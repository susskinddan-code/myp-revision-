# QA round 4 report: MYP Revision (working tree at /home/claude/myp-revision-, uncommitted fixer changes included)

Tested 2026-10-15 with headless Chromium (Playwright) at 1280px and 390px (plus 320px for select overflow), against vite dev (:8092/:8093), a fake PostgREST + auth (with new RPCs `ai_usage_take`, `ai_usage_refund`, `report_cached_check_v2`, `bump_task_report_v2`, `bump_task_served`, `bump_cache_use`, a working `generated_tasks` bank, failure switches for bank/RPC/refresh-token) and a fake Anthropic server with failure modes. The dev server ran with `SUPABASE_SERVICE_ROLE_KEY=fake`, `TASK_SIGNING_KEY=x`, and also once with neither key (signing falls back to the Anthropic key). No file under src/, content/, scripts/, drizzle/ was edited. Harness and screenshots: `/tmp/claude-0/-home-claude-myp-revision-/7bf37415-14ac-5462-9687-9bde57546ce6/scratchpad/qa4/` (and `qa4b/`, a second stack on :8093/:9301/:9298 used to run mode-changing tests in parallel). All servers were stopped afterwards.

Not tested: the real Anthropic and Supabase services, real JWT verification (getClaims against a real project), real Postgres (migration 0008 was read, not executed), Safari/Firefox, a real touch device (Playwright tap needs hasTouch; I used clicks at 390px), screen readers.

## 1. What I verified

| # | Area | Result | Evidence |
|---|---|---|---|
| 1a | Stored paper marked end to end (short, long-task, interactive widget papers, all 6 areas, 1280 and 390) | PASS | 24 runs per width (Mixed Short, Build my exam, "Write me a new paper", first stored paper per area): score shown, Level x of 8 and Grade x of 7, interactive answers reach the marker prompt, no console errors, no horizontal overflow. 11 widget papers at 320 and 390: 0px overflow before and after answering (N3 fixed). |
| 1b | Server loads question and scheme by id; client-supplied text ignored | PASS | Replayed the gradePaper server function with a `question: "EVIL"`/`markScheme: "[99]"` payload on a real stored id: prompt contained the DB scheme, not the client text. |
| 1c | Tampered / unknown task refused with no AI call | PASS | 0 Anthropic calls for: unknown uuid, valid+unknown mix, `gen-<unknown uuid>`, `gen-zzz`, `gen-new-` with no sig, bad sig, wrong-length sig, tampered scheme on a real signed gen-new task (UI shows "could not be matched ... Reload the page and sit it again"; untampered retry then marks 12/24 with 1 call), sql-ish id, expired/other-key. Real bank id with tampered text: marked from DB text. Dup ids/positions, 31 answers, grade 9, 40,001-char answer: rejected by validation, 0 AI calls. A 40,000-char answer is cut (prompt 10k chars). Title/subject injection is flattened to one line and `<` `>` neutralised. |
| 1d | gen-new signed tasks (bank write failing) and banked `gen-<uuid>` tasks (bank working) both mark | PASS | Mixed, Build, Timed "new paper" in both modes, and with no service key at all. |
| 1e | Unmarked flow | PASS | AI returns 1 of 4: result 3/6 "of the marked questions", 3 "Not marked" pills, no Level/Grade shown; "Mark the missing questions" re-sends only the 3 missing (1 call), then 12/24 with Level 2 of 8 and Grade 1 of 7. |
| 1f | Both scales only on exam result; Level 1-8 never 1-7 | PASS | Plain practice paper (/subjects/physics -> All practice papers): "MYP Level 3 of 8", no Grade x of 7. Exam result: Level x of 8 plus Grade x of 7. No "Level n of 7" anywhere in any result page. |
| 2a | Quota exhausted message | PASS with Low issues | Marking: "You have used today's AI allowance ... resets tomorrow" (0 AI calls). Global cap: "The AI helper has reached its daily limit for all students". See L1, L2. |
| 2b | Refund on failed AI call | PASS | marking 500/429/401/bad JSON/no tool/max_tokens/empty/NaN marks, typed check 500/429/bad JSON/empty/bad verdict/no tool, generation 500/429/bad JSON/empty/bad markup/bad sum/xss/missing/max_tokens: every failure shows `ai_usage_take` then `ai_usage_refund` of the same cost, usage back to prior value. |
| 2c | Per-user burst limit | PASS | 8 marking calls per 10 min, the 9th returns "too quickly"; failed calls do not use a slot (N6 fixed). |
| 2d | Fail-open | PASS | RPC absent (404), erroring (500) and connection dropped: generation, marking and typed checks all work, server logs `[ai] ai_usage_take failed (is migration 0008 applied?)` and carries on. No service key at all: stored papers, gen-new signed tasks and marking work. |
| 3a | N4 expired sitting after reload | PASS | 3 stored + 3 mixed: auto-submit once questions load, 1 AI call, result shown. Also with the refresh token request delayed 3 s (no spurious "sign in" error). |
| 3b | N5 signed-out gate | PASS | "Sign in before you start" on Timed paper / Mixed / Build tabs; in-exam banner with link; Submit shows sign-in link; after sign-in you return and "Resume exam" restores 3/3 answers and marking works. |
| 3c | N11 Resume banner | PASS | Readiness tab shows "You have an exam in progress ... clock is still running", Resume restores answers and the running clock. Header navigation asks `confirm`; Back returns. |
| 3d | N12 session conflict | PASS with Low issue | Deep link to another paper shows the conflict panel. See L5. |
| 3e | N2 widgets restore after reload | PASS | select, drag, plot (2 points) and fill cells identical before and after reload at 1280 and 390; marker prompt has them. |
| 3f | N7 phone menu | PASS | Escape closes (focus back on button), outside click closes, link click closes; signed-out Sign in + hamburger visible at 390. |
| 3g | N3 select overflow 320-390 | PASS | See 1a. |
| 3h | Open redirect | PASS | 30 values after sign-in (`https://evil.com`, `//evil.com`, `%2F%2Fevil.com`, `/%5Cevil.com`, `/\evil.com`, tab/newline/CR encoded, leading space, `javascript:`, `data:`, `/.//evil.com`, `////evil.com`, `/auth?redirect=...`) and 6 values for an already signed-in visit: always same-origin, never navigates away (verified with request interception). Safe paths with query still honoured. |
| 3i | Password recovery (N1, M7) | PASS (Low issue L6) | Forgot-password mode sends; recovery link (fresh page load with `#...type=recovery`) shows "Choose a new password" and survives reload; 3-char password refused, valid one saves and goes to /dashboard; flag cleared; Cancel signs out. |
| 4a | Typed answers signed out | PASS | "Sign in to check your answers" with `/auth?redirect=...`, 0 AI calls, text kept. |
| 4b | Typed answers signed in, AI up / down | PASS | wrong -> "not yet" hint, partial -> "half right", correct; exact answer needs no AI; AI down: exact/local match accepted ("checked locally"), miss shows "checker unavailable" and consumes no attempt; shared answer cache serves a second student with 0 AI calls; "This feedback is wrong" posts `report_cached_check_v2` with the user id. |
| 4c | French/Spanish/Mandarin ab initio offline matching | PASS | For all 1,458 stored answers: self, lower-case, accent-stripped all accepted; hanzi-only and pinyin-only accepted for "hanzi (pinyin)" answers; 0 false positives against 1,457 other answers. Browser run: "zǎoshang hǎo" for "早上好 (zǎoshang hǎo)", "我很好，谢谢。" for "我很好，谢谢。(wǒ hěn hǎo, xièxie.)", "Bien, ¿y tu?" accepted. |
| 4d | Options shown/hidden on 30 random real stems | PASS | 8 shown, 22 hidden; every shown one is a genuine "Which sentence/improvement/pairing ..." pick, no recall stem listed. Longest MCQ stem 392, answer 243, explanation 311 chars: all within the server caps (4000/500/2000). |
| 5 | `npm run build` | PASS (exit 0) | |
| 5 | `npx tsc --noEmit` | PASS (exit 0) | |
| 5 | `npm run lint` | PASS (exit 0, 3 react-refresh warnings: PaperRunner.tsx:48,63, use-auth.tsx:101). See L7. |
| 5 | `scripts/test-*.mts` | PASS | ai-server all passed; safe-redirect all passed; task-markup 89 assertions; typed-answer all 77 (stems 12,186, options shown 3,789). |
| 5 | `validate-widget-papers.mjs` / `check-paper-sizes.mjs` / `json-to-sql.mjs content/biology-myp4` | PASS | 11 papers valid; 971 tasks, longest 5,595/10,000, scheme 3,680/8,000; json-to-sql exit 0. Also: all 971 stored tasks parse with the real `parseTaskBody` (0 errors, 127 widgets, no stray braces). |
| 6 | Routes and links | PASS | /, /subjects, /eassessment (+6 areas), /past-papers, /daily, /my-files, /dashboard, /auth, subject pages (incl. interdisciplinary-learning), 404s for bogus subject/area/path; 161 distinct internal links all 200; no horizontal overflow at 1280 or 390; all 5 tabs of all 6 areas at 390 and 1280 render, no overflow. Interdisciplinary Learning: Mixed/Build/Timed/Stored all mark at both widths. Only console noise: expected 404s and L4. |
| extra | Keyboard and mouse on widgets after the TaskBody rewrite | PASS | Enter/Space place, Delete removes, drag with mouse, plot arrows+Enter+Backspace, all work. |
| extra | Double-click Submit / submit near expiry | PASS | 1 AI call in both cases. |
| extra | AI task output hardening | PASS | XSS markup, bad sums, bad markup, empty, missing, 429, 500 all fall back to saved tasks with the notice, no script executed. |

## 2. New bugs

### HIGH

None found.

### MEDIUM

**M1. A saved exam is not tied to the user: the next student on the same browser tab can open and submit the previous student's answers**
- Repro: signed in as student A, Mixed test (or any timed paper), type "STUDENT A PRIVATE ANSWER" in question 1, press Sign out (header), go to /auth and sign in as student B, open /eassessment/mathematics. A "Resume exam" banner for A's exam appears; clicking it shows A's typed answer, widgets and remaining clock. Submitting marks them and records attempts on B's account.
- Expected: sign-out (or a different user id) clears `myp-exam:*` sessionStorage (or the key includes the user id).
- Actual: `sessionStorage` key is `myp-exam:<subjectId>:<kind>` only; nothing clears it on SIGNED_OUT. Matters for shared school computers.
- Suspected: `src/components/study/PaperRunner.tsx:25-70` (loadExamSession/clearExamSession, `persistKey`) and `src/hooks/use-auth.tsx` (no cleanup on SIGNED_OUT); `$area.tsx:84-97` resume effect.

### LOW

**L1. When the daily AI allowance (or the global cap) is used up, the student can still start and sit a whole exam that can only fail at the end**
- Repro: set the per-user cap so `ai_usage_take` returns `user_cap` (or `global_cap`), open Mixed test > Short. Notice reads "New-question writing is unavailable, so this uses saved tasks." (misleading: it is the allowance, and signed-in). The student answers everything, presses Submit and only then gets "You have used today's AI allowance ... It resets tomorrow." Session expires after 12 h, the clock keeps running.
- Expected: say "today's allowance is used up" before starting (or at least in the banner), and do not offer a timed sitting that cannot be marked.
- Suspected: `ai-core.server.ts` charge() returns the quota text only in `error`; `$area.tsx` `buildAiTasks` (~line 556) throws that away and `fallbackNotice` (~line 284) shows the generic text.

**L2. Typed-answer quota/burst errors are shown as "The answer checker is unavailable right now ... try again in a moment"**
- Repro: make `ai_usage_take` return `user_cap` (or hit 40 checks/min), type a non-exact answer in any sub-topic Questions tab.
- Expected: "You have used today's AI allowance" (server text exists). Actual: generic checker-down panel; "Try again in a moment" will not help until tomorrow.
- Suspected: `QuestionRunner.tsx` handleCheck `catch { ... }` ignores `res.error` / `errorCode`.

**L3. Awkward notice grammar: "New-question writing is unavailable" / "New-paper writing is unavailable"**
- `$area.tsx` `fallbackNotice` builds `New-${what} writing`. Suggest "Writing new questions is unavailable, so this uses saved tasks."

**L4. React dev warning on direct load of /dashboard (still present, unchanged since round 3 L8)**
- Repro: sign in, `page.goto('/dashboard')` repeatedly; about 1 load in 3 logs "Can't perform a React state update on a component that hasn't mounted yet" (dev build only; not on SPA navigation). Source not isolated (AuthProvider effect order is now clean, so another component on the dashboard).

**L5. Session-conflict panel: "Keep the earlier exam" does not open the earlier exam, and the deep link keeps re-triggering the panel**
- Repro: start paper A (Timed paper), then open `/eassessment/<area>?subject=...&tab=Timed+paper&paper=<B>` directly. Panel appears. "Keep the earlier exam" -> shows the paper list (no banner, tab is the same so no Resume offer); the saved exam is still there but the student must find card A. Reload: the panel appears again because `&paper=<B>` is still in the URL.
- Expected: Keep goes back to A (or the URL param is dropped). Suspected: `PaperRunner.tsx` conflict `onClick={onExit}` and `TimedPapers` `onExit={() => setPaperId(null)}` (URL not updated).
- Related: after "Exit" (discard) on a deep-linked paper, reload restarts the exam with a fresh clock (URL param `paper=` still present).

**L6. Expired or invalid password-reset link shows no explanation**
- Repro: open `/auth#error=access_denied&error_code=otp_expired&error_description=Email+link+is+invalid+or+has+expired`. The sign-in form appears with no message. Suspected: `auth.tsx` (does not read the hash error).

**L7. Lint exits 0 partly because whole folders are now ignored**
- `eslint.config.js` ignores `src/integrations/supabase/**` (includes hand-written `auth-attacher.ts`, `auth-middleware.ts`, `cron-auth.ts`, `previewAuthStorage.ts`) and `src/components/ui/**`; `.prettierignore` also ignores `content/`. Auth code is no longer linted. Also `previewAuthStorage.ts` (Lovable-managed) was reformatted before being ignored, which will conflict if Lovable regenerates it. Not a runtime bug.

**L8. Resume banner and clock for an already expired exam**
- A saved exam whose `endAt` has passed still shows "The clock is still running" on the Readiness tab; clicking Resume then auto-submits at once. Cosmetic. (`$area.tsx` resume banner text.)

**L9. Short/Half-length labels vs actual sitting time**
- "Half paper · 60 min" can give 65:00 (54 marks x 1.2) and a stored-paper fallback "Full length" on Sciences gives 127:00. Honest per-mark timing, but the label promises 60/105 minutes. (Carry-over of round 3 N8, now smaller.)

**L10. Offline checker does not accept tone-number pinyin ("ni3 hao3" for "你好 (nǐ hǎo)")**
- Toneless ("ni hao") and accented are accepted, numeric tones are not. Only matters when the AI checker is down (a miss is not counted).

**L11. Quota design note: typed-answer checks and marking share one 400-unit daily budget**
- A student who grinds typed practice (1 unit per non-exact attempt, no cache hit) can use up the allowance that also pays for marking (5) and writing exams (20). Consider separate budgets or a higher default for checks. Not a defect against the spec.

## 3. Harness notes (not bugs)

- On a freshly started vite dev server the first sign-in submits before hydration (`/auth?` GET reload). No credentials leak (inputs have no `name`), so it is only a cold-compile artefact; I waited for hydration in later runs.
- `bun`-style sign-out is hidden behind the hamburger at 390px, so my "Sign out visible" wait printed SIGNIN FAILED in 390px runs although sign-in worked.
