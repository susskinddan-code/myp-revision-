import { accuracyToMypLevel } from "@/lib/myp";

/**
 * MYP eAssessment (on-screen exams, sat in the final year of the MYP / MYP 5 / Grade 10).
 * Facts here follow the IB's public pages (ibo.org "On-screen examinations", the MYP subject
 * briefs and the MYP awards brief); see content/review/eassessment-format-research.md for
 * sources. The IB publicly states "2-hour" on-screen exams in one place and "between 1 hour
 * 45 minutes and 2 hours" in another, so every area uses 120 minutes as the safe full length.
 * Sessions run in May or November (school's choice). The IB sets the exact dates and grade
 * boundaries each session, so those are always labelled as such. Task structures below are
 * taken from the IB's published blueprints and can change, so wording stays cautious.
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
      "english-language-and-literature",
      "french-language-and-literature",
      "spanish-language-and-literature",
    ],
    blurb:
      "Analyse and compare text extracts shown on screen, then write a piece of your own. Criteria: analysing, organizing, producing text, using language.",
    looksLike: [
      "A 2-hour on-screen exam, usually in two tasks: an analysis task on two extracts, then a longer creative writing task (the analysis task carries fewer marks than the writing task)",
      "Criteria assessed: A Analysing, B Organizing, C Producing text, D Using language",
      "You type your answers. Accuracy of language and clear organisation are marked in both tasks",
    ],
    bg: "bg-language-literature",
  },
  {
    key: "individuals-societies",
    name: "Individuals & Societies",
    minutes: 120,
    slugs: ["history", "geography", "economics"],
    blurb:
      "Work with written and rich-media sources, answer investigation questions, then write an extended response in History, Geography or Integrated humanities.",
    looksLike: [
      "A 2-hour on-screen exam, usually in three tasks: engaging with sources, an investigation with structured questions, and an extended response (the extended response is worth the most marks)",
      "Criteria assessed: A Knowing and understanding, B Investigating, C Communicating, D Thinking critically",
      "Source tasks reward judging origin, purpose, value and limitations, and spotting counter-claims. Name the source, then explain it",
    ],
    bg: "bg-individuals-societies",
  },
  {
    key: "sciences",
    name: "Sciences",
    minutes: 120,
    slugs: ["physics", "chemistry", "biology", "integrated-science", "environmental-systems"],
    blurb:
      "Show scientific knowledge, plan and evaluate investigations with data, and apply science to real-life issues.",
    looksLike: [
      "A 2-hour on-screen exam in three tasks: knowing and understanding (about a quarter of the marks), investigation skills (about half) and applying science (about a quarter)",
      "Criteria assessed: A Knowing and understanding, B Inquiring and designing, C Processing and evaluating, D Reflecting on the impacts of science",
      "Investigation tasks ask you to form hypotheses, plan methods, handle and interpret data and evaluate. Units, labelled graphs and 'explain why' answers pick up marks",
    ],
    bg: "bg-sciences",
  },
  {
    key: "mathematics",
    name: "Mathematics",
    minutes: 120,
    slugs: ["standard-mathematics", "extended-mathematics"],
    blurb:
      "Know and use methods, investigate patterns, and apply mathematics to real-life situations, in standard or extended form.",
    looksLike: [
      "A 2-hour on-screen exam in three tasks: knowing and understanding, investigating patterns, and applying mathematics in real-life contexts (each task is worth roughly a third of the marks)",
      "Criteria assessed: A Knowing and understanding, B Investigating patterns, C Communicating, D Applying mathematics in real-life contexts. Communicating is marked across all three tasks",
      "The IB lists an on-screen graphing calculator among the exam tools. Show every step and state your reasoning, because communication is marked throughout",
    ],
    bg: "bg-mathematics",
  },
  {
    key: "language-acquisition",
    name: "Language Acquisition",
    minutes: 120,
    slugs: ["french-ab-initio", "spanish-ab-initio", "mandarin-ab-initio"],
    blurb:
      "Listening, reading and writing tasks on multimedia texts in your additional language. Speaking is assessed separately by your teacher.",
    looksLike: [
      "An on-screen exam of up to 2 hours (the IB gives a range of 1 hour 45 minutes to 2 hours), usually in three tasks: listening, reading and writing",
      "Criteria: A Listening, B Reading, D Writing are in the on-screen exam. C Speaking is a separate interactive task marked by your teacher and moderated by the IB",
      "The IB offers on-screen Language Acquisition exams for certain phases and levels only, so check with your school which one applies to you. The ab initio practice on this site mirrors the format: read the whole task first, then answer in full sentences in the target language",
    ],
    bg: "bg-language-acquisition",
  },
  {
    key: "interdisciplinary",
    name: "Interdisciplinary Learning",
    minutes: 120,
    slugs: ["interdisciplinary-learning"],
    blurb:
      "Use stimulus material to evaluate and synthesise ideas from two subject groups about a real-world issue.",
    looksLike: [
      "A 2-hour on-screen exam in two tasks, using stimulus such as infographics, data, videos and articles",
      "Two disciplines are chosen from Language and literature, Individuals and societies, Mathematics and Sciences",
      "Criteria assessed: A Evaluating, B Synthesizing, C Reflecting. It is reported separately from your subject grades",
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
 * Uses the standard MYP 32-point conversion (sum of four criteria, each 0-8), the same scale
 * schools use for internal assessment. The IB says on-screen exam boundaries are set from
 * raw marks each session, so this is only a guide and is never a prediction.
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

/**
 * 1 May is used only as a rough start of the May window for the countdown. Sessions run in
 * May or November (the school chooses) and the IB sets exact dates, so check with your coordinator.
 */
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
    body: "Plan on about one to one and a quarter minutes per mark (a guide, not an IB rule). If a 2-mark question is eating five minutes, flag it and come back.",
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
    body: "The IB exam is taken on a computer. Practise typing longer answers and using on-screen tools such as drag and drop, copy and paste, graph plotting and drawing, an on-screen graphing calculator in maths, and play, pause and replay for video. Get comfortable with the timer on this site.",
  },
];

export type FormulaGroup = { title: string; lines: string[] };

const MATHS_FORMULAS: FormulaGroup[] = [
  {
    title: "Number and algebra",
    lines: [
      "Percentage change = (new − original) ÷ original × 100",
      "Percentage error = |measured − actual| ÷ actual × 100",
      "Compound interest: A = P(1 + r/100)ⁿ",
      "Standard form: a × 10ᵏ, where 1 ≤ a < 10",
      "Quadratic formula: x = (−b ± √(b² − 4ac)) ÷ 2a",
      "Arithmetic sequence: uₙ = a + (n − 1)d",
      "Gradient: m = (y₂ − y₁) ÷ (x₂ − x₁); line: y = mx + c",
    ],
  },
  {
    title: "Geometry and trigonometry",
    lines: [
      "Pythagoras: a² + b² = c²",
      "sin θ = opp ÷ hyp, cos θ = adj ÷ hyp, tan θ = opp ÷ adj",
      "Sine rule: a ÷ sin A = b ÷ sin B",
      "Cosine rule: a² = b² + c² − 2bc cos A",
      "Area of a triangle = ½ab sin C",
      "Circle: C = 2πr, A = πr²; arc = θ/360 × 2πr; sector = θ/360 × πr²",
      "Prism: V = base area × height; cylinder: V = πr²h",
      "Pyramid and cone: V = ⅓ × base area × height; sphere: V = 4/3 πr³, S = 4πr²",
      "Cylinder curved surface = 2πrh; cone curved surface = πrl",
    ],
  },
  {
    title: "Statistics and probability",
    lines: [
      "Mean = sum of values ÷ number of values",
      "P(A or B) = P(A) + P(B) − P(A and B)",
      "Independent events: P(A and B) = P(A) × P(B)",
      "Conditional probability: P(A | B) = P(A and B) ÷ P(B)",
      "Frequency density = frequency ÷ class width",
    ],
  },
];

const SCIENCE_FORMULAS: FormulaGroup[] = [
  {
    title: "Physics",
    lines: [
      "speed = distance ÷ time; acceleration = change in velocity ÷ time",
      "v = u + at; v² = u² + 2as; s = ut + ½at²",
      "force = mass × acceleration (F = ma); weight = mass × g (g = 10 N/kg)",
      "work done = force × distance; power = energy ÷ time",
      "KE = ½mv²; GPE = mgh",
      "pressure = force ÷ area; density = mass ÷ volume",
      "V = IR; P = VI; E = Pt; Q = It",
      "wave speed = frequency × wavelength",
      "Q = mcΔT",
    ],
  },
  {
    title: "Chemistry",
    lines: [
      "moles = mass ÷ molar mass (n = m ÷ M)",
      "concentration (mol/dm³) = moles ÷ volume (dm³)",
      "gas volume at room temperature and pressure = moles × 24 dm³",
      "percentage yield = actual yield ÷ theoretical yield × 100",
      "percentage by mass of an element = (Ar × atoms) ÷ Mr × 100",
      "ΔH = energy to break bonds − energy released making bonds",
      "Rf = distance moved by spot ÷ distance moved by solvent",
      "rate = change in amount ÷ time",
    ],
  },
  {
    title: "Biology and data",
    lines: [
      "magnification = image size ÷ actual size",
      "percentage change = (new − original) ÷ original × 100",
      "mean = total ÷ number of readings; ignore anomalies",
      "percentage error = |measured − accepted| ÷ accepted × 100",
    ],
  },
];

/** On-screen formula reference shown in exam mode (a reminder sheet, not a substitute for revision). */
export function formulaSheetFor(areaKey: string): FormulaGroup[] | null {
  if (areaKey === "mathematics") return MATHS_FORMULAS;
  if (areaKey === "sciences") return SCIENCE_FORMULAS;
  return null;
}
