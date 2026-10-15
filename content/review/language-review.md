# Language content accuracy review (second pass), MYP 5

Scope: English L&L, French L&L, Spanish L&L, French / Spanish / Mandarin ab initio (all grade 5), plus the 38 language practice papers in `content/papers-myp5`.
Reviewer rule: every item read, nothing waved through. Fixes are made in the JSON and mirrored in `content/review/language-fixes.sql` (idempotent, begin/commit, exact old-text match, scoped by subject slug and grade 5).

## Order of SQL files

The working tree already contains fixes from two earlier reviews: `content/fixes/language-fixes.sql` (42 statements) and `content/review/languages-fixes.sql` (10 fixes). I do not know whether Dan has applied them live. `language-fixes.sql` in this folder matches the CURRENT working-tree text, so run it after those two files. Every statement matches exact old text, so one that matches nothing updates 0 rows and does no harm. Expect UPDATE 1 for each of the 11 statements.

## Counts checked

| Area | Sub-topics | MCQs | Flashcards | Notes |
|---|---|---|---|---|
| English L&L | 39 | 702 | 351 | 39 |
| French L&L | 24 | 432 | 216 | 24 |
| Spanish L&L | 24 | 432 | 216 | 24 |
| French ab initio | 27 | 486 | 243 | 27 |
| Spanish ab initio | 27 | 486 | 243 | 27 |
| Mandarin ab initio | 27 | 486 | 243 | 27 |
| Total | 168 | 3,024 | 1,512 | 168 |

Papers: 38 (English L&L 9, French L&L 4, Spanish L&L 4, French ab initio 7, Spanish ab initio 7, Mandarin ab initio 7). Every paper was read in full: stimulus texts, tasks, mark schemes. All 38 pass `papers-to-sql.mjs` and every `[n]` mark total equals the question marks. No "1-7" scale, DP, or A-level wording anywhere. Criterion levels are consistently 1-8 where levels are mentioned.

Checks applied: keyed answer truly correct; no distractor also correct; question unambiguous; French/Spanish accents, gender, agreement, conjugation, subjunctive/imperative forms; Mandarin characters, pinyin tone marks and tone sandhi (不 -> bú before 4th tone; 一 -> yí before 4th, yì before 1st/2nd/3rd); English literary-term definitions and text-type conventions; MYP level only; no real-author quotations presented as genuine.

## Errors found and fixed (11)

### Content (6)

1. Mandarin ab initio, Family and Friends > Describing People, Q6 (MCQ). The question asks what 她很高 means and the keyed answer was "She is very tall". The explanation itself says 很 in plain statements often just means "is", so "very tall" over-translates, and a student who answers "She is tall" would be marked wrong.
   - Before: keyed option "She is very tall"
   - After: keyed option "She is tall" (other options unchanged; position and answer index unchanged)
2. Mandarin ab initio, Home and Daily Life > Rooms and Furniture, note and flashcard 8 back. Pinyin tone mark missing and inconsistent with the Town and Travel topic.
   - Before: 前面 (qiánmian)
   - After: 前面 (qiánmiàn)
3. Spanish ab initio, Town and Travel > Asking for and Giving Directions, note. The usted rule was wrong: it said the usted command ends in -e "except for seguir", but the ending is -e only for -ar verbs and -a for ALL -er/-ir verbs (seguir is just one example; the same applies to e.g. escribir, volver). A student would wrongly expect "sigue/gire"-style -e on -er/-ir verbs.
   - Before: "The tú form looks like the 'he/she' present tense (sigue, gira, cruza, toma). The usted form ends in -e (gire, cruce, tome) except for 'seguir', which becomes 'siga'."
   - After: "The usted form of -ar verbs ends in -e (gire, cruce, tome); -er and -ir verbs end in -a, so 'seguir' becomes 'siga'."
4. Spanish L&L, Prose and Fiction > Character and Setting, Q5 (MCQ). The question shows a physical description and the keyed option called it "una caracterización directa", but the note in the same sub-topic defines direct characterization as the narrator stating a trait; a description that only implies tiredness is indirect, so the keyed wording contradicted the study material.
   - Before: "Una caracterización directa que sugiere cansancio o nervios"
   - After: "Una descripción física que caracteriza al personaje y sugiere cansancio o nervios"
5. English L&L, Language Accuracy > Grammar, Punctuation and Syntax, note worked example. "No point staying" is correct idiom, so the claimed "missing preposition" was itself an error.
   - Before: Corrected: "...there was no point in staying." Errors fixed: the comma splice, the confusion of "their" and "there", and the missing preposition "in".
   - After: Corrected: "...there was no point staying." Errors fixed: the comma splice and the confusion of "their" and "there".
6. English L&L, Language Accuracy > Spelling, Vocabulary and Editing, note. "friend" obeys "i before e", so it is not an exception; "received" is an example of the rule, not a contrast.
   - Before: "i before e, except after c" (received, but friend is an exception)
   - After: (receive, but weird is an exception)

### Papers (4)

7. Mandarin ab initio Paper B (137), Q7: French guillemets around a Chinese blog title. Before: « 爱护地球 ». After: “爱护地球”.
8. English L&L Structure Mock B (79), Q1, Text A: "Mara: you up?" is two words but the text said "Three words." Now "Two words."
9. English L&L Paper B (107), Q1.1: the question said "the second paragraph" but the repeated "They do not say..." sits in the third block (the speech opens with a one-line greeting and a paragraph before it). Now "in the paragraph beginning 'They do not say that on the fourteenth of October'".
10. English L&L Structure Mock A (78), Q1, Text B: exhibition dated 14 March to 30 April but described as "six weeks" (47 days). Now "almost seven weeks".

SQL statements: items 1-6 are 7 statements (item 2 covers a note and a flashcard) and items 7-10 add 4, so `language-fixes.sql` has 11 statements.

## Observations, not changed

- Mandarin: 学生 is spelled xuésheng (neutral second syllable, the standard dictionary form) in 08 and 09 but xuéshēng in 01-greetings-and-introductions. Both are in use and neither is an error at this level, so nothing was changed; a consistent choice would be tidier.
- Paper titles: 106, 107, 108 and 51 say "(3 tasks, 80 marks)" counting exam tasks, while 78, 79, 86, 87 and the other subjects say "(7 tasks ...)" counting questions. The two conventions are inconsistent but titles are used as dedup keys by the loader, so I did not change them.
- French L&L and Spanish L&L papers are written "for this paper" (original texts); no real-author quotations were found anywhere, so nothing needed removal.
- Spanish Paper 2 Text A: "A Isla Bermeja no se llega: se desemboca" uses desembocar (normally for rivers) figuratively; acceptable as deliberate wordplay.
- English L&L papers 06 and 16 use British spelling and idiom consistently; 'Mara' is reused as a character name across three papers (no content problem).

## Could not verify

- Audio and pronunciation: nothing audible was available, so tone and pronunciation claims were checked on paper only (pinyin tone marks, sandhi rules).
- Real-world exam fidelity: whether the paper formats exactly match the live MYP eAssessment cannot be checked (real papers are not public).
- Attribution of any lines to real authors or real events can only be judged from memory; none were found being presented as real quotations.
- Whether the two earlier SQL fix files have been applied to the live database. This file assumes the working-tree text and is safe either way.
- Mandarin vocabulary frequency and "what students at MYP 5 ab initio level actually meet" is judged from the MYP language acquisition phase descriptors, not from an official word list.
