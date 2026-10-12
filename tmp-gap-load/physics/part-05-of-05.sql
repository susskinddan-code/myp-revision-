-- Part 5 of 5: 1 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Heat and Temperature > Evaporation, Condensation and Boiling
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Heat and Temperature$mq$, 5, 6 from public.subjects s where s.slug = $mq$physics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Evaporation, Condensation and Boiling$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physics$mq$ and p.grade = 5 and p.name = $mq$Heat and Temperature$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Evaporation, Condensation and Boiling$mq$ and p.name = $mq$Heat and Temperature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is evaporation?$mq$, $mq$["Particles escaping from the surface of a liquid to become a gas","A liquid boiling throughout","A gas turning into a liquid","A solid turning into a gas"]$mq$, 0, $mq$Evaporation happens only at the liquid surface, at temperatures below the boiling point.$mq$, $mq$easy$mq$),
($mq$At what temperature does pure water boil at normal atmospheric pressure at sea level?$mq$, $mq$["0 °C","50 °C","212 °C","100 °C"]$mq$, 3, $mq$Water boils at 100 °C at standard pressure. 212 is the value in °F.$mq$, $mq$easy$mq$),
($mq$What is condensation?$mq$, $mq$["A liquid changing into a gas","A liquid changing into a solid","A gas changing into a liquid","A solid changing into a liquid"]$mq$, 2, $mq$When a gas cools, its particles slow down and clump together, forming a liquid.$mq$, $mq$easy$mq$),
($mq$Why does a bathroom mirror become misty after a hot shower?$mq$, $mq$["The mirror absorbs water","Water vapour condenses on the cold mirror","Steam freezes on the mirror","The mirror gets hotter than the air"]$mq$, 1, $mq$Warm, moist air cools on the cold mirror and the vapour condenses into tiny water droplets.$mq$, $mq$easy$mq$),
($mq$Which change of state needs energy to be supplied?$mq$, $mq$["Liquid to gas","Gas to liquid","Liquid to solid","Gas to solid"]$mq$, 0, $mq$Particles must gain energy to overcome forces between them, so boiling and evaporation need energy.$mq$, $mq$easy$mq$),
($mq$Which statement correctly describes how evaporation differs from boiling?$mq$, $mq$["Evaporation occurs throughout the liquid, boiling only at the surface","Evaporation needs a heater, boiling does not","Boiling occurs at any temperature","Evaporation occurs only at the surface at any temperature, boiling occurs throughout the liquid at the boiling point"]$mq$, 3, $mq$Boiling forms bubbles of vapour inside the liquid at a fixed temperature. Evaporation is a slower surface process.$mq$, $mq$medium$mq$),
($mq$Why does evaporation cool the liquid left behind?$mq$, $mq$["The particles that escape are the slowest","Evaporation adds energy to the liquid","The fastest, most energetic particles escape, lowering the average kinetic energy","The liquid gains more particles"]$mq$, 2, $mq$Only particles with enough energy break away from the surface, so the average energy of the remaining particles falls.$mq$, $mq$medium$mq$),
($mq$Which change would increase the rate of evaporation from a puddle?$mq$, $mq$["Cooler air","A windy day","Higher humidity","Smaller surface area"]$mq$, 1, $mq$Wind removes vapour from above the surface so more particles escape. Higher temperature, larger surface area and drier air also speed it up.$mq$, $mq$medium$mq$),
($mq$Wet clothes dry faster when hung on a washing line on a warm, dry, windy day. Which factors explain this?$mq$, $mq$["Higher temperature, low humidity and moving air","Cold temperature, high humidity and still air","Only higher temperature","Only lower humidity"]$mq$, 0, $mq$Warm particles move faster, dry air can take up more vapour and wind carries it away.$mq$, $mq$medium$mq$),
($mq$On a high mountain, water boils at a lower temperature than 100 °C. Why?$mq$, $mq$["The air is warmer","The water has more dissolved salt","Gravity is stronger","The atmospheric pressure is lower"]$mq$, 3, $mq$Boiling occurs when the vapour pressure equals the pressure of the surroundings. At altitude the air pressure is lower, so water boils at a lower temperature.$mq$, $mq$medium$mq$),
($mq$A heater supplies energy to water at its boiling point. What happens to the temperature while it boils?$mq$, $mq$["It keeps rising","It falls","It stays constant","It rises then falls"]$mq$, 2, $mq$The energy supplied goes into separating the particles (changing state), not into raising the temperature.$mq$, $mq$medium$mq$),
($mq$Where does the energy come from when steam condenses on a cold surface?$mq$, $mq$["The cold surface creates it","The steam releases it as its particles move closer together","From the surface evaporating","No energy is released"]$mq$, 1, $mq$Condensation releases the latent heat of vaporisation, which is why steam burns are severe.$mq$, $mq$medium$mq$),
($mq$Water has a specific latent heat of vaporisation of 2.26 × 10⁶ J/kg. How much energy is needed to boil 0.50 kg of water already at 100 °C? (Q = m × L)$mq$, $mq$["1.13 × 10⁶ J","4.52 × 10⁶ J","2.26 × 10⁶ J","1.13 × 10³ J"]$mq$, 0, $mq$Q = 0.50 × 2.26 × 10⁶ = 1.13 × 10⁶ J.$mq$, $mq$medium$mq$),
($mq$A 2000 W heater is used to boil 0.50 kg of water at 100 °C. All its energy goes into the water. How long does it take? (L = 2.26 × 10⁶ J/kg)$mq$, $mq$["1130 s","0.57 s","4520 s","565 s"]$mq$, 3, $mq$Energy = 1.13 × 10⁶ J. Time = energy ÷ power = 1.13 × 10⁶ ÷ 2000 = 565 s.$mq$, $mq$hard$mq$),
($mq$How much energy is released when 0.050 kg of steam at 100 °C condenses to water at 100 °C? (L = 2.26 × 10⁶ J/kg)$mq$, $mq$["4.52 × 10⁷ J","1.13 × 10⁶ J","1.13 × 10⁵ J","2.26 × 10⁵ J"]$mq$, 2, $mq$Q = 0.050 × 2.26 × 10⁶ = 1.13 × 10⁵ J, released to the surroundings.$mq$, $mq$hard$mq$),
($mq$A kettle with a 2000 W element is left on for 300 s after boiling begins. Assuming all the energy boils water already at 100 °C, which mass turns to steam? (L = 2.26 × 10⁶ J/kg)$mq$, $mq$["3.8 kg","0.27 kg","0.0027 kg","2.7 kg"]$mq$, 1, $mq$Energy = 2000 × 300 = 6.0 × 10⁵ J. Mass = 6.0 × 10⁵ ÷ 2.26 × 10⁶ ≈ 0.27 kg.$mq$, $mq$hard$mq$),
($mq$How does the energy needed to heat 1.0 kg of water from 20 °C to 100 °C (specific heat capacity 4200 J/kg°C) compare with the energy to then boil it all away (L = 2.26 × 10⁶ J/kg)?$mq$, $mq$["Boiling needs about 6.7 times more","Boiling needs about the same","Boiling needs about 6.7 times less","Boiling needs about 100 times more"]$mq$, 0, $mq$Heating: 1.0 × 4200 × 80 = 3.36 × 10⁵ J. Boiling: 2.26 × 10⁶ J. The ratio is 2.26 × 10⁶ ÷ 3.36 × 10⁵ ≈ 6.7.$mq$, $mq$hard$mq$),
($mq$In a cooling-curve experiment, steam is cooled and the temperature is recorded every 30 s. The graph is level at 100 °C for several minutes. Which statement is the best explanation?$mq$, $mq$["The steam has stopped losing energy","The thermometer is faulty","The liquid is evaporating","The steam is condensing, releasing energy while its temperature stays constant"]$mq$, 3, $mq$During a change of state the energy released comes from the potential energy of the particles, so the temperature remains constant until all the steam has condensed.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Evaporation, Condensation and Boiling$mq$ and p.name = $mq$Heat and Temperature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Evaporation$mq$, $mq$Particles escape from the surface of a liquid at any temperature below the boiling point. It cools the remaining liquid.$mq$),
($mq$Why does evaporation cause cooling?$mq$, $mq$The most energetic particles escape, so the average kinetic energy of those left behind decreases.$mq$),
($mq$Factors that increase evaporation rate$mq$, $mq$Higher temperature, larger surface area, moving air and lower humidity.$mq$),
($mq$Boiling$mq$, $mq$Vapour bubbles form throughout the liquid at the boiling point. Water boils at 100 °C at normal sea-level pressure.$mq$),
($mq$Boiling point and pressure$mq$, $mq$Lower pressure (high altitude) gives a lower boiling point. Higher pressure (pressure cooker) gives a higher boiling point.$mq$),
($mq$Condensation$mq$, $mq$A gas changing into a liquid as it cools. It releases energy to the surroundings.$mq$),
($mq$Temperature during a change of state$mq$, $mq$Stays constant. The energy goes into (or comes from) the potential energy of particles, not their speed.$mq$),
($mq$Latent heat equation$mq$, $mq$Q = m × L. For water vaporising, L = 2.26 × 10⁶ J/kg.$mq$),
($mq$Evaporation versus boiling$mq$, $mq$Evaporation: surface only, any temperature, slow. Boiling: throughout the liquid, at the boiling point, fast, with bubbles.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Evaporation, Condensation and Boiling$mq$ and p.name = $mq$Heat and Temperature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Particles and change of state
In a liquid, particles are close together but can move around each other. In a gas, they are far apart and move quickly. In **evaporation**, **boiling** and **condensation**, particles move between these states. Energy is needed to go from liquid to gas, and released going from gas to liquid.

## Evaporation
**Evaporation** happens at the **surface** of a liquid, at any temperature below the boiling point. Particles in a liquid have a range of energies. The ones near the surface with the highest energy can overcome the attraction of neighbouring particles and escape. Because the fastest particles leave, the average energy of the remaining particles falls, so **evaporation cools the liquid**. This is why sweating cools the body.
The rate of evaporation increases with:
- a **higher temperature** (more particles have enough energy);
- a **larger surface area** (more particles at the surface);
- **moving air** (vapour is carried away so fewer particles return);
- **lower humidity** (dry air can take more water vapour).

## Boiling
**Boiling** happens throughout the liquid when it reaches the **boiling point**. Bubbles of vapour form inside the liquid and rise to the surface. Water boils at 100 °C at normal sea-level pressure. The boiling point depends on pressure: it is lower at high altitude, where the air pressure is lower, and higher in a pressure cooker.
During boiling, the temperature stays constant, even though energy is still being supplied. The energy goes into overcoming the forces between particles, not into raising their average speed. This energy is the **latent heat**.

## Condensation
**Condensation** is the change from gas to liquid. When vapour touches a cold surface or cools, its particles lose energy, slow down and come together. Examples include a misty mirror, dew on grass, water droplets on a cold glass, and cloud formation. Energy is released as the vapour condenses, which is why steam causes serious burns, and the surface warms up.

## Specific latent heat
The energy to change state without changing temperature is Q = m × L, where m is the mass and L is the specific latent heat. For water boiling, L = 2.26 × 10⁶ J/kg.
Worked example: to boil 0.50 kg of water at 100 °C, Q = 0.50 × 2.26 × 10⁶ = 1.13 × 10⁶ J. A 2000 W heater takes 1.13 × 10⁶ ÷ 2000 = 565 s.
Comparison: heating 1.0 kg of water from 20 °C to 100 °C needs 1.0 × 4200 × 80 = 3.36 × 10⁵ J, but boiling it away needs 2.26 × 10⁶ J, about 6.7 times more.

## Common mistakes
- Saying that boiling and evaporation are the same. Boiling happens at one temperature throughout the liquid.
- Saying that temperature rises during boiling.
- Saying that the particles in steam are hotter than in water at 100 °C. They have the same average kinetic energy; the extra energy is stored as potential energy.
- Saying evaporation cools because particles lose energy by themselves. It is because the fastest ones leave.

## How this is examined
Typical questions describe a heating or cooling experiment, give data, and ask you to plot the graph, identify the plateau, explain it using particle ideas and calculate energy with Q = m × L. Investigation tasks ask for variables to control when testing the rate of evaporation, such as surface area, volume and air flow.

Exam tip: To explain a flat section on a heating or cooling graph, write that energy is transferred but the temperature does not change because the energy is used to change the state of the substance.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('physics')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;