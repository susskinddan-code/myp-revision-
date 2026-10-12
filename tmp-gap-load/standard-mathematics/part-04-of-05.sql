-- Part 4 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Further Statistics and Probability > Conditional and Dependent Events
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Further Statistics and Probability$mq$, 5, 3 from public.subjects s where s.slug = $mq$standard-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Conditional and Dependent Events$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$standard-mathematics$mq$ and p.grade = 5 and p.name = $mq$Further Statistics and Probability$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Conditional and Dependent Events$mq$ and p.name = $mq$Further Statistics and Probability$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$A bag has 3 red and 5 blue counters. What is the probability of picking red?$mq$, $mq$["3/8","3/5","5/8","1/3"]$mq$, 0, $mq$There are 3 + 5 = 8 counters in total and 3 are red: 3/8.$mq$, $mq$easy$mq$),
($mq$A fair coin is flipped and a fair die is rolled. What is P(head and a 6)?$mq$, $mq$["1/8","7/12","1/6","1/12"]$mq$, 3, $mq$The events are independent, so multiply: 1/2 × 1/6 = 1/12.$mq$, $mq$easy$mq$),
($mq$Two sweets are taken from a bag one after another without replacement. The events are...$mq$, $mq$["Independent","Mutually exclusive","Dependent","Impossible"]$mq$, 2, $mq$Taking the first sweet changes what is left, so the probability of the second depends on the first.$mq$, $mq$easy$mq$),
($mq$A bag has 4 red and 6 blue counters. One red counter is taken out and not replaced. What is the probability the next counter is red?$mq$, $mq$["2/5","1/3","4/10","3/10"]$mq$, 1, $mq$There are now 3 red out of 9 counters: 3/9 = 1/3.$mq$, $mq$easy$mq$),
($mq$P(A) = 0.35. What is P(not A)?$mq$, $mq$["0.65","0.35","0.7","−0.35"]$mq$, 0, $mq$Probabilities of an event and its complement sum to 1, so 1 − 0.35 = 0.65.$mq$, $mq$easy$mq$),
($mq$A bag has 5 red and 3 blue counters. Two are drawn without replacement. Find the probability that both are red.$mq$, $mq$["25/64","5/16","5/8","5/14"]$mq$, 3, $mq$P(first red) = 5/8, then P(second red) = 4/7: 5/8 × 4/7 = 20/56 = 5/14. Using 5/8 twice would assume replacement.$mq$, $mq$medium$mq$),
($mq$A bag has 5 red and 3 blue counters. Two are drawn without replacement. Find the probability of getting one of each colour.$mq$, $mq$["15/64","15/56","15/28","3/7"]$mq$, 2, $mq$Red then blue: 5/8 × 3/7 = 15/56. Blue then red is also 15/56. Adding both orders gives 30/56 = 15/28.$mq$, $mq$medium$mq$),
($mq$Of 30 students, 18 play football, 12 play basketball and 5 play both. A student who plays football is chosen. What is the probability they also play basketball?$mq$, $mq$["5/12","5/18","5/30","12/30"]$mq$, 1, $mq$P(basketball given football) = number who play both ÷ number who play football = 5/18.$mq$, $mq$medium$mq$),
($mq$P(A ∩ B) = 0.12 and P(B) = 0.4. Find P(A | B).$mq$, $mq$["0.3","0.048","0.52","0.12"]$mq$, 0, $mq$P(A | B) = P(A ∩ B) ÷ P(B) = 0.12 ÷ 0.4 = 0.3.$mq$, $mq$medium$mq$),
($mq$Of 60 students, 32 are girls and 28 are boys. 18 of the girls and 10 of the boys walk to school. A girl is chosen at random. What is the probability she walks?$mq$, $mq$["28/60","18/60","18/28","9/16"]$mq$, 3, $mq$Only girls are considered, so use 18 out of 32: 18/32 = 9/16.$mq$, $mq$medium$mq$),
($mq$A bag has 6 blue counters out of 10. Two counters are drawn WITH replacement. Find P(both blue).$mq$, $mq$["0.33","0.6","0.36","0.3"]$mq$, 2, $mq$The draws are independent: 0.6 × 0.6 = 0.36. Without replacement it would be 6/10 × 5/9 = 1/3.$mq$, $mq$medium$mq$),
($mq$P(rain) = 0.3. If it rains, P(late) = 0.4. If it does not rain, P(late) = 0.1. Find P(late).$mq$, $mq$["0.5","0.19","0.4","0.12"]$mq$, 1, $mq$Add the two branches that end in late: 0.3 × 0.4 + 0.7 × 0.1 = 0.12 + 0.07 = 0.19.$mq$, $mq$medium$mq$),
($mq$P(A) = 0.5, P(B) = 0.4 and P(A ∩ B) = 0.2. Which statement is correct?$mq$, $mq$["A and B are independent because 0.5 × 0.4 = 0.2","A and B are mutually exclusive","A and B are dependent because P(A ∩ B) ≠ 0","A and B are independent because P(A ∩ B) = 0.2"]$mq$, 0, $mq$Independent events satisfy P(A ∩ B) = P(A) × P(B). Here 0.5 × 0.4 = 0.2. Mutually exclusive events would have P(A ∩ B) = 0.$mq$, $mq$medium$mq$),
($mq$A bag has 4 red, 3 green and 2 yellow counters. Two are drawn without replacement. Find P(same colour).$mq$, $mq$["29/81","1/3","4/9","5/18"]$mq$, 3, $mq$RR: 4/9 × 3/8 = 12/72. GG: 3/9 × 2/8 = 6/72. YY: 2/9 × 1/8 = 2/72. Total 20/72 = 5/18.$mq$, $mq$hard$mq$),
($mq$A bag has 4 red and 5 other counters. Two are taken without replacement. Find the probability that at least one is red.$mq$, $mq$["16/81","5/18","13/18","4/9"]$mq$, 2, $mq$Use the complement. P(no red) = 5/9 × 4/8 = 20/72 = 5/18. So P(at least one red) = 1 − 5/18 = 13/18.$mq$, $mq$hard$mq$),
($mq$Using P(rain) = 0.3, P(late | rain) = 0.4 and P(late | no rain) = 0.1, the overall P(late) is 0.19. Someone arrives late. Find the probability that it rained.$mq$, $mq$["0.4","12/19","0.3","7/19"]$mq$, 1, $mq$P(rain | late) = P(rain and late) ÷ P(late) = 0.12 ÷ 0.19 = 12/19, which is about 0.63. This is bigger than 0.3 because rain makes lateness more likely.$mq$, $mq$hard$mq$),
($mq$P(A) = 0.6, P(B) = 0.5 and P(A ∪ B) = 0.8. Find P(A | B).$mq$, $mq$["0.6","0.3","0.5","0.75"]$mq$, 0, $mq$P(A ∩ B) = 0.6 + 0.5 − 0.8 = 0.3. Then P(A | B) = 0.3 ÷ 0.5 = 0.6, which also equals P(A), so the events are independent.$mq$, $mq$hard$mq$),
($mq$A box has 12 items, 3 of which are defective. An inspector takes 3 items without replacement. Find the probability that none is defective.$mq$, $mq$["27/64","1/4","9/55","21/55"]$mq$, 3, $mq$9/12 × 8/11 × 7/10 = 504/1320 = 21/55. Each item taken reduces both the good items and the total by one.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Conditional and Dependent Events$mq$ and p.name = $mq$Further Statistics and Probability$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Independent events$mq$, $mq$One does not affect the other. P(A and B) = P(A) × P(B).$mq$),
($mq$Dependent events$mq$, $mq$The first outcome changes the probability of the second, as in picking without replacement.$mq$),
($mq$Conditional probability formula$mq$, $mq$P(A | B) = P(A ∩ B) ÷ P(B).$mq$),
($mq$Meaning of P(A | B)$mq$, $mq$The probability of A happening, given that B has already happened.$mq$),
($mq$Probability of 'at least one'$mq$, $mq$1 − P(none). Often quicker than adding every case.$mq$),
($mq$Tree diagram rules$mq$, $mq$Multiply along branches for 'and'. Add the outcomes for 'or'.$mq$),
($mq$Test for independence$mq$, $mq$P(A ∩ B) = P(A) × P(B), or P(A | B) = P(A).$mq$),
($mq$Mutually exclusive$mq$, $mq$Cannot happen together: P(A ∩ B) = 0. Not the same as independent.$mq$),
($mq$Union formula$mq$, $mq$P(A ∪ B) = P(A) + P(B) − P(A ∩ B).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Conditional and Dependent Events$mq$ and p.name = $mq$Further Statistics and Probability$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Independent and dependent events
Two events are **independent** if one happening does not change the probability of the other. Flipping a coin and rolling a die are independent. For independent events: P(A and B) = P(A) × P(B).
Two events are **dependent** if the outcome of the first changes the chances of the second. Taking items from a bag **without replacement** gives dependent events because the contents change. Taking **with replacement** keeps the contents the same, so the events are independent.

## Without replacement
A bag has 5 red and 3 blue counters. Two are taken without replacement.
- P(both red) = 5/8 × 4/7 = 5/14.
- P(one of each colour) = (5/8 × 3/7) + (3/8 × 5/7) = 15/28.
The denominators drop by 1 each pick and the numerator for the colour taken also drops by 1.
"At least one" questions are easiest by complement: P(at least one) = 1 − P(none).

## Conditional probability
The probability of A given that B has happened is written P(A | B). Formula:
P(A | B) = P(A ∩ B) ÷ P(B).
Think "restrict the sample space to B". Example: of 30 students, 18 play football and 5 play both football and basketball. P(basketball | football) = 5/18. In a two-way table, use only the row or column named after "given". Of 32 girls, 18 walk to school, so P(walk | girl) = 18/32 = 9/16.

## Tree diagrams
Draw branches for each stage. Multiply along the branches for "and". Add the end results that satisfy the question for "or".
Example: P(rain) = 0.3. If it rains, P(late) = 0.4. If not, P(late) = 0.1. P(late) = 0.3 × 0.4 + 0.7 × 0.1 = 0.19. Now reverse it: P(rain | late) = 0.12 ÷ 0.19 = 12/19. This is Bayes-style reasoning that appears in diagnosis or quality tests.

## Testing independence
A and B are independent if P(A ∩ B) = P(A) × P(B), or equivalently P(A | B) = P(A). If P(A) = 0.5, P(B) = 0.4 and P(A ∩ B) = 0.2, then they are independent. Do not confuse this with **mutually exclusive**, where P(A ∩ B) = 0.

## Venn diagrams
Use P(A ∪ B) = P(A) + P(B) − P(A ∩ B). Fill the middle of the Venn diagram first, then the rest.

## Common mistakes
- Using the same denominator for both picks when there is no replacement.
- Dividing by the wrong total when finding a conditional probability.
- Adding along branches instead of multiplying.
- Believing independent means mutually exclusive.

## How this is examined
Contexts include quality control, school survey tables, weather and medical screening. You complete a tree diagram, calculate joint and conditional probabilities, and judge whether the results fit a claim, such as "the test is reliable". Extended parts ask you to explain what an assumption of independence means.

Exam tip: Say the sample space out loud: "given B means only B is possible". Write the new total before you write a fraction.$mq$ from st;

-- Networks, Algorithms and Optimisation > Networks and Weighted Pathways
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Networks, Algorithms and Optimisation$mq$, 5, 4 from public.subjects s where s.slug = $mq$standard-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Networks and Weighted Pathways$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$standard-mathematics$mq$ and p.grade = 5 and p.name = $mq$Networks, Algorithms and Optimisation$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Networks and Weighted Pathways$mq$ and p.name = $mq$Networks, Algorithms and Optimisation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In a network, what is the degree of a vertex?$mq$, $mq$["The number of edges meeting at it","The number of vertices in the network","The total weight of its edges","The length of the longest path from it"]$mq$, 0, $mq$The degree counts how many edge ends meet at the vertex. A loop would count twice.$mq$, $mq$easy$mq$),
($mq$A network has 7 edges. What is the sum of all the vertex degrees?$mq$, $mq$["7","49","3.5","14"]$mq$, 3, $mq$Each edge has two ends, so the sum of degrees is twice the number of edges: 2 × 7 = 14.$mq$, $mq$easy$mq$),
($mq$On a weighted network of towns, what could the weight of an edge represent?$mq$, $mq$["The number of vertices","The degree of the town","Distance, time or cost of the route","The number of edges in the network"]$mq$, 2, $mq$Weights attach a number to each edge, usually a distance, a time or a cost.$mq$, $mq$easy$mq$),
($mq$How many edges does a tree with 6 vertices have?$mq$, $mq$["6","5","7","4"]$mq$, 1, $mq$A tree is connected with no cycles, so it always has one fewer edge than vertices: 6 − 1 = 5.$mq$, $mq$easy$mq$),
($mq$A route that starts and ends at the same vertex and does not repeat any other vertex is called a...$mq$, $mq$["Cycle","Tree","Degree","Spanning edge"]$mq$, 0, $mq$A cycle returns to its start without repeating vertices. A tree has no cycles at all.$mq$, $mq$easy$mq$),
($mq$Network N has vertices A to F. Edges and weights (km): A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3. What is the shortest distance from A to F?$mq$, $mq$["14 km","15 km","11 km","13 km"]$mq$, 3, $mq$The shortest route is A–C–B–D–E–F: 2 + 1 + 5 + 2 + 3 = 13 km. A–C–B–D–F is 14 km and A–C–E–F is 15 km.$mq$, $mq$medium$mq$),
($mq$Network N has vertices A to F. Edges and weights (km): A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3. Using Kruskal's algorithm, what is the total weight of a minimum spanning tree?$mq$, $mq$["41 km","11 km","13 km","16 km"]$mq$, 2, $mq$Add edges in order of weight, skipping any that form a cycle: B–C 1, A–C 2, D–E 2, E–F 3, A–B (4, cycle, skip), B–D 5. Five edges for six vertices: 1 + 2 + 2 + 3 + 5 = 13.$mq$, $mq$medium$mq$),
($mq$Network N has vertices A to F. Edges and weights (km): A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3. How many vertices have an odd degree?$mq$, $mq$["0","2","4","6"]$mq$, 1, $mq$Degrees: A 2, B 3, C 4, D 4, E 3, F 2. Only B and E are odd. So an Euler trail exists between B and E.$mq$, $mq$medium$mq$),
($mq$In an adjacency matrix, what does the sum of the entries in the row for vertex C equal (no loops)?$mq$, $mq$["The degree of C","The weight of the network","The number of vertices","The number of edges in the network"]$mq$, 0, $mq$Each 1 in the row shows an edge from C to another vertex, so the sum is the degree of C.$mq$, $mq$medium$mq$),
($mq$Five towns need to be joined by cables. Costs ($ thousand): P–Q 7, P–R 5, Q–R 4, Q–S 6, R–S 9, S–T 3, R–T 8. What is the cheapest total cost of connecting all five towns?$mq$, $mq$["$42 thousand","$16 thousand","$13 thousand","$18 thousand"]$mq$, 3, $mq$Minimum spanning tree: S–T 3, Q–R 4, P–R 5, Q–S 6. Four edges for five towns: 18.$mq$, $mq$medium$mq$),
($mq$Using the cable network (P–Q 7, P–R 5, Q–R 4, Q–S 6, R–S 9, S–T 3, R–T 8), what is the shortest route length from P to T?$mq$, $mq$["16","17","13","15"]$mq$, 2, $mq$P–R–T is 5 + 8 = 13. P–Q–S–T is 16 and P–R–S–T is 17.$mq$, $mq$medium$mq$),
($mq$A connected network has every vertex of even degree. What does this tell you?$mq$, $mq$["No route uses every edge once","A closed route using every edge exactly once exists","Exactly two vertices are odd","It is a tree"]$mq$, 1, $mq$If all vertices are even, there is an Euler circuit that starts and ends at the same vertex and uses each edge once.$mq$, $mq$medium$mq$),
($mq$How many edges does a complete graph on 5 vertices (every vertex joined to every other) have?$mq$, $mq$["10","5","20","25"]$mq$, 0, $mq$Each of 5 vertices joins to 4 others, giving 20 edge ends, so 20 ÷ 2 = 10 edges.$mq$, $mq$medium$mq$),
($mq$A map of four land areas has vertices with degrees 3, 3, 3 and 5 (a bridge-crossing puzzle). Can someone cross every bridge exactly once?$mq$, $mq$["Yes, starting anywhere","Yes, but only from a vertex of degree 3","No, because there are four vertices","No, four vertices are odd"]$mq$, 3, $mq$An Euler trail needs 0 or 2 odd vertices. All four vertices here are odd, so it is impossible.$mq$, $mq$hard$mq$),
($mq$Network N has vertices A to F. Edges and weights (km): A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3. An inspector wants to travel along every road at least once, starting at B and ending at E. What is the minimum distance?$mq$, $mq$["13 km","46 km","41 km","36 km"]$mq$, 2, $mq$B and E are the only odd vertices, so an Euler trail from B to E exists and uses each road exactly once. The total is 4 + 2 + 1 + 5 + 8 + 10 + 2 + 6 + 3 = 41 km.$mq$, $mq$hard$mq$),
($mq$Network N has vertices A to F. Edges and weights (km): A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3. The road B–D (5 km) is closed. What is the new shortest distance from A to F?$mq$, $mq$["13 km","15 km","14 km","16 km"]$mq$, 1, $mq$Without B–D the best routes are A–C–E–F = 2 + 10 + 3 = 15 and A–C–D–E–F = 2 + 8 + 2 + 3 = 15. The old route needed B–D.$mq$, $mq$hard$mq$),
($mq$A connected network has 8 vertices and 9 edges. How many edges must be removed to leave a spanning tree?$mq$, $mq$["2","1","7","9"]$mq$, 0, $mq$A spanning tree on 8 vertices has 7 edges. 9 − 7 = 2 edges must go, chosen to break the cycles while keeping the network connected.$mq$, $mq$hard$mq$),
($mq$Network N has vertices A to F. Edges and weights (km): A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3. Prim's algorithm starts at A and always adds the cheapest edge joining the tree to a new vertex. Which is the THIRD edge chosen?$mq$, $mq$["A–B","D–E","C–D","B–D"]$mq$, 3, $mq$Start at A: the cheapest edge is A–C (2). Then C–B (1). From {A, B, C} the cheapest new connection is B–D (5), beating C–D (8) and C–E (10).$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Networks and Weighted Pathways$mq$ and p.name = $mq$Networks, Algorithms and Optimisation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Vertex, edge, weight$mq$, $mq$Vertex: point. Edge: line joining vertices. Weight: number on an edge such as distance, time or cost.$mq$),
($mq$Degree of a vertex$mq$, $mq$The number of edges meeting at that vertex.$mq$),
($mq$Handshake rule$mq$, $mq$Sum of all degrees = 2 × number of edges. The number of odd vertices is always even.$mq$),
($mq$Tree$mq$, $mq$Connected network with no cycles. n vertices have n − 1 edges.$mq$),
($mq$Minimum spanning tree$mq$, $mq$Connects all vertices with the smallest total weight and no cycles. Found by Kruskal's or Prim's algorithm.$mq$),
($mq$Kruskal's algorithm$mq$, $mq$Sort edges by weight, add the cheapest that does not form a cycle, stop at n − 1 edges.$mq$),
($mq$Prim's algorithm$mq$, $mq$Start at a vertex and keep adding the cheapest edge joining the tree to a new vertex.$mq$),
($mq$Euler trail rule$mq$, $mq$Uses every edge once. Possible if there are 0 odd vertices (circuit) or exactly 2 (start and end at them).$mq$),
($mq$Shortest path$mq$, $mq$The route with the smallest total weight, not the fewest edges.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Networks and Weighted Pathways$mq$ and p.name = $mq$Networks, Algorithms and Optimisation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Graphs and networks
A **network** (graph) is made from **vertices** (points or nodes) joined by **edges** (lines). In a **weighted network** each edge carries a number such as a distance in km, a time in minutes or a cost in dollars. Networks model road maps, cable layouts, delivery routes and the internet.

Key vocabulary:
- **Degree** of a vertex: the number of edges meeting there.
- **Path**: a route that does not repeat vertices. **Cycle**: a path that returns to its start.
- **Connected**: there is a route between every pair of vertices.
- **Tree**: a connected network with no cycles. A tree on n vertices has n − 1 edges.
- **Complete graph**: every vertex joins every other. With n vertices there are n(n − 1)/2 edges.
The sum of all degrees is twice the number of edges, so the number of odd vertices is always even.

## Shortest path
To find the shortest route between two vertices, work outward from the start, recording the shortest known distance to each vertex (Dijkstra's method). In the network with edges A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3, the shortest route from A to F is A–C–B–D–E–F with total 2 + 1 + 5 + 2 + 3 = 13. Notice that the route with the fewest edges is not the shortest. If B–D is closed, the answer rises to 15.

## Minimum spanning tree
A **spanning tree** connects all vertices using no cycles. The **minimum spanning tree** (MST) has the smallest total weight. Use it to find the cheapest way to connect towns with cable or pipes.
Kruskal's algorithm: sort the edges, add the cheapest edge that does not create a cycle, stop when you have n − 1 edges.
Prim's algorithm: start at any vertex and repeatedly add the cheapest edge that joins the tree to a new vertex.
Both give the same total weight, here 13 for the network above.
Remember: the MST connects everything cheaply but does not give the shortest route between two particular vertices.

## Euler trails
A route using every edge exactly once is an **Euler trail**. It exists when the number of odd vertices is 0 (it can be a closed circuit) or 2 (it must start at one odd vertex and end at the other). In the example network only B and E are odd, so the whole network can be traversed from B to E in a distance equal to the sum of all weights, 41. A network with four odd vertices, like the famous bridges of Königsberg, has no such route without repeating edges.

## Common mistakes
- Choosing the route with the fewest edges instead of the smallest total weight.
- Adding an edge that makes a cycle when building a minimum spanning tree.
- Counting a spanning tree with the wrong number of edges.
- Confusing MST total weight with the shortest path.

## How this is examined
Tasks give a map with distances or costs, often a school trip, delivery round, cable laying or emergency access plan. You find shortest paths, build a minimum spanning tree, check whether a closed route exists, and evaluate how a closure would change the answer.

Exam tip: Record each step of your algorithm in a small table or list, such as edges chosen in order, so that an examiner can follow your reasoning and a slip can still earn method marks.$mq$ from st;

-- Networks, Algorithms and Optimisation > Flowcharts and Algorithms
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Networks, Algorithms and Optimisation$mq$, 5, 4 from public.subjects s where s.slug = $mq$standard-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Flowcharts and Algorithms$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$standard-mathematics$mq$ and p.grade = 5 and p.name = $mq$Networks, Algorithms and Optimisation$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Flowcharts and Algorithms$mq$ and p.name = $mq$Networks, Algorithms and Optimisation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In a flowchart, which shape is used for a decision (yes/no question)?$mq$, $mq$["Diamond","Rectangle","Oval","Parallelogram"]$mq$, 0, $mq$A diamond holds a condition with two exits, usually Yes and No. Rectangles are processes, ovals are start/stop, parallelograms are input/output.$mq$, $mq$easy$mq$),
($mq$Which flowchart shape marks the start or end of an algorithm?$mq$, $mq$["Diamond","Rectangle","Triangle","Oval"]$mq$, 3, $mq$The start and end terminators are drawn as ovals (rounded rectangles).$mq$, $mq$easy$mq$),
($mq$What is an algorithm?$mq$, $mq$["A type of computer","A single mathematical formula","A step-by-step set of instructions to solve a problem","A drawing of a network"]$mq$, 2, $mq$An algorithm is a finite, ordered list of clear instructions that solves a problem.$mq$, $mq$easy$mq$),
($mq$An algorithm sets x = 5, then x = x × 2 + 1. What is the final value of x?$mq$, $mq$["10","11","12","16"]$mq$, 1, $mq$x × 2 = 10, plus 1 gives 11. The new x replaces the old one.$mq$, $mq$easy$mq$),
($mq$Which flowchart shape is normally used for input and output?$mq$, $mq$["Parallelogram","Diamond","Circle","Oval"]$mq$, 0, $mq$Parallelograms show reading in a value or displaying a result.$mq$, $mq$easy$mq$),
($mq$Start n = 1. While n < 20, replace n with n × 2. What is the final value of n?$mq$, $mq$["16","20","40","32"]$mq$, 3, $mq$n takes the values 1, 2, 4, 8, 16 and then 32. At 16 the condition 16 < 20 is true, so it doubles once more. At 32 the loop stops.$mq$, $mq$medium$mq$),
($mq$Set total = 0. For i from 1 to 5, add i² to total. What is total at the end?$mq$, $mq$["15","225","55","30"]$mq$, 2, $mq$1 + 4 + 9 + 16 + 25 = 55. The sum of the squares is different from the square of the sum, which is 225.$mq$, $mq$medium$mq$),
($mq$The algorithm: if x is even output x ÷ 2, otherwise output 3x + 1. What is the output when x = 7?$mq$, $mq$["3.5","22","21","8"]$mq$, 1, $mq$7 is odd, so the output is 3 × 7 + 1 = 22.$mq$, $mq$medium$mq$),
($mq$Algorithm: a = 48, b = 18. Repeat while b ≠ 0: r = a mod b, a = b, b = r. Output a. What is the output?$mq$, $mq$["6","12","18","0"]$mq$, 0, $mq$(48, 18) → (18, 12) → (12, 6) → (6, 0). The loop stops and a = 6, the HCF of 48 and 18.$mq$, $mq$medium$mq$),
($mq$A loop runs for i = 3, 7, 11, 15 (starting at 3, adding 4, stopping at 15). How many times does the loop body run?$mq$, $mq$["3","5","12","4"]$mq$, 3, $mq$The values are 3, 7, 11 and 15, which is four values.$mq$, $mq$medium$mq$),
($mq$Start n = 10 and count = 0. While n > 0: subtract 3 from n and add 1 to count. What is count at the end?$mq$, $mq$["3","10","4","2"]$mq$, 2, $mq$n goes 10 → 7 → 4 → 1 → −2. The loop ran four times, so count = 4.$mq$, $mq$medium$mq$),
($mq$One pass of bubble sort (swapping neighbours if out of order, left to right) is applied to 5, 2, 9, 1. What is the list afterwards?$mq$, $mq$["1, 2, 5, 9","2, 5, 1, 9","2, 5, 9, 1","5, 2, 1, 9"]$mq$, 1, $mq$Compare 5 and 2: swap → 2, 5, 9, 1. Compare 5 and 9: no swap. Compare 9 and 1: swap → 2, 5, 1, 9. One pass puts the largest at the end but does not fully sort.$mq$, $mq$medium$mq$),
($mq$A linear search looks for 9 in the list 7, 3, 9, 4, 1, checking from the left. How many values are compared?$mq$, $mq$["3","2","5","4"]$mq$, 0, $mq$Compare 7, then 3, then 9. The search stops on the third comparison when it finds 9.$mq$, $mq$medium$mq$),
($mq$Start x = 2 and y = 1. Repeat 3 times: y = y × x, then x = x + 1. What is y at the end?$mq$, $mq$["8","6","120","24"]$mq$, 3, $mq$Pass 1: y = 2, x = 3. Pass 2: y = 6, x = 4. Pass 3: y = 24, x = 5. The loop computes 4! = 24.$mq$, $mq$hard$mq$),
($mq$Start a = 0, b = 1. Repeat 6 times: c = a + b, a = b, b = c. What is b afterwards?$mq$, $mq$["8","21","13","6"]$mq$, 2, $mq$b takes the values 1, 2, 3, 5, 8, 13 on the six passes. This is the Fibonacci sequence.$mq$, $mq$hard$mq$),
($mq$A binary search is used on a sorted list of 15 items. Each comparison halves the list. What is the maximum number of comparisons needed?$mq$, $mq$["15","4","8","3"]$mq$, 1, $mq$15 items → 7 → 3 → 1 after halving each time, so 4 comparisons in the worst case (2⁴ − 1 = 15). A linear search could need up to 15.$mq$, $mq$hard$mq$),
($mq$An algorithm to find the largest number sets max = 0, then compares each input. It outputs 0 for the inputs −5, −2, −9. How should it be fixed?$mq$, $mq$["Set max to the first input value at the start","Set max to 1 at the start","Compare using < instead of >","Add 5 to every input"]$mq$, 0, $mq$Starting at 0 is wrong when all numbers are negative because 0 is not in the data. Starting with the first value always works.$mq$, $mq$hard$mq$),
($mq$To test whether 29 is prime, an algorithm tries divisors only up to √29 ≈ 5.4. Why is that enough?$mq$, $mq$["Because 29 is odd","Because primes are below 6","Because divisors above 5 are always even","Any factor pair has one factor not bigger than the square root"]$mq$, 3, $mq$If n = a × b, at least one of a and b is at most √n. So if no divisor up to √n works, n has no other factors.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Flowcharts and Algorithms$mq$ and p.name = $mq$Networks, Algorithms and Optimisation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Flowchart shapes$mq$, $mq$Oval: start/end. Rectangle: process. Parallelogram: input/output. Diamond: decision.$mq$),
($mq$Algorithm$mq$, $mq$A finite, ordered list of clear instructions that solves a problem.$mq$),
($mq$Trace table$mq$, $mq$A table recording each variable's value after every step, used to predict output or find errors.$mq$),
($mq$WHILE loop$mq$, $mq$Checks the condition before every pass and repeats while it is true.$mq$),
($mq$FOR loop$mq$, $mq$Repeats a set number of times, with a counter moving from a start value to an end value.$mq$),
($mq$Euclid's algorithm$mq$, $mq$Repeat: replace (a, b) with (b, a mod b) until b = 0. The answer is a, the HCF.$mq$),
($mq$Linear vs binary search$mq$, $mq$Linear: check each item in turn. Binary: halve a sorted list each time. Binary is much faster.$mq$),
($mq$Bubble sort$mq$, $mq$Compare neighbours and swap if out of order; repeat passes until no swaps are needed.$mq$),
($mq$Testing an algorithm$mq$, $mq$Use normal, extreme and unusual inputs, for example negatives or zero, to find hidden errors.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Flowcharts and Algorithms$mq$ and p.name = $mq$Networks, Algorithms and Optimisation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is an algorithm?
An **algorithm** is a finite, ordered list of clear instructions that solves a problem or completes a task. Recipes, sorting a list and finding the shortest route are all algorithms. A good algorithm has a clear start and end, each step is unambiguous, and it works for every valid input.

## Flowchart symbols
- **Oval**: start or end.
- **Rectangle**: a process, such as x = x + 1.
- **Parallelogram**: input or output.
- **Diamond**: a decision with two exits, Yes and No.
- **Arrows**: show the direction of flow.
A loop is formed when an arrow returns to an earlier step. Keep the decision question precise, such as "Is n < 20?".

## Pseudocode
Pseudocode describes an algorithm in plain structured language: INPUT, OUTPUT, IF ... THEN ... ELSE, WHILE ... DO, FOR i FROM 1 TO 5. It is not a real programming language, but it should be clear enough for anyone to follow.

## Trace tables
Tracing means working through an algorithm by hand, recording the values of the variables in a table after each step. This is the main way to predict outputs and find errors.
Example: Start x = 2, y = 1. Repeat 3 times: y = y × x, then x = x + 1.
Pass 1: y = 2, x = 3. Pass 2: y = 6, x = 4. Pass 3: y = 24, x = 5. Final y = 24.
Another: n = 1, while n < 20 double n. The values are 1, 2, 4, 8, 16, 32, and the loop stops when n = 32, because 32 < 20 is false.

## Classic algorithms
- **Euclid's algorithm** for HCF: repeat a mod b until the remainder is 0. For 48 and 18 the pairs are (48, 18), (18, 12), (12, 6), (6, 0), so the HCF is 6.
- **Linear search**: check items one by one. Worst case, every item.
- **Binary search**: for a sorted list, repeatedly halve the search area. For 15 items it needs at most 4 checks.
- **Bubble sort**: repeatedly compare neighbours and swap if they are in the wrong order. One pass moves the largest value to the end: 5, 2, 9, 1 becomes 2, 5, 1, 9.
- **Primality test**: only test divisors up to √n.

## Testing and improving an algorithm
Test with typical data, extreme values and unusual cases. For example, a "find the largest" algorithm that starts with max = 0 fails if all the inputs are negative. Starting max at the first input fixes it. Efficiency also matters: binary search is much faster than linear search for large sorted lists.

## Common mistakes
- Updating variables in the wrong order inside a loop.
- Running a loop one time too many or too few.
- Reading the decision exits the wrong way round.
- Forgetting the initial values of variables.

## How this is examined
Tasks present a flowchart or pseudocode for a real situation, such as a ticket price calculator, a thermostat rule or a sorting routine. You trace it with sample inputs, state the purpose, find and correct an error, and sometimes design your own algorithm to meet a specification.

Exam tip: Always make a trace table with a column for every variable and one row for each pass of the loop. Test the loop condition at the start of every pass, and stop exactly when it becomes false.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('standard-mathematics')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;