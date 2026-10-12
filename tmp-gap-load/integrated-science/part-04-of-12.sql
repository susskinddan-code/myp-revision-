-- Part 4 of 12: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Energy and Heat > Energy Stores, Transfers and Efficiency
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Energy and Heat$mq$, 5, 4 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Energy Stores, Transfers and Efficiency$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Energy and Heat$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Energy Stores, Transfers and Efficiency$mq$ and p.name = $mq$Energy and Heat$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does the principle of conservation of energy state?$mq$, $mq$["Energy cannot be created or destroyed, only transferred or dissipated","Energy is used up when work is done","Energy is created in power stations","Energy disappears as heat"]$mq$, 0, $mq$The total energy before and after a change is the same.$mq$, $mq$easy$mq$),
($mq$In which store is energy kept in a stretched spring?$mq$, $mq$["Kinetic","Thermal","Nuclear","Elastic potential"]$mq$, 3, $mq$Stretching or compressing an object stores elastic potential energy.$mq$, $mq$easy$mq$),
($mq$Which of these is a chemical energy store?$mq$, $mq$["A moving car","A hot cup of tea","Food or fuel","A stretched elastic band"]$mq$, 2, $mq$Chemical energy is released in reactions such as respiration and combustion.$mq$, $mq$easy$mq$),
($mq$A filament lamp transfers electrical energy. Which output is the useful energy?$mq$, $mq$["Heat","Light","Sound","Chemical energy"]$mq$, 1, $mq$The lamp is meant to produce light. Most of the energy goes to the surroundings as heat.$mq$, $mq$easy$mq$),
($mq$Which equation defines efficiency?$mq$, $mq$["Useful energy output ÷ total energy input","Total energy input ÷ useful energy output","Wasted energy ÷ useful energy","Useful power × time"]$mq$, 0, $mq$Efficiency compares the useful output with the total input and cannot exceed 100%.$mq$, $mq$easy$mq$),
($mq$A device takes in 500 J and transfers 400 J usefully. What is its efficiency?$mq$, $mq$["125%","20%","8%","80%"]$mq$, 3, $mq$400 ÷ 500 = 0.80, which is 80%.$mq$, $mq$medium$mq$),
($mq$A motor is supplied with 2000 J and wastes 500 J as heat and sound. What is its efficiency?$mq$, $mq$["25%","80%","75%","33%"]$mq$, 2, $mq$Useful output = 2000 − 500 = 1500 J. 1500 ÷ 2000 = 75%.$mq$, $mq$medium$mq$),
($mq$In a Sankey diagram, what does a wider arrow show?$mq$, $mq$["More time","More energy","Higher temperature","A faster device"]$mq$, 1, $mq$The width of each arrow is drawn in proportion to the amount of energy.$mq$, $mq$medium$mq$),
($mq$Why is wasted energy described as 'dissipated'?$mq$, $mq$["It spreads out into the surroundings and is hard to use again","It is destroyed","It is stored in the device","It turns into mass"]$mq$, 0, $mq$The total energy is conserved but spread out as thermal energy in the surroundings.$mq$, $mq$medium$mq$),
($mq$A 60 W filament lamp gives out 6 W as light. What is its efficiency?$mq$, $mq$["90%","1%","66%","10%"]$mq$, 3, $mq$6 ÷ 60 = 0.10, which is 10%. The other 54 W is wasted as heat.$mq$, $mq$medium$mq$),
($mq$Which describes the energy transfers in a battery-powered toy car moving along?$mq$, $mq$["Kinetic → chemical → electrical","Thermal → chemical → kinetic","Chemical → electrical → kinetic (with some wasted as heat and sound)","Electrical → chemical → gravitational"]$mq$, 2, $mq$The battery's chemical store drives a current, which makes the motor turn.$mq$, $mq$medium$mq$),
($mq$How does lubricating a machine increase its efficiency?$mq$, $mq$["It increases the input energy","It reduces friction, so less energy is wasted as heat","It makes the machine heavier","It increases the useful power by creating energy"]$mq$, 1, $mq$Less friction means less energy is dissipated as heat and sound.$mq$, $mq$medium$mq$),
($mq$A 2 kW electric heater runs for 3 hours. Electricity costs 30p per kWh. What is the cost?$mq$, $mq$["£1.80","£0.60","£18.00","£6.00"]$mq$, 0, $mq$Energy = 2 × 3 = 6 kWh. Cost = 6 × 30p = 180p = £1.80.$mq$, $mq$medium$mq$),
($mq$Appliance A takes in 800 J and gives 600 J useful output. Appliance B takes in 500 J and gives 350 J. Which is more efficient?$mq$, $mq$["B, with 70% against 60%","A, with 60% against 70%","They are equally efficient","A, with 75% against 70%"]$mq$, 3, $mq$A: 600 ÷ 800 = 75%. B: 350 ÷ 500 = 70%. B transfers less energy in total, but that is not the same as efficiency.$mq$, $mq$hard$mq$),
($mq$A company claims that its new engine is 120% efficient. What is the best evaluation?$mq$, $mq$["Possible if it is well lubricated","Possible if it is very large","Impossible, because it would produce more energy than it was given","Possible but only in cold weather"]$mq$, 2, $mq$Efficiency cannot exceed 100% because energy cannot be created.$mq$, $mq$hard$mq$),
($mq$A motor lifts a 2 kg load through 1.5 m using 50 J of electrical energy. Taking g = 10 N/kg, what is the efficiency?$mq$, $mq$["30%","60%","83%","40%"]$mq$, 1, $mq$Useful GPE = 2 × 10 × 1.5 = 30 J. 30 ÷ 50 = 60%.$mq$, $mq$hard$mq$),
($mq$An LED bulb uses 10 W and a filament bulb uses 60 W for the same light. Both are used for 1000 hours per year and electricity costs 30p per kWh. What is the yearly saving from using the LED?$mq$, $mq$["£15","£3","£18","£150"]$mq$, 0, $mq$Power saved = 50 W = 0.05 kW. Energy saved = 0.05 × 1000 = 50 kWh. Cost saved = 50 × 0.30 = £15.$mq$, $mq$hard$mq$),
($mq$1000 kg of water falls 50 m through a hydroelectric turbine. Taking g = 10 N/kg and a generator efficiency of 80%, how much electrical energy is produced?$mq$, $mq$["500 000 J","625 000 J","40 000 J","400 000 J"]$mq$, 3, $mq$GPE = 1000 × 10 × 50 = 500 000 J. 80% of this is 400 000 J.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Energy Stores, Transfers and Efficiency$mq$ and p.name = $mq$Energy and Heat$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Conservation of energy$mq$, $mq$Energy cannot be created or destroyed, only transferred between stores or dissipated into the surroundings.$mq$),
($mq$Dissipated energy$mq$, $mq$Wasted energy that spreads out into the surroundings, usually as thermal energy, and is hard to reuse.$mq$),
($mq$Efficiency formula$mq$, $mq$Efficiency = useful energy output ÷ total energy input (× 100% for a percentage). It can never exceed 100%.$mq$),
($mq$Name six energy stores$mq$, $mq$Kinetic, gravitational potential, elastic potential, chemical, thermal and nuclear.$mq$),
($mq$Sankey diagram$mq$, $mq$A diagram showing energy transfers. Arrow width is proportional to the amount of energy; useful and wasted arrows add up to the input.$mq$),
($mq$Kilowatt-hour$mq$, $mq$Energy (kWh) = power (kW) × time (h). Cost = kWh × price per kWh.$mq$),
($mq$How to increase efficiency$mq$, $mq$Reduce friction (lubricate), use insulation, and choose devices that waste less energy, such as LEDs.$mq$),
($mq$Example of energy transfers in a hydroelectric station$mq$, $mq$Gravitational potential → kinetic → electrical (with some wasted as heat and sound).$mq$),
($mq$Why can efficiency not be more than 100%?$mq$, $mq$That would mean getting out more useful energy than was put in, which would create energy.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Energy Stores, Transfers and Efficiency$mq$ and p.name = $mq$Energy and Heat$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Energy stores and transfers
Energy is measured in joules (J). We think of energy as being held in stores. The main stores are:
- **Kinetic**: movement.
- **Gravitational potential**: height above the ground.
- **Elastic potential**: stretched or squashed objects.
- **Chemical**: fuels, food and batteries.
- **Thermal**: the random motion of particles in a hot object.
- **Nuclear**: the nucleus of atoms.

Energy is moved between stores by transfers such as mechanical work, electrical current, heating and radiation (light and sound). A battery-powered toy car transfers chemical energy to electrical energy and then to kinetic energy, with some energy wasted as heat and sound.

## Conservation of energy
Energy is never created or destroyed, only transferred. In every transfer some energy is usually **wasted** or **dissipated**. This means it spreads out into the surroundings as thermal energy and cannot easily be used again. The total energy stays the same, but the useful energy decreases.

## Efficiency
Efficiency tells us how good a device is at transferring input energy into useful output energy:

efficiency = useful energy output ÷ total energy input (× 100% for a percentage)

Worked example: a motor takes in 2000 J and wastes 500 J. Useful output is 1500 J, so efficiency = 1500 ÷ 2000 = 0.75 or 75%. Efficiency can never be over 100%, because that would mean creating energy. A filament lamp that gives 6 W of light from 60 W is only 10% efficient. An LED lamp is much more efficient.

## Sankey diagrams
A Sankey diagram shows the energy flow with arrows. The width of the arrow is proportional to the amount of energy. The input arrow splits into a useful arrow and a wasted arrow, and the widths add up to the input.

## Reducing waste
- Lubrication reduces friction.
- Insulation reduces unwanted heat transfer.
- Using more efficient devices, such as LED lamps, saves energy and money.

## Energy costs
The kilowatt-hour (kWh) is a unit of energy: energy (kWh) = power (kW) × time (h). A 2 kW heater used for 3 hours uses 6 kWh. At 30p per kWh this costs £1.80. For a lamp comparison, replacing a 60 W filament lamp with a 10 W LED lamp saves 50 W. Over 1000 hours that is 50 kWh, which is £15 at 30p per kWh. Even though the LED costs more to buy, it can repay its cost quickly.

## Common mistakes
- Saying energy is "used up" or "lost". Say it is transferred or dissipated.
- Calculating efficiency the wrong way round.
- Forgetting to convert W to kW and minutes to hours when using kWh.

## How this is examined
In the eAssessment you could be given a Sankey diagram, a table of appliance data or a household electricity bill. You calculate efficiency and cost, compare devices, and evaluate sustainability. Criterion D tasks ask you to weigh the cost, the efficiency and the environmental effect, and to state assumptions such as hours of use.

Exam tip: In explanations, name the energy stores at the start and end of the transfer and say where the wasted energy goes. Show units for every step of a calculation.$mq$ from st;

-- Energy and Heat > Heat Transfer and Thermal Physics
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Energy and Heat$mq$, 5, 4 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Heat Transfer and Thermal Physics$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Energy and Heat$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Heat Transfer and Thermal Physics$mq$ and p.name = $mq$Energy and Heat$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$How does heat travel through a solid metal rod?$mq$, $mq$["By conduction","By convection","By radiation only","By evaporation"]$mq$, 0, $mq$Particles vibrate and pass on energy, and in metals free electrons help.$mq$, $mq$easy$mq$),
($mq$In which type of material does convection happen?$mq$, $mq$["Solids only","A vacuum","Metals only","Liquids and gases"]$mq$, 3, $mq$Convection needs particles that can flow, so it happens in fluids.$mq$, $mq$easy$mq$),
($mq$Which method of heat transfer can travel through a vacuum?$mq$, $mq$["Conduction","Convection","Radiation","Evaporation"]$mq$, 2, $mq$Infrared radiation is an electromagnetic wave and needs no particles.$mq$, $mq$easy$mq$),
($mq$Which of these is a good thermal insulator?$mq$, $mq$["Copper","Wool or trapped air","Iron","Aluminium"]$mq$, 1, $mq$Poor conductors with trapped air slow heat transfer.$mq$, $mq$easy$mq$),
($mq$In which unit is the thermal energy transferred measured?$mq$, $mq$["Joule (J)","Degree Celsius (°C)","Newton (N)","Watt (W)"]$mq$, 0, $mq$Temperature is in °C. Energy is in joules.$mq$, $mq$easy$mq$),
($mq$Why are metals good conductors of heat?$mq$, $mq$["They have no particles","They contain lots of trapped air","Their particles never vibrate","They contain free electrons that carry energy through the metal"]$mq$, 3, $mq$Free electrons move quickly and transfer energy quickly.$mq$, $mq$medium$mq$),
($mq$Why does a heated fluid rise?$mq$, $mq$["It becomes heavier","Its particles stop moving","It expands and becomes less dense than the surrounding fluid","It becomes a solid"]$mq$, 2, $mq$Warm fluid is less dense so it floats up, and cooler fluid sinks to replace it, forming a convection current.$mq$, $mq$medium$mq$),
($mq$Which surface is the best absorber and emitter of infrared radiation?$mq$, $mq$["Shiny white","Dull black","Shiny silver","Dull white"]$mq$, 1, $mq$Dark, matt surfaces absorb and emit radiation well. Shiny surfaces reflect it.$mq$, $mq$medium$mq$),
($mq$How much energy is needed to raise the temperature of 2 kg of water by 10 °C? (specific heat capacity 4200 J/kg°C)$mq$, $mq$["84 000 J","8400 J","840 J","42 000 J"]$mq$, 0, $mq$Q = m × c × ΔT = 2 × 4200 × 10 = 84 000 J.$mq$, $mq$medium$mq$),
($mq$A 2000 W kettle with no energy losses heats 1.0 kg of water from 20 °C to 100 °C (c = 4200 J/kg°C). How long does it take?$mq$, $mq$["80 s","336 s","8.4 s","168 s"]$mq$, 3, $mq$Q = 1.0 × 4200 × 80 = 336 000 J. Time = 336 000 ÷ 2000 = 168 s.$mq$, $mq$medium$mq$),
($mq$A vacuum flask has a double-walled glass bottle with a vacuum and silvered surfaces. What does the vacuum do?$mq$, $mq$["It stops radiation only","It makes the glass thicker","It stops conduction and convection between the walls","It heats the liquid inside"]$mq$, 2, $mq$With no particles between the walls, conduction and convection cannot occur. The silver reflects radiation.$mq$, $mq$medium$mq$),
($mq$Why does loft insulation reduce heating costs?$mq$, $mq$["It creates heat","It traps air, which is a poor conductor and cannot circulate","It reflects sound","It conducts heat away"]$mq$, 1, $mq$Trapped air reduces conduction and convection so heat escapes more slowly.$mq$, $mq$medium$mq$),
($mq$A metal spoon and a wooden spoon in a cold room are at the same temperature. Why does the metal one feel colder?$mq$, $mq$["Metal conducts heat away from the hand faster","Metal is at a lower temperature","Wood is a better conductor","Wood has more thermal energy"]$mq$, 0, $mq$The feeling of cold depends on the rate of heat transfer from the hand.$mq$, $mq$medium$mq$),
($mq$Four identical beakers of hot water are wrapped in different materials. After 10 min the temperature falls are: no wrap 30 °C, foam 12 °C, newspaper 18 °C and foil 25 °C. Which conclusion is best supported?$mq$, $mq$["Foil is the best insulator","Newspaper is the best insulator","All wrappings are equally good","Foam is the best insulator of those tested"]$mq$, 3, $mq$The smallest drop in temperature means the least heat transfer. The variables to control include starting temperature, volume of water and wrapping thickness.$mq$, $mq$hard$mq$),
($mq$At the seaside, during a sunny day, a breeze blows from the sea to the land. Which is the best explanation?$mq$, $mq$["Sea heats faster than land, so air above the sea rises","The sea is always colder","Land heats faster than the sea, so air above the land rises and cooler air moves in from the sea","Wind is created by waves"]$mq$, 2, $mq$Water has a high specific heat capacity, so the sea warms slowly. Warm air over land rises and creates a convection current.$mq$, $mq$hard$mq$),
($mq$0.50 kg of copper (c = 390 J/kg°C) cools from 100 °C to 20 °C. How much energy does it release?$mq$, $mq$["19 500 J","15 600 J","3900 J","156 000 J"]$mq$, 1, $mq$Q = 0.50 × 390 × 80 = 15 600 J.$mq$, $mq$hard$mq$),
($mq$Students find the specific heat capacity of a metal block using an electric heater but do not insulate it. Their value is higher than the data-book value. What explains this?$mq$, $mq$["Some energy was lost to the surroundings, so the block gained less than the energy supplied","The block gained more energy than supplied","The thermometer measured mass","The heater created extra energy"]$mq$, 0, $mq$Using too much energy in the calculation (energy supplied, not energy gained) makes c = Q ÷ (m × ΔT) too large. Insulating the block would improve the experiment.$mq$, $mq$hard$mq$),
($mq$Why does a gas conduct heat much worse than a solid?$mq$, $mq$["Gas particles do not move","Gas particles have no energy","Gas particles are always heavier","Its particles are far apart so they collide less often to pass on energy"]$mq$, 3, $mq$Conduction depends on collisions or vibrations passing energy between neighbouring particles. In a gas they are widely spaced.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Heat Transfer and Thermal Physics$mq$ and p.name = $mq$Energy and Heat$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Conduction$mq$, $mq$Transfer of energy through a solid by particle vibrations and, in metals, by free electrons.$mq$),
($mq$Convection$mq$, $mq$Energy transfer in fluids: warmer, less dense fluid rises and cooler, denser fluid sinks, forming a convection current.$mq$),
($mq$Radiation$mq$, $mq$Transfer by infrared electromagnetic waves; needs no particles, so it can travel through a vacuum.$mq$),
($mq$Best absorbers and emitters of radiation$mq$, $mq$Dull, black surfaces. Shiny, light surfaces reflect radiation and emit poorly.$mq$),
($mq$How does a vacuum flask work?$mq$, $mq$Vacuum stops conduction and convection, silvered walls reflect radiation, and the stopper reduces heat loss.$mq$),
($mq$Specific heat capacity equation$mq$, $mq$Q = m × c × ΔT. Q in joules, m in kg, c in J/kg°C, ΔT is the temperature change in °C.$mq$),
($mq$Specific heat capacity of water$mq$, $mq$About 4200 J/kg°C: water needs a lot of energy to warm up and releases a lot as it cools.$mq$),
($mq$Why do metals conduct heat well?$mq$, $mq$Free electrons carry energy rapidly through the metal.$mq$),
($mq$Why is trapped air a good insulator?$mq$, $mq$Gases are poor conductors, and trapped air cannot form convection currents.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Heat Transfer and Thermal Physics$mq$ and p.name = $mq$Energy and Heat$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Temperature and thermal energy
Temperature tells us how hot something is. It measures the average kinetic energy of the particles. Thermal energy (heat) is the total energy of the moving particles and is measured in joules. A bath of warm water holds more thermal energy than a cup of boiling water, though the cup has a higher temperature. Energy always flows from hot to cold.

## Conduction
Conduction is the transfer of energy through a solid. Hot particles vibrate more strongly and pass energy to their neighbours. In metals, free electrons move through the metal carrying energy fast, so metals are good conductors. Non-metals, liquids and gases are poor conductors. Gases are the worst because their particles are far apart and collide less often. Materials that trap air, such as wool or foam, are good insulators. A metal spoon feels colder than a wooden one at the same temperature because metal draws heat from your hand faster.

## Convection
Convection happens in liquids and gases. When a fluid is heated, the particles move apart, so the fluid becomes less dense and rises. Cooler, denser fluid sinks to replace it, setting up a convection current. This explains radiators heating a room, sea breezes and why a freezer compartment is at the top of some fridges. Convection cannot happen in solids or a vacuum.

## Radiation
All objects emit infrared radiation, and hotter objects emit more. Radiation is an electromagnetic wave, so it can travel through a vacuum, which is how the Sun's energy reaches Earth. Dull, black surfaces are the best absorbers and emitters. Shiny, white surfaces reflect radiation and are poor emitters.

## Reducing heat transfer
A vacuum flask has a vacuum between two walls to stop conduction and convection and silvered surfaces to reflect radiation. Houses use loft insulation, cavity wall insulation and double glazing, all of which trap air to reduce conduction and prevent convection.

## Specific heat capacity
The energy needed to change the temperature of a substance is Q = m × c × ΔT, where c is the specific heat capacity in J/kg°C. For water c = 4200 J/kg°C. Heating 2 kg of water by 10 °C takes 2 × 4200 × 10 = 84 000 J. A 2000 W kettle needs 336 000 ÷ 2000 = 168 s to heat 1.0 kg of water from 20 °C to 100 °C, if there is no heat loss. Water has a high specific heat capacity, so the sea warms and cools more slowly than land, which causes sea breezes. In experiments, unwanted heat loss makes the measured c too large, so insulation is used.

## Common mistakes
- Confusing temperature and thermal energy.
- Saying that insulators "stop" heat. They only slow transfer.
- Saying that cold flows into a warm object.
- Using the final temperature instead of the temperature change.

## How this is examined
Typical contexts are keeping a drink hot, insulating a house, solar water heaters or sea breezes. You analyse cooling data, name the method of transfer, calculate energy using Q = mcΔT, and evaluate a method by identifying sources of error.

Exam tip: Always name the method of heat transfer and the particle behaviour, for example "free electrons carry energy in the metal". Use the temperature change, not the final temperature, in calculations.$mq$ from st;

-- Energy and Heat > Energy Resources and Sustainability
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Energy and Heat$mq$, 5, 4 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Energy Resources and Sustainability$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Energy and Heat$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Energy Resources and Sustainability$mq$ and p.name = $mq$Energy and Heat$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which of these is a renewable energy resource?$mq$, $mq$["Wind","Coal","Natural gas","Oil"]$mq$, 0, $mq$Renewable resources are replaced naturally as fast as they are used.$mq$, $mq$easy$mq$),
($mq$Which of these is a non-renewable energy resource?$mq$, $mq$["Solar","Tidal","Wind","Natural gas"]$mq$, 3, $mq$Fossil fuels take millions of years to form.$mq$, $mq$easy$mq$),
($mq$Which gas released by burning fossil fuels contributes to global warming?$mq$, $mq$["Oxygen","Nitrogen","Carbon dioxide","Helium"]$mq$, 2, $mq$CO₂ traps infrared radiation in the atmosphere.$mq$, $mq$easy$mq$),
($mq$What energy transfer does a wind turbine make?$mq$, $mq$["Chemical to electrical","Kinetic energy of the wind to electrical energy","Nuclear to kinetic","Thermal to chemical"]$mq$, 1, $mq$Moving air turns the blades, which turn a generator.$mq$, $mq$easy$mq$),
($mq$What does sustainable mean in the context of energy?$mq$, $mq$["Meeting present needs without harming future generations' ability to meet theirs","Using energy as fast as possible","Using only coal","Using one resource only"]$mq$, 0, $mq$Sustainable use balances current benefits with long-term environmental, social and economic effects.$mq$, $mq$easy$mq$),
($mq$What is a main disadvantage of solar power?$mq$, $mq$["It releases large amounts of CO₂ when used","It uses up fuel quickly","It cannot be used in any country","Output depends on sunlight and varies with weather and time of day"]$mq$, 3, $mq$Solar cells produce no emissions while running but are intermittent.$mq$, $mq$medium$mq$),
($mq$What is a major advantage and a major disadvantage of nuclear power?$mq$, $mq$["No waste; uses fossil fuel","Cheap to build; unreliable","Very low CO₂ emissions in operation; radioactive waste","Renewable; causes acid rain"]$mq$, 2, $mq$Nuclear power stations release little CO₂ but need long-term storage for radioactive waste and have high building costs.$mq$, $mq$medium$mq$),
($mq$Which is a main disadvantage of hydroelectric power?$mq$, $mq$["It releases a lot of CO₂ when running","Dams can flood habitats and displace people","It only works at night","It needs coal"]$mq$, 1, $mq$Hydro is reliable and low-carbon in operation but changes ecosystems.$mq$, $mq$medium$mq$),
($mq$Which sequence describes energy transfers in a coal-fired power station?$mq$, $mq$["Chemical → thermal → kinetic → electrical","Nuclear → chemical → electrical","Kinetic → chemical → thermal","Electrical → thermal → chemical"]$mq$, 0, $mq$Coal burns to heat water into steam, the steam turns turbines, and generators produce electricity.$mq$, $mq$medium$mq$),
($mq$A wind farm has 10 turbines each rated at 2 MW but on average produces 30% of its rated output. What is the average power output of the farm?$mq$, $mq$["20 MW","0.6 MW","60 MW","6 MW"]$mq$, 3, $mq$Total rated power = 20 MW. 30% of 20 = 6 MW.$mq$, $mq$medium$mq$),
($mq$How does carbon dioxide cause the greenhouse effect to increase?$mq$, $mq$["It reflects all sunlight","It makes the atmosphere thinner","It absorbs infrared radiation from Earth and re-emits it, warming the atmosphere","It absorbs ultraviolet only"]$mq$, 2, $mq$More CO₂ traps more energy near the surface.$mq$, $mq$medium$mq$),
($mq$Why might biofuels be called low-carbon, and what is one issue?$mq$, $mq$["They release no CO₂ at all; they are cheaper","Plants absorb CO₂ as they grow; but growing them can take land from food crops","They are non-renewable; they are clean","They are made by nuclear reactions; they last forever"]$mq$, 1, $mq$The CO₂ released when burning was taken in earlier, but land use, fertilisers and transport add to the impact.$mq$, $mq$medium$mq$),
($mq$What is geothermal energy?$mq$, $mq$["Using thermal energy from hot rocks underground","Using tides to turn turbines","Using wind to heat water","Using sunlight for photosynthesis"]$mq$, 0, $mq$Hot rock heats water into steam that can turn turbines or heat buildings.$mq$, $mq$medium$mq$),
($mq$In a hypothetical comparison, source X releases 0.90 kg of CO₂ per kWh and source Z releases 0.01 kg per kWh. How much CO₂ would be avoided by supplying 1000 kWh from Z instead of X?$mq$, $mq$["900 kg","10 kg","91 kg","890 kg"]$mq$, 3, $mq$1000 × (0.90 − 0.01) = 890 kg.$mq$, $mq$hard$mq$),
($mq$Wind farms sometimes produce more electricity than needed. A planner proposes pumped storage. Why is it useful?$mq$, $mq$["It makes wind blow more often","It removes the need for turbines","Surplus electricity pumps water uphill so the stored GPE can generate electricity when wind is low","It creates energy from nothing"]$mq$, 2, $mq$Storage helps cope with intermittent supply by saving energy for when it is needed.$mq$, $mq$hard$mq$),
($mq$A solar panel produces 300 kWh each year and replaces electricity from a grid that releases 0.4 kg of CO₂ per kWh. Over 20 years how much CO₂ is avoided?$mq$, $mq$["120 kg","2400 kg","6000 kg","24 000 kg"]$mq$, 1, $mq$300 × 20 = 6000 kWh. 6000 × 0.4 = 2400 kg.$mq$, $mq$hard$mq$),
($mq$A newspaper says 'electric cars produce zero emissions'. Which is the best evaluation?$mq$, $mq$["They have no exhaust emissions, but the total effect depends on how the electricity and batteries are produced","It is true because electricity is clean","It is false because electric cars burn fuel","It is true because batteries are made from nothing"]$mq$, 0, $mq$A fair evaluation considers the whole life cycle and the electricity mix.$mq$, $mq$hard$mq$),
($mq$A household uses 4000 kWh a year. A solar system produces 3600 kWh a year but mainly in daytime. Which is the best evaluation?$mq$, $mq$["It meets 100% of demand at all times","It meets 10% of the demand","It is useless because it only works in summer","It meets about 90% of annual demand in total but cannot supply night-time needs without storage or the grid"]$mq$, 3, $mq$3600 ÷ 4000 = 90% on an annual basis. Matching supply with demand at different times is a limitation.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Energy Resources and Sustainability$mq$ and p.name = $mq$Energy and Heat$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Renewable energy resource$mq$, $mq$A resource that is naturally replaced at the rate it is used, e.g. wind, solar, hydroelectric, tidal, geothermal, biofuels.$mq$),
($mq$Non-renewable energy resource$mq$, $mq$A resource that will run out, e.g. coal, oil, natural gas and nuclear fuel.$mq$),
($mq$Why do fossil fuels cause global warming?$mq$, $mq$Burning them releases carbon dioxide, a greenhouse gas that absorbs infrared radiation and traps energy.$mq$),
($mq$Main problem with nuclear power$mq$, $mq$It produces radioactive waste that must be stored safely for a long time; it is expensive to build and decommission.$mq$),
($mq$Main problem with wind and solar$mq$, $mq$They are intermittent: the output depends on the wind or sunlight, so storage or backup is needed.$mq$),
($mq$Sustainability$mq$, $mq$Meeting present needs without reducing the ability of future generations to meet their own needs.$mq$),
($mq$Pumped storage$mq$, $mq$Surplus electricity pumps water uphill; the water's GPE can be released through turbines to generate electricity when demand is high.$mq$),
($mq$Average power of a wind farm$mq$, $mq$Rated power × proportion of time/output achieved, e.g. 20 MW × 30% = 6 MW.$mq$),
($mq$Greenhouse effect$mq$, $mq$Gases such as CO₂ and methane absorb infrared radiation from Earth and re-emit it, warming the atmosphere.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Energy Resources and Sustainability$mq$ and p.name = $mq$Energy and Heat$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Energy resources
Energy resources are used to generate electricity, heat buildings and fuel transport. They can be **non-renewable** (they will run out) or **renewable** (naturally replaced).

**Non-renewable**: coal, oil and natural gas (fossil fuels) and nuclear fuels (uranium). Fossil fuels release carbon dioxide when burned, which strengthens the greenhouse effect and contributes to global warming. Burning coal and oil also releases sulfur dioxide, which causes acid rain. Nuclear power stations produce almost no CO₂ in operation, but they produce radioactive waste that needs safe storage for a long time, and they are expensive to build and decommission.

**Renewable**: solar, wind, hydroelectric, tidal, geothermal and biofuels.
- **Solar**: no emissions while running but depends on sunlight and the weather.
- **Wind**: no fuel needed, but depends on wind and can affect landscapes and birds.
- **Hydroelectric**: reliable and fast to start, but dams can flood habitats and move people.
- **Tidal**: very predictable, but barrages affect estuaries and cost a lot.
- **Geothermal**: uses heat from hot rocks, only available in some locations.
- **Biofuels**: made from plants. They are considered low-carbon since plants absorb CO₂ as they grow, but land use, fertilisers and transport add emissions.

## The greenhouse effect
Greenhouse gases such as carbon dioxide and methane absorb infrared radiation emitted by Earth and re-emit it, which keeps Earth warm. Increasing the amount of these gases traps more energy and raises average temperatures.

## Calculating and comparing
Power stations transfer energy through stages such as chemical to thermal to kinetic to electrical. Each stage wastes energy.

Capacity and output: a wind farm with 10 turbines each rated at 2 MW has a rated power of 20 MW. If the farm produces on average 30% of its rated power, the average output is 6 MW. Carbon savings: if a solar system produces 300 kWh a year and the grid emits 0.4 kg of CO₂ per kWh, it avoids 300 × 0.4 = 120 kg per year, or 2400 kg over 20 years.

## Sustainability
A sustainable choice meets present needs without damaging the ability of future generations to meet theirs. When evaluating, consider cost, reliability, emissions, land use, waste and who is affected. No energy source is perfect. Energy storage, such as pumped storage hydro or batteries, helps manage the intermittent supply from wind and solar. Saving energy through insulation and efficient devices is often the cheapest way to cut emissions.

## Common mistakes
- Saying that renewable sources have no impact at all.
- Saying that nuclear power causes global warming from its operation, or that it is renewable.
- Mixing up the greenhouse effect with the ozone layer.
- Giving only advantages or only disadvantages in a "discuss" or "evaluate" answer.

## How this is examined
In criterion D contexts you may read about a town choosing between a wind farm, a solar farm and a gas station. You use data tables for cost and emissions, calculate savings, state assumptions, and judge which option is most sustainable, considering different stakeholders.

Exam tip: For "evaluate" or "discuss" questions give at least one advantage and one disadvantage, support them with data from the stimulus, and reach a justified conclusion.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('integrated-science')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;