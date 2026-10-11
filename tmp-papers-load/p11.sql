begin;
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

-- English Language and Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks) (80 marks)
with sub as (select id from public.subjects where slug = $mq$english-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$English Language and Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$English Language and Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1.1 | A 2]]
Task 1: Analysing
Questions 1.1 to 1.4 focus on the key concept of communication. Question 1.5 focuses on the key concept of connections. The criteria assessed are A (Analysing) and B (Organizing). Suggested time for Questions 1.1 to 1.4: 15 minutes. Suggested time for Question 1.5: 35 minutes.

Text A: 'The Spice Tin' (an extract from a short story, written for this paper)
This extract describes Rania, a girl who has recently arrived in England, on the evening a parcel from her mother reaches her.

The tin arrived in the second week of November, wrapped in a jumper that smelled of someone else's house. Rania carried it up the stairs of the flat as if it might spill, though the lid was sealed with tape, and set it on the windowsill beside the radiator, where the cold glass of an English evening pressed against it.

On the lid her mother had written in Arabic, in the looping hand that had once signed every one of Rania's school reports: for the soup that cures things. Rania did not open it. She knew what she would find: cumin, coriander, the dark crumbs of dried lime, all ground by her grandmother's wrists in a kitchen in a city that no airline flew to any more.

Downstairs, the neighbours' television laughed at something. Somebody was frying onions, but they were the wrong onions. The smell was too thin, too polite.

At school she had been Rania for two months, which is to say she had been Ray-nee-a, then Rainy, then, whenever Mr Whitfield took the register, a brief and hopeful silence while he searched the page for how she was supposed to sound. She had stopped correcting him. Correcting took energy she needed for the other work: the daily labour of arranging her face into a person who was fine.

On the phone her mother said, "You are eating? You are speaking English all day?" and Rania said yes to both, because yes was the shortest road to the end of the call.

Now she lifted the tin and held it against her chest. It weighed almost nothing. It weighed everything. When she finally prised off the tape and the lid, the smell rose like a hand laid on the back of her neck, and for a moment the radiator, the rain, the wrong onions, all of it went quiet.

She said her own name aloud, slowly, the way her grandmother used to, with the rolled r that English had no room for. Rania. Rania. It sounded like a door she had not realised was still unlocked.

Text B: webpage for 'Suitcase Stories', a community exhibition (written for this paper; in the live exam this would be a screen image)

[Layout: A wide banner photograph fills the top of the page. An open brown leather suitcase rests on a bare wooden floor. It holds no clothes. Instead it is crammed with small objects: a dented kettle, a school photograph, a paper bag of seeds, a football scarf and a child's red shoe. The light falls softly from the left. Across a deep teal band beneath the photograph, in large white capitals, are the words:]

WHAT WOULD YOU CARRY?

[Subheading in white italics:] Twenty-six people. Twenty-six suitcases. One city that is still learning to call itself home.

[The page divides into two columns below a thin gold line.]

[Left column, heading in teal capitals:] THE EXHIBITION
Every object here has crossed a border. Some arrived in a pocket, some in the back of a lorry, some only in the memory of a person who had to leave the real thing behind. For six weeks they sit under glass at Eastfield Library, beside the words of the people who carried them. Come and listen.

[A small photograph sits beneath this text: an elderly man holding a chipped enamel cup in both hands and looking just past the camera. Caption in grey italics:] Tomasz, 74, carried this cup from Gdansk in 1981. "It is worth nothing. That is why it is worth everything."

[Right column, heading in teal capitals:] JOIN IN
- Bring one object and tell us its story (open table, every Saturday, 2 p.m.)
- Record a message in your first language for our listening wall
- Help us translate the labels into twenty languages

[A bright yellow button, centred below both columns, reads:] ADD YOUR STORY

[A pull quote in large serif type is set between two thin lines across the full width of the page:] "Home is not only where you come from. It is what you refuse to leave behind."

[Footer in small grey type:] Free entry. Step-free access. 14 March to 30 April. A project of Eastfield Library and the Eastfield Welcome Network.

Q 1.1 Comment on the use of the senses in the first two paragraphs of Text A. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a sense or sensory detail with a reference to the text but does not explain its effect, e.g. 'a jumper that smelled of someone else's house' appeals to smell. [1] Level 2 (2 marks): comments on the use of the senses with an example and some explanation, e.g. smell ('someone else's house'), touch ('the cold glass of an English evening pressed against it') and sight ('the looping hand') build a sense of Rania's loneliness in an unfamiliar place and make the parcel feel precious as a link with her mother. [1] Accept any valid sense and effect (hearing is not yet used in these paragraphs). Award 0 for no or incorrect reference to the text.$mq$, $mq$A$mq$),
(2, $mq$[[Q 1.2 | A 3]]
Refer to Text A (printed in Question 1.1). Explain the effect of the lines: 'Somebody was frying onions, but they were the wrong onions. The smell was too thin, too polite.' (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies an effect without developing it, e.g. the lines show that Rania misses her home. [1] Level 2 (2 marks): describes an effect with some example or explanation, e.g. the repeated 'wrong onions' shows that even ordinary smells are foreign to her, so she feels she does not belong. [1] Level 3 (3 marks): explains the effect consistently with well-chosen quotation, e.g. the personification of the smell as 'too polite' suggests the new country is courteous but distant and cold, contrasted with the warmth of the spices; the short, flat sentence rhythm after the longer sentence echoes her sense of disappointment and isolation. [1] Accept any valid reading supported by the text.$mq$, $mq$A$mq$),
(3, $mq$[[Q 1.3 | A 2]]
Refer to Text B (printed in Question 1.1). Describe the purpose of the question 'WHAT WOULD YOU CARRY?' in the banner. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a purpose without explanation, e.g. it makes the reader think. [1] Level 2 (2 marks): describes the purpose with an example or explanation, e.g. the direct question addresses the reader personally and invites them to imagine being forced to leave home, so that they feel empathy before reading about the exhibition; the large capitals on teal make it the first thing the eye sees and catch attention. [1] Accept: to engage and involve the audience; to introduce the theme of what matters most.$mq$, $mq$A$mq$),
(4, $mq$[[Q 1.4 | A 3]]
Refer to Text B (printed in Question 1.1). Analyse the effect of a technique used in Text B. (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies a technique and an effect with no development, e.g. there is a photograph of a suitcase. [1] Level 2 (2 marks): describes the effect of one technique with some justification, e.g. the suitcase holds everyday objects such as a kettle and a child's shoe, which makes the migrants' lives seem familiar and human to the reader. [1] Level 3 (3 marks): analyses the effect consistently with a precise example, e.g. the caption quotation 'It is worth nothing. That is why it is worth everything.' uses paradox and a personal voice to show that value is emotional, not financial, and the contrast with the gentle grey caption text makes the old man's words stand out; or the imperative button 'ADD YOUR STORY' turns the audience from observers into participants. [1] Accept any valid technique: layout, colour, imagery, list structure, repetition of 'Twenty-six', pull quote, direct address.$mq$, $mq$A$mq$),
(5, $mq$[[Q 1.5 | A 10 | B 10]]
Refer to Text A and Text B (printed in Question 1.1). Compare and contrast how the concept of identity is explored in the two texts. (Approximately 350 words) (20 marks)

Criterion A (Analysing) is worth 10 marks and Criterion B (Organizing) is worth 10 marks.$mq$, $mq$Total 20 marks: Criterion A (10) and Criterion B (10). Criterion A Analysing (10 marks). 0: no work that meets a descriptor. 1-2 (limited): identifies some content, language, structure or technique with few or no examples; little sense of how the texts relate. 3-4 (adequate): describes some features of the texts with some examples; a degree of understanding of how features create meaning; some awareness of similarity or difference. 5-6 (considerable): explains the effect of a range of features with relevant examples from both texts; clear understanding of how meaning is created; sound awareness of similarities and differences. 7-8 (substantial): analyses the effect of content, language, structure and technique in both texts with well-chosen evidence; thoughtful understanding of the writers' and creators' choices and of the relationship between the texts. 9-10 (excellent): perceptive, sustained analysis of both texts with precise, well-integrated evidence; insightful evaluation of how and why meaning is shaped, and a discerning view of the relationship between the texts. Indicative content for A (not exhaustive; credit any valid, evidenced point). Text A: identity under pressure; the mispronounced name (Ray-nee-a, Rainy) and the 'person who was fine' show a self that is diminished and masked; the tin, the smell and the grandmother's pronunciation carry identity across distance; third-person limited narration and the final door metaphor create a private, quiet moment of reclaiming the self; imagery of senses and sentence rhythm. Text B: identity as shared, collective and public; objects and stories are displayed so that identity is recorded, respected and celebrated; the use of numbers ('Twenty-six'), the direct address of the question, the caption voice of Tomasz, the pull quote and the invitation to participate; the multimodal layout moves the audience from empathy to action. Similarities: both use ordinary objects (tin, cup, suitcase) as symbols of belonging; both link identity to memory, language and home; both ask the audience to value what has been left behind. Differences: private, painful and unresolved in Text A versus public, hopeful and communal in Text B; fiction showing one voice versus an informative and persuasive text showing many; narrative interiority versus direct address. Award up to [10] for Criterion A. Criterion B Organizing (10 marks). 0: no work that meets a descriptor. 1-2 (limited): little structure; the texts are mostly treated separately or in a list; ideas are hard to follow; little or no concluding thought. 3-4 (adequate): some structure with an opening and a close; both texts are discussed with a few links; some paragraphing and a degree of coherence. 5-6 (considerable): a clear structure; comparison and contrast appear in most paragraphs; ideas are generally logical and linked; an appropriate conclusion. 7-8 (substantial): an effective, purposeful structure; comparison and contrast are woven through the response; transitions are controlled and ideas build; a developed conclusion. 9-10 (excellent): a sophisticated, fully controlled structure that shapes the argument; comparison and contrast are integrated throughout; seamless linking; a conclusion that synthesizes the argument. Look for a comparative structure (for example by idea or by technique), topic sentences that name both texts, comparative connectives (whereas, similarly, in contrast) and a conclusion. Award up to [10] for Criterion B.$mq$, $mq$A$mq$),
(6, $mq$[[Q 2 | C 10 | D 10]]
Task 2: Producing literary text
This task focuses on the key concept of creativity. The criteria assessed are C (Producing text) and D (Using language). Suggested time: 35 minutes.

Image 1 (described in words): a single battered suitcase stands alone on a deserted railway platform at dusk. The last carriage of a train, its windows lit orange, is pulling away into the distance. A yellow lamp flickers overhead and rain gleams on the platform.
Image 2 (described in words): the inside of a kitchen window, steamed up on a winter morning. Someone has drawn a small heart in the condensation and, beside it, pressed a child's handprint, through which the street outside is blurred into grey and gold.

Using one of the images, write the opening of a story about a character who must leave something behind, or who returns to something they have left behind. You may consider purpose, characterisation, setting, mood and point of view. State which image you are using before you start. (Approximately 350 words) (20 marks)$mq$, $mq$Total 20 marks: Criterion C (10) and Criterion D (10). Criterion C Producing text (10 marks). 0: no work that meets a descriptor. 1-2 (limited): limited creative choices; little imagination or insight; little detail; the image or prompt is hardly used. 3-4 (adequate): some creative choices; some imagination and insight; some relevant detail; the image and prompt are used in a basic way. 5-6 (considerable): thoughtful creative choices of content, character, setting and point of view; considerable imagination and insight; sufficient relevant detail. 7-8 (substantial): purposeful, imaginative choices; a developed voice and perspective; substantial insight; well-chosen detail that supports a clear purpose. 9-10 (excellent): highly original, perceptive choices; an assured, distinctive voice and perspective; extensive, precise detail and a controlled narrative or poetic shape that fully serves the prompt. A response that uses neither image and does not address the prompt scores 0 for Criterion C. Indicative content: the named image is clearly used as a starting point; a character with a believable reason to leave or return; a controlled setting and mood (for example transience, nostalgia, uncertainty); sensory detail; a deliberate point of view; an opening that creates curiosity. Credit narrative, descriptive or poetic forms if they work as an opening. Award up to [10] for Criterion C. Criterion D Using language (10 marks). 0: no work that meets a descriptor. 1-2 (limited): limited range of vocabulary and structures; errors are frequent and often hinder communication; register is rarely appropriate. 3-4 (adequate): adequate range; a degree of accuracy; errors sometimes hinder communication; register is sometimes appropriate. 5-6 (considerable): a varied range of vocabulary, sentence structures and devices; considerable accuracy; errors do not hinder communication; register and style are generally appropriate. 7-8 (substantial): an effective range used with control; high accuracy with occasional slips; register and style are consistently appropriate and purposeful. 9-10 (excellent): a sophisticated, flexible range used with precision and flair; highly accurate with only minor errors; register and style are skilfully sustained throughout. Look for varied sentence length, precise verbs and imagery, effective control of tense, and accurate punctuation of dialogue where used. Award up to [10] for Criterion D.$mq$, $mq$C$mq$),
(7, $mq$[[Q 3 | B 10 | C 10 | D 10]]
Task 3: Producing non-literary text
This task focuses on the key concept of perspective. You will create a piece of non-literary writing in relation to the global context orientation in space and time: migration and the movement of people. The criteria assessed are B (Organizing), C (Producing text) and D (Using language). Suggested time: 50 minutes.

Write a feature article for your school magazine under the title 'Between Two Places' about what it means to belong to more than one place or culture, and what a welcoming school community can do to help newcomers feel they belong. Use a clear structure and the conventions of a feature article, such as a headline, an engaging opening, a balance of personal voice and evidence, and a closing thought. (Approximately 350 words) (30 marks)$mq$, $mq$Total 30 marks: Criterion B (10), Criterion C (10) and Criterion D (10). Criterion B Organizing (10 marks). 0: no work that meets a descriptor. 1-2 (limited): little organisation; few or no text-type conventions; ideas not sequenced; paragraphing absent or random. 3-4 (adequate): some organisation; some conventions of the text type are used; a basic opening and ending; paragraphing is mostly logical. 5-6 (considerable): a clear structure; most conventions of the text type are used appropriately; ideas are generally sequenced and linked. 7-8 (substantial): an effective structure; conventions of the text type used purposefully; clear progression with controlled links and an effective opening and close. 9-10 (excellent): a skilfully crafted structure; conventions of the text type exploited for effect; seamless progression, with every paragraph contributing to the purpose and audience. Indicative content: headline and possible standfirst; a hook (an anecdote, a striking image or a question); developed paragraphs on belonging and identity; examples drawn from school life, language, food, friendship or traditions; a quotation or interview, real or imagined; a balanced call to action; a closing line that links back to the opening. Award up to [10] for Criterion B. Criterion C Producing text (10 marks). 0: no work that meets a descriptor. 1-2 (limited): little insight into the global context or topic; little relevant detail; limited sense of audience and purpose. 3-4 (adequate): some insight into the global context; some relevant detail and examples; some awareness of audience and purpose. 5-6 (considerable): considerable insight into the global context and the topic; sufficient relevant detail and examples; a clear perspective and a good sense of audience and purpose. 7-8 (substantial): substantial, well-developed insight; well-chosen examples that support the argument; an assured perspective and a controlled appeal to the audience. 9-10 (excellent): perceptive, original insight into the global context; extensive, precise detail and examples; a distinctive, convincing perspective that fully serves the audience and purpose. Indicative content: insight into migration as both loss and gain; the experience of newcomers and of those who welcome them; specific, plausible suggestions such as buddy systems, language clubs, shared meals and a curriculum that reflects many histories; awareness that identity can be plural. Award up to [10] for Criterion C. Criterion D Using language (10 marks). 0: no work that meets a descriptor. 1-2 (limited): limited range of vocabulary and structures; errors are frequent and often hinder communication; register is rarely appropriate. 3-4 (adequate): adequate range; a degree of accuracy; errors sometimes hinder communication; register is sometimes appropriate. 5-6 (considerable): a varied range of vocabulary, sentence structures and devices; considerable accuracy; errors do not hinder communication; register and style are generally appropriate. 7-8 (substantial): an effective range used with control; high accuracy with occasional slips; register and style are consistently appropriate and purposeful. 9-10 (excellent): a sophisticated, flexible range used with precision and flair; highly accurate with only minor errors; register and style are skilfully sustained throughout. Look for an engaging journalistic register that is semi-formal, rhetorical devices used purposefully (rule of three, anecdote, inclusive pronouns, rhetorical question), and accurate grammar, spelling and punctuation. Award up to [10] for Criterion D.$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- English Language and Literature MYP 5 eAssessment Structure Mock B (7 tasks, 80 marks) (80 marks)
with sub as (select id from public.subjects where slug = $mq$english-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$English Language and Literature MYP 5 eAssessment Structure Mock B (7 tasks, 80 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$English Language and Literature MYP 5 eAssessment Structure Mock B (7 tasks, 80 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1.1 | A 2]]
Task 1: Analysing
Questions 1.1 to 1.4 focus on the key concept of communication. Question 1.5 focuses on the key concept of connections. The criteria assessed are A (Analysing) and B (Organizing). Suggested time for Questions 1.1 to 1.4: 15 minutes. Suggested time for Question 1.5: 35 minutes.

Text A: 'Night Mode' (an extract from a short story, written for this paper)
This extract describes Kofi, a fifteen-year-old, awake in his bedroom in the early hours of a school night.

At 1.17 a.m. the phone lit Kofi's face from below, which made him look, he thought, like someone telling a ghost story to himself. He was not asleep. He had stopped pretending to be around midnight, when the tenth video in a row about a stranger's perfect morning had slid into the eleventh without his thumb ever deciding anything.

The screen gave nothing back. That was its gift and its crime. It never grew tired, never said enough, never looked at him with the particular patience of his father at the kitchen table. It simply refreshed, and a new face appeared, laughing at a joke he had missed.

Somewhere below his window a bin lorry groaned, and the ordinary noise startled him: a real thing, made by real people on a real night shift. He looked up. His bedroom had been there all along: the poster peeling at one corner, the chemistry homework glowing faintly white on the desk like a small accusation, the dark square of the window.

The phone buzzed in his hand.

Mara: you up?

Three words. He typed an answer, deleted it, typed another. Every version looked like a boy pretending not to care. In the end he did what he always did. He sent a thumbs-up, a small yellow hand lifted in the dark, and the conversation ended where it had begun.

Mara had been his best friend since they were seven. Mara lived four streets away. They sat in the same row in registration, and in six weeks neither had said a sentence to the other that was longer than a reaction.

He lay back. The ceiling had a crack in it shaped like a river. For a second he imagined pulling on his trainers, walking the four streets, and throwing a pebble at her window. Four streets was nothing. It had somehow become the longest distance he knew.

He turned the phone face down on the duvet. The room did not collapse. The light drained from his hands, and the darkness came up around him, soft and enormous and slightly frightening, like the deep end when you first let go of the side.

Text B: poster for 'The Look Up Challenge' (written for this paper; in the live exam this would be an image)

[Layout: a tall poster with a dark navy background. The top two-thirds is a photograph of a crowded bus stop at dusk. Six people stand in a row and every head is bowed over a glowing phone, their faces lit a pale, ghostly blue. The whole photograph is in muted blue-grey, with one exception. At the far right edge a small girl in a yellow raincoat looks straight out at the viewer, and in her hand is a bright red paper kite.]

[Across the middle of the poster, in huge white capitals:] WHO ARE YOU MISSING?

[Beneath it, in smaller gold type:] Our survey of 2,000 teenagers found that most check their phones more than eighty times a day. How many times did you look up?

[Centred body text in white, in short lines, with generous space between them:]
Your friends are not in your pocket.
They are at the next bus stop.
The next table.
The next street.

[A row of three small white icons, each with a one-word caption underneath: a phone lying face down, "PARK IT"; two speech bubbles, "SAY IT"; a sunrise over a hill, "GO OUTSIDE".]

Seven days. One rule. When you are with people, phones go face down.

[Across the bottom, a bright red band with white capitals:] START MONDAY. TELL THREE FRIENDS. #LOOKUP

[Small print in the bottom corner:] A project of the Greenfield Youth Trust. Join in at lookupchallenge.example. No apps. No downloads. Just people.

Q 1.1 Comment on the use of light in the first two paragraphs of Text A. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a use of light with a reference to the text but does not explain its effect, e.g. the phone 'lit Kofi's face from below'. [1] Level 2 (2 marks): comments on the use of light with an example and some explanation, e.g. the cold glow of the phone from below, compared to a ghost-story teller, makes Kofi seem eerie and cut off, and suggests the screen is the only source of life in his night; the screen 'gave nothing back' as light without warmth. [1] Accept any valid effect, for example isolation, unreality or the unnatural hour. Award 0 for no or incorrect reference to the text.$mq$, $mq$A$mq$),
(2, $mq$[[Q 1.2 | A 3]]
Refer to Text A (printed in Question 1.1). Explain the effect of the lines: 'Four streets was nothing. It had somehow become the longest distance he knew.' (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies an effect without developing it, e.g. it shows Kofi is far from his friend. [1] Level 2 (2 marks): describes an effect with some example or explanation, e.g. the contrast between 'nothing' and 'the longest distance' shows that physical closeness has been replaced by emotional distance. [1] Level 3 (3 marks): explains the effect consistently with well-chosen quotation, e.g. the very short first sentence mirrors how easy the walk would be, then the longer second sentence with the reflective 'somehow' conveys Kofi's confusion and sadness; the paradox implies that constant digital contact has made real contact harder, so the reader feels the loss of the friendship. [1] Accept any valid reading supported by the text.$mq$, $mq$A$mq$),
(3, $mq$[[Q 1.3 | A 2]]
Refer to Text B (printed in Question 1.1). Describe the purpose of the colour in the photograph. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a purpose without explanation, e.g. the colours make the people look dull. [1] Level 2 (2 marks): describes the purpose with an example or explanation, e.g. the muted blue-grey of the phone users makes them look cold and lifeless, while the bright red kite and the yellow raincoat of the girl draw the eye and suggest that real life, play and connection are vivid and are found by looking up. [1] Accept: to contrast absorption in screens with the energy of the real world; to focus on the girl as the model of behaviour.$mq$, $mq$A$mq$),
(4, $mq$[[Q 1.4 | A 3]]
Refer to Text B (printed in Question 1.1). Analyse the effect of a technique used in Text B. (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies a technique and an effect with no development, e.g. the poster uses a question as the headline. [1] Level 2 (2 marks): describes the effect of one technique with some justification, e.g. the question 'WHO ARE YOU MISSING?' addresses the viewer directly and makes them feel slightly guilty, so they keep reading. [1] Level 3 (3 marks): analyses the effect consistently with a precise example, e.g. the list structure 'The next bus stop. The next table. The next street.' uses repetition and a falling rhythm to move from the public to the personal, so that friends seem close enough to reach; the red band with imperatives 'START MONDAY. TELL THREE FRIENDS.' turns guilt into a simple action. [1] Accept any valid technique: statistics, imagery, imperative verbs, hashtag, icons, small print 'No apps. Just people.', layout.$mq$, $mq$A$mq$),
(5, $mq$[[Q 1.5 | A 10 | B 10]]
Refer to Text A and Text B (printed in Question 1.1). Compare and contrast how the relationship between technology and human connection is presented in the two texts. (Approximately 350 words) (20 marks)

Criterion A (Analysing) is worth 10 marks and Criterion B (Organizing) is worth 10 marks.$mq$, $mq$Total 20 marks: Criterion A (10) and Criterion B (10). Criterion A Analysing (10 marks). 0: no work that meets a descriptor. 1-2 (limited): identifies some content, language, structure or technique with few or no examples; little sense of how the texts relate. 3-4 (adequate): describes some features of the texts with some examples; a degree of understanding of how features create meaning; some awareness of similarity or difference. 5-6 (considerable): explains the effect of a range of features with relevant examples from both texts; clear understanding of how meaning is created; sound awareness of similarities and differences. 7-8 (substantial): analyses the effect of content, language, structure and technique in both texts with well-chosen evidence; thoughtful understanding of the writers' and creators' choices and of the relationship between the texts. 9-10 (excellent): perceptive, sustained analysis of both texts with precise, well-integrated evidence; insightful evaluation of how and why meaning is shaped, and a discerning view of the relationship between the texts. Indicative content for A (not exhaustive; credit any valid, evidenced point). Text A: technology as a seductive and isolating force; the endless scroll ('slid into the eleventh without his thumb ever deciding anything'), the personified screen that 'gave nothing back', the thumbs-up as a failed message, the contrast of the bin lorry and the peeling poster (the real world) with the phone; close third-person narration and the tentative ending in darkness that suggests possible change without resolving it. Text B: technology as a barrier that can be overcome by choice; the visual contrast of the muted crowd and the red kite; direct address, statistics, imperatives and a call to action; the tone moves from guilt to encouragement and practical hope ('No apps. Just people.'). Similarities: both show people physically near but emotionally apart; both use colour or light to separate the screen world from the real one; both suggest that real connection is within reach. Differences: private, ambiguous, internal in Text A versus public, persuasive and purposeful in Text B; Text A shows the problem through one character's story, Text B proposes a solution to a whole group; narrative withholds an answer, while the poster gives a clear one. Award up to [10] for Criterion A. Criterion B Organizing (10 marks). 0: no work that meets a descriptor. 1-2 (limited): little structure; the texts are mostly treated separately or in a list; ideas are hard to follow; little or no concluding thought. 3-4 (adequate): some structure with an opening and a close; both texts are discussed with a few links; some paragraphing and a degree of coherence. 5-6 (considerable): a clear structure; comparison and contrast appear in most paragraphs; ideas are generally logical and linked; an appropriate conclusion. 7-8 (substantial): an effective, purposeful structure; comparison and contrast are woven through the response; transitions are controlled and ideas build; a developed conclusion. 9-10 (excellent): a sophisticated, fully controlled structure that shapes the argument; comparison and contrast are integrated throughout; seamless linking; a conclusion that synthesizes the argument. Look for a comparative structure (for example by idea or by technique), topic sentences that name both texts, comparative connectives (whereas, similarly, in contrast) and a conclusion. Award up to [10] for Criterion B.$mq$, $mq$A$mq$),
(6, $mq$[[Q 2 | C 10 | D 10]]
Task 2: Producing literary text
This task focuses on the key concept of creativity. The criteria assessed are C (Producing text) and D (Using language). Suggested time: 35 minutes.

Image 1 (described in words): an old television set glows in a dark, empty living room. A single armchair is pulled close to it, a cup of tea steaming on its arm, and the screen shows only grey static that casts a flickering light on the wallpaper and a framed family photograph.
Image 2 (described in words): a girl stands alone on a flat city rooftop at dawn, holding a small handheld radio with its aerial raised towards a pale sky. Behind her, the lights of towers and windows are fading as the sun comes up.

Using one of the images, write a scene in a story in which a character hears or sees something that changes how they understand the world. You may consider purpose, characterisation, setting, mood and point of view. State which image you are using before you start. (Approximately 350 words) (20 marks)$mq$, $mq$Total 20 marks: Criterion C (10) and Criterion D (10). Criterion C Producing text (10 marks). 0: no work that meets a descriptor. 1-2 (limited): limited creative choices; little imagination or insight; little detail; the image or prompt is hardly used. 3-4 (adequate): some creative choices; some imagination and insight; some relevant detail; the image and prompt are used in a basic way. 5-6 (considerable): thoughtful creative choices of content, character, setting and point of view; considerable imagination and insight; sufficient relevant detail. 7-8 (substantial): purposeful, imaginative choices; a developed voice and perspective; substantial insight; well-chosen detail that supports a clear purpose. 9-10 (excellent): highly original, perceptive choices; an assured, distinctive voice and perspective; extensive, precise detail and a controlled narrative or poetic shape that fully serves the prompt. A response that uses neither image and does not address the prompt scores 0 for Criterion C. Indicative content: the named image is clearly used as a starting point; a character with a clear motive; a controlled shift from not knowing to understanding; a purposeful setting and mood (for example anticipation, loneliness, wonder, unease); sensory detail, especially sound and light; a deliberate point of view; an ending that resonates. Credit science fiction, realist, mystery or poetic treatments. Award up to [10] for Criterion C. Criterion D Using language (10 marks). 0: no work that meets a descriptor. 1-2 (limited): limited range of vocabulary and structures; errors are frequent and often hinder communication; register is rarely appropriate. 3-4 (adequate): adequate range; a degree of accuracy; errors sometimes hinder communication; register is sometimes appropriate. 5-6 (considerable): a varied range of vocabulary, sentence structures and devices; considerable accuracy; errors do not hinder communication; register and style are generally appropriate. 7-8 (substantial): an effective range used with control; high accuracy with occasional slips; register and style are consistently appropriate and purposeful. 9-10 (excellent): a sophisticated, flexible range used with precision and flair; highly accurate with only minor errors; register and style are skilfully sustained throughout. Look for varied sentence length, precise verbs, controlled imagery and tense, and accurate punctuation. Award up to [10] for Criterion D.$mq$, $mq$C$mq$),
(7, $mq$[[Q 3 | B 10 | C 10 | D 10]]
Task 3: Producing non-literary text
This task focuses on the key concept of communication. You will create a piece of non-literary writing in relation to the global context scientific and technical innovation: digital life. The criteria assessed are B (Organizing), C (Producing text) and D (Using language). Suggested time: 50 minutes.

Your school is considering introducing a 'phone-free day' every week. Write a formal letter to the head teacher giving your view on this proposal and recommending what the school should do. Use a clear structure and the conventions of a formal letter, including an appropriate opening and close, a clear purpose, developed reasons supported by evidence and a persuasive but respectful tone. (Approximately 350 words) (30 marks)$mq$, $mq$Total 30 marks: Criterion B (10), Criterion C (10) and Criterion D (10). Criterion B Organizing (10 marks). 0: no work that meets a descriptor. 1-2 (limited): little organisation; few or no text-type conventions; ideas not sequenced; paragraphing absent or random. 3-4 (adequate): some organisation; some conventions of the text type are used; a basic opening and ending; paragraphing is mostly logical. 5-6 (considerable): a clear structure; most conventions of the text type are used appropriately; ideas are generally sequenced and linked. 7-8 (substantial): an effective structure; conventions of the text type used purposefully; clear progression with controlled links and an effective opening and close. 9-10 (excellent): a skilfully crafted structure; conventions of the text type exploited for effect; seamless progression, with every paragraph contributing to the purpose and audience. Indicative content: sender and recipient details or an acceptable letter layout, date, formal salutation and sign-off that match (Dear Mr/Ms X ... Yours sincerely, or Dear Sir or Madam ... Yours faithfully), a subject line or an opening that states the purpose, logically sequenced paragraphs (position, reasons, counterargument, recommendation) and a courteous close. Award up to [10] for Criterion B. Criterion C Producing text (10 marks). 0: no work that meets a descriptor. 1-2 (limited): little insight into the global context or topic; little relevant detail; limited sense of audience and purpose. 3-4 (adequate): some insight into the global context; some relevant detail and examples; some awareness of audience and purpose. 5-6 (considerable): considerable insight into the global context and the topic; sufficient relevant detail and examples; a clear perspective and a good sense of audience and purpose. 7-8 (substantial): substantial, well-developed insight; well-chosen examples that support the argument; an assured perspective and a controlled appeal to the audience. 9-10 (excellent): perceptive, original insight into the global context; extensive, precise detail and examples; a distinctive, convincing perspective that fully serves the audience and purpose. Indicative content: insight into digital life, including benefits (research, communication, creativity, safety) and costs (distraction, sleep, wellbeing, comparison, reduced face-to-face contact); a clear and defensible position; specific evidence or examples from school life; consideration of the head teacher's concerns; a practical recommendation such as a trial period with review. Award up to [10] for Criterion C. Criterion D Using language (10 marks). 0: no work that meets a descriptor. 1-2 (limited): limited range of vocabulary and structures; errors are frequent and often hinder communication; register is rarely appropriate. 3-4 (adequate): adequate range; a degree of accuracy; errors sometimes hinder communication; register is sometimes appropriate. 5-6 (considerable): a varied range of vocabulary, sentence structures and devices; considerable accuracy; errors do not hinder communication; register and style are generally appropriate. 7-8 (substantial): an effective range used with control; high accuracy with occasional slips; register and style are consistently appropriate and purposeful. 9-10 (excellent): a sophisticated, flexible range used with precision and flair; highly accurate with only minor errors; register and style are skilfully sustained throughout. Look for a consistently formal register (no slang or contractions unless justified), measured persuasive devices, effective connectives and accurate grammar, spelling and punctuation. Award up to [10] for Criterion D.$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- French ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 68 marks) (68 marks)
with sub as (select id from public.subjects where slug = $mq$french-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 68 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 68 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the voice message, then answer in English.

Message vocal de Mathieu :
« Salut Lucas, c'est Mathieu. Samedi, c'est mon anniversaire : j'ai quatorze ans ! Je fais une fête chez moi à dix-huit heures. Au menu, il y a un gâteau au chocolat et des pizzas. Tu peux apporter des boissons ? Après le repas, nous jouons aux jeux vidéo et nous écoutons de la musique. Ma maison est près de la gare, au numéro douze, rue Victor-Hugo. Réponds-moi vite ! À samedi ! »

(a) How old will Mathieu be on Saturday? (1 mark)
(b) At what time does the party start? (1 mark)
(c) Which two things will there be to eat? (2 marks)
(d) What is Lucas asked to bring? (1 mark)
(e) What two things will the guests do after the meal? (2 marks)
(f) Where is Mathieu's house? (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] 14 / fourteen
(b) [1] 6 pm / 18:00
(c) [1] Chocolate cake
[1] Pizzas (accept pizza)
(d) [1] Drinks
(e) [1] Play video games
[1] Listen to music
(f) [1] Near the station (also accept: 12 rue Victor-Hugo)$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the conversation, then answer in English.

À la gare
Employé : Bonjour, madame. Vous désirez ?
Cliente : Bonjour. Je voudrais des billets pour Lyon, s'il vous plaît.
Employé : Un aller simple ou un aller-retour ?
Cliente : Un aller-retour. C'est pour aujourd'hui.
Employé : Le prochain train part à quatorze heures quinze, du quai numéro trois. Le voyage dure deux heures.
Cliente : C'est combien ?
Employé : Un billet adulte coûte trente-huit euros et un billet enfant coûte dix-neuf euros.
Cliente : Alors, je voudrais un billet pour moi et un pour ma fille. Elle a huit ans. Je paie par carte.
Employé : Très bien. Voilà vos billets. Bon voyage !

(a) Where does the customer want to go? (1 mark)
(b) Does she want a single or a return ticket? (1 mark)
(c) At what time does the next train leave? (1 mark)
(d) From which platform does the train leave? (1 mark)
(e) How long does the journey take? (1 mark)
(f) How much is a child's ticket? (1 mark)
(g) How much does the customer pay in total for herself and her daughter? Show your working or give the total. (1 mark)
(h) How does she pay? (1 mark)

Total for Question 2: 8 marks$mq$, $mq$(a) [1] Lyon
(b) [1] Return (aller-retour)
(c) [1] 2.15 pm / 14:15
(d) [1] Platform 3 / number three
(e) [1] Two hours
(f) [1] 19 euros
(g) [1] 57 euros (38 + 19)
(h) [1] By card$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 10]]
Reading. Read the text, then answer in English.

Text A (message)
Salut Léa ! Mon téléphone est cassé, alors j'écris depuis l'ordinateur de mon père. Le week-end, je joue aux jeux vidéo, mais pas pendant la semaine parce que j'ai beaucoup de devoirs. Mon jeu préféré s'appelle « Planète Bleue ». Et toi, tu aimes jouer ? Hugo

Text B (poster)
CLUB INFORMATIQUE
Tu aimes les ordinateurs ? Rejoins le club informatique du collège !
Quand ? Le lundi et le vendredi, de midi à treize heures.
Où ? En salle 12, à côté de la bibliothèque.
Au programme : créer un site web, apprendre à programmer, jouer à des jeux éducatifs.
C'est gratuit ! Inscription auprès de Madame Roux.

(a) What is wrong with Hugo's phone? (1 mark)
(b) When does Hugo play video games? (1 mark)
(c) Why does he not play during the week? (1 mark)
(d) What is the name of his favourite game? (1 mark)
(e) On which two days does the computer club meet? (2 marks)
(f) Where does the club meet? (1 mark)
(g) Name one activity at the club. (1 mark)
(h) How much does the club cost? (1 mark)
(i) Who should students register with? (1 mark)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] It is broken
(b) [1] At the weekend
(c) [1] He has a lot of homework
(d) [1] Planète Bleue (Blue Planet)
(e) [1] Monday
[1] Friday
(f) [1] Room 12 (next to the library)
(g) [1] Any one of: create a website / learn to programme (code) / play educational games
(h) [1] Nothing / it is free
(i) [1] Madame Roux$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 12]]
Reading. Read the text, then answer in English.

Salut Tom !
Tu me demandes comment est ma ville. J'habite à Saint-Aubin, un petit village près de la mer, dans l'ouest de la France. Il y a deux mille habitants. Dans le village, il y a une boulangerie, une pharmacie, un petit supermarché et une église. Il n'y a pas de cinéma, mais il y a une grande plage. En été, il y a beaucoup de touristes : ils font de la voile et mangent des glaces. En hiver, il fait froid et il pleut souvent, mais j'aime mon village parce qu'il est calme. Pour aller au collège, je prends le bus : le collège est à dix kilomètres. Le week-end, je joue au volley sur la plage avec mes copains. L'année dernière, tu as visité Paris avec ta famille ; cet été, tu peux venir chez moi !
À bientôt, Camille

(a) Where is Saint-Aubin? Give two details. (2 marks)
(b) How many people live in Saint-Aubin? (1 mark)
(c) Name two shops or services in the village. (2 marks)
(d) What is there not in the village? (1 mark)
(e) What do tourists do in summer? Give two details. (2 marks)
(f) Why does Camille like the village in winter? (1 mark)
(g) How does Camille get to school, and how far away is it? (2 marks)
(h) What does Camille do at the weekend? (1 mark)

Total for Question 4: 12 marks$mq$, $mq$(a) [1] Near the sea
[1] In the west of France
(b) [1] 2000 / two thousand
(c) [1] Any one of: bakery / pharmacy / small supermarket (church is not accepted)
[1] A different one of these
(d) [1] A cinema
(e) [1] They go sailing
[1] They eat ice creams
(f) [1] It is calm / quiet
(g) [1] By bus
[1] 10 km / ten kilometres
(h) [1] Plays volleyball on the beach (with friends)$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | D 8]]
Language in context. Answer all parts. Parts (a) to (d) are gap-fills, (e) and (f) are choices, (g) and (h) are translations into the target language.

(a) Complete with the correct form of the verb in brackets: Nous ______ (habiter) dans une petite maison. (1 mark)
(b) Complete with the correct form of the verb in brackets: Mon frère ______ (avoir) seize ans. (1 mark)
(c) Complete with the correct form of the verb in brackets: Tu ______ (aller) au collège à pied ? (1 mark)
(d) Complete with the correct form of the verb in brackets: Elles ______ (faire) leurs devoirs. (1 mark)
(e) Choose the correct word, un or une: J'ai ______ chat noir. (1 mark)
(f) Choose the correct word, le or l' : Ma mère travaille à ______ hôpital. (1 mark)
(g) Translate into French: Tomorrow I am going to play tennis. (1 mark)
(h) Translate into French: There are three bedrooms in the house. (1 mark)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] habitons
(b) [1] a
(c) [1] vas
(d) [1] font
(e) [1] un
(f) [1] l'
(g) [1] Demain, je vais jouer au tennis. (accept: Je vais jouer au tennis demain.)
(h) [1] Il y a trois chambres dans la maison.$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | D 10]]
Writing. You will soon stay with a host family in France. Write an email to introduce yourself. Include: your name and age; where you live; one family member; two hobbies; a question for the family.

Write 60 to 70 words in French. (10 marks)

Total for Question 6: 10 marks$mq$, $mq$Content (1 mark each)
[1] Gives name and age (e.g. Je m'appelle Sam et j'ai quinze ans)
[1] Says where they live
[1] Describes at least one family member
[1] Mentions a first hobby (e.g. J'aime jouer au football)
[1] Mentions a second hobby
[1] Asks a question to the family (e.g. Vous avez un chien ?)
Language
[3] Vocabulary and grammar: 3 = mostly accurate with some variety of structures; 2 = generally accurate, simple structures; 1 = frequent errors, message still understood; 0 = not understandable
Organisation
[1] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 40 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | D 12]]
Writing. Your school magazine has a competition called « Protégeons notre planète ». Write an article. Include: one environmental problem; two things you do at home to protect the planet; one thing you did recently to help; one thing you are going to do next week; why you think it is important.

Write 80 to 90 words in French. (12 marks)

Total for Question 7: 12 marks$mq$, $mq$Content (1 mark each)
[1] Names a problem (e.g. la pollution, les déchets, le plastique)
[1] Gives a first action at home (e.g. Je recycle le papier)
[1] Gives a second action at home (e.g. J'éteins la lumière)
[1] Says what they did recently (past tense or a clear attempt, e.g. J'ai ramassé des déchets)
[1] Says what they will do next week (e.g. Je vais utiliser un vélo)
[1] Gives a reason or opinion (e.g. C'est important parce que la planète est notre maison)
Language
[4] Vocabulary and grammar: 4 = mostly accurate with some variety of structures; 3 = generally accurate, simple structures; 2 = frequent errors, message still understood; 1 = very limited; 0 = not understandable
Organisation
[2] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 50 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- French ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 68 marks) (68 marks)
with sub as (select id from public.subjects where slug = $mq$french-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 68 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 68 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the school announcement, then answer in English.

Annonce du collège :
« Bonjour à tous les élèves de troisième. Demain, mercredi, le cours de sciences est à neuf heures, en salle quinze. Apportez votre cahier et une calculatrice. Le cours de sport est annulé parce que le professeur est malade. Vendredi, c'est la fête de l'école. Les élèves peuvent venir avec leurs parents à partir de dix-sept heures. Il y a des jeux, un concert et un repas. Merci et bonne journée ! »

(a) On which day and at what time is the science lesson? (2 marks)
(b) In which room is the science lesson? (1 mark)
(c) What two things must students bring? (2 marks)
(d) Why is the sport lesson cancelled? (1 mark)
(e) On which day is the school party? (1 mark)
(f) Name one thing there will be at the party. (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] Wednesday
[1] 9 am / 09:00
(b) [1] Room 15 / fifteen
(c) [1] An exercise book / notebook
[1] A calculator
(d) [1] The teacher is ill / sick
(e) [1] Friday
(f) [1] Any one of: games / a concert / a meal$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the radio weather forecast, then answer in English.

Bulletin météo à la radio :
« Voici la météo pour demain. Dans le nord, il pleut le matin et il y a du vent l'après-midi. La température est de douze degrés. Dans l'est, il neige dans les montagnes. Dans le sud, il fait beau et chaud : vingt-sept degrés, avec beaucoup de soleil. À l'ouest, il y a du brouillard le matin, puis du soleil. Pour le week-end, il fait plus froid partout. Bonne journée ! »

(a) What is the weather like in the north in the morning? (1 mark)
(b) What is the weather like in the north in the afternoon? (1 mark)
(c) What is the temperature in the north? (1 mark)
(d) What is the weather like in the mountains in the east? (1 mark)
(e) What is the weather like in the south? (1 mark)
(f) What is the temperature in the south? (1 mark)
(g) What is the weather like in the west in the morning? (1 mark)
(h) What will the weather be like at the weekend? (1 mark)

Total for Question 2: 8 marks$mq$, $mq$(a) [1] Rain / it rains
(b) [1] Windy / wind
(c) [1] 12 degrees
(d) [1] Snow / it snows
(e) [1] Fine / nice and warm / sunny (accept any one of these)
(f) [1] 27 degrees
(g) [1] Fog / foggy
(h) [1] Colder (everywhere)$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 10]]
Reading. Read the text, then answer in English.

OFFRE D'EMPLOI
Le café Le Soleil, rue des Fleurs, cherche un serveur ou une serveuse pour juillet et août.
Tu as seize ans ou plus. Tu es sympa et tu aimes parler avec les gens.
Tu travailles du mardi au samedi, de dix heures à seize heures.
Salaire : neuf euros par heure. Un repas gratuit à midi.
Écris à Monsieur Blanc : cafelesoleil@exemple.fr

(a) In which two months is the job? (2 marks)
(b) What is the minimum age? (1 mark)
(c) Which two qualities does the café want? (2 marks)
(d) On which days does the person work? (1 mark)
(e) What are the working hours? (2 marks)
(f) How much is the pay per hour? (1 mark)
(g) What is free at midday? (1 mark)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] July
[1] August
(b) [1] 16 / sixteen
(c) [1] Friendly / nice
[1] Likes talking to people
(d) [1] Tuesday to Saturday
(e) [1] From 10 am / 10:00
[1] To 4 pm / 16:00
(f) [1] 9 euros
(g) [1] A meal$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 12]]
Reading. Read the text, then answer in English.

Mes vacances au Canada
Cet été, ma famille et moi, nous sommes allés au Canada, chez ma tante, à Québec. Nous avons pris l'avion à Paris. En juillet, il fait chaud, mais en hiver il fait très froid. Nous avons visité le vieux Québec et nous avons mangé des crêpes au sirop d'érable. Mon père a pris beaucoup de photos. À Québec, tout le monde parle français, et ma cousine parle aussi anglais. Demain, nous allons faire une promenade en bateau pour voir des baleines. Ensuite, nous allons rentrer à Paris.
Sarah

(a) Where did Sarah go on holiday? (1 mark)
(b) Whose house did the family stay at? (1 mark)
(c) How did the family travel? (1 mark)
(d) What is the weather like in July? (1 mark)
(e) What did they visit? (1 mark)
(f) What did they eat? Give two details. (2 marks)
(g) Who took a lot of photos? (1 mark)
(h) Which two languages does Sarah's cousin speak? (2 marks)
(i) What are they going to do tomorrow? (1 mark)
(j) What are they going to do after that? (1 mark)

Total for Question 4: 12 marks$mq$, $mq$(a) [1] Canada / Québec
(b) [1] Her aunt's
(c) [1] By plane
(d) [1] Warm / hot
(e) [1] The old town of Québec / old Québec
(f) [1] Pancakes / crêpes
[1] With maple syrup
(g) [1] Her father
(h) [1] French
[1] English
(i) [1] Go on a boat trip (to see whales)
(j) [1] Return / go back to Paris$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | D 8]]
Language in context. Answer all parts. Parts (a) to (d) use the words in the box: est · a · vais · prend. Parts (e) and (f) are adjective agreements. Parts (g) and (h) are translations into French.

(a) Complete with a word from the box: Ma mère ______ le bus pour aller au travail. (1 mark)
(b) Complete with a word from the box: Je ______ au marché samedi. (1 mark)
(c) Complete with a word from the box: Il ______ vingt ans. (1 mark)
(d) Complete with a word from the box: Mon père ______ médecin. (1 mark)
(e) Write the adjective in the correct form: Les chaussures sont ______ (noir). (1 mark)
(f) Write the adjective in the correct form: Ma sœur est ______ (content). (1 mark)
(g) Translate into French: I have a brother and two sisters. (1 mark)
(h) Translate into French: She likes playing the guitar. (1 mark)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] prend
(b) [1] vais
(c) [1] a
(d) [1] est
(e) [1] noires
(f) [1] contente
(g) [1] J'ai un frère et deux sœurs.
(h) [1] Elle aime jouer de la guitare.$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | D 10]]
Writing. Your French friend asks about your school. Write a message to answer. Include: the name of your school and where it is; your favourite subject and why; what time lessons start; what you eat at lunchtime; a question about your friend's school.

Write 60 to 70 words in French. (10 marks)

Total for Question 6: 10 marks$mq$, $mq$Content (1 mark each)
[1] Gives the name or the location of the school
[1] Says their favourite subject (e.g. Ma matière préférée, c'est l'anglais)
[1] Gives a reason (e.g. parce que le professeur est sympa)
[1] Says what time lessons start (e.g. Les cours commencent à huit heures)
[1] Says what they eat at lunchtime
[1] Asks a question about the friend's school (e.g. Comment est ton école ?)
Language
[3] Vocabulary and grammar: 3 = mostly accurate with some variety of structures; 2 = generally accurate, simple structures; 1 = frequent errors, message still understood; 0 = not understandable
Organisation
[1] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 40 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | D 12]]
Writing. Your school magazine is preparing an issue called « Les écrans et moi ». Write an article. Include: which devices you use; how long you use them each day; two things you do online; one advantage or one problem of screens; what you are going to do tomorrow with a device or without one.

Write 80 to 90 words in French. (12 marks)

Total for Question 7: 12 marks$mq$, $mq$Content (1 mark each)
[1] Says which device(s) they use (e.g. J'utilise un téléphone et un ordinateur)
[1] Says how long each day (e.g. deux heures par jour)
[1] Gives a first online activity (e.g. je regarde des vidéos)
[1] Gives a second online activity (e.g. je parle avec mes amis)
[1] Gives an advantage or a problem (e.g. C'est utile pour les devoirs / Ça fatigue les yeux)
[1] Says what they will do tomorrow (e.g. Demain, je vais jouer au foot sans mon téléphone)
Language
[4] Vocabulary and grammar: 4 = mostly accurate with some variety of structures; 3 = generally accurate, simple structures; 2 = frequent errors, message still understood; 1 = very limited; 0 = not understandable
Organisation
[2] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 50 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);
commit;
