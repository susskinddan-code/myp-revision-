-- Part 2 of 6: 6 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Enzymes and Nutrition > Enzyme Action and the Lock and Key Model
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Enzymes and Nutrition$mq$, 4, 3 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Enzyme Action and the Lock and Key Model$mq$, 4, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Enzymes and Nutrition$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Enzyme Action and the Lock and Key Model$mq$ and p.name = $mq$Enzymes and Nutrition$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Enzymes are biological catalysts. Name the type of molecule that all enzymes are made of.$mq$, $mq$["Protein","Carbohydrate","Fat","Mineral"]$mq$, 0, $mq$Enzymes are proteins. Their long chains fold into a specific three-dimensional shape that allows them to work.$mq$, $mq$easy$mq$),
($mq$Name the part of an enzyme where the substrate binds.$mq$, $mq$["Nucleus","Cell wall","Membrane","Active site"]$mq$, 3, $mq$The active site is a small region with a particular shape. The substrate fits into it so the reaction can happen.$mq$, $mq$easy$mq$),
($mq$Name the substance that an enzyme acts on.$mq$, $mq$["Product","Catalyst","Substrate","Solvent"]$mq$, 2, $mq$The substrate binds to the enzyme's active site and is changed into one or more products.$mq$, $mq$easy$mq$),
($mq$Enzymes are biological catalysts. What do they do to the rate of a reaction?$mq$, $mq$["Slow it down","Speed it up","Stop it","Reverse it"]$mq$, 1, $mq$A catalyst increases the rate of a reaction without being used up. Without enzymes, reactions in cells would be too slow to keep us alive.$mq$, $mq$easy$mq$),
($mq$Name the enzyme in saliva that breaks down starch.$mq$, $mq$["Amylase","Protease","Lipase","Catalase"]$mq$, 0, $mq$Amylase breaks down starch into the sugar maltose, starting digestion in the mouth.$mq$, $mq$easy$mq$),
($mq$Name the type of enzyme that breaks down proteins into amino acids.$mq$, $mq$["Lipase","Amylase","Catalase","Protease"]$mq$, 3, $mq$Proteases digest proteins. Pepsin in the stomach is one example.$mq$, $mq$medium$mq$),
($mq$Lipase breaks down fats. Name the two types of molecule it produces.$mq$, $mq$["Amino acids and glucose","Glucose and maltose","Fatty acids and glycerol","Starch and protein"]$mq$, 2, $mq$Lipase breaks lipids (fats and oils) into three fatty acids and one glycerol molecule.$mq$, $mq$medium$mq$),
($mq$Name the enzyme found in cells that breaks down toxic hydrogen peroxide into water and oxygen.$mq$, $mq$["Amylase","Catalase","Protease","Lipase"]$mq$, 1, $mq$Catalase protects cells from hydrogen peroxide, which is a harmful waste product of some reactions.$mq$, $mq$medium$mq$),
($mq$Why does each enzyme work on only one type of substrate?$mq$, $mq$["Its active site has a matching shape","Enzymes are all the same shape","All substrates are alike","Enzymes are alive"]$mq$, 0, $mq$The substrate fits the active site like a key in a lock. A substrate with a different shape will not fit, so that enzyme cannot act on it.$mq$, $mq$medium$mq$),
($mq$What happens to an enzyme at the end of a reaction?$mq$, $mq$["It is used up","It becomes the product","It is digested","It is unchanged and can be reused"]$mq$, 3, $mq$An enzyme is a catalyst, so it is not used up. It can bind to another substrate molecule straight away.$mq$, $mq$medium$mq$),
($mq$Name the model of enzyme action in which the substrate fits the active site like a key fits a lock.$mq$, $mq$["Fluid mosaic model","Particle model","Lock and key model","Cell theory"]$mq$, 2, $mq$In the lock and key model the shape of the active site is complementary to the shape of the substrate.$mq$, $mq$medium$mq$),
($mq$Name the new substances formed when an enzyme breaks down a substrate.$mq$, $mq$["Reactants","Products","Catalysts","Solutes"]$mq$, 1, $mq$The molecules produced by a reaction are called the products. In digestion, the products are small soluble molecules such as sugars.$mq$, $mq$medium$mq$),
($mq$Name one organ other than the salivary glands that makes amylase.$mq$, $mq$["Pancreas","Liver","Stomach","Gall bladder"]$mq$, 0, $mq$The pancreas makes amylase, protease and lipase and releases them into the small intestine. The liver makes bile, which is not an enzyme.$mq$, $mq$medium$mq$),
($mq$Name the term for an enzyme whose active site has permanently changed shape so the substrate no longer fits.$mq$, $mq$["Digested","Dissolved","Respired","Denatured"]$mq$, 3, $mq$When an enzyme is denatured, its protein chain unfolds and the active site loses its shape. This change is usually permanent.$mq$, $mq$hard$mq$),
($mq$The rate of an enzyme-controlled reaction levels off when more substrate is added. What is the most likely reason?$mq$, $mq$["The enzyme is denatured","The substrate is used up","All active sites are occupied","The temperature has fallen"]$mq$, 2, $mq$When every enzyme molecule is busy with a substrate, adding more substrate cannot speed up the reaction, so the rate stops rising.$mq$, $mq$hard$mq$),
($mq$Amylase added to a mixture of starch and protein breaks down only the starch. Name the property of enzymes that this shows.$mq$, $mq$["Denaturation","Specificity","Diffusion","Respiration"]$mq$, 1, $mq$Amylase has an active site that fits starch only, not protein. Each enzyme is specific to its substrate.$mq$, $mq$hard$mq$),
($mq$Name the protease enzyme made in the stomach.$mq$, $mq$["Pepsin","Amylase","Lipase","Maltase"]$mq$, 0, $mq$Pepsin breaks down proteins into smaller chains of amino acids. It works best in the acidic conditions of the stomach.$mq$, $mq$hard$mq$),
($mq$A chemical with a similar shape to the substrate blocks the active site of an enzyme. What happens to the rate of the reaction?$mq$, $mq$["It increases","It stays the same","It reverses","It decreases"]$mq$, 3, $mq$The chemical occupies the active site, so fewer substrate molecules can bind. The rate of reaction falls.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Enzyme Action and the Lock and Key Model$mq$ and p.name = $mq$Enzymes and Nutrition$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Enzyme$mq$, $mq$A biological catalyst made of protein. It speeds up a reaction and is not used up.$mq$),
($mq$Catalyst$mq$, $mq$A substance that increases the rate of a chemical reaction without being used up.$mq$),
($mq$Substrate$mq$, $mq$The substance that an enzyme acts on.$mq$),
($mq$Active site$mq$, $mq$The region of an enzyme with a shape that matches the substrate.$mq$),
($mq$Lock and key model$mq$, $mq$The substrate has a shape that fits the active site of its enzyme, like a key fits a lock.$mq$),
($mq$Amylase$mq$, $mq$An enzyme that breaks down starch into maltose. Made in the salivary glands and pancreas.$mq$),
($mq$Protease$mq$, $mq$An enzyme that breaks proteins down into amino acids. Pepsin is a protease in the stomach.$mq$),
($mq$Lipase$mq$, $mq$An enzyme that breaks down fats into fatty acids and glycerol.$mq$),
($mq$Why are enzymes specific?$mq$, $mq$Each enzyme has an active site with a shape that fits only one type of substrate.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Enzyme Action and the Lock and Key Model$mq$ and p.name = $mq$Enzymes and Nutrition$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Every second, thousands of chemical reactions take place in your cells. Most would be far too slow at body temperature without help. This help comes from enzymes.

## What are enzymes?
Enzymes are biological catalysts. A catalyst is a substance that speeds up a chemical reaction without being used up. Enzymes are proteins. The long chain of amino acids folds into a specific three-dimensional shape. Part of that shape is a small groove or pocket called the active site.

## The lock and key model
The substance an enzyme works on is the substrate. The substrate has a shape that is complementary to the active site, in the same way that a key fits a lock. The substrate binds to the active site to form an enzyme-substrate complex. The reaction takes place, the products are released, and the enzyme is unchanged and free to work again.

This model explains why enzymes are specific. Only one substrate has the right shape to fit a given active site. Amylase will break down starch but will not break down protein.

## Examples of digestive enzymes
- Amylase breaks down starch into maltose. It is made in the salivary glands and the pancreas.
- Protease, such as pepsin in the stomach, breaks down proteins into amino acids.
- Lipase breaks down fats into fatty acids and glycerol.
Digestive enzymes break large insoluble molecules into small soluble molecules that can be absorbed into the blood. Catalase is not a digestive enzyme. It works inside cells and breaks down hydrogen peroxide into water and oxygen.

## Enzymes and conditions
Enzymes work best at an optimum temperature and pH. If conditions are too extreme, the shape of the active site changes. The substrate no longer fits and the enzyme is denatured. This is covered further in the sub-topic on rate investigations.

## Worked example 1
A student mixes the enzyme lipase with milk containing fat. The pH falls. Explain why. Answer: lipase breaks down the fat into fatty acids and glycerol. The fatty acids lower the pH.

## Worked example 2
A scientist adds more and more substrate to a fixed amount of enzyme. The rate rises, then levels off. Explain the shape of the graph. Answer: at first more substrate means more enzyme-substrate collisions, so the rate rises. Eventually all of the active sites are occupied at once, so extra substrate cannot increase the rate. The enzyme concentration is now the limiting factor.

## Common mistakes
- Saying enzymes are "used up" or "killed". Enzymes are not alive, and they are not used up. They are denatured, not killed.
- Saying the substrate is changed to fit the enzyme. In the lock and key model the shapes are already complementary.
- Mixing up the substrate and the product.
- Writing that amylase breaks down proteins.
- Saying an enzyme "makes" the reaction happen. It only speeds up a reaction that is possible.

## Command terms
- Define: give the exact meaning of a catalyst.
- Describe: say what happens, for example describe how the lock and key model works.
- Explain: give reasons, such as why an enzyme is specific.
- Sketch: draw a rough graph, for example rate against substrate concentration.

Exam tip: in an explanation about enzymes, use the words active site, substrate and complementary shape.$mq$ from st;

-- Enzymes and Nutrition > Enzyme Rate Investigations
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Enzymes and Nutrition$mq$, 4, 3 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Enzyme Rate Investigations$mq$, 4, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Enzymes and Nutrition$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Enzyme Rate Investigations$mq$ and p.name = $mq$Enzymes and Nutrition$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the optimum temperature for most human enzymes?$mq$, $mq$["37 degrees Celsius","20 degrees Celsius","50 degrees Celsius","100 degrees Celsius"]$mq$, 0, $mq$Human enzymes work best at around 37 degrees Celsius, which is normal body temperature.$mq$, $mq$easy$mq$),
($mq$Name the conditions at which an enzyme works fastest.$mq$, $mq$["Minimum conditions","Maximum conditions","Neutral conditions","Optimum conditions"]$mq$, 3, $mq$The optimum temperature and pH are the values at which the enzyme has the highest rate of reaction.$mq$, $mq$easy$mq$),
($mq$What happens to an enzyme at a very high temperature, such as 80 degrees Celsius?$mq$, $mq$["It works faster","It is digested","It is denatured","It evaporates"]$mq$, 2, $mq$High temperatures break the bonds holding the enzyme's shape, so the active site changes and the enzyme stops working.$mq$, $mq$easy$mq$),
($mq$Name the solution used to test for the presence of starch.$mq$, $mq$["Benedict's solution","Iodine solution","Limewater","Biuret reagent"]$mq$, 1, $mq$Iodine solution turns from orange-brown to blue-black in the presence of starch.$mq$, $mq$easy$mq$),
($mq$What colour does iodine solution turn when starch is present?$mq$, $mq$["Blue-black","Brick-red","Cloudy white","Colourless"]$mq$, 0, $mq$Starch turns iodine solution blue-black. If starch is absent, the iodine stays orange-brown.$mq$, $mq$easy$mq$),
($mq$Pepsin works best in the stomach. What is the approximate optimum pH for pepsin?$mq$, $mq$["pH 7","pH 9","pH 12","pH 2"]$mq$, 3, $mq$The stomach contains hydrochloric acid, which gives it a pH of about 2. Pepsin is adapted to work in these acidic conditions.$mq$, $mq$medium$mq$),
($mq$What is the approximate optimum pH of amylase from saliva?$mq$, $mq$["pH 2","pH 11","pH 7","pH 14"]$mq$, 2, $mq$Saliva is close to neutral, and salivary amylase works best at about pH 7.$mq$, $mq$medium$mq$),
($mq$In an amylase and starch investigation, what colour of iodine shows that all the starch has been broken down?$mq$, $mq$["Blue-black","Orange-brown","Green","Purple"]$mq$, 1, $mq$Iodine solution is orange-brown unless starch is present. If the colour stays orange-brown, there is no starch left.$mq$, $mq$medium$mq$),
($mq$What happens to the rate of an enzyme-controlled reaction as the temperature rises from 0 to 37 degrees Celsius?$mq$, $mq$["It increases","It decreases","It stays the same","It stops"]$mq$, 0, $mq$At higher temperatures, particles have more kinetic energy and collide more often and harder, so the reaction rate goes up.$mq$, $mq$medium$mq$),
($mq$Name the piece of equipment used to keep the temperature of tubes steady in an enzyme investigation.$mq$, $mq$["Bunsen burner","Balance","Measuring cylinder","Water bath"]$mq$, 3, $mq$A water bath keeps the contents of the tubes at a constant temperature. A Bunsen burner would heat unevenly.$mq$, $mq$medium$mq$),
($mq$The volume of enzyme solution is kept the same in every tube. What kind of variable is this?$mq$, $mq$["Independent variable","Dependent variable","Control variable","Random variable"]$mq$, 2, $mq$Variables that are kept the same so the test is fair are called control variables.$mq$, $mq$medium$mq$),
($mq$Starch disappears after 50 seconds. What is the rate of reaction, calculated as 1 divided by time?$mq$, $mq$["0.2 per second","0.02 per second","50 per second","2 per second"]$mq$, 1, $mq$Rate = 1 ÷ time = 1 ÷ 50 = 0.02 per second.$mq$, $mq$medium$mq$),
($mq$What should you do with an anomalous result when calculating a mean?$mq$, $mq$["Exclude it","Include it twice","Double it","Change it to match the others"]$mq$, 0, $mq$An anomalous result does not fit the pattern, often because of a mistake. It is left out of the mean and mentioned in the evaluation.$mq$, $mq$medium$mq$),
($mq$The rates of an enzyme at 10, 20, 30, 40, 50 and 60 degrees Celsius are 2, 4, 7, 9, 3 and 0. What is the best estimate of the optimum temperature?$mq$, $mq$["30 degrees Celsius","50 degrees Celsius","60 degrees Celsius","40 degrees Celsius"]$mq$, 3, $mq$The highest rate is at 40 degrees Celsius. The rate then falls sharply as the enzyme begins to denature, and it is zero at 60 degrees Celsius.$mq$, $mq$hard$mq$),
($mq$An enzyme heated to 70 degrees Celsius is cooled to 37 degrees Celsius but does not work again. What is the reason?$mq$, $mq$["The substrate has been used up","The enzyme has evaporated","Its active site has permanently changed shape","The pH has risen"]$mq$, 2, $mq$Denaturation by high temperature is permanent, so cooling does not restore the shape of the active site.$mq$, $mq$hard$mq$),
($mq$Why does the rate of an enzyme-controlled reaction rise as the temperature increases below the optimum?$mq$, $mq$["The enzyme is denatured","More frequent collisions between enzyme and substrate","The substrate changes shape","More enzyme is made"]$mq$, 1, $mq$Warmer particles move faster, so enzyme and substrate molecules collide more often and with more energy.$mq$, $mq$hard$mq$),
($mq$Pepsin leaves the stomach and enters the alkaline small intestine. Why does it stop working?$mq$, $mq$["The alkaline pH denatures it","It is too cold","It is digested by amylase","It runs out of substrate"]$mq$, 0, $mq$Pepsin has an optimum of about pH 2. In the alkaline small intestine, its active site changes shape, so it is denatured.$mq$, $mq$hard$mq$),
($mq$At 80 degrees Celsius a mixture of starch and amylase still turns iodine blue-black. What does this show?$mq$, $mq$["All the starch has been digested","The iodine has reacted with amylase","Amylase works best at 80 degrees Celsius","The amylase has been denatured"]$mq$, 3, $mq$The starch is still present, so the amylase did not break it down. At 80 degrees Celsius amylase is denatured.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Enzyme Rate Investigations$mq$ and p.name = $mq$Enzymes and Nutrition$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Optimum temperature$mq$, $mq$The temperature at which an enzyme works fastest. About 37 degrees Celsius for human enzymes.$mq$),
($mq$Denatured enzyme$mq$, $mq$An enzyme whose active site has permanently changed shape, usually by high temperature or extreme pH.$mq$),
($mq$Why does the rate rise with temperature below the optimum?$mq$, $mq$Particles have more kinetic energy, so enzyme and substrate collide more often.$mq$),
($mq$Optimum pH of pepsin$mq$, $mq$About pH 2, in the acidic stomach.$mq$),
($mq$Optimum pH of salivary amylase$mq$, $mq$About pH 7, close to neutral.$mq$),
($mq$Iodine test for starch$mq$, $mq$Orange-brown iodine turns blue-black when starch is present.$mq$),
($mq$How to find rate from time$mq$, $mq$Rate = 1 ÷ time. A shorter time means a faster rate.$mq$),
($mq$Control variables in an amylase investigation$mq$, $mq$Volume and concentration of starch and enzyme, temperature (when testing pH), and the timing method.$mq$),
($mq$Why repeat the investigation?$mq$, $mq$To calculate a mean, spot anomalous results and make the results more reliable.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Enzyme Rate Investigations$mq$ and p.name = $mq$Enzymes and Nutrition$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Enzymes are sensitive to their surroundings. Two of the most important factors are temperature and pH. In this sub-topic you learn how to investigate these factors and how to interpret the results.

## Temperature
At low temperatures, enzyme and substrate particles move slowly. They collide less often, so the reaction is slow. As the temperature rises, particles gain kinetic energy, collide more often and the rate increases. Every enzyme has an optimum temperature at which it works fastest. For human enzymes this is around 37 degrees Celsius. Above the optimum, the bonds that hold the enzyme in shape begin to break. The active site changes shape and the substrate no longer fits. The enzyme is denatured, and the rate falls rapidly. Denaturation is permanent, so cooling does not bring the enzyme back to life.

## pH
Each enzyme also has an optimum pH. Pepsin in the stomach works best at about pH 2. Salivary amylase works best at about pH 7. Enzymes in the small intestine work best in slightly alkaline conditions. If the pH is too far from the optimum, the enzyme is denatured.

## A standard investigation: amylase and starch
1. Mix starch solution and amylase in a test tube kept in a water bath at a chosen temperature.
2. Every 30 seconds, take a drop of the mixture and add it to a drop of iodine solution on a spotting tile.
3. Record when the iodine stops turning blue-black and stays orange-brown. This is the time at which all of the starch has been broken down.
4. Repeat at several temperatures, or with buffer solutions of different pH.
Independent variable: temperature or pH. Dependent variable: the time taken for starch to disappear. Control variables: volume and concentration of starch, volume and concentration of amylase, and (when testing pH) the temperature.

Rate can be calculated as 1 ÷ time. A shorter time means a faster rate.

## Worked example
Time taken for the starch to disappear: 20 degrees Celsius = 200 s; 40 degrees Celsius = 50 s; 60 degrees Celsius = no change after 600 s.
Rate at 20 degrees Celsius = 1 ÷ 200 = 0.005 per second. Rate at 40 degrees Celsius = 1 ÷ 50 = 0.02 per second, four times faster. At 60 degrees Celsius, the rate is zero, because the amylase has been denatured. The optimum is likely to be near 40 degrees Celsius, although a narrower range of temperatures would be needed to find it more precisely.

## Improving reliability and accuracy
- Repeat each temperature at least three times and calculate a mean.
- Exclude anomalous results from the mean and discuss them.
- Use a water bath and a thermometer to keep temperatures steady.
- Let the enzyme and starch reach the temperature separately before mixing.
- Use a measuring syringe, not a beaker, to measure small volumes.

## Common mistakes
- Saying that enzymes are killed by heat. They are not alive, so say denatured.
- Writing that low temperatures denature enzymes. Cold only slows them down, and they work again when warmed.
- Describing the rate as "the time". A longer time means a slower rate.
- Forgetting to control the temperature when investigating pH.
- Drawing the graph with a smooth rise that ends flat. The rate drops sharply after the optimum.

## Command terms
- Plan: describe the equipment, variables and steps of an investigation.
- Interpret: say what a graph or table shows about the enzyme.
- Justify: give reasons for choosing the optimum from data.
- Evaluate: comment on strengths and weaknesses of the method.

Exam tip: if asked to explain a rate change, mention collisions at low temperature and denaturation at high temperature, and never use the word "killed".$mq$ from st;

-- Enzymes and Nutrition > Nutrients, Food Tests and Deficiencies
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Enzymes and Nutrition$mq$, 4, 3 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Nutrients, Food Tests and Deficiencies$mq$, 4, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Enzymes and Nutrition$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Nutrients, Food Tests and Deficiencies$mq$ and p.name = $mq$Enzymes and Nutrition$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Name the nutrient needed for growth and repair of body tissues.$mq$, $mq$["Protein","Carbohydrate","Fibre","Water"]$mq$, 0, $mq$Proteins are made of amino acids, which the body uses to build new cells and repair damaged ones.$mq$, $mq$easy$mq$),
($mq$Name the nutrient that is the main source of quick energy.$mq$, $mq$["Protein","Fibre","Vitamin D","Carbohydrate"]$mq$, 3, $mq$Carbohydrates such as starch and sugars are broken down to glucose, which is used in respiration.$mq$, $mq$easy$mq$),
($mq$Name the solution used to test food for glucose.$mq$, $mq$["Iodine solution","Biuret reagent","Benedict's solution","Limewater"]$mq$, 2, $mq$Benedict's solution is heated with the food sample in a water bath. Glucose and some other sugars change its colour.$mq$, $mq$easy$mq$),
($mq$What colour does Benedict's solution turn with a high concentration of glucose after heating?$mq$, $mq$["Blue-black","Brick-red","Purple","Cloudy white"]$mq$, 1, $mq$The colour change goes from blue through green, yellow and orange to brick-red as the concentration of sugar rises.$mq$, $mq$easy$mq$),
($mq$Name the disease caused by a lack of vitamin C.$mq$, $mq$["Scurvy","Rickets","Anaemia","Goitre"]$mq$, 0, $mq$Vitamin C is needed to make healthy skin and gums. A lack causes scurvy, with bleeding gums and slow wound healing.$mq$, $mq$easy$mq$),
($mq$A lack of which vitamin causes rickets?$mq$, $mq$["Vitamin A","Vitamin C","Vitamin K","Vitamin D"]$mq$, 3, $mq$Vitamin D helps the body absorb calcium. Without it, bones are soft and can bend, which is called rickets.$mq$, $mq$medium$mq$),
($mq$A lack of which mineral causes anaemia?$mq$, $mq$["Calcium","Iodine","Iron","Sodium"]$mq$, 2, $mq$Iron is needed to make haemoglobin in red blood cells. Without enough iron, the blood carries less oxygen and the person feels tired and weak.$mq$, $mq$medium$mq$),
($mq$What do you see in the ethanol emulsion test if fat is present?$mq$, $mq$["A blue-black colour","A cloudy white layer","A brick-red precipitate","A purple colour"]$mq$, 1, $mq$Fat does not dissolve in water, so when the ethanol solution is added to water, fat forms a cloudy white emulsion.$mq$, $mq$medium$mq$),
($mq$Dietary fibre helps to prevent which digestive problem?$mq$, $mq$["Constipation","Scurvy","Rickets","Anaemia"]$mq$, 0, $mq$Fibre adds bulk to the food and helps the muscles of the gut push it along, so it helps to prevent constipation.$mq$, $mq$medium$mq$),
($mq$In which unit is the energy content of foods usually measured?$mq$, $mq$["Kilograms","Kilopascals","Kilometres","Kilojoules"]$mq$, 3, $mq$Energy in food is measured in joules or kilojoules (kJ). Many labels also give kilocalories.$mq$, $mq$medium$mq$),
($mq$Eggs, fish and beans are good sources of which nutrient?$mq$, $mq$["Carbohydrate","Fibre","Protein","Vitamin C"]$mq$, 2, $mq$These foods contain a lot of protein, which is used for growth and repair.$mq$, $mq$medium$mq$),
($mq$Name the mineral needed for strong bones and teeth.$mq$, $mq$["Iron","Calcium","Iodine","Sodium"]$mq$, 1, $mq$Calcium is a main component of bone and teeth. Milk and cheese are good sources.$mq$, $mq$medium$mq$),
($mq$Which vitamin is needed for good vision in dim light?$mq$, $mq$["Vitamin A","Vitamin C","Vitamin D","Vitamin K"]$mq$, 0, $mq$Vitamin A is used to make a light-sensitive pigment in the eye. A lack causes night blindness.$mq$, $mq$medium$mq$),
($mq$In a food-burning experiment, 1.0 g of food heats 20 g of water by 10 degrees Celsius. The specific heat capacity of water is 4.2 J per gram per degree Celsius. How much energy per gram of food was transferred to the water?$mq$, $mq$["84 J","8400 J","210 J","840 J"]$mq$, 3, $mq$Energy = mass of water x 4.2 x temperature rise = 20 x 4.2 x 10 = 840 J for 1.0 g of food.$mq$, $mq$hard$mq$),
($mq$One food sample gives a green colour with Benedict's solution and another gives brick-red. What does this show?$mq$, $mq$["The first has more sugar","Neither has any sugar","The second has more sugar","Both have equal sugar"]$mq$, 2, $mq$The colour changes from blue to green, yellow, orange and then brick-red as the sugar concentration increases. Brick-red means the most sugar.$mq$, $mq$hard$mq$),
($mq$Egg white solution turns purple with biuret reagent and stays blue with heated Benedict's solution. What does it contain?$mq$, $mq$["Glucose but no protein","Protein but no glucose","Starch and protein","Fat only"]$mq$, 1, $mq$Purple with biuret reagent shows protein is present. The blue colour with Benedict's solution shows there is no reducing sugar such as glucose.$mq$, $mq$hard$mq$),
($mq$A teenager needs 10,500 kJ per day. A meal provides 3,150 kJ. What percentage of the daily energy requirement is this?$mq$, $mq$["30%","33%","3.5%","70%"]$mq$, 0, $mq$Percentage = 3,150 ÷ 10,500 x 100 = 30%.$mq$, $mq$hard$mq$),
($mq$Per 100 g, butter provides about 3000 kJ and bread about 1000 kJ. Which nutrient mainly explains the higher energy in butter?$mq$, $mq$["Fibre","Water","Vitamin C","Fat"]$mq$, 3, $mq$Fat gives about 37 kJ per gram, more than twice the energy per gram from carbohydrate or protein (about 17 kJ per gram).$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Nutrients, Food Tests and Deficiencies$mq$ and p.name = $mq$Enzymes and Nutrition$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Carbohydrates$mq$, $mq$Provide energy. Digested to glucose.$mq$),
($mq$Proteins$mq$, $mq$Made of amino acids. Used for growth, repair and making enzymes.$mq$),
($mq$Fats (lipids)$mq$, $mq$Store energy, insulate and protect organs. About 37 kJ per gram.$mq$),
($mq$Scurvy$mq$, $mq$Disease caused by a lack of vitamin C. Bleeding gums and slow wound healing.$mq$),
($mq$Rickets$mq$, $mq$Disease caused by a lack of vitamin D (and so poor calcium absorption). Soft, bent bones.$mq$),
($mq$Anaemia$mq$, $mq$A lack of iron means too little haemoglobin is made. The person is tired and pale.$mq$),
($mq$Benedict's test for sugar$mq$, $mq$Heat with Benedict's solution. Blue turns green, yellow, orange or brick-red depending on the amount of sugar.$mq$),
($mq$Biuret test for protein$mq$, $mq$Add biuret reagent. Blue turns purple if protein is present.$mq$),
($mq$Energy in food equation$mq$, $mq$Energy (J) = mass of water x 4.2 x temperature rise in degrees Celsius.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Nutrients, Food Tests and Deficiencies$mq$ and p.name = $mq$Enzymes and Nutrition$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$A balanced diet gives the body everything it needs to release energy, grow, repair tissue and stay healthy. The main nutrient groups are carbohydrates, proteins, fats (lipids), vitamins, minerals, fibre and water.

## Nutrient groups and their jobs
- Carbohydrates, such as starch and sugars, provide energy. They are digested into glucose.
- Proteins are made of amino acids. They are used for growth and repair, and to make enzymes and hormones.
- Fats (lipids) store energy and insulate the body. They give more energy per gram than the other nutrients: about 37 kJ per gram compared with about 17 kJ per gram for carbohydrate and protein.
- Vitamins and minerals are needed in small amounts.
- Fibre (cellulose) is not digested but keeps food moving through the gut.
- Water is needed for all the chemical reactions and for transport in the blood.

## Deficiency diseases
- Vitamin C: lack causes scurvy (bleeding gums, slow healing). Found in citrus fruits.
- Vitamin D: lack causes rickets (soft bones). The skin makes vitamin D in sunlight.
- Vitamin A: lack causes poor vision in dim light.
- Iron: lack causes anaemia, because haemoglobin cannot be made.
- Calcium: needed for bones and teeth.
- Iodine: needed for thyroid hormones. A lack causes a swollen thyroid called goitre.

## Food tests
- Starch: add iodine solution. Orange-brown changes to blue-black.
- Glucose: add Benedict's solution and heat in a water bath. Blue changes to green, yellow, orange or brick-red, depending on the amount.
- Protein: add biuret reagent (sodium hydroxide and copper sulfate). Blue changes to purple.
- Fat: shake the food with ethanol, then pour the liquid into water. A cloudy white emulsion shows fat.
For the glucose test the colour change tells you roughly how much sugar there is, so it is semi-quantitative. Prepare the food as a solution by grinding it with water first.

## Energy content of food
To measure energy in food, burn a known mass of the food under a boiling tube containing a known mass of water, and measure the temperature rise.
Energy transferred = mass of water x 4.2 x temperature rise.
Worked example: 1.0 g of a nut heats 25 g of water by 20 degrees Celsius. Energy = 25 x 4.2 x 20 = 2,100 J, which is 2.1 kJ per gram. The real value is higher because much of the heat escapes to the air. Improve accuracy by using a draught shield, putting the flame close to the tube, and stirring the water.

## Common mistakes
- Saying a positive Benedict's test is "red" every time. The colour depends on concentration.
- Forgetting to heat the Benedict's mixture.
- Writing that fibre gives energy. It is not digested.
- Confusing scurvy (vitamin C) and rickets (vitamin D).
- Stating the energy value of food without including the units.

## Command terms
- State: name a nutrient or a disease.
- Describe: give the steps and the colour changes of a food test.
- Explain: link a deficiency to its cause, for example why a lack of iron causes tiredness.
- Calculate: use the energy equation and show the working.
- Evaluate: suggest why a food-burning result is lower or higher than the true value.

Exam tip: always give both the starting colour and the end colour in a food test answer.$mq$ from st;

-- Photosynthesis > The Photosynthesis Equation and Leaf Structure
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Photosynthesis$mq$, 4, 4 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$The Photosynthesis Equation and Leaf Structure$mq$, 4, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Photosynthesis$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$The Photosynthesis Equation and Leaf Structure$mq$ and p.name = $mq$Photosynthesis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Name the green pigment in chloroplasts that absorbs light.$mq$, $mq$["Chlorophyll","Haemoglobin","Cellulose","Melanin"]$mq$, 0, $mq$Chlorophyll absorbs light energy so that it can be used to make glucose.$mq$, $mq$easy$mq$),
($mq$Photosynthesis takes in energy from light. What word describes a reaction that takes in energy?$mq$, $mq$["Exothermic","Combustion","Reversible","Endothermic"]$mq$, 3, $mq$An endothermic reaction takes in energy from the surroundings. In photosynthesis the energy comes from light.$mq$, $mq$easy$mq$),
($mq$Name the gas that is released as a product of photosynthesis.$mq$, $mq$["Carbon dioxide","Nitrogen","Oxygen","Methane"]$mq$, 2, $mq$Oxygen is made when water molecules are split during photosynthesis and it leaves the leaf through the stomata.$mq$, $mq$easy$mq$),
($mq$Name the form of energy that is absorbed by chlorophyll.$mq$, $mq$["Heat energy","Light energy","Sound energy","Chemical energy"]$mq$, 1, $mq$Chlorophyll absorbs light energy and the plant stores it as chemical energy in glucose.$mq$, $mq$easy$mq$),
($mq$Besides carbon dioxide, name the raw material that plants take from the soil for photosynthesis.$mq$, $mq$["Water","Oxygen","Glucose","Nitrogen"]$mq$, 0, $mq$Water is absorbed by the roots and carried to the leaves in the xylem. Carbon dioxide, the other reactant, enters through the stomata.$mq$, $mq$easy$mq$),
($mq$In the balanced equation 6CO2 + 6H2O -> C6H12O6 + ?O2, what number goes before O2?$mq$, $mq$["2","12","3","6"]$mq$, 3, $mq$There are 6 carbon atoms and 12 hydrogen atoms on each side. The oxygen atoms: 12 + 6 = 18 on the left, and 6 in glucose + 12 in 6O2 = 18 on the right.$mq$, $mq$medium$mq$),
($mq$Name the layer of cells near the top of a leaf that contains the most chloroplasts.$mq$, $mq$["Spongy mesophyll","Lower epidermis","Palisade mesophyll","Xylem"]$mq$, 2, $mq$Palisade cells are tall and packed with chloroplasts, and they are near the top of the leaf where the light is strongest.$mq$, $mq$medium$mq$),
($mq$Name the pair of cells that open and close a stoma.$mq$, $mq$["Root hair cells","Guard cells","Palisade cells","Xylem vessels"]$mq$, 1, $mq$Guard cells change shape to open or close the stoma. This controls gas exchange and water loss.$mq$, $mq$medium$mq$),
($mq$Name the layer in the leaf that has large air spaces to let gases diffuse.$mq$, $mq$["Spongy mesophyll","Palisade mesophyll","Upper epidermis","Cuticle"]$mq$, 0, $mq$Air spaces in the spongy mesophyll allow carbon dioxide to diffuse to the palisade cells and oxygen to diffuse out.$mq$, $mq$medium$mq$),
($mq$Why is the upper epidermis of a leaf transparent?$mq$, $mq$["To store starch","To absorb water","To make glucose","To let light through"]$mq$, 3, $mq$Light must pass through the upper epidermis to reach the chloroplasts in the palisade cells below.$mq$, $mq$medium$mq$),
($mq$Name the waxy layer on the surface of a leaf that reduces water loss.$mq$, $mq$["Phloem","Stomata","Cuticle","Xylem"]$mq$, 2, $mq$The cuticle is waterproof, so it reduces evaporation from the leaf surface.$mq$, $mq$medium$mq$),
($mq$Name the tissue that carries water into the leaf.$mq$, $mq$["Phloem","Xylem","Epidermis","Cuticle"]$mq$, 1, $mq$Xylem vessels carry water and mineral ions from the roots to the leaves.$mq$, $mq$medium$mq$),
($mq$Name the tissue that carries sugars away from the leaf to other parts of the plant.$mq$, $mq$["Phloem","Xylem","Cuticle","Guard cells"]$mq$, 0, $mq$Phloem carries dissolved sugars (sucrose) from the leaves to growing parts and storage organs in a process called translocation.$mq$, $mq$medium$mq$),
($mq$Which two colours of light does chlorophyll absorb most strongly?$mq$, $mq$["Green and yellow","Red and green","Blue and yellow","Red and blue"]$mq$, 3, $mq$Chlorophyll absorbs mainly red and blue light and reflects most green light, which is why leaves look green.$mq$, $mq$hard$mq$),
($mq$Why are the palisade cells found near the top of the leaf?$mq$, $mq$["To store water","To let gases in","To absorb the most light","To transport sugars"]$mq$, 2, $mq$The top of the leaf receives the most light, so chloroplast-rich cells there carry out the most photosynthesis.$mq$, $mq$hard$mq$),
($mq$The white part of a variegated leaf does not photosynthesise. Why?$mq$, $mq$["It has no cell wall","It has no chlorophyll","It has no water","It has no stomata"]$mq$, 1, $mq$White areas have no chloroplasts and so no chlorophyll to absorb light. They cannot photosynthesise.$mq$, $mq$hard$mq$),
($mq$How many molecules of oxygen are produced when a plant makes 3 molecules of glucose?$mq$, $mq$["18","6","3","9"]$mq$, 0, $mq$The equation shows 6 molecules of oxygen for each glucose molecule. For 3 glucose molecules, 3 x 6 = 18.$mq$, $mq$hard$mq$),
($mq$Why is photosynthesis described as the basis of most food chains?$mq$, $mq$["It produces heat","It makes carbon dioxide","It breaks down food","It stores light energy in glucose"]$mq$, 3, $mq$Photosynthesis changes light energy into chemical energy in glucose. Producers pass this energy on to the consumers that eat them.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$The Photosynthesis Equation and Leaf Structure$mq$ and p.name = $mq$Photosynthesis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Word equation for photosynthesis$mq$, $mq$Carbon dioxide + water -> glucose + oxygen, using light energy absorbed by chlorophyll.$mq$),
($mq$Symbol equation for photosynthesis$mq$, $mq$6CO2 + 6H2O -> C6H12O6 + 6O2$mq$),
($mq$Chlorophyll$mq$, $mq$The green pigment in chloroplasts that absorbs light, mainly red and blue.$mq$),
($mq$Why is photosynthesis endothermic?$mq$, $mq$It takes in energy from light and stores it as chemical energy in glucose.$mq$),
($mq$Palisade mesophyll$mq$, $mq$The layer of tall cells near the top of a leaf, packed with chloroplasts.$mq$),
($mq$Spongy mesophyll$mq$, $mq$The layer with air spaces that allows gases to diffuse through the leaf.$mq$),
($mq$Stomata and guard cells$mq$, $mq$Stomata are pores for gas exchange. Guard cells open and close them.$mq$),
($mq$Xylem and phloem in a leaf$mq$, $mq$Xylem brings water and minerals to the leaf. Phloem carries sugars away.$mq$),
($mq$Why are leaves broad and thin?$mq$, $mq$A large surface area absorbs more light and a short diffusion distance lets gases reach cells quickly.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$The Photosynthesis Equation and Leaf Structure$mq$ and p.name = $mq$Photosynthesis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Photosynthesis is the process by which plants, algae and some bacteria make their own food. It is the way almost all the energy in food chains enters living things. Plants are called producers because they make glucose from simple substances.

## The photosynthesis equations
In words: carbon dioxide + water -> glucose + oxygen, in the presence of light and chlorophyll.
In symbols: 6CO2 + 6H2O -> C6H12O6 + 6O2.
Photosynthesis is an endothermic reaction: it takes in energy from light. This energy is stored in the bonds of glucose as chemical energy. Chlorophyll, the green pigment in chloroplasts, absorbs the light. It absorbs red and blue light most strongly and reflects green light.

Check the balance: on the left there are 6 carbon, 12 hydrogen and 18 oxygen atoms. On the right glucose has 6 carbon, 12 hydrogen and 6 oxygen, and 6 O2 adds 12 more oxygen atoms, giving 18. Both sides match.

## Where it happens: the leaf
A leaf is adapted for photosynthesis:
- The waxy cuticle reduces water loss.
- The upper epidermis is thin and transparent, so light passes through.
- The palisade mesophyll is just below it. The cells are tall, close together and packed with chloroplasts, so they absorb a lot of light.
- The spongy mesophyll has air spaces, so carbon dioxide can diffuse to the palisade cells.
- The lower epidermis contains stomata. These pores let carbon dioxide in and oxygen out. Each stoma is opened and closed by two guard cells.
- Veins contain xylem, which brings water and minerals, and phloem, which carries away sugar.
A leaf is also thin and broad. This gives a large surface area to absorb light and a short distance for gases to diffuse.

## Worked example 1
How many molecules of carbon dioxide are needed to make 4 molecules of glucose? The equation shows 6 CO2 for each glucose. So 4 x 6 = 24 molecules.

## Worked example 2
A student is asked to explain why palisade cells are well adapted for photosynthesis. A good answer: they contain many chloroplasts with chlorophyll to absorb light; they are located near the top of the leaf, where most light arrives; and they are long and tall, so they fit many cells in a small area of leaf.

## Common mistakes
- Saying that plants only take in carbon dioxide and give out oxygen. They also respire all the time, taking in oxygen and giving out carbon dioxide.
- Saying plants get their food from the soil. The soil provides water and minerals; the glucose is made in the leaf.
- Writing the equation backwards. That is respiration.
- Writing "chlorophyll" for the structure. Chloroplasts are the organelles; chlorophyll is the pigment within them.
- Thinking stomata are only on the top of the leaf. They are usually on the underside.

## Command terms
- State: give the word equation.
- Describe: say what happens to light, water and carbon dioxide.
- Explain: link a leaf feature to its function, for example why the leaf is thin.
- Label: add the names to a diagram of a leaf cross-section.

Exam tip: for adaptation questions, use the pattern feature, function, benefit, for example "thin leaf, so a short diffusion distance, so carbon dioxide reaches the cells quickly".$mq$ from st;

-- Photosynthesis > Factors Affecting Photosynthesis Rate
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Photosynthesis$mq$, 4, 4 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Factors Affecting Photosynthesis Rate$mq$, 4, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Photosynthesis$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Factors Affecting Photosynthesis Rate$mq$ and p.name = $mq$Photosynthesis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Name the gas whose concentration can limit the rate of photosynthesis.$mq$, $mq$["Carbon dioxide","Nitrogen","Argon","Methane"]$mq$, 0, $mq$Carbon dioxide is a reactant. If there is very little in the air, the rate of photosynthesis cannot be high.$mq$, $mq$easy$mq$),
($mq$Name the factor that is measured in units called lux.$mq$, $mq$["Temperature","Carbon dioxide concentration","Water volume","Light intensity"]$mq$, 3, $mq$Light intensity is how bright the light is, and it can be measured in lux with a light meter.$mq$, $mq$easy$mq$),
($mq$Name the factor that is in shortest supply and limits the rate of photosynthesis.$mq$, $mq$["Control variable","Dependent variable","Limiting factor","Catalyst"]$mq$, 2, $mq$The limiting factor is the one that is in shortest supply. Increasing it increases the rate, whereas increasing other factors does not.$mq$, $mq$easy$mq$),
($mq$Which factor limits photosynthesis at night?$mq$, $mq$["Carbon dioxide","Light","Temperature","Water"]$mq$, 1, $mq$At night there is no light energy, so photosynthesis stops.$mq$, $mq$easy$mq$),
($mq$Name the gas given off as bubbles by pondweed in a photosynthesis investigation.$mq$, $mq$["Oxygen","Carbon dioxide","Hydrogen","Nitrogen"]$mq$, 0, $mq$The bubbles are oxygen released as a product of photosynthesis. Counting them gives an estimate of the rate.$mq$, $mq$easy$mq$),
($mq$What happens to the rate of photosynthesis as light intensity increases from a very low level?$mq$, $mq$["It decreases","It stays the same","It stops","It increases"]$mq$, 3, $mq$More light gives more energy for the reaction, so at first the rate rises.$mq$, $mq$medium$mq$),
($mq$Name the water plant commonly used in an investigation of photosynthesis where bubbles are counted.$mq$, $mq$["Moss","Cactus","Pondweed","Fern"]$mq$, 2, $mq$Pondweed (Elodea or Cabomba) is a water plant that gives off visible bubbles of oxygen from cut stems.$mq$, $mq$medium$mq$),
($mq$How can a student change the light intensity in a pondweed investigation?$mq$, $mq$["Add more water","Change the distance of the lamp","Change the bubble size","Heat the beaker"]$mq$, 1, $mq$Moving the lamp closer increases the light intensity. Moving it further away decreases it.$mq$, $mq$medium$mq$),
($mq$Sodium hydrogencarbonate is added to the water in a pondweed investigation. What does it provide?$mq$, $mq$["Carbon dioxide","Oxygen","Light","Nitrogen"]$mq$, 0, $mq$Sodium hydrogencarbonate dissolves and releases carbon dioxide, so the amount of carbon dioxide is not the limiting factor.$mq$, $mq$medium$mq$),
($mq$Why is a beaker of water placed between the lamp and the pondweed?$mq$, $mq$["To add oxygen","To make the light brighter","To provide carbon dioxide","To absorb heat from the lamp"]$mq$, 3, $mq$The water absorbs heat, so the temperature of the pondweed does not change when the lamp is moved.$mq$, $mq$medium$mq$),
($mq$The rate of photosynthesis stops increasing even though the light intensity is raised further. What is the most likely explanation?$mq$, $mq$["Light is not needed","The plant has died","Another factor is now limiting","Oxygen is used up"]$mq$, 2, $mq$Once light is no longer the limiting factor, some other factor such as carbon dioxide or temperature is limiting.$mq$, $mq$medium$mq$),
($mq$Name the type of molecule that controls the reactions of photosynthesis and can be denatured by heat.$mq$, $mq$["Hormones","Enzymes","Vitamins","Lipids"]$mq$, 1, $mq$Many reactions in photosynthesis are controlled by enzymes. At high temperatures the enzymes denature and the rate falls.$mq$, $mq$medium$mq$),
($mq$Some greenhouse owners burn paraffin. What does this increase?$mq$, $mq$["Carbon dioxide concentration","Light brightness","Humidity only","Oxygen concentration"]$mq$, 0, $mq$Burning paraffin releases carbon dioxide and heat, both of which can increase the rate of photosynthesis.$mq$, $mq$medium$mq$),
($mq$A pondweed gives 40 bubbles per minute at 10 cm from a lamp and 10 bubbles per minute at 20 cm. How many times faster is the rate at 10 cm?$mq$, $mq$["2 times","30 times","The same","4 times"]$mq$, 3, $mq$The rate at 10 cm divided by the rate at 20 cm = 40 ÷ 10 = 4.$mq$, $mq$hard$mq$),
($mq$Four repeats of bubble counts are 12, 14, 30 and 13. The value 30 is anomalous. What is the mean of the other results?$mq$, $mq$["17.3","14","13","12.5"]$mq$, 2, $mq$Mean of 12, 14 and 13 = (12 + 14 + 13) ÷ 3 = 39 ÷ 3 = 13.$mq$, $mq$hard$mq$),
($mq$A plant at 55 degrees Celsius photosynthesises very slowly. Why?$mq$, $mq$["Carbon dioxide is used up","Enzymes are denatured","There is too much light","Chlorophyll evaporates"]$mq$, 1, $mq$At high temperatures the enzymes that control photosynthesis lose their shape, so the rate drops.$mq$, $mq$hard$mq$),
($mq$Light intensity is low but carbon dioxide and temperature are ideal. Which factor is limiting the rate?$mq$, $mq$["Light intensity","Carbon dioxide","Temperature","Water"]$mq$, 0, $mq$The factor that is furthest from its ideal value is limiting. Here that is the light.$mq$, $mq$hard$mq$),
($mq$In a pondweed investigation, moving the lamp closer also warms the water. What is the effect on the investigation?$mq$, $mq$["It is more accurate","Bubbles become larger","Light intensity decreases","It is not a fair test"]$mq$, 3, $mq$Temperature is a second variable that changes, so the change in rate cannot be linked only to light intensity.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Factors Affecting Photosynthesis Rate$mq$ and p.name = $mq$Photosynthesis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Limiting factor$mq$, $mq$The factor in shortest supply that stops the rate of photosynthesis from increasing.$mq$),
($mq$Three factors affecting photosynthesis$mq$, $mq$Light intensity, carbon dioxide concentration and temperature.$mq$),
($mq$Why does the rate fall at high temperature?$mq$, $mq$Enzymes that control photosynthesis are denatured.$mq$),
($mq$Why does a rate graph level off?$mq$, $mq$Another factor, such as carbon dioxide or temperature, has become the limiting factor.$mq$),
($mq$What gas do the bubbles from pondweed contain?$mq$, $mq$Oxygen, a product of photosynthesis.$mq$),
($mq$How to change light intensity in an investigation$mq$, $mq$Move the lamp closer or further away from the plant.$mq$),
($mq$Why add sodium hydrogencarbonate?$mq$, $mq$It releases carbon dioxide, so carbon dioxide is not limiting.$mq$),
($mq$Why put a beaker of water in front of the lamp?$mq$, $mq$To absorb heat so the temperature stays constant.$mq$),
($mq$How do greenhouses increase yield?$mq$, $mq$By controlling light, temperature and carbon dioxide concentration.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Factors Affecting Photosynthesis Rate$mq$ and p.name = $mq$Photosynthesis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$The rate of photosynthesis is how fast a plant makes glucose. It is not constant. It depends on several factors, and understanding them helps farmers and gardeners grow more food.

## The three main factors
1. Light intensity: light provides the energy. As light intensity rises, the rate rises, until another factor becomes limiting.
2. Carbon dioxide concentration: the air has about 0.04% carbon dioxide. This is low, so it often limits photosynthesis on bright days. Raising it increases the rate.
3. Temperature: photosynthesis is controlled by enzymes. The rate rises with temperature up to an optimum, then falls quickly as enzymes denature. The optimum for many plants is around 25 to 35 degrees Celsius.
Water is also needed, but a shortage usually causes the stomata to close, which cuts the supply of carbon dioxide.

## Limiting factors
A limiting factor is the factor that is in shortest supply and so stops the rate from rising. On a graph of rate against light intensity, the line rises and then flattens. In the rising part, light is limiting. In the flat part, light is no longer limiting and a different factor, such as carbon dioxide or temperature, is limiting. To increase the rate further, you must increase that other factor.

## Investigating light intensity with pondweed
1. Place a piece of pondweed in a beaker of water with sodium hydrogencarbonate, which provides carbon dioxide.
2. Put a lamp at a measured distance from the beaker.
3. Count the bubbles of oxygen given off in one minute.
4. Repeat at several distances and repeat each three times.
Independent variable: distance of the lamp. Dependent variable: bubbles per minute. Control variables: temperature, carbon dioxide, same piece of pondweed and the time. A beaker of water between the lamp and the plant absorbs heat and keeps the temperature steady.

Limitations of counting bubbles are that bubbles vary in size, and some oxygen dissolves. A more accurate method is to collect the gas in a capillary tube or gas syringe and measure its volume.

## Worked example
Distances and bubbles per minute: 10 cm gave 36, 20 cm gave 9, 40 cm gave 2. From 10 cm to 20 cm the distance doubles and the rate falls from 36 to 9, a fall to a quarter. This shows that the rate falls quickly as the light weakens. Mean of 12, 14 and 13 bubbles = 39 ÷ 3 = 13 bubbles per minute.

## Using this in agriculture
Commercial greenhouses can control the limiting factors: lamps provide light at night, heaters keep temperature near the optimum, and carbon dioxide can be released into the air. Growers must balance the costs against the extra crop.

## Common mistakes
- Saying that the rate keeps rising forever as one factor increases. It levels off.
- Saying that high temperature "kills" the enzymes. They are denatured.
- Not controlling temperature when changing the lamp distance.
- Counting the bubbles and calling the bubbles "carbon dioxide".
- Forgetting to repeat the readings and calculate a mean.

## Command terms
- Identify: say which factor is limiting at a point on a graph.
- Interpret: explain the shape of a rate graph.
- Suggest: propose how a grower could increase the yield.
- Evaluate: judge the usefulness of bubble counting as a method.

Exam tip: when you describe a graph that levels off, say which factor limits the rate on the rising part, and that another factor limits it on the flat part.$mq$ from st;

-- Photosynthesis > Uses of Glucose and Plant Mineral Needs
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Photosynthesis$mq$, 4, 4 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Uses of Glucose and Plant Mineral Needs$mq$, 4, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Photosynthesis$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Uses of Glucose and Plant Mineral Needs$mq$ and p.name = $mq$Photosynthesis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Name the carbohydrate that plants use to store glucose.$mq$, $mq$["Starch","Cellulose","Glycogen","Sucrose"]$mq$, 0, $mq$Starch is a large insoluble carbohydrate made from many glucose molecules. Plants store it in leaves, roots and seeds.$mq$, $mq$easy$mq$),
($mq$Name the liquid heated in a water bath to remove chlorophyll from a leaf before testing for starch.$mq$, $mq$["Water","Iodine","Acid","Ethanol"]$mq$, 3, $mq$Hot ethanol dissolves chlorophyll so the leaf turns white, which makes the colour change with iodine easier to see.$mq$, $mq$easy$mq$),
($mq$Name the carbohydrate made from glucose that is used to build plant cell walls.$mq$, $mq$["Starch","Glycogen","Cellulose","Chitin"]$mq$, 2, $mq$Cellulose forms strong fibres in the cell wall. It is made from many glucose molecules.$mq$, $mq$easy$mq$),
($mq$Name the soluble sugar in which glucose is transported in phloem.$mq$, $mq$["Starch","Sucrose","Cellulose","Maltose"]$mq$, 1, $mq$Glucose is converted to sucrose, which is soluble and can be carried in the phloem to other parts of the plant.$mq$, $mq$easy$mq$),
($mq$Name the process in which cells release energy from glucose.$mq$, $mq$["Respiration","Photosynthesis","Digestion","Transpiration"]$mq$, 0, $mq$Plants use some of their glucose in respiration to release energy for growth and active transport.$mq$, $mq$easy$mq$),
($mq$In the starch test, why is the leaf first dipped in boiling water?$mq$, $mq$["To make more starch","To remove oxygen","To add colour","To kill it and soften it"]$mq$, 3, $mq$Boiling water kills the leaf cells and breaks down the membranes. It also softens the leaf so that ethanol and iodine can enter.$mq$, $mq$medium$mq$),
($mq$Why is the leaf then placed in hot ethanol?$mq$, $mq$["To make starch","To kill bacteria","To remove the chlorophyll","To add iodine"]$mq$, 2, $mq$Chlorophyll would hide the blue-black colour. Ethanol dissolves it, leaving the leaf pale.$mq$, $mq$medium$mq$),
($mq$Why is the ethanol heated in a water bath and not directly with a flame?$mq$, $mq$["Ethanol freezes","Ethanol is flammable","The flame destroys starch","A water bath is faster"]$mq$, 1, $mq$Ethanol catches fire easily, so it is heated in a beaker of hot water and the flame is turned off.$mq$, $mq$medium$mq$),
($mq$Half of a destarched leaf is covered with foil and the plant is placed in the light. After testing with iodine, which half turns blue-black?$mq$, $mq$["The uncovered half","The covered half","Both halves","Neither half"]$mq$, 0, $mq$Light reaches only the uncovered half, so only that half photosynthesises and stores starch.$mq$, $mq$medium$mq$),
($mq$Name the mineral ion that plants combine with glucose to make proteins.$mq$, $mq$["Calcium","Sodium","Chloride","Nitrate"]$mq$, 3, $mq$Plants absorb nitrate from the soil and use it with sugar to make amino acids, which form proteins.$mq$, $mq$medium$mq$),
($mq$A plant has yellow leaves because it lacks a mineral ion. Which ion is needed to make chlorophyll?$mq$, $mq$["Iodide","Sodium","Magnesium","Fluoride"]$mq$, 2, $mq$Magnesium is part of the chlorophyll molecule. Without it, leaves cannot make enough chlorophyll and turn yellow.$mq$, $mq$medium$mq$),
($mq$A plant with poor root growth and purple-tinged leaves may be short of which mineral ion?$mq$, $mq$["Nitrate","Phosphate","Magnesium","Chloride"]$mq$, 1, $mq$Phosphate is needed for making DNA, cell membranes and for energy transfer, and a lack of it limits growth, especially of roots.$mq$, $mq$medium$mq$),
($mq$Why do farmers add fertilisers to soil?$mq$, $mq$["To replace minerals removed by crops","To add water","To increase light","To lower the pH"]$mq$, 0, $mq$Crops take minerals out of the soil. Fertilisers contain nitrate, phosphate and potassium to replace what has been lost.$mq$, $mq$medium$mq$),
($mq$Why is glucose converted to starch for storage?$mq$, $mq$["Starch is sweeter","Starch is lighter","Starch dissolves quickly","Starch is insoluble"]$mq$, 3, $mq$Insoluble starch does not change the concentration of the cell sap, so it does not draw in water by osmosis. Glucose is soluble and would.$mq$, $mq$hard$mq$),
($mq$Potatoes store starch in underground tubers. Where was the glucose originally made?$mq$, $mq$["In the roots","In the tuber","In the leaves","In the flowers"]$mq$, 2, $mq$Glucose is made by photosynthesis in the leaves. It is turned into sucrose, moved in the phloem and converted to starch in the tuber.$mq$, $mq$hard$mq$),
($mq$A plant lacking nitrate has stunted growth. Which type of molecule can it not make enough of?$mq$, $mq$["Starch","Proteins","Cellulose","Sucrose"]$mq$, 1, $mq$Nitrate provides the nitrogen needed for amino acids. Without enough amino acids, the plant cannot make proteins for growth.$mq$, $mq$hard$mq$),
($mq$Before an investigation, a plant is kept in the dark for 48 hours. Why?$mq$, $mq$["To use up its existing starch","To make more chlorophyll","To kill bacteria","To increase water uptake"]$mq$, 0, $mq$The plant uses its stored starch in respiration. Any starch found afterwards must have been made during the experiment.$mq$, $mq$hard$mq$),
($mq$The white parts of a variegated leaf stay orange-brown with iodine after the plant has been in the light. What does this show?$mq$, $mq$["The leaf has no cell wall","The leaf has starch there","The iodine was too weak","No photosynthesis took place there"]$mq$, 3, $mq$White areas have no chlorophyll, so no photosynthesis occurs and no starch is stored. Iodine stays orange-brown.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Uses of Glucose and Plant Mineral Needs$mq$ and p.name = $mq$Photosynthesis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Starch$mq$, $mq$An insoluble storage carbohydrate made from glucose in plants.$mq$),
($mq$Cellulose$mq$, $mq$A carbohydrate made from glucose that forms plant cell walls.$mq$),
($mq$Sucrose$mq$, $mq$A soluble sugar made from glucose that is transported in phloem.$mq$),
($mq$Why store glucose as starch?$mq$, $mq$Starch is insoluble, so it does not affect osmosis and is compact for storage.$mq$),
($mq$Nitrate in plants$mq$, $mq$Used with glucose to make amino acids and proteins. Lack causes stunted growth.$mq$),
($mq$Magnesium in plants$mq$, $mq$Needed to make chlorophyll. Lack causes yellow leaves.$mq$),
($mq$Phosphate in plants$mq$, $mq$Needed for DNA, cell membranes and energy transfer. Lack causes poor root growth and purple leaves.$mq$),
($mq$Starch test for a leaf$mq$, $mq$Boil, soften in hot ethanol to remove chlorophyll, rinse, add iodine. Blue-black means starch.$mq$),
($mq$Why destarch a plant first?$mq$, $mq$Keeping it in the dark uses up existing starch, so any starch found was made during the experiment.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Uses of Glucose and Plant Mineral Needs$mq$ and p.name = $mq$Photosynthesis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Photosynthesis makes glucose, but a plant needs much more than glucose to survive. The glucose is used, changed and stored in several ways, and the plant must also take in mineral ions from the soil.

## Uses of glucose
1. Respiration: some glucose is used in respiration to release energy for growth, active transport and other cell activities.
2. Making starch: glucose is converted to starch, an insoluble storage molecule. It is stored in leaves, roots, tubers and seeds. Because starch is insoluble, it does not affect the concentration of the cell and so does not draw water in by osmosis.
3. Making cellulose: glucose is built into cellulose for cell walls.
4. Making sucrose: sucrose is a soluble sugar that is transported in the phloem to all parts of the plant. Sugar is also stored in fruit.
5. Making fats and oils: some glucose is used to make lipids stored in seeds, such as sunflower seeds, as an energy store.
6. Making proteins: glucose is combined with nitrate ions from the soil to make amino acids, then proteins.

## Mineral ions
- Nitrate: for amino acids and proteins. A shortage causes stunted growth and yellowing of older leaves.
- Magnesium: for making chlorophyll. A shortage causes yellow leaves.
- Phosphate: for making DNA and cell membranes and for energy transfer. A shortage causes poor root growth and purple-tinged leaves.
Plants take up these ions from the soil by active transport. Farmers use fertilisers to replace the minerals that harvested crops remove.

## Testing a leaf for starch
1. Dip the leaf in boiling water for about 30 seconds to kill it and soften it.
2. Turn off the flame. Place the leaf in hot ethanol in a boiling tube standing in hot water, to remove the chlorophyll. The leaf turns white.
3. Rinse the leaf in water to soften it again.
4. Spread it on a white tile and add iodine solution.
Blue-black shows starch is present; orange-brown shows it is absent.

## Worked example: is light needed?
To test whether light is needed, destarch a plant by leaving it in the dark for 48 hours. Cover part of a leaf with foil, and leave the plant in bright light for some hours. Test the leaf for starch. Result: the covered part is orange-brown, while the uncovered part is blue-black. Conclusion: light is needed for photosynthesis, since starch was made only where light reached.
A similar test uses a variegated leaf. The green parts turn blue-black and the white parts stay orange-brown, which shows that chlorophyll is needed.

## Common mistakes
- Saying plants get food from the soil. They get minerals, which are not food.
- Saying that starch is the immediate product. Glucose is made first and is then converted to starch.
- Heating the ethanol directly with a flame.
- Forgetting to destarch the plant before the investigation.
- Writing "magnesium makes leaves green". Magnesium is a part of chlorophyll, which makes them green.

## Command terms
- List: give several uses of glucose.
- Explain: give the reason why starch is used for storage.
- Describe: give the steps of the starch test with the result.
- Conclude: state what the result of the investigation shows.
- Justify: give a reason why a step, such as destarching, was needed.

Exam tip: in plant mineral questions, name the ion, say what the plant makes with it, and state the effect of a shortage.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('biology')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;