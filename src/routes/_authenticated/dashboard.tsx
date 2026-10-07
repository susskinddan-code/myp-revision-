import { createFileRoute, Link } from "@tanstack/react-router";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { toast } from "sonner";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/hooks/use-auth";
import {
  fetchAttempts,
  fetchProfile,
  fetchSubjects,
  computeStreak,
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
    queryKey: ["subjects", profile?.grade ?? 4],
    queryFn: () => fetchSubjects(profile?.grade ?? 4),
  });

  const list = attempts ?? [];
  const total = list.length;
  const correct = list.filter((a) => a.correct).length;
  const accuracy = total ? correct / total : 0;
  const level = accuracyToMypLevel(accuracy);
  const streak = computeStreak(list.map((a) => a.created_at));
  const subjectName = (id: string | null) =>
    subjects?.find((s) => s.id === id)?.name ?? "Study session";

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

  return (
    <div className="page-fade mx-auto max-w-[1200px] px-6 py-12 md:px-12">
      <h1 className="text-4xl">My progress</h1>
      <p className="mt-2 text-muted-foreground">
        {profile?.display_name ? `${profile.display_name} — ` : ""}
        {user?.email}
      </p>

      <div className="mt-8 grid gap-4 sm:grid-cols-4">
        <Stat value={`${streak}`} label="Day streak" />
        <Stat value={`${total}`} label="Questions answered" />
        <Stat value={`${Math.round(accuracy * 100)}%`} label="Accuracy" />
        <Stat
          value={total ? `${level}` : "—"}
          label={`MYP Level (of 8)${total ? ` — ${MYP_LEVEL_LABELS[level]}` : ""}`}
        />
      </div>

      <section className="mt-10">
        <h2 className="font-display text-2xl">Your grade</h2>
        <div className="mt-3 flex flex-wrap gap-2">
          {GRADES.map((g) => (
            <button
              key={g}
              type="button"
              onClick={() => setGrade(g)}
              className={`rounded-full border px-4 py-1.5 text-sm transition-colors ${
                (profile?.grade ?? 4) === g
                  ? "border-primary bg-primary text-primary-foreground"
                  : "border-border bg-card hover:bg-secondary"
              }`}
            >
              MYP {g}
            </button>
          ))}
        </div>
      </section>

      <section className="mt-10 grid gap-6 lg:grid-cols-2">
        <div className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
          <h2 className="font-display text-2xl">Topics to work on</h2>
          {weakest.length ? (
            <ul className="mt-4 flex flex-col gap-3">
              {weakest.map(([id, v]) => (
                <li key={id} className="flex items-center justify-between gap-4">
                  <span className="text-sm">{subjectName(id)}</span>
                  <span className="text-sm text-muted-foreground">
                    {Math.round((v.correct / v.total) * 100)}% of {v.total}
                  </span>
                </li>
              ))}
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
