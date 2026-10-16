import { useEffect, useMemo, useState } from "react";
import { Button } from "@/components/ui/button";
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
  type Widget,
} from "@/lib/task-markup";

const FOCUS =
  "focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary";

type Props = {
  text: string;
  values: Record<string, string>;
  onChange: (id: string, value: string) => void;
  disabled: boolean;
};

/** Renders task text with its interactive answer widgets and diagrams. */
export function TaskBody({ text, values, onChange, disabled }: Props) {
  const { segments } = parseTaskBody(text);
  return (
    <div className="mt-2 font-medium leading-relaxed">
      {segments.map((s, i) =>
        s.type === "text" ? (
          <span key={i} className="whitespace-pre-line">
            {s.text}
          </span>
        ) : (
          <WidgetView
            key={i}
            widget={s.widget}
            value={s.widget.kind === "chart" ? "" : (values[s.widget.id] ?? "")}
            onChange={onChange}
            disabled={disabled}
          />
        ),
      )}
    </div>
  );
}

function WidgetView({
  widget,
  value,
  onChange,
  disabled,
}: {
  widget: Widget;
  value: string;
  onChange: (id: string, value: string) => void;
  disabled: boolean;
}) {
  switch (widget.kind) {
    case "select":
      return (
        <select
          aria-label={`Choose an answer (${widget.id})`}
          value={value}
          disabled={disabled}
          onChange={(e) => onChange(widget.id, e.target.value)}
          className="mx-1 inline-block max-w-full min-w-0 truncate rounded-md border border-border bg-background px-2 py-1 text-sm font-normal outline-none focus:border-primary"
        >
          <option value="">Choose…</option>
          {widget.options.map((o) => (
            <option key={o} value={o}>
              {o}
            </option>
          ))}
        </select>
      );
    case "drag":
      return <DragTable widget={widget} value={value} onChange={onChange} disabled={disabled} />;
    case "plot":
      return <PlotGrid widget={widget} value={value} onChange={onChange} disabled={disabled} />;
    case "fill":
      return <FillTable widget={widget} value={value} onChange={onChange} disabled={disabled} />;
    case "chart":
      return <Chart widget={widget} />;
  }
}

/* ---------------------------- drag items into a table --------------------------- */

function DragTable({
  widget,
  value,
  onChange,
  disabled,
}: {
  widget: Extract<Widget, { kind: "drag" }>;
  value: string;
  onChange: (id: string, value: string) => void;
  disabled: boolean;
}) {
  // The saved answer is the single source of truth, so a restored exam shows what will be submitted.
  const placed = useMemo(
    () => decodeDragAnswer(widget.slots, widget.items, value),
    [widget.slots, widget.items, value],
  );
  const [held, setHeld] = useState<string | null>(null);
  const [msg, setMsg] = useState("");

  function commit(next: Record<string, string>) {
    onChange(widget.id, encodeDragAnswer(widget.slots, next));
  }
  function place(slot: string, item: string) {
    if (disabled) return;
    const next = { ...placed };
    for (const k of Object.keys(next)) if (next[k] === item) delete next[k];
    next[slot] = item;
    commit(next);
    setHeld(null);
    setMsg(`Placed ${item} in ${slot}`);
  }
  function clear(slot: string) {
    if (disabled || !placed[slot]) return;
    const next = { ...placed };
    const item = next[slot];
    delete next[slot];
    commit(next);
    setMsg(`Removed ${item} from ${slot}`);
  }
  const used = new Set(Object.values(placed));
  return (
    <div className="my-3 rounded-md border border-border bg-surface-2 p-3 font-normal">
      <p className="mb-2 text-xs uppercase tracking-wide text-muted-foreground">
        Drag each item into the table, or select an item then a row (Enter or Space)
      </p>
      <span className="sr-only" role="status" aria-live="polite">
        {msg}
      </span>
      <div className="mb-3 flex flex-wrap gap-2">
        {widget.items.map((item) => (
          <button
            key={item}
            type="button"
            draggable={!disabled}
            disabled={disabled}
            onDragStart={(e) => e.dataTransfer.setData("text/plain", item)}
            aria-pressed={held === item}
            aria-label={`${item}${
              Object.entries(placed).find(([, v]) => v === item)
                ? `, placed in ${Object.entries(placed).find(([, v]) => v === item)![0]}`
                : ""
            }`}
            onClick={() => {
              setHeld(held === item ? null : item);
              setMsg(held === item ? `${item} deselected` : `${item} selected`);
            }}
            className={`rounded-full border px-3 py-1 text-sm ${FOCUS} ${
              held === item
                ? "border-primary bg-primary text-primary-foreground"
                : used.has(item)
                  ? "border-border bg-card text-muted-foreground"
                  : "border-primary/60 bg-background"
            }`}
          >
            {item}
          </button>
        ))}
      </div>
      <table className="w-full border-collapse text-sm">
        <tbody>
          {widget.slots.map((slot) => (
            <tr key={slot} className="border-t border-border">
              <th className="w-1/2 p-2 text-left font-medium">{slot}</th>
              <td
                onDragOver={(e) => e.preventDefault()}
                onDrop={(e) => {
                  e.preventDefault();
                  const item = e.dataTransfer.getData("text/plain");
                  if (item && widget.items.includes(item)) place(slot, item);
                }}
                onClick={() => (held ? place(slot, held) : undefined)}
                className={`h-10 border-l border-dashed border-border p-2 ${
                  held && !disabled ? "cursor-pointer bg-primary/5" : ""
                }`}
              >
                <span
                  role="button"
                  tabIndex={disabled ? -1 : 0}
                  aria-disabled={disabled}
                  aria-label={`${slot}: ${placed[slot] ? `contains ${placed[slot]}` : "empty"}. ${
                    held
                      ? `Press Enter to place ${held} here`
                      : placed[slot]
                        ? "Press Delete to remove it"
                        : "Select an item first"
                  }`}
                  onKeyDown={(e) => {
                    if (disabled) return;
                    if (e.key === "Enter" || e.key === " ") {
                      e.preventDefault();
                      if (held) place(slot, held);
                      else
                        setMsg(placed[slot] ? "Press Delete to remove it" : "Select an item first");
                    } else if (e.key === "Delete" || e.key === "Backspace") {
                      e.preventDefault();
                      clear(slot);
                    }
                  }}
                  className={`inline-block min-w-16 rounded-sm ${FOCUS}`}
                >
                  {placed[slot] ?? <span className="text-muted-foreground">Drop here</span>}
                </span>
                {placed[slot] && !disabled ? (
                  <button
                    type="button"
                    aria-label={`Remove ${placed[slot]} from ${slot}`}
                    className={`ml-2 rounded-sm text-xs text-muted-foreground underline ${FOCUS}`}
                    onClick={(e) => {
                      e.stopPropagation();
                      clear(slot);
                    }}
                  >
                    remove
                  </button>
                ) : null}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

/* --------------------------------- plot on a grid -------------------------------- */

function PlotGrid({
  widget,
  value,
  onChange,
  disabled,
}: {
  widget: Extract<Widget, { kind: "plot" }>;
  value: string;
  onChange: (id: string, value: string) => void;
  disabled: boolean;
}) {
  // Points come from the saved answer. "Join" is only encoded with two or more points, so a
  // one-point choice is kept locally.
  const saved = useMemo(() => decodePlotAnswer(widget, value), [widget, value]);
  const points = saved.points;
  const [joinLocal, setJoin] = useState(false);
  const join = points.length > 1 ? saved.join : joinLocal;
  const [cur, setCur] = useState({ x: widget.xmin, y: widget.ymin });
  const [focused, setFocused] = useState(false);
  const [msg, setMsg] = useState("");
  const W = 420;
  const H = 300;
  const pad = 36;
  const sx = (x: number) =>
    pad + ((x - widget.xmin) / (widget.xmax - widget.xmin)) * (W - pad * 1.5);
  const sy = (y: number) =>
    H - pad - ((y - widget.ymin) / (widget.ymax - widget.ymin)) * (H - pad * 1.5);

  function commit(pts: { x: number; y: number }[], j: boolean) {
    setJoin(j);
    onChange(widget.id, encodePlotAnswer(pts, j));
  }
  function add(x: number, y: number) {
    if (disabled) return;
    if (points.some((p) => p.x === x && p.y === y)) {
      setMsg(`(${x}, ${y}) is already plotted`);
      return;
    }
    commit([...points, { x, y }], join);
    setMsg(`Plotted (${x}, ${y}). ${points.length + 1} points`);
  }
  function undo() {
    const last = points[points.length - 1];
    commit(points.slice(0, -1), join);
    if (last) setMsg(`Removed (${last.x}, ${last.y}). ${points.length - 1} points`);
  }
  function onKey(e: React.KeyboardEvent<SVGSVGElement>) {
    if (disabled) return;
    const d: Record<string, [number, number]> = {
      ArrowLeft: [-1, 0],
      ArrowRight: [1, 0],
      ArrowUp: [0, 1],
      ArrowDown: [0, -1],
    };
    const mv = d[e.key];
    if (mv) {
      e.preventDefault();
      const x = Math.min(widget.xmax, Math.max(widget.xmin, cur.x + mv[0]));
      const y = Math.min(widget.ymax, Math.max(widget.ymin, cur.y + mv[1]));
      setCur({ x, y });
      setMsg(`Cursor at (${x}, ${y})`);
    } else if (e.key === "Enter" || e.key === " ") {
      e.preventDefault();
      add(cur.x, cur.y);
    } else if (e.key === "Backspace" || e.key === "Delete") {
      e.preventDefault();
      undo();
    }
  }
  function click(e: React.MouseEvent<SVGSVGElement>) {
    if (disabled) return;
    const r = e.currentTarget.getBoundingClientRect();
    const px = ((e.clientX - r.left) / r.width) * W;
    const py = ((e.clientY - r.top) / r.height) * H;
    const x = Math.round(
      widget.xmin + ((px - pad) / (W - pad * 1.5)) * (widget.xmax - widget.xmin),
    );
    const y = Math.round(
      widget.ymin + ((H - pad - py) / (H - pad * 1.5)) * (widget.ymax - widget.ymin),
    );
    if (x < widget.xmin || x > widget.xmax || y < widget.ymin || y > widget.ymax) return;
    if (points.some((p) => p.x === x && p.y === y)) return;
    setCur({ x, y });
    add(x, y);
  }
  const xs = Array.from({ length: widget.xmax - widget.xmin + 1 }, (_, i) => widget.xmin + i);
  const ys = Array.from({ length: widget.ymax - widget.ymin + 1 }, (_, i) => widget.ymin + i);
  const stepX = Math.max(1, Math.ceil(xs.length / 12));
  const stepY = Math.max(1, Math.ceil(ys.length / 10));
  return (
    <div className="my-3 rounded-md border border-border bg-surface-2 p-3 font-normal">
      <p className="mb-2 text-xs uppercase tracking-wide text-muted-foreground">
        Click the grid to plot a point, or focus it and use the arrow keys, Enter to plot, Backspace
        to undo
      </p>
      <span className="sr-only" role="status" aria-live="polite">
        {msg}
      </span>
      <svg
        viewBox={`0 0 ${W} ${H}`}
        role="application"
        tabIndex={disabled ? -1 : 0}
        aria-label={`Grid for plotting points, ${widget.xl} (${widget.xmin} to ${widget.xmax}) against ${widget.yl} (${widget.ymin} to ${widget.ymax}). Arrow keys move the cursor, Enter plots a point, Backspace removes the last point. ${points.length} points plotted.`}
        onClick={click}
        onKeyDown={onKey}
        onFocus={() => setFocused(true)}
        onBlur={() => setFocused(false)}
        className={`w-full max-w-md bg-background ${FOCUS} ${disabled ? "" : "cursor-crosshair"}`}
      >
        {xs.map((x) => (
          <line
            key={`gx${x}`}
            x1={sx(x)}
            x2={sx(x)}
            y1={sy(widget.ymin)}
            y2={sy(widget.ymax)}
            stroke="var(--border)"
          />
        ))}
        {ys.map((y) => (
          <line
            key={`gy${y}`}
            y1={sy(y)}
            y2={sy(y)}
            x1={sx(widget.xmin)}
            x2={sx(widget.xmax)}
            stroke="var(--border)"
          />
        ))}
        {xmin0(widget) ? (
          <line
            x1={sx(0)}
            x2={sx(0)}
            y1={sy(widget.ymin)}
            y2={sy(widget.ymax)}
            stroke="var(--foreground)"
          />
        ) : null}
        {ymin0(widget) ? (
          <line
            y1={sy(0)}
            y2={sy(0)}
            x1={sx(widget.xmin)}
            x2={sx(widget.xmax)}
            stroke="var(--foreground)"
          />
        ) : null}
        {xs
          .filter((_, i) => i % stepX === 0)
          .map((x) => (
            <text
              key={`tx${x}`}
              x={sx(x)}
              y={H - pad + 14}
              fontSize="10"
              textAnchor="middle"
              fill="var(--muted-foreground)"
            >
              {x}
            </text>
          ))}
        {ys
          .filter((_, i) => i % stepY === 0)
          .map((y) => (
            <text
              key={`ty${y}`}
              x={pad - 6}
              y={sy(y) + 3}
              fontSize="10"
              textAnchor="end"
              fill="var(--muted-foreground)"
            >
              {y}
            </text>
          ))}
        <text x={W / 2} y={H - 6} fontSize="11" textAnchor="middle" fill="var(--foreground)">
          {widget.xl}
        </text>
        <text
          x={10}
          y={H / 2}
          fontSize="11"
          textAnchor="middle"
          fill="var(--foreground)"
          transform={`rotate(-90 10 ${H / 2})`}
        >
          {widget.yl}
        </text>
        {join && points.length > 1 ? (
          <polyline
            fill="none"
            stroke="var(--primary)"
            strokeWidth="2"
            points={points.map((p) => `${sx(p.x)},${sy(p.y)}`).join(" ")}
          />
        ) : null}
        {points.map((p, i) => (
          <circle key={i} cx={sx(p.x)} cy={sy(p.y)} r="4.5" fill="var(--primary)" />
        ))}
        {focused && !disabled ? (
          <circle
            cx={sx(cur.x)}
            cy={sy(cur.y)}
            r="8"
            fill="none"
            stroke="var(--foreground)"
            strokeWidth="2"
            strokeDasharray="3 2"
          />
        ) : null}
      </svg>
      <div className="mt-2 flex flex-wrap items-center gap-2 text-sm">
        <span className="text-muted-foreground">
          {points.length ? points.map((p) => `(${p.x}, ${p.y})`).join("  ") : "No points yet"}
        </span>
        {!disabled ? (
          <>
            <Button
              type="button"
              size="sm"
              variant="outline"
              className="rounded-full"
              onClick={undo}
            >
              Undo
            </Button>
            <Button
              type="button"
              size="sm"
              variant="outline"
              className="rounded-full"
              onClick={() => {
                commit([], false);
                setMsg("Cleared all points");
              }}
            >
              Clear
            </Button>
            <label className="flex items-center gap-1 text-xs">
              <input
                type="checkbox"
                checked={join}
                onChange={(e) => commit(points, e.target.checked)}
              />
              Join points with lines
            </label>
          </>
        ) : null}
      </div>
    </div>
  );
}
const xmin0 = (w: { xmin: number; xmax: number }) => w.xmin <= 0 && w.xmax >= 0;
const ymin0 = (w: { ymin: number; ymax: number }) => w.ymin <= 0 && w.ymax >= 0;

/* -------------------------------- fill-in table --------------------------------- */

function FillTable({
  widget,
  value,
  onChange,
  disabled,
}: {
  widget: Extract<Widget, { kind: "fill" }>;
  value: string;
  onChange: (id: string, value: string) => void;
  disabled: boolean;
}) {
  const [cells, setCells] = useState<string[][]>(() =>
    decodeFillAnswer(widget.cols, widget.rows, value),
  );
  // Typing keeps the raw text (the saved answer trims it); a saved answer that differs from what the
  // table would encode (restored or replaced from outside) takes over.
  useEffect(() => {
    if (value !== encodeFillAnswer(widget.cols, cells))
      setCells(decodeFillAnswer(widget.cols, widget.rows, value));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [value]);
  function set(r: number, c: number, v: string) {
    const next = cells.map((row) => [...row]);
    next[r]![c] = v;
    setCells(next);
    onChange(widget.id, encodeFillAnswer(widget.cols, next));
  }
  return (
    <div className="my-3 overflow-x-auto rounded-md border border-border bg-surface-2 p-3 font-normal">
      <table className="w-full border-collapse text-sm">
        <thead>
          <tr>
            {widget.cols.map((c) => (
              <th key={c} className="border border-border bg-card p-2 text-left font-medium">
                {c}
              </th>
            ))}
          </tr>
        </thead>
        <tbody>
          {cells.map((row, r) => (
            <tr key={r}>
              {row.map((v, c) => (
                <td key={c} className="border border-border p-0">
                  <input
                    aria-label={`${widget.cols[c]}, row ${r + 1}`}
                    value={v}
                    disabled={disabled}
                    onChange={(e) => set(r, c, e.target.value)}
                    className="w-full bg-background p-2 focus:bg-primary/5 focus-visible:outline focus-visible:outline-2 focus-visible:-outline-offset-2 focus-visible:outline-primary"
                  />
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

/* ------------------------------ diagrams (display) ------------------------------- */

// Pie slices: eight clearly different hues (colour-blind-safe Okabe-Ito set). Colour is never the only
// cue: every slice and legend row also carries its number.
const CHART_COLORS = [
  "#0072B2",
  "#E69F00",
  "#009E73",
  "#CC79A7",
  "#D55E00",
  "#56B4E9",
  "#F0E442",
  "#7A7A7A",
];
const sliceColor = (i: number) =>
  i < CHART_COLORS.length ? CHART_COLORS[i]! : `hsl(${(i * 47) % 360} 55% 50%)`;
/** Slice number: black on the light hues, white on the rest. */
const sliceInk = (i: number) => (i === 1 || i === 6 || i === 5 ? "#111" : "#fff");

function Chart({ widget }: { widget: Extract<Widget, { kind: "chart" }> }) {
  if (widget.type === "pie") return <PieChart widget={widget} />;
  const W = 420;
  const H = 260;
  const { lo, hi, ticks } = niceScale(widget.data.map((d) => d.value));
  const tickText = ticks.map(formatNumber);
  const n = widget.data.length;
  const left = Math.max(40, Math.max(...tickText.map((t) => t.length)) * 6 + 20);
  const right = 10;
  const bw = (W - left - right) / n;
  // Category names are shown in full: wrapped over up to 3 lines when they fit, otherwise rotated
  // (and only then shortened, at 24 characters). The data table under the chart always has the full text.
  const perLine = Math.max(3, Math.floor((bw * 0.95) / 5.6));
  const wrapped = widget.data.map((d) => wrapLabel(d.label, perLine));
  const rotate = wrapped.some((w) => w === null);
  const labels = widget.data.map((d) => truncateLabel(d.label, 24));
  const maxLen = Math.max(...labels.map((l) => l.length));
  const maxLines = Math.max(...wrapped.map((w) => w?.length ?? 1));
  const labelExtent = rotate ? Math.ceil(maxLen * 5.6 * 0.58) + 6 : 12 * maxLines;
  const bottom = H - 26 - labelExtent;
  const top = 14;
  const sy = (v: number) => bottom - ((v - lo) / (hi - lo)) * (bottom - top);
  const cx = (i: number) => left + i * bw + bw / 2;
  const xLabel = (i: number) =>
    rotate ? (
      <text
        x={cx(i)}
        y={bottom + 10}
        fontSize="10"
        textAnchor="end"
        fill="var(--foreground)"
        transform={`rotate(-35 ${cx(i)} ${bottom + 10})`}
      >
        <title>{widget.data[i]!.label}</title>
        {labels[i]}
      </text>
    ) : (
      <text x={cx(i)} y={bottom + 14} fontSize="10" textAnchor="middle" fill="var(--foreground)">
        <title>{widget.data[i]!.label}</title>
        {(wrapped[i] ?? [labels[i]!]).map((line, k) => (
          <tspan key={k} x={cx(i)} dy={k === 0 ? 0 : 12}>
            {line}
          </tspan>
        ))}
      </text>
    );
  const valueLabel = (i: number) => {
    const v = widget.data[i]!.value;
    const below = v < 0;
    return (
      <text
        x={cx(i)}
        y={below ? sy(v) + 11 : sy(v) - 4}
        fontSize="10"
        fontWeight="600"
        textAnchor="middle"
        fill="var(--foreground)"
      >
        {formatNumber(v)}
      </text>
    );
  };
  return (
    <figure className="my-3 font-normal">
      <svg
        viewBox={`0 0 ${W} ${H}`}
        role="img"
        aria-label={`${widget.title || "Chart"}: ${widget.data.map((d) => `${d.label} ${d.value}`).join(", ")}`}
        className="w-full max-w-md bg-background"
      >
        {ticks.map((t, k) => (
          <g key={t}>
            <line
              x1={left}
              x2={W - right}
              y1={sy(t)}
              y2={sy(t)}
              stroke={t === 0 ? "var(--foreground)" : "var(--border)"}
            />
            <text
              x={left - 4}
              y={sy(t) + 3}
              fontSize="10"
              textAnchor="end"
              fill="var(--muted-foreground)"
            >
              {tickText[k]}
            </text>
          </g>
        ))}
        {widget.type === "bar" ? (
          widget.data.map((d, i) => (
            <g key={i}>
              <rect
                x={left + i * bw + bw * 0.15}
                y={Math.min(sy(d.value), sy(0))}
                width={bw * 0.7}
                height={Math.abs(sy(0) - sy(d.value))}
                fill="var(--primary)"
              />
              {valueLabel(i)}
              {xLabel(i)}
            </g>
          ))
        ) : (
          <g>
            <polyline
              fill="none"
              stroke="var(--primary)"
              strokeWidth="2"
              points={widget.data.map((d, i) => `${cx(i)},${sy(d.value)}`).join(" ")}
            />
            {widget.data.map((d, i) => (
              <g key={i}>
                <circle cx={cx(i)} cy={sy(d.value)} r="3.5" fill="var(--primary)" />
                {valueLabel(i)}
                {xLabel(i)}
              </g>
            ))}
          </g>
        )}
        <text
          x={(left + W) / 2}
          y={H - 4}
          fontSize="11"
          textAnchor="middle"
          fill="var(--foreground)"
        >
          {widget.xl}
        </text>
        <text
          x={10}
          y={(top + bottom) / 2}
          fontSize="11"
          textAnchor="middle"
          fill="var(--foreground)"
          transform={`rotate(-90 10 ${(top + bottom) / 2})`}
        >
          {widget.yl}
        </text>
      </svg>
      <table className="mt-1 w-full max-w-md border-collapse text-xs">
        <caption className="sr-only">{widget.title || "Chart"}: exact values</caption>
        <tbody>
          {widget.data.map((d, i) => (
            <tr key={i} className="border-t border-border">
              <th scope="row" className="py-0.5 pr-3 text-left font-normal break-words">
                {d.label}
              </th>
              <td className="py-0.5 text-right font-medium tabular-nums">
                {formatNumber(d.value)}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      {widget.title ? (
        <figcaption className="text-xs text-muted-foreground">{widget.title}</figcaption>
      ) : null}
    </figure>
  );
}

function PieChart({ widget }: { widget: Extract<Widget, { kind: "chart" }> }) {
  const total = widget.data.reduce((t, d) => t + d.value, 0) || 1;
  const nonZero = widget.data.filter((d) => d.value > 0).length;
  let a = -Math.PI / 2;
  return (
    <figure className="my-3 font-normal">
      <div className="flex flex-wrap items-center gap-x-6 gap-y-2">
        <svg
          viewBox="0 0 200 200"
          role="img"
          aria-label={`${widget.title || "Pie chart"}: ${widget.data.map((d) => `${d.label} ${d.value}`).join(", ")}`}
          className="w-full max-w-[200px]"
        >
          {widget.data.map((d, i) => {
            if (d.value <= 0) return null;
            if (nonZero === 1)
              return (
                <g key={i}>
                  <circle
                    cx="100"
                    cy="100"
                    r="90"
                    fill={sliceColor(i)}
                    stroke="var(--background)"
                  />
                  <text
                    x="100"
                    y="105"
                    fontSize="14"
                    fontWeight="600"
                    textAnchor="middle"
                    fill={sliceInk(i)}
                  >
                    {i + 1}
                  </text>
                </g>
              );
            const span = (d.value / total) * Math.PI * 2;
            const a2 = a + span;
            const large = a2 - a > Math.PI ? 1 : 0;
            const path = `M100 100 L${100 + 90 * Math.cos(a)} ${100 + 90 * Math.sin(a)} A90 90 0 ${large} 1 ${100 + 90 * Math.cos(a2)} ${100 + 90 * Math.sin(a2)} Z`;
            const mid = (a + a2) / 2;
            a = a2;
            return (
              <g key={i}>
                <path d={path} fill={sliceColor(i)} stroke="var(--background)" />
                {span > 0.3 ? (
                  <text
                    x={100 + 60 * Math.cos(mid)}
                    y={100 + 60 * Math.sin(mid) + 4}
                    fontSize="12"
                    fontWeight="600"
                    textAnchor="middle"
                    fill={sliceInk(i)}
                  >
                    {i + 1}
                  </text>
                ) : null}
              </g>
            );
          })}
        </svg>
        <ul className="grid min-w-0 flex-1 basis-40 gap-1 text-xs">
          {widget.data.map((d, i) => (
            <li key={i} className="flex min-w-0 items-start gap-2">
              <span
                aria-hidden="true"
                className="mt-0.5 inline-flex size-4 shrink-0 items-center justify-center text-[10px] font-semibold leading-none"
                style={{ background: sliceColor(i), color: sliceInk(i) }}
              >
                {i + 1}
              </span>
              <span className="min-w-0 break-words">
                {d.label}: {formatNumber(d.value)}
              </span>
            </li>
          ))}
        </ul>
      </div>
      {widget.title ? (
        <figcaption className="text-xs text-muted-foreground">{widget.title}</figcaption>
      ) : null}
    </figure>
  );
}
