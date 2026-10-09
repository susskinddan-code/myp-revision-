import { useEffect, useRef, useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { Flag, Sigma, Sparkles } from "lucide-react";
import { Button } from "@/components/ui/button";
import { gradePaper, type PaperMark } from "@/lib/ai.functions";
import {
  fetchPaperQuestions,
  recordAttempt,
  accuracyToMypLevel,
  marksOf,
  MYP_LEVEL_LABELS,
} from "@/lib/myp";
import { useAuth } from "@/hooks/use-auth";
import { describeResult, type FormulaGroup } from "@/lib/eassessment";

type Props = {
  paper: { id: string; title: string; grade: number; criterion: string | null };
  subjectId: string;
  subjectName: string;
  onExit: () => void;
  /** eAssessment-style sitting: countdown timer and both grade scales on the result. */
  exam?: { minutes: number; formulas?: FormulaGroup[] | null };
};

export function PaperRunner({ paper, subjectId, subjectName, onExit, exam }: Props) {
  const { user } = useAuth();
  const mark = useServerFn(gradePaper);
  const [responses, setResponses] = useState<Record<number, string>>({});
  const [marks, setMarks] = useState<PaperMark[] | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [marking, setMarking] = useState(false);
  const [secondsLeft, setSecondsLeft] = useState<number | null>(exam ? exam.minutes * 60 : null);
  const submitRef = useRef<() => void>(() => {});
  const [flagged, setFlagged] = useState<Record<number, boolean>>({});
  const [working, setWorking] = useState<Record<number, string>>({});
  const [showFormulas, setShowFormulas] = useState(false);

  useEffect(() => {
    if (secondsLeft === null || marks || marking) return;
    if (secondsLeft <= 0) {
      submitRef.current();
      return;
    }
    const t = setTimeout(() => setSecondsLeft((s) => (s === null ? s : s - 1)), 1000);
    return () => clearTimeout(t);
  }, [secondsLeft, marks, marking]);

  const { data: questions, isLoading } = useQuery({
    queryKey: ["paper-questions", paper.id],
    queryFn: () => fetchPaperQuestions(paper.id),
  });

  async function handleSubmit() {
    if (!questions?.length) return;
    setMarking(true);
    setError(null);
    try {
      const result = await mark({
        data: {
          subject: subjectName,
          grade: paper.grade,
          paperTitle: paper.title,
          criterion: paper.criterion,
          answers: questions.map((q) => ({
            position: q.position,
            question: q.content,
            markScheme: q.mark_scheme,
            response: responses[q.position] ?? "",
          })),
        },
      });
      if (result.marks) {
        setMarks(result.marks);
        if (user) {
          for (const m of result.marks) {
            recordAttempt(user.id, {
              subjectId,
              source: "practice-paper",
              correct: m.marksAwarded >= m.maxMarks / 2,
            }).catch(() => {});
          }
        }
      } else {
        setError(result.error);
      }
    } catch {
      setError("Your paper could not be marked right now. Try again.");
    } finally {
      setMarking(false);
    }
  }

  submitRef.current = handleSubmit;

  if (isLoading) {
    return <p className="text-sm text-muted-foreground">Loading paper…</p>;
  }
  if (!questions?.length) {
    return <p className="text-sm text-muted-foreground">This paper has no questions.</p>;
  }

  const awarded = marks?.reduce((t, m) => t + m.marksAwarded, 0) ?? 0;
  const total = marks?.reduce((t, m) => t + m.maxMarks, 0) ?? 0;
  const level = total ? accuracyToMypLevel(awarded / total) : 0;
  const both = total ? describeResult(awarded / total) : null;
  const answeredCount = questions.filter(
    (q) => (responses[q.position] ?? "").trim().length > 0,
  ).length;
  const flaggedCount = questions.filter((q) => flagged[q.position]).length;
  const clock =
    secondsLeft === null
      ? null
      : `${Math.floor(secondsLeft / 60)}:${String(secondsLeft % 60).padStart(2, "0")}`;

  return (
    <div>
      <Button variant="ghost" size="sm" className="mb-4 rounded-full" onClick={onExit}>
        All practice papers
      </Button>
      <h2 className="font-display text-2xl">{paper.title}</h2>
      <p className="mt-1 text-sm text-muted-foreground">
        {questions.length} written-answer questions · MYP {paper.grade}
        {marks ? null : " · answer each one, then submit for marking"}
      </p>
      {clock && !marks ? (
        <div
          className={`sticky top-16 z-30 mt-3 flex items-center justify-between rounded-full border px-4 py-2 text-sm ${
            (secondsLeft ?? 0) < 300
              ? "border-destructive bg-destructive/10 text-destructive"
              : "border-border bg-card"
          }`}
        >
          <span>Exam mode</span>
          <span className="font-mono text-base tabular-nums">{clock}</span>
        </div>
      ) : null}

      {exam && !marks ? (
        <div className="sticky top-28 z-20 mt-3 rounded-lg border border-border bg-card p-3 shadow-[var(--shadow-soft)]">
          <div className="flex flex-wrap items-center gap-2">
            <span className="mr-1 text-xs uppercase tracking-wide text-muted-foreground">
              Questions
            </span>
            {questions.map((q) => {
              const answered = (responses[q.position] ?? "").trim().length > 0;
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
          <p className="mt-2 text-xs text-muted-foreground">
            {answeredCount} of {questions.length} answered · {flaggedCount} flagged for review
          </p>
          {showFormulas && exam.formulas ? (
            <div className="mt-3 max-h-64 overflow-y-auto rounded-md border border-border bg-surface-2 p-3 text-sm">
              {exam.formulas.map((g) => (
                <div key={g.title} className="mb-3 last:mb-0">
                  <p className="text-xs uppercase tracking-wide text-muted-foreground">{g.title}</p>
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

      {marks ? (
        <div className="mt-6 rounded-lg border border-border bg-card p-6 text-center shadow-[var(--shadow-soft)]">
          <p className="font-display text-4xl">
            {Math.round(awarded * 10) / 10} / {total}
          </p>
          <p className="mt-1 text-sm text-muted-foreground">
            {Math.round((awarded / total) * 100)}% · MYP Level {level} of 8 —{" "}
            {MYP_LEVEL_LABELS[level]}
          </p>
          {exam && both ? (
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
          return (
            <li
              key={q.id}
              id={`pq-${q.position}`}
              className="scroll-mt-60 rounded-lg border border-border bg-card p-5 shadow-[var(--shadow-soft)]"
            >
              <div className="flex items-start justify-between gap-4">
                <p className="text-xs uppercase tracking-wide text-muted-foreground">
                  Question {q.position}
                  {qMarks ? ` · ${qMarks} marks` : ""}
                  {q.criterion ? ` · Criterion ${q.criterion}` : ""}
                </p>
                <div className="flex shrink-0 items-center gap-2">
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
                  {result ? (
                    <span className="rounded-full bg-secondary px-3 py-1 text-sm">
                      {result.marksAwarded} / {result.maxMarks}
                    </span>
                  ) : null}
                </div>
              </div>
              <p className="mt-2 whitespace-pre-line font-medium leading-relaxed">{q.content}</p>

              <textarea
                value={responses[q.position] ?? ""}
                onChange={(e) => setResponses((r) => ({ ...r, [q.position]: e.target.value }))}
                disabled={!!marks || marking}
                rows={Math.min(14, Math.max(4, Math.round(qMarks / 1.5)))}
                placeholder="Write your answer here. Label each part, for example (a), (b)…"
                className="mt-3 w-full rounded-md border border-border bg-background p-3 text-sm outline-none focus:border-primary disabled:opacity-80"
              />
              <p className="mt-1 text-right text-xs text-muted-foreground">
                {(responses[q.position] ?? "").trim().split(/\s+/).filter(Boolean).length} words
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

      {error ? <p className="mt-4 text-sm text-destructive">{error}</p> : null}

      <div className="mt-6 flex justify-end gap-2">
        {marks ? (
          <>
            <Button
              variant="outline"
              className="rounded-full"
              onClick={() => {
                setMarks(null);
                setResponses({});
                setError(null);
              }}
            >
              Try again
            </Button>
            <Button className="rounded-full" onClick={onExit}>
              Back to papers
            </Button>
          </>
        ) : (
          <Button className="rounded-full" disabled={marking} onClick={handleSubmit}>
            {marking ? "Marking your paper…" : "Submit for marking"}
          </Button>
        )}
      </div>
    </div>
  );
}
