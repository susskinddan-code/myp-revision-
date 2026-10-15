-- 6 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Standard Mathematics MYP 5 Interactive Practice (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$standard-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Standard Mathematics MYP 5 Interactive Practice (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Standard Mathematics MYP 5 Interactive Practice (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 5 | C 2]]
The straight line has equation y = 2x - 3.
(a) Complete the table of values. Write each x-value in the first column and the matching y-value in the second column, for x = -1, 0, 1, 2 and 3 (in that order). (2 marks)
{{fill|t1|x,y|5}}
(b) Plot the five points from your table on the grid. (2 marks)
{{plot|p1|-2,4,-6,6|x|y}}
(c) The gradient of the line is {{select|g1|-3|2|3|1/2}} and the y-intercept is {{select|g2|-3|2|3|1/2}}. (2 marks)
(d) The line passes through the point (5, k). Find the value of k. (1 mark)

Total for Question 1: 7 marks$mq$, $mq$(a) Interactive answer [t1] rows in order: (-1, -5), (0, -3), (1, -1), (2, 1), (3, 3). Three or four correct rows [1]; all five correct [1]. (b) Interactive answer [p1]: plotted (-1, -5), (0, -3), (1, -1), (2, 1), (3, 3). At least three points correct [1]; all five correct [1]; joining the points is not required. (c) Interactive answers [g1] = 2 [1] and [g2] = -3 [1]. (d) k = 2 x 5 - 3 = 7 [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 2 | C 2 | D 3]]
A student recorded the hours of screen time on each day of one week.
{{chart|bar|Screen time per day|Day|Hours|Mon:3,Tue:2,Wed:4,Thu:3,Fri:6,Sat:10,Sun:7}}
(a) State the screen time on Saturday. (1 mark)
(b) Match each statistic to its value by placing the values in the table. (4 marks)
{{drag|m1|Mean,Median,Mode,Range|3 hours,4 hours,5 hours,6 hours,8 hours}}
(c) The student says "The {{select|c1|mean|median}} gives the best idea of a typical day." Give a reason for the choice made in the drop-down. (2 marks)

Total for Question 2: 7 marks$mq$, $mq$(a) 10 hours [1]. (b) Interactive answer [m1]: Mean = 5 hours [1]; Median = 4 hours [1]; Mode = 3 hours [1]; Range = 8 hours [1]. (Total 35 hours / 7 = 5; ordered data 2, 3, 3, 4, 6, 7, 10; range 10 - 2 = 8.) 6 hours is a distractor. (c) Interactive answer [c1] = median [1]; reason: Saturday (10 hours) is much larger than the other days so it pulls the mean up above most days, whereas the median is not affected by the extreme value [1].$mq$, $mq$D$mq$),
(3, $mq$[[Q 3 | B 5 | C 2]]
A sequence begins 5, 8, 11, 14, ...
(a) Complete the table for the first five terms. Write n in the first column and the term in the second column for n = 1 to 5. (2 marks)
{{fill|t3|n,Term|5}}
(b) Plot the first four terms as points (n, term) on the grid. (2 marks)
{{plot|p3|0,6,0,20|n|Term}}
(c) The sequence is {{select|s1|linear|quadratic|geometric}}. (1 mark)
(d) Write an expression for the nth term and use it to find the 30th term. (2 marks)

Total for Question 3: 7 marks$mq$, $mq$(a) Interactive answer [t3] rows: (1, 5), (2, 8), (3, 11), (4, 14), (5, 17). First three rows correct [1]; last two rows correct [1]. (b) Interactive answer [p3]: plotted (1, 5), (2, 8), (3, 11), (4, 14). Three points correct [1]; all four correct [1]. (c) Interactive answer [s1] = linear [1] (constant difference 3). (d) nth term = 3n + 2 [1]; 30th term = 3 x 30 + 2 = 92 [1].$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | A 3 | D 4]]
A family's monthly budget is GBP 2400. The pie chart shows how it is spent (amounts in GBP).
{{chart|pie|Monthly budget (GBP)|||Rent:960,Food:480,Travel:360,Savings:360,Other:240}}
(a) Match each category to its percentage of the total budget. (3 marks)
{{drag|d4|Food,Travel,Other|10%,15%,20%,40%}}
(b) Calculate the angle of the Savings sector in a pie chart drawn with 360 degrees. (2 marks)
(c) The rent increases by 5%. Calculate the new rent. (2 marks)

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [d4]: Food = 20% [1]; Travel = 15% [1]; Other = 10% [1]. (480/2400 = 20%; 360/2400 = 15%; 240/2400 = 10%.) 40% is Rent and is a distractor. (b) 360/2400 = 15% [1]; 0.15 x 360 = 54 degrees [1]. (c) 960 x 1.05 [1] = GBP 1008 [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Standard Mathematics MYP 5 Interactive Practice (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$standard-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Standard Mathematics MYP 5 Interactive Practice (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Standard Mathematics MYP 5 Interactive Practice (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6 | C 2]]
Consider the function y = x^2 - 4.
(a) Complete the table. Write x in the first column and y in the second column for x = -3, -2, -1, 0, 1, 2, 3 (in that order). (2 marks)
{{fill|t1|x,y|7}}
(b) Plot the seven points on the grid. (2 marks)
{{plot|p1|-4,4,-5,6|x|y}}
(c) The graph of y = x^2 - 4 is {{select|s1|U-shaped|n-shaped|a straight line}} and its line of symmetry is {{select|s2|x = 0|y = 0|x = -4}}. (2 marks)
(d) Solve x^2 - 4 = 0. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) Interactive answer [t1] rows: (-3, 5), (-2, 0), (-1, -3), (0, -4), (1, -3), (2, 0), (3, 5). Five or six correct rows [1]; all seven correct [1]. (b) Interactive answer [p1]: plotted (-3, 5), (-2, 0), (-1, -3), (0, -4), (1, -3), (2, 0), (3, 5). Five or more correct [1]; all seven correct [1]. (c) [s1] = U-shaped [1]; [s2] = x = 0 [1]. (d) x^2 = 4 [1]; x = 2 or x = -2 [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | B 2 | C 2 | D 3]]
Mia saves the same amount each month. The line chart shows her savings (GBP) at the end of each month, January to June.
{{chart|line|Mia's savings|Month|Savings (GBP)|Jan:200,Feb:260,Mar:320,Apr:380,May:440,Jun:500}}
(a) The pattern of her savings is {{select|a1|linear|exponential}}. (1 mark)
(b) State how much Mia adds each month. (1 mark)
(c) Predict her savings for July, August and September. Write the month in the first column and the savings in the second column. (3 marks)
{{fill|t2|Month,Savings (GBP)|3}}
(d) Savings for January are GBP 200. Find the first month in which she has at least GBP 1000, counting on from January (give the month and say which year). (2 marks)

Total for Question 2: 7 marks$mq$, $mq$(a) Interactive answer [a1] = linear [1]. (b) GBP 60 [1]. (c) Interactive answer [t2] rows: (Jul, 560), (Aug, 620), (Sep, 680). July correct [1]; August correct [1]; September correct [1]. (d) 200 + 60(m - 1) >= 1000 gives m - 1 >= 13.33, so m = 15 [1] (month 15 counting January as month 1) which is March of the following year [1].$mq$, $mq$D$mq$),
(3, $mq$[[Q 3 | A 5 | C 1]]
A right-angled triangle has sides 5 cm, 12 cm and 13 cm. The angle theta is opposite the 5 cm side. Diagram not to scale.
(a) The triangle is right-angled because {{select|r1|5^2 + 12^2 = 13^2|5 + 12 = 13|5 x 12 = 13^2}}. (1 mark)
(b) Match each ratio to its value. (3 marks)
{{drag|d1|sin(theta),cos(theta),tan(theta)|5/13,12/13,5/12,12/5}}
(c) Calculate theta correct to 1 decimal place. (2 marks)

Total for Question 3: 6 marks$mq$, $mq$(a) Interactive answer [r1] = 5^2 + 12^2 = 13^2 [1]. (b) Interactive answer [d1]: sin(theta) = 5/13 [1]; cos(theta) = 12/13 [1]; tan(theta) = 5/12 [1]. 12/5 is a distractor. (c) theta = tan^-1(5/12) [1] = 22.6 degrees (1 d.p.) [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 2 | D 5]]
A cyclist leaves home at time 0 and travels to a viewpoint, rests, then returns home. Distance from home is d km at time t hours.
- At t = 0 the cyclist is at home.
- At t = 2 the cyclist is 24 km from home.
- The cyclist rests until t = 3.
- The cyclist returns home at a steady speed, arriving at t = 5.
(a) Plot the four points showing the start, the arrival, the end of the rest and the arrival home, and join them with straight lines. (2 marks)
{{plot|p4|0,6,0,30|t (hours)|d (km)}}
(b) During the rest the graph is {{select|h1|horizontal|the steepest part|a curve}}. (1 mark)
(c) Complete the table for the distance from home. Write t in the first column and d in the second column for t = 1 and t = 4. (2 marks)
{{fill|t4|t (hours),d (km)|2}}
(d) Calculate the average speed on the journey out. (1 mark)
(e) Calculate the average speed for the whole journey including the rest. (1 mark)

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [p4]: plotted (0, 0), (2, 24), (3, 24), (5, 0), joined by straight lines. Three points correct [1]; all four correct and joined [1]. (b) [h1] = horizontal [1]. (c) Interactive answer [t4] rows: (1, 12) [1] and (4, 12) [1]. (Return speed 24/2 = 12 km/h so at t = 4 the distance is 24 - 12 = 12 km.) (d) 24/2 = 12 km/h [1]. (e) Total distance 48 km / 5 h = 9.6 km/h [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Extended Mathematics MYP 5 Interactive Practice (4 tasks, 30 marks) (30 marks)
with sub as (select id from public.subjects where slug = $mq$extended-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Extended Mathematics MYP 5 Interactive Practice (4 tasks, 30 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Extended Mathematics MYP 5 Interactive Practice (4 tasks, 30 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 7 | C 1]]
A function is f(x) = x^2 - 2x - 3.
(a) Complete the table. Write x in the first column and f(x) in the second column for x = -2, -1, 0, 1, 2, 3, 4 (in that order). (2 marks)
{{fill|t1|x,f(x)|7}}
(b) Plot the points and draw the curve through them by joining the points. (2 marks)
{{plot|p1|-2,4,-5,6|x|f(x)}}
(c) The factorised form of f(x) is {{select|f1|(x - 3)(x + 1)|(x + 3)(x - 1)|(x - 3)(x - 1)}}. (1 mark)
(d) Write down the coordinates of the minimum point. (1 mark)
(e) Solve x^2 - 2x - 3 = 5. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) Interactive answer [t1] rows: (-2, 5), (-1, 0), (0, -3), (1, -4), (2, -3), (3, 0), (4, 5). Five or six rows correct [1]; all seven correct [1]. (b) Interactive answer [p1]: plotted (-2, 5), (-1, 0), (0, -3), (1, -4), (2, -3), (3, 0), (4, 5). Five or more correct [1]; all seven correct [1]. (c) [f1] = (x - 3)(x + 1) [1]. (d) (1, -4) [1]. (e) x^2 - 2x - 8 = 0 [1]; (x - 4)(x + 2) = 0 so x = 4 or x = -2 [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | B 5 | C 2]]
A culture starts with 100 bacteria. The number doubles every hour.
{{chart|line|Bacteria count|Hour|Number of bacteria|0:100,1:200,2:400,3:800,4:1600,5:3200}}
(a) The growth is {{select|g1|exponential|linear|quadratic}}. (1 mark)
(b) Complete the table for hours 6, 7 and 8. Write the hour in the first column and the number of bacteria in the second column. (3 marks)
{{fill|t2|Hour,Number of bacteria|3}}
(c) Write a formula for the number of bacteria N after t hours. (1 mark)
(d) Find the smallest whole number of hours after which there are more than 1 000 000 bacteria. Show your working. (2 marks)

Total for Question 2: 7 marks$mq$, $mq$(a) Interactive answer [g1] = exponential [1]. (b) Interactive answer [t2] rows: (6, 6400) [1]; (7, 12800) [1]; (8, 25600) [1]. (c) N = 100 x 2^t [1]. (d) 100 x 2^t > 1 000 000 so 2^t > 10 000 [1]; 2^13 = 8192 is too small and 2^14 = 16384 works, so 14 hours [1].$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | A 5 | C 3]]
In triangle ABC, side a = BC = 7 cm, side b = CA = 9 cm and angle C = 60 degrees. Diagram not to scale.
(a) Choose the correct rule for each situation. (3 marks)
{{drag|d1|Two sides and the included angle; find the third side,Two angles and one side; find another side,Three sides; find an angle|Cosine rule to find a side,Sine rule,Cosine rule to find an angle,Pythagoras theorem}}
(b) Calculate the length of AB correct to 3 significant figures. (3 marks)
(c) Calculate the area of the triangle correct to 3 significant figures. (2 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) Interactive answer [d1]: first slot = Cosine rule to find a side [1]; second slot = Sine rule [1]; third slot = Cosine rule to find an angle [1]. Pythagoras theorem is a distractor. (b) c^2 = 7^2 + 9^2 - 2 x 7 x 9 x cos 60 [1] = 130 - 63 = 67 [1]; c = 8.19 cm (3 s.f.) [1]. (c) Area = 1/2 x 7 x 9 x sin 60 [1] = 27.3 cm^2 (3 s.f.) [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 3 | D 4]]
Two phone plans are compared. Plan A costs y = 2x + 1 and plan B costs y = 7 - x, where x is the number of hours and y is the cost in GBP.
(a) Complete the table. Write x in the first column, then the cost for plan A, then the cost for plan B, for x = 0, 1, 2, 3, 4. (3 marks)
{{fill|t4|x,Plan A (y = 2x + 1),Plan B (y = 7 - x)|5}}
(b) Plot the point where the two plans cost the same. (1 mark)
{{plot|p4|0,8,0,10|x (hours)|y (GBP)}}
(c) The number of solutions of the simultaneous equations is {{select|n1|exactly one|none|infinitely many}}. (1 mark)
(d) Solve the equations algebraically to confirm your point. (2 marks)

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [t4] rows: (0, 1, 7), (1, 3, 6), (2, 5, 5), (3, 7, 4), (4, 9, 3). The x column correct [1]; Plan A column correct [1]; Plan B column correct [1]. (b) Interactive answer [p4]: plotted (2, 5) [1]. (c) [n1] = exactly one [1]. (d) 2x + 1 = 7 - x [1] so 3x = 6, x = 2 and y = 5 [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Physics MYP 5 Interactive Practice (4 tasks, 27 marks) (27 marks)
with sub as (select id from public.subjects where slug = $mq$physics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Physics MYP 5 Interactive Practice (4 tasks, 27 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Physics MYP 5 Interactive Practice (4 tasks, 27 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 2 | C 6]]
A trolley accelerates from rest. Its speed is recorded every 2 seconds.
{{chart|line|Speed of a trolley|Time (s)|Speed (m/s)|0:0,2:4,4:8,6:12,8:12}}
(a) Calculate the acceleration of the trolley during the first 6 s. (2 marks)
(b) Between 6 s and 8 s the trolley moves with {{select|m1|constant speed|constant acceleration|zero speed}}. (1 mark)
(c) Calculate the distance travelled in the first 6 s using the area under the graph. (2 marks)
(d) Plot the distance travelled (in metres) at t = 0, 2, 4 and 6 s. Use the fact that the distance travelled is equal to t squared for this motion. (2 marks)
{{plot|p1|0,8,0,40|Time (s)|Distance (m)}}
(e) The shape of the distance-time graph for the first 6 s is {{select|m2|a curve|a straight line|horizontal}}. (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) a = change in speed / time = 12 / 6 [1] = 2 m/s^2 [1]. (b) Interactive answer [m1] = constant speed [1]. (c) Area of triangle = 1/2 x 6 x 12 [1] = 36 m [1]. (d) Interactive answer [p1]: plotted (0, 0), (2, 4), (4, 16), (6, 36). Three points correct [1]; all four correct [1]. (e) [m2] = a curve [1].$mq$, $mq$C$mq$),
(2, $mq$[[Q 2 | A 6 | C 2]]
A roller coaster car of mass 500 kg starts from rest at the top of a hill 20 m high. Use g = 10 N/kg and assume there is no friction until the brakes are used.
(a) Choose the main energy store at each point. (3 marks)
{{drag|d1|Top of the hill,Bottom of the hill,After braking to a stop|Gravitational potential,Kinetic,Thermal,Chemical}}
(b) Assuming no friction, the total mechanical energy of the car is {{select|e1|conserved|increased|destroyed}} as it rolls down. (1 mark)
(c) Calculate the gravitational potential energy at the top of the hill. (2 marks)
(d) Calculate the speed of the car at the bottom of the hill. (2 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) Interactive answer [d1]: top = Gravitational potential [1]; bottom = Kinetic [1]; after braking = Thermal [1]. Chemical is a distractor. (b) Interactive answer [e1] = conserved [1]. (c) GPE = mgh = 500 x 10 x 20 [1] = 100 000 J (100 kJ) [1]. (d) 1/2 m v^2 = 100 000 so v^2 = 2 x 100 000 / 500 = 400 [1]; v = 20 m/s [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 1 | C 5]]
A student investigates a 4 ohm resistor. The potential difference (p.d.) is changed and the current is measured.
p.d. (V): 0, 4, 8, 12. Current (A): 0, 1, 2, 3.
(a) Plot the four points (p.d. on the x-axis, current on the y-axis). (2 marks)
{{plot|p3|0,12,0,4|p.d. (V)|Current (A)}}
(b) The graph is {{select|o1|a straight line through the origin|a curve|a horizontal line}} so the resistor obeys Ohm's law. (1 mark)
(c) The 4 ohm resistor is connected in series with an 8 ohm resistor and a 12 V cell. Complete the table for the current in the circuit and the p.d. across the 4 ohm resistor. (2 marks)
{{fill|t3|Current (A),p.d. across 4 ohm resistor (V)|1}}
(d) State why the current in the 8 ohm resistor is the same as in the 4 ohm resistor. (1 mark)

Total for Question 3: 6 marks$mq$, $mq$(a) Interactive answer [p3]: plotted (0, 0), (4, 1), (8, 2), (12, 3). Three points correct [1]; all four correct [1]. (b) [o1] = a straight line through the origin [1]. (c) Interactive answer [t3]: current 1 A [1] (I = 12 / (4 + 8) = 1 A); p.d. 4 V [1] (V = 1 x 4). (d) In a series circuit there is only one path so the same current flows through every component [1].$mq$, $mq$C$mq$),
(4, $mq$[[Q 4 | A 2 | D 3]]
A town's electricity comes from five sources. The bar chart shows each source's share (%) of the electricity generated in one year.
{{chart|bar|Electricity sources|Source|Share (%)|Gas:40,Wind:25,Nuclear:15,Solar:10,Coal:10}}
(a) Calculate the percentage of electricity from wind and solar combined. (1 mark)
(b) Classify each source. (3 marks)
{{drag|c1|Wind,Gas,Nuclear|Renewable,Fossil fuel,Nuclear fuel}}
(c) Suggest one environmental advantage of replacing coal with wind. (1 mark)

Total for Question 4: 5 marks$mq$, $mq$(a) 25 + 10 = 35% [1]. (b) Interactive answer [c1]: Wind = Renewable [1]; Gas = Fossil fuel [1]; Nuclear = Nuclear fuel [1]. (c) Wind produces no carbon dioxide while generating electricity, so it reduces greenhouse gas emissions and air pollution [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Chemistry MYP 5 Interactive Practice (4 tasks, 27 marks) (27 marks)
with sub as (select id from public.subjects where slug = $mq$chemistry$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Chemistry MYP 5 Interactive Practice (4 tasks, 27 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Chemistry MYP 5 Interactive Practice (4 tasks, 27 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Sodium and chlorine are in the third period of the periodic table.
(a) Complete the table for a sodium-23 atom (11 protons) in row 1 and a chloride ion made from chlorine-35 (17 protons) in row 2. Write the number of protons, neutrons and electrons in the three columns. (3 marks)
{{fill|t1|Protons,Neutrons,Electrons|2}}
(b) Match each element to its group. (3 marks)
{{drag|d1|Sodium,Chlorine,Neon|Group 1 alkali metal,Group 17 halogen,Group 18 noble gas,Group 2 alkaline earth metal}}
(c) The electron arrangement of a sodium atom is {{select|e1|2,8,1|2,8,2|2,1}}. (1 mark)
(d) Explain why sodium and chlorine form an ionic compound. (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) Interactive answer [t1] rows: row 1 = 11, 12, 11 [1]; row 2 protons 17 and neutrons 18 [1]; row 2 electrons 18 [1]. (b) Interactive answer [d1]: Sodium = Group 1 alkali metal [1]; Chlorine = Group 17 halogen [1]; Neon = Group 18 noble gas [1]. Group 2 is a distractor. (c) [e1] = 2,8,1 [1]. (d) Sodium (a metal) transfers its outer electron to chlorine (a non-metal) forming oppositely charged ions held together by electrostatic attraction [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 1 | C 6]]
A student measures the volume of gas produced when magnesium reacts with acid, every 10 seconds.
{{chart|line|Gas produced|Time (s)|Volume (cm3)|0:0,10:16,20:27,30:34,40:38,50:40,60:40}}
(a) State the total volume of gas collected. (1 mark)
(b) The reaction stopped at {{select|s1|10 s|30 s|50 s|60 s}}. (1 mark)
(c) Calculate the mean rate of reaction over the first 10 s, with units. (2 marks)
(d) With a catalyst the volumes at 0, 10, 20 and 30 s are 0, 27, 37 and 40 cm3. Plot these points. (2 marks)
{{plot|p1|0,40,0,40|Time (s)|Volume (cm3)}}
(e) The catalyst makes the reaction faster because it {{select|c1|lowers the activation energy|increases the amount of acid|lowers the temperature}}. (1 mark)

Total for Question 2: 7 marks$mq$, $mq$(a) 40 cm3 [1]. (b) Interactive answer [s1] = 50 s [1] (the volume stops changing at 50 s). (c) 16 / 10 [1] = 1.6 cm3/s [1]. (d) Interactive answer [p1]: plotted (0, 0), (10, 27), (20, 37), (30, 40). Three points correct [1]; all four correct [1]. (e) Interactive answer [c1] = lowers the activation energy [1].$mq$, $mq$C$mq$),
(3, $mq$[[Q 3 | A 6]]
Calcium carbonate reacts with hydrochloric acid: CaCO3 + 2HCl -> CaCl2 + H2O + CO2.
(a) Match each type of reaction to the products. (3 marks)
{{drag|d1|Metal + acid,Metal carbonate + acid,Acid + alkali|salt + hydrogen,salt + water + carbon dioxide,salt + water,metal oxide + water}}
(b) A student reacts 5.0 g of calcium carbonate (Ca = 40, C = 12, O = 16) with excess acid. One mole of gas occupies 24 dm3 at room temperature. Complete the table: relative formula mass of CaCO3, moles of CaCO3 in 5.0 g, and volume of carbon dioxide in dm3. (3 marks)
{{fill|t3|Mr of CaCO3,Moles in 5.0 g,Volume of CO2 (dm3)|1}}

Total for Question 3: 6 marks$mq$, $mq$(a) Interactive answer [d1]: Metal + acid = salt + hydrogen [1]; Metal carbonate + acid = salt + water + carbon dioxide [1]; Acid + alkali = salt + water [1]. Metal oxide + water is a distractor. (b) Interactive answer [t3]: Mr = 40 + 12 + 3 x 16 = 100 [1]; moles = 5.0 / 100 = 0.05 [1]; volume = 0.05 x 24 = 1.2 dm3 [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 3 | D 3]]
The bar chart shows the pH of some common substances.
{{chart|bar|pH of substances|Substance|pH|Lemon juice:2,Vinegar:3,Water:7,Baking soda solution:9,Bleach:13}}
(a) Classify each substance. (3 marks)
{{drag|d4|Vinegar,Water,Bleach|Acidic,Neutral,Alkaline}}
(b) The most acidic substance is {{select|m1|lemon juice|vinegar|bleach}}. (1 mark)
(c) Lemon juice (pH 2) has a hydrogen ion concentration {{select|c1|10 times|100 times|2 times}} greater than vinegar (pH 3). (1 mark)
(d) Suggest why baking soda solution can be used to treat an acid spill. (1 mark)

Total for Question 4: 6 marks$mq$, $mq$(a) Interactive answer [d4]: Vinegar = Acidic [1]; Water = Neutral [1]; Bleach = Alkaline [1]. (b) [m1] = lemon juice [1]. (c) [c1] = 10 times [1] (each pH unit is a factor of 10). (d) It is alkaline (pH 9) so it neutralises the acid, giving a salt and water [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Biology MYP 5 Interactive Practice (4 tasks, 27 marks) (27 marks)
with sub as (select id from public.subjects where slug = $mq$biology$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Biology MYP 5 Interactive Practice (4 tasks, 27 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Biology MYP 5 Interactive Practice (4 tasks, 27 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 3 | B 5]]
A student models cells as cubes to investigate diffusion.
(a) Complete the table for cubes of side 1 cm, 2 cm and 3 cm. Write the side, surface area, volume and surface area to volume ratio (as a single number) in the four columns. (3 marks)
{{fill|t1|Side (cm),Surface area (cm2),Volume (cm3),SA:V ratio|3}}
(b) As the cube gets bigger the surface area to volume ratio {{select|r1|decreases|increases|stays the same}}. (1 mark)
(c) Plot the ratio against the side length. (2 marks)
{{plot|p1|0,4,0,8|Side (cm)|SA:V ratio}}
(d) Use your results to explain why large organisms need a transport system. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) Interactive answer [t1] rows: (1, 6, 1, 6), (2, 24, 8, 3), (3, 54, 27, 2). Surface areas correct [1]; volumes correct [1]; ratios correct [1]. (b) [r1] = decreases [1]. (c) Interactive answer [p1]: plotted (1, 6), (2, 3), (3, 2). Two points correct [1]; all three correct [1]. (d) As size increases the surface area to volume ratio falls so diffusion across the surface is too slow to supply all the cells [1]; a transport system (such as blood) carries oxygen and nutrients to cells deep inside the body [1].$mq$, $mq$B$mq$),
(2, $mq$[[Q 2 | A 2 | B 3 | C 2]]
A student measures the activity of an enzyme at different temperatures.
{{chart|line|Enzyme activity|Temperature (C)|Rate (units)|10:2,20:5,30:9,40:14,50:6,60:0}}
(a) The optimum temperature shown is {{select|o1|20 C|40 C|60 C}}. (1 mark)
(b) Describe and explain the change in rate from 40 C to 60 C. (2 marks)
(c) Match each temperature to the correct description. (3 marks)
{{drag|d2|10 C,40 C,60 C|Little kinetic energy so few collisions,Rate is greatest,Enzyme is denatured,Substrate is used up}}
(d) Calculate the increase in rate from 20 C to 40 C. (1 mark)

Total for Question 2: 7 marks$mq$, $mq$(a) Interactive answer [o1] = 40 C [1]. (b) The rate falls from 14 to 0 [1] because the high temperature changes the shape of the active site (denatures the enzyme) so substrate no longer fits [1]. (c) Interactive answer [d2]: 10 C = Little kinetic energy so few collisions [1]; 40 C = Rate is greatest [1]; 60 C = Enzyme is denatured [1]. Substrate is used up is a distractor. (d) 14 - 5 = 9 units [1].$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | A 6]]
In humans brown eyes (B) are dominant to blue eyes (b). Two parents are both Bb.
(a) Complete the Punnett square. Row 1 is the B gamete and row 2 is the b gamete. Write the gamete in the first column and the offspring genotypes in the next two columns. (3 marks)
{{fill|t3|Gamete,B,b|2}}
(b) The probability that a child has blue eyes is {{select|p1|1/4|1/2|3/4}}. (1 mark)
(c) The couple have 80 children in a large study of similar families. Predict how many have blue eyes. (1 mark)
(d) State the ratio of brown-eyed to blue-eyed children. (1 mark)

Total for Question 3: 6 marks$mq$, $mq$(a) Interactive answer [t3] rows: (B, BB, Bb) and (b, Bb, bb). Gametes B and b in first column [1]; BB and Bb in row 1 [1]; Bb and bb in row 2 [1]. (b) [p1] = 1/4 [1]. (c) 1/4 x 80 = 20 [1]. (d) 3 : 1 [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 2 | D 4]]
A pond is sampled and 200 organisms are counted.
{{chart|pie|Organisms in a pond sample|||Algae:120,Water snails:50,Perch:20,Heron:10}}
(a) Place each organism in its position in the food chain. (4 marks)
{{drag|f1|Producer,Primary consumer,Secondary consumer,Tertiary consumer|Algae,Water snail,Perch,Heron}}
(b) Calculate the percentage of the organisms that are algae. (1 mark)
(c) There are fewer organisms at higher levels because {{select|e1|energy is lost at each level|the herons are bigger and eat more|algae cannot be eaten}}. (1 mark)

Total for Question 4: 6 marks$mq$, $mq$(a) Interactive answer [f1]: Producer = Algae [1]; Primary consumer = Water snail [1]; Secondary consumer = Perch [1]; Tertiary consumer = Heron [1]. (b) 120 / 200 = 60% [1]. (c) Interactive answer [e1] = energy is lost at each level [1] (as heat, movement and waste), so less is available to support organisms higher up.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
