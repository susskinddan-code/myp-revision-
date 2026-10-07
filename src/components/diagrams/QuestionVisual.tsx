/**
 * Hand-coded SVG visuals for questions. No charting library by design.
 * Shape of `visual`: { type: string, data: {...} }
 */

type ForceData = {
  object?: string;
  forces?: { name: string; magnitude: number; direction: "up" | "down" | "left" | "right" }[];
};

type GraphData = {
  xLabel?: string;
  yLabel?: string;
  points?: { x: number; y: number }[];
};

type TableData = { headers?: string[]; rows?: (string | number)[][] };

type ShapeData = { shape?: "triangle" | "circle" | "rectangle"; labels?: string[] };

type CircuitData = { components?: string[] };

export type QuestionVisualData =
  | { type: "force_diagram"; data: ForceData }
  | { type: "graph"; data: GraphData }
  | { type: "data_table"; data: TableData }
  | { type: "geometric_shape"; data: ShapeData }
  | { type: "circuit"; data: CircuitData };

const STROKE = "var(--foreground)";
const ACCENT = "var(--primary)";

function ForceDiagram({ data }: { data: ForceData }) {
  const forces = data.forces ?? [];
  const vectors: Record<string, [number, number]> = {
    up: [0, -70],
    down: [0, 70],
    left: [-80, 0],
    right: [80, 0],
  };
  return (
    <svg viewBox="0 0 320 220" role="img" aria-label="Force diagram" className="w-full max-w-sm">
      <rect x="130" y="85" width="60" height="50" rx="6" fill="var(--surface-2)" stroke={STROKE} />
      {forces.map((f, i) => {
        const [dx, dy] = vectors[f.direction] ?? [0, 0];
        return (
          <g key={i}>
            <line
              x1={160}
              y1={110}
              x2={160 + dx}
              y2={110 + dy}
              stroke={ACCENT}
              strokeWidth={3}
              markerEnd="url(#arrow)"
            />
            <text
              x={160 + dx * 1.25}
              y={110 + dy * 1.25}
              fontSize="12"
              textAnchor="middle"
              fill={STROKE}
            >
              {f.name} {f.magnitude} N
            </text>
          </g>
        );
      })}
      <defs>
        <marker id="arrow" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
          <path d="M0,0 L0,6 L7,3 z" fill={ACCENT} />
        </marker>
      </defs>
    </svg>
  );
}

function LineGraph({ data }: { data: GraphData }) {
  const points = data.points ?? [];
  const maxX = Math.max(1, ...points.map((p) => p.x));
  const maxY = Math.max(1, ...points.map((p) => p.y));
  const px = (x: number) => 40 + (x / maxX) * 240;
  const py = (y: number) => 180 - (y / maxY) * 150;
  return (
    <svg viewBox="0 0 320 220" role="img" aria-label="Line graph" className="w-full max-w-sm">
      <line x1="40" y1="180" x2="300" y2="180" stroke={STROKE} />
      <line x1="40" y1="20" x2="40" y2="180" stroke={STROKE} />
      <polyline
        fill="none"
        stroke={ACCENT}
        strokeWidth="3"
        points={points.map((p) => `${px(p.x)},${py(p.y)}`).join(" ")}
      />
      {points.map((p, i) => (
        <circle key={i} cx={px(p.x)} cy={py(p.y)} r="4" fill={ACCENT} />
      ))}
      <text x="170" y="210" fontSize="12" textAnchor="middle" fill={STROKE}>
        {data.xLabel ?? "x"}
      </text>
      <text x="14" y="100" fontSize="12" textAnchor="middle" fill={STROKE}>
        {data.yLabel ?? "y"}
      </text>
    </svg>
  );
}

function DataTable({ data }: { data: TableData }) {
  return (
    <table className="w-full max-w-sm border-collapse overflow-hidden rounded-md border border-border text-sm">
      <thead className="bg-surface-2">
        <tr>
          {(data.headers ?? []).map((h) => (
            <th key={h} className="border border-border px-3 py-2 text-left font-medium">
              {h}
            </th>
          ))}
        </tr>
      </thead>
      <tbody>
        {(data.rows ?? []).map((row, i) => (
          <tr key={i}>
            {row.map((cell, j) => (
              <td key={j} className="border border-border px-3 py-2">
                {cell}
              </td>
            ))}
          </tr>
        ))}
      </tbody>
    </table>
  );
}

function GeometricShape({ data }: { data: ShapeData }) {
  const labels = data.labels ?? [];
  return (
    <svg viewBox="0 0 220 200" role="img" aria-label="Geometric shape" className="w-full max-w-xs">
      {data.shape === "circle" ? (
        <circle cx="110" cy="100" r="70" fill="var(--surface-2)" stroke={STROKE} strokeWidth="2" />
      ) : data.shape === "rectangle" ? (
        <rect
          x="30"
          y="50"
          width="160"
          height="100"
          fill="var(--surface-2)"
          stroke={STROKE}
          strokeWidth="2"
        />
      ) : (
        <polygon
          points="110,25 195,170 25,170"
          fill="var(--surface-2)"
          stroke={STROKE}
          strokeWidth="2"
        />
      )}
      {labels.map((label, i) => (
        <text key={i} x={30 + i * 70} y={190} fontSize="12" fill={STROKE}>
          {label}
        </text>
      ))}
    </svg>
  );
}

function CircuitDiagram({ data }: { data: CircuitData }) {
  const items = data.components ?? ["cell", "lamp"];
  return (
    <svg viewBox="0 0 320 180" role="img" aria-label="Circuit diagram" className="w-full max-w-sm">
      <rect
        x="30"
        y="30"
        width="260"
        height="120"
        fill="none"
        stroke={STROKE}
        strokeWidth="2"
        rx="4"
      />
      <line x1="120" y1="30" x2="150" y2="30" stroke="var(--background)" strokeWidth="6" />
      <line x1="125" y1="18" x2="125" y2="42" stroke={STROKE} strokeWidth="3" />
      <line x1="145" y1="24" x2="145" y2="36" stroke={STROKE} strokeWidth="3" />
      <circle cx="160" cy="150" r="16" fill="var(--surface-2)" stroke={STROKE} strokeWidth="2" />
      <line x1="150" y1="140" x2="170" y2="160" stroke={STROKE} />
      <line x1="170" y1="140" x2="150" y2="160" stroke={STROKE} />
      <text x="160" y="12" fontSize="12" textAnchor="middle" fill={STROKE}>
        {items.join(" + ")}
      </text>
    </svg>
  );
}

export function QuestionVisual({ visual }: { visual: unknown }) {
  if (!visual || typeof visual !== "object") return null;
  const v = visual as QuestionVisualData;
  const wrap = (child: React.ReactNode) => (
    <div className="my-4 flex justify-center rounded-lg border border-border bg-card p-4">
      {child}
    </div>
  );

  switch (v.type) {
    case "force_diagram":
      return wrap(<ForceDiagram data={v.data ?? {}} />);
    case "graph":
      return wrap(<LineGraph data={v.data ?? {}} />);
    case "data_table":
      return wrap(<DataTable data={v.data ?? {}} />);
    case "geometric_shape":
      return wrap(<GeometricShape data={v.data ?? {}} />);
    case "circuit":
      return wrap(<CircuitDiagram data={v.data ?? {}} />);
    default:
      return null;
  }
}
