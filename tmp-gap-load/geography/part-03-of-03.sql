-- Part 3 of 3: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Resource Extraction and Consumption > Consumption, Waste and Resource Security
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Resource Extraction and Consumption$mq$, 5, 3 from public.subjects s where s.slug = $mq$geography$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Consumption, Waste and Resource Security$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$geography$mq$ and p.grade = 5 and p.name = $mq$Resource Extraction and Consumption$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Consumption, Waste and Resource Security$mq$ and p.name = $mq$Resource Extraction and Consumption$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does the term 'ecological footprint' measure?$mq$, $mq$["The area of land and sea needed to supply the resources a person or population uses and absorb its waste","The size of a person's shoes","The number of trees in a country","The distance a person travels"]$mq$, 0, $mq$The footprint compares human demand on nature with what the planet can regenerate.$mq$, $mq$easy$mq$),
($mq$Which is the best example of the 'reduce' step of the waste hierarchy?$mq$, $mq$["Putting plastic in a recycling bin","Burning rubbish for energy","Burying waste in landfill","Buying products with less packaging"]$mq$, 3, $mq$Waste hierarchy: reduce, reuse, recycle, recover, dispose. Reducing prevents waste at source and sits at the top.$mq$, $mq$easy$mq$),
($mq$What is e-waste?$mq$, $mq$["Waste from energy drinks","Waste from emails","Discarded electrical and electronic products such as phones and laptops","Waste from farms"]$mq$, 2, $mq$E-waste contains valuable metals but also harmful substances if processed unsafely.$mq$, $mq$easy$mq$),
($mq$Which resource is essential for life and may be scarce in some regions?$mq$, $mq$["Gold","Fresh water","Diamonds","Sand dunes"]$mq$, 1, $mq$Water scarcity affects billions of people. Gold and diamonds are valued but not essential for survival.$mq$, $mq$easy$mq$),
($mq$Resource security means$mq$, $mq$["Having reliable access to enough affordable resources such as food, water and energy","Hiding resources from other countries","Using all resources immediately","Having no trade"]$mq$, 0, $mq$Security of supply is a concern for governments and households, as shortages can cause price rises and instability.$mq$, $mq$easy$mq$),
($mq$Which statement best describes a circular economy?$mq$, $mq$["Products are used once and dumped","Only new materials are used","Waste is shipped abroad","Products and materials are kept in use through reuse, repair and recycling to minimise waste"]$mq$, 3, $mq$A circular economy contrasts with a linear 'take, make, dispose' model.$mq$, $mq$medium$mq$),
($mq$In 2018 Cape Town in South Africa came close to 'Day Zero', when municipal water supplies might have had to be turned off. What was the main trigger?$mq$, $mq$["A volcanic eruption","A sudden increase in rainfall","A multi-year drought combined with high demand","A decline in population"]$mq$, 2, $mq$Restrictions on use and public efforts to reduce consumption helped to delay Day Zero.$mq$, $mq$medium$mq$),
($mq$Which pair correctly matches a resource to a security concern?$mq$, $mq$["Fresh air: it must be imported","Energy: dependence on imported gas can cause shortages if supply is cut","Sunlight: it runs out each year","Sand: it is the main source of electricity"]$mq$, 1, $mq$Countries relying on a single foreign supplier are vulnerable. The 2022 gas supply disruption in Europe showed this.$mq$, $mq$medium$mq$),
($mq$Why does consumption of resources tend to be higher in high-income countries?$mq$, $mq$["Higher incomes allow people to buy more goods, energy and food per person","They have lower populations everywhere","They have no waste","They use only renewable resources"]$mq$, 0, $mq$Per-person consumption rises with income, though population size also affects total demand.$mq$, $mq$medium$mq$),
($mq$Which of these is a drawback of landfill?$mq$, $mq$["It always produces useful electricity","It prevents all pollution","It makes waste vanish","It takes up land and can release methane and pollute groundwater"]$mq$, 3, $mq$Decomposing waste produces methane, a greenhouse gas, and leachate can contaminate water.$mq$, $mq$medium$mq$),
($mq$Country A recycles 45 kg of household waste per person each year out of 300 kg produced. What is the recycling rate?$mq$, $mq$["6.7%","45%","15%","85%"]$mq$, 2, $mq$45 ÷ 300 × 100 = 15%. Dividing 300 by 45 gives 6.7, not a percentage.$mq$, $mq$medium$mq$),
($mq$A town introduces a pay-as-you-throw system, charging households by the weight of non-recycled rubbish. Which effect is most likely?$mq$, $mq$["Waste always increases","Households reduce waste and recycle more to save money","Recycling falls to zero","Fly-tipping is impossible"]$mq$, 1, $mq$Financial incentives encourage behaviour change, though fly-tipping can be a side effect if enforcement is weak.$mq$, $mq$medium$mq$),
($mq$The energy mix of a country in a year was: coal 40%, gas 30%, wind 20%, hydro 10%. What percentage is from renewable sources?$mq$, $mq$["30%","20%","70%","50%"]$mq$, 0, $mq$Renewables are wind and hydro, 20 + 10 = 30%. Gas and coal are fossil fuels.$mq$, $mq$medium$mq$),
($mq$A phone manufacturer offers a 'take-back' scheme, where old phones are collected and the metals recovered. Which advantage is most accurate?$mq$, $mq$["It guarantees no mining will occur","It makes phones last forever","It increases landfill","It reduces e-waste and the need to mine new metals"]$mq$, 3, $mq$Recovering metals reduces demand for virgin material, though collection and recycling must be efficient to deliver benefits.$mq$, $mq$hard$mq$),
($mq$Earth Overshoot Day is the date when humanity has used the resources the Earth can renew in a year. If it falls on 1 August, what does this suggest?$mq$, $mq$["Resources will last for ever","The planet is able to supply more than enough","People are using resources faster than they can be regenerated, equivalent to more than one planet","Consumption has fallen below sustainable levels"]$mq$, 2, $mq$An early date means demand exceeds the annual capacity of ecosystems to regenerate, so stocks are being run down.$mq$, $mq$hard$mq$),
($mq$Country X imports 80% of its energy from one supplier. After a political dispute the supplier cuts exports by half. Which response gives the best long-term resource security?$mq$, $mq$["Rely on the same supplier and hope the dispute ends","Diversify suppliers, improve efficiency and develop domestic renewable energy","Stop using energy","Increase use of the same imported fuel"]$mq$, 1, $mq$Diversification and reducing demand lower exposure to a single point of failure.$mq$, $mq$hard$mq$),
($mq$A city's water demand is 200 million litres per day but its supply is 160 million. A campaign cuts household demand by 10% and leak repairs return 12 million litres per day to supply. What shortfall remains?$mq$, $mq$["8 million litres per day","28 million litres per day","0, with a surplus","20 million litres per day"]$mq$, 0, $mq$New demand = 200 × 0.9 = 180. New supply = 160 + 12 = 172. Shortfall = 180 − 172 = 8 million litres. The measures help but do not fully solve the problem.$mq$, $mq$hard$mq$),
($mq$Evaluate whether higher prices for scarce resources will, by themselves, ensure sustainable consumption.$mq$, $mq$["Yes, because prices solve every problem","No, because prices never affect behaviour","Yes, because all consumers are equally affected","Higher prices can reduce demand and encourage innovation, but poorer people may be hit hardest and other policies such as regulation are also needed"]$mq$, 3, $mq$A strong answer weighs market incentives against fairness and the need for regulation and education.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Consumption, Waste and Resource Security$mq$ and p.name = $mq$Resource Extraction and Consumption$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Ecological footprint$mq$, $mq$The land and sea area needed to supply the resources a population uses and to absorb its waste.$mq$),
($mq$Earth Overshoot Day$mq$, $mq$The date each year when humanity's demand for resources exceeds what the Earth can regenerate that year.$mq$),
($mq$Waste hierarchy$mq$, $mq$Reduce, reuse, recycle, recover, dispose. Prevention is better than disposal.$mq$),
($mq$E-waste$mq$, $mq$Discarded electrical and electronic goods such as phones; contains valuable metals and harmful substances.$mq$),
($mq$Circular economy$mq$, $mq$Products and materials are repaired, reused and recycled so waste is minimised, instead of take-make-dispose.$mq$),
($mq$Landfill problems$mq$, $mq$Uses land, releases methane and can leak pollutants into groundwater.$mq$),
($mq$Resource security$mq$, $mq$Reliable access to enough affordable food, water and energy.$mq$),
($mq$Cape Town Day Zero$mq$, $mq$In 2018 a multi-year drought brought the city close to shutting off municipal water; restrictions cut demand.$mq$),
($mq$Ways to improve resource security$mq$, $mq$Use resources efficiently, reduce leaks, diversify suppliers, store reserves, develop renewables and cooperate internationally.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Consumption, Waste and Resource Security$mq$ and p.name = $mq$Resource Extraction and Consumption$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Consumption is the use of goods, services and resources. As populations grow and incomes rise, global consumption increases and creates waste. This sub-topic explores patterns of consumption, how waste is managed and how countries try to keep their supplies of food, water and energy secure.

## Patterns of consumption
Consumption per person is usually higher in high-income countries, where people can afford more goods, energy and food. Total consumption also depends on the number of people, so large countries with rapidly growing incomes can have a huge impact. The **ecological footprint** measures the area of land and sea needed to supply what people use and absorb the waste they produce. Earth Overshoot Day marks the date each year when humanity has used up more than the planet can renew in that year. When it falls earlier, we are consuming faster.

## Waste
Waste includes household rubbish, industrial waste, food waste, plastics and **e-waste** from electronics. Methods of dealing with waste are ranked in the **waste hierarchy**:
- **Reduce**: avoid creating waste, for example less packaging
- **Reuse**: use items again
- **Recycle**: turn waste into new materials
- **Recover**: for example burning waste to produce energy
- **Dispose**: landfill, the last option
Landfill takes up land, releases methane from rotting waste and can pollute groundwater. Recycling saves raw materials and energy but needs good collection and sorting.

In a **circular economy** products are designed to be repaired, reused and recycled, so materials stay in use. This contrasts with the linear model of take, make, use and dispose. Take-back schemes, repair cafés and pay-as-you-throw charges are examples of policies. Governments can also use bans on single-use items, taxes, and education campaigns.

## Resource security
**Resource security** means having reliable access to enough affordable resources. The three big concerns are:
- **Water security**: Cape Town came close to "Day Zero" in 2018 after a long drought, when the city feared supplies might have to be shut off. Restrictions and public saving helped avoid it.
- **Energy security**: countries that rely heavily on one imported fuel are vulnerable if supply is cut, as European countries found after major gas supply disruptions in 2022.
- **Food security**: access to enough nutritious food depends on farming, prices, transport and conflict.

Strategies to improve security include using supplies more efficiently, reducing leaks, diversifying suppliers, building storage, developing renewable energy and international cooperation.

## Calculating and interpreting data
Recycling rate = recycled amount ÷ total waste × 100. For an energy mix, add only the renewable sources, such as wind, solar and hydro, to find the renewable share. When comparing, always check the units and the base year. If a problem has several steps, work through them carefully, like finding the new demand, then the new supply, then the difference.

## Evaluating solutions
Higher prices for scarce resources can reduce demand, but they may hit poorer households hardest. Regulation and education can help but need enforcement and public support. Technology such as efficient appliances helps, but "rebound effects" can occur if savings lead people to use more. The best strategies combine several tools.

## How this is examined
Tasks may give a table-like description of a city's water supply and demand, a country's energy mix, or a recycling scheme. You calculate percentages, explain why consumption differs between places, and evaluate how well a strategy improves sustainability.

Exam tip: When evaluating, mention more than one scale (individual, community, government) and say which option you think is most effective and why.$mq$ from st;

-- Weather Hazards and Disasters > Tropical Storms and Floods
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Weather Hazards and Disasters$mq$, 5, 4 from public.subjects s where s.slug = $mq$geography$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Tropical Storms and Floods$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$geography$mq$ and p.grade = 5 and p.name = $mq$Weather Hazards and Disasters$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Tropical Storms and Floods$mq$ and p.name = $mq$Weather Hazards and Disasters$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the minimum sea surface temperature usually needed for a tropical storm to form?$mq$, $mq$["About 26.5°C","About 5°C","About 15°C","About 50°C"]$mq$, 0, $mq$Warm water provides the heat and moisture that power the storm.$mq$, $mq$easy$mq$),
($mq$In the north-west Pacific Ocean, a tropical storm is called a$mq$, $mq$["Hurricane","Tornado","Blizzard","Typhoon"]$mq$, 3, $mq$Hurricane is used in the Atlantic and north-east Pacific, typhoon in the north-west Pacific, and cyclone in the Indian and south Pacific oceans.$mq$, $mq$easy$mq$),
($mq$What is the calm, clear centre of a tropical storm called?$mq$, $mq$["The eyewall","The front","The eye","The ridge"]$mq$, 2, $mq$The eye has sinking air and light winds. The eyewall around it has the strongest winds and heaviest rain.$mq$, $mq$easy$mq$),
($mq$A storm surge is$mq$, $mq$["A very large wave caused by an earthquake","A rise in sea level caused by strong winds and low pressure pushing water towards the coast","A heavy shower in the mountains","A slow tide on a calm day"]$mq$, 1, $mq$Storm surges often cause the most deaths in tropical storms because of coastal flooding.$mq$, $mq$easy$mq$),
($mq$Which is the main cause of river flooding?$mq$, $mq$["More water enters the river than its channel can hold, for example after prolonged or intense rain","A drop in air temperature","A lack of rainfall","A decrease in surface run-off"]$mq$, 0, $mq$Flooding occurs when discharge exceeds channel capacity.$mq$, $mq$easy$mq$),
($mq$Why do tropical storms lose strength when they move over land?$mq$, $mq$["The land is warmer than the sea","The air over land is moister","The Coriolis effect increases","They are cut off from the warm ocean water that supplies their energy"]$mq$, 3, $mq$Heat and moisture from the sea power the storm. Friction with land also slows the winds.$mq$, $mq$medium$mq$),
($mq$Hurricane Katrina struck the US Gulf Coast in August 2005. Which factor made the flooding in New Orleans so severe?$mq$, $mq$["A volcanic eruption","A tsunami","Storm surge and failures of levees (flood walls) protecting a city partly below sea level","Lack of any warning"]$mq$, 2, $mq$Much of New Orleans lies below sea level and the levees failed in several places, flooding large areas.$mq$, $mq$medium$mq$),
($mq$Why are tropical storms rarely seen close to the Equator?$mq$, $mq$["The sea is too cold","The Coriolis effect is too weak there to make the storm spin","There is no ocean there","There is too much land"]$mq$, 1, $mq$Coriolis force is needed to give the spin. It is zero at the Equator, so storms form at least about 5° away.$mq$, $mq$medium$mq$),
($mq$Typhoon Haiyan hit the Philippines in November 2013. Which impact was most severe?$mq$, $mq$["A powerful storm surge and winds destroyed coastal communities, with more than 6,000 deaths","Mild winds with no damage","A drought across the whole country","A volcanic eruption alongside it"]$mq$, 0, $mq$Haiyan was one of the strongest tropical cyclones recorded at landfall, and the storm surge was especially deadly in Tacloban.$mq$, $mq$medium$mq$),
($mq$Which factor increases flood risk in an urban area?$mq$, $mq$["Many trees and parks","Wide natural floodplains","Soil that absorbs water easily","Large areas of impermeable surfaces like roads and roofs that speed up run-off"]$mq$, 3, $mq$Concrete and tarmac stop infiltration, so rain reaches rivers faster, giving a short lag time and higher peak flow.$mq$, $mq$medium$mq$),
($mq$A river's peak discharge rose from 80 m³/s to 140 m³/s after heavy rain. What was the percentage increase?$mq$, $mq$["43%","60%","75%","175%"]$mq$, 2, $mq$Increase 60 ÷ 80 × 100 = 75%. 43% divides by the new value.$mq$, $mq$medium$mq$),
($mq$Which is an example of SOFT engineering to reduce flood risk?$mq$, $mq$["Building a concrete flood wall","Afforestation in the upper catchment and floodplain zoning","Dredging and straightening the channel","Building a large dam"]$mq$, 1, $mq$Soft engineering works with natural processes. Walls, dredging and dams are hard engineering.$mq$, $mq$medium$mq$),
($mq$In Bangladesh, a cyclone preparedness programme uses volunteers, warning flags and shelters. What impact has this had?$mq$, $mq$["Deaths from major cyclones have fallen greatly compared with the 1970 Bhola cyclone","No effect on deaths","It makes cyclones weaker","It replaces the need for shelters"]$mq$, 0, $mq$The Bhola cyclone killed an estimated several hundred thousand people. Better warnings and shelters have cut loss of life in later storms.$mq$, $mq$medium$mq$),
($mq$In 2022 severe monsoon flooding in Pakistan affected tens of millions of people. Which combination of causes is most accurate?$mq$, $mq$["Only an earthquake","Only drought","Only a tsunami","Extremely heavy monsoon rain together with glacier melt, and vulnerable low-lying communities"]$mq$, 3, $mq$Floods had natural causes but human vulnerability such as poverty and poor infrastructure increased the impact.$mq$, $mq$hard$mq$),
($mq$Two coastal towns face the same storm. Town A has a sea wall, shelters and an early-warning system. Town B has none. Which statement best explains the likely difference in impact?$mq$, $mq$["Town B has lower vulnerability","The hazard is different in each town","Town A has lower vulnerability and greater capacity to cope, so losses should be smaller","Town A will be hit harder because it has a wall"]$mq$, 2, $mq$The hazard is the same but risk depends on vulnerability and capacity to cope.$mq$, $mq$hard$mq$),
($mq$A government must choose between building a 10 km flood wall (high cost, protects one city) and restoring wetlands and reforesting a catchment (lower cost, slower benefit, wider effects). Which judgement is most balanced?$mq$, $mq$["The wall is perfect and needs no maintenance","The wall protects quickly but may fail and shift flooding downstream; catchment restoration is cheaper and sustainable but slower, so a combination may be best","Wetland restoration has no benefits","Neither option can reduce flood risk"]$mq$, 1, $mq$Good evaluation compares speed, cost, sustainability, who benefits and who may lose.$mq$, $mq$hard$mq$),
($mq$A student claims: 'Because a hurricane caused fewer deaths in a rich country than a similar storm in a poor country, the storm in the rich country was weaker.' What is the best critique?$mq$, $mq$["Death tolls depend on vulnerability, preparation and response, so they do not measure storm strength alone","Rich countries never have storms","Death tolls are exactly equal to storm strength","Poor countries do not have warnings"]$mq$, 0, $mq$Hazard strength and disaster impact are different. Compare wind speed, surge height and exposure as well.$mq$, $mq$hard$mq$),
($mq$Evaluate whether climate change will make tropical storm disasters worse.$mq$, $mq$["It will certainly make every storm stronger and nothing else matters","Climate change has no connection with seas","Storms depend only on land temperature","Warmer seas may increase storm intensity and rainfall and rising sea levels raise surge risk, but the impact also depends on population growth in coastal areas and preparedness"]$mq$, 3, $mq$Strong answers distinguish the hazard from the disaster, mention both physical and human factors and acknowledge uncertainty about storm frequency.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Tropical Storms and Floods$mq$ and p.name = $mq$Weather Hazards and Disasters$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Tropical storm formation$mq$, $mq$Sea surface at about 26.5°C or more, at least about 5° from the Equator for Coriolis spin, and low wind shear.$mq$),
($mq$Hurricane, typhoon, cyclone$mq$, $mq$Same type of storm: hurricane (Atlantic, NE Pacific), typhoon (NW Pacific), cyclone (Indian and S Pacific).$mq$),
($mq$Eye and eyewall$mq$, $mq$Eye: calm centre with sinking air. Eyewall: ring of strongest winds and heaviest rain.$mq$),
($mq$Storm surge$mq$, $mq$A rise in sea level from wind and low pressure pushing water ashore; often the deadliest effect of a tropical storm.$mq$),
($mq$Hazard vs disaster$mq$, $mq$A hazard is a natural event that could cause harm. A disaster occurs when it causes serious loss to people.$mq$),
($mq$Causes of river floods$mq$, $mq$Heavy rain, snowmelt, impermeable surfaces, deforestation, urbanisation and building on floodplains.$mq$),
($mq$Hard vs soft engineering$mq$, $mq$Hard: walls, levees, dams. Soft: afforestation, wetlands, zoning, warnings. Soft is often cheaper and more sustainable.$mq$),
($mq$Hurricane Katrina 2005$mq$, $mq$Storm surge and levee failure flooded New Orleans, which is partly below sea level.$mq$),
($mq$Risk$mq$, $mq$Depends on hazard, vulnerability and capacity to cope. High vulnerability and low capacity raise risk.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Tropical Storms and Floods$mq$ and p.name = $mq$Weather Hazards and Disasters$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Weather hazards are extreme events such as tropical storms, floods, droughts and wildfires. A **hazard** is a natural event that could cause harm; a **disaster** happens when a hazard seriously affects people, property or the environment. A hurricane over empty ocean is a hazard but not a disaster.

## Tropical storms
A tropical storm is an intense low-pressure system with strong winds and heavy rain. They are called hurricanes in the Atlantic and north-east Pacific, typhoons in the north-west Pacific and cyclones in the Indian and south Pacific oceans.

Conditions for formation:
- sea surface temperature of about 26.5°C or more, over a depth of tens of metres
- a location at least about 5° from the Equator, so the Coriolis effect can make the storm spin
- low wind shear, so the storm can grow upright
Warm moist air rises, condenses and releases heat, which drives more rising air. The centre, the **eye**, has sinking air and calm weather; the **eyewall** around it has the strongest winds. Storms weaken over land or cold water because they lose their energy source.

## Impacts
Primary impacts include destroyed buildings and deaths from strong winds and flooding. The **storm surge**, a rise in sea level driven by wind and low pressure, is often the deadliest part. Secondary impacts include disease, loss of jobs and long-term economic damage. Hurricane Katrina (August 2005) flooded much of New Orleans after levees failed. Typhoon Haiyan (November 2013) devastated parts of the Philippines, with more than 6,000 deaths, mostly from the surge. Bangladesh has reduced deaths since the Bhola cyclone of 1970 by building shelters, using volunteers and issuing warnings.

## Floods
River floods occur when more water enters a river than the channel can carry. Causes:
- physical: heavy or prolonged rain, snowmelt, steep impermeable catchments
- human: deforestation, urbanisation with impermeable surfaces, poor drainage and building on floodplains
Pakistan's 2022 monsoon floods, which affected tens of millions of people, combined extreme rain, glacier melt and vulnerable communities.

## Managing floods
- **Hard engineering**: flood walls, levees, dams and channel straightening. Effective locally but expensive and can move flooding downstream.
- **Soft engineering**: afforestation, wetland restoration, floodplain zoning and flood warnings. Often cheaper and more sustainable, but slower.
Warnings only work if people receive them and know what to do.

## Hazard, vulnerability and risk
Risk depends on the hazard, how vulnerable people are, and their capacity to cope. This is why a similar storm can cause very different results in different places. Poverty, poor housing and weak governance increase vulnerability.

## Percentage change practice
Peak discharge rising from 80 to 140 m³/s is an increase of 60 ÷ 80 × 100 = 75%. Always divide by the starting value.

## How this is examined
You may get a storm track map, a hydrograph or a short news article. You describe patterns, explain causes, compare impacts in countries at different income levels and evaluate management. Link physical processes to human choices.

Exam tip: Separate the hazard from the disaster. A strong answer says the storm was the same strength but the impact differed because of vulnerability and preparation.$mq$ from st;

-- Weather Hazards and Disasters > Droughts, Wildfires and Risk Reduction
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Weather Hazards and Disasters$mq$, 5, 4 from public.subjects s where s.slug = $mq$geography$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Droughts, Wildfires and Risk Reduction$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$geography$mq$ and p.grade = 5 and p.name = $mq$Weather Hazards and Disasters$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Droughts, Wildfires and Risk Reduction$mq$ and p.name = $mq$Weather Hazards and Disasters$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a drought?$mq$, $mq$["A prolonged period of below-average rainfall causing water shortage","A very heavy rainstorm","A short hot afternoon","A flood in a desert"]$mq$, 0, $mq$Droughts develop slowly and last weeks, months or years, and can affect farming, water supplies and ecosystems.$mq$, $mq$easy$mq$),
($mq$Which of the following is a main ingredient of a wildfire?$mq$, $mq$["Heavy rain, ice and snow","Only wet soil","Calm seas","Fuel such as dry vegetation, heat or an ignition source, and oxygen"]$mq$, 3, $mq$Fire needs fuel, heat and oxygen. Dry vegetation, high temperatures and wind make wildfires spread.$mq$, $mq$easy$mq$),
($mq$A drought that reduces soil moisture and harms crop growth is called$mq$, $mq$["A meteorological drought","A flash flood","An agricultural drought","A cold snap"]$mq$, 2, $mq$Meteorological drought = lack of rain. Agricultural drought = effects on crops. Hydrological drought = low rivers and reservoirs.$mq$, $mq$easy$mq$),
($mq$Which of these increases the risk of wildfires?$mq$, $mq$["Cool, wet weather","Hot, dry, windy weather and a build-up of dead vegetation","Frequent rainfall","Bare concrete surfaces only"]$mq$, 1, $mq$Dry fuel ignites easily and wind carries flames and embers quickly.$mq$, $mq$easy$mq$),
($mq$Which is a good example of a firebreak?$mq$, $mq$["A cleared strip of land that stops flames spreading","A pile of dry leaves","A line of petrol containers","A thick forest"]$mq$, 0, $mq$Firebreaks remove fuel to slow or stop the fire's advance.$mq$, $mq$easy$mq$),
($mq$Between 2020 and 2023 several rainy seasons in a row failed across the Horn of Africa. What was the most serious consequence?$mq$, $mq$["Increased harvests","A decrease in food prices","A rise in river flooding everywhere","Crop failure and livestock deaths led to severe food insecurity for millions of people"]$mq$, 3, $mq$Prolonged drought in pastoral and farming areas caused hunger and displacement, worsened by high food prices and conflict.$mq$, $mq$medium$mq$),
($mq$Australia's 'Black Summer' bushfires of 2019-20 burned about 18 million hectares. Which factor helped create these conditions?$mq$, $mq$["Unusually heavy rainfall","Frozen ground","Record heat and a long drought left vegetation extremely dry","Sea ice melting"]$mq$, 2, $mq$Prolonged drought and heat dried the fuel. Strong winds then spread fires, and smoke affected many cities.$mq$, $mq$medium$mq$),
($mq$The Camp Fire in California (November 2018) destroyed the town of Paradise and killed 85 people. Which lesson is most strongly linked to this disaster?$mq$, $mq$["Wildfires can only happen in tropical regions","Communities near forests need effective evacuation plans, warning systems and fire-safe design","Fires are always started by lightning","Warnings are unnecessary"]$mq$, 1, $mq$Rapid fire spread, narrow roads and limited warning time showed the importance of planning for evacuation.$mq$, $mq$medium$mq$),
($mq$Which human activity can contribute to the spread of wildfire risk?$mq$, $mq$["Building homes in forested areas and starting fires carelessly","Planting crops in wet areas","Installing sprinklers in cities","Reducing the amount of dry vegetation"]$mq$, 0, $mq$More people near fire-prone vegetation increases both ignition sources and property exposed to fire.$mq$, $mq$medium$mq$),
($mq$Reservoir storage in a city fell from 600 million m³ to 270 million m³ during a drought. What percentage of storage was lost?$mq$, $mq$["45%","122%","330%","55%"]$mq$, 3, $mq$Loss = 330. 330 ÷ 600 × 100 = 55%. 45% is the percentage that remains.$mq$, $mq$medium$mq$),
($mq$Which of these is a short-term response to drought?$mq$, $mq$["Building a new reservoir","Breeding drought-resistant crops","Water restrictions and emergency food aid","Rewriting land-use laws"]$mq$, 2, $mq$Short-term responses address immediate needs. Reservoirs, new crops and legislation are long-term.$mq$, $mq$medium$mq$),
($mq$Which is an example of a long-term drought adaptation?$mq$, $mq$["Importing emergency water for a week","Developing drought-resistant crops and efficient irrigation","Praying for rain only","Ignoring weather forecasts"]$mq$, 1, $mq$Adaptation reduces vulnerability over time, for example by changing crops and improving water storage.$mq$, $mq$medium$mq$),
($mq$Disaster risk can be described as depending on hazard, vulnerability and capacity to cope. Which action mainly increases capacity to cope?$mq$, $mq$["Training communities and building emergency shelters and stores","Building more homes on a floodplain","Reducing emergency funding","Ignoring warnings"]$mq$, 0, $mq$Capacity to cope includes skills, resources, institutions and preparedness.$mq$, $mq$medium$mq$),
($mq$The Sendai Framework (2015-2030) is an international agreement that aims to$mq$, $mq$["Stop all natural hazards","Remove all forests","End all migration","Reduce disaster risk and losses by improving understanding of risk, governance and preparedness"]$mq$, 3, $mq$It sets priorities for countries to reduce disaster losses rather than preventing hazards.$mq$, $mq$hard$mq$),
($mq$A town has one road out and is surrounded by dry forest. A resident says: 'Spending on forest clearing, warning sirens and evacuation drills is wasted because fires cannot be stopped.' What is the best response?$mq$, $mq$["The resident is right since hazards cannot be altered","The measures will stop all fires","These measures cannot stop fires but can reduce deaths and damage by lowering vulnerability and improving response","Only more roads matter"]$mq$, 2, $mq$Risk reduction does not remove the hazard, but it reduces the impact. Evidence supports preparedness.$mq$, $mq$hard$mq$),
($mq$Compare two droughts of similar rainfall deficit. Country P has irrigation, crop insurance and grain stores. Country Q relies on rain-fed farming and has no reserves. Which prediction is most reasonable?$mq$, $mq$["Both will have identical impacts","Country Q will suffer more severe food shortages because it is more vulnerable","Country P will be hit harder","Neither will be affected"]$mq$, 1, $mq$Impact depends on vulnerability and resilience as well as the hazard. Safety nets reduce losses.$mq$, $mq$hard$mq$),
($mq$A region's wildfire frequency has doubled over 30 years. Which interpretation is most appropriate?$mq$, $mq$["Several factors, such as climate warming, land-use change and fire management, may be involved and should be examined","It must be caused only by arsonists","It proves rainfall has increased","It cannot be explained at all"]$mq$, 0, $mq$Wildfire trends result from interacting factors. Good geography avoids single-cause explanations.$mq$, $mq$hard$mq$),
($mq$Evaluate: 'Governments should spend more on preparing for hazards than on responding after they happen.'$mq$, $mq$["Preparation is useless because disasters are random","Only response matters","Only the poorest countries should prepare","Preparedness usually costs less than recovery and saves lives, but responses are still needed for unavoidable events, so a balance is wise"]$mq$, 3, $mq$Studies of disaster risk reduction suggest investment in prevention gives high returns, but no system removes all risk.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Droughts, Wildfires and Risk Reduction$mq$ and p.name = $mq$Weather Hazards and Disasters$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Three types of drought$mq$, $mq$Meteorological (lack of rain), agricultural (low soil moisture for crops), hydrological (low rivers and reservoirs).$mq$),
($mq$Impacts of drought$mq$, $mq$Crop failure, livestock loss, food and water shortages, higher prices, wildfires, migration and conflict.$mq$),
($mq$Wildfire needs$mq$, $mq$Fuel (dry vegetation), heat or ignition, and oxygen. Hot, dry, windy weather spreads fire.$mq$),
($mq$Wildfire management$mq$, $mq$Firebreaks, controlled burns, fire-safe building design, early detection, warnings and evacuation plans.$mq$),
($mq$Black Summer 2019-20$mq$, $mq$Australian bushfires that burned about 18 million hectares after record heat and long drought.$mq$),
($mq$Camp Fire 2018$mq$, $mq$California wildfire that destroyed Paradise and killed 85 people; highlighted evacuation and warning planning.$mq$),
($mq$Short-term vs long-term drought responses$mq$, $mq$Short: water restrictions, food aid. Long: drought-resistant crops, efficient irrigation, storage, forecasting.$mq$),
($mq$Risk$mq$, $mq$Depends on hazard, vulnerability and capacity to cope. Reduce vulnerability and raise capacity to cut risk.$mq$),
($mq$Sendai Framework$mq$, $mq$UN agreement (2015-2030) to reduce disaster risk and losses through better understanding, governance and preparedness.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Droughts, Wildfires and Risk Reduction$mq$ and p.name = $mq$Weather Hazards and Disasters$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Droughts and wildfires are weather hazards that develop and spread differently from storms. Droughts are slow-onset hazards; wildfires can spread in minutes. This sub-topic also pulls together how societies reduce the risk from all weather hazards.

## Droughts
A **drought** is a prolonged period of lower-than-normal rainfall that causes water shortage. We distinguish:
- **meteorological** drought: lack of rain
- **agricultural** drought: soil moisture too low for crops
- **hydrological** drought: rivers, lakes and reservoirs fall low
Causes include shifts in atmospheric circulation, natural climate cycles such as El Niño, and long-term climate change. Human factors such as over-extraction of water make impacts worse.

Impacts include crop failure, livestock deaths, food shortages and higher prices, water restrictions, wildfires, migration and sometimes conflict. The Horn of Africa suffered several failed rainy seasons in a row from 2020, and millions faced severe hunger. Responses can be short-term (water restrictions, food aid) and long-term (drought-resistant crops, efficient irrigation, rainwater harvesting, new storage and better forecasting).

## Wildfires
Wildfires need **fuel**, **heat** and **oxygen**. Hot, dry and windy weather dries vegetation and spreads flames. Causes can be natural (lightning) or human (campfires, power lines, arson). Impacts include loss of life, homes and wildlife, air pollution and carbon emissions, and soil erosion afterwards. In Australia's 2019-20 "Black Summer", fires burned about 18 million hectares after record heat and drought. The Camp Fire in California in 2018 destroyed the town of Paradise and killed 85 people, showing the danger when many people live near flammable vegetation and have little warning.

Management: firebreaks and controlled burns to reduce fuel, fire-resistant building design, early detection using satellites, warning and evacuation plans, and public education.

## Disaster risk reduction
Risk depends on the **hazard**, how **vulnerable** people are and their **capacity to cope**. Reducing risk means lowering vulnerability and raising capacity, since we often cannot stop the hazard. Common approaches:
- **Predict**: monitoring and forecasting
- **Protect**: engineering and land-use planning
- **Prepare**: drills, shelters, stores and insurance
- **Plan for recovery**: funding, rebuilding and learning
The Sendai Framework for Disaster Risk Reduction (2015-2030) sets international goals to cut disaster losses.

Wealth is important but not everything. Well-organised communities with good warning systems, such as in Bangladesh, can protect people even where incomes are low.

## Analysing data
A reservoir falling from 600 to 270 million m³ has lost (600 − 270) ÷ 600 × 100 = 55%. Check the base value and say clearly what the percentage refers to. When asked about trends in wildfires or droughts, avoid assuming one cause; consider climate, land use and management together.

## How this is examined
Tasks give a news report or a graph of rainfall and reservoir levels. You identify type and causes of a hazard, calculate changes, assess impacts on different groups and recommend or evaluate risk-reduction strategies.

Common mistakes: confusing hazard with disaster; blaming a single cause; assuming that hard engineering is always best; giving only short-term responses.

Exam tip: Match each strategy to its time scale and stakeholder, then judge which gives the best balance of cost, effectiveness and sustainability.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('geography')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;