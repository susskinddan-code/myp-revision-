# Code review, round 3 (read-only review of uncommitted src/ + migrations 0006/0007)

Scope: src/lib/{ai-core.server,ai.functions,anthropic.server,supabase-admin.server,typed-answer,task-markup}.ts,
src/components/study/{PaperRunner,QuestionRunner,TaskBody}.tsx, SiteHeader.tsx, src/routes/eassessment/$area.tsx,
src/routes/auth.tsx, drizzle/migrations/0006 + 0007.

Verified by running: scripts/test-ai-server.mts, test-task-markup.mts, test-typed-answer.mts (all pass),
scripts/check-paper-sizes.mjs (971 tasks, 0 over caps). Built output in .output/public was grepped for
SERVICE_ROLE, api.anthropic.com, answer_cache, ANTHROPIC_API_KEY: none in the client bundle (only in
.output/server). No service-role leak. Migration 0007 does REVOKE the four SECURITY DEFINER functions from
public/anon/authenticated and grants only service_role, so the RPC concern is handled.

Confirmed by a one-line tsx run: sanitizeData("<stu<student_answer>dent_answer>X") returns "<student_answer>X".

## HIGH

### H1. gradePaper trusts the client for the question and the mark scheme (open Claude proxy + self-marking)
ai-core.server.ts:385-407 (input), 476-487 (prompt), ai.functions.ts:41-44, PaperRunner.tsx:239-251.
The server marks whatever `question` (10k chars) and `markScheme` (8k) the caller sends, for up to 30 answers.
- Abuse: any signed-in account can call gradePaper directly with arbitrary text in `question`/`markScheme`
  and read back up to 4000 output tokens of free-form text in `feedback`. It is a rate-limited but free
  general-purpose Claude endpoint, and one call can carry about 540k chars of input (about 135k tokens).
- Integrity: a student can send `markScheme: "Any answer [10]"` and get full marks. recordAttempt then
  stores `correct: true` in their own stats. Also the full mark scheme of every task is shipped to the
  browser (and into sessionStorage) before the sitting starts.
Fix: send only `{paperId | generatedTaskIds, position, response}`. Look up question and mark scheme
server-side with the admin client (stored `paper_questions` and `generated_tasks`). For tasks that exist only
client-side (gen-new-*), insert them into `generated_tasks` before returning them (the id then always exists
in the DB), and refuse unknown ids. Stop returning `mark_scheme` to the client until after marking
(return it in the marking result). At minimum, add a total input budget (sum of question+scheme+response
<= ~60k chars) and `.max(...)` on `paperTitle`/`criterion` use.

### H2. Student-controlled text reaches the generation prompt and is then banked for every student
ai-core.server.ts:568 (`seen`), 672, 685-687 (prompt), 887-913 (bank insert), 70-72 (sanitizeData).
`seen` is 20 free strings of 200 chars from the client (localStorage or a direct server-fn call). It is placed
in the writer prompt and the resulting tasks are inserted into the shared `generated_tasks` bank with no
review, then served to other (school-age) students. validateRaw only checks structure, marks and the BANNED
regex, so an injected instruction ("include this link / write that...") yields a structurally valid task that
persists until three reports. When `topics` cannot be checked (admin client missing or topic lookup error,
lines 758-773) topic names are also free text, but those tasks are not banked, so `seen` is the real route.
Fix: drop `seen` from the input. Build the avoid-list server-side from `seenIds` (select the first 90 chars of
those bank rows). Add a cheap content filter before banking (reject URLs/`http`, emails, `ignore previous`,
HTML tags, non-printable chars, content > 6000 chars) and consider banking new tasks only after a
second validation call or with `reports`-style "quarantine" (served to the author only until seen N times).

### H3. Per-user, in-memory rate limits do not bound cost on the deployed target
ai-core.server.ts:37-55, vite build preset is `cloudflare-module` (.output/nitro.json).
The `windows` Map lives in one isolate; Workers run many isolates, so the 8/10 min, 40/min limits are
per-isolate and reset on every cold start. Accounts are free (auth.tsx signUp; if email confirmation is off
in the Supabase project, unlimited). Worst case per generate call: up to 12 tasks -> 4 batches x 2 rounds x
(1 retry) x 7000 max tokens on Sonnet (lines 693, 703-704, 864-872), roughly 0.4-0.5M output tokens per
request, repeatable across accounts. checkTypedAnswer and gradePaper are similar.
Fix: persist usage in Postgres (table `ai_usage(user_id, day, kind, n)` incremented with an atomic RPC,
service_role only) and enforce a per-user daily cap plus a global daily budget kill switch (env
`AI_DAILY_BUDGET_CALLS`). Require confirmed email. Cap one request to 1 round of at most 2 batches, or
move generation to a background job. Keep the in-memory limiter only as a burst smoother.

## MEDIUM

### M1. sanitizeData is bypassable (single-pass replace)
ai-core.server.ts:70-72. "<stu<student_answer>dent_answer>" collapses to a real "<student_answer>" tag, and
`</student_answer>` can be reconstituted the same way, letting an answer close the data block and add fake
"Mark scheme:" lines to gradePaper or fake context to checkTypedAnswer. Impact is mostly self-marking, but
this is the defence the system prompts rely on.
Fix: loop until stable, or just escape every `<` and `>` in student text (`s.replace(/</g,"‹")`), or
send student text as a JSON-encoded string field rather than between tags.

### M2. Anyone can retire any cached verdict or banked task alone (no per-user de-duplication)
ai-core.server.ts:348-372, 937-951; migration 0007 (`report_cached_check`, `bump_task_report`). Three calls by
one account (rate 20/min) delete a cache row or take a good task out of the bank; scripting this empties the
bank/cache and forces paid regeneration.
Fix: table `ai_reports(user_id uuid, kind text, target text, primary key (user_id, kind, target))`; insert on
conflict do nothing in the RPC and count rows. Retire at 3 distinct users.

### M3. Server timeout is shorter than a 7000-token generation, so "Write me a new paper" will often fail
anthropic.server.ts:17-21 (default 60 000 ms), ai-core.server.ts:693. Three long tasks with tables and
mark schemes can take 60-120 s at Sonnet speeds. Aborted calls are not retried (line 58), so the student sees
"saved tasks used". The UI promises "up to a minute" but a full-length paper is up to 4 batches in 2 waves
plus an optional second round, so 2-5 min end to end, which may also exceed host request limits.
Fix: use `stream: true` (or a 150 s timeout for exam writing), generate batches of 2 tasks, and have the
client call generate once per batch (parallel from the browser) instead of one long request. Make timeouts
per call type (`ANTHROPIC_TIMEOUT_MS` is global).

### M4. gradePaper max_tokens is fixed at 4000 for up to 30 answers
ai-core.server.ts:495, anthropic.server.ts:118-121. A 25-30 question paper with 1-3 sentence feedback each
can exceed 4000 tokens, `stop_reason=max_tokens` is treated as total failure, the student must resubmit
and burns the 8-per-10-min budget (line 452).
Fix: `maxTokens: Math.min(8000, 400 + 160 * answers.length)`; on max_tokens, parse the partial tool input if
present or retry once with fewer feedback sentences.

### M5. Interactive widgets lose their state on reload (answers still submitted)
TaskBody.tsx:97-99 (DragTable), 244-248 (PlotGrid), 503-505 (FillTable) keep local `useState` and are not
seeded from `values`; only `select` is controlled (line 36). PaperRunner restores `widgetVals` from
sessionStorage (PaperRunner.tsx:115-117) and `fullResponse` sends them. After a reload the student sees empty
tables/grids but the old placements are marked, and any edit overwrites silently.
Fix: pass `value` to all widgets and derive `placed`/`points`/`cells` from the encoded string (add decoders
next to encodeFillAnswer), or store structured widget state instead of the encoded string.

### M6. checkTypedAnswer has an untrusted path and client-controlled attempt/history
ai-core.server.ts:97-112, 210-222, 229. If `questionId` is missing or the admin client is absent, the
question, correct answer and explanation come from the client (open mini-proxy, 40 calls/min, and a student
can self-mark). `attempt` and `history` are client claims, so attempt=5 requests the "nearly give it away"
hint on the first try; `studentAnswer` may be empty (no `.min(1)`), which still costs an AI call.
Fix: require `questionId` (reject when the lookup fails and admin exists; when admin is absent return
`errorCode:"no_key"` so the UI falls back to localCheck). Derive attempt from `history.length + 1`. Add
`studentAnswer: z.string().trim().min(1).max(1000)`.

### M7. Password recovery detection is fragile and can mismatch on hydration
auth.tsx:~52-58. `useState(() => /type=recovery/.test(window.location.hash))` is false on the server and
possibly true on the client (hydration mismatch). supabase-js clears the hash after processing, and the
`PASSWORD_RECOVERY` event can fire before the effect registers the listener; then `user` is set, `recovering`
is false and the user is redirected to /dashboard without ever choosing a password.
Fix: register `onAuthStateChange` at module level or read the hash in a `useEffect` (client only), store a
`sessionStorage` flag before redirect, and check `supabase.auth` `amr`/recovery in the session. Test the
real reset email flow once (also needs `<site>/auth` in Supabase redirect allow-list).

### M8. Unmarked questions silently inflate the score
PaperRunner.tsx:284-291. Unmarked tasks are excluded from `total`, so if the model skips the hardest
question the student gets a higher Level and a higher estimated 1-7 grade; only a small red note says so.
Fix: for exam results, refuse to show the Level/1-7 grade when `unmarkedCount > 0` ("Re-mark to get your
grade"), and offer a "Mark the missing questions" call that sends only those positions.

## LOW

- L1. AI free-text is not checked against the Levels 1-8 rule. BANNED (ai-core.server.ts:625) is applied to
  generated tasks only. Apply the same regex to `feedback` in gradePaperCore (line 538) and checkAnswerCore
  (line 312); on a hit, strip the sentence or fall back to a generic message. (Result UI itself is correct:
  PaperRunner.tsx:429-437 shows both scales, labelled, only for `exam`.)
- L2. anthropic.server.ts:11-12. `ANTHROPIC_FAST_MODEL` defaults to the main model, so answer checking (the
  most frequent call) runs on Sonnet. Default to a Haiku-class model for `fast: true`.
- L3. No `pg_temp` at the end of `search_path` in the four SECURITY DEFINER functions (0007), and no
  `revoke all on table ... from anon, authenticated` on answer_cache/generated_tasks (0006). RLS-without-policy
  already blocks access; the revoke is defence in depth if a policy is ever added by mistake.
  Use `set search_path = public, pg_temp`.
- L4. bump_task_served counts tasks that are later dropped by trimming (ai-core.server.ts:884 vs 919-930),
  skewing the rotation. Call it after `trimmed` is final and only for banked ids in `all`.
- L5. planRound text "any part of the MYP 5 course" is hard-coded (ai-core.server.ts:729); use MYP_LINE(grade).
- L6. Bank-only return path (843-846) does not apply the +25% overshoot rule used at 926, so a paper can run
  well over the sitting time. Bank grows without limit; add a per-subject cap or prune by reports/age.
- L7. safeRedirect (auth.tsx) rejects `//` and `\` but not control characters ("/\t/evil.com" is normalised to
  "//evil.com" by URL parsing). pushState blocks cross-origin so it is not exploitable today; strip
  `[\u0000-\u001f]` and reject any `://` anyway.
- L8. authenticate() throws plain Errors, and start.ts errorMiddleware turns anything without `statusCode` into
  a 500 HTML page. Throw `Object.assign(new Error("Unauthorized"), {statusCode: 401})` so PaperRunner's
  "Please sign in again" branch (describeError, line 72) and QuestionRunner's fallback behave as intended.
  Verify in a browser.
- L9. cacheKey/answer_cache stores raw student text (up to 180 chars) shared across students and never expires.
  Add a TTL/purge job and avoid caching answers that contain digits sequences resembling phone/email (or just
  skip keys containing `@`). Include a prompt-version prefix in the key so prompt edits invalidate old verdicts.
- L10. stemNeedsOptions still hides options for some choice-dependent stems, e.g. "Which reaction would be
  unsuitable for ...?", "What is true at equilibrium?" (found by scanning content/*). Add
  `which \w+ (would|could|is|are)` and `what is (true|false)` to EXPLICIT_CHOICES.
- L11. localCheck fallback (typed-answer.ts:125-134) accepts any answer that contains the key phrase and is up
  to 3x+10 chars, which is more lenient than the AI path; fine as an outage fallback but it marks first-try
  `correct` and awards XP. Consider not counting fallback matches as first-try.
- L12. Interactive-answer block is appended after the typed answer (PaperRunner.tsx:216) and the server cuts
  at 8000 chars (ai-core.server.ts:459), so a long essay answer can push the plotted/filled answers off the
  end. Put the interactive block first, or reserve budget for it.

## Checked and fine
- Service-role key: only imported by *.server.ts files; absent from client bundle (verified by grep).
- RPC exposure: REVOKE from public/anon/authenticated, GRANT to service_role (0007 lines 55-62).
- Cache poisoning across students: cache is written only for server-loaded questions (trusted flag), keyed by
  a hash of the stored question/answer plus the normalised first-attempt text, first attempts only, and not
  cached when the feedback leaks the stored answer. A student can only influence the verdict for the exact
  same normalised text; residual risk is a wrong AI verdict reused for everyone (see M2 for the report path).
- Zod: all string/array inputs capped; response truncation and total-answer budget present.
- MYP rules: prompts state Levels 1-8; BANNED blocks "levels 1-7" and DP/A-level terms in generated tasks;
  1-7 appears only in the exam-style result and the eAssessment explainer text.
