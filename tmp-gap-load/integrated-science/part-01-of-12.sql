-- Part 1 of 12: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Matter and Particles > States and the Particle Model
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Matter and Particles$mq$, 5, 1 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$States and the Particle Model$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Matter and Particles$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$States and the Particle Model$mq$ and p.name = $mq$Matter and Particles$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In a solid, how are the particles arranged and how do they move?$mq$, $mq$["Closely packed in a regular pattern, vibrating about fixed positions","Closely packed but sliding freely past each other","Far apart and moving randomly at high speed","Arranged in a regular pattern and moving from place to place"]$mq$, 0, $mq$Solid particles are held in fixed positions by strong forces, so they can only vibrate.$mq$, $mq$easy$mq$),
($mq$Which change of state is called sublimation?$mq$, $mq$["Liquid to gas at the surface only","Gas to liquid on cooling","Solid to liquid on heating","Solid to gas without becoming a liquid"]$mq$, 3, $mq$Sublimation skips the liquid state, for example solid carbon dioxide (dry ice) turning to gas.$mq$, $mq$easy$mq$),
($mq$Why can a gas be compressed much more easily than a liquid?$mq$, $mq$["Gas particles are much smaller than liquid particles","Gas particles have no mass","There are large spaces between gas particles","Gas particles are held together by strong forces"]$mq$, 2, $mq$Gas particles are far apart, so there is plenty of empty space to squeeze them into. Liquid particles already touch.$mq$, $mq$easy$mq$),
($mq$A pure solid is heated and starts to melt. What happens to its temperature while it melts?$mq$, $mq$["It rises steadily","It stays constant","It falls slightly","It rises faster than before"]$mq$, 1, $mq$During a change of state the energy supplied breaks the bonds between particles instead of raising the temperature.$mq$, $mq$easy$mq$),
($mq$A student sees tiny specks of smoke jittering randomly under a microscope. What does this show?$mq$, $mq$["Air particles are moving randomly and colliding with the smoke specks","The smoke specks are alive","The smoke specks are attracted to each other","Air particles are completely still"]$mq$, 0, $mq$This is Brownian motion: unseen fast-moving air particles bump the visible specks from all directions.$mq$, $mq$easy$mq$),
($mq$Ice at −10 °C is heated steadily. The graph of temperature against time has a flat section at 0 °C. What is the energy being used for during this flat section?$mq$, $mq$["Making the particles vibrate faster","Making the particles heavier","Heating the thermometer","Overcoming the forces holding the particles in the solid"]$mq$, 3, $mq$At the melting point the energy goes into breaking the forces between particles, not into raising the average kinetic energy.$mq$, $mq$medium$mq$),
($mq$A sealed syringe of air is pushed so its volume halves at constant temperature. Why does the pressure rise?$mq$, $mq$["Particles hit the walls harder because they speed up","The particles get bigger","Particles hit the walls more often because they are closer together","The particles stop moving"]$mq$, 2, $mq$Same speed but less space means more collisions per second with the walls, so the pressure increases.$mq$, $mq$medium$mq$),
($mq$Cotton wool soaked in ammonia solution is placed at one end of a long glass tube and cotton wool soaked in hydrochloric acid at the other end. A white ring forms closer to the hydrochloric acid end. What explains this?$mq$, $mq$["Ammonia particles are heavier so they diffuse faster","Ammonia particles are lighter so they diffuse faster","Hydrochloric acid particles are lighter so they diffuse faster","Both diffuse at the same speed so the ring is random"]$mq$, 1, $mq$Lighter particles move faster at the same temperature, so the ammonia travels further before meeting the HCl.$mq$, $mq$medium$mq$),
($mq$A sealed rigid container of gas is heated. Why does the pressure rise?$mq$, $mq$["Particles move faster so they collide with the walls harder and more often","Particles expand as they heat up","More particles enter the container","Particles become attracted to the walls"]$mq$, 0, $mq$Higher temperature means higher average kinetic energy. Volume is fixed, so impacts are harder and more frequent.$mq$, $mq$medium$mq$),
($mq$Substance X has a melting point of −7 °C and a boiling point of 59 °C. What state is it in at 25 °C?$mq$, $mq$["Solid","Gas","A mixture of solid and gas","Liquid"]$mq$, 3, $mq$25 °C is above the melting point and below the boiling point, so X is a liquid.$mq$, $mq$medium$mq$),
($mq$Why does ice float on liquid water?$mq$, $mq$["Ice particles are lighter than water particles","Ice particles are moving faster than water particles","In ice the particles are held in an open arrangement, so ice is less dense","Ice has more particles than the same volume of water"]$mq$, 2, $mq$Water is unusual: its particles are spaced further apart in ice than in liquid water, so ice is less dense.$mq$, $mq$medium$mq$),
($mq$A student investigates how temperature affects how fast sugar dissolves. Which set of variables should be kept the same?$mq$, $mq$["Temperature, mass of sugar and volume of water","Mass of sugar, volume of water and stirring","Time taken and temperature","Only the volume of water"]$mq$, 1, $mq$Temperature is the independent variable and time is the dependent variable. All others are control variables.$mq$, $mq$medium$mq$),
($mq$What is the main difference between evaporation and boiling?$mq$, $mq$["Evaporation happens at the surface at any temperature; boiling happens throughout the liquid at the boiling point","Evaporation needs a higher temperature than boiling","Boiling happens only at the surface","Evaporation is a chemical change; boiling is a physical change"]$mq$, 0, $mq$Both are physical changes. Only boiling forms bubbles of vapour inside the liquid at its boiling point.$mq$, $mq$medium$mq$),
($mq$A liquid is heated and its temperature recorded. Time (min): 0, 2, 4, 6, 8, 10, 12. Temperature (°C): 20, 40, 60, 78, 78, 78, 90. Which conclusion is best supported?$mq$, $mq$["The liquid melted at 78 °C","The liquid is impure because the temperature rose","The liquid boils at 90 °C","The liquid boiled between about 6 and 10 minutes, so its boiling point is 78 °C"]$mq$, 3, $mq$The flat section shows a change of state. After all the liquid has boiled, the vapour heats up again, giving 90 °C at 12 minutes.$mq$, $mq$hard$mq$),
($mq$A balloon is moved from a warm room to a freezer and shrinks. Which explanation is correct?$mq$, $mq$["The gas particles shrink in the cold","Some gas particles turn into a liquid and vanish","Gas particles slow down, collide less forcefully, so the outside pressure compresses the balloon","The gas particles stop completely"]$mq$, 2, $mq$Particle size does not change. Slower particles give a lower internal pressure, so the balloon shrinks until the pressures balance.$mq$, $mq$hard$mq$),
($mq$A textbook diagram shows particles as solid spheres. Which is a limitation of this model?$mq$, $mq$["It cannot show that particles are in a solid","It does not show the forces between particles","It shows particles as too widely spaced in a gas","It cannot be used to explain diffusion"]$mq$, 1, $mq$The model shows arrangement but not the attractive forces, and it cannot show that atoms are mostly empty space.$mq$, $mq$hard$mq$),
($mq$A gas has a volume of 6.0 L at a pressure of 100 kPa. At constant temperature the volume is reduced to 3.0 L. What is the new pressure?$mq$, $mq$["200 kPa","50 kPa","100 kPa","300 kPa"]$mq$, 0, $mq$At constant temperature pressure × volume stays the same: 100 × 6.0 = 600, and 600 ÷ 3.0 = 200 kPa.$mq$, $mq$hard$mq$),
($mq$Two beakers of water, one at 20 °C and one at 60 °C, each receive one drop of dye. The dye spreads fully in 90 s in the warm beaker and 240 s in the cold one. Which is the best conclusion and improvement?$mq$, $mq$["Dye is heavier in cold water; use a bigger drop","Temperature has no effect; use more beakers","Diffusion only happens in warm water; stop the experiment","Diffusion is faster when warmer; repeat the trial to check reliability"]$mq$, 3, $mq$Faster particles at a higher temperature diffuse faster. One trial each is not reliable, so repeats are needed.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$States and the Particle Model$mq$ and p.name = $mq$Matter and Particles$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Solid particle behaviour$mq$, $mq$Closely packed, regular pattern, vibrate about fixed positions; strong forces between particles.$mq$),
($mq$Gas particle behaviour$mq$, $mq$Far apart, move quickly and randomly, weak forces between particles; fill the container and are easily compressed.$mq$),
($mq$Sublimation$mq$, $mq$A change of state from solid directly to gas without becoming a liquid, e.g. dry ice.$mq$),
($mq$Why is the temperature flat during melting?$mq$, $mq$Energy supplied breaks the forces between particles rather than increasing their kinetic energy.$mq$),
($mq$What causes gas pressure?$mq$, $mq$Gas particles colliding with the walls of the container.$mq$),
($mq$Diffusion$mq$, $mq$The net movement of particles from high to low concentration because of random motion; faster when hot and for lighter particles.$mq$),
($mq$Brownian motion$mq$, $mq$Random jittery movement of visible specks caused by collisions with fast-moving, unseen particles.$mq$),
($mq$Evaporation vs boiling$mq$, $mq$Evaporation: at the surface, any temperature. Boiling: throughout the liquid at the boiling point.$mq$),
($mq$Pressure and volume of a gas (constant temperature)$mq$, $mq$Pressure × volume is constant: halving the volume doubles the pressure.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$States and the Particle Model$mq$ and p.name = $mq$Matter and Particles$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The big idea
Everything around us is made of tiny particles that are constantly in motion. The particle model explains the properties of solids, liquids and gases, and why substances change state.

## The three states
- **Solid**: particles are closely packed in a regular pattern, held by strong forces. They vibrate about fixed positions. Solids keep their shape and volume and are hard to compress.
- **Liquid**: particles are close together but irregularly arranged. They slide past each other. Liquids have a fixed volume but take the shape of their container.
- **Gas**: particles are far apart and move quickly in random directions with very weak forces between them. Gases fill their container and are easily compressed.

## Changes of state
Melting, freezing, boiling (or evaporating), condensing and sublimation are physical changes: no new substance forms. When a solid is heated, its particles gain energy and vibrate more. At the melting point the energy goes into breaking the forces holding the particles in place, so the temperature stays flat on a heating curve. The same happens at the boiling point. Do not say the particles "get bigger" or "melt". The particles themselves never change.

Evaporation happens at the surface of a liquid at any temperature when fast particles escape. Boiling happens throughout the liquid at the boiling point, with bubbles of vapour forming.

## Diffusion and gas pressure
Diffusion is the net movement of particles from a region of high concentration to low concentration due to random motion. It happens faster at higher temperatures and with lighter particles. Brownian motion, the jittery movement of visible specks, is evidence that unseen particles are moving and colliding.

Gas pressure is caused by particles colliding with the walls of the container. Heating a gas in a fixed volume increases pressure because particles move faster. Squeezing a gas into a smaller volume at constant temperature increases pressure because collisions are more frequent. For a fixed amount of gas at constant temperature, pressure × volume stays constant. Worked example: 4.0 L at 150 kPa compressed to 2.0 L gives 150 × 4.0 ÷ 2.0 = 300 kPa.

## Common mistakes
- Saying particles expand when heated. They move faster and take up more space between them.
- Forgetting that during a change of state the temperature stays constant.
- Mixing up evaporation and boiling.
- Describing the particle model as "real": it is a model, and it does not show forces or the empty space inside atoms.

## How this is examined
In the eAssessment, this topic usually appears in a context such as a cooling or heating experiment, a diffusion demonstration, or a gas syringe investigation. You may be given temperature-time data and asked to identify the melting or boiling point, explain a flat section using the particle model, or evaluate the method (control variables, repeats, reliability). Extended tasks ask you to design a fair test and to comment on the limitations of the model.

Exam tip: When explaining any change in terms of particles, always mention what the particles are doing (speed, spacing, forces) and link it to the observation. Never say the particles themselves change size, shape or temperature.$mq$ from st;

-- Matter and Particles > Atoms, Elements and the Periodic Table
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Matter and Particles$mq$, 5, 1 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Atoms, Elements and the Periodic Table$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Matter and Particles$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Atoms, Elements and the Periodic Table$mq$ and p.name = $mq$Matter and Particles$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which particle in an atom has no electric charge?$mq$, $mq$["Neutron","Proton","Electron","Nucleus"]$mq$, 0, $mq$Protons are positive, electrons negative and neutrons neutral. The nucleus as a whole is positive.$mq$, $mq$easy$mq$),
($mq$The atomic number of an element is the number of what?$mq$, $mq$["Neutrons in the nucleus","Protons plus neutrons","Electrons in the outer shell","Protons in the nucleus"]$mq$, 3, $mq$Atomic number = number of protons. It identifies the element.$mq$, $mq$easy$mq$),
($mq$What are the Group 1 metals commonly called?$mq$, $mq$["Halogens","Noble gases","Alkali metals","Transition metals"]$mq$, 2, $mq$Group 1 contains lithium, sodium, potassium and others, called the alkali metals.$mq$, $mq$easy$mq$),
($mq$Sodium has atomic number 11. What is its electron arrangement?$mq$, $mq$["2,8,8","2,8,1","2,9","2,1,8"]$mq$, 1, $mq$Shells fill 2, then 8, then the rest. Eleven electrons gives 2,8,1.$mq$, $mq$easy$mq$),
($mq$Which of these is a noble gas?$mq$, $mq$["Argon","Chlorine","Oxygen","Nitrogen"]$mq$, 0, $mq$Argon is in Group 18. The others are reactive non-metals.$mq$, $mq$easy$mq$),
($mq$An atom has 17 protons and 18 neutrons. What is its mass number?$mq$, $mq$["17","18","1","35"]$mq$, 3, $mq$Mass number = protons + neutrons = 17 + 18 = 35.$mq$, $mq$medium$mq$),
($mq$Chlorine-35 and chlorine-37 are isotopes. How do their atoms differ?$mq$, $mq$["They have different numbers of protons","They have different numbers of electrons","They have different numbers of neutrons","They are in different groups"]$mq$, 2, $mq$Isotopes have the same atomic number but different mass numbers because of extra neutrons.$mq$, $mq$medium$mq$),
($mq$An element has the electron arrangement 2,8,7. Where is it in the periodic table?$mq$, $mq$["Group 7, Period 17","Group 17 (halogens), Period 3","Group 17, Period 2","Group 3, Period 7"]$mq$, 1, $mq$Seven outer electrons puts it in Group 17 (the halogens). Three occupied shells means Period 3.$mq$, $mq$medium$mq$),
($mq$Lithium, sodium and potassium react with water. Why does reactivity increase down Group 1?$mq$, $mq$["The outer electron is further from the nucleus and is lost more easily","The atoms have fewer shells","The atoms have fewer protons","The outer electron is held more strongly"]$mq$, 0, $mq$Down the group there are more shells, so the outer electron is more shielded and less strongly attracted.$mq$, $mq$medium$mq$),
($mq$A solid element is shiny, conducts electricity, can be hammered into sheets and forms a basic oxide. What kind of element is it?$mq$, $mq$["A non-metal","A noble gas","A metalloid gas","A metal"]$mq$, 3, $mq$These are typical metallic properties. Non-metals usually form acidic oxides and do not conduct.$mq$, $mq$medium$mq$),
($mq$Magnesium has atomic number 12. How many electrons are in a Mg²⁺ ion?$mq$, $mq$["12","14","10","2"]$mq$, 2, $mq$A neutral atom has 12 electrons. Losing two electrons to form Mg²⁺ leaves 10.$mq$, $mq$medium$mq$),
($mq$Why are the noble gases unreactive?$mq$, $mq$["They have only one electron","Their outer shells are full","They are all lighter than air","They have no protons"]$mq$, 1, $mq$A full outer shell is stable, so the atoms do not need to gain, lose or share electrons.$mq$, $mq$medium$mq$),
($mq$Mendeleev left gaps in his periodic table. Why was this useful?$mq$, $mq$["He predicted that undiscovered elements would fill them, and he was proved right","It made the table look neat","It showed that all elements were already known","It proved that atoms are divisible"]$mq$, 0, $mq$Predictions of the properties of missing elements were later confirmed, which supported his arrangement.$mq$, $mq$medium$mq$),
($mq$Chlorine exists as 75% chlorine-35 and 25% chlorine-37. What is the relative atomic mass?$mq$, $mq$["36.0","35.0","36.5","35.5"]$mq$, 3, $mq$(75 × 35 + 25 × 37) ÷ 100 = 3550 ÷ 100 = 35.5.$mq$, $mq$hard$mq$),
($mq$A particle has 19 protons, 20 neutrons and 18 electrons. Which description is correct?$mq$, $mq$["A neutral atom with mass number 39","A negative ion with a charge of 1− and mass number 38","A positive ion with a charge of 1+ and mass number 39","A positive ion with a charge of 1+ and mass number 20"]$mq$, 2, $mq$There is one more proton than electrons so the charge is 1+. Mass number = 19 + 20 = 39.$mq$, $mq$hard$mq$),
($mq$Three Group 1 metals are dropped into water. X fizzes slowly. Y melts into a ball and moves quickly. Z burns with a lilac flame. Which prediction for rubidium, which is below potassium, is best?$mq$, $mq$["It will react less vigorously than X","It will react even more vigorously than Z","It will not react","It will react like Y"]$mq$, 1, $mq$Reactivity increases down Group 1, so rubidium below potassium should be even more reactive.$mq$, $mq$hard$mq$),
($mq$Chlorine water is added to potassium bromide solution and the mixture turns orange. What is the best explanation?$mq$, $mq$["Chlorine is more reactive than bromine, so it displaces bromine","Bromine is more reactive than chlorine","Chlorine and bromine are isotopes","The potassium has been displaced as a gas"]$mq$, 0, $mq$A more reactive halogen displaces a less reactive one from its salt. The orange colour is bromine.$mq$, $mq$hard$mq$),
($mq$In an alpha particle scattering experiment on thin gold foil, most particles went straight through and a very small number bounced back. What does this show?$mq$, $mq$["Atoms are solid spheres of positive charge","Electrons are in the nucleus","All alpha particles are the same size as atoms","Atoms are mostly empty space with a tiny, dense, positive nucleus"]$mq$, 3, $mq$Most passed through empty space; a few were strongly deflected by the small, dense, positive nucleus.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Atoms, Elements and the Periodic Table$mq$ and p.name = $mq$Matter and Particles$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Proton, neutron, electron$mq$, $mq$Proton: +1, mass 1. Neutron: 0, mass 1. Electron: −1, negligible mass.$mq$),
($mq$Atomic number$mq$, $mq$The number of protons in the nucleus; it identifies the element.$mq$),
($mq$Mass number$mq$, $mq$Number of protons plus neutrons in an atom.$mq$),
($mq$Isotopes$mq$, $mq$Atoms of the same element with the same number of protons but different numbers of neutrons.$mq$),
($mq$Electron arrangement of the first 20 elements$mq$, $mq$Fill shells in order: 2, then 8, then 8, then the rest. E.g. sodium is 2,8,1.$mq$),
($mq$Trend in reactivity in Group 1$mq$, $mq$Reactivity increases down the group; the outer electron is further from the nucleus and is lost more easily.$mq$),
($mq$Trend in reactivity in Group 17$mq$, $mq$Reactivity decreases down the group. A more reactive halogen displaces a less reactive one from its salt solution.$mq$),
($mq$Why are noble gases unreactive?$mq$, $mq$They have full outer shells of electrons, so they do not need to gain, lose or share electrons.$mq$),
($mq$Result of the gold foil scattering experiment$mq$, $mq$Most alpha particles went straight through, a few were deflected: atoms are mostly empty space with a small, dense, positive nucleus.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Atoms, Elements and the Periodic Table$mq$ and p.name = $mq$Matter and Particles$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Atoms and sub-atomic particles
Every element is made of one type of atom. An atom has a tiny central nucleus containing **protons** (relative charge +1, relative mass 1) and **neutrons** (charge 0, mass 1). **Electrons** (charge −1, negligible mass) move around the nucleus in shells. A neutral atom has equal numbers of protons and electrons.

- **Atomic number** = number of protons. It defines the element.
- **Mass number** = protons + neutrons.
- Number of neutrons = mass number − atomic number.

Worked example: an atom of potassium has atomic number 19 and mass number 39. It has 19 protons, 19 electrons and 39 − 19 = 20 neutrons.

## Isotopes and ions
**Isotopes** are atoms of the same element with different numbers of neutrons, so they have different mass numbers but the same chemical properties. The **relative atomic mass** is the weighted average of the isotopes. If chlorine is 75% chlorine-35 and 25% chlorine-37, the average is (75 × 35 + 25 × 37) ÷ 100 = 35.5.

An **ion** is a charged particle formed when an atom gains or loses electrons. Metals lose electrons to form positive ions. Non-metals gain electrons to form negative ions.

## Electron arrangement
Electrons fill shells from the inside: 2 in the first, 8 in the second, 8 in the third (for the first 20 elements). Sodium (11 electrons) is 2,8,1. The number of outer electrons gives the group, and the number of shells gives the period.

## The periodic table
Elements are arranged by increasing atomic number. Mendeleev's early table left gaps for undiscovered elements and correctly predicted their properties. Key families:
- **Group 1, alkali metals**: soft, reactive; reactivity increases down the group because the outer electron is further from the nucleus and lost more easily.
- **Group 17, halogens**: reactive non-metals; reactivity decreases down the group. A more reactive halogen displaces a less reactive one from a solution of its salt.
- **Group 18, noble gases**: unreactive because their outer shells are full.

Metals are shiny, conduct electricity and heat, and are malleable. Non-metals are usually dull, brittle and poor conductors.

## How the model developed
Scattering experiments with thin gold foil showed that most alpha particles went straight through but a few were deflected strongly. This showed that atoms are mostly empty space with a small, dense, positive nucleus. Science models change when new evidence appears.

## Common mistakes
- Using mass number as the number of protons.
- Forgetting that an ion has a different number of electrons from protons.
- Saying that isotopes have different chemical properties.

## How this is examined
Questions often provide a table of data on reactions of metals with water or halogen displacement, and ask you to find a pattern, predict a missing element, and justify using electron arrangement. You may also evaluate how a scientific model changed.

Exam tip: When asked to explain a trend in a group, always link the number of shells, the distance of the outer electrons from the nucleus and how easily they are lost or gained.$mq$ from st;

-- Matter and Particles > Mixtures, Compounds and Separation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Matter and Particles$mq$, 5, 1 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Mixtures, Compounds and Separation$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Matter and Particles$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Mixtures, Compounds and Separation$mq$ and p.name = $mq$Matter and Particles$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a mixture?$mq$, $mq$["Two or more substances that are not chemically combined","A substance with only one type of atom","A substance with atoms joined in a fixed ratio","A solid that melts at a sharp temperature"]$mq$, 0, $mq$The parts of a mixture keep their own properties and can be separated physically.$mq$, $mq$easy$mq$),
($mq$Which method best separates insoluble sand from water?$mq$, $mq$["Evaporation","Chromatography","Distillation","Filtration"]$mq$, 3, $mq$Sand particles are too large to pass through filter paper, but water does.$mq$, $mq$easy$mq$),
($mq$Which method obtains solid salt from salt solution?$mq$, $mq$["Filtration","Magnetism","Evaporation or crystallisation","Using a separating funnel"]$mq$, 2, $mq$Heating the solution removes the water and leaves the salt.$mq$, $mq$easy$mq$),
($mq$Which of these is a compound?$mq$, $mq$["Oxygen (O₂)","Water (H₂O)","Air","Sea water"]$mq$, 1, $mq$A compound has different atoms chemically joined in a fixed ratio. Air and sea water are mixtures.$mq$, $mq$easy$mq$),
($mq$A student wants to find which dyes are in a black ink. Which technique should be used?$mq$, $mq$["Chromatography","Filtration","Distillation","Crystallisation"]$mq$, 0, $mq$Different dyes travel different distances up the paper, separating the ink.$mq$, $mq$easy$mq$),
($mq$Why can ethanol be separated from a mixture of ethanol and water by distillation?$mq$, $mq$["They have different colours","One is a solid","Ethanol is insoluble in water","The two liquids have different boiling points"]$mq$, 3, $mq$The liquid with the lower boiling point evaporates first and is condensed and collected.$mq$, $mq$medium$mq$),
($mq$In chromatography a spot moves 3.0 cm while the solvent front moves 7.5 cm. What is the Rf value?$mq$, $mq$["2.5","0.25","0.40","4.5"]$mq$, 2, $mq$Rf = distance moved by spot ÷ distance moved by solvent = 3.0 ÷ 7.5 = 0.40.$mq$, $mq$medium$mq$),
($mq$Which statement about a compound is correct?$mq$, $mq$["It can be separated by filtering","It has fixed composition and different properties from its elements","It keeps the properties of its elements","Its composition can vary"]$mq$, 1, $mq$Compounds form in chemical reactions and need chemical methods to separate.$mq$, $mq$medium$mq$),
($mq$Iron and sulfur are heated together and a dark grey solid forms. Which observation shows a compound formed?$mq$, $mq$["The product is not attracted to a magnet","The product is a solid","The product contains iron","The mixture was heated"]$mq$, 0, $mq$Iron sulfide has different properties from iron. In a mixture the iron could still be removed with a magnet.$mq$, $mq$medium$mq$),
($mq$A sample of a solid melts gradually between 78 °C and 84 °C. What does this suggest?$mq$, $mq$["The sample is a pure element","The sample is a gas","The sample is a pure compound","The sample is impure"]$mq$, 3, $mq$Pure substances melt at one sharp temperature. Impurities give a melting range.$mq$, $mq$medium$mq$),
($mq$A mixture of sand, salt and iron filings needs separating. What should be done first?$mq$, $mq$["Evaporate the mixture","Add water and then filter","Use a magnet to remove the iron","Use chromatography"]$mq$, 2, $mq$The magnet works on the dry mixture. After that, adding water dissolves the salt so the sand can be filtered off, then the filtrate is evaporated.$mq$, $mq$medium$mq$),
($mq$Crude oil is separated by fractional distillation. Why do fractions with small molecules leave near the top of the column?$mq$, $mq$["They have higher boiling points","They have lower boiling points and condense at lower temperatures higher up","They are heavier and sink","They are solids"]$mq$, 1, $mq$The column is hot at the bottom and cooler at the top. Small molecules stay as vapour until near the top.$mq$, $mq$medium$mq$),
($mq$Which is a correct definition of an element?$mq$, $mq$["A substance made of only one type of atom","A substance made of different atoms joined together","A mixture of compounds","A substance that cannot be seen"]$mq$, 0, $mq$Elements cannot be broken down into simpler substances by chemical methods.$mq$, $mq$medium$mq$),
($mq$A chromatogram is run with known dyes A (Rf 0.30), B (Rf 0.55) and C (Rf 0.80) and an unknown ink. The ink has spots at Rf 0.30 and 0.80. What is the best conclusion?$mq$, $mq$["The ink contains all three dyes","The ink contains only dye C","The ink is a pure substance","The ink contains dyes A and C but not B"]$mq$, 3, $mq$Spots matching Rf values of A and C identify those dyes. There is no spot at 0.55, so B is absent.$mq$, $mq$hard$mq$),
($mq$Why is the starting line in chromatography drawn in pencil rather than pen?$mq$, $mq$["Pencil is darker than pen","Pencil ink is a compound","Pencil does not dissolve in the solvent, so it will not interfere with the results","Pen would make the paper heavier"]$mq$, 2, $mq$Pen ink would itself separate and add extra spots to the chromatogram.$mq$, $mq$hard$mq$),
($mq$A town treats river water by screening, sedimentation, filtration and chlorination. Why would these steps alone NOT make sea water drinkable?$mq$, $mq$["Chlorine reacts with salt","Dissolved salts are small enough to pass through the filter","Sea water has no solids to remove","Salt is a gas"]$mq$, 1, $mq$Filtration only removes insoluble particles. Removing dissolved salt needs distillation or similar.$mq$, $mq$hard$mq$),
($mq$In a distillation set-up, cold water enters the condenser at the bottom and leaves at the top. Why?$mq$, $mq$["It keeps the condenser jacket full of water, so cooling is efficient","It makes the water boil","It prevents the vapour leaving","It heats the condenser"]$mq$, 0, $mq$If water entered at the top, it could drain away leaving air gaps and poor cooling.$mq$, $mq$hard$mq$),
($mq$A sample of 'pure' water boils at 101.5 °C at normal sea-level pressure. What is the best evaluation?$mq$, $mq$["The water is pure because boiling points vary","The thermometer is measuring the melting point","The water must be a mixture of gases","The water probably contains dissolved impurities that raise the boiling point"]$mq$, 3, $mq$Pure water boils at 100 °C at normal pressure. A higher boiling point suggests dissolved substances, though the thermometer should also be checked.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Mixtures, Compounds and Separation$mq$ and p.name = $mq$Matter and Particles$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Element$mq$, $mq$A substance made of only one type of atom.$mq$),
($mq$Compound$mq$, $mq$Two or more elements chemically joined in a fixed ratio; properties differ from the elements.$mq$),
($mq$Mixture$mq$, $mq$Two or more substances not chemically joined; each keeps its properties and can be separated physically.$mq$),
($mq$Filtration$mq$, $mq$Separates an insoluble solid (residue) from a liquid (filtrate).$mq$),
($mq$Simple distillation$mq$, $mq$Separates a solvent from a solution by boiling then condensing the vapour.$mq$),
($mq$Fractional distillation$mq$, $mq$Separates liquids with different boiling points; the lowest boiling point comes off first.$mq$),
($mq$Rf value$mq$, $mq$Distance moved by spot ÷ distance moved by solvent front. Same substance, same solvent gives the same Rf.$mq$),
($mq$Purity test using melting point$mq$, $mq$Pure substances melt at a sharp, fixed temperature; impurities give a lower, wider melting range.$mq$),
($mq$Why does filtration not remove dissolved salt?$mq$, $mq$Dissolved particles are smaller than the holes in filter paper and pass through.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Mixtures, Compounds and Separation$mq$ and p.name = $mq$Matter and Particles$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Elements, compounds and mixtures
An **element** contains only one type of atom, for example oxygen or iron. A **compound** contains two or more different elements chemically joined in a fixed ratio, for example water (H₂O) or sodium chloride. A **mixture** contains two or more substances that are not chemically joined, such as air, sea water or ink. The substances in a mixture keep their own properties and their proportions can vary.

Compounds have properties very different from their elements. Iron and sulfur powder in a mixture can be separated with a magnet. After heating they react to form iron sulfide, a compound that is not magnetic. Separating a compound needs a chemical reaction. Separating a mixture needs only physical methods.

## Pure substances
A pure substance has a fixed melting point and boiling point. Impurities lower the melting point, raise the boiling point and make the change happen over a range of temperatures. Chemists use melting and boiling points as a purity test.

## Separation methods
Choose the method by thinking about the properties that differ.
- **Filtration**: separates an insoluble solid from a liquid. The solid is the residue and the liquid that passes through is the filtrate.
- **Evaporation and crystallisation**: obtain a dissolved solid from a solution by removing the solvent.
- **Simple distillation**: separates a solvent from a solution, for example pure water from salt water. The liquid is boiled, the vapour is cooled in a condenser and collected.
- **Fractional distillation**: separates liquids with different boiling points, such as ethanol from water or the fractions in crude oil. The lowest boiling point comes off first.
- **Chromatography**: separates dissolved substances that travel different distances up paper.
- **Magnet**: separates magnetic materials such as iron.

## Chromatography calculations
The Rf value is the distance moved by the spot divided by the distance moved by the solvent front. For a spot that moved 3.0 cm while the solvent front moved 7.5 cm, Rf = 3.0 ÷ 7.5 = 0.40. A substance always has the same Rf in the same solvent, so matching Rf values to known samples identifies the substances. Draw the starting line in pencil, because pen ink would separate too, and keep the line above the level of the solvent.

## Science in society
Water treatment includes screening, sedimentation, filtration and chlorination. These remove solids and kill microbes but do not remove dissolved salts. Desalination, using distillation or membranes, uses large amounts of energy, so engineers weigh the benefits against the cost and environmental impact.

## Common mistakes
- Calling air or sea water a compound.
- Saying filtration removes dissolved substances.
- Confusing residue and filtrate.

## How this is examined
Questions often present a scenario such as a forensic ink test, a water supply or a recycling plant. You choose and justify a separation method, interpret a chromatogram, use Rf values, or evaluate the method and the impact on society.

Exam tip: To justify a separation method, name the property that differs (solubility, boiling point, magnetism or particle size) and link it to the method.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('integrated-science')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;