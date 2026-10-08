import { useState } from "react";
import { Check, X, Sparkles, Flame, Trophy } from "lucide-react";
import { useServerFn } from "@tanstack/react-start";
import { useQueryClient } from "@tanstack/react-query";
import { Button } from "@/components/ui/button";
import { QuestionVisual } from "@/components/diagrams/QuestionVisual";
import { getQuestionFeedback } from "@/lib/ai.functions";
import { recordAttempt, type Question } from "@/lib/myp";
import { encouragement } from "@/lib/progress";
import { useAuth } from "@/hooks/use-auth";

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
  const askFeedback = useServerFn(getQuestionFeedback);
  const [questions, setQuestions] = useState(initial);
  const [index, setIndex] = useState(0);
  const [selected, setSelected] = useState<number | null>(null);
  const [checked, setChecked] = useState(false);
  const [score, setScore] = useState(0);
  const [inRow, setInRow] = useState(0);
  const [bestRow, setBestRow] = useState(0);
  const [missed, setMissed] = useState<Question[]>([]);
  const [feedback, setFeedback] = useState<string | null>(null);
  const [feedbackError, setFeedbackError] = useState<string | null>(null);
  const [loadingFeedback, setLoadingFeedback] = useState(false);

  const finished = index >= questions.length;
  const question = questions[index];

  function restart(next: Question[]) {
    setQuestions(next);
    setIndex(0);
    setScore(0);
    setInRow(0);
    setBestRow(0);
    setMissed([]);
    setSelected(null);
    setChecked(false);
    setFeedback(null);
    setFeedbackError(null);
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

  async function handleCheck() {
    if (selected === null || !question) return;
    const correct = selected === question.answer;
    setChecked(true);
    if (correct) {
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
        correct,
      })
        .then(() => queryClient.invalidateQueries({ queryKey: ["attempts", user.id] }))
        .catch(() => {});
    }

    if (!correct) {
      setLoadingFeedback(true);
      try {
        const result = await askFeedback({
          data: {
            subject: subjectName,
            topic: topicName,
            grade,
            question: question.content,
            options,
            correctIndex: question.answer,
            studentIndex: selected,
            explanation: question.explanation,
          },
        });
        setFeedback(result.feedback);
        setFeedbackError(result.error);
      } catch {
        setFeedbackError("Feedback could not be loaded right now.");
      } finally {
        setLoadingFeedback(false);
      }
    }
  }

  function handleNext() {
    const last = index + 1 >= questions.length;
    setIndex((i) => i + 1);
    setSelected(null);
    setChecked(false);
    setFeedback(null);
    setFeedbackError(null);
    if (last) onFinish?.(score, questions.length);
  }

  const isCorrect = checked && selected === question.answer;

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

      <ul className="mt-4 flex flex-col gap-2">
        {options.map((option, i) => {
          const chosen = selected === i;
          const right = checked && i === question.answer;
          const wrongChoice = checked && chosen && i !== question.answer;
          return (
            <li key={i}>
              <button
                type="button"
                disabled={checked}
                onClick={() => setSelected(i)}
                className={`flex w-full items-center gap-3 rounded-md border px-4 py-3 text-left transition-colors ${
                  right
                    ? "border-success bg-success/10"
                    : wrongChoice
                      ? "border-destructive bg-destructive/10"
                      : chosen
                        ? "border-primary bg-primary/10"
                        : "border-border bg-background hover:bg-secondary"
                }`}
              >
                <span className="flex size-6 shrink-0 items-center justify-center rounded-full border border-border text-xs">
                  {String.fromCharCode(65 + i)}
                </span>
                <span className="flex-1 text-sm">{option}</span>
                {right ? <Check className="size-4 text-success" /> : null}
                {wrongChoice ? <X className="size-4 text-destructive" /> : null}
              </button>
            </li>
          );
        })}
      </ul>

      {checked ? (
        <div
          className={`mt-5 rounded-md border p-4 ${
            isCorrect ? "border-success/40 bg-success/5" : "border-border bg-surface-2"
          }`}
        >
          <p className="font-medium">{encouragement(inRow, isCorrect)}</p>
          {question.explanation ? (
            <p className="mt-1 text-sm text-muted-foreground">{question.explanation}</p>
          ) : null}
          {!isCorrect ? (
            <div className="mt-3 flex gap-2 text-sm">
              <Sparkles className="mt-0.5 size-4 shrink-0 text-accent" />
              <p className="text-muted-foreground">
                {loadingFeedback
                  ? "Thinking about your answer…"
                  : (feedback ?? feedbackError ?? "")}
              </p>
            </div>
          ) : null}
        </div>
      ) : null}

      <div className="mt-6 flex justify-end">
        {checked ? (
          <Button className="rounded-full" onClick={handleNext}>
            {index + 1 === questions.length ? "Finish" : "Next question"}
          </Button>
        ) : (
          <Button className="rounded-full" disabled={selected === null} onClick={handleCheck}>
            Check answer
          </Button>
        )}
      </div>
    </div>
  );
}
