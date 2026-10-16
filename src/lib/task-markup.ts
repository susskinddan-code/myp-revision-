// Inline interactive/diagram markup for written exam tasks. Pure parser, used by the paper runner
// (to render widgets) and by the server (to reject malformed AI-written tasks).
//
//   {{select|id|option 1|option 2|option 3}}          drop-down inside a sentence
//   {{drag|id|Slot A,Slot B|item 1,item 2,item 3}}     drag (or click) items into slots of a table
//   {{plot|id|xmin,xmax,ymin,ymax|x label|y label}}    click on a grid to plot points
//   {{fill|id|Col 1,Col 2,Col 3|rows}}                 table the student fills in
//   {{chart|bar|Title|x label|y label|A:3,B:5,C:2}}    diagram shown with the question (bar, line, pie)
//
// Kinds are lower case in the documented syntax; upper case is accepted and normalised.
// Ids match /^[a-z0-9_-]{1,20}$/i. Anything malformed is rejected (null) and reported in `errors`.

export type ChartPoint = { label: string; value: number };

export type Widget =
  | { kind: "select"; id: string; options: string[] }
  | { kind: "drag"; id: string; slots: string[]; items: string[] }
  | {
      kind: "plot";
      id: string;
      xmin: number;
      xmax: number;
      ymin: number;
      ymax: number;
      xl: string;
      yl: string;
    }
  | { kind: "fill"; id: string; cols: string[]; rows: number }
  | {
      kind: "chart";
      type: "bar" | "line" | "pie";
      title: string;
      xl: string;
      yl: string;
      data: ChartPoint[];
    };

export type Segment = { type: "text"; text: string } | { type: "widget"; widget: Widget };

export const WIDGET_ID = /^[a-z0-9_-]{1,20}$/i;
export const MAX_FILL_COLS = 8;
export const MAX_FILL_ROWS = 12;
export const MAX_PLOT_SPAN = 40;
export const MAX_CHART_POINTS = 24;

const list = (s: string | undefined) =>
  (s ?? "")
    .split(",")
    .map((x) => x.trim())
    .filter(Boolean);

const hasDuplicates = (xs: string[]) => new Set(xs).size !== xs.length;

function parseWidget(raw: string): Widget | null {
  const p = raw.split("|").map((x) => x.trim());
  const kind = p[0]?.toLowerCase();
  const id = p[1] ?? "";
  if (kind === "select") {
    if (!WIDGET_ID.test(id)) return null;
    const options = p.slice(2).filter(Boolean);
    return options.length >= 2 && !hasDuplicates(options) ? { kind, id, options } : null;
  }
  if (kind === "drag") {
    if (!WIDGET_ID.test(id)) return null;
    const slots = list(p[2]);
    const items = list(p[3]);
    if (hasDuplicates(slots) || hasDuplicates(items)) return null;
    // Each item can be placed once, so there must be at least as many items as slots.
    return slots.length >= 2 && items.length >= slots.length ? { kind, id, slots, items } : null;
  }
  if (kind === "plot") {
    if (!WIDGET_ID.test(id)) return null;
    const raw4 = list(p[2]);
    const b = raw4.map(Number);
    if (b.length !== 4 || b.some((n) => !Number.isInteger(n))) return null;
    const [xmin, xmax, ymin, ymax] = b as [number, number, number, number];
    // Points snap to whole numbers, so each axis needs at least one whole unit and an ascending range.
    if (xmax - xmin < 1 || ymax - ymin < 1) return null;
    if (xmax - xmin > MAX_PLOT_SPAN || ymax - ymin > MAX_PLOT_SPAN) return null;
    return { kind, id, xmin, xmax, ymin, ymax, xl: p[3] ?? "x", yl: p[4] ?? "y" };
  }
  if (kind === "fill") {
    if (!WIDGET_ID.test(id)) return null;
    const cols = list(p[2]);
    const rows = Number(p[3]);
    if (!cols.length || cols.length > MAX_FILL_COLS) return null;
    if (!Number.isInteger(rows) || rows < 1 || rows > MAX_FILL_ROWS) return null;
    return { kind, id, cols, rows };
  }
  if (kind === "chart") {
    const type = p[1]?.toLowerCase();
    if (type !== "bar" && type !== "line" && type !== "pie") return null;
    const entries = list(p[5]);
    if (entries.length < 2 || entries.length > MAX_CHART_POINTS) return null;
    const data: ChartPoint[] = [];
    for (const x of entries) {
      const i = x.lastIndexOf(":");
      if (i < 1) return null;
      const label = x.slice(0, i).trim();
      const num = x.slice(i + 1).trim();
      // An empty value ("A:") must not silently become 0.
      if (!label || !num) return null;
      const value = Number(num);
      if (!Number.isFinite(value)) return null;
      data.push({ label, value });
    }
    if (type === "pie") {
      // Slices are shares of a whole: negative values make no sense, and an all-zero pie is empty.
      if (data.some((d) => d.value < 0)) return null;
      if (data.reduce((t, d) => t + d.value, 0) <= 0) return null;
    }
    return { kind: "chart", type, title: p[2] ?? "", xl: p[3] ?? "", yl: p[4] ?? "", data };
  }
  return null;
}

export function parseTaskBody(text: string): { segments: Segment[]; errors: string[] } {
  const segments: Segment[] = [];
  const errors: string[] = [];
  const seen = new Set<string>();
  // Three braces in a row ("{{{select|...}}}") would leave stray braces in the question text.
  if (/\{\{\{|\}\}\}/.test(text)) errors.push("triple braces");
  let last = 0;
  for (const m of text.matchAll(/\{\{([^{}]*)\}\}/g)) {
    const at = m.index ?? 0;
    if (at > last) segments.push({ type: "text", text: text.slice(last, at) });
    let w = parseWidget(m[1] ?? "");
    if (w) {
      if (w.kind !== "chart") {
        if (seen.has(w.id.toLowerCase())) {
          errors.push(`duplicate widget id "${w.id}"`);
          // Give the repeat a unique id so the two widgets do not share one value.
          let n = 2;
          while (seen.has(`${w.id}-${n}`.toLowerCase())) n++;
          w = { ...w, id: `${w.id}-${n}` };
        }
        seen.add(w.id.toLowerCase());
      }
      segments.push({ type: "widget", widget: w });
    } else errors.push(m[0]);
    last = at + m[0].length;
  }
  if (last < text.length) segments.push({ type: "text", text: text.slice(last) });
  // Braces left over after removing every well-formed widget mean unclosed or stray markup.
  const leftover = segments
    .filter((s): s is { type: "text"; text: string } => s.type === "text")
    .map((s) => s.text)
    .join("");
  if (/\{\{|\}\}/.test(leftover)) errors.push("unclosed or stray {{ }}");
  return { segments, errors };
}

/** Ids of the answer widgets (not charts) in a task, in order. */
export function widgetIds(text: string): string[] {
  return parseTaskBody(text).segments.flatMap((s) =>
    s.type === "widget" && s.widget.kind !== "chart" ? [s.widget.id] : [],
  );
}

/**
 * Encodes a fill-table answer for the marker without ambiguity. Cells are trimmed; an empty cell is
 * "-"; any cell containing a separator (" | ", " / ", ";"), a quote, or that is literally "-" is
 * written as a JSON string. Returns "" when no cell has content (whitespace-only counts as empty).
 */
export function encodeFillAnswer(cols: string[], cells: string[][]): string {
  const clean = cells.map((row) => row.map((x) => x.trim()));
  if (!clean.some((row) => row.some(Boolean))) return "";
  return `table (${cols.map(encFillCell).join(" | ")}): ${clean.map((row) => row.map(encFillCell).join(" | ")).join(" / ")}`;
}

const encFillCell = (x: string) =>
  !x ? "-" : /[|/;"\\]/.test(x) || x === "-" ? JSON.stringify(x) : x;

/**
 * Inverse of encodeFillAnswer: rebuilds the `rows` x `cols.length` cell grid from a saved answer so a
 * reloaded exam shows what will be submitted. Returns a blank grid for "" or anything that is not
 * exactly what encodeFillAnswer would have written for these columns.
 */
export function decodeFillAnswer(cols: string[], rows: number, value: string): string[][] {
  const blank = () => Array.from({ length: rows }, () => cols.map(() => ""));
  const prefix = `table (${cols.map(encFillCell).join(" | ")}): `;
  if (!value.startsWith(prefix)) return blank();
  const body = value.slice(prefix.length);
  const grid: string[][] = [[]];
  let i = 0;
  while (i <= body.length) {
    let cell: string;
    if (body[i] === '"') {
      let j = i + 1;
      while (j < body.length && body[j] !== '"') j += body[j] === "\\" ? 2 : 1;
      if (j >= body.length) return blank();
      try {
        cell = JSON.parse(body.slice(i, j + 1)) as string;
      } catch {
        return blank();
      }
      i = j + 1;
    } else {
      let j = i;
      while (j < body.length && !body.startsWith(" | ", j) && !body.startsWith(" / ", j)) j++;
      cell = body.slice(i, j);
      i = j;
      if (cell === "-") cell = "";
    }
    grid[grid.length - 1]!.push(cell);
    if (i >= body.length) break;
    if (body.startsWith(" | ", i)) i += 3;
    else if (body.startsWith(" / ", i)) {
      i += 3;
      grid.push([]);
    } else return blank();
  }
  if (grid.length > rows || grid.some((r) => r.length !== cols.length)) return blank();
  const out = blank();
  grid.forEach((r, ri) => (out[ri] = r));
  return out;
}

/** Encodes drag-table placements ("Slot = item; Slot = item", in slot order). */
export function encodeDragAnswer(slots: string[], placed: Record<string, string>): string {
  return slots
    .filter((s) => placed[s])
    .map((s) => `${s} = ${placed[s]}`)
    .join("; ");
}

/** Inverse of encodeDragAnswer; anything that does not round-trip gives no placements. */
export function decodeDragAnswer(
  slots: string[],
  items: string[],
  value: string,
): Record<string, string> {
  if (!value) return {};
  const placed: Record<string, string> = {};
  const used = new Set<string>();
  for (const slot of slots) {
    for (const item of items) {
      const pair = `${slot} = ${item}`;
      const hit =
        value === pair ||
        value.startsWith(`${pair}; `) ||
        value.endsWith(`; ${pair}`) ||
        value.includes(`; ${pair}; `);
      if (hit && !used.has(item)) {
        placed[slot] = item;
        used.add(item);
        break;
      }
    }
  }
  return encodeDragAnswer(slots, placed) === value ? placed : {};
}

export type PlotPoint = { x: number; y: number };

/** Encodes plotted points the way the marker reads them. */
export function encodePlotAnswer(points: PlotPoint[], join: boolean): string {
  if (!points.length) return "";
  return `plotted ${points.map((p) => `(${p.x}, ${p.y})`).join(", ")}${
    points.length > 1 ? (join ? ", joined by straight lines" : ", not joined") : ""
  }`;
}

/** Inverse of encodePlotAnswer; points outside the grid or a string that does not round-trip give none. */
export function decodePlotAnswer(
  w: { xmin: number; xmax: number; ymin: number; ymax: number },
  value: string,
): { points: PlotPoint[]; join: boolean } {
  const none = { points: [], join: false };
  if (!value.startsWith("plotted ")) return none;
  const points = [...value.matchAll(/\((-?\d+), (-?\d+)\)/g)].map((m) => ({
    x: Number(m[1]),
    y: Number(m[2]),
  }));
  const join = value.endsWith(", joined by straight lines");
  if (
    !points.length ||
    points.some((p) => p.x < w.xmin || p.x > w.xmax || p.y < w.ymin || p.y > w.ymax) ||
    encodePlotAnswer(points, join) !== value
  )
    return none;
  return { points, join };
}

/** "Nice" axis for a chart that always includes zero; handles negatives and tiny values. */
export function niceScale(values: number[]): { lo: number; hi: number; ticks: number[] } {
  let lo = Math.min(0, ...values);
  let hi = Math.max(0, ...values);
  if (hi === lo) hi = 1;
  const raw = (hi - lo) / 4;
  const mag = 10 ** Math.floor(Math.log10(raw));
  const norm = raw / mag;
  const step = (norm <= 1 ? 1 : norm <= 2 ? 2 : norm <= 2.5 ? 2.5 : norm <= 5 ? 5 : 10) * mag;
  lo = Math.floor(lo / step + 1e-9) * step;
  hi = Math.ceil(hi / step - 1e-9) * step;
  const ticks: number[] = [];
  for (let v = lo; v <= hi + step / 2; v += step) ticks.push(Number(v.toPrecision(12)));
  return { lo: Number(lo.toPrecision(12)), hi: Number(hi.toPrecision(12)), ticks };
}

const compact = new Intl.NumberFormat("en", { notation: "compact", maximumFractionDigits: 1 });
/** Short axis/legend number: compact above 9,999, otherwise at most 4 significant digits. */
export function formatNumber(v: number): string {
  if (Math.abs(v) >= 10000) return compact.format(v);
  return String(Number(v.toPrecision(4)));
}

export function truncateLabel(s: string, max = 12): string {
  return s.length > max ? `${s.slice(0, max - 1)}…` : s;
}

/**
 * Splits an axis label over at most `maxLines` lines of about `perLine` characters, breaking on spaces.
 * Returns null when it cannot be done without cutting a word (the caller then rotates the label instead).
 */
export function wrapLabel(s: string, perLine: number, maxLines = 3): string[] | null {
  const words = s.trim().split(/\s+/).filter(Boolean);
  if (!words.length) return [""];
  if (words.some((w) => w.length > perLine)) return null;
  const lines: string[] = [];
  let cur = "";
  for (const w of words) {
    if (!cur) cur = w;
    else if (cur.length + 1 + w.length <= perLine) cur += ` ${w}`;
    else {
      lines.push(cur);
      cur = w;
    }
  }
  lines.push(cur);
  return lines.length > maxLines ? null : lines;
}
