import { createFileRoute, Link } from "@tanstack/react-router";
import { ArrowRight, Clock, Target, CalendarDays } from "lucide-react";
import { EASSESSMENT_AREAS, daysToMaySession, formatDuration } from "@/lib/eassessment";

export const Route = createFileRoute("/eassessment/")({
  head: () => ({
    meta: [
      { title: "MYP eAssessment practice — MYP Revision" },
      {
        name: "description",
        content:
          "Prepare for the MYP 5 eAssessment on-screen exams: timed practice papers, readiness tracking, exam technique and both grade scales explained.",
      },
      { property: "og:title", content: "MYP eAssessment practice — MYP Revision" },
      { property: "og:type", content: "website" },
    ],
  }),
  component: EAssessmentHub,
});

function EAssessmentHub() {
  const days = daysToMaySession();
  return (
    <div className="page-fade">
      <section className="dot-grid">
        <div className="mx-auto max-w-[1200px] px-6 py-14 md:px-12 md:py-20">
          <p className="text-sm uppercase tracking-[0.2em] text-muted-foreground">
            MYP 5 · Grade 10 · eAssessment
          </p>
          <h1 className="mt-3 max-w-3xl text-4xl leading-tight md:text-5xl">
            Practise the exam you will actually sit.
          </h1>
          <p className="mt-4 max-w-2xl text-lg text-muted-foreground">
            Six on-screen exams make up the MYP eAssessment. Pick your exam, check what you are
            ready for, then sit timed papers and mixed tests until it feels familiar.
          </p>
          <div className="mt-6 inline-flex items-center gap-3 rounded-full border border-border bg-card px-5 py-2.5 text-sm shadow-[var(--shadow-soft)]">
            <CalendarDays className="size-4 text-primary" />
            <span>
              <strong>{days}</strong> days to 1 May. Your exact session dates come from your school
              and the IB timetable.
            </span>
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-[1200px] px-6 py-12 md:px-12">
        <h2 className="font-display text-3xl">Choose your exam</h2>
        <div className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {EASSESSMENT_AREAS.map((area) => (
            <Link
              key={area.key}
              to="/eassessment/$area"
              params={{ area: area.key }}
              className="card-lift overflow-hidden rounded-lg border border-border bg-card shadow-[var(--shadow-soft)]"
            >
              <div className={`h-2 ${area.bg}`} />
              <div className="flex h-full flex-col p-6">
                <h3 className="font-display text-xl">{area.name}</h3>
                <p className="mt-2 text-sm text-muted-foreground">{area.blurb}</p>
                <p className="mt-4 flex items-center gap-2 text-xs text-muted-foreground">
                  <Clock className="size-3.5" />
                  {formatDuration(area.minutes)} on screen
                </p>
                <span className="mt-4 inline-flex items-center gap-1 text-sm font-medium text-primary">
                  {area.slugs.length ? "Start practising" : "See the format"}
                  <ArrowRight className="size-4" />
                </span>
              </div>
            </Link>
          ))}
        </div>
        <p className="mt-4 text-sm text-muted-foreground">
          Arts, Design and Physical & Health Education are assessed by ePortfolio, not an on-screen
          exam, so they are not in this section. You can still revise them under Subjects.
        </p>
      </section>

      <section className="mx-auto max-w-[1200px] px-6 pb-20 md:px-12">
        <div className="grid gap-4 md:grid-cols-2">
          <div className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
            <Target className="size-5 text-primary" />
            <h3 className="mt-3 font-display text-xl">Two scales, kept separate</h3>
            <p className="mt-2 text-sm text-muted-foreground">
              Inside your subject, each criterion is reported on <strong>Levels 1 to 8</strong>. The
              eAssessment itself reports one <strong>overall grade from 1 to 7</strong> for each
              exam. Every eAssessment-style result here shows both, clearly labelled.
            </p>
          </div>
          <div className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
            <Clock className="size-5 text-primary" />
            <h3 className="mt-3 font-display text-xl">Practice, not real papers</h3>
            <p className="mt-2 text-sm text-muted-foreground">
              Real IB papers are not publicly available, so every paper here is original, exam-style
              and AI marked. The grade shown is an estimate: the IB sets its own grade boundaries
              each session.
            </p>
          </div>
        </div>
      </section>
    </div>
  );
}
