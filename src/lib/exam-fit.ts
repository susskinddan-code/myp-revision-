// Keeps a sitting inside the minutes it was sold as ("Half paper 60 min" must never run 65).

/** Honest sitting time: 1.2 minutes per mark (the same rate the AI writer and the result page use). */
export const MINUTES_PER_MARK = 1.2;

type Fittable = { content: string; mark_scheme: string | null; position: number };

/** Marks a mark scheme offers: the sum of its "[n]" tags. */
export function schemeMarks(markScheme: string | null | undefined): number {
  let total = 0;
  for (const m of (markScheme ?? "").matchAll(/\[(\d+)\]/g)) total += Number(m[1]);
  return total;
}

/** Sitting minutes for a set of tasks (never below 5), rounded up so the stated time is never short. */
export function minutesFor(tasks: { mark_scheme: string | null }[]): number {
  const marks = tasks.reduce((t, q) => t + schemeMarks(q.mark_scheme), 0);
  return marks ? Math.max(5, Math.ceil(marks * MINUTES_PER_MARK - 1e-9)) : 0;
}

/**
 * Trims a task list so `minutesFor(result) <= minutes`. Tasks keep their order; one that would overflow is
 * skipped and later, smaller ones may still fit. At least one task is always kept. Tasks are renumbered
 * ("[[Q 3 | A 4]]" -> "[[Task 2 | A 4]]") so the headings stay consecutive.
 */
export function fitToMinutes<T extends Fittable>(tasks: T[], minutes: number): T[] {
  const budget = Math.floor((minutes + 1e-9) / MINUTES_PER_MARK);
  const kept: T[] = [];
  let sum = 0;
  for (const t of tasks) {
    const m = schemeMarks(t.mark_scheme);
    if (sum + m > budget) continue;
    kept.push(t);
    sum += m;
  }
  // Nothing fits: keep the shortest task rather than none (the sitting clock is still capped by the caller).
  const shortest = [...tasks].sort(
    (a, b) => (schemeMarks(a.mark_scheme) || 1e9) - (schemeMarks(b.mark_scheme) || 1e9),
  )[0];
  const out = kept.length ? kept : shortest ? [shortest] : [];
  return out.map((t, i) => ({
    ...t,
    position: i + 1,
    content: t.content.replace(/^(\s*\[\[)\s*[^|\]]+?\s*(\||\]\])/, `$1Task ${i + 1} $2`),
  }));
}
