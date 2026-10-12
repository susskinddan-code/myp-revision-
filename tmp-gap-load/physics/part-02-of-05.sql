-- Part 2 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Astrophysics > The Solar System, Planets and Satellites
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Astrophysics$mq$, 5, 2 from public.subjects s where s.slug = $mq$physics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$The Solar System, Planets and Satellites$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physics$mq$ and p.grade = 5 and p.name = $mq$Astrophysics$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$The Solar System, Planets and Satellites$mq$ and p.name = $mq$Astrophysics$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which planet is closest to the Sun?$mq$, $mq$["Mercury","Venus","Mars","Earth"]$mq$, 0, $mq$Mercury is the innermost planet, followed by Venus, Earth and Mars.$mq$, $mq$easy$mq$),
($mq$Between which two planets is the main asteroid belt?$mq$, $mq$["Earth and Mars","Jupiter and Saturn","Neptune and Uranus","Mars and Jupiter"]$mq$, 3, $mq$The main belt of rocky asteroids lies between the orbits of Mars and Jupiter.$mq$, $mq$easy$mq$),
($mq$What force keeps planets in orbit around the Sun?$mq$, $mq$["Friction","Magnetism","Gravity","Air resistance"]$mq$, 2, $mq$The Sun's gravitational attraction provides the centripetal force that keeps planets in orbit.$mq$, $mq$easy$mq$),
($mq$What is a moon?$mq$, $mq$["A star that orbits a planet","A natural satellite that orbits a planet","An artificial satellite","A dwarf planet orbiting the Sun"]$mq$, 1, $mq$Moons are natural satellites. Artificial satellites are built by people.$mq$, $mq$easy$mq$),
($mq$Which of these is a gas giant?$mq$, $mq$["Jupiter","Mercury","Mars","Earth"]$mq$, 0, $mq$Jupiter and Saturn are the gas giants. Mercury, Earth and Mars are rocky.$mq$, $mq$easy$mq$),
($mq$The Earth orbits the Sun at a mean distance of 1.5 × 10¹¹ m. Light travels at 3.0 × 10⁸ m/s. How long does light from the Sun take to reach Earth?$mq$, $mq$["50 s","5000 s","2.0 × 10⁻³ s","500 s"]$mq$, 3, $mq$Time = distance ÷ speed = 1.5 × 10¹¹ ÷ 3.0 × 10⁸ = 500 s, which is a little over 8 minutes.$mq$, $mq$medium$mq$),
($mq$How does the time taken to orbit the Sun (the orbital period) change for planets further from the Sun?$mq$, $mq$["It decreases","It stays the same","It increases","It depends only on the planet's mass"]$mq$, 2, $mq$Further planets have longer paths and move more slowly, so their orbital periods are longer.$mq$, $mq$medium$mq$),
($mq$A satellite orbits Earth in a circle of radius 7.0 × 10⁶ m in 5800 s. What is its orbital speed? (speed = 2πr ÷ T)$mq$, $mq$["1.2 × 10³ m/s","7.6 × 10³ m/s","4.1 × 10¹⁰ m/s","7.6 × 10⁶ m/s"]$mq$, 1, $mq$Speed = 2π × 7.0 × 10⁶ ÷ 5800 ≈ 7.6 × 10³ m/s.$mq$, $mq$medium$mq$),
($mq$Which statement about a geostationary satellite is correct?$mq$, $mq$["It orbits above the equator with a period of 24 hours","It orbits over the poles with a period of 90 minutes","It stays still in space and the Earth moves under it","It orbits at only 200 km above the surface"]$mq$, 0, $mq$A geostationary satellite orbits in the same direction as Earth's spin with a 24 hour period, so it stays above the same point on the equator.$mq$, $mq$medium$mq$),
($mq$Which type of satellite is most suitable for a TV broadcasting dish that stays pointed at a fixed point in the sky?$mq$, $mq$["Low polar orbit","An asteroid","A comet","Geostationary"]$mq$, 3, $mq$Only a geostationary satellite appears fixed in the sky, so the dish needs no tracking.$mq$, $mq$medium$mq$),
($mq$Compared with a planet in an almost circular orbit, a comet's orbit is …$mq$, $mq$["a perfect circle around the Sun","a straight line","a long ellipse, with the Sun near one end","a circle around Jupiter"]$mq$, 2, $mq$Comets follow very elongated elliptical orbits, moving fastest when closest to the Sun.$mq$, $mq$medium$mq$),
($mq$A comet's tail always points …$mq$, $mq$["towards the Sun","away from the Sun","in the direction it is travelling","towards the Earth"]$mq$, 1, $mq$The tail is blown away from the Sun by the solar wind and radiation, no matter which way the comet moves.$mq$, $mq$medium$mq$),
($mq$A satellite in a low orbit and another in a higher orbit both circle the Earth. Which statement is correct?$mq$, $mq$["The satellite in the lower orbit moves faster and has a shorter period","The satellite in the lower orbit moves slower and has a shorter period","Both have the same speed and period","The higher satellite moves faster"]$mq$, 0, $mq$Gravity is stronger closer to Earth, so a satellite in a lower orbit must move faster and takes less time per orbit.$mq$, $mq$medium$mq$),
($mq$A satellite in geostationary orbit has an orbital radius of 4.2 × 10⁷ m and a period of 24 h (86 400 s). What is its orbital speed?$mq$, $mq$["7.6 × 10³ m/s","3.1 × 10⁴ m/s","1.1 × 10¹¹ m/s","3.1 × 10³ m/s"]$mq$, 3, $mq$Speed = 2π × 4.2 × 10⁷ ÷ 86 400 ≈ 3.1 × 10³ m/s. Note it is slower than a low-orbit satellite.$mq$, $mq$hard$mq$),
($mq$Earth takes 365.25 days to complete one orbit of radius 1.5 × 10¹¹ m. Which is the best estimate of its orbital speed?$mq$, $mq$["3.0 × 10⁸ m/s","3.0 × 10² m/s","3.0 × 10⁴ m/s","9.4 × 10¹¹ m/s"]$mq$, 2, $mq$Distance = 2π × 1.5 × 10¹¹ ≈ 9.4 × 10¹¹ m. Time = 365.25 × 86 400 ≈ 3.16 × 10⁷ s. Speed ≈ 3.0 × 10⁴ m/s (about 30 km/s).$mq$, $mq$hard$mq$),
($mq$A student says: 'The astronauts on the International Space Station float because there is no gravity there.' Which evaluation is best?$mq$, $mq$["Correct: gravity stops acting above the atmosphere","Incorrect: gravity is still strong, and they float because they are in continuous free fall around Earth","Incorrect: they float because the ISS is much heavier than they are","Correct: the Moon's gravity cancels Earth's"]$mq$, 1, $mq$At about 400 km height gravity is still around 90% of its value at the surface. The station and astronauts fall together as they orbit.$mq$, $mq$hard$mq$),
($mq$A probe sends a signal from Mars to Earth. The signal takes 12 minutes to arrive. Using c = 3.0 × 10⁸ m/s, what is the distance at that moment?$mq$, $mq$["2.2 × 10¹¹ m","3.6 × 10⁹ m","2.2 × 10¹⁰ m","3.6 × 10¹¹ m"]$mq$, 0, $mq$Distance = speed × time = 3.0 × 10⁸ × (12 × 60) = 3.0 × 10⁸ × 720 = 2.16 × 10¹¹ m ≈ 2.2 × 10¹¹ m.$mq$, $mq$hard$mq$),
($mq$Two satellites, P and Q, orbit Earth. P is at a greater height than Q. Which pair of statements is correct?$mq$, $mq$["P has a higher speed and a longer period than Q","P has a lower speed and a shorter period than Q","P has a higher speed and a shorter period than Q","P has a lower speed and a longer period than Q"]$mq$, 3, $mq$Higher orbits need less speed to stay in orbit, and the longer path at lower speed gives a longer period.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$The Solar System, Planets and Satellites$mq$ and p.name = $mq$Astrophysics$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Name the eight planets in order from the Sun$mq$, $mq$Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune.$mq$),
($mq$Asteroid belt$mq$, $mq$A region of rocky fragments orbiting the Sun between the orbits of Mars and Jupiter.$mq$),
($mq$What keeps planets in orbit?$mq$, $mq$The Sun's gravity, which acts as a force towards the centre and continually changes the direction of motion.$mq$),
($mq$Orbital speed formula$mq$, $mq$Speed = 2πr ÷ T, where r is the orbital radius and T the orbital period.$mq$),
($mq$Geostationary satellite$mq$, $mq$Orbits above the equator at about 36 000 km with a 24 hour period, so it stays above one point on Earth.$mq$),
($mq$Low Earth orbit satellite$mq$, $mq$Orbits a few hundred km up, in about 90 minutes at about 7.6 km/s. Used for observation and the ISS.$mq$),
($mq$How do orbital speed and period change with height?$mq$, $mq$The higher the orbit, the lower the speed and the longer the period.$mq$),
($mq$Comet orbit and tail$mq$, $mq$Long elliptical orbit, fastest near the Sun. The tail always points away from the Sun.$mq$),
($mq$Light travel time from the Sun$mq$, $mq$About 500 s (over 8 minutes), since distance 1.5 × 10¹¹ m ÷ speed 3.0 × 10⁸ m/s.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$The Solar System, Planets and Satellites$mq$ and p.name = $mq$Astrophysics$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The Solar System
Our Solar System is a star, the Sun, with objects that orbit it because of its gravity. It contains eight planets. The four inner planets, Mercury, Venus, Earth and Mars, are small and rocky. Between Mars and Jupiter lies the **asteroid belt**, a region of rocky fragments. The outer planets are Jupiter and Saturn, the **gas giants**, and Uranus and Neptune, the **ice giants**. There are also **dwarf planets** such as Pluto, and **comets**, which are balls of ice and dust.

## Orbits
A planet moves in an almost circular orbit because of the Sun's gravity. The force acts towards the centre, changing the direction of the planet's velocity all the time, so it keeps going around instead of travelling in a straight line. Planets further from the Sun have weaker gravity acting on them, move more slowly, and have longer paths, so their years are longer.

A comet follows a long, stretched ellipse. It moves fastest near the Sun and slowest when far away. Its tail is created near the Sun when the ice evaporates, and always points away from the Sun.

A **moon** is a natural satellite of a planet. The Moon orbits Earth about every 27 days.

## Satellites
A **satellite** is any object that orbits a larger object. Artificial satellites are used for communications, weather monitoring, navigation and observing Earth.
- **Low Earth orbit** (a few hundred kilometres up): a period of about 90 minutes. The satellite moves fast, about 7.6 km/s. Used for observation and the International Space Station.
- **Geostationary orbit**: a height of about 36 000 km above the equator with a period of exactly 24 hours, moving in the same direction as Earth rotates. It appears fixed in the sky, so it is ideal for TV and communications.
- **Polar orbit**: passes over the poles and scans the whole Earth over time, used for mapping and monitoring.
A satellite in a higher orbit moves more slowly and takes longer for each orbit.

## Orbital speed
For a circular orbit, speed = distance ÷ time = 2πr ÷ T.
Worked example: a satellite has an orbital radius of 7.0 × 10⁶ m and a period of 5800 s. Speed = 2π × 7.0 × 10⁶ ÷ 5800 ≈ 7.6 × 10³ m/s.
For the Earth, r = 1.5 × 10¹¹ m and T = 365.25 days ≈ 3.16 × 10⁷ s, giving a speed of about 3.0 × 10⁴ m/s.

## Light travel times
Light travels at 3.0 × 10⁸ m/s. Sunlight takes 1.5 × 10¹¹ ÷ 3.0 × 10⁸ = 500 s, over 8 minutes, to reach Earth.

## Common mistakes
- Saying astronauts float because there is no gravity. They are in free fall around Earth.
- Forgetting to convert hours or days into seconds before calculating speed.
- Thinking a comet's tail trails behind it. It points away from the Sun.
- Thinking a higher satellite moves faster. It moves more slowly.

## How this is examined
Typical tasks give orbit data for a planet or satellite and ask you to find speed, period or distance, compare satellite types for a purpose, and justify a choice. Criterion D questions may ask about the benefits and risks of space technology.

Exam tip: Convert every time to seconds and every distance to metres before using speed = distance ÷ time, and show the full circumference calculation 2πr.$mq$ from st;

-- Astrophysics > Stars, Galaxies and the Big Bang
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Astrophysics$mq$, 5, 2 from public.subjects s where s.slug = $mq$physics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Stars, Galaxies and the Big Bang$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physics$mq$ and p.grade = 5 and p.name = $mq$Astrophysics$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Stars, Galaxies and the Big Bang$mq$ and p.name = $mq$Astrophysics$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the Milky Way?$mq$, $mq$["The galaxy containing our Solar System","The nearest star to the Sun","A planet in our Solar System","A comet"]$mq$, 0, $mq$The Milky Way is our home galaxy, a huge collection of stars, gas and dust.$mq$, $mq$easy$mq$),
($mq$What is a light-year?$mq$, $mq$["The time light takes to travel one metre","A unit of brightness","One year on a distant planet","The distance light travels in one year"]$mq$, 3, $mq$A light-year is a unit of distance, about 9.5 × 10¹⁵ m.$mq$, $mq$easy$mq$),
($mq$What process releases energy in the core of a star like the Sun?$mq$, $mq$["Nuclear fission","Combustion of gas","Nuclear fusion","Radioactive decay"]$mq$, 2, $mq$Hydrogen nuclei fuse to form helium, releasing large amounts of energy.$mq$, $mq$easy$mq$),
($mq$The Sun will end its life as which type of object?$mq$, $mq$["A black hole","A white dwarf","A neutron star","A supernova"]$mq$, 1, $mq$A star of about the Sun's mass swells to a red giant, loses its outer layers, and leaves a white dwarf.$mq$, $mq$easy$mq$),
($mq$About how long ago do scientists estimate the Universe began with the Big Bang?$mq$, $mq$["13.8 billion years","4.6 billion years","100 million years","500 years"]$mq$, 0, $mq$The Big Bang was about 13.8 billion years ago. 4.6 billion years is about the age of the Solar System.$mq$, $mq$easy$mq$),
($mq$Which sequence correctly shows the life cycle of a star like the Sun?$mq$, $mq$["Nebula, main sequence, supernova, black hole","Protostar, white dwarf, red giant, main sequence","Main sequence, nebula, red giant, neutron star","Nebula, protostar, main sequence, red giant, white dwarf"]$mq$, 3, $mq$Stars form from clouds of gas and dust, spend most of their lives fusing hydrogen, then expand and cool before ending as a dense white dwarf.$mq$, $mq$medium$mq$),
($mq$What stops a main-sequence star from collapsing under its own gravity?$mq$, $mq$["The star's magnetic field","The nearby planets","The outward pressure from fusion balances gravity","The rotation of the galaxy"]$mq$, 2, $mq$The star is stable because the outward pressure from the hot core balances the inward pull of gravity.$mq$, $mq$medium$mq$),
($mq$The star Proxima Centauri is 4.2 light-years away. What does this mean?$mq$, $mq$["It is 4.2 years old","Light from it takes 4.2 years to reach us","It is 4.2 million km away","It orbits the Sun in 4.2 years"]$mq$, 1, $mq$One light-year is the distance light covers in a year, so the light we see left the star 4.2 years ago.$mq$, $mq$medium$mq$),
($mq$The light from a distant galaxy is redshifted. What does this tell us?$mq$, $mq$["The galaxy is moving away from us","The galaxy is moving towards us","The galaxy is stationary","The galaxy is made of red stars"]$mq$, 0, $mq$Redshift means the wavelengths are stretched towards the red end because the source is moving away.$mq$, $mq$medium$mq$),
($mq$Observations show that more distant galaxies have bigger redshifts. What is the best interpretation?$mq$, $mq$["The Universe is shrinking","The galaxies are all the same distance","Light speeds up in space","The Universe is expanding"]$mq$, 3, $mq$If farther galaxies move away faster, space is expanding, which supports the Big Bang theory.$mq$, $mq$medium$mq$),
($mq$Which observation is evidence for the Big Bang, besides redshift?$mq$, $mq$["Sunspots","The Moon's phases","Cosmic microwave background radiation","Meteor showers"]$mq$, 2, $mq$Faint microwave radiation coming from all directions is the cooled remains of the energy from the early Universe.$mq$, $mq$medium$mq$),
($mq$Where were most of the elements heavier than helium made?$mq$, $mq$["In the Big Bang itself","In stars and supernovae","In planets","In the Earth's core"]$mq$, 1, $mq$Hydrogen and helium formed early on. Heavier elements were made by fusion in stars, and the heaviest during supernova explosions.$mq$, $mq$medium$mq$),
($mq$A large star at the end of its life explodes. What is this called?$mq$, $mq$["A supernova","A nova","A comet","A nebula"]$mq$, 0, $mq$Massive stars end their lives in a supernova, leaving a neutron star or a black hole.$mq$, $mq$medium$mq$),
($mq$One light-year is about 9.5 × 10¹⁵ m. A star is 4.0 light-years away. What is its distance in metres?$mq$, $mq$["3.8 × 10¹⁵ m","2.4 × 10¹⁵ m","3.8 × 10¹⁹ m","3.8 × 10¹⁶ m"]$mq$, 3, $mq$4.0 × 9.5 × 10¹⁵ = 38 × 10¹⁵ = 3.8 × 10¹⁶ m.$mq$, $mq$hard$mq$),
($mq$In a lab, hydrogen emits light at 656 nm. In light from a distant galaxy the same line is at 670 nm. Which conclusion is best?$mq$, $mq$["The galaxy is approaching, because the wavelength has increased","The galaxy is receding, because the wavelength has decreased","The galaxy is receding, because the wavelength has increased","The galaxy is stationary, because the line is still present"]$mq$, 2, $mq$A longer observed wavelength (redshift) shows the galaxy is moving away from us.$mq$, $mq$hard$mq$),
($mq$Which statement best explains why a star much more massive than the Sun has a shorter life?$mq$, $mq$["It has less hydrogen to start with","It fuses its hydrogen much faster because its core is hotter and denser","It does not have fusion in its core","It is further from the galaxy centre"]$mq$, 1, $mq$Larger stars have more fuel, but they burn it at a much greater rate, so they use it up in a shorter time.$mq$, $mq$hard$mq$),
($mq$A student says: 'The Big Bang was an explosion at one point in space, and galaxies are flying out into empty space.' Which evaluation is best?$mq$, $mq$["Not quite: space itself expanded from an extremely hot, dense state everywhere","Correct: it was a normal explosion in space","Incorrect: the Universe is not expanding","Correct: the galaxies are the pieces of a star"]$mq$, 0, $mq$The Big Bang model says space itself is expanding, which carries galaxies apart. It was not an explosion into an existing space.$mq$, $mq$hard$mq$),
($mq$A telescope detects a very distant galaxy. The light left it 10 billion years ago. Which statement is correct?$mq$, $mq$["We see the galaxy as it is today","The galaxy is exactly 10 light-years away","The galaxy no longer exists","We see the galaxy as it was 10 billion years ago"]$mq$, 3, $mq$Light takes time to travel, so looking far away means looking back in time.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Stars, Galaxies and the Big Bang$mq$ and p.name = $mq$Astrophysics$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Nuclear fusion in stars$mq$, $mq$Hydrogen nuclei join to form helium in the core, releasing energy. It powers main-sequence stars.$mq$),
($mq$Main sequence star$mq$, $mq$The stable stage of a star's life, where outward pressure from fusion balances the inward pull of gravity.$mq$),
($mq$Life cycle of a star like the Sun$mq$, $mq$Nebula, protostar, main sequence, red giant, white dwarf.$mq$),
($mq$Life cycle of a massive star$mq$, $mq$Nebula, protostar, main sequence, red supergiant, supernova, then a neutron star or black hole.$mq$),
($mq$Light-year$mq$, $mq$The distance light travels in one year, about 9.5 × 10¹⁵ m. It is a unit of distance.$mq$),
($mq$Galaxy$mq$, $mq$A huge collection of stars, gas and dust held together by gravity. Ours is the Milky Way.$mq$),
($mq$Redshift$mq$, $mq$Wavelengths of light from a receding source are stretched. More distant galaxies show more redshift, so the Universe is expanding.$mq$),
($mq$Big Bang theory$mq$, $mq$The Universe began about 13.8 billion years ago from an extremely hot, dense state and has been expanding ever since.$mq$),
($mq$Cosmic microwave background radiation$mq$, $mq$Faint microwaves from all directions, the cooled radiation left over from the early hot Universe. Evidence for the Big Bang.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Stars, Galaxies and the Big Bang$mq$ and p.name = $mq$Astrophysics$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Stars
A star forms when gravity pulls together a cloud of gas and dust called a **nebula**. As it collapses it heats up, forming a **protostar**. When the core is hot and dense enough, hydrogen nuclei undergo **nuclear fusion** to form helium, releasing huge amounts of energy as light and heat. The star is now in the **main sequence**, the longest stage of its life. It is stable because the outward pressure from fusion balances the inward pull of gravity.

## The end of a star
When the hydrogen in the core runs low, the balance changes.
- A star like the Sun swells into a **red giant**, then loses its outer layers and shrinks into a hot, dense **white dwarf**.
- A much more massive star becomes a **red supergiant** and explodes in a **supernova**. The core left behind becomes a **neutron star** or, for the most massive stars, a **black hole**.
Massive stars burn faster and live for a much shorter time than small stars. Elements heavier than hydrogen and helium were made inside stars and supernovae, and so were the atoms in our bodies.

## Galaxies and distance
A **galaxy** is a huge collection of stars, gas and dust held together by gravity. Our galaxy, the Milky Way, is a spiral galaxy that contains hundreds of billions of stars. The Universe contains billions of galaxies.
Space distances are measured in **light-years**, the distance light travels in one year, about 9.5 × 10¹⁵ m. Worked example: a star 4.0 light-years away is 4.0 × 9.5 × 10¹⁵ = 3.8 × 10¹⁶ m away. Because light takes time to travel, looking at distant objects shows them as they were in the past.

## Redshift and expansion
When a light source moves away, its wavelengths are stretched towards the red end of the spectrum. This is **redshift**. Light from almost all galaxies is redshifted, and the more distant the galaxy, the greater the redshift and the faster it is moving away. This shows that space itself is expanding.

## The Big Bang
Working back in time, everything must have been together in an extremely hot, dense state about 13.8 billion years ago. This is the **Big Bang** theory. Space expanded and cooled. The evidence comprises:
- Redshift of galaxies, showing expansion.
- **Cosmic microwave background radiation**, faint microwaves from all directions, the cooled energy of the early Universe.
Scientists accept a theory when predictions agree with observations from many sources, and it is open to change with new evidence.

## Common mistakes
- Treating a light-year as a unit of time.
- Describing the Big Bang as an explosion into empty space.
- Thinking the Sun will become a black hole or supernova. It does not have enough mass.
- Saying redshift means a galaxy is red. It means the observed wavelength is longer.

## How this is examined
Questions give redshift data or star distances and ask you to interpret what they show, order stages in a star's life, convert light-years to metres, and justify why a theory is supported by evidence. Criterion D may ask you to evaluate evidence for competing models.

Exam tip: When asked for evidence, name the observation (for example redshift that increases with distance) and then state what it shows (the Universe is expanding).$mq$ from st;

-- Wave Properties > Transverse and Longitudinal Waves
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Wave Properties$mq$, 5, 3 from public.subjects s where s.slug = $mq$physics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Transverse and Longitudinal Waves$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physics$mq$ and p.grade = 5 and p.name = $mq$Wave Properties$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Transverse and Longitudinal Waves$mq$ and p.name = $mq$Wave Properties$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which of these is a transverse wave?$mq$, $mq$["Light","Sound in air","A push along a spring","Ultrasound"]$mq$, 0, $mq$In a transverse wave the vibrations are at right angles to the direction of travel. Light is a transverse wave, sound is longitudinal.$mq$, $mq$easy$mq$),
($mq$Which type of wave has compressions and rarefactions?$mq$, $mq$["Transverse","Electromagnetic","Water ripples","Longitudinal"]$mq$, 3, $mq$Longitudinal waves such as sound have regions where particles are squashed together (compressions) and spread out (rarefactions).$mq$, $mq$easy$mq$),
($mq$What is the amplitude of a wave?$mq$, $mq$["The distance between two crests","The number of waves per second","The maximum displacement from the rest position","The time for one wave"]$mq$, 2, $mq$Amplitude is the greatest distance a point moves from its undisturbed position. It is linked to the energy of the wave.$mq$, $mq$easy$mq$),
($mq$What is the unit of frequency?$mq$, $mq$["Metre (m)","Hertz (Hz)","Second (s)","Newton (N)"]$mq$, 1, $mq$Frequency is the number of waves per second, measured in hertz.$mq$, $mq$easy$mq$),
($mq$A wave travels across the sea to a beach. What does the wave transfer?$mq$, $mq$["Energy","Water particles from far away","Mass","Temperature only"]$mq$, 0, $mq$Waves transfer energy from place to place without transferring matter. The water particles move up and down on the spot.$mq$, $mq$easy$mq$),
($mq$A loudspeaker produces sound of frequency 50 Hz with a wavelength of 6.8 m. What is the speed of the sound?$mq$, $mq$["0.15 m/s","57 m/s","3400 m/s","340 m/s"]$mq$, 3, $mq$Speed = frequency × wavelength = 50 × 6.8 = 340 m/s.$mq$, $mq$medium$mq$),
($mq$A wave has a frequency of 25 Hz. What is its period?$mq$, $mq$["25 s","4.0 s","0.04 s","0.25 s"]$mq$, 2, $mq$Period = 1 ÷ frequency = 1 ÷ 25 = 0.04 s.$mq$, $mq$medium$mq$),
($mq$A student counts 5 complete waves passing a point on a rope in 2.0 s. Each wave is 0.80 m long. What is the speed of the wave?$mq$, $mq$["0.32 m/s","2.0 m/s","4.0 m/s","8.0 m/s"]$mq$, 1, $mq$Frequency = 5 ÷ 2.0 = 2.5 Hz. Speed = 2.5 × 0.80 = 2.0 m/s.$mq$, $mq$medium$mq$),
($mq$In a sound wave, what is a compression?$mq$, $mq$["A region where particles are closer together than normal","A region where particles are further apart than normal","The highest point of the wave","The point where particles stop vibrating"]$mq$, 0, $mq$Compressions are high-pressure regions where the particles are bunched up. In rarefactions they are spread out.$mq$, $mq$medium$mq$),
($mq$A person shouts towards a cliff and hears the echo 0.40 s later. The speed of sound is 340 m/s. How far away is the cliff?$mq$, $mq$["136 m","34 m","850 m","68 m"]$mq$, 3, $mq$The sound travels to the cliff and back: 340 × 0.40 = 136 m total. The cliff is half of that, 68 m.$mq$, $mq$medium$mq$),
($mq$Why can sound not travel through a vacuum?$mq$, $mq$["It is too fast","It needs light to travel","It needs particles to vibrate","It has too long a wavelength"]$mq$, 2, $mq$Sound is a longitudinal wave passed on by vibrating particles. With no particles, there is nothing to pass it on.$mq$, $mq$medium$mq$),
($mq$A louder sound of the same pitch is played. Which property of the wave has increased?$mq$, $mq$["Frequency","Amplitude","Wavelength","Speed"]$mq$, 1, $mq$Loudness depends on amplitude, pitch depends on frequency.$mq$, $mq$medium$mq$),
($mq$On a wave diagram, which distance represents one wavelength?$mq$, $mq$["From one crest to the next crest","From a crest to the next trough","From the rest line to a crest","From a trough to the rest line"]$mq$, 0, $mq$Wavelength is the distance of one complete wave, for example crest to crest.$mq$, $mq$medium$mq$),
($mq$A ship uses sonar. A pulse of sound is sent down and its echo from the sea bed arrives 0.20 s later. Sound travels at 1500 m/s in water. What is the depth?$mq$, $mq$["300 m","75 m","7500 m","150 m"]$mq$, 3, $mq$Total distance = 1500 × 0.20 = 300 m. This is down and back, so depth = 300 ÷ 2 = 150 m.$mq$, $mq$hard$mq$),
($mq$A wave on a string has a wavelength of 0.50 m and a period of 0.020 s. What is its speed?$mq$, $mq$["10 m/s","0.04 m/s","25 m/s","50 m/s"]$mq$, 2, $mq$Frequency = 1 ÷ 0.020 = 50 Hz. Speed = 50 × 0.50 = 25 m/s.$mq$, $mq$hard$mq$),
($mq$Thunder is heard 4.0 s after a lightning flash is seen. The speed of sound is 340 m/s. Which is the best estimate of the distance to the lightning?$mq$, $mq$["85 m","1400 m","340 m","1.2 × 10⁸ m"]$mq$, 1, $mq$Light arrives almost instantly, so the 4.0 s is the travel time for sound: 340 × 4.0 = 1360 m ≈ 1400 m.$mq$, $mq$hard$mq$),
($mq$A loudspeaker's frequency is doubled while the sound travels through the same air. What happens?$mq$, $mq$["The wavelength halves and the speed stays the same","The wavelength doubles and the speed stays the same","The speed doubles and the wavelength stays the same","Both the wavelength and speed halve"]$mq$, 0, $mq$Speed in a given medium is fixed. Since v = fλ, doubling f means λ must halve.$mq$, $mq$hard$mq$),
($mq$Earthquake waves are detected on the other side of the Earth. P-waves (longitudinal) arrive but S-waves (transverse) do not. Which conclusion does this support?$mq$, $mq$["The Earth is completely solid","S-waves travel faster than P-waves","Longitudinal waves cannot travel through rock","Part of the Earth's interior is liquid"]$mq$, 3, $mq$Transverse waves cannot travel through liquids, so the missing S-waves show that part of the interior (the outer core) is liquid.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Transverse and Longitudinal Waves$mq$ and p.name = $mq$Wave Properties$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Transverse wave$mq$, $mq$Vibrations are at right angles to the direction of travel. Examples: light, water ripples, waves on a rope.$mq$),
($mq$Longitudinal wave$mq$, $mq$Vibrations are parallel to the direction of travel, with compressions and rarefactions. Example: sound.$mq$),
($mq$Amplitude$mq$, $mq$The maximum displacement of a wave from its rest position. Greater amplitude means more energy.$mq$),
($mq$Wavelength$mq$, $mq$The length of one complete wave, such as crest to crest. Measured in metres.$mq$),
($mq$Frequency and period$mq$, $mq$Frequency is waves per second (Hz). Period is the time for one wave, T = 1 ÷ f.$mq$),
($mq$Wave equation$mq$, $mq$Speed = frequency × wavelength (v = fλ).$mq$),
($mq$What do waves transfer?$mq$, $mq$Energy, not matter. The medium's particles only vibrate about a fixed position.$mq$),
($mq$Speed of sound in air$mq$, $mq$About 340 m/s. Faster in liquids and fastest in solids. Cannot travel in a vacuum.$mq$),
($mq$Echo distance$mq$, $mq$Distance to the reflecting surface = (speed × time) ÷ 2, because the sound travels there and back.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Transverse and Longitudinal Waves$mq$ and p.name = $mq$Wave Properties$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is a wave?
A wave is a regular disturbance that transfers **energy** from one place to another without transferring matter. A cork on a water wave bobs up and down but does not travel along with the wave. Waves are described by the following quantities.
- **Amplitude**: the maximum displacement from the rest position. A bigger amplitude means more energy (a louder sound, a brighter light).
- **Wavelength (λ)**: the length of one complete wave, for example crest to crest, in metres.
- **Frequency (f)**: the number of complete waves per second, in hertz (Hz).
- **Period (T)**: the time for one complete wave, in seconds. T = 1 ÷ f.
- **Wave speed (v)**: the distance travelled by the wave each second.

## The wave equation
**v = f × λ**
Worked example: a sound wave has a frequency of 170 Hz. The speed of sound in air is about 340 m/s. Wavelength = v ÷ f = 340 ÷ 170 = 2.0 m.
Another: five complete waves pass a point in 2.0 s, and each wave is 0.80 m long. Frequency = 5 ÷ 2.0 = 2.5 Hz, so speed = 2.5 × 0.80 = 2.0 m/s.
The speed of a wave depends on the medium, not on its amplitude or frequency. If the frequency of a wave in a given medium goes up, the wavelength goes down.

## Transverse waves
In **transverse** waves the vibrations are at right angles to the direction the wave travels. Examples are light and all other electromagnetic waves, water ripples, and waves on a rope or string. They have crests and troughs. Transverse waves can travel through a vacuum if they are electromagnetic, but sound cannot.

## Longitudinal waves
In **longitudinal** waves the vibrations are parallel to the direction of travel. Sound is the main example, and so are pushes along a slinky spring. They have **compressions**, where particles are close together (high pressure), and **rarefactions**, where particles are further apart (low pressure). Sound needs a medium, so it cannot travel through a vacuum. It travels fastest in solids, slower in liquids and slowest in gases, because the particles are closest in solids. In air at room temperature it is about 340 m/s.

## Echoes and distance
Use distance = speed × time. For an echo or sonar, the sound travels there and back, so halve the total distance. If an echo returns after 0.40 s, the total path is 340 × 0.40 = 136 m, so the surface is 68 m away.

## Seismic waves
Earthquakes produce P-waves (longitudinal, faster) and S-waves (transverse, slower). S-waves cannot pass through liquid, which gave evidence that the Earth's outer core is liquid.

## Common mistakes
- Forgetting to halve the distance in an echo question.
- Mixing up amplitude (height) and wavelength (length).
- Saying that particles travel along with the wave. They only vibrate about a fixed position.
- Saying a higher frequency means a faster wave. In the same medium, the speed stays the same.

## How this is examined
You may be given a wave diagram or a data table and asked to read off the wavelength and amplitude, calculate frequency and speed, and explain a measurement such as an echo timing. Investigation questions may ask how to improve the accuracy of a speed-of-sound experiment, for example by timing many echoes.

Exam tip: Write the equation v = f × λ before you substitute, and check that frequency is in hertz and wavelength in metres so the answer comes out in m/s.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('physics')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;