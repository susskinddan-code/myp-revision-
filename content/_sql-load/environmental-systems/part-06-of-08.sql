-- Part 6 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Soils and Land Use > Soil Formation and Degradation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Soils and Land Use$mq$, 5, 6 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Soil Formation and Degradation$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Soils and Land Use$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Soil Formation and Degradation$mq$ and p.name = $mq$Soils and Land Use$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which of these is NOT a main component of soil?$mq$, $mq$["Plastic","Mineral particles","Humus (organic matter)","Water and air"]$mq$, 0, $mq$Soil is made of mineral particles, organic matter, water, air and living organisms. Plastic is a pollutant, not a natural component.$mq$, $mq$easy$mq$),
($mq$Which soil horizon is the topsoil, rich in humus and roots?$mq$, $mq$["The C horizon","The bedrock","The B horizon","The A horizon"]$mq$, 3, $mq$The A horizon (topsoil) contains the most organic matter and nutrients. The B horizon is subsoil and the C horizon is weathered parent rock.$mq$, $mq$easy$mq$),
($mq$Which particle type is the smallest in a soil?$mq$, $mq$["Sand","Silt","Clay","Gravel"]$mq$, 2, $mq$Clay particles are the smallest, silt is in the middle and sand is the largest of the three main soil particle sizes.$mq$, $mq$easy$mq$),
($mq$What is soil erosion?$mq$, $mq$["The addition of fertiliser to soil","The removal and transport of soil by wind or water","The growth of crops","The formation of rock"]$mq$, 1, $mq$Erosion moves topsoil away from where it formed, often to rivers or other places, reducing fertility.$mq$, $mq$easy$mq$),
($mq$Which action helps to reduce soil erosion on a sloping field?$mq$, $mq$["Planting along the contours","Ploughing straight up and down the slope","Removing all plants","Leaving soil bare in winter"]$mq$, 0, $mq$Contour ploughing slows runoff, so less soil is washed downhill. Bare soil and up-and-down ploughing increase erosion.$mq$, $mq$easy$mq$),
($mq$Soil forms very slowly from the weathering of parent rock mixed with organic matter. Which statement about soil formation is correct?$mq$, $mq$["It forms in a few weeks after rain","It forms only from plastic waste","It forms without any living organisms","It can take hundreds to thousands of years to form a few centimetres, so it is effectively non-renewable on human timescales"]$mq$, 3, $mq$Weathering, decomposition and mixing by organisms are slow processes. Soil lost by erosion cannot be replaced quickly.$mq$, $mq$medium$mq$),
($mq$A gardener finds that water drains through her soil very quickly and nutrients wash away. Which soil texture is most likely?$mq$, $mq$["Clay soil","Peat soil","Sandy soil","Loam soil"]$mq$, 2, $mq$Sand particles are large with big gaps between them, so water drains fast and nutrients leach out. Clay holds water and drains slowly.$mq$, $mq$medium$mq$),
($mq$Which soil is usually best for growing most crops?$mq$, $mq$["Pure sand","Loam, a balance of sand, silt, clay and organic matter","Pure clay","Bare rock"]$mq$, 1, $mq$Loam drains well but holds water and nutrients. Its mixture gives good structure and fertility.$mq$, $mq$medium$mq$),
($mq$Irrigation in a hot, dry region repeatedly brings water to the surface, which evaporates. What soil problem is likely?$mq$, $mq$["Salinisation, as salts are left behind in the soil","Acidification caused by rain","Increased humus","Faster soil formation"]$mq$, 0, $mq$Evaporation leaves dissolved salts behind. Over time salt builds up and harms plants, a common cause of degradation in irrigated land.$mq$, $mq$medium$mq$),
($mq$Which is a cause of soil compaction?$mq$, $mq$["Adding compost","Planting deep-rooted plants","Earthworm activity","Heavy machinery or livestock repeatedly pressing on wet soil"]$mq$, 3, $mq$Compaction squeezes out air spaces so roots cannot grow and water cannot infiltrate. It increases runoff and erosion.$mq$, $mq$medium$mq$),
($mq$Overgrazing removes the plant cover from grassland. What is the most likely sequence of events?$mq$, $mq$["More roots, less erosion, increased fertility","Thicker topsoil, more water absorbed","Bare soil, more erosion, reduced fertility, possible desertification","No change because grass grows back instantly"]$mq$, 2, $mq$Without plant cover, soil is exposed to wind and rain, so topsoil is lost. In dry regions this can lead to desertification.$mq$, $mq$medium$mq$),
($mq$A farmer adds compost to a field every year. How does this improve the soil?$mq$, $mq$["It removes all the nutrients","It adds organic matter and nutrients and improves structure and water retention","It makes the soil heavier by adding sand","It stops decomposers working"]$mq$, 1, $mq$Organic matter (humus) binds particles into crumbs, holds water and releases nutrients as it decomposes.$mq$, $mq$medium$mq$),
($mq$A field test: 50 g of soil is dried at 105 °C and then weighs 40 g. What percentage of the original mass was water?$mq$, $mq$["20%","25%","80%","10%"]$mq$, 0, $mq$Water lost = 50 − 40 = 10 g. 10 ÷ 50 × 100 = 20%. Dividing by the dry mass (40) would incorrectly give 25%.$mq$, $mq$medium$mq$),
($mq$A sloping field loses 12 tonnes of soil per hectare per year. If soil forms at 1 tonne per hectare per year, what is the net annual loss and what does this suggest?$mq$, $mq$["13 tonnes per hectare; soil is increasing","1 tonne per hectare; the field is balanced","12 tonnes per hectare; soil formation is irrelevant","11 tonnes per hectare; soil is being lost far faster than it forms, so use is unsustainable"]$mq$, 3, $mq$Net loss = 12 − 1 = 11 t/ha/yr. Erosion rates far above formation rates mean the soil resource is being depleted.$mq$, $mq$hard$mq$),
($mq$Two fields are compared. Field A: 6 cm topsoil, 5% organic matter, ploughed down the slope. Field B: 6 cm topsoil, 5% organic matter, terraced with hedges. After 10 years, A has 3 cm and B has 5.5 cm of topsoil. What is the best conclusion?$mq$, $mq$["Both lost equal amounts","B lost 50% and A lost 8%","Terracing and hedges reduced erosion; A lost 50% of its topsoil while B lost about 8%","Slope management has no effect"]$mq$, 2, $mq$A lost 3 of 6 cm (50%). B lost 0.5 of 6 cm, about 8%. Conservation measures slow soil loss.$mq$, $mq$hard$mq$),
($mq$A student suggests that a wind-eroded field is mainly eroded because of heavy rainfall. Which evidence would best test this idea?$mq$, $mq$["Measure the colour of the sky","Compare soil loss on bare and covered plots during dry windy periods and during rain","Count the number of crops sold","Measure only the pH once"]$mq$, 1, $mq$Comparing treatments (cover, wind, rain) under controlled conditions separates the causes. Soil loss measured in traps would give evidence.$mq$, $mq$hard$mq$),
($mq$Which statement best explains why replacing forest by crops on a steep slope can increase flooding downstream?$mq$, $mq$["Roots and canopy intercept less rain and hold less soil, so runoff is faster and rivers silt up","Crops release more water","Forests create rain only in the valley","Bare slopes absorb more water than forest"]$mq$, 0, $mq$Vegetation slows rainfall and binds soil. Without it, water runs off quickly carrying sediment that raises riverbeds and worsens flooding.$mq$, $mq$hard$mq$),
($mq$A farm's yield of wheat falls from 6 t/ha to 4.8 t/ha over 20 years while fertiliser use stays the same. The farmer blames the weather, but nearby fields with trees and mulch have constant yields. Which is the best interpretation?$mq$, $mq$["The 20% fall proves weather is the cause","Soil has no effect on yield","The nearby fields prove fertiliser is harmful","A 20% fall suggests soil degradation on the farm; the tree and mulch fields hint that soil management matters, though more data are needed"]$mq$, 3, $mq$6 → 4.8 is a fall of 1.2 ÷ 6 = 20%. A fair interpretation links the evidence but notes that other variables must be checked.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Soil Formation and Degradation$mq$ and p.name = $mq$Soils and Land Use$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Soil$mq$, $mq$A mixture of mineral particles, organic matter (humus), water, air and living organisms that supports plant growth.$mq$),
($mq$Humus$mq$, $mq$Dark, decomposed organic matter in soil that holds water and nutrients and improves structure.$mq$),
($mq$Soil horizons$mq$, $mq$O (litter), A (topsoil), B (subsoil), C (weathered parent rock), then bedrock.$mq$),
($mq$Soil texture$mq$, $mq$Based on proportions of sand (largest), silt and clay (smallest). Loam, a balanced mix, is best for most crops.$mq$),
($mq$Soil erosion$mq$, $mq$Removal and transport of soil by wind or water, made worse by bare ground, slopes and overgrazing.$mq$),
($mq$Salinisation$mq$, $mq$Build-up of salts in soil, often when irrigation water evaporates in hot dry regions, harming crops.$mq$),
($mq$Soil compaction$mq$, $mq$Soil is pressed together by machinery or livestock, reducing air spaces, root growth and water infiltration.$mq$),
($mq$Desertification$mq$, $mq$Fertile land in dry regions becoming desert-like because of degradation such as overgrazing and deforestation.$mq$),
($mq$Soil conservation methods$mq$, $mq$Contour ploughing, terracing, cover crops, mulching, windbreaks, crop rotation, adding compost, controlled grazing.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Soil Formation and Degradation$mq$ and p.name = $mq$Soils and Land Use$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Soil is a thin layer at Earth's surface that supports plants, stores water, recycles nutrients and is home to billions of organisms. It is a vital but slowly formed resource: a few centimetres can take hundreds to thousands of years to develop.

## How soil forms
Soil forms from **parent rock** that is broken down by weathering (physical, chemical and biological) and mixed with organic matter from dead plants and animals. Decomposers turn dead material into **humus**. Climate, slope, living organisms and time all affect the type of soil formed.

Soil is made of:
- mineral particles (sand, silt, clay)
- organic matter (humus)
- water
- air
- living organisms such as earthworms, fungi and bacteria

## Soil profile
A soil profile shows horizons (layers):
- **O horizon**: surface litter and decomposing material.
- **A horizon (topsoil)**: dark, rich in humus, roots and nutrients.
- **B horizon (subsoil)**: lighter, with less organic matter and some minerals washed down from above.
- **C horizon**: partly weathered parent rock.
- **Bedrock**: solid rock underneath.

## Soil texture
Sand particles are largest, silt is medium and clay is smallest. Sandy soils drain quickly and hold few nutrients. Clay soils hold water and nutrients but can become waterlogged. **Loam**, a balanced mix with organic matter, is usually best for crops.

## Soil degradation
Degradation means soil loses quality or quantity. Main causes and effects:
- **Erosion** by wind or water, especially when vegetation is removed, on slopes or after overgrazing.
- **Compaction** by heavy machinery or livestock, which reduces air spaces and infiltration.
- **Salinisation** where irrigation in dry climates evaporates water and leaves salts behind.
- **Nutrient depletion** when crops are taken and nutrients are not replaced.
- **Desertification**, when fertile land in dry regions becomes desert-like.

Effects include lower crop yields, more runoff and flooding, silt in rivers and reservoirs, and loss of habitats.

## Soil conservation
- Contour ploughing and terracing slow runoff.
- Cover crops, mulching and windbreaks protect the surface.
- Crop rotation and adding compost or manure restore nutrients and structure.
- Controlled grazing and avoiding bare soil in wet or windy seasons.

## Worked example
A soil sample of 50 g is dried and weighs 40 g. Water content = (50 − 40) ÷ 50 × 100 = 20%. Divide by the original mass, not the dried mass.

## Common mistakes
- Treating soil as renewable on human timescales. It forms far more slowly than it can be lost.
- Mixing up erosion (movement of soil) with weathering (breakdown of rock).
- Forgetting to link a cause to an effect: for example, bare soil leads to erosion, which leads to lower fertility.

## How this is examined
Expect a scenario about a farm, hillside or irrigation scheme, with data such as topsoil depth, yield or mass loss. You may need to calculate a percentage or rate, identify the degradation process, and evaluate management methods.

Exam tip: always link a human action to a process and then to a consequence, e.g. "overgrazing removes plant cover, so rain and wind remove topsoil, which lowers yields".$mq$ from st;

-- Soils and Land Use > Agriculture and Sustainability
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Soils and Land Use$mq$, 5, 6 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Agriculture and Sustainability$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Soils and Land Use$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Agriculture and Sustainability$mq$ and p.name = $mq$Soils and Land Use$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a monoculture?$mq$, $mq$["Growing a single crop over a large area","Growing many different crops together","Farming without soil","Farming only animals"]$mq$, 0, $mq$Monocultures are efficient to manage but are vulnerable to pests and disease and can deplete specific nutrients.$mq$, $mq$easy$mq$),
($mq$What is the purpose of fertiliser?$mq$, $mq$["To kill pests","To add water to the soil","To remove weeds","To supply nutrients such as nitrogen and phosphorus for plant growth"]$mq$, 3, $mq$Fertilisers replace nutrients removed when crops are harvested. Pesticides kill pests; herbicides kill weeds.$mq$, $mq$easy$mq$),
($mq$Which farming method avoids synthetic pesticides and fertilisers?$mq$, $mq$["Intensive monoculture","Factory farming","Organic farming","Slash and burn"]$mq$, 2, $mq$Organic farming uses natural methods such as compost, crop rotation and biological pest control.$mq$, $mq$easy$mq$),
($mq$What does 'yield' mean in agriculture?$mq$, $mq$["The price of land","The amount of crop produced from a given area","The number of farmers","The size of a tractor"]$mq$, 1, $mq$Yield is often measured in tonnes per hectare.$mq$, $mq$easy$mq$),
($mq$Which practice helps maintain soil fertility by growing different crops in a planned order?$mq$, $mq$["Crop rotation","Monoculture","Overgrazing","Burning stubble"]$mq$, 0, $mq$Rotating crops (including nitrogen-fixing legumes) reduces pests and prevents the same nutrients being used each year.$mq$, $mq$easy$mq$),
($mq$A farm produces 120 tonnes of wheat from 30 hectares. What is the yield?$mq$, $mq$["3600 t/ha","0.25 t/ha","90 t/ha","4 t/ha"]$mq$, 3, $mq$Yield = 120 ÷ 30 = 4 t/ha. Dividing the other way gives 0.25, which is hectares per tonne.$mq$, $mq$medium$mq$),
($mq$Excess nitrate fertiliser runs off fields into a lake. What is the likely effect?$mq$, $mq$["Clearer water","More oxygen at all depths","Algal blooms and eutrophication, leading to oxygen depletion","Fewer algae"]$mq$, 2, $mq$Nutrients stimulate algal growth. When algae die, bacteria use up dissolved oxygen, harming fish.$mq$, $mq$medium$mq$),
($mq$Which is a disadvantage of using broad-spectrum pesticides?$mq$, $mq$["They always increase biodiversity","They can kill beneficial insects such as pollinators and may build up in food chains","They are never expensive","They improve soil structure"]$mq$, 1, $mq$Non-selective pesticides harm non-target species. Some can bioaccumulate, becoming more concentrated at higher trophic levels.$mq$, $mq$medium$mq$),
($mq$Planting leguminous crops such as beans in rotation helps because:$mq$, $mq$["Bacteria in root nodules fix nitrogen, adding it to the soil","Beans release phosphorus from rock","Beans fix carbon in the soil only","Beans kill all weeds"]$mq$, 0, $mq$Nitrogen-fixing bacteria in legume nodules convert atmospheric nitrogen into forms plants can use.$mq$, $mq$medium$mq$),
($mq$Which method is part of integrated pest management?$mq$, $mq$["Spraying every day regardless of pests","Removing all predators","Burning the crops","Using natural predators such as ladybirds along with targeted spraying only when needed"]$mq$, 3, $mq$Integrated pest management combines biological control, crop choice and limited pesticide use to reduce environmental harm.$mq$, $mq$medium$mq$),
($mq$Why does producing 1 kg of beef usually require more land than 1 kg of wheat?$mq$, $mq$["Cattle photosynthesise more slowly","Wheat needs more land per kilogram","Energy is lost at each trophic level, so far more plant food is needed to produce animal products","Cattle are produced without feed"]$mq$, 2, $mq$Only about 10% of energy passes to the next trophic level, so eating lower on the food chain generally needs less land.$mq$, $mq$medium$mq$),
($mq$A farmer switches from flood irrigation to drip irrigation, reducing water use from 8000 m³ to 5200 m³ per hectare per season. What is the percentage saving?$mq$, $mq$["65%","35%","54%","2800%"]$mq$, 1, $mq$Saving = 8000 − 5200 = 2800 m³. 2800 ÷ 8000 × 100 = 35%.$mq$, $mq$medium$mq$),
($mq$Which is a social benefit of local food production compared with imported food?$mq$, $mq$["Reduced food miles and support for local jobs","Always cheaper in every season","Always larger yields","No need for any storage"]$mq$, 0, $mq$Shorter supply chains cut transport emissions and support local economies, though growing season and efficiency still matter.$mq$, $mq$medium$mq$),
($mq$A farmer cuts nitrogen fertiliser from 200 kg/ha to 150 kg/ha. Yield falls from 8.0 to 7.6 t/ha. Which is the best evaluation?$mq$, $mq$["Yield fell by 25%, so the change is a failure","Fertiliser fell by 5% and yield by 25%","The data show no change at all","Fertiliser fell 25% while yield fell only 5%, so the reduction may be more efficient and less polluting"]$mq$, 3, $mq$Fertiliser: 50 ÷ 200 = 25%. Yield: 0.4 ÷ 8.0 = 5%. Lower inputs with a small yield loss can be better economically and environmentally.$mq$, $mq$hard$mq$),
($mq$Two farms are compared. Farm X: monoculture of maize, 9 t/ha, uses 180 kg/ha nitrogen, high pesticide. Farm Y: mixed crops with rotation, 7 t/ha, uses 60 kg/ha nitrogen, low pesticide. Which judgment is best supported?$mq$, $mq$["X is always best because yield is highest","Y is always best because it uses less fertiliser","Y yields less but is likely more sustainable for soil, water quality and biodiversity; the best choice depends on food demand and costs","Neither can be compared"]$mq$, 2, $mq$Evaluation should balance productivity against impacts on soil, pollution and biodiversity, and refer to the data.$mq$, $mq$hard$mq$),
($mq$Which scenario best explains how the spread of intensive monoculture can increase the risk of crop failure?$mq$, $mq$["Monocultures have more pollinators","Uniform plants share the same weaknesses, so one pest or disease can spread quickly across a whole region","Uniform plants are always resistant","Pests prefer varied crops"]$mq$, 1, $mq$Genetic and species uniformity removes natural barriers to the spread of disease. Diversity spreads risk.$mq$, $mq$hard$mq$),
($mq$An organic farm and a conventional farm each grow 10 ha of tomatoes. Organic produces 400 tonnes using 4 workers; conventional produces 520 tonnes using 3 workers. A student concludes the conventional farm is better. What is the main flaw?$mq$, $mq$["The student only compares yield and labour, ignoring environmental impacts, costs, product prices and long-term soil health","Yield cannot be compared","Tonnes are not a valid unit","Workers do not matter"]$mq$, 0, $mq$Yields are 40 and 52 t/ha. A balanced judgement uses several criteria: economic, social and environmental.$mq$, $mq$hard$mq$),
($mq$Which statement describes the strongest argument that shifting to plant-rich diets could improve food security?$mq$, $mq$["Plants contain no nutrients","Animals use no land","Energy flow upwards increases at each level","Plants feed people directly, so less land and water are needed per unit of food energy than for animal products"]$mq$, 3, $mq$Energy is lost at each trophic level, so producing animal products typically requires more resources per calorie.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Agriculture and Sustainability$mq$ and p.name = $mq$Soils and Land Use$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Sustainable agriculture$mq$, $mq$Producing food in ways that meet present needs without harming soil, water, biodiversity and climate for the future.$mq$),
($mq$Yield$mq$, $mq$Amount of crop produced per area, e.g. t/ha. Calculate by total produced ÷ area.$mq$),
($mq$Monoculture$mq$, $mq$Growing one crop over a large area: efficient but vulnerable to pests, disease and nutrient depletion.$mq$),
($mq$Crop rotation$mq$, $mq$Growing different crops in sequence, including nitrogen-fixing legumes, to keep soil fertile and reduce pests.$mq$),
($mq$Eutrophication from farming$mq$, $mq$Fertiliser runoff adds nitrates and phosphates, causing algal blooms; decomposers then use up oxygen and aquatic life dies.$mq$),
($mq$Integrated pest management$mq$, $mq$Combining natural predators, resistant crops, rotation and limited targeted pesticide use.$mq$),
($mq$Organic farming$mq$, $mq$Farming without synthetic fertilisers and pesticides, using compost, manure, rotation and biological control.$mq$),
($mq$Drip irrigation$mq$, $mq$Delivers small amounts of water directly to roots, reducing evaporation and saving water.$mq$),
($mq$Why eating plants uses less land$mq$, $mq$Energy is lost at each trophic level (only about 10% passes on), so animal products need more land per unit of food energy.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Agriculture and Sustainability$mq$ and p.name = $mq$Soils and Land Use$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Agriculture feeds the world but is also one of the biggest users of land and water and a major source of pollution and greenhouse gases. **Sustainable agriculture** aims to meet today's food needs without damaging soil, water, biodiversity and the climate for future generations.

## Types of farming
- **Intensive farming**: high inputs (fertiliser, pesticides, machinery, irrigation) on a small area to get a high yield per hectare.
- **Extensive farming**: low inputs over a large area, with lower yields per hectare.
- **Monoculture**: one crop grown repeatedly. It is easy to manage but vulnerable to pests and disease and can deplete particular nutrients.
- **Mixed farming and crop rotation**: several crops or animals together or in turn.
- **Organic farming**: no synthetic fertilisers or pesticides; uses compost, manure and natural pest control.

## Yield and efficiency
**Yield** is crop produced per area, such as tonnes per hectare (t/ha). Example: 120 tonnes from 30 ha gives 120 ÷ 30 = 4 t/ha. Always check units and divide the total by the area.

## Environmental impacts
- **Eutrophication**: nitrates and phosphates from fertiliser run into water, causing algal blooms. When algae die, decomposers use up oxygen and fish die.
- **Pesticides**: can kill beneficial insects, pollinators and predators, and can build up in food chains (bioaccumulation).
- **Soil degradation**: erosion, compaction and salinisation from poor management.
- **Water use**: irrigation can deplete rivers and groundwater.
- **Greenhouse gases**: methane from cattle and rice, nitrous oxide from fertilisers, CO₂ from machinery and land clearing.
- **Biodiversity loss**: removing hedgerows, wetlands and forests for fields.

## Sustainable approaches
- Crop rotation, including nitrogen-fixing legumes, and cover crops.
- Integrated pest management using natural predators and targeted spraying.
- Drip irrigation and rainwater harvesting (for example, cutting water from 8000 to 5200 m³ per hectare is a 35% saving).
- Precision farming: using sensors or GPS to apply inputs only where needed.
- Agroforestry: growing trees with crops or livestock.
- Reducing food waste and sourcing food locally to cut food miles.

## Energy and diet
Energy is lost at each step of a food chain, so animal products usually need more land and resources than plant foods. A more plant-rich diet can reduce land use.

## Evaluating
There is rarely a single best option. Compare yield, cost, workers needed, soil health, pollution and biodiversity. Quote numbers from the data and state the trade-off.

## Common mistakes
- Saying organic farming has no environmental impact.
- Judging only on yield. Sustainability also includes soil, water, biodiversity, economics and society.
- Mixing up percentage change in inputs with percentage change in output.

## How this is examined
You might be given a table of two farms with yields, fertiliser use and costs, then asked to calculate yields or percentage changes, explain a pollution pathway like eutrophication, and justify which system is more sustainable.

Exam tip: for "evaluate", give at least one advantage and one limitation for each option, and finish with a justified conclusion that uses the data.$mq$ from st;

-- Soils and Land Use > Deforestation and Land Use Change
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Soils and Land Use$mq$, 5, 6 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Deforestation and Land Use Change$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Soils and Land Use$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Deforestation and Land Use Change$mq$ and p.name = $mq$Soils and Land Use$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is deforestation?$mq$, $mq$["The permanent clearing of forests for other uses","Planting new forests","Thinning trees for safety only","Protecting forests from fire"]$mq$, 0, $mq$Deforestation converts forest to other land uses, such as farmland, mining or buildings.$mq$, $mq$easy$mq$),
($mq$Which is a common cause of tropical deforestation?$mq$, $mq$["Building more national parks","Planting trees in cities","Creating nature reserves","Clearing land for cattle ranching and plantations"]$mq$, 3, $mq$Agriculture, including cattle, soy and palm oil, is a leading driver, along with logging, mining and road building.$mq$, $mq$easy$mq$),
($mq$Planting trees on land that has not recently been forest is called:$mq$, $mq$["Deforestation","Desertification","Afforestation","Erosion"]$mq$, 2, $mq$Afforestation creates forest where there was none; reforestation replants where forest was cut.$mq$, $mq$easy$mq$),
($mq$Why do forests help reduce flooding?$mq$, $mq$["Forests produce more rain in rivers","Leaves and roots intercept rain and help water soak into the ground","Roots make soil waterproof","Trees heat the ground"]$mq$, 1, $mq$Vegetation slows rainfall and increases infiltration, so water reaches rivers more slowly.$mq$, $mq$easy$mq$),
($mq$Which gas is stored in trees and released when forests are burned?$mq$, $mq$["Carbon dioxide","Helium","Neon","Hydrogen"]$mq$, 0, $mq$Trees store carbon taken in by photosynthesis. Burning or decay releases it as CO₂.$mq$, $mq$easy$mq$),
($mq$Which is the best explanation of why deforestation contributes to climate change?$mq$, $mq$["Trees produce greenhouse gases only","Deforestation increases ozone","Clearing forests adds more rain","Fewer trees absorb less CO₂ and burning or decay releases stored carbon"]$mq$, 3, $mq$Removing forests both releases carbon and reduces future absorption.$mq$, $mq$medium$mq$),
($mq$A forest area of 50 000 hectares loses 2000 hectares per year. What percentage is lost in the first year?$mq$, $mq$["25%","2%","4%","40%"]$mq$, 2, $mq$2000 ÷ 50 000 × 100 = 4%. At the same constant loss it would be gone in 25 years.$mq$, $mq$medium$mq$),
($mq$Why does heavy rain cause greater soil loss after deforestation on a slope?$mq$, $mq$["Roots create runoff","Without roots and canopy, rain hits bare soil and runoff carries topsoil away","Trees block infiltration","Deforested soil is always rock"]$mq$, 1, $mq$Removing vegetation exposes soil to raindrop impact and runoff.$mq$, $mq$medium$mq$),
($mq$Which sustainable forestry practice helps maintain a forest while still providing timber?$mq$, $mq$["Selective logging and replanting, with certification such as FSC","Clear-felling the whole area","Burning the stumps","Logging in protected parks"]$mq$, 0, $mq$Selective harvesting and replanting keep forest cover and biodiversity. Certification schemes help buyers choose responsibly sourced wood.$mq$, $mq$medium$mq$),
($mq$Slash-and-burn farming can be sustainable at low population density but harmful at high density. Why?$mq$, $mq$["Burning adds new soil forever","Trees regrow instantly","There is no ash","The land needs many years to recover, but high demand leads to shorter fallow periods and soil exhaustion"]$mq$, 3, $mq$Ash gives a short-term nutrient boost. Repeated clearing without recovery time degrades soil.$mq$, $mq$medium$mq$),
($mq$Which is an effect of deforestation on local rainfall?$mq$, $mq$["It always increases rainfall","It has no relation to water","Reduced transpiration can lead to less local rainfall","It makes oceans freshwater"]$mq$, 2, $mq$Trees release water vapour by transpiration, which contributes to rainfall, especially in large forests such as the Amazon.$mq$, $mq$medium$mq$),
($mq$Which land use change usually has the biggest direct effect on flooding in a river catchment?$mq$, $mq$["Planting more trees","Replacing grass and soil with roads and roofs (urbanisation)","Restoring wetlands","Adding hedgerows"]$mq$, 1, $mq$Impermeable surfaces prevent infiltration and speed up runoff, leading to quicker, higher flood peaks.$mq$, $mq$medium$mq$),
($mq$Which group is directly affected when a forest is cleared in many regions?$mq$, $mq$["Indigenous communities who rely on the forest for food, shelter and culture","Only distant cities","Nobody","Only planes"]$mq$, 0, $mq$Deforestation can displace people and remove traditional resources.$mq$, $mq$medium$mq$),
($mq$A palm oil company clears 1500 ha of forest. Each hectare stored about 200 tonnes of carbon. How much carbon was stored in the cleared area, and what happens to it?$mq$, $mq$["3000 tonnes, absorbed by the soil","30 000 tonnes, stored in oil","300 tonnes, converted to oxygen","300 000 tonnes, mostly released to the atmosphere as CO₂ when burned or decayed"]$mq$, 3, $mq$1500 × 200 = 300 000 tonnes of carbon. Clearing and burning release it, adding to the enhanced greenhouse effect.$mq$, $mq$hard$mq$),
($mq$Satellite data show forest cover in a region fell from 80% to 62% of the land area over 20 years. By how many percentage points did it fall and what percentage of the original forest was lost?$mq$, $mq$["18%; 18% of the original","22.5 percentage points; 18% of original","18 percentage points; 22.5% of the original forest","18 percentage points; 77.5% of original"]$mq$, 2, $mq$80 − 62 = 18 percentage points. 18 ÷ 80 × 100 = 22.5% of the original forest. Distinguish points from percentages.$mq$, $mq$hard$mq$),
($mq$A country argues that clearing forest for farming will reduce poverty. A conservation group argues for protection. Which approach is best supported by sustainable development?$mq$, $mq$["Choose the plan with the highest profit this year only","Compare long-term economic, social and environmental costs and benefits, including alternatives like agroforestry and eco-tourism","Ignore the views of local people","Choose the plan that preserves nothing"]$mq$, 1, $mq$A sustainable approach balances present needs against future ones and involves local people in decisions.$mq$, $mq$hard$mq$),
($mq$A study finds that rivers downstream of cleared hillsides carry 5 times more sediment than rivers below forested hillsides. Which conclusion is most reasonable and what is a limitation?$mq$, $mq$["Clearing increases erosion; however, other factors like slope, rainfall and soil type must be controlled","Forests increase sediment; the data are perfect","There is no link; rivers are unaffected","Sediment is caused by fish"]$mq$, 0, $mq$The evidence is consistent with vegetation protecting soil, but a valid conclusion must consider confounding variables.$mq$, $mq$hard$mq$),
($mq$Which combination of strategies would best reduce deforestation while supporting local people?$mq$, $mq$["Unlimited logging licences","Removing all residents with no alternatives","Banning agriculture worldwide","Protected areas with community involvement, sustainable forest products, payments for forest protection and enforcement against illegal logging"]$mq$, 3, $mq$Successful conservation combines legal protection with benefits for communities and enforcement.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Deforestation and Land Use Change$mq$ and p.name = $mq$Soils and Land Use$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Deforestation$mq$, $mq$Permanent clearing of forest so land can be used for farming, mining, building or other uses.$mq$),
($mq$Main causes of tropical deforestation$mq$, $mq$Cattle ranching, soy and palm oil plantations, logging, subsistence farming, mining, roads and urban growth.$mq$),
($mq$Deforestation and climate$mq$, $mq$Clearing releases stored carbon as CO₂ and removes trees that would absorb it, strengthening the enhanced greenhouse effect.$mq$),
($mq$Effects on soil and water$mq$, $mq$Less interception and root binding: more runoff, erosion, flooding and silted rivers; less transpiration may lower rainfall.$mq$),
($mq$Afforestation vs reforestation$mq$, $mq$Afforestation: planting trees where there was no forest. Reforestation: replanting where forest was cut.$mq$),
($mq$Slash-and-burn$mq$, $mq$Clearing and burning plots for ash nutrients, farming a few years, then leaving to recover. Harmful if recovery time is too short.$mq$),
($mq$Sustainable forestry$mq$, $mq$Selective logging, replanting, protecting biodiversity, and certification (e.g. FSC) so timber is responsibly sourced.$mq$),
($mq$Land use change$mq$, $mq$Converting land from one use to another, e.g. forest to farmland or farmland to housing.$mq$),
($mq$Percentage points vs percentage$mq$, $mq$Cover falling from 80% to 62% is 18 percentage points, but 18 ÷ 80 = 22.5% of the original forest.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Deforestation and Land Use Change$mq$ and p.name = $mq$Soils and Land Use$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Forests cover about a third of Earth's land and provide timber, food, medicines, homes for people and wildlife, and vital services such as storing carbon, regulating water and protecting soil. **Deforestation** is the permanent removal of forest so the land can be used for something else. **Land use change** is any conversion from one use to another, such as forest to farmland, farmland to housing or wetland to drained pasture.

## Causes of deforestation
- Commercial agriculture: cattle ranching, soy and palm oil plantations.
- Subsistence farming, including slash-and-burn where each plot is cleared, burned for ash nutrients, farmed for a few years, then left to recover.
- Logging for timber and paper, often through illegal logging.
- Mining, road building and dams.
- Urban growth and fuelwood collection.

Underlying drivers include rising population, demand for cheap food and wood, poverty, weak law enforcement and global trade.

## Environmental effects
- **Climate**: trees store carbon. Clearing and burning release CO₂, and fewer trees absorb less.
- **Biodiversity**: habitat loss and fragmentation threaten species.
- **Soil**: roots and canopy protect soil. After clearing, rain causes erosion and nutrient loss.
- **Water**: less interception and infiltration means faster runoff, more flooding and silted rivers. Reduced transpiration can lower local rainfall.
- **Urbanisation** replaces soil with impermeable surfaces, increasing flood risk.

## Social and economic effects
Short-term income from timber and farming can be important, but long-term losses include fertility loss, floods and displacement of communities who rely on forests for food, shelter and culture.

## Worked example
A forest of 50 000 ha loses 2000 ha per year. Loss in year 1 = 2000 ÷ 50 000 × 100 = 4%. If the loss continues at the same rate, it takes 50 000 ÷ 2000 = 25 years to clear it. Note the difference between **percentage points** and **percentages**: a fall from 80% cover to 62% cover is 18 percentage points, but 18 ÷ 80 = 22.5% of the original forest.

## Management and solutions
- Protected areas and national parks, with real enforcement.
- Sustainable forestry: selective logging, replanting and certification (such as FSC).
- Reforestation (replanting cut forest) and afforestation (planting new forest).
- Agroforestry and sustainable products, such as ecotourism.
- Reducing demand: less waste, recycled paper, certified products, and diet changes.
- Involving local and indigenous people, who often protect forests best.

## Common mistakes
- Saying all deforestation is illegal or all caused by poor people. Causes are varied, including global demand.
- Confusing percentage points with percentage change.
- Forgetting trade-offs: solutions should consider the needs of communities.

## How this is examined
Expect maps, tables of forest cover over time or a short case study. You may calculate loss, explain impacts on carbon, soil and water, and evaluate solutions from different perspectives.

Exam tip: structure your evaluation by environmental, social and economic impacts, and always quote data from the stimulus.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('environmental-systems')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;