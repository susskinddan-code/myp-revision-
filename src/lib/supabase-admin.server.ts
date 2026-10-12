// Server-only Supabase client using the service-role key. Never import from client code.
// Needs SUPABASE_SERVICE_ROLE_KEY (untracked .env.local / host secret). Without it the caches are simply skipped.
import { createClient, type SupabaseClient } from "@supabase/supabase-js";

let cached: SupabaseClient | null | undefined;

export function adminClient(): SupabaseClient | null {
  if (cached !== undefined) return cached;
  const url = process.env["SUPABASE_URL"] ?? process.env["VITE_SUPABASE_URL"];
  const key = process.env["SUPABASE_SERVICE_ROLE_KEY"];
  cached = url && key ? createClient(url, key, { auth: { persistSession: false } }) : null;
  return cached;
}
