import { supabase } from "@/integrations/supabase/client";
import type { Tables } from "@/integrations/supabase/types";

export type Subject = Tables<"subjects">;
export type Topic = Tables<"topics">;
export type Question = Tables<"questions">;
export type Flashcard = Tables<"flashcards">;
export type Note = Tables<"notes">;

export const GRADES = [1, 2, 3, 4, 5] as const;

export const GROUP_ORDER = [
  "Sciences",
  "Mathematics",
  "Language & Literature",
  "Language Acquisition",
  "Individuals & Societies",
  "Arts",
  "Design",
  "Physical & Health Education",
] as const;

/** Background colour per subject group, from the design tokens. */
export const GROUP_BG: Record<string, string> = {
  sciences: "bg-sciences",
  mathematics: "bg-mathematics",
  "language-literature": "bg-language-literature",
  "language-acquisition": "bg-language-acquisition",
  "individuals-societies": "bg-individuals-societies",
  arts: "bg-arts",
  design: "bg-design",
  "physical-health": "bg-physical-health",
};

/** MYP reports achievement on Levels 1-8 (never 1-7, that is the Diploma Programme). */
export const MYP_MAX_LEVEL = 8;

export function accuracyToMypLevel(accuracy: number): number {
  if (accuracy >= 0.95) return 8;
  if (accuracy >= 0.87) return 7;
  if (accuracy >= 0.78) return 6;
  if (accuracy >= 0.68) return 5;
  if (accuracy >= 0.56) return 4;
  if (accuracy >= 0.44) return 3;
  if (accuracy >= 0.28) return 2;
  return 1;
}

export const MYP_LEVEL_LABELS: Record<number, string> = {
  1: "Very limited",
  2: "Limited",
  3: "Adequate (lower)",
  4: "Adequate",
  5: "Good",
  6: "Very good",
  7: "Excellent",
  8: "Outstanding",
};

export async function fetchSubjects(grade: number) {
  const { data, error } = await supabase
    .from("subjects")
    .select("*")
    .contains("grades", [grade])
    .order("position");
  if (error) throw error;
  return data;
}

export async function fetchSubjectBySlug(slug: string) {
  const { data, error } = await supabase
    .from("subjects")
    .select("*")
    .eq("slug", slug)
    .maybeSingle();
  if (error) throw error;
  return data;
}

/** Top-level topics only; sub-topics are fetched separately. */
export async function fetchTopics(subjectId: string, grade: number) {
  const { data, error } = await supabase
    .from("topics")
    .select("*")
    .eq("subject_id", subjectId)
    .eq("grade", grade)
    .is("parent_topic_id", null)
    .order("position");
  if (error) throw error;
  return data;
}

/** Focused sub-topics belonging to a topic, in order. */
export async function fetchSubTopics(parentTopicId: string) {
  const { data, error } = await supabase
    .from("topics")
    .select("*")
    .eq("parent_topic_id", parentTopicId)
    .order("position");
  if (error) throw error;
  return data;
}

export async function fetchQuestions(topicId: string) {
  const { data, error } = await supabase
    .from("questions")
    .select("*")
    .eq("topic_id", topicId)
    .eq("type", "MCQ")
    .order("created_at");
  if (error) throw error;
  return data;
}

/** MCQs across a topic and (optionally) its sub-topics. */
export async function fetchQuestionsForTopics(topicIds: string[]) {
  if (!topicIds.length) return [];
  const { data, error } = await supabase
    .from("questions")
    .select("*")
    .in("topic_id", topicIds)
    .eq("type", "MCQ")
    .order("created_at");
  if (error) throw error;
  return data;
}

/** Flashcards for a topic and (optionally) its sub-topics. */
export async function fetchFlashcardsForTopics(topicIds: string[]) {
  if (!topicIds.length) return [];
  const { data, error } = await supabase.from("flashcards").select("*").in("topic_id", topicIds);
  if (error) throw error;
  return data;
}

/** The first note found for a topic or its sub-topics. */
export async function fetchNoteForTopics(topicIds: string[]) {
  if (!topicIds.length) return null;
  const { data, error } = await supabase
    .from("notes")
    .select("*")
    .in("topic_id", topicIds)
    .limit(1);
  if (error) throw error;
  return data?.[0] ?? null;
}

/**
 * Practice paper questions that look relevant to a topic: paper questions in
 * this subject/grade whose text mentions a distinctive word from the topic name.
 */
export async function fetchRelatedPaperQuestions(
  subjectId: string,
  grade: number,
  topicName: string,
) {
  const stop = new Set([
    "and",
    "the",
    "of",
    "in",
    "on",
    "to",
    "a",
    "an",
    "for",
    "with",
    "vs",
    "its",
    "introduction",
    "properties",
    "calculations",
    "diagrams",
    "types",
  ]);
  const words = topicName
    .toLowerCase()
    .replace(/[^a-z0-9\s'-]/g, " ")
    .split(/\s+/)
    .filter((w) => w.length > 3 && !stop.has(w));
  if (!words.length) return [];
  const filter = words.map((w) => `content.ilike.%${w}%`).join(",");
  const { data, error } = await supabase
    .from("paper_questions")
    .select("id, content, mark_scheme, criterion, past_papers!inner(title, subject_id, grade)")
    .eq("past_papers.subject_id", subjectId)
    .eq("past_papers.grade", grade)
    .or(filter)
    .limit(8);
  if (error) throw error;
  return data ?? [];
}

export async function fetchFlashcards(subjectId: string, grade: number) {
  const { data, error } = await supabase
    .from("flashcards")
    .select("*")
    .eq("subject_id", subjectId)
    .eq("grade", grade);
  if (error) throw error;
  return data;
}

export async function fetchNote(topicId: string) {
  const { data, error } = await supabase
    .from("notes")
    .select("*")
    .eq("topic_id", topicId)
    .maybeSingle();
  if (error) throw error;
  return data;
}

/**
 * Ids that should carry a "Note available" badge for a subject/grade: every
 * topic that has its own note, plus every parent topic that has a note in any
 * of its sub-topics (so parents don't look empty when only children have notes).
 */
export async function fetchNoteBadgeIds(subjectId: string, grade: number) {
  const { data, error } = await supabase
    .from("notes")
    .select("topic_id, topics!inner(parent_topic_id, subject_id, grade)")
    .eq("topics.subject_id", subjectId)
    .eq("topics.grade", grade);
  if (error) throw error;
  const ids = new Set<string>();
  for (const row of data ?? []) {
    ids.add(row.topic_id as string);
    const parent = (row.topics as { parent_topic_id: string | null } | null)?.parent_topic_id;
    if (parent) ids.add(parent);
  }
  return [...ids];
}

export async function fetchPapers(subjectId: string, grade: number) {
  const { data, error } = await supabase
    .from("past_papers")
    .select("id, title, grade, year, criterion, paper_questions(count)")
    .eq("subject_id", subjectId)
    .eq("grade", grade);
  if (error) throw error;
  // A paper is only shown when it actually has questions attached.
  return (data ?? []).filter((p) => (p.paper_questions?.[0]?.count ?? 0) > 0);
}

export type PaperQuestion = Tables<"paper_questions">;

export async function fetchPaperQuestions(paperId: string) {
  const { data, error } = await supabase
    .from("paper_questions")
    .select("*")
    .eq("paper_id", paperId)
    .order("position");
  if (error) throw error;
  return data;
}

export type AttemptInput = {
  questionId?: string | null;
  topicId?: string | null;
  subjectId?: string | null;
  source: "question-bank" | "practice-paper" | "flashcards";
  correct: boolean;
};

export async function recordAttempt(userId: string, input: AttemptInput) {
  const { error } = await supabase.from("question_attempts").insert({
    user_id: userId,
    question_id: input.questionId ?? null,
    topic_id: input.topicId ?? null,
    subject_id: input.subjectId ?? null,
    source: input.source,
    correct: input.correct,
  });
  if (error) throw error;
}

export async function fetchAttempts(userId: string) {
  const { data, error } = await supabase
    .from("question_attempts")
    .select("id, correct, source, created_at, subject_id, topic_id")
    .eq("user_id", userId)
    .order("created_at", { ascending: false })
    .limit(500);
  if (error) throw error;
  return data;
}

export async function fetchProfile(userId: string) {
  const { data, error } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", userId)
    .maybeSingle();
  if (error) throw error;
  return data;
}

/** Consecutive days (ending today or yesterday) with at least one attempt. */
export function computeStreak(dates: string[]): number {
  const days = new Set(dates.map((d) => new Date(d).toISOString().slice(0, 10)));
  if (days.size === 0) return 0;
  const today = new Date();
  const key = (d: Date) => d.toISOString().slice(0, 10);
  const cursor = new Date(today);
  if (!days.has(key(cursor))) {
    cursor.setDate(cursor.getDate() - 1);
    if (!days.has(key(cursor))) return 0;
  }
  let streak = 0;
  while (days.has(key(cursor))) {
    streak += 1;
    cursor.setDate(cursor.getDate() - 1);
  }
  return streak;
}

/** Subjects by slug list (for eAssessment areas). Only those offered at the grade are returned. */
export async function fetchSubjectsBySlugs(slugs: string[], grade: number) {
  if (!slugs.length) return [];
  const { data, error } = await supabase
    .from("subjects")
    .select("*")
    .in("slug", slugs)
    .contains("grades", [grade])
    .order("position");
  if (error) throw error;
  return data;
}

/** Every topic and sub-topic for a subject at a grade (used for mastery roll-ups). */
export async function fetchAllTopics(subjectId: string, grade: number) {
  const { data, error } = await supabase
    .from("topics")
    .select("id, name, parent_topic_id, position")
    .eq("subject_id", subjectId)
    .eq("grade", grade)
    .order("position");
  if (error) throw error;
  return data;
}

/** A random-ish mixed set of MCQs across a whole subject at one grade. */
export async function fetchMixedQuestions(subjectId: string, grade: number, count: number) {
  const { data, error } = await supabase
    .from("questions")
    .select("*")
    .eq("subject_id", subjectId)
    .eq("grade", grade)
    .eq("type", "MCQ")
    .limit(1000);
  if (error) throw error;
  const pool = [...(data ?? [])];
  for (let i = pool.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [pool[i], pool[j]] = [pool[j]!, pool[i]!];
  }
  return pool.slice(0, count);
}

export function shuffle<T>(list: T[]): T[] {
  const pool = [...list];
  for (let i = pool.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [pool[i], pool[j]] = [pool[j]!, pool[i]!];
  }
  return pool;
}

/**
 * The daily challenge: today's "subject of the day" at the student's grade and ten
 * questions from it. Same for everyone on the same day.
 */
export async function fetchDailyChallenge(grade: number, rand: () => number) {
  const subjects = await fetchSubjects(grade);
  if (!subjects.length) return { subject: null, questions: [] as Question[] };
  const subject = subjects[Math.floor(rand() * subjects.length)]!;
  const { data, error } = await supabase
    .from("questions")
    .select("*")
    .eq("subject_id", subject.id)
    .eq("grade", grade)
    .eq("type", "MCQ")
    .limit(1000);
  if (error) throw error;
  const pool = [...(data ?? [])];
  for (let i = pool.length - 1; i > 0; i--) {
    const j = Math.floor(rand() * (i + 1));
    [pool[i], pool[j]] = [pool[j]!, pool[i]!];
  }
  return { subject, questions: pool.slice(0, 10) };
}
