#!/usr/bin/env node
// Compares content/outlines/<subject>.json with the JSON written in content/<subject>-myp5 and reports missing sub-topics.
// Usage: node scripts/check-coverage.mjs <subject-slug>
import { readdirSync, readFileSync, existsSync } from "node:fs";
import { join } from "node:path";
const slug = process.argv[2];
const outline = JSON.parse(readFileSync(`content/outlines/${slug}.json`, "utf8"));
const dir = `content/${slug}-myp5`;
const have = new Set();
if (existsSync(dir)) {
  for (const f of readdirSync(dir).filter((x) => x.endsWith(".json"))) {
    for (const c of JSON.parse(readFileSync(join(dir, f), "utf8"))) have.add(`${c.topic}|${c.subTopic}`);
  }
}
let missing = 0, total = 0;
for (const t of outline) for (const s of t.subTopics) {
  total++;
  if (!have.has(`${t.topic}|${s}`)) { missing++; console.log(`MISSING ${t.topic} > ${s}`); }
}
console.log(`${slug}: ${total - missing}/${total} sub-topics written`);
