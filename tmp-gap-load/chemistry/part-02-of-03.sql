-- Part 2 of 3: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Chemistry in Everyday Life > Food Chemistry: Fats, Sugars and Proteins
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Chemistry in Everyday Life$mq$, 5, 2 from public.subjects s where s.slug = $mq$chemistry$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Food Chemistry: Fats, Sugars and Proteins$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$chemistry$mq$ and p.grade = 5 and p.name = $mq$Chemistry in Everyday Life$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Food Chemistry: Fats, Sugars and Proteins$mq$ and p.name = $mq$Chemistry in Everyday Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$A drop of iodine solution turns blue-black on a food sample. Which nutrient is present?$mq$, $mq$["Starch","Protein","Fat","Vitamin C"]$mq$, 0, $mq$Iodine solution is orange-brown but turns blue-black with starch.$mq$, $mq$easy$mq$),
($mq$What are the monomers (building blocks) of proteins?$mq$, $mq$["Glucose molecules","Fatty acids","Glycerol molecules","Amino acids"]$mq$, 3, $mq$Proteins are long chains of amino acids joined by peptide bonds.$mq$, $mq$easy$mq$),
($mq$Which nutrient releases the most energy per gram when eaten?$mq$, $mq$["Carbohydrate","Protein","Fat","Water"]$mq$, 2, $mq$Fat gives about 37 kJ per gram, roughly double the energy of carbohydrate or protein.$mq$, $mq$easy$mq$),
($mq$A positive Benedict's test on warming gives which colour?$mq$, $mq$["Blue","Brick-red or orange","Purple","Blue-black"]$mq$, 1, $mq$Benedict's solution starts blue and turns green, yellow, orange then brick-red with reducing sugars.$mq$, $mq$easy$mq$),
($mq$A positive biuret test for protein gives which colour?$mq$, $mq$["Purple or violet","Orange","Brick-red","Blue-black"]$mq$, 0, $mq$Sodium hydroxide and copper sulfate turn from blue to purple with protein.$mq$, $mq$easy$mq$),
($mq$A fat or oil molecule is made from which parts?$mq$, $mq$["Three glycerols and one fatty acid","Many amino acids","Many glucose units","One glycerol and three fatty acids"]$mq$, 3, $mq$Fats are triglycerides: an ester of glycerol with three fatty acid chains.$mq$, $mq$medium$mq$),
($mq$What makes a fat saturated?$mq$, $mq$["It contains water","Its chains contain C=C double bonds","Its fatty acid chains contain only single carbon-carbon bonds","It has no carbon atoms"]$mq$, 2, $mq$Saturated fatty acids have no C=C bonds. Unsaturated ones have one or more.$mq$, $mq$medium$mq$),
($mq$Equal volumes of oils X and Y are tested. X needs 3 drops of bromine water before the orange colour stays, and Y needs 12 drops. What can you conclude?$mq$, $mq$["X is more unsaturated than Y","Y is more unsaturated than X","X and Y are identical","X contains starch"]$mq$, 1, $mq$Unsaturated oils react with bromine at C=C bonds, so the oil that uses more bromine has more double bonds. Y used more, so Y is more unsaturated.$mq$, $mq$medium$mq$),
($mq$Vegetable oil is hydrogenated using nickel at about 60 °C to make margarine. What is the main change?$mq$, $mq$["Hydrogen adds across C=C bonds, making the fat firmer","Water is removed","Oxygen is added","C-C bonds break"]$mq$, 0, $mq$Hydrogenation turns C=C into C-C, giving a more saturated fat with a higher melting point.$mq$, $mq$medium$mq$),
($mq$What forms when two amino acids join to make a peptide bond?$mq$, $mq$["Carbon dioxide is released","Oxygen is released","Nothing is released","A water molecule is released"]$mq$, 3, $mq$Amino acids join by condensation, losing one water molecule for each peptide bond.$mq$, $mq$medium$mq$),
($mq$A food sample gives a blue Benedict's test. It is boiled with dilute hydrochloric acid, neutralised and tested again. This time it turns brick-red. What does this suggest?$mq$, $mq$["It contains starch only","It contains only fat","It contains a non-reducing sugar such as sucrose","It contains no carbohydrate"]$mq$, 2, $mq$Sucrose is a non-reducing sugar. Acid breaks it into glucose and fructose, which are reducing sugars.$mq$, $mq$medium$mq$),
($mq$100 g of water is heated by burning 0.5 g of a snack and its temperature rises by 20 °C. Using 4.2 J per g per °C, how much energy per gram does the snack release?$mq$, $mq$["8.4 kJ/g","16.8 kJ/g","42 kJ/g","4.2 kJ/g"]$mq$, 1, $mq$Energy = 100 × 4.2 × 20 = 8400 J = 8.4 kJ. Per gram = 8.4 ÷ 0.5 = 16.8 kJ/g.$mq$, $mq$medium$mq$),
($mq$Which pairing of food test and nutrient is INCORRECT?$mq$, $mq$["Benedict's: fat","Biuret: protein","Iodine: starch","Ethanol emulsion test: fat"]$mq$, 0, $mq$Benedict's solution detects reducing sugars, not fat. Fat is tested using the ethanol emulsion test (cloudy white emulsion).$mq$, $mq$medium$mq$),
($mq$A student measures 12 kJ per gram for a nut in a calorimetry experiment, but the label says 25 kJ per gram. What is the most likely reason for the low value?$mq$, $mq$["Water absorbs extra energy","Nuts contain no fat","The thermometer was too accurate","Heat was lost to the surroundings and burning may be incomplete"]$mq$, 3, $mq$In simple calorimetry much of the heat escapes into the air and the flask, so the water gains less energy than the food releases.$mq$, $mq$hard$mq$),
($mq$Per 100 g, food P has 20 g fat, 10 g carbohydrate and 5 g protein. Using 37, 17 and 17 kJ per gram, what is the energy content?$mq$, $mq$["745 kJ","1295 kJ","995 kJ","1500 kJ"]$mq$, 2, $mq$Fat: 20 × 37 = 740. Carbohydrate: 10 × 17 = 170. Protein: 5 × 17 = 85. Total = 995 kJ.$mq$, $mq$hard$mq$),
($mq$Why are unsaturated oils usually liquid at room temperature, while saturated fats are solid?$mq$, $mq$["Unsaturated oils are heavier","C=C bonds put kinks in chains, so molecules pack less closely and have weaker forces","Unsaturated oils contain water","Saturated fats have double bonds"]$mq$, 1, $mq$Kinked chains cannot pack tightly, so less energy is needed to separate the molecules.$mq$, $mq$hard$mq$),
($mq$Which statement correctly describes digestion of protein?$mq$, $mq$["Enzymes add water to break peptide bonds, producing amino acids","Enzymes remove water to form amino acids","Acid turns protein into glucose","Protein is changed into fat"]$mq$, 0, $mq$Digestion is hydrolysis: protease enzymes use water to split peptide bonds into amino acids.$mq$, $mq$hard$mq$),
($mq$Three oils are compared for unsaturation. Equal volumes of oil are shaken with bromine water, added drop by drop until the orange colour stays. Which result shows the MOST unsaturated oil?$mq$, $mq$["The oil needing the fewest drops","The oil with the darkest colour","The oil that floats highest","The oil needing the most drops"]$mq$, 3, $mq$More C=C bonds react with more bromine, so more drops are needed before excess bromine stays orange. The oil volume must be kept equal to keep the test fair.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Food Chemistry: Fats, Sugars and Proteins$mq$ and p.name = $mq$Chemistry in Everyday Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Structure of a fat or oil$mq$, $mq$A triglyceride: one glycerol molecule joined to three fatty acid chains by ester bonds.$mq$),
($mq$Saturated vs unsaturated fat$mq$, $mq$Saturated: only C-C single bonds, usually solid. Unsaturated: at least one C=C bond, usually liquid.$mq$),
($mq$Hydrogenation of oils$mq$, $mq$Hydrogen added to C=C using a nickel catalyst at about 60 °C, giving a firmer, more saturated fat (margarine).$mq$),
($mq$Test for starch$mq$, $mq$Add iodine solution: orange-brown turns blue-black.$mq$),
($mq$Test for reducing sugars$mq$, $mq$Warm with Benedict's solution: blue turns green, yellow, orange then brick-red.$mq$),
($mq$Test for protein$mq$, $mq$Biuret test: sodium hydroxide and copper sulfate turn from blue to purple.$mq$),
($mq$What is a peptide bond?$mq$, $mq$The bond that joins amino acids in a protein, formed by condensation with loss of water.$mq$),
($mq$Energy in food from calorimetry$mq$, $mq$Energy (J) = mass of water × 4.2 × temperature rise. Divide by mass of food for J per g.$mq$),
($mq$Approximate energy values$mq$, $mq$Fat about 37 kJ/g; carbohydrate and protein about 17 kJ/g.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Food Chemistry: Fats, Sugars and Proteins$mq$ and p.name = $mq$Chemistry in Everyday Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Food is a mixture of chemicals, and three big groups provide energy and building material: fats (lipids), carbohydrates such as sugars and starch, and proteins. Understanding their structures explains why foods behave differently and how we can test for them.

## Fats and oils
A fat or oil is a triglyceride: one **glycerol** molecule joined to three **fatty acid** chains by ester links. Fatty acids can be:
- **Saturated**: only single carbon-carbon bonds, so the chains are straight, pack closely and the fat is usually solid at room temperature (butter, lard).
- **Unsaturated**: one or more C=C double bonds. Double bonds put kinks in the chain, so the molecules pack less well and the oil is usually liquid (olive oil, sunflower oil).

Unsaturated oils decolourise bromine water because bromine adds across C=C. The more double bonds, the more bromine is used. In industry, vegetable oils can be hardened by **hydrogenation**: hydrogen is added at about 60 °C with a nickel catalyst, turning C=C into C-C and producing margarine. Fat releases about 37 kJ of energy per gram, more than carbohydrate or protein.

## Carbohydrates
Sugars such as glucose (C₆H₁₂O₆) are small carbohydrates. Starch is a long polymer made of many glucose units. Carbohydrates release about 17 kJ per gram. Two tests are important:
- **Iodine**: orange-brown to blue-black means starch is present.
- **Benedict's**: warm the sample with the blue solution. Reducing sugars such as glucose give green, yellow, orange then brick-red. Sucrose is non-reducing, so it stays blue until it has been broken down by boiling with dilute acid.

## Proteins
Proteins are polymers of amino acids. Each amino acid has an amine group (-NH₂) and a carboxyl group (-COOH). Neighbouring amino acids join by **peptide bonds**, a condensation reaction that releases a water molecule each time. Protein releases about 17 kJ per gram. The **biuret test** (sodium hydroxide plus copper sulfate) turns from blue to purple when protein is present. During digestion, enzymes split peptide bonds using water (hydrolysis) to make amino acids.

## Fat test
Mix the sample with ethanol, then pour into water. A cloudy white emulsion shows fat or oil.

## Energy from food
You can estimate the energy in a food by burning it under a container of water. Energy transferred = mass of water × 4.2 × temperature rise (in J). Example: 100 g of water rises by 20 °C. Energy = 100 × 4.2 × 20 = 8400 J, or 8.4 kJ. If 0.5 g of food was burnt, the energy is 16.8 kJ per gram. Your result is usually lower than data-book values because heat is lost to the air and burning may be incomplete. To improve it, shield the flame, insulate the container and keep the flame close.

## Common mistakes
- Saying unsaturated means "contains no saturated fat". It means C=C bonds are present.
- Mixing up the tests: iodine is for starch, Benedict's for reducing sugars, biuret for protein.
- Forgetting to heat Benedict's solution.

## How this is examined
A typical task describes a student comparing breakfast cereals or oils. You may need to interpret test results, calculate energy values, name control variables, evaluate the accuracy of calorimetry and suggest improvements. Command terms: state, explain, calculate, evaluate.

Exam tip: In experiment questions always name the independent, dependent and control variables, and when a measured energy value is lower than expected, give a specific cause such as heat loss rather than just "human error".$mq$ from st;

-- Mixtures and Materials > Solutions, Suspensions and Emulsions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Mixtures and Materials$mq$, 5, 3 from public.subjects s where s.slug = $mq$chemistry$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Solutions, Suspensions and Emulsions$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$chemistry$mq$ and p.grade = 5 and p.name = $mq$Mixtures and Materials$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Solutions, Suspensions and Emulsions$mq$ and p.name = $mq$Mixtures and Materials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In a solution of sugar in water, which substance is the solute?$mq$, $mq$["Sugar","Water","Both","Neither"]$mq$, 0, $mq$The solute is the substance that dissolves. Water is the solvent.$mq$, $mq$easy$mq$),
($mq$Which of these is a suspension?$mq$, $mq$["Salt dissolved in water","Clean air","Sugar in tea","Muddy water"]$mq$, 3, $mq$Muddy water contains insoluble particles that eventually settle out.$mq$, $mq$easy$mq$),
($mq$Which of these is an emulsion?$mq$, $mq$["Sea water","Pure water","Milk","Brass"]$mq$, 2, $mq$Milk is tiny fat droplets spread through water, so it is an emulsion.$mq$, $mq$easy$mq$),
($mq$A beam of light is shone through a liquid and its path is visible inside the liquid. What does this show?$mq$, $mq$["The liquid is a true solution","The liquid contains particles large enough to scatter light, such as a colloid","The liquid is pure water","The liquid is a metal"]$mq$, 1, $mq$Light scattering (the Tyndall effect) occurs in colloids and suspensions, but not in true solutions.$mq$, $mq$easy$mq$),
($mq$Which statement describes a true solution?$mq$, $mq$["Particles are dissolved evenly and do not settle","Particles settle on standing","Particles are visible","It is always cloudy"]$mq$, 0, $mq$In a solution the solute particles are spread evenly at particle level and do not settle.$mq$, $mq$easy$mq$),
($mq$20 g of salt is dissolved to make 500 cm³ of solution. What is the concentration in g/dm³?$mq$, $mq$["10","20","80","40"]$mq$, 3, $mq$500 cm³ = 0.5 dm³. Concentration = 20 ÷ 0.5 = 40 g/dm³.$mq$, $mq$medium$mq$),
($mq$A mixture of chalk powder and water is left on a bench. The chalk settles, and the mixture can be separated using filter paper. What type of mixture is it?$mq$, $mq$["Solution","Emulsion","Suspension","Alloy"]$mq$, 2, $mq$Insoluble solid particles that settle and can be filtered out make a suspension.$mq$, $mq$medium$mq$),
($mq$What does an emulsifier do?$mq$, $mq$["Dissolves the oil in water","Helps oil and water stay mixed because part of its molecule likes oil and part likes water","Turns water into oil","Makes the mixture warmer"]$mq$, 1, $mq$An emulsifier such as lecithin in egg yolk sits at the surface of droplets and stops them joining together.$mq$, $mq$medium$mq$),
($mq$Salt X solubility (g per 100 g water): 20 °C: 30, 40 °C: 45, 60 °C: 65, 80 °C: 90. What mass of X can dissolve in 50 g of water at 60 °C?$mq$, $mq$["32.5 g","22.5 g","45 g","65 g"]$mq$, 0, $mq$50 g is half of 100 g, so half of 65 g dissolves: 32.5 g.$mq$, $mq$medium$mq$),
($mq$A bottle of fizzy drink is warmed and bubbles escape faster. What is the explanation?$mq$, $mq$["Gases are more soluble in warmer liquids","Warming makes more gas","The bottle gets heavier","Gases are less soluble in warmer liquids"]$mq$, 3, $mq$Solubility of gases decreases with temperature, so carbon dioxide leaves the drink.$mq$, $mq$medium$mq$),
($mq$Which method would recover the solid salt from a salt solution?$mq$, $mq$["Filtration","Sieving","Evaporation or crystallisation","Magnetism"]$mq$, 2, $mq$Dissolved solute passes through filter paper. Evaporating the water leaves the salt behind.$mq$, $mq$medium$mq$),
($mq$Why does milk look cloudy even though it passes through filter paper?$mq$, $mq$["It has large lumps","Tiny droplets scatter light but are small enough to pass through","It contains metals","Milk is a pure substance"]$mq$, 1, $mq$Colloid droplets are too small to be filtered out, but large enough to scatter light.$mq$, $mq$medium$mq$),
($mq$A liquid passes through filter paper, does not settle in a week, and a beam of light is clearly visible going through it. Which description fits best?$mq$, $mq$["Colloid","Suspension","True solution","Pure element"]$mq$, 0, $mq$Not settling and passing the filter rules out a suspension. Scattering the light rules out a true solution, so it is a colloid.$mq$, $mq$medium$mq$),
($mq$Using the solubility data for salt X (80 °C: 90 g per 100 g water; 20 °C: 30 g per 100 g water), what mass of crystals forms when a saturated solution containing 200 g of water at 80 °C is cooled to 20 °C?$mq$, $mq$["60 g","90 g","180 g","120 g"]$mq$, 3, $mq$At 80 °C, 200 g water holds 180 g. At 20 °C it holds 60 g. Crystals = 180 − 60 = 120 g.$mq$, $mq$hard$mq$),
($mq$At 40 °C, 100 g of water can dissolve 45 g of salt X. A solution contains 40 g X in 100 g water at 40 °C. A further 10 g of X is added and stirred. How much stays undissolved?$mq$, $mq$["0 g","10 g","5 g","45 g"]$mq$, 2, $mq$The solution could hold 5 g more. Total 50 g added, 45 g dissolves, so 5 g stays undissolved.$mq$, $mq$hard$mq$),
($mq$Butter is a water-in-oil emulsion. Which description is correct?$mq$, $mq$["Water forms the continuous phase with oil droplets inside","Oil forms the continuous phase with water droplets inside","It has no continuous phase","It is a true solution"]$mq$, 1, $mq$In water-in-oil emulsions the water droplets are spread through oil. Mayonnaise is the opposite, oil-in-water.$mq$, $mq$hard$mq$),
($mq$A student wants to prove that a liquid is a true solution. Which results would support this?$mq$, $mq$["It passes through filter paper, does not settle, and does not scatter a light beam","It does not pass through filter paper","It settles in an hour","It scatters light strongly"]$mq$, 0, $mq$All three tests together show particles are dissolved. Any one test alone is not enough to be sure.$mq$, $mq$hard$mq$),
($mq$2.5 g of a solute dissolves in 250 cm³ of solution. What mass of solute is needed for 750 cm³ of solution with the same concentration?$mq$, $mq$["2.5 g","5.0 g","10 g","7.5 g"]$mq$, 3, $mq$Concentration = 2.5 ÷ 0.25 = 10 g/dm³. For 0.75 dm³ you need 10 × 0.75 = 7.5 g.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Solutions, Suspensions and Emulsions$mq$ and p.name = $mq$Mixtures and Materials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Solute, solvent, solution$mq$, $mq$Solute dissolves in the solvent; together they make a solution.$mq$),
($mq$Suspension$mq$, $mq$Insoluble particles spread through a liquid. It looks cloudy, settles and can be filtered.$mq$),
($mq$Colloid$mq$, $mq$Small particles that do not settle or filter out, but scatter light (Tyndall effect).$mq$),
($mq$Emulsion$mq$, $mq$A colloid of tiny droplets of one liquid in another liquid they do not mix with, e.g. milk.$mq$),
($mq$Emulsifier$mq$, $mq$A substance with a water-loving and an oil-loving part that keeps droplets from joining, e.g. lecithin.$mq$),
($mq$Concentration formula$mq$, $mq$Concentration (g/dm³) = mass of solute (g) ÷ volume of solution (dm³).$mq$),
($mq$Solubility$mq$, $mq$The maximum mass of solute that dissolves in 100 g of water at a given temperature.$mq$),
($mq$Effect of temperature on solubility$mq$, $mq$Solids: usually more soluble when hotter. Gases: less soluble when hotter.$mq$),
($mq$Saturated solution$mq$, $mq$A solution that already holds the maximum solute at that temperature; any extra stays undissolved.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Solutions, Suspensions and Emulsions$mq$ and p.name = $mq$Mixtures and Materials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Mixtures are made of two or more substances that are not chemically joined, and the way the particles are spread out decides what we call the mixture. At MYP 5 you need to tell solutions, suspensions, colloids and emulsions apart, calculate concentration and interpret solubility data.

## Solutions
A **solution** forms when a **solute** dissolves in a **solvent**. In a sugar solution the sugar is the solute and the water is the solvent. The solute particles are mixed in at particle level, so the mixture is clear (it may be coloured), the particles never settle, they pass through filter paper and they do not scatter light.

## Suspensions
A **suspension** contains larger insoluble particles spread through a liquid, such as chalk in water or muddy water. It looks cloudy, the particles slowly settle, they can be removed using filter paper, and the mixture scatters light.

## Colloids and emulsions
In a **colloid** the particles are between the two sizes. They do not settle and pass through filter paper, but they are large enough to scatter a beam of light (the Tyndall effect). An **emulsion** is a colloid of one liquid spread as tiny droplets in another liquid that it does not mix with, such as milk or mayonnaise (oil droplets in water) or butter (water droplets in oil). Emulsions need an **emulsifier**, a substance with one end that likes water and one end that likes oil. It surrounds the droplets and stops them joining back together. Egg yolk contains lecithin, which is why it is used in mayonnaise.

## Summary of tests
- Does it settle? Suspension yes, colloid and solution no.
- Does it pass through filter paper? Suspension no, colloid and solution yes.
- Does it scatter light? Suspension and colloid yes, solution no.

## Concentration
Concentration in g/dm³ = mass of solute (g) ÷ volume of solution (dm³). Remember 1 dm³ = 1000 cm³. Worked example: 20 g of salt in 500 cm³ gives 20 ÷ 0.5 = 40 g/dm³.

## Solubility
Solubility is the maximum mass of solute that dissolves in 100 g of water at a certain temperature. A **saturated** solution holds that maximum. For most solids, solubility increases as the temperature rises. For gases it decreases, which is why a warm fizzy drink loses its fizz. Solubility curves can be used to predict how much solid crystallises on cooling.

Worked example: solubility of salt X is 90 g per 100 g water at 80 °C and 30 g per 100 g at 20 °C. A saturated solution with 200 g of water at 80 °C holds 180 g. At 20 °C it holds only 60 g, so 120 g of crystals appear.

## Common mistakes
- Forgetting to convert cm³ into dm³ before calculating concentration.
- Saying that a colloid will settle if left long enough. It does not.
- Using the total mass of solution instead of the mass of water when reading solubility data.

## How this is examined
Tasks often describe a food or cosmetics company testing a product, or a lab investigation with data. You may classify a mixture from test results, calculate concentration or crystals formed, and evaluate whether the test is fair and the conclusion justified.

Exam tip: When classifying a mixture use at least two observations, such as filtering and shining a light through it, and name the observation that rules out each of the other types.$mq$ from st;

-- Mixtures and Materials > Alloys and Properties of Metals
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Mixtures and Materials$mq$, 5, 3 from public.subjects s where s.slug = $mq$chemistry$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Alloys and Properties of Metals$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$chemistry$mq$ and p.grade = 5 and p.name = $mq$Mixtures and Materials$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Alloys and Properties of Metals$mq$ and p.name = $mq$Mixtures and Materials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is an alloy?$mq$, $mq$["A mixture of a metal with at least one other element","A compound of two metals","A pure metal","A non-metal"]$mq$, 0, $mq$Alloys are mixtures, usually of metals, made to improve properties.$mq$, $mq$easy$mq$),
($mq$Brass is an alloy of which two metals?$mq$, $mq$["Copper and tin","Iron and carbon","Aluminium and iron","Copper and zinc"]$mq$, 3, $mq$Brass is copper and zinc. Bronze is copper and tin.$mq$, $mq$easy$mq$),
($mq$Why can metals conduct electricity?$mq$, $mq$["They contain ions that cannot move","They contain neutrons that carry charge","They contain delocalised electrons that move","They contain molecules"]$mq$, 2, $mq$Metals have a lattice of positive ions in a sea of delocalised electrons that carry charge.$mq$, $mq$easy$mq$),
($mq$Steel is mainly iron mixed with a small amount of which element?$mq$, $mq$["Chlorine","Carbon","Hydrogen","Helium"]$mq$, 1, $mq$Steel is an alloy of iron and a small percentage of carbon.$mq$, $mq$easy$mq$),
($mq$What does the term malleable mean?$mq$, $mq$["Can be hammered into shape","Can be stretched into wires","Shiny","Breaks easily"]$mq$, 0, $mq$Malleable means it can be hammered or bent without shattering. Ductile means it can be drawn into wires.$mq$, $mq$easy$mq$),
($mq$Why is an alloy usually harder than the pure metal it is made from?$mq$, $mq$["Alloys contain more electrons","Alloys have no bonds","Alloy atoms are the same size","Atoms of different sizes disrupt the layers so they cannot slide easily"]$mq$, 3, $mq$In a pure metal, layers of same-size atoms slide easily. Different-sized atoms in an alloy block the layers.$mq$, $mq$medium$mq$),
($mq$What percentage of 18-carat gold is pure gold? (24 carat is pure gold)$mq$, $mq$["18%","50%","75%","90%"]$mq$, 2, $mq$18 ÷ 24 = 0.75, so 75% gold.$mq$, $mq$medium$mq$),
($mq$Why is pure copper used for electrical wires?$mq$, $mq$["It is a poor conductor but cheap","It is a good conductor and can be drawn into wires","It is brittle","It is magnetic"]$mq$, 1, $mq$Copper is an excellent conductor and ductile, so it is easily made into wires.$mq$, $mq$medium$mq$),
($mq$Why are aluminium alloys used to build aircraft?$mq$, $mq$["Low density and strong","High density and strong","Easy to melt and weak","Magnetic and heavy"]$mq$, 0, $mq$Aircraft need light but strong materials, which aluminium alloys provide.$mq$, $mq$medium$mq$),
($mq$What is the main advantage of stainless steel for cutlery?$mq$, $mq$["It is a poor conductor of heat","It is a liquid","It is soft","It resists rusting"]$mq$, 3, $mq$Chromium in stainless steel forms a protective layer, so it does not rust easily.$mq$, $mq$medium$mq$),
($mq$Which of these is NOT an alloy?$mq$, $mq$["Bronze","Solder","Pure copper","Stainless steel"]$mq$, 2, $mq$Pure copper is a single element. The others are mixtures.$mq$, $mq$medium$mq$),
($mq$A 12 g ring is made from 9-carat gold. What mass of gold does it contain? (24 carat is pure gold)$mq$, $mq$["3.0 g","4.5 g","6.0 g","9.0 g"]$mq$, 1, $mq$9 ÷ 24 = 0.375. Gold = 0.375 × 12 = 4.5 g.$mq$, $mq$medium$mq$),
($mq$Hardness (arbitrary units) of iron: pure iron 4; iron with 0.2% carbon 6; iron with 0.8% carbon 8. What does the data suggest?$mq$, $mq$["Adding carbon makes iron harder","Adding carbon makes iron softer","Carbon has no effect","Pure iron is hardest"]$mq$, 0, $mq$Hardness rises as carbon increases from 0 to 0.8%.$mq$, $mq$medium$mq$),
($mq$Pure copper conducts electricity better than brass. What is the best reason?$mq$, $mq$["Brass has no electrons","Copper has no ions","Brass is a compound","Zinc atoms disturb the flow of delocalised electrons"]$mq$, 3, $mq$The different atoms in brass scatter the moving electrons and reduce conductivity.$mq$, $mq$hard$mq$),
($mq$An engineer needs a material for a ship's propeller that is strong, hard-wearing and resists corrosion in seawater. Which is the best choice?$mq$, $mq$["Pure copper","Pure tin","Bronze","Mild steel"]$mq$, 2, $mq$Bronze is stronger and harder than copper and resists corrosion. Mild steel rusts and pure copper and tin are too soft.$mq$, $mq$hard$mq$),
($mq$250 g of brass is 70% copper by mass. How much zinc does it contain?$mq$, $mq$["30 g","75 g","175 g","250 g"]$mq$, 1, $mq$Copper = 0.70 × 250 = 175 g. Zinc = 250 − 175 = 75 g.$mq$, $mq$hard$mq$),
($mq$A student says that brass is a compound because it contains two elements. Which response is correct?$mq$, $mq$["Brass is a mixture because the metals are not chemically bonded in fixed proportions","Brass is a compound because it has two elements","Brass is an element","Brass is a gas"]$mq$, 0, $mq$Alloys are mixtures: the proportions can vary and no new chemical compound forms.$mq$, $mq$hard$mq$),
($mq$Pure tin melts at 232 °C. A lead-tin solder melts at about 183 °C. Why is the alloy useful for joining electronic parts?$mq$, $mq$["Higher melting point makes the joint stronger","It is a gas","It is magnetic","Lower melting point means less risk of heat damage to components"]$mq$, 3, $mq$The alloy melts at a lower temperature than pure tin, so components are not damaged during soldering.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Alloys and Properties of Metals$mq$ and p.name = $mq$Mixtures and Materials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Metallic bonding$mq$, $mq$A lattice of positive metal ions surrounded by a sea of delocalised electrons.$mq$),
($mq$Why metals conduct electricity$mq$, $mq$Delocalised electrons are free to move and carry charge through the metal.$mq$),
($mq$Malleable vs ductile$mq$, $mq$Malleable: can be hammered into shape. Ductile: can be drawn out into wires.$mq$),
($mq$What is an alloy?$mq$, $mq$A mixture of a metal with at least one other element, made to improve properties.$mq$),
($mq$Why are alloys harder than pure metals?$mq$, $mq$Atoms of different sizes distort the layers, so they cannot slide over each other easily.$mq$),
($mq$Brass and bronze$mq$, $mq$Brass is copper and zinc. Bronze is copper and tin.$mq$),
($mq$Steel and stainless steel$mq$, $mq$Steel: iron with a little carbon. Stainless steel: iron with chromium and nickel, resists rusting.$mq$),
($mq$Carat of gold$mq$, $mq$24 carat is pure gold. 18 carat is 18/24 = 75% gold.$mq$),
($mq$Why use pure copper for wires?$mq$, $mq$It is an excellent conductor and ductile. Alloys usually conduct less well.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Alloys and Properties of Metals$mq$ and p.name = $mq$Mixtures and Materials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Metals are used in almost everything from phones to bridges. To choose the right metal for a job you need to know how metals are built, why they have their properties, and how mixing them into alloys can improve them.

## Metallic bonding
A metal is a regular lattice of positive ions surrounded by a sea of **delocalised electrons**. These free electrons are shared between all the ions and hold the structure together. This explains the common properties:
- **Good electrical conductivity**: the delocalised electrons carry charge through the metal.
- **Good thermal conductivity**: the electrons quickly pass on energy.
- **High melting points**: a lot of energy is needed to overcome the strong attraction between ions and electrons.
- **Malleable and ductile**: layers of ions can slide over each other, but the electrons keep holding them together, so the metal bends instead of shattering.
- **Shiny when polished** and **sonorous** (rings when hit).

## Why pure metals are often too soft
In a pure metal, all the atoms are the same size, so the layers slide easily. Pure iron, copper, gold and aluminium are soft and bend easily, which is not ideal for tools or buildings.

## Alloys
An **alloy** is a mixture of a metal with at least one other element, usually another metal. The atoms of the added element are a different size. They distort the regular layers and stop them sliding, so alloys are usually **harder and stronger** than the pure metal. Alloys are made by mixing the molten metals and letting them cool. They are mixtures, not compounds, because no chemical reaction occurs and the proportions can vary.

Common alloys:
- **Brass**: copper and zinc. Used in taps and musical instruments.
- **Bronze**: copper and tin. Hard-wearing, used for statues and ship propellers.
- **Steel**: iron with a small amount of carbon. Strong, used for construction.
- **Stainless steel**: iron, chromium and nickel. Resists rust, used for cutlery and sinks.
- **Solder**: tin-based alloy with a low melting point, used to join electronic parts.
- **Aluminium alloys**: low density and strong, used for aircraft.
- **Gold alloys**: pure gold is 24 carat. 18 carat gold is 18 out of 24 parts gold, or 75%.

Trade-off: alloys are usually less good at conducting electricity than the pure metal because the different atoms disturb the flow of electrons. That is why pure copper is used for electrical wires.

## Calculations
Worked example: a 12 g ring is 9 carat. Fraction of gold = 9 ÷ 24 = 0.375. Mass of gold = 0.375 × 12 = 4.5 g.
Worked example: 250 g of brass is 70% copper. Copper = 175 g, so zinc = 75 g.

## Choosing materials
Real design decisions weigh several properties: strength, density, resistance to corrosion, conductivity, cost and availability. For a bridge you need strength and low cost, so steel is common. For an aircraft you need low density as well, so aluminium alloys are used. State the property needed, then match it to the material.

## Common mistakes
- Calling an alloy a compound.
- Saying alloys are harder because their bonds are stronger. The reason is that layers cannot slide.
- Forgetting that pure metals are good conductors but alloys are usually worse.

## How this is examined
Questions give a scenario, such as selecting a metal for a bike frame or a coin, with a data table of properties. You are asked to compare, explain using particle structure, calculate the composition of an alloy and justify a choice.

Exam tip: When explaining why an alloy is harder, mention that the atoms are different sizes, the layers are distorted and they cannot slide over each other easily.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('chemistry')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;