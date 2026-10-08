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

export type AttemptWithSource = Attempt & { source?: string | null };

export type Badge = { key: string; name: string; hint: string; earned: boolean; progress: number };

/** Badges are derived from your answers, so they can never get out of sync. */
export function badgesFor(attempts: AttemptWithSource[]): Badge[] {
  const total = attempts.length;
  const correct = attempts.filter((a) => a.correct).length;
  const streak = streakOf(attempts);
  const subjects = new Set(attempts.map((a) => a.subject_id).filter(Boolean)).size;
  const papers = attempts.filter((a) => a.source === "practice-paper").length;
  const accuracy = total ? correct / total : 0;
  const mk = (key: string, name: string, hint: string, value: number, goal: number): Badge => ({
    key,
    name,
    hint,
    earned: value >= goal,
    progress: Math.min(1, value / goal),
  });
  return [
    mk("first", "First steps", "Answer your first question", total, 1),
    mk("ten", "Warming up", "Answer 10 questions", total, 10),
    mk("hundred", "Centurion", "Answer 100 questions", total, 100),
    mk("five-hundred", "Dedicated", "Answer 500 questions", total, 500),
    mk("streak3", "On a roll", "Study 3 days in a row", streak, 3),
    mk("streak7", "Week warrior", "Study 7 days in a row", streak, 7),
    mk("streak30", "Unstoppable", "Study 30 days in a row", streak, 30),
    mk("sharp", "Sharp shooter", "80% accuracy over 50+ answers", total >= 50 ? accuracy : 0, 0.8),
    mk("allrounder", "All-rounder", "Practise 5 different subjects", subjects, 5),
    mk("paper", "Exam ready", "Sit a written practice paper", papers, 1),
    mk("goal", "Goal getter", "Hit today's daily goal", todayCount(attempts), DAILY_GOAL),
  ];
}

/** Small seeded generator so the daily challenge is the same for everyone on the same day. */
export function seededRandom(seed: string) {
  let h = 1779033703 ^ seed.length;
  for (let i = 0; i < seed.length; i++) {
    h = Math.imul(h ^ seed.charCodeAt(i), 3432918353);
    h = (h << 13) | (h >>> 19);
  }
  return () => {
    h = Math.imul(h ^ (h >>> 16), 2246822507);
    h = Math.imul(h ^ (h >>> 13), 3266489909);
    h ^= h >>> 16;
    return (h >>> 0) / 4294967296;
  };
}

export const todayKey = () => new Date().toISOString().slice(0, 10);
