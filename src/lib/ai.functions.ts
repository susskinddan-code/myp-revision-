import { createServerFn } from "@tanstack/react-start";
import { z } from "zod";
import { claudeJson, claudeText } from "./anthropic.server";
import { adminClient } from "./supabase-admin.server";
import { answerKey, exactMatch } from "./typed-answer";
import { parseTaskBody } from "./task-markup";

const FeedbackInput = z.object({
  subject: z.string(),
  topic: z.string(),
  grade: z.number().int().min(1).max(5),
  question: z.string(),
  options: z.array(z.string()),
  correctIndex: z.number().int().min(0).max(3),
  studentIndex: z.number().int().min(0).max(3),
  explanation: z.string().nullable().optional(),
});

/**
 * Personalised feedback for an incorrect MCQ answer, via the Anthropic API.
 * MYP achievement is reported on Levels 1-8 — never 1-7 (that is the DP).
 */
export const getQuestionFeedback = createServerFn({ method: "POST" })
  .inputValidator((input: unknown) => FeedbackInput.parse(input))
  .handler(async ({ data }) => {
    const prompt = [
      `You are an IB Middle Years Programme (MYP) tutor for a Grade ${data.grade} student.`,
      `MYP achievement is reported on Levels 1 to 8 (never 1 to 7 - that is the Diploma Programme).`,
      `Subject: ${data.subject}. Topic: ${data.topic}.`,
      `Question: ${data.question}`,
      `Options: ${data.options.map((o, i) => `${i + 1}) ${o}`).join("  ")}`,
      `The student chose: "${data.options[data.studentIndex]}".`,
      `The correct answer is: "${data.options[data.correctIndex]}".`,
      data.explanation ? `Reference explanation: ${data.explanation}` : "",
      `In 2 or 3 short sentences, kindly explain why the student's choice is wrong, then give the correct reasoning. Plain text only, no markdown, no headings.`,
    ]
      .filter(Boolean)
      .join("\n");

    const result = await claudeText({ prompt, maxTokens: 300, what: "feedback" });
    if (!result.ok) return { feedback: null, error: result.error };
    return { feedback: result.value, error: null };
  });

const GradePaperInput = z.object({
  subject: z.string(),
  grade: z.number().int().min(1).max(5),
  paperTitle: z.string(),
  criterion: z.string().nullable().optional(),
  answers: z
    .array(
      z.object({
        position: z.number().int(),
        question: z.string(),
        markScheme: z.string().nullable(),
        response: z.string(),
      }),
    )
    .min(1)
    .max(30),
});

export type PaperMark = {
  position: number;
  marksAwarded: number;
  maxMarks: number;
  feedback: string;
};

const GRADE_SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["marks"],
  properties: {
    marks: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["position", "marks_awarded", "max_marks", "feedback"],
        properties: {
          position: { type: "integer" },
          marks_awarded: { type: "number" },
          max_marks: { type: "number" },
          feedback: { type: "string" },
        },
      },
    },
  },
} as const;

/**
 * Marks a student's written practice-paper answers against the stored mark scheme.
 * MYP achievement is reported on Levels 1-8 — never 1-7 (that is the DP).
 */
export const gradePaper = createServerFn({ method: "POST" })
  .inputValidator((input: unknown) => GradePaperInput.parse(input))
  .handler(async ({ data }) => {
    const prompt = [
      `You are an experienced IB Middle Years Programme (MYP) examiner marking a Grade ${data.grade} ${data.subject} practice paper: "${data.paperTitle}".`,
      data.criterion ? `Assessment criterion: ${data.criterion}.` : "",
      `MYP achievement is reported on Levels 1 to 8 (never 1 to 7 - that is the Diploma Programme).`,
      `Mark each answer strictly against its mark scheme. Count the marks the mark scheme offers to set max_marks; award part marks where the mark scheme allows. An empty or irrelevant answer scores 0.`,
      `A student answer may end with an 'Interactive answers:' block listing drop-down choices, items placed in tables, plotted points or table cells they filled in; mark these like any other part of the answer. Give 1-3 sentences of feedback per question: what earned credit, what was missing, and what the full-mark answer needed. Plain text, no markdown.`,
      ``,
      ...data.answers.map((a) =>
        [
          `--- Question ${a.position} ---`,
          `Question: ${a.question}`,
          `Mark scheme: ${a.markScheme ?? "No mark scheme available; mark on subject accuracy."}`,
          `Student answer: ${a.response.trim() || "(no answer given)"}`,
        ].join("\n"),
      ),
    ]
      .filter(Boolean)
      .join("\n");

    const result = await claudeJson<{
      marks: { position: number; marks_awarded: number; max_marks: number; feedback: string }[];
    }>({
      prompt,
      maxTokens: 4000,
      what: "marking",
      toolName: "record_marks",
      schema: GRADE_SCHEMA as unknown as Record<string, unknown>,
    });
    if (!result.ok) return { marks: null as PaperMark[] | null, error: result.error };

    const parsed = result.value;
    if (!Array.isArray(parsed.marks) || !parsed.marks.length) {
      return {
        marks: null as PaperMark[] | null,
        error: "The marking result could not be read. Try submitting again.",
      };
    }
    const marks: PaperMark[] = parsed.marks.map((m) => {
      const max = Math.max(1, Number(m.max_marks) || 1);
      return {
        position: m.position,
        marksAwarded: Math.max(0, Math.min(Number(m.marks_awarded) || 0, max)),
        maxMarks: max,
        feedback: String(m.feedback ?? ""),
      };
    });
    return { marks, error: null };
  });

/* ------------------------------------------------------------------ */
/* Typed-answer checking (replaces multiple-choice picking)            */
/* ------------------------------------------------------------------ */

const CheckInput = z.object({
  questionId: z.string().uuid().nullable().optional(),
  subject: z.string(),
  topic: z.string(),
  grade: z.number().int().min(1).max(5),
  question: z.string(),
  correctAnswer: z.string(),
  explanation: z.string().nullable().optional(),
  studentAnswer: z.string().max(1000),
  /** 1-based number of this attempt on this question. */
  attempt: z.number().int().min(1).max(10),
  history: z
    .array(z.object({ answer: z.string(), feedback: z.string() }))
    .max(10)
    .optional(),
});

export type AnswerCheck = {
  verdict: "correct" | "partial" | "wrong";
  feedback: string;
  /** True when this verdict came from the shared cache or a plain match, not a new AI call. */
  cached?: boolean;
};

const CHECK_SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["verdict", "feedback"],
  properties: {
    verdict: { type: "string", enum: ["correct", "partial", "wrong"] },
    feedback: { type: "string" },
  },
} as const;

/**
 * Checks a typed answer against the stored correct answer. "partial" means the student
 * has the right idea or a correct next step but has not reached the answer yet.
 * Hints get stronger with each attempt but never give the answer away before the last one.
 */
export const checkTypedAnswer = createServerFn({ method: "POST" })
  .inputValidator((input: unknown) => CheckInput.parse(input))
  .handler(async ({ data }) => {
    // 1. A plainly correct answer needs no AI at all.
    if (exactMatch(data.studentAnswer, data.correctAnswer))
      return {
        check: { verdict: "correct", feedback: "That's right.", cached: true } as AnswerCheck,
        error: null,
      };

    // 2. First-attempt answers other students already tried are answered from the shared cache.
    const admin = adminClient();
    const firstTry = data.attempt === 1 && !(data.history?.length ?? 0);
    const key = answerKey(data.studentAnswer);
    if (admin && data.questionId && firstTry && key) {
      const { data: hit } = await admin
        .from("answer_cache")
        .select("id, verdict, feedback, uses")
        .eq("question_id", data.questionId)
        .eq("answer_key", key)
        .maybeSingle();
      if (hit) {
        void admin
          .from("answer_cache")
          .update({ uses: (hit.uses ?? 1) + 1 })
          .eq("id", hit.id);
        return {
          check: { verdict: hit.verdict, feedback: hit.feedback, cached: true } as AnswerCheck,
          error: null,
        };
      }
    }

    const prompt = [
      `You are a patient IB Middle Years Programme (MYP) ${data.subject} tutor for a Grade ${data.grade + 5} student (MYP ${data.grade}). Topic: ${data.topic}.`,
      `The student must TYPE the answer; there are no options to pick from. Judge their answer against the stored correct answer.`,
      `Question: ${data.question}`,
      `Stored correct answer: ${data.correctAnswer}`,
      data.explanation ? `Reference explanation (do not paste it): ${data.explanation}` : "",
      `Student's answer (attempt ${data.attempt}): "${data.studentAnswer}"`,
      data.history?.length
        ? `Earlier attempts and the feedback already given:\n${data.history
            .map((h, i) => `  ${i + 1}. "${h.answer}" -> ${h.feedback}`)
            .join("\n")}`
        : "",
      ``,
      `Verdict rules:`,
      `- "correct": same meaning or value as the stored answer. Accept equivalent forms (0.5 = 1/2 = 50%, different order of terms, missing units on a pure number, reasonable synonyms, a correct answer with extra correct working).`,
      `- "partial": not the final answer, but the student shows a correct idea, correct working or the right next step (for example a correct first step, or a correct but unfinished expression). Say what is right, then ask for the next step.`,
      `- "wrong": no useful correct step.`,
      `Feedback rules (1-2 short sentences, plain text, no markdown, friendly, never say "multiple choice"):`,
      `- correct: say so briefly and add one short reason or tip.`,
      `- partial: start with "Close" or similar, name what they got right, and nudge towards the next step without giving the final answer.`,
      `- wrong: give a hint whose strength depends on the attempt. Attempt 1: only point at the skill or idea ("Remember how to factorise a quadratic."). Attempt 2: name the first step or formula to use. Attempt 3: work the first step for them and ask them to continue. Attempt 4 or later: nearly give it away, e.g. show the working up to the last line.`,
      `- Never state the stored correct answer in a partial or wrong response. Never repeat a hint already given; make it more specific.`,
      `MYP achievement is reported on Levels 1 to 8, never 1 to 7.`,
    ]
      .filter(Boolean)
      .join("\n");

    const result = await claudeJson<AnswerCheck>({
      prompt,
      maxTokens: 400,
      what: "answer checking",
      toolName: "record_check",
      schema: CHECK_SCHEMA as unknown as Record<string, unknown>,
    });
    if (!result.ok) return { check: null as AnswerCheck | null, error: result.error };
    const v = result.value;
    if (!["correct", "partial", "wrong"].includes(v.verdict) || typeof v.feedback !== "string")
      return { check: null as AnswerCheck | null, error: "The check could not be read." };
    const check: AnswerCheck = { verdict: v.verdict, feedback: v.feedback.trim() };
    if (admin && data.questionId && firstTry && key && check.feedback) {
      void admin.from("answer_cache").upsert(
        {
          question_id: data.questionId,
          answer_key: key,
          verdict: check.verdict,
          feedback: check.feedback.slice(0, 800),
        },
        { onConflict: "question_id,answer_key", ignoreDuplicates: true },
      );
    }
    return { check, error: null };
  });

/** Removes a cached verdict a student says is wrong, so the next student gets a fresh AI check. */
export const reportCachedCheck = createServerFn({ method: "POST" })
  .inputValidator((input: unknown) =>
    z.object({ questionId: z.string().uuid(), answer: z.string().max(1000) }).parse(input),
  )
  .handler(async ({ data }) => {
    const admin = adminClient();
    if (!admin) return { ok: true };
    await admin
      .from("answer_cache")
      .delete()
      .eq("question_id", data.questionId)
      .eq("answer_key", answerKey(data.answer));
    return { ok: true };
  });

/* ------------------------------------------------------------------ */
/* Brand-new written exam tasks, generated on the spot                  */
/* ------------------------------------------------------------------ */

const GenerateInput = z.object({
  subject: z.string(),
  grade: z.number().int().min(1).max(5),
  /** Topic names to cover. Empty means range across the whole course. */
  topics: z.array(z.string()).max(40),
  targetMarks: z.number().int().min(6).max(110),
  /** Stems already seen recently, so new tasks differ from them. */
  seen: z.array(z.string()).max(20).optional(),
});

export type GeneratedTask = {
  position: number;
  marks: number;
  criterion: string;
  content: string;
  mark_scheme: string;
};

const TASKS_SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["tasks"],
  properties: {
    tasks: {
      type: "array",
      items: {
        type: "object",
        additionalProperties: false,
        required: ["marks", "criterion", "content", "mark_scheme"],
        properties: {
          marks: { type: "integer" },
          criterion: { type: "string", enum: ["A", "B", "C", "D"] },
          content: { type: "string" },
          mark_scheme: { type: "string" },
        },
      },
    },
  },
} as const;

const CRITERIA_HELP = [
  "Mathematics: A Knowing and understanding, B Investigating patterns, C Communicating, D Applying mathematics in real-life contexts.",
  "Sciences: A Knowing and understanding, B Inquiring and designing, C Processing and evaluating, D Reflecting on the impacts of science.",
  "Language and literature: A Analysing, B Organizing, C Producing text, D Using language.",
  "Individuals and societies: A Knowing and understanding, B Investigating, C Communicating, D Thinking critically.",
  "Language acquisition: A Listening, B Reading, C Speaking/Communicating, D Writing/Using language.",
  "Interdisciplinary: A Disciplinary grounding, B Synthesizing, C Communicating, D Reflecting.",
].join(" ");

function schemeMarks(scheme: string) {
  let t = 0;
  for (const m of scheme.matchAll(/\[(\d+)\]/g)) t += Number(m[1]);
  return t;
}

const BANNED = /\b1\s*(-|to)\s*7\b|out of 7|diploma programme|a-level|\bIB DP\b|\bHL\b|\bSL\b/i;

export type BankedTask = GeneratedTask & { id: string; fresh: boolean };

/**
 * Builds the tasks for a Mixed test, Build my exam or a new paper. Tasks the student has not seen come
 * from the shared bank first (free); the AI writes the rest and every new task is saved to the bank.
 */
export const generateExamTasks = createServerFn({ method: "POST" })
  .inputValidator((input: unknown) =>
    GenerateInput.extend({
      subjectId: z.string().uuid().nullable().optional(),
      seenIds: z.array(z.string()).max(200).optional(),
    }).parse(input),
  )
  .handler(async ({ data }) => {
    const admin = adminClient();
    const wanted = Math.max(1, Math.min(12, Math.round(data.targetMarks / 9)));
    const topicSet = new Set(data.topics);
    const seen = new Set((data.seenIds ?? []).map((x) => x.replace(/^gen-/, "")));

    // 1. Unseen tasks from the shared bank (about 70% of the paper when the bank is big enough).
    let banked: BankedTask[] = [];
    if (admin && data.subjectId) {
      const { data: rows } = await admin
        .from("generated_tasks")
        .select("id, topic_name, marks, criterion, content, mark_scheme")
        .eq("subject_id", data.subjectId)
        .eq("grade", data.grade)
        .eq("reports", 0)
        .order("times_served", { ascending: true })
        .limit(300);
      const pool = (rows ?? [])
        .filter((r) => !seen.has(r.id))
        .filter((r) => !topicSet.size || !r.topic_name || topicSet.has(r.topic_name))
        .sort(() => Math.random() - 0.5);
      const take = pool.length >= wanted ? Math.round(wanted * 0.7) : pool.length;
      let marks = 0;
      for (const r of pool.slice(0, take)) {
        banked.push({
          id: `gen-${r.id}`,
          position: banked.length + 1,
          marks: r.marks,
          criterion: r.criterion ?? "A",
          content: r.content,
          mark_scheme: r.mark_scheme,
          fresh: false,
        });
        marks += r.marks;
        if (marks >= data.targetMarks) break;
      }
      if (banked.length) {
        const ids = banked.map((b) => b.id.replace(/^gen-/, ""));
        void admin
          .from("generated_tasks")
          .select("id, times_served")
          .in("id", ids)
          .then(({ data: cur }) => {
            for (const c of cur ?? [])
              void admin
                .from("generated_tasks")
                .update({ times_served: (c.times_served ?? 0) + 1 })
                .eq("id", c.id);
          });
      }
    }
    const bankMarks = banked.reduce((t, b) => t + b.marks, 0);
    const remaining = data.targetMarks - bankMarks;
    if (remaining < 5 && banked.length)
      return { tasks: banked as BankedTask[] | null, error: null as string | null };

    // 2. The AI writes the rest.
    const nTasks = Math.max(1, Math.min(12, Math.round(remaining / 9)));
    const perTask = Math.max(4, Math.min(14, Math.round(remaining / nTasks)));
    const foci = Array.from({ length: nTasks }, (_, i) =>
      data.topics.length ? data.topics[i % data.topics.length]! : "any part of the MYP 5 course",
    );
    const batches: { start: number; foci: string[] }[] = [];
    for (let i = 0; i < nTasks; i += 3) batches.push({ start: i, foci: foci.slice(i, i + 3) });

    const results = await Promise.all(
      batches.map(async (b) => {
        const seed = Math.random().toString(36).slice(2, 8);
        const prompt = [
          `You are an experienced IB MYP ${data.subject} examiner writing ${b.foci.length} ORIGINAL on-screen eAssessment style tasks for MYP ${data.grade} (school Grade ${data.grade + 5}). Seed ${seed}: use fresh contexts, names and numbers.`,
          `Never copy real IB papers. MYP only, never Diploma Programme or A-level. MYP criteria: ${CRITERIA_HELP} Use the criterion letters that fit ${data.subject}.`,
          `Task focus, in order: ${b.foci.map((f, i) => `${i + 1}) ${f}`).join("; ")}.`,
          `Each task is about ${perTask} marks (range ${Math.max(4, perTask - 3)} to ${perTask + 3}). Give it a real stimulus (a scenario, data table with actual numbers, passage extract, experiment or source written out in the text), then lettered parts (a), (b), (c)... rising from recall to application to evaluation, each ending with "(n marks)". Use proper command terms (state, describe, explain, calculate, show that, justify, evaluate, discuss). The task must be fully answerable from the text.`,
          `Make the task feel like the on-screen exam by using this inline markup where it fits naturally (use it in roughly half your tasks, with exact syntax, no nesting, no braces inside): {{select|id|option 1|option 2|option 3}} a drop-down inside a sentence (ids like a1, b2, unique within the task); {{drag|id|Row A,Row B,Row C|item 1,item 2,item 3}} items the student places into table rows; {{plot|id|xmin,xmax,ymin,ymax|x label|y label}} a grid where the student plots points (integer coordinates, at most 40 units per axis); {{fill|id|Column 1,Column 2|3}} an empty table to fill in (last number = rows); {{chart|bar|Title|x label|y label|A:3,B:5,C:2}} a chart shown with the question (types bar, line, pie; the numbers must match the story). Use a chart to present data instead of describing a picture. The mark scheme must say what the correct drop-down choices, placements or plotted points are.`,
          `Start "content" with a header like [[Q 1 | A 5 | C 2]] listing the criteria and marks per criterion (the numbers add up to the task's marks), then a newline, then the task text. End the content with "Total for Question N: X marks".`,
          `mark_scheme: per-part marking points each followed by [n]; all [n] values must add up exactly to "marks". Include accepted alternatives.`,
          `Do not mention the scale 1-7. Plain text, no markdown.`,
          data.seen?.length ? `Avoid these stems already used:\n- ${data.seen.join("\n- ")}` : "",
        ]
          .filter(Boolean)
          .join("\n");
        const r = await claudeJson<{
          tasks: { marks: number; criterion: string; content: string; mark_scheme: string }[];
        }>({
          prompt,
          maxTokens: 7000,
          what: "exam writing",
          toolName: "record_tasks",
          schema: TASKS_SCHEMA as unknown as Record<string, unknown>,
        });
        return { r, foci: b.foci };
      }),
    );

    const failed = results.find((x) => !x.r.ok);
    const fresh: BankedTask[] = [];
    for (const { r, foci: fs } of results) {
      if (!r.ok) continue;
      (r.value.tasks ?? []).forEach((t, idx) => {
        if (typeof t.content !== "string" || typeof t.mark_scheme !== "string") return;
        const marks = schemeMarks(t.mark_scheme);
        if (marks < 3 || marks !== Number(t.marks)) return;
        if (BANNED.test(t.content) || BANNED.test(t.mark_scheme)) return;
        if (!/\(\d+ marks?\)/.test(t.content)) return;
        if (parseTaskBody(t.content).errors.length) return;
        fresh.push({
          id: "",
          position: 0,
          marks,
          criterion: t.criterion,
          content: t.content.trim(),
          mark_scheme: t.mark_scheme.trim(),
          fresh: true,
          ...(fs[idx] && data.topics.length ? { topicName: fs[idx] } : {}),
        } as BankedTask & { topicName?: string });
      });
    }

    // Save the new tasks to the shared bank (best effort) and give them ids.
    if (admin && data.subjectId && fresh.length) {
      const { data: saved } = await admin
        .from("generated_tasks")
        .insert(
          fresh.map((t) => ({
            subject_id: data.subjectId!,
            grade: data.grade,
            topic_name: (t as BankedTask & { topicName?: string }).topicName ?? null,
            marks: t.marks,
            criterion: t.criterion,
            content: t.content,
            mark_scheme: t.mark_scheme,
          })),
        )
        .select("id");
      (saved ?? []).forEach((row, i) => {
        if (fresh[i]) fresh[i]!.id = `gen-${row.id}`;
      });
    }
    fresh.forEach((t, i) => {
      if (!t.id) t.id = `gen-new-${Date.now().toString(36)}-${i}`;
    });

    const all = [...banked, ...fresh].map((t, i) => ({ ...t, position: i + 1 }));
    if (!all.length)
      return {
        tasks: null as BankedTask[] | null,
        error: failed && !failed.r.ok ? failed.r.error : "No valid tasks were produced.",
      };
    return { tasks: all as BankedTask[] | null, error: null as string | null };
  });

/** Takes a reported task out of the shared bank. */
export const reportGeneratedTask = createServerFn({ method: "POST" })
  .inputValidator((input: unknown) => z.object({ id: z.string().max(80) }).parse(input))
  .handler(async ({ data }) => {
    const admin = adminClient();
    const id = data.id.replace(/^gen-/, "");
    if (!admin || !/^[0-9a-f-]{36}$/.test(id)) return { ok: true };
    const { data: cur } = await admin
      .from("generated_tasks")
      .select("reports")
      .eq("id", id)
      .maybeSingle();
    if (cur)
      await admin
        .from("generated_tasks")
        .update({ reports: (cur.reports ?? 0) + 1 })
        .eq("id", id);
    return { ok: true };
  });
