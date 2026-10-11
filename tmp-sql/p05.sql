begin;
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

-- Environmental Systems MYP 5 eAssessment Structure Mock A (8 tasks, 80 marks) (80 marks)
with sub as (select id from public.subjects where slug = $mq$environmental-systems$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Environmental Systems MYP 5 eAssessment Structure Mock A (8 tasks, 80 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Environmental Systems MYP 5 eAssessment Structure Mock A (8 tasks, 80 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
A freshwater lake has the food chain: algae -> water fleas -> minnows -> pike. Scientists measured the energy stored in each trophic level, in kilojoules per square metre per year (kJ/m2/yr).

Trophic level: Algae, Water fleas, Minnows, Pike
Energy stored (kJ/m2/yr): 20,000, 2,100, 260, 25

(a) Identify the secondary consumer in this food chain. (1 mark)
(b) Calculate the percentage of energy transferred from the algae to the water fleas. (2 marks)
(c) Calculate the percentage of energy transferred from the minnows to the pike, to one decimal place. (1 mark)
(d) Describe two ways in which energy is lost between one trophic level and the next. (2 marks)
(e) Explain why there are far fewer pike than minnows in the lake. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) Minnows [1].
(b) 2,100 / 20,000 x 100 [1] = 10.5% [1].
(c) 25 / 260 x 100 = 9.6% [1].
(d) Any two, described: lost as heat from respiration (used to release energy for movement and life processes); parts that are not eaten (bones, shells, roots); material that is eaten but not absorbed and lost as faeces / waste; energy in dead organisms passed to decomposers [1][1].
(e) Only about a tenth of energy passes to each higher trophic level [1]; so the pike have much less energy available, which supports a smaller number (and biomass) of organisms than the minnows [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Carbon dioxide is a greenhouse gas. Before the Industrial Revolution the concentration of carbon dioxide in the atmosphere was about 280 parts per million (ppm). It is now about 420 ppm.

(a) State two greenhouse gases other than water vapour. (2 marks)
(b) Outline how the greenhouse effect keeps the Earth's surface warmer than it would be without an atmosphere. (2 marks)
(c) Calculate the percentage increase in atmospheric carbon dioxide concentration since the Industrial Revolution. Show your working. (2 marks)
(d) Explain one way in which deforestation increases the concentration of carbon dioxide in the atmosphere. (2 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) Any two: carbon dioxide, methane, nitrous oxide, ozone (accept CFCs / fluorinated gases) [1][1].
(b) Short-wave radiation from the Sun passes through the atmosphere and warms the surface [1]; the surface re-emits longer-wavelength infrared radiation, which is absorbed by greenhouse gases and radiated back towards the surface, so less heat escapes to space [1].
(c) (420 - 280) / 280 x 100 [1] = 50% [1].
(d) Trees take in carbon dioxide for photosynthesis, so fewer trees means less carbon dioxide removed [1]; burning or decay of the cleared wood releases the stored carbon as carbon dioxide (also less carbon stored in biomass) [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
A hillside farm in a wet region has had its natural forest cut down and replaced by fields of maize. After heavy rain, brown water runs off the fields into a nearby lake.

(a) State the name of the soil layer that contains the most humus. (1 mark)
(b) Describe how removing the forest leads to soil erosion. (2 marks)
(c) Outline two farming methods that reduce soil erosion on a hillside. (2 marks)
(d) The farmer adds large amounts of nitrate fertiliser to the fields. Explain how this can cause eutrophication in the lake. (3 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) Topsoil (A horizon) [1].
(b) Tree roots no longer bind the soil and the canopy no longer intercepts rain [1]; so rain hits bare soil directly, loosens it and surface runoff carries it downhill [1].
(c) Any two, outlined: terracing (steps cut into the slope); contour ploughing (rows follow the hill's contours); planting cover crops or leaving crop residue; windbreaks / hedgerows or strips of trees; reducing grazing or ploughing on steep land [1][1].
(d) Nitrates that are not taken up by the crops are washed off into the lake [1]; the extra nutrients cause rapid growth of algae (an algal bloom) that blocks light, so plants below die [1]; bacteria decomposing dead material use up the dissolved oxygen, so fish and other organisms die [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 10]]
Acid rain forms when sulfur dioxide and nitrogen oxides dissolve in rainwater. A student wants to find out how the acidity of rainwater affects the germination of cress seeds. She has a solution of dilute sulfuric acid that she can dilute with distilled water to make solutions with pH 3, 4, 5, 6 and 7. She has packets of cress seeds, petri dishes, filter paper and a measuring cylinder.

(a) Formulate a research question for this investigation. (1 mark)
(b) State a testable hypothesis and give a scientific reason for your prediction. (2 marks)
(c) Identify the independent variable and the dependent variable. (2 marks)
(d) Identify two variables that must be kept constant and state how each can be controlled. (2 marks)
(e) Outline a method, including how the dependent variable will be measured and how the reliability of the results could be improved. (2 marks)
(f) State one safety precaution the student should take. (1 mark)

Total for Question 4: 10 marks$mq$, $mq$(a) A question linking pH of the solution to germination of cress seeds, e.g. "How does the pH of the water given to cress seeds affect the percentage of seeds that germinate after five days?" [1].
(b) A prediction that links the variables, e.g. the lower the pH (the more acidic), the fewer seeds will germinate [1]; reason, e.g. acid damages the seed coat and embryo or interferes with the enzymes needed for germination [1].
(c) Independent variable: pH of the solution (3, 4, 5, 6, 7) [1]; dependent variable: number or percentage of seeds that germinate (accept length of shoots) [1].
(d) Any two with control: number of seeds per dish (e.g. 20 seeds in each); volume of solution added each day (measured with the cylinder); temperature and light (same shelf or incubator); same type, age and batch of seeds; same time period [1][1] (one mark for each variable with a method).
(e) Method: place the same number of seeds on wet filter paper in each dish, add the same volume of the solution of each pH, leave under the same conditions and count the seeds that germinate after a fixed time (e.g. five days) [1]; improve reliability by repeating each pH at least three times (three dishes per pH) and calculating a mean [1].
(f) Any one: wear safety goggles when handling the acid; wipe up spills; wash hands after handling seeds and solutions; dilute acid correctly [1].$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | C 12]]
Raw sewage containing organic waste is released into a river from a town. Students measured the concentration of dissolved oxygen at sites downstream of the outflow, and counted the mayfly nymphs (animals that need well-oxygenated water) in a standard sample of the river bed at each site. They took one reading at each site on the same day.

Distance downstream from the outflow (km): 1, 2, 3, 4, 5, 6
Dissolved oxygen (mg/dm3): 3.4, 4.6, 5.4, 6.0, 4.1, 7.0
Mayfly nymphs per sample: 0, 2, 5, 9, 12, 15

(a) Identify the independent variable and the dependent variable for the dissolved oxygen measurements. (2 marks)
(b) Describe the trend in dissolved oxygen with distance from the outflow. (2 marks)
(c) Identify the anomalous result and suggest one reason why it might have occurred. (2 marks)
(d) Calculate the mean dissolved oxygen concentration at the first four sites (1 km to 4 km). (2 marks)
(e) Explain what the data show about the effect of the sewage on the river. (2 marks)
(f) Evaluate the method used by the students and suggest one improvement. (2 marks)

Total for Question 5: 12 marks$mq$, $mq$(a) Independent variable: distance downstream from the outflow [1]; dependent variable: dissolved oxygen concentration (mg/dm3) [1].
(b) Dissolved oxygen increases as the distance from the outflow increases [1]; from 3.4 mg/dm3 at 1 km to 7.0 mg/dm3 at 6 km (excluding the anomaly), with the largest increase at the start [1].
(c) 4.1 mg/dm3 at 5 km [1]; reason, any one: a measurement or probe error; the probe was not calibrated or left in the water for too short a time; a local inflow of polluted water or a stagnant pool at that site; a recording error [1]. The mayfly count of 12 at 5 km suggests the oxygen there is likely to be higher.
(d) (3.4 + 4.6 + 5.4 + 6.0) / 4 [1] = 19.4 / 4 = 4.85 mg/dm3 [1] (accept 4.9).
(e) Close to the outflow oxygen is low and no mayflies survive (0 at 1 km) [1]; bacteria decomposing the organic waste use up oxygen, and oxygen recovers (and mayfly numbers rise from 2 to 15) further downstream as the waste is diluted and used up and oxygen dissolves from the air [1].
(f) Evaluation, one strength or weakness [1], e.g. weaknesses: only one reading per site, so no way to check reliability; only six sites and one day; there was no upstream control site to show the oxygen level before the outflow; strengths: the mayfly counts provide a second line of evidence. One improvement [1], e.g. repeat readings at each site and calculate a mean; add an upstream site; repeat on different days or seasons.$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | D 10]]
Calder Bay is a fishing area where 85 families depend on small boats. A coastal government has proposed a marine reserve that would ban all fishing in 30% of the bay's waters. Studies of similar reserves elsewhere found that the mass of fish inside increased by 60% within five years and that young fish and eggs drifted out to neighbouring waters. Fishing families would lose access to 30% of their fishing grounds, although they would receive compensation of $4,000 per boat per year for five years. Dive companies expect the reserve to attract 12,000 visitors a year. Patrolling the reserve would cost $250,000 per year. An elders' council says that one cove in the proposed reserve has been a family fishing place for generations and holds cultural importance.

(a) State one economic factor and one environmental factor that are evident in the passage. (2 marks)
(b) Outline one benefit and one risk of the proposal. (2 marks)
(c) Explain how the reserve could, over time, benefit the fishing families. (2 marks)
(d) Discuss whether the reserve should go ahead, considering at least two different factors (such as ethical, social, economic, cultural, political or environmental). (4 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) Economic: compensation of $4,000 per boat, loss of fishing income, tourism income, patrol cost of $250,000 [1]. Environmental: fish mass increases by 60%, protection of fish stocks and young fish [1]. Accept any other correct factor linked to evidence in the passage.
(b) Benefit, any one: fish stocks recover; income from diving tourism; spillover of young fish to fishing areas [1]. Risk, any one: loss of income for fishing families after compensation ends; fishing effort concentrated in the remaining 70% may cause overfishing there; illegal fishing if enforcement is weak; loss of cultural access [1].
(c) Fish inside the reserve grow larger and breed [1]; young fish and eggs drift into neighbouring waters, so catches outside the reserve can rise in the long term (more sustainable fishing and income) [1].
(d) Up to 4: factors identified and linked to the passage, each developed (e.g. economic: compensation ends after five years but tourism brings 12,000 visitors and the cost of patrols is $250,000; environmental: biomass recovery and healthier ecosystem; cultural: the elders' fishing cove; ethical: fairness to families who depend on fishing vs the duty to protect marine life; political: government must balance fishing voters and conservation targets) [1][1]; a balanced discussion that weighs benefits and risks for different stakeholders [1]; a justified conclusion or a conditional recommendation, e.g. proceed but keep the cove accessible for traditional fishing and extend compensation [1].$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | C 10]]
The island of Tharsay has 3,000 households. Each household uses an average of 4.0 MWh of electricity per year. At present all electricity comes from diesel generators, which release 0.8 tonnes of carbon dioxide for every MWh of electricity produced. The island council is considering one wind turbine with a rated power of 2.0 MW. Because the wind is not constant, the turbine is expected to produce on average 35% of its rated power over a year. There are 8,760 hours in a year. The turbine costs $3.6 million. Each MWh of wind electricity saves $95 of diesel fuel.

(a) Calculate the island's total electricity use in one year. (1 mark)
(b) Show that one turbine is expected to produce about 6,100 MWh of electricity per year. (2 marks)
(c) Calculate the percentage of the island's electricity use that one turbine would supply. (1 mark)
(d) Calculate the mass of carbon dioxide, in tonnes per year, that one turbine would avoid. (2 marks)
(e) Determine the smallest number of turbines needed to supply the island's total electricity use over a year. (1 mark)
(f) Calculate how many years the savings in diesel fuel from one turbine would take to repay its cost. (2 marks)
(g) State one reason why the electricity output of a wind turbine varies. (1 mark)

Total for Question 7: 10 marks$mq$, $mq$(a) 3,000 x 4.0 = 12,000 MWh per year [1].
(b) Average power = 2.0 x 0.35 = 0.70 MW [1]; energy = 0.70 x 8,760 = 6,132 MWh, which is about 6,100 MWh [1].
(c) 6,132 / 12,000 x 100 = 51% (51.1%) [1].
(d) 6,132 x 0.8 [1] = 4,906 tonnes (4,905.6) [1].
(e) 12,000 / 6,132 = 1.96, so 2 turbines [1].
(f) Savings per year = 6,132 x $95 = $582,540 [1]; payback = 3,600,000 / 582,540 = 6.2 years [1].
(g) The wind speed changes (no wind or too strong a wind means the turbine produces little or stops) [1].
Error carried forward is allowed between parts.$mq$, $mq$C$mq$),
(8, $mq$[[Q 8 | A 5 | B 2 | C 4 | D 3]]
Along a rocky coast, kelp (large brown seaweed) forms underwater forests that shelter fish, crabs and young sea animals. Sea urchins graze on kelp. Sea otters eat sea urchins. Over twenty years, scientists surveyed the same stretch of coast.

Year: 2000, 2005, 2010, 2015, 2020
Sea otters counted: 120, 95, 60, 35, 22
Sea urchins per square metre: 4, 7, 14, 22, 30
Kelp canopy cover of the sea bed (%): 78, 66, 41, 24, 15

(a) Describe the relationship between the number of sea otters and the amount of kelp. (2 marks)
(b) Calculate the percentage decrease in kelp canopy cover between 2000 and 2020, to one decimal place. (2 marks)
(c) Explain how a decline in sea otters can lead to a loss of kelp, using the term trophic cascade. (3 marks)
(d) Explain why the loss of kelp forest reduces biodiversity on this coast. (2 marks)
(e) Outline a monitoring plan that could show whether the number of sea otters and the kelp cover are recovering. (2 marks)
(f) Two management options are proposed. Option 1: reintroduce sea otters from a healthy population at a cost of $1.5 million over five years. Option 2: pay divers to remove urchins, costing $400,000 every year. Evaluate the two options and recommend one. (3 marks)

Total for Question 8: 14 marks$mq$, $mq$(a) As the number of sea otters falls, kelp cover falls [1]; a positive relationship / strong correlation, e.g. otters 120 to 22 while kelp falls from 78% to 15% [1] (accept inverse relationship with urchins as additional comment).
(b) (78 - 15) / 78 x 100 [1] = 80.8% (80.77) [1].
(c) Sea otters are predators of sea urchins; fewer otters mean fewer urchins are eaten [1]; urchin numbers rise (4 to 30 per square metre) and they graze more kelp [1]; a trophic cascade is a chain of effects that runs down the food web from the loss of a top predator, so the kelp (producers) declines [1].
(d) Kelp provides food and shelter/habitat for many species, so when it is lost these organisms lose their food and hiding places [1]; species move away or die, so species richness and the number of individuals decline (also fewer producers, so less energy enters the food web) [1].
(e) Repeat the same survey regularly (e.g. every year at the same time, using the same sites and methods) to count sea otters and urchins and measure kelp cover (e.g. with quadrats or photographs) [1]; compare with the 2020 baseline values and keep other conditions recorded (water temperature) so changes can be judged reliably [1].
(f) Evaluation, 3 marks: Option 1 addresses the cause by restoring a predator and is cheaper in the long term ($1.5 million over five years = $300,000 a year) but is slow and uncertain, and otters may not survive [1]; Option 2 gives quick results as urchins are removed, costing $400,000 each year (= $2 million over five years) but must continue indefinitely and treats the symptom only [1]; a clear recommendation supported by reasons (e.g. Option 1 for the long-term, perhaps with urchin removal in the short-term) [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Extended Mathematics MYP 5 eAssessment Structure Mock A (8 tasks, 98 marks) (98 marks)
with sub as (select id from public.subjects where slug = $mq$extended-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Extended Mathematics MYP 5 eAssessment Structure Mock A (8 tasks, 98 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Extended Mathematics MYP 5 eAssessment Structure Mock A (8 tasks, 98 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 7 | C 2 | D 1]]
Logarithms and bounds. In this question logarithms without a base are to base 10.
(a) [A1] Evaluate log₂(1/8). (1 mark)
(b) [A1 C1] Show that 2 log 6 − log 9 + log 25 = 2. (2 marks)
(c) [A1 D1] A bacteria culture grows so that the number of cells after t hours is N = 500 × 1.8^t. Find, to 3 significant figures, the time taken for the culture to reach 4000 cells. (2 marks)
(d) [A2] An athlete runs 400 m, measured correct to the nearest metre, in 53.2 seconds, measured correct to 1 decimal place. Calculate the greatest possible average speed. (2 marks)
(e) [A2] Calculate the least possible average speed. (2 marks)
(f) [C1] Hence write down the average speed to a suitable degree of accuracy. Justify your answer. (1 mark)

Total for Question 1: 10 marks$mq$, $mq$(a) -3 [1]. (b) 2 log 6 = log 36 and log 36 − log 9 + log 25 = log(36 × 25 / 9) [1]; = log 100 = 2, with the working shown (no unsupported calculator value) [1]. (c) 500 × 1.8^t = 4000 so 1.8^t = 8 [1]; t = log 8 / log 1.8 = 3.54 hours [1]. (d) Upper bound of distance 400.5 m and lower bound of time 53.15 s [1]; 400.5 / 53.15 = 7.535 m/s [1]. (e) Lower bound of distance 399.5 m and upper bound of time 53.25 s [1]; 399.5 / 53.25 = 7.502 m/s [1]. (f) 7.5 m/s, because both bounds (7.535 and 7.502) round to 7.5 to 2 significant figures, so that is the most accurate value that can be stated with certainty [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8 | C 1]]
Rational and trigonometric graphs. The function f is defined by f(x) = (2x + 1)/(x − 3) for x ≠ 3. The function g is defined by g(x) = 3 sin(2x°) + 1 for 0 ≤ x ≤ 180.
(a) [A2] Write down the equations of the two asymptotes of the graph of y = f(x). (2 marks)
(b) [A2] Find the coordinates of the points where the graph of y = f(x) crosses the x-axis and the y-axis. (2 marks)
(c) [A2] State the amplitude and the period of the graph of y = g(x). (2 marks)
(d) [A2] Solve g(x) = 2.5. (2 marks)
(e) [C1] Explain why the equation f(x) = 2 has no solution. (1 mark)

Total for Question 2: 9 marks$mq$, $mq$(a) x = 3 [1]; y = 2 [1]. (b) x-axis: 2x + 1 = 0 so (−1/2, 0) [1]; y-axis: f(0) = 1/(−3) so (0, −1/3) [1]. (c) Amplitude 3 [1]; period 180° [1]. (d) sin(2x°) = 0.5, so 2x = 30 or 150 [1]; x = 15 or x = 75 [1] (no other solutions in the domain, since 2x < 360). (e) y = 2 is the horizontal asymptote, which the graph approaches but never reaches (algebraically 2x + 1 = 2x − 6 gives 1 = −6, which is impossible) [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 6 | C 1]]
Transformations of quadratic functions. The function f is defined by f(x) = x² − 6x + 5.
(a) [A2] Write f(x) in the form (x − p)² + q. (2 marks)
(b) [A2] Write down the coordinates of the vertex and the equation of the axis of symmetry of the graph of y = f(x). (2 marks)
(c) [A2] The graph of y = f(x) is translated by the vector (2, 3) to give the graph of y = g(x). Find g(x) and write it in the form x² + bx + c. (2 marks)
(d) [C1] Use your answer to (c) to justify that the graph of y = g(x) crosses the x-axis at x = 4 and x = 6. (1 mark)

Total for Question 3: 7 marks$mq$, $mq$(a) (x − 3)² [1]; − 4, giving (x − 3)² − 4 [1]. (b) Vertex (3, −4) [1]; axis of symmetry x = 3 [1]. (c) g(x) = f(x − 2) + 3 = (x − 5)² − 1 [1]; g(x) = x² − 10x + 24 [1]. (d) x² − 10x + 24 = (x − 4)(x − 6) = 0 gives x = 4 and x = 6 [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 6 | C 1]]
Sine rule, cosine rule and area. A triangular plot of land ABC has AB = 85 m, AC = 112 m and angle BAC = 62°. Diagram not to scale. [Description: triangle ABC with A at the top left, the 62° angle at A between sides AB and AC.]
(a) [A3] Calculate the length of BC. (3 marks)
(b) [A2] Calculate the size of angle ABC. (2 marks)
(c) [A1 C1] Show that the area of the plot is 4200 m² to 3 significant figures. (2 marks)

Total for Question 4: 7 marks$mq$, $mq$(a) BC² = 85² + 112² − 2 × 85 × 112 × cos 62° [1]; BC² = 10 830 (to 4 significant figures) [1]; BC = 104 m (3 significant figures) [1]. (b) sin B / 112 = sin 62° / 104.07 [1]; angle ABC = 71.8° [1] (accept 71.9° from a rounded value of BC). (c) Area = ½ × 85 × 112 × sin 62° [1]; = 4203 m², which is 4200 m² to 3 significant figures [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | A 6 | C 2]]
Probability and standard deviation. Machine A makes 60% of a factory's phone cases and machine B makes the other 40%. Of the cases from machine A, 2% are defective. Of the cases from machine B, 5% are defective.
(a) [A2] Find the probability that a case chosen at random is defective. (2 marks)
(b) [A2] A defective case is found. Find the probability that it came from machine A. (2 marks)
(c) [C2] Two classes sat the same test. Class X had mean 62 and standard deviation 4.1. Class Y had mean 60 and standard deviation 11.5. Compare the performance of the two classes. (2 marks)
(d) [A2] Calculate the standard deviation of the data set 6, 8, 8, 10, 13. (2 marks)

Total for Question 5: 8 marks$mq$, $mq$(a) 0.6 × 0.02 + 0.4 × 0.05 [1]; = 0.012 + 0.020 = 0.032 [1]. (b) P(A | defective) = 0.012 / 0.032 [1]; = 3/8 = 0.375 [1]. (c) Class X has the higher mean, so slightly higher marks on average [1]; Class Y has the larger standard deviation, so its marks are more spread out / less consistent, X's marks are closer together [1]. (d) Mean = 45/5 = 9 [1]; standard deviation = √(28/5) = √5.6 = 2.37 [1] (accept 2.65 if the sample formula is used).$mq$, $mq$A$mq$),
(6, $mq$[[Q 6 | A 5 | C 2]]
Circle geometry and similarity. Points A, B, C and D lie on a circle in that order. The chords AC and BD intersect at X. Angle BAC = 38°, AX = 6 cm, XD = 9 cm and AB = 7 cm. Diagram not to scale. [Description: a circle with two crossing chords AC and BD meeting inside the circle at X.]
(a) [A2] Write down the size of angle BDC and give a reason. (2 marks)
(b) [C2] Show that triangles AXB and DXC are similar. (2 marks)
(c) [A1] Find the length of DC. (1 mark)
(d) [A2] In a different circle, PQRS is a cyclic quadrilateral with angle PQR = 95°. Find angle PSR and state the circle theorem that you used. (2 marks)

Total for Question 6: 7 marks$mq$, $mq$(a) 38° [1]; angles in the same segment (subtended by the same chord BC) are equal [1]. (b) Angle BAX = angle CDX (= 38°) [1]; angle AXB = angle DXC (vertically opposite angles), so the triangles are similar (two equal angles) [1]. (c) AB / DC = AX / DX so DC = 7 × 9 / 6 = 10.5 cm [1]. (d) Angle PSR = 180° − 95° = 85° [1]; opposite angles of a cyclic quadrilateral sum to 180° [1].$mq$, $mq$A$mq$),
(7, $mq$[[Q 7 | A 7 | C 2 | D 11]]
Real-life modelling: planning a bakery's day. Harbour Bakery bakes x sourdough loaves and y fruit cakes each day. A loaf needs 20 minutes of oven time and a cake needs 40 minutes, and the oven is available for 480 minutes each day. Ingredients cost $3 per loaf and $4 per cake and the daily ingredient budget is $61. At most 14 loaves can be sold each day and the bakery must make at least 3 cakes. The profit is $2.50 per loaf and $4 per cake. The feasible region for the constraints is a pentagon with vertices (0, 3), (0, 12), (13, 5.5), (14, 4.75) and (14, 3).
The bakery delivers to a cafe at S through junctions P, Q and R. [Description: a weighted network with nodes B (the bakery), P, Q, R and S. Edge lengths in km: B-P 4, B-Q 6, P-Q 3, P-R 7, Q-R 4, Q-S 8, R-S 3.] Diagram not to scale.
(a) [A1 C1] Show that the oven constraint can be written as x + 2y ≤ 24. (2 marks)
(b) [A3] Write down inequalities for the ingredient budget, the number of loaves sold and the minimum number of cakes. (3 marks)
(c) [A1 C1] Show that the lines x + 2y = 24 and 3x + 4y = 61 meet at the point (13, 5.5). (2 marks)
(d) [D3] Write an expression for the daily profit P in dollars. Calculate P at each of the five vertices. (3 marks)
(e) [D3] The bakery can only make whole numbers of loaves and cakes. Determine the whole-number plan that gives the greatest profit. Justify your answer by testing at least two other plans near the boundary of the region. (3 marks)
(f) [A2 D1] Determine the shortest route from B to S and its length. Show that you have compared the alternatives. (3 marks)
(g) [D4] The van costs $1.20 per km and makes one round trip each day from B to S and back along the shortest route. Design a daily plan for the bakery, stating the quantities of each item and the route. Justify whether the bakery should make the delivery. (4 marks)

Total for Question 7: 20 marks$mq$, $mq$(a) 20x + 40y ≤ 480 [1]; divide by 20 to get x + 2y ≤ 24 [1]. (b) 3x + 4y ≤ 61 [1]; x ≤ 14 [1]; y ≥ 3 [1]. (c) x = 24 − 2y, so 3(24 − 2y) + 4y = 61 [1]; 72 − 2y = 61 so y = 5.5 and x = 13 [1]. (d) P = 2.5x + 4y [1]; values 12, 48, 54.5, 54, 47 for the vertices in the order given [2] (award 1 mark for three or four correct values). (e) Plan 12 loaves and 6 cakes (oven: 12 + 12 = 24, cost: 36 + 24 = $60 so both constraints are met) [1]; profit $54 [1]; other plans tested, for example (13, 5) gives $52.50 and (14, 4) gives $51 [1], showing that rounding the best vertex does not give the best plan. (f) Alternatives compared, for example B-P-R-S = 14, B-Q-S = 14, B-P-Q-R-S = 14 [1]; shortest route B-Q-R-S [1]; length 6 + 4 + 3 = 13 km [1]. (g) Plan: 12 loaves and 6 cakes, route B-Q-R-S-R-Q-B [1]; round trip 26 km costs 26 × 1.20 = $31.20 [1]; net profit 54 − 31.20 = $22.80 per day [1]; the delivery still makes a profit, so it is worthwhile, with a valid comment such as that a delivery is worthwhile only if the cafe's orders are included in the sales figures or that fixed costs such as wages are ignored [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | B 16 | C 13 | D 1]]
Investigation: lines dividing a plane. Straight lines are drawn on a flat sheet of paper. No two lines are parallel and no three lines pass through the same point. Let R be the greatest number of regions that n lines can divide the sheet into. With 0 lines there is 1 region, with 1 line there are 2 regions, with 2 lines there are 4 regions and with 3 lines there are 7 regions. Diagrams not to scale. [Description: three lines forming a triangle in the middle with 7 regions in total.]
(a) [B2] Find R for n = 4 and for n = 5 (you may draw diagrams). (2 marks)
(b) [B1 C1] Calculate the differences R_n − R_(n−1) for n = 1 to 5 and describe the pattern in them. (2 marks)
(c) [B2] Use the pattern to find R for n = 6 and for n = 7. (2 marks)
(d) [C3] Explain why drawing the nth line adds exactly n new regions. (3 marks)
(e) [B1 C1] Show that the second differences of R are constant. What does this tell you about the form of the rule for R? (2 marks)
(f) [B3] Find the rule R = an² + bn + c for the number of regions. (3 marks)
(g) [B1 C1] Verify your rule for n = 7. (2 marks)
(h) [C3] Justify your rule by writing R as 1 plus a sum and finding the sum of 1 + 2 + ... + n. (3 marks)
(i) [B2 D1] A city planner draws straight paths across a park. The paths must divide the park into at least 500 separate plots. Find the smallest number of paths needed. (3 marks)
(j) [B1 C2] Let P be the number of points where two lines cross. Show that P = n(n − 1)/2 and hence show that R = 1 + n + P gives the same rule as before. (3 marks)
(k)(i) [B1] Now suppose 3 lines pass through the same point. State the number of regions they make. (1 mark)
(k)(ii) [C2] Explain why the rule gives 7 for three lines but the lines through one point give fewer regions. (2 marks)
(k)(iii) [B2] Four lines are drawn so that exactly three of them pass through one point and the fourth line is in general position. Find the number of regions. (2 marks)

Total for Question 8: 30 marks$mq$, $mq$(a) R = 11 for n = 4 [1]; R = 16 for n = 5 [1]. (b) Differences 1, 2, 3, 4, 5 [1]; the differences increase by 1 each time / the difference at n equals n [1]. (c) R = 16 + 6 = 22 [1]; R = 22 + 7 = 29 [1]. (d) The new line crosses each of the n − 1 existing lines once, at n − 1 different points (no parallel lines, no three lines through one point) [1]; these points cut the new line into n pieces [1]; each piece splits one existing region into two, so n regions are added [1]. (e) First differences 1, 2, 3, 4, 5 so second differences 1, 1, 1, 1 [1]; a constant second difference means the rule is quadratic in n [1]. (f) Using n = 0, 1, 2: c = 1, a + b + c = 2, 4a + 2b + c = 4 [1]; solving gives a = 1/2 and b = 1/2 [1]; R = (n² + n + 2)/2 [1]. (g) R = (49 + 7 + 2)/2 = 29 [1]; this agrees with the value found in part (c) [1]. (h) R = 1 + 1 + 2 + ... + n [1]; writing the sum forwards and backwards, each pair adds to n + 1 and there are n pairs so 2S = n(n + 1) [1]; R = 1 + n(n + 1)/2 = (n² + n + 2)/2 [1]. (i) (n² + n + 2)/2 ≥ 500 [1]; n = 31 gives 497, which is too few [1]; n = 32 gives 529, so 32 paths are needed [1]. (j) Each pair of lines meets once so P = n(n − 1)/2 [1]; R = 1 + n + n(n − 1)/2 [1]; = (2 + 2n + n² − n)/2 = (n² + n + 2)/2 [1]. (k)(i) 6 regions [1]. (k)(ii) The third line crosses the first two lines at the same point, so it makes only 1 crossing point instead of 2 [1]; it is cut into 2 pieces, not 3, so it adds 2 regions rather than 3 [1]. (k)(iii) The fourth line crosses the three lines at 3 different points, so it is cut into 4 pieces [1]; regions = 6 + 4 = 10 [1].$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- Extended Mathematics MYP 5 eAssessment Structure Mock B (8 tasks, 99 marks) (99 marks)
with sub as (select id from public.subjects where slug = $mq$extended-mathematics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Extended Mathematics MYP 5 eAssessment Structure Mock B (8 tasks, 99 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Extended Mathematics MYP 5 eAssessment Structure Mock B (8 tasks, 99 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 7 | C 3]]
Logarithms and bounds. In this question logarithms without a base are to base 10.
(a) [A1] The acidity of a solution is measured by pH = −log[H⁺], where [H⁺] is the concentration of hydrogen ions in mol/dm³. Calculate the pH of a solution with [H⁺] = 3.2 × 10⁻⁵, to 2 decimal places. (1 mark)
(b) [A2] Solve log₂(x + 3) = 5. (2 marks)
(c) [A1 C1] Given that log_a 2 = p and log_a 3 = q, express log_a 12 in terms of p and q. Show your working. (2 marks)
(d) [A3] A metal block has mass 612 g, measured to the nearest gram, and volume 85 cm³, measured to the nearest cubic centimetre. Calculate the greatest and the least possible values of its density, using density = mass ÷ volume. (3 marks)
(e) [C2] Write down the density to a suitable degree of accuracy. Justify your answer using your bounds. (2 marks)

Total for Question 1: 10 marks$mq$, $mq$(a) pH = −log(3.2 × 10⁻⁵) = 4.49 [1]. (b) x + 3 = 2⁵ = 32 [1]; x = 29 [1]. (c) 12 = 2² × 3, so log_a 12 = 2 log_a 2 + log_a 3 [1]; = 2p + q [1]. (d) Upper bound of mass 612.5 g and lower bound of volume 84.5 cm³, or lower bound of mass 611.5 g and upper bound of volume 85.5 cm³ [1]; greatest density 612.5 / 84.5 = 7.2485... g/cm³ [1]; least density 611.5 / 85.5 = 7.1520... g/cm³ [1]. (e) 7.2 g/cm³ [1]; both bounds round to 7.2 to 2 significant figures (but would differ at 3 significant figures: 7.25 and 7.15) so 7.2 is the most accurate value that can be stated with certainty [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 6 | C 1 | D 2]]
Rational and trigonometric graphs. The function f is defined by f(x) = 4/(x + 1) − 2 for x ≠ −1. The depth d of water in a harbour, in metres, t hours after midnight is modelled by d = 4.5 + 1.8 cos(30t°) for 0 ≤ t ≤ 12.
(a) [A2] Write down the equations of the two asymptotes of the graph of y = f(x). (2 marks)
(b) [A2] Find the coordinates of the points where the graph of y = f(x) crosses the y-axis and the x-axis. (2 marks)
(c) [A2] State the greatest depth, the least depth and the period of the model. (2 marks)
(d) [D2 C1] A fishing boat needs a depth of at least 3.6 m to enter the harbour. Determine the times between t = 0 and t = 12 when the boat cannot enter the harbour. (3 marks)

Total for Question 2: 9 marks$mq$, $mq$(a) x = −1 [1]; y = −2 [1]. (b) y-axis: f(0) = 4 − 2 = 2, so (0, 2) [1]; x-axis: 4/(x + 1) = 2 gives x + 1 = 2, so (1, 0) [1]. (c) Greatest depth 6.3 m and least depth 2.7 m [1]; period 360 / 30 = 12 hours [1]. (d) 4.5 + 1.8 cos(30t) = 3.6 gives cos(30t°) = −0.5 [1]; 30t = 120 or 240 so t = 4 or t = 8 [1]; the depth is below 3.6 m between t = 4 and t = 8, so the boat cannot enter for those 4 hours [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 6 | C 1]]
Transformations of quadratic functions. The function f is defined by f(x) = 2x² − 12x + 10.
(a) [A2] Write f(x) in the form a(x − p)² + q. (2 marks)
(b) [A1 C1] Describe the sequence of transformations that maps the graph of y = x² onto the graph of y = f(x). (2 marks)
(c) [A2] Solve f(x) = 0. (2 marks)
(d) [A1] The graph of y = f(x) is reflected in the x-axis to give the graph of y = g(x). State the maximum value of g(x). (1 mark)

Total for Question 3: 7 marks$mq$, $mq$(a) 2(x² − 6x) + 10, or 2(x − 3)² [1]; 2(x − 3)² − 8 [1]. (b) A vertical stretch with scale factor 2 [1]; followed by a translation by the vector (3, −8) [1]. (c) 2(x − 3)² = 8 so (x − 3)² = 4 [1]; x = 1 or x = 5 [1] (accept factorising 2(x − 1)(x − 5)). (d) 8 [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 6 | C 1]]
Sine rule and cosine rule. A triangular sail PQR has PQ = 7.2 m, QR = 9.5 m and PR = 12.1 m. Diagram not to scale. [Description: triangle PQR with PR as the longest side at the bottom.]
(a) [A3] Calculate the size of angle PQR. (3 marks)
(b) [A2] Calculate the size of angle QPR. (2 marks)
(c) [A1 C1] Show that the area of the sail is 34.2 m², correct to 3 significant figures. (2 marks)

Total for Question 4: 7 marks$mq$, $mq$(a) cos Q = (7.2² + 9.5² − 12.1²) / (2 × 7.2 × 9.5) [1]; = −0.0316 [1]; angle PQR = 91.8° [1]. (b) sin P / 9.5 = sin 91.8° / 12.1 [1]; angle QPR = 51.7° [1] (acute, because angle Q is obtuse). (c) Area = ½ × 7.2 × 9.5 × sin 91.8° [1]; = 34.18..., which is 34.2 m² to 3 significant figures [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | A 7 | C 1]]
Sets and standard deviation. At a sports academy, 80 students were asked which of football (F), basketball (B) and swimming (S) they play. The results are: n(F) = 36, n(B) = 31, n(S) = 25, n(F ∩ B) = 12, n(F ∩ S) = 10, n(B ∩ S) = 9, n(F ∩ B ∩ S) = 4, and 15 students play none of the three. [Description: a Venn diagram with three overlapping circles F, B and S inside a rectangle.]
(a) [A1 C1] Show that 8 students play football and basketball but not swimming. (2 marks)
(b) [A2] Find the number of students who play swimming only. (2 marks)
(c) [A2] A student who plays football is chosen at random. Find the probability that this student also plays swimming. (2 marks)
(d) [A2] The number of goals scored by 20 players in a match is: 0 goals, 4 players; 1 goal, 7 players; 2 goals, 6 players; 3 goals, 3 players. Calculate the mean and the standard deviation of the number of goals. (2 marks)

Total for Question 5: 8 marks$mq$, $mq$(a) The 12 who play F and B include the 4 who play all three [1]; 12 − 4 = 8 [1]. (b) Swimming and football only = 10 − 4 = 6 and swimming and basketball only = 9 − 4 = 5 [1]; 25 − 6 − 5 − 4 = 10 [1]. (c) P(S | F) = n(F ∩ S) / n(F) = 10/36 [1]; = 5/18 (0.278) [1]. (d) Mean = 28/20 = 1.4 [1]; standard deviation = √(58/20 − 1.4²) = √0.94 = 0.970 [1].$mq$, $mq$A$mq$),
(6, $mq$[[Q 6 | A 7 | C 1]]
Circle geometry and similarity. A circle has centre O and radius 5 cm. The point P is outside the circle with OP = 13 cm. The lines PA and PB are tangents to the circle at A and B. Diagram not to scale. [Description: a circle with a point P to the right of it; two tangents from P touch the circle at A (above) and B (below).]
(a) [C1] Explain why angle OAP = 90°. (1 mark)
(b) [A2] Calculate the length of PA. (2 marks)
(c) [A2] Calculate the area of quadrilateral OAPB. (2 marks)
(d) [A2] A model of a monument is made to a scale of 1 : 25. The surface area of the model is 0.18 m². Calculate the surface area of the real monument. (2 marks)
(e) [A1] The volume of the model is 0.004 m³. Calculate the volume of the real monument. (1 mark)

Total for Question 6: 8 marks$mq$, $mq$(a) A tangent is perpendicular to the radius at the point of contact [1]. (b) PA² = 13² − 5² = 144 [1]; PA = 12 cm [1]. (c) Area of triangle OAP = ½ × 5 × 12 = 30 cm² [1]; triangle OBP is congruent (tangents from P are equal in length) so the area is 2 × 30 = 60 cm² [1]. (d) Area scale factor 25² = 625 [1]; 0.18 × 625 = 112.5 m² [1]. (e) 0.004 × 25³ = 62.5 m³ [1].$mq$, $mq$A$mq$),
(7, $mq$[[Q 7 | A 6 | C 1 | D 13]]
Real-life modelling: a robotics club. A school robotics club builds x rover kits and y drone kits each term. A rover kit takes 3 hours to assemble and a drone kit takes 2 hours, and 36 hours of volunteer time are available. A rover kit has parts costing $20 and a drone kit has parts costing $30, and the parts budget is $360. The club must build at least 2 of each kit. The profit is $18 per rover kit and $25 per drone kit. The feasible region is a quadrilateral with vertices (2, 2), (32/3, 2), (7.2, 7.2) and (2, 32/3).
The kits are delivered from the workshop W to the school S through junctions A, B, C and D. [Description: a weighted network with nodes W, A, B, C, D and S. Edge lengths in km: W-A 5, W-B 8, A-B 2, A-C 9, B-C 5, B-D 7, C-D 3, C-S 6, D-S 4.] Diagram not to scale.
(a) [A2] Write down two inequalities, in x and y, for the assembly time and for the parts budget. Simplify each as far as possible. (2 marks)
(b) [A1 C1] Show that the boundary lines of your inequalities meet at the point (7.2, 7.2). (2 marks)
(c) [D3] Write an expression for the profit P in dollars. Calculate the profit at each of the four vertices. (3 marks)
(d) [D3] The club can only build whole numbers of kits. Determine the whole-number plan that gives the greatest profit. Justify your answer by testing at least two other plans near the vertex (7.2, 7.2). (3 marks)
(e) [A2 D1] Determine the length of the shortest route from W to S. Show that you have compared the alternatives. (3 marks)
(f) [A1 D1] The road between A and B is closed. Find the new shortest distance from W to S and the increase in the journey length. (2 marks)
(g) [D5] The courier charges $2.50 per km for one round trip from W to S and back along the shortest route, to deliver all the kits. The school offers to collect the kits itself if the club reduces its price by $60 in total. Design the club's term plan, stating the kits built, and justify whether the club should deliver or let the school collect. (5 marks)

Total for Question 7: 20 marks$mq$, $mq$(a) 3x + 2y ≤ 36 [1]; 20x + 30y ≤ 360 simplifies to 2x + 3y ≤ 36 [1]. (b) Solving 3x + 2y = 36 and 2x + 3y = 36, for example adding to get 5x + 5y = 72 [1]; subtracting gives x = y, so x = y = 7.2 [1]. (c) P = 18x + 25y [1]; values 86, 242, 309.6 and 302.67 (to 2 decimal places) in the order given [2] (award 1 mark for two or three correct values). (d) Plan 6 rover kits and 8 drone kits (3 × 6 + 2 × 8 = 34 ≤ 36 and 2 × 6 + 3 × 8 = 36 ≤ 36, so both constraints are met) [1]; profit $308 [1]; other plans tested, for example (7, 7) gives $301, (3, 10) gives $304 and (8, 6) gives $294, so rounding the vertex to (7, 7) is not the best plan [1]. (e) Alternatives compared, for example W-B-C-S = 19 and W-A-C-S = 20 [1]; shortest route W-A-B-C-S or W-A-B-D-S (the two tie) [1]; length 18 km [1]. (f) New shortest is W-B-C-S or W-B-D-S, 19 km [1]; increase of 1 km [1]. (g) Plan 6 rover kits and 8 drone kits, profit $308 [1]; delivery cost 2 × 18 × 2.50 = $90 [1]; profit with delivery 308 − 90 = $218 [1]; profit with collection 308 − 60 = $248 [1]; the club should let the school collect since $248 is greater than $218, with a valid limitation such as the price reduction is a one-off or that the school may not always be able to collect [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | B 14 | C 12 | D 4]]
Investigation: folding a paper strip. A long strip of paper is 2000 mm long and 0.1 mm thick. It is folded in half, end to end, again and again. Each fold doubles the number of layers and halves the length. After n folds the number of layers is L_n, the thickness is T_n mm and the length is S_n mm. When the strip is unfolded again, the folds leave creases. Let c_n be the number of creases after n folds. After 1 fold c_1 = 1, after 2 folds c_2 = 3. Diagrams not to scale.
(a) [B2] The first values are L_0 = 1, L_1 = 2 and L_2 = 4. Find L_3, L_4 and L_5. (2 marks)
(b) [B1 C1] Write down a rule for L_n in terms of n and name the type of sequence. (2 marks)
(c) [B1 D1] Calculate the thickness of the folded strip after 10 folds. (2 marks)
(d) [B1 C1] Show that 7 is the smallest number of folds for which the thickness exceeds 1 cm. (2 marks)
(e) [B2 C1] Use logarithms to find the smallest number of folds for the thickness to exceed 1 metre. (3 marks)
(f) [B2] Find c_3, c_4 and c_5 by considering how the creases double with each fold. (2 marks)
(g) [B1 C1] Write down a rule for c_n in terms of n and verify it for n = 5. (2 marks)
(h) [C3] Justify your rule by showing that if c_n = 2^n − 1 then c_(n+1) = 2^(n+1) − 1, given that each fold doubles the creases and adds one new one. (3 marks)
(i) [B1 C2] The creases can also be counted as c_n = 1 + 2 + 4 + ... + 2^(n−1). Show that this sum equals 2^n − 1 by multiplying the sum by 2 and subtracting. (3 marks)
(j) [B1 D1] Calculate the length of the folded strip after 6 folds. (2 marks)
(k) [C2] Show that the product T_n × S_n is the same for every n and state its value. (2 marks)
(l) [B2 C1 D2] A student claims that the strip can be folded in half 12 times. Calculate the length and the thickness after 12 folds and evaluate the student's claim. (5 marks)

Total for Question 8: 30 marks$mq$, $mq$(a) L_3 = 8, L_4 = 16, L_5 = 32 [2] (award 1 mark for two correct values). (b) L_n = 2^n [1]; geometric sequence with common ratio 2 [1]. (c) T_10 = 0.1 × 2^10 [1]; = 102.4 mm [1]. (d) 6 folds: 0.1 × 64 = 6.4 mm, which is less than 10 mm [1]; 7 folds: 0.1 × 128 = 12.8 mm, which is more than 10 mm [1]. (e) 0.1 × 2^n > 1000 so 2^n > 10 000 [1]; n > log 10 000 / log 2 = 13.29 [1]; n = 14 (checks: 2^13 × 0.1 = 819.2 mm is not enough and 2^14 × 0.1 = 1638.4 mm is enough) [1]. (f) c_3 = 7, c_4 = 15, c_5 = 31 [2] (award 1 mark for two correct values or the method c_(n+1) = 2c_n + 1). (g) c_n = 2^n − 1 [1]; 2^5 − 1 = 31, which agrees with part (f) [1]. (h) c_(n+1) = 2c_n + 1 [1]; = 2(2^n − 1) + 1 [1]; = 2^(n+1) − 2 + 1 = 2^(n+1) − 1, so the rule holds for the next fold (it holds for n = 1, so for all n) [1]. (i) S = 1 + 2 + ... + 2^(n−1), so 2S = 2 + 4 + ... + 2^n [1]; 2S − S = 2^n − 1 [1]; so S = 2^n − 1, matching the rule in (g) [1]. (j) S_6 = 2000 / 2^6 [1]; = 31.25 mm [1]. (k) T_n × S_n = 0.1 × 2^n × 2000 / 2^n [1]; = 200 mm² for every n, because the 2^n terms cancel (the volume of paper does not change) [1]. (l) S_12 = 2000 / 4096 = 0.488 mm [1]; T_12 = 0.1 × 4096 = 409.6 mm [1]; the stack would be over 800 times thicker than it is long, which is physically impossible for a real strip [1]; the model assumes that each fold exactly halves the length, but real paper bends around each fold and uses up length, so the claim is not realistic [1]; clear conclusion that the claim is not supported by the model [1].$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);


commit;
