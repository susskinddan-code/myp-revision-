import { createMiddleware, createServerFn } from "@tanstack/react-start";
import { getRequest } from "@tanstack/react-start/server";
import {
  authenticate,
  checkAnswerCore,
  CheckInput,
  generateExamTasksCore,
  GenerateInput,
  gradePaperCore,
  GradePaperInput,
  reportCachedCheckCore,
  reportGeneratedTaskCore,
  ReportCheckInput,
} from "./ai-core.server";
import { z } from "zod";

export type {
  AnswerCheck,
  BankedTask,
  CheckResult,
  GeneratedTask,
  GenerateResult,
  GradeResult,
  PaperMark,
} from "./ai-core.server";

/**
 * Every AI call needs a signed-in student. The browser attaches the bearer token to server-function
 * calls through the global `attachSupabaseAuth` middleware in src/start.ts. Logic and input caps live in
 * ai-core.server.ts (which also rate limits per user).
 */
const requireStudent = createMiddleware({ type: "function" }).server(async ({ next }) => {
  const userId = await authenticate(getRequest());
  return next({ context: { userId } });
});

/** Marks a student's written practice-paper answers against the stored mark scheme. MYP Levels 1-8, never 1-7. */
export const gradePaper = createServerFn({ method: "POST" })
  .middleware([requireStudent])
  .inputValidator((input: unknown) => GradePaperInput.parse(input))
  .handler(async ({ data, context }) => gradePaperCore(data, context.userId));

/**
 * Checks a typed answer. "partial" means the right idea but not there yet. When the AI is unavailable,
 * `check` is null and `errorCode` says why (no_key / busy) - that is never a wrong attempt.
 */
export const checkTypedAnswer = createServerFn({ method: "POST" })
  .middleware([requireStudent])
  .inputValidator((input: unknown) => CheckInput.parse(input))
  .handler(async ({ data, context }) => checkAnswerCore(data, context.userId));

/** Counts a report against a cached verdict a student says is wrong (retired at 3 reports). */
export const reportCachedCheck = createServerFn({ method: "POST" })
  .middleware([requireStudent])
  .inputValidator((input: unknown) => ReportCheckInput.parse(input))
  .handler(async ({ data, context }) => reportCachedCheckCore(data, context.userId));

/** Tasks for a Mixed test, Build my exam or a new paper: unseen bank tasks first, then fresh AI-written ones. */
export const generateExamTasks = createServerFn({ method: "POST" })
  .middleware([requireStudent])
  .inputValidator((input: unknown) => GenerateInput.parse(input))
  .handler(async ({ data, context }) => generateExamTasksCore(data, context.userId));

/** Counts a report against a banked task (retired at 3 reports). */
export const reportGeneratedTask = createServerFn({ method: "POST" })
  .middleware([requireStudent])
  .inputValidator((input: unknown) => z.object({ id: z.string().max(80) }).parse(input))
  .handler(async ({ data, context }) => reportGeneratedTaskCore(data, context.userId));
