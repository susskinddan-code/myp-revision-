-- Part 3 of 6: 6 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Respiration > Aerobic Respiration Explained
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Respiration$mq$, 4, 5 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Aerobic Respiration Explained$mq$, 4, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Respiration$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Aerobic Respiration Explained$mq$ and p.name = $mq$Respiration$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Name the organelle where most aerobic respiration takes place.$mq$, $mq$["Mitochondria","Chloroplasts","Ribosomes","Nucleus"]$mq$, 0, $mq$Mitochondria contain the enzymes for aerobic respiration, which releases energy from glucose.$mq$, $mq$easy$mq$),
($mq$Name the gas that is needed for aerobic respiration.$mq$, $mq$["Carbon dioxide","Nitrogen","Hydrogen","Oxygen"]$mq$, 3, $mq$Aerobic means 'with oxygen'. Oxygen is used to break down glucose completely.$mq$, $mq$easy$mq$),
($mq$Name the sugar that is broken down in respiration to release energy.$mq$, $mq$["Starch","Cellulose","Glucose","Sucrose"]$mq$, 2, $mq$Glucose is the main fuel for respiration. Other nutrients are first changed to glucose or similar molecules.$mq$, $mq$easy$mq$),
($mq$Name the two substances produced by aerobic respiration, besides energy.$mq$, $mq$["Oxygen and glucose","Carbon dioxide and water","Lactic acid and water","Ethanol and carbon dioxide"]$mq$, 1, $mq$Glucose + oxygen -> carbon dioxide + water. The carbon dioxide is breathed out and the water is lost or reused.$mq$, $mq$easy$mq$),
($mq$Respiration releases heat to the surroundings. What word describes a reaction that releases energy?$mq$, $mq$["Exothermic","Endothermic","Reversible","Neutral"]$mq$, 0, $mq$An exothermic reaction transfers energy to the surroundings. Respiration is exothermic.$mq$, $mq$easy$mq$),
($mq$How many molecules of oxygen react with one molecule of glucose in aerobic respiration?$mq$, $mq$["2","12","3","6"]$mq$, 3, $mq$The balanced equation is C6H12O6 + 6O2 -> 6CO2 + 6H2O, so six oxygen molecules are used for each glucose.$mq$, $mq$medium$mq$),
($mq$Which organisms carry out respiration?$mq$, $mq$["Only animals","Only plants","All living organisms","Only organisms with lungs"]$mq$, 2, $mq$Every living cell respires to release energy, including plants, animals, fungi and bacteria.$mq$, $mq$medium$mq$),
($mq$Name the process of moving air in and out of the lungs.$mq$, $mq$["Respiration","Breathing","Diffusion","Digestion"]$mq$, 1, $mq$Breathing, also called ventilation, moves air. Respiration is the chemical process in cells that releases energy.$mq$, $mq$medium$mq$),
($mq$Why does breathing rate increase during exercise?$mq$, $mq$["Muscles need more oxygen","Muscles need less energy","The body is cooling the lungs","The body is making more nitrogen"]$mq$, 0, $mq$Active muscles respire faster, so they need more oxygen and produce more carbon dioxide. Faster breathing supplies and removes these gases.$mq$, $mq$medium$mq$),
($mq$What happens to limewater when carbon dioxide is bubbled through it?$mq$, $mq$["It turns blue-black","It turns brick-red","It stays clear","It turns cloudy"]$mq$, 3, $mq$Carbon dioxide reacts with limewater to form a white solid, which makes it cloudy.$mq$, $mq$medium$mq$),
($mq$About what percentage of inhaled air is oxygen?$mq$, $mq$["78%","0.04%","21%","50%"]$mq$, 2, $mq$Air is about 78% nitrogen, 21% oxygen and 0.04% carbon dioxide. Exhaled air has about 16% oxygen.$mq$, $mq$medium$mq$),
($mq$Name the indicator that changes from red to yellow as the carbon dioxide concentration rises.$mq$, $mq$["Iodine solution","Hydrogencarbonate indicator","Benedict's solution","Biuret reagent"]$mq$, 1, $mq$Hydrogencarbonate indicator is red in air, becomes yellow in higher carbon dioxide and purple in lower carbon dioxide.$mq$, $mq$medium$mq$),
($mq$Plants respire all the time. Name the process that uses energy from respiration to take minerals into root hair cells.$mq$, $mq$["Active transport","Osmosis","Diffusion","Transpiration"]$mq$, 0, $mq$Active transport needs energy released in respiration to move mineral ions against their concentration gradient.$mq$, $mq$medium$mq$),
($mq$Why do piles of germinating seeds become warm?$mq$, $mq$["Photosynthesis releases heat","Osmosis releases heat","Seeds absorb sunlight","Respiration releases heat"]$mq$, 3, $mq$Respiration is exothermic. A large number of seeds respire quickly as they germinate, and the heat released warms the pile.$mq$, $mq$hard$mq$),
($mq$Exhaled air contains about 4% carbon dioxide and inhaled air about 0.04%. How many times more carbon dioxide does exhaled air contain?$mq$, $mq$["10 times","4 times","100 times","400 times"]$mq$, 2, $mq$4 ÷ 0.04 = 100, so exhaled air has about 100 times as much carbon dioxide.$mq$, $mq$hard$mq$),
($mq$A plant is sealed in a clear bag in the dark. What happens to the carbon dioxide concentration in the bag?$mq$, $mq$["It decreases","It increases","It stays the same","It disappears"]$mq$, 1, $mq$In the dark there is no photosynthesis, but the plant still respires and releases carbon dioxide.$mq$, $mq$hard$mq$),
($mq$At a certain light intensity a plant takes in no net carbon dioxide and gives out no net oxygen. What is happening?$mq$, $mq$["Photosynthesis rate equals respiration rate","Photosynthesis has stopped","Respiration has stopped","The stomata are closed"]$mq$, 0, $mq$The carbon dioxide made by respiration is exactly used up by photosynthesis, and the oxygen made by photosynthesis is exactly used by respiration.$mq$, $mq$hard$mq$),
($mq$Cyanide stops the reactions of respiration in mitochondria. Why can this kill an animal quickly?$mq$, $mq$["Glucose is too concentrated","Oxygen leaves the lungs","Cells make too much carbon dioxide","Cells cannot release energy"]$mq$, 3, $mq$Without respiration, cells cannot release the energy needed for movement, active transport and keeping the heart beating.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Aerobic Respiration Explained$mq$ and p.name = $mq$Respiration$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Aerobic respiration$mq$, $mq$The release of energy from glucose using oxygen. It takes place in mitochondria.$mq$),
($mq$Word equation for aerobic respiration$mq$, $mq$Glucose + oxygen -> carbon dioxide + water (+ energy).$mq$),
($mq$Symbol equation for aerobic respiration$mq$, $mq$C6H12O6 + 6O2 -> 6CO2 + 6H2O$mq$),
($mq$Is respiration endothermic or exothermic?$mq$, $mq$Exothermic. Energy is released, some of it as heat.$mq$),
($mq$Respiration versus breathing$mq$, $mq$Breathing moves air in and out of the lungs. Respiration is the chemical process in cells that releases energy.$mq$),
($mq$Name three uses of energy from respiration$mq$, $mq$Muscle contraction, active transport, making proteins (also growth and keeping warm).$mq$),
($mq$Limewater test$mq$, $mq$Limewater turns cloudy when carbon dioxide is bubbled through it.$mq$),
($mq$Hydrogencarbonate indicator$mq$, $mq$Red in air. Turns yellow when carbon dioxide concentration rises and purple when it falls.$mq$),
($mq$Do plants respire?$mq$, $mq$Yes. All living cells respire, day and night.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Aerobic Respiration Explained$mq$ and p.name = $mq$Respiration$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Every living cell needs a continuous supply of energy. This energy is released from food molecules by respiration. Do not confuse respiration with breathing: breathing moves air in and out of the lungs, whereas respiration is a chemical process that takes place in every cell.

## What is aerobic respiration?
Aerobic respiration is the release of energy from glucose using oxygen. It takes place in the mitochondria of cells (some of the early steps happen in the cytoplasm).
Word equation: glucose + oxygen -> carbon dioxide + water (+ energy).
Symbol equation: C6H12O6 + 6O2 -> 6CO2 + 6H2O.
It is an exothermic reaction: energy is released. Some is transferred to the surroundings as heat, which is why mammals and birds stay warm. The rest is captured in a molecule called ATP, which cells use to power processes such as muscle contraction, active transport, protein synthesis, cell division, and nerve impulses.

## Where do the materials come from?
Glucose comes from the digestion of carbohydrates and is carried by the blood. Oxygen enters the blood in the lungs by diffusion and is carried by red blood cells. The carbon dioxide made diffuses out of the cells into the blood and is breathed out. Plants respire too. They use glucose made in photosynthesis and take in oxygen through the stomata, day and night.

## Inhaled and exhaled air
- Inhaled air: about 21% oxygen, 0.04% carbon dioxide, 78% nitrogen.
- Exhaled air: about 16% oxygen, 4% carbon dioxide, 78% nitrogen, with more water vapour.
The changes happen because cells use oxygen and produce carbon dioxide. You can show the extra carbon dioxide with limewater, which turns cloudy, or hydrogencarbonate indicator, which changes from red to yellow.

## Worked example 1
How many molecules of carbon dioxide are released when 5 molecules of glucose are fully respired? One glucose gives 6 CO2, so 5 x 6 = 30.

## Worked example 2
Compare photosynthesis and respiration. Photosynthesis takes place in chloroplasts only in cells with chlorophyll and only in the light; it takes in carbon dioxide and water and releases oxygen; it stores energy; it is endothermic. Respiration takes place in all cells, all the time; it takes in oxygen and glucose and releases carbon dioxide and water; it releases energy; it is exothermic. During the day, a plant's photosynthesis is usually faster than its respiration. At night only respiration continues, so the carbon dioxide level near plants can rise.

## Common mistakes
- Saying respiration is breathing.
- Saying that energy is "made" or "produced". Energy is released from glucose.
- Saying only animals respire. Plants respire too, all of the time.
- Writing the equation with the reactants and products the wrong way round, which is photosynthesis.
- Saying that mitochondria are only in muscle cells. They are in nearly all cells, with the most in cells with a high energy demand.

## Command terms
- State: give the word equation.
- Compare: give similarities and differences, for example of photosynthesis and respiration.
- Explain: give the reason why breathing rate rises during exercise.
- Predict: say what would happen to the carbon dioxide level in a closed bag with a plant in the dark.

Exam tip: always connect a bodily change in exercise to respiration: more energy needed, so more oxygen needed, so faster breathing and heart rate.$mq$ from st;

-- Respiration > Anaerobic Respiration in Muscles and Yeast
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Respiration$mq$, 4, 5 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Anaerobic Respiration in Muscles and Yeast$mq$, 4, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Respiration$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Anaerobic Respiration in Muscles and Yeast$mq$ and p.name = $mq$Respiration$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Name the type of respiration that takes place without oxygen.$mq$, $mq$["Anaerobic respiration","Aerobic respiration","Photosynthesis","Digestion"]$mq$, 0, $mq$Anaerobic means 'without oxygen'. It releases much less energy than aerobic respiration.$mq$, $mq$easy$mq$),
($mq$Name the substance produced in muscles during anaerobic respiration.$mq$, $mq$["Ethanol","Glucose","Starch","Lactic acid"]$mq$, 3, $mq$In animals, glucose is partly broken down to lactic acid when there is too little oxygen.$mq$, $mq$easy$mq$),
($mq$Name the alcohol produced when yeast respires anaerobically.$mq$, $mq$["Methanol","Glycerol","Ethanol","Lactic acid"]$mq$, 2, $mq$Yeast produces ethanol and carbon dioxide from glucose in the absence of oxygen.$mq$, $mq$easy$mq$),
($mq$Name the process by which yeast makes ethanol and carbon dioxide from sugar.$mq$, $mq$["Photosynthesis","Fermentation","Transpiration","Digestion"]$mq$, 1, $mq$Fermentation is anaerobic respiration in yeast. It is used to make bread and alcoholic drinks.$mq$, $mq$easy$mq$),
($mq$Name the gas that makes bread dough rise.$mq$, $mq$["Carbon dioxide","Oxygen","Nitrogen","Hydrogen"]$mq$, 0, $mq$The carbon dioxide from yeast respiration forms bubbles in the dough, which expand when baked.$mq$, $mq$easy$mq$),
($mq$Which type of respiration releases more energy from each glucose molecule?$mq$, $mq$["Anaerobic respiration","They release equal amounts","Neither releases energy","Aerobic respiration"]$mq$, 3, $mq$Aerobic respiration breaks glucose down completely, so it releases much more energy than anaerobic respiration.$mq$, $mq$medium$mq$),
($mq$Why do muscles respire anaerobically during a sprint?$mq$, $mq$["Muscles do not need energy","Glucose has run out","Oxygen is not supplied fast enough","There is too much oxygen"]$mq$, 2, $mq$During intense exercise, energy is needed faster than the blood can deliver oxygen, so muscles also respire anaerobically.$mq$, $mq$medium$mq$),
($mq$Name the extra oxygen that must be taken in after exercise to break down lactic acid.$mq$, $mq$["Lactic cycle","Oxygen debt","Energy loss","Aerobic reserve"]$mq$, 1, $mq$The oxygen debt is the extra oxygen needed after exercise to remove lactic acid. This is why you keep breathing heavily after stopping.$mq$, $mq$medium$mq$),
($mq$Complete the word equation for anaerobic respiration in muscles: glucose -> ?$mq$, $mq$["Lactic acid","Ethanol","Carbon dioxide and water","Starch"]$mq$, 0, $mq$In muscles, glucose -> lactic acid (+ a small amount of energy). No carbon dioxide is produced.$mq$, $mq$medium$mq$),
($mq$Complete the word equation for anaerobic respiration in yeast: glucose -> ethanol + ?$mq$, $mq$["Oxygen","Water","Lactic acid","Carbon dioxide"]$mq$, 3, $mq$Yeast produces ethanol and carbon dioxide: glucose -> ethanol + carbon dioxide.$mq$, $mq$medium$mq$),
($mq$Name one food that is made using yeast fermentation.$mq$, $mq$["Cheese","Yoghurt","Bread","Butter"]$mq$, 2, $mq$Bread uses yeast. Cheese and yoghurt are made with bacteria.$mq$, $mq$medium$mq$),
($mq$Why does bread dough rise?$mq$, $mq$["Oxygen forms bubbles","Carbon dioxide forms bubbles","Water boils","Yeast swells with water"]$mq$, 1, $mq$Yeast produces carbon dioxide by fermentation, and the gas gets trapped in the dough as bubbles.$mq$, $mq$medium$mq$),
($mq$What causes muscle fatigue during intense exercise?$mq$, $mq$["A build-up of lactic acid","A build-up of glucose","Too much oxygen","A loss of ethanol"]$mq$, 0, $mq$Lactic acid builds up in muscles, which causes cramp and tiredness, so muscles stop contracting efficiently.$mq$, $mq$medium$mq$),
($mq$After exercise, lactic acid is carried in the blood to the liver. What is used to break it down there?$mq$, $mq$["Glucose","Starch","Ethanol","Oxygen"]$mq$, 3, $mq$The liver uses oxygen to convert lactic acid, so oxygen is used to repay the oxygen debt.$mq$, $mq$hard$mq$),
($mq$Why does anaerobic respiration release less energy than aerobic respiration?$mq$, $mq$["Glucose is not used","There is too much oxygen","Glucose is not fully broken down","Carbon dioxide is absorbed"]$mq$, 2, $mq$In anaerobic respiration glucose is only partly broken down and the products (lactic acid or ethanol) still contain a lot of stored energy.$mq$, $mq$hard$mq$),
($mq$A layer of oil is poured over the sugar solution in a yeast fermentation experiment. Why?$mq$, $mq$["To add nutrients","To exclude oxygen","To cool the yeast","To absorb carbon dioxide"]$mq$, 1, $mq$The oil stops air dissolving in the solution, so the yeast respires anaerobically.$mq$, $mq$hard$mq$),
($mq$Which activity depends most heavily on anaerobic respiration in muscles?$mq$, $mq$["100 metre sprint","Marathon","Gentle walk","Sleeping"]$mq$, 0, $mq$A sprint needs a very rapid release of energy over a short time, so muscles rely on anaerobic respiration. In a gentle walk, aerobic respiration supplies enough energy.$mq$, $mq$hard$mq$),
($mq$A plant root in waterlogged soil has no oxygen and respires anaerobically. Which substance does it produce?$mq$, $mq$["Lactic acid","Oxygen","Starch","Ethanol"]$mq$, 3, $mq$Plants and yeast produce ethanol and carbon dioxide in anaerobic respiration. Lactic acid is made in animals.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Anaerobic Respiration in Muscles and Yeast$mq$ and p.name = $mq$Respiration$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Anaerobic respiration$mq$, $mq$Release of energy from glucose without oxygen. It releases much less energy than aerobic respiration.$mq$),
($mq$Equation for anaerobic respiration in muscles$mq$, $mq$Glucose -> lactic acid (+ energy). No carbon dioxide is made.$mq$),
($mq$Equation for fermentation in yeast$mq$, $mq$Glucose -> ethanol + carbon dioxide (+ energy).$mq$),
($mq$Why do muscles respire anaerobically in a sprint?$mq$, $mq$Oxygen cannot be delivered as quickly as energy is needed.$mq$),
($mq$Muscle fatigue$mq$, $mq$Tiredness and cramp in muscles caused by a build-up of lactic acid.$mq$),
($mq$Oxygen debt$mq$, $mq$The extra oxygen needed after exercise to break down lactic acid, mainly in the liver.$mq$),
($mq$Fermentation uses$mq$, $mq$Baking, where carbon dioxide makes dough rise, and brewing, where the ethanol is the alcohol.$mq$),
($mq$Why is anaerobic respiration less efficient?$mq$, $mq$Glucose is only partly broken down, so most of the energy stays in lactic acid or ethanol.$mq$),
($mq$Why add oil to a yeast experiment?$mq$, $mq$To keep oxygen out so the yeast respires anaerobically.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Anaerobic Respiration in Muscles and Yeast$mq$ and p.name = $mq$Respiration$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Sometimes cells cannot get enough oxygen, or they live where there is none. They can still release some energy from glucose by anaerobic respiration. This is respiration without oxygen.

## Anaerobic respiration in muscles
During hard exercise, such as sprinting, muscles need energy faster than the blood can bring oxygen. The muscle cells then also respire anaerobically:
glucose -> lactic acid (+ a small amount of energy).
Glucose is only partly broken down, so much less energy is released than in aerobic respiration. No carbon dioxide is made. As lactic acid builds up, the muscles become tired and may cramp. This is muscle fatigue.

After exercise, you keep breathing hard and your heart keeps beating fast. The lactic acid is carried by the blood to the liver, where it is broken down using oxygen. The extra oxygen needed is called the oxygen debt. When the debt is repaid, breathing and heart rate return to normal.

## Anaerobic respiration in yeast
Yeast is a single-celled fungus. When it has no oxygen, it carries out fermentation:
glucose -> ethanol + carbon dioxide (+ a small amount of energy).
Plant cells can also do this, for example roots in waterlogged soil.
Fermentation is useful in industry:
- Baking: carbon dioxide makes dough rise. The ethanol evaporates during baking.
- Brewing: the ethanol is the alcohol in beer and wine.

## Comparing aerobic and anaerobic respiration
- Oxygen: aerobic needs it, anaerobic does not.
- Products: aerobic gives carbon dioxide and water, anaerobic gives lactic acid (animals) or ethanol and carbon dioxide (yeast and plants).
- Energy: aerobic releases a lot; anaerobic releases a little.
- Where: aerobic in mitochondria, anaerobic in the cytoplasm.

## Investigating yeast
Mix yeast with sugar solution in a flask. Add a layer of oil to exclude oxygen. Connect a delivery tube to a tube of limewater. If the limewater turns cloudy, carbon dioxide is being produced. You can also count the bubbles per minute at different temperatures: the rate increases up to about 40 degrees Celsius, and then the enzymes denature.

## Worked example
A marathon runner uses mostly aerobic respiration, because the activity is steady and the oxygen supply can keep up. A sprinter running 100 m finishes in 10 seconds. The sprinter's muscles respire both aerobically and anaerobically, and he continues to breathe heavily afterwards to repay the oxygen debt. Explanation: during the sprint, energy demand is higher than the oxygen supply, so lactic acid forms; the heavy breathing afterwards supplies oxygen to break the lactic acid down.

## Common mistakes
- Saying that anaerobic respiration releases no energy. It releases a small amount.
- Saying that humans make ethanol. Muscles make lactic acid.
- Writing that lactic acid is a waste product that has no further use. It is broken down later using oxygen.
- Saying carbon dioxide is produced in muscle anaerobic respiration.
- Confusing the bread-rising gas (carbon dioxide) with the alcohol (ethanol).

## Command terms
- Compare: give similarities and differences of aerobic and anaerobic respiration.
- Describe: say what happens to a sprinter's breathing after a race.
- Explain: give reasons for the oxygen debt.
- Suggest: use ideas to explain what to expect in a new situation, such as a yeast experiment with oil on top.

Exam tip: always name the organism: lactic acid in animals, ethanol and carbon dioxide in yeast and plants.$mq$ from st;

-- Respiration > Measuring Respiration and the Effect of Exercise
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Respiration$mq$, 4, 5 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Measuring Respiration and the Effect of Exercise$mq$, 4, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Respiration$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Measuring Respiration and the Effect of Exercise$mq$ and p.name = $mq$Respiration$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In which unit is heart rate measured?$mq$, $mq$["Beats per minute","Litres per second","Metres per second","Breaths per hour"]$mq$, 0, $mq$Heart rate is the number of heart beats in one minute, written as beats per minute (bpm).$mq$, $mq$easy$mq$),
($mq$Pulse can be felt in which type of blood vessel?$mq$, $mq$["Vein","Capillary","Lymph vessel","Artery"]$mq$, 3, $mq$Each heartbeat sends a surge of blood through the arteries, which can be felt as a pulse at the wrist or neck.$mq$, $mq$easy$mq$),
($mq$What happens to your breathing rate during exercise?$mq$, $mq$["It decreases","It stays the same","It increases","It stops"]$mq$, 2, $mq$Muscles respire faster during exercise, so breathing rate rises to supply more oxygen and remove carbon dioxide.$mq$, $mq$easy$mq$),
($mq$Name the time taken for heart rate to return to normal after exercise.$mq$, $mq$["Reaction time","Recovery time","Resting time","Rise time"]$mq$, 1, $mq$Recovery time is a measure of fitness. A fitter person has a shorter recovery time.$mq$, $mq$easy$mq$),
($mq$Name the apparatus used to measure oxygen uptake by small living organisms such as germinating peas.$mq$, $mq$["Respirometer","Thermometer","Microscope","Calorimeter"]$mq$, 0, $mq$A respirometer measures how quickly a small organism takes in oxygen, usually by watching a liquid move along a scale.$mq$, $mq$easy$mq$),
($mq$Why does heart rate increase during exercise?$mq$, $mq$["The heart needs to cool","The body is removing water","The lungs need to fill","Muscles need more oxygen and glucose"]$mq$, 3, $mq$A faster heart rate pumps blood to the muscles more quickly, delivering more oxygen and glucose and removing carbon dioxide.$mq$, $mq$medium$mq$),
($mq$Soda lime is placed in a respirometer. Which gas does it absorb?$mq$, $mq$["Oxygen","Nitrogen","Carbon dioxide","Water vapour"]$mq$, 2, $mq$Soda lime absorbs the carbon dioxide produced, so any change in gas volume is caused by oxygen being taken in.$mq$, $mq$medium$mq$),
($mq$In a respirometer the coloured liquid moves towards the germinating peas. What causes this?$mq$, $mq$["Oxygen is produced","Oxygen is used up","Carbon dioxide is added","Water is produced"]$mq$, 1, $mq$The peas use oxygen and the carbon dioxide is absorbed, so the gas volume falls and the liquid is drawn towards the peas.$mq$, $mq$medium$mq$),
($mq$Breathing rate rises from 15 to 30 breaths per minute during exercise. What is the percentage increase?$mq$, $mq$["100%","50%","15%","200%"]$mq$, 0, $mq$Percentage increase = (30 - 15) ÷ 15 x 100 = 100%.$mq$, $mq$medium$mq$),
($mq$The liquid in a respirometer moves 24 mm in 8 minutes. What is the rate?$mq$, $mq$["192 mm per minute","0.33 mm per minute","8 mm per minute","3 mm per minute"]$mq$, 3, $mq$Rate = distance ÷ time = 24 ÷ 8 = 3 mm per minute.$mq$, $mq$medium$mq$),
($mq$A tube containing glass beads is set up alongside the tube of peas. What is its purpose?$mq$, $mq$["To produce carbon dioxide","To cool the peas","To act as a control","To absorb oxygen"]$mq$, 2, $mq$The control tube has no living organisms, so it shows whether changes in pressure or temperature in the room affect the liquid.$mq$, $mq$medium$mq$),
($mq$Which organ stores glycogen, which can be turned into glucose when needed during exercise?$mq$, $mq$["Kidney","Liver","Stomach","Lung"]$mq$, 1, $mq$The liver and the muscles store glycogen. The liver converts it back into glucose and releases it into the blood.$mq$, $mq$medium$mq$),
($mq$A fit athlete has a lower resting heart rate than a less fit person. What is the reason?$mq$, $mq$["The heart pumps more blood each beat","The heart is smaller","The blood is thicker","The lungs are smaller"]$mq$, 0, $mq$Regular exercise strengthens the heart muscle, so each beat pushes out more blood and fewer beats are needed.$mq$, $mq$medium$mq$),
($mq$A student's heart rate is 72 beats per minute at rest and 148 immediately after exercise. What is the percentage increase, to the nearest whole number?$mq$, $mq$["51%","76%","205%","106%"]$mq$, 3, $mq$Increase = 148 - 72 = 76. Percentage = 76 ÷ 72 x 100 = 105.6%, which is 106% to the nearest whole number.$mq$, $mq$hard$mq$),
($mq$Liquid in a respirometer moves 3, 6 and 12 mm in 10 minutes at 10, 20 and 30 degrees Celsius. What is the rate at 30 degrees Celsius?$mq$, $mq$["12 mm per minute","0.12 mm per minute","1.2 mm per minute","120 mm per minute"]$mq$, 2, $mq$Rate = 12 mm ÷ 10 minutes = 1.2 mm per minute.$mq$, $mq$hard$mq$),
($mq$Why does the rate of respiration in peas rise as the temperature rises from 10 to 30 degrees Celsius?$mq$, $mq$["The peas make more oxygen","The respiration enzymes work faster","The soda lime absorbs more","The peas photosynthesise"]$mq$, 1, $mq$Respiration is controlled by enzymes, which work faster as the temperature rises towards their optimum, so more oxygen is taken in.$mq$, $mq$hard$mq$),
($mq$A person breathes 15 times per minute, taking in 500 cm cubed with each breath. What volume of air is breathed per minute?$mq$, $mq$["7500 cm cubed","750 cm cubed","515 cm cubed","3750 cm cubed"]$mq$, 0, $mq$Volume per minute = breathing rate x volume per breath = 15 x 500 = 7500 cm cubed.$mq$, $mq$hard$mq$),
($mq$Why does a person keep breathing fast after exercise has stopped?$mq$, $mq$["To make more lactic acid","To cool the lungs","To digest food","To repay the oxygen debt"]$mq$, 3, $mq$After exercise the body still needs extra oxygen to break down lactic acid, so breathing stays fast until the debt is repaid.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Measuring Respiration and the Effect of Exercise$mq$ and p.name = $mq$Respiration$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Why does heart rate rise during exercise?$mq$, $mq$To deliver more oxygen and glucose to the muscles and remove carbon dioxide faster.$mq$),
($mq$Why does breathing rate rise during exercise?$mq$, $mq$Muscles respire faster, so more oxygen is needed and more carbon dioxide must be removed.$mq$),
($mq$Recovery time$mq$, $mq$The time for heart rate to return to its resting value after exercise. Shorter in fitter people.$mq$),
($mq$Respirometer$mq$, $mq$Apparatus that measures oxygen uptake of small organisms by watching a liquid move along a scale.$mq$),
($mq$Why use soda lime in a respirometer?$mq$, $mq$It absorbs carbon dioxide, so the volume change is due to oxygen uptake only.$mq$),
($mq$Why use a control tube in a respirometer?$mq$, $mq$It has no living organism, so it shows whether temperature or pressure changes are moving the liquid.$mq$),
($mq$Percentage change$mq$, $mq$(new value - original value) ÷ original value x 100.$mq$),
($mq$Rate of oxygen uptake$mq$, $mq$Distance moved by liquid ÷ time, for example 24 mm in 8 minutes is 3 mm per minute.$mq$),
($mq$Why does a fitter person have a lower resting heart rate?$mq$, $mq$The heart muscle is stronger, so each beat pumps more blood.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Measuring Respiration and the Effect of Exercise$mq$ and p.name = $mq$Respiration$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$The effect of exercise on the body is a good way to see respiration in action. When muscles contract more, they need more energy, and this energy comes from respiration. There are therefore changes in the heart rate and breathing rate.

## Changes during exercise
- Muscles respire faster, using more glucose and oxygen and producing more carbon dioxide.
- Breathing rate and depth increase to bring more oxygen into the blood and remove more carbon dioxide.
- Heart rate increases to carry blood faster, delivering more oxygen and glucose and taking away carbon dioxide.
- If oxygen cannot keep up, muscles respire anaerobically and lactic acid builds up.
After exercise, the breathing rate and heart rate stay high for some time while the oxygen debt is repaid. The time taken for the heart rate to return to its resting value is the recovery time. A fit person has a lower resting heart rate, because their stronger heart pumps more blood per beat, and a shorter recovery time.

## Investigation: exercise and pulse
Measure resting pulse for one minute (or 15 seconds x 4). Exercise for a fixed time, such as 2 minutes of step-ups. Measure the pulse immediately and then every minute until it returns to the resting value. Independent variable: type or length of exercise. Dependent variable: pulse rate and recovery time. Control: the same person, the same step height and the same method of counting. Repeat and calculate a mean, as heart rate varies between attempts.

## Measuring respiration with a respirometer
A respirometer is a sealed tube containing living organisms, such as germinating peas, and soda lime to absorb carbon dioxide. A tube with a scale and a drop of coloured liquid is attached. As the peas respire, they take in oxygen and the carbon dioxide is absorbed, so the gas volume falls and the liquid moves towards the peas. The distance moved in a certain time shows the rate of oxygen uptake. A control tube with glass beads or boiled peas shows whether changes in temperature or pressure are affecting the liquid. The experiment can be repeated at different temperatures.

## Worked example 1
The liquid moves 18 mm in 6 minutes. Rate = 18 ÷ 6 = 3 mm per minute. If the temperature is raised and it moves 30 mm in 6 minutes, rate = 5 mm per minute. Percentage increase = (5 - 3) ÷ 3 x 100 = 67%.

## Worked example 2
Resting heart rate: 70 bpm. After exercise: 140 bpm. Percentage increase = (140 - 70) ÷ 70 x 100 = 100%. Minute volume of breathing = breathing rate x volume per breath. With 12 breaths per minute and 500 cm cubed per breath, minute volume = 12 x 500 = 6,000 cm cubed per minute.

## Common mistakes
- Dividing by the new value instead of the original value when calculating percentage change.
- Forgetting soda lime, which means carbon dioxide production hides the oxygen uptake.
- Not allowing the respirometer to reach the water bath temperature before starting.
- Taking only one measurement of pulse.
- Saying that breathing is faster in exercise because the lungs "need more air". The correct reason is that the muscles need more oxygen for respiration.

## Command terms
- Calculate: percentage change or rate, with working.
- Describe: how pulse rate changes during and after exercise.
- Explain: why the changes happen, using respiration.
- Evaluate: how well the respirometer controls other variables, and how it could be improved.
- Suggest: how the investigation could be improved with data loggers or repeated trials.

Exam tip: link every change in heart or breathing rate to the demand of muscles for oxygen and glucose for respiration, and the need to remove carbon dioxide.$mq$ from st;

-- Human Digestive and Circulatory Systems > Organs of the Alimentary Canal and Absorption
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Human Digestive and Circulatory Systems$mq$, 4, 6 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Organs of the Alimentary Canal and Absorption$mq$, 4, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Human Digestive and Circulatory Systems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Organs of the Alimentary Canal and Absorption$mq$ and p.name = $mq$Human Digestive and Circulatory Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the name for the waves of muscle contraction that push food along the oesophagus?$mq$, $mq$["Peristalsis","Diffusion","Egestion","Emulsification"]$mq$, 0, $mq$Peristalsis is the rhythmic squeezing of circular and longitudinal muscles in the gut wall that moves food along.$mq$, $mq$easy$mq$),
($mq$Which organ of the alimentary canal absorbs most of the digested food into the blood?$mq$, $mq$["Large intestine","Stomach","Oesophagus","Small intestine"]$mq$, 3, $mq$The small intestine is long, lined with villi and has a rich blood supply, so most absorption happens there.$mq$, $mq$easy$mq$),
($mq$Which organ stores bile until it is needed?$mq$, $mq$["Stomach","Liver","Gall bladder","Pancreas"]$mq$, 2, $mq$Bile is made in the liver but stored in the gall bladder, then released into the small intestine.$mq$, $mq$easy$mq$),
($mq$What is the term for removing undigested food from the body through the anus?$mq$, $mq$["Ingestion","Egestion","Excretion","Assimilation"]$mq$, 1, $mq$Egestion is the removal of undigested material (faeces). Excretion is the removal of metabolic waste such as urea.$mq$, $mq$easy$mq$),
($mq$Which acid in the stomach kills many microorganisms in food?$mq$, $mq$["Hydrochloric acid","Sulfuric acid","Lactic acid","Carbonic acid"]$mq$, 0, $mq$The stomach makes hydrochloric acid, which kills many pathogens and gives pepsin the acidic conditions it needs.$mq$, $mq$easy$mq$),
($mq$Which part of the alimentary canal absorbs the water that is left in undigested food, so that solid faeces form?$mq$, $mq$["Gall bladder","Stomach","Oesophagus","Large intestine"]$mq$, 3, $mq$The large intestine absorbs water, leaving a more solid waste called faeces.$mq$, $mq$medium$mq$),
($mq$Which substance, made in the liver, breaks large fat droplets into many small droplets?$mq$, $mq$["Amylase","Lipase","Bile","Pepsin"]$mq$, 2, $mq$Bile emulsifies fat, which gives lipase a larger surface area to work on. Bile itself is not an enzyme.$mq$, $mq$medium$mq$),
($mq$Which organ releases a juice containing amylase, protease and lipase into the small intestine?$mq$, $mq$["Liver","Pancreas","Gall bladder","Salivary gland"]$mq$, 1, $mq$The pancreas makes pancreatic juice containing all three types of digestive enzyme.$mq$, $mq$medium$mq$),
($mq$The wall of the small intestine is covered in villi. What do villi increase?$mq$, $mq$["Surface area","Gut temperature","Enzyme concentration","Speed of peristalsis"]$mq$, 0, $mq$Villi greatly increase the surface area for absorption, so more nutrients can diffuse into the blood in a given time.$mq$, $mq$medium$mq$),
($mq$Each villus contains a small lymph vessel in the centre. What is it called?$mq$, $mq$["Capillary","Alveolus","Sphincter","Lacteal"]$mq$, 3, $mq$The lacteal absorbs fatty acids and glycerol, which later enter the blood. Glucose and amino acids enter the blood capillaries.$mq$, $mq$medium$mq$),
($mq$Which products of fat digestion are absorbed along with glycerol?$mq$, $mq$["Amino acids","Glucose","Fatty acids","Maltose"]$mq$, 2, $mq$Lipase breaks fats into fatty acids and glycerol, and both are absorbed into the lacteal.$mq$, $mq$medium$mq$),
($mq$A disease flattens the villi in a person's small intestine. What is the main effect?$mq$, $mq$["More bile production","Less nutrient absorption","Faster stomach emptying","More water absorbed in the stomach"]$mq$, 1, $mq$Flatter villi mean a much smaller surface area, so less digested food is absorbed and the person may lose weight.$mq$, $mq$medium$mq$),
($mq$A model gut has an inner surface area of 400 cm². Villi increase this area 30 times. What is the new area in cm²?$mq$, $mq$["12000","13","430","1200"]$mq$, 0, $mq$400 × 30 = 12 000 cm². Multiplying by the factor gives the new area.$mq$, $mq$medium$mq$),
($mq$Faeces leaving through the anus is called egestion rather than excretion. What is the reason?$mq$, $mq$["It is mostly urea","It is made in the liver cells","It is absorbed and then released by the kidneys","It was never part of cell metabolism"]$mq$, 3, $mq$Excretion removes waste made by metabolic reactions inside cells. Faeces are mostly undigested food that never entered the body's cells.$mq$, $mq$hard$mq$),
($mq$Visking tubing containing starch and glucose solution is placed in water. After 20 minutes glucose is found in the water but starch is not. What does this show?$mq$, $mq$["Glucose molecules are too large to pass through","Starch dissolves faster than glucose","Starch molecules are too large to pass through","The tubing is fully permeable"]$mq$, 2, $mq$Visking tubing models the gut wall. Small glucose molecules diffuse through its pores but large starch molecules cannot, which is why starch must be digested before absorption.$mq$, $mq$hard$mq$),
($mq$After a person has their gall bladder removed, a very fatty meal is digested more slowly. What is the best explanation?$mq$, $mq$["The liver no longer makes bile","Less bile reaches the small intestine at once","Lipase can no longer be made","The villi stop absorbing fat"]$mq$, 1, $mq$The liver still makes bile, but without storage it trickles in steadily instead of being released in a surge, so less emulsification occurs after a big fatty meal.$mq$, $mq$hard$mq$),
($mq$Blood carrying glucose from the small intestine travels first to which organ?$mq$, $mq$["Liver","Pancreas","Heart","Kidney"]$mq$, 0, $mq$The hepatic portal vein carries absorbed nutrients to the liver, which regulates what enters the main circulation.$mq$, $mq$hard$mq$),
($mq$Why must stomach acid be neutralised when food enters the small intestine?$mq$, $mq$["Acid would be absorbed by the villi","Acid stops peristalsis","Bile only works in acid","Intestinal enzymes work best in alkaline conditions"]$mq$, 3, $mq$Bile is alkaline and neutralises the acid. The enzymes of the small intestine have an optimum pH that is slightly alkaline, unlike pepsin, which prefers acid.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Organs of the Alimentary Canal and Absorption$mq$ and p.name = $mq$Human Digestive and Circulatory Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Peristalsis$mq$, $mq$Waves of muscle contraction in the gut wall that push food along the alimentary canal.$mq$),
($mq$Function of bile$mq$, $mq$Made in the liver, stored in the gall bladder. It neutralises stomach acid and emulsifies fat to give a larger surface area for lipase.$mq$),
($mq$Where is most food absorbed?$mq$, $mq$In the small intestine (ileum), which is long and lined with villi.$mq$),
($mq$Adaptations of a villus$mq$, $mq$Large surface area, thin one-cell wall, rich blood supply and a lacteal. All of these make absorption fast.$mq$),
($mq$What is absorbed into the lacteal?$mq$, $mq$Fatty acids and glycerol. Glucose and amino acids go into blood capillaries.$mq$),
($mq$Role of the large intestine$mq$, $mq$Absorbs water from undigested food, leaving faeces.$mq$),
($mq$Egestion vs excretion$mq$, $mq$Egestion removes undigested food (faeces). Excretion removes waste made by metabolism, such as urea and carbon dioxide.$mq$),
($mq$Role of stomach acid$mq$, $mq$Hydrochloric acid kills pathogens and gives pepsin its acidic optimum pH.$mq$),
($mq$Five stages of nutrition in order$mq$, $mq$Ingestion, digestion, absorption, assimilation, egestion.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Organs of the Alimentary Canal and Absorption$mq$ and p.name = $mq$Human Digestive and Circulatory Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$The alimentary canal is a long muscular tube that runs from the mouth to the anus. Its job is to break food into small soluble molecules and to absorb them into the blood. Five processes happen in order: ingestion (taking food in), digestion (breaking food down), absorption (moving small molecules into the blood), assimilation (using the molecules in cells) and egestion (removing undigested material).

## Journey of food
- **Mouth**: teeth carry out mechanical digestion, cutting food into smaller pieces with a bigger surface area. Saliva contains amylase, which starts to digest starch.
- **Oesophagus**: a muscular tube. Muscles squeeze behind the food in waves called **peristalsis**, so food moves even when you are lying down.
- **Stomach**: churns food and mixes it with gastric juice. Hydrochloric acid kills many pathogens, and the enzyme pepsin digests protein.
- **Small intestine**: the first part (duodenum) receives bile and pancreatic juice. The rest (ileum) is where most absorption occurs.
- **Large intestine**: absorbs water from the remaining material.
- **Rectum and anus**: store faeces and then egest them.

## Helper organs
The **liver** makes bile and the **gall bladder** stores it. Bile is alkaline, so it neutralises acid from the stomach, and it emulsifies fats, breaking big droplets into many small ones. This does not digest the fat chemically, but it gives lipase a much larger surface area. The **pancreas** makes juice containing amylase, protease and lipase and releases it into the small intestine.

## Absorption and villi
The wall of the small intestine is folded and covered in tiny finger-like villi. Each villus has a thin wall, only one cell thick, a rich supply of blood capillaries and a central lacteal. These features give a large surface area, a short diffusion distance and a steep concentration gradient, because blood carries absorbed molecules away. Glucose and amino acids enter the capillaries. Fatty acids and glycerol enter the lacteal. Blood from the small intestine flows through the hepatic portal vein to the liver before reaching the rest of the body.

## Worked example
A section of gut has an inner surface area of 400 cm² before folding. Folds and villi multiply the area by 30. New area = 400 × 30 = 12 000 cm². Explain: a larger area lets more molecules be absorbed every second.

## Common mistakes
- Saying bile is an enzyme. It is not; it emulsifies fat and neutralises acid.
- Saying bile is made in the gall bladder. It is made in the liver and stored in the gall bladder.
- Confusing egestion (undigested food) with excretion (metabolic waste such as urea).
- Saying most water is absorbed in the stomach. Very little water is absorbed there. Most is absorbed in the small intestine, and the large intestine absorbs the water that is left in the undigested food.

## How this is examined
Questions often give a diagram of the gut and ask you to name organs, then use a data table such as villus length or surface area. Criterion A tasks use command terms such as state, describe and explain. For explain questions, link the structure to its function, for example thin wall means short diffusion distance. Criterion C tasks may ask you to evaluate a model such as Visking tubing, noting that it does not have villi or blood flow.

Exam tip: when you explain an adaptation, always write structure, then function, then effect, for example "villi give a large surface area, so absorption is faster".$mq$ from st;

-- Human Digestive and Circulatory Systems > Heart Structure and the Double Circulation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Human Digestive and Circulatory Systems$mq$, 4, 6 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Heart Structure and the Double Circulation$mq$, 4, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Human Digestive and Circulatory Systems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Heart Structure and the Double Circulation$mq$ and p.name = $mq$Human Digestive and Circulatory Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which chamber of the heart pumps oxygenated blood around the whole body?$mq$, $mq$["Left ventricle","Right ventricle","Left atrium","Right atrium"]$mq$, 0, $mq$The left ventricle pumps blood into the aorta at high pressure to supply the whole body.$mq$, $mq$easy$mq$),
($mq$Name the blood vessel that carries blood from the heart to the lungs.$mq$, $mq$["Pulmonary vein","Aorta","Vena cava","Pulmonary artery"]$mq$, 3, $mq$The pulmonary artery carries deoxygenated blood from the right ventricle to the lungs.$mq$, $mq$easy$mq$),
($mq$What is the job of the valves in the heart?$mq$, $mq$["Add oxygen to blood","Pump blood faster","Stop blood flowing backwards","Filter out bacteria"]$mq$, 2, $mq$Valves open one way only, so blood moves in one direction through the heart.$mq$, $mq$easy$mq$),
($mq$Which vessels supply the heart muscle itself with oxygenated blood?$mq$, $mq$["Hepatic veins","Coronary arteries","Pulmonary veins","Vena cava"]$mq$, 1, $mq$The coronary arteries run over the surface of the heart. If one is blocked, part of the heart muscle is starved of oxygen.$mq$, $mq$easy$mq$),
($mq$How many chambers does the human heart have?$mq$, $mq$["4","2","3","6"]$mq$, 0, $mq$There are two atria and two ventricles.$mq$, $mq$easy$mq$),
($mq$Which chamber receives oxygenated blood from the lungs?$mq$, $mq$["Right atrium","Left ventricle","Right ventricle","Left atrium"]$mq$, 3, $mq$Pulmonary veins bring oxygenated blood from the lungs into the left atrium.$mq$, $mq$medium$mq$),
($mq$Why is the wall of the left ventricle thicker than the wall of the right ventricle?$mq$, $mq$["It receives blood from the body","It holds the valves","It pumps blood at higher pressure","It pumps deoxygenated blood"]$mq$, 2, $mq$The left ventricle sends blood around the whole body, which needs more force than sending blood to the nearby lungs.$mq$, $mq$medium$mq$),
($mq$Blood passes through the heart twice in one complete circuit of the body. What is this called?$mq$, $mq$["Single circulation","Double circulation","Peristalsis","Ventilation"]$mq$, 1, $mq$One loop goes heart to lungs to heart (pulmonary) and the other goes heart to body to heart (systemic).$mq$, $mq$medium$mq$),
($mq$What is the main function of the septum in the heart?$mq$, $mq$["Keeps oxygenated and deoxygenated blood apart","Prevents backflow into the atria","Pumps blood into the aorta","Supplies oxygen to the heart muscle"]$mq$, 0, $mq$The septum is the wall between the left and right sides. Preventing backflow is the job of valves.$mq$, $mq$medium$mq$),
($mq$Cardiac output = stroke volume × heart rate. A person has a stroke volume of 70 cm³ and a heart rate of 72 beats per minute. What is the cardiac output in cm³ per minute?$mq$, $mq$["50400","142","504","5040"]$mq$, 3, $mq$70 × 72 = 5040 cm³ per minute.$mq$, $mq$medium$mq$),
($mq$A person's resting heart rate is 64 beats per minute and rises to 148 beats per minute during running. By how many beats per minute does it rise?$mq$, $mq$["212","94","84","74"]$mq$, 2, $mq$148 − 64 = 84 beats per minute.$mq$, $mq$medium$mq$),
($mq$Which vessel returns deoxygenated blood from the body to the right atrium?$mq$, $mq$["Pulmonary vein","Vena cava","Aorta","Coronary artery"]$mq$, 1, $mq$The vena cava is the large vein that carries blood from the body into the right atrium.$mq$, $mq$medium$mq$),
($mq$Why can a pulse be felt at the wrist?$mq$, $mq$["Surges of blood stretch the artery wall","The bones vibrate with each beat","Veins contract at the wrist","Valves close in the capillaries"]$mq$, 0, $mq$Each contraction of the ventricles sends a pressure surge along the arteries, which makes the artery wall stretch and recoil.$mq$, $mq$medium$mq$),
($mq$What is the advantage of a double circulation compared with a single circulation?$mq$, $mq$["Blood gains oxygen twice in the body","Deoxygenated blood skips the lungs","Blood travels a shorter distance","Blood pressure is raised again after the lungs"]$mq$, 3, $mq$In a single circulation blood loses pressure in the gas exchange organ. In a double circulation the heart boosts the pressure again, so tissues are supplied faster.$mq$, $mq$hard$mq$),
($mq$The valve between the left atrium and left ventricle is faulty and leaks. What is the likely effect?$mq$, $mq$["Blood flows from the aorta into the right ventricle","Blood cannot leave the right atrium","Some blood flows back into the left atrium","Blood stops entering the lungs"]$mq$, 2, $mq$A leaking valve lets blood move backwards when the ventricle contracts, so less blood is pumped into the aorta with each beat.$mq$, $mq$hard$mq$),
($mq$A baby is born with a hole in the septum between the two ventricles. What is the main problem this causes?$mq$, $mq$["The heart cannot beat","Blood with different oxygen levels mixes","No blood reaches the lungs","Blood flows only to the heart muscle"]$mq$, 1, $mq$Mixing means the blood sent to the body is less well oxygenated, so tissues may get too little oxygen.$mq$, $mq$hard$mq$),
($mq$A person's cardiac output is 6000 cm³ per minute with a stroke volume of 80 cm³ and heart rate of 75 beats per minute. After training, the stroke volume is 100 cm³ and cardiac output is unchanged. What is the new heart rate in beats per minute?$mq$, $mq$["60","75","80","48"]$mq$, 0, $mq$Heart rate = 6000 ÷ 100 = 60 beats per minute. A bigger stroke volume lets the heart beat more slowly for the same output.$mq$, $mq$hard$mq$),
($mq$Trained athletes often have a lower resting heart rate than other people. What is the best explanation?$mq$, $mq$["Each beat pumps a smaller volume of blood","Their heart walls are thinner","They breathe more quickly at rest","Each beat pumps a larger volume of blood"]$mq$, 3, $mq$Training strengthens heart muscle, which increases stroke volume, so fewer beats per minute supply the same amount of blood.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Heart Structure and the Double Circulation$mq$ and p.name = $mq$Human Digestive and Circulatory Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Four chambers of the heart$mq$, $mq$Right atrium, right ventricle, left atrium and left ventricle. Atria receive blood and ventricles pump it out.$mq$),
($mq$Path of blood from the body$mq$, $mq$Vena cava, right atrium, right ventricle, pulmonary artery, lungs, pulmonary vein, left atrium, left ventricle, aorta.$mq$),
($mq$Why is the left ventricle wall thicker?$mq$, $mq$It pumps blood at high pressure around the whole body, not just to the nearby lungs.$mq$),
($mq$Role of heart valves$mq$, $mq$Stop blood flowing backwards, so it moves in one direction.$mq$),
($mq$Double circulation$mq$, $mq$Blood passes through the heart twice per full circuit: pulmonary (heart-lungs-heart) and systemic (heart-body-heart).$mq$),
($mq$Coronary arteries$mq$, $mq$Supply the heart muscle with oxygen and glucose. A blockage can cause a heart attack.$mq$),
($mq$Cardiac output formula$mq$, $mq$Cardiac output = stroke volume × heart rate (for example 70 cm³ × 72 per minute = 5040 cm³ per minute).$mq$),
($mq$Role of the septum$mq$, $mq$Separates the left and right sides so oxygenated and deoxygenated blood do not mix.$mq$),
($mq$Why does exercise raise heart rate?$mq$, $mq$Muscles respire faster and need more oxygen and glucose, and the blood removes carbon dioxide faster.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Heart Structure and the Double Circulation$mq$ and p.name = $mq$Human Digestive and Circulatory Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$The heart is a muscular pump that keeps blood flowing around the body. In humans it has four chambers: two upper atria that receive blood, and two lower ventricles that pump it out. A wall of muscle called the septum separates the left side from the right side, so oxygenated and deoxygenated blood never mix.

## Following the blood
Deoxygenated blood from the body enters the right atrium through the vena cava. It passes through a valve into the right ventricle, which pumps it through the pulmonary artery to the lungs. In the lungs the blood picks up oxygen and gives out carbon dioxide. Oxygenated blood returns through the pulmonary vein to the left atrium, passes through a valve into the left ventricle and is pumped out through the aorta to the body. Remember the useful rule: arteries carry blood away from the heart, and veins carry blood towards the heart. The pulmonary artery is unusual because it carries deoxygenated blood, and the pulmonary vein carries oxygenated blood.

## Double circulation
Blood travels through the heart twice on each full trip around the body. The pulmonary circuit goes heart, lungs, heart. The systemic circuit goes heart, body, heart. This is a double circulation. It lets the heart raise the pressure again after the blood has slowed down in the narrow lung capillaries, so oxygen reaches the body quickly. This supports the high metabolic rate of mammals.

## Structures and their functions
- **Valves**: open one way only and stop backflow. They are found between atria and ventricles and at the start of the arteries.
- **Thick left ventricle wall**: the left ventricle pumps blood around the whole body at high pressure.
- **Coronary arteries**: supply the heart muscle with oxygen and glucose. A blockage causes a heart attack.

## Heart rate and cardiac output
Heart rate is the number of beats per minute. Stroke volume is the volume of blood pumped by one ventricle in one beat. Cardiac output = stroke volume × heart rate. Worked example: stroke volume 70 cm³ and heart rate 72 beats per minute gives 70 × 72 = 5040 cm³ per minute. During exercise, muscles respire faster and need more oxygen, so heart rate increases and cardiac output rises. Regular training increases stroke volume, so the resting heart rate falls.

## Common mistakes
- Saying that arteries always carry oxygenated blood. The pulmonary artery does not.
- Drawing the heart from your own point of view. The left side of a diagram is the patient's right side.
- Saying that the right ventricle is thicker. The left ventricle has the thickest wall.
- Saying that the heart gets oxygen from the blood inside its chambers. It is supplied by the coronary arteries.

## How this is examined
Typical items give a labelled heart diagram and ask you to name chambers, trace the flow of blood or explain wall thickness. Data tasks may give heart rates before and after exercise, asking you to calculate change or percentage change. Criterion C questions may ask you to evaluate evidence that exercise lowers resting heart rate.

Exam tip: when you describe the path of blood, name every chamber, valve and vessel in order, and always state whether the blood is oxygenated or deoxygenated.$mq$ from st;

-- Human Digestive and Circulatory Systems > Blood Vessels and Blood Components
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Human Digestive and Circulatory Systems$mq$, 4, 6 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Blood Vessels and Blood Components$mq$, 4, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Human Digestive and Circulatory Systems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Blood Vessels and Blood Components$mq$ and p.name = $mq$Human Digestive and Circulatory Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which blood vessels carry blood away from the heart?$mq$, $mq$["Arteries","Capillaries","Veins","Venules"]$mq$, 0, $mq$Arteries carry blood away from the heart at high pressure.$mq$, $mq$easy$mq$),
($mq$Which blood cells carry oxygen around the body?$mq$, $mq$["White blood cells","Platelets","Plasma","Red blood cells"]$mq$, 3, $mq$Red blood cells contain haemoglobin, which binds oxygen.$mq$, $mq$easy$mq$),
($mq$Which pigment in red blood cells binds to oxygen?$mq$, $mq$["Keratin","Chlorophyll","Haemoglobin","Melanin"]$mq$, 2, $mq$Haemoglobin combines with oxygen in the lungs to form oxyhaemoglobin.$mq$, $mq$easy$mq$),
($mq$What is the liquid part of blood called?$mq$, $mq$["Haemoglobin","Plasma","Cytoplasm","Platelets"]$mq$, 1, $mq$Plasma is a pale yellow liquid that carries blood cells and dissolved substances.$mq$, $mq$easy$mq$),
($mq$Which blood component helps blood to clot at a cut?$mq$, $mq$["Platelets","Haemoglobin","Red blood cells","Phagocytes"]$mq$, 0, $mq$Platelets are cell fragments that help form a clot and seal wounds.$mq$, $mq$easy$mq$),
($mq$Which type of blood vessel contains valves?$mq$, $mq$["Arteries","Capillaries","Aorta","Veins"]$mq$, 3, $mq$Blood in veins is at low pressure, so valves stop it flowing backwards.$mq$, $mq$medium$mq$),
($mq$Capillary walls are only one cell thick. What does this allow?$mq$, $mq$["High blood pressure","Prevention of backflow","Fast diffusion of substances","Blood clotting"]$mq$, 2, $mq$A thin wall means a short diffusion distance, so oxygen, glucose and carbon dioxide can exchange quickly.$mq$, $mq$medium$mq$),
($mq$What shape is a red blood cell?$mq$, $mq$["Sphere","Biconcave disc","Cuboid","Spiral"]$mq$, 1, $mq$The biconcave shape gives a large surface area for taking up oxygen.$mq$, $mq$medium$mq$),
($mq$Which type of white blood cell engulfs pathogens?$mq$, $mq$["Phagocytes","Platelets","Red cells","Neurones"]$mq$, 0, $mq$Phagocytes surround and digest pathogens by phagocytosis.$mq$, $mq$medium$mq$),
($mq$A person has 5.0 dm³ of blood and 55% is plasma. What volume of plasma do they have in dm³?$mq$, $mq$["2.25","0.55","27.5","2.75"]$mq$, 3, $mq$55% of 5.0 = 0.55 × 5.0 = 2.75 dm³.$mq$, $mq$medium$mq$),
($mq$Why do arteries have thick, elastic walls?$mq$, $mq$["To store oxygen","To let substances diffuse out","To withstand high pressure","To prevent backflow"]$mq$, 2, $mq$Blood leaves the heart at high pressure. Thick muscle and elastic fibres stop the walls bursting and help to keep blood moving.$mq$, $mq$medium$mq$),
($mq$Which waste substance is carried dissolved in plasma to the kidneys?$mq$, $mq$["Starch","Urea","Haemoglobin","Fibrin"]$mq$, 1, $mq$Urea is made in the liver from excess amino acids and travels in the plasma to the kidneys.$mq$, $mq$medium$mq$),
($mq$Why do mature red blood cells have no nucleus?$mq$, $mq$["More room for haemoglobin","So they can divide faster","So they can make antibodies","So they can digest bacteria"]$mq$, 0, $mq$Without a nucleus there is more space inside the cell for haemoglobin, so each cell carries more oxygen.$mq$, $mq$medium$mq$),
($mq$A person moves to live at high altitude, where the air has less oxygen. After some weeks, what change is expected in the blood?$mq$, $mq$["More platelets are made","Fewer red blood cells are made","The plasma becomes thicker","More red blood cells are made"]$mq$, 3, $mq$The body responds to low oxygen by making more red blood cells, which increases the oxygen carried per dm³ of blood.$mq$, $mq$hard$mq$),
($mq$Blood in a leg vessel flows towards the heart at low pressure, helped by squeezing from nearby muscles. Which vessel is it?$mq$, $mq$["Capillary","Artery","Vein","Aorta"]$mq$, 2, $mq$Veins have low pressure, wide lumens and valves, and rely on muscle squeezing to push blood back to the heart.$mq$, $mq$hard$mq$),
($mq$Which protein forms a mesh of threads that traps blood cells in a clot?$mq$, $mq$["Keratin","Fibrin","Haemoglobin","Amylase"]$mq$, 1, $mq$Platelets release chemicals that convert soluble fibrinogen to insoluble fibrin threads, forming a clot.$mq$, $mq$hard$mq$),
($mq$A centrifuged blood sample contains 45% red blood cells and 1% white cells and platelets. What percentage is plasma?$mq$, $mq$["54","55","46","44"]$mq$, 0, $mq$Cells make up 45 + 1 = 46%. Plasma is 100 − 46 = 54%.$mq$, $mq$hard$mq$),
($mq$People with anaemia have too little haemoglobin and often feel tired. What is the best explanation?$mq$, $mq$["Their blood clots too quickly","They have too much plasma protein","Phagocytes attack their red cells","Their tissues receive less oxygen"]$mq$, 3, $mq$Less haemoglobin means less oxygen delivered to respiring cells, so less energy is released.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Blood Vessels and Blood Components$mq$ and p.name = $mq$Human Digestive and Circulatory Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Artery structure$mq$, $mq$Thick muscular and elastic wall, narrow lumen, high pressure. Carries blood away from the heart.$mq$),
($mq$Vein structure$mq$, $mq$Thinner wall, wide lumen, valves, low pressure. Carries blood towards the heart.$mq$),
($mq$Capillary structure$mq$, $mq$Wall one cell thick, which gives a short diffusion distance for exchange of substances.$mq$),
($mq$Plasma$mq$, $mq$Liquid part of blood (about 55%). Carries dissolved glucose, amino acids, urea, hormones and carbon dioxide, and heat.$mq$),
($mq$Red blood cell adaptations$mq$, $mq$Biconcave shape for a large surface area, no nucleus for more haemoglobin, and haemoglobin to carry oxygen.$mq$),
($mq$Haemoglobin$mq$, $mq$Red pigment in red blood cells that binds oxygen in the lungs to form oxyhaemoglobin.$mq$),
($mq$Function of platelets$mq$, $mq$Cell fragments that help blood clot by forming a fibrin mesh, sealing wounds and keeping pathogens out.$mq$),
($mq$Function of white blood cells$mq$, $mq$Defend against disease. Phagocytes engulf pathogens and lymphocytes make antibodies.$mq$),
($mq$Why does anaemia cause tiredness?$mq$, $mq$Too little haemoglobin means less oxygen is delivered, so cells release less energy by respiration.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Blood Vessels and Blood Components$mq$ and p.name = $mq$Human Digestive and Circulatory Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Blood travels around the body in a closed system of tubes called blood vessels. There are three main types, and each is adapted to its job. The blood itself is a tissue made of a liquid, plasma, and several types of cell.

## Types of blood vessel
- **Arteries** carry blood away from the heart. The blood is at high pressure, so artery walls are thick, with muscle and elastic fibres, and the lumen (the space inside) is narrow. The elastic walls stretch and recoil, which creates the pulse.
- **Veins** carry blood towards the heart. The pressure is low, so the walls are thinner and the lumen is wide. Veins have valves to stop backflow, and blood is also pushed along when nearby skeletal muscles squeeze the vein.
- **Capillaries** are tiny vessels with walls only one cell thick. They link arteries to veins and pass very close to nearly every cell. The thin wall gives a short diffusion distance, so oxygen and glucose move out of the blood and carbon dioxide and urea move in.

## Components of blood
Blood is roughly 55% plasma and 45% cells by volume.
- **Plasma**: mostly water. It carries dissolved glucose, amino acids, urea, hormones and carbon dioxide, and also distributes heat around the body.
- **Red blood cells**: carry oxygen. They are biconcave discs, which gives a large surface area, and contain haemoglobin, a red pigment that combines with oxygen to form oxyhaemoglobin. Mature red cells have no nucleus, so there is more room for haemoglobin.
- **White blood cells**: defend the body. Phagocytes engulf pathogens and lymphocytes make antibodies.
- **Platelets**: small cell fragments that help blood to clot. At a wound they help to form a mesh of fibrin that traps cells, seals the cut and keeps pathogens out.

## Worked example
A person has 5.0 dm³ of blood. Plasma is 55% of this, so volume of plasma = 0.55 × 5.0 = 2.75 dm³. In a centrifuged sample with 45% red cells and 1% white cells and platelets, plasma = 100 − 46 = 54%.

## Linking structure to function
When you explain, link structure to function. Red cells have no nucleus, so they hold more haemoglobin. Capillaries are one cell thick, so substances diffuse quickly. Arteries are thick and elastic, so they cope with high pressure. A person with low haemoglobin (anaemia) feels tired because cells receive less oxygen and release less energy by aerobic respiration.

## Common mistakes
- Saying that veins carry deoxygenated blood only. The pulmonary vein carries oxygenated blood.
- Saying that platelets are whole cells. They are fragments of cells.
- Saying that red blood cells carry most of the carbon dioxide. Most carbon dioxide is carried in the plasma.
- Describing thin artery walls as an advantage. Arteries need thick walls to cope with the pressure.

## How this is examined
Questions often show a cross-section diagram of three vessels and ask you to identify them with reasons. Data questions use blood counts at different altitudes or after training. Explain and justify command terms need a structure, a function and a link.

Exam tip: when you identify a vessel, give at least two reasons from its structure, such as thick wall and narrow lumen for an artery.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('biology')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;