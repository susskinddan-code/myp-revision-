-- Part 4 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Static Electricity and Fields > Electric Fields
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Static Electricity and Fields$mq$, 5, 4 from public.subjects s where s.slug = $mq$physics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Electric Fields$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physics$mq$ and p.grade = 5 and p.name = $mq$Static Electricity and Fields$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Electric Fields$mq$ and p.name = $mq$Static Electricity and Fields$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is an electric field?$mq$, $mq$["A region where a charged object experiences a force","A region where only magnets have a force","The area around a battery","A line of electrons"]$mq$, 0, $mq$An electric field is a region of space in which a charged particle feels an electric force.$mq$, $mq$easy$mq$),
($mq$In which direction do electric field lines point?$mq$, $mq$["From negative to positive","Always to the right","In a circle around the charge","From positive to negative"]$mq$, 3, $mq$By convention, field lines show the direction of the force on a small positive charge, so they go from positive to negative.$mq$, $mq$easy$mq$),
($mq$Which diagram shows the field around a single positive point charge?$mq$, $mq$["Straight lines pointing radially inwards","Parallel lines","Straight lines pointing radially outwards","Closed loops"]$mq$, 2, $mq$The force on a positive test charge near a positive charge is repulsion, so the lines point away from it in all directions.$mq$, $mq$easy$mq$),
($mq$What does it mean if electric field lines are closer together?$mq$, $mq$["The field is weaker","The field is stronger","The field is zero","The charge is negative"]$mq$, 1, $mq$Closer field lines show a stronger field, where the force on a charge is larger.$mq$, $mq$easy$mq$),
($mq$What type of field is found between two parallel charged metal plates?$mq$, $mq$["A uniform field","A radial field","No field","A magnetic field"]$mq$, 0, $mq$Between parallel plates the field lines are parallel and equally spaced, so the field strength is the same everywhere.$mq$, $mq$easy$mq$),
($mq$A small positive charge is placed in a uniform field pointing to the right. In which direction is the force on it?$mq$, $mq$["To the left","Upwards","There is no force","To the right"]$mq$, 3, $mq$The force on a positive charge is in the same direction as the field. On a negative charge it would be opposite.$mq$, $mq$medium$mq$),
($mq$An electron enters a uniform field between two plates, the top plate positive and the bottom plate negative. Which way is it deflected?$mq$, $mq$["Towards the negative (bottom) plate","It moves in a straight line","Towards the positive (top) plate","In a circle"]$mq$, 2, $mq$Electrons are negative, so they are attracted to the positive plate and repelled from the negative plate.$mq$, $mq$medium$mq$),
($mq$A charge of 3.0 × 10⁻⁶ C experiences a force of 0.60 N in an electric field. What is the electric field strength? (E = F ÷ Q)$mq$, $mq$["1.8 × 10⁻⁶ N/C","2.0 × 10⁵ N/C","5.0 × 10⁻⁶ N/C","0.60 N/C"]$mq$, 1, $mq$E = F ÷ Q = 0.60 ÷ 3.0 × 10⁻⁶ = 2.0 × 10⁵ N/C.$mq$, $mq$medium$mq$),
($mq$A uniform field has a strength of 4000 N/C. What force acts on a charge of 2.0 × 10⁻⁹ C? (F = Q × E)$mq$, $mq$["8.0 × 10⁻⁶ N","2.0 × 10⁶ N","5.0 × 10¹¹ N","8.0 × 10⁻¹² N"]$mq$, 0, $mq$F = Q × E = 2.0 × 10⁻⁹ × 4000 = 8.0 × 10⁻⁶ N.$mq$, $mq$medium$mq$),
($mq$Two parallel plates are 0.040 m apart with a potential difference of 200 V between them. What is the field strength? (E = V ÷ d)$mq$, $mq$["8.0 V/m","0.20 V/m","8000 V/m","5000 V/m"]$mq$, 3, $mq$E = V ÷ d = 200 ÷ 0.040 = 5000 V/m.$mq$, $mq$medium$mq$),
($mq$How does the field pattern between a positive and a negative point charge look?$mq$, $mq$["Lines run away from both","Lines are straight and parallel everywhere","Lines curve from the positive charge to the negative charge","Lines form circles around both"]$mq$, 2, $mq$Field lines start on the positive and end on the negative, curving between them.$mq$, $mq$medium$mq$),
($mq$Why do field lines never cross?$mq$, $mq$["Charges cannot be near each other","The field has only one direction at each point","Lines would become hot","They are made of electrons"]$mq$, 1, $mq$If lines crossed there would be two directions of force at the same point, which is impossible.$mq$, $mq$medium$mq$),
($mq$In a cathode-ray style tube, an electron beam passes between plates and bends towards the top plate. Which statement is correct?$mq$, $mq$["The top plate is positive","The top plate is negative","The plates are not charged","The field points upwards on electrons"]$mq$, 0, $mq$Electrons are attracted to positive charge, so the top plate must be positive.$mq$, $mq$medium$mq$),
($mq$The plates in a uniform field are 0.030 m apart and the field strength is 3.0 × 10⁵ V/m. What is the potential difference across the plates?$mq$, $mq$["1.0 × 10⁷ V","9.0 × 10⁻⁶ V","90 V","9000 V"]$mq$, 3, $mq$V = E × d = 3.0 × 10⁵ × 0.030 = 9000 V.$mq$, $mq$hard$mq$),
($mq$A dust particle with a charge of +6.0 nC is held at rest between horizontal plates by an upward electric force. Its weight is 1.2 × 10⁻⁶ N. What field strength is needed?$mq$, $mq$["7.2 × 10⁻¹⁵ N/C","2.0 × 10⁻³ N/C","2.0 × 10² N/C","5.0 × 10⁻³ N/C"]$mq$, 2, $mq$The electric force must equal the weight: E = F ÷ Q = 1.2 × 10⁻⁶ ÷ 6.0 × 10⁻⁹ = 200 N/C.$mq$, $mq$hard$mq$),
($mq$An alpha particle (positive) and an electron fly into the same uniform field at right angles to it. Which statement is correct?$mq$, $mq$["They are deflected in the same direction","They are deflected in opposite directions","Neither is deflected","Only the electron is deflected"]$mq$, 1, $mq$The force on a positive charge is along the field and on a negative charge is opposite, so they curve in opposite directions.$mq$, $mq$hard$mq$),
($mq$In the gold foil experiment, alpha particles were scattered by gold nuclei. Which electric field idea best explains why a few were scattered by large angles?$mq$, $mq$["A strong field close to a small positive nucleus repels the alpha particles","A uniform field exists across the whole foil","The field of the electrons attracts them","Gold has no electric field"]$mq$, 0, $mq$The field of a point charge is strongest very close to it. An alpha particle heading almost directly at the nucleus is strongly repelled.$mq$, $mq$hard$mq$),
($mq$A student argues: 'If the plates are moved closer together with the same potential difference, the field strength between them decreases.' Which evaluation is correct?$mq$, $mq$["Correct: smaller d gives a larger field, which means weaker","Correct: E is independent of d","Incorrect: the field becomes zero","Incorrect: E = V ÷ d, so smaller d gives a larger field"]$mq$, 3, $mq$With the same V, E = V ÷ d increases as the distance decreases. The field lines become more concentrated.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Electric Fields$mq$ and p.name = $mq$Static Electricity and Fields$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Electric field$mq$, $mq$A region of space where a charged particle experiences a force.$mq$),
($mq$Direction of field lines$mq$, $mq$The direction of the force on a positive charge: from positive to negative.$mq$),
($mq$Field around a positive point charge$mq$, $mq$Straight lines pointing radially outwards. Lines point inwards for a negative charge.$mq$),
($mq$Uniform field$mq$, $mq$Parallel, equally spaced lines, as between two oppositely charged parallel plates. Same strength everywhere.$mq$),
($mq$What do close field lines mean?$mq$, $mq$A stronger field.$mq$),
($mq$Force on charges in a field$mq$, $mq$Positive charges are pushed along the field direction, negative charges (such as electrons) opposite to it.$mq$),
($mq$Field strength formulas$mq$, $mq$E = F ÷ Q (N/C), and in a uniform field E = V ÷ d (V/m).$mq$),
($mq$Effect of closer plates$mq$, $mq$With the same potential difference, a smaller separation d gives a greater field strength E = V ÷ d.$mq$),
($mq$Why do field lines never cross?$mq$, $mq$The field has only one direction at each point, so lines cannot cross.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Electric Fields$mq$ and p.name = $mq$Static Electricity and Fields$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is an electric field?
An **electric field** is a region where a charged object experiences a force. Charged objects create fields around them. You cannot see a field, but you can represent it using **field lines**.

## Drawing field lines
- Lines show the direction of the force on a small **positive** test charge.
- They start on positive charges and end on negative charges.
- They never cross.
- The closer together the lines are, the stronger the field.
The main patterns are:
- **A single positive point charge**: lines point radially outwards. For a negative point charge they point radially inwards.
- **Two opposite charges**: lines curve from the positive to the negative charge.
- **Two parallel charged plates**: straight, parallel, equally spaced lines between the plates give a **uniform field**, with the same strength everywhere in the gap. Near the edges the lines bend outwards.

## Forces on charges in a field
A positive charge is pushed **along** the field direction. A negative charge, such as an electron, is pushed **against** it. In a uniform field the force is constant, so a charged particle moving across the field is deflected along a curved path, like a ball thrown through gravity. An electron beam passing between a positive top plate and a negative bottom plate is bent upwards, towards the positive plate.

## Field strength
**Electric field strength** E is the force on each unit of charge: **E = F ÷ Q**, in newtons per coulomb (N/C). Rearranged, F = Q × E.
Worked example: a charge of 2.0 × 10⁻⁹ C in a 4000 N/C field feels a force of 2.0 × 10⁻⁹ × 4000 = 8.0 × 10⁻⁶ N.
For a uniform field between plates, **E = V ÷ d**, where V is the potential difference across the plates and d is their separation, in volts per metre (V/m). Worked example: 200 V across plates 0.040 m apart gives E = 200 ÷ 0.040 = 5000 V/m. Moving the plates closer together with the same voltage makes the field stronger.

## Balancing forces
A charged droplet can hang still between horizontal plates if the electric force upwards equals its weight. Then Q × E = m × g. Using E = F ÷ Q, a weight of 1.2 × 10⁻⁶ N on a charge of 6.0 × 10⁻⁹ C needs E = 200 N/C.

## Applications
- Electron beams in older display tubes and oscilloscopes are deflected by electric fields.
- Photocopiers, ink-jet printers and paint sprayers control charged droplets with fields.
- The Rutherford scattering experiment: the strong field close to the nucleus repelled alpha particles that came near.

## Common mistakes
- Drawing field arrows into a positive charge. Lines leave positive charges.
- Forgetting that electrons move opposite to the field lines.
- Using centimetres without converting to metres in E = V ÷ d.
- Thinking a closer plate separation weakens the field.

## How this is examined
Look for a diagram of plates or point charges where you sketch the field or deflection of a particle, calculations using E = F ÷ Q or E = V ÷ d, and a context such as a printer or air purifier where you explain how a field acts on charged particles. Criterion B tasks might ask you to plan how to investigate how the force on a charged sphere depends on the plate voltage.

Exam tip: For any particle in a field, first state its charge sign, then say whether the force is with or against the field direction, and then describe the direction of deflection.$mq$ from st;

-- Generating and Transmitting Electricity > AC, DC and Power Generation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Generating and Transmitting Electricity$mq$, 5, 5 from public.subjects s where s.slug = $mq$physics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$AC, DC and Power Generation$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physics$mq$ and p.grade = 5 and p.name = $mq$Generating and Transmitting Electricity$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$AC, DC and Power Generation$mq$ and p.name = $mq$Generating and Transmitting Electricity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is direct current (DC)?$mq$, $mq$["Current that flows in one direction only","Current that changes direction regularly","Current that has no voltage","Current that only flows in wires"]$mq$, 0, $mq$DC flows in one direction. Batteries and solar cells supply DC.$mq$, $mq$easy$mq$),
($mq$What is the frequency of the UK mains supply?$mq$, $mq$["230 Hz","100 Hz","12 Hz","50 Hz"]$mq$, 3, $mq$UK mains is about 230 V at 50 Hz, meaning 50 complete cycles each second.$mq$, $mq$easy$mq$),
($mq$What does a generator do?$mq$, $mq$["Transfers electrical energy into kinetic energy","Stores electrical energy","Transfers kinetic energy into electrical energy","Changes AC to DC only"]$mq$, 2, $mq$A generator is turned by a turbine or other source, and the movement induces a voltage.$mq$, $mq$easy$mq$),
($mq$Which of these is a renewable energy resource?$mq$, $mq$["Coal","Wind","Natural gas","Uranium"]$mq$, 1, $mq$Wind, solar, hydroelectric, tidal, geothermal and biomass can be replaced naturally. Coal, gas and uranium are limited.$mq$, $mq$easy$mq$),
($mq$What is electromagnetic induction?$mq$, $mq$["A voltage produced when a conductor moves in a magnetic field","A magnet moving through a vacuum","A current making a wire hot","A battery being charged"]$mq$, 0, $mq$A changing magnetic field through a coil induces an electromotive force (voltage).$mq$, $mq$easy$mq$),
($mq$On an oscilloscope screen, one complete cycle of a mains-style signal covers 4.0 divisions and the time base is 5.0 ms per division. What is the frequency?$mq$, $mq$["20 Hz","5.0 Hz","0.020 Hz","50 Hz"]$mq$, 3, $mq$Period = 4.0 × 5.0 = 20 ms = 0.020 s. Frequency = 1 ÷ 0.020 = 50 Hz.$mq$, $mq$medium$mq$),
($mq$An oscilloscope is set to 2.0 V per division. The peak of an AC trace is 3.0 divisions above the centre line. What is the peak voltage?$mq$, $mq$["1.5 V","3.0 V","6.0 V","12 V"]$mq$, 2, $mq$Peak voltage = 3.0 divisions × 2.0 V per division = 6.0 V.$mq$, $mq$medium$mq$),
($mq$Which change would increase the voltage from a simple generator?$mq$, $mq$["Rotate the coil more slowly","Rotate the coil faster","Use a weaker magnet","Use fewer turns on the coil"]$mq$, 1, $mq$A faster rotation, a stronger magnet, more turns or a larger coil area all increase the induced voltage.$mq$, $mq$medium$mq$),
($mq$What happens to the frequency of the output of a simple AC generator if the coil is rotated twice as fast?$mq$, $mq$["It doubles","It halves","It stays the same","It becomes DC"]$mq$, 0, $mq$One cycle is produced per rotation, so turning twice as fast gives twice as many cycles each second.$mq$, $mq$medium$mq$),
($mq$A wind turbine produces 2000 kW. How much energy does it supply in 3.0 hours?$mq$, $mq$["667 kWh","600 kWh","2003 kWh","6000 kWh"]$mq$, 3, $mq$Energy = power × time = 2000 kW × 3.0 h = 6000 kWh.$mq$, $mq$medium$mq$),
($mq$A power station burns coal. Chemical energy in the coal is transferred to the generator in several stages. Which sequence is correct?$mq$, $mq$["Chemical, kinetic, thermal, electrical","Thermal, chemical, electrical, kinetic","Chemical, thermal, kinetic, electrical","Chemical, electrical, thermal, kinetic"]$mq$, 2, $mq$Fuel burning heats water to steam, the steam turns the turbine, and the turbine turns the generator.$mq$, $mq$medium$mq$),
($mq$Which is an advantage of solar cells over a coal power station?$mq$, $mq$["They work equally well at night","No greenhouse gases are produced during operation","They have a constant output","They produce AC directly"]$mq$, 1, $mq$Solar cells emit no carbon dioxide while operating, but output depends on sunlight and they produce DC.$mq$, $mq$medium$mq$),
($mq$Which statement describes alternating current?$mq$, $mq$["The direction of the current changes repeatedly","The current is constant","The voltage is always zero","The current flows through a battery only"]$mq$, 0, $mq$In AC the current reverses direction many times per second, 50 times each second in the UK mains.$mq$, $mq$medium$mq$),
($mq$A power station receives 400 MJ of energy from burning fuel in a given time and delivers 120 MJ of electrical energy. What is its efficiency?$mq$, $mq$["70%","3.3%","33%","30%"]$mq$, 3, $mq$Efficiency = useful output ÷ input = 120 ÷ 400 = 0.30 = 30%.$mq$, $mq$hard$mq$),
($mq$A UK household appliance is rated 13 A at 230 V. What is its power?$mq$, $mq$["17.7 W","243 W","2990 W","2.99 W"]$mq$, 2, $mq$P = V × I = 230 × 13 = 2990 W, about 3.0 kW.$mq$, $mq$hard$mq$),
($mq$A student claims that the mains supply of 230 V means the voltage is always 230 V. Which evaluation is best?$mq$, $mq$["Correct: mains voltage is a constant 230 V","Incorrect: the voltage alternates, and 230 V is an effective value, with a peak around 325 V","Incorrect: mains is a DC supply","Correct: voltage is zero for the whole cycle"]$mq$, 1, $mq$The voltage of AC varies between positive and negative peaks. The quoted value is the equivalent steady DC value for heating, about the peak ÷ √2.$mq$, $mq$hard$mq$),
($mq$A community considers replacing a coal power station with a wind farm. Which evaluation is best?$mq$, $mq$["Wind lowers emissions but depends on weather, so storage or backup is needed","Wind is always better because it gives constant output","Coal is better because it produces no waste","Wind is not renewable"]$mq$, 0, $mq$A good evaluation considers benefits (low operating emissions), limits (variable output, land use, visual impact) and a judgement.$mq$, $mq$hard$mq$),
($mq$Two generators are identical except Generator Q has a coil with twice as many turns. Both are turned at the same speed. What is true?$mq$, $mq$["Q produces the same voltage at twice the frequency","Q produces half the voltage","Q produces DC","Q produces twice the peak voltage at the same frequency"]$mq$, 3, $mq$More turns increase the induced voltage in proportion. Frequency depends on the rotation speed, which is unchanged.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$AC, DC and Power Generation$mq$ and p.name = $mq$Generating and Transmitting Electricity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Direct current (DC)$mq$, $mq$Current in one direction only, such as from a battery or solar cell.$mq$),
($mq$Alternating current (AC)$mq$, $mq$Current that reverses direction repeatedly. UK mains is 230 V and 50 Hz.$mq$),
($mq$Electromagnetic induction$mq$, $mq$A voltage is induced in a conductor when it moves in a magnetic field or when the magnetic field through a coil changes.$mq$),
($mq$Ways to increase generator voltage$mq$, $mq$Spin the coil faster, use a stronger magnet, more turns on the coil, or a larger coil.$mq$),
($mq$Frequency from an oscilloscope$mq$, $mq$Period = divisions per cycle × time base. Frequency = 1 ÷ period.$mq$),
($mq$Energy chain in a coal power station$mq$, $mq$Chemical → thermal → kinetic → electrical.$mq$),
($mq$Renewable resource examples$mq$, $mq$Wind, solar, hydroelectric, tidal, geothermal and biomass.$mq$),
($mq$Efficiency$mq$, $mq$Useful output energy ÷ total input energy × 100%.$mq$),
($mq$Power and energy equations$mq$, $mq$P = V × I and E = P × t.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$AC, DC and Power Generation$mq$ and p.name = $mq$Generating and Transmitting Electricity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Direct and alternating current
- **Direct current (DC)** flows in one direction only. Cells, batteries and solar cells provide DC.
- **Alternating current (AC)** changes direction repeatedly. Mains electricity is AC. In the UK it is 230 V and 50 Hz, meaning the current reverses 50 complete cycles every second.
On an oscilloscope, DC appears as a flat horizontal line, and AC as a wave (sine curve). To read a trace:
- **Peak voltage** = number of divisions above the centre line × volts per division.
- **Period** = number of divisions for one complete wave × time per division. Frequency = 1 ÷ period.
Worked example: one cycle covers 4.0 divisions at 5.0 ms per division. Period = 20 ms = 0.020 s, so frequency = 50 Hz. A peak 3.0 divisions high at 2.0 V per division gives 6.0 V.
The quoted mains voltage (230 V) is an effective value, which has the same heating effect as a steady 230 V DC. The actual peak is about 325 V.

## Electromagnetic induction
When a conductor cuts through magnetic field lines, or the magnetic field through a coil changes, a voltage is **induced**. If the circuit is complete, a current flows. This is the principle of the generator.

## The AC generator
A simple generator has a coil of wire that rotates in a magnetic field. As the coil turns, the field through it keeps changing, so an alternating voltage is induced. You can increase the output voltage by:
- rotating the coil faster (this also raises the frequency);
- using a stronger magnet;
- adding more turns to the coil;
- using a coil with a larger area.
Rotating the coil twice as fast doubles the frequency and raises the peak voltage. Doubling the turns doubles the peak voltage but leaves the frequency unchanged.

## Power stations
In most power stations an energy source turns a **turbine**, and the turbine turns a **generator**.
- Fossil fuel and biomass: burning heats water into steam which spins the turbine. Chemical energy → thermal → kinetic → electrical. Fossil fuels release carbon dioxide.
- Nuclear: fission in the reactor produces heat to make steam. No carbon dioxide during operation, but radioactive waste must be stored safely.
- Hydroelectric, wind and tidal: moving water or air turns the turbine directly. Renewable, with no fuel needed, but depend on location and weather.
- Solar cells: transfer light directly to electrical energy as DC. They need sunlight.
Efficiency = useful output ÷ total input × 100%. If a power station uses 400 MJ and delivers 120 MJ, efficiency = 30%.

## Power and energy
P = V × I, and E = P × t. A 13 A appliance at 230 V uses 2990 W. A 2000 kW wind turbine running for 3.0 h supplies 6000 kWh.

## Common mistakes
- Saying the mains voltage is constant at 230 V.
- Confusing the oscilloscope vertical scale (voltage) with its horizontal scale (time).
- Stating that a faster coil changes the voltage only. Frequency also rises.

## How this is examined
Typical items include an oscilloscope trace to interpret, an explanation of how to increase generator output, a comparison of power station types, and an evaluation task asking whether a region should invest in renewable energy, considering cost, reliability and environment (criterion D).

Exam tip: When comparing energy resources, give at least one advantage and one limitation for each, then finish with a judgement linked to the situation described.$mq$ from st;

-- Generating and Transmitting Electricity > Transmission and the National Grid
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Generating and Transmitting Electricity$mq$, 5, 5 from public.subjects s where s.slug = $mq$physics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Transmission and the National Grid$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physics$mq$ and p.grade = 5 and p.name = $mq$Generating and Transmitting Electricity$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Transmission and the National Grid$mq$ and p.name = $mq$Generating and Transmitting Electricity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the National Grid?$mq$, $mq$["The network of cables and transformers that distributes electricity","A battery bank","A type of power station","A wind farm"]$mq$, 0, $mq$The National Grid links power stations to homes and industry.$mq$, $mq$easy$mq$),
($mq$Which device changes the size of an AC voltage?$mq$, $mq$["Generator","Resistor","Switch","Transformer"]$mq$, 3, $mq$A transformer steps an AC voltage up or down. It needs a changing current to work.$mq$, $mq$easy$mq$),
($mq$Why are high voltages used to transmit electricity over long distances?$mq$, $mq$["To make the current larger","To make the wires cold","To reduce energy lost as heat in the cables","To increase the frequency"]$mq$, 2, $mq$A higher voltage means a lower current for the same power, so less heat is lost.$mq$, $mq$easy$mq$),
($mq$What does a step-down transformer do?$mq$, $mq$["Increases the voltage","Decreases the voltage","Changes AC into DC","Increases the frequency"]$mq$, 1, $mq$A step-down transformer has fewer turns on the secondary coil than the primary coil, so output voltage is lower.$mq$, $mq$easy$mq$),
($mq$A transformer works only with which type of supply?$mq$, $mq$["AC","DC","Either AC or DC","Neither"]$mq$, 0, $mq$The changing magnetic field needed for induction is produced only by alternating current.$mq$, $mq$easy$mq$),
($mq$A power station delivers 50 MW. If the power is sent at 400 kV, what is the current? (I = P ÷ V)$mq$, $mq$["8000 A","2000 A","0.008 A","125 A"]$mq$, 3, $mq$I = 50 × 10⁶ ÷ 400 × 10³ = 125 A.$mq$, $mq$medium$mq$),
($mq$The same 50 MW is sent at 25 kV instead. What is the current?$mq$, $mq$["125 A","1250 A","2000 A","0.5 A"]$mq$, 2, $mq$I = 50 × 10⁶ ÷ 25 × 10³ = 2000 A. A lower voltage requires a much larger current.$mq$, $mq$medium$mq$),
($mq$A transformer has 200 turns on the primary coil and 1000 turns on the secondary. The primary voltage is 230 V. What is the secondary voltage? (Vp ÷ Vs = Np ÷ Ns)$mq$, $mq$["46 V","1150 V","230 V","5750 V"]$mq$, 1, $mq$Vs = Vp × Ns ÷ Np = 230 × 1000 ÷ 200 = 1150 V. It is a step-up transformer.$mq$, $mq$medium$mq$),
($mq$A step-down transformer converts 12 000 V to 240 V. The primary coil has 2400 turns. How many turns does the secondary have?$mq$, $mq$["48","120","12 000","2400"]$mq$, 0, $mq$Ns = Np × Vs ÷ Vp = 2400 × 240 ÷ 12 000 = 48 turns.$mq$, $mq$medium$mq$),
($mq$Why are step-down transformers used near homes?$mq$, $mq$["To increase the current in the cables","To produce DC","To raise the voltage","To reduce the voltage to a safe level for use"]$mq$, 3, $mq$The grid carries hundreds of thousands of volts, which must be reduced to 230 V for safe use.$mq$, $mq$medium$mq$),
($mq$The power lost as heat in a cable is given by P = I² × R. What happens to the power loss if the current is halved, with the resistance unchanged?$mq$, $mq$["It halves","It doubles","It falls to one quarter","It stays the same"]$mq$, 2, $mq$Power loss depends on I². Halving the current gives (1/2)² = 1/4 of the loss.$mq$, $mq$medium$mq$),
($mq$Which is a disadvantage of overhead power lines compared with underground cables?$mq$, $mq$["They are much more expensive to build","They affect the landscape and can be damaged by weather","They cannot carry AC","They lose more energy because they are cold"]$mq$, 1, $mq$Overhead lines are cheaper and easier to repair, but they change the appearance of the landscape and can be damaged by storms.$mq$, $mq$medium$mq$),
($mq$In an ideal transformer, the secondary supplies 12 V at 2.0 A. What current flows in the primary connected to 230 V?$mq$, $mq$["0.10 A","2.0 A","38 A","0.50 A"]$mq$, 0, $mq$Power out = 12 × 2.0 = 24 W. For an ideal transformer, power in = power out, so I = 24 ÷ 230 ≈ 0.10 A.$mq$, $mq$medium$mq$),
($mq$Each cable in the grid has a resistance of 10 Ω. 50 MW is transmitted at 400 kV (current 125 A). What is the power lost as heat? (P = I² × R)$mq$, $mq$["1.25 × 10³ W","4.0 × 10⁷ W","1.6 × 10⁶ W","1.6 × 10⁵ W"]$mq$, 3, $mq$P = 125² × 10 = 15 625 × 10 = 156 250 W, which is about 1.6 × 10⁵ W (0.16 MW).$mq$, $mq$hard$mq$),
($mq$For the same line and power, the current is 2000 A when 50 MW is sent at 25 kV. What is the power lost in a 10 Ω cable, and what does it show?$mq$, $mq$["4.0 × 10⁴ W, a small loss","2.0 × 10⁴ W, a small loss","4.0 × 10⁷ W, almost all of the power would be lost","4.0 × 10⁷ W, no loss"]$mq$, 2, $mq$P = 2000² × 10 = 4.0 × 10⁷ W = 40 MW, which is 80% of the 50 MW. High voltage is vital.$mq$, $mq$hard$mq$),
($mq$A student says: 'A step-up transformer increases the energy, because it increases the voltage.' Which evaluation is best?$mq$, $mq$["Correct: energy is created by the extra coil turns","Incorrect: the voltage rises but the current falls, so power stays about the same","Correct: the output current also rises","Incorrect: transformers decrease voltage only"]$mq$, 1, $mq$Power = V × I. In an ideal transformer, power in equals power out, so raising the voltage lowers the current. A real transformer loses a little as heat.$mq$, $mq$hard$mq$),
($mq$A transformer has input power 100 W and output power 90 W. What is its efficiency and what is the most likely reason for the loss?$mq$, $mq$["90%, energy lost as heat in the coils and core","90%, energy lost as sound only","10%, energy lost as gamma rays","110%, extra energy added by the core"]$mq$, 0, $mq$Efficiency = 90 ÷ 100 = 90%. Heating of the coils (resistance) and the core (changing magnetic field) explains most of the loss.$mq$, $mq$hard$mq$),
($mq$A region needs 500 MW delivered at the lowest cost for energy lost. Which choice of transmission is best, ignoring construction costs?$mq$, $mq$["Transmit at 230 V with thin cables","Transmit as DC from the generator at 12 V","Transmit at low voltage with the largest current","Step up to 400 kV with thick, low-resistance cables"]$mq$, 3, $mq$Higher voltage means lower current, and low-resistance cables give low I²R losses. The cost of thicker cables and pylons should also be weighed.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Transmission and the National Grid$mq$ and p.name = $mq$Generating and Transmitting Electricity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$National Grid$mq$, $mq$The network of power lines, pylons, substations and transformers that carries electricity from power stations to consumers.$mq$),
($mq$Why transmit at high voltage?$mq$, $mq$High voltage means low current for the same power, so there is much less heat loss in the cables.$mq$),
($mq$Power loss in a cable$mq$, $mq$P = I² × R. Halving the current cuts the loss to one quarter.$mq$),
($mq$Power equation$mq$, $mq$P = V × I, so I = P ÷ V.$mq$),
($mq$Transformer$mq$, $mq$Device with a primary coil, secondary coil and iron core that changes an AC voltage. It does not work with DC.$mq$),
($mq$Transformer equation$mq$, $mq$Vp ÷ Vs = Np ÷ Ns (voltages and turns on primary and secondary coils).$mq$),
($mq$Step-up vs step-down$mq$, $mq$Step-up: secondary has more turns, voltage increases. Step-down: secondary has fewer turns, voltage decreases.$mq$),
($mq$Ideal transformer power$mq$, $mq$Power in = power out, so Vp × Ip = Vs × Is. A step-up transformer raises voltage and lowers current.$mq$),
($mq$Overhead vs underground cables$mq$, $mq$Overhead: cheaper and easier to repair but affects landscape and weather exposed. Underground: hidden and protected but much more expensive.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Transmission and the National Grid$mq$ and p.name = $mq$Generating and Transmitting Electricity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why electricity needs a grid
Power stations are often far from the towns that use the electricity. The **National Grid** is the network of cables, pylons, substations and transformers that transmits electrical energy from power stations to homes, offices and factories. The challenge is to deliver the energy while wasting as little as possible as heat in the cables.

## Power and losses in cables
Power = voltage × current (P = V × I). To send a fixed power, a higher voltage means a lower current. For example, sending 50 MW:
- at 25 kV needs I = 50 × 10⁶ ÷ 25 × 10³ = 2000 A;
- at 400 kV needs I = 50 × 10⁶ ÷ 400 × 10³ = 125 A.
Cables heat up as the current passes through their resistance. The power lost is **P = I² × R**. If the cable resistance is 10 Ω:
- at 2000 A, the loss is 2000² × 10 = 4.0 × 10⁷ W (40 MW), which is 80% of the power sent;
- at 125 A, the loss is 125² × 10 = 156 250 W (about 0.16 MW), only 0.3% of the power.
Halving the current cuts the loss to a quarter. So electricity is transmitted at very high voltages, up to 400 kV in the UK.

## Transformers
A **transformer** changes the voltage of an alternating supply. It has a primary coil and a secondary coil wound on an iron core. An alternating current in the primary creates a changing magnetic field in the core, which induces an alternating voltage in the secondary. It does not work with DC, because the field would not change.
**Vp ÷ Vs = Np ÷ Ns**
- **Step-up** transformer: more turns on the secondary, higher voltage. Used at the power station.
- **Step-down** transformer: fewer turns on the secondary, lower voltage. Used near towns, then again in local substations to reach 230 V.
Worked example: a primary has 200 turns at 230 V and the secondary has 1000 turns. Vs = 230 × 1000 ÷ 200 = 1150 V.
For an ideal transformer, power in = power out, so Vp × Ip = Vs × Is. A 12 V, 2.0 A secondary delivers 24 W, so a 230 V primary carries 24 ÷ 230 ≈ 0.10 A. A step-up transformer raises voltage but lowers current. It does not create energy. Real transformers are about 90% to 99% efficient because of heating in the coils and core.

## The journey of electricity
Generator (about 25 kV) → step-up transformer (to 400 kV) → pylons or cables → step-down transformers at substations (to 33 kV, then 11 kV) → local transformer (to 230 V) → homes.

## Overhead or underground?
Overhead lines are cheaper and easier to repair, but affect the landscape, can be damaged in storms and may affect wildlife. Underground cables are less visible and protected from weather, but cost much more and are harder to repair.

## Common mistakes
- Saying that a step-up transformer increases power. It increases voltage, and current falls.
- Using the wrong way round in Vp ÷ Vs = Np ÷ Ns.
- Forgetting that P = I² × R needs the current squared.

## How this is examined
You might be given grid data, such as power, voltage and cable resistance, and be asked to calculate the current and power loss at two voltages, then explain which is better. Criterion D questions may ask you to evaluate overhead cables against underground cables for a new wind farm.

Exam tip: To explain high-voltage transmission, use the chain: high voltage → low current → smaller I²R heating → less energy wasted.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('physics')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;