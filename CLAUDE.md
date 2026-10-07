# MYP Revision (a.k.a. "MYP Genius Hub")

Web study platform for IB Middle Years Programme students (MYP 1-5 / school Grades 6-10), modelled on Revision Village / Revision Dojo but MYP-only. Features: question banks (MCQ + written), flashcards, study notes, AI-marked practice papers, progress tracking.

Owner: Dan, who is himself sitting the MYP eAssessment in May (MYP 5 / Grade 10). **MYP 5 is the priority grade.**

## Stack (as exported from Lovable)

- TanStack Start (React 19, TypeScript, Vite), TanStack Router file routes in `src/routes/`, TanStack Query
- Tailwind v4 + shadcn/ui (`src/components/ui/`)
- Supabase (Postgres + auth). Client in `src/integrations/supabase/`. Types in `src/integrations/supabase/types.ts` (generated, do not hand-edit)
- Schema/migrations in `drizzle/migrations/` (`drizzle/schema.ts` is auto-generated and intentionally blank). Supabase project id is in `supabase/config.toml`
- Server functions in `src/lib/ai.functions.ts` (`getQuestionFeedback`, `gradePaper`)
- Package manager: bun (`bun.lock`); `npm i` also works. Scripts: `dev`, `build`, `lint`, `format`
- `bun.lock` pins Lovable's private npm mirror (403 outside Lovable). Use `npm i` (a public-registry `package-lock.json` is committed; installs and `npm run build` succeed). Ignore `bun.lock`
- `.env` holds only the public Supabase URL/publishable key. Never commit service-role keys or API keys

## Known Lovable-specific dependencies (must be replaced to run outside Lovable)

- AI feedback and paper marking now call the Anthropic API (`claude-sonnet-4-5`) through `src/lib/anthropic.server.ts`. It needs `ANTHROPIC_API_KEY` as a server-only env var (put it in an untracked `.env.local`, and in the host's secret settings when deployed). Paper marking uses forced tool-use for structured JSON. Not yet tested against the live API because no key was available when it was written
- `src/integrations/lovable/index.ts` and `@lovable.dev/cloud-auth-js` handle Lovable Cloud sign-in. Check whether Google sign-in depends on it before touching auth
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

Done to flagship depth: Physics MYP 4 and Physics MYP 5 (55 sub-topics each). Practice-paper sitting + AI marking is a reusable app-wide feature.

## Current plan (target: December 2026)

1. Biology MYP 5: 19 headings are empty; consolidate to 13 topics / 40 sub-topics (breakdown in `.lovable/plan/biology-myp-5-sub-topic-breakdown-for-review-2026-09-16.md`), then generate content
2. All 21 subjects built at Grade 10 (MYP 5) depth, then Grade 9, then Grade 8
3. Top-level "eAssessment" section: Language & Literature, Individuals & Societies (one of History/Geography/Economics), Sciences (one of Physics/Chemistry/Biology/Integrated), Mathematics (Standard/Extended), Language Acquisition, Interdisciplinary Learning. Arts, Design and PHE are ePortfolio-assessed so are excluded from this section but still built as normal subjects
4. "Build My Exam": student picks topics/difficulty/count and the app assembles a paper from the existing bank, reusing the marking logic (cheap alternative to live AI generation)
5. Flashcards were lost in the original migration and are being regenerated per sub-topic

## Working rules

- This repo may stay connected to Lovable. **Never rewrite pushed git history** (no force-push, rebase, amend or squash of pushed commits). Keep the main branch working, since pushes sync back into the Lovable editor
- Dan prefers one comprehensive prompt and then an uninterrupted run, with screenshot-based UI feedback afterwards
- Run `bun run build` (or `npm run build`) and `lint` before declaring work done
- Plans and review documents live in `.lovable/plan/`; `roadmap.md` tracks the checklist
