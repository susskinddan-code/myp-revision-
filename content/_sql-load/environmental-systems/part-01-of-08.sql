-- Part 1 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Ecosystems > Energy Flow and Food Webs
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Ecosystems$mq$, 5, 1 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Energy Flow and Food Webs$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Ecosystems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Energy Flow and Food Webs$mq$ and p.name = $mq$Ecosystems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the original source of energy for almost all ecosystems on Earth?$mq$, $mq$["The Sun","Decomposers","Soil minerals","Producers"]$mq$, 0, $mq$Sunlight provides the energy that producers capture by photosynthesis. Producers pass this energy on, but they are not the original source.$mq$, $mq$easy$mq$),
($mq$What is a producer in an ecosystem?$mq$, $mq$["An organism that eats plants","An organism that breaks down dead matter","An organism at the top of a food chain","An organism that makes its own food using light energy"]$mq$, 3, $mq$Producers, such as plants and algae, make their own food by photosynthesis. Organisms that eat plants are consumers.$mq$, $mq$easy$mq$),
($mq$Look at this food chain: grass → grasshopper → frog → snake. Which organism is the secondary consumer?$mq$, $mq$["Grasshopper","Snake","Frog","Grass"]$mq$, 2, $mq$The grasshopper eats the producer, so it is the primary consumer. The frog eats the primary consumer, so it is the secondary consumer.$mq$, $mq$easy$mq$),
($mq$In a food chain, what do the arrows show?$mq$, $mq$["Which organism is larger","The direction of energy transfer","Which organism is more numerous","The direction in which predators hunt"]$mq$, 1, $mq$Arrows point from the food to the feeder, showing the direction in which energy (in food) is transferred.$mq$, $mq$easy$mq$),
($mq$What is the main role of decomposers in an ecosystem?$mq$, $mq$["Release nutrients by breaking down dead organisms and waste","Make food by photosynthesis","Hunt herbivores","Absorb energy directly from the Sun"]$mq$, 0, $mq$Decomposers such as fungi and bacteria break down dead matter and waste, returning nutrients to the soil for producers to use.$mq$, $mq$easy$mq$),
($mq$A meadow's producers capture 20 000 kJ of energy. If 10% is transferred at each trophic level, how much reaches the primary consumers?$mq$, $mq$["200 kJ","10 000 kJ","18 000 kJ","2000 kJ"]$mq$, 3, $mq$10% of 20 000 kJ = 2000 kJ. The other 90% is lost as heat, in waste, or in parts that are not eaten.$mq$, $mq$medium$mq$),
($mq$Primary consumers in a lake receive 5000 kJ of energy. The secondary consumers receive 450 kJ. What is the percentage energy transfer between these two levels?$mq$, $mq$["0.9%","11%","9%","90%"]$mq$, 2, $mq$Transfer efficiency = 450 ÷ 5000 × 100 = 9%. Dividing the other way round (5000 ÷ 450) gives a ratio, not a percentage transfer.$mq$, $mq$medium$mq$),
($mq$Why are food chains rarely longer than four or five trophic levels?$mq$, $mq$["Large predators cannot find enough water","Too much energy is lost at each level, so little remains for the top","Producers cannot support more than four species","Decomposers stop working at higher levels"]$mq$, 1, $mq$Energy is lost at each transfer through respiration, heat, waste and uneaten parts. After a few levels there is too little energy left to support another one.$mq$, $mq$medium$mq$),
($mq$One oak tree supports 2000 caterpillars, which feed 20 small birds. Which statement describes the pyramid of numbers for this chain?$mq$, $mq$["It is not a normal pyramid, because one large producer supports many more consumers","It is a normal pyramid because the oak is largest","It is a normal pyramid because there are more birds than trees","It cannot be drawn because trees are not counted"]$mq$, 0, $mq$Counting individuals gives 1 tree, 2000 caterpillars and 20 birds, which is not pyramid shaped. Pyramids of energy never have this problem.$mq$, $mq$medium$mq$),
($mq$In a food web, hawks eat rabbits and snakes. Snakes eat mice. Rabbits and mice eat grass. A disease kills most of the rabbits. Which short-term effect is most likely?$mq$, $mq$["Grass decreases because rabbits no longer fertilise it","Hawks are unaffected because they only eat snakes","Mice decrease because hawks switch to hunting them","Hawks eat more snakes, so snake numbers fall and mice may increase"]$mq$, 3, $mq$With fewer rabbits, hawks eat more snakes. Fewer snakes means mice face less predation. In this web hawks do not eat mice directly.$mq$, $mq$medium$mq$),
($mq$A bear eats berries, fish and insects. What best describes its position in food webs?$mq$, $mq$["Only a primary consumer","Only a tertiary consumer","An omnivore feeding at more than one trophic level","A decomposer"]$mq$, 2, $mq$Berries make it a primary consumer, while fish and insects make it a secondary or higher consumer. Omnivores occupy several trophic levels.$mq$, $mq$medium$mq$),
($mq$Why is a pyramid of energy always wider at the bottom, even when a pyramid of numbers is not?$mq$, $mq$["Because producers are always the most numerous","Because energy is lost at every transfer and cannot be recycled","Because decomposers add energy at the top","Because biomass is lost when animals die"]$mq$, 1, $mq$Energy flows one way and some is lost as heat at each level. This means less energy is available at each higher level, whatever the number or size of the organisms.$mq$, $mq$medium$mq$),
($mq$A field of crops stores 100 000 kJ. People can eat the crops directly (10% reaches them), or feed them to cattle (10% reaches the cattle) and then eat the cattle (10% reaches people). How much more energy reaches people through the first route?$mq$, $mq$["10 times more","5 times more","100 times more","2 times more"]$mq$, 0, $mq$Directly: 10 000 kJ. Via cattle: 100 000 × 0.1 × 0.1 = 1000 kJ. 10 000 ÷ 1000 = 10 times more.$mq$, $mq$medium$mq$),
($mq$Energy data for a grassland in kJ per m² per year: producers 8000, herbivores 900, carnivores 85. What is the energy transfer efficiency from herbivores to carnivores?$mq$, $mq$["10.6%","94%","11.3%","9.4%"]$mq$, 3, $mq$85 ÷ 900 × 100 = 9.4%. The producer to herbivore efficiency is 900 ÷ 8000 = 11.25%, so do not mix up the levels.$mq$, $mq$hard$mq$),
($mq$A pesticide that does not break down is sprayed on a farm. Years later, its concentration is highest in hawks at the top of the food chain. Which explanation is best?$mq$, $mq$["Hawks drink more contaminated water than other animals","The pesticide gets stronger the longer it stays in the soil","The pesticide is stored in tissues and not excreted, so predators gain the amounts from all the prey they eat","Hawks absorb the pesticide directly through their feathers"]$mq$, 2, $mq$Persistent chemicals build up in body tissues. Each predator eats many contaminated prey, so concentration increases at each trophic level (biomagnification).$mq$, $mq$hard$mq$),
($mq$A student uses the 10% rule to predict energy at each trophic level for several ecosystems. What is the main limitation of this model?$mq$, $mq$["Energy is gained rather than lost at each level","The real transfer varies between organisms and ecosystems, so 10% is only an average estimate","It only works in water ecosystems","It ignores the Sun completely"]$mq$, 1, $mq$Actual transfer depends on factors such as how digestible the food is and whether the consumer is warm or cold blooded. The rule gives an approximation, not an exact value.$mq$, $mq$hard$mq$),
($mq$In a wetland, producers capture 12 000 kJ per m² per year (gross primary productivity) and use 4500 kJ in respiration. What is the net primary productivity?$mq$, $mq$["7500 kJ per m² per year","16 500 kJ per m² per year","4500 kJ per m² per year","2.7 kJ per m² per year"]$mq$, 0, $mq$Net primary productivity = gross productivity − respiration = 12 000 − 4500 = 7500 kJ per m² per year. This is the energy available to consumers.$mq$, $mq$hard$mq$),
($mq$Producers in a lake capture 1 000 000 kJ. Assuming 10% transfer at each level, how much energy is available to the fifth trophic level (producers are level 1)?$mq$, $mq$["1000 kJ","10 kJ","10 000 kJ","100 kJ"]$mq$, 3, $mq$Level 2 receives 100 000 kJ, level 3 10 000 kJ, level 4 1000 kJ and level 5 100 kJ. Each step is a multiplication by 0.1, and there are four steps.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Energy Flow and Food Webs$mq$ and p.name = $mq$Ecosystems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Producer$mq$, $mq$An organism that makes its own food, usually by photosynthesis, using energy from sunlight (for example plants and algae).$mq$),
($mq$Trophic level$mq$, $mq$The feeding position of an organism in a food chain: producer, primary consumer, secondary consumer and so on.$mq$),
($mq$What do arrows in a food chain show?$mq$, $mq$The direction of energy transfer, pointing from the food to the organism that eats it.$mq$),
($mq$The 10% rule$mq$, $mq$On average, about 10% of the energy at one trophic level is passed to the next. The rest is lost as heat, waste and uneaten parts.$mq$),
($mq$Why are food chains short?$mq$, $mq$Energy is lost at each transfer, so after four or five levels too little remains to support another level.$mq$),
($mq$Formula for transfer efficiency$mq$, $mq$Energy in the higher level ÷ energy in the lower level × 100.$mq$),
($mq$Net primary productivity$mq$, $mq$Gross primary productivity minus the energy producers use in respiration. It is the energy available to consumers.$mq$),
($mq$Decomposers$mq$, $mq$Fungi and bacteria that break down dead organisms and waste, returning nutrients to the soil.$mq$),
($mq$Food web vs food chain$mq$, $mq$A food chain shows one feeding path. A food web shows many linked chains and is a more realistic picture of feeding relationships.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Energy Flow and Food Webs$mq$ and p.name = $mq$Ecosystems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Energy flow in ecosystems
An ecosystem is a community of living organisms interacting with each other and with the non-living (abiotic) environment. The key idea in this sub-topic is that energy flows through an ecosystem in one direction, while nutrients are recycled.

Almost all energy enters ecosystems as sunlight. **Producers** (plants, algae and some bacteria) capture it by photosynthesis and store it in chemical form in glucose and other molecules. **Consumers** get their energy by eating other organisms:
- **Primary consumers** eat producers (herbivores).
- **Secondary consumers** eat primary consumers.
- **Tertiary consumers** eat secondary consumers.
- **Decomposers** (fungi and bacteria) break down dead organisms and waste, returning nutrients to the soil.

Each feeding level is a **trophic level**. A **food chain** shows one feeding path, for example grass → grasshopper → frog → snake. The arrows show the direction of energy transfer, so they point towards the feeder. A **food web** joins many chains together and is more realistic, because most animals eat several kinds of food. Many animals are omnivores and occupy more than one trophic level.

## Why energy is lost
Only about 10% of the energy at one trophic level reaches the next. This is called the **10% rule**, and it is an average, not an exact law. The rest is lost because:
- Organisms use energy for respiration (movement, keeping warm, growth). This energy is released as heat.
- Some parts are not eaten, such as bones, roots or shells.
- Some food is not digested and leaves the body as waste.

Because energy is lost at each step, food chains usually have only four or five trophic levels. It also explains why there are fewer large predators than herbivores. Energy cannot be recycled, so ecosystems need a constant input of sunlight.

## Ecological pyramids
- A **pyramid of numbers** shows how many organisms are at each level. It can be a strange shape (one tree supporting thousands of insects).
- A **pyramid of biomass** shows the dry mass at each level.
- A **pyramid of energy** shows energy per area per year and is always pyramid shaped.

## Worked example
Producers capture 50 000 kJ per m² per year. Using the 10% rule, primary consumers receive 5000 kJ and secondary consumers 500 kJ. To find transfer efficiency, use: energy in the higher level ÷ energy in the lower level × 100. If secondary consumers actually get 450 kJ from 5000 kJ, efficiency = 450 ÷ 5000 × 100 = 9%.

Net primary productivity (NPP) is the energy left for consumers after producers use some for respiration: NPP = gross primary productivity − respiration.

## Eating lower on the food chain
People who eat crops directly receive about ten times more of the energy than if the same crops are fed to animals first. This is why land used for growing grain can often feed more people than land used for livestock.

## Common mistakes
- Drawing arrows from predator to prey. Arrows follow the energy.
- Saying energy is "used up". Energy is lost as heat, but it is not destroyed.
- Thinking energy is recycled. Nutrients cycle, energy does not.

## How this is examined
Questions usually give a food web or energy data from a real-looking ecosystem. You may be asked to identify trophic levels, calculate percentage transfer, explain energy loss, predict what happens when one species is removed, and evaluate the limits of the 10% model.

Exam tip: when asked to predict what happens if a species is removed, trace the effect on both its predators and its prey, and use words such as increase, decrease and because.$mq$ from st;

-- Ecosystems > Nutrient Cycles
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Ecosystems$mq$, 5, 1 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Nutrient Cycles$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Ecosystems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Nutrient Cycles$mq$ and p.name = $mq$Ecosystems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which process removes carbon dioxide from the atmosphere and stores carbon in plants?$mq$, $mq$["Photosynthesis","Respiration","Combustion","Decomposition"]$mq$, 0, $mq$Plants use carbon dioxide in photosynthesis to build glucose. Respiration, combustion and decomposition all release carbon dioxide.$mq$, $mq$easy$mq$),
($mq$Which process returns carbon dioxide to the atmosphere from living organisms?$mq$, $mq$["Photosynthesis","Fixation","Condensation","Respiration"]$mq$, 3, $mq$All living organisms release carbon dioxide through respiration. Photosynthesis takes it in.$mq$, $mq$easy$mq$),
($mq$Where are nitrogen-fixing bacteria found in legumes such as peas and clover?$mq$, $mq$["In the leaves","In the seeds only","In root nodules","In the flowers"]$mq$, 2, $mq$These bacteria live in nodules on the roots and convert nitrogen gas into compounds the plant can use. The plant gives them sugars in return.$mq$, $mq$easy$mq$),
($mq$When fossil fuels are burned, what happens to carbon in the carbon cycle?$mq$, $mq$["It is destroyed","It moves from long-term storage underground into the atmosphere as carbon dioxide","It moves from the atmosphere into the oceans only","It is turned into nitrogen"]$mq$, 1, $mq$Fossil fuels are a store of carbon built up over millions of years. Burning them releases that carbon into the atmosphere much faster than natural processes can remove it.$mq$, $mq$easy$mq$),
($mq$What is the role of decomposers in nutrient cycles?$mq$, $mq$["They break down dead organisms and waste, returning nutrients to the soil","They fix nitrogen from the air only","They make nutrients by photosynthesis","They remove all nutrients from ecosystems"]$mq$, 0, $mq$Decomposers release nutrients locked in dead matter so that producers can take them up again.$mq$, $mq$easy$mq$),
($mq$About 78% of the atmosphere is nitrogen gas, yet plants often lack nitrogen. Why?$mq$, $mq$["Plants can absorb nitrogen gas, but only at night","Nitrogen gas is very rare near the ground","Nitrogen gas is poisonous to plants","Plants cannot use nitrogen gas directly and need it converted into nitrates or ammonium"]$mq$, 3, $mq$The nitrogen molecule N₂ is very stable. Bacteria, lightning or industrial processes must convert it into forms like nitrate that plants can absorb.$mq$, $mq$medium$mq$),
($mq$In the nitrogen cycle, what is the correct order of nitrification?$mq$, $mq$["Nitrate → nitrite → ammonium","Nitrogen gas → nitrate → ammonium","Ammonium → nitrite → nitrate","Nitrate → nitrogen gas → nitrite"]$mq$, 2, $mq$Nitrifying bacteria oxidise ammonium to nitrite, then nitrite to nitrate. Nitrate is the form most easily taken up by plants.$mq$, $mq$medium$mq$),
($mq$What does denitrification do in the nitrogen cycle?$mq$, $mq$["Turns nitrogen gas into nitrates","Turns nitrates back into nitrogen gas, removing nitrogen from the soil","Turns ammonia into proteins","Absorbs nitrates into roots"]$mq$, 1, $mq$Denitrifying bacteria, often in waterlogged soil with little oxygen, convert nitrates to nitrogen gas, which escapes to the air.$mq$, $mq$medium$mq$),
($mq$Large areas of forest are cleared and burned. What is the most direct effect on the carbon cycle?$mq$, $mq$["Carbon stored in trees is released as carbon dioxide, and less is removed by photosynthesis","Carbon dioxide levels fall because fires use up gas","Carbon is removed from the cycle permanently","The ocean releases more oxygen"]$mq$, 0, $mq$Burning releases stored carbon quickly, and fewer trees mean less photosynthesis to take carbon dioxide back out of the air.$mq$, $mq$medium$mq$),
($mq$Each year, human activity emits 10 gigatonnes of carbon (GtC). The oceans absorb 2.5 GtC and land plants absorb a net 3.0 GtC. How much carbon is added to the atmosphere each year?$mq$, $mq$["5.5 GtC","7.5 GtC","15.5 GtC","4.5 GtC"]$mq$, 3, $mq$10 − 2.5 − 3.0 = 4.5 GtC. Only the part not absorbed by sinks builds up in the atmosphere.$mq$, $mq$medium$mq$),
($mq$Why does a field that is often flooded tend to lose nitrogen from its soil?$mq$, $mq$["Nitrogen-fixing bacteria grow too fast in water","Plants release nitrogen when they are wet","Denitrifying bacteria thrive in low-oxygen waterlogged soil and convert nitrate to nitrogen gas","Rainwater contains no nitrogen compounds"]$mq$, 2, $mq$Waterlogged soil has little oxygen, which favours denitrifying bacteria. They turn nitrates into nitrogen gas that escapes.$mq$, $mq$medium$mq$),
($mq$How is the phosphorus cycle different from the carbon and nitrogen cycles?$mq$, $mq$["It does not involve living organisms","It has no major gas stage, so phosphorus is mainly released from rocks by weathering","It happens only in the oceans","It is much faster than other cycles"]$mq$, 1, $mq$Phosphorus does not form a common atmospheric gas. It enters ecosystems mainly as phosphate released slowly from rock by weathering, then moves through food chains and waste.$mq$, $mq$medium$mq$),
($mq$Coal, oil and natural gas formed from the remains of organisms over millions of years. Why is burning them said to upset the carbon cycle?$mq$, $mq$["It moves carbon from a very slow store into the atmosphere far faster than it can be taken back","Fossil fuels contain no carbon","It destroys carbon atoms","It makes plants stop respiring"]$mq$, 0, $mq$The carbon was locked away for millions of years. Releasing it within decades adds to the atmosphere faster than natural sinks can absorb it.$mq$, $mq$medium$mq$),
($mq$A farmer harvests wheat every year and removes it from the field. After several years the soil is less fertile. What is the best explanation?$mq$, $mq$["Wheat adds acids to the soil","Rain adds too much nitrogen","Decomposers increase and eat the nutrients","Nutrients taken up by the crop are removed and not returned by decomposition"]$mq$, 3, $mq$In a natural system dead plants decompose and return nutrients. When the crop is removed, nutrients leave with it, so fertiliser or crop rotation is needed.$mq$, $mq$hard$mq$),
($mq$A sealed bottle contains pond water, plants and snails. It is kept in a dark cupboard for three weeks. Which prediction is best?$mq$, $mq$["Carbon dioxide stays the same because the bottle is sealed","Oxygen increases because the plants are resting","Carbon dioxide rises and oxygen falls because respiration continues but photosynthesis stops","Nitrogen turns into carbon dioxide"]$mq$, 2, $mq$Without light there is no photosynthesis, but all organisms still respire, using oxygen and releasing carbon dioxide.$mq$, $mq$hard$mq$),
($mq$The atmosphere holds about 850 GtC and increases by 4.5 GtC in a year. What is the approximate percentage increase?$mq$, $mq$["5.3%","0.53%","19%","0.019%"]$mq$, 1, $mq$4.5 ÷ 850 × 100 = 0.53%. A small percentage each year adds up to a large change over decades.$mq$, $mq$hard$mq$),
($mq$A soil test finds low nitrate but high ammonium in a compacted, waterlogged field. Which is the most likely reason?$mq$, $mq$["Nitrifying bacteria need oxygen and are inactive in the waterlogged soil","Too many nitrogen-fixing plants are growing","The soil has been heavily limed","Plants have absorbed all the ammonium"]$mq$, 0, $mq$Nitrification needs oxygen. In compacted, waterlogged soil it slows down, so ammonium builds up and little nitrate is formed.$mq$, $mq$hard$mq$),
($mq$A farmer wants to restore nitrogen to a depleted field without adding much manufactured fertiliser. Which plan is best justified?$mq$, $mq$["Burn the stubble after each harvest","Drain the field to remove all water","Plant the same cereal every year","Plant clover for a season and plough it in before the next crop"]$mq$, 3, $mq$Clover is a legume with nitrogen-fixing bacteria in its roots. Ploughing it in adds nitrogen compounds to the soil as it decomposes.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Nutrient Cycles$mq$ and p.name = $mq$Ecosystems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Nitrogen fixation$mq$, $mq$The conversion of nitrogen gas into usable compounds: ammonia or ammonium by bacteria (in soil or legume root nodules), and nitrates by lightning.$mq$),
($mq$Nitrification$mq$, $mq$Bacteria convert ammonium to nitrite and then to nitrate. It needs oxygen. Nitrate is the main form plants absorb.$mq$),
($mq$Denitrification$mq$, $mq$Bacteria in waterlogged, low-oxygen soil convert nitrates back into nitrogen gas, which returns to the atmosphere.$mq$),
($mq$Which processes release carbon dioxide?$mq$, $mq$Respiration, decomposition and combustion (burning wood or fossil fuels).$mq$),
($mq$Which process removes carbon dioxide from the air?$mq$, $mq$Photosynthesis. The oceans also absorb carbon dioxide by dissolving it.$mq$),
($mq$Why plant legumes in crop rotation?$mq$, $mq$Their root nodule bacteria fix nitrogen, so the soil gains nitrogen compounds and less fertiliser is needed.$mq$),
($mq$Store (sink) in a nutrient cycle$mq$, $mq$A place where an element is held, such as the atmosphere, oceans, soil, living things or fossil fuels.$mq$),
($mq$Why does the phosphorus cycle differ?$mq$, $mq$It has no major gas stage. Phosphate is released from rock by weathering and cycles slowly through soil, organisms and sediments.$mq$),
($mq$Why is burning fossil fuels a problem for the carbon cycle?$mq$, $mq$It moves carbon from a store that took millions of years to form into the atmosphere within decades, faster than sinks can absorb it.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Nutrient Cycles$mq$ and p.name = $mq$Ecosystems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Cycling matter
Energy flows through ecosystems in one direction, but matter is recycled. The atoms that make up your body have been part of other organisms before. Nutrient cycles describe how elements such as carbon, nitrogen and phosphorus move between **stores** (also called reservoirs or sinks, such as the atmosphere, soil, oceans and living organisms) through **flows** (processes such as photosynthesis and decomposition).

## The carbon cycle
Carbon is the basis of all organic molecules. Key processes:
- **Photosynthesis** removes carbon dioxide from the air and builds it into glucose in producers.
- **Feeding** passes carbon compounds along food chains.
- **Respiration** releases carbon dioxide from all organisms.
- **Decomposition** returns carbon dioxide to the air as decomposers respire.
- **Combustion** of wood and fossil fuels releases carbon dioxide quickly.
- **Dissolving** moves carbon dioxide into the oceans, where it is used by algae and shell-forming organisms.

Fossil fuels (coal, oil and gas) form from the remains of organisms over millions of years. Burning them moves carbon from a slow-moving store to the atmosphere in decades. Deforestation also adds carbon dioxide and removes trees that would absorb it. This is why atmospheric carbon dioxide is rising.

Worked example: human activity emits 10 gigatonnes of carbon (GtC) each year. Oceans absorb 2.5 GtC and land absorbs 3.0 GtC. Atmospheric increase = 10 − 2.5 − 3.0 = 4.5 GtC per year.

## The nitrogen cycle
About 78% of air is nitrogen gas (N₂), but most organisms cannot use it directly. Bacteria do the key steps:
- **Nitrogen fixation**: bacteria in soil or in root nodules of legumes (peas, beans, clover) convert N₂ into ammonia/ammonium. Lightning also fixes small amounts.
- **Nitrification**: ammonium → nitrite → nitrate by nitrifying bacteria. This needs oxygen.
- **Assimilation**: plants absorb nitrates and build proteins; animals get nitrogen by eating.
- **Ammonification**: decomposers break down dead matter and waste into ammonium.
- **Denitrification**: bacteria in waterlogged, low-oxygen soil turn nitrate back into nitrogen gas.

Farmers add fertiliser or use crop rotation with legumes because harvesting removes nitrogen from the field. Too much fertiliser can wash into rivers and cause pollution.

## The phosphorus cycle
Phosphorus has no important gas stage. It is released from rocks by weathering as phosphate, taken up by plants, passed through food chains and returned by decomposition. The cycle is slow, and some phosphate ends up in sediments.

## Common mistakes
- Mixing up nitrogen fixation (gas to compounds) and denitrification (compounds to gas).
- Saying plants take in nitrogen from the air.
- Forgetting that decomposers are essential in every cycle.
- Saying carbon dioxide is "made" or "destroyed". Atoms are moved, not created or destroyed.

## How this is examined
Questions often show a cycle diagram described in words or a table of carbon flows. You may be asked to name a process, calculate a net change in a store, explain why a farming practice changes soil nitrogen, or predict the effect of deforestation or flooding on a cycle.

Exam tip: for a cycle question, name the process, say which store the matter moves from and to, and say which organisms or conditions are involved.$mq$ from st;

-- Ecosystems > Interactions and Succession
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Ecosystems$mq$, 5, 1 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Interactions and Succession$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Ecosystems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Interactions and Succession$mq$ and p.name = $mq$Ecosystems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which term describes a relationship in which both species benefit?$mq$, $mq$["Mutualism","Parasitism","Predation","Competition"]$mq$, 0, $mq$In mutualism both partners benefit, for example bees pollinating flowers while feeding on nectar.$mq$, $mq$easy$mq$),
($mq$A tapeworm lives in the intestine of a dog and absorbs digested food, harming the dog. This is an example of which interaction?$mq$, $mq$["Mutualism","Commensalism","Predation","Parasitism"]$mq$, 3, $mq$A parasite lives on or in a host and benefits at the host's expense.$mq$, $mq$easy$mq$),
($mq$Lichens are often the first organisms to colonise bare rock. What are such first colonisers called?$mq$, $mq$["Climax species","Keystone species","Pioneer species","Indicator species"]$mq$, 2, $mq$Pioneer species are the first to colonise a new or disturbed area and start to build soil for later species.$mq$, $mq$easy$mq$),
($mq$Two plant species in a meadow both need the same limited supply of water and light. What interaction is this?$mq$, $mq$["Mutualism","Competition","Parasitism","Commensalism"]$mq$, 1, $mq$Competition occurs when organisms use the same limited resource, and each is negatively affected.$mq$, $mq$easy$mq$),
($mq$Where does primary succession begin?$mq$, $mq$["On bare rock or new land with no soil","On a field after a crop is harvested","In a forest after a small fire","On a lawn after mowing"]$mq$, 0, $mq$Primary succession starts where there is no soil, such as new volcanic rock or ground exposed by a retreating glacier.$mq$, $mq$easy$mq$),
($mq$A forest fire burns the trees but leaves the soil and seeds intact. New plants soon grow. What is this process called?$mq$, $mq$["Primary succession","Eutrophication","Biomagnification","Secondary succession"]$mq$, 3, $mq$Secondary succession occurs when an existing community is disturbed but soil remains. It is faster than primary succession.$mq$, $mq$medium$mq$),
($mq$On a graph of a predator and its prey over many years, the predator peaks a little after the prey peaks. What is the best explanation?$mq$, $mq$["Predators are always slower","Prey numbers cannot be affected by predators","Predator numbers rise only after there is plenty of prey, and then fall when prey declines","Predators and prey have no relationship"]$mq$, 2, $mq$Prey increase gives predators more food, so their numbers rise with a delay. More predators then reduce the prey, so prey fall and predators follow.$mq$, $mq$medium$mq$),
($mq$Clownfish live among sea anemone tentacles, gaining protection, while they clean the anemone and may attract food. Which interaction is this?$mq$, $mq$["Parasitism","Mutualism","Predation","Competition"]$mq$, 1, $mq$Both species gain an advantage, so it is mutualism.$mq$, $mq$medium$mq$),
($mq$Barnacles attach to the skin of a whale. The barnacles gain a place to live and food-rich water while the whale is not noticeably affected. What is this interaction?$mq$, $mq$["Commensalism","Mutualism","Parasitism","Competition"]$mq$, 0, $mq$In commensalism one species benefits and the other is neither helped nor harmed.$mq$, $mq$medium$mq$),
($mq$Two species of similar beetles are placed in the same container with the same food. Over time, one species disappears. Which idea does this support?$mq$, $mq$["Beetles never compete","The remaining species is a parasite","Mutualism always replaces competition","Species with the same niche cannot easily coexist, so one is outcompeted"]$mq$, 3, $mq$If two species need exactly the same resources, the one that uses them better tends to outcompete the other. This is competitive exclusion.$mq$, $mq$medium$mq$),
($mq$Which is an example of interspecific competition?$mq$, $mq$["Two male deer fighting over a territory","Seedlings of one oak tree competing for light","Lions and hyenas competing for the same prey","Two rabbits sharing a burrow"]$mq$, 2, $mq$Interspecific competition is between different species. The other examples involve competition within a species (intraspecific).$mq$, $mq$medium$mq$),
($mq$As succession progresses from bare ground towards a mature forest, which change is most likely?$mq$, $mq$["Soil gets thinner and species richness falls","Soil becomes deeper and more species are found","Light at ground level increases","Energy flow stops"]$mq$, 1, $mq$Pioneer species build soil with their remains, allowing larger plants to grow. Biodiversity and biomass usually increase over time.$mq$, $mq$medium$mq$),
($mq$Sea otters eat sea urchins, which graze on kelp. After otters are removed from a coast, urchins increase and the kelp forest disappears. What type of species are otters here?$mq$, $mq$["Keystone species","Pioneer species","Parasites","Decomposers"]$mq$, 0, $mq$A keystone species has a much larger effect on its ecosystem than its numbers suggest. Removing it changes the whole community.$mq$, $mq$medium$mq$),
($mq$Lynx and hare populations in a northern forest show repeating cycles. Hare numbers peak, then lynx numbers peak about a year later. A student states that lynx cause hare numbers to rise. Which comment is most accurate?$mq$, $mq$["The student is correct because both peaks occur together","The student is wrong because hares do not affect lynx","The graph cannot be used to show any relationship","The graph shows that hare numbers help lynx numbers to rise, and lynx predation reduces hares, so the claim is reversed"]$mq$, 3, $mq$More hares provide more food, so lynx numbers rise afterwards. Predation then pulls hare numbers down. The cause is in the opposite direction to the student's claim.$mq$, $mq$hard$mq$),
($mq$Species A and species B each grown alone give a mean dry mass of 12 g per plant. Grown together, A has a mean mass of 10 g and B 3 g. What is the percentage reduction in mass for B, and what does it suggest?$mq$, $mq$["25%, B is the stronger competitor","75%, B is the stronger competitor","75%, B is the weaker competitor","9%, the species do not compete"]$mq$, 2, $mq$(12 − 3) ÷ 12 × 100 = 75%. A lost only about 17%, so B is much more affected by competition.$mq$, $mq$hard$mq$),
($mq$A mature forest has remained roughly the same for centuries but is not completely unchanging. Which statement best explains why the climax community is called stable?$mq$, $mq$["Its species numbers never change at all","It stays similar in overall structure and species while small changes happen, until a disturbance resets it","It is not affected by any disturbance","It has stopped exchanging energy"]$mq$, 1, $mq$A climax community is relatively stable under the local climate, but storms, fires or disease can still disturb it and restart succession.$mq$, $mq$hard$mq$),
($mq$Why are lichens and mosses effective pioneers on bare rock, while trees are not?$mq$, $mq$["Lichens tolerate harsh conditions with no soil and help break down rock, creating the first thin soil","Trees cannot photosynthesise in light","Lichens need deep soil to grow","Mosses are the largest plants and shade out others"]$mq$, 0, $mq$Pioneers survive without soil and with little water. Their activity and remains create thin soil that later species such as grasses and shrubs can use.$mq$, $mq$hard$mq$),
($mq$A non-native rabbit species is introduced to an island and eats the native shrubs. Native birds that nest in the shrubs decline. What is the strongest conclusion?$mq$, $mq$["The rabbits are competing with the birds for food only","The birds must be parasites of the rabbits","The shrubs will increase because of grazing","Introduced species can affect other species indirectly by changing the habitat"]$mq$, 3, $mq$The rabbits do not eat the birds, but removing shrubs destroys nesting sites. This is an indirect effect of a non-native species on a food web.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Interactions and Succession$mq$ and p.name = $mq$Ecosystems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Mutualism$mq$, $mq$An interaction in which both species benefit, for example bees pollinating flowers while feeding on nectar.$mq$),
($mq$Parasitism$mq$, $mq$An interaction in which the parasite benefits and the host is harmed, for example a tapeworm in a dog.$mq$),
($mq$Commensalism$mq$, $mq$One species benefits and the other is neither helped nor harmed, for example barnacles on a whale.$mq$),
($mq$Niche$mq$, $mq$The role of a species in an ecosystem, including what it eats, where it lives and when it is active.$mq$),
($mq$Keystone species$mq$, $mq$A species that has a much bigger effect on its ecosystem than its numbers suggest, such as sea otters protecting kelp forests.$mq$),
($mq$Primary vs secondary succession$mq$, $mq$Primary starts on bare rock with no soil. Secondary follows a disturbance when soil is already present, so it is faster.$mq$),
($mq$Pioneer species$mq$, $mq$The first species to colonise a new or bare area, such as lichens. They help to form soil for later species.$mq$),
($mq$Climax community$mq$, $mq$The relatively stable final stage of succession in a given climate, with high biodiversity, until a disturbance resets it.$mq$),
($mq$Predator and prey graph pattern$mq$, $mq$Both populations cycle. The predator peak follows the prey peak with a delay, because predators increase only after prey are plentiful.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Interactions and Succession$mq$ and p.name = $mq$Ecosystems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Interactions between organisms
Organisms in an ecosystem do not live in isolation. They interact with each other, and the type of interaction depends on who gains and who loses. The main types are:
- **Predation**: a predator kills and eats prey (a lion and a zebra).
- **Competition**: organisms use the same limited resource, such as light, water, food or space. **Intraspecific** competition is within a species. **Interspecific** competition is between different species.
- **Mutualism**: both species benefit (bees and flowers, or nitrogen-fixing bacteria and legumes).
- **Parasitism**: the parasite benefits and the host is harmed (a tapeworm in a dog, a tick on a deer).
- **Commensalism**: one species benefits and the other is not affected (barnacles on a whale).

## Niche and competition
A **niche** is the role of a species in its ecosystem: what it eats, where it lives and when it is active. When two species have almost identical niches, one often outcompetes the other. This is called **competitive exclusion**. Species can survive together if they use resources a little differently, for example by feeding at different heights in a tree.

## Predator and prey cycles
Predator and prey numbers often rise and fall in repeating cycles. When prey are abundant, predators have more food and increase. More predators eat more prey, so prey decrease. Then the predators starve and decrease. The predator peak comes slightly after the prey peak. When you describe a graph, mention the delay and use the words "because" and "so".

## Keystone and invasive species
A **keystone species** has a large effect on its community compared with its numbers. Sea otters keep sea urchins in check, which protects kelp forests. An **invasive species** is a non-native species that spreads and harms native species, for example by competing with them or eating them. Invasive species often lack natural predators in their new habitat.

## Ecological succession
**Succession** is the gradual change in the species of a community over time.
- **Primary succession** starts on bare rock or new land without soil. Pioneer species (lichens, mosses) break down rock and add dead matter, forming thin soil. Grasses, shrubs and finally trees follow.
- **Secondary succession** happens after a disturbance such as a fire or farming stops, when soil is already present. It is much faster.

As succession proceeds, soil deepens, biomass and the number of species usually increase, and food webs become more complex. The final relatively stable stage is the **climax community**, which depends on the local climate and soil. Disturbances such as storms or fires can reset the process.

## Worked example
In a pot experiment, a plant grown alone has a mean mass of 12 g. When grown with another species its mass is 3 g. Percentage reduction = (12 − 3) ÷ 12 × 100 = 75%. A large reduction suggests it is the weaker competitor for light, water or nutrients.

## Common mistakes
- Confusing commensalism and mutualism (check whether both benefit).
- Saying a climax community never changes.
- Describing a predator-prey graph without the time delay.
- Confusing primary succession (no soil) with secondary succession (soil present).

## How this is examined
Questions often give a graph of two populations, a table of plant growth with and without competitors, or a description of a landscape after a disturbance. You may be asked to identify the interaction, interpret trends, predict the next stage of succession and evaluate whether a conclusion is justified by the data.

Exam tip: when given an experiment on competition, mention the control (species grown alone), compare the same measurement with and without the other species, and give a percentage change.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('environmental-systems')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;