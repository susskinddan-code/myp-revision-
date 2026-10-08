import { createFileRoute, Link } from "@tanstack/react-router";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import { ExternalLink, FileText } from "lucide-react";
import { fetchAllPapers } from "@/lib/myp";
import { EASSESSMENT_AREAS } from "@/lib/eassessment";

export const Route = createFileRoute("/past-papers")({
  head: () => ({
    meta: [
      { title: "Practice papers — MYP Revision" },
      {
        name: "description",
        content:
          "Exam-style written practice papers for the MYP 5 eAssessment subjects, plus links to the IB's official eAssessment information.",
      },
    ],
  }),
  component: PastPapers,
});

const GRADE = 5;

function PastPapers() {
  const [areaKey, setAreaKey] = useState<string>("all");
  const { data: papers, isLoading } = useQuery({
    queryKey: ["all-papers", GRADE],
    queryFn: () => fetchAllPapers(GRADE),
  });

  const rows = (papers ?? [])
    .map((p) => {
      const subject = p.subjects as { name: string; slug: string } | null;
      const area = EASSESSMENT_AREAS.find((a) => subject && a.slugs.includes(subject.slug));
      return { p, subject, area };
    })
    .filter((r) => r.subject && r.area && (areaKey === "all" || r.area.key === areaKey));

  return (
    <div className="page-fade mx-auto max-w-[1200px] px-6 py-12 md:px-12">
      <h1 className="text-4xl">Practice papers</h1>
      <p className="mt-2 max-w-2xl text-muted-foreground">
        Written, exam-style papers for MYP 5, marked by AI against a mark scheme. They follow the
        real format (an unseen stimulus, then parts that build up to a longer answer) but every
        question is original.
      </p>

      <div className="mt-6 flex flex-wrap gap-2">
        {[
          { key: "all", name: "All exams" },
          ...EASSESSMENT_AREAS.filter((a) => a.slugs.length),
        ].map((a) => (
          <button
            key={a.key}
            type="button"
            onClick={() => setAreaKey(a.key)}
            className={`rounded-full border px-4 py-1.5 text-sm transition-colors ${
              areaKey === a.key
                ? "border-primary bg-primary text-primary-foreground"
                : "border-border bg-card hover:bg-secondary"
            }`}
          >
            {a.name}
          </button>
        ))}
      </div>

      <div className="mt-8">
        {isLoading ? (
          <p className="text-sm text-muted-foreground">Loading papers…</p>
        ) : rows.length ? (
          <ul className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {rows.map(({ p, subject, area }) => (
              <li key={p.id}>
                <Link
                  to="/eassessment/$area"
                  params={{ area: area!.key }}
                  search={{ subject: subject!.slug, tab: "Timed paper", paper: p.id }}
                  className="card-lift flex h-full flex-col rounded-lg border border-border bg-card p-5 shadow-[var(--shadow-soft)]"
                >
                  <FileText className="size-5 text-primary" />
                  <h2 className="mt-3 font-display text-lg">{p.title}</h2>
                  <p className="mt-1 text-sm text-muted-foreground">
                    {area!.name} · {p.paper_questions?.[0]?.count ?? 0} questions · timed · AI
                    marked
                  </p>
                </Link>
              </li>
            ))}
          </ul>
        ) : (
          <div className="rounded-lg border border-dashed border-border bg-card p-10 text-center text-muted-foreground">
            No papers here yet.
          </div>
        )}
      </div>

      <section className="mt-12 rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
        <h2 className="font-display text-2xl">Official IB information</h2>
        <p className="mt-2 text-sm text-muted-foreground">
          The IB does not publish its past eAssessment papers, so they are not on this site. Use the
          IB&apos;s own pages for the official format, and ask your school coordinator what official
          practice material your school has access to.
        </p>
        <ul className="mt-4 flex flex-col gap-2 text-sm">
          <li>
            <a
              className="inline-flex items-center gap-1.5 underline underline-offset-4"
              href="https://ibo.org/myp-eassessment/"
              target="_blank"
              rel="noreferrer"
            >
              IB: MYP eAssessment overview <ExternalLink className="size-3.5" />
            </a>
          </li>
          <li>
            <a
              className="inline-flex items-center gap-1.5 underline underline-offset-4"
              href="https://www-prod.ibo.org/globalassets/new-structure/programmes/myp/pdfs/myp-eassessment-factsheet-en.pdf"
              target="_blank"
              rel="noreferrer"
            >
              IB: MYP eAssessment factsheet (PDF) <ExternalLink className="size-3.5" />
            </a>
          </li>
        </ul>
      </section>
    </div>
  );
}
