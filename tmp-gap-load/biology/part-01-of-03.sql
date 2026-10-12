-- Part 1 of 3: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Biological Molecules > Carbohydrates, Proteins and Lipids
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Biological Molecules$mq$, 5, 1 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Carbohydrates, Proteins and Lipids$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 5 and p.name = $mq$Biological Molecules$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Carbohydrates, Proteins and Lipids$mq$ and p.name = $mq$Biological Molecules$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which elements are found in ALL carbohydrates?$mq$, $mq$["Carbon, hydrogen and oxygen","Carbon, hydrogen and nitrogen","Carbon and oxygen only","Carbon, oxygen and sulfur"]$mq$, 0, $mq$Carbohydrates contain carbon, hydrogen and oxygen only. Nitrogen is the extra element that makes proteins different.$mq$, $mq$easy$mq$),
($mq$Which of these is the monomer (building block) of a protein?$mq$, $mq$["Glucose","Fatty acid","Glycerol","Amino acid"]$mq$, 3, $mq$Proteins are long chains of amino acids. Glucose builds carbohydrates, while fatty acids and glycerol build lipids.$mq$, $mq$easy$mq$),
($mq$A lipid molecule such as a fat is made from which two types of smaller molecule?$mq$, $mq$["Glucose and amino acids","Starch and cellulose","Glycerol and fatty acids","Amino acids and glycerol"]$mq$, 2, $mq$One glycerol molecule joins to three fatty acid molecules to make a triglyceride (a fat or oil).$mq$, $mq$easy$mq$),
($mq$Which of these is a carbohydrate used by plants as a long-term energy store?$mq$, $mq$["Glycogen","Starch","Cellulose","Keratin"]$mq$, 1, $mq$Plants store energy as starch. Glycogen is the animal store, cellulose is a structural carbohydrate in cell walls, and keratin is a protein.$mq$, $mq$easy$mq$),
($mq$Which of these foods is the best source of protein for growth and repair?$mq$, $mq$["Eggs","Rice","Butter","Sugar"]$mq$, 0, $mq$Eggs are rich in protein. Rice is mainly starch, butter is mainly fat and sugar is a simple carbohydrate.$mq$, $mq$easy$mq$),
($mq$A student describes starch as 'a polysaccharide'. What does this mean?$mq$, $mq$["It is made of two sugar units joined together","It contains many different amino acids","It is made of one sugar unit only","It is made of many glucose units joined together"]$mq$, 3, $mq$'Poly' means many. A polysaccharide is a long chain of sugar (glucose) units. A disaccharide has two units and a monosaccharide has one.$mq$, $mq$medium$mq$),
($mq$Sucrose is formed when glucose joins with fructose. How should sucrose be classified?$mq$, $mq$["Monosaccharide","Polysaccharide","Disaccharide","Triglyceride"]$mq$, 2, $mq$Two simple sugar units joined together make a disaccharide. Maltose (two glucose units) and lactose are other examples.$mq$, $mq$medium$mq$),
($mq$Gill is explaining why athletes store glycogen in their muscles and liver. Which statement best describes glycogen?$mq$, $mq$["A protein that builds muscle fibres","A branched carbohydrate that is a store of glucose in animals","A lipid that insulates the body","A sugar that is transported in the blood plasma"]$mq$, 1, $mq$Glycogen is a polysaccharide made of glucose units, stored mainly in the liver and muscles, and broken down when glucose is needed.$mq$, $mq$medium$mq$),
($mq$A protein is heated to 80°C and its enzyme activity is lost permanently. What is the best explanation?$mq$, $mq$["The protein's 3D shape has been changed (denatured)","The peptide bonds between amino acids turn into fats","The amino acids have turned into glucose","The protein has been digested by the heat"]$mq$, 0, $mq$High temperature breaks the bonds that hold the folded protein in shape. The active site changes shape so the substrate no longer fits. This is denaturation.$mq$, $mq$medium$mq$),
($mq$Which statement correctly compares fats with carbohydrates as energy sources?$mq$, $mq$["Fats release less energy per gram than carbohydrates","Fats and carbohydrates release exactly the same energy per gram","Fats cannot be used for energy at all","Fats release more than twice as much energy per gram as carbohydrates"]$mq$, 3, $mq$Fats contain more energy per gram (about 37 kJ/g compared with about 17 kJ/g for carbohydrate), which is why they make a compact long-term energy store.$mq$, $mq$medium$mq$),
($mq$Arctic seals have a thick layer of blubber under the skin. Which two roles of lipids does this show?$mq$, $mq$["Transport and enzyme action","Growth and repair of muscle","Insulation and energy storage","Protection against disease only"]$mq$, 2, $mq$Fat under the skin reduces heat loss (insulation) and stores energy that can be used when food is scarce.$mq$, $mq$medium$mq$),
($mq$A scientist analyses a molecule and finds it contains carbon, hydrogen, oxygen and nitrogen. Which type of molecule is it most likely to be?$mq$, $mq$["Carbohydrate","Protein","Lipid","Starch"]$mq$, 1, $mq$Only proteins (of these choices) contain nitrogen, because amino acids have an amine group. Carbohydrates and lipids contain just C, H and O.$mq$, $mq$medium$mq$),
($mq$Cellulose and starch are both made of glucose, yet cellulose is not digested by humans. A suitable reason that links structure to function is that cellulose:$mq$, $mq$["has glucose units joined in a way human enzymes cannot break, forming strong fibres in plant cell walls","is a protein, so it is too large to digest","contains nitrogen, which humans cannot absorb","is a lipid that dissolves in water"]$mq$, 0, $mq$Cellulose's glucose units are linked differently from starch, so human amylase cannot break it down. Its long fibres give plant cell walls strength. It still acts as dietary fibre.$mq$, $mq$medium$mq$),
($mq$A short chain has 20 amino acids joined by peptide bonds. A second chain contains the same 20 amino acids in a different order. Why might the two chains behave differently?$mq$, $mq$["Both chains must have identical shape because they contain the same amino acids","Peptide bonds only form in one order","Amino acids change into fatty acids if their order changes","The order of amino acids determines how the chain folds, so shape and function can differ"]$mq$, 3, $mq$The sequence of amino acids controls the folding and final 3D shape, which determines function. Changing the order can create a different protein.$mq$, $mq$hard$mq$),
($mq$An experiment compares energy released when 1 g of two foods is burned to heat water. Food X raised 50 g of water by 20°C and Food Y raised 50 g of water by 9°C. Which conclusion is best supported?$mq$, $mq$["Food Y must be a protein","Both foods contain the same energy","Food X contains more energy per gram, so it could be rich in fat","Food X must be a carbohydrate"]$mq$, 2, $mq$A bigger temperature rise means more energy was transferred, so X has more energy per gram. High energy content is consistent with fat, but the data alone cannot prove the type. Food Y cannot be assumed to be a protein.$mq$, $mq$hard$mq$),
($mq$Why can a protein's function be lost even if all its peptide bonds remain intact after being placed in strong acid?$mq$, $mq$["Strong acid turns the protein into a carbohydrate","Acid disrupts the bonds holding the folded shape, so the active site no longer works","Acid adds extra amino acids to the chain","Acid always digests proteins into glucose"]$mq$, 1, $mq$Extreme pH disrupts the weaker bonds that maintain the 3D shape. The sequence is unchanged but the shape, and so the function, is lost.$mq$, $mq$hard$mq$),
($mq$A student claims 'glucose, starch and glycogen are the same molecule because all contain only glucose units'. Which response best evaluates this claim?$mq$, $mq$["Incorrect, because glucose is a single unit while starch and glycogen are large polymers with different structures and roles","Correct, because the elements present are identical so the molecules behave identically","Incorrect, because glycogen is a protein","Correct, because all carbohydrates are monosaccharides"]$mq$, 0, $mq$Glucose is a monosaccharide. Starch (plants) and glycogen (animals) are polysaccharides of glucose with different arrangements and roles. Being made of the same units does not make them the same molecule.$mq$, $mq$hard$mq$),
($mq$Why is glycogen or starch a better storage molecule than many separate glucose molecules in a cell?$mq$, $mq$["It contains more nitrogen than glucose","It dissolves quickly and moves out of the cell","It is a lipid, so it provides insulation","It is a large, compact molecule that does not dissolve easily, so it does not affect water movement in the cell"]$mq$, 3, $mq$Large polymers have little effect on the concentration of solutes in the cell, so water does not move in by osmosis. They can also be packed compactly and broken back to glucose when required.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Carbohydrates, Proteins and Lipids$mq$ and p.name = $mq$Biological Molecules$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Elements in carbohydrates$mq$, $mq$Carbon, hydrogen and oxygen only.$mq$),
($mq$Element that proteins contain but carbohydrates and lipids do not$mq$, $mq$Nitrogen (amino acids have an amine group).$mq$),
($mq$Monomer of a protein$mq$, $mq$Amino acid. Joined by peptide bonds into long chains.$mq$),
($mq$Building blocks of a fat (triglyceride)$mq$, $mq$One glycerol molecule and three fatty acid molecules.$mq$),
($mq$Starch vs glycogen$mq$, $mq$Both are glucose polysaccharide stores. Starch is the store in plants; glycogen is the store in animals (liver and muscles).$mq$),
($mq$Role of cellulose$mq$, $mq$Structural polysaccharide of glucose that forms strong fibres in plant cell walls. Humans cannot digest it (dietary fibre).$mq$),
($mq$Denaturation$mq$, $mq$Loss of a protein's 3D shape (caused by high temperature or extreme pH), so it can no longer do its job. Usually permanent.$mq$),
($mq$Examples of disaccharides$mq$, $mq$Sucrose (glucose + fructose) and maltose (glucose + glucose).$mq$),
($mq$Main functions of lipids$mq$, $mq$Energy store (over twice as much energy per gram as carbohydrate), insulation, protection of organs and part of cell membranes.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Carbohydrates, Proteins and Lipids$mq$ and p.name = $mq$Biological Molecules$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Living things are built from a small set of large molecules. Three of the most important are carbohydrates, proteins and lipids. Knowing what each is made from, and what each does, is core MYP 5 Biology.

## Carbohydrates
Carbohydrates contain the elements **carbon, hydrogen and oxygen**. They are built from sugar units.
- **Monosaccharides** are single sugar units, for example glucose and fructose.
- **Disaccharides** are two sugar units joined, for example sucrose (glucose + fructose) and maltose (glucose + glucose).
- **Polysaccharides** are long chains of glucose units. Starch is the energy store in plants, glycogen is the energy store in animals (found in the liver and muscles) and cellulose forms strong fibres in plant cell walls.
Glucose is the main fuel for respiration. Large polysaccharides make good stores because they are compact and do not dissolve easily, so they do not upset the water balance of the cell.

## Proteins
Proteins contain carbon, hydrogen, oxygen and **nitrogen** (sometimes sulfur too). They are long chains of **amino acids** joined by peptide bonds. There are about 20 different amino acids, and the order of the amino acids decides how the chain folds into a specific 3D shape. That shape decides the function.
- Enzymes speed up reactions.
- Antibodies fight pathogens.
- Haemoglobin carries oxygen.
- Keratin and collagen give structure to hair, skin and tissues.
If the shape is damaged by high temperature or extreme pH, the protein is **denatured** and stops working. This is permanent for most enzymes.

## Lipids
Lipids (fats and oils) contain carbon, hydrogen and oxygen, but far less oxygen than carbohydrates. A fat molecule is made of one **glycerol** and three **fatty acids**. Lipids:
- store energy (more than twice as much per gram as carbohydrate)
- insulate the body and protect organs
- form part of every cell membrane.

## Worked example
Question: A food label shows it contains nitrogen. Which molecule type is present? Answer: protein, because only proteins of the three groups contain nitrogen.

## Common mistakes
- Saying enzymes are 'killed' by heat. They are not alive, so say 'denatured'.
- Mixing up glycogen (animals) and starch (plants).
- Forgetting that cellulose is made of glucose but is not digested by humans.
- Saying fats are 'bad'. They are essential in the right amounts.

## How this is examined
Questions usually give a short context, such as an athlete's diet or a lab experiment on denaturing, and ask you to identify the molecule, link its structure to its function, interpret data (for example energy released from burning foods) or evaluate a claim. Command terms such as state, describe, explain and evaluate decide how much detail is needed. Use precise words like 'amino acids', 'glycerol', 'denatured' and 'polysaccharide'.

Exam tip: When asked to explain a function, link structure to function in one sentence, for example 'glycogen is a large, compact polymer of glucose, so it stores energy without affecting osmosis'.$mq$ from st;

-- Biological Molecules > Food Tests and Balanced Diets
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Biological Molecules$mq$, 5, 1 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Food Tests and Balanced Diets$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 5 and p.name = $mq$Biological Molecules$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Food Tests and Balanced Diets$mq$ and p.name = $mq$Biological Molecules$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which reagent is used to test a food sample for starch?$mq$, $mq$["Iodine solution","Benedict's solution","Biuret reagent","Ethanol"]$mq$, 0, $mq$Iodine solution turns from orange-brown to blue-black when starch is present.$mq$, $mq$easy$mq$),
($mq$A food sample is tested with Benedict's solution and heated in a water bath. It turns brick-red. What does this show?$mq$, $mq$["Starch is present","Protein is present","Fat is present","Reducing sugar is present"]$mq$, 3, $mq$Benedict's solution changes from blue to green, yellow, orange and brick-red when reducing sugars such as glucose are present and heated.$mq$, $mq$easy$mq$),
($mq$Which test result shows protein is present?$mq$, $mq$["Iodine turns blue-black","Benedict's solution turns brick-red","Biuret reagent turns from blue to purple","A clear emulsion forms"]$mq$, 2, $mq$The Biuret test gives a blue to purple (lilac) colour change when protein is present.$mq$, $mq$easy$mq$),
($mq$In the ethanol emulsion test for lipids, what is seen if a lipid is present?$mq$, $mq$["A blue-black colour","A white cloudy emulsion","A purple colour","A brick-red precipitate"]$mq$, 1, $mq$The sample is mixed with ethanol and then water. Lipid is insoluble in water, so it forms a cloudy white emulsion.$mq$, $mq$easy$mq$),
($mq$Which nutrient group is needed mainly for growth and repair?$mq$, $mq$["Protein","Fibre","Carbohydrate","Water only"]$mq$, 0, $mq$Protein supplies the amino acids for growth and repair of tissues.$mq$, $mq$easy$mq$),
($mq$Tom heats a food with Benedict's solution and the mixture stays blue. Which conclusion is correct?$mq$, $mq$["The food contains starch","The food contains protein","The food contains lipid","No reducing sugar is detected"]$mq$, 3, $mq$Blue means no reducing sugar was detected. The test says nothing about starch, protein or lipid.$mq$, $mq$medium$mq$),
($mq$A student tests a food with both iodine and Benedict's solution. Iodine turns blue-black and Benedict's stays blue. What does this show?$mq$, $mq$["Reducing sugar is present but no starch","Both starch and reducing sugar are present","Starch is present but no reducing sugar","Neither is present"]$mq$, 2, $mq$Blue-black with iodine means starch is present. Benedict's staying blue means no reducing sugar was detected.$mq$, $mq$medium$mq$),
($mq$Why must the sample be heated in a water bath when carrying out the Benedict's test?$mq$, $mq$["Heat turns starch into protein","The reaction needs heat to take place","Heat makes the solution blue","Heat removes the lipid"]$mq$, 1, $mq$The reaction between Benedict's solution and reducing sugars happens when heated (about 80°C or above). A water bath is safer than heating directly with a flame.$mq$, $mq$medium$mq$),
($mq$Which safety precaution is most appropriate for the Benedict's test?$mq$, $mq$["Wear eye protection and use a water bath, not a flame","Smell the solution directly","Use a naked flame under a closed test tube","Taste the solution to check for sugar"]$mq$, 0, $mq$Hot liquids and chemicals can harm the eyes. Never taste lab materials, and avoid heating test tubes with a naked flame when a water bath is suitable.$mq$, $mq$medium$mq$),
($mq$Which diet is best described as balanced?$mq$, $mq$["One that contains only protein","One that excludes all fat","One that contains as many calories as possible","One that contains the right proportions of carbohydrates, proteins, lipids, vitamins, minerals, fibre and water"]$mq$, 3, $mq$A balanced diet contains all the nutrient groups in suitable amounts for the person's age, size and activity level.$mq$, $mq$medium$mq$),
($mq$Which deficiency disease is correctly matched with its cause?$mq$, $mq$["Rickets: lack of vitamin C","Anaemia: lack of calcium","Scurvy: lack of vitamin C","Scurvy: lack of iron"]$mq$, 2, $mq$Scurvy is caused by a lack of vitamin C. Rickets is linked to lack of vitamin D (or calcium) and anaemia to lack of iron.$mq$, $mq$medium$mq$),
($mq$Why is dietary fibre important even though humans cannot digest it?$mq$, $mq$["It provides most of the body's energy","It adds bulk to food so the gut muscles can push it along","It forms new proteins","It stores vitamins"]$mq$, 1, $mq$Fibre (mainly cellulose) adds bulk and helps peristalsis move food through the gut, which prevents constipation.$mq$, $mq$medium$mq$),
($mq$A pregnant woman, a teenage athlete and an office worker have different dietary needs. Which factor best explains this?$mq$, $mq$["Age, activity level and life stage change the energy and nutrients required","Everyone needs the same diet","Only body colour matters","Only the time of day matters"]$mq$, 0, $mq$Energy and nutrient needs depend on age, size, sex, activity and conditions such as pregnancy. Athletes need more energy and teenagers need extra protein and calcium for growth.$mq$, $mq$medium$mq$),
($mq$A student wants to test whether a milk sample contains both protein and lipid. Which pair of tests is correct?$mq$, $mq$["Iodine test for protein and Benedict's test for lipid","Benedict's test for protein and Biuret for lipid","Ethanol test for protein and iodine for lipid","Biuret test for protein and ethanol emulsion test for lipid"]$mq$, 3, $mq$Biuret detects protein and the ethanol emulsion test detects lipid. Iodine is for starch and Benedict's is for reducing sugar.$mq$, $mq$hard$mq$),
($mq$A student tests four foods with Benedict's solution and reports results as 'a bit orange' and 'a bit more orange'. Which improvement makes the results more reliable and comparable?$mq$, $mq$["Use different volumes each time","Taste the samples to confirm","Use the same volume of food and reagent, heat for the same time, and compare against a colour chart","Heat each sample for as long as desired"]$mq$, 2, $mq$Controlling variables (volumes, time, temperature) and using a standard colour scale makes the semi-quantitative results fairer and repeatable.$mq$, $mq$hard$mq$),
($mq$A student tests a clear, colourless drink with iodine, Benedict's and Biuret. Only Benedict's gives a brick-red colour. A friend says: 'The drink contains sucrose.' Which evaluation is best?$mq$, $mq$["Fully supported; all sugars give a brick-red colour","Not supported; the test shows reducing sugar such as glucose. Sucrose is a non-reducing sugar, so it would not give this result unless broken down first","Supported, because sucrose is a protein","Not supported, because brick-red means starch"]$mq$, 1, $mq$Benedict's detects reducing sugars (glucose, maltose). Sucrose does not react until boiled with dilute acid, so the result points to a reducing sugar, not sucrose.$mq$, $mq$hard$mq$),
($mq$A teenager eats a diet that contains plenty of energy but almost no fruit or vegetables. After months the gums bleed and wounds heal slowly. Which is the best explanation?$mq$, $mq$["A deficiency of vitamin C, found in fresh fruit and vegetables","A deficiency of iron only","Too much dietary fibre","Too much water"]$mq$, 0, $mq$Bleeding gums and slow healing are signs of scurvy, caused by lack of vitamin C. Energy intake can be high while a nutrient is still missing, so the diet is not balanced.$mq$, $mq$hard$mq$),
($mq$A population study found that people eating a diet very high in saturated fat and low in fibre had higher rates of heart disease. Which statement is the most reasonable evaluation?$mq$, $mq$["The study proves that fat is the only cause of heart disease","The study shows fibre cures heart disease","The study has no value because it is about people","The data show a link, but other factors such as exercise and smoking may also contribute, so the diet is not proven to be the only cause"]$mq$, 3, $mq$Correlation does not prove sole causation. A good evaluation notes a link and acknowledges confounding factors such as exercise, smoking and genetics.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Food Tests and Balanced Diets$mq$ and p.name = $mq$Biological Molecules$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Test for starch$mq$, $mq$Add iodine solution. Orange-brown turns blue-black if starch is present.$mq$),
($mq$Test for reducing sugar$mq$, $mq$Benedict's solution, heated in a water bath. Blue turns green, yellow, orange, then brick-red as sugar increases.$mq$),
($mq$Test for protein$mq$, $mq$Biuret reagent. Blue turns purple (lilac) if protein is present.$mq$),
($mq$Test for lipid$mq$, $mq$Ethanol emulsion test: shake with ethanol, pour into water. A cloudy white emulsion shows lipid.$mq$),
($mq$Why use a water bath for Benedict's test?$mq$, $mq$Gives steady, safe heating at about 80°C without a naked flame.$mq$),
($mq$Why does sucrose not react with Benedict's?$mq$, $mq$It is a non-reducing sugar. It only gives a positive result after boiling with dilute acid.$mq$),
($mq$Scurvy$mq$, $mq$Deficiency disease caused by lack of vitamin C. Signs include bleeding gums and slow wound healing.$mq$),
($mq$Role of dietary fibre$mq$, $mq$Adds bulk so the gut muscles can move food along (peristalsis) and prevents constipation. It is not digested.$mq$),
($mq$Anaemia$mq$, $mq$Caused by lack of iron, which is needed to make haemoglobin. Leads to tiredness and pale skin.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Food Tests and Balanced Diets$mq$ and p.name = $mq$Biological Molecules$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Food tests let scientists identify which nutrients are in a sample, and the idea of a balanced diet explains why we need all of them in the right amounts. Both topics appear often in MYP 5 Biology, especially in practical (Criterion B and C) questions.

## The four food tests
- **Starch (iodine test):** add a few drops of orange-brown iodine solution. A positive result is **blue-black**. Negative stays orange-brown.
- **Reducing sugar (Benedict's test):** add Benedict's solution (blue) to the sample and heat in a water bath at about 80°C for several minutes. The colour goes blue → green → yellow → orange → **brick-red** as the amount of reducing sugar increases. Blue means none detected.
- **Protein (Biuret test):** add Biuret reagent (or sodium hydroxide followed by copper sulfate). A positive result is **purple (lilac)**. Negative stays blue.
- **Lipid (ethanol emulsion test):** shake the sample with ethanol, then pour into water. A positive result is a **cloudy white emulsion**. Negative stays clear.

## Doing the tests well
Good practice in a food test investigation includes:
- using the same volume of food and reagent each time
- using a water bath, not a naked flame, for heating
- wearing eye protection
- including a control (for example water instead of food) to show the reagent alone does not change colour
- never tasting lab materials.
Benedict's results can be compared with a colour chart to give a rough amount (semi-quantitative). Sucrose does not give a positive Benedict's result unless it is first boiled with dilute acid, because it is not a reducing sugar.

## A balanced diet
A balanced diet contains the correct proportions of:
- carbohydrates (energy)
- proteins (growth and repair)
- lipids (energy store, insulation)
- vitamins and minerals (small amounts for health)
- fibre (keeps food moving through the gut)
- water (needed for reactions and transport).
Energy needs depend on age, size, sex and activity. Teenagers need extra protein, calcium and iron. Athletes need more energy.

## Deficiency diseases
- **Scurvy:** lack of vitamin C (bleeding gums, slow healing).
- **Rickets:** lack of vitamin D or calcium (soft, bent bones).
- **Anaemia:** lack of iron (tiredness, pale skin, because haemoglobin cannot be made).
- **Kwashiorkor:** severe protein deficiency.

## Common mistakes
- Saying iodine tests for sugar. It tests for starch.
- Writing 'clear' instead of 'blue' for a negative Benedict's test.
- Claiming a food is 'healthy' or 'unhealthy' without referring to nutrients and amounts.
- Forgetting that tests only show what is present, not how much unless a scale is used.

## How this is examined
Expect a practical context, for example a table of results in words from several foods. You may be asked to identify nutrients, name a safety precaution, suggest an improvement to make results more reliable, or evaluate a diet plan for a person with specific needs. Extended questions ask you to justify conclusions using the data and to say what limits them.

Exam tip: Always give both the reagent and the colour change, for example 'Biuret turns blue to purple', and name one control variable when asked how to make a test fair.$mq$ from st;

-- Senses and Behaviour > The Eye, Ear and Other Receptors
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Senses and Behaviour$mq$, 5, 2 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$The Eye, Ear and Other Receptors$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 5 and p.name = $mq$Senses and Behaviour$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$The Eye, Ear and Other Receptors$mq$ and p.name = $mq$Senses and Behaviour$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a receptor in the nervous system?$mq$, $mq$["A cell or organ that detects a stimulus","A muscle that produces a response","A gland that releases hormones","A neurone that carries messages to the brain only"]$mq$, 0, $mq$Receptors detect stimuli such as light, sound, touch, temperature and chemicals. Muscles and glands are effectors.$mq$, $mq$easy$mq$),
($mq$Which part of the eye contains the light-sensitive cells?$mq$, $mq$["Cornea","Iris","Lens","Retina"]$mq$, 3, $mq$The retina contains rod and cone cells that detect light. The cornea and lens refract light and the iris controls the pupil size.$mq$, $mq$easy$mq$),
($mq$Which part of the ear contains the cochlea?$mq$, $mq$["Outer ear","Middle ear","Inner ear","Ear canal"]$mq$, 2, $mq$The cochlea is in the inner ear. It converts vibrations into nerve impulses.$mq$, $mq$easy$mq$),
($mq$Which structure of the eye controls the amount of light entering by changing the size of the pupil?$mq$, $mq$["Retina","Iris","Optic nerve","Cornea"]$mq$, 1, $mq$The muscles of the iris make the pupil larger or smaller. The retina detects light and the optic nerve carries impulses to the brain.$mq$, $mq$easy$mq$),
($mq$Which sense organ contains receptors that detect chemicals in the air?$mq$, $mq$["Nose","Eye","Ear","Skin"]$mq$, 0, $mq$The nose has chemical receptors that detect smell. The tongue has chemical receptors for taste.$mq$, $mq$easy$mq$),
($mq$In bright light, what happens to the pupil and why?$mq$, $mq$["It gets larger to let more light in","It stays the same size","It moves to the side of the eye","It gets smaller to protect the retina from too much light"]$mq$, 3, $mq$Circular muscles in the iris contract, making the pupil smaller. This stops damage to the retina.$mq$, $mq$medium$mq$),
($mq$Which sequence correctly shows the path of light entering the eye?$mq$, $mq$["Retina → lens → pupil → cornea","Lens → cornea → retina → pupil","Cornea → pupil → lens → retina","Pupil → retina → lens → cornea"]$mq$, 2, $mq$Light is refracted by the cornea, passes through the pupil, is focused by the lens and lands on the retina.$mq$, $mq$medium$mq$),
($mq$When looking at a close object, what happens to the lens?$mq$, $mq$["It becomes thinner and flatter","It becomes thicker and rounder","It moves backwards","It disappears"]$mq$, 1, $mq$For near objects, ciliary muscles contract, suspensory ligaments slacken and the lens becomes fatter, which bends light more strongly.$mq$, $mq$medium$mq$),
($mq$Which sequence correctly shows how sound passes through the ear?$mq$, $mq$["Ear drum → ossicles → cochlea → auditory nerve","Cochlea → ossicles → ear drum → auditory nerve","Ossicles → auditory nerve → ear drum → cochlea","Ear drum → cochlea → ossicles → auditory nerve"]$mq$, 0, $mq$Sound makes the ear drum vibrate, the ossicles (three small bones) pass and amplify vibrations to the cochlea, which sends impulses along the auditory nerve.$mq$, $mq$medium$mq$),
($mq$Rod cells and cone cells differ because:$mq$, $mq$["Rods detect colour; cones work in dim light","Both detect only sound","Rods are in the lens; cones are in the cornea","Rods work in dim light; cones detect colour in bright light"]$mq$, 3, $mq$Rods are sensitive in dim light but do not detect colour. Cones need brighter light and give colour vision.$mq$, $mq$medium$mq$),
($mq$Alicia has short-sightedness (myopia). She can see near objects clearly but distant objects look blurred. What is the likely cause?$mq$, $mq$["Light from distant objects is focused behind the retina","The retina is missing","Light from distant objects is focused in front of the retina","The pupil is too small"]$mq$, 2, $mq$In myopia the eyeball is too long or the lens too strong, so light from far away focuses in front of the retina. A concave (diverging) lens corrects it.$mq$, $mq$medium$mq$),
($mq$A person walks from bright sunlight into a dark room. What happens to the pupil over the next few seconds?$mq$, $mq$["It gets smaller","It gets larger","It closes completely","No change"]$mq$, 1, $mq$Radial muscles of the iris contract and circular muscles relax, making the pupil wider to let in more light.$mq$, $mq$medium$mq$),
($mq$Skin contains receptors that detect which stimuli?$mq$, $mq$["Touch, pressure, temperature and pain","Light and sound only","Smell and taste only","Gravity only"]$mq$, 0, $mq$The skin has a range of receptors for touch, pressure, heat, cold and pain.$mq$, $mq$medium$mq$),
($mq$Mei Ling stands near a loud concert speaker for hours. Later she finds quiet sounds hard to hear. Which explanation is best?$mq$, $mq$["Loud sound damages the lens","Loud sound damages the retina","Loud sound makes the ear drum thicker","Loud sound can damage the sensory hair cells in the cochlea"]$mq$, 3, $mq$The hair cells in the cochlea detect vibrations. Very loud noise can damage them permanently, causing hearing loss.$mq$, $mq$hard$mq$),
($mq$Why can people not see well in dim light at the edges of their vision and see few colours at night?$mq$, $mq$["Cones work best in dim light","The lens turns black at night","Rods work in dim light but do not detect colour, and cones need brighter light","The cornea closes at night"]$mq$, 2, $mq$At night mostly rod cells are working. They cannot tell colours apart, so the world appears in shades of grey.$mq$, $mq$hard$mq$),
($mq$A student tests a volunteer's pupil size as a torch is shone towards the eye. Pupil diameter: before 7 mm, after 3 mm. What is the best conclusion?$mq$, $mq$["The retina changed colour","The pupil reflex reduced light entering the eye, which protects the retina","The lens became thicker","The cornea absorbed the light"]$mq$, 1, $mq$The pupil decreased from 7 mm to 3 mm, a response to bright light that limits light reaching the retina. The data does not show changes in the lens or cornea.$mq$, $mq$hard$mq$),
($mq$A person has damage to the optic nerve but a healthy eye. Which effect is most likely?$mq$, $mq$["Light is focused normally but impulses cannot reach the brain, so vision is lost or reduced","Light cannot enter the eye","The lens cannot change shape but vision is normal","Sound cannot be heard"]$mq$, 0, $mq$The retina can detect light, but the optic nerve carries impulses to the brain. Without it, the brain cannot form the image.$mq$, $mq$hard$mq$),
($mq$Diego is given 'receptor, sensory neurone, relay neurone, motor neurone, effector' as a pathway. Which description of the ear's role fits this list correctly?$mq$, $mq$["The ossicles are effectors","The ear drum is the motor neurone","The outer ear is the relay neurone","The cochlea hair cells are receptors; the auditory nerve carries impulses to the brain"]$mq$, 3, $mq$The sensory hair cells in the cochlea are the receptors and the auditory nerve is made of sensory neurones. The ossicles and ear drum are not neurones or effectors.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$The Eye, Ear and Other Receptors$mq$ and p.name = $mq$Senses and Behaviour$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Stimulus vs receptor$mq$, $mq$A stimulus is a change in the environment. A receptor is a cell or organ that detects it.$mq$),
($mq$Function of the retina$mq$, $mq$Contains rod and cone cells (light receptors) that send impulses along the optic nerve to the brain.$mq$),
($mq$Rods vs cones$mq$, $mq$Rods: work in dim light, no colour. Cones: detect colour, need bright light.$mq$),
($mq$Pupil in bright light$mq$, $mq$Circular iris muscles contract, pupil gets smaller, protecting the retina.$mq$),
($mq$Lens when focusing on a near object$mq$, $mq$Ciliary muscles contract, ligaments slacken, lens becomes thicker and rounder.$mq$),
($mq$Path of sound through the ear$mq$, $mq$Pinna, ear canal, ear drum, ossicles, cochlea (hair cells), auditory nerve, brain.$mq$),
($mq$Role of ossicles$mq$, $mq$Three small bones that pass on and amplify vibrations from the ear drum to the cochlea.$mq$),
($mq$Short-sightedness and its correction$mq$, $mq$Distant objects focus in front of the retina. Corrected by a concave (diverging) lens.$mq$),
($mq$Role of semicircular canals$mq$, $mq$Contain receptors that detect head movement and help with balance.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$The Eye, Ear and Other Receptors$mq$ and p.name = $mq$Senses and Behaviour$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Our senses let us detect changes in the environment. A **stimulus** is a change that can be detected, and a **receptor** is a cell or organ that detects it. Receptors turn the stimulus into nerve impulses, which travel to the brain, where a response is decided. Muscles and glands that carry out the response are called **effectors**.

## The eye
Light enters the eye and is bent (refracted) so that it forms a sharp image on the retina.
- **Cornea:** transparent front surface that does most of the bending of light.
- **Iris:** coloured ring of muscle that controls pupil size.
- **Pupil:** hole in the iris where light enters.
- **Lens:** changes shape to fine-focus light.
- **Retina:** layer at the back containing **rods** (work in dim light, no colour) and **cones** (colour, need bright light).
- **Optic nerve:** carries impulses to the brain.

### Pupil reflex
In bright light, circular muscles of the iris contract and the pupil gets smaller, protecting the retina. In dim light, radial muscles contract and the pupil gets larger to let more light in.

### Focusing
To see a **near** object, ciliary muscles contract, suspensory ligaments slacken and the lens becomes thicker and rounder. To see a **distant** object, ciliary muscles relax, ligaments tighten and the lens becomes thinner. In short-sightedness, distant objects are focused in front of the retina and a concave lens corrects it. In long-sightedness, near objects are focused behind the retina and a convex lens corrects it.

## The ear
The ear detects sound and also helps with balance.
- **Pinna** collects sound.
- **Ear drum** vibrates.
- **Ossicles** (three small bones) pass the vibrations on and make them stronger.
- **Cochlea** contains hair cells that turn vibrations into nerve impulses.
- **Auditory nerve** carries impulses to the brain.
The semicircular canals contain receptors that detect head movement and help balance. Very loud noise can permanently damage the hair cells.

## Other receptors
- Skin: touch, pressure, temperature and pain.
- Nose: chemicals in the air (smell).
- Tongue: chemicals in food (taste: sweet, salty, sour, bitter, umami).

## Common mistakes
- Saying the lens does all the bending of light. The cornea does most of it.
- Mixing up which muscles do what when the pupil changes. Link size to light: bright light, small pupil.
- Forgetting that the receptor is the cell (for example rod or hair cell) not the whole organ.

## How this is examined
Questions often give a scenario, such as a person moving from sunshine into a dark cinema or an investigation of pupil size. You may be asked to label or describe the path of light or sound, explain a response, interpret data in a short table described in words, or evaluate how reliable an investigation is.

Exam tip: When explaining the pupil reflex, state the stimulus, the receptor or effector involved and the result (for example 'bright light, iris muscles contract, pupil smaller, less light reaches the retina').$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('biology')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;