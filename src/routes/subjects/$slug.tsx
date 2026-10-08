import { createFileRoute, Link, notFound } from "@tanstack/react-router";
import { useQuery } from "@tanstack/react-query";
import { useEffect, useState } from "react";
import {
  fetchSubjectBySlug,
  fetchTopics,
  fetchSubTopics,
  fetchFlashcards,
  fetchPapers,
  fetchNoteBadgeIds,
  fetchAttempts,
  fetchAllTopics,
  accuracyToMypLevel,
  MYP_LEVEL_LABELS,
  GRADES,
  GROUP_BG,
} from "@/lib/myp";
import { TopicStudy } from "@/components/study/TopicStudy";
import { PaperRunner } from "@/components/study/PaperRunner";
import { useAuth } from "@/hooks/use-auth";
import { useMyGrade } from "@/lib/use-grade";
import { masteryOf, STATUS_LABEL, type Mastery } from "@/lib/progress";
import { ArrowRight } from "lucide-react";
import { Button } from "@/components/ui/button";

const TABS = ["Overview", "Study", "All practice papers", "My progress"] as const;
type Tab = (typeof TABS)[number];
type SubjectSearch = { grade?: number; tab?: Tab; topic?: string };

export const Route = createFileRoute("/subjects/$slug")({
  validateSearch: (s: Record<string, unknown>): SubjectSearch => {
    const out: SubjectSearch = {};
    const g = Number(s["grade"]);
    if (g >= 1 && g <= 5) out.grade = g;
    if (TABS.includes(s["tab"] as Tab)) out.tab = s["tab"] as Tab;
    if (typeof s["topic"] === "string") out.topic = s["topic"];
    return out;
  },
  loader: async ({ params }) => {
    const subject = await fetchSubjectBySlug(params.slug);
    if (!subject) throw notFound();
    return { subject };
  },
  head: ({ loaderData }) => {
    if (!loaderData) {
      return {
        meta: [
          { title: "Subject unavailable — MYP Revision" },
          { name: "robots", content: "noindex" },
        ],
      };
    }
    const { subject } = loaderData;
    const title = `${subject.name} — MYP Revision`;
    const description =
      subject.description ??
      `MYP ${subject.name} question bank, flashcards and revision for Grades 1 to 5.`;
    return {
      meta: [
        { title },
        { name: "description", content: description },
        { property: "og:title", content: title },
        { property: "og:description", content: description },
        { property: "og:type", content: "website" },
        { name: "twitter:card", content: "summary_large_image" },
      ],
    };
  },
  component: SubjectPage,
});

function SubjectPage() {
  const { subject } = Route.useLoaderData();
  const { user } = useAuth();
  const search = Route.useSearch();
  const [savedGrade, saveGrade] = useMyGrade();
  const [pickedGrade, setPickedGrade] = useState<number | null>(null);
  const grade = pickedGrade ?? search.grade ?? savedGrade;
  const setGrade = (g: number) => {
    setPickedGrade(g);
    saveGrade(g);
  };
  const [tab, setTab] = useState<Tab>(search.tab ?? "Overview");
  /** Selected top-level topic. */
  const [parentId, setParentId] = useState<string | null>(search.topic ?? null);
  /** Selected sub-topic, or the parent id itself for "Whole topic". */
  const [topicId, setTopicId] = useState<string | null>(null);
  const [paperId, setPaperId] = useState<string | null>(null);

  const { data: topics } = useQuery({
    queryKey: ["topics", subject.id, grade],
    queryFn: () => fetchTopics(subject.id, grade),
  });
  const { data: cards } = useQuery({
    queryKey: ["flashcards", subject.id, grade],
    queryFn: () => fetchFlashcards(subject.id, grade),
  });
  const { data: papers } = useQuery({
    queryKey: ["papers", subject.id, grade],
    queryFn: () => fetchPapers(subject.id, grade),
  });
  const { data: subTopics } = useQuery({
    queryKey: ["subtopics", parentId],
    queryFn: () => fetchSubTopics(parentId!),
    enabled: !!parentId,
  });
  const { data: noteBadgeIds } = useQuery({
    queryKey: ["note-badges", subject.id, grade],
    queryFn: () => fetchNoteBadgeIds(subject.id, grade),
  });
  const { data: attempts } = useQuery({
    queryKey: ["attempts", user?.id],
    queryFn: () => fetchAttempts(user!.id),
    enabled: !!user,
  });

  const { data: allTopics } = useQuery({
    queryKey: ["all-topics", subject.id, grade],
    queryFn: () => fetchAllTopics(subject.id, grade),
  });

  const activePaper = papers?.find((p) => p.id === paperId) ?? null;
  const subjectAttempts = (attempts ?? []).filter((a) => a.subject_id === subject.id);
  const correctCount = subjectAttempts.filter((a) => a.correct).length;
  const accuracy = subjectAttempts.length ? correctCount / subjectAttempts.length : 0;
  const level = accuracyToMypLevel(accuracy);

  // Mastery per topic id, with each parent rolling up its sub-topics.
  const masteryById = new Map<string, Mastery>();
  {
    const byTopic = new Map<string, { t: number; c: number }>();
    for (const a of subjectAttempts) {
      if (!a.topic_id) continue;
      const e = byTopic.get(a.topic_id) ?? { t: 0, c: 0 };
      e.t += 1;
      if (a.correct) e.c += 1;
      byTopic.set(a.topic_id, e);
    }
    for (const t of allTopics ?? []) {
      const own = byTopic.get(t.id) ?? { t: 0, c: 0 };
      let total = own.t;
      let right = own.c;
      if (!t.parent_topic_id) {
        for (const child of allTopics ?? []) {
          if (child.parent_topic_id !== t.id) continue;
          const e = byTopic.get(child.id);
          if (e) {
            total += e.t;
            right += e.c;
          }
        }
      }
      masteryById.set(t.id, masteryOf(total, right));
    }
  }
  const lastAttempt = subjectAttempts.find((a) => a.topic_id);
  const lastTopic = lastAttempt
    ? (allTopics ?? []).find((t) => t.id === lastAttempt.topic_id)
    : null;
  const weakParent = [...(topics ?? [])]
    .map((t) => ({ t, m: masteryById.get(t.id) }))
    .filter((x) => x.m && x.m.status === "needs-work")
    .sort((a, b) => a.m!.pct - b.m!.pct)[0];
  const untouchedCount = (topics ?? []).filter(
    (t) => (masteryById.get(t.id)?.total ?? 0) === 0,
  ).length;

  function openTopic(id: string) {
    const topic = (allTopics ?? []).find((t) => t.id === id);
    setTab("Study");
    if (topic?.parent_topic_id) {
      setParentId(topic.parent_topic_id);
      setTopicId(topic.id);
    } else {
      setParentId(id);
      setTopicId(null);
    }
  }

  const activeParent = (topics ?? []).find((t) => t.id === parentId) ?? null;
  const isWholeTopic = !!topicId && topicId === parentId;
  const activeSubTopic = (subTopics ?? []).find((t) => t.id === topicId) ?? null;
  const studyTopicIds = isWholeTopic
    ? [parentId!, ...(subTopics ?? []).map((t) => t.id)]
    : topicId
      ? [topicId]
      : [];

  const resetStudy = () => {
    setTopicId(null);
    setParentId(null);
  };

  // A topic with no sub-topics opens straight into its own study page.
  useEffect(() => {
    if (parentId && subTopics && subTopics.length === 0 && !topicId) setTopicId(parentId);
  }, [parentId, subTopics, topicId]);

  return (
    <div className="page-fade">
      <div className={`${GROUP_BG[subject.group_key] ?? "bg-secondary"}`}>
        <div className="mx-auto max-w-[1200px] px-6 py-10 md:px-12">
          <Link to="/subjects" className="text-sm underline underline-offset-4">
            All subjects
          </Link>
          <h1 className="mt-3 text-4xl">{subject.name}</h1>
          <p className="mt-2 max-w-2xl text-sm">{subject.description}</p>
          <p className="mt-1 text-xs uppercase tracking-wide opacity-70">{subject.subject_group}</p>
        </div>
      </div>

      <div className="mx-auto max-w-[1200px] px-6 py-8 md:px-12">
        <div className="flex flex-wrap items-center gap-2">
          <span className="text-sm text-muted-foreground">Grade</span>
          {GRADES.map((g) => (
            <button
              key={g}
              type="button"
              onClick={() => {
                setGrade(g);
                resetStudy();
                setPaperId(null);
              }}
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

        <div className="mt-6 flex flex-wrap gap-1 border-b border-border">
          {TABS.map((t) => (
            <button
              key={t}
              type="button"
              onClick={() => setTab(t)}
              className={`-mb-px border-b-2 px-4 py-2 text-sm transition-colors ${
                tab === t
                  ? "border-primary font-medium text-foreground"
                  : "border-transparent text-muted-foreground hover:text-foreground"
              }`}
            >
              {t}
            </button>
          ))}
        </div>

        <div className="mt-8">
          {tab === "Overview" ? (
            <div className="grid gap-4 sm:grid-cols-3">
              {lastTopic ? (
                <button
                  type="button"
                  onClick={() => openTopic(lastTopic.id)}
                  className="card-lift sm:col-span-3 flex items-center justify-between gap-4 rounded-lg border border-primary/40 bg-primary/5 p-5 text-left"
                >
                  <span>
                    <span className="block text-xs uppercase tracking-wide text-muted-foreground">
                      Pick up where you left off
                    </span>
                    <span className="mt-1 block font-display text-xl">{lastTopic.name}</span>
                  </span>
                  <ArrowRight className="size-5 shrink-0 text-primary" />
                </button>
              ) : null}
              {weakParent ? (
                <button
                  type="button"
                  onClick={() => openTopic(weakParent.t.id)}
                  className="card-lift sm:col-span-3 flex items-center justify-between gap-4 rounded-lg border border-border bg-card p-5 text-left"
                >
                  <span>
                    <span className="block text-xs uppercase tracking-wide text-muted-foreground">
                      Strengthen this next · {Math.round(weakParent.m!.pct * 100)}% so far
                    </span>
                    <span className="mt-1 block font-display text-xl">{weakParent.t.name}</span>
                  </span>
                  <ArrowRight className="size-5 shrink-0 text-primary" />
                </button>
              ) : null}
              {!user ? (
                <div className="sm:col-span-3 rounded-lg border border-dashed border-border bg-card p-5 text-sm text-muted-foreground">
                  <Link to="/auth" className="underline underline-offset-4">
                    Sign in
                  </Link>{" "}
                  to save your streak, see mastery on every topic and get a "what to study next"
                  suggestion.
                </div>
              ) : untouchedCount ? (
                <p className="sm:col-span-3 text-sm text-muted-foreground">
                  {untouchedCount} of {topics?.length ?? 0} topics not started yet.
                </p>
              ) : null}
              <Stat label="Topics at MYP " value={`${topics?.length ?? 0}`} suffix={`${grade}`} />
              <Stat label="Flashcards" value={`${cards?.length ?? 0}`} />
              <Stat label="Practice papers" value={`${papers?.length ?? 0}`} />
              <div className="sm:col-span-3 rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
                <h2 className="font-display text-xl">How to revise this subject</h2>
                <p className="mt-2 text-sm text-muted-foreground">
                  Pick a topic, then a sub-topic — everything for it sits on one page: the study
                  note, flashcards, multiple-choice questions and related practice paper questions.
                  Choose Whole topic to mix a full topic together, or All practice papers to sit a
                  full AI-marked paper. Check My progress for your MYP Level 1-8 estimate.
                </p>
              </div>
            </div>
          ) : null}

          {tab === "Study" ? (
            topicId ? (
              <TopicStudy
                topicIds={studyTopicIds}
                topicName={isWholeTopic ? (activeParent?.name ?? "") : (activeSubTopic?.name ?? "")}
                parentName={isWholeTopic ? null : (activeParent?.name ?? null)}
                subjectId={subject.id}
                subjectName={subject.name}
                grade={grade}
                backLabel={subTopics?.length ? "Back to sub-topics" : "Back to topics"}
                onBack={() => {
                  setTopicId(null);
                  if (!subTopics?.length) setParentId(null);
                }}
              />
            ) : parentId ? (
              <div>
                <Button
                  variant="ghost"
                  size="sm"
                  className="mb-4 rounded-full"
                  onClick={() => setParentId(null)}
                >
                  All topics
                </Button>
                <h2 className="mb-4 font-display text-2xl">{activeParent?.name}</h2>
                <TopicList
                  topics={[
                    {
                      id: parentId,
                      name: "Whole topic",
                      description:
                        "Notes, flashcards and questions from every sub-topic, mixed together.",
                    },
                    ...(subTopics ?? []),
                  ]}
                  badgeIds={noteBadgeIds ?? []}
                  masteryById={masteryById}
                  onPick={setTopicId}
                />
              </div>
            ) : (
              <TopicList
                topics={topics ?? []}
                badgeIds={noteBadgeIds ?? []}
                masteryById={masteryById}
                onPick={(id) => setParentId(id)}
              />
            )
          ) : null}

          {tab === "All practice papers" ? (
            activePaper ? (
              <PaperRunner
                paper={activePaper}
                subjectId={subject.id}
                subjectName={subject.name}
                onExit={() => setPaperId(null)}
              />
            ) : papers?.length ? (
              <ul className="flex flex-col gap-3">
                {papers.map((paper) => (
                  <li key={paper.id}>
                    <button
                      type="button"
                      onClick={() => setPaperId(paper.id)}
                      className="w-full rounded-lg border border-border bg-card p-5 text-left shadow-[var(--shadow-soft)] transition-colors hover:border-primary"
                    >
                      <h3 className="font-display text-lg">{paper.title}</h3>
                      <p className="text-sm text-muted-foreground">
                        MYP {paper.grade} · {paper.paper_questions?.[0]?.count ?? 0} written-answer
                        questions · AI marked
                      </p>
                    </button>
                  </li>
                ))}
              </ul>
            ) : (
              <Empty text={`No practice papers for MYP ${grade} yet.`} />
            )
          ) : null}

          {tab === "My progress" ? (
            user ? (
              <div className="grid gap-4 sm:grid-cols-3">
                <Stat label="Questions answered" value={`${subjectAttempts.length}`} />
                <Stat label="Accuracy" value={`${Math.round(accuracy * 100)}%`} />
                <Stat
                  label={`MYP Level (of 8) — ${MYP_LEVEL_LABELS[level]}`}
                  value={`${subjectAttempts.length ? level : "—"}`}
                />
              </div>
            ) : (
              <Empty text="Sign in to track your progress in this subject." />
            )
          ) : null}
        </div>
      </div>
    </div>
  );
}

function Stat({ label, value, suffix }: { label: string; value: string; suffix?: string }) {
  return (
    <div className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
      <p className="font-display text-3xl">{value}</p>
      <p className="mt-1 text-sm text-muted-foreground">
        {label}
        {suffix}
      </p>
    </div>
  );
}

function Empty({ text, onBack }: { text: string; onBack?: () => void }) {
  return (
    <div className="rounded-lg border border-dashed border-border bg-card p-10 text-center">
      <p className="text-muted-foreground">{text}</p>
      {onBack ? (
        <Button variant="outline" className="mt-4 rounded-full" onClick={onBack}>
          Back to topics
        </Button>
      ) : null}
    </div>
  );
}

function TopicList({
  topics,
  onPick,
  badgeIds,
  masteryById,
}: {
  topics: { id: string; name: string; description: string | null }[];
  onPick: (id: string) => void;
  badgeIds?: string[];
  masteryById?: Map<string, Mastery>;
}) {
  if (!topics.length) return <Empty text="No topics for this grade yet." />;
  return (
    <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
      {topics.map((topic) => (
        <button
          key={topic.id}
          type="button"
          onClick={() => onPick(topic.id)}
          className="card-lift rounded-lg border border-border bg-card p-5 text-left shadow-[var(--shadow-soft)]"
        >
          <h3 className="font-display text-lg">{topic.name}</h3>
          {badgeIds?.includes(topic.id) ? (
            <span className="mt-2 inline-block rounded-full bg-secondary px-2.5 py-0.5 text-xs text-muted-foreground">
              Note available
            </span>
          ) : null}
          {masteryById?.get(topic.id) && masteryById.get(topic.id)!.total > 0 ? (
            <div className="mt-3">
              <div className="h-1.5 overflow-hidden rounded-full bg-secondary">
                <div
                  className="h-full rounded-full bg-primary"
                  style={{ width: `${Math.round(masteryById.get(topic.id)!.pct * 100)}%` }}
                />
              </div>
              <p className="mt-1 text-xs text-muted-foreground">
                {STATUS_LABEL[masteryById.get(topic.id)!.status]} ·{" "}
                {Math.round(masteryById.get(topic.id)!.pct * 100)}%
              </p>
            </div>
          ) : null}
          {topic.description ? (
            <p className="mt-1 line-clamp-2 text-sm text-muted-foreground">{topic.description}</p>
          ) : null}
        </button>
      ))}
    </div>
  );
}
