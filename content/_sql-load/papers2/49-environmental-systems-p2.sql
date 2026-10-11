-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Environmental Systems MYP 5 eAssessment-style Practice Paper 2 (39 marks)
with sub as (select id from public.subjects where slug = $mq$environmental-systems$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Environmental Systems MYP 5 eAssessment-style Practice Paper 2$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Environmental Systems MYP 5 eAssessment-style Practice Paper 2$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Farmers in a region grow beans in rotation with wheat. Beans are legumes, which have swellings called root nodules containing bacteria. After a bean crop, the soil contains more nitrate than before.

(a) Name the process carried out by the bacteria in root nodules. (1 mark)
(b) Explain how decomposers help to recycle nitrogen in an ecosystem. (2 marks)
(c) Explain why planting beans can reduce the amount of artificial fertiliser a farmer needs to use. (2 marks)

(Total 5 marks)$mq$, $mq$(a) [1] Nitrogen fixation (accept: converting nitrogen gas into ammonium/nitrogen compounds)
(b) [1] Decomposers (bacteria and fungi) break down dead organisms and waste
[1] This releases nitrogen as ammonium (ammonia) which can be changed by nitrifying bacteria into nitrates and absorbed by plants
(c) [1] The bacteria fix nitrogen from the air into compounds the plant can use
[1] This enriches the soil with nitrate for the next crop, so less fertiliser is needed
Common error: stating that plants take in nitrogen gas directly from the air.$mq$, $mq$A$mq$),
(2, $mq$A student wanted to find out how soil salinity affects seed germination. She planted 20 cress seeds on damp cotton wool in each of four dishes. She watered each dish with 10 cm³ of salt solution of a different concentration every day. After 7 days she counted the seeds that had germinated.

Salt concentration (%): 0, 0.5, 1.0, 2.0
Seeds germinated (out of 20): 18, 17, 11, 4

(a) State the independent variable and the dependent variable. (2 marks)
(b) State two variables that should be kept constant. (1 mark)
(c) Calculate the percentage of seeds that germinated at 1.0% salt concentration. (1 mark)
(d) Write a conclusion for this investigation and explain it using the idea of water movement. (2 marks)

(Total 6 marks)$mq$, $mq$(a) [1] Independent variable: salt concentration of the water
[1] Dependent variable: number (or percentage) of seeds germinated after 7 days
(b) [1] Any two from: volume of solution, number of seeds per dish, temperature, light, type of seed, type of cotton wool, time (7 days) (both needed for the mark)
(c) [1] 11 ÷ 20 × 100 = 55%
(d) [1] Conclusion: higher salt concentrations reduce germination (germination is little affected up to 0.5% but falls sharply at 1.0% and above)
[1] Explanation: a salty solution has a lower water concentration than the seed cells, so water moves out of or less water moves into the seeds by osmosis, preventing germination
Common error: saying salt 'kills' the seeds without any explanation.$mq$, $mq$B$mq$),
(3, $mq$The greenhouse effect keeps Earth warm enough for life. Human activities have increased the concentration of some greenhouse gases in the atmosphere.

(a) State two greenhouse gases. (1 mark)
(b) Explain how an increase in greenhouse gases causes global temperatures to rise. (3 marks)
(c) State one effect of rising global temperatures on coastal communities. (1 mark)

(Total 5 marks)$mq$, $mq$(a) [1] Any two from: carbon dioxide, methane, water vapour, nitrous oxide (both needed)
(b) [1] Short-wave radiation from the Sun passes through the atmosphere and warms Earth's surface
[1] The surface emits longer-wave infrared radiation, which is absorbed by greenhouse gases
[1] The gases re-emit the energy in all directions, including back to Earth, so more heat is retained and temperatures rise
(c) [1] Any one from: sea level rise causing flooding, coastal erosion, loss of land, damage to homes, saltwater entering freshwater supplies, more intense storms
Do not accept: the ozone layer being involved in global warming as the main cause.$mq$, $mq$A$mq$),
(4, $mq$Deer were introduced to a fenced nature reserve with no predators. A ranger counted the population every two years.

Year: 0, 2, 4, 6, 8, 10
Number of deer: 50, 90, 160, 260, 330, 340

(a) Calculate the average increase in the number of deer per year between year 2 and year 6. (1 mark)
(b) Estimate the carrying capacity of the reserve. (1 mark)
(c) Explain why the growth rate slows after year 6. (2 marks)
(d) Wolves are reintroduced to the reserve. Predict the effect on the deer population and the vegetation, and justify your prediction. (2 marks)

(Total 6 marks)$mq$, $mq$(a) [1] (260 − 90) ÷ 4 = 42.5 deer per year
(b) [1] Approximately 340 deer (accept a value between 340 and 350)
(c) [1] Resources such as food and space become limited as the population approaches carrying capacity
[1] Competition increases, so birth rate falls and/or death rate rises until they are about equal
(d) [1] The deer population will fall (or stabilise at a lower number) because wolves prey on deer
[1] There is less grazing, so vegetation recovers (increases); accept justification linking predator-prey relationships
Common error: saying the population stops growing because all deer 'run out of space' without mentioning resources.$mq$, $mq$C$mq$),
(5, $mq$A town of 15 000 people produces household waste. The average person produces 480 kg of household waste per year. The waste is made up of: food waste 30%, paper 25%, plastic 12%, glass 8% and other materials 25%.

(a) Calculate the mass of plastic waste produced per person per year. (1 mark)
(b) Calculate the total mass of food waste produced by the town in a year, in tonnes (1 tonne = 1 000 kg). (2 marks)
(c) Explain two reasons why plastic waste is harmful to marine ecosystems. (2 marks)

(Total 5 marks)$mq$, $mq$(a) [1] 480 × 0.12 = 57.6 kg
(b) [1] 480 × 0.30 × 15 000 = 2 160 000 kg
[1] 2 160 000 ÷ 1 000 = 2 160 tonnes
(c) [1] Animals mistake plastic for food or become entangled, causing injury or death
[1] Plastic breaks into microplastics that persist for a long time and enter food chains (accept: releases toxic chemicals, or damages habitats such as coral)
Common error: forgetting to convert kilograms to tonnes.$mq$, $mq$A$mq$),
(6, $mq$A company proposes a tourist resort on a coastline that has a 50-hectare mangrove forest. Building the resort will clear 8 hectares of the mangroves. The company says the resort will create 120 jobs for local people. Mangroves protect the coast from storm waves and are nurseries for young fish that local fishers catch.

(a) Calculate the percentage of the mangrove forest that would be cleared. (1 mark)
(b) Identify two stakeholders and state a likely viewpoint of each. (2 marks)
(c) Evaluate whether the resort should go ahead, and recommend one condition that would reduce the environmental impact. (3 marks)

(Total 6 marks)$mq$, $mq$(a) [1] 8 ÷ 50 × 100 = 16%
(b) [1] One stakeholder with a viewpoint, for example local fishers who oppose it because nursery habitat is lost
[1] A second stakeholder with a viewpoint, for example unemployed residents who support it for jobs (or the company wanting profit, conservation groups wanting protection)
(c) [1] An advantage weighed fairly (jobs, income) and a disadvantage (loss of habitat, reduced storm protection, effect on fish catches)
[1] A clear judgement or recommendation supported by the evidence (for example approve only a reduced scheme, or reject because long-term costs exceed short-term jobs)
[1] A realistic condition, for example replanting mangroves elsewhere, reducing the cleared area, or monitoring water quality (do not accept vague 'be careful')
Common error: giving a one-sided answer with no judgement.$mq$, $mq$D$mq$),
(7, $mq$A class sampled invertebrates in a stream using a net for 3 minutes at two sites: one upstream of a farm and one downstream of a farm drain. Some invertebrates are sensitive to pollution (mayfly and stonefly larvae); bloodworms tolerate low oxygen.

Organism: upstream count, downstream count
Mayfly larvae: 14, 1
Stonefly larvae: 9, 0
Freshwater shrimp: 22, 5
Bloodworms: 3, 48

(a) Calculate the total number of invertebrates caught at each site. (2 marks)
(b) Calculate the percentage of the downstream sample that were bloodworms. Give your answer to 1 decimal place. (1 mark)
(c) Explain how the data suggest that the stream is polluted downstream of the farm. (2 marks)
(d) Suggest one improvement to make the comparison more reliable. (1 mark)

(Total 6 marks)$mq$, $mq$(a) [1] Upstream: 14 + 9 + 22 + 3 = 48
[1] Downstream: 1 + 0 + 5 + 48 = 54
(b) [1] 48 ÷ 54 × 100 = 88.9%
(c) [1] Pollution-sensitive species (mayfly, stonefly) are almost absent downstream
[1] Bloodworms, which tolerate low oxygen, dominate downstream, suggesting organic pollution or low dissolved oxygen (for example from fertiliser or manure runoff)
(d) [1] Repeat the sampling several times at each site and calculate means (accept: sample for the same time at several points, or measure oxygen directly)
Common error: judging pollution from the total number alone, since the totals (48 and 54) are similar.$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
