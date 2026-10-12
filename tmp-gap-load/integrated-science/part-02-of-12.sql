-- Part 2 of 12: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Chemical Reactions > Chemical Change and Equations
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Chemical Reactions$mq$, 5, 2 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Chemical Change and Equations$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Chemical Reactions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Chemical Change and Equations$mq$ and p.name = $mq$Chemical Reactions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which observation is the best sign that a chemical change has happened?$mq$, $mq$["A new substance is formed, such as a gas or a colour change","A solid changes shape when cut","Water is poured into a different container","A liquid changes volume when it is heated slightly"]$mq$, 0, $mq$A chemical change makes new substances. Changes of shape or container are physical.$mq$, $mq$easy$mq$),
($mq$What does the law of conservation of mass state?$mq$, $mq$["Mass always increases in a reaction","Mass is lost when a gas forms","Products always weigh less than reactants","Atoms are not created or destroyed, so total mass stays the same in a closed system"]$mq$, 3, $mq$Atoms are rearranged in reactions, so the total number of each atom and the total mass are unchanged.$mq$, $mq$easy$mq$),
($mq$In the reaction magnesium + oxygen → magnesium oxide, which are the reactants?$mq$, $mq$["Magnesium oxide only","Oxygen and magnesium oxide","Magnesium and oxygen","Magnesium oxide and energy"]$mq$, 2, $mq$Reactants are on the left of the arrow; the product is on the right.$mq$, $mq$easy$mq$),
($mq$What is the chemical formula for carbon dioxide?$mq$, $mq$["CO","CO₂","C₂O","O₂C₂"]$mq$, 1, $mq$One carbon atom joined to two oxygen atoms. CO is carbon monoxide.$mq$, $mq$easy$mq$),
($mq$What must be true of a balanced chemical equation?$mq$, $mq$["The same number of each type of atom on both sides","The same number of molecules on both sides","The same number of elements on each side","Only one product"]$mq$, 0, $mq$Atoms are conserved so each element has equal numbers either side.$mq$, $mq$easy$mq$),
($mq$Which set of coefficients balances H₂ + O₂ → H₂O?$mq$, $mq$["1, 1, 1","2, 2, 1","1, 2, 2","2, 1, 2"]$mq$, 3, $mq$2H₂ + O₂ → 2H₂O gives four H atoms and two O atoms on each side.$mq$, $mq$medium$mq$),
($mq$Which word equation describes the complete combustion of methane?$mq$, $mq$["Methane + water → carbon dioxide + oxygen","Methane + carbon dioxide → oxygen + water","Methane + oxygen → carbon dioxide + water","Methane → carbon + hydrogen"]$mq$, 2, $mq$Complete combustion of a hydrocarbon produces carbon dioxide and water.$mq$, $mq$medium$mq$),
($mq$A student burns 0.24 g of magnesium ribbon in an open crucible and the white product weighs 0.40 g. Why is the product heavier?$mq$, $mq$["Magnesium atoms became heavier","The magnesium combined with oxygen from the air","Energy has mass in the flame","The crucible lost mass"]$mq$, 1, $mq$Mg + O → MgO. The extra 0.16 g is the mass of oxygen that joined the magnesium.$mq$, $mq$medium$mq$),
($mq$Calcium carbonate is added to hydrochloric acid in an open flask on a balance. The reading falls. Why?$mq$, $mq$["Carbon dioxide gas escapes into the air","Mass is destroyed in the reaction","The acid evaporates completely","The calcium carbonate dissolves and vanishes"]$mq$, 0, $mq$The gas is a product that leaves the flask. In a sealed container the mass would stay the same.$mq$, $mq$medium$mq$),
($mq$Which set of coefficients balances Na + Cl₂ → NaCl?$mq$, $mq$["1, 1, 1","1, 2, 2","2, 2, 1","2, 1, 2"]$mq$, 3, $mq$2Na + Cl₂ → 2NaCl: two Na and two Cl on each side.$mq$, $mq$medium$mq$),
($mq$Which of these is a physical change?$mq$, $mq$["Wood burning","Iron rusting","Ice melting","Milk going sour"]$mq$, 2, $mq$Melting changes state but forms no new substance. The others make new substances.$mq$, $mq$medium$mq$),
($mq$Calcium carbonate is heated: CaCO₃ → CaO + CO₂. What type of reaction is this?$mq$, $mq$["Neutralisation","Thermal decomposition","Combustion","Displacement"]$mq$, 1, $mq$One compound breaks down into simpler substances when heated.$mq$, $mq$medium$mq$),
($mq$How many oxygen atoms are shown by 2Ca(OH)₂?$mq$, $mq$["4","2","1","6"]$mq$, 0, $mq$Each Ca(OH)₂ has two O atoms, so 2 × 2 = 4.$mq$, $mq$medium$mq$),
($mq$Which set of coefficients balances Fe + O₂ → Fe₂O₃?$mq$, $mq$["2, 3, 1","1, 1, 1","3, 4, 2","4, 3, 2"]$mq$, 3, $mq$4Fe + 3O₂ → 2Fe₂O₃: four Fe and six O on each side.$mq$, $mq$hard$mq$),
($mq$When 10.0 g of calcium carbonate is fully decomposed by heating, 5.6 g of calcium oxide forms. What mass of carbon dioxide is released?$mq$, $mq$["5.6 g","10.0 g","4.4 g","15.6 g"]$mq$, 2, $mq$Total mass is conserved: 10.0 − 5.6 = 4.4 g.$mq$, $mq$hard$mq$),
($mq$A student seals a flask containing acid and carbonate and the balance reading does not change. A second student leaves the flask open and the reading falls. What is the best conclusion?$mq$, $mq$["The law of conservation of mass is wrong","Mass is conserved only when no gas can escape; the open flask lost gas","Sealing the flask stops the reaction","Gas has no mass"]$mq$, 1, $mq$The open system lost carbon dioxide. Comparing closed and open systems is a good control.$mq$, $mq$hard$mq$),
($mq$In the equation C₃H₈ + ?O₂ → 3CO₂ + 4H₂O, what number goes in place of '?'$mq$, $mq$["5","3","4","10"]$mq$, 0, $mq$There are 6 + 4 = 10 oxygen atoms on the right, so 5 O₂ molecules are needed.$mq$, $mq$hard$mq$),
($mq$A catalytic converter changes harmful gases: 2CO + 2NO → 2CO₂ + N₂. Which statement is correct?$mq$, $mq$["The equation is not balanced because there is one N₂","The equation is balanced and has 6 atoms on each side","The equation is not balanced because CO₂ has more oxygen","The equation is balanced and has 8 atoms on each side"]$mq$, 3, $mq$Left: 2 × 2 + 2 × 2 = 8 atoms. Right: 2 × 3 + 2 = 8 atoms. The C, N and O counts all match.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Chemical Change and Equations$mq$ and p.name = $mq$Chemical Reactions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Chemical change$mq$, $mq$A change where one or more new substances form, e.g. burning, rusting, or cooking an egg.$mq$),
($mq$Law of conservation of mass$mq$, $mq$Atoms are not created or destroyed in a reaction, so total mass of reactants = total mass of products in a closed system.$mq$),
($mq$Reactant and product$mq$, $mq$Reactants are the starting substances (left of the arrow); products are the substances made (right of the arrow).$mq$),
($mq$Balancing rule$mq$, $mq$Change the coefficients (big numbers in front), never the subscripts (small numbers in formulae).$mq$),
($mq$Balanced equation for hydrogen burning$mq$, $mq$2H₂ + O₂ → 2H₂O$mq$),
($mq$Complete combustion of a hydrocarbon$mq$, $mq$Hydrocarbon + oxygen → carbon dioxide + water, and energy is released.$mq$),
($mq$Thermal decomposition$mq$, $mq$A compound breaks down into simpler substances when heated, e.g. CaCO₃ → CaO + CO₂.$mq$),
($mq$Why does a metal gain mass when it burns in air?$mq$, $mq$It combines with oxygen from the air, forming a heavier oxide.$mq$),
($mq$Why does an open flask lose mass in a reaction that makes gas?$mq$, $mq$The gas escapes into the air. In a sealed container the mass would not change.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Chemical Change and Equations$mq$ and p.name = $mq$Chemical Reactions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Chemical and physical change
In a **physical change** such as melting, dissolving or boiling, no new substance forms and the change can usually be reversed easily. In a **chemical change** new substances are made. Clues include a gas being released, a colour change, a precipitate forming, a temperature change, or light and heat being given out. However, you must be careful: a temperature change or gas can also occur in physical changes, so confirm that a new substance really forms.

## Reactants and products
In a reaction, **reactants** are turned into **products**. We write the change as a word equation, for example magnesium + oxygen → magnesium oxide. Symbol equations use chemical formulae such as Mg, O₂ and MgO. The formula shows which atoms are in a particle and how many.

## Conservation of mass
In a chemical reaction atoms are rearranged, not created or destroyed. So the total mass of reactants equals the total mass of products, as long as no substance enters or leaves the system. If a gas escapes, the mass seems to fall. If a gas from the air joins in, the mass seems to rise. For example, when 0.24 g of magnesium is burned in air, the white solid weighs 0.40 g because 0.16 g of oxygen has joined with the magnesium. Scientists use sealed containers to check mass conservation.

## Balancing equations
To balance an equation, put numbers (coefficients) in front of formulae so each element has the same number of atoms on both sides. Never change the small subscript numbers, because that changes the substance.

Worked example: balance propane burning, C₃H₈ + O₂ → CO₂ + H₂O.
- Balance carbon: 3 CO₂.
- Balance hydrogen: 8 H means 4 H₂O.
- Count oxygen on the right: 6 + 4 = 10, so 5 O₂.
- Final equation: C₃H₈ + 5O₂ → 3CO₂ + 4H₂O.
Check each element by counting atoms on both sides.

## Types of reaction
- **Combustion**: a substance reacts with oxygen, releasing energy.
- **Thermal decomposition**: a compound breaks down when heated, for example CaCO₃ → CaO + CO₂.
- **Neutralisation**: an acid reacts with a base (covered later).
- **Displacement**: a more reactive element takes the place of a less reactive one in a compound.

## Common mistakes
- Changing subscripts instead of coefficients when balancing.
- Forgetting that a gas can have mass.
- Saying mass is "lost" in an open reaction when it has actually escaped as a gas.
- Counting molecules instead of atoms to check a balance.

## How this is examined
Science criteria B and C often give an experiment, such as heating a metal in a crucible or reacting an acid with a carbonate on a balance, with a table of masses. You explain mass changes, balance an equation, and evaluate whether the method was fair and reliable. In criterion D you may link a reaction, such as the catalytic converter, to its impact on society and the environment.

Exam tip: If mass seems to change in a reaction, ask yourself whether a gas has entered or left the system. Refer to the particles and say that atoms are rearranged, not lost.$mq$ from st;

-- Chemical Reactions > Acids, Bases and Salts in Context
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Chemical Reactions$mq$, 5, 2 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Acids, Bases and Salts in Context$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Chemical Reactions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Acids, Bases and Salts in Context$mq$ and p.name = $mq$Chemical Reactions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the pH of a neutral solution at room temperature?$mq$, $mq$["7","0","1","14"]$mq$, 0, $mq$Below 7 is acidic and above 7 is alkaline. Pure water is neutral.$mq$, $mq$easy$mq$),
($mq$What colour does universal indicator turn in a strong acid?$mq$, $mq$["Purple","Green","Blue","Red"]$mq$, 3, $mq$Universal indicator is red for strong acids, green for neutral and purple for strong alkalis.$mq$, $mq$easy$mq$),
($mq$What is an alkali?$mq$, $mq$["Any acid that dissolves in water","A salt that has no pH","A base that dissolves in water","An acid with a pH above 7"]$mq$, 2, $mq$Alkalis such as sodium hydroxide form hydroxide ions in water and have pH above 7.$mq$, $mq$easy$mq$),
($mq$Which general word equation describes neutralisation?$mq$, $mq$["Acid + alkali → hydrogen + water","Acid + alkali → salt + water","Acid + metal → salt + water","Alkali + water → salt + hydrogen"]$mq$, 1, $mq$Neutralisation gives a salt and water.$mq$, $mq$easy$mq$),
($mq$Which salt forms when hydrochloric acid reacts with sodium hydroxide?$mq$, $mq$["Sodium chloride","Sodium sulfate","Sodium nitrate","Sodium carbonate"]$mq$, 0, $mq$Hydrochloric acid makes chlorides, sulfuric acid makes sulfates and nitric acid makes nitrates.$mq$, $mq$easy$mq$),
($mq$An acid is added to a solid and bubbles form. The gas turns limewater milky. What gas is it?$mq$, $mq$["Hydrogen","Oxygen","Chlorine","Carbon dioxide"]$mq$, 3, $mq$Carbon dioxide turns limewater cloudy. The solid was a carbonate.$mq$, $mq$medium$mq$),
($mq$What are the products when sulfuric acid reacts with sodium hydroxide?$mq$, $mq$["Sodium chloride and water","Sodium sulfate and hydrogen","Sodium sulfate and water","Sodium hydroxide and carbon dioxide"]$mq$, 2, $mq$Sulfuric acid makes sulfate salts, and neutralisation also makes water.$mq$, $mq$medium$mq$),
($mq$Magnesium is added to dilute hydrochloric acid. A lit splint is held at the mouth of the test tube and gives a squeaky pop. What does this show?$mq$, $mq$["Oxygen gas is produced","Hydrogen gas is produced","Carbon dioxide gas is produced","Chlorine gas is produced"]$mq$, 1, $mq$Acid + metal → salt + hydrogen. Hydrogen burns with a squeaky pop.$mq$, $mq$medium$mq$),
($mq$A farmer finds soil with a pH of 5.0. Why might lime (calcium hydroxide) be added?$mq$, $mq$["It is a base that neutralises the acidity","It is an acid that lowers pH","It increases the temperature","It adds water to the soil"]$mq$, 0, $mq$A base reacts with acid and raises the pH towards 7, which suits most crops.$mq$, $mq$medium$mq$),
($mq$Why do indigestion tablets contain bases such as magnesium hydroxide?$mq$, $mq$["To make the stomach more acidic","To kill bacteria in food","To add vitamins","To neutralise excess hydrochloric acid in the stomach"]$mq$, 3, $mq$Antacids neutralise acid. They should not make the stomach strongly alkaline.$mq$, $mq$medium$mq$),
($mq$In a neutralisation experiment 25.0 cm³ of alkali needed 20.2 cm³, 19.8 cm³ and 20.0 cm³ of acid in three trials. What is the mean volume of acid?$mq$, $mq$["19.8 cm³","20.2 cm³","20.0 cm³","60.0 cm³"]$mq$, 2, $mq$(20.2 + 19.8 + 20.0) ÷ 3 = 60.0 ÷ 3 = 20.0 cm³.$mq$, $mq$medium$mq$),
($mq$A dilute acid is diluted further with water. What happens to the pH?$mq$, $mq$["It decreases to 0","It increases towards 7","It stays exactly the same","It becomes alkaline"]$mq$, 1, $mq$Diluting an acid lowers the concentration of hydrogen ions, so the pH rises but does not pass 7.$mq$, $mq$medium$mq$),
($mq$Acid rain damages a statue made from limestone (calcium carbonate). Why?$mq$, $mq$["Acid reacts with calcium carbonate, releasing carbon dioxide and dissolving it","Acid rain is an alkali that dissolves the stone","The stone expands when it is wet","Acid evaporates the statue"]$mq$, 0, $mq$Carbonates react with acids, so the stone slowly erodes.$mq$, $mq$medium$mq$),
($mq$The pH of a stream is 4.2 upstream and 6.9 after it passes through a bed of limestone chippings. What explains the change?$mq$, $mq$["The limestone adds more acid","The water is diluted by evaporation","The thermometer was faulty","The carbonate neutralises acid in the water"]$mq$, 3, $mq$The limestone reacts with the acid and raises the pH. This is also how lime is used to treat acidified lakes.$mq$, $mq$hard$mq$),
($mq$Solution A has a pH of 2 and solution B has a pH of 5. Compared with B, A has about how many times the hydrogen ion concentration?$mq$, $mq$["3 times","30 times","1000 times","100 000 times"]$mq$, 2, $mq$Each pH unit is a tenfold change. Three units gives 10 × 10 × 10 = 1000.$mq$, $mq$hard$mq$),
($mq$Copper(II) sulfate crystals are made by adding copper(II) oxide to warm dilute sulfuric acid. Why is the oxide added in excess?$mq$, $mq$["To make the solution acidic","To make sure all the acid reacts; the leftover solid is then filtered off","To speed the reaction by cooling","To turn the product into a gas"]$mq$, 1, $mq$Excess insoluble base ensures no acid remains. The unreacted solid is removed by filtration and the filtrate is crystallised.$mq$, $mq$hard$mq$),
($mq$A student finds the end-point of a neutralisation by adding acid to alkali with indicator, but the volume varies between trials by 3 cm³. Which improvement is best?$mq$, $mq$["Add acid one drop at a time near the end-point and repeat until results agree","Use a larger beaker","Add all the acid quickly","Use less indicator and one trial"]$mq$, 0, $mq$Slow dropwise addition near the change reduces overshoot, and repeats improve reliability.$mq$, $mq$hard$mq$),
($mq$A school technician spills dilute sulfuric acid. Which treatment is best and why?$mq$, $mq$["A strong alkali, because it acts quickly","Water only, because it removes all acid","A strong acid, because it dries the spill","Sodium hydrogencarbonate powder, because it neutralises the acid and fizzing shows when it is finished"]$mq$, 3, $mq$A weak base is safe and shows completion by fizzing stopping. A strong alkali would be hazardous and could overshoot.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Acids, Bases and Salts in Context$mq$ and p.name = $mq$Chemical Reactions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$pH scale$mq$, $mq$0 to 14: below 7 acidic, 7 neutral, above 7 alkaline.$mq$),
($mq$Alkali$mq$, $mq$A base that dissolves in water; forms a solution with pH above 7.$mq$),
($mq$Neutralisation$mq$, $mq$Acid + base or alkali → salt + water.$mq$),
($mq$Acid + metal carbonate$mq$, $mq$Salt + water + carbon dioxide. Test the gas with limewater, which turns milky.$mq$),
($mq$Acid + metal$mq$, $mq$Salt + hydrogen. Test: lit splint gives a squeaky pop.$mq$),
($mq$Salt names$mq$, $mq$Hydrochloric acid → chlorides; sulfuric acid → sulfates; nitric acid → nitrates.$mq$),
($mq$pH change of one unit$mq$, $mq$A tenfold change in hydrogen ion concentration; pH 2 has 1000 times more H⁺ than pH 5.$mq$),
($mq$Why use excess insoluble base to make a salt?$mq$, $mq$It ensures all the acid reacts. The excess solid is removed by filtration.$mq$),
($mq$Uses of neutralisation$mq$, $mq$Lime on acidic soil, antacids for indigestion, treating acidified lakes, cleaning acid spills with weak bases.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Acids, Bases and Salts in Context$mq$ and p.name = $mq$Chemical Reactions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Acids and alkalis
Acids, such as hydrochloric, sulfuric and nitric acid, have a pH below 7 and form hydrogen ions (H⁺) in water. **Bases** are substances that react with acids. **Alkalis** are bases that dissolve in water and have a pH above 7. Examples are sodium hydroxide and calcium hydroxide. Pure water is neutral with a pH of 7.

The pH scale runs from 0 to 14. Universal indicator changes colour with pH, from red (strongly acidic) through green (neutral) to purple (strongly alkaline). Each step of 1 on the pH scale is a tenfold change in hydrogen ion concentration, so pH 2 has 1000 times more hydrogen ions than pH 5. Diluting an acid raises its pH towards 7 but never beyond.

## Reactions of acids
- **Acid + metal → salt + hydrogen.** Test: a lit splint makes a squeaky pop.
- **Acid + metal carbonate → salt + water + carbon dioxide.** Test: carbon dioxide turns limewater milky.
- **Acid + base or alkali → salt + water.** This is **neutralisation**.

The name of the salt comes from the acid and the metal: hydrochloric acid makes chlorides, sulfuric acid makes sulfates and nitric acid makes nitrates. Sulfuric acid and sodium hydroxide give sodium sulfate and water.

## Making a pure, dry salt
To make a soluble salt from an insoluble base, add the base (for example copper(II) oxide) to warm acid until no more reacts. The excess solid shows that all the acid has been used. Filter off the excess, then heat the filtrate to concentrate it and leave it to crystallise. Dry the crystals.

## Titration and accuracy
In neutralisation, a measured volume of alkali is placed in a flask with indicator. Acid is added from a burette until the indicator changes. Near the end-point add acid drop by drop. Repeat until you have concordant results (within about 0.2 cm³), then calculate the mean. For titres 20.2, 19.8 and 20.0 cm³, the mean is 20.0 cm³.

## Science in society
- Farmers add lime to raise the pH of acidic soil.
- Antacids contain bases that neutralise excess stomach acid.
- Acid rain, formed when sulfur dioxide dissolves in rain, dissolves limestone and harms aquatic life. Limestone is used to treat acidified lakes.
- Spills of acid in a laboratory are treated with a weak base such as sodium hydrogencarbonate, never a strong alkali.

## Common mistakes
- Saying that all bases are alkalis. Only soluble bases are alkalis.
- Forgetting that a salt is not always table salt.
- Saying that diluting an acid makes it alkaline.

## How this is examined
Context questions might involve soil treatment, a stream with changing pH, or a titration table. You calculate mean titres, name salts, identify gases from tests and evaluate whether a method is accurate. Criterion D questions ask about benefits and risks of neutralisation in society.

Exam tip: To name a salt, take the metal from the base and the ending from the acid, for example sulfuric acid gives a sulfate. Always quote the gas test result with the gas name.$mq$ from st;

-- Chemical Reactions > Rates of Reaction and Energy Changes
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Chemical Reactions$mq$, 5, 2 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Rates of Reaction and Energy Changes$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Chemical Reactions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Rates of Reaction and Energy Changes$mq$ and p.name = $mq$Chemical Reactions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What happens to the rate of most reactions when temperature increases?$mq$, $mq$["The rate increases","The rate decreases","The rate stays the same","The reaction stops"]$mq$, 0, $mq$Particles move faster, collide more often and with more energy.$mq$, $mq$easy$mq$),
($mq$What is a catalyst?$mq$, $mq$["A substance that slows a reaction","A reactant that is used up","A product of a reaction","A substance that speeds up a reaction and is not used up"]$mq$, 3, $mq$Catalysts provide an alternative pathway with lower activation energy and are unchanged at the end.$mq$, $mq$easy$mq$),
($mq$What does an exothermic reaction do?$mq$, $mq$["Absorbs energy so the temperature falls","Produces no energy change","Releases energy to the surroundings, so the temperature rises","Uses up energy permanently"]$mq$, 2, $mq$Combustion is exothermic.$mq$, $mq$easy$mq$),
($mq$What happens to the temperature of the surroundings in an endothermic reaction?$mq$, $mq$["It rises","It falls","It stays the same","It rises then explodes"]$mq$, 1, $mq$Endothermic reactions absorb energy from the surroundings, as in a cold pack.$mq$, $mq$easy$mq$),
($mq$Why does powdered marble react faster with acid than a marble chip of the same mass?$mq$, $mq$["Powder has a larger surface area","Powder has more mass","Powder is hotter","Powder is a different chemical"]$mq$, 0, $mq$More surface is exposed, so there are more collisions per second.$mq$, $mq$easy$mq$),
($mq$According to collision theory, why does a higher temperature increase the rate of reaction?$mq$, $mq$["Particles become larger","The number of particles increases","Particles collide with less energy","Particles collide more often and more of the collisions have enough energy to react"]$mq$, 3, $mq$Both the frequency and the energy of collisions increase.$mq$, $mq$medium$mq$),
($mq$Why does a higher concentration increase the rate of a reaction?$mq$, $mq$["Each particle moves faster","The activation energy is lower","There are more particles in the same volume, so collisions are more frequent","The particles are heavier"]$mq$, 2, $mq$Concentration changes the number of particles per volume, not their speed.$mq$, $mq$medium$mq$),
($mq$A reaction makes 48 cm³ of gas in 60 seconds. What is the mean rate of reaction?$mq$, $mq$["1.25 cm³/s","0.80 cm³/s","2880 cm³/s","12 cm³/s"]$mq$, 1, $mq$Rate = volume ÷ time = 48 ÷ 60 = 0.80 cm³ per second.$mq$, $mq$medium$mq$),
($mq$On a graph of gas volume against time, the line levels off. What does this show?$mq$, $mq$["One reactant has been used up and the reaction has stopped","The reaction has just started","The catalyst was used up","The temperature is falling to zero"]$mq$, 0, $mq$When the limiting reactant is gone, no more gas forms.$mq$, $mq$medium$mq$),
($mq$The time for a reaction at 20, 30, 40 and 50 °C is 80, 40, 20 and 10 s. Following the pattern, what time is predicted at 60 °C?$mq$, $mq$["0 s","15 s","40 s","5 s"]$mq$, 3, $mq$The time halves for each 10 °C rise, so 10 ÷ 2 = 5 s. Extrapolating assumes the pattern continues.$mq$, $mq$medium$mq$),
($mq$A student investigates how concentration affects rate. Which variable must be kept the same?$mq$, $mq$["The concentration of acid","The time for the reaction to finish","The temperature and the mass of metal","The rate of reaction"]$mq$, 2, $mq$Only the independent variable (concentration) changes.$mq$, $mq$medium$mq$),
($mq$Which pair is correctly matched?$mq$, $mq$["Hand warmer: endothermic; cold pack: exothermic","Hand warmer: exothermic; instant cold pack: endothermic","Both are exothermic","Both are endothermic"]$mq$, 1, $mq$A hand warmer releases heat, and a cold pack absorbs it.$mq$, $mq$medium$mq$),
($mq$Which statement about enzymes is correct?$mq$, $mq$["They are biological catalysts that speed up reactions in living things","They are used up in the reaction","They only work at very high temperatures","They slow down digestion"]$mq$, 0, $mq$Enzymes are protein catalysts and work best at their optimum temperature.$mq$, $mq$medium$mq$),
($mq$Why is burning a fuel exothermic in terms of bonds?$mq$, $mq$["More energy is needed to make bonds than to break them","No bonds are broken","Atoms are destroyed and release energy","More energy is released making new bonds than is needed to break old bonds"]$mq$, 3, $mq$The net difference is released as heat.$mq$, $mq$hard$mq$),
($mq$Magnesium reacts with acid. With 1 mol/dm³ acid 20 cm³ of gas is collected in the first 30 s; with 2 mol/dm³ acid 40 cm³ is collected. Which conclusion is best supported?$mq$, $mq$["The rate is unaffected by concentration","Concentration halves the rate","Doubling the concentration doubled the initial rate under these conditions","More acid always gives more gas in total"]$mq$, 2, $mq$The rate of gas production in the first 30 s doubled. Only two concentrations are tested so a general rule is not proven.$mq$, $mq$hard$mq$),
($mq$A student compares marble chips and powdered marble but uses 5 g of chips and 2 g of powder. What is the main flaw?$mq$, $mq$["The powder is too fine to react","Two variables changed, so the result is not a fair test","The chips will not react","The acid must be removed"]$mq$, 1, $mq$Both surface area and mass differ, so the effect cannot be attributed to surface area alone.$mq$, $mq$hard$mq$),
($mq$50 g of solution (specific heat capacity 4.2 J/g°C) rises from 20.0 °C to 26.5 °C in a reaction. How much energy was transferred to the solution and is the reaction exothermic or endothermic?$mq$, $mq$["1365 J; exothermic","1365 J; endothermic","210 J; exothermic","325 J; endothermic"]$mq$, 0, $mq$Q = m × c × ΔT = 50 × 4.2 × 6.5 = 1365 J. The temperature rose, so energy was released: exothermic.$mq$, $mq$hard$mq$),
($mq$Flour in a bag does not explode but flour dust in air can. What best explains this?$mq$, $mq$["Dust is made of a different chemical","Dust has a lower mass","Dust particles are cooler","The dust has a huge surface area, so it can react extremely fast, releasing energy and gas rapidly"]$mq$, 3, $mq$Rate depends on surface area. A very fast, exothermic reaction in a confined space causes an explosion.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Rates of Reaction and Energy Changes$mq$ and p.name = $mq$Chemical Reactions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Rate of reaction$mq$, $mq$How fast reactants are used up or products formed; rate = amount of product ÷ time.$mq$),
($mq$Collision theory$mq$, $mq$Reactions happen when particles collide with enough energy. More frequent or more energetic collisions give a faster rate.$mq$),
($mq$Effect of temperature on rate$mq$, $mq$Higher temperature: particles move faster, collide more often and more collisions have enough energy.$mq$),
($mq$Effect of surface area$mq$, $mq$Larger surface area (powder) exposes more particles, so more collisions per second and a faster rate.$mq$),
($mq$Effect of concentration$mq$, $mq$Higher concentration means more particles per volume, so more frequent collisions and a faster rate.$mq$),
($mq$Catalyst$mq$, $mq$Speeds up a reaction by giving an alternative pathway with lower activation energy; not used up.$mq$),
($mq$Exothermic reaction$mq$, $mq$Releases energy to the surroundings; temperature rises (e.g. combustion, hand warmers).$mq$),
($mq$Endothermic reaction$mq$, $mq$Absorbs energy from the surroundings; temperature falls (e.g. thermal decomposition, cold packs).$mq$),
($mq$Energy transferred formula$mq$, $mq$Q = m × c × ΔT (mass × specific heat capacity × temperature change).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Rates of Reaction and Energy Changes$mq$ and p.name = $mq$Chemical Reactions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## How fast do reactions go?
The **rate of reaction** is how quickly reactants are used up or products formed. We can measure it by the volume of gas produced per second, the loss of mass per second, or the time for a change such as a cloudy mark to disappear. Rate = amount of product ÷ time. For example, 48 cm³ of gas in 60 s is 48 ÷ 60 = 0.80 cm³/s.

## Collision theory
Particles must collide with enough energy to react. Anything that makes collisions more frequent, or more energetic, raises the rate.
- **Temperature**: particles move faster, so they collide more often and a greater proportion of collisions have enough energy.
- **Concentration** (or pressure for gases): more particles in the same volume mean more frequent collisions.
- **Surface area**: breaking a solid into a powder exposes more particles, so more collisions can happen at once.
- **Catalyst**: gives an alternative pathway with a lower activation energy, so more collisions are successful. A catalyst is not used up. Enzymes are biological catalysts.

## Reading rate graphs
On a graph of volume of gas against time, the steepest section is the fastest rate. When the line levels off, one reactant has run out. A steeper line at the start means a faster reaction. Total volume depends on the amount of the limiting reactant, not on the rate.

## Fair testing
Change only one variable, keep all the others constant, and take repeat readings. In a concentration experiment, control the temperature, the mass and surface area of solid, and the volume of acid. A common flaw is changing two things at once.

## Energy changes
In an **exothermic** reaction energy is transferred to the surroundings, so the temperature rises. Examples are burning, neutralisation and hand warmers. In an **endothermic** reaction energy is taken in, so the temperature falls. Examples are thermal decomposition and instant cold packs. Energy is needed to break bonds and released when new bonds form. If more energy is released than taken in, the reaction is exothermic.

The energy transferred to a solution can be estimated using Q = m × c × ΔT. For 50 g of solution (c = 4.2 J/g°C) rising by 6.5 °C, Q = 50 × 4.2 × 6.5 = 1365 J.

## Science in society
Industry uses catalysts to save energy and cost. Catalytic converters in cars change toxic gases into safer ones. Flour mills must control dust because the huge surface area makes it explosive. Hand warmers and cold packs rely on energy changes.

## Common mistakes
- Saying that higher temperature gives particles more energy and so they "want" to react. Say collisions are more frequent and more energetic.
- Saying that a catalyst takes part permanently.
- Mixing up the rate and the total amount of product.

## How this is examined
Typical eAssessment tasks give a table of times or volumes, ask you to plot or describe the trend, predict a value, explain using collision theory, identify the flaw in a method, and evaluate the safety and societal impact.

Exam tip: Link every explanation of rate to collisions: they must be more frequent or more energetic. Do not just say that particles "move faster".$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('integrated-science')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;