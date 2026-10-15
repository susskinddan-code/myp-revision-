import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
  type ReactNode,
} from "react";
import type { Session, User } from "@supabase/supabase-js";
import { supabase } from "@/integrations/supabase/client";

type AuthValue = {
  user: User | null;
  session: Session | null;
  loading: boolean;
  /** True while the user holds a password-recovery session and still has to choose a new password. */
  recovering: boolean;
  /** Call once the new password is saved (or the recovery is abandoned). */
  finishRecovery: () => void;
};

const AuthContext = createContext<AuthValue>({
  user: null,
  session: null,
  loading: true,
  recovering: false,
  finishRecovery: () => {},
});

// The emailed reset link lands on /auth#...type=recovery. supabase-js removes the hash as soon as it
// has processed it (and may fire PASSWORD_RECOVERY before any component has subscribed), so the hash
// is read once, here, when this module loads, and remembered in sessionStorage for reloads.
const RECOVERY_KEY = "myp:recovery";
function readRecoveryFlag(): boolean {
  try {
    return window.sessionStorage.getItem(RECOVERY_KEY) === "1";
  } catch {
    return false;
  }
}
function writeRecoveryFlag(on: boolean) {
  try {
    if (on) window.sessionStorage.setItem(RECOVERY_KEY, "1");
    else window.sessionStorage.removeItem(RECOVERY_KEY);
  } catch {
    /* storage blocked: recovery still works for this page view via state */
  }
}
if (typeof window !== "undefined" && /(^|[#&])type=recovery(&|$)/.test(window.location.hash))
  writeRecoveryFlag(true);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [session, setSession] = useState<Session | null>(null);
  const [loading, setLoading] = useState(true);
  // Always false on the server and on the first client render (no hydration mismatch); the real value
  // is read in the effect below, before `loading` turns false, so no redirect can run in between.
  const [recovering, setRecovering] = useState(false);

  useEffect(() => {
    let active = true;
    if (readRecoveryFlag()) setRecovering(true);

    const { data } = supabase.auth.onAuthStateChange((event, nextSession) => {
      if (!active) return;
      if (event === "PASSWORD_RECOVERY") {
        writeRecoveryFlag(true);
        setRecovering(true);
      } else if (event === "SIGNED_OUT") {
        writeRecoveryFlag(false);
        setRecovering(false);
        // A saved exam belongs to whoever was signed in; never hand it to the next user of this tab.
        try {
          for (let i = sessionStorage.length - 1; i >= 0; i--) {
            const k = sessionStorage.key(i);
            if (k?.startsWith("myp-exam:")) sessionStorage.removeItem(k);
          }
        } catch {
          /* storage unavailable */
        }
      }
      setSession(nextSession);
      setLoading(false);
    });

    supabase.auth.getSession().then(({ data: { session: current } }) => {
      if (!active) return;
      setSession(current);
      setLoading(false);
    });

    return () => {
      active = false;
      data.subscription.unsubscribe();
    };
  }, []);

  const finishRecovery = useCallback(() => {
    writeRecoveryFlag(false);
    setRecovering(false);
  }, []);

  const value = useMemo(
    () => ({ user: session?.user ?? null, session, loading, recovering, finishRecovery }),
    [session, loading, recovering, finishRecovery],
  );
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth() {
  return useContext(AuthContext);
}
