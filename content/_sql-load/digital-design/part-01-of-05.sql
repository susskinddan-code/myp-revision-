-- Part 1 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- The Digital Design Cycle > Inquiring and Analysing a Need
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$The Digital Design Cycle$mq$, 5, 1 from public.subjects s where s.slug = $mq$digital-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Inquiring and Analysing a Need$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$digital-design$mq$ and p.grade = 5 and p.name = $mq$The Digital Design Cycle$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Inquiring and Analysing a Need$mq$ and p.name = $mq$The Digital Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In the MYP design cycle, which criterion is about Inquiring and analysing?$mq$, $mq$["Criterion A","Criterion B","Criterion C","Criterion D"]$mq$, 0, $mq$Criterion A is Inquiring and analysing. B is Developing ideas, C is Creating the solution and D is Evaluating.$mq$, $mq$easy$mq$),
($mq$What is a design brief?$mq$, $mq$["A finished prototype of the product","A list of the materials the designer owns","A report on how well the product sold","A short statement of the problem to be solved and what the solution should achieve"]$mq$, 3, $mq$A brief summarises the need or problem and the aim of the solution. It comes at the start of the project.$mq$, $mq$easy$mq$),
($mq$Which of these is a primary source of research?$mq$, $mq$["A magazine article about apps","A website about phone history","A survey you give to your classmates","A textbook chapter on usability"]$mq$, 2, $mq$Primary research is collected first-hand by you, for example with surveys, interviews and observations.$mq$, $mq$easy$mq$),
($mq$Who is the 'target audience' of a digital product?$mq$, $mq$["The person who programs the product","The group of people the product is designed for","The company that pays for the hosting","The teacher who marks the project"]$mq$, 1, $mq$The target audience (or end user) is the group the solution is meant to help. Their needs shape the design.$mq$, $mq$easy$mq$),
($mq$A student writes: 'Many Year 7 students forget homework deadlines.' What part of the cycle does this belong to?$mq$, $mq$["Identifying and explaining the problem","Testing the prototype","Writing the evaluation","Choosing the file format"]$mq$, 0, $mq$Explaining the need or problem is the first strand of Criterion A.$mq$, $mq$easy$mq$),
($mq$A designer wants to build a timetable app for her school. She surveys 40 students and finds 30 say they check the timetable on a phone. What percentage is this?$mq$, $mq$["30%","40%","133%","75%"]$mq$, 3, $mq$30 ÷ 40 × 100 = 75%. This is useful evidence that a phone-friendly design is needed.$mq$, $mq$medium$mq$),
($mq$Which question in a survey would give the most useful data for a revision app?$mq$, $mq$["Do you like apps?","Is revising good?","How many minutes do you usually spend revising on a school night?","Would a great app be something you want?"]$mq$, 2, $mq$It is specific, neutral and measurable. The others are vague or leading questions.$mq$, $mq$medium$mq$),
($mq$Which survey question is a leading question?$mq$, $mq$["How often do you visit the school website?","Don't you agree that our school website is confusing?","Which page do you visit most often?","What would you change about the school website?"]$mq$, 1, $mq$A leading question pushes the answer. Good surveys use neutral wording so results are not biased.$mq$, $mq$medium$mq$),
($mq$A designer lists: 'must work offline', 'must be readable by users with poor eyesight', 'must load in under 3 seconds'. What is this list?$mq$, $mq$["A design specification of success criteria","A bibliography","A test plan for the final product","A flowchart of the algorithm"]$mq$, 0, $mq$A specification lists measurable requirements the final solution must meet. It is also used later for evaluation.$mq$, $mq$medium$mq$),
($mq$Why is it important to research existing products (similar solutions)?$mq$, $mq$["To copy their code exactly and submit it","To prove that nobody else has had the idea","To avoid doing a survey","To find strengths and weaknesses that can inform your own design"]$mq$, 3, $mq$Analysing existing products shows what works and what to improve. Copying without credit is plagiarism.$mq$, $mq$medium$mq$),
($mq$A designer interviews a user with a visual impairment about a news app. Which finding should most influence the specification?$mq$, $mq$["The user likes the colour blue","The user has used the app for two years","The user relies on a screen reader and needs clear text labels","The user reads news in the evening"]$mq$, 2, $mq$A requirement about accessibility directly affects design decisions, so it belongs in the specification.$mq$, $mq$medium$mq$),
($mq$Which source would be most reliable for research on safe password practice?$mq$, $mq$["An anonymous forum post","A national cyber-security agency website","An advert for a password manager","A video with no author named"]$mq$, 1, $mq$Reliable sources have an expert author, a clear purpose and up-to-date information. Adverts and anonymous posts are biased or unverifiable.$mq$, $mq$medium$mq$),
($mq$A student gathers research but never links it to the design. What is the main weakness?$mq$, $mq$["The research does not justify any design decisions","The research is too accurate","The research was done too early","The research uses too many sources"]$mq$, 0, $mq$In Criterion A, research must be analysed so it leads to a clear brief, not just collected.$mq$, $mq$medium$mq$),
($mq$A club needs a booking website. Survey results: 18 of 24 members use phones, 4 use tablets, 2 use laptops. A designer concludes 'the site must work only on phones'. What is the best critique?$mq$, $mq$["The conclusion is correct because most users prefer phones","The sample is too accurate to be used","The data shows nobody uses laptops","18 of 24 is 75%, so mobile-first is sensible, but tablets and laptops (25%) still need a usable layout"]$mq$, 3, $mq$A majority justifies mobile-first design, not mobile-only. The other 25% of users should still be supported (responsive design).$mq$, $mq$hard$mq$),
($mq$A designer wants to know how people really use a ticket kiosk. Which method gives the most valid evidence of actual behaviour, not just opinions?$mq$, $mq$["Asking users if they like kiosks","Reading the kiosk's advertising","Observing users while they try to buy a ticket","Counting how many kiosks exist"]$mq$, 2, $mq$Observation shows what people do, which can differ from what they say they do.$mq$, $mq$hard$mq$),
($mq$A survey of 200 people was sent only to members of a gaming club about a new homework planner for all students. What is the main limitation?$mq$, $mq$["The sample is too large","The sample is biased and may not represent the whole target audience","Surveys cannot be used for planners","Gaming clubs do not use computers"]$mq$, 1, $mq$A sample should represent the target audience. Using only one group can give unrepresentative results.$mq$, $mq$hard$mq$),
($mq$Which specification statement is best written as a measurable success criterion?$mq$, $mq$["The app will display search results within 2 seconds on a school Wi-Fi connection","The app will be fast and nice to use","The app will look modern","The app will be popular with students"]$mq$, 0, $mq$Measurable criteria can be tested in Criterion D. Words like fast, nice and modern are vague.$mq$, $mq$hard$mq$),
($mq$A designer's analysis concludes: 'Users are older, so use larger text and high contrast, and avoid small icons without labels.' Which Criterion A strand does this best show?$mq$, $mq$["Evaluating the final product","Writing pseudocode","Creating a file naming system","Using research findings to develop a specification that responds to user needs"]$mq$, 3, $mq$The designer has analysed user data and turned it into design requirements. This links research to the specification.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Inquiring and Analysing a Need$mq$ and p.name = $mq$The Digital Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Criterion A$mq$, $mq$Inquiring and analysing: explain the need, plan research, analyse existing products, and write a design brief and specification.$mq$),
($mq$Design brief$mq$, $mq$A short statement of the problem, the target audience and what the solution should achieve.$mq$),
($mq$Primary research$mq$, $mq$Information you collect yourself, for example with surveys, interviews and observations.$mq$),
($mq$Secondary research$mq$, $mq$Information from existing sources such as websites, books and reports. Check reliability.$mq$),
($mq$Leading question$mq$, $mq$A survey question worded to push the answer, for example 'Don't you agree...?'. It causes bias.$mq$),
($mq$Biased sample$mq$, $mq$A group of respondents that does not represent the target audience, so results may mislead.$mq$),
($mq$Design specification$mq$, $mq$A list of measurable success criteria the final solution must meet.$mq$),
($mq$Measurable criterion$mq$, $mq$A requirement that can be tested, such as 'loads in under 3 seconds'.$mq$),
($mq$Analysis of existing products$mq$, $mq$Comparing similar products to find strengths, weaknesses and ideas for your design.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Inquiring and Analysing a Need$mq$ and p.name = $mq$The Digital Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What Criterion A asks for
Every MYP design project begins with Criterion A: Inquiring and analysing. Your goal is to show you understand a problem well enough to design something that genuinely helps real people. In Digital Design the solution is a digital product, such as an app, a website, a game, a database or a piece of media. Criterion A is marked in Levels 1-8, and the top levels need detailed, justified work rather than just a list of facts.

## The four strands
- **Explain and justify the need** for a solution to a problem. Say who has the problem, where it happens and why it matters. Use a real context, such as a school, a club or a local business.
- **Identify and prioritise research** needed to design a solution. Decide what you need to find out before you start, for example who the users are, what devices they own and what rules apply.
- **Analyse a range of existing products** that inspire the solution. Look at at least two or three similar apps or sites. Describe what each does well, what it does badly and what you can learn.
- **Develop a detailed design brief**, which states the problem, the target audience and the key features of the solution, and a **design specification** of success criteria.

## Primary and secondary research
**Primary research** is collected by you. Examples are surveys, interviews and observations. **Secondary research** comes from existing sources such as websites, articles, reports and books. Strong projects use both. Always record where information came from, and judge reliability by asking: Who wrote it? Why? When? Is it biased?

## Good survey and interview questions
Keep questions neutral and specific. A leading question such as "Don't you think the site is slow?" pushes the answer. A better question is "How would you describe the loading speed of the site?" Closed questions give numbers you can count. Open questions give richer ideas. Aim for a sample that represents your target audience. If you ask only your friends, your data could be biased.

## Worked example
A student surveys 50 classmates about a homework app. 35 say they forget deadlines weekly. 35 ÷ 50 × 100 = 70%. The student writes: "70% of the sample forget deadlines weekly, so a reminder feature is a high priority." Notice that the number leads to a design decision. That link is what the highest levels reward.

## The specification
A specification is a list of success criteria. Good criteria are measurable, so you can test them later in Criterion D. Compare "The app must be easy" (vague) with "A new user must be able to add a deadline in under 30 seconds with no help" (measurable). Include functional needs (what it does), usability and accessibility needs, and constraints such as time, device, budget or law.

## How this is examined
In the eAssessment-style questions you are given a short scenario, such as a school needing a booking system, with small data sets like survey results. You may be asked to calculate a percentage, choose the best research method, spot a leading question or biased sample, or decide which finding should shape the specification. Command terms such as state, outline, justify and analyse tell you how much depth is needed.

## Common mistakes
- Listing research without explaining what it means for the design.
- Writing vague criteria that cannot be tested.
- Surveying a sample that does not match the target audience.
- Copying text from websites without a source.

Exam tip: When asked to justify, always link the evidence (a number or a user comment) to a specific design decision.$mq$ from st;

-- The Digital Design Cycle > Developing Digital Ideas
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$The Digital Design Cycle$mq$, 5, 1 from public.subjects s where s.slug = $mq$digital-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Developing Digital Ideas$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$digital-design$mq$ and p.grade = 5 and p.name = $mq$The Digital Design Cycle$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Developing Digital Ideas$mq$ and p.name = $mq$The Digital Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which criterion covers Developing ideas in the MYP design cycle?$mq$, $mq$["Criterion B","Criterion A","Criterion C","Criterion D"]$mq$, 0, $mq$Criterion B is Developing ideas. It includes design ideas, a chosen design and a plan.$mq$, $mq$easy$mq$),
($mq$What is a wireframe?$mq$, $mq$["A finished website with all images","A list of survey results","A piece of code that fixes bugs","A simple outline sketch of a screen layout without final graphics"]$mq$, 3, $mq$Wireframes show where elements go on a screen. They are quick and cheap to change.$mq$, $mq$easy$mq$),
($mq$What is a storyboard used for in digital design?$mq$, $mq$["Storing passwords","Compressing a video file","Showing a sequence of screens or scenes in order","Counting website visitors"]$mq$, 2, $mq$A storyboard lays out the order of screens, animation frames or user steps.$mq$, $mq$easy$mq$),
($mq$Why should a designer produce more than one design idea?$mq$, $mq$["Because one idea is always wrong","To compare options before choosing the best one","To make the project longer","So the teacher can pick one"]$mq$, 1, $mq$Generating several ideas lets you compare them against the specification and justify your choice.$mq$, $mq$easy$mq$),
($mq$Which tool is best for planning the order of tasks and deadlines for a project?$mq$, $mq$["A Gantt chart or timeline","A spell checker","A colour wheel","A firewall"]$mq$, 0, $mq$A Gantt chart or plan shows tasks, durations and order, which is part of the Criterion B plan.$mq$, $mq$easy$mq$),
($mq$A designer produces three layouts for a school news app. Which next step best shows evaluation of ideas?$mq$, $mq$["Choose the layout with the brightest colours","Pick the layout drawn first","Combine all three without explanation","Compare each layout against the specification and explain which meets most criteria"]$mq$, 3, $mq$Choosing a design must be justified using the success criteria, not personal taste.$mq$, $mq$medium$mq$),
($mq$A specification says 'every button must be at least 44 pixels tall for touch screens'. Which design detail shows this has been considered?$mq$, $mq$["A colour palette","A list of fonts","An annotated wireframe with button sizes labelled","A copyright notice"]$mq$, 2, $mq$Annotations on a design link features to the specification.$mq$, $mq$medium$mq$),
($mq$Why might a designer create a mood board?$mq$, $mq$["To calculate the file size","To explore colours, fonts and style that suit the audience","To debug an algorithm","To collect user passwords"]$mq$, 1, $mq$Mood boards collect visual inspiration so design choices fit the theme and audience.$mq$, $mq$medium$mq$),
($mq$A designer lists tasks: A design logo (2 days), B build home page (3 days, after A), C test (1 day, after B). What is the minimum total time if the tasks are done one after another?$mq$, $mq$["6 days","3 days","5 days","7 days"]$mq$, 0, $mq$Since each task depends on the previous one: 2 + 3 + 1 = 6 days.$mq$, $mq$medium$mq$),
($mq$A project plan lists 'Create the solution' as one task of 10 hours with no detail. How could it be improved?$mq$, $mq$["Delete the plan","Use a longer title","Add more colours","Break it into smaller steps with time estimates and the order they will be done"]$mq$, 3, $mq$A detailed plan has logical steps, time estimates, resources and a sequence that someone else could follow.$mq$, $mq$medium$mq$),
($mq$Which is a valid reason to choose a sans-serif font for an app interface?$mq$, $mq$["It is always the cheapest font","It cannot be read by screen readers","It is often clear and readable on screens at small sizes","It is required by law"]$mq$, 2, $mq$Sans-serif fonts are commonly used for on-screen text because they stay clear at small sizes.$mq$, $mq$medium$mq$),
($mq$A designer's final chosen design has no explanation of why it was chosen. Which strand is missing?$mq$, $mq$["Creating a bibliography","Justifying the chosen design with reference to the specification","Writing the algorithm","Testing for bugs"]$mq$, 1, $mq$Criterion B requires you to present the chosen design and justify it.$mq$, $mq$medium$mq$),
($mq$A designer sketches a home screen with the main menu at the bottom for thumb reach. Which specification need does this most directly support?$mq$, $mq$["Ease of use on a phone held in one hand","Faster server speed","Stronger password rules","Lower file size for videos"]$mq$, 0, $mq$Placing controls where a thumb can reach supports usability on mobile devices.$mq$, $mq$medium$mq$),
($mq$A designer compares two navigation layouts. Layout 1 needs 2 taps to reach any page. Layout 2 needs 3 taps for 4 of 10 pages and 1 tap for the rest. Which has the lower average taps per page?$mq$, $mq$["Layout 1 with an average of 2 taps","Layout 2 with an average of 2.4 taps","They are equal at 2 taps","Layout 2 with an average of 1.8 taps"]$mq$, 3, $mq$Layout 2: (4 × 3 + 6 × 1) ÷ 10 = 18 ÷ 10 = 1.8 taps, lower than Layout 1 at 2.$mq$, $mq$hard$mq$),
($mq$A designer's success criteria include 'works for colour-blind users'. Which design feature best meets this?$mq$, $mq$["Using red and green only","Making the screen brighter","Using labels and patterns as well as colour to show status","Using only animations"]$mq$, 2, $mq$Information should not depend on colour alone. Text labels and patterns help users with colour-vision deficiency.$mq$, $mq$hard$mq$),
($mq$A planning chart shows task X taking 4 hours and task Y taking 5 hours, but Y cannot start until X finishes. A third task Z (3 hours) can run at the same time as X and Y. What is the shortest time to finish all three if two people work in parallel?$mq$, $mq$["12 hours","9 hours","4 hours","5 hours"]$mq$, 1, $mq$The chain X then Y takes 4 + 5 = 9 hours. Z (3 hours) runs alongside, so the total is 9 hours.$mq$, $mq$hard$mq$),
($mq$A designer rejects idea 2 because it 'does not look cool'. Which improvement would make this a stronger justification?$mq$, $mq$["Refer to a specific success criterion that idea 2 fails, such as readability or load time","Say the idea is not fashionable","Delete idea 2 from the portfolio","Ask a friend to choose"]$mq$, 0, $mq$A justification needs evidence linked to the specification, not opinion alone.$mq$, $mq$hard$mq$),
($mq$Which set of planning items shows the most complete Criterion B plan?$mq$, $mq$["A title and a date","A list of apps installed on the computer","A single colour scheme","Ordered steps, time estimates, resources needed and checkpoints for testing"]$mq$, 3, $mq$A complete plan allows another person to follow it and includes sequencing, timings and resources.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Developing Digital Ideas$mq$ and p.name = $mq$The Digital Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Criterion B$mq$, $mq$Developing ideas: success criteria, design ideas, chosen design with justification, and a plan.$mq$),
($mq$Wireframe$mq$, $mq$A simple outline of a screen layout showing where elements go, before graphics are added.$mq$),
($mq$Storyboard$mq$, $mq$A sequence of drawings showing the order of screens, scenes or user steps.$mq$),
($mq$Mood board$mq$, $mq$A collage of colours, fonts and images that sets the style for a design.$mq$),
($mq$Site map$mq$, $mq$A diagram showing how the pages of a website are organised and linked.$mq$),
($mq$Gantt chart$mq$, $mq$A bar chart showing tasks, their durations and their order over time.$mq$),
($mq$Dependent task$mq$, $mq$A task that cannot start until another task has finished.$mq$),
($mq$Justifying a design$mq$, $mq$Explaining why the chosen design is best, using evidence from the specification.$mq$),
($mq$Annotation$mq$, $mq$A label on a design that explains a feature, size or reason for a decision.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Developing Digital Ideas$mq$ and p.name = $mq$The Digital Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What Criterion B asks for
Criterion B is Developing ideas. Once you have a clear brief from Criterion A, you now write your specification and generate design ideas, choose the best one and plan how to make it. Criterion B is marked in Levels 1-8. Higher levels need ideas that are detailed, linked to the specification and clearly justified.

## The strands
- **Develop a list of success criteria** for the design of a solution (your specification refined into things you can test).
- **Present relevant design ideas**, which can be evaluated, to be created. Show more than one idea.
- **Present the chosen design** and outline reasons for its selection.
- **Develop accurate planning drawings and diagrams**, and outline the requirements for the creation of the chosen solution.

## Generating ideas
Start with quick ideas. Thumbnail sketches, wireframes, storyboards and mood boards are all useful. A **wireframe** is a simple outline of a screen that shows where things go: the header, menu, buttons and content. A **storyboard** shows a sequence, such as the screens a user passes through to buy a ticket. A **mood board** collects colours, fonts and images that give the right feel for the audience. A **site map** or **flowchart** shows how pages or steps connect.

## Design thinking for digital products
Think about the user. Check each idea against the specification. Questions to ask include: Is it readable? Is it accessible? Does it work on small screens? Will it be quick to use? Use clear annotations on each design, for example "Button 44 pixels tall for easy tapping" or "High-contrast text for readability".

## Choosing and justifying
Do not choose a design because you simply like it. Compare ideas against the success criteria, for instance with a table in words: idea 1 meets four of six criteria, idea 2 meets six of six. Then explain the choice using that evidence. You may combine the best parts of several ideas, but explain why.

## Planning
A plan lists the steps to create the solution in order, with time estimates, the resources you need (software, assets, devices) and when you will test. A **Gantt chart** is a bar chart of tasks against time. If task B cannot start until task A finishes, B is dependent on A. Tasks that do not depend on each other can run at the same time, which shortens the total time. Example: A takes 2 days, B takes 3 days after A, C takes 1 day after B. The total is 2 + 3 + 1 = 6 days.

## How this is examined
Expect a scenario such as designing a booking app, then questions asking which design best meets given criteria, how to read a simple plan or timeline, how to calculate a duration, or which justification is strongest. You may be asked to evaluate two layouts using simple numbers, such as the average number of taps to reach a page.

## Common mistakes
- Only one idea, or ideas that are nearly identical.
- Choosing a design with no reference to the specification.
- Plans with vague steps such as "make the app".
- Designs with no annotations or sizes.

Exam tip: A strong justification names a criterion, gives evidence from the design and states the result in a clear sentence.$mq$ from st;

-- The Digital Design Cycle > Creating and Testing
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$The Digital Design Cycle$mq$, 5, 1 from public.subjects s where s.slug = $mq$digital-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Creating and Testing$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$digital-design$mq$ and p.grade = 5 and p.name = $mq$The Digital Design Cycle$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Creating and Testing$mq$ and p.name = $mq$The Digital Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which criterion covers Creating the solution?$mq$, $mq$["Criterion C","Criterion A","Criterion B","Criterion D"]$mq$, 0, $mq$Criterion C is Creating the solution. Criterion D is Evaluating.$mq$, $mq$easy$mq$),
($mq$What is a prototype?$mq$, $mq$["The final advert for the product","A list of bugs","A type of password","An early working model used to test ideas before the final product"]$mq$, 3, $mq$Prototypes let designers test and improve a design before investing in the final version.$mq$, $mq$easy$mq$),
($mq$What is a bug?$mq$, $mq$["A virus that you install on purpose","A type of keyboard","An error in a program or product that causes unexpected behaviour","A colour setting"]$mq$, 2, $mq$A bug is a fault. Testing and debugging help find and fix them.$mq$, $mq$easy$mq$),
($mq$Which action is part of good version control for a project?$mq$, $mq$["Overwriting the only copy every day","Saving files with clear names and dates, and keeping earlier versions","Deleting the old files","Using the name 'final final 2'"]$mq$, 1, $mq$Keeping dated, clearly named versions lets you go back if something breaks and shows your process.$mq$, $mq$easy$mq$),
($mq$What does 'testing' a digital product mean?$mq$, $mq$["Checking that it works as intended and meets the success criteria","Printing it out","Changing its colour","Uploading it to social media"]$mq$, 0, $mq$Testing compares real results with expected results and with the specification.$mq$, $mq$easy$mq$),
($mq$A designer logs: 'Button should save the form. Result: nothing happens on mobile.' What type of record is this?$mq$, $mq$["A bibliography","A mood board","A site map","A test log comparing expected and actual results"]$mq$, 3, $mq$Test logs record the test, expected result, actual result and any fix made.$mq$, $mq$medium$mq$),
($mq$A login form must reject empty passwords. Which test data is most useful to check this?$mq$, $mq$["A very long username","A correct password","An empty password field","A password with emojis"]$mq$, 2, $mq$Testing the boundary or invalid case, an empty input, checks the validation rule directly.$mq$, $mq$medium$mq$),
($mq$A game asks for an age between 10 and 18. Which set contains normal, boundary and invalid test data in that order?$mq$, $mq$["10, 18, 14","14, 10, 5","5, 100, abc","14, 14, 14"]$mq$, 1, $mq$Normal data is typical (14). Boundary data sits at the limit (10 or 18). Invalid data is outside the allowed range or type (5).$mq$, $mq$medium$mq$),
($mq$Why should a designer test with real users as well as testing it personally?$mq$, $mq$["Users may find problems the designer cannot see","Designers never make errors","Users can only test colours","It makes the code shorter"]$mq$, 0, $mq$The designer knows the product too well. Fresh users reveal usability problems.$mq$, $mq$medium$mq$),
($mq$A designer must change the plan because an image license does not allow commercial use. What does this show?$mq$, $mq$["The project has failed","The plan should be ignored","Licences never matter","A justified change to the plan, which should be recorded"]$mq$, 3, $mq$Criterion C rewards recording changes and the reasons for them, including legal issues.$mq$, $mq$medium$mq$),
($mq$Which item best shows 'technical skills' in Criterion C?$mq$, $mq$["A long essay about colours","A screenshot of the home screen only","A working feature built with appropriate tools such as layers, functions or styles","A list of websites visited"]$mq$, 2, $mq$Criterion C looks for effective use of tools and techniques, shown with evidence such as annotated screenshots.$mq$, $mq$medium$mq$),
($mq$A student's app crashes when the user types a letter in the age field. Which fix is most appropriate?$mq$, $mq$["Remove the age field","Add input validation that accepts only numbers","Change the font","Make the button bigger"]$mq$, 1, $mq$Validation checks input before using it and prevents errors from unexpected data.$mq$, $mq$medium$mq$),
($mq$A designer renames files as 'logo_v1', 'logo_v2' and 'logo_v3' with dates in a notes file. What good practice is this?$mq$, $mq$["Version control with clear naming","Data encryption","Image compression","Phishing prevention"]$mq$, 0, $mq$Numbered, dated versions let the designer track changes and return to an earlier version.$mq$, $mq$medium$mq$),
($mq$A tester runs 25 test cases. 22 pass and 3 fail. After fixes, 2 of the 3 now pass. What percentage of all 25 cases pass now?$mq$, $mq$["88%","92%","100%","96%"]$mq$, 3, $mq$22 + 2 = 24 pass. 24 ÷ 25 × 100 = 96%.$mq$, $mq$hard$mq$),
($mq$A designer builds a quiz app and finds that scores display as 'NaN' when a question is skipped. Which is the most likely cause?$mq$, $mq$["The screen resolution is too high","The font is missing","A calculation uses an empty value that is not a number","The Wi-Fi is too slow"]$mq$, 2, $mq$NaN means 'not a number'. Calculations on empty or missing data produce this error.$mq$, $mq$hard$mq$),
($mq$Two testers report different results for the same feature. Tester A uses a phone, tester B uses a laptop. What should the designer conclude first?$mq$, $mq$["Tester A is wrong","The bug may depend on the device, so test on both and record the details","The feature is fine","The testers should swap names"]$mq$, 1, $mq$Different environments can behave differently. Recording the device and browser helps reproduce bugs.$mq$, $mq$hard$mq$),
($mq$Which approach best shows iterative development?$mq$, $mq$["Build a small version, test it, fix problems, then add features and repeat","Build everything then test once at the end","Test before writing a brief","Copy another project"]$mq$, 0, $mq$Iterative development repeats build-test-improve cycles, finding errors early.$mq$, $mq$hard$mq$),
($mq$A student uses free music in an app without checking the licence. Which risk is most relevant?$mq$, $mq$["The music will use too much colour","The app will become slower on every phone","The app will become more accessible","A copyright breach, because the licence may not allow that use"]$mq$, 3, $mq$Using media requires respecting copyright and licence terms. Credit and permission are part of ethical practice.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Creating and Testing$mq$ and p.name = $mq$The Digital Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Criterion C$mq$, $mq$Creating the solution: follow your plan, show technical skill, justify changes and present the working product.$mq$),
($mq$Prototype$mq$, $mq$An early working model used to test and improve a design.$mq$),
($mq$Test log$mq$, $mq$A record of each test: test data, expected result, actual result and any fix.$mq$),
($mq$Normal data$mq$, $mq$Typical valid values the product should accept.$mq$),
($mq$Boundary data$mq$, $mq$Values at the very edge of the allowed range, such as the minimum and maximum.$mq$),
($mq$Invalid data$mq$, $mq$Values that should be rejected, such as letters in a number field.$mq$),
($mq$Validation$mq$, $mq$Checking that input is sensible and allowed before the program uses it.$mq$),
($mq$Iterative development$mq$, $mq$Repeating build, test and improve steps to refine a product.$mq$),
($mq$Version control$mq$, $mq$Saving clearly named, dated versions so you can return to earlier work.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Creating and Testing$mq$ and p.name = $mq$The Digital Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What Criterion C asks for
Criterion C is Creating the solution. You turn your chosen design and plan into a working digital product, record how you did it, and show that it is good enough to be tested. Criterion C is marked in Levels 1-8. Higher levels show strong technical skills, clear evidence and the ability to follow and adapt your plan.

## The strands
- **Construct a logical plan**, which describes the efficient use of time and resources, sufficient for peers to be able to follow to produce the solution.
- **Demonstrate excellent technical skills** when making the solution.
- **Follow the plan** to create the solution, which functions as intended.
- **Fully justify changes** made to the chosen design and plan when making the solution.
- **Present the solution** as a whole, with evidence of its creation (for example annotated screenshots).

## Building a digital solution
Work in stages. Create a **prototype** first, a small working version with the main features, then add features. Keep evidence of each stage: screenshots of the work in progress, short notes on tools used and problems solved. Use good **file management**: meaningful names, folders and dates, and keep earlier versions. If something breaks you can go back.

## Testing
**Testing** means checking that the product works and meets the success criteria. Plan tests before you run them. A **test log** records: what is tested, the test data, the expected result, the actual result and any fix. Types of test data:
- **Normal data**: typical values that should work.
- **Boundary data**: values at the edge of the allowed range.
- **Invalid data**: values that should be rejected, such as text in a number field.

Example: a field accepts ages 10 to 18. Normal 14. Boundary 10 and 18. Invalid 5 or the word "abc".

## Debugging and validation
A **bug** is an error. **Debugging** means finding and fixing it. Common causes include typing mistakes, wrong logic, missing input checks and untested devices. **Validation** checks that data is sensible before it is used, for example that a number is in range. It is different from verification, which checks that data was entered correctly, such as typing an email twice.

## User testing and iteration
Ask real users to try the product while you watch. They find problems you cannot see. Then improve and test again. This build-test-improve loop is called **iterative development**. Record the change and the reason, because Criterion C rewards justified changes to the plan.

## Legal and ethical creation
Use media you have permission to use. Check **licences** and credit creators. Never use another person's work as if it were yours.

## Worked example
A tester runs 25 test cases and 22 pass. After fixing two bugs, 24 pass. 24 ÷ 25 × 100 = 96% passing. The remaining failure must be recorded and either fixed or explained.

## How this is examined
Questions give a short test log or scenario and ask which test data is correct, what a result shows, which bug fix is best, or how many tests pass as a percentage. Command terms: state, describe, explain, justify.

Exam tip: For any test question, name the type of data (normal, boundary or invalid) and say what you expect to happen.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('digital-design')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;