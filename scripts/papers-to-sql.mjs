#!/usr/bin/env node
// Validates written exam-style practice papers (JSON) and turns them into one reviewable SQL file.
//
// Usage: node scripts/papers-to-sql.mjs content/papers-myp5 > papers.sql
// Each *.json is an array of:
//   { "subject": "biology", "grade": 5, "title": "...", "criterion": null,
//     "questions": [{ "position": 1, "content": "...", "marks": 6, "criterion": "A", "mark_scheme": "..." }] }
// Written questions store options = [] and answer = 0 (the schema allows an empty options array).
// Mark schemes must show each mark as "[1]" so the AI marker can count them; the total must equal `marks`.
import { readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";

const dir = process.argv[2];
if (!dir) { console.error("Usage: node scripts/papers-to-sql.mjs <folder>"); process.exit(1); }

const BAD_SCOPE = /\bA[- ]level\b|Diploma Programme|\bIB DP\b|\bHL\b|\bSL\b/;
const BAD_SCALE = /\b(1\s*(?:-|to|–)\s*7)\b|\bout of 7\b/i;

function validate(p) {
  const errs = [];
  const qs = p.questions ?? [];
  if (!p.title?.trim()) errs.push("missing title");
  const full = p.format === "full-mock";
  if (qs.length < 5 || qs.length > 10) errs.push(`expected 5-10 questions, got ${qs.length}`);
  let total = 0;
  qs.forEach((q, i) => {
    const tag = `q${i + 1}`;
    if (q.position !== i + 1) errs.push(`${tag}: position should be ${i + 1}`);
    if (!q.content?.trim() || q.content.length < 60) errs.push(`${tag}: content too short`);
    const maxQ = full ? 40 : 12;
    if (!Number.isInteger(q.marks) || q.marks < 1 || q.marks > maxQ) errs.push(`${tag}: marks must be 1-${maxQ}`);
    if (!/\(\s*\d+\s*marks?\s*\)/i.test(q.content ?? "")) errs.push(`${tag}: content should show marks like "(4 marks)"`);
    const awards = (q.mark_scheme ?? "").match(/\[(\d+)\]/g) ?? [];
    const sum = awards.reduce((t, a) => t + Number(a.slice(1, -1)), 0);
    if (sum !== q.marks) errs.push(`${tag}: mark scheme [n] marks sum to ${sum}, question marks ${q.marks}`);
    if (!/^[A-D]$/.test(q.criterion ?? "")) errs.push(`${tag}: criterion must be A-D`);
    total += q.marks ?? 0;
  });
  if (full ? total < 90 || total > 130 : total < 30 || total > 60)
    errs.push(`total marks ${total} (want ${full ? "90-130" : "30-60"})`);
  const all = JSON.stringify(p);
  if (BAD_SCOPE.test(all)) errs.push("mentions Diploma/A-level scope");
  if (BAD_SCALE.test(all)) errs.push("mentions a 1-7 scale inside the paper");
  if (all.includes("$mq$")) errs.push("contains the SQL quote tag");
  return { errs, total };
}

const d = (s) => `$mq$${String(s).trim()}$mq$`;
const files = readdirSync(dir).filter((f) => f.endsWith(".json")).sort();
const items = files.flatMap((f) => JSON.parse(readFileSync(join(dir, f), "utf8")).map((x) => ({ ...x, _file: f })));
let bad = 0;
for (const p of items) {
  const { errs, total } = validate(p);
  p._total = total;
  if (errs.length) { bad++; console.error(`INVALID ${p._file} > ${p.title}: ${errs.join("; ")}`); }
}
if (bad) { console.error(`${bad} paper(s) failed validation; no SQL written.`); process.exit(1); }

const out = [`-- ${items.length} papers. Safe to re-run: a paper with the same subject, grade and title is skipped.`, "begin;"];
for (const p of items) {
  out.push(`\n-- ${p.title} (${p._total} marks)`);
  out.push(`with sub as (select id from public.subjects where slug = ${d(p.subject)}),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, ${d(p.title)}, ${Number(p.grade)}, ${p.criterion ? d(p.criterion) : "null"}, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = ${Number(p.grade)} and x.title = ${d(p.title)})
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
${p.questions.map((q) => `(${q.position}, ${d(q.content)}, ${d(q.mark_scheme)}, ${d(q.criterion)})`).join(",\n")}
) as v(position, content, mark_scheme, criterion);`);
}
out.push("\ncommit;", `
select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;`);
console.log(out.join("\n"));
