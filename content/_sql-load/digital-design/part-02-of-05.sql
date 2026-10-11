-- Part 2 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- The Digital Design Cycle > Evaluating Digital Solutions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$The Digital Design Cycle$mq$, 5, 1 from public.subjects s where s.slug = $mq$digital-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Evaluating Digital Solutions$mq$, 5, p.id, 4
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$digital-design$mq$ and p.grade = 5 and p.name = $mq$The Digital Design Cycle$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Evaluating Digital Solutions$mq$ and p.name = $mq$The Digital Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which criterion covers Evaluating in the MYP design cycle?$mq$, $mq$["Criterion D","Criterion A","Criterion B","Criterion C"]$mq$, 0, $mq$Criterion D is Evaluating. It looks at testing, success and the impact of the solution.$mq$, $mq$easy$mq$),
($mq$What do you compare your finished product with when evaluating?$mq$, $mq$["Your favourite film","The cost of your computer","Your friend's opinion only","The design specification (success criteria)"]$mq$, 3, $mq$Evaluation measures how well the solution meets the success criteria.$mq$, $mq$easy$mq$),
($mq$Which is a suggested improvement?$mq$, $mq$["The product is perfect","I enjoyed the project","Adding a dark mode to help users with light sensitivity","The deadline was Friday"]$mq$, 2, $mq$Improvements are specific changes that would make the product better for users.$mq$, $mq$easy$mq$),
($mq$Who should give feedback for an evaluation?$mq$, $mq$["Only the designer","The target audience and other users","Nobody","Only the hardware company"]$mq$, 1, $mq$Feedback from the intended users gives the most useful evidence.$mq$, $mq$easy$mq$),
($mq$What does 'impact' mean in Criterion D?$mq$, $mq$["The effects the solution could have on people, society or the environment","The weight of the device","The speed of the processor","The price of the software"]$mq$, 0, $mq$Impact includes social, ethical and environmental effects as well as personal ones.$mq$, $mq$easy$mq$),
($mq$A success criterion was 'loads in under 3 seconds'. Five tests give 2.1, 2.8, 3.4, 2.5 and 2.2 seconds. How many tests met the criterion?$mq$, $mq$["5 out of 5","3 out of 5","1 out of 5","4 out of 5"]$mq$, 3, $mq$Only 3.4 seconds is over 3. The other four are under 3 seconds.$mq$, $mq$medium$mq$),
($mq$Using the same five tests (2.1, 2.8, 3.4, 2.5, 2.2 seconds), what is the mean load time?$mq$, $mq$["2.5 seconds","2.8 seconds","2.6 seconds","3.4 seconds"]$mq$, 2, $mq$Sum = 13.0. 13.0 ÷ 5 = 2.6 seconds.$mq$, $mq$medium$mq$),
($mq$A user says: 'The menu was hard to find.' What is the best way to use this in an evaluation?$mq$, $mq$["Ignore it because it is one comment","Link it to a usability criterion and suggest a clearer menu icon or label","Delete the menu","Write that users are confused by everything"]$mq$, 1, $mq$Good evaluation analyses feedback, links it to the criteria and proposes a specific improvement.$mq$, $mq$medium$mq$),
($mq$Which statement is evaluative rather than just descriptive?$mq$, $mq$["The search feature meets criterion 4 because 9 of 10 users found a result in under 10 seconds","The search feature is on the top right","I made the search feature on Tuesday","The search feature uses a blue icon"]$mq$, 0, $mq$Evaluation uses evidence to judge success against criteria.$mq$, $mq$medium$mq$),
($mq$A product works well but uses a lot of battery. Which is a fair way to report this?$mq$, $mq$["It is perfect","It is useless","Battery does not matter for apps","It meets the function criteria but fails the efficiency criterion, so optimisation is needed"]$mq$, 3, $mq$A balanced evaluation reports strengths and limitations.$mq$, $mq$medium$mq$),
($mq$Why is it useful to evaluate your own testing methods?$mq$, $mq$["Testing is never needed","Methods are always perfect","A small or biased test group may make results unreliable","It makes the report longer"]$mq$, 2, $mq$Reflecting on method limitations shows critical thinking, for example a sample of only 3 users.$mq$, $mq$medium$mq$),
($mq$What is the purpose of a user feedback questionnaire after testing?$mq$, $mq$["To change user passwords","To collect evidence about how well the product meets user needs","To advertise the product","To store cookies"]$mq$, 1, $mq$A questionnaire gathers evidence for evaluation against the success criteria.$mq$, $mq$medium$mq$),
($mq$Which type of evidence would best support a claim that a website is accessible?$mq$, $mq$["Testing with a screen reader and checking text contrast ratios","Saying the site looks nice","Counting the number of pages","Checking the site name is short"]$mq$, 0, $mq$Accessibility claims need evidence from tools or users who rely on accessibility features.$mq$, $mq$medium$mq$),
($mq$Eight users tried the app. Seven completed the task. One gave up. Another criterion says 'at least 90% of users can complete the task'. Does the app meet it?$mq$, $mq$["Yes, because 7 is nearly all","Yes, because 87.5% is above 90%","No, because 7 is an odd number","No, because 7 ÷ 8 = 87.5%, which is below 90%"]$mq$, 3, $mq$87.5% is below the 90% target, so the criterion is not met. Be exact when judging against a measurable criterion.$mq$, $mq$hard$mq$),
($mq$A designer writes: 'The app is great.' Which addition would best raise this to a high-level evaluation?$mq$, $mq$["A longer title","More emojis","Specific evidence from tests, a judgement against each criterion, and improvements","A thank-you list"]$mq$, 2, $mq$High-level evaluation is detailed, evidence-based and linked to criteria.$mq$, $mq$hard$mq$),
($mq$A new fitness-tracking app collects location data. What is a relevant impact to evaluate?$mq$, $mq$["Whether the logo is square","The effect on user privacy and whether data collection is necessary and consented to","How many files are in the folder","The number of colours used"]$mq$, 1, $mq$Evaluating impact should consider privacy, safety and ethical implications of data collection.$mq$, $mq$hard$mq$),
($mq$After testing, a designer plans to fix all problems at once without prioritising. What is the better approach?$mq$, $mq$["Prioritise fixes by effect on users and effort required","Fix only the easiest colours","Ignore all feedback","Fix in alphabetical order"]$mq$, 0, $mq$Prioritising focuses limited time on the improvements that matter most.$mq$, $mq$hard$mq$),
($mq$A designer claims 'users love the app' based on two friends' comments. What is the best critique?$mq$, $mq$["Friends are always the best source","Two is a statistically perfect number","The claim is true because it is positive","The sample is too small and biased to support the claim"]$mq$, 3, $mq$Evidence must come from a larger, more representative group to support strong claims.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Evaluating Digital Solutions$mq$ and p.name = $mq$The Digital Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Criterion D$mq$, $mq$Evaluating: design testing methods, evaluate against the specification, suggest improvements and explain impact.$mq$),
($mq$Evaluation$mq$, $mq$A judgement of how well a solution meets its success criteria, supported by evidence.$mq$),
($mq$Mean$mq$, $mq$The sum of the values divided by how many values there are.$mq$),
($mq$Percentage success$mq$, $mq$Number of successes ÷ total tests × 100.$mq$),
($mq$Met / partly met / not met$mq$, $mq$Ways to judge each success criterion with evidence.$mq$),
($mq$Improvement$mq$, $mq$A specific, realistic change linked to feedback or test results.$mq$),
($mq$Impact$mq$, $mq$The effect of a solution on users, society, privacy, safety and the environment.$mq$),
($mq$Test limitation$mq$, $mq$A weakness in how tests were done, such as a small or biased sample or one device only.$mq$),
($mq$User feedback$mq$, $mq$Opinions and observations from target users, used as evidence in evaluation.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Evaluating Digital Solutions$mq$ and p.name = $mq$The Digital Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What Criterion D asks for
Criterion D is Evaluating. After creating your solution you judge how well it works and what it means for the people who use it. It is marked in Levels 1-8. Higher levels use detailed evidence, careful judgement and thoughtful consideration of impact.

## The strands
- **Design detailed and relevant testing methods**, which generate data to measure the success of the solution.
- **Critically evaluate the success of the solution** against the design specification.
- **Explain how the solution could be improved.**
- **Explain the impact of the solution** on the client or target audience.

## Planning testing
Testing methods should produce useful data. Examples: timing how long a task takes, counting errors, asking users to complete a task while you watch, and giving a short questionnaire afterwards. Decide beforehand what a pass looks like. A test of "loads in under 3 seconds" is clear because it has a number.

## Evaluating against the specification
Go through your success criteria one by one. For each, state the evidence and judge: met, partly met or not met. Use numbers where possible.

Worked example: five load times are 2.1, 2.8, 3.4, 2.5 and 2.2 seconds. The criterion is under 3 seconds. Four of five tests pass. The mean is (2.1 + 2.8 + 3.4 + 2.5 + 2.2) ÷ 5 = 13.0 ÷ 5 = 2.6 seconds. You could write: "The mean load time of 2.6 seconds meets the criterion, but one test of 3.4 seconds failed, so performance is not fully reliable on slower connections."

## Percentages and thresholds
Be exact. If 7 of 8 users completed a task, that is 7 ÷ 8 × 100 = 87.5%. A target of 90% is not met. Do not round up to make results look better.

## Improvements
Suggest specific, realistic improvements linked to evidence. "Make it better" is weak. "Add text labels to the icons, because 4 of 8 users could not find the menu" is strong.

## Impact
Think about who is affected and how: the client, the users, other people and the environment. Consider accessibility, privacy, safety, wellbeing and cost. For example, an app that collects location data raises privacy questions, and a very data-heavy app may be difficult for users with limited internet.

## Limits of your testing
Be honest. A small group, a biased group or testing on only one device limits how far you can trust the results. Saying so shows critical thinking.

## How this is examined
Questions provide small data sets, such as times or pass counts, and ask you to calculate a mean or percentage, decide whether a criterion is met, choose the best improvement or identify a limitation in the testing.

## Common mistakes
- Describing the product rather than judging it.
- Using only opinions rather than evidence.
- Forgetting to discuss impact.
- Claiming success on a tiny sample.

Exam tip: Use the pattern claim, evidence, link to criterion, improvement.$mq$ from st;

-- Computational Thinking > Algorithms and Flowcharts
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Computational Thinking$mq$, 5, 2 from public.subjects s where s.slug = $mq$digital-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Algorithms and Flowcharts$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$digital-design$mq$ and p.grade = 5 and p.name = $mq$Computational Thinking$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Algorithms and Flowcharts$mq$ and p.name = $mq$Computational Thinking$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is an algorithm?$mq$, $mq$["A step-by-step set of instructions to solve a problem","A type of computer virus","A speed measure for a processor","A drawing of a screen layout"]$mq$, 0, $mq$An algorithm is a clear, ordered set of steps. It can be written as pseudocode or drawn as a flowchart.$mq$, $mq$easy$mq$),
($mq$In a flowchart, which shape is normally used for a decision such as 'Is age ≥ 13?'$mq$, $mq$["Rectangle","Oval","Parallelogram","Diamond"]$mq$, 3, $mq$A diamond shows a decision with two or more exits, such as Yes and No. Rectangles are processes and ovals are start or end.$mq$, $mq$easy$mq$),
($mq$Which shape in a flowchart marks the start or end of an algorithm?$mq$, $mq$["Diamond","Rectangle","Rounded oval (terminator)","Circle with a cross"]$mq$, 2, $mq$The terminator shape shows start and stop.$mq$, $mq$easy$mq$),
($mq$What is pseudocode?$mq$, $mq$["Code that has been encrypted","A plain-language, code-like way of writing an algorithm","A program that only runs on phones","A tool for editing photos"]$mq$, 1, $mq$Pseudocode describes the logic in structured English without worrying about exact syntax of a language.$mq$, $mq$easy$mq$),
($mq$What does 'decomposition' mean in computational thinking?$mq$, $mq$["Breaking a big problem into smaller parts","Deleting a program","Making a file smaller","Writing code in a new language"]$mq$, 0, $mq$Decomposition splits a complex problem into smaller, easier tasks.$mq$, $mq$easy$mq$),
($mq$Trace this algorithm: total = 0. FOR i from 1 to 4: total = total + i × 2. OUTPUT total. What is output?$mq$, $mq$["10","12","8","20"]$mq$, 3, $mq$Add 2, 4, 6, 8: total = 20.$mq$, $mq$medium$mq$),
($mq$A flowchart reads: INPUT n. If n MOD 2 = 0 then OUTPUT 'even', else OUTPUT 'odd'. What is output when n = 7?$mq$, $mq$["even","7","odd","0"]$mq$, 2, $mq$7 MOD 2 = 1, which is not 0, so the else branch runs and outputs 'odd'.$mq$, $mq$medium$mq$),
($mq$Which algorithm correctly finds the average of three numbers a, b and c?$mq$, $mq$["OUTPUT a + b + c ÷ 3","OUTPUT (a + b + c) ÷ 3","OUTPUT (a + b + c) × 3","OUTPUT a × b × c ÷ 3"]$mq$, 1, $mq$The sum must be in brackets before dividing by 3. Without brackets, only c would be divided.$mq$, $mq$medium$mq$),
($mq$A list holds 4, 9, 2, 7. A linear search looks for 2 starting at the first item. How many items are checked, including the match?$mq$, $mq$["3","1","2","4"]$mq$, 0, $mq$The search checks 4, then 9, then 2 and stops at the match: three comparisons.$mq$, $mq$medium$mq$),
($mq$count = 10. WHILE count > 3: count = count − 4. How many times does the loop run, and what is count at the end?$mq$, $mq$["3 times, count is −2","2 times, count is 6","1 time, count is 6","2 times, count is 2"]$mq$, 3, $mq$10 → 6 (still > 3) → 2 (not > 3), so 2 runs and the final value is 2.$mq$, $mq$medium$mq$),
($mq$Which is a good reason to draw a flowchart before coding?$mq$, $mq$["It makes the program run faster","It removes the need for testing","It shows the logic and makes errors easier to spot","It converts the program to binary"]$mq$, 2, $mq$Flowcharts help plan and communicate the logic, but the program must still be tested.$mq$, $mq$medium$mq$),
($mq$x = 5. y = x × 2. x = y − 3. OUTPUT x + y. What is the output?$mq$, $mq$["12","17","15","10"]$mq$, 1, $mq$y = 10. Then x = 10 − 3 = 7. Output 7 + 10 = 17.$mq$, $mq$medium$mq$),
($mq$Which action is an example of 'abstraction'?$mq$, $mq$["Showing only the stations and lines on a metro map and ignoring street details","Copying a map exactly","Printing a map in colour","Deleting a map"]$mq$, 0, $mq$Abstraction removes unnecessary detail to focus on what matters.$mq$, $mq$medium$mq$),
($mq$A list is 5, 2, 4, 1. One pass of bubble sort compares each pair from the left and swaps if the first is larger. What is the list after one pass?$mq$, $mq$["1, 2, 4, 5","2, 5, 4, 1","5, 4, 2, 1","2, 4, 1, 5"]$mq$, 3, $mq$5 swaps right past 2, 4 and 1, giving 2, 4, 1, 5. The list needs more passes to be sorted.$mq$, $mq$hard$mq$),
($mq$A sorted list has 64 items. A binary search halves the remaining items each step. About how many halvings reduce 64 items to 1?$mq$, $mq$["8","32","6","64"]$mq$, 2, $mq$64 → 32 → 16 → 8 → 4 → 2 → 1 takes 6 halvings. This is why binary search is efficient on sorted data.$mq$, $mq$hard$mq$),
($mq$A flowchart for a school lunch machine: INPUT balance, price. If balance ≥ price then balance = balance − price and OUTPUT 'Paid', else OUTPUT 'Top up'. balance = 3.50 and price = 3.50. What happens?$mq$, $mq$["Output 'Top up'","Output 'Paid' and balance becomes 0","Output 'Paid' and balance stays 3.50","The algorithm never ends"]$mq$, 1, $mq$3.50 ≥ 3.50 is true, so the machine takes payment and the balance is 0.$mq$, $mq$hard$mq$),
($mq$Two algorithms both find the largest value in a list of 1000 numbers. A checks every number once. B compares every number with every other number. Which is more efficient and why?$mq$, $mq$["A, because it needs far fewer comparisons","B, because it checks more","They are equal because they give the same answer","B, because it uses more loops"]$mq$, 0, $mq$Same answer, but A uses about 1000 steps while B uses about 1000 × 1000. Efficiency compares the number of steps.$mq$, $mq$hard$mq$),
($mq$An algorithm should output the largest of three numbers a, b, c. Which design is correct?$mq$, $mq$["If a > b then output a, else output c","Output a + b + c","If a > b then output a, else if b > c then output c","If a ≥ b and a ≥ c then output a, else if b ≥ c then output b, else output c"]$mq$, 3, $mq$The correct version tests every possibility. The others miss cases, for example when b is the largest.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Algorithms and Flowcharts$mq$ and p.name = $mq$Computational Thinking$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Algorithm$mq$, $mq$A clear, ordered set of steps that solves a problem.$mq$),
($mq$Decomposition$mq$, $mq$Breaking a complex problem into smaller, manageable parts.$mq$),
($mq$Abstraction$mq$, $mq$Removing unnecessary detail to focus on what matters.$mq$),
($mq$Pattern recognition$mq$, $mq$Spotting similarities or repeats so a solution can be reused.$mq$),
($mq$Sequence, selection, iteration$mq$, $mq$The three building blocks: steps in order, decisions (IF) and loops (FOR/WHILE).$mq$),
($mq$Flowchart shapes$mq$, $mq$Oval: start/end. Parallelogram: input/output. Rectangle: process. Diamond: decision.$mq$),
($mq$Pseudocode$mq$, $mq$Structured, plain-language description of an algorithm that is not tied to one language.$mq$),
($mq$Trace table$mq$, $mq$A table of variable values written step by step while following an algorithm by hand.$mq$),
($mq$Linear vs binary search$mq$, $mq$Linear checks items one by one. Binary halves a sorted list each step, so it is faster.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Algorithms and Flowcharts$mq$ and p.name = $mq$Computational Thinking$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is an algorithm?
An **algorithm** is a precise, step-by-step set of instructions that solves a problem. Computers cannot guess, so every step must be clear and in a sensible order. In Digital Design, algorithms are the plan behind a program, game or app. They support Criterion B (planning the solution) and Criterion C (creating it).

## The four parts of computational thinking
- **Decomposition**: break a big problem into smaller parts. A quiz app can be split into questions, scoring and results.
- **Pattern recognition**: spot things that repeat, so you can reuse a solution.
- **Abstraction**: ignore detail that does not matter. A metro map shows stations and lines, not street names.
- **Algorithm design**: write the steps in order.

## Three building blocks
Every algorithm is made from only three structures.
- **Sequence**: steps happen one after another, in order.
- **Selection**: a decision picks a path, using IF, THEN and ELSE.
- **Iteration**: a loop repeats steps, using FOR (a set number of times) or WHILE (until a condition changes).

## Pseudocode
Pseudocode is structured, plain language. Example:
INPUT score
IF score ≥ 50 THEN OUTPUT "Pass" ELSE OUTPUT "Try again"
It does not have to follow the rules of any single programming language, but it must be clear, ordered and consistent.

## Flowcharts
A flowchart draws the algorithm. The standard shapes are: a rounded oval for start and end, a parallelogram for input and output, a rectangle for a process (such as total = total + 1), and a diamond for a decision with labelled exits (Yes and No). Arrows show the flow. Check that every decision has two exits and every path eventually reaches the end.

## Tracing an algorithm
A **trace** means following the algorithm by hand and writing the value of each variable at every step. Example: total = 0. FOR i from 1 to 4, total = total + i × 2. The values are 2, 6, 12, 20, so total is 20 at the end. Tracing finds logic errors before you write any code.

## Searching and sorting
A **linear search** checks items one by one from the start. A **binary search** works on a sorted list and halves the search area each time: 64 items become 32, 16, 8, 4, 2, 1 in 6 halvings. A **bubble sort** compares neighbours and swaps them if they are in the wrong order. Starting with 5, 2, 4, 1, one pass gives 2, 4, 1, 5, and the largest value has moved to the end.

## Efficiency
Two algorithms can give the same answer but one may need far fewer steps. Efficient algorithms save time and energy, which matters when there is a lot of data.

## How this is examined
Typical items give a short algorithm or flowchart in a context (for example a ticket price calculator) and ask for the output for a given input, which shape is missing, how to fix a logic error, or which of two approaches is more efficient. Command terms: state, trace, complete, explain.

## Common mistakes
- Missing brackets in calculations, such as a + b + c ÷ 3.
- Loops that never end because the condition never changes.
- Forgetting the final ELSE case.
- Using the wrong flowchart shape.

Exam tip: Trace with a small table of variable values. Write each new value on its own line so you never lose track.$mq$ from st;

-- Computational Thinking > Programming Basics
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Computational Thinking$mq$, 5, 2 from public.subjects s where s.slug = $mq$digital-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Programming Basics$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$digital-design$mq$ and p.grade = 5 and p.name = $mq$Computational Thinking$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Programming Basics$mq$ and p.name = $mq$Computational Thinking$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a program?$mq$, $mq$["A set of instructions a computer can follow","A type of screen","A kind of cable","A list of passwords"]$mq$, 0, $mq$A program is code written in a programming language to make a computer do tasks.$mq$, $mq$easy$mq$),
($mq$Which of these is a loop?$mq$, $mq$["IF x > 3","INPUT name","OUTPUT 5","FOR i FROM 1 TO 10"]$mq$, 3, $mq$A FOR statement repeats a block of code. IF is selection.$mq$, $mq$easy$mq$),
($mq$What does a function do?$mq$, $mq$["Stores one number only","Deletes variables","Groups code into a named block that can be reused","Connects to the internet"]$mq$, 2, $mq$Functions help organise programs and avoid repeating code.$mq$, $mq$easy$mq$),
($mq$What is a syntax error?$mq$, $mq$["A program that is too fast","A mistake in the rules of the language, such as a missing bracket","A correct program with a wrong idea","A computer that overheats"]$mq$, 1, $mq$The language cannot understand code with a syntax error, so it will not run.$mq$, $mq$easy$mq$),
($mq$Which symbol in most languages checks if two values are equal?$mq$, $mq$["==","=","→","&&"]$mq$, 0, $mq$A single = usually assigns a value. == compares two values.$mq$, $mq$easy$mq$),
($mq$What is the output? name = 'Mia'. age = 15. print(name + ' is ' + str(age))$mq$, $mq$["Mia + is + 15","name is age","Mia is age","Mia is 15"]$mq$, 3, $mq$The strings are joined (concatenated) and age is converted to text with str().$mq$, $mq$medium$mq$),
($mq$What is the final value of n? n = 3. FOR i FROM 1 TO 3: n = n × 2$mq$, $mq$["9","12","24","18"]$mq$, 2, $mq$3 → 6 → 12 → 24 after three doublings.$mq$, $mq$medium$mq$),
($mq$A game gives 10 points per coin. A player collects 7 coins and loses 15 points for hitting a trap. What is the score after: score = coins × 10 − 15?$mq$, $mq$["70","55","85","−15"]$mq$, 1, $mq$7 × 10 = 70, then 70 − 15 = 55.$mq$, $mq$medium$mq$),
($mq$Which line makes the program ask the user for a number and store it as an integer?$mq$, $mq$["age = int(input('Age? '))","age = input() + 'int'","int = age(input)","print(age)"]$mq$, 0, $mq$input() reads text. int() converts it to a whole number.$mq$, $mq$medium$mq$),
($mq$The code IF mark >= 70 THEN grade = 'A' ELSE IF mark >= 50 THEN grade = 'B' ELSE grade = 'C' is used. What grade is given for mark = 50?$mq$, $mq$["A","C","No grade","B"]$mq$, 3, $mq$50 is not ≥ 70, but 50 ≥ 50 is true, so the grade is B.$mq$, $mq$medium$mq$),
($mq$A student's program should repeat until the user types 'quit'. Which structure fits best?$mq$, $mq$["FOR 1 TO 3","IF input is 'quit'","WHILE input is not 'quit'","OUTPUT 'quit'"]$mq$, 2, $mq$A WHILE loop repeats until a condition changes. The number of repeats is not known in advance.$mq$, $mq$medium$mq$),
($mq$Why do programmers add comments to code?$mq$, $mq$["To make the program faster","To explain what the code does for themselves and others","To change the colour of the output","To stop errors happening"]$mq$, 1, $mq$Comments are ignored when the program runs. They make code easier to read and maintain.$mq$, $mq$medium$mq$),
($mq$A function area(w, h) returns w × h. What does area(4, 6) return?$mq$, $mq$["24","10","20","46"]$mq$, 0, $mq$4 × 6 = 24. w and h are parameters that receive the values 4 and 6.$mq$, $mq$medium$mq$),
($mq$A program has total = 0. FOR i FROM 1 TO 5: IF i MOD 2 = 1 THEN total = total + i. What is total at the end?$mq$, $mq$["15","6","5","9"]$mq$, 3, $mq$Odd values are 1, 3, 5. 1 + 3 + 5 = 9.$mq$, $mq$hard$mq$),
($mq$A programmer expects 'Hello' to print 3 times but it prints 4 times: FOR i FROM 0 TO 3: print('Hello'). What is the most likely cause?$mq$, $mq$["The word Hello is too long","The computer is slow","The loop counts from 0 to 3 inclusive, which is 4 values","The loop should be a function"]$mq$, 2, $mq$0, 1, 2 and 3 are four values. This is an off-by-one error. Use 0 to 2 or 1 to 3 for three repeats.$mq$, $mq$hard$mq$),
($mq$The program runs but gives the wrong total because it adds tax twice. What type of error is this?$mq$, $mq$["A syntax error","A logic error","A hardware error","A network error"]$mq$, 1, $mq$The code runs without crashing but the logic gives the wrong result. Tracing and testing find it.$mq$, $mq$hard$mq$),
($mq$A shop program: price = 20. IF member THEN price = price × 0.9. IF price > 15 THEN price = price − 2. For a member, what is the final price?$mq$, $mq$["16","18","15.5","20"]$mq$, 0, $mq$20 × 0.9 = 18. Then 18 > 15, so 18 − 2 = 16.$mq$, $mq$hard$mq$),
($mq$Which change makes a program better structured when the same 10 lines of code appear in five places?$mq$, $mq$["Copy the lines again","Delete four copies without checking","Rename the variables","Put the lines in one function and call it five times"]$mq$, 3, $mq$Reusing a function reduces duplicates, makes fixes easier and keeps the code readable.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Programming Basics$mq$ and p.name = $mq$Computational Thinking$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Variable$mq$, $mq$A named storage location that holds a value which can change.$mq$),
($mq$Assignment$mq$, $mq$Giving a variable a value, for example score = 0.$mq$),
($mq$== vs =$mq$, $mq$== compares two values. = assigns a value to a variable.$mq$),
($mq$Function$mq$, $mq$A named, reusable block of code, often with parameters and a returned value.$mq$),
($mq$Syntax error$mq$, $mq$A mistake in the rules of the language, so the program will not run.$mq$),
($mq$Logic error$mq$, $mq$The program runs but gives wrong results because the instructions are wrong.$mq$),
($mq$Runtime error$mq$, $mq$An error that makes a program crash while it is running, such as dividing by zero.$mq$),
($mq$FOR vs WHILE$mq$, $mq$FOR repeats a set number of times. WHILE repeats until its condition is false.$mq$),
($mq$MOD$mq$, $mq$The remainder after division. For example 7 MOD 2 = 1.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Programming Basics$mq$ and p.name = $mq$Computational Thinking$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## From algorithm to program
Once you have an algorithm, you can turn it into a **program** by writing it in a programming language such as Python, JavaScript or Scratch. The language has strict rules called **syntax**. The computer follows your instructions exactly, so small mistakes matter. In the design cycle, writing a program belongs to Criterion C (Creating the solution).

## Core ideas
- **Variable**: a named place in memory that stores a value, such as score = 0.
- **Assignment**: giving a variable a value. Most languages use a single equals sign, so score = score + 1 means "take the old value, add 1 and store it back".
- **Input and output**: input() collects data from the user and print() shows a result.
- **Operators**: + - × (written *) ÷ (written /), MOD (remainder after division) and comparison operators such as ==, !=, <, > and >=.
- **Selection**: IF, ELSE IF and ELSE choose between paths.
- **Iteration**: FOR loops repeat a fixed number of times and WHILE loops repeat while a condition is true.
- **Function**: a named, reusable block of code. Parameters receive values and a return value gives a result back.

## Worked example
Pseudocode for a grading program:
INPUT mark
IF mark >= 70 THEN grade = "A"
ELSE IF mark >= 50 THEN grade = "B"
ELSE grade = "C"
OUTPUT grade
For mark = 50, the first test fails and the second succeeds, so the grade is "B". Always test boundaries such as 49, 50 and 70.

## Types of error
- **Syntax error**: you broke the rules of the language, such as a missing bracket. The program will not run.
- **Runtime error**: the program crashes while running, for example dividing by zero.
- **Logic error**: the program runs but gives the wrong result, such as adding tax twice.

**Debugging** is finding and fixing errors. Strategies include reading error messages, tracing by hand, printing values and testing small parts at a time.

## Good programming practice
Use meaningful names such as totalScore, not x. Add comments. Indent loops and decisions. Reuse code in functions instead of copying. Test with normal, boundary and invalid data. Save versions as you work.

## Off-by-one errors
FOR i FROM 0 TO 3 runs four times because 0, 1, 2 and 3 are all included. Many languages count from 0, so be careful about whether a loop includes its end value.

## How this is examined
Questions show short code or pseudocode within a context (a game score, a shop discount) and ask for the output, the final variable value, the type of error, or the best way to improve the structure. You may be asked to complete missing lines or to identify why a loop runs the wrong number of times.

## Common mistakes
- Using = when you mean ==.
- Forgetting to convert input to a number before calculating.
- Not testing boundary values.
- Writing one long block of code instead of functions.

Exam tip: When you trace code, work line by line and write the value of each variable. Do not try to do it in your head.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('digital-design')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;