import { useState } from "react";
import { Check, X, Sparkles } from "lucide-react";
import { useServerFn } from "@tanstack/react-start";
import { Button } from "@/components/ui/button";
import { QuestionVisual } from "@/components/diagrams/QuestionVisual";
import { getQuestionFeedback } from "@/lib/ai.functions";
import { recordAttempt, type Question } from "@/lib/myp";
import { useAuth } from "@/hooks/use-auth";

type Props = {
  questions: Question[];
  subjectName: string;
  subjectId: string;
  topicName: string;
  grade: number;
};

export function QuestionRunner({ questions, subjectName, subjectId, topicName, grade }: Props) {
  const { user } = useAuth();
  const askFeedback = useServerFn(getQuestionFeedback);
  const [index, setIndex] = useState(0);
  const [selected, setSelected] = useState<number | null>(null);
  const [checked, setChecked] = useState(false);
  const [score, setScore] = useState(0);
  const [feedback, setFeedback] = useState<string | null>(null);
  const [feedbackError, setFeedbackError] = useState<string | null>(null);
  const [loadingFeedback, setLoadingFeedback] = useState(false);

  const question = questions[index];
  if (!question) return null;
  const options = (question.options as string[]) ?? [];
  const finished = index >= questions.length;

  async function handleCheck() {
    if (selected === null || !question) return;
    const correct = selected === question.answer;
    setChecked(true);
    if (correct) setScore((s) => s + 1);

    if (user) {
      recordAttempt(user.id, {
        questionId: question.id,
        topicId: question.topic_id,
        subjectId,
        source: "question-bank",
        correct,
      }).catch(() => {});
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
    setIndex((i) => i + 1);
    setSelected(null);
    setChecked(false);
    setFeedback(null);
    setFeedbackError(null);
  }

  if (finished) {
    return (
      <div className="rounded-lg border border-border bg-card p-8 text-center shadow-[var(--shadow-soft)]">
        <h3 className="text-2xl">Set complete</h3>
        <p className="mt-2 text-muted-foreground">
          You scored {score} out of {questions.length}.
        </p>
        <Button
          className="mt-6 rounded-full"
          onClick={() => {
            setIndex(0);
            setScore(0);
            setSelected(null);
            setChecked(false);
            setFeedback(null);
            setFeedbackError(null);
          }}
        >
          Start again
        </Button>
      </div>
    );
  }

  const isCorrect = checked && selected === question.answer;

  return (
    <div className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
      <div className="flex items-center justify-between text-sm text-muted-foreground">
        <span>
          Question {index + 1} of {questions.length}
        </span>
        <span className="capitalize">{question.difficulty}</span>
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
        <div className="mt-5 rounded-md border border-border bg-surface-2 p-4">
          <p className="font-medium">{isCorrect ? "Correct" : "Not quite"}</p>
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
