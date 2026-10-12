// Inline interactive/diagram markup for written exam tasks. Pure parser, used by the paper runner
// (to render widgets) and by the server (to reject malformed AI-written tasks).
//
//   {{select|id|option 1|option 2|option 3}}          drop-down inside a sentence
//   {{drag|id|Slot A,Slot B|item 1,item 2,item 3}}     drag (or click) items into slots of a table
//   {{plot|id|xmin,xmax,ymin,ymax|x label|y label}}    click on a grid to plot points
//   {{fill|id|Col 1,Col 2,Col 3|rows}}                 table the student fills in
//   {{chart|bar|Title|x label|y label|A:3,B:5,C:2}}    diagram shown with the question (bar, line, pie)

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

const list = (s: string | undefined) =>
  (s ?? "")
    .split(",")
    .map((x) => x.trim())
    .filter(Boolean);

function parseWidget(raw: string): Widget | null {
  const p = raw.split("|").map((x) => x.trim());
  const kind = p[0]?.toLowerCase();
  const id = p[1] ?? "";
  if (kind === "select") {
    const options = p.slice(2).filter(Boolean);
    return id && options.length >= 2 ? { kind, id, options } : null;
  }
  if (kind === "drag") {
    const slots = list(p[2]);
    const items = list(p[3]);
    return id && slots.length >= 2 && items.length >= 2 ? { kind, id, slots, items } : null;
  }
  if (kind === "plot") {
    const b = list(p[2]).map(Number);
    if (!id || b.length !== 4 || b.some((n) => !Number.isFinite(n))) return null;
    const [xmin, xmax, ymin, ymax] = b as [number, number, number, number];
    if (xmax <= xmin || ymax <= ymin || xmax - xmin > 40 || ymax - ymin > 40) return null;
    return { kind, id, xmin, xmax, ymin, ymax, xl: p[3] ?? "x", yl: p[4] ?? "y" };
  }
  if (kind === "fill") {
    const cols = list(p[2]);
    const rows = Number(p[3]);
    return id && cols.length >= 1 && rows >= 1 && rows <= 12 ? { kind, id, cols, rows } : null;
  }
  if (kind === "chart") {
    const type = p[1];
    if (type !== "bar" && type !== "line" && type !== "pie") return null;
    const data = list(p[5])
      .map((x) => {
        const i = x.lastIndexOf(":");
        return { label: x.slice(0, i).trim(), value: Number(x.slice(i + 1)) };
      })
      .filter((d) => d.label && Number.isFinite(d.value));
    return data.length >= 2
      ? { kind, type, title: p[2] ?? "", xl: p[3] ?? "", yl: p[4] ?? "", data }
      : null;
  }
  return null;
}

export function parseTaskBody(text: string): { segments: Segment[]; errors: string[] } {
  const segments: Segment[] = [];
  const errors: string[] = [];
  let last = 0;
  for (const m of text.matchAll(/\{\{([^{}]*)\}\}/g)) {
    const at = m.index ?? 0;
    if (at > last) segments.push({ type: "text", text: text.slice(last, at) });
    const w = parseWidget(m[1] ?? "");
    if (w) segments.push({ type: "widget", widget: w });
    else errors.push(m[0]);
    last = at + m[0].length;
  }
  if (last < text.length) segments.push({ type: "text", text: text.slice(last) });
  return { segments, errors };
}

/** Ids of the answer widgets (not charts) in a task, in order. */
export function widgetIds(text: string): string[] {
  return parseTaskBody(text).segments.flatMap((s) =>
    s.type === "widget" && s.widget.kind !== "chart" ? [s.widget.id] : [],
  );
}
