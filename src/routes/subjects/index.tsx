import { createFileRoute, Link } from "@tanstack/react-router";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import { fetchSubjects, GRADES, GROUP_BG, type Subject } from "@/lib/myp";

export const Route = createFileRoute("/subjects/")({
  head: () => ({
    meta: [
      { title: "All MYP subjects — MYP Revision" },
      {
        name: "description",
        content:
          "Browse all 21 IB MYP subjects across the eight subject groups, with question banks and flashcards for Grades 1 to 5.",
      },
      { property: "og:title", content: "All MYP subjects — MYP Revision" },
      {
        property: "og:description",
        content: "Question banks and flashcards for every MYP subject group, Grades 1 to 5.",
      },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary_large_image" },
    ],
  }),
  component: SubjectsPage,
});

function SubjectsPage() {
  const [grade, setGrade] = useState(4);
  const { data: subjects, isLoading } = useQuery({
    queryKey: ["subjects", grade],
    queryFn: () => fetchSubjects(grade),
  });

  const groups = new Map<string, Subject[]>();
  for (const subject of subjects ?? []) {
    const list = groups.get(subject.subject_group) ?? [];
    list.push(subject);
    groups.set(subject.subject_group, list);
  }

  return (
    <div className="page-fade mx-auto max-w-[1200px] px-6 py-12 md:px-12">
      <h1 className="text-4xl">Subjects</h1>
      <p className="mt-2 max-w-2xl text-muted-foreground">
        All 21 MYP subjects, organised by the eight subject groups. Achievement is reported on MYP
        Levels 1 to 8.
      </p>

      <div className="mt-6 flex flex-wrap items-center gap-2">
        <span className="text-sm text-muted-foreground">Grade</span>
        {GRADES.map((g) => (
          <button
            key={g}
            type="button"
            onClick={() => setGrade(g)}
            className={`rounded-full border px-4 py-1.5 text-sm transition-colors ${
              grade === g
                ? "border-primary bg-primary text-primary-foreground"
                : "border-border bg-card hover:bg-secondary"
            }`}
          >
            MYP {g}
          </button>
        ))}
      </div>

      {isLoading ? (
        <p className="mt-10 text-muted-foreground">Loading subjects…</p>
      ) : (
        <div className="mt-10 flex flex-col gap-10">
          {[...groups.entries()].map(([groupName, groupSubjects]) => (
            <section key={groupName}>
              <h2 className="font-display text-2xl">{groupName}</h2>
              <div className="mt-4 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
                {groupSubjects.map((subject) => (
                  <Link
                    key={subject.id}
                    to="/subjects/$slug"
                    params={{ slug: subject.slug }}
                    className="card-lift overflow-hidden rounded-lg border border-border bg-card shadow-[var(--shadow-soft)]"
                  >
                    <div className={`h-2 ${GROUP_BG[subject.group_key] ?? "bg-secondary"}`} />
                    <div className="p-5">
                      <h3 className="font-display text-lg">{subject.name}</h3>
                      <p className="mt-1 line-clamp-2 text-sm text-muted-foreground">
                        {subject.description}
                      </p>
                    </div>
                  </Link>
                ))}
              </div>
            </section>
          ))}
        </div>
      )}
    </div>
  );
}
