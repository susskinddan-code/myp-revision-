/**
 * Post-sign-in destinations must be same-site paths. Accepts a single leading "/" followed by anything
 * that still resolves to the same origin; rejects absolute URLs ("https://..."), protocol-relative
 * ("//host", "/\host"), "javascript:" and friends, control characters or whitespace (browsers strip
 * tabs/newlines, so "/\t/evil.com" would become "//evil.com"), and the /auth page itself.
 * Returns undefined for anything else, so callers fall back to /dashboard.
 */
export function safeRedirect(v: unknown): string | undefined {
  if (typeof v !== "string" || v.length === 0 || v.length > 500) return undefined;
  if (v[0] !== "/" || v[1] === "/" || v[1] === "\\") return undefined;
  // eslint-disable-next-line no-control-regex
  if (/[\u0000- \u007f\\]/.test(v)) return undefined;
  if (v === "/auth" || v.startsWith("/auth?") || v.startsWith("/auth/") || v.startsWith("/auth#"))
    return undefined;
  try {
    const base = "http://same-site.invalid";
    if (new URL(v, base).origin !== base) return undefined;
  } catch {
    return undefined;
  }
  return v;
}
