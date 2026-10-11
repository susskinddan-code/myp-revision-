begin;
-- Chemistry MYP 5 eAssessment Structure Mock A (8 tasks, 76 marks) (76 marks)
with sub as (select id from public.subjects where slug = $mq$chemistry$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Chemistry MYP 5 eAssessment Structure Mock A (8 tasks, 76 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Chemistry MYP 5 eAssessment Structure Mock A (8 tasks, 76 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6]]
A student collects a sample of seawater from a rock pool. The sample is cloudy because it contains fine sand, and it also contains dissolved sodium chloride. The student also has a second mixture of ethanol (boiling point 78 degrees C) and water (boiling point 100 degrees C).
(a) State the name of the technique used to remove the fine sand from the seawater. (1 mark)
(b) Describe how the student could obtain dry crystals of sodium chloride from the clear liquid that results. (2 marks)
(c) Name the technique that separates the ethanol and water mixture and explain, using ideas about particles and forces, why ethanol is collected first. (3 marks)

Total for Question 1: 6 marks$mq$, $mq$(a) Filtration [1].
(b) Heat the solution to evaporate some of the water until it is saturated / crystals start to form (crystallisation point) [1]; leave to cool so crystals form, then filter off and dry the crystals (accept evaporate to dryness) [1].
(c) Fractional distillation (accept distillation) [1]; ethanol has weaker forces between its molecules / lower boiling point, so less energy is needed for it to become a gas at about 78 degrees C [1]; the ethanol vapour passes into the condenser, cools and condenses, and is collected first while the water stays behind [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 7]]
Some data about three Group 1 metals are shown below.
Element: lithium, sodium, potassium
Atomic number: 3, 11, 19
Melting point (degrees C): 181, 98, 63
Observation with cold water: lithium fizzes steadily, sodium melts into a ball and fizzes rapidly, potassium melts and burns with a lilac flame.
(a) State the electronic configuration of a sodium atom. (1 mark)
(b) Explain why the Group 1 metals have similar chemical properties. (1 mark)
(c) Describe the trend in melting point and the trend in reactivity going down Group 1. (2 marks)
(d) Explain why potassium is more reactive than sodium. (2 marks)
(e) Write a balanced symbol equation for the reaction of sodium with water. (1 mark)

Total for Question 2: 7 marks$mq$, $mq$(a) 2,8,1 [1].
(b) They all have one electron in their outer shell (and lose it to form a 1+ ion) [1].
(c) Melting point decreases down the group [1]; reactivity increases down the group [1].
(d) The outer electron of potassium is further from the nucleus / there is more shielding from inner shells [1]; so the attraction to the nucleus is weaker and the electron is lost more easily [1].
(e) 2Na + 2H2O -> 2NaOH + H2 (accept state symbols; formulae correct and balanced) [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
Four unlabelled solids P, Q, R and S were tested. The results are shown below.
Solid P: melting point 801 degrees C; does not conduct as a solid; conducts when molten.
Solid Q: melting point -114 degrees C (it is a gas at room temperature); does not conduct in any state.
Solid R: melting point 3550 degrees C; very hard; does not conduct.
Solid S: melting point 1085 degrees C; conducts as a solid; can be hammered into shape.
The four substances are sodium chloride, hydrogen chloride, diamond and copper (not in that order).
(a) Match each of P, Q, R and S to the correct substance and state the type of structure it has. (4 marks)
(b) Explain why Q has such a low melting point. (2 marks)
(c) Explain why P conducts electricity when molten but not when solid. (2 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) P is sodium chloride, ionic (giant ionic lattice) [1]; Q is hydrogen chloride, simple molecular (covalent) [1]; R is diamond, giant covalent [1]; S is copper, metallic [1].
(b) Q is made of small molecules with weak forces between the molecules (intermolecular forces) [1]; only a small amount of energy is needed to overcome these forces, the strong covalent bonds inside the molecules do not break [1].
(c) In molten P the ions are free to move and carry charge [1]; in the solid the ions are held in fixed positions in the lattice so cannot move [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 8]]
The structures of four organic compounds are shown as condensed formulae.
Compound 1: CH3CH2CH2CH3
Compound 2: CH3CH=CHCH3
Compound 3: CH3CH2CH2OH
(a) Name compound 1 and compound 2. (2 marks)
(b) Name the homologous series to which compound 3 belongs and give its name. (2 marks)
(c) Describe a chemical test that distinguishes compound 1 from compound 2, giving the result for each. (2 marks)
(d) Write a balanced symbol equation for the complete combustion of compound 3. (2 marks)

Total for Question 4: 8 marks$mq$, $mq$(a) Compound 1 is butane [1]; compound 2 is but-2-ene [1].
(b) Alcohols [1]; propan-1-ol [1].
(c) Add bromine water (aqueous bromine) and shake [1]; compound 2 (alkene) decolourises it from orange/brown to colourless but compound 1 (alkane) stays orange/brown [1].
(d) 2C3H7OH + 9O2 -> 6CO2 + 8H2O (accept C3H8O): correct formulae for all species [1]; correctly balanced [1]. (Check: C 6 = 6, H 16 = 16, O 20 = 20.)$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 11]]
A student wants to investigate how the concentration of hydrochloric acid affects the rate of reaction with sodium thiosulfate solution. In this reaction a pale yellow precipitate of sulfur forms and the mixture turns cloudy:
Na2S2O3 + 2HCl -> 2NaCl + S + SO2 + H2O
The student has 0.20 mol/dm3 sodium thiosulfate solution, 2.0 mol/dm3 hydrochloric acid, distilled water, measuring cylinders, conical flasks, a stopwatch, a thermometer and a piece of paper with a black cross drawn on it. [Description: the flask is placed on top of the cross; the student looks down through the solution and stops the timer when the cross can no longer be seen.]
(a) Formulate a research question for this investigation. (2 marks)
(b) Formulate a hypothesis and justify it using scientific reasoning. (2 marks)
(c) Identify the independent variable, the dependent variable and two variables that must be controlled. (3 marks)
(d) Outline a method the student could use, including how the different concentrations of acid will be prepared. (3 marks)
(e) Identify one safety hazard in this investigation and state a precaution. (1 mark)

Total for Question 5: 11 marks$mq$, $mq$(a) Research question names the independent variable (concentration of HCl) [1] and the dependent variable (rate of reaction / time for the cross to disappear) with the reaction named, and is phrased as a question, e.g. How does the concentration of hydrochloric acid affect the time taken for the cross to disappear when it reacts with sodium thiosulfate? [1].
(b) Prediction: as the concentration of acid increases the time taken falls / the rate increases [1]; justification: more acid particles per unit volume so more frequent successful collisions per second (collision theory) [1].
(c) Independent variable: concentration of hydrochloric acid [1]; dependent variable: time for the cross to disappear (or rate = 1/time) [1]; any two controlled variables from temperature, volume of thiosulfate, concentration of thiosulfate, same flask/cross, same observer [1] (both needed for the mark).
(d) Prepare a range of at least five acid concentrations by diluting the 2.0 mol/dm3 acid with distilled water using measuring cylinders, keeping a fixed total volume [1]; add a fixed volume of thiosulfate to the flask on the cross, add acid, start the stopwatch immediately and swirl, stop when the cross is no longer visible [1]; repeat each concentration at least three times and calculate a mean [1].
(e) Any one hazard with its matching precaution: sulfur dioxide gas is produced and is harmful to people with asthma, so work in a well ventilated room / fume cupboard; or hydrochloric acid is an irritant, so wear eye protection [1].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 12]]
A student measures the energy released when hydrochloric acid reacts with sodium hydroxide solution. In each trial 25.0 cm3 of 1.00 mol/dm3 hydrochloric acid was placed in a polystyrene cup and its temperature recorded. Then 25.0 cm3 of 1.00 mol/dm3 sodium hydroxide solution was added, the mixture was stirred and the highest temperature recorded.
Trial: 1, 2, 3, 4
Initial temperature (degrees C): 21.0, 20.8, 21.2, 21.0
Highest temperature (degrees C): 27.8, 27.6, 28.0, 29.4
Use: density of solutions = 1.00 g/cm3; specific heat capacity = 4.18 J/g/degree C; energy transferred q = m x c x temperature change.
(a) Calculate the temperature rise for each trial. (2 marks)
(b) Identify the anomalous result and suggest one possible reason for it. (2 marks)
(c) Calculate the mean temperature rise, leaving out the anomalous result. (1 mark)
(d) Calculate the energy released, in joules. (2 marks)
(e) Show that 0.0250 mol of hydrochloric acid was used, and calculate the enthalpy change in kJ per mole, including its sign. (3 marks)
(f) The accepted value is -57.1 kJ/mol. Calculate the percentage difference between your value and the accepted value, and suggest one improvement to the method. (2 marks)

Total for Question 6: 12 marks$mq$, $mq$(a) 6.8, 6.8, 6.8 [1] and 8.4 degrees C [1].
(b) Trial 4 [1]; any reasonable reason, e.g. thermometer misread, not enough stirring, wrong volume or concentration used, cup not clean/dry [1].
(c) 6.8 degrees C [1].
(d) mass = 50.0 g (25.0 + 25.0 cm3 at 1.00 g/cm3) [1]; q = 50.0 x 4.18 x 6.8 = 1421 J (accept 1420 or 1.42 kJ) [1].
(e) moles HCl = 25.0/1000 x 1.00 = 0.0250 mol [1]; energy per mole = 1421/0.0250 = 56 840 J = 56.8 kJ/mol (accept 56.8 or 56.9; allow error carried forward) [1]; reaction is exothermic (temperature rose) so enthalpy change is -56.8 kJ/mol [1].
(f) (57.1 - 56.8)/57.1 x 100 = 0.5 per cent (accept 0.5 to 0.6; allow error carried forward) [1]; the experimental value is slightly smaller, because some heat was lost to the surroundings; use a lid on the cup / better insulation / use a digital thermometer or more precise measuring (any one sensible improvement linked to the reason) [1].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | C 3 | D 5]]
Read the passage.
The council of the town of Harrowby is deciding whether to replace its coal-fired power station with a gas-fired one fitted with carbon capture. Coal contains sulfur, so the old station releases sulfur dioxide as well as carbon dioxide. Natural gas is mostly methane, which releases less carbon dioxide for each unit of electricity. Some methane escapes from gas pipelines, and methane is itself a greenhouse gas. The new station would capture about 90 per cent of its carbon dioxide, but it would raise electricity bills by about 15 per cent. Building it would create 150 jobs while closing the coal station would end 400 jobs. Local fishers say the cooling water from the station is warming the estuary.
(a) Show that burning 1000 kg of methane (CH4) releases 2750 kg of carbon dioxide. Relative atomic masses: H = 1, C = 12, O = 16. (3 marks)
(b) Discuss the implications of replacing the coal station with the gas station, referring to at least two different factors (for example environmental, economic, social or political). (5 marks)

Total for Question 7: 8 marks$mq$, $mq$(a) CH4 + 2O2 -> CO2 + 2H2O, so 1 mol CH4 gives 1 mol CO2 [1]; Mr(CH4) = 16 and Mr(CO2) = 44 [1]; 1000 x 44/16 = 2750 kg (62.5 kmol of each) [1].
(b) Credit one mark for each developed point, to a maximum of five marks, with at least two different factors for full marks [1][1][1][1][1]. Indicative content (no marks attached to individual lines):
Environmental benefit: no sulfur dioxide so less acid rain; less carbon dioxide per unit of electricity and 90 per cent capture reduces the enhanced greenhouse effect.
Environmental risk: methane leaks are a potent greenhouse gas; warm cooling water harms estuary wildlife; stored carbon dioxide could leak.
Economic: 15 per cent higher bills affect poorer households, but new jobs and investment.
Social: 400 jobs lost versus 150 created, so unemployment and community impact unless retraining is provided.
Political/ethical: responsibility to meet climate targets and protect future generations versus duty to local workers.
Band guidance: one to two marks, simple one-sided statements; three to four marks, benefits and risks linked to evidence in the passage; five marks, balanced discussion with two or more factors and a reasoned judgement.$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 9 | B 3 | C 2 | D 2]]
A class investigates the reactivity of four metals: magnesium, zinc, copper and silver. Observations when a strip of each metal is placed in a solution of another metal's salt are given below.
Zinc in copper(II) sulfate solution: the blue colour fades and a reddish-brown solid forms on the zinc.
Copper in zinc sulfate solution: no change.
Magnesium in zinc sulfate solution: a grey solid forms and the magnesium strip gets smaller.
Copper in silver nitrate solution: a grey-white solid forms on the copper and the solution slowly turns blue.
(a) Deduce the order of reactivity of the four metals, from most reactive to least reactive. (2 marks)
(b) Write the ionic equation for the reaction of zinc with copper(II) sulfate solution, and state which species is oxidised and which is reduced, in terms of electrons. (3 marks)
The students then build a cell. A zinc strip in zinc sulfate solution and a copper strip in copper(II) sulfate solution (both 1.0 mol/dm3) are connected by a wire containing a voltmeter. A strip of filter paper soaked in potassium nitrate solution links the two solutions. The voltmeter reads 1.10 V.
(c) State the direction of electron flow in the wire, name the negative electrode, write the half-equation at that electrode, and state the purpose of the filter paper. (4 marks)
The students measure the voltage when other metals are paired with copper in 1.0 mol/dm3 solutions of their sulfates. Magnesium: 2.7 V. Zinc: 1.1 V. Iron: 0.8 V.
(d) Describe the pattern in these results and predict the voltage range expected for a lead-copper cell, given that lead is less reactive than iron but more reactive than copper. (2 marks)
(e) Outline how the students could investigate the effect of the concentration of copper(II) sulfate solution on the voltage of the zinc-copper cell. (3 marks)
(f) Rechargeable batteries are replacing single-use batteries. Discuss one environmental advantage and one environmental disadvantage of this change. (2 marks)

Total for Question 8: 16 marks$mq$, $mq$(a) Magnesium > zinc > copper > silver [1][1] (award one mark if the order is partly correct, e.g. magnesium and zinc correctly above copper and silver).
(b) Zn + Cu2+ -> Zn2+ + Cu [1]; zinc is oxidised as it loses electrons [1]; copper(II) ions are reduced as they gain electrons [1].
(c) Electrons flow from the zinc to the copper through the wire [1]; zinc is the negative electrode (anode) [1]; Zn -> Zn2+ + 2e- [1]; the salt bridge (filter paper) lets ions move between the solutions to complete the circuit and balance the charge [1].
(d) The more reactive the metal paired with copper, the larger the voltage (greater difference in reactivity gives larger voltage) [1]; lead-copper voltage is between 0 V and 0.8 V (accept any value in that range, for example about 0.5 V) [1].
(e) Prepare a range of copper(II) sulfate concentrations (e.g. 1.0, 0.50, 0.25, 0.10 mol/dm3) by diluting a stock solution [1]; measure the voltage of the cell for each concentration with the voltmeter [1]; control the zinc sulfate concentration, electrode sizes, temperature and salt bridge, and repeat readings to calculate a mean [1].
(f) Advantage: fewer batteries are made and thrown away, so less waste and less use of raw materials (accept reduced landfill/toxic metals) [1]. Disadvantage: manufacture needs mining of metals such as lithium and cobalt and more energy, and cells still need proper recycling (accept hazardous waste if not recycled) [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Chemistry MYP 5 eAssessment Structure Mock B (8 tasks, 77 marks) (77 marks)
with sub as (select id from public.subjects where slug = $mq$chemistry$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Chemistry MYP 5 eAssessment Structure Mock B (8 tasks, 77 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Chemistry MYP 5 eAssessment Structure Mock B (8 tasks, 77 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6]]
Chlorine has two naturally occurring isotopes, chlorine-35 and chlorine-37. In a typical sample, 75 per cent of the atoms are chlorine-35 and 25 per cent are chlorine-37. The atomic number of chlorine is 17.
(a) State the number of protons, neutrons and electrons in an atom of chlorine-37. (2 marks)
(b) Explain why the two isotopes have the same chemical properties. (1 mark)
(c) Calculate the relative atomic mass of chlorine in this sample. (2 marks)
(d) Calculate the mass of 0.20 mol of chlorine molecules, Cl2. (1 mark)

Total for Question 1: 6 marks$mq$, $mq$(a) 17 protons and 17 electrons [1]; 20 neutrons (37 - 17) [1].
(b) They have the same number of electrons / same electronic configuration (same number of outer electrons) [1].
(c) (35 x 75 + 37 x 25)/100 [1]; = 35.5 [1].
(d) Mr(Cl2) = 71, so mass = 0.20 x 71 = 14.2 g [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 7]]
A school technician has solutions of hydrochloric acid (pH 1), sodium chloride (pH 7) and sodium hydroxide (pH 13).
(a) State the colour of universal indicator in the sodium hydroxide solution. (1 mark)
(b) Write the ionic equation for neutralisation. (1 mark)
(c) Describe how pure, dry crystals of copper(II) sulfate can be prepared from copper(II) oxide (an insoluble base) and dilute sulfuric acid. (4 marks)
(d) Write a balanced symbol equation for the reaction in (c). (1 mark)

Total for Question 2: 7 marks$mq$, $mq$(a) Purple (accept violet or dark blue-purple) [1].
(b) H+(aq) + OH-(aq) -> H2O(l) [1].
(c) Add copper(II) oxide to warm dilute sulfuric acid, stirring, until no more dissolves (excess) [1]; filter to remove the excess copper(II) oxide [1]; heat the filtrate to evaporate some water until saturated (crystallisation point) then leave to cool and crystallise [1]; filter off the crystals and dry them between filter paper [1].
(d) CuO + H2SO4 -> CuSO4 + H2O [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
Vinegar contains ethanoic acid, CH3COOH. Ethanoic acid belongs to the homologous series called carboxylic acids.
(a) Name the functional group present in all carboxylic acids. (1 mark)
(b) Name the three products formed when ethanoic acid reacts with sodium carbonate. (2 marks)
(c) Ethanoic acid reacts with ethanol, warmed with a few drops of concentrated sulfuric acid as a catalyst, to form an ester. Name this ester and give its condensed structural formula. (2 marks)
(d) Name the ester made from propanoic acid and methanol. (1 mark)
(e) Ethanol can be made from glucose by fermentation. Write the balanced symbol equation for this reaction and state the conditions needed. (2 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) Carboxyl group, -COOH [1].
(b) Sodium ethanoate [1]; carbon dioxide and water (both needed) [1].
(c) Ethyl ethanoate [1]; CH3COOCH2CH3 [1].
(d) Methyl propanoate [1].
(e) C6H12O6 -> 2C2H5OH + 2CO2 [1]; yeast (enzymes), warm (about 25 to 35 degrees C), no oxygen (anaerobic) (any two conditions) [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 7]]
Four metals W, X, Y and Z are calcium, copper, iron and zinc (not in that order). Their reactions are recorded below.
Metal W: bubbles rapidly in cold water.
Metal X: no reaction with cold water; fizzes steadily in dilute hydrochloric acid.
Metal Y: no reaction with cold water or dilute hydrochloric acid.
Metal Z: no reaction with cold water; fizzes slowly in dilute hydrochloric acid.
(a) List W, X, Y and Z in order of reactivity, most reactive first. (1 mark)
(b) Identify metal W and metal Y. (2 marks)
(c) Zinc reacts with hydrochloric acid: Zn + 2HCl -> ZnCl2 + H2. Explain, in terms of electrons, why this is a redox reaction. (2 marks)
(d) Steel objects are often coated with zinc. Explain why the steel is still protected from rusting when the coating is scratched. (2 marks)

Total for Question 4: 7 marks$mq$, $mq$(a) W, X, Z, Y [1].
(b) W is calcium [1]; Y is copper [1].
(c) Zinc atoms lose electrons (0 to +2) so zinc is oxidised [1]; hydrogen ions gain electrons (+1 to 0) to form hydrogen so are reduced; oxidation and reduction happen together [1].
(d) Zinc is more reactive than iron, so it loses electrons in preference [1]; the zinc corrodes instead of the iron (sacrificial protection) [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | C 12]]
A student reacts a 0.12 g piece of magnesium ribbon with an excess of 1.0 mol/dm3 hydrochloric acid and collects the hydrogen in a gas syringe. The ribbon had not been cleaned. Mg + 2HCl -> MgCl2 + H2. The volume of 1 mol of any gas at room temperature and pressure is 24 000 cm3. Relative atomic mass of Mg = 24.
Time (s): 0, 20, 40, 60, 80, 100, 120, 140, 160
Volume of hydrogen (cm3): 0, 40, 66, 84, 96, 104, 110, 114, 114
(a) Describe how the data should be presented in a graph and the shape you expect the graph to have. (2 marks)
(b) Calculate the mean rate of reaction over the first 20 s, in cm3/s. (1 mark)
(c) Calculate the mean rate of reaction between 60 s and 100 s. (2 marks)
(d) Explain, using collision theory, why the rate decreases as the reaction proceeds. (2 marks)
(e) Show that the maximum volume of hydrogen that could be made is 120 cm3. (3 marks)
(f) Calculate the percentage of the maximum volume that was collected and suggest one reason why it is less than 100 per cent. (2 marks)

Total for Question 5: 12 marks$mq$, $mq$(a) Line graph with time (s) on the x-axis and volume of hydrogen (cm3) on the y-axis, with units and a line or curve of best fit [1]; the curve is steepest at the start, the gradient decreases and the graph levels off to a plateau at 114 cm3 after about 140 s [1].
(b) 40/20 = 2.0 cm3/s [1].
(c) (104 - 84)/(100 - 60) [1]; = 0.50 cm3/s [1].
(d) The concentration of hydrochloric acid decreases (and the surface area of magnesium decreases) [1]; so there are fewer successful collisions per second [1].
(e) moles of Mg = 0.12/24 = 0.0050 mol [1]; mole ratio Mg : H2 is 1 : 1 so 0.0050 mol H2 [1]; volume = 0.0050 x 24 000 = 120 cm3 [1].
(f) 114/120 x 100 = 95 per cent [1]; reason: the magnesium ribbon was coated in magnesium oxide so less magnesium reacted / some gas escaped before the syringe was connected / leak in apparatus / hydrogen not perfectly insoluble (any one) [1].$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | B 10]]
Antacid tablets contain bases such as calcium carbonate that neutralise excess hydrochloric acid in the stomach. A student wants to find out which of two brands, Brand X and Brand Y, neutralises more acid per tablet. Equipment available: tablets of each brand, 0.100 mol/dm3 hydrochloric acid, 0.100 mol/dm3 sodium hydroxide solution, phenolphthalein indicator, burette, pipette, conical flasks, beakers, balance, mortar and pestle, distilled water, stopwatch, thermometer.
(a) Formulate a research question. (1 mark)
(b) Formulate a hypothesis and justify it. (2 marks)
(c) State the independent variable and the dependent variable, and explain how two other variables will be controlled. (3 marks)
(d) Outline a method, including how the amount of acid neutralised by one tablet can be found. (3 marks)
(e) Identify one hazard and a safety precaution. (1 mark)

Total for Question 6: 10 marks$mq$, $mq$(a) A question linking brand of antacid (independent) to the amount of acid neutralised (dependent), e.g. Which brand of antacid tablet neutralises the greater amount of 0.100 mol/dm3 hydrochloric acid? [1].
(b) A prediction that names one brand (e.g. Brand X neutralises more acid) [1]; a scientific justification, e.g. it contains a greater mass or proportion of calcium carbonate or a stronger base, and more moles of base neutralise more moles of acid [1].
(c) Independent variable: brand of tablet; dependent variable: moles (or volume) of acid neutralised [1]; two controlled variables with how: same volume and concentration of hydrochloric acid, measured with the same pipette [1]; same temperature / same time allowed for reaction / tablet crushed to the same fineness [1].
(d) Crush a tablet, find its mass, add it to a measured excess volume of 0.100 mol/dm3 hydrochloric acid in a conical flask and swirl until fizzing stops (the base is insoluble so a direct titration is not possible) [1]; add phenolphthalein and titrate the leftover acid with 0.100 mol/dm3 sodium hydroxide from the burette to the end point [1]; repeat for each brand until concordant results, and acid neutralised = acid added minus acid left over [1].
(e) Hydrochloric acid and sodium hydroxide are irritants/corrosive, so wear eye protection (accept clear-up spillages with plenty of water; do not eat tablets in the lab) [1].$mq$, $mq$B$mq$),
(7, $mq$[[Q 7 | A 1 | C 3 | D 4]]
Read the passage.
A fertiliser factory in the region of Eastmere makes ammonia by the Haber process: N2 + 3H2 -> 2NH3. The nitrogen is separated from the air by fractional distillation of liquid air, and the hydrogen is made from natural gas. The reaction uses an iron catalyst at about 450 degrees C and high pressure. The ammonia is converted into fertiliser, which has helped farmers in the region to double their crop yields. However, nitrate from fertiliser washes into rivers, causing algae to grow rapidly and fish to die. The factory owner plans to double production, which would employ 200 more people but would also increase energy use and the price of gas for local homes.
(a) State the approximate percentage of nitrogen in dry air. (1 mark)
(b) Show that about 820 kg of nitrogen is needed to make 1000 kg of ammonia. Relative atomic masses: H = 1, N = 14. (3 marks)
(c) Discuss the implications of doubling ammonia production, referring to at least two different factors (for example environmental, economic, social or ethical). (4 marks)

Total for Question 7: 8 marks$mq$, $mq$(a) 78 per cent (accept 78 to 80 per cent) [1].
(b) Mr(NH3) = 17, so 1000 kg is 58.8 kmol of NH3 [1]; mole ratio N2 : NH3 is 1 : 2 so 29.4 kmol of N2 [1]; mass of N2 = 29.4 x 28 = 823 kg, which is about 820 kg [1]. (Alternative: 28 g of N2 gives 34 g of NH3, so 1000 x 28/34 = 823 kg.)
(c) Credit one mark for each developed point, to a maximum of four marks, with at least two different factors for full marks [1][1][1][1]. Indicative content (no marks attached to individual lines):
Social/economic benefit: more food and food security, 200 new jobs, local economic growth.
Environmental risk: more fertiliser run-off, eutrophication and loss of river life; more energy use and carbon dioxide emissions from natural gas.
Economic/social risk: higher gas prices for households, possible fuel poverty.
Ethical: balance feeding people against harm to ecosystems and the rights of future generations; careful fertiliser use or buffer zones as a compromise.
Band guidance: one to two marks, simple statements; three marks, benefits and risks from the passage explained; four marks, balanced discussion across two factors with a justified conclusion.$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 7 | B 3 | C 6 | D 3]]
Copper is purified by electrolysis. The impure copper is made the anode and a thin sheet of pure copper is made the cathode. Both dip into copper(II) sulfate solution. The impurities include silver, gold and zinc.
(a) Write the half-equation for the change at the anode and the half-equation for the change at the cathode. (2 marks)
(b) Explain why the concentration of the copper(II) sulfate solution stays approximately constant during the process. (2 marks)
(c) Explain why silver and gold fall to the bottom of the cell as a sludge, and why zinc does not coat the cathode. (3 marks)
A student models the process on a small scale using a constant current of 0.60 A. The mass gained by the cathode is measured.
Time (min): 10, 20, 30, 40, 50
Mass gained by cathode (g): 0.12, 0.24, 0.36, 0.47, 0.59
(d) Describe the relationship between time and mass gained. (2 marks)
(e) Calculate the mean rate of deposition in g/min using the 50 minute result, and use it to predict the mass gained after 70 minutes. (3 marks)
(f) Show that about 0.0093 mol of copper was deposited in 50 minutes. Relative atomic mass: Cu = 63.5. (1 mark)
(g) Outline how the student could investigate whether the current affects the mass of copper deposited. (3 marks)
(h) Copper can be recycled from scrap instead of being extracted from ore. Evaluate this statement: Recycling copper is better for society than mining new ore. (3 marks)

Total for Question 8: 19 marks$mq$, $mq$(a) Anode: Cu -> Cu2+ + 2e- [1]; cathode: Cu2+ + 2e- -> Cu [1].
(b) Copper atoms dissolve from the anode as Cu2+ at the same rate as Cu2+ ions are deposited at the cathode [1]; the same number of electrons is involved at each electrode (equal and opposite changes) [1].
(c) Silver and gold are less reactive than copper so they are not oxidised to ions at the anode [1]; they stay as metal and drop off as the anode dissolves, forming anode sludge [1]; zinc is more reactive than copper so zinc ions stay in solution and copper ions are reduced at the cathode instead [1].
(d) Mass gained increases as time increases [1]; the relationship is directly proportional / linear, about 0.012 g every minute (mass doubles when time doubles) [1].
(e) Rate = 0.59/50 = 0.0118 g/min (accept 0.012) [1]; mass after 70 min = 0.0118 x 70 [1]; = 0.83 g (accept 0.82 to 0.84) [1].
(f) 0.59/63.5 = 0.0093 mol [1].
(g) Vary the current (e.g. 0.2, 0.4, 0.6, 0.8 A) using a variable resistor and read it on an ammeter [1]; weigh the dried cathode before and after, using the same time for each run [1]; control the concentration and volume of electrolyte, electrode separation and size, and repeat to find a mean [1].
(h) Credit evaluation using evidence, one mark per developed point [1][1][1]: recycling uses much less energy and avoids mining damage to land, so less pollution and habitat loss; it conserves finite ore and reduces waste sent to landfill; but collecting and sorting scrap costs money and impure scrap still needs refining, so a balanced judgement (mostly valid) is reached.$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Biology MYP 5 eAssessment Structure Mock A (8 tasks, 72 marks) (72 marks)
with sub as (select id from public.subjects where slug = $mq$biology$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Biology MYP 5 eAssessment Structure Mock A (8 tasks, 72 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Biology MYP 5 eAssessment Structure Mock A (8 tasks, 72 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6]]
A student studies a leaf under a microscope.
Diagram not to scale. [Description: a printed micrograph of one palisade mesophyll cell from a leaf. The cell is a tall rectangle containing a thin cell wall, a large central vacuole, many green chloroplasts around the edge of the cytoplasm, and a nucleus. The student measured the length of the cell on the printed micrograph as 48 mm. The magnification of the micrograph is x600.]
(a) Identify the structure that controls the activities of the cell. (1 mark)
(b) Explain why palisade cells contain many chloroplasts. (2 marks)
(c) Calculate the actual length of the cell. Give your answer in micrometres (1 mm = 1000 micrometres). (2 marks)
(d) State the level of organisation of a whole leaf. (1 mark)

Total for Question 1: 6 marks$mq$, $mq$(a) Nucleus [1]. (b) Chloroplasts contain chlorophyll, which absorbs light energy [1]; more chloroplasts means more photosynthesis, so more glucose is made (accept: more light is absorbed) [1]. (c) Actual length = image length / magnification = 48 / 600 [1] = 0.08 mm = 80 micrometres [1] (award both marks for 80 with no working; 0.08 mm without conversion gets 1). (d) Organ [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 7]]
A grassland ecosystem contains the following feeding relationships. Grasshoppers and rabbits eat grass. Frogs eat grasshoppers. Snakes eat frogs. Hawks eat snakes and rabbits. Foxes eat rabbits.
(a) State the producer in this ecosystem. (1 mark)
(b) Write down the longest food chain in this ecosystem. (1 mark)
(c) State the trophic level of the frog. (1 mark)
(d) A disease kills most of the rabbits. Predict and explain the effect on the number of snakes in the short term. (2 marks)
(e) The grass in one area stores 50 000 kJ of energy each year. Assuming that 10% of the energy is transferred at each step, calculate the energy available to the frogs. (2 marks)

Total for Question 2: 7 marks$mq$, $mq$(a) Grass [1]. (b) Grass, grasshopper, frog, snake, hawk (arrows pointing in the direction of energy flow; accept a correct chain written with arrows) [1]. (c) Secondary consumer (accept third trophic level) [1]. (d) Snake numbers decrease [1] because hawks, which now have fewer rabbits to eat, eat more snakes [1]. (e) Grass to grasshopper = 5 000 kJ [1]; grasshopper to frog = 500 kJ [1] (award both marks for 500 kJ with no working).$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 7]]
Amylase is an enzyme in saliva that breaks down starch. A student mixes amylase with starch solution at six temperatures and records the time taken for all the starch to disappear (tested with iodine solution).
Temperature in degrees Celsius: 10, 20, 30, 40, 50, 60
Time for starch to disappear in seconds: 240, 120, 60, 30, 90, no change after 600
(a) Identify the temperature, from those tested, at which amylase works fastest. (1 mark)
(b) The rate of reaction = 1 divided by the time taken. Calculate the rate at 20 degrees Celsius, in units of per second. Give your answer to 2 significant figures. (2 marks)
(c) Explain why there was no change at 60 degrees Celsius. (2 marks)
(d) State the name of one product of the digestion of starch by amylase. (1 mark)
(e) Explain why the time taken falls between 10 and 40 degrees Celsius. (1 mark)

Total for Question 3: 7 marks$mq$, $mq$(a) 40 degrees Celsius [1]. (b) Rate = 1 / 120 [1] = 0.0083 per second (accept 8.3 x 10 to the power minus 3) [1]. (c) The high temperature breaks the bonds that hold the enzyme in shape, so the active site changes shape (the enzyme is denatured) [1]; the starch no longer fits the active site so the reaction cannot happen [1]. (d) Maltose (accept sugar or glucose) [1]. (e) Enzyme and substrate particles gain kinetic energy and move faster, so there are more frequent collisions with enough energy to react [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 8]]
A person touches a hot pan and pulls their hand away before feeling pain.
(a) Put the following parts of the reflex arc in the order in which an impulse passes through them: effector, relay neurone, receptor, motor neurone, sensory neurone. (2 marks)
(b) State one reason why reflex actions are important. (1 mark)
(c) Compare nervous and hormonal communication by stating two differences. (2 marks)
(d) Before a race, a cyclist's heart rate increases because a hormone is released. Name the gland that releases this hormone. (1 mark)
(e) Explain how this hormone helps the cyclist to perform well. (2 marks)

Total for Question 4: 8 marks$mq$, $mq$(a) Receptor first and effector last [1]; sensory neurone, then relay neurone, then motor neurone in the middle in that order [1]. (b) They are fast and automatic, so they protect the body from harm (accept: no time needed for decisions) [1]. (c) Any two differences from: nerves use electrical impulses, hormones are chemicals carried in the blood; nervous responses are fast, hormonal responses are slower; nervous effects are short-lived, hormonal effects last longer; nervous effects are local, hormones can affect many target organs [1][1]. (d) Adrenal gland (accept adrenal glands) [1]. (e) Adrenaline increases the heart rate so more blood is pumped per minute [1]; more oxygen and glucose reach the muscles for aerobic respiration, releasing more energy for movement [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 10]]
A class wants to investigate how light intensity affects the rate of photosynthesis in the water plant Elodea. A student places a piece of Elodea in a beaker of water, with a lamp at a measured distance from the beaker. The student counts the bubbles of gas released from the cut end of the stem in one minute.
(a) State a research question that this investigation could answer. (2 marks)
(b) Formulate a testable hypothesis, using scientific reasoning. (2 marks)
(c) Identify the independent variable and the dependent variable. (2 marks)
(d) Describe how the student can change the light intensity and obtain reliable values for the dependent variable. (2 marks)
(e) Outline one variable that must be controlled, and how this can be done. (1 mark)
(f) Outline one safety precaution for this investigation. (1 mark)

Total for Question 5: 10 marks$mq$, $mq$(a) A question linking both variables, for example: How does the distance of the lamp from the Elodea (light intensity) affect the number of bubbles released per minute? [2] (1 mark if both variables are named but not linked). (b) A prediction that links the variables, for example: as the lamp is moved closer, more bubbles will be released [1]; with reasoning, for example: more light energy is absorbed by chlorophyll, so photosynthesis is faster and more oxygen is produced [1]. (c) Independent: distance of lamp from the plant (light intensity) [1]; dependent: number of bubbles per minute (rate of oxygen release) [1]. (d) Use a metre rule to place the lamp at several set distances, for example 10, 20, 30, 40 and 50 cm [1]; at each distance count the bubbles for the same period, repeat at least three times and calculate a mean (accept: allow the plant to adjust for a few minutes before counting) [1]. (e) Any one from: temperature, using a water bath or a heat shield (heat-absorbing water tank) between lamp and beaker; carbon dioxide concentration, by adding the same amount of sodium hydrogencarbonate; same piece of Elodea or same length of stem; room darkened so other light does not interfere [1]. (f) Any one from: do not touch the hot lamp; keep electrical equipment away from water; wipe up spills; wash hands after handling pond plants [1].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 10]]
The class results are shown. Three trials were done at each distance.
Distance of lamp in cm: 10, 20, 30, 40, 50
Bubbles per minute, trial 1: 48, 25, 16, 9, 6
Bubbles per minute, trial 2: 50, 27, 15, 8, 6
Bubbles per minute, trial 3: 46, 26, 29, 10, 6
(a) Identify the anomalous result and suggest one possible cause. (2 marks)
(b) Calculate the mean number of bubbles per minute at 30 cm, leaving out the anomalous result. (2 marks)
(c) The means for the other distances are 48, 26, 9 and 6. State which variable should be plotted on the horizontal axis of a graph of the means. (1 mark)
(d) Describe the trend shown by the means. (1 mark)
(e) Explain the trend using your knowledge of photosynthesis. (2 marks)
(f) Evaluate one limitation of counting bubbles to measure the rate of photosynthesis, and suggest an improvement. (2 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) 29 bubbles at 30 cm in trial 3 [1]; a possible cause, for example miscounting, the lamp being moved closer, or the water warming up [1]. (b) (16 + 15) / 2 [1] = 15.5 bubbles per minute [1]. (c) Distance of the lamp (independent variable) [1]. (d) As the distance increases, the mean number of bubbles per minute decreases (the decrease is steep at first and then levels off) [1]. (e) Further from the lamp there is less light energy for the chlorophyll to absorb [1], so photosynthesis is slower and less oxygen gas is released as bubbles [1]. (f) A limitation, for example bubbles vary in size so counting does not measure the volume of gas accurately, or some oxygen dissolves or is used in respiration [1]; an improvement, for example collect the gas in a capillary tube or gas syringe and measure its volume [1].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | D 10]]
Read the passage.
A farming cooperative in East Africa is deciding whether to grow insect-resistant maize. Scientists have inserted a gene from a soil bacterium into the maize so that the plant makes a protein that is harmful to stem-borer caterpillars. In field trials the yield increased by 20% and the farmers sprayed insecticide twice a season instead of six times. The seed is patented, so farmers must buy new seed each year at three times the price of ordinary seed. Some consumers worry about long-term health effects. Some ecologists worry that pollen could carry the new gene to wild relatives of maize.
(a) Outline what is meant by genetic modification. (2 marks)
(b) Describe two benefits of growing the insect-resistant maize. (2 marks)
(c) Explain one possible environmental risk of growing the insect-resistant maize. (2 marks)
(d) Discuss one economic or social factor that the cooperative should consider. (2 marks)
(e) Justify whether the cooperative should grow the maize, using evidence from the passage. (2 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) A gene from one organism is transferred into the genome (DNA) of another organism [1]; so that the receiving organism has a new characteristic (makes a new protein) [1]. (b) Any two from: higher yield, so more food or income [1]; less insecticide used, which saves money and reduces pollution and harm to other insects and farm workers [1]. (c) Pollen carries the gene to wild relatives [1], which may change wild populations or let weeds gain resistance to pests, reducing biodiversity (accept: the toxin may harm non-target insects such as butterflies, or caterpillars may evolve resistance) [1]. (d) Economic: seed costs three times as much and must be bought every year, which may put the cooperative in debt or make farmers depend on one company [1], balanced against the extra income from the 20% higher yield (accept a social factor such as consumer acceptance or access to seed for poor farmers, with a development) [1]. (e) A clear decision [1] supported by evidence from the passage, for example yield rises by 20% and spraying falls from six to two times, which may outweigh the seed cost if prices are high enough (accept a reasoned decision against, citing the cost or ecological worry) [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 6 | C 4 | D 4]]
Read the passage and study the data.
Measles is caused by a virus that spreads in droplets from coughs and sneezes. In a population with no immunity, one infected person passes the virus on to about 15 others (R0 = 15). The two-dose measles vaccine is about 97% effective. Town Y recorded its vaccination coverage and the number of measles cases each year.
Year: 2016, 2018, 2020, 2022
Children fully vaccinated (%): 98, 97, 90, 82
Measles cases in the town: 3, 6, 95, 240
(a) Explain how a vaccine gives a person immunity to a disease. (3 marks)
(b) The percentage of a population that must be immune to stop an outbreak spreading is given by 100 x (1 - 1/R0). Show that this is about 93% for measles. (2 marks)
(c) Describe the changes in vaccination coverage and in the number of cases in Town Y between 2016 and 2022. (2 marks)
(d) Explain why the number of cases rose in Town Y even though most children were still vaccinated. (3 marks)
(e) Some parents refuse to vaccinate their children. Discuss the ethical and social factors involved in making vaccination compulsory. (4 marks)

Total for Question 8: 14 marks$mq$, $mq$(a) A vaccine contains weakened or dead pathogens, or their antigens [1]; white blood cells (lymphocytes) recognise the antigens and make specific antibodies [1]; memory cells remain, so if the real pathogen enters later, antibodies are made much faster and in larger amounts [1]. (b) 100 x (1 - 1/15) [1] = 100 x 0.933 = 93.3%, so about 93% [1]. (c) Coverage fell from 98% to 82% [1]; cases rose from 3 to 240 (accept: cases rose steadily each time coverage fell) [1]. (d) By 2020 coverage (90%) had fallen below the 93% needed for herd immunity [1], so there were enough unvaccinated people for the virus to keep passing from person to person [1]; the vaccine is also not 100% effective, so some vaccinated children were still susceptible, and as more people became infected the virus spread faster [1]. (e) Ethical: compulsory vaccination limits personal and parental choice (autonomy) [1], but protects babies and people with weak immune systems who cannot be vaccinated and rely on herd immunity [1]. Social: reduces illness and healthcare costs for the whole community, but may reduce trust in health authorities or punish families unfairly, whereas education about vaccine safety may persuade more people [1]. A balanced judgement or conclusion supported by reasoning [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Biology MYP 5 eAssessment Structure Mock B (8 tasks, 74 marks) (74 marks)
with sub as (select id from public.subjects where slug = $mq$biology$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Biology MYP 5 eAssessment Structure Mock B (8 tasks, 74 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Biology MYP 5 eAssessment Structure Mock B (8 tasks, 74 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6]]
The human circulatory system carries blood around the body.
(a) State the name of the type of blood vessel that carries blood away from the heart. (1 mark)
(b) Veins contain valves. State the function of these valves. (1 mark)
(c) Explain how the structure of a capillary makes it suited to exchanging substances with body cells. (2 marks)
(d) The wall of the left ventricle is much thicker than the wall of the right ventricle. Explain why. (2 marks)

Total for Question 1: 6 marks$mq$, $mq$(a) Artery [1]. (b) To stop the backflow of blood (keep blood flowing towards the heart) [1]. (c) The wall is only one cell thick, giving a short diffusion distance [1]; capillaries are very narrow and form a large network, giving a large surface area and slow flow so there is time for exchange [1]. (d) The left ventricle pumps blood to the whole body, which needs a high pressure [1]; the right ventricle only pumps blood to the nearby lungs, which needs a lower pressure, so a thinner muscle wall is enough [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 7]]
Cells release energy from glucose by respiration.
(a) Write the balanced chemical equation for aerobic respiration. (2 marks)
(b) State the name of the part of the cell where most aerobic respiration takes place. (1 mark)
(c) During a sprint, muscle cells also respire without oxygen. State the product of this process in muscle cells. (1 mark)
(d) Explain why a person keeps breathing heavily for several minutes after a sprint has finished. (2 marks)
(e) State one product of anaerobic respiration in yeast that is used to make bread rise. (1 mark)

Total for Question 2: 7 marks$mq$, $mq$(a) C6H12O6 + 6O2 -> 6CO2 + 6H2O: correct reactants and products [1]; correctly balanced [1] (award 1 for the correct word equation). (b) Mitochondria (mitochondrion) [1]. (c) Lactic acid [1]. (d) The extra oxygen is needed to break down the lactic acid that built up (the oxygen debt) [1]; the lactic acid is converted to carbon dioxide and water, or removed by the liver, and the muscles are restored to resting state [1]. (e) Carbon dioxide [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 7]]
Cystic fibrosis is an inherited condition caused by a recessive allele, f. The dominant allele is F. Two parents who do not have cystic fibrosis each carry one copy of the recessive allele.
(a) State the genotype of each parent. (1 mark)
(b) Complete a Punnett square for the cross and determine the probability that their child has cystic fibrosis. (2 marks)
(c) Define the term allele. (1 mark)
(d) Describe the structure of a DNA molecule. (2 marks)
(e) State what a gene codes for. (1 mark)

Total for Question 3: 7 marks$mq$, $mq$(a) Ff (both parents) [1]. (b) Gametes F and f from each parent; offspring FF, Ff, Ff, ff correctly shown [1]; probability = 1 in 4 (0.25 or 25%) [1]. (c) A different version of a gene [1]. (d) Two strands wound into a double helix [1]; held together by pairs of bases, A with T and C with G (accept: made of nucleotides with a sugar-phosphate backbone) [1]. (e) A protein (the order of amino acids in a protein) [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 8]]
On a hot day a runner's body temperature starts to rise above its normal value.
(a) State the name of the part of the brain that monitors body temperature. (1 mark)
(b) Describe two ways in which the skin responds to a rise in body temperature. (4 marks)
(c) State the normal core body temperature of a healthy person. (1 mark)
(d) Explain how this response is an example of negative feedback. (2 marks)

Total for Question 4: 8 marks$mq$, $mq$(a) Hypothalamus [1]. (b) Any two responses, each with a description and a reason (2 marks each): sweat glands release more sweat [1]; the evaporation of sweat takes heat from the skin and cools the body [1]. Blood vessels near the skin surface widen (vasodilation) [1]; more blood flows near the surface so more heat is lost by radiation to the surroundings [1]. (Accept hairs lying flat as a third response.) (c) About 37 degrees Celsius [1]. (d) A change away from the set point (a rise in temperature) is detected [1]; the response reverses the change and returns the temperature towards the set point [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 10]]
A student wants to investigate how temperature affects the rate of anaerobic respiration in yeast. The student mixes dried yeast with sugar solution in a boiling tube. A delivery tube leads from the boiling tube into limewater in a second tube. The student can heat the boiling tube in a water bath.
(a) State a research question that this investigation could answer. (2 marks)
(b) Formulate a testable hypothesis, using scientific reasoning. (2 marks)
(c) Identify the independent variable and the dependent variable. (2 marks)
(d) Outline a method that would allow the student to measure the rate of respiration at different temperatures. (3 marks)
(e) Outline one safety precaution for this investigation. (1 mark)

Total for Question 5: 10 marks$mq$, $mq$(a) A question that links both variables, for example: How does the temperature of the yeast and sugar mixture affect the rate of carbon dioxide production? [2] (1 mark if both variables are named but not linked). (b) A prediction, for example: as the temperature increases up to about 40 degrees Celsius the rate will increase, then fall at higher temperatures [1]; reasoning using enzymes: respiration is controlled by enzymes, which work faster as particles gain energy but denature at high temperature [1]. (c) Independent: temperature of the mixture [1]; dependent: rate of carbon dioxide production, for example bubbles per minute or time for limewater to turn cloudy [1]. (d) Set up water baths at several temperatures, for example 10, 20, 30, 40 and 50 degrees Celsius, and allow the mixture to reach each temperature [1]; at each temperature count the bubbles in the limewater tube (or measure the volume of gas in a syringe) over the same time, for example 5 minutes [1]; keep the volume and concentration of yeast and sugar, and the yeast mass, the same, and repeat the experiment to calculate a mean [1]. (e) Any one from: take care with hot water and hot glassware; wear eye protection; do not drink or taste the limewater and wash hands afterwards [1].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 10]]
A student investigates transpiration using a potometer. The capillary tube of the potometer has an internal radius of 0.50 mm. The student records how far an air bubble moves along the tube in 10 minutes for the same leafy shoot in four conditions.
Condition: still air, moving air (fan), humid air, bright light
Distance moved by the bubble in 10 minutes in mm: 42, 78, 18, 60
The volume of water taken in is given by volume = pi x r squared x distance, where r is the radius of the tube.
(a) Show that the volume of water taken up in still air in 10 minutes is about 33 cubic millimetres. (2 marks)
(b) Calculate the rate of water uptake in moving air, in cubic millimetres per minute. Give your answer to 2 significant figures. (3 marks)
(c) Calculate the percentage increase in the distance moved by the bubble in moving air compared with still air. (2 marks)
(d) Explain why the shoot takes up water more slowly in humid air. (2 marks)
(e) Evaluate one limitation of using a potometer to measure the rate of transpiration. (1 mark)

Total for Question 6: 10 marks$mq$, $mq$(a) Volume = pi x 0.50 squared x 42 [1] = 32.99 cubic millimetres, so about 33 [1]. (b) Volume = pi x 0.50 squared x 78 = 61.26 cubic millimetres [1]; divide by 10 minutes [1]; rate = 6.1 cubic millimetres per minute [1] (error carried forward is allowed). (c) (78 - 42) / 42 x 100 [1] = 86% (85.7%) [1]. (d) In humid air there is already a lot of water vapour in the air, so the concentration gradient of water vapour between the leaf and the air is smaller [1]; less water vapour diffuses out through the stomata, so transpiration and uptake of water are slower [1]. (e) A potometer measures water taken up, not water lost, and some water is used for photosynthesis or stays in the plant (accept: cutting the shoot and leaks of air affect the results; only one shoot was used) [1].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | D 10]]
Read the passage.
Hospital scientists in a fictional country are using three new technologies. A bioprinter lays down layers of a gel mixed with a patient's own cells to build patches of skin for burn victims. The team hopes to print whole kidneys in the future. In a second project, the genomes of tumour cells are mapped so that doctors can choose the drug most likely to work. The data are stored on a company's computers. In a third, a company offers to clone a customer's pet dog for a high fee, using a cell from the dog's skin. Only a few of the cloned embryos develop into healthy animals.
(a) Define the term clone. (1 mark)
(b) Outline one benefit of mapping the genome of a patient's tumour. (1 mark)
(c) Explain why printing skin from the patient's own cells reduces the risk of rejection. (2 marks)
(d) Discuss one ethical factor related to cloning pets and one social factor related to storing genome data. (4 marks)
(e) Suggest one way in which the use of these technologies could be regulated, and justify your suggestion. (2 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) A genetically identical copy of an organism (or cell) [1]. (b) Doctors can choose a drug or treatment suited to the genetic changes in the tumour, so treatment is more effective (accept: faster diagnosis, fewer side effects) [1]. (c) The immune system recognises foreign cells by their antigens [1]; cells from the patient have the same antigens as the rest of the body, so the immune system does not attack the new tissue [1]. (d) Ethical (2 marks): most cloned embryos do not develop into healthy animals, causing suffering or waste of life [1]; developed, for example, the animal suffering is hard to justify for a pet, and the clone will not be identical in personality or experience [1]. Social (2 marks): genome data are private and could be used by insurers or employers to discriminate against people [1]; developed, for example, patients must give informed consent and be told who can access their data [1]. (e) A sensible suggestion, for example an independent ethics committee must approve each project, or laws limit who can see genome data [1]; with justification, for example this protects patients' rights and prevents misuse while still allowing medical benefit [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 8 | C 4 | D 4]]
Read the passage and study the data.
Staphylococcus bacteria cause infections in hospital patients. Doctors use antibiotics to treat them. A hospital records the percentage of Staphylococcus samples that are resistant to a common antibiotic, and the number of prescriptions of this antibiotic for each 1000 patients.
Year: 2016, 2018, 2020, 2022
Samples resistant to the antibiotic (%): 4, 9, 19, 37
Prescriptions for each 1000 patients: 310, 420, 560, 700
(a) Explain how natural selection led to an increase in the percentage of resistant bacteria. (4 marks)
(b) Calculate how many times greater the percentage of resistant samples was in 2022 than in 2016. Give your answer to 2 significant figures. (2 marks)
(c) Describe the relationship between prescriptions and resistance and state why the data alone cannot prove that prescriptions cause resistance. (2 marks)
(d) Explain why a patient should finish a whole course of antibiotics, and why antibiotics are not used to treat viral infections. (4 marks)
(e) Evaluate two actions that hospitals could take to reduce antibiotic resistance, stating one advantage or drawback of each. (4 marks)

Total for Question 8: 16 marks$mq$, $mq$(a) Variation exists in the bacteria because of random mutations, and a few bacteria are resistant [1]; the antibiotic kills the non-resistant bacteria, so the resistant ones survive (selection pressure) [1]; the survivors reproduce and pass on the resistance allele to their offspring [1]; over many generations the proportion of resistant bacteria increases [1]. (b) 37 / 4 [1] = 9.25, so about 9.3 times (accept 9.2) [1]. (c) As prescriptions increase, the percentage of resistant samples also increases (positive correlation) [1]; correlation does not prove cause, because other factors may have changed, such as the number of patients with infections or hygiene (accept: more patients carrying resistant bacteria) [1]. (d) Finishing the course kills all the bacteria, including those that are less sensitive [1]; stopping early leaves survivors that can multiply, and these may be resistant [1]. Viruses are not living cells, and antibiotics work by damaging bacterial structures such as cell walls [1]; viruses live inside host cells and are not affected, so the antibiotic would not work and would only increase resistance [1]. (e) Any two actions each with an evaluation (2 marks each), for example: restrict prescriptions to confirmed bacterial infections [1], which slows the spread of resistance, but some patients might be under-treated [1]; improve hygiene such as hand washing and isolating infected patients [1], which reduces the spread of resistant bacteria without using drugs, but needs staff time and training [1]. (Accept: use a different antibiotic or two together, research into new antibiotics, vaccination.)$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Integrated Science MYP 5 eAssessment Structure Mock B (8 tasks, 75 marks) (75 marks)
with sub as (select id from public.subjects where slug = $mq$integrated-science$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Integrated Science MYP 5 eAssessment Structure Mock B (8 tasks, 75 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Integrated Science MYP 5 eAssessment Structure Mock B (8 tasks, 75 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6]]
Sodium and chlorine react to make sodium chloride. Sodium has atomic number 11 and mass number 23.
(a) State the number of neutrons in an atom of sodium. (1 mark)
(b) State the electron arrangement of a sodium atom. (1 mark)
(c) Explain why sodium is placed in Group 1 of the periodic table. (1 mark)
(d) Chlorine has two isotopes, chlorine-35 and chlorine-37. State what is meant by the term isotope. (1 mark)
(e) In a sample of chlorine, 75% of the atoms are chlorine-35 and 25% are chlorine-37. Calculate the relative atomic mass of chlorine. (2 marks)

Total for Question 1: 6 marks$mq$, $mq$(a) 23 - 11 = 12 neutrons [1]. (b) 2,8,1 [1]. (c) It has one electron in its outer shell (accept: it forms ions with a 1+ charge) [1]. (d) Atoms of the same element with the same number of protons but different numbers of neutrons [1]. (e) (75 x 35 + 25 x 37) / 100 [1] = 35.5 [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 7]]
A cyclist and bicycle have a combined mass of 80 kg and are travelling at 6.0 m/s along a level road. The cyclist brakes and the bicycle comes to rest in 4.0 s.
(a) Calculate the kinetic energy of the cyclist and bicycle before braking. (2 marks)
(b) Calculate the deceleration of the bicycle, assuming it is constant. (2 marks)
(c) Calculate the resultant force that acts on the bicycle while it is slowing down. (1 mark)
(d) Explain what happens to the kinetic energy as the bicycle slows down. (2 marks)

Total for Question 2: 7 marks$mq$, $mq$(a) KE = 1/2 x m x v² = 0.5 x 80 x 6.0² [1] = 1440 J [1]. (b) a = change in speed / time = (6.0 - 0) / 4.0 [1] = 1.5 m/s² [1]. (c) F = m x a = 80 x 1.5 = 120 N [1] (error carried forward from (b)). (d) The kinetic energy is transferred to thermal energy (heat) in the brakes, tyres and road [1]; energy is conserved, so the total energy stays the same but is spread out into the surroundings and is not useful [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 7]]
Gas exchange takes place in the alveoli of the lungs.
(a) Name the gas that diffuses from the air in the alveoli into the blood. (1 mark)
(b) Describe two features of the alveoli that make gas exchange efficient. (2 marks)
(c) Explain why a person's breathing rate increases during exercise. (2 marks)
(d) Describe the movement of the diaphragm and the effect on the chest during inhalation. (2 marks)

Total for Question 3: 7 marks$mq$, $mq$(a) Oxygen [1]. (b) Any two from: walls are one cell thick, so the diffusion distance is short; very large total surface area from millions of alveoli; covered by a dense network of capillaries which maintains the concentration gradient; moist surface so gases dissolve [1][1]. (c) The muscles respire faster and produce more carbon dioxide, which is detected by the brain [1]; breathing faster gets oxygen in and removes carbon dioxide more quickly [1]. (d) The diaphragm contracts and moves down (flattens) [1]; the volume of the chest increases and the pressure falls, so air is drawn into the lungs [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 7]]
Indigestion is caused by too much hydrochloric acid in the stomach. Indigestion tablets contain magnesium hydroxide, which neutralises the acid.
(a) State the pH of a neutral solution. (1 mark)
(b) State the colour of universal indicator in a strong acid. (1 mark)
(c) Write a word equation for the reaction between hydrochloric acid and sodium hydroxide. (1 mark)
(d) Balance the equation for the reaction between magnesium hydroxide and hydrochloric acid: Mg(OH)2 + HCl -> MgCl2 + H2O (2 marks)
(e) Suggest why sodium hydroxide solution would not be used in an indigestion remedy. (1 mark)
(f) Name the type of reaction between an acid and a base. (1 mark)

Total for Question 4: 7 marks$mq$, $mq$(a) pH 7 [1]. (b) Red [1]. (c) Hydrochloric acid + sodium hydroxide -> sodium chloride + water [1]. (d) Mg(OH)2 + 2HCl -> MgCl2 + 2H2O: coefficient 2 before HCl [1]; coefficient 2 before H2O [1]. (e) It is a strong alkali that is corrosive and would damage the stomach and throat [1]. (f) Neutralisation [1].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 10]]
A student wants to find out how the length of a simple pendulum affects the time it takes to swing. A small metal bob hangs from a thread tied to a clamp. The student pulls the bob a short distance to one side, releases it, and times the swings with a stopwatch.
(a) State a research question that this investigation could answer. (2 marks)
(b) Formulate a testable hypothesis, using scientific reasoning. (2 marks)
(c) Identify the independent variable and the dependent variable. (2 marks)
(d) Describe how the student can obtain an accurate value for the time of one swing, and measure the length. (2 marks)
(e) Outline one variable that must be controlled. (1 mark)
(f) Outline one safety precaution for this investigation. (1 mark)

Total for Question 5: 10 marks$mq$, $mq$(a) A question linking both variables, for example: How does the length of a pendulum affect the time taken for one complete swing (the period)? [2] (1 mark if both variables are named but not linked). (b) A prediction, for example: a longer pendulum will take longer for each swing [1]; with reasoning, for example: the bob has further to travel along a longer arc, and the restoring force acts more slowly (accept: a longer pendulum has a larger period because the bob travels a longer path) [1]. (c) Independent: length of the thread [1]; dependent: time for one swing (period) [1]. (d) Time 20 swings and divide by 20, which reduces the effect of reaction time [1]; measure the length with a metre rule from the clamp to the centre of the bob [1]. (e) Any one from: mass of the bob, starting angle (the same small release angle), same bob and thread [1]. (f) Any one from: make sure the clamp stand is secure so it cannot fall; keep the area clear so no one trips; wear eye protection [1].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 10]]
A student adds zinc powder to 50 cm³ of copper sulfate solution of concentration 0.50 mol/dm³ in an insulated cup and records the highest temperature rise. The reaction is zinc + copper sulfate -> zinc sulfate + copper.
Mass of zinc in g: 0.5, 1.0, 1.5, 2.0, 2.5
Temperature rise in degrees Celsius: 4.8, 9.6, 14.1, 15.4, 15.4
(a) State whether the reaction is exothermic or endothermic and give evidence from the data. (1 mark)
(b) Describe the trend in the temperature rise as the mass of zinc increases. (2 marks)
(c) Calculate the mass of zinc that reacts with all of the copper sulfate. The relative atomic mass of zinc is 65. The equation shows that 1 mol of zinc reacts with 1 mol of copper sulfate. (3 marks)
(d) Use your answer to (c) to explain the trend between 2.0 g and 2.5 g of zinc. (1 mark)
(e) Use the data to determine the temperature rise expected with 0.75 g of zinc. (1 mark)
(f) Evaluate one limitation of the method and suggest an improvement. (2 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) Exothermic, because the temperature rises [1]. (b) The temperature rise increases as the mass of zinc increases, roughly in direct proportion at first (about 9.6 degrees Celsius per gram up to 1.5 g) [1]; it then levels off at 15.4 degrees Celsius and does not increase further [1]. (c) Amount of copper sulfate = 0.050 dm³ x 0.50 mol/dm³ = 0.025 mol [1]; 1 : 1 ratio so 0.025 mol of zinc is needed [1]; mass = 0.025 x 65 = 1.6 g (1.625 g) [1]. (d) All of the copper sulfate has already reacted (it is the limiting reactant) when 1.6 g of zinc has been added, so extra zinc cannot react and release more energy [1]. (e) 7.2 degrees Celsius (midway between 4.8 and 9.6; accept values from 7.0 to 7.4) [1]. (f) A limitation, for example heat is lost to the surroundings, so the temperature rises are lower than the true values (accept: zinc powder may react at different speeds, or the thermometer reading is only to 0.1 degrees Celsius) [1]; an improvement, for example use a lid on the cup, or a thicker layer of insulation, and stir the mixture [1].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | D 10]]
Read the passage.
Clothes made from polyester and nylon shed tiny plastic fibres, called microplastics, each time they are washed. Wastewater treatment plants remove most of the fibres, but the rest are carried into rivers and the sea. Small animals such as shellfish and plankton eat them, and the fibres can carry harmful chemicals. Filters that fit inside washing machines can catch most of the fibres, but they cost money and must be emptied regularly. Some governments are considering a law that requires filters in all new machines. Manufacturers say this will make machines more expensive.
(a) Outline how microplastic fibres can enter a food chain and reach humans. (2 marks)
(b) Describe two ways of reducing the release of microplastic fibres from laundry. (2 marks)
(c) Discuss one economic factor and one political factor that affect how this problem is solved. (4 marks)
(d) Suggest and justify one action that should be taken first. (2 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) Fibres are eaten by small organisms such as plankton and shellfish [1]; these are eaten by fish and other animals, and the fibres move up the food chain to humans who eat seafood [1]. (b) Any two from: fit filters to washing machines; wash clothes less often or with full loads at a lower temperature; choose natural fabrics instead of synthetic ones; improve filtering at wastewater plants [1][1]. (c) Economic: filters raise the cost of machines and need emptying, so consumers or manufacturers may resist [1]; developed, for example, poorer households may not be able to afford new machines, or the long-term cost of cleaning up the sea is higher than the cost of the filters [1]. Political: a law would force all manufacturers to fit filters [1]; developed, for example, governments must balance public pressure for the environment against pressure from industry, and laws need international agreement because rivers and seas cross borders [1]. (d) A sensible action [1] with justification, for example require filters in new machines because this stops the fibres at source and is more effective than cleaning up the sea afterwards [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 7 | C 7 | D 4]]
A school plans to heat water for its sports-hall showers using a solar thermal panel. The panel has an area of 4.0 square metres. The average sunlight energy arriving at the panel is 600 W for each square metre, and the panel transfers 55% of this to the water. The tank holds 150 kg of water, which must be heated from 15 degrees Celsius to 45 degrees Celsius. The specific heat capacity of water is 4200 J/kg degrees Celsius. Energy = mass x specific heat capacity x temperature change.
(a) Describe how energy from the Sun is transferred to the water in the tank. (3 marks)
(b) Explain why the panel surface is black and the pipes are made of copper. (2 marks)
(c) Show that the useful power transferred to the water is 1320 W. (2 marks)
(d) Calculate the energy needed to heat the water in the tank. (3 marks)
(e) Calculate the time needed to heat the water, in hours. Give your answer to 2 significant figures. (2 marks)
(f) Bacteria that cause Legionnaires' disease multiply fastest in water at temperatures between about 20 and 45 degrees Celsius and are killed above 60 degrees Celsius. The system is heated to above 60 degrees Celsius once a week. Explain how this heating kills the bacteria. (2 marks)
(g) The school could instead use a gas boiler. Evaluate the two heating systems and recommend one. (4 marks)

Total for Question 8: 18 marks$mq$, $mq$(a) Energy travels from the Sun to the panel by radiation (electromagnetic waves, infrared and visible light) [1]; the panel absorbs the radiation and the pipes are heated; thermal energy passes through the pipe wall to the water by conduction [1]; the warm water rises and circulates through the tank by convection, so the whole tank is heated [1]. (b) Black surfaces are good absorbers of radiation (and poor reflectors) [1]; copper is a good conductor of thermal energy, so heat passes quickly to the water [1]. (c) Power arriving = 600 x 4.0 = 2400 W [1]; useful power = 0.55 x 2400 = 1320 W [1]. (d) Temperature change = 45 - 15 = 30 degrees Celsius [1]; energy = 150 x 4200 x 30 [1] = 18 900 000 J (18.9 MJ) [1]. (e) Time = energy / power = 18 900 000 / 1320 = 14 318 s [1]; 14 318 / 3600 = 4.0 hours [1]. (f) Bacterial cells contain enzymes, which are proteins [1]; above 60 degrees Celsius the enzymes' shape changes (they denature), so the bacteria can no longer respire or grow and they die [1]. (g) Solar: no fuel cost or carbon dioxide emissions in use, and it uses a renewable source [1]; but it is only available when the Sun shines, so the 4.0 hours of heating needs good weather and the installation costs a lot [1]. Gas boiler: heats on demand at any time, but burns a fossil fuel, producing carbon dioxide that adds to climate change and costs more to run [1]. A recommendation supported by the evidence, for example solar with a gas boiler as back-up on cloudy days [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);


commit;
