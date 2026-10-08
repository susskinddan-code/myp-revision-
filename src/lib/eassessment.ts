import { accuracyToMypLevel } from "@/lib/myp";

/**
 * MYP eAssessment (on-screen exams, sat at the end of MYP 5 / Grade 10).
 * Durations follow the IB's published session format; the IB sets the exact
 * date, session and boundaries each session, so those are always labelled as such.
 */
export type EArea = {
  key: string;
  name: string;
  minutes: number;
  /** Subject slugs students can sit within this area. */
  slugs: string[];
  blurb: string;
  looksLike: string[];
  /** Tailwind background token for the card accent. */
  bg: string;
};

export const EASSESSMENT_AREAS: EArea[] = [
  {
    key: "language-literature",
    name: "Language & Literature",
    minutes: 120,
    slugs: [
      "english-language-literature",
      "french-language-literature",
      "spanish-language-literature",
    ],
    blurb: "Read unseen texts, analyse how writers create meaning, and write a response.",
    looksLike: [
      "Unseen texts are shown on screen and you answer in your own words",
      "Marked on analysing, organising, producing text and using language (criteria A to D)",
      "Command terms such as analyse, explain and discuss decide how deep to go",
    ],
    bg: "bg-language-literature",
  },
  {
    key: "individuals-societies",
    name: "Individuals & Societies",
    minutes: 120,
    slugs: ["history", "geography", "economics"],
    blurb: "Work with sources and data, explain causes and effects, and build an argument.",
    looksLike: [
      "Source-based and case-study questions in your chosen discipline",
      "Marked on knowing and understanding, investigating, communicating and thinking critically (A to D)",
      "Evidence matters: name a source, quote or figure, then explain it",
    ],
    bg: "bg-individuals-societies",
  },
  {
    key: "sciences",
    name: "Sciences",
    minutes: 120,
    slugs: ["physics", "chemistry", "biology", "integrated-science", "environmental-systems"],
    blurb: "Apply scientific knowledge, read data and experiments, and explain what is happening.",
    looksLike: [
      "Questions on knowledge, experiment design, data and evaluating methods",
      "Marked on knowing and understanding, inquiring and designing, processing and evaluating (A to C)",
      "Units, labelled graphs and 'explain why' answers pick up the marks",
    ],
    bg: "bg-sciences",
  },
  {
    key: "mathematics",
    name: "Mathematics",
    minutes: 120,
    slugs: ["standard-mathematics", "extended-mathematics"],
    blurb: "Number, algebra, geometry, statistics and probability, in standard or extended form.",
    looksLike: [
      "Calculation and problem-solving questions, with and without context",
      "Marked on knowing and understanding, investigating patterns and communicating (A to C)",
      "Show every step, because method marks are real marks",
    ],
    bg: "bg-mathematics",
  },
  {
    key: "language-acquisition",
    name: "Language Acquisition",
    minutes: 105,
    slugs: ["french-ab-initio", "spanish-ab-initio", "mandarin-ab-initio"],
    blurb: "Reading and listening comprehension, plus writing, in your additional language.",
    looksLike: [
      "Shorter on-screen exam: 1 hour 45 minutes",
      "A separate teacher-run speaking assessment sits alongside it",
      "Read the whole task first, then answer in full sentences in the target language",
    ],
    bg: "bg-language-acquisition",
  },
  {
    key: "interdisciplinary",
    name: "Interdisciplinary Learning",
    minutes: 120,
    slugs: [],
    blurb: "Connect ideas from two subject groups to explain a real-world issue.",
    looksLike: [
      "Case-study style tasks that need ideas from two subject groups",
      "Marked on disciplinary grounding, synthesising and communicating",
      "Practice questions for this area are still being built",
    ],
    bg: "bg-tertiary",
  },
];

export function findArea(key: string) {
  return EASSESSMENT_AREAS.find((a) => a.key === key) ?? null;
}

export function formatDuration(minutes: number) {
  const h = Math.floor(minutes / 60);
  const m = minutes % 60;
  if (!h) return `${m} minutes`;
  return m
    ? `${h} hour${h > 1 ? "s" : ""} ${m} minutes`
    : `${h} hours`.replace("1 hours", "1 hour");
}

/**
 * Rough 1-7 estimate for the overall subject grade from a practice percentage.
 * Uses the standard MYP 32-point conversion (sum of four criteria, each 0-8).
 * The IB sets the real eAssessment boundaries every session, so this is only a guide.
 */
const BOUNDARIES: [number, number][] = [
  [28, 7],
  [24, 6],
  [19, 5],
  [15, 4],
  [10, 3],
  [6, 2],
  [1, 1],
];

export function estimateOverallGrade(fraction: number): number {
  const points = Math.round(Math.max(0, Math.min(1, fraction)) * 32);
  for (const [min, grade] of BOUNDARIES) if (points >= min) return grade;
  return 1;
}

/** Both scales, labelled, for any eAssessment-style result. */
export function describeResult(fraction: number) {
  return {
    criterionLevel: accuracyToMypLevel(fraction),
    overallGrade: estimateOverallGrade(fraction),
  };
}

/** First of May 2027 is used only as the start of the exam window for the countdown. */
export function daysToMaySession(now = new Date()): number {
  let year = now.getFullYear();
  let target = new Date(year, 4, 1);
  if (target.getTime() < now.getTime()) target = new Date(++year, 4, 1);
  return Math.ceil((target.getTime() - now.getTime()) / 86_400_000);
}

export const COMMAND_TERMS: { term: string; meaning: string }[] = [
  { term: "State / List / Name", meaning: "Give a short answer. No explanation needed." },
  { term: "Define", meaning: "Give the precise meaning of a word or idea." },
  { term: "Describe", meaning: "Say what something is like, including its key features." },
  { term: "Explain", meaning: "Give reasons or causes, using because / so / therefore." },
  { term: "Outline", meaning: "Give the main points briefly, without fine detail." },
  { term: "Identify", meaning: "Pick out the right answer from the information you have." },
  { term: "Calculate", meaning: "Work it out with numbers, showing your steps and units." },
  { term: "Compare", meaning: "Say how things are similar and different, side by side." },
  {
    term: "Analyse",
    meaning: "Break something into parts and show how they connect or why they matter.",
  },
  { term: "Discuss", meaning: "Give several viewpoints or points with supporting evidence." },
  { term: "Evaluate", meaning: "Weigh strengths and limits, then reach a justified judgement." },
  { term: "Justify", meaning: "Give valid reasons or evidence for a choice or answer." },
  { term: "Suggest", meaning: "Offer a sensible idea based on what you know." },
  {
    term: "To what extent",
    meaning: "Argue how far something is true and finish with a clear verdict.",
  },
];

export const EXAM_TIPS: { title: string; body: string }[] = [
  {
    title: "Read, then plan for two minutes",
    body: "Skim every question first. Mark the ones you can bank quickly and give the longer ones a time budget before you start.",
  },
  {
    title: "Let the command term set your answer",
    body: "'State' wants one line, 'explain' wants a reason, 'evaluate' wants a judgement. Matching the command term is the easiest way to avoid losing marks.",
  },
  {
    title: "Spend time by marks, not by mood",
    body: "Roughly one minute per mark is a safe pace. If a 2-mark question is eating five minutes, flag it and come back.",
  },
  {
    title: "Use evidence in every longer answer",
    body: "A figure, a quote, a source or a named example turns a general point into a marked point.",
  },
  {
    title: "Check units, labels and the question one last time",
    body: "Leave five minutes at the end. Most dropped marks are missing units, a missing second point, or answering a slightly different question.",
  },
  {
    title: "On-screen exam habits",
    body: "Practise typing longer answers and using on-screen tools, because you will not be writing by hand. Get comfortable with the timer on this site.",
  },
];
