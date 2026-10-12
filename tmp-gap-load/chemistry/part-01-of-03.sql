-- Part 1 of 3: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Naming and Classifying Organic Compounds > IUPAC Naming of Alkanes and Alkenes
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Naming and Classifying Organic Compounds$mq$, 5, 1 from public.subjects s where s.slug = $mq$chemistry$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$IUPAC Naming of Alkanes and Alkenes$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$chemistry$mq$ and p.grade = 5 and p.name = $mq$Naming and Classifying Organic Compounds$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$IUPAC Naming of Alkanes and Alkenes$mq$ and p.name = $mq$Naming and Classifying Organic Compounds$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which general formula represents the alkanes?$mq$, $mq$["CₙH₂ₙ₊₂","CₙH₂ₙ","CₙH₂ₙ₋₂","CₙHₙ"]$mq$, 0, $mq$Alkanes are saturated hydrocarbons with the general formula CₙH₂ₙ₊₂. CₙH₂ₙ is the alkene formula.$mq$, $mq$easy$mq$),
($mq$What is the name of the hydrocarbon with the formula C₃H₈?$mq$, $mq$["Propene","Butane","Ethane","Propane"]$mq$, 3, $mq$Three carbons gives the stem prop-, and C₃H₈ fits CₙH₂ₙ₊₂, so it is propane.$mq$, $mq$easy$mq$),
($mq$Why are alkenes described as unsaturated?$mq$, $mq$["They contain oxygen","They dissolve in water","They contain a C=C double bond","They have no hydrogen atoms"]$mq$, 2, $mq$Unsaturated means the molecule has at least one carbon-carbon double bond, so it holds fewer hydrogen atoms than the alkane with the same number of carbons.$mq$, $mq$easy$mq$),
($mq$A few drops of bromine water are shaken with an alkene. What do you observe?$mq$, $mq$["Colourless to orange","Orange to colourless","Orange to blue-black","No change at all"]$mq$, 1, $mq$Alkenes add bromine across the double bond, so the orange colour disappears. Alkanes give no change in the dark.$mq$, $mq$easy$mq$),
($mq$Which prefix in an organic name shows a chain of four carbon atoms?$mq$, $mq$["But-","Prop-","Pent-","Eth-"]$mq$, 0, $mq$The stems are meth-, eth-, prop-, but-, pent-, hex- for 1 to 6 carbons.$mq$, $mq$easy$mq$),
($mq$What is the molecular formula of hexane?$mq$, $mq$["C₆H₁₂","C₆H₁₀","C₅H₁₂","C₆H₁₄"]$mq$, 3, $mq$Hexane is an alkane with n = 6, so CₙH₂ₙ₊₂ gives C₆H₁₄.$mq$, $mq$medium$mq$),
($mq$What is the molecular formula of pentene?$mq$, $mq$["C₅H₁₂","C₅H₈","C₅H₁₀","C₄H₁₀"]$mq$, 2, $mq$Pentene is an alkene with n = 5, so CₙH₂ₙ gives C₅H₁₀.$mq$, $mq$medium$mq$),
($mq$What is the name of CH₃CH₂CH=CH₂?$mq$, $mq$["But-2-ene","But-1-ene","Propene","Butane"]$mq$, 1, $mq$There are four carbons so the stem is but-. The double bond starts at carbon 1 when numbering from the nearer end, giving but-1-ene.$mq$, $mq$medium$mq$),
($mq$What is the correct name of CH₃CH(CH₃)CH₃?$mq$, $mq$["2-methylpropane","Butane","Propane","1-methylpropane"]$mq$, 0, $mq$The longest chain has three carbons (propane) with a methyl branch on carbon 2, so it is 2-methylpropane.$mq$, $mq$medium$mq$),
($mq$Which products form when methane burns completely in plenty of oxygen?$mq$, $mq$["Carbon and water","Carbon monoxide and hydrogen","Carbon dioxide and hydrogen","Carbon dioxide and water"]$mq$, 3, $mq$Complete combustion of any hydrocarbon gives carbon dioxide and water.$mq$, $mq$medium$mq$),
($mq$Ethene reacts with bromine water at room temperature but ethane does not. What is the best explanation?$mq$, $mq$["Ethene is heavier than ethane","Ethane contains more carbon atoms","Ethene has a double bond that can open up and add atoms","Ethene is a liquid"]$mq$, 2, $mq$The C=C bond in ethene is reactive and can break to form two new single bonds. Ethane has only strong single bonds, so it does not add bromine.$mq$, $mq$medium$mq$),
($mq$Ethene reacts with bromine in an addition reaction. What is the product?$mq$, $mq$["Bromoethane","1,2-dibromoethane","Ethanol","Carbon dioxide"]$mq$, 1, $mq$One bromine atom adds to each carbon of the double bond, giving 1,2-dibromoethane. Only one product forms in addition reactions.$mq$, $mq$medium$mq$),
($mq$A hydrocarbon has the formula C₇H₁₄ and turns bromine water from orange to colourless. Which type of compound is it most likely to be?$mq$, $mq$["An alkene","An alkane","A carboxylic acid","An alcohol"]$mq$, 0, $mq$C₇H₁₄ fits CₙH₂ₙ and the bromine test is positive, so it is an alkene (heptene).$mq$, $mq$medium$mq$),
($mq$What is the name of CH₃CH₂CH(CH₃)CH₂CH₃?$mq$, $mq$["2-methylpentane","Hexane","2-ethylbutane","3-methylpentane"]$mq$, 3, $mq$The longest chain is five carbons (pentane). Numbering from either end puts the methyl branch on carbon 3, so it is 3-methylpentane.$mq$, $mq$hard$mq$),
($mq$Decane (C₁₀H₂₂) is cracked into octane and one other product. What is the formula of the other product?$mq$, $mq$["C₂H₆","C₂H₂","C₂H₄","CH₄"]$mq$, 2, $mq$Atoms must balance: C₁₀H₂₂ → C₈H₁₈ + C₂H₄. The product C₂H₄ is ethene, an alkene, which is why cracking makes alkenes.$mq$, $mq$hard$mq$),
($mq$A student gives these names. Which one is NOT a correct IUPAC name?$mq$, $mq$["2-methylbutane","1-methylpropane","2,2-dimethylpropane","3-methylhexane"]$mq$, 1, $mq$1-methylpropane is wrong because the chain would continue and the longest chain is four carbons, so the compound is really butane. A methyl group cannot sit on an end carbon.$mq$, $mq$hard$mq$),
($mq$Propane burns completely: C₃H₈ + 5O₂ → 3CO₂ + 4H₂O. What mass of carbon dioxide forms from 4.4 g of propane? (Mᵣ of propane = 44, Mᵣ of CO₂ = 44)$mq$, $mq$["13.2 g","4.4 g","8.8 g","17.6 g"]$mq$, 0, $mq$4.4 g ÷ 44 = 0.1 mol of propane. The ratio is 1 : 3, so 0.3 mol CO₂ forms, and 0.3 × 44 = 13.2 g.$mq$, $mq$hard$mq$),
($mq$Ignoring cis-trans differences, how many different unbranched alkenes have the formula C₅H₁₀?$mq$, $mq$["1","3","4","2"]$mq$, 3, $mq$The double bond can be in position 1 or 2 (pent-1-ene and pent-2-ene). Positions 3 and 4 just repeat the same molecules numbered from the other end.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$IUPAC Naming of Alkanes and Alkenes$mq$ and p.name = $mq$Naming and Classifying Organic Compounds$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Alkane general formula$mq$, $mq$CₙH₂ₙ₊₂. Alkanes are saturated hydrocarbons with only single C-C bonds, for example C₄H₁₀.$mq$),
($mq$Alkene general formula$mq$, $mq$CₙH₂ₙ. Alkenes are unsaturated hydrocarbons containing a C=C double bond, for example C₃H₆.$mq$),
($mq$Stems for 1 to 6 carbons$mq$, $mq$meth-, eth-, prop-, but-, pent-, hex-.$mq$),
($mq$Test for an alkene$mq$, $mq$Shake with bromine water. Alkene: orange to colourless. Alkane: stays orange.$mq$),
($mq$What does saturated mean?$mq$, $mq$Every carbon-carbon bond is a single bond, so the molecule holds as many hydrogen atoms as possible.$mq$),
($mq$Products of complete combustion of a hydrocarbon$mq$, $mq$Carbon dioxide and water.$mq$),
($mq$What is cracking?$mq$, $mq$Breaking large alkanes into smaller alkanes and alkenes using heat and a catalyst.$mq$),
($mq$How do you name a branched alkane?$mq$, $mq$Find the longest chain, number from the end giving lowest numbers, then write branch number and name before the stem, e.g. 2-methylbutane.$mq$),
($mq$What does but-2-ene tell you?$mq$, $mq$Four carbons in the chain and the double bond starts at carbon 2.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$IUPAC Naming of Alkanes and Alkenes$mq$ and p.name = $mq$Naming and Classifying Organic Compounds$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Organic chemistry is the chemistry of carbon compounds, and hydrocarbons are the simplest family. A hydrocarbon contains only carbon and hydrogen. In MYP 5 you need to recognise two homologous series, the alkanes and the alkenes, and name them using the IUPAC system, the agreed international method that makes sure every chemist uses the same name for the same molecule.

## The stems
The first part of a name tells you how many carbon atoms are in the longest continuous chain.
- **meth-** (1 carbon)
- **eth-** (2 carbons)
- **prop-** (3 carbons)
- **but-** (4 carbons)
- **pent-** (5 carbons)
- **hex-** (6 carbons)

## Alkanes
Alkanes are saturated: every carbon-carbon bond is a single bond. Their general formula is CₙH₂ₙ₊₂, so methane is CH₄, ethane is C₂H₆, propane is C₃H₈ and butane is C₄H₁₀. Names end in **-ane**. They are fairly unreactive, but they burn. In plenty of oxygen the products are carbon dioxide and water; in limited oxygen you can get carbon monoxide or carbon (soot).

## Alkenes
Alkenes are unsaturated: they contain at least one carbon-carbon double bond. Their general formula is CₙH₂ₙ and names end in **-ene**. Ethene is C₂H₄ and propene is C₃H₆. Because the double bond can open up, alkenes take part in addition reactions. The test for an alkene is bromine water: it changes from orange to colourless. Alkanes do not decolourise bromine water in the dark.

## Branches and positions
When the chain has a side group, follow these steps:
- Find the longest continuous chain of carbon atoms and name it.
- Number the chain from the end that gives the lowest numbers to the branches or the double bond.
- Name each branch (a one-carbon branch is methyl, a two-carbon branch is ethyl) and put its number first.
- Use di- or tri- if the same branch appears twice, such as 2,2-dimethylpropane.
- For alkenes, give the position of the double bond: but-1-ene has the double bond between carbons 1 and 2, but-2-ene between carbons 2 and 3.

Worked example: CH₃CH₂CH(CH₃)CH₂CH₃. The longest chain has five carbons, so the stem is pentane. The methyl group is on carbon 3 whichever end you count from, so the name is 3-methylpentane.

## Cracking
Large alkanes from crude oil are broken into smaller, more useful molecules by cracking, using heat and a catalyst. Cracking always makes at least one alkene. For example C₁₀H₂₂ → C₈H₁₈ + C₂H₄. Check that atoms balance on both sides.

## Common mistakes
- Choosing a chain that is not the longest. Always look for the longest path, even if it bends on the page.
- Numbering from the wrong end. Pick the direction that gives the smaller number.
- Forgetting the number for the double bond in alkenes with four or more carbons.
- Mixing up the formulae: alkanes CₙH₂ₙ₊₂, alkenes CₙH₂ₙ.

## How this is examined
Questions usually place the compounds in a context, for example a fuel company comparing a gas cylinder with a petrol sample, or a lab report where bromine water was added to two unknown liquids. You may be asked to name a structure, write the formula from the name, state what a colour change shows, explain why a reaction occurs, and evaluate whether a conclusion from the data is justified. Command terms such as state, identify, explain and justify tell you how much detail is needed.

Exam tip: When asked to name a compound, write the longest chain first, check the numbering gives the lowest numbers, and count atoms with the general formula to make sure your name matches the formula given.$mq$ from st;

-- Naming and Classifying Organic Compounds > Alcohols, Carboxylic Acids and Esters
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Naming and Classifying Organic Compounds$mq$, 5, 1 from public.subjects s where s.slug = $mq$chemistry$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Alcohols, Carboxylic Acids and Esters$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$chemistry$mq$ and p.grade = 5 and p.name = $mq$Naming and Classifying Organic Compounds$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Alcohols, Carboxylic Acids and Esters$mq$ and p.name = $mq$Naming and Classifying Organic Compounds$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which functional group is present in all alcohols?$mq$, $mq$["-OH","-COOH","-COO-","C=C"]$mq$, 0, $mq$Alcohols contain the hydroxyl group, -OH. -COOH is the carboxylic acid group.$mq$, $mq$easy$mq$),
($mq$What is the name of the alcohol with the formula C₂H₅OH?$mq$, $mq$["Methanol","Ethanoic acid","Propanol","Ethanol"]$mq$, 3, $mq$Two carbons give eth-, and the -OH group gives the ending -ol, so the name is ethanol.$mq$, $mq$easy$mq$),
($mq$Which functional group is present in carboxylic acids?$mq$, $mq$["-OH","C=C","-COOH","-COO-"]$mq$, 2, $mq$The carboxyl group, -COOH, is the functional group of carboxylic acids such as ethanoic acid.$mq$, $mq$easy$mq$),
($mq$Which property is typical of esters?$mq$, $mq$["Strong smell of vinegar","Sweet, fruity smell","Turn orange bromine water colourless","Strongly alkaline"]$mq$, 1, $mq$Many esters have pleasant, fruity smells and are used in flavourings and perfumes.$mq$, $mq$easy$mq$),
($mq$Which compound gives vinegar its sour taste?$mq$, $mq$["Ethanoic acid","Ethanol","Ethyl ethanoate","Ethene"]$mq$, 0, $mq$Vinegar is a dilute solution of ethanoic acid.$mq$, $mq$easy$mq$),
($mq$What is the molecular formula of propan-1-ol?$mq$, $mq$["C₃H₆O","C₃H₇O₂","C₂H₆O","C₃H₈O"]$mq$, 3, $mq$Propan-1-ol is CH₃CH₂CH₂OH, which has 3 carbon, 8 hydrogen and 1 oxygen atom: C₃H₈O.$mq$, $mq$medium$mq$),
($mq$Methanol reacts with ethanoic acid to make an ester. What is the name of the ester?$mq$, $mq$["Ethyl methanoate","Methyl methanoate","Methyl ethanoate","Ethyl ethanoate"]$mq$, 2, $mq$The alkyl part comes from the alcohol (methyl) and the second part from the acid (ethanoate), giving methyl ethanoate.$mq$, $mq$medium$mq$),
($mq$An alcohol and a carboxylic acid are heated with a few drops of concentrated sulfuric acid. Which two products form?$mq$, $mq$["Ester and carbon dioxide","Ester and water","Alkene and water","Salt and hydrogen"]$mq$, 1, $mq$Esterification is a condensation reaction that produces an ester and water. The sulfuric acid is a catalyst.$mq$, $mq$medium$mq$),
($mq$Which set of conditions is used to make ethanol by fermentation of glucose?$mq$, $mq$["Yeast, about 30 °C, no oxygen","Nickel, 60 °C, hydrogen","Steam, 300 °C, catalyst","Yeast, 100 °C, plenty of air"]$mq$, 0, $mq$Yeast enzymes work best at warm temperatures (about 25-35 °C) and in the absence of air. Too hot kills the enzymes, and air allows further oxidation.$mq$, $mq$medium$mq$),
($mq$Two colourless liquids are labelled ethanol and ethanoic acid. Sodium carbonate is added to each. What do you expect?$mq$, $mq$["Both fizz","Neither fizzes","Only ethanol fizzes","Only ethanoic acid fizzes"]$mq$, 3, $mq$Carboxylic acids react with carbonates to give carbon dioxide, so they fizz. Alcohols do not.$mq$, $mq$medium$mq$),
($mq$Fermentation: C₆H₁₂O₆ → 2C₂H₅OH + 2CO₂. How many moles of ethanol form from 1 mole of glucose?$mq$, $mq$["1","4","2","6"]$mq$, 2, $mq$The balanced equation shows a 1 : 2 ratio of glucose to ethanol, so 2 mol.$mq$, $mq$medium$mq$),
($mq$Why is ethanoic acid classed as a weak acid?$mq$, $mq$["It has a low molecular mass","It only partly ionises in water","It does not contain hydrogen","It reacts with nothing"]$mq$, 1, $mq$A weak acid is only partially ionised in solution. Strength is about ionisation, not concentration.$mq$, $mq$medium$mq$),
($mq$What is the name of the ester CH₃CH₂COOCH₃?$mq$, $mq$["Methyl propanoate","Ethyl ethanoate","Propyl methanoate","Methyl ethanoate"]$mq$, 0, $mq$The part with C=O (CH₃CH₂COO-) comes from propanoic acid, and the group on the oxygen is methyl. The name is methyl propanoate.$mq$, $mq$medium$mq$),
($mq$Propanoic acid is warmed with ethanol and a little concentrated sulfuric acid. What is the ester called?$mq$, $mq$["Propyl ethanoate","Ethyl ethanoate","Propyl propanoate","Ethyl propanoate"]$mq$, 3, $mq$The alcohol (ethanol) gives ethyl, and the acid (propanoic acid) gives propanoate: ethyl propanoate.$mq$, $mq$hard$mq$),
($mq$9.2 g of ethanol (Mᵣ = 46) is completely oxidised to ethanoic acid (Mᵣ = 60). What is the theoretical mass of ethanoic acid?$mq$, $mq$["6.0 g","9.2 g","12.0 g","18.4 g"]$mq$, 2, $mq$9.2 ÷ 46 = 0.2 mol. The ratio is 1 : 1, so 0.2 mol acid forms and 0.2 × 60 = 12.0 g.$mq$, $mq$hard$mq$),
($mq$Liquid X has pH 3 and fizzes with sodium carbonate. Liquid Y has pH 7, does not fizz and burns with a clean flame. Which pair is correct?$mq$, $mq$["X ethanol, Y ethanoic acid","X ethanoic acid, Y ethanol","X ethanoic acid, Y ethyl ethanoate","Both are ethanol"]$mq$, 1, $mq$A low pH and fizzing with carbonate show an acid. A neutral, flammable liquid fits ethanol.$mq$, $mq$hard$mq$),
($mq$Ethanol can be made by fermentation or by hydrating ethene with steam. Which statement is correct?$mq$, $mq$["Hydration uses a non-renewable raw material but is fast and continuous","Fermentation is continuous and gives pure ethanol","Fermentation uses crude oil","Hydration is slow and works in batches"]$mq$, 0, $mq$Ethene comes from crude oil, which is finite, but hydration is rapid, continuous and gives pure ethanol. Fermentation uses renewable sugar but is slow, batch-based and makes a dilute mixture.$mq$, $mq$hard$mq$),
($mq$An ester is made by heating the reactants under reflux. What is the purpose of the reflux condenser?$mq$, $mq$["To remove water from the mixture","To cool the flask so no reaction occurs","To collect the ester as soon as it forms","To stop volatile liquids escaping by condensing vapours back into the flask"]$mq$, 3, $mq$Alcohols, acids and esters are volatile and flammable. Reflux lets the mixture be heated for a long time without losing liquid or vapour.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Alcohols, Carboxylic Acids and Esters$mq$ and p.name = $mq$Naming and Classifying Organic Compounds$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Functional group of alcohols$mq$, $mq$-OH (hydroxyl). Names end in -ol, e.g. ethanol C₂H₅OH.$mq$),
($mq$Functional group of carboxylic acids$mq$, $mq$-COOH (carboxyl). Names end in -oic acid, e.g. ethanoic acid CH₃COOH.$mq$),
($mq$Functional group of esters$mq$, $mq$-COO-. Esters often have sweet, fruity smells.$mq$),
($mq$How is an ester made?$mq$, $mq$Carboxylic acid + alcohol, with concentrated sulfuric acid catalyst and heat, gives ester + water.$mq$),
($mq$Name the ester from ethanol and ethanoic acid$mq$, $mq$Ethyl ethanoate. The alcohol gives the first word, the acid gives the second.$mq$),
($mq$Fermentation equation$mq$, $mq$C₆H₁₂O₆ → 2C₂H₅OH + 2CO₂, using yeast, about 25-35 °C, no oxygen.$mq$),
($mq$Why is ethanoic acid a weak acid?$mq$, $mq$It only partly ionises in water, so it has a pH of about 3 and fewer free H⁺ ions than a strong acid.$mq$),
($mq$Test to tell ethanoic acid from ethanol$mq$, $mq$Add sodium carbonate. The acid fizzes (CO₂ forms); ethanol does not.$mq$),
($mq$What happens when ethanol is oxidised?$mq$, $mq$It forms ethanoic acid, e.g. wine turning to vinegar.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Alcohols, Carboxylic Acids and Esters$mq$ and p.name = $mq$Naming and Classifying Organic Compounds$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Three families of carbon compounds are very common in everyday life: alcohols, carboxylic acids and esters. Each family has a functional group, the atom or group of atoms that decides how the molecule behaves. If you can spot the functional group you can predict the chemistry.

## Alcohols
Alcohols contain the **-OH** group and their names end in **-ol**. Methanol is CH₃OH, ethanol is C₂H₅OH and propanol is C₃H₇OH. Alcohols burn in air to give carbon dioxide and water, are used as fuels and solvents, and are neutral in solution (pH about 7).

Ethanol can be made in two main ways:
- **Fermentation**: yeast breaks down glucose without oxygen at about 25-35 °C. C₆H₁₂O₆ → 2C₂H₅OH + 2CO₂. It uses a renewable raw material, but is slow and gives a dilute mixture.
- **Hydration of ethene**: ethene reacts with steam using a catalyst. It is fast and continuous and gives pure ethanol, but ethene comes from crude oil, which is finite.

## Carboxylic acids
Carboxylic acids contain the **-COOH** group and their names end in **-oic acid**. Methanoic acid is HCOOH, ethanoic acid is CH₃COOH and propanoic acid is CH₃CH₂COOH. Ethanoic acid is the acid in vinegar. These are weak acids because they only partly ionise in water, so their pH is around 3 rather than 1. They still behave like acids: they react with metals to give hydrogen, with bases to give salts, and with carbonates to give carbon dioxide (fizzing). The carbonate test is a quick way to tell a carboxylic acid from an alcohol.

Ethanol can be oxidised to ethanoic acid. This is why wine left open to the air turns sour: microbes oxidise the ethanol.

## Esters
Esters contain the **-COO-** group and often smell sweet and fruity. They are made when a carboxylic acid reacts with an alcohol, with a few drops of concentrated sulfuric acid as a catalyst and gentle heating. Water is also produced:

carboxylic acid + alcohol ⇌ ester + water

To name an ester, the first word comes from the alcohol (ethanol gives ethyl) and the second from the acid (ethanoic acid gives ethanoate). Ethanol and ethanoic acid make ethyl ethanoate. Methanol and propanoic acid make methyl propanoate.

When making an ester in the lab, the mixture is heated under reflux. A condenser fitted vertically returns the vapours to the flask so that flammable liquids do not escape.

## Worked example
What mass of ethanoic acid forms when 4.6 g of ethanol (Mᵣ = 46) is fully oxidised? Moles of ethanol = 4.6 ÷ 46 = 0.10 mol. The ratio is 1 : 1, so 0.10 mol of acid forms. Mass = 0.10 × 60 = 6.0 g.

## Common mistakes
- Writing the acid part of an ester name first. The alcohol part comes first.
- Thinking a weak acid means a dilute acid. Weak describes ionisation, not concentration.
- Forgetting that water is produced in esterification.

## How this is examined
Expect a context such as a perfume maker, a brewery or a food lab. You may be asked to identify the functional group, name an ester from its parent compounds, describe a test to tell two liquids apart, or evaluate fermentation against hydration of ethene for sustainability and cost.

Exam tip: To tell the families apart, link each with its test: carboxylic acid fizzes with carbonate and has a pH below 7, alcohol does not fizz and is neutral, and an ester has a fruity smell.$mq$ from st;

-- Naming and Classifying Organic Compounds > Structural Formulae and Isomers
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Naming and Classifying Organic Compounds$mq$, 5, 1 from public.subjects s where s.slug = $mq$chemistry$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Structural Formulae and Isomers$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$chemistry$mq$ and p.grade = 5 and p.name = $mq$Naming and Classifying Organic Compounds$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Structural Formulae and Isomers$mq$ and p.name = $mq$Naming and Classifying Organic Compounds$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What are isomers?$mq$, $mq$["Compounds with the same molecular formula but different structures","Compounds with the same structure but different formulae","Atoms of the same element with different neutrons","Compounds in the same homologous series"]$mq$, 0, $mq$Isomers share a molecular formula but have their atoms arranged differently.$mq$, $mq$easy$mq$),
($mq$What does a displayed formula show?$mq$, $mq$["Only the number of each atom","Only the functional group","Only the carbon atoms","All the atoms and all the bonds"]$mq$, 3, $mq$A displayed formula draws every atom and every bond.$mq$, $mq$easy$mq$),
($mq$What is the molecular formula of butane?$mq$, $mq$["C₄H₈","C₃H₈","C₄H₁₀","C₅H₁₂"]$mq$, 2, $mq$Butane is an alkane with n = 4, so CₙH₂ₙ₊₂ gives C₄H₁₀.$mq$, $mq$easy$mq$),
($mq$Which pair of compounds are isomers?$mq$, $mq$["Ethane and ethene","Butane and 2-methylpropane","Methane and methanol","Propane and butane"]$mq$, 1, $mq$Both butane and 2-methylpropane have the formula C₄H₁₀ but different structures.$mq$, $mq$easy$mq$),
($mq$Which is the condensed formula of ethanol?$mq$, $mq$["CH₃CH₂OH","CH₃CH₃","CH₃COOH","CH₂CH₂"]$mq$, 0, $mq$Ethanol has a CH₃ group, a CH₂ group and an OH group: CH₃CH₂OH.$mq$, $mq$easy$mq$),
($mq$How many structural isomers does pentane (C₅H₁₂) have, including pentane itself?$mq$, $mq$["1","2","4","3"]$mq$, 3, $mq$The isomers are pentane, 2-methylbutane and 2,2-dimethylpropane.$mq$, $mq$medium$mq$),
($mq$What is the molecular formula of 2-methylbutane?$mq$, $mq$["C₄H₁₀","C₅H₁₀","C₅H₁₂","C₆H₁₄"]$mq$, 2, $mq$Four carbons in the main chain plus one methyl carbon is five carbons, and it is an alkane, so C₅H₁₂.$mq$, $mq$medium$mq$),
($mq$Which compound is an isomer of hexane (C₆H₁₄)?$mq$, $mq$["Hex-1-ene","2-methylpentane","Cyclohexane","Heptane"]$mq$, 1, $mq$2-methylpentane has the formula C₆H₁₄. Hex-1-ene is C₆H₁₂ and heptane is C₇H₁₆.$mq$, $mq$medium$mq$),
($mq$Butane boils at about −1 °C and 2-methylpropane at about −12 °C. What is the best explanation?$mq$, $mq$["The branched molecule has less surface contact, so weaker forces between molecules","The branched molecule has fewer atoms","The branched molecule has stronger covalent bonds","The branched molecule has a higher mass"]$mq$, 0, $mq$Both have the same mass. The branched shape is more compact, giving weaker intermolecular forces, so less energy is needed to separate the molecules.$mq$, $mq$medium$mq$),
($mq$Ethanol and methoxymethane both have the formula C₂H₆O. What is true about them?$mq$, $mq$["They have the same functional group","They are the same compound","They have different molecular formulae","They have the same molecular formula but different functional groups"]$mq$, 3, $mq$They are isomers: same atoms, different arrangement, so they behave differently.$mq$, $mq$medium$mq$),
($mq$Ignoring cis-trans forms, how many alkenes have the formula C₄H₈ with an open chain?$mq$, $mq$["1","2","3","4"]$mq$, 2, $mq$They are but-1-ene, but-2-ene and 2-methylpropene.$mq$, $mq$medium$mq$),
($mq$Which condensed formula represents 2-methylpropane?$mq$, $mq$["CH₃CH₂CH₂CH₃","CH₃CH(CH₃)CH₃","CH₃C(CH₃)₂CH₃","CH₃CH₂CH₃"]$mq$, 1, $mq$Three carbons in the chain with a methyl on carbon 2 gives CH₃CH(CH₃)CH₃.$mq$, $mq$medium$mq$),
($mq$A student draws two different-looking displayed structures for C₃H₈ and says they are isomers. Which comment is correct?$mq$, $mq$["Incorrect, because there is only one way to arrange C₃H₈ so they are the same molecule","Correct, because they look different","Incorrect, because C₃H₈ has no isomers and is a different formula","Correct, because they have different bond angles"]$mq$, 0, $mq$Rotating or flipping a drawing does not make a new compound. Propane has no structural isomers.$mq$, $mq$medium$mq$),
($mq$Propanoic acid and methyl ethanoate both have the formula C₃H₆O₂. Which test would tell them apart?$mq$, $mq$["Add bromine water: only the ester decolourises it","Measure their relative formula mass","Burn them: only the ester produces CO₂","Add sodium carbonate: only the acid fizzes"]$mq$, 3, $mq$Carboxylic acids react with carbonates to give carbon dioxide. Esters do not. Both have the same relative formula mass.$mq$, $mq$hard$mq$),
($mq$How many alcohols have the molecular formula C₄H₉OH (structural isomers only)?$mq$, $mq$["2","3","4","5"]$mq$, 2, $mq$They are butan-1-ol, butan-2-ol, 2-methylpropan-1-ol and 2-methylpropan-2-ol.$mq$, $mq$hard$mq$),
($mq$Which pair of compounds are isomers of each other?$mq$, $mq$["Propane and propene","But-1-ene and but-2-ene","Ethanol and ethanoic acid","Methane and methanol"]$mq$, 1, $mq$But-1-ene and but-2-ene are both C₄H₈, differing only in the position of the double bond.$mq$, $mq$hard$mq$),
($mq$Isomers of C₄H₁₀ each have a relative formula mass of 58. Which statement is correct?$mq$, $mq$["Isomers have the same relative formula mass but can have different physical properties","Isomers always have identical boiling points","Isomers have the same structure","Isomers have different relative formula masses"]$mq$, 0, $mq$The relative formula mass depends only on the atoms present, which are identical in isomers, but their shapes affect physical properties such as boiling point.$mq$, $mq$hard$mq$),
($mq$Pentane boils at 36 °C, 2-methylbutane at 28 °C and 2,2-dimethylpropane at about 10 °C. What conclusion fits the data?$mq$, $mq$["More branching raises the boiling point","Boiling point is not linked to structure","The compounds have different formulae","More branching lowers the boiling point of isomers"]$mq$, 3, $mq$All three are C₅H₁₂. As branching increases, molecules are more compact and have weaker intermolecular forces, so boiling points fall.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Structural Formulae and Isomers$mq$ and p.name = $mq$Naming and Classifying Organic Compounds$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Isomers$mq$, $mq$Compounds with the same molecular formula but different arrangements of atoms.$mq$),
($mq$Displayed formula$mq$, $mq$A drawing that shows every atom and every bond in the molecule.$mq$),
($mq$Condensed formula$mq$, $mq$Shows groups of atoms in order, e.g. CH₃CH(CH₃)CH₃ for 2-methylpropane.$mq$),
($mq$Chain isomers$mq$, $mq$Same formula, different carbon skeleton, e.g. butane and 2-methylpropane (both C₄H₁₀).$mq$),
($mq$Position isomers$mq$, $mq$Same chain, functional group or double bond in a different place, e.g. but-1-ene and but-2-ene.$mq$),
($mq$Functional-group isomers$mq$, $mq$Same formula, different family, e.g. ethanol and methoxymethane (both C₂H₆O).$mq$),
($mq$How many isomers has C₅H₁₂?$mq$, $mq$Three: pentane, 2-methylbutane and 2,2-dimethylpropane.$mq$),
($mq$Effect of branching on boiling point$mq$, $mq$More branching gives a lower boiling point because molecules are more compact with weaker intermolecular forces.$mq$),
($mq$Do isomers have the same relative formula mass?$mq$, $mq$Yes, because they contain exactly the same atoms, but their physical properties can differ.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$chemistry$mq$ and t.grade = 5 and t.name = $mq$Structural Formulae and Isomers$mq$ and p.name = $mq$Naming and Classifying Organic Compounds$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Two different compounds can have exactly the same atoms. Chemists call them **isomers**: molecules with the same molecular formula but different arrangements of atoms. Understanding isomers explains why a formula alone is not enough and why we need several ways of writing a structure.

## Ways to show a molecule
- **Molecular formula**: the number of each type of atom, such as C₄H₁₀. It says nothing about the arrangement.
- **Displayed formula**: every atom and every bond is drawn. This is the clearest way to show structure.
- **Condensed (structural) formula**: shows the groups in order without drawing every bond, for example CH₃CH₂CH₂CH₃ or CH₃CH(CH₃)CH₃.
- **Skeletal-style drawing**: sometimes used for carbon chains where each corner is a carbon, but you should always be able to convert it to a displayed or condensed formula.

## Types of structural isomers
There are three main ways the same atoms can be arranged differently.
- **Chain isomers**: the carbon skeleton is branched differently. C₄H₁₀ can be butane (a straight chain) or 2-methylpropane (a branched chain). C₅H₁₂ has three isomers: pentane, 2-methylbutane and 2,2-dimethylpropane.
- **Position isomers**: the same chain, but the functional group or double bond is in a different place. But-1-ene and but-2-ene are both C₄H₈. Propan-1-ol and propan-2-ol are both C₃H₈O.
- **Functional-group isomers**: the same atoms form different families. Ethanol (an alcohol) and methoxymethane (an ether) are both C₂H₆O. Propanoic acid and methyl ethanoate are both C₃H₆O₂.

## How isomers differ
Isomers have the same relative formula mass, but their physical and chemical properties can differ. Within chain isomers, more branching means a more compact molecule with less surface contact between neighbours, so the intermolecular forces are weaker and the boiling point is lower. For example, pentane boils at about 36 °C while 2,2-dimethylpropane boils at about 10 °C. Functional-group isomers react differently because the functional group controls the chemistry: propanoic acid fizzes with sodium carbonate, but methyl ethanoate does not.

## Finding isomers systematically
To find all isomers of a formula, work in order. Start with the longest straight chain. Then shorten the main chain by one carbon and place that carbon as a branch in every different position. Check each time that drawings are not the same molecule turned over or rotated. Count hydrogen atoms to confirm each one fits the formula.

Worked example: C₄H₉OH. Straight chain: butan-1-ol and butan-2-ol. Branched chain: 2-methylpropan-1-ol and 2-methylpropan-2-ol. That makes four alcohol isomers.

## Common mistakes
- Counting a rotated or flipped drawing as a new isomer.
- Assuming that a different name always means a different formula.
- Forgetting that isomers need the same molecular formula, so pent-1-ene (C₅H₁₀) is not an isomer of pentane (C₅H₁₂).

## How this is examined
Typical contexts include fuel blending, where branched and straight-chain molecules burn differently, or a flavour chemist comparing an acid and an ester. Expect tasks to draw or name isomers, state why two structures are or are not isomers, predict how properties differ and justify your choice using the data.

Exam tip: Check every proposed isomer by counting the carbon and hydrogen atoms, then check for duplicates by testing whether you could get the drawing by turning another one over.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('chemistry')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;