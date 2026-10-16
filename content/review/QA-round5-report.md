# QA round 5 report: eAssessment (working tree at /home/claude/myp-revision-)

Tested 2026-10-16 with headless Chromium (Playwright) at 1280 and 390 px against vite dev (:8094), a fake PostgREST + auth (all stored papers incl. 72-79, 17 subjects, bucket-aware `ai_usage_take`) and a fake Anthropic server. No file under src/, content/, scripts/, drizzle/ was edited. Harness: `/tmp/claude-0/-home-claude-myp-revision-/7bf37415-14ac-5462-9687-9bde57546ce6/scratchpad/qa5/`. Servers stopped afterwards.
Not tested: real Anthropic / Supabase, real JWT checks, Safari/Firefox, a physical touch device.

## 1. PASS / FAIL

| # | Area | Result | Evidence |
|---|---|---|---|
| 1 | /eassessment hub + 6 area pages, all 5 tabs, 1280 and 390 | PASS | 6 cards, "2 hours on screen" on all; no horizontal overflow; no console errors. Language acquisition shows 2 HOURS and the corrected looks-like text (up to 2 hours, 1 h 45 to 2 h range, criteria A/B/D + C speaking). Mixed test "Full length · 120 min" in all 6 areas. |
| 1b | Every button/block navigates sensibly | PASS | "What this exam looks like" chips, Readiness buttons, Exam skills "Put it into practice", subject chips (keep tab), topic cards (open the subject Study tab on that topic), hub links to /dashboard and /past-papers. 0 mismatches in 4 areas at 1280; sampled the rest. |
| 2 | Sit all 8 new widget papers (72-79) start to finish, 1280 and 390 | PASS | select, drag by click, by keyboard (focus chip, Enter, focus cell, Enter) and by mouse drag_to, fill, plot (keyboard + click, 3 points), charts. Marker prompt contained every widget id (10/10, 10/10, 10/10, 14/14 x3, 9/9, 11/11) in an "Interactive answers:" block. Result shows "Level 2 of 8" and "Grade 3 of 7". Accents (é è ñ ¿ « ») and hanzi/pinyin render with no mojibake; 0 console errors; 0 px horizontal overflow before/after answering at 390 incl. Mandarin and long French strings. |
| 2b | Content consistency of papers 72-79 | PASS | Parsed every task with the real parser: no markup errors, header marks = scheme sum = "Total for Question", every select answer in the scheme is one of its options. |
| 2c | Chart readability | FAIL (M2) | see M2 |
| 3 | Mixed / Build / Write-new minutes caps, all 6 areas | PASS | AI mode: Short <=30 (29:00), Half <=60 (58:00), Full <=120 (116:00); Build 30/60/90/120 all <= label; Write new <=120. Stored-task fallback (signed out, 1280 and 390): max seen 120:00 on Sciences/Maths, never over. Notes L2/L3. |
| 3b | Quota panel ("Your AI allowance is used up") + "Sit it anyway" + "Try later" | PASS | Mixed, Build and Write-new in all 6 areas at 1280 and in Language acquisition + IDL at 390: panel shows, 0 Anthropic calls, notice banner in the sitting, Submit shows the allowance message and keeps answers; after the allowance is restored, pressing Submit again marks (Level/Grade shown, 1 call). |
| 3c | Expired saved exam | PASS | Banner "Time ran out on ... Mark my answers"; click opens the tab, auto-submits once, answer text reaches the marker, banner and saved session cleared. |
| 3d | Session conflict, "Keep the earlier exam" | PASS | Opens exam A with its answer; `?paper=` dropped from the URL; reload resumes A (round-4 L5 fixed). |
| 3e | Resume banner | PASS | Shown on the Readiness tab, Resume restores the typed answer and running clock (28:57). |
| 3f | Saved exam cleared on sign-out (round-4 M1) | PASS | No `myp-exam:*` keys after Sign out. |
| 4 | Readiness numbers | PASS with M3 | 6/6 correct + 3/6 correct typed answers gave "75% correct from 12 answers", Historical Skills Strong 100% from 6, Industrial Revolution Needs work 50% from 6; subject chip "History 75%". "Spend your next hour on" link goes to the right topic when there is one needs-work topic. Wrong when there are several (M3). |
| 5 | Auth | PASS | `#error=access_denied&error_code=otp_expired...` (also without description, and `error_description=Token+has+expired`) shows "This link is invalid or has expired. Use "Forgot password" to get a new one." (role=alert, no overflow at 1280/390). Open redirect: `https://evil.com`, `//evil.com`, `%2F%2Fevil.com`, `/%5Cevil.com`, `javascript:alert(1)`, `/\evil.com` all end on /dashboard; encoded safe paths are honoured. See L4. |
| 6 | Typed answers, ab initio, tone-number pinyin | PASS | Offline (AI down): "zao3shang hao3" accepted for "早上好 (zǎoshang hǎo)" ("checked locally"). Sweep over all 132 stored Mandarin answers with pinyin: every one accepted when typed as tone-number pinyin (both "u" and "v" for ü), 1 rejection that is an English sentence, 1 benign false positive (digit on the wrong syllable). With the AI up the same text goes to the AI (see L1). |
| 7 | `npm run build` | PASS | exit 0 |
| 7 | `npx tsc --noEmit` | PASS | exit 0 |
| 7 | `npm run lint` | PASS | exit 0, 3 react-refresh warnings (PaperRunner.tsx:48,63, use-auth.tsx:110) |
| 7 | `npx tsx scripts/test-*.mts` | PASS | ai-server all passed; safe-redirect all passed; task-markup 89; typed-answer all 85 |
| 7 | `validate-widget-papers.mjs` | PASS | 19 papers valid |
| 7 | `check-paper-sizes.mjs` | PASS | 1,003 tasks, longest 5,595/10,000, scheme 3,680/8,000 |
| 8 | Migrations 0007, 0008, 0009 | PASS | Executed for real in PGlite (Postgres WASM): 0006 > 0007 > 0008 > 0009 apply with no error, and twice in a row (idempotent). 0009 on top of 0008 data keeps old rows as bucket 'exam'; PK becomes (user_id, day, bucket) / (day, bucket); 4-arg legacy call still works (lands in 'exam'); 'check' and 'exam' caps are independent; user_cap/global_cap/refund behave; grants: anon/authenticated cannot execute or read, service_role can execute; `report_cached_check_v2` counts distinct users, retires the cache row at 3. 0007 with duplicate rows and a bad criterion: dedupes, constraint NOT VALID so old rows survive, new bad row rejected. 0009 run without 0008 fails ("relation public.ai_usage does not exist"), as its header says. See L5. |

## 2. New bugs

### HIGH
None.

### MEDIUM

**M1. Reloading mid-exam in any subject other than the first chip loses sight of the exam (no banner, clock keeps running)**
- Repro: /eassessment/sciences, click chip "Chemistry", tab "Mixed test", "Short", type an answer, press reload (F5). Page returns to Readiness + Physics (subject and tab live only in React state; the URL stays /eassessment/sciences). No "Resume exam" banner (banner only looks at the current subject's keys). The Chemistry exam is still in sessionStorage (`myp-exam:<chemId>:mixed`) with its clock running and nothing points to it. Same for expired sittings (never offered for marking) and for every multi-subject area (L&L, I&S, Sciences, Maths, Language acquisition).
- Expected: subject (and tab) in the URL (`?subject=` is already read on load), or the resume banner scanning all subjects in the area.
- Suspected: `src/routes/eassessment/$area.tsx` `AreaPage` (`setSlug` at the chip onClick never updates the search params; resume effect ~lines 84-97 only checks `subjectIdForResume`).

**M2. Bar charts truncate category names to 12 characters and have no value labels, so some chart questions cannot be answered on a touch screen (or without hovering)**
- Repro: paper "French ab initio MYP 5 Interactive Practice 1", Task 2. The first bar is shown as "les jeux vi…" (the full name is only in a hover tooltip `<title>` and in the aria-label). Part (a) asks the student to write the hobby in a table column; "les jeux vidéo" appears nowhere else in the task text or in the options of (b)/(c). Same chart style: Spanish ab initio ("los videojue…", though the full name is an option in (c)), French L&L Task 3 ("Utiliser le…", "Emprunter de…"). Bars carry no value labels and the gridlines are every 5 (French) or 2.5 (Mandarin), so reading 11 vs 10, 9 vs 8, 6 vs 7 off the bars is guesswork, while (a) and (c) are marked on the exact number.
- Expected: full labels (wrap or rotate; truncation only when it cannot hurt) and a value label or data table on bar charts that questions read exact values from.
- Suspected: `src/components/study/TaskBody.tsx` `Chart` (~line 586, `truncateLabel(d.label)` with max 12 in `src/lib/task-markup.ts:308`), no value text on bars. Content workaround: list the categories/values in the task text.

**M3. "Spend your next hour on ..." and the "weakest first" order ignore the actual percentage**
- Repro: signed in, History: 2/5 correct in "Analysing Sources" (Historical Skills) and 0/5 in "Causes and Key Inventions" (The Industrial Revolution). Readiness shows "Spend your next hour on Historical Skills" (40%) and lists Historical Skills before The Industrial Revolution (0%).
- Expected: the lowest percentage (0%) first and as the recommendation.
- Actual: rows are sorted only by status bucket (`needs-work` < `new` < ...); ties keep DB order, and `weakest = rows.find(status === "needs-work")` is the first of that bucket.
- Suspected: `src/routes/eassessment/$area.tsx` Readiness (~line 405-415: `rows.sort((a, b) => order[a.m.status] - order[b.m.status])`). Add `|| a.m.pct - b.m.pct` as a tie-break.
- Related: the "% correct from N answers" headline also counts practice-paper attempts (stored with `topic_id = null`), but "N of M topics started" and the per-topic bars do not, so a student who only sat papers sees "40% correct from 4 answers (Needs work). 0 of 13 topics started".

### LOW

**L1. Language-acquisition tone-number pinyin works offline but the AI check prompt never mentions it.** `ai-core.server.ts` has no mention of pinyin, tone marks or tone numbers; "zao3shang hao3" with the AI up went to the AI (mock said wrong) and nothing in the prompt tells the real model to accept it (the offline path does). Mismatch between online and offline behaviour. Also neutral tone "0" ("xie4xie0") is not recognised (`[1-5]` only in `typed-answer.ts` toneNumbersOff).

**L2. Stored-task fallback often gives well under the length asked.** Signed out, Mixed "Short · 30 min" gave 20:00 (History, French ab initio) and 21:00 (Physics); Build "90 min" on Standard Maths gave 60:00. Within the cap (so the earlier cap bug is fixed) but the button label overpromises. `fitToMinutes`/`assembleWrittenExam` in `$area.tsx`. Also `fitToMinutes` always keeps at least one task, so a single task longer than the cap could still overrun.

**L3. Stored "Full eAssessment Mock"/Paper A-C papers carry 101-116 marks but are sat in a flat 120 minutes (1.03-1.19 min per mark)** whereas generated exams use 1.2 min per mark. Not wrong against the real exam length, but inconsistent with the tip "about 1 to 1.25 minutes per mark" and with the 1.2 rule used elsewhere. `suggested()` in `$area.tsx` TimedPapers.

**L4. Auth error text and hash.** Any `#error=...` (including `server_error&error_description=boom`) shows "This link is invalid or has expired", and the `#error=...` hash stays in the address bar. Also an unencoded `?redirect=/eassessment/sciences?tab=Mixed+test` (the `+` becomes a space) falls back to /dashboard; links generated by the app are encoded so this only affects hand-typed links.

**L5. Migration notes.** (a) Re-running 0008 after 0009 re-creates the 4-argument `ai_usage_take`/`ai_usage_refund` next to the 5-argument ones (works, exact-arity match wins, but leaves two overloads); keep the run order note in `content/review/RUN-THESE-IN-ORDER.md`. (b) `ai_usage_take` accepts any `p_bucket` text (service role only, so not exploitable). No syntax, grant or ordering errors.

**L6. Language Acquisition copy vs content.** The area text says "On-screen exams are offered at the capable and proficient levels", but the area's only subjects are the three "ab initio" courses (emergent phases). A student could read it as "my level has no on-screen exam". Worth a one-line clarification.

**L7. Carried over, unchanged:** dev-only React warning on a direct /dashboard load (round 3 L8 / round 4 L4) was not re-checked this round; lint warnings are the same three.

## 3. Harness notes (not bugs)
- First sign-in after a cold vite start submits before hydration (SIGNIN FAILED log line); I waited for hydration afterwards. At 390 px "Sign out" is behind the menu, so the harness SIGNIN FAILED message also appears when sign-in worked.
- The per-user marking burst limit (8 per 10 minutes) correctly produced "You are doing that too quickly" when one test user sat 9 papers; I used one user per batch.
- ERR_ABORTED entries for vite module URLs are navigations interrupting dev module fetches.
