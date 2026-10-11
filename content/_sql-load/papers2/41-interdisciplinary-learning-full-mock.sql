-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Interdisciplinary Learning MYP 5 Full eAssessment Mock (100 marks)
with sub as (select id from public.subjects where slug = $mq$interdisciplinary-learning$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Interdisciplinary Learning MYP 5 Full eAssessment Mock$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Interdisciplinary Learning MYP 5 Full eAssessment Mock$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Case study 1: Lumen Nights (Sciences and The Arts)

The fictional city of Harbourgate holds a ten-night light festival called Lumen Nights. Artists create glowing installations on the waterfront, and the organisers want to use energy sensibly.

Source A: Lighting data
Number of light fixtures: 800
Power of one LED fixture: 12 W
Power of one older halogen fixture: 50 W
Lights are on for 6 hours each night for 10 nights.
Electricity costs £0.30 per kWh. Generating 1 kWh of electricity releases 0.2 kg of carbon dioxide.

Source B: Notes from the lead artist
"We use white light and coloured plastic filters. A red filter placed in front of a white lamp gives a red glow. Our red filters give light with a wavelength of about 700 nm. I choose warm colours for the entrance to make visitors feel welcome. We also have visitors from many countries and I know colours can mean different things in different places."

Source C: Visitor survey and costs
Visitors surveyed: 1200 (assume this is the total number of visitors)
Visitors from outside Harbourgate: 45%
Average spending in the city per visitor from outside: £38
Average spending in the city per local visitor: £12
Cost of running the festival: £30 000

(a) Calculate the total energy used by the 800 LED fixtures over the whole festival, in kWh. Show your working. (3 marks)
(b) The organisers consider using halogen fixtures instead. Calculate the energy used by 800 halogen fixtures over the whole festival, in kWh. (2 marks)
(c) Calculate the mass of carbon dioxide avoided by using LED instead of halogen fixtures. (3 marks)
(d) Calculate the money saved on electricity by using LED fixtures. (2 marks)
(e) Explain, using ideas about energy transfer, why an LED can give a similar amount of light with a lower power. (2 marks)

(Total 12 marks)$mq$, $mq$(a) [1] 800 × 12 W = 9600 W = 9.6 kW
[1] Time = 6 × 10 = 60 hours, so energy = 9.6 kW × 60 h
[1] 576 kWh
(b) [1] 800 × 50 W = 40 000 W = 40 kW, and 40 × 60
[1] 2400 kWh
(c) [1] Energy saved = 2400 − 576 = 1824 kWh
[1] 1824 × 0.2
[1] 364.8 kg of carbon dioxide
(d) [1] 1824 × 0.30
[1] £547.20 (accept £547)
(e) [1] A halogen lamp transfers much of its input energy as heat (thermal energy) rather than light, so it is wasteful
[1] An LED transfers a greater fraction of the input energy as light, so less power is needed for the same light output (it is more efficient)$mq$, $mq$A$mq$),
(2, $mq$Case study 1: Lumen Nights (Sciences and The Arts)

The fictional city of Harbourgate holds a ten-night light festival called Lumen Nights. Artists create glowing installations on the waterfront, and the organisers want to use energy sensibly.

Source A: Lighting data
Number of light fixtures: 800
Power of one LED fixture: 12 W
Power of one older halogen fixture: 50 W
Lights are on for 6 hours each night for 10 nights.
Electricity costs £0.30 per kWh. Generating 1 kWh of electricity releases 0.2 kg of carbon dioxide.

Source B: Notes from the lead artist
"We use white light and coloured plastic filters. A red filter placed in front of a white lamp gives a red glow. Our red filters give light with a wavelength of about 700 nm. I choose warm colours for the entrance to make visitors feel welcome. We also have visitors from many countries and I know colours can mean different things in different places."

Source C: Visitor survey and costs
Visitors surveyed: 1200 (assume this is the total number of visitors)
Visitors from outside Harbourgate: 45%
Average spending in the city per visitor from outside: £38
Average spending in the city per local visitor: £12
Cost of running the festival: £30 000

(a) Explain why white light passing through a red filter looks red. (2 marks)
(b) Predict and explain what a person sees when blue light shines on the red filter. (2 marks)
(c) Calculate the frequency of the red light in Source B. Use the speed of light 3.0 × 10⁸ m/s and the equation speed = frequency × wavelength. Give your answer in Hz in standard form to 2 significant figures. (3 marks)
(d) Explain how the lead artist's choice of warm colours can affect the mood of visitors. (2 marks)
(e) Give one example of a colour having different meanings in different cultures and explain what this means for the artist's international audience. (3 marks)

(Total 12 marks)$mq$, $mq$(a) [1] White light contains all the colours (a mixture of wavelengths)
[1] The red filter transmits (lets through) red light and absorbs the other colours
(b) [1] The filter looks dark / black (little or no light passes through)
[1] Blue light is absorbed by the red filter, because a red filter only transmits red
(c) [1] f = speed ÷ wavelength, with 700 nm = 7.0 × 10⁻⁷ m
[1] 3.0 × 10⁸ ÷ 7.0 × 10⁻⁷
[1] 4.3 × 10¹⁴ Hz
(d) [1] Warm colours (reds, oranges, yellows) are associated with energy, comfort or friendliness
[1] Used at the entrance, they give a first impression of welcome and excitement
(e) [1] A valid example, for example red means good luck and celebration in China, but it can mean danger or warning in many other countries; or white is linked to mourning in some East Asian cultures and to weddings in many Western ones
[1] Visitors may interpret the same installation differently
[1] The artist should research meanings, use colours with wide positive associations, or add explanations so the meaning is not misunderstood$mq$, $mq$A$mq$),
(3, $mq$Case study 1: Lumen Nights (Sciences and The Arts)

The fictional city of Harbourgate holds a ten-night light festival called Lumen Nights. Artists create glowing installations on the waterfront, and the organisers want to use energy sensibly.

Source A: Lighting data
Number of light fixtures: 800
Power of one LED fixture: 12 W
Power of one older halogen fixture: 50 W
Lights are on for 6 hours each night for 10 nights.
Electricity costs £0.30 per kWh. Generating 1 kWh of electricity releases 0.2 kg of carbon dioxide.

Source B: Notes from the lead artist
"We use white light and coloured plastic filters. A red filter placed in front of a white lamp gives a red glow. Our red filters give light with a wavelength of about 700 nm. I choose warm colours for the entrance to make visitors feel welcome. We also have visitors from many countries and I know colours can mean different things in different places."

Source C: Visitor survey and costs
Visitors surveyed: 1200 (assume this is the total number of visitors)
Visitors from outside Harbourgate: 45%
Average spending in the city per visitor from outside: £38
Average spending in the city per local visitor: £12
Cost of running the festival: £30 000

(a) Calculate how many of the visitors came from outside Harbourgate and how many were local. (2 marks)
(b) Calculate the total money spent in the city by all 1200 visitors. Show your working. (3 marks)
(c) Calculate the difference between the visitors' spending and the cost of running the festival. (1 mark)
(d) A councillor argues that the festival should not run again because the festival costs more than the visitors spend. Evaluate this view using your calculations and ideas from Sciences and The Arts. (7 marks)

(Total 13 marks)$mq$, $mq$(a) [1] Outside: 45% of 1200 = 540
[1] Local: 1200 − 540 = 660
(b) [1] Outside visitors: 540 × 38 = £20 520
[1] Local visitors: 660 × 12 = £7920
[1] Total = £28 440
(c) [1] 28 440 − 30 000 = −£1560 (spending is £1560 less than the cost)
(d) [1] Uses the calculation: the direct spending does not cover the cost (by £1560, a small difference of about 5%)
[1] Notes that spending only counts visitors' spending, not other benefits such as tourism that continues after the festival or local business income
[1] Uses the science: LED lighting saves 1824 kWh and about 364.8 kg of CO₂, and £547.20 of electricity, so the real running cost can be reduced
[1] Uses the arts: the festival has cultural value, gives artists a platform and builds community pride, which cannot easily be measured in £
[1] Considers a limitation of the data (for example survey of visitors only, average spending, one year)
[1] Considers alternatives (for example ticket income, sponsorship, using more LEDs)
[1] A clear, justified judgement that combines the quantitative and non-quantitative evidence$mq$, $mq$B$mq$),
(4, $mq$Case study 1: Lumen Nights (Sciences and The Arts)

The fictional city of Harbourgate holds a ten-night light festival called Lumen Nights. Artists create glowing installations on the waterfront, and the organisers want to use energy sensibly.

Source A: Lighting data
Number of light fixtures: 800
Power of one LED fixture: 12 W
Power of one older halogen fixture: 50 W
Lights are on for 6 hours each night for 10 nights.
Electricity costs £0.30 per kWh. Generating 1 kWh of electricity releases 0.2 kg of carbon dioxide.

Source B: Notes from the lead artist
"We use white light and coloured plastic filters. A red filter placed in front of a white lamp gives a red glow. Our red filters give light with a wavelength of about 700 nm. I choose warm colours for the entrance to make visitors feel welcome. We also have visitors from many countries and I know colours can mean different things in different places."

Source C: Visitor survey and costs
Visitors surveyed: 1200 (assume this is the total number of visitors)
Visitors from outside Harbourgate: 45%
Average spending in the city per visitor from outside: £38
Average spending in the city per local visitor: £12
Cost of running the festival: £30 000

The organisers want to publish a short press release (about 120 words) for an international audience. It should explain how Lumen Nights uses LED lighting to cut energy use, say something about the artistic choices, and invite visitors to attend. Write the press release. (12 marks)

(Total 12 marks)$mq$, $mq$Award one mark for each of the following (maximum 12).
[1] A clear, attractive headline or opening that identifies the festival
[1] States the dates, location or practical details for visitors (accept invented but sensible details)
[1] Uses accurate numerical data (for example 576 kWh instead of 2400 kWh, or 364.8 kg of CO₂ avoided)
[1] Explains the energy saving in terms an audience can follow (for example LEDs waste less energy as heat)
[1] Uses science vocabulary correctly (for example energy, power, efficiency, wavelength, filter)
[1] Describes at least one artistic choice (for example warm colours at the entrance)
[1] Mentions that colour can have different meanings and welcomes people of all cultures
[1] Tone and register suited to a press release (positive, professional)
[1] Logical structure with paragraphs: opening, details, invitation
[1] Clear invitation or call to action
[1] Appropriate length (about 100 to 140 words) and concise writing
[1] Accurate spelling, grammar and sentence structure that make the text easy to read$mq$, $mq$C$mq$),
(5, $mq$Case study 2: Food Waste at Riverside School (Sciences, Mathematics and Individuals and Societies)

Riverside School has 600 students. The student council weighed the food thrown away in the canteen over one week in March.

Source D: Food waste, one week
Monday: 38 kg
Tuesday: 45 kg
Wednesday: 41 kg
Thursday: 52 kg
Friday: 34 kg
The school year has 190 school days. Wasted food costs the school about £2.50 per kg.

Source E: Student survey (300 students, who could choose one main reason)
Portions are too large: 46%
I do not like the taste: 31%
I do not have enough time to eat: 15%
Other reasons: 8%

Source F: Proposals
Proposal 1: offer small, medium and large portions. Estimated to reduce waste by 25%.
Proposal 2: send the remaining food waste to a composting service instead of the bin. Estimated to cost £6000 per year and to divert 80% of the remaining waste from landfill.
Note: food waste buried in landfill rots without oxygen and releases methane.

(a) Calculate the mean mass of food waste per day. (2 marks)
(b) Calculate the mean mass of food wasted per student per day, in grams. (2 marks)
(c) Estimate the total mass of food wasted in a school year of 190 days. State the assumption you make. (2 marks)
(d) Explain, using scientific ideas, why sending food waste to landfill is harmful to the environment. (3 marks)
(e) Calculate the cost of the wasted food over a school year, and explain why this matters for the school. (3 marks)

(Total 12 marks)$mq$, $mq$(a) [1] (38 + 45 + 41 + 52 + 34) ÷ 5 = 210 ÷ 5
[1] 42 kg per day
(b) [1] 42 kg = 42 000 g, and 42 000 ÷ 600
[1] 70 g per student per day
(c) [1] 42 × 190 = 7980 kg
[1] Assumption: the week measured is typical of the whole year (every school day is similar)
(d) [1] In landfill there is little oxygen, so food rots by anaerobic decomposition
[1] This releases methane, a greenhouse gas that is much more powerful than carbon dioxide over a short period
[1] Greenhouse gases trap thermal energy and add to global warming and climate change
(e) [1] 7980 × 2.50
[1] £19 950 per year
[1] This is money that could be spent on other resources (for example equipment, better ingredients, or activities) or reduce meal prices$mq$, $mq$A$mq$),
(6, $mq$Case study 2: Food Waste at Riverside School (Sciences, Mathematics and Individuals and Societies)

Riverside School has 600 students. The student council weighed the food thrown away in the canteen over one week in March.

Source D: Food waste, one week
Monday: 38 kg
Tuesday: 45 kg
Wednesday: 41 kg
Thursday: 52 kg
Friday: 34 kg
The school year has 190 school days. Wasted food costs the school about £2.50 per kg.

Source E: Student survey (300 students, who could choose one main reason)
Portions are too large: 46%
I do not like the taste: 31%
I do not have enough time to eat: 15%
Other reasons: 8%

Source F: Proposals
Proposal 1: offer small, medium and large portions. Estimated to reduce waste by 25%.
Proposal 2: send the remaining food waste to a composting service instead of the bin. Estimated to cost £6000 per year and to divert 80% of the remaining waste from landfill.
Note: food waste buried in landfill rots without oxygen and releases methane.

(a) The school adopts Proposal 1. Calculate the new mean mass of waste per day. (2 marks)
(b) Calculate the mass of food saved over a school year and the money saved. (3 marks)
(c) The school then also adopts Proposal 2. Using the yearly waste after Proposal 1 (190 days), calculate the mass of waste diverted from landfill. (2 marks)
(d) Evaluate the two proposals. Use the survey in Source E, your calculations and ideas from Sciences and Individuals and Societies to recommend what the school should do. (6 marks)

(Total 13 marks)$mq$, $mq$(a) [1] 42 × 0.75 (or 42 − 25% of 42)
[1] 31.5 kg per day
(b) [1] Daily saving = 42 − 31.5 = 10.5 kg; over 190 days = 1995 kg
[1] 1995 × 2.50
[1] £4987.50
(c) [1] Yearly waste after Proposal 1 = 31.5 × 190 = 5985 kg
[1] 80% of 5985 = 4788 kg diverted from landfill
(d) [1] Links Proposal 1 to the survey: 46% give portion size as the reason, the largest reason, so Proposal 1 tackles the main cause
[1] Notes that Proposal 1 saves money (£4987.50) while Proposal 2 costs £6000 a year and does not reduce waste
[1] Uses science: Proposal 2 diverts 4788 kg of waste from landfill and so reduces methane emissions
[1] Uses Individuals and Societies: considers responsibility of the school and education of students, and the cost to the budget
[1] Notes that 31% say they do not like the taste, which neither proposal tackles, and suggests an action (for example menu feedback)
[1] A clear recommendation justified with evidence (for example adopt Proposal 1 first, then consider Proposal 2 when the budget allows or with sponsorship)$mq$, $mq$B$mq$),
(7, $mq$Case study 2: Food Waste at Riverside School (Sciences, Mathematics and Individuals and Societies)

Riverside School has 600 students. The student council weighed the food thrown away in the canteen over one week in March.

Source D: Food waste, one week
Monday: 38 kg
Tuesday: 45 kg
Wednesday: 41 kg
Thursday: 52 kg
Friday: 34 kg
The school year has 190 school days. Wasted food costs the school about £2.50 per kg.

Source E: Student survey (300 students, who could choose one main reason)
Portions are too large: 46%
I do not like the taste: 31%
I do not have enough time to eat: 15%
Other reasons: 8%

Source F: Proposals
Proposal 1: offer small, medium and large portions. Estimated to reduce waste by 25%.
Proposal 2: send the remaining food waste to a composting service instead of the bin. Estimated to cost £6000 per year and to divert 80% of the remaining waste from landfill.
Note: food waste buried in landfill rots without oxygen and releases methane.

(a) Describe three limitations of the data in Source D. (3 marks)
(b) Evaluate the survey method in Source E. (3 marks)
(c) Reflect on how the use of Mathematics, Sciences and Individuals and Societies together led to a better solution than one subject alone. (3 marks)
(d) Explain how you would improve the investigation if you were to repeat it, and how this would make your conclusions more reliable. (4 marks)

(Total 13 marks)$mq$, $mq$(a) [1] Only one week of data, so it may not be representative of the year
[1] Only a single measurement per day (no repeats), so random errors cannot be checked
[1] The week may include unusual days (for example a trip, an exam or a special menu), and amounts of waste may change by season
(b) [1] A sample of 300 out of 600 students (half) is large enough to be reasonable
[1] Students could choose only one reason, which may hide several reasons for waste
[1] Possible bias (for example the sample may not include all year groups; answers may not be honest) and the survey does not measure how much waste each reason causes
(c) [1] Mathematics gave the amounts, costs and savings
[1] Sciences explained why waste harms the environment (methane) and how composting helps
[1] Individuals and Societies considered cost, the school community's behaviour and choices; combining them gave a balanced, realistic recommendation
(d) [1] Collect data over several weeks and different seasons
[1] Survey all year groups (or a random sample from each) and allow more than one reason
[1] Weigh waste by type of food to see which meals are wasted most
[1] Explains that more data from a wider sample reduces the effect of unusual days and bias, so conclusions are more reliable$mq$, $mq$D$mq$),
(8, $mq$Case study 1: Lumen Nights (Sciences and The Arts)

The fictional city of Harbourgate holds a ten-night light festival called Lumen Nights. Artists create glowing installations on the waterfront, and the organisers want to use energy sensibly.

Source A: Lighting data
Number of light fixtures: 800
Power of one LED fixture: 12 W
Power of one older halogen fixture: 50 W
Lights are on for 6 hours each night for 10 nights.
Electricity costs £0.30 per kWh. Generating 1 kWh of electricity releases 0.2 kg of carbon dioxide.

Source B: Notes from the lead artist
"We use white light and coloured plastic filters. A red filter placed in front of a white lamp gives a red glow. Our red filters give light with a wavelength of about 700 nm. I choose warm colours for the entrance to make visitors feel welcome. We also have visitors from many countries and I know colours can mean different things in different places."

Source C: Visitor survey and costs
Visitors surveyed: 1200 (assume this is the total number of visitors)
Visitors from outside Harbourgate: 45%
Average spending in the city per visitor from outside: £38
Average spending in the city per local visitor: £12
Cost of running the festival: £30 000

Case study 2: Food Waste at Riverside School (Sciences, Mathematics and Individuals and Societies)

Riverside School has 600 students. The student council weighed the food thrown away in the canteen over one week in March.

Source D: Food waste, one week
Monday: 38 kg
Tuesday: 45 kg
Wednesday: 41 kg
Thursday: 52 kg
Friday: 34 kg
The school year has 190 school days. Wasted food costs the school about £2.50 per kg.

Source E: Student survey (300 students, who could choose one main reason)
Portions are too large: 46%
I do not like the taste: 31%
I do not have enough time to eat: 15%
Other reasons: 8%

Source F: Proposals
Proposal 1: offer small, medium and large portions. Estimated to reduce waste by 25%.
Proposal 2: send the remaining food waste to a composting service instead of the bin. Estimated to cost £6000 per year and to divert 80% of the remaining waste from landfill.
Note: food waste buried in landfill rots without oxygen and releases methane.

Reflect on both case studies.

(a) Identify two different stakeholders in one of the case studies and explain how their views might differ. (4 marks)
(b) Explain how your own values or experiences may have influenced the recommendations you made. (3 marks)
(c) Explain how your conclusions about one case study might change in a school or city in a different country. (3 marks)
(d) Describe one skill you used in this paper that you could apply to a new interdisciplinary problem, and explain why it would be useful. (3 marks)

(Total 13 marks)$mq$, $mq$(a) [1] Identifies two relevant stakeholders (for example the festival organisers and local residents, or the school principal and students)
[1] Explains the first stakeholder's likely view with a reason
[1] Explains the second stakeholder's likely view with a reason
[1] Shows how and why the views differ (for example different priorities: cost, environment, enjoyment, convenience)
(b) [1] Identifies a relevant personal value or experience (for example caring about the environment, or enjoying art)
[1] Explains how it influenced a specific choice in the recommendations
[1] Considers how to reduce this influence (for example by checking the evidence or consulting others)
(c) [1] Identifies a relevant difference (for example climate and electricity sources, cost of food, cultural attitudes to waste or festivals)
[1] Explains the effect of the difference on the data or the options
[1] Reaches a reasoned conclusion about how the recommendation would change
(d) [1] Identifies a specific skill (for example combining evidence from two subjects, checking calculations, evaluating bias)
[1] Describes how it was used in this paper
[1] Explains why it would help with a new problem (for example it helps to see a whole picture and make a balanced decision)$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
