-- Part 3 of 3: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Mixtures and Materials > Metals and Non-metals Compared
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Mixtures and Materials$mq$, 5, 3 from public.subjects s where s.slug = $mq$chemistry$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Metals and Non-metals Compared$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$chemistry$mq$ and p.grade = 5 and p.name = $mq$Mixtures and Materials$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Metals and Non-metals Compared$mq$ and p.name = $mq$Mixtures and Materials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which of these is a good conductor of electricity?$mq$, $mq$["Copper","Sulfur","Diamond","Oxygen"]$mq$, 0, $mq$Copper is a metal with delocalised electrons.$mq$, $mq$easy$mq$),
($mq$Which property is typical of a solid non-metal?$mq$, $mq$["Malleable","Shiny","Ductile","Brittle"]$mq$, 3, $mq$Solid non-metals such as sulfur break or crumble when hit.$mq$, $mq$easy$mq$),
($mq$What type of ion do metal atoms usually form?$mq$, $mq$["Negative ions","No ions","Positive ions","Neutral molecules"]$mq$, 2, $mq$Metals lose electrons to form positive ions.$mq$, $mq$easy$mq$),
($mq$When a soluble metal oxide dissolves in water, the solution is usually...$mq$, $mq$["Acidic","Alkaline","Neutral","Orange"]$mq$, 1, $mq$Metal oxides are basic, and soluble ones form alkaline hydroxide solutions.$mq$, $mq$easy$mq$),
($mq$Which metal is liquid at room temperature (about 20 °C)?$mq$, $mq$["Mercury","Iron","Sodium","Aluminium"]$mq$, 0, $mq$Mercury is the only common metal that is liquid at room temperature.$mq$, $mq$easy$mq$),
($mq$An unknown solid is dull, brittle, melts at 115 °C and does not conduct electricity. What type of element is it most likely to be?$mq$, $mq$["Metal","Alloy","Noble metal","Non-metal"]$mq$, 3, $mq$These properties match a non-metal such as sulfur.$mq$, $mq$medium$mq$),
($mq$Graphite is a non-metal that conducts electricity. What is the reason?$mq$, $mq$["It contains metal atoms","It has free ions","It has delocalised electrons between its layers","It has no electrons"]$mq$, 2, $mq$Each carbon atom in graphite uses only three bonds, leaving a delocalised electron that can move.$mq$, $mq$medium$mq$),
($mq$Sulfur is burnt in air and the gas formed is dissolved in water. What is the pH of the solution likely to be?$mq$, $mq$["Exactly 7","Less than 7","Greater than 7","14"]$mq$, 1, $mq$Sulfur dioxide is an acidic non-metal oxide and forms an acidic solution.$mq$, $mq$medium$mq$),
($mq$Magnesium is added to dilute hydrochloric acid. Which gas forms and how is it tested?$mq$, $mq$["Hydrogen, squeaky pop with a lit splint","Oxygen, relights a glowing splint","Carbon dioxide, limewater milky","Chlorine, bleaches litmus"]$mq$, 0, $mq$Metals react with acids to make a salt and hydrogen. Hydrogen gives a squeaky pop.$mq$, $mq$medium$mq$),
($mq$Element W conducts, is malleable, melts at 1085 °C. Element X is brittle, melts at 115 °C, does not conduct. Which statement is correct?$mq$, $mq$["W is a non-metal and X is a metal","Both are metals","Both are non-metals","W is a metal and X is a non-metal"]$mq$, 3, $mq$Conduction, malleability and a high melting point are metal properties, while brittleness and low melting point suggest a non-metal.$mq$, $mq$medium$mq$),
($mq$Which pair is correctly matched with its type of bonding?$mq$, $mq$["Carbon dioxide: ionic","Sodium and chlorine atoms share electrons","Sodium chloride: ionic","Water: ionic"]$mq$, 2, $mq$Metal plus non-metal gives ionic bonding. Two non-metals share electrons in covalent bonds.$mq$, $mq$medium$mq$),
($mq$Which oxide would give an acidic solution in water?$mq$, $mq$["Sodium oxide","Carbon dioxide","Calcium oxide","Magnesium oxide"]$mq$, 1, $mq$Carbon dioxide, a non-metal oxide, forms carbonic acid. The others are basic metal oxides.$mq$, $mq$medium$mq$),
($mq$Silicon is used in computer chips. Why is it called a metalloid?$mq$, $mq$["It has properties between metals and non-metals","It is a liquid metal","It is always a gas","It has no properties"]$mq$, 0, $mq$Metalloids such as silicon are semiconductors and have mixed properties.$mq$, $mq$medium$mq$),
($mq$Why are metals malleable but ionic compounds such as sodium chloride brittle?$mq$, $mq$["Ionic compounds are softer","Metals contain no ions","Ionic compounds do not have bonds","Sliding ionic layers bring like charges together so they repel and the crystal shatters, while metal layers slide with electrons still bonding"]$mq$, 3, $mq$In a metal the electron sea holds the layers together as they slide. In an ionic crystal, a shift lines up like charges, which repel.$mq$, $mq$hard$mq$),
($mq$Element Q lights a bulb in a circuit. Its oxide dissolves in water to form a solution with pH 12. What is the best conclusion?$mq$, $mq$["Q is probably a non-metal","Q is a noble gas","Q is probably a metal","Q is a compound"]$mq$, 2, $mq$Conducting electricity and forming a basic oxide are typical metal properties.$mq$, $mq$hard$mq$),
($mq$A student says carbon is a metal because graphite conducts. What is the best evaluation?$mq$, $mq$["Right: all conductors are metals","Wrong: carbon is a non-metal; graphite conducts by delocalised electrons, but carbon forms an acidic oxide","Right: graphite is shiny","Wrong: graphite is a gas"]$mq$, 1, $mq$One property is not enough. Carbon forms an acidic oxide (CO₂), is brittle and not malleable, so it is a non-metal.$mq$, $mq$hard$mq$),
($mq$Which observation best shows that an oxide is basic?$mq$, $mq$["It reacts with dilute hydrochloric acid to make a salt and water","It is a gas","It is colourless","It dissolves in water to give pH 3"]$mq$, 0, $mq$Basic oxides neutralise acids. This works even for oxides that do not dissolve in water.$mq$, $mq$hard$mq$),
($mq$Atom X has electron arrangement 2,8,2 and atom Y has 2,8,6. What compound would you predict them to form and why?$mq$, $mq$["XY, covalent: both share 2","X₂Y: X loses 1 electron","No compound forms","XY, ionic: X loses 2 electrons and Y gains 2"]$mq$, 3, $mq$X is a metal that gives away 2 electrons (X²⁺), Y is a non-metal that gains 2 (Y²⁻). Charges balance in a 1 : 1 ratio.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Metals and Non-metals Compared$mq$ and p.name = $mq$Mixtures and Materials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Typical physical properties of metals$mq$, $mq$Shiny, malleable, ductile, good conductors, high melting points, high density, sonorous.$mq$),
($mq$Typical physical properties of non-metals$mq$, $mq$Dull, brittle if solid, poor conductors, low melting and boiling points, low density.$mq$),
($mq$Ions formed by metals and non-metals$mq$, $mq$Metals lose electrons to form positive ions. Non-metals gain electrons to form negative ions.$mq$),
($mq$Metal oxides$mq$, $mq$Basic: they react with acids and soluble ones form alkaline solutions.$mq$),
($mq$Non-metal oxides$mq$, $mq$Acidic: they dissolve in water to form acidic solutions, e.g. CO₂ and SO₂.$mq$),
($mq$Metal + acid$mq$, $mq$Gives a salt and hydrogen. Hydrogen gives a squeaky pop with a lit splint.$mq$),
($mq$Why does graphite conduct?$mq$, $mq$Each carbon has a delocalised electron between layers that can carry charge.$mq$),
($mq$What is a metalloid?$mq$, $mq$An element with properties between metals and non-metals, such as silicon, used as a semiconductor.$mq$),
($mq$Bonding between metals and non-metals$mq$, $mq$Ionic bonding, by transfer of electrons. Two non-metals share electrons in covalent bonds.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Metals and Non-metals Compared$mq$ and p.name = $mq$Mixtures and Materials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Elements can be sorted into metals and non-metals using their physical and chemical properties and their position in the periodic table. Most elements are metals, found on the left and centre. Non-metals are on the right, with hydrogen as an exception that sits at the top.

## Physical properties
Metals:
- Good conductors of heat and electricity
- Shiny when polished
- Malleable and ductile
- High melting and boiling points (mercury is the exception, a liquid at room temperature)
- High density, and sonorous

Non-metals:
- Poor conductors of heat and electricity (graphite is an exception)
- Dull when solid
- Brittle when solid
- Low melting and boiling points; many are gases at room temperature
- Low density

Metalloids, such as silicon, have properties in between and are used as semiconductors.

## Chemical properties
- **Ions**: metals lose electrons to form positive ions (Na⁺, Mg²⁺). Non-metals gain electrons to form negative ions (Cl⁻, O²⁻) or share electrons in covalent bonds.
- **Oxides**: metal oxides are basic, so they neutralise acids. Soluble ones form alkaline solutions, for example sodium oxide in water gives sodium hydroxide. Non-metal oxides are acidic, for example carbon dioxide and sulfur dioxide dissolve in water to form acidic solutions.
- **Reaction with acids**: many metals react with dilute acids to give a salt and hydrogen, such as magnesium + hydrochloric acid → magnesium chloride + hydrogen. Hydrogen gives a squeaky pop. Non-metals do not usually react with dilute acids.
- **Bonding**: a metal combined with a non-metal gives an ionic compound. Two non-metals form covalent molecules.

## Predicting from electron arrangements
The number of electrons in the outer shell tells you a lot. An atom with the arrangement 2,8,2 has two outer electrons, so it is a metal that loses them to form a 2+ ion. An atom with 2,8,6 has six outer electrons and gains two to form a 2− ion, so it is a non-metal. They would form an ionic compound in a 1 : 1 ratio.

## Special cases
- Graphite is a non-metal that conducts electricity because each carbon atom has a delocalised electron.
- Diamond is a non-metal that does not conduct and is very hard.
- Mercury is a metal with a low melting point.
- Metals vary: sodium is soft and reactive, while iron is hard and less reactive.

## Common mistakes
- Using one property as proof. Always use several properties.
- Saying all non-metals are gases. Carbon, sulfur and iodine are solids, and bromine is a liquid.
- Mixing up which oxides are acidic and basic: metal oxides are basic and non-metal oxides are acidic.

## How this is examined
Questions often show a table of properties of four unknown elements or ask you to compare two materials for a purpose. You may need to classify elements, explain the evidence for your choice, predict ions and bonding, and evaluate an argument that uses only one property.

Exam tip: To classify an element, quote at least two pieces of evidence, such as electrical conductivity and the acidity of its oxide, and point out any exception like graphite.$mq$ from st;

-- Chemical Equilibrium > Reversible Reactions and Dynamic Equilibrium
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Chemical Equilibrium$mq$, 5, 4 from public.subjects s where s.slug = $mq$chemistry$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Reversible Reactions and Dynamic Equilibrium$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$chemistry$mq$ and p.grade = 5 and p.name = $mq$Chemical Equilibrium$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Reversible Reactions and Dynamic Equilibrium$mq$ and p.name = $mq$Chemical Equilibrium$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which symbol shows that a reaction is reversible?$mq$, $mq$["⇌","→","=","↑"]$mq$, 0, $mq$The double arrow ⇌ shows that the reaction can go both forwards and backwards.$mq$, $mq$easy$mq$),
($mq$Hydrated copper(II) sulfate is heated until it turns white. What colour was it at the start?$mq$, $mq$["Green","Black","Yellow","Blue"]$mq$, 3, $mq$Hydrated copper(II) sulfate is blue. Heating drives off water to leave white anhydrous copper(II) sulfate.$mq$, $mq$easy$mq$),
($mq$Water is added to white anhydrous copper(II) sulfate. What do you see?$mq$, $mq$["It stays white","It turns black","It turns blue","It turns pink"]$mq$, 2, $mq$The reaction reverses and hydrated blue crystals form. This is a test for water.$mq$, $mq$easy$mq$),
($mq$What is true about the rates of the forward and reverse reactions at dynamic equilibrium?$mq$, $mq$["The forward rate is zero","They are equal","The reverse rate is zero","The forward rate is always larger"]$mq$, 1, $mq$At equilibrium the two rates are equal, so there is no overall change in amounts.$mq$, $mq$easy$mq$),
($mq$What is needed for a reversible reaction to reach equilibrium?$mq$, $mq$["A closed system","An open container","A catalyst","High pressure"]$mq$, 0, $mq$If substances can escape, the system cannot settle at equilibrium.$mq$, $mq$easy$mq$),
($mq$At equilibrium, the concentrations of reactants and products are...$mq$, $mq$["Equal","Zero for the reactants","Increasing","Constant"]$mq$, 3, $mq$Concentrations stay constant. They are not necessarily equal.$mq$, $mq$medium$mq$),
($mq$CaCO₃ ⇌ CaO + CO₂ is heated in an open test tube. Why does it not reach equilibrium?$mq$, $mq$["Calcium carbonate is a liquid","The reaction needs oxygen","CO₂ escapes so the reverse reaction cannot happen","The temperature is too low"]$mq$, 2, $mq$Equilibrium needs a closed system. In an open tube the gas escapes and the reaction goes to completion.$mq$, $mq$medium$mq$),
($mq$N₂O₄ (colourless) ⇌ 2NO₂ (brown) is sealed in a tube. At equilibrium the brown colour stops changing. Which statement explains this?$mq$, $mq$["Both reactions have stopped","Both reactions continue at the same rate","Only the forward reaction continues","Only the reverse reaction continues"]$mq$, 1, $mq$Equilibrium is dynamic. The colour is constant because NO₂ is formed as fast as it is used.$mq$, $mq$medium$mq$),
($mq$The concentration of ammonia (mol/dm³) at times 0, 2, 4, 6, 8, 10 min is 0.0, 0.3, 0.5, 0.6, 0.6, 0.6. When is equilibrium reached?$mq$, $mq$["After 6 min","After 2 min","After 4 min","After 10 min"]$mq$, 0, $mq$The concentration stops changing from 6 minutes onward, so equilibrium is reached at about 6 minutes.$mq$, $mq$medium$mq$),
($mq$Which change is easily reversible?$mq$, $mq$["Burning a piece of paper","Frying an egg","Rusting of iron","Heating hydrated copper(II) sulfate"]$mq$, 3, $mq$Hydrated copper(II) sulfate loses water on heating and regains it when water is added. The others are irreversible.$mq$, $mq$medium$mq$),
($mq$Ammonium chloride is heated in a test tube and white solid forms again near the cool top of the tube. What happens?$mq$, $mq$["The solid melts","Water condenses","Ammonia and hydrogen chloride recombine on cooling","Carbon dioxide forms"]$mq$, 2, $mq$NH₄Cl ⇌ NH₃ + HCl. The gases recombine into solid ammonium chloride where it is cooler.$mq$, $mq$medium$mq$),
($mq$A reaction starts with only reactants. Which describes the rates as equilibrium is approached?$mq$, $mq$["Both rates rise","Forward rate falls and reverse rate rises until equal","Both rates fall to zero","Forward rate rises and reverse falls"]$mq$, 1, $mq$Reactants are used up so the forward rate falls, while the products build up, so the reverse rate rises.$mq$, $mq$medium$mq$),
($mq$A student says that at equilibrium the reaction has stopped. What is the best correction?$mq$, $mq$["Reactions continue in both directions at equal rates","Reactions are faster","The system is open","Equilibrium means 100% product"]$mq$, 0, $mq$The macroscopic properties are constant, but molecules keep reacting in both directions.$mq$, $mq$medium$mq$),
($mq$1.0 mol of N₂O₄ is sealed in a vessel. At equilibrium 0.60 mol of N₂O₄ remains. What amount of NO₂ is present? (N₂O₄ ⇌ 2NO₂)$mq$, $mq$["0.40 mol","0.60 mol","1.2 mol","0.80 mol"]$mq$, 3, $mq$0.40 mol N₂O₄ reacted. The ratio is 1 : 2, so 0.80 mol NO₂ formed.$mq$, $mq$hard$mq$),
($mq$A small amount of labelled N₂O₄ is added to an equilibrium mixture. Later labelled NO₂ is found. What does this show?$mq$, $mq$["The reaction has stopped","The reaction is irreversible","Both reactions are still happening","The system is open"]$mq$, 2, $mq$Labelled atoms moving between N₂O₄ and NO₂ show that the forward and reverse reactions continue.$mq$, $mq$hard$mq$),
($mq$At equilibrium a mixture has [A] = 0.2 mol/dm³ and [B] = 0.8 mol/dm³ for A ⇌ B. Which conclusion is correct?$mq$, $mq$["The reaction has not started","Equilibrium lies mainly towards B","Equilibrium lies towards A","Concentrations must be equal"]$mq$, 1, $mq$There is more B than A at equilibrium, so the position lies towards B. Equilibrium does not require equal amounts.$mq$, $mq$hard$mq$),
($mq$Bromine liquid and vapour are in a sealed flask. The colour of the vapour and the level of liquid stay constant. Which statement is correct?$mq$, $mq$["Br₂(l) ⇌ Br₂(g) is in dynamic equilibrium, with evaporation and condensation equal in rate","Evaporation has stopped","Condensation has stopped","The flask must be open"]$mq$, 0, $mq$Physical changes can also reach equilibrium in a closed system.$mq$, $mq$hard$mq$),
($mq$A catalyst is added to a system at equilibrium. What happens?$mq$, $mq$["Only the forward rate increases","The equilibrium shifts to products","The system becomes open","Both rates increase equally and the position is unchanged"]$mq$, 3, $mq$A catalyst speeds up both reactions equally, so equilibrium is reached faster but the position does not change.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Reversible Reactions and Dynamic Equilibrium$mq$ and p.name = $mq$Chemical Equilibrium$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Reversible reaction$mq$, $mq$A reaction in which products can react to form the reactants again, shown by ⇌.$mq$),
($mq$Dynamic equilibrium$mq$, $mq$Forward and reverse reactions continue at equal rates in a closed system, so concentrations stay constant.$mq$),
($mq$Must concentrations be equal at equilibrium?$mq$, $mq$No. They are constant, not necessarily equal.$mq$),
($mq$Why is a closed system needed?$mq$, $mq$If substances can escape, the reverse reaction cannot keep pace and equilibrium is not reached.$mq$),
($mq$Hydrated copper(II) sulfate reaction$mq$, $mq$Blue hydrated crystals ⇌ white anhydrous powder + water. Used as a test for water.$mq$),
($mq$N₂O₄ ⇌ 2NO₂$mq$, $mq$Colourless N₂O₄ and brown NO₂ form an equilibrium in a sealed tube; the colour becomes constant.$mq$),
($mq$Rates as equilibrium is approached$mq$, $mq$Forward rate falls, reverse rate rises until they are equal.$mq$),
($mq$Effect of a catalyst on equilibrium$mq$, $mq$Speeds up both reactions equally. Equilibrium is reached faster but the position does not change.$mq$),
($mq$Does reaction stop at equilibrium?$mq$, $mq$No. Both reactions continue; there is no overall change.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Reversible Reactions and Dynamic Equilibrium$mq$ and p.name = $mq$Chemical Equilibrium$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Many reactions go only one way: when you burn a piece of paper you cannot turn the ash back into paper. Others are **reversible**, meaning the products can react to re-form the reactants. We show this with the symbol ⇌.

## Reversible reactions
A classic example is hydrated copper(II) sulfate. Heating the blue crystals drives off the water and leaves a white powder. Adding water to the white powder turns it blue again and gives out heat. We can write this as hydrated copper(II) sulfate ⇌ anhydrous copper(II) sulfate + water. This is the basis of a simple test for water. Another example is ammonium chloride: NH₄Cl ⇌ NH₃ + HCl. When heated, the solid breaks down into two gases, but on the cooler part of the tube they recombine and white solid appears again.

## Dynamic equilibrium
If a reversible reaction takes place in a **closed system** (nothing can enter or escape), the mixture eventually reaches **dynamic equilibrium**. At this point:
- The rate of the forward reaction equals the rate of the reverse reaction.
- The concentrations of reactants and products are constant. They are not usually equal.
- The reactions have not stopped. Molecules keep reacting in both directions, which is why we call it dynamic.
- Macroscopic properties such as colour, pressure and density stay constant.

Think of a busy escalator with equal numbers of people going up and down. The number on each floor stays the same even though people are moving all the time.

## What happens in a graph
Start with only reactants. At first the forward rate is high because the reactant concentration is high, and the reverse rate is zero. As reactants are used up, the forward rate falls. As products build up, the reverse rate rises. Eventually the two rates are equal. On a concentration-time graph both lines level off. If the concentration of ammonia is 0.0, 0.3, 0.5, 0.6, 0.6, 0.6 mol/dm³ at 0, 2, 4, 6, 8 and 10 minutes, equilibrium is reached at about 6 minutes.

## Position of equilibrium
Where the equilibrium lies depends on the reaction. If there is much more product than reactant, we say it lies to the right. If there is more reactant, it lies to the left.

Worked example: N₂O₄ ⇌ 2NO₂. Start with 1.0 mol N₂O₄. At equilibrium 0.60 mol remains. Amount reacted = 0.40 mol. Because of the 1 : 2 ratio, NO₂ formed = 0.80 mol.

## Open and closed systems
In an open container, a gas can escape and the system cannot reach equilibrium. Heating calcium carbonate in an open tube produces CO₂ that escapes, so the reaction goes to completion. In a sealed vessel the same reaction would reach equilibrium.

## Catalysts
A catalyst speeds up both the forward and the reverse reactions equally. It helps the system reach equilibrium faster but does not change the position of equilibrium.

## Common mistakes
- Saying the reaction has stopped at equilibrium.
- Saying that the concentrations are equal. They are constant, not necessarily equal.
- Forgetting that equilibrium needs a closed system.

## How this is examined
Questions give data such as a concentration-time table or a colour change in a sealed tube. You may be asked to identify when equilibrium is reached, explain why the colour stops changing, calculate amounts using the equation, and justify why an open system is different from a closed one.

Exam tip: When explaining equilibrium, always mention three things: closed system, equal rates of forward and reverse reactions, and constant concentrations.$mq$ from st;

-- Chemical Equilibrium > Changing Conditions and the Haber Process
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Chemical Equilibrium$mq$, 5, 4 from public.subjects s where s.slug = $mq$chemistry$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Changing Conditions and the Haber Process$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$chemistry$mq$ and p.grade = 5 and p.name = $mq$Chemical Equilibrium$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Changing Conditions and the Haber Process$mq$ and p.name = $mq$Chemical Equilibrium$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which two gases are the reactants in the Haber process?$mq$, $mq$["Nitrogen and hydrogen","Nitrogen and oxygen","Hydrogen and oxygen","Ammonia and hydrogen"]$mq$, 0, $mq$N₂ + 3H₂ ⇌ 2NH₃.$mq$, $mq$easy$mq$),
($mq$Which catalyst is used in the Haber process?$mq$, $mq$["Nickel","Platinum","Vanadium(V) oxide","Iron"]$mq$, 3, $mq$An iron catalyst is used. Nickel is used for hydrogenating oils.$mq$, $mq$easy$mq$),
($mq$What is the main use of the ammonia made by the Haber process?$mq$, $mq$["Making plastics","Making fuels","Making fertilisers","Making glass"]$mq$, 2, $mq$Most ammonia is converted into nitrogen fertilisers that help feed the world's population.$mq$, $mq$easy$mq$),
($mq$Where does the nitrogen for the Haber process come from?$mq$, $mq$["Crude oil","The air","Water","Limestone"]$mq$, 1, $mq$Air is about 78% nitrogen.$mq$, $mq$easy$mq$),
($mq$What effect does a catalyst have on the yield of ammonia at equilibrium?$mq$, $mq$["None, it only speeds up the rate","It increases the yield","It reduces the yield","It stops the reaction"]$mq$, 0, $mq$A catalyst speeds up both reactions equally and does not change the position of equilibrium.$mq$, $mq$easy$mq$),
($mq$The Haber process is N₂ + 3H₂ ⇌ 2NH₃. What happens to the yield of ammonia when pressure is increased?$mq$, $mq$["It decreases","It stays the same","It becomes zero","It increases"]$mq$, 3, $mq$There are 4 moles of gas on the left and 2 on the right, so higher pressure favours the right side.$mq$, $mq$medium$mq$),
($mq$Why is a very low temperature NOT used in the Haber process?$mq$, $mq$["Ammonia would decompose","The catalyst would melt","The rate would be too slow","The gases would escape"]$mq$, 2, $mq$The forward reaction is exothermic so low temperature favours yield, but the rate is too low to be economic.$mq$, $mq$medium$mq$),
($mq$Which set of conditions is typical for the Haber process?$mq$, $mq$["About 100 °C, 1 atm, no catalyst","About 450 °C, 200 atm, iron catalyst","About 1000 °C, 1 atm, nickel","About 25 °C, 500 atm, iron"]$mq$, 1, $mq$This is a compromise that balances yield, rate and cost.$mq$, $mq$medium$mq$),
($mq$In the Haber process, ammonia is cooled to a liquid and removed, and unreacted gases are recycled. Why does this improve the process?$mq$, $mq$["It shifts equilibrium to the right and reduces waste","It slows the reaction","It uses more energy","It destroys the catalyst"]$mq$, 0, $mq$Removing product makes the system form more ammonia, and recycling reactants uses them rather than wasting them.$mq$, $mq$medium$mq$),
($mq$The forward reaction in the Haber process is exothermic. What happens when the temperature is raised and the system is allowed to reach a new equilibrium?$mq$, $mq$["Yield increases","Yield stays the same","The reaction stops","Yield decreases"]$mq$, 3, $mq$Raising temperature favours the endothermic (reverse) direction, so less ammonia is at equilibrium.$mq$, $mq$medium$mq$),
($mq$Yield of ammonia at 200 atm (approximate): 300 °C: 66%, 400 °C: 36%, 500 °C: 18%. What conclusion fits the data?$mq$, $mq$["Higher temperature gives higher yield","Temperature has no effect","Higher temperature gives lower yield","The reaction is endothermic"]$mq$, 2, $mq$Yield falls as temperature rises, which supports an exothermic forward reaction.$mq$, $mq$medium$mq$),
($mq$N₂O₄ (colourless) ⇌ 2NO₂ (brown). The forward reaction is endothermic. What do you observe when the sealed tube is heated?$mq$, $mq$["The mixture becomes paler","The mixture becomes darker brown","No colour change","It becomes blue"]$mq$, 1, $mq$Heating favours the endothermic forward reaction, producing more NO₂.$mq$, $mq$medium$mq$),
($mq$More nitrogen is added to the Haber equilibrium mixture at constant temperature. What happens?$mq$, $mq$["More ammonia forms","Less ammonia forms","Nothing changes","Hydrogen increases"]$mq$, 0, $mq$Adding reactant shifts the equilibrium to the right to use some of it.$mq$, $mq$medium$mq$),
($mq$Why is pressure in the Haber process not raised as high as possible?$mq$, $mq$["High pressure lowers the yield","High pressure kills the catalyst","High pressure stops the reaction","High pressure is expensive and hazardous because equipment must be very strong"]$mq$, 3, $mq$Higher pressures cost more in equipment and energy and are more dangerous, so a compromise of about 200 atm is used.$mq$, $mq$hard$mq$),
($mq$At the same temperature and pressure, 60 dm³ of nitrogen reacts completely with excess hydrogen. What is the maximum volume of ammonia?$mq$, $mq$["60 dm³","90 dm³","120 dm³","180 dm³"]$mq$, 2, $mq$The equation gives 1 volume N₂ to 2 volumes NH₃, so the volume is 2 × 60 = 120 dm³.$mq$, $mq$hard$mq$),
($mq$Theoretical yield of ammonia from 28 g of nitrogen is 34 g. A plant obtains 6.8 g. What is the percentage yield?$mq$, $mq$["6.8%","20%","50%","80%"]$mq$, 1, $mq$Percentage yield = 6.8 ÷ 34 × 100 = 20%.$mq$, $mq$hard$mq$),
($mq$Which combination of conditions is the best compromise for ammonia manufacture?$mq$, $mq$["Moderate temperature, high pressure, iron catalyst","Very low temperature, low pressure, no catalyst","Very high temperature, low pressure, iron catalyst","Very low temperature, very high pressure, no catalyst"]$mq$, 0, $mq$A moderate temperature gives a reasonable rate and yield, high pressure raises yield, and a catalyst speeds up the reaction.$mq$, $mq$hard$mq$),
($mq$Only about 15% of the gases form ammonia on each pass through the reactor, yet the plant converts nearly all the nitrogen and hydrogen to ammonia overall. Why?$mq$, $mq$["The catalyst changes the equilibrium","The temperature is lowered","The reaction is irreversible","Ammonia is removed and unreacted gases are recycled back to the reactor"]$mq$, 3, $mq$Recycling gives unreacted nitrogen and hydrogen further chances to react, so overall conversion is high.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Changing Conditions and the Haber Process$mq$ and p.name = $mq$Chemical Equilibrium$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Haber process equation$mq$, $mq$N₂ + 3H₂ ⇌ 2NH₃. The forward reaction is exothermic.$mq$),
($mq$Haber process conditions$mq$, $mq$About 450 °C, about 200 atmospheres, iron catalyst.$mq$),
($mq$Effect of increasing pressure on the Haber equilibrium$mq$, $mq$Yield rises, because there are 4 gas molecules on the left and only 2 on the right.$mq$),
($mq$Effect of increasing temperature on the Haber equilibrium$mq$, $mq$Yield falls because the forward reaction is exothermic, though the rate increases.$mq$),
($mq$Why is 450 °C a compromise?$mq$, $mq$Lower temperatures give a better yield but too slow a rate; higher temperatures give a faster rate but a lower yield.$mq$),
($mq$Role of the iron catalyst$mq$, $mq$Speeds up the reaction so equilibrium is reached faster at a lower temperature; it does not change the yield.$mq$),
($mq$Why are unreacted gases recycled?$mq$, $mq$Only about 15% reacts per pass; recycling uses the reactants and gives a high overall conversion.$mq$),
($mq$Percentage yield formula$mq$, $mq$Actual yield ÷ theoretical yield × 100.$mq$),
($mq$Main use of ammonia$mq$, $mq$Making fertilisers; the environmental cost includes energy use and run-off causing eutrophication.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Changing Conditions and the Haber Process$mq$ and p.name = $mq$Chemical Equilibrium$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$When a system at equilibrium is disturbed, it responds in a way that reduces the effect of the change. This idea, often called Le Chatelier's principle, lets us predict what happens to the amount of product when we change concentration, pressure or temperature. It is used in industry to design the Haber process, which makes ammonia.

## Changing conditions
- **Concentration**: adding more of a reactant moves the equilibrium to the right to use some of it. Removing a product also moves it to the right to replace it.
- **Pressure** (for gases): increasing pressure favours the side with fewer gas molecules. Decreasing pressure favours the side with more.
- **Temperature**: raising the temperature favours the endothermic direction. Lowering it favours the exothermic direction.
- **Catalyst**: speeds up the forward and reverse reactions equally. It does not change the position or yield, but equilibrium is reached sooner.

Example: N₂O₄ (colourless) ⇌ 2NO₂ (brown) is endothermic in the forward direction. Heating a sealed tube makes the mixture darker, and cooling makes it paler.

## The Haber process
The equation is N₂ + 3H₂ ⇌ 2NH₃ and the forward reaction is exothermic. Nitrogen comes from the air and hydrogen is made from natural gas and steam. The gases are compressed and passed over an iron catalyst. Ammonia is cooled until it is a liquid and removed, and unreacted nitrogen and hydrogen are recycled.

Why the conditions are a compromise:
- **Pressure**: there are 4 gas molecules on the left and 2 on the right, so high pressure increases the yield. About 200 atmospheres is used. Even higher pressures would cost too much and be dangerous.
- **Temperature**: low temperature gives a better yield because the forward reaction is exothermic, but the rate would be far too slow. A temperature of about 450 °C gives a reasonable rate and acceptable yield.
- **Catalyst**: iron speeds up the reaction, so the lower temperature can be used, saving energy.

Under these conditions, only about 15% of the gas mixture is converted to ammonia each time it passes through the reactor, but recycling makes the overall conversion much higher.

## Calculations
Gas volumes at the same temperature and pressure follow the equation ratio. 60 dm³ of nitrogen reacts completely to give 120 dm³ of ammonia.
Percentage yield = actual yield ÷ theoretical yield × 100. If the theoretical yield is 34 g and 6.8 g is obtained, percentage yield = 6.8 ÷ 34 × 100 = 20%.

## Sustainability and impact
Ammonia fertilisers have greatly increased food production, but making them uses a lot of energy, mostly from fossil fuels, and releases carbon dioxide. Fertiliser run-off causes eutrophication in rivers and lakes. Evaluating the process means weighing food security against environmental costs.

## Common mistakes
- Saying a catalyst increases the yield. It does not.
- Forgetting to count only gas molecules when predicting the effect of pressure.
- Mixing up exothermic and endothermic when predicting the effect of temperature.
- Saying the best conditions are the ones with the highest yield, rather than a compromise with rate and cost.

## How this is examined
Typical tasks present a table of yields at different temperatures and pressures and ask you to describe trends, explain them using the idea of equilibrium, choose and justify the best conditions, calculate yields, and evaluate the wider impact of fertiliser production.

Exam tip: Structure explanations in three parts: what happens to the position of equilibrium, what happens to the rate, and why the industrial conditions are a compromise.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('chemistry')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;