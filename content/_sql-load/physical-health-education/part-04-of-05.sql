-- Part 4 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Skills and Strategy > Movement Skills and Technique
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Skills and Strategy$mq$, 5, 4 from public.subjects s where s.slug = $mq$physical-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Movement Skills and Technique$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-health-education$mq$ and p.grade = 5 and p.name = $mq$Skills and Strategy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Movement Skills and Technique$mq$ and p.name = $mq$Skills and Strategy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which of these is a fundamental movement skill?$mq$, $mq$["Throwing","Playing a full match","Planning a season","Reading a rulebook"]$mq$, 0, $mq$Fundamental movement skills such as running, jumping, throwing, catching and kicking are the basic building blocks of sport.$mq$, $mq$easy$mq$),
($mq$A skill that is performed in a stable, predictable environment, such as a free throw or a gymnastics vault, is called$mq$, $mq$["an open skill","a tactical skill","a fine skill","a closed skill"]$mq$, 3, $mq$Closed skills happen in a predictable setting and are mostly controlled by the performer.$mq$, $mq$easy$mq$),
($mq$A skill where the environment keeps changing, such as passing in a football match, is called$mq$, $mq$["a closed skill","a fixed skill","an open skill","a discrete skill"]$mq$, 2, $mq$Open skills must adapt to teammates, opponents and conditions.$mq$, $mq$easy$mq$),
($mq$The three main phases of most movement skills are$mq$, $mq$["warm-up, game and cool-down","preparation, execution and follow-through","plan, perform and score","start, middle and rest"]$mq$, 1, $mq$Preparation sets up the movement, execution is the main action, and follow-through finishes it.$mq$, $mq$easy$mq$),
($mq$Which is an example of a gross motor skill?$mq$, $mq$["Sprinting","Threading a needle","Writing a name","Fastening a button"]$mq$, 0, $mq$Gross skills use large muscle groups. Fine skills use small, precise movements.$mq$, $mq$easy$mq$),
($mq$A basketball player bends the knees, then extends the legs and arm, and the wrist snaps as the ball is released. Which phase includes the wrist snap and the arm staying extended after release?$mq$, $mq$["Preparation","Warm-up","Recovery","Follow-through"]$mq$, 3, $mq$The wrist snap and extended arm after release are part of follow-through, which helps accuracy and control.$mq$, $mq$medium$mq$),
($mq$A coach says 'Great pass!' after a drill. This is an example of$mq$, $mq$["intrinsic feedback","a closed skill","extrinsic feedback","a warm-up"]$mq$, 2, $mq$Feedback from outside the performer, such as from a coach, is extrinsic. Intrinsic feedback is the performer's own feel.$mq$, $mq$medium$mq$),
($mq$Which practice method splits a complex skill, such as a swimming stroke, into smaller parts before putting them together?$mq$, $mq$["Whole practice","Part practice","Massed practice only","Mental rest"]$mq$, 1, $mq$Part practice works on pieces of a skill, then combines them. It is helpful for complex or dangerous skills.$mq$, $mq$medium$mq$),
($mq$A learner feels where the racket is and knows the shot was off before anyone tells them. This is$mq$, $mq$["intrinsic feedback","extrinsic feedback","knowledge of results only","a coach's instruction"]$mq$, 0, $mq$Intrinsic feedback comes from the body's own senses and awareness of the movement.$mq$, $mq$medium$mq$),
($mq$Which statement correctly compares open and closed skills?$mq$, $mq$["Open skills never involve opponents","Closed skills are always easy","Open skills happen only indoors","An open skill must be adapted to changing conditions; a closed skill follows a fixed pattern"]$mq$, 3, $mq$Open skills respond to a changing environment, closed skills happen in a predictable one. Difficulty does not decide the category.$mq$, $mq$medium$mq$),
($mq$A beginner is learning a tennis serve and needs a lot of conscious thought and makes frequent errors. Which learning stage is this?$mq$, $mq$["The autonomous stage","The associative stage","The cognitive (early) stage","The expert stage"]$mq$, 2, $mq$Early learners think carefully about each part and make many errors. Later stages are smoother and more automatic.$mq$, $mq$medium$mq$),
($mq$A student improves their kick by filming it and comparing it with a model demonstration. Which method is this?$mq$, $mq$["Massed practice","Using visual feedback and a demonstration","Intrinsic feedback only","Warm-up"]$mq$, 1, $mq$Video and demonstrations show the difference between a performance and a model technique, which guides improvement.$mq$, $mq$medium$mq$),
($mq$Why is correct technique important in activities such as lifting or landing from a jump?$mq$, $mq$["It improves efficiency and reduces the risk of injury","It always makes you stronger immediately","It replaces the need to warm up","It is only for scoring"]$mq$, 0, $mq$Good technique uses the body safely and effectively. It does not replace warm-ups.$mq$, $mq$medium$mq$),
($mq$A cricketer practises the same batting shot 50 times with no breaks until tired. This is mainly$mq$, $mq$["distributed practice with rest","a closed warm-up","random practice","massed practice, which may cause fatigue and poorer quality"]$mq$, 3, $mq$Massed practice has few or no rests. Distributed practice includes breaks and is often better for complex skills or when tired.$mq$, $mq$hard$mq$),
($mq$A volleyball player's serve is successful 6 times out of 15 in week 1 and 9 out of 15 in week 4. By what percentage did the success rate increase?$mq$, $mq$["20%","25%","50%","3%"]$mq$, 2, $mq$6 to 9 is an increase of 3, and 3 ÷ 6 = 0.5, which is 50%. The percentage points rose from 40% to 60%, which is a 20 percentage point rise, not a 20% increase.$mq$, $mq$hard$mq$),
($mq$A learner's passing is accurate in practice drills but poor in matches. Which is the most likely reason and best response?$mq$, $mq$["The learner has no skill at all","Match conditions are open and pressured, so practise with moving opponents and decisions","Closed practice is always best","Matches are easier than drills"]$mq$, 1, $mq$Drills are closed. To transfer skill to matches, practise in more game-like open conditions.$mq$, $mq$hard$mq$),
($mq$Which evaluation of 'whole practice' for a simple skill such as a basic jump is most accurate?$mq$, $mq$["It is suitable because the skill is simple and can be practised as one movement","It is unsafe for every skill","It is only for experts","It is slower than part practice for every skill"]$mq$, 0, $mq$Simple skills are usually practised as a whole. Complex or risky skills often benefit from being broken into parts first.$mq$, $mq$hard$mq$),
($mq$A coach wants a learner at the associative stage to improve smoothness. Which feedback is most helpful?$mq$, $mq$["A long list of every error","No feedback at all","Only comments about the result of the match","Specific, positive feedback focused on one or two key points"]$mq$, 3, $mq$Targeted feedback avoids overload. Too many corrections can confuse learners.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Movement Skills and Technique$mq$ and p.name = $mq$Skills and Strategy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Open skill versus closed skill$mq$, $mq$Open skills are performed in a changing environment (a pass in football). Closed skills are performed in a stable, predictable setting (a free throw).$mq$),
($mq$Three phases of a skill$mq$, $mq$Preparation, execution and follow-through.$mq$),
($mq$Why is follow-through important?$mq$, $mq$It helps accuracy and control, completes the movement smoothly and reduces the risk of injury.$mq$),
($mq$Gross versus fine skills$mq$, $mq$Gross skills use large muscle groups (running, jumping). Fine skills use small, precise movements (aiming, threading).$mq$),
($mq$Intrinsic versus extrinsic feedback$mq$, $mq$Intrinsic comes from your own senses and feel. Extrinsic comes from outside, such as a coach, teammate, video or score.$mq$),
($mq$Whole versus part practice$mq$, $mq$Whole practice rehearses the entire skill, good for simple skills. Part practice splits complex or risky skills into sections.$mq$),
($mq$Massed versus distributed practice$mq$, $mq$Massed has few or no rests and can cause fatigue. Distributed includes rest breaks and often improves quality and learning.$mq$),
($mq$Stages of learning$mq$, $mq$Cognitive (thinking, many errors), associative (smoother, self-correcting) and autonomous (fluent and automatic).$mq$),
($mq$Name some fundamental movement skills$mq$, $mq$Running, jumping, balancing, throwing, catching and kicking. They are the building blocks for sports skills.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Movement Skills and Technique$mq$ and p.name = $mq$Skills and Strategy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$A movement skill is a learned action performed with control and purpose, such as throwing, dribbling, swimming a stroke or landing from a jump. Technique is the way you carry out the skill. Good technique makes movement efficient, accurate and safer.

## Types of skill
- **Fundamental movement skills** are basic actions such as running, jumping, balancing, throwing, catching and kicking. They are the foundation of sports.
- **Gross skills** use large muscle groups (sprinting). **Fine skills** use small, precise movements (archery aiming).
- **Open skills** are performed in a changing environment and must adapt to teammates and opponents (a pass in football).
- **Closed skills** are performed in a stable, predictable environment (a free throw, a vault).
- Many skills sit on a line between open and closed, so you can say "more open" or "more closed".

## Phases of a skill
Most skills can be broken down into three phases:
- **Preparation**: get into position, balance and focus. For a throw, this is the stance and wind-up.
- **Execution**: the main action where force is applied.
- **Follow-through**: continuing the movement after contact or release, which helps accuracy and reduces injury risk.

## Stages of learning
Beginners are in the **cognitive stage**: lots of thinking and many errors. With practice they move to the **associative stage**: smoother, fewer errors, and the learner can correct themselves. Experts reach the **autonomous stage**: movement is fluent and automatic, freeing attention for tactics.

## Practice methods
- **Whole practice**: practising the full skill; good for simple skills.
- **Part practice**: breaking a complex skill into parts; good for complex or risky skills.
- **Massed practice**: continuous practice with few rests; can cause fatigue.
- **Distributed practice**: practice with breaks; helps quality and learning.
- Practice should become more game-like (open, with decisions and pressure) as the learner improves.

## Feedback
- **Intrinsic feedback** is what you feel and sense yourself.
- **Extrinsic feedback** comes from outside: a coach, teammate, video or scoreboard.
- Good feedback is specific, positive and focused on one or two points at a time.

## Worked example
A player scores 6 of 15 serves in week 1 and 9 of 15 in week 4. Increase = 9 − 6 = 3. Percentage increase = 3 ÷ 6 × 100 = 50%. The success rate moved from 40% to 60%.

## Common mistakes
- Mixing up open and closed skills; ask whether the environment changes.
- Confusing intrinsic and extrinsic feedback.
- Describing only the "result" of a skill instead of its phases and key points.

## How this is examined
Questions often present a short description of a learner or a performance clip and ask you to identify skill type, phase, stage of learning, or to suggest practice and feedback that would improve technique. Describe and explain command terms need accurate technical vocabulary.

Exam tip: When analysing technique, name the phase (preparation, execution or follow-through) and give one specific observation and one improvement for it.$mq$ from st;

-- Skills and Strategy > Tactics and Game Strategy
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Skills and Strategy$mq$, 5, 4 from public.subjects s where s.slug = $mq$physical-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Tactics and Game Strategy$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-health-education$mq$ and p.grade = 5 and p.name = $mq$Skills and Strategy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Tactics and Game Strategy$mq$ and p.name = $mq$Skills and Strategy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In a team game, 'tactics' are$mq$, $mq$["the plans and decisions used during play to gain an advantage","the rules written in a rulebook","the warm-up exercises","the equipment used"]$mq$, 0, $mq$Tactics are choices made in a game, such as where to pass or how to defend. Rules set what is allowed.$mq$, $mq$easy$mq$),
($mq$Which phase of play is a team in when it has the ball?$mq$, $mq$["Defence","Warm-up","Foul","Attack"]$mq$, 3, $mq$Teams are in attack when they have possession and try to score, and in defence when the opponent has it.$mq$, $mq$easy$mq$),
($mq$Creating 'space' in a game most often means$mq$, $mq$["standing close to a defender","kicking the ball out of play","moving to a position where you can receive the ball or where opponents are not","slowing down play"]$mq$, 2, $mq$Good attackers move into open areas so passes and shots become easier.$mq$, $mq$easy$mq$),
($mq$Which of these is a defensive principle?$mq$, $mq$["Spreading wide to stretch the defence","Marking an opponent to limit their options","Passing quickly to a free player","Making a run into space"]$mq$, 1, $mq$Marking and covering restrict space and time for attackers.$mq$, $mq$easy$mq$),
($mq$What does 'possession' mean in a team game?$mq$, $mq$["Having control of the ball or puck","Being the highest scorer","Having the most substitutes","Being the home team"]$mq$, 0, $mq$Keeping possession lets a team control the tempo and limits opponents' chances to score.$mq$, $mq$easy$mq$),
($mq$A team spreads its players wide across the pitch when attacking. What is the main aim?$mq$, $mq$["To make passing harder","To protect their own goal","To slow down play","To stretch the defence and create gaps"]$mq$, 3, $mq$Width forces defenders to cover more space, which opens gaps between them.$mq$, $mq$medium$mq$),
($mq$A coach tells players to 'play in the gaps between defenders and to support the player on the ball'. Which principle of attack is this?$mq$, $mq$["Delay","Marking","Support and creating passing options","Containing"]$mq$, 2, $mq$Supporting the ball carrier gives them passing options and keeps attacks moving.$mq$, $mq$medium$mq$),
($mq$Which tactic is most suitable when a team is winning by one goal with two minutes left?$mq$, $mq$["Take long, risky shots from anywhere","Keep possession and slow the tempo","Leave only one defender back","Foul opponents on purpose"]$mq$, 1, $mq$Keeping the ball in safe areas runs down the clock. Reckless play risks losing the lead.$mq$, $mq$medium$mq$),
($mq$In badminton doubles, what is the main advantage of the 'front and back' formation when attacking?$mq$, $mq$["One player covers the net and the other covers the back, allowing a smash attack","Both players stay at the net","Neither player moves","Players avoid hitting the shuttle"]$mq$, 0, $mq$Front and back combines net pressure and a strong rear-court smash. The other formation, side by side, is more defensive.$mq$, $mq$medium$mq$),
($mq$A team has fewer players than its opponent near the ball. Which decision is best?$mq$, $mq$["Keep playing the ball into the crowded area","Stop moving","Ask for a rule change","Move the ball quickly to the area where they have more players or space"]$mq$, 3, $mq$Good decision-making looks for areas of advantage and moves play there.$mq$, $mq$medium$mq$),
($mq$A set play such as a corner routine is useful because$mq$, $mq$["it removes the need for fitness","it is always successful","it gives players rehearsed roles in a planned situation","it replaces all decision-making"]$mq$, 2, $mq$Set plays are practised in advance so everyone knows their role. They still depend on skill and execution.$mq$, $mq$medium$mq$),
($mq$Which choice describes an effective transition?$mq$, $mq$["Staying in one formation at all times","Quickly changing from defence to attack when the ball is won","Stopping play when possession changes","Always kicking long"]$mq$, 1, $mq$Transitions are moments when possession changes. Rapid, organised movement can create chances.$mq$, $mq$medium$mq$),
($mq$After watching a match, a coach counts that the team lost possession 18 times in the middle third and only 6 times in the final third. What does this suggest?$mq$, $mq$["The team has most difficulty keeping the ball in the middle third","The team is strongest in midfield","The team has no possession problems","The team never attacks"]$mq$, 0, $mq$More turnovers in the middle third shows that area needs tactical or skill work.$mq$, $mq$medium$mq$),
($mq$A team's passing completion was 36 passes completed out of 48 attempts. What was the completion rate?$mq$, $mq$["133%","25%","36%","75%"]$mq$, 3, $mq$36 ÷ 48 = 0.75, which is 75%. Dividing the other way round gives an impossible 133%.$mq$, $mq$hard$mq$),
($mq$A team always plays through the centre and the opponent keeps packing that area. Which adjustment is best?$mq$, $mq$["Keep doing exactly the same thing","Stop passing","Use wide players to stretch the defence and open the centre","Make the same pass faster each time"]$mq$, 2, $mq$If one approach is blocked, adapt. Wide play can pull defenders out of the middle.$mq$, $mq$hard$mq$),
($mq$Which statement is the best evaluation of a tactic that gave the team many shots but all from far away and few on target?$mq$, $mq$["It was perfect","It created chances but needs improvement in the quality of shot selection","It created no chances","It cannot be evaluated"]$mq$, 1, $mq$Evaluating means weighing the strengths and weaknesses: many shots (strength) but poor location and accuracy (weakness).$mq$, $mq$hard$mq$),
($mq$A team has strong fast wingers but a slow centre-back pair. Which game plan is most sensible?$mq$, $mq$["Attack down the wings and defend deeper to protect against balls behind the defence","Press high with slow defenders","Ignore the wingers","Play the same plan as every team"]$mq$, 0, $mq$Tactics should use team strengths and protect weaknesses. High pressing with slow defenders leaves space behind.$mq$, $mq$hard$mq$),
($mq$Which approach best shows tactical awareness in a changing game?$mq$, $mq$["Following one fixed plan whatever happens","Waiting for the coach to give every instruction","Only focusing on your own skills","Reading opponents' positions and adapting the plan during play"]$mq$, 3, $mq$Awareness means scanning the game, anticipating and adjusting decisions in real time.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Tactics and Game Strategy$mq$ and p.name = $mq$Skills and Strategy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Difference between skill and tactic$mq$, $mq$A skill is how you perform an action. A tactic is the decision about what action to use and when or where to use it.$mq$),
($mq$Name some principles of attack$mq$, $mq$Keep possession, create and use space, width and depth, support the ball carrier and vary the tempo.$mq$),
($mq$Name some principles of defence$mq$, $mq$Mark opponents, cover teammates, delay attackers, stay compact and transition quickly when the ball is won.$mq$),
($mq$Why use width in attack?$mq$, $mq$Spreading wide stretches the defence and creates gaps to pass or run into.$mq$),
($mq$What is a transition in a game?$mq$, $mq$The moment possession changes between attack and defence. Reacting quickly can create chances or prevent them.$mq$),
($mq$What is a set play?$mq$, $mq$A rehearsed routine for a restart, such as a corner, free throw or serve, where each player has a planned role.$mq$),
($mq$Tactic when winning late in a match$mq$, $mq$Keep possession, slow the tempo and avoid risks to protect the lead.$mq$),
($mq$Calculate pass completion rate$mq$, $mq$Completed passes ÷ attempted passes × 100. For example, 36 out of 48 is 75%.$mq$),
($mq$Why adapt tactics during a game?$mq$, $mq$Opponents change and situations develop, so reading the game and adjusting keeps your team effective.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Tactics and Game Strategy$mq$ and p.name = $mq$Skills and Strategy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Tactics are the plans and decisions a team or player uses to gain an advantage. Strategy is the larger plan for a whole game or season. Skills tell you what you can do; tactics decide when and where you do it.

## Basic principles of attack
- **Keep possession**: a team with the ball controls the pace and cannot be scored against.
- **Create and use space**: move into open areas, spread out and run off the ball.
- **Width and depth**: width stretches the defence side to side. Depth means having players ahead of and behind the ball to give options.
- **Support**: players move to give the ball carrier passing choices.
- **Tempo**: change the speed of play, attack quickly when a gap opens or slow down to keep the ball.

## Basic principles of defence
- **Mark** opponents to reduce their time and space.
- **Cover** teammates so there is back-up if one is beaten.
- **Delay** the attacker to allow teammates to recover.
- **Compact shape**: stay close together to limit gaps.
- **Transition quickly** when possession changes.

## Formations and set plays
A formation is the way players are arranged, for example "4-4-2" in football or front-and-back in badminton doubles. No formation is best for all situations. Choose it to suit your players' strengths and the opposition. Set plays such as corners, free throws or serves are rehearsed so that each player knows their role.

## Decision-making and adapting
Good players scan the game, read opponents and choose the best option. When a plan is not working, adapt. Examples:
- If the opponent defends the centre well, use the wings.
- If you lead late in the game, keep possession and slow the tempo.
- If you trail, take more risks and push players forward.

## Using data
Simple data helps analyse tactics. For example, a team completes 36 of 48 passes. Completion rate = 36 ÷ 48 × 100 = 75%. Compare it with earlier matches or between areas of the pitch to find strengths and weaknesses.

## Common mistakes
- Confusing tactics (decisions in play) with skills (how an action is performed).
- Saying "play better" without naming a specific principle.
- Suggesting a tactic that does not fit the team's strengths.

## How this is examined
You may be given a game situation, a diagram described in words or simple match statistics, and asked to identify the principle in use, explain why a tactic works or evaluate it and suggest an alternative. Evaluate answers should weigh strengths and limits using the evidence provided.

Exam tip: Name the principle (width, support, marking, tempo), link it to the situation given, and explain the effect it has on space or possession.$mq$ from st;

-- Skills and Strategy > Leadership and Fair Play
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Skills and Strategy$mq$, 5, 4 from public.subjects s where s.slug = $mq$physical-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Leadership and Fair Play$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-health-education$mq$ and p.grade = 5 and p.name = $mq$Skills and Strategy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Leadership and Fair Play$mq$ and p.name = $mq$Skills and Strategy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Fair play means$mq$, $mq$["playing by the rules and showing respect for others","winning at any cost","only playing when winning","arguing with the referee"]$mq$, 0, $mq$Fair play includes honesty, respect and following the rules and the spirit of the game.$mq$, $mq$easy$mq$),
($mq$Which of these is a good example of sportsmanship?$mq$, $mq$["Mocking a losing team","Hiding an injury","Cheating to win","Shaking hands with opponents after a match"]$mq$, 3, $mq$Sportsmanship means showing respect and grace in both winning and losing.$mq$, $mq$easy$mq$),
($mq$Which is a responsibility of a team captain?$mq$, $mq$["Making all the decisions alone","Blaming players for mistakes","Encouraging teammates and communicating with officials respectfully","Choosing only friends to play"]$mq$, 2, $mq$Captains support the team, set a positive example and communicate in a calm way.$mq$, $mq$easy$mq$),
($mq$The role of a referee or official is to$mq$, $mq$["help one team win","apply the rules fairly and keep the game safe","coach players during the game","choose the team"]$mq$, 1, $mq$Officials make sure the rules are applied consistently. Players should respect their decisions.$mq$, $mq$easy$mq$),
($mq$Which of these is one of the Olympic values?$mq$, $mq$["Respect","Revenge","Rivalry","Reward"]$mq$, 0, $mq$The Olympic values are excellence, friendship and respect.$mq$, $mq$easy$mq$),
($mq$A player is fouled and the referee does not see it. The player who committed the foul admits it. This shows$mq$, $mq$["poor sportsmanship","gamesmanship","leadership failure","integrity"]$mq$, 3, $mq$Integrity means being honest even when you might not be caught.$mq$, $mq$medium$mq$),
($mq$Which behaviour is most likely to build a positive team culture?$mq$, $mq$["Shouting at players who make mistakes","Ignoring new players","Giving specific encouragement and listening to teammates","Blaming the coach"]$mq$, 2, $mq$Encouragement and listening build trust and help teams perform better.$mq$, $mq$medium$mq$),
($mq$A student leader organises a lunchtime game and makes sure everyone, including less skilled players, can join. This shows$mq$, $mq$["exclusion","inclusion","favouritism","dominating others"]$mq$, 1, $mq$Inclusion means making sure everyone has the chance to take part and feel valued.$mq$, $mq$medium$mq$),
($mq$Why are rules important in sport?$mq$, $mq$["They keep the game fair, safe and consistent for everyone","They make games longer","They stop players trying","They reward the stronger team only"]$mq$, 0, $mq$Rules protect players and give everyone the same conditions.$mq$, $mq$medium$mq$),
($mq$Which communication skill is most important for a leader during a tense match?$mq$, $mq$["Shouting at the referee","Staying silent","Criticising individuals publicly","Clear, calm and respectful communication"]$mq$, 3, $mq$Calm, clear messages keep a team focused. Public criticism can harm confidence.$mq$, $mq$medium$mq$),
($mq$A player wins a point by exploiting a loophole to waste time, though it is not clearly against the rules. This is an example of$mq$, $mq$["excellent fair play","teamwork","gamesmanship, which can go against the spirit of fair play","inclusion"]$mq$, 2, $mq$Gamesmanship bends the rules to gain an edge. Fair play follows both the rules and the spirit.$mq$, $mq$medium$mq$),
($mq$Which of these is an example of a leader showing responsibility for a mistake?$mq$, $mq$["Blaming a teammate","Admitting their error and focusing on how to fix it","Ignoring it","Leaving the team"]$mq$, 1, $mq$Good leaders take ownership and model problem-solving.$mq$, $mq$medium$mq$),
($mq$How can coaches and players show respect to officials after a decision they disagree with?$mq$, $mq$["Accept the decision calmly and raise concerns through the proper channel later","Shout at the official","Refuse to play","Insult the official"]$mq$, 0, $mq$Respectful behaviour accepts decisions in the moment. Concerns can be raised appropriately after the game.$mq$, $mq$medium$mq$),
($mq$A team is losing 5–0. A player begins to argue and tackle dangerously. What would a good leader do?$mq$, $mq$["Join in to match the aggression","Send the player off alone with no support","Quit the match","Calm the player, refocus the team on small achievable targets and model respect"]$mq$, 3, $mq$Leaders help teams to manage emotions and refocus. Aggression can lead to injuries and sanctions.$mq$, $mq$hard$mq$),
($mq$In a group task a leader notices a quiet member has not contributed. Which action best reflects effective leadership?$mq$, $mq$["Do their part for them","Leave them out","Invite them to share ideas and give them a role that suits their strengths","Criticise them in front of the group"]$mq$, 2, $mq$Effective leaders involve everyone and use individual strengths, building confidence and better results.$mq$, $mq$hard$mq$),
($mq$A coach gives an award for 'Most Respectful Player' at the end of the season. What is the best evaluation of this decision?$mq$, $mq$["It has no effect","It promotes fair play values alongside performance, though selection criteria should be clear","It is unfair because only winners matter","It teaches players to cheat"]$mq$, 1, $mq$Recognising respect shows it is valued as much as results, but clear criteria keep the award fair.$mq$, $mq$hard$mq$),
($mq$Which situation best shows the 'spirit of the game' being upheld?$mq$, $mq$["A player returns the ball so an injured opponent can get treatment","A player fakes injury to waste time","A player argues about every call","A team deliberately breaks rules when losing"]$mq$, 0, $mq$The spirit of the game values respect and concern for others above small advantages.$mq$, $mq$hard$mq$),
($mq$A school team's captain is also very skilled but often ignores less skilled teammates. Which advice would help most?$mq$, $mq$["Play more alone","Only pass to the best players","Stop captaining","Share the ball, praise effort and involve everyone so that the whole team improves"]$mq$, 3, $mq$Leadership is about helping the whole group. Involving all players builds morale and tactical options.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Leadership and Fair Play$mq$ and p.name = $mq$Skills and Strategy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$What is fair play?$mq$, $mq$Playing honestly, following the rules and the spirit of the game, and showing respect to opponents, teammates and officials.$mq$),
($mq$Spirit of the game$mq$, $mq$The idea that sport should be played with respect, honesty and concern for others, not just within the written rules.$mq$),
($mq$Define gamesmanship$mq$, $mq$Bending the rules or using tricks to gain an advantage without strictly breaking them. It is often seen as unsporting.$mq$),
($mq$Olympic values$mq$, $mq$Excellence, friendship and respect.$mq$),
($mq$Role of an official$mq$, $mq$To apply the rules fairly and consistently and to keep the game safe. Players should respect their decisions.$mq$),
($mq$Qualities of an effective leader$mq$, $mq$Clear communication, being a role model, inclusion, responsibility, motivation and good organisation.$mq$),
($mq$What is integrity in sport?$mq$, $mq$Being honest and doing the right thing even when no one would notice, such as admitting a foul.$mq$),
($mq$Why is inclusion important in teams?$mq$, $mq$It ensures everyone can take part and feel valued, which builds trust, morale and uses all players' strengths.$mq$),
($mq$How should a leader respond to a team setback?$mq$, $mq$Stay calm, give specific encouragement, set small achievable targets and keep everyone involved.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Leadership and Fair Play$mq$ and p.name = $mq$Skills and Strategy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Sport is more than winning. Leadership and fair play are about how we behave, treat others and help groups succeed. They are central to PHE because they show the values behind taking part.

## Fair play
Fair play means playing honestly, following the rules and respecting opponents, teammates and officials. It also means following the **spirit of the game**: not only what is allowed, but what is right. Examples of fair play:
- shaking hands after a match whatever the result;
- admitting a foul or a ball that went out of play;
- helping an injured opponent;
- accepting umpire decisions calmly.

Behaviour that breaks the spirit of fair play includes cheating, deliberately injuring someone, wasting time unfairly, abusing officials and mocking opponents. **Gamesmanship** is bending the rules to gain an advantage without strictly breaking them. It may not be illegal, but it is often considered unsporting.

## Why rules and officials matter
Rules keep the game fair, safe and consistent. Referees, umpires and judges apply them. Without respect for officials, games cannot run properly.

## Values in sport
The Olympic values are **excellence**, **friendship** and **respect**. Other values often linked to sport include honesty, teamwork, determination and inclusion.

## Leadership
A leader helps a group to work towards a shared goal. Leaders in sport include captains, coaches, officials and student organisers. Qualities of an effective leader:
- **Communication**: clear, calm, respectful speech and good listening;
- **Role model**: showing the behaviour you ask of others;
- **Inclusion**: involving all members and valuing different strengths;
- **Responsibility**: taking ownership of decisions and mistakes;
- **Motivation**: encouraging effort and helping the team recover from setbacks;
- **Organisation**: planning roles, warm-ups and tactics.

## Leadership in action
Leadership is a skill that can be learned and practised, so every student can lead in some way, for example by running a warm-up or explaining a rule to a new player. Imagine a team losing heavily and becoming frustrated. A good leader stays calm, gives specific encouragement, sets small targets (such as winning the next ten minutes) and keeps everyone involved. This improves confidence and helps prevent poor behaviour.

## Common mistakes
- Confusing leadership with being the best player or the loudest voice.
- Describing fair play only as "following the rules" without mentioning respect and the spirit of the game.
- Giving vague examples instead of specific behaviours.

## How this is examined
You may meet a scenario in which a player, captain or coach faces a conflict or an unfair situation. You will be asked to identify the value or leadership quality shown, explain its effect on the team and suggest a better response. Justify and evaluate command terms need reasons supported by the scenario.

Exam tip: Use precise vocabulary such as integrity, inclusion, respect and communication, and always connect it to what the people in the scenario actually did.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('physical-health-education')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;