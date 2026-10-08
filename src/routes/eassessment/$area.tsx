import { createFileRoute, Link, notFound } from "@tanstack/react-router";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import { Clock, Lightbulb } from "lucide-react";
import {
  fetchAllTopics,
  fetchAttempts,
  fetchMixedQuestions,
  fetchPapers,
  fetchQuestionsForTopics,
  shuffle,
  fetchSubjectsBySlugs,
} from "@/lib/myp";
import {
  COMMAND_TERMS,
  EXAM_TIPS,
  describeResult,
  findArea,
  formatDuration,
} from "@/lib/eassessment";
import { masteryOf, STATUS_LABEL } from "@/lib/progress";
import { PaperRunner } from "@/components/study/PaperRunner";
import { QuestionRunner } from "@/components/study/QuestionRunner";
import { useAuth } from "@/hooks/use-auth";
import { Button } from "@/components/ui/button";

const GRADE = 5;
const TABS = ["Readiness", "Timed paper", "Mixed test", "Build my exam", "Exam skills"] as const;
type Tab = (typeof TABS)[number];

export const Route = createFileRoute("/eassessment/$area")({
  loader: ({ params }) => {
    const area = findArea(params.area);
    if (!area) throw notFound();
    return { area };
  },
  head: ({ loaderData }) => ({
    meta: [
      { title: `${loaderData?.area.name ?? "eAssessment"} eAssessment practice — MYP Revision` },
      { name: "description", content: loaderData?.area.blurb ?? "MYP eAssessment practice." },
    ],
  }),
  component: AreaPage,
});

function AreaPage() {
  const { area } = Route.useLoaderData();
  const [tab, setTab] = useState<Tab>(area.slugs.length ? "Readiness" : "Exam skills");
  const [slug, setSlug] = useState<string | null>(null);

  const { data: subjects } = useQuery({
    queryKey: ["ea-subjects", area.key],
    queryFn: () => fetchSubjectsBySlugs(area.slugs, GRADE),
  });
  const subject = subjects?.find((s) => s.slug === slug) ?? subjects?.[0] ?? null;

  return (
    <div className="page-fade">
      <div className={area.bg}>
        <div className="mx-auto max-w-[1200px] px-6 py-10 md:px-12">
          <Link to="/eassessment" className="text-sm underline underline-offset-4">
            All eAssessment exams
          </Link>
          <h1 className="mt-3 text-4xl">{area.name}</h1>
          <p className="mt-2 max-w-2xl text-sm">{area.blurb}</p>
          <p className="mt-3 flex items-center gap-2 text-xs uppercase tracking-wide opacity-80">
            <Clock className="size-3.5" />
            {formatDuration(area.minutes)} · on screen · MYP 5
          </p>
        </div>
      </div>

      <div className="mx-auto max-w-[1200px] px-6 py-8 md:px-12">
        <div className="rounded-lg border border-border bg-card p-5 shadow-[var(--shadow-soft)]">
          <h2 className="font-display text-lg">What this exam looks like</h2>
          <ul className="mt-2 list-disc space-y-1 pl-5 text-sm text-muted-foreground">
            {area.looksLike.map((l) => (
              <li key={l}>{l}</li>
            ))}
          </ul>
        </div>

        {area.slugs.length ? (
          <div className="mt-6 flex flex-wrap items-center gap-2">
            <span className="text-sm text-muted-foreground">Your subject</span>
            {(subjects ?? []).map((s) => (
              <button
                key={s.id}
                type="button"
                onClick={() => setSlug(s.slug)}
                className={`rounded-full border px-4 py-1.5 text-sm transition-colors ${
                  subject?.id === s.id
                    ? "border-primary bg-primary text-primary-foreground"
                    : "border-border bg-card hover:bg-secondary"
                }`}
              >
                {s.name}
              </button>
            ))}
          </div>
        ) : null}

        <div className="mt-6 flex flex-wrap gap-1 border-b border-border">
          {TABS.filter((t) => area.slugs.length || t === "Exam skills").map((t) => (
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
          {tab === "Readiness" && subject ? (
            <Readiness subjectId={subject.id} slug={subject.slug} />
          ) : null}
          {tab === "Timed paper" && subject ? (
            <TimedPapers
              key={subject.id}
              subjectId={subject.id}
              subjectName={subject.name}
              areaMinutes={area.minutes}
            />
          ) : null}
          {tab === "Mixed test" && subject ? (
            <MixedTest key={subject.id} subjectId={subject.id} subjectName={subject.name} />
          ) : null}
          {tab === "Build my exam" && subject ? (
            <BuildExam key={subject.id} subjectId={subject.id} subjectName={subject.name} />
          ) : null}
          {tab === "Exam skills" ? <ExamSkills /> : null}
          {area.slugs.length && !subjects?.length && tab !== "Exam skills" ? (
            <Empty text="No subjects in this area are available at MYP 5 yet." />
          ) : null}
        </div>
      </div>
    </div>
  );
}

function Readiness({ subjectId, slug }: { subjectId: string; slug: string }) {
  const { user } = useAuth();
  const { data: topics, isLoading } = useQuery({
    queryKey: ["ea-topics", subjectId],
    queryFn: () => fetchAllTopics(subjectId, GRADE),
  });
  const { data: attempts } = useQuery({
    queryKey: ["attempts", user?.id],
    queryFn: () => fetchAttempts(user!.id),
    enabled: !!user,
  });

  if (isLoading) return <p className="text-sm text-muted-foreground">Loading topics…</p>;
  const parents = (topics ?? []).filter((t) => !t.parent_topic_id);
  if (!parents.length)
    return <Empty text="Topics for this subject at MYP 5 are still being built." />;

  const own = (attempts ?? []).filter((a) => a.subject_id === subjectId);
  const rows = parents.map((p) => {
    const ids = new Set([
      p.id,
      ...(topics ?? []).filter((t) => t.parent_topic_id === p.id).map((t) => t.id),
    ]);
    const list = own.filter((a) => a.topic_id && ids.has(a.topic_id));
    return { topic: p, m: masteryOf(list.length, list.filter((a) => a.correct).length) };
  });
  const started = rows.filter((r) => r.m.status !== "new").length;
  const order = { "needs-work": 0, new: 1, "getting-there": 2, strong: 3 } as const;
  rows.sort((a, b) => order[a.m.status] - order[b.m.status]);

  const tone = {
    new: "bg-secondary text-muted-foreground",
    "needs-work": "bg-destructive/10 text-destructive",
    "getting-there": "bg-warning/20 text-foreground",
    strong: "bg-success/15 text-success",
  } as const;

  return (
    <div>
      <p className="text-sm text-muted-foreground">
        {user
          ? `${started} of ${rows.length} topics started. Weakest first, so you know where to spend your next hour.`
          : "Sign in and your readiness for each topic builds up as you answer questions."}
      </p>
      <ul className="mt-4 grid gap-3 md:grid-cols-2">
        {rows.map(({ topic, m }) => (
          <li key={topic.id}>
            <Link
              to="/subjects/$slug"
              params={{ slug }}
              search={{ grade: GRADE, tab: "Study", topic: topic.id }}
              className="card-lift block rounded-lg border border-border bg-card p-4 shadow-[var(--shadow-soft)]"
            >
              <div className="flex items-start justify-between gap-3">
                <h3 className="font-medium">{topic.name}</h3>
                <span className={`shrink-0 rounded-full px-2.5 py-0.5 text-xs ${tone[m.status]}`}>
                  {STATUS_LABEL[m.status]}
                </span>
              </div>
              <div className="mt-3 h-1.5 overflow-hidden rounded-full bg-secondary">
                <div
                  className="h-full rounded-full bg-primary transition-all"
                  style={{ width: `${Math.round(m.pct * 100)}%` }}
                />
              </div>
              <p className="mt-2 text-xs text-muted-foreground">
                {m.total ? `${Math.round(m.pct * 100)}% from ${m.total} answers` : "No answers yet"}
              </p>
            </Link>
          </li>
        ))}
      </ul>
    </div>
  );
}

function TimedPapers({
  subjectId,
  subjectName,
  areaMinutes,
}: {
  subjectId: string;
  subjectName: string;
  areaMinutes: number;
}) {
  const [paperId, setPaperId] = useState<string | null>(null);
  const { data: papers, isLoading } = useQuery({
    queryKey: ["papers", subjectId, GRADE],
    queryFn: () => fetchPapers(subjectId, GRADE),
  });
  const paper = papers?.find((p) => p.id === paperId);
  const suggested = (count: number) => Math.min(areaMinutes, Math.max(20, count * 8));

  if (paper) {
    const count = paper.paper_questions?.[0]?.count ?? 0;
    return (
      <PaperRunner
        paper={paper}
        subjectId={subjectId}
        subjectName={subjectName}
        exam={{ minutes: suggested(count) }}
        onExit={() => setPaperId(null)}
      />
    );
  }
  if (isLoading) return <p className="text-sm text-muted-foreground">Loading papers…</p>;
  if (!papers?.length)
    return (
      <Empty
        text={`No written practice papers for ${subjectName} at MYP 5 yet. Try the Mixed test meanwhile.`}
      />
    );
  return (
    <div>
      <p className="mb-4 text-sm text-muted-foreground">
        Sit it like the real thing: a countdown runs, you answer every question, and the AI marks it
        against the mark scheme. Results show your Level 1-8 and an estimated overall 1-7.
      </p>
      <ul className="flex flex-col gap-3">
        {papers.map((p) => {
          const count = p.paper_questions?.[0]?.count ?? 0;
          return (
            <li key={p.id}>
              <button
                type="button"
                onClick={() => setPaperId(p.id)}
                className="card-lift w-full rounded-lg border border-border bg-card p-5 text-left shadow-[var(--shadow-soft)]"
              >
                <h3 className="font-display text-lg">{p.title}</h3>
                <p className="text-sm text-muted-foreground">
                  {count} questions · {suggested(count)} minutes · AI marked
                </p>
              </button>
            </li>
          );
        })}
      </ul>
    </div>
  );
}

function MixedTest({ subjectId, subjectName }: { subjectId: string; subjectName: string }) {
  const [count, setCount] = useState<number | null>(null);
  const [run, setRun] = useState(0);
  const [result, setResult] = useState<{ score: number; total: number } | null>(null);

  const { data: questions, isLoading } = useQuery({
    queryKey: ["mixed", subjectId, count, run],
    queryFn: () => fetchMixedQuestions(subjectId, GRADE, count!),
    enabled: count !== null,
    staleTime: Infinity,
  });

  if (count === null) {
    return (
      <div>
        <p className="text-sm text-muted-foreground">
          Questions are mixed from every topic in {subjectName}, so you practise recall without the
          hints that come from knowing the topic.
        </p>
        <div className="mt-4 flex flex-wrap gap-3">
          {[10, 20, 40].map((n) => (
            <Button key={n} variant="outline" className="rounded-full" onClick={() => setCount(n)}>
              {n} questions
            </Button>
          ))}
        </div>
      </div>
    );
  }
  if (isLoading) return <p className="text-sm text-muted-foreground">Building your test…</p>;
  if (!questions?.length) return <Empty text="No questions for this subject at MYP 5 yet." />;

  const both = result ? describeResult(result.score / result.total) : null;
  return (
    <div>
      <QuestionRunner
        key={`${count}-${run}`}
        questions={questions}
        subjectName={subjectName}
        subjectId={subjectId}
        topicName="mixed topics"
        grade={GRADE}
        onFinish={(score, total) => setResult({ score, total })}
      />
      {both ? (
        <div className="mt-4 grid gap-3 sm:grid-cols-2">
          <div className="rounded-lg border border-border bg-card p-4">
            <p className="text-xs uppercase tracking-wide text-muted-foreground">
              Criterion achievement (Levels 1-8)
            </p>
            <p className="mt-1 font-display text-2xl">Level {both.criterionLevel} of 8</p>
          </div>
          <div className="rounded-lg border border-border bg-card p-4">
            <p className="text-xs uppercase tracking-wide text-muted-foreground">
              Estimated overall subject grade (1-7)
            </p>
            <p className="mt-1 font-display text-2xl">Grade {both.overallGrade} of 7</p>
          </div>
          <p className="text-xs text-muted-foreground sm:col-span-2">
            Multiple-choice only, so the real exam will feel different. The IB sets its own grade
            boundaries each session, so use this as a guide.
          </p>
          <div className="sm:col-span-2">
            <Button
              className="rounded-full"
              onClick={() => {
                setResult(null);
                setRun((r) => r + 1);
              }}
            >
              New mixed test
            </Button>
          </div>
        </div>
      ) : null}
    </div>
  );
}

const DIFFICULTIES = ["easy", "medium", "hard"] as const;

function BuildExam({ subjectId, subjectName }: { subjectId: string; subjectName: string }) {
  const { data: topics, isLoading } = useQuery({
    queryKey: ["ea-topics", subjectId],
    queryFn: () => fetchAllTopics(subjectId, GRADE),
  });
  const [picked, setPicked] = useState<string[]>([]);
  const [levels, setLevels] = useState<string[]>([...DIFFICULTIES]);
  const [count, setCount] = useState(20);
  const [exam, setExam] = useState<Awaited<ReturnType<typeof fetchQuestionsForTopics>> | null>(
    null,
  );
  const [building, setBuilding] = useState(false);
  const [message, setMessage] = useState<string | null>(null);
  const [result, setResult] = useState<{ score: number; total: number } | null>(null);

  if (isLoading) return <p className="text-sm text-muted-foreground">Loading topics…</p>;
  const parents = (topics ?? []).filter((t) => !t.parent_topic_id);
  if (!parents.length)
    return <Empty text="Topics for this subject at MYP 5 are still being built." />;

  const toggle = (list: string[], id: string) =>
    list.includes(id) ? list.filter((x) => x !== id) : [...list, id];

  async function build() {
    const chosen = picked.length ? picked : parents.map((p) => p.id);
    const ids = new Set<string>();
    for (const id of chosen) {
      ids.add(id);
      for (const t of topics ?? []) if (t.parent_topic_id === id) ids.add(t.id);
    }
    setBuilding(true);
    setMessage(null);
    try {
      const all = await fetchQuestionsForTopics([...ids]);
      const pool = all.filter((q) => levels.includes(q.difficulty));
      if (!pool.length) {
        setMessage("No questions match those choices yet. Try more topics or difficulties.");
        return;
      }
      setResult(null);
      setExam(shuffle(pool).slice(0, count));
    } catch {
      setMessage("Could not build the exam right now. Try again.");
    } finally {
      setBuilding(false);
    }
  }

  if (exam) {
    const both = result ? describeResult(result.score / result.total) : null;
    return (
      <div>
        <Button
          variant="ghost"
          size="sm"
          className="mb-4 rounded-full"
          onClick={() => setExam(null)}
        >
          Change my choices
        </Button>
        <QuestionRunner
          key={exam.map((q) => q.id).join("")}
          questions={exam}
          subjectName={subjectName}
          subjectId={subjectId}
          topicName="your custom exam"
          grade={GRADE}
          onFinish={(score, total) => setResult({ score, total })}
        />
        {both ? (
          <div className="mt-4 grid gap-3 sm:grid-cols-2">
            <div className="rounded-lg border border-border bg-card p-4">
              <p className="text-xs uppercase tracking-wide text-muted-foreground">
                Criterion achievement (Levels 1-8)
              </p>
              <p className="mt-1 font-display text-2xl">Level {both.criterionLevel} of 8</p>
            </div>
            <div className="rounded-lg border border-border bg-card p-4">
              <p className="text-xs uppercase tracking-wide text-muted-foreground">
                Estimated overall subject grade (1-7)
              </p>
              <p className="mt-1 font-display text-2xl">Grade {both.overallGrade} of 7</p>
            </div>
          </div>
        ) : null}
      </div>
    );
  }

  return (
    <div className="max-w-2xl">
      <p className="text-sm text-muted-foreground">
        Pick what you want to practise and we will build a test from the {subjectName} question
        bank. Leave topics empty to include everything.
      </p>
      <h3 className="mt-5 font-display text-lg">Topics</h3>
      <div className="mt-2 flex flex-wrap gap-2">
        {parents.map((p) => (
          <button
            key={p.id}
            type="button"
            onClick={() => setPicked((l) => toggle(l, p.id))}
            className={`rounded-full border px-3 py-1.5 text-sm transition-colors ${
              picked.includes(p.id)
                ? "border-primary bg-primary text-primary-foreground"
                : "border-border bg-card hover:bg-secondary"
            }`}
          >
            {p.name}
          </button>
        ))}
      </div>
      <h3 className="mt-5 font-display text-lg">Difficulty</h3>
      <div className="mt-2 flex flex-wrap gap-2">
        {DIFFICULTIES.map((d) => (
          <button
            key={d}
            type="button"
            onClick={() => setLevels((l) => (l.length === 1 && l.includes(d) ? l : toggle(l, d)))}
            className={`rounded-full border px-3 py-1.5 text-sm capitalize transition-colors ${
              levels.includes(d)
                ? "border-primary bg-primary text-primary-foreground"
                : "border-border bg-card hover:bg-secondary"
            }`}
          >
            {d}
          </button>
        ))}
      </div>
      <h3 className="mt-5 font-display text-lg">Number of questions</h3>
      <div className="mt-2 flex flex-wrap gap-2">
        {[10, 20, 30, 40].map((n) => (
          <button
            key={n}
            type="button"
            onClick={() => setCount(n)}
            className={`rounded-full border px-3 py-1.5 text-sm transition-colors ${
              count === n
                ? "border-primary bg-primary text-primary-foreground"
                : "border-border bg-card hover:bg-secondary"
            }`}
          >
            {n}
          </button>
        ))}
      </div>
      {message ? <p className="mt-4 text-sm text-destructive">{message}</p> : null}
      <Button className="mt-6 rounded-full" disabled={building} onClick={build}>
        {building ? "Building…" : "Build my exam"}
      </Button>
    </div>
  );
}

function ExamSkills() {
  return (
    <div className="grid gap-8 lg:grid-cols-2">
      <section>
        <h2 className="font-display text-2xl">Command terms</h2>
        <p className="mt-1 text-sm text-muted-foreground">
          The first word of a question tells you how much to write.
        </p>
        <dl className="mt-4 divide-y divide-border rounded-lg border border-border bg-card">
          {COMMAND_TERMS.map((c) => (
            <div key={c.term} className="grid gap-1 p-4 sm:grid-cols-[10rem_1fr]">
              <dt className="font-medium">{c.term}</dt>
              <dd className="text-sm text-muted-foreground">{c.meaning}</dd>
            </div>
          ))}
        </dl>
      </section>
      <section>
        <h2 className="font-display text-2xl">Exam technique</h2>
        <ul className="mt-4 flex flex-col gap-3">
          {EXAM_TIPS.map((t) => (
            <li key={t.title} className="rounded-lg border border-border bg-card p-4">
              <p className="flex items-center gap-2 font-medium">
                <Lightbulb className="size-4 text-accent" />
                {t.title}
              </p>
              <p className="mt-1 text-sm text-muted-foreground">{t.body}</p>
            </li>
          ))}
        </ul>
      </section>
    </div>
  );
}

function Empty({ text }: { text: string }) {
  return (
    <div className="rounded-lg border border-dashed border-border bg-card p-10 text-center">
      <p className="text-muted-foreground">{text}</p>
    </div>
  );
}
