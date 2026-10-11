# Spec for writing eAssessment-structure practice papers (MYP 5)

You are writing ORIGINAL exam-style papers that feel like the real MYP on-screen eAssessment. Never copy real IB papers, school papers, Revision Village/Dojo, or ExamPrep.World. Reference material about format only. Content must be MYP (never Diploma/A-level), accurate, and not "slop": real stimulus (passages, data tables with numbers, experiments, sources, transcripts), command terms (state, describe, explain, calculate, show that, justify, evaluate, discuss, outline, compare), a rising difficulty ladder, and marks that match the demand.

## File format
Write each paper as ONE json file in your staging folder (given in your brief): an array with one object:
{"subject":"<db slug>","grade":5,"format":"structured-mock","title":"<unique title ending with (N tasks, M marks)>","criterion":null,"questions":[{"position":1,"marks":N,"criterion":"A","content":"...","mark_scheme":"..."}, ...]}
Study these working examples first: content/papers-myp5/51-english-language-and-literature-structure-mock.json, 52-standard-mathematics-structure-mock.json, 53-..., 54-..., 55-extended-mathematics-structure-mock.json, 56-integrated-science-structure-mock.json.

Rules enforced by `node scripts/papers-to-sql.mjs <your folder>` (run it on your folder; fix until it prints SQL with no INVALID):
- 5 to 10 questions per paper (a "question" = one task with lettered parts (a),(b)... inside content). Total marks 60 to 130; each question 1 to 40 marks. Positions 1..n.
- content starts with a header line like [[Q 1 | A 4 | C 2]] (label | criterion marks) then text. Content must contain "(n marks)" for parts and a "Total for Question n: m marks" line.
- mark_scheme: every mark written as [1] so the [n] values SUM EXACTLY to the question's marks. Give acceptable answers, working, and level descriptors for extended writing (use "[3]" style chunks that sum correctly).
- criterion field is a single letter A-D (the main one).
- Never write a 1-7 scale ("1-7", "1 to 7", "out of 7") or the words Diploma Programme, A-level, IB DP, HL, SL.
- Do not include the text $mq$.
- Diagrams/graphs cannot be drawn: describe them precisely in words or give a table of values, and say "Diagram not to scale" where relevant. Use drop-down style items as "(select: same / different)".
- Check all arithmetic and facts yourself. Ambiguity and wrong mark schemes are the main failure.

## Criteria (MYP)
Maths A Knowing and understanding, B Investigating patterns, C Communicating, D Applying mathematics in real-life contexts. Sciences A Knowing and understanding, B Inquiring and designing, C Processing and evaluating, D Reflecting on the impacts of science. Language and literature A Analysing, B Organizing, C Producing text, D Using language. Individuals and societies A Knowing and understanding, B Investigating, C Communicating, D Thinking critically. Language acquisition: Listening, Reading, Writing objectives (use A Listening, B Reading, D Writing-style tags; map to criterion letters A, B, C as the existing papers do). Interdisciplinary: A Disciplinary grounding, B Synthesizing, C Communicating, D Reflecting.
Timing: on-screen exams run roughly 1h45 to 2h; Maths about 100 marks.
