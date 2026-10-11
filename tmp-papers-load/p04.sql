begin;
-- Economics MYP 5 eAssessment Paper B (7 tasks, 67 marks) (67 marks)
with sub as (select id from public.subjects where slug = $mq$economics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Economics MYP 5 eAssessment Paper B (7 tasks, 67 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Economics MYP 5 eAssessment Paper B (7 tasks, 67 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: Public goods and private goods.

Source A: four goods or services (compiled for this paper)
1. Street lighting on a public road.
2. A cinema ticket.
3. A lighthouse that warns ships of rocks.
4. A cone of ice cream from a street seller.

(a) Explain what is meant by a public good, using the terms non-excludable and non-rivalrous. (2 marks)

(b) Identify which two goods in Source A are public goods. (2 marks)

(c) Explain the free rider problem, using the lighthouse as an example. (2 marks)

(d) Explain why governments often provide public goods and pay for them through taxation. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] Non-excludable: nobody can be prevented from using it, even if they do not pay. [1] Non-rivalrous: one person using it does not reduce how much is available to others.
(b) [1] Street lighting. [1] Lighthouse.
(c) [1] A free rider benefits from a good without paying for it, since ships cannot be stopped from using the light. [1] Because people can avoid paying, private firms have no incentive to provide the good, so it may not be provided at all.
(d) [1] The market under-provides public goods because they cannot be sold profitably. [1] Taxation makes everyone who benefits contribute, which overcomes the free rider problem.$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 4 | B 5]]
Task 2: Price elasticity of supply.

Source B: the effect of a 10 percent rise in price on the quantity supplied (figures created for this paper)
Good: change in quantity supplied within one month; within one year
Strawberries: +2%; +18%
Bicycles: +12%; +30%

Price elasticity of supply (PES) = percentage change in quantity supplied divided by percentage change in price.

(a) Calculate the PES of strawberries within one month and within one year. (2 marks)

(b) State which of the four PES values in Source B shows that supply is inelastic, and explain how you know. (2 marks)

(c) Explain why the supply of strawberries is inelastic in the short run. (2 marks)

(d) In the short run, the price of bicycles rises by 20 percent. Calculate the percentage change in the quantity supplied. (1 mark)

(e) Explain one limitation of using the figures in Source B to predict next year's output. (2 marks)

Total for Question 2: 9 marks$mq$, $mq$(a) [1] One month: 2 / 10 = 0.2. [1] One year: 18 / 10 = 1.8.
(b) [1] 0.2 (strawberries within one month). [1] It is less than 1, so quantity supplied changes by a smaller percentage than price.
(c) [1] Strawberries take time to grow, so farmers cannot quickly increase output. [1] They are perishable, so stocks cannot be stored to supply more, and land and workers are fixed in the short run.
(d) [1] 1.2 x 20 = 24% (increase).
(e) [1] PES values are based on past data and one market. [1] Other factors, such as weather, costs or technology, could change and are assumed constant.$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | B 8 | D 3]]
Task 3: Wages in a factory.

Background: The invented company StitchCo makes clothes in the country of Dala. The sources were created for this paper.

Source C: an extract from a StitchCo advertisement (imagined, 2023)
"At StitchCo we are proud to give thousands of families a steady job. Our factories offer training, a hot meal and wages above the national minimum. Every garment carries the promise of fair work."

Source D: an extract from a report by a campaigning organisation (imagined, 2023)
"We interviewed 200 StitchCo workers. The average wage is 2.40 dollars an hour, while the living wage in Dala is estimated at 3.50 dollars an hour. Many work overtime to make ends meet, and 60 percent said they could not afford a doctor."

(a) Identify the origin and the purpose of Source C. (2 marks)

(b) Explain one way in which Source D is valuable for an economist studying wages in the clothing industry. (2 marks)

(c) Explain one limitation of Source D. (2 marks)

(d) Calculate the average StitchCo wage as a percentage of the living wage. Give your answer to one decimal place. (2 marks)

(e) Compare the claims of Source C and Source D about StitchCo's wages. Use the origin of each source to explain why they differ. (3 marks)

Total for Question 3: 11 marks$mq$, $mq$(a) [1] Origin: an advertisement published by the company StitchCo in 2023. [1] Purpose: to promote the company's image and attract customers by presenting itself as a fair employer.
(b) [1] It gives specific data (a wage of 2.40 dollars compared with a living wage of 3.50), which can be compared with other evidence. [1] It is based on interviews with workers, who have first-hand knowledge, and the sample size (200) is given.
(c) [1] The organisation campaigns for better wages, so it may select or stress evidence that supports its cause. [1] The sample of 200 may not represent all StitchCo workers, and the living wage is an estimate.
(d) [1] Method: 2.40 / 3.50 x 100. [1] 68.6%
(e) [1] Source C claims wages above the national minimum and fair work, while Source D claims wages well below a living wage. [1] The two sources need not contradict each other: wages can be above the legal minimum but still below a living wage. [1] The company wants a good reputation while the campaign group wants change, which explains why they stress different facts.$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 10]]
Task 4: Planning an investigation: a bottle deposit scheme.

A school introduced a deposit scheme in which students receive 10 cents for each plastic bottle returned to a collection point. A student plans to investigate whether the scheme increased recycling.

Source E: plastic bottles collected per week at the school (invented data)
Before the scheme (weeks 1 to 4): 120, 130, 110, 140
After the scheme (weeks 5 to 8): 200, 210, 190, 220

(a) Write a hypothesis for the investigation and state the independent and dependent variables. (2 marks)

(b) Describe how the student could collect data to find out whether the scheme worked. (3 marks)

(c) Calculate the mean number of bottles collected per week before and after the scheme. (2 marks)

(d) Calculate the percentage increase in the mean number of bottles collected. (1 mark)

(e) Explain two reasons why the student should be cautious about concluding that the deposit scheme caused the whole increase. (2 marks)

Total for Question 4: 10 marks$mq$, $mq$(a) [1] A testable hypothesis (e.g. The deposit scheme will increase the number of bottles returned each week). [1] Independent variable: the deposit scheme (before or after). Dependent variable: number of bottles collected.
(b) [1] Count bottles at the same collection point each week using a tally sheet or a weighing scale. [1] Collect data for the same number of weeks before and after to allow a fair comparison. [1] Keep other conditions the same where possible, e.g. count at the same time each week.
(c) [1] Before: 500 / 4 = 125. [1] After: 820 / 4 = 205.
(d) [1] (205 - 125) / 125 x 100 = 64%.
(e) [1] Other factors could have changed, e.g. a school event, hotter weather increasing drinks sales, or a campaign on recycling. [1] The sample is only four weeks in each period, so the result might be due to chance.$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | A 2 | C 6]]
Task 5: Exchange rates and exporters.

The currency of the invented country of Brollin is the brol. Brollin exports cars to the United States, where prices are in dollars.

Source F: exchange rates
Last year: 1 brol = 0.40 dollars
This year: 1 brol = 0.50 dollars
A car is priced at 20,000 brol.

(a) Calculate the percentage increase in the dollar price of the car in the United States. (2 marks)

(b) Write an email of about 120 words to a Brollin car exporter explaining what the change in the exchange rate means for the business and what it could do in response. Marks are given for your economic knowledge and for how clearly and appropriately you communicate to a business person. (6 marks)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] Last year 20,000 x 0.40 = 8,000 dollars; this year 20,000 x 0.50 = 10,000 dollars. [1] (10,000 - 8,000) / 8,000 x 100 = 25%.
(b) [1] Explains that the brol has appreciated (become stronger), so one brol buys more dollars. [1] Explains that the car costs 25 percent more for buyers in the United States if the price in brol stays the same. [1] Explains the likely effect on sales, i.e. demand falls and the exporter may lose sales to rivals. [1] Suggests a response, e.g. cut costs, accept lower brol prices, look for new markets, or use imported inputs that are cheaper. [1] Communication: a suitable email format (greeting, clear opening and closing) and a professional tone. [1] Communication: logical order and accurate terms (e.g. appreciation, exchange rate, exports, competitiveness).$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | D 9]]
Task 6: Income inequality in Sorrel.

Sorrel is an invented country. The figures were created for this paper.

Source G: share of total national income received by each fifth of households
Poorest fifth: 5%
Second fifth: 9%
Middle fifth: 14%
Fourth fifth: 22%
Richest fifth: 50%

Source H: a statement by the finance minister (imagined)
"Our economy is growing fast. Growth makes the cake bigger and everyone will receive a larger slice. We should keep taxes low and let businesses create jobs."

Source I: a statement by a trade union leader (imagined)
"Growth has brought wealth to the richest households, while workers' wages have barely moved. The government should tax high incomes more and invest in schools and healthcare for poor families."

(a) How many times larger is the share of national income received by the richest fifth than by the poorest fifth? (1 mark)

(b) Describe the distribution of income shown in Source G. (2 marks)

(c) Explain two ways in which a government could reduce income inequality. (2 marks)

(d) Evaluate the view in Source H that economic growth alone will solve poverty. Use Source G and Source I. (4 marks)

Total for Question 6: 9 marks$mq$, $mq$(a) [1] 50 / 5 = 10 times.
(b) [1] Income is unequally shared: the richest fifth receives half of all income. [1] The poorest two fifths together receive only 14 percent (5 + 9).
(c) [1] A policy named (e.g. progressive income taxes) with an explanation of how it works. [1] A second policy named (e.g. spending on education and healthcare, welfare payments, or a minimum wage) with an explanation.
(d) [1] Source H's logic: growth can create jobs and raise incomes. [1] Source G shows that the benefits are unevenly shared, and Source I says wages barely moved, so growth alone has not helped the poorest. [1] Both are statements by people with interests (a government minister defending policy and a union leader representing workers). [1] A reasoned judgement.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | C 2 | D 10]]
Task 7: Unemployment and inflation: extended response.

Statement: Reducing unemployment should be a more important goal for governments than keeping inflation low.

Evaluate this statement. Use specific examples that you have studied. You should:
- explain the costs of unemployment,
- explain the costs of inflation,
- reach a supported judgement about which should be the greater priority.

(a) Evaluate the statement. Your answer will be marked for your knowledge and evaluation (10 marks) and for the quality of your communication (2 marks). (12 marks)

Total for Question 7: 12 marks$mq$, $mq$(a) [1] Defines or explains unemployment accurately (people able and willing to work but without a job). [1] Explains the costs of unemployment to individuals (lost income, poorer health, loss of skills). [1] Explains the costs to the economy and government (lost output, lower tax revenue, higher welfare spending). [1] Explains types of unemployment, e.g. cyclical, structural or frictional, and how this changes the policy needed. [1] Defines or explains inflation accurately (a sustained rise in the general price level). [1] Explains the costs of inflation (falling real incomes, damage to savings, uncertainty for firms, loss of competitiveness). [1] Explains possible policy responses, e.g. higher interest rates to reduce inflation, or government spending and tax cuts to reduce unemployment. [1] Considers conflicts between the goals (e.g. higher interest rates to reduce inflation may increase unemployment). [1] Considers the size of the problem (e.g. hyperinflation compared with moderate inflation; short-term compared with long-term unemployment). [1] A clear judgement about which should have priority. [1] The judgement is supported by reasoning that weighs both costs. [1] Communication: a clear introduction, structured paragraphs and a conclusion, with accurate economic vocabulary.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Economics MYP 5 eAssessment Paper C (7 tasks, 62 marks) (62 marks)
with sub as (select id from public.subjects where slug = $mq$economics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Economics MYP 5 eAssessment Paper C (7 tasks, 62 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Economics MYP 5 eAssessment Paper C (7 tasks, 62 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 7]]
Task 1: Costs, revenue and profit.

Juniper Print Shop is an invented business that prints posters.

Source A: information about the business
Selling price: 5 dollars per poster.
Fixed costs: 200 dollars per month.
Variable costs: 2 dollars per poster.

(a) Calculate the total revenue from selling 100 posters. (1 mark)

(b) Calculate the total cost and the profit from producing and selling 100 posters. (2 marks)

(c) Calculate the break-even number of posters. Give your answer to the nearest whole poster. (2 marks)

(d) Explain two ways Juniper Print Shop could increase its profit. (2 marks)

Total for Question 1: 7 marks$mq$, $mq$(a) [1] 100 x 5 = 500 dollars.
(b) [1] Total cost = 200 + (100 x 2) = 400 dollars. [1] Profit = 500 - 400 = 100 dollars.
(c) [1] Method: 200 / (5 - 2) (fixed cost divided by the contribution per poster). [1] 67 posters (66.7 rounded up).
(d) [1] A valid way (e.g. raise the price or cut variable costs) with an explanation of the effect on profit. [1] A second valid way with an explanation, and a comment on a risk (e.g. a higher price may reduce the quantity demanded).$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 4 | B 6]]
Task 2: Economic growth in Orsholm.

Orsholm is an invented country. The figures were created for this paper.

Source B: GDP and population of Orsholm
Year: 2018, 2019, 2020, 2021
GDP (billions of dollars): 200, 210, 199.5, 215.5
Population (millions): 10, 10.1, 10.2, 10.3

(a) Calculate the percentage change in GDP between 2019 and 2020. (2 marks)

(b) Calculate GDP per person in 2021 to the nearest dollar. (2 marks)

(c) Describe the pattern of economic growth in Orsholm between 2018 and 2021. (2 marks)

(d) Explain one likely effect on employment of the fall in GDP in 2020. (2 marks)

(e) Explain one reason why GDP per person is a limited measure of people's standard of living. (2 marks)

Total for Question 2: 10 marks$mq$, $mq$(a) [1] Method: (199.5 - 210) / 210 x 100. [1] -5% (a fall of 5%).
(b) [1] 215.5 billion / 10.3 million = 215,500 million / 10.3 million. [1] About 20,922 dollars per person (accept 20,900).
(c) [1] Growth in 2019 (5%), then a fall in 2020 (-5%). [1] A strong recovery in 2021 (about 8%), taking GDP above its 2019 level.
(d) [1] Firms sell less, so they reduce output and cut workers or hours. [1] Unemployment is likely to rise.
(e) [1] It is an average and does not show how income is shared (inequality). [1] It ignores factors such as health, education, leisure time and environmental damage.$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | B 8 | D 2]]
Task 3: Competition in the water market.

Two invented towns buy water from different types of supplier. Sources C and D were created for this paper.

Source C: an extract from a statement by Hallam Water (imagined, 2023)
"Hallam Water is the only supplier in Hallam. Our prices reflect the cost of maintaining thousands of kilometres of pipes. We invest every year to keep your water clean and safe, and we do so at a fair price."

Source D: an extract from a report by a regulator (imagined, 2023)
"Price per 1,000 litres of water: Hallam (one supplier) 4.80 dollars; Brinton (three competing suppliers) 3.60 dollars. Complaints about service per 1,000 customers were higher in Hallam than in Brinton. The regulator urges Hallam Water to explain its prices."

(a) Identify the origin and purpose of Source C. (2 marks)

(b) Explain one way in which Source D is valuable to an economist studying the effects of competition. (2 marks)

(c) Explain one limitation of Source D. (2 marks)

(d) Calculate how much higher the price in Hallam is than the price in Brinton, as a percentage of the price in Brinton. Give your answer to one decimal place. (2 marks)

(e) Explain why a firm that is the only supplier in a market may charge higher prices than firms in a competitive market. (2 marks)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] Origin: a statement from Hallam Water in 2023. [1] Purpose: to justify its prices and protect its reputation.
(b) [1] It compares prices in a market with one supplier and a market with three, so the effect of competition can be seen. [1] It comes from a regulator whose role is to protect consumers, and gives figures on prices and complaints.
(c) [1] It covers only two towns, so we cannot be sure that competition causes the difference. [1] Other factors (such as pipe length, geography or age of the network) could explain price differences.
(d) [1] (4.80 - 3.60) / 3.60 x 100 (method). [1] 33.3%
(e) [1] With no rivals, customers cannot switch, so demand is less elastic. [1] The monopolist has market power to raise prices and profit, while competing firms must keep prices low to keep customers.$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 8]]
Task 4: Cost-benefit analysis of a cycle lane.

The council of the invented city of Marwick is considering building a protected cycle lane. It has estimated the costs and benefits over 10 years.

Source E: estimated costs and benefits (figures created for this paper)
Construction cost (one-off, paid in year 1): 1.2 million dollars.
Maintenance cost: 0.1 million dollars per year for 10 years.
Health benefits (fewer illnesses): 0.3 million dollars per year for 10 years.
Reduced congestion (time and fuel saved): 0.2 million dollars per year for 10 years.

(a) Calculate the total cost over 10 years, in millions of dollars. (1 mark)

(b) Calculate the total benefit over 10 years, in millions of dollars. (1 mark)

(c) Calculate the net benefit of the project over 10 years. (1 mark)

(d) Calculate the benefit-cost ratio (total benefits divided by total costs). Give your answer to one decimal place. (1 mark)

(e) Explain two difficulties the council would have in estimating the benefits in money terms. (2 marks)

(f) Describe how the council could use a survey to improve its estimate of the number of people who would use the lane. (2 marks)

Total for Question 4: 8 marks$mq$, $mq$(a) [1] 1.2 + (0.1 x 10) = 2.2 million dollars.
(b) [1] (0.3 + 0.2) x 10 = 5.0 million dollars.
(c) [1] 5.0 - 2.2 = 2.8 million dollars.
(d) [1] 5.0 / 2.2 = 2.3 (2.27 rounded).
(e) [1] Benefits such as health and wellbeing have no market price, so values must be estimated. [1] The benefits happen in the future, and predictions about how many people will cycle may be wrong.
(f) [1] Ask a representative sample of residents, including commuters and those who live near the route. [1] Ask how often they would cycle and what would stop them, and use a random sample to avoid bias.$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | A 2 | C 6]]
Task 5: Development aid.

A remote village in an invented developing country has been offered one of three types of help from an international charity: (1) food aid for one year, (2) money to build a primary school and a health clinic, or (3) small loans (microloans) for villagers who want to start small businesses.

(a) Explain the difference between food aid and aid that provides money to build a school. (2 marks)

(b) Write a recommendation of about 120 words to the village council on which type of help it should accept. Marks are given for your economic knowledge and for how clearly and persuasively you communicate. (6 marks)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] Food aid is short-term emergency help that meets immediate needs. [1] Building a school is long-term development aid that increases human capital and future incomes.
(b) [1] Chooses an option with a clear reason linked to development (e.g. long-term benefits of schools and clinics). [1] Explains one benefit of the chosen option, e.g. a healthier, better-educated population raises productivity and income. [1] Explains a limitation or opportunity cost of the chosen option (e.g. buildings need teachers and running costs, and the village still needs food). [1] Considers another option and why it was not chosen, e.g. food aid does not create lasting change, or microloans could cause debt. [1] Communication: a clear, persuasive tone suited to a village council with a logical structure. [1] Communication: accurate economic vocabulary (e.g. human capital, sustainable, opportunity cost).$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | D 7]]
Task 6: A multinational in a developing country.

Source F: an extract from a statement by Alpha Mining Corporation (imagined)
"Our mine in the invented country of Tarrin employs 1,500 local people and pays them well above local wages. We pay taxes, build roads and give the government a share of our profits. Tarrin is richer because we are here."

Source G: information about the mine (figures created for this paper)
Number of workers: 1,500. Average wage: 1,200 dollars per year. Average local wage in farming: 800 dollars per year.
Annual profit of the corporation from the mine: 20 million dollars, of which 2 million dollars is paid in tax to the Tarrin government. The rest of the profit is sent to the corporation's headquarters abroad. The mine has polluted a nearby river used by farmers.

(a) Calculate the mine's total annual wage bill. (1 mark)

(b) Using Source G, explain two ways in which the mine benefits Tarrin. (2 marks)

(c) Evaluate the claim in Source F that Tarrin is richer because Alpha Mining is there. (4 marks)

Total for Question 6: 7 marks$mq$, $mq$(a) [1] 1,500 x 1,200 = 1,800,000 dollars (1.8 million).
(b) [1] Jobs paying more than the local average (1,200 against 800 dollars) raise workers' incomes. [1] The government receives 2 million dollars in tax, which it can use for services. (Accept further jobs or infrastructure.)
(c) [1] Evidence in support: higher wages and tax revenue. [1] Evidence against: most of the profit (18 million) leaves the country and the pollution harms farmers. [1] Source F is written by the company, so it stresses the benefits. [1] A balanced judgement, e.g. benefits to Tarrin are real but smaller than claimed unless the government negotiates a bigger share and enforces environmental rules.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | C 2 | D 10]]
Task 7: Trade and development: extended response.

Statement: The best way for a developing country to grow is to specialise in the goods it produces most efficiently and trade them with other countries.

Evaluate this statement. Use specific examples that you have studied, such as exports of coffee or minerals, manufacturing, tourism or education. You should:
- explain the benefits of specialisation and trade,
- explain the risks or limits of specialising,
- reach a supported judgement.

(a) Evaluate the statement. Your answer will be marked for your knowledge and evaluation (10 marks) and for the quality of your communication (2 marks). (12 marks)

Total for Question 7: 12 marks$mq$, $mq$(a) [1] Explains specialisation and comparative advantage (producing at a lower opportunity cost). [1] Explains that trade lets countries sell more and buy goods at lower prices, and can raise output and incomes. [1] A specific example of benefit, e.g. a country exporting coffee, cocoa or minerals earns foreign currency. [1] Explains economies of scale or the benefit of access to bigger markets. [1] Explains the risk of depending on a few exports, with an example (e.g. a fall in world coffee prices cuts export earnings). [1] Explains that primary products often earn less than manufactured goods, and that prices are volatile. [1] Explains other risks, e.g. competition from imports harming local industry, or unequal bargaining power with large buyers. [1] Explains how diversification, education and investment in manufacturing or services can reduce these risks. [1] Considers the role of government policy (e.g. trade agreements, infrastructure, training). [1] A clear judgement. [1] The judgement is supported by weighing the evidence and considering the short term compared with the long term. [1] Communication: a clear introduction, structured paragraphs and a conclusion, with accurate economic vocabulary.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Geography MYP 5 eAssessment Paper A (7 tasks, 69 marks) (69 marks)
with sub as (select id from public.subjects where slug = $mq$geography$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Geography MYP 5 eAssessment Paper A (7 tasks, 69 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Geography MYP 5 eAssessment Paper A (7 tasks, 69 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 9]]
Task 1: Population change in Tamberlo.

Tamberlo is an invented country. The figures were created for this paper and are not real statistics.

Source A: birth and death rates in Tamberlo (per 1,000 people per year)
Year: 1990, 2000, 2010, 2020
Birth rate: 38, 32, 24, 16
Death rate: 14, 10, 7, 8

(a) Calculate the natural increase per 1,000 people in 1990 and in 2020. (2 marks)

(b) Describe how the birth rate changed between 1990 and 2020 and suggest one reason for the change. (2 marks)

(c) Explain why the death rate fell between 1990 and 2010. (3 marks)

(d) Explain one problem that a country faces when the proportion of elderly people in its population grows. (2 marks)

Total for Question 1: 9 marks$mq$, $mq$(a) [1] 1990: 38 - 14 = 24 per 1,000. [1] 2020: 16 - 8 = 8 per 1,000.
(b) [1] The birth rate fell steadily, from 38 to 16 per 1,000 (22 fewer). [1] A valid reason, e.g. more girls in education and women in work, wider use of contraception, or people moving to cities where large families are less needed.
(c) [1] Better healthcare, vaccination and hospitals reduced deaths from disease. [1] Cleaner water, sanitation and improved nutrition or food supply reduced infection and malnutrition. [1] Higher incomes and education led to healthier living and lower infant mortality. Accept other accurate, developed reasons.
(d) [1] A valid problem, e.g. the cost of pensions and healthcare rises. [1] Developed, e.g. fewer working-age people pay taxes to support a growing number of dependants, so government budgets are put under strain.$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 4 | B 6]]
Task 2: Land use in the city of Kasira.

Kasira is an invented city. The data were created for this paper.

Source B: land price and building height in four zones of Kasira
Zone: distance from the central business district (CBD); average land price (US dollars per square metre); average building height (floors)
CBD: 0 km; 9,000; 22
Inner city: 3 km; 4,000; 6
Suburbs: 10 km; 1,500; 2
Rural-urban fringe: 20 km; 400; 1

(a) Describe the relationship between distance from the CBD and land price shown in Source B. (2 marks)

(b) Explain why land prices are highest in the CBD. (2 marks)

(c) Calculate the percentage fall in land price between the CBD and the rural-urban fringe. Give your answer to one decimal place. (2 marks)

(d) Explain one problem caused by urban sprawl at the rural-urban fringe. (2 marks)

(e) A student says: The data in Source B prove that all cities have land prices that fall steadily with distance from the CBD. Explain why this claim is not justified. (2 marks)

Total for Question 2: 10 marks$mq$, $mq$(a) [1] Land price falls as distance from the CBD increases. [1] Supported with figures, e.g. from 9,000 dollars in the CBD to 400 dollars at the fringe, with the steepest fall between the CBD and the inner city.
(b) [1] The CBD is the most accessible place, with roads and public transport leading to it, so many customers and workers can reach it. [1] There is great competition for limited space from shops, offices and banks, which can pay high prices, so buildings go upward (22 floors).
(c) [1] Method: (9,000 - 400) / 9,000 x 100 (or 8,600 / 9,000). [1] 95.6%
(d) [1] A valid problem, e.g. loss of farmland and natural habitats, longer journeys and more traffic. [1] Explained, e.g. commuters depend on cars so congestion and pollution increase, and services cost more to provide over a wider area.
(e) [1] The data are for one city only (and are invented for this paper). [1] Other cities have more than one centre or different geography, e.g. rivers, hills, planning rules or out-of-town shopping centres, which change the pattern. Accept other developed points.$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | B 9 | D 1]]
Task 3: Fieldwork enquiry: pedestrian flow.

A class is investigating the hypothesis: Pedestrian flow decreases with distance from the town centre. They will count pedestrians at five sites along a straight main road.

Source C: results of the class investigation (pedestrians counted in 10 minutes)
Site: distance from the town centre; count
1: 0 m; 120
2: 200 m; 96
3: 400 m; 60
4: 600 m; 55
5: 800 m; 20

(a) Explain why the class used a hypothesis to guide their investigation. (1 mark)

(b) Describe three ways the class could make sure their pedestrian counts are reliable and fair. (3 marks)

(c) Describe one risk in carrying out this fieldwork and explain how to reduce it. (2 marks)

(d) Calculate the mean count for the five sites. (1 mark)

(e) Name a suitable graph to show the relationship between distance and count, and explain why it is suitable. (2 marks)

(f) Suggest one reason why the count at Site 4 is only slightly lower than at Site 3. (1 mark)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] A hypothesis is a testable statement, so it gives the investigation a clear aim and the class can decide what data to collect.
(b) [1] Count at the same time of day and for the same length of time at every site. [1] Use the same counting method and counting point (for example tally sheets, one person counting each site), with the same weather and day. [1] Repeat the counts on different days or times and use the average.
(c) [1] A valid risk, e.g. standing near a busy road, or working alone. [1] A suitable way of reducing the risk, e.g. work in pairs on the pavement away from the kerb, wear high-visibility vests, and have a teacher or adult nearby.
(d) [1] (120 + 96 + 60 + 55 + 20) / 5 = 351 / 5 = 70.2.
(e) [1] Scatter graph (accept line graph). [1] It shows how two numerical variables are related, so a trend or relationship can be seen. Accept an answer such as a bar chart only if it is justified.
(f) [1] A valid reason that could be tested, e.g. a bus stop, school, park entrance or supermarket near Site 4 attracted extra pedestrians.$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | A 5 | B 2 | D 4]]
Task 4: Water resources in Rahel.

Rahel is an invented country. The figures were created for this paper.

Source D: water supply, demand and population in Rahel
Year: 2000, 2010, 2020
Water supply (million cubic metres per year): 9,500; 10,000; 9,800
Water demand (million cubic metres per year): 7,000; 9,800; 12,500
Population (millions): 5; 6.5; 8

A country is described as water stressed when it has fewer than 1,700 cubic metres of water per person per year.

(a) Calculate the water supply per person in Rahel in 2020. Give your answer in cubic metres per person per year. (1 mark)

(b) Using the 1,700 cubic metre threshold, state the first year shown in which Rahel was water stressed. Support your answer with a calculation. (2 marks)

(c) Calculate the shortfall between demand and supply in 2020, and describe the trend in demand between 2000 and 2020. (2 marks)

(d) Suggest two reasons why supply did not rise between 2010 and 2020 even though demand was growing. (2 marks)

(e) Rahel's government can either build a large dam or introduce water-saving measures such as higher prices, repairing leaking pipes and recycling. Evaluate which strategy it should choose. (4 marks)

Total for Question 4: 11 marks$mq$, $mq$(a) [1] 9,800 million / 8 million = 1,225 cubic metres per person.
(b) [1] 2010. [1] 10,000 / 6.5 = about 1,538, which is below 1,700 (in 2000 the figure is 1,900, which is above).
(c) [1] 12,500 - 9,800 = 2,700 million cubic metres. [1] Demand rose each period, from 7,000 to 12,500 (an increase of 5,500 million cubic metres or about 79%).
(d) [1] A valid reason, e.g. lower rainfall or drought linked to climate change. [1] A second valid reason, e.g. over-use of groundwater, pollution of rivers, or evaporation losses.
(e) [1] The dam is explained as increasing supply (storage) and possibly producing hydroelectric power. [1] A drawback of the dam, e.g. high cost, flooding of land, moving people, reduced flow to downstream countries. [1] Water saving is explained as reducing demand, usually at lower cost and with less environmental damage. [1] A reasoned recommendation, e.g. start with water saving and leak repair because it is faster, or use both, with a reason.$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | A 2 | C 6]]
Task 5: Reading a map extract.

Source E: a map extract described in words (Diagram not to scale). The scale is 1:25,000, so 1 cm on the map represents 250 m on the ground.
- The River Kell flows from west to east across the middle of the map. It has a wide, flat flood plain on both banks, where the map shows marsh symbols.
- The town of Marlow Ford lies on the south bank, beside the only bridge over the river. Four roads meet in the town.
- A railway runs parallel to the river on the south side and has a station in Marlow Ford.
- North of the river the contour lines are very close together and show a steep slope covered by woodland.
- On the south side, beyond the flood plain, the land is gently sloping farmland.
- The town's primary school and its railway station are 8 cm apart on the map.

(a) Calculate the real distance in kilometres between the school and the railway station. (1 mark)

(b) State what the very close contour lines on the north side of the river show about the land. (1 mark)

(c) Using Source E, write a short geographical explanation of why Marlow Ford grew where it did and what problem its site might face. Marks are given for your knowledge and for the quality of your geographical writing. (6 marks)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] 8 x 250 = 2,000 m = 2 km.
(b) [1] A steep slope.
(c) [1] Bridging point: the town is beside the only bridge, so routes and roads meet there. [1] Site advantages: flat land on the south bank for building and farmland; the river as a water supply; the railway and station help transport. [1] Site disadvantage: the nearby flood plain with marsh makes flooding likely, especially after heavy rain, which can damage property. [1] A suggested management or response, e.g. flood defences, avoiding building on the flood plain, flood warnings. [1] Communication: clear, organised writing with a sequence of linked ideas. [1] Communication: accurate geographical terms (e.g. bridging point, flood plain, site, contours) used correctly.$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | D 9]]
Task 6: Tourism in the Kalani Reserve.

Kalani Reserve is an invented wildlife reserve in a developing country. The sources were created for this paper.

Source F: an extract from the website of a safari lodge company (imagined)
"Our lodges bring jobs and opportunity to the Kalani region. More than 200 local people work with us as guides, cooks and drivers, and our guests pay a conservation fee to protect the lions and elephants for generations. Our tourists pay to see wildlife, so the animals are worth more alive than dead."

Source G: an extract from an interview with a village elder (imagined)
"The lodge owners are from the capital city and most of the money leaves with them. The reserve was our grazing land, and now our cattle are not allowed there. The young people work as cleaners and drivers while the managers are foreign. The tourists drive across our farmland in big cars and leave rubbish."

(a) Compare the views of the safari lodge company and the village elder about the effects of tourism. (3 marks)

(b) Explain why the two sources give different views. (3 marks)

(c) Suggest one change that would make tourism in Kalani Reserve more sustainable, and evaluate how successful it would be. (3 marks)

Total for Question 6: 9 marks$mq$, $mq$(a) [1] The company sees tourism as providing local jobs and paying for conservation. [1] The elder sees most of the money leaving the area and local people losing land access and good jobs. [1] A comparison point, e.g. both mention jobs, but the company stresses quantity (200 jobs) and the elder stresses the poor quality of work and its low pay.
(b) [1] The company's purpose is to attract tourists and show a positive image. [1] The elder lives with the costs of tourism and has lost access to grazing land. [1] Different stakeholders have different interests.
(c) [1] A relevant change, e.g. a community-run lodge, local hiring and training for management roles, or sharing the entry fees with villages. [1] A benefit explained, e.g. more income stays in the area and local people support wildlife protection. [1] A limitation or condition, e.g. needs funding and training, and the lodge company may resist.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | C 2 | D 10]]
Task 7: Responding to climate change: extended response.

Statement: Adapting to climate change is a better response than trying to reduce greenhouse gas emissions.

Evaluate this statement. Use specific examples that you have studied. You should:
- explain how adaptation helps people and places,
- explain how mitigation (reducing emissions) works,
- reach a supported judgement.

(a) Evaluate the statement. Your answer will be marked for your knowledge and evaluation (10 marks) and for the quality of your communication (2 marks). (12 marks)

Total for Question 7: 12 marks$mq$, $mq$(a) [1] Adaptation is explained with a specific example (e.g. sea walls and flood barriers in the Netherlands or Bangladesh's cyclone shelters and early warning). [1] A second adaptation example, e.g. drought-resistant crops, rainwater harvesting or moving settlements away from coasts. [1] The benefit of adaptation is explained: it protects communities now and the effects can be seen quickly. [1] A limit of adaptation is explained, e.g. it cannot stop sea-level rise, it is costly, and poorer countries have less money to adapt. [1] Mitigation is explained with a specific example (e.g. replacing fossil fuels with solar and wind power, the Paris Agreement of 2015, reforestation). [1] A second mitigation point, e.g. energy efficiency, electric transport, carbon taxes. [1] The benefit of mitigation is explained: it tackles the cause and limits future warming for everyone. [1] A limit of mitigation is explained, e.g. results take decades, it needs international cooperation, and large emitters may not agree. [1] Links between the two are made, e.g. more warming makes adaptation harder, and some warming is already locked in. [1] A clear judgement, e.g. both are needed but mitigation is more important in the long term. [1] The judgement is supported with reasoning about timescales, costs or fairness (poorer countries emit least but suffer most). [1] Communication: a clear introduction, structured paragraphs and a conclusion, with accurate geographical vocabulary.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Geography MYP 5 eAssessment Paper B (7 tasks, 68 marks) (68 marks)
with sub as (select id from public.subjects where slug = $mq$geography$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Geography MYP 5 eAssessment Paper B (7 tasks, 68 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Geography MYP 5 eAssessment Paper B (7 tasks, 68 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 10]]
Task 1: Plate boundaries and hazards.

Source A: a cross-section described in words (Diagram not to scale)
An oceanic plate is moving towards a continental plate at an average of 5 cm per year. At the boundary the oceanic plate bends down beneath the continental plate and forms a deep ocean trench. On the continental side, about 150 km inland from the trench, there is a line of volcanoes. Earthquake foci are shallow near the trench and become deeper further inland.

(a) Name the type of plate boundary described in Source A. (1 mark)

(b) Explain why the oceanic plate sinks beneath the continental plate. (2 marks)

(c) Explain why volcanoes form on the continental side of this boundary. (2 marks)

(d) Calculate how far the oceanic plate would move in 10,000 years at 5 cm per year. Give your answer in metres. (1 mark)

(e) Explain two ways that people living in an earthquake zone can reduce the impact of earthquakes. (4 marks)

Total for Question 1: 10 marks$mq$, $mq$(a) [1] Destructive (also accepted: convergent or subduction zone).
(b) [1] Oceanic crust is denser than continental crust. [1] The denser plate is forced down (subducted) into the mantle where it melts.
(c) [1] The subducted plate melts as it descends, and water released from it lowers the melting point of the mantle above, forming magma. [1] The magma is less dense than the surrounding rock, so it rises through the crust and erupts at the surface.
(d) [1] 5 cm x 10,000 = 50,000 cm = 500 m.
(e) [1] First valid method, e.g. building earthquake-resistant structures with deep foundations and flexible frames. [1] Explanation of how it reduces impact, e.g. fewer buildings collapse, so fewer people die. [1] Second valid method, e.g. earthquake drills and public education; land-use planning; emergency supplies and rapid-response teams. [1] Explanation of how the second method reduces impact.$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 2 | B 4 | D 3]]
Task 2: Climate of Solmara.

Solmara is an invented city. The climate data were created for this paper.

Source B: monthly climate data for Solmara
Month: J, F, M, A, M, J, J, A, S, O, N, D
Mean temperature (degrees Celsius): 24, 24, 23, 21, 18, 15, 14, 15, 17, 19, 21, 23
Rainfall (mm): 12, 10, 25, 55, 90, 120, 130, 110, 70, 40, 20, 15

(a) Calculate the annual temperature range for Solmara. (1 mark)

(b) Calculate the total annual rainfall for Solmara. (1 mark)

(c) Solmara is in the Southern Hemisphere. Identify two pieces of evidence in Source B that support this. (2 marks)

(d) Describe the pattern of rainfall in Source B. (2 marks)

(e) Climate scientists predict that Solmara's temperatures will rise by 2 degrees Celsius and that winter rainfall will fall by 20 percent. Explain two ways this could affect farming in the region. (3 marks)

Total for Question 2: 9 marks$mq$, $mq$(a) [1] 24 - 14 = 10 degrees Celsius.
(b) [1] 12 + 10 + 25 + 55 + 90 + 120 + 130 + 110 + 70 + 40 + 20 + 15 = 697 mm.
(c) [1] The coldest month is July (14 degrees Celsius). [1] The warmest months are December, January and February (24 degrees Celsius at the start and end of the year).
(d) [1] The wettest months are in the middle of the year (June to August, with a peak of 130 mm in July). [1] The driest months are at the start and end of the year (10 mm in February and 12 mm in January); rainfall rises from March and falls from August.
(e) [1] Less winter rainfall reduces water for crops and may cause drought or lower yields. [1] Higher temperatures increase evaporation and heat stress, which raises demand for irrigation. [1] Consequence of the changes, e.g. farmers may need to change crops or invest in irrigation, which increases costs and food prices. (Three developed points for three marks.)$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | B 10]]
Task 3: River response to rainfall.

Two small catchments received the same storm. Catchment X is mostly forest. Catchment Y is mostly a built-up town with roads and drains. The peak rainfall in both catchments fell at hour 2.

Source C: river discharge (cubic metres per second)
Hours after the storm began: 0, 2, 4, 6, 8, 10, 12
Catchment X (forest): 5, 5, 8, 14, 12, 8, 6
Catchment Y (town): 5, 12, 40, 25, 14, 8, 6

(a) State the peak discharge and the time at which it occurred for each catchment. (2 marks)

(b) Calculate the lag time for each catchment (the time between peak rainfall and peak discharge). (2 marks)

(c) Explain why the river in Catchment Y responds more quickly and reaches a higher peak than the river in Catchment X. (3 marks)

(d) Suggest one way in which the students could improve the reliability of their conclusion about the two catchments. (1 mark)

(e) Explain why the catchments need to be similar in size and rock type for the comparison to be fair. (2 marks)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] Catchment X: 14 cubic metres per second at hour 6. [1] Catchment Y: 40 cubic metres per second at hour 4.
(b) [1] Catchment X: 6 - 2 = 4 hours. [1] Catchment Y: 4 - 2 = 2 hours.
(c) [1] Tarmac, concrete and roofs are impermeable, so water cannot soak into the ground (infiltration is low). [1] Drains and gutters carry water rapidly to the river, so surface runoff is fast. [1] In Catchment X trees intercept rain and roots take up water, so water reaches the river slowly by throughflow and groundwater.
(d) [1] Use data from several storms, not one, or from more catchments of the same size, slope and rock type.
(e) [1] Other factors such as size, steepness and rock permeability also affect discharge. [1] If these differed, the difference in discharge might not be caused by land use, so the comparison would not be a fair test.$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 10]]
Task 4: Planning an investigation: a factory and a town.

A student wants to investigate how a transnational corporation (TNC) factory affects the town of Hangmai, an invented town. The factory makes sports shoes for export and opened in 2005. The student can interview workers, survey shops and look at government statistics.

(a) Write a focused enquiry question for the investigation and suggest a hypothesis. (2 marks)

(b) Identify three types of data the student could collect and explain how each would help. (3 marks)

(c) Write two questions the student could ask workers in a survey. Explain why each is a good question. (3 marks)

(d) Explain how the student could reduce bias in choosing which workers to survey. (2 marks)

Total for Question 4: 10 marks$mq$, $mq$(a) [1] A clear enquiry question about economic or social effects of the factory on Hangmai. [1] A testable hypothesis (e.g. Shops in Hangmai have more customers now than before 2005).
(b) [1] A suitable type of primary data (e.g. questionnaire to workers) and its use. [1] A suitable type of secondary data (e.g. government employment or wage statistics) and its use. [1] A third type (e.g. interviews with a shop owner; photographs; local newspaper reports), with a reason.
(c) [1] A clear, unbiased question about experiences (e.g. How many hours do you work in a week?). [1] Explanation, e.g. it produces data that can be counted and compared. [1] A second suitable question that is not leading, with explanation.
(d) [1] Select people randomly or from different departments, ages and shifts. [1] Do not ask only friends or workers the factory manager recommends, because they may give more positive answers.$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | A 2 | C 6]]
Task 5: Preparing a coastal town for tsunami.

Background: A coastal town of 8,000 people lies on low ground less than 5 m above sea level. The nearby sea floor has a plate boundary that can cause strong earthquakes. Scientists say a tsunami could reach the town within 30 minutes of a large earthquake.

(a) State two factors that can increase the risk to people from a natural hazard such as a tsunami. (2 marks)

(b) Write the text for a public information leaflet of about 100 words that explains to residents what to do if a tsunami warning is given and why. Marks are given for your knowledge and for how clearly and suitably you communicate to the general public. (6 marks)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] A valid factor (e.g. high population density, low-lying land, poverty). [1] A second different valid factor (e.g. poor warning systems, weak buildings, lack of education or preparedness).
(b) [1] States clear warning signs (e.g. a strong or long earthquake near the coast, or the sea drawing back suddenly). [1] Gives correct actions: move immediately to higher ground or inland and away from the shore, do not wait for a siren. [1] Explains why (e.g. waves can arrive within 30 minutes and later waves can be larger). [1] Mentions further advice (e.g. prepare an emergency kit, know the evacuation route, follow official alerts, do not return until it is declared safe). [1] Communication: clear, simple language and sentences suitable for the public, with a helpful heading or sequence. [1] Communication: logical order and an appropriate tone (calm and direct).$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | D 9]]
Task 6: Coral reefs under pressure.

The Tavo Islands are invented. The sources were created for this paper.

Source F: an extract from a dive-company brochure (imagined)
"Come and explore the Tavo reefs, some of the most colourful in the region! Our expert guides have been diving here for fifteen years, and the reef has never looked better. Over 400 divers each year come to the islands, and every dive helps to fund local jobs."

Source G: part of a marine scientist's survey (imagined)
Site: description; percentage of seabed covered by living coral in 2010; in 2020
A: inside a marine reserve; 60; 55
B: next to the harbour; 55; 30
C: remote island with no tourism; 50; 48
D: beneath a hotel sewage outlet; 70; 25

(a) Calculate the percentage fall in coral cover at Site D between 2010 and 2020. Give your answer to one decimal place. (2 marks)

(b) Using Source G, explain what the data suggest about the causes of coral loss in the Tavo Islands. (3 marks)

(c) The brochure says the reef has never looked better. Evaluate how far Source G supports this view. (4 marks)

Total for Question 6: 9 marks$mq$, $mq$(a) [1] Method: (70 - 25) / 70 x 100 (or 45 / 70). [1] 64.3%
(b) [1] Sites near human activity fell most (B: harbour and D: sewage outlet), suggesting that pollution and boat traffic harm coral. [1] Protected or remote sites changed little (A and C), suggesting that protection or lack of human activity helps coral survive. [1] Comparison supported with figures, e.g. site D fell by 45 percentage points against 2 points at site C.
(c) [1] Source G shows large losses at B and D, which contradicts the brochure. [1] The brochure may be correct for the sites divers visit (e.g. protected sites such as A), and A and C show small losses only. [1] The brochure's purpose is to attract divers, so it selects positive information. [1] A judgement on the extent of support, e.g. little support overall because the scientist's data cover several sites and the dive company has a commercial motive.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | C 2 | D 10]]
Task 7: Globalisation: extended response.

Statement: Globalisation has brought more benefits than costs to developing countries.

Evaluate this statement. Use specific examples that you have studied, such as transnational corporations, trade, migration, communication technology or culture. You should:
- explain how developing countries benefit from globalisation,
- explain the costs or problems it can create,
- reach a supported judgement.

(a) Evaluate the statement. Your answer will be marked for your knowledge and evaluation (10 marks) and for the quality of your communication (2 marks). (12 marks)

Total for Question 7: 12 marks$mq$, $mq$(a) [1] A benefit is explained with a specific example (e.g. TNCs create factory jobs and bring investment and technology). [1] A second benefit, e.g. access to world markets for exports; remittances sent by migrants; mobile phones and internet access. [1] A developed point on wider impact, e.g. rising incomes, a growing middle class and reduced poverty in some countries. [1] A cost is explained with a specific example (e.g. low wages, long hours and unsafe working conditions in some factories). [1] A second cost, e.g. profits leave the country, local businesses cannot compete, or workers can lose jobs when TNCs relocate. [1] Environmental or cultural costs, e.g. pollution, resource use, loss of traditional culture. [1] Recognises that benefits and costs are unevenly shared (e.g. between regions, social groups or countries). [1] Recognises that outcomes depend on government policy, e.g. trade rules, minimum wages and environmental regulation. [1] A balanced comparison of the scale and long-term effects of benefits and costs. [1] A clear judgement. [1] The judgement is supported by reasoning rather than a list. [1] Communication: a clear introduction, structured paragraphs and a conclusion, with accurate geographical vocabulary.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Geography MYP 5 eAssessment Paper C (7 tasks, 68 marks) (68 marks)
with sub as (select id from public.subjects where slug = $mq$geography$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Geography MYP 5 eAssessment Paper C (7 tasks, 68 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Geography MYP 5 eAssessment Paper C (7 tasks, 68 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 9]]
Task 1: Nutrient cycling in ecosystems.

Source A: illustrative shares of nutrients held in three stores (values created for this paper to show general patterns)
Store: tropical rainforest (percentage); temperate deciduous woodland (percentage)
Biomass (trees and plants): 75; 35
Litter (dead leaves and wood on the ground): 3; 15
Soil: 22; 50

(a) Calculate how many times larger the biomass store is in the rainforest than in the temperate woodland. Give your answer to one decimal place. (2 marks)

(b) Explain why the litter store is smaller in the tropical rainforest than in the temperate woodland. (2 marks)

(c) Explain why soils in cleared tropical rainforest quickly become infertile. (2 marks)

(d) Explain how large-scale deforestation can change the water cycle in a rainforest region. (3 marks)

Total for Question 1: 9 marks$mq$, $mq$(a) [1] 75 / 35 (method). [1] 2.1
(b) [1] Warm, wet conditions in the rainforest allow bacteria, fungi and insects to break down dead material very rapidly. [1] Nutrients are taken up again quickly by roots, so little accumulates as litter.
(c) [1] Most nutrients are stored in the biomass, which is removed when trees are cut. [1] Without leaf litter to return nutrients, and with heavy rain washing nutrients out of the soil (leaching), the soil is quickly depleted.
(d) [1] Fewer trees mean less transpiration and interception, so less water vapour enters the air. [1] Reduced evaporation and cloud formation may mean less local rainfall. [1] Without tree roots and canopy, rain runs off quickly over the surface, which increases flooding and soil erosion in rivers.$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 5 | B 2 | D 3]]
Task 2: Getting to work in Brenhaven.

Brenhaven is an invented city. The figures were created for this paper.

Source B: how people travel to work in Brenhaven (percentage of commuters)
Mode: 2015; 2023
Car: 62; 48
Bus: 20; 30
Cycling: 3; 9
Walking: 10; 10
Train: 5; 3
Total number of commuters: 200,000 in 2015; 260,000 in 2023.

(a) State the change in the percentage of commuters who cycled between 2015 and 2023. (1 mark)

(b) Calculate the percentage increase in the share of commuters using the bus between 2015 and 2023. (2 marks)

(c) Describe the main changes in the way people travelled to work between 2015 and 2023. (2 marks)

(d) Explain one environmental benefit of a shift from cars to buses and bikes. (2 marks)

(e) A city councillor says: Fewer people are driving to work in Brenhaven now than in 2015. Use calculations from Source B to evaluate this claim. (3 marks)

Total for Question 2: 10 marks$mq$, $mq$(a) [1] An increase of 6 percentage points (3 to 9).
(b) [1] Method: (30 - 20) / 20 x 100. [1] 50%
(c) [1] The share travelling by car fell most (62 to 48 percent), while bus use and cycling rose (bus from 20 to 30 and cycling from 3 to 9). [1] Walking stayed at 10 percent and train use fell slightly (5 to 3 percent).
(d) [1] Fewer cars on the road reduces carbon dioxide and nitrogen oxide emissions. [1] Developed, e.g. cleaner air and lower greenhouse gases, and less congestion means less fuel wasted idling.
(e) [1] 2015: 62% of 200,000 = 124,000 car commuters. [1] 2023: 48% of 260,000 = 124,800 car commuters. [1] Judgement: the share fell, but the number of drivers did not fall (it rose by 800), so the claim is not supported.$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 7 | D 2]]
Task 3: Retreat of a delta shoreline.

The Ilo Delta is an invented coastal area. The data and interview were created for this paper.

Source C: measurements from satellite images
Year: 1990, 2005, 2020
Width of the mangrove forest along the coast (metres): 400, 250, 90
Distance the shoreline has retreated since 1990 (metres): 0, 70, 180

Source D: an extract from an interview with a fisherman, Mr Tane, recorded by a researcher from a university (imagined, 2020)
"When I was a boy the mangroves were thick and the waves were gentle behind them. Shrimp farms were built, and the trees were cut for ponds and firewood. Now every storm takes more of the beach, and my house is only forty metres from the water."

(a) Calculate the average rate of shoreline retreat between 1990 and 2020 in metres per year. (1 mark)

(b) Describe how the shoreline retreat changed over time and how it relates to the width of the mangrove forest. (2 marks)

(c) Identify the origin and purpose of Source D. (2 marks)

(d) Explain one way in which Source C is valuable for a geographer studying coastal change. (2 marks)

(e) Explain one limitation of using Sources C and D alone to decide that cutting the mangroves caused the shoreline to retreat. (2 marks)

Total for Question 3: 9 marks$mq$, $mq$(a) [1] 180 / 30 = 6 metres per year.
(b) [1] Retreat was 70 m in the first 15 years and a further 110 m in the next 15 years, so it speeded up (about 4.7 m a year to about 7.3 m a year). [1] As the mangrove belt became narrower (400 to 90 m), the retreat increased, suggesting mangroves protect the coast.
(c) [1] Origin: an interview with a local fisherman recorded by a university researcher in 2020. [1] Purpose: to collect local people's first-hand experience of coastal change for research.
(d) [1] It gives measurements at three dates, so changes can be compared over time. [1] Satellite images cover a large area consistently and objectively, which is useful for calculating rates.
(e) [1] The sources show a link but do not prove cause; other factors such as sea-level rise, storms and sediment supply from rivers could also be responsible. [1] Source D is one person's opinion and Source C covers only one location.$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 7 | D 3]]
Task 4: Using GIS to choose a hospital site.

A regional government is using a geographic information system (GIS) to choose a site for a new hospital. The GIS holds layers of data for four possible sites.

Source E: data for the four sites
Site: population within 5 km (thousands); distance to the nearest main road (km); flood risk; land cost (million dollars)
A: 85; 0.5; low; 6
B: 120; 3.0; high; 4
C: 60; 1.0; low; 3
D: 95; 0.8; medium; 5

Scoring rules (3 is best, 1 is worst):
Population: more than 100 = 3; 80 to 100 = 2; less than 80 = 1.
Distance to road: less than 1 km = 3; 1 to 2 km = 2; more than 2 km = 1.
Flood risk: low = 3; medium = 2; high = 1.
Land cost: 4 million or less = 3; more than 4 up to 6 million = 2; more than 6 million = 1.

(a) Explain what is meant by overlaying layers in a GIS and why it is useful in this decision. (2 marks)

(b) Calculate the total score for Site A and for Site D. (2 marks)

(c) The government decides that flood risk is twice as important as the other factors, so the flood risk score is doubled. Calculate the new total score for Site B and for Site C. (2 marks)

(d) Recommend one site for the hospital and justify your choice using the scores. (1 mark)

(e) Evaluate one limitation of using a scoring method like this to choose the site. (3 marks)

Total for Question 4: 10 marks$mq$, $mq$(a) [1] Layers of different data (such as population, roads and flood zones) for the same area are placed on top of one another. [1] This lets planners compare several factors at once and find sites that meet all of the criteria.
(b) [1] Site A: 2 + 3 + 3 + 2 = 10. [1] Site D: 2 + 3 + 2 + 2 = 9.
(c) [1] Site B: 3 + 1 + (2 x 1) + 3 = 8 + 1 = 9. [1] Site C: 1 + 2 + (2 x 3) + 3 = 12.
(d) [1] A clear choice supported by figures, e.g. Site A has the highest total (10, or 13 with flood risk doubled), by being near a road with a low flood risk.
(e) [1] The score bands and the weights are arbitrary; a small change in the rules can change the result (e.g. cost at exactly 6 million). [1] It leaves out important factors such as local opinion, the environment or how long ambulances take to reach other areas. [1] A judgement that the GIS scores are best used as a guide alongside consultation and site visits.$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | A 2 | C 6]]
Task 5: Rising sea levels.

Background: Many people live in low-lying delta cities. Sea levels have been rising and storm surges can flood the land. A city council has asked for advice on how to protect its residents.

(a) State two causes of sea-level rise linked to global warming. (2 marks)

(b) Write a letter of about 120 words to the city council recommending how it should protect the city from flooding in the future. Marks are given for your geographical knowledge and for how clearly and persuasively you communicate. (6 marks)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] Thermal expansion of seawater as the oceans warm. [1] Melting of land ice such as glaciers and the ice sheets of Greenland and Antarctica.
(b) [1] Describes the threat accurately (e.g. sea-level rise and storm surges threaten low-lying homes and drinking water). [1] Recommends a specific hard-engineering measure (e.g. sea walls or flood barriers) with a reason. [1] Recommends a soft or sustainable measure (e.g. restoring mangroves or wetlands, early warning systems, or managed retreat) with a reason. [1] Justifies the recommendation, e.g. by comparing cost, effectiveness, effects on people and the environment, or the long-term view. [1] Communication: letter conventions are used (greeting, clear opening, closing) and the tone is polite and persuasive. [1] Communication: ideas are in a logical order with accurate geographical vocabulary.$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | D 10]]
Task 6: Managing fish stocks.

The island of Marrow is invented. The figures and sources were created for this paper.

Source F: fish stock and annual catch around Marrow
Year: 2000, 2010, 2020
Fish stock (tonnes): 50,000; 30,000; 12,000
Annual catch (tonnes): 8,000; 9,000; 7,000

Source G: a marine biologist (imagined)
"The stock has fallen by almost four-fifths in twenty years. We are catching fish faster than they can breed. Without strict catch limits the fishery will collapse, and then there will be no fish and no jobs."

Source H: the president of the island's fishing association (imagined)
"Quotas will ruin our families. The real problem is the big foreign trawlers that fish just beyond our waters. Our small boats cannot catch enough to harm the sea."

(a) Calculate the catch in 2020 as a percentage of the fish stock in 2020. Give your answer to one decimal place. (2 marks)

(b) Using Source F, explain why the fishing around Marrow is unsustainable. (2 marks)

(c) Compare the views of Source G and Source H about what should be done. (2 marks)

(d) Evaluate whether introducing a catch quota is the best way to restore fish stocks around Marrow. (4 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) [1] Method: 7,000 / 12,000 x 100. [1] 58.3%
(b) [1] The stock fell from 50,000 to 12,000 tonnes while the catch stayed high, so the proportion caught rose (16 percent in 2000 to 58.3 percent in 2020). [1] Fish cannot breed fast enough to replace those caught, so the population will decline further and may collapse.
(c) [1] Source G calls for strict catch limits to protect the stock. [1] Source H opposes quotas and blames foreign trawlers; the different interests (conservation against livelihoods) explain the disagreement.
(d) [1] A benefit of quotas explained (e.g. limits the total catch so stocks can recover). [1] A problem of quotas (e.g. hard to enforce, hurts small-boat fishers, foreign trawlers outside the waters are not controlled). [1] An alternative (e.g. marine protected areas, banning certain nets, international agreements on trawlers) with a reason. [1] A reasoned judgement, e.g. quotas help but only if combined with enforcement and international cooperation.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | C 2 | D 10]]
Task 7: Urban growth: extended response.

Statement: Governments should improve informal settlements (slums) rather than clear them.

Evaluate this statement. Use specific examples that you have studied, such as self-help housing, upgrading schemes (for example the Favela-Bairro programme in Rio de Janeiro), relocation or new housing projects. You should:
- explain why improving informal settlements may be effective,
- explain why clearing or relocating them may be considered,
- reach a supported judgement.

(a) Evaluate the statement. Your answer will be marked for your knowledge and evaluation (10 marks) and for the quality of your communication (2 marks). (12 marks)

Total for Question 7: 12 marks$mq$, $mq$(a) [1] Explains why informal settlements grow (rural-urban migration, shortage of affordable housing). [1] Explains improvement with an example (e.g. Favela-Bairro: paved streets, water, sanitation and community buildings). [1] Explains how improvement helps people: they stay close to jobs and communities; it costs less than rebuilding. [1] A developed point about self-help or community involvement (people improve their own homes with materials or loans). [1] A limit of improvement, e.g. it may not remove all risks if homes are on steep slopes or flood plains, and land ownership issues remain. [1] Explains clearance with an example (e.g. moving residents to new apartment blocks on the edge of the city). [1] A benefit of clearance: safer, planned housing with services, where the land is dangerous. [1] A drawback of clearance: loss of jobs and social networks, long commutes, and rents too high for the poorest. [1] Considers who benefits (residents, governments, developers) and who loses. [1] A clear judgement. [1] The judgement is supported by weighing the evidence, e.g. improvement is generally better except in hazardous locations. [1] Communication: a clear introduction, structured paragraphs and a conclusion, with accurate vocabulary.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- History MYP 5 eAssessment Paper A (7 tasks, 67 marks) (67 marks)
with sub as (select id from public.subjects where slug = $mq$history$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$History MYP 5 eAssessment Paper A (7 tasks, 67 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$History MYP 5 eAssessment Paper A (7 tasks, 67 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: The Ottoman Empire.

Source A: a timeline of selected events (compiled for this paper)
1453: Sultan Mehmed II captures Constantinople.
1517: Sultan Selim I conquers Mamluk Egypt.
1529: An Ottoman army besieges Vienna but withdraws.
1566: Sultan Suleiman I dies after a reign of 46 years.
1683: A second siege of Vienna fails.
1923: The Republic of Turkey is proclaimed.

(a) State two events in Source A that show the Ottoman Empire expanding its territory. (2 marks)

(b) Show that 470 years separate the capture of Constantinople from the proclamation of the Republic of Turkey. (1 mark)

(c) Describe how the millet system worked in the Ottoman Empire. (2 marks)

(d) Explain why the Ottoman Empire was able to rule many different peoples for several centuries. (3 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] 1453: the capture of Constantinople. [1] 1517: the conquest of Mamluk Egypt. (Do not accept 1529 or 1683, which were failures, or 1566 or 1923.)
(b) [1] 1923 - 1453 = 470 (the subtraction must be shown).
(c) [1] Non-Muslim religious communities (for example Orthodox Christians, Armenians, Jews) were organised into self-governing groups called millets. [1] Each millet ran its own religious courts, schools and community affairs under its own leaders, and paid taxes (such as the jizya) to the Sultan.
(d) [1] A powerful, well-paid army, including the Janissaries, could defend the empire and put down rebellion. [1] Religious tolerance under the millet system let communities keep their faith and customs, which reduced resentment. [1] An organised administration and tax system (provinces, governors, officials) and control of trade routes brought wealth that funded the state. Accept other accurate, developed explanations.$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 3 | B 7]]
Task 2: Emigration from a fictional port.

Carrick Haven and Dunmarrow are invented places. The figures were created for this paper and are not real statistics. In 1846 the potato crop in the Dunmarrow valley failed for the first time, and it failed again in 1847.

Source B: number of emigrants leaving Carrick Haven
Year: 1846, 1847, 1848, 1849, 1850
Emigrants: 4,200; 9,800; 7,000; 6,300; 3,500

Source C: passengers on the emigrant ship Marigold, 1847 (invented passenger list)
Adults (220 in total): farm labourers 120; craftworkers 45; servants 35; shopkeepers 10; other occupations 10.
Children under 14: 180.

(a) Calculate the total number of emigrants who left Carrick Haven from 1846 to 1850. (1 mark)

(b) Calculate the percentage fall in emigrants between 1847 and 1850. Give your answer to one decimal place. (2 marks)

(c) Calculate the percentage of the passengers on the Marigold who were children. (1 mark)

(d) Describe one pattern shown in Source C and suggest one reason for it. (2 marks)

(e) Suggest one question about emigration from Carrick Haven that Sources B and C cannot answer, and name one type of source that could help to answer it. (2 marks)

(f) Explain why a historian should be careful before using Source B to say that the potato failure was the only cause of emigration. (2 marks)

Total for Question 2: 10 marks$mq$, $mq$(a) [1] 4,200 + 9,800 + 7,000 + 6,300 + 3,500 = 30,800.
(b) [1] Method: (9,800 - 3,500) / 9,800 x 100 (or 6,300 / 9,800). [1] 64.3%
(c) [1] 180 / 400 x 100 = 45%.
(d) [1] A valid pattern, e.g. farm labourers were the largest adult group (120 of 220, over half); or nearly half of the passengers were children, so whole families travelled. [1] A valid reason, e.g. farm labourers depended most on the potato crop, so they were hit hardest by the failure; families left together because there was no food or work to stay for.
(e) [1] A valid unanswered question, e.g. where the emigrants settled; how many returned; what the emigrants themselves felt; why richer families did not leave. [1] A suitable source type matched to the question, e.g. letters from emigrants; arrival records at the destination port; census returns; ship captains' logs.
(f) [1] The table only gives numbers; it does not state why people left. [1] Other causes could have been at work, e.g. rent rises, evictions, or the pull of work abroad, which the figures cannot show. (Also accept that the numbers are for one port only.)$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | B 7 | D 3]]
Task 3: Life on the home front, 1941 to 1942.

Source D: a government poster (imagined, described for this paper)
Origin: issued in 1941 by a British government ministry.
Description: A smiling woman in a headscarf holds a spade in a neat vegetable garden. Behind her a ship is shown sinking into the sea. The slogan in bold letters reads: EVERY PLOT A WEAPON. GROW YOUR OWN. Small print at the bottom reads: Every pound of food you grow is a pound that need not be shipped across the Atlantic.

Source E: an extract from a diary (imagined, written for this paper by a fictional housewife in a northern town, March 1942)
"The allotment is hard work after a day at the factory and my back aches, but I would not give it up. This week we ate our own carrots and the neighbours swapped us onions for seed potatoes. The ration book is a poor thing by itself. Some women grumble that the posters make it sound like a game when they are tired to the bone, but I would rather dig than go hungry."

(a) Identify the origin and the purpose of Source D. (2 marks)

(b) Explain one way in which Source D is valuable to a historian studying the British home front. (3 marks)

(c) Explain one limitation of Source E for a historian who wants to know how most people in Britain felt about growing food. (2 marks)

(d) Compare how far Sources D and E agree about growing food at home. (3 marks)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] Origin: a British government ministry poster of 1941, during the Second World War. [1] Purpose: to persuade civilians to grow their own food, so that fewer ships carrying food had to cross the Atlantic and food supplies lasted (and to boost morale and a sense of contributing).
(b) [1] Identifies a valid value, e.g. it shows the government message and the methods used to mobilise civilians; it shows the wartime threat from attacks on shipping. [1] Explains why this is valuable, linked to the origin, content or purpose, e.g. a poster from a ministry reveals what the government wanted the public to do and believe, which is evidence of official policy. [1] Developed with a specific detail from the poster, e.g. the sinking ship or the slogan EVERY PLOT A WEAPON links gardening to winning the war.
(c) [1] A valid limitation, e.g. it is the view of one woman in one northern town, so it may not be typical. [1] Explanation, e.g. her mixed feelings may reflect her own circumstances (she has an allotment), and a private diary may leave out other views or exaggerate; many people lived in cities without gardens.
(d) [1] Agreement identified, e.g. both present growing food as worthwhile and helpful in wartime. [1] Disagreement identified, e.g. D shows it as cheerful and simple while E admits it is tiring and that some women resent the posters. [1] A supported judgement about the extent of agreement, linked to the different authors and purposes (a government wanting action against a private writer recording experience).$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 10]]
Task 4: Planning an investigation: the printing press.

A student is investigating the effects of the printing press in Europe. Her first question is: How far did the printing press change Europe?
She knows that Johannes Gutenberg began printing with movable metal type in Mainz around 1450, and that by 1500 printing presses were working in more than 200 European towns.

(a) Explain two ways in which the student's question could be made more focused. (2 marks)

(b) Write a more focused research question that the student could investigate. (1 mark)

(c) Identify two different sources the student could use and explain how each would help her investigation. (4 marks)

(d) The student finds a website that says the printing press was the most important invention in history. Describe three checks she should make before using it in her investigation. (3 marks)

Total for Question 4: 10 marks$mq$, $mq$(a) [1] It could be limited by time period (e.g. 1450 to 1550) or place (e.g. one country or city). [1] It could be limited to one aspect of change (e.g. spread of religious ideas, literacy, or the price of books) instead of the whole of Europe.
(b) [1] A clear, answerable question that names a period, place or aspect, e.g. How far did the printing press spread Protestant ideas in German towns between 1517 and 1530?
(c) [1] A suitable first source (e.g. a printed pamphlet or Bible from the period; town records of print shops; a historian's book). [1] Explanation of how the first source helps, linked to the question. [1] A second source of a different type. [1] Explanation of how the second source helps, linked to the question and different in the evidence it gives.
(d) [1] Check who wrote the page and whether they are an expert (author or organisation). [1] Check the purpose or bias, e.g. whether the site is trying to sell something or argue a view. [1] Check the date, evidence and references, and compare the claims with at least one other source such as a history textbook or museum site.$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | A 2 | C 6]]
Task 5: The Black Death in England.

Source F: an extract from a chronicle (imagined, written for this paper by a fictional monk, Brother Aldric of Wexham, in 1349)
"The sickness came to our village after Michaelmas. Before Christmas twenty-two of our sixty households stood empty. The corn lay uncut in the fields, for no hired man could be found, and when one came he asked double the old wage. The lord's steward cursed and swore, but there were no hands to work the land and no hands to bury the dead."

(a) State two symptoms of bubonic plague or two ways in which the plague spread. (2 marks)

(b) Using Source F and your own knowledge, explain how the Black Death changed the lives of peasants in England. Write a short paragraph. Marks are given for the quality of your historical writing as well as your knowledge. (6 marks)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] A first accurate symptom or method of spread (e.g. swellings or buboes in the groin or armpits; fever; spread by fleas carried by black rats; travelled on trade ships and routes). [1] A second accurate, different symptom or method of spread.
(b) [1] Labour became scarce because so many died, so peasants could demand higher wages (supported by Source F: a hired man asked double). [1] Landowners tried to hold wages down, e.g. the Statute of Labourers in 1351, which angered peasants. [1] Serfdom weakened because peasants could leave for better pay and some lords let them pay rent instead of working for free; or the unrest led to the Peasants' Revolt of 1381 after the poll tax. [1] The change is linked to wider consequences or judged (e.g. changes were gradual, and not all peasants gained). [1] Communication: the paragraph is organised, with a clear opening point, linked sentences and a conclusion. [1] Communication: accurate historical terms (e.g. labour shortage, serf, wages, landowner) and evidence from Source F are used correctly.$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | D 9]]
Task 6: The Suez Crisis, 1956.

Background: In July 1956 the Egyptian president, Gamal Abdel Nasser, nationalised the Suez Canal, which was owned by a British and French company. In late October Israel invaded the Sinai Peninsula, and on 5 and 6 November British and French forces landed at Port Said. The United States did not support the invasion and a ceasefire was agreed within days.

Source G: an extract from a British newspaper editorial (imagined, written for this paper, early November 1956)
"The Canal is the artery of world trade. Colonel Nasser has seized it by force and threatens the oil on which our factories and homes depend. Britain and France cannot stand by while a dictator holds the world's shipping to ransom. Our troops go in to separate the fighting and to protect the waterway for every nation."

Source H: an extract from a radio broadcast (imagined, written for this paper, Cairo, November 1956)
"The Canal was dug by Egyptian hands, and Egyptian hands will hold it. The old empires have come again with their warships, hiding their greed behind the word protection. We will never again be ruled from London and Paris. The whole world sees who has attacked a free people."

(a) Identify two differences between the views of Source G and Source H about the Suez landings. (2 marks)

(b) Explain why Sources G and H give such different accounts of the same event. (3 marks)

(c) To what extent did the Suez Crisis show that Britain and France were no longer world powers? Use the sources and your own knowledge. (4 marks)

Total for Question 6: 9 marks$mq$, $mq$(a) [1] Source G sees the landings as protecting trade and separating the fighters; Source H sees them as an attack by old empires on a free people. [1] Source G describes Nasser as a dictator threatening world trade; Source H describes Egyptians defending a canal that belongs to them (or accept any other valid contrast about who is the aggressor).
(b) [1] The authors are from opposing sides: a British editor defends the British government, while a Cairo broadcaster supports Egypt. [1] The purposes differ: G aims to persuade British readers to back the invasion; H aims to rally Egyptians and win world sympathy. [1] Each uses selected evidence and loaded language, e.g. dictator and artery of world trade against greed and old empires.
(c) [1] A supported point for the view, e.g. they had to accept a ceasefire after United States pressure, including financial pressure on the pound. [1] A supported point against or qualifying, e.g. both still had large armed forces and nuclear weapons, and the military operation itself succeeded at first. [1] A clear judgement on the extent, e.g. the crisis showed they depended on the United States and could not act alone, so it marked a decline in power. [1] The judgement uses both sources or a precise fact (e.g. Source H's pride in resisting empire shows the growing power of new nations).$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | C 2 | D 10]]
Task 7: Rights and protest: extended response.

Statement: Non-violent protest was more effective than violent protest in winning rights during the twentieth century.

Evaluate this statement. Use specific examples that you have studied, such as the Montgomery bus boycott, the Salt March, the struggle against apartheid, or any other protest movement. You should:
- explain how non-violent protest achieved change,
- explain how violent or militant protest affected change,
- reach a supported judgement.

(a) Evaluate the statement. Your answer will be marked for your knowledge and evaluation (10 marks) and for the quality of your communication (2 marks). (12 marks)

Total for Question 7: 12 marks$mq$, $mq$(a) [1] Non-violent success is explained with a precise example (e.g. the Montgomery bus boycott 1955 to 1956 ended in a Supreme Court ruling that bus segregation was unlawful). [1] Further developed, e.g. non-violence won public sympathy and media attention (e.g. the Salt March in 1930, or the 1963 March on Washington leading to the Civil Rights Act of 1964). [1] A second distinct non-violent example, or evidence of limits (e.g. the Salt March did not bring independence directly; the process took until 1947). [1] Violent or militant protest is explained with a precise example (e.g. Umkhonto we Sizwe sabotage campaign from 1961 in South Africa; or the Algerian war of independence). [1] Effect of violence assessed, e.g. it forced governments to negotiate or drew international attention but also led to harsh repression and lost support. [1] A second developed point about violence, or a comparison of how governments responded to each approach. [1] Consideration of context, e.g. non-violence works best where there is a free press, courts or an electorate that can be moved, as in the USA or Britain's India. [1] Recognises combined or interacting factors, e.g. in South Africa armed resistance, mass protest, boycotts and sanctions together ended apartheid. [1] A clear, reasoned judgement about which was more effective. [1] The judgement is supported by weighing the evidence rather than listing it (e.g. explains why one factor mattered more). [1] Communication: a clear introduction, paragraphs and conclusion. [1] Communication: accurate historical vocabulary and precise dates, names and places.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- History MYP 5 eAssessment Paper B (7 tasks, 70 marks) (70 marks)
with sub as (select id from public.subjects where slug = $mq$history$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$History MYP 5 eAssessment Paper B (7 tasks, 70 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$History MYP 5 eAssessment Paper B (7 tasks, 70 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: The Mongol Empire and trade.

Source A: a timeline of selected events (compiled for this paper)
1206: Temujin is proclaimed Genghis Khan at a gathering of the Mongol tribes.
1227: Genghis Khan dies.
1260: Kublai Khan becomes Great Khan.
1271: Kublai Khan names his dynasty in China the Yuan.
1279: The Yuan complete the conquest of the Song dynasty.
1368: The Yuan dynasty is overthrown and the Ming dynasty begins.

(a) Show that Genghis Khan ruled as Great Khan for 21 years, using Source A. (1 mark)

(b) Describe what is meant by the Pax Mongolica. (2 marks)

(c) Explain why the Mongols were able to conquer such a large area in the thirteenth century. (3 marks)

(d) Explain how Mongol rule helped the growth of trade between China and the Middle East or Europe. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] 1227 - 1206 = 21 (the subtraction must be shown).
(b) [1] A period (roughly the thirteenth and fourteenth centuries) of relative peace and order across the lands the Mongols ruled in Asia and Europe. [1] Travel and trade were safer, e.g. along the Silk Road, with a relay post system (the yam) and protection for merchants and travellers.
(c) [1] Their army was made up of fast horse archers who could move quickly over long distances. [1] Discipline, organisation and tactics (such as feigned retreats and splitting the army into units) gave them an advantage. [1] They used captured engineers and siege weapons and used fear and terror to make cities surrender. Accept other accurate, developed reasons.
(d) [1] Law and order and the yam relay stations made journeys safer and faster. [1] Traders and travellers (such as merchants and envoys) were often protected and taxes were set, which encouraged long-distance trade, so goods and ideas such as silk, spices and paper-making moved more easily.$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 6 | B 5]]
Task 2: The Columbian Exchange.

Source B: examples of things that crossed the Atlantic after 1492 (compiled for this paper)
From the Americas to the Old World: potatoes, maize, tomatoes, tobacco.
From the Old World to the Americas: wheat, horses, cattle, sugar cane, smallpox.

Source C: the village of Hallowby (invented for this paper; the figures are not real statistics). Farmers in Hallowby began growing potatoes in 1700.
Year: 1600, 1700, 1800
Population: 800; 1,000; 1,800

(a) State two items from Source B that travelled from the Americas to the Old World. (2 marks)

(b) Calculate the percentage increase in the population of Hallowby between 1700 and 1800. (2 marks)

(c) Describe the change in the rate of population growth in Hallowby shown in Source C. (2 marks)

(d) A student says: Source C proves that potatoes caused the population of Hallowby to grow. Explain why the student's claim may not be justified. (3 marks)

(e) Explain one way in which the Columbian Exchange harmed Indigenous peoples of the Americas. (2 marks)

Total for Question 2: 11 marks$mq$, $mq$(a) [1] One correct item: potatoes, maize, tomatoes or tobacco. [1] A second correct item from the same list. (Do not accept items travelling the other way.)
(b) [1] Method: (1,800 - 1,000) / 1,000 x 100 (or 800 / 1,000). [1] 80%
(c) [1] Population grew slowly from 1600 to 1700 (25%, by 200 people). [1] Growth was much faster from 1700 to 1800 (80%, by 800 people), after potatoes were introduced.
(d) [1] The source shows a link in time but does not prove a cause. [1] Other factors could explain the rise, e.g. better medicine, fewer wars, other crops, or people moving in. [1] The figures are for one village and so cannot show what happened in other places.
(e) [1] Europeans brought diseases such as smallpox, measles and influenza, which Indigenous peoples had no immunity to. [1] Epidemics killed very large numbers and weakened societies, making conquest or loss of land easier (accept also forced labour or the loss of land to European farming).$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 7 | D 4]]
Task 3: The match workers' strike, London, 1888.

Background: In July 1888 about 1,400 women and girls who worked at the Bryant and May match factory in London went on strike. Many were paid low wages and handled white phosphorus, which could cause a painful disease of the jaw called phossy jaw. The two sources below are imagined and were written for this paper.

Source D: an extract from a newspaper article by a campaigning journalist (imagined, June 1888)
"They go to the factory at half past six, and they work until their fingers bleed for a few shillings a week. A girl is fined for a dirty floor or a late arrival, and her wages are cut. The phosphorus eats the jaws of those who breathe it every day. Is this not slavery in all but name? The public who strike the matches should know who pays for them."

Source E: an extract from a statement by a company director (imagined, July 1888)
"The company has always treated its workers fairly. Our wages are in line with those of other trades in the district, and the fines are small and are meant to keep the factory orderly. The stories about disease have been greatly exaggerated by outsiders who do not know our business. The girls have been led astray and will return to work."

(a) Identify the origin and purpose of Source E. (2 marks)

(b) Explain one way in which Source D is valuable for a historian studying working conditions in the 1880s. (3 marks)

(c) Explain one limitation of Source D. (2 marks)

(d) To what extent do Sources D and E together give a reliable picture of working conditions at the factory? Refer to the origin and purpose of both sources. (4 marks)

Total for Question 3: 11 marks$mq$, $mq$(a) [1] Origin: a statement by a company director, written in July 1888 during the strike. [1] Purpose: to defend the company's reputation and persuade the public that the strike was unjustified (and to encourage workers to return).
(b) [1] A valid value linked to content, e.g. it describes wages, fines and working hours and the risks of phosphorus. [1] Link to origin or purpose, e.g. a journalist investigating the factory had access to the workers' stories and wanted to expose bad conditions. [1] Developed explanation, e.g. it shows the concerns of reformers and helps explain why the strike gained public sympathy.
(c) [1] A valid limitation of the source, e.g. it is written by a campaigner who wants to shock readers and win support. [1] Explained, e.g. emotional words such as slavery may exaggerate, and a short extract may leave out the facts about the company's side or about better-paid workers.
(d) [1] Recognises that D and E disagree on wages, fines and disease. [1] Explains why D may be biased, with reference to the author and purpose. [1] Explains why E may be biased, with reference to the author and purpose (the director defends his company). [1] A supported judgement, e.g. neither is fully reliable alone, and the historian should check them against other evidence such as factory records, medical reports or workers' letters.$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 10]]
Task 4: Planning an investigation: Meiji Japan.

A student is investigating change in Japan after 1868. Some facts she has found:
- In 1868 the Emperor Meiji was restored to power and the rule of the shogun ended.
- In 1872 Japan's first railway opened between Tokyo and Yokohama.
- In 1872 the government introduced a plan for compulsory schooling, and in 1873 it introduced conscription into a national army.

(a) Write a focused research question about change in Japan after 1868 that the student could investigate. (1 mark)

(b) Write two sub-questions that the student could use to help answer her main research question. (2 marks)

(c) Choose one primary source and one secondary source the student could use. For each, explain how it would help her investigation. (4 marks)

(d) The student finds a set of photographs of Tokyo taken in 1880 showing trains, brick buildings and men in western clothes. Explain two problems with using these photographs as evidence about changes across the whole of Japan. (3 marks)

Total for Question 4: 10 marks$mq$, $mq$(a) [1] A clear, answerable question with a limited focus, e.g. How far did the Meiji government modernise Japan's army and economy between 1868 and 1890?
(b) [1] A relevant sub-question about one part of the main question (e.g. What changes were made to the army?). [1] A second, different relevant sub-question (e.g. How did railways and factories change the economy?).
(c) [1] A suitable primary source named (e.g. a government decree, a newspaper of the period, a photograph, or a diary). [1] Explanation of how the primary source helps, linked to the question. [1] A suitable secondary source named (e.g. a history book or a museum website). [1] Explanation of how the secondary source helps, e.g. it gives overview and interpretation by an expert.
(d) [1] Tokyo was the capital and the most modernised city, so the photographs may not show villages and the countryside. [1] Photographers chose what to photograph, so the images may show only modern scenes and leave out traditional life. [1] A single year cannot show how things changed over time without comparison with earlier evidence.$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | A 2 | C 6]]
Task 5: Hospital reform in the Crimean War.

Background: Florence Nightingale arrived at the British military hospital at Scutari in November 1854 with a team of 38 nurses. In March 1855 a government Sanitary Commission arrived to clean the hospital's drains and improve its ventilation.

Source F: figures for a military hospital (invented for this paper; they are not real statistics)
Month: patients admitted; deaths
January: 1,000; 420
February: 1,200; 480
March: 1,100; 110
April: 900; 63

(a) Calculate the percentage of patients who died in February and in April. Give both answers. (2 marks)

(b) Explain how Florence Nightingale and her colleagues helped to improve hospital care during and after the Crimean War. Use Source F and your own knowledge. Write in well-organised paragraphs. Marks are given for the quality of your historical writing as well as your knowledge. (6 marks)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] February: 480 / 1,200 x 100 = 40%. [1] April: 63 / 900 x 100 = 7%.
(b) [1] Immediate changes to the hospital, e.g. cleanliness, clean linen, better food and basic supplies, and nursing care for the sick. [1] The Sanitary Commission in March 1855 cleaned the sewers and improved ventilation, and Source F shows deaths falling (40% in February to 7% in April). [1] Longer-term changes, e.g. her use of statistics and diagrams to persuade officials; her book Notes on Nursing (1859); the nursing school at St Thomas' Hospital in 1860. [1] A balanced comment, e.g. the Commission's work may have mattered more than the nurses alone, or Nightingale's fame has made some historians credit her too much. [1] Communication: a clear structure with an introduction, linked points and a conclusion. [1] Communication: accurate vocabulary (e.g. sanitation, ventilation, mortality rate) with evidence from Source F used correctly.$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | D 10]]
Task 6: The Russian Revolution of 1917.

Background: In March 1917 Tsar Nicholas II gave up the throne and a Provisional Government took power. In October 1917 the Bolsheviks, led by Lenin, seized control in Petrograd. Their slogan was Peace, Land and Bread.

Source G: a Bolshevik poster (imagined, described for this paper, 1917)
Description: A soldier, a peasant and a factory worker march side by side under a red banner. The soldier carries a rifle pointed at the ground, the peasant holds a sheaf of wheat, and the worker holds a loaf of bread. The slogan across the top reads: PEACE. LAND. BREAD. ALL POWER TO THE SOVIETS.

Source H: a letter from a factory manager (imagined, written for this paper, Petrograd, November 1917)
"The new rulers promise bread and land to everyone, but they have no plan to produce either. Our workers' committees now want to run the factory. The Bolsheviks have taken power by force in the middle of a war, and I fear that the promises will be forgotten once their rivals are crushed."

(a) Explain how the poster in Source G was designed to appeal to three different groups. (3 marks)

(b) Explain why the view of the Bolsheviks in Source H is different from the view in Source G. (3 marks)

(c) How far do Sources G and H, together with your own knowledge, explain why the Bolsheviks were able to seize power in October 1917? Give a supported judgement. (4 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) [1] The soldier (rifle pointed down) is linked to the promise of peace and ending the war. [1] The peasant (wheat) is linked to the promise of land. [1] The worker (bread) is linked to the promise of bread, and the slogan All Power to the Soviets presents workers' councils as the way to hold power for all three groups.
(b) [1] Source G was made by the Bolsheviks to win support, so it shows only the attractive promises. [1] Source H is written by a factory manager who fears losing control of his business to workers' committees, so he is hostile. [1] Source H is also a private letter reflecting a middle-class view in the capital, while Source G is public propaganda aimed at ordinary workers, peasants and soldiers.
(c) [1] Uses Source G or own knowledge to show the appeal of the slogans after war losses, food shortages and the weakness of the Provisional Government. [1] Uses Source H or own knowledge to show opposition or that power was taken by force, e.g. a small, organised party seized key buildings in Petrograd. [1] Adds another relevant factor, e.g. Lenin's leadership; Trotsky's organisation of the Military Revolutionary Committee; the Provisional Government's decision to continue the war. [1] A clear judgement about the relative importance of the factors.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | C 2 | D 10]]
Task 7: Independence and national identity: extended response.

Statement: The most important reason independence movements succeeded in the twentieth century was strong leadership.

Evaluate this statement. Use specific examples that you have studied, such as India, Ghana, Algeria, Kenya or Indonesia. You should:
- explain how leaders helped independence movements,
- explain at least one other factor (for example mass support, outside pressure or the weakness of the colonial power),
- reach a supported judgement.

(a) Evaluate the statement. Your answer will be marked for your knowledge and evaluation (10 marks) and for the quality of your communication (2 marks). (12 marks)

Total for Question 7: 12 marks$mq$, $mq$(a) [1] Leadership is explained with a precise example (e.g. Kwame Nkrumah and the Convention People's Party in the Gold Coast, leading to Ghana's independence in 1957). [1] Developed with how leaders organised, inspired or negotiated (e.g. Gandhi's campaigns; Ho Chi Minh and the Viet Minh; Sukarno). [1] A second distinct example of leadership or an assessment of its limits (e.g. leaders were often divided, as in India with Congress and the Muslim League). [1] Mass support and organisation are explained with an example (e.g. strikes, boycotts and protests in the Gold Coast; peasant support in the Algerian war). [1] The weakness of colonial powers after the Second World War is explained (e.g. Britain and France were weakened economically and under pressure from the United States and the United Nations). [1] Another factor developed, e.g. armed struggle (Algeria's FLN; the Mau Mau in Kenya) or the spread of nationalist ideas. [1] The role of the colonial power's response is considered (e.g. negotiation in Ghana against war in Algeria). [1] Links are made between factors, e.g. leadership mattered because it organised mass support at a time when empires were weak. [1] A clear judgement about which factor was most important. [1] The judgement is justified by weighing at least two factors. [1] Communication: a clear introduction, structured paragraphs and a conclusion. [1] Communication: accurate vocabulary and precise facts (dates, names, places).$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);
commit;
