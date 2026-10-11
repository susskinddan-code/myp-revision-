begin;
-- English Language and Literature MYP 5 eAssessment Structure Mock (3 tasks, 80 marks) (80 marks)
with sub as (select id from public.subjects where slug = $mq$english-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$English Language and Literature MYP 5 eAssessment Structure Mock (3 tasks, 80 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$English Language and Literature MYP 5 eAssessment Structure Mock (3 tasks, 80 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1.1 | A 2]]
Task 1: Analysing
Questions 1.1 to 1.4 focus on the key concept of communication. Question 1.5 focuses on the key concept of connections. The criteria assessed are A (Analysing) and B (Organizing). Suggested time for Questions 1.1 to 1.4: 15 minutes. Suggested time for Question 1.5: 35 minutes.

Text A: 'The Last Ferry Home' (an extract from a short story, written for this paper)
This extract describes a girl, Imara, waiting on a rain-soaked pier for her grandfather after the harbour has been closed by a storm.

By six o'clock the sea had turned the colour of old pewter. Imara stood at the end of the pier with her collar up, watching the lights of the mainland blink and vanish behind the swell. The harbour master had already chained the gate. "Nothing's crossing tonight, love," he had said, not unkindly, but she had stayed anyway.

Behind her the fish stalls were shuttered, their striped awnings snapping like flags in surrender. A single gull hung above the water, wings locked, going nowhere against the wind. She understood it perfectly.

Her grandfather had promised he would be on the last ferry. He had promised it on the telephone, in the slow, careful English he used when he wanted to be believed. "Wait for me by the lamp," he had said. So she waited by the lamp, and the lamp swung and buzzed, and its yellow circle shrank and grew on the wet boards like a pulse.

At seven, a bell began to toll somewhere out in the dark. Imara's heart lifted, then fell. It was only a buoy, rocking, ringing for no one.

She took out the small brass compass he had given her last winter and held it flat on her palm. The needle shivered, then settled, pointing steadily at the place where the lights had been. "Even when you can't see the way," he used to say, "you can know the direction." She closed her fingers around it. The rain ran down her wrists. She did not move from the lamp.

Text B: transcript of 'Keep Rowing', a two-minute public-awareness film about a community lifeboat crew (written for this paper; in the live exam this would be a video)
[Visual: a small orange lifeboat rides a grey swell. Slow, low piano music. The camera is placed at water level.]
Narrator (calm, quiet): "Nobody here is a hero. They're bakers and teachers and bus drivers."
[Visual: close-up of hands tightening a rope; cut to a clock on a wall showing 3.12 a.m.]
Narrator: "When the pager goes, they go. They don't ask who is out there. They only ask how fast."
[Visual: a wave breaks over the bow; the music stops completely for three seconds. Only wind.]
Narrator: "Courage isn't the absence of fear. It's what you do with the fear in your hands."
[Visual: the crew hauls a stranger aboard and wraps a blanket round them. The piano returns, warmer. Sunrise breaks over the water.]
On-screen text, white capitals on black: THEY KEEP ROWING SO OTHERS CAN COME HOME. Volunteer today.

Q 1.1 Comment on the use of weather in the opening of Text A. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a use of weather with reference to the text but does not justify with examples or explanation, e.g. the sea is described as pewter-coloured. [1] Level 2 (2 marks): comments on a use of weather with some example and explanation, e.g. the 'old pewter' sea and the storm create a bleak, threatening mood that foreshadows disappointment for Imara. [1] Award 0 for no or incorrect reference to the text.$mq$, $mq$A$mq$),
(2, $mq$[[Q 1.2 | A 3]]
Refer to Text A (printed in Question 1.1). Explain the effect of the line: 'A single gull hung above the water, wings locked, going nowhere against the wind. She understood it perfectly.' (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies an effect without developing it, e.g. the line shows Imara is stuck. [1] Level 2 (2 marks): describes an effect with some example or explanation, e.g. the gull mirrors Imara: both are held in place by forces they cannot beat. [1] Level 3 (3 marks): explains an effect consistently with well-chosen quotation, e.g. the short sentence 'She understood it perfectly' links Imara to the gull, so the reader feels her helplessness and determination to stay, and 'locked' and 'going nowhere' suggest effort that gets no reward. [1]$mq$, $mq$A$mq$),
(3, $mq$[[Q 1.3 | A 2]]
Refer to Text B (printed in Question 1.1). Describe the purpose of the music in the film. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a purpose without explanation, e.g. the music sets the mood. [1] Level 2 (2 marks): describes a purpose with an example, e.g. the quiet piano creates a calm, respectful tone, then stops for three seconds during the wave so the silence shows danger, and returns warmer at sunrise to signal relief and hope. [1]$mq$, $mq$A$mq$),
(4, $mq$[[Q 1.4 | A 3]]
Refer to Text B (printed in Question 1.1). Analyse the effect of a technique used in the film. (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies a technique and an effect with no development, e.g. a close-up shows the hands. [1] Level 2 (2 marks): describes the effect of one technique with some justification, e.g. the low camera at water level makes the audience feel inside the waves and so more aware of the risk. [1] Level 3 (3 marks): analyses the effect consistently with a precise example, e.g. the cut from the hands on the rope to the clock at 3.12 a.m. shows the crew act at the worst hour, so the audience admires their selflessness; the on-screen text 'KEEP ROWING SO OTHERS CAN COME HOME' ends with a direct call to action that turns admiration into support. [1] Accept any valid technique: narration, camera angle, silence, colour, contrast of sound.$mq$, $mq$A$mq$),
(5, $mq$[[Q 1.5 | A 10 | B 10]]
Refer to Text A and Text B (printed in Question 1.1). Compare and contrast how the concept of perseverance is explored in the two texts. (Approximately 350 words) (20 marks)

Criterion A (Analysing) is worth 10 marks and Criterion B (Organizing) is worth 10 marks.$mq$, $mq$Criterion A (10 marks) and Criterion B (10 marks), 20 marks in total. Criterion A: 9 to 10 marks for effective, perceptive analysis of content, language, structure and technique in BOTH texts with extensive well-chosen evidence; 6 to 8 for considerable analysis with sufficient evidence; 3 to 5 for adequate analysis with some evidence; 1 to 2 for limited analysis with few examples. Indicative content: Text A shows quiet, solitary perseverance through the lamp, the compass and the 'going nowhere' gull; sentence rhythm slows and the ending does not resolve. Text B shows collective, active perseverance through the crew, the clock and the 'keep rowing' slogan; music and camera shape admiration and a call to action. Contrast: individual and passive waiting versus group and active effort; hope held privately versus perseverance used to persuade an audience. Award up to [10] for Criterion A. Criterion B: 9 to 10 marks for effective organisation with a clear structure, comparison and contrast sustained throughout, effective linking and a conclusion; 6 to 8 for a considerable degree; 3 to 5 for an adequate degree with some comparison; 1 to 2 for limited, mostly separate treatment of each text. Award up to [10] for Criterion B.$mq$, $mq$A$mq$),
(6, $mq$[[Q 2.1 | C 10 | D 10]]
Task 2: Producing literary text
This task focuses on the key concept of creativity. The criteria assessed are C (Producing text) and D (Using language).

Image 1 (described in words): a shelf in a junk shop crowded with chipped teapots, clocks that have stopped, brass keys and one old pair of binoculars, all under a film of dust and lit by a thin beam of sunlight.
Image 2 (described in words): two glowing glass flasks, one green and one red, on a stone bench in a dark workshop, with three students leaning in to watch the liquids.

Using one of the images, write a scene in a science fiction story in which a character discovers an object's power. You may consider purpose, characterisation, setting, mood and point of view. State which image you are using before you start. (Approximately 350 words) (20 marks)$mq$, $mq$Criterion C (10 marks): 9 to 10 high degree of insight and imagination, perceptive stylistic choices, extensive precise detail; 6 to 8 considerable insight, thoughtful choices, sufficient detail; 3 to 5 some insight, some stylistic choices, some detail; 1 to 2 limited. A response that uses neither image nor the prompt scores 0 for C. Award up to [10] for Criterion C. Criterion D (10 marks): 9 to 10 effective range of vocabulary and sentence structures, consistently purposeful register, high accuracy with minor errors; 6 to 8 varied range, considerable accuracy, errors do not hinder communication; 3 to 5 adequate range, a degree of accuracy, errors sometimes hinder; 1 to 2 limited range, errors often hinder. Award up to [10] for Criterion D. Indicative content: a clear named image, a character who discovers and tests the power, rising tension, sensory description and a controlled ending.$mq$, $mq$C$mq$),
(7, $mq$[[Q 3.1 | B 10 | C 10 | D 10]]
Task 3: Producing non-literary text
This task focuses on the key concept of perspective. You will create a piece of non-literary writing in relation to the global context globalization and sustainability: sustainable development and resources. The criteria assessed are B (Organizing), C (Producing text) and D (Using language).

Write a speech for a school assembly on why reducing food waste matters for your community now and for future generations. Use a clear structure and persuasive techniques suited to a speech. (Approximately 350 words) (30 marks)$mq$, $mq$Criterion B (10 marks): organisation suited to a speech: a purposeful opening, three developed points, a persuasive close and the conventions of the text type (direct address, rhetorical devices); 9 to 10 effective, 6 to 8 considerable, 3 to 5 adequate, 1 to 2 limited. Award up to [10] for Criterion B. Criterion C (10 marks): perspective on the global context shown through insight, relevant detail and examples about waste, resources and future generations; 9 to 10 high degree of insight and extensive detail, 6 to 8 considerable, 3 to 5 some, 1 to 2 limited. Award up to [10] for Criterion C. Criterion D (10 marks): register suited to an assembly audience, varied sentence structures, persuasive techniques (rule of three, repetition, inclusive language, rhetorical questions), accurate grammar and punctuation; 9 to 10 high accuracy, 6 to 8 considerable, 3 to 5 a degree, 1 to 2 minimal. Award up to [10] for Criterion D.$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- Standard Mathematics MYP 5 eAssessment Structure Mock (8 tasks, 70 marks) (70 marks)
with sub as (select id from public.subjects where slug = $mq$standard-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Standard Mathematics MYP 5 eAssessment Structure Mock (8 tasks, 70 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Standard Mathematics MYP 5 eAssessment Structure Mock (8 tasks, 70 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 5 | C 2]]
A grain silo is a cylinder of radius 4 m and height 10 m with a hemisphere of radius 4 m fixed on top. Diagram not to scale. (The volume of a sphere is 4/3 × π × r³.)
(a) Determine the volume of the cylinder, in terms of π. (2 marks)
(b) Determine the volume of the hemisphere, in terms of π. (2 marks)
(c) Find the total volume of the silo, giving your answer correct to 3 significant figures and showing your working clearly. (3 marks)

Total for Question 1: 7 marks$mq$, $mq$(a) V = π × 4² × 10 [1] = 160π [1]. (b) V = 1/2 × 4/3 × π × 4³ [1] = 128π/3 [1]. (c) Total = 160π + 128π/3 = 608π/3 [1]; = 636.7... [1]; = 637 m³ (3 s.f.) with units and clear working (communication) [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 6 | C 2]]
In each part, O is the centre of the circle. Diagrams are not to scale.
(a) A, B and C lie on the circumference. Angle ACB = 48°. Find angle AOB, where O is the centre. (2 marks)
(b) PA is a tangent to the circle at A. Angle AOP = 65°. Determine angle APO. (2 marks)
(c) TA and TB are tangents from T to the circle. Angle ATB = 64°. Find the reflex angle AOB. (3 marks)
(d) ABCD is a cyclic quadrilateral. Angle ABC = 112°. Find angle ADC and state the circle theorem you used. (1 mark)

Total for Question 2: 8 marks$mq$, $mq$(a) Angle at the centre is twice the angle at the circumference: 96° [2]. (b) Radius meets tangent at 90°; angle APO = 180 - 90 - 65 [1] = 25° [1]. (c) Angles OAT and OBT are 90° [1]; angle AOB = 360 - 90 - 90 - 64 = 116° [1]; reflex = 244° [1]. (d) 68°, because opposite angles of a cyclic quadrilateral add to 180° [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 8 | C 3]]
Matchsticks are used to build a row of squares. Stage 1 is one square (4 matchsticks). Stage 2 is two squares joined side by side (7 matchsticks). Stage 3 is three squares in a row (10 matchsticks). Let n be the stage number and S the number of matchsticks.
(a) Write down the missing values for stages 4 and 5 in a table with columns n and S (n = 1, 2, 3 given as 4, 7, 10). (2 marks)
(b) Describe in words the pattern for S as n increases. (1 mark)
(c) Write down a general rule for S in terms of n. (2 marks)
(d) Verify your rule for n = 6 by working out S from the pattern. (2 marks)
(e) Justify why your rule works for every stage. (2 marks)
(f) Which stage uses exactly 100 matchsticks? (2 marks)

Total for Question 3: 11 marks$mq$, $mq$(a) n=4: 13 [1]; n=5: 16 [1]. (b) The number of matchsticks increases by 3 each stage [1]. (c) S = 3n + 1 [2] (award 1 for 3n only). (d) Pattern: 4, 7, 10, 13, 16, 19 so S = 19 [1]; rule gives 3(6) + 1 = 19, so it agrees [1]. (e) The first square needs 4 matchsticks and every extra square needs 3 more (it shares one side) [1], so S = 4 + 3(n - 1) = 3n + 1 [1]. (f) 3n + 1 = 100 [1]; n = 33 [1].$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | D 7 | C 3]]
A phone company offers two monthly plans. Plan A costs £8 plus £1.50 for each gigabyte (GB) of data used. Plan B costs a fixed £20 for unlimited data. Let g be the number of GB used in a month.
(a) Write down an expression for the monthly cost of Plan A. (1 mark)
(b) Determine the cost of Plan A when g = 6. (1 mark)
(c) Find the value of g for which both plans cost the same. (2 marks)
(d) Solve an inequality to find when Plan A is cheaper than Plan B. (2 marks)
(e) Sam uses 10 GB each month. Calculate how much cheaper Plan B is than Plan A for Sam. (2 marks)
(f) Explain which plan you would recommend to someone who uses about 5 GB, with a reason. (2 marks)

Total for Question 4: 10 marks$mq$, $mq$(a) 8 + 1.5g [1]. (b) 8 + 9 = £17 [1]. (c) 8 + 1.5g = 20 [1]; g = 8 [1]. (d) 8 + 1.5g < 20 [1]; g < 8 [1]. (e) Plan A: 8 + 15 = £23 [1]; Plan B is £3 cheaper [1]. (f) Plan A [1], because at 5 GB it costs £15.50, which is less than £20 [1].$mq$, $mq$D$mq$),
(5, $mq$[[Q 5 | A 6 | C 2]]
The table shows the times, t minutes, taken by 40 runners to finish a 5 km race.
Time: 20 ≤ t < 25 has 4 runners; 25 ≤ t < 30 has 9; 30 ≤ t < 35 has k; 35 ≤ t < 40 has 11; 40 ≤ t < 45 has 6.
(a) Find the value of k. (2 marks)
(b) Calculate an estimate of the mean time, showing your working. (3 marks)
(c) Write down the class that contains the median. (1 mark)
(d) A runner is chosen at random. Find the probability that the runner took less than 30 minutes. (2 marks)

Total for Question 5: 8 marks$mq$, $mq$(a) 4 + 9 + k + 11 + 6 = 40 [1]; k = 10 [1]. (b) Midpoints 22.5, 27.5, 32.5, 37.5, 42.5 [1]; sum of frequency x midpoint = 1330 [1]; mean = 1330 / 40 = 33.25 minutes [1]. (c) 30 ≤ t < 35 [1]. (d) 13 / 40 [2] (award 1 for 13 runners identified).$mq$, $mq$A$mq$),
(6, $mq$[[Q 6 | D 8 | C 2]]
Mia invests £2000. Account X pays 4% simple interest per year. Account Y pays 3.5% compound interest per year. Interest is added once a year.
(a) Calculate the value of Account X after 8 years. (2 marks)
(b) Write down the formula for the value of Account Y after t years and find its value after 10 years, to the nearest penny. (3 marks)
(c) After 5 years, find how much more Account X is worth than Account Y. (3 marks)
(d) Explain which account is better for a long-term investment and why. (2 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) 4% of 2000 = £80 per year [1]; 2000 + 8 x 80 = £2640 [1]. (b) V = 2000 x 1.035^t [1]; 2000 x 1.035^10 [1] = £2821.20 [1]. (c) X: £2400 [1]; Y: 2000 x 1.035^5 = £2375.37 [1]; difference £24.63 [1]. (d) Account Y [1], because compound interest is earned on previous interest so it grows faster and overtakes simple interest after 9 years (at 10 years Y is £2821.20 against £2800) [1].$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | A 5 | D 3]]
A ship leaves port P and sails 12 km on a bearing of 040° to point Q. It then sails 9 km on a bearing of 130° to point R. Angle PQR is 90°. Diagram not to scale.
(a) Calculate the distance PR. (2 marks)
(b) Calculate angle QPR, to 1 decimal place. (2 marks)
(c) Find the bearing of R from P, to the nearest degree. (2 marks)
(d) Find the bearing of P from R. (2 marks)

Total for Question 7: 8 marks$mq$, $mq$(a) PR² = 12² + 9² = 225 [1]; PR = 15 km [1]. (b) tan(QPR) = 9/12 [1]; QPR = 36.9° [1]. (c) 40 + 36.9 = 76.9 [1]; bearing 077° [1]. (d) Back bearing = 76.9 + 180 [1] = 257° [1].$mq$, $mq$A$mq$),
(8, $mq$[[Q 8 | D 4 | A 2 | C 2]]
A garden sprinkler waters a sector of a circle of radius 8 m with an angle of 150° at the centre. Diagram not to scale.
(a) Find the area watered, in terms of π and then to 1 decimal place. (3 marks)
(b) Find the length of the curved edge of the watered region, to 1 decimal place. (3 marks)
(c) A low fence is placed along the curved edge and costs £6.50 per metre. Calculate the cost, to the nearest penny. (2 marks)

Total for Question 8: 8 marks$mq$, $mq$(a) 150/360 x π x 8² [1] = 80π/3 [1] = 83.8 m² [1]. (b) 150/360 x 2 x π x 8 [1] = 20π/3 [1] = 20.9 m [1]. (c) 20.944 x 6.50 [1] = £136.14 [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Standard Mathematics MYP 5 Investigating Patterns Structure Mock (6 tasks, 63 marks) (63 marks)
with sub as (select id from public.subjects where slug = $mq$standard-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Standard Mathematics MYP 5 Investigating Patterns Structure Mock (6 tasks, 63 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Standard Mathematics MYP 5 Investigating Patterns Structure Mock (6 tasks, 63 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | B 9 | C 2]]
Investigating patterns. In this task you will use logic to investigate staircases built from unit squares. Stage 1 is 1 square, stage 2 is a staircase with rows of 1 and 2 squares (3 squares), stage 3 has rows of 1, 2 and 3 squares (6 squares) and so on. Let n be the stage and T the number of squares.
(a) Write down the missing values of T for n = 4 and n = 5. (2 marks)
(b) Describe in words two patterns in the values of T. (2 marks)
(c) Write down a general rule for T in terms of n. (2 marks)
(d) Verify your rule for n = 8, clearly showing your working. (2 marks)
(e) Justify your rule by considering two identical staircases placed together. (3 marks)

Total for Question 1: 11 marks$mq$, $mq$(a) n=4: 10 [1]; n=5: 15 [1]. (b) T increases every stage [1]; the amount added grows by 1 each time (2, 3, 4, 5), which is the stage number [1]. (c) T = n(n + 1)/2 [2] (award 1 for a correct unsimplified sum idea such as 1 + 2 + ... + n). (d) Continuing the pattern gives 1, 3, 6, 10, 15, 21, 28, 36 so T = 36 [1]; the rule gives 8 x 9 / 2 = 36 so it agrees [1]. (e) Two identical staircases fit together to make a rectangle n by (n + 1) [1] with n(n + 1) squares [1], so one staircase is half of that, n(n + 1)/2 [1].$mq$, $mq$B$mq$),
(2, $mq$[[Q 2 | B 10 | C 3]]
Investigating patterns. A student designs a family of straight lines. The equation for stage n is y = (n + 1)x + 2n, so stage 1 is y = 2x + 2, stage 2 is y = 3x + 4 and stage 3 is y = 4x + 6.
(a) Write down the y-intercept of each line for n = 1, 2, 3 and 4. (2 marks)
(b) Write down the gradient of each line for n = 1, 2, 3 and 4. (2 marks)
(c) Write down a rule for the y-intercept and a rule for the gradient, each in terms of n. (2 marks)
(d) Verify your rules by writing down the equation of the line for n = 10. (2 marks)
(e) Find the x-intercept of the line for n = 3. (2 marks)
(f) Show that the point (-2, -2) lies on the line for every value of n. (3 marks)

Total for Question 2: 13 marks$mq$, $mq$(a) 2, 4, 6, 8 [2] (award 1 for two or three correct). (b) 2, 3, 4, 5 [2] (award 1 for two or three correct). (c) y-intercept = 2n [1]; gradient = n + 1 [1]. (d) y = 11x + 20 [2] (award 1 for one correct value). (e) Set y = 0: 4x + 6 = 0 [1]; x = -1.5 [1]. (f) Substitute x = -2: y = (n + 1)(-2) + 2n [1] = -2n - 2 + 2n [1] = -2 for every n, so the point is on every line [1].$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | A 7 | C 2]]
A fitness app awards a Bronze badge if 50 < 2P + 10 ≤ 250, where P is the weekly active points. It awards a Silver badge if P/3 + 5 ≥ 25 and P < 90. A user needs both badges in the same week to earn the Dual badge.
(a) Solve the Bronze inequality to find the range of P. (3 marks)
(b) Solve the Silver inequalities to find the range of P. (3 marks)
(c) Find the range of P that earns the Dual badge, and state how many whole-number values of P qualify. (3 marks)

Total for Question 3: 9 marks$mq$, $mq$(a) 40 < 2P ≤ 240 [1]; 20 < P ≤ 120 [2] (one mark each end). (b) P/3 ≥ 20 [1]; P ≥ 60 [1]; with P < 90 gives 60 ≤ P < 90 [1]. (c) Overlap of 20 < P ≤ 120 and 60 ≤ P < 90 is 60 ≤ P < 90 [1]; whole numbers 60 to 89 [1]; 30 values [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 5 | C 2]]
A circular plaza has radius 12 m. A sector of the plaza with angle 75° at the centre is paved. Diagram not to scale.
(a) Determine the area of the paved sector, in terms of π. (3 marks)
(b) Determine the length of the curved edge of the sector, in terms of π. (2 marks)
(c) Find the perimeter of the paved sector, correct to 1 decimal place. (2 marks)

Total for Question 4: 7 marks$mq$, $mq$(a) 75/360 x π x 12² [1] = 75/360 x 144π [1] = 30π m² [1]. (b) 75/360 x 2 x π x 12 [1] = 5π m [1]. (c) 12 + 12 + 5π [1] = 39.7 m [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 12 | C 4]]
Investigating patterns. Stage 1 is a square of side 8 cm. At each new stage, a new square is drawn inside the previous one by joining the midpoints of its sides. Let n be the stage and A the area of the newest square.
(a) Write down A for stage 1, 2, 3 and 4. (2 marks)
(b) Write down the values of A for stages 5 and 6. (2 marks)
(c) Describe in words the pattern in A. (2 marks)
(d) Write down a general rule for A in terms of n. (2 marks)
(e) Verify your rule for n = 6. (2 marks)
(f) Use Pythagoras' theorem to show that the area of the square at stage 2 is 32 cm². (3 marks)
(g) Find the first stage at which the area is less than 0.1 cm². (3 marks)

Total for Question 5: 16 marks$mq$, $mq$(a) 64, 32, 16, 8 [2] (award 1 for two correct). (b) 4 and 2 [2]. (c) Each area is half the previous area [1], so the area is halved at every stage / A is multiplied by 1/2 [1]. (d) A = 64 x (1/2)^(n - 1) [2] (equivalent forms such as 128 / 2^n accepted). (e) Rule: 64 x (1/2)^5 = 2 [1]; pattern value for stage 6 is 2, so it agrees [1]. (f) The side of the new square is the hypotenuse of a right-angled triangle with sides 4 and 4 [1]; side² = 16 + 16 = 32 [1]; area = side² = 32 cm² [1]. (g) 128 / 2^n < 0.1 so 2^n > 1280 [1]; 2^10 = 1024 is too small and 2^11 = 2048 works [1]; stage 11 [1].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | D 5 | C 2]]
A 5 m ladder leans against a vertical wall. Its base is on level ground and it makes an angle of 70° with the ground. A ladder is considered safe if the angle with the ground is between 70° and 80°. Diagram not to scale.
(a) Calculate how high up the wall the ladder reaches, to 2 decimal places. (2 marks)
(b) Calculate how far the base of the ladder is from the wall, to 2 decimal places. (2 marks)
(c) The base is moved to 1.5 m from the wall. Calculate the new angle with the ground, to 1 decimal place, and state whether the ladder is still safe, with a reason. (3 marks)

Total for Question 6: 7 marks$mq$, $mq$(a) 5 x sin 70° [1] = 4.70 m [1]. (b) 5 x cos 70° [1] = 1.71 m [1]. (c) cos θ = 1.5 / 5 [1]; θ = 72.5° [1]; still safe because 72.5° is between 70° and 80° [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Standard Mathematics MYP 5 Modelling and Design Structure Mock (7 tasks, 62 marks) (62 marks)
with sub as (select id from public.subjects where slug = $mq$standard-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Standard Mathematics MYP 5 Modelling and Design Structure Mock (7 tasks, 62 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Standard Mathematics MYP 5 Modelling and Design Structure Mock (7 tasks, 62 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | D 16 | C 5]]
Applying mathematics in real-life contexts. A school is building a terraced vegetable garden. Terrace walls rise in steps, and the heights of the walls form an arithmetic sequence. The first terrace wall is 0.4 m high and the seventh is 2.2 m high. Each raised bed is 2.5 m wide, a 1 m gap is needed between beds in a row and a 1.5 m path is needed at each end of a row. The garden is 20 m wide. Diagram not to scale.
(a) Determine the common difference between the heights of the walls. (2 marks)
(b) Write down the general term for the height H of the nth terrace wall. (1 mark)
(c) Determine the height of the twelfth terrace wall. (2 marks)
(d) Let x be the greatest number of beds that fit in one row. Show that x = 5. (3 marks)
Let y be the number of terraces. The constraints are: Constraint 1: the row width is 20 m, so x ≤ 5. Constraint 2: the top wall may be at most 3.1 m high. Constraint 3: each bed holds 12 plants and the garden may hold at most 480 plants.
(e) Write down the equation of each boundary line for the three constraints, and describe the region that satisfies all constraints. (3 marks)
(f) Design the terraced garden to hold the greatest number of plants. In your answer you should: clearly identify three relevant factors; make calculations for the number of beds in the whole garden and the number of plants; describe a sketch of your design; and justify whether your design makes the best use of the space. (10 marks)

Total for Question 1: 21 marks$mq$, $mq$(a) 2.2 - 0.4 = 1.8 [1]; 1.8 / 6 = 0.3 m [1]. (b) H = 0.4 + 0.3(n - 1) = 0.3n + 0.1 [1]. (c) 0.3(12) + 0.1 [1] = 3.7 m [1]. (d) 2.5x + 1(x - 1) + 2(1.5) <= 20 [1]; 3.5x <= 18 so x <= 5.14... [1]; whole beds only, so x = 5 [1]. (e) Lines x = 5 [1]; y = 10, from 0.3y + 0.1 <= 3.1 [1]; xy = 40, from 12xy <= 480 [1] (the region identification is credited with the last mark: whole-number points with x <= 5, y <= 10 and xy <= 40). (f) Three factors, for example width of the garden, maximum wall height, plant limit, bed size [3]; calculation of beds per row, x = 5 [1]; calculation of terraces from the constraints with y = 8 and 5 x 8 = 40 beds, or 4 x 10 = 40 [2]; total plants 12 x 40 = 480 [1]; the design is described clearly (rows, terraces, gaps, paths) [1]; justification that 40 beds is the maximum because xy must not exceed 40, that the height 0.3(8) + 0.1 = 2.5 m is within 3.1 m and that every constraint is met, noting 5 x 10 = 50 would break the plant limit [2].$mq$, $mq$D$mq$),
(2, $mq$[[Q 2 | D 3 | A 5]]
A designer makes banners in the shape of similar trapezia. The large banner has a top width of 40 cm and an area of 1200 cm². A small banner has a top width of 10 cm. Yellow paint covers a total of at most 90 cm². The designer adds stars of two sizes: a small star of area 3 cm² and a large star of area 6 cm². The number of small stars must be 3 times the number of large stars. Let x be the number of small stars and y the number of large stars.
(a) Show that the area of the small banner is 75 cm². (3 marks)
(b) Write down the equation linking x and y, and an inequality for the paint. (2 marks)
(c) Find the greatest possible number of small and large stars. (3 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) Length scale factor 10/40 = 1/4 [1]; area scale factor (1/4)² = 1/16 [1]; 1200 / 16 = 75 cm² [1]. (b) x = 3y [1]; 3x + 6y <= 90 [1]. (c) 9y + 6y <= 90 so 15y <= 90 [1]; y <= 6 [1]; so 6 large and 18 small stars [1].$mq$, $mq$D$mq$),
(3, $mq$[[Q 3 | A 5 | C 2]]
A bag holds 5 red, 3 blue and 2 green counters. Two counters are taken without replacement.
(a) Find the probability that both counters are red. (2 marks)
(b) Find the probability that the two counters are different colours. Show your working clearly. (3 marks)
(c) Find the probability that at least one counter is blue. (2 marks)

Total for Question 3: 7 marks$mq$, $mq$(a) 5/10 x 4/9 [1] = 2/9 [1]. (b) P(same) = 20/90 + 6/90 + 2/90 = 28/90 [2]; P(different) = 1 - 28/90 = 62/90 = 31/45 [1]. (c) P(no blue) = 7/10 x 6/9 = 42/90 [1]; P(at least one blue) = 48/90 = 8/15 [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | D 5 | C 2]]
A population of bacteria is modelled by P = 200 x 1.5^t, where t is the time in hours after the start.
(a) Calculate the population after 3 hours. (2 marks)
(b) State the starting population and explain what the number 1.5 means. (1 mark)
(c) Find the smallest whole number of hours after which the population first exceeds 1000. Show your working. (3 marks)
(d) State one limitation of this model. (1 mark)

Total for Question 4: 7 marks$mq$, $mq$(a) 200 x 1.5^3 [1] = 675 [1]. (b) 200, and the population is multiplied by 1.5 (increases by 50%) every hour [1]. (c) At t = 3, P = 675 which is below 1000 [1]; at t = 4, P = 1012.5 [1]; so 4 hours [1]. (d) The model cannot continue forever as food and space run out, or the growth rate would change [1].$mq$, $mq$D$mq$),
(5, $mq$[[Q 5 | A 5 | C 1]]
A cinema sells adult tickets for £a and child tickets for £c. Three adult tickets and two child tickets cost £31. Two adult tickets and four child tickets cost £34.
(a) Write down two equations from this information. (2 marks)
(b) Solve the equations to find a and c. (3 marks)
(c) Find the cost of a family ticket for 2 adults and 3 children. (1 mark)

Total for Question 5: 6 marks$mq$, $mq$(a) 3a + 2c = 31 [1]; 2a + 4c = 34 [1]. (b) Divide the second by 2: a + 2c = 17, and subtract from the first: 2a = 14 [1]; a = 7 [1]; c = 5 [1]. (c) 14 + 15 = £29 [1].$mq$, $mq$A$mq$),
(6, $mq$[[Q 6 | A 5 | C 1]]
Two similar cones have heights 6 cm and 9 cm. The smaller cone has a volume of 80 cm³ and a curved surface area of 100 cm².
(a) Write down the length scale factor from the smaller cone to the larger cone. (1 mark)
(b) Find the volume of the larger cone. (3 marks)
(c) Find the curved surface area of the larger cone. (2 marks)

Total for Question 6: 6 marks$mq$, $mq$(a) 9/6 = 3/2 [1]. (b) Volume scale factor (3/2)³ = 27/8 [1]; 80 x 27/8 [1] = 270 cm³ [1]. (c) Area scale factor (3/2)² = 9/4 [1]; 100 x 9/4 = 225 cm² [1].$mq$, $mq$A$mq$),
(7, $mq$[[Q 7 | A 5 | C 2]]
The number of minutes 12 students took to complete a puzzle were: 4, 6, 7, 7, 8, 9, 10, 12, 13, 15, 18, 21.
(a) Find the median. (1 mark)
(b) Find the lower quartile and the upper quartile. (2 marks)
(c) Find the interquartile range. (1 mark)
(d) A value is an outlier if it is more than 1.5 x IQR above the upper quartile or below the lower quartile. Show that there are no outliers. (2 marks)
(e) Describe one thing the box-and-whisker plot would show about the spread of the data. (1 mark)

Total for Question 7: 7 marks$mq$, $mq$(a) (9 + 10) / 2 = 9.5 [1]. (b) Q1 = 7 [1]; Q3 = 14 [1]. (c) 14 - 7 = 7 [1]. (d) 1.5 x 7 = 10.5 so upper limit 24.5 and lower limit -3.5 [1]; the smallest value 4 and the largest 21 are inside these limits, so no outliers [1]. (e) For example, the middle half of the students took between 7 and 14 minutes, or the upper whisker is longer so the data is positively skewed [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Extended Mathematics MYP 5 eAssessment Structure Mock (8 tasks, 62 marks) (62 marks)
with sub as (select id from public.subjects where slug = $mq$extended-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Extended Mathematics MYP 5 eAssessment Structure Mock (8 tasks, 62 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Extended Mathematics MYP 5 eAssessment Structure Mock (8 tasks, 62 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 4 | C 1]]
Three data sets are shown as frequency graphs. Set X has the values 1, 2, 3, 4 and 5, each with frequency 2. Set Y has the values 11, 12, 13, 14 and 15, each with frequency 2. Set Z has the value 1 with frequency 5 and the value 9 with frequency 5. Set Q has the value 6 with frequency 10.
(a) State whether the standard deviation of Set Q is zero or large. (1 mark)
(b) For Set X and Set Y, state whether the mean is the same or different, and whether the standard deviation is the same or different. (2 marks)
(c) State which of Set X and Set Z has the larger standard deviation, and give a reason. (2 marks)

Total for Question 1: 5 marks$mq$, $mq$(a) Zero, because every value is the same [1]. (b) Mean different (3 and 13) [1]; standard deviation the same, because Y is X shifted 10 to the right with an identical spread [1]. (c) Set Z [1], because its values are further from the mean of 5 (each is 4 away) while Set X values are at most 2 away from its mean of 3 [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 6 | C 2]]
Two events, A and B, are such that P(A) = 7/20, P(A | B) = 1/2 and P(A ∩ B) = 3/20.
(a) Find P(B). (3 marks)
(b) Show that events A and B are not independent. (3 marks)
(c) Find P(A ∪ B). (2 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) P(A | B) = P(A ∩ B) / P(B) [1]; 1/2 = (3/20) / P(B) [1]; P(B) = 3/10 [1]. (b) If independent, P(A) x P(B) = P(A ∩ B) [1]; P(A) x P(B) = 7/20 x 3/10 = 21/200 [1]; this is not equal to 3/20 = 30/200, so A and B are not independent [1]. (c) 7/20 + 6/20 - 3/20 [1] = 10/20 = 1/2 [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 5 | C 2]]
In triangle ABC, angle ACB = 90°, AC = 12 cm, BC = 9 cm and AB = 15 cm. The point D lies on AC with AD = 8 cm. The point E lies on AB so that DE is perpendicular to AC. Diagram not to scale.
(a) Show that triangle ADE is similar to triangle ACB. (2 marks)
(b) Find the length DE. (2 marks)
(c) Find the lengths AE and EB. (3 marks)

Total for Question 3: 7 marks$mq$, $mq$(a) Angle A is common [1]; angles ADE and ACB are both 90° (so the triangles are similar by equal angles) [1]. (b) Scale factor AD / AC = 8/12 = 2/3 [1]; DE = 2/3 x 9 = 6 cm [1]. (c) AE = 2/3 x 15 [1] = 10 cm [1]; EB = 15 - 10 = 5 cm [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 6 | C 2]]
The function f(x) = a × b^x + c has a graph with a horizontal asymptote y = 2, passes through (0, 6) and passes through (1, 4).
(a) Write down the value of c. (1 mark)
(b) Find the value of a. (2 marks)
(c) Find the value of b. (2 marks)
(d) Describe what happens to f(x) as x becomes very large. (1 mark)
(e) Solve f(x) = 3. (2 marks)

Total for Question 4: 8 marks$mq$, $mq$(a) c = 2 [1]. (b) At x = 0: a + 2 = 6 [1]; a = 4 [1]. (c) 4b + 2 = 4 [1]; b = 0.5 [1]. (d) f(x) gets closer and closer to 2 (but never reaches it) [1]. (e) 4 x 0.5^x = 1 so 0.5^x = 0.25 [1]; x = 2 [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | A 6 | D 3]]
A yacht race starts at buoy H. The first leg goes 120 m on a bearing of 070° to buoy A. The second leg goes 200 m on a bearing of 150° to buoy B. The yachts then return directly to H. Diagram not to scale.
(a) Show that angle HAB is 100°. (2 marks)
(b) Calculate the distance from B to H, to 1 decimal place. (3 marks)
(c) Calculate the bearing of B from H, to the nearest degree. (3 marks)
(d) Find the total length of the course. (1 mark)

Total for Question 5: 9 marks$mq$, $mq$(a) The bearing of H from A is 250° (070 + 180) [1]; angle HAB = 250 - 150 = 100° [1]. (b) BH² = 120² + 200² - 2 x 120 x 200 x cos 100° [1] = 62 735 [1]; BH = 250.5 m [1]. (c) sin(AHB) / 200 = sin 100° / 250.5 [1]; angle AHB = 51.9° [1]; bearing = 070 + 51.9 = 122° (to the nearest degree) [1]. (d) 120 + 200 + 250.5 = 570.5 m [1].$mq$, $mq$A$mq$),
(6, $mq$[[Q 6 | D 5 | C 2]]
A race starts at buoy H and the yachts must pass buoys A, B and C exactly once each and return to H. Distances in metres: H to A 100, H to B 180, H to C 150, A to B 120, A to C 160, B to C 90.
(a) Write down how many different routes are possible. (1 mark)
(b) Find the total distance of the routes H-A-B-C-H, H-A-C-B-H and H-B-A-C-H. (3 marks)
(c) The route H-C-B-A-H is the reverse of H-A-B-C-H. State the minimum total distance and the route that gives it. (2 marks)
(d) Explain why a route and its reverse always have the same length. (1 mark)

Total for Question 6: 7 marks$mq$, $mq$(a) 3 x 2 x 1 = 6 routes [1]. (b) H-A-B-C-H: 100 + 120 + 90 + 150 = 460 [1]; H-A-C-B-H: 100 + 160 + 90 + 180 = 530 [1]; H-B-A-C-H: 180 + 120 + 160 + 150 = 610 [1]. (c) Minimum distance 460 m [1]; route H-A-B-C-H (or its reverse H-C-B-A-H) [1]. (d) The same legs are used in the opposite order so the same distances are added [1].$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | B 10 | C 3]]
Investigating patterns. A square floor of side n metres is covered in 1 m by 1 m tiles. A border of tiles, one tile wide, is placed around the outside of the floor. Let n be the stage and T the number of tiles in the border. The border for n = 1 has 8 tiles and the border for n = 2 has 12 tiles.
(a) Write down the values of T for n = 3, 4 and 5. (2 marks)
(b) Describe in words two patterns in T. (2 marks)
(c) Write down a general rule for T in terms of n. (2 marks)
(d) Verify your rule for n = 10. (2 marks)
(e) Justify your rule by considering the areas of two squares. (3 marks)
(f) The border for one stage uses exactly 100 tiles. Find n. (2 marks)

Total for Question 7: 13 marks$mq$, $mq$(a) 16, 20, 24 [2] (award 1 for two correct). (b) T increases by 4 each stage [1]; T is always a multiple of 4 / T is even [1]. (c) T = 4n + 4 [2] (award 1 for 4n). (d) Extending the pattern gives T = 44 at n = 10 [1]; the rule gives 4(10) + 4 = 44 [1]. (e) The outer square has side n + 2 so area (n + 2)² [1]; the floor has area n² [1]; (n + 2)² - n² = 4n + 4 [1]. (f) 4n + 4 = 100 [1]; n = 24 [1].$mq$, $mq$B$mq$),
(8, $mq$[[Q 8 | A 4 | C 1]]
Consider the function y = x² - 5x - 14.
(a) Factorise x² - 5x - 14 and solve x² - 5x - 14 = 0. (3 marks)
(b) Find the coordinates of the lowest point of the graph. (2 marks)

Total for Question 8: 5 marks$mq$, $mq$(a) (x - 7)(x + 2) [1]; x = 7 [1]; x = -2 [1]. (b) x = (7 + (-2)) / 2 = 2.5 [1]; y = 6.25 - 12.5 - 14 = -20.25, so (2.5, -20.25) [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Integrated Science MYP 5 eAssessment Structure Mock (7 tasks, 60 marks) (60 marks)
with sub as (select id from public.subjects where slug = $mq$integrated-science$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Integrated Science MYP 5 eAssessment Structure Mock (7 tasks, 60 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Integrated Science MYP 5 eAssessment Structure Mock (7 tasks, 60 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | Criterion A: Knowing and understanding]]
A student studies cells under a light microscope.
(a) State the name of the part of a microscope that holds the slide in place. (1 mark)
(b) State two structures found in plant cells but not in animal cells. (2 marks)
(c) Smooth muscle cells are long and tapered with one central nucleus. Cardiac muscle cells are branched, have cross-striations and are joined by intercalated discs. Apply this information to explain one reason cardiac muscle suits the heart. (2 marks)
(d) Red blood cells have no nucleus and a pale centre called the central pallor. State one advantage of having no nucleus. (1 mark)

Total for Question 1: 6 marks$mq$, $mq$(a) Stage (accept stage clips) [1]. (b) Any two from cell wall, chloroplasts, large permanent vacuole [1][1]. (c) Intercalated discs let electrical signals pass quickly between cells so the heart contracts in a coordinated way [1]; cross-striations/branching show strong, fast, rhythmic contraction without tiring [1]. (d) More space to carry haemoglobin and so more oxygen [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | Criterion A: Knowing and understanding]]
Read the passage.
Comets are often called dirty snowballs because they are made of ice, dust and rock. When a comet nears the Sun, ice turns to gas and the solar wind pushes dust and gas into a tail that points away from the Sun. Asteroids are mostly rock and metal and are found mainly in a belt between Mars and Jupiter. Both are leftovers from the formation of the solar system about 4.6 billion years ago.
(a) State why the tail of a comet points away from the Sun. (1 mark)
(b) Describe one difference in composition between a comet and an asteroid. (2 marks)
(c) Explain why studying comets and asteroids helps scientists learn about the early solar system. (2 marks)
(d) State the force that keeps planets in orbit around the Sun. (1 mark)

Total for Question 2: 6 marks$mq$, $mq$(a) The solar wind pushes gas and dust away from the Sun [1]. (b) Comets contain a lot of ice (volatile material) [1]; asteroids are mostly rock and metal [1]. (c) They are leftovers that have changed little since the solar system formed [1], so their composition shows the conditions and materials from which planets formed [1]. (d) Gravity [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | Criterion B: Inquiring and designing]]
Read the passage.
A group of students investigate how the concentration of sugar solution affects potato strips. They cut identical strips of potato 5.0 cm long, weigh each strip, and place one strip in each of five beakers holding 50 cm³ of sugar solution (0.0, 0.2, 0.4, 0.6 and 0.8 mol/dm³). After 30 minutes at room temperature they dry the strips and weigh them again.
(a) State a research question that can be answered by this investigation. (2 marks)
(b) Formulate a testable hypothesis, using scientific reasoning. (2 marks)
(c) Identify the independent variable and the dependent variable. (2 marks)
(d) Outline two variables that must be controlled. (2 marks)
(e) Outline one safety measure for this investigation. (1 mark)
(f) Suggest one way to make the results more reliable. (1 mark)

Total for Question 3: 10 marks$mq$, $mq$(a) A question that links both variables, e.g. How does the concentration of sugar solution affect the change in mass of a potato strip? [2] (1 if the variables are named but not linked). (b) A prediction that links the variables [1], with reasoning using osmosis, e.g. as concentration increases, the strips will lose more mass because water moves out of the cells by osmosis into the more concentrated solution [1]. (c) Independent: sugar concentration [1]; dependent: change in mass of the strip [1]. (d) Any two from volume of solution, temperature, time in solution, size/length of strip, same potato [1][1]. (e) Any one from wear goggles, dry spills, take care with the knife [1]. (f) Repeat the experiment and calculate a mean (use several strips per beaker) [1].$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | Criterion C: Processing and evaluating]]
The students' results are shown. Each strip had a starting mass of 5.0 g.
Sugar concentration (mol/dm³) and final mass (g): 0.0 gives 5.8; 0.2 gives 5.4; 0.4 gives 5.0; 0.6 gives 4.6; 0.8 gives 4.2.
(a) Calculate the percentage change in mass of the strip in the 0.2 mol/dm³ solution. (2 marks)
(b) Describe the trend shown by the results. (2 marks)
(c) State the concentration at which the potato cells have the same concentration as the solution. (1 mark)
(d) Explain the result at 0.8 mol/dm³ using osmosis. (3 marks)
(e) Evaluate one limitation of the method and suggest an improvement. (2 marks)

Total for Question 4: 10 marks$mq$, $mq$(a) (5.4 - 5.0) / 5.0 x 100 [1] = +8% [1]. (b) As the sugar concentration increases the final mass decreases [1]; the strips gain mass at low concentrations and lose mass at high concentrations (the change is steady/linear) [1]. (c) 0.4 mol/dm³ [1]. (d) Water moves by osmosis from a higher water concentration (inside the cells) to a lower water concentration (the solution) [1] across a partially permeable membrane [1]; the strip loses water so its mass decreases [1]. (e) A limitation, e.g. only one strip per concentration so results may not be reliable, or strips may have different surface areas [1]; with a matching improvement, e.g. use three strips and a mean [1].$mq$, $mq$C$mq$),
(5, $mq$[[Q 5 | Criterion D: Reflecting on the impacts of science]]
Read the passage.
Rechargeable lithium batteries power phones, laptops and electric cars. They contain metals such as lithium, cobalt and nickel, which are mined in ways that can damage land and water. When batteries are thrown away with household rubbish they can start fires at landfill sites and leak harmful chemicals. Modern recycling plants can recover most of the metals so they can be used in new batteries, which reduces the need for new mining. However, collecting and sorting used batteries is expensive and many countries do not have enough recycling plants.
(a) Identify two benefits of recycling lithium batteries. (2 marks)
(b) Describe one environmental risk of throwing batteries away with household rubbish. (2 marks)
(c) Discuss how science helps to solve the battery waste problem, and how an economic factor limits the solution. (4 marks)
(d) State one action that a student could take to reduce battery waste. (2 marks)

Total for Question 5: 10 marks$mq$, $mq$(a) Any two from recovers metals for reuse, reduces mining, reduces landfill fires/pollution, saves resources [1][1]. (b) Chemicals leak into soil and water, harming living things [1]; or fires release toxic fumes [1] (one risk with a described effect). (c) Science develops recycling technology that recovers metals [1]; this reduces the need for mining and pollution [1]; the economic factor: collecting and sorting is expensive [1], so poorer areas may lack plants and the solution is not used everywhere [1]. (d) An action [1], e.g. take used batteries to a collection point, with a reason such as so the metals can be reused [1].$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | Criterion A: Knowing and understanding]]
In a species of pea plant, the allele for tall stems (T) is dominant to the allele for short stems (t). Two heterozygous tall plants are crossed.
(a) State the genotype of a heterozygous tall plant. (1 mark)
(b) Complete a Punnett square for the cross. (2 marks)
(c) State the ratio of tall to short offspring. (1 mark)
(d) The cross produces 120 offspring. Calculate the expected number of short plants. (1 mark)
(e) Explain why a plant with genotype Tt is tall. (2 marks)
(f) Define the term allele. (1 mark)

Total for Question 6: 8 marks$mq$, $mq$(a) Tt [1]. (b) Gametes T and t from each parent [1]; offspring TT, Tt, Tt, tt [1]. (c) 3 tall : 1 short [1]. (d) 120 x 1/4 = 30 [1]. (e) T is dominant [1], so its effect shows even when only one copy is present (it masks the recessive allele) [1]. (f) A version of a gene [1].$mq$, $mq$A$mq$),
(7, $mq$[[Q 7 | Criterion C: Processing and evaluating]]
A student places magnesium ribbon in hydrochloric acid and measures the time for the ribbon to disappear. Each concentration is tested three times. Times in seconds: 0.5 mol/dm³: 62, 58, 60. 1.0 mol/dm³: 31, 29, 30. 1.5 mol/dm³: 21, 20, 19. 2.0 mol/dm³: 15, 14, 40.
(a) Identify the independent variable and the dependent variable. (2 marks)
(b) Calculate the mean time at 0.5 mol/dm³. (2 marks)
(c) Identify the anomalous result and suggest one reason for it. (2 marks)
(d) Describe the relationship between acid concentration and time taken. (2 marks)
(e) Explain your answer to part (d) using particles. (2 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) Independent: concentration of acid [1]; dependent: time for the magnesium to disappear [1]. (b) (62 + 58 + 60) / 3 [1] = 60.0 s [1]. (c) 40 s at 2.0 mol/dm³ [1]; reason, e.g. timing error, ribbon not fully covered or incomplete mixing [1]. (d) As concentration increases the time taken decreases [1]; the reaction gets faster (about half the time when concentration doubles, so inversely proportional) [1]. (e) Higher concentration means more particles in the same volume [1], so more frequent successful collisions per second and a faster reaction [1].$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

-- Physics MYP 5 eAssessment Structure Mock A (8 tasks, 74 marks) (74 marks)
with sub as (select id from public.subjects where slug = $mq$physics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Physics MYP 5 eAssessment Structure Mock A (8 tasks, 74 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Physics MYP 5 eAssessment Structure Mock A (8 tasks, 74 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6]]
A delivery van of mass 1200 kg starts from rest on a straight, level road. The engine produces a forward driving force of 3000 N. Friction and air resistance together produce a backward force of 1200 N.
(a) State what is meant by the resultant force on an object. (1 mark)
(b) Calculate the resultant force on the van. (1 mark)
(c) Calculate the acceleration of the van. State the unit. (2 marks)
(d) Calculate the speed of the van after 6.0 s, assuming the forces stay constant. (2 marks)

Total for Question 1: 6 marks$mq$, $mq$(a) The single force that has the same effect as all the forces acting on the object together (the vector sum of the forces) [1]. (b) 3000 - 1200 = 1800 N [1]. (c) a = F/m = 1800/1200 [1] = 1.5 m/s² (unit required) [1]. (d) v = u + at = 0 + 1.5 x 6.0 [1] = 9.0 m/s [1] (allow error carried forward from (c)).$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 6]]
The speed-time graph describes the motion of a tram between two stops. Diagram not to scale. [Description: Time in s on the horizontal axis, speed in m/s on the vertical axis. The line rises in a straight line from 0 m/s at 0 s to 20 m/s at 10 s, stays horizontal at 20 m/s until 40 s, then falls in a straight line to 0 m/s at 50 s.]
Time (s): 0, 10, 40, 50 / Speed (m/s): 0, 20, 20, 0
(a) Calculate the acceleration of the tram during the first 10 s. (2 marks)
(b) Describe the motion of the tram between 10 s and 40 s and state what this tells you about the resultant force. (2 marks)
(c) Calculate the total distance travelled between the two stops. (2 marks)

Total for Question 2: 6 marks$mq$, $mq$(a) a = change in speed / time = (20 - 0)/10 [1] = 2.0 m/s² [1]. (b) Constant speed (no acceleration) of 20 m/s [1]; so the resultant force is zero (forces balanced) [1]. (c) Distance = area under the graph [1]: 0.5 x 10 x 20 = 100 m, 30 x 20 = 600 m, 0.5 x 10 x 20 = 100 m, total 800 m [1] (accept trapezium method: 0.5 x (30 + 50) x 20 = 800 m).$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 6]]
A student uses a ripple tank to study water waves. The straight waves have a wavelength of 0.40 m and a frequency of 3.0 Hz.
(a) State what is measured by the frequency of a wave. (1 mark)
(b) Calculate the speed of the water waves. (2 marks)
(c) Sound waves are longitudinal. Describe how the particles of air move in a sound wave. (2 marks)
(d) Explain why sound cannot travel through a vacuum. (1 mark)

Total for Question 3: 6 marks$mq$, $mq$(a) The number of complete waves (oscillations) passing a point each second [1]. (b) v = f x wavelength = 3.0 x 0.40 [1] = 1.2 m/s [1]. (c) Particles vibrate (oscillate) back and forth [1] parallel to (in the same direction as) the direction the wave travels, forming compressions and rarefactions [1]. (d) There are no particles in a vacuum to pass on the vibrations [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 8]]
A mains adaptor for a laptop contains a transformer. The primary coil has 2000 turns and is connected to the 240 V mains supply. The secondary coil gives an output of 12 V. Assume the transformer is ideal.
(a) State the type of transformer, choosing from step-up and step-down. (1 mark)
(b) Calculate the number of turns on the secondary coil. (2 marks)
(c) Explain why a transformer will not work with a steady direct current. (2 marks)
(d) The secondary circuit delivers a current of 2.5 A. Calculate the current in the primary coil. (2 marks)
(e) State one reason why a real transformer is less than 100% efficient. (1 mark)

Total for Question 4: 8 marks$mq$, $mq$(a) Step-down [1]. (b) Vp/Vs = Np/Ns, so Ns = 2000 x 12/240 [1] = 100 turns [1]. (c) A steady d.c. gives a constant magnetic field in the core [1]; only a changing field induces a voltage in the secondary coil (induction needs a changing flux) [1]. (d) Power out = 12 x 2.5 = 30 W [1]; for an ideal transformer Ip = 30/240 = 0.125 A [1] (accept 0.13 A). (e) Any one from: resistance of the coils causes heating; energy lost as heat in the core by eddy currents; not all magnetic flux links the secondary coil [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 10]]
Electromagnets are used in scrapyards to lift steel objects. A student plans an investigation into how the number of turns of insulated wire on an iron nail affects the strength of the electromagnet. The student will measure strength by counting how many steel paper clips the nail can pick up. A variable power supply, an ammeter, a nail and a box of paper clips are available.
(a) State a research question for this investigation. (2 marks)
(b) Formulate a testable hypothesis, using scientific reasoning. (2 marks)
(c) Identify the independent variable and the dependent variable. (2 marks)
(d) Outline two variables that must be controlled and how each would be controlled. (2 marks)
(e) Outline one safety precaution that should be taken. (1 mark)
(f) The paper clips are picked up one at a time, so the strength can only be measured in whole numbers. Suggest one improvement to the method of measuring strength. (1 mark)

Total for Question 5: 10 marks$mq$, $mq$(a) A question linking both variables, e.g. How does the number of turns of wire on an iron nail affect the number of paper clips it can lift? [2] (1 mark only if variables are named but not linked). (b) A prediction linking the variables, e.g. more turns will lift more paper clips [1], with reasoning, e.g. each turn adds to the magnetic field, so more turns give a stronger field [1]. (c) Independent: number of turns of wire [1]; dependent: number of paper clips picked up [1]. (d) Any two from: current (keep the ammeter reading constant by adjusting the supply); same nail / core material and size; same type and mass of paper clip; same method of bringing the nail to the clips; each needs the variable and its control [1][1]. (e) Any one from: the wire and nail can get hot so switch off between readings and use for short times; keep the supply low voltage; keep the power supply away from water [1]. (f) Use a balance or newton meter to measure the force needed to pull the nail away from a steel plate (or measure the mass lifted with a balance) [1].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 12]]
A student investigates the energy changes of a trolley of mass 0.50 kg released from rest on a smooth, sloping track. A light gate measures the speed v of the trolley at the bottom of the track for different release heights h above the bottom. Gravitational field strength g = 9.8 N/kg.
Release height h (m): 0.10, 0.20, 0.30, 0.40, 0.50
Speed at bottom v (m/s): 1.3, 1.8, 2.2, 2.9, 2.8
Values of v squared (m²/s²): 1.69, 3.24, 4.84, 8.41, 7.84
(a) Identify the anomalous result and justify your choice. (2 marks)
(b) Calculate the kinetic energy of the trolley at the bottom when h = 0.30 m. (2 marks)
(c) Calculate the gravitational potential energy lost by the trolley when h = 0.30 m. (2 marks)
(d) Calculate the percentage of the gravitational potential energy transferred to kinetic energy when h = 0.30 m. Give your answer to 2 significant figures. (2 marks)
(e) Suggest one reason why the kinetic energy is smaller than the gravitational potential energy lost. (1 mark)
(f) Describe the relationship shown by the other four results. (1 mark)
(g) Evaluate the method by identifying one limitation and suggesting an improvement. (2 marks)

Total for Question 6: 12 marks$mq$, $mq$(a) The result at h = 0.40 m (v = 2.9 m/s, or v squared = 8.41) [1]; it breaks the trend: speed should increase with height, but it is greater than the speed at 0.50 m [1]. (b) KE = 1/2 m v² = 0.5 x 0.50 x 4.84 [1] = 1.21 J (1.2 J) [1]. (c) GPE = m g h = 0.50 x 9.8 x 0.30 [1] = 1.47 J [1]. (d) 1.21/1.47 x 100 [1] = 82% [1] (allow 82.3%; 1.2/1.47 = 82% also accepted). (e) Energy transferred as heat/sound by friction and air resistance (some energy is dissipated to the surroundings) [1]. (f) As release height increases, v² (and so kinetic energy) increases in direct proportion to h [1] (accept: the faster the trolley, the higher it started, with data support). (g) Limitation, e.g. only one trial at each height / friction on the track / reading error in height [1]; improvement, e.g. repeat and take means / use a lubricated or air track / use a metre rule with a set square to measure height [1].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | A 2 | C 2 | D 6]]
Read the passage.
A coastal council is considering a proposal for an offshore wind farm of 40 turbines. Each turbine has a rated power of 6.0 MW, but because the wind is not always strong, the farm is expected to work at 40% of its rated power on average over the year. The developer says it would bring jobs and cheap electricity. Local fishers say the turbine foundations will reduce their fishing area, and bird charities are concerned about birds flying into the blades. The council also notes that the farm will cost 1.2 billion pounds to build. An average household uses 3.6 MWh of electricity in a year. There are 8760 hours in a year.
(a) State the main energy transfer that takes place in a wind turbine. (2 marks)
(b) Show that the average power output of the wind farm is 96 MW. (2 marks)
(c) Calculate the number of households that could be supplied with electricity in a year. (2 marks)
(d) Discuss, using two different factors (for example economic, environmental, social, political), whether the council should approve the wind farm. Reach a justified conclusion. (4 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) Kinetic energy of the wind [1] is transferred to electrical energy (through the turbine and generator) [1]. (b) 40 x 6.0 = 240 MW rated power [1]; 240 x 0.40 = 96 MW [1]. (c) Energy per year = 96 x 8760 = 840 960 MWh [1]; households = 840 960/3.6 = 233 600 (about 2.3 x 10^5) [1]. (d) Up to 4 marks: a factor identified and linked to the passage, e.g. environmental: no carbon dioxide produced in operation but risk to birds [1]; a second, different factor, e.g. economic: jobs and electricity for 233 600 homes against 1.2 billion pounds cost and loss of fishing income [1]; weighing the factors against each other (e.g. one outweighs the other because of scale or reversibility) [1]; a justified decision, e.g. approve with conditions such as bird-friendly siting and compensation to fishers [1]. Do not credit a decision with no reasoning.$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 4 | C 5 | D 7]]
Read the passage.
A car maker is promoting an electric car with regenerative braking. In regenerative braking the electric motor works backwards as a generator, so the car's kinetic energy is partly transferred to electrical energy and stored in the battery. The car has a mass of 1500 kg and slows from 20 m/s to rest using a constant braking force of 6000 N. The manufacturer claims that 30% of the car's kinetic energy is recovered during each stop. The battery stores 60 kWh. 1 kWh = 3.6 x 10^6 J. A typical journey in a town involves 40 stops from 20 m/s. The advert claims regenerative braking 'greatly extends the range of the car'.
(a) Calculate the kinetic energy of the car at 20 m/s. (2 marks)
(b) Show that the distance the car travels while braking is 50 m. (2 marks)
(c) Explain, using electromagnetic induction, how a generator transfers kinetic energy to electrical energy. (3 marks)
(d) Calculate the energy recovered in one stop, in joules, and show that it is 0.025 kWh. (3 marks)
(e) Calculate the total energy recovered over the 40 stops, in kWh. (1 mark)
(f) Evaluate the claim in the advert, using the data and at least one other factor to reach a judgement. (5 marks)

Total for Question 8: 16 marks$mq$, $mq$(a) KE = 1/2 m v² = 0.5 x 1500 x 20² [1] = 300 000 J (3.0 x 10^5 J) [1]. (b) Work done by braking force = KE lost, so F x d = 300 000 [1]; d = 300 000/6000 = 50 m [1]. (c) A coil (or the magnets of the generator) is made to rotate, so the coil cuts through magnetic field lines / the magnetic flux linking the coil changes [1]; this induces a voltage (emf) across the coil [1]; if connected to a circuit a current flows, and a faster spin or stronger field gives a bigger voltage [1]. (d) Energy recovered = 0.30 x 300 000 [1] = 90 000 J [1]; 90 000/3.6 x 10^6 = 0.025 kWh [1]. (e) 40 x 0.025 = 1.0 kWh [1]. (f) Five marks: use of data, e.g. recovered energy over a typical journey is 1.0 kWh, about 1.7% of the 60 kWh battery [1]; interpretation, e.g. the energy per stop is small compared with battery capacity so 'greatly extends' is not supported by these figures [1]; another factor, e.g. benefit depends on driving style and is greater in stop-start town driving than on motorways [1]; a second factor, e.g. less wear on friction brakes and less brake dust, but the manufacturer has a commercial interest so the claim may be biased [1]; a justified judgement, e.g. the claim is exaggerated but regenerative braking gives a modest, real saving [1]. Level guide: statements without data score at most 2; use of calculated data plus one extra factor scores 3-4; a balanced evaluation with a justified judgement scores 5.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Physics MYP 5 eAssessment Structure Mock B (8 tasks, 78 marks) (78 marks)
with sub as (select id from public.subjects where slug = $mq$physics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Physics MYP 5 eAssessment Structure Mock B (8 tasks, 78 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Physics MYP 5 eAssessment Structure Mock B (8 tasks, 78 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6]]
A kettle contains 0.50 kg of water at 20 °C. The kettle has a power rating of 2000 W. The specific heat capacity of water is 4200 J/kg°C.
(a) State the process by which thermal energy from the Sun reaches the Earth. (1 mark)
(b) Calculate the energy needed to heat the water to 100 °C. (2 marks)
(c) Calculate the minimum time the kettle takes to do this. (2 marks)
(d) In practice the kettle takes longer than the time in (c). Suggest one reason. (1 mark)

Total for Question 1: 6 marks$mq$, $mq$(a) Radiation (infrared radiation / electromagnetic waves) [1]. (b) Q = m c ΔT = 0.50 x 4200 x (100 - 20) [1] = 168 000 J (168 kJ) [1]. (c) time = energy/power = 168 000/2000 [1] = 84 s [1]. (d) Some energy heats the kettle itself or is lost to the surroundings (not 100% efficient) [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 6]]
Carbon-14 is a radioactive isotope of carbon. It has 6 protons and a nucleon number of 14. Radium-226 has 88 protons and decays by emitting an alpha particle.
(a) State the number of neutrons in a nucleus of carbon-14. (1 mark)
(b) State what is meant by isotopes. (1 mark)
(c) Determine the nucleon number and the proton number of the nucleus formed when radium-226 emits an alpha particle. (2 marks)
(d) Compare the penetrating power of alpha, beta and gamma radiation. (2 marks)

Total for Question 2: 6 marks$mq$, $mq$(a) 14 - 6 = 8 neutrons [1]. (b) Atoms of the same element (same number of protons) with different numbers of neutrons [1]. (c) An alpha particle is 2 protons and 2 neutrons, so nucleon number 226 - 4 = 222 [1] and proton number 88 - 2 = 86 [1] (radon-222). (d) Alpha is stopped by paper or a few centimetres of air (least penetrating) [1]; beta is stopped by a few millimetres of aluminium, and gamma is the most penetrating, needing thick lead or concrete to reduce it [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 6 | C 2]]
Technetium-99m is a medical tracer. It is injected into a patient and its gamma rays are detected outside the body. Its half-life is 6.0 hours and the activity of a dose at injection is 480 MBq.
(a) State what is meant by half-life. (1 mark)
(b) Determine the activity of the dose after 18 hours. (2 marks)
(c) Determine the time taken for the activity to fall below 10 MBq. (2 marks)
(d) Explain why a source with a short half-life that emits gamma rays is suitable as a tracer. (2 marks)
(e) State one precaution that a radiographer should take when handling the dose. (1 mark)

Total for Question 3: 8 marks$mq$, $mq$(a) The time taken for the activity (or the number of undecayed nuclei) to halve [1]. (b) 18 h is 3 half-lives [1]; 480 -> 240 -> 120 -> 60 MBq [1]. (c) Activity after each 6 h: 240, 120, 60, 30, 15, 7.5 MBq [1]; so 36 h (6 half-lives) [1]. (d) Gamma rays are very penetrating so they pass out of the body to be detected [1]; the short half-life means the activity falls quickly, so the patient receives a smaller total dose and is not radioactive for long [1]. (e) Any one from: use tongs or remote handling; wear a lead apron/shielding; limit time near the source; wear a dosimeter badge [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 6 | C 2]]
The nearest star to the Sun is Proxima Centauri, at a distance of 4.24 light-years. One light-year is 9.46 x 10^15 m. The Sun is 1.50 x 10^11 m from Earth. The speed of light is 3.00 x 10^8 m/s.
(a) State what is meant by a light-year. (1 mark)
(b) Calculate the distance to Proxima Centauri in metres. Give your answer to 3 significant figures. (2 marks)
(c) Calculate the time taken for light from the Sun to reach the Earth. Give your answer in minutes. (2 marks)
(d) Describe what happens to a star much more massive than the Sun after it leaves the main sequence. (2 marks)
(e) State one piece of evidence for the Big Bang theory. (1 mark)

Total for Question 4: 8 marks$mq$, $mq$(a) The distance light travels in one year in a vacuum [1]. (b) 4.24 x 9.46 x 10^15 [1] = 4.01 x 10^16 m [1]. (c) t = d/c = 1.50 x 10^11/3.00 x 10^8 = 500 s [1]; 500/60 = 8.3 minutes [1]. (d) It expands into a red supergiant [1]; it then explodes as a supernova, leaving a neutron star or black hole [1]. (e) Any one from: red-shift of light from distant galaxies (the Universe is expanding); cosmic microwave background radiation [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 12]]
Insulation is used to reduce the rate at which hot drinks cool. A student wants to find out how the number of layers of newspaper wrapped around a beaker affects how much the temperature of hot water falls in 10 minutes. The equipment available is a set of identical 250 cm³ beakers, newspaper, elastic bands, a kettle, a thermometer, a measuring cylinder and a stopwatch.
(a) State a research question for this investigation. (2 marks)
(b) Formulate a testable hypothesis, using scientific reasoning. (2 marks)
(c) Identify the independent variable and the dependent variable, stating how each will be measured. (2 marks)
(d) Outline two variables that must be controlled. (2 marks)
(e) Outline a method, in no more than four steps, that the student could follow. (3 marks)
(f) Outline one safety precaution. (1 mark)

Total for Question 5: 12 marks$mq$, $mq$(a) A question linking both variables, e.g. How does the number of layers of newspaper around a beaker affect the fall in temperature of hot water in 10 minutes? [2] (1 mark only if the variables are named but not linked). (b) A prediction linking the variables, e.g. more layers will cause a smaller fall in temperature [1], with reasoning, e.g. trapped air between the layers is a poor conductor so less thermal energy is transferred to the surroundings [1]. (c) Independent: number of layers of newspaper, counted [1]; dependent: fall in temperature (starting temperature minus temperature after 10 minutes), measured with a thermometer [1]. (d) Any two from: starting temperature of the water; volume of water; size and type of beaker; room temperature / position in the room; time (10 minutes); whether a lid is used [1][1]. (e) Pour the same volume of hot water into each beaker with different numbers of layers and record the starting temperature [1]; start the stopwatch and leave each beaker in the same place [1]; after 10 minutes record the final temperature, calculate the fall in temperature, and repeat to calculate a mean [1]. (f) Any one from: take care with boiling water from the kettle, fill beakers away from the edge of the bench, wipe up spills [1].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 12]]
The student carries out the investigation in Question 5 with the starting temperature of the water at 80 °C. Each trial was repeated twice (trial 1 and trial 2). The results show the fall in temperature after 10 minutes.
Number of layers: 0, 1, 2, 3, 4
Fall in temperature, trial 1 (°C): 42, 33, 27, 24, 23
Fall in temperature, trial 2 (°C): 40, 35, 27, 31, 22
(a) Identify the anomalous result. (1 mark)
(b) Calculate the mean fall in temperature for 1 layer. (1 mark)
(c) Explain how the student should deal with the anomalous result and state the value of the fall in temperature that should be used for that number of layers. (2 marks)
(d) The mean falls in temperature for 0, 2 and 4 layers are 41, 27 and 22.5 °C. Describe the trend shown by the results. (2 marks)
(e) Calculate the percentage decrease in the fall in temperature between 0 layers and 4 layers. Give your answer to 2 significant figures. (2 marks)
(f) Explain the trend using ideas about conduction and trapped air. (2 marks)
(g) Evaluate the method by identifying one limitation and suggesting a specific improvement. (2 marks)

Total for Question 6: 12 marks$mq$, $mq$(a) 31 °C for 3 layers in trial 2 [1]. (b) (33 + 35)/2 = 34 °C [1]. (c) Ignore (exclude) the anomalous value, or repeat the measurement for 3 layers [1]; use 24 °C (the value from trial 1, or a new repeated mean) [1]. (d) As the number of layers increases, the fall in temperature decreases [1]; with data support, e.g. from 41 °C at 0 layers to 22.5 °C at 4 layers, and the decrease gets smaller with each extra layer (levels off) [1]. (e) (41 - 22.5)/41 x 100 [1] = 45% [1] (45.1% before rounding). (f) Air is trapped between the layers of paper and air is a poor conductor (insulator) [1]; so less thermal energy is transferred by conduction from the beaker to the surroundings [1] (accept reduced convection currents). (g) Limitation, e.g. only two trials / hand-held thermometer reading to 1 °C / water cooling by evaporation from the open top / no lid [1]; improvement, e.g. repeat three times, use a data logger or put a lid on each beaker [1].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | C 4 | D 6]]
Read the passage.
A country burns coal in a power station of output 1000 MW. The station operates at 70% of this output on average over the year (8760 hours). Burning coal produces 0.90 tonnes of carbon dioxide for every MWh of electricity generated. The government proposes to replace it with a nuclear power station of the same average output. Over its whole life cycle, a nuclear station produces 0.012 tonnes of carbon dioxide per MWh. The nuclear plant would produce radioactive waste that must be stored safely for thousands of years. Supporters say it would provide reliable power that does not depend on the weather. Opponents say it costs more to build and that an accident, although rare, would be serious.
(a) Calculate the energy generated by the coal power station in one year, in MWh. (1 mark)
(b) Calculate the mass of carbon dioxide produced by the coal power station in one year. (1 mark)
(c) Calculate the percentage reduction in carbon dioxide emissions if the coal station is replaced by the nuclear station. Give your answer to 3 significant figures. (2 marks)
(d) Evaluate whether the government should replace the coal power station with the nuclear station. Refer to at least two different factors (for example environmental, economic, social, political) and reach a justified conclusion. (6 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) 1000 x 0.70 x 8760 = 6 132 000 MWh (6.13 x 10^6 MWh) [1]. (b) 6 132 000 x 0.90 = 5 518 800 tonnes (5.52 x 10^6 tonnes) [1]. (c) Nuclear emissions = 6 132 000 x 0.012 = 73 584 tonnes [1]; reduction = (5 518 800 - 73 584)/5 518 800 x 100 = 98.7% [1] (equivalent: (0.90 - 0.012)/0.90). (d) Level guide, 6 marks. Levels 1-2 (1-2 marks): lists points about nuclear or coal with little link to the passage. Levels 3-4 (3-4 marks): two factors explained with evidence, e.g. environmental: emissions fall by 98.7% (about 5.4 million tonnes less carbon dioxide) which helps limit climate change, but the waste stays hazardous for thousands of years; economic: higher build cost versus reliable output independent of weather. Levels 5-6 (5-6 marks): the factors are weighed against each other (e.g. long-term global benefit versus local risk and cost, who bears each), the scale and likelihood of risks are discussed, and a clear justified conclusion is reached, e.g. support the replacement with a secure waste storage plan, or oppose it in favour of cheaper alternatives. [6]$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 3 | C 6 | D 7]]
Read the passage.
Astronomers observe a star similar to the Sun. Its brightness dips by a small, regular amount every 3.5 days. They think a planet passes in front of the star (a transit). The star has radius 7.0 x 10^8 m. The planet has radius 7.0 x 10^7 m and orbits at a distance of 7.5 x 10^9 m from the star, in a circular orbit. The Earth orbits the Sun at 1.5 x 10^11 m. Hydrogen light from a laboratory has wavelength 656.3 nm, and in the light from the star it shows a tiny shift of 0.00022 nm that changes direction every 3.5 days. The fractional change in wavelength = velocity of the star / speed of light, with the speed of light 3.0 x 10^8 m/s. The fraction of the star's light blocked in a transit is (planet radius/star radius)². The brightness of starlight falling on a planet is inversely proportional to the square of its distance from the star.
(a) State why the brightness of the star dips during a transit. (1 mark)
(b) Show that the brightness of the star dips by about 1% during a transit. (2 marks)
(c) The orbital period is 3.5 days (3.5 x 24 x 3600 s). Calculate the orbital speed of the planet. Give your answer in m/s to 3 significant figures. (3 marks)
(d) Calculate the speed of the star towards and away from Earth that causes the shift of 0.00022 nm. (2 marks)
(e) Explain how the shift in the star's spectrum provides evidence for the planet. (2 marks)
(f) Calculate how many times brighter the starlight is at this planet than at the Earth. (1 mark)
(g) Evaluate whether this planet is likely to support life as we know it, and discuss why scientists use more than one method before announcing a new planet. (5 marks)

Total for Question 8: 16 marks$mq$, $mq$(a) The planet blocks (absorbs or scatters) part of the starlight reaching Earth [1]. (b) (7.0 x 10^7/7.0 x 10^8)² = (0.10)² [1] = 0.010 = 1% [1]. (c) Circumference = 2 x π x 7.5 x 10^9 = 4.71 x 10^10 m [1]; period = 3.5 x 24 x 3600 = 302 400 s [1]; speed = 4.71 x 10^10/302 400 = 1.56 x 10^5 m/s [1]. (d) v = c x change in wavelength/wavelength [1] = 3.0 x 10^8 x 0.00022/656.3 = 1.0 x 10^2 m/s (101 m/s) [1]. (e) The shift (Doppler effect) is towards red when the star moves away and towards blue when it moves towards us [1]; the change repeats every 3.5 days, matching the transit period, because the planet's gravity makes the star wobble as they orbit their common centre [1]. (f) (1.5 x 10^11/7.5 x 10^9)² = 20² = 400 times brighter [1]. (g) Five marks: the planet receives about 400 times as much starlight as Earth, so is far too hot for liquid water [1]; it is so close and has a short year, so conditions are extreme (and its radius is about ten times Earth's, so it is probably a gas giant with no solid surface) [1]; so it is unlikely to support life as we know it [1]; using more than one method (transit and spectral shift) confirms the planet exists, reduces the chance of errors (such as star spots causing dips), and gives its size from one method and mass from the other [1]; findings are shared and checked by independent teams (peer review, international cooperation, data from space telescopes) so the evidence is reliable [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);


commit;
