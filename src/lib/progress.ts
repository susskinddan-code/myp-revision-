import { computeStreak } from "@/lib/myp";

export type Attempt = {
  correct: boolean;
  created_at: string;
  subject_id: string | null;
  topic_id: string | null;
};

export const DAILY_GOAL = 10;

const dayKey = (d: Date | string) => new Date(d).toISOString().slice(0, 10);

/** XP: 10 for a correct answer, 4 for trying and missing, so effort always counts. */
export function xpFor(attempts: Attempt[]) {
  return attempts.reduce((t, a) => t + (a.correct ? 10 : 4), 0);
}

const LEVELS = [
  { at: 0, name: "Starter" },
  { at: 100, name: "Learner" },
  { at: 300, name: "Explorer" },
  { at: 700, name: "Scholar" },
  { at: 1400, name: "Specialist" },
  { at: 2500, name: "Expert" },
  { at: 4000, name: "Master" },
];

export function levelFor(xp: number) {
  let i = 0;
  while (i + 1 < LEVELS.length && xp >= LEVELS[i + 1]!.at) i++;
  const cur = LEVELS[i]!;
  const next = LEVELS[i + 1] ?? null;
  const pct = next ? (xp - cur.at) / (next.at - cur.at) : 1;
  return { index: i + 1, name: cur.name, next, pct, toNext: next ? next.at - xp : 0 };
}

export function todayCount(attempts: Attempt[]) {
  const today = dayKey(new Date());
  return attempts.filter((a) => dayKey(a.created_at) === today).length;
}

/** Last 7 days (oldest first) with question counts. */
export function lastSevenDays(attempts: Attempt[]) {
  const out: { label: string; count: number; today: boolean }[] = [];
  for (let i = 6; i >= 0; i--) {
    const d = new Date();
    d.setDate(d.getDate() - i);
    const key = dayKey(d);
    out.push({
      label: d.toLocaleDateString("en-GB", { weekday: "short" }).slice(0, 2),
      count: attempts.filter((a) => dayKey(a.created_at) === key).length,
      today: i === 0,
    });
  }
  return out;
}

export function streakOf(attempts: Attempt[]) {
  return computeStreak(attempts.map((a) => a.created_at));
}

export type Mastery = {
  total: number;
  correct: number;
  pct: number;
  status: "new" | "needs-work" | "getting-there" | "strong";
};

export function masteryOf(total: number, correct: number): Mastery {
  const pct = total ? correct / total : 0;
  const status =
    total < 3 ? "new" : pct < 0.6 ? "needs-work" : pct < 0.8 ? "getting-there" : "strong";
  return { total, correct, pct, status };
}

export const STATUS_LABEL: Record<Mastery["status"], string> = {
  new: "Not started",
  "needs-work": "Needs work",
  "getting-there": "Getting there",
  strong: "Strong",
};

export function encouragement(streakInRow: number, correct: boolean) {
  if (!correct) return "Good attempt. Read why, and you will get the next one.";
  if (streakInRow >= 5) return `${streakInRow} in a row. You are on fire.`;
  if (streakInRow >= 3) return `${streakInRow} in a row. Keep it going.`;
  return "Correct. Nice one.";
}
