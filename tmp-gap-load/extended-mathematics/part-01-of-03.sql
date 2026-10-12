-- Part 1 of 3: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Networks and Algorithms > Networks, Nodes and Weighted Pathways
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Networks and Algorithms$mq$, 5, 1 from public.subjects s where s.slug = $mq$extended-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Networks, Nodes and Weighted Pathways$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$extended-mathematics$mq$ and p.grade = 5 and p.name = $mq$Networks and Algorithms$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Networks, Nodes and Weighted Pathways$mq$ and p.name = $mq$Networks and Algorithms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In a network diagram, what does a node (also called a vertex) represent?$mq$, $mq$["A point such as a town, junction or computer","A connection between two points with a number on it","The total length of a route","A route that visits every point once"]$mq$, 0, $mq$A node is a point in the network. The lines joining nodes are edges (or arcs), and the numbers on them are weights.$mq$, $mq$easy$mq$),
($mq$A road network is drawn with each edge labelled with the distance in kilometres. What is the weight of an edge?$mq$, $mq$["The number of nodes it joins","The thickness used to draw it","The number of routes that use it","The number on it, here the distance in km"]$mq$, 3, $mq$A weighted edge carries a number that measures something about the link, such as distance, time or cost. Here the weight is the distance.$mq$, $mq$easy$mq$),
($mq$A network has edges A–B, A–C, A–D, B–C and D–E. What is the degree of node A?$mq$, $mq$["2","4","3","5"]$mq$, 2, $mq$The degree of a node is the number of edges meeting at it. Node A is on A–B, A–C and A–D, so its degree is 3.$mq$, $mq$easy$mq$),
($mq$In a network, the edge weights are A–B = 4 and B–D = 5. What is the total weight of the path A–B–D?$mq$, $mq$["20","9","5","1"]$mq$, 1, $mq$The weight of a path is the sum of the weights of its edges: 4 + 5 = 9. Multiplying (4 × 5 = 20) is a common slip.$mq$, $mq$easy$mq$),
($mq$A network has 5 nodes with degrees 3, 2, 2, 2 and 3. How many edges does it have?$mq$, $mq$["6","12","5","10"]$mq$, 0, $mq$Each edge adds 1 to the degree of two nodes, so the sum of the degrees is twice the number of edges. The degrees add to 12, so there are 6 edges.$mq$, $mq$easy$mq$),
($mq$Use this road network (weights in km): A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3. What is the length of the shortest route from A to E?$mq$, $mq$["11 km","12 km","15 km","10 km"]$mq$, 3, $mq$The shortest route is A–C–B–D–E: 2 + 1 + 5 + 2 = 10. A–B–D–E (11) and A–C–E or A–C–D–E (12) are longer.$mq$, $mq$medium$mq$),
($mq$In the network A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3 (weights in km), Sam says: "A–C–E–F is the best route from A to F because it uses the fewest edges." Which statement is correct?$mq$, $mq$["A–C–E–F has weight 13, so Sam is right","The fewest edges always gives the shortest weighted path","A–C–E–F has weight 15, but a route with more edges has weight 13, so Sam is wrong","A–C–E–F has weight 10, so it is shortest"]$mq$, 2, $mq$A–C–E–F = 2 + 10 + 3 = 15. The route A–C–B–D–E–F = 2 + 1 + 5 + 2 + 3 = 13 uses more edges but is shorter. The shortest weighted path depends on the weights, not on the number of edges.$mq$, $mq$medium$mq$),
($mq$The road between B and D in the network A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3 (weights in km) is closed for repairs. What is the length of the shortest route from A to F now?$mq$, $mq$["13 km","15 km","14 km","17 km"]$mq$, 1, $mq$Without B–D, the best route is A–C–E–F = 2 + 10 + 3 = 15 (A–C–D–E–F = 2 + 8 + 2 + 3 is also 15). The old value 13 used the closed road.$mq$, $mq$medium$mq$),
($mq$A council connects six villages (A to F) with the least total length of new cable. The possible links and lengths in km are A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3. What is the least total length that connects all six villages?$mq$, $mq$["13 km","15 km","12 km","17 km"]$mq$, 0, $mq$A connected network on 6 nodes with no loop needs 5 links. Choosing the shortest links that do not form a loop gives B–C 1, A–C 2, D–E 2, E–F 3 and B–D 5, a total of 13 km.$mq$, $mq$medium$mq$),
($mq$A network has nodes P, Q and R. The edges are P–Q with weight 3 and Q–R with weight 5. In the adjacency matrix, rows and columns are in the order P, Q, R, and 0 means no direct edge. What is the row for Q?$mq$, $mq$["3, 5, 0","0, 3, 5","3, 5, 5","3, 0, 5"]$mq$, 3, $mq$The Q row lists the weight of the edge from Q to P, Q to Q and Q to R. That is 3, 0 (no loop at Q) and 5.$mq$, $mq$medium$mq$),
($mq$A courier's route network has distances in km, and the shortest route from A to F is 13 km (A–C–B–D–E–F). The vehicle costs £0.45 per km to run. What is the running cost for the shortest route?$mq$, $mq$["£6.75","£28.89","£5.85","£13.45"]$mq$, 2, $mq$Cost = distance × cost per km = 13 × 0.45 = £5.85. £6.75 comes from using the 15 km route, and dividing (13 ÷ 0.45) gives a meaningless £28.89.$mq$, $mq$medium$mq$),
($mq$The weights in the network A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3 are travel times in minutes. A bus also waits 2 minutes at every node it passes through between A and F (not at A or F). Which statement is correct?$mq$, $mq$["A–C–B–D–E–F is still the quickest, taking 13 minutes","A–C–B–D–E–F is no longer the quickest: it takes 21 minutes, but A–C–E–F takes 19","A–C–B–D–F takes 14 minutes in total","A–C–E–F takes 15 minutes in total"]$mq$, 1, $mq$Add 2 minutes per intermediate node. A–C–B–D–E–F has 4 intermediate nodes: 13 + 8 = 21. A–C–E–F has 2: 15 + 4 = 19. A–C–B–D–F is 14 + 6 = 20. The shortest pure travel time is not the quickest overall.$mq$, $mq$medium$mq$),
($mq$A planner uses a network with distance weights to choose the quickest delivery route. What is the main limitation of this model?$mq$, $mq$["Distance does not show speed limits or traffic, so the shortest route may not be the quickest","Networks cannot be used with real roads","Weights must always be whole numbers","A network can only have one possible route"]$mq$, 0, $mq$Time depends on speed, traffic and junctions, not distance alone. A good evaluation states this assumption and suggests using travel-time weights instead.$mq$, $mq$medium$mq$),
($mq$The network A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3 has distances in km. Road B–D is closed and a new bypass reduces the weight of C–E from 10 to 4. What is the new shortest distance from A to F?$mq$, $mq$["13 km","15 km","12 km","9 km"]$mq$, 3, $mq$With B–D closed and C–E = 4, the route A–C–E–F = 2 + 4 + 3 = 9. Routes using D cost more, for example A–C–E–D–F = 2 + 4 + 2 + 6 = 14.$mq$, $mq$hard$mq$),
($mq$A company wants a direct cable between every pair of its 6 offices. A cheaper plan only needs the offices to be connected with no loops. How many fewer cables does the cheaper plan use?$mq$, $mq$["9","15","10","5"]$mq$, 2, $mq$Direct links between every pair need 6 × 5 ÷ 2 = 15 cables. A connected layout without loops on 6 nodes needs 5 cables. 15 − 5 = 10 fewer.$mq$, $mq$hard$mq$),
($mq$In the network A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3, Jo starts at D and always moves along the shortest edge to a node she has not yet visited, aiming to visit every node. What happens?$mq$, $mq$["She visits all six nodes with a total of 13 km","She visits D, E, F and then cannot continue, so A, B and C are never reached","She visits all six nodes with a total of 15 km","She goes D–F first because F is a final node"]$mq$, 1, $mq$From D the nearest unvisited node is E (2). From E the nearest unvisited is F (3). F's only neighbours are D and E, which are already visited, so she is stuck. A greedy rule does not always give a complete route.$mq$, $mq$hard$mq$),
($mq$Dijkstra's algorithm starts at A in the network A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3. When node C (label 2) is processed, what temporary label does D receive, and does it change later?$mq$, $mq$["10, and it later improves to 8 through B","8, and it never changes","10, and it never changes","9, and it later improves to 8"]$mq$, 0, $mq$Processing C gives D a label of 2 + 8 = 10. Processing C also improves B to 3 (2 + 1). Then processing B gives D a label of 3 + 5 = 8, which is smaller, so D is updated.$mq$, $mq$hard$mq$),
($mq$The weights in the network A–B 4, A–C 2, B–C 1, B–D 5, C–D 8, C–E 10, D–E 2, D–F 6, E–F 3 are times in minutes. Roadworks increase the time on D–E by 150%. Which route from A to F is now the quickest and how long does it take?$mq$, $mq$["A–C–B–D–E–F in 16 minutes","A–C–B–D–E–F in 13 minutes","A–C–E–F in 13 minutes","A–C–B–D–F in 14 minutes"]$mq$, 3, $mq$A 150% increase on 2 minutes gives 2 + 3 = 5 minutes. The old best route becomes 2 + 1 + 5 + 5 + 3 = 16. The route via D–F is 2 + 1 + 5 + 6 = 14, which is now the quickest.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Networks, Nodes and Weighted Pathways$mq$ and p.name = $mq$Networks and Algorithms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Node (vertex)$mq$, $mq$A point in a network, such as a town, junction or computer.$mq$),
($mq$Edge (arc)$mq$, $mq$A link joining two nodes. In a weighted network each edge has a number on it.$mq$),
($mq$Weight$mq$, $mq$The number on an edge, such as a distance, time or cost.$mq$),
($mq$Degree of a node$mq$, $mq$The number of edges that meet at that node.$mq$),
($mq$Sum of degrees$mq$, $mq$The sum of all the degrees equals twice the number of edges.$mq$),
($mq$Weight of a path$mq$, $mq$The sum of the weights of the edges used.$mq$),
($mq$Tree with n nodes$mq$, $mq$A connected network with no cycles; it always has n − 1 edges.$mq$),
($mq$Minimum connecting network$mq$, $mq$Pick the shortest edges first, skip any that make a cycle, and stop at n − 1 edges.$mq$),
($mq$Why fewest edges is not shortest$mq$, $mq$A path with more edges can have a smaller total weight, so always add the weights.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Networks, Nodes and Weighted Pathways$mq$ and p.name = $mq$Networks and Algorithms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is a network?
A network (or graph) is a diagram made of nodes (also called vertices) joined by edges (also called arcs). Nodes can be towns, airports, computers or classrooms. Edges are the links between them: roads, flights, cables or footpaths. When each edge has a number on it, the network is weighted. The number is the weight, and it might be a distance in km, a time in minutes or a cost in pounds.

## Key vocabulary
- **Degree** of a node: the number of edges that meet at it.
- **Path**: a sequence of edges that joins nodes without going back through a node you have already used.
- **Weight of a path**: the sum of the weights of its edges.
- **Connected network**: you can travel between any two nodes.
- **Cycle**: a path that starts and finishes at the same node.
- **Tree**: a connected network with no cycles. A tree with n nodes always has n − 1 edges.

A useful check: the sum of all the degrees is twice the number of edges, because each edge touches two nodes.

## Finding the shortest path
To find the shortest route between two nodes, you cannot just count edges. A route with many short edges can beat a route with one long edge. A reliable method is to build up the shortest distances from the start node (Dijkstra's idea):
- Give the start node the label 0 and all others a temporary label.
- Take the unfinished node with the smallest label and fix it.
- Update the labels of its neighbours: new label = fixed label + edge weight, keeping the smaller value.
- Repeat until the target node is fixed.

Worked example: edges A–B 4, A–C 2, B–C 1, B–D 5. From A, B gets 4 and C gets 2. Fix C (2). Then B can be reached by 2 + 1 = 3, which is better than 4, so B becomes 3. Fix B (3). Then D = 3 + 5 = 8.

## Minimum connecting network
Sometimes the aim is to connect every node using the least total weight, such as laying cable to villages. Choose the shortest edge available, then the next shortest, and so on, skipping any edge that would make a cycle. Stop when you have n − 1 edges. This gives the lowest total weight for a connected network.

## Adjacency matrices
A network can be stored as a table. Rows and columns are the nodes, and each entry is the weight of the direct edge (or 0 if there is none). The matrix is symmetric for a two-way network.

## Common mistakes
- Choosing the route with the fewest edges instead of the smallest total weight.
- Forgetting extra costs, such as waiting time at a node.
- Using a greedy rule (always take the nearest next node) and assuming it gives the best overall answer.
- Mixing units, such as km and minutes.

## How this is examined
Questions set a real context, such as a delivery firm, an airport shuttle or a cable layout, with the network described in text or a diagram. You may be asked to state the degree of a node, calculate a path weight, find the shortest route, justify why one route is better, and then evaluate the model: what does the weight really measure, and what changes if there is a road closure or a traffic delay? Extended tasks ask you to state assumptions and say how realistic the model is.

Exam tip: Write every route you test as a list of nodes with the weights added up (for example A–C–B–D = 2 + 1 + 5 = 8). Method marks are given for showing the comparison, and always include the units in your final answer.$mq$ from st;

-- Networks and Algorithms > Algorithms and Flowcharts
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Networks and Algorithms$mq$, 5, 1 from public.subjects s where s.slug = $mq$extended-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Algorithms and Flowcharts$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$extended-mathematics$mq$ and p.grade = 5 and p.name = $mq$Networks and Algorithms$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Algorithms and Flowcharts$mq$ and p.name = $mq$Networks and Algorithms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In a flowchart, which shape is used for a decision such as "Is x > 10?"$mq$, $mq$["A diamond","A rectangle","An oval","A parallelogram"]$mq$, 0, $mq$A diamond holds a yes/no question and has two exits. Rectangles are processes, ovals are start/stop, and parallelograms are input/output.$mq$, $mq$easy$mq$),
($mq$An algorithm reads x. If x > 10 it outputs 2x − 5, otherwise it outputs x + 3. What is the output when x = 7?$mq$, $mq$["9","19","4","10"]$mq$, 3, $mq$7 is not greater than 10, so the algorithm outputs x + 3 = 10. Using the other branch would give 2 × 7 − 5 = 9.$mq$, $mq$easy$mq$),
($mq$Which of these best describes an algorithm?$mq$, $mq$["A diagram with only diamonds in it","A single calculation that has one answer","A finite list of clear steps that solves a problem","A list of numbers in order"]$mq$, 2, $mq$An algorithm is a precise set of steps that always ends and solves a problem. A flowchart or pseudocode is one way to show it.$mq$, $mq$easy$mq$),
($mq$An algorithm sets total = 0 and n = 1. It repeats: total = total + n², then n = n + 1, until n is greater than 4. What is the final total?$mq$, $mq$["10","30","100","14"]$mq$, 1, $mq$The loop adds 1² + 2² + 3² + 4² = 1 + 4 + 9 + 16 = 30. Adding n instead of n² would give 10.$mq$, $mq$easy$mq$),
($mq$Which shape is used in a flowchart for input or output, such as "Enter a number"?$mq$, $mq$["A parallelogram","A diamond","A rectangle","An oval"]$mq$, 0, $mq$Input and output steps use a parallelogram. Diamonds are for decisions, rectangles for calculations and ovals for start and stop.$mq$, $mq$easy$mq$),
($mq$An algorithm starts with a = 48 and b = 18. It repeats: if a > b replace a by a − b, otherwise replace b by b − a, until a = b. It then outputs a. What is the output?$mq$, $mq$["12","18","30","6"]$mq$, 3, $mq$The pairs are (48, 18) → (30, 18) → (12, 18) → (12, 6) → (6, 6). The output is 6, the highest common factor of 48 and 18.$mq$, $mq$medium$mq$),
($mq$A bacteria model starts at 5 cells and doubles every hour. An algorithm repeats "double the number" until the number is more than 1000, and outputs the number. What does it output?$mq$, $mq$["1000","640","1280","2560"]$mq$, 2, $mq$The values are 5, 10, 20, 40, 80, 160, 320, 640, 1280. The first value above 1000 is 1280, after 8 doublings. Stopping at 640 is too early because 640 is not more than 1000.$mq$, $mq$medium$mq$),
($mq$An account has £2000 and earns 3% interest each year. An algorithm repeats "multiply the balance by 1.03 and add 1 to the year count" until the balance is more than £2500. What year count does it output?$mq$, $mq$["7","8","9","25"]$mq$, 1, $mq$2000 × 1.03⁷ ≈ 2459.7, which is below 2500, but 2000 × 1.03⁸ ≈ 2533.5, which is above 2500. So the loop ends after 8 years.$mq$, $mq$medium$mq$),
($mq$A bubble sort pass compares neighbouring numbers from left to right and swaps them if the left is larger. The list is 5, 2, 9, 1, 6. What is the list after one pass?$mq$, $mq$["2, 5, 1, 6, 9","1, 2, 5, 6, 9","2, 5, 9, 1, 6","2, 5, 1, 9, 6"]$mq$, 0, $mq$Compare 5 and 2: swap → 2, 5, 9, 1, 6. 5 and 9: no swap. 9 and 1: swap → 2, 5, 1, 9, 6. 9 and 6: swap → 2, 5, 1, 6, 9. One pass does not fully sort the list.$mq$, $mq$medium$mq$),
($mq$A sorted list has 100 values. Binary search checks the middle value and discards half the list each time. What is the greatest number of checks needed to find a value?$mq$, $mq$["10","50","100","7"]$mq$, 3, $mq$Each check at most halves the list: 100 → 50 → 25 → 12 → 6 → 3 → 1 shows the list is reduced to one item after at most 7 checks, since 2⁶ = 64 < 100 ≤ 2⁷ = 128.$mq$, $mq$medium$mq$),
($mq$An algorithm starts with n = 6 and a counter at 0. While n ≠ 1: if n is even, replace n by n ÷ 2; if n is odd, replace n by 3n + 1. Each time, add 1 to the counter. What is the counter at the end?$mq$, $mq$["6","5","8","9"]$mq$, 2, $mq$The values of n are 6, 3, 10, 5, 16, 8, 4, 2, 1. That is 8 steps, so the counter is 8.$mq$, $mq$medium$mq$),
($mq$A taxi company charges £3.50 plus £1.20 per km for the first 5 km, then £0.90 per km after that. An algorithm calculates the fare for a trip. What is the fare for a 12 km trip?$mq$, $mq$["£17.90","£15.80","£14.30","£18.20"]$mq$, 1, $mq$The first 5 km cost 5 × 1.20 = £6.00. The remaining 7 km cost 7 × 0.90 = £6.30. Fare = 3.50 + 6.00 + 6.30 = £15.80. Using one rate for all 12 km is a common error.$mq$, $mq$medium$mq$),
($mq$An algorithm sets n = 1 and repeats: "while n > 0, replace n by n + 1". What happens when it runs?$mq$, $mq$["It never stops, because n is always greater than 0","It stops when n reaches 0","It stops after one repeat","It outputs the value 1 and ends"]$mq$, 0, $mq$n starts at 1 and gets bigger, so the condition n > 0 is always true. This is an infinite loop, a typical error in algorithm design.$mq$, $mq$medium$mq$),
($mq$An algorithm sets a = 1 and b = 1. It repeats 6 times: set c = a + b, set a = b, set b = c. It then outputs b. What does it output?$mq$, $mq$["13","34","8","21"]$mq$, 3, $mq$The values of b after each pass are 2, 3, 5, 8, 13, 21. After 6 repeats b = 21. This is the Fibonacci pattern.$mq$, $mq$hard$mq$),
($mq$An algorithm uses two loops: for i from 1 to 4, for j from i to 6, output the pair (i, j). How many pairs are output in total?$mq$, $mq$["24","16","18","10"]$mq$, 2, $mq$For i = 1, j takes 6 values; i = 2 gives 5; i = 3 gives 4; i = 4 gives 3. Total = 6 + 5 + 4 + 3 = 18. Assuming j always has 6 values would give 24.$mq$, $mq$hard$mq$),
($mq$An algorithm starts with x = 2. It repeats: replace x by 2x − 1 and output x. The outputs are 3, 5, 9, 17, ... Which rule gives the value after n repeats?$mq$, $mq$["2n + 1","2ⁿ + 1","3n","2ⁿ − 1"]$mq$, 1, $mq$Test n = 1: 2¹ + 1 = 3, n = 2: 2² + 1 = 5, n = 3: 2³ + 1 = 9, n = 4: 17. The rule 2n + 1 gives 3, 5, 7, so it fails at n = 3.$mq$, $mq$hard$mq$),
($mq$An algorithm should output the largest of a, b and c: Step 1 if a > b then max = a, otherwise max = b. Step 2 if c > b then max = c. Which test input shows that the algorithm is wrong?$mq$, $mq$["a = 9, b = 2, c = 5","a = 1, b = 2, c = 3","a = 3, b = 2, c = 1","a = 2, b = 9, c = 5"]$mq$, 0, $mq$For 9, 2, 5: step 1 sets max = 9, but step 2 checks 5 > 2 and replaces max with 5, which is wrong. Step 2 should compare c with max, not with b. The other inputs happen to give the right answer.$mq$, $mq$hard$mq$),
($mq$A linear search checks a sorted list of 1000 values one by one. A binary search halves the list each time. In the worst case, how many fewer checks does binary search need?$mq$, $mq$["500","999","900","990"]$mq$, 3, $mq$Linear search needs up to 1000 checks. Binary search needs at most 10, because 2⁹ = 512 < 1000 ≤ 2¹⁰ = 1024. The difference is 1000 − 10 = 990.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Algorithms and Flowcharts$mq$ and p.name = $mq$Networks and Algorithms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Algorithm$mq$, $mq$A finite, ordered list of precise steps that solves a problem and always ends.$mq$),
($mq$Flowchart shapes$mq$, $mq$Oval: start/stop. Rectangle: process. Diamond: decision. Parallelogram: input/output.$mq$),
($mq$Trace table$mq$, $mq$A table that records the value of each variable after every step or pass.$mq$),
($mq$Loop$mq$, $mq$A set of steps repeated until a condition is met, for example repeat until n > 4.$mq$),
($mq$Infinite loop$mq$, $mq$A loop whose stopping condition never becomes true, so the algorithm never ends.$mq$),
($mq$Bubble sort$mq$, $mq$Compare neighbours and swap if out of order; repeat passes until no swaps are needed.$mq$),
($mq$Binary search$mq$, $mq$In a sorted list, check the middle and discard half. At most k checks where 2ᵏ ≥ n.$mq$),
($mq$Euclid-style subtraction$mq$, $mq$Replace the larger of two numbers with the difference until they are equal; the result is the highest common factor.$mq$),
($mq$Good test input$mq$, $mq$One that makes different branches matter and can expose an error, not one that works by luck.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Algorithms and Flowcharts$mq$ and p.name = $mq$Networks and Algorithms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is an algorithm?
An algorithm is a finite list of clear, ordered steps that solves a problem. It must be precise (each step is unambiguous), it must end, and it should give the right output for every valid input. Everyday examples include a recipe, a route to school, or the steps your calculator uses to work out a square root.

## Ways to show an algorithm
A flowchart uses standard shapes joined by arrows:
- **Oval**: start or stop.
- **Rectangle**: a process or calculation, such as total = total + n.
- **Diamond**: a decision with a yes/no question and two exits.
- **Parallelogram**: input or output.

Pseudocode is a written version that looks like simple code, using words such as IF, THEN, ELSE, WHILE and FOR. It does not need to follow the rules of any particular programming language.

## Variables, loops and decisions
A variable is a named box that stores a value, such as total or n. Assignment means putting a new value in: n = n + 1 means "take the value of n, add 1 and store it back in n". A loop repeats steps until a condition is met. A decision (selection) chooses between two paths.

## Tracing an algorithm
Tracing means following the steps with real numbers and recording the value of each variable in a table, one row per pass. This is the most important skill. For example, start with total = 0 and n = 1, and repeat total = total + n², n = n + 1 until n > 4.
- n = 1: total = 1
- n = 2: total = 5
- n = 3: total = 14
- n = 4: total = 30, then n becomes 5 and the loop stops.

The output is 30. Always check the stopping condition carefully: "until n > 4" means the loop stops once n is 5, but n = 4 was still processed.

## Common algorithms
- **Repeated subtraction (Euclid-style)**: to find the highest common factor, subtract the smaller number from the larger until they are equal.
- **Bubble sort**: compare neighbours and swap if out of order. Repeat passes until no swaps are needed.
- **Binary search**: in a sorted list, check the middle value and discard half. For a list of n values you need at most k checks where 2ᵏ ≥ n.
- **Counting loops** and **running totals**, used in interest and growth models.

## Finding errors
A test input is useful if it reveals a mistake. Choose cases where different branches matter, for example a case where the first number is the largest, not just a case that works by chance. Typical errors include infinite loops (the condition never becomes false), off-by-one errors (stopping one pass too early or too late), and comparing the wrong variables.

## General rules
After tracing several outputs you can often describe a rule in terms of n. If x starts at 2 and each repeat doubles x then subtracts 1, the outputs are 3, 5, 9, 17, so the rule is 2ⁿ + 1. Always test your rule on at least two more cases.

## How this is examined
In the eAssessment you are given a real-life process (a taxi fare, a savings plan, a sorting job) written as a flowchart or pseudocode. You trace it, state the output, find a mistake, and then decide whether the algorithm is efficient or suitable. Extended tasks ask you to design your own algorithm, test it on new cases and evaluate its limits.

Exam tip: Draw a trace table and fill in every row. Do not skip passes in your head. State the final output clearly and include units if the context has them.$mq$ from st;

-- Optimisation > Linear Programming with Inequalities
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Optimisation$mq$, 5, 2 from public.subjects s where s.slug = $mq$extended-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Linear Programming with Inequalities$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$extended-mathematics$mq$ and p.grade = 5 and p.name = $mq$Optimisation$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Linear Programming with Inequalities$mq$ and p.name = $mq$Optimisation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$A van can carry at most 40 boxes. If x is the number of boxes, which inequality shows this?$mq$, $mq$["x ≤ 40","x ≥ 40","x < 40 only","x = 40"]$mq$, 0, $mq$"At most" means the number can be 40 or less, so x ≤ 40. "At least" would give x ≥ 40.$mq$, $mq$easy$mq$),
($mq$A shop must sell at least 5 phones (p) each day. Which inequality describes this?$mq$, $mq$["p ≤ 5","p > 5 only","p = 5","p ≥ 5"]$mq$, 3, $mq$"At least 5" includes 5 and anything bigger, so p ≥ 5.$mq$, $mq$easy$mq$),
($mq$Which point satisfies the inequality 2x + y ≤ 12?$mq$, $mq$["(5, 4)","(6, 1)","(3, 5)","(4, 5)"]$mq$, 2, $mq$Check each point. (3, 5) gives 6 + 5 = 11, which is ≤ 12. (5, 4) gives 14, (6, 1) gives 13, and (4, 5) gives 13, so these fail.$mq$, $mq$easy$mq$),
($mq$In a linear programming problem, what is the feasible region?$mq$, $mq$["The line with the highest profit","The set of points that satisfy all the constraints","The point where the axes cross","The set of points that break at least one constraint"]$mq$, 1, $mq$The feasible region contains every point that satisfies all the inequalities at the same time. The best solution is found in or on the edge of this region.$mq$, $mq$easy$mq$),
($mq$A bakery's profit is P = 30x + 20y, where x is the number of cakes and y is the number of loaves. What is P called?$mq$, $mq$["The objective function","The constraint","The feasible region","The boundary line"]$mq$, 0, $mq$The quantity you want to maximise or minimise (here profit) is the objective function. Constraints are the inequalities that limit x and y.$mq$, $mq$easy$mq$),
($mq$A bakery uses 2 hours of oven time per batch of cakes (x) and 1 hour per batch of loaves (y). There are 40 oven hours available. Where does the boundary line of 2x + y ≤ 40 cross the axes?$mq$, $mq$["(40, 0) and (0, 40)","(20, 0) and (0, 20)","(2, 0) and (0, 1)","(20, 0) and (0, 40)"]$mq$, 3, $mq$When y = 0, 2x = 40 so x = 20. When x = 0, y = 40. The line crosses at (20, 0) and (0, 40).$mq$, $mq$medium$mq$),
($mq$A bakery makes x batches of cakes and y batches of loaves. Cakes need 2 hours of oven time, loaves need 1 hour, and at most 40 oven hours are available. Which inequality models the oven time?$mq$, $mq$["x + 2y ≤ 40","2x + y ≥ 40","2x + y ≤ 40","3xy ≤ 40"]$mq$, 2, $mq$Total oven time is 2 hours per cake batch plus 1 hour per loaf batch: 2x + y. This must be at most 40. Swapping the coefficients, x + 2y, would mean the wrong item uses 2 hours.$mq$, $mq$medium$mq$),
($mq$The lines x + y = 30 and 2x + y = 40 are two boundaries of a feasible region. At which point do they cross?$mq$, $mq$["(20, 10)","(10, 20)","(10, 30)","(15, 15)"]$mq$, 1, $mq$Subtract the equations: (2x + y) − (x + y) = 40 − 30, so x = 10. Then y = 30 − 10 = 20. Check: 2(10) + 20 = 40.$mq$, $mq$medium$mq$),
($mq$The feasible region has corners at (0, 0), (20, 0), (10, 20) and (0, 30). The profit is P = 30x + 20y. What is the maximum profit?$mq$, $mq$["700","600","900","1200"]$mq$, 0, $mq$Evaluate P at each corner: 0, 600, 30(10) + 20(20) = 700, and 600. The maximum is 700 at (10, 20). The optimum for a linear objective is always at a corner.$mq$, $mq$medium$mq$),
($mq$How many points (x, y) with whole-number coordinates satisfy x ≥ 0, y ≥ 0 and x + y ≤ 3?$mq$, $mq$["6","9","16","10"]$mq$, 3, $mq$List them by x: x = 0 gives y = 0, 1, 2, 3 (4 points); x = 1 gives 3 points; x = 2 gives 2 points; x = 3 gives 1 point. Total 4 + 3 + 2 + 1 = 10.$mq$, $mq$medium$mq$),
($mq$Which region should be shaded to show y > 2x on a graph (using a dashed line y = 2x)?$mq$, $mq$["The region below the line","The region on both sides","The region above the line","Only the line itself"]$mq$, 2, $mq$Test a point such as (0, 5): 5 > 0 is true, and (0, 5) lies above the line. The line is dashed because > does not include equality.$mq$, $mq$medium$mq$),
($mq$For the profit P = 30x + 20y, what is the gradient of a line of constant profit when written as y = mx + c?$mq$, $mq$["3/2","−3/2","−2/3","−30"]$mq$, 1, $mq$Rearrange 30x + 20y = P to y = −(3/2)x + P/20. The gradient is −3/2. Every profit line is parallel, and the best one touches the feasible region at a corner.$mq$, $mq$medium$mq$),
($mq$A cost C = 3x + 5y is to be minimised subject to x + y ≥ 10, x ≤ 8, y ≥ 1 and x ≥ 0. Which whole-number point gives the minimum cost, and what is it?$mq$, $mq$["(8, 2) with cost 34","(9, 1) with cost 32","(0, 10) with cost 50","(8, 1) with cost 29"]$mq$, 0, $mq$The corners of the region are (8, 2) and (0, 10). (9, 1) breaks x ≤ 8 and (8, 1) breaks x + y ≥ 10, so they are not allowed. C = 24 + 10 = 34 at (8, 2) compared with 50 at (0, 10).$mq$, $mq$medium$mq$),
($mq$A tree-selling business models profit with P = 30x + 20y subject to x + y ≤ 30, 2x + y ≤ 40, y ≤ 15, x ≥ 0 and y ≥ 0. The corner (12.5, 15) gives the maximum, but trees cannot be split. Which whole-number plan gives the greatest profit?$mq$, $mq$["x = 12, y = 15 with profit 660","x = 13, y = 15 with profit 690","x = 12.5, y = 15 with profit 675","x = 13, y = 14 with profit 670"]$mq$, 3, $mq$x = 13, y = 15 breaks 2x + y ≤ 40 (41). (13, 14) gives 2(13) + 14 = 40 and profit 390 + 280 = 670. (12, 15) gives 660. 675 needs a half item, so it is not allowed.$mq$, $mq$hard$mq$),
($mq$A school buys x laptops and y tablets. It buys at most 30 devices in total, at least twice as many tablets as laptops, and spends at most £9000. Laptops cost £600 and tablets cost £250. Which set of inequalities models this?$mq$, $mq$["x + y ≤ 30, x ≥ 2y, 600x + 250y ≤ 9000","x + y ≥ 30, y ≥ 2x, 600x + 250y ≤ 9000","x + y ≤ 30, y ≥ 2x, 600x + 250y ≤ 9000","x + y ≤ 30, y ≥ 2x, 250x + 600y ≤ 9000"]$mq$, 2, $mq$"At least twice as many tablets as laptops" gives y ≥ 2x. The cost uses 600 per laptop (x) and 250 per tablet (y). The device limit "at most" gives ≤.$mq$, $mq$hard$mq$),
($mq$Using x + y ≤ 30, y ≥ 2x and 600x + 250y ≤ 9000 for laptops (x) and tablets (y), what is the greatest number of laptops the school can buy?$mq$, $mq$["9","8","10","15"]$mq$, 1, $mq$Buying more tablets only increases cost, so test y = 2x. Then the cost is 600x + 500x = 1100x ≤ 9000 gives x ≤ 8.18. With x = 8, y = 16 costs £8800 and 24 devices. x = 9 would need y = 18 and cost £9900.$mq$, $mq$hard$mq$),
($mq$The corners of a feasible region are (0, 0), (20, 0), (10, 20) and (0, 30). The profit on chairs rises so the objective is now P = 30x + 40y. Where is the maximum profit now, and what is it?$mq$, $mq$["(0, 30) with profit 1200","(10, 20) with profit 1100","(20, 0) with profit 600","(10, 20) with profit 700"]$mq$, 0, $mq$Evaluate: (0, 0) gives 0, (20, 0) gives 600, (10, 20) gives 300 + 800 = 1100, and (0, 30) gives 1200. A change in the objective can move the optimum to a different corner.$mq$, $mq$hard$mq$),
($mq$With x + y ≤ 30 and 2x + y ≤ 40, the maximum of P = 30x + 20y is 700. The oven is upgraded so the second constraint becomes 2x + y ≤ 50. What is the new maximum profit?$mq$, $mq$["700","750","900","800"]$mq$, 3, $mq$The new corners are (0, 0), (25, 0), (20, 10) and (0, 30), where x = 20, y = 10 comes from x + y = 30 and 2x + y = 50. P values are 0, 750, 800 and 600. The maximum is 800.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Linear Programming with Inequalities$mq$ and p.name = $mq$Optimisation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$At most / no more than$mq$, $mq$Means ≤. For example, at most 40 boxes: x ≤ 40.$mq$),
($mq$At least / a minimum of$mq$, $mq$Means ≥. For example, at least 5 sold: p ≥ 5.$mq$),
($mq$Constraint$mq$, $mq$An inequality that limits the variables, such as 2x + y ≤ 40.$mq$),
($mq$Feasible region$mq$, $mq$The set of points that satisfy all the constraints at once.$mq$),
($mq$Objective function$mq$, $mq$The expression to maximise or minimise, such as profit P = 30x + 20y.$mq$),
($mq$Where is the optimum?$mq$, $mq$At a corner (vertex) of the feasible region, for a linear objective function.$mq$),
($mq$Method of corners$mq$, $mq$Find all corners, substitute each into the objective function, and pick the largest or smallest.$mq$),
($mq$Solid or dashed line?$mq$, $mq$Solid for ≤ or ≥ (boundary included); dashed for < or > (boundary not included).$mq$),
($mq$Whole-number answers$mq$, $mq$If items cannot be split, check whole-number points near the best corner that still satisfy every constraint.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Linear Programming with Inequalities$mq$ and p.name = $mq$Optimisation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Turning words into inequalities
Linear programming is a way to find the best choice (the most profit or the least cost) when there are limits on what you can do. First, define your variables, for example x = number of cakes and y = number of loaves. Then write each limit as an inequality.
- "At most", "no more than", "up to": use ≤.
- "At least", "no fewer than", "a minimum of": use ≥.
- "At least twice as many y as x": y ≥ 2x.
- Quantities cannot be negative, so x ≥ 0 and y ≥ 0 are almost always needed.

## Drawing the feasible region
For each inequality, draw the boundary line (replace the inequality sign with =). Find two points, usually the axis intercepts. For 2x + y ≤ 40, set y = 0 to get x = 20 and set x = 0 to get y = 40. Use a solid line for ≤ or ≥, and a dashed line for < or >. Then test a point, such as (0, 0), to decide which side to shade. If it satisfies the inequality, shade the side containing it. The feasible region is where all the shaded conditions overlap. Every point inside it satisfies all the constraints.

## The objective function
The objective function is the quantity you want to optimise, such as profit P = 30x + 20y. A key fact is that, for a linear objective, the maximum or minimum always occurs at a corner (vertex) of the feasible region. So the method is:
- Find the coordinates of every corner, by reading from the graph or solving two boundary equations together.
- Substitute each corner into the objective function.
- Choose the largest value for a maximum, or the smallest for a minimum.

Worked example: with x + y ≤ 30 and 2x + y ≤ 40, the corners are (0, 0), (20, 0), (10, 20) and (0, 30). The point (10, 20) comes from solving x + y = 30 and 2x + y = 40 (subtract to get x = 10, then y = 20). Profit values are 0, 600, 700 and 600. The best plan is x = 10 and y = 20 with a profit of 700.

## Profit lines
All lines P = 30x + 20y are parallel, with gradient −3/2. Sliding such a line away from the origin shows which corner is touched last. It also shows why a change in the profit per item, for example P = 30x + 40y, can move the best corner.

## Whole numbers
If the items cannot be split, the answer must be whole numbers. The best corner may have a fraction, such as (12.5, 15). Then you must check the whole-number points near it that still obey every constraint. Rounding up can break a constraint, so test each one.

## Common mistakes
- Reversing the coefficients, such as writing x + 2y when cakes need 2 hours.
- Using ≥ when the words say "at most".
- Forgetting x ≥ 0 and y ≥ 0.
- Reading a corner from a graph without checking it in both equations.
- Giving the profit but not the plan, or the plan but not the profit.

## How this is examined
Questions give a context, for example a bakery, a school budget or a workshop, with the limits in words and numbers. You must form the inequalities, represent the region, find the corners and state the best plan. Extended tasks ask you to state assumptions (such as all items sell, or prices stay constant), check whether answers must be whole numbers, and judge how the plan changes if a limit changes.

Exam tip: Always finish with a sentence in context, such as "The bakery should make 10 batches of cakes and 20 batches of loaves for a maximum profit of 700." Check your corner by substituting it into every constraint.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('extended-mathematics')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;