import { useEffect, useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { fetchProfile } from "@/lib/myp";
import { useAuth } from "@/hooks/use-auth";

const KEY = "myp-grade";

/** The student's grade: saved profile, else last choice on this device, else MYP 5 (the priority grade). */
export function useMyGrade(): [number, (g: number) => void] {
  const { user } = useAuth();
  const [local, setLocal] = useState<number | null>(null);
  useEffect(() => {
    try {
      const v = Number(window.localStorage.getItem(KEY));
      if (v >= 1 && v <= 5) setLocal(v);
    } catch {
      /* storage can be unavailable */
    }
  }, []);
  const { data: profile } = useQuery({
    queryKey: ["profile", user?.id],
    queryFn: () => fetchProfile(user!.id),
    enabled: !!user,
  });
  const grade = local ?? profile?.grade ?? 5;
  const set = (g: number) => {
    setLocal(g);
    try {
      window.localStorage.setItem(KEY, String(g));
    } catch {
      /* ignore */
    }
  };
  return [grade, set];
}
