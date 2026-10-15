#!/usr/bin/env node
// Validates the interactive-widget papers: widget markup (same rules as src/lib/task-markup.ts),
// unique widget ids per task, mark-scheme [n] sums, criterion, header and "(n marks)" parts.
// Usage: node scripts/validate-widget-papers.mjs [folder]   (default content/papers-widgets)
import { readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";

const dir = process.argv[2] ?? "content/papers-widgets";
const list = (s) => (s ?? "").split(",").map((x) => x.trim()).filter(Boolean);

// Mirror of parseWidget in src/lib/task-markup.ts. Returns { kind, id } or null when malformed.
function parseWidget(raw) {
  const p = raw.split("|").map((x) => x.trim());
  const kind = p[0]?.toLowerCase();
  const id = p[1] ?? "";
  if (kind === "select") return id && p.slice(2).filter(Boolean).length >= 2 ? { kind, id } : null;
  if (kind === "drag") return id && list(p[2]).length >= 2 && list(p[3]).length >= 2
    ? { kind, id, slots: list(p[2]).length, items: list(p[3]).length } : null;
  if (kind === "plot") {
    const b = list(p[2]).map(Number);
    if (!id || b.length !== 4 || b.some((n) => !Number.isFinite(n))) return null;
    const [x0, x1, y0, y1] = b;
    return x1 <= x0 || y1 <= y0 || x1 - x0 > 40 || y1 - y0 > 40 ? null : { kind, id };
  }
  if (kind === "fill") {
    const rows = Number(p[3]);
    return id && list(p[2]).length >= 1 && rows >= 1 && rows <= 12 ? { kind, id, cols: list(p[2]).length, rows } : null;
  }
  if (kind === "chart") {
    if (!["bar", "line", "pie"].includes(p[1])) return null;
    const data = list(p[5]).map((x) => { const i = x.lastIndexOf(":"); return { l: x.slice(0, i).trim(), v: Number(x.slice(i + 1)) }; })
      .filter((d) => d.l && Number.isFinite(d.v));
    return data.length >= 2 ? { kind, id: "" } : null;
  }
  return null;
}

let bad = 0, papers = 0;
for (const f of readdirSync(dir).filter((x) => x.endsWith(".json")).sort()) {
  for (const p of JSON.parse(readFileSync(join(dir, f), "utf8"))) {
    papers++;
    const errs = [];
    const kinds = new Set();
    let total = 0;
    const qs = p.questions ?? [];
    if (qs.length < 3 || qs.length > 4) errs.push(`want 3-4 tasks, got ${qs.length}`);
    qs.forEach((q, i) => {
      const t = `q${i + 1}`;
      total += q.marks;
      const sum = [...(q.mark_scheme ?? "").matchAll(/\[(\d+)\]/g)].reduce((a, m) => a + Number(m[1]), 0);
      if (sum !== q.marks) errs.push(`${t}: mark scheme sums to ${sum}, marks ${q.marks}`);
      if (!/^[A-D]$/.test(q.criterion)) errs.push(`${t}: bad criterion`);
      if (q.position !== i + 1) errs.push(`${t}: bad position`);
      const head = q.content.match(/^\[\[Q (\d+) \| ([^\]]+)\]\]/);
      if (!head || Number(head[1]) !== i + 1) errs.push(`${t}: bad header`);
      else {
        const hs = [...head[2].matchAll(/[A-D] (\d+)/g)].reduce((a, m) => a + Number(m[1]), 0);
        if (hs !== q.marks) errs.push(`${t}: header criterion marks ${hs} != ${q.marks}`);
      }
      if (!new RegExp(`Total for Question ${i + 1}: ${q.marks} marks`).test(q.content)) errs.push(`${t}: missing/wrong total line`);
      // part marks "(n marks)" must add up to the task marks
      const parts = [...q.content.matchAll(/\((\d+) marks?\)/g)].reduce((a, m) => a + Number(m[1]), 0);
      if (parts !== q.marks) errs.push(`${t}: part marks ${parts} != ${q.marks}`);
      // widgets
      const ids = [];
      for (const m of q.content.matchAll(/\{\{([^{}]*)\}\}/g)) {
        const w = parseWidget(m[1]);
        if (!w) { errs.push(`${t}: malformed widget ${m[0]}`); continue; }
        kinds.add(w.kind);
        if (w.kind !== "chart") {
          ids.push(w.id);
          if (!q.mark_scheme.includes(`[${w.id}]`)) errs.push(`${t}: mark scheme does not mention [${w.id}]`);
          if (w.kind === "drag" && w.items < w.slots) errs.push(`${t}: drag ${w.id} has fewer items than slots`);
        }
      }
      if (/\{\{|\}\}/.test(q.content.replace(/\{\{[^{}]*\}\}/g, ""))) errs.push(`${t}: stray braces`);
      if (new Set(ids).size !== ids.length) errs.push(`${t}: duplicate widget ids ${ids.join(",")}`);
    });
    if (kinds.size < 3) errs.push(`only ${kinds.size} widget types (${[...kinds]})`);
    if (total < 25 || total > 30) errs.push(`total ${total} outside 25-30`);
    if (!p.title.endsWith(`(${qs.length} tasks, ${total} marks)`)) errs.push(`title does not end with (${qs.length} tasks, ${total} marks)`);
    if (/\b(1\s*(?:-|to|–)\s*7)\b|\bout of 7\b|Diploma Programme|A[- ]level|\bHL\b|\bSL\b|\$mq\$/i.test(JSON.stringify(p))) errs.push("banned scale/scope text");
    console.log(`${errs.length ? "INVALID" : "ok"}  ${f}  ${total} marks  widgets: ${[...kinds].join(",")}`);
    if (errs.length) { bad++; errs.forEach((e) => console.log("   - " + e)); }
  }
}
console.log(bad ? `${bad} of ${papers} failed` : `all ${papers} papers valid`);
process.exit(bad ? 1 : 0);
