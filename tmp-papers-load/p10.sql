begin;
-- Economics MYP 5 eAssessment Structure Mock B (8 tasks, 80 marks) (80 marks)
with sub as (select id from public.subjects where slug = $mq$economics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Economics MYP 5 eAssessment Structure Mock B (8 tasks, 80 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Economics MYP 5 eAssessment Structure Mock B (8 tasks, 80 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
The table shows the gross domestic product (GDP) and population of Dalmora.

Year: 2021, 2022, 2023, 2024
GDP (billions of dollars): 50.0, 52.5, 54.6, 55.2
Population (millions): 10.0, 10.1, 10.2, 10.4

(a) Calculate the rate of economic growth between 2021 and 2022. (2 marks)
(b) Calculate GDP per capita in 2024, to the nearest dollar. (2 marks)
(c) Show that GDP per capita in Dalmora fell between 2023 and 2024. (2 marks)
(d) Explain how GDP per capita can fall in a year when GDP has risen. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) (52.5 - 50.0) / 50.0 x 100 [1] = 5.0% [1].
(b) GDP per capita = GDP / population = 55.2 billion / 10.4 million [1] = $5,308 [1] (5,307.7).
(c) 2023: 54.6 billion / 10.2 million = $5,353 (5,352.9) [1]; 2024 value $5,308 is lower, so GDP per capita fell by about $45 [1].
(d) GDP rose by only about 1.1% (54.6 to 55.2) [1]; the population grew faster, by about 2.0% (10.2 to 10.4 million), so output is shared among more people and the average falls [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Four people in the country of Quenta are looking for work.

Person 1: Mara teaches skiing. Every summer, when the resorts are closed, she has no job until the snow returns.
Person 2: Joel has just graduated and is searching for his first job. He has had two interviews and expects an offer within three months.
Person 3: Tobias worked in a factory that made film cameras. The factory closed because almost everyone now uses phone cameras, and his skills do not match the jobs available.
Person 4: Lena was laid off from a car plant when a recession caused car sales to fall sharply across the country.

(a) Identify the type of unemployment affecting each person, choosing from: frictional, structural, cyclical, seasonal. (4 marks)
(b) In 2025 the labour force of Quenta was 2.4 million people, of whom 168,000 were unemployed. Calculate the unemployment rate. (2 marks)
(c) Explain one cost of high unemployment to the government. (2 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) Mara: seasonal [1]; Joel: frictional [1]; Tobias: structural [1]; Lena: cyclical [1].
(b) 168,000 / 2,400,000 [1] x 100 = 7.0% [1].
(c) Any one cost, identified [1] and explained [1], e.g. the government pays more unemployment benefits while receiving less income tax (fewer workers) and VAT (less spending), so a budget deficit can widen; or spending on health or social services rises as unemployment harms well-being.$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 10]]
A student at Harbour School wants to investigate how a price rise would affect sales in the school canteen. She prepared a short questionnaire and asked 40 students in her own class to complete it.

Source A: Extract from the questionnaire.
Question 1: "Don't you agree that the canteen's prices are already far too high?" (Yes / No)
Question 2: "How often do you buy lunch in the canteen?" (Never / 1 or 2 times a week / 3 or 4 times a week / Every day)
Question 3: "Would you still buy a sandwich if its price rose from $2.50 to $3.00?" (Yes / No)

Source B: Results for Question 3 (40 students, all from the same class).
Answered Yes: 12 students
Answered No: 28 students

(a) Formulate a focused research question for the student's investigation. (2 marks)
(b) Identify the question in Source A that is a leading question and explain why it is a problem. (2 marks)
(c) Calculate the percentage of the 40 students who would stop buying a sandwich if the price rose. (1 mark)
(d) Explain why the results in Source B may not be representative of all students at the school, and suggest a better sampling method. (3 marks)
(e) Distinguish between primary data and secondary data, and give one example of secondary data the student could use. (2 marks)

Total for Question 3: 10 marks$mq$, $mq$(a) A question that names the product and the change and is answerable with data [1], and that links price to the quantity bought or to sales [1], e.g. "To what extent would a rise in the price of a canteen sandwich from $2.50 to $3.00 reduce the number of sandwiches bought by students at Harbour School?" Award 1 if the question is broad or vague (e.g. "Is the canteen too expensive?").
(b) Question 1 [1]; it pushes respondents towards agreeing ("Don't you agree ... far too high") so the answers are biased and do not show real opinions [1].
(c) 28 / 40 x 100 = 70% [1].
(d) The sample is only one class, so it may be the same age and may include friends with similar incomes and habits / it is small (40 students) [1]; students in other year groups may buy more or less lunch and respond differently, so results cannot be generalised to the whole school [1]; better method: random or stratified sampling, selecting students from every year group in proportion to numbers (e.g. every 10th name on the school register) [1].
(e) Primary data is collected first-hand by the researcher for this purpose (e.g. through her questionnaire) and secondary data was collected earlier by someone else [1]; example of secondary data: canteen sales records, school or local government statistics on food prices, published studies of price changes in school canteens [1].$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | A 5 | C 5]]
The table shows the government budget of the country of Brenmark for one year (billions of dollars).

Revenue: income tax 42, VAT (sales tax) 30, corporation tax 18, other 10.
Spending: health 28, education 22, welfare 25, defence 10, infrastructure 12, interest on government debt 9.

At the start of the year the central bank had a base interest rate of 2.0% and inflation was 7%. The central bank raised its base rate to 3.5%.

(a) Calculate total government revenue and total government spending, and state the size of the budget deficit or surplus. (2 marks)
(b) Calculate the percentage of total revenue that comes from VAT. (1 mark)
(c) Describe how the government's spending is distributed, identifying the largest and smallest categories. (2 marks)
(d) Explain how raising the base interest rate may help to reduce inflation. (2 marks)
(e) Calculate the angle for the health sector on a pie chart of the government's spending, to the nearest degree. (2 marks)
(f) State one reason why a government might choose to run a budget deficit. (1 mark)

Total for Question 4: 10 marks$mq$, $mq$(a) Revenue = 42 + 30 + 18 + 10 = $100 billion; spending = 28 + 22 + 25 + 10 + 12 + 9 = $106 billion [1]; deficit of $6 billion [1].
(b) 30 / 100 x 100 = 30% [1].
(c) The largest category is health ($28 billion, about 26% of spending) [1]; the smallest is interest on debt ($9 billion); welfare and education are also large, with defence and infrastructure smaller [1].
(d) Higher interest rates make borrowing more expensive and saving more attractive, so households and firms spend and invest less [1]; lower total demand reduces pressure on prices, so inflation falls (and firms' costs for borrowed money rise too) [1].
(e) 28 / 106 x 360 [1] = 95 degrees (95.1) [1].
(f) Any one: to increase spending in a recession to boost demand and jobs; to invest in infrastructure or education that raises long-term growth; to avoid raising taxes when households are struggling [1].$mq$, $mq$C$mq$),
(5, $mq$[[Q 5 | A 10]]
Country X and country Y each have 10 workers who can make wheat or cloth. The table shows the output of one worker in one day.

Country X: 6 tonnes of wheat or 3 rolls of cloth
Country Y: 4 tonnes of wheat or 4 rolls of cloth

Before trade, each country uses 5 workers to make wheat and 5 workers to make cloth.

(a) State which country has an absolute advantage in producing wheat. (1 mark)
(b) Calculate the opportunity cost of producing one roll of cloth in each country, in tonnes of wheat. (2 marks)
(c) Identify which country has a comparative advantage in cloth, and justify your answer. (2 marks)
(d) Show that if each country specialises in the good in which it has a comparative advantage, the combined output of both wheat and cloth is greater than before trade. (3 marks)
(e) Outline two risks or limitations of a country specialising in one product. (2 marks)

Total for Question 5: 10 marks$mq$, $mq$(a) Country X [1] (6 tonnes per worker compared with 4).
(b) Country X: 6 / 3 = 2 tonnes of wheat per roll of cloth [1]; Country Y: 4 / 4 = 1 tonne of wheat per roll of cloth [1].
(c) Country Y [1], because its opportunity cost of cloth (1 tonne of wheat) is lower than country X's (2 tonnes) [1].
(d) Before trade: X makes 5 x 6 = 30 tonnes wheat and 5 x 3 = 15 rolls; Y makes 5 x 4 = 20 tonnes and 5 x 4 = 20 rolls; combined 50 tonnes of wheat and 35 rolls of cloth [1]. After specialisation: X makes wheat only, 10 x 6 = 60 tonnes; Y makes cloth only, 10 x 4 = 40 rolls [1]; 60 > 50 and 40 > 35, so combined output of both goods is higher [1].
(e) Any two, outlined: over-dependence on one product, so a fall in its price or a bad harvest hits the whole economy; reliance on imports of other goods, which may be disrupted or become more expensive; loss of skills and jobs in other industries; lower resilience in a conflict or crisis; trade barriers or exchange-rate changes may remove the gains [1][1].$mq$, $mq$A$mq$),
(6, $mq$[[Q 6 | A 2 | C 8]]
The island of Ilmara relies on tourism. Study Source A and Source B.

Source A: Cartoon from an Ilmaran newspaper. [Description: A very large cruise ship fills the horizon behind a tiny fishing boat. On the beach a local vendor holds a sign that reads "Welcome! Buy my shells!" while a tourist photographs him and says "Paradise!". In the foreground a pile of plastic bottles lies next to a broken piece of white, dead coral.]

Source B: Data from the Ilmara Tourism and Environment Office.
Year: 2015, 2018, 2021, 2024
Tourist arrivals (thousands): 120, 190, 260, 340
Share of the island's workers employed in tourism (%): 12, 21, 30, 38
Healthy coral cover on the surveyed reef (%): 62, 55, 44, 31

(a) Describe the trend in tourist arrivals in Source B. (2 marks)
(b) Calculate the percentage increase in tourist arrivals between 2015 and 2024, to the nearest whole number. (2 marks)
(c) Identify the message of the cartoon in Source A and one technique the cartoonist uses to convey it. (2 marks)
(d) Compare and contrast the view of tourism presented in Source A with the evidence in Source B. (2 marks)
(e) Explain how the data in Source B supports the message of the cartoon and state one limitation of using Source B to support it. (2 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) Arrivals rose steadily in every period [1], from 120 thousand in 2015 to 340 thousand in 2024, an increase of 220 thousand (about 70 thousand every three years) [1].
(b) (340 - 120) / 120 x 100 [1] = 183% (183.3) [1].
(c) Message: tourism brings visitors and money but damages the environment and the island's character, treating locals as commodities / mass tourism is unsustainable [1]; technique, any one: irony (tourist calls it "paradise" beside litter and dead coral), contrast in scale (huge ship, tiny boat), symbolism (dead coral, plastic bottles), caption or sign wording [1].
(d) Similarity [1]: both indicate that tourism has grown strongly and affects the environment (coral cover falls from 62% to 31%); difference [1]: the cartoon presents only the negative side (and an exaggerated one), whereas Source B also shows benefits, e.g. 38% of workers now earn their living from tourism, up from 12%.
(e) Support: coral cover halves from 62% to 31% as arrivals rise by 183%, which matches the dead coral and litter shown [1]; limitation, any one: correlation does not prove tourism caused the coral loss (warming seas or pollution from farms may also be causes) / the data are only from the surveyed reef / no data on pollution or income per worker [1].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | A 5 | D 7]]
The city of Nordhavn is deciding whether to pay a subsidy to producers of electric bicycles (e-bikes).

Source A: Information from the city's transport department.
Shop price of an e-bike without a subsidy: $1,200
Proposed subsidy: $200 per e-bike, paid to producers, who pass it on in lower prices
Expected e-bike sales per year without the subsidy: 8,000
Expected e-bike sales per year with the subsidy: 11,000
Alternative project for the same money: a cycle-lane network costing $2.2 million

Source B: Comment from a city council transport officer.
"We should remember that many of the 8,000 people who would buy an e-bike anyway will also receive the subsidy. We would be paying them for something they were going to do. Whether a subsidy is the best use of public money depends on what else the money could achieve."

(a) Calculate the total cost of the subsidy to the city if 11,000 e-bikes are sold. (1 mark)
(b) Calculate the cost to the city for each additional e-bike sold because of the subsidy. (2 marks)
(c) Explain, using supply and demand, how a subsidy paid to producers can lower the market price of e-bikes. (2 marks)
(d) Explain one opportunity cost of spending the money on the subsidy. (2 marks)
(e) Evaluate whether the city should introduce the subsidy. Use information from Sources A and B. (5 marks)

Total for Question 7: 12 marks$mq$, $mq$(a) 11,000 x $200 = $2,200,000 [1].
(b) Additional e-bikes = 11,000 - 8,000 = 3,000 [1]; $2,200,000 / 3,000 = $733 (733.33) per additional e-bike [1].
(c) A subsidy lowers producers' costs, so supply increases (the supply curve shifts right / down) [1]; at the old price there is a surplus, so the market price falls to a new equilibrium with a higher quantity bought [1].
(d) The $2.2 million could be used for something else, e.g. the cycle-lane network named in Source A [1]; so the city gives up the benefits of the next best use, such as safer cycling for everyone, not just e-bike buyers (accept schools, buses or healthcare as alternatives) [1].
(e) Level-based, 5 marks. Indicative content: for: lowers the price by about 17% ($1,200 to $1,000 if fully passed on), raises sales by 37.5% (3,000 additional bikes), fewer car journeys so less pollution and congestion. Against: $733 per additional e-bike is much higher than the $200 headline subsidy; 8,000 buyers would have bought anyway (Source B); the same money could build the cycle lanes; the effect on car use is not measured; subsidy must be paid for by taxpayers. Mark bands: 1 to 2 marks for a one-sided recommendation using one point; 3 to 4 marks for a recommendation with both advantages and disadvantages and some data from Sources A or B; 5 marks for a balanced weighing of the evidence, use of the $733 figure and Source B, comparison with the alternative, and a clear justified conclusion. Total for part (e) [5].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 3 | B 2 | C 2 | D 5]]
Conceptual link: fairness and development. Global context: fairness and development.

The country of Jorvik is deciding whether to raise its national minimum wage from $9.00 per hour to $10.80 per hour. Study Sources C, D and E.

Source C: Government statistics.
Workers currently paid less than $10.80 per hour: 310,000
Typical hours worked by these workers: 30 hours per week, 52 weeks per year
National unemployment rate: 5.2%
Economists' estimates of jobs lost among the affected workers if the minimum wage rises: between 0.5% and 2.0%

Source D: Statement from the Jorvik Employers' Federation.
"A rise of 20% in the minimum wage in one step is too much for small cafes, shops and care homes, which have very thin profit margins. Many will cut hours, stop hiring or close. The workers most likely to lose out are exactly the ones the policy claims to help."

Source E: Statement from the Jorvik Workers' Union.
"These workers clean our offices and care for our elderly, yet they cannot afford rent. A rise of $1.80 an hour means over $2,800 more each year for a family. Higher wages are spent in local shops, which creates jobs. The alternative is to let employers keep paying poverty wages."

Using Sources C, D and E and your own economic knowledge, evaluate whether Jorvik should raise the minimum wage to $10.80. In your answer you should: use data from Source C; refer to Sources D and E, commenting on their origin or purpose; consider the effects on workers, businesses and the government; and reach a justified conclusion. (12 marks)

Total for Question 8: 12 marks$mq$, $mq$This is an extended response. Marks are awarded by criterion: A (knowing and understanding) [3], B (investigating, use and evaluation of sources) [2], C (communicating) [2], D (thinking critically) [5].

Indicative content (data checked): the rise is 1.80 / 9.00 = 20%. A worker on 30 hours for 52 weeks earns 9.00 x 30 x 52 = $14,040 a year now and 10.80 x 30 x 52 = $16,848 after, a gain of $2,808, matching Source E's claim of over $2,800. Job losses of 0.5% to 2.0% of 310,000 equal 1,550 to 6,200 jobs. Even with the largest loss, 303,800 workers keep jobs and gain about $853 million in extra pay in total (310,000 workers with no job loss would gain about $870 million), against 6,200 who lose their income entirely. The unemployment rate of 5.2% suggests the labour market is not weak.
Knowledge (A): minimum wage as a price floor above equilibrium in the labour market; demand for labour is a derived demand; higher wages raise costs and may cut hours or jobs; higher incomes raise consumption and tax revenue; reduced need for state benefits; poverty and income inequality; elasticity of demand for labour.
Sources (B): Source C is government data (reliable on numbers, but job-loss figures are estimates and the range is wide); Source D is from an employers' body that wants to keep costs low, and gives no figures; Source E is from a union that represents low-paid workers and wants a pay rise, uses a correct figure but ignores job-loss risk and stays silent on firms that may close.
Evaluation (D): weigh certain gains for most low-paid workers against possible job losses for a few; consider phased increases (e.g. in two steps), support for small firms, review of evidence; consider effects on prices and inflation, fairness in income distribution, and the government's budget (more income tax, less spending on benefits).

Level descriptors. Criterion A (3 marks): 1 mark - limited knowledge, mainly description; 2 marks - relevant concepts used with some accuracy (price floor, derived demand, poverty, inflation); 3 marks - accurate, wide-ranging terminology and concepts applied to workers, businesses and government. Criterion B (2 marks): 1 mark - uses the sources with little comment on origin or purpose; 2 marks - uses data from Source C and evaluates the origin, purpose, value or limitation of Source D and/or Source E. Criterion C (2 marks): 1 mark - some structure and basic terminology; 2 marks - clear, logical structure with a conclusion, accurate figures and appropriate terms. Criterion D (5 marks): 1 to 2 marks - one-sided or unsupported judgement; 3 to 4 marks - considers advantages and disadvantages with supporting evidence and a judgement; 5 marks - balanced, well-supported evaluation that weighs gains against costs for different groups, recognises limits of the evidence, and reaches a justified, possibly conditional, conclusion.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Interdisciplinary Learning MYP 5 eAssessment Structure Mock A (7 tasks, 78 marks) (78 marks)
with sub as (select id from public.subjects where slug = $mq$interdisciplinary-learning$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Interdisciplinary Learning MYP 5 eAssessment Structure Mock A (7 tasks, 78 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Interdisciplinary Learning MYP 5 eAssessment Structure Mock A (7 tasks, 78 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: Identifying disciplines and reading data

THEME: Port Merrow - defending a coast and powering a town
Port Merrow is a fictional coastal town of 14 000 people. The council must decide how to protect the town from flooding and how to meet its energy targets. Read Sources A to F, which come from different fields of study, and use them to answer the tasks.

Source A: Monitoring record (Merrow Coastal Monitoring Group)
Year: 1990, 2000, 2010, 2020
Mean sea level above the 1990 baseline (mm): 0, 28, 64, 108
Flood warnings issued in the year: 2, 3, 6, 9
Properties flooded in the year: 0, 12, 85, 140

Source B: Science note (Merrow Marine Science Centre), "Why the sea is rising and how storms make it worse"
"Sea level rises for two main reasons. First, water expands when it warms (thermal expansion) because its particles move faster and take up slightly more space. Second, ice that rests on land, such as ice sheets and mountain glaciers, melts and the water runs into the ocean. Melting of ice that is already floating, such as sea ice, adds almost no extra volume. In a storm, a fall in air pressure lets the sea surface rise. As a rough rule, every 1 hPa that the pressure falls below the normal value of 1013 hPa raises the local sea surface by about 1 cm. A storm on 14 November 2023 had a central pressure of 978 hPa. Our field measurements also show that each 50 m width of saltmarsh reduces the height of a wave entering it by 20% of its height at the start of that 50 m. The energy carried by each metre of a wave crest is proportional to the square of the wave height."

Source C: Appraisal of three flood-defence options (Tideway Partners, consultants to the council; figures in millions of pounds, GBP)
Option 1, concrete sea wall: capital cost 42; maintenance 0.5 per year; working life 50 years; flood damage avoided 3.1 per year; effect on habitat: removes 22 hectares of saltmarsh.
Option 2, restored saltmarsh with a low embankment: capital cost 18; maintenance 0.3 per year; working life 40 years; flood damage avoided 1.7 per year; effect on habitat: creates 35 hectares of saltmarsh.
Option 3, tidal barrier with turbines: capital cost 65; maintenance 1.2 per year; working life 60 years; flood damage avoided 4.2 per year; also generates 9 500 MWh of electricity per year.
Note: total cost = capital cost + (maintenance per year x working life). Total benefit = damage avoided per year x working life. Benefit-cost ratio (BCR) = total benefit / total cost. Figures exclude the value of habitats, tourism and fishing.

Source D: Interview extract (Coast Talk, local radio), Marta Quill, mussel farmer and chair of the Merrow Boatyard Association
Interviewer: Some people say a concrete wall is the only safe answer. You disagree?
Quill: "My family's boatyard has flooded three times in eight years. Believe me, I want protection, and I want it quickly. But look at the marsh at Teller's Point. When the November storm hit, the water was shin-deep there and chest-deep on Harbour Road. The marsh did that for nothing. My mussel beds, forty jobs in the season, depend on the clean water that marsh filters. A wall would be a monument to our fear, and it would cut the town off from the sea that made it. I am not against engineers. I am against being told it is wall or nothing."

Source E: Policy statement (Merrow Town Council, Climate and Coast Strategy)
1. Flood-defence capital spending may not exceed GBP 50 million, which is the limit of the grant from the Regional Resilience Fund.
2. By 2035, at least 40% of the town's yearly electricity demand must be met by renewable sources generated locally.
3. There must be no net loss of protected coastal habitat.
4. Residents must be consulted before a final decision, and the Strategy must be reviewed every five years.

Source F: Energy options sheet (SeaWind Developments Ltd, a company bidding to build the turbines)
Town electricity demand: 62 000 MWh per year. Hours in a year: 8 760.
Offshore wind turbine: rated power 3.6 MW; capacity factor 35% (the fraction of the rated power it delivers on average over a year); installed cost GBP 5.4 million each.
Tidal stream turbine: rated power 1.2 MW; capacity factor 40%; installed cost GBP 4.8 million each.
Statement: "Our wind turbines deliver reliable, clean power for decades."
Carbon: replacing grid electricity with local renewable electricity avoids 0.2 kg of carbon dioxide for every kWh (1 MWh = 1000 kWh).

(a) Identify the field of study (discipline) that each of Sources A, B, C and F draws on most. Give one field for each source. (4 marks)
(b) State the two main causes of sea-level rise described in Source B. (2 marks)
(c) Using Source A, state the decade in which the rise in mean sea level was greatest and give the size of that rise. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] Source A: geography / Individuals and Societies (accept mathematics for data handling) [1] Source B: sciences (accept Earth science, physics, oceanography) [1] Source C: economics / Individuals and Societies [1] Source F: design and engineering / sciences (physics) (accept mathematics or economics for the cost data). Award a mark only where the field matches the source's content; one field per source.
(b) [1] Thermal expansion of warming sea water [1] Melting of ice that rests on land (ice sheets and glaciers) that adds water to the ocean. Do not credit melting sea ice.
(c) [1] 2010 to 2020 [1] 44 mm (108 - 64 = 44). Accept 4.4 mm per year.$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 9 | B 2]]
Task 2: Applying scientific and geographical ideas

THEME: Port Merrow - defending a coast and powering a town
Port Merrow is a fictional coastal town of 14 000 people. The council must decide how to protect the town from flooding and how to meet its energy targets. Read Sources A to F, which come from different fields of study, and use them to answer the tasks.

Source A: Monitoring record (Merrow Coastal Monitoring Group)
Year: 1990, 2000, 2010, 2020
Mean sea level above the 1990 baseline (mm): 0, 28, 64, 108
Flood warnings issued in the year: 2, 3, 6, 9
Properties flooded in the year: 0, 12, 85, 140

Source B: Science note (Merrow Marine Science Centre), "Why the sea is rising and how storms make it worse"
"Sea level rises for two main reasons. First, water expands when it warms (thermal expansion) because its particles move faster and take up slightly more space. Second, ice that rests on land, such as ice sheets and mountain glaciers, melts and the water runs into the ocean. Melting of ice that is already floating, such as sea ice, adds almost no extra volume. In a storm, a fall in air pressure lets the sea surface rise. As a rough rule, every 1 hPa that the pressure falls below the normal value of 1013 hPa raises the local sea surface by about 1 cm. A storm on 14 November 2023 had a central pressure of 978 hPa. Our field measurements also show that each 50 m width of saltmarsh reduces the height of a wave entering it by 20% of its height at the start of that 50 m. The energy carried by each metre of a wave crest is proportional to the square of the wave height."

Source C: Appraisal of three flood-defence options (Tideway Partners, consultants to the council; figures in millions of pounds, GBP)
Option 1, concrete sea wall: capital cost 42; maintenance 0.5 per year; working life 50 years; flood damage avoided 3.1 per year; effect on habitat: removes 22 hectares of saltmarsh.
Option 2, restored saltmarsh with a low embankment: capital cost 18; maintenance 0.3 per year; working life 40 years; flood damage avoided 1.7 per year; effect on habitat: creates 35 hectares of saltmarsh.
Option 3, tidal barrier with turbines: capital cost 65; maintenance 1.2 per year; working life 60 years; flood damage avoided 4.2 per year; also generates 9 500 MWh of electricity per year.
Note: total cost = capital cost + (maintenance per year x working life). Total benefit = damage avoided per year x working life. Benefit-cost ratio (BCR) = total benefit / total cost. Figures exclude the value of habitats, tourism and fishing.

Source D: Interview extract (Coast Talk, local radio), Marta Quill, mussel farmer and chair of the Merrow Boatyard Association
Interviewer: Some people say a concrete wall is the only safe answer. You disagree?
Quill: "My family's boatyard has flooded three times in eight years. Believe me, I want protection, and I want it quickly. But look at the marsh at Teller's Point. When the November storm hit, the water was shin-deep there and chest-deep on Harbour Road. The marsh did that for nothing. My mussel beds, forty jobs in the season, depend on the clean water that marsh filters. A wall would be a monument to our fear, and it would cut the town off from the sea that made it. I am not against engineers. I am against being told it is wall or nothing."

Source E: Policy statement (Merrow Town Council, Climate and Coast Strategy)
1. Flood-defence capital spending may not exceed GBP 50 million, which is the limit of the grant from the Regional Resilience Fund.
2. By 2035, at least 40% of the town's yearly electricity demand must be met by renewable sources generated locally.
3. There must be no net loss of protected coastal habitat.
4. Residents must be consulted before a final decision, and the Strategy must be reviewed every five years.

Source F: Energy options sheet (SeaWind Developments Ltd, a company bidding to build the turbines)
Town electricity demand: 62 000 MWh per year. Hours in a year: 8 760.
Offshore wind turbine: rated power 3.6 MW; capacity factor 35% (the fraction of the rated power it delivers on average over a year); installed cost GBP 5.4 million each.
Tidal stream turbine: rated power 1.2 MW; capacity factor 40%; installed cost GBP 4.8 million each.
Statement: "Our wind turbines deliver reliable, clean power for decades."
Carbon: replacing grid electricity with local renewable electricity avoids 0.2 kg of carbon dioxide for every kWh (1 MWh = 1000 kWh).

(a) Show that the storm on 14 November 2023 raised the local sea surface by about 35 cm, using the rule in Source B. (2 marks)
(b) Waves 1.5 m high enter a saltmarsh that is 100 m wide. Calculate the height of the waves leaving the marsh, and determine the percentage by which the wave energy per metre of crest is reduced. (3 marks)
(c) Explain why the melting of land ice raises sea level but the melting of floating sea ice adds almost nothing. (2 marks)
(d) Use the rate of rise between 2010 and 2020 in Source A to predict the mean sea level above the 1990 baseline in 2050. (2 marks)
(e) Evaluate how reliable your prediction in part (d) is. (2 marks)

Total for Question 2: 11 marks$mq$, $mq$(a) [1] Pressure fall = 1013 - 978 = 35 hPa [1] 35 hPa x 1 cm per hPa = 35 cm
(b) [1] Two 50 m sections, each leaving 80% of the height: 1.5 x 0.8 x 0.8 = 0.96 m [1] Energy proportional to height squared: ratio = 0.96^2 / 1.5^2 = 0.4096 (accept 0.41) [1] Reduction = (1 - 0.4096) = 59% (accept 59.04% or 59-60%)
(c) [1] Land ice is water that was not previously in the ocean, so melting adds new volume to the ocean [1] Floating ice already displaces its own weight of water, so when it melts it takes up about the same volume (it fills the space it displaced)
(d) [1] Rate = 44 mm / 10 years = 4.4 mm per year, over 30 years = 132 mm [1] 108 + 132 = 240 mm
(e) [1] The rate has increased each decade (28, 36, 44 mm), so a constant rate probably underestimates the 2050 level [1] Valid supporting point, for example only four data points, local land movement, storm surges or ice-melt rates not included, or the prediction extends three times further than the data. Accept any valid evaluation point linked to evidence.$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 5 | B 4]]
Task 3: Costs, benefits and the limits of numbers

THEME: Port Merrow - defending a coast and powering a town
Port Merrow is a fictional coastal town of 14 000 people. The council must decide how to protect the town from flooding and how to meet its energy targets. Read Sources A to F, which come from different fields of study, and use them to answer the tasks.

Source A: Monitoring record (Merrow Coastal Monitoring Group)
Year: 1990, 2000, 2010, 2020
Mean sea level above the 1990 baseline (mm): 0, 28, 64, 108
Flood warnings issued in the year: 2, 3, 6, 9
Properties flooded in the year: 0, 12, 85, 140

Source B: Science note (Merrow Marine Science Centre), "Why the sea is rising and how storms make it worse"
"Sea level rises for two main reasons. First, water expands when it warms (thermal expansion) because its particles move faster and take up slightly more space. Second, ice that rests on land, such as ice sheets and mountain glaciers, melts and the water runs into the ocean. Melting of ice that is already floating, such as sea ice, adds almost no extra volume. In a storm, a fall in air pressure lets the sea surface rise. As a rough rule, every 1 hPa that the pressure falls below the normal value of 1013 hPa raises the local sea surface by about 1 cm. A storm on 14 November 2023 had a central pressure of 978 hPa. Our field measurements also show that each 50 m width of saltmarsh reduces the height of a wave entering it by 20% of its height at the start of that 50 m. The energy carried by each metre of a wave crest is proportional to the square of the wave height."

Source C: Appraisal of three flood-defence options (Tideway Partners, consultants to the council; figures in millions of pounds, GBP)
Option 1, concrete sea wall: capital cost 42; maintenance 0.5 per year; working life 50 years; flood damage avoided 3.1 per year; effect on habitat: removes 22 hectares of saltmarsh.
Option 2, restored saltmarsh with a low embankment: capital cost 18; maintenance 0.3 per year; working life 40 years; flood damage avoided 1.7 per year; effect on habitat: creates 35 hectares of saltmarsh.
Option 3, tidal barrier with turbines: capital cost 65; maintenance 1.2 per year; working life 60 years; flood damage avoided 4.2 per year; also generates 9 500 MWh of electricity per year.
Note: total cost = capital cost + (maintenance per year x working life). Total benefit = damage avoided per year x working life. Benefit-cost ratio (BCR) = total benefit / total cost. Figures exclude the value of habitats, tourism and fishing.

Source D: Interview extract (Coast Talk, local radio), Marta Quill, mussel farmer and chair of the Merrow Boatyard Association
Interviewer: Some people say a concrete wall is the only safe answer. You disagree?
Quill: "My family's boatyard has flooded three times in eight years. Believe me, I want protection, and I want it quickly. But look at the marsh at Teller's Point. When the November storm hit, the water was shin-deep there and chest-deep on Harbour Road. The marsh did that for nothing. My mussel beds, forty jobs in the season, depend on the clean water that marsh filters. A wall would be a monument to our fear, and it would cut the town off from the sea that made it. I am not against engineers. I am against being told it is wall or nothing."

Source E: Policy statement (Merrow Town Council, Climate and Coast Strategy)
1. Flood-defence capital spending may not exceed GBP 50 million, which is the limit of the grant from the Regional Resilience Fund.
2. By 2035, at least 40% of the town's yearly electricity demand must be met by renewable sources generated locally.
3. There must be no net loss of protected coastal habitat.
4. Residents must be consulted before a final decision, and the Strategy must be reviewed every five years.

Source F: Energy options sheet (SeaWind Developments Ltd, a company bidding to build the turbines)
Town electricity demand: 62 000 MWh per year. Hours in a year: 8 760.
Offshore wind turbine: rated power 3.6 MW; capacity factor 35% (the fraction of the rated power it delivers on average over a year); installed cost GBP 5.4 million each.
Tidal stream turbine: rated power 1.2 MW; capacity factor 40%; installed cost GBP 4.8 million each.
Statement: "Our wind turbines deliver reliable, clean power for decades."
Carbon: replacing grid electricity with local renewable electricity avoids 0.2 kg of carbon dioxide for every kWh (1 MWh = 1000 kWh).

(a) Calculate the total cost, the total benefit and the benefit-cost ratio (BCR) of Option 2 in Source C. (3 marks)
(b) Show that the BCR of Option 1 is 2.3 when given to one decimal place. (2 marks)
(c) Explain why the BCR alone is not enough to choose between Options 1 and 2. (2 marks)
(d) Identify two costs or benefits that are not measured in money in Source C and name the field of study that would be best placed to investigate each. (2 marks)

Total for Question 3: 9 marks$mq$, $mq$(a) [1] Total cost = 18 + (0.3 x 40) = GBP 30 million [1] Total benefit = 1.7 x 40 = GBP 68 million [1] BCR = 68 / 30 = 2.27 (accept 2.3)
(b) [1] Total cost = 42 + (0.5 x 50) = 67 and total benefit = 3.1 x 50 = 155 [1] 155 / 67 = 2.313..., which is 2.3 to 1 decimal place
(c) [1] The BCRs are almost the same (2.3 and 2.27), so the ratio cannot separate them [1] The figures exclude habitat, tourism and fishing (Source C), and these matter to residents (Source D) and to the policy limits in Source E (no net loss of habitat)
(d) [1] A valid non-monetary factor with a matching field, for example loss or gain of saltmarsh habitat (biology / ecology), or the town's relationship with the sea and its cultural identity (sociology / humanities) [1] A second, different factor with a matching field, for example fear and safety of residents (psychology / sociology), or jobs in mussel farming (economics). Award each mark only for a factor paired with a sensible field.$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 10 | C 2]]
Task 4: Evaluating sources and communicating findings

THEME: Port Merrow - defending a coast and powering a town
Port Merrow is a fictional coastal town of 14 000 people. The council must decide how to protect the town from flooding and how to meet its energy targets. Read Sources A to F, which come from different fields of study, and use them to answer the tasks.

Source A: Monitoring record (Merrow Coastal Monitoring Group)
Year: 1990, 2000, 2010, 2020
Mean sea level above the 1990 baseline (mm): 0, 28, 64, 108
Flood warnings issued in the year: 2, 3, 6, 9
Properties flooded in the year: 0, 12, 85, 140

Source B: Science note (Merrow Marine Science Centre), "Why the sea is rising and how storms make it worse"
"Sea level rises for two main reasons. First, water expands when it warms (thermal expansion) because its particles move faster and take up slightly more space. Second, ice that rests on land, such as ice sheets and mountain glaciers, melts and the water runs into the ocean. Melting of ice that is already floating, such as sea ice, adds almost no extra volume. In a storm, a fall in air pressure lets the sea surface rise. As a rough rule, every 1 hPa that the pressure falls below the normal value of 1013 hPa raises the local sea surface by about 1 cm. A storm on 14 November 2023 had a central pressure of 978 hPa. Our field measurements also show that each 50 m width of saltmarsh reduces the height of a wave entering it by 20% of its height at the start of that 50 m. The energy carried by each metre of a wave crest is proportional to the square of the wave height."

Source C: Appraisal of three flood-defence options (Tideway Partners, consultants to the council; figures in millions of pounds, GBP)
Option 1, concrete sea wall: capital cost 42; maintenance 0.5 per year; working life 50 years; flood damage avoided 3.1 per year; effect on habitat: removes 22 hectares of saltmarsh.
Option 2, restored saltmarsh with a low embankment: capital cost 18; maintenance 0.3 per year; working life 40 years; flood damage avoided 1.7 per year; effect on habitat: creates 35 hectares of saltmarsh.
Option 3, tidal barrier with turbines: capital cost 65; maintenance 1.2 per year; working life 60 years; flood damage avoided 4.2 per year; also generates 9 500 MWh of electricity per year.
Note: total cost = capital cost + (maintenance per year x working life). Total benefit = damage avoided per year x working life. Benefit-cost ratio (BCR) = total benefit / total cost. Figures exclude the value of habitats, tourism and fishing.

Source D: Interview extract (Coast Talk, local radio), Marta Quill, mussel farmer and chair of the Merrow Boatyard Association
Interviewer: Some people say a concrete wall is the only safe answer. You disagree?
Quill: "My family's boatyard has flooded three times in eight years. Believe me, I want protection, and I want it quickly. But look at the marsh at Teller's Point. When the November storm hit, the water was shin-deep there and chest-deep on Harbour Road. The marsh did that for nothing. My mussel beds, forty jobs in the season, depend on the clean water that marsh filters. A wall would be a monument to our fear, and it would cut the town off from the sea that made it. I am not against engineers. I am against being told it is wall or nothing."

Source E: Policy statement (Merrow Town Council, Climate and Coast Strategy)
1. Flood-defence capital spending may not exceed GBP 50 million, which is the limit of the grant from the Regional Resilience Fund.
2. By 2035, at least 40% of the town's yearly electricity demand must be met by renewable sources generated locally.
3. There must be no net loss of protected coastal habitat.
4. Residents must be consulted before a final decision, and the Strategy must be reviewed every five years.

Source F: Energy options sheet (SeaWind Developments Ltd, a company bidding to build the turbines)
Town electricity demand: 62 000 MWh per year. Hours in a year: 8 760.
Offshore wind turbine: rated power 3.6 MW; capacity factor 35% (the fraction of the rated power it delivers on average over a year); installed cost GBP 5.4 million each.
Tidal stream turbine: rated power 1.2 MW; capacity factor 40%; installed cost GBP 4.8 million each.
Statement: "Our wind turbines deliver reliable, clean power for decades."
Carbon: replacing grid electricity with local renewable electricity avoids 0.2 kg of carbon dioxide for every kWh (1 MWh = 1000 kWh).

(a) Using the origin, purpose, value and limitation of Source D, assess how useful it is for deciding on a flood-defence option. (4 marks)
(b) Compare how Source C and Source D differ in what they count as a benefit of Option 2. (3 marks)
(c) Evaluate how far the statement in Source F, 'reliable, clean power for decades', can be trusted. (3 marks)
(d) Write a headline and a summary of no more than 30 words for the town newsletter that accurately describes the trend shown in Source A. (2 marks)

Total for Question 4: 12 marks$mq$, $mq$(a) [1] Origin: a local radio interview with a mussel farmer and boatyard association chair, so a first-hand local witness [1] Purpose: to persuade listeners that a wall is not the only option, and to represent the interests of the boatyard and mussel farm [1] Value: first-hand evidence of flooding on Harbour Road and the effect of the marsh in the November storm (shin-deep against chest-deep) [1] Limitation: personal and emotional language, one opinion, an interested party, no measurements; the claims about jobs and water quality are not checked
(b) [1] Source C counts only money: damage avoided per year, with habitat excluded [1] Source D counts non-monetary benefits: clean water for mussels, 40 seasonal jobs, and keeping the town connected to the sea [1] Link: both agree that flooding damage is a problem; Source C's exclusion of habitat means it may undervalue what Source D values. Award the third mark for a clear contrast or link supported by evidence.
(c) [1] Origin and purpose: written by a company that wants the contract, so it has a reason to present the turbines positively [1] The capacity factor of 35% shows the turbines do not deliver their rated power all of the time, so 'reliable' is overstated [1] No evidence is given for 'for decades', and 'clean' ignores manufacturing, installation and effects on sea life. Credit independent checking or a second source as a suggestion.
(d) [1] Clear headline and summary of no more than 30 words, in language suitable for residents, with an accurate trend (sea level up 108 mm since 1990, and flood warnings up from 2 to 9) [1] Quantitative evidence from Source A used correctly and the word limit respected$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | A 9 | B 3]]
Task 5: Energy and the flood-defence decision

THEME: Port Merrow - defending a coast and powering a town
Port Merrow is a fictional coastal town of 14 000 people. The council must decide how to protect the town from flooding and how to meet its energy targets. Read Sources A to F, which come from different fields of study, and use them to answer the tasks.

Source A: Monitoring record (Merrow Coastal Monitoring Group)
Year: 1990, 2000, 2010, 2020
Mean sea level above the 1990 baseline (mm): 0, 28, 64, 108
Flood warnings issued in the year: 2, 3, 6, 9
Properties flooded in the year: 0, 12, 85, 140

Source B: Science note (Merrow Marine Science Centre), "Why the sea is rising and how storms make it worse"
"Sea level rises for two main reasons. First, water expands when it warms (thermal expansion) because its particles move faster and take up slightly more space. Second, ice that rests on land, such as ice sheets and mountain glaciers, melts and the water runs into the ocean. Melting of ice that is already floating, such as sea ice, adds almost no extra volume. In a storm, a fall in air pressure lets the sea surface rise. As a rough rule, every 1 hPa that the pressure falls below the normal value of 1013 hPa raises the local sea surface by about 1 cm. A storm on 14 November 2023 had a central pressure of 978 hPa. Our field measurements also show that each 50 m width of saltmarsh reduces the height of a wave entering it by 20% of its height at the start of that 50 m. The energy carried by each metre of a wave crest is proportional to the square of the wave height."

Source C: Appraisal of three flood-defence options (Tideway Partners, consultants to the council; figures in millions of pounds, GBP)
Option 1, concrete sea wall: capital cost 42; maintenance 0.5 per year; working life 50 years; flood damage avoided 3.1 per year; effect on habitat: removes 22 hectares of saltmarsh.
Option 2, restored saltmarsh with a low embankment: capital cost 18; maintenance 0.3 per year; working life 40 years; flood damage avoided 1.7 per year; effect on habitat: creates 35 hectares of saltmarsh.
Option 3, tidal barrier with turbines: capital cost 65; maintenance 1.2 per year; working life 60 years; flood damage avoided 4.2 per year; also generates 9 500 MWh of electricity per year.
Note: total cost = capital cost + (maintenance per year x working life). Total benefit = damage avoided per year x working life. Benefit-cost ratio (BCR) = total benefit / total cost. Figures exclude the value of habitats, tourism and fishing.

Source D: Interview extract (Coast Talk, local radio), Marta Quill, mussel farmer and chair of the Merrow Boatyard Association
Interviewer: Some people say a concrete wall is the only safe answer. You disagree?
Quill: "My family's boatyard has flooded three times in eight years. Believe me, I want protection, and I want it quickly. But look at the marsh at Teller's Point. When the November storm hit, the water was shin-deep there and chest-deep on Harbour Road. The marsh did that for nothing. My mussel beds, forty jobs in the season, depend on the clean water that marsh filters. A wall would be a monument to our fear, and it would cut the town off from the sea that made it. I am not against engineers. I am against being told it is wall or nothing."

Source E: Policy statement (Merrow Town Council, Climate and Coast Strategy)
1. Flood-defence capital spending may not exceed GBP 50 million, which is the limit of the grant from the Regional Resilience Fund.
2. By 2035, at least 40% of the town's yearly electricity demand must be met by renewable sources generated locally.
3. There must be no net loss of protected coastal habitat.
4. Residents must be consulted before a final decision, and the Strategy must be reviewed every five years.

Source F: Energy options sheet (SeaWind Developments Ltd, a company bidding to build the turbines)
Town electricity demand: 62 000 MWh per year. Hours in a year: 8 760.
Offshore wind turbine: rated power 3.6 MW; capacity factor 35% (the fraction of the rated power it delivers on average over a year); installed cost GBP 5.4 million each.
Tidal stream turbine: rated power 1.2 MW; capacity factor 40%; installed cost GBP 4.8 million each.
Statement: "Our wind turbines deliver reliable, clean power for decades."
Carbon: replacing grid electricity with local renewable electricity avoids 0.2 kg of carbon dioxide for every kWh (1 MWh = 1000 kWh).

(a) Show that one offshore wind turbine in Source F delivers about 11 000 MWh of electricity per year. (2 marks)
(b) Calculate the smallest number of offshore wind turbines needed to meet the 40% target in Source E. (3 marks)
(c) The council could instead use tidal stream turbines, which each deliver about 4 200 MWh per year. Determine which would cost less to meet the 40% target and by how much. (2 marks)
(d) The barrier in Option 3 generates 9 500 MWh per year. Calculate this as a percentage of the electricity needed for the 40% target. (2 marks)
(e) Suggest, with reasons, a combined plan for flood defence and electricity that meets all the limits in Source E, using ideas from at least two fields of study. (3 marks)

Total for Question 5: 12 marks$mq$, $mq$(a) [1] 3.6 MW x 0.35 = 1.26 MW average output [1] 1.26 x 8760 = 11 037.6 MWh, which is about 11 000 MWh
(b) [1] 40% of 62 000 = 24 800 MWh [1] 24 800 / 11 037.6 = 2.25 turbines [1] Rounded up to 3 turbines (must be a whole number)
(c) [1] Tidal: 24 800 / 4 204.8 = 5.9, so 6 turbines, costing 6 x 4.8 = GBP 28.8 million (wind: 3 x 5.4 = GBP 16.2 million) [1] Wind is cheaper by GBP 12.6 million (accept 12.6)
(d) [1] 9 500 / 24 800 [1] 38.3% (accept 38%)
(e) [1] A combination that fits the capital limit of GBP 50 million, for example Option 2 (18) plus 3 wind turbines (16.2) = 34.2 million, or Option 3 is rejected as it costs 65 million alone [1] Links two or more fields: for example the marsh reduces wave energy (science) and avoids habitat loss (biology/geography), while the turbines meet 40% of demand (design/engineering) [1] Justified with evidence from the sources, such as 24 800 MWh needed, no net loss of habitat or the BCR figures. Accept an alternative combination that is costed and justified.$mq$, $mq$A$mq$),
(6, $mq$[[Q 6 | B 8 | C 6]]
Task 6: Synthesis - recommendation to the council

THEME: Port Merrow - defending a coast and powering a town
Port Merrow is a fictional coastal town of 14 000 people. The council must decide how to protect the town from flooding and how to meet its energy targets. Read Sources A to F, which come from different fields of study, and use them to answer the tasks.

Source A: Monitoring record (Merrow Coastal Monitoring Group)
Year: 1990, 2000, 2010, 2020
Mean sea level above the 1990 baseline (mm): 0, 28, 64, 108
Flood warnings issued in the year: 2, 3, 6, 9
Properties flooded in the year: 0, 12, 85, 140

Source B: Science note (Merrow Marine Science Centre), "Why the sea is rising and how storms make it worse"
"Sea level rises for two main reasons. First, water expands when it warms (thermal expansion) because its particles move faster and take up slightly more space. Second, ice that rests on land, such as ice sheets and mountain glaciers, melts and the water runs into the ocean. Melting of ice that is already floating, such as sea ice, adds almost no extra volume. In a storm, a fall in air pressure lets the sea surface rise. As a rough rule, every 1 hPa that the pressure falls below the normal value of 1013 hPa raises the local sea surface by about 1 cm. A storm on 14 November 2023 had a central pressure of 978 hPa. Our field measurements also show that each 50 m width of saltmarsh reduces the height of a wave entering it by 20% of its height at the start of that 50 m. The energy carried by each metre of a wave crest is proportional to the square of the wave height."

Source C: Appraisal of three flood-defence options (Tideway Partners, consultants to the council; figures in millions of pounds, GBP)
Option 1, concrete sea wall: capital cost 42; maintenance 0.5 per year; working life 50 years; flood damage avoided 3.1 per year; effect on habitat: removes 22 hectares of saltmarsh.
Option 2, restored saltmarsh with a low embankment: capital cost 18; maintenance 0.3 per year; working life 40 years; flood damage avoided 1.7 per year; effect on habitat: creates 35 hectares of saltmarsh.
Option 3, tidal barrier with turbines: capital cost 65; maintenance 1.2 per year; working life 60 years; flood damage avoided 4.2 per year; also generates 9 500 MWh of electricity per year.
Note: total cost = capital cost + (maintenance per year x working life). Total benefit = damage avoided per year x working life. Benefit-cost ratio (BCR) = total benefit / total cost. Figures exclude the value of habitats, tourism and fishing.

Source D: Interview extract (Coast Talk, local radio), Marta Quill, mussel farmer and chair of the Merrow Boatyard Association
Interviewer: Some people say a concrete wall is the only safe answer. You disagree?
Quill: "My family's boatyard has flooded three times in eight years. Believe me, I want protection, and I want it quickly. But look at the marsh at Teller's Point. When the November storm hit, the water was shin-deep there and chest-deep on Harbour Road. The marsh did that for nothing. My mussel beds, forty jobs in the season, depend on the clean water that marsh filters. A wall would be a monument to our fear, and it would cut the town off from the sea that made it. I am not against engineers. I am against being told it is wall or nothing."

Source E: Policy statement (Merrow Town Council, Climate and Coast Strategy)
1. Flood-defence capital spending may not exceed GBP 50 million, which is the limit of the grant from the Regional Resilience Fund.
2. By 2035, at least 40% of the town's yearly electricity demand must be met by renewable sources generated locally.
3. There must be no net loss of protected coastal habitat.
4. Residents must be consulted before a final decision, and the Strategy must be reviewed every five years.

Source F: Energy options sheet (SeaWind Developments Ltd, a company bidding to build the turbines)
Town electricity demand: 62 000 MWh per year. Hours in a year: 8 760.
Offshore wind turbine: rated power 3.6 MW; capacity factor 35% (the fraction of the rated power it delivers on average over a year); installed cost GBP 5.4 million each.
Tidal stream turbine: rated power 1.2 MW; capacity factor 40%; installed cost GBP 4.8 million each.
Statement: "Our wind turbines deliver reliable, clean power for decades."
Carbon: replacing grid electricity with local renewable electricity avoids 0.2 kg of carbon dioxide for every kWh (1 MWh = 1000 kWh).

Port Merrow's council meets next week to choose a flood-defence option and a plan for local electricity. You are an adviser. Write a recommendation of 250 to 350 words for the council that makes a decision and justifies it. Use evidence from at least four of Sources A to F, draw on at least three different fields of study, explain how the fields are connected, and state one limitation of your recommendation. Refer to sources by letter (for example, 'Source C').

(a) Synthesise ideas from the sources into a justified recommendation (criterion B: synthesizing). (8 marks)
(b) Communicate the recommendation clearly to the council (criterion C: communicating). (6 marks)

Total for Question 6: 14 marks$mq$, $mq$(a) Award up to 8 marks for synthesis; use the indicative content, then confirm with the descriptors. [1] A clear, firm recommendation for the flood defence (for example Option 2 or a justified alternative) [1] Uses the cost data: totals and BCRs from Source C (2.27, 2.3, 1.84) and the GBP 50 million limit in Source E [1] Uses science: sea level rise of 108 mm and the 240 mm prediction, or wave energy reduction of 59% by 100 m of saltmarsh (Sources A, B) [1] Uses human perspective: Source D (jobs, flooding experience, the marsh) [1] Links the flood decision to the energy decision (40% target, 24 800 MWh, wind or tidal choice, Sources E and F) [1] Explains a connection between at least two fields so that the combined view gives an answer that neither field gives alone (for example economics and ecology) [1] Handles a conflict or trade-off in the evidence (for example cheapest versus no net loss of habitat) [1] Shows awareness of source reliability (for example the bidder in Source F or the interested party in Source D). Level descriptors for B: 1-2 marks, sources listed or described separately with little connection; 3-4 marks, some connections between two fields with partly justified decision; 5-6 marks, clear integration of at least three fields and a justified decision; 7-8 marks, fully integrated insight that resolves trade-offs, with evaluation of evidence and a decision that meets all policy limits.
(b) Award up to 6 marks for communication. [1] Organised structure with a clear opening decision, reasons and a conclusion [1] Tone and register suitable for a council audience [1] Accurate use of subject vocabulary (for example benefit-cost ratio, capacity factor, saltmarsh, thermal expansion) [1] Sources acknowledged by letter and numbers quoted correctly [1] Sentences clear and accurate, with logical paragraphs and links [1] Stays within 250 to 350 words. Level descriptors for C: 1-2 marks, ideas hard to follow or poorly organised; 3-4 marks, mostly clear and organised with some referencing; 5-6 marks, clear, concise and convincing writing for the audience with consistent referencing.$mq$, $mq$B$mq$),
(7, $mq$[[Q 7 | C 2 | D 10]]
Task 7: Reflecting on the process

THEME: Port Merrow - defending a coast and powering a town
Port Merrow is a fictional coastal town of 14 000 people. The council must decide how to protect the town from flooding and how to meet its energy targets. Read Sources A to F, which come from different fields of study, and use them to answer the tasks.

Source A: Monitoring record (Merrow Coastal Monitoring Group)
Year: 1990, 2000, 2010, 2020
Mean sea level above the 1990 baseline (mm): 0, 28, 64, 108
Flood warnings issued in the year: 2, 3, 6, 9
Properties flooded in the year: 0, 12, 85, 140

Source B: Science note (Merrow Marine Science Centre), "Why the sea is rising and how storms make it worse"
"Sea level rises for two main reasons. First, water expands when it warms (thermal expansion) because its particles move faster and take up slightly more space. Second, ice that rests on land, such as ice sheets and mountain glaciers, melts and the water runs into the ocean. Melting of ice that is already floating, such as sea ice, adds almost no extra volume. In a storm, a fall in air pressure lets the sea surface rise. As a rough rule, every 1 hPa that the pressure falls below the normal value of 1013 hPa raises the local sea surface by about 1 cm. A storm on 14 November 2023 had a central pressure of 978 hPa. Our field measurements also show that each 50 m width of saltmarsh reduces the height of a wave entering it by 20% of its height at the start of that 50 m. The energy carried by each metre of a wave crest is proportional to the square of the wave height."

Source C: Appraisal of three flood-defence options (Tideway Partners, consultants to the council; figures in millions of pounds, GBP)
Option 1, concrete sea wall: capital cost 42; maintenance 0.5 per year; working life 50 years; flood damage avoided 3.1 per year; effect on habitat: removes 22 hectares of saltmarsh.
Option 2, restored saltmarsh with a low embankment: capital cost 18; maintenance 0.3 per year; working life 40 years; flood damage avoided 1.7 per year; effect on habitat: creates 35 hectares of saltmarsh.
Option 3, tidal barrier with turbines: capital cost 65; maintenance 1.2 per year; working life 60 years; flood damage avoided 4.2 per year; also generates 9 500 MWh of electricity per year.
Note: total cost = capital cost + (maintenance per year x working life). Total benefit = damage avoided per year x working life. Benefit-cost ratio (BCR) = total benefit / total cost. Figures exclude the value of habitats, tourism and fishing.

Source D: Interview extract (Coast Talk, local radio), Marta Quill, mussel farmer and chair of the Merrow Boatyard Association
Interviewer: Some people say a concrete wall is the only safe answer. You disagree?
Quill: "My family's boatyard has flooded three times in eight years. Believe me, I want protection, and I want it quickly. But look at the marsh at Teller's Point. When the November storm hit, the water was shin-deep there and chest-deep on Harbour Road. The marsh did that for nothing. My mussel beds, forty jobs in the season, depend on the clean water that marsh filters. A wall would be a monument to our fear, and it would cut the town off from the sea that made it. I am not against engineers. I am against being told it is wall or nothing."

Source E: Policy statement (Merrow Town Council, Climate and Coast Strategy)
1. Flood-defence capital spending may not exceed GBP 50 million, which is the limit of the grant from the Regional Resilience Fund.
2. By 2035, at least 40% of the town's yearly electricity demand must be met by renewable sources generated locally.
3. There must be no net loss of protected coastal habitat.
4. Residents must be consulted before a final decision, and the Strategy must be reviewed every five years.

Source F: Energy options sheet (SeaWind Developments Ltd, a company bidding to build the turbines)
Town electricity demand: 62 000 MWh per year. Hours in a year: 8 760.
Offshore wind turbine: rated power 3.6 MW; capacity factor 35% (the fraction of the rated power it delivers on average over a year); installed cost GBP 5.4 million each.
Tidal stream turbine: rated power 1.2 MW; capacity factor 40%; installed cost GBP 4.8 million each.
Statement: "Our wind turbines deliver reliable, clean power for decades."
Carbon: replacing grid electricity with local renewable electricity avoids 0.2 kg of carbon dioxide for every kWh (1 MWh = 1000 kWh).

(a) Describe one insight you gained by combining two fields of study that you could not have reached using one field alone. (3 marks)
(b) Explain one limitation or possible bias in the evidence you used, and how it could affect your recommendation. (3 marks)
(c) Evaluate how your recommendation might need to change if sea level rise accelerates faster than predicted. (2 marks)
(d) Reflect on one strategy that helped you to connect the sources and one thing you would do differently next time. (2 marks)
(e) Write a message of no more than 50 words for a residents' group explaining, in plain language, the main uncertainty in your recommendation. (2 marks)

Total for Question 7: 12 marks$mq$, $mq$(a) [1] Identifies two fields clearly [1] States a specific insight, for example the saltmarsh is both a cheap flood defence (economics) and a wave-energy absorber (science), so it is not only an environmental choice [1] Explains why one field alone would be insufficient (for example Source C ignores habitat; Source B ignores cost)
(b) [1] Identifies a specific limitation or bias (for example the bidder in Source F; Source C excludes habitat; one voice in Source D) [1] Explains how it could distort the recommendation [1] Gives a way to reduce the problem (for example seeking independent data or more local voices)
(c) [1] Identifies a change, such as a higher defence, a review earlier than every five years (Source E) or a stronger embankment [1] Evaluates the effect on cost, habitat or energy plans with a reason
(d) [1] A specific strategy (for example making a table of fields and sources, or comparing numbers) with why it helped [1] A realistic improvement for next time, linked to the process
(e) [1] Plain, polite language suitable for non-experts, within 50 words [1] Accurately names the main uncertainty (for example how fast sea level will rise or the cost estimates) and why it matters$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Interdisciplinary Learning MYP 5 eAssessment Structure Mock B (7 tasks, 78 marks) (78 marks)
with sub as (select id from public.subjects where slug = $mq$interdisciplinary-learning$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Interdisciplinary Learning MYP 5 eAssessment Structure Mock B (7 tasks, 78 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Interdisciplinary Learning MYP 5 eAssessment Structure Mock B (7 tasks, 78 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: Identifying disciplines and reading data

THEME: Calder Vale - feeding a growing city
Calder Vale is a fictional city of 540 000 people. Its food council is deciding how to make the city's fresh food supply more secure, healthier and more sustainable. Read Sources A to F, which come from different fields of study, and use them to answer the tasks.

Source A: Food supply record (Calder Vale Food Council data table)
Year: 2000, 2010, 2020
City population (thousands): 410, 468, 540
Share of fresh vegetables imported from other countries (%): 62, 71, 78
Average distance that fresh vegetables travel to reach the city (km): 1100, 1450, 1900

Source B: Research note (Verdant Systems Ltd, a company that builds and sells vertical farms), "Growing lettuce: field or tower?"
"Plants make their own food by photosynthesis. Chlorophyll absorbs mainly red and blue light and reflects green light, which is why leaves look green. Our vertical farm grows lettuce without soil (hydroponics): the roots sit in water containing dissolved mineral ions, and LED lamps give red and blue light to the leaves in 12 stacked layers.
Field lettuce: yield 3.5 kg per square metre of land per year; water use 250 litres per kg.
Vertical farm: yield 60 kg per square metre of floor area per year; water use 20 litres per kg; electricity use 25 kWh per kg.
Grid electricity releases 0.2 kg of carbon dioxide per kWh. Road transport of food releases 0.0001 kg of carbon dioxide for every kg carried for every km travelled.
Plan: the city grows 120 000 kg of lettuce a year (the amount currently imported over 1900 km)."

Source C: Business plan (GreenDeck Ltd, a rooftop farm start-up; independent accountant's summary)
Start-up cost: GBP 480 000. Running cost: GBP 210 000 per year. Output: 70 000 kg of lettuce and herbs per year. Selling price: GBP 3.60 per kg. Price of imported equivalent in shops: GBP 2.80 per kg. Note: the accountant has assumed that every kilogram produced is sold, and that running costs stay constant.

Source D: Interview extract ("Calder Vale Voices" podcast), Tomas Idowu, coordinator of the Northfield Community Garden
Host: What does the garden give people that a supermarket does not?
Idowu: "Fresh kale at a price they can afford, yes. But also somewhere to go on a Tuesday evening. Eighty families have a plot. Last summer a boy of nine pulled a carrot out of the ground and said, 'It's real!' as if I had performed magic. The nearest big shop is two and a half kilometres away, and you need a bus ticket and two hands free. People ask me whether our garden is 'efficient'. I ask them: efficient at what? Our plots are small, and some years the slugs win. But nobody in Northfield has ever been grown a bar of chocolate by a spreadsheet."

Source E: Policy statement (Calder Vale City Food Strategy)
1. By 2035, at least 20% of the city's fresh vegetables must be grown within 50 km of Calder Vale. The average resident eats 80 kg of fresh vegetables per year.
2. An Urban Growing Fund of GBP 2.0 million is available. Priority goes to wards where fewer than 30% of adults eat five portions of fruit and vegetables per day.
3. Public-building rooftops may be used for growing, and each project must publish its water and energy use every year.

Source F: Infographic described in words (Calder Vale Public Health Unit survey, 1 500 adults in each ward)
Title: "Who eats their five a day?" The graphic shows three horizontal bars, one for each ward, with a small shop icon at a distance from the bar's left end.
Ward: Northfield, Eastgate, Hillcrest
Adults eating five portions of fruit and vegetables per day (%): 21, 38, 59
Distance to nearest supermarket (km): 2.4, 1.1, 0.6
Median household income (GBP per year): 19 500, 27 000, 41 000

(a) Identify the field of study (discipline) that each of Sources A, B, C and F draws on most. Give one field for each source. (4 marks)
(b) State the word equation for photosynthesis, which is described in Source B. (2 marks)
(c) Use Source A to calculate the percentage increase in the average distance that fresh vegetables travel between 2000 and 2020. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] Source A: geography / Individuals and Societies (accept mathematics for data handling) [1] Source B: sciences (biology, accept botany or agricultural science) [1] Source C: economics / business [1] Source F: health and physical education / Individuals and Societies (accept mathematics for data handling). One field per source, and it must match the content.
(b) [1] Carbon dioxide + water [1] (with light energy and chlorophyll) produces glucose + oxygen. Accept the symbol equation 6CO2 + 6H2O -> C6H12O6 + 6O2 for both marks.
(c) [1] (1900 - 1100) / 1100 [1] 72.7% (accept 73%)$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 9 | B 2]]
Task 2: Comparing field and vertical farming

THEME: Calder Vale - feeding a growing city
Calder Vale is a fictional city of 540 000 people. Its food council is deciding how to make the city's fresh food supply more secure, healthier and more sustainable. Read Sources A to F, which come from different fields of study, and use them to answer the tasks.

Source A: Food supply record (Calder Vale Food Council data table)
Year: 2000, 2010, 2020
City population (thousands): 410, 468, 540
Share of fresh vegetables imported from other countries (%): 62, 71, 78
Average distance that fresh vegetables travel to reach the city (km): 1100, 1450, 1900

Source B: Research note (Verdant Systems Ltd, a company that builds and sells vertical farms), "Growing lettuce: field or tower?"
"Plants make their own food by photosynthesis. Chlorophyll absorbs mainly red and blue light and reflects green light, which is why leaves look green. Our vertical farm grows lettuce without soil (hydroponics): the roots sit in water containing dissolved mineral ions, and LED lamps give red and blue light to the leaves in 12 stacked layers.
Field lettuce: yield 3.5 kg per square metre of land per year; water use 250 litres per kg.
Vertical farm: yield 60 kg per square metre of floor area per year; water use 20 litres per kg; electricity use 25 kWh per kg.
Grid electricity releases 0.2 kg of carbon dioxide per kWh. Road transport of food releases 0.0001 kg of carbon dioxide for every kg carried for every km travelled.
Plan: the city grows 120 000 kg of lettuce a year (the amount currently imported over 1900 km)."

Source C: Business plan (GreenDeck Ltd, a rooftop farm start-up; independent accountant's summary)
Start-up cost: GBP 480 000. Running cost: GBP 210 000 per year. Output: 70 000 kg of lettuce and herbs per year. Selling price: GBP 3.60 per kg. Price of imported equivalent in shops: GBP 2.80 per kg. Note: the accountant has assumed that every kilogram produced is sold, and that running costs stay constant.

Source D: Interview extract ("Calder Vale Voices" podcast), Tomas Idowu, coordinator of the Northfield Community Garden
Host: What does the garden give people that a supermarket does not?
Idowu: "Fresh kale at a price they can afford, yes. But also somewhere to go on a Tuesday evening. Eighty families have a plot. Last summer a boy of nine pulled a carrot out of the ground and said, 'It's real!' as if I had performed magic. The nearest big shop is two and a half kilometres away, and you need a bus ticket and two hands free. People ask me whether our garden is 'efficient'. I ask them: efficient at what? Our plots are small, and some years the slugs win. But nobody in Northfield has ever been grown a bar of chocolate by a spreadsheet."

Source E: Policy statement (Calder Vale City Food Strategy)
1. By 2035, at least 20% of the city's fresh vegetables must be grown within 50 km of Calder Vale. The average resident eats 80 kg of fresh vegetables per year.
2. An Urban Growing Fund of GBP 2.0 million is available. Priority goes to wards where fewer than 30% of adults eat five portions of fruit and vegetables per day.
3. Public-building rooftops may be used for growing, and each project must publish its water and energy use every year.

Source F: Infographic described in words (Calder Vale Public Health Unit survey, 1 500 adults in each ward)
Title: "Who eats their five a day?" The graphic shows three horizontal bars, one for each ward, with a small shop icon at a distance from the bar's left end.
Ward: Northfield, Eastgate, Hillcrest
Adults eating five portions of fruit and vegetables per day (%): 21, 38, 59
Distance to nearest supermarket (km): 2.4, 1.1, 0.6
Median household income (GBP per year): 19 500, 27 000, 41 000

(a) Calculate the area needed to grow 120 000 kg of lettuce a year in the field and in the vertical farm, and state how many times larger the field area is. (3 marks)
(b) Calculate the volume of water saved per year by using the vertical farm instead of the field, and express it as a percentage of the field's water use. (3 marks)
(c) Show that the vertical farm uses 3 000 000 kWh of electricity per year and that this releases 600 000 kg of carbon dioxide. (2 marks)
(d) Calculate the carbon dioxide released by transporting 120 000 kg of lettuce over 1 900 km by road. (1 mark)
(e) Using your answers to (c) and (d), evaluate whether the vertical farm in Source B would reduce the city's carbon emissions. (2 marks)

Total for Question 2: 11 marks$mq$, $mq$(a) [1] Field: 120 000 / 3.5 = 34 286 square metres (accept 34 300) [1] Vertical farm: 120 000 / 60 = 2 000 square metres [1] 34 286 / 2 000 = 17 times larger (accept 17.1)
(b) [1] Field: 250 x 120 000 = 30 000 000 litres; vertical: 20 x 120 000 = 2 400 000 litres [1] Saving = 27 600 000 litres [1] 27.6 / 30 = 92%
(c) [1] 25 x 120 000 = 3 000 000 kWh [1] 3 000 000 x 0.2 = 600 000 kg
(d) [1] 120 000 x 1 900 x 0.0001 = 22 800 kg
(e) [1] With grid electricity the farm releases 600 000 kg compared with 22 800 kg for transport, about 26 times more, so it would not reduce emissions [1] A condition or alternative, for example it would only help if powered by renewable electricity, and this must be balanced against the benefits of saving water and land. Accept a justified conclusion that uses the numbers.$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 9 | B 2]]
Task 3: Business, price and the city's target

THEME: Calder Vale - feeding a growing city
Calder Vale is a fictional city of 540 000 people. Its food council is deciding how to make the city's fresh food supply more secure, healthier and more sustainable. Read Sources A to F, which come from different fields of study, and use them to answer the tasks.

Source A: Food supply record (Calder Vale Food Council data table)
Year: 2000, 2010, 2020
City population (thousands): 410, 468, 540
Share of fresh vegetables imported from other countries (%): 62, 71, 78
Average distance that fresh vegetables travel to reach the city (km): 1100, 1450, 1900

Source B: Research note (Verdant Systems Ltd, a company that builds and sells vertical farms), "Growing lettuce: field or tower?"
"Plants make their own food by photosynthesis. Chlorophyll absorbs mainly red and blue light and reflects green light, which is why leaves look green. Our vertical farm grows lettuce without soil (hydroponics): the roots sit in water containing dissolved mineral ions, and LED lamps give red and blue light to the leaves in 12 stacked layers.
Field lettuce: yield 3.5 kg per square metre of land per year; water use 250 litres per kg.
Vertical farm: yield 60 kg per square metre of floor area per year; water use 20 litres per kg; electricity use 25 kWh per kg.
Grid electricity releases 0.2 kg of carbon dioxide per kWh. Road transport of food releases 0.0001 kg of carbon dioxide for every kg carried for every km travelled.
Plan: the city grows 120 000 kg of lettuce a year (the amount currently imported over 1900 km)."

Source C: Business plan (GreenDeck Ltd, a rooftop farm start-up; independent accountant's summary)
Start-up cost: GBP 480 000. Running cost: GBP 210 000 per year. Output: 70 000 kg of lettuce and herbs per year. Selling price: GBP 3.60 per kg. Price of imported equivalent in shops: GBP 2.80 per kg. Note: the accountant has assumed that every kilogram produced is sold, and that running costs stay constant.

Source D: Interview extract ("Calder Vale Voices" podcast), Tomas Idowu, coordinator of the Northfield Community Garden
Host: What does the garden give people that a supermarket does not?
Idowu: "Fresh kale at a price they can afford, yes. But also somewhere to go on a Tuesday evening. Eighty families have a plot. Last summer a boy of nine pulled a carrot out of the ground and said, 'It's real!' as if I had performed magic. The nearest big shop is two and a half kilometres away, and you need a bus ticket and two hands free. People ask me whether our garden is 'efficient'. I ask them: efficient at what? Our plots are small, and some years the slugs win. But nobody in Northfield has ever been grown a bar of chocolate by a spreadsheet."

Source E: Policy statement (Calder Vale City Food Strategy)
1. By 2035, at least 20% of the city's fresh vegetables must be grown within 50 km of Calder Vale. The average resident eats 80 kg of fresh vegetables per year.
2. An Urban Growing Fund of GBP 2.0 million is available. Priority goes to wards where fewer than 30% of adults eat five portions of fruit and vegetables per day.
3. Public-building rooftops may be used for growing, and each project must publish its water and energy use every year.

Source F: Infographic described in words (Calder Vale Public Health Unit survey, 1 500 adults in each ward)
Title: "Who eats their five a day?" The graphic shows three horizontal bars, one for each ward, with a small shop icon at a distance from the bar's left end.
Ward: Northfield, Eastgate, Hillcrest
Adults eating five portions of fruit and vegetables per day (%): 21, 38, 59
Distance to nearest supermarket (km): 2.4, 1.1, 0.6
Median household income (GBP per year): 19 500, 27 000, 41 000

(a) Calculate the yearly profit of GreenDeck Ltd in Source C. (2 marks)
(b) Calculate the payback period for the start-up cost, in years to one decimal place. (2 marks)
(c) Calculate by what percentage GreenDeck's selling price is higher than the price of the imported equivalent. (2 marks)
(d) Use Source E to calculate the mass of vegetables that must be grown locally to meet the 20% target, and the number of farms of GreenDeck's size needed to produce it. (3 marks)
(e) Suggest two ways in which GreenDeck could make the business more attractive to investors, using evidence from Source C. (2 marks)

Total for Question 3: 11 marks$mq$, $mq$(a) [1] Revenue = 70 000 x 3.60 = GBP 252 000 [1] Profit = 252 000 - 210 000 = GBP 42 000
(b) [1] 480 000 / 42 000 [1] 11.4 years
(c) [1] 3.60 - 2.80 = 0.80 per kg and 0.80 / 2.80 [1] 28.6% (accept 29%)
(d) [1] 540 000 x 80 = 43 200 000 kg per year, and 20% of this is 8 640 000 kg [1] 8 640 000 / 70 000 = 123.4 [1] 124 farms (rounded up to a whole farm)
(e) [1] A valid method with a link to the figures, for example reduce running costs to shorten the 11.4-year payback, or apply for the Urban Growing Fund (Source E) to cover start-up cost [1] A second different valid method, for example raise yield, sell to restaurants at a higher price, or highlight the freshness of local food. Accept any two reasoned suggestions.$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 10 | C 2]]
Task 4: Evaluating sources and communicating findings

THEME: Calder Vale - feeding a growing city
Calder Vale is a fictional city of 540 000 people. Its food council is deciding how to make the city's fresh food supply more secure, healthier and more sustainable. Read Sources A to F, which come from different fields of study, and use them to answer the tasks.

Source A: Food supply record (Calder Vale Food Council data table)
Year: 2000, 2010, 2020
City population (thousands): 410, 468, 540
Share of fresh vegetables imported from other countries (%): 62, 71, 78
Average distance that fresh vegetables travel to reach the city (km): 1100, 1450, 1900

Source B: Research note (Verdant Systems Ltd, a company that builds and sells vertical farms), "Growing lettuce: field or tower?"
"Plants make their own food by photosynthesis. Chlorophyll absorbs mainly red and blue light and reflects green light, which is why leaves look green. Our vertical farm grows lettuce without soil (hydroponics): the roots sit in water containing dissolved mineral ions, and LED lamps give red and blue light to the leaves in 12 stacked layers.
Field lettuce: yield 3.5 kg per square metre of land per year; water use 250 litres per kg.
Vertical farm: yield 60 kg per square metre of floor area per year; water use 20 litres per kg; electricity use 25 kWh per kg.
Grid electricity releases 0.2 kg of carbon dioxide per kWh. Road transport of food releases 0.0001 kg of carbon dioxide for every kg carried for every km travelled.
Plan: the city grows 120 000 kg of lettuce a year (the amount currently imported over 1900 km)."

Source C: Business plan (GreenDeck Ltd, a rooftop farm start-up; independent accountant's summary)
Start-up cost: GBP 480 000. Running cost: GBP 210 000 per year. Output: 70 000 kg of lettuce and herbs per year. Selling price: GBP 3.60 per kg. Price of imported equivalent in shops: GBP 2.80 per kg. Note: the accountant has assumed that every kilogram produced is sold, and that running costs stay constant.

Source D: Interview extract ("Calder Vale Voices" podcast), Tomas Idowu, coordinator of the Northfield Community Garden
Host: What does the garden give people that a supermarket does not?
Idowu: "Fresh kale at a price they can afford, yes. But also somewhere to go on a Tuesday evening. Eighty families have a plot. Last summer a boy of nine pulled a carrot out of the ground and said, 'It's real!' as if I had performed magic. The nearest big shop is two and a half kilometres away, and you need a bus ticket and two hands free. People ask me whether our garden is 'efficient'. I ask them: efficient at what? Our plots are small, and some years the slugs win. But nobody in Northfield has ever been grown a bar of chocolate by a spreadsheet."

Source E: Policy statement (Calder Vale City Food Strategy)
1. By 2035, at least 20% of the city's fresh vegetables must be grown within 50 km of Calder Vale. The average resident eats 80 kg of fresh vegetables per year.
2. An Urban Growing Fund of GBP 2.0 million is available. Priority goes to wards where fewer than 30% of adults eat five portions of fruit and vegetables per day.
3. Public-building rooftops may be used for growing, and each project must publish its water and energy use every year.

Source F: Infographic described in words (Calder Vale Public Health Unit survey, 1 500 adults in each ward)
Title: "Who eats their five a day?" The graphic shows three horizontal bars, one for each ward, with a small shop icon at a distance from the bar's left end.
Ward: Northfield, Eastgate, Hillcrest
Adults eating five portions of fruit and vegetables per day (%): 21, 38, 59
Distance to nearest supermarket (km): 2.4, 1.1, 0.6
Median household income (GBP per year): 19 500, 27 000, 41 000

(a) Using the origin, purpose, value and limitation of Source E, assess how useful it is for deciding what the city should do. (4 marks)
(b) Compare what Source D and Source F suggest about the connection between food and where people live. (3 marks)
(c) Evaluate the limitations of Source B as evidence that vertical farms are the best way to supply the city. (3 marks)
(d) Write a headline and a summary of no more than 30 words for a school newsletter that accurately describes the trend in Source A. (2 marks)

Total for Question 4: 12 marks$mq$, $mq$(a) [1] Origin: the city's own policy document, so it has legal and political authority [1] Purpose: to set targets and direct public money, not to describe the full evidence [1] Value: gives the target (20% by 2035), the funding available (GBP 2.0 million) and a rule that data must be published [1] Limitation: gives no evidence for how the target will be reached or why 20%; it does not say who pays for projects over GBP 2.0 million
(b) [1] Source D: the nearest big shop is 2.5 km away, and the garden gives affordable fresh food and community in Northfield [1] Source F: Northfield has the greatest distance (2.4 km) and the lowest percentage eating five a day (21%) [1] Link: both point to access and income, not choice, as reasons for poorer diet in Northfield. Award this mark for a clear comparison supported by evidence from both.
(c) [1] Origin and purpose: published by a company that sells vertical farms, so it has a reason to present them well [1] The note ignores costs such as buying and running the farm, and the high electricity use (25 kWh per kg) is stated but not discussed [1] Only lettuce is considered, so it does not show whether other vegetables could be grown in the same way. Accept other valid limitations.
(d) [1] Clear headline and summary of no more than 30 words, in language suitable for students, giving an accurate trend (imports 62% to 78%, distance 1100 km to 1900 km) [1] Numbers from Source A used correctly and the word limit respected$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | A 2 | B 6 | C 2]]
Task 5: Interpreting ward data and making a case

THEME: Calder Vale - feeding a growing city
Calder Vale is a fictional city of 540 000 people. Its food council is deciding how to make the city's fresh food supply more secure, healthier and more sustainable. Read Sources A to F, which come from different fields of study, and use them to answer the tasks.

Source A: Food supply record (Calder Vale Food Council data table)
Year: 2000, 2010, 2020
City population (thousands): 410, 468, 540
Share of fresh vegetables imported from other countries (%): 62, 71, 78
Average distance that fresh vegetables travel to reach the city (km): 1100, 1450, 1900

Source B: Research note (Verdant Systems Ltd, a company that builds and sells vertical farms), "Growing lettuce: field or tower?"
"Plants make their own food by photosynthesis. Chlorophyll absorbs mainly red and blue light and reflects green light, which is why leaves look green. Our vertical farm grows lettuce without soil (hydroponics): the roots sit in water containing dissolved mineral ions, and LED lamps give red and blue light to the leaves in 12 stacked layers.
Field lettuce: yield 3.5 kg per square metre of land per year; water use 250 litres per kg.
Vertical farm: yield 60 kg per square metre of floor area per year; water use 20 litres per kg; electricity use 25 kWh per kg.
Grid electricity releases 0.2 kg of carbon dioxide per kWh. Road transport of food releases 0.0001 kg of carbon dioxide for every kg carried for every km travelled.
Plan: the city grows 120 000 kg of lettuce a year (the amount currently imported over 1900 km)."

Source C: Business plan (GreenDeck Ltd, a rooftop farm start-up; independent accountant's summary)
Start-up cost: GBP 480 000. Running cost: GBP 210 000 per year. Output: 70 000 kg of lettuce and herbs per year. Selling price: GBP 3.60 per kg. Price of imported equivalent in shops: GBP 2.80 per kg. Note: the accountant has assumed that every kilogram produced is sold, and that running costs stay constant.

Source D: Interview extract ("Calder Vale Voices" podcast), Tomas Idowu, coordinator of the Northfield Community Garden
Host: What does the garden give people that a supermarket does not?
Idowu: "Fresh kale at a price they can afford, yes. But also somewhere to go on a Tuesday evening. Eighty families have a plot. Last summer a boy of nine pulled a carrot out of the ground and said, 'It's real!' as if I had performed magic. The nearest big shop is two and a half kilometres away, and you need a bus ticket and two hands free. People ask me whether our garden is 'efficient'. I ask them: efficient at what? Our plots are small, and some years the slugs win. But nobody in Northfield has ever been grown a bar of chocolate by a spreadsheet."

Source E: Policy statement (Calder Vale City Food Strategy)
1. By 2035, at least 20% of the city's fresh vegetables must be grown within 50 km of Calder Vale. The average resident eats 80 kg of fresh vegetables per year.
2. An Urban Growing Fund of GBP 2.0 million is available. Priority goes to wards where fewer than 30% of adults eat five portions of fruit and vegetables per day.
3. Public-building rooftops may be used for growing, and each project must publish its water and energy use every year.

Source F: Infographic described in words (Calder Vale Public Health Unit survey, 1 500 adults in each ward)
Title: "Who eats their five a day?" The graphic shows three horizontal bars, one for each ward, with a small shop icon at a distance from the bar's left end.
Ward: Northfield, Eastgate, Hillcrest
Adults eating five portions of fruit and vegetables per day (%): 21, 38, 59
Distance to nearest supermarket (km): 2.4, 1.1, 0.6
Median household income (GBP per year): 19 500, 27 000, 41 000

(a) Using Source F, calculate the difference in percentage points between Hillcrest and Northfield, and the number of times greater the Hillcrest percentage is. (2 marks)
(b) Describe the relationship between distance to the nearest supermarket and the percentage of adults eating five a day. (2 marks)
(c) Explain why the data in Source F do not prove that distance to a shop causes a lower fruit and vegetable intake. (2 marks)
(d) Suggest how a community garden in Northfield could affect the figures in Source F, and name the fields of study that would help to measure the effect. (2 marks)
(e) Describe the type of chart you would use to show the three wards' results to the food council, and justify your choice. (2 marks)

Total for Question 5: 10 marks$mq$, $mq$(a) [1] 59 - 21 = 38 percentage points [1] 59 / 21 = 2.8 times (accept 2.81)
(b) [1] As distance increases, the percentage eating five a day decreases (negative relationship) [1] Supported with data, for example 0.6 km gives 59% and 2.4 km gives 21%
(c) [1] A correlation does not prove causation; only three wards are compared [1] Another variable, such as income (19 500 to 41 000), also changes with distance, and may explain the difference
(d) [1] Gives fresh produce locally at a lower cost, so the percentage eating five a day may rise (the garden is in the priority ward in Source E) [1] Names two suitable fields, for example health and physical education (diet survey), mathematics (statistics), economics (cost), or biology (nutrition)
(e) [1] A suitable chart (for example a bar chart of the percentages by ward, or a scatter graph of distance against percentage) with clear labelled axes and units [1] Justification, for example it allows easy comparison of categories, or shows the pattern between two variables$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | B 8 | C 6]]
Task 6: Synthesis - plan for the Food Council

THEME: Calder Vale - feeding a growing city
Calder Vale is a fictional city of 540 000 people. Its food council is deciding how to make the city's fresh food supply more secure, healthier and more sustainable. Read Sources A to F, which come from different fields of study, and use them to answer the tasks.

Source A: Food supply record (Calder Vale Food Council data table)
Year: 2000, 2010, 2020
City population (thousands): 410, 468, 540
Share of fresh vegetables imported from other countries (%): 62, 71, 78
Average distance that fresh vegetables travel to reach the city (km): 1100, 1450, 1900

Source B: Research note (Verdant Systems Ltd, a company that builds and sells vertical farms), "Growing lettuce: field or tower?"
"Plants make their own food by photosynthesis. Chlorophyll absorbs mainly red and blue light and reflects green light, which is why leaves look green. Our vertical farm grows lettuce without soil (hydroponics): the roots sit in water containing dissolved mineral ions, and LED lamps give red and blue light to the leaves in 12 stacked layers.
Field lettuce: yield 3.5 kg per square metre of land per year; water use 250 litres per kg.
Vertical farm: yield 60 kg per square metre of floor area per year; water use 20 litres per kg; electricity use 25 kWh per kg.
Grid electricity releases 0.2 kg of carbon dioxide per kWh. Road transport of food releases 0.0001 kg of carbon dioxide for every kg carried for every km travelled.
Plan: the city grows 120 000 kg of lettuce a year (the amount currently imported over 1900 km)."

Source C: Business plan (GreenDeck Ltd, a rooftop farm start-up; independent accountant's summary)
Start-up cost: GBP 480 000. Running cost: GBP 210 000 per year. Output: 70 000 kg of lettuce and herbs per year. Selling price: GBP 3.60 per kg. Price of imported equivalent in shops: GBP 2.80 per kg. Note: the accountant has assumed that every kilogram produced is sold, and that running costs stay constant.

Source D: Interview extract ("Calder Vale Voices" podcast), Tomas Idowu, coordinator of the Northfield Community Garden
Host: What does the garden give people that a supermarket does not?
Idowu: "Fresh kale at a price they can afford, yes. But also somewhere to go on a Tuesday evening. Eighty families have a plot. Last summer a boy of nine pulled a carrot out of the ground and said, 'It's real!' as if I had performed magic. The nearest big shop is two and a half kilometres away, and you need a bus ticket and two hands free. People ask me whether our garden is 'efficient'. I ask them: efficient at what? Our plots are small, and some years the slugs win. But nobody in Northfield has ever been grown a bar of chocolate by a spreadsheet."

Source E: Policy statement (Calder Vale City Food Strategy)
1. By 2035, at least 20% of the city's fresh vegetables must be grown within 50 km of Calder Vale. The average resident eats 80 kg of fresh vegetables per year.
2. An Urban Growing Fund of GBP 2.0 million is available. Priority goes to wards where fewer than 30% of adults eat five portions of fruit and vegetables per day.
3. Public-building rooftops may be used for growing, and each project must publish its water and energy use every year.

Source F: Infographic described in words (Calder Vale Public Health Unit survey, 1 500 adults in each ward)
Title: "Who eats their five a day?" The graphic shows three horizontal bars, one for each ward, with a small shop icon at a distance from the bar's left end.
Ward: Northfield, Eastgate, Hillcrest
Adults eating five portions of fruit and vegetables per day (%): 21, 38, 59
Distance to nearest supermarket (km): 2.4, 1.1, 0.6
Median household income (GBP per year): 19 500, 27 000, 41 000

The Calder Vale Food Council meets next month to decide how to spend the Urban Growing Fund and what combination of approaches (vertical farms, rooftop farms, community gardens, changes to imports) to support. You are an adviser. Write a briefing note of 250 to 350 words that makes a plan and justifies it. Use evidence from at least four of Sources A to F, draw on at least three different fields of study, explain how the fields are connected, and state one limitation of your plan. Refer to sources by letter (for example, 'Source C').

(a) Synthesise ideas from the sources into a justified plan (criterion B: synthesizing). (8 marks)
(b) Communicate the plan clearly to the Food Council (criterion C: communicating). (6 marks)

Total for Question 6: 14 marks$mq$, $mq$(a) Award up to 8 marks for synthesis; use the indicative content, then confirm with the descriptors. [1] A clear, firm plan stating which approaches to support and how funds are used (GBP 2.0 million in Source E) [1] Uses data on supply: 78% imported, 1900 km, a 72.7% rise in distance (Source A) [1] Uses science: water saving of 92%, land use of 2 000 m2 against 34 286 m2, or the electricity and carbon trade-off (600 000 kg against 22 800 kg; Source B) [1] Uses economics: payback of 11.4 years, price 28.6% above imports, 124 farms needed (Sources C and E) [1] Uses social and health evidence: Northfield 21% and 2.4 km, and community value (Sources D and F) [1] Explains a connection between at least two fields so that the combined view gives an answer that neither field gives alone (for example a farm powered by renewable electricity combining science, economics and health) [1] Handles a trade-off (for example low water use against high electricity use, or cost against fairness) [1] Shows awareness of source reliability (for example the seller in Source B). Level descriptors for B: 1-2 marks, sources listed or described separately with little connection; 3-4 marks, some connections between two fields with a partly justified plan; 5-6 marks, clear integration of at least three fields and a justified plan; 7-8 marks, fully integrated insight that resolves trade-offs, evaluates evidence and meets the aims of the Strategy.
(b) Award up to 6 marks for communication. [1] Organised structure with a clear opening decision, reasons and a conclusion [1] Tone and register suitable for a council briefing note [1] Accurate use of subject vocabulary (for example hydroponics, photosynthesis, payback period, food miles) [1] Sources acknowledged by letter and numbers quoted correctly [1] Sentences clear and accurate, with logical paragraphs and links [1] Stays within 250 to 350 words. Level descriptors for C: 1-2 marks, ideas hard to follow or poorly organised; 3-4 marks, mostly clear and organised with some referencing; 5-6 marks, clear, concise and convincing writing for the audience with consistent referencing.$mq$, $mq$B$mq$),
(7, $mq$[[Q 7 | C 2 | D 10]]
Task 7: Reflecting on the process

THEME: Calder Vale - feeding a growing city
Calder Vale is a fictional city of 540 000 people. Its food council is deciding how to make the city's fresh food supply more secure, healthier and more sustainable. Read Sources A to F, which come from different fields of study, and use them to answer the tasks.

Source A: Food supply record (Calder Vale Food Council data table)
Year: 2000, 2010, 2020
City population (thousands): 410, 468, 540
Share of fresh vegetables imported from other countries (%): 62, 71, 78
Average distance that fresh vegetables travel to reach the city (km): 1100, 1450, 1900

Source B: Research note (Verdant Systems Ltd, a company that builds and sells vertical farms), "Growing lettuce: field or tower?"
"Plants make their own food by photosynthesis. Chlorophyll absorbs mainly red and blue light and reflects green light, which is why leaves look green. Our vertical farm grows lettuce without soil (hydroponics): the roots sit in water containing dissolved mineral ions, and LED lamps give red and blue light to the leaves in 12 stacked layers.
Field lettuce: yield 3.5 kg per square metre of land per year; water use 250 litres per kg.
Vertical farm: yield 60 kg per square metre of floor area per year; water use 20 litres per kg; electricity use 25 kWh per kg.
Grid electricity releases 0.2 kg of carbon dioxide per kWh. Road transport of food releases 0.0001 kg of carbon dioxide for every kg carried for every km travelled.
Plan: the city grows 120 000 kg of lettuce a year (the amount currently imported over 1900 km)."

Source C: Business plan (GreenDeck Ltd, a rooftop farm start-up; independent accountant's summary)
Start-up cost: GBP 480 000. Running cost: GBP 210 000 per year. Output: 70 000 kg of lettuce and herbs per year. Selling price: GBP 3.60 per kg. Price of imported equivalent in shops: GBP 2.80 per kg. Note: the accountant has assumed that every kilogram produced is sold, and that running costs stay constant.

Source D: Interview extract ("Calder Vale Voices" podcast), Tomas Idowu, coordinator of the Northfield Community Garden
Host: What does the garden give people that a supermarket does not?
Idowu: "Fresh kale at a price they can afford, yes. But also somewhere to go on a Tuesday evening. Eighty families have a plot. Last summer a boy of nine pulled a carrot out of the ground and said, 'It's real!' as if I had performed magic. The nearest big shop is two and a half kilometres away, and you need a bus ticket and two hands free. People ask me whether our garden is 'efficient'. I ask them: efficient at what? Our plots are small, and some years the slugs win. But nobody in Northfield has ever been grown a bar of chocolate by a spreadsheet."

Source E: Policy statement (Calder Vale City Food Strategy)
1. By 2035, at least 20% of the city's fresh vegetables must be grown within 50 km of Calder Vale. The average resident eats 80 kg of fresh vegetables per year.
2. An Urban Growing Fund of GBP 2.0 million is available. Priority goes to wards where fewer than 30% of adults eat five portions of fruit and vegetables per day.
3. Public-building rooftops may be used for growing, and each project must publish its water and energy use every year.

Source F: Infographic described in words (Calder Vale Public Health Unit survey, 1 500 adults in each ward)
Title: "Who eats their five a day?" The graphic shows three horizontal bars, one for each ward, with a small shop icon at a distance from the bar's left end.
Ward: Northfield, Eastgate, Hillcrest
Adults eating five portions of fruit and vegetables per day (%): 21, 38, 59
Distance to nearest supermarket (km): 2.4, 1.1, 0.6
Median household income (GBP per year): 19 500, 27 000, 41 000

(a) Describe one insight you gained by combining two fields of study that you could not have reached using one field alone. (3 marks)
(b) Explain one limitation or possible bias in the evidence you used, and how it could affect your plan. (3 marks)
(c) Evaluate how your plan might need to change if electricity costs doubled. (2 marks)
(d) Reflect on one strategy that helped you to connect the sources and one thing you would do differently next time. (2 marks)
(e) Write a message of no more than 50 words for residents of Northfield explaining, in plain language, what your plan means for them. (2 marks)

Total for Question 7: 12 marks$mq$, $mq$(a) [1] Identifies two fields clearly [1] States a specific insight, for example the vertical farm saves water and land (science) but is only low-carbon if the electricity is low-carbon (science and economics of energy), so a simple 'greener' label is misleading [1] Explains why one field alone would be insufficient
(b) [1] Identifies a specific limitation or bias (for example the seller in Source B; one coordinator in Source D; three wards in Source F) [1] Explains how it could distort the plan [1] Gives a way to reduce the problem (for example independent data, or interviewing more residents)
(c) [1] Identifies a change, for example vertical farms become less viable, so the plan would favour rooftop farms and community gardens [1] Evaluates the effect on cost, price or carbon with a reason
(d) [1] A specific strategy (for example making a table of fields and sources, or comparing numbers) with why it helped [1] A realistic improvement for next time, linked to the process
(e) [1] Plain, polite language suitable for residents, within 50 words [1] Accurately explains the effect of the plan on Northfield, consistent with the plan in Task 6$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);
commit;
