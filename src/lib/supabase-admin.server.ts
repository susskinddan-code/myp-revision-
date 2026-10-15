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

let cachedPublic: SupabaseClient | null | undefined;

/**
 * Read-only client with the public (publishable) key, for rows that are public anyway (questions, stored
 * paper questions). Used to check client claims against the database when the service key is absent.
 */
export function publicClient(): SupabaseClient | null {
  if (cachedPublic !== undefined) return cachedPublic;
  const url = process.env["SUPABASE_URL"] ?? process.env["VITE_SUPABASE_URL"];
  const key =
    process.env["SUPABASE_PUBLISHABLE_KEY"] ?? process.env["VITE_SUPABASE_PUBLISHABLE_KEY"];
  cachedPublic =
    url && key
      ? createClient(url, key, {
          auth: { persistSession: false, autoRefreshToken: false, storage: undefined as never },
        })
      : null;
  return cachedPublic;
}
