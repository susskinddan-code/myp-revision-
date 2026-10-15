import { createFileRoute, Link, notFound } from "@tanstack/react-router";
import { useQuery } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { generateExamTasks, type BankedTask } from "@/lib/ai.functions";
import { useEffect, useState } from "react";
import { Clock, Lightbulb } from "lucide-react";
import {
  fetchAllTopics,
  fetchAttempts,
  fetchPapers,
  fetchSubjectPaperTasks,
  fetchSubjectsBySlugs,
  assembleWrittenExam,
  topicKeywords,
  shuffle,
  marksOf,
  type PaperTask,
} from "@/lib/myp";
import {
  COMMAND_TERMS,
  EXAM_TIPS,
  describeResult,
  findArea,
  formatDuration,
  formulaSheetFor,
} from "@/lib/eassessment";
import { masteryOf, STATUS_LABEL } from "@/lib/progress";
import { loadExamSession, PaperRunner, type ExamTask } from "@/components/study/PaperRunner";
import { useAuth } from "@/hooks/use-auth";
import { Button } from "@/components/ui/button";

const GRADE = 5;
const TABS = ["Readiness", "Timed paper", "Mixed test", "Build my exam", "Exam skills"] as const;
type Tab = (typeof TABS)[number];

type AreaSearch = { subject?: string; tab?: Tab; paper?: string };

export const Route = createFileRoute("/eassessment/$area")({
  validateSearch: (s: Record<string, unknown>): AreaSearch => {
    const out: AreaSearch = {};
    if (typeof s["subject"] === "string") out.subject = s["subject"];
    if (TABS.includes(s["tab"] as Tab)) out.tab = s["tab"] as Tab;
    if (typeof s["paper"] === "string") out.paper = s["paper"];
    return out;
  },
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
  const search = Route.useSearch();
  const [tab, setTab] = useState<Tab>(
    search.tab ?? (area.slugs.length ? "Readiness" : "Exam skills"),
  );
  const [slug, setSlug] = useState<string | null>(search.subject ?? null);

  const { data: subjects } = useQuery({
    queryKey: ["ea-subjects", area.key],
    queryFn: () => fetchSubjectsBySlugs(area.slugs, GRADE),
  });
  const subject = subjects?.find((s) => s.slug === slug) ?? subjects?.[0] ?? null;

  // An exam saved in this browser tab (sessionStorage) that the student is not looking at: offer to resume it.
  const [resume, setResume] = useState<{ tab: Tab; title: string } | null>(null);
  const subjectIdForResume = subject?.id ?? null;
  useEffect(() => {
    if (!subjectIdForResume) return setResume(null);
    const keys: [Tab, string][] = [
      ["Timed paper", "timed"],
      ["Mixed test", "mixed"],
      ["Build my exam", "custom"],
    ];
    for (const [t, k] of keys) {
      const sess = loadExamSession(`${subjectIdForResume}:${k}`);
      if (sess && t !== tab) return setResume({ tab: t, title: sess.paper.title });
    }
    setResume(null);
  }, [subjectIdForResume, tab]);

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
          {area.slugs.length ? (
            <div className="mt-4 flex flex-wrap gap-2">
              {(["Timed paper", "Mixed test", "Build my exam", "Exam skills"] as const).map((t) => (
                <Button
                  key={t}
                  variant="outline"
                  size="sm"
                  className="rounded-full"
                  onClick={() => setTab(t)}
                >
                  {t}
                </Button>
              ))}
            </div>
          ) : null}
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

        {resume ? (
          <div
            role="status"
            className="mt-6 flex flex-wrap items-center justify-between gap-3 rounded-lg border border-primary/40 bg-primary/5 px-4 py-3 text-sm"
          >
            <span>
              You have an exam in progress: <strong>{resume.title}</strong>. The clock is still
              running.
            </span>
            <Button size="sm" className="rounded-full" onClick={() => setTab(resume.tab)}>
              Resume exam
            </Button>
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
              areaKey={area.key}
              initialPaperId={search.paper ?? null}
            />
          ) : null}
          {tab === "Mixed test" && subject ? (
            <MixedTest
              key={subject.id}
              subjectId={subject.id}
              subjectName={subject.name}
              areaKey={area.key}
            />
          ) : null}
          {tab === "Build my exam" && subject ? (
            <BuildExam
              key={subject.id}
              subjectId={subject.id}
              subjectName={subject.name}
              areaKey={area.key}
            />
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

/** Shown before a sitting starts when the student is signed out (marking needs an account). */
function SignInPrompt() {
  const { user, loading } = useAuth();
  if (user || loading) return null;
  const here =
    typeof window === "undefined" ? "/" : window.location.pathname + window.location.search;
  return (
    <p
      role="status"
      className="mb-4 rounded-md border border-primary/40 bg-primary/5 px-3 py-2 text-sm"
    >
      Sign in before you start: marking needs an account, and signed-out sittings use saved tasks
      only.{" "}
      <a
        href={`/auth?redirect=${encodeURIComponent(here)}`}
        className="font-medium underline underline-offset-4"
      >
        Sign in
      </a>
    </p>
  );
}

const fallbackNotice = (what: string, signedIn: boolean) =>
  signedIn
    ? `New-${what} writing is unavailable, so this uses saved tasks.`
    : `Sign in to have new ${what}s written and your answers marked. This uses saved tasks.`;

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
  areaKey,
  initialPaperId,
}: {
  subjectId: string;
  subjectName: string;
  areaMinutes: number;
  areaKey: string;
  initialPaperId: string | null;
}) {
  const [paperId, setPaperId] = useState<string | null>(initialPaperId);
  const [fresh, setFresh] = useState<CustomExam | null>(null);
  const [freshRun, setFreshRun] = useState(0);
  const [writing, setWriting] = useState(false);
  const [freshMsg, setFreshMsg] = useState<string | null>(null);
  const generate = useServerFn(generateExamTasks);
  const { user } = useAuth();
  const persistKey = `${subjectId}:timed`;

  // Resume an exam that was in progress before a reload.
  useEffect(() => {
    const s = loadExamSession(persistKey);
    if (!s || initialPaperId) return;
    const exam = restoreExam(persistKey);
    if (exam) {
      setFresh(exam);
      setFreshRun((r) => r + 1);
    } else setPaperId(s.paper.id);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  async function writeNew() {
    setWriting(true);
    setFreshMsg(null);
    try {
      const topics = await fetchAllTopics(subjectId, GRADE);
      const names = shuffle(topics.filter((t) => !t.parent_topic_id).map((t) => t.name));
      const {
        tasks,
        fresh: ok,
        minutes,
      } = await buildAiTasks({
        generate,
        signedIn: !!user,
        subjectId,
        subjectName,
        topicNames: names,
        minutes: areaMinutes,
        bankFallback: async () =>
          assembleWrittenExam(
            await fetchSubjectPaperTasks(subjectId, GRADE),
            Math.round(areaMinutes / 1.2),
          ),
      });
      if (!tasks.length) return setFreshMsg("No tasks available yet for this subject.");
      setFreshRun((r) => r + 1);
      setFresh({
        id: newExamId("fresh"),
        tasks,
        minutes,
        title: `${subjectName} new practice paper`,
        notice: ok ? null : fallbackNotice("paper", !!user),
      });
    } catch {
      setFreshMsg("Could not write a paper right now. Try again.");
    } finally {
      setWriting(false);
    }
  }
  const { data: papers, isLoading } = useQuery({
    queryKey: ["papers", subjectId, GRADE],
    queryFn: () => fetchPapers(subjectId, GRADE),
  });
  const paper = papers?.find((p) => p.id === paperId);
  const isMock = (title: string) =>
    title.includes("Full eAssessment Mock") ||
    title.includes("Structure Mock") ||
    /\d+ marks\)/.test(title);
  const marksInTitle = (title: string) => Number(title.match(/(\d+) marks\)/)?.[1] ?? 0);
  const suggested = (count: number, title = "") => {
    if (title.includes("Structure Mock") || /\d+ marks\)/.test(title)) {
      const m = marksInTitle(title);
      return m ? Math.min(areaMinutes, Math.round(m * 1.2)) : areaMinutes;
    }
    return isMock(title) ? areaMinutes : Math.min(areaMinutes, Math.max(20, count * 8));
  };
  const sortedPapers = [...(papers ?? [])].sort(
    (a, b) => Number(isMock(b.title)) - Number(isMock(a.title)) || a.title.localeCompare(b.title),
  );

  if (fresh) {
    return (
      <PaperRunner
        key={freshRun}
        paper={{ id: fresh.id, title: fresh.title, grade: GRADE, criterion: null }}
        persistKey={persistKey}
        notice={fresh.notice}
        tasks={fresh.tasks}
        subjectId={subjectId}
        subjectName={subjectName}
        exam={{ minutes: fresh.minutes, formulas: formulaSheetFor(areaKey) }}
        exitLabel="All practice papers"
        onExit={() => setFresh(null)}
      />
    );
  }
  if (paper) {
    const count = paper.paper_questions?.[0]?.count ?? 0;
    return (
      <PaperRunner
        paper={paper}
        subjectId={subjectId}
        subjectName={subjectName}
        persistKey={persistKey}
        exam={{ minutes: suggested(count, paper.title), formulas: formulaSheetFor(areaKey) }}
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
      <SignInPrompt />
      <p className="mb-4 text-sm text-muted-foreground">
        Sit it like the real thing: a countdown runs, you answer every question, and the AI marks it
        against the mark scheme. Results show your Level 1-8 and an estimated overall 1-7.
      </p>
      <div className="mb-4 rounded-lg border border-primary/40 bg-primary/5 p-5">
        <h3 className="font-display text-lg">A brand-new paper, written for you</h3>
        <p className="mt-1 text-sm text-muted-foreground">
          Full length, {areaMinutes} minutes, never seen before. AI writes every task fresh across
          the {subjectName} course.
        </p>
        <Button className="mt-3 rounded-full" disabled={writing} onClick={writeNew}>
          {writing
            ? "Writing your paper… this can take a couple of minutes"
            : "Write me a new paper"}
        </Button>
        {freshMsg ? <p className="mt-2 text-sm text-destructive">{freshMsg}</p> : null}
      </div>
      <ul className="flex flex-col gap-3">
        {sortedPapers.map((p) => {
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
                  {isMock(p.title) ? "Full-length mock · " : ""}
                  {count} questions · {suggested(count, p.title)} minutes · AI marked
                </p>
              </button>
            </li>
          );
        })}
      </ul>
    </div>
  );
}

type CustomExam = {
  id: string;
  tasks: ExamTask[];
  minutes: number;
  title: string;
  notice?: string | null;
};

/** Puts back an exam that was in progress before a reload or navigation (see PaperRunner persistence). */
function restoreExam(key: string): CustomExam | null {
  const s = loadExamSession(key);
  if (!s?.tasks?.length) return null;
  return {
    id: s.paper.id,
    tasks: s.tasks,
    minutes: s.minutes ?? 60,
    title: s.paper.title,
    notice: s.notice ?? null,
  };
}
const newExamId = (kind: string) => `${kind}-${Date.now().toString(36)}`;

const SEEN_IDS_KEY = "myp-seen-task-ids";
function readList(key: string, subjectId: string): string[] {
  try {
    const all = JSON.parse(localStorage.getItem(key) ?? "{}") as Record<string, string[]>;
    return all[subjectId] ?? [];
  } catch {
    return [];
  }
}
function writeList(key: string, subjectId: string, items: string[], keep: number) {
  try {
    const all = JSON.parse(localStorage.getItem(key) ?? "{}") as Record<string, string[]>;
    all[subjectId] = [...items, ...(all[subjectId] ?? [])].slice(0, keep);
    localStorage.setItem(key, JSON.stringify(all));
  } catch {
    /* storage unavailable: repeats are still unlikely */
  }
}

/**
 * Builds a written exam: tasks the student has not seen come from the shared bank, the AI writes the
 * rest (and saves them to the bank). Falls back to the stored paper tasks if the AI is unavailable
 * or the student is signed out. The sitting time is always the honest 1.2 minutes per mark of the tasks returned.
 */
async function buildAiTasks(opts: {
  generate: (a: {
    data: {
      subject: string;
      subjectId?: string | null;
      grade: number;
      topics: string[];
      targetMarks: number;
      seenIds?: string[];
    };
  }) => Promise<{
    tasks: BankedTask[] | null;
    error: string | null;
    totalMarks?: number;
    minutes?: number;
  }>;
  signedIn: boolean;
  subjectId: string;
  subjectName: string;
  topicNames: string[];
  minutes: number;
  bankFallback: () => Promise<PaperTask[]>;
}): Promise<{ tasks: ExamTask[]; fresh: boolean; minutes: number }> {
  const targetMarks = Math.min(110, Math.round(opts.minutes / 1.2));
  try {
    const res = opts.signedIn
      ? await opts.generate({
          data: {
            subject: opts.subjectName,
            subjectId: opts.subjectId,
            grade: GRADE,
            topics: opts.topicNames,
            targetMarks,
            seenIds: readList(SEEN_IDS_KEY, opts.subjectId).slice(0, 200),
          },
        })
      : null;
    if (res?.tasks?.length) {
      writeList(
        SEEN_IDS_KEY,
        opts.subjectId,
        res.tasks.map((t) => t.id).filter((id) => !id.startsWith("gen-new-")),
        150,
      );
      // Honest sitting time: what the server worked out from the marks it returned (1.2 min per mark).
      const got = res.minutes && res.minutes > 0 ? res.minutes : opts.minutes;
      return {
        fresh: true,
        minutes: Math.max(5, Math.min(Math.ceil(opts.minutes * 1.2), got)),
        tasks: res.tasks.map((t, i) => ({
          id: t.id,
          paper_id: "generated",
          position: i + 1,
          criterion: t.criterion,
          content: t.content,
          mark_scheme: t.mark_scheme,
          options: [],
          answer: 0,
          ...(t.sig ? { sig: t.sig } : {}),
        })),
      };
    }
  } catch {
    /* fall through to the stored bank */
  }
  const tasks = await opts.bankFallback();
  const marks = totalMarks(tasks);
  return {
    fresh: false,
    tasks,
    minutes: marks ? Math.max(5, Math.round(marks * 1.2)) : opts.minutes,
  };
}

function totalMarks(tasks: PaperTask[]) {
  return tasks.reduce((t, q) => t + marksOf(q.mark_scheme), 0);
}

function MixedTest({
  subjectId,
  subjectName,
  areaKey,
}: {
  subjectId: string;
  subjectName: string;
  areaKey: string;
}) {
  const [exam, setExam] = useState<CustomExam | null>(null);
  const [run, setRun] = useState(0);
  const [busy, setBusy] = useState(false);
  const [message, setMessage] = useState<string | null>(null);
  const generate = useServerFn(generateExamTasks);
  const { user } = useAuth();
  const persistKey = `${subjectId}:mixed`;

  useEffect(() => {
    const exam = restoreExam(persistKey);
    if (exam) {
      setExam(exam);
      setRun((r) => r + 1);
    }
  }, [persistKey]);

  async function start(minutes: number) {
    setBusy(true);
    setMessage(null);
    try {
      const topics = await fetchAllTopics(subjectId, GRADE);
      const names = shuffle(topics.filter((t) => !t.parent_topic_id).map((t) => t.name));
      const {
        tasks,
        fresh,
        minutes: sitting,
      } = await buildAiTasks({
        generate,
        signedIn: !!user,
        subjectId,
        subjectName,
        topicNames: names,
        minutes,
        bankFallback: async () =>
          assembleWrittenExam(
            await fetchSubjectPaperTasks(subjectId, GRADE),
            Math.round(minutes / 1.2),
          ),
      });
      if (!tasks.length) {
        setMessage("No written tasks for this subject at MYP 5 yet.");
        return;
      }
      setRun((r) => r + 1);
      setExam({
        id: newExamId("mixed"),
        tasks,
        minutes: sitting,
        title: `${subjectName} mixed test`,
        notice: fresh ? null : fallbackNotice("question", !!user),
      });
    } catch {
      setMessage("Could not build the test right now. Try again.");
    } finally {
      setBusy(false);
    }
  }

  if (exam) {
    return (
      <PaperRunner
        key={run}
        paper={{ id: exam.id, title: exam.title, grade: GRADE, criterion: null }}
        persistKey={persistKey}
        notice={exam.notice}
        tasks={exam.tasks}
        subjectId={subjectId}
        subjectName={subjectName}
        exam={{ minutes: exam.minutes, formulas: formulaSheetFor(areaKey) }}
        exitLabel="Back to mixed test"
        onExit={() => setExam(null)}
      />
    );
  }
  return (
    <div>
      <SignInPrompt />
      <p className="text-sm text-muted-foreground">
        Written tasks drawn from every topic in {subjectName}, in exam conditions: a countdown, no
        hints about which topic is coming, and AI marking against a mark scheme. Every test is
        freshly written by AI, so you will not keep meeting the same questions.
      </p>
      <div className="mt-4 flex flex-wrap gap-3">
        {[
          { m: 30, l: "Short · 30 min" },
          { m: 60, l: "Half paper · 60 min" },
          { m: 105, l: "Full length · 105 min" },
        ].map((o) => (
          <Button
            key={o.m}
            variant="outline"
            className="rounded-full"
            disabled={busy}
            onClick={() => start(o.m)}
          >
            {o.l}
          </Button>
        ))}
      </div>
      {busy ? (
        <p className="mt-4 text-sm text-muted-foreground">
          Writing brand-new questions for you. This can take a couple of minutes.
        </p>
      ) : null}
      {message ? <p className="mt-4 text-sm text-destructive">{message}</p> : null}
    </div>
  );
}

function BuildExam({
  subjectId,
  subjectName,
  areaKey,
}: {
  subjectId: string;
  subjectName: string;
  areaKey: string;
}) {
  const { data: topics, isLoading } = useQuery({
    queryKey: ["ea-topics", subjectId],
    queryFn: () => fetchAllTopics(subjectId, GRADE),
  });
  const [picked, setPicked] = useState<string[]>([]);
  const [minutes, setMinutes] = useState(60);
  const [exam, setExam] = useState<CustomExam | null>(null);
  const [run, setRun] = useState(0);
  const [building, setBuilding] = useState(false);
  const [message, setMessage] = useState<string | null>(null);
  const generate = useServerFn(generateExamTasks);
  const { user } = useAuth();
  const persistKey = `${subjectId}:custom`;

  useEffect(() => {
    const exam = restoreExam(persistKey);
    if (exam) {
      setExam(exam);
      setRun((r) => r + 1);
    }
  }, [persistKey]);

  if (isLoading) return <p className="text-sm text-muted-foreground">Loading topics…</p>;
  const parents = (topics ?? []).filter((t) => !t.parent_topic_id);
  if (!parents.length)
    return <Empty text="Topics for this subject at MYP 5 are still being built." />;

  const toggle = (list: string[], id: string) =>
    list.includes(id) ? list.filter((x) => x !== id) : [...list, id];

  async function build() {
    const chosen = picked.length ? picked : parents.map((p) => p.id);
    const words = new Set<string>();
    for (const id of chosen) {
      for (const t of topics ?? [])
        if (t.id === id || t.parent_topic_id === id)
          for (const w of topicKeywords(t.name)) words.add(w);
    }
    setBuilding(true);
    setMessage(null);
    try {
      const names = parents.filter((p) => chosen.includes(p.id)).map((p) => p.name);
      const {
        tasks,
        fresh,
        minutes: sitting,
      } = await buildAiTasks({
        generate,
        signedIn: !!user,
        subjectId,
        subjectName,
        topicNames: names,
        minutes,
        bankFallback: async () => {
          const all = await fetchSubjectPaperTasks(subjectId, GRADE);
          const hits = (q: PaperTask) => {
            const text = q.content.toLowerCase();
            let n = 0;
            for (const w of words) if (text.includes(w)) n++;
            return n;
          };
          const pool = picked.length ? all.filter((q) => hits(q) >= 2) : all;
          return assembleWrittenExam(pool, Math.round(minutes / 1.2), hits);
        },
      });
      if (!tasks.length) {
        setMessage("No written tasks match those topics yet. Pick more topics.");
        return;
      }
      setRun((r) => r + 1);
      setExam({
        id: newExamId("custom"),
        tasks,
        minutes: sitting,
        title: `${subjectName} custom exam`,
        notice: fresh ? null : fallbackNotice("question", !!user),
      });
    } catch {
      setMessage("Could not build the exam right now. Try again.");
    } finally {
      setBuilding(false);
    }
  }

  if (exam) {
    return (
      <PaperRunner
        key={run}
        paper={{ id: exam.id, title: exam.title, grade: GRADE, criterion: null }}
        persistKey={persistKey}
        notice={exam.notice}
        tasks={exam.tasks}
        subjectId={subjectId}
        subjectName={subjectName}
        exam={{ minutes: exam.minutes, formulas: formulaSheetFor(areaKey) }}
        exitLabel="Change my choices"
        onExit={() => setExam(null)}
      />
    );
  }

  return (
    <div className="max-w-2xl">
      <SignInPrompt />
      <p className="text-sm text-muted-foreground">
        Pick the topics and how long you want to sit. We write a brand-new {subjectName} exam on
        them with AI, timed and AI marked, so it is never the same twice. Leave topics empty to
        include everything.
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
      <h3 className="mt-5 font-display text-lg">Length</h3>
      <div className="mt-2 flex flex-wrap gap-2">
        {[30, 60, 90, 105].map((n) => (
          <button
            key={n}
            type="button"
            onClick={() => setMinutes(n)}
            className={`rounded-full border px-3 py-1.5 text-sm transition-colors ${
              minutes === n
                ? "border-primary bg-primary text-primary-foreground"
                : "border-border bg-card hover:bg-secondary"
            }`}
          >
            {n} min
          </button>
        ))}
      </div>
      {message ? <p className="mt-4 text-sm text-destructive">{message}</p> : null}
      <Button className="mt-6 rounded-full" disabled={building} onClick={build}>
        {building ? "Writing your exam…" : "Build my exam"}
      </Button>
      {building ? (
        <p className="mt-3 text-sm text-muted-foreground">
          Writing brand-new questions on your topics. This can take a couple of minutes.
        </p>
      ) : null}
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
