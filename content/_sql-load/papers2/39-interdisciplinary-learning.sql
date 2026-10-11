-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Interdisciplinary Learning MYP 5 eAssessment-style Practice Paper 1 (40 marks)
with sub as (select id from public.subjects where slug = $mq$interdisciplinary-learning$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Interdisciplinary Learning MYP 5 eAssessment-style Practice Paper 1$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Interdisciplinary Learning MYP 5 eAssessment-style Practice Paper 1$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Case study: Keeping Marlow Cool (Sciences and Individuals and Societies)

The fictional city of Marlow is planning how to respond to hotter summers. On one afternoon in July, students measured air temperature at five sites.

Source A: Air temperature at 3 pm
Public park: 24.1 °C
Residential street: 27.3 °C
City centre (shops and offices): 31.2 °C
Industrial estate: 29.8 °C
River bank: 25.0 °C

Source B: Land use
The city centre covers 4.5 km² and has 18 000 residents. It has 6% tree cover. The park area has 55% tree cover. Most roofs and roads in the centre are dark grey.

(a) Calculate the difference in temperature between the city centre and the public park. (1 mark)
(b) Calculate the mean temperature of the five sites, giving your answer to 1 decimal place. (2 marks)
(c) Use scientific ideas to explain why dark grey roofs and roads make the city centre warmer than the park. (2 marks)

(Total 5 marks)$mq$, $mq$(a) [1] 31.2 − 24.1 = 7.1 °C
(b) [1] (24.1 + 27.3 + 31.2 + 29.8 + 25.0) ÷ 5 = 137.4 ÷ 5 = 27.48
[1] 27.5 °C (1 decimal place)
(c) [1] Dark surfaces absorb more of the Sun's radiation (and reflect less)
[1] The absorbed energy is transferred as heat to the surface and the air above, so the centre warms more; trees in the park give shade and cool the air by evaporation of water (accept either)$mq$, $mq$A$mq$),
(2, $mq$Case study: Keeping Marlow Cool (Sciences and Individuals and Societies)

The fictional city of Marlow is planning how to respond to hotter summers. On one afternoon in July, students measured air temperature at five sites.

Source A: Air temperature at 3 pm
Public park: 24.1 °C
Residential street: 27.3 °C
City centre (shops and offices): 31.2 °C
Industrial estate: 29.8 °C
River bank: 25.0 °C

Source B: Land use
The city centre covers 4.5 km² and has 18 000 residents. It has 6% tree cover. The park area has 55% tree cover. Most roofs and roads in the centre are dark grey.

(a) Calculate the population density of the city centre in people per km². (2 marks)
(b) Explain, using ideas from Individuals and Societies, how a high population density can lead to little tree cover in the city centre. (2 marks)
(c) State one contribution that Sciences makes and one contribution that Individuals and Societies makes to understanding the problem of urban heat. (2 marks)

(Total 6 marks)$mq$, $mq$(a) [1] 18 000 ÷ 4.5
[1] 4000 people per km²
(b) [1] Land is in high demand for housing, shops and offices, so it is built on rather than left as green space
[1] Land in the centre is valuable / costly, so developers and planners prioritise buildings and roads over trees (accept transport and parking needs)
(c) [1] Sciences: measures and explains the physical causes (heat absorption, temperature data, evaporation)
[1] Individuals and Societies: explains the human causes and effects (land use, planning decisions, who is affected, costs)$mq$, $mq$A$mq$),
(3, $mq$The Marlow council is considering three ways to cool the city centre.

Source C: Council options
Option 1, tree planting: cost £2.0 million, expected cooling 1.8 °C, full effect after 15 years.
Option 2, reflective paving: cost £3.5 million, expected cooling 1.2 °C, works immediately.
Option 3, green roofs: cost £6.0 million, expected cooling 2.4 °C, full effect after 8 years.

(a) Calculate the cost per °C of cooling for each option, in £ million, to 2 decimal places. (3 marks)
(b) A councillor says, "We should simply choose the cheapest option per degree of cooling." Using both scientific and social or economic ideas, explain why this might not be the best decision. (3 marks)

(Total 6 marks)$mq$, $mq$(a) [1] Option 1: 2.0 ÷ 1.8 = £1.11 million per °C
[1] Option 2: 3.5 ÷ 1.2 = £2.92 million per °C
[1] Option 3: 6.0 ÷ 2.4 = £2.50 million per °C
(b) [1] Scientific idea: cooling is not only about cost, for example trees also take years to grow, so the benefit is delayed during hot summers now (or trees absorb CO₂ and give shade)
[1] Social or economic idea: for example residents most at risk (older people) need cooling soon; green spaces also improve wellbeing; maintenance costs and public support matter
[1] A clear link that combines both, concluding that cost per degree should be balanced against timing, wider benefits and fairness$mq$, $mq$B$mq$),
(4, $mq$Marlow Council wants a short briefing for residents. Using Sources A to C, write a paragraph of about 100 words explaining why the city centre is hotter than the park and recommending one of the three options. You will be marked on how well you communicate to a general audience, not on the option you choose. (6 marks)

(Total 6 marks)$mq$, $mq$[1] A clear purpose and audience: the paragraph addresses residents and states the problem
[1] Accurate data from the sources is used (for example 31.2 °C and 24.1 °C, a 7.1 °C difference)
[1] Technical terms from both subjects are used and explained (for example absorb radiation, land use, population density)
[1] A logical structure: problem, cause, options, recommendation
[1] An appropriate, clear register with no unexplained jargon
[1] A justified recommendation that refers to at least one option's cost, cooling or timing$mq$, $mq$C$mq$),
(5, $mq$The students who collected Source A took readings at only one time (3 pm) on one day in July, using one thermometer at each site.

(a) Identify two limitations of this data collection. (2 marks)
(b) Describe how combining Sciences and Individuals and Societies gave you a better understanding of the heat problem than using one subject alone. (3 marks)

(Total 5 marks)$mq$, $mq$(a) [1] One day / one time only, so the readings may not be typical (weather and time of day vary)
[1] One thermometer per site, so no repeats or averages; position (sun or shade) may affect the reading (accept a second valid limitation)
(b) [1] Science explained why the temperatures differ
[1] Individuals and Societies explained why the land use and the decisions that cause it exist, and who is affected
[1] Together they led to a more complete, realistic solution than either alone (for example choosing an option considering both cooling and cost and fairness)$mq$, $mq$D$mq$),
(6, $mq$Marlow Council surveyed 400 residents about tree planting (Option 1).

Source D: Survey results
Support tree planting even if council tax rises by £15 per year: 62%
Do not support: 28%
Not sure: 10%

Source E: Comment from a shop owner
"Planting trees means removing 40 parking spaces outside the shops. My customers drive here. I would lose business."

(a) Calculate the number of residents who support tree planting. (1 mark)
(b) Source E raises a concern. Explain how the council could use both scientific and social ideas to respond to this concern. (3 marks)
(c) Make a recommendation about Option 1 that takes account of Sources A to E. Justify it. (3 marks)

(Total 7 marks)$mq$, $mq$(a) [1] 62% of 400 = 248 residents
(b) [1] Scientific: trees could still be placed where they give most shade and cooling, or on streets without parking, so benefits are maximised with fewer spaces lost
[1] Social: consult the shop owners, offer alternative parking or public transport, and consider that cooler, shadier streets may attract more shoppers
[1] A link between the two: balance cooling gains with business needs and fairness
(c) [1] A clear recommendation (for example proceed with tree planting, perhaps combined with another option)
[1] Uses evidence from at least two sources (for example 62% support, 1.8 °C cooling, lowest cost per °C, parking concern)
[1] Acknowledges a limitation or compromise (for example the 15 years' delay, the 28% who do not support)$mq$, $mq$B$mq$),
(7, $mq$Reflect on your own thinking when answering this paper.

(a) Describe one assumption you made when you used the data in Sources A to E. (2 marks)
(b) Explain one way in which the council could improve the evidence before making a final decision. (3 marks)

(Total 5 marks)$mq$, $mq$(a) [1] Identifies a relevant assumption (for example that the 3 pm readings are typical of summer, or that the survey sample represents all residents)
[1] Explains why this assumption matters or what could go wrong
(b) [1] A specific improvement (for example repeat measurements on several days and times, or survey more residents including shop owners)
[1] Explains how this makes the evidence more reliable or less biased
[1] Links the improvement to the decision (for example it would show whether the cooling estimates and public support are accurate)$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
