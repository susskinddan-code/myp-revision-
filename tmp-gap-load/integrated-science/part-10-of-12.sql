-- Part 10 of 12: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Ecosystems and the Environment > Food Webs and Energy Flow
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Ecosystems and the Environment$mq$, 5, 10 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Food Webs and Energy Flow$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Ecosystems and the Environment$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Food Webs and Energy Flow$mq$ and p.name = $mq$Ecosystems and the Environment$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In a food chain, what does the arrow between two organisms show?$mq$, $mq$["The direction of energy transfer","Which organism is bigger","Which organism is faster","The direction of water movement"]$mq$, 0, $mq$Arrows point from the food to the feeder, showing the direction in which energy and biomass move.$mq$, $mq$easy$mq$),
($mq$Which organisms are producers?$mq$, $mq$["Rabbits","Fungi","Foxes","Green plants and algae"]$mq$, 3, $mq$Producers make their own food by photosynthesis, so they capture light energy and start the food chain.$mq$, $mq$easy$mq$),
($mq$An organism that eats only plants is called a$mq$, $mq$["secondary consumer","decomposer","primary consumer","producer"]$mq$, 2, $mq$Herbivores are primary consumers because they are the first consumers in the chain.$mq$, $mq$easy$mq$),
($mq$What is the original source of energy for almost all food chains on Earth?$mq$, $mq$["The soil","The Sun","Decomposers","The wind"]$mq$, 1, $mq$Sunlight is captured by producers during photosynthesis and then passed along food chains.$mq$, $mq$easy$mq$),
($mq$What is a trophic level?$mq$, $mq$["A feeding position in a food chain","A type of habitat","A group of the same species","A measure of soil depth"]$mq$, 0, $mq$Trophic levels are the steps in a food chain: producers, primary consumers, secondary consumers and so on.$mq$, $mq$easy$mq$),
($mq$A food chain is: grass → grasshopper → frog → snake. If the frog population falls sharply, what will most likely happen to the grasshoppers at first?$mq$, $mq$["They will decrease","They will stay exactly the same","They will become producers","They will increase"]$mq$, 3, $mq$Fewer frogs means fewer grasshoppers are eaten, so the grasshopper population will tend to increase, at least until food becomes limiting.$mq$, $mq$medium$mq$),
($mq$Grass in a meadow stores 20 000 kJ of energy per square metre each year. The rabbits eating the grass store 2 000 kJ. What percentage of energy is transferred to the rabbits?$mq$, $mq$["1%","90%","10%","20%"]$mq$, 2, $mq$2 000 ÷ 20 000 × 100 = 10%.$mq$, $mq$medium$mq$),
($mq$Which of these is NOT a way that energy is lost between trophic levels?$mq$, $mq$["Heat from respiration","Energy is created by consumers","Parts that are not eaten, such as bones","Energy in waste (faeces)"]$mq$, 1, $mq$Energy cannot be created. It is lost as heat from respiration, in uneaten parts and in waste.$mq$, $mq$medium$mq$),
($mq$Why do most food chains have only four or five trophic levels?$mq$, $mq$["Energy is lost at each stage, so too little remains for further levels","Animals are too small","Plants cannot support more animals","Predators do not eat other predators"]$mq$, 0, $mq$With about 10% transfer, very little energy remains after four or five steps to support another level.$mq$, $mq$medium$mq$),
($mq$A researcher marks 40 beetles and releases them. A later sample of 30 beetles contains 6 marked ones. Using population = (first sample × second sample) ÷ marked in second sample, estimate the population.$mq$, $mq$["120","7","1200","200"]$mq$, 3, $mq$40 × 30 ÷ 6 = 200 beetles. The method assumes marked beetles mix fully and that marking does not harm them.$mq$, $mq$medium$mq$),
($mq$A student counts 90 daisies in 12 quadrats, each 0.25 m². The field is 400 m². Which is the best estimate of the number of daisies in the field?$mq$, $mq$["1 800","3 600","12 000","30"]$mq$, 2, $mq$90 ÷ 12 = 7.5 per quadrat. 7.5 ÷ 0.25 = 30 per m². 30 × 400 = 12 000.$mq$, $mq$medium$mq$),
($mq$A pesticide is sprayed on a lake. Concentrations in organisms are: algae 0.02 ppm, small fish 0.5 ppm, large fish 4 ppm, fish-eating birds 25 ppm. What process does this show?$mq$, $mq$["Photosynthesis","Bioaccumulation (biomagnification)","Decomposition","Eutrophication"]$mq$, 1, $mq$Toxins that are not broken down build up and become more concentrated at each trophic level.$mq$, $mq$medium$mq$),
($mq$Which pyramid shape is almost always seen for biomass in a land ecosystem?$mq$, $mq$["Wide at the bottom and narrower at the top","Narrow at the bottom and wide at the top","The same width at every level","Wider in the middle"]$mq$, 0, $mq$Producers have the greatest biomass, and each higher level has less because energy is lost.$mq$, $mq$medium$mq$),
($mq$Producers in an ecosystem have 5 000 kJ of energy. Assuming 10% transfer at each step, how much energy reaches the tertiary consumers (producer → primary → secondary → tertiary)?$mq$, $mq$["50 kJ","0.5 kJ","500 kJ","5 kJ"]$mq$, 3, $mq$There are three transfers: 5 000 × 0.1 × 0.1 × 0.1 = 5 kJ.$mq$, $mq$hard$mq$),
($mq$Energy values: producers 8 000 kJ, primary consumers 960 kJ, secondary consumers 120 kJ. Which statement is correct?$mq$, $mq$["The transfer from producers to primary consumers is 8%","Both transfers have the same efficiency","The transfer from primary to secondary consumers is more efficient than from producers to primary consumers","Energy increases between levels"]$mq$, 2, $mq$960 ÷ 8 000 = 12% and 120 ÷ 960 = 12.5%, so the second transfer is slightly more efficient.$mq$, $mq$hard$mq$),
($mq$A student estimates the population of a plant on a school field by placing quadrats only along the edge of a path. Why might the estimate be unreliable?$mq$, $mq$["Quadrats should be circular","The sampling was not random, so it may not represent the whole field","Plants should be counted at night","Only the largest plants should be counted"]$mq$, 1, $mq$Sampling next to a path may involve trampling or different light and soil. Random placement, for example with random coordinates, reduces bias.$mq$, $mq$hard$mq$),
($mq$In a grassland, rabbits eat grass and foxes eat rabbits. Disease kills most of the rabbits. Which short-term prediction is best supported?$mq$, $mq$["Fox numbers fall and the grass increases","Fox numbers increase and the grass increases","Fox numbers stay the same and the grass decreases","Grass disappears completely"]$mq$, 0, $mq$Less food for foxes reduces their numbers, and fewer rabbits grazing allows grass to grow more.$mq$, $mq$hard$mq$),
($mq$A student claims: 'Eating plants is a more efficient use of land than eating meat.' Which energy argument best supports the claim?$mq$, $mq$["Plants contain more protein than meat","Animals do not respire","Plants take less time to digest","Eating plants uses fewer trophic levels so less energy is lost"]$mq$, 3, $mq$Energy is lost between trophic levels. A human eating plants takes energy directly from the producer level, while eating meat adds an extra level of loss.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Food Webs and Energy Flow$mq$ and p.name = $mq$Ecosystems and the Environment$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Producer$mq$, $mq$An organism that makes its own food by photosynthesis, such as a plant or alga. It starts a food chain.$mq$),
($mq$Primary, secondary, tertiary consumers$mq$, $mq$Primary eat producers (herbivores). Secondary eat primary consumers. Tertiary eat secondary consumers.$mq$),
($mq$Food chain arrow$mq$, $mq$Points from the organism eaten to the one eating it, showing energy transfer.$mq$),
($mq$Energy transfer between trophic levels$mq$, $mq$About 10%. The rest is lost as heat from respiration, waste and uneaten parts.$mq$),
($mq$Percentage efficiency formula$mq$, $mq$(Energy passed to next level ÷ energy available) × 100.$mq$),
($mq$Why food chains are short$mq$, $mq$So much energy is lost at each stage that too little remains to support more than about four or five levels.$mq$),
($mq$Quadrat sampling$mq$, $mq$Place quadrats randomly, count organisms, find the mean per quadrat, then scale up to the whole area.$mq$),
($mq$Capture–mark–recapture formula$mq$, $mq$Population = (first sample × second sample) ÷ number of marked animals in the second sample.$mq$),
($mq$Bioaccumulation$mq$, $mq$Toxins that are not broken down become more concentrated at each trophic level, harming top predators most.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Food Webs and Energy Flow$mq$ and p.name = $mq$Ecosystems and the Environment$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$A food chain shows how energy and biomass pass from one organism to the next. A food web is a network of many linked food chains and gives a more realistic picture. The arrow points from the organism being eaten to the organism that eats it, showing the direction of energy flow.

## Trophic levels
- **Producers** (plants, algae) make food by photosynthesis. They are the first trophic level.
- **Primary consumers** (herbivores) eat producers.
- **Secondary consumers** (carnivores or omnivores) eat primary consumers. **Tertiary consumers** eat secondary consumers.
- **Decomposers** (bacteria and fungi) break down dead material and waste and return nutrients to the soil.
- A **top predator** has no natural predators.

## Energy flow
Nearly all energy comes from the Sun. Only a small fraction of sunlight is captured by producers. At each step, only about **10%** of the energy is passed to the next level. The rest is lost as heat from respiration, in waste such as faeces, and in parts that are not eaten such as bones or roots. This is why food chains are short, why top predators are rare and why biomass pyramids narrow towards the top.

Efficiency of transfer = (energy passed on ÷ energy available) × 100. Worked example: producers store 8 000 kJ and the primary consumers store 960 kJ. Efficiency = 960 ÷ 8 000 × 100 = 12%. Starting with 5 000 kJ and a 10% transfer at three steps gives 5 000 × 0.1³ = 5 kJ at the end.

## Changes in a web
If one population changes, others are affected. If a predator is removed, its prey will usually increase at first. If a producer declines, herbivores may starve. Predator and prey numbers often rise and fall in linked cycles, with the predator peak following the prey peak. Introduced species with no predators can disrupt a web.

## Sampling populations
Ecologists cannot usually count every organism, so they sample.
- **Quadrats**: place them randomly (for example with random coordinates), count organisms and calculate the mean per quadrat. Worked example: 90 plants in 12 quadrats of 0.25 m². Mean 7.5 per quadrat, which is 30 per m². A field of 400 m² therefore holds about 12 000.
- **Capture–mark–recapture**: population = (number in first sample × number in second sample) ÷ number of marked animals recaptured. For example 40 × 30 ÷ 6 = 200. This assumes the marks do not harm the animals, marked animals mix evenly, and there is no migration or births and deaths.
- Larger samples and repeated measurements give more reliable estimates.

## Bioaccumulation
Some toxic substances, such as certain pesticides and mercury, are not broken down. They are absorbed by producers and become more concentrated at each level of the chain, so top predators suffer the most. This is called bioaccumulation, or biomagnification.

## How this is examined
Expect a food web or data about energy at each level. You may be asked to identify trophic levels, calculate percentage efficiency, predict what happens when one organism is removed and evaluate a sampling method. Use the words "trophic level", "energy transfer" and "population" precisely.

## Common mistakes
- Saying energy is "used up" or "destroyed". It is transferred, and mostly lost as heat.
- Drawing arrows from the eater to the food.
- Forgetting that quadrats must be placed randomly.

Exam tip: For prediction questions, explain the effect step by step (for example fewer predators, then more prey, then less food for prey). For percentage questions show the division and multiplication by 100, and include units.$mq$ from st;

-- Ecosystems and the Environment > Nutrient Cycles and Decomposition
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Ecosystems and the Environment$mq$, 5, 10 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Nutrient Cycles and Decomposition$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Ecosystems and the Environment$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Nutrient Cycles and Decomposition$mq$ and p.name = $mq$Ecosystems and the Environment$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which process removes carbon dioxide from the atmosphere?$mq$, $mq$["Photosynthesis","Respiration","Combustion","Decomposition"]$mq$, 0, $mq$Plants and algae take in CO₂ during photosynthesis. Respiration, combustion and decay release it.$mq$, $mq$easy$mq$),
($mq$Which organisms break down dead plants and animals and recycle nutrients?$mq$, $mq$["Producers","Herbivores","Predators","Decomposers"]$mq$, 3, $mq$Bacteria and fungi are decomposers. They release nutrients into the soil.$mq$, $mq$easy$mq$),
($mq$Which gas makes up about 78% of the air?$mq$, $mq$["Oxygen","Carbon dioxide","Nitrogen","Argon"]$mq$, 2, $mq$Air is about 78% nitrogen, 21% oxygen and 1% other gases (including argon and carbon dioxide).$mq$, $mq$easy$mq$),
($mq$Why do plants need nitrates from the soil?$mq$, $mq$["To make glucose","To make proteins","To make starch","To absorb sunlight"]$mq$, 1, $mq$Nitrates provide nitrogen, which plants need to make amino acids and proteins.$mq$, $mq$easy$mq$),
($mq$Burning fossil fuels adds which gas to the atmosphere?$mq$, $mq$["Carbon dioxide","Nitrogen","Hydrogen","Helium"]$mq$, 0, $mq$Combustion of carbon-containing fuels releases carbon dioxide.$mq$, $mq$easy$mq$),
($mq$Which of these conditions speeds up decay the most?$mq$, $mq$["Cold and dry","Frozen","Very acidic and waterlogged","Warm, moist and well-aerated"]$mq$, 3, $mq$Decomposers respire and grow best when it is warm, moist and has oxygen. Cold, dry or waterlogged conditions slow decay.$mq$, $mq$medium$mq$),
($mq$Bacteria that convert nitrogen gas into ammonium compounds are called$mq$, $mq$["denitrifying bacteria","decomposers only","nitrogen-fixing bacteria","photosynthetic bacteria"]$mq$, 2, $mq$Nitrogen-fixing bacteria live in the soil or in root nodules of legumes. They convert N₂ into compounds plants can use.$mq$, $mq$medium$mq$),
($mq$Why do farmers sometimes grow clover or beans and then plough them back into the soil?$mq$, $mq$["These plants release oxygen","The root nodules contain nitrogen-fixing bacteria that enrich the soil","These plants repel water","They make the soil colder"]$mq$, 1, $mq$Legumes have nitrogen-fixing bacteria in their roots. Ploughing in the plants adds nitrogen compounds to the soil.$mq$, $mq$medium$mq$),
($mq$A student buries 20 g of dry leaves in soil. After 10 days the leaves have a mass of 14 g. What is the percentage mass lost?$mq$, $mq$["30%","6%","70%","43%"]$mq$, 0, $mq$(20 − 14) ÷ 20 × 100 = 30%.$mq$, $mq$medium$mq$),
($mq$In the same experiment, what is the mean rate of mass loss per day?$mq$, $mq$["1.4 g per day","2 g per day","6 g per day","0.6 g per day"]$mq$, 3, $mq$6 g lost ÷ 10 days = 0.6 g per day.$mq$, $mq$medium$mq$),
($mq$What happens to the carbon in dead leaves when decomposers respire?$mq$, $mq$["It is destroyed","It becomes nitrogen","It is released as carbon dioxide","It turns into oxygen"]$mq$, 2, $mq$Decomposers respire, releasing CO₂, and carbon atoms are not destroyed. This returns carbon to the atmosphere.$mq$, $mq$medium$mq$),
($mq$Waterlogged soil often has fewer nitrates. Which process is most likely responsible?$mq$, $mq$["Photosynthesis in roots","Denitrifying bacteria convert nitrates to nitrogen gas","Faster decomposition","Nitrogen fixation by lightning"]$mq$, 1, $mq$Denitrifying bacteria work without oxygen and convert nitrates into nitrogen gas, so nitrates are lost from the soil.$mq$, $mq$medium$mq$),
($mq$Why is the carbon cycle described as a cycle and not a one-way flow?$mq$, $mq$["Carbon atoms are recycled between the atmosphere, organisms and the ground","Energy is recycled","Carbon is created in plants","Carbon is destroyed by animals"]$mq$, 0, $mq$The same carbon atoms are reused. Unlike energy, matter is conserved and recycled.$mq$, $mq$medium$mq$),
($mq$Four jars contain the same amount of grass cuttings. Jar P is kept at 5°C, Q at 20°C, R at 35°C and S at 80°C. After a week the greatest mass loss is in jar R. What is the best reason for jar S losing little mass?$mq$, $mq$["Grass does not decay above 20°C","Decomposers prefer cold","Water was too abundant","The high temperature denatured the enzymes of decomposers"]$mq$, 3, $mq$Very high temperatures denature enzymes and kill decomposers, so decay slows. Jar R is closer to the optimum.$mq$, $mq$hard$mq$),
($mq$In an experiment to test the effect of moisture on decay, which variable must be kept the same?$mq$, $mq$["Amount of water","Colour of the container","Temperature, mass of material and type of material","The number of days only"]$mq$, 2, $mq$Only moisture should change. All other factors, such as temperature, mass and material, are controlled variables.$mq$, $mq$hard$mq$),
($mq$Farmers apply too much fertiliser and heavy rain washes nitrates into a river. Which is the correct sequence of effects?$mq$, $mq$["Fish increase, algae decrease, oxygen increases","Algae grow rapidly, then die, decomposers use up oxygen, fish die","Decomposers decrease, then algae increase, then nitrates disappear","Oxygen increases, then fish increase"]$mq$, 1, $mq$This is eutrophication. Extra nutrients cause an algal bloom. When the algae die, decomposers respire and use up the oxygen, so fish die.$mq$, $mq$hard$mq$),
($mq$A compost heap is turned regularly and kept moist. Why does turning help?$mq$, $mq$["It brings in oxygen for aerobic decomposers","It removes carbon","It lowers the temperature to 0°C","It adds nitrogen gas"]$mq$, 0, $mq$Aerobic decomposers need oxygen. Turning the heap mixes air through it and speeds up decay.$mq$, $mq$hard$mq$),
($mq$Peat bogs are waterlogged, acidic and low in oxygen. What does this explain about dead plant material in peat?$mq$, $mq$["It decays more quickly than in warm soil","It becomes nitrates immediately","It is converted into oxygen","It decays very slowly, so carbon is stored for a long time"]$mq$, 3, $mq$Decomposers are inhibited in these conditions, so carbon stays locked in the peat. Draining bogs releases CO₂.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Nutrient Cycles and Decomposition$mq$ and p.name = $mq$Ecosystems and the Environment$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Photosynthesis in the carbon cycle$mq$, $mq$Removes CO₂ from the air and builds carbon into glucose and other compounds.$mq$),
($mq$Processes that return CO₂ to the air$mq$, $mq$Respiration, decomposition and combustion.$mq$),
($mq$Nitrogen fixation$mq$, $mq$Bacteria (soil and root nodules of legumes) and lightning convert N₂ into compounds that plants can use.$mq$),
($mq$Nitrification$mq$, $mq$Nitrifying bacteria convert ammonium compounds into nitrates.$mq$),
($mq$Denitrification$mq$, $mq$Denitrifying bacteria convert nitrates to nitrogen gas, mainly in waterlogged soil with little oxygen.$mq$),
($mq$Role of decomposers$mq$, $mq$Bacteria and fungi break down dead material and waste, releasing nutrients to the soil and CO₂ to the air.$mq$),
($mq$Conditions for fast decay$mq$, $mq$Warm (not too hot), moist and plenty of oxygen.$mq$),
($mq$Eutrophication sequence$mq$, $mq$Fertiliser runoff, algal bloom, algae die, decomposers use up oxygen, fish die.$mq$),
($mq$Why plants need nitrates$mq$, $mq$To make amino acids and then proteins.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Nutrient Cycles and Decomposition$mq$ and p.name = $mq$Ecosystems and the Environment$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Matter, unlike energy, is recycled in ecosystems. The atoms in your body have been part of many other organisms. Nutrient cycles show how elements move between living things, the air, water and soil. Decomposers drive these cycles by breaking down dead material and waste.

## The carbon cycle
- **Photosynthesis** removes CO₂ from the air and builds carbon into glucose and other compounds in plants.
- **Feeding** passes carbon compounds along the food chain.
- **Respiration** by plants, animals and decomposers returns CO₂ to the air.
- **Decomposition** of dead organisms and waste releases CO₂ (and returns other nutrients to the soil).
- **Combustion** of wood and fossil fuels releases CO₂ quickly.
- Over millions of years, dead organisms can become coal, oil and gas. In peat bogs, carbon is stored because decay is very slow.

## The nitrogen cycle
Air is about 78% nitrogen gas (N₂), but plants cannot use it. They need nitrates from the soil to build amino acids and proteins. Key processes:
- **Nitrogen fixation**: nitrogen-fixing bacteria (in the soil and in the root nodules of legumes such as peas and clover) and lightning convert N₂ into compounds plants can use.
- **Decomposition**: decomposers turn proteins and urea into ammonium compounds.
- **Nitrification**: nitrifying bacteria convert ammonium compounds into nitrates.
- **Uptake**: plants absorb nitrates and make proteins, which animals eat.
- **Denitrification**: denitrifying bacteria, often in waterlogged soil with little oxygen, convert nitrates into nitrogen gas, which is lost to the air.
Farmers add fertilisers, rotate crops with legumes and plough in clover to restore nitrates.

## Conditions affecting decay
Decomposers need warmth, moisture and oxygen (most are aerobic). Decay is fast at about 25–40°C, slow in the cold, stopped in very dry conditions and slow when waterlogged. Temperatures that are too high denature the enzymes of decomposers. Composting speeds up decay by keeping the heap warm, moist and aerated, which produces a nutrient-rich material for soil.

## Investigating decay
A typical investigation measures the mass of leaves or bread before and after a set time at different temperatures. Example: 20 g of leaves decrease to 14 g in 10 days. Percentage lost = (20 − 14) ÷ 20 × 100 = 30%. Rate = 6 ÷ 10 = 0.6 g per day. In a fair test, change one variable (temperature), measure the effect (mass loss) and control the others (type and mass of leaves, moisture, time). Repeating the experiment and calculating a mean improves reliability.

## Eutrophication
When fertiliser runs off into rivers, algae grow rapidly (an algal bloom). Algae at the surface block light, plants below die, and decomposers multiply and use up the dissolved oxygen. Fish and other animals die from lack of oxygen.

## How this is examined
A common context is a farm or lake with data on nitrate levels or a decay experiment. You may need to explain a process in order, plan a fair test, calculate a rate or percentage change and suggest improvements.

Exam tip: In cycle questions, name the process and the organisms involved (for example denitrifying bacteria in waterlogged soil). In experiment questions, state the independent, dependent and controlled variables.$mq$ from st;

-- Ecosystems and the Environment > Human Impact and Conservation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Ecosystems and the Environment$mq$, 5, 10 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Human Impact and Conservation$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Ecosystems and the Environment$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Human Impact and Conservation$mq$ and p.name = $mq$Ecosystems and the Environment$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is biodiversity?$mq$, $mq$["The variety of living organisms in an area","The number of individuals of one species","The mass of all plants in a forest","The amount of rainfall in an area"]$mq$, 0, $mq$Biodiversity includes the variety of species, genetic variety within them and variety of habitats.$mq$, $mq$easy$mq$),
($mq$Which human activity is a major cause of habitat loss?$mq$, $mq$["Recycling","Planting hedgerows","Creating nature reserves","Deforestation"]$mq$, 3, $mq$Clearing forests for farming, timber, mining and building removes habitats and reduces biodiversity.$mq$, $mq$easy$mq$),
($mq$Which gas released by burning fossil fuels contributes to global warming?$mq$, $mq$["Oxygen","Nitrogen","Carbon dioxide","Argon"]$mq$, 2, $mq$Carbon dioxide is a greenhouse gas that traps thermal energy in the atmosphere.$mq$, $mq$easy$mq$),
($mq$What is a nature reserve or national park?$mq$, $mq$["A farm that grows only one crop","A protected area that conserves wildlife and habitats","A zoo","A landfill site"]$mq$, 1, $mq$Protected areas limit damaging activities so that species and habitats are conserved.$mq$, $mq$easy$mq$),
($mq$What does sustainable use of a resource mean?$mq$, $mq$["Using it in a way that meets present needs without harming future generations","Using it as quickly as possible","Never using it at all","Using only imported resources"]$mq$, 0, $mq$Sustainability balances present use with the ability of future generations to meet their own needs.$mq$, $mq$easy$mq$),
($mq$A forest of 1 800 km² is reduced to 1 350 km² in ten years. What percentage of the forest has been lost?$mq$, $mq$["33%","75%","450%","25%"]$mq$, 3, $mq$(1 800 − 1 350) ÷ 1 800 × 100 = 25%.$mq$, $mq$medium$mq$),
($mq$Overfishing can cause fish populations to collapse. Which management method would best help?$mq$, $mq$["Using more boats","Fishing only in breeding season","Setting catch quotas and larger net mesh sizes","Removing all fishing limits"]$mq$, 2, $mq$Quotas limit the numbers caught, and bigger mesh lets young fish escape and breed. Fishing during breeding season would make things worse.$mq$, $mq$medium$mq$),
($mq$Why is a captive breeding programme in a zoo useful for an endangered species?$mq$, $mq$["It makes the species extinct","It increases numbers so animals can later be released","It prevents any mutation","It removes the need to protect habitats"]$mq$, 1, $mq$Captive breeding increases numbers and can allow reintroduction, although habitats still need to be protected.$mq$, $mq$medium$mq$),
($mq$Which of these is the main purpose of a seed bank?$mq$, $mq$["To store seeds so plant species can be preserved and regrown","To sell fruit","To make fertiliser","To grow only crops for food"]$mq$, 0, $mq$Seed banks preserve genetic diversity as insurance against extinction.$mq$, $mq$medium$mq$),
($mq$Indicator species such as lichens and mayfly larvae are used because$mq$, $mq$["they are always the most numerous","they are the largest species","they are the top predators","their presence or absence shows the level of pollution"]$mq$, 3, $mq$Some species are sensitive to pollution. For example, mayfly larvae need clean, well-oxygenated water.$mq$, $mq$medium$mq$),
($mq$A scientist counts the number of different species in two woods. Wood X has 12 species and wood Y has 30 species. Which statement is correct?$mq$, $mq$["Wood X has the higher biodiversity","The woods have equal biodiversity","Wood Y has the higher species richness","Wood X is healthier because it has fewer species"]$mq$, 2, $mq$Species richness is the number of different species. 30 > 12 so wood Y has higher species richness, though other factors also matter.$mq$, $mq$medium$mq$),
($mq$Why is monoculture (growing one crop over large areas) bad for biodiversity?$mq$, $mq$["It adds new species","It reduces habitats and food sources for wildlife","It increases the number of food webs","It improves soil by itself"]$mq$, 1, $mq$Large single-crop fields offer few habitats and food sources, so fewer species can live there.$mq$, $mq$medium$mq$),
($mq$A town uses recycled paper in place of new paper. Which environmental benefit is most directly linked to this?$mq$, $mq$["Fewer trees need to be cut down","More fossil fuels are produced","Higher CO₂ in the atmosphere","More landfill is needed"]$mq$, 0, $mq$Recycling reduces the demand for raw materials such as wood and reduces waste in landfill.$mq$, $mq$medium$mq$),
($mq$A coastal reserve protects a bird species. Numbers: Year 1: 240 birds, Year 5: 300 birds. Visitors increased from 2 000 to 9 000 a year. What is the best conclusion?$mq$, $mq$["Visitors have no possible effect","The reserve has failed","The bird numbers have doubled","The reserve may be helping, but visitor increase needs monitoring"]$mq$, 3, $mq$Numbers rose 25%, so the reserve seems to help, but the visitor increase could cause disturbance. One data set does not prove cause.$mq$, $mq$hard$mq$),
($mq$Which action would be MOST effective at reducing the long-term rise in atmospheric CO₂?$mq$, $mq$["Planting no new trees","Burning more wood","Reducing fossil fuel use and increasing renewable energy","Using more petrol cars"]$mq$, 2, $mq$The main cause of the rise in CO₂ is fossil fuel combustion, so reducing it is most effective. Trees help but cannot offset large emissions alone.$mq$, $mq$hard$mq$),
($mq$A species of frog lives in only one small pond. Which threat poses the greatest risk of extinction?$mq$, $mq$["A small increase in rainfall","Draining the pond","A rise in the number of visitors by 5%","A new species of plant"]$mq$, 1, $mq$Its entire habitat is one pond, so losing it would remove the whole population.$mq$, $mq$hard$mq$),
($mq$A government wants to reduce fertiliser pollution. Which policy is most likely to help while keeping crop yields?$mq$, $mq$["Training farmers to apply fertiliser at the right time and amount","Banning all farming","Doubling fertiliser use","Planting crops along the river edge with no buffer"]$mq$, 0, $mq$Correct timing and amount reduces runoff while keeping the nutrients available to crops. Buffer strips between fields and rivers help too.$mq$, $mq$hard$mq$),
($mq$Hunters argue that limiting hunting will harm local jobs, while conservationists argue it protects the species long term. What is the best approach for a balanced evaluation?$mq$, $mq$["Accept the argument that is stated more loudly","Ignore economic data","Choose the argument from the older person","Compare evidence of population trends with the economic and social impacts on both groups"]$mq$, 3, $mq$A balanced evaluation uses evidence on both ecological and human impacts, and considers short-term and long-term effects.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Human Impact and Conservation$mq$ and p.name = $mq$Ecosystems and the Environment$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Biodiversity$mq$, $mq$The variety of living organisms in an area: species richness, genetic variety and habitat variety.$mq$),
($mq$Effects of deforestation$mq$, $mq$Habitat loss, lower biodiversity, less CO₂ absorbed, and CO₂ released when trees are burnt or decay.$mq$),
($mq$Enhanced greenhouse effect$mq$, $mq$Extra CO₂ and other greenhouse gases from human activity trap more thermal energy and warm the planet.$mq$),
($mq$Eutrophication$mq$, $mq$Fertiliser runoff causes an algal bloom. When the algae die, decomposers use up the oxygen and aquatic animals die.$mq$),
($mq$Indicator species$mq$, $mq$Species whose presence or absence shows environmental quality, such as lichens (clean air) and mayfly larvae (clean water).$mq$),
($mq$Captive breeding$mq$, $mq$Breeding endangered species in zoos or reserves to increase numbers, sometimes followed by reintroduction to the wild.$mq$),
($mq$Sustainable$mq$, $mq$Meeting current needs without reducing the ability of future generations to meet theirs.$mq$),
($mq$Fishing conservation measures$mq$, $mq$Catch quotas, larger net mesh sizes, closed seasons and marine protected areas.$mq$),
($mq$Percentage change$mq$, $mq$(New value − old value) ÷ old value × 100. Negative means a decrease.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Human Impact and Conservation$mq$ and p.name = $mq$Ecosystems and the Environment$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Human activities have changed almost every ecosystem on Earth. As the human population has grown, we have used more land, water, energy and other resources. Understanding our impact helps us make decisions that protect biodiversity and support sustainable development.

## Biodiversity
**Biodiversity** is the variety of living things in an area, including the number of different species (species richness), the genetic variety within each species and the variety of habitats. High biodiversity usually makes an ecosystem more stable, because there are more food sources and more species that can fill a role if another is lost.

## Main human impacts
- **Deforestation** clears forest for farming, timber, mining and building. It destroys habitats, reduces biodiversity, reduces the CO₂ taken up by photosynthesis and, when trees are burnt or decay, releases CO₂.
- **Burning fossil fuels** releases CO₂, which adds to the enhanced greenhouse effect and climate change. Rising temperatures can change where species can live.
- **Pollution**: fertiliser runoff causes eutrophication; plastic waste harms marine life; pesticides can build up through food chains by bioaccumulation; sulfur dioxide from burning fuel causes acid rain.
- **Overexploitation**: overfishing and hunting can reduce populations faster than they can breed.
- **Monoculture and urban growth** replace diverse habitats with few species.
- **Invasive species** introduced by people can outcompete native species or prey on them.

## Measuring impact
Percentage change is useful: a forest shrinks from 1 800 km² to 1 350 km². The loss is 450 km², so percentage loss = 450 ÷ 1 800 × 100 = 25%. **Indicator species** show the quality of an environment. Lichens are sensitive to air pollution, and mayfly larvae are found only in clean water. Comparing the number of species before and after a change also shows effects.

## Conservation methods
- **Protected areas** such as national parks and marine reserves limit damaging activities.
- **Captive breeding** and reintroduction increase numbers of endangered species.
- **Seed banks** store seeds to preserve plant diversity.
- **Quotas, mesh size limits and closed seasons** protect fish stocks.
- **Laws and agreements** control hunting and trade in endangered species.
- **Education and sustainable practices** such as recycling, renewable energy, sustainable forestry and reducing waste.

## Evaluating solutions
Many solutions have trade-offs. A reserve may protect a bird species but restrict local farmers, and tourism may bring money but also disturbance. When evaluating, compare evidence for ecological, economic and social effects, consider short-term and long-term outcomes, and say who gains and who loses. Avoid claims that one action will solve everything.

## How this is examined
Typical questions present a case study such as a wetland, a fishery or a rainforest, with data about populations or area over time. You may be asked to calculate percentage change, interpret a graph, link a cause to an effect and evaluate a proposed solution with evidence. Marks are given for balanced reasoning and for using data in your answer.

## Common mistakes
- Saying that a correlation proves a cause. Always suggest further evidence.
- Giving a solution without explaining how it works.
- Forgetting the social and economic side of conservation.

Exam tip: For evaluation questions give at least one advantage and one limitation, use a number from the data, and finish with a judgement that answers the question asked.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('integrated-science')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;