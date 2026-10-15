// Run with: npx tsx scripts/test-safe-redirect.mts
import assert from "node:assert/strict";
import { safeRedirect } from "../src/lib/safe-redirect.ts";

const bad: unknown[] = [
  "https://evil.com",
  "http://evil.com/x",
  "//evil.com",
  "///evil.com",
  "/\\evil.com",
  "/\\/evil.com",
  "\\\\evil.com",
  "/\t/evil.com",
  "/\n/evil.com",
  "/ /evil.com",
  "javascript:alert(1)",
  "JaVaScRiPt:alert(1)",
  "data:text/html,x",
  "evil.com",
  "",
  "/auth",
  "/auth?redirect=/x",
  "/auth/x",
  "/auth#x",
  "/" + "a".repeat(600),
  undefined,
  null,
  42,
  ["/x"],
  { a: 1 },
];
for (const v of bad) assert.equal(safeRedirect(v), undefined, `should reject ${JSON.stringify(v)}`);

const good = [
  "/",
  "/dashboard",
  "/eassessment/sciences?subject=physics&tab=Timed+paper",
  "/subjects#x",
];
for (const v of good) assert.equal(safeRedirect(v), v, `should accept ${v}`);

console.log("safe-redirect: all passed");
