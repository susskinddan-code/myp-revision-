#!/usr/bin/env node
// Checks every stored practice-paper task fits the server's marking caps (src/lib/ai-core.server.ts).
// Usage: node scripts/check-paper-sizes.mjs   (exits 1 if anything is over)
import { readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";

const src = readFileSync("src/lib/ai-core.server.ts", "utf8");
const cap = (name) =>
  Number(new RegExp(`${name}\\s*=\\s*([\\d_]+)`).exec(src)?.[1]?.replace(/_/g, ""));
const MAX_Q = cap("MAX_QUESTION_CHARS");
const MAX_S = cap("MAX_SCHEME_CHARS");
if (!MAX_Q || !MAX_S) {
  console.error("could not read caps");
  process.exit(2);
}

let over = 0,
  tasks = 0,
  maxQ = 0,
  maxS = 0;
for (const dir of ["content/papers-myp5", "content/papers-widgets"]) {
  for (const f of readdirSync(dir).filter((x) => x.endsWith(".json"))) {
    for (const p of JSON.parse(readFileSync(join(dir, f), "utf8"))) {
      for (const q of p.questions ?? []) {
        tasks++;
        const ql = (q.content ?? "").length,
          sl = (q.mark_scheme ?? "").length;
        maxQ = Math.max(maxQ, ql);
        maxS = Math.max(maxS, sl);
        if (ql > MAX_Q || sl > MAX_S) {
          over++;
          console.log(
            `OVER ${f} "${p.title}" q${q.position}: content ${ql}/${MAX_Q}, scheme ${sl}/${MAX_S}`,
          );
        }
      }
    }
  }
}
console.log(
  `${tasks} tasks; longest content ${maxQ}/${MAX_Q}, longest scheme ${maxS}/${MAX_S}; ${over} over`,
);
process.exit(over ? 1 : 0);
