# Which SQL files to run (2026-10-15)

Verified by loading the committed (HEAD) content into a local Postgres 16 (schema from `drizzle/migrations/`, loaders `scripts/json-to-sql.mjs` and `scripts/papers-to-sql.mjs`), running every file below, and comparing the result with a second database loaded from the current working-tree JSON. After the five accuracy files ran, all questions, flashcards, notes and paper questions were identical to the working-tree JSON (0 differing rows out of 28,545). So together they are complete, they do not conflict, and nothing in the working-tree content edits is left without SQL.

All files are `begin; ... commit;`, use dollar-quoted (`$mq$`) text and update only rows whose current text matches the exact old text. A statement that finds nothing reports `UPDATE 0` and changes nothing. Re-running is safe (three statements in `content/fixes/language-fixes.sql` and three in `content/fixes/humanities-fixes.sql` rewrite the same value and report `UPDATE 1` again; that is harmless).

Run each file in the Supabase SQL editor (project `qntfyxrlnvdsqklaedcm`), one at a time, in this order.

| # | File | Statements | Expected result on a DB loaded from the committed content |
|---|---|---|---|
| 1 | `content/fixes/humanities-fixes.sql` | 23 | 23 x `UPDATE 1`. History (Great Terror, Terror chronology, Bayeux Tapestry), geography/environmental systems climate figures dated, economics criterion wording, 7 paper fixes (India/Pakistan dates, Montgomery leaflet, ANC/PAC ban, etc.) |
| 2 | `content/review/humanities-fixes.sql` | 20 (15 + 5) | 19 x `UPDATE 1` and 1 x `UPDATE 2` (the Geography Structure Mock B statement hits two task rows, Q4 and Q7). English wording and option-position fixes, PED question, Bismarck, Tokyo, OVRA dating, EU members, geography paper mark schemes |
| 3 | `content/fixes/language-fixes.sql` | 42 | 42 x `UPDATE 1`. French/Spanish/Mandarin/English first language pass (sympa, distractors, positional explanations, Spanish subjunctive, band labels, paper 106 stanza references) |
| 4 | `content/review/languages-fixes.sql` | 10 | 10 x `UPDATE 1`. Positional explanations in French/Spanish ab initio, Spanish rhyme, Spanish "desayunar" item, Spanish notice wording |
| 5 | `content/review/language-fixes.sql` | 11 | 11 x `UPDATE 1`. Mandarin 她很高, qiánmiàn, Spanish usted rule, Spanish L&L characterisation option, two English notes, four paper fixes |
| 6 | `content/papers-widgets/load.sql` | 11 papers | Inserts the 11 interactive practice papers (44 tasks). Skips any paper whose subject, grade and title already exist, so re-running adds nothing. Independent of 1-5 |

Order matters little (the four accuracy files were also tested alone and in reverse order, all statements still matched), but files 4 and 5 were written to follow 3, so use the order above.

## Not obsolete, but easy to confuse

- `content/fixes/` (written 10-14) and `content/review/` (written 10-15) are NOT alternatives. They fix different rows. `content/review/humanities-fixes.sql` and `content/review/language-fixes.sql` were written later and say they must run after the older files. Nothing in `content/fixes/` was superseded, so nothing there was moved.
- `languages-fixes.sql` (with an s, 10 fixes, written 10-14) and `language-fixes.sql` (no s, 11 fixes, written 10-15) are two different files in `content/review/`. Run both.

## Obsolete (moved to `content/_unused/`)

- `content/_unused/papers-widgets-out-OLD-6-papers.sql` (was `content/papers-widgets/out.sql`): an older output of `papers-to-sql.mjs` with only 6 of the 11 widget papers and the pre-verification text. Running it before `load.sql` would insert the old versions of papers 61-66 and `load.sql` would then skip them because the titles match. Use `load.sql` only.

## Before you run

- The fixes assume the live rows still hold the text the loader wrote from the committed JSON. If some were already changed by hand, those statements report `UPDATE 0`; that is not an error.
- The subject slugs used are the ones in the content JSON (for example `english-language-and-literature`). If every statement for one subject reports `UPDATE 0`, check that subject's slug in the `subjects` table first.
- Quick check after running files 1-5 (all should return 0):
  `select count(*) from public.questions where content like '%Cold, he thought. Cold, and nobody coming%' or content like '%sandwich from $50 to $45 per party tray%';`

## Accuracy notes from this verification (no change needed)

- Spot-checked as correct: Pakistan 14 August / India 15 August 1947; ANC and PAC banned April 1960; Great Terror "over a million arrested in 1937-38"; Louis XVI executed January 1793 before the Terror; CO2 280 to about 420 ppm (50 per cent, or 33 per cent on the new base); IPCC 2011-2020 about 1.1 C above 1850-1900; Bismarck wars 1864/1866/1870-71; EU 27 members in 2020 (21 more than the six founders); France's first nuclear test 1960; OVRA from 1927; PED example (10 per cent price cut, 30 per cent rise in orders, PED 3, revenue 10,000 to 11,700); Veldara energy figures (36 PJ to 420 PJ wind and solar, coal -56.5 per cent); Kandara basin (30 + 2 x 23 = 76 million cubic metres); Spanish usted imperatives (-ar gives -e, -er/-ir give -a); sympa invariable in gender; 她很高; 前面 qiánmiàn; "Fermes" as tu present, "ferme" as tu command.
- Left as the reviewers decided: Armenian genocide "more than one million", Falkenhayn "bleed France white" (post-war memoir), Mandarin 学生 xuésheng/xuéshēng inconsistency, paper-title task-count conventions.
