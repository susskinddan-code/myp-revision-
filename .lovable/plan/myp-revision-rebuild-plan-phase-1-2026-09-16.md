# MYP Revision — Rebuild Plan (Phase 1)

## My recommendations on your two open questions

**Scope:** Build the foundation plus a working question bank and flashcards. That gives a real, usable study loop end to end rather than an empty shell. Notes, practice papers and the progress dashboard follow in phase 2, once the core loop feels right.

**Existing content:** Start fresh. Your old data has ~9,700 broken records; importing it would carry every one of those problems into the new build. I'll set up the 21 subjects and the structure to hold topics, questions and flashcards, seed a handful of real topics with good sample content so every screen works, and leave a clean import path for when you've fixed and exported the old content.

## What gets built in phase 1

**Look and feel**
- Warm palette from your handoff (sage green, warm tan, off-white), Fraunces headings, DM Sans body, dot-grid background, pill buttons, 16px cards, soft shadows.
- Card hover lift, 300ms page fades, animated progress bars, 3D flashcard flip.

**Pages**
- Home — what the platform is, grade picker, entry to subjects.
- Subjects — all 21 subjects grouped by the 8 MYP groups, each in its group colour, filtered by grade.
- Subject page — tabbed: Overview, Question Bank, Flashcards, Practice Papers (placeholder in phase 1), My Progress.
- Question bank — pick a topic, answer multiple-choice questions, get instant marking and AI feedback when wrong.
- Flashcards — flip deck with "Got it" / "Review again".
- Sign in / sign up — email and password plus Google.
- Account — grade, streak, recent activity.

**Behind the scenes**
- Accounts required to study, per your answer. Every answer is recorded against the signed-in user.
- AI feedback and paper grading through Lovable's built-in AI — no API key, no Anthropic bill.
- MYP Levels 1–8 everywhere: in grading logic, AI prompts and anything shown on screen. Never 1–7.
- Charts and question diagrams hand-drawn as SVG, no charting library.

## Data model

Tables: `subjects`, `topics`, `questions`, `flashcards`, `notes`, `past_papers`, `paper_questions`, `question_attempts`, `profiles`.

Key decisions carried over from the audit so the old bugs can't recur:
- `questions.answer` stored as an integer index (0–3) with a check constraint that it falls inside the options array, and options constrained to exactly 4 non-empty strings. The "answer not in options" class of bug becomes impossible.
- `questions.visual` as JSON, rendered by a diagram component supporting force diagrams, circuits, line graphs, data tables and geometric shapes.
- A paper cannot be listed unless it has attached questions — no empty shells.
- `question_attempts` records user, question, topic, subject, source and correctness; the dashboard aggregates from it.

Security: subjects, topics, questions, flashcards and notes are readable by everyone; attempts and profiles are readable and writable only by their owner. A profile row is created automatically on signup to hold grade and streak.

## Technical notes

- TanStack Start with file-based routes; Lovable Cloud for database, auth and storage.
- Design tokens defined in `src/styles.css` under `@theme`; fonts loaded via `<link>` in the root route.
- AI calls run server-side through the Lovable AI Gateway from server functions (`feedback`, later `generate-paper` and `evaluate-paper`). Prompts hard-state MYP Levels 1–8 and request structured JSON.
- Seed data ships as SQL in the migration: 21 subjects, their groups and grades, plus sample topics/questions/flashcards for a few subjects so the UI is never empty.
- Per-route metadata (title, description, social preview) on every page.

## Phase 2 (not in this build)

Notes per topic, AI practice paper generation and grading, full progress dashboard with weak-topic analysis and streaks, spaced repetition (SM-2), search and filters, admin panel, dark mode, importer for your cleaned legacy export.
