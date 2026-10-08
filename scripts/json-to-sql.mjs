#!/usr/bin/env node
// Validates hand-written/generated content JSON and turns it into one reviewable SQL file.
//
// Usage: node scripts/json-to-sql.mjs content/biology-myp5 > out.sql
//   Each *.json in the folder is an array of:
//   { "subject": "biology", "grade": 5, "topic": "Microbiology", "subTopic": "Microorganism Types and Growth",
//     "questions": [{content, options[4], answer(0-3), explanation, difficulty}], "note": "...", "flashcards": [{front, back}] }
// The SQL looks sub-topics up by name, skips any sub-topic that already has a note, and runs in one transaction.
import { readdirSync, readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { join } from "node:path";

const args = process.argv.slice(2);
const dir = args[0];
if (!dir) { console.error("Usage: node scripts/json-to-sql.mjs <content-folder> [--out <folder> --chunk <n>]"); process.exit(1); }
const flag = (name) => { const i = args.indexOf(name); return i >= 0 ? args[i + 1] : null; };
const outDir = flag("--out");
const chunkSize = Number(flag("--chunk") ?? 0);

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
// Positions for topics/sub-topics created by this file (order of first appearance).
const parentPos = new Map();
const subPos = new Map();
for (const c of items) {
  const pk = `${c.subject}|${c.grade}|${c.topic}`;
  if (!parentPos.has(pk)) parentPos.set(pk, c.parentPosition ?? parentPos.size + 1);
  const n = (subPos.get(pk) ?? 0) + 1;
  subPos.set(pk, n);
  c._sub = c.position ?? n;
  c._parent = parentPos.get(pk);
}
let bad = 0;
for (const c of items) {
  const errs = validate(c);
  if (errs.length) { bad++; console.error(`INVALID ${c._file} > ${c.subTopic}: ${errs.join("; ")}`); }
}
if (bad) { console.error(`${bad} sub-topic(s) failed validation; no SQL written.`); process.exit(1); }

const blocks = [];
for (const c of items) {
  const out = [];
  const st = `select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = ${d(c.subject)} and t.grade = ${Number(c.grade)} and t.name = ${d(c.subTopic)} and p.name = ${d(c.topic)}
      and not exists (select 1 from public.notes n where n.topic_id = t.id)`;
  out.push(`\n-- ${c.topic} > ${c.subTopic}`);
  // Create the topic and sub-topic if they do not exist yet (names are unique per subject and grade).
  out.push(`insert into public.topics (subject_id, name, grade, position)
select s.id, ${d(c.topic)}, ${Number(c.grade)}, ${Number(c._parent)} from public.subjects s where s.slug = ${d(c.subject)}
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, ${d(c.subTopic)}, ${Number(c.grade)}, p.id, ${Number(c._sub)}
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = ${d(c.subject)} and p.grade = ${Number(c.grade)} and p.name = ${d(c.topic)} and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;`);
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
  blocks.push(out.join("\n"));
}
const slugs = [...new Set(items.map((i) => `'${i.subject}'`))].join(", ");
const summary = `
select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in (${slugs})
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;`;
const wrap = (list, label) =>
  [`-- ${label}: ${list.length} sub-topics. Safe to re-run: sub-topics that already have a note are skipped.`, "begin;", ...list, "\ncommit;", summary].join("\n");
if (outDir && chunkSize > 0) {
  mkdirSync(outDir, { recursive: true });
  const parts = Math.ceil(blocks.length / chunkSize);
  for (let i = 0; i < parts; i++) {
    const name = `part-${String(i + 1).padStart(2, "0")}-of-${String(parts).padStart(2, "0")}.sql`;
    writeFileSync(join(outDir, name), wrap(blocks.slice(i * chunkSize, (i + 1) * chunkSize), `Part ${i + 1} of ${parts}`));
    console.error(`wrote ${join(outDir, name)}`);
  }
} else {
  console.log(wrap(blocks, `${items.length} sub-topics`));
}
