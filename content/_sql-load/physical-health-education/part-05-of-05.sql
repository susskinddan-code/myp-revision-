-- Part 5 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Planning and Reflecting > Setting and Reviewing Goals
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Planning and Reflecting$mq$, 5, 5 from public.subjects s where s.slug = $mq$physical-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Setting and Reviewing Goals$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-health-education$mq$ and p.grade = 5 and p.name = $mq$Planning and Reflecting$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Setting and Reviewing Goals$mq$ and p.name = $mq$Planning and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does the 'S' in SMART goals stand for?$mq$, $mq$["Specific","Simple","Social","Strong"]$mq$, 0, $mq$A specific goal is clear and detailed about what exactly you want to achieve.$mq$, $mq$easy$mq$),
($mq$Which goal is a short-term goal?$mq$, $mq$["Win a national title in five years","Make a professional team in ten years","Be healthy for life","Improve my 1 km run time this month"]$mq$, 3, $mq$Short-term goals are achieved in days or weeks and are steps towards long-term goals.$mq$, $mq$easy$mq$),
($mq$The 'M' in SMART stands for$mq$, $mq$["Motivating","Massive","Measurable","Medium"]$mq$, 2, $mq$A measurable goal includes a number or clear way to check progress.$mq$, $mq$easy$mq$),
($mq$Which of these is a long-term goal?$mq$, $mq$["Do 10 sit-ups tonight","Complete a 10 km run by the end of the year","Stretch for five minutes tomorrow","Drink water at lunch"]$mq$, 1, $mq$Long-term goals take months or years and are usually broken into shorter steps.$mq$, $mq$easy$mq$),
($mq$Why should goals be reviewed regularly?$mq$, $mq$["To check progress and adjust the plan if needed","To make goals impossible","To avoid training","To compare with others only"]$mq$, 0, $mq$Reviewing shows what is working, what is not, and whether the goal needs changing.$mq$, $mq$easy$mq$),
($mq$Which goal is best written as a SMART goal?$mq$, $mq$["Get more flexible","Be the best","Stretch sometimes","Increase my sit-and-reach score by 3 cm in six weeks by stretching three times a week"]$mq$, 3, $mq$It is specific, measurable, achievable, relevant and time-bound. The others lack numbers or deadlines.$mq$, $mq$medium$mq$),
($mq$A student sets the goal 'Run 5 km in 10 minutes by next week' with a current best of 28 minutes. Which SMART element is mainly missing?$mq$, $mq$["Specific","Measurable","Achievable","Time-bound"]$mq$, 2, $mq$The goal is clear, measured and timed, but is not realistic for the current ability.$mq$, $mq$medium$mq$),
($mq$An outcome goal is$mq$, $mq$["a goal about technique only","a goal focused on the end result, such as winning a race","a daily routine","a warm-up"]$mq$, 1, $mq$Outcome goals focus on results. Performance goals focus on personal standards. Process goals focus on actions.$mq$, $mq$medium$mq$),
($mq$Which is an example of a process goal for a basketball shooter?$mq$, $mq$["Keep my elbow under the ball on every free throw","Win the league","Score 20 points","Be selected for the team"]$mq$, 0, $mq$A process goal focuses on the technique or actions that lead to success.$mq$, $mq$medium$mq$),
($mq$A student plans to raise her number of push-ups in one minute from 15 to 24. What is the target increase?$mq$, $mq$["39","15","24","9"]$mq$, 3, $mq$24 − 15 = 9. Adding the numbers (39) would not be the increase.$mq$, $mq$medium$mq$),
($mq$Which feature would make a goal 'time-bound'?$mq$, $mq$["A measurement","A clear description","A date by which it will be achieved","A plan for resources"]$mq$, 2, $mq$A time-bound goal has a deadline or time frame, such as 'in eight weeks'.$mq$, $mq$medium$mq$),
($mq$After four weeks, a student finds she has met 2 of her 4 weekly training targets. Which is the best response?$mq$, $mq$["Abandon all goals","Review barriers such as time and adjust the plan","Ignore the results","Double the targets next week"]$mq$, 1, $mq$Reviewing barriers and adjusting the plan is realistic and supports progress.$mq$, $mq$medium$mq$),
($mq$A swimmer's goal is to cut her 50 m time from 40 s to 36 s in 8 weeks. By what percentage does she plan to improve?$mq$, $mq$["10%","4%","11%","90%"]$mq$, 0, $mq$The reduction is 4 s, and 4 ÷ 40 = 0.1, which is 10%. Using 36 as the base gives 11%, which is incorrect.$mq$, $mq$medium$mq$),
($mq$Why is it useful to have short-term goals as steps towards a long-term goal?$mq$, $mq$["They replace the long-term goal","They make the plan less specific","They remove the need to review","They show progress and keep motivation"]$mq$, 3, $mq$Smaller steps are easier to track and give regular successes.$mq$, $mq$hard$mq$),
($mq$A runner's log: Week 1 5 km in 32 min; Week 4 5 km in 30 min; Week 8 5 km in 29 min. Her goal was 27 min by week 8. Which conclusion is best?$mq$, $mq$["She exceeded the goal","She made no progress","She improved but did not reach the goal, so she should review training and barriers","The goal cannot be reviewed"]$mq$, 2, $mq$She improved by 3 min in total but is 2 min above the goal. A review should look at causes and set a revised target.$mq$, $mq$hard$mq$),
($mq$A student's goal is to 'be fitter'. Which revision would make it most useful for planning?$mq$, $mq$["Try to be better","Improve my 12-minute run distance by 200 m in eight weeks with three runs a week","Exercise more when possible","Be as fit as a professional"]$mq$, 1, $mq$The revised goal is specific, measurable, time-bound and linked to a plan.$mq$, $mq$hard$mq$),
($mq$A student misses their goal because of an exam period. Which action best shows effective goal setting?$mq$, $mq$["Adjust the timeline, keep a smaller routine and re-set the target","Cancel all training","Ignore the goal","Claim the goal was never important"]$mq$, 0, $mq$Goals should be flexible. Adjusting for real constraints is better than giving up.$mq$, $mq$hard$mq$),
($mq$Which approach gives the most reliable evidence for reviewing a fitness goal?$mq$, $mq$["Guessing how you feel","Comparing different tests","Using different equipment each time","Retesting under the same conditions and comparing with the baseline"]$mq$, 3, $mq$Retesting with the same method gives a fair comparison with the starting results.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Setting and Reviewing Goals$mq$ and p.name = $mq$Planning and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$What do the letters in SMART stand for?$mq$, $mq$Specific, Measurable, Achievable, Relevant, Time-bound.$mq$),
($mq$Short-term versus long-term goals$mq$, $mq$Short-term goals take days or weeks. Long-term goals take months or years. Short-term goals act as steps towards long-term ones.$mq$),
($mq$Outcome, performance and process goals$mq$, $mq$Outcome: a result (winning). Performance: a personal standard (a personal best). Process: actions or technique (keeping elbow tucked in).$mq$),
($mq$What is a baseline?$mq$, $mq$Your starting measurement before training, used to compare later results and see progress.$mq$),
($mq$Why review goals?$mq$, $mq$To check progress, find what helped or hindered, and adjust the plan or target if needed.$mq$),
($mq$Give an example of a barrier to training$mq$, $mq$Lack of time, weather, equipment, injury or motivation. Good plans include solutions to barriers.$mq$),
($mq$Why should goals be achievable?$mq$, $mq$Goals that are far beyond current ability are demotivating. Challenging but realistic goals keep motivation.$mq$),
($mq$Percentage change formula$mq$, $mq$(change ÷ starting value) × 100. Example: 40 s to 36 s is 4 ÷ 40 × 100 = 10% improvement.$mq$),
($mq$Why is retesting under the same conditions important?$mq$, $mq$It makes the comparison fair and valid, so changes can be linked to training rather than different conditions.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Setting and Reviewing Goals$mq$ and p.name = $mq$Planning and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$A goal is something you want to achieve. Setting goals gives your training direction and motivation, and reviewing them shows whether your plan is working. Good PHE planning always links goals, actions and evidence.

## Types of goals
- **Short-term goals** take days or weeks, for example "complete three training sessions this week".
- **Long-term goals** take months or years, for example "run a 10 km race by June".
- **Outcome goals** focus on a result (winning, finishing in the top three).
- **Performance goals** focus on your own standard (a personal best time).
- **Process goals** focus on actions and technique (keeping your head still when you swing).

Using short-term goals as steps towards a long-term goal makes the big target feel manageable. Process and performance goals are fully within your control, while outcome goals depend on other people as well.

## SMART goals
A strong goal is SMART:
- **S**pecific: exactly what you will do.
- **M**easurable: numbers or evidence to check progress.
- **A**chievable: challenging but realistic for your current level.
- **R**elevant: connected to your sport, needs or interests.
- **T**ime-bound: a clear deadline.

Weak: "Get fitter." SMART: "Increase my distance in a 12-minute run by 200 m in eight weeks by running three times a week."

## Planning to reach a goal
- Test your starting point (a **baseline**).
- Choose training methods and decide how often to train.
- Think about barriers such as time, weather, equipment or motivation, and plan solutions.
- Ask for support from a coach, teacher, friend or family member.
- Decide when and how you will check progress.

## Reviewing goals
Review at planned points and compare current results with your baseline and target. Ask:
- Did I meet the goal? How close was I?
- What helped me? What got in the way?
- Does the goal need changing: harder, easier, or a new deadline?

Worked example: a swimmer aims to improve her 50 m time from 40 s to 36 s in eight weeks. Planned improvement = 40 − 36 = 4 s. As a percentage of the starting time, 4 ÷ 40 × 100 = 10%. If she reaches 38 s, she has improved by 2 s (5%), which is partial success; she should then review training frequency and technique.

## Common mistakes
- Writing goals with no numbers or deadline.
- Setting goals so hard that they cannot be reached, or so easy that they do not challenge you.
- Never reviewing, or abandoning goals the first time they are missed.
- Calculating percentage change against the wrong value; use the starting value.

## How this is examined
You may be given a short profile of a student with test results and asked to write SMART goals, suggest short-term steps, or review progress using data and recommend changes. Command terms such as outline, justify and evaluate decide how much explanation is needed.

Exam tip: Quote the numbers from the data in your review and always end with a specific next step, such as a revised target or training change.$mq$ from st;

-- Planning and Reflecting > Analysing Performance
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Planning and Reflecting$mq$, 5, 5 from public.subjects s where s.slug = $mq$physical-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Analysing Performance$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-health-education$mq$ and p.grade = 5 and p.name = $mq$Planning and Reflecting$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Analysing Performance$mq$ and p.name = $mq$Planning and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Performance analysis involves$mq$, $mq$["collecting information about a performance and identifying strengths and weaknesses","only watching the final score","copying another athlete","avoiding feedback"]$mq$, 0, $mq$Analysis uses evidence to understand what went well and what needs improvement.$mq$, $mq$easy$mq$),
($mq$Which of these is quantitative data?$mq$, $mq$["The performance looked confident","The player seemed tired","The team spirit was good","Number of successful passes: 12"]$mq$, 3, $mq$Quantitative data is numerical. Qualitative data is descriptive.$mq$, $mq$easy$mq$),
($mq$Which of these is qualitative data?$mq$, $mq$["Sprint time of 5.2 s","42 shots taken","The player's technique looked smooth but lacked power","Heart rate of 150 bpm"]$mq$, 2, $mq$Qualitative data uses descriptions and observations rather than numbers.$mq$, $mq$easy$mq$),
($mq$A tool used to record how often skills happen in a game is$mq$, $mq$["a trophy","an observation checklist or tally chart","a rule book","a warm-up"]$mq$, 1, $mq$Checklists and tallies record frequencies of actions, giving data to analyse.$mq$, $mq$easy$mq$),
($mq$What is a 'strength' in performance analysis?$mq$, $mq$["Something done well","A mistake","A rule","A type of fitness test"]$mq$, 0, $mq$Strengths are positive aspects. Weaknesses are areas that need improvement.$mq$, $mq$easy$mq$),
($mq$A coach films a performance and watches it back in slow motion. What is the main benefit?$mq$, $mq$["The result changes","Fitness improves immediately","The rules change","Details of technique can be seen more clearly"]$mq$, 3, $mq$Video lets you pause, replay and compare technique with a model.$mq$, $mq$medium$mq$),
($mq$A basketball player takes 20 shots and scores 9. What is the shooting accuracy?$mq$, $mq$["55%","9%","45%","20%"]$mq$, 2, $mq$9 ÷ 20 = 0.45, which is 45%.$mq$, $mq$medium$mq$),
($mq$Which is a good way to make performance data reliable?$mq$, $mq$["Change the test every time","Use the same method and conditions each time","Record only the best attempt","Use guesswork"]$mq$, 1, $mq$Consistent methods make results repeatable and comparable.$mq$, $mq$medium$mq$),
($mq$A student compares their technique with an expert model and finds that their knee bends less on landing. This identifies$mq$, $mq$["a weakness in technique","a rule infringement","a strength in fitness","a fair play issue"]$mq$, 0, $mq$The difference from the model shows an area to improve, in this case landing technique.$mq$, $mq$medium$mq$),
($mq$Heart rate after a 6-minute run is 172 bpm in week 1 and 160 bpm in week 8 for the same run. What does this suggest?$mq$, $mq$["Fitness has decreased","The test is not valid at all","Strength has increased","Cardiovascular fitness has probably improved"]$mq$, 3, $mq$A lower heart rate for the same effort suggests the heart works more efficiently.$mq$, $mq$medium$mq$),
($mq$A tally shows a footballer made 24 passes: 18 forward and 6 backward, with 15 of the forward passes successful. What is the forward pass success rate?$mq$, $mq$["62.5%","75%","83%","15%"]$mq$, 2, $mq$15 ÷ 18 = 0.833, which is about 83%. Dividing by 24 (62.5%) mixes up the total passes with forward passes.$mq$, $mq$medium$mq$),
($mq$Why is it useful to compare current data with earlier data?$mq$, $mq$["It proves other people are worse","It shows progress or decline over time","It removes the need for goals","It makes data qualitative"]$mq$, 1, $mq$Comparing with a baseline shows change and helps judge the effect of training.$mq$, $mq$medium$mq$),
($mq$Which statement describes a 'weakness' with a cause?$mq$, $mq$["Her serve fails often because her toss is inconsistent","Her serve is perfect","She enjoys tennis","She plays on Saturdays"]$mq$, 0, $mq$Linking a weakness to a likely cause makes improvement targets more specific.$mq$, $mq$medium$mq$),
($mq$A coach sees that a player's accuracy drops from 70% in the first half to 45% in the second half. Which cause is most likely worth investigating first?$mq$, $mq$["The colour of the kit","The length of the game programme","The weather forecast for next week","Fatigue"]$mq$, 3, $mq$A drop late in a game often points to tiredness. The other factors are not logical causes.$mq$, $mq$hard$mq$),
($mq$Two observers record the same match. One counts 14 tackles and the other 22. What does this suggest?$mq$, $mq$["Both are certainly correct","The match was cancelled","The method may be unreliable and needs clearer definitions","Tackles cannot be counted"]$mq$, 2, $mq$A big difference between observers suggests unclear criteria. Agreeing on definitions improves reliability.$mq$, $mq$hard$mq$),
($mq$A player's sprint times over 30 m are 5.2, 5.1, 5.3, 5.0 and 5.1 s. What is the mean time?$mq$, $mq$["5.2 s","5.14 s","25.7 s","5.0 s"]$mq$, 1, $mq$The total is 25.7 s, and 25.7 ÷ 5 = 5.14 s. 25.7 is the sum, not the mean.$mq$, $mq$hard$mq$),
($mq$Which conclusion is best supported by this data? 'Week 1: 8 of 20 free throws scored. Week 6: 13 of 20 scored.'$mq$, $mq$["Free-throw accuracy increased from 40% to 65%","Accuracy fell","Accuracy stayed the same","The player is now perfect"]$mq$, 0, $mq$8 ÷ 20 = 40% and 13 ÷ 20 = 65%. The increase is 25 percentage points.$mq$, $mq$hard$mq$),
($mq$After analysis, which next step shows the best use of results?$mq$, $mq$["Ignore the results","Change sport","Wait without acting","Set a specific improvement target and plan practices to address the weakness"]$mq$, 3, $mq$Analysis only helps if it leads to action: targets, practices and a later review.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Analysing Performance$mq$ and p.name = $mq$Planning and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Quantitative versus qualitative data$mq$, $mq$Quantitative data is numerical (times, scores, percentages). Qualitative data is descriptive (how a technique looked or felt).$mq$),
($mq$Name three ways to collect performance data$mq$, $mq$Observation checklists or tally charts, video analysis, fitness tests, peer or coach feedback and self-assessment diaries.$mq$),
($mq$What is validity?$mq$, $mq$Whether a test or method actually measures what it is meant to measure.$mq$),
($mq$What is reliability?$mq$, $mq$Whether repeating the test under the same conditions gives similar results.$mq$),
($mq$Percentage accuracy$mq$, $mq$Successes ÷ attempts × 100. Example: 9 scored from 20 attempts is 45%.$mq$),
($mq$Mean (average) formula$mq$, $mq$Add all the results and divide by the number of results.$mq$),
($mq$Why compare with a model performance?$mq$, $mq$It shows differences between your technique and good technique, so specific weaknesses can be found.$mq$),
($mq$How to write a useful weakness$mq$, $mq$State what is weak, support it with evidence and give a reason, for example inconsistent toss causing missed serves.$mq$),
($mq$What should follow analysis?$mq$, $mq$Set specific targets, choose practices to address weaknesses, and review again to check improvement.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Analysing Performance$mq$ and p.name = $mq$Planning and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Analysing performance means collecting information about how you or others performed, working out what went well and what needs improving, and using the results to plan the next steps. In the PHE criteria this links strongly to reflecting and improving performance.

## Collecting information
- **Quantitative data** is numerical: scores, times, distances, heart rate, number of passes, percentage accuracy.
- **Qualitative data** is descriptive: how technique looked, how confident someone seemed, how the team communicated.
Good analysis uses both. Methods include:
- observation checklists and tally charts;
- video recording and slow-motion playback;
- fitness tests (such as a 12-minute run, a sit-and-reach test or a press-up count);
- peer or coach feedback;
- self-assessment and a training diary;
- comparison with a model performance or expert demonstration.

## Making data trustworthy
- **Validity**: does the test measure what it is supposed to measure?
- **Reliability**: would you get similar results if repeated under the same conditions?
To improve both, use the same method, equipment, surface, time of day and warm-up, define clearly what counts as a pass or a tackle, and use more than one attempt or observer.

## Interpreting results
Compare results with an earlier baseline, a target or a model. Calculate simple measures:
- Percentage accuracy = successes ÷ attempts × 100. For example, 9 scored from 20 shots is 45%.
- Mean = total ÷ number of results. For 5.2, 5.1, 5.3, 5.0 and 5.1 s, the total is 25.7 s and the mean is 5.14 s.
- Percentage change = change ÷ starting value × 100.

## Identifying strengths and weaknesses
A strength is something done well, and a weakness is something to improve. Always try to give a **reason**. "My serve is weak" is not enough. "My serve often fails because my toss is inconsistent" points to a fix. Use the evidence: "Accuracy dropped from 70% in the first half to 45% in the second, which suggests fatigue."

## Using the analysis
After analysing, set targets, choose practices to address the weaknesses, and review again. This creates a cycle: plan, perform, analyse, improve.

## Common mistakes
- Using only opinions without data, or only data without explanation.
- Using different test methods and then comparing the results.
- Listing weaknesses without suggesting improvements.
- Dividing by the wrong number when calculating percentages.

## How this is examined
Expect a table or description of results from a performance or fitness test, followed by questions asking you to calculate a measure, identify patterns, comment on reliability and recommend an improvement. Evaluate and justify answers must use figures from the data.

Exam tip: Quote at least one number from the data, state what it shows, give a likely cause and then suggest a specific improvement.$mq$ from st;

-- Planning and Reflecting > Using the PHE Criteria
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Planning and Reflecting$mq$, 5, 5 from public.subjects s where s.slug = $mq$physical-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Using the PHE Criteria$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-health-education$mq$ and p.grade = 5 and p.name = $mq$Planning and Reflecting$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Using the PHE Criteria$mq$ and p.name = $mq$Planning and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$How many assessment criteria are used in MYP Physical and Health Education?$mq$, $mq$["Four","Two","Three","Six"]$mq$, 0, $mq$PHE has four criteria: A, B, C and D.$mq$, $mq$easy$mq$),
($mq$Criterion A in MYP PHE is$mq$, $mq$["Planning for performance","Applying and performing","Reflecting and improving performance","Knowing and understanding"]$mq$, 3, $mq$Criterion A assesses knowledge and understanding of health and movement concepts and the ability to use them.$mq$, $mq$easy$mq$),
($mq$Criterion B in MYP PHE is$mq$, $mq$["Knowing and understanding","Applying and performing","Planning for performance","Reflecting and improving performance"]$mq$, 2, $mq$Criterion B is about planning, such as creating a plan to improve performance.$mq$, $mq$easy$mq$),
($mq$Criterion C in MYP PHE is$mq$, $mq$["Knowing and understanding","Applying and performing","Planning for performance","Reflecting and improving performance"]$mq$, 1, $mq$Criterion C is about performing and applying skills and strategies.$mq$, $mq$easy$mq$),
($mq$Criterion D in MYP PHE is$mq$, $mq$["Reflecting and improving performance","Applying and performing","Planning for performance","Knowing and understanding"]$mq$, 0, $mq$Criterion D is about evaluating and reflecting on performance and how to improve it.$mq$, $mq$easy$mq$),
($mq$Each PHE criterion is marked using$mq$, $mq$["Levels 1-5","Grades A-F","Percentages only","Levels 1-8"]$mq$, 3, $mq$Each MYP criterion has achievement levels 1-8, grouped in bands of two.$mq$, $mq$medium$mq$),
($mq$Which command term asks you to give reasons or causes?$mq$, $mq$["State","List","Explain","Name"]$mq$, 2, $mq$Explain requires you to give reasons or causes. State needs only a brief answer.$mq$, $mq$medium$mq$),
($mq$Which command term requires you to give a detailed account without necessarily giving reasons?$mq$, $mq$["Justify","Describe","Evaluate","Explain"]$mq$, 1, $mq$Describe gives a detailed account of characteristics or features.$mq$, $mq$medium$mq$),
($mq$A task asks you to 'outline' a warm-up. What should your answer be?$mq$, $mq$["A brief account or summary of the main parts","A very long essay","A single word","Only a table"]$mq$, 0, $mq$Outline gives a short summary of the main points without extended detail.$mq$, $mq$medium$mq$),
($mq$A student writes 'The plan was good' for a reflection. Why is this unlikely to score highly in Criterion D?$mq$, $mq$["It is too long","It uses command terms","It includes data","It gives no evidence, reasons or suggested improvements"]$mq$, 3, $mq$Higher levels require specific evidence, explanation of strengths and limitations and improvements.$mq$, $mq$medium$mq$),
($mq$Which piece of work best fits Criterion B (planning for performance)?$mq$, $mq$["A match performance","A fitness test result alone","A training plan with goals, activities, timetable and ways of checking progress","A quiz on bones"]$mq$, 2, $mq$Criterion B centres on designing and justifying a plan for performance.$mq$, $mq$medium$mq$),
($mq$Where would a student score for demonstrating skills and tactics during a game?$mq$, $mq$["Criterion A","Criterion C","Criterion B","Criterion D"]$mq$, 1, $mq$Criterion C assesses applying and performing: skills, techniques, strategies and responses to the situation.$mq$, $mq$medium$mq$),
($mq$The achievement-level bands in each criterion are grouped as$mq$, $mq$["1-2, 3-4, 5-6 and 7-8","1-3, 4-6 and 7-8","1-4 and 5-8","1-8 with no bands"]$mq$, 0, $mq$Each criterion uses four descriptors, each covering two levels.$mq$, $mq$medium$mq$),
($mq$Which answer shows the command term 'justify' for choosing interval training?$mq$, $mq$["Interval training is a method","It is good","Interval training has intervals","Interval training improves both aerobic and anaerobic fitness, which suits a football midfielder who sprints and jogs repeatedly"]$mq$, 3, $mq$Justify means giving valid reasons or evidence in support. The best answer links method, benefit and the player's needs.$mq$, $mq$hard$mq$),
($mq$A student writes a reflection that includes data, strengths, weaknesses with reasons and specific improvements. Which level band is most likely?$mq$, $mq$["The lowest band, because it is too long","No band, because reflections are not assessed","A high band, because it is detailed, supported and evaluative","A middle band, since data is irrelevant"]$mq$, 2, $mq$High-level work is substantial and analytical, using evidence to make informed suggestions.$mq$, $mq$hard$mq$),
($mq$Which approach is best for a student aiming for higher achievement levels in Criterion A?$mq$, $mq$["List random facts","Use correct terminology and apply knowledge to specific situations","Avoid examples","Write only definitions"]$mq$, 1, $mq$High levels show accurate knowledge and its application to the given context.$mq$, $mq$hard$mq$),
($mq$A task says 'Evaluate your training plan'. Which response meets this command term?$mq$, $mq$["Judge its strengths and limitations using evidence, then recommend changes","List the exercises","State the date","Describe the equipment only"]$mq$, 0, $mq$Evaluate involves weighing strengths and limitations and reaching a supported judgement.$mq$, $mq$hard$mq$),
($mq$A student's plan lists goals and activities but does not explain why they were chosen or how progress will be checked. Which criterion descriptors are probably not fully met?$mq$, $mq$["Criterion C, because there was no game","Criterion A, because terms were not used","None, because plans need no reasons","Criterion B, because the plan lacks justification and a way to review it"]$mq$, 3, $mq$Higher levels in Criterion B require a plan that is logical, justified and includes ways to measure progress.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Using the PHE Criteria$mq$ and p.name = $mq$Planning and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Name the four PHE criteria$mq$, $mq$A: Knowing and understanding. B: Planning for performance. C: Applying and performing. D: Reflecting and improving performance.$mq$),
($mq$How are PHE criteria marked?$mq$, $mq$Each criterion is assessed on Levels 1-8, grouped into four bands of two levels.$mq$),
($mq$Level bands$mq$, $mq$Levels 1-2 limited, 3-4 adequate, 5-6 substantial and 7-8 excellent.$mq$),
($mq$What does Criterion B assess?$mq$, $mq$Planning for performance: a logical, justified plan with goals, activities, safety and ways to check progress.$mq$),
($mq$What does Criterion C assess?$mq$, $mq$Applying and performing: using skills, techniques, tactics and fitness effectively in activities, and adapting to situations.$mq$),
($mq$What does Criterion D assess?$mq$, $mq$Reflecting and improving performance: evaluating performance and plans with evidence and suggesting realistic improvements.$mq$),
($mq$Command term: describe$mq$, $mq$Give a detailed account of features, characteristics or what happens.$mq$),
($mq$Command term: explain$mq$, $mq$Give reasons or causes, showing how and why something happens.$mq$),
($mq$Command term: evaluate$mq$, $mq$Weigh strengths and limitations using evidence, then make a supported judgement or conclusion.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Using the PHE Criteria$mq$ and p.name = $mq$Planning and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$In MYP Physical and Health Education (PHE) your work is assessed against four criteria. Knowing how they work helps you plan your answers and understand what examiners look for. Each criterion is marked on achievement Levels 1-8.

## The four criteria
- **Criterion A: Knowing and understanding.** Do you know the facts, terms and concepts about health and movement, and can you apply them to different situations? For example, explaining how training principles apply to a given athlete.
- **Criterion B: Planning for performance.** Can you design a plan to improve performance or health, with goals, activities, a timetable, safety and ways to check progress, and justify your choices?
- **Criterion C: Applying and performing.** Can you perform skills, techniques and strategies effectively, adapt to situations and demonstrate fitness, teamwork and fair play?
- **Criterion D: Reflecting and improving performance.** Can you evaluate your performance and plan using evidence, identify strengths and limitations and suggest realistic improvements?

## Levels and bands
Each criterion has four bands, each of two levels:
- Levels 1-2: limited
- Levels 3-4: adequate
- Levels 5-6: substantial
- Levels 7-8: excellent

Moving up the bands usually means moving from simple statements to accurate, detailed, well-justified and well-applied work.

## Command terms
The command term in a task tells you how deeply to answer:
- **State / name / list**: short, factual answers.
- **Outline**: a brief summary of the main points.
- **Describe**: a detailed account of features or what happens.
- **Explain**: give reasons or causes (how and why).
- **Justify**: give valid reasons or evidence to support a choice.
- **Analyse**: break into parts and show how they relate.
- **Evaluate**: judge strengths and limitations using evidence, then reach a conclusion.

## Example of rising quality
Task: reflect on your training plan.
- Lower: "My plan was good and I got fitter."
- Higher: "My 12-minute run distance rose from 2000 m to 2300 m, a 15% increase, which met my target. Attendance was strong (nine of ten sessions) but I missed a session in exam week. Next time I will schedule shorter sessions during busy weeks." This uses data, a judgement, a limitation and an improvement.

## Common mistakes
- Not reading the command term and writing only a list when an explanation is asked for.
- Making general statements without evidence from your own plan or performance.
- Forgetting to mention improvements in a reflection.
- Mixing up the criteria: A is knowledge, B is planning, C is performing, D is reflecting.

## How this is examined
Questions test whether you can match tasks to the correct criterion, interpret command terms and recognise features of high-quality work. You may be asked to judge short sample answers or to say which descriptor is not yet met.

Exam tip: Underline the command term, then check your answer includes the depth it demands: facts for state, reasons for explain, evidence and judgement for evaluate.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('physical-health-education')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;