# QA report: MYP Revision app (tester pass, 2026-10-13)

Environment: vite dev on 8082, fake PostgREST (extended copy with all subject slugs and the six widget papers loaded), fake Anthropic mock. No source or content changed. Throwaway scripts are in the scratchpad `qa/` folder.

Not tested: the real Anthropic API, a real service-role key (answer_cache and generated_tasks writes, bank-first serving, seenIds filtering are code-read only), real Supabase auth (signed-in flows, recordAttempt, streaks), the production build at runtime (only `vite build` ran), touch devices, and screen readers.

## Critical / Major

1. **Timer expiry with a marking error causes an endless retry loop (major).**
   - Repro: start any timed paper or Mixed test, stop the AI service (or have it return 429/500), let the clock reach 0:00.
   - `PaperRunner.tsx` effect (lines 54-62): at `secondsLeft <= 0` it calls `submitRef.current()`. When marking fails, `marking` goes back to false and the effect runs again. I measured 59 `gradePaper` calls in about 3 seconds, and it never stops.
   - Fix idea: an `autoSubmitted` ref/flag.

2. **"Try again" after a timed-out paper instantly auto-submits a blank paper (major).**
   - Repro: let the timer reach 0 with the AI up, so it auto-marks. Click "Try again". Marks reappear immediately (2nd call).
   - Cause: `secondsLeft` stays 0 and the effect fires again. The timer is never reset on Try again even when not expired. A timed-out exam can't be retried.

3. **"Try again" leaves the widget UI out of sync with the cleared answers (major).**
   - Repro: Mixed test, fill a table cell, plot points, then Submit and click "Try again".
   - `setWidgetVals({})` clears the parent state, but `PlotGrid`, `FillTable` and `DragTable` keep local `useState`. I saw the fill cell still showing "5" and 6 plotted circles still drawn, while the counter read "0 of 3 answered". Resubmitting sends no interactive answers. Flagged-for-review and rough-working state are also not reset.
   - Fix: change the key on TaskBody (a run counter), or lift the state up.

4. **Header nav doesn't collapse at 390px, so every page scrolls horizontally (major, mobile).**
   - `SiteHeader.tsx`: the `nav` is `flex` with 5 links plus Sign in, with no wrap and no menu. `scrollWidth - clientWidth = 216px` on every route at 390px.
   - The Sign-in button sits at x about 606, off-screen. Page content itself fits; only the header overflows.

5. **`exactMatch` marks wrong answers correct without calling the AI (major, correctness).** Tested in `src/lib/typed-answer.ts`:
   - Units are ignored: "5 cm" = "5 m", "5 mm" = "5 km", "3 kg" = "3 g", "2 J" = "2 W", "1 mol" = "1 L". Cause: `asNumber` strips trailing letters.
   - Trailing letters are stripped from algebra answers: "2x" is accepted for "2".
   - The unit-token strip deletes a lone `n`: "+1" = "n+1" (and vice versa).
   - A 0.5% tolerance accepts "3.14" for "3.15", "1000" for "1004" and "100.4" for "100".
   - Fallback `localCheck` accepts negations because of `a.includes(b)` for 5+ character answers: "not photosynthesis" is correct for "photosynthesis".

6. **Unauthenticated, unthrottled server functions (major, cost and abuse).**
   - `checkTypedAnswer`, `generateExamTasks` (up to 12 tasks, 7000 tokens per batch), `gradePaper`, `reportCachedCheck` and `reportGeneratedTask` have no auth or rate limit.
   - Anyone can delete any `answer_cache` row.
   - A single anonymous `reportGeneratedTask` call with a known id sets `reports=1` and removes the task from the shared bank for everyone (the bank filters on `reports = 0`).

7. **Stale answer_cache after content fixes (major, process).**
   - The cache is keyed only on question_id and answer text. `content/review/*.sql` edit question text and explanations in place, so cached verdicts and feedback survive.
   - Run `delete from answer_cache where question_id in (...)` (or truncate) after those fixes and any content edit.

8. **Task validator accepts malformed markup and silently corrupts widgets (major for AI-generated tasks).**
   - `parseTaskBody().errors` only reports `{{...}}` blocks that fail to parse. It does not catch the following (all verified rendering in the app):
     - **Unclosed `{{select|u|a|b`:** shown as raw text to students ("Bad: {{select|u|a|b" appears in the page).
     - **Stray or nested braces:** same raw-text result.
     - **Duplicate widget ids in one task:** two selects with id `a1` mirror each other, since values are keyed `[position][id]`, and the marker sees one answer. The prompt asks for unique ids but nothing enforces it.
     - **A drag with more slots than items:** can't be completed.
   - Commas or pipes inside items, labels or options (for example `1,000`, `(2, 3)`, `|x|`) are split silently into extra items. A chart value of `B:1,000` becomes label "00" with value 0.
   - Task marks are not cross-checked against the `[[Q n | A x | C y]]` header or the `(n marks)` parts. `scripts/validate-widget-papers.mjs` does check these, so the two validators disagree.

## Minor

9. `BANNED` regex (`ai.functions.ts`) false-positives: "out of 7" and "1-7" or "1 to 7" reject legitimate tasks ("3 out of 7 days", "days 1-7"). The same pattern is in `papers-to-sql.mjs` and the widget validator. `\bSL\b`/`\bHL\b` are fine.
10. Chart bugs in `TaskBody.tsx`:
    - Negative bar values produce `<rect height="-89">`. Console errors, bars are invisible, and the axis has no negative range.
    - An all-zero pie is blank, and a pie with negative values is garbage.
    - Pie legends overflow the 320px viewBox for long labels (such as "Baking soda solution: 9") and for more than about 8 slices.
    - Long x labels overlap, and large y values (1e9) are clipped.
    - The line chart spaces x categories evenly even when the x values aren't evenly spaced.
    - Tiny values (0.0001) give invisible bars.
11. Plot widget: non-integer bounds (`0,2.5,0,5`) are accepted, but the grid and click rounding use integers only. Grid is mouse-only with no keyboard path. Points that duplicate an existing one are silently ignored.
12. Drag widget: placing an item removes it from any other slot, so an item can be used once only and "many-to-one" classification (two rows both "Renewable") can't be answered. Duplicate items or slot names produce duplicate React keys. HTML5 drag doesn't work on touch, but click-to-place does.
13. Typed answers: no `maxLength`. Over 1000 characters fails the zod check and silently drops to the local check with generic feedback. A long unbroken string widens the page by thousands of pixels (9800px measured; the history item has no `break-words`).
14. "Show answer" is clickable while a check is in flight (`QuestionRunner.tsx`). A late "correct" then runs `resolve` twice (duplicate in `missed`, double `recordAttempt`).
15. The fallback hint on attempt 2 prints the first sentence of the explanation, which can give the answer away (seen: "Electrons carry a charge of −1...").
16. Submitting with nothing answered sends a full AI marking call with no confirmation. `gradePaper` doesn't verify that every position came back, or that `max_marks` equals the mark-scheme sum. A dropped question inflates the percentage. The UI "N marks" label (from the scheme) can disagree with the AI's "x / max".
17. "Reported, thanks" shows even for ids that can't be reported (`gen-new-...` when the bank isn't configured).
18. `/dashboard` while signed out redirects to /auth correctly but logs a hydration-mismatch error (ssr:false route, dev mode). The redirect doesn't carry a return URL.
19. `answerKey` truncates at 200 characters, so long answers sharing a 200-character prefix collide in the cache. A Unicode minus "−5" doesn't match "-5" in `exactMatch` (it falls through to the AI, so low impact).
20. `$area.tsx`: the `tab` and `subject` state isn't synced to the URL, and the "What this exam looks like" shortcut buttons change the tab without scrolling or updating the URL.
21. Tasks written by the AI go straight into the shared bank, with no correctness check on mark schemes before other students get them.
22. `estimateOverallGrade` returns 1 for 0 points (the IB has no grade 0, so this is probably fine).
23. Content nit: Standard Maths paper 62, Q2(d), says "say which year" but no year is given. The answer is "March of the following year".

## Content and scripts review

- `node scripts/validate-widget-papers.mjs`: all 6 papers valid.
- `papers-to-sql.mjs` on `content/papers-myp5`: output is byte-identical to the HEAD version (1,842,392 bytes). The `widget-practice` change does not break existing papers.
- `papers-to-sql.mjs` on `content/papers-widgets` matches `out.sql`. SQL read by eye: dollar-quoting, begin/commit and the idempotent title guard are fine. The final summary SELECT filters on `eAssessment-style`/`Full eAssessment Mock` titles, so it won't list the new papers (cosmetic). `papers-to-sql.mjs` doesn't check widget markup in widget-practice mode; only the separate validator does.
- I re-worked all maths and science answers in the 6 widget papers by hand (table values, means/medians, trig, cosine rule, areas, energy, Ohm, moles, SA:V, Punnett, percentages, pie sums). All correct, and the mark sums, headers and `(n marks)` parts agree.
- All 6 papers plus the old demo render in the app at 1280 and 390px: correct widget counts, no raw `{{`, no console errors, no overflow beyond the header.

## Verified OK

- `npm run build` passes. `npx tsc --noEmit` is clean. ESLint on `src/` (excluding integrations and ui) has 0 errors and 1 react-refresh warning (`use-auth.tsx`).
- All routes return 200 or a proper 404: `/`, `/subjects`, `/subjects/<slug>` (several grades), `/eassessment`, all 6 areas with all 5 tabs (interdisciplinary resolves to `interdisciplinary-learning`), `/past-papers`, `/daily`, `/my-files`, `/auth`. Bogus slugs give a proper 404. No console or page errors apart from the `/dashboard` hydration message. Clickable stat blocks, tabs and links all navigate or toggle. The "dead" clicks were already-selected toggles.
- Typed answers:
  - Wrong answers escalate hints.
  - "close" gives "half right". Correct works. "Show answer" appears only after 2 tries. Auto reveal happens after 5.
  - The reported-wrong button disables itself after use.
  - First-try-only scoring: 16/18 with one reveal and one second-try, and the "Retry the 2 you missed" count was right.
  - Enter submits. Empty and whitespace submissions are blocked.
  - HTML in an answer is escaped (no XSS).
  - With the AI service down, local fallback hints, "Show answer" and reveal all work.
- `answerKey` keeps sign and number differences distinct ("-5" vs "5", "2.5" vs "2,5").
- Exam widgets:
  - Select works.
  - Drag by mouse and click-to-place both work. Moving an item and removing it work.
  - Plot: points register at edges and corners, out-of-grid clicks are ignored, duplicates are ignored, Undo, Clear and Join work.
  - Fill table works. Flag for review and the question-nav counters work, and nav scroll lands below the sticky bars.
  - The report button shows for `gen-` ids.
  - Timer starts at the right value.
  - Results show both scales: "MYP Level 3 of 8" and "Grade 4 of 7" for 50%. The 32-point conversion table matches the IB.
- Server code read: the cache keys on first attempt only; race on upsert is benign (`ignoreDuplicates`). seenIds prefix stripping is consistent. The bank-first split (about 70%) is as intended.
- Not reproduced because it needs a real key: bank and cache behaviour against Supabase.
