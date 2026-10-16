# MYP Revision (a.k.a. "MYP Genius Hub")

Web study platform for IB Middle Years Programme students (MYP 1-5 / school Grades 6-10), modelled on Revision Village / Revision Dojo but MYP-only. Features: question banks (MCQ + written), flashcards, study notes, AI-marked practice papers, progress tracking.

Owner: Dan, who is himself sitting the MYP eAssessment in May (MYP 5 / Grade 10). **MYP 5 is the priority grade.**

## Stack (as exported from Lovable)

- TanStack Start (React 19, TypeScript, Vite), TanStack Router file routes in `src/routes/`, TanStack Query
- Tailwind v4 + shadcn/ui (`src/components/ui/`)
- Supabase (Postgres + auth). Client in `src/integrations/supabase/`. Types in `src/integrations/supabase/types.ts` (generated, do not hand-edit)
- Schema/migrations in `drizzle/migrations/` (`drizzle/schema.ts` is auto-generated and intentionally blank). Supabase project id is in `supabase/config.toml`
- Server functions in `src/lib/ai.functions.ts` (`getQuestionFeedback`, `gradePaper`)
- Needs Node 22+ (Node 20.11 fails with `styleText` error); `.nvmrc` pins 22
- Package manager: bun (`bun.lock`); `npm i` also works. Scripts: `dev`, `build`, `lint`, `format`
- `bun.lock` pins Lovable's private npm mirror (403 outside Lovable). Use `npm i` (a public-registry `package-lock.json` is committed; installs and `npm run build` succeed). Ignore `bun.lock`
- Database now lives in Dan's own Supabase project `qntfyxrlnvdsqklaedcm` (moved off Lovable Cloud on 2026-10-07; schema applied and all content copied, 150 sub-topics / 5,458 questions / 1,242 flashcards / 323 notes / 216 papers). Supabase dashboard: supabase.com/dashboard/project/qntfyxrlnvdsqklaedcm
- `.env` holds only the public Supabase URL/publishable key. Never commit service-role keys or API keys

## Known Lovable-specific dependencies (must be replaced to run outside Lovable)

- AI feedback and paper marking now call the Anthropic API (`claude-sonnet-4-5`) through `src/lib/anthropic.server.ts`. It needs `ANTHROPIC_API_KEY` as a server-only env var (put it in an untracked `.env.local`, and in the host's secret settings when deployed). Paper marking uses forced tool-use for structured JSON. Not yet tested against the live API because no key was available when it was written
- Google sign-in now uses `supabase.auth.signInWithOAuth` (no longer Lovable Cloud). It only works once the Google provider is enabled in the Supabase project (Authentication -> Providers -> Google, needs a Google Cloud OAuth client) and the site URL is in the redirect allow-list. Email/password sign-in works as is. `src/integrations/lovable/` is now unused
- Database changes: prefer adding a new numbered SQL migration in `drizzle/migrations/` and telling Dan to apply it; do not assume direct DB write access from this environment

## Non-negotiable rules

- MYP internal/criterion achievement uses **Levels 1-8, never 1-7**
- The real MYP eAssessment reports the overall subject grade on **1-7**. eAssessment-style practice papers must show both scales, labelled clearly
- `grade` is stored as 1-5 (= MYP 1-5 = school Grades 6-10)
- Content must be MYP-accurate. Never Diploma Programme / A-level material (this has happened before in Extended Maths)
- Real IB past papers are not publicly available and must not be copied. Papers here are AI-generated, exam-style, in the real format
- All question attempts require a signed-in user (anonymous support was dropped)
- After any content generation run, validate data integrity (past incidents: notes text landing in flashcard/question fields)
- MCQ answers are stored as numeric indices, not letters

## Content model

Subject -> Topic -> Sub-topic (via `parent_topic_id`). Each sub-topic page shows its Note, Flashcards, MCQs and matching practice-paper questions together; "Whole topic" and "All practice papers" are the broader options. Flagship depth per sub-topic: ~18 MCQs + 1 study note + 9 flashcards.

Done to flagship depth: Physics MYP 4 and Physics MYP 5 (55 sub-topics each). MYP 5 flagship content also written, checked and loaded into the live DB (2026-10-11) for: Biology, Chemistry, Standard/Extended Maths, English L&L, French/Spanish L&L, History, Geography, Economics, Interdisciplinary Learning, Environmental Systems, French/Spanish/Mandarin ab initio, Visual Arts, Music, Drama, Product Design, Digital Design, PHE (DB slug physical-and-health-education). Legacy empty placeholder topics still exist (name clashes: sub-topic names must differ from legacy top-level topic names). Practice-paper sitting + AI marking is a reusable app-wide feature.

## Current plan (target: December 2026)

1. ~~Biology MYP 5~~ done (13 topics / 40 sub-topics, flagship depth). Next: Biology MYP 4 and other subjects at Grade 10 depth
2. All 21 subjects built at Grade 10 (MYP 5) depth, then Grade 9, then Grade 8
3. Top-level "eAssessment" section: Language & Literature, Individuals & Societies (one of History/Geography/Economics), Sciences (one of Physics/Chemistry/Biology/Integrated), Mathematics (Standard/Extended), Language Acquisition, Interdisciplinary Learning. Arts, Design and PHE are ePortfolio-assessed so are excluded from this section but still built as normal subjects
4. "Build My Exam": student picks topics/difficulty/count and the app assembles a paper from the existing bank, reusing the marking logic (cheap alternative to live AI generation)
5. Flashcards were lost in the original migration and are being regenerated per sub-topic

## Working rules

- This repo may stay connected to Lovable. **Never rewrite pushed git history** (no force-push, rebase, amend or squash of pushed commits). Keep the main branch working, since pushes sync back into the Lovable editor
- Dan prefers one comprehensive prompt and then an uninterrupted run, with screenshot-based UI feedback afterwards
- Run `bun run build` (or `npm run build`) and `lint` before declaring work done
- Content without an API key: write JSON in `content/<name>/` and run `node scripts/json-to-sql.mjs content/<name> > out.sql`, then Dan reviews and runs it in the Supabase SQL editor
- Content generation: `node scripts/generate-content.mjs --subject biology --grade 5 [--limit N] [--dry-run]` (needs ANTHROPIC_API_KEY, SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY in the shell, never committed). Always dry-run a few sub-topics and read the output before loading
- Plans and review documents live in `.lovable/plan/`; `roadmap.md` tracks the checklist

## Typed answers and AI-written exams (2026-10-12)

- MCQ rows are kept as-is (question + `options[answer]` = stored correct answer) but students now TYPE the answer. `checkTypedAnswer` (ai.functions.ts) returns correct / partial ("half right") / wrong with escalating hints; after 5 tries or "Show answer" the answer is revealed. Without `ANTHROPIC_API_KEY` it falls back to `src/lib/typed-answer.ts` (plain match + generic hints)
- Mixed test, Build my exam and "Write me a new paper" call `generateExamTasks` to write brand-new tasks (validated: mark scheme `[n]` sum = marks, no banned terms). They fall back to the stored paper tasks if the AI is unavailable. Recent stems are remembered in localStorage to avoid repeats. Untested against the live API (no key yet)

## Gap content, caches, widgets, My files (2026-10-12)

- 114 gap sub-topics (incl. Integrated Science) from `content/gap/` are loaded in the live DB and verified
- `answer_cache` and `generated_tasks` (migration 0006, applied, RLS on, no policies) are server-only: they need `SUPABASE_SERVICE_ROLE_KEY` in `.env.local` or host secrets; without it caching/bank saving is silently skipped. Dan must also set `ANTHROPIC_API_KEY`
- Exam task markup (`src/lib/task-markup.ts`, rendered by `TaskBody.tsx`): `{{select|id|opt|opt}}`, `{{drag|id|Slot,Slot|item,item}}`, `{{plot|id|xmin,xmax,ymin,ymax|xl|yl}}`, `{{fill|id|Col,Col|rows}}`, `{{chart|bar|line|pie|Title|xl|yl|A:3,B:5}}`. Stored papers do not use widgets yet; only the generator does
- `/my-files`: opens a local PDF (never uploaded) and keeps a localStorage links list
- Tested end to end with Playwright against a fake PostgREST and fake Anthropic server (`ANTHROPIC_API_URL` override): typed answers (wrong, half right, correct), Mixed test widgets, marking, clickable stat blocks. NOT tested: the real Anthropic API, cache/bank writes with a real service-role key
- Not built on purpose: free allowance and payments

## Round 3-4 hardening and content (2026-10-15)

- Server AI logic now lives in `src/lib/ai-core.server.ts` (public server functions unchanged in `ai.functions.ts`). `gradePaper` takes only task ids: question and mark scheme are loaded server-side (stored papers by id; AI-written tasks via `gen-<uuid>` bank rows or an HMAC-signed `gen-new-*` task). Client text is never trusted. Writer avoid-lists are built server-side; `safeToBank` filters before anything is shared
- Migrations 0007 + 0008 (apply in SQL editor): service-role-only RPCs, per-user daily allowance (`AI_USER_DAILY_UNITS`) and global budget (`AI_DAILY_BUDGET_UNITS`), one report per user. They fail open (with a log) if not applied
- `src/lib/safe-redirect.ts` guards `/auth?redirect=`; TanStack `validateSearch` must always return the key or the raw value survives
- Saved exams live in sessionStorage (`myp-exam:*`), cleared on sign-out
- 11 interactive-widget papers in `content/papers-widgets/` (load.sql); Biology MYP 4 in `content/biology-myp4/` (33 sub-topics, SQL in `sql/`); accuracy fixes in `content/fixes/` and `content/review/` — run order in `content/review/RUN-THESE-IN-ORDER.md`
- Tests: `npx tsx scripts/test-*.mts`, `node scripts/validate-widget-papers.mjs`, `node scripts/check-paper-sizes.mjs`. QA reports in `content/review/QA-round*.md`. Lint ignores generated `src/integrations/supabase/**` and `src/components/ui/**`
- Known open (Low): daily-quota exhaustion message wording, 60-min mix can run 65 min, tone-number pinyin rejected offline, dev-only React warning on direct /dashboard load

## eAssessment completion (2026-10-16)

- Interactive widget papers 61-79 (19) cover every eAssessment area (`content/papers-widgets/`, load with `load.sql`, regenerate via `node scripts/papers-to-sql.mjs content/papers-widgets > content/papers-widgets/load.sql`). Language/IDL papers verified (`content/review/widget-papers-72-79-verification.md`); a native-speaker skim of French/Spanish/Mandarin is still advisable
- Area copy in `src/lib/eassessment.ts` corrected from IB sources (`content/review/eassessment-format-research.md`): Language acquisition 120 min; formula sheet is a revision aid; no listening/audio, no on-screen graphing calculator, no multi-extract L&L view yet
- Migration 0009: separate AI allowance buckets (`check` vs `exam`), apply after 0008. Stated exam minutes are a hard cap (`src/lib/exam-fit.ts`). Subject and tab are in the URL for /eassessment/$area; saved exams (sessionStorage) resume across subjects
- QA reports `content/review/QA-round5-report.md`; migrations 0006-0009 were run clean twice in PGlite
