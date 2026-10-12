-- Part 6 of 12: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Electricity and Magnetism > Circuits, Current and Resistance
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Electricity and Magnetism$mq$, 5, 6 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Circuits, Current and Resistance$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Electricity and Magnetism$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Circuits, Current and Resistance$mq$ and p.name = $mq$Electricity and Magnetism$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the SI unit of electric current?$mq$, $mq$["Ampere (A)","Volt (V)","Ohm (Ω)","Watt (W)"]$mq$, 0, $mq$Current is measured in amperes. Volts measure potential difference and ohms measure resistance.$mq$, $mq$easy$mq$),
($mq$How should an ammeter be connected to measure the current through a lamp?$mq$, $mq$["In parallel with the lamp","In parallel with the battery only","Either way gives the same reading","In series with the lamp"]$mq$, 3, $mq$An ammeter has very low resistance, so it must be placed in the circuit in series so the current flows through it.$mq$, $mq$easy$mq$),
($mq$How should a voltmeter be connected to measure the potential difference across a resistor?$mq$, $mq$["In series with the resistor","In series with the battery","In parallel with the resistor","Across the ammeter only"]$mq$, 2, $mq$A voltmeter measures the difference between two points, so it is connected across the component.$mq$, $mq$easy$mq$),
($mq$What is the unit of resistance?$mq$, $mq$["Ampere (A)","Ohm (Ω)","Coulomb (C)","Joule (J)"]$mq$, 1, $mq$Resistance is measured in ohms, defined by R = V ÷ I.$mq$, $mq$easy$mq$),
($mq$In a series circuit with a cell and three lamps, what is true about the current?$mq$, $mq$["It is the same at every point","It is greatest at the cell","It is shared out between the lamps","It decreases after each lamp"]$mq$, 0, $mq$In a series circuit there is only one path, so the same current flows everywhere. Charge is not used up.$mq$, $mq$easy$mq$),
($mq$A current of 0.50 A flows through a 12 Ω resistor. What is the potential difference across it?$mq$, $mq$["24 V","0.042 V","11.5 V","6.0 V"]$mq$, 3, $mq$V = I × R = 0.50 × 12 = 6.0 V.$mq$, $mq$medium$mq$),
($mq$Three resistors of 4 Ω, 6 Ω and 2 Ω are connected in series to a 12 V supply. What current flows?$mq$, $mq$["0.5 A","12 A","1.0 A","144 A"]$mq$, 2, $mq$Total resistance = 4 + 6 + 2 = 12 Ω. I = V ÷ R = 12 ÷ 12 = 1.0 A.$mq$, $mq$medium$mq$),
($mq$Two 6 Ω resistors are connected in parallel. What is their combined resistance?$mq$, $mq$["12 Ω","3 Ω","6 Ω","1.5 Ω"]$mq$, 1, $mq$For identical resistors in parallel, the total is the value divided by the number: 6 ÷ 2 = 3 Ω. Parallel combinations always have less resistance than the smallest branch.$mq$, $mq$medium$mq$),
($mq$A kettle rated 2000 W is switched on for 3.0 minutes. How much energy does it transfer?$mq$, $mq$["360 000 J","6000 J","2000 J","666 J"]$mq$, 0, $mq$Energy = power × time = 2000 × 180 s = 360 000 J. Remember to convert minutes to seconds.$mq$, $mq$medium$mq$),
($mq$A current of 2.0 A flows through a wire for 30 s. How much charge flows past a point?$mq$, $mq$["15 C","32 C","0.067 C","60 C"]$mq$, 3, $mq$Q = I × t = 2.0 × 30 = 60 C.$mq$, $mq$medium$mq$),
($mq$Four wires are made from the same metal. Which has the greatest resistance?$mq$, $mq$["Short and thin","Long and thick","Long and thin","Short and thick"]$mq$, 2, $mq$Resistance increases with length and decreases with cross-sectional area.$mq$, $mq$medium$mq$),
($mq$What happens to the resistance of a light-dependent resistor (LDR) as the light gets brighter?$mq$, $mq$["It increases","It decreases","It stays the same","It becomes infinite"]$mq$, 1, $mq$In bright light more charge carriers are freed, so the resistance of an LDR falls. This is used in automatic street lights.$mq$, $mq$medium$mq$),
($mq$A component gives these results. Potential difference (V): 1.0, 2.0, 3.0, 4.0. Current (A): 0.20, 0.40, 0.60, 0.80. What can you conclude?$mq$, $mq$["It is an ohmic conductor with a resistance of 5.0 Ω","Its resistance increases as current increases","It is a diode","It has a resistance of 0.20 Ω"]$mq$, 0, $mq$V ÷ I = 5.0 Ω each time, so current is directly proportional to potential difference.$mq$, $mq$medium$mq$),
($mq$A 12 V supply is connected across two parallel branches. Branch X has a 4 Ω resistor and branch Y has a 6 Ω resistor. What current does the supply provide?$mq$, $mq$["1.2 A","2.0 A","3.0 A","5.0 A"]$mq$, 3, $mq$Each branch has the full 12 V. IX = 12 ÷ 4 = 3.0 A and IY = 12 ÷ 6 = 2.0 A. Total current = 5.0 A.$mq$, $mq$hard$mq$),
($mq$A 6 Ω resistor is in series with a parallel pair of 6 Ω and 3 Ω resistors. The supply is 16 V. What is the potential difference across the parallel pair?$mq$, $mq$["8 V","12 V","4 V","16 V"]$mq$, 2, $mq$The parallel pair has resistance (6 × 3) ÷ (6 + 3) = 2 Ω. Total resistance = 8 Ω, so I = 2 A. The parallel pair has V = 2 × 2 = 4 V.$mq$, $mq$hard$mq$),
($mq$A student investigates how the length of nichrome wire affects its resistance. Which set of control variables is best?$mq$, $mq$["Same length and different materials","Same material, same diameter and low current to avoid heating","Same diameter and increasing current each time","Same temperature but different thickness"]$mq$, 1, $mq$Only the length should vary. Material and diameter must be fixed, and a low current prevents the wire heating, which would change resistance.$mq$, $mq$hard$mq$),
($mq$A 3.0 kW heater runs for 2.0 hours. Electricity costs 30 p per kWh. What is the cost?$mq$, $mq$["£1.80","£0.60","£18.00","£0.18"]$mq$, 0, $mq$Energy = 3.0 kW × 2.0 h = 6.0 kWh. Cost = 6.0 × 30 p = 180 p = £1.80.$mq$, $mq$hard$mq$),
($mq$The current-voltage graph of a filament lamp curves so that the gradient flattens at higher voltage. What is the best explanation?$mq$, $mq$["The lamp loses charge","The potential difference falls","The metal becomes a better conductor when hot","The filament gets hotter, so its resistance increases"]$mq$, 3, $mq$A hotter filament has ions vibrating more, which collide with electrons more often, so resistance rises and current rises less quickly.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Circuits, Current and Resistance$mq$ and p.name = $mq$Electricity and Magnetism$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Ohm's law$mq$, $mq$V = I × R. Potential difference (V) = current (A) × resistance (Ω).$mq$),
($mq$Series circuit rules$mq$, $mq$Same current everywhere; potential differences add to the supply; total resistance = R₁ + R₂ + ...$mq$),
($mq$Parallel circuit rules$mq$, $mq$Same potential difference across each branch; branch currents add; total resistance is less than the smallest branch.$mq$),
($mq$Charge formula$mq$, $mq$Q = I × t. Charge (C) = current (A) × time (s).$mq$),
($mq$Electrical power$mq$, $mq$P = V × I. Energy E = P × t. In kilowatt-hours: kW × hours.$mq$),
($mq$Factors affecting wire resistance$mq$, $mq$Longer wire: more resistance. Thicker wire: less resistance. Also depends on material and temperature.$mq$),
($mq$How does an LDR behave?$mq$, $mq$Its resistance decreases as light intensity increases. Used in automatic lights.$mq$),
($mq$How does a thermistor behave?$mq$, $mq$Its resistance decreases as temperature increases (NTC type). Used in temperature sensors.$mq$),
($mq$Why does a filament lamp not obey Ohm's law?$mq$, $mq$As current rises the filament heats and its resistance increases, so the I-V graph is a curve.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Circuits, Current and Resistance$mq$ and p.name = $mq$Electricity and Magnetism$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Charge, current and potential difference
Electric **current** is the rate of flow of charge. In metals the charge carriers are electrons. Current is measured in amperes (A) with an ammeter connected in **series**. Charge (coulombs, C) is found with Q = I × t.
**Potential difference** (voltage) is the energy transferred per unit charge between two points. It is measured in volts (V) with a voltmeter connected in **parallel**.
**Resistance** is how much a component opposes current. It is measured in ohms (Ω).

## Ohm's law
V = I × R. Rearranged, I = V ÷ R and R = V ÷ I.
Worked example: a 12 Ω resistor carries 0.50 A. The potential difference is 12 × 0.50 = 6.0 V.
An **ohmic conductor** such as a fixed resistor at constant temperature has a straight line through the origin on a current-voltage graph. A filament lamp curves because its resistance rises with temperature. A thermistor's resistance falls as temperature rises, and an LDR's resistance falls as light increases.

## Series and parallel circuits
- **Series**: one path. Current is the same everywhere, potential differences add up to the supply, and the total resistance is R₁ + R₂ + R₃.
- **Parallel**: branches. The potential difference across each branch equals the supply, branch currents add up to the total current, and total resistance is less than the smallest branch. For two resistors, R = (R₁ × R₂) ÷ (R₁ + R₂).
Worked example: 4 Ω and 6 Ω in parallel on 12 V. Currents are 3.0 A and 2.0 A, total 5.0 A. In a household, devices are wired in parallel so each gets the full mains voltage and works independently.

## Factors affecting resistance of a wire
Resistance increases with length, decreases with thicker cross-section, and depends on the material and temperature. In an investigation into length, control material, diameter and temperature, and use a low current so the wire does not heat.

## Power and energy
Power is the rate of energy transfer: P = V × I, and energy E = P × t. In the home energy is billed in kilowatt-hours (kWh): kW × hours. A 3.0 kW heater for 2.0 hours uses 6.0 kWh. At 30 p per kWh it costs £1.80.

## Common mistakes
- Putting a voltmeter in series, or an ammeter in parallel.
- Adding the resistances in parallel instead of using the parallel rule.
- Forgetting to convert minutes to seconds in E = P × t.
- Assuming current gets used up around a series circuit.

## How this is examined
Practical contexts are common: investigating resistance of a wire, comparing circuit designs for a street light or testing a component. You may be asked to draw or interpret a circuit, process data into V ÷ I, spot an anomaly, identify control variables and evaluate how reliable the method is. Criterion D tasks look at electricity use and energy efficiency in homes.

Exam tip: Write the formula, substitute with units, and label each answer with its unit. For parallel circuits, always check that the combined resistance is less than the smallest branch.$mq$ from st;

-- Electricity and Magnetism > Static Electricity and Electric Fields
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Electricity and Magnetism$mq$, 5, 6 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Static Electricity and Electric Fields$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Electricity and Magnetism$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Static Electricity and Electric Fields$mq$ and p.name = $mq$Electricity and Magnetism$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$When a plastic rod is rubbed with a cloth, which particles are transferred?$mq$, $mq$["Electrons","Protons","Neutrons","Atoms"]$mq$, 0, $mq$Only electrons are free to move between surfaces. The object that gains electrons becomes negative and the one that loses them becomes positive.$mq$, $mq$easy$mq$),
($mq$Two negatively charged balloons are brought close together. What happens?$mq$, $mq$["They attract each other","Nothing happens","They become neutral","They repel each other"]$mq$, 3, $mq$Like charges repel and unlike charges attract.$mq$, $mq$easy$mq$),
($mq$A polythene rod becomes negatively charged when rubbed. What does this show?$mq$, $mq$["It has lost electrons","It has gained protons","It has gained electrons","It has lost protons"]$mq$, 2, $mq$Negative charge means an excess of electrons.$mq$, $mq$easy$mq$),
($mq$Which type of material can hold static charge on its surface?$mq$, $mq$["A metal wire","An insulator","Salt water","Graphite"]$mq$, 1, $mq$Insulators do not let charge move through them, so charge stays where it is rubbed on.$mq$, $mq$easy$mq$),
($mq$What is the purpose of earthing a charged object?$mq$, $mq$["It lets charge flow safely to the ground","It creates more charge","It adds protons to the object","It stops all electrons moving"]$mq$, 0, $mq$Earthing provides a path to the ground so extra charge flows away and the object becomes neutral.$mq$, $mq$easy$mq$),
($mq$An acetate rod is rubbed with a cloth and becomes positively charged. What happens to the cloth?$mq$, $mq$["It becomes positively charged","It stays neutral","It becomes negative because protons move from the rod","It becomes negatively charged because electrons move from the rod to the cloth"]$mq$, 3, $mq$Charge is conserved. The electrons lost by the rod are gained by the cloth.$mq$, $mq$medium$mq$),
($mq$A charged balloon sticks to a neutral wall. What is the best explanation?$mq$, $mq$["The balloon gives the wall a permanent charge","Gravity pulls the balloon towards the wall","The balloon causes opposite charge to be induced on the wall surface nearest it, so they attract","The wall has a magnet inside"]$mq$, 2, $mq$Charges in the wall move slightly (induction), so the surface nearest the balloon has the opposite charge, which is attracted to it.$mq$, $mq$medium$mq$),
($mq$Why are aircraft earthed while they are being refuelled?$mq$, $mq$["To increase the fuel pressure","To prevent a build-up of static charge that could cause a spark","To make the fuel flow faster","To reduce air resistance"]$mq$, 1, $mq$Friction with fuel can charge the aircraft. A spark near fuel vapour could cause a fire, so the charge is conducted to ground.$mq$, $mq$medium$mq$),
($mq$What is the direction of an electric field line?$mq$, $mq$["From positive charge towards negative charge","From negative towards positive","Round the charge in circles","Parallel to the surface"]$mq$, 0, $mq$Field lines show the direction of force on a small positive test charge.$mq$, $mq$medium$mq$),
($mq$Where is an electric field strongest?$mq$, $mq$["Where the field lines are furthest apart","At the end of the line","Where the lines are parallel","Where the field lines are closest together"]$mq$, 3, $mq$Closer field lines mean a stronger force on a charge.$mq$, $mq$medium$mq$),
($mq$In electrostatic paint spraying the droplets are given the same charge and the object is given the opposite charge. Why?$mq$, $mq$["Droplets stick together to make a thicker layer","The object repels the paint to save paint","Droplets repel each other, spreading out, and are attracted to the object, giving an even coat","The droplets become neutral on reaching the object"]$mq$, 2, $mq$Like charges on the droplets spread the spray; opposite charge on the object attracts them, so little paint is wasted.$mq$, $mq$medium$mq$),
($mq$A negatively charged rod is brought near the cap of an uncharged gold-leaf electroscope without touching it. What is seen?$mq$, $mq$["The leaf stays still","The leaf rises because electrons are repelled down to the leaf","The leaf falls to the cap","The leaf rises because protons move to the leaf"]$mq$, 1, $mq$The rod repels electrons from the cap to the leaf and stem, which then have the same charge and repel each other.$mq$, $mq$medium$mq$),
($mq$What causes the charge build-up in a thundercloud before lightning?$mq$, $mq$["Ice particles rubbing together transfer electrons, separating charge","Chemical reactions between raindrops","Heat from the Sun splitting atoms","Wind removing protons from the cloud"]$mq$, 0, $mq$Friction between ice particles moves electrons, so parts of the cloud become positively and negatively charged until a discharge occurs.$mq$, $mq$medium$mq$),
($mq$A neutral metal ball on an insulating stand has a negative rod held close. The ball is touched briefly with a finger, then the finger and then the rod are removed. What charge does the ball have?$mq$, $mq$["Negative","Neutral","It has no charge because it is a conductor","Positive"]$mq$, 3, $mq$The rod repels electrons, which flow through the finger to earth. After removal the ball has lost electrons, so it is positive.$mq$, $mq$hard$mq$),
($mq$A student wants to compare how well different cloths charge a polythene rod. The rod picks up small paper squares. Which is the dependent variable?$mq$, $mq$["The type of cloth","The mass of each paper square","The number of paper squares picked up","The length of rubbing time"]$mq$, 2, $mq$The type of cloth is the independent variable. The number picked up is measured as the result. Time and paper mass should be controlled.$mq$, $mq$hard$mq$),
($mq$Sphere A has a charge of +6 nC and an identical sphere B has −2 nC. They touch and are then separated. What is the charge on each?$mq$, $mq$["+4 nC","+2 nC","+3 nC","−2 nC"]$mq$, 1, $mq$Total charge = +6 + (−2) = +4 nC, shared equally by identical spheres = +2 nC each.$mq$, $mq$hard$mq$),
($mq$A student says, "Earthing a positively charged rod works because protons flow from the rod to the ground." What is the best evaluation?$mq$, $mq$["Incorrect: electrons flow from the ground to the rod","Correct: protons are free to move in metals","Incorrect: charge cannot flow to earth","Correct: positive charge only moves as neutrons"]$mq$, 0, $mq$Protons are fixed in the nucleus. A positive rod has a shortage of electrons, which flow in from the ground to neutralise it.$mq$, $mq$hard$mq$),
($mq$The electric field around an isolated negative point charge is drawn. What do the lines look like?$mq$, $mq$["Straight lines pointing radially outwards","Circles around the charge","Parallel lines pointing downwards","Straight lines pointing radially inwards"]$mq$, 3, $mq$A positive test charge would be attracted towards the negative charge, so field lines point inwards.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Static Electricity and Electric Fields$mq$ and p.name = $mq$Electricity and Magnetism$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$How does an object become charged?$mq$, $mq$By gaining or losing electrons. Gaining electrons makes it negative; losing electrons makes it positive.$mq$),
($mq$Rules of attraction$mq$, $mq$Like charges repel; unlike charges attract. A charged object can also attract a neutral object by induction.$mq$),
($mq$Why does a rubbed balloon stick to a wall?$mq$, $mq$It induces an opposite charge on the nearby wall surface; the attraction between them holds the balloon.$mq$),
($mq$What is earthing?$mq$, $mq$Connecting an object to the ground so charge flows away safely. Electrons move, not protons.$mq$),
($mq$Electric field$mq$, $mq$A region where a charged particle feels a force. Field lines point away from positive and towards negative.$mq$),
($mq$Field line spacing$mq$, $mq$Close lines mean a strong field; widely spaced lines mean a weak field.$mq$),
($mq$Uniform field$mq$, $mq$The field between two oppositely charged parallel plates: evenly spaced, parallel lines.$mq$),
($mq$Dangers of static electricity$mq$, $mq$Sparks near fuel, lightning, shocks and damage to electronics. Reduced by earthing and bonding.$mq$),
($mq$Uses of static electricity$mq$, $mq$Photocopiers, electrostatic spray painting, inkjet printers and chimney dust precipitators.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Static Electricity and Electric Fields$mq$ and p.name = $mq$Electricity and Magnetism$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Charge and atoms
Atoms contain positive protons, negative electrons and neutral neutrons. Normally an atom is neutral. Only electrons can move between objects. If an object gains electrons it becomes negatively charged; if it loses electrons it becomes positively charged. Charge is measured in coulombs (C), and the total charge is always conserved.

## Charging by friction
When two insulators are rubbed together, electrons transfer from one to the other. A polythene rod rubbed with a cloth gains electrons and becomes negative, while the cloth becomes positive. An acetate rod rubbed with a cloth loses electrons and becomes positive.
- **Like charges repel; unlike charges attract.**
- A charged object can attract a neutral one by **induction**: charges in the neutral object shift slightly, so the nearer surface has the opposite charge. That is why a rubbed balloon sticks to a wall.

## Conductors, insulators and earthing
Metals are conductors, so charge flows through them. Plastics are insulators, so charge stays on them. Earthing connects an object to the ground by a conductor so charge flows away. If a positive rod is earthed, electrons flow up from the ground to neutralise it. Protons never move.
Worked example: a neutral metal ball on an insulating stand and a negative rod nearby. The rod repels electrons. Touch the ball with a finger: electrons flow to earth. Remove the finger, then the rod. The ball is left positive.

## Electric fields
An **electric field** is the region where a charge feels a force. We draw field lines from positive to negative, showing the direction of the force on a small positive test charge. Lines close together mean a strong field. Around a positive point charge lines point outwards, around a negative point charge they point inwards, and between two oppositely charged parallel plates the field is uniform, with evenly spaced parallel lines.

## Uses and dangers
- Uses: photocopiers, inkjet printers, electrostatic paint spraying, dust precipitators in chimneys.
- Dangers: sparks when refuelling vehicles or aircraft, lightning, damage to electronics, and shocks. Prevention includes earthing, antistatic mats and bonding wires.
Lightning forms when ice particles in clouds rub together, build up charge and then discharge to the ground or other clouds.

## Common mistakes
- Saying that protons move when something is charged.
- Saying that insulators cannot be charged. They hold charge well.
- Drawing field lines from negative to positive.
- Thinking a neutral object has no charges at all. It has equal positive and negative charge.

## How this is examined
Questions often describe an experiment such as charging rods and balloons, or an industrial process like spray painting. You explain what happens in terms of electron movement, draw field lines, design a fair test, and evaluate safety measures or the benefit and risk of static electricity in industry.

Exam tip: Always explain static effects in terms of electron transfer and say which object gains or loses electrons. Never say protons move.$mq$ from st;

-- Electricity and Magnetism > Magnetism, Motors and Generators
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Electricity and Magnetism$mq$, 5, 6 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Magnetism, Motors and Generators$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Electricity and Magnetism$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Magnetism, Motors and Generators$mq$ and p.name = $mq$Electricity and Magnetism$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What happens when two north poles of magnets are brought together?$mq$, $mq$["They repel","They attract","They become demagnetised","They swap poles"]$mq$, 0, $mq$Like poles repel and unlike poles attract.$mq$, $mq$easy$mq$),
($mq$Which of these metals is magnetic?$mq$, $mq$["Copper","Aluminium","Gold","Iron"]$mq$, 3, $mq$Iron, nickel and cobalt (and steel) are magnetic materials.$mq$, $mq$easy$mq$),
($mq$Outside a bar magnet, which way do magnetic field lines point?$mq$, $mq$["From south to north","In circles round the centre","From the north pole to the south pole","Away from both poles"]$mq$, 2, $mq$By convention field lines leave the north pole and enter the south pole.$mq$, $mq$easy$mq$),
($mq$How is an electromagnet made?$mq$, $mq$["By rubbing iron with a cloth","By passing current through a coil of wire, usually round an iron core","By heating a magnet","By connecting two magnets in series"]$mq$, 1, $mq$A current produces a magnetic field. A coil strengthens it and an iron core strengthens it further.$mq$, $mq$easy$mq$),
($mq$What energy change takes place in a generator?$mq$, $mq$["Kinetic energy to electrical energy","Electrical energy to kinetic energy","Chemical energy to electrical energy","Light energy to electrical energy"]$mq$, 0, $mq$A generator is turned, for example by a turbine, and produces a voltage by electromagnetic induction.$mq$, $mq$easy$mq$),
($mq$Which change would NOT make an electromagnet stronger?$mq$, $mq$["Increasing the current","Adding an iron core","Adding more turns of wire","Reducing the number of turns of wire"]$mq$, 3, $mq$More turns, more current or an iron core strengthen an electromagnet. Fewer turns weaken it.$mq$, $mq$medium$mq$),
($mq$A wire carrying a current is placed in a magnetic field. What is the result?$mq$, $mq$["The wire becomes a permanent magnet","The current stops","The wire experiences a force","The wire emits sound"]$mq$, 2, $mq$This is the motor effect. Reversing the current or the field reverses the direction of the force.$mq$, $mq$medium$mq$),
($mq$In Fleming's left-hand rule for the motor effect, what does the second finger represent?$mq$, $mq$["Force","Current","Magnetic field","Speed"]$mq$, 1, $mq$Thumb is thrust (force), first finger is field and second finger is current.$mq$, $mq$medium$mq$),
($mq$A transformer has 200 turns on the primary coil and 50 turns on the secondary coil. The input is 240 V a.c. What is the output voltage?$mq$, $mq$["60 V","960 V","4 V","240 V"]$mq$, 0, $mq$Vs ÷ Vp = Ns ÷ Np, so Vs = 240 × 50 ÷ 200 = 60 V. This is a step-down transformer.$mq$, $mq$medium$mq$),
($mq$Why is electricity transmitted at very high voltage in power lines?$mq$, $mq$["High voltage makes the cables thicker","High voltage is safer for people","High voltage increases the current and power","A high voltage means a low current, so less energy is wasted as heat in the cables"]$mq$, 3, $mq$For the same power, P = V × I, so a higher voltage needs a smaller current and the heating loss I²R falls.$mq$, $mq$medium$mq$),
($mq$A student turns the coil of a simple generator faster. What happens to the output?$mq$, $mq$["The voltage decreases","The voltage stays the same but the frequency rises","The voltage and the frequency increase","Only the frequency decreases"]$mq$, 2, $mq$Faster rotation cuts the field more quickly, increasing induced voltage and the number of cycles per second.$mq$, $mq$medium$mq$),
($mq$A bar magnet is pushed into a coil connected to a sensitive meter. When does the meter show a reading?$mq$, $mq$["Whenever the magnet is inside the coil","Only while the magnet is moving","Only when the magnet is still","Only when the magnet is removed"]$mq$, 1, $mq$A voltage is induced only when the magnetic field through the coil is changing.$mq$, $mq$medium$mq$),
($mq$Why does the north pole of a compass needle point to the Earth's geographic north?$mq$, $mq$["The Earth has a magnetic south pole near the geographic north","The Earth has a magnetic north pole near the geographic north","Compass needles are attracted to the Sun","The needle is made from non-magnetic metal"]$mq$, 0, $mq$The needle's north pole is attracted to a magnetic south pole, which lies near the geographic north.$mq$, $mq$medium$mq$),
($mq$An ideal transformer has an input of 12 V and 2.0 A. The output voltage is 240 V. What is the output current?$mq$, $mq$["40 A","2.0 A","0.0042 A","0.10 A"]$mq$, 3, $mq$For an ideal transformer, power in = power out: 12 × 2.0 = 24 W. Output current = 24 ÷ 240 = 0.10 A.$mq$, $mq$hard$mq$),
($mq$A 100 kW supply is sent along cables of resistance 5.0 Ω at 10 000 V. How much power is lost as heat in the cables?$mq$, $mq$["50 000 W","5 W","500 W","100 000 W"]$mq$, 2, $mq$I = P ÷ V = 100 000 ÷ 10 000 = 10 A. Power loss = I²R = 10² × 5.0 = 500 W.$mq$, $mq$hard$mq$),
($mq$What is the job of the split-ring commutator in a d.c. motor?$mq$, $mq$["It reverses the magnetic field","It reverses the current in the coil every half turn so the coil keeps spinning the same way","It provides the magnetic field","It stops the coil moving too quickly"]$mq$, 1, $mq$Without the commutator, the force would reverse after half a turn and the coil would just rock back and forth.$mq$, $mq$hard$mq$),
($mq$How does an a.c. generator differ from a d.c. generator?$mq$, $mq$["An a.c. generator uses slip rings; a d.c. generator uses a split-ring commutator","An a.c. generator uses a battery","A d.c. generator has no magnet","An a.c. generator has a split-ring commutator"]$mq$, 0, $mq$Slip rings keep each end connected to the same brush, so the output alternates. A commutator flips the connection every half turn to give d.c.$mq$, $mq$hard$mq$),
($mq$A class tests how the number of turns affects the number of paper clips an electromagnet picks up. Which change would make the test unfair?$mq$, $mq$["Using the same iron core","Using the same length of wire","Using clips of the same size","Using a different battery voltage for each coil"]$mq$, 3, $mq$Number of turns is the independent variable. The current (set by the voltage) must stay constant, otherwise two things change at once.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Magnetism, Motors and Generators$mq$ and p.name = $mq$Electricity and Magnetism$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Magnetic materials$mq$, $mq$Iron, steel, nickel and cobalt are magnetic. Copper, aluminium and gold are not.$mq$),
($mq$Ways to strengthen an electromagnet$mq$, $mq$Increase the current, add more turns of wire, or add a soft iron core.$mq$),
($mq$Motor effect$mq$, $mq$A current-carrying wire in a magnetic field experiences a force. Direction found with Fleming's left-hand rule.$mq$),
($mq$Fleming's left-hand rule$mq$, $mq$Thumb: thrust (force). First finger: field. Second finger: current.$mq$),
($mq$Electromagnetic induction$mq$, $mq$A voltage is induced in a conductor when the magnetic field through it changes, for example a magnet moving in a coil.$mq$),
($mq$Raising generator output$mq$, $mq$Stronger magnet, more turns, larger coil area, or faster rotation.$mq$),
($mq$Transformer equation$mq$, $mq$Vs ÷ Vp = Ns ÷ Np. For an ideal transformer, Vp × Ip = Vs × Is.$mq$),
($mq$Why transmit at high voltage?$mq$, $mq$High voltage means low current for the same power, so less energy is lost as heat in cables (P = I²R).$mq$),
($mq$Commutator vs slip rings$mq$, $mq$Split-ring commutator in a d.c. motor/generator reverses connections every half turn. Slip rings give a.c.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Magnetism, Motors and Generators$mq$ and p.name = $mq$Electricity and Magnetism$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Magnets and magnetic fields
Magnets have a north pole and a south pole. Like poles repel and unlike poles attract. Only a few materials are magnetic: iron, steel, nickel and cobalt. A **magnetic field** is the region around a magnet where magnetic materials feel a force. Field lines run from north to south outside the magnet, and are closer together where the field is stronger. A plotting compass shows the direction of the field.
The Earth has its own magnetic field. A compass needle's north pole points to the geographic north because there is a magnetic south pole of the Earth near the geographic north.

## Electromagnets
A current in a wire creates a magnetic field. A coil of wire (a solenoid) gives a field like a bar magnet. To make an electromagnet stronger: increase the current, add more turns, or add a soft iron core. It can be switched on and off, which is used in cranes, relays and doorbells.

## The motor effect
A current-carrying wire in a magnetic field feels a force. Use Fleming's left-hand rule: thumb for thrust (force), first finger for field, second finger for current. The force is bigger with a stronger field, a larger current or a longer wire in the field. In a d.c. motor, a coil between magnets is turned by the forces on its two sides, and the **split-ring commutator** reverses the current every half turn so the rotation continues.

## Electromagnetic induction and generators
If a magnet moves in or out of a coil (or the coil moves in a magnetic field), a voltage is induced while the magnetic field through the coil is changing. In a generator a coil spins in a magnetic field. The output voltage increases with a stronger magnet, more turns, a bigger coil or faster rotation. **Slip rings** give alternating current; a commutator gives direct current.

## Transformers
A transformer changes an alternating voltage using two coils on an iron core. The voltage ratio is Vs ÷ Vp = Ns ÷ Np. For an ideal transformer, power in = power out, so Vp × Ip = Vs × Is.
Worked example: Np = 200, Ns = 50, Vp = 240 V. Vs = 240 × 50 ÷ 200 = 60 V (step-down). Step-up transformers raise voltage for transmission; step-down transformers lower it for homes.
Why high voltage? For the same power, a higher voltage means a lower current and less heating loss (I²R). For 100 kW at 10 000 V, I = 10 A, so with 5.0 Ω cable the loss is 10² × 5.0 = 500 W.

## Common mistakes
- Saying transformers work with d.c. They need a changing magnetic field, so a.c. is required.
- Thinking a stationary magnet in a coil induces a voltage.
- Mixing the primary and secondary coils in the ratio.
- Confusing generators (motion → electricity) with motors (electricity → motion).

## How this is examined
Typical contexts are electricity transmission to a town, a wind turbine generator, a crane electromagnet or an investigation into electromagnet strength. You are asked to use the transformer equation, explain why high voltages are used, identify variables in a fair test, and evaluate energy supply choices for a community.

Exam tip: For induction explanations always mention a changing magnetic field. For transformer problems state the equation and which side is primary before substituting.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('integrated-science')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;