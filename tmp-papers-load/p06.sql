begin;
-- Interdisciplinary Learning MYP 5 eAssessment Paper A (7 tasks, 78 marks) (78 marks)
with sub as (select id from public.subjects where slug = $mq$interdisciplinary-learning$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Interdisciplinary Learning MYP 5 eAssessment Paper A (7 tasks, 78 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Interdisciplinary Learning MYP 5 eAssessment Paper A (7 tasks, 78 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: Identifying disciplines and reading data
THEME: Harbourfield - feeding a city without wasting it
Harbourfield is a fictional port city of 240,000 people living in 96,000 households. The council wants to cut the amount of food waste sent to landfill. Read Sources A to H, which come from different fields of study, and use them to answer the tasks.

Source A: Waste audit (Harbourfield Waste Authority). Food waste sent to landfill in one year, by source
Source: tonnes per year
Households: 21 600
Restaurants and cafes: 7 200
Supermarkets: 3 600
Schools and offices: 2 400
Food markets: 1 200
Total: 36 000

Source B: Science note (Harbourfield University, Environmental Science Group), "What happens to wasted food?"
"When food waste is buried in landfill there is very little oxygen. Bacteria that live without oxygen break the food down and release methane. Methane traps about 28 times as much heat as carbon dioxide over 100 years, so emissions are reported as carbon dioxide equivalent (CO2e): 1 kg of methane counts as 28 kg CO2e. Our measurements show that each tonne of food waste in landfill releases 60 kg of methane. If food waste is sent to a sealed anaerobic digester instead, the methane is captured and burned. The process then causes only 0.1 tonnes CO2e per tonne of food waste and produces 120 kWh of electricity per tonne. In an open compost heap there is plenty of air, so microorganisms carry out aerobic respiration and release carbon dioxide and water; very little methane forms. Separately, food kept between 8 C and 63 C allows bacteria to multiply quickly, because some species divide about every 20 minutes."

Source C: Cost report (Harbourfield Chamber of Commerce). Costs per tonne of food waste, in pounds (GBP)
Landfill disposal including landfill tax: 95
Separate household collection: 48
Anaerobic digestion treatment: 70
Electricity from digestion: 120 kWh per tonne, sold at 0.12 per kWh
Assumed participation in a citywide household scheme: 55% of household food waste collected
(Set-up costs of bins and vehicles are covered by a government grant.)

Source D: Newspaper extract (Harbourfield Gazette), "The bin that smells of progress"
"Over six months, 4 000 homes in Eastside tested a weekly food waste collection. 3 100 households took part. 'Cooking smells and flies in summer were the biggest complaint,' said trial manager Jo Reyes, 'but most people got used to the kitchen caddy within a month.' Many Eastside residents volunteered for the trial, and the area has more houses with gardens than the rest of the city. Alan Price, who lives in a flat in Central Harbourfield, said: 'I have no room for another bin.' A Food Standards officer reminded readers that 'use by' dates are about safety, while 'best before' dates are about quality."

Source E: Infographic shown as a table. "Why households throw food away" (Harbourfield Household Survey, 1 200 households, one main reason each)
Went off before it was eaten: 34%
Cooked or served too much: 28%
Past the date on the label: 22%
Did not like it: 9%
Other reasons: 7%

Source F: Interview transcript (Harbourfield Radio), Daria Okoye, owner of the Salt and Pepper Cafe
Interviewer: How much food do you throw away?
Daria: About 18 kilograms on a typical day, mostly vegetable peelings and plate leftovers. Before I joined SaveBite it was nearer 26. Customers reserve our unsold sandwiches and soups at 5 pm for half price.
Interviewer: Why don't more owners join?
Daria: Three things. Staff time, because we have to pack the food. The app takes 30% commission. And fear. Owners worry that if someone is ill after eating leftover food they will be blamed. Soup must be cooled quickly and kept in the fridge, or kept hot, otherwise bacteria grow. My staff rule is: never leave it on the counter.
Interviewer: What would help?
Daria: Clear guidance from the council, and maybe a small grant for fridges. But honestly, the biggest waste is in people's homes, not in my cafe.

Source G: Advert (SaveBite app)
"SaveBite - tonight's food at half the price, zero waste! Over 100 000 meals rescued in two years! Join 120 partner restaurants and cafes. Each rescued meal saves 2.5 kg of CO2! (Average rescued meal: 400 g of food.) Download free today, because every bite counts." Small print: partner businesses pay 30% commission on each sale.

Source H: Policy extract (Harbourfield Council, Climate Plan: Food Waste Strategy)
1. Cut food waste sent to landfill by 50% of today's 36 000 tonnes by 2032.
2. The net extra running cost to the council must not exceed 150 000 pounds per year.
3. Household charges must not rise by more than 5 pounds per household per year.
4. Services must work for flats as well as houses.
5. Progress will be reviewed every two years.

(a) Name the main field of study (for example geography, a science, economics, mathematics, sociology) that each of Sources A, B, C and E draws on. Give one field for each source. (4 marks)
(b) Calculate the percentage of the city's landfill food waste that comes from households. Show your working. (2 marks)
(c) Use Source E to state the two most common reasons households give for throwing food away, with their percentages. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$[1] Source A: geography / environmental studies / mathematics (data handling)
[1] Source B: sciences (environmental science, biology or chemistry)
[1] Source C: economics (Individuals and societies)
[1] Source E: sociology / psychology / mathematics (survey data). One field per source; the field must fit the content of that source.
[1] 21 600 / 36 000 (x 100)
[1] 60%
[1] Went off before it was eaten, 34%
[1] Cooked or served too much, 28%$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 9 | B 2]]
Task 2: Applying scientific and economic ideas
THEME: Harbourfield - feeding a city without wasting it
Harbourfield is a fictional port city of 240,000 people living in 96,000 households. The council wants to cut the amount of food waste sent to landfill. Read Sources A to H, which come from different fields of study, and use them to answer the tasks.

Source A: Waste audit (Harbourfield Waste Authority). Food waste sent to landfill in one year, by source
Source: tonnes per year
Households: 21 600
Restaurants and cafes: 7 200
Supermarkets: 3 600
Schools and offices: 2 400
Food markets: 1 200
Total: 36 000

Source B: Science note (Harbourfield University, Environmental Science Group), "What happens to wasted food?"
"When food waste is buried in landfill there is very little oxygen. Bacteria that live without oxygen break the food down and release methane. Methane traps about 28 times as much heat as carbon dioxide over 100 years, so emissions are reported as carbon dioxide equivalent (CO2e): 1 kg of methane counts as 28 kg CO2e. Our measurements show that each tonne of food waste in landfill releases 60 kg of methane. If food waste is sent to a sealed anaerobic digester instead, the methane is captured and burned. The process then causes only 0.1 tonnes CO2e per tonne of food waste and produces 120 kWh of electricity per tonne. In an open compost heap there is plenty of air, so microorganisms carry out aerobic respiration and release carbon dioxide and water; very little methane forms. Separately, food kept between 8 C and 63 C allows bacteria to multiply quickly, because some species divide about every 20 minutes."

Source C: Cost report (Harbourfield Chamber of Commerce). Costs per tonne of food waste, in pounds (GBP)
Landfill disposal including landfill tax: 95
Separate household collection: 48
Anaerobic digestion treatment: 70
Electricity from digestion: 120 kWh per tonne, sold at 0.12 per kWh
Assumed participation in a citywide household scheme: 55% of household food waste collected
(Set-up costs of bins and vehicles are covered by a government grant.)

Source D: Newspaper extract (Harbourfield Gazette), "The bin that smells of progress"
"Over six months, 4 000 homes in Eastside tested a weekly food waste collection. 3 100 households took part. 'Cooking smells and flies in summer were the biggest complaint,' said trial manager Jo Reyes, 'but most people got used to the kitchen caddy within a month.' Many Eastside residents volunteered for the trial, and the area has more houses with gardens than the rest of the city. Alan Price, who lives in a flat in Central Harbourfield, said: 'I have no room for another bin.' A Food Standards officer reminded readers that 'use by' dates are about safety, while 'best before' dates are about quality."

Source E: Infographic shown as a table. "Why households throw food away" (Harbourfield Household Survey, 1 200 households, one main reason each)
Went off before it was eaten: 34%
Cooked or served too much: 28%
Past the date on the label: 22%
Did not like it: 9%
Other reasons: 7%

Source F: Interview transcript (Harbourfield Radio), Daria Okoye, owner of the Salt and Pepper Cafe
Interviewer: How much food do you throw away?
Daria: About 18 kilograms on a typical day, mostly vegetable peelings and plate leftovers. Before I joined SaveBite it was nearer 26. Customers reserve our unsold sandwiches and soups at 5 pm for half price.
Interviewer: Why don't more owners join?
Daria: Three things. Staff time, because we have to pack the food. The app takes 30% commission. And fear. Owners worry that if someone is ill after eating leftover food they will be blamed. Soup must be cooled quickly and kept in the fridge, or kept hot, otherwise bacteria grow. My staff rule is: never leave it on the counter.
Interviewer: What would help?
Daria: Clear guidance from the council, and maybe a small grant for fridges. But honestly, the biggest waste is in people's homes, not in my cafe.

Source G: Advert (SaveBite app)
"SaveBite - tonight's food at half the price, zero waste! Over 100 000 meals rescued in two years! Join 120 partner restaurants and cafes. Each rescued meal saves 2.5 kg of CO2! (Average rescued meal: 400 g of food.) Download free today, because every bite counts." Small print: partner businesses pay 30% commission on each sale.

Source H: Policy extract (Harbourfield Council, Climate Plan: Food Waste Strategy)
1. Cut food waste sent to landfill by 50% of today's 36 000 tonnes by 2032.
2. The net extra running cost to the council must not exceed 150 000 pounds per year.
3. Household charges must not rise by more than 5 pounds per household per year.
4. Services must work for flats as well as houses.
5. Progress will be reviewed every two years.

(a) Source B. Calculate the carbon dioxide equivalent released when 11 880 tonnes of food waste is buried in landfill. Show your working. (3 marks)
(b) The same 11 880 tonnes are sent to an anaerobic digester instead. Calculate the carbon dioxide equivalent saved compared with landfill. (3 marks)
(c) Explain why food buried in landfill releases methane, but food in an open compost heap releases mainly carbon dioxide. (3 marks)
(d) Use Sources B and C to calculate the net extra cost, per tonne of food waste, of collecting and digesting it instead of using landfill, and then the net extra cost per tonne of CO2e avoided. (2 marks)

Total for Question 2: 11 marks$mq$, $mq$[1] 60 kg methane x 28 = 1 680 kg CO2e = 1.68 tonnes CO2e per tonne of food waste
[1] 11 880 x 1.68
[1] 19 958 tonnes CO2e (accept 19 958.4 or 20 000 to 2 s.f.)
[1] Digestion emissions: 11 880 x 0.1 = 1 188 tonnes CO2e
[1] Saving = 19 958.4 - 1 188
[1] 18 770 tonnes CO2e (accept 18 770.4; also accept 1.58 x 11 880)
[1] Landfill has very little oxygen, so decomposition is anaerobic (bacteria that do not use oxygen)
[1] Anaerobic breakdown produces methane
[1] An open compost heap has plenty of air, so microorganisms use oxygen in aerobic respiration, producing carbon dioxide and water
[1] Net extra cost per tonne = (48 + 70) - 95 - (120 x 0.12 = 14.40) = 8.60 pounds
[1] 8.60 / 1.58 tonnes CO2e avoided per tonne = about 5.44 pounds per tonne CO2e$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 9]]
Task 3: Applying biology, social science and mathematics
THEME: Harbourfield - feeding a city without wasting it
Harbourfield is a fictional port city of 240,000 people living in 96,000 households. The council wants to cut the amount of food waste sent to landfill. Read Sources A to H, which come from different fields of study, and use them to answer the tasks.

Source A: Waste audit (Harbourfield Waste Authority). Food waste sent to landfill in one year, by source
Source: tonnes per year
Households: 21 600
Restaurants and cafes: 7 200
Supermarkets: 3 600
Schools and offices: 2 400
Food markets: 1 200
Total: 36 000

Source B: Science note (Harbourfield University, Environmental Science Group), "What happens to wasted food?"
"When food waste is buried in landfill there is very little oxygen. Bacteria that live without oxygen break the food down and release methane. Methane traps about 28 times as much heat as carbon dioxide over 100 years, so emissions are reported as carbon dioxide equivalent (CO2e): 1 kg of methane counts as 28 kg CO2e. Our measurements show that each tonne of food waste in landfill releases 60 kg of methane. If food waste is sent to a sealed anaerobic digester instead, the methane is captured and burned. The process then causes only 0.1 tonnes CO2e per tonne of food waste and produces 120 kWh of electricity per tonne. In an open compost heap there is plenty of air, so microorganisms carry out aerobic respiration and release carbon dioxide and water; very little methane forms. Separately, food kept between 8 C and 63 C allows bacteria to multiply quickly, because some species divide about every 20 minutes."

Source C: Cost report (Harbourfield Chamber of Commerce). Costs per tonne of food waste, in pounds (GBP)
Landfill disposal including landfill tax: 95
Separate household collection: 48
Anaerobic digestion treatment: 70
Electricity from digestion: 120 kWh per tonne, sold at 0.12 per kWh
Assumed participation in a citywide household scheme: 55% of household food waste collected
(Set-up costs of bins and vehicles are covered by a government grant.)

Source D: Newspaper extract (Harbourfield Gazette), "The bin that smells of progress"
"Over six months, 4 000 homes in Eastside tested a weekly food waste collection. 3 100 households took part. 'Cooking smells and flies in summer were the biggest complaint,' said trial manager Jo Reyes, 'but most people got used to the kitchen caddy within a month.' Many Eastside residents volunteered for the trial, and the area has more houses with gardens than the rest of the city. Alan Price, who lives in a flat in Central Harbourfield, said: 'I have no room for another bin.' A Food Standards officer reminded readers that 'use by' dates are about safety, while 'best before' dates are about quality."

Source E: Infographic shown as a table. "Why households throw food away" (Harbourfield Household Survey, 1 200 households, one main reason each)
Went off before it was eaten: 34%
Cooked or served too much: 28%
Past the date on the label: 22%
Did not like it: 9%
Other reasons: 7%

Source F: Interview transcript (Harbourfield Radio), Daria Okoye, owner of the Salt and Pepper Cafe
Interviewer: How much food do you throw away?
Daria: About 18 kilograms on a typical day, mostly vegetable peelings and plate leftovers. Before I joined SaveBite it was nearer 26. Customers reserve our unsold sandwiches and soups at 5 pm for half price.
Interviewer: Why don't more owners join?
Daria: Three things. Staff time, because we have to pack the food. The app takes 30% commission. And fear. Owners worry that if someone is ill after eating leftover food they will be blamed. Soup must be cooled quickly and kept in the fridge, or kept hot, otherwise bacteria grow. My staff rule is: never leave it on the counter.
Interviewer: What would help?
Daria: Clear guidance from the council, and maybe a small grant for fridges. But honestly, the biggest waste is in people's homes, not in my cafe.

Source G: Advert (SaveBite app)
"SaveBite - tonight's food at half the price, zero waste! Over 100 000 meals rescued in two years! Join 120 partner restaurants and cafes. Each rescued meal saves 2.5 kg of CO2! (Average rescued meal: 400 g of food.) Download free today, because every bite counts." Small print: partner businesses pay 30% commission on each sale.

Source H: Policy extract (Harbourfield Council, Climate Plan: Food Waste Strategy)
1. Cut food waste sent to landfill by 50% of today's 36 000 tonnes by 2032.
2. The net extra running cost to the council must not exceed 150 000 pounds per year.
3. Household charges must not rise by more than 5 pounds per household per year.
4. Services must work for flats as well as houses.
5. Progress will be reviewed every two years.

(a) Source F describes the rule 'never leave it on the counter'. Use Source B to explain why food must be kept cold or hot, not at room temperature. (3 marks)
(b) 22% of households in Source E throw food away because it is past the date on the label. Use Source D to explain why this may be a misunderstanding, and what it leads to. (3 marks)
(c) If supermarkets cut their landfill food waste in Source A by 25%, calculate how many tonnes this saves and what percentage of the city's total food waste this is. (3 marks)

Total for Question 3: 9 marks$mq$, $mq$[1] Bacteria multiply fastest between 8 C and 63 C (some divide every 20 minutes), so room temperature is in this range
[1] A fridge (below 8 C) slows their growth because the chemical reactions controlled by their enzymes are slower at low temperature
[1] Keeping food hot, above 63 C, stops bacteria multiplying (heat denatures their enzymes)
[1] 'Best before' dates are about quality, not safety
[1] Only 'use by' dates relate to safety, so food past a 'best before' date may still be safe to eat
[1] People who treat all dates the same throw away edible food, adding to waste
[1] 25% of 3 600 = 900 tonnes
[1] 900 / 36 000 (x 100)
[1] 2.5%$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 12]]
Task 4: Synthesising evidence to test a scheme against policy
THEME: Harbourfield - feeding a city without wasting it
Harbourfield is a fictional port city of 240,000 people living in 96,000 households. The council wants to cut the amount of food waste sent to landfill. Read Sources A to H, which come from different fields of study, and use them to answer the tasks.

Source A: Waste audit (Harbourfield Waste Authority). Food waste sent to landfill in one year, by source
Source: tonnes per year
Households: 21 600
Restaurants and cafes: 7 200
Supermarkets: 3 600
Schools and offices: 2 400
Food markets: 1 200
Total: 36 000

Source B: Science note (Harbourfield University, Environmental Science Group), "What happens to wasted food?"
"When food waste is buried in landfill there is very little oxygen. Bacteria that live without oxygen break the food down and release methane. Methane traps about 28 times as much heat as carbon dioxide over 100 years, so emissions are reported as carbon dioxide equivalent (CO2e): 1 kg of methane counts as 28 kg CO2e. Our measurements show that each tonne of food waste in landfill releases 60 kg of methane. If food waste is sent to a sealed anaerobic digester instead, the methane is captured and burned. The process then causes only 0.1 tonnes CO2e per tonne of food waste and produces 120 kWh of electricity per tonne. In an open compost heap there is plenty of air, so microorganisms carry out aerobic respiration and release carbon dioxide and water; very little methane forms. Separately, food kept between 8 C and 63 C allows bacteria to multiply quickly, because some species divide about every 20 minutes."

Source C: Cost report (Harbourfield Chamber of Commerce). Costs per tonne of food waste, in pounds (GBP)
Landfill disposal including landfill tax: 95
Separate household collection: 48
Anaerobic digestion treatment: 70
Electricity from digestion: 120 kWh per tonne, sold at 0.12 per kWh
Assumed participation in a citywide household scheme: 55% of household food waste collected
(Set-up costs of bins and vehicles are covered by a government grant.)

Source D: Newspaper extract (Harbourfield Gazette), "The bin that smells of progress"
"Over six months, 4 000 homes in Eastside tested a weekly food waste collection. 3 100 households took part. 'Cooking smells and flies in summer were the biggest complaint,' said trial manager Jo Reyes, 'but most people got used to the kitchen caddy within a month.' Many Eastside residents volunteered for the trial, and the area has more houses with gardens than the rest of the city. Alan Price, who lives in a flat in Central Harbourfield, said: 'I have no room for another bin.' A Food Standards officer reminded readers that 'use by' dates are about safety, while 'best before' dates are about quality."

Source E: Infographic shown as a table. "Why households throw food away" (Harbourfield Household Survey, 1 200 households, one main reason each)
Went off before it was eaten: 34%
Cooked or served too much: 28%
Past the date on the label: 22%
Did not like it: 9%
Other reasons: 7%

Source F: Interview transcript (Harbourfield Radio), Daria Okoye, owner of the Salt and Pepper Cafe
Interviewer: How much food do you throw away?
Daria: About 18 kilograms on a typical day, mostly vegetable peelings and plate leftovers. Before I joined SaveBite it was nearer 26. Customers reserve our unsold sandwiches and soups at 5 pm for half price.
Interviewer: Why don't more owners join?
Daria: Three things. Staff time, because we have to pack the food. The app takes 30% commission. And fear. Owners worry that if someone is ill after eating leftover food they will be blamed. Soup must be cooled quickly and kept in the fridge, or kept hot, otherwise bacteria grow. My staff rule is: never leave it on the counter.
Interviewer: What would help?
Daria: Clear guidance from the council, and maybe a small grant for fridges. But honestly, the biggest waste is in people's homes, not in my cafe.

Source G: Advert (SaveBite app)
"SaveBite - tonight's food at half the price, zero waste! Over 100 000 meals rescued in two years! Join 120 partner restaurants and cafes. Each rescued meal saves 2.5 kg of CO2! (Average rescued meal: 400 g of food.) Download free today, because every bite counts." Small print: partner businesses pay 30% commission on each sale.

Source H: Policy extract (Harbourfield Council, Climate Plan: Food Waste Strategy)
1. Cut food waste sent to landfill by 50% of today's 36 000 tonnes by 2032.
2. The net extra running cost to the council must not exceed 150 000 pounds per year.
3. Household charges must not rise by more than 5 pounds per household per year.
4. Services must work for flats as well as houses.
5. Progress will be reviewed every two years.

(a) Use two sources to explain why households are the most important group to target. (3 marks)
(b) Source C assumes 55% participation in a household scheme, but Source D reports 3 100 of 4 000 homes (77.5%) took part in the trial. Explain why the two figures may differ and which is more suitable for planning the whole city. (3 marks)
(c) The council target in Source H is a 50% cut in landfill food waste. Calculate the tonnage the target requires. Then calculate the tonnage diverted by a household scheme at 55% and at 77.5% participation, and compare each with the target. (4 marks)
(d) At 77.5% participation, calculate the net extra annual cost to the council (using 8.60 pounds per tonne) and decide whether it meets policy points 2 and 3 in Source H. (2 marks)

Total for Question 4: 12 marks$mq$, $mq$[1] Source A: households produce 21 600 of 36 000 tonnes (60%), the largest share
[1] Source E / F: most waste comes from avoidable habits at home (over-cooking, food going off) and the cafe owner says the biggest waste is in homes
[1] Links the two to a clear conclusion that a household scheme gives the biggest possible reduction
[1] 3 100 / 4 000 = 77.5% (the trial figure is higher)
[1] Trial households volunteered and have gardens, so they may be more willing or able than the whole city (including flats)
[1] A cautious planner would use 55% or test a wider sample; a range of 55% to 77.5% is a sensible way to plan
[1] Target: 50% of 36 000 = 18 000 tonnes
[1] 55%: 0.55 x 21 600 = 11 880 tonnes (33% of the city total)
[1] 77.5%: 0.775 x 21 600 = 16 740 tonnes (46.5% of the city total)
[1] Neither reaches 18 000 tonnes, so other sources (for example supermarkets, restaurants, schools) must also be reduced
[1] 16 740 x 8.60 = 143 964 pounds, which is below 150 000 (point 2 met)
[1] 143 964 / 96 000 = about 1.50 pounds per household, below the 5 pound limit (point 3 met)$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | B 12]]
Task 5: Evaluating sources and claims
THEME: Harbourfield - feeding a city without wasting it
Harbourfield is a fictional port city of 240,000 people living in 96,000 households. The council wants to cut the amount of food waste sent to landfill. Read Sources A to H, which come from different fields of study, and use them to answer the tasks.

Source A: Waste audit (Harbourfield Waste Authority). Food waste sent to landfill in one year, by source
Source: tonnes per year
Households: 21 600
Restaurants and cafes: 7 200
Supermarkets: 3 600
Schools and offices: 2 400
Food markets: 1 200
Total: 36 000

Source B: Science note (Harbourfield University, Environmental Science Group), "What happens to wasted food?"
"When food waste is buried in landfill there is very little oxygen. Bacteria that live without oxygen break the food down and release methane. Methane traps about 28 times as much heat as carbon dioxide over 100 years, so emissions are reported as carbon dioxide equivalent (CO2e): 1 kg of methane counts as 28 kg CO2e. Our measurements show that each tonne of food waste in landfill releases 60 kg of methane. If food waste is sent to a sealed anaerobic digester instead, the methane is captured and burned. The process then causes only 0.1 tonnes CO2e per tonne of food waste and produces 120 kWh of electricity per tonne. In an open compost heap there is plenty of air, so microorganisms carry out aerobic respiration and release carbon dioxide and water; very little methane forms. Separately, food kept between 8 C and 63 C allows bacteria to multiply quickly, because some species divide about every 20 minutes."

Source C: Cost report (Harbourfield Chamber of Commerce). Costs per tonne of food waste, in pounds (GBP)
Landfill disposal including landfill tax: 95
Separate household collection: 48
Anaerobic digestion treatment: 70
Electricity from digestion: 120 kWh per tonne, sold at 0.12 per kWh
Assumed participation in a citywide household scheme: 55% of household food waste collected
(Set-up costs of bins and vehicles are covered by a government grant.)

Source D: Newspaper extract (Harbourfield Gazette), "The bin that smells of progress"
"Over six months, 4 000 homes in Eastside tested a weekly food waste collection. 3 100 households took part. 'Cooking smells and flies in summer were the biggest complaint,' said trial manager Jo Reyes, 'but most people got used to the kitchen caddy within a month.' Many Eastside residents volunteered for the trial, and the area has more houses with gardens than the rest of the city. Alan Price, who lives in a flat in Central Harbourfield, said: 'I have no room for another bin.' A Food Standards officer reminded readers that 'use by' dates are about safety, while 'best before' dates are about quality."

Source E: Infographic shown as a table. "Why households throw food away" (Harbourfield Household Survey, 1 200 households, one main reason each)
Went off before it was eaten: 34%
Cooked or served too much: 28%
Past the date on the label: 22%
Did not like it: 9%
Other reasons: 7%

Source F: Interview transcript (Harbourfield Radio), Daria Okoye, owner of the Salt and Pepper Cafe
Interviewer: How much food do you throw away?
Daria: About 18 kilograms on a typical day, mostly vegetable peelings and plate leftovers. Before I joined SaveBite it was nearer 26. Customers reserve our unsold sandwiches and soups at 5 pm for half price.
Interviewer: Why don't more owners join?
Daria: Three things. Staff time, because we have to pack the food. The app takes 30% commission. And fear. Owners worry that if someone is ill after eating leftover food they will be blamed. Soup must be cooled quickly and kept in the fridge, or kept hot, otherwise bacteria grow. My staff rule is: never leave it on the counter.
Interviewer: What would help?
Daria: Clear guidance from the council, and maybe a small grant for fridges. But honestly, the biggest waste is in people's homes, not in my cafe.

Source G: Advert (SaveBite app)
"SaveBite - tonight's food at half the price, zero waste! Over 100 000 meals rescued in two years! Join 120 partner restaurants and cafes. Each rescued meal saves 2.5 kg of CO2! (Average rescued meal: 400 g of food.) Download free today, because every bite counts." Small print: partner businesses pay 30% commission on each sale.

Source H: Policy extract (Harbourfield Council, Climate Plan: Food Waste Strategy)
1. Cut food waste sent to landfill by 50% of today's 36 000 tonnes by 2032.
2. The net extra running cost to the council must not exceed 150 000 pounds per year.
3. Household charges must not rise by more than 5 pounds per household per year.
4. Services must work for flats as well as houses.
5. Progress will be reviewed every two years.

(a) Identify two features of Source G that show it is an advert rather than a neutral report. (2 marks)
(b) Source G claims 'each rescued meal saves 2.5 kg of CO2'. Use Source B and the meal mass in Source G to test this claim. (4 marks)
(c) Give two limits to relying on voluntary schemes like SaveBite to cut restaurant waste, using evidence from Source F. (3 marks)
(d) SaveBite says it has rescued 100 000 meals. Convert this to tonnes and compare it with the restaurant and cafe waste in Source A. (3 marks)

Total for Question 5: 12 marks$mq$, $mq$[1] Persuasive or emotional language (for example 'zero waste', 'every bite counts') or exclamation marks
[1] Selected positive figures with no method or source; the commission is only in small print (accept a call to action 'Download free today')
[1] 400 g meal = 0.4 kg of food
[1] Landfill releases 1.68 kg CO2e per kg of food, so 0.4 x 1.68 = about 0.67 kg CO2e
[1] The claim is nearly 4 times higher (2.5 / 0.67 = about 3.7)
[1] The claim may include emissions from growing and transporting the food, which Source B does not count, but the advert does not show its method or source
[1] Cost and effort: staff time to pack food and 30% commission
[1] Fear of blame if customers become ill
[1] Links limits to the low take-up (only 120 businesses in the advert) or the need for council guidance. Award a mark for each limit with evidence, and one for the link.
[1] 100 000 x 0.4 kg = 40 000 kg = 40 tonnes
[1] 40 / 7 200 x 100 = about 0.56%
[1] Conclusion: a very small share, so the app alone cannot solve the problem (accept 'about 0.6%')$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 14]]
Task 6: Communicating a recommendation
THEME: Harbourfield - feeding a city without wasting it
Harbourfield is a fictional port city of 240,000 people living in 96,000 households. The council wants to cut the amount of food waste sent to landfill. Read Sources A to H, which come from different fields of study, and use them to answer the tasks.

Source A: Waste audit (Harbourfield Waste Authority). Food waste sent to landfill in one year, by source
Source: tonnes per year
Households: 21 600
Restaurants and cafes: 7 200
Supermarkets: 3 600
Schools and offices: 2 400
Food markets: 1 200
Total: 36 000

Source B: Science note (Harbourfield University, Environmental Science Group), "What happens to wasted food?"
"When food waste is buried in landfill there is very little oxygen. Bacteria that live without oxygen break the food down and release methane. Methane traps about 28 times as much heat as carbon dioxide over 100 years, so emissions are reported as carbon dioxide equivalent (CO2e): 1 kg of methane counts as 28 kg CO2e. Our measurements show that each tonne of food waste in landfill releases 60 kg of methane. If food waste is sent to a sealed anaerobic digester instead, the methane is captured and burned. The process then causes only 0.1 tonnes CO2e per tonne of food waste and produces 120 kWh of electricity per tonne. In an open compost heap there is plenty of air, so microorganisms carry out aerobic respiration and release carbon dioxide and water; very little methane forms. Separately, food kept between 8 C and 63 C allows bacteria to multiply quickly, because some species divide about every 20 minutes."

Source C: Cost report (Harbourfield Chamber of Commerce). Costs per tonne of food waste, in pounds (GBP)
Landfill disposal including landfill tax: 95
Separate household collection: 48
Anaerobic digestion treatment: 70
Electricity from digestion: 120 kWh per tonne, sold at 0.12 per kWh
Assumed participation in a citywide household scheme: 55% of household food waste collected
(Set-up costs of bins and vehicles are covered by a government grant.)

Source D: Newspaper extract (Harbourfield Gazette), "The bin that smells of progress"
"Over six months, 4 000 homes in Eastside tested a weekly food waste collection. 3 100 households took part. 'Cooking smells and flies in summer were the biggest complaint,' said trial manager Jo Reyes, 'but most people got used to the kitchen caddy within a month.' Many Eastside residents volunteered for the trial, and the area has more houses with gardens than the rest of the city. Alan Price, who lives in a flat in Central Harbourfield, said: 'I have no room for another bin.' A Food Standards officer reminded readers that 'use by' dates are about safety, while 'best before' dates are about quality."

Source E: Infographic shown as a table. "Why households throw food away" (Harbourfield Household Survey, 1 200 households, one main reason each)
Went off before it was eaten: 34%
Cooked or served too much: 28%
Past the date on the label: 22%
Did not like it: 9%
Other reasons: 7%

Source F: Interview transcript (Harbourfield Radio), Daria Okoye, owner of the Salt and Pepper Cafe
Interviewer: How much food do you throw away?
Daria: About 18 kilograms on a typical day, mostly vegetable peelings and plate leftovers. Before I joined SaveBite it was nearer 26. Customers reserve our unsold sandwiches and soups at 5 pm for half price.
Interviewer: Why don't more owners join?
Daria: Three things. Staff time, because we have to pack the food. The app takes 30% commission. And fear. Owners worry that if someone is ill after eating leftover food they will be blamed. Soup must be cooled quickly and kept in the fridge, or kept hot, otherwise bacteria grow. My staff rule is: never leave it on the counter.
Interviewer: What would help?
Daria: Clear guidance from the council, and maybe a small grant for fridges. But honestly, the biggest waste is in people's homes, not in my cafe.

Source G: Advert (SaveBite app)
"SaveBite - tonight's food at half the price, zero waste! Over 100 000 meals rescued in two years! Join 120 partner restaurants and cafes. Each rescued meal saves 2.5 kg of CO2! (Average rescued meal: 400 g of food.) Download free today, because every bite counts." Small print: partner businesses pay 30% commission on each sale.

Source H: Policy extract (Harbourfield Council, Climate Plan: Food Waste Strategy)
1. Cut food waste sent to landfill by 50% of today's 36 000 tonnes by 2032.
2. The net extra running cost to the council must not exceed 150 000 pounds per year.
3. Household charges must not rise by more than 5 pounds per household per year.
4. Services must work for flats as well as houses.
5. Progress will be reviewed every two years.

(a) Write a briefing of 150 to 200 words for the council's Climate Committee. Recommend whether Harbourfield should adopt a household food waste collection. Use evidence from at least three sources, and refer to them by letter (for example 'Source C'). (10 marks)
(b) Describe one table or chart you would add to the briefing. State its title, the labels and units, and the data it would show. (4 marks)

Total for Question 6: 14 marks$mq$, $mq$[1] A clear recommendation is stated at the start
[1] Logical structure (opening, evidence, conclusion; paragraphs or headings)
[1] Formal, suitable tone for a council committee
[1] A figure from one source is used accurately (for example 60% of waste from households, or 18 770 tonnes CO2e saved)
[1] A figure from a second source is used accurately (for example cost 8.60 pounds per tonne or 143 964 pounds)
[1] A figure from a third source is used accurately and cited (for example 77.5% trial participation)
[1] Combines ideas from two fields (for example climate science with costs)
[1] Acknowledges one limitation or uncertainty (for example participation, flats, summer smell)
[1] Suggests one measure for non-household waste (for example supermarkets, cafes, school guidance)
[1] Length and clarity are appropriate (about 150 to 200 words, no unexplained jargon)
[1] A suitable type for the data (for example bar chart of waste by source, or table comparing scheme options)
[1] A clear title and labelled axes or columns with units
[1] Data shown accurately from the sources (for example 21 600, 7 200, 3 600, 2 400, 1 200 tonnes)
[1] Explains why it helps the committee understand or decide$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | D 12]]
Task 7: Reflecting on the process
THEME: Harbourfield - feeding a city without wasting it
Harbourfield is a fictional port city of 240,000 people living in 96,000 households. The council wants to cut the amount of food waste sent to landfill. Read Sources A to H, which come from different fields of study, and use them to answer the tasks.

Source A: Waste audit (Harbourfield Waste Authority). Food waste sent to landfill in one year, by source
Source: tonnes per year
Households: 21 600
Restaurants and cafes: 7 200
Supermarkets: 3 600
Schools and offices: 2 400
Food markets: 1 200
Total: 36 000

Source B: Science note (Harbourfield University, Environmental Science Group), "What happens to wasted food?"
"When food waste is buried in landfill there is very little oxygen. Bacteria that live without oxygen break the food down and release methane. Methane traps about 28 times as much heat as carbon dioxide over 100 years, so emissions are reported as carbon dioxide equivalent (CO2e): 1 kg of methane counts as 28 kg CO2e. Our measurements show that each tonne of food waste in landfill releases 60 kg of methane. If food waste is sent to a sealed anaerobic digester instead, the methane is captured and burned. The process then causes only 0.1 tonnes CO2e per tonne of food waste and produces 120 kWh of electricity per tonne. In an open compost heap there is plenty of air, so microorganisms carry out aerobic respiration and release carbon dioxide and water; very little methane forms. Separately, food kept between 8 C and 63 C allows bacteria to multiply quickly, because some species divide about every 20 minutes."

Source C: Cost report (Harbourfield Chamber of Commerce). Costs per tonne of food waste, in pounds (GBP)
Landfill disposal including landfill tax: 95
Separate household collection: 48
Anaerobic digestion treatment: 70
Electricity from digestion: 120 kWh per tonne, sold at 0.12 per kWh
Assumed participation in a citywide household scheme: 55% of household food waste collected
(Set-up costs of bins and vehicles are covered by a government grant.)

Source D: Newspaper extract (Harbourfield Gazette), "The bin that smells of progress"
"Over six months, 4 000 homes in Eastside tested a weekly food waste collection. 3 100 households took part. 'Cooking smells and flies in summer were the biggest complaint,' said trial manager Jo Reyes, 'but most people got used to the kitchen caddy within a month.' Many Eastside residents volunteered for the trial, and the area has more houses with gardens than the rest of the city. Alan Price, who lives in a flat in Central Harbourfield, said: 'I have no room for another bin.' A Food Standards officer reminded readers that 'use by' dates are about safety, while 'best before' dates are about quality."

Source E: Infographic shown as a table. "Why households throw food away" (Harbourfield Household Survey, 1 200 households, one main reason each)
Went off before it was eaten: 34%
Cooked or served too much: 28%
Past the date on the label: 22%
Did not like it: 9%
Other reasons: 7%

Source F: Interview transcript (Harbourfield Radio), Daria Okoye, owner of the Salt and Pepper Cafe
Interviewer: How much food do you throw away?
Daria: About 18 kilograms on a typical day, mostly vegetable peelings and plate leftovers. Before I joined SaveBite it was nearer 26. Customers reserve our unsold sandwiches and soups at 5 pm for half price.
Interviewer: Why don't more owners join?
Daria: Three things. Staff time, because we have to pack the food. The app takes 30% commission. And fear. Owners worry that if someone is ill after eating leftover food they will be blamed. Soup must be cooled quickly and kept in the fridge, or kept hot, otherwise bacteria grow. My staff rule is: never leave it on the counter.
Interviewer: What would help?
Daria: Clear guidance from the council, and maybe a small grant for fridges. But honestly, the biggest waste is in people's homes, not in my cafe.

Source G: Advert (SaveBite app)
"SaveBite - tonight's food at half the price, zero waste! Over 100 000 meals rescued in two years! Join 120 partner restaurants and cafes. Each rescued meal saves 2.5 kg of CO2! (Average rescued meal: 400 g of food.) Download free today, because every bite counts." Small print: partner businesses pay 30% commission on each sale.

Source H: Policy extract (Harbourfield Council, Climate Plan: Food Waste Strategy)
1. Cut food waste sent to landfill by 50% of today's 36 000 tonnes by 2032.
2. The net extra running cost to the council must not exceed 150 000 pounds per year.
3. Household charges must not rise by more than 5 pounds per household per year.
4. Services must work for flats as well as houses.
5. Progress will be reviewed every two years.

(a) Describe one insight you gained by combining two fields of study that you could not have gained using one field alone. (3 marks)
(b) Explain one limitation or possible bias in the evidence you used and how it could affect your recommendation. (3 marks)
(c) Evaluate how your recommendation might change if only 40% of households took part. (2 marks)
(d) Reflect on one strategy that helped you connect the sources and one thing you would do differently next time. (2 marks)
(e) Write a message of no more than 50 words for residents explaining, in plain language, the main uncertainty in your recommendation. (2 marks)

Total for Question 7: 12 marks$mq$, $mq$[1] Identifies two fields clearly
[1] States a specific insight (for example that a scheme that cuts emissions also needs cost data and public behaviour data to work)
[1] Explains why one field alone would be insufficient
[1] Identifies a specific limitation or bias (for example volunteers in the trial in Source D, the commercial interest in Source G)
[1] Explains how it could distort the recommendation
[1] Suggests a way to reduce the problem (for example a bigger or random trial)
[1] Identifies a change (diverts 8 640 tonnes, 24% of the city total; or the target is further away)
[1] Evaluates the effect on the target, cost or need for additional measures, with a reason
[1] A specific strategy with why it helped (for example listing facts by discipline)
[1] A realistic improvement linked to the process
[1] Plain, polite language suitable for non-experts and within 50 words
[1] Names the main uncertainty accurately (for example how many households will take part) and why it matters$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Interdisciplinary Learning MYP 5 eAssessment Paper B (7 tasks, 78 marks) (78 marks)
with sub as (select id from public.subjects where slug = $mq$interdisciplinary-learning$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Interdisciplinary Learning MYP 5 eAssessment Paper B (7 tasks, 78 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Interdisciplinary Learning MYP 5 eAssessment Paper B (7 tasks, 78 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: Identifying disciplines and reading data
THEME: Karaville - keeping a dense city cool
Karaville is a fictional city of 900,000 people. Its crowded central district becomes dangerously hot in summer heatwaves. The council has a limited budget and must decide how to protect residents. Read Sources A to H, which come from different fields of study, and use them to answer the tasks.

Source A: Temperature record (Karaville Weather Service), 3 pm on the hottest day of the heatwave
Site: tree canopy cover; air temperature; surface temperature
Central district: 8%; 38.4 C; 51.0 C
Harbour front: 5%; 36.9 C; 47.5 C
East suburb: 24%; 35.2 C; 41.0 C
Riverside Park: 62%; 32.6 C; 33.0 C

Source B: Science note (Karaville Institute of Technology), "Why cities run hot"
"On a clear day, sunlight at midday delivers about 800 W of energy to every square metre. The albedo of a surface is the fraction of this energy that it reflects; the rest is absorbed and becomes heat. Dark asphalt and dark roofs have an albedo of about 0.10, while a white-painted roof has an albedo of about 0.70. Trees cool a city in two ways: their leaves shade the ground, and they release water vapour (transpiration). Evaporating 1 litre of water takes in about 2.26 MJ of energy from the surroundings. A large tree can transpire about 400 litres on a hot day. Brick and concrete store heat in the day and release it slowly at night, so dense districts stay warm after sunset. (1 kWh = 3.6 MJ.)"

Source C: Health data (Karaville Public Health Office), hospital admissions for heat illness during the heatwave week
Age group: population; admissions per 100 000 people; number admitted
0 to 14 years: 150 000; 10; 15
15 to 64 years: 600 000; 25; 150
65 years and over: 150 000; 120; 180
Total: 900 000; -; 345
Note: during the 6 days of the heatwave there were an average of 41 deaths per day in the city, compared with 18 per day normally.

Source D: Newspaper extract (Karaville Courier), "Trees or paint?"
"A planning officer told the council that new street trees take about 15 years to give full shade, and that because of pipes under the pavements, trees can be planted on only one in four of Central's narrow streets. White roof paint works from the first summer but must be re-applied every five years. Shop owner Rami Qadir doubted the plan for cooling centres: 'Older people will not travel across the city in 38 degrees to sit in a library.' The council says no option can be ruled out."

Source E: Interview transcript (Karaville Radio), Lena Haddad, community nurse
Interviewer: Who worries you most in a heatwave?
Lena: People over 75 who live alone in top-floor flats in Central. Their flats can be 3 degrees hotter than the street at night. They keep the windows shut because of noise and break-ins, and many cannot afford to run an air conditioner.
Interviewer: Why do they not simply drink more and cool down?
Lena: Older people often do not feel thirsty, and they sweat less. One man told me, "I never feel hot, I am fine," and the next day he collapsed. A neighbour knocking on the door and a cool, nearby place to go make the biggest difference.

Source F: Advert (CoolCoat roof paint)
"CoolCoat - paint it white, keep it cool! Reflects up to 90% of sunlight. Cuts your cooling bills by up to 40%*. Used on over 5 000 roofs. Only 12 pounds per square metre!" Small print: *Result from a one-storey warehouse in a desert test. Price is per coat; two coats are recommended. Labour not included.

Source G: Options costed by the Council Planning Office (pounds, GBP)
Option 1, street trees: 500 trees at 1 800 each (planting and five years of care). Full effect after about 15 years.
Option 2, cool-roof paint on public buildings: 40 000 square metres at 14 per square metre (paint and labour). Effect immediate; re-apply every five years.
Option 3, heatwave cooling centres: 12 centres at 35 000 per year each. Effect immediate while open.

Source H: Policy extract (Karaville Council, Heat Action Plan)
1. Protect the people most at risk of heat illness first.
2. Reduce the peak afternoon air temperature in Central by 2 C by 2035.
3. One-off budget: 1 000 000 pounds. Yearly running budget: 450 000 pounds.
4. Neighbourhoods with the lowest tree canopy must benefit first.

(a) Name the main field of study that each of Sources A, B, C and G draws on. Give one field for each source. (4 marks)
(b) Use Source A to calculate the difference between Central district and Riverside Park in (i) air temperature and (ii) surface temperature. (2 marks)
(c) Use Source C to calculate the percentage of all heat admissions who were aged 65 and over. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$[1] Source A: geography / meteorology / mathematics (data handling)
[1] Source B: sciences (physics and biology)
[1] Source C: health science / biology / mathematics (data handling)
[1] Source G: economics (Individuals and societies). One field per source; the field must fit the content.
[1] (i) 38.4 - 32.6 = 5.8 C
[1] (ii) 51.0 - 33.0 = 18.0 C
[1] Total 345 admissions
[1] 180 / 345 = 52.2% (accept 52%)$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 9 | B 2]]
Task 2: Applying physics and biology to the city
THEME: Karaville - keeping a dense city cool
Karaville is a fictional city of 900,000 people. Its crowded central district becomes dangerously hot in summer heatwaves. The council has a limited budget and must decide how to protect residents. Read Sources A to H, which come from different fields of study, and use them to answer the tasks.

Source A: Temperature record (Karaville Weather Service), 3 pm on the hottest day of the heatwave
Site: tree canopy cover; air temperature; surface temperature
Central district: 8%; 38.4 C; 51.0 C
Harbour front: 5%; 36.9 C; 47.5 C
East suburb: 24%; 35.2 C; 41.0 C
Riverside Park: 62%; 32.6 C; 33.0 C

Source B: Science note (Karaville Institute of Technology), "Why cities run hot"
"On a clear day, sunlight at midday delivers about 800 W of energy to every square metre. The albedo of a surface is the fraction of this energy that it reflects; the rest is absorbed and becomes heat. Dark asphalt and dark roofs have an albedo of about 0.10, while a white-painted roof has an albedo of about 0.70. Trees cool a city in two ways: their leaves shade the ground, and they release water vapour (transpiration). Evaporating 1 litre of water takes in about 2.26 MJ of energy from the surroundings. A large tree can transpire about 400 litres on a hot day. Brick and concrete store heat in the day and release it slowly at night, so dense districts stay warm after sunset. (1 kWh = 3.6 MJ.)"

Source C: Health data (Karaville Public Health Office), hospital admissions for heat illness during the heatwave week
Age group: population; admissions per 100 000 people; number admitted
0 to 14 years: 150 000; 10; 15
15 to 64 years: 600 000; 25; 150
65 years and over: 150 000; 120; 180
Total: 900 000; -; 345
Note: during the 6 days of the heatwave there were an average of 41 deaths per day in the city, compared with 18 per day normally.

Source D: Newspaper extract (Karaville Courier), "Trees or paint?"
"A planning officer told the council that new street trees take about 15 years to give full shade, and that because of pipes under the pavements, trees can be planted on only one in four of Central's narrow streets. White roof paint works from the first summer but must be re-applied every five years. Shop owner Rami Qadir doubted the plan for cooling centres: 'Older people will not travel across the city in 38 degrees to sit in a library.' The council says no option can be ruled out."

Source E: Interview transcript (Karaville Radio), Lena Haddad, community nurse
Interviewer: Who worries you most in a heatwave?
Lena: People over 75 who live alone in top-floor flats in Central. Their flats can be 3 degrees hotter than the street at night. They keep the windows shut because of noise and break-ins, and many cannot afford to run an air conditioner.
Interviewer: Why do they not simply drink more and cool down?
Lena: Older people often do not feel thirsty, and they sweat less. One man told me, "I never feel hot, I am fine," and the next day he collapsed. A neighbour knocking on the door and a cool, nearby place to go make the biggest difference.

Source F: Advert (CoolCoat roof paint)
"CoolCoat - paint it white, keep it cool! Reflects up to 90% of sunlight. Cuts your cooling bills by up to 40%*. Used on over 5 000 roofs. Only 12 pounds per square metre!" Small print: *Result from a one-storey warehouse in a desert test. Price is per coat; two coats are recommended. Labour not included.

Source G: Options costed by the Council Planning Office (pounds, GBP)
Option 1, street trees: 500 trees at 1 800 each (planting and five years of care). Full effect after about 15 years.
Option 2, cool-roof paint on public buildings: 40 000 square metres at 14 per square metre (paint and labour). Effect immediate; re-apply every five years.
Option 3, heatwave cooling centres: 12 centres at 35 000 per year each. Effect immediate while open.

Source H: Policy extract (Karaville Council, Heat Action Plan)
1. Protect the people most at risk of heat illness first.
2. Reduce the peak afternoon air temperature in Central by 2 C by 2035.
3. One-off budget: 1 000 000 pounds. Yearly running budget: 450 000 pounds.
4. Neighbourhoods with the lowest tree canopy must benefit first.

(a) Source B. A flat roof has an albedo of 0.10. It is repainted white with an albedo of 0.70. At midday, calculate the energy absorbed per square metre before and after painting, the reduction per square metre, and the reduction in power for 40 000 square metres of roof. (4 marks)
(b) Calculate the energy absorbed from the air by one large tree that transpires 400 litres on a hot day, in megajoules and in kilowatt-hours. (2 marks)
(c) Explain two ways in which trees cool the air, and use Source A to support one of them. (3 marks)
(d) Use Source G to calculate the total cost of doing both Option 1 and Option 2 and compare it with the one-off budget in Source H. (2 marks)

Total for Question 2: 11 marks$mq$, $mq$[1] Before: 0.90 x 800 = 720 W per square metre
[1] After: 0.30 x 800 = 240 W per square metre
[1] Reduction = 480 W per square metre
[1] 480 x 40 000 = 19 200 000 W = 19.2 MW
[1] 400 x 2.26 = 904 MJ
[1] 904 / 3.6 = about 251 kWh
[1] Shade: leaves block sunlight so less energy is absorbed by the ground and buildings
[1] Transpiration: water evaporating from leaves takes in energy from the air
[1] Uses Source A (for example Riverside Park has 62% canopy and is 5.8 C cooler than Central with 8% canopy)
[1] 500 x 1 800 = 900 000 and 40 000 x 14 = 560 000; total 1 460 000 pounds
[1] This is 460 000 pounds more than the 1 000 000 budget$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 9]]
Task 3: Applying biology, health and geography
THEME: Karaville - keeping a dense city cool
Karaville is a fictional city of 900,000 people. Its crowded central district becomes dangerously hot in summer heatwaves. The council has a limited budget and must decide how to protect residents. Read Sources A to H, which come from different fields of study, and use them to answer the tasks.

Source A: Temperature record (Karaville Weather Service), 3 pm on the hottest day of the heatwave
Site: tree canopy cover; air temperature; surface temperature
Central district: 8%; 38.4 C; 51.0 C
Harbour front: 5%; 36.9 C; 47.5 C
East suburb: 24%; 35.2 C; 41.0 C
Riverside Park: 62%; 32.6 C; 33.0 C

Source B: Science note (Karaville Institute of Technology), "Why cities run hot"
"On a clear day, sunlight at midday delivers about 800 W of energy to every square metre. The albedo of a surface is the fraction of this energy that it reflects; the rest is absorbed and becomes heat. Dark asphalt and dark roofs have an albedo of about 0.10, while a white-painted roof has an albedo of about 0.70. Trees cool a city in two ways: their leaves shade the ground, and they release water vapour (transpiration). Evaporating 1 litre of water takes in about 2.26 MJ of energy from the surroundings. A large tree can transpire about 400 litres on a hot day. Brick and concrete store heat in the day and release it slowly at night, so dense districts stay warm after sunset. (1 kWh = 3.6 MJ.)"

Source C: Health data (Karaville Public Health Office), hospital admissions for heat illness during the heatwave week
Age group: population; admissions per 100 000 people; number admitted
0 to 14 years: 150 000; 10; 15
15 to 64 years: 600 000; 25; 150
65 years and over: 150 000; 120; 180
Total: 900 000; -; 345
Note: during the 6 days of the heatwave there were an average of 41 deaths per day in the city, compared with 18 per day normally.

Source D: Newspaper extract (Karaville Courier), "Trees or paint?"
"A planning officer told the council that new street trees take about 15 years to give full shade, and that because of pipes under the pavements, trees can be planted on only one in four of Central's narrow streets. White roof paint works from the first summer but must be re-applied every five years. Shop owner Rami Qadir doubted the plan for cooling centres: 'Older people will not travel across the city in 38 degrees to sit in a library.' The council says no option can be ruled out."

Source E: Interview transcript (Karaville Radio), Lena Haddad, community nurse
Interviewer: Who worries you most in a heatwave?
Lena: People over 75 who live alone in top-floor flats in Central. Their flats can be 3 degrees hotter than the street at night. They keep the windows shut because of noise and break-ins, and many cannot afford to run an air conditioner.
Interviewer: Why do they not simply drink more and cool down?
Lena: Older people often do not feel thirsty, and they sweat less. One man told me, "I never feel hot, I am fine," and the next day he collapsed. A neighbour knocking on the door and a cool, nearby place to go make the biggest difference.

Source F: Advert (CoolCoat roof paint)
"CoolCoat - paint it white, keep it cool! Reflects up to 90% of sunlight. Cuts your cooling bills by up to 40%*. Used on over 5 000 roofs. Only 12 pounds per square metre!" Small print: *Result from a one-storey warehouse in a desert test. Price is per coat; two coats are recommended. Labour not included.

Source G: Options costed by the Council Planning Office (pounds, GBP)
Option 1, street trees: 500 trees at 1 800 each (planting and five years of care). Full effect after about 15 years.
Option 2, cool-roof paint on public buildings: 40 000 square metres at 14 per square metre (paint and labour). Effect immediate; re-apply every five years.
Option 3, heatwave cooling centres: 12 centres at 35 000 per year each. Effect immediate while open.

Source H: Policy extract (Karaville Council, Heat Action Plan)
1. Protect the people most at risk of heat illness first.
2. Reduce the peak afternoon air temperature in Central by 2 C by 2035.
3. One-off budget: 1 000 000 pounds. Yearly running budget: 450 000 pounds.
4. Neighbourhoods with the lowest tree canopy must benefit first.

(a) Use Source E to explain why older people are at greater risk of heat illness. (3 marks)
(b) Use Source C to show how many times higher the admission rate is for people aged 65 and over than for people aged 15 to 64. (2 marks)
(c) Give two reasons why a top-floor flat in Central can be hotter than the street at night. (2 marks)
(d) Use Source C to calculate the number of extra deaths in the heatwave compared with normal. (2 marks)

Total for Question 3: 9 marks$mq$, $mq$[1] The body cools mainly by sweating (evaporation), and older people sweat less
[1] They feel less thirsty, so they may become dehydrated
[1] The heart and circulation work harder to move blood to the skin to lose heat, which is harder with age or heart conditions (accept any valid body-system point)
[1] 120 / 25
[1] 4.8 times
[1] Brick and concrete store heat in the day and release it slowly at night
[1] Windows are kept shut so heat cannot escape (also accept hot air rises to the top floor, or a dark roof absorbing heat)
[1] 41 - 18 = 23 extra deaths per day
[1] 23 x 6 = 138 extra deaths$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 12]]
Task 4: Synthesising evidence to test the options against policy
THEME: Karaville - keeping a dense city cool
Karaville is a fictional city of 900,000 people. Its crowded central district becomes dangerously hot in summer heatwaves. The council has a limited budget and must decide how to protect residents. Read Sources A to H, which come from different fields of study, and use them to answer the tasks.

Source A: Temperature record (Karaville Weather Service), 3 pm on the hottest day of the heatwave
Site: tree canopy cover; air temperature; surface temperature
Central district: 8%; 38.4 C; 51.0 C
Harbour front: 5%; 36.9 C; 47.5 C
East suburb: 24%; 35.2 C; 41.0 C
Riverside Park: 62%; 32.6 C; 33.0 C

Source B: Science note (Karaville Institute of Technology), "Why cities run hot"
"On a clear day, sunlight at midday delivers about 800 W of energy to every square metre. The albedo of a surface is the fraction of this energy that it reflects; the rest is absorbed and becomes heat. Dark asphalt and dark roofs have an albedo of about 0.10, while a white-painted roof has an albedo of about 0.70. Trees cool a city in two ways: their leaves shade the ground, and they release water vapour (transpiration). Evaporating 1 litre of water takes in about 2.26 MJ of energy from the surroundings. A large tree can transpire about 400 litres on a hot day. Brick and concrete store heat in the day and release it slowly at night, so dense districts stay warm after sunset. (1 kWh = 3.6 MJ.)"

Source C: Health data (Karaville Public Health Office), hospital admissions for heat illness during the heatwave week
Age group: population; admissions per 100 000 people; number admitted
0 to 14 years: 150 000; 10; 15
15 to 64 years: 600 000; 25; 150
65 years and over: 150 000; 120; 180
Total: 900 000; -; 345
Note: during the 6 days of the heatwave there were an average of 41 deaths per day in the city, compared with 18 per day normally.

Source D: Newspaper extract (Karaville Courier), "Trees or paint?"
"A planning officer told the council that new street trees take about 15 years to give full shade, and that because of pipes under the pavements, trees can be planted on only one in four of Central's narrow streets. White roof paint works from the first summer but must be re-applied every five years. Shop owner Rami Qadir doubted the plan for cooling centres: 'Older people will not travel across the city in 38 degrees to sit in a library.' The council says no option can be ruled out."

Source E: Interview transcript (Karaville Radio), Lena Haddad, community nurse
Interviewer: Who worries you most in a heatwave?
Lena: People over 75 who live alone in top-floor flats in Central. Their flats can be 3 degrees hotter than the street at night. They keep the windows shut because of noise and break-ins, and many cannot afford to run an air conditioner.
Interviewer: Why do they not simply drink more and cool down?
Lena: Older people often do not feel thirsty, and they sweat less. One man told me, "I never feel hot, I am fine," and the next day he collapsed. A neighbour knocking on the door and a cool, nearby place to go make the biggest difference.

Source F: Advert (CoolCoat roof paint)
"CoolCoat - paint it white, keep it cool! Reflects up to 90% of sunlight. Cuts your cooling bills by up to 40%*. Used on over 5 000 roofs. Only 12 pounds per square metre!" Small print: *Result from a one-storey warehouse in a desert test. Price is per coat; two coats are recommended. Labour not included.

Source G: Options costed by the Council Planning Office (pounds, GBP)
Option 1, street trees: 500 trees at 1 800 each (planting and five years of care). Full effect after about 15 years.
Option 2, cool-roof paint on public buildings: 40 000 square metres at 14 per square metre (paint and labour). Effect immediate; re-apply every five years.
Option 3, heatwave cooling centres: 12 centres at 35 000 per year each. Effect immediate while open.

Source H: Policy extract (Karaville Council, Heat Action Plan)
1. Protect the people most at risk of heat illness first.
2. Reduce the peak afternoon air temperature in Central by 2 C by 2035.
3. One-off budget: 1 000 000 pounds. Yearly running budget: 450 000 pounds.
4. Neighbourhoods with the lowest tree canopy must benefit first.

(a) Use Sources C, G and H to explain why heatwave cooling centres should be part of the plan. (3 marks)
(b) Explain two tensions between the options and the aims in Source H. (3 marks)
(c) The council funds Option 2 in full. Calculate the greatest number of trees it could then buy with the rest of the one-off budget. (3 marks)
(d) Check whether Option 3 fits the yearly running budget, and whether a thirteenth centre would. (3 marks)

Total for Question 4: 12 marks$mq$, $mq$[1] Source C: people aged 65 and over are 16.7% of the population but 52.2% of admissions
[1] Source H, point 1: the people most at risk must be protected first
[1] Source G: cooling centres work immediately, whereas trees take about 15 years (accept a limitation from Source D or E such as transport needs)
[1] Trees take about 15 years to give full shade (Sources D and G), but the target is for 2035
[1] Trees can be planted on only one in four of Central's narrow streets (Source D), but low-canopy areas are meant to benefit first
[1] Roof paint is immediate but needs re-applying every five years, so costs return (accept any valid link)
[1] 1 000 000 - 560 000 = 440 000 pounds
[1] 440 000 / 1 800 = 244.4
[1] 244 trees (rounded down because part of a tree cannot be bought)
[1] 12 x 35 000 = 420 000 pounds
[1] Within the 450 000 budget, leaving 30 000
[1] A thirteenth centre would raise the cost to 455 000, which is over budget$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | B 12]]
Task 5: Evaluating sources and claims
THEME: Karaville - keeping a dense city cool
Karaville is a fictional city of 900,000 people. Its crowded central district becomes dangerously hot in summer heatwaves. The council has a limited budget and must decide how to protect residents. Read Sources A to H, which come from different fields of study, and use them to answer the tasks.

Source A: Temperature record (Karaville Weather Service), 3 pm on the hottest day of the heatwave
Site: tree canopy cover; air temperature; surface temperature
Central district: 8%; 38.4 C; 51.0 C
Harbour front: 5%; 36.9 C; 47.5 C
East suburb: 24%; 35.2 C; 41.0 C
Riverside Park: 62%; 32.6 C; 33.0 C

Source B: Science note (Karaville Institute of Technology), "Why cities run hot"
"On a clear day, sunlight at midday delivers about 800 W of energy to every square metre. The albedo of a surface is the fraction of this energy that it reflects; the rest is absorbed and becomes heat. Dark asphalt and dark roofs have an albedo of about 0.10, while a white-painted roof has an albedo of about 0.70. Trees cool a city in two ways: their leaves shade the ground, and they release water vapour (transpiration). Evaporating 1 litre of water takes in about 2.26 MJ of energy from the surroundings. A large tree can transpire about 400 litres on a hot day. Brick and concrete store heat in the day and release it slowly at night, so dense districts stay warm after sunset. (1 kWh = 3.6 MJ.)"

Source C: Health data (Karaville Public Health Office), hospital admissions for heat illness during the heatwave week
Age group: population; admissions per 100 000 people; number admitted
0 to 14 years: 150 000; 10; 15
15 to 64 years: 600 000; 25; 150
65 years and over: 150 000; 120; 180
Total: 900 000; -; 345
Note: during the 6 days of the heatwave there were an average of 41 deaths per day in the city, compared with 18 per day normally.

Source D: Newspaper extract (Karaville Courier), "Trees or paint?"
"A planning officer told the council that new street trees take about 15 years to give full shade, and that because of pipes under the pavements, trees can be planted on only one in four of Central's narrow streets. White roof paint works from the first summer but must be re-applied every five years. Shop owner Rami Qadir doubted the plan for cooling centres: 'Older people will not travel across the city in 38 degrees to sit in a library.' The council says no option can be ruled out."

Source E: Interview transcript (Karaville Radio), Lena Haddad, community nurse
Interviewer: Who worries you most in a heatwave?
Lena: People over 75 who live alone in top-floor flats in Central. Their flats can be 3 degrees hotter than the street at night. They keep the windows shut because of noise and break-ins, and many cannot afford to run an air conditioner.
Interviewer: Why do they not simply drink more and cool down?
Lena: Older people often do not feel thirsty, and they sweat less. One man told me, "I never feel hot, I am fine," and the next day he collapsed. A neighbour knocking on the door and a cool, nearby place to go make the biggest difference.

Source F: Advert (CoolCoat roof paint)
"CoolCoat - paint it white, keep it cool! Reflects up to 90% of sunlight. Cuts your cooling bills by up to 40%*. Used on over 5 000 roofs. Only 12 pounds per square metre!" Small print: *Result from a one-storey warehouse in a desert test. Price is per coat; two coats are recommended. Labour not included.

Source G: Options costed by the Council Planning Office (pounds, GBP)
Option 1, street trees: 500 trees at 1 800 each (planting and five years of care). Full effect after about 15 years.
Option 2, cool-roof paint on public buildings: 40 000 square metres at 14 per square metre (paint and labour). Effect immediate; re-apply every five years.
Option 3, heatwave cooling centres: 12 centres at 35 000 per year each. Effect immediate while open.

Source H: Policy extract (Karaville Council, Heat Action Plan)
1. Protect the people most at risk of heat illness first.
2. Reduce the peak afternoon air temperature in Central by 2 C by 2035.
3. One-off budget: 1 000 000 pounds. Yearly running budget: 450 000 pounds.
4. Neighbourhoods with the lowest tree canopy must benefit first.

(a) Identify two features of Source F that show it is an advert rather than a neutral report. (2 marks)
(b) Evaluate the claims 'reflects up to 90% of sunlight' and 'cuts your cooling bills by up to 40%'. (4 marks)
(c) Compare the usefulness of Source D (newspaper) and Source E (interview) as evidence for the council. (3 marks)
(d) Use Source F to calculate the paint cost for 40 000 square metres with two coats, and compare it with the cost for Option 2 in Source G. (3 marks)

Total for Question 5: 12 marks$mq$, $mq$[1] Persuasive wording or exclamation (for example 'paint it white, keep it cool!')
[1] Selective statistics ('up to') or a low price shown boldly while the limits are in small print
[1] 'Up to' gives a best case, not a typical result
[1] Source B gives an albedo of about 0.70 (70%) for white roofs, lower than the 90% claimed
[1] The 40% result came from a one-storey warehouse in a desert, which is very different from Karaville's multi-storey buildings
[1] The seller has a commercial interest in the claims
[1] Source E gives first-hand expert experience of the people at risk, and agrees with the data in Source C
[1] Source E is one person's view and may focus on one group (accept possible bias)
[1] Source D reports several views with some facts from officials, but selects quotations and includes opinion (for example Rami Qadir's doubt is not backed by data)
[1] 12 x 2 = 24 pounds per square metre
[1] 24 x 40 000 = 960 000 pounds (before labour)
[1] This is 400 000 pounds (about 71%) more than the 560 000 in Source G, so the advertised price is misleading$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 14]]
Task 6: Communicating to the public
THEME: Karaville - keeping a dense city cool
Karaville is a fictional city of 900,000 people. Its crowded central district becomes dangerously hot in summer heatwaves. The council has a limited budget and must decide how to protect residents. Read Sources A to H, which come from different fields of study, and use them to answer the tasks.

Source A: Temperature record (Karaville Weather Service), 3 pm on the hottest day of the heatwave
Site: tree canopy cover; air temperature; surface temperature
Central district: 8%; 38.4 C; 51.0 C
Harbour front: 5%; 36.9 C; 47.5 C
East suburb: 24%; 35.2 C; 41.0 C
Riverside Park: 62%; 32.6 C; 33.0 C

Source B: Science note (Karaville Institute of Technology), "Why cities run hot"
"On a clear day, sunlight at midday delivers about 800 W of energy to every square metre. The albedo of a surface is the fraction of this energy that it reflects; the rest is absorbed and becomes heat. Dark asphalt and dark roofs have an albedo of about 0.10, while a white-painted roof has an albedo of about 0.70. Trees cool a city in two ways: their leaves shade the ground, and they release water vapour (transpiration). Evaporating 1 litre of water takes in about 2.26 MJ of energy from the surroundings. A large tree can transpire about 400 litres on a hot day. Brick and concrete store heat in the day and release it slowly at night, so dense districts stay warm after sunset. (1 kWh = 3.6 MJ.)"

Source C: Health data (Karaville Public Health Office), hospital admissions for heat illness during the heatwave week
Age group: population; admissions per 100 000 people; number admitted
0 to 14 years: 150 000; 10; 15
15 to 64 years: 600 000; 25; 150
65 years and over: 150 000; 120; 180
Total: 900 000; -; 345
Note: during the 6 days of the heatwave there were an average of 41 deaths per day in the city, compared with 18 per day normally.

Source D: Newspaper extract (Karaville Courier), "Trees or paint?"
"A planning officer told the council that new street trees take about 15 years to give full shade, and that because of pipes under the pavements, trees can be planted on only one in four of Central's narrow streets. White roof paint works from the first summer but must be re-applied every five years. Shop owner Rami Qadir doubted the plan for cooling centres: 'Older people will not travel across the city in 38 degrees to sit in a library.' The council says no option can be ruled out."

Source E: Interview transcript (Karaville Radio), Lena Haddad, community nurse
Interviewer: Who worries you most in a heatwave?
Lena: People over 75 who live alone in top-floor flats in Central. Their flats can be 3 degrees hotter than the street at night. They keep the windows shut because of noise and break-ins, and many cannot afford to run an air conditioner.
Interviewer: Why do they not simply drink more and cool down?
Lena: Older people often do not feel thirsty, and they sweat less. One man told me, "I never feel hot, I am fine," and the next day he collapsed. A neighbour knocking on the door and a cool, nearby place to go make the biggest difference.

Source F: Advert (CoolCoat roof paint)
"CoolCoat - paint it white, keep it cool! Reflects up to 90% of sunlight. Cuts your cooling bills by up to 40%*. Used on over 5 000 roofs. Only 12 pounds per square metre!" Small print: *Result from a one-storey warehouse in a desert test. Price is per coat; two coats are recommended. Labour not included.

Source G: Options costed by the Council Planning Office (pounds, GBP)
Option 1, street trees: 500 trees at 1 800 each (planting and five years of care). Full effect after about 15 years.
Option 2, cool-roof paint on public buildings: 40 000 square metres at 14 per square metre (paint and labour). Effect immediate; re-apply every five years.
Option 3, heatwave cooling centres: 12 centres at 35 000 per year each. Effect immediate while open.

Source H: Policy extract (Karaville Council, Heat Action Plan)
1. Protect the people most at risk of heat illness first.
2. Reduce the peak afternoon air temperature in Central by 2 C by 2035.
3. One-off budget: 1 000 000 pounds. Yearly running budget: 450 000 pounds.
4. Neighbourhoods with the lowest tree canopy must benefit first.

(a) Write a leaflet of 120 to 160 words for older residents of Central district. Explain why the district gets so hot, give at least two practical actions, and tell them about the council's plan. Use at least two sources, and write in plain language. (10 marks)
(b) Describe one table or chart you would add to your communication. State its title, the labels and units, and the data it would show. (4 marks)

Total for Question 6: 14 marks$mq$, $mq$[1] A clear title or heading that suits the audience
[1] Short sentences and everyday words suitable for older readers
[1] Explains accurately why Central is hotter (for example dark surfaces absorb heat and few trees)
[1] Gives a first practical action based on the sources (for example drink water even if not thirsty; Source E)
[1] Gives a second practical action (for example check on neighbours, visit a cooling centre, open windows safely at night)
[1] Mentions the council plan accurately (for example 12 cooling centres in heatwaves)
[1] Uses a figure from the sources accurately (for example 38.4 C in Central or 5.8 C difference)
[1] Supportive tone that does not cause panic
[1] Logical order and clear layout
[1] Length appropriate (about 120 to 160 words) with no unexplained jargon
[1] A suitable type for the data (for example a bar chart of air temperature at the four sites in Source A, or a table of the three options)
[1] A clear title and labelled axes or columns with units
[1] Data shown accurately from the sources
[1] Explains why it helps the audience$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | D 12]]
Task 7: Reflecting on the process
THEME: Karaville - keeping a dense city cool
Karaville is a fictional city of 900,000 people. Its crowded central district becomes dangerously hot in summer heatwaves. The council has a limited budget and must decide how to protect residents. Read Sources A to H, which come from different fields of study, and use them to answer the tasks.

Source A: Temperature record (Karaville Weather Service), 3 pm on the hottest day of the heatwave
Site: tree canopy cover; air temperature; surface temperature
Central district: 8%; 38.4 C; 51.0 C
Harbour front: 5%; 36.9 C; 47.5 C
East suburb: 24%; 35.2 C; 41.0 C
Riverside Park: 62%; 32.6 C; 33.0 C

Source B: Science note (Karaville Institute of Technology), "Why cities run hot"
"On a clear day, sunlight at midday delivers about 800 W of energy to every square metre. The albedo of a surface is the fraction of this energy that it reflects; the rest is absorbed and becomes heat. Dark asphalt and dark roofs have an albedo of about 0.10, while a white-painted roof has an albedo of about 0.70. Trees cool a city in two ways: their leaves shade the ground, and they release water vapour (transpiration). Evaporating 1 litre of water takes in about 2.26 MJ of energy from the surroundings. A large tree can transpire about 400 litres on a hot day. Brick and concrete store heat in the day and release it slowly at night, so dense districts stay warm after sunset. (1 kWh = 3.6 MJ.)"

Source C: Health data (Karaville Public Health Office), hospital admissions for heat illness during the heatwave week
Age group: population; admissions per 100 000 people; number admitted
0 to 14 years: 150 000; 10; 15
15 to 64 years: 600 000; 25; 150
65 years and over: 150 000; 120; 180
Total: 900 000; -; 345
Note: during the 6 days of the heatwave there were an average of 41 deaths per day in the city, compared with 18 per day normally.

Source D: Newspaper extract (Karaville Courier), "Trees or paint?"
"A planning officer told the council that new street trees take about 15 years to give full shade, and that because of pipes under the pavements, trees can be planted on only one in four of Central's narrow streets. White roof paint works from the first summer but must be re-applied every five years. Shop owner Rami Qadir doubted the plan for cooling centres: 'Older people will not travel across the city in 38 degrees to sit in a library.' The council says no option can be ruled out."

Source E: Interview transcript (Karaville Radio), Lena Haddad, community nurse
Interviewer: Who worries you most in a heatwave?
Lena: People over 75 who live alone in top-floor flats in Central. Their flats can be 3 degrees hotter than the street at night. They keep the windows shut because of noise and break-ins, and many cannot afford to run an air conditioner.
Interviewer: Why do they not simply drink more and cool down?
Lena: Older people often do not feel thirsty, and they sweat less. One man told me, "I never feel hot, I am fine," and the next day he collapsed. A neighbour knocking on the door and a cool, nearby place to go make the biggest difference.

Source F: Advert (CoolCoat roof paint)
"CoolCoat - paint it white, keep it cool! Reflects up to 90% of sunlight. Cuts your cooling bills by up to 40%*. Used on over 5 000 roofs. Only 12 pounds per square metre!" Small print: *Result from a one-storey warehouse in a desert test. Price is per coat; two coats are recommended. Labour not included.

Source G: Options costed by the Council Planning Office (pounds, GBP)
Option 1, street trees: 500 trees at 1 800 each (planting and five years of care). Full effect after about 15 years.
Option 2, cool-roof paint on public buildings: 40 000 square metres at 14 per square metre (paint and labour). Effect immediate; re-apply every five years.
Option 3, heatwave cooling centres: 12 centres at 35 000 per year each. Effect immediate while open.

Source H: Policy extract (Karaville Council, Heat Action Plan)
1. Protect the people most at risk of heat illness first.
2. Reduce the peak afternoon air temperature in Central by 2 C by 2035.
3. One-off budget: 1 000 000 pounds. Yearly running budget: 450 000 pounds.
4. Neighbourhoods with the lowest tree canopy must benefit first.

(a) Describe one insight you gained by combining two fields of study that you could not have gained using one field alone. (3 marks)
(b) Explain one limitation or possible bias in the evidence you used and how it could affect your recommendation. (3 marks)
(c) Evaluate how your recommendation might change if future heatwaves are 2 C hotter and last longer. (2 marks)
(d) Reflect on one strategy that helped you to connect the sources and one thing you would do differently next time. (2 marks)
(e) Write a message of no more than 50 words for local residents explaining, in plain language, the main uncertainty in your recommendation. (2 marks)

Total for Question 7: 12 marks$mq$, $mq$[1] Identifies two fields clearly
[1] States a specific insight that comes from the combination
[1] Explains why one field alone would be insufficient
[1] Identifies a specific limitation or bias (for example a seller with a commercial interest, a small sample, one voice)
[1] Explains how it could distort the recommendation
[1] Suggests a way to reduce the problem
[1] Identifies a change (for example more cooling centres, earlier roof painting, or faster action for the most at risk)
[1] Evaluates the effect on cost, budget or the policy targets with a reason
[1] A specific strategy with why it helped (for example a table of sources against fields of study)
[1] A realistic improvement linked to the process
[1] Plain, polite language suitable for non-experts and within 50 words
[1] Names the main uncertainty accurately and says why it matters$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);
commit;
