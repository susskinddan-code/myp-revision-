-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Environmental Systems MYP 5 eAssessment-style Practice Paper 1 (39 marks)
with sub as (select id from public.subjects where slug = $mq$environmental-systems$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Environmental Systems MYP 5 eAssessment-style Practice Paper 1$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Environmental Systems MYP 5 eAssessment-style Practice Paper 1$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$A scientist measured the energy stored in each trophic level of a grassland ecosystem over one year. All values are in kJ per m² per year.

Grass (producers): 20 000
Grasshoppers (primary consumers): 2 000
Frogs (secondary consumers): 180

(a) Calculate the percentage of energy transferred from the grass to the grasshoppers. Show your working. (1 mark)
(b) Calculate the percentage of energy transferred from the grasshoppers to the frogs. (1 mark)
(c) Explain why not all of the energy in the grasshoppers is passed on to the frogs. (3 marks)

(Total 5 marks)$mq$, $mq$(a) [1] 2 000 ÷ 20 000 × 100 = 10% (accept 10 with the % sign missing only if working is shown)
(b) [1] 180 ÷ 2 000 × 100 = 9%
(c) [1] Some energy is released as heat during respiration (to power life processes such as movement)
[1] Some parts of the grasshopper are not eaten or not digested by the frog (for example bones/exoskeleton) and are lost as waste
[1] Some grasshoppers die and are broken down by decomposers, or are eaten by other organisms, so the energy does not reach the frogs
Common error: saying energy is 'used up' or 'destroyed'. Energy is transferred to the surroundings, not lost from the universe.$mq$, $mq$A$mq$),
(2, $mq$Algal blooms are linked to nutrients in water. A group of students collected pond water and placed 500 cm³ in each of four identical clear containers. They added different amounts of phosphate fertiliser, placed all containers on the same sunny windowsill and counted the algal cells in 1 cm³ of water after 10 days.

Phosphate added (mg per dm³): 0, 0.5, 1.0, 2.0
Algal cells per cm³ (thousands): 120, 340, 610, 1150

For the 1.0 mg per dm³ container the students counted three separate samples: 590, 610 and 630 (thousand cells per cm³).

(a) Identify the independent variable and the dependent variable. (2 marks)
(b) Calculate the mean of the three samples from the 1.0 mg per dm³ container. (1 mark)
(c) State the relationship shown by the results. (1 mark)
(d) Explain how nutrient enrichment in a real pond can lead to the death of fish. (2 marks)

(Total 6 marks)$mq$, $mq$(a) [1] Independent variable: amount (concentration) of phosphate added
[1] Dependent variable: number of algal cells per cm³ after 10 days
(b) [1] (590 + 610 + 630) ÷ 3 = 610 (thousand cells per cm³)
(c) [1] As the phosphate added increases, the number of algal cells increases (positive correlation; accept: more phosphate, more algae)
(d) [1] Algae grow very quickly and block light, so plants below die; when the algae and plants die, bacteria decompose them
[1] Decomposition uses up dissolved oxygen (high biological oxygen demand), so fish suffocate
Common error: saying the algae 'use up' the oxygen at night is acceptable only if linked to death and decomposition; saying phosphate poisons fish scores 0.$mq$, $mq$B$mq$),
(3, $mq$The table shows the carbon dioxide concentration in the air measured at a mountain observatory in three different years.

Year: 1960, 1990, 2020
CO₂ concentration (parts per million, ppm): 317, 354, 414

(a) Calculate the increase in CO₂ concentration between 1990 and 2020. (1 mark)
(b) Calculate the percentage increase in CO₂ concentration between 1960 and 2020. Give your answer to the nearest whole number. (2 marks)
(c) State two human activities that have caused the increase in atmospheric CO₂. (2 marks)

(Total 5 marks)$mq$, $mq$(a) [1] 414 − 354 = 60 ppm
(b) [1] (414 − 317) ÷ 317 × 100 (accept: 97 ÷ 317 × 100)
[1] 31% (accept 30.6 before rounding)
(c) [1] Burning fossil fuels (coal, oil, gas) for energy, transport or industry
[1] Deforestation (or burning forests, which removes trees that absorb CO₂); accept cement production or burning biomass
Do not accept: 'pollution' or 'factories' with no link to burning fuel.$mq$, $mq$A$mq$),
(4, $mq$Students estimated the number of daisy plants in a school field of area 2 000 m². They placed ten square quadrats (each 0.5 m × 0.5 m) at random positions and counted the daisies in each.

Daisies per quadrat: 4, 7, 3, 6, 5, 8, 2, 5, 6, 4

(a) Calculate the mean number of daisies per quadrat. (1 mark)
(b) Each quadrat has an area of 0.25 m². Estimate the total number of daisies in the field. Show your working. (3 marks)
(c) Explain why the students placed the quadrats at random positions. (1 mark)
(d) Suggest one way to improve the accuracy of the estimate. (1 mark)

(Total 6 marks)$mq$, $mq$(a) [1] 50 ÷ 10 = 5 daisies per quadrat
(b) [1] Mean per m² = 5 ÷ 0.25 = 20
[1] Multiply by field area: 20 × 2 000
[1] 40 000 daisies (accept: 40 000 with any equivalent working; ECF from an incorrect mean)
(c) [1] To avoid bias (for example choosing areas with more daisies) so the sample represents the whole field
(d) [1] Use more quadrats (or repeat the sampling several times) and calculate a new mean (accept: sample all parts of the field)
Common error: forgetting to convert quadrat area to m² before scaling up.$mq$, $mq$C$mq$),
(5, $mq$An environmental agency measured nitrogen dioxide (NO₂) at a busy city road junction at four times during one weekday.

07:00: 52 µg per m³
10:00: 78 µg per m³
13:00: 64 µg per m³
16:00: 46 µg per m³

The city's guideline for the daily mean is 40 µg per m³.

(a) Calculate the mean NO₂ concentration for the four readings. (1 mark)
(b) Calculate by what percentage the mean is above the guideline. (1 mark)
(c) Explain how nitrogen oxides from vehicles can lead to photochemical smog. (2 marks)
(d) Suggest one policy a city could use to reduce NO₂ levels. (1 mark)

(Total 5 marks)$mq$, $mq$(a) [1] (52 + 78 + 64 + 46) ÷ 4 = 60 µg per m³
(b) [1] (60 − 40) ÷ 40 × 100 = 50%
(c) [1] Vehicle engines release nitrogen oxides and volatile organic compounds (hydrocarbons)
[1] In strong sunlight these react to form ozone and other irritants at ground level, producing smog
(d) [1] Any one from: low-emission zone or congestion charge, better public transport/cycling lanes, tighter vehicle emission standards, promoting electric vehicles (accept any reasonable policy)
Common error: confusing ground-level ozone (a pollutant) with the ozone layer.$mq$, $mq$A$mq$),
(6, $mq$A coastal island with 26 000 households is considering a wind farm. The proposal is for 12 turbines, each with a maximum power of 3.0 MW. Because the wind does not blow at full strength all the time, each turbine produces on average 35% of its maximum power. There are 8 760 hours in a year. An average household on the island uses 4.2 MWh of electricity per year.

(a) Calculate the electrical energy the wind farm produces in a year, in MWh. (2 marks)
(b) Calculate the number of households this energy could supply. (1 mark)
(c) Evaluate the proposal by discussing one environmental benefit and one limitation or negative impact of the wind farm. (3 marks)

(Total 6 marks)$mq$, $mq$(a) [1] Average power = 12 × 3.0 × 0.35 = 12.6 MW
[1] Energy = 12.6 × 8 760 = 110 376 MWh (accept 110 000)
(b) [1] 110 376 ÷ 4.2 = 26 280 households (this is enough for all 26 000 households)
(c) [1] Benefit: produces electricity with no CO₂ emitted during operation, reducing fossil fuel use and climate impact
[1] Limitation or impact: intermittent supply so backup or storage is needed; or risk to birds/bats, noise, visual impact, effect on tourism
[1] Evaluation: a judgement linking both, for example that the benefit is large because the farm can supply all households, but the limitation must be managed with storage and careful site choice
Common error: describing only advantages; evaluation needs a judgement.$mq$, $mq$D$mq$),
(7, $mq$Students investigated how vegetation cover affects soil erosion. They placed identical trays of soil on the same slope, each covered with a different percentage of grass. They poured 2 dm³ of water over each tray in 10 minutes and collected and dried the soil washed out.

Vegetation cover (%): 0, 25, 50, 75, 100
Mass of soil washed out (g): 48, 30, 17, 8, 3

(a) Describe the pattern in the results. (1 mark)
(b) Calculate the percentage decrease in soil lost between 0% cover and 100% cover. Give your answer to 1 decimal place. (2 marks)
(c) Explain the pattern using what you know about plant roots and rain. (2 marks)
(d) Describe one limitation of using trays to model erosion on a real hillside. (1 mark)

(Total 6 marks)$mq$, $mq$(a) [1] As vegetation cover increases, the mass of soil washed out decreases (negative relationship; accept a comment that the decrease slows down)
(b) [1] (48 − 3) ÷ 48 × 100
[1] 93.8% (accept 93.75)
(c) [1] Roots bind soil particles together and leaves intercept raindrops, so soil is less easily detached
[1] Vegetation slows water flow and increases infiltration, so there is less surface runoff to carry soil away
(d) [1] Any one from: a tray is small so does not model long slopes or large catchments; artificial rainfall differs from real storms; soil in a tray is disturbed and has no natural structure; only one soil type or slope was tested
Common error: giving a limitation without saying how it affects validity.$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
