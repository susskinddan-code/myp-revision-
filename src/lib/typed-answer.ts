// Offline fallback for checking a typed answer when the AI checker is unavailable.

const KNOWN_UNITS = new Set([
  "mm",
  "cm",
  "m",
  "km",
  "mg",
  "g",
  "kg",
  "s",
  "min",
  "h",
  "ms",
  "n",
  "j",
  "kj",
  "w",
  "kw",
  "hz",
  "pa",
  "v",
  "a",
  "ma",
  "ohm",
  "mol",
  "ml",
  "l",
  "dm3",
  "cm3",
  "m3",
  "m2",
  "cm2",
  "mm2",
  "m/s",
  "m/s2",
  "km/h",
  "kg/m3",
  "g/cm3",
  "c",
  "k",
  "°c",
  "°",
  "%",
  "units",
  "unit",
]);

function textNorm(s: string) {
  return s
    .toLowerCase()
    .replace(/[\s]+/g, " ")
    .replace(/[.;:!]+$/, "")
    .trim();
}

type Quantity = { num: number; unit: string };

/** Parse "12.5 cm", "£1,200", "3/4", "-7" into a number and a unit (unit may be empty). */
function asQuantity(s: string): Quantity | null {
  const t = s
    .normalize("NFKC")
    .replace(/−/g, "-")
    .toLowerCase()
    .trim()
    .replace(/(\d),(?=\d{3}(\D|$))/g, "$1")
    .replace(/[£$€]/g, "")
    .replace(/\s+/g, " ")
    .replace(/[.;:]+$/, "");
  const frac = t.match(/^(-?\d+(?:\.\d+)?)\/(\d+(?:\.\d+)?)$/);
  if (frac && Number(frac[2]) !== 0) return { num: Number(frac[1]) / Number(frac[2]), unit: "" };
  const m = t.match(/^(-?\d*\.?\d+(?:e-?\d+)?)\s*([a-z°%µ²³/^0-9 ]*)$/);
  if (!m) return null;
  const unit = (m[2] ?? "")
    .replace(/\s+/g, "")
    .replace(/²/g, "2")
    .replace(/³/g, "3")
    .replace(/\^/g, "");
  return { num: Number(m[1]), unit };
}

function sameNumber(x: number, y: number) {
  return Math.abs(x - y) <= Math.abs(y) * 1e-9 + 1e-12;
}

function sameQuantity(student: string, correct: string): boolean | null {
  const a = asQuantity(student);
  const b = asQuantity(correct);
  if (!a || !b) return null; // not a pure quantity: caller compares as text
  if (!sameNumber(a.num, b.num)) return false;
  if (a.unit === b.unit) return true;
  // A missing unit is forgiven only when the stored answer's unit is a recognised physical unit.
  return a.unit === "" && KNOWN_UNITS.has(b.unit);
}

/** Strict match (same text or same quantity) used to skip the AI for plainly correct answers. */
export function exactMatch(student: string, correct: string): boolean {
  if (!student.trim()) return false;
  const q = sameQuantity(student, correct);
  if (q !== null) return q;
  return textNorm(student) === textNorm(correct);
}

const CHEM_SYMBOL = /^(?:[A-Z][a-z]?\d*|\([A-Za-z0-9]+\)\d*)+(?:\d*[+-])?$/;

/**
 * Cache key for an answer: NFKC, U+2212 mapped to '-', single spaces, no trailing punctuation.
 * Lower-cased, except short tokens (<= 3 chars, e.g. "Co" vs "CO", "N" vs "n") and chemical-looking
 * formulas, where case carries meaning. Never truncated: callers skip the cache for long answers.
 */
export function answerKey(answer: string): string {
  const t = answer
    .normalize("NFKC")
    .replace(/−/g, "-")
    .replace(/\s+/g, " ")
    .replace(/[.!?\s]+$/, "")
    .trim();
  if (t.length <= 3 || CHEM_SYMBOL.test(t)) return t;
  return t.toLowerCase();
}

const NEGATION =
  /\b(not|no|never|isn'?t|aren'?t|doesn'?t|don'?t|cannot|can'?t|won'?t|without|neither|nor)\b/;

/** Parenthetical glosses such as "十二 (shí'èr)" or "bonjour (hello)": ASCII and full-width brackets. */
const PARENS = /[(（][^()（）]*[)）]/g;

/**
 * Language-answer normal form: NFKC, curly quotes/apostrophes unified, guillemets and inverted marks dropped,
 * all sentence punctuation removed (so French "Où est la gare ?" == "Où est la gare"), single spaces, lower case.
 */
function langNorm(s: string): string {
  return s
    .normalize("NFKC")
    .replace(/[\u2018\u2019\u02bc`´]/g, "'")
    .replace(/[\u201c\u201d«»„]/g, "")
    .replace(/[.,;:!?¿¡。？！，、；：…\u2026"]/g, " ")
    .replace(/\s+/g, " ")
    .trim()
    .toLowerCase();
}

/** Accent- and tone-insensitive form, also ignoring apostrophes and spaces (pinyin syllable separators). */
function langLoose(s: string): string {
  return langNorm(s)
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .normalize("NFC")
    .replace(/['\s-]/g, "");
}

/**
 * Tone-number pinyin as typed on a plain keyboard ("ni3 hao3", "shi2'er4", "lv4", "ma5") reduced to letters,
 * so it can be compared with the accented stored form after accents are dropped.
 */
function toneNumbersOff(s: string): string {
  return s
    .normalize("NFKC")
    .replace(/v(?=[0-5])/gi, "u")
    .replace(/([a-z])[0-5](?!\d)/gi, "$1");
}

/** Forms the stored answer can be typed as: the whole text, the text without a gloss, and the gloss alone. */
function answerForms(correct: string): string[] {
  const forms = [correct];
  const glosses = [...correct.matchAll(PARENS)].map((m) => m[0].slice(1, -1));
  const bare = correct.replace(PARENS, " ").replace(/\s+/g, " ").trim();
  if (bare && bare !== correct) forms.push(bare);
  // A gloss is an alternative answer only for non-Latin text ("十二 (shí'èr)"), not a translation ("bonjour (hello)").
  if (/[\u3400-\u9fff]/.test(bare)) for (const g of glosses) if (g.trim()) forms.push(g);
  return forms;
}

/**
 * Offline check used only when the AI checker is unavailable (a miss is never counted against the student).
 * Accepted: exact text or quantity; the same text ignoring case, sentence punctuation and French spacing
 * ("Où est la gare ?" = "où est la gare"); either half of "hanzi (pinyin)" on its own or both together;
 * and, deliberately lenient offline, answers typed without accents or pinyin tones ("ou est la gare",
 * "shi'er", "shier") because many keyboards cannot type them. The AI checker, when available, instead
 * treats a missing accent in a language answer as half right.
 */
export function localCheck(student: string, correct: string): boolean {
  if (exactMatch(student, correct)) return true;
  if (asQuantity(student) && asQuantity(correct)) return false; // quantities must match exactly
  const forms = answerForms(correct);
  const sN = langNorm(student);
  const sL = langLoose(student);
  const sT = /[a-z][0-5](?!\d)/i.test(student) ? langLoose(toneNumbersOff(student)) : "";
  if (sL) {
    for (const f of forms) {
      if (sN === langNorm(f) || sL === langLoose(f)) return true;
      if (sT && sT === langLoose(f)) return true;
    }
    // Both parts typed in either order ("十二 shí'èr" / "shí'èr 十二").
    if (forms.length > 1) {
      const parts = forms.slice(1).map(langLoose).filter(Boolean);
      if (parts.length >= 2) {
        const [p0 = "", p1 = ""] = parts;
        const joined = [p0 + p1, p1 + p0];
        if (joined.includes(sL) || (sT && joined.includes(sT))) return true;
      }
    }
  }
  const a = textNorm(student);
  const b = textNorm(correct.replace(PARENS, " "));
  if (!a || b.length < 5) return false;
  if (NEGATION.test(a) && !NEGATION.test(b)) return false;
  // Accept a longer answer that contains the key phrase, but not a rambling list of guesses.
  return a.includes(b) && a.length <= b.length * 3 + 10;
}

export function localHint(attempt: number, topic: string, _explanation?: string | null): string {
  if (attempt <= 1)
    return `Not quite. Re-read the question and think about what you know on ${topic}.`;
  if (attempt === 2)
    return "Hint: think about the key idea behind this topic, then write the term or value that answers the question directly.";
  return "Still not there. Try writing out your working step by step, or use Show answer.";
}

const EXPLICIT_CHOICES =
  /\b(of|from|in|among) (the|these|those) (following|options|choices|list|statements|sentences|below)\b|\bwhich (one )?of (these|those|them)\b|\b(options?|choices?)\b|\bwhich one\b|\bwhich (?:is|are|was|were|would|could|might|did)\b/i;
// "Which sentence/pair/spelling ..." can only be answered by picking from candidates.
const CANDIDATE_NOUN =
  /\bwhich (?:\w+ ){0,2}?(?:sentence|statement|description|sequence|list|order|explanation|reason|conclusion|analysis|summary|approach|response|phrase|option|word|term|pair|spelling|combination|version|form|criterion|question|greeting|expression|verb form)\b/i;
// "Which is the best/correct ..." and "Which ... is most effective" are judgements between candidates.
const JUDGEMENT =
  /\bwhich\b[^?.]*\b(?:best|correct|incorrect|valid|true|false|accurate|appropriate|suitable|odd one|(?:most|least) (?:effective|likely|appropriate|suitable|useful|convincing|reliable|helpful|accurate|reasonable|plausible))\b|\b(?:best|most suitable) (?:description|summary|explanation|reason|conclusion|answer|example|response|reply|criticism|comment|conclusion|interpretation|evaluation)\b|\bfairest (?:comment|description|conclusion|judgement)\b/i;

// Imperative picking verbs at the start of the stem ("Select the...", "Choose the...").
const PICK_IMPERATIVE = /^\s*(?:select|choose|pick|identify the (?:correct|best|odd|incorrect))\b/i;
// An interrogative "which" at the start of a clause (not a relative clause such as "a process which ...").
const WHICH_QUESTION =
  /\b(?:quel(?:le)?s?|lequel|laquelle|lesquel(?:le)?s|cu[aá]l(?:es)?)\b|(?:^|[.?!;:]\s+|,\s+)(?:\w+ ){0,2}?which\b|^\W*(?:in|for|during|after|before|when|if|given|using)\b[^?]*\bwhich\b/i;

/** A stored answer a student could plausibly type from memory: a term, number or short phrase. */
function isRecallable(answer: string): boolean {
  const t = answer.trim();
  const words = t.split(/\s+/).filter(Boolean).length;
  return t.length <= 30 && words <= 4;
}

/**
 * Should the multiple-choice options be listed (read-only) under a typed-answer question? Only when the
 * stem asks the student to pick among candidates AND the typed answer would otherwise be unguessable:
 *  - explicit references to given candidates ("Which of these...", "Which sentence is correct?", "Which is
 *    the best...") or an imperative "Select/Choose ..." always show them;
 *  - any other interrogative "Which ..." shows them when the stored answer is a long phrase or sentence
 *    (e.g. "Which goal is the most SMART?"), because no student could reproduce that wording unseen.
 *    "Which hormone ...?" -> "adrenaline" stays a typed recall question.
 * "natural selection", "selective" or "chooses" never trigger it, nor do plain recall stems.
 * `answer` is the stored correct answer text; omit it to use only the stem-based rules.
 */
export function stemNeedsOptions(stem: string, answer?: string): boolean {
  if (EXPLICIT_CHOICES.test(stem) || CANDIDATE_NOUN.test(stem) || JUDGEMENT.test(stem)) return true;
  if (PICK_IMPERATIVE.test(stem)) return true;
  return answer !== undefined && WHICH_QUESTION.test(stem) && !isRecallable(answer);
}
