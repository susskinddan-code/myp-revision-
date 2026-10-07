import { createServerFn } from "@tanstack/react-start";
import { z } from "zod";
import { claudeJson, claudeText } from "./anthropic.server";

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
      `Give 1-3 sentences of feedback per question: what earned credit, what was missing, and what the full-mark answer needed. Plain text, no markdown.`,
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
      return { marks: null as PaperMark[] | null, error: "The marking result could not be read. Try submitting again." };
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
