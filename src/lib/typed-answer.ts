// Offline fallback for checking a typed answer when the AI checker is unavailable.

function norm(s: string) {
  return s
    .toLowerCase()
    .replace(/[£$€°%]/g, "")
    .replace(/\b(cm|mm|km|m|kg|g|s|n|j|w|hz|mol|ml|l|units?)\b\^?\d*/g, "")
    .replace(/[\s,]/g, "")
    .replace(/[.;:]+$/, "");
}

function asNumber(s: string): number | null {
  const t = s.replace(/[£$€°%\s,]/g, "");
  const frac = t.match(/^(-?\d+(?:\.\d+)?)\/(\d+(?:\.\d+)?)$/);
  if (frac) return Number(frac[1]) / Number(frac[2]);
  const n = Number(t.replace(/[a-z²³]+$/i, ""));
  return Number.isFinite(n) && /\d/.test(t) ? n : null;
}

export function localCheck(student: string, correct: string): boolean {
  const a = norm(student);
  const b = norm(correct);
  if (!a) return false;
  if (a === b) return true;
  const na = asNumber(student);
  const nb = asNumber(correct);
  if (na !== null && nb !== null) return Math.abs(na - nb) <= Math.abs(nb) * 0.005 + 1e-9;
  if (b.length >= 5 && a.includes(b)) return true;
  return false;
}

export function localHint(attempt: number, topic: string, explanation?: string | null): string {
  if (attempt <= 1)
    return `Not quite. Re-read the question and think about what you know on ${topic}.`;
  const first = explanation?.split(/(?<=[.!?])\s/)[0];
  if (attempt === 2 && first) return `Hint: ${first}`;
  return "Still not there. Try writing out your working step by step, or use Show answer.";
}
