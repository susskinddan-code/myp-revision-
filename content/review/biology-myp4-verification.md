# Biology MYP 4 verification (content/biology-myp4/)

Scope: 33 sub-topics (12 content files a-01..a-05, b-01..b-07, plus outline.json), 594 MCQs, 33 notes, 297 flashcards. Every question, answer key, explanation, note and flashcard was read; every calculation was re-worked (magnification, SA:V cubes, percentage change, rates, energy = m x 4.2 x dT, cardiac output, Punnett probabilities, 2^n bacterial growth, trophic transfer, biomass %, ppm ratios, herd immunity, dilution/DNA base %, etc.). All were correct.

Validator: `node scripts/json-to-sql.mjs content/biology-myp4 > /dev/null` exits 0 with no INVALID lines (before and after edits).

Automated checks (all pass): 18 MCQs and 9 flashcards per sub-topic; 5/8/5 difficulty; 4 distinct options; no duplicated question stems in the folder; notes 519-630 words and end with "Exam tip:"; flashcard backs all under 300 characters; no "1-7"/"HL"/"SL"/"A-level"/"Diploma" strings; no markdown tables; no note text in question or flashcard fields; outline.json matches the files exactly (topic and sub-topic strings and order); grade 4 and subject biology in every object.

Name uniqueness: all 33 sub-topic names are unique and do not match any sub-topic in content/biology-myp5 or content/gap/biology, any biology parent topic there, or any parent topic in this folder.

## Errors found and fixed

1. a-02.json, Osmosis in Plant and Animal Cells, note intro: said potato chips "go hard in salt water". In concentrated salt solution water leaves the cells and the chips go limp and soft. Reworded to "go limp and soft in very salty water".
2. b-01.json, Blood Vessels and Blood Components, note "Common mistakes": "Writing that red blood cells carry carbon dioxide" was misleading (some CO2 is carried by haemoglobin). Reworded to "Saying that red blood cells carry most of the carbon dioxide. Most carbon dioxide is carried in the plasma."
3. b-05.json, Pollution, Habitat Loss and Conservation, Q10: described the rise in concentration up a food chain and named it "Bioaccumulation". That is biomagnification. Correct option changed to "Biomagnification" and explanation rewritten. Note section changed to "Bioaccumulation and biomagnification" with both terms defined correctly; worked example now says "biomagnification"; the flashcard "Bioaccumulation" retitled "Bioaccumulation and biomagnification" with a correct back (under 300 chars). The Q6 distractor "Bioaccumulation" (eutrophication question) is still valid as a wrong answer.
4. b-02.json, Kidneys, Urine and Waste Removal, Q15: distractors "Ultrafiltration" and "Deamination" are beyond MYP 4 level. Replaced with "Filtration" and "Evaporation" (answer "Selective reabsorption" unchanged; the explanation already covers filtration).
5. All b-*.json files (b-01..b-07: 18 sub-topics, 324 MCQs): the answer key was index 0 for every question (correct option always first). Options were re-ordered (swap of the correct option with the target slot, answer index updated, asserted that the option text is unchanged) so correct positions are balanced: 90 / 90 / 72 / 72 across positions 0-3. a-*.json files were already balanced (5/5/4/4 per sub-topic).

(Files re-serialised with json.dump for items 3-5, so b-02, b-03, b-04, b-05, b-06, b-07 and b-01 are now pretty-printed with 2-space indent; content is unchanged apart from the edits above.)

## Unresolved / for Dan to be aware of

- Parent topic names (Photosynthesis, Respiration, etc.) were not compared against the live Biology MYP 4 topics in the database, which is not readable from here. The plan file says MYP 4 Biology has 10 existing legacy topics holding questions and no sub-topics. Before loading, confirm that json-to-sql attaches these sub-topics to the intended existing MYP 4 parent topics and that no sub-topic name equals a legacy MYP 4 top-level topic name. None of the 33 sub-topic names equals a legacy heading named in the plan (Cell Structure, Genetics, Evolution, Ecology, Human Physiology, Biodiversity).
- Minor, left as is: a few questions use grade-appropriate simplifications (e.g. "Cheese and yoghurt are made with bacteria", "mammals" as endotherms, 100 m sprint as the anaerobic example, ">98% DNA in common"). All are acceptable at MYP 4.
- Shared scratchpad note: this verifier wrote helper scripts dump.py and rep.py into the session scratchpad, which may have overwritten files of the same name written earlier by other work. Nothing in the repo outside content/biology-myp4/ and this report was changed.
