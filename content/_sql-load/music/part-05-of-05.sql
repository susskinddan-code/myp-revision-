-- Part 5 of 5: 2 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Reflecting on Music > Evaluating Performances
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Reflecting on Music$mq$, 5, 5 from public.subjects s where s.slug = $mq$music$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Evaluating Performances$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$music$mq$ and p.grade = 5 and p.name = $mq$Reflecting on Music$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Evaluating Performances$mq$ and p.name = $mq$Reflecting on Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does it mean to evaluate a performance?$mq$, $mq$["To judge its quality using reasons and evidence","To describe the notes only","To copy it exactly","To perform it again"]$mq$, 0, $mq$Evaluating goes beyond description: it says how well something worked and why.$mq$, $mq$easy$mq$),
($mq$Which of these is something you can judge about a performance?$mq$, $mq$["The colour of the stage","The cost of the tickets","The weather outside","Accuracy of pitch and rhythm"]$mq$, 3, $mq$Pitch, rhythm, tone, expression and ensemble skill are musical features that can be evaluated.$mq$, $mq$easy$mq$),
($mq$Why should an evaluation include evidence?$mq$, $mq$["To make it longer","To avoid giving an opinion","To support each judgement with something that was heard","To hide mistakes"]$mq$, 2, $mq$Evidence such as 'the tempo stayed at 100 BPM' makes a judgement convincing.$mq$, $mq$easy$mq$),
($mq$Which sentence is a clear statement of a strength?$mq$, $mq$["It was okay","The tempo stayed steady all the way through","Some of it was there","I do not know"]$mq$, 1, $mq$A specific, musical strength names a feature and can be checked.$mq$, $mq$easy$mq$),
($mq$What does 'interpretation' mean for a performer?$mq$, $mq$["Their own approach to tempo, dynamics and phrasing","The date of the piece","The price of the music","The size of the room"]$mq$, 0, $mq$Two performers can play the same notes with different interpretations.$mq$, $mq$easy$mq$),
($mq$When you evaluate balance in an ensemble, what do you listen for?$mq$, $mq$["How many people are in the audience","How long the piece is","Which instrument is most expensive","Whether the melody is heard clearly over the accompaniment"]$mq$, 3, $mq$Balance means each part sits at an appropriate level, with the melody normally prominent.$mq$, $mq$medium$mq$),
($mq$Which is the most constructive piece of feedback?$mq$, $mq$["You were rubbish","It was fine","The tuning slipped in verse two; try tuning to the piano before you start","Try harder"]$mq$, 2, $mq$Constructive feedback is specific and includes a suggestion for improvement.$mq$, $mq$medium$mq$),
($mq$When comparing two performances, which linking words are best?$mq$, $mq$["Maybe, nothing, anyway","Whereas, in contrast, both","Louder, softer, quiet","First, last, only"]$mq$, 1, $mq$Comparative language shows how the performances are similar or different.$mq$, $mq$medium$mq$),
($mq$Which evidence best supports the claim that a performance was expressive?$mq$, $mq$["A wide dynamic range and shaped phrases","The notes were written clearly","The piece was long","The performer wore a suit"]$mq$, 0, $mq$Dynamics, phrasing and tone colour are evidence of expression.$mq$, $mq$medium$mq$),
($mq$How can the venue affect how a performance is judged?$mq$, $mq$["It cannot affect it","Only the audience size matters","Rooms never change sound","Acoustics and size change how loud and clear the music sounds"]$mq$, 3, $mq$A large, echoing hall may need slower tempo and clearer articulation than a small room.$mq$, $mq$medium$mq$),
($mq$Which of these is an objective statement about a performance?$mq$, $mq$["I loved the clarinet","The clarinet looked nice","The clarinet played 6 wrong notes in 32 bars","The piece was my favourite"]$mq$, 2, $mq$Objective statements can be checked against the score or recording, while enjoyment is personal (subjective).$mq$, $mq$medium$mq$),
($mq$Which statement is evidence of fluency?$mq$, $mq$["The soloist stopped four times","The soloist kept going smoothly through the fast run","The soloist changed the key","The soloist left the stage"]$mq$, 1, $mq$Fluent playing flows without stopping or hesitating.$mq$, $mq$medium$mq$),
($mq$A recorded studio performance can be edited, but a live performance cannot. How should this affect evaluation?$mq$, $mq$["Judge live performance on its flow and recovery, knowing it cannot be fixed afterwards","Ignore the difference","Give recordings lower marks","Assume live is always perfect"]$mq$, 0, $mq$The two contexts have different expectations, so evaluate fairly against the situation.$mq$, $mq$medium$mq$),
($mq$Performer A plays all the notes accurately but with flat dynamics. Performer B has a few wrong notes but shapes the phrases beautifully. Which comment is balanced?$mq$, $mq$["A is better because of accuracy","B is better because of expression","They are the same","A shows accuracy but needs more expression; B is expressive but needs more accuracy"]$mq$, 3, $mq$A balanced evaluation recognises each strength and each area for development.$mq$, $mq$hard$mq$),
($mq$Which revision best improves the comment 'It was boring'?$mq$, $mq$["It was bad","I did not like it much","The performance was at a constant mf, so it lacked contrast; adding crescendos would add interest","Boring because I am tired"]$mq$, 2, $mq$The improved comment names the element, gives evidence and suggests a fix.$mq$, $mq$hard$mq$),
($mq$A performer intended a calm lullaby but played at 140 BPM with sharp accents. How should you evaluate it?$mq$, $mq$["The performance matched perfectly","The tempo and articulation do not match the intended calm mood","The mood is irrelevant","The key was wrong"]$mq$, 1, $mq$Evaluation compares what was done with the intention. A calm lullaby needs a slow tempo and smooth articulation.$mq$, $mq$hard$mq$),
($mq$A performer plays 96 out of 120 notes correctly. What percentage of the notes were accurate?$mq$, $mq$["80%","96%","20%","75%"]$mq$, 0, $mq$96 ÷ 120 = 0.8, so 80%. The percentage of accurate notes is a measurable piece of evidence, though it does not judge expression.$mq$, $mq$hard$mq$),
($mq$Which approach makes an evaluation of a performance more reliable?$mq$, $mq$["Listen once with no notes","Rely only on a first impression","Ask only a friend","Use a recording, a checklist of criteria and more than one listener"]$mq$, 3, $mq$Repeated listening, clear criteria and several opinions reduce bias and help you notice detail.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Evaluating Performances$mq$ and p.name = $mq$Reflecting on Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Evaluate$mq$, $mq$Judge how well something worked, giving reasons and evidence.$mq$),
($mq$Describe vs evaluate$mq$, $mq$Describing says what happened. Evaluating says how successful it was and why.$mq$),
($mq$Objective vs subjective$mq$, $mq$Objective: can be checked (6 wrong notes). Subjective: personal opinion (I loved it).$mq$),
($mq$Interpretation$mq$, $mq$A performer's own approach to tempo, dynamics and phrasing.$mq$),
($mq$Parts of a good evaluation$mq$, $mq$Point, evidence, judgement, improvement; compared with the intention.$mq$),
($mq$Constructive feedback$mq$, $mq$Specific, kind and useful, with a suggestion for improvement.$mq$),
($mq$Evaluating balance$mq$, $mq$Is the melody heard clearly and are accompanying parts supporting at a suitable level?$mq$),
($mq$Accuracy percentage$mq$, $mq$Correct notes ÷ total notes × 100. 96 of 120 = 80%.$mq$),
($mq$Making evaluation reliable$mq$, $mq$Record it, listen more than once, use a checklist and ask more than one listener.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Evaluating Performances$mq$ and p.name = $mq$Reflecting on Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is evaluating?
To **evaluate** a performance is to make a judgement about how successful it was, supported by reasons and evidence. It is different from **describing**, which only says what happened. In Music you evaluate your own performances, your classmates' and professional recordings. Evaluating helps you improve and helps you understand the music more deeply.

## What to look for
Use a checklist so your evaluation covers the key areas:
- **Technical accuracy**: pitch (intonation), rhythm, tempo and fluency.
- **Tone quality** and control of the instrument or voice.
- **Expression and interpretation**: dynamics, phrasing, articulation and the performer's own approach to the piece.
- **Ensemble skills**: balance, blend, timing and communication.
- **Communication and presentation**: confidence, stage presence and connection with the audience.
- **Context**: the style, period or culture of the music and the venue, audience and purpose.

## Objective and subjective
**Objective** comments can be checked: 'there were six wrong notes in 32 bars'. **Subjective** comments are personal opinions: 'I enjoyed it'. A strong evaluation uses opinion but always backs it with objective evidence from the music.

## Structure of a good evaluation
Use **point, evidence, effect/judgement, improvement**. For example: 'The tempo was too fast in the lullaby (point). At 140 BPM the notes sounded rushed (evidence). This did not match the calm mood the performer wanted (judgement). Slowing to about 70 BPM with smoother articulation would fix it (improvement).' Always compare the result with the performer's **intention**.

## Giving feedback
Feedback should be **specific**, **kind** and **useful**. Name a strength first, then one or two areas for development, with a suggestion for each. Avoid vague words such as 'good', 'bad' or 'boring'. Instead name the musical element: 'the dynamics stayed the same, so the music lacked contrast'.

## Comparing performances
Use language such as 'whereas', 'in contrast', 'both' and 'similarly'. Compare the same features in each performance, for example tempo, tone, expression and ensemble. A balanced comparison recognises the strengths of both, such as one player with accurate notes and another with more expression.

## Using numbers
Sometimes you can count evidence. If a performer plays 96 of 120 notes correctly, the accuracy is 96 ÷ 120 = 80%. Numbers are useful, but they cannot judge expression, so combine them with listening comments.

## Making evaluation reliable
Record the performance, listen more than once, use a checklist and ask more than one listener. Remember that live and recorded music are judged differently: a live performance cannot be edited, so how a performer recovers from slips matters.

## Common mistakes
- Describing the music instead of judging it.
- Giving only opinions with no evidence.
- Ignoring the performer's intention or the context.
- Giving only negative feedback.

## How this is examined
You may be given a description of two performances and asked to pick the best evaluation, identify the vague comment, or rewrite a comment to include evidence and a suggestion. Look for the answer that is specific, balanced and linked to the intention.

Exam tip: Check each sentence in your evaluation for evidence. If it has no musical detail, rewrite it.$mq$ from st;

-- Reflecting on Music > Using the Music Criteria
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Reflecting on Music$mq$, 5, 5 from public.subjects s where s.slug = $mq$music$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Using the Music Criteria$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$music$mq$ and p.grade = 5 and p.name = $mq$Reflecting on Music$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Using the Music Criteria$mq$ and p.name = $mq$Reflecting on Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$How many assessment criteria are used in MYP Music?$mq$, $mq$["Four: A, B, C and D","Two","Six","Eight"]$mq$, 0, $mq$MYP arts subjects are assessed on four criteria: A, B, C and D.$mq$, $mq$easy$mq$),
($mq$What is criterion A in MYP Music?$mq$, $mq$["Developing skills","Thinking creatively","Responding","Knowing and understanding"]$mq$, 3, $mq$Criterion A is about knowledge of musical language, concepts and context.$mq$, $mq$easy$mq$),
($mq$What is criterion B in MYP Music?$mq$, $mq$["Knowing and understanding","Thinking creatively","Developing skills","Responding"]$mq$, 2, $mq$Criterion B covers acquiring and applying skills through performing and creating.$mq$, $mq$easy$mq$),
($mq$What is criterion C in MYP Music?$mq$, $mq$["Responding","Thinking creatively","Developing skills","Knowing and understanding"]$mq$, 1, $mq$Criterion C focuses on curiosity, exploring ideas and developing a clear artistic intention.$mq$, $mq$easy$mq$),
($mq$What is criterion D in MYP Music?$mq$, $mq$["Responding","Knowing and understanding","Developing skills","Thinking creatively"]$mq$, 0, $mq$Criterion D involves reflecting on, analysing and evaluating music and your own development.$mq$, $mq$easy$mq$),
($mq$What is the highest achievement Level available in each criterion?$mq$, $mq$["Level 7","Level 10","Level 4","Level 8"]$mq$, 3, $mq$Each MYP criterion is assessed on Levels 1–8.$mq$, $mq$medium$mq$),
($mq$Which descriptor goes with the top band of achievement levels (Levels 7-8)?$mq$, $mq$["Limited quality","Adequate quality","Excellent quality","Substantial quality"]$mq$, 2, $mq$The bands rise from limited (1-2), to adequate (3-4), substantial (5-6) and then excellent (7-8).$mq$, $mq$medium$mq$),
($mq$What is the maximum total across all four criteria?$mq$, $mq$["28","32","16","40"]$mq$, 1, $mq$Four criteria with a maximum Level 8 each give 4 × 8 = 32.$mq$, $mq$medium$mq$),
($mq$What does the command term 'analyse' ask you to do?$mq$, $mq$["Break something into parts and examine how they work together","Give a brief definition","Write your opinion only","List names"]$mq$, 0, $mq$Analysis examines the elements and relationships of the music, such as how rhythm and texture create a mood.$mq$, $mq$medium$mq$),
($mq$What does the command term 'evaluate' ask for?$mq$, $mq$["A list of facts","A copy of the score","A single word","A judgement of strengths and limitations with reasons"]$mq$, 3, $mq$To evaluate, you weigh up how well something works and support your view.$mq$, $mq$medium$mq$),
($mq$What does the command term 'justify' ask you to do?$mq$, $mq$["Name an instrument","Draw a diagram","Give valid reasons for a choice or conclusion","Write a story"]$mq$, 2, $mq$Justify means supporting a decision with evidence or reasoning.$mq$, $mq$medium$mq$),
($mq$Where in your ePortfolio would you show your development and decisions over time?$mq$, $mq$["Only in the final recording","In a process journal with rehearsal logs and reflections","Nowhere","In the title page"]$mq$, 1, $mq$A process journal shows your developing ideas, the problems you met and how you solved them.$mq$, $mq$medium$mq$),
($mq$Which evidence best fits criterion C?$mq$, $mq$["Experimenting with ideas and developing a clear artistic intention","A glossary of terms","A tuning chart","A list of instruments"]$mq$, 0, $mq$Criterion C rewards curiosity, exploration and purposeful development of ideas.$mq$, $mq$medium$mq$),
($mq$A student scores Level 5 in A, Level 6 in B, Level 4 in C and Level 7 in D. What is the total?$mq$, $mq$["21","23","18","22"]$mq$, 3, $mq$5 + 6 + 4 + 7 = 22 out of a possible 32.$mq$, $mq$hard$mq$),
($mq$A student submits an annotated analysis of a piece, using terms for rhythm, harmony and context. Which criterion does it most clearly address?$mq$, $mq$["B: developing skills","C: thinking creatively","A: knowing and understanding","D: nothing"]$mq$, 2, $mq$Using accurate musical language and knowledge of context shows knowing and understanding.$mq$, $mq$hard$mq$),
($mq$Which statement shows the strongest creative thinking?$mq$, $mq$["I just wrote a tune","I used a drone to show isolation, tested two timbres and revised because the first sounded too bright","I copied a song","I did what I was told"]$mq$, 1, $mq$The strongest statement shows an intention, experimentation and a reasoned revision.$mq$, $mq$hard$mq$),
($mq$A student wants to move up in criterion D. What should they add?$mq$, $mq$["Critical evaluation with specific evidence and its impact on the audience and own development","A longer list of facts","More descriptions of the steps","A new instrument"]$mq$, 0, $mq$Higher Levels in D need reasoned evaluation and reflection, not just description.$mq$, $mq$hard$mq$),
($mq$A student's rehearsal notes show a problem with rushing, three solutions tried and a recording showing improvement. Which criterion does this most directly support?$mq$, $mq$["A: knowing and understanding","D: nothing","None","B: developing skills"]$mq$, 3, $mq$This shows practising and applying skills to improve, which is the heart of developing skills.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Using the Music Criteria$mq$ and p.name = $mq$Reflecting on Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Criterion A$mq$, $mq$Knowing and understanding: musical language, concepts and context.$mq$),
($mq$Criterion B$mq$, $mq$Developing skills: acquiring and applying performing and creating skills.$mq$),
($mq$Criterion C$mq$, $mq$Thinking creatively: curiosity, exploring ideas, clear artistic intention.$mq$),
($mq$Criterion D$mq$, $mq$Responding: reflecting on, analysing and evaluating music and your own development.$mq$),
($mq$Levels in each criterion$mq$, $mq$Levels 1–8. Bands: 1–2 limited, 3–4 adequate, 5–6 substantial, 7–8 excellent.$mq$),
($mq$Maximum total$mq$, $mq$4 criteria × 8 = 32.$mq$),
($mq$Analyse vs evaluate$mq$, $mq$Analyse: break into parts and show relationships. Evaluate: judge strengths and limitations with reasons.$mq$),
($mq$Justify$mq$, $mq$Give valid reasons or evidence for a choice or conclusion.$mq$),
($mq$ePortfolio$mq$, $mq$Collected evidence over time: process journal, rehearsal logs, performances, compositions, reflections.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Using the Music Criteria$mq$ and p.name = $mq$Reflecting on Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The four criteria
In MYP Music, your work is assessed against four criteria. Each is marked on **Levels 1–8**, so the maximum for each criterion is 8, and the total across the four is 32. Your teacher decides your Levels using the published descriptors, which move from limited, to adequate, to substantial, to excellent quality as the Levels rise: Levels 1–2 are limited, 3–4 adequate, 5–6 substantial and 7–8 excellent.

- **Criterion A: Knowing and understanding.** Showing that you know the language of music (elements, notation, terms) and understand it in context (style, period, culture). Evidence: analysis, annotated scores, accurate use of vocabulary.
- **Criterion B: Developing skills.** Acquiring, practising and applying the skills of performing and creating. Evidence: rehearsal logs, performances, recordings and compositions that show improvement.
- **Criterion C: Thinking creatively.** Showing curiosity, exploring ideas, taking creative risks and developing a clear artistic intention. Evidence: sketches, drafts, experiments with sounds, reasons for creative decisions.
- **Criterion D: Responding.** Reflecting on, analysing and evaluating music, your own and other people's, and on your own development. Evidence: written or spoken evaluations, comparisons, links to context.

## Command terms
Command terms tell you what to do:
- **State / identify / list**: give brief answers.
- **Describe**: say what something is like.
- **Explain**: give reasons and show how.
- **Analyse**: break into parts and show how they work together.
- **Compare**: show similarities and differences.
- **Justify**: give valid reasons for a choice.
- **Evaluate**: judge strengths and limitations with reasons.

Aim to read the command term first, because it decides how deep your answer should be.

## Moving up the Levels
Low Levels show limited use of terms and little reflection. Middle Levels are accurate, but often describe. Higher Levels give **specific evidence**, **reasoned judgement**, **links to context** and **clear development of ideas**. Always show your thinking: why did you choose that tempo, that instrument or that structure?

## The ePortfolio
Your ePortfolio gathers evidence over time: performances, compositions, process journal, rehearsal logs, recordings and reflections. It is not only for the final product. Teachers look for **development**, so keep dated entries, annotated drafts and evaluations as you go. A tidy, well-labelled portfolio makes it easy for the evidence to be matched to the criteria.

## Working out totals
Add the Levels from the four criteria. For example Levels of 5, 6, 4 and 7 give a total of 22 out of 32. The total shows where you are strong and where to focus next.

## Common mistakes
- Treating the criteria as separate pieces of work; one task can give evidence for several criteria.
- Describing rather than evaluating in criterion D.
- Making a polished final product but keeping no evidence of development.
- Confusing criterion B (skills) with criterion C (creative thinking).

## How this is examined
Questions test whether you know what each criterion rewards, can match evidence to criteria, can interpret command terms and can compare statements for quality. You may be asked what a student should add to improve their work.

Exam tip: For each task, ask yourself which criterion it targets and what the descriptors for the next Level up require.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('music')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;