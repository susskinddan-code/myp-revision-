begin;
-- Biology MYP 5 eAssessment Paper B (8 tasks, 72 marks) (72 marks)
with sub as (select id from public.subjects where slug = $mq$biology$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Biology MYP 5 eAssessment Paper B (8 tasks, 72 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Biology MYP 5 eAssessment Paper B (8 tasks, 72 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Cholera is caused by a bacterium and spreads in water contaminated with sewage. Influenza is caused by a virus and spreads in droplets from coughs and sneezes.
(a) Describe one way to reduce the spread of influenza and one way to reduce the spread of cholera. (2 marks)
(b) Explain why antibiotics can be used to treat cholera but not influenza. (2 marks)
(c) Explain how a vaccine protects a person against a future infection. (3 marks)
(d) Explain why unvaccinated people are less likely to catch a disease when most of the population has been vaccinated. (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) Influenza: cover coughs and sneezes / wash hands / stay at home when ill [1]. Cholera: treat sewage / provide clean drinking water / boil water [1].
(b) Antibiotics kill bacteria (for example by damaging bacterial cell walls) [1]; viruses live and reproduce inside host cells and are not affected by antibiotics [1].
(c) The vaccine contains a weakened or dead pathogen (or its antigens) [1]; the body makes antibodies and memory cells (lymphocytes) without causing the disease [1]; if the real pathogen enters later, memory cells quickly make large amounts of antibodies so the person is protected [1].
(d) Herd immunity: the pathogen cannot easily pass from person to person because most people are immune [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Scientists classify organisms using a system of groups. The lion is named Panthera leo, the tiger is named Panthera tigris and the domestic cat is named Felis catus.
(a) Explain the information given by each of the two words in the binomial name Panthera leo. (2 marks)
(b) State which two of the three animals are most closely related and give a reason. (2 marks)
A dichotomous key is shown.
1a Has feathers: bird. 1b No feathers: go to 2.
2a Has hair or fur: mammal. 2b No hair or fur: go to 3.
3a Dry skin covered in scales: reptile. 3b Moist skin with no scales: amphibian.
(c) Use the key to identify the group of (i) a crocodile, which has dry scaly skin, and (ii) a frog, which has smooth moist skin and lays eggs in water. (2 marks)
(d) State two features of mammals that are not in the key. (2 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) The first word is the genus (the group of closely related species) [1]; the second word is the species [1].
(b) Lion and tiger [1]; they are in the same genus (Panthera) [1].
(c) (i) reptile [1]; (ii) amphibian [1].
(d) Any two from: mammary glands that produce milk; give birth to live young (most mammals); body temperature kept constant (warm-blooded); four-chambered heart; diaphragm [2].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
Humans have a double circulatory system. Gas exchange takes place in the alveoli of the lungs.
(a) Name the blood vessel that carries oxygenated blood from the lungs to the heart. (1 mark)
(b) Describe the path taken by blood from the right ventricle to the left atrium. (3 marks)
(c) Explain how the alveoli are adapted for efficient gas exchange. (3 marks)
(d) State one advantage of a double circulatory system compared with a single circulation. (1 mark)

Total for Question 3: 8 marks$mq$, $mq$(a) Pulmonary vein [1].
(b) Blood leaves the right ventricle in the pulmonary artery [1]; it passes through capillaries in the lungs [1]; it returns in the pulmonary vein to the left atrium [1].
(c) Walls are one cell thick, giving a short diffusion distance [1]; there are very many alveoli, giving a large surface area [1]; a dense capillary network and breathing keep a steep concentration gradient (moist lining lets gases dissolve) [1].
(d) Blood returns to the heart to be pumped again after the lungs, so it reaches the body at higher pressure [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 8]]
Study the information about a woodland ecosystem. Oak leaves are eaten by caterpillars and by squirrels. Caterpillars are eaten by blue tits. Blue tits are eaten by sparrowhawks. Squirrels are eaten by foxes.
(a) Name the process by which carbon dioxide is removed from the air by oak trees. (1 mark)
(b) State two processes that return carbon dioxide to the air. (2 marks)
(c) Nitrogen-fixing bacteria live in the root nodules of some plants. Explain why they are useful to the plants. (2 marks)
(d) Write a food chain from the information that has four organisms. (1 mark)
(e) Name one secondary consumer in the woodland. (1 mark)
(f) A farmer sprays insecticide that kills most of the caterpillars. Explain one effect on the sparrowhawk population. (1 mark)

Total for Question 4: 8 marks$mq$, $mq$(a) Photosynthesis [1].
(b) Any two from: respiration, combustion (burning), decomposition (decay) [2].
(c) They convert nitrogen gas from the air into nitrogen compounds (nitrates or ammonium) [1]; the plant uses these to make proteins (amino acids) [1].
(d) Oak leaves -> caterpillar -> blue tit -> sparrowhawk (or oak leaves -> squirrel -> fox) with arrows pointing from food to feeder [1].
(e) Blue tit or fox [1].
(f) Fewer caterpillars means less food for blue tits, so blue tit numbers fall, and the sparrowhawks have less food so their population decreases [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 10]]
Cells in organisms must exchange materials by diffusion. A student makes cubes of agar jelly that contain sodium hydroxide and an indicator that is pink in alkali and colourless in acid. The cubes are placed in dilute hydrochloric acid. As the acid diffuses in, the pink colour disappears. The student wants to investigate how the size of a cube affects the time taken for the pink colour to disappear. The side lengths of the cubes will be 0.5, 1.0, 1.5, 2.0 and 2.5 cm.
(a) Formulate a hypothesis, using scientific reasoning. (2 marks)
(b) Identify the independent variable and the dependent variable. (2 marks)
(c) Outline a method that the student could follow to collect the results. (3 marks)
(d) Outline two variables that must be controlled. (2 marks)
(e) State one safety precaution for this investigation. (1 mark)

Total for Question 5: 10 marks$mq$, $mq$(a) A prediction that links the variables, e.g. larger cubes will take longer to turn colourless [1]; reasoning, e.g. larger cubes have a smaller surface area to volume ratio so the acid has further to diffuse / more volume to reach [1].
(b) Independent: side length (size) of the cube [1]; dependent: time for the pink colour to disappear [1].
(c) Cut the cubes accurately with a ruler and scalpel and place each in the same volume of acid at the same time as starting a stopwatch [1]; stop the timer when the pink colour has completely gone (observe against a white tile) [1]; repeat each size at least three times and calculate a mean [1].
(d) Any two from: concentration of acid, volume of acid, temperature, same batch of agar, same indicator and concentration of sodium hydroxide, method of judging the end point [2].
(e) Any one from: wear eye protection / gloves because the acid and sodium hydroxide are irritants; cut away from the body on a cutting board; wash hands afterwards [1].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 10]]
A volcano covers an island with dark ash. Biologists count a sample of 200 beetles on the island at three times. The beetles are either green or brown. Birds eat the beetles that they can see easily. Colour is controlled by one gene.
Year: 0, 10, 20
Green beetles: 150, 90, 40
Brown beetles: 50, 110, 160
(a) Calculate the percentage of green beetles in the sample in year 0. (1 mark)
(b) Calculate the change in the percentage of brown beetles between year 0 and year 20. (2 marks)
(c) Describe the trend shown by the data. (2 marks)
(d) Use the theory of natural selection to explain the change in the beetle population. (4 marks)
(e) Predict what would happen to the proportions over time if rain washed the ash away. (1 mark)

Total for Question 6: 10 marks$mq$, $mq$(a) 150 / 200 x 100 = 75% [1].
(b) Year 0: 50 / 200 = 25% brown; year 20: 160 / 200 = 80% brown [1]; change = 55 percentage points (an increase) [1].
(c) The number (proportion) of brown beetles increases over time [1]; the number of green beetles decreases at the same time (brown becomes the majority by year 10) [1].
(d) There is variation in colour in the beetle population (caused by different alleles) [1]; brown beetles are better camouflaged against the dark ash so birds eat fewer of them [1]; brown beetles survive longer, breed and pass on the allele for brown to their offspring [1]; over generations the proportion of the brown allele in the population increases [1].
(e) The green beetles would be better camouflaged again, so the proportion of green beetles would rise [1].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | D 10]]
Read the passage.
Peat is the thick layer of partly decayed plant material that forms in waterlogged bogs. Peat bogs store large amounts of carbon. In an upland region, 4 000 hectares of bog were drained so that sheep could graze. Scientists estimate that a drained bog releases 12 tonnes of carbon dioxide per hectare each year. A restoration project now plans to block the drainage ditches so that the bog fills with water again. Restored bogs hold rainwater like a sponge, which lowers flood risk downstream, and they provide habitat for rare birds. Farmers say that they will lose grazing land and income.
(a) Calculate the mass of carbon dioxide released each year by the drained bog. (2 marks)
(b) Explain why draining a peat bog increases the rate of climate change. (2 marks)
(c) Identify two benefits of restoring the bog. (2 marks)
(d) Evaluate the restoration project, considering the views of the farmers and the environment. (4 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) 4 000 x 12 [1] = 48 000 tonnes of CO2 per year [1].
(b) Draining lets air into the peat so microorganisms decompose it by aerobic respiration (decay speeds up) [1]; the carbon is released as carbon dioxide, a greenhouse gas that increases the greenhouse effect [1].
(c) Any two from: stores carbon (less CO2 released); reduces flood risk downstream; provides habitat for rare birds and increases biodiversity [2].
(d) An environmental benefit with evidence, e.g. avoids up to 48 000 tonnes of CO2 a year and reduces floods [1]; a social or economic cost, e.g. farmers lose grazing land and income [1]; a suggestion that balances both, e.g. compensate farmers or restore only part of the bog [1]; a justified conclusion [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 6 | C 4]]
The body keeps its water content steady. The table shows where a person's water comes from and goes on a cool day and on a hot day. Volumes are in cm3 per day. The person gains the same water on both days.
Water gained: drink 1 500, food 700, respiration 300.
Water lost on a cool day: urine 1 500, sweat 400, breathing 400, faeces 200.
Water lost on a hot day: urine 600, sweat 1 300, breathing 400, faeces 200.
(a) Name the organ that adjusts the concentration of the urine. (1 mark)
(b) Antidiuretic hormone (ADH) is released into the blood by the pituitary gland. State the effect of ADH on the kidney. (2 marks)
(c) Explain why less urine is produced on the hot day. (2 marks)
(d) State the term for the mechanism that restores a factor to its normal value after a change. (1 mark)
(e) Calculate the percentage of the total water lost as urine on the cool day. (2 marks)
(f) Use the data to show that the person keeps a balanced water content on the hot day. (2 marks)

Total for Question 8: 10 marks$mq$, $mq$(a) Kidney [1].
(b) ADH makes the kidney reabsorb more water into the blood [1]; so the urine is more concentrated and smaller in volume [1].
(c) More water is lost in sweat on the hot day, so the blood becomes more concentrated [1]; more ADH is released, so more water is kept in the body and less urine is made [1].
(d) Negative feedback [1].
(e) Total lost = 1 500 + 400 + 400 + 200 = 2 500 cm3 [1]; 1 500 / 2 500 x 100 = 60% [1].
(f) Hot day gains = 1 500 + 700 + 300 = 2 500 cm3 [1]; hot day losses = 600 + 1 300 + 400 + 200 = 2 500 cm3, so gains equal losses [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Biology MYP 5 eAssessment Paper C (8 tasks, 72 marks) (72 marks)
with sub as (select id from public.subjects where slug = $mq$biology$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Biology MYP 5 eAssessment Paper C (8 tasks, 72 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Biology MYP 5 eAssessment Paper C (8 tasks, 72 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
A student draws an onion epidermis cell seen through a light microscope. The drawing of one cell is 45 mm long. The real length of the cell is 0.15 mm.
(a) Calculate the magnification of the drawing. Show your working. (2 marks)
(b) Another cell has a real width of 0.06 mm. Calculate the width of its image when it is magnified 400 times. Give your answer in mm. (2 marks)
(c) State two ways in which a bacterial cell differs from an animal cell. (2 marks)
(d) Describe the function of mitochondria in cells. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) magnification = image size / real size [1] = 45 / 0.15 = 300 (x300) [1].
(b) 0.06 x 400 [1] = 24 mm [1].
(c) Any two from: bacterial cells have no nucleus (DNA is free in the cytoplasm, often as a loop); have a cell wall (not made of cellulose); may have plasmids; are much smaller; have no mitochondria [2].
(d) Mitochondria are where aerobic respiration takes place [1]; this releases energy from glucose for the cell [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Plants take in water through their roots and lose water vapour from their leaves.
(a) Name the tissue that carries water up the stem. (1 mark)
(b) Name the tissue that carries sucrose around the plant. (1 mark)
(c) Describe the path taken by water from the soil to the air. (3 marks)
(d) Explain why the rate of transpiration increases on a hot, windy day. (3 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) Xylem [1].
(b) Phloem [1].
(c) Water enters root hair cells by osmosis [1]; it moves up the xylem in the stem to the leaves [1]; it evaporates from the surface of mesophyll cells and diffuses out of the leaf through the stomata [1].
(d) Higher temperature gives water molecules more energy, so evaporation is faster [1]; wind blows away the humid air near the stomata [1]; this keeps a steep concentration gradient of water vapour between the leaf and the air so diffusion is faster [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
A scientist measures the energy stored in the organisms of a pond food chain in kJ per m2 per year.
Algae (producers): 20 000. Water fleas (primary consumers): 2 000. Small fish (secondary consumers): 180.
(a) State the role of the algae in the food chain. (1 mark)
(b) Calculate the percentage of energy transferred from the algae to the water fleas. (2 marks)
(c) Explain why not all of the energy in the algae is stored in the water fleas. (2 marks)
(d) Explain why the pesticide DDT, which is not broken down, reaches the highest concentration in the top predator. (2 marks)
(e) State why most food chains have no more than five trophic levels. (1 mark)

Total for Question 3: 8 marks$mq$, $mq$(a) The algae are producers: they make food (glucose) by photosynthesis and are the source of energy for the chain [1].
(b) 2 000 / 20 000 x 100 [1] = 10% [1].
(c) Some algae are not eaten [1]; energy is lost as heat from respiration, in movement, and in waste (faeces) or parts that cannot be digested [1].
(d) The pesticide is not broken down or excreted, so it builds up in the bodies of organisms [1]; each predator eats many contaminated prey, so the concentration increases along the food chain (bioaccumulation) [1].
(e) Too little energy remains at higher levels to support more organisms [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 8]]
Adrenaline is a hormone that helps the body respond to danger.
(a) Name the glands that release adrenaline. (1 mark)
(b) Describe two effects of adrenaline on the body. (2 marks)
(c) Testosterone is the male sex hormone. State two changes in boys at puberty that are caused by testosterone. (2 marks)
(d) A fast reflex action and a hormonal response both help survival. Explain why the effect of adrenaline lasts longer than a nervous impulse. (2 marks)
(e) Name the hormone that is released when the blood glucose concentration is too high. (1 mark)

Total for Question 4: 8 marks$mq$, $mq$(a) Adrenal glands [1].
(b) Any two from: heart rate increases; breathing rate increases; more glucose released from the liver into the blood; pupils dilate; blood diverted to muscles [2].
(c) Any two from: voice deepens; facial and body hair grows; muscle mass increases; testes produce sperm; growth spurt [2].
(d) Hormones are carried in the blood and remain in circulation until they are broken down [1]; nerve impulses are very brief electrical signals that stop as soon as the stimulus stops [1].
(e) Insulin [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 10]]
Vitamin C is found in fruit juices. A blue dye called DCPIP loses its colour when it reacts with vitamin C. A student wants to compare the vitamin C content of three fruit juices: orange, apple and lemon. She adds juice drop by drop from a dropper to 1.0 cm3 of DCPIP solution and counts how many drops are needed to make the blue colour disappear.
(a) Write a research question for this investigation. (2 marks)
(b) Identify the independent variable and the dependent variable. (2 marks)
(c) Outline a method the student could use. (4 marks)
(d) Outline two variables that must be controlled. (2 marks)

Total for Question 5: 10 marks$mq$, $mq$(a) A question that names both variables and links them, e.g. Which fruit juice (orange, apple or lemon) needs the fewest drops to decolourise DCPIP, so contains the most vitamin C? [2]. Award 1 mark if only one variable is named or the link is missing.
(b) Independent: type of fruit juice [1]; dependent: number of drops needed to make the DCPIP colourless [1].
(c) Measure 1.0 cm3 of DCPIP into a test tube using a syringe or pipette [1]; add the juice one drop at a time, mixing after every drop [1]; stop when the blue colour has completely disappeared and record the number of drops [1]; repeat three times for each juice, rinse the equipment between juices [1].
(d) Any two from: volume of DCPIP; concentration of DCPIP; same dropper (drop size); the juices must be fresh or at the same dilution; same temperature [2].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 10]]
The student records the number of drops of each juice needed to remove the blue colour from 1.0 cm3 of DCPIP.
Orange juice: trial 1 is 12, trial 2 is 14, trial 3 is 13.
Apple juice: trial 1 is 38, trial 2 is 40, trial 3 is 36.
Lemon juice: trial 1 is 19, trial 2 is 31, trial 3 is 20.
(a) Calculate the mean number of drops for orange juice. (2 marks)
(b) Identify the anomalous result and suggest one possible cause. (2 marks)
(c) Calculate the mean for lemon juice without the anomalous result. (2 marks)
(d) State which juice contains the most vitamin C and justify your answer. (2 marks)
(e) Evaluate the use of drops as a unit of measurement and suggest an improvement. (2 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) (12 + 14 + 13) / 3 [1] = 13.0 drops [1].
(b) 31 drops (lemon, trial 2) [1]; cause, e.g. a larger drop was added, the solution was not mixed, or the end point was misjudged [1].
(c) (19 + 20) / 2 [1] = 19.5 drops [1].
(d) Orange juice [1]; it needs the smallest mean number of drops (13.0) to remove the colour, so it has the highest vitamin C concentration [1].
(e) Drops vary in size so the volumes are not accurate or comparable [1]; use a burette or a graduated syringe to measure the volume of juice in cm3 [1].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | D 10]]
Read the passage.
Only about 40 individuals of a rare deer species survive in the wild. Conservationists have frozen skin cells from a deer that died. They plan to remove the nucleus from a donor egg cell, replace it with the nucleus from a frozen skin cell, and place the embryo in a female of a related species. In a trial with another species, 2 healthy animals were born from 80 embryos. Supporters say cloning could save the species. Critics say that all the clones would be genetically identical, making the population very vulnerable to disease, and that the money would be better spent on protecting the deer's forest habitat.
(a) Explain why a cloned animal is genetically identical to the animal that donated the skin cell. (2 marks)
(b) Calculate the success rate of the trial as a percentage. (2 marks)
(c) Explain one scientific problem with using cloning to rebuild a population. (2 marks)
(d) Evaluate the argument that the money should be spent on habitat protection instead of cloning. (4 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) The nucleus of the skin cell contains all of the donor's genes (DNA) [1]; no fertilisation takes place and so no genes from a second parent are mixed in [1].
(b) 2 / 80 x 100 [1] = 2.5% [1].
(c) Clones have no genetic variation [1]; a single disease or environmental change could kill all of them, because none has a different resistance [1].
(d) Habitat protection helps many species and the whole ecosystem, and lets deer breed naturally with genetic variation [1]; cloning has a very low success rate (2.5%) so is costly per animal [1]; cloned animals still need a safe habitat to live in, so the two approaches are linked [1]; a justified conclusion, e.g. habitat protection first with cloning as a limited extra to add genetic stock [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 6 | C 4]]
The human genome contains about 3.2 x 10^9 base pairs and about 20 000 genes arranged on 23 pairs of chromosomes.
(a) State what a gene codes for. (1 mark)
(b) Describe the structure of a DNA molecule. (2 marks)
(c) Explain how a mutation in a gene can change a protein. (2 marks)
(d) Muscle cells and nerve cells in the same person have the same genes but look different. Suggest why. (1 mark)
A sequencing machine reads 8.0 x 10^7 base pairs per hour.
(e) Calculate the time in hours that the machine needs to read one human genome. (2 marks)
A company reports that the cost of sequencing one genome fell from 60 000 pounds in 2010 to 600 pounds in 2020.
(f) Calculate the percentage decrease in cost. (2 marks)

Total for Question 8: 10 marks$mq$, $mq$(a) The order of amino acids in one protein [1].
(b) Two strands twisted into a double helix [1]; the strands are joined by pairs of bases: A with T and C with G (complementary base pairing) [1].
(c) A mutation changes the base sequence, which may change an amino acid [1]; this may alter the shape of the protein so it cannot do its job (e.g. an enzyme's active site changes) [1].
(d) Different genes are switched on (expressed) in each cell type, so different proteins are made [1].
(e) 3.2 x 10^9 / 8.0 x 10^7 [1] = 40 hours [1].
(f) (60 000 - 600) / 60 000 x 100 [1] = 99% [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Environmental Systems MYP 5 eAssessment Paper A (8 tasks, 72 marks) (72 marks)
with sub as (select id from public.subjects where slug = $mq$environmental-systems$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Environmental Systems MYP 5 eAssessment Paper A (8 tasks, 72 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Environmental Systems MYP 5 eAssessment Paper A (8 tasks, 72 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Water moves between the oceans, the atmosphere and the land in the water cycle.
(a) Name the process by which water vapour in the air changes into liquid droplets in clouds. (1 mark)
(b) Explain how clearing a large area of forest can change the water cycle in that area. (3 marks)
A country is classed as water stressed when it has fewer than 1 700 m3 of renewable fresh water per person per year. A country has 5.0 million people and 8.0 x 10^9 m3 of renewable fresh water each year.
(c) Calculate the renewable fresh water available per person per year. (2 marks)
(d) State whether the country is water stressed and give a reason. (1 mark)
(e) Suggest one way the country could reduce its water stress. (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) Condensation [1].
(b) Fewer trees means less transpiration, so less water vapour enters the air and local rainfall may decrease [1]; with no roots and leaf cover, less water infiltrates the soil and more runs off the surface [1]; this increases flooding and soil erosion (and lowers groundwater) [1].
(c) 8.0 x 10^9 / 5.0 x 10^6 [1] = 1 600 m3 per person per year [1].
(d) Yes, because 1 600 is below the limit of 1 700 m3 per person [1].
(e) Any one from: fix leaking pipes; reduce demand with water meters or education; recycle waste water; build reservoirs or desalination plants; improve irrigation efficiency [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Biodiversity is under threat in many parts of the world.
(a) Define the term biodiversity. (1 mark)
(b) Explain why habitat loss is one of the main causes of species extinction. (2 marks)
(c) Distinguish between in situ and ex situ conservation and give one example of each. (3 marks)
In rocky tidal pools a predatory starfish feeds mainly on mussels. When scientists removed the starfish from some pools, the mussels spread and the number of different species in those pools fell.
(d) Explain why the removal of the starfish caused a loss of biodiversity. (2 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) The variety of living organisms in an area, including the number of species and the genetic variation within them [1].
(b) Species lose the food, shelter and breeding sites that they need [1]; populations become smaller and isolated and cannot survive or recover [1].
(c) In situ conservation protects species in their natural habitat [1]; ex situ conservation protects species outside their natural habitat [1]; one correct example of each, e.g. national park, nature reserve or marine protected area (in situ) and zoo, seed bank or captive breeding programme (ex situ) [1].
(d) The starfish kept mussel numbers low [1]; without it the mussels out-competed other species for space, so other species disappeared (keystone species) [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
The ozone layer in the stratosphere protects life on Earth.
(a) State the function of the ozone layer. (1 mark)
(b) Name the group of chemicals that caused the most damage to the ozone layer. (1 mark)
(c) Explain how these chemicals break down ozone. (2 marks)
(d) State two effects of increased ultraviolet radiation on living organisms. (2 marks)
(e) The Montreal Protocol is an international agreement to phase out ozone-depleting chemicals. Explain why international cooperation was needed. (2 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) It absorbs most of the harmful ultraviolet (UV) radiation from the Sun [1].
(b) Chlorofluorocarbons (CFCs) [1].
(c) UV radiation breaks CFC molecules apart, releasing chlorine atoms [1]; chlorine atoms react with ozone and convert it to oxygen, and one chlorine atom can destroy many ozone molecules [1].
(d) Any two from: skin cancer; cataracts (eye damage); damage to phytoplankton and crops; weakened immune systems [2].
(e) CFCs were released in many countries and spread through the atmosphere all over the world, so one country acting alone could not stop the damage [1]; all countries had to agree to stop making and using them, and poorer countries needed help to change [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 8]]
A population of deer is introduced to a large island with plenty of food. Its growth follows an S-shaped (sigmoid) curve.
(a) Define the term carrying capacity. (1 mark)
(b) Describe the three phases of the S-shaped growth curve. (3 marks)
(c) Define the term ecological footprint. (1 mark)
A country has an ecological footprint of 5.0 global hectares per person. Its biocapacity is 2.0 global hectares per person.
(d) Calculate the ecological deficit per person. (1 mark)
(e) Suggest two ways in which individuals could reduce their ecological footprint. (2 marks)

Total for Question 4: 8 marks$mq$, $mq$(a) The maximum population size of a species that an environment can support over a long time [1].
(b) Slow growth at first, when the population is small [1]; rapid (exponential) growth with plenty of food and space [1]; the growth slows and levels off at the carrying capacity because resources become limiting [1].
(c) The area of land and sea needed to supply a person's (or population's) resources and absorb their waste [1].
(d) 5.0 - 2.0 = 3.0 global hectares per person [1].
(e) Any two from: use public transport, cycling or walking; eat less meat; reduce energy use; recycle and buy fewer products; reduce food waste [2].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 10]]
In cities, hard surfaces can heat the air above them. A class wants to find out how the type of ground surface affects its temperature on a sunny day. They will test grass, bare soil, concrete and tarmac in a school playground and field. They will point an infrared thermometer at each surface from a height of 10 cm.
(a) Formulate a hypothesis, using scientific reasoning. (2 marks)
(b) Identify the independent variable and the dependent variable. (2 marks)
(c) Outline three variables that must be controlled. (3 marks)
(d) Describe how the class can make its results reliable. (2 marks)
(e) State one safety precaution for the fieldwork. (1 mark)

Total for Question 5: 10 marks$mq$, $mq$(a) A prediction, e.g. tarmac will have the highest temperature and grass the lowest [1]; reasoning, e.g. dark hard surfaces absorb more solar radiation, while grass is cooled by transpiration and reflects more light [1].
(b) Independent: type of ground surface [1]; dependent: surface temperature (degrees C) [1].
(c) Any three from: time of day; distance and angle of the thermometer; all surfaces in full sunlight (no shade); same thermometer; same weather conditions (cloud, wind); surfaces dry [3].
(d) Take several readings at different places on each surface [1]; calculate a mean for each surface and repeat on another day / compare with a second thermometer [1].
(e) Any one from: wear a sun hat and sun cream; do not touch hot surfaces; keep away from traffic; drink water [1].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 10]]
A fisheries agency records the total catch of a fish species and the number of fishing boats in a coastal region.
Year: 2000, 2005, 2010, 2015, 2020
Catch (thousand tonnes): 480, 520, 410, 330, 270
Number of boats: 120, 135, 150, 150, 140
(a) Calculate the percentage decrease in the catch between 2005 and 2020. Give your answer to the nearest whole number. (2 marks)
(b) Calculate the catch per boat in 2020, in thousand tonnes. Give your answer to 2 significant figures. (2 marks)
(c) Describe how the catch and the number of boats changed between 2005 and 2015. (2 marks)
(d) Explain what the catch per boat suggests about the fish stock. (2 marks)
(e) Suggest two measures that could help the fish population recover. (2 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) (520 - 270) / 520 x 100 [1] = 48% [1].
(b) 270 / 140 [1] = 1.9 thousand tonnes per boat [1].
(c) The catch fell from 520 to 330 thousand tonnes [1] while the number of boats increased from 135 to 150 [1].
(d) The catch per boat fell (from 4.0 in 2000 to 1.9 in 2020) even though similar numbers of boats were used [1]; this suggests fish are harder to find because the stock has been overfished and is declining [1].
(e) Any two from: fishing quotas; closed seasons; minimum net mesh size; marine protected areas; limit the number of boats; fish farming [2].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | D 10]]
Read the passage.
The centre of a city has levels of nitrogen dioxide (NO2) above the legal limit. About 150 000 vehicles enter the centre every day. The council proposes a daily charge for the most polluting vehicles. In another city with a similar scheme, traffic fell by 20% and NO2 fell by 15%. Supporters say the money raised can improve buses and cycle lanes. Shop owners fear that customers will go to out-of-town shopping centres, and some low-income workers say they cannot afford newer vehicles or the charge.
(a) Calculate the number of fewer vehicles entering the centre if traffic falls by 20%. (2 marks)
(b) Explain how pollution from vehicle exhausts harms human health. (2 marks)
(c) Identify two environmental benefits of reducing the number of vehicles. (2 marks)
(d) Evaluate the proposed charge, considering environmental, social and economic factors. (4 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) 20 / 100 x 150 000 [1] = 30 000 fewer vehicles [1].
(b) Nitrogen dioxide and small particles are breathed in and irritate the lungs and airways [1]; this can cause or worsen asthma and other breathing problems (heart disease) especially in children and the elderly [1].
(c) Any two from: lower NO2 and cleaner air; lower greenhouse gas emissions; less noise; less acid rain / less smog [2].
(d) An environmental benefit with evidence, e.g. NO2 could fall by about 15% [1]; a social or economic cost, e.g. low-income workers may not afford the charge, and shops may lose customers [1]; a way to reduce the problem, e.g. discounts for low-income drivers or investing the money in better public transport [1]; a justified conclusion [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 6 | C 4]]
The carbon footprint of food depends on how it is produced. The table shows illustrative values in kg of carbon dioxide equivalent (kg CO2e) per kg of food.
Beef: 50. Chicken: 6. Beans: 2.
(a) State what is meant by a carbon footprint. (1 mark)
(b) Explain why beef has a much larger carbon footprint than beans. (2 marks)
(c) Suggest two ways that a food producer can reduce the carbon footprint of food. (2 marks)
(d) Name one greenhouse gas that is released by flooded rice fields. (1 mark)
A family eats 2 kg of beef and 3 kg of beans each week.
(e) Calculate the weekly carbon footprint of this food. (2 marks)
(f) The family replaces 1 kg of beef with 1 kg of chicken. Calculate the percentage decrease in the weekly footprint. Give your answer to the nearest whole number. (2 marks)

Total for Question 8: 10 marks$mq$, $mq$(a) The total amount of greenhouse gases (as carbon dioxide equivalent) released by an activity or product [1].
(b) Cattle need large amounts of plant feed and land, and energy is lost at each trophic level, so more resources are used per kg of food [1]; cattle also release methane, a powerful greenhouse gas, and land clearing releases carbon dioxide [1].
(c) Any two from: use renewable energy on the farm; reduce fertiliser use; capture methane; transport locally; reduce food waste; improve feed efficiency [2].
(d) Methane [1].
(e) 2 x 50 + 3 x 2 [1] = 106 kg CO2e [1].
(f) New footprint = 1 x 50 + 1 x 6 + 3 x 2 = 62 kg, so a decrease of 44 kg [1]; 44 / 106 x 100 = 42% [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Environmental Systems MYP 5 eAssessment Paper B (8 tasks, 72 marks) (72 marks)
with sub as (select id from public.subjects where slug = $mq$environmental-systems$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Environmental Systems MYP 5 eAssessment Paper B (8 tasks, 72 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Environmental Systems MYP 5 eAssessment Paper B (8 tasks, 72 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
A tropical rainforest has a mean annual temperature of 27 degrees C and 2 500 mm of rainfall a year. A hot desert has a mean annual temperature of 30 degrees C and 100 mm of rainfall a year.
(a) State the difference in annual rainfall between the two biomes. (1 mark)
(b) Explain why the tropical rainforest supports many more species than the desert. (2 marks)
(c) Describe two adaptations that help desert plants to survive. (2 marks)
(d) Explain why rainforest soils are low in nutrients even though the vegetation grows quickly. (3 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) 2 500 - 100 = 2 400 mm [1].
(b) Warmth, water and light all year allow high productivity (plant growth) [1]; this provides a large range of food sources and habitats (niches) for many species [1].
(c) Any two described adaptations from: thick waxy cuticle to reduce water loss; small leaves or spines; roots that are deep or spread widely; fleshy stems that store water; open stomata only at night [2].
(d) Most nutrients are held in the living biomass (trees and plants) rather than in the soil [1]; dead material decays quickly and nutrients are rapidly absorbed again by roots [1]; heavy rainfall washes (leaches) soluble nutrients from the soil [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
A volcanic eruption covers an island with bare lava rock. Over time lichens, mosses, grasses, shrubs and trees colonise it.
(a) Define the term ecological succession. (1 mark)
(b) Name a pioneer species from the information. (1 mark)
(c) Explain how pioneer species make it possible for other species to live in the area. (2 marks)
(d) Describe how biodiversity changes during succession. (2 marks)
(e) After a forest fire the soil remains. Explain why secondary succession is faster than primary succession. (2 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) The gradual change in the community of species in an area over time [1].
(b) Lichens (accept mosses) [1].
(c) They break down the rock and, when they die, add organic matter, forming the first soil [1]; the soil holds water and nutrients so larger plants can grow [1].
(d) Biodiversity increases as more species arrive [1]; it levels off when a stable climax community is reached [1].
(e) Soil, seeds and nutrients are already present after a fire [1]; so plants can start to grow straight away and no time is needed to form soil [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
A coal-fired power station burns coal that releases 250 MJ of thermal energy. It produces 100 MJ of electrical energy.
(a) Calculate the efficiency of the power station. (2 marks)
(b) State where the rest of the energy goes. (1 mark)
(c) Describe the energy transfers in a coal-fired power station, from the chemical store in coal to electricity. (3 marks)
(d) Explain one environmental advantage of generating electricity from hydroelectric power instead of coal. (2 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) efficiency = useful output / total input x 100 = 100 / 250 x 100 [1] = 40% [1].
(b) It is wasted as thermal energy to the surroundings (heat lost in cooling towers, exhaust gases and friction) [1].
(c) Chemical energy in coal is transferred to thermal energy when it burns and heats water to steam [1]; the steam makes the turbine spin (kinetic energy) [1]; the turbine turns the generator, producing electrical energy [1].
(d) Hydroelectric power does not burn fuel, so it releases no carbon dioxide during operation [1]; so it does not add to the greenhouse effect or sulfur dioxide that causes acid rain [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 8]]
A company manages a forest of 12 000 hectares. The trees take 60 years to reach a size suitable for cutting down. The company wants to manage the forest sustainably.
(a) Define the term sustainable development. (1 mark)
(b) Calculate the maximum area of forest that can be cut down each year if the forest is to remain the same size, assuming replanting. (2 marks)
(c) The company cuts down 300 hectares each year. Explain why this is not sustainable. (2 marks)
(d) State two sustainable forestry practices. (2 marks)
(e) State one environmental benefit of keeping forests. (1 mark)

Total for Question 4: 8 marks$mq$, $mq$(a) Development that meets the needs of the present without reducing the ability of future generations to meet their own needs [1].
(b) 12 000 / 60 [1] = 200 hectares per year [1].
(c) 300 hectares is more than the 200 hectares that regrow each year [1]; so the forest area (and its trees) will decrease until the resource is used up [1].
(d) Any two from: replanting trees after felling; selective cutting instead of clear-felling; certification such as FSC; leaving corridors and buffer strips; rotating areas to cut [2].
(e) Any one from: stores carbon; provides habitat for biodiversity; reduces soil erosion and flooding; releases oxygen and cycles water [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 10]]
A footpath crosses a meadow. A class wants to find out how trampling affects the plants. They plan to lay a tape measure at right angles to the path, with the 0 m mark at the centre of the path. At 0, 1, 2, 3, 4 and 5 m from the path they will place a 0.5 m x 0.5 m quadrat and estimate the percentage of the ground covered by plants.
(a) Formulate a hypothesis, using scientific reasoning. (2 marks)
(b) Identify the independent variable and the dependent variable. (2 marks)
(c) Explain why a transect is better than random sampling for this investigation. (1 mark)
(d) Describe how a student should use a quadrat to estimate the percentage plant cover. (3 marks)
(e) Outline two variables that should be kept the same along the transect. (2 marks)

Total for Question 5: 10 marks$mq$, $mq$(a) A prediction, e.g. plant cover will increase with distance from the path [1]; reasoning, e.g. trampling damages stems and compacts the soil, so plants near the path are damaged or cannot grow [1].
(b) Independent: distance from the path [1]; dependent: percentage plant cover [1].
(c) A transect samples along a line so that the change in cover with distance can be seen, but random sampling would not show the pattern in order [1].
(d) Place the quadrat flat on the ground at the correct distance without moving plants [1]; estimate the fraction of the squares (grid) covered by plants, looking from directly above [1]; repeat several times at each distance (or along parallel transects) and calculate a mean [1].
(e) Any two from: soil type; slope; light/shade; quadrat size; time of year and weather; same person estimating cover [2].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 10]]
Another class carried out a similar transect. Their mean results are shown.
Distance from the centre of the path (m): 0, 1, 2, 3, 4, 5
Mean plant cover (%): 5, 22, 48, 71, 80, 82
Soil compaction measured with a penetrometer (kg/cm2): 4.5, 3.8, 2.4, 1.6, 1.3, 1.2
A higher number means harder, more compacted soil.
(a) Describe the trend in plant cover as the distance from the path increases. (2 marks)
(b) Calculate the mean plant cover for the distances 3 m, 4 m and 5 m. Give your answer to 1 decimal place. (2 marks)
(c) Calculate the plant cover at 2 m as a percentage of the plant cover at 5 m. Give your answer to the nearest whole number. (2 marks)
(d) Use the data to explain the link between soil compaction and plant cover. (3 marks)
(e) Suggest one limitation of the investigation. (1 mark)

Total for Question 6: 10 marks$mq$, $mq$(a) Plant cover increases with distance from the path [1]; the increase is fastest between 1 and 3 m, then levels off at about 80% beyond 4 m [1].
(b) (71 + 80 + 82) / 3 [1] = 77.7% [1].
(c) 48 / 82 x 100 [1] = 59% [1].
(d) Compaction is greatest next to the path (4.5 kg/cm2) where cover is lowest (5%) and is least at 5 m (1.2) where cover is highest (82%) [1]; there is a negative correlation [1]; compacted soil has less air and water and is harder for roots to penetrate, so fewer plants can grow (trampling also directly damages plants) [1].
(e) Any one from: only one transect or one path; estimates of cover are subjective; only six distances; other factors such as shade were not measured [1].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | D 10]]
Read the passage.
Beavers were hunted to extinction in many river valleys. A project released a family of beavers into a wooded stream. The beavers cut down small trees and built dams, creating a series of ponds. Scientists found that the dams reduced the peak flow of floodwater downstream by 30%, from 20 m3/s to a lower value. The ponds attracted frogs, dragonflies, fish and birds. However, some farmers downstream complained that 5 hectares of pasture were flooded and that beavers felled valuable trees.
(a) Calculate the peak flow of floodwater after the beavers built the dams. (2 marks)
(b) Explain how beaver dams can increase biodiversity. (2 marks)
(c) Identify two concerns of the farmers. (2 marks)
(d) Evaluate the decision to reintroduce beavers into the river valley. (4 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) 30% of 20 = 6 m3/s [1]; 20 - 6 = 14 m3/s [1].
(b) Dams create ponds and wetland habitats that did not exist before [1]; these support more species of insects, amphibians, fish and birds (more niches and food) [1].
(c) Flooding of 5 hectares of pasture [1]; beavers felling valuable trees [1].
(d) An environmental or flood benefit with evidence, e.g. peak flow reduced from 20 to 14 m3/s and more species in ponds [1]; the cost to farmers, e.g. flooded pasture and lost trees [1]; a way to reduce conflict, e.g. compensation for farmers, protecting valuable trees with fencing, or moving beavers away from vulnerable land [1]; a justified conclusion [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 6 | C 4]]
Sea level is rising around the world. The table shows the approximate rise in global mean sea level since 1993.
Year: 1993, 2003, 2013, 2023
Rise since 1993 (mm): 0, 30, 63, 100
(a) Describe two causes of sea level rise linked to global warming. (2 marks)
(b) Explain why melting floating sea ice does not raise sea level but melting ice on land does. (2 marks)
(c) Describe two impacts of rising sea level on coastal communities. (2 marks)
(d) Calculate the mean rate of rise in mm per year between 1993 and 2023. Give your answer to 2 significant figures. (2 marks)
(e) Calculate the mean rate of rise for 1993-2003 and for 2013-2023, and state what this shows about the rate of rise. (2 marks)

Total for Question 8: 10 marks$mq$, $mq$(a) Thermal expansion: as the oceans warm the water expands [1]; melting of glaciers and ice sheets on land adds water to the oceans [1].
(b) Floating ice already displaces its own weight of water, so when it melts the level stays the same [1]; ice on land is not in the water, so the meltwater is new water added to the ocean [1].
(c) Any two from: flooding of homes and farmland; coastal erosion and loss of land; salt water enters fresh water supplies and soil; more damage from storm surges; people forced to move [2].
(d) 100 / 30 [1] = 3.3 mm per year [1].
(e) 1993-2003: 30 / 10 = 3.0 mm per year; 2013-2023: (100 - 63) / 10 = 3.7 mm per year [1]; the rate of rise has increased (sea level is rising faster) [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Integrated Science MYP 5 eAssessment Paper A (8 tasks, 72 marks) (72 marks)
with sub as (select id from public.subjects where slug = $mq$integrated-science$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Integrated Science MYP 5 eAssessment Paper A (8 tasks, 72 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Integrated Science MYP 5 eAssessment Paper A (8 tasks, 72 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
A person steps on a sharp thorn and pulls their foot away before they feel pain. This is a reflex action.
(a) Put these parts of the reflex arc in the correct order: motor neurone, effector, sensory neurone, receptor, relay neurone. (2 marks)
(b) Name the gap between two neurones. (1 mark)
(c) Explain why a reflex action is faster than a voluntary action and why this is useful. (2 marks)
(d) An impulse travels along a nerve 1.2 m long in 0.012 s. Calculate the speed of the impulse in m/s. (2 marks)
(e) Name the effector in this reflex. (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) receptor, sensory neurone, relay neurone, motor neurone, effector [2]. Award 1 mark if one neighbouring pair is swapped.
(b) Synapse [1].
(c) The impulse passes through the spinal cord without being sent to the conscious part of the brain, so the pathway is shorter and there is no decision time [1]; the body can withdraw from danger before damage becomes serious [1].
(d) speed = distance / time = 1.2 / 0.012 [1] = 100 m/s [1].
(e) Muscle (leg muscle) [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Magnesium ribbon burns in air with a bright white flame to form a white powder, magnesium oxide. The relative atomic mass of magnesium is 24 and of oxygen is 16.
(a) Write the balanced symbol equation for the reaction. (2 marks)
(b) Calculate the mass of magnesium oxide formed when 2.4 g of magnesium burns completely. (2 marks)
(c) The white powder has a greater mass than the original magnesium. Explain why. (2 marks)
(d) Write the word equation for the neutralisation of hydrochloric acid by sodium hydroxide. (1 mark)
(e) State the pH of the solution if exactly equal amounts of acid and alkali react. (1 mark)

Total for Question 2: 8 marks$mq$, $mq$(a) 2Mg + O2 [1] -> 2MgO [1].
(b) 2.4 g is 0.10 mol of Mg, which forms 0.10 mol of MgO [1]; mass of MgO = 0.10 x 40 = 4.0 g [1]. (Accept ratio method 48 g gives 80 g.)
(c) Magnesium combines with oxygen from the air (oxidation) [1]; the mass of the oxygen is added to the magnesium so the product is heavier (mass is conserved overall) [1].
(d) hydrochloric acid + sodium hydroxide -> sodium chloride + water [1].
(e) pH 7 (neutral) [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
A roller coaster car of mass 500 kg is pulled to the top of a hill 20 m high. It is then released from rest. Use gravitational field strength = 10 N/kg.
(a) Calculate the gravitational potential energy of the car at the top of the hill. (2 marks)
(b) Assume all of the potential energy becomes kinetic energy at the bottom. Calculate the speed of the car at the bottom. (3 marks)
(c) The real speed at the bottom is lower than your answer. Explain why. (2 marks)
(d) State the principle of conservation of energy. (1 mark)

Total for Question 3: 8 marks$mq$, $mq$(a) GPE = mgh = 500 x 10 x 20 [1] = 100 000 J [1].
(b) KE = 1/2 mv2 so 100 000 = 0.5 x 500 x v2 [1]; v2 = 400 [1]; v = 20 m/s [1].
(c) Some energy is transferred to thermal energy by friction in the wheels and air resistance [1]; so less is available as kinetic energy (energy is dissipated to the surroundings) [1].
(d) Energy cannot be created or destroyed, only transferred from one store to another [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 8]]
A research boat sends a pulse of ultrasound down to the sea floor. The echo returns after 0.40 s. The speed of sound in sea water is 1 500 m/s.
(a) State what is meant by the frequency of a wave. (1 mark)
(b) A sound wave in air has a frequency of 500 Hz and a speed of 340 m/s. Calculate its wavelength. (2 marks)
(c) Calculate the depth of the sea floor. (3 marks)
(d) Name one type of electromagnetic wave used for communication and one used in medical imaging. (2 marks)

Total for Question 4: 8 marks$mq$, $mq$(a) The number of waves that pass a point in one second (measured in hertz) [1].
(b) wavelength = speed / frequency = 340 / 500 [1] = 0.68 m [1].
(c) Distance to the floor and back = 1 500 x 0.40 = 600 m [1]; the pulse travels the depth twice so divide by 2 [1] = 300 m [1].
(d) Communication: radio waves or microwaves (accept infrared for remote controls or optical fibres) [1]; medical imaging: X-rays (accept gamma rays) [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 10]]
A student wants to find out how the angle of a ramp affects the speed of a toy car. A 1.0 m long wooden ramp is raised at one end by stacking books. The car is released from rest at the top of the ramp and the time it takes to reach the bottom is measured with a stopwatch. The angles tested are 10, 20, 30, 40 and 50 degrees.
(a) Write a research question for the investigation. (2 marks)
(b) Formulate a hypothesis, using scientific reasoning. (2 marks)
(c) Identify the independent variable and the dependent variable. (2 marks)
(d) Explain why a stopwatch may give inaccurate results and suggest an improvement. (2 marks)
(e) Outline two variables that must be controlled. (2 marks)

Total for Question 5: 10 marks$mq$, $mq$(a) A question that links angle of the ramp and speed (or time), e.g. How does the angle of the ramp affect the average speed of the toy car? [2]. Award 1 mark if only one variable is named.
(b) A prediction, e.g. a steeper ramp gives a greater speed (shorter time) [1]; with reasoning, e.g. a steeper slope means a larger part of the car's weight acts down the slope, so the acceleration is greater [1].
(c) Independent: angle of the ramp [1]; dependent: time taken (to find average speed) [1].
(d) Human reaction time is about 0.2 s, which is large compared with the short times measured [1]; use light gates or video recording with a frame-by-frame analysis, or repeat and average [1].
(e) Any two from: same car (mass and wheels); same ramp surface; same starting point and release method (no push); same ramp length [2].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 10]]
Scientists measure the concentration of carbon dioxide in the atmosphere and the average global temperature. The temperature is given as the rise above the 1951-1980 average. Temperature values are approximate.
Year: 1960, 1980, 2000, 2020
Carbon dioxide (ppm): 317, 339, 369, 413
Temperature rise (degrees C): 0.0, 0.3, 0.4, 1.0
(a) Calculate the increase in carbon dioxide concentration between 1960 and 2020. (1 mark)
(b) Calculate the percentage increase in carbon dioxide concentration between 1960 and 2020. Give your answer to the nearest whole number. (2 marks)
(c) Calculate the mean rate of increase in carbon dioxide concentration between 2000 and 2020 in ppm per year. (2 marks)
(d) Describe the relationship between carbon dioxide concentration and temperature. (2 marks)
(e) Explain why this correlation alone does not prove that carbon dioxide causes the temperature rise, and describe further evidence that supports the link. (3 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) 413 - 317 = 96 ppm [1].
(b) 96 / 317 x 100 [1] = 30% [1] (30.3%).
(c) (413 - 369) / 20 [1] = 2.2 ppm per year [1].
(d) As carbon dioxide concentration increases, temperature also increases (positive correlation) [1]; the temperature rise is larger in the later years (1.0 degrees at 413 ppm), so the relationship is not perfectly steady [1].
(e) Correlation shows two variables change together but other factors (for example solar activity, volcanoes) may also affect temperature [1]; evidence for a mechanism: carbon dioxide absorbs infrared radiation and traps heat (greenhouse effect), shown in laboratory experiments [1]; supporting data: ice cores show that past temperature and carbon dioxide changed together over thousands of years / models of warming match the observed rise only when human emissions are included [1].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | D 10]]
Read the passage.
Satellites give us weather forecasts, satellite navigation, television and emergency communications. Thousands of satellites orbit the Earth. When a satellite stops working, it can stay in orbit for many years. Collisions between old satellites and rocket parts break them into fragments. In low orbits, fragments travel at about 7 500 m/s. Even a fragment with a mass of only 0.010 kg can seriously damage a working satellite or a space station. Some companies are developing spacecraft that capture old satellites and push them into the atmosphere to burn up. Removal missions are expensive, and only a few countries can afford them.
(a) Calculate the kinetic energy of a 0.010 kg fragment travelling at 7 500 m/s. (2 marks)
(b) Explain why small fragments of debris are dangerous. (2 marks)
(c) Identify two benefits of satellites to society. (2 marks)
(d) Evaluate whether all countries should be required to remove their old satellites from orbit. (4 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) KE = 1/2 x 0.010 x 7 500^2 [1] = 281 250 J (2.8 x 10^5 J) [1].
(b) Kinetic energy depends on the square of the speed, so a tiny mass at very high speed carries a very large amount of energy [1]; a collision can destroy a satellite and create many more fragments, increasing the risk of further collisions [1].
(c) Any two from: weather forecasts and warnings; navigation; communications and television; emergency services / monitoring the environment [2].
(d) A benefit of removal, e.g. protects useful satellites and astronauts and reduces future collisions [1]; a drawback with evidence, e.g. removal missions are expensive and only a few countries can afford them [1]; a balanced suggestion, e.g. share costs, design satellites to deorbit themselves, or help poorer countries [1]; a justified conclusion [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 6 | C 4]]
The Earth orbits the Sun, and the Moon orbits the Earth. The speed of light is 3.0 x 10^8 m/s.
(a) Explain why the Earth has seasons. (2 marks)
(b) Explain why the Moon appears to change shape during a month. (2 marks)
(c) Name the force that keeps the Moon in orbit around the Earth. (1 mark)
(d) Name the galaxy that contains the Sun. (1 mark)
(e) Light from the Sun takes 500 s to reach the Earth. Calculate the distance from the Sun to the Earth in metres. (2 marks)
(f) The Moon is 3.8 x 10^8 m from the Earth. Calculate the time taken for light reflected from the Moon to reach the Earth. Give your answer to 2 significant figures. (2 marks)

Total for Question 8: 10 marks$mq$, $mq$(a) The Earth's axis is tilted (about 23.5 degrees) relative to its orbit [1]; the hemisphere tilted towards the Sun receives more direct sunlight and longer days so it is warmer (summer), while the other has winter [1].
(b) Half of the Moon is always lit by the Sun [1]; as the Moon orbits the Earth we see different amounts of the lit half (phases) [1].
(c) Gravity (gravitational attraction) [1].
(d) The Milky Way [1].
(e) distance = speed x time = 3.0 x 10^8 x 500 [1] = 1.5 x 10^11 m [1].
(f) time = distance / speed = 3.8 x 10^8 / 3.0 x 10^8 [1] = 1.3 s [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Integrated Science MYP 5 eAssessment Paper B (8 tasks, 72 marks) (72 marks)
with sub as (select id from public.subjects where slug = $mq$integrated-science$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Integrated Science MYP 5 eAssessment Paper B (8 tasks, 72 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Integrated Science MYP 5 eAssessment Paper B (8 tasks, 72 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Sodium (atomic number 11, electron arrangement 2,8,1) reacts with chlorine (atomic number 17) to form sodium chloride.
(a) State the electron arrangement of a chlorine atom. (1 mark)
(b) Describe what happens to the electrons when sodium reacts with chlorine, and name the type of bond formed. (3 marks)
(c) Explain why sodium chloride has a high melting point. (2 marks)
(d) Explain why a solution of sodium chloride conducts electricity but solid sodium chloride does not. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) 2,8,7 [1].
(b) Each sodium atom loses one electron to form a positive ion, Na+ [1]; each chlorine atom gains one electron to form a negative ion, Cl- [1]; the oppositely charged ions attract each other: an ionic bond [1].
(c) There are strong electrostatic forces between oppositely charged ions throughout the giant lattice [1]; a lot of energy is needed to overcome these forces [1].
(d) In solution the ions are free to move and carry charge [1]; in the solid the ions are held in fixed positions in the lattice [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
A 12 V battery is connected in series to a 4 ohm resistor and an 8 ohm resistor.
(a) Calculate the total resistance of the circuit. (1 mark)
(b) Calculate the current in the circuit. (2 marks)
(c) Calculate the potential difference across the 8 ohm resistor. (2 marks)
(d) Calculate the power transferred by the battery. (1 mark)
Two identical lamps are connected in parallel to a battery. One lamp is removed from its holder.
(e) Explain why the other lamp stays lit. (2 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) 4 + 8 = 12 ohms [1].
(b) I = V / R = 12 / 12 [1] = 1.0 A [1].
(c) V = I x R = 1.0 x 8 [1] = 8 V [1].
(d) P = I x V = 1.0 x 12 = 12 W [1].
(e) Each lamp is on its own branch, so removing one does not break the circuit through the other [1]; the other lamp still has the full battery potential difference across it [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
During a 100 m sprint, a runner's muscles respire anaerobically as well as aerobically.
(a) Write the word equation for anaerobic respiration in human muscle. (1 mark)
(b) Explain why the runner continues to breathe heavily after finishing the race. (2 marks)
(c) Explain why anaerobic respiration releases less energy than aerobic respiration. (1 mark)
(d) Describe two features of an artery that suit its function. (2 marks)
(e) Suggest two ways in which regular training could improve a runner's supply of oxygen to the muscles. (2 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) glucose -> lactic acid [1].
(b) Extra oxygen is needed to break down the lactic acid that built up (repay the oxygen debt) [1]; this produces carbon dioxide and water and the heart and breathing rates stay high until the lactic acid is removed [1].
(c) Glucose is only partly broken down, so much of its chemical energy remains in the lactic acid [1].
(d) Thick muscular and elastic walls withstand the high pressure of blood from the heart [1]; a narrow lumen helps to keep the pressure high / elastic walls recoil to keep the blood flowing in pulses [1].
(e) Any two from: a stronger heart increases stroke volume; more capillaries in muscle; greater lung capacity; more red blood cells [2].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 8]]
Rocks are continually formed, broken down and reformed in the rock cycle.
(a) Granite is an igneous rock with large crystals. Explain how granite is formed and why its crystals are large. (2 marks)
(b) Describe how a sedimentary rock such as sandstone is formed. (2 marks)
(c) Earthquakes happen most often near the boundaries between tectonic plates. Explain why. (2 marks)
(d) Seismic S-waves cannot travel through the Earth's outer core but P-waves can. State what this tells scientists about the outer core and state one difference between P-waves and S-waves. (2 marks)

Total for Question 4: 8 marks$mq$, $mq$(a) Magma cools and solidifies underground [1]; slow cooling allows time for large crystals to grow [1].
(b) Rock is weathered and eroded; the sediments are transported and deposited in layers [1]; layers are compressed and cemented together over millions of years (compaction) [1].
(c) Plates move slowly past, towards or away from each other [1]; stress builds up where plates stick, and is released suddenly as seismic waves when the rock moves [1].
(d) The outer core is liquid [1]; P-waves are longitudinal (compression) waves and S-waves are transverse waves (P-waves travel faster) [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 10]]
A student wants to find out which material is the best insulator. She pours 200 cm3 of hot water at 80 degrees C into each of four identical metal cups. Cup 1 has no insulation. Cup 2 is wrapped in newspaper, cup 3 in cotton wool and cup 4 in bubble wrap. She measures the temperature of the water in each cup after 10 minutes.
(a) Identify the independent variable and the dependent variable. (2 marks)
(b) Formulate a hypothesis, using scientific reasoning. (2 marks)
(c) Outline three variables that must be controlled. (3 marks)
(d) Describe how the student can make the temperature measurements accurate. (2 marks)
(e) State one safety precaution. (1 mark)

Total for Question 5: 10 marks$mq$, $mq$(a) Independent: the insulating material [1]; dependent: temperature of the water after 10 minutes (or the temperature drop) [1].
(b) A prediction, e.g. the cup wrapped in cotton wool will stay hottest [1]; reasoning, e.g. cotton wool traps air, which is a poor conductor, and so reduces the transfer of thermal energy by conduction and convection [1].
(c) Any three from: volume of water; starting temperature; type and size of cup; thickness of insulation; time; room temperature; lids on or off [3].
(d) Use the same thermometer (or a temperature probe) placed in the same position, read at eye level [1]; stir gently before reading and read at exactly 10 minutes, repeating the experiment to calculate a mean [1].
(e) Any one from: take care when pouring hot water; wear eye protection; wipe up spills; use a tray [1].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 10]]
A student uses a titration to find the concentration of hydrochloric acid. She measures 25.0 cm3 of the acid into a conical flask, adds indicator and adds sodium hydroxide solution of concentration 0.100 mol/dm3 from a burette. The equation is HCl + NaOH -> NaCl + H2O. The volume of sodium hydroxide needed is called the titre.
Titre 1: 24.6 cm3. Titre 2: 24.4 cm3. Titre 3: 24.5 cm3. Titre 4: 26.1 cm3.
(a) Identify the anomalous titre. (1 mark)
(b) Calculate the mean titre using only the concordant (closely agreeing) results. (2 marks)
(c) Calculate the number of moles of sodium hydroxide in the mean titre. (2 marks)
(d) Calculate the concentration of the hydrochloric acid in mol/dm3. (3 marks)
(e) Suggest why the student repeats the titration several times. (1 mark)
(f) Suggest why the student places the flask on a white tile. (1 mark)

Total for Question 6: 10 marks$mq$, $mq$(a) 26.1 cm3 (titre 4) [1].
(b) (24.6 + 24.4 + 24.5) / 3 [1] = 24.5 cm3 [1].
(c) moles = concentration x volume in dm3 = 0.100 x 24.5 / 1000 [1] = 0.00245 mol [1].
(d) From the equation, 1 mol NaOH reacts with 1 mol HCl, so moles HCl = 0.00245 mol [1]; concentration = moles / volume = 0.00245 / 0.0250 [1] = 0.098 mol/dm3 [1].
(e) To identify anomalous results and obtain a reliable mean [1].
(f) The colour change at the end point is easier to see against a white background [1].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | D 10]]
Read the passage.
A city is testing buses that run on hydrogen. In a fuel cell the hydrogen reacts with oxygen from the air to produce electricity, and the only waste product is water. Hydrogen can be made by electrolysis, which splits water using electricity. If the electricity comes from wind or solar farms the hydrogen is called green hydrogen. However, much of the hydrogen used today is made from natural gas, which releases carbon dioxide. Hydrogen is a very light gas that is difficult to store, and the buses need special refuelling stations, which are expensive to build.
(a) Write the balanced equation for the electrolysis of water. (2 marks)
(b) Explain why a hydrogen bus does not emit carbon dioxide from its exhaust. (2 marks)
(c) Identify two challenges of using hydrogen buses. (2 marks)
(d) Evaluate whether the city should replace all diesel buses with hydrogen buses. (4 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) 2H2O [1] -> 2H2 + O2 [1].
(b) The fuel cell reacts hydrogen with oxygen, so the only product is water, which contains no carbon [1]; carbon dioxide is only made when carbon-containing fuels are burned [1].
(c) Any two from: hydrogen is hard to store because it is very light; special refuelling stations are needed; they are expensive to build; much hydrogen is made from natural gas, which releases carbon dioxide [2].
(d) Advantage with evidence, e.g. no tailpipe pollution and so cleaner city air [1]; disadvantage with evidence, e.g. cost of refuelling stations or emissions if hydrogen is not green [1]; a balanced recommendation such as starting with a trial route and green hydrogen from renewable electricity [1]; a justified conclusion [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 6 | C 4]]
Natural gas is mostly methane, CH4. Methane burns in oxygen according to the equation CH4 + 2O2 -> CO2 + 2H2O. Relative atomic masses: C = 12, H = 1, O = 16.
(a) Name the type of reaction that occurs when methane burns in oxygen. (1 mark)
(b) State what is meant by an exothermic reaction. (1 mark)
(c) Explain how burning fossil fuels increases the greenhouse effect. (2 marks)
(d) The oceans absorb some of the extra carbon dioxide. Explain the effect on the pH of the oceans. (2 marks)
(e) Calculate the relative formula mass of methane. (1 mark)
(f) Calculate the mass of carbon dioxide produced when 8.0 g of methane burns completely. (3 marks)

Total for Question 8: 10 marks$mq$, $mq$(a) Combustion (oxidation) [1].
(b) A reaction that transfers thermal energy to the surroundings (temperature of the surroundings rises) [1].
(c) Burning fossil fuels releases carbon dioxide, a greenhouse gas [1]; it traps more infrared radiation in the atmosphere, so the Earth warms more [1].
(d) Carbon dioxide dissolves in sea water to form carbonic acid [1]; this lowers the pH of the oceans (they become more acidic) [1].
(e) 12 + 4 x 1 = 16 [1].
(f) 8.0 g / 16 = 0.50 mol of methane [1]; 1 mol CH4 gives 1 mol CO2 so 0.50 mol CO2 (relative formula mass 44) [1]; 0.50 x 44 = 22 g [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Integrated Science MYP 5 eAssessment Paper C (8 tasks, 72 marks) (72 marks)
with sub as (select id from public.subjects where slug = $mq$integrated-science$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Integrated Science MYP 5 eAssessment Paper C (8 tasks, 72 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Integrated Science MYP 5 eAssessment Paper C (8 tasks, 72 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Carbon-12 and carbon-14 are two isotopes of carbon. Carbon has atomic number 6. Carbon-14 is radioactive and has a half-life of 5 730 years.
(a) State the number of protons, neutrons and electrons in a neutral atom of carbon-14. (2 marks)
(b) Define the term isotopes. (1 mark)
(c) Define the term half-life. (1 mark)
(d) A piece of ancient wood contained 16 units of carbon-14 activity when the tree died. It now has 2 units. Calculate the age of the wood. (3 marks)
(e) State one safety precaution for handling a radioactive source in a school laboratory. (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) 6 protons, 8 neutrons, 6 electrons [2]. Award 1 mark if two of the three are correct.
(b) Atoms of the same element with the same number of protons but different numbers of neutrons [1].
(c) The time taken for half of the radioactive nuclei in a sample to decay (or for the activity to halve) [1].
(d) 16 -> 8 -> 4 -> 2 is 3 half-lives [1]; 3 x 5 730 [1] = 17 190 years [1].
(e) Any one from: use tongs; keep the source in a lead-lined box; keep it pointing away from people; limit the time of exposure; keep distance [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
The immune system protects the body against pathogens.
(a) Name the type of white blood cell that produces antibodies. (1 mark)
(b) Explain how antibodies help to destroy a pathogen. (2 marks)
(c) Describe how a phagocyte destroys a bacterium. (2 marks)
(d) Some bacteria have become resistant to an antibiotic. Explain how antibiotic resistance develops in a population of bacteria. (3 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) Lymphocytes [1].
(b) Antibodies have a shape that fits a specific antigen on the pathogen and attach to it [1]; they clump pathogens together or mark them so that phagocytes destroy them [1].
(c) The phagocyte engulfs the bacterium [1]; enzymes inside the phagocyte digest it [1].
(d) A random mutation gives some bacteria resistance [1]; when the antibiotic is used, non-resistant bacteria are killed but resistant ones survive and reproduce [1]; the resistance gene is passed on so the proportion of resistant bacteria increases (natural selection) [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
A student separates the colours in black ink by paper chromatography. One coloured spot moves 3.6 cm while the solvent front moves 6.0 cm. She also wants to obtain pure water from salt water.
(a) Explain why chromatography separates the different dyes in the ink. (2 marks)
(b) Calculate the Rf value of the spot. Rf = distance moved by the spot / distance moved by the solvent. (2 marks)
(c) Describe how pure water can be obtained from salt water by distillation. (2 marks)
(d) Use the particle model to explain why a gas can be compressed but a liquid cannot. (2 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) The dyes have different solubilities in the solvent (and different attractions to the paper) [1]; so they travel different distances up the paper [1].
(b) Rf = 3.6 / 6.0 [1] = 0.60 [1].
(c) Heat the salt water so the water evaporates (boils), leaving the salt behind [1]; the vapour is cooled in a condenser and the liquid water is collected [1].
(d) In a gas the particles are far apart with large gaps, so they can be pushed closer together [1]; in a liquid the particles are already close together and touching, so there is almost no space to compress [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 8]]
Light can be reflected and refracted.
(a) State the law of reflection. (1 mark)
(b) A ray of light hits a plane mirror with an angle of incidence of 35 degrees. Calculate the angle between the incident ray and the reflected ray. (2 marks)
(c) A ray of light passes from air into glass and bends towards the normal. Name this effect and explain why it happens. (2 marks)
(d) Optical fibres carry light signals using total internal reflection. State the conditions needed for total internal reflection. (2 marks)
(e) State one use of optical fibres. (1 mark)

Total for Question 4: 8 marks$mq$, $mq$(a) The angle of incidence is equal to the angle of reflection [1].
(b) The angle of reflection is also 35 degrees [1]; the angle between the rays is 35 + 35 = 70 degrees [1].
(c) Refraction [1]; light travels more slowly in glass than in air [1].
(d) The light must travel from a more dense material to a less dense material [1]; the angle of incidence must be greater than the critical angle [1].
(e) Any one from: telecommunications and internet cables; endoscopes in medicine; decorative lighting [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 10]]
Iron rusts when it reacts with oxygen and water. A student wants to investigate how the concentration of salt in water affects the rate of rusting. She places an iron nail in each of five test tubes. Each test tube contains 20 cm3 of a salt solution made by dissolving 0 g, 1 g, 2 g, 3 g or 4 g of salt in 100 cm3 of water. The nails are dried and weighed before the test, left for 7 days, then dried and weighed again.
(a) Formulate a hypothesis, using scientific reasoning. (2 marks)
(b) Identify the independent variable and the dependent variable. (2 marks)
(c) Explain why the 0 g salt test tube is included. (1 mark)
(d) Describe how the student should prepare the 4 g solution. (2 marks)
(e) Outline two variables that must be controlled. (2 marks)
(f) Suggest one way to improve the reliability of the investigation. (1 mark)

Total for Question 5: 10 marks$mq$, $mq$(a) A prediction, e.g. the more salt in the water, the faster the nail will rust (the greater the mass gain) [1]; reasoning, e.g. dissolved salt makes the water a better conductor so ions speed up the reaction of iron with oxygen [1].
(b) Independent: mass (concentration) of salt in the water [1]; dependent: change in mass of the nail (due to rust) [1].
(c) It is the control that shows how much rusting occurs without salt, to compare with [1].
(d) Weigh 4 g of salt on a balance [1]; dissolve it in 100 cm3 of water in a beaker, stirring until fully dissolved [1].
(e) Any two from: same type and size of nail; same volume of solution; same temperature; same time left; same method of drying [2].
(f) Use more than one nail at each concentration and calculate a mean [1].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 10]]
A trolley is pulled along a low-friction track by a constant force of 2.0 N. The mass of the trolley is changed by adding masses and the acceleration is measured.
Mass (kg): 0.5, 1.0, 1.5, 2.0
Measured acceleration (m/s2): 3.9, 2.0, 1.4, 1.0
(a) Describe the relationship between the mass and the acceleration. (2 marks)
(b) Use acceleration = force / mass to calculate the predicted acceleration for a mass of 1.5 kg. Give your answer to 2 significant figures. (2 marks)
(c) Calculate the percentage difference between the measured acceleration and the predicted acceleration for 1.5 kg. Use the unrounded predicted value of 1.333 m/s2. (2 marks)
(d) Suggest one reason why the measured values differ slightly from the predicted values. (1 mark)
(e) Show that the data supports the equation force = mass x acceleration. (3 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) As the mass increases the acceleration decreases [1]; the acceleration is roughly halved when the mass doubles (inversely proportional) [1].
(b) a = 2.0 / 1.5 [1] = 1.3 m/s2 [1].
(c) (1.4 - 1.333) / 1.333 x 100 [1] = 5% [1].
(d) Any one from: friction in the wheels and air resistance; timing or measurement error; the force was not exactly constant [1].
(e) Multiply mass by acceleration for each result: 0.5 x 3.9 = 1.95, 1.0 x 2.0 = 2.0, 1.5 x 1.4 = 2.1, 2.0 x 1.0 = 2.0 [1]; each product is close to 2.0 [1]; this equals the constant force of 2.0 N, so force = mass x acceleration [1].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | D 10]]
Read the passage.
Cultured (lab-grown) meat is made by taking a small sample of cells from an animal and growing them in a nutrient liquid in large tanks called bioreactors. No animal needs to be slaughtered. An illustrative study estimates that producing 1 kg of beef from cattle releases 50 kg of carbon dioxide equivalent, mainly as methane from the cattle and carbon dioxide from clearing land for grazing. The same study estimates 15 kg for 1 kg of cultured meat if the factory uses electricity from fossil fuels, and 5 kg if it uses renewable electricity. At present cultured meat is much more expensive than beef, and some people say they would not eat it.
(a) Calculate the percentage decrease in carbon dioxide equivalent when beef is replaced by cultured meat made with renewable electricity. (2 marks)
(b) Explain how keeping cattle increases the greenhouse effect. (2 marks)
(c) Identify two benefits of cultured meat other than reduced emissions. (2 marks)
(d) Evaluate whether governments should fund research into cultured meat. (4 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) (50 - 5) / 50 x 100 [1] = 90% [1].
(b) Cattle produce methane (from digestion) which is a greenhouse gas [1]; land clearing removes trees that absorb carbon dioxide and releases carbon dioxide [1].
(c) Any two from: no animals slaughtered (animal welfare); less land needed; less water or fertiliser use; fewer antibiotics used / lower disease risk [2].
(d) A benefit with evidence, e.g. a 90% cut in emissions with renewable electricity (or 70% with fossil electricity) [1]; a drawback, e.g. it is expensive now and some consumers will not eat it [1]; a balanced consideration, e.g. emissions fall only if renewable electricity is used, so money should also support clean energy [1]; a justified conclusion [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 6 | C 4]]
Stars form from clouds of gas and dust and release energy by nuclear fusion.
(a) Galaxies show red shift. Explain how this evidence supports the Big Bang theory. (2 marks)
(b) Put these stages in the life cycle of a star like the Sun in order: red giant, nebula, white dwarf, main sequence star. (2 marks)
(c) Describe the nuclear reaction that releases energy in the Sun. (2 marks)
The nearest star to the Sun, Proxima Centauri, is 4.2 light-years away. One light-year is 9.5 x 10^12 km.
(d) Calculate the distance to Proxima Centauri in km. Give your answer to 2 significant figures. (2 marks)
(e) A space probe travels at 25 km/s. Using a distance of 4.0 x 10^13 km, calculate the time it takes in years. Use 1 year = 3.2 x 10^7 s. (2 marks)

Total for Question 8: 10 marks$mq$, $mq$(a) The light from distant galaxies is shifted towards the red end of the spectrum, which means they are moving away from us [1]; this shows that the universe is expanding, so it was once smaller and started from a single point (the Big Bang) [1].
(b) nebula, main sequence star, red giant, white dwarf [2]. Award 1 mark if one neighbouring pair is swapped.
(c) Nuclear fusion: hydrogen nuclei join to form helium nuclei [1]; this releases a large amount of energy [1].
(d) 4.2 x 9.5 x 10^12 [1] = 4.0 x 10^13 km [1].
(e) time = distance / speed = 4.0 x 10^13 / 25 = 1.6 x 10^12 s [1]; 1.6 x 10^12 / 3.2 x 10^7 = 5.0 x 10^4 years (50 000 years) [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Economics MYP 5 eAssessment Paper A (7 tasks, 69 marks) (69 marks)
with sub as (select id from public.subjects where slug = $mq$economics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Economics MYP 5 eAssessment Paper A (7 tasks, 69 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Economics MYP 5 eAssessment Paper A (7 tasks, 69 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: Scarcity and choice in a town council.

The council of Eastmere, an invented town, has 1.7 million dollars to spend this year. It cannot afford every project that residents want.

Source A: possible projects (figures created for this paper)
Project: cost (dollars); expected users per year
Library extension: 1,200,000; 40,000
Skatepark: 800,000; 25,000
Bus shelters: 500,000; 60,000
Park lighting: 600,000; 30,000

(a) Define the economic term scarcity. (2 marks)

(b) Calculate the cost per user per year for the library extension and for the bus shelters. Give the bus shelter answer to the nearest cent. (2 marks)

(c) The council chooses the library extension and the bus shelters. Explain what the opportunity cost of this decision is. (2 marks)

(d) Suggest two reasons why the council might not choose the project with the lowest cost per user. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] Scarcity is the limited supply of resources compared with unlimited wants. [1] Accept a version showing that there are not enough resources to satisfy all wants, so choices must be made.
(b) [1] Library: 1,200,000 / 40,000 = 30 dollars per user. [1] Bus shelters: 500,000 / 60,000 = 8.33 dollars per user.
(c) [1] Opportunity cost is the value of the next best alternative that is given up. [1] The council spends 1.7 million on these two projects, so it cannot also afford the skatepark or the park lighting; the lost benefit of the best of these is the opportunity cost.
(d) [1] A valid reason, e.g. some benefits cannot be measured in users (such as safer streets or education). [1] A second valid reason, e.g. fairness to groups who are not served by the cheapest project, or the long-term benefits.$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 3 | B 8]]
Task 2: The market for scooter hire.

The market for hiring electric scooters in the invented city of Dunmore is shown below. The data were created for this paper.

Source B: weekly demand and supply of scooter hire
Price per hire (dollars): 3, 4, 5, 6, 7, 8
Quantity demanded: 600, 500, 400, 300, 200, 100
Quantity supplied: 200, 300, 400, 500, 600, 700

(a) State the equilibrium price and equilibrium quantity. (1 mark)

(b) At a price of 7 dollars, calculate the size of the surplus and state what is likely to happen to the price. (2 marks)

(c) A heatwave increases the quantity demanded at every price by 200 hires. State the new equilibrium price and quantity. (2 marks)

(d) Calculate the percentage change in the equilibrium price after the heatwave. (2 marks)

(e) Explain two factors other than a heatwave that could cause demand for scooter hire to increase. (4 marks)

Total for Question 2: 11 marks$mq$, $mq$(a) [1] Price: 5 dollars and quantity 400 hires (both needed).
(b) [1] Surplus: 600 - 200 = 400 hires. [1] Price will fall, because suppliers compete to sell the unsold hires.
(c) [1] New demand at 6 dollars is 500, which equals the supply of 500. [1] New equilibrium price 6 dollars and quantity 500.
(d) [1] Method: (6 - 5) / 5 x 100. [1] 20% increase.
(e) [1] A valid factor, e.g. a rise in consumers' incomes or population or a fashion change. [1] Explained effect on demand, e.g. higher incomes allow more people to afford hires. [1] A second valid factor, e.g. a rise in the price of substitutes such as buses or taxis; a ban on cars in the centre. [1] Explained effect on demand.$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | B 10]]
Task 3: Investigating price and demand: a bus fare cut.

The invented city of Calder cut its bus fare from 2.00 dollars to 1.50 dollars. The average number of passengers each day rose from 10,000 to 12,500. A student is planning an investigation into whether the fare cut caused the rise.

(a) Write a focused enquiry question for the student's investigation. (1 mark)

(b) Calculate the percentage change in the fare and the percentage change in the number of passengers. (2 marks)

(c) Calculate the price elasticity of demand for bus travel and explain what the value shows. (2 marks)

(d) Explain two other factors that might have changed passenger numbers at the same time and describe how the student could take them into account. (3 marks)

(e) Name two sources of data the student could use and give one limitation of one of them. (2 marks)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] A clear, focused question about the effect of the fare cut on passenger numbers (e.g. How did the bus fare cut affect daily passenger numbers in Calder in the six months after the cut?).
(b) [1] Fare: (1.50 - 2.00) / 2.00 x 100 = -25%. [1] Passengers: (12,500 - 10,000) / 10,000 x 100 = +25%.
(c) [1] PED = +25 / -25 = -1.0 (accept 1.0 ignoring the sign). [1] Demand is unit elastic: the percentage change in quantity equals the percentage change in price, so revenue stays about the same.
(d) [1] A valid other factor (e.g. higher petrol prices, a change in school terms, a new factory or road works). [1] A way of taking it into account (e.g. compare with the same months in the previous year). [1] A second factor or a second way of controlling (e.g. record weather conditions or use another city's data as a comparison).
(e) [1] Two relevant sources named (e.g. bus company ticket records and a passenger survey). [1] A valid limitation (e.g. survey answers may be inaccurate or the sample may be biased; ticket records do not explain why people travel).$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | A 4 | D 7]]
Task 4: A minimum price for milk.

The government of the invented country of Varnia is considering a minimum price (price floor) of 2.50 dollars a litre for milk. The free-market equilibrium price is 2.00 dollars a litre at 7,000 litres a week. At 2.50 dollars, the quantity demanded is 6,000 litres a week and the quantity supplied is 9,000 litres a week.

Source C: a statement by the dairy farmers' union (imagined)
"Our members cannot cover their costs at two dollars. A minimum price protects family farms, which keep our countryside alive and our food supply secure."

Source D: a statement by a consumer group (imagined)
"A minimum price forces families to pay more for a basic food, and the poorest households will suffer. Taxpayers will also pay if the government has to buy up the surplus."

(a) Explain why a minimum price set above the equilibrium price causes a surplus. (2 marks)

(b) Calculate the weekly surplus of milk at the minimum price. (1 mark)

(c) The government buys the surplus at the minimum price. Calculate the weekly cost. (1 mark)

(d) Compare the views in Source C and Source D. (3 marks)

(e) Evaluate whether the minimum price is the best way to support dairy farmers. You may suggest an alternative policy. (4 marks)

Total for Question 4: 11 marks$mq$, $mq$(a) [1] At the higher price more producers are willing to supply (9,000 litres), but consumers buy less (6,000). [1] The quantity supplied is greater than the quantity demanded, so unsold milk remains.
(b) [1] 9,000 - 6,000 = 3,000 litres.
(c) [1] 3,000 x 2.50 = 7,500 dollars.
(d) [1] Source C supports the policy because it protects farmers' incomes and local farms. [1] Source D opposes it because of higher prices and the cost to taxpayers. [1] A comparison, e.g. each focuses on a different stakeholder (producers against consumers and taxpayers).
(e) [1] A benefit of the policy, e.g. guaranteed higher income for farmers and stable supply. [1] A cost of the policy, e.g. higher prices for consumers and the cost of the surplus (7,500 dollars a week). [1] An alternative, e.g. direct income payments or a subsidy, with an explanation of how it works. [1] A supported judgement.$mq$, $mq$D$mq$),
(5, $mq$[[Q 5 | A 2 | C 6]]
Task 5: Inflation and living costs.

The consumer price index (CPI) measures changes in the average price of goods and services bought by households. Data for the invented country of Pelavia were created for this paper.

Source E: CPI in Pelavia
Year 1: 100
Year 2: 104
Year 3: 109.2
In Year 3 the average wage in Pelavia rose by 3 percent.

(a) Calculate the inflation rate between Year 2 and Year 3. (2 marks)

(b) Write a short article of about 120 words for a community newsletter explaining how inflation of this size affects ordinary households in Pelavia. Refer to workers, and to people with savings or on fixed incomes. Marks are given for your economic knowledge and for how clearly you communicate to the general reader. (6 marks)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] Method: (109.2 - 104) / 104 x 100. [1] 5%
(b) [1] Explains that inflation means a general rise in prices, so money buys less. [1] Uses the data: wages rose 3 percent while prices rose 5 percent, so real wages fell by about 2 percent. [1] Explains the effect on a group with a fixed income (e.g. pensioners) or savers whose savings lose value if interest rates are below inflation. [1] Explains a further effect (e.g. borrowers gain because debts are worth less, or businesses face rising costs). [1] Communication: language suitable for the general reader, with a clear opening and conclusion. [1] Communication: logical order and accurate economic terms (e.g. real wages, inflation, fixed income).$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | D 9]]
Task 6: A tariff on imported shoes.

The government of Zaria, an invented country, put a 20 percent tariff on imported shoes. The data were created for this paper.

Source F: a government poster (imagined, described in words)
A cartoon of a smiling cobbler stands in front of a workshop. The slogan reads: MAKE IT HERE, KEEP JOBS HERE. A smaller line says: Foreign shoes now pay their way.

Source G: effects of the tariff
Before the tariff: price of imported shoes 30 dollars; imports 500,000 pairs; jobs in domestic shoe making 4,000.
After the tariff: price of imported shoes 36 dollars; imports 400,000 pairs; jobs in domestic shoe making 4,600.

(a) Calculate the government's tariff revenue after the tariff was introduced. (2 marks)

(b) Using Source G, explain how far the data support the claim on the poster that the tariff will keep jobs in Zaria. (3 marks)

(c) Evaluate the effects of the tariff on different groups in Zaria, including consumers, domestic producers and the government. (4 marks)

Total for Question 6: 9 marks$mq$, $mq$(a) [1] Tariff per pair = 20% of 30 = 6 dollars. [1] 400,000 x 6 = 2,400,000 dollars (2.4 million).
(b) [1] Jobs rose by 600 (from 4,000 to 4,600), which supports the claim. [1] The data do not show whether the rise was caused by the tariff, and they ignore jobs lost elsewhere (for example in shops, ports or exports). [1] The poster is government publicity and presents only the benefit.
(c) [1] Consumers: pay higher prices (36 against 30 dollars) and have less choice. [1] Domestic producers: gain sales and jobs because imports are more expensive. [1] Government: gains tax revenue (2.4 million dollars). [1] A judgement or further effect, e.g. other countries might retaliate and hurt exporters, so overall effects depend on how long the tariff stays.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | C 2 | D 10]]
Task 7: Growth and sustainability: extended response.

Statement: A country cannot achieve both rapid economic growth and environmental sustainability.

Evaluate this statement. Use specific examples that you have studied, such as carbon taxes, renewable energy subsidies, tradable permits, or the use of natural resources in developing countries. You should:
- explain why growth may harm the environment,
- explain how policies might allow growth and sustainability to be combined,
- reach a supported judgement.

(a) Evaluate the statement. Your answer will be marked for your knowledge and evaluation (10 marks) and for the quality of your communication (2 marks). (12 marks)

Total for Question 7: 12 marks$mq$, $mq$(a) [1] Explains that growth usually raises output and uses more energy and raw materials, so it can increase pollution and resource depletion. [1] A specific example of harm, e.g. burning coal for power; deforestation for farming; overfishing. [1] Explains the idea of externalities, i.e. costs to third parties that are not in the market price. [1] Recognises that GDP does not measure environmental damage or the use of natural resources. [1] Explains a policy that can combine them with a specific example (e.g. a carbon tax raises the price of polluting fuels and encourages cleaner production). [1] A second policy, e.g. subsidies for renewable energy, tradable pollution permits, or regulations. [1] Explains how technology or efficiency can let output rise while pollution falls (e.g. renewable energy cheaper over time). [1] Evaluates the limits or costs of policies (e.g. higher costs for firms and consumers, difficulty of international agreement, poor countries may need growth first). [1] Considers differences between rich and poor countries or short-run and long-run effects. [1] A clear judgement. [1] The judgement is supported by weighing the evidence, not just listing it. [1] Communication: a clear introduction, structured paragraphs and a conclusion, with accurate economic vocabulary.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);
commit;
