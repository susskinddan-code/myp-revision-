#!/usr/bin/env node
// Validates hand-written/generated content JSON and turns it into one reviewable SQL file.
//
// Usage: node scripts/json-to-sql.mjs content/biology-myp5 > out.sql
//   Each *.json in the folder is an array of:
//   { "subject": "biology", "grade": 5, "topic": "Microbiology", "subTopic": "Microorganism Types and Growth",
//     "questions": [{content, options[4], answer(0-3), explanation, difficulty}], "note": "...", "flashcards": [{front, back}] }
// The SQL looks sub-topics up by name, skips any sub-topic that already has a note, and runs in one transaction.
import { readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";

const dir = process.argv[2];
if (!dir) { console.error("Usage: node scripts/json-to-sql.mjs <content-folder>"); process.exit(1); }

const BAD_SCOPE = /\bA[- ]level\b|Diploma Programme|\bIB DP\b|\bHL\b/i;
const BAD_SCALE = /\b(1\s*(?:-|to|–)\s*7)\b|\bout of 7\b/i;

function validate(c) {
  const errs = [];
  const q = c.questions ?? [];
  if (q.length !== 18) errs.push(`expected 18 questions, got ${q.length}`);
  const counts = { easy: 0, medium: 0, hard: 0 };
  const answers = [0, 0, 0, 0];
  q.forEach((x, i) => {
    counts[x.difficulty] = (counts[x.difficulty] ?? 0) + 1;
    const opts = x.options ?? [];
    if (!x.content?.trim()) errs.push(`q${i + 1}: empty question`);
    if (opts.length !== 4 || opts.some((o) => !String(o).trim())) errs.push(`q${i + 1}: needs 4 non-empty options`);
    if (new Set(opts.map((o) => String(o).trim().toLowerCase())).size !== opts.length) errs.push(`q${i + 1}: duplicate options`);
    if (!Number.isInteger(x.answer) || x.answer < 0 || x.answer > 3) errs.push(`q${i + 1}: answer index invalid`);
    else answers[x.answer]++;
    if (!x.explanation?.trim()) errs.push(`q${i + 1}: missing explanation`);
    if (/all of the above|none of the above/i.test(opts.join(" "))) errs.push(`q${i + 1}: uses all/none of the above`);
  });
  if (counts.easy !== 5 || counts.medium !== 8 || counts.hard !== 5) errs.push(`difficulty split ${JSON.stringify(counts)} (want 5/8/5)`);
  if (Math.max(...answers) > 7 || Math.min(...answers) < 2) errs.push(`answer positions lopsided ${answers}`);
  const words = (c.note ?? "").trim().split(/\s+/).filter(Boolean).length;
  if (words < 450) errs.push(`note only ${words} words`);
  const f = c.flashcards ?? [];
  if (f.length !== 9) errs.push(`expected 9 flashcards, got ${f.length}`);
  f.forEach((x, i) => {
    if (!x.front?.trim() || !x.back?.trim()) errs.push(`flashcard ${i + 1}: empty side`);
    else if (x.back.length > 300) errs.push(`flashcard ${i + 1}: back too long`);
  });
  const all = JSON.stringify(c);
  if (BAD_SCOPE.test(all)) errs.push("mentions Diploma/A-level scope");
  if (BAD_SCALE.test(all)) errs.push("mentions a 1-7 scale");
  if (all.includes("$mq$")) errs.push("contains the SQL quote tag");
  return errs;
}

const d = (s) => `$mq$${String(s).trim()}$mq$`;
const files = readdirSync(dir).filter((f) => f.endsWith(".json")).sort();
const items = files.flatMap((f) => JSON.parse(readFileSync(join(dir, f), "utf8")).map((x) => ({ ...x, _file: f })));
// Spread the correct answer evenly over the four positions (deterministic), keeping the other options in order.
for (const c of items) {
  c.questions.forEach((x, i) => {
    if (!Array.isArray(x.options) || x.options.length !== 4 || !Number.isInteger(x.answer) || x.answer < 0 || x.answer > 3) return;
    const target = (i * 3) % 4;
    const correct = x.options[x.answer];
    const rest = x.options.filter((_, k) => k !== x.answer);
    rest.splice(target, 0, correct);
    x.options = rest;
    x.answer = target;
  });
}
let bad = 0;
for (const c of items) {
  const errs = validate(c);
  if (errs.length) { bad++; console.error(`INVALID ${c._file} > ${c.subTopic}: ${errs.join("; ")}`); }
}
if (bad) { console.error(`${bad} sub-topic(s) failed validation; no SQL written.`); process.exit(1); }

const out = [`-- ${items.length} sub-topics. Safe to re-run: sub-topics that already have a note are skipped.`, "begin;"];
for (const c of items) {
  const st = `select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = ${d(c.subject)} and t.grade = ${Number(c.grade)} and t.name = ${d(c.subTopic)} and p.name = ${d(c.topic)}
      and not exists (select 1 from public.notes n where n.topic_id = t.id)`;
  out.push(`\n-- ${c.topic} > ${c.subTopic}`);
  out.push(`with st as (${st})
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, ${Number(c.grade)}, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
${c.questions.map((x) => `(${d(x.content)}, ${d(JSON.stringify(x.options.map((o) => String(o).trim())))}, ${x.answer}, ${d(x.explanation)}, ${d(x.difficulty)})`).join(",\n")}
) as v(content, options, answer, explanation, difficulty);`);
  out.push(`with st as (${st})
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, ${Number(c.grade)}, v.front, v.back
from st, (values
${c.flashcards.map((x) => `(${d(x.front)}, ${d(x.back)})`).join(",\n")}
) as v(front, back);`);
  out.push(`with st as (${st})
insert into public.notes (topic_id, content) select st.topic_id, ${d(c.note)} from st;`);
}
out.push("\ncommit;", `
select p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug = 'biology'
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 group by p.name order by p.name;`);
console.log(out.join("\n"));
