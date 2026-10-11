-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Interdisciplinary Learning MYP 5 eAssessment-style Practice Paper 2 (40 marks)
with sub as (select id from public.subjects where slug = $mq$interdisciplinary-learning$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Interdisciplinary Learning MYP 5 eAssessment-style Practice Paper 2$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Interdisciplinary Learning MYP 5 eAssessment-style Practice Paper 2$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Case study: The Fish of Lake Tamsin (Sciences, Mathematics and Individuals and Societies)

Lake Tamsin is a fictional lake in a small country. Fishing is the main job for 140 people in the village of Tamsin Bay. A biologist monitors the stock of the main fish, the lake perch, and the fishing co-operative records the catch.

Source A: Perch stock and catch (tonnes)
Year: 2019, 2020, 2021, 2022, 2023, 2024
Estimated stock: 1200, 1130, 1040, 950, 880, 790
Catch: 220, 235, 250, 260, 270, 275

Source B: Economic information
The co-operative sells perch for $2400 per tonne. A tourist lodge on the lake employs 12 people and relies on anglers who come to catch perch for sport.

(a) Describe the trend in the estimated perch stock from 2019 to 2024. (1 mark)
(b) Calculate the percentage decrease in the estimated stock from 2019 to 2024, to 1 decimal place. (2 marks)
(c) The biologist says the lake is being overfished. Using biological ideas, explain how a catch that is too large can cause the stock to fall. (3 marks)

(Total 6 marks)$mq$, $mq$(a) [1] The stock falls every year (from 1200 to 790 tonnes)
(b) [1] (1200 − 790) ÷ 1200 × 100 = 410 ÷ 1200 × 100
[1] 34.2%
(c) [1] A population stays stable only if the number of fish born (and growing) replaces the number removed
[1] If more fish are caught than are replaced by reproduction, the number of breeding adults falls
[1] Fewer breeding adults produce fewer young, so the population declines further each year (a cycle)$mq$, $mq$A$mq$),
(2, $mq$Case study: The Fish of Lake Tamsin (Sciences, Mathematics and Individuals and Societies)

Lake Tamsin is a fictional lake in a small country. Fishing is the main job for 140 people in the village of Tamsin Bay. A biologist monitors the stock of the main fish, the lake perch, and the fishing co-operative records the catch.

Source A: Perch stock and catch (tonnes)
Year: 2019, 2020, 2021, 2022, 2023, 2024
Estimated stock: 1200, 1130, 1040, 950, 880, 790
Catch: 220, 235, 250, 260, 270, 275

Source B: Economic information
The co-operative sells perch for $2400 per tonne. A tourist lodge on the lake employs 12 people and relies on anglers who come to catch perch for sport.

(a) Calculate the co-operative's income from the 2024 catch. (1 mark)
(b) Calculate the average income from the 2024 catch for each of the 140 fishers, to the nearest dollar. (2 marks)
(c) Explain, using ideas from Individuals and Societies, why a fishing limit could reduce income in the short term but protect jobs in the long term. (3 marks)

(Total 6 marks)$mq$, $mq$(a) [1] 275 × 2400 = $660 000
(b) [1] 660 000 ÷ 140
[1] $4714 (4714.29 to the nearest dollar)
(c) [1] A limit means fewer tonnes sold now, so income falls in the short term
[1] If the stock recovers, the lake can keep supporting fishing for many years (sustainability: resources must last)
[1] Jobs and village life depend on the resource, so protecting it protects employment and the community (accept: tourism jobs also depend on healthy fish)$mq$, $mq$A$mq$),
(3, $mq$The government proposes three catch rules for the next five years. A biologist has predicted the effect of each on the stock.

Source C: Options
Option 1: limit the catch to 150 tonnes a year. Predicted stock after five years: about 1000 tonnes.
Option 2: limit the catch to 220 tonnes a year. Predicted stock after five years: about 600 tonnes.
Option 3: limit the catch to 200 tonnes a year plus a closed breeding season. Predicted stock after five years: about 800 tonnes.

(a) Using the price of $2400 per tonne, calculate the yearly income for the co-operative if it catches the full limit under each option. (3 marks)
(b) Evaluate the three options by combining the predicted stock levels and the incomes. Recommend one and justify it. (4 marks)

(Total 7 marks)$mq$, $mq$(a) [1] Option 1: 150 × 2400 = $360 000
[1] Option 2: 220 × 2400 = $528 000
[1] Option 3: 200 × 2400 = $480 000
(b) [1] Uses the science: Option 2 lets the stock keep falling (600 tonnes), so it is not sustainable
[1] Uses the economics: Option 1 gives the lowest income now ($360 000) but the largest recovery (1000 tonnes)
[1] Compares Option 3 as a balance (higher income than Option 1, stock roughly stable at about 800)
[1] A clear recommendation justified with both kinds of evidence (accept Option 1 or Option 3 with sound reasoning)$mq$, $mq$B$mq$),
(4, $mq$The council will explain Source A to villagers at a public meeting. Describe how you would present the data on stock and catch in a graph that villagers can understand. Include the type of graph, what you would show on each axis, and two other features that make the graph clear. (6 marks)

(Total 6 marks)$mq$, $mq$[1] An appropriate graph type, for example a line graph with year along the horizontal axis (or a bar chart with two series)
[1] Correct variables and axes: year on the horizontal axis and tonnes on the vertical axis
[1] Both data sets (stock and catch) are shown, with a key or labels to tell them apart
[1] Axes are labelled with units (tonnes) and sensibly scaled
[1] A clear title and the source (for example "Perch stock and catch in Lake Tamsin, 2019 to 2024")
[1] A short plain-language message for the audience (for example the catch has grown while the stock has fallen)$mq$, $mq$C$mq$),
(5, $mq$Read two statements about the lake.

Source D: Statement by the biologist
"The stock has fallen every year since 2019. Fish need time to grow and breed. If the catch stays at 275 tonnes, the stock may fall below 500 tonnes within five years."

Source E: Statement by the co-operative chair
"Our families have fished here for generations. If you cut our catch, many of us will have no income. The lake has had bad years before and the fish have always come back."

(a) Identify one point on which the two statements agree and one on which they disagree. (2 marks)
(b) Suggest a compromise that uses ideas from both subject groups and explain why it could be acceptable to both people. (4 marks)

(Total 6 marks)$mq$, $mq$(a) [1] Agree: the lake is important and the fish stock matters to both (accept: both accept the stock has changed or that fish need time to recover)
[1] Disagree: the biologist says the catch must fall to protect the stock, while the chair argues cutting the catch harms livelihoods and that the fish will recover without action
(b) [1] A specific compromise (for example a gradual reduction of the catch, a closed breeding season, or support for other jobs such as fish farming or tourism)
[1] The scientific reason it helps the stock (for example breeding adults are protected so the population can recover)
[1] The social or economic reason it protects people (for example income continues or alternative income is provided)
[1] Explains why each person could accept it (the biologist's concern is addressed and the chair's concern is addressed)$mq$, $mq$B$mq$),
(6, $mq$Source E is written by the chair of the fishing co-operative. Source D is written by the biologist.

(a) Explain one way in which the position or interests of the chair might affect the reliability of Source E. (2 marks)
(b) Explain one limitation of the biologist's data in Source A. (1 mark)
(c) Describe how your own view of the problem changed as you worked through the sources. (2 marks)

(Total 5 marks)$mq$, $mq$(a) [1] The chair's income and community depend on fishing, so there may be bias towards continuing a high catch
[1] This could lead them to understate the risk or make claims without evidence (for example "the fish have always come back")
(b) [1] The stock is an estimate, not an exact count (or it covers only six years and one species), so the predictions are uncertain
(c) [1] Describes an initial view and a change or a deepening of that view
[1] Links the change to a specific source or piece of evidence$mq$, $mq$D$mq$),
(7, $mq$Rewrite this sentence from a scientific report so that villagers with no science background can understand it. Keep all the important information. (4 marks)

"The perch population exhibits a sustained negative trend in biomass, attributable to an annual harvest that exceeds the replacement rate."

(Total 4 marks)$mq$, $mq$[1] Replaces "perch population" and "biomass" with plain terms (for example "the number of perch" or "the amount of fish in the lake")
[1] Explains "negative trend" as a fall each year
[1] Explains "harvest exceeds replacement rate" as "more fish are caught than are born and grow to replace them"
[1] A clear, complete sentence or two with a suitable tone (for example "The amount of perch in the lake falls every year because we catch more fish than the lake can replace.")$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
