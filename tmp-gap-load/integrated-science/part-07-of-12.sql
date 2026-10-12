-- Part 7 of 12: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Cells and Living Systems > Cell Structure and Transport
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Cells and Living Systems$mq$, 5, 7 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Cell Structure and Transport$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Cells and Living Systems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Cell Structure and Transport$mq$ and p.name = $mq$Cells and Living Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which part of an animal cell contains the genetic material (DNA)?$mq$, $mq$["Nucleus","Ribosome","Mitochondrion","Cell membrane"]$mq$, 0, $mq$The nucleus holds the DNA and controls the activities of the cell.$mq$, $mq$easy$mq$),
($mq$Where does aerobic respiration mainly take place in a cell?$mq$, $mq$["Ribosomes","Nucleus","Cell wall","Mitochondria"]$mq$, 3, $mq$Mitochondria release energy from glucose using oxygen.$mq$, $mq$easy$mq$),
($mq$Which structure is found in plant cells but NOT in animal cells?$mq$, $mq$["Cell membrane","Cytoplasm","Cell wall","Nucleus"]$mq$, 2, $mq$Plant cells also have chloroplasts and a permanent vacuole. All cells have a membrane, cytoplasm and genetic material.$mq$, $mq$easy$mq$),
($mq$What is diffusion?$mq$, $mq$["Movement of particles from low to high concentration using energy","The net movement of particles from a higher concentration to a lower concentration","Movement of water only through a membrane","The movement of cells towards light"]$mq$, 1, $mq$Diffusion is passive: no energy is needed and particles move down the concentration gradient.$mq$, $mq$easy$mq$),
($mq$What is osmosis?$mq$, $mq$["The movement of water across a partially permeable membrane from a dilute solution to a more concentrated solution","The movement of solute from dilute to concentrated solutions","Active movement of water against a gradient","Movement of gases only"]$mq$, 0, $mq$Osmosis is the diffusion of water through a partially permeable membrane. Water moves from high to low water concentration.$mq$, $mq$easy$mq$),
($mq$What is the function of ribosomes?$mq$, $mq$["To release energy","To store genetic information","To control what enters the cell","To make proteins"]$mq$, 3, $mq$Ribosomes are the site of protein synthesis. Mitochondria release energy and the nucleus holds DNA.$mq$, $mq$medium$mq$),
($mq$Potato cylinders are placed in sucrose solutions and the mass change recorded. In 0.0 M: +8 %. In 0.2 M: +4 %. In 0.4 M: 0 %. In 0.6 M: −5 %. What is the best estimate of the concentration inside the potato cells?$mq$, $mq$["About 0.0 M","About 0.6 M","About 0.4 M","About 0.2 M"]$mq$, 2, $mq$There is no net osmosis when the mass is unchanged, so the solution outside has about the same concentration as the cell contents.$mq$, $mq$medium$mq$),
($mq$Root hair cells absorb mineral ions from soil that is more dilute than the cell contents. Which process is this?$mq$, $mq$["Diffusion","Active transport","Osmosis","Evaporation"]$mq$, 1, $mq$Moving ions against their concentration gradient requires energy from respiration, so it is active transport.$mq$, $mq$medium$mq$),
($mq$A student draws a cell 45 mm long under a microscope. The actual cell is 0.015 mm long. What is the magnification?$mq$, $mq$["×3000","×300","×675","×0.00033"]$mq$, 0, $mq$Magnification = image size ÷ actual size = 45 ÷ 0.015 = 3000.$mq$, $mq$medium$mq$),
($mq$What happens to a red blood cell placed in distilled water?$mq$, $mq$["It shrinks","It stays the same","It becomes firm and turgid","It swells and bursts"]$mq$, 3, $mq$Water enters by osmosis. An animal cell has no cell wall to resist swelling, so it bursts.$mq$, $mq$medium$mq$),
($mq$What is plasmolysis?$mq$, $mq$["A plant cell swelling with water","The cell wall dissolving","The membrane pulling away from the cell wall when a plant cell loses water","The cell dividing"]$mq$, 2, $mq$In a concentrated solution a plant cell loses water by osmosis, the vacuole shrinks and the membrane pulls away from the wall.$mq$, $mq$medium$mq$),
($mq$Cube A has sides 2 cm and cube B has sides of 1 cm. What is the surface area to volume ratio of cube A compared with B?$mq$, $mq$["A is 6 : 1 and B is 3 : 1","A is 3 : 1 and B is 6 : 1, so B has the larger ratio","Both are 6 : 1","A is 24 : 1 and B is 6 : 1"]$mq$, 1, $mq$Cube A: 24 cm² ÷ 8 cm³ = 3. Cube B: 6 cm² ÷ 1 cm³ = 6. Smaller objects have a larger ratio, which helps diffusion.$mq$, $mq$medium$mq$),
($mq$Why does a root hair cell have a long thin extension?$mq$, $mq$["It increases surface area for absorbing water and ions","It stores starch","It carries out photosynthesis","It makes it easier to divide"]$mq$, 0, $mq$A large surface area increases the rate of absorption by osmosis and active transport.$mq$, $mq$medium$mq$),
($mq$Which change would NOT increase the rate of diffusion of a gas into a cell?$mq$, $mq$["A greater concentration difference","A higher temperature","A larger surface area","A smaller concentration difference across the membrane"]$mq$, 3, $mq$A steeper concentration gradient, higher temperature and bigger surface area all increase diffusion. A smaller difference decreases it.$mq$, $mq$hard$mq$),
($mq$A scale bar on a drawing shows a drawn cell 60 mm wide at magnification ×400. What is its actual width in micrometres?$mq$, $mq$["24 000 µm","0.15 µm","150 µm","1.5 µm"]$mq$, 2, $mq$Actual = 60 ÷ 400 = 0.15 mm = 150 µm (1 mm = 1000 µm).$mq$, $mq$hard$mq$),
($mq$A potato cylinder has an initial mass of 5.0 g and a final mass of 5.6 g after 30 minutes in a solution. What is the percentage change in mass?$mq$, $mq$["+10.7 %","+12 %","+0.6 %","+11.2 %"]$mq$, 1, $mq$Percentage change = (final − initial) ÷ initial × 100 = 0.6 ÷ 5.0 × 100 = 12 %. Dividing by the final mass is a common mistake.$mq$, $mq$hard$mq$),
($mq$Two groups repeat a potato osmosis experiment. One group's cylinders gain far more mass than expected in the 0.4 M solution. What is the most likely cause?$mq$, $mq$["The cylinders were not blotted dry, so extra water on the surface added to the mass","Osmosis does not occur in sucrose","The temperature of the room was constant","The cylinders were cut with the same cork borer"]$mq$, 0, $mq$Surface water adds mass, so cylinders must be blotted before weighing. Same borer and constant temperature are good practice.$mq$, $mq$hard$mq$),
($mq$When cyanide is added to root hair cells, uptake of nitrate ions stops, but the uptake of water continues. Cyanide stops respiration. What explains this?$mq$, $mq$["Water needs ATP but nitrate does not","Cyanide blocks the cell wall","Nitrate moves by osmosis","Nitrate uptake is active transport requiring ATP, whereas water moves by osmosis"]$mq$, 3, $mq$Active transport needs energy from respiration, so stopping respiration stops it. Osmosis is passive.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Cell Structure and Transport$mq$ and p.name = $mq$Cells and Living Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Plant cell structures not in animal cells$mq$, $mq$Cell wall, chloroplasts and a permanent vacuole.$mq$),
($mq$Function of mitochondria$mq$, $mq$Release energy from glucose by aerobic respiration. Cells with high energy needs have many.$mq$),
($mq$Magnification formula$mq$, $mq$Magnification = image size ÷ actual size. Convert units: 1 mm = 1000 µm.$mq$),
($mq$Define diffusion$mq$, $mq$Net movement of particles from a region of higher concentration to lower concentration, down a gradient. No energy needed.$mq$),
($mq$Define osmosis$mq$, $mq$Net movement of water across a partially permeable membrane from a dilute solution to a more concentrated solution.$mq$),
($mq$Define active transport$mq$, $mq$Movement of particles against a concentration gradient using energy from respiration, e.g. mineral ions into root hair cells.$mq$),
($mq$Turgid vs plasmolysed$mq$, $mq$Turgid: plant cell full of water and firm. Plasmolysed: cell has lost water and membrane has pulled away from the wall.$mq$),
($mq$Why do small organisms not need a transport system?$mq$, $mq$They have a large surface area to volume ratio, so diffusion is fast enough over a short distance.$mq$),
($mq$Percentage change in mass$mq$, $mq$(final mass − initial mass) ÷ initial mass × 100.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Cell Structure and Transport$mq$ and p.name = $mq$Cells and Living Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Cells are the units of life
All living things are made of cells. Animal and plant cells share some structures, and plant cells have a few extra ones.
- **Nucleus**: contains DNA and controls the cell.
- **Cytoplasm**: jelly-like fluid where reactions take place.
- **Cell membrane**: controls what enters and leaves.
- **Mitochondria**: release energy by aerobic respiration.
- **Ribosomes**: make proteins.
Plant cells also have a **cell wall** (cellulose, for support), **chloroplasts** (photosynthesis) and a **permanent vacuole** (cell sap, keeps the cell firm).
Bacteria are different: they have no true nucleus, and their DNA lies free in the cytoplasm.

## Specialised cells
Cells are adapted to their jobs. A root hair cell has a long extension for absorbing water; a sperm cell has a tail and many mitochondria; a red blood cell has no nucleus and is packed with haemoglobin; a palisade cell has many chloroplasts. Cells form tissues, which form organs, which form organ systems.

## Microscopy and magnification
Magnification = image size ÷ actual size. Worked example: a drawing is 45 mm long and the cell is 0.015 mm, so magnification = 45 ÷ 0.015 = ×3000. To find actual size, rearrange: actual = image ÷ magnification. Convert units carefully: 1 mm = 1000 µm.

## Movement into and out of cells
- **Diffusion**: net movement of particles from high to low concentration, down the gradient. No energy needed. Oxygen and carbon dioxide move this way. Rate increases with a steeper gradient, higher temperature and larger surface area.
- **Osmosis**: diffusion of water across a partially permeable membrane. Water moves from a dilute solution to a more concentrated one.
- **Active transport**: movement of particles against the concentration gradient, requiring energy from respiration, for example mineral ions into root hair cells or glucose into the blood from the gut.

## Osmosis in plants and animals
A plant cell in dilute solution takes in water and becomes firm (turgid); the wall stops it bursting. In concentrated solution it loses water and the membrane pulls away from the wall (plasmolysis). Animal cells have no wall, so a red blood cell bursts in distilled water and shrivels in very concentrated solution.

## Surface area to volume ratio
Small objects have a larger surface area to volume ratio. A 1 cm cube has ratio 6 : 1; a 2 cm cube has 3 : 1. Large organisms need transport and exchange systems because diffusion alone is too slow.

## Practical: potato cylinders
Cut same-size cylinders, weigh them, place in different sucrose concentrations, leave for a set time, blot dry and reweigh. Percentage change = (final − initial) ÷ initial × 100. The concentration where there is no change is about equal to the concentration of the potato cells. To improve reliability, repeat and calculate a mean, and blot every cylinder in the same way.

## Common mistakes
- Saying that osmosis moves water to where there is "more water".
- Forgetting that active transport needs energy and works against the gradient.
- Dividing by the final mass when calculating percentage change.
- Forgetting to convert mm to µm.

## How this is examined
You may see a practical with data in text, such as potato cylinders in sucrose solutions. Typical tasks are plotting percentage change, finding where the line crosses zero, naming control variables, spotting why a result is anomalous, and linking cell adaptations to function.

Exam tip: Use the words "partially permeable membrane" and "concentration gradient" in explanations, and always say whether energy is needed.$mq$ from st;

-- Cells and Living Systems > Photosynthesis and Respiration
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Cells and Living Systems$mq$, 5, 7 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Photosynthesis and Respiration$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Cells and Living Systems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Photosynthesis and Respiration$mq$ and p.name = $mq$Cells and Living Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the word equation for photosynthesis?$mq$, $mq$["Carbon dioxide + water → glucose + oxygen","Glucose + oxygen → carbon dioxide + water","Oxygen + water → glucose + carbon dioxide","Glucose + carbon dioxide → oxygen + water"]$mq$, 0, $mq$Photosynthesis uses light energy to make glucose from carbon dioxide and water, releasing oxygen.$mq$, $mq$easy$mq$),
($mq$Which pigment in chloroplasts absorbs light for photosynthesis?$mq$, $mq$["Haemoglobin","Melanin","Keratin","Chlorophyll"]$mq$, 3, $mq$Chlorophyll absorbs mostly red and blue light and reflects green.$mq$, $mq$easy$mq$),
($mq$What is the word equation for aerobic respiration?$mq$, $mq$["Carbon dioxide + water → glucose + oxygen","Glucose → ethanol + carbon dioxide","Glucose + oxygen → carbon dioxide + water (+ energy)","Glucose → lactic acid"]$mq$, 2, $mq$Aerobic respiration releases energy from glucose using oxygen.$mq$, $mq$easy$mq$),
($mq$In which living things does respiration occur?$mq$, $mq$["Only animals","All living things, all the time","Only plants at night","Only in the dark"]$mq$, 1, $mq$Every living cell respires continuously to release energy.$mq$, $mq$easy$mq$),
($mq$What colour does iodine solution turn when starch is present?$mq$, $mq$["Blue-black","Brick red","Purple","Clear"]$mq$, 0, $mq$Iodine turns blue-black with starch. Benedict's solution goes brick red with reducing sugars.$mq$, $mq$easy$mq$),
($mq$Which is a limiting factor of photosynthesis?$mq$, $mq$["Mitochondria number","Wind direction","Bile concentration","Light intensity"]$mq$, 3, $mq$The limiting factors are light intensity, carbon dioxide concentration and temperature.$mq$, $mq$medium$mq$),
($mq$A student moves a lamp away from pondweed. Bubbles per minute: 10 cm: 40, 20 cm: 22, 30 cm: 10. What is the conclusion?$mq$, $mq$["Rate increases with distance","Distance has no effect","Rate of photosynthesis decreases as light intensity decreases","Rate is highest at 30 cm"]$mq$, 2, $mq$Greater distance means lower light intensity and fewer bubbles of oxygen per minute.$mq$, $mq$medium$mq$),
($mq$What is produced during anaerobic respiration in human muscles?$mq$, $mq$["Ethanol and carbon dioxide","Lactic acid","Glucose","Oxygen"]$mq$, 1, $mq$In muscles, glucose is incompletely broken down to lactic acid when oxygen is short.$mq$, $mq$medium$mq$),
($mq$Yeast respire anaerobically in a sugar solution. Which products are formed?$mq$, $mq$["Ethanol and carbon dioxide","Lactic acid and oxygen","Water and glucose","Starch and carbon dioxide"]$mq$, 0, $mq$Anaerobic respiration in yeast is fermentation, used in brewing and bread making.$mq$, $mq$medium$mq$),
($mq$How is a leaf adapted for photosynthesis?$mq$, $mq$["It has thick waxy walls with no air spaces","It has no stomata","It has chloroplasts only in roots","It is broad and thin with many chloroplasts in palisade cells near the top"]$mq$, 3, $mq$A large surface area, thin structure and chloroplast-rich palisade layer maximise light capture and gas diffusion.$mq$, $mq$medium$mq$),
($mq$What is the function of guard cells?$mq$, $mq$["To make glucose","To absorb water from soil","To open and close stomata to control gas exchange and water loss","To carry sugar around the plant"]$mq$, 2, $mq$Guard cells change shape to open or close the stomata.$mq$, $mq$medium$mq$),
($mq$Which is the correct balanced symbol equation for photosynthesis?$mq$, $mq$["CO₂ + H₂O → C₆H₁₂O₆ + O₂","6CO₂ + 6H₂O → C₆H₁₂O₆ + 6O₂","C₆H₁₂O₆ + 6O₂ → 6CO₂ + 6H₂O","6CO₂ + 12H₂O → C₆H₁₂O₆ + 6O₂"]$mq$, 1, $mq$Left: 6 C, 12 H, 18 O. Right: 6 C, 12 H, 6 + 12 = 18 O. It is balanced. Option three is the reverse reaction.$mq$, $mq$medium$mq$),
($mq$Which is NOT a use of the glucose made by photosynthesis?$mq$, $mq$["Making haemoglobin in the leaf","Respiration","Storage as starch","Making cellulose for cell walls"]$mq$, 0, $mq$Plants use glucose for respiration, storage as starch and cellulose. With nitrates it can make amino acids for proteins; haemoglobin is not made by plants.$mq$, $mq$medium$mq$),
($mq$A graph of photosynthesis rate against light intensity rises and then levels off. The temperature is 20 °C. What is the most likely limiting factor at the flat part?$mq$, $mq$["Light intensity","Chlorophyll colour","Oxygen concentration","Carbon dioxide concentration or temperature"]$mq$, 3, $mq$On the plateau, extra light no longer increases the rate, so another factor such as CO₂ concentration or temperature is limiting.$mq$, $mq$hard$mq$),
($mq$A variegated leaf (green and white areas) is tested for starch after several hours in light. What is the result and conclusion?$mq$, $mq$["Only the white areas turn blue-black, showing chlorophyll is not needed","All areas turn blue-black, showing light is needed","Only the green areas turn blue-black, showing that chlorophyll is needed","No area turns blue-black, showing starch is not made"]$mq$, 2, $mq$White areas lack chlorophyll so cannot photosynthesise; they do not store starch.$mq$, $mq$hard$mq$),
($mq$A plant is in bright light. At the same time it respires and photosynthesises. What is the net gas exchange?$mq$, $mq$["It releases carbon dioxide because respiration only happens in the dark","It takes in carbon dioxide because photosynthesis is faster than respiration","It takes in oxygen only","There is no gas exchange"]$mq$, 1, $mq$In bright light the rate of photosynthesis exceeds respiration, so there is net uptake of carbon dioxide and net release of oxygen.$mq$, $mq$hard$mq$),
($mq$Hydrogencarbonate indicator is red in air, yellow at high CO₂ and purple at low CO₂. A tube with a leaf is wrapped in foil and left in light for 2 hours. What colour is expected and why?$mq$, $mq$["Yellow, because the leaf only respires in the dark and produces CO₂","Purple, because the leaf photosynthesises","Red, because the leaf does not respire","Purple, because the leaf releases oxygen"]$mq$, 0, $mq$In the dark there is no photosynthesis, so CO₂ from respiration builds up and turns the indicator yellow.$mq$, $mq$hard$mq$),
($mq$A student counts bubbles from pondweed to find photosynthesis rate. Which improvement most increases the validity of the investigation?$mq$, $mq$["Count bubbles for 5 seconds only","Use a brighter bulb without changing the distance","Count bubbles by eye without repeating","Collect and measure the volume of oxygen in a gas syringe and use an LED to avoid heating the water"]$mq$, 3, $mq$Bubbles vary in size, so measuring gas volume is more accurate. A cool light source prevents temperature acting as a second variable.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Photosynthesis and Respiration$mq$ and p.name = $mq$Cells and Living Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Word equation for photosynthesis$mq$, $mq$Carbon dioxide + water → glucose + oxygen, using light energy absorbed by chlorophyll.$mq$),
($mq$Balanced equation for photosynthesis$mq$, $mq$6CO₂ + 6H₂O → C₆H₁₂O₆ + 6O₂.$mq$),
($mq$Word equation for aerobic respiration$mq$, $mq$Glucose + oxygen → carbon dioxide + water, releasing energy. Happens in mitochondria.$mq$),
($mq$Anaerobic respiration in muscles and yeast$mq$, $mq$Muscles: glucose → lactic acid. Yeast: glucose → ethanol + carbon dioxide.$mq$),
($mq$Limiting factors of photosynthesis$mq$, $mq$Light intensity, carbon dioxide concentration and temperature. The one in shortest supply limits the rate.$mq$),
($mq$Function of stomata and guard cells$mq$, $mq$Stomata let gases in and out; guard cells open and close them and control water loss.$mq$),
($mq$Test for starch$mq$, $mq$Add iodine solution: blue-black means starch is present.$mq$),
($mq$Uses of glucose in a plant$mq$, $mq$Respiration, storage as starch, cellulose for cell walls, and amino acids (with nitrates) for proteins.$mq$),
($mq$Hydrogencarbonate indicator colours$mq$, $mq$Purple: low CO₂. Red: atmospheric CO₂. Yellow: high CO₂.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Photosynthesis and Respiration$mq$ and p.name = $mq$Cells and Living Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Photosynthesis
Photosynthesis is the process by which plants, algae and some bacteria make glucose using light energy. It happens in the chloroplasts, which contain chlorophyll.
Word equation: carbon dioxide + water → glucose + oxygen (light energy, chlorophyll).
Balanced symbol equation: 6CO₂ + 6H₂O → C₆H₁₂O₆ + 6O₂. Check: 6 C, 12 H and 18 O on each side.
Plants use glucose for respiration, to make starch for storage, cellulose for cell walls, and with nitrates to make amino acids for proteins. Starch is tested with iodine, which turns blue-black.

## Leaf structure
A leaf is broad and thin to catch light and let gases diffuse in. Palisade cells near the top contain many chloroplasts. Spongy mesophyll has air spaces for gas diffusion. **Stomata** are tiny pores, mostly on the underside, opened and closed by **guard cells**. Xylem brings water, and phloem carries sugars away.

## Limiting factors
The rate of photosynthesis can be limited by light intensity, carbon dioxide concentration or temperature. On a graph the rate rises then levels off when another factor becomes limiting. At very high temperatures enzymes are denatured and the rate falls.

## Respiration
Respiration releases energy from glucose in every living cell. It is not breathing.
- **Aerobic respiration**: glucose + oxygen → carbon dioxide + water (+ energy). Takes place in mitochondria. C₆H₁₂O₆ + 6O₂ → 6CO₂ + 6H₂O.
- **Anaerobic respiration in muscles**: glucose → lactic acid (+ less energy). Causes an oxygen debt and muscle fatigue.
- **Anaerobic respiration in yeast**: glucose → ethanol + carbon dioxide. Used in brewing and baking.
The energy is used for movement, growth, keeping warm, active transport and building molecules.

## Day and night in plants
In the light a plant photosynthesises and respires, but if photosynthesis is faster it takes in carbon dioxide and gives out oxygen overall. In the dark it only respires, taking in oxygen and releasing carbon dioxide. Hydrogencarbonate indicator shows carbon dioxide levels: purple (low), red (atmospheric), yellow (high).

## Practical: pondweed and light
Place a lamp at different distances from pondweed and count bubbles per minute. Control temperature (use a water bath or LED lamp), carbon dioxide concentration and the same pondweed. To improve accuracy, repeat and find a mean, and collect gas in a syringe instead of counting bubbles of different sizes.

## Common mistakes
- Saying plants photosynthesise only in the day and respire only at night. They respire all the time.
- Mixing up the reactants and products of photosynthesis and respiration.
- Saying plants "breathe in" carbon dioxide and use it for respiration.
- Describing anaerobic respiration in muscles as producing ethanol.

## How this is examined
Expect an investigation context such as pondweed, a greenhouse or a variegated leaf. You may interpret a graph with a plateau, identify the limiting factor, evaluate the method and link photosynthesis to global issues such as food security, greenhouse design and carbon dioxide levels.

Exam tip: When asked for a limiting factor on a plateau, say what is in short supply and explain why increasing the first factor no longer helps.$mq$ from st;

-- Cells and Living Systems > Enzymes, Nutrition and Digestion
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Cells and Living Systems$mq$, 5, 7 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Enzymes, Nutrition and Digestion$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Cells and Living Systems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Enzymes, Nutrition and Digestion$mq$ and p.name = $mq$Cells and Living Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What are enzymes?$mq$, $mq$["Biological catalysts made of protein","Hormones that speed up growth","Carbohydrates that store energy","Vitamins that fight disease"]$mq$, 0, $mq$Enzymes speed up reactions without being used up, and they are proteins.$mq$, $mq$easy$mq$),
($mq$Which enzyme digests starch?$mq$, $mq$["Protease","Lipase","Pepsin","Amylase"]$mq$, 3, $mq$Amylase breaks starch into sugars such as maltose. Protease digests protein and lipase digests fats.$mq$, $mq$easy$mq$),
($mq$What does protease break proteins down into?$mq$, $mq$["Glucose","Fatty acids","Amino acids","Glycerol"]$mq$, 2, $mq$Proteins are made of amino acids, which protease releases.$mq$, $mq$easy$mq$),
($mq$What are the products of lipid (fat) digestion?$mq$, $mq$["Amino acids","Fatty acids and glycerol","Glucose","Maltose"]$mq$, 1, $mq$Lipase breaks down lipids into fatty acids and glycerol.$mq$, $mq$easy$mq$),
($mq$Where does most absorption of digested food take place?$mq$, $mq$["Small intestine","Stomach","Large intestine","Mouth"]$mq$, 0, $mq$The small intestine is long and lined with villi, so it has a huge surface area for absorbing food molecules.$mq$, $mq$easy$mq$),
($mq$What does the lock and key model say about enzymes?$mq$, $mq$["The enzyme changes shape to fit any substrate","The enzyme is used up in the reaction","The substrate is a catalyst","The substrate fits the shape of the enzyme's active site"]$mq$, 3, $mq$Each enzyme has an active site with a specific shape that matches its substrate.$mq$, $mq$medium$mq$),
($mq$Why does an enzyme stop working at high temperature?$mq$, $mq$["The enzyme runs out of substrate","The enzyme is killed because it is alive","The active site changes shape (it is denatured)","The temperature changes the pH only"]$mq$, 2, $mq$Heat breaks bonds holding the protein shape, so the substrate no longer fits. Enzymes are not alive.$mq$, $mq$medium$mq$),
($mq$Pepsin works best at about pH 2 and amylase at about pH 7. Which statement explains this?$mq$, $mq$["All enzymes work best at pH 7","Each enzyme is adapted to the pH of where it works","Pepsin is not an enzyme","Amylase works only in the stomach"]$mq$, 1, $mq$Pepsin works in the acidic stomach; salivary amylase works in the near neutral mouth.$mq$, $mq$medium$mq$),
($mq$How are villi adapted for absorption?$mq$, $mq$["Large surface area, thin walls and a rich blood supply","Thick walls and few capillaries","Smooth surface and no blood vessels","Many chloroplasts for light"]$mq$, 0, $mq$Thin walls give a short diffusion distance and capillaries maintain a steep concentration gradient.$mq$, $mq$medium$mq$),
($mq$What is the role of bile?$mq$, $mq$["To digest proteins","To digest starch","To absorb water","To emulsify fats and neutralise stomach acid"]$mq$, 3, $mq$Bile, made in the liver and stored in the gall bladder, breaks fats into droplets, giving a larger surface area for lipase. It is not an enzyme.$mq$, $mq$medium$mq$),
($mq$A food sample turns purple when biuret reagent is added. What does it contain?$mq$, $mq$["Reducing sugar","Starch","Protein","Lipid"]$mq$, 2, $mq$Biuret turns purple with protein. Benedict's gives a brick-red precipitate with reducing sugars, and iodine turns blue-black with starch.$mq$, $mq$medium$mq$),
($mq$Amylase activity at different temperatures: 10 °C: 2, 20 °C: 5, 30 °C: 9, 40 °C: 14, 50 °C: 3 (arbitrary units). What can you conclude?$mq$, $mq$["The enzyme works best at 50 °C","The optimum temperature is near 40 °C, and the enzyme is denatured at 50 °C","The enzyme is denatured at 10 °C","Temperature has no effect"]$mq$, 1, $mq$Rates rise to a peak around 40 °C and fall sharply at 50 °C as the enzyme denatures.$mq$, $mq$medium$mq$),
($mq$Why is dietary fibre important?$mq$, $mq$["It helps food move through the gut and prevents constipation","It provides most of the body's energy","It builds muscle","It is digested to glucose"]$mq$, 0, $mq$Fibre is not digested, but adds bulk so food moves along the intestine.$mq$, $mq$medium$mq$),
($mq$Starch disappears in 120 s at 20 °C and in 30 s at 40 °C. Using rate = 1 ÷ time, how many times faster is the reaction at 40 °C?$mq$, $mq$["2 times","90 times","0.25 times","4 times"]$mq$, 3, $mq$Rate at 20 °C = 1/120; at 40 °C = 1/30. The ratio is 120 ÷ 30 = 4.$mq$, $mq$hard$mq$),
($mq$Doubling the enzyme concentration at first doubles the rate, but then the rate stops increasing. What explains this?$mq$, $mq$["The enzyme has been denatured","The temperature becomes too low","All the substrate is being used so substrate becomes the limiting factor","The enzyme turns into a substrate"]$mq$, 2, $mq$At first more active sites means faster reaction. Eventually substrate is the limiting factor.$mq$, $mq$hard$mq$),
($mq$A student burns 1.0 g of a nut under a boiling tube containing 50 g of water. The water temperature rises by 20 °C. Water needs 4.2 J per g per °C. What is the energy released per gram?$mq$, $mq$["840 J","4200 J (4.2 kJ)","210 J","4.2 J"]$mq$, 1, $mq$Energy = 50 × 4.2 × 20 = 4200 J. The true energy in the nut is higher because some heat is lost to the surroundings.$mq$, $mq$hard$mq$),
($mq$A student says, "High temperatures kill enzymes." What is the best correction?$mq$, $mq$["Enzymes are not alive; high temperatures denature them by changing the shape of the active site","Enzymes are alive but small","High temperatures dissolve the substrate","Enzymes work faster as temperature increases forever"]$mq$, 0, $mq$Only living things can be killed. Enzymes are proteins that lose their shape.$mq$, $mq$hard$mq$),
($mq$In an investigation into the effect of pH on amylase, which control is most important?$mq$, $mq$["Different temperature in every tube","Different volume of amylase in each tube","Different substrates in each tube","Same temperature, enzyme volume and starch concentration in every tube"]$mq$, 3, $mq$pH is the independent variable. All other variables must be kept constant so any difference is due to pH.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Enzymes, Nutrition and Digestion$mq$ and p.name = $mq$Cells and Living Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$What is an enzyme?$mq$, $mq$A biological catalyst, made of protein, that speeds up a reaction without being used up.$mq$),
($mq$Lock and key model$mq$, $mq$The substrate fits the specific shape of the enzyme's active site, like a key in a lock.$mq$),
($mq$Denaturation$mq$, $mq$A change in shape of the enzyme (and active site) caused by high temperature or extreme pH. The enzyme no longer works.$mq$),
($mq$Amylase, protease, lipase$mq$, $mq$Amylase: starch → sugars. Protease: protein → amino acids. Lipase: lipids → fatty acids and glycerol.$mq$),
($mq$Function of bile$mq$, $mq$Made in the liver, stored in the gall bladder. Neutralises acid and emulsifies fats. It is not an enzyme.$mq$),
($mq$Food test results$mq$, $mq$Starch: iodine blue-black. Reducing sugar: Benedict's brick red. Protein: biuret purple. Lipid: ethanol emulsion cloudy.$mq$),
($mq$Adaptations of villi$mq$, $mq$Large surface area, thin walls (one cell thick) and a rich blood supply for fast absorption.$mq$),
($mq$Calculating rate from time$mq$, $mq$Rate = 1 ÷ time taken. A shorter time means a faster reaction.$mq$),
($mq$Energy from food$mq$, $mq$Energy (J) = mass of water (g) × 4.2 × temperature rise (°C).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Enzymes, Nutrition and Digestion$mq$ and p.name = $mq$Cells and Living Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Enzymes
Enzymes are biological catalysts. They are proteins that speed up chemical reactions without being used up. Each enzyme has an **active site** with a specific shape that fits only one **substrate**: the lock and key model. When the substrate fits, the reaction happens and products are released, and the enzyme can be used again.
Enzymes work best at an **optimum** temperature and pH. At low temperature particles move slowly, so reactions are slow. At high temperature, the enzyme's shape changes and the active site no longer fits. We say the enzyme is **denatured**. This is not the same as being killed, because enzymes are not alive. Different enzymes have different optimum pH values: pepsin about pH 2 in the stomach, amylase about pH 7.

## Factors affecting enzyme rate
- Temperature: rate rises up to the optimum, then drops sharply.
- pH: extreme pH changes shape, reducing activity.
- Enzyme concentration: more enzyme gives a faster rate until the substrate runs out.
- Substrate concentration: more substrate increases the rate until all active sites are busy.
Rate can be calculated as 1 ÷ time taken. If starch disappears in 120 s at 20 °C and 30 s at 40 °C, the rate is 4 times greater at 40 °C.

## Nutrition
A balanced diet includes carbohydrates (energy), proteins (growth and repair), lipids (energy store, insulation), vitamins and minerals, fibre (moves food through the gut) and water.
Food tests: iodine for starch (blue-black), Benedict's for reducing sugars (brick red when heated), biuret for protein (purple), and the ethanol emulsion test for lipids (cloudy white).

## Digestion
Digestion breaks large insoluble molecules into small soluble ones that can be absorbed.
- Carbohydrase (amylase): starch → sugars (made in salivary glands, pancreas).
- Protease (pepsin in the stomach): proteins → amino acids.
- Lipase: lipids → fatty acids and glycerol.
**Bile** is made in the liver and stored in the gall bladder. It is not an enzyme. It neutralises stomach acid and emulsifies fats, giving a larger surface area for lipase. The small intestine absorbs digested food, and the large intestine absorbs water. **Villi** are folds with thin walls and a rich blood supply for fast absorption.

## Energy in food
In a calorimetry experiment burning food heats water: energy = mass of water × 4.2 × temperature rise. For 50 g of water rising 20 °C, energy = 4200 J. The result is lower than the real value because some heat escapes to the surroundings. Improve by insulating and using a lid.

## Common mistakes
- Saying enzymes are "killed" or "used up".
- Saying bile digests fat chemically. It emulsifies.
- Using digestion and absorption as the same thing.
- Forgetting to control temperature when testing the effect of pH.

## How this is examined
Questions might present an experiment on amylase or catalase with results in text, ask for conclusions, require rate calculations, and ask for improvements such as repeats, a water bath and a control. Criterion D items link enzymes to industry, such as biological washing powders or lactose-free milk.

Exam tip: Link every enzyme explanation to the shape of the active site and the substrate, and say "denatured", not "killed".$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('integrated-science')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;