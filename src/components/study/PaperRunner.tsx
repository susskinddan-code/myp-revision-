import { useEffect, useRef, useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { Sparkles } from "lucide-react";
import { Button } from "@/components/ui/button";
import { gradePaper, type PaperMark } from "@/lib/ai.functions";
import {
  fetchPaperQuestions,
  recordAttempt,
  accuracyToMypLevel,
  MYP_LEVEL_LABELS,
} from "@/lib/myp";
import { useAuth } from "@/hooks/use-auth";
import { describeResult } from "@/lib/eassessment";

type Props = {
  paper: { id: string; title: string; grade: number; criterion: string | null };
  subjectId: string;
  subjectName: string;
  onExit: () => void;
  /** eAssessment-style sitting: countdown timer and both grade scales on the result. */
  exam?: { minutes: number };
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
          return (
            <li
              key={q.id}
              className="rounded-lg border border-border bg-card p-5 shadow-[var(--shadow-soft)]"
            >
              <div className="flex items-start justify-between gap-4">
                <h3 className="font-medium">
                  {q.position}. {q.content}
                </h3>
                {result ? (
                  <span className="shrink-0 rounded-full bg-secondary px-3 py-1 text-sm">
                    {result.marksAwarded} / {result.maxMarks}
                  </span>
                ) : null}
              </div>

              <textarea
                value={responses[q.position] ?? ""}
                onChange={(e) => setResponses((r) => ({ ...r, [q.position]: e.target.value }))}
                disabled={!!marks || marking}
                rows={4}
                placeholder="Write your answer here…"
                className="mt-3 w-full rounded-md border border-border bg-background p-3 text-sm outline-none focus:border-primary disabled:opacity-80"
              />

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
