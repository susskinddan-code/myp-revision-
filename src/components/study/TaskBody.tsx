import { useState } from "react";
import { Button } from "@/components/ui/button";
import { parseTaskBody, type Widget } from "@/lib/task-markup";

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
          className="mx-1 inline-block rounded-md border border-border bg-background px-2 py-1 text-sm font-normal outline-none focus:border-primary"
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
      return <DragTable widget={widget} onChange={onChange} disabled={disabled} />;
    case "plot":
      return <PlotGrid widget={widget} onChange={onChange} disabled={disabled} />;
    case "fill":
      return <FillTable widget={widget} onChange={onChange} disabled={disabled} />;
    case "chart":
      return <Chart widget={widget} />;
  }
}

/* ---------------------------- drag items into a table --------------------------- */

function DragTable({
  widget,
  onChange,
  disabled,
}: {
  widget: Extract<Widget, { kind: "drag" }>;
  onChange: (id: string, value: string) => void;
  disabled: boolean;
}) {
  const [placed, setPlaced] = useState<Record<string, string>>({});
  const [held, setHeld] = useState<string | null>(null);

  function commit(next: Record<string, string>) {
    setPlaced(next);
    onChange(
      widget.id,
      widget.slots
        .filter((s) => next[s])
        .map((s) => `${s} = ${next[s]}`)
        .join("; "),
    );
  }
  function place(slot: string, item: string) {
    if (disabled) return;
    const next = { ...placed };
    for (const k of Object.keys(next)) if (next[k] === item) delete next[k];
    next[slot] = item;
    commit(next);
    setHeld(null);
  }
  const used = new Set(Object.values(placed));
  return (
    <div className="my-3 rounded-md border border-border bg-surface-2 p-3 font-normal">
      <p className="mb-2 text-xs uppercase tracking-wide text-muted-foreground">
        Drag each item into the table, or click an item then a row
      </p>
      <div className="mb-3 flex flex-wrap gap-2">
        {widget.items.map((item) => (
          <button
            key={item}
            type="button"
            draggable={!disabled}
            disabled={disabled}
            onDragStart={(e) => e.dataTransfer.setData("text/plain", item)}
            onClick={() => setHeld(held === item ? null : item)}
            className={`rounded-full border px-3 py-1 text-sm ${
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
                {placed[slot] ?? <span className="text-muted-foreground">Drop here</span>}
                {placed[slot] && !disabled ? (
                  <button
                    type="button"
                    aria-label={`Remove ${placed[slot]}`}
                    className="ml-2 text-xs text-muted-foreground underline"
                    onClick={(e) => {
                      e.stopPropagation();
                      const next = { ...placed };
                      delete next[slot];
                      commit(next);
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
  onChange,
  disabled,
}: {
  widget: Extract<Widget, { kind: "plot" }>;
  onChange: (id: string, value: string) => void;
  disabled: boolean;
}) {
  const [points, setPoints] = useState<{ x: number; y: number }[]>([]);
  const [join, setJoin] = useState(false);
  const W = 420;
  const H = 300;
  const pad = 36;
  const sx = (x: number) =>
    pad + ((x - widget.xmin) / (widget.xmax - widget.xmin)) * (W - pad * 1.5);
  const sy = (y: number) =>
    H - pad - ((y - widget.ymin) / (widget.ymax - widget.ymin)) * (H - pad * 1.5);

  function commit(pts: { x: number; y: number }[], j: boolean) {
    setPoints(pts);
    setJoin(j);
    onChange(
      widget.id,
      pts.length
        ? `plotted ${pts.map((p) => `(${p.x}, ${p.y})`).join(", ")}${
            pts.length > 1 ? (j ? ", joined by straight lines" : ", not joined") : ""
          }`
        : "",
    );
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
    commit([...points, { x, y }], join);
  }
  const xs = Array.from({ length: widget.xmax - widget.xmin + 1 }, (_, i) => widget.xmin + i);
  const ys = Array.from({ length: widget.ymax - widget.ymin + 1 }, (_, i) => widget.ymin + i);
  const stepX = Math.max(1, Math.ceil(xs.length / 12));
  const stepY = Math.max(1, Math.ceil(ys.length / 10));
  return (
    <div className="my-3 rounded-md border border-border bg-surface-2 p-3 font-normal">
      <p className="mb-2 text-xs uppercase tracking-wide text-muted-foreground">
        Click the grid to plot a point
      </p>
      <svg
        viewBox={`0 0 ${W} ${H}`}
        role="img"
        aria-label={`Grid for plotting points. ${widget.xl} against ${widget.yl}`}
        onClick={click}
        className={`w-full max-w-md bg-background ${disabled ? "" : "cursor-crosshair"}`}
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
              onClick={() => commit(points.slice(0, -1), join)}
            >
              Undo
            </Button>
            <Button
              type="button"
              size="sm"
              variant="outline"
              className="rounded-full"
              onClick={() => commit([], false)}
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
  onChange,
  disabled,
}: {
  widget: Extract<Widget, { kind: "fill" }>;
  onChange: (id: string, value: string) => void;
  disabled: boolean;
}) {
  const [cells, setCells] = useState<string[][]>(() =>
    Array.from({ length: widget.rows }, () => widget.cols.map(() => "")),
  );
  function set(r: number, c: number, v: string) {
    const next = cells.map((row) => [...row]);
    next[r]![c] = v;
    setCells(next);
    const filled = next.some((row) => row.some(Boolean));
    onChange(
      widget.id,
      filled
        ? `table (${widget.cols.join(" | ")}): ${next.map((row) => row.map((x) => x || "-").join(" | ")).join(" / ")}`
        : "",
    );
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
                    className="w-full bg-background p-2 outline-none focus:bg-primary/5"
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

function Chart({ widget }: { widget: Extract<Widget, { kind: "chart" }> }) {
  const W = 420;
  const H = 260;
  const pad = 40;
  const max = Math.max(...widget.data.map((d) => d.value), 1);
  const top = Math.ceil(max * 1.1);
  const sy = (v: number) => H - pad - (v / top) * (H - pad * 1.6);
  const n = widget.data.length;
  const bw = (W - pad * 1.5) / n;
  const colors = [
    "var(--primary)",
    "var(--accent)",
    "var(--success)",
    "var(--warning)",
    "var(--destructive)",
    "var(--muted-foreground)",
  ];
  if (widget.type === "pie") {
    const total = widget.data.reduce((t, d) => t + d.value, 0) || 1;
    let a = -Math.PI / 2;
    return (
      <figure className="my-3 font-normal">
        <svg
          viewBox="0 0 320 200"
          role="img"
          aria-label={widget.title || "Pie chart"}
          className="w-full max-w-sm"
        >
          {widget.data.map((d, i) => {
            const a2 = a + (d.value / total) * Math.PI * 2;
            const large = a2 - a > Math.PI ? 1 : 0;
            const path = `M100 100 L${100 + 80 * Math.cos(a)} ${100 + 80 * Math.sin(a)} A80 80 0 ${large} 1 ${100 + 80 * Math.cos(a2)} ${100 + 80 * Math.sin(a2)} Z`;
            a = a2;
            return (
              <path
                key={d.label}
                d={path}
                fill={colors[i % colors.length]}
                stroke="var(--background)"
              />
            );
          })}
          {widget.data.map((d, i) => (
            <g key={d.label}>
              <rect
                x={210}
                y={30 + i * 20}
                width="10"
                height="10"
                fill={colors[i % colors.length]}
              />
              <text x={226} y={39 + i * 20} fontSize="11" fill="var(--foreground)">
                {d.label}: {d.value}
              </text>
            </g>
          ))}
        </svg>
        {widget.title ? (
          <figcaption className="text-xs text-muted-foreground">{widget.title}</figcaption>
        ) : null}
      </figure>
    );
  }
  return (
    <figure className="my-3 font-normal">
      <svg
        viewBox={`0 0 ${W} ${H}`}
        role="img"
        aria-label={widget.title || "Chart"}
        className="w-full max-w-md bg-background"
      >
        {[0, 0.25, 0.5, 0.75, 1].map((f) => (
          <g key={f}>
            <line x1={pad} x2={W - 10} y1={sy(top * f)} y2={sy(top * f)} stroke="var(--border)" />
            <text
              x={pad - 4}
              y={sy(top * f) + 3}
              fontSize="10"
              textAnchor="end"
              fill="var(--muted-foreground)"
            >
              {Math.round(top * f * 10) / 10}
            </text>
          </g>
        ))}
        {widget.type === "bar" ? (
          widget.data.map((d, i) => (
            <g key={d.label}>
              <rect
                x={pad + i * bw + bw * 0.15}
                y={sy(d.value)}
                width={bw * 0.7}
                height={H - pad - sy(d.value)}
                fill="var(--primary)"
              />
              <text
                x={pad + i * bw + bw / 2}
                y={H - pad + 14}
                fontSize="10"
                textAnchor="middle"
                fill="var(--foreground)"
              >
                {d.label}
              </text>
            </g>
          ))
        ) : (
          <g>
            <polyline
              fill="none"
              stroke="var(--primary)"
              strokeWidth="2"
              points={widget.data
                .map((d, i) => `${pad + i * bw + bw / 2},${sy(d.value)}`)
                .join(" ")}
            />
            {widget.data.map((d, i) => (
              <g key={d.label}>
                <circle cx={pad + i * bw + bw / 2} cy={sy(d.value)} r="3.5" fill="var(--primary)" />
                <text
                  x={pad + i * bw + bw / 2}
                  y={H - pad + 14}
                  fontSize="10"
                  textAnchor="middle"
                  fill="var(--foreground)"
                >
                  {d.label}
                </text>
              </g>
            ))}
          </g>
        )}
        <text x={W / 2} y={H - 4} fontSize="11" textAnchor="middle" fill="var(--foreground)">
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
      </svg>
      {widget.title ? (
        <figcaption className="text-xs text-muted-foreground">{widget.title}</figcaption>
      ) : null}
    </figure>
  );
}
