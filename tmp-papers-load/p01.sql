begin;
-- Standard Mathematics MYP 5 Full eAssessment Paper A (8 tasks, 102 marks) (102 marks)
with sub as (select id from public.subjects where slug = $mq$standard-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Standard Mathematics MYP 5 Full eAssessment Paper A (8 tasks, 102 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Standard Mathematics MYP 5 Full eAssessment Paper A (8 tasks, 102 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6 | C 2]]
Neptune is on average 4.5 × 10⁹ km from the Sun. Light travels at 3 × 10⁵ km per second.
(a) Write 4.5 × 10⁹ as an ordinary number. (1 mark)
(b) Calculate the time, in seconds, that light takes to travel from the Sun to Neptune. Give your answer in standard form. (2 marks)
(c) Change your answer to part (b) into hours, correct to 3 significant figures. (2 marks)
(d) Write √75 + √12 in the form a√3, where a is an integer. Show your working. (2 marks)
(e) Solve 3^(x − 1) = 81. (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) 4 500 000 000 [1]. (b) 4.5 × 10⁹ ÷ 3 × 10⁵ [1] = 1.5 × 10⁴ seconds [1] (the answer must be in standard form). (c) 15 000 ÷ 3600 [1] = 4.17 hours [1]. (d) √75 = 5√3 and √12 = 2√3 [1]; sum = 7√3 [1]. (e) 81 = 3⁴ so x − 1 = 4 and x = 5 [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 3 | D 3 | C 2]]
A reservoir is filled by identical pumps working together. The time T hours needed to fill the reservoir is inversely proportional to the number of pumps n. Four pumps take 9 hours. Each pump costs £15 per hour to run.
(a) Find the constant of proportionality and write a formula for T in terms of n. (2 marks)
(b) Find the time taken when 6 pumps are used. (1 mark)
(c) Find the smallest number of pumps needed to fill the reservoir in at most 3 hours. (2 marks)
(d) Calculate the running cost using 4 pumps and the running cost using 6 pumps. Explain the result. (3 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) T = k/n so 9 = k/4 and k = 36 [1]; T = 36/n [1]. (b) 36 ÷ 6 = 6 hours [1]. (c) 36/n ≤ 3 [1]; n ≥ 12 so 12 pumps [1]. (d) 4 pumps: 4 × 9 × 15 = £540 [1]; 6 pumps: 6 × 6 × 15 = £540 [1]; the cost is the same because n × T = 36 pump-hours is always needed, so the cost is always 36 × 15 = £540 [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 6 | C 2]]
A function is defined by f(x) = x² − 6x + 5.
(a) Factorise f(x). (2 marks)
(b) Hence solve f(x) = 0. (1 mark)
(c) Find f(−2). (1 mark)
(d) Write f(x) in the form (x − p)² + q and write down the coordinates of the lowest point of the graph of y = f(x). (2 marks)
(e) Solve f(x) = 12. Show each step of your working. (2 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) (x − 1)(x − 5) [2] (award 1 for a factorisation with one correct bracket or sign slip). (b) x = 1 or x = 5 [1]. (c) 4 + 12 + 5 = 21 [1]. (d) f(x) = (x − 3)² − 4 [1]; lowest point (3, −4) [1]. (e) x² − 6x − 7 = 0, so (x − 7)(x + 1) = 0 [1]; x = 7 or x = −1 [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 3 | D 3 | C 2]]
A courier delivers parcels between six depots P, Q, R, S, T and U. The roads between depots and the journey time in minutes along each road are: P–Q 7, P–R 4, Q–R 3, Q–S 6, R–S 8, R–T 11, S–T 2, S–U 6, T–U 3. Diagram not to scale.
(a) Calculate the sum of the journey times of all the roads. (1 mark)
(b) State the degree of vertex S. (1 mark)
(c) Find the shortest journey time from P to U. Write down the route and show your working. (3 marks)
(d) The courier wants a journey that uses every road exactly once, starting at P. Use the degrees of the vertices to explain whether this is possible. (2 marks)
(e) The courier leaves P at 09:10 and takes the shortest route. Find the arrival time at U. (1 mark)

Total for Question 4: 8 marks$mq$, $mq$(a) 7 + 4 + 3 + 6 + 8 + 11 + 2 + 6 + 3 = 50 minutes [1]. (b) 4 (roads to Q, R, T and U) [1]. (c) Route P–R–S–T–U [1]; 4 + 8 + 2 + 3 [1]; 17 minutes [1] (other routes: P–R–T–U = 18, P–R–S–U = 18, P–Q–S–T–U = 18). (d) Degrees: P 2, Q 3, R 4, S 4, T 3, U 2, so Q and T are the only odd vertices [1]; a journey using every road once must start at one odd vertex and end at the other, so it cannot start at P [1]. (e) 09:27 [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | D 12 | A 4 | C 4]]
A school bakery bakes x wholemeal loaves and y seeded loaves each morning. The bakery has these constraints.
Constraint 1: the oven holds at most 120 loaves in total.
Constraint 2: a wholemeal loaf uses 500 g of flour and a seeded loaf uses 400 g of flour. There is 54 kg of flour available.
Constraint 3: at least 20 seeded loaves are needed.
Constraint 4: no more than 80 wholemeal loaves can be sold.
(a) Write down an inequality for each of Constraints 1, 3 and 4. (3 marks)
(b) Show that Constraint 2 can be written as 5x + 4y ≤ 540. (2 marks)
(c) Find the coordinates of the point where the lines x + y = 120 and 5x + 4y = 540 meet. (3 marks)
(d) The feasible region is a polygon with vertices (0, 20), (0, 120), (60, 60), A and (80, 20). Find the coordinates of A, where the lines 5x + 4y = 540 and x = 80 meet. (3 marks)
(e) The bakery makes a profit of £1.20 on each wholemeal loaf and £0.80 on each seeded loaf. Write an expression for the profit £P, then calculate P at each of the five vertices. (4 marks)
(f) The manager asks you to recommend a baking plan. In your answer you should: state how many of each loaf to bake and the profit; show how much flour and oven space the plan uses; compare it with baking 60 of each loaf; and give one practical risk of your plan. (5 marks)

Total for Question 5: 20 marks$mq$, $mq$(a) x + y ≤ 120 [1]; y ≥ 20 [1]; x ≤ 80 [1]. (b) 0.5x + 0.4y ≤ 54 (working in kg) [1]; multiply both sides by 10 to get 5x + 4y ≤ 540 [1]. (c) y = 120 − x, so 5x + 4(120 − x) = 540 [1]; x = 60 [1]; y = 60, point (60, 60) [1]. (d) 5(80) + 4y = 540 [1]; 4y = 140 so y = 35 [1]; A = (80, 35) [1]. (e) P = 1.2x + 0.8y [1]; values at (0, 20) £16, (0, 120) £96, (60, 60) £120, (80, 35) £124, (80, 20) £112 [2] (award 1 mark for at least three correct values); the greatest value is £124 at (80, 35) [1]. (f) Bake 80 wholemeal and 35 seeded, profit £124 [1]; flour used 5(80) + 4(35) = 540 so all 54 kg is used [1]; oven space 115 of 120 loaves [1]; the plan makes £124 compared with £120 for 60 of each, which is £4 more per morning [1]; a valid risk, for example no spare flour so any spoilage or error means loaves are lost, or demand for seeded loaves may be higher than 35 [1].$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | D 6 | C 3 | A 1]]
An orienteering course starts and finishes at A. Runners go from A to control B, then to control C, then back to A. AB = 850 m, BC = 620 m and angle ABC = 74°. Diagram not to scale.
(a) Use the cosine rule to calculate the distance AC, correct to the nearest metre. (3 marks)
(b) Use the sine rule to calculate angle BAC, correct to 1 decimal place. (3 marks)
(c) Calculate the area of triangle ABC, correct to the nearest 1000 m². (2 marks)
(d) The organisers want the whole course to be between 2.2 km and 2.4 km long. Decide whether the course meets this requirement. Support your decision with a calculation. (2 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) AC² = 850² + 620² − 2 × 850 × 620 × cos 74° [1]; AC² = 816378 [1]; AC = 904 m [1]. (b) sin A / 620 = sin 74° / 903.5 [1]; sin A = 0.6596 [1]; angle BAC = 41.3° [1]. (c) Area = ½ × 850 × 620 × sin 74° [1] = 253292 m², which is 253000 m² to the nearest 1000 m² [1]. (d) Course length = 850 + 620 + 904 = 2374 m = 2.37 km [1]; 2.2 < 2.37 < 2.4 so the course meets the requirement [1].$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | A 4 | D 2 | C 2]]
Two athletics clubs, Club P and Club Q, record the 100 m times, in seconds, of their runners. The five-number summaries are:
Club P: minimum 10.9, lower quartile 11.4, median 11.8, upper quartile 12.5, maximum 13.6.
Club Q: minimum 11.2, lower quartile 11.6, median 12.1, upper quartile 12.4, maximum 12.9.
(a) Calculate the interquartile range of each club. (2 marks)
(b) Calculate the range of each club. (1 mark)
(c) A value is an outlier if it is more than 1.5 × IQR above the upper quartile. Show that the slowest runner in Club P is not an outlier. (2 marks)
(d) Which club has the more consistent times? Give a reason using your answers to part (a). (1 mark)
(e) A coach says that Club P is the faster club. Use the medians to explain whether the data supports this. (2 marks)

Total for Question 7: 8 marks$mq$, $mq$(a) Club P: 12.5 − 11.4 = 1.1 s [1]; Club Q: 12.4 − 11.6 = 0.8 s [1]. (b) P: 2.7 s and Q: 1.7 s [1] (both needed). (c) 1.5 × 1.1 = 1.65 and 12.5 + 1.65 = 14.15 [1]; 13.6 < 14.15 so it is not an outlier [1]. (d) Club Q, because its IQR (0.8 s) is smaller than the IQR of Club P (1.1 s) [1]. (e) The median of Club P (11.8 s) is lower than that of Club Q (12.1 s) [1]; so the typical runner in Club P is 0.3 s faster, which supports the claim for typical runners, although Club P is less consistent [1].$mq$, $mq$A$mq$),
(8, $mq$[[Q 8 | B 25 | C 7]]
Investigating patterns. A designer builds square frames from metal rods that are all the same length. Stage n is a square grid with n rows and n columns of cells, and every side of every cell is one rod. Stage 1 is a single square cell and needs 4 rods. Stage 2 is a 2 by 2 grid of four cells and needs 12 rods. Let R be the number of rods needed for stage n.
(a) Copy and complete the table for n = 1 to 5. Stages 1 and 2 are given: n = 1, R = 4; n = 2, R = 12. Find R for n = 3, n = 4 and n = 5. (3 marks)
(b) Work out the first differences and second differences of the sequence 4, 12, 24, 40, 60. State what the second differences tell you about the rule. (3 marks)
(c) Find a rule for R in terms of n. (4 marks)
(d) Verify your rule for stage 6 by continuing the pattern of differences. (3 marks)
(e) Justify why your rule is correct for every stage n by counting the rods in a grid. (4 marks)
(f) A second design uses grids with n rows and n + 2 columns (for example n = 1 is 1 row and 3 columns). Find a rule for the number of rods T in terms of n. Show how you count the horizontal and vertical rods. (4 marks)
(g) Verify your rule in part (f) for n = 3 by counting the rods in a grid of 3 rows and 5 columns. (2 marks)
(h) Show that the second design needs 4n + 2 more rods than the square design with the same n, and explain this in terms of the two extra columns. (3 marks)
(i) The designer has 500 rods. Find the largest square grid (stage n) that can be built. (3 marks)
(j) Justify that no square grid uses exactly 300 rods. (3 marks)

Total for Question 8: 32 marks$mq$, $mq$(a) n = 3: 24 [1]; n = 4: 40 [1]; n = 5: 60 [1]. (b) First differences 8, 12, 16, 20 [1]; second differences 4, 4, 4 [1]; constant second difference means the rule is quadratic [1]. (c) R = an² + bn + c with 2a = 4 so a = 2 [1]; 2 + b + c = 4 and 8 + 2b + c = 12 [1]; b = 2 and c = 0 [1]; R = 2n² + 2n [1]. (d) Next first difference is 24 so R = 60 + 24 = 84 [1]; rule gives 2(36) + 2(6) = 84 [1]; the two values agree so the rule is verified [1]. (e) A grid has n + 1 horizontal lines of rods [1]; each horizontal line has n rods so n(n + 1) horizontal rods [1]; by symmetry there are n(n + 1) vertical rods [1]; total 2n(n + 1) = 2n² + 2n, which matches the rule [1]. (f) Horizontal lines: n + 1 lines each of n + 2 rods, giving (n + 1)(n + 2) [1]; vertical lines: n + 3 lines each of n rods, giving n(n + 3) [1]; T = n² + 3n + 2 + n² + 3n [1]; T = 2n² + 6n + 2 [1]. (g) Count: 4 × 5 + 6 × 3 = 20 + 18 = 38 [1]; rule: 2(9) + 6(3) + 2 = 38 [1]. (h) (2n² + 6n + 2) − (2n² + 2n) [1] = 4n + 2 [1]; two extra columns add 2(n + 1) horizontal rods and 2n vertical rods, which total 4n + 2 [1]. (i) 2n² + 2n ≤ 500, so n² + n ≤ 250 [1]; n = 15 needs 480 rods and n = 16 needs 544 rods [1]; largest stage is n = 15 [1]. (j) n = 11 needs 2(121) + 22 = 264 rods [1]; n = 12 needs 2(144) + 24 = 312 rods [1]; the rule increases with n and 300 lies between 264 and 312 so no whole stage uses 300 rods [1].$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- Standard Mathematics MYP 5 Full eAssessment Paper B (8 tasks, 103 marks) (103 marks)
with sub as (select id from public.subjects where slug = $mq$standard-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Standard Mathematics MYP 5 Full eAssessment Paper B (8 tasks, 103 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Standard Mathematics MYP 5 Full eAssessment Paper B (8 tasks, 103 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 5 | C 3]]
Algebra and indices.
(a) Solve 3x − 7 > 11. (2 marks)
(b) Solve −4 ≤ 2x + 1 < 9. Show each step of your working. (2 marks)
(c) Write down all the integer values of x that satisfy the inequality in part (b). (1 mark)
(d) Simplify (2a³b)² ÷ (4ab²), showing your working. (2 marks)
(e) Evaluate 27^(2/3) without a calculator. (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) 3x > 18 [1]; x > 6 [1]. (b) −5 ≤ 2x < 8 [1]; −2.5 ≤ x < 4 [1]. (c) −2, −1, 0, 1, 2, 3 [1] (all six needed). (d) (2a³b)² = 4a⁶b² [1]; 4a⁶b² ÷ 4ab² = a⁵ [1]. (e) 27^(1/3) = 3 and 3² = 9 [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 3 | D 3 | C 2]]
At a weekend market, a stall sells jars of honey and loaves of bread. Three jars of honey and two loaves cost £23. Two jars of honey and five loaves cost £24.50. Let h be the price of a jar of honey and l the price of a loaf, both in pounds.
(a) Write down two equations in h and l. (2 marks)
(b) Solve the equations to find the price of a jar of honey and the price of a loaf. (3 marks)
(c) Find the cost of 5 jars of honey and 4 loaves. (1 mark)
(d) Mina has £50. She buys 4 jars of honey. Write and solve an inequality to find the greatest number of loaves she can also buy. (2 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) 3h + 2l = 23 [1]; 2h + 5l = 24.5 [1]. (b) Multiply to match a coefficient, for example 15h + 10l = 115 and 4h + 10l = 49 [1]; subtract: 11h = 66 so h = £6 [1]; l = £2.50 [1]. (c) 30 + 10 = £40 [1]. (d) 24 + 2.5l ≤ 50 [1]; l ≤ 10.4 so 10 loaves [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 5 | D 2 | C 2]]
The entrance hall of a museum is a glass pyramid with a square base of side 6 m and a perpendicular height of 4 m. The apex is directly above the centre of the base. Diagram not to scale. (The volume of a pyramid is one third × base area × height.)
(a) Calculate the volume of the pyramid. (2 marks)
(b) Show that the slant height of each triangular face is 5 m. (2 marks)
(c) The four triangular faces are made of glass. Calculate the total area of glass. (2 marks)
(d) A model of the museum entrance has a height of 20 cm. It is mathematically similar to the real pyramid. Find the length scale factor, the volume scale factor and the volume of the model in cm³. (3 marks)

Total for Question 3: 9 marks$mq$, $mq$(a) ⅓ × 6² × 4 [1] = 48 m³ [1]. (b) The slant height is the hypotenuse of a right-angled triangle with sides 3 m (half the base) and 4 m (the height) [1]; √(3² + 4²) = 5 m [1]. (c) One face ½ × 6 × 5 = 15 m² [1]; four faces 60 m² [1]. (d) Length scale factor 20 : 400 = 1 : 20 [1]; volume scale factor 1 : 8000 [1]; model volume 48 000 000 ÷ 8000 = 6000 cm³ [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 4 | D 2 | C 2]]
A survey of 40 pupils asks which of two activities they do. 22 pupils do football (F), 15 do basketball (B), and 6 do both. 9 pupils do neither.
(a) Draw a Venn diagram or describe it by stating the number of pupils in each of the four regions. (2 marks)
(b) A pupil who does basketball is chosen at random. Find the probability that this pupil also does football. (2 marks)
(c) Show that doing football and doing basketball are not independent events. (2 marks)
(d) Two different pupils are chosen at random from the 40. Find the probability that both do neither activity. (2 marks)

Total for Question 4: 8 marks$mq$, $mq$(a) Football only 16, both 6, basketball only 9 [1]; neither 9 [1]. (b) P(F | B) = 6/15 [1] = 2/5 [1]. (c) P(F) × P(B) = 22/40 × 15/40 = 330/1600 ≈ 0.206 [1]; P(F and B) = 6/40 = 0.15, which is not equal, so the events are not independent [1]. (d) 9/40 × 8/39 [1] = 72/1560 = 3/65 [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | D 14 | A 2 | C 4]]
Two rescue bases, A and B, are on a straight coast. B is 18 km from A on a bearing of 090° from A. A boat in difficulty at C is on a bearing of 040° from A and a bearing of 325° from B. Diagram not to scale. A helicopter at A can fly at 180 km/h and a lifeboat at B can travel at 30 km/h.
(a) Show that angle BAC = 50°, angle ABC = 55° and angle ACB = 75°. (3 marks)
(b) Use the sine rule to calculate the distance AC, correct to 1 decimal place. (3 marks)
(c) Calculate the distance BC, correct to 1 decimal place. (2 marks)
(d) Find the bearing of A from C. (1 mark)
(e) Calculate the travel time, in minutes, of the helicopter from A to C and of the lifeboat from B to C. Give each answer to 1 decimal place. (3 marks)
(f) The helicopter needs 10 minutes to prepare and the lifeboat needs 5 minutes to launch, both counted from the alert. A person in cold water can only survive 30 minutes after the alert. Evaluate the rescue plan. In your answer you should: calculate the time from the alert to arrival for each unit; compare each time with the 30-minute limit; recommend which unit should lead the rescue; and calculate the minimum speed the lifeboat would need to arrive within the limit. (8 marks)

Total for Question 5: 20 marks$mq$, $mq$(a) Angle BAC = 90° − 40° = 50° [1]; at B the direction of A is 270° and of C is 325°, so angle ABC = 325° − 270° = 55° [1]; angle ACB = 180° − 50° − 55° = 75° [1]. (b) AC / sin 55° = 18 / sin 75° [1]; AC = 18 sin 55° ÷ sin 75° [1]; AC = 15.3 km [1]. (c) BC = 18 sin 50° ÷ sin 75° [1] = 14.3 km [1]. (d) 040° + 180° = 220° [1]. (e) Helicopter: 15.3 ÷ 180 × 60 [1] = 5.1 minutes [1]; lifeboat: 14.3 ÷ 30 × 60 = 28.6 minutes [1]. (f) Helicopter total 15.1 minutes [1]; lifeboat total 33.6 minutes [1]; the helicopter arrives inside 30 minutes and the lifeboat is outside the limit [1]; recommend the helicopter leads the rescue [1] and the lifeboat should still go as support, because it can recover the person afterwards or treat the person on shore [1]; the lifeboat has 30 − 5 = 25 minutes of travel [1]; speed ≥ 14.3 ÷ (25/60) [1] = 34.3 km/h, which is more than 30 km/h so the lifeboat cannot reach in time at its current speed [1].$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | D 6 | A 2 | C 2]]
A nursery records the heights, h cm, of 60 sunflower seedlings after three weeks.
Height: 10 ≤ h < 15 has 6 seedlings; 15 ≤ h < 20 has 14; 20 ≤ h < 25 has 20; 25 ≤ h < 30 has 12; 30 ≤ h < 35 has 8.
(a) Write down the cumulative frequency at the upper end of each class. (1 mark)
(b) Calculate an estimate of the mean height. Show your working. (3 marks)
(c) Use the cumulative frequency to estimate the median height by interpolation within the median class. (2 marks)
(d) Estimate the lower quartile and the upper quartile. (2 marks)
(e) A calculator gives a standard deviation of 5.8 cm for this data. A second nursery has seedlings with mean height 23.4 cm and standard deviation 3.1 cm. Compare the two nurseries, referring to both the mean and the standard deviation. (2 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) 6, 20, 40, 52, 60 [1]. (b) Midpoints 12.5, 17.5, 22.5, 27.5, 32.5 [1]; Σfx = 75 + 245 + 450 + 330 + 260 = 1360 [1]; mean = 1360 ÷ 60 = 22.7 cm [1]. (c) The 30th value lies in 20 ≤ h < 25 [1]; estimate 20 + (30 − 20)/20 × 5 = 22.5 cm [1]. (d) Lower quartile (15th value) 15 + 9/14 × 5 = 18.2 cm [1]; upper quartile (45th value) 25 + 5/12 × 5 = 27.1 cm [1]. (e) The second nursery has taller seedlings on average (23.4 cm against 22.7 cm) [1]; the second nursery has the smaller standard deviation (3.1 cm against 5.8 cm) so its heights are more consistent [1].$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | A 6 | C 2]]
Triangle ABC has vertices A(1, 1), B(4, 1) and C(4, 3). Diagram not to scale.
(a) Triangle ABC is reflected in the y-axis. Write down the coordinates of the three vertices of the image. (2 marks)
(b) Triangle PQR has vertices P(−1, 1), Q(−1, 4) and R(−3, 4). Describe fully the single transformation that maps ABC onto PQR. (2 marks)
(c) Triangle ABC is enlarged with scale factor 2 and centre the origin. Write down the coordinates of the image of each vertex. (2 marks)
(d) Calculate the area of triangle ABC and the area of its enlargement. Explain how the areas are related. (2 marks)

Total for Question 7: 8 marks$mq$, $mq$(a) (−1, 1), (−4, 1), (−4, 3) [2] (award 1 for two correct vertices). (b) A rotation [1] of 90° anticlockwise about the origin [1]. (c) (2, 2), (8, 2), (8, 6) [2] (award 1 for two correct vertices). (d) ABC: ½ × 3 × 2 = 3; enlargement: ½ × 6 × 4 = 12 [1]; the area is multiplied by 2² = 4 [1].$mq$, $mq$A$mq$),
(8, $mq$[[Q 8 | B 25 | C 7]]
Investigating patterns. In a table tennis league, every team plays every other team exactly once (a round robin). Let n be the number of teams and M the number of matches. With 2 teams there is 1 match, with 3 teams there are 3 matches, and with 4 teams there are 6 matches.
(a) Find M for n = 5, n = 6 and n = 7 by drawing or listing the matches. (3 marks)
(b) Work out the first and second differences of the sequence 1, 3, 6, 10, 15, 21. (2 marks)
(c) Find a rule for M in terms of n. (4 marks)
(d) Verify your rule for n = 8 by continuing the pattern of differences. (3 marks)
(e) Justify why your rule is correct for every n. (4 marks)
(f) In a double round robin every pair of teams plays twice (home and away). Write a rule for the number of matches D and find D for 16 teams. (3 marks)
(g) A league of n teams (n even) splits into two equal groups, and each group plays a single round robin. Show that the total number of matches is n(n − 2) ÷ 4. (4 marks)
(h) For 16 teams, how many fewer matches are played in the two-group league than in one single round robin? Explain why there are fewer. (3 marks)
(i) The organiser has time for at most 100 matches. Find the largest number of teams in a single round robin. (3 marks)
(j) Justify that no single round robin has exactly 100 matches. (3 marks)

Total for Question 8: 32 marks$mq$, $mq$(a) n = 5: 10 [1]; n = 6: 15 [1]; n = 7: 21 [1]. (b) First differences 2, 3, 4, 5, 6 [1]; second differences all 1 [1]. (c) M = an² + bn + c with 2a = 1 so a = ½ [1]; using n = 2 and n = 3: 2 + 2b + c = 1 and 4.5 + 3b + c = 3 [1]; b = −½ and c = 0 [1]; M = ½n² − ½n = n(n − 1)/2 [1]. (d) Next first difference is 7 so M = 21 + 7 = 28 [1]; rule gives 8 × 7 ÷ 2 = 28 [1]; the values agree [1]. (e) Each team plays n − 1 opponents [1]; there are n teams so n(n − 1) team appearances [1]; each match involves two teams so it has been counted twice [1]; so M = n(n − 1) ÷ 2 [1]. (f) D = 2M [1] = n(n − 1) [1]; for 16 teams D = 240 [1]. (g) Each group has n/2 teams [1]; matches in one group (n/2)(n/2 − 1) ÷ 2 [1]; two groups give (n/2)(n/2 − 1) [1] = n(n − 2) ÷ 4 [1]. (h) Single: 120 matches and two groups: 16 × 14 ÷ 4 = 56 matches [1]; 120 − 56 = 64 fewer [1]; teams in different groups never play each other [1]. (i) n(n − 1)/2 ≤ 100 [1]; n = 14 gives 91 and n = 15 gives 105 [1]; the largest is 14 teams [1]. (j) n = 14 gives 91 matches [1]; n = 15 gives 105 matches [1]; the number of matches increases with n and 100 lies between 91 and 105 so no n gives 100 [1].$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- Standard Mathematics MYP 5 Full eAssessment Paper C (8 tasks, 102 marks) (102 marks)
with sub as (select id from public.subjects where slug = $mq$standard-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Standard Mathematics MYP 5 Full eAssessment Paper C (8 tasks, 102 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Standard Mathematics MYP 5 Full eAssessment Paper C (8 tasks, 102 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 4 | D 2 | C 2]]
A tablet has a storage capacity of 2.5 × 10¹² bytes. One photo uses 4 × 10⁶ bytes.
(a) Calculate how many photos the tablet can store when it is empty. Give your answer in standard form. (2 marks)
(b) Videos already on the tablet use 8 × 10¹¹ bytes. Calculate the storage left, in standard form. (2 marks)
(c) Rationalise the denominator of 6/√3 and write it in the form a√3. (2 marks)
(d) Evaluate 8^(−2/3) without a calculator. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) 2.5 × 10¹² ÷ 4 × 10⁶ [1] = 6.25 × 10⁵ photos [1]. (b) 2.5 × 10¹² − 0.8 × 10¹² [1] = 1.7 × 10¹² bytes [1]. (c) 6/√3 × √3/√3 = 6√3/3 [1] = 2√3 [1]. (d) 8^(1/3) = 2 [1]; 2^(−2) = 1/4 [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 5 | C 3]]
In each part O is the centre of the circle. Diagrams are not to scale. In every part write down the circle theorem you use as part of your answer.
(a) AB is a diameter and C lies on the circumference. Angle CAB = 38°. Find angle ABC. (2 marks)
(b) A and B lie on the circle and angle AOB = 124°. Find angle OAB. (2 marks)
(c) A tangent touches the circle at T. TA is a chord. The angle between the tangent and TA is 57°. B is a point on the circumference in the alternate segment. Find angle TBA. (2 marks)
(d) The radius of the circle is 5 cm. P is a point outside the circle with OP = 13 cm. PT is a tangent to the circle at T. Calculate the length PT. (2 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) Angle ACB = 90° (angle in a semicircle) [1]; angle ABC = 180° − 90° − 38° = 52° [1]. (b) OA = OB (radii) so triangle OAB is isosceles [1]; angle OAB = (180° − 124°) ÷ 2 = 28° [1]. (c) Angle TBA = 57° [1] by the alternate segment theorem [1]. (d) Angle OTP = 90° (radius meets tangent at a right angle) so PT² = 13² − 5² = 144 [1]; PT = 12 cm [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 4 | D 2 | C 2]]
On a map of a town, one unit on each axis represents 1 km. Three junctions are at A(−2, 1), B(4, 5) and C(6, 1). A straight road joins A to B.
(a) Find the gradient of the road AB. (1 mark)
(b) A café is at the midpoint of AB. Find its coordinates. (1 mark)
(c) Calculate the length of the road AB, correct to 2 decimal places. (2 marks)
(d) A new straight road passes through C and is parallel to AB. Find its equation in the form y = mx + c. (2 marks)
(e) Find the equation of the line through B that is perpendicular to AB. (2 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) (5 − 1) ÷ (4 − (−2)) = 4/6 = 2/3 [1]. (b) (1, 3) [1]. (c) √(6² + 4²) = √52 [1] = 7.21 km [1]. (d) Gradient 2/3 so y − 1 = (2/3)(x − 6) [1]; y = (2/3)x − 3 [1]. (e) Perpendicular gradient −3/2 [1]; y − 5 = −(3/2)(x − 4) giving y = −1.5x + 11 [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 4 | C 2 | D 2]]
The probability that it rains on Saturday is 0.3. If it rains on Saturday, the probability that it rains on Sunday is 0.6. If it does not rain on Saturday, the probability that it rains on Sunday is 0.2.
(a) Draw a tree diagram, or state the probabilities on each branch, for the two days. (2 marks)
(b) Find the probability that it rains on both days. (1 mark)
(c) Find the probability that it rains on exactly one of the two days. (2 marks)
(d) Find the probability that it rains on Sunday. (1 mark)
(e) It rains on Sunday. Find the probability that it also rained on Saturday. (2 marks)

Total for Question 4: 8 marks$mq$, $mq$(a) Saturday: rain 0.3, no rain 0.7 [1]; Sunday after rain: rain 0.6, no rain 0.4, and after no rain: rain 0.2, no rain 0.8 [1]. (b) 0.3 × 0.6 = 0.18 [1]. (c) 0.3 × 0.4 + 0.7 × 0.2 [1] = 0.12 + 0.14 = 0.26 [1]. (d) 0.18 + 0.14 = 0.32 [1]. (e) 0.18 ÷ 0.32 [1] = 9/16 = 0.5625 [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | D 13 | A 3 | C 4]]
A community stadium is to have a seating block with rows of seats. Row 1 has 24 seats and each row has 3 more seats than the row before it, so the numbers of seats form an arithmetic sequence. Each seat is 0.5 m wide. The widest row allowed by the building plan is 45 m. Each seat costs £85 to supply and fit, and the budget for the block is £110 000.
(a) Find the number of seats in row 10. (2 marks)
(b) Show that the number of seats in row n is 3n + 21. (2 marks)
(c) Show that the total number of seats in the first n rows is n(3n + 45)/2. (2 marks)
(d) Calculate the number of seats in a block of 20 rows. (2 marks)
(e) The stadium wants at least 1500 seats in the block. Form and solve a quadratic inequality to find the least number of rows needed. (3 marks)
(f) Design the seating block. In your answer you should: identify two constraints from the information at the start; calculate the greatest number of rows allowed by the width of the widest row; calculate the greatest number of seats allowed by the budget; choose the number of rows and justify your choice; and state the total cost and how many seats short of 1500 your design is. (9 marks)

Total for Question 5: 20 marks$mq$, $mq$(a) 24 + 9 × 3 [1] = 51 [1]. (b) u = 24 + 3(n − 1) [1] = 3n + 21 [1]. (c) Sum of an arithmetic sequence: n/2 × (first + last) = n/2 × (24 + 3n + 21) [1] = n(3n + 45)/2 [1]. (d) 20 × (60 + 45) ÷ 2 [1] = 1050 [1]. (e) n(3n + 45)/2 ≥ 1500 gives n² + 15n − 1000 ≥ 0 [1]; (n − 25)(n + 40) ≥ 0 [1]; n ≥ 25 so 25 rows [1]. (f) Two constraints, for example widest row at most 45 m (90 seats) and budget £110 000 [2]; 3n + 21 ≤ 90 so n ≤ 23 [1]; 110 000 ÷ 85 = 1294.1 so at most 1294 seats [1]; 23 rows would give 1311 seats, costing £111 435, over budget [1]; 22 rows gives 1221 seats [1] and its widest row has 87 seats (43.5 m), which is allowed [1]; cost 1221 × 85 = £103 785, within the budget [1]; the design is 1500 − 1221 = 279 seats short of the 1500 target, so the target cannot be met within the constraints [1].$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | D 6 | A 2 | C 2]]
A camping tent is a triangular prism. The cross-section is an isosceles triangle with base 2.4 m and perpendicular height 1.5 m. The tent is 3.0 m long. Diagram not to scale. The tent fabric, including the floor and both triangular ends, costs £14 per m². The campsite budget for one tent is £320.
(a) Calculate the volume of the tent. (2 marks)
(b) Calculate the length of each sloping side of the cross-section, correct to 3 significant figures. (2 marks)
(c) Calculate the total area of fabric needed for the tent, correct to 2 decimal places. (3 marks)
(d) A designer suggests making the tent 3.5 m long. Decide whether each tent length can be made within the £320 budget. Support your answer with calculations. (3 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) ½ × 2.4 × 1.5 × 3.0 [1] = 5.4 m³ [1]. (b) √(1.2² + 1.5²) [1] = √3.69 = 1.921 = 1.92 m (3 s.f.) [1]. (c) Two sloping rectangles 2 × 1.921 × 3 = 11.53 m² [1]; floor 2.4 × 3 = 7.2 m² and two triangular ends 3.6 m² [1]; total 22.33 m² [1]. (d) Cost for 3.0 m: 22.33 × 14 = £312.56, within budget [1]; cost for 3.5 m: fabric 25.45 m², cost £356.25 [1]; the 3.5 m tent is over budget by about £36.25 so only the 3.0 m tent is affordable [1].$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | A 4 | D 2 | C 2]]
A goalkeeper makes the following numbers of saves in five matches: 14, 16, 18, 20, 22.
(a) Calculate the mean number of saves. (1 mark)
(b) Write down the median and the range. (2 marks)
(c) Show that the variance is 8. (2 marks)
(d) Write down the standard deviation, correct to 3 significant figures. (1 mark)
(e) A second goalkeeper has a mean of 18 saves and a standard deviation of 4.1 saves. Compare the two goalkeepers. (2 marks)

Total for Question 7: 8 marks$mq$, $mq$(a) 90 ÷ 5 = 18 [1]. (b) Median 18 [1]; range 22 − 14 = 8 [1]. (c) Squared differences from the mean 16, 4, 0, 4, 16 [1]; sum 40 and 40 ÷ 5 = 8 [1]. (d) √8 = 2.83 [1]. (e) Both make the same number of saves on average [1]; the first goalkeeper is more consistent because the standard deviation is smaller (2.83 against 4.1) [1].$mq$, $mq$A$mq$),
(8, $mq$[[Q 8 | B 25 | C 7]]
Investigating patterns. A circular cake is cut by n straight cuts, each running all the way across the cake. The cuts are made so that every pair of cuts crosses inside the cake and no three cuts pass through the same point. Let R be the greatest number of pieces. With 0 cuts there is 1 piece, with 1 cut there are 2 pieces, with 2 cuts there are 4 pieces and with 3 cuts there are 7 pieces.
(a) Find R for 4 cuts and for 5 cuts. (2 marks)
(b) Work out the first and second differences of the sequence 1, 2, 4, 7, 11, 16. (2 marks)
(c) Find a rule for R in terms of n. (4 marks)
(d) Verify your rule for 6 cuts by continuing the pattern of differences. (3 marks)
(e) Justify why the nth cut adds exactly n new pieces. (4 marks)
(f) Find the least number of cuts needed to make at least 100 pieces. (3 marks)
(g) Another cutting method uses n parallel cuts (which never cross) and then one more cut across all of them. Show that this makes 2(n + 1) pieces. (4 marks)
(h) Both methods use 11 cuts in total. For the parallel method use n = 10. Calculate the number of pieces for each method and find the difference. (3 marks)
(i) A student predicts that the number of pieces doubles with each cut (1, 2, 4, 8, ...). Show that this prediction is wrong and explain why the pattern does not continue to double. (3 marks)
(j) Find the greatest number of cuts that makes no more than 50 pieces. (4 marks)

Total for Question 8: 32 marks$mq$, $mq$(a) 4 cuts: 11 pieces [1]; 5 cuts: 16 pieces [1]. (b) First differences 1, 2, 3, 4, 5 [1]; second differences all 1 [1]. (c) R = an² + bn + c with 2a = 1 so a = ½ [1]; n = 0 gives c = 1 [1]; n = 1 gives ½ + b + 1 = 2 so b = ½ [1]; R = ½n² + ½n + 1 [1]. (d) Next first difference is 6 so R = 16 + 6 = 22 [1]; rule gives (36 + 6 + 2) ÷ 2 = 22 [1]; they agree [1]. (e) The nth cut crosses each of the previous n − 1 cuts once [1]; these n − 1 crossing points split the new cut into n sections [1]; each section divides one existing piece into two [1]; so n new pieces are made and R(n) = R(n − 1) + n [1]. (f) n² + n + 2 ≥ 200, so n² + n ≥ 198 [1]; 13 cuts give 92 pieces and 14 cuts give 106 pieces [1]; 14 cuts [1]. (g) n parallel cuts make n + 1 strips [1]; the extra cut crosses all n parallel cuts, so it passes through every strip [1]; each of the n + 1 strips is split in two [1]; total 2(n + 1) [1]. (h) All crossing: (121 + 11 + 2) ÷ 2 = 67 [1]; parallel: 2 × 11 = 22 [1]; difference 45 [1]. (i) Prediction for 3 cuts is 8 but the actual value is 7 [1]; the differences between terms are 1, 2, 3 and so on, increasing by 1 each time [1]; a doubling pattern would need the differences to double, but each new cut can only add n pieces [1]. (j) n² + n + 2 ≤ 100, so n² + n ≤ 98 [1]; 9 cuts give 46 pieces [1]; 10 cuts give 56 pieces, which is more than 50 [1]; the greatest number of cuts is 9 [1].$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- Extended Mathematics MYP 5 Full eAssessment Paper A (8 tasks, 104 marks) (104 marks)
with sub as (select id from public.subjects where slug = $mq$extended-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Extended Mathematics MYP 5 Full eAssessment Paper A (8 tasks, 104 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Extended Mathematics MYP 5 Full eAssessment Paper A (8 tasks, 104 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 4 | C 2 | D 2]]
Logarithms and bounds. In this question, logarithms without a base are to base 10.
(a) [A1] Evaluate log₃ 81. (1 mark)
(b) [A1 C1] Show that 2 log 5 + log 4 = 2. (2 marks)
(c) [A2] Solve 5ˣ = 40. Give your answer correct to 3 significant figures. (2 marks)
(d) [D2 C1] A rectangular solar panel has length 1.6 m and width 0.85 m. Each measurement is correct to 2 significant figures. Calculate the lower bound and the upper bound of the area of the panel, then state the area to a suitable degree of accuracy. Justify your choice. (3 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) log₃ 81 = 4 because 3⁴ = 81 [1].
(b) 2 log 5 = log 25 [1]; log 25 + log 4 = log 100 = 2 [1].
(c) x = log 40 / log 5 [1]; x = 2.29 (2.292...) [1].
(d) Lower bound 1.55 × 0.845 = 1.30975 m² [1]; upper bound 1.65 × 0.855 = 1.41075 m² [1]; the bounds are 1.3... and 1.4..., which differ at 2 significant figures but both round to 1 at 1 significant figure, so the area can only be given reliably as 1 m² [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 6 | D 4]]
Graphs of functions. The function g is defined by g(x) = 4/(x − 2) + 1 for x ≠ 2. A marker on a rotating drum has height k(x) cm relative to a fixed line, x seconds after timing starts, where k(x) = 2 cos(3x°) − 1 for 0 ≤ x ≤ 180.
(a) [A2] Write down the equations of the vertical asymptote and the horizontal asymptote of the graph of g. (2 marks)
(b) [A2] Find the coordinates of the points where the graph of g crosses the x-axis and the y-axis. (2 marks)
(c) [D2] State the amplitude of k and the time taken for the marker to complete one full cycle. (2 marks)
(d) [D1] State the greatest and least heights of the marker relative to the fixed line. (1 mark)
(e) [A2 D1] Find the times during the 180 seconds at which the marker is exactly on the fixed line (k(x) = 0). Show your working. (3 marks)

Total for Question 2: 10 marks$mq$, $mq$(a) Vertical asymptote x = 2 [1]; horizontal asymptote y = 1 [1].
(b) y-axis: g(0) = 4/(−2) + 1 = −1, so (0, −1) [1]; x-axis: 4/(x − 2) = −1, so x − 2 = −4 and x = −2, so (−2, 0) [1].
(c) Amplitude 2 cm [1]; period 360 ÷ 3 = 120 seconds [1].
(d) Greatest height 1 cm and least height −3 cm (that is, 3 cm below the line) [1].
(e) 2 cos(3x°) = 1 so cos(3x°) = 0.5 [1]; 3x = 60, 300, 420 (the range for 3x is 0 to 540) [1]; x = 20, 100, 140 seconds [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 4 | C 2 | D 2]]
Triangular plot of land. A triangular plot of land ABC has AB = 125 m, BC = 98 m and angle ABC = 70°. Diagram not to scale.
(a) [A2 C1] Calculate the length AC. Give your answer correct to 1 decimal place. (3 marks)
(b) [A1 C1] Calculate the size of angle ACB. Give your answer correct to 1 decimal place. (2 marks)
(c) [A1 D2] Calculate the area of the plot. Turf costs £3.20 per square metre. Calculate the cost of turfing the whole plot, to the nearest £100. (3 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) AC² = 125² + 98² − 2(125)(98) cos 70° [1]; AC² = 25 229 − 8379.5 = 16 849.5 (approximately) [1]; AC = 129.8 m [1].
(b) sin C / 125 = sin 70° / 129.8 [1]; angle ACB = 64.8° [1]. (Accept 64.8 to 64.9 if rounded values are used.)
(c) Area = ½ × 125 × 98 × sin 70° = 5756 m² (5755.6) [1]; cost = 5755.6 × 3.20 = £18 418 [1]; to the nearest £100 the cost is £18 400 [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 5 | C 4]]
Probability and statistics. A year group has 60 students. 28 study French (F), 24 study Spanish (S) and 9 study both languages.
(a) [A2] Find the number of students in each of the four regions of a Venn diagram for F and S. (2 marks)
(b) [A2] A student is chosen at random. Given that the student studies Spanish, find the probability that the student also studies French. (2 marks)
(c) [C2] Show that studying French and studying Spanish are not independent events. (2 marks)
(d) [A1] Five students scored 12, 15, 15, 18 and 20 in a test. The mean score is 16. Calculate the standard deviation of these scores, correct to 3 significant figures. (1 mark)
(e) [C2] A second group of five students has mean 16 and standard deviation 1.9. Compare the two groups' scores. (2 marks)

Total for Question 4: 9 marks$mq$, $mq$(a) Both = 9, French only = 28 − 9 = 19 [1]; Spanish only = 24 − 9 = 15 and neither = 60 − (19 + 9 + 15) = 17 [1].
(b) P(F | S) = n(F ∩ S) / n(S) [1] = 9/24 = 3/8 [1].
(c) P(F) × P(S) = 28/60 × 24/60 = 14/75 (about 0.187) [1]; P(F ∩ S) = 9/60 = 0.15, which is not equal to 0.187, so the events are not independent [1].
(d) Standard deviation = 2.76 [1] (squared deviations 16, 1, 1, 4, 16 sum to 38; variance 7.6).
(e) The means are equal, so the groups scored the same on average [1]; the second group has the smaller standard deviation (1.9 < 2.76), so its scores are more consistent / less spread out [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | A 1 | B 2 | D 4]]
Networks and sequences. A phone company plans to connect six villages A to F with cable. The table shows the possible links and their lengths in km: AB 7, AC 4, BC 3, BD 9, CD 6, CE 10, DE 5, DF 8, EF 2.
(a) [A1 D2] Find the minimum spanning tree of this network. List the links used and the total length of cable needed. (3 marks)
(b) [D2] Find the shortest route from A to F using these links. Give the route and its length. (2 marks)
(c) [B2] The numbers of views of a video, in hundreds, on days 1, 2 and 3 are 8, 12 and 18. The numbers form a geometric sequence. Find the common ratio and the number of views on day 5. (2 marks)

Total for Question 5: 7 marks$mq$, $mq$(a) Method: add the shortest links first and reject any link that makes a cycle [1]; links EF 2, BC 3, AC 4, DE 5, CD 6 (AB 7 is rejected as it makes a cycle with A, B, C) [1]; total 2 + 3 + 4 + 5 + 6 = 20 km [1].
(b) A–C–E–F = 4 + 10 + 2 = 16 km [1]; other routes are longer, for example A–C–D–E–F = 17 km, A–C–D–F = 18 km and A–B–D–F = 24 km, so 16 km is the shortest [1].
(c) Common ratio 12 ÷ 8 = 1.5 [1]; day 5 = 8 × 1.5⁴ = 40.5 hundred = 4050 views [1].$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | A 5 | C 3 | D 7]]
Real-life modelling: a phone battery. The capacity of a phone battery is measured as a percentage of its capacity when new. A manufacturer models the capacity after n hundred charge cycles by C(n) = 100 × 0.96ⁿ.
(a) [A2] Calculate the capacity of the battery after 500 charge cycles. Give your answer correct to 1 decimal place. (2 marks)
(b) [C2] Explain why the model means the battery loses 4% of its current capacity every hundred cycles, not 4 percentage points. (2 marks)
(c) [A3] Use logarithms to solve C(n) = 70. Hence find the number of charge cycles, to the nearest 10, after which the capacity first falls to 70%. (3 marks)
(d) [D3] A laboratory measures the capacity of one battery. After 0, 1, 2, 3 and 4 hundred cycles the readings are 100, 96.1, 92.0, 88.5 and 85.0. A rival model is L(n) = 100 − 2.4n. Decide which model fits the readings better. Justify your answer using calculated values. (3 marks)
(e) [C1 D1] An advertisement claims: 'Keeps at least 80% capacity for 600 charge cycles.' Use the model C(n) to decide whether the claim is supported. (2 marks)
(f) [D3] The manufacturer wants to write a warranty of the form 'at least 80% capacity for N charge cycles' where N is a multiple of 100. Find the largest possible N according to the model and justify whether this is a sensible warranty. (3 marks)

Total for Question 6: 15 marks$mq$, $mq$(a) n = 5: C = 100 × 0.96⁵ [1] = 81.5% [1].
(b) C(n + 1) ÷ C(n) = 0.96 for every n [1]; so each hundred cycles removes 4% of the capacity at that time, which is a smaller amount each time (not a fixed 4 percentage points) [1].
(c) 0.96ⁿ = 0.7 [1]; n = log 0.7 / log 0.96 [1]; n = 8.74, so about 870 charge cycles [1].
(d) Exponential model values 100, 96.0, 92.2, 88.5, 84.9 [1]; linear model values 100, 97.6, 95.2, 92.8, 90.4 [1]; the exponential values are within 0.2 of every reading but the linear values are up to 5.4 away, so C(n) fits better [1].
(e) C(6) = 100 × 0.96⁶ = 78.3% [1]; 78.3 < 80, so the claim is not supported by the model [1].
(f) Solve 100 × 0.96ⁿ ≥ 80: n ≤ log 0.8 / log 0.96 = 5.47 [1]; the largest whole number of hundreds is 5, so N = 500 [1]; sensible because the model matches the laboratory readings closely and C(5) = 81.5% leaves a small margin, though real batteries vary so a lower N such as 400 might be safer [1].$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | A 4 | C 5 | D 8]]
Real-life modelling: a candle workshop. A workshop makes x large candles and y small candles each week. A large candle uses 300 g of wax and 40 minutes of work. A small candle uses 100 g of wax and 20 minutes of work. Each week 6 kg of wax and 15 hours of work are available. The workshop makes at least 5 large candles each week. The profit is £8 on each large candle and £3 on each small candle.
(a) [C2] Show that the wax limit can be written as the inequality 3x + y ≤ 60. (2 marks)
(b) [C2] Write down the inequalities for the work time (in its simplest form) and for the minimum number of large candles. Also state the inequality that stops y being negative. (2 marks)
(c) [A3 C1] The feasible region is a quadrilateral. Find the coordinates of its four vertices. (4 marks)
(d) [A1 D2] Write an expression for the weekly profit £P. Find the number of each candle that gives the maximum profit and state that profit. (3 marks)
(e) [D3] The profit on a small candle rises to £5. Show that the best plan changes, and find the new best plan and the new maximum profit. (3 marks)
(f) [D3] The workshop can only store 30 candles in total each week, so x + y ≤ 30. With the profit of £5 on a small candle, decide whether the plan in the previous part is still possible. Recommend a plan and justify your recommendation. (3 marks)

Total for Question 7: 17 marks$mq$, $mq$(a) 300x + 100y ≤ 6000 (6 kg = 6000 g) [1]; divide by 100 to get 3x + y ≤ 60 [1].
(b) 40x + 20y ≤ 900 gives 2x + y ≤ 45 [1]; x ≥ 5 and y ≥ 0 [1].
(c) (5, 0) from x = 5 and y = 0 [1]; (20, 0) from 3x + y = 60 with y = 0, because x = 22.5 from the time limit is outside the wax limit [1]; (5, 35) from x = 5 and 2x + y = 45 [1]; (15, 15) from solving 3x + y = 60 and 2x + y = 45 (subtract to get x = 15, then y = 15) [1].
(d) P = 8x + 3y [1]; values at the vertices: (5, 0) = 40, (20, 0) = 160, (15, 15) = 165, (5, 35) = 145 [1]; maximum profit £165 with 15 large and 15 small candles [1].
(e) New profit P = 8x + 5y [1]; values: (5, 0) = 40, (20, 0) = 160, (15, 15) = 195, (5, 35) = 215 [1]; the best plan is now 5 large and 35 small candles, with a profit of £215, which is different from the earlier plan [1].
(f) (5, 35) has 40 candles, more than 30, so it is no longer possible [1]; the new vertices are (5, 0), (20, 0), (15, 15) and (5, 25) with profits 40, 160, 195 and 165 [1]; recommend 15 large and 15 small candles, profit £195, because it has the highest profit of all feasible vertices [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | B 20 | C 10]]
Investigation: diagonals of polygons. A diagonal of a polygon is a straight line joining two vertices that are not next to each other. For a convex polygon with n sides, let D be the number of diagonals. The triangle (n = 3) has no diagonals. The table shows the first values.
n: 3, 4, 5, 6
D: 0, 2, 5, 9
(a) [B2] Find D when n = 7 and when n = 8. (2 marks)
(b) [B3] For n = 3 to 8, find the differences between consecutive values of D and then the differences between those differences. Describe the pattern and say what it suggests about the type of rule. (3 marks)
(c) [B4] Find a rule of the form D = an² + bn + c. (4 marks)
(d) [C3] Explain, using the idea of vertices, why the number of diagonals is n(n − 3)/2. (3 marks)
(e) [B2 C1] A polygon has 170 diagonals. Find the number of sides. (3 marks)
(f) [B2 C2] Drawing all the diagonals from one vertex splits an n-sided polygon into n − 2 triangles. Use this to show that the sum of the interior angles is 180(n − 2)°. Hence find the size of one interior angle of the regular polygon with 170 diagonals. (4 marks)
(g) [B3] Now count triangles whose three vertices are vertices of the polygon. Let T be this number. For n = 3, 4, 5, 6, 7 the values of T are 1, 4, 10, 20, 35. Use first, second and third differences to predict T when n = 8. (3 marks)
(h) [B1 C2] The rule for T is T = n(n − 1)(n − 2)/6. Verify this rule for n = 8, and explain why the rule works. (3 marks)
(i) [B3] Find the smallest value of n for which T is greater than 10 000. (3 marks)
(j) [C2] State one limitation of the rule for D that applies to polygons that are not convex, and explain what goes wrong. (2 marks)

Total for Question 8: 30 marks$mq$, $mq$(a) n = 7: D = 14 [1]; n = 8: D = 20 [1].
(b) First differences 2, 3, 4, 5, 6 [1]; second differences all equal to 1 [1]; a constant second difference suggests a quadratic rule [1].
(c) a = ½ because the second difference is 2a = 1 [1]; using n = 3 and n = 4: 0 = 4.5 + 3b + c and 2 = 8 + 4b + c [1]; subtract to get b = −1.5 and c = 0 [1]; D = ½n² − 1.5n = n(n − 3)/2 [1].
(d) Each vertex is joined by diagonals to n − 3 other vertices (not itself or its two neighbours) [1]; counting from all n vertices gives n(n − 3) [1]; every diagonal has two ends so it has been counted twice, so divide by 2 [1].
(e) n(n − 3) = 340 so n² − 3n − 340 = 0 [1]; (n − 20)(n + 17) = 0 [1]; n = 20, rejecting n = −17 because the number of sides cannot be negative [1].
(f) There are n − 2 triangles, each with angle sum 180° [1]; so the angle sum is 180(n − 2)° [1]; for n = 20 the sum is 3240° [1]; each interior angle of the regular polygon is 3240 ÷ 20 = 162° [1].
(g) First differences 3, 6, 10, 15 and second differences 3, 4, 5, third differences 1, 1 [1]; extend: next second difference 6 and next first difference 15 + 6 = 21 [1]; T = 35 + 21 = 56 [1].
(h) 8 × 7 × 6 ÷ 6 = 56, which matches the prediction [1]; choosing three vertices in order gives n(n − 1)(n − 2) ways [1]; each triangle is counted 3 × 2 × 1 = 6 times because the order does not matter, so divide by 6 [1].
(i) n(n − 1)(n − 2) > 60 000 [1]; T(40) = 40 × 39 × 38 ÷ 6 = 9880, which is too small [1]; T(41) = 10 660, so n = 41 [1].
(j) The rule only works for convex polygons [1]; in a non-convex polygon some lines between non-adjacent vertices pass outside the polygon, so they are not counted as diagonals and the rule gives too many [1].$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- Extended Mathematics MYP 5 Full eAssessment Paper B (8 tasks, 104 marks) (104 marks)
with sub as (select id from public.subjects where slug = $mq$extended-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Extended Mathematics MYP 5 Full eAssessment Paper B (8 tasks, 104 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Extended Mathematics MYP 5 Full eAssessment Paper B (8 tasks, 104 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 5 | C 2 | D 2]]
Logarithms and bounds. In this question, logarithms without a base are to base 10.
(a) [A1 C1] Given that log 2 = a and log 3 = b, write log 72 in terms of a and b. (2 marks)
(b) [A1 C1] Solve log₂(x + 3) = 5. (2 marks)
(c) [A2] The loudness L of a sound, in decibels, is given by L = 10 log(I / 10⁻¹²), where I is the intensity in watts per square metre. A busy road has I = 2.5 × 10⁻⁵. Calculate L, correct to 3 significant figures. (2 marks)
(d) [A1 D2] A cyclist rides 12.4 km, correct to 3 significant figures, in 27 minutes, correct to the nearest minute. Calculate the upper bound of her average speed in km/h, correct to 3 significant figures. (3 marks)

Total for Question 1: 9 marks$mq$, $mq$(a) 72 = 2³ × 3² [1]; log 72 = 3 log 2 + 2 log 3 = 3a + 2b [1].
(b) x + 3 = 2⁵ = 32 [1]; x = 29 [1].
(c) I / 10⁻¹² = 2.5 × 10⁷ [1]; L = 10 log(2.5 × 10⁷) = 74.0 decibels [1].
(d) Upper bound of distance 12.45 km [1]; lower bound of time 26.5 minutes = 26.5/60 hours [1]; speed = 12.45 ÷ (26.5/60) = 28.2 km/h [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 3 | C 3 | D 3]]
Graphs of functions. The function f is defined by f(x) = (3x − 2)/(x + 1) for x ≠ −1. A paddle wheel turns in a stream. The height of a paddle tip above the water surface is h cm, x seconds after timing starts, where h = 5 sin(3x°) + 2 for 0 ≤ x ≤ 120.
(a) [A1 C1] Write down the equations of the vertical asymptote and the horizontal asymptote of the graph of f. (2 marks)
(b) [A1 C1] Find the coordinates of the points where the graph of f crosses the y-axis and the x-axis. (2 marks)
(c) [C1] State the range of f. Give a reason. (1 mark)
(d) [D2] State the greatest height and the least height of the paddle tip, and the time the wheel takes to complete one full turn. (2 marks)
(e) [A1 D1] Find the times at which the paddle tip is at a height of 4.5 cm. (2 marks)

Total for Question 2: 9 marks$mq$, $mq$(a) Vertical asymptote x = −1 [1]; as x becomes very large f(x) approaches 3 (divide numerator and denominator by x), so the horizontal asymptote is y = 3 [1].
(b) f(0) = −2/1 = −2, so (0, −2) [1]; 3x − 2 = 0, so x = 2/3 and the point is (2/3, 0) [1].
(c) f(x) can take every value except 3, because y = 3 is a horizontal asymptote that the graph never reaches [1].
(d) Greatest 7 cm and least −3 cm (that is, 3 cm below the surface) [1]; period 360 ÷ 3 = 120 seconds [1].
(e) 5 sin(3x°) + 2 = 4.5 so sin(3x°) = 0.5 [1]; 3x = 30 or 150, so x = 10 s and x = 50 s [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 2 | C 2 | D 3]]
Triangular roof panel. A triangular glass roof panel has sides of length 7.4 m, 9.1 m and 12.6 m. Diagram not to scale.
(a) [A1 C2] Calculate the size of the largest angle of the panel. Give your answer correct to 1 decimal place. (3 marks)
(b) [A1 D1] Calculate the area of the panel, to the nearest square metre. (2 marks)
(c) [D2] The panel is fixed with its longest side along the bottom edge. Calculate the perpendicular height of the panel above that edge, correct to 2 significant figures. (2 marks)

Total for Question 3: 7 marks$mq$, $mq$(a) The largest angle is opposite the 12.6 m side [1]; cos θ = (7.4² + 9.1² − 12.6²) / (2 × 7.4 × 9.1) = −21.19 / 134.68 [1]; θ = 99.1° [1].
(b) Area = ½ × 7.4 × 9.1 × sin 99.05° [1] = 33 m² (33.25) [1].
(c) Area = ½ × 12.6 × h so h = 2 × 33.25 ÷ 12.6 [1]; h = 5.3 m [1].$mq$, $mq$D$mq$),
(4, $mq$[[Q 4 | A 5 | C 3 | D 1]]
Probability and statistics. A website shows each visitor message A with probability 0.55, otherwise message B. A visitor clicks the link with probability 0.08 after message A and probability 0.12 after message B.
(a) [A1 D1] Find the probability that a randomly chosen visitor clicks the link. (2 marks)
(b) [A1 C1] A visitor clicked the link. Find the probability that this visitor was shown message B. (2 marks)
(c) [A1 C1] The waiting times of 60 callers to a help line are recorded in a cumulative frequency table.
Time t seconds: t ≤ 10 | t ≤ 20 | t ≤ 30 | t ≤ 40 | t ≤ 50 | t ≤ 60
Cumulative frequency: 6 | 18 | 36 | 50 | 58 | 60
Assume that the times are spread evenly within each class. Estimate the median waiting time. (2 marks)
(d) [A2 C1] Estimate the interquartile range of the waiting times. (3 marks)

Total for Question 4: 9 marks$mq$, $mq$(a) P(A and click) = 0.55 × 0.08 = 0.044 and P(B and click) = 0.45 × 0.12 = 0.054 [1]; P(click) = 0.098 [1].
(b) P(B | click) = P(B and click) / P(click) [1] = 0.054 / 0.098 = 27/49 = 0.551 [1].
(c) The 30th value lies in the class 20 < t ≤ 30 [1]; median ≈ 20 + (30 − 18)/(36 − 18) × 10 = 26.7 seconds [1].
(d) Lower quartile (15th value): 10 + (15 − 6)/12 × 10 = 17.5 [1]; upper quartile (45th value): 30 + (45 − 36)/14 × 10 = 36.4 [1]; interquartile range ≈ 36.4 − 17.5 = 18.9 seconds [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | A 3 | D 4]]
Networks and number notation. A courier links seven depots A to G by road. The possible roads and their lengths in km are: AB 5, AC 8, BC 4, BD 7, CD 6, CE 9, DE 3, DF 10, EF 5, EG 11, FG 2.
(a) [A1 D2] Find a minimum spanning tree for the depots. List the roads used and state the total length. (3 marks)
(b) [D2] Find the shortest route from A to G along these roads, and its length. (2 marks)
(c) [A2] A virus is a sphere of diameter 1.2 × 10⁻⁷ m. Calculate how many viruses placed in a straight line, touching, would fit along a length of 3 mm. Give your answer in the form a × 10ᵏ where 1 ≤ a < 10 and k is an integer. (2 marks)

Total for Question 5: 7 marks$mq$, $mq$(a) Method: choose the shortest roads that do not form a cycle [1]; roads FG 2, DE 3, BC 4, AB 5, EF 5, CD 6 [1]; total 25 km [1].
(b) A–B–D–E–F–G = 5 + 7 + 3 + 5 + 2 = 22 km [1]; the other routes are longer, for example A–C–E–F–G = 24 km and A–B–C–D–E–F–G = 25 km, so 22 km is the shortest [1].
(c) 3 mm = 3 × 10⁻³ m [1]; 3 × 10⁻³ ÷ 1.2 × 10⁻⁷ = 2.5 × 10⁴ [1].$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | A 5 | C 3 | D 7]]
Real-life modelling: a park pavilion. A park pavilion has a roof in the shape of a square-based pyramid. The square base ABCD has side 6 m and the apex V is 2.8 m vertically above the centre O of the base. M is the midpoint of AB. Diagram not to scale.
(a) [A1 C2] Show that the sloping edge VA has length 5.08 m, correct to 3 significant figures. (3 marks)
(b) [A2] Calculate the angle between the edge VA and the base ABCD. (2 marks)
(c) [A2 D2] Calculate the length VM, and hence the total area of the four triangular faces of the roof. (4 marks)
(d) [D3] Roof tiles are sold in packs that each cover 5 m² and cost £84. An extra 10% of the roof area is added to allow for cutting waste. Calculate the cost of the tiles. (3 marks)
(e) [C1 D2] Building rules state that the angle between each triangular face and the base must be between 40° and 45°. Show that the present design meets this rule. The client asks for the apex to be raised to 3.2 m. Determine the range of allowed heights and advise whether the client's request is possible. (3 marks)

Total for Question 6: 15 marks$mq$, $mq$(a) OA is half the diagonal: OA = √(3² + 3²) = √18 = 4.24 m [1]; VA² = 18 + 2.8² = 25.84 [1]; VA = 5.08 m [1].
(b) tan θ = 2.8 / 4.243 [1]; θ = 33.4° [1].
(c) OM = 3 m so VM = √(3² + 2.8²) = √16.84 = 4.10 m [1]; area of one face = ½ × 6 × 4.10 = 12.3 m² (12.31) [1]; total area = 4 × 12.31 [1] = 49.2 m² [1].
(d) Area to buy = 49.24 × 1.1 = 54.2 m² [1]; packs = 54.2 ÷ 5 = 10.8, so 11 packs are needed [1]; cost = 11 × £84 = £924 [1].
(e) Face angle = tan⁻¹(2.8 / 3) = 43.0°, which is between 40° and 45° [1]; allowed heights 3 tan 40° = 2.52 m up to 3 tan 45° = 3.00 m [1]; 3.2 m is above 3.00 m (the angle would be 46.8°) so the request breaks the rule and the maximum possible height is 3.0 m [1].$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | A 6 | C 3 | D 7]]
Real-life modelling: a food bank. A food bank packs x small parcels and y large parcels each day. A small parcel uses 2 kg of rice and feeds 3 people. A large parcel uses 3 kg of rice and feeds 4 people. There are 140 kg of rice available each day. Volunteers can pack at most 60 parcels per day. The food bank packs at least as many small parcels as large parcels.
(a) [A2 C1] Write down three inequalities, other than x ≥ 0 and y ≥ 0, that describe these conditions. (3 marks)
(b) [A3 C1] Find the coordinates of the four vertices of the feasible region. (4 marks)
(c) [A1 D2] The food bank wants to feed as many people as possible each day. Write down an expression for the number of people fed, and find the best numbers of small and large parcels. (3 marks)
(d) [D3] A donor increases the rice available to 160 kg each day. Find the new best plan and the number of people it feeds. (3 marks)
(e) [C1 D2] The donor offers even more rice. Evaluate whether the food bank should ask for more than 160 kg, and recommend how else the number of people fed could be increased. (3 marks)

Total for Question 7: 16 marks$mq$, $mq$(a) 2x + 3y ≤ 140 [1]; x + y ≤ 60 [1]; x ≥ y [1].
(b) (0, 0) and (60, 0) (check 2 × 60 = 120 ≤ 140) [1]; (40, 20) from x + y = 60 and 2x + 3y = 140: 2x + 2y = 120, subtract to get y = 20, x = 40 [2]; (28, 28) from x = y and 2x + 3y = 140, so 5x = 140 [1].
(c) People fed = 3x + 4y [1]; values at vertices: 0, 180, 200, 196 [1]; best plan 40 small and 20 large parcels, feeding 200 people [1].
(d) New rice limit 2x + 3y ≤ 160 changes the region to vertices (0, 0), (60, 0) and (30, 30), because the packing limit and x ≥ y now restrict the region [1]; values 0, 180, 210 [1]; best plan 30 small and 30 large parcels, feeding 210 people [1].
(e) At (30, 30) the rice used is 2 × 30 + 3 × 30 = 150 kg, so rice no longer limits the plan and more rice cannot increase the number fed [1]; the limiting conditions are the 60 parcels packing limit and x ≥ y [1]; recommend recruiting more volunteers (increasing the packing limit) instead of asking for rice [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | B 20 | C 11 | D 1]]
Investigation: a triangle pattern. Stage 0 is one shaded equilateral triangle of side 8 cm. To make the next stage, every shaded triangle is divided into four equal equilateral triangles by joining the midpoints of its sides, and the middle triangle is left unshaded. Let Sₙ be the number of shaded triangles at stage n, Lₙ the side length of each shaded triangle in cm, and Aₙ the fraction of the original area that is still shaded.
Stage 0: S = 1, L = 8, A = 1
Stage 1: S = 3, L = 4, A = 3/4
(a) [B3] Find S, L and A for stage 2 and stage 3. (3 marks)
(b) [B3] Write general rules for Sₙ, Lₙ and Aₙ in terms of n. (3 marks)
(c) [B1 C2] Explain why Aₙ = (¾)ⁿ. (3 marks)
(d) [B1 C2] The total perimeter of all the shaded triangles at stage n is Pₙ cm. Show that Pₙ = 24 × (1.5)ⁿ. (3 marks)
(e) [B3] Find the smallest stage n for which less than 10% of the original area is still shaded. (3 marks)
(f) [B3] Find the smallest stage n for which the total perimeter Pₙ is greater than 1 km (100 000 cm). (3 marks)
(g) [B4] Triangles are removed (left unshaded) at each stage. At stage k the number of triangles removed is 3^(k−1). Show that the total number removed up to stage n is (3ⁿ − 1)/2, and find this number for stage 4. (4 marks)
(h) [B2 C2] Each triangle removed at stage k has area (¼)ᵏ of the original triangle. Show that the total fraction of the original area removed up to stage n is 1 − (¾)ⁿ. (4 marks)
(i) [C3] Describe what happens to the shaded area and to the perimeter Pₙ as n becomes very large, and explain why this is surprising. (3 marks)
(j) [C2 D1] Find the side length of the shaded triangles at stage 12 in standard form. A fine pen draws a line 0.01 cm wide. Explain why stage 12 cannot be drawn accurately. (3 marks)

Total for Question 8: 32 marks$mq$, $mq$(a) S: 9 and 27 [1]; L: 2 and 1 [1]; A: 9/16 and 27/64 [1].
(b) Sₙ = 3ⁿ [1]; Lₙ = 8 × (½)ⁿ = 8/2ⁿ [1]; Aₙ = (¾)ⁿ [1].
(c) Each shaded triangle is replaced by 3 shaded triangles, each with ¼ of its area [1]; so the shaded area is multiplied by ¾ at every stage [1]; starting from 1 this gives (¾)ⁿ after n stages [1].
(d) Perimeter of one shaded triangle = 3 × 8/2ⁿ [1]; there are 3ⁿ triangles so Pₙ = 3 × 3ⁿ × 8/2ⁿ [1] = 24 × (3/2)ⁿ [1].
(e) (¾)ⁿ < 0.1 [1]; n > log 0.1 / log 0.75 = 8.004 [1]; n = 9, as (¾)⁸ = 0.1001 (just above 0.1) and (¾)⁹ = 0.0751 [1].
(f) 24 × 1.5ⁿ > 100 000 so 1.5ⁿ > 4166.7 [1]; n > log 4166.7 / log 1.5 = 20.6 [1]; n = 21 (P₂₀ ≈ 79 800 cm and P₂₁ ≈ 119 700 cm) [1].
(g) Total = 1 + 3 + 9 + … + 3^(n−1), a geometric series [1]; first term 1 and common ratio 3 [1]; sum = (3ⁿ − 1)/(3 − 1) [1]; for n = 4, (81 − 1)/2 = 40 [1].
(h) At stage k the removed area is 3^(k−1) × (¼)ᵏ = ¼ × (¾)^(k−1) [1]; the total is a geometric series with first term ¼ and common ratio ¾ [1]; sum = ¼(1 − (¾)ⁿ) / (1 − ¾) [1]; = 1 − (¾)ⁿ [1].
(i) The shaded area fraction (¾)ⁿ gets closer and closer to 0 [1]; the perimeter 24 × 1.5ⁿ grows without limit because the ratio 1.5 is greater than 1 [1]; it is surprising because almost no area remains but the total boundary length becomes enormous [1].
(j) L₁₂ = 8/2¹² = 1.95 × 10⁻³ cm [1]; this is much smaller than the pen line width of 0.01 cm [1]; so the lines would merge and the pattern is only an idealised mathematical model at high stages [1].$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- Extended Mathematics MYP 5 Full eAssessment Paper C (8 tasks, 101 marks) (101 marks)
with sub as (select id from public.subjects where slug = $mq$extended-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Extended Mathematics MYP 5 Full eAssessment Paper C (8 tasks, 101 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Extended Mathematics MYP 5 Full eAssessment Paper C (8 tasks, 101 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 4 | C 3 | D 2]]
Logarithms and bounds. In this question, logarithms without a base are to base 10.
(a) [A1 C1] Evaluate log₄ 64 + log₂(1/4). (2 marks)
(b) [A2 C1] Solve 3^(2x − 1) = 50. Give your answer correct to 3 significant figures. Show your working. (3 marks)
(c) [A1 C1] A metal sample has mass 275 g, correct to the nearest 5 g, and volume 35 cm³, correct to the nearest cm³. Calculate the lower bound and the upper bound of its density, in g/cm³, correct to 3 significant figures. (2 marks)
(d) [D2] The densities of three metals are zinc 7.14 g/cm³, iron 7.87 g/cm³ and copper 8.96 g/cm³. A student says: 'The sample must be iron.' Evaluate the student's statement. (2 marks)

Total for Question 1: 9 marks$mq$, $mq$(a) log₄ 64 = 3 and log₂(1/4) = −2 [1]; sum = 1 [1].
(b) 2x − 1 = log 50 / log 3 [1] = 3.5609 [1]; x = 2.28 [1].
(c) Lower bound = 272.5 ÷ 35.5 = 7.68 [1]; upper bound = 277.5 ÷ 34.5 = 8.04 [1].
(d) Zinc (7.14) is below the lower bound and copper (8.96) is above the upper bound, so both are ruled out; iron (7.87) lies inside the interval [1]; but the statement is too strong, because the density is only known to lie between 7.68 and 8.04, so another metal with a density in that range is possible [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 5 | C 2 | D 2]]
Graphs of functions and transformations. The graph of y = f(x) has its lowest point at (3, −2). The function g is defined by g(x) = 80 × 1.05ˣ. The function r is defined by r(x) = 6/(x + 2) − 3 for x ≠ −2.
(a) [A1 C1] Write down the coordinates of the lowest point of the graph of y = f(x − 2) + 5. (2 marks)
(b) [A1 C1] The graph of y = f(x) is transformed to y = −2f(x). State the coordinates of the turning point of the new graph and whether it is a maximum or a minimum. (2 marks)
(c) [A1 D2] The function g models the value in pounds of an investment after x years. State the range of g. Find the number of years for the value to reach £100, correct to 3 significant figures. (3 marks)
(d) [A2] Write down the equations of the asymptotes of the graph of r, and show that the graph passes through the origin. (2 marks)

Total for Question 2: 9 marks$mq$, $mq$(a) The graph moves 2 to the right [1] and 5 up, so the lowest point is (5, 3) [1].
(b) Turning point (3, 4) [1]; it is a maximum, because the reflection in the x-axis turns the lowest point into the highest point [1].
(c) Range g(x) > 0 [1]; 1.05ˣ = 1.25, so x = log 1.25 / log 1.05 [1] = 4.57 years [1].
(d) Vertical asymptote x = −2 and horizontal asymptote y = −3 [1]; r(0) = 6/2 − 3 = 0, so (0, 0) is on the graph [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 3 | C 2 | D 2]]
Radio mast. A vertical radio mast stands on level ground. From a point A the angle of elevation of the top T of the mast is 38°. From a point B, which is 60 m further from the mast than A and in the same straight line as A and the foot F of the mast, the angle of elevation of T is 29°. Diagram not to scale.
(a) [C2] Show that angle ATB is 9°. (2 marks)
(b) [A3] Use the sine rule in triangle ATB to calculate the length AT. (3 marks)
(c) [D2] Calculate the height of the mast, correct to the nearest metre. (2 marks)

Total for Question 3: 7 marks$mq$, $mq$(a) Angle TAB = 180° − 38° = 142° (angles on a straight line) [1]; angle ATB = 180° − 142° − 29° = 9° [1].
(b) AT / sin 29° = 60 / sin 9° [1]; AT = 60 × sin 29° ÷ sin 9° [1]; AT = 186 m [1].
(c) h = AT × sin 38° [1] = 114 m [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 4 | C 2 | D 2]]
Probability and statistics. A survey of 50 students asked about two activities: running (R) and cycling (C). 23 students run, 19 cycle and 11 do neither.
(a) [A1 C1] Find the number of students who do both activities. (2 marks)
(b) [A1 C1] A student who does not run is chosen at random. Find the probability that this student cycles. (2 marks)
(c) [A2] Cycling club X records the times, in minutes, of five riders over a course: 42, 45, 47, 51 and 55. The mean is 48 minutes. Calculate the standard deviation, correct to 3 significant figures. (2 marks)
(d) [D2] Club Y has a mean time of 48 minutes and a standard deviation of 6.57 minutes. A coach needs a team whose times are as consistent as possible. Decide which club to choose and justify the decision. (2 marks)

Total for Question 4: 8 marks$mq$, $mq$(a) 39 students do at least one activity (50 − 11) [1]; both = 23 + 19 − 39 = 3 [1].
(b) 27 students do not run (50 − 23) [1]; of these 19 − 3 = 16 cycle, so the probability is 16/27 [1].
(c) Squared deviations 36, 9, 1, 9, 49 sum to 104 [1]; variance 20.8, standard deviation 4.56 minutes [1].
(d) The means are equal, so average speeds are the same [1]; club X has the smaller standard deviation (4.56 < 6.57), so its times are more consistent and the coach should choose club X [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | A 2 | B 2 | C 3]]
Networks and sequences. A park has five junctions A, B, C, D and E joined by seven paths: AB, AC, BC, BD, CD, CE and DE. A keeper wants to walk along every path exactly once.
(a) [A1 C1] Write down the degree of each junction. (2 marks)
(b) [C2] Explain why the keeper cannot start and finish at the same junction, and give a walk that does cover every path exactly once. (2 marks)
(c) [B2] A museum had 4000 visitors in year 1. The number of visitors falls by 10% each year. Write a formula for the number of visitors in year n and find the number in year 6, to the nearest whole number. (2 marks)
(d) [A1] Find the first year in which the number of visitors is below 2000. (1 mark)

Total for Question 5: 7 marks$mq$, $mq$(a) A has degree 2, B has 3, C has 4, D has 3, E has 2 [2] (award 1 mark if at least three are correct).
(b) Exactly two junctions (B and D) have odd degree, so a walk using every path once must start at one of them and finish at the other [1]; for example B–A–C–B–D–C–E–D [1].
(c) u_n = 4000 × 0.9^(n − 1) [1]; u₆ = 4000 × 0.9⁵ = 2362 [1].
(d) u₇ = 2126 and u₈ = 1913, so year 8 [1].$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | A 5 | D 9]]
Real-life modelling: waiting times at a clinic. A clinic records the waiting times of 100 patients. The cumulative frequency table is:
Time t minutes: t ≤ 5 | t ≤ 10 | t ≤ 15 | t ≤ 20 | t ≤ 25 | t ≤ 30
Cumulative frequency: 12 | 41 | 73 | 90 | 97 | 100
Assume that the times are spread evenly within each class.
(a) [A1] Find the number of patients who waited more than 10 minutes but no more than 15 minutes. (1 mark)
(b) [A2 D2] Estimate the median waiting time and the interquartile range. (4 marks)
(c) [A1 D1] Estimate the mean waiting time, using the midpoint of each class. (2 marks)
(d) [D1] The clinic's target is that at least 90% of patients are seen within 20 minutes. Decide whether the target was met. (1 mark)
(e) [A1 D2] A new appointment system reduces every patient's waiting time to 80% of its previous value. State the new median, interquartile range and mean, and say why each changes in this way. (3 marks)
(f) [D3] The manager wants to publish a new target of the form 'at least 90% of patients are seen within T minutes'. Recommend a value of T and justify it. State one reason for caution. (3 marks)

Total for Question 6: 14 marks$mq$, $mq$(a) 73 − 41 = 32 patients [1].
(b) Median: 50th value in the class 10 < t ≤ 15, 10 + (50 − 41)/32 × 5 = 11.4 minutes [1]; lower quartile 5 + (25 − 12)/29 × 5 = 7.24 [1]; upper quartile 15 + (75 − 73)/17 × 5 = 15.59 [1]; interquartile range = 15.59 − 7.24 = 8.35 minutes [1].
(c) Frequencies 12, 29, 32, 17, 7, 3 with midpoints 2.5, 7.5, 12.5, 17.5, 22.5, 27.5 give a total of 1185 [1]; mean = 1185 ÷ 100 = 11.85 minutes [1].
(d) 90 of the 100 patients waited 20 minutes or less, which is exactly 90%, so the target was just met [1].
(e) New median 0.8 × 11.4 = 9.1 minutes (accept 9.12 to 9.13) [1]; new interquartile range 0.8 × 8.35 = 6.68 minutes and new mean 0.8 × 11.85 = 9.48 minutes [1]; multiplying every time by 0.8 multiplies the median, the mean and the spread by 0.8 [1].
(f) Since every time is multiplied by 0.8, the 20 minute target becomes T = 0.8 × 20 = 16 minutes [1]; justification: 90% of patients are seen within 16 minutes under the model [1]; caution: the figures come from grouped data and an assumption of even spread, so the claim should be checked against real data from the new system [1].$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | A 6 | C 3 | D 8]]
Real-life modelling: mixing animal feed. A farmer mixes x kg of feed A and y kg of feed B each day for a herd. Feed A contains 30 g of protein and 10 g of fibre per kg. Feed B contains 10 g of protein and 20 g of fibre per kg. The herd needs at least 300 g of protein and at least 200 g of fibre each day. The feeding trough holds at most 20 kg of feed. Feed A costs £1.20 per kg and feed B costs £0.90 per kg.
(a) [C2] Show that the protein requirement can be written as 3x + y ≥ 30. (2 marks)
(b) [A1 C1] Write down the inequality for the fibre requirement (in simplest form) and for the size of the trough. (2 marks)
(c) [A4] The feasible region is a triangle. Find the coordinates of its three vertices. (4 marks)
(d) [A1 D2] Find the cheapest daily mix, and state its cost. (3 marks)
(e) [D3] The prices change to £0.50 per kg for feed A and £1.10 per kg for feed B. Show that the cheapest mix changes, and find the new cheapest mix and its cost. (3 marks)
(f) [D3] Because the nutrient content of the feeds varies, the farmer wants at least 5% more protein and at least 5% more fibre than the minimum. Find the cheapest mix at the original prices and compare it with the mix in the earlier part. Justify whether the extra cost is worth paying. (3 marks)

Total for Question 7: 17 marks$mq$, $mq$(a) 30x + 10y ≥ 300 [1]; divide by 10 to get 3x + y ≥ 30 [1].
(b) 10x + 20y ≥ 200 gives x + 2y ≥ 20 [1]; x + y ≤ 20 [1].
(c) 3x + y = 30 and x + 2y = 20: solving gives (8, 6) [1]; 3x + y = 30 and x + y = 20: subtract to get 2x = 10, giving (5, 15) [1]; x + 2y = 20 and x + y = 20: subtract to get y = 0, giving (20, 0) [1]; check each vertex satisfies the third inequality (for example (5, 15) has x + 2y = 35 ≥ 20) [1].
(d) Cost C = 1.2x + 0.9y [1]; values at the vertices: (5, 15) = £19.50, (8, 6) = £15.00, (20, 0) = £24.00 [1]; cheapest mix 8 kg of A and 6 kg of B, costing £15.00 per day [1].
(e) New cost C = 0.5x + 1.1y [1]; values: (5, 15) = £19.00, (8, 6) = £10.60, (20, 0) = £10.00 [1]; the cheapest mix is now 20 kg of feed A only, costing £10.00, which is different from the earlier mix [1].
(f) New requirements 315 g protein and 210 g fibre: 3x + y ≥ 31.5 and x + 2y ≥ 21, which meet at (8.4, 6.3), which satisfies x + y = 14.7 ≤ 20 [1]; cost = 1.2 × 8.4 + 0.9 × 6.3 = £15.75, which is 75p more than £15.00 [1]; a 5% increase in cost buys a safety margin on nutrition, so it is worth paying because the herd would still receive enough nutrients if the feed is weaker [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | B 19 | C 11]]
Investigation: painted cubes. A large cube made from n × n × n identical small cubes has all six outside faces painted red. It is then taken apart. Some small cubes have 3 painted faces, some 2, some 1 and some 0. The table shows the results for the first two sizes.
n = 2: 3 faces = 8, 2 faces = 0, 1 face = 0, 0 faces = 0
n = 3: 3 faces = 8, 2 faces = 12, 1 face = 6, 0 faces = 1
(a) [B3] Find the number of small cubes with 3, 2, 1 and 0 painted faces for n = 4 and for n = 5. (3 marks)
(b) [B2] Describe two patterns in the table of results. (2 marks)
(c) [B3] Write rules, in terms of n, for the number of small cubes with 2 painted faces, with 1 painted face and with 0 painted faces. (3 marks)
(d) [C3] Explain, by thinking about the large cube, why each of these three rules works. (3 marks)
(e) [B2 C2] Let m = n − 2. Show that the total number of small cubes 8 + 12m + 6m² + m³ equals n³. (4 marks)
(f) [B1 C2] Show that the total number of painted faces, counted over all the small cubes, is 6n². (3 marks)
(g) [B2] Find the value of n for which exactly 1000 small cubes have no painted faces. (2 marks)
(h) [B2 C2] Find the smallest value of n for which more than half of the small cubes have no painted faces. Justify that no smaller value works. (4 marks)
(i) [B4] A cuboid made from 4 × 5 × 6 small cubes is painted on the outside and taken apart. Find the number of small cubes with 3, 2, 1 and 0 painted faces, and check that they add up to 120. (4 marks)
(j) [C2] State the smallest value of n for which the rules in this investigation are valid, and explain what goes wrong for n = 1. (2 marks)

Total for Question 8: 30 marks$mq$, $mq$(a) n = 4: 8, 24, 24, 8 [1]; n = 5: 8, 36, 54, 27 [1]; both rows sum to the total number of small cubes (64 and 125) [1].
(b) Any two of: the number with 3 painted faces is always 8; the number with 2 painted faces increases by 12 each time; the numbers with 1 painted face are 6 times a square number (6, 24, 54); the numbers with 0 painted faces are cube numbers (1, 8, 27) [1]; a second correct pattern [1].
(c) 2 faces: 12(n − 2) [1]; 1 face: 6(n − 2)² [1]; 0 faces: (n − 2)³ [1].
(d) Each of the 12 edges has n − 2 small cubes that are not corners, giving 12(n − 2) [1]; each of the 6 faces has an (n − 2) by (n − 2) square of small cubes that are not on an edge, giving 6(n − 2)² [1]; the unpainted cubes form an inner cube measuring (n − 2) by (n − 2) by (n − 2) [1].
(e) Total = 8 + 12(n − 2) + 6(n − 2)² + (n − 2)³ = 8 + 12m + 6m² + m³ [1]; (m + 2)³ = (m + 2)(m² + 4m + 4) [1] = m³ + 6m² + 12m + 8 [1]; and m + 2 = n so the total is n³ [1].
(f) Painted faces = 8 × 3 + 12(n − 2) × 2 + 6(n − 2)² × 1 [1]; = 24 + 24n − 48 + 6n² − 24n + 24 [1]; = 6n², which equals the six faces of the large cube each with n² small faces [1].
(g) (n − 2)³ = 1000 [1]; n − 2 = 10 so n = 12 [1].
(h) Need (n − 2)³ > n³/2 [1]; n = 9: 343 against 364.5, not enough [1]; n = 10: 512 against 500, which is more than half [1]; the fraction ((n − 2)/n)³ increases as n increases, so no smaller n works and n = 10 [1].
(i) 3 faces: 8 [1]; 2 faces: 4 × (2 + 3 + 4) = 36 [1]; 1 face: 2 × (2×3 + 3×4 + 2×4) = 52 [1]; 0 faces: 2 × 3 × 4 = 24, and 8 + 36 + 52 + 24 = 120 [1].
(j) The rules are valid for n ≥ 2 [1]; for n = 1 the rule 12(n − 2) gives −12 and (n − 2)³ gives −1, which are impossible numbers of cubes (the single cube has 6 painted faces) [1].$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- English Language and Literature MYP 5 eAssessment Paper A (3 tasks, 80 marks) (80 marks)
with sub as (select id from public.subjects where slug = $mq$english-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$English Language and Literature MYP 5 eAssessment Paper A (3 tasks, 80 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$English Language and Literature MYP 5 eAssessment Paper A (3 tasks, 80 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1.1 | A 2]]
Task 1: Analysing
Questions 1.1 to 1.4 focus on the key concept of perspective. Question 1.5 focuses on the key concept of connections.  The criteria assessed are A (Analysing) and B (Organizing). Suggested time for Questions 1.1 to 1.4: 15 minutes. Suggested time for Question 1.5: 35 minutes.

Text A: 'Declaration' (a poem, written for this paper)
This poem is spoken by a young woman at an airport border desk.

Nothing to declare, I say,
and the officer's pen hovers
over the little box marked Purpose of Visit.
 
What I carry: one suitcase, zipped like a held breath;
a jar of my mother's pickled lemons,
sealed with wax, sweating in the heat of my hand;
a name that the machine pronounces
as three separate mistakes.
 
Nothing to declare.
But my grandmother's language
is rattling in my throat like loose change,
and I am afraid that if I open my mouth
it will spill across the counter,
and they will count it, and find it
not legal tender here.
 
Stamp.
The sound is small and final,
a door closing in a distant house.
 
Welcome, he says.
I say Thank you in his accent.
It fits like a borrowed coat.
Outside, rain.
I lift the jar to my face
and breathe my whole country in.

Text B: social media post and replies (written for this paper; in the live exam this would be an on-screen image)
[Visual: a square photograph shows a cluttered kitchen table. On it are a steaming pot, three mismatched bowls, and a hand-written card reading 'Welcome Table - every Sunday - bring nothing, bring anyone'. Warm yellow light, shot from above. A hand reaches in from the edge of the frame holding a ladle.]

@thewelcometable (Nour A.)
"Two years ago I arrived in this city knowing nobody. Nobody asked me my story, they just asked if I was hungry. 🍲 So now it's my turn. Every Sunday, my flat, soup for whoever needs it. No forms. No questions. Just a seat. #WelcomeTable #SundaySoup #NewNeighbours"

♥ 2,431 likes · 318 shares

Replies:
@marcus_k: "Crying at my desk. Sat alone for a year. See you Sunday."
@old_mrs_hale: "I will bring a lemon cake. Is that allowed?"
@nour.a replied to @old_mrs_hale: "Everything is allowed. That's the whole point."
@dan_t_1987: "Nice idea but where does it end? Who pays for all this soup?"
@nour.a replied to @dan_t_1987: "Nobody counts a pot of soup. Come and see for yourself."

Q 1.1 Comment on the use of the word 'declare' and the title of Text A. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies the idea of declaring or customs without explanation, e.g. the title refers to an airport. [1] Level 2 (2 marks): comments on the title or repeated phrase with some explanation, e.g. 'Nothing to declare' repeats like a refrain; officially she has nothing to declare, but the poem shows she carries language, memory and identity that cannot be declared on a form. [1] Award 0 for no or incorrect reference to the text.$mq$, $mq$A$mq$),
(2, $mq$[[Q 1.2 | A 3]]
Refer to Text A (printed in Question 1.1). Explain the effect of the simile 'a name that the machine pronounces / as three separate mistakes'. Include a second image from stanza two in your answer. (3 marks)

Note: the simile is in stanza two; the second image may be any other figurative expression in that stanza.$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies a figure of speech without developing the effect, e.g. the machine gets her name wrong. [1] Level 2 (2 marks): describes an effect with some explanation, e.g. the mispronounced name suggests technology and the new country fail to recognise her identity. [1] Level 3 (3 marks): explains the effect consistently with well-chosen quotation, e.g. 'three separate mistakes' turns her name from something whole into errors, so the speaker feels she is the problem; the image of the language 'rattling in my throat like loose change' links her heritage to something small and worthless in the new place, adding to the sense of shame. [1] Accept 'zipped like a held breath' as the second image.$mq$, $mq$A$mq$),
(3, $mq$[[Q 1.3 | A 2]]
Refer to Text B (printed in Question 1.1). Describe the purpose of the hashtags and the hand-written card in the post. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a purpose without explanation, e.g. the hashtags help people find the post. [1] Level 2 (2 marks): describes a purpose with an example, e.g. the hashtags #WelcomeTable and #NewNeighbours make a recognisable brand and let like-minded people find and share the event, while the card 'bring nothing, bring anyone' reads as personal and informal, inviting trust. [1]$mq$, $mq$A$mq$),
(4, $mq$[[Q 1.4 | A 3]]
Refer to Text B (printed in Question 1.1). Analyse the effect of the replies from @dan_t_1987 and @nour.a. (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies an effect with no development, e.g. one person disagrees. [1] Level 2 (2 marks): describes the effect of the exchange with some justification, e.g. the sceptical question gives a realistic opposing voice, making the project look tested. [1] Level 3 (3 marks): analyses the effect consistently with precise reference, e.g. the question 'where does it end? Who pays?' voices economic worry, and Nour's short reply 'Nobody counts a pot of soup' answers calmly with a metaphor of generosity, then invites the sceptic ('Come and see for yourself') rather than arguing, which reinforces her inclusive tone and persuades readers to trust her. [1]$mq$, $mq$A$mq$),
(5, $mq$[[Q 1.5 | A 10 | B 10]]
Refer to Text A and Text B (printed in Question 1.1). Compare and contrast how the two texts explore what it means to arrive in a new place. (Approximately 350 words) (20 marks)

Criterion A (Analysing) is worth 10 marks and Criterion B (Organizing) is worth 10 marks.$mq$, $mq$Criterion A (10 marks) and Criterion B (10 marks), 20 marks in total. Criterion A (10 marks): 9 to 10 marks for effective, perceptive analysis of content, language, structure and technique in both texts with extensive, well-chosen evidence; 6 to 8 for considerable analysis with sufficient, relevant evidence; 3 to 5 for adequate analysis with some evidence; 1 to 2 for limited analysis with few or no examples. Indicative content: Text A uses first-person free verse, a refrain ('Nothing to declare'), extended contrast between official language and private feeling, sensory imagery (pickled lemons, wax, rain), simile ('like a borrowed coat', 'like loose change') and a final turn of private comfort ('breathe my whole country in'). The tone moves from anxiety to quiet resilience and the poem stays internal and solitary. Text B uses multimodal features: overhead warm-lit photograph, the hand with a ladle (offering), informal direct address, emoji, imperative short sentences ('No forms. No questions. Just a seat'), hashtags and the dialogue of replies. Arrival is shown as community and welcome after earlier isolation. Contrast: loss of identity and fear of rejection versus rebuilding belonging by giving hospitality; private reflection versus public persuasion; both use food as a symbol of home and connection (lemons, soup). Award up to [10] for Criterion A. Criterion B (10 marks): 9 to 10 marks for effective organisation: clear structure, comparison and contrast sustained throughout, effective linking and a conclusion; 6 to 8 for a considerable degree of organisation with sustained comparison; 3 to 5 for an adequate degree of organisation with some comparison; 1 to 2 for limited organisation, with the texts mostly treated separately. Indicative content: a clear introduction naming both texts; a sustained point-by-point or thematic structure; comparative connectives; paragraphs that each pair evidence from both texts; a conclusion that evaluates the shared use of food and the contrasting emotional outcome. Award up to [10] for Criterion B.$mq$, $mq$A$mq$),
(6, $mq$[[Q 2.1 | C 10 | D 10]]
Task 2: Producing literary text
This task focuses on the key concept of creativity. The criteria assessed are C (Producing text) and D (Using language).

Image 1 (described in words): a night-time view from inside a train carriage. A window is misted over and someone has drawn a small house in the condensation with one finger. Beyond the glass, blurred orange lights stream past. A child's backpack sits on the seat, with one strap trailing on the floor.
Image 2 (described in words): an empty classroom at dusk. Every chair is stacked on its desk except one, which stands alone in the middle of the room facing the whiteboard. On the board, half-rubbed-out, is the single word 'Tomorrow'.

Using one of the images, write the opening of a story set in a dystopian society in which a young character notices something the authorities want hidden. You may consider purpose, characterisation, setting, mood and point of view. State which image you are using before you start. (Approximately 350 words) (20 marks)$mq$, $mq$Criterion C (10 marks): 9 to 10 marks for a high degree of insight and imagination, perceptive stylistic choices and extensive precise detail; 6 to 8 for considerable insight and imagination, thoughtful choices and sufficient detail; 3 to 5 for some insight and imagination, some stylistic choices and some detail; 1 to 2 for limited insight, few stylistic choices and little detail. Indicative content: a named image used meaningfully; a controlled dystopian setting built through telling detail (rules, surveillance, scarcity) rather than explanation; a developed character and viewpoint; a hook or revelation; atmosphere created through imagery, sentence length and pacing. A response that uses neither image nor the prompt scores 0 for C. Award up to [10] for Criterion C. Criterion D (10 marks): 9 to 10 marks for an effective range of vocabulary and sentence structures, consistently suitable register and high accuracy with only minor errors; 6 to 8 for a varied range, considerable accuracy and errors that do not hinder communication; 3 to 5 for an adequate range, a degree of accuracy and errors that sometimes hinder communication; 1 to 2 for a limited range, with errors that often hinder communication. Indicative content: precise, varied vocabulary, deliberate sentence variety (short sentences for tension, longer for description), figurative language, consistent tense and point of view, accurate punctuation of dialogue if used. Award up to [10] for Criterion D.$mq$, $mq$C$mq$),
(7, $mq$[[Q 3.1 | B 10 | C 10 | D 10]]
Task 3: Producing non-literary text
This task focuses on the key concept of communication. You will create a piece of non-literary writing in relation to the global context identities and relationships: identities, and personal, physical, social and cultural expression. The criteria assessed are B (Organizing), C (Producing text) and D (Using language).

You have recently moved to a new country with your family. Write an informal letter to a friend in your old home town describing the first month, what you miss, and how your sense of who you are has changed. (Approximately 350 words) (30 marks)$mq$, $mq$Criterion B (10 marks): organisation suited to an informal letter: address or date, greeting, clear paragraphs sequencing first impressions, losses and change, and a warm sign-off; 9 to 10 effective, 6 to 8 considerable, 3 to 5 adequate, 1 to 2 limited. Award up to [10] for Criterion B. Criterion C (10 marks): perspective on identity shown through insight, personal detail and examples (language, food, school, friendships); 9 to 10 high degree of insight and extensive detail, 6 to 8 considerable, 3 to 5 some, 1 to 2 limited. Award up to [10] for Criterion C. Criterion D (10 marks): conversational register with control, varied sentences, humour or emotion, rhetorical questions or direct address to the friend, accurate grammar and punctuation; 9 to 10 high accuracy and effective register, 6 to 8 considerable, 3 to 5 a degree, 1 to 2 minimal. Award up to [10] for Criterion D.$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- English Language and Literature MYP 5 eAssessment Paper B (3 tasks, 80 marks) (80 marks)
with sub as (select id from public.subjects where slug = $mq$english-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$English Language and Literature MYP 5 eAssessment Paper B (3 tasks, 80 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$English Language and Literature MYP 5 eAssessment Paper B (3 tasks, 80 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1.1 | A 3]]
Task 1: Analysing
Questions 1.1 to 1.4 focus on the key concept of communication. Question 1.5 focuses on the key concept of perspective. The criteria assessed are A (Analysing) and B (Organizing). Suggested time for Questions 1.1 to 1.4: 15 minutes. Suggested time for Question 1.5: 35 minutes.

Text A: 'We Are Not Your Weather' (a speech, written for this paper)
This is a transcript of a speech given by a sixteen-year-old student, Tamsin Reyes, to a town council meeting about plans to build on a flood plain beside the river.

Good evening, councillors.

You have a folder in front of you. It is blue, and it is thick, and it contains eleven reports. I have read them all. I would like to tell you what they do not say.

They do not say that on the fourteenth of October the river came up Mill Road in forty minutes. They do not say that my neighbour, Mr Okafor, carried his wife's wheelchair upstairs while the water climbed the stairs behind him. They do not say what a house smells like three weeks after.

You will tell me the plan is safe. You will tell me the drains have been upgraded. You will tell me we cannot stand in the way of progress. Progress. Let us be honest about that word. Progress for whom? Progress to where? A road that leads into a lake is not progress; it is a very expensive way of drowning.

We are not asking for miracles. We are asking you to read the map the river has already drawn. For ten thousand years it has told us where it wants to go. For ten thousand years we have been polite enough to listen. And now, in one meeting, in one folder, you are about to tell it to move.

It will not move.

So I ask you tonight, not as a protest, not as a statistic, but as a neighbour: when the next flood comes, whose name do you want on the page? Because the water will not read your reports. But my generation will.

Thank you.

Text B: a magazine advertisement (written for this paper; in the live exam this would be an image)
[Visual: a full-page photograph taken from above of a suburban street at dusk. Every house is exactly the same grey shape, with identical lit windows. In the centre of the page, one house is painted bright yellow and has a small vegetable garden in front. Soft fog sits at the end of the street. The colours are cold except for the yellow house.]
Headline, large white serif letters across the top: BE THE EXCEPTION.
Sub-headline in smaller italics: Not everything that stands out has to shout.
Body text, small sans-serif font bottom left: At Fernhill Homes we build 40 individual houses on the edge of the Meridian Valley. No two alike. Each with a garden, a view and a story. From £289,000.
Strapline in bold capitals beside a logo of a small tree: GROW WHERE YOU ARE PLANTED.
Website: fernhillhomes.example

Q 1.1 Explain the effect of the repeated structure 'They do not say...' in the second paragraph of Text A. (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies the repetition without explaining the effect, e.g. she says 'They do not say' three times. [1] Level 2 (2 marks): describes an effect with some example, e.g. the anaphora builds a list of what is missing from the reports and makes the councillors seem careless. [1] Level 3 (3 marks): explains the effect consistently with precise quotation, e.g. the repeated negative 'They do not say...' contrasts official paperwork with human detail (Mr Okafor, the wheelchair, the smell), building pressure to a climax and making the audience feel guilt as well as sympathy. [1]$mq$, $mq$A$mq$),
(2, $mq$[[Q 1.2 | A 2]]
Refer to Text A (printed in Question 1.1). Comment on the speaker's use of the phrase 'a very expensive way of drowning'. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a meaning without development, e.g. the phrase means the plan is a bad idea. [1] Level 2 (2 marks): comments with some explanation, e.g. the sharp, dark metaphor-like phrase turns an economic argument ('expensive') into a life-and-death warning and shows her sarcasm toward the council's idea of progress. [1]$mq$, $mq$A$mq$),
(3, $mq$[[Q 1.3 | A 3]]
Refer to Text B (printed in Question 1.1). Analyse the effect of colour and composition in the advertisement. (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies colour or composition without explaining its effect, e.g. one house is yellow. [1] Level 2 (2 marks): describes an effect with some justification, e.g. the cold grey of the street makes the single yellow house stand out as warm and attractive. [1] Level 3 (3 marks): analyses the effect consistently with precise reference, e.g. the overhead view of identical grey houses suggests dull conformity, and the bright yellow house with the vegetable garden is placed at the centre of the page so readers see themselves as the individual who escapes sameness, which supports the headline 'BE THE EXCEPTION'. [1] Accept the fog, the dusk lighting or the white serif headline as relevant details.$mq$, $mq$A$mq$),
(4, $mq$[[Q 1.4 | A 2]]
Refer to Text B (printed in Question 1.1). Describe the purpose of the strapline 'GROW WHERE YOU ARE PLANTED'. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a purpose without explanation, e.g. it is the advert's slogan. [1] Level 2 (2 marks): describes a purpose with an example, e.g. the botanical metaphor, supported by the tree logo, links home ownership to natural growth and stability and ends the advert with a memorable, positive message encouraging readers to commit to the new development. [1]$mq$, $mq$A$mq$),
(5, $mq$[[Q 1.5 | A 10 | B 10]]
Refer to Text A and Text B (printed in Question 1.1). Compare and contrast how the two texts present attitudes towards building and the natural environment. (Approximately 350 words) (20 marks)

Criterion A (Analysing) is worth 10 marks and Criterion B (Organizing) is worth 10 marks.$mq$, $mq$Criterion A (10 marks) and Criterion B (10 marks), 20 marks in total. Criterion A (10 marks): 9 to 10 marks for effective, perceptive analysis of content, language, structure and technique in both texts with extensive, well-chosen evidence; 6 to 8 for considerable analysis with sufficient, relevant evidence; 3 to 5 for adequate analysis with some evidence; 1 to 2 for limited analysis with few or no examples. Indicative content: Text A (spoken, persuasive, emotive): direct address ('councillors'), anaphora, rule of three ('You will tell me...'), rhetorical questions ('Progress for whom?'), personal anecdote (Mr Okafor), personification of the river ('it wants to go', 'It will not move'), short climactic sentence, closing appeal to the future ('my generation will'). It presents building on the flood plain as dangerous arrogance and respects nature as a force. Text B (visual and written advertising): image of conformity vs individuality, cold/warm colour contrast, imperative headline, minimal body text, price, 'a garden, a view and a story', tree logo and metaphor. It presents nature as a pleasant feature to be sold (gardens, views) and says nothing of risk; the valley setting is a selling point. Contrast: warning vs enticement; community vs individual; collective memory of loss vs aspirational lifestyle; formal and moral register vs light, aspirational register. Similarity: both use emotive appeals and a clear call to the audience. Award up to [10] for Criterion A. Criterion B (10 marks): 9 to 10 marks for effective organisation: clear structure, comparison and contrast sustained throughout, effective linking and a conclusion; 6 to 8 for a considerable degree of organisation with sustained comparison; 3 to 5 for an adequate degree of organisation with some comparison; 1 to 2 for limited organisation, with the texts mostly treated separately. Indicative content: clear introduction with a thesis about the opposing viewpoints; either an integrated or text-by-text structure with explicit comparison; topic sentences; connectives of contrast and similarity; conclusion judging how persuasion differs in speech and advert. Award up to [10] for Criterion B.$mq$, $mq$A$mq$),
(6, $mq$[[Q 2.1 | C 10 | D 10]]
Task 2: Producing literary text
This task focuses on the key concept of creativity. The criteria assessed are C (Producing text) and D (Using language).

Image 1 (described in words): a seaside pier at the end of winter. Half the planks are missing and the sea is visible through the gaps. A single deckchair stands upright at the far end, facing the horizon. A flock of starlings wheels above it in a dark spiral.
Image 2 (described in words): a market stall in the early morning. A woman in a patterned headscarf arranges mirrors on a trestle table; each mirror reflects a different part of the street, so that together they make a broken map of the neighbourhood. A cat sleeps beneath the table.

Using one of the images, write a poem or a prose piece that explores memory and the passing of time. You may consider purpose, imagery, mood, structure and voice. State which image you are using before you start. (Approximately 350 words, or a poem of about 20 to 30 lines) (20 marks)$mq$, $mq$Criterion C (10 marks): 9 to 10 marks for a high degree of insight and imagination, perceptive stylistic choices and extensive precise detail; 6 to 8 for considerable insight and imagination, thoughtful choices and sufficient detail; 3 to 5 for some insight and imagination, some stylistic choices and some detail; 1 to 2 for limited insight, few stylistic choices and little detail. Indicative content: a named image used as a springboard; a central idea about memory or time developed with symbolism (the pier as ruin, the mirrors as fragments); a consistent voice; structural choices such as stanza shape, repetition or a turn at the end; sensory imagery. A response that uses neither image nor the prompt scores 0 for C. Award up to [10] for Criterion C. Criterion D (10 marks): 9 to 10 marks for an effective range of vocabulary and sentence structures, consistently suitable register and high accuracy with only minor errors; 6 to 8 for a varied range, considerable accuracy and errors that do not hinder communication; 3 to 5 for an adequate range, a degree of accuracy and errors that sometimes hinder communication; 1 to 2 for a limited range, with errors that often hinder communication. Indicative content: figurative language (metaphor, personification), deliberate rhythm, line breaks or sentence length, precise verbs, controlled tone, accuracy appropriate to the form chosen. Award up to [10] for Criterion D.$mq$, $mq$C$mq$),
(7, $mq$[[Q 3.1 | B 10 | C 10 | D 10]]
Task 3: Producing non-literary text
This task focuses on the key concept of perspective. You will create a piece of non-literary writing in relation to the global context fairness and development: rights, rules and responsibilities.

The local council in your town plans to close the public library and sell the building for flats. Write a blog post (for a youth community website) arguing for or against the plan. The criteria assessed are B (Organizing), C (Producing text) and D (Using language). (Approximately 350 words) (30 marks)$mq$, $mq$Criterion B (10 marks): organisation suited to a blog post: engaging title, short paragraphs with subheadings if wished, a clear sequence of arguments, a call to action, and a personal voice; 9 to 10 effective, 6 to 8 considerable, 3 to 5 adequate, 1 to 2 limited. Award up to [10] for Criterion B. Criterion C (10 marks): perspective on fairness and responsibility shown through insight and relevant detail (access to learning, who benefits, rights of young people, alternatives); 9 to 10 high degree of insight and extensive detail, 6 to 8 considerable, 3 to 5 some, 1 to 2 limited. Award up to [10] for Criterion C. Criterion D (10 marks): chatty but controlled register, persuasive devices (anecdote, rhetorical questions, statistics that are plausible, direct address), varied sentence structures, accurate grammar and punctuation; 9 to 10 high accuracy and effective register, 6 to 8 considerable, 3 to 5 a degree, 1 to 2 minimal. Award up to [10] for Criterion D.$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);
commit;
