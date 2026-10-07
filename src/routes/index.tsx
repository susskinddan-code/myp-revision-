import { createFileRoute, Link } from "@tanstack/react-router";
import { useQuery } from "@tanstack/react-query";
import { BookOpen, Layers, Sparkles, LineChart } from "lucide-react";
import { fetchSubjects, GROUP_BG } from "@/lib/myp";
import { Button } from "@/components/ui/button";

export const Route = createFileRoute("/")({
  head: () => ({
    meta: [
      { title: "MYP Revision — IB MYP practice questions, flashcards & feedback" },
      {
        name: "description",
        content:
          "Revise every IB MYP subject with topic question banks, instant AI feedback and flashcards for Grades 1 to 5. Achievement on MYP Levels 1 to 8.",
      },
      {
        property: "og:title",
        content: "MYP Revision — IB MYP practice questions, flashcards & feedback",
      },
      {
        property: "og:description",
        content: "Topic question banks, instant feedback and flashcards for all 21 MYP subjects.",
      },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary_large_image" },
    ],
  }),
  component: Home,
});

const FEATURES = [
  {
    icon: BookOpen,
    title: "Topic question banks",
    body: "Multiple-choice sets built topic by topic, marked the moment you answer.",
  },
  {
    icon: Sparkles,
    title: "Feedback that explains",
    body: "Get it wrong and you get a short explanation written for your grade, not just a tick.",
  },
  {
    icon: Layers,
    title: "Flashcards",
    body: "Flip-card decks per subject and grade for quick recall between sessions.",
  },
  {
    icon: LineChart,
    title: "Progress on Levels 1-8",
    body: "Streaks, accuracy and an estimated MYP Level so you know where you stand.",
  },
];

function Home() {
  const { data: subjects } = useQuery({
    queryKey: ["subjects", 4],
    queryFn: () => fetchSubjects(4),
  });

  return (
    <div className="page-fade">
      <section className="dot-grid">
        <div className="mx-auto max-w-[1200px] px-6 py-20 md:px-12 md:py-28">
          <p className="text-sm uppercase tracking-[0.2em] text-muted-foreground">
            For IB MYP Grades 1-5
          </p>
          <h1 className="mt-4 max-w-3xl text-5xl leading-tight md:text-6xl">
            Revision that actually tells you why you got it wrong.
          </h1>
          <p className="mt-5 max-w-xl text-lg text-muted-foreground">
            Question banks, flashcards and progress tracking across all 21 MYP subjects — with
            achievement reported on MYP Levels 1 to 8.
          </p>
          <div className="mt-8 flex flex-wrap gap-3">
            <Button asChild size="lg" className="rounded-full">
              <Link to="/subjects">Start revising</Link>
            </Button>
            <Button asChild size="lg" variant="outline" className="rounded-full">
              <Link to="/auth">Create a free account</Link>
            </Button>
          </div>
          <p className="mt-5 text-xs text-muted-foreground">
            Independent study resource. Not affiliated with or endorsed by the IB.
          </p>
        </div>
      </section>

      <section className="mx-auto max-w-[1200px] px-6 py-16 md:px-12">
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
          {FEATURES.map(({ icon: Icon, title, body }) => (
            <div
              key={title}
              className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]"
            >
              <span className="flex size-10 items-center justify-center rounded-full bg-secondary">
                <Icon className="size-5 text-primary" />
              </span>
              <h2 className="mt-4 font-display text-lg">{title}</h2>
              <p className="mt-2 text-sm text-muted-foreground">{body}</p>
            </div>
          ))}
        </div>
      </section>

      <section className="mx-auto max-w-[1200px] px-6 pb-20 md:px-12">
        <div className="flex items-end justify-between gap-4">
          <h2 className="font-display text-3xl">Every MYP subject group</h2>
          <Link to="/subjects" className="text-sm underline underline-offset-4">
            See all
          </Link>
        </div>
        <div className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
          {(subjects ?? []).slice(0, 8).map((subject) => (
            <Link
              key={subject.id}
              to="/subjects/$slug"
              params={{ slug: subject.slug }}
              className="card-lift overflow-hidden rounded-lg border border-border bg-card shadow-[var(--shadow-soft)]"
            >
              <div className={`h-2 ${GROUP_BG[subject.group_key] ?? "bg-secondary"}`} />
              <div className="p-5">
                <h3 className="font-display text-lg">{subject.name}</h3>
                <p className="mt-1 text-xs text-muted-foreground">{subject.subject_group}</p>
              </div>
            </Link>
          ))}
        </div>
      </section>
    </div>
  );
}
