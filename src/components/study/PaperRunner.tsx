import { useEffect, useRef, useState } from "react";
import { useBlocker } from "@tanstack/react-router";
import { useQuery } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { ChevronDown, Flag, Sigma, Sparkles } from "lucide-react";
import { Button } from "@/components/ui/button";
import { gradePaper, reportGeneratedTask, type PaperMark } from "@/lib/ai.functions";
import {
  fetchPaperQuestions,
  type PaperTask,
  recordAttempt,
  accuracyToMypLevel,
  marksOf,
  parseQuestionHeader,
  MYP_LEVEL_LABELS,
} from "@/lib/myp";
import { TaskBody } from "@/components/study/TaskBody";
import { useAuth } from "@/hooks/use-auth";
import { describeResult, type FormulaGroup } from "@/lib/eassessment";

/** Typed answers are capped here; the server cuts anything longer (see MAX_RESPONSE_CHARS). */
const MAX_ANSWER_CHARS = 6000;

const SESSION_PREFIX = "myp-exam:";
const SESSION_MAX_AGE_MS = 12 * 3600_000;

/** A task as shown in the exam; `sig` is the server's signature on a freshly written (not yet banked) task. */
export type ExamTask = PaperTask & { sig?: string | undefined };

/** An exam in progress, kept in sessionStorage so a reload or accidental navigation does not lose it. */
export type ExamSession = {
  v: 1;
  /** Wall-clock end of the sitting (ms since epoch); null when untimed. */
  endAt: number | null;
  savedAt: number;
  responses: Record<number, string>;
  widgetVals: Record<number, Record<string, string>>;
  flagged: Record<number, boolean>;
  working: Record<number, string>;
  paper: { id: string; title: string; grade: number; criterion: string | null };
  /** Present for generated exams (stored papers are re-fetched by paper id). */
  tasks?: ExamTask[];
  minutes?: number | undefined;
  exitLabel?: string | undefined;
  notice?: string | null | undefined;
};

export function loadExamSession(key: string): ExamSession | null {
  try {
    const raw = sessionStorage.getItem(SESSION_PREFIX + key);
    if (!raw) return null;
    const s = JSON.parse(raw) as ExamSession;
    if (s?.v !== 1 || !s.paper || Date.now() - s.savedAt > SESSION_MAX_AGE_MS) {
      sessionStorage.removeItem(SESSION_PREFIX + key);
      return null;
    }
    return s;
  } catch {
    return null;
  }
}

export function clearExamSession(key: string) {
  try {
    sessionStorage.removeItem(SESSION_PREFIX + key);
  } catch {
    /* storage unavailable */
  }
}

const SIGN_IN_MESSAGE =
  "You need to be signed in to get this paper marked. Your answers are kept here.";

function describeError(e: unknown): { message: string; signIn: boolean } {
  const msg = e instanceof Error ? e.message : typeof e === "string" ? e : "";
  if (/too_big|too big|too long|exceeds|at most/i.test(msg))
    return {
      message:
        "One question or answer is too long to send for marking. Shorten your longest answer and try again.",
      signIn: false,
    };
  if (/sign in|unauthori|401|not signed/i.test(msg))
    return { message: SIGN_IN_MESSAGE, signIn: true };
  const short = msg.replace(/\s+/g, " ").trim().slice(0, 160);
  return {
    message: short
      ? `Your paper could not be marked right now (${short}). Try again.`
      : "Your paper could not be marked right now. Try again.",
    signIn: false,
  };
}

/** Link to the sign-in page that brings the student back to this exam. */
function signInHref() {
  if (typeof window === "undefined") return "/auth";
  return `/auth?redirect=${encodeURIComponent(window.location.pathname + window.location.search)}`;
}

type Props = {
  paper: { id: string; title: string; grade: number; criterion: string | null };
  subjectId: string;
  subjectName: string;
  onExit: () => void;
  /** Pre-assembled tasks (Mixed / Build my exam) instead of a stored paper. */
  tasks?: ExamTask[];
  exitLabel?: string | undefined;
  /** eAssessment-style sitting: countdown timer and both grade scales on the result. */
  exam?: { minutes: number; formulas?: FormulaGroup[] | null };
  /** Saves the sitting to sessionStorage under this key (see loadExamSession). */
  persistKey?: string;
  /** Shown as a banner inside the exam, e.g. "new questions unavailable, saved tasks used". */
  notice?: string | null | undefined;
};

export function PaperRunner({
  paper,
  subjectId,
  subjectName,
  onExit,
  exam,
  tasks,
  exitLabel,
  persistKey,
  notice,
}: Props) {
  const { user, loading: authLoading } = useAuth();
  const mark = useServerFn(gradePaper);
  const report = useServerFn(reportGeneratedTask);
  const [saved] = useState<ExamSession | null>(() => {
    if (!persistKey) return null;
    const s = loadExamSession(persistKey);
    return s && s.paper.id === paper.id ? s : null;
  });
  const [widgetVals, setWidgetVals] = useState<Record<number, Record<string, string>>>(
    saved?.widgetVals ?? {},
  );
  const [reported, setReported] = useState<Record<number, boolean>>({});
  const [responses, setResponses] = useState<Record<number, string>>(saved?.responses ?? {});
  const [marks, setMarks] = useState<PaperMark[] | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [needsSignIn, setNeedsSignIn] = useState(false);
  // Another paper's sitting is already saved under this key: ask before replacing it.
  const [conflict, setConflict] = useState<ExamSession | null>(() => {
    if (!persistKey || saved) return null;
    const other = loadExamSession(persistKey);
    return other && other.paper.id !== paper.id ? other : null;
  });
  const [marking, setMarking] = useState(false);
  // The clock runs off a wall-clock end time, so background-tab throttling and reloads cannot slow it.
  const endAt = useRef<number | null>(
    exam ? (saved?.endAt ?? Date.now() + exam.minutes * 60_000) : null,
  );
  const [now, setNow] = useState(() => Date.now());
  const secondsLeft =
    endAt.current === null ? null : Math.max(0, Math.ceil((endAt.current - now) / 1000));
  const submitRef = useRef<() => void>(() => {});
  const [flagged, setFlagged] = useState<Record<number, boolean>>(saved?.flagged ?? {});
  const [working, setWorking] = useState<Record<number, string>>(saved?.working ?? {});
  const [showFormulas, setShowFormulas] = useState(false);
  const [navOpen, setNavOpen] = useState(
    () => typeof window !== "undefined" && window.matchMedia("(min-width: 640px)").matches,
  );
  const [run, setRun] = useState(0);
  const [confirmBlank, setConfirmBlank] = useState(false);
  const autoSubmitted = useRef(false);

  useEffect(() => {
    if (endAt.current === null || marks) return;
    const tick = () => setNow(Date.now());
    tick();
    const t = setInterval(tick, 1000);
    document.addEventListener("visibilitychange", tick);
    return () => {
      clearInterval(t);
      document.removeEventListener("visibilitychange", tick);
    };
  }, [marks]);

  const inProgress = !!exam && !marks && !conflict;
  // Persist the sitting; stored papers are re-fetched by id, generated ones keep their tasks.
  useEffect(() => {
    if (!persistKey || conflict) return;
    if (marks) return clearExamSession(persistKey);
    try {
      const record: ExamSession = {
        v: 1,
        endAt: endAt.current,
        savedAt: Date.now(),
        responses,
        widgetVals,
        flagged,
        working,
        paper,
        ...(tasks ? { tasks, minutes: exam?.minutes, exitLabel, notice } : {}),
      };
      sessionStorage.setItem(SESSION_PREFIX + persistKey, JSON.stringify(record));
    } catch {
      /* storage full or unavailable: the sitting just is not restorable */
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [persistKey, conflict, marks, responses, widgetVals, flagged, working]);

  // Leaving the page (reload, close, in-app navigation, browser Back) asks first; answers stay saved.
  useBlocker({
    shouldBlockFn: () =>
      !window.confirm(
        "Leave this exam? Your answers are saved on this device and the clock keeps running.",
      ),
    enableBeforeUnload: () => inProgress,
    disabled: !inProgress,
  });

  function leave() {
    if (inProgress && !window.confirm("Leave this exam? Your answers will be discarded.")) return;
    if (persistKey) clearExamSession(persistKey);
    onExit();
  }

  const { data: fetched, isLoading: loadingFetched } = useQuery({
    queryKey: ["paper-questions", paper.id],
    queryFn: () => fetchPaperQuestions(paper.id),
    enabled: !tasks,
  });
  const questions: ExamTask[] | undefined = tasks ?? fetched;
  const isLoading = !tasks && loadingFetched;

  // Time ran out: submit once, but only when the questions are loaded (a restored, already expired sitting
  // loads them a moment after the first render). If marking fails the student can retry in one click.
  useEffect(() => {
    if (secondsLeft !== 0 || marks || marking || conflict || !questions?.length) return;
    if (!autoSubmitted.current) {
      autoSubmitted.current = true;
      submitRef.current();
    }
  }, [secondsLeft, marks, marking, conflict, questions]);

  /** The typed answer plus whatever the student chose, placed or plotted in the interactive parts. */
  function fullResponse(position: number) {
    const typed = (responses[position] ?? "").trim();
    const picked = Object.entries(widgetVals[position] ?? {})
      .filter(([, v]) => v)
      .map(([id, v]) => `[${id}] ${v}`);
    return picked.length
      ? `${typed}${typed ? "\n" : ""}Interactive answers:\n${picked.join("\n")}`
      : typed;
  }

  /** What is sent for one task: its id and answer. Only a just-written task also carries its signed text. */
  function payloadFor(q: ExamTask) {
    const id = String(q.id);
    const base = { position: q.position, taskId: id, response: fullResponse(q.position) };
    return id.startsWith("gen-new-")
      ? {
          ...base,
          ...(q.sig ? { sig: q.sig } : {}),
          question: q.content,
          markScheme: q.mark_scheme,
        }
      : base;
  }

  /** Marks the given tasks (all of them, or only those left unmarked before). Returns the marks or null. */
  async function markTasks(list: ExamTask[]): Promise<PaperMark[] | null> {
    if (!user) {
      setError(SIGN_IN_MESSAGE);
      setNeedsSignIn(true);
      return null;
    }
    setMarking(true);
    try {
      const result = await mark({
        data: {
          subject: subjectName,
          grade: paper.grade,
          paperTitle: paper.title,
          criterion: paper.criterion,
          answers: list.map(payloadFor),
        },
      });
      if (result.marks) {
        for (const m of result.marks) {
          if (m.unmarked) continue;
          recordAttempt(user.id, {
            subjectId,
            source: "practice-paper",
            correct: m.marksAwarded >= m.maxMarks / 2,
          }).catch(() => {});
        }
        return result.marks;
      }
      setError(result.error);
      return null;
    } catch (e) {
      const d = describeError(e);
      setError(d.message);
      setNeedsSignIn(d.signIn);
      return null;
    } finally {
      setMarking(false);
    }
  }

  async function handleSubmit() {
    if (!questions?.length) return;
    setConfirmBlank(false);
    setError(null);
    setNeedsSignIn(false);
    // A completely blank paper scores 0 without spending an AI call.
    if (questions.every((q) => fullResponse(q.position).length === 0)) {
      setMarks(
        questions.map((q) => ({
          position: q.position,
          marksAwarded: 0,
          maxMarks: marksOf(q.mark_scheme) || 1,
          feedback: "No answer was given for this question.",
        })),
      );
      return;
    }
    const got = await markTasks(questions);
    if (got) setMarks(got);
  }

  /** Marks only the questions the marker skipped, and merges them into the result. */
  async function handleRemark() {
    if (!questions || !marks) return;
    setError(null);
    setNeedsSignIn(false);
    const missing = questions.filter((q) => marks.find((m) => m.position === q.position)?.unmarked);
    if (!missing.length) return;
    const got = await markTasks(missing);
    if (got)
      setMarks((prev) =>
        (prev ?? []).map((m) => {
          const n = got.find((g) => g.position === m.position);
          return n && !n.unmarked ? n : m;
        }),
      );
  }

  submitRef.current = handleSubmit;

  if (conflict) {
    return (
      <div className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
        <h2 className="font-display text-xl">You already have an exam in progress</h2>
        <p className="mt-2 text-sm text-muted-foreground">
          "{conflict.paper.title}" is saved on this device for this subject. Starting "{paper.title}
          " will discard it. To carry on with the earlier one, go back and open this tab again.
        </p>
        <div className="mt-4 flex flex-wrap gap-2">
          <Button
            className="rounded-full"
            onClick={() => {
              endAt.current = exam ? Date.now() + exam.minutes * 60_000 : null;
              setNow(Date.now());
              setConflict(null);
            }}
          >
            Discard it and start this one
          </Button>
          <Button variant="outline" className="rounded-full" onClick={onExit}>
            Keep the earlier exam
          </Button>
        </div>
      </div>
    );
  }
  if (isLoading) {
    return <p className="text-sm text-muted-foreground">Loading paper…</p>;
  }
  if (!questions?.length) {
    return <p className="text-sm text-muted-foreground">This paper has no questions.</p>;
  }

  const counted = marks?.filter((m) => !m.unmarked) ?? [];
  const unmarkedCount = (marks?.length ?? 0) - counted.length;
  const awarded = counted.reduce((t, m) => t + m.marksAwarded, 0);
  const total = counted.reduce((t, m) => t + m.maxMarks, 0);
  const timeUp = secondsLeft === 0 && !marks;
  const locked = !!marks || marking || timeUp;
  const level = total ? accuracyToMypLevel(awarded / total) : 0;
  const both = total ? describeResult(awarded / total) : null;
  const answeredCount = questions.filter((q) => fullResponse(q.position).length > 0).length;
  const flaggedCount = questions.filter((q) => flagged[q.position]).length;
  const clock =
    secondsLeft === null
      ? null
      : `${Math.floor(secondsLeft / 60)}:${String(secondsLeft % 60).padStart(2, "0")}`;

  return (
    <div>
      <Button variant="ghost" size="sm" className="mb-4 rounded-full" onClick={leave}>
        {exitLabel ?? "All practice papers"}
      </Button>
      {!user && !authLoading ? (
        <p
          role="status"
          className="mb-3 rounded-md border border-primary/40 bg-primary/5 px-3 py-2 text-sm"
        >
          You are not signed in, so this paper cannot be marked yet.{" "}
          <a href={signInHref()} className="font-medium underline underline-offset-4">
            Sign in
          </a>{" "}
          first (your answers stay on this device and you come straight back here).
        </p>
      ) : null}
      {notice ? (
        <p
          role="status"
          className="mb-3 rounded-md border border-border bg-surface-2 px-3 py-2 text-sm text-muted-foreground"
        >
          {notice}
        </p>
      ) : null}
      <h2 className="font-display text-2xl">{paper.title}</h2>
      <p className="mt-1 text-sm text-muted-foreground">
        {questions.length} written-answer questions · MYP {paper.grade}
        {marks ? null : " · answer each one, then submit for marking"}
      </p>
      {exam && !marks ? (
        <div className="sticky top-14 z-30 mt-3 rounded-lg border border-border bg-card shadow-[var(--shadow-soft)] sm:top-16">
          <div className="flex items-center justify-between gap-2 px-3 py-2 text-sm">
            <span
              className={`font-mono text-base tabular-nums ${
                (secondsLeft ?? 0) < 300 ? "text-destructive" : ""
              }`}
              aria-label="Time left"
            >
              {clock}
            </span>
            <span className="min-w-0 truncate text-xs text-muted-foreground">
              {answeredCount}/{questions.length} answered
              {flaggedCount ? ` · ${flaggedCount} flagged` : ""}
            </span>
            <button
              type="button"
              aria-expanded={navOpen}
              onClick={() => setNavOpen((v) => !v)}
              className="inline-flex shrink-0 items-center gap-1 rounded-full border border-border px-3 py-1 text-xs"
            >
              Questions
              <ChevronDown
                className={`size-3 transition-transform ${navOpen ? "rotate-180" : ""}`}
              />
            </button>
          </div>
          {navOpen ? (
            <div className="max-h-48 overflow-y-auto border-t border-border p-3">
              <div className="flex flex-wrap items-center gap-2">
                {questions.map((q) => {
                  const answered = fullResponse(q.position).length > 0;
                  return (
                    <button
                      key={q.id}
                      type="button"
                      aria-label={`Go to question ${q.position}${answered ? ", answered" : ", not answered"}${
                        flagged[q.position] ? ", flagged" : ""
                      }`}
                      onClick={() =>
                        document
                          .getElementById(`pq-${q.position}`)
                          ?.scrollIntoView({ behavior: "smooth", block: "start" })
                      }
                      className={`relative size-8 rounded-md border text-sm tabular-nums ${
                        answered
                          ? "border-primary bg-primary text-primary-foreground"
                          : "border-border bg-background"
                      }`}
                    >
                      {q.position}
                      {flagged[q.position] ? (
                        <Flag className="absolute -right-1 -top-1 size-3 fill-current text-destructive" />
                      ) : null}
                    </button>
                  );
                })}
                {exam.formulas ? (
                  <Button
                    type="button"
                    variant="outline"
                    size="sm"
                    className="ml-auto rounded-full"
                    onClick={() => setShowFormulas((v) => !v)}
                  >
                    <Sigma className="mr-1 size-4" />
                    {showFormulas ? "Hide formulas" : "Formulas"}
                  </Button>
                ) : null}
              </div>
              {showFormulas && exam.formulas ? (
                <div className="mt-3 max-h-40 overflow-y-auto rounded-md border border-border bg-surface-2 p-3 text-sm">
                  {exam.formulas.map((g) => (
                    <div key={g.title} className="mb-3 last:mb-0">
                      <p className="text-xs uppercase tracking-wide text-muted-foreground">
                        {g.title}
                      </p>
                      <ul className="mt-1 flex flex-col gap-1">
                        {g.lines.map((l) => (
                          <li key={l} className="font-mono text-xs">
                            {l}
                          </li>
                        ))}
                      </ul>
                    </div>
                  ))}
                </div>
              ) : null}
            </div>
          ) : null}
        </div>
      ) : null}

      {marks ? (
        <div className="mt-6 rounded-lg border border-border bg-card p-6 text-center shadow-[var(--shadow-soft)]">
          <p className="font-display text-4xl">
            {Math.round(awarded * 10) / 10} / {total}
          </p>
          <p className="mt-1 text-sm text-muted-foreground">
            {total ? Math.round((awarded / total) * 100) : 0}%
            {unmarkedCount
              ? " of the marked questions"
              : ` · MYP Level ${level} of 8 — ${MYP_LEVEL_LABELS[level]}`}
          </p>
          {unmarkedCount ? (
            <div className="mt-2 text-xs text-destructive">
              <p>
                {unmarkedCount} question{unmarkedCount === 1 ? " was" : "s were"} not marked and{" "}
                {unmarkedCount === 1 ? "is" : "are"} left out of this total. Your Level
                {exam ? " and grade" : ""} will appear once every question is marked.
              </p>
              <Button
                size="sm"
                variant="outline"
                className="mt-2 rounded-full"
                disabled={marking}
                onClick={handleRemark}
              >
                {marking ? "Marking…" : "Mark the missing questions"}
              </Button>
            </div>
          ) : null}
          {exam && both && !unmarkedCount ? (
            <div className="mt-4 grid gap-3 text-left sm:grid-cols-2">
              <div className="rounded-md border border-border bg-surface-2 p-4">
                <p className="text-xs uppercase tracking-wide text-muted-foreground">
                  Criterion achievement (Levels 1-8)
                </p>
                <p className="mt-1 font-display text-2xl">Level {both.criterionLevel} of 8</p>
              </div>
              <div className="rounded-md border border-border bg-surface-2 p-4">
                <p className="text-xs uppercase tracking-wide text-muted-foreground">
                  Estimated overall subject grade (1-7)
                </p>
                <p className="mt-1 font-display text-2xl">Grade {both.overallGrade} of 7</p>
              </div>
              <p className="text-xs text-muted-foreground sm:col-span-2">
                The real eAssessment reports one overall grade from 1 to 7. The IB sets the exact
                grade boundaries every session, so treat this as a guide, not a prediction.
              </p>
            </div>
          ) : null}
        </div>
      ) : null}

      <ol className="mt-6 flex flex-col gap-4">
        {questions.map((q) => {
          const result = marks?.find((m) => m.position === q.position);
          const qMarks = marksOf(q.mark_scheme);
          const head = parseQuestionHeader(q.content);
          return (
            <li
              key={q.id}
              id={`pq-${q.position}`}
              className="scroll-mt-32 rounded-lg sm:scroll-mt-60 border border-border bg-card p-5 shadow-[var(--shadow-soft)]"
            >
              <div className="flex flex-wrap items-start justify-between gap-x-4 gap-y-2">
                <p className="min-w-0 flex-1 basis-40 text-xs uppercase tracking-wide text-muted-foreground">
                  {head.label ?? `Question ${q.position}`}
                  {qMarks ? ` · ${qMarks} marks` : ""}
                  {head.tags.length === 0 && q.criterion ? ` · Criterion ${q.criterion}` : ""}
                  {head.tags.map((t) => (
                    <span
                      key={t}
                      className="ml-2 inline-block rounded border border-border px-1.5 py-0.5 normal-case tracking-normal text-foreground"
                    >
                      {t}
                    </span>
                  ))}
                </p>
                <div className="flex flex-wrap items-center gap-2">
                  {exam && !marks ? (
                    <button
                      type="button"
                      aria-pressed={!!flagged[q.position]}
                      onClick={() => setFlagged((f) => ({ ...f, [q.position]: !f[q.position] }))}
                      className={`inline-flex items-center gap-1 rounded-full border px-3 py-1 text-xs ${
                        flagged[q.position]
                          ? "border-destructive text-destructive"
                          : "border-border text-muted-foreground"
                      }`}
                    >
                      <Flag className="size-3" />
                      {flagged[q.position] ? "Flagged" : "Flag for review"}
                    </button>
                  ) : null}
                  {String(q.id).startsWith("gen-") ? (
                    <button
                      type="button"
                      disabled={!!reported[q.position]}
                      onClick={() => {
                        setReported((r) => ({ ...r, [q.position]: true }));
                        void report({ data: { id: String(q.id) } }).catch(() => {});
                      }}
                      className="rounded-full border border-border px-3 py-1 text-xs text-muted-foreground hover:text-foreground disabled:opacity-60"
                    >
                      {reported[q.position] ? "Reported, thanks" : "Report this question"}
                    </button>
                  ) : null}
                  {result ? (
                    <span className="rounded-full bg-secondary px-3 py-1 text-sm">
                      {result.unmarked
                        ? "Not marked"
                        : `${result.marksAwarded} / ${result.maxMarks}`}
                    </span>
                  ) : null}
                </div>
              </div>
              <TaskBody
                key={`${q.id}-${run}`}
                text={head.text}
                values={widgetVals[q.position] ?? {}}
                onChange={(id, v) =>
                  setWidgetVals((w) => ({
                    ...w,
                    [q.position]: { ...(w[q.position] ?? {}), [id]: v },
                  }))
                }
                disabled={locked}
              />

              <textarea
                value={responses[q.position] ?? ""}
                onChange={(e) => setResponses((r) => ({ ...r, [q.position]: e.target.value }))}
                disabled={locked}
                maxLength={MAX_ANSWER_CHARS}
                rows={Math.min(14, Math.max(4, Math.round(qMarks / 1.5)))}
                placeholder="Write your answer here. Label each part, for example (a), (b)…"
                style={{
                  backgroundImage:
                    "repeating-linear-gradient(transparent, transparent 27px, var(--border) 27px, var(--border) 28px)",
                  lineHeight: "28px",
                }}
                className="mt-3 w-full rounded-md border border-border bg-background px-3 py-0 text-sm outline-none focus:border-primary disabled:opacity-80"
              />
              <p className="mt-1 text-right text-xs text-muted-foreground">
                {(responses[q.position] ?? "").trim().split(/\s+/).filter(Boolean).length} words ·{" "}
                {(responses[q.position] ?? "").length} / {MAX_ANSWER_CHARS} characters
              </p>
              {exam && !marks ? (
                <details className="mt-2">
                  <summary className="cursor-pointer text-xs uppercase tracking-wide text-muted-foreground">
                    Rough working (not marked)
                  </summary>
                  <textarea
                    value={working[q.position] ?? ""}
                    onChange={(e) => setWorking((w) => ({ ...w, [q.position]: e.target.value }))}
                    rows={4}
                    placeholder="Jot calculations or sketches in words here. This is not sent for marking."
                    className="mt-2 w-full rounded-md border border-dashed border-border bg-background p-3 font-mono text-xs outline-none focus:border-primary"
                  />
                </details>
              ) : null}

              {result ? (
                <div className="mt-3 rounded-md border border-border bg-surface-2 p-4 text-sm">
                  <div className="flex gap-2">
                    <Sparkles className="mt-0.5 size-4 shrink-0 text-accent" />
                    <p className="text-muted-foreground">{result.feedback}</p>
                  </div>
                  {q.mark_scheme ? (
                    <details className="mt-3">
                      <summary className="cursor-pointer text-xs uppercase tracking-wide text-muted-foreground">
                        Mark scheme
                      </summary>
                      <p className="mt-2 whitespace-pre-line text-muted-foreground">
                        {q.mark_scheme}
                      </p>
                    </details>
                  ) : null}
                </div>
              ) : null}
            </li>
          );
        })}
      </ol>

      {error ? (
        <p className="mt-4 text-sm text-destructive" role="alert">
          {error}
          {needsSignIn ? (
            <>
              {" "}
              <a href={signInHref()} className="font-medium underline underline-offset-4">
                Sign in
              </a>
            </>
          ) : null}
        </p>
      ) : null}

      <div className="mt-6 flex justify-end gap-2">
        {marks ? (
          <>
            <Button
              variant="outline"
              className="rounded-full"
              onClick={() => {
                setMarks(null);
                setResponses({});
                setWidgetVals({});
                setFlagged({});
                setError(null);
                setNeedsSignIn(false);
                setConfirmBlank(false);
                autoSubmitted.current = false;
                setRun((r) => r + 1);
                endAt.current = exam ? Date.now() + exam.minutes * 60_000 : null;
                setNow(Date.now());
              }}
            >
              Try again
            </Button>
            <Button
              className="rounded-full"
              onClick={() => {
                if (persistKey) clearExamSession(persistKey);
                onExit();
              }}
            >
              {exitLabel ? "Done" : "Back to papers"}
            </Button>
          </>
        ) : (
          <Button
            className="rounded-full"
            disabled={marking}
            onClick={() => {
              // After time is up there is nothing to confirm: one click marks what is there.
              if (!timeUp && questions.length - answeredCount > 0 && !confirmBlank)
                setConfirmBlank(true);
              else handleSubmit();
            }}
          >
            {marking
              ? "Marking your paper…"
              : timeUp
                ? "Time is up: try marking again"
                : confirmBlank
                  ? `Submit with ${questions.length - answeredCount} unanswered?`
                  : "Submit for marking"}
          </Button>
        )}
      </div>
    </div>
  );
}
