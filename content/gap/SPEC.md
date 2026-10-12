# Gap-content spec (MYP 5)

Read `content/outlines/BRIEF.md` first: it is the full quality bar, JSON schema, validation rules and style (18 MCQs 5/8/5 easy/medium/hard, 1 note >= 450 words ending "Exam tip:", 9 flashcards, MYP level only, verify every calculation/fact, never 1-7 / Diploma / A-level, plain text, no markdown tables).

Overrides for this job:
- Outline: `content/gap/outlines/<subject>.json` (array of {topic, subTopics[]}). Write ONLY the sub-topics assigned to you, using the EXACT topic and subTopic strings.
- Output folder: `content/gap/<subject>/` (not content/<subject>-myp5). One JSON file per parent topic, named `NN-<topic-slug>.json` with NN = 1-based index of the topic in the outline file for that subject (zero padded). Each file is an array of sub-topic objects in outline order. Include `"subject": "<slug>", "grade": 5`.
- Validate only your own folder: `node scripts/json-to-sql.mjs content/gap/<subject> > /dev/null` (other writers share the folder; ignore INVALID lines for files that are not yours).
- Where a sub-topic extends an existing parent (e.g. "Heat and Temperature", "Functions", "Biotechnology"), it still gets its own file; use the parent name exactly.
- Integrated Science (`integrated-science`): the real eAssessment is one combined sciences paper drawing on biology, chemistry and physics through global contexts. Write MYP 5 depth across the three sciences and include context-based items (experiment data in text, fair-test design, evaluating a method, impact of science on society) typical of criteria A-D.
- Extended Mathematics: extended depth (still MYP, never Diploma). Standard Mathematics: Standard depth.
- Maths: use python3 to verify every calculation. History: only accurate, widely documented facts (dates, names, events); no invented quotations from real people; if unsure of a detail, leave it out.
- Be efficient: do not over-explain, do not re-read other writers' files. Reply with only: files written, number of sub-topics, validator status.
