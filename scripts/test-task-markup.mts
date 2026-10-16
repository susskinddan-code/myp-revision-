// Run: npx tsx scripts/test-task-markup.mts   (or: node --experimental-strip-types scripts/test-task-markup.mts)
import assert from "node:assert/strict";
import {
  decodeDragAnswer,
  decodeFillAnswer,
  decodePlotAnswer,
  encodeDragAnswer,
  encodeFillAnswer,
  encodePlotAnswer,
  formatNumber,
  niceScale,
  parseTaskBody,
  truncateLabel,
  wrapLabel,
  widgetIds,
} from "../src/lib/task-markup.ts";

let passed = 0;
const ok = (name: string, text: string, check?: (r: ReturnType<typeof parseTaskBody>) => void) => {
  const r = parseTaskBody(text);
  assert.deepEqual(r.errors, [], `${name}: expected no errors, got ${JSON.stringify(r.errors)}`);
  check?.(r);
  passed++;
};
const bad = (name: string, text: string) => {
  const r = parseTaskBody(text);
  assert.ok(r.errors.length > 0, `${name}: expected an error for ${text}`);
  passed++;
};

// --- well-formed markup still works
ok("select", "Pick {{select|a|x|y|z}} now", (r) => {
  const w = r.segments.find((s) => s.type === "widget");
  assert.equal(w?.type === "widget" && w.widget.kind, "select");
});
ok("drag", "{{drag|d1|Slot A,Slot B|one,two,three}}");
ok("plot", "{{plot|p1|0,10,0,5|Time|Distance}}");
ok("fill", "{{fill|f1|A,B,C|3}}");
ok("chart bar", "{{chart|bar|T|x|y|A:3,B:5,C:2}}");
ok("chart bar negative", "{{chart|bar|T|x|y|A:-3,B:5}}");
ok("chart line negative", "{{chart|line|T|x|y|A:-3,B:-5}}");
ok("chart all zero bar", "{{chart|bar|T|x|y|A:0,B:0}}");
ok("chart duplicate labels parse", "{{chart|bar|T|x|y|A:1,A:2}}");
ok("pie 100% single slice", "{{chart|pie|T|x|y|A:10,B:0}}");
ok("id with dash/underscore", "{{select|a_b-9|x|y}}");
ok("two distinct ids", "{{select|a|x|y}} {{select|b|x|y}}");
ok("fill 8 cols", "{{fill|f|1,2,3,4,5,6,7,8|2}}");
ok("plain braces in text are not widgets", "A set is {1, 2}.");

// --- uppercase kinds are normalised to lower case
ok("uppercase kind", "{{SELECT|a|x|y}}", (r) => {
  const w = r.segments[0];
  assert.ok(w?.type === "widget" && w.widget.kind === "select");
});
ok("uppercase chart type", "{{CHART|PIE|T|x|y|A:1,B:2}}", (r) => {
  const w = r.segments[0];
  assert.ok(w?.type === "widget" && w.widget.kind === "chart" && w.widget.type === "pie");
});

// --- rejected markup
bad("triple braces", "{{{select|a|x|y}}}");
bad("triple open only", "{{{select|a|x|y}}");
bad("unbalanced", "{{select|a|x|y}");
bad("nested", "{{select|a|{{x}}|y}}");
bad("empty id", "{{select||x|y}}");
bad("one option", "{{select|a|x}}");
bad("duplicate select options", "{{select|a|x|y|x}}");
bad("duplicate drag items", "{{drag|d|A,B|one,one,two}}");
bad("duplicate drag slots", "{{drag|d|A,A|one,two,three}}");
bad("fewer items than slots", "{{drag|d|A,B,C|one,two}}");
bad("duplicate ids in one task", "{{select|a|x|y}} {{fill|a|A|2}}");
bad("duplicate ids differing in case", "{{select|ab|x|y}} {{select|AB|x|y}}");
bad("id with space", "{{select|a b|x|y}}");
bad("id with symbol", "{{select|a.b|x|y}}");
bad("id too long", `{{select|${"a".repeat(21)}|x|y}}`);
bad("chart value empty 'A:'", "{{chart|bar|T|x|y|A:,B:2}}");
bad("chart value empty trailing", "{{chart|bar|T|x|y|A:1,B:}}");
bad("chart value NaN", "{{chart|bar|T|x|y|A:x,B:2}}");
bad("chart no colon", "{{chart|bar|T|x|y|A,B}}");
bad("chart one point", "{{chart|bar|T|x|y|A:1}}");
bad("chart bad type", "{{chart|donut|T|x|y|A:1,B:2}}");
bad("pie negative", "{{chart|pie|T|x|y|A:5,B:-1}}");
bad("pie all zero", "{{chart|pie|T|x|y|A:0,B:0}}");
const many = Array.from({ length: 25 }, (_, i) => `L${i}:1`).join(",");
bad("chart too many points", "{{chart|bar|T|x|y|" + many + "}}");
bad("plot range under 1 unit", "{{plot|p|0,0.001,0,5|x|y}}");
bad("plot zero x range", "{{plot|p|3,3,0,5|x|y}}");
bad("plot inverted x", "{{plot|p|10,0,0,5|x|y}}");
bad("plot inverted y", "{{plot|p|0,10,5,0|x|y}}");
bad("plot fractional bounds", "{{plot|p|0,10.5,0,5|x|y}}");
bad("plot too large", "{{plot|p|0,41,0,5|x|y}}");
bad("plot NaN", "{{plot|p|0,a,0,5|x|y}}");
bad("plot Infinity", "{{plot|p|0,Infinity,0,5|x|y}}");
bad("plot wrong count", "{{plot|p|0,10,0|x|y}}");
bad("fill fractional rows", "{{fill|f|A,B|2.5}}");
bad("fill rows zero", "{{fill|f|A,B|0}}");
bad("fill rows too many", "{{fill|f|A,B|13}}");
bad("fill 9 columns", "{{fill|f|1,2,3,4,5,6,7,8,9|2}}");
bad("fill no columns", "{{fill|f||2}}");
bad("unknown kind", "{{video|v|x}}");

// --- L9: duplicate ids get a unique suffix (and are still reported)
{
  const r = parseTaskBody("{{select|a|x|y}} {{select|a|x|y}} {{fill|a|A|2}} {{select|a-2|x|y}}");
  assert.ok(r.errors.length >= 3);
  const ids = widgetIds("{{select|a|x|y}} {{select|a|x|y}} {{fill|a|A|2}}");
  assert.deepEqual(ids, ["a", "a-2", "a-3"]);
  passed++;
}

// --- L9: fill-table encoding is unambiguous
{
  const cols = ["X", "Y"];
  assert.equal(
    encodeFillAnswer(cols, [
      ["", " "],
      ["  ", ""],
    ]),
    "",
    "whitespace-only is unanswered",
  );
  assert.equal(
    encodeFillAnswer(cols, [
      ["1", ""],
      ["", ""],
    ]),
    "table (X | Y): 1 | - / - | -",
  );
  assert.equal(
    encodeFillAnswer(cols, [
      ["a | b", "c / d"],
      ["-", " ok "],
    ]),
    'table (X | Y): "a | b" | "c / d" / "-" | ok',
  );
  assert.equal(encodeFillAnswer(["A | B"], [["x"]]), 'table ("A | B"): x');
  passed += 4;
}

// --- L1: chart scale helpers
{
  const s = niceScale([-3, 5]);
  assert.ok(s.lo <= -3 && s.hi >= 5 && s.ticks.includes(0));
  const tiny = niceScale([0.0001, 0.0002]);
  assert.ok(tiny.hi >= 0.0002 && tiny.hi <= 0.0003, `tiny hi ${tiny.hi}`);
  const neg = niceScale([-5, -2]);
  assert.equal(neg.hi, 0);
  assert.equal(niceScale([0, 0]).hi, 1);
  const big = niceScale([1200000, 3400000]);
  assert.ok(big.hi >= 3400000 && big.hi <= 4000000);
  assert.equal(formatNumber(1234567), "1.2M");
  assert.equal(formatNumber(0.00020000000001), "0.0002");
  assert.equal(truncateLabel("short"), "short");
  assert.equal(truncateLabel("a very long axis label"), "a very long…");
  // Axis labels are wrapped in full, never cut mid-word (null = rotate instead)
  assert.deepEqual(wrapLabel("les jeux vidéo", 8), ["les jeux", "vidéo"]);
  assert.deepEqual(wrapLabel("short", 8), ["short"]);
  assert.equal(wrapLabel("Utiliser le téléphone", 4), null);
  assert.equal(wrapLabel("one two three four five six", 7, 2), null);
  assert.equal(wrapLabel("los videojuegos", 14)?.join(" "), "los videojuegos");
  passed += 14;
}

// --- N2/M5: saved widget answers restore exactly (restore round trip)
{
  const cols = ["n", "term | x", "note"];
  const nasty = [
    ["1", "3", ""],
    ["2", "a | b", "c / d"],
    ["-", 'say "hi"', "back\\slash; semi"],
    ["", "", ""],
  ];
  const enc = encodeFillAnswer(cols, nasty);
  const dec = decodeFillAnswer(cols, 4, enc);
  assert.deepEqual(dec, nasty);
  assert.equal(encodeFillAnswer(cols, dec), enc);
  assert.deepEqual(decodeFillAnswer(cols, 3, ""), [
    Array(3).fill(""),
    Array(3).fill(""),
    Array(3).fill(""),
  ]);
  // wrong columns / too many rows / junk give a blank grid, never a partial one
  assert.deepEqual(decodeFillAnswer(["a", "b"], 2, enc), [
    ["", ""],
    ["", ""],
  ]);
  assert.deepEqual(decodeFillAnswer(cols, 2, enc), [Array(3).fill(""), Array(3).fill("")]);
  assert.deepEqual(decodeFillAnswer(["a"], 1, "table (a): "), [[""]]);
  // trailing/leading spaces are trimmed on encode, so the restored grid equals what was submitted
  assert.deepEqual(decodeFillAnswer(["a"], 1, encodeFillAnswer(["a"], [["  x  "]])), [["x"]]);

  const slots = ["Fewest books", "Most = books"];
  const items = ["Wednesday", "Tuesday", "Mon; day"];
  for (const placed of [
    {},
    { "Fewest books": "Wednesday" },
    { "Fewest books": "Wednesday", "Most = books": "Tuesday" },
    { "Fewest books": "Mon; day", "Most = books": "Wednesday" },
  ] as Record<string, string>[]) {
    const e = encodeDragAnswer(slots, placed);
    assert.deepEqual(decodeDragAnswer(slots, items, e), placed, `drag round trip: ${e}`);
  }
  assert.deepEqual(decodeDragAnswer(slots, items, "Nonsense = Tuesday"), {});
  assert.deepEqual(decodeDragAnswer(slots, items, "Fewest books = Friday"), {});

  const box = { xmin: -2, xmax: 6, ymin: 0, ymax: 8 };
  for (const [pts, join] of [
    [[], false],
    [[{ x: 3, y: 5 }], false],
    [
      [
        { x: 3, y: 5 },
        { x: -2, y: 6 },
      ],
      true,
    ],
    [
      [
        { x: 0, y: 0 },
        { x: 6, y: 8 },
        { x: 1, y: 1 },
      ],
      false,
    ],
  ] as [{ x: number; y: number }[], boolean][]) {
    const e = encodePlotAnswer(pts, join);
    const d = decodePlotAnswer(box, e);
    assert.deepEqual(d.points, pts, `plot points: ${e}`);
    if (pts.length > 1) assert.equal(d.join, join);
  }
  assert.deepEqual(decodePlotAnswer(box, "plotted (99, 5)").points, []);
  assert.deepEqual(decodePlotAnswer(box, "something else").points, []);
  passed += 20;
}

console.log(`task-markup: ${passed} assertions passed`);
