begin;
-- English Language and Literature MYP 5 eAssessment Paper C (3 tasks, 80 marks) (80 marks)
with sub as (select id from public.subjects where slug = $mq$english-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$English Language and Literature MYP 5 eAssessment Paper C (3 tasks, 80 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$English Language and Literature MYP 5 eAssessment Paper C (3 tasks, 80 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1.1 | A 2]]
Task 1: Analysing
Questions 1.1 to 1.4 focus on the key concept of communication. Question 1.5 focuses on the key concept of connections. The criteria assessed are A (Analysing) and B (Organizing). Suggested time for Questions 1.1 to 1.4: 15 minutes. Suggested time for Question 1.5: 35 minutes.

Text A: 'The Quiet Quarter' (a short story extract, written for this paper)
This extract is from a story set in a city where citizens' conversations are measured by wall-mounted meters.

On Verity Street the meters hummed all day, a low green note that Kiri had stopped hearing years ago, the way you stop hearing your own heartbeat. Every doorway had one: a small white box with a dial, its needle trembling between CALM and CONCERN. Nobody spoke above the green.

Kiri's mother taught her the code before she could read. Two fingers on the wrist meant danger. A tapped temple meant listen. A hand pressed flat against the chest meant I love you, which was the only sentence nobody had ever managed to ban, because nobody could hear it.

That morning, walking to the water depot, Kiri found a bird. It was a sparrow, brown and ordinary, wedged in the grating of the pavement, and it was singing. Not the polite chirp of the loudspeaker birds that piped out of the lamp-posts every dawn, but a ragged, joyful, off-key song that climbed the brick like ivy.

The needle on the nearest meter shivered. Moved. Crossed into amber.

Kiri knelt. Her heart beat so loud she was certain the whole street could count it. The sparrow tilted its head at her, and for the first time in her life she thought: it is not the noise that is dangerous. It is the listening.

Somewhere behind her, a door unlocked.

She did not look round. She pressed a hand flat against her chest, and the sparrow sang on.

Text B: a graphic-novel page (written for this paper; in the live exam this would be an illustrated page)
Title of the graphic novel: 'Static'. Page 14. Four panels, described in words.

PANEL 1 (wide, top of page). A grey city skyline seen from a rooftop. Every window is a rectangle of television light, all the same blue. A boy, Jonah, in a hooded jacket sits at the edge of the roof with his back to us. Caption (yellow box, top left): "Everyone I know is watching the same thing."

PANEL 2 (small, square). Extreme close-up of Jonah's face, lit by the screen of a small handheld radio. One eye only is shown, wide and bright. Sound effect, jagged letters curving across the panel: KSSSHHH-krrk. Speech bubble with a wobbly outline, from the radio: "...anyone... out there...?"

PANEL 3 (small, square). A tall, thin figure in a white coat stands on the roof behind Jonah, casting a long shadow across the page. The figure's face is blank, with no features. A thought bubble, with small circles leading to Jonah's head, contains only: "!"

PANEL 4 (wide, bottom of page, no border). The full-page background turns completely black. In the centre, small white letters: "I turned the dial. I will not turn it back." The bottom corner of the panel is torn, as if the page is breaking.

Q 1.1 Comment on the use of the sound of the meters in the first paragraph of Text A. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies the meters' sound without explaining, e.g. the meters hum all day. [1] Level 2 (2 marks): comments with some explanation, e.g. the 'low green note' that Kiri 'had stopped hearing' shows constant surveillance has become normal, and the simile of the heartbeat shows how deeply it is part of her. [1]$mq$, $mq$A$mq$),
(2, $mq$[[Q 1.2 | A 3]]
Refer to Text A (printed in Question 1.1). Explain the effect of the sentence 'it is not the noise that is dangerous. It is the listening.' (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies an effect without development, e.g. it shows Kiri has a new thought. [1] Level 2 (2 marks): describes an effect with some explanation, e.g. the contrast of 'noise' and 'listening' shifts the blame from the sparrow to the system of surveillance. [1] Level 3 (3 marks): explains the effect consistently with quotation, e.g. the two short parallel sentences, the pause of the full stop and the structure 'not X... It is Y' deliver a moment of revelation, so the reader sees Kiri's first act of independent thought and the story's theme that authority, not freedom, is the true threat. [1]$mq$, $mq$A$mq$),
(3, $mq$[[Q 1.3 | A 3]]
Refer to Text B (printed in Question 1.1). Analyse the effect of the sound effect and speech bubble in Panel 2. (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies a feature with no development, e.g. there is a noise from the radio. [1] Level 2 (2 marks): describes the effect with some justification, e.g. the jagged lettering of KSSSHHH-krrk shows the poor signal and suggests tension. [1] Level 3 (3 marks): analyses the effect consistently with precise reference, e.g. the curving, jagged sound effect makes the reader hear the interference, while the wobbly outline and broken ellipses in '...anyone... out there...?' suggest a faint, fragile human voice, so the audience feels the loneliness and hope of contact outside the controlled world. [1]$mq$, $mq$A$mq$),
(4, $mq$[[Q 1.4 | A 2]]
Refer to Text B (printed in Question 1.1). Describe the purpose of the final panel. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a purpose without explanation, e.g. it ends the page. [1] Level 2 (2 marks): describes a purpose with an example, e.g. the black borderless background and torn corner show that the safe world has broken, and the small white text with Jonah's words reads as a decisive vow, leaving the reader eager to see the consequences. [1]$mq$, $mq$A$mq$),
(5, $mq$[[Q 1.5 | A 10 | B 10]]
Refer to Text A and Text B (printed in Question 1.1). Compare and contrast how the two texts present individuals who resist control. (Approximately 350 words) (20 marks)

Criterion A (Analysing) is worth 10 marks and Criterion B (Organizing) is worth 10 marks.$mq$, $mq$Criterion A (10 marks) and Criterion B (10 marks), 20 marks in total. Criterion A (10 marks): 9 to 10 marks for effective, perceptive analysis of content, language, structure and technique in both texts with extensive, well-chosen evidence; 6 to 8 for considerable analysis with sufficient, relevant evidence; 3 to 5 for adequate analysis with some evidence; 1 to 2 for limited analysis with few or no examples. Indicative content: Text A (third-person, past tense, limited viewpoint): setting of surveillance through the meters and colour (green, amber); code gestures; the sparrow as symbol of natural freedom contrasted with the 'loudspeaker birds'; simile ('like ivy'); the quiet, understated resistance of the flat hand on the heart; a final line of open tension ('a door unlocked'). Text B (graphic novel, first-person caption): visual conformity (identical blue windows), the radio as lifeline, onomatopoeia, the faceless figure as a symbol of authority, shadow, panel size and the borderless black final panel; direct declaration of choice ('I will not turn it back'). Contrast: small, silent, emotional rebellion vs a decisive, active turn of the dial; subtle suggested threat vs visually looming threat; language-led vs image-led. Similarity: both end on moments of commitment and both use symbols of communication (bird, radio). Award up to [10] for Criterion A. Criterion B (10 marks): 9 to 10 marks for effective organisation: clear structure, comparison and contrast sustained throughout, effective linking and a conclusion; 6 to 8 for a considerable degree of organisation with sustained comparison; 3 to 5 for an adequate degree of organisation with some comparison; 1 to 2 for limited organisation, with the texts mostly treated separately. Indicative content: a clear thesis in the introduction; thematic paragraphs (e.g. the control system, the symbols of freedom, the resistance); explicit comparison words; precise integrated references to both texts; a conclusion that evaluates how form shapes the portrayal. Award up to [10] for Criterion B.$mq$, $mq$A$mq$),
(6, $mq$[[Q 2.1 | C 10 | D 10]]
Task 2: Producing literary text
This task focuses on the key concept of creativity. The criteria assessed are C (Producing text) and D (Using language).

Image 1 (described in words): a vast field of sunflowers at the end of a hot day, all facing the same direction except one, which has turned its head toward the camera. A rusty bicycle leans against a fence post at the edge of the field.
Image 2 (described in words): a narrow stairwell in an old building. Each step is worn in the middle. A coat has been left on the bannister. At the top of the stairs a door stands slightly open, and a bar of white light spills out onto the dark wood.

Using one of the images, write a short story or the opening of a story, in which a character makes a decision that changes their life. You may consider purpose, characterisation, setting, mood and point of view. State which image you are using before you start. (Approximately 350 words) (20 marks)$mq$, $mq$Criterion C (10 marks): 9 to 10 marks for a high degree of insight and imagination, perceptive stylistic choices and extensive precise detail; 6 to 8 for considerable insight and imagination, thoughtful choices and sufficient detail; 3 to 5 for some insight and imagination, some stylistic choices and some detail; 1 to 2 for limited insight, few stylistic choices and little detail. Indicative content: a named image integrated into setting or plot; a clearly motivated character and a believable moment of choice; tension and a controlled narrative arc; symbolism (the one sunflower, the open door); a purposeful ending. A response that uses neither image nor the prompt scores 0 for C. Award up to [10] for Criterion C. Criterion D (10 marks): 9 to 10 marks for an effective range of vocabulary and sentence structures, consistently suitable register and high accuracy with only minor errors; 6 to 8 for a varied range, considerable accuracy and errors that do not hinder communication; 3 to 5 for an adequate range, a degree of accuracy and errors that sometimes hinder communication; 1 to 2 for a limited range, with errors that often hinder communication. Indicative content: a deliberate narrative voice, varied sentence lengths, precise verbs, figurative language, consistent tense, and accurate punctuation and paragraphing. Award up to [10] for Criterion D.$mq$, $mq$C$mq$),
(7, $mq$[[Q 3.1 | B 10 | C 10 | D 10]]
Task 3: Producing non-literary text
This task focuses on the key concept of communication. You will create a piece of non-literary writing in relation to the global context scientific and technical innovation: digital life and the impact of technology on communities.

Your school is considering a plan to issue every student with a tablet and replace printed textbooks and exercise books. Write an article for the school magazine giving your view on whether this plan is a good idea. The criteria assessed are B (Organizing), C (Producing text) and D (Using language). (Approximately 350 words) (30 marks)$mq$, $mq$Criterion B (10 marks): organisation suited to a magazine article: headline, optional standfirst, engaging opening, logical paragraphs for each argument or counter-argument, and a conclusion; 9 to 10 effective, 6 to 8 considerable, 3 to 5 adequate, 1 to 2 limited. Award up to [10] for Criterion B. Criterion C (10 marks): perspective on technology in communities shown through insight, relevant detail and examples (access, distraction, equity, environment, handwriting, learning); 9 to 10 high degree of insight and extensive detail, 6 to 8 considerable, 3 to 5 some, 1 to 2 limited. Award up to [10] for Criterion C. Criterion D (10 marks): register suited to a school-magazine readership, varied sentence structures, a clear authorial voice and sensible use of persuasive devices (rhetorical question, anecdote, balanced contrast), with accurate grammar and punctuation; 9 to 10 high accuracy and effective register, 6 to 8 considerable, 3 to 5 a degree, 1 to 2 minimal. Award up to [10] for Criterion D.$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- Chemistry MYP 5 eAssessment Paper A (8 tasks, 69 marks) (69 marks)
with sub as (select id from public.subjects where slug = $mq$chemistry$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Chemistry MYP 5 eAssessment Paper A (8 tasks, 69 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Chemistry MYP 5 eAssessment Paper A (8 tasks, 69 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6]]
A cotton wool pad soaked in concentrated ammonia solution (releases ammonia gas, NH₃) is placed at one end of a long, dry glass tube. A pad soaked in concentrated hydrochloric acid (releases hydrogen chloride gas, HCl) is placed at the other end. Both ends are sealed with stoppers. After a few minutes a white ring forms inside the tube. Relative molecular masses: NH₃ = 17, HCl = 36.5.
(a) Name the process by which the gases move along the tube. (1 mark)
(b) Explain, using the particle model, why gases mix faster than liquids. (2 marks)
(c) State where the white ring forms (select: nearer the ammonia end / nearer the hydrochloric acid end) and explain your choice. (2 marks)
(d) Name the white solid that forms. (1 mark)

Total for Question 1: 6 marks$mq$, $mq$(a) Diffusion [1]. (b) The particles of a gas are far apart and move quickly in random directions, with few forces between them [1]; liquid particles are close together and move more slowly, so they spread more slowly [1]. (c) Nearer the hydrochloric acid end [1]; ammonia molecules have a smaller mass than hydrogen chloride molecules, so at the same temperature they move faster and travel further before meeting [1]. (d) Ammonium chloride [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 7]]
The periodic table arranges elements by atomic number.
(a) An aluminium atom has atomic number 13. State its electron arrangement. (1 mark)
(b) An element has the electron arrangement 2,8,6. State the group and the period of this element. (2 marks)
(c) The halogens are in Group 7. State the trend in reactivity going down the group and explain it. (3 marks)
(d) Chlorine water is added to a colourless solution of potassium iodide. State what you would see. (1 mark)

Total for Question 2: 7 marks$mq$, $mq$(a) 2,8,3 [1]. (b) Group 6 (also called group 16) [1]; period 3 (three occupied shells) [1]. (c) Reactivity decreases down the group [1]; atoms get larger, so the outer shell is further from the nucleus and more shielded [1]; so an incoming electron is attracted less strongly, making it harder to gain an electron [1]. (d) The solution turns brown (iodine is formed) [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
Iron is extracted from iron(III) oxide, Fe₂O₃, in a blast furnace. Relative atomic masses: Fe = 56, O = 16.
(a) Write the chemical formulae of aluminium oxide and of calcium nitrate (calcium ion Ca²⁺, nitrate ion NO₃⁻). (2 marks)
(b) Balance the equation: Fe₂O₃ + CO → Fe + CO₂ (1 mark)
(c) Calculate the mass of iron produced from 80 g of iron(III) oxide. Show each step of the working. (3 marks)
(d) Calculate the percentage by mass of iron in iron(III) oxide. (2 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) Al₂O₃ [1]; Ca(NO₃)₂ [1]. (b) Fe₂O₃ + 3CO -> 2Fe + 3CO₂ [1]. (c) Mr of Fe₂O₃ = 2 x 56 + 3 x 16 = 160; moles = 80/160 = 0.50 mol [1]; mole ratio Fe₂O₃ : Fe = 1 : 2, so 1.0 mol Fe [1]; mass = 1.0 x 56 = 56 g [1]. (d) 112/160 [1] x 100 = 70% [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 10]]
Hydrogen peroxide solution decomposes slowly to form water and oxygen: 2H₂O₂ -> 2H₂O + O₂. Manganese(IV) oxide, MnO₂, is a black powder that acts as a catalyst for this reaction. A student wants to find out how the mass of manganese(IV) oxide affects the rate of the reaction. She adds 0.1 g, 0.2 g, 0.3 g and 0.4 g of manganese(IV) oxide to separate flasks that contain 25 cm³ of hydrogen peroxide solution, and collects the oxygen in a gas syringe.
(a) Formulate a testable hypothesis using scientific reasoning. (2 marks)
(b) Identify the independent variable and the dependent variable. Describe how the dependent variable could be measured. (3 marks)
(c) Outline two variables that must be controlled. (2 marks)
(d) State the control experiment she should include and explain why. (2 marks)
(e) Outline one safety precaution. (1 mark)

Total for Question 4: 10 marks$mq$, $mq$(a) A prediction linking the variables, e.g. more catalyst gives a faster rate of oxygen production [1]; reasoning, e.g. more catalyst gives more surface for the reaction, providing an alternative pathway of lower activation energy, so more collisions are successful per second [1]. (b) Independent: mass of manganese(IV) oxide [1]; dependent: rate of reaction/volume of oxygen collected in a fixed time (or time to collect a fixed volume) [1]; measured with a gas syringe and stopwatch, recording the volume at regular intervals [1]. (c) Any two from: volume and concentration of hydrogen peroxide, temperature, particle size/form of the manganese(IV) oxide, same apparatus [1][1]. (d) A flask with no manganese(IV) oxide (0.0 g) [1]; to show how much oxygen is produced without the catalyst, so any difference is due to the catalyst [1]. (e) Any one from: wear eye protection (hydrogen peroxide can irritate/bleach), clamp the gas syringe so it does not fall, wash hands/ clean spills [1].$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | C 12]]
A class makes simple electrochemical cells. In each cell one metal strip and a copper strip are placed in the same beaker of dilute sulfuric acid, with a voltmeter connected across the strips. Each cell was tested twice. The more reactive metal is connected to the negative terminal of the voltmeter.

Metal paired with copper: magnesium | zinc | iron | tin
Voltage, trial 1 (V): 2.6 | 1.08 | 0.77 | 0.52
Voltage, trial 2 (V): 2.8 | 1.12 | 0.83 | 0.48
Mean voltage (V): 2.7 | 1.10 | ? | 0.50

(a) Calculate the missing mean voltage for iron. (1 mark)
(b) State which metal is the most reactive of the four metals, using the data. (1 mark)
(c) Describe the relationship between the voltage and the position of the metal in the reactivity series. (2 marks)
(d) Explain why the voltage is larger when the two metals are further apart in the reactivity series. (2 marks)
(e) The voltage of a cell is the difference between the voltages of its two metals when each is compared with copper. Predict the voltage of a magnesium-zinc cell. (2 marks)
(f) Write the half-equation for the change at the zinc strip in the zinc-copper cell. (1 mark)
(g) Evaluate the reliability of the results and suggest one improvement. (3 marks)

Total for Question 5: 12 marks$mq$, $mq$(a) (0.77 + 0.83)/2 = 0.80 V [1]. (b) Magnesium, because it gives the highest voltage with copper [1]. (c) The more reactive the metal compared with copper, the larger the voltage [1]; order of voltage Mg (2.7) > Zn (1.10) > Fe (0.80) > Sn (0.50) matches the reactivity series order [1]. (d) A more reactive metal loses electrons (is oxidised) more readily [1]; a larger difference in tendency to lose electrons gives a larger push on the electrons in the external circuit, so a larger voltage [1]. (e) 2.7 - 1.10 [1] = 1.6 V [1]. (f) Zn -> Zn²⁺ + 2e⁻ [1]. (g) The repeats agree closely for zinc, iron and tin (differences of 0.04 to 0.06 V), so these results are reasonably reliable [1]; the magnesium repeats differ by 0.2 V, which is less reliable, possibly because of an oxide layer on the magnesium [1]; improvement, e.g. clean the strips with sandpaper, use the same area of metal in the acid, and take at least three repeats [1].$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | A 8]]
Esters are organic compounds that are used in perfumes and food flavourings. Ethyl ethanoate, CH₃COOCH₂CH₃, is made by heating ethanol with ethanoic acid and a few drops of concentrated sulfuric acid. Relative atomic masses: C = 12, H = 1, O = 16.
(a) Name the ester made from methanol and propanoic acid. (1 mark)
(b) State the role of the concentrated sulfuric acid. (1 mark)
(c) Name the compound CH₃CH₂CH₂COOH. (1 mark)
(d) Name the compound CH₃CH(OH)CH₃. (1 mark)
(e) Name the compound CH₃CH=CHCH₃. (1 mark)
(f) State one property of esters that makes them useful in perfumes. (1 mark)
(g) State the molecular formula of ethyl ethanoate. (1 mark)
(h) Calculate the relative formula mass of ethyl ethanoate. (1 mark)

Total for Question 6: 8 marks$mq$, $mq$(a) Methyl propanoate [1]. (b) Catalyst [1]. (c) Butanoic acid [1]. (d) Propan-2-ol [1]. (e) But-2-ene [1]. (f) They have a pleasant fruity smell / are volatile [1]. (g) C₄H₈O₂ [1]. (h) 4 x 12 + 8 x 1 + 2 x 16 = 88 [1].$mq$, $mq$A$mq$),
(7, $mq$[[Q 7 | A 2 | C 2 | D 6]]
Read the passage.
Seawater absorbs some of the carbon dioxide in the atmosphere. Carbon dioxide dissolves and reacts with water to form a weak acid, which releases hydrogen ions. Before industrialisation the carbon dioxide level in the atmosphere was about 280 parts per million (ppm); it is now about 420 ppm. Over the same time the average pH of surface seawater has fallen from about 8.2 to about 8.1. Animals such as corals, oysters and some plankton build shells and skeletons of calcium carbonate, which reacts with acid: CaCO₃ + 2H⁺ -> Ca²⁺ + H₂O + CO₂. Coastal communities rely on shellfish farming and on reefs, which attract tourists and protect coasts from storms. Some scientists propose adding powdered limestone to the sea near reefs, but this would be expensive and could only be done over small areas.
(a) State the approximate percentage of nitrogen in the Earth's atmosphere. (1 mark)
(b) State whether seawater of pH 8.1 is acidic or alkaline. (1 mark)
(c) Calculate the percentage increase in atmospheric carbon dioxide from 280 ppm to 420 ppm. (2 marks)
(d) Discuss the impacts of rising carbon dioxide levels on marine organisms and on people, and evaluate the proposal to add limestone to the sea. (6 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) About 78% (accept 78 to 80%) [1]. (b) Slightly alkaline (pH above 7) [1]. (c) (420 - 280)/280 [1] x 100 = 50% [1]. (d) Up to 6 marks: impact on organisms linked to chemistry, e.g. more dissolved CO₂ releases more H⁺, lowering pH; the acid reacts with calcium carbonate shells so organisms struggle to build or keep shells and reefs [1][1]; impact on people, e.g. loss of income from shellfish farming and tourism, loss of coastal protection from reefs [1][1]; evaluation of the limestone proposal, e.g. limestone is a base that neutralises the acid, but it is expensive and only works over small areas [1]; justified conclusion, e.g. it can only protect valuable reefs temporarily, so reducing carbon dioxide emissions is the long-term solution [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 8]]
Dinitrogen tetroxide, N₂O₄ (colourless gas), and nitrogen dioxide, NO₂ (brown gas), are in equilibrium in a sealed syringe: N₂O₄(g) ⇌ 2NO₂(g). The forward reaction is endothermic.
(a) State what the symbol ⇌ shows. (1 mark)
(b) State two features of a system at dynamic equilibrium. (2 marks)
(c) The syringe is placed in hot water and the gas becomes a darker brown. Explain what this shows about the position of equilibrium and why it changes. (2 marks)
(d) The plunger is pushed in to increase the pressure at constant temperature. State and explain the colour change that is eventually seen, ignoring the first moment when the gas is compressed. (2 marks)
(e) State the effect of adding a catalyst on the position of equilibrium. (1 mark)

Total for Question 8: 8 marks$mq$, $mq$(a) The reaction is reversible (can go in both directions) [1]. (b) Any two from: forward and reverse reactions occur at the same rate; the concentrations of reactants and products stay constant; it occurs in a closed system [1][1]. (c) The equilibrium moves to the right, producing more NO₂ [1]; because the forward reaction is endothermic, so raising the temperature favours the reaction that absorbs heat [1]. (d) The mixture becomes paler (less brown) [1]; the equilibrium moves to the side with fewer gas molecules, N₂O₄ (1 mole of gas compared with 2 moles of NO₂) [1]. (e) No effect on the position (it only speeds up how fast equilibrium is reached) [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Chemistry MYP 5 eAssessment Paper B (8 tasks, 67 marks) (67 marks)
with sub as (select id from public.subjects where slug = $mq$chemistry$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Chemistry MYP 5 eAssessment Paper B (8 tasks, 67 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Chemistry MYP 5 eAssessment Paper B (8 tasks, 67 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6]]
The table shows the numbers of subatomic particles in four particles A, B, C and D. Particles A and D are formed from the same element.

Particle: A | B | C | D
Protons: 11 | 17 | 8 | 11
Neutrons: 12 | 18 | 8 | 13
Electrons: 10 | 18 | 10 | 11

(a) State the charge on particle A. (1 mark)
(b) State the mass number (nucleon number) of particle A. (1 mark)
(c) State which two particles are isotopes of each other and explain your answer. (2 marks)
(d) Explain why an atom has no overall electrical charge. (1 mark)
(e) State the electron arrangement of particle C. (1 mark)

Total for Question 1: 6 marks$mq$, $mq$(a) 1+ (11 protons and 10 electrons) [1]. (b) 11 + 12 = 23 [1]. (c) A and D [1]; same number of protons (same atomic number) but different numbers of neutrons [1]. (d) It has equal numbers of protons (positive) and electrons (negative) [1]. (e) 2,8 [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 7]]
Magnesium oxide, MgO, is used to line furnaces. Carbon dioxide, CO₂, is a gas at room temperature.
(a) Describe the formation of magnesium oxide from magnesium atoms and oxygen atoms in terms of electrons. (3 marks)
(b) Explain why magnesium oxide has a very high melting point. (2 marks)
(c) State the total number of electron pairs shared in one molecule of carbon dioxide. (1 mark)
(d) Explain why carbon dioxide does not conduct electricity. (1 mark)

Total for Question 2: 7 marks$mq$, $mq$(a) Each magnesium atom loses two electrons to form Mg²⁺ [1]; each oxygen atom gains two electrons to form O²⁻ [1]; the oppositely charged ions attract each other strongly (ionic bond) [1]. (b) Magnesium oxide has a giant lattice of ions with strong electrostatic forces between the oppositely charged ions [1]; a lot of energy is needed to overcome these forces [1]. (c) Four shared pairs (two double bonds) [1]. (d) It is made of simple molecules with no free ions or free electrons to carry charge [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
A student makes crystals of copper(II) sulfate by adding copper(II) oxide powder to warm dilute sulfuric acid until no more dissolves.
(a) State the type of reaction that takes place. (1 mark)
(b) Write the word equation for the reaction. (1 mark)
(c) Explain why an excess of copper(II) oxide is added. (2 marks)
(d) Name the technique used to remove the excess copper(II) oxide. (1 mark)
(e) Describe how the student obtains crystals from the copper(II) sulfate solution. (2 marks)
(f) State the colour of the copper(II) sulfate solution. (1 mark)

Total for Question 3: 8 marks$mq$, $mq$(a) Neutralisation (a base reacting with an acid) [1]. (b) copper(II) oxide + sulfuric acid -> copper(II) sulfate + water [1]. (c) To make sure all the acid reacts [1]; copper(II) oxide is insoluble, so the excess can be removed, leaving a solution that contains only copper(II) sulfate [1]. (d) Filtration [1]. (e) Heat the solution gently to evaporate some of the water until it is saturated (a drop on a glass rod forms crystals) [1]; leave the solution to cool and crystallise, then filter and dry the crystals between filter paper [1]. (f) Blue [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 10]]
Iron rusts when it reacts with oxygen and water. A student wants to find out how the concentration of salt in water affects the rusting of iron nails. She places one clean iron nail in each of five beakers that contain 100 cm³ of salt solution with concentrations of 0, 1, 2, 3 and 4 g per 100 cm³. She leaves them for 7 days. She dries each nail and measures its mass before and after.
(a) State a research question that this investigation can answer. (2 marks)
(b) Formulate a testable hypothesis using scientific reasoning. (2 marks)
(c) Identify the independent variable and the dependent variable. (2 marks)
(d) Outline two variables that must be controlled. (2 marks)
(e) Explain why the mass of a rusted nail changes. (1 mark)
(f) Outline one safety precaution. (1 mark)

Total for Question 4: 10 marks$mq$, $mq$(a) A question that links both variables, e.g. How does the concentration of salt solution affect the change in mass of an iron nail caused by rusting? [2] (1 mark if the variables are named but not linked). (b) Prediction, e.g. the higher the salt concentration the faster the nail rusts [1]; reasoning, e.g. dissolved salt makes the water a better conductor (electrolyte), which speeds up the oxidation of iron [1]. (c) Independent: concentration of salt solution [1]; dependent: change in mass of the nail (accept amount of rust) [1]. (d) Any two from: volume of solution, mass/size of nail, temperature, time, how much of the nail is covered by solution, starting condition (cleaned nails) [1][1]. (e) The mass increases because iron combines with oxygen to form hydrated iron(III) oxide (rust), which is heavier than the iron [1]. (f) Any one from: wear eye protection, handle sharp nails with care, wash hands after handling salt solution [1].$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | C 12]]
A student adds 0.100 mol/dm³ sodium sulfate solution to 25.0 cm³ of 0.100 mol/dm³ barium chloride solution. A white precipitate of barium sulfate forms: BaCl₂ + Na₂SO₄ -> BaSO₄ + 2NaCl. After each addition the precipitate is filtered, washed, dried and weighed. Relative atomic masses: Ba = 137, S = 32, O = 16. The mass of precipitate is recorded.

Volume of sodium sulfate solution added (cm³): 5 | 10 | 15 | 20 | 25 | 30 | 35
Mass of barium sulfate (g): 0.12 | 0.23 | 0.35 | 0.46 | 0.58 | 0.59 | 0.58

A graph of mass (vertical axis) against volume (horizontal axis) rises in a straight line from the origin at first and then becomes a horizontal line. Diagram not to scale.
(a) Describe the shape of the graph. (2 marks)
(b) Explain why the mass of precipitate stops increasing after 25 cm³ of sodium sulfate is added. (2 marks)
(c) Calculate the number of moles of barium chloride in 25.0 cm³ of 0.100 mol/dm³ solution. (1 mark)
(d) Calculate the maximum mass of barium sulfate that can form. (2 marks)
(e) Calculate the mean mass for the three readings at 25, 30 and 35 cm³ and comment on its agreement with your answer to (d). (2 marks)
(f) Calculate the percentage yield when 20 cm³ of sodium sulfate solution is added. (2 marks)
(g) State why the precipitate is washed before it is dried. (1 mark)

Total for Question 5: 12 marks$mq$, $mq$(a) The mass increases (in direct proportion to the volume) up to 25 cm³ [1]; then it stays constant (about 0.58 g) as more solution is added [1]. (b) All the barium ions have reacted by 25 cm³ (barium chloride is the limiting reagent for larger volumes) [1]; extra sodium sulfate has no barium ions left to react with, so no more precipitate forms [1]. (c) 0.0250 x 0.100 = 0.00250 mol [1]. (d) Mole ratio 1 : 1, so 0.00250 mol BaSO₄ [1]; Mr = 137 + 32 + 64 = 233; mass = 0.00250 x 233 = 0.583 g (0.58 g) [1]. (e) (0.58 + 0.59 + 0.58)/3 = 0.583 g [1]; this agrees closely with the theoretical maximum of 0.583 g [1]. (f) Sodium sulfate is the limiting reagent: 0.0200 x 0.100 = 0.00200 mol, so theoretical mass = 0.00200 x 233 = 0.466 g [1]; percentage yield = 0.46/0.466 x 100 = 98.7% (about 99%) [1]. (g) To remove soluble impurities such as sodium chloride solution so that only barium sulfate is weighed [1].$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | A 8]]
Metals are extracted from their ores by methods that depend on the position of the metal in the reactivity series. Zinc can be extracted by heating zinc oxide with carbon: ZnO + C -> Zn + CO.
(a) State the general method used to extract metals that are less reactive than carbon. (1 mark)
(b) Name the substance that is oxidised in the reaction of zinc oxide with carbon and give a reason. (2 marks)
(c) State what is meant by reduction in terms of electrons. (1 mark)
(d) Write the half-equation for the change of a zinc ion Zn²⁺ into a zinc atom. (1 mark)
(e) Explain why aluminium cannot be extracted from aluminium oxide by heating with carbon. (1 mark)
(f) Magnesium reacts with copper(II) sulfate solution: Mg + Cu²⁺ -> Mg²⁺ + Cu. State which species is reduced. (1 mark)
(g) Explain why gold is found in the ground as the uncombined element. (1 mark)

Total for Question 6: 8 marks$mq$, $mq$(a) Heating the ore (oxide) with carbon (reduction by carbon) [1]. (b) Carbon [1]; because it gains oxygen (to form carbon monoxide) [1]. (c) Reduction is gain of electrons [1]. (d) Zn²⁺ + 2e⁻ -> Zn [1]. (e) Aluminium is more reactive than carbon, so carbon cannot displace it from its oxide [1]. (f) Cu²⁺ (copper ions) [1]. (g) Gold is very unreactive, so it does not react with oxygen or water in the environment [1].$mq$, $mq$A$mq$),
(7, $mq$[[Q 7 | A 1 | C 3 | D 4]]
Read the passage.
A dry coastal country is planning to supply drinking water from seawater. Seawater contains about 3.5% dissolved salts by mass. Option 1 is a distillation plant, in which seawater is boiled and the steam is condensed. About 2.26 MJ of energy is needed to evaporate each kilogram of water. Option 2 is reverse osmosis, in which high pressure pushes water through a membrane that holds back the salts. This uses much less energy, but the membranes need regular replacement. Both options produce a very salty waste liquid, called brine, which is usually returned to the sea, where it can harm marine life near the outlet.
(a) State the separation technique that obtains pure water from salt solution by boiling and condensing. (1 mark)
(b) Calculate the mass of dissolved salts in 2000 kg of seawater. (1 mark)
(c) Calculate the maximum mass of pure water that can be obtained from 2000 kg of seawater. (1 mark)
(d) Calculate the energy needed to evaporate this mass of water by distillation. (1 mark)
(e) Evaluate the two options for the country and suggest which should be chosen. (4 marks)

Total for Question 7: 8 marks$mq$, $mq$(a) Distillation [1]. (b) 3.5% of 2000 = 70 kg [1]. (c) 2000 - 70 = 1930 kg [1]. (d) 1930 x 2.26 = 4361.8 MJ (about 4.4 x 10³ MJ) [1]. (e) Up to 4 marks: a point for distillation linked to the passage (e.g. simple, but needs 4.4 x 10³ MJ for every 2000 kg of seawater, so large energy use and cost) [1]; a point for reverse osmosis (e.g. uses much less energy but membranes must be replaced regularly) [1]; a shared impact (e.g. brine harms marine life near the outlet, which could be reduced by diluting it) [1]; a justified choice, e.g. reverse osmosis because it needs less energy, with a plan for managing the brine [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 8]]
Collision theory explains how factors change the rate of a reaction between marble (calcium carbonate) and hydrochloric acid.
(a) Explain, using collision theory, why powdered marble reacts faster than marble chips of the same mass. (2 marks)
(b) Explain why increasing the temperature increases the rate of reaction. (2 marks)
(c) State what is meant by activation energy. (1 mark)
(d) Explain why using more concentrated acid increases the rate of reaction. (2 marks)
(e) The reaction of two gases is carried out at a higher pressure. State and explain the effect on the rate of reaction. (1 mark)

Total for Question 8: 8 marks$mq$, $mq$(a) Powder has a larger surface area exposed to the acid [1]; so more collisions per second between acid particles and calcium carbonate particles [1]. (b) The particles move faster, so they collide more often [1]; a greater proportion of the collisions have at least the activation energy, so more collisions are successful [1]. (c) The minimum energy that colliding particles must have for the collision to result in a reaction [1]. (d) There are more acid particles in the same volume [1]; so collisions occur more frequently [1]. (e) The rate increases, because the gas particles are closer together, so collisions are more frequent [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Chemistry MYP 5 eAssessment Paper C (8 tasks, 70 marks) (70 marks)
with sub as (select id from public.subjects where slug = $mq$chemistry$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Chemistry MYP 5 eAssessment Paper C (8 tasks, 70 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Chemistry MYP 5 eAssessment Paper C (8 tasks, 70 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6]]
The table gives the melting points and boiling points of three substances A, B and C.

Substance: A | B | C
Melting point (°C): -39 | -210 | 115
Boiling point (°C): 357 | -196 | 445

(a) State the physical state (solid, liquid or gas) of each substance at 25 °C. (3 marks)
(b) Explain, using the particle model, what happens when substance C melts. (2 marks)
(c) State which substance has the weakest forces between its particles. (1 mark)

Total for Question 1: 6 marks$mq$, $mq$(a) A: liquid [1]; B: gas [1]; C: solid [1]. (b) The particles gain energy (from heating) and vibrate more [1]; this overcomes the forces holding the particles in fixed positions so they can move past each other (no bonds within the particles are broken) [1]. (c) B (it has the lowest boiling point) [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Methane, CH₄, is the main compound in natural gas. It burns in a plentiful supply of air to form carbon dioxide and water, but in a limited supply of air it burns incompletely.
(a) State one condition that leads to incomplete combustion of methane. (1 mark)
(b) Explain why carbon monoxide is toxic. (1 mark)
(c) Balance the equation for incomplete combustion: __CH₄ + __O₂ -> __CO + __H₂O (2 marks)
(d) Nitrogen oxides are formed in car engines even though the fuel contains no nitrogen. Explain why. (1 mark)
(e) State one environmental problem caused by nitrogen oxides. (1 mark)
(f) State the approximate percentage of nitrogen in dry air. (1 mark)
(g) A catalytic converter converts carbon monoxide and nitrogen monoxide into carbon dioxide and nitrogen. Write the balanced symbol equation. (1 mark)

Total for Question 2: 8 marks$mq$, $mq$(a) A limited supply of air (oxygen) [1]. (b) It binds to haemoglobin in red blood cells and prevents them carrying oxygen [1]. (c) 2CH₄ + 3O₂ -> 2CO + 4H₂O: [1] for 2 and 2 (CH₄ and CO) and [1] for 3 and 4 (O₂ and H₂O). (d) The high temperature in the engine makes nitrogen and oxygen from the air react together [1]. (e) Acid rain (or smog / respiratory problems) [1]. (f) About 78% [1]. (g) 2CO + 2NO -> 2CO₂ + N₂ [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
The table shows the pH of two acids of the same concentration, 0.10 mol/dm³.

Solution: hydrochloric acid | ethanoic acid
pH: 1 | 3

(a) State which solution contains the strong acid and give a reason. (2 marks)
(b) Explain, in terms of ionisation, why the two pH values are different. (2 marks)
(c) Calculate how many times greater the hydrogen ion concentration is in the solution of pH 1 than in the solution of pH 3. (1 mark)
(d) Equal volumes of the two acids are reacted with excess magnesium ribbon. Compare the initial rate and the final volume of hydrogen gas produced. (2 marks)
(e) Write the ionic equation for neutralisation. (1 mark)

Total for Question 3: 8 marks$mq$, $mq$(a) Hydrochloric acid [1]; it has the lower pH at the same concentration, so it has the higher concentration of hydrogen ions [1]. (b) Hydrochloric acid ionises completely in water [1]; ethanoic acid is only partly ionised (an equilibrium), so fewer H⁺ ions [1]. (c) Each pH unit is a factor of ten, so 2 units = 100 times greater [1]. (d) The initial rate is faster for hydrochloric acid [1]; the final volume of hydrogen is the same because both contain the same number of moles of acid [1]. (e) H⁺ + OH⁻ -> H₂O [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 10]]
Electrolysis of copper(II) sulfate solution using copper electrodes transfers copper from the positive electrode (anode) to the negative electrode (cathode). A student wants to find out how the size of the current affects the mass of copper deposited. She sets up the circuit with an ammeter and a variable resistor and passes currents of 0.2 A, 0.4 A, 0.6 A, 0.8 A and 1.0 A, each for 10 minutes, using a new cathode each time.
(a) Formulate a testable hypothesis using scientific reasoning. (2 marks)
(b) Identify the independent variable and the dependent variable. (2 marks)
(c) Outline two variables that must be controlled. (2 marks)
(d) Describe how the student should find the mass of copper deposited on each cathode. (2 marks)
(e) Write the half-equation for the change at the cathode. (1 mark)
(f) Outline one safety precaution. (1 mark)

Total for Question 4: 10 marks$mq$, $mq$(a) A prediction linking the variables, e.g. the greater the current the greater the mass of copper deposited [1]; reasoning, e.g. a larger current means more charge flows each second, so more Cu²⁺ ions gain electrons at the cathode [1]. (b) Independent: the size of the current; dependent: the mass of copper deposited on the cathode (change in mass of cathode) [1][1]. (c) Any two from: time of electrolysis, concentration and volume of the solution, distance between and area of the electrodes immersed, temperature [1][1]. (d) Weigh each cathode before the experiment; after electrolysis rinse and dry it carefully (e.g. with propanone) and weigh it again [1]; mass deposited = final mass - initial mass [1]. (e) Cu²⁺ + 2e⁻ -> Cu [1]. (f) Any one from: wear eye protection, copper(II) sulfate is harmful so wash hands, take care with propanone near sparks/flames, do not touch electrodes while the current is on [1].$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | C 12]]
A student compares the energy released when four alcohols burn. For each alcohol, 1.00 g is burned in a spirit burner under a metal can that contains 100 g of water. The temperature rise of the water is measured. The specific heat capacity of water is 4.2 J/g °C. Relative atomic masses: C = 12, H = 1, O = 16.

Alcohol: methanol | ethanol | propan-1-ol | butan-1-ol
Relative formula mass: 32 | 46 | 60 | 74
Temperature rise of water (°C): 11.0 | 14.0 | 16.0 | 17.0
Energy per mole (kJ/mol): 148 | ? | 403 | 528

(a) Calculate the energy transferred to the water when the ethanol burns. (2 marks)
(b) Show how the energy per mole for propan-1-ol is obtained from its temperature rise. (2 marks)
(c) Describe the trend in energy per mole as the number of carbon atoms increases. Use the data. (2 marks)
(d) Predict the energy per mole for pentan-1-ol. (1 mark)
(e) A data book gives the energy released by burning one mole of ethanol as 1367 kJ/mol. Explain why the student's result is lower. (2 marks)
(f) Suggest two improvements to the method. (2 marks)
(g) State one safety precaution when using spirit burners. (1 mark)

Total for Question 5: 12 marks$mq$, $mq$(a) Q = mcΔT = 100 x 4.2 x 14.0 [1] = 5880 J (5.88 kJ) [1]. (b) Energy for 1.00 g = 100 x 4.2 x 16.0 = 6720 J = 6.72 kJ [1]; moles in 1.00 g = 1/60, so energy per mole = 6.72 x 60 = 403 kJ/mol [1]. (c) The energy per mole increases as the number of carbon atoms increases [1]; by roughly 120 to 135 kJ/mol for each additional CH₂ (148 -> 270 -> 403 -> 528) [1]. (d) About 650 kJ/mol (accept 640 to 670) [1]. (e) Much of the energy is lost to the surroundings and the metal can instead of heating the water [1]; the alcohol may burn incompletely (soot) so less energy is released, and some may evaporate unburned [1]. (f) Any two from: use a draught shield or lid to reduce heat loss, insulate the can, stir the water, move the can closer to the flame, use a digital thermometer, weigh the burner before and after [1][1]. (g) Any one from: keep flammable liquids away from other flames, extinguish the burner with the cap, wear eye protection, tie back hair [1].$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | A 8]]
Group 2 metals react with water. Magnesium reacts very slowly with cold water. Calcium reacts steadily with cold water, forming a cloudy solution and bubbles of gas. Strontium reacts more vigorously than calcium.
(a) Calcium has atomic number 20. State its electron arrangement. (1 mark)
(b) State the trend in reactivity down Group 2 and explain it. (3 marks)
(c) Write the balanced symbol equation for the reaction of calcium with water to form calcium hydroxide and hydrogen. (2 marks)
(d) Describe the test for hydrogen gas. (1 mark)
(e) Predict whether the pH of the final mixture is above or below 7 and name the ion responsible. (1 mark)

Total for Question 6: 8 marks$mq$, $mq$(a) 2,8,8,2 [1]. (b) Reactivity increases down the group [1]; the outer electrons are further from the nucleus and more shielded [1]; so they are held less strongly and are lost more easily [1]. (c) Ca + 2H₂O -> Ca(OH)₂ + H₂: correct formulae [1]; balanced [1]. (d) A lit splint makes a squeaky pop [1]. (e) Above 7 (alkaline), because of hydroxide ions, OH⁻ [1].$mq$, $mq$A$mq$),
(7, $mq$[[Q 7 | A 2 | C 2 | D 6]]
Read the passage.
Chlorofluorocarbons (CFCs) were widely used in refrigerators and aerosol sprays. In the stratosphere, ultraviolet radiation breaks CFC molecules and releases chlorine atoms, and one chlorine atom can destroy many thousands of ozone molecules. An international agreement, the Montreal Protocol (1987), banned most CFCs. The ozone layer over Antarctica is expected to recover to its 1980 level around the year 2066. Some replacement chemicals, hydrofluorocarbons (HFCs), do not harm ozone but are strong greenhouse gases, and countries have agreed to reduce their use. Illustrative values for the amount of ozone-depleting chlorine in the stratosphere are given below.

Year: 1980 | 1990 | 2000 | 2010 | 2020
Chlorine in stratosphere (parts per billion): 2.0 | 3.4 | 3.7 | 3.3 | 2.9

(a) State the function of the ozone layer. (1 mark)
(b) Name the element in CFCs that destroys ozone. (1 mark)
(c) Calculate the percentage decrease in stratospheric chlorine from 2000 to 2020. (2 marks)
(d) Evaluate how successful the international response to CFCs has been. Refer to the passage and the data and reach a justified conclusion. (6 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) It absorbs harmful ultraviolet radiation from the Sun [1]. (b) Chlorine [1]. (c) (3.7 - 2.9)/3.7 [1] x 100 = 21.6% (about 22%) [1]. (d) Up to 6 marks: evidence of success, e.g. chlorine peaked in 2000 at 3.7 ppb and fell to 2.9 ppb by 2020, about 22% lower [1]; the ban on most CFCs worked because countries acted together, and recovery to the 1980 level of the ozone layer over Antarctica is expected by about 2066 [1]; limitations, e.g. the chlorine in 2020 is still above the 1980 level of 2.0 ppb, and recovery will take decades because the chlorine persists in the atmosphere [1]; a new problem, e.g. HFCs replace CFCs but are strong greenhouse gases and also need controlling [1]; a balanced judgement [1]; a justified conclusion, e.g. largely successful and an example of effective global cooperation but not complete [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 8]]
Relative atomic masses: H = 1, C = 12, N = 14, O = 16, Ca = 40. One mole of any gas occupies 24 dm³ at room temperature and pressure.
(a) A student dissolves 4.0 g of sodium hydroxide, NaOH (relative formula mass 40), in water to make 500 cm³ of solution. Calculate the number of moles of sodium hydroxide and the concentration of the solution in mol/dm³. (2 marks)
(b) Calcium carbonate reacts with excess hydrochloric acid: CaCO₃ + 2HCl -> CaCl₂ + H₂O + CO₂. Calculate the volume of carbon dioxide produced at room temperature and pressure from 5.0 g of calcium carbonate. (3 marks)
(c) Calculate the relative formula mass of calcium hydroxide, Ca(OH)₂. (1 mark)
(d) Calculate the percentage by mass of nitrogen in ammonium nitrate, NH₄NO₃. (2 marks)

Total for Question 8: 8 marks$mq$, $mq$(a) moles = 4.0/40 = 0.10 mol [1]; concentration = 0.10/0.500 = 0.20 mol/dm³ [1]. (b) Mr of CaCO₃ = 100, moles = 5.0/100 = 0.050 mol [1]; ratio 1 : 1 so 0.050 mol CO₂ [1]; volume = 0.050 x 24 = 1.2 dm³ [1]. (c) 40 + 2 x (16 + 1) = 74 [1]. (d) Mr = 14 + 4 + 14 + 48 = 80 [1]; % N = 28/80 x 100 = 35% [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Physics MYP 5 eAssessment Paper A (8 tasks, 70 marks) (70 marks)
with sub as (select id from public.subjects where slug = $mq$physics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Physics MYP 5 eAssessment Paper A (8 tasks, 70 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Physics MYP 5 eAssessment Paper A (8 tasks, 70 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6]]
A lift of mass 800 kg is raised and lowered by a cable. Use g = 10 N/kg.
(a) Calculate the weight of the lift. (1 mark)
(b) The lift moves upwards at a constant speed of 2.0 m/s. State the tension in the cable and give a reason for your answer. (2 marks)
(c) The lift then accelerates upwards at 1.5 m/s². Calculate the resultant force on the lift. (2 marks)
(d) Calculate the tension in the cable while the lift accelerates upwards at 1.5 m/s². (1 mark)

Total for Question 1: 6 marks$mq$, $mq$(a) W = mg = 800 x 10 = 8000 N [1]. (b) 8000 N [1]; the forces are balanced (no resultant force) because the speed is constant (Newton's first law) [1]. (c) F = ma [1] = 800 x 1.5 = 1200 N [1]. (d) Tension = weight + resultant force = 8000 + 1200 = 9200 N [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 6]]
A student of mass 70 kg stands on frozen snow. Use g = 10 N/kg. The total area of the soles of her two boots in contact with the snow is 0.040 m².
(a) Calculate the weight of the student. (1 mark)
(b) Calculate the pressure that she exerts on the snow. (2 marks)
(c) She puts on snowshoes. The total area of the snowshoes in contact with the snow is 0.20 m². Calculate the new pressure on the snow. (1 mark)
(d) Explain why the snowshoes make it less likely that she will sink into the snow. (2 marks)

Total for Question 2: 6 marks$mq$, $mq$(a) W = 70 x 10 = 700 N [1]. (b) p = F/A [1] = 700/0.040 = 17 500 Pa (17.5 kPa) [1]. (c) 700/0.20 = 3500 Pa [1]. (d) The force (her weight) is the same [1], but it is spread over a larger area, so the pressure on the snow is smaller [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
A solid metal block is a cuboid with edges 4.0 cm, 5.0 cm and 2.5 cm. Its mass is 135 g.
(a) Calculate the volume of the block. (2 marks)
(b) Calculate the density of the block in g/cm³. (2 marks)
(c) The density of ice is 920 kg/m³ and the density of water is 1000 kg/m³. State why ice floats on water. (2 marks)
(d) State the difference between the mass and the weight of an object. (1 mark)
(e) The gravitational field strength on the Moon is 1.6 N/kg. Calculate the weight on the Moon of an astronaut of mass 60 kg. (1 mark)

Total for Question 3: 8 marks$mq$, $mq$(a) V = 4.0 x 5.0 x 2.5 [1] = 50 cm³ [1]. (b) density = mass/volume [1] = 135/50 = 2.7 g/cm³ [1]. (c) Ice has a lower density than water [1], so it is less dense than the water it displaces and floats (the upthrust is enough to support its weight) [1]. (d) Mass is the amount of matter (measured in kg) and does not change with place; weight is the force of gravity on the object (measured in N) and depends on the gravitational field strength [1]. (e) W = mg = 60 x 1.6 = 96 N [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 10]]
A student investigates how the area of a parachute affects the time it takes to fall. She makes square parachutes from thin plastic sheet with sides of 10 cm, 15 cm, 20 cm, 25 cm and 30 cm. She attaches a 20 g mass to each by four strings of equal length. She drops each parachute from a height of 2.0 m and times the fall with a stopwatch.
(a) Formulate a testable hypothesis for this investigation, using scientific reasoning. (2 marks)
(b) Identify the independent variable and the dependent variable. (2 marks)
(c) Outline two variables that the student must keep constant. (2 marks)
(d) Outline how the student should collect her data so that the results are reliable. (2 marks)
(e) Explain one source of error in the use of a stopwatch for this investigation and suggest how to reduce it. (2 marks)

Total for Question 4: 10 marks$mq$, $mq$(a) A prediction linking the variables, e.g. the larger the parachute area, the longer the fall time [1]; reasoning, e.g. a larger area gives more air resistance, so the resultant downward force is smaller and the parachute accelerates less and falls more slowly [1]. (b) Independent: area (side length) of the parachute [1]; dependent: time to fall 2.0 m [1]. (c) Any two from: mass attached, drop height, string length, plastic material/thickness, the way it is released [1][1]. (d) Repeat each size at least three times [1] and calculate a mean (discarding any anomalous result) [1]. (e) Reaction time of the student when starting/stopping the watch [1]; reduce by using video of the drop with a timer, light gates, or a longer drop height so reaction time is a smaller fraction of the total [1].$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | C 12]]
A group of students investigates how the resultant force on a trolley affects its acceleration. A light gate system measures the acceleration. Weights are moved from the trolley to a hanger so that the total mass of the system stays constant. Each force is tested twice.

Resultant force F (N): 0.2 | 0.4 | 0.6 | 0.8 | 1.0
Acceleration, trial 1 (m/s²): 0.24 | 0.50 | 0.76 | 1.00 | 1.24
Acceleration, trial 2 (m/s²): 0.28 | 0.48 | 0.78 | 0.98 | 1.28
Mean acceleration (m/s²): 0.26 | 0.49 | 0.77 | ? | 1.26

A graph of mean acceleration (vertical axis) against force (horizontal axis) is drawn. The points lie close to a straight line that passes through the origin (0, 0) and the point (1.0 N, 1.26 m/s²). Diagram not to scale.
(a) Calculate the missing mean acceleration for 0.8 N. (1 mark)
(b) Describe the relationship shown by the data. (2 marks)
(c) Calculate the gradient of the line. Give the unit as (m/s²) per N. (2 marks)
(d) The gradient equals 1 divided by the total mass. Use it to find the total mass of the system. The students measured the mass as 0.80 kg. Comment on the agreement. (2 marks)
(e) Write a conclusion for the investigation, supported by data. (2 marks)
(f) Evaluate the reliability of the results. (3 marks)

Total for Question 5: 12 marks$mq$, $mq$(a) (1.00 + 0.98)/2 = 0.99 m/s² [1]. (b) As the force increases the acceleration increases [1]; directly proportional: doubling the force (0.2 to 0.4 N) roughly doubles the acceleration (0.26 to 0.49) / the graph is a straight line through the origin [1]. (c) gradient = change in acceleration/change in force = (1.26 - 0)/(1.0 - 0) [1] = 1.26 (m/s²) per N [1] (accept 1.2 to 1.3). (d) mass = 1/1.26 = 0.79 kg [1]; this agrees closely with 0.80 kg (difference about 1%), so the data support the relationship [1]. (e) At constant mass the acceleration is directly proportional to the resultant force [1], supported by a quoted pair of values, e.g. 0.2 N gives 0.26 m/s² and 1.0 N gives 1.26 m/s² (five times the force gives about five times the acceleration) [1]. (f) Good agreement between the repeats: the largest difference between the two trials is only 0.04 m/s² (at 0.2 N and 1.0 N) [1]; however only two repeats were taken, so an anomaly could not be identified; more repeats (at least three) and a mean would improve reliability [1]; a further improvement such as a data logger/light gates at both ends or checking friction by tilting the track [1].$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | A 8]]
Read the passage.
In the 1920s, astronomers found that the light from almost all distant galaxies is shifted towards the red end of the spectrum. The more distant the galaxy, the larger the shift. In 1965 two scientists detected faint microwave radiation arriving from every direction in space. Most scientists now accept the Big Bang theory of how the Universe began.
(a) State what is meant by redshift. (1 mark)
(b) Explain how redshift shows that galaxies are moving away from us. (2 marks)
(c) Describe how the microwave radiation provides evidence for the Big Bang. (2 marks)
(d) State the approximate age of the Universe in years. (1 mark)
(e) Compare terrestrial planets and gas giants. (2 marks)

Total for Question 6: 8 marks$mq$, $mq$(a) The wavelength of the light received from a source is longer than the wavelength emitted (shifted towards red) [1]. (b) Light from a galaxy that is moving away is stretched to a longer wavelength [1]; the larger the redshift the faster the galaxy is moving away, and since distant galaxies show larger redshifts, the Universe is expanding [1]. (c) The microwaves are the cosmic microwave background, radiation left over from the hot, dense early Universe [1]; as the Universe expanded it cooled and the radiation was stretched to longer wavelength (microwaves), as predicted by the theory [1]. (d) About 13.8 billion years (accept 13 to 14 billion) [1]. (e) Any two comparisons from: terrestrial planets are small, gas giants are large; terrestrial are rocky/solid, gas giants are mostly hydrogen and helium; terrestrial have higher density; terrestrial are closer to the Sun [1][1].$mq$, $mq$A$mq$),
(7, $mq$[[Q 7 | A 1 | C 3 | D 6]]
Read the passage.
A desert region plans a solar farm. The panels will cover 40 000 m². Averaged over day and night through the year, the Sun delivers 250 W of power to each square metre of panel. The panels are 20% efficient. An average household in the region uses electricity at an average rate of 0.50 kW. The farm will cover 0.30 km² of desert, which is home to rare lizards, and it will need large batteries to supply electricity at night. Supporters say the farm will produce no carbon dioxide while operating. Critics say the panels contain materials that must be mined and will need replacing after about 25 years.
(a) State the name of the nuclear process that releases the energy in the Sun. (1 mark)
(b) Calculate the average power of the Sun's radiation falling on the panels. (1 mark)
(c) Calculate the average electrical power output of the solar farm. (1 mark)
(d) Calculate the number of households this average output can supply. (1 mark)
(e) Evaluate the proposal to build the solar farm, using information from the passage. Reach a justified conclusion. (6 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) Nuclear fusion [1]. (b) 250 x 40 000 = 10 000 000 W (10 MW) [1]. (c) 10 MW x 0.20 = 2.0 MW (2 000 000 W) [1]. (d) 2 000 000/500 = 4000 households [1]. (e) Up to 6 marks: advantages from the passage, e.g. renewable source, no carbon dioxide in operation, supplies about 4000 households [1][1]; disadvantages from the passage, e.g. loss of lizard habitat, output only when the Sun shines so batteries are needed, mining of materials and panels replaced after 25 years [1][1]; a weighing of the factors (e.g. the habitat loss is local and 0.30 km² is small, or batteries add cost and environmental impact) [1]; a justified conclusion, e.g. approve with conditions such as moving the lizards or choosing a less sensitive site [1]. Do not credit a conclusion with no reasoning.$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 2 | C 2 | D 6]]
Read the passage.
Thousands of pieces of space debris orbit the Earth. At an altitude of 400 km the debris travels at about 7.7 km/s (7700 m/s). A small fleck of paint of mass 0.010 kg can crack the window of a spacecraft. Space agencies are discussing two measures: a rule that all new satellites must be moved out of orbit within five years of the end of their working life, and spacecraft that capture old debris. Each removal mission costs tens of millions of pounds.
(a) State the force that keeps a satellite in orbit around the Earth. (1 mark)
(b) State how the gravitational field strength changes as the altitude of a satellite increases. (1 mark)
(c) Calculate the kinetic energy of the paint fleck. Use kinetic energy = ½mv². (2 marks)
(d) A car of mass 1000 kg moving at 20 m/s has a kinetic energy of 200 000 J. Use this and your answer to (c) to explain why very small pieces of debris are dangerous. (2 marks)
(e) Discuss whether the two measures are worth the cost. Reach a justified conclusion. (4 marks)

Total for Question 8: 10 marks$mq$, $mq$(a) Gravity (gravitational attraction between the satellite and the Earth) [1]. (b) It decreases [1]. (c) KE = 0.5 x 0.010 x 7700² [1] = 296 450 J (about 3.0 x 10^5 J) [1]. (d) The fleck has more kinetic energy than the car although its mass is 100 000 times smaller [1], because kinetic energy depends on the square of the speed, so the very high speed gives it a large energy that can cause damage on impact [1]. (e) Up to 4 marks: a benefit linked to the passage (e.g. protects working satellites and astronauts, which are expensive and important to communications and weather forecasts) [1]; a cost or limitation (e.g. tens of millions of pounds per mission; the rule does not remove existing debris) [1]; a comparison of the two measures (e.g. the five-year rule is cheap and prevents new debris, removal is costly but deals with existing debris) [1]; a justified conclusion [1].$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Physics MYP 5 eAssessment Paper B (8 tasks, 68 marks) (68 marks)
with sub as (select id from public.subjects where slug = $mq$physics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Physics MYP 5 eAssessment Paper B (8 tasks, 68 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Physics MYP 5 eAssessment Paper B (8 tasks, 68 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6]]
A crane lifts a crate of mass 250 kg through a height of 12 m in 20 s. The electric motor of the crane takes in energy at a rate of 2500 W. Use g = 10 N/kg.
(a) Calculate the work done in lifting the crate. (2 marks)
(b) Calculate the useful power output of the crane. (1 mark)
(c) Calculate the efficiency of the crane. (2 marks)
(d) State what happens to the energy that is not usefully transferred. (1 mark)

Total for Question 1: 6 marks$mq$, $mq$(a) Force = weight = 250 x 10 = 2500 N [1]; work = 2500 x 12 = 30 000 J [1]. (b) P = W/t = 30 000/20 = 1500 W [1]. (c) efficiency = useful power/input power = 1500/2500 [1] = 0.60 (60%) [1]. (d) It is transferred to the surroundings as thermal energy (and sound), so it is wasted [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 6]]
A rigid copper wire carries a current while it lies at right angles to the magnetic field between two magnets.
(a) State what happens to the wire. (1 mark)
(b) State two ways of increasing the size of the force on the wire. (2 marks)
(c) State what happens to the direction of the force when the current is reversed. (1 mark)
(d) A bar magnet is pushed into a coil of wire connected to a sensitive voltmeter. Explain why the voltmeter shows a reading while the magnet is moving. (2 marks)

Total for Question 2: 6 marks$mq$, $mq$(a) The wire experiences a force (it moves) [1]. (b) Any two from: increase the current, use a stronger magnet, increase the length of wire in the field (more turns) [1][1]. (c) The force reverses direction [1]. (d) The magnetic field through the coil is changing (the coil cuts field lines) [1], which induces a voltage across the coil (electromagnetic induction) [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
Waves in the electromagnetic spectrum are used in communication. The electromagnetic spectrum, in order of increasing frequency, is: radio waves, microwaves, infrared, visible light, ultraviolet, X-rays, gamma rays.
(a) State the part of the spectrum that has the shortest wavelength. (1 mark)
(b) State the part of the spectrum used by a television remote control. (1 mark)
(c) An FM radio station transmits at a frequency of 100 MHz (1.0 x 10⁸ Hz). Radio waves travel at 3.0 x 10⁸ m/s. Calculate the wavelength of the waves. (2 marks)
(d) State one use and one hazard of ultraviolet radiation. (2 marks)
(e) Sound is a longitudinal wave. (select: Sound / Light) cannot travel through a vacuum. Select the correct word and explain your choice. (2 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) Gamma rays [1]. (b) Infrared [1]. (c) v = f x wavelength, so wavelength = 3.0 x 10⁸/1.0 x 10⁸ [1] = 3.0 m [1]. (d) Use, e.g. sterilising water, detecting forged banknotes, sun tanning lamps [1]; hazard, e.g. skin cancer, sunburn, eye damage [1]. (e) Sound [1]; sound needs particles (a medium) to pass vibrations on, and a vacuum has no particles, while light is an electromagnetic wave that needs no medium [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 10]]
A student wants to find out which material is the best thermal conductor. She has four rods of equal length and diameter made of copper, aluminium, steel and glass. She coats each rod with a thin layer of wax, sticks a drawing pin to the wax 10 cm from one end, and heats the other end of each rod in turn in a Bunsen burner flame. She records the time taken for the pin to fall off.
(a) State a research question that this investigation can answer. (2 marks)
(b) Formulate a testable hypothesis using scientific reasoning. (2 marks)
(c) Identify the independent variable and the dependent variable. (2 marks)
(d) Outline two variables that must be controlled. (2 marks)
(e) Outline one safety precaution. (1 mark)
(f) Suggest one way of improving the reliability of the results. (1 mark)

Total for Question 4: 10 marks$mq$, $mq$(a) A question that links both variables, e.g. How does the type of material affect the time taken for thermal energy to travel 10 cm along a rod? [2] (1 mark if the variables are named but not linked). (b) Prediction, e.g. the metals will cause the pin to fall sooner than glass [1]; reasoning, e.g. metals contain free electrons that carry thermal energy quickly, glass does not [1]. (c) Independent: the material of the rod [1]; dependent: time for the pin to fall [1]. (d) Any two from: rod length and diameter, distance of the pin from the heated end, amount of wax, flame position and heating time/ same flame, starting temperature [1][1]. (e) Any one from: wear eye protection, tie back hair, use tongs/heat-proof mat, let rods cool before handling [1]. (f) Repeat each rod several times and calculate a mean [1].$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | C 12]]
A student investigates how fast a magnet must move to induce a voltage in a coil of 200 turns. A small magnet on a trolley moves through the coil at different speeds. A light gate measures the speed and a voltage sensor records the peak voltage induced.

Speed of magnet (m/s): 0.2 | 0.4 | 0.6 | 0.8 | 1.0
Peak voltage (mV): 12 | 25 | 36 | 49 | 61

(a) Identify the independent variable and the dependent variable. (2 marks)
(b) Describe the pattern shown by the data. (2 marks)
(c) Calculate the value of voltage divided by speed (in mV per m/s) for three of the readings. Use the answers to show that the voltage is directly proportional to the speed. (3 marks)
(d) Use the data to predict the peak voltage when the speed is 0.7 m/s. (1 mark)
(e) State the effect on the induced voltage of moving the magnet out of the coil instead of in. (1 mark)
(f) Evaluate the method used to collect these data. (3 marks)

Total for Question 5: 12 marks$mq$, $mq$(a) Independent: speed of the magnet [1]; dependent: peak induced voltage [1]. (b) As the speed increases the voltage increases [1]; the voltage increases by about the same amount (about 12 mV) for each 0.2 m/s increase (steady/linear increase) [1]. (c) Correct calculations for three readings, e.g. 12/0.2 = 60; 25/0.4 = 62.5; 36/0.6 = 60; 49/0.8 = 61.25; 61/1.0 = 61 [1]; the values are approximately constant (all between 60 and 62.5 mV per m/s) [1]; so voltage is directly proportional to speed (doubling the speed doubles the voltage) [1]. (d) About 43 mV (accept 42 to 44) [1]. (e) The voltage is induced in the opposite direction (reversed polarity) [1]. (f) Strength: a light gate measures the speed accurately/ reduces human timing error, and the same coil and magnet are used [1]; weaknesses: only one reading at each speed so no mean or check for anomalies [1]; improvement, e.g. repeat each speed at least three times and calculate a mean, or the peak value is read from a sensor whose resolution (1 mV) is large compared with the smallest reading of 12 mV, so use a more sensitive sensor [1].$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | A 8]]
A student studies thermal energy and the particle model.
(a) Describe the arrangement and motion of the particles in a gas compared with those in a liquid. (2 marks)
(b) A sealed rigid container of gas is heated. Explain, using the particle model, why the pressure of the gas increases. (2 marks)
(c) A radiator is fixed near the floor of a room. Explain how it heats the whole room by convection. (2 marks)
(d) The inner wall of a vacuum flask is coated with a shiny silver layer. Explain how this helps to keep the drink hot. (2 marks)

Total for Question 6: 8 marks$mq$, $mq$(a) Gas: particles far apart and moving randomly and quickly in all directions [1]; liquid: particles close together (touching), moving past each other, in no regular arrangement [1]. (b) The particles move faster (gain kinetic energy) [1]; they hit the walls more often and with greater force, so the pressure increases [1]. (c) Air next to the radiator is heated, expands and becomes less dense, so it rises [1]; cooler, denser air moves in to take its place and sinks, setting up a convection current that circulates the warm air [1]. (d) The shiny surface reflects infrared (thermal) radiation back into the drink [1], reducing the heat transferred by radiation across the vacuum [1].$mq$, $mq$A$mq$),
(7, $mq$[[Q 7 | A 2 | C 2 | D 6]]
Read the passage.
Residents of the town of Wexbridge object to a new mobile phone mast that transmits microwaves. Some fear that the radiation will harm their health. The council points out that microwaves are non-ionising, unlike some other parts of the electromagnetic spectrum, and that the radiation heats body tissue only very slightly. An international guideline sets a limit on exposure of 10 W/m². A survey measured the exposure at the nearest house to the mast as 0.002 W/m². The council admits that studies of possible effects of exposure over many decades are limited, and that residents are also exposed to radiation from their own phones and wireless routers.
(a) State two parts of the electromagnetic spectrum that are ionising. (2 marks)
(b) Calculate how many times smaller the measured exposure is than the guideline limit. (2 marks)
(c) Evaluate the claim that "the mast is safe". Use evidence from the passage and reach a justified conclusion. (6 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) Any two from: ultraviolet (the higher-frequency end), X-rays, gamma rays [1][1]. (b) 10/0.002 [1] = 5000 times smaller [1]. (c) Up to 6 marks: evidence that supports safety, e.g. microwaves are non-ionising so cannot damage DNA directly, and heating is very small [1]; the measured exposure is 5000 times below the international guideline [1]; limitations, e.g. long-term studies over decades are limited [1]; the survey measured one house, and total exposure includes phones and routers [1]; a balanced judgement that weighs the evidence (e.g. good evidence for low short-term risk but uncertainty about long-term effects) [1]; a justified conclusion or recommendation, e.g. accept that the mast is very likely safe on current evidence and recommend continued independent monitoring of exposure and publishing the results [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 8]]
A kettle is rated at 2300 W when connected to the 230 V mains supply. The kettle plug can be fitted with a 3 A, 5 A or 13 A fuse.
(a) Calculate the current in the kettle when it is working normally. (2 marks)
(b) State which fuse should be fitted and give a reason. (2 marks)
(c) The kettle is switched on for 3.0 minutes. Calculate the energy transferred in kilowatt-hours (kWh). (2 marks)
(d) Electricity costs 30 pence per kWh. Calculate the cost of using the kettle for 3.0 minutes. (1 mark)
(e) State the purpose of the earth wire in the kettle's cable. (1 mark)

Total for Question 8: 8 marks$mq$, $mq$(a) I = P/V [1] = 2300/230 = 10 A [1]. (b) 13 A [1]; the 3 A and 5 A fuses would melt at the normal current of 10 A, and 13 A is the nearest value above 10 A so it still protects the cable from overheating [1]. (c) 3.0 min = 0.050 h; E = 2.3 kW x 0.050 h [1] = 0.115 kWh [1]. (d) 0.115 x 30 = 3.45 pence (about 3.5 p) [1]. (e) It provides a path for current to flow to the ground if the metal case becomes live, so the fuse blows and the user is protected from electric shock [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

-- Physics MYP 5 eAssessment Paper C (7 tasks, 62 marks) (62 marks)
with sub as (select id from public.subjects where slug = $mq$physics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Physics MYP 5 eAssessment Paper C (7 tasks, 62 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Physics MYP 5 eAssessment Paper C (7 tasks, 62 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 6]]
A stone is dropped from rest from a bridge into a river. It takes 2.0 s to reach the water. Ignore air resistance. Use g = 10 m/s².
(a) Calculate the speed of the stone when it hits the water. (2 marks)
(b) Calculate the height of the bridge above the water. (2 marks)
(c) On the Moon, a hammer and a feather released together from the same height land at the same time. Explain why. (2 marks)

Total for Question 1: 6 marks$mq$, $mq$(a) v = u + at (or v = gt) [1] = 10 x 2.0 = 20 m/s [1]. (b) average speed = (0 + 20)/2 = 10 m/s, distance = 10 x 2.0 [1] = 20 m [1] (accept s = 0.5 x 10 x 2.0² = 20 m). (c) There is no air on the Moon, so no air resistance acts on either object [1]; the only force is gravity, which gives all objects the same acceleration (the same free-fall acceleration) regardless of mass [1].$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Radioactive nuclei emit alpha particles, beta particles or gamma rays.
(a) Three types of radiation are stopped by different materials. Select the radiation for each statement (select: alpha / beta / gamma).
  (i) Stopped by a sheet of paper. (1 mark)
  (ii) Stopped by about 3 mm of aluminium but not by paper. (1 mark)
  (iii) Reduced but not stopped by several centimetres of lead. (1 mark)
(b) Uranium-238 (atomic number 92) decays by emitting an alpha particle to form thorium. Give the nucleon number and the atomic number of the thorium nucleus formed. (2 marks)
(c) Carbon-14 (atomic number 6) decays by beta emission to form nitrogen-14. Describe what happens in the nucleus and how the atomic number changes. (2 marks)
(d) State why alpha radiation is the most ionising of the three types. (1 mark)

Total for Question 2: 8 marks$mq$, $mq$(a)(i) alpha [1]. (ii) beta [1]. (iii) gamma [1]. (b) Alpha particle has nucleon number 4 and atomic number 2, so thorium has nucleon number 238 - 4 = 234 [1] and atomic number 92 - 2 = 90 [1]. (c) A neutron changes into a proton (and an electron, the beta particle, is emitted) [1]; the atomic number increases by one (from 6 to 7) while the nucleon number stays 14 [1]. (d) Alpha particles are relatively large and carry a 2+ charge, so they interact strongly and ionise many atoms over a short distance [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 10]]
A light-dependent resistor (LDR) is a component whose resistance changes with light intensity. A student wants to find how the distance of a lamp from an LDR affects the resistance of the LDR. She connects the LDR in series with a 6.0 V battery and an ammeter, with a voltmeter connected across the LDR. She places a lamp at distances of 10 cm to 50 cm from the LDR in a darkened room.
(a) State a research question that this investigation can answer. (2 marks)
(b) Formulate a testable hypothesis using scientific reasoning. (2 marks)
(c) Identify the independent variable and the dependent variable. (2 marks)
(d) Outline how the student will find the resistance of the LDR from her readings. (1 mark)
(e) Outline two variables that must be controlled. (2 marks)
(f) Outline one safety precaution. (1 mark)

Total for Question 3: 10 marks$mq$, $mq$(a) A question that links both variables, e.g. How does the distance of the lamp from the LDR affect the resistance of the LDR? [2] (1 mark if the variables are named but not linked). (b) Prediction, e.g. as distance increases the resistance of the LDR increases [1]; reasoning, e.g. the light intensity falls with distance, so fewer charge carriers are released in the LDR and it conducts less [1]. (c) Independent: distance of the lamp from the LDR [1]; dependent: resistance of the LDR [1]. (d) Resistance = voltage across LDR divided by current (R = V/I) [1]. (e) Any two from: same lamp and brightness, same battery voltage, darkened room (other light), lamp pointing directly at the LDR, same time lamp on [1][1]. (f) Any one from: do not touch the lamp as it gets hot, keep water away from the circuit, switch off between readings [1].$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | C 12]]
A student measures the count rate from a radioactive source using a Geiger counter. The background count rate, measured with the source removed, is 20 counts per minute. The corrected count rate is the measured count rate minus the background.

Time (min): 0 | 2 | 4 | 6 | 8 | 10
Measured count rate (counts per minute): 420 | 300 | 220 | 160 | 120 | 90
Corrected count rate (counts per minute): 400 | 280 | 200 | ? | 100 | 70

A graph of corrected count rate (vertical axis) against time (horizontal axis) is a smooth curve that falls steeply at first and then more and more slowly. Diagram not to scale.
(a) Explain why the background count rate is subtracted. (1 mark)
(b) Calculate the missing corrected count rate at 6 min. (1 mark)
(c) Describe the pattern of the decay. (2 marks)
(d) Use the data to determine the half-life of the source. Show your working. (2 marks)
(e) Predict the measured count rate at 16 min. (2 marks)
(f) Explain why the measured count rates would not fit a perfectly smooth curve if the experiment were repeated, and suggest an improvement. (2 marks)
(g) Describe two safety precautions that should be taken when handling the source. (2 marks)

Total for Question 4: 12 marks$mq$, $mq$(a) The Geiger counter also detects radiation from the surroundings (rocks, cosmic rays), which is not from the source [1]. (b) 160 - 20 = 140 counts per minute [1]. (c) The count rate falls [1], quickly at first and then more slowly (the rate of decrease is proportional to what remains; each time interval halves the count rate, not a constant amount) [1]. (d) The corrected count rate falls from 400 to 200 [1] in 4 min, so half-life = 4 min (accept 3.8 to 4.2; 280 to 140 between 2 and 6 min gives the same) [1]. (e) 16 min is four half-lives: 400 -> 200 -> 100 -> 50 -> 25 [1]; add the background: 25 + 20 = 45 counts per minute [1]. (f) Radioactive decay is random, so the number of counts in a given time varies [1]; improvement: count for longer or repeat each measurement and average [1]. (g) Any two from: use tongs and never handle directly, keep the source at a distance, store it in a lead-lined box, limit the time of exposure, do not point at people [1][1].$mq$, $mq$C$mq$),
(5, $mq$[[Q 5 | A 8]]
Two identical lamps, each of resistance 12 Ω, are connected in parallel to a 6.0 V battery of negligible internal resistance.
(a) State the unit of electric charge. (1 mark)
(b) A current of 3.0 A flows in a wire for 2.0 minutes. Calculate the charge that flows. (2 marks)
(c) Calculate the current in each lamp. (2 marks)
(d) Calculate the total current drawn from the battery. (1 mark)
(e) One lamp fails and stops conducting. State what happens to the other lamp and explain why. (1 mark)
(f) Calculate the power of one lamp. (1 mark)

Total for Question 5: 8 marks$mq$, $mq$(a) Coulomb (C) [1]. (b) t = 120 s [1]; Q = It = 3.0 x 120 = 360 C [1]. (c) I = V/R [1] = 6.0/12 = 0.50 A [1]. (d) 0.50 + 0.50 = 1.0 A [1]. (e) It stays lit as normal, because it is still connected directly across the 6.0 V battery by its own branch [1]. (f) P = VI = 6.0 x 0.50 = 3.0 W [1].$mq$, $mq$A$mq$),
(6, $mq$[[Q 6 | A 8]]
The table shows the average distance from the Sun and the time for one orbit of four planets. One astronomical unit (AU) is the average distance from the Earth to the Sun.

Planet: Mercury | Earth | Mars | Jupiter
Distance from the Sun (AU): 0.39 | 1.00 | 1.52 | 5.20
Time for one orbit (Earth years): 0.24 | 1.00 | 1.88 | 11.9

(a) Describe the relationship between distance from the Sun and the time for one orbit. (1 mark)
(b) Explain why planets that are further from the Sun take longer to complete an orbit. (2 marks)
(c) The gravitational field strength at the surface of Jupiter is 25 N/kg. Calculate the weight of a person of mass 60 kg on Jupiter. (2 marks)
(d) State what is meant by a moon. (1 mark)
(e) A comet moves in an elliptical orbit around the Sun. Explain why it moves fastest when it is closest to the Sun. (2 marks)

Total for Question 6: 8 marks$mq$, $mq$(a) The further the planet is from the Sun, the longer the time for one orbit [1]. (b) The orbit is longer (larger circumference) [1]; the Sun's gravitational pull is weaker at greater distance, so the planet moves more slowly [1]. (c) W = mg [1] = 60 x 25 = 1500 N [1]. (d) A natural satellite that orbits a planet [1]. (e) The Sun's gravitational pull on the comet is strongest when it is closest [1]; the comet falls towards the Sun, so gravitational potential energy is transferred to kinetic energy and its speed increases [1].$mq$, $mq$A$mq$),
(7, $mq$[[Q 7 | A 2 | C 2 | D 6]]
Read the passage.
A country plans to replace a coal-fired power station of output 1000 MW with a nuclear power station of the same output. Coal burning produces about 5 million tonnes of carbon dioxide each year at this size. The nuclear station would produce almost none while operating, but would take about ten years to build and would cost several billion pounds. The used fuel contains caesium-137, with a half-life of 30 years, and plutonium-239, with a half-life of 24 000 years. The used fuel must be stored safely for thousands of years. Supporters point out that the nuclear station would work all day and night in all weather. Opponents say the money should be spent on renewable energy that is quicker to build.
(a) State what happens to a nucleus in nuclear fission. (1 mark)
(b) State why used nuclear fuel is hazardous. (1 mark)
(c) Calculate the fraction of caesium-137 that remains after 90 years. (2 marks)
(d) Evaluate the proposal to build the nuclear power station. Reach a justified conclusion. (6 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) A large, unstable nucleus (such as uranium-235) splits into two smaller nuclei, releasing energy (and neutrons) [1]. (b) It emits ionising radiation (alpha, beta, gamma) that can damage living cells / stay radioactive for a very long time [1]. (c) 90 years is 90/30 = 3 half-lives [1]; (1/2)³ = 1/8 (12.5%) remains [1]. (d) Up to 6 marks: advantages from the passage, e.g. almost no carbon dioxide while operating (compared with 5 million tonnes a year), works in all weather day and night [1][1]; disadvantages, e.g. long build time (ten years) and high cost, long-lived waste needing storage for thousands of years [1][1]; weighing the factors, e.g. compares the urgency of reducing emissions with the cost and long-term waste risk, or notes that caesium-137 falls to 1/8 in 90 years while plutonium-239 remains for a very long time [1]; justified conclusion, e.g. build with a funded waste plan or combine with renewable energy [1]. Do not credit a conclusion with no reasoning.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Biology MYP 5 eAssessment Paper A (8 tasks, 70 marks) (70 marks)
with sub as (select id from public.subjects where slug = $mq$biology$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Biology MYP 5 eAssessment Paper A (8 tasks, 70 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Biology MYP 5 eAssessment Paper A (8 tasks, 70 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
The human digestive system is made of organs, which are made of tissues, which are made of cells.
(a) Put these levels of organisation in order from smallest to largest: organ system, cell, organ, tissue. (2 marks)
(b) The wall of the stomach contains muscle tissue, epithelial tissue and glandular tissue. State the function of the glandular tissue. (2 marks)
(c) Most absorption of digested food happens in the small intestine. Name the part of the small intestine wall that increases the surface area for absorption and explain how the small intestine is adapted for efficient absorption. (4 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) cell, tissue, organ, organ system [2]. Award 1 mark if only one neighbouring pair is swapped.
(b) Glandular tissue makes (secretes) digestive juices [1], such as acid and enzymes (pepsin) / mucus [1].
(c) Villi (accept microvilli) [1]. Villi/folds give a large surface area [1]; the wall is very thin (one cell thick) so the diffusion distance is short [1]; a dense network of capillaries carries absorbed food away, keeping a steep concentration gradient [1]. (Any three explained points after the name.)$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Plants and animals both use gases to transfer energy, but in opposite directions.
(a) Write the word equation for photosynthesis. (2 marks)
(b) Write the balanced symbol equation for aerobic respiration. (2 marks)
A student measured the net exchange of carbon dioxide (CO2) by a leaf at different light intensities. A positive value means CO2 is released by the leaf and a negative value means CO2 is taken in.
Light intensity (arbitrary units): 0, 20, 40, 60, 80
Net CO2 exchange (units per minute): +3, +1, -1, -3, -5
(c) The rate of respiration stays the same at every light intensity. Determine the light intensity at which the rate of photosynthesis equals the rate of respiration. (2 marks)
(d) Calculate the total (gross) rate of CO2 uptake by photosynthesis at a light intensity of 80 units. (2 marks)

Total for Question 2: 8 marks$mq$, $mq$(a) carbon dioxide + water [1] -> glucose + oxygen [1] (light energy and chlorophyll may be shown above the arrow; accept reversed order of reactants).
(b) C6H12O6 + 6O2 [1] -> 6CO2 + 6H2O [1] (formulae correct but unbalanced scores 1 only).
(c) The net exchange is zero when photosynthesis and respiration cancel out [1]; the values change from +1 at 20 units to -1 at 40 units, so zero is at 30 units [1].
(d) Respiration releases 3 units per minute (reading at 0 light) so photosynthesis must take in 5 + 3 [1] = 8 units per minute [1].$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
Pepsin is a protease found in the stomach. Trypsin is a protease released into the small intestine. The table shows the relative activity of each enzyme at different pH values (100 is the highest activity).
pH: 1, 2, 3, 5, 7, 8, 10
Pepsin: 60, 100, 55, 5, 0, 0, 0
Trypsin: 0, 0, 0, 20, 70, 100, 30
(a) State the optimum pH for pepsin. (1 mark)
(b) Explain why pepsin has no activity at pH 7. (2 marks)
(c) The pancreas and liver release alkaline juices into the small intestine. Explain why this is needed for trypsin to work. (2 marks)
(d) State the products of protein digestion. (1 mark)
(e) Use the lock and key model to explain why trypsin does not digest starch. (2 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) pH 2 [1].
(b) The enzyme is denatured at this pH (its shape changes) [1]; the active site no longer fits the substrate so no reaction occurs [1].
(c) The acid from the stomach makes the contents of the small intestine acidic (trypsin has no activity at low pH) [1]; alkaline juices neutralise the acid and raise the pH to about 8, the optimum for trypsin [1].
(d) Amino acids [1].
(e) The active site of trypsin has a shape complementary only to protein (the substrate) [1]; starch does not fit the active site, so the enzyme is specific and cannot bind it [1].$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | A 8]]
Organisms detect changes in their surroundings and respond.
(a) Define the term phototropism. (1 mark)
A shoot grows towards a window. Auxin is a plant hormone made in the tip of the shoot.
(b) Explain how auxin causes the shoot to bend towards the light. (3 marks)
(c) State how a root responds to gravity. (1 mark)
(d) Compare the nervous system and the hormonal (endocrine) system in animals. (3 marks)

Total for Question 4: 8 marks$mq$, $mq$(a) The growth of a plant part in response to light (direction of the light) [1].
(b) Auxin moves to (collects on) the shaded side of the shoot [1]; it makes cells on that side elongate more [1]; the shaded side grows faster than the lit side, so the shoot bends towards the light [1].
(c) Roots grow downwards (positive gravitropism) [1].
(d) Any three comparisons from: nervous system uses electrical impulses, endocrine system uses chemical hormones; nerves respond quickly, hormones act more slowly; nervous effects are short-lived, hormone effects last longer; nerve signals travel along neurones to a specific target, hormones travel in the blood to target organs [3].$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | B 10]]
A class wants to find out how the intensity of exercise affects pulse rate. Each volunteer steps on and off a 20 cm step for 2 minutes at a rate set by a metronome. The rates are 0 (resting), 20, 40, 60 and 80 steps per minute. Pulse rate is then measured.
(a) Identify the independent variable and the dependent variable. (2 marks)
(b) Formulate a hypothesis, using scientific reasoning. (2 marks)
(c) Outline two variables that should be controlled and say how each would be controlled. (2 marks)
(d) Describe how the pulse rate should be measured so that results are accurate and comparable. (3 marks)
(e) Outline one safety or ethical consideration when using human volunteers. (1 mark)

Total for Question 5: 10 marks$mq$, $mq$(a) Independent: stepping rate (steps per minute) [1]; dependent: pulse rate (beats per minute) [1].
(b) Prediction linking the variables, e.g. as the stepping rate increases, pulse rate will increase [1]; reason, e.g. muscles respire faster and need more oxygen and glucose, so the heart beats faster to deliver them / remove carbon dioxide [1].
(c) Any two controlled variables each with how it is controlled, from: same volunteer or volunteers of similar age and fitness; same step height (20 cm) using the same step; same duration (2 minutes) timed with a stopwatch; same rest time before each test; same room temperature [2].
(d) Measure at the same place (wrist or neck) with fingers, not the thumb [1]; start counting at the same time after stopping (e.g. immediately) and count for a fixed time (e.g. 30 s) then multiply, or use a pulse sensor [1]; repeat the reading and calculate a mean / use the same method each time [1].
(e) Any one from: volunteers may stop if they feel dizzy or unwell; a volunteer with a health condition should not take part; informed consent; rest between trials; use a stable step [1].$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 10]]
Scientists counted rabbits and foxes on an island each year. Rabbit numbers are in hundreds.
Year: 0, 1, 2, 3, 4, 5, 6, 7, 8
Rabbits (hundreds): 40, 70, 110, 90, 50, 30, 60, 100, 85
Foxes: 10, 14, 24, 32, 20, 12, 10, 16, 26
Foxes eat rabbits. Rabbits eat grass.
(a) Calculate the percentage increase in the rabbit population between year 0 and year 2. (2 marks)
(b) Calculate the mean number of foxes for years 0 to 4. (2 marks)
(c) Describe the pattern shown by both populations. (2 marks)
(d) Explain why the fox population fell between year 3 and year 5. (3 marks)
(e) Suggest why there are fewer foxes than rabbits on the island. (1 mark)

Total for Question 6: 10 marks$mq$, $mq$(a) (110 - 40) / 40 x 100 [1] = 175% [1].
(b) (10 + 14 + 24 + 32 + 20) / 5 [1] = 20 foxes [1] (100 / 5).
(c) Both populations rise and fall in repeating cycles [1]; the fox peak (year 3) comes about a year after the rabbit peak (year 2) / the predator follows the prey [1].
(d) Rabbit numbers fell from 110 (year 2) to 50 (year 4) [1]; so there was less food for the foxes [1]; foxes starved or competed for food and fewer survived or reproduced [1].
(e) Energy is lost at each trophic level so the food supports fewer predators than prey / predators are at a higher trophic level [1].$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | D 10]]
Read the passage.
A health service plans to sequence the genome of every newborn baby. A genome map shows the order of the bases in all of a person's DNA. The test can identify around 200 inherited conditions that can be treated if found early, such as some metabolic disorders. A pilot study found a treatable condition in 1 baby in every 100 tested. However, some people worry that the data could be stored insecurely or used by insurance companies. Others say that the results for some genes only show a raised risk, so parents may worry about a disease the child never develops.
(a) Identify two benefits of sequencing newborn genomes. (2 marks)
(b) Describe one risk linked to the storage of genome data. (2 marks)
(c) Explain why a result showing a raised risk does not mean the child will definitely develop the disease. (2 marks)
(d) Evaluate whether the health service should sequence every newborn baby. Support your answer with evidence from the passage and your own knowledge. (4 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) Any two from: early detection of treatable conditions; treatment can begin before damage occurs; helps plan healthcare or understand inherited conditions [2].
(b) Data could be stolen or accessed by hackers [1]; or used by insurers or employers to discriminate against the person (loss of privacy) [1].
(c) Many diseases depend on several genes and on environment or lifestyle as well [1]; an allele may only increase the chance of disease or may be recessive / may never be expressed [1].
(d) Benefit with evidence, e.g. 1 in 100 babies has a treatable condition so early treatment saves health and money [1]; a drawback with evidence, e.g. privacy risks or unnecessary worry from raised-risk results [1]; a balanced judgement or condition, e.g. do it only with parental consent and strong data protection [1]; a justified conclusion that weighs the benefits against the risks [1].$mq$, $mq$D$mq$),
(8, $mq$[[Q 8 | A 8]]
A human body cell has 46 chromosomes. Albinism is caused by a recessive allele, a. The normal allele is A. Two parents who both have the genotype Aa want to have a child.
(a) State the number of chromosomes in a human sperm cell. (1 mark)
(b) State two differences between the products of mitosis and the products of meiosis. (2 marks)
(c) One strand of a DNA molecule has the base sequence T A C G G T. State the sequence of the complementary strand. (2 marks)
(d) Determine the probability that the child will have albinism. Show your working. (2 marks)
(e) Define the term mutation. (1 mark)

Total for Question 8: 8 marks$mq$, $mq$(a) 23 [1].
(b) Any two from: mitosis makes 2 cells, meiosis makes 4 cells; mitosis cells are genetically identical, meiosis cells are genetically different; mitosis cells are diploid (46), meiosis cells are haploid (23) [2].
(c) A T G C C A [2]. Award 1 mark if at least four bases are correct.
(d) Gametes A, a from each parent: offspring AA, Aa, Aa, aa (Punnett square or equivalent) [1]; probability of aa = 1 in 4 (25%, 0.25) [1].
(e) A random change in the DNA sequence (base order) of a gene [1].$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);
commit;
