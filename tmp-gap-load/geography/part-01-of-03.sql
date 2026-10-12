-- Part 1 of 3: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Managing Natural Environments > Forests and Grasslands
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Managing Natural Environments$mq$, 5, 1 from public.subjects s where s.slug = $mq$geography$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Forests and Grasslands$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$geography$mq$ and p.grade = 5 and p.name = $mq$Managing Natural Environments$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Forests and Grasslands$mq$ and p.name = $mq$Managing Natural Environments$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which layer of a tropical rainforest receives the most sunlight and contains the tallest trees?$mq$, $mq$["The emergent layer","The forest floor","The understorey","The shrub layer"]$mq$, 0, $mq$Emergent trees poke above the main canopy and get the most direct sunlight. The forest floor is the darkest layer.$mq$, $mq$easy$mq$),
($mq$Which of these is a typical feature of savanna grassland?$mq$, $mq$["Rain falling evenly all year with dense tree cover","Permanently frozen soil","Almost no rainfall at all","A wet season and a dry season with scattered trees"]$mq$, 3, $mq$Savannas have a strongly seasonal climate. Dense year-round tree cover describes rainforest, not savanna.$mq$, $mq$easy$mq$),
($mq$Which human activity is a major cause of rainforest loss in the Amazon basin?$mq$, $mq$["Building ski resorts","Mining sea salt","Clearing land for cattle ranching and soy farming","Planting mangroves"]$mq$, 2, $mq$Forest is cleared for pasture and crops such as soy. Ski resorts and sea salt have no link to the Amazon.$mq$, $mq$easy$mq$),
($mq$What does the term deforestation mean?$mq$, $mq$["The natural growth of new trees after a fire","The permanent removal of forest so the land can be used for something else","Planting trees in a city park","Cutting only the dead branches from trees"]$mq$, 1, $mq$Deforestation means forest is removed and not allowed to regrow as forest. Planting trees is the opposite process.$mq$, $mq$easy$mq$),
($mq$Why is the soil under a tropical rainforest often described as nutrient-poor even though the forest is lush?$mq$, $mq$["Most nutrients are stored in the living plants and the thin litter layer, not in the soil","The soil contains no organic matter at all","Rainforest soil is frozen for most of the year","Nutrients are stored deep in rock layers below the forest"]$mq$, 0, $mq$Heat and moisture make dead material decompose fast and plants absorb nutrients quickly, so little is stored in the soil.$mq$, $mq$easy$mq$),
($mq$In a rainforest, leaf litter decomposes within weeks. What is the main reason?$mq$, $mq$["The forest floor is very cold","Few organisms live in the forest","There is no rain to wash leaves away","Warm, humid conditions allow decomposers to work very quickly"]$mq$, 3, $mq$Constant heat and moisture favour bacteria and fungi, so nutrients are recycled rapidly back into plants.$mq$, $mq$medium$mq$),
($mq$A farmer clears rainforest and grows crops. After three or four years yields fall sharply. What is the best explanation?$mq$, $mq$["The crops need more shade than the forest gave","The soil became too rich in nutrients","The nutrients that were held in the trees have gone and heavy rain washes the rest from the exposed soil","Rainfall stopped completely after the trees were removed"]$mq$, 2, $mq$Removing the trees breaks the nutrient cycle. Exposed soil is leached and eroded by heavy rain, so fertility drops quickly.$mq$, $mq$medium$mq$),
($mq$Which approach is an example of sustainable forest management?$mq$, $mq$["Clear-felling a whole valley and leaving it","Selective logging with replanting and a ban on clear-felling steep slopes","Burning the forest to make charcoal then abandoning the site","Logging only the youngest trees so they regrow faster"]$mq$, 1, $mq$Selective logging with replanting keeps the forest cover and its functions. Removing young trees or clear-felling ruins the future supply.$mq$, $mq$medium$mq$),
($mq$Forest certification schemes such as the Forest Stewardship Council (FSC) mainly aim to$mq$, $mq$["Let buyers identify wood products that come from responsibly managed forests","Ban all timber trade worldwide","Pay governments to stop all farming","Replace forests with plantations"]$mq$, 0, $mq$FSC labels tell consumers the wood came from a forest managed to agreed environmental and social standards. They do not ban trade.$mq$, $mq$medium$mq$),
($mq$The Great Plains of North America are temperate grassland. What is the main reason trees are scarce there?$mq$, $mq$["The soil is permanently frozen","Temperatures never rise above 0°C","There is too much rain for trees","Rainfall is too low and too variable to support forest, but enough for grasses"]$mq$, 3, $mq$Grasslands lie where rainfall is moderate to low and variable. Grasses cope with drought and grazing better than trees.$mq$, $mq$medium$mq$),
($mq$During the 1930s, large dust storms struck the US Great Plains (the Dust Bowl). Which combination of causes is most accurate?$mq$, $mq$["An earthquake that broke up the soil","A rise in sea level","Drought together with ploughing up grassland and poor farming practice that left soil bare","Over-use of the land for ice skating"]$mq$, 2, $mq$Deep ploughing removed the grass roots that held soil in place, and when drought arrived the dry topsoil was blown away.$mq$, $mq$medium$mq$),
($mq$Overgrazing on savanna grassland can lead to$mq$, $mq$["Thicker grass and richer soil","Bare ground, soil erosion and loss of grass cover","More rain in the dry season","Higher biodiversity of grasses"]$mq$, 1, $mq$Too many animals remove the plant cover faster than it regrows, leaving soil exposed to wind and rain.$mq$, $mq$medium$mq$),
($mq$Some savanna managers use controlled (prescribed) burning. Which is the best reason?$mq$, $mq$["It clears dead grass, recycles nutrients and reduces the risk of a larger uncontrolled fire","It permanently removes all grass","It increases the amount of carbon in the soil immediately","It stops the wet season"]$mq$, 0, $mq$Small planned burns remove fuel so a later fire is less intense, and ash returns nutrients. Many savanna species are adapted to fire.$mq$, $mq$medium$mq$),
($mq$A government wants to protect a forest but local villagers rely on it for firewood and farmland. Which strategy is most likely to succeed long term?$mq$, $mq$["Fence off the forest and ban all access without compensation","Allow unlimited logging so villagers earn income","Ignore the villagers and rely on satellite monitoring only","Involve villagers in management, for example agroforestry and community-run reserves with legal use rights"]$mq$, 3, $mq$Schemes work best when local people gain from conservation. Strict exclusion often fails because people have no alternative livelihood.$mq$, $mq$hard$mq$),
($mq$A forest area measured 1,000 km² in Year 1 and 880 km² in Year 6. What is the average percentage loss per year (to 1 decimal place), assuming equal loss each year?$mq$, $mq$["12.0%","1.2%","2.4%","2.0%"]$mq$, 2, $mq$Loss = 120 km², which is 12% of 1,000. Spread over 5 years that is 12 ÷ 5 = 2.4% of the original area per year. 12% is the total loss, not the yearly figure.$mq$, $mq$hard$mq$),
($mq$Satellite images show a straight line of cleared forest with many smaller branches coming off it, like a fishbone. What is the most likely cause?$mq$, $mq$["A natural lightning strike","A new road that opened the forest to settlers, farmers and loggers","A river changing its course","A volcanic eruption"]$mq$, 1, $mq$A fishbone deforestation pattern is typical along a road, because access allows people to clear side tracks.$mq$, $mq$hard$mq$),
($mq$Evaluate: Banning all logging in a tropical country is the best way to protect its rainforest. Which response gives the strongest judgement?$mq$, $mq$["It protects trees in the short term but may cost jobs and cause illegal logging unless alternatives and enforcement are provided","It is perfect because logging has no benefits","It fails because forests do not need protection","It works only for grasslands, so it is irrelevant"]$mq$, 0, $mq$A strong answer weighs benefits and drawbacks and refers to enforcement and alternative incomes, not just one side.$mq$, $mq$hard$mq$),
($mq$A scientist compares two plots. Plot A is intact rainforest. Plot B was cleared 5 years ago for pasture. Soil temperature is 6°C higher in Plot B and its river runs muddier. Which conclusion is best supported?$mq$, $mq$["Plots A and B must have identical ecosystems","The river is muddier because Plot A has more trees","The data prove that all pasture is bad for the climate everywhere","Removing the canopy reduced shade and protection, increasing heating and soil erosion"]$mq$, 3, $mq$Evidence supports a link between canopy removal and heating and erosion in this comparison. It cannot be generalised to all pastures from two plots.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Forests and Grasslands$mq$ and p.name = $mq$Managing Natural Environments$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Biome$mq$, $mq$A large ecosystem defined by its climate, soils, plants and animals, such as tropical rainforest or savanna.$mq$),
($mq$Rainforest nutrient cycle$mq$, $mq$Nutrients are held mainly in living plants and litter. Dead matter decomposes fast and roots take nutrients up quickly, so soils are thin and poor.$mq$),
($mq$Rainforest layers$mq$, $mq$Emergent, canopy, understorey and forest floor. Most species live in the canopy.$mq$),
($mq$Main causes of Amazon deforestation$mq$, $mq$Cattle ranching, soy farming, logging, mining, roads and settlement.$mq$),
($mq$Effects of deforestation$mq$, $mq$Soil erosion and leaching, loss of biodiversity, carbon released, changed local rainfall and loss of Indigenous livelihoods.$mq$),
($mq$Savanna climate$mq$, $mq$Tropical grassland with a distinct wet and dry season, scattered trees and frequent natural fires, e.g. the Serengeti.$mq$),
($mq$Dust Bowl$mq$, $mq$1930s dust storms on the US Great Plains caused by drought plus ploughing up grassland, leaving bare soil to blow away.$mq$),
($mq$Sustainable forest management$mq$, $mq$Using forest so it can continue to provide resources: selective logging, replanting, certification, agroforestry and involving local people.$mq$),
($mq$REDD+$mq$, $mq$Payments to countries for reducing emissions from deforestation and forest degradation, rewarding them for keeping forests standing.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Forests and Grasslands$mq$ and p.name = $mq$Managing Natural Environments$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Forests and grasslands are two of the world's major biomes. A biome is a large ecosystem defined by its climate, soils, plants and animals. At MYP 5 you need to describe where these environments are found, explain how they work, and evaluate how humans use and manage them.

## Tropical rainforests
Tropical rainforests grow near the Equator, in places such as the Amazon basin, the Congo basin and Southeast Asia. They are hot (about 25-28°C) and wet (often more than 2,000 mm of rain a year) with little seasonal change. The forest has layers: the **emergent** trees at the top, the dense **canopy**, the **understorey**, and the dark forest floor. Most animal species live in the canopy.

The **nutrient cycle** is fast. Dead leaves decompose within weeks, and roots quickly take the nutrients up again. Most nutrients are stored in the biomass (living plants) rather than in the soil. This is why the soil is poor, even though the forest looks so rich.

## Threats and impacts
Causes of deforestation include cattle ranching, soy and palm-oil plantations, logging, mining, roads and settlement. When trees are removed:
- the nutrient cycle is broken and soil is leached and eroded
- less water is returned to the air, so local rainfall can fall
- carbon stored in trees is released, adding to climate change
- habitats and biodiversity are lost, and Indigenous communities lose their homes

## Grasslands
**Savanna** grassland (for example the Serengeti in Tanzania and Kenya) is found in tropical areas with a wet and a dry season. It has tall grasses, scattered trees and large grazing animals. Fire is a natural part of the system. **Temperate grassland** (for example the prairies of the US Great Plains and the steppe of Eurasia) has hot summers, cold winters and moderate rainfall. Its deep, dark soils are very fertile, so much of it has been turned into farmland.

The 1930s **Dust Bowl** in the USA shows what can go wrong. Farmers ploughed up native grasses, then drought arrived and the exposed soil blew away in huge storms. Grassland is also damaged by overgrazing, where animals eat plants faster than they regrow.

## Managing forests and grasslands sustainably
Sustainable management meets today's needs without harming the future. Strategies include:
- selective logging with replanting rather than clear-felling
- certification such as FSC so consumers can choose responsible timber
- agroforestry, which mixes trees with crops
- national parks and protected areas, with local people involved
- payments for keeping forest standing (REDD+ schemes)
- controlled burning, crop rotation and limits on livestock numbers on grassland

## Evaluating strategies
Always weigh costs and benefits and ask who is affected. A ban on logging protects trees but may remove jobs and lead to illegal logging if it is not enforced. Schemes that give local people a share of the benefits tend to last longer than ones that simply keep them out.

## How this is examined
Questions usually give a short source such as satellite data, a rainfall graph or a report on a named place. You are asked to describe a pattern, explain causes using geographical terms (nutrient cycle, leaching, erosion), and judge a management plan. Good answers use a named example, state a clear judgement and consider more than one stakeholder.

Common mistakes: saying rainforest soil is fertile; mixing up savanna with desert; writing that all logging is bad without discussing sustainable logging.

Exam tip: When asked to evaluate, name a place, give one benefit and one limitation, and finish with a clear justified judgement.$mq$ from st;

-- Managing Natural Environments > Deserts and Arid Environments
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Managing Natural Environments$mq$, 5, 1 from public.subjects s where s.slug = $mq$geography$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Deserts and Arid Environments$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$geography$mq$ and p.grade = 5 and p.name = $mq$Managing Natural Environments$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Deserts and Arid Environments$mq$ and p.name = $mq$Managing Natural Environments$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which of these best describes a desert?$mq$, $mq$["An area that receives very little precipitation, usually less than about 250 mm a year","An area that is always hot","An area covered only by sand dunes","An area with no living things"]$mq$, 0, $mq$Deserts are defined by low rainfall (aridity), not by temperature or sand. Cold deserts exist and many deserts are mostly rock or gravel.$mq$, $mq$easy$mq$),
($mq$The Sahara is the world's largest hot desert. On which continent is it found?$mq$, $mq$["Asia","Australia","South America","Africa"]$mq$, 3, $mq$The Sahara stretches across northern Africa from the Atlantic Ocean to the Red Sea.$mq$, $mq$easy$mq$),
($mq$Which feature helps a cactus survive in a hot desert?$mq$, $mq$["Large thin leaves to lose heat","Very shallow roots only 1 cm deep","Thick stems that store water and spines instead of leaves","A need for daily rainfall"]$mq$, 2, $mq$Cacti store water in stems, and spines reduce water loss and protect the plant. Large thin leaves would lose too much water.$mq$, $mq$easy$mq$),
($mq$What is desertification?$mq$, $mq$["The natural movement of sand dunes within an existing desert","The process by which fertile land becomes degraded and turns into desert-like land","The building of cities in deserts","The flooding of a desert after rain"]$mq$, 1, $mq$Desertification is land degradation in dry areas, caused by climate and human activity. It is not just dune movement.$mq$, $mq$easy$mq$),
($mq$The Sahel is a region of Africa often linked with desertification. Where is it located?$mq$, $mq$["A semi-arid belt south of the Sahara","On the northern coast of Africa","In the centre of the Amazon basin","In Antarctica"]$mq$, 0, $mq$The Sahel is the transition zone between the Sahara in the north and wetter savanna to the south.$mq$, $mq$easy$mq$),
($mq$Which pair of human activities most directly contributes to desertification in the Sahel?$mq$, $mq$["Fishing and whaling","Tourism and skiing","Building dams and canals on rainforests","Overgrazing and removing trees for fuelwood"]$mq$, 3, $mq$Overgrazing strips plant cover and cutting trees removes roots that hold soil, leaving it exposed to wind and erosion.$mq$, $mq$medium$mq$),
($mq$Which desert animal adaptation reduces water loss?$mq$, $mq$["Sweating heavily to cool down","Drinking large amounts of water every hour","Being active at night and sheltering in burrows during the day","Staying in direct sun at midday"]$mq$, 2, $mq$Nocturnal behaviour avoids the hottest, driest conditions. Heavy sweating would waste water.$mq$, $mq$medium$mq$),
($mq$In the Sahel, farmers dig small planting pits (zaï) filled with compost. How does this help?$mq$, $mq$["It stops all rain from entering the soil","It collects rainwater and nutrients around crop roots so seeds survive in poor soil","It removes the need to plant seeds","It makes the soil salty"]$mq$, 1, $mq$Zaï pits concentrate scarce water and manure near each plant, helping crops grow on degraded land.$mq$, $mq$medium$mq$),
($mq$The Aral Sea in Central Asia shrank dramatically from the 1960s. Which cause is best supported by evidence?$mq$, $mq$["Water from the rivers that fed it was diverted to irrigate cotton and other crops","A huge meteor strike","Melting of the Antarctic ice sheet","Building a bridge over the sea"]$mq$, 0, $mq$The Amu Darya and Syr Darya rivers were diverted for irrigation, so much less water reached the sea. Evaporation then exceeded inflow.$mq$, $mq$medium$mq$),
($mq$Which statement about the Great Green Wall initiative (launched by the African Union in 2007) is accurate?$mq$, $mq$["It is a physical stone barrier along the whole Sahara coast","It aims to flood the Sahara with seawater","It was designed to expand the Sahara southward","It aims to restore degraded land across the Sahel by planting trees and improving land management"]$mq$, 3, $mq$The project is now seen as a mosaic of restoration activities rather than one continuous line of trees.$mq$, $mq$medium$mq$),
($mq$Irrigation in dry regions can cause salinisation. What happens?$mq$, $mq$["Salt is washed away so soil becomes more fertile","Rain becomes saltier","Water evaporates and leaves dissolved salts in the topsoil, making it harder for crops to grow","Crops absorb all the salt and become larger"]$mq$, 2, $mq$In hot dry conditions water evaporates from the surface, leaving salts behind that damage plant roots.$mq$, $mq$medium$mq$),
($mq$Compare drip irrigation with flood irrigation in a desert farm. Which statement is most accurate?$mq$, $mq$["Flood irrigation uses less water than drip irrigation","Drip irrigation delivers water slowly to plant roots and loses much less to evaporation","Drip irrigation works only in rainforests","Both methods lose the same amount of water"]$mq$, 1, $mq$Drip systems target the roots, so less water evaporates or runs off. Flood irrigation wastes more and increases salinisation risk.$mq$, $mq$medium$mq$),
($mq$A village in a semi-arid area sees its grazing land turn to bare soil. Livestock numbers have doubled in 20 years while rainfall has fallen slightly. What is the best explanation?$mq$, $mq$["Grazing pressure exceeded the land's carrying capacity, and lower rainfall reduced regrowth","Rainfall alone caused all the damage","Livestock numbers have no effect on vegetation","The soil is naturally richer than before"]$mq$, 0, $mq$Both factors interact: more animals eat plants faster, and with less rain plants cannot recover, so soil is exposed.$mq$, $mq$medium$mq$),
($mq$A farmer in a dry area earns most income from cattle. An aid agency proposes a limit on herd size. Which is the strongest argument FOR the limit?$mq$, $mq$["It will immediately raise rainfall","It will increase the number of cattle","It guarantees the farmer more profit this year","It reduces overgrazing so pasture can recover and supports long-term income"]$mq$, 3, $mq$Limiting herd size protects the resource base. It may cost income in the short term but supports sustainability.$mq$, $mq$hard$mq$),
($mq$Rainfall in a semi-arid district (mm per year): 2018: 320, 2019: 280, 2020: 240, 2021: 200. What is the percentage decrease from 2018 to 2021?$mq$, $mq$["60%","27.5%","37.5%","62.5%"]$mq$, 2, $mq$Decrease = 120 mm. 120 ÷ 320 × 100 = 37.5%. Dividing by 200 gives 60%, the wrong base, and 62.5% is the share that remains (200 ÷ 320), not the decrease.$mq$, $mq$hard$mq$),
($mq$A study finds that desert plants have roots that spread 10 m wide but only 30 cm deep. Which is the best explanation of this adaptation?$mq$, $mq$["The soil is always wet at depth","Brief rainfall wets only the surface, so wide shallow roots absorb water quickly before it evaporates","The plants need to anchor in bedrock","Wide roots make photosynthesis faster in the dark"]$mq$, 1, $mq$After rare showers water sits near the surface for a short time. Wide shallow roots capture it quickly.$mq$, $mq$hard$mq$),
($mq$Evaluate: Large-scale water-pumping from deep underground aquifers will solve food shortages in a desert country. Which judgement is strongest?$mq$, $mq$["It may boost production in the short term, but if the aquifer is non-renewable the water will eventually run out, so it is not sustainable","It is a perfect long-term solution because underground water is unlimited","It cannot help production at all","It will reduce the need for any water management"]$mq$, 0, $mq$Fossil aquifers recharge extremely slowly, so heavy pumping is effectively mining water. A strong answer weighs short- and long-term outcomes.$mq$, $mq$hard$mq$),
($mq$A conservation team compares two Sahelian villages. Village A built stone lines along field contours and planted trees; Village B did nothing. After 10 years, A's crop yields rose by 40% while B's fell by 5%. Which conclusion is most reasonable?$mq$, $mq$["The data prove stone lines work everywhere in the world","The yield changes were certainly caused by random chance","Tree planting always lowers crop yields","The interventions probably helped, but other factors such as rainfall and soil should be checked before generalising"]$mq$, 3, $mq$The comparison is suggestive but two villages are a small sample. Good geographers note limitations before generalising.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Deserts and Arid Environments$mq$ and p.name = $mq$Managing Natural Environments$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Desert (geographical definition)$mq$, $mq$An area with very low precipitation, usually under about 250 mm a year. Can be hot (Sahara) or cold (Gobi).$mq$),
($mq$Why hot deserts form near 15°-35° latitude$mq$, $mq$Air that rose at the Equator sinks here as dry air, giving clear skies and little rain.$mq$),
($mq$Desertification$mq$, $mq$Degradation of dryland soils into desert-like land, caused by climate variation and human activities such as overgrazing.$mq$),
($mq$Sahel$mq$, $mq$A semi-arid belt south of the Sahara in Africa, often used as an example of desertification.$mq$),
($mq$Causes of desertification$mq$, $mq$Overgrazing, overcultivation, removing trees for fuel, drought and climate change, population pressure.$mq$),
($mq$Salinisation$mq$, $mq$Salts left in topsoil when irrigation water evaporates in hot dry conditions, harming crops.$mq$),
($mq$Aral Sea$mq$, $mq$Central Asian lake that shrank from the 1960s after rivers feeding it were diverted for irrigation, leading to salty dust and a collapsed fishing industry.$mq$),
($mq$Zaï pits$mq$, $mq$Small planting pits filled with compost used in the Sahel to trap water and nutrients near crops.$mq$),
($mq$Great Green Wall$mq$, $mq$African Union initiative launched in 2007 to restore degraded land across the Sahel through tree planting and land management.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Deserts and Arid Environments$mq$ and p.name = $mq$Managing Natural Environments$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Deserts and arid environments are places where evaporation is higher than rainfall and water is the main limit on life. In geography we usually say a desert gets less than about 250 mm of precipitation a year. Being dry does not mean being hot: the Gobi and the Antarctic interior are cold deserts, while the Sahara and the Australian deserts are hot ones. Many deserts are rock or gravel, not just sand.

## Where and why
Hot deserts are concentrated around 15° to 35° north and south of the Equator. Air rises at the Equator, loses its moisture as rain, then sinks over these latitudes as dry air, which suppresses cloud and rain. Other deserts are found in the rain shadow of mountains, or far inland where moist air rarely reaches.

## Plant and animal adaptations
Organisms survive with clever adaptations:
- **Cacti** store water in thick stems, have spines instead of leaves to cut water loss, and have wide shallow roots to catch short showers.
- Many animals are **nocturnal**, sheltering in burrows by day to avoid heat and water loss.
- Camels can tolerate large losses of body water and store fat in the hump.
- Some seeds lie dormant for years and germinate only after rain.

## Desertification
**Desertification** is land degradation in dry areas caused by climate variation and human activities. The Sahel, the semi-arid belt south of the Sahara, is a well-known example. Causes include:
- **Overgrazing**: too many livestock strip the vegetation
- **Overcultivation**: crops without rest or fertiliser exhaust the soil
- **Deforestation** for fuelwood, which removes roots that bind soil
- **Climate change** and droughts, which reduce plant growth
- Population growth, which increases pressure on the land

Effects include soil erosion, falling food production, hunger and migration of people.

## Case study: the Aral Sea
Until the 1960s the Aral Sea in Central Asia was one of the world's largest lakes. Water from the Amu Darya and Syr Darya rivers was diverted to irrigate crops such as cotton. Much less water reached the sea, which shrank dramatically. The result was a salty, dusty exposed seabed, a collapse of the fishing industry and health problems for local people. It shows how poorly planned irrigation can harm an environment and a local economy.

## Managing arid environments
Strategies include:
- **Drip irrigation** and efficient water use to avoid salinisation and waste
- **Stone lines and zaï pits** that trap water and soil
- **Tree planting and agroforestry**, as in the African Union's Great Green Wall initiative (launched in 2007), which supports land restoration across the Sahel
- Controlled grazing and fencing to let vegetation recover
- Using appropriate technology that local people can afford and maintain

Solutions work best when communities help to plan them, because they know the land and must keep the projects going.

## How this is examined
Typical tasks present rainfall data or a short article about a dryland place. You calculate changes (for example a percentage decrease), explain causes of desertification, and evaluate a management scheme. You should refer to a named example and consider short-term and long-term impacts.

Common mistakes: saying all deserts are hot, or that deserts are lifeless; blaming only climate or only people when both usually contribute.

Exam tip: For an evaluate question, give a benefit, a drawback and a final judgement about sustainability, and name the place you are discussing.$mq$ from st;

-- Managing Natural Environments > Aquatic and Polar Environments
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Managing Natural Environments$mq$, 5, 1 from public.subjects s where s.slug = $mq$geography$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Aquatic and Polar Environments$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$geography$mq$ and p.grade = 5 and p.name = $mq$Managing Natural Environments$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Aquatic and Polar Environments$mq$ and p.name = $mq$Managing Natural Environments$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What are coral reefs mainly built by?$mq$, $mq$["Tiny animals called coral polyps that form hard limestone skeletons","Underwater volcanoes","Seaweed and kelp forests","Sand deposited by rivers"]$mq$, 0, $mq$Reefs are built over thousands of years by polyps that secrete calcium carbonate skeletons.$mq$, $mq$easy$mq$),
($mq$Which of these is a mangrove forest's main benefit to a tropical coastline?$mq$, $mq$["It makes sea water fresh","It prevents all storms","It creates deep ocean trenches","Its roots reduce wave energy and act as a nursery for young fish"]$mq$, 3, $mq$Mangroves protect coasts from erosion and storm waves, and their roots shelter juvenile fish.$mq$, $mq$easy$mq$),
($mq$Which statement about the Antarctic is correct?$mq$, $mq$["It is an ocean surrounded by land","It is a country with a single government","It is a continent covered by a very thick ice sheet and governed by an international treaty","It is mostly tropical rainforest"]$mq$, 2, $mq$Antarctica is a continent. The Antarctic Treaty (signed in 1959) sets it aside for peaceful purposes and science.$mq$, $mq$easy$mq$),
($mq$What does overfishing mean?$mq$, $mq$["Catching only fish that are too small to sell","Catching fish faster than their populations can reproduce","Using fishing boats in rivers only","Releasing all fish that are caught"]$mq$, 1, $mq$Overfishing reduces breeding stocks, so catches fall and ecosystems are damaged.$mq$, $mq$easy$mq$),
($mq$The Arctic Ocean is mostly covered by$mq$, $mq$["Sea ice that varies in extent through the year","Warm shallow lagoons","Coral reefs","A land ice sheet over bedrock like Antarctica"]$mq$, 0, $mq$The Arctic is an ocean largely covered by floating sea ice. Antarctica is a continent.$mq$, $mq$easy$mq$),
($mq$What is coral bleaching?$mq$, $mq$["When coral grows too fast","When coral is covered in sand","When coral turns green from sunlight","When stressed coral expels the algae living in its tissue, turning white"]$mq$, 3, $mq$The algae give coral its colour and food. Without them the coral turns white and may starve if stress continues.$mq$, $mq$medium$mq$),
($mq$Rising sea temperatures are a major cause of coral bleaching. Which other factor also threatens reefs?$mq$, $mq$["Falling sea levels from lack of rain","Too much oxygen in the water","Ocean acidification, as the sea absorbs extra carbon dioxide from the atmosphere","Reduced fishing"]$mq$, 2, $mq$More dissolved CO₂ makes seawater slightly more acidic, which makes it harder for corals to build skeletons.$mq$, $mq$medium$mq$),
($mq$The Great Barrier Reef stretches along the coast of which country?$mq$, $mq$["Brazil","Australia","Japan","South Africa"]$mq$, 1, $mq$It lies off Queensland in north-eastern Australia and is one of the largest reef systems in the world.$mq$, $mq$medium$mq$),
($mq$Why is the loss of Arctic sea ice a concern for climate?$mq$, $mq$["Dark open water absorbs more sunlight than white ice, which speeds further warming (albedo feedback)","Ice increases the sun's heat absorption","Open water reflects more sunlight than ice","Sea ice has no effect on temperature"]$mq$, 0, $mq$Ice has a high albedo (reflects most sunlight). When it melts the darker ocean absorbs more energy, a positive feedback.$mq$, $mq$medium$mq$),
($mq$In 1992 Canada declared a moratorium on cod fishing off Newfoundland. What does this show?$mq$, $mq$["Cod populations rise when heavily fished","Fish stocks never need monitoring","Fishing quotas always cause collapse","Overfishing can collapse a fishery and damage communities that depend on it"]$mq$, 3, $mq$Northern cod stocks fell sharply after decades of heavy fishing, and thousands of jobs were lost.$mq$, $mq$medium$mq$),
($mq$Which management tool helps fish stocks recover?$mq$, $mq$["Larger nets that catch smaller fish","Removing all quotas","Marine protected areas with no-take zones and enforced catch quotas","Fishing during spawning season"]$mq$, 2, $mq$Protecting breeding areas and limiting catches allows populations to rebuild. Small-mesh nets catch juveniles.$mq$, $mq$medium$mq$),
($mq$The Madrid Protocol (signed in 1991) to the Antarctic Treaty is important mainly because it$mq$, $mq$["Allows oil drilling across the continent","Bans mineral resource activities in Antarctica apart from scientific research","Divides Antarctica between countries","Ends all scientific research"]$mq$, 1, $mq$The protocol designates Antarctica as a natural reserve devoted to peace and science.$mq$, $mq$medium$mq$),
($mq$Permafrost is ground that stays frozen for at least two years. What is the main risk when it thaws in the Arctic?$mq$, $mq$["Buildings and roads can sink, and trapped carbon dioxide and methane may be released","Rivers stop flowing","The sea freezes faster","The ground becomes more stable"]$mq$, 0, $mq$Thawing releases greenhouse gases from decaying organic matter, a feedback, and ground subsidence damages infrastructure.$mq$, $mq$medium$mq$),
($mq$A simplified data set gives Arctic sea ice minimum extent (million km²) as about 7.0 in the 1980s and about 3.7 in 2020. What is the approximate percentage decrease?$mq$, $mq$["53%","3.3%","90%","47%"]$mq$, 3, $mq$Decrease 3.3 ÷ 7.0 × 100 ≈ 47%. 53% is the share that remains, and 3.3 is the difference in million km², not a percentage.$mq$, $mq$hard$mq$),
($mq$A tourist company offers cruises to Antarctica. Which argument best supports limiting the number of visitors?$mq$, $mq$["Cold weather makes tourism boring","Antarctica has no wildlife","Visitors can disturb wildlife and introduce non-native species to a fragile ecosystem","Tourists improve the ice sheet"]$mq$, 2, $mq$Antarctic ecosystems are fragile and recover slowly. Visitor limits and biosecurity rules help protect them.$mq$, $mq$hard$mq$),
($mq$An island nation depends on reef tourism and fishing. After a bleaching event, 30% of its coral dies. Which impact chain is most plausible?$mq$, $mq$["Fish numbers rise because they have more space","Less coral reduces fish habitats, so catches and tourist numbers may fall, hurting incomes","Tourism rises since white coral is attractive","There are no effects because coral is a rock"]$mq$, 1, $mq$Reefs shelter many fish and attract divers, so loss of coral affects both food supply and tourism income.$mq$, $mq$hard$mq$),
($mq$A scientist argues that closing a 20% section of a fishing area to all fishing could raise catches in the surrounding area after some years. Which reasoning best explains this?$mq$, $mq$["Fish in the protected zone grow larger and breed, and some spill over into fished waters","Fish prefer to live in fished areas","Closing an area lowers the number of breeding adults","Larger fish have no effect on reproduction"]$mq$, 0, $mq$No-take zones allow bigger, more fertile fish, and juveniles and adults can move out (spillover). This is often the logic behind marine reserves.$mq$, $mq$hard$mq$),
($mq$Evaluate which strategy gives the best long-term protection for coral reefs.$mq$, $mq$["Banning swimming near reefs only","Building artificial walls around reefs","Increasing fishing to keep fish numbers down","Cutting greenhouse gas emissions combined with local measures such as controlling pollution and fishing"]$mq$, 3, $mq$Warming and acidification are global problems so local action alone is not enough, but local stress reduction helps reefs to recover.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Aquatic and Polar Environments$mq$ and p.name = $mq$Managing Natural Environments$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Coral polyps$mq$, $mq$Tiny animals that build coral reefs from limestone skeletons and live with algae that give them food and colour.$mq$),
($mq$Coral bleaching$mq$, $mq$Stressed coral (often from warm water) expels its algae and turns white; prolonged bleaching can kill the coral.$mq$),
($mq$Ocean acidification$mq$, $mq$Sea water becomes more acidic as it absorbs more CO₂, making it harder for corals and shellfish to form skeletons and shells.$mq$),
($mq$Why mangroves matter$mq$, $mq$Roots reduce wave energy and erosion, trap sediment and shelter young fish, protecting coasts and fisheries.$mq$),
($mq$Overfishing$mq$, $mq$Catching fish faster than stocks can reproduce, e.g. the Newfoundland cod collapse and 1992 fishing moratorium.$mq$),
($mq$Marine protected area$mq$, $mq$A zone of sea where activities are restricted to protect wildlife; no-take zones ban fishing completely.$mq$),
($mq$Arctic vs Antarctic$mq$, $mq$Arctic: an ocean mostly covered by sea ice. Antarctic: a continent under a thick ice sheet.$mq$),
($mq$Albedo feedback$mq$, $mq$Melting ice reveals darker water that absorbs more sunlight, which warms the area and melts more ice.$mq$),
($mq$Antarctic Treaty and Madrid Protocol$mq$, $mq$1959 treaty reserves Antarctica for peace and science; 1991 protocol bans mineral resource activities apart from research.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Aquatic and Polar Environments$mq$ and p.name = $mq$Managing Natural Environments$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Aquatic and polar environments cover the vast majority of our planet's surface and include some of its most fragile ecosystems. In this sub-topic you need to describe how they work, understand the threats, and evaluate management approaches.

## Coral reefs
Coral reefs grow in warm, clear, shallow tropical seas. They are built by **coral polyps**, tiny animals that make limestone skeletons and live in partnership with algae that give them food and colour. Reefs support about a quarter of marine species, protect coasts from waves and support fishing and tourism. The Great Barrier Reef off Queensland, Australia is one of the largest reef systems in the world.

Threats include:
- **Warming seas**, which cause coral bleaching, where corals expel their algae and turn white
- **Ocean acidification**, as the sea absorbs extra carbon dioxide
- Pollution and run-off of fertiliser and sediment
- Overfishing and damage from anchors or destructive fishing

Bleaching events have affected the Great Barrier Reef several times in recent years. Corals can recover if the stress ends soon enough, so reducing other pressures helps.

## Mangroves and wetlands
Mangroves are salt-tolerant trees growing on tropical shorelines. Their tangled roots slow waves, trap sediment and shelter young fish, so they are called nurseries of the sea. They are cleared for shrimp farms and development, which increases coastal flooding risk.

## Fisheries
**Overfishing** means taking fish faster than stocks can replace themselves. When Canada banned cod fishing off Newfoundland in 1992, thousands of jobs were lost and the cod have recovered only slowly. Management tools include quotas, mesh-size rules to avoid catching young fish, **marine protected areas** with no-take zones, and certification such as the Marine Stewardship Council label.

## Polar environments
The **Arctic** is an ocean mostly covered by sea ice, surrounded by land. The **Antarctic** is a continent under a thick ice sheet, surrounded by the Southern Ocean. Both have extreme cold, low precipitation, strong winds and long periods of darkness or daylight. Food chains are short and sensitive; krill is key in the Southern Ocean.

Climate change is warming the poles faster than the global average. Key issues:
- **Albedo feedback**: melting ice exposes dark water that absorbs more heat, causing more melting
- **Permafrost thaw** in the Arctic releases carbon dioxide and methane and damages buildings and roads
- Loss of sea ice affects polar bears, seals and Indigenous communities who hunt on it
- Shipping, oil and gas exploration and tourism add pressure

## Governing the poles
The Antarctic Treaty (signed in 1959) keeps the continent for peaceful and scientific purposes. The Madrid Protocol (signed in 1991) bans mineral resource activities there apart from research. The Arctic has no single treaty. Countries cooperate through bodies such as the Arctic Council, but disagreements over resources and shipping routes remain.

## Evaluating management
Global action on emissions is needed to tackle warming and acidification, while local actions (marine reserves, pollution control, quotas, visitor limits) reduce other stresses and can improve resilience. Strong answers link several scales and use evidence.

## How this is examined
Expect a source about a reef, fishery or polar region, perhaps with a graph of sea ice extent or catch data. You describe trends, calculate percentage change, explain impacts for people and wildlife, and judge a strategy.

Exam tip: Link causes to impacts in a chain (for example warming, then bleaching, then fewer fish, then lower incomes) and finish with a justified judgement.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('geography')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;