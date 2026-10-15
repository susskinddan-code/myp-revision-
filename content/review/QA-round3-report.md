# QA round 3 report: MYP Revision (working tree at /home/claude/myp-revision-, uncommitted changes included)

Tested 2026-10-15 in Playwright/Chromium against vite dev on :8090, fake PostgREST+auth (:9100), fake Anthropic with failure modes (:9099). No file under src/, content/, scripts/ or drizzle/ was edited. Harness, scripts and screenshots: `/tmp/claude-0/-home-claude-myp-revision-/7bf37415-14ac-5462-9687-9bde57546ce6/scratchpad/qa3/` (called `qa3/` below). The fake DB held 17 subjects, all 138 stored papers (all papers-myp5 array and object files, all 11 papers-widgets, plus 3 edge papers) and 4 sub-topics of content per subject. Servers were stopped afterwards.

Not tested: the real Anthropic/Supabase services, real JWT verification, service-role cache/bank writes, Safari/Firefox, screen readers, a real touch device, and subjects at grades 1-4.

## 1. Re-verification of round-2 bugs (BUGS.md)

| Id | Status | Evidence |
|---|---|---|
| H1 long task marking | **FIXED** | Fake paper with a 2,468-char task: marked (6/12), 1 AI call. All 23 stored papers that exceed the old caps (IDL tasks up to 5,595 chars, English L&L 4,533, mark schemes up to 3,680) were opened by deep link, answered and marked: 23 of 23 returned a score (`qa3/longall.out`). `scripts/check-paper-sizes.mjs`: 971 tasks, longest task 5,595/10,000, scheme 3,680/8,000. |
| H2 mobile header | **FIXED** | 390px: logo + "Sign in" + hamburger visible when signed out (Sign in at x=273..334). Signed in: hamburger opens a list with Papers, Daily, eAssessment, Subjects, My files, My progress, Sign out (`qa3/hdr_True_open.png`). No document overflow at 320, 360, 600, 768, 1023, 1024, 1100, 1280. See N7 for a small a11y gap. |
| M1 fallback notice | **FIXED** | Mixed test with AI tasks = 500, 429, bad JSON, no tool, empty, bad markup, bad mark sums, max_tokens: banner "New-question writing is unavailable, so this mix uses saved tasks." appears every time (role=status). Same for Build my exam and Timed "Write me a new paper" (fallback banner). |
| M2 exam length vs timer | **FIXED** (residual Low N8) | Mock returns 10 tasks: Short shows 5 tasks/30 marks/30:00, Half 9 tasks/54 marks/60:00, Full 15 tasks/90 marks/104:59. Server now trims and the client uses the returned minutes. Residual: Short is 30 marks in 30 min (1.0 min/mark, not the 1.2 used elsewhere). |
| M3 AI outage in typed practice | **FIXED** | AI 500/429/401/bad JSON, correct paraphrase typed: no "wrong" entry, no attempt consumed, text kept, status box "The answer checker is unavailable right now", Show answer offered; exact answer still accepted locally. |
| M4 option-list regex | **PARTLY** | Old false positives ("natural selection", "chooses") are gone and "Which of these..." now shows options (replaced by `stemNeedsOptions`, typed-answer.ts:159). Still missed: stems that need candidates but use other nouns, e.g. "Which goal is the most SMART...?", "Which refinement is likely to help?", "In an investigation ... which control is most important?", "Which algorithm correctly finds...", "Which scenario is the clearest example of the tragedy of the commons?". My count over content/: 422 questions contain "which", have no visual, a long (>45 char) stored answer, and show no options (`qa3/m4b.mts`). Over-triggering remains for 80 stems with no "which/choose/select" word (e.g. "What is the best explanation?" is intended; "Why is static stretching ... not the best choice?" is a false positive). |
| M5 exam lost on refresh/tab/Back | **FIXED** (new bug N2, Low N11) | Exam state is saved to sessionStorage with a wall-clock end. Reload, then clicking the tab again: answers and clock restored. Header-link navigation and Exit show a confirm; reload/Back fire beforeunload. Switching tabs inside the page and returning restores. Exit+reload does not resurrect the exam. But widgets restore blank, see N2. |
| M6 keyboard access to widgets | **FIXED** | Chip focus + Enter selects (aria-pressed), drop cells are role=button/tabindex=0: Enter and Space place, Delete removes; plot grid is focusable (role=application): arrows move a cursor, Enter plots, Backspace undoes; answers reached the marker as `[b1] ...; [c1] plotted (...)`. |
| M7 phone sticky stack | **FIXED** | Pinned stack at 390x844 is header 57px + timer bar 44px (~12%), question navigator collapsed by default on phones. Task header row: label 300px wide, buttons inside the card (right edge 314 < card 366). `qa3/m7_q2.png`. |
| M8 long answers | **FIXED** | Textarea has maxLength=6000 and a "n words · x / 6000 characters" counter; filling 50,000 chars keeps 6,000; a paper with every answer at 6,000 chars marked normally. Server truncates instead of rejecting. |
| L1 chart edge cases | **FIXED** | Negative bars/lines draw below a zero line, values of 0.0001-0.0002 get a 0.0002 axis, 1.4e9 shows "1.5B/1B/500M", long labels truncate with ellipsis, no console errors (`qa3/edge3_1280_q1..q3.png`). |
| L2 pie legend | **FIXED** | 20-slice pie lists all 20 legend rows (HTML list, not SVG) and a one-slice pie draws a full disc. Cosmetic: see N10. |
| L3 signed-out typed practice | **FIXED** | First Check shows "Sign in to check your answers" with a link `/auth?redirect=<this page>`; no AI call; typed text stays; after sign-in you return to the page. |
| L4 timer expiry / resubmit | **FIXED** (new bug N4) | Clock is wall-clock based; at 0:00 exactly one auto-submit; if marking fails inputs are locked and button reads "Time is up: try marking again" (500 case: textarea disabled, retry available). Restored session with endAt in the future keeps the right remaining time. |
| L5 unmarked questions | **FIXED** | Marker returns 1 of 4 questions: result 3/7, three pills "Not marked", note "3 questions were not marked and are left out of this total", no attempts recorded for them. |
| L6 blank paper | **FIXED** | Blank paper scores 0/28 locally, 0 AI calls, both scales shown; whitespace-only answers count as unanswered. |
| L7 forgot password / redirect | **FIXED, but introduced N1 (High)** | "Forgot password?" mode exists (calls `/auth/v1/recover`; the fake DB 404s, so only the UI was checked); header Sign in and the typed-practice link return you to the page you came from. The redirect value is not validated in practice, see N1. |
| L8 hydration / not-mounted warning | **STILL PRESENT** (Low, dev only) | Direct load of `/dashboard` signed in logged "Can't perform a React state update on a component that hasn't mounted yet" in 2 of 4 loads at 1280 (not on SPA navigation, not at 390 this time). Likely `AuthProvider` (hooks/use-auth.tsx:17-26) setting state from `onAuthStateChange` before mount. |
| L9 fill/dup ids | **FIXED** (unit level) | `encodeFillAnswer` JSON-quotes cells with `| / ; " \` and uses "-" for empty; whitespace-only cells count as empty; duplicate widget ids are renamed (`id-2`), observed: two selects with the same id are independent. Covered by `test-task-markup.mts` (69 assertions). Pipe-in-cell was not typed into a browser (my test markup was malformed). |
| L10 tooling | **FIXED** for tests, **STILL BROKEN** for lint | `test-ai-server.mts` now "all passed" (concurrency 2, 4 batches 2 at a time, bank top-up). `npm run lint` still exits 1: 548 prettier errors (356 in generated `integrations/supabase/types.ts`, 41 auth-middleware, 28 generate-content.mjs, 22 previewAuthStorage, 19 validate-widget-papers.mjs, ...), 9 react-refresh warnings (2 in PaperRunner.tsx:45,60), 1 prefer-const (previewAuthStorage.ts:38). |

## 2. Regression run

| Command | Result |
|---|---|
| `npm run build` | exit 0 (warnings only: `createServerFn().inputValidator() is deprecated` x5 in ai.functions.ts, rolldown "inlineDynamicImports ignored") |
| `npx tsc --noEmit` | exit 0, no errors |
| `npx tsx scripts/test-task-markup.mts` | 69 assertions passed |
| `npx tsx scripts/test-typed-answer.mts` | all 35 passed (also prints "content MCQ stems: 12186, options shown 2810, hidden 9376") |
| `npx tsx scripts/test-ai-server.mts` | all passed |
| `node scripts/validate-widget-papers.mjs` | all 11 papers valid |
| `node scripts/check-paper-sizes.mjs` | 971 tasks, 0 over cap |
| `npm run lint` | exit 1 (see L10) |

## 3. New bugs and exploratory findings

### HIGH

**N1. Open redirect after sign-in: `/auth?redirect=https://evil.com` sends a signed-in user to evil.com**
- Repro: open `http://<site>/auth?redirect=https://evil.com`, sign in with email/password. The browser ends on `https://evil.com/` (observed; the sandbox proxy even resolved it). Also: the Google button builds `redirect_to=<origin>https://evil.com`; `redirect=//evil.com` navigates to `/evil.com`; `redirect=javascript:alert(1)` leaves a signed-in user stuck on `/auth` (script did not run).
- Expected: anything that is not a same-site path is ignored and the user lands on /dashboard (that is what `safeRedirect` is meant to do).
- Actual: `safeRedirect` works, but `validateSearch` returns `{}` for a rejected value, so TanStack merges the parent route's raw search into the match and `Route.useSearch().redirect` still holds the attacker's string (verified: `router.state.matches[1].search == {redirect:"https://evil.com"}` while `validateSearch({redirect:'https://evil.com'})` returns `{}`). `target = redirect ?? "/dashboard"` then uses it.
- Suspected: `src/routes/auth.tsx:28-31` (validateSearch) and `:45-46` (target). Fix: return `{ redirect: undefined }`/always include the key, and run `safeRedirect(target)` again where `target` is used (navigate, signUp emailRedirectTo, OAuth redirectTo).
- Phishing risk: a link on a trusted domain that sends the user to a lookalike page right after sign-in.

### MEDIUM

**N2. A restored exam shows empty drag/plot/fill widgets but still submits their old answers**
- Repro: open a stored widget paper (e.g. "Standard Mathematics MYP 5 eAssessment Interactive Demo"), choose the select, place both drag chips, plot 2 points, fill the table, wait 1 s, reload the page, return to Timed paper. Label still says "2/2 answered"; the select shows the chosen value, but drag cells read "Drop here", the plot has 0 points and the fill inputs are empty (`qa3/restore_widgets.png`). Pressing Submit sends `[b1] Fewest books = Wednesday; Most books = Tuesday` and `[c1] plotted (3, 5), (4, 6), not joined` that the student can no longer see.
- Expected: widgets re-hydrate from `values`, or the saved values are dropped.
- Suspected: `DragTable`, `PlotGrid`, `FillTable` in `src/components/study/TaskBody.tsx` initialise local `useState` ({} / [] / blank rows) and ignore the `value` prop passed from `WidgetView` (TaskBody.tsx ~line 41, 100, 255, 478).

**N3. Phone: long drop-down options make the whole page scroll sideways (Integrated Science and Environmental Systems interactive papers)**
- Repro: 390px, `/eassessment/sciences?subject=integrated-science&tab=Timed+paper`, open "Interactive Practice 1". Document scrollWidth exceeds the viewport by 58px (22px for Environmental Systems) before anything is chosen; the first `<select>` is 395px wide because its longest option is "break the forces holding the particles in fixed positions". The header is cut off and the page can be dragged sideways (`qa3/select_overflow_390.png`).
- Expected: select shrinks to the card (max-width 100%).
- Suspected: `src/components/study/TaskBody.tsx:61-69` select has `inline-block` with no `max-w-full`/`min-w-0`.

**N4. Restoring an already-expired stored paper silently skips the auto-submit; the retry button then needs two clicks**
- Repro: start a stored timed paper, type an answer, set the saved session's `endAt` to the past (or leave a real exam open past time and reload), reload. Clock shows 0:00, 0 AI calls, no message, inputs locked, button "Time is up: try marking again". First click does nothing visible (calls=0); second click marks.
- Cause: the one-shot auto-submit effect fires while `questions` is still loading, `handleSubmit` returns early on `!questions?.length`, and `autoSubmitted` is already true. The first click only flips `confirmBlank` (an "unanswered?" confirmation the label never shows because `timeUp` wins in the label ternary).
- Suspected: `src/components/study/PaperRunner.tsx` auto-submit effect (~lines 134-141), `handleSubmit` guard, and the button onClick/label (~lines 590-606). Fix: wait for questions before setting `autoSubmitted`; skip the confirm when `timeUp`.
- Same two-click effect after a failed auto-submit with unanswered questions (observed with marks=500).

### LOW

- **N5. Signed-out users can sit a whole exam and only learn at the end that it cannot be marked.** Mixed test works signed out with notice "New-question writing is unavailable" (really: not signed in); Submit gives "Please sign in again, then submit. Your answers are still here." with no link and "again" is wrong. Suggest a sign-in gate or a link before starting (PaperRunner `describeError`, `$area.tsx` notices).
- **N6. Per-user rate limits (marking 8 and generation 8 per 10 min) are charged on failed calls too.** After outages or "Try again" re-sits a student can hit "You are doing that too quickly" (observed). A generation rate-limit is shown as the generic "unavailable, saved tasks" banner. `ai-core.server.ts:452, 750`.
- **N7. Phone menu does not close on Escape or outside click** (aria-expanded stays true; `SiteHeader.tsx`).
- **N8. Short (30 min) mix can contain 30 marks**: 1.0 min per mark vs the 1.2 used for Half/Full (server rounds the task count up past targetMarks 25).
- **N9. Offline checker is strict for language answers**: with the AI checker down "十二" does not match the stored "十二 (shí'èr)" and "où est la gare" does not match "Où est la gare ?" (`localCheck` does not drop a parenthetical gloss or French space-before-punctuation). 167 of 486 Mandarin ab initio answers contain hanzi; the typed UI gives no input help. Impact is limited now that a miss is "checker unavailable", not a wrong attempt.
- **N10. Pie slice colours repeat nearly identically** (slice A and C both green: `--primary` and `--success`), `TaskBody.tsx` CHART_COLORS.
- **N11. A reload of an in-progress Mixed test lands on the Readiness tab** (tab is not in the URL) and there is no "Resume exam" banner; the exam only comes back if the student clicks the same tab again. Timed paper restores automatically only when the URL still contains `tab=Timed+paper`.
- **N12. (code-read, not run)** Opening a different stored paper in the same subject while another saved session exists overwrites the saved sitting (same persist key `<subjectId>:timed`).
- **N13. Menu text contrast on the phone menu is low** (muted grey on cream; `qa3/hdr_True_open.png`).

## 4. Areas exercised with no defect found

- All 6 eAssessment areas (Language & Literature, Individuals & Societies, Sciences, Mathematics, Language Acquisition, Interdisciplinary Learning) at 1280 and 390: Mixed test (Short), Build my exam (60 min), Timed paper "write me a new one" (full length) and the first stored paper, each answered with every widget type (select, drag, plot, fill, text), submitted, marked, showing Level 1-8 and Grade 1-7, interactive answers present in the marker prompt, no console errors, no horizontal overflow (`qa3/sweep1280b.out`, `sweep1280.out`, `sweep390.out`). IDL (`/eassessment/interdisciplinary`): all five tabs, 8 stored papers, Mixed/Build/Timed all work.
- All 11 stored widget papers plus the demo paper (`content/papers-widgets`) at 1280 and 390: no raw `{{` markup, every widget usable, answers reach the marker (`qa3/wp.py`), apart from N3.
- Routes `/`, `/subjects`, `/subjects/{physics,standard-mathematics,interdisciplinary-learning,history,french-ab-initio}` (5 tabs, MYP 1-5 pills), `/eassessment` + 6 areas, `/past-papers`, `/daily`, `/my-files`, `/auth`, `/dashboard`, 404s for bogus subject/area/case: no overflow at 1280/390, ~89 internal links all resolve 200 with the right h1; past-paper deep links open the right paper; unknown `?paper=`, `?subject=`, `?tab=`, `?grade=` fall back gracefully.
- Flashcards tab and per-topic Flashcards (9 cards, flip, Next wraps to card 1, no face overflow at 390 even with the longest 196-char back).
- Typed practice signed in: empty/whitespace disabled, maxLength 400, XSS inert, hints, half-right, Show answer after 2 tries, 5 tries reveal, 16/18 scoring, double-submit sends one request, report button; attempts recorded.
- Sign-in/out (bad password toast, sign out clears session), `/my-files` (PDF opens in a blob iframe, a .txt file is not accepted, a `javascript:` link is not added, a 3,000-char URL causes no overflow, links open with `target=_blank rel=noreferrer`).
