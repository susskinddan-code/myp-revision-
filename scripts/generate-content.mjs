#!/usr/bin/env node
// Generates MYP content (18 MCQs + 1 study note + 9 flashcards) for every sub-topic of a subject/grade
// that has no study note yet, validates it, and loads it into Supabase.
//
// Usage:  node scripts/generate-content.mjs --subject biology --grade 5 [--limit 3] [--dry-run]
// Env:    ANTHROPIC_API_KEY, SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY   (never commit these)
// Dry run writes JSON to scripts/out/ and touches nothing in the database.
import { mkdirSync, writeFileSync } from "node:fs";

const args = Object.fromEntries(
  process.argv.slice(2).reduce((acc, a, i, all) => {
    if (a.startsWith("--")) acc.push([a.slice(2), all[i + 1] && !all[i + 1].startsWith("--") ? all[i + 1] : true]);
    return acc;
  }, []),
);
const SUBJECT = args.subject ?? "biology";
const GRADE = Number(args.grade ?? 5);
const LIMIT = args.limit ? Number(args.limit) : Infinity;
const DRY = Boolean(args["dry-run"]);
const MODEL = "claude-sonnet-4-5";

const need = (k) => {
  const v = process.env[k];
  if (!v) { console.error(`Missing env var ${k}`); process.exit(1); }
  return v;
};
const ANTHROPIC_API_KEY = need("ANTHROPIC_API_KEY");
const SUPABASE_URL = need("SUPABASE_URL").replace(/\/$/, "");
const SERVICE_KEY = need("SUPABASE_SERVICE_ROLE_KEY");

const sb = async (path, init = {}) => {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/${path}`, {
    ...init,
    headers: { apikey: SERVICE_KEY, Authorization: `Bearer ${SERVICE_KEY}`, "Content-Type": "application/json", Prefer: "return=representation", ...init.headers },
  });
  if (!res.ok) throw new Error(`Supabase ${res.status} on ${path}: ${await res.text()}`);
  return res.status === 204 ? null : res.json();
};

const SCHEMA = {
  type: "object",
  required: ["questions", "note", "flashcards"],
  properties: {
    questions: {
      type: "array",
      items: {
        type: "object",
        required: ["content", "options", "answer", "explanation", "difficulty"],
        properties: {
          content: { type: "string" },
          options: { type: "array", items: { type: "string" }, minItems: 4, maxItems: 4 },
          answer: { type: "integer", minimum: 0, maximum: 3, description: "Zero-based index of the correct option" },
          explanation: { type: "string" },
          difficulty: { type: "string", enum: ["easy", "medium", "hard"] },
        },
      },
    },
    note: { type: "string", description: "Study note, at least 450 words, plain text with short paragraphs" },
    flashcards: {
      type: "array",
      items: { type: "object", required: ["front", "back"], properties: { front: { type: "string" }, back: { type: "string" } } },
    },
  },
};

function buildPrompt(subject, parent, sub) {
  return [
    `You are writing revision content for the IB Middle Years Programme (MYP), Year ${GRADE} (school Grade ${GRADE + 5}).`,
    `Subject: ${subject}. Topic: ${parent}. Sub-topic: ${sub}.`,
    `Rules: MYP content only, never Diploma Programme or A-level material. MYP criterion achievement is Levels 1-8 (never 1-7). Do not mention grade scales unless essential.`,
    `Produce exactly: 18 multiple-choice questions (5 easy, 8 medium, 5 hard), each with 4 distinct options, a zero-based correct index, and a one-to-two sentence explanation; spread the correct answer across all four positions; no "all of the above".`,
    `One study note of at least 450 words covering the sub-topic with clear headings-as-sentences and worked examples where relevant.`,
    `Exactly 9 flashcards: short front (term or question), concise back (under 300 characters).`,
    `Be factually precise. Return the result through the tool.`,
  ].join("\n");
}

async function generate(subject, parent, sub) {
  const res = await fetch("https://api.anthropic.com/v1/messages", {
    method: "POST",
    headers: { "content-type": "application/json", "x-api-key": ANTHROPIC_API_KEY, "anthropic-version": "2023-06-01" },
    body: JSON.stringify({
      model: MODEL,
      max_tokens: 16000,
      messages: [{ role: "user", content: buildPrompt(subject, parent, sub) }],
      tools: [{ name: "submit_content", description: "Submit the generated revision content.", input_schema: SCHEMA }],
      tool_choice: { type: "tool", name: "submit_content" },
    }),
  });
  if (!res.ok) throw new Error(`Anthropic ${res.status}: ${await res.text()}`);
  const json = await res.json();
  const block = (json.content ?? []).find((b) => b.type === "tool_use");
  if (!block) throw new Error("No tool output returned");
  return block.input;
}

const BAD_SCOPE = /\bA[- ]level\b|Diploma Programme|\bIB DP\b|\bHL\b/i;
const BAD_SCALE = /\b(1\s*(?:-|to|–)\s*7)\b|\bout of 7\b/i;

function validate(c) {
  const errs = [];
  const q = c.questions ?? [];
  if (q.length !== 18) errs.push(`expected 18 questions, got ${q.length}`);
  const counts = { easy: 0, medium: 0, hard: 0 };
  q.forEach((x, i) => {
    counts[x.difficulty] = (counts[x.difficulty] ?? 0) + 1;
    const opts = x.options ?? [];
    if (!x.content?.trim()) errs.push(`q${i + 1}: empty question`);
    if (opts.length !== 4 || opts.some((o) => !String(o).trim())) errs.push(`q${i + 1}: needs 4 non-empty options`);
    if (new Set(opts.map((o) => String(o).trim().toLowerCase())).size !== opts.length) errs.push(`q${i + 1}: duplicate options`);
    if (!Number.isInteger(x.answer) || x.answer < 0 || x.answer > 3) errs.push(`q${i + 1}: answer index invalid`);
    if (!x.explanation?.trim()) errs.push(`q${i + 1}: missing explanation`);
  });
  if (counts.easy !== 5 || counts.medium !== 8 || counts.hard !== 5) errs.push(`difficulty split ${JSON.stringify(counts)} (want 5/8/5)`);
  const words = (c.note ?? "").trim().split(/\s+/).filter(Boolean).length;
  if (words < 450) errs.push(`note only ${words} words`);
  const f = c.flashcards ?? [];
  if (f.length !== 9) errs.push(`expected 9 flashcards, got ${f.length}`);
  f.forEach((x, i) => {
    if (!x.front?.trim() || !x.back?.trim()) errs.push(`flashcard ${i + 1}: empty side`);
    else if (x.back.length > 400) errs.push(`flashcard ${i + 1}: back too long (note text leaking into flashcard?)`);
  });
  const all = JSON.stringify(c);
  if (BAD_SCOPE.test(all)) errs.push("mentions Diploma/A-level scope");
  if (BAD_SCALE.test(all)) errs.push("mentions a 1-7 scale");
  return errs;
}

async function main() {
  const [subj] = await sb(`subjects?slug=eq.${encodeURIComponent(SUBJECT)}&select=id,name`);
  if (!subj) throw new Error(`Subject ${SUBJECT} not found`);
  const topics = await sb(`topics?subject_id=eq.${subj.id}&grade=eq.${GRADE}&select=id,name,parent_topic_id,position&order=position`);
  const byId = new Map(topics.map((t) => [t.id, t]));
  const subs = topics.filter((t) => t.parent_topic_id);
  const notes = await sb(`notes?topic_id=in.(${subs.map((s) => s.id).join(",") || "00000000-0000-0000-0000-000000000000"})&select=topic_id`);
  const done = new Set(notes.map((n) => n.topic_id));
  const todo = subs.filter((s) => !done.has(s.id)).slice(0, LIMIT);
  console.log(`${subj.name} MYP ${GRADE}: ${subs.length} sub-topics, ${done.size} done, generating ${todo.length}${DRY ? " (dry run)" : ""}`);
  if (DRY) mkdirSync("scripts/out", { recursive: true });

  for (const [n, s] of todo.entries()) {
    const parent = byId.get(s.parent_topic_id)?.name ?? "";
    process.stdout.write(`[${n + 1}/${todo.length}] ${parent} > ${s.name} ... `);
    let content, errs;
    for (let attempt = 1; attempt <= 3; attempt++) {
      try { content = await generate(subj.name, parent, s.name); errs = validate(content); } catch (e) { errs = [String(e.message)]; }
      if (!errs.length) break;
      process.stdout.write(`(retry ${attempt}: ${errs[0]}) `);
    }
    if (errs.length) { console.log(`SKIPPED — ${errs.join("; ")}`); continue; }
    if (DRY) { writeFileSync(`scripts/out/${s.id}.json`, JSON.stringify({ subTopic: s.name, ...content }, null, 2)); console.log("ok (saved)"); continue; }
    // Questions and flashcards first; the note goes last because its existence marks the sub-topic as done.
    await sb("questions", { method: "POST", body: JSON.stringify(content.questions.map((x) => ({
      subject_id: subj.id, topic_id: s.id, grade: GRADE, type: "MCQ", content: x.content.trim(),
      options: x.options.map((o) => o.trim()), answer: x.answer, explanation: x.explanation.trim(), difficulty: x.difficulty,
    }))) });
    await sb("flashcards", { method: "POST", body: JSON.stringify(content.flashcards.map((x) => ({
      subject_id: subj.id, topic_id: s.id, grade: GRADE, front: x.front.trim(), back: x.back.trim(),
    }))) });
    await sb("notes", { method: "POST", body: JSON.stringify({ topic_id: s.id, content: content.note.trim() }) });
    console.log("loaded");
  }
}
main().catch((e) => { console.error(e); process.exit(1); });
