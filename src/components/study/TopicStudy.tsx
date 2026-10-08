import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import {
  fetchQuestionsForTopics,
  fetchFlashcardsForTopics,
  fetchNoteForTopics,
  fetchRelatedPaperQuestions,
} from "@/lib/myp";
import { QuestionRunner } from "@/components/study/QuestionRunner";
import { FlashcardDeck } from "@/components/study/FlashcardDeck";
import { NoteBody } from "@/components/study/NoteBody";
import { Button } from "@/components/ui/button";

const MODES = ["Notes", "Flashcards", "Questions", "Paper questions"] as const;
type Mode = (typeof MODES)[number];

/**
 * Everything for one topic or sub-topic in a single place: the study note,
 * its flashcards, its MCQs and any practice paper questions that mention it.
 */
export function TopicStudy({
  topicIds,
  topicName,
  parentName,
  subjectId,
  subjectName,
  grade,
  onBack,
  backLabel,
}: {
  topicIds: string[];
  topicName: string;
  parentName?: string | null;
  subjectId: string;
  subjectName: string;
  grade: number;
  onBack: () => void;
  backLabel: string;
}) {
  const [mode, setMode] = useState<Mode>("Questions");
  const key = topicIds.join(",");

  const { data: questions } = useQuery({
    queryKey: ["study-questions", key],
    queryFn: () => fetchQuestionsForTopics(topicIds),
  });
  const { data: cards } = useQuery({
    queryKey: ["study-cards", key],
    queryFn: () => fetchFlashcardsForTopics(topicIds),
  });
  const { data: note } = useQuery({
    queryKey: ["study-note", key],
    queryFn: () => fetchNoteForTopics(topicIds),
  });
  const { data: paperQuestions } = useQuery({
    queryKey: ["study-paper-questions", subjectId, grade, topicName],
    queryFn: () => fetchRelatedPaperQuestions(subjectId, grade, topicName),
  });

  const counts: Record<Mode, number> = {
    Notes: note ? 1 : 0,
    Flashcards: cards?.length ?? 0,
    Questions: questions?.length ?? 0,
    "Paper questions": paperQuestions?.length ?? 0,
  };

  return (
    <div>
      <Button variant="ghost" size="sm" className="mb-4 rounded-full" onClick={onBack}>
        {backLabel}
      </Button>
      {parentName ? (
        <p className="text-xs uppercase tracking-wide text-muted-foreground">{parentName}</p>
      ) : null}
      <h2 className="font-display text-2xl">{topicName}</h2>

      <div className="mt-5 flex flex-wrap gap-2">
        {MODES.map((m) => (
          <button
            key={m}
            type="button"
            onClick={() => setMode(m)}
            className={`rounded-full border px-4 py-1.5 text-sm transition-colors ${
              mode === m
                ? "border-primary bg-primary text-primary-foreground"
                : "border-border bg-card hover:bg-secondary"
            }`}
          >
            {m} ({counts[m]})
          </button>
        ))}
      </div>

      <div className="mt-6">
        {mode === "Notes" ? (
          note ? (
            <article className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)] md:p-8">
              <NoteBody content={note.content} />
            </article>
          ) : (
            <EmptyPanel text="No study note here yet." />
          )
        ) : null}

        {mode === "Flashcards" ? (
          cards?.length ? (
            <FlashcardDeck cards={cards} />
          ) : (
            <EmptyPanel text="No flashcards here yet." />
          )
        ) : null}

        {mode === "Questions" ? (
          questions?.length ? (
            <QuestionRunner
              questions={questions}
              subjectName={subjectName}
              subjectId={subjectId}
              topicName={topicName}
              grade={grade}
              {...(cards?.length
                ? {
                    nextStep: {
                      label: "Review the flashcards",
                      onClick: () => setMode("Flashcards"),
                    },
                  }
                : note
                  ? { nextStep: { label: "Re-read the note", onClick: () => setMode("Notes") } }
                  : {})}
            />
          ) : (
            <EmptyPanel text="No questions here yet." />
          )
        ) : null}

        {mode === "Paper questions" ? (
          paperQuestions?.length ? (
            <ul className="flex flex-col gap-3">
              {paperQuestions.map((q) => (
                <li
                  key={q.id}
                  className="rounded-lg border border-border bg-card p-5 shadow-[var(--shadow-soft)]"
                >
                  <p className="text-xs uppercase tracking-wide text-muted-foreground">
                    {(q.past_papers as { title: string } | null)?.title}
                    {q.criterion ? ` · Criterion ${q.criterion}` : ""}
                  </p>
                  <p className="mt-2 text-sm">{q.content}</p>
                  {q.mark_scheme ? (
                    <details className="mt-3">
                      <summary className="cursor-pointer text-sm text-muted-foreground">
                        Mark scheme
                      </summary>
                      <p className="mt-2 whitespace-pre-line text-sm text-foreground/90">
                        {q.mark_scheme}
                      </p>
                    </details>
                  ) : null}
                </li>
              ))}
            </ul>
          ) : (
            <EmptyPanel text="No practice paper questions match this topic. Use All practice papers to sit a full paper." />
          )
        ) : null}
      </div>
    </div>
  );
}

function EmptyPanel({ text }: { text: string }) {
  return (
    <div className="rounded-lg border border-dashed border-border bg-card p-10 text-center">
      <p className="text-muted-foreground">{text}</p>
    </div>
  );
}
