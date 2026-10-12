import { useState } from "react";
import { Check, X, Sparkles, Flame, Trophy } from "lucide-react";
import { useServerFn } from "@tanstack/react-start";
import { useQueryClient } from "@tanstack/react-query";
import { Button } from "@/components/ui/button";
import { QuestionVisual } from "@/components/diagrams/QuestionVisual";
import { checkTypedAnswer, reportCachedCheck } from "@/lib/ai.functions";
import { localCheck, localHint } from "@/lib/typed-answer";
import { Input } from "@/components/ui/input";
import { recordAttempt, type Question } from "@/lib/myp";
import { encouragement } from "@/lib/progress";
import { useAuth } from "@/hooks/use-auth";

type Verdict = "correct" | "partial" | "wrong";

type Props = {
  questions: Question[];
  subjectName: string;
  subjectId: string;
  topicName: string;
  grade: number;
  /** Optional shortcut shown on the finish screen, e.g. jump to flashcards. */
  nextStep?: { label: string; onClick: () => void };
  /** Optional hook when the set is finished (used by exam-style mixed tests). */
  onFinish?: (score: number, total: number) => void;
};

export function QuestionRunner({
  questions: initial,
  subjectName,
  subjectId,
  topicName,
  grade,
  nextStep,
  onFinish,
}: Props) {
  const { user } = useAuth();
  const queryClient = useQueryClient();
  const askCheck = useServerFn(checkTypedAnswer);
  const reportCheck = useServerFn(reportCachedCheck);
  const [questions, setQuestions] = useState(initial);
  const [index, setIndex] = useState(0);
  const [input, setInput] = useState("");
  const [history, setHistory] = useState<
    { answer: string; verdict: Verdict; feedback: string; reported?: boolean }[]
  >([]);
  const [status, setStatus] = useState<"answering" | "solved" | "revealed">("answering");
  const [checking, setChecking] = useState(false);
  const checked = status !== "answering";
  const [score, setScore] = useState(0);
  const [inRow, setInRow] = useState(0);
  const [bestRow, setBestRow] = useState(0);
  const [missed, setMissed] = useState<Question[]>([]);

  const finished = index >= questions.length;
  const question = questions[index];

  function restart(next: Question[]) {
    setQuestions(next);
    setIndex(0);
    setScore(0);
    setInRow(0);
    setBestRow(0);
    setMissed([]);
    resetQuestion();
  }

  function resetQuestion() {
    setInput("");
    setHistory([]);
    setStatus("answering");
  }

  if (finished) {
    const pct = Math.round((score / Math.max(1, questions.length)) * 100);
    const headline =
      pct >= 90
        ? "Outstanding"
        : pct >= 75
          ? "Great work"
          : pct >= 50
            ? "Solid progress"
            : "Good start";
    return (
      <div className="rounded-lg border border-border bg-card p-8 text-center shadow-[var(--shadow-soft)]">
        <Trophy className="mx-auto size-10 text-accent" />
        <h3 className="mt-3 text-2xl">{headline}</h3>
        <p className="mt-1 text-4xl font-display">
          {score} / {questions.length}
        </p>
        <p className="mt-1 text-sm text-muted-foreground">
          {pct}% · best run {bestRow} in a row · +{score * 10 + missed.length * 4} XP
        </p>
        {!user ? (
          <p className="mt-3 text-sm text-muted-foreground">
            Sign in to save your streak and see your progress build up.
          </p>
        ) : null}
        <div className="mt-6 flex flex-wrap justify-center gap-2">
          {missed.length ? (
            <Button className="rounded-full" onClick={() => restart(missed)}>
              Retry the {missed.length} you missed
            </Button>
          ) : null}
          {nextStep ? (
            <Button variant="outline" className="rounded-full" onClick={nextStep.onClick}>
              {nextStep.label}
            </Button>
          ) : null}
          <Button variant="outline" className="rounded-full" onClick={() => restart(initial)}>
            Start again
          </Button>
        </div>
      </div>
    );
  }
  if (!question) return null;
  const options = (question.options as string[]) ?? [];
  const correctText = String(options[question.answer] ?? "");
  const needsOptions =
    /which of the following|which one of|which statement|select|choose|from the (list|options)/i.test(
      question.content,
    );

  function resolve(firstTry: boolean, how: "solved" | "revealed") {
    if (!question) return;
    setStatus(how);
    if (firstTry) {
      setScore((s) => s + 1);
      setInRow((r) => {
        setBestRow((b) => Math.max(b, r + 1));
        return r + 1;
      });
    } else {
      setInRow(0);
      setMissed((m) => [...m, question]);
    }
    if (user) {
      recordAttempt(user.id, {
        questionId: question.id,
        topicId: question.topic_id,
        subjectId: question.subject_id ?? subjectId,
        source: "question-bank",
        correct: firstTry,
      })
        .then(() => queryClient.invalidateQueries({ queryKey: ["attempts", user.id] }))
        .catch(() => {});
    }
  }

  async function handleCheck() {
    const answer = input.trim();
    if (!answer || !question || checking) return;
    const attempt = history.length + 1;
    setChecking(true);
    let verdict: Verdict;
    let feedback: string;
    try {
      const res = await askCheck({
        data: {
          questionId: question.id,
          subject: subjectName,
          topic: topicName,
          grade,
          question: question.content,
          correctAnswer: correctText,
          explanation: question.explanation,
          studentAnswer: answer,
          attempt,
          history: history.map((h) => ({ answer: h.answer, feedback: h.feedback })),
        },
      });
      if (!res.check) throw new Error(res.error ?? "no check");
      verdict = res.check.verdict;
      feedback = res.check.feedback;
    } catch {
      // AI checker unavailable: fall back to a plain match and generic hints.
      if (localCheck(answer, correctText)) {
        verdict = "correct";
        feedback = "That's right.";
      } else {
        verdict = "wrong";
        feedback = localHint(attempt, topicName, question.explanation);
      }
    }
    setHistory((h) => [...h, { answer, verdict, feedback }]);
    setInput("");
    setChecking(false);
    if (verdict === "correct") resolve(attempt === 1, "solved");
    else if (attempt >= 5) resolve(false, "revealed");
  }

  function handleNext() {
    const last = index + 1 >= questions.length;
    setIndex((i) => i + 1);
    resetQuestion();
    if (last) onFinish?.(score, questions.length);
  }

  const isCorrect = status === "solved";
  const lastTry = history[history.length - 1];

  return (
    <div className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
      <div className="flex items-center justify-between text-sm text-muted-foreground">
        <span>
          Question {index + 1} of {questions.length}
        </span>
        <span className="flex items-center gap-3">
          {inRow >= 2 ? (
            <span className="flex items-center gap-1 font-medium text-accent">
              <Flame className="size-4" />
              {inRow}
            </span>
          ) : null}
          <span className="capitalize">{question.difficulty}</span>
        </span>
      </div>
      <div className="mt-3 h-1.5 overflow-hidden rounded-full bg-secondary">
        <div
          className="h-full rounded-full bg-primary transition-all"
          style={{ width: `${((index + (checked ? 1 : 0)) / questions.length) * 100}%` }}
        />
      </div>

      <h3 className="mt-5 font-display text-xl">{question.content}</h3>
      <QuestionVisual visual={question.visual} />

      {needsOptions ? (
        <ul className="mt-3 list-disc pl-6 text-sm text-muted-foreground">
          {options.map((o, i) => (
            <li key={i}>{o}</li>
          ))}
        </ul>
      ) : null}

      {history.length ? (
        <ul className="mt-4 flex flex-col gap-2">
          {history.map((h, i) => (
            <li
              key={i}
              className={`rounded-md border p-3 text-sm ${
                h.verdict === "correct"
                  ? "border-success/40 bg-success/5"
                  : h.verdict === "partial"
                    ? "border-accent/50 bg-accent/5"
                    : "border-border bg-surface-2"
              }`}
            >
              <p className="flex items-center gap-2 font-medium">
                {h.verdict === "correct" ? (
                  <Check className="size-4 text-success" />
                ) : h.verdict === "partial" ? (
                  <Sparkles className="size-4 text-accent" />
                ) : (
                  <X className="size-4 text-destructive" />
                )}
                {h.answer}
                <span className="text-xs font-normal text-muted-foreground">
                  {h.verdict === "correct"
                    ? "correct"
                    : h.verdict === "partial"
                      ? "half right"
                      : "not yet"}
                </span>
              </p>
              <p className="mt-1 text-muted-foreground">{h.feedback}</p>
              {i === 0 && h.verdict !== "correct" ? (
                <button
                  type="button"
                  disabled={h.reported}
                  className="mt-1 text-xs text-muted-foreground underline underline-offset-2 hover:text-foreground disabled:no-underline"
                  onClick={() => {
                    setHistory((all) =>
                      all.map((x, k) => (k === i ? { ...x, reported: true } : x)),
                    );
                    void reportCheck({
                      data: { questionId: question.id, answer: h.answer },
                    }).catch(() => {});
                  }}
                >
                  {h.reported ? "Thanks, we'll recheck it" : "This feedback is wrong"}
                </button>
              ) : null}
            </li>
          ))}
        </ul>
      ) : null}

      {!checked ? (
        <form
          className="mt-4 flex flex-col gap-3 sm:flex-row"
          onSubmit={(e) => {
            e.preventDefault();
            void handleCheck();
          }}
        >
          <Input
            value={input}
            autoFocus
            onChange={(e) => setInput(e.target.value)}
            placeholder={history.length ? "Try again…" : "Type your answer"}
            className="flex-1"
            disabled={checking}
          />
          <Button type="submit" className="rounded-full" disabled={!input.trim() || checking}>
            {checking ? "Checking…" : "Check answer"}
          </Button>
        </form>
      ) : (
        <div
          className={`mt-5 rounded-md border p-4 ${
            isCorrect ? "border-success/40 bg-success/5" : "border-border bg-surface-2"
          }`}
        >
          <p className="font-medium">
            {isCorrect
              ? history.length === 1
                ? encouragement(inRow, true)
                : "Got it. You worked it out."
              : `The answer is: ${correctText}`}
          </p>
          {question.explanation ? (
            <p className="mt-1 text-sm text-muted-foreground">{question.explanation}</p>
          ) : null}
        </div>
      )}

      <div className="mt-6 flex items-center justify-between">
        {!checked && history.length >= 2 && lastTry?.verdict !== "correct" ? (
          <Button variant="ghost" size="sm" onClick={() => resolve(false, "revealed")}>
            Show answer
          </Button>
        ) : (
          <span />
        )}
        {checked ? (
          <Button className="rounded-full" onClick={handleNext}>
            {index + 1 === questions.length ? "Finish" : "Next question"}
          </Button>
        ) : null}
      </div>
    </div>
  );
}
