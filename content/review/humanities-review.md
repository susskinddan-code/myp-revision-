# Humanities accuracy review (third independent pass)

Scope: content/history-myp5, geography-myp5, economics-myp5, interdisciplinary-learning-myp5, content/gap/history, content/gap/geography, and the 24 history/geography/economics papers in content/papers-myp5 (07-09, 17-19, 25-27, 67-72, 123-131).
Earlier passes: content/review/humanities-fixes.sql (15 edits) and content/fixes/humanities-fixes.sql are already applied in the working tree; this pass adds the block at the end of content/review/humanities-fixes.sql.

## Method
Every MCQ key and distractor, flashcard, note, explanation and mark scheme was read. Economics and geography calculations were recomputed in python3. Scripts checked paper [n] mark sums (0 mismatches) and banned strings (no 1-7, A-level or DP wording). Interdisciplinary criteria A-D and Levels 1-8 confirmed.

## Errors fixed (all low severity; no wrong MCQ keys found)
1. history-myp5/06 Fascism and Nazism, note. Before: "By 1925-26 Mussolini ruled as Il Duce: ... a secret police (OVRA) operated". After: "By 1926 ... (OVRA, set up in 1927) operated". Parties were banned in 1926, OVRA founded 1927.
2. history-myp5/06 Fascism and Nazism, Q8 explanation. Before: "By 1925-26 he had banned opposition parties, censored newspapers and used secret police such as the OVRA." After: "By 1926 he had banned opposition parties and censored newspapers, and from 1927 he used secret police such as the OVRA."
3. gap/history/06 Superpower Rivalry and Regional Blocs, Q11. "How many countries joined after 1957?" was ambiguous (six founders; later enlargements include the UK leaving). Now "How many more members did the EU have in 2020 than the six founding members?" Key (21) unchanged.
4. papers-myp5/128-s6-geography-C Q4(c) mark scheme: "= 8 + 1 = 9" (confusing, implied 8) changed to "= 9".
5. papers-myp5/70-geography-structure-mock-b Q4(e): "renewable output must increase from 36 PJ to 420 PJ" changed to "wind and solar output ..." (36 PJ is the wind and solar figure, not all renewables).
6. papers-myp5/70 Q7 indicative content: garbled "remaining 30 million gap would be exceeded within about two years" changed to "the remaining gap would more than double within about two years (30 + 2 x 23 = 76 million cubic metres)".

Validation: json-to-sql.mjs passes for history-myp5 and gap/history; papers-to-sql.mjs passes for papers-myp5. Edited JSON still parses.

## Hedges, left unchanged
- history 11 Q9: Armenian genocide "more than one million" deaths (commonly cited range 1 to 1.5 million; acceptable).
- history 04: "bleed France white" attributed to Falkenhayn's Verdun strategy comes from his disputed post-war memoir; taught as intent, not a verified quotation.
- economics 07 Q16: a distractor is worded loosely but is not correct.
- paper 123 Q3(c): "revenue changes only a little" while revenue falls 6.25 per cent; marginal, accepted as indicative wording.

## Could not be verified
- Both-scale labelling (Levels 1-8 criterion plus 1-7 eAssessment grade) is rendered by src/ app code, not the JSON; not checked.
- Real-world statistics were checked against model knowledge only (no live sources). Many paper sources are imagined and labelled as such.
- Fixes not applied to the database (instructed not to touch it); Dan runs the SQL.
