# Content writing brief (MYP 5 / Grade 10 revision site)

You are writing ORIGINAL revision content for an IB MYP revision website. Students are MYP 5 (Grade 10, ~15-16 years old) preparing for the MYP eAssessment on-screen exams. Quality bar: as good as a strong revision-site (Revision Village / Dojo style) but entirely your own words. Never copy or closely paraphrase any real exam paper, textbook or website.

## What to produce
For every sub-topic you are assigned, one object:
{ "subject": "<slug>", "grade": 5, "topic": "<parent topic name>", "subTopic": "<sub-topic name>",
  "questions": [ { "content": "...", "options": ["A","B","C","D"], "answer": 0-3, "explanation": "...", "difficulty": "easy|medium|hard" } x18 ],
  "note": "...", "flashcards": [ { "front": "...", "back": "..." } x9 ] }
Use the EXACT topic and subTopic strings from the outline file (content/outlines/<subject>.json). One JSON file per parent topic, named `NN-<topic-slug>.json` where NN is the topic's 1-based index in the outline (zero padded), saved in content/<subject>-myp5/ . Each file is a JSON array of that topic's sub-topic objects, in outline order. Write the files with the Write tool (valid JSON, double quotes, no trailing commas, no comments).

## Questions (exactly 18 per sub-topic)
- Difficulty split exactly: 5 easy, 8 medium, 5 hard. Order them easy -> medium -> hard.
- Exactly 4 options, one clearly correct, three plausible distractors built from real misconceptions. `answer` is the 0-based index of the correct option. Do NOT use "all of the above"/"none of the above". Options must be distinct. Keep options short and parallel in style. Vary which position is correct (a script also rebalances positions).
- `explanation`: 1-3 sentences saying why the right answer is right and, where useful, why a tempting wrong one is wrong. This is shown to students after answering.
- Cover the whole sub-topic: recall, application, data/calculation, interpretation, and exam-style reasoning. Hard questions need multi-step thinking or a subtle misconception, not obscure trivia.
- Real-feeling stimulus: many questions should open with a short context (an experiment, a data set in plain text, a short extract, a scenario). Questions are plain text only: NO images, NO markdown, NO tables (write data as "x: 1, 2, 3" lines or sentences). Use Unicode for symbols (°C, ×, ÷, ², ³, √, π, ≤, ≥, →, CO₂, H₂O).
- Every calculation must be verified with python3 in the shell before you write it. Every fact must be correct. Wrong answers in a revision site are the worst failure.

## Study note (>= 450 words, aim 520-650)
Plain text with optional `## Heading` lines and `- bullet` lines (bold with **term**). Teach the sub-topic properly at MYP 5 depth: key ideas, definitions, worked example(s) where relevant, common mistakes, and finish with a line starting "Exam tip:". Written to a 15-year-old, clear and encouraging, no waffle.

## Flashcards (exactly 9)
Short front (a term, question or prompt), concise back (<= 280 characters), covering the most examinable facts/definitions/formulae of the sub-topic.

## HARD RULES
- MYP level ONLY. NEVER Diploma Programme / A-level / university content. Never write the strings "HL", "SL", "A-level", "Diploma Programme", "IB DP".
- Never write a "1-7" / "1 to 7" / "out of 7" range anywhere (the validator rejects it, even in maths like "numbers 1 to 7": rephrase). MYP achievement is Levels 1-8 per criterion; if you must mention levels say Levels 1-8.
- Names, places, dates and statistics must be accurate. Do not attribute invented quotations to real people or publications. Invented people/places/case studies are fine if they are plainly fictional.
- Do not mention Revision Village, Revision Dojo, or any real paper.
- Keep each file self-contained and valid JSON.

## Validate
When your files are written run:
  cd /home/claude/myp-revision- && node scripts/json-to-sql.mjs content/<subject>-myp5 > /dev/null
Fix every "INVALID <your file> > <sub-topic>: ..." message (the check covers counts, difficulty split, word count, duplicates, forbidden phrases). Ignore INVALID lines for other people's files (other writers work in the same folder at the same time). Exit code 0 means everything in the folder is valid; if other files are still being written you may see their errors only.
Then run a self-audit: re-read 6 random questions per sub-topic as a student would and re-verify the answer key.

## Reply format
Reply with only: files written (names), number of sub-topics, and the validator status for your files. No summaries of the content.
