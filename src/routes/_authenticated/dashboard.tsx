import { createFileRoute, Link } from "@tanstack/react-router";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { toast } from "sonner";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/hooks/use-auth";
import { Flame, Target, Zap, CalendarDays, ArrowRight } from "lucide-react";
import { DAILY_GOAL, levelFor, lastSevenDays, todayCount, xpFor, streakOf } from "@/lib/progress";
import { daysToMaySession } from "@/lib/eassessment";
import {
  fetchAttempts,
  fetchProfile,
  fetchSubjects,
  accuracyToMypLevel,
  MYP_LEVEL_LABELS,
  GRADES,
} from "@/lib/myp";

export const Route = createFileRoute("/_authenticated/dashboard")({
  head: () => ({
    meta: [
      { title: "My progress — MYP Revision" },
      {
        name: "description",
        content:
          "Your MYP revision streak, accuracy and estimated MYP Level 1-8 across every subject you study.",
      },
      { property: "og:title", content: "My progress — MYP Revision" },
      { property: "og:description", content: "Track your MYP revision streak and accuracy." },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary_large_image" },
    ],
  }),
  component: Dashboard,
});

function Dashboard() {
  const { user } = useAuth();
  const queryClient = useQueryClient();

  const { data: profile } = useQuery({
    queryKey: ["profile", user?.id],
    queryFn: () => fetchProfile(user!.id),
    enabled: !!user,
  });
  const { data: attempts } = useQuery({
    queryKey: ["attempts", user?.id],
    queryFn: () => fetchAttempts(user!.id),
    enabled: !!user,
  });
  const { data: subjects } = useQuery({
    queryKey: ["subjects", profile?.grade ?? 5],
    queryFn: () => fetchSubjects(profile?.grade ?? 5),
  });

  const list = attempts ?? [];
  const total = list.length;
  const correct = list.filter((a) => a.correct).length;
  const accuracy = total ? correct / total : 0;
  const level = accuracyToMypLevel(accuracy);
  const streak = streakOf(list);
  const xp = xpFor(list);
  const lvl = levelFor(xp);
  const today = todayCount(list);
  const goalPct = Math.min(1, today / DAILY_GOAL);
  const week = lastSevenDays(list);
  const weekMax = Math.max(1, ...week.map((d) => d.count));
  const subjectOf = (id: string | null) => subjects?.find((s) => s.id === id);
  const subjectName = (id: string | null) => subjectOf(id)?.name ?? "Study session";

  const perSubject = new Map<string, { total: number; correct: number }>();
  for (const a of list) {
    if (!a.subject_id) continue;
    const entry = perSubject.get(a.subject_id) ?? { total: 0, correct: 0 };
    entry.total += 1;
    if (a.correct) entry.correct += 1;
    perSubject.set(a.subject_id, entry);
  }
  const weakest = [...perSubject.entries()]
    .filter(([, v]) => v.total >= 3)
    .sort((a, b) => a[1].correct / a[1].total - b[1].correct / b[1].total)
    .slice(0, 3);
  const lastSubject = subjectOf(list.find((a) => a.subject_id)?.subject_id ?? null);

  async function setGrade(grade: number) {
    if (!user) return;
    const { error } = await supabase.from("profiles").update({ grade }).eq("id", user.id);
    if (error) {
      toast.error("Could not save your grade.");
      return;
    }
    queryClient.invalidateQueries({ queryKey: ["profile", user.id] });
    toast.success(`Your grade is now MYP ${grade}.`);
  }

  const name = profile?.display_name || user?.email?.split("@")[0] || "there";
  const R = 34;
  const C = 2 * Math.PI * R;

  return (
    <div className="page-fade mx-auto max-w-[1200px] px-6 py-12 md:px-12">
      <p className="text-sm text-muted-foreground">Welcome back</p>
      <h1 className="text-4xl">{name}</h1>

      <section className="mt-8 grid gap-4 lg:grid-cols-3">
        <div className="flex items-center gap-5 rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
          <svg viewBox="0 0 80 80" className="size-20 shrink-0 -rotate-90" aria-hidden="true">
            <circle
              cx="40"
              cy="40"
              r={R}
              fill="none"
              strokeWidth="8"
              className="stroke-secondary"
            />
            <circle
              cx="40"
              cy="40"
              r={R}
              fill="none"
              strokeWidth="8"
              strokeLinecap="round"
              className="stroke-primary transition-all"
              strokeDasharray={C}
              strokeDashoffset={C * (1 - goalPct)}
            />
          </svg>
          <div>
            <p className="flex items-center gap-1.5 text-sm text-muted-foreground">
              <Target className="size-4" /> Daily goal
            </p>
            <p className="font-display text-2xl">
              {Math.min(today, DAILY_GOAL)} / {DAILY_GOAL}
            </p>
            <p className="text-xs text-muted-foreground">
              {today >= DAILY_GOAL
                ? "Goal done. Anything extra is a bonus."
                : `${DAILY_GOAL - today} more questions to hit today's goal`}
            </p>
          </div>
        </div>

        <div className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
          <p className="flex items-center gap-1.5 text-sm text-muted-foreground">
            <Flame className="size-4 text-accent" /> Streak
          </p>
          <p className="font-display text-4xl">
            {streak}{" "}
            <span className="text-lg text-muted-foreground">day{streak === 1 ? "" : "s"}</span>
          </p>
          <div className="mt-3 flex items-end gap-1.5" aria-label="Questions per day, last 7 days">
            {week.map((d, i) => (
              <div key={i} className="flex flex-1 flex-col items-center gap-1">
                <div className="flex h-10 w-full items-end">
                  <div
                    className={`w-full rounded-sm ${d.count ? "bg-primary" : "bg-secondary"}`}
                    style={{ height: `${Math.max(10, (d.count / weekMax) * 100)}%` }}
                  />
                </div>
                <span
                  className={`text-[10px] ${d.today ? "font-semibold" : "text-muted-foreground"}`}
                >
                  {d.label}
                </span>
              </div>
            ))}
          </div>
        </div>

        <div className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
          <p className="flex items-center gap-1.5 text-sm text-muted-foreground">
            <Zap className="size-4 text-accent" /> Level {lvl.index} · {lvl.name}
          </p>
          <p className="font-display text-4xl">{xp} XP</p>
          <div className="mt-3 h-2 overflow-hidden rounded-full bg-secondary">
            <div
              className="h-full rounded-full bg-primary transition-all"
              style={{ width: `${Math.round(lvl.pct * 100)}%` }}
            />
          </div>
          <p className="mt-2 text-xs text-muted-foreground">
            {lvl.next ? `${lvl.toNext} XP to ${lvl.next.name}` : "Top level reached"}
          </p>
        </div>
      </section>

      <section className="mt-4 grid gap-4 md:grid-cols-2">
        {lastSubject ? (
          <Link
            to="/subjects/$slug"
            params={{ slug: lastSubject.slug }}
            search={{ grade: profile?.grade ?? 5, tab: "Study" }}
            className="card-lift flex items-center justify-between gap-4 rounded-lg border border-primary/40 bg-primary/5 p-5"
          >
            <span>
              <span className="block text-xs uppercase tracking-wide text-muted-foreground">
                Keep going
              </span>
              <span className="mt-1 block font-display text-xl">Back to {lastSubject.name}</span>
            </span>
            <ArrowRight className="size-5 text-primary" />
          </Link>
        ) : (
          <Link
            to="/subjects"
            className="card-lift flex items-center justify-between gap-4 rounded-lg border border-primary/40 bg-primary/5 p-5"
          >
            <span>
              <span className="block text-xs uppercase tracking-wide text-muted-foreground">
                Start here
              </span>
              <span className="mt-1 block font-display text-xl">Pick your first subject</span>
            </span>
            <ArrowRight className="size-5 text-primary" />
          </Link>
        )}
        <Link
          to="/eassessment"
          className="card-lift flex items-center justify-between gap-4 rounded-lg border border-border bg-card p-5"
        >
          <span>
            <span className="flex items-center gap-1.5 text-xs uppercase tracking-wide text-muted-foreground">
              <CalendarDays className="size-3.5" /> {daysToMaySession()} days to 1 May
            </span>
            <span className="mt-1 block font-display text-xl">Practise your eAssessment</span>
          </span>
          <ArrowRight className="size-5 text-primary" />
        </Link>
      </section>

      <div className="mt-4 grid gap-4 sm:grid-cols-3">
        <Stat value={`${total}`} label="Questions answered" />
        <Stat value={`${Math.round(accuracy * 100)}%`} label="Accuracy" />
        <Stat
          value={total ? `${level}` : "—"}
          label={`MYP Level (of 8)${total ? ` — ${MYP_LEVEL_LABELS[level]}` : ""}`}
        />
      </div>

      <section className="mt-10 grid gap-6 lg:grid-cols-2">
        <div className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
          <h2 className="font-display text-2xl">Subjects to work on</h2>
          {weakest.length ? (
            <ul className="mt-4 flex flex-col gap-3">
              {weakest.map(([id, v]) => {
                const sub = subjectOf(id);
                return (
                  <li key={id} className="flex items-center justify-between gap-4">
                    {sub ? (
                      <Link
                        to="/subjects/$slug"
                        params={{ slug: sub.slug }}
                        search={{ grade: profile?.grade ?? 5, tab: "Study" }}
                        className="text-sm underline underline-offset-4"
                      >
                        {sub.name}
                      </Link>
                    ) : (
                      <span className="text-sm">{subjectName(id)}</span>
                    )}
                    <span className="text-sm text-muted-foreground">
                      {Math.round((v.correct / v.total) * 100)}% of {v.total}
                    </span>
                  </li>
                );
              })}
            </ul>
          ) : (
            <p className="mt-3 text-sm text-muted-foreground">
              Answer a few more questions and your weakest subjects will show up here.
            </p>
          )}
        </div>

        <div className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
          <h2 className="font-display text-2xl">Recent activity</h2>
          {list.length ? (
            <ul className="mt-4 flex flex-col gap-2 text-sm">
              {list.slice(0, 8).map((a) => (
                <li key={a.id} className="flex items-center justify-between gap-4">
                  <span>{subjectName(a.subject_id)}</span>
                  <span className={a.correct ? "text-success" : "text-destructive"}>
                    {a.correct ? "Correct" : "Incorrect"}
                  </span>
                </li>
              ))}
            </ul>
          ) : (
            <p className="mt-3 text-sm text-muted-foreground">
              Nothing yet.{" "}
              <Link to="/subjects" className="underline underline-offset-4">
                Pick a subject
              </Link>{" "}
              to get started.
            </p>
          )}
        </div>
      </section>

      <section className="mt-10">
        <h2 className="font-display text-2xl">Your grade</h2>
        <div className="mt-3 flex flex-wrap gap-2">
          {GRADES.map((g) => (
            <button
              key={g}
              type="button"
              onClick={() => setGrade(g)}
              className={`rounded-full border px-4 py-1.5 text-sm transition-colors ${
                (profile?.grade ?? 5) === g
                  ? "border-primary bg-primary text-primary-foreground"
                  : "border-border bg-card hover:bg-secondary"
              }`}
            >
              MYP {g}
            </button>
          ))}
        </div>
      </section>
    </div>
  );
}

function Stat({ value, label }: { value: string; label: string }) {
  return (
    <div className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
      <p className="font-display text-3xl">{value}</p>
      <p className="mt-1 text-sm text-muted-foreground">{label}</p>
    </div>
  );
}
