-- Part 4 of 6: 6 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Gas Exchange and Excretion > Ventilation and Gas Exchange in the Lungs
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Gas Exchange and Excretion$mq$, 4, 7 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Ventilation and Gas Exchange in the Lungs$mq$, 4, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Gas Exchange and Excretion$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Ventilation and Gas Exchange in the Lungs$mq$ and p.name = $mq$Gas Exchange and Excretion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What are the tiny air sacs in the lungs, where gas exchange happens, called?$mq$, $mq$["Alveoli","Bronchioles","Bronchi","Trachea"]$mq$, 0, $mq$Alveoli are the microscopic air sacs at the end of the bronchioles where oxygen and carbon dioxide are exchanged with the blood.$mq$, $mq$easy$mq$),
($mq$Which gas diffuses from the air in the alveoli into the blood?$mq$, $mq$["Carbon dioxide","Nitrogen","Hydrogen","Oxygen"]$mq$, 3, $mq$Oxygen concentration is higher in the alveoli than in the blood, so oxygen diffuses into the blood.$mq$, $mq$easy$mq$),
($mq$Which large sheet of muscle below the lungs flattens during inhalation?$mq$, $mq$["Stomach","Liver","Diaphragm","Sternum"]$mq$, 2, $mq$When the diaphragm contracts it flattens and moves down, which increases the volume of the chest cavity.$mq$, $mq$easy$mq$),
($mq$What is the name of the windpipe?$mq$, $mq$["Larynx","Trachea","Oesophagus","Bronchus"]$mq$, 1, $mq$The trachea carries air from the throat to the bronchi. It is kept open by rings of cartilage.$mq$, $mq$easy$mq$),
($mq$Which gas turns limewater milky?$mq$, $mq$["Carbon dioxide","Oxygen","Nitrogen","Hydrogen"]$mq$, 0, $mq$Carbon dioxide reacts with limewater to form a cloudy white precipitate of calcium carbonate.$mq$, $mq$easy$mq$),
($mq$What happens to the volume of the chest cavity during inhalation?$mq$, $mq$["It decreases","It stays the same","It halves","It increases"]$mq$, 3, $mq$The ribs move up and out and the diaphragm flattens, so the chest volume increases and the air pressure inside falls below atmospheric pressure.$mq$, $mq$medium$mq$),
($mq$Which cells lining the trachea sweep mucus and trapped dirt up towards the throat?$mq$, $mq$["Sperm cells","Goblet cells","Ciliated cells","Palisade cells"]$mq$, 2, $mq$Ciliated cells have hair-like cilia that beat in waves. Goblet cells make the mucus but do not move it.$mq$, $mq$medium$mq$),
($mq$Why is the wall of an alveolus only one cell thick?$mq$, $mq$["To increase blood pressure","To give a short diffusion distance","To trap dust","To store air"]$mq$, 1, $mq$A very thin wall means gases have only a short distance to diffuse, so exchange is fast.$mq$, $mq$medium$mq$),
($mq$What is the approximate percentage of oxygen in inhaled air?$mq$, $mq$["21%","78%","0.04%","4%"]$mq$, 0, $mq$Air is about 78% nitrogen, 21% oxygen and 0.04% carbon dioxide.$mq$, $mq$medium$mq$),
($mq$What is the approximate percentage of carbon dioxide in exhaled air?$mq$, $mq$["16%","0.04%","21%","4%"]$mq$, 3, $mq$Exhaled air contains about 4% carbon dioxide, which is about 100 times more than inhaled air.$mq$, $mq$medium$mq$),
($mq$Which gas in cigarette smoke binds to haemoglobin and reduces the oxygen carried by the blood?$mq$, $mq$["Nitrogen","Carbon dioxide","Carbon monoxide","Methane"]$mq$, 2, $mq$Carbon monoxide binds to haemoglobin much more strongly than oxygen does, so the blood carries less oxygen.$mq$, $mq$medium$mq$),
($mq$A person breathes 15 times per minute with a tidal volume (volume of each breath) of 500 cm³. How much air do they breathe per minute in cm³?$mq$, $mq$["515","7500","750","33"]$mq$, 1, $mq$15 × 500 = 7500 cm³ per minute.$mq$, $mq$medium$mq$),
($mq$How does breathing change during vigorous exercise?$mq$, $mq$["Faster and deeper","There is no change","Slower and deeper","Faster and shallower"]$mq$, 0, $mq$Muscles respire faster, so more carbon dioxide is made and more oxygen is needed. Both breathing rate and depth increase.$mq$, $mq$medium$mq$),
($mq$Smokers get more chest infections. Which is the best explanation?$mq$, $mq$["More oxygen reaches the alveoli","The diaphragm stops moving","The alveoli walls become thicker","Mucus and microbes build up in the airways"]$mq$, 3, $mq$Tar damages and paralyses the cilia, so mucus containing microbes and dust is not moved out and stays in the airways.$mq$, $mq$hard$mq$),
($mq$In emphysema the walls between alveoli break down. What is the main effect on gas exchange?$mq$, $mq$["Surface area for exchange increases","The diffusion distance decreases","Surface area for exchange decreases","More oxygen is made in the lungs"]$mq$, 2, $mq$Fewer, larger air spaces mean a much smaller surface area, so less oxygen can diffuse into the blood.$mq$, $mq$hard$mq$),
($mq$When the diaphragm contracts, how does the air pressure inside the lungs compare with the air pressure outside?$mq$, $mq$["The same","Lower","Higher","Zero"]$mq$, 1, $mq$The volume of the chest increases, so the pressure inside falls below atmospheric pressure and air is pushed in.$mq$, $mq$hard$mq$),
($mq$A person breathes in 6.0 dm³ of air per minute containing 21% oxygen. The exhaled air contains 16% oxygen in the same volume. How many dm³ of oxygen are taken up per minute?$mq$, $mq$["0.30","1.26","0.96","0.05"]$mq$, 0, $mq$The difference is 21 − 16 = 5% of 6.0 dm³ = 0.05 × 6.0 = 0.30 dm³.$mq$, $mq$hard$mq$),
($mq$What would happen if the air in the alveoli were never replaced by breathing?$mq$, $mq$["The diffusion distance would shrink","The concentration gradient would steepen","Blood flow would double","The concentration gradient would be lost"]$mq$, 3, $mq$Oxygen would be used up and carbon dioxide would build up, so the gradients for diffusion would fall and gas exchange would stop.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Ventilation and Gas Exchange in the Lungs$mq$ and p.name = $mq$Gas Exchange and Excretion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Path of air into the lungs$mq$, $mq$Nose or mouth, trachea, bronchi, bronchioles, alveoli.$mq$),
($mq$Inhalation$mq$, $mq$Intercostal muscles and diaphragm contract, the ribs move up and out, chest volume increases, pressure falls and air moves in.$mq$),
($mq$Exhalation$mq$, $mq$Intercostal muscles and diaphragm relax, chest volume decreases, pressure rises and air is pushed out.$mq$),
($mq$Alveolus adaptations$mq$, $mq$Huge numbers for a large surface area, wall one cell thick, moist lining, and a dense capillary network for a steep gradient.$mq$),
($mq$Composition of inhaled air$mq$, $mq$About 78% nitrogen, 21% oxygen and 0.04% carbon dioxide.$mq$),
($mq$Composition of exhaled air$mq$, $mq$About 78% nitrogen, 16% oxygen, 4% carbon dioxide and more water vapour.$mq$),
($mq$Role of cilia and mucus$mq$, $mq$Mucus traps dust and microbes. Cilia sweep the mucus up to the throat to be swallowed.$mq$),
($mq$Effects of tar and carbon monoxide$mq$, $mq$Tar paralyses cilia and can cause cancer. Carbon monoxide binds to haemoglobin so blood carries less oxygen.$mq$),
($mq$Test for carbon dioxide$mq$, $mq$Bubble the gas through limewater. If CO₂ is present, the limewater turns milky.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Ventilation and Gas Exchange in the Lungs$mq$ and p.name = $mq$Gas Exchange and Excretion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Gas exchange is the process by which an organism takes in oxygen and gets rid of carbon dioxide. In humans it happens in the lungs. Cells need oxygen for aerobic respiration and need to remove the carbon dioxide that respiration produces.

## The breathing system
Air enters through the nose or mouth and passes down the **trachea**. This is held open by rings of cartilage. The trachea divides into two **bronchi**, one for each lung, which branch into smaller **bronchioles**. Each bronchiole ends in a cluster of tiny air sacs called **alveoli**. The trachea and bronchi are lined with goblet cells that make mucus to trap dust and microbes, and ciliated cells whose cilia sweep the mucus upwards to be swallowed.

## Ventilation
Ventilation is the movement of air in and out of the lungs. It keeps fresh air in the alveoli, which maintains a steep concentration gradient.
- **Inhalation**: the intercostal muscles between the ribs contract and lift the ribs up and out. The diaphragm contracts and flattens. The volume of the chest increases, so the pressure falls below atmospheric pressure and air is pushed in.
- **Exhalation**: the intercostal muscles and diaphragm relax. The ribs fall and the diaphragm domes upwards. The volume decreases, the pressure increases and air is forced out.

## Gas exchange at the alveoli
The alveoli are adapted for fast diffusion. There are millions of them, so the surface area is huge. Their walls are one cell thick and are surrounded by a network of capillaries with walls one cell thick, so the diffusion distance is tiny. A thin film of moisture lets gases dissolve. The blood flow constantly carries oxygen away and brings carbon dioxide, which maintains steep gradients. Oxygen diffuses into the blood and joins haemoglobin. Carbon dioxide diffuses from the blood into the alveoli and is breathed out.

## Inhaled and exhaled air
Inhaled air: about 21% oxygen and 0.04% carbon dioxide. Exhaled air: about 16% oxygen and 4% carbon dioxide. Exhaled air also contains more water vapour. Nitrogen is about 78% in both. Not all oxygen is removed, which is why mouth-to-mouth resuscitation can work. Limewater turns milky with carbon dioxide, and exhaled air makes it cloudy faster than inhaled air.

## Smoking and exercise
Tar in cigarette smoke damages cilia and can cause lung cancer. Smoke irritates the lining and can destroy alveoli walls in emphysema, reducing surface area. Carbon monoxide binds to haemoglobin and cuts oxygen transport. Nicotine is addictive. During exercise breathing is faster and deeper, because the muscles need more oxygen and produce more carbon dioxide.

## Worked example
A person breathes 6.0 dm³ of air per minute. Oxygen in exhaled air is 5 percentage points lower. Oxygen taken up = 0.05 × 6.0 = 0.30 dm³ per minute.

## Common mistakes
- Saying that air is "pulled" by the lungs. The lungs have no muscles; changes in chest volume change pressure.
- Saying we breathe in only oxygen and breathe out only carbon dioxide. Both gases are in both samples.
- Mixing up breathing (ventilation) with respiration. Respiration is the chemical release of energy in cells.

## How this is examined
You may be given a diagram of the thorax and asked to describe the changes in inhalation, or a table of air composition. Criterion B may ask for an investigation into the effect of exercise on breathing rate, including variables and a fair test. Criterion D can ask you to evaluate the impact of smoking.

Exam tip: for inhalation questions, write the chain: muscles contract, volume increases, pressure decreases, air moves in.$mq$ from st;

-- Gas Exchange and Excretion > Kidneys, Urine and Waste Removal
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Gas Exchange and Excretion$mq$, 4, 7 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Kidneys, Urine and Waste Removal$mq$, 4, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Gas Exchange and Excretion$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Kidneys, Urine and Waste Removal$mq$ and p.name = $mq$Gas Exchange and Excretion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which organ makes urea from excess amino acids?$mq$, $mq$["Liver","Pancreas","Kidney","Bladder"]$mq$, 0, $mq$The liver breaks down excess amino acids and makes urea, which the blood carries to the kidneys.$mq$, $mq$easy$mq$),
($mq$What is the removal of metabolic waste products from the body called?$mq$, $mq$["Egestion","Ingestion","Digestion","Excretion"]$mq$, 3, $mq$Excretion removes waste made by the body's chemical reactions, such as urea and carbon dioxide.$mq$, $mq$easy$mq$),
($mq$Which organ filters the blood to make urine?$mq$, $mq$["Liver","Bladder","Kidney","Heart"]$mq$, 2, $mq$The two kidneys filter blood and produce urine.$mq$, $mq$easy$mq$),
($mq$Where is urine stored before leaving the body?$mq$, $mq$["Ureter","Bladder","Urethra","Kidney"]$mq$, 1, $mq$Urine passes along the ureters and is stored in the bladder until it is released through the urethra.$mq$, $mq$easy$mq$),
($mq$Which tube carries urine from the kidney to the bladder?$mq$, $mq$["Ureter","Urethra","Renal vein","Renal artery"]$mq$, 0, $mq$There is one ureter from each kidney. The urethra carries urine from the bladder out of the body.$mq$, $mq$easy$mq$),
($mq$Which waste gas is excreted by the lungs?$mq$, $mq$["Oxygen","Urea","Nitrogen","Carbon dioxide"]$mq$, 3, $mq$Carbon dioxide is a waste product of respiration and is excreted when we breathe out.$mq$, $mq$medium$mq$),
($mq$Which type of molecule is normally too large to be filtered out of the blood in the kidney?$mq$, $mq$["Glucose","Urea","Protein","Water"]$mq$, 2, $mq$Filtration in the kidney lets small molecules such as water, glucose, urea and salts pass out, but proteins and blood cells stay in the blood.$mq$, $mq$medium$mq$),
($mq$What happens to all of the glucose that is filtered out of the blood in a healthy kidney?$mq$, $mq$["It is changed into urea","It is reabsorbed into the blood","It is excreted in the urine","It is broken down in the bladder"]$mq$, 1, $mq$Selective reabsorption returns all of the glucose to the blood, so healthy urine contains no glucose.$mq$, $mq$medium$mq$),
($mq$A person's urine contains glucose. Which condition might this suggest?$mq$, $mq$["Diabetes","Anaemia","Asthma","Scurvy"]$mq$, 0, $mq$In diabetes the blood glucose is so high that the kidney cannot reabsorb it all, so some is lost in the urine.$mq$, $mq$medium$mq$),
($mq$In a dialysis machine, which waste substance moves from the patient's blood into the dialysis fluid?$mq$, $mq$["Glucose","Protein","Oxygen","Urea"]$mq$, 3, $mq$Urea diffuses from the blood, where it is concentrated, into the dialysis fluid, which contains none.$mq$, $mq$medium$mq$),
($mq$A person's urine contains 20 g of urea per dm³. They produce 1.5 dm³ of urine in a day. How many grams of urea are lost in a day?$mq$, $mq$["13.3","21.5","30","3"]$mq$, 2, $mq$20 × 1.5 = 30 g of urea.$mq$, $mq$medium$mq$),
($mq$Which blood vessel brings blood to the kidney?$mq$, $mq$["Renal vein","Renal artery","Vena cava","Hepatic vein"]$mq$, 1, $mq$The renal artery brings blood to be filtered and the renal vein carries filtered blood away.$mq$, $mq$medium$mq$),
($mq$Why does dialysis fluid contain no urea?$mq$, $mq$["To keep urea diffusing out of the blood","To add urea to the blood","To stop glucose leaving the blood","To make the blood clot"]$mq$, 0, $mq$With no urea in the fluid, a steep concentration gradient is maintained all along the membrane.$mq$, $mq$medium$mq$),
($mq$Dialysis fluid contains glucose at the same concentration as normal blood. Why?$mq$, $mq$["So the patient makes more urea","So glucose diffuses out of the blood","So the blood cells burst","So glucose does not diffuse out of the blood"]$mq$, 3, $mq$If there is no difference in concentration, there is no net movement of glucose. The patient keeps their glucose while urea is removed.$mq$, $mq$hard$mq$),
($mq$In a healthy person, glucose is found in the fluid filtered from the blood, but not in the urine. Which process explains this?$mq$, $mq$["Filtration","Evaporation","Selective reabsorption","Egestion"]$mq$, 2, $mq$Filtration is not selective. Later, the kidney tubule reabsorbs all the glucose, plus some water and salts.$mq$, $mq$hard$mq$),
($mq$Urea is at 0.3 g per dm³ in the filtrate and 20 g per dm³ in urine. How many times more concentrated is urea in the urine, to the nearest whole number?$mq$, $mq$["6","67","20","0.015"]$mq$, 1, $mq$20 ÷ 0.3 = 66.7, which is 67 to the nearest whole number. Water reabsorption concentrates the urea.$mq$, $mq$hard$mq$),
($mq$Why can a kidney transplant be better for a patient than long-term dialysis?$mq$, $mq$["No regular machine sessions are needed","It cures every other disease","There is no risk of rejection","The donor kidney never needs matching"]$mq$, 0, $mq$A working transplanted kidney does the job all the time, so the patient is not tied to a machine. The patient must still take drugs to reduce the risk of rejection.$mq$, $mq$hard$mq$),
($mq$A patient's urine contains protein. What is the most likely explanation?$mq$, $mq$["The ureter is blocked","Too much protein is being reabsorbed","The patient is dehydrated","The filter in the kidney is damaged"]$mq$, 3, $mq$Protein molecules are too big to pass through a healthy filter. Their presence in urine suggests that the filter in the kidney is damaged.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Kidneys, Urine and Waste Removal$mq$ and p.name = $mq$Gas Exchange and Excretion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Excretion$mq$, $mq$The removal of waste products of metabolism, such as carbon dioxide, urea and excess water and salts.$mq$),
($mq$Where is urea made?$mq$, $mq$In the liver, from excess amino acids. The blood carries it to the kidneys to be excreted in urine.$mq$),
($mq$Path of urine$mq$, $mq$Kidney, ureter, bladder (stored), urethra, out of the body.$mq$),
($mq$Stage 1 in the kidney: filtration$mq$, $mq$Small molecules (water, glucose, urea, salts) are forced out of the blood into the tubule. Proteins and blood cells stay in the blood.$mq$),
($mq$Stage 2: selective reabsorption$mq$, $mq$Useful substances return to the blood: all glucose, some salts and as much water as the body needs.$mq$),
($mq$Glucose in urine$mq$, $mq$May suggest diabetes: blood sugar is so high that the kidney cannot reabsorb all of it.$mq$),
($mq$Protein in urine$mq$, $mq$Suggests damage to the kidney filter, because healthy kidneys do not let protein through.$mq$),
($mq$How dialysis works$mq$, $mq$Blood passes by a partially permeable membrane. Urea diffuses into dialysis fluid that has no urea but normal glucose and salts.$mq$),
($mq$Transplant vs dialysis$mq$, $mq$A transplant works all the time and frees the patient from machines, but needs a matching donor and anti-rejection drugs.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Kidneys, Urine and Waste Removal$mq$ and p.name = $mq$Gas Exchange and Excretion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Excretion is the removal of waste products made by the chemical reactions of metabolism. If these wastes build up they become toxic. Do not confuse it with egestion, which is the removal of undigested food.

## Main excretory products and organs
- **Carbon dioxide**: made by respiration and excreted by the lungs.
- **Urea**: made in the liver when excess amino acids are broken down. It is carried in the blood plasma to the kidneys and excreted in urine.
- **Water and salts**: lost in sweat from the skin and in urine. Sweat's main job is cooling, though it does remove some salts.

## The urinary system
Blood enters each kidney through the renal artery. The kidney filters the blood and the cleaned blood leaves through the renal vein. The liquid waste, urine, passes along the ureters to the bladder, where it is stored. It leaves the body through the urethra.

## How the kidney makes urine
Each kidney contains about a million tiny filtering units called nephrons. Two main stages are needed at MYP level.
1. **Filtration**: blood is forced under pressure into a ball of capillaries. Small molecules such as water, glucose, urea and salts are squeezed out into the kidney tubule. Large molecules such as proteins and blood cells stay in the blood because they are too big.
2. **Selective reabsorption**: as the filtrate moves along the tubule, useful substances are taken back into the blood. All of the glucose is reabsorbed, as well as some salts and as much water as the body needs. The remaining liquid, containing urea, extra salts and water, is urine.

The amount of water reabsorbed depends on how hydrated you are. When you are dehydrated, the kidney reabsorbs more water and the urine is small in volume and dark. When you drink a lot of water, urine is large in volume and pale.

## Diagnosis from urine
Glucose in urine can suggest diabetes. Protein in urine suggests that the kidney filter is damaged.

## Kidney failure
If the kidneys stop working, urea and salts build up in the blood. There are two treatments.
- **Dialysis**: the patient's blood passes through a machine with a partially permeable membrane. The dialysis fluid on the other side contains no urea and normal levels of glucose and salts. Urea diffuses out of the blood, while glucose and useful salts stay. Dialysis takes several hours, several times per week.
- **Transplant**: a healthy kidney from a donor is placed in the patient. The kidney must be a close match and the patient takes drugs to reduce the risk of rejection, but there is no need for regular machine treatment.

## Worked example
Urine contains 20 g of urea per dm³. A person produces 1.5 dm³ in a day, so the mass of urea excreted is 20 × 1.5 = 30 g. Comparing concentrations: if filtrate has 0.3 g per dm³ of urea, urine is 20 ÷ 0.3 = 67 times more concentrated.

## Common mistakes
- Writing that urea is made in the kidney. It is made in the liver.
- Saying that urine is made in the bladder. It is made in the kidney and stored in the bladder.
- Saying glucose is filtered out and lost. It is filtered, then fully reabsorbed.
- Mixing up the ureter (kidney to bladder) and the urethra (bladder to outside).

## How this is examined
Expect diagrams of the urinary system and data tables comparing blood, filtrate and urine. Criterion D tasks might ask you to evaluate dialysis against transplants for a patient.

Exam tip: when comparing concentrations in a table, name the substance, quote both values, and then say what process (filtration or reabsorption) explains the change.$mq$ from st;

-- Coordination, Response and Homeostasis > Neurones, Reflex Arcs and Responses
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Coordination, Response and Homeostasis$mq$, 4, 8 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Neurones, Reflex Arcs and Responses$mq$, 4, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Coordination, Response and Homeostasis$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Neurones, Reflex Arcs and Responses$mq$ and p.name = $mq$Coordination, Response and Homeostasis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a change in the environment that is detected by a receptor called?$mq$, $mq$["Stimulus","Hormone","Response","Effector"]$mq$, 0, $mq$A stimulus is any change in the environment, such as light, heat or pressure, that a receptor can detect.$mq$, $mq$easy$mq$),
($mq$Which two organs make up the central nervous system?$mq$, $mq$["Brain and heart","Spinal cord and muscles","Nerves and receptors","Brain and spinal cord"]$mq$, 3, $mq$The central nervous system (CNS) is the brain and spinal cord. Nerves outside the CNS make up the peripheral system.$mq$, $mq$easy$mq$),
($mq$Which type of neurone carries impulses from receptors to the central nervous system?$mq$, $mq$["Motor neurone","Relay neurone","Sensory neurone","Synapse"]$mq$, 2, $mq$Sensory neurones take information from receptors into the CNS.$mq$, $mq$easy$mq$),
($mq$What is the name of the tiny gap between two neurones?$mq$, $mq$["Nucleus","Synapse","Axon","Myelin sheath"]$mq$, 1, $mq$At a synapse, chemicals called neurotransmitters carry the signal across the gap.$mq$, $mq$easy$mq$),
($mq$What name is given to a fast, automatic response that does not involve conscious thought?$mq$, $mq$["Reflex","Voluntary action","Hormone response","Growth"]$mq$, 0, $mq$A reflex is automatic and protects the body, for example pulling a hand from a hot object.$mq$, $mq$easy$mq$),
($mq$Muscles and glands that carry out a response are called what?$mq$, $mq$["Receptors","Coordinators","Stimuli","Effectors"]$mq$, 3, $mq$Effectors respond to nerve impulses: muscles contract and glands release substances.$mq$, $mq$medium$mq$),
($mq$Which type of neurone carries impulses from the central nervous system to an effector?$mq$, $mq$["Relay neurone","Sensory neurone","Motor neurone","Receptor neurone"]$mq$, 2, $mq$Motor neurones carry instructions from the CNS to muscles or glands.$mq$, $mq$medium$mq$),
($mq$How does a nerve impulse cross a synapse?$mq$, $mq$["By electric sparks jumping the gap","By chemicals diffusing across the gap","By hormones in the blood","By osmosis of water"]$mq$, 1, $mq$The first neurone releases neurotransmitter, which diffuses across the gap and triggers an impulse in the next neurone.$mq$, $mq$medium$mq$),
($mq$What name is given to the fatty layer that insulates some axons and speeds up impulses?$mq$, $mq$["Myelin sheath","Nucleus","Cell membrane","Synapse"]$mq$, 0, $mq$The myelin sheath insulates the axon, so impulses travel much faster along it.$mq$, $mq$medium$mq$),
($mq$What happens to the pupil of the eye in bright light?$mq$, $mq$["It becomes flat","It gets larger","It changes colour","It gets smaller"]$mq$, 3, $mq$The pupil constricts to reduce the amount of light entering, which protects the retina.$mq$, $mq$medium$mq$),
($mq$Which part of the eye contains the light-sensitive receptor cells?$mq$, $mq$["Cornea","Lens","Retina","Iris"]$mq$, 2, $mq$The retina contains rod and cone cells that detect light.$mq$, $mq$medium$mq$),
($mq$In a ruler-drop test, a student catches the ruler after it falls 14 cm, 16 cm and 15 cm. What is the mean distance in cm?$mq$, $mq$["45","15","14.5","16"]$mq$, 1, $mq$(14 + 16 + 15) ÷ 3 = 45 ÷ 3 = 15 cm. A shorter distance means a faster reaction.$mq$, $mq$medium$mq$),
($mq$In a withdrawal reflex, which neurone is located inside the spinal cord?$mq$, $mq$["Relay neurone","Motor neurone","Sensory neurone","Receptor neurone"]$mq$, 0, $mq$The relay neurone connects the sensory neurone to the motor neurone inside the spinal cord.$mq$, $mq$medium$mq$),
($mq$Why is a reflex response faster than a voluntary response?$mq$, $mq$["Impulses travel faster in reflex neurones","It uses hormones","It has more synapses","It avoids the conscious part of the brain"]$mq$, 3, $mq$In a reflex, the impulse goes through the spinal cord without waiting for decisions in the brain, so fewer synapses are involved and the response is quicker.$mq$, $mq$hard$mq$),
($mq$In a reflex arc, which structure comes directly after the relay neurone?$mq$, $mq$["Sensory neurone","Receptor","Motor neurone","Stimulus"]$mq$, 2, $mq$The order is stimulus, receptor, sensory neurone, relay neurone, motor neurone, effector, response.$mq$, $mq$hard$mq$),
($mq$In dim light the pupil gets bigger. Which muscles of the iris contract to cause this?$mq$, $mq$["Ciliary muscles","Radial muscles","Circular muscles","Cardiac muscles"]$mq$, 1, $mq$Radial muscles pull the iris outwards and make the pupil larger. In bright light the circular muscles contract and make it smaller.$mq$, $mq$hard$mq$),
($mq$An impulse travels 1.2 m along a nerve at 60 m/s. How long does it take in seconds?$mq$, $mq$["0.02","50","72","0.2"]$mq$, 0, $mq$time = distance ÷ speed = 1.2 ÷ 60 = 0.02 s.$mq$, $mq$hard$mq$),
($mq$After an accident, a person's motor neurones to the hand are cut but the sensory neurones are fine. What is the result?$mq$, $mq$["They can neither feel nor move it","They can move the hand but cannot feel it","Their reflexes become faster","They can feel the hand but cannot move it"]$mq$, 3, $mq$Sensory neurones still carry impulses to the CNS, but without motor neurones the instruction to move cannot reach the muscles.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Neurones, Reflex Arcs and Responses$mq$ and p.name = $mq$Coordination, Response and Homeostasis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Reflex arc pathway$mq$, $mq$Stimulus, receptor, sensory neurone, relay neurone, motor neurone, effector, response.$mq$),
($mq$Sensory neurone$mq$, $mq$Carries impulses from receptors to the central nervous system.$mq$),
($mq$Motor neurone$mq$, $mq$Carries impulses from the central nervous system to effectors (muscles or glands).$mq$),
($mq$Synapse$mq$, $mq$A tiny gap between two neurones. Neurotransmitter chemicals diffuse across it and start a new impulse.$mq$),
($mq$Central nervous system$mq$, $mq$The brain and the spinal cord.$mq$),
($mq$Effector$mq$, $mq$A muscle or gland that carries out a response.$mq$),
($mq$Why are reflexes important?$mq$, $mq$They are fast and automatic, so they protect the body from harm before the brain has time to decide.$mq$),
($mq$Pupil in bright light$mq$, $mq$Circular muscles contract and the pupil gets smaller to protect the retina.$mq$),
($mq$Function of the myelin sheath$mq$, $mq$A fatty layer that insulates the axon and makes impulses travel faster.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Neurones, Reflex Arcs and Responses$mq$ and p.name = $mq$Coordination, Response and Homeostasis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Living things must detect changes in their surroundings and respond to them. In humans, this coordination is done by the nervous system. Its job is to send electrical impulses quickly from where a change is detected to where a response is needed.

## Key terms
- **Stimulus**: a change in the environment, such as light, sound, temperature or pressure.
- **Receptor**: a cell or organ that detects a stimulus, for example the retina in the eye.
- **Coordinator**: the central nervous system (CNS), made of the brain and the spinal cord. It processes information and decides on a response.
- **Effector**: a muscle or gland that carries out the response.
- **Response**: the action that results, such as muscle contraction or release of a substance.

## Neurones
A neurone, or nerve cell, is a long specialised cell that carries electrical impulses. There are three types.
- **Sensory neurones** carry impulses from receptors to the CNS.
- **Relay neurones** are in the CNS and connect sensory neurones to motor neurones.
- **Motor neurones** carry impulses from the CNS to effectors.

A neurone has a cell body, a long axon, and branched endings. Many axons are surrounded by a fatty myelin sheath that insulates the axon and speeds up the impulse. Two neurones do not touch. There is a tiny gap between them called a **synapse**. When an impulse reaches the end of one neurone it releases chemicals called neurotransmitters, which diffuse across the gap and start a new impulse in the next neurone. Synapses make sure that impulses only travel in one direction.

## The reflex arc
A reflex is a fast, automatic response. The path taken is the reflex arc: stimulus, receptor, sensory neurone, relay neurone (in the spinal cord), motor neurone, effector, response. For example, if you touch something hot, pain receptors in the skin send an impulse along a sensory neurone to the spinal cord. The relay neurone passes the impulse to a motor neurone, and the muscle in the arm contracts so the hand pulls away. The brain is informed afterwards. Reflexes are quick because the path is short with few synapses, and conscious decisions are not needed.

## Reflexes in the eye
The iris controls how much light enters the pupil. In bright light, circular muscles contract and the pupil becomes smaller, which protects the retina. In dim light, radial muscles contract and the pupil becomes larger, so more light can enter.

## Worked example
A ruler-drop test measures reaction time. Three drops give 14 cm, 16 cm and 15 cm. Mean = (14 + 16 + 15) ÷ 3 = 15 cm. A smaller mean distance means a faster reaction. Speed example: an impulse travels 1.2 m at 60 m/s, so time = 1.2 ÷ 60 = 0.02 s.

## Common mistakes
- Saying that the brain is involved in every reflex. A reflex is processed in the spinal cord.
- Mixing up the two neurones: sensory goes into the CNS, motor goes out of it.
- Describing a synapse as a physical joining of two neurones. There is a gap.
- Saying the pupil gets bigger in bright light.

## How this is examined
Questions often label a reflex arc and ask you to name each part, or ask you to explain why reflexes are important. Criterion B may ask you to plan a fair-test investigation of reaction time, naming the independent variable, dependent variable and controlled variables, and repeating readings to find a mean.

Exam tip: when you describe a reflex arc, give the parts in order using the exact words stimulus, receptor, sensory neurone, relay neurone, motor neurone, effector, response.$mq$ from st;

-- Coordination, Response and Homeostasis > Hormones and Blood Glucose Control
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Coordination, Response and Homeostasis$mq$, 4, 8 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Hormones and Blood Glucose Control$mq$, 4, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Coordination, Response and Homeostasis$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Hormones and Blood Glucose Control$mq$ and p.name = $mq$Coordination, Response and Homeostasis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which organ makes the hormone insulin?$mq$, $mq$["Pancreas","Thyroid","Liver","Kidney"]$mq$, 0, $mq$Insulin is made by cells in the pancreas and released into the blood.$mq$, $mq$easy$mq$),
($mq$What do hormones travel in?$mq$, $mq$["Urine","Neurones","Bile","Blood"]$mq$, 3, $mq$Hormones are chemical messengers released by glands straight into the blood, which carries them to target organs.$mq$, $mq$easy$mq$),
($mq$Which hormone is released in a frightening situation to prepare the body for action?$mq$, $mq$["Insulin","Oestrogen","Adrenaline","Thyroxine"]$mq$, 2, $mq$Adrenaline increases heart rate and releases glucose so that the body is ready to fight or run away.$mq$, $mq$easy$mq$),
($mq$Which sugar in the blood has its level controlled by insulin and glucagon?$mq$, $mq$["Lactose","Glucose","Sucrose","Maltose"]$mq$, 1, $mq$Insulin and glucagon keep the level of blood glucose within narrow limits.$mq$, $mq$easy$mq$),
($mq$What name is given to a gland that releases hormones directly into the blood?$mq$, $mq$["Endocrine gland","Sweat gland","Salivary gland","Tear gland"]$mq$, 0, $mq$Endocrine glands are ductless and release hormones straight into the bloodstream.$mq$, $mq$easy$mq$),
($mq$In which organ is glucose converted to glycogen when insulin is released?$mq$, $mq$["Stomach","Pancreas","Kidney","Liver"]$mq$, 3, $mq$Insulin causes the liver (and muscles) to take up glucose and store it as glycogen, which lowers blood glucose.$mq$, $mq$medium$mq$),
($mq$What does glucagon cause the liver to do?$mq$, $mq$["Make more insulin","Store glucose as glycogen","Release glucose from glycogen","Make urea from glucose"]$mq$, 2, $mq$Glucagon is released when blood glucose is low. It causes glycogen to be broken down to glucose.$mq$, $mq$medium$mq$),
($mq$Compared with nervous responses, hormone responses are usually what?$mq$, $mq$["Faster and longer lasting","Slower and longer lasting","Faster and shorter","Slower and shorter"]$mq$, 1, $mq$Hormones travel in the blood, which takes longer than an electrical impulse, but their effects last for longer.$mq$, $mq$medium$mq$),
($mq$A person's pancreas does not make enough insulin. What condition is this?$mq$, $mq$["Diabetes","Scurvy","Anaemia","Asthma"]$mq$, 0, $mq$Without insulin, blood glucose rises too high. This is called type 1 diabetes.$mq$, $mq$medium$mq$),
($mq$How is type 1 diabetes usually treated?$mq$, $mq$["Eating more sugar","Antibiotics","Dialysis","Insulin injections"]$mq$, 3, $mq$People with type 1 diabetes inject insulin and monitor their diet and blood glucose.$mq$, $mq$medium$mq$),
($mq$After a sugary meal blood glucose rises. Which hormone is released into the blood?$mq$, $mq$["Glucagon","Adrenaline","Insulin","Thyroxine"]$mq$, 2, $mq$Insulin is released when blood glucose is high and lowers it again.$mq$, $mq$medium$mq$),
($mq$What effect does adrenaline have on the heart?$mq$, $mq$["Stops the heart","Increases heart rate","Decreases heart rate","No effect"]$mq$, 1, $mq$Adrenaline makes the heart beat faster, so more oxygen and glucose are delivered to the muscles.$mq$, $mq$medium$mq$),
($mq$Which gland in the neck makes thyroxine, which controls metabolic rate?$mq$, $mq$["Thyroid","Pituitary","Adrenal","Pancreas"]$mq$, 0, $mq$Thyroxine from the thyroid gland controls how fast the body uses energy.$mq$, $mq$medium$mq$),
($mq$A glucose tolerance test records blood glucose at 5.0 mmol/dm³ before a sugary drink, 9.5 after one hour and 8.8 after three hours. A healthy person returns to about 5.0. What does this suggest about the tested person?$mq$, $mq$["They are healthy","They have too much glucagon","They have low blood sugar","They may have diabetes"]$mq$, 3, $mq$Their blood glucose stays high, so insulin is not working effectively. A doctor would run more tests.$mq$, $mq$hard$mq$),
($mq$Why is insulin injected rather than taken as a tablet?$mq$, $mq$["It is too small to be absorbed","It only works in muscles","Enzymes in the gut would digest it","It is absorbed too slowly"]$mq$, 2, $mq$Insulin is a protein, so protease enzymes in the stomach and small intestine would break it down before it reached the blood.$mq$, $mq$hard$mq$),
($mq$What name is given to a control system in which a change triggers a response that reverses the change?$mq$, $mq$["Positive feedback","Negative feedback","Reflex action","Osmosis"]$mq$, 1, $mq$In blood glucose control a rise causes insulin release, which lowers glucose again. This reverses the change.$mq$, $mq$hard$mq$),
($mq$In type 2 diabetes the blood contains plenty of insulin, but blood glucose is still high. What is the best explanation?$mq$, $mq$["Body cells respond poorly to insulin","The pancreas has been removed","Insulin is destroyed by phagocytes","Glucagon blocks the kidneys"]$mq$, 0, $mq$In type 2 diabetes, target cells have a reduced response to insulin. It is linked to diet, obesity and lack of exercise.$mq$, $mq$hard$mq$),
($mq$Blood glucose readings are 4.8 mmol/dm³ before a meal and 8.9 at the peak. What is the percentage increase, to the nearest whole number?$mq$, $mq$["46%","4.1%","185%","85%"]$mq$, 3, $mq$Increase = 8.9 − 4.8 = 4.1. Percentage increase = 4.1 ÷ 4.8 × 100 = 85%.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Hormones and Blood Glucose Control$mq$ and p.name = $mq$Coordination, Response and Homeostasis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Hormone$mq$, $mq$A chemical messenger made by an endocrine gland, carried in the blood to target organs.$mq$),
($mq$Nerves vs hormones$mq$, $mq$Nerves are fast and short-lived. Hormones are slower but longer lasting.$mq$),
($mq$Insulin$mq$, $mq$Made by the pancreas when blood glucose is high. It makes the liver and muscles store glucose as glycogen, so blood glucose falls.$mq$),
($mq$Glucagon$mq$, $mq$Made by the pancreas when blood glucose is low. It makes the liver break glycogen down into glucose, so blood glucose rises.$mq$),
($mq$Negative feedback$mq$, $mq$A change causes a response that reverses the change and returns the level to normal.$mq$),
($mq$Adrenaline$mq$, $mq$Released by the adrenal glands in danger. It increases heart rate and releases glucose for fight or flight.$mq$),
($mq$Type 1 diabetes$mq$, $mq$The pancreas makes too little insulin. Treated by insulin injections, diet and monitoring.$mq$),
($mq$Type 2 diabetes$mq$, $mq$Body cells respond poorly to insulin. Linked to diet and obesity and controlled with diet and exercise.$mq$),
($mq$Thyroxine$mq$, $mq$Made by the thyroid gland in the neck. It controls metabolic rate.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Hormones and Blood Glucose Control$mq$ and p.name = $mq$Coordination, Response and Homeostasis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Hormones are chemical messengers that coordinate processes in the body. They are made in endocrine glands, released directly into the blood and travel round the body. Each hormone affects only particular target organs, which have receptors for it.

## Nervous and hormonal systems compared
- Nervous system: electrical impulses along neurones, very fast, short-lived effects, usually affects one precise place.
- Hormonal system: chemicals in the blood, slower, longer-lasting effects, can affect more than one organ.

## Main endocrine glands
- **Pituitary gland** (brain): makes many hormones that control other glands, and ADH, which controls water balance.
- **Thyroid** (neck): makes thyroxine, which controls metabolic rate.
- **Pancreas**: makes insulin and glucagon.
- **Adrenal glands** (above the kidneys): make adrenaline.
- **Ovaries** make oestrogen and **testes** make testosterone.

## Adrenaline
Adrenaline is released in stressful situations. It speeds the heart rate, widens the pupils, increases breathing rate and causes the liver to release glucose. This prepares the body for "fight or flight".

## Controlling blood glucose
The level of glucose in the blood must stay within narrow limits so cells get enough energy and cells do not lose or gain too much water. The pancreas monitors the level.
- **Blood glucose too high** (after a meal): the pancreas releases **insulin**. Insulin makes the liver and muscles take up glucose and store it as **glycogen**, and also makes cells use more glucose. Blood glucose falls.
- **Blood glucose too low** (between meals or after exercise): the pancreas releases **glucagon**. This makes the liver break glycogen down into glucose, which enters the blood. Blood glucose rises.

This is a **negative feedback** system because the response reverses the original change.

## Diabetes
- **Type 1**: the pancreas does not make enough insulin. It is treated by injecting insulin, planning meals and monitoring blood glucose.
- **Type 2**: body cells respond poorly to insulin. It is linked to obesity and an unhealthy diet, and is controlled by a diet low in sugar, exercise and sometimes drugs.

## Worked example
A glucose tolerance test records 4.8 mmol/dm³ before a drink and 8.9 at the peak. Increase = 8.9 − 4.8 = 4.1. Percentage increase = 4.1 ÷ 4.8 × 100 = 85%. A healthy person would return to around 4.8 within a couple of hours, so a person whose level stays high may have diabetes.

## Common mistakes
- Mixing up insulin (lowers glucose) with glucagon (raises glucose).
- Mixing up glucose (a sugar), glycogen (the storage carbohydrate) and glucagon (a hormone).
- Saying insulin is made in the liver. It is made in the pancreas.
- Forgetting to say that hormones are carried in the blood.

## How this is examined
You may be given a graph of blood glucose and insulin after a meal and asked to describe and explain the pattern, or a table of readings for a person with and without diabetes. Criterion D questions may ask you to discuss the impact of diet on type 2 diabetes in a population.

Exam tip: in graph questions, quote values from the graph with units, describe the trend, and then explain it using the hormone names.$mq$ from st;

-- Coordination, Response and Homeostasis > Temperature Regulation and Feedback
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Coordination, Response and Homeostasis$mq$, 4, 8 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Temperature Regulation and Feedback$mq$, 4, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Coordination, Response and Homeostasis$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Temperature Regulation and Feedback$mq$ and p.name = $mq$Coordination, Response and Homeostasis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the normal human core body temperature?$mq$, $mq$["37°C","40°C","30°C","25°C"]$mq$, 0, $mq$Core body temperature is kept close to 37°C, the best temperature for enzymes in the body.$mq$, $mq$easy$mq$),
($mq$Which part of the brain monitors and controls body temperature?$mq$, $mq$["Cerebellum","Medulla","Retina","Hypothalamus"]$mq$, 3, $mq$The hypothalamus contains receptors that monitor the temperature of the blood and receives information from receptors in the skin.$mq$, $mq$easy$mq$),
($mq$What is the term for keeping a constant internal environment?$mq$, $mq$["Osmosis","Excretion","Homeostasis","Respiration"]$mq$, 2, $mq$Homeostasis is the maintenance of constant internal conditions such as temperature, water and glucose.$mq$, $mq$easy$mq$),
($mq$What do we produce on the skin that cools us as it evaporates?$mq$, $mq$["Bile","Sweat","Mucus","Urine"]$mq$, 1, $mq$Sweat is mostly water and needs heat to evaporate. This takes heat from the skin.$mq$, $mq$easy$mq$),
($mq$What name is given to the involuntary muscle shaking that releases heat in the cold?$mq$, $mq$["Shivering","Sweating","Peristalsis","Ventilation"]$mq$, 0, $mq$Shivering makes the muscles respire faster, which releases heat energy.$mq$, $mq$easy$mq$),
($mq$When the body is too hot, what happens to the arterioles in the skin?$mq$, $mq$["They disappear","They narrow","They close","They widen"]$mq$, 3, $mq$Vasodilation lets more warm blood flow near the skin surface, so more heat is lost by radiation.$mq$, $mq$medium$mq$),
($mq$Why does sweating cool the body?$mq$, $mq$["Sweat is colder than the body","Sweat reflects radiation","Heat is needed to evaporate the sweat","Sweat blocks the pores"]$mq$, 2, $mq$Evaporation requires energy, which is taken from the skin and the blood flowing near it.$mq$, $mq$medium$mq$),
($mq$Why does shivering warm the body?$mq$, $mq$["Muscles absorb heat","Muscle respiration releases heat","It stops blood flow","It makes sweat"]$mq$, 1, $mq$Rapid contractions need energy, and some of the energy released by respiration appears as heat.$mq$, $mq$medium$mq$),
($mq$In cold conditions the arterioles in the skin narrow. What is this process called?$mq$, $mq$["Vasoconstriction","Vasodilation","Osmosis","Egestion"]$mq$, 0, $mq$Vasoconstriction reduces blood flow near the skin surface, which reduces heat loss.$mq$, $mq$medium$mq$),
($mq$Which type of receptor in the skin detects temperature changes?$mq$, $mq$["Photoreceptors","Chemoreceptors","Pressure receptors","Thermoreceptors"]$mq$, 3, $mq$Thermoreceptors in the skin detect heat and cold, and send impulses to the brain.$mq$, $mq$medium$mq$),
($mq$A runner's core temperature rises from 37.0°C to 38.4°C during a race. By how many °C does it rise?$mq$, $mq$["0.4","2.4","1.4","38.4"]$mq$, 2, $mq$38.4 − 37.0 = 1.4°C.$mq$, $mq$medium$mq$),
($mq$Which hormone, released from the pituitary gland, causes the kidneys to reabsorb more water?$mq$, $mq$["Insulin","ADH","Glucagon","Thyroxine"]$mq$, 1, $mq$ADH is released when the blood is too concentrated. It makes the kidneys reabsorb more water, so less is lost in urine.$mq$, $mq$medium$mq$),
($mq$What are mammals that produce their own body heat called?$mq$, $mq$["Endotherms","Producers","Ectotherms","Herbivores"]$mq$, 0, $mq$Endotherms keep a stable temperature by internal heat production, unlike ectotherms, which rely on external heat.$mq$, $mq$medium$mq$),
($mq$Why is body temperature control an example of negative feedback?$mq$, $mq$["The response increases the change","The change is ignored","It uses no nerves or hormones","The response reverses the change"]$mq$, 3, $mq$If temperature rises, the response (sweating, vasodilation) cools the body, which reverses the change.$mq$, $mq$hard$mq$),
($mq$Which skin vessels widen and narrow to control heat loss?$mq$, $mq$["Capillaries","Veins","Arterioles","Venules"]$mq$, 2, $mq$Arterioles have muscle in their walls and can widen or narrow. Capillaries have no muscle and cannot move. A common mistake is to say that capillaries move closer to the skin.$mq$, $mq$hard$mq$),
($mq$In a cold room, which set of responses helps the body to conserve heat?$mq$, $mq$["Shivering, vasodilation, more sweating","Shivering, vasoconstriction, less sweating","Sweating, vasodilation, no shivering","No shivering, vasoconstriction, more sweating"]$mq$, 1, $mq$Shivering produces heat, vasoconstriction reduces heat loss from skin, and less sweating reduces cooling.$mq$, $mq$hard$mq$),
($mq$A person is dehydrated and the blood becomes more concentrated. What change is expected in their urine?$mq$, $mq$["Less urine that is more concentrated","Urine that contains glucose","More urine that is more dilute","No change"]$mq$, 0, $mq$More ADH is released, so the kidneys reabsorb more water. Urine is smaller in volume and darker.$mq$, $mq$hard$mq$),
($mq$A student places a hand in water at 10°C, 20°C, 30°C and 40°C and records skin temperature after 2 minutes. What is the independent variable?$mq$, $mq$["Skin temperature","Time in water","Size of the hand","Water temperature"]$mq$, 3, $mq$The independent variable is the one the student changes on purpose, which is the water temperature. The skin temperature is the dependent variable.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Temperature Regulation and Feedback$mq$ and p.name = $mq$Coordination, Response and Homeostasis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Homeostasis$mq$, $mq$Maintaining a constant internal environment, such as temperature, glucose and water content.$mq$),
($mq$Control centre for temperature$mq$, $mq$The hypothalamus in the brain, which monitors blood temperature and receives signals from skin thermoreceptors.$mq$),
($mq$Responses when too hot$mq$, $mq$Sweating, vasodilation of skin arterioles, and less shivering.$mq$),
($mq$Responses when too cold$mq$, $mq$Vasoconstriction, shivering, and no sweating.$mq$),
($mq$Why does sweating cool us?$mq$, $mq$Heat from the skin is needed to evaporate the sweat, so the skin loses heat.$mq$),
($mq$Vasodilation vs vasoconstriction$mq$, $mq$Dilation: arterioles widen and more heat is lost. Constriction: arterioles narrow and less heat is lost.$mq$),
($mq$Negative feedback$mq$, $mq$A change triggers a response that reverses the change and returns conditions to normal.$mq$),
($mq$Role of ADH$mq$, $mq$Released by the pituitary gland when blood is too concentrated. It makes the kidneys reabsorb more water.$mq$),
($mq$Why is 37°C important?$mq$, $mq$It is close to the optimum temperature of human enzymes, so reactions run efficiently.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Temperature Regulation and Feedback$mq$ and p.name = $mq$Coordination, Response and Homeostasis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Humans keep their internal conditions steady, even when the world outside changes. This is **homeostasis**. Examples include body temperature, blood glucose and water content. Enzymes work best at around 37°C, so the body keeps its core temperature near this value. If it gets too hot, enzymes can be damaged. If it gets too cold, reactions slow down.

## How temperature is controlled
The **hypothalamus** in the brain acts as the control centre. It contains receptors that monitor the temperature of the blood passing through it. Thermoreceptors in the skin also detect the temperature outside and send impulses to the hypothalamus. The hypothalamus then sends impulses to effectors such as the sweat glands, muscles and the blood vessels in the skin.

## When the body is too hot
- **Sweating**: sweat glands release sweat onto the skin. When it evaporates it takes heat energy from the skin, which cools the body.
- **Vasodilation**: the arterioles that supply the skin capillaries widen, so more blood flows near the surface and more heat is lost by radiation.
- Less shivering and muscle activity.

## When the body is too cold
- **Vasoconstriction**: the arterioles narrow, so less blood flows near the surface and less heat is lost.
- **Shivering**: muscles contract rapidly. Respiration in the muscles releases heat.
- Sweating stops. Hair erector muscles raise the hairs, which traps a layer of air, though this is not very effective in humans.

## Negative feedback
Temperature control is an example of **negative feedback**: a change away from the normal level causes a response that reverses the change and returns the level to normal. The cycle then repeats whenever the temperature moves away again. This is why body temperature varies only slightly around 37°C.

## Water balance
The water content of the blood is also controlled. The pituitary gland releases **ADH** when the blood is too concentrated, for example during dehydration. ADH makes the kidneys reabsorb more water, so the urine is smaller in volume and darker. If the blood is too dilute, less ADH is released and the urine is larger in volume and paler. This is also negative feedback.

## Worked example
A runner's core temperature rises from 37.0°C to 38.4°C. Rise = 38.4 − 37.0 = 1.4°C. As the temperature rises, the hypothalamus triggers sweating and vasodilation. Heat loss increases, the temperature falls and the sweating gradually stops.

## Common mistakes
- Saying that blood vessels "move closer to the skin". The arterioles change width, they do not move.
- Saying capillaries widen and narrow. Capillaries have no muscle; arterioles do.
- Forgetting evaporation. Sweat only cools you when it evaporates.
- Saying that the skin controls temperature. The skin is an effector; the hypothalamus is the control centre.

## How this is examined
Questions give data on skin temperature or core temperature during exercise and ask you to describe and explain the changes. Criterion B tasks might ask for a method to compare how fast different materials cool a beaker of warm water as a model of insulation, with controlled variables.

Exam tip: always link a response to its effect, for example "vasodilation increases blood flow near the skin, so more heat is lost by radiation".$mq$ from st;

-- Reproduction and Inheritance > Asexual and Sexual Reproduction Compared
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Reproduction and Inheritance$mq$, 4, 9 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Asexual and Sexual Reproduction Compared$mq$, 4, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Reproduction and Inheritance$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Asexual and Sexual Reproduction Compared$mq$ and p.name = $mq$Reproduction and Inheritance$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$How many parents are needed for asexual reproduction?$mq$, $mq$["One","Four","Two","Three"]$mq$, 0, $mq$Asexual reproduction involves only one parent and no gametes.$mq$, $mq$easy$mq$),
($mq$What are the sex cells, such as sperm and egg, called?$mq$, $mq$["Zygotes","Spores","Clones","Gametes"]$mq$, 3, $mq$Gametes are the sex cells that fuse during fertilisation.$mq$, $mq$easy$mq$),
($mq$What is the fusion of a male gamete and a female gamete called?$mq$, $mq$["Germination","Pollination","Fertilisation","Mitosis"]$mq$, 2, $mq$Fertilisation forms a zygote, which then develops into an embryo.$mq$, $mq$easy$mq$),
($mq$Which male part of a flower produces pollen?$mq$, $mq$["Stigma","Anther","Ovary","Petal"]$mq$, 1, $mq$The anther is at the top of the stamen and makes pollen grains containing the male gametes.$mq$, $mq$easy$mq$),
($mq$Offspring that are genetically identical to their single parent are called what?$mq$, $mq$["Clones","Mutants","Hybrids","Gametes"]$mq$, 0, $mq$Asexual reproduction uses mitosis, so the offspring are clones of the parent.$mq$, $mq$easy$mq$),
($mq$Which type of cell division produces gametes?$mq$, $mq$["Binary fission","Mitosis","Budding","Meiosis"]$mq$, 3, $mq$Meiosis halves the chromosome number, so gametes are haploid.$mq$, $mq$medium$mq$),
($mq$What is the transfer of pollen from an anther to a stigma called?$mq$, $mq$["Germination","Fertilisation","Pollination","Dispersal"]$mq$, 2, $mq$Pollination is the transfer of pollen. Fertilisation happens later, when the nuclei fuse.$mq$, $mq$medium$mq$),
($mq$How many chromosomes are in a human egg cell?$mq$, $mq$["46","23","92","12"]$mq$, 1, $mq$Gametes are haploid and have half the usual number of chromosomes, which is 23 in humans.$mq$, $mq$medium$mq$),
($mq$What name is given to asexual reproduction in bacteria?$mq$, $mq$["Binary fission","Fertilisation","Budding","Pollination"]$mq$, 0, $mq$A bacterium copies its DNA and then splits into two identical cells by binary fission.$mq$, $mq$medium$mq$),
($mq$What is one advantage of asexual reproduction?$mq$, $mq$["It makes offspring different from the parent","It increases genetic variation","It needs two parents","No mate is needed"]$mq$, 3, $mq$Asexual reproduction can be quick and only needs one parent. The offspring are identical, so it gives no variation.$mq$, $mq$medium$mq$),
($mq$Which feature is typical of a wind-pollinated flower?$mq$, $mq$["Brightly coloured petals","Scented nectar","Large feathery stigmas","Sticky spiky pollen"]$mq$, 2, $mq$Feathery stigmas catch pollen from the air. Wind-pollinated flowers have small, dull petals and light, smooth pollen.$mq$, $mq$medium$mq$),
($mq$One bacterium divides by binary fission every 20 minutes. How many bacteria are there after 2 hours?$mq$, $mq$["12","64","6","32"]$mq$, 1, $mq$2 hours is 120 minutes, which is 6 divisions. 2⁶ = 64 bacteria.$mq$, $mq$medium$mq$),
($mq$In which part of a flower does fertilisation take place?$mq$, $mq$["Ovule","Anther","Stigma","Petal"]$mq$, 0, $mq$The male nucleus travels down the pollen tube and fuses with the female nucleus in the ovule. The fertilised ovule becomes a seed.$mq$, $mq$medium$mq$),
($mq$Why does sexual reproduction produce variation?$mq$, $mq$["Mitosis copies DNA exactly","One parent gives all the genes","The offspring are clones","Genes from two different parents are mixed"]$mq$, 3, $mq$Gametes carry different combinations of alleles from each parent. Fertilisation is random, so each zygote has a new combination.$mq$, $mq$hard$mq$),
($mq$What is a disadvantage of asexual reproduction in a wild population?$mq$, $mq$["Offspring cannot grow","It is slower than sexual reproduction","The whole population is vulnerable to the same disease","It needs a mate"]$mq$, 2, $mq$Clones share the same alleles, so a disease or change in the environment that harms one individual can harm them all.$mq$, $mq$hard$mq$),
($mq$A farmer grows strawberries by planting runners. Why is this useful?$mq$, $mq$["It increases variation","Offspring keep the same desirable traits","Seeds disperse further","It needs insects"]$mq$, 1, $mq$Runners are asexual reproduction, so the new plants are clones of a parent that produced good fruit.$mq$, $mq$hard$mq$),
($mq$What is the correct order of events in the sexual reproduction of a flowering plant?$mq$, $mq$["Pollination, fertilisation, seed formation","Pollination, seed formation, fertilisation","Fertilisation, pollination, seed formation","Seed formation, pollination, fertilisation"]$mq$, 0, $mq$Pollen lands on the stigma, the pollen tube grows, the nuclei fuse and the fertilised ovule becomes a seed.$mq$, $mq$hard$mq$),
($mq$A human zygote has 46 chromosomes. How many chromosomes are in each daughter cell after the zygote's first mitosis?$mq$, $mq$["23","92","69","46"]$mq$, 3, $mq$Mitosis produces genetically identical cells with the same chromosome number as the parent cell.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Asexual and Sexual Reproduction Compared$mq$ and p.name = $mq$Reproduction and Inheritance$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Asexual reproduction$mq$, $mq$One parent, no gametes, mitosis. The offspring are genetically identical clones.$mq$),
($mq$Sexual reproduction$mq$, $mq$Two parents make gametes by meiosis. Fertilisation produces offspring with a mixture of genes, so there is variation.$mq$),
($mq$Gametes$mq$, $mq$Sex cells (sperm, egg cell, and the male nucleus in a pollen grain). They are haploid: human gametes have 23 chromosomes.$mq$),
($mq$Fertilisation$mq$, $mq$The fusion of a male gamete nucleus with a female gamete nucleus to form a zygote.$mq$),
($mq$Pollination$mq$, $mq$The transfer of pollen from an anther to a stigma.$mq$),
($mq$Advantage of sexual reproduction$mq$, $mq$Variation. Some individuals may survive changes in the environment or a new disease.$mq$),
($mq$Disadvantage of asexual reproduction$mq$, $mq$No variation, so the whole population can be wiped out by the same disease or environmental change.$mq$),
($mq$Examples of asexual reproduction$mq$, $mq$Binary fission in bacteria, runners in strawberries, tubers in potatoes, budding in yeast.$mq$),
($mq$Wind-pollinated flower features$mq$, $mq$Small dull petals, no scent or nectar, large feathery stigmas, and light smooth pollen in large amounts.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Asexual and Sexual Reproduction Compared$mq$ and p.name = $mq$Reproduction and Inheritance$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Reproduction produces new individuals of the same species. There are two types: asexual and sexual. They differ in the number of parents, how the offspring are made and how much variation there is.

## Asexual reproduction
Only **one parent** is needed. No gametes are involved and no fertilisation takes place. The parent cell divides by **mitosis**, so the offspring are genetically identical to the parent. They are called **clones**. Examples:
- **Bacteria** divide by binary fission.
- **Strawberry plants** produce runners (stems that grow along the ground and form new plants).
- **Potato plants** form tubers that grow into new plants.
- **Yeast** makes buds that break off.

Advantages: it is quick, needs only one parent, does not need a mate and can produce many offspring in a short time. Disadvantages: no genetic variation, so a change in the environment or a new disease can affect the whole population.

## Sexual reproduction
Two parents are involved. Each makes **gametes** by **meiosis**, which halves the number of chromosomes. Human gametes have 23 chromosomes (haploid) and body cells have 46 (diploid). Fertilisation, the fusion of the male and female gamete, makes a **zygote** with the full number of chromosomes. The zygote divides by mitosis to form an embryo. The offspring are not identical to either parent because they inherit a mix of alleles from both parents.

Advantages: variation means that some individuals may survive a change in environment or disease, which allows natural selection and evolution. Disadvantages: it needs two parents, it takes more time and energy, and fewer offspring are produced.

## Sexual reproduction in flowering plants
- The **anther** makes pollen, which contains the male gamete. The **ovary** contains ovules with female gametes. The **stigma** receives pollen.
- **Pollination** is the transfer of pollen from the anther to the stigma. Insect-pollinated flowers have bright petals, scent and nectar, and sticky pollen. Wind-pollinated flowers have small dull petals and large feathery stigmas.
- After pollination, a pollen tube grows down to the ovule and the male nucleus fuses with the female nucleus. This is **fertilisation**.
- The fertilised ovule becomes a **seed** and the ovary becomes the fruit.

## Worked example
One bacterium divides every 20 minutes. In 2 hours (120 minutes) there are 120 ÷ 20 = 6 divisions. Number of bacteria = 2⁶ = 64. This shows how fast asexual reproduction can increase a population.

## Common mistakes
- Mixing up pollination (moving pollen) with fertilisation (fusion of nuclei).
- Writing that asexual reproduction uses meiosis. It uses mitosis.
- Saying that sexual reproduction always involves two different individuals. Some plants can pollinate themselves, but the gametes are still produced by meiosis, so there is variation.
- Saying clones are always identical in appearance. They have identical genes, but the environment can still change how they look.

## How this is examined
Questions ask you to compare the two types in a table, to label flower diagrams or to explain which type of reproduction suits a farmer or a species in a changing environment. Criterion D tasks may ask you to evaluate the use of cloning to grow crops.

Exam tip: in comparison questions, use comparative words in every statement, such as "asexual reproduction produces offspring faster, but sexual reproduction produces more variation".$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('biology')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;