-- Part 1 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Movement and Fitness > Components of Fitness
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Movement and Fitness$mq$, 5, 1 from public.subjects s where s.slug = $mq$physical-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Components of Fitness$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-health-education$mq$ and p.grade = 5 and p.name = $mq$Movement and Fitness$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Components of Fitness$mq$ and p.name = $mq$Movement and Fitness$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which component of fitness is the ability of the heart, lungs and blood vessels to supply oxygen to working muscles over a long period?$mq$, $mq$["Cardiovascular endurance","Muscular strength","Flexibility","Agility"]$mq$, 0, $mq$Cardiovascular endurance is about sustained oxygen delivery, as in distance running or swimming. Strength is the maximum force a muscle can produce.$mq$, $mq$easy$mq$),
($mq$Which test is most suitable for measuring flexibility of the lower back and hamstrings?$mq$, $mq$["Standing broad jump","30 m sprint","Grip dynamometer","Sit and reach"]$mq$, 3, $mq$The sit and reach test measures how far a person can reach past their toes, which shows flexibility of the hamstrings and lower back.$mq$, $mq$easy$mq$),
($mq$A sprinter needs to get out of the blocks quickly when the starting gun fires. Which skill-related component is most important for this?$mq$, $mq$["Balance","Body composition","Reaction time","Muscular endurance"]$mq$, 2, $mq$Reaction time is the time taken to respond to a stimulus such as a starting signal.$mq$, $mq$easy$mq$),
($mq$Which of these is a skill-related component of fitness rather than a health-related one?$mq$, $mq$["Body composition","Coordination","Flexibility","Cardiovascular endurance"]$mq$, 1, $mq$Coordination (with agility, balance, power, speed and reaction time) is skill-related. The other three are health-related components.$mq$, $mq$easy$mq$),
($mq$A gymnast holds a handstand without wobbling. Which component of fitness does this mainly show?$mq$, $mq$["Balance","Speed","Power","Body composition"]$mq$, 0, $mq$Balance is the ability to keep the centre of mass over the base of support, whether still or moving.$mq$, $mq$easy$mq$),
($mq$Amira does 20 press-ups in one minute in September and 26 in November. Which component has she mainly improved, and by what percentage?$mq$, $mq$["Flexibility, by 30%","Muscular endurance, by 23%","Muscular strength, by 6%","Muscular endurance, by 30%"]$mq$, 3, $mq$Press-ups in a minute test muscular endurance. The increase is 26 − 20 = 6, and 6 ÷ 20 = 0.30, so 30%. Dividing by 26 gives 23%, which is wrong because the percentage change uses the starting value.$mq$, $mq$medium$mq$),
($mq$A student runs 30 m in 4.5 seconds. What is their average speed?$mq$, $mq$["About 7.5 m/s","About 0.15 m/s","About 6.7 m/s","About 135 m/s"]$mq$, 2, $mq$Speed = distance ÷ time = 30 ÷ 4.5 ≈ 6.7 m/s. Multiplying the numbers (30 × 4.5 = 135) is a common slip.$mq$, $mq$medium$mq$),
($mq$Power is best described as a combination of which two components?$mq$, $mq$["Balance and flexibility","Strength and speed","Endurance and agility","Reaction time and coordination"]$mq$, 1, $mq$Power is the ability to use strength quickly, for example in a vertical jump or a shot put throw.$mq$, $mq$medium$mq$),
($mq$A coach says: 'Our goalkeeper needs to change direction quickly while keeping control of her body.' Which component is being described?$mq$, $mq$["Agility","Cardiovascular endurance","Muscular strength","Body composition"]$mq$, 0, $mq$Agility is the ability to change direction quickly and accurately. It differs from speed, which is straight-line movement.$mq$, $mq$medium$mq$),
($mq$Jonas's results on a fitness test are: sit and reach 12 cm, then 15 cm after six weeks of stretching. What is the percentage improvement?$mq$, $mq$["20%","3%","80%","25%"]$mq$, 3, $mq$The change is 15 − 12 = 3 cm. 3 ÷ 12 = 0.25, so a 25% improvement. 20% would come from dividing by 15.$mq$, $mq$medium$mq$),
($mq$A school wants to test cardiovascular endurance for a whole class in a small hall at the same time. Which is the most suitable test?$mq$, $mq$["Vertical jump test","Ruler drop test","Multi-stage fitness (bleep) test","Grip dynamometer test"]$mq$, 2, $mq$The multi-stage fitness test is done over a 20 m shuttle, needs little space and tests many students at once. The other tests measure power, reaction time and strength.$mq$, $mq$medium$mq$),
($mq$Why might a marathon runner and a weightlifter both be considered fit but have very different fitness profiles?$mq$, $mq$["Fitness is the same in every sport","Each sport needs different components, so training emphasises different ones","Only the weightlifter has any fitness","Marathon runners do not need strength"]$mq$, 1, $mq$Fitness is specific. A marathon runner needs high cardiovascular and muscular endurance, while a weightlifter needs maximum strength and power.$mq$, $mq$medium$mq$),
($mq$A table tennis player has excellent reaction time but poor cardiovascular endurance. Which statement is the best conclusion?$mq$, $mq$["They would benefit from aerobic training to cope with long matches","They are unfit in every way","Reaction time cannot be improved","Cardiovascular endurance is not skill-related, so it does not matter"]$mq$, 0, $mq$Fitness profiles are uneven. Strong reaction time helps, but long tournaments need aerobic fitness, so targeted aerobic training is sensible.$mq$, $mq$medium$mq$),
($mq$Which fitness test is matched to the correct component?$mq$, $mq$["Cooper 12-minute run: muscular strength","Sit and reach: agility","Grip dynamometer: cardiovascular endurance","Standing broad jump: power"]$mq$, 3, $mq$The standing broad jump measures explosive leg power. The Cooper run measures cardiovascular endurance, sit and reach measures flexibility, and grip dynamometer measures strength.$mq$, $mq$hard$mq$),
($mq$Sana tests her classmates and records the results in a table. One test used a stopwatch started by one student and stopped by another. Which is the biggest limitation of this method?$mq$, $mq$["Stopwatches cannot measure seconds","The test measures flexibility","Human timing error reduces reliability","The result cannot be compared to anything"]$mq$, 2, $mq$Hand timing varies by reaction time of the timer, which reduces reliability. Using the same timer, repeating trials or using timing gates improves it.$mq$, $mq$hard$mq$),
($mq$A netball player jumps high to intercept a pass, then lands and changes direction at once. Which combination of components is she using most?$mq$, $mq$["Flexibility and body composition only","Power, agility and balance","Muscular endurance and cardiovascular endurance only","Reaction time only"]$mq$, 1, $mq$The jump uses power, the quick change of direction uses agility and keeping control on landing uses balance. Sports use several components together.$mq$, $mq$hard$mq$),
($mq$A student concludes: 'My friend ran further in the Cooper test, so he has better muscular strength.' What is wrong with the conclusion?$mq$, $mq$["The Cooper test measures cardiovascular endurance, not strength","Nothing, further always means stronger","The Cooper test measures flexibility","Running distance cannot be measured"]$mq$, 0, $mq$The conclusion matches the wrong component to the test. A valid conclusion must link the result to the component the test actually measures.$mq$, $mq$hard$mq$),
($mq$A student's body composition is discussed in a PHE class. Which statement is the most accurate and sensitive?$mq$, $mq$["It is simply how much a person weighs, and lower is always better","It is a measure of how fast someone runs","It is the same as flexibility","It is the proportion of fat, muscle, bone and water in the body, and there is no single ideal for everyone"]$mq$, 3, $mq$Body composition is the make-up of the body, and healthy ranges vary with age, sex, sport and build. Weight on its own does not describe it and lower is not always better.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Components of Fitness$mq$ and p.name = $mq$Movement and Fitness$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Cardiovascular endurance$mq$, $mq$The ability of the heart, lungs and blood vessels to supply oxygen to working muscles over a long period. Tested by the Cooper run or bleep test.$mq$),
($mq$Muscular strength vs muscular endurance$mq$, $mq$Strength is the most force a muscle can produce in one effort. Endurance is the ability to keep contracting repeatedly without tiring.$mq$),
($mq$Health-related components (5)$mq$, $mq$Cardiovascular endurance, muscular strength, muscular endurance, flexibility and body composition.$mq$),
($mq$Skill-related components (6)$mq$, $mq$Agility, balance, coordination, power, reaction time and speed.$mq$),
($mq$Power$mq$, $mq$Strength used quickly: strength × speed. Tested by vertical jump or standing broad jump.$mq$),
($mq$Test for flexibility$mq$, $mq$Sit and reach test, which shows range of movement at the hamstrings and lower back.$mq$),
($mq$Average speed formula$mq$, $mq$Speed = distance ÷ time. Example: 30 m in 4.5 s ≈ 6.7 m/s.$mq$),
($mq$Percentage change$mq$, $mq$(new − old) ÷ old × 100. Example: 20 to 26 press-ups is 6 ÷ 20 × 100 = 30%.$mq$),
($mq$Why is fitness specific?$mq$, $mq$Each sport demands different components, so a fit sprinter, marathon runner and gymnast have different fitness profiles.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Components of Fitness$mq$ and p.name = $mq$Movement and Fitness$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is fitness?
Physical fitness is the ability to carry out daily tasks and take part in physical activity with energy and without becoming exhausted too quickly. In PHE we break fitness into components so that we can measure it, train it and talk about it clearly. There are two groups: health-related and skill-related components.

## Health-related components
- **Cardiovascular endurance**: how well the heart, lungs and blood vessels deliver oxygen to working muscles over a long time. Think of distance running, swimming or cycling.
- **Muscular strength**: the maximum force a muscle or muscle group can produce in a single effort, such as a one-repetition lift.
- **Muscular endurance**: the ability of a muscle to keep working repeatedly without tiring, for example press-ups or sit-ups in one minute.
- **Flexibility**: the range of movement available at a joint.
- **Body composition**: the proportion of fat, muscle, bone and water in the body. Healthy ranges differ between people, so we talk about it carefully and never judge someone by their appearance.

## Skill-related components
- **Agility**: changing direction quickly and under control.
- **Balance**: keeping the centre of mass over the base of support, still or moving.
- **Coordination**: using the senses and body parts together smoothly, such as hand-eye coordination when catching.
- **Power**: strength used quickly (strength × speed), as in a jump or a throw.
- **Reaction time**: the time between a signal and the start of a response.
- **Speed**: how quickly the body or a body part moves. Average speed = distance ÷ time.

## Testing fitness
A fitness test gives you a number you can compare later. Common matches are:
- Cooper 12-minute run or multi-stage (bleep) test: cardiovascular endurance
- Grip dynamometer: muscular strength
- Press-ups or sit-ups in one minute: muscular endurance
- Sit and reach: flexibility
- Standing broad jump or vertical jump: power
- 30 m sprint: speed
- Illinois agility run: agility
- Ruler drop: reaction time
- Stork stand: balance

Worked example: a student runs 30 m in 4.5 s. Speed = 30 ÷ 4.5 ≈ 6.7 m/s. Another student improves from 20 to 26 press-ups. The change is 6, and 6 ÷ 20 = 0.30, so there is a 30% improvement. Always divide the change by the starting value.

## Fitness is specific to the activity
A marathon runner, a sprinter and a gymnast are all fit, but in different ways. Each activity places different demands on the body, so a good performer knows which components matter most for their sport and trains them in particular. Most sports use several components at once: a netball player uses power to jump, agility to change direction and balance to land.

## Common mistakes
- Mixing up strength and endurance. Strength is one big effort; endurance is lots of repeats or a long time.
- Matching a test to the wrong component, for example saying the Cooper run measures strength.
- Calling someone "fit" or "unfit" overall. Fitness is a profile with strengths and areas to develop.
- Forgetting limitations of tests: hand timing, different surfaces, motivation on the day and different equipment all reduce reliability.

## How this is examined
Questions usually give a short scenario, such as a student's results or a sport, and ask you to identify the component, choose a suitable test, calculate a change or percentage, and comment on the reliability of the data. In Criterion A you use correct terms; in Criterion B you choose components to develop; in Criterion D you evaluate results.

Exam tip: name the component exactly, link it to the activity or test in the question, and say why it matters. "Cardiovascular endurance, because a long match needs oxygen delivered to the muscles" earns more than "stamina".$mq$ from st;

-- Movement and Fitness > Training Principles and Methods
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Movement and Fitness$mq$, 5, 1 from public.subjects s where s.slug = $mq$physical-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Training Principles and Methods$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-health-education$mq$ and p.grade = 5 and p.name = $mq$Movement and Fitness$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Training Principles and Methods$mq$ and p.name = $mq$Movement and Fitness$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does the 'I' in the FITT principle stand for?$mq$, $mq$["Intensity","Inactivity","Improvement","Individuality"]$mq$, 0, $mq$FITT stands for Frequency, Intensity, Time and Type. Intensity is how hard you work.$mq$, $mq$easy$mq$),
($mq$Which training method involves alternating periods of hard work with periods of rest or easy work?$mq$, $mq$["Continuous training","Static stretching","Sleeping","Interval training"]$mq$, 3, $mq$Interval training alternates work and recovery periods, for example sprint 30 s, walk 60 s.$mq$, $mq$easy$mq$),
($mq$Which type of training is best for improving cardiovascular endurance?$mq$, $mq$["A single heavy lift","Holding a stretch for 10 seconds","Steady running for 30 minutes","Practising a free throw"]$mq$, 2, $mq$Sustained aerobic activity such as continuous running raises the demand on the heart and lungs. Heavy lifts train strength.$mq$, $mq$easy$mq$),
($mq$Training which is matched to the needs of a sport or component is following which principle?$mq$, $mq$["Reversibility","Specificity","Tedium","Recovery"]$mq$, 1, $mq$Specificity means training should match the demands of the activity and the component you want to improve.$mq$, $mq$easy$mq$),
($mq$What happens to fitness if a person stops training for several weeks?$mq$, $mq$["It gradually decreases","It stays exactly the same","It improves faster","Only flexibility is lost"]$mq$, 0, $mq$Reversibility means that the gains from training are lost gradually if training stops.$mq$, $mq$easy$mq$),
($mq$A student wants to improve muscular strength. Which plan best follows the FITT principle?$mq$, $mq$["Daily 5-minute walks","One 3-hour swim a month","Stretching only on Fridays","Three sessions a week of resistance exercises with heavy loads and few repetitions"]$mq$, 3, $mq$Strength gains need regular sessions (frequency), heavy loads (intensity) and resistance exercise (type), usually with low repetitions.$mq$, $mq$medium$mq$),
($mq$Sofia runs 20 minutes three times a week and increases her run time by 10% each fortnight. What will her run time be after the first increase?$mq$, $mq$["21 minutes","30 minutes","22 minutes","20.1 minutes"]$mq$, 2, $mq$10% of 20 is 2 minutes, so 20 + 2 = 22 minutes. This gradual increase is progressive overload.$mq$, $mq$medium$mq$),
($mq$A 16-year-old estimates their maximum heart rate with 220 − age. What is it, and what is 60% of it (rounded)?$mq$, $mq$["204 and 100","204 and 122","220 and 132","236 and 142"]$mq$, 1, $mq$220 − 16 = 204. 60% of 204 = 122.4, which rounds to 122. The formula is only an estimate.$mq$, $mq$medium$mq$),
($mq$Which statement best describes progressive overload?$mq$, $mq$["Gradually increasing the demands on the body as it adapts","Doing the same session every day","Training only on one body part","Taking a complete rest from training"]$mq$, 0, $mq$Overload means working harder than usual, and progressive means it is increased step by step so the body adapts safely.$mq$, $mq$medium$mq$),
($mq$A circuit training session has eight stations of 40 seconds each, with 20 seconds of rest after every station (including the last), and the circuit is done 3 times. What is the total time including all rest?$mq$, $mq$["16 minutes","18 minutes","8 minutes","24 minutes"]$mq$, 3, $mq$Each station plus its rest is 60 s, so 8 stations take 8 minutes, and 3 circuits take 24 minutes.$mq$, $mq$medium$mq$),
($mq$Why is fartlek training useful for a footballer?$mq$, $mq$["It trains only flexibility","It is performed with no movement","It mixes changes of pace, like the stop-start nature of a match","It only trains the upper body"]$mq$, 2, $mq$Fartlek ('speed play') mixes fast and slow running without a set pattern, which resembles the varied pace of a match.$mq$, $mq$medium$mq$),
($mq$A swimmer does exactly the same session five times a week for six months and becomes bored and stops improving. Which two ideas explain this best?$mq$, $mq$["Reversibility and flexibility","Tedium and a need for variation and progression","Body composition and balance","Reaction time and agility"]$mq$, 1, $mq$Doing the same routine causes boredom (tedium) and the body adapts so no further overload occurs. Varying and progressing the training helps.$mq$, $mq$medium$mq$),
($mq$Which activity is an example of plyometric training?$mq$, $mq$["Box jumps","Slow static stretching","Walking","Holding a plank"]$mq$, 0, $mq$Plyometrics uses explosive jumping or bounding movements to develop power.$mq$, $mq$medium$mq$),
($mq$Which is the best reason a coach would give two different training programmes to two teammates of the same age?$mq$, $mq$["Everyone needs identical work","Coaches should not personalise","Age is the only factor","Individual differences in fitness, goals and needs"]$mq$, 3, $mq$The individual differences principle says training should suit each person's current fitness, goals, health and preferences.$mq$, $mq$hard$mq$),
($mq$A player's resting heart rate falls from 72 to 64 beats per minute over 10 weeks of aerobic training. What is the most reasonable conclusion?$mq$, $mq$["Their flexibility has improved","They have lost muscle","Their heart has become more efficient","The test is invalid because heart rate cannot change"]$mq$, 2, $mq$A lower resting heart rate is a typical adaptation to aerobic training because each beat pumps more blood. One result does not prove cause, but it fits the pattern.$mq$, $mq$hard$mq$),
($mq$Maya wants to improve her 800 m time. Which plan is the most specific and sensible?$mq$, $mq$["Only weightlifting for the arms","Interval runs near race pace with rest, plus easy continuous runs","Only stretching","One long swim a month"]$mq$, 1, $mq$Interval work near race pace plus aerobic runs matches the energy demands of 800 m, so it applies specificity.$mq$, $mq$hard$mq$),
($mq$An athlete trains hard six days a week with no rest and gets slower and more tired. What principle has been ignored, and what is the likely issue?$mq$, $mq$["Recovery; overtraining","Specificity; boredom","Flexibility; stiffness only","Reaction time; clumsiness"]$mq$, 0, $mq$Adaptation happens during recovery. Without rest days the body cannot repair and strengthen, which can lead to overtraining and injury.$mq$, $mq$hard$mq$),
($mq$Which evaluation of a six-week training plan is strongest?$mq$, $mq$["Say it was good because it was hard","Say it failed since it was tiring","Ignore the data and rely on opinion","Compare before and after test results, consider reliability and note what could be changed"]$mq$, 3, $mq$A good evaluation uses data from tests, comments on limitations and suggests specific improvements, which links to Criterion D.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Training Principles and Methods$mq$ and p.name = $mq$Movement and Fitness$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$FITT$mq$, $mq$Frequency, Intensity, Time, Type. A way to describe and plan any training session.$mq$),
($mq$Specificity$mq$, $mq$Training should match the demands of the sport and the component being improved.$mq$),
($mq$Progressive overload$mq$, $mq$Gradually increasing the demands (frequency, intensity or time) so the body keeps adapting safely.$mq$),
($mq$Reversibility$mq$, $mq$Fitness gains are gradually lost when training stops or is greatly reduced.$mq$),
($mq$Interval training$mq$, $mq$Alternating periods of hard work with rest or easy work. Example: 30 s sprint, 60 s walk.$mq$),
($mq$Fartlek training$mq$, $mq$Continuous running with changes of pace chosen freely. 'Speed play'. Suits games with varied pace.$mq$),
($mq$Circuit training$mq$, $mq$A series of timed stations that work different muscle groups or components, with short rests between.$mq$),
($mq$Estimated maximum heart rate$mq$, $mq$About 220 − age. For age 16 that is about 204 beats per minute. It is only an estimate.$mq$),
($mq$Why is recovery part of training?$mq$, $mq$The body repairs and gets stronger during rest. Without recovery, overtraining and injury risk increase.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Training Principles and Methods$mq$ and p.name = $mq$Movement and Fitness$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why training needs a plan
Training is planned exercise that improves fitness or performance. Random exercise might help a little, but a clear plan lets you improve a specific component safely and measure the result. In PHE we use principles of training to design and evaluate programmes.

## The FITT principle
FITT is a simple way to describe any training session.
- **Frequency**: how often you train, for example three times a week.
- **Intensity**: how hard you work, such as a percentage of maximum heart rate, the weight lifted or the speed run.
- **Time**: how long each session lasts.
- **Type**: the kind of exercise, matched to the component you want to improve.

## Principles of training
- **Specificity**: training should match the sport and the component. A swimmer needs swimming-related endurance, not only running.
- **Progressive overload**: the body adapts only when it is asked to work a little harder than normal. Increase frequency, intensity or time gradually. If a run of 20 minutes increases by 10%, the new time is 22 minutes.
- **Reversibility**: fitness gained is gradually lost when training stops. "Use it or lose it."
- **Variation and tedium**: doing the same session every time causes boredom and a plateau. Changing exercises keeps motivation high.
- **Individual differences**: people differ in starting fitness, goals, age, health and enjoyment, so programmes should be personal.
- **Recovery**: fitness improves during rest, not during the session. Rest days, sleep and easy sessions prevent overtraining and injury.

## Training methods
- **Continuous training**: steady exercise without rest for a long time, such as jogging for 30 minutes. It develops cardiovascular endurance.
- **Interval training**: periods of hard work separated by rest or easy work, such as 30 seconds of sprinting followed by 60 seconds of walking. It can improve speed and endurance.
- **Fartlek training**: "speed play". The pace changes without a fixed pattern, which suits games like football.
- **Circuit training**: a series of stations each working a different muscle group or component, with timed work and rest.
- **Resistance (weight) training**: using weights, bands or bodyweight to build strength or muscular endurance. Heavier loads with fewer repetitions favour strength; lighter loads with many repetitions favour muscular endurance.
- **Plyometrics**: explosive jumping and bounding to develop power.
- **Flexibility training**: static stretching (holding a position) or dynamic stretching (moving through a range).

## Using heart rate
Maximum heart rate can be roughly estimated as 220 − age. For a 16-year-old that is 204 beats per minute. A common aerobic training zone is about 60% to 85% of this value. It is only an estimate, so students should listen to their bodies and talk to a teacher or coach rather than push through discomfort. Resting heart rate often decreases with regular aerobic training because the heart becomes more efficient.

## Common mistakes
- Increasing everything too quickly, which risks injury.
- Choosing a method that does not match the goal, such as using only long slow runs to improve power.
- Skipping recovery.
- Forgetting that a plan must be tested and reviewed.

## How this is examined
You may be given a scenario about an athlete and asked to select a method, apply FITT to design a week of training, calculate a percentage increase or heart-rate figure, and justify your choices. For evaluation you will be given before-and-after test data and asked to judge how effective the plan was and how it could be improved.

Exam tip: always justify. Write the method, the principle it follows and the reason: "Interval training, because it is specific to the stop-start demands of netball and allows overload through shorter rests."$mq$ from st;

-- Movement and Fitness > Warm-up, Cool-down and Safety
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Movement and Fitness$mq$, 5, 1 from public.subjects s where s.slug = $mq$physical-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Warm-up, Cool-down and Safety$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-health-education$mq$ and p.grade = 5 and p.name = $mq$Movement and Fitness$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Warm-up, Cool-down and Safety$mq$ and p.name = $mq$Movement and Fitness$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the main purpose of a warm-up?$mq$, $mq$["To prepare the body and mind for exercise and reduce injury risk","To finish a session","To make the muscles tired","To replace training"]$mq$, 0, $mq$A warm-up raises body temperature, increases blood flow and prepares muscles and joints for activity.$mq$, $mq$easy$mq$),
($mq$Which activity is the best 'pulse raiser' at the start of a warm-up?$mq$, $mq$["Holding a long static stretch","Lifting a maximum weight","Sitting down","Light jogging"]$mq$, 3, $mq$A pulse raiser gradually increases heart rate and body temperature. Light jogging does this.$mq$, $mq$easy$mq$),
($mq$Which of these is usually part of a cool-down?$mq$, $mq$["A sprint","A heavy weight lift","Slow walking and gentle stretching","A competitive match"]$mq$, 2, $mq$A cool-down gradually lowers heart rate and breathing and includes gentle stretching.$mq$, $mq$easy$mq$),
($mq$Which item of equipment is correct for protecting the head when cycling?$mq$, $mq$["A scarf","A well-fitting helmet","Sunglasses only","A water bottle"]$mq$, 1, $mq$A well-fitting helmet is the key protective equipment for cycling and reduces the risk of head injury.$mq$, $mq$easy$mq$),
($mq$Before a lesson starts, a teacher walks around the gym checking for wet patches and loose equipment. What is this called?$mq$, $mq$["Risk assessment","Cool-down","Tactics","Fartlek"]$mq$, 0, $mq$Checking for hazards and deciding how to control them is a risk assessment.$mq$, $mq$easy$mq$),
($mq$Which stretch type is most appropriate in the main part of a warm-up?$mq$, $mq$["Long static stretches only","No movement at all","Maximum-effort jumps from cold","Dynamic stretches such as leg swings"]$mq$, 3, $mq$Dynamic stretches take joints through their range while moving and are suited to warm-ups. Long static holds are more suited to a cool-down.$mq$, $mq$medium$mq$),
($mq$A hockey coach lists a warm-up: 3 minutes jogging, 4 minutes dynamic stretches, 5 minutes passing drills. How long is the warm-up, and which stage is sport-specific?$mq$, $mq$["12 minutes; jogging","7 minutes; dynamic stretches","12 minutes; passing drills","3 minutes; passing drills"]$mq$, 2, $mq$3 + 4 + 5 = 12 minutes. The passing drills copy movements used in hockey, so they are sport-specific.$mq$, $mq$medium$mq$),
($mq$Why might a cool-down help recovery after exercise?$mq$, $mq$["It makes the body colder at once","It lets heart rate and breathing return gradually towards resting levels","It stops the heart","It builds maximum strength"]$mq$, 1, $mq$A gradual cool-down keeps blood flowing and helps the body return to resting levels. It is not guaranteed to prevent all soreness.$mq$, $mq$medium$mq$),
($mq$Which is a hazard rather than a risk?$mq$, $mq$["A wet floor in the gym","A student might slip and bruise a knee","The chance of injury is medium","Wearing slippery shoes may cause a fall"]$mq$, 0, $mq$A hazard is something that could cause harm, such as a wet floor. A risk is the chance and seriousness of harm resulting from it.$mq$, $mq$medium$mq$),
($mq$A student wearing a necklace and watch is told to remove them before gymnastics. What is the main reason?$mq$, $mq$["They make the student faster","They count as a warm-up","They break the rules of scoring","They can catch on equipment or injure the student or others"]$mq$, 3, $mq$Jewellery can snag or press into skin during movement. Removing it is a simple safety control.$mq$, $mq$medium$mq$),
($mq$On a hot afternoon a coach arranges a water break every 20 minutes, shade and sun cream. Which category of safety measure is this?$mq$, $mq$["Choosing tactics","Testing flexibility","Controlling environmental risks","Scoring a match"]$mq$, 2, $mq$These measures reduce risks caused by heat and sun, which are environmental factors.$mq$, $mq$medium$mq$),
($mq$Why is static stretching of cold muscles just before a sprint not the best choice?$mq$, $mq$["Stretching is always harmful","Dynamic, progressive movement better prepares muscles for rapid effort","Sprinters never warm up","Stretching raises heart rate too much"]$mq$, 1, $mq$Warm-ups should gradually raise temperature and prepare the specific movements. Dynamic movement does this better than long holds of cold muscles.$mq$, $mq$medium$mq$),
($mq$Mia has 10 minutes before a match. Which is the best use of time?$mq$, $mq$["Pulse raiser, dynamic stretches, then drills at increasing intensity","30 seconds of stretching then play","Sit and wait","Hard sprints from the start"]$mq$, 0, $mq$A staged warm-up builds gradually from general to specific and gives time to prepare.$mq$, $mq$medium$mq$),
($mq$A school plans an outdoor cross-country run. Which control would reduce the highest risk of someone being injured and unnoticed?$mq$, $mq$["Giving every student a medal","Running faster","Removing the warm-up","Using a buddy system and a teacher at the end of the route"]$mq$, 3, $mq$Supervision and pairing students means that any injury is noticed quickly. This is an example of a risk control for activities away from the main group.$mq$, $mq$hard$mq$),
($mq$A coach says: 'Warm-ups have no effect on performance, only on injury.' Which statement is the best response?$mq$, $mq$["The coach is right in every case","Warm-ups cause injuries","Warm-ups can also improve readiness, reaction and focus, though evidence on injury prevention varies by activity","Warm-ups only matter in winter"]$mq$, 2, $mq$A warm-up helps physical and mental readiness. Claims should be balanced, since the effect on injury rates differs by sport and routine.$mq$, $mq$hard$mq$),
($mq$A risk assessment rates a trampoline activity as 'high likelihood, high severity' without supervision. What is the most appropriate response?$mq$, $mq$["Ignore it","Add controls such as qualified supervision, spotting rules and a limit on numbers, then reassess","Cancel all PE","Remove the warm-up"]$mq$, 1, $mq$The aim is to reduce likelihood and severity using controls, then check the remaining risk is acceptable.$mq$, $mq$hard$mq$),
($mq$A student's warm-up consists only of reading the plan for the match. Which evaluation is strongest?$mq$, $mq$["It misses the physical preparation, so add a pulse raiser, mobility and sport-specific drills","It is perfect","It is too long","It trains strength"]$mq$, 0, $mq$Mental planning is useful but the body also needs to be prepared with gradual movement. A good evaluation says what is missing and how to fix it.$mq$, $mq$hard$mq$),
($mq$Which reason best explains why athletes keep moving lightly after a hard race rather than stopping suddenly?$mq$, $mq$["Stopping suddenly builds fitness","Moving lightly increases injury","It saves time","Light movement helps blood keep circulating while heart rate comes down"]$mq$, 3, $mq$Gradual reduction in activity helps circulation and avoids feeling dizzy as heart rate and breathing settle.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Warm-up, Cool-down and Safety$mq$ and p.name = $mq$Movement and Fitness$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Three stages of a warm-up$mq$, $mq$Pulse raiser, mobility/dynamic stretching, and sport-specific drills of increasing intensity.$mq$),
($mq$Purpose of a warm-up$mq$, $mq$Raise body temperature and heart rate, improve blood flow and range of movement, and prepare mind and body to reduce injury risk.$mq$),
($mq$Purpose of a cool-down$mq$, $mq$Gradually lower heart rate and breathing, keep circulation going and include static stretching to help recovery.$mq$),
($mq$Dynamic stretch$mq$, $mq$Stretching while moving through a range of motion, such as leg swings. Used in warm-ups.$mq$),
($mq$Static stretch$mq$, $mq$Holding a stretched position for about 15 to 30 seconds. Often used in a cool-down.$mq$),
($mq$Hazard$mq$, $mq$Something that could cause harm, such as a wet floor or damaged equipment.$mq$),
($mq$Risk$mq$, $mq$How likely harm is to happen and how serious it would be.$mq$),
($mq$Steps in a risk assessment$mq$, $mq$Identify hazards, rate the risk, choose controls, then review the remaining risk.$mq$),
($mq$Examples of safety controls$mq$, $mq$Protective equipment, removing jewellery, checking the surface, supervision, rules, water breaks and sun protection.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Warm-up, Cool-down and Safety$mq$ and p.name = $mq$Movement and Fitness$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why prepare and recover?
Every PE lesson or training session should have three parts: a warm-up, the main activity and a cool-down. Planning the first and last parts protects you from injury, helps you perform better and helps you recover. Safety is also about the environment, equipment and rules, not only your body.

## The warm-up
A warm-up is a period of lighter exercise at the start of a session that gradually prepares the body and mind. It normally lasts about 8 to 15 minutes and has three stages.
- **Pulse raiser**: easy jogging, skipping or cycling to raise heart rate and body temperature.
- **Mobility and dynamic stretching**: moving joints through their range, such as leg swings, arm circles and lunges with a twist. This prepares muscles and joints for the movements they will use.
- **Sport-specific drills**: practising skills at gradually increasing intensity, for example passing in football or shooting in basketball.

Benefits of a warm-up include higher muscle temperature, better blood flow, more elastic muscles, greater range of movement, faster reactions, mental focus and a lower chance of strain. The evidence for injury prevention differs between activities, so a balanced answer says "can reduce the risk" rather than "stops all injuries".

## The cool-down
A cool-down is gentle activity after the main session.
- Slow jogging or walking for a few minutes lets heart rate and breathing fall gradually.
- Static stretches, held for around 15 to 30 seconds, help maintain or improve flexibility while muscles are warm.
- Taking fluids and reflecting on the session helps recovery.

Do not stop suddenly after hard exercise, as you may feel dizzy because blood flow has not yet adjusted.

## Staying safe
Safety is managed through habits and planning.
- **Clothing and equipment**: suitable footwear, protective equipment such as helmets, shin pads and gum shields, and removing jewellery. Check equipment for damage and set it up properly.
- **Environment**: check the surface, space, lighting and weather. Wet floors or uneven grass are hazards. On hot days use shade, sun protection and regular water breaks.
- **People and rules**: listen to instructions, follow the rules of the activity, use suitable group sizes and match opponents fairly. Tell a teacher about any injury or illness before or during the session.
- **Technique**: lifting and landing correctly reduces strain.

## Risk assessment
A **hazard** is something that could cause harm. A **risk** is how likely harm is and how serious it would be. A risk assessment lists hazards, rates the risk, and decides on controls, such as supervision, rules, equipment and changing the activity. After the controls are in place the remaining risk is reviewed. Worked example: a wet gym floor is a hazard; the risk of slipping is high; the control is to dry it, put up a sign and stop the activity until it is safe.

## Common mistakes
- Confusing hazard and risk.
- Skipping the warm-up because you are short of time.
- Only doing static stretching at the start of a sprint session.
- Thinking safety is only the teacher's job. Everyone shares responsibility.

## How this is examined
Typical tasks present a plan or a scenario and ask you to describe or evaluate the warm-up and cool-down, identify hazards, suggest controls and justify them. In Criterion B you plan a warm-up suited to your sport; in Criterion D you comment on whether it worked.

Exam tip: link every warm-up activity to its purpose. Say "leg swings, to increase the range of movement at the hip before sprinting" rather than just "stretches".$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('physical-and-health-education')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;