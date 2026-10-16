# MYP eAssessment format research (2026-10-16)

Scope: make `src/lib/eassessment.ts` match the real IB MYP on-screen eAssessment as far as public sources allow. No real exam content was read or copied. Where a source is a school-hosted copy of an IB document, or is dated (2014/2015), the wording on the site is cautious ("usually", "about").

## Sources

- IB, On-screen examinations: https://ibo.org/programmes/middle-years-programme/assessment-and-exams/onscreen-examinations/
- IB, Assessment and exams (MYP): https://ibo.org/programmes/middle-years-programme/assessment-and-exams/
- IB, MYP brief Mathematics: https://www.ibo.org/globalassets/new-structure/brochures-and-infographics/pdfs/myp-brief-mathematics-en.pdf
- IB, MYP brief Sciences: https://www.ibo.org/globalassets/new-structure/brochures-and-infographics/pdfs/myp-brief-sciences-en.pdf
- IB, MYP brief Interdisciplinary learning: https://www.ibo.org/globalassets/new-structure/brochures-and-infographics/pdfs/myp-brief-interdisciplinary-learning_en.pdf
- IB, MYP brief Awards: https://ibo.org/globalassets/new-structure/brochures-and-infographics/pdfs/1702-myp-brief-awards-en.pdf
- IB eAssessment factsheet (2014, dated, partly superseded): https://www-prod.ibo.org/globalassets/new-structure/programmes/myp/pdfs/myp-eassessment-factsheet-en.pdf
- MYP brief Language and literature (2015 copy hosted by a school): https://www.hwa.edu.sg/wp-content/uploads/2021/04/myp-brief_language-literature_2015.pdf
- MYP brief Individuals and societies (2015 copy, school-hosted): https://www.hwa.edu.sg/wp-content/uploads/2021/04/myp-brief_individuals-societies_2015.pdf
- MYP brief Language acquisition (2020 copy, school-hosted): https://www.woodstockschool.in/wp-content/uploads/2021/07/myp-brief-language-acquisition-2020-en.pdf
- A school's eAssessment page (results dates, 1-7 reporting): https://isa.edu.gr/files/476/MYP_IB/eAssessment_.pdf

Not fetched: the IB's own current L&L, I&S and Language acquisition brief PDFs (fetch was blocked), so those three areas rely on school-hosted copies of IB briefs. Re-check against the current ibo.org versions when possible. revisiondojo.com blog pages appeared in search but were not used (third-party, unreliable).

## Facts that apply to every area

- On-screen exams are external, taken in the final MYP year, marked by trained IB examiners. IB page: "2-hour end-of-term exams"; the Assessment and exams page says "between one hour and 45 minutes and two hours". Verified.
- Sessions run once a year, in May or November. Verified (IB On-screen page). Exact dates are set by the IB.
- Exams are "a series of tasks that sample, simulate or replicate" school-based assessment; about 75% targets inquiry, communication and critical thinking rather than recall. Verified.
- Screen features listed by the IB: drag and drop, cut/copy/paste, play/pause/replay for video and animation, interaction with animations and simulations, plotting graphs and drawing lines/pictures, on-screen (graphing) calculator(s), hover-text for difficult words. Accessibility: font and background colour changes, extra time, pauses. Verified (IB On-screen page). The page does not say which features appear in which subject, and does not mention a formula sheet or a plain text box.
- Reporting: each subject result is on a seven-point scale (1-7); boundaries are set per session and, for on-screen exams, are based on marks. Verified (Awards brief). Criteria have eight levels (1-8) in the internal model. I could NOT verify that the on-screen result is published with criterion levels, so the site does not claim that. Certificate: validated grade of at least 3 in each of seven components and at least 28 of 56 points. Verified (Awards brief). Results release dates 1 August (May session) and 1 February (November session) come from one school's page only: unverified, not used on the site.
- Arts, Design and PHE are ePortfolio-assessed, not on-screen. Verified. Language acquisition has an on-screen exam plus an internally assessed speaking task (IB On-screen page). The 2014 factsheet says Language acquisition is an ePortfolio; that is superseded.
- On-screen exams are offered in specific courses: Language and literature, Language acquisition (capable and proficient levels only), History, Geography, Integrated humanities, Mathematics, Extended mathematics, Biology, Chemistry, Physics, Integrated sciences, Interdisciplinary learning. Environmental systems is not listed (see gaps).

## Per area

### Language & Literature
- Duration: 2 hours (2015 brief copy; IB On-screen page). Site: 120 min (unchanged).
- Tasks: two. (1) Analysis of two text extracts, compare and contrast, 50 marks, criteria A, B, D. (2) Creative writing, 70 marks, criteria C, D (B for organisation). Total 120. Source is the 2015 brief, so the site says "usually".
- Criteria: A Analysing, B Organizing, C Producing text, D Using language.
- Site now says: 2-hour, two tasks (analysis then longer creative writing), the four criteria, typed answers.
- Gaps: site's L&L questions are mostly short-answer style; the real exam has a 70-mark extended creative writing task and a two-extract comparison. We do not show two extracts side by side, and no creative-writing-with-audience task. French/Spanish L&L exams exist in the real list.

### Individuals & Societies
- Duration: 2 hours.
- Tasks (2015 brief copy): Engagement with sources 30 marks (A, D); Investigation with structured questions 30 marks (B, C); Extended response 60 marks (A-D). Rich-media sources. Subjects: History, Geography, Integrated humanities. Economics is NOT in the IB on-screen list.
- Criteria: A Knowing and understanding, B Investigating, C Communicating, D Thinking critically.
- Site now says: three tasks, source evaluation (origin, purpose, value, limitations), extended response worth most marks, with "usually".
- Gaps: Economics is on the site as an area subject but has no IB on-screen course. Real source sets combine 4-5 mixed-media sources (text, speech, graphic, photograph); site papers mostly use text stems. Extended response of 60 marks is not mirrored in length.

### Sciences
- Duration: 2 hours (IB Sciences brief).
- Tasks: Knowing and understanding (A) 25 marks; Investigation skills (B and C) 50 marks; Applying science (D) 25 marks; total 100. Investigation tasks use one investigation or several scenarios: hypotheses, plan, collect/present/interpret/evaluate data.
- Criteria: A Knowing and understanding, B Inquiring and designing, C Processing and evaluating, D Reflecting on the impacts of science. The old site text omitted D.
- Site now says: three tasks with approximate mark shares, four criteria including D.
- Gaps: Environmental systems has no IB on-screen course (the IB lists Biology, Chemistry, Physics, Integrated sciences). Real investigations are simulation/data driven with interactive plotting; the site has widget papers only partially. The IB brief does not say whether a formula sheet or calculator is provided in sciences. The site's exam-mode formula sheet is therefore unverified (see UI suggestions).

### Mathematics
- Duration: 2 hours (IB Mathematics brief refers to "2 hour on-screen examinations").
- Tasks: three, each 31-35 marks. Knowing and understanding (A, C); Investigating patterns (B, C); Applying mathematics in real-life contexts (C, D), possibly with extended writing to justify models. All four branches may appear. Criterion C is spread across all tasks (25 marks).
- Criteria: A Knowing and understanding, B Investigating patterns, C Communicating, D Applying mathematics in real-life contexts.
- Tools: IB On-screen page lists on-screen graphing calculator(s) as a screen feature generally. The maths brief does not mention calculators or a formula sheet. Site wording: "The IB lists an on-screen graphing calculator among the exam tools" (true) and does not claim a formula sheet.
- Gaps: the site gives no on-screen graphing calculator. The three-task structure (an investigation task, a modelling task with written justification) is only approximated by stored papers.

### Language Acquisition
- Duration: the IB gives a range of 1 h 45 to 2 h for on-screen exams and "2-hour" elsewhere; no Language-acquisition-specific figure was found. Site changed from 105 to 120 (upper bound). If a current IB source confirms 105 for Language acquisition, revert `minutes` to 105 and update the four places listed below.
- Tasks (2020 brief copy): listening to spoken multimodal texts (A, 32 marks), reading multimodal texts (B, 32), writing in response to multimodal texts (D, 32). Speaking (C, 32) is a separate interactive task marked by the teacher and moderated by the IB. On-screen exams are offered at capable and proficient levels only (not emergent).
- Site now says: up to 2 hours with the IB range, three on-screen tasks, speaking separate, criteria A, B, D on screen and C speaking.
- Gaps: the site has no listening audio tasks and cannot play multimodal texts; listening is a third of the on-screen marks. Site slugs use "ab initio" (a Diploma Programme term). MYP uses emergent/capable/proficient phases. Slugs were left unchanged as instructed. Real exam languages listed: Arabic, Mandarin, Dutch, English, French, German, Hindi, Spanish, Urdu; the site covers French, Spanish, Mandarin.

### Interdisciplinary Learning
- Duration: 2 hours.
- Tasks (IB brief): two. Task 1 Evaluating (A), or A and Reflecting (C); Task 2 Synthesizing (B), or B and C. Stimulus: infographics, data, videos, articles. Two disciplines chosen from Language and literature, Individuals and societies, Mathematics, Sciences. Criteria A Evaluating, B Synthesizing, C Reflecting (three criteria, not four). Reported separately from subject grades; the only exam assessing interdisciplinary understanding. Mark split reported as 24/12 or 12/24 (36 total) but the table was unclear: not used on the site.
- Site now says: two tasks, stimulus types, the three criteria, separate reporting. The old text "from two subject groups" is retained in the blurb.
- Gaps: site has no choose-two-disciplines mechanic and no multimedia stimulus; the three-criteria scale differs from the four-criteria shape the rest of the site assumes (see UI suggestions).

## What the site now says, in short

Durations are now 120 for all six areas (Language Acquisition was 105). `looksLike` and `blurb` in each area now name the real task structure and criteria; the criteria for Sciences now include D, and Interdisciplinary lists three criteria. Tip texts updated: pace guide (1 to 1.25 minutes/mark, flagged as a guide) and a list of the on-screen tools the IB names. Code comments no longer claim IB fixed durations or a fixed 1 May date, and note that boundaries come from marks each session.

## Practice gaps (real exam vs site)

1. No listening/audio tasks (about a third of Language acquisition on-screen marks).
2. No on-screen graphing calculator for Maths; no drawing tool in general; plotting only in widget papers.
3. Source-based I&S tasks: not multi-source rich-media sets; no video/animation/simulation stimulus anywhere.
4. L&L: no two-extract side-by-side view; creative writing task (70 of 120 marks) is much longer than site writing tasks.
5. Interdisciplinary: no two-discipline choice and no stimulus bundle.
6. Grade estimate uses the internal 32-point conversion (`BOUNDARIES` in eassessment.ts); the IB sets on-screen boundaries from raw marks each session, so the 1-7 shown is only a guide. Wording already says so; keep the label.
7. Economics and Environmental systems are listed under areas but have no IB on-screen course. Students still can practise them but the site should not imply they are examined on screen.
8. Formula sheet: the site's exam-mode formula sheet is not confirmed by any IB source. Tool list does not mention one.
9. Accessibility: IB allows extra time, pauses, font and background changes; the site offers none of these in exam mode.

## UI suggestions (not applied; outside the files I own)

- `src/routes/eassessment/$area.tsx:999`: label `"Full length · 105 min"` with `m: 105`. Change to `{ m: 120, l: "Full length · 120 min" }` so the full-paper option matches `area.minutes`.
- `src/routes/eassessment/$area.tsx:1181`: length options `[30, 60, 90, 105]`. Change to `[30, 60, 90, 120]`.
- `src/routes/eassessment/$area.tsx:129`: `{formatDuration(area.minutes)} · on screen · MYP 5`. Suggest `... · on screen · final MYP year`, and for `language-acquisition` append `· speaking assessed separately`.
- `src/routes/_authenticated/dashboard.tsx:241`: `{daysToMaySession()} days to 1 May`. Suggest `days to the May window` (sessions are May or November and the IB sets the date).
- Where `formulaSheetFor(areaKey)` feeds the exam panel (`$area.tsx:674, 690, 981, 1147`; displayed in `PaperRunner.tsx`): label the sheet "Revision aid: the IB has not published a formula sheet for this exam" or make it opt-in.
- Anywhere an area page shows criteria letters, handle Interdisciplinary as three criteria (A Evaluating, B Synthesizing, C Reflecting) and Language acquisition as A Listening, B Reading, C Speaking, D Writing.
- Optional: on the Economics and Environmental systems subject cards in the area picker, add a small note "No IB on-screen course; practise as revision for your Individuals & societies / Sciences exam".
- The result display (wherever `describeResult` is rendered) should keep both scales labelled: "Criterion level (1-8)" and "Estimated course grade (1-7), guide only".
