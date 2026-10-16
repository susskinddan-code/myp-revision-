-- 19 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Standard Mathematics MYP 5 Interactive Practice 1 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$standard-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Standard Mathematics MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Standard Mathematics MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$)
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

-- Standard Mathematics MYP 5 Interactive Practice 2 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$standard-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Standard Mathematics MYP 5 Interactive Practice 2 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Standard Mathematics MYP 5 Interactive Practice 2 (4 tasks, 28 marks)$mq$)
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
- The cyclist rides out at a steady speed and at t = 2 is 24 km from home, at the viewpoint.
- The cyclist rests until t = 3.
- The cyclist returns home at a steady speed, arriving at t = 5.
(a) Plot the four points showing the start, the arrival at the viewpoint, the end of the rest and the arrival home. (2 marks)
{{plot|p4|0,6,0,30|t (hours)|d (km)}}
(b) During the rest the graph is {{select|h1|horizontal|the steepest part|a curve}}. (1 mark)
(c) Complete the table for the distance from home. Write t in the first column and d in the second column for t = 1 and t = 4. (2 marks)
{{fill|t4|t (hours),d (km)|2}}
(d) Calculate the average speed on the journey out. (1 mark)
(e) Calculate the average speed for the whole journey including the rest. (1 mark)

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [p4]: plotted (0, 0), (2, 24), (3, 24), (5, 0). Three points correct [1]; all four correct [1]; joining the points is not required. (b) [h1] = horizontal [1]. (c) Interactive answer [t4] rows: (1, 12) [1] and (4, 12) [1]. (Outward speed 24/2 = 12 km/h so at t = 1 the distance is 12 km; return speed 24/2 = 12 km/h so at t = 4 the distance is 24 - 12 = 12 km.) (d) 24/2 = 12 km/h [1]. (e) Total distance 48 km / 5 h = 9.6 km/h [1].$mq$, $mq$D$mq$)
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
(b) Plot the seven points on the grid. (2 marks)
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
{{drag|d1|Two sides and the included angle (find the third side),Two angles and one side (find another side),Three sides (find an angle)|Cosine rule to find a side,Sine rule,Cosine rule to find an angle,Pythagoras theorem}}
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

-- Integrated Science MYP 5 Interactive Practice 1 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$integrated-science$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Integrated Science MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Integrated Science MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 5 | C 2]]
A student heats a solid sample of substance X and records its temperature every minute.
{{chart|line|Heating curve of substance X|Time (min)|Temperature (C)|0:30,1:50,2:70,3:70,4:70,5:90,6:110}}
(a) Match each state of matter to the description of its particles. (3 marks)
{{drag|s1|Solid,Liquid,Gas|Particles vibrate in fixed positions,Particles slide past each other,Particles move freely and are far apart,Particles do not move at all}}
(b) State the melting point of substance X. (1 mark)
(c) Between 2 and 4 minutes the temperature stays constant because the energy supplied is used to {{select|e1|break the forces holding the particles in fixed positions|make the particles move faster|make each particle heavier}}. (1 mark)
(d) Calculate the rate of temperature rise, in C per minute, between 0 and 2 minutes. (2 marks)

Total for Question 1: 7 marks$mq$, $mq$(a) Interactive answer [s1]: Solid = particles vibrate in fixed positions [1]; Liquid = particles slide past each other [1]; Gas = particles move freely and are far apart [1]. 'Particles do not move at all' is a distractor. (b) 70 C [1] (the flat section of the graph). (c) Interactive answer [e1] = break the forces holding the particles in fixed positions [1]. (d) (70 - 30) / 2 [1] = 20 C per minute [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | B 5 | C 2]]
A student investigates how the temperature of water affects the time an antacid tablet takes to dissolve. She repeats each temperature three times.
(a) Place each variable in the correct row of the table. (3 marks)
{{drag|v1|Independent variable,Dependent variable,Controlled variable|Temperature of the water,Time taken for the tablet to dissolve,Volume of water,Colour of the tablet packaging}}
(b) Complete her prediction. As the water gets hotter, the time taken will {{select|h1|increase|decrease|stay the same}} because the particles move {{select|h2|faster and collide more often|more slowly and collide less often}}. (2 marks)
(c) Her results are: 20 C: 62 s, 58 s, 60 s; 40 C: 31 s, 29 s, 30 s; 60 C: 14 s, 16 s, 15 s. Complete the table with the mean time for each temperature. Write the temperature in the first column and the mean time in the second column. (2 marks)
{{fill|r1|Temperature (C),Mean time (s)|3}}

Total for Question 2: 7 marks$mq$, $mq$(a) Interactive answer [v1]: Independent variable = temperature of the water [1]; Dependent variable = time taken for the tablet to dissolve [1]; Controlled variable = volume of water [1]. 'Colour of the tablet packaging' is a distractor. (b) Interactive answer [h1] = decrease [1]; [h2] = faster and collide more often [1]. (c) Interactive answer [r1] rows: (20, 60), (40, 30), (60, 15). (62 + 58 + 60) / 3 = 60; (31 + 29 + 30) / 3 = 30; (14 + 16 + 15) / 3 = 15. Two rows correct [1]; all three rows correct [1].$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | C 5 | A 2]]
A cyclist rides along a straight track. The table shows her distance from the start.
Time (s): 0, 2, 4, 6, 8
Distance (m): 0, 10, 20, 20, 30
(a) Plot the five points on the grid. (2 marks)
{{plot|p1|0,8,0,40|Time (s)|Distance (m)}}
(b) Between 4 s and 6 s the cyclist is {{select|m1|accelerating|stationary|moving at constant speed}}. (1 mark)
(c) Complete the table with her speed in each part of the journey. Use the three rows 0 to 4 s, 4 to 6 s and 6 to 8 s. Write the time interval in the first column and the speed in m/s in the second column. (2 marks)
{{fill|f1|Time interval,Speed (m/s)|3}}
(d) Calculate her average speed for the whole 8 s. (2 marks)

Total for Question 3: 7 marks$mq$, $mq$(a) Interactive answer [p1]: plotted (0, 0), (2, 10), (4, 20), (6, 20), (8, 30). At least three points correct [1]; all five correct [1]; joining the points is not required. (b) Interactive answer [m1] = stationary [1] (distance does not change). (c) Interactive answer [f1] rows: (0 to 4 s, 5), (4 to 6 s, 0), (6 to 8 s, 5). Two rows correct [1]; all three rows correct [1]. (20 / 4 = 5; 0 / 2 = 0; 10 / 2 = 5.) (d) Total distance 30 m divided by 8 s [1] = 3.75 m/s [1].$mq$, $mq$C$mq$),
(4, $mq$[[Q 4 | D 5 | A 2]]
The pie chart shows the electricity generated in one year by a fictional country, Country M. The values are in terawatt-hours (TWh).
{{chart|pie|Electricity generated by Country M (TWh)|||Gas:80,Wind:50,Nuclear:30,Solar:20,Coal:20}}
(a) Complete the table with the percentage of the total generated by gas, wind and nuclear. Write the source in the first column and the percentage in the second column. (3 marks)
{{fill|u1|Source,Percentage|3}}
(b) Gas and coal are {{select|f1|renewable|non-renewable}} energy sources. (1 mark)
(c) Calculate the percentage of the electricity that came from wind and solar together. (2 marks)
(d) Explain one environmental benefit of generating more electricity from wind and solar instead of coal. (1 mark)

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [u1] rows: (Gas, 40), (Wind, 25), (Nuclear, 15). The total is 80 + 50 + 30 + 20 + 20 = 200 TWh. Gas 80 / 200 = 40% [1]; Wind 50 / 200 = 25% [1]; Nuclear 30 / 200 = 15% [1]. (b) Interactive answer [f1] = non-renewable [1]. (c) (50 + 20) / 200 [1] = 35% [1]. (d) Wind and solar release no (or far less) carbon dioxide than burning coal, so they reduce the enhanced greenhouse effect and climate change; accept less air pollution [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Geography MYP 5 Interactive Practice 1 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$geography$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Geography MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Geography MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 5 | C 2]]
The bar chart shows the population of a fictional country, Country P, by age group, in millions.
{{chart|bar|Population of Country P by age group (millions)|Age group|Millions|Aged 0 to 14:10,Aged 15 to 64:30,Aged 65 and over:10}}
(a) Complete the table with the percentage of the total population in each age group. Write the age group in the first column and the percentage in the second column. (3 marks)
{{fill|a1|Age group,Percentage|3}}
(b) The dependency ratio is (young + old) / working-age x 100. Calculate the dependency ratio for Country P. Give your answer to 1 decimal place. (2 marks)
(c) Because 20% of Country P's people are aged 65 and over, it has an {{select|b2|ageing|youthful}} population, so demand will increase for {{select|b3|healthcare|primary schools}}. (2 marks)

Total for Question 1: 7 marks$mq$, $mq$(a) Interactive answer [a1] rows: (Aged 0 to 14, 20), (Aged 15 to 64, 60), (Aged 65 and over, 20). Total 50 million. Each correct row [1] [1] [1]. (b) (10 + 10) / 30 x 100 [1] = 66.7 [1]. (c) Interactive answer [b2] = ageing [1]; [b3] = healthcare [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | B 5 | C 2]]
A class measures a river at five sites downstream from its source. The widths are: 2 km: 3 m; 4 km: 6 m; 6 km: 8 m; 8 km: 12 m; 10 km: 15 m.
(a) Plot the five widths on the grid, with distance from the source on the horizontal axis. (2 marks)
{{plot|w1|0,12,0,20|Distance from source (km)|Width (m)}}
(b) Match each measurement to the most suitable fieldwork method. (3 marks)
{{drag|m1|River width,River depth,River velocity|Tape measure across the channel,Ruler placed at set points across the channel,Timing a float over a measured distance,Thermometer placed in the water}}
(c) At one site a float travels 10 m in 8 s. Calculate the velocity of the river in m/s. (2 marks)

Total for Question 2: 7 marks$mq$, $mq$(a) Interactive answer [w1]: plotted (2, 3), (4, 6), (6, 8), (8, 12), (10, 15). At least three points correct [1]; all five correct [1]. (b) Interactive answer [m1]: River width = tape measure across the channel [1]; River depth = ruler placed at set points across the channel [1]; River velocity = timing a float over a measured distance [1]. The thermometer is a distractor. (c) 10 / 8 [1] = 1.25 m/s [1] (unit required).$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | A 5 | C 2]]
The line graph shows the mean monthly temperature at Station K, which is in the northern hemisphere.
{{chart|line|Mean monthly temperature at Station K (C)|Month|Temperature (C)|Jan:4,Feb:5,Mar:8,Apr:11,May:15,Jun:18,Jul:21,Aug:20,Sep:17,Oct:12,Nov:7,Dec:5}}
(a) Calculate the annual temperature range. (1 mark)
(b) The hottest month is {{select|c1|June|July|August}}. (1 mark)
(c) Calculate the mean annual temperature, correct to 1 decimal place. (2 marks)
(d) Explain why temperatures at Station K are higher in July than in January. (2 marks)
(e) The annual temperature range near the equator is usually {{select|c3|smaller|larger}} than at Station K. (1 mark)

Total for Question 3: 7 marks$mq$, $mq$(a) 21 - 4 = 17 C [1]. (b) Interactive answer [c1] = July [1]. (c) Sum of the twelve monthly values = 143 [1]; 143 / 12 = 11.9 C [1]. (d) In July the northern hemisphere is tilted towards the Sun [1], so the Sun is higher in the sky and days are longer, giving more energy per unit area [1]. (e) Interactive answer [c3] = smaller [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | D 5 | A 2]]
The pie chart shows the employment of workers in a fictional country, Country Q, in percent.
{{chart|pie|Employment in Country Q (percent)|||Agriculture:45,Industry:20,Services:35}}
(a) Rural-urban migration is common in Country Q. Place one factor in each row of the table. (2 marks)
{{drag|u1|Push factor from the countryside,Pull factor of the city|Farms are too small to support families,More jobs in factories and services,Cities have no hospitals}}
(b) Calculate the percentage of workers who do not work in agriculture. (1 mark)
(c) A high share of workers in agriculture is typical of a {{select|d1|lower income|higher income}} country. (1 mark)
(d) Explain one environmental problem that rapid growth of cities can cause and suggest one way a city planner could reduce it. (3 marks)

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [u1]: Push factor = farms are too small to support families [1]; Pull factor = more jobs in factories and services [1]. 'Cities have no hospitals' is a distractor. (b) 100 - 45 = 55% [1]. (c) Interactive answer [d1] = lower income [1]. (d) Identifies a problem such as air pollution, waste, loss of green space or pressure on water supply [1]; explains how city growth causes it, for example more vehicles and factories or more people producing waste [1]; suggests a valid solution such as public transport, recycling schemes or protecting green belts [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Economics MYP 5 Interactive Practice 1 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$economics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Economics MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Economics MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 5 | C 2]]
The market for a type of notebook has a demand rule Qd = 10 - P and a supply rule Qs = P - 2, where P is the price in GBP and Q is the quantity in thousands of notebooks.
(a) Complete the table for prices of 2, 4, 6 and 8 GBP. Write price, quantity demanded and quantity supplied in the three columns. (2 marks)
{{fill|m1|Price (GBP),Quantity demanded,Quantity supplied|4}}
(b) Plot the four demand points on the grid, with quantity on the horizontal axis and price on the vertical axis. (2 marks)
{{plot|d1|0,10,0,10|Quantity (thousands)|Price (GBP)}}
(c) The equilibrium price is {{select|e1|4|6|8}} GBP. (1 mark)
(d) At a price of 8 GBP there is {{select|e2|excess supply|excess demand}}. Calculate its size, in thousands of notebooks. (2 marks)

Total for Question 1: 7 marks$mq$, $mq$(a) Interactive answer [m1] rows: (2, 8, 0), (4, 6, 2), (6, 4, 4), (8, 2, 6). Two rows correct [1]; all four correct [1]. (b) Interactive answer [d1]: plotted (8, 2), (6, 4), (4, 6), (2, 8) as (quantity, price). At least three points correct [1]; all four correct [1]. (c) Interactive answer [e1] = 6 [1] (10 - P = P - 2 gives P = 6 and Q = 4). (d) Interactive answer [e2] = excess supply [1]; quantity supplied 6 minus quantity demanded 2 = 4 thousand notebooks [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | B 5 | C 2]]
The bar chart shows the annual inflation rate in a fictional country, Country R.
{{chart|bar|Annual inflation rate in Country R (percent)|Year|Percent|Year 1:2,Year 2:3,Year 3:6,Year 4:4,Year 5:2,Year 6:1}}
(a) The year with the highest inflation was {{select|i1|Year 2|Year 3|Year 4}}. (1 mark)
(b) Calculate the mean inflation rate over the six years. (2 marks)
(c) At the start of Year 3 a bag of rice cost 50 GBP. Calculate its price after the Year 3 inflation rate is applied. (1 mark)
(d) Match each term to its meaning. (2 marks)
{{drag|t1|Inflation,Deflation|A general rise in prices over time,A general fall in prices over time,A rise in unemployment}}
(e) Between Year 3 and Year 5 the inflation rate {{select|i2|rose|fell}}, but prices {{select|i3|still rose|fell}} overall. (1 mark)

Total for Question 2: 7 marks$mq$, $mq$(a) Interactive answer [i1] = Year 3 [1]. (b) (2 + 3 + 6 + 4 + 2 + 1) = 18 [1]; 18 / 6 = 3% [1]. (c) 50 x 1.06 = 53 GBP [1]. (d) Interactive answer [t1]: Inflation = a general rise in prices over time [1]; Deflation = a general fall in prices over time [1]. 'A rise in unemployment' is a distractor. (e) Interactive answers [i2] = fell and [i3] = still rose, both correct [1] (inflation of 2% in Year 5 is still positive, so prices are still rising).$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | C 5 | D 2]]
The pie chart shows how a fictional government plans to spend 200 billion GBP.
{{chart|pie|Government spending (billion GBP)|||Health:60,Education:50,Defence:30,Transport:20,Other:40}}
(a) Complete the table with the percentage of total spending on health, education and defence. Write the area in the first column and the percentage in the second column. (2 marks)
{{fill|g1|Area,Percentage|3}}
(b) If the government spends more on transport, one opportunity cost could be {{select|o1|less money available for health or education|more tax revenue|lower unemployment}}. (1 mark)
(c) The government increases transport spending from 20 billion GBP to 30 billion GBP. Calculate the percentage increase. (2 marks)
(d) Explain why governments cannot spend unlimited amounts on every area. (2 marks)

Total for Question 3: 7 marks$mq$, $mq$(a) Interactive answer [g1] rows: (Health, 30), (Education, 25), (Defence, 15). Two rows correct [1]; all three correct [1]. (b) Interactive answer [o1] = less money available for health or education [1]. (c) (30 - 20) / 20 x 100 [1] = 50% [1]. (d) Resources and tax revenue are limited (scarcity) [1]; spending more in one area means choosing to spend less in another, so choices must be made (opportunity cost) [1].$mq$, $mq$C$mq$),
(4, $mq$[[Q 4 | D 5 | B 2]]
The unemployment rate in a fictional country over six years was: Year 1: 5%, Year 2: 6%, Year 3: 8%, Year 4: 7%, Year 5: 5%, Year 6: 4%.
(a) Plot the six unemployment rates on the grid. (2 marks)
{{plot|u1|0,7,0,10|Year|Unemployment rate (percent)}}
(b) Match each type of unemployment to its cause. (3 marks)
{{drag|k1|Frictional unemployment,Structural unemployment,Cyclical unemployment|Workers are between jobs,A factory closes because machines replace workers,Total demand falls in a recession,Workers choose not to look for work}}
(c) Calculate the fall in the unemployment rate, in percentage points, from Year 3 to Year 6. (1 mark)
(d) Suggest one government policy to reduce structural unemployment. (1 mark)

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [u1]: plotted (1, 5), (2, 6), (3, 8), (4, 7), (5, 5), (6, 4). At least four points correct [1]; all six correct [1]. (b) Interactive answer [k1]: Frictional = workers are between jobs [1]; Structural = a factory closes because machines replace workers [1]; Cyclical = total demand falls in a recession [1]. 'Workers choose not to look for work' is a distractor. (c) 8 - 4 = 4 percentage points [1]. (d) A valid policy such as funding retraining programmes or education for new skills, or helping workers move to where jobs are [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- History MYP 5 Interactive Practice 1 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$history$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$History MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$History MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 5 | C 2]]
This task is about the causes of the First World War.
(a) Match each date to the event that happened on it. (4 marks)
{{drag|d1|28 June 1914,4 August 1914,11 November 1918,28 June 1919|Archduke Franz Ferdinand is assassinated in Sarajevo,Britain declares war on Germany,The armistice ends the fighting on the Western Front,The Treaty of Versailles is signed,The Tsar of Russia abdicates}}
(b) The assassination in Sarajevo was the {{select|t1|long-term cause|trigger|consequence}} of the war. (1 mark)
(c) State two long-term causes of the war. (2 marks)

Total for Question 1: 7 marks$mq$, $mq$(a) Interactive answer [d1]: 28 June 1914 = Archduke Franz Ferdinand is assassinated in Sarajevo [1]; 4 August 1914 = Britain declares war on Germany [1]; 11 November 1918 = the armistice ends the fighting on the Western Front [1]; 28 June 1919 = the Treaty of Versailles is signed [1]. 'The Tsar of Russia abdicates' is a distractor (it happened in 1917). (b) Interactive answer [t1] = trigger [1]. (c) Any two of: the alliance system, militarism and the arms race, imperial rivalry, nationalism [1] [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 4 | C 3]]
This task is about the Treaty of Versailles of 1919.
(a) Match each theme to the term of the treaty. (3 marks)
{{drag|v1|War guilt,Army,Territory|Germany accepted responsibility for causing the war,The German army was limited to 100 000 men,Alsace-Lorraine was returned to France,Germany became a member of the League of Nations in 1920}}
(b) The League of Nations was created to {{select|l1|keep peace between countries|collect taxes|run schools}}. (1 mark)
(c) Explain why many Germans resented the treaty. (3 marks)

Total for Question 2: 7 marks$mq$, $mq$(a) Interactive answer [v1]: War guilt = Germany accepted responsibility for causing the war [1]; Army = the German army was limited to 100 000 men [1]; Territory = Alsace-Lorraine was returned to France [1]. The League of Nations item is a distractor (Germany joined later, in 1926). (b) Interactive answer [l1] = keep peace between countries [1]. (c) Identifies a term Germans resented such as the war guilt clause, limits on the army, loss of territory or reparations [1]; develops with detail or an example [1]; explains the link to resentment, for example that Germany was not allowed to negotiate so the treaty was seen as dictated and humiliating [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 5 | C 2]]
The chart shows how many years after 1914 each event happened.
{{chart|bar|Years after 1914 that each event happened|Event|Years|Russian Revolution:3,USA enters the war:3,Armistice:4,Treaty of Versailles:5,League first meets:6}}
(a) Plot the five events from the chart as points on the grid, with the years after 1914 on the horizontal axis and the event number on the vertical axis (1 = Russian Revolution, 2 = USA enters the war, 3 = Armistice, 4 = Treaty of Versailles, 5 = League first meets). (1 mark)
{{plot|y1|0,8,0,6|Years after 1914|Event number}}
(b) Add 1914 to the number of years shown to complete the table. Write the event in the first column and the year in the second column for the Armistice, the Treaty of Versailles and the first meeting of the League of Nations. (3 marks)
{{fill|y2|Event,Year|3}}
(c) Explain why the entry of the USA into the war mattered to the Allies. (3 marks)

Total for Question 3: 7 marks$mq$, $mq$(a) Interactive answer [y1]: plotted (3, 1), (3, 2), (4, 3), (5, 4), (6, 5); all five correct [1] (the Russian Revolution and the USA entering the war both fall 3 years after 1914, which is 1917). (b) Interactive answer [y2] rows: (Armistice, 1918) [1]; (Treaty of Versailles, 1919) [1]; (League of Nations first meets, 1920) [1]. (c) Allied armies and economies were tired after years of fighting [1]; the USA brought fresh troops and supplies [1]; this shifted the balance of resources against Germany and helped lead to the armistice in 1918 [1].$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | D 5 | C 2]]
A student states: 'The assassination in Sarajevo was the only cause of the First World War.'
(a) Choose the statement that best matches the view of most historians. The assassination was {{select|j1|the only cause|one of several causes}} of the war. (1 mark)
(b) Evaluate the student's statement. Use at least three factors in your answer and reach a supported judgement. (6 marks)

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [j1] = one of several causes [1]. (b) Award marks for: the assassination on 28 June 1914 as the immediate trigger [1]; the alliance system pulling other powers into the conflict [1]; militarism or the arms race [1]; nationalism or imperial rivalry [1]; an explicit judgement that long-term tensions made the trigger so serious [1]; a justified conclusion, for example that without these tensions the assassination might have stayed a local crisis [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Environmental Systems MYP 5 Interactive Practice 1 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$environmental-systems$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Environmental Systems MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Environmental Systems MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 5 | C 2]]
A meadow food chain is grass, grasshopper, frog and snake. The chart shows the energy available at each trophic level.
{{chart|bar|Energy at each trophic level (kJ)|Trophic level|Energy (kJ)|Producer:10000,Primary consumer:1000,Secondary consumer:100,Tertiary consumer:10}}
(a) Match each organism to its trophic level. (2 marks)
{{drag|e1|Producer,Primary consumer,Secondary consumer,Tertiary consumer|Grass,Grasshopper,Frog,Snake,Fungus}}
(b) Calculate the percentage of energy transferred from the primary consumers to the secondary consumers and state what the chart shows about the other transfers. (2 marks)
(c) Most of the energy lost between levels is released as {{select|l1|heat from respiration|light|sound}}. (1 mark)
(d) Explain why food chains rarely have more than five trophic levels. (2 marks)

Total for Question 1: 7 marks$mq$, $mq$(a) Interactive answer [e1]: Producer = grass; Primary consumer = grasshopper; Secondary consumer = frog; Tertiary consumer = snake. Three correct [1]; all four correct [1]. Fungus is a distractor (a decomposer). (b) 100 / 1000 x 100 = 10% [1]; the other transfers are also 10% (1000 / 10000 and 10 / 100) [1]. (c) Interactive answer [l1] = heat from respiration [1]. (d) Only about 10% of energy passes to the next level, so energy decreases at each level [1]; by the fifth level too little energy remains to support another group of consumers [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | C 5 | D 2]]
The line graph shows carbon dioxide at a fictional monitoring site, Station M. The data are invented for practice.
{{chart|line|Carbon dioxide at Station M (ppm)|Year|Carbon dioxide (ppm)|Year 1:380,Year 2:382,Year 3:384,Year 4:386,Year 5:388}}
(a) Assume the trend continues. Complete the table to predict Years 6 and 7. Write the year number in the first column and the carbon dioxide in ppm in the second column. (2 marks)
{{fill|c1|Year,Carbon dioxide (ppm)|2}}
(b) Calculate the mean increase in carbon dioxide per year between Year 1 and Year 5. (2 marks)
(c) Match each process to its effect on carbon dioxide. (3 marks)
{{drag|k1|Photosynthesis,Respiration,Combustion|Carbon dioxide is taken from the air to make glucose,Carbon dioxide is released by living cells releasing energy,Carbon dioxide is released when fuels burn,Carbon dioxide is converted into oxygen by animals}}

Total for Question 2: 7 marks$mq$, $mq$(a) Interactive answer [c1] rows: (6, 390) [1]; (7, 392) [1]. (b) (388 - 380) / 4 [1] = 2 ppm per year [1]. (c) Interactive answer [k1]: Photosynthesis = carbon dioxide is taken from the air to make glucose [1]; Respiration = carbon dioxide is released by living cells releasing energy [1]; Combustion = carbon dioxide is released when fuels burn [1]. 'Carbon dioxide is converted into oxygen by animals' is a distractor.$mq$, $mq$C$mq$),
(3, $mq$[[Q 3 | B 5 | C 2]]
A student estimates the number of daisies in a field of area 400 m2. She places ten 1 m2 quadrats at random positions and counts the daisies in each: 3, 5, 4, 6, 2, 4, 3, 5, 4, 4.
(a) Calculate the mean number of daisies per quadrat. (1 mark)
(b) Estimate the total number of daisies in the field. (2 marks)
(c) Plot the frequency of each count on the grid, with the number of daisies per quadrat on the horizontal axis. (2 marks)
{{plot|q1|0,8,0,6|Daisies per quadrat|Frequency}}
(d) To make the estimate more reliable the student should use {{select|q2|more quadrats placed randomly|one quadrat in the best patch|quadrats only at the edge of the field}}. (1 mark)
(e) State one reason the estimate may differ from the true number of daisies. (1 mark)

Total for Question 3: 7 marks$mq$, $mq$(a) 40 / 10 = 4 daisies per quadrat [1]. (b) 4 x 400 [1] = 1600 daisies [1]. (c) Interactive answer [q1]: plotted (2, 1), (3, 2), (4, 4), (5, 2), (6, 1). At least three points correct [1]; all five correct [1]. (d) Interactive answer [q2] = more quadrats placed randomly [1]. (e) Daisies may not be spread evenly, or the sample of ten quadrats is small, so it may not represent the whole field [1].$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | D 5 | A 2]]
The pie chart shows the household waste of a fictional town, in tonnes per month.
{{chart|pie|Household waste by type (tonnes per month)|||Food:175,Paper:100,Plastic:75,Glass:50,Other:100}}
(a) Match each type of waste to a suitable way of managing it. (3 marks)
{{drag|w1|Food waste,Glass,Paper|Compost or anaerobic digestion,Collect and melt to make new glass containers,Pulp and recycle into new paper products,Bury in landfill}}
(b) Paper, plastic and glass can be recycled. Calculate the tonnes of recyclable waste per month and the percentage of the total waste this represents. (2 marks)
(c) Landfill sites can cause pollution because rotting waste produces {{select|w2|methane gas and a polluted liquid called leachate|ozone and acid rain only}}. (1 mark)
(d) Suggest one action the town council could take to reduce the waste sent to landfill. (1 mark)

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [w1]: Food waste = compost or anaerobic digestion [1]; Glass = collect and melt to make new glass containers [1]; Paper = pulp and recycle into new paper products [1]. 'Bury in landfill' is a distractor. (b) 100 + 75 + 50 = 225 tonnes [1]; 225 / 500 x 100 = 45% [1]. (c) Interactive answer [w2] = methane gas and a polluted liquid called leachate [1]. (d) A valid action such as kerbside recycling collections, food waste collection for composting, or a charge for non-recycled waste [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- English Language and Literature MYP 5 Interactive Practice 1 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$english-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$English Language and Literature MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$English Language and Literature MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 7]]
Read Text 1, an extract from a newspaper opinion column, and answer the questions.

Text 1: "The Pavement Is Empty"
Every morning at ten past eight, the street outside my window turns into a car park. Engines idle. Horns complain. Parents lean on steering wheels and stare at the bumper in front, convinced that the traffic is somebody else's fault. Last Tuesday, I counted forty-two cars carrying forty-two children who live less than a kilometre from the school gate. Forty-two! Meanwhile, the pavement stood empty, as if it had been abandoned. According to the council, only one in five pupils at our school now walks. I am not saying that the school run is a crime. I am saying that we have quietly swapped fresh air, conversation and independence for a warm seat and a closed door. Surely a short walk is a small price to pay?

(a) This text is best described as {{select|e1a|a newspaper opinion column|a set of instructions|a formal scientific report}}. (1 mark)
(b) Complete the table. Identify three techniques the writer uses, choose a short quotation for each and explain its effect on the reader. (3 marks)
{{fill|e1b|Technique,Quotation,Effect on the reader|3}}
(c) The writer's tone is mainly {{select|e1c|critical but reasonable|angry and insulting|neutral and detached}}. (1 mark)
(d) Explain how the final question, "Surely a short walk is a small price to pay?", helps the writer achieve the purpose of the column. (2 marks)

Total for Question 1: 7 marks$mq$, $mq$(a) Interactive answer [e1a] = a newspaper opinion column [1]. (b) Interactive answer [e1b]: award 1 mark per row for a correctly named technique, an accurate quotation from the text and a plausible effect on the reader (all three elements are needed for the mark) [1] [1] [1]. Acceptable examples: personification, "Horns complain" (makes the traffic seem noisy and irritating); statistic, "only one in five pupils at our school now walks" (gives factual weight and shows the problem is real); metaphor, "turns into a car park" (an exaggerated image of congestion); short sentences, "Engines idle." (quick, sharp rhythm that creates a sense of impatience); exclamation and repetition, "Forty-two!" (shows the writer's shock and invites the reader to share it); contrast, "the pavement stood empty" (highlights what has been lost). (c) Interactive answer [e1c] = critical but reasonable [1]; the writer says "I am not saying that the school run is a crime". (d) Identifies that it is a rhetorical question [1]; explains that it invites the reader to agree, makes the walk seem easy and cheap and leaves the reader with the writer's view, so it supports the aim of persuading parents [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 7]]
Read Text 2, a poem, and answer the questions.

Text 2: "The Bakery at Four"
At four, the town is still a locked door,
but the bakery window glows like a coin.
Flour hangs in the air like slow snow;
the ovens breathe and the whole street yawns.
My uncle's hands, strong and scarred and certain,
fold the dough as if it were a letter.
Nobody sees this. Nobody thanks him.
By six, the queue is a river of coats,
and loaves leave in paper wings, warm,
while he wipes his hands and watches the light
arrive, late and ordinary,
at the door he had opened for it.

(a) Match each quotation to the technique it shows. (3 marks)
{{drag|e2a|the ovens breathe and the whole street yawns,the queue is a river of coats,Nobody sees this. Nobody thanks him.|personification,metaphor,repetition,onomatopoeia,rhyme}}
(b) The poem mainly celebrates {{select|e2b|quiet, unnoticed hard work|the excitement of a holiday|the dangers of early mornings}}. (1 mark)
(c) Explain how the poet makes the reader admire the uncle in the final three lines. (3 marks)

Total for Question 2: 7 marks$mq$, $mq$(a) Interactive answer [e2a]: "the ovens breathe and the whole street yawns" = personification [1]; "the queue is a river of coats" = metaphor [1]; "Nobody sees this. Nobody thanks him." = repetition [1]. Onomatopoeia and rhyme are distractors. (b) Interactive answer [e2b] = quiet, unnoticed hard work [1]. (c) Award up to 3 marks for developed comment on the final three lines: the light is "late and ordinary", which contrasts with the uncle's early and extraordinary effort, so he seems dedicated [1]; "the door he had opened for it" suggests he prepares the day for everyone else, a quiet generosity [1]; the calm, unhurried sentence (the long run-on line with no strong stop) mirrors his patience and gives the poem a gentle, respectful ending, or the image of him wiping his hands and simply watching shows modest pride without any need for thanks [1]. Accept other well-supported readings that use the text.$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 5 | A 2]]
Study Text 3, an advert, and the chart that follows it.

Text 3
GROW SOMETHING GREAT!
Hartley Community Garden: Open Day, Saturday 14 June, 10 am to 4 pm
Dig. Plant. Share.
- Free seedlings for every visitor
- Cake stall and live music
- Workshops for under-16s at 11 am
Come and get your hands dirty. Your neighbourhood is waiting.

The chart shows the results of a survey of 100 visitors at last year's Open Day. Each visitor gave one main reason for coming.
{{chart|pie|Main reason for visiting last year|Reason|Share of visitors|To meet neighbours:40,To learn gardening skills:30,Family activities:20,Free plants:10}}

(a) The slogan "Dig. Plant. Share." uses {{select|e3a|a list of three short imperatives|a rhetorical question|a statistic}}. (1 mark)
(b) Match each feature of the advert's layout and language to its purpose. (3 marks)
{{drag|e3b|Heading in capitals with an exclamation mark,Bulleted list of offers,Imperative verbs such as "Come and get your hands dirty"|Grabs attention immediately,Presents the benefits quickly and clearly,Gives the reader a direct call to action,Provides detailed scientific evidence,Shows the writer's personal memories}}
(c) According to the pie chart, the most common reason for visiting was {{select|e3c|to meet neighbours|to learn gardening skills|to get free plants}}. (1 mark)
(d) Use one result from the pie chart to suggest an extra line for the advert. Explain how it would persuade the target audience. (2 marks)

Total for Question 3: 7 marks$mq$, $mq$(a) Interactive answer [e3a] = a list of three short imperatives [1]. (b) Interactive answer [e3b]: heading in capitals with an exclamation mark = grabs attention immediately [1]; bulleted list of offers = presents the benefits quickly and clearly [1]; imperative verbs = gives the reader a direct call to action [1]. "Provides detailed scientific evidence" and "Shows the writer's personal memories" are distractors. (c) Interactive answer [e3c] = to meet neighbours [1]; it is the largest share at 40 percent. (d) A suitable extra line that uses a chart result, for example "Join the 40 percent who came last year just to meet their neighbours" [1]; a link to audience and purpose, for example that it shows the event is friendly and popular and so appeals to local people who want community and belonging, and that the statistic adds credibility [1]. Layout and structure awareness should be shown: the added line should fit the advert's short, punchy style.$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | A 1 | C 3 | D 3]]
Read Text 4, the opening of a short story.

Text 4
By the time Maya reached the allotment, the sky had turned the colour of an old bruise. She pushed the rusty gate with her shoulder; it groaned like a tired animal. Somebody had been here. The soil by the bean rows was freshly turned, and in the middle of it, half-buried, lay a small tin box.

(a) The story is told in {{select|e4a|the third person|the first person|the second person}}. (1 mark)
(b) Each sentence below contains one error of grammar. Match each sentence to its correct version. (3 marks)
{{drag|e4b|Their was nobody else in the garden.,She could of run away.,The box were locked.|There was nobody else in the garden.,She could have run away.,The box was locked.,The boxes was locked.}}
(c) Write the next four or five sentences of the story. Keep to the past tense and use at least one simile or metaphor. (3 marks)

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [e4a] = the third person [1]. (b) Interactive answer [e4b]: "Their was nobody else in the garden." = "There was nobody else in the garden." [1]; "She could of run away." = "She could have run away." [1]; "The box were locked." = "The box was locked." [1]. "The boxes was locked." is a distractor that is also incorrect. (c) Ideas and content: continues logically from the extract (for example opening the box or hearing someone approach) and develops the mystery [1]; style: at least one effective simile or metaphor and some sensory detail that suits the tense, atmospheric tone [1]; organisation and control: a clear sequence of four or five sentences, consistent past tense and a consistent narrative voice [1].$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

-- French Language and Literature MYP 5 Interactive Practice 1 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$french-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French Language and Literature MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French Language and Literature MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 7]]
Lis le texte 1, un extrait de billet de blog, puis réponds aux questions.

Texte 1 : « Mon téléphone dort dans la cuisine »
Depuis septembre, mon téléphone dort dans la cuisine. Chaque soir à vingt et une heures, je l'éteins et je le pose près de la bouilloire, loin de ma chambre. Au début, c'était difficile : j'avais l'impression de rater quelque chose d'important. Pourtant, après trois semaines, je dors mieux, je lis davantage et mes amis ne m'ont pas oublié ! Selon une enquête de mon collège, 70 % des élèves dorment avec leur portable à côté du lit. Est-ce vraiment nécessaire ? Je ne prétends pas que la technologie est mauvaise ; je dis simplement qu'elle ne devrait pas décider de nos nuits. Alors, et si vous essayiez, vous aussi, cette semaine ?

(a) Ce texte est surtout {{select|f1a|un billet de blog personnel|un règlement intérieur|un article scientifique}}. (1 mark)
(b) Complète le tableau : relève trois procédés d'écriture, cite un court passage pour chacun et explique son effet sur le lecteur. (3 marks)
{{fill|f1b|Procédé,Citation,Effet sur le lecteur|3}}
(c) Le ton de l'auteur est surtout {{select|f1c|personnel et persuasif|violent et agressif|froid et administratif}}. (1 mark)
(d) Explique l'effet de la dernière phrase, « Alors, et si vous essayiez, vous aussi, cette semaine ? », sur le lecteur. (2 marks)

Total for Question 1: 7 marks$mq$, $mq$Answers may be given in French or English; accept any accurate wording. (a) Interactive answer [f1a] = un billet de blog personnel [1]. (b) Interactive answer [f1b]: award 1 mark per row for a correctly named technique, an accurate quotation from the text and a plausible effect on the reader (all three elements are needed for the mark) [1] [1] [1]. Acceptable examples: question rhétorique, « Est-ce vraiment nécessaire ? » (pousse le lecteur à réfléchir à sa propre habitude); statistique, « 70 % des élèves » (donne du poids et de la crédibilité); anecdote à la première personne, « mon téléphone dort dans la cuisine » (rend le texte proche et sincère); personnification du téléphone qui « dort » (ton léger et amusant); point d'exclamation, « mes amis ne m'ont pas oublié ! » (humour et soulagement); adresse au lecteur, « vous » (implique le lecteur); contraste, « difficile » puis « Pourtant » (montre un changement positif). (c) Interactive answer [f1c] = personnel et persuasif [1]. (d) Identifie une question rhétorique ou une invitation directe adressée au lecteur avec « vous » [1]; explique qu'elle l'encourage à agir et à essayer l'expérience, ce qui correspond à l'intention persuasive du blog et laisse une impression positive [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 7]]
Lis le texte 2, un poème, puis réponds aux questions.

Texte 2 : « Marée basse »
La mer s'est retirée sans dire au revoir,
laissant sur le sable des coquilles fatiguées.
Le vent, lui, chuchote des histoires du soir
que personne n'écoute sur la plage oubliée.
Mon père y marchait, un seau dans la main,
riant des vagues comme on rit d'un vieil ami.
Aujourd'hui je marche seul, et le chemin
est long, froid et vide, sans lui.

(a) Associe chaque passage au procédé qu'il illustre. (3 marks)
{{drag|f2a|des coquilles fatiguées,comme on rit d'un vieil ami,Aujourd'hui je marche seul|une personnification,une comparaison,un contraste entre passé et présent,une hyperbole,une onomatopée}}
(b) Dans les deux derniers vers, le poète passe du souvenir à {{select|f2b|la solitude du présent|la colère contre la mer|l'humour}}. (1 mark)
(c) Explique comment le poète fait sentir l'absence du père. (3 marks)

Total for Question 2: 7 marks$mq$, $mq$Answers may be given in French or English. (a) Interactive answer [f2a]: « des coquilles fatiguées » = une personnification [1]; « comme on rit d'un vieil ami » = une comparaison [1]; « Aujourd'hui je marche seul » = un contraste entre passé et présent [1]. Une hyperbole et une onomatopée sont des distracteurs. (b) Interactive answer [f2b] = la solitude du présent [1]. (c) Up to 3 marks for developed comment using the text: la mer qui part « sans dire au revoir » peut évoquer le départ du père, la nature semble partager la perte [1]; le contraste entre « Mon père y marchait » (imparfait, souvenir joyeux) et « je marche seul » (présent) montre ce qui a disparu [1]; les adjectifs « long, froid et vide » et le dernier mot « sans lui » mettent l'absence en valeur par l'accumulation et par la chute finale du poème [1]. Accept other well-supported readings.$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 5 | A 2]]
Étudie le texte 3, une affiche, et le diagramme qui la suit.

Texte 3
CDI DU COLLÈGE : OUVERT JUSQU'À 18 HEURES !
Ouvre un livre, et le monde s'ouvre à toi.
✔ Prêt gratuit pour tous les élèves
✔ Espace calme pour travailler
✔ Club de lecture tous les jeudis à 12 h 30
Viens nous voir : le CDI t'attend !

Le diagramme présente les résultats d'une enquête auprès de 100 élèves (plusieurs réponses possibles).
{{chart|bar|Raisons de venir au CDI|Raison|Nombre d'élèves|Travailler:42,Emprunter des livres:35,Utiliser les ordinateurs:28,Se reposer:15}}

(a) Dans le slogan, le verbe « ouvrir » est {{select|f3a|répété|remplacé par un synonyme|remplacé par son contraire}}. (1 mark)
(b) Associe chaque élément de l'affiche à sa fonction. (3 marks)
{{drag|f3b|Titre en majuscules avec point d'exclamation,Liste avec des coches,Impératif et tutoiement|Attire l'attention immédiatement,Présente les services de façon claire et rapide,S'adresse directement au lecteur,Donne des preuves scientifiques détaillées,Raconte les souvenirs de l'auteur}}
(c) D'après le diagramme, la raison la plus fréquente de venir au CDI est {{select|f3c|travailler|se reposer|utiliser les ordinateurs}}. (1 mark)
(d) Propose une phrase à ajouter sur l'affiche à partir d'un résultat de l'enquête et explique pourquoi elle convaincrait les élèves. (2 marks)

Total for Question 3: 7 marks$mq$, $mq$Answers may be given in French or English. (a) Interactive answer [f3a] = répété [1]. (b) Interactive answer [f3b]: titre en majuscules avec point d'exclamation = attire l'attention immédiatement [1]; liste avec des coches = présente les services de façon claire et rapide [1]; impératif et tutoiement = s'adresse directement au lecteur [1]. « Donne des preuves scientifiques détaillées » et « Raconte les souvenirs de l'auteur » sont des distracteurs. (c) Interactive answer [f3c] = travailler [1]; c'est la barre la plus haute, 42 élèves. (d) Une phrase pertinente qui utilise un résultat, par exemple « 35 élèves sur 100 viennent déjà emprunter des livres : et toi ? » [1]; un lien avec le public et l'intention, par exemple que le chiffre montre que beaucoup d'élèves font déjà ce choix, ce qui rassure et donne envie de les imiter, dans un style court et direct comme l'affiche [1].$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | A 1 | C 3 | D 3]]
Lis le texte 4, le début d'un récit.

Texte 4
Il pleuvait depuis le matin quand Léa est arrivée à la gare. Elle serrait contre elle une vieille valise et regardait l'horloge : le train de dix-sept heures avait déjà du retard. Sur le quai, personne ne parlait. Soudain, une voix a crié son nom derrière elle.

(a) Le récit est écrit à {{select|f4a|la troisième personne|la première personne|la deuxième personne}}. (1 mark)
(b) Chaque phrase ci-dessous contient une erreur de grammaire. Associe chaque phrase à sa version correcte. (3 marks)
{{drag|f4b|Léa est arrivé à la gare.,Elle regardais l'horloge.,Il pleuvaient depuis le matin.|Léa est arrivée à la gare.,Elle regardait l'horloge.,Il pleuvait depuis le matin.,Elle regardera l'horloge.}}
(c) Écris la suite du récit en quatre ou cinq phrases. Utilise le passé composé et l'imparfait, et inclus une description. (3 marks)

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [f4a] = la troisième personne [1]. (b) Interactive answer [f4b]: « Léa est arrivé à la gare. » = « Léa est arrivée à la gare. » (accord du participe passé avec le sujet féminin) [1]; « Elle regardais l'horloge. » = « Elle regardait l'horloge. » (accord du verbe avec « elle ») [1]; « Il pleuvaient depuis le matin. » = « Il pleuvait depuis le matin. » (verbe impersonnel, toujours au singulier) [1]. « Elle regardera l'horloge. » est un distracteur au mauvais temps. (c) Ideas and content: continues logically from the extract (for example Léa se retourne et reconnaît la personne) and develops the situation [1]; style: a real description with sensory detail or an effective image that suits the atmosphere [1]; organisation and control: four or five sentences in a clear order that use passé composé for events and imparfait for description appropriately [1]. Do not penalise isolated spelling slips here as language accuracy is credited in (b).$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

-- Spanish Language and Literature MYP 5 Interactive Practice 1 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish Language and Literature MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish Language and Literature MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 7]]
Lee el texto 1, un fragmento de una columna de opinión, y contesta a las preguntas.

Texto 1: «Perdidos sin mapa»
Hace una semana me quedé sin batería en mitad de una ciudad desconocida. Sin mapa, sin llamadas, sin nada. Al principio sentí pánico: el corazón me latía como un tambor y las calles parecían laberintos. Después, sin embargo, ocurrió algo curioso. Pregunté a una señora cómo llegar a la plaza y ella, sonriendo, me acompañó dos manzanas y me contó la historia de su barrio. Según una encuesta reciente, el 68 % de los jóvenes no sabría volver a casa sin el teléfono. ¿De verdad queremos depender tanto de una pantalla? No propongo tirar los móviles; propongo, simplemente, perdernos de vez en cuando. Quizá así descubramos que el mejor mapa son las personas.

(a) Este texto es sobre todo {{select|s1a|una columna de opinión personal|un manual de instrucciones|un informe científico}}. (1 mark)
(b) Completa la tabla: identifica tres recursos que usa el autor, copia una cita breve de cada uno y explica su efecto en el lector. (3 marks)
{{fill|s1b|Recurso,Cita,Efecto en el lector|3}}
(c) El tono del autor es sobre todo {{select|s1c|reflexivo y persuasivo|agresivo y ofensivo|frío y técnico}}. (1 mark)
(d) Explica el efecto de la última frase, «Quizá así descubramos que el mejor mapa son las personas», en el lector. (2 marks)

Total for Question 1: 7 marks$mq$, $mq$Answers may be given in Spanish or English; accept any accurate wording. (a) Interactive answer [s1a] = una columna de opinión personal [1]. (b) Interactive answer [s1b]: award 1 mark per row for a correctly named device, an accurate quotation from the text and a plausible effect on the reader (all three elements are needed for the mark) [1] [1] [1]. Acceptable examples: símil, «el corazón me latía como un tambor» (hace sentir el pánico de forma intensa); metáfora, «el mejor mapa son las personas» (da una idea nueva y memorable); pregunta retórica, «¿De verdad queremos depender tanto de una pantalla?» (invita a reflexionar); estadística, «el 68 % de los jóvenes» (aporta credibilidad); anécdota en primera persona (acerca el texto al lector); frases cortas, «Sin mapa, sin llamadas, sin nada» (crean sensación de vacío y urgencia); contraste, «Al principio» y «Después, sin embargo» (muestra un cambio positivo). (c) Interactive answer [s1c] = reflexivo y persuasivo [1]. (d) Identifies a metaphor or a closing reflection that sums up the message [1]; explains that it leaves the reader with a positive, memorable idea that people matter more than screens, which supports the persuasive purpose [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 7]]
Lee el texto 2, un poema, y contesta a las preguntas.

Texto 2: «La casa vacía»
La casa guarda silencio como un cofre cerrado,
y la luz cansada se sienta junto al balcón.
Mi abuela ya no canta en el pasillo dorado,
pero su voz aún huele a pan y a canción.

Las sillas esperan, quietas, a que alguien vuelva,
y el reloj cuenta horas que nadie oye ya.
Yo cruzo la sala despacio, sin que nada se mueva,
temiendo despertar lo que aquí aún está.

(a) Relaciona cada cita con el recurso literario que muestra. (3 marks)
{{drag|s2a|como un cofre cerrado,la luz cansada se sienta junto al balcón,su voz aún huele a pan y a canción|un símil,una personificación,una sinestesia,una hipérbole,una ironía}}
(b) El ambiente del poema es sobre todo {{select|s2b|nostálgico y silencioso|alegre y ruidoso|cómico y burlón}}. (1 mark)
(c) Explica cómo el poema muestra la ausencia de la abuela en la segunda estrofa. (3 marks)

Total for Question 2: 7 marks$mq$, $mq$Answers may be given in Spanish or English. (a) Interactive answer [s2a]: «como un cofre cerrado» = un símil [1]; «la luz cansada se sienta junto al balcón» = una personificación [1]; «su voz aún huele a pan y a canción» = una sinestesia [1]. Una hipérbole y una ironía son distractores. (b) Interactive answer [s2b] = nostálgico y silencioso [1]. (c) Up to 3 marks for developed comment on the second stanza: las sillas «esperan» a que alguien vuelva, es decir, la casa parece esperar a la abuela (personificación de objetos) [1]; el reloj cuenta horas «que nadie oye», lo que muestra un tiempo vacío, sin la presencia de ella [1]; la hablante cruza la sala «sin que nada se mueva» y teme «despertar lo que aquí aún está», lo que sugiere que el recuerdo de la abuela sigue presente y es frágil, con un ritmo lento que refuerza el respeto y la tristeza [1]. Accept other well-supported readings.$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 5 | A 2]]
Estudia el texto 3, un cartel, y el gráfico que lo sigue.

Texto 3
¡PEDALEA HASTA EL COLE!
Semana de la bicicleta: del 12 al 16 de mayo
Cada pedalada cuenta: menos humo, más sonrisas.
✔ Aparcamiento gratuito para bicicletas
✔ Desayuno saludable para quien llegue en bici
✔ Casco de regalo para los veinte primeros
Apúntate en secretaría. ¡Te esperamos!

El gráfico muestra los resultados de una encuesta a 100 alumnos del colegio.
{{chart|bar|Cómo llega el alumnado al colegio|Medio de transporte|Número de alumnos|En coche:38,A pie:27,En autobús:25,En bicicleta:10}}

(a) La frase «¡Pedalea hasta el cole!» usa {{select|s3a|un imperativo|una pregunta retórica|un dato estadístico}}. (1 mark)
(b) Relaciona cada elemento del cartel con su función. (3 marks)
{{drag|s3b|Título en mayúsculas con signos de exclamación,Lista con casillas marcadas,Verbos como «Apúntate» en imperativo|Llama la atención desde el primer momento,Presenta las ventajas de forma clara y rápida,Invita directamente al lector a actuar,Ofrece pruebas científicas detalladas,Cuenta los recuerdos personales del autor}}
(c) Según el gráfico, el medio de transporte más habitual es {{select|s3c|el coche|la bicicleta|el autobús}}. (1 mark)
(d) Usa un dato del gráfico para proponer una frase nueva para el cartel y explica por qué convencería al alumnado. (2 marks)

Total for Question 3: 7 marks$mq$, $mq$Answers may be given in Spanish or English. (a) Interactive answer [s3a] = un imperativo [1]. (b) Interactive answer [s3b]: título en mayúsculas con signos de exclamación = llama la atención desde el primer momento [1]; lista con casillas marcadas = presenta las ventajas de forma clara y rápida [1]; verbos en imperativo = invita directamente al lector a actuar [1]. «Ofrece pruebas científicas detalladas» y «Cuenta los recuerdos personales del autor» son distractores. (c) Interactive answer [s3c] = el coche [1]; es la barra más alta, 38 alumnos. (d) Una frase adecuada que use un dato, por ejemplo «Solo 10 de cada 100 alumnos vienen en bici: ¡sé uno de ellos!» [1]; un vínculo con el público y la intención, por ejemplo que el dato muestra que hay mucho margen para cambiar y reta al alumnado a participar, en un estilo breve y directo como el del cartel [1].$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | A 1 | C 3 | D 3]]
Lee el texto 4, el comienzo de un relato.

Texto 4
Llovía desde la mañana cuando Marta llegó al puerto. Apretaba contra su pecho una maleta vieja y miraba el reloj: el barco de las cinco ya llevaba retraso. En el muelle nadie hablaba. De pronto, una voz gritó su nombre a sus espaldas.

(a) El narrador cuenta la historia en {{select|s4a|tercera persona|primera persona|segunda persona}}. (1 mark)
(b) Cada frase siguiente contiene un error. Relaciona cada frase con su versión correcta. (3 marks)
{{drag|s4b|Marta llego al puerto.,Apretaba una maleta viejo.,Nadie hablaban en el muelle.|Marta llegó al puerto.,Apretaba una maleta vieja.,Nadie hablaba en el muelle.,Nadie hablarán en el muelle.}}
(c) Escribe la continuación del relato en cuatro o cinco frases. Usa el pretérito indefinido y el imperfecto, e incluye una descripción. (3 marks)

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [s4a] = tercera persona [1]. (b) Interactive answer [s4b]: «Marta llego al puerto.» = «Marta llegó al puerto.» (falta la tilde del pretérito indefinido) [1]; «Apretaba una maleta viejo.» = «Apretaba una maleta vieja.» (concordancia de género con «maleta») [1]; «Nadie hablaban en el muelle.» = «Nadie hablaba en el muelle.» («nadie» lleva el verbo en singular) [1]. «Nadie hablarán en el muelle.» es un distractor con el tiempo y el número incorrectos. (c) Ideas and content: continues logically from the extract (for example Marta se vuelve y reconoce a la persona) and develops the situation [1]; style: a real description with sensory detail or an effective image that suits the atmosphere [1]; organisation and control: four or five sentences in a clear order that use the pretérito indefinido for events and the imperfecto for description appropriately [1]. Do not penalise isolated spelling slips here as language accuracy is credited in (b).$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

-- French ab initio MYP 5 Interactive Practice 1 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$french-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French ab initio MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French ab initio MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | B 7]]
Tâche 1 : Lire un message (Task 1: reading a message). Lis le message de Léa (Read Léa's message), puis réponds (then answer).

Salut Tom !
Samedi, c'est mon anniversaire : j'ai quatorze ans ! Je fais une fête chez moi à quatre heures. J'habite au 12, rue des Fleurs, près du parc. Mon frère Lucas prépare un gâteau au chocolat. Tu peux venir ? Apporte ta guitare, s'il te plaît !
À bientôt,
Léa

Choisis la bonne réponse (Choose the correct answer).
(a) La fête est {{select|a1|vendredi|samedi|dimanche}}. (1 mark)
(b) La fête commence à {{select|a2|trois heures|quatre heures|cinq heures}}. (1 mark)
(c) Léa habite {{select|a3|près du parc|près de l'école|près du cinéma}}. (1 mark)
(d) Qui prépare le gâteau ? {{select|a4|Lucas|Tom|Léa}} (1 mark)
(e) « Léa a quinze ans. » Vrai ou faux ? {{select|a5|Vrai|Faux}} (1 mark)
(f) What does Léa ask Tom to bring? Answer in English. (1 mark)
(g) Find the French word in the message that means "party". Write it. (1 mark)

Total for Question 1: 7 marks$mq$, $mq$(a) Interactive answer [a1] = samedi [1]. (b) [a2] = quatre heures [1]. (c) [a3] = près du parc [1]. (d) [a4] = Lucas [1]. (e) [a5] = Faux [1] (Léa is fourteen: quatorze ans). (f) His guitar [1]. (g) fête [1] (accept 'une fête' or 'la fête'; do not accept 'anniversaire', which means birthday).$mq$, $mq$B$mq$),
(2, $mq$[[Q 2 | B 5 | C 2]]
Tâche 2 : Un sondage (Task 2: a survey). Dans la classe de 3B, on pose la question : « Quel est ton passe-temps préféré ? » (In class 3B the question is: What is your favourite pastime?)

{{chart|bar|Le passe-temps préféré des élèves de 3B|Passe-temps|Nombre d'élèves|les jeux vidéo:11,le foot:9,le cinéma:7,la musique:6,la lecture:4}}

(a) Complète le tableau (Complete the table). Écris le passe-temps dans la première colonne et le nombre d'élèves dans la deuxième colonne, pour les trois passe-temps les plus populaires, du plus populaire au moins populaire. (3 marks)
{{fill|h1|Passe-temps,Nombre d'élèves|3}}
(b) Le passe-temps le moins populaire est {{select|h2|la lecture|la musique|le cinéma}}. (1 mark)
(c) Six élèves préfèrent {{select|h3|la musique|le foot|la lecture}}. (1 mark)
(d) Écris une phrase en français : quel est ton passe-temps préféré ? (Write one sentence in French about your favourite pastime.) Par exemple : « J'aime nager. » (2 marks)

Total for Question 2: 7 marks$mq$, $mq$(a) Interactive answer [h1] rows in order: (les jeux vidéo, 11), (le foot, 9), (le cinéma, 7). Accept the hobby with or without its article, 'football' for 'le foot', and 'jeux vidéo' or 'jeux video'. One mark for each correct row [1] [1] [1]. (b) Interactive answer [h2] = la lecture [1] (4 students). (c) [h3] = la musique [1] (6 students). (d) A clear sentence about a pastime, with a subject and verb or a structure such as 'Mon passe-temps préféré, c'est ...' [1]; correct spelling, article or verb form for the hobby chosen, for example 'J'aime le tennis' or 'Je joue au tennis' [1]. Accept any real hobby; do not reward a copy of the example alone.$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | B 3 | C 4]]
Tâche 3 : Les mots et la grammaire (Task 3: words and grammar).

(a) Associe chaque mot français à son sens en anglais (Match each French word to its English meaning). Un sens en anglais est en trop (One English meaning is not needed). (3 marks)
{{drag|m1|le fromage,la pomme,le pain|cheese,apple,bread,meat}}

(b) Complète les phrases avec la bonne forme (Complete the sentences with the correct form). (4 marks)
1. Je {{select|g1|mange|manges|mangent}} un sandwich.
2. Nous {{select|g2|buvons|boit|boivent}} de l'eau.
3. Ma sœur {{select|g3|est|ai|a}} douze ans.
4. Tu veux {{select|g4|un|une|des}} salade ?

Total for Question 3: 7 marks$mq$, $mq$(a) Interactive answer [m1]: le fromage = cheese [1]; la pomme = apple [1]; le pain = bread [1]. 'meat' is a distractor. (b) Interactive answers [g1] = mange [1] (je takes the -e form); [g2] = buvons [1] (nous form of boire); [g3] = a [1] (avoir is used for age: elle a douze ans); [g4] = une [1] (salade is feminine).$mq$, $mq$C$mq$),
(4, $mq$[[Q 4 | C 7]]
Tâche 4 : Écrire un message (Task 4: writing a message). Tu réponds au message de Léa de la Tâche 1 (You are replying to Léa's message from Task 1).

(a) Choisis la bonne formule pour commencer ton message (Choose the correct way to begin your message). {{select|w1|Chère Léa|Cher Léa|Chers Léa}} (1 mark)

(b) Écris ta réponse en français, environ 30 à 40 mots (Write your reply in French, about 30 to 40 words). Dans ton message : (6 marks)
- remercie Léa pour l'invitation (thank Léa for the invitation) ;
- dis si tu peux venir samedi (say if you can come on Saturday) ;
- dis ce que tu apportes (say what you will bring) ;
- pose une question à Léa (ask Léa a question).

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [w1] = Chère Léa [1] (Léa is a girl, so the adjective is feminine singular). (b) Communication of the four points: thanks, whether you can come, what you bring, a question to Léa: all four clear [2]; two or three clear earns 1 mark instead. Vocabulary: appropriate words for the topic (for example merci, venir, apporter, gâteau, cadeau, quand, où) used correctly [1]. Language accuracy: verb forms and agreements are mostly correct in simple sentences (for example je peux venir, j'apporte) [2]; some correct forms with frequent errors earns 1 mark instead. Spelling, accents, capital letters, punctuation and a closing formula such as 'À bientôt' [1]. Maximum 6 marks for part (b). If the reply is under 15 words, award no more than 3 marks in total for part (b).$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

-- Spanish ab initio MYP 5 Interactive Practice 1 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish ab initio MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish ab initio MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | B 7]]
Tarea 1: Leer un horario (Task 1: reading a timetable). Lee el horario y la nota de Clara (Read Clara's timetable and note), y contesta (and answer).

Horario de Clara (martes)
8:30 Matemáticas
9:30 Inglés
10:30 Recreo
11:00 Ciencias
12:00 Educación física
13:00 Comida en la cafetería
14:00 Arte

Nota de Clara: Mi asignatura favorita es el arte porque la profesora es muy simpática. No me gustan las ciencias porque son difíciles.

Elige la respuesta correcta (Choose the correct answer).
(a) La primera clase es {{select|a1|matemáticas|inglés|arte}}. (1 mark)
(b) El recreo es a las {{select|a2|nueve y media|diez y media|once}}. (1 mark)
(c) Clara come a {{select|a3|la una|las dos|las tres}}. (1 mark)
(d) Educación física es a las {{select|a4|doce|dos|ocho y media}}. (1 mark)
(e) « Las ciencias son fáciles. » ¿Verdadero o falso? {{select|a5|Verdadero|Falso}} (1 mark)
(f) What is Clara's favourite subject, and why? Answer in English. (2 marks)

Total for Question 1: 7 marks$mq$, $mq$(a) Interactive answer [a1] = matemáticas [1]. (b) [a2] = diez y media [1] (10:30). (c) [a3] = la una [1] (13:00). (d) [a4] = doce [1]. (e) [a5] = Falso [1] (Clara says they are difficult). (f) Art [1]; because the teacher is very nice / friendly [1].$mq$, $mq$B$mq$),
(2, $mq$[[Q 2 | B 5 | C 2]]
Tarea 2: Una encuesta (Task 2: a survey). En la clase de 3B se pregunta: « ¿Cuál es tu pasatiempo favorito? » (In class 3B the question is: What is your favourite pastime?)

{{chart|bar|El pasatiempo favorito de los alumnos de 3B|Pasatiempo|Número de alumnos|el fútbol:10,los videojuegos:8,la música:7,el cine:5,la lectura:3}}

(a) Completa la tabla (Complete the table). Escribe el pasatiempo en la primera columna y el número de alumnos en la segunda columna, para los tres pasatiempos más populares, del más popular al menos popular. (3 marks)
{{fill|h1|Pasatiempo,Número de alumnos|3}}
(b) El pasatiempo menos popular es {{select|h2|la lectura|el cine|la música}}. (1 mark)
(c) Siete alumnos prefieren {{select|h3|los videojuegos|la música|el cine}}. (1 mark)
(d) Escribe una frase en español: ¿cuál es tu pasatiempo favorito? (Write one sentence in Spanish about your favourite pastime.) Por ejemplo: « Me gusta nadar. » (2 marks)

Total for Question 2: 7 marks$mq$, $mq$(a) Interactive answer [h1] rows in order: (el fútbol, 10), (los videojuegos, 8), (la música, 7). Accept the hobby with or without its article, 'futbol' without the accent, and 'videojuegos'. One mark for each correct row [1] [1] [1]. (b) Interactive answer [h2] = la lectura [1] (3 students). (c) [h3] = la música [1] (7 students). (d) A clear sentence about a pastime with a verb or structure such as 'Me gusta ...' or 'Mi pasatiempo favorito es ...' [1]; correct spelling, article or verb form for the hobby chosen, for example 'Me gusta el tenis' or 'Juego al tenis' [1]. Accept any real hobby; do not reward a copy of the example alone.$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | B 3 | C 4]]
Tarea 3: Las palabras y la gramática (Task 3: words and grammar).

(a) Relaciona cada lugar con su significado en inglés (Match each place to its English meaning). Un significado en inglés sobra (One English meaning is not needed). (3 marks)
{{drag|m1|la biblioteca,el mercado,la estación|library,market,station,hospital}}

(b) Completa las frases con la forma correcta (Complete the sentences with the correct form). (4 marks)
1. Yo {{select|g1|como|comes|comen}} un bocadillo.
2. Nosotros {{select|g2|bebemos|bebe|beben}} agua.
3. Mi hermana {{select|g3|es|tiene|tienes}} doce años.
4. ¿Quieres {{select|g4|un|una|unos}} ensalada?

Total for Question 3: 7 marks$mq$, $mq$(a) Interactive answer [m1]: la biblioteca = library [1]; el mercado = market [1]; la estación = station [1]. 'hospital' is a distractor. (b) Interactive answers [g1] = como [1] (yo form of comer); [g2] = bebemos [1] (nosotros form of beber); [g3] = tiene [1] (tener is used for age: tiene doce años); [g4] = una [1] (ensalada is feminine).$mq$, $mq$C$mq$),
(4, $mq$[[Q 4 | C 7]]
Tarea 4: Escribir un correo (Task 4: writing an email). Pablo, un chico español, te escribe (Pablo, a Spanish boy, writes to you).

« Hola. Soy Pablo y vivo en Madrid. ¿Cómo es tu colegio? ¿Cuál es tu asignatura favorita? ¿Qué haces los fines de semana? Un saludo, Pablo »

(a) Elige la forma correcta para empezar tu respuesta (Choose the correct way to begin your reply). {{select|w1|Querido Pablo|Querida Pablo|Queridos Pablo}} (1 mark)

(b) Escribe tu respuesta en español, unas 30 a 40 palabras (Write your reply in Spanish, about 30 to 40 words). En tu correo: (6 marks)
- describe tu colegio (describe your school);
- di cuál es tu asignatura favorita (say your favourite subject);
- di qué haces los fines de semana (say what you do at weekends);
- haz una pregunta a Pablo (ask Pablo a question).

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [w1] = Querido Pablo [1] (Pablo is male, so the adjective is masculine singular). (b) Communication of the four points: school, favourite subject, weekend activities, a question to Pablo: all four clear [2]; two or three clear earns 1 mark instead. Vocabulary: appropriate words for the topic (for example colegio, grande, asignatura, me gusta, los sábados, ¿y tú?) used correctly [1]. Language accuracy: verb forms and agreements are mostly correct in simple sentences (for example mi colegio es grande, juego al fútbol) [2]; some correct forms with frequent errors earns 1 mark instead. Spelling, accents, inverted question marks, capital letters and a closing formula such as 'Un saludo' [1]. Maximum 6 marks for part (b). If the reply is under 15 words, award no more than 3 marks in total for part (b).$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

-- Mandarin ab initio MYP 5 Interactive Practice 1 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$mandarin-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Mandarin ab initio MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Mandarin ab initio MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | B 7]]
任务一：看菜单 (Rènwù yī: kàn càidān) Task 1: reading a menu. 请看菜单，然后回答问题 (Qǐng kàn càidān, ránhòu huídá wèntí). Read the menu, then answer.

菜单 (Càidān)
炒饭 (chǎofàn) 十二块 (shí'èr kuài)
面条 (miàntiáo) 十块 (shí kuài)
饺子 (jiǎozi) 十五块 (shíwǔ kuài)
茶 (chá) 三块 (sān kuài)
水 (shuǐ) 一块 (yí kuài)

小明想吃饺子，也想喝茶。(Xiǎo Míng xiǎng chī jiǎozi, yě xiǎng hē chá.)

请选择 (Qǐng xuǎnzé) Choose the correct answer.
(a) 面条 (miàntiáo) 多少钱 (duōshao qián)? {{select|a1|十块 shí kuài|十二块 shí'èr kuài|十五块 shíwǔ kuài}} (1 mark)
(b) 水 (shuǐ) 多少钱? {{select|a2|一块 yí kuài|三块 sān kuài|十块 shí kuài}} (1 mark)
(c) 小明一共要付多少钱 (Xiǎo Míng yígòng yào fù duōshao qián)? How much will Xiǎo Míng pay in total? {{select|a3|十五块 shíwǔ kuài|十八块 shíbā kuài|二十块 èrshí kuài}} (1 mark)
(d) 炒饭十五块。(Chǎofàn shíwǔ kuài.) {{select|a4|对 duì|不对 búduì}} (1 mark)
(e) 菜单上最便宜的东西是 (Càidān shàng zuì piányi de dōngxi shì) the cheapest item on the menu is: {{select|a5|茶 chá|水 shuǐ|面条 miàntiáo}} (1 mark)
(f) Write the Chinese word for "dumplings" from the menu. Characters or pinyin with tone marks. (1 mark)
(g) How much is the tea? Answer in English. (1 mark)

Total for Question 1: 7 marks$mq$, $mq$(a) Interactive answer [a1] = 十块 shí kuài [1]. (b) [a2] = 一块 yí kuài [1]. (c) [a3] = 十八块 shíbā kuài [1] (饺子 15 + 茶 3 = 18). (d) [a4] = 不对 búduì [1] (炒饭 is 12 kuai). (e) [a5] = 水 shuǐ [1] (1 kuai). (f) 饺子 or jiǎozi [1] (accept jiaozi without tone marks). (g) 3 kuai / 3 yuan [1].$mq$, $mq$B$mq$),
(2, $mq$[[Q 2 | B 5 | C 2]]
任务二：调查 (Rènwù èr: diàochá) Task 2: a survey. 三班的同学回答：“你最喜欢做什么？” (Sān bān de tóngxué huídá: "Nǐ zuì xǐhuan zuò shénme?") Class 3's students answer: What do you like doing best?

爱好 (àihào) hobbies: 踢足球 (tī zúqiú), 玩游戏 (wán yóuxì), 听音乐 (tīng yīnyuè), 看电影 (kàn diànyǐng), 看书 (kàn shū)

{{chart|bar|三班同学最喜欢的爱好|爱好|人数|踢足球:10,玩游戏:8,听音乐:7,看电影:5,看书:3}}

(a) Complete the table. Write the hobby (characters, or pinyin with tone marks) in the first column and the number of students (digits) in the second column, for the three most popular hobbies, from most to least popular. (3 marks)
{{fill|h1|爱好,人数|3}}
(b) 哪个爱好的人数最少 (Nǎge àihào de rénshù zuì shǎo)? Which hobby has the fewest students? {{select|h2|看书 kàn shū|看电影 kàn diànyǐng|听音乐 tīng yīnyuè}} (1 mark)
(c) 七个同学喜欢 (Qī ge tóngxué xǐhuan) seven students like: {{select|h3|玩游戏 wán yóuxì|听音乐 tīng yīnyuè|看电影 kàn diànyǐng}} (1 mark)
(d) 请写一个句子 (Qǐng xiě yí ge jùzi): write one sentence in Chinese about your own hobby, for example 我喜欢游泳。(Wǒ xǐhuan yóuyǒng.) Characters are best; add pinyin with tone marks if you are unsure. (2 marks)

Total for Question 2: 7 marks$mq$, $mq$(a) Interactive answer [h1] rows in order: (踢足球, 10), (玩游戏, 8), (听音乐, 7). Accept the hobby in characters or in pinyin with tone marks (tī zúqiú, wán yóuxì, tīng yīnyuè); do not penalise a missing tone mark. One mark for each correct row [1] [1] [1]. (b) Interactive answer [h2] = 看书 kàn shū [1] (3 students). (c) [h3] = 听音乐 tīng yīnyuè [1] (7 students). (d) A clear sentence about a hobby with a subject and a verb such as 我喜欢 (wǒ xǐhuan) or 我爱 (wǒ ài) [1]; correct characters or pinyin and word order for the hobby chosen, for example 我喜欢打篮球 [1]. Accept any real hobby; do not reward a copy of the example alone.$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | B 3 | C 4]]
任务三：词语和语法 (Rènwù sān: cíyǔ hé yǔfǎ) Task 3: words and grammar.

(a) 请连线 (Qǐng liánxiàn) Match each place to its English meaning. One English meaning is not needed. (3 marks)
{{drag|m1|图书馆 túshūguǎn,商店 shāngdiàn,火车站 huǒchēzhàn|library,shop,railway station,hospital}}

(b) 请选择正确的词 (Qǐng xuǎnzé zhèngquè de cí) Choose the correct word. (4 marks)
1. 我 {{select|g1|喝|吃|看}} 水。(Wǒ ___ shuǐ.)
2. 我有两 {{select|g2|本|只|杯}} 书。(Wǒ yǒu liǎng ___ shū.)
3. 我们 {{select|g3|坐|吃|喝}} 公共汽车去学校。(Wǒmen ___ gōnggòng qìchē qù xuéxiào.)
4. 我 {{select|g4|不|没|别}} 喜欢鱼。(Wǒ ___ xǐhuan yú.)

Total for Question 3: 7 marks$mq$, $mq$(a) Interactive answer [m1]: 图书馆 túshūguǎn = library [1]; 商店 shāngdiàn = shop [1]; 火车站 huǒchēzhàn = railway station [1]. 'hospital' is a distractor. (b) Interactive answers [g1] = 喝 [1] (hē, drink water); [g2] = 本 [1] (běn, the measure word for books); [g3] = 坐 [1] (zuò, take a bus); [g4] = 不 [1] (bù, the usual negative before 喜欢).$mq$, $mq$C$mq$),
(4, $mq$[[Q 4 | C 7]]
任务四：写短信 (Rènwù sì: xiě duǎnxìn) Task 4: writing a short message. 中国朋友小丽给你写信 (Zhōngguó péngyou Xiǎolì gěi nǐ xiě xìn). Your Chinese friend Xiǎolì writes to you.

“你好！我叫小丽，我十四岁，我住在上海。你叫什么名字？你喜欢做什么？”
(“Nǐ hǎo! Wǒ jiào Xiǎolì, wǒ shísì suì, wǒ zhù zài Shànghǎi. Nǐ jiào shénme míngzi? Nǐ xǐhuan zuò shénme?”)

(a) 回信的开头应该写 (Huíxìn de kāitóu yīnggāi xiě) The best way to begin your reply is: {{select|w1|你好 Nǐ hǎo|再见 zàijiàn|谢谢 xièxie}} (1 mark)

(b) Write your reply in Chinese, about 30 to 40 characters. Use characters if you can; add pinyin with tone marks if you are unsure. In your message: (6 marks)
- say hello and say your name (你叫什么名字？);
- say how old you are;
- say what you like doing;
- ask Xiǎolì a question.

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [w1] = 你好 Nǐ hǎo [1] (a greeting to begin a message). (b) Communication of the four points: name, age, what you like doing, a question to Xiǎolì: all four clear [2]; two or three clear earns 1 mark instead. Vocabulary: appropriate words for the topic (for example 我叫, 岁, 喜欢, 你呢, 你住在哪儿) used correctly [1]. Language accuracy: simple sentences with correct word order and measure words, for example 我十三岁, 我喜欢踢足球 [2]; some correct sentences with frequent errors earns 1 mark instead. Characters or pinyin are recognisable, with tone marks where pinyin is used, and sensible punctuation [1]. Maximum 6 marks for part (b). Accept pinyin with tone marks for any word the student cannot write in characters. If the reply is under 15 characters, award no more than 3 marks in total for part (b).$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

-- Interdisciplinary Learning MYP 5 Interactive Practice 1 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$interdisciplinary-learning$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Interdisciplinary Learning MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Interdisciplinary Learning MYP 5 Interactive Practice 1 (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 7]]
THEME: Selmer Bay, a coast under pressure (Sciences and Individuals and societies)
Selmer Bay is a fictional village of 900 people on a cliff of clay and sand. The bar chart shows how far the cliff edge moved back each year. At the start of 2024 the coast road is 24 m from the cliff edge.
{{chart|bar|Cliff retreat at Selmer Bay (m per year)|Year|Retreat (m)|2019:0.8,2020:1.1,2021:1.0,2022:1.6,2023:1.5}}
(a) Calculate the mean retreat per year from 2019 to 2023. (2 marks)
(b) Assume the mean retreat continues. Plot the distance from the cliff edge to the road at 0, 5, 10, 15 and 20 years after the start of 2024. (2 marks)
{{plot|p1|0,20,0,24|Years after start of 2024|Distance to road (m)}}
(c) The two fastest years, 2022 and 2023, followed winters with many storms. Use ideas about waves and about clay to explain why storms speed up cliff retreat. (2 marks)
(d) At the mean rate the road is reached after {{select|a1|15|20|25}} years. (1 mark)

Total for Question 1: 7 marks$mq$, $mq$(a) Sum 0.8 + 1.1 + 1.0 + 1.6 + 1.5 = 6.0 [1]; 6.0 / 5 = 1.2 m per year [1]. (b) Interactive answer [p1]: points (0, 24), (5, 18), (10, 12), (15, 6), (20, 0) (distance falls 6 m every 5 years). At least three points correct [1]; all five correct [1]. (c) Storm waves are higher and carry more energy, so they erode the cliff base faster (hydraulic action, abrasion) and undercut the cliff so the top collapses [1]. Heavy rain fills the spaces between clay particles, which adds weight and makes the clay weaker and slippery, so it slumps [1]. (d) Interactive answer [a1] = 20 (24 / 1.2) [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 7]]
The council gathered different kinds of evidence. (a) For each statement choose the subject group that mainly supplies that idea or evidence. (4 marks)
1. Waves with more energy remove more material from the cliff base: {{select|s1|Sciences|Individuals and societies}}
2. Many residents are over 65 and could not afford to move if their homes were lost: {{select|s2|Sciences|Individuals and societies}}
3. Wet clay becomes heavy and weak, so it slumps: {{select|s3|Sciences|Individuals and societies}}
4. Residents disagree about whether the council or homeowners should pay for defences: {{select|s4|Sciences|Individuals and societies}}
(b) Match each stakeholder to the concern they are most likely to raise about building defences. (3 marks)
{{drag|m1|Cliff-top homeowner,Harbour boat owner,Nature reserve warden|Fear of losing a home before compensation is agreed,Silting of the harbour mouth if sand movement is blocked,Loss of nesting sites on the cliff face and beach,Cheaper bus fares to town}}

Total for Question 2: 7 marks$mq$, $mq$(a) Interactive answers: [s1] = Sciences [1]; [s2] = Individuals and societies [1]; [s3] = Sciences [1]; [s4] = Individuals and societies [1]. (b) Interactive answer [m1]: Cliff-top homeowner = fear of losing a home before compensation is agreed [1]; Harbour boat owner = silting of the harbour mouth if sand movement is blocked [1]; Nature reserve warden = loss of nesting sites on the cliff face and beach [1]. 'Cheaper bus fares to town' is a distractor.$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 3 | B 4]]
The council can protect the 600 m of cliff with one of three options.
Rock armour: large boulders at the cliff base absorb wave energy. Cost 2 400 000 pounds; lasts 40 years.
Beach nourishment: pumped sand makes a wider beach that absorbs waves, but waves carry the sand away, so it is repeated every 3 years. Cost 450 000 pounds each time.
Timber groynes: wooden barriers across the beach trap sand moving along the shore (longshore drift). Cost 900 000 pounds; last 30 years. Beaches further along the coast then receive less sand and may erode faster.
(a) Complete the table with the cost per year of each option, in pounds. (3 marks)
{{fill|f1|Option,Cost per year (pounds)|3}}
(b) Recommend one option. Justify it using one scientific idea AND one idea about people or money. (4 marks)

Total for Question 3: 7 marks$mq$, $mq$(a) Interactive answer [f1] rows: (Rock armour, 60 000), (Beach nourishment, 150 000), (Timber groynes, 30 000). Working: 2 400 000 / 40; 450 000 / 3; 900 000 / 30. Each correct row [1] [1] [1]. (b) Any option is acceptable if the reasoning is sound. Accurate scientific idea, for example boulders absorb wave energy, sand absorbs energy but is moved away, or groynes trap sediment carried by longshore drift [1]; links that idea to stopping cliff retreat or to a side effect [1]; accurate idea about people or money, for example cost per year, who pays, homes protected, or neighbours downdrift [1]; combines both into a decision that weighs one drawback [1].$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | D 5 | C 2]]
(a) Measurements of cliff retreat alone cannot tell the council which option to choose because {{select|d1|they cannot show whose losses matter most|they are always inaccurate|waves cannot be measured}}. (1 mark)
(b) Explain one limit of planning the defences using only the views of residents. (2 marks)
(c) Describe one thing you understood better by combining Sciences and Individuals and societies than by using either one alone. (2 marks)
(d) Write a notice of no more than 40 words for villagers that states the option you recommend and one reason, in clear plain language. (2 marks)

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [d1] = they cannot show whose losses matter most [1]. (b) Residents' views cannot show how fast the cliff retreats or how well a defence will work [1]; views may be shaped by self-interest or limited information, so they need measurements to test them [1]. (c) A specific gain, for example the retreat data showed when the road is at risk while the stakeholder views showed who would be hurt and what would be accepted [1]; explains how the two together gave a better understanding than either alone [1]. (d) Names the recommended option and gives one reason [1]; plain, clear, within about 40 words and suitable for villagers [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Interdisciplinary Learning MYP 5 Interactive Practice 2 (4 tasks, 28 marks) (28 marks)
with sub as (select id from public.subjects where slug = $mq$interdisciplinary-learning$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Interdisciplinary Learning MYP 5 Interactive Practice 2 (4 tasks, 28 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Interdisciplinary Learning MYP 5 Interactive Practice 2 (4 tasks, 28 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 7]]
THEME: Harlow Park School energy audit (Mathematics and Design)
Harlow Park is a fictional school. A student team measured the electricity used in one typical week. The pie chart shows kWh used by each area.
{{chart|pie|Electricity used in one week (kWh)|||Lighting:400,Computers:240,Kitchen:320,Heating pumps:480,Other:160}}
(a) Calculate the total electricity used in the week, in kWh. (1 mark)
(b) Complete the table with the percentage of the total used by each area. (3 marks)
{{fill|t1|Area,Percentage|3}}
Fill in the rows for Lighting, Computers and Kitchen.
(c) New LED lights would cut lighting use by 50%. Calculate the weekly saving and the new weekly total. (2 marks)
(d) The area with the largest share of use is {{select|b1|Heating pumps|Lighting|Kitchen}}. (1 mark)

Total for Question 1: 7 marks$mq$, $mq$(a) 400 + 240 + 320 + 480 + 160 = 1600 kWh [1]. (b) Interactive answer [t1] rows: (Lighting, 25), (Computers, 15), (Kitchen, 20). Working 400/1600, 240/1600, 320/1600. Each correct row [1] [1] [1]; accept with or without the % sign. (c) 50% of 400 = 200 kWh saved per week [1]; new total 1600 - 200 = 1400 kWh [1]. (d) Interactive answer [b1] = Heating pumps (30%) [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 7]]
The team uses ideas from Mathematics and Design. (a) For each activity choose the subject that mainly supplies it. (4 marks)
1. Showing that a 50% cut in lighting saves 200 kWh a week: {{select|s1|Mathematics|Design}}
2. Deciding the colours and layout of a reminder sign so that staff will notice it: {{select|s2|Mathematics|Design}}
3. Writing a design specification that states what a switch-off sign must do: {{select|s3|Mathematics|Design}}
4. Using a graph to show when savings repay a cost: {{select|s4|Mathematics|Design}}
(b) Match each stage of the design cycle to one action by the team. (3 marks)
{{drag|c1|Inquiring and analysing,Developing ideas,Creating the solution|Interviewing staff about when lights are left on,Sketching three sign layouts and choosing one against the specification,Building the sign from a plan and recording changes,Testing the finished sign with users and suggesting improvements}}

Total for Question 2: 7 marks$mq$, $mq$(a) Interactive answers: [s1] = Mathematics [1]; [s2] = Design [1]; [s3] = Design [1]; [s4] = Mathematics [1]. (b) Interactive answer [c1]: Inquiring and analysing = interviewing staff about when lights are left on [1]; Developing ideas = sketching three sign layouts and choosing one against the specification [1]; Creating the solution = building the sign from a plan and recording changes [1]. 'Testing the finished sign...' belongs to the Evaluating stage, which is not in the table, so it is a distractor.$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 3 | B 4]]
The school can fit LED lights that cut lighting use by 50%. The fitting costs 5000 pounds. Electricity costs 0.25 pounds per kWh. The lights are used for 40 weeks each year, and the weekly saving is 200 kWh.
(a) Calculate the saving in pounds in one year. (2 marks)
(b) Plot the total saving after 1, 2, 3 and 4 years. The vertical axis is in thousands of pounds. (2 marks)
{{plot|g1|0,5,0,10|Years|Total saving (thousand pounds)}}
(c) The total saving reaches the 5000 pound fitting cost after {{select|g2|2|2.5|3}} years. (1 mark)
(d) A design student adds motion sensors that switch lights off in empty rooms. Explain one way this could raise the saving above the 50% cut, and say what data the team should record to check it. (2 marks)

Total for Question 3: 7 marks$mq$, $mq$(a) 200 x 40 = 8000 kWh [1]; 8000 x 0.25 = 2000 pounds [1]. (b) Interactive answer [g1]: points (1, 2), (2, 4), (3, 6), (4, 8). At least three correct [1]; all four correct [1]. (c) Interactive answer [g2] = 2.5 (5000 / 2000) [1]. (d) Sensors stop lights being left on in empty rooms, which reduces hours of use and so uses less energy [1]; records weekly kWh for lighting before and after, or hours of use per room, and compares them [1].$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | D 5 | C 2]]
(a) Complete the table: for each subject, state one thing it could not show on its own about the plan. (2 marks)
{{fill|e1|Subject,One thing it could not show on its own|2}}
Use the rows Mathematics and Design.
(b) The payback time of 2.5 years assumes that {{select|d1|the price of electricity and the hours of use stay the same|the LEDs never need replacing and cost nothing|every teacher agrees}}. (1 mark)
(c) Explain what the team gained by combining Mathematics and Design rather than using one alone. (2 marks)
(d) Write a message of no more than 40 words for the staff noticeboard that uses one figure from your calculations and asks for one clear action. (2 marks)

Total for Question 4: 7 marks$mq$, $mq$(a) Interactive answer [e1] rows. Mathematics: could not show whether staff would notice or follow a sign, or what the sign should look like [1]. Design: could not show how much energy or money is saved, or when the cost is repaid [1]. Accept equivalent valid limits. (b) Interactive answer [d1] = the price of electricity and the hours of use stay the same [1]. (c) A specific gain: calculations showed where the energy goes and how large the saving is, while design work turned this into a sign or feature people would use [1]; explains that together they give a solution that is both measurable and practical [1]. (d) Uses one accurate figure, for example 200 kWh a week or 2000 pounds a year, and one clear action [1]; clear, suitable for staff and within about 40 words [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
