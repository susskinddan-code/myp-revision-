-- Part 4 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Pollution > Air Pollution and Smog
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Pollution$mq$, 5, 4 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Air Pollution and Smog$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Pollution$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Air Pollution and Smog$mq$ and p.name = $mq$Pollution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which of these is a primary air pollutant?$mq$, $mq$["Sulfur dioxide from burning coal","Ground-level ozone","Peroxyacetyl nitrate (PAN)","Sulfuric acid in rain"]$mq$, 0, $mq$A primary pollutant is released directly. Ozone, PAN and acids in rain form later by chemical reactions, so they are secondary pollutants.$mq$, $mq$easy$mq$),
($mq$What is the main source of nitrogen oxides in city air?$mq$, $mq$["Volcanoes","Plants and trees","Sea spray","Vehicle engines, where nitrogen and oxygen react at high temperature"]$mq$, 3, $mq$In hot engines, nitrogen and oxygen from the air react to form nitrogen oxides, which are released in exhaust gases.$mq$, $mq$easy$mq$),
($mq$Which condition is needed for photochemical smog to form?$mq$, $mq$["Heavy snow","Strong winds","Sunlight","Complete darkness"]$mq$, 2, $mq$Sunlight drives the reactions between nitrogen oxides and volatile organic compounds that form ozone and other irritants.$mq$, $mq$easy$mq$),
($mq$Which gases mainly cause acid rain?$mq$, $mq$["Oxygen and nitrogen","Sulfur dioxide and nitrogen oxides","Carbon monoxide and helium","Methane and argon"]$mq$, 1, $mq$These gases dissolve in cloud water to form sulfuric and nitric acids, which fall as acid rain.$mq$, $mq$easy$mq$),
($mq$What does a catalytic converter in a car's exhaust do?$mq$, $mq$["Converts harmful gases such as carbon monoxide and nitrogen oxides into less harmful gases","Increases the amount of fuel burned","Removes all carbon dioxide","Makes the engine louder"]$mq$, 0, $mq$A catalytic converter helps reactions that turn carbon monoxide into carbon dioxide and nitrogen oxides into nitrogen. It does not remove carbon dioxide.$mq$, $mq$easy$mq$),
($mq$The pH scale is logarithmic. A lake falls from pH 6 to pH 4 because of acid rain. How many times more acidic is it?$mq$, $mq$["2 times","10 times","1000 times","100 times"]$mq$, 3, $mq$Each pH unit is a factor of 10. A drop of two units is 10 × 10 = 100 times more acidic.$mq$, $mq$medium$mq$),
($mq$In a temperature inversion, a layer of warm air sits above cooler air near the ground. Why does this make air pollution worse?$mq$, $mq$["It increases wind speed","It washes pollutants away with rain","It traps pollutants near the ground, preventing them from rising and dispersing","It removes sunlight"]$mq$, 2, $mq$Normally warm air near the surface rises and carries pollutants up. In an inversion the cooler air is trapped below the warm layer, so pollutants accumulate.$mq$, $mq$medium$mq$),
($mq$A city's average PM2.5 particle concentration falls from 35 to 21 micrograms per m³ after new rules. What is the percentage reduction?$mq$, $mq$["14%","40%","60%","67%"]$mq$, 1, $mq$The decrease is 14. 14 ÷ 35 × 100 = 40%. Dividing by 21 would be wrong, because the original value is the base.$mq$, $mq$medium$mq$),
($mq$Ground-level ozone forms when nitrogen oxides and volatile organic compounds react in sunlight. What type of pollutant is it?$mq$, $mq$["A secondary pollutant","A primary pollutant","A natural gas only","A biodegradable pollutant"]$mq$, 0, $mq$Secondary pollutants are formed in the atmosphere from reactions of primary pollutants, rather than emitted directly.$mq$, $mq$medium$mq$),
($mq$A coal power station fits flue-gas desulfurisation, in which the exhaust is passed through a wet limestone mixture. Which pollutant does this mainly reduce?$mq$, $mq$["Carbon monoxide","Ozone","Noise","Sulfur dioxide"]$mq$, 3, $mq$The limestone mixture reacts with sulfur dioxide and traps it as a solid, reducing acid rain. It does not stop carbon dioxide emissions.$mq$, $mq$medium$mq$),
($mq$Why are very fine particulates (PM2.5) considered especially harmful to health?$mq$, $mq$["They are heavy and fall to the ground at once","They only affect plants","They can travel deep into the lungs and even enter the bloodstream","They make air cooler"]$mq$, 2, $mq$Particles smaller than 2.5 micrometres bypass the body's defences in the nose and throat and can damage lungs and circulation.$mq$, $mq$medium$mq$),
($mq$Why is photochemical smog most severe in warm, sunny cities with many vehicles?$mq$, $mq$["Cold air produces more ozone","Heavy traffic provides the pollutants and strong sunlight provides the energy for the reactions","Rain makes the pollutants stronger","Vehicles run only when it is sunny"]$mq$, 1, $mq$Traffic emits nitrogen oxides and volatile organic compounds, and sunshine drives the reactions that form ozone and other irritants.$mq$, $mq$medium$mq$),
($mq$Limestone statues are damaged in a city with acid rain. Which explanation is best?$mq$, $mq$["The acid reacts with calcium carbonate in limestone and dissolves it","Acid rain makes limestone grow","Limestone absorbs oxygen and cracks","Acid rain is basic and coats the stone"]$mq$, 0, $mq$Acids react with calcium carbonate, producing soluble salts, carbon dioxide and water. This wears away the surface.$mq$, $mq$medium$mq$),
($mq$A monitoring station shows nitrogen dioxide peaking at 8 a.m. and 6 p.m., but ozone peaking around 2 p.m. What is the best explanation?$mq$, $mq$["Ozone is released directly by cars at 2 p.m.","Nitrogen dioxide is destroyed by traffic","The instruments are faulty","Nitrogen dioxide comes from rush-hour traffic, and ozone forms later as sunlight drives reactions"]$mq$, 3, $mq$Primary pollutants peak with traffic. Ozone is a secondary pollutant, so its peak lags behind when sunshine is strongest.$mq$, $mq$hard$mq$),
($mq$A city introduces a congestion charge for cars entering the centre. Which result would best show that the policy is effective?$mq$, $mq$["More cars buy toll tickets","The city earns money","Measured nitrogen dioxide and traffic counts in the zone fall compared with before, and compared with similar areas without a charge","People say they like the scheme"]$mq$, 2, $mq$Effectiveness is shown by measurable change in the target outcome, compared with a control. Income and opinion do not show reduced pollution.$mq$, $mq$hard$mq$),
($mq$Factories in country A emit sulfur dioxide. Lakes in country B, hundreds of kilometres downwind, become acidic. Which statement explains this?$mq$, $mq$["Country B must have caused it","Pollutants are carried by winds across borders and fall as acid rain far from the source","Acid rain only forms at the source","Lakes naturally become acidic every year"]$mq$, 1, $mq$Air pollution can travel long distances before it is deposited, which is why acid rain needs international cooperation.$mq$, $mq$hard$mq$),
($mq$A study finds that children at a school next to a busy road have higher rates of asthma than children at a school in a quiet area. A student concludes that traffic pollution definitely causes asthma. What is the best evaluation?$mq$, $mq$["The data suggest a link, but other factors such as housing, smoking and genetics could also differ, so it does not prove cause","The conclusion is certain because the schools are different","The result is meaningless because asthma is not related to air","The student should only have used one school"]$mq$, 0, $mq$A correlation is not proof of causation. A fairer study would control or measure other variables and use many schools.$mq$, $mq$hard$mq$),
($mq$Unpolluted rain has a pH of about 5.6. A town's rain has an average pH of 4.6. Which statement is correct?$mq$, $mq$["The town's rain is 10 units more acidic","The town's rain is slightly less acidic than normal","Normal rain has a pH of 7 because it is pure water","The town's rain is 1 unit lower and so 10 times more acidic; rain is normally slightly acidic because dissolved carbon dioxide forms carbonic acid"]$mq$, 3, $mq$One pH unit equals a tenfold change in acidity. Natural rain is slightly acidic due to dissolved CO₂, and acid rain is generally defined as rain below about pH 5.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Air Pollution and Smog$mq$ and p.name = $mq$Pollution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Primary vs secondary pollutant$mq$, $mq$Primary pollutants are released directly (SO₂, CO, NOₓ, particulates). Secondary pollutants form later in the air (ground-level ozone, PAN).$mq$),
($mq$Photochemical smog$mq$, $mq$Smog formed when sunlight drives reactions between nitrogen oxides and VOCs from vehicles, producing ozone and other irritants.$mq$),
($mq$Temperature inversion$mq$, $mq$A layer of warm air above cooler air that traps pollutants near the ground so they cannot disperse.$mq$),
($mq$Cause of acid rain$mq$, $mq$Sulfur dioxide and nitrogen oxides dissolve in cloud water to form sulfuric and nitric acids.$mq$),
($mq$Effects of acid rain$mq$, $mq$Acidifies lakes, damages trees and soils, and corrodes limestone and metal because acids react with calcium carbonate.$mq$),
($mq$Catalytic converter$mq$, $mq$A device in car exhausts that changes CO to CO₂ and nitrogen oxides to nitrogen. It does not remove carbon dioxide.$mq$),
($mq$Flue-gas desulfurisation$mq$, $mq$Exhaust gases from power stations pass through a limestone mixture that traps sulfur dioxide, reducing acid rain.$mq$),
($mq$Why are PM2.5 particles dangerous?$mq$, $mq$They are small enough to go deep into the lungs and enter the blood, causing asthma, and heart and lung disease.$mq$),
($mq$pH and acidity$mq$, $mq$The pH scale is logarithmic: one unit lower is 10 times more acidic, and two units lower is 100 times. Normal rain is about pH 5.6.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Air Pollution and Smog$mq$ and p.name = $mq$Pollution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Types of air pollution
Air pollution is the presence of substances in the air at levels that harm people, other organisms or materials. Pollutants are grouped by how they form.
- **Primary pollutants** are released directly: carbon monoxide (incomplete combustion), sulfur dioxide (burning coal and oil), nitrogen oxides (hot engines), particulates (soot, dust) and volatile organic compounds (VOCs).
- **Secondary pollutants** form later by reactions in the air: ground-level ozone and PAN in smog, and the acids in acid rain.

Do not confuse ground-level ozone, which harms health, with the ozone layer high in the atmosphere that protects us.

## Photochemical smog
In sunlight, nitrogen oxides and VOCs from traffic react to form ozone and other irritants. This **photochemical smog** is worst in warm, sunny cities with many vehicles, and when weather conditions are still. It causes eye and throat irritation, breathing problems and damage to crops.

A **temperature inversion** occurs when a layer of warm air lies over cooler air near the ground. Normally warm air rises and carries pollutants away. In an inversion, pollutants are trapped near the surface, so smog builds up, especially in valleys and basins.

Historic "sulfurous" smog came from burning coal with fog. Today many large cities in rapidly developing regions still suffer from smoke, sulfur dioxide and particulates.

## Acid rain
Sulfur dioxide and nitrogen oxides dissolve in cloud water to form sulfuric and nitric acids. Rain with a pH below about 5 is acid rain. Natural rain is slightly acidic (about pH 5.6) because of dissolved carbon dioxide.
Effects: acidified lakes where fish and invertebrates die; damage to trees and leaching of nutrients and aluminium from soils; corrosion of limestone buildings, because acid reacts with calcium carbonate.
Because winds carry pollutants hundreds of kilometres, acid rain can fall in a different country from the source, so solving it needs international cooperation.
The pH scale is logarithmic: each unit is a factor of 10. A fall from pH 6 to pH 4 means 100 times more acidic.

## Health effects
Particulates, especially PM2.5, are tiny enough to travel deep into the lungs and may enter the blood. They are linked to asthma, heart and lung disease. Carbon monoxide reduces the blood's ability to carry oxygen.

## Reducing air pollution
- **Catalytic converters** change carbon monoxide to carbon dioxide and nitrogen oxides to nitrogen.
- **Flue-gas desulfurisation** (scrubbers) removes sulfur dioxide using limestone mixtures.
- Low-sulfur fuel, cleaner energy, electric vehicles, public transport, cycling and congestion charges.
- Laws and emission limits, plus monitoring.

## Calculating change
If particulates fall from 35 to 21 micrograms per m³: decrease = 14, and 14 ÷ 35 × 100 = 40%.

## Evaluating evidence
Be careful about cause and effect. If asthma rates are higher near a busy road, traffic might be involved, but housing, smoking or genetics could also differ. Good investigations measure pollution directly, use several sites and compare with a control.

## Common mistakes
- Mixing up primary and secondary pollutants.
- Thinking ozone is always good or always bad: it depends on where it is.
- Forgetting that pH is logarithmic.
- Saying catalytic converters stop carbon dioxide.

## How this is examined
You may be given a city's pollution data over a day or year, a map of wind and emissions, or a description of a policy. Tasks include naming pollutants and sources, explaining smog or acid rain, calculating percentage change, and evaluating policies using evidence.

Exam tip: link each pollutant to its source, its effect and a way of reducing it, and name the evidence you would need to judge whether a policy has worked.$mq$ from st;

-- Pollution > Water Pollution and Eutrophication
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Pollution$mq$, 5, 4 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Water Pollution and Eutrophication$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Pollution$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Water Pollution and Eutrophication$mq$ and p.name = $mq$Pollution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is eutrophication?$mq$, $mq$["Enrichment of a water body with nutrients, leading to excessive algal growth and loss of oxygen","Removal of salt from water","Heating of water by sunlight","Filtering of water through sand"]$mq$, 0, $mq$Eutrophication starts with extra nutrients, usually nitrates and phosphates, which cause algae to grow rapidly and eventually deplete oxygen.$mq$, $mq$easy$mq$),
($mq$Which activity is a common source of nitrate pollution in rivers?$mq$, $mq$["Planting trees on the banks","Using solar panels","Cycling to school","Run-off of fertiliser from fields"]$mq$, 3, $mq$Fertiliser spread on farmland can wash into streams after rain, bringing nitrates and phosphates into water bodies.$mq$, $mq$easy$mq$),
($mq$Which organism is most likely to be found in a stream with very low dissolved oxygen caused by pollution?$mq$, $mq$["Mayfly larvae","Stonefly larvae","Sludge worms (tubifex)","Freshwater shrimp"]$mq$, 2, $mq$Sludge worms tolerate low oxygen and organic pollution. Mayfly and stonefly larvae need clean, well-oxygenated water.$mq$, $mq$easy$mq$),
($mq$Why does warm water hold less dissolved oxygen than cold water?$mq$, $mq$["Warm water contains more fish","The solubility of gases decreases as temperature rises","Warm water has no gases","Oxygen is made by heat"]$mq$, 1, $mq$Gases are less soluble in warm water, so dissolved oxygen falls as temperature increases.$mq$, $mq$easy$mq$),
($mq$Untreated sewage is released into a river. Why does this lower the oxygen level?$mq$, $mq$["Bacteria decomposing the organic matter use up oxygen in respiration","Sewage contains oxygen-absorbing metals","Sewage heats the river","Sewage stops photosynthesis in fish"]$mq$, 0, $mq$Aerobic bacteria break down the organic waste and use dissolved oxygen as they respire, leaving less for fish and invertebrates.$mq$, $mq$easy$mq$),
($mq$Which sequence correctly describes the stages of eutrophication?$mq$, $mq$["Fish die, nutrient run-off, algal bloom, plants die","Algal bloom, fish die, nutrient run-off, light blocked","Bacteria decompose, nutrient run-off, algal bloom, fish die","Nutrient run-off, algal bloom, light blocked and plants die, bacteria decompose and use oxygen, fish die"]$mq$, 3, $mq$Nutrients cause an algal bloom. The bloom shades submerged plants, which die. Decomposers multiply and use up oxygen, and fish and other animals suffocate.$mq$, $mq$medium$mq$),
($mq$Why does a thick layer of algae on the surface of a pond harm submerged plants?$mq$, $mq$["Algae poison the plants","Algae remove all carbon dioxide","It blocks sunlight so the plants cannot photosynthesise","Algae absorb the soil"]$mq$, 2, $mq$Submerged plants need light for photosynthesis. A surface bloom blocks it, so they die.$mq$, $mq$medium$mq$),
($mq$Dissolved oxygen is 9 mg/L upstream of a factory outlet and 3 mg/L downstream. What is the percentage decrease?$mq$, $mq$["33%","67%","300%","6%"]$mq$, 1, $mq$The decrease is 6 mg/L. 6 ÷ 9 × 100 = 66.7%, which rounds to 67%.$mq$, $mq$medium$mq$),
($mq$A farmer applies 40 kg of nitrogen fertiliser per hectare on 150 hectares. If 25% of the nitrogen is lost in run-off, how much nitrogen reaches nearby water?$mq$, $mq$["1500 kg","6000 kg","150 kg","40 kg"]$mq$, 0, $mq$Per hectare, 25% of 40 kg = 10 kg. For 150 ha: 10 × 150 = 1500 kg.$mq$, $mq$medium$mq$),
($mq$In the later stages of eutrophication, which process mainly causes the fall in dissolved oxygen?$mq$, $mq$["Fish breathing out oxygen","Photosynthesis by algae in daylight","Evaporation of the oxygen","Aerobic bacteria respiring while decomposing dead algae and plants"]$mq$, 3, $mq$Large amounts of dead material feed decomposers, whose respiration uses up the dissolved oxygen.$mq$, $mq$medium$mq$),
($mq$A strip of grass and shrubs is planted between a field and a river. How does it help reduce eutrophication?$mq$, $mq$["It adds fertiliser to the river","It increases the temperature of the river","It absorbs nutrients and slows run-off, so less reaches the water","It stops rain falling"]$mq$, 2, $mq$Buffer strips trap soil and take up nutrients before they reach the river.$mq$, $mq$medium$mq$),
($mq$An oil spill affects seabirds. What is the main reason oil is harmful to them?$mq$, $mq$["Oil makes the water too salty","Oil coats feathers, reducing insulation and waterproofing, and birds swallow toxic oil while preening","Oil is poisonous only to fish","Oil makes birds heavier by increasing their size"]$mq$, 1, $mq$Oiled feathers lose their insulating properties so birds can die of cold, and ingesting oil damages organs.$mq$, $mq$medium$mq$),
($mq$A power station releases warm cooling water into a river. What problem might this cause?$mq$, $mq$["It reduces dissolved oxygen and can stress organisms adapted to cooler water","It adds extra oxygen to the water","It makes the river cleaner","It lowers the nutrient level"]$mq$, 0, $mq$Thermal pollution lowers oxygen solubility and speeds up metabolism, so organisms need more oxygen when less is available.$mq$, $mq$medium$mq$),
($mq$Invertebrates found at three sites on a stream: Site 1, mayfly and stonefly larvae; Site 2, freshwater shrimp and snails; Site 3, sludge worms and rat-tailed maggots. Which order is from cleanest to most polluted?$mq$, $mq$["Site 3, Site 2, Site 1","Site 2, Site 1, Site 3","Site 1, Site 3, Site 2","Site 1, Site 2, Site 3"]$mq$, 3, $mq$Mayfly and stonefly larvae need very clean water, shrimp and snails tolerate moderate pollution, and sludge worms and rat-tailed maggots live in heavily polluted, low-oxygen water.$mq$, $mq$hard$mq$),
($mq$Algae release oxygen by photosynthesis, so why can an algal bloom still cause fish to die?$mq$, $mq$["Algae do not make oxygen","Fish cannot use oxygen from algae","At night algae respire, and when the bloom dies, decomposition uses much more oxygen than the algae made","Algae turn the water into a gas"]$mq$, 2, $mq$Oxygen from photosynthesis only occurs in light and mostly near the surface. Respiration at night and decomposition of dead algae can leave the water with very little oxygen.$mq$, $mq$hard$mq$),
($mq$A town bans phosphates in laundry detergent. Which evaluation is most balanced?$mq$, $mq$["It will fix all eutrophication immediately","It removes one source of phosphate, but farm run-off and sewage may still supply nutrients, so other measures are also needed","It will have no effect on phosphate input","It is pointless because detergent is not used"]$mq$, 1, $mq$Eutrophication usually has several nutrient sources. Reducing one helps, but a full solution tackles all major sources.$mq$, $mq$hard$mq$),
($mq$Why might a sewage works add a tertiary treatment stage before releasing water into a river?$mq$, $mq$["To remove nitrates and phosphates that would otherwise cause eutrophication","To add more organic matter","To warm the water","To increase the number of bacteria"]$mq$, 0, $mq$Primary and secondary treatment remove solids and most organic matter. Tertiary treatment removes remaining nutrients and may disinfect the water.$mq$, $mq$hard$mq$),
($mq$A student tests how fertiliser concentration affects algae growth in five identical jars of pond water. Which change would make the investigation fairer?$mq$, $mq$["Putting each jar in a different window with different light","Changing both the fertiliser and the temperature in each jar","Using different amounts of pond water in each jar","Giving each jar the same volume of water, the same light and temperature, and changing only the fertiliser concentration"]$mq$, 3, $mq$A fair test changes only the independent variable (fertiliser concentration) and keeps other variables, such as volume, light and temperature, constant.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Water Pollution and Eutrophication$mq$ and p.name = $mq$Pollution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Eutrophication$mq$, $mq$Nutrient enrichment of water (nitrates and phosphates) that causes an algal bloom and later oxygen depletion by decomposers.$mq$),
($mq$Main steps of eutrophication$mq$, $mq$Nutrients enter, algal bloom, light blocked, plants die, bacteria decompose and use oxygen, animals die.$mq$),
($mq$Why does the oxygen level fall?$mq$, $mq$Aerobic bacteria use dissolved oxygen as they decompose large amounts of dead algae and plants.$mq$),
($mq$Indicator species for clean water$mq$, $mq$Mayfly and stonefly larvae need clean, oxygen-rich water. Sludge worms and rat-tailed maggots tolerate polluted, low-oxygen water.$mq$),
($mq$Thermal pollution$mq$, $mq$Warm water released from industry. It holds less dissolved oxygen and speeds up the metabolism of organisms.$mq$),
($mq$Sources of nutrient pollution$mq$, $mq$Fertiliser run-off, sewage, animal waste and detergents containing phosphates.$mq$),
($mq$Buffer strip$mq$, $mq$A band of grass or trees between a field and a river that traps soil and absorbs nutrients, reducing run-off.$mq$),
($mq$Stages of sewage treatment$mq$, $mq$Primary removes solids, secondary uses bacteria to break down organic matter, tertiary removes nutrients and kills microbes.$mq$),
($mq$Effect of an oil spill on seabirds$mq$, $mq$Oil coats feathers, destroying insulation and waterproofing. Birds also swallow toxic oil when preening.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Water Pollution and Eutrophication$mq$ and p.name = $mq$Pollution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Sources of water pollution
Water pollution is the addition of harmful substances or energy to water so that it harms living things or reduces its use. Main sources:
- **Sewage**: contains organic matter, nutrients and microbes that cause disease.
- **Agricultural run-off**: fertilisers (nitrates and phosphates), pesticides and animal waste washed from fields by rain.
- **Industrial waste**: toxic chemicals and heavy metals such as mercury.
- **Oil spills**: coat organisms and damage habitats.
- **Thermal pollution**: warm water released from power stations lowers the amount of dissolved oxygen.
- **Plastics and litter**.

## Eutrophication step by step
Eutrophication means enrichment of water with nutrients. The stages are:
1. Fertiliser or sewage adds extra nitrates and phosphates to a lake or river.
2. Algae grow very fast, forming an **algal bloom** on the surface.
3. The bloom blocks light, so submerged plants cannot photosynthesise and die.
4. Algae and plants die. **Aerobic bacteria** decompose them and use up dissolved oxygen as they respire.
5. Fish and other animals that need oxygen die, and the water becomes a low-oxygen "dead zone".

Notice the key point: the lack of oxygen is caused by decomposers, not by the algae themselves. At night algae also respire, which lowers oxygen further.

## Measuring water quality
- **Dissolved oxygen** (in mg per litre): clean, fast water has more. Warm water holds less oxygen than cold water.
- **Nitrate and phosphate tests**.
- **Indicator species**: mayfly and stonefly larvae need clean, oxygen-rich water. Freshwater shrimp and snails tolerate some pollution. Sludge worms and rat-tailed maggots survive in heavily polluted water.

Worked example: oxygen is 9 mg/L upstream and 3 mg/L downstream. Percentage decrease = (9 − 3) ÷ 9 × 100 = 67% (to two significant figures).

Nutrient loss example: 40 kg nitrogen per hectare on 150 ha with 25% lost: 40 × 0.25 = 10 kg per ha; 10 × 150 = 1500 kg reaches water.

## Reducing water pollution
- Use fertiliser carefully and at the right time, and use crop rotation.
- **Buffer strips** of grass or trees between fields and rivers.
- Treat sewage: primary treatment removes solids, secondary uses bacteria to break down organic matter, tertiary removes nutrients and kills microbes.
- Phosphate-free detergents and regulations on factories.
- Containing spills and cleaning up quickly.

Some pollutants, such as mercury, can build up in food chains (bioaccumulation and biomagnification). This affects top predators including humans.

## Common mistakes
- Saying algae use up the oxygen. It is the bacteria decomposing dead material that cause the main drop.
- Forgetting that the bloom blocks light.
- Using indicator species from one visit as perfect evidence. Repeat the sampling.
- Listing fertiliser as the only cause of eutrophication. Sewage and detergents also add nutrients.

## How this is examined
Questions often give a map or table of a river with oxygen readings, nitrate levels and invertebrate counts at different sites. You may have to interpret trends, explain the cause of changes, calculate percentage change or nutrient loads, and judge management options.

Exam tip: when explaining eutrophication, write the whole chain in order. Marks are given for each link: more nutrients, more algae, less light, plants die, more decomposition, less oxygen, animals die.$mq$ from st;

-- Pollution > Waste and Plastic Management
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Pollution$mq$, 5, 4 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Waste and Plastic Management$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Pollution$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Waste and Plastic Management$mq$ and p.name = $mq$Pollution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In the waste hierarchy, which action is the most preferred?$mq$, $mq$["Reduce and prevent waste","Landfill","Incineration","Recycling"]$mq$, 0, $mq$The hierarchy puts prevention and reduction first because avoiding waste saves the most resources and energy.$mq$, $mq$easy$mq$),
($mq$What is leachate in a landfill site?$mq$, $mq$["A gas produced by plants","A type of plastic","A cover of soil","A polluted liquid that drains through waste and can contaminate groundwater"]$mq$, 3, $mq$Rain passing through waste picks up chemicals and microbes, forming leachate. Modern landfills use liners and collection systems to contain it.$mq$, $mq$easy$mq$),
($mq$Which greenhouse gas is produced when organic waste decomposes without oxygen in a landfill?$mq$, $mq$["Helium","Oxygen","Methane","Argon"]$mq$, 2, $mq$Anaerobic decomposition releases methane, a strong greenhouse gas. Some landfills capture it for energy.$mq$, $mq$easy$mq$),
($mq$What are microplastics?$mq$, $mq$["Plastics used in microscopes","Plastic fragments smaller than 5 mm","Plastic bags that are very large","Biodegradable plastics"]$mq$, 1, $mq$Microplastics form from the breakdown of larger plastics or are made small on purpose, such as in some cosmetics. They spread through water, soil and food chains.$mq$, $mq$easy$mq$),
($mq$What does biodegradable mean?$mq$, $mq$["Can be broken down by living organisms such as bacteria and fungi","Cannot be broken down","Made from metal","Always safe to eat"]$mq$, 0, $mq$Biodegradable materials are broken down by decomposers into simpler substances. The time and conditions needed can vary a lot.$mq$, $mq$easy$mq$),
($mq$A city has 500 000 people and each produces 1.2 kg of waste per day. How many tonnes of waste does the city produce per day? (1 tonne = 1000 kg)$mq$, $mq$["6000 tonnes","60 tonnes","416 tonnes","600 tonnes"]$mq$, 3, $mq$500 000 × 1.2 = 600 000 kg, which is 600 tonnes.$mq$, $mq$medium$mq$),
($mq$Of the city's 600 tonnes of waste per day, 180 tonnes are recycled. What is the recycling rate?$mq$, $mq$["3%","18%","30%","70%"]$mq$, 2, $mq$180 ÷ 600 × 100 = 30%.$mq$, $mq$medium$mq$),
($mq$Which list shows the waste hierarchy from most to least preferred?$mq$, $mq$["Landfill, recover, recycle, reuse, reduce","Reduce, reuse, recycle, recover (energy), landfill","Recycle, reduce, landfill, reuse, recover","Reuse, landfill, reduce, recycle, recover"]$mq$, 1, $mq$The order follows the amount of resources saved: prevention first, then reuse, recycling, energy recovery and finally disposal.$mq$, $mq$medium$mq$),
($mq$A town burns its waste in an incinerator that generates electricity. Which statement gives a benefit and a drawback?$mq$, $mq$["Benefit: reduces the volume of waste and can generate energy; drawback: can release air pollutants and CO₂ if not controlled","Benefit: no emissions; drawback: it produces too little ash","Benefit: recycles plastic into new bottles; drawback: none","Benefit: removes all toxic substances; drawback: produces no energy"]$mq$, 0, $mq$Incineration reduces waste volume by a large factor and produces heat, but it releases CO₂, can produce toxic ash and gases, and uses materials that could be recycled.$mq$, $mq$medium$mq$),
($mq$A school collects food scraps and garden waste to make compost. What is the main advantage?$mq$, $mq$["It makes plastic degrade faster","It increases landfill methane","It removes metals from waste","It turns organic waste into a soil improver and reduces waste sent to landfill"]$mq$, 3, $mq$Composting uses decomposers to break down organic matter into nutrient-rich material that can improve soil.$mq$, $mq$medium$mq$),
($mq$Why do most conventional plastics remain in the environment for hundreds of years?$mq$, $mq$["They are heavy","They are made of metal","They have strong, long chemical chains that most microorganisms cannot break down easily","They contain oxygen"]$mq$, 2, $mq$Most decomposers lack the enzymes to digest synthetic polymers. Sunlight and wear break plastic into smaller pieces, but they do not fully break it down quickly.$mq$, $mq$medium$mq$),
($mq$Why is recycling electronic waste (e-waste) important?$mq$, $mq$["E-waste cannot contain metals","It contains valuable metals that can be recovered and hazardous substances that must not leak into the environment","It is made only of paper","It decomposes quickly in landfills"]$mq$, 1, $mq$Circuit boards and batteries contain metals such as copper and gold, and also toxic metals such as lead. Recovery saves mining and protects soil and water.$mq$, $mq$medium$mq$),
($mq$What is the main idea of a circular economy?$mq$, $mq$["Keeping materials and products in use for as long as possible through reuse, repair and recycling to reduce waste","Making more products and throwing them away faster","Burning all waste for energy","Using only products made once"]$mq$, 0, $mq$A circular economy replaces the 'take, make, dispose' model with one that designs out waste and keeps resources in use.$mq$, $mq$medium$mq$),
($mq$If the city's recycling rate rises from 30% to 45% while the total waste stays at 600 tonnes per day, how many extra tonnes are recycled each day?$mq$, $mq$["15 tonnes","270 tonnes","150 tonnes","90 tonnes"]$mq$, 3, $mq$The rate increases by 15 percentage points. 15% of 600 = 90 tonnes. The new total recycled is 270 tonnes.$mq$, $mq$hard$mq$),
($mq$A company advertises its 'biodegradable' plastic bags. Tests show they break down only in industrial composting units at high temperatures. What is the best evaluation?$mq$, $mq$["They will break down quickly in the ocean","They break down in all conditions","They may not break down in the sea or landfill, so the label can mislead and they must be collected and processed correctly","They are guaranteed to be better than every other bag"]$mq$, 2, $mq$Biodegradability depends on conditions. Without the right facilities, 'biodegradable' items can persist and still cause litter and microplastic problems.$mq$, $mq$hard$mq$),
($mq$Assume that making one cotton bag causes as much environmental damage as making 25 single-use plastic bags. For the cotton bag to be the better option, it must be used how many times?$mq$, $mq$["5 times","More than 25 times","Once","250 times"]$mq$, 1, $mq$Each use of the cotton bag replaces one plastic bag, so it needs to replace more than 25 to cause less damage overall. The assumption is a model, because real impacts vary.$mq$, $mq$hard$mq$),
($mq$Large amounts of plastic reach the ocean via rivers. Which action would most effectively reduce ocean plastic in the long term?$mq$, $mq$["Reducing plastic use and improving waste collection on land, so less enters rivers","Only removing plastic from the open ocean","Burning plastic on beaches","Burying plastic on the seabed"]$mq$, 0, $mq$Cleaning up the ocean is hard and cannot keep pace if plastic keeps entering. Preventing leakage at the source is more effective and cheaper.$mq$, $mq$hard$mq$),
($mq$A student claims: "Recycling alone can solve the plastic pollution problem." Which is the best evaluation?$mq$, $mq$["The claim is correct because all plastics are easily recycled","The claim is wrong because recycling has no benefits","The claim is correct because recycling creates no emissions","The claim is overstated: many plastics are contaminated, mixed or downcycled, so reduction and reuse are also needed"]$mq$, 3, $mq$Recycling helps but is limited by contamination, different plastic types, cost and quality loss. The hierarchy places reduction and reuse above it.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Waste and Plastic Management$mq$ and p.name = $mq$Pollution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Waste hierarchy (most to least preferred)$mq$, $mq$Reduce/prevent, reuse, recycle, recover energy, dispose (landfill).$mq$),
($mq$Landfill: two environmental problems$mq$, $mq$Methane from decomposing organic waste (a greenhouse gas) and leachate, polluted liquid that can contaminate groundwater.$mq$),
($mq$Incineration: benefit and drawback$mq$, $mq$Reduces waste volume and can generate energy, but releases CO₂ and possibly toxic gases and leaves ash needing safe disposal.$mq$),
($mq$Microplastics$mq$, $mq$Plastic fragments smaller than 5 mm, formed by breakdown of larger plastic or made small on purpose. They spread through water, soil and food chains.$mq$),
($mq$Why do plastics persist?$mq$, $mq$Their long synthetic chains are very hard for decomposers to break down, so they last for hundreds of years.$mq$),
($mq$Biodegradable$mq$, $mq$Able to be broken down by living organisms. The speed depends on conditions, and some need industrial composting.$mq$),
($mq$Circular economy$mq$, $mq$A system that keeps products and materials in use through reuse, repair and recycling, and designs out waste.$mq$),
($mq$Recycling rate formula$mq$, $mq$Mass recycled ÷ total waste × 100. For 180 t of 600 t: 30%.$mq$),
($mq$Why recycle e-waste?$mq$, $mq$It contains valuable metals that can be recovered and hazardous substances such as lead that must not leak into the environment.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Waste and Plastic Management$mq$ and p.name = $mq$Pollution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The waste problem
Humans produce huge amounts of waste, and it increases with population, wealth and consumption. Waste includes household rubbish, food waste, packaging, plastics, industrial waste and electronic waste. If it is managed badly it pollutes land, water and air, wastes resources and harms wildlife.

## The waste hierarchy
The hierarchy ranks options from most to least preferred:
1. **Reduce / prevent**: avoid creating waste, for example less packaging.
2. **Reuse**: use items again, for example refillable bottles.
3. **Recycle**: turn waste into new materials.
4. **Recover**: obtain energy, for example by incineration with energy recovery or anaerobic digestion.
5. **Dispose**: landfill.

The higher up the hierarchy, the more resources and energy are saved.

## Disposal methods
- **Landfill**: cheap and simple, but takes up land, produces **methane** (a greenhouse gas) as organic waste decays without oxygen, and can produce **leachate**, a polluted liquid that can contaminate groundwater. Modern sites use liners and capture gas.
- **Incineration**: burning reduces the volume of waste and can generate electricity, but releases carbon dioxide and possibly toxic gases and leaves ash that needs safe disposal.
- **Composting and anaerobic digestion**: decomposers turn food and garden waste into compost or biogas.
- **Recycling**: saves raw materials and energy, but needs collection and sorting. Contamination can ruin a batch, and some materials, such as many plastics, lose quality each time.

## Plastics
Plastics are cheap, light and durable, which is why they are so useful, but also why they last in the environment. Their long chains are hard for decomposers to digest. Sunlight and wear break them into **microplastics** (smaller than 5 mm), which spread through oceans, soil and food chains. Animals can be harmed by entanglement or by swallowing plastic. Solutions include reducing single-use items, deposit-return schemes, better collection and design for recycling. 'Biodegradable' plastics may only break down in industrial composters, so the label can mislead.

## E-waste and the circular economy
Electronic waste contains valuable metals that can be recovered and hazardous materials, such as lead, that can leak if dumped. A **circular economy** keeps products and materials in use through repair, reuse and recycling and designs out waste, instead of the 'take, make, dispose' pattern.

## Calculations
- City waste: 500 000 people × 1.2 kg = 600 000 kg = 600 tonnes per day.
- Recycling rate = recycled ÷ total × 100 = 180 ÷ 600 × 100 = 30%.
- If the rate rises from 30% to 45%: 15% of 600 = 90 extra tonnes per day.
- Break-even for reusable bags: if one cotton bag has the same impact as 25 plastic bags, it must be used more than 25 times. This depends on the assumption, so say that it is a model.

## Common mistakes
- Putting recycling above reduction and reuse in the hierarchy.
- Thinking landfill waste simply disappears. It produces gas and liquids.
- Mixing up percentage points and percentages when a rate changes.
- Assuming 'biodegradable' always means quick, harmless decay.

## How this is examined
Questions often give a town or school waste audit, a table of waste types or a plastic-use scenario. You may calculate tonnages, recycling rates and changes, compare disposal methods using criteria, and recommend actions with justification, stating assumptions and limitations.

Exam tip: when evaluating a waste strategy, refer to the hierarchy and compare at least two methods on cost, emissions, pollution and resource use.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('environmental-systems')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;