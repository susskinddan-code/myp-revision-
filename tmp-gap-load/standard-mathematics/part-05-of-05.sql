-- Part 5 of 5: 2 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Networks, Algorithms and Optimisation > Linear Programming
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Networks, Algorithms and Optimisation$mq$, 5, 4 from public.subjects s where s.slug = $mq$standard-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Linear Programming$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$standard-mathematics$mq$ and p.grade = 5 and p.name = $mq$Networks, Algorithms and Optimisation$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Linear Programming$mq$ and p.name = $mq$Networks, Algorithms and Optimisation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Why do linear programming problems include x ≥ 0 and y ≥ 0?$mq$, $mq$["The quantities cannot be negative","The lines must pass through the origin","The objective must be maximised","The region must be triangular"]$mq$, 0, $mq$x and y usually count real items, such as tables or loaves, so they cannot be below zero.$mq$, $mq$easy$mq$),
($mq$What are the intercepts of the line x + y = 10?$mq$, $mq$["(5, 5) and (10, 10)","(0, 0) and (10, 10)","(1, 0) and (0, 1)","(10, 0) and (0, 10)"]$mq$, 3, $mq$Set y = 0 to get x = 10 and set x = 0 to get y = 10.$mq$, $mq$easy$mq$),
($mq$What is the feasible region?$mq$, $mq$["The line with the highest profit","The set of points that satisfy at least one constraint","The set of points that satisfy all the constraints","The point with the largest x"]$mq$, 2, $mq$The feasible region is where all the inequalities hold at once. Only points inside it are allowed.$mq$, $mq$easy$mq$),
($mq$The profit is P = 3x + 2y. Find P at the point (4, 5).$mq$, $mq$["14","22","20","9"]$mq$, 1, $mq$P = 3 × 4 + 2 × 5 = 12 + 10 = 22.$mq$, $mq$easy$mq$),
($mq$Where does the maximum or minimum of the objective function occur in a feasible region?$mq$, $mq$["At a vertex (corner point)","At the centre of the region","At the origin","Anywhere inside"]$mq$, 0, $mq$The objective function is linear, so its largest and smallest values are found at corner points of the region.$mq$, $mq$easy$mq$),
($mq$A bakery makes x loaves and y cakes in one day. The oven can bake at most 40 items in total. Which inequality shows this?$mq$, $mq$["x + y ≥ 40","xy ≤ 40","x − y ≤ 40","x + y ≤ 40"]$mq$, 3, $mq$The total x + y must not exceed 40, so it is less than or equal to 40.$mq$, $mq$medium$mq$),
($mq$'There must be at least twice as many loaves (x) as cakes (y).' Which inequality represents this?$mq$, $mq$["y ≥ 2x","x ≤ 2y","x ≥ 2y","x + y ≥ 2"]$mq$, 2, $mq$Loaves are at least 2 times the number of cakes, so x ≥ 2y. Mixing the variables gives the opposite condition.$mq$, $mq$medium$mq$),
($mq$The feasible region for x + y ≤ 8, x ≤ 5, x ≥ 0, y ≥ 0 has vertices (0, 0), (5, 0), (5, 3) and (0, 8). Maximise P = 2x + y.$mq$, $mq$["10","13","8","15"]$mq$, 1, $mq$Test each vertex: (0, 0) gives 0, (5, 0) gives 10, (5, 3) gives 13, (0, 8) gives 8. The maximum is 13.$mq$, $mq$medium$mq$),
($mq$Find the point where x + y = 10 and 2x + y = 16 intersect.$mq$, $mq$["(6, 4)","(4, 6)","(8, 2)","(3, 7)"]$mq$, 0, $mq$Subtract the first from the second: x = 6. Then y = 10 − 6 = 4. Check: 2 × 6 + 4 = 16.$mq$, $mq$medium$mq$),
($mq$Which point satisfies 2x + 3y ≤ 12?$mq$, $mq$["(4, 3)","(5, 2)","(2, 4)","(3, 2)"]$mq$, 3, $mq$(3, 2): 6 + 6 = 12 ≤ 12, true (on the boundary). (4, 3) gives 17, (5, 2) gives 16, (2, 4) gives 16, all too big.$mq$, $mq$medium$mq$),
($mq$A region is defined by x + y ≥ 10, x ≥ 2, y ≥ 1, with corner points (9, 1) and (2, 8). The cost is C = 4x + 6y. Which gives the minimum cost over the corners?$mq$, $mq$["(2, 8) with cost 56","(9, 1) with cost 54","(9, 1) with cost 42","(2, 8) with cost 42"]$mq$, 2, $mq$At (9, 1) cost = 36 + 6 = 42. At (2, 8) cost = 8 + 48 = 56. The smaller value, 42, occurs at (9, 1).$mq$, $mq$medium$mq$),
($mq$The optimal corner is (4.6, 3.2) but the items must be whole numbers. What should you do?$mq$, $mq$["Round both numbers up","Test whole-number points inside the region near that corner","Use the nearest corner","Ignore the integer condition"]$mq$, 1, $mq$Rounding up may leave the feasible region. Check nearby integer points that satisfy every constraint and compare their objective values.$mq$, $mq$medium$mq$),
($mq$An objective line P = 3x + 2y is drawn on a graph. What is its gradient?$mq$, $mq$["−3/2","3/2","−2/3","3"]$mq$, 0, $mq$Rearrange: y = (P − 3x) ÷ 2 = −1.5x + P/2. The gradient is −3/2. Sliding this line outward finds the optimal vertex.$mq$, $mq$medium$mq$),
($mq$A factory makes x tables and y chairs. Constraints: 2x + y ≤ 20 (work hours), x + y ≤ 12 (wood), x ≥ 0, y ≥ 0. The corner points are (0, 0), (10, 0), (8, 4) and (0, 12). Profit is $50 per table and $30 per chair. What is the maximum profit?$mq$, $mq$["$500","$360","$400","$520"]$mq$, 3, $mq$P = 50x + 30y. (10, 0) gives 500, (8, 4) gives 400 + 120 = 520, (0, 12) gives 360. The maximum is $520.$mq$, $mq$hard$mq$),
($mq$A factory makes x tables and y chairs. Constraints: 2x + y ≤ 20 (work hours), x + y ≤ 12 (wood), x ≥ 0, y ≥ 0. The corner points are (0, 0), (10, 0), (8, 4) and (0, 12). Profit is $50 per table and $30 per chair. How many tables should be made to achieve the maximum profit?$mq$, $mq$["10","4","8","12"]$mq$, 2, $mq$The best corner is (8, 4), meaning 8 tables and 4 chairs.$mq$, $mq$hard$mq$),
($mq$A factory makes x tables and y chairs. Constraints: 2x + y ≤ 20 (work hours), x + y ≤ 12 (wood), x ≥ 0, y ≥ 0. The corner points are (0, 0), (10, 0), (8, 4) and (0, 12). Profit is $50 per table and $30 per chair. Now the profit per chair rises to $60 (table profit stays $50). What is the new optimal plan and profit?$mq$, $mq$["8 tables, 4 chairs, $640","0 tables, 12 chairs, $720","10 tables, 0 chairs, $500","4 tables, 8 chairs, $440"]$mq$, 1, $mq$P = 50x + 60y. (10, 0) gives 500, (8, 4) gives 640, (0, 12) gives 720. The best is 12 chairs and no tables.$mq$, $mq$hard$mq$),
($mq$A diet needs 2x + y ≥ 10 and x + 2y ≥ 8 (x, y ≥ 0), with cost C = 3x + 2y. The corner points are (0, 10), (4, 2) and (8, 0). What is the minimum cost?$mq$, $mq$["16","20","24","14"]$mq$, 0, $mq$C at (0, 10) = 20, at (4, 2) = 12 + 4 = 16, at (8, 0) = 24. The minimum is 16 at (4, 2).$mq$, $mq$hard$mq$),
($mq$Region: x + y ≤ 6, x ≤ 4, y ≤ 4, x ≥ 0, y ≥ 0, with corners (0, 0), (4, 0), (4, 2), (2, 4), (0, 4). To maximise P = x + y, which is true?$mq$, $mq$["The maximum is 8 at (4, 4)","The maximum is 6 only at (4, 2)","There is no maximum","The maximum is 6, reached at every point on the edge from (4, 2) to (2, 4)"]$mq$, 3, $mq$P = x + y equals 6 at both (4, 2) and (2, 4), and the objective line is parallel to the boundary x + y = 6, so every point on that edge is optimal. (4, 4) is not feasible because 8 > 6.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Linear Programming$mq$ and p.name = $mq$Networks, Algorithms and Optimisation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Constraint$mq$, $mq$An inequality that limits the variables, such as x + y ≤ 40.$mq$),
($mq$Feasible region$mq$, $mq$The set of points that satisfy ALL the constraints at once.$mq$),
($mq$Objective function$mq$, $mq$The quantity to maximise or minimise, such as profit P = 50x + 30y.$mq$),
($mq$Why check vertices only?$mq$, $mq$The best value of a linear objective function occurs at a corner of the feasible region.$mq$),
($mq$Non-negativity constraints$mq$, $mq$x ≥ 0 and y ≥ 0 because you cannot make a negative quantity.$mq$),
($mq$Finding a vertex$mq$, $mq$Solve the two boundary equations simultaneously, such as 2x + y = 20 and x + y = 12 giving (8, 4).$mq$),
($mq$Translating words$mq$, $mq$'At most' is ≤. 'At least' is ≥. 'No more than' is ≤.$mq$),
($mq$Multiple optimal solutions$mq$, $mq$If the objective line is parallel to an edge of the region, every point on that edge gives the same best value.$mq$),
($mq$Integer constraint$mq$, $mq$If items must be whole, check integer points near the best vertex that lie inside the region.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Linear Programming$mq$ and p.name = $mq$Networks, Algorithms and Optimisation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The idea
**Linear programming** helps find the best outcome, such as the largest profit or smallest cost, when resources are limited. You describe the limits with linear inequalities called **constraints**, draw the region where all of them hold, and then find the best point in that region.

## Steps
1. **Define variables**: let x be the number of tables and y the number of chairs.
2. **Write constraints** as inequalities. "At most 40 items" gives x + y ≤ 40. "At least twice as many loaves as cakes" gives x ≥ 2y. Include x ≥ 0 and y ≥ 0 because you cannot make a negative number of items.
3. **Draw the lines** for each boundary. Find the intercepts: for x + y = 12 use (12, 0) and (0, 12). Use a solid line for ≤ or ≥.
4. **Shade the unwanted side** and leave the **feasible region** unshaded, or shade the feasible side, but state which you did. Test the origin to check which side is valid.
5. **Find the vertices** (corner points). Read from the graph or solve simultaneous equations. For 2x + y = 20 and x + y = 12, subtracting gives x = 8, then y = 4.
6. **Write the objective function**, such as P = 50x + 30y.
7. **Evaluate at each vertex** and pick the largest (maximise) or smallest (minimise).

## Worked example
A factory makes x tables and y chairs. Work: 2x + y ≤ 20. Wood: x + y ≤ 12. The vertices of the feasible region are (0, 0), (10, 0), (8, 4) and (0, 12). With profit P = 50x + 30y the values are 0, 500, 520 and 360. The maximum profit is $520 with 8 tables and 4 chairs. If the profit per chair rises to $60, the values become 0, 500, 640 and 720, so the best plan switches to 12 chairs and no tables. This shows how the optimum depends on the objective function.

## Why vertices?
The objective function is a straight line P = ax + by. Sliding it across the region, the last point it touches is a corner (or a whole edge if it is parallel to a boundary). So you only need to test the corners. If the objective is parallel to an edge, every point on that edge is optimal.

## Integer solutions
If items must be whole numbers and the best vertex has fractional coordinates, check the nearby integer points inside the region. Do not simply round, because the rounded point may break a constraint.

## Common mistakes
- Using the wrong inequality direction when translating words.
- Forgetting non-negativity constraints.
- Reading vertex coordinates by eye instead of solving the equations.
- Testing only one vertex.
- Not answering in the context, for example giving a value of P without saying how many tables to make.

## How this is examined
Tasks set a production, diet or transport scenario with a table of resources. You write inequalities, graph them, find the feasible region, optimise, and then evaluate the solution: is it realistic, what if costs change, are whole numbers needed?

Exam tip: Write the constraints in a numbered list, label each line on your graph with the same number, and keep a small table of vertices and objective values. It makes your method clear and checkable.$mq$ from st;

-- Rational and Trigonometric Functions > Rational Functions and Trigonometric Graphs
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Rational and Trigonometric Functions$mq$, 5, 5 from public.subjects s where s.slug = $mq$standard-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Rational Functions and Trigonometric Graphs$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$standard-mathematics$mq$ and p.grade = 5 and p.name = $mq$Rational and Trigonometric Functions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Rational Functions and Trigonometric Graphs$mq$ and p.name = $mq$Rational and Trigonometric Functions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What are the asymptotes of the graph of y = 1/x?$mq$, $mq$["x = 0 and y = 0","x = 1 and y = 1","x = 0 only","y = 1 only"]$mq$, 0, $mq$The function is undefined at x = 0, so the y-axis is a vertical asymptote. As x gets very large, y gets very close to 0, so the x-axis is a horizontal asymptote.$mq$, $mq$easy$mq$),
($mq$For which value of x is y = 1/(x − 3) undefined?$mq$, $mq$["x = −3","x = 0","x = 1/3","x = 3"]$mq$, 3, $mq$The denominator is zero when x − 3 = 0, so x = 3. Division by zero is not possible.$mq$, $mq$easy$mq$),
($mq$What is the period of y = sin x, in degrees?$mq$, $mq$["180°","90°","360°","720°"]$mq$, 2, $mq$The sine graph repeats every 360°.$mq$, $mq$easy$mq$),
($mq$What is the amplitude of y = 3 sin x?$mq$, $mq$["1","3","6","1/3"]$mq$, 1, $mq$The amplitude is the maximum distance from the middle line, which is 3 here. The graph oscillates between −3 and 3.$mq$, $mq$easy$mq$),
($mq$What is the maximum value of y = cos x?$mq$, $mq$["1","0","90","360"]$mq$, 0, $mq$Cosine oscillates between −1 and 1, so its greatest value is 1 (at x = 0° and x = 360°).$mq$, $mq$easy$mq$),
($mq$What are the asymptotes of y = 2/(x + 1)?$mq$, $mq$["x = 1 and y = 0","x = −1 and y = 2","x = 2 and y = 1","x = −1 and y = 0"]$mq$, 3, $mq$The denominator is zero when x = −1, so x = −1 is a vertical asymptote. As x grows large the fraction tends to 0, so y = 0 is horizontal.$mq$, $mq$medium$mq$),
($mq$What is the equation of the horizontal asymptote of y = 1/x + 2?$mq$, $mq$["y = 0","y = 1","y = 2","x = 2"]$mq$, 2, $mq$As x gets large, 1/x gets close to 0, so y gets close to 2. The +2 shifts the graph up by 2 units, and the asymptote moves with it.$mq$, $mq$medium$mq$),
($mq$What is the period of y = sin 2x, in degrees?$mq$, $mq$["720°","180°","360°","90°"]$mq$, 1, $mq$For y = sin(bx), the period is 360° ÷ b. Here 360° ÷ 2 = 180°.$mq$, $mq$medium$mq$),
($mq$What is the range of y = 4 cos x + 1?$mq$, $mq$["−3 ≤ y ≤ 5","−4 ≤ y ≤ 4","−1 ≤ y ≤ 1","0 ≤ y ≤ 5"]$mq$, 0, $mq$4 cos x ranges from −4 to 4. Adding 1 shifts everything up: −3 to 5.$mq$, $mq$medium$mq$),
($mq$Which description fits the graph of y = 6/x?$mq$, $mq$["A straight line through the origin","Two curves in the second and fourth quadrants","A single curve through the origin","Two separate curves, in the first and third quadrants"]$mq$, 3, $mq$For positive x, y is positive; for negative x, y is negative. That gives two branches in quadrants 1 and 3. The graph never touches either axis.$mq$, $mq$medium$mq$),
($mq$The graph of y = k/x passes through (4, 3). What is y when x = 6?$mq$, $mq$["3","12","2","4.5"]$mq$, 2, $mq$k = 4 × 3 = 12, so y = 12/x. When x = 6, y = 12 ÷ 6 = 2.$mq$, $mq$medium$mq$),
($mq$Solve sin x = 0.5 for 0° ≤ x ≤ 360°.$mq$, $mq$["30° and 330°","30° and 150°","60° and 120°","30° only"]$mq$, 1, $mq$The calculator gives 30°. Sine is also positive in the second quadrant, so a second solution is 180° − 30° = 150°.$mq$, $mq$medium$mq$),
($mq$A group trip costs $120 for the bus plus $5 per person for food. The cost per person is C = 120/n + 5 when n people go. What is C when n = 8?$mq$, $mq$["$20","$15","$25","$5"]$mq$, 0, $mq$120 ÷ 8 = 15, and 15 + 5 = 20. Each person pays $20.$mq$, $mq$medium$mq$),
($mq$A sine wave has a maximum of 5, a minimum of −5 and a period of 120°. Which equation matches?$mq$, $mq$["y = 3 sin 5x","y = 5 sin (x/3)","y = 120 sin 5x","y = 5 sin 3x"]$mq$, 3, $mq$The amplitude is 5, so a = 5. The period is 360° ÷ b = 120°, so b = 3. The function is y = 5 sin 3x.$mq$, $mq$hard$mq$),
($mq$Solve cos x = −0.5 for 0° ≤ x ≤ 360°.$mq$, $mq$["60° and 300°","120° only","120° and 240°","150° and 210°"]$mq$, 2, $mq$cos⁻¹(−0.5) = 120°. Cosine is symmetrical about 180°, so the second solution is 360° − 120° = 240°.$mq$, $mq$hard$mq$),
($mq$Write y = (2x + 1)/(x − 1) as 2 + 3/(x − 1). What are its asymptotes?$mq$, $mq$["x = −1 and y = 2","x = 1 and y = 2","x = 1 and y = 3","x = 2 and y = 1"]$mq$, 1, $mq$The denominator is zero at x = 1, so x = 1 is the vertical asymptote. As x gets large, 3/(x − 1) tends to 0 and y tends to 2. Check: x = 3 gives 7/2 = 2 + 3/2.$mq$, $mq$hard$mq$),
($mq$Tide height in metres is h = 3 sin(30t) + 5, where t is hours after midnight and the angle is in degrees. What is the first time that the tide reaches its maximum height?$mq$, $mq$["t = 3 hours, h = 8 m","t = 6 hours, h = 8 m","t = 3 hours, h = 3 m","t = 12 hours, h = 5 m"]$mq$, 0, $mq$The maximum happens when sin(30t) = 1, so 30t = 90° and t = 3. Then h = 3 + 5 = 8 m. The period is 360 ÷ 30 = 12 hours.$mq$, $mq$hard$mq$),
($mq$Using C = 120/n + 5, how many people must go for the cost per person to fall to $8?$mq$, $mq$["15","24","3","40"]$mq$, 3, $mq$120/n + 5 = 8 gives 120/n = 3, so n = 40. Notice that the cost never falls below $5, which is the horizontal asymptote.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Rational Functions and Trigonometric Graphs$mq$ and p.name = $mq$Rational and Trigonometric Functions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Reciprocal function y = 1/x$mq$, $mq$A hyperbola with two branches (quadrants 1 and 3) and asymptotes x = 0 and y = 0.$mq$),
($mq$Vertical asymptote$mq$, $mq$Found where the denominator equals zero, such as x = 3 for y = 1/(x − 3).$mq$),
($mq$Horizontal asymptote$mq$, $mq$The value y approaches as x gets very large. For y = 1/x + 2 it is y = 2.$mq$),
($mq$Inverse proportion$mq$, $mq$y = k/x. Find k using one known point: k = x × y.$mq$),
($mq$y = a sin(bx) + c$mq$, $mq$a is the amplitude, 360° ÷ b is the period, c shifts the graph vertically.$mq$),
($mq$Period of sine and cosine$mq$, $mq$360°. For y = sin(bx) the period is 360° ÷ b.$mq$),
($mq$Period of y = tan x$mq$, $mq$180°, with vertical asymptotes at 90° and 270°.$mq$),
($mq$Solving sin x = k$mq$, $mq$Find the calculator angle α, then the second solution is 180° − α (between 0° and 360°).$mq$),
($mq$Solving cos x = k$mq$, $mq$Find the calculator angle α, then the second solution is 360° − α.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Rational Functions and Trigonometric Graphs$mq$ and p.name = $mq$Rational and Trigonometric Functions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Rational functions
A **rational function** is a fraction where the numerator and denominator are expressions in x. The simplest is y = 1/x, called a **reciprocal function**. Its graph is a hyperbola with two branches: one in the first quadrant and one in the third. The graph never touches the axes. We call the lines it approaches **asymptotes**.

## Finding asymptotes
- **Vertical asymptote**: where the denominator equals zero. For y = 1/(x − 3), set x − 3 = 0 so the asymptote is x = 3. The function is undefined there.
- **Horizontal asymptote**: the value y approaches as x becomes very large positive or negative. For y = 1/x + 2, the fraction tends to 0, so y tends to 2.
Examples: y = 2/(x + 1) has asymptotes x = −1 and y = 0. For y = (2x + 1)/(x − 1), divide to write it as 2 + 3/(x − 1). It has asymptotes x = 1 and y = 2. Check a value: x = 3 gives 7/2 = 3.5 and 2 + 3/2 = 3.5.

## The form y = k/x
If y is inversely proportional to x, then y = k/x. Use one point to find k: through (4, 3), k = 12, so y = 12/x and at x = 6, y = 2. If k is negative the branches lie in quadrants 2 and 4.

## Real-life modelling
Cost per person for a group booking: C = 120/n + 5. As n rises, the 120/n part shrinks, so C approaches the asymptote $5. It never goes below $5, because there are fixed costs per person. For n = 8, C = $20, and C = $8 needs n = 40. Interpreting asymptotes in context is a key skill.

## Trigonometric graphs
- y = sin x: starts at 0, maximum 1 at 90°, back to 0 at 180°, minimum −1 at 270°. Period 360°.
- y = cos x: starts at 1, zero at 90°, minimum −1 at 180°. Period 360°. It is a sine graph shifted left by 90°.
- y = tan x: period 180°, has vertical asymptotes at 90°, 270° and so on, and tan 45° = 1.

## Transformations
For y = a sin(bx) + c:
- **a** changes the amplitude (height of the wave).
- **b** changes the period to 360° ÷ b.
- **c** shifts the graph up by c, so the middle line is y = c and the range is c − |a| to c + |a|.
Example: y = 4 cos x + 1 has range −3 to 5. y = sin 2x has period 180°. A wave with amplitude 5 and period 120° has equation y = 5 sin 3x.

## Solving trig equations from the graph
Solve sin x = 0.5 for 0° to 360°: the calculator gives 30°. Use symmetry for the second answer: sine is symmetrical about 90°, so 180° − 30° = 150°. For cos x = −0.5 the calculator gives 120°, and by symmetry about 180° the other solution is 360° − 120° = 240°. Always sketch the graph to see how many solutions to expect.

## Context: tides
A tide height h = 3 sin(30t) + 5 oscillates between 2 and 8 metres. The maximum happens when sin(30t) = 1, so 30t = 90°, giving t = 3 hours. The period is 360 ÷ 30 = 12 hours.

## Common mistakes
- Writing the vertical asymptote as x = the number in the bracket without changing the sign.
- Forgetting that period = 360° ÷ b, not 360° × b.
- Giving only one solution to a trig equation.
- Putting the calculator in radians instead of degrees.

## How this is examined
Tasks model tides, daylight hours, a Ferris wheel, or costs and speeds. You read a graph, state the amplitude, period and range, find the equation, solve for a given value, and comment on whether the model is reasonable for long periods of time.

Exam tip: For any rational function, ask "What makes the bottom zero?" first and "What happens when x is huge?" second. These two questions give both asymptotes in seconds.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('standard-mathematics')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;