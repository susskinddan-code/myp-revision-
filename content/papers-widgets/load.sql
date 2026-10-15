-- 11 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
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

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
