# Humanities accuracy review (2026-10-14)

Scope: Individuals & Societies (History, Geography, Economics), Interdisciplinary Learning and Environmental Systems at MYP 5.

## Reviewed

| Area | Count |
|---|---|
| Sub-topic entries (history-myp5 38, geography-myp5 36, economics-myp5 35, interdisciplinary-learning-myp5 22, environmental-systems-myp5 24, gap/history 17, gap/geography 9) | 181 |
| MCQs (stored answer and explanation checked, other options checked for defensibility) | 3,258 |
| Flashcards | 1,629 |
| Study notes | 181 |
| Papers in `papers-myp5` (history, geography, economics, interdisciplinary-learning, environmental-systems) | 38 papers / 282 tasks |

Every calculation in content and papers was recomputed (marks, percentages, means, unit conversions, ratios, BCRs, payback times). Paper mark-scheme `[n]` sums match task marks (mechanical check, all 38 pass).

## Result

No high or medium errors found. No wrong stored MCQ answers, no indefensible distractors, no flashcard/note text bleed, no DP/A-level/IGCSE material, and no 1-7 criterion scale (criteria are A-D throughout; no level scale is used in these items). Colonialism, Cold War, Suez, Algeria, Armenian genocide, Cambodia, China and Israel/Palestine content is balanced and sourced to multiple perspectives.

Severity key: high = wrong stored answer or factual error students would learn; medium = misleading but not wrong; low = imprecision, unhedged dated statistic, or wording.

Totals: 0 high, 0 medium, 14 low (7 distinct issues in sub-topic content, fixed in 6 JSON files across 16 text locations; 7 in papers).

## A. Sub-topic content fixes (JSON edited in place and SQL written)

| # | File | Where | Sev | Issue | Fix |
|---|---|---|---|---|---|
| 1 | history-myp5/05-revolution-in-russia.json (Great Terror) | Q5 explanation, note, flashcard 8 | low | "Millions" arrested in the Great Terror overstates the usual estimate | "Over a million ... in 1937-38" |
| 2 | gap/history/03-ideas-and-ideologies.json (first sub-topic) | Q11 explanation | low | Louis XVI's execution (January 1793) was placed within the Terror, which began later in 1793 | Chronology corrected |
| 3 | gap/history/04-everyday-life-and-culture.json | Q9 option, note, flashcard 7 | low | Bayeux Tapestry described as made on the Norman side; provenance is debated | Hedged: probably commissioned by Bishop Odo, usually read as favouring the Norman viewpoint |
| 4 | geography-myp5/05-weather-and-climate.json | Q6 content, note, flashcard 7 | low | CO2 "about 420 ppm" stated as current | Dated "in the early 2020s" |
| 5 | geography-myp5/05-weather-and-climate.json | Q10 content, note, flashcard 8 | low | Warming "1.1 C" not tied to a source or period | Tied to IPCC, 2011-2020 compared with 1850-1900 |
| 6 | environmental-systems-myp5/05-climate-and-atmosphere.json | Q7 content, note | low | "420 ppm today" | Dated "in the early 2020s" |
| 7 | economics-myp5/05-government-intervention.json | note | low | "core of the real-world application criterion" is not an MYP criterion name | "draws mainly on Criterion D, Thinking critically" |

(Item numbers for questions are 1-based; the SQL file lists the exact old and new text for each statement.)

## B. Paper fixes (JSON edited in place; SQL appended to the fixes file)

| # | Paper | Where | Sev | Issue | Fix |
|---|---|---|---|---|---|
| 8 | 25-history-full-mock | Q7(b) mark scheme | low | India and Pakistan both given 15 August 1947 | Pakistan 14 August, India 15 August |
| 9 | 67-history-structure-mock-a | Q3 Source A (Montgomery leaflet) | low | Leaflet says Rosa Parks "has been fined"; the fine came at the Monday trial after the leaflet was distributed | "Her case will be heard in court on Monday." |
| 10 | 68-history-structure-mock-b | Q7 Source I timeline | low | ANC/PAC ban implied to be on 21 March 1960; it was in April 1960 | "In April 1960 ... are banned" |
| 11 | 127-s6-geography-B | Q2(c) mark scheme | low | Said December is 24 C; Source B gives 23 C | January and February 24 C, December 23 C |
| 12 | 123-s6-economics-A | Q3(c) mark scheme | low | Unit-elastic PED by simple percentage change said to leave revenue "about the same"; revenue actually falls from 20,000 to 18,750 | Reworded with the real figures |
| 13 | 129-s6-history-A | Q6(c) mark scheme | low | "both [Britain and France] had nuclear weapons" in 1956; France first tested in 1960 | "Britain had nuclear weapons" |
| 14 | 75-environmental-systems-structure-mock-a | Q2 stimulus | low | Undated "It is now about 420 ppm" | "In the early 2020s it was about 420 ppm" |

Other papers: `109-s4-chemistry-A.json` also contains "420 ppm" but is outside this scope (flag for the chemistry reviewer).

## C. Checked and left unchanged (judgement calls)

- Pearl Harbor / Germany's declaration of war on the US wording: acceptable simplification at MYP level.
- "Armenian genocide" and "Cambodian genocide" labels: standard scholarly terminology; sources present the Ottoman/Turkish and Khmer Rouge positions neutrally where the item asks for perspectives.
- OPCVL vs OPVL naming: both used for source analysis; consistent within each item.
- Copenhagen "carbon-neutral by 2025" goal is described as a goal, not an achievement.
- Ekofisk "production after discovery in 1969": production began 1971, wording says "after", so not wrong.
- Tokyo "more than 30 million": hedged ("estimates vary"); fine.
- Environmental Systems themes (worldviews, EIA, precautionary principle) resemble DP ESS topics but are pitched at MYP level with no HL/SL terminology, so left.
- Stylised teaching figures in papers (all fictional places are labelled as invented; numbers are not claimed as real statistics).

## D. Could not be verified

- Live-source checks of dated statistics (global CO2 ppm, warming, sea-level rise rate, city populations). They are now hedged to the early 2020s but were not each checked against the latest published data.
- Exact figures for the Great Terror (arrests vs executions are estimates) and for IPCC period averages.
- Fictional case-study figures (Tamberlo, Kasira, Harbourfield etc.) are internally consistent but not real data, by design.
- Database state: fixes SQL assumes the live rows still contain the original text. Statements match exact old text, so rows that were already changed, or whose option order differs from the (i*3)%4 shuffle, will simply not match (0 rows updated).

## E. Files

- Edited: history-myp5/05-revolution-in-russia.json, gap/history/03-ideas-and-ideologies.json, gap/history/04-everyday-life-and-culture.json, geography-myp5/05-weather-and-climate.json, environmental-systems-myp5/05-climate-and-atmosphere.json, economics-myp5/05-government-intervention.json, and papers-myp5 files 25, 67, 68, 75, 123, 127, 129.
- Written: fixes/humanities-fixes.sql (begin/commit, idempotent `$mq$` dollar-quoted updates for questions, flashcards, notes and paper_questions) and this review.
- Validation: `node scripts/json-to-sql.mjs` runs clean on all seven content folders after the edits; all papers parse; `validate-widget-papers.mjs` passes.
- Not committed.
