import { createServerFn } from "@tanstack/react-start";
import { z } from "zod";

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
 * Personalised feedback for an incorrect MCQ answer, via Lovable AI.
 * MYP achievement is reported on Levels 1-8 — never 1-7 (that is the DP).
 */
export const getQuestionFeedback = createServerFn({ method: "POST" })
  .inputValidator((input: unknown) => FeedbackInput.parse(input))
  .handler(async ({ data }) => {
    const apiKey = process.env["LOVABLE_API_KEY"];
    if (!apiKey) {
      return { feedback: null, error: "AI feedback is not configured." };
    }

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

    let response: Response;
    try {
      response = await fetch("https://ai.gateway.lovable.dev/v1/responses", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Lovable-API-Key": apiKey,
          "X-Lovable-AIG-SDK": "fetch",
        },
        body: JSON.stringify({
          model: "openai/gpt-6-astra",
          input: prompt,
          stream: true,
          reasoning: { effort: "low" },
        }),
      });
    } catch {
      return { feedback: null, error: "Could not reach the feedback service. Try again." };
    }

    if (!response.ok || !response.body) {
      const status = response.status;
      const message =
        status === 429
          ? "The feedback service is busy right now. Try again in a moment."
          : status === 402
            ? "AI credits have run out for this workspace."
            : status === 403
              ? "AI feedback is currently blocked for this workspace."
              : "Feedback could not be generated for this question.";
      return { feedback: null, error: message };
    }

    const reader = response.body.getReader();
    const decoder = new TextDecoder();
    let buffer = "";
    let text = "";

    while (true) {
      const { value, done } = await reader.read();
      if (done) break;
      buffer += decoder.decode(value, { stream: true });
      const lines = buffer.split("\n");
      buffer = lines.pop() ?? "";
      for (const line of lines) {
        if (!line.startsWith("data:")) continue;
        const payload = line.slice(5).trim();
        if (!payload || payload === "[DONE]") continue;
        try {
          const event = JSON.parse(payload) as {
            type?: string;
            delta?: string;
            response?: { output_text?: string };
          };
          if (event.type === "response.output_text.delta" && typeof event.delta === "string") {
            text += event.delta;
          } else if (event.type === "response.completed" && event.response?.output_text) {
            if (!text) text = event.response.output_text;
          }
        } catch {
          // ignore keep-alive and non-JSON frames
        }
      }
    }

    const trimmed = text.trim();
    if (!trimmed) {
      return { feedback: null, error: "No feedback was returned for this question." };
    }
    return { feedback: trimmed, error: null };
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
    const apiKey = process.env["LOVABLE_API_KEY"];
    if (!apiKey) {
      return { marks: null as PaperMark[] | null, error: "AI marking is not configured." };
    }

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

    let response: Response;
    try {
      response = await fetch("https://ai.gateway.lovable.dev/v1/responses", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Lovable-API-Key": apiKey,
          "X-Lovable-AIG-SDK": "fetch",
        },
        body: JSON.stringify({
          model: "openai/gpt-6-astra",
          input: prompt,
          stream: true,
          reasoning: { effort: "medium" },
          text: {
            format: {
              type: "json_schema",
              name: "paper_marks",
              strict: true,
              schema: GRADE_SCHEMA,
            },
          },
        }),
      });
    } catch {
      return { marks: null, error: "Could not reach the marking service. Try again." };
    }

    if (!response.ok || !response.body) {
      const message =
        response.status === 429
          ? "The marking service is busy right now. Try again in a moment."
          : response.status === 402
            ? "AI credits have run out for this workspace."
            : response.status === 403
              ? "AI marking is currently blocked for this workspace."
              : "This paper could not be marked right now.";
      return { marks: null, error: message };
    }

    const reader = response.body.getReader();
    const decoder = new TextDecoder();
    let buffer = "";
    let text = "";

    while (true) {
      const { value, done } = await reader.read();
      if (done) break;
      buffer += decoder.decode(value, { stream: true });
      const lines = buffer.split("\n");
      buffer = lines.pop() ?? "";
      for (const line of lines) {
        if (!line.startsWith("data:")) continue;
        const payload = line.slice(5).trim();
        if (!payload || payload === "[DONE]") continue;
        try {
          const event = JSON.parse(payload) as {
            type?: string;
            delta?: string;
            response?: { output_text?: string };
          };
          if (event.type === "response.output_text.delta" && typeof event.delta === "string") {
            text += event.delta;
          } else if (event.type === "response.completed" && event.response?.output_text) {
            if (!text) text = event.response.output_text;
          }
        } catch {
          // ignore keep-alive and non-JSON frames
        }
      }
    }

    try {
      const parsed = JSON.parse(text.trim()) as {
        marks: { position: number; marks_awarded: number; max_marks: number; feedback: string }[];
      };
      const marks: PaperMark[] = parsed.marks.map((m) => ({
        position: m.position,
        marksAwarded: Math.max(0, Math.min(m.marks_awarded, m.max_marks)),
        maxMarks: Math.max(1, m.max_marks),
        feedback: m.feedback,
      }));
      if (!marks.length) throw new Error("empty");
      return { marks, error: null };
    } catch {
      return { marks: null, error: "The marking result could not be read. Try submitting again." };
    }
  });
