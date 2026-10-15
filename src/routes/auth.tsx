import { createFileRoute, useNavigate, Link } from "@tanstack/react-router";
import { useEffect, useState } from "react";
import { safeRedirect } from "@/lib/safe-redirect";
import { toast } from "sonner";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/hooks/use-auth";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";

export const Route = createFileRoute("/auth")({
  head: () => ({
    meta: [
      { title: "Sign in — MYP Revision" },
      {
        name: "description",
        content:
          "Sign in or create a free MYP Revision account to track your progress across all 21 MYP subjects.",
      },
      { property: "og:title", content: "Sign in — MYP Revision" },
      {
        property: "og:description",
        content: "Create a free account to save your MYP revision progress.",
      },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary_large_image" },
    ],
  }),
  validateSearch: (s: Record<string, unknown>): { redirect?: string | undefined } => {
    // Always return the key: if a rejected value were left out, TanStack would merge the raw search
    // string back in and the attacker's URL would still reach Route.useSearch().
    return { redirect: safeRedirect(s["redirect"]) };
  },
  component: AuthPage,
});

function AuthPage() {
  const [mode, setMode] = useState<"signin" | "signup" | "reset">("signin");
  const { redirect } = Route.useSearch();
  // Checked again at the point of use, whatever validateSearch returned.
  const target = safeRedirect(redirect) ?? "/dashboard";
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [busy, setBusy] = useState(false);
  const [sentConfirmation, setSentConfirmation] = useState(false);
  const [sentReset, setSentReset] = useState(false);
  const [newPassword, setNewPassword] = useState("");
  const { user, loading, recovering, finishRecovery } = useAuth();
  const navigate = useNavigate();

  useEffect(() => {
    if (!loading && user && !recovering)
      navigate({ href: safeRedirect(target) ?? "/dashboard", replace: true });
  }, [user, loading, navigate, target, recovering]);

  async function cancelRecovery() {
    finishRecovery();
    await supabase.auth.signOut();
  }

  async function handleNewPassword(event: React.FormEvent) {
    event.preventDefault();
    setBusy(true);
    try {
      const { error } = await supabase.auth.updateUser({ password: newPassword });
      if (error) throw error;
      toast.success("Password updated.");
      finishRecovery();
    } catch (error) {
      toast.error(error instanceof Error ? error.message : "Could not update the password");
    } finally {
      setBusy(false);
    }
  }

  async function handleSubmit(event: React.FormEvent) {
    event.preventDefault();
    setBusy(true);
    try {
      if (mode === "reset") {
        const { error } = await supabase.auth.resetPasswordForEmail(email, {
          redirectTo: `${window.location.origin}/auth`,
        });
        if (error) throw error;
        setSentReset(true);
        return;
      }
      if (mode === "signup") {
        const { data, error } = await supabase.auth.signUp({
          email,
          password,
          options: {
            emailRedirectTo: `${window.location.origin}${safeRedirect(target) ?? "/dashboard"}`,
          },
        });
        if (error) throw error;
        if (!data.session) {
          setSentConfirmation(true);
          return;
        }
        navigate({ href: safeRedirect(target) ?? "/dashboard" });
      } else {
        const { error } = await supabase.auth.signInWithPassword({ email, password });
        if (error) throw error;
        navigate({ href: safeRedirect(target) ?? "/dashboard" });
      }
    } catch (error) {
      toast.error(error instanceof Error ? error.message : "Something went wrong");
    } finally {
      setBusy(false);
    }
  }

  async function handleGoogle() {
    setBusy(true);
    // Standard Supabase OAuth. Needs the Google provider enabled in the Supabase project
    // (Authentication -> Providers -> Google) and this site's URL in the redirect allow-list.
    const { error } = await supabase.auth.signInWithOAuth({
      provider: "google",
      options: { redirectTo: `${window.location.origin}${safeRedirect(target) ?? "/dashboard"}` },
    });
    if (error) {
      setBusy(false);
      toast.error("Google sign-in could not be started. Please try again.");
    }
  }

  return (
    <div className="page-fade mx-auto flex max-w-md flex-col gap-6 px-6 py-16">
      <div className="text-center">
        <h1 className="text-3xl">
          {recovering
            ? "Choose a new password"
            : mode === "signin"
              ? "Welcome back"
              : mode === "signup"
                ? "Create your account"
                : "Reset your password"}
        </h1>
        <p className="mt-2 text-sm text-muted-foreground">
          Your answers, streak and weak topics are saved to your account.
        </p>
      </div>

      {recovering ? (
        <div className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
          <form onSubmit={handleNewPassword} className="flex flex-col gap-4">
            <div className="flex flex-col gap-2">
              <Label htmlFor="new-password">New password</Label>
              <Input
                id="new-password"
                type="password"
                required
                minLength={6}
                autoComplete="new-password"
                value={newPassword}
                onChange={(e) => setNewPassword(e.target.value)}
                className="rounded-md"
              />
            </div>
            <Button type="submit" disabled={busy} className="rounded-full">
              Save new password
            </Button>
            <Button
              type="button"
              variant="ghost"
              disabled={busy}
              className="rounded-full"
              onClick={cancelRecovery}
            >
              Cancel and sign out
            </Button>
          </form>
        </div>
      ) : sentReset ? (
        <div className="rounded-lg border border-border bg-card p-6 text-center shadow-[var(--shadow-soft)]">
          <h2 className="text-xl">Check your email</h2>
          <p className="mt-2 text-sm text-muted-foreground">
            If {email} has an account, we sent a link to reset the password.
          </p>
          <Button
            type="button"
            variant="outline"
            className="mt-4 rounded-full"
            onClick={() => {
              setSentReset(false);
              setMode("signin");
            }}
          >
            Back to sign in
          </Button>
        </div>
      ) : sentConfirmation ? (
        <div className="rounded-lg border border-border bg-card p-6 text-center shadow-[var(--shadow-soft)]">
          <h2 className="text-xl">Check your email</h2>
          <p className="mt-2 text-sm text-muted-foreground">
            We sent a confirmation link to {email}. Click it to finish setting up your account.
          </p>
        </div>
      ) : (
        <div className="rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
          <form onSubmit={handleSubmit} className="flex flex-col gap-4">
            <div className="flex flex-col gap-2">
              <Label htmlFor="email">Email</Label>
              <Input
                id="email"
                type="email"
                required
                autoComplete="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="rounded-md"
              />
            </div>
            {mode !== "reset" ? (
              <div className="flex flex-col gap-2">
                <Label htmlFor="password">Password</Label>
                <Input
                  id="password"
                  type="password"
                  required
                  minLength={6}
                  autoComplete={mode === "signin" ? "current-password" : "new-password"}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="rounded-md"
                />
                {mode === "signin" ? (
                  <button
                    type="button"
                    className="self-end text-xs text-muted-foreground underline underline-offset-4 hover:text-foreground"
                    onClick={() => setMode("reset")}
                  >
                    Forgot password?
                  </button>
                ) : null}
              </div>
            ) : null}
            <Button type="submit" disabled={busy} className="rounded-full">
              {mode === "signin"
                ? "Sign in"
                : mode === "signup"
                  ? "Create account"
                  : "Send reset link"}
            </Button>
          </form>

          {mode !== "reset" ? (
            <>
              <div className="my-4 flex items-center gap-3 text-xs text-muted-foreground">
                <span className="h-px flex-1 bg-border" />
                or
                <span className="h-px flex-1 bg-border" />
              </div>

              <Button
                type="button"
                variant="outline"
                disabled={busy}
                onClick={handleGoogle}
                className="w-full rounded-full"
              >
                Continue with Google
              </Button>
            </>
          ) : null}

          <p className="mt-5 text-center text-sm text-muted-foreground">
            {mode === "signin" ? "New to MYP Revision?" : "Already have an account?"}{" "}
            <button
              type="button"
              className="font-medium text-foreground underline underline-offset-4"
              onClick={() => setMode(mode === "signin" ? "signup" : "signin")}
            >
              {mode === "signin" ? "Create an account" : "Sign in"}
            </button>
          </p>
        </div>
      )}

      <p className="text-center text-sm text-muted-foreground">
        <Link to="/subjects" className="underline underline-offset-4">
          Browse subjects first
        </Link>
      </p>
    </div>
  );
}
