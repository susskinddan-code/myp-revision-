import { createFileRoute, Link } from "@tanstack/react-router";
import { useQuery } from "@tanstack/react-query";
import { CalendarCheck } from "lucide-react";
import { fetchDailyChallenge } from "@/lib/myp";
import { seededRandom, todayKey } from "@/lib/progress";
import { useMyGrade } from "@/lib/use-grade";
import { QuestionRunner } from "@/components/study/QuestionRunner";
import { useAuth } from "@/hooks/use-auth";

export const Route = createFileRoute("/daily")({
  head: () => ({
    meta: [
      { title: "Daily challenge — MYP Revision" },
      {
        name: "description",
        content: "Ten fresh MYP questions every day from a different subject. Build your streak.",
      },
    ],
  }),
  component: Daily,
});

function Daily() {
  const { user } = useAuth();
  const [grade] = useMyGrade();
  const day = todayKey();
  const { data, isLoading } = useQuery({
    queryKey: ["daily", grade, day],
    queryFn: () => fetchDailyChallenge(grade, seededRandom(`${day}-${grade}`)),
    staleTime: Infinity,
  });

  return (
    <div className="page-fade mx-auto max-w-[800px] px-6 py-12 md:px-12">
      <p className="flex items-center gap-2 text-sm text-muted-foreground">
        <CalendarCheck className="size-4" />
        {new Date().toLocaleDateString("en-GB", { weekday: "long", day: "numeric", month: "long" })}
        · MYP {grade}
      </p>
      <h1 className="mt-2 text-4xl">Daily challenge</h1>
      <p className="mt-2 text-muted-foreground">
        {data?.subject
          ? `Today's subject is ${data.subject.name}. Ten questions, one streak day.`
          : "Ten questions from a different subject every day. One streak day."}
      </p>
      {!user ? (
        <p className="mt-3 text-sm text-muted-foreground">
          <Link to="/auth" className="underline underline-offset-4">
            Sign in
          </Link>{" "}
          so your answers count towards your streak.
        </p>
      ) : null}

      <div className="mt-8">
        {isLoading ? (
          <p className="text-sm text-muted-foreground">Picking today&apos;s questions…</p>
        ) : data?.subject && data.questions.length ? (
          <QuestionRunner
            questions={data.questions}
            subjectName={data.subject.name}
            subjectId={data.subject.id}
            topicName="today's challenge"
            grade={grade}
          />
        ) : (
          <div className="rounded-lg border border-dashed border-border bg-card p-10 text-center text-muted-foreground">
            No questions at MYP {grade} yet. Try MYP 5 or 4, which are built first.
          </div>
        )}
      </div>
    </div>
  );
}
