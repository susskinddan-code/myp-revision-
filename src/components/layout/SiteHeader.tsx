import { useEffect, useRef, useState } from "react";
import { Link, useNavigate, useRouterState } from "@tanstack/react-router";
import { useQueryClient, useQuery } from "@tanstack/react-query";
import { GraduationCap, LogOut, Flame, Menu, X } from "lucide-react";
import { fetchAttempts } from "@/lib/myp";
import { streakOf } from "@/lib/progress";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/hooks/use-auth";
import { Button } from "@/components/ui/button";

const LINKS = [
  { to: "/past-papers", label: "Papers" },
  { to: "/daily", label: "Daily" },
  { to: "/eassessment", label: "eAssessment" },
  { to: "/subjects", label: "Subjects" },
  { to: "/my-files", label: "My files" },
] as const;

const linkClass =
  "rounded-full px-3 py-2 text-muted-foreground transition-colors hover:bg-secondary hover:text-foreground";
const activeClass = "rounded-full px-3 py-2 bg-secondary text-foreground";
// Phone menu rows use the full foreground colour: muted grey on the cream menu is below WCAG AA (4.5:1).
const menuLinkClass = "rounded-full px-3 py-2 text-foreground transition-colors hover:bg-secondary";

export function SiteHeader() {
  const { user, loading } = useAuth();
  const navigate = useNavigate();
  const queryClient = useQueryClient();
  const href = useRouterState({ select: (s) => s.location.href });
  const [open, setOpen] = useState(false);
  const headerRef = useRef<HTMLElement>(null);
  const toggleRef = useRef<HTMLButtonElement>(null);
  const { data: attempts } = useQuery({
    queryKey: ["attempts", user?.id],
    queryFn: () => fetchAttempts(user!.id),
    enabled: !!user,
  });
  const streak = attempts ? streakOf(attempts) : 0;

  // Close the phone menu whenever the page changes.
  useEffect(() => setOpen(false), [href]);

  // Phone menu: Escape closes it and returns focus to the toggle; so does a press outside the header.
  useEffect(() => {
    if (!open) return;
    function onKey(e: KeyboardEvent) {
      if (e.key !== "Escape") return;
      setOpen(false);
      toggleRef.current?.focus();
    }
    function onPointer(e: PointerEvent) {
      if (!headerRef.current?.contains(e.target as Node)) setOpen(false);
    }
    function onFocusIn(e: FocusEvent) {
      // Tabbing past the end of the menu (or into the page) closes it without stealing focus.
      if (!headerRef.current?.contains(e.target as Node)) setOpen(false);
    }
    document.addEventListener("keydown", onKey);
    document.addEventListener("pointerdown", onPointer);
    document.addEventListener("focusin", onFocusIn);
    return () => {
      document.removeEventListener("keydown", onKey);
      document.removeEventListener("pointerdown", onPointer);
      document.removeEventListener("focusin", onFocusIn);
    };
  }, [open]);

  async function handleSignOut() {
    setOpen(false);
    await queryClient.cancelQueries();
    queryClient.clear();
    await supabase.auth.signOut();
    navigate({ to: "/auth", replace: true });
  }

  // Come back to this page after signing in (not from /auth itself).
  const signInSearch = href.startsWith("/auth") ? {} : { redirect: href };

  const streakBadge =
    user && streak > 0 ? (
      <span
        className="flex items-center gap-1 rounded-full bg-accent/15 px-2.5 py-1 text-xs font-medium"
        title={`${streak}-day streak`}
      >
        <Flame className="size-3.5 text-accent" />
        {streak}
      </span>
    ) : null;

  return (
    <header
      ref={headerRef}
      className="sticky top-0 z-40 border-b border-border bg-background/85 backdrop-blur"
    >
      {/* Fixed height (h-14 phone, h-16 from sm) so sticky elements below can offset by a known amount. */}
      <div className="mx-auto flex h-14 max-w-[1200px] flex-nowrap items-center justify-between gap-x-2 px-3 sm:h-16 sm:gap-x-4 sm:px-6 md:px-12">
        <Link to="/" className="flex shrink-0 items-center gap-2" aria-label="MYP Revision home">
          <span className="flex size-9 items-center justify-center rounded-full bg-primary text-primary-foreground">
            <GraduationCap className="size-5" />
          </span>
          <span className="hidden font-display text-lg font-semibold sm:inline">MYP Revision</span>
        </Link>

        {/* Wide screens: inline nav */}
        <nav
          className="hidden items-center gap-1 whitespace-nowrap text-sm lg:flex"
          aria-label="Main"
        >
          {LINKS.map((l) => (
            <Link
              key={l.to}
              to={l.to}
              className={linkClass}
              activeProps={{ className: activeClass }}
            >
              {l.label}
            </Link>
          ))}
          {user ? (
            <>
              <Link to="/dashboard" className={linkClass} activeProps={{ className: activeClass }}>
                My progress
              </Link>
              {streakBadge}
              <Button
                variant="ghost"
                size="sm"
                className="rounded-full"
                onClick={handleSignOut}
                aria-label="Sign out"
              >
                <LogOut className="size-4" />
                Sign out
              </Button>
            </>
          ) : loading ? null : (
            <Button asChild size="sm" className="rounded-full">
              <Link to="/auth" search={signInSearch}>
                Sign in
              </Link>
            </Button>
          )}
        </nav>

        {/* Phones and tablets: Sign in stays visible, everything else is in a menu */}
        <div className="flex items-center gap-2 lg:hidden">
          {streakBadge}
          {!user && !loading ? (
            <Button asChild size="sm" className="rounded-full">
              <Link to="/auth" search={signInSearch}>
                Sign in
              </Link>
            </Button>
          ) : null}
          <Button
            ref={toggleRef}
            variant="ghost"
            size="icon"
            className="rounded-full"
            aria-label={open ? "Close menu" : "Open menu"}
            aria-expanded={open}
            aria-controls="mobile-nav"
            onClick={() => setOpen((o) => !o)}
          >
            {open ? <X className="size-5" /> : <Menu className="size-5" />}
          </Button>
        </div>
      </div>

      {open ? (
        <nav
          id="mobile-nav"
          aria-label="Main"
          className="absolute inset-x-0 top-full border-b border-border bg-background shadow-lg lg:hidden"
        >
          <div className="mx-auto flex max-w-[1200px] flex-col gap-1 px-3 py-3 text-base sm:px-6 md:px-12">
            {LINKS.map((l) => (
              <Link
                key={l.to}
                to={l.to}
                className={menuLinkClass}
                activeProps={{ className: activeClass }}
              >
                {l.label}
              </Link>
            ))}
            {user ? (
              <>
                <Link
                  to="/dashboard"
                  className={menuLinkClass}
                  activeProps={{ className: activeClass }}
                >
                  My progress
                </Link>
                <button
                  type="button"
                  onClick={handleSignOut}
                  className={`${menuLinkClass} flex items-center gap-2 text-left`}
                >
                  <LogOut className="size-4" />
                  Sign out
                </button>
              </>
            ) : null}
          </div>
        </nav>
      ) : null}
    </header>
  );
}
