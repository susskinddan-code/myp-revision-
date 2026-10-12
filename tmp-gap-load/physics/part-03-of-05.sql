-- Part 3 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Wave Properties > Diffraction and Wave Behaviour
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Wave Properties$mq$, 5, 3 from public.subjects s where s.slug = $mq$physics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Diffraction and Wave Behaviour$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physics$mq$ and p.grade = 5 and p.name = $mq$Wave Properties$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Diffraction and Wave Behaviour$mq$ and p.name = $mq$Wave Properties$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is reflection?$mq$, $mq$["A wave bouncing off a surface","A wave bending as it enters a new medium","A wave spreading out through a gap","A wave being absorbed"]$mq$, 0, $mq$Reflection is when a wave bounces back from a boundary or surface.$mq$, $mq$easy$mq$),
($mq$What is refraction?$mq$, $mq$["A wave bouncing off a mirror","A wave stopping completely","A wave being created","A change in direction of a wave as its speed changes"]$mq$, 3, $mq$Refraction occurs when a wave passes into a medium where its speed is different.$mq$, $mq$easy$mq$),
($mq$What is diffraction?$mq$, $mq$["The reflection of a wave from a flat surface","A wave becoming faster in a denser material","The spreading out of a wave as it passes through a gap or around an edge","The absorption of a wave energy"]$mq$, 2, $mq$Waves spread out when they pass through a gap or round an obstacle.$mq$, $mq$easy$mq$),
($mq$A ray of light hits a plane mirror. The angle of incidence is 35°. What is the angle of reflection?$mq$, $mq$["55°","35°","70°","145°"]$mq$, 1, $mq$The law of reflection says angle of incidence = angle of reflection, both measured from the normal.$mq$, $mq$easy$mq$),
($mq$What is the normal in a ray diagram?$mq$, $mq$["A line at right angles to the surface","A line along the surface","The reflected ray","The incident ray"]$mq$, 0, $mq$The normal is drawn at 90° to the surface at the point where the ray hits. Angles are measured from it.$mq$, $mq$easy$mq$),
($mq$Light passes from air into glass at an angle. What happens to its direction?$mq$, $mq$["It bends away from the normal","It does not change direction","It reflects entirely","It bends towards the normal"]$mq$, 3, $mq$Light slows down in glass, a denser medium, so it bends towards the normal.$mq$, $mq$medium$mq$),
($mq$When a water wave moves from deep to shallow water, which quantity does NOT change?$mq$, $mq$["Wavelength","Speed","Frequency","Direction (if hitting at an angle)"]$mq$, 2, $mq$The frequency is set by the source. Speed and wavelength both decrease in shallow water.$mq$, $mq$medium$mq$),
($mq$In a ripple tank, waves of frequency 6.0 Hz travel at 0.30 m/s in deep water. What is the wavelength?$mq$, $mq$["1.8 m","0.050 m","20 m","0.20 m"]$mq$, 1, $mq$Wavelength = speed ÷ frequency = 0.30 ÷ 6.0 = 0.050 m.$mq$, $mq$medium$mq$),
($mq$The same waves (6.0 Hz) move into shallower water where their speed is 0.18 m/s. What is the new wavelength?$mq$, $mq$["0.030 m","0.050 m","1.1 m","0.108 m"]$mq$, 0, $mq$The frequency stays at 6.0 Hz, so wavelength = 0.18 ÷ 6.0 = 0.030 m. The waves become closer together.$mq$, $mq$medium$mq$),
($mq$For which gap width will a wave of wavelength 2 cm diffract most?$mq$, $mq$["20 cm","1 m","Diffraction is the same for all gaps","2 cm"]$mq$, 3, $mq$Diffraction is greatest when the gap is about the same size as the wavelength.$mq$, $mq$medium$mq$),
($mq$Why can you hear someone talking around a corner even when you cannot see them?$mq$, $mq$["Sound travels faster than light","Light cannot travel through walls","Sound waves have a longer wavelength and diffract around the corner","Sound is a transverse wave"]$mq$, 2, $mq$Sound wavelengths (roughly a metre for speech) are similar to doorway sizes, so sound diffracts a lot. Visible light wavelengths are far too small to diffract noticeably.$mq$, $mq$medium$mq$),
($mq$A light ray enters a glass block with an angle of incidence of 45° and an angle of refraction of 28°. The refractive index n = sin i ÷ sin r. What is n?$mq$, $mq$["0.62","1.5","1.6 × 10¹","1.0"]$mq$, 1, $mq$sin 45° = 0.7071 and sin 28° = 0.4695. n = 0.7071 ÷ 0.4695 = 1.5.$mq$, $mq$medium$mq$),
($mq$Which of these shows total internal reflection being useful?$mq$, $mq$["Light travelling along an optical fibre","A plane mirror","A magnifying glass","A shadow"]$mq$, 0, $mq$In an optical fibre, light hits the boundary at angles greater than the critical angle, so it reflects entirely and stays inside.$mq$, $mq$medium$mq$),
($mq$Long-wave radio signals (wavelength about 1500 m) can be received behind hills, but television signals (wavelength about 0.5 m) often cannot. What is the best explanation?$mq$, $mq$["Television waves travel more slowly","Radio waves are longitudinal","Hills absorb only television waves","Longer wavelengths diffract more around large obstacles"]$mq$, 3, $mq$Diffraction is greater when the wavelength is comparable to the obstacle or gap size. 1500 m waves bend around hills, 0.5 m waves do not.$mq$, $mq$hard$mq$),
($mq$Water waves with wavelength 0.040 m pass through a gap in a barrier. For which gap will the waves spread out into almost circular wavefronts?$mq$, $mq$["0.4 m","4 m","0.04 m","The gap makes no difference"]$mq$, 2, $mq$When the gap is equal to the wavelength, diffraction is greatest and the wavefronts become almost semicircular.$mq$, $mq$hard$mq$),
($mq$A student is investigating refraction and measures the angles of incidence and refraction for a glass block, plotting sin i against sin r. The points form a straight line through the origin with gradient 1.5. Which statement is best supported?$mq$, $mq$["The angle of refraction is always 1.5 times the angle of incidence","The ratio sin i ÷ sin r is constant, so the refractive index is 1.5","The glass has a speed of 1.5 m/s","Light speeds up in the glass by a factor of 1.5"]$mq$, 1, $mq$A constant gradient shows sin i ÷ sin r is constant for that material, which is the refractive index, 1.5. The straight line is for sines, not angles.$mq$, $mq$hard$mq$),
($mq$A wave passes into a medium where it travels more slowly. Which description is correct?$mq$, $mq$["Frequency unchanged, wavelength shorter, bends towards the normal","Frequency increased, wavelength unchanged, bends away from the normal","Frequency unchanged, wavelength longer, bends towards the normal","Frequency decreased, wavelength shorter, bends away from the normal"]$mq$, 0, $mq$The source sets the frequency. v = fλ so smaller v means shorter λ. Slower speed makes the wave bend towards the normal.$mq$, $mq$hard$mq$),
($mq$A wave of wavelength 0.020 m meets a gap of width 0.20 m and then a gap of width 0.020 m. How do the diffraction patterns compare?$mq$, $mq$["Same amount of spreading in both","More spreading through the wide gap","No waves pass through the narrow gap","Little spreading through the wide gap and much more through the narrow gap"]$mq$, 3, $mq$Diffraction is most noticeable when the gap is about the same size as the wavelength. Ten times larger leads to little spreading.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Diffraction and Wave Behaviour$mq$ and p.name = $mq$Wave Properties$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Law of reflection$mq$, $mq$Angle of incidence = angle of reflection, both measured from the normal.$mq$),
($mq$Normal$mq$, $mq$An imaginary line at 90° to the surface at the point where the ray meets it. All angles are measured from it.$mq$),
($mq$Refraction$mq$, $mq$A change in direction of a wave when its speed changes on entering a different medium.$mq$),
($mq$Light from air into glass$mq$, $mq$It slows down and bends towards the normal. Leaving glass into air it bends away from the normal.$mq$),
($mq$What stays the same in refraction?$mq$, $mq$The frequency. Speed and wavelength change together (v = fλ).$mq$),
($mq$Refractive index$mq$, $mq$n = sin i ÷ sin r, where i is the angle of incidence in air and r the angle of refraction in the material.$mq$),
($mq$Total internal reflection$mq$, $mq$All light is reflected inside a denser medium when the angle of incidence exceeds the critical angle. Used in optical fibres.$mq$),
($mq$Diffraction$mq$, $mq$Waves spread out as they pass through a gap or round an edge. Wavelength and frequency do not change.$mq$),
($mq$When is diffraction greatest?$mq$, $mq$When the gap width is about the same as the wavelength.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Diffraction and Wave Behaviour$mq$ and p.name = $mq$Wave Properties$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Reflection
When a wave hits a surface it can bounce back. This is **reflection**. The **normal** is a line drawn at 90° to the surface. The **law of reflection** states that the angle of incidence equals the angle of reflection, both measured from the normal. A rough surface scatters light in many directions (diffuse reflection) while a smooth surface such as a mirror gives a clear image. Echoes are reflected sound waves.

## Refraction
**Refraction** is the change of direction of a wave when it passes from one medium to another, caused by a change in speed. When light goes from air into glass or water it slows down and bends **towards the normal**. When it goes from glass back to air it speeds up and bends **away from the normal**. If a wave hits the boundary at 90° (along the normal) it does not change direction but its speed still changes.
- The **frequency does not change** because it is set by the source.
- Since v = f × λ, slower speed means a shorter wavelength.
Worked example: in a ripple tank, deep-water waves with f = 6.0 Hz and v = 0.30 m/s have a wavelength 0.30 ÷ 6.0 = 0.050 m. In shallow water v = 0.18 m/s, so wavelength = 0.18 ÷ 6.0 = 0.030 m.
The **refractive index** of a material is n = sin i ÷ sin r. For i = 45° and r = 28°, n = 0.7071 ÷ 0.4695 = 1.5, which is typical for glass.

## Total internal reflection
When light inside glass hits the boundary with air at an angle bigger than the **critical angle**, all of it is reflected. This is **total internal reflection**. It makes optical fibres work: the light bounces along inside the fibre and carries data, and it is also used in some prisms and reflectors.

## Diffraction
**Diffraction** is the spreading out of waves as they pass through a gap or around the edge of an obstacle. The wavelength and frequency stay the same.
- The effect is greatest when the gap is **about the same size as the wavelength**.
- A gap much wider than the wavelength gives little spreading, and straight waves pass through.
This explains why you can hear around a corner (sound wavelength is roughly a metre for speech, similar to a doorway) but not see around it (the wavelength of light is about 500 nm). It also explains why long-wave radio signals can be received behind hills, while shorter-wavelength television signals are more easily blocked.

## Common mistakes
- Measuring angles from the surface instead of from the normal.
- Saying the frequency changes during refraction. It does not.
- Believing that the wavelength changes in diffraction. It stays the same.
- Saying a wider gap diffracts more. Spreading is greatest for a gap close to the wavelength.

## How this is examined
Typical tasks are ray diagrams, ripple tank data, calculations with v = fλ in two media, explaining a real situation (hearing around a corner, optical fibres) and planning an investigation into refraction, for example plotting sin i against sin r and checking it is a straight line.

Exam tip: In explanations, name the property that changes (speed), say what stays the same (frequency), and link both to the outcome (wavelength or direction).$mq$ from st;

-- Wave Properties > Electromagnetic Waves and Their Applications
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Wave Properties$mq$, 5, 3 from public.subjects s where s.slug = $mq$physics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Electromagnetic Waves and Their Applications$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physics$mq$ and p.grade = 5 and p.name = $mq$Wave Properties$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Electromagnetic Waves and Their Applications$mq$ and p.name = $mq$Wave Properties$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which electromagnetic wave has the longest wavelength?$mq$, $mq$["Radio waves","Gamma rays","X-rays","Visible light"]$mq$, 0, $mq$The spectrum from longest to shortest wavelength is radio, microwave, infrared, visible, ultraviolet, X-ray, gamma.$mq$, $mq$easy$mq$),
($mq$Which type of electromagnetic radiation is used to cook food in a microwave oven?$mq$, $mq$["Infrared","Ultraviolet","Radio waves","Microwaves"]$mq$, 3, $mq$Microwaves are absorbed by water molecules in food, which heats it.$mq$, $mq$easy$mq$),
($mq$What do all electromagnetic waves have in common?$mq$, $mq$["They have the same wavelength","They have the same frequency","They travel at the same speed in a vacuum","They are all visible"]$mq$, 2, $mq$All electromagnetic waves travel at 3.0 × 10⁸ m/s in a vacuum (and almost this in air).$mq$, $mq$easy$mq$),
($mq$Which radiation is used in TV remote controls?$mq$, $mq$["Ultraviolet","Infrared","X-rays","Gamma rays"]$mq$, 1, $mq$Infrared pulses carry signals from a remote control to a sensor on the television.$mq$, $mq$easy$mq$),
($mq$Which type of electromagnetic wave is used to see broken bones?$mq$, $mq$["X-rays","Radio waves","Microwaves","Infrared"]$mq$, 0, $mq$X-rays pass through soft tissue but are absorbed by dense bone, giving an image.$mq$, $mq$easy$mq$),
($mq$Which list shows the electromagnetic waves in order of increasing frequency?$mq$, $mq$["Gamma, X-ray, ultraviolet, visible, infrared, microwave, radio","Radio, infrared, microwave, visible, ultraviolet, X-ray, gamma","Visible, infrared, microwave, radio, ultraviolet, X-ray, gamma","Radio, microwave, infrared, visible, ultraviolet, X-ray, gamma"]$mq$, 3, $mq$Frequency rises as wavelength falls, going from radio waves to gamma rays.$mq$, $mq$medium$mq$),
($mq$A radio station broadcasts at a frequency of 100 MHz. The speed of radio waves is 3.0 × 10⁸ m/s. What is the wavelength?$mq$, $mq$["0.33 m","3.0 × 10⁶ m","3.0 m","30 m"]$mq$, 2, $mq$Wavelength = speed ÷ frequency = 3.0 × 10⁸ ÷ 1.0 × 10⁸ = 3.0 m.$mq$, $mq$medium$mq$),
($mq$A microwave oven uses waves of frequency 2.45 GHz. What is the wavelength? (c = 3.0 × 10⁸ m/s)$mq$, $mq$["8.2 m","0.12 m","1.2 × 10¹⁸ m","0.82 m"]$mq$, 1, $mq$2.45 GHz = 2.45 × 10⁹ Hz. Wavelength = 3.0 × 10⁸ ÷ 2.45 × 10⁹ ≈ 0.12 m.$mq$, $mq$medium$mq$),
($mq$Why should people limit their exposure to ultraviolet radiation from the Sun?$mq$, $mq$["It can damage skin cells and cause skin cancer","It makes the body too cold","It causes radio interference","It is not absorbed by skin"]$mq$, 0, $mq$UV carries enough energy to damage DNA and can cause sunburn, eye damage and skin cancer.$mq$, $mq$medium$mq$),
($mq$Which radiation is used to sterilise medical equipment and to treat cancer?$mq$, $mq$["Radio waves","Microwaves","Visible light","Gamma rays"]$mq$, 3, $mq$Gamma rays are highly penetrating and ionising. They kill microbes and cancer cells.$mq$, $mq$medium$mq$),
($mq$Thermal imaging cameras detect which radiation?$mq$, $mq$["Ultraviolet","X-rays","Infrared","Radio waves"]$mq$, 2, $mq$All objects emit infrared radiation, and hotter objects emit more, so a camera can build an image from temperature differences.$mq$, $mq$medium$mq$),
($mq$Optical fibres for telephone and internet signals carry which type of radiation?$mq$, $mq$["Gamma rays","Infrared or visible light","X-rays","Radio waves"]$mq$, 1, $mq$Pulses of infrared or visible light travel along fibres by total internal reflection.$mq$, $mq$medium$mq$),
($mq$Which electromagnetic radiation is used for satellite TV links and mobile phone signals?$mq$, $mq$["Microwaves","Gamma rays","X-rays","Ultraviolet"]$mq$, 0, $mq$Microwaves pass through the atmosphere and can be sent in narrow beams, so they are used for satellites and mobile phones.$mq$, $mq$medium$mq$),
($mq$Visible light has a wavelength of 500 nm in air. What is its frequency? (c = 3.0 × 10⁸ m/s, 1 nm = 1 × 10⁻⁹ m)$mq$, $mq$["1.5 × 10¹⁶ Hz","6.0 × 10⁻¹⁶ Hz","1.7 × 10⁶ Hz","6.0 × 10¹⁴ Hz"]$mq$, 3, $mq$Frequency = speed ÷ wavelength = 3.0 × 10⁸ ÷ 5.0 × 10⁻⁷ = 6.0 × 10¹⁴ Hz.$mq$, $mq$hard$mq$),
($mq$A radar pulse is sent to an aircraft and the reflection returns 2.0 ms later (1 ms = 0.001 s). The speed of the wave is 3.0 × 10⁸ m/s. How far away is the aircraft?$mq$, $mq$["6.0 × 10⁵ m","1.5 × 10⁵ m","3.0 × 10⁵ m","3.0 × 10⁸ m"]$mq$, 2, $mq$The pulse travels there and back: 3.0 × 10⁸ × 0.002 = 6.0 × 10⁵ m. The aircraft is half of this, 3.0 × 10⁵ m.$mq$, $mq$hard$mq$),
($mq$Which is the best explanation of why X-rays and gamma rays are more dangerous than radio waves?$mq$, $mq$["They travel faster than radio waves","They have much higher frequency and energy, so they can ionise atoms and damage DNA","They are longitudinal waves","They have a longer wavelength"]$mq$, 1, $mq$All electromagnetic waves travel at the same speed. Higher frequency means more energy per photon, and X-rays and gamma rays have enough to ionise.$mq$, $mq$hard$mq$),
($mq$Two engineers argue: one says mobile phone microwaves are as dangerous as X-rays because both are electromagnetic. Which evaluation is best?$mq$, $mq$["Incorrect: microwaves have much lower energy and are non-ionising, though they can cause heating","Correct: all electromagnetic waves are equally harmful","Incorrect: microwaves are ionising but at lower speeds","Correct: they have the same frequency"]$mq$, 0, $mq$Danger depends on the energy carried. Mobile microwaves cannot ionise atoms. Their main effect is slight heating of tissue, which is why exposure limits exist.$mq$, $mq$hard$mq$),
($mq$A company wants to detect forged banknotes by checking invisible markings that glow under a light source. Which radiation is most suitable?$mq$, $mq$["Gamma rays","Microwaves","Radio waves","Ultraviolet"]$mq$, 3, $mq$Fluorescent security inks absorb ultraviolet radiation and re-emit it as visible light. UV is also much safer than gamma at these levels.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Electromagnetic Waves and Their Applications$mq$ and p.name = $mq$Wave Properties$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Order of the EM spectrum (low to high frequency)$mq$, $mq$Radio, microwave, infrared, visible, ultraviolet, X-ray, gamma.$mq$),
($mq$Speed of all EM waves in a vacuum$mq$, $mq$3.0 × 10⁸ m/s.$mq$),
($mq$What changes along the EM spectrum?$mq$, $mq$Frequency and energy increase, wavelength decreases, from radio waves to gamma rays.$mq$),
($mq$Uses of microwaves$mq$, $mq$Satellite and mobile phone communications, Wi-Fi, and cooking (water absorbs them).$mq$),
($mq$Uses of infrared$mq$, $mq$Remote controls, thermal imaging, heaters and grills, short-range data and optical fibres.$mq$),
($mq$Uses of ultraviolet$mq$, $mq$Security markings, fluorescent lamps, sterilising water. Dangers: skin cancer and eye damage.$mq$),
($mq$Uses of X-rays$mq$, $mq$Imaging bones and checking baggage. Absorbed by dense materials such as bone. Ionising.$mq$),
($mq$Uses of gamma rays$mq$, $mq$Sterilising medical equipment and food, and treating cancer. Highly penetrating and ionising.$mq$),
($mq$Wave equation for EM waves$mq$, $mq$c = f × λ, where c = 3.0 × 10⁸ m/s. Convert MHz, GHz and nm to standard form first.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Electromagnetic Waves and Their Applications$mq$ and p.name = $mq$Wave Properties$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The electromagnetic spectrum
Electromagnetic (EM) waves are a family of **transverse** waves that carry energy. In order of **increasing frequency** (and decreasing wavelength) they are: radio waves, microwaves, infrared, visible light, ultraviolet, X-rays, gamma rays. A useful way to remember the order is to learn it by heart, then check using the rule that as frequency rises, wavelength falls.
All EM waves:
- travel at the same speed in a vacuum, **3.0 × 10⁸ m/s**;
- are transverse waves, and can travel through a vacuum;
- transfer energy, and can be reflected, refracted and diffracted;
- obey v = f × λ.
Higher-frequency waves carry more energy, so they are more dangerous.

## Calculations
Worked example 1: a radio station broadcasts at 100 MHz = 1.0 × 10⁸ Hz. Wavelength = 3.0 × 10⁸ ÷ 1.0 × 10⁸ = 3.0 m.
Worked example 2: green light has a wavelength of 500 nm = 5.0 × 10⁻⁷ m. Frequency = 3.0 × 10⁸ ÷ 5.0 × 10⁻⁷ = 6.0 × 10¹⁴ Hz.
Radar and echo-type questions use distance = speed × time. The signal goes there and back, so halve the total distance.

## Uses of each type
- **Radio waves**: broadcasting TV and radio, communications. Long wavelengths diffract around hills.
- **Microwaves**: satellite communications, mobile phones, Wi-Fi, and cooking in microwave ovens (water in food absorbs the waves and heats up). Microwave ovens use about 2.45 GHz, a wavelength of about 0.12 m.
- **Infrared**: remote controls, thermal imaging, electric heaters, grills, and optical fibre communications.
- **Visible light**: seeing, photography, optical fibres.
- **Ultraviolet**: security markings, sterilising water, fluorescent lamps, sun tanning.
- **X-rays**: medical imaging of bones, and airport baggage scanners. Dense bone absorbs more, so shows up on the image.
- **Gamma rays**: sterilising medical equipment and food, and treating cancer.

## Hazards
- **Microwaves**: internal heating of body tissue. Mobile phone use is regulated, but there is no strong evidence of harm at permitted levels.
- **Infrared**: skin burns.
- **Ultraviolet**: sunburn, eye damage and skin cancer, so use sunscreen and eye protection.
- **X-rays and gamma rays**: ionising, which can damage cells and cause cancer. Doses are kept low and the exposure time as short as possible, with shielding such as lead aprons.

## Common mistakes
- Thinking higher-frequency waves travel faster. They all travel at the same speed in a vacuum.
- Forgetting to convert prefixes such as MHz, GHz and nm.
- Saying all EM radiation is ionising. Only UV (higher part), X-rays and gamma are.
- Mixing up the order. Learn it as a set from radio to gamma.

## How this is examined
Expect a table of the spectrum with missing entries, a wave-equation calculation using standard form, and a short evaluation of the benefits and risks of a technology, for example whether to use X-rays or ultrasound for a medical scan. Criterion D questions reward weighing risks and benefits and giving a judgement.

Exam tip: To explain a use, link the property of the wave to the job, for example "microwaves are absorbed by water, so they heat food" or "X-rays are absorbed by bone but pass through soft tissue".$mq$ from st;

-- Static Electricity and Fields > Static Electricity and Charge
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Static Electricity and Fields$mq$, 5, 4 from public.subjects s where s.slug = $mq$physics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Static Electricity and Charge$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physics$mq$ and p.grade = 5 and p.name = $mq$Static Electricity and Fields$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Static Electricity and Charge$mq$ and p.name = $mq$Static Electricity and Fields$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What happens when two objects with the same type of charge are brought near each other?$mq$, $mq$["They repel","They attract","They have no force","They become neutral"]$mq$, 0, $mq$Like charges repel and unlike charges attract.$mq$, $mq$easy$mq$),
($mq$A polythene rod becomes negatively charged when rubbed with a cloth. Which particles moved?$mq$, $mq$["Protons moved from the cloth to the rod","Electrons moved from the rod to the cloth","Protons moved from the rod to the cloth","Electrons moved from the cloth to the rod"]$mq$, 3, $mq$Only electrons can move. The rod gained electrons so it is negative, and the cloth lost electrons so it is positive.$mq$, $mq$easy$mq$),
($mq$Which of these materials is an electrical conductor?$mq$, $mq$["Polythene","Dry wood","Copper","Rubber"]$mq$, 2, $mq$Metals such as copper have free electrons, so charge can flow through them. Polythene and rubber are insulators.$mq$, $mq$easy$mq$),
($mq$What is the unit of electric charge?$mq$, $mq$["Ampere (A)","Coulomb (C)","Volt (V)","Ohm (Ω)"]$mq$, 1, $mq$Charge is measured in coulombs. Current is measured in amperes.$mq$, $mq$easy$mq$),
($mq$What does earthing a charged object do?$mq$, $mq$["It lets charge flow to the ground, removing the charge","It makes the object more charged","It makes the object a magnet","It changes protons into electrons"]$mq$, 0, $mq$An earth wire gives a path for excess charge to flow safely away.$mq$, $mq$easy$mq$),
($mq$A balloon is rubbed on a jumper and sticks to a wall. Why does a charged balloon stick to an uncharged wall?$mq$, $mq$["The wall has a permanent opposite charge","Protons move from the balloon to the wall","Gravity pulls the balloon to the wall","It induces opposite charge on the wall surface, causing attraction"]$mq$, 3, $mq$The charged balloon pushes electrons away on the nearer surface of the wall, leaving that surface with the opposite charge, so the balloon is attracted.$mq$, $mq$medium$mq$),
($mq$A charged rod is brought near the cap of a gold-leaf electroscope without touching it, and the leaf rises. What does this show?$mq$, $mq$["The leaf is being attracted by gravity","The rod has no charge","Charges on the cap and leaf are repelling each other","Electrons have been destroyed"]$mq$, 2, $mq$Induction pushes charge down to the leaf and rod. The leaf and stem now have the same charge, so they repel.$mq$, $mq$medium$mq$),
($mq$A current of 0.50 mA flows onto a metal sphere for 4.0 s. How much charge is gained? (Q = I × t)$mq$, $mq$["2.0 C","2.0 × 10⁻³ C","8.0 × 10⁻⁴ C","0.125 C"]$mq$, 1, $mq$0.50 mA = 5.0 × 10⁻⁴ A. Q = 5.0 × 10⁻⁴ × 4.0 = 2.0 × 10⁻³ C.$mq$, $mq$medium$mq$),
($mq$Why is it dangerous to refuel an aircraft without earthing it?$mq$, $mq$["Friction can build up charge, and a spark could ignite the fuel vapour","The fuel becomes magnetic","The plane becomes too heavy","The fuel evaporates faster"]$mq$, 0, $mq$Fuel flowing through pipes can charge by friction. A spark when the charge discharges could cause a fire, so the equipment is earthed.$mq$, $mq$medium$mq$),
($mq$A positively charged rod attracts a small piece of foil hanging on a thread. Which conclusion is certain?$mq$, $mq$["The foil is positively charged","The foil is a conductor with no charge","The foil has more protons than electrons","The foil is either negatively charged or neutral"]$mq$, 3, $mq$Opposites attract, but a charged rod also attracts a neutral object by induction. So repulsion is the only reliable test for charge.$mq$, $mq$medium$mq$),
($mq$In an electrostatic paint sprayer, the paint droplets are given the same charge and the object is given an opposite charge. What is the advantage?$mq$, $mq$["Droplets repel the object so less paint is used","The paint dries without air","Droplets are attracted to the object and spread evenly","The object becomes hot"]$mq$, 2, $mq$Droplets with the same charge repel each other and spread out, while the oppositely charged object attracts them to give an even coat.$mq$, $mq$medium$mq$),
($mq$A glass rod loses electrons when rubbed with silk. Which statement about the rod is correct?$mq$, $mq$["It becomes negatively charged","It becomes positively charged","It gains protons","It remains neutral"]$mq$, 1, $mq$Losing negatively charged electrons leaves more protons than electrons, so the rod is positive.$mq$, $mq$medium$mq$),
($mq$A student rubs two different insulators together and finds each is charged. Rod X repels a negatively charged rod, and rod Y attracts it. What can be concluded?$mq$, $mq$["X is negative and Y is positive","X is positive and Y is negative","X and Y are both negative","X and Y are both positive"]$mq$, 0, $mq$Repulsion with a negative rod means X has negative charge. Attraction suggests Y is positive (it could be neutral, but both rubbed objects are charged, and charges are opposite).$mq$, $mq$medium$mq$),
($mq$A sphere has a charge of −3.2 × 10⁻⁹ C. The charge of one electron is −1.6 × 10⁻¹⁹ C. How many extra electrons does the sphere have?$mq$, $mq$["5.1 × 10²⁸","2.0 × 10⁻¹⁰","1.6 × 10⁻²⁸","2.0 × 10¹⁰"]$mq$, 3, $mq$Number = total charge ÷ charge of an electron = 3.2 × 10⁻⁹ ÷ 1.6 × 10⁻¹⁹ = 2.0 × 10¹⁰.$mq$, $mq$hard$mq$),
($mq$During a thunderstorm, a cloud base becomes negatively charged. Which description of a lightning strike is most accurate?$mq$, $mq$["Protons flow from the ground to the cloud","Electrons flow from the ground to the cloud through the air","Electrons flow from the cloud to the ground through ionised air","Neutral air carries the charge to the cloud"]$mq$, 2, $mq$Large charge builds up by friction between ice particles. When the potential difference is large enough, the air ionises and electrons flow from the negative cloud base to the ground.$mq$, $mq$hard$mq$),
($mq$A metal sphere on an insulating stand is charged positively. It is then touched briefly by an identical uncharged metal sphere on another insulating stand. What happens?$mq$, $mq$["Protons flow from the first sphere to the second","Electrons flow from the second sphere to the first and both end up positive","Electrons flow from the first sphere to the second and both end up positive","Nothing happens because both are metal"]$mq$, 1, $mq$Electrons are attracted from the neutral sphere into the positive one. The charge is shared, so both end up with a smaller positive charge.$mq$, $mq$hard$mq$),
($mq$A dust-collecting chimney (electrostatic precipitator) charges smoke particles and passes them past oppositely charged plates. Which statement best explains why this reduces pollution?$mq$, $mq$["Charged particles are attracted to the plates and removed from the gas","The particles are neutralised and burn up","The plates heat the smoke so it condenses","The particles repel each other and escape faster"]$mq$, 0, $mq$Charged ash particles are attracted to the oppositely charged plates and stick there, and they are later knocked off and collected.$mq$, $mq$hard$mq$),
($mq$A pupil claims: 'When a plastic ruler is charged by rubbing, new charge is created.' Which evaluation is best?$mq$, $mq$["Correct: friction creates electrons","Correct: friction creates protons","Incorrect: charge is destroyed in rubbing","Incorrect: charge is transferred, and total charge is conserved"]$mq$, 3, $mq$Rubbing moves electrons from one object to the other. The total amount of charge is unchanged, which is the conservation of charge.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Static Electricity and Charge$mq$ and p.name = $mq$Static Electricity and Fields$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$How do objects become charged by friction?$mq$, $mq$Electrons are transferred. The object that gains electrons becomes negative and the one that loses them becomes positive.$mq$),
($mq$Only particles that move when charging$mq$, $mq$Electrons. Protons stay fixed in the nuclei.$mq$),
($mq$Forces between charges$mq$, $mq$Like charges repel, unlike charges attract.$mq$),
($mq$Why does a charged balloon attract a neutral wall?$mq$, $mq$Induction: electrons in the wall are repelled or attracted, so the nearer surface has the opposite charge.$mq$),
($mq$Best test for whether an object is charged$mq$, $mq$Repulsion. Attraction could also happen with a neutral object.$mq$),
($mq$Conductor vs insulator$mq$, $mq$A conductor has free electrons so charge flows. An insulator holds charge in place.$mq$),
($mq$Earthing$mq$, $mq$Connecting to the ground gives charge a safe path away, removing static charge and preventing sparks.$mq$),
($mq$Charge formula$mq$, $mq$Q = I × t. Charge in coulombs, current in amperes, time in seconds.$mq$),
($mq$Charge on one electron$mq$, $mq$−1.6 × 10⁻¹⁹ C.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Static Electricity and Charge$mq$ and p.name = $mq$Static Electricity and Fields$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Charge and the atom
All matter contains charged particles. Protons are positive, electrons are negative and neutrons have no charge. Normally the number of protons equals the number of electrons, so objects are neutral. Only electrons can move from one object to another. **Charge** is measured in **coulombs (C)**. The charge on one electron is −1.6 × 10⁻¹⁹ C.

## Charging by friction
When two different insulating materials are rubbed together, electrons are transferred from one to the other.
- The material that **gains** electrons becomes **negatively** charged.
- The material that **loses** electrons becomes **positively** charged.
For example, rubbing a polythene rod with a cloth moves electrons from the cloth to the rod, so the rod is negative and the cloth is positive. A glass rod rubbed with silk loses electrons and becomes positive. The total charge stays the same, because charge is transferred, never created or destroyed.

## Forces between charges
- **Like charges repel** and **unlike charges attract**.
- A charged object also attracts a neutral object. The charge on the charged object pushes or pulls electrons in the neutral object, so the nearest surface gets the opposite charge. This is called induction. It explains why a charged balloon sticks to a wall or picks up small pieces of paper.
Because attraction can happen with a neutral object, repulsion is the only certain test that an object is charged.

## Conductors and insulators
Metals are **conductors**: they have free electrons, so charge flows easily. Plastics, glass and rubber are **insulators**: charge stays where it is, so they can hold a static charge. A conductor can be charged only if it is on an insulating stand, otherwise the charge flows away.
**Earthing** gives a path for charge to flow safely to the ground and removes excess charge.

## Current and charge
Charge flowing per second is the current: Q = I × t. Worked example: 0.50 mA for 4.0 s gives Q = 5.0 × 10⁻⁴ × 4.0 = 2.0 × 10⁻³ C. Number of electrons = total charge ÷ 1.6 × 10⁻¹⁹. For 3.2 × 10⁻⁹ C that is 2.0 × 10¹⁰ electrons.

## Uses and dangers
- **Uses**: photocopiers and laser printers, electrostatic paint spraying (droplets with the same charge spread out and are attracted to an oppositely charged object), and electrostatic precipitators in chimneys, which attract smoke particles to charged plates.
- **Dangers**: sparks when refuelling aircraft and vehicles (equipment is earthed to avoid this), lightning, and electric shocks from charged clothes. In thunderclouds, friction between ice particles builds up charge. When the potential difference is large enough, air ionises and charge flows as lightning.

## Common mistakes
- Saying protons move when objects are charged. Only electrons move.
- Using attraction as proof that an object is charged.
- Saying friction creates charge. It transfers it.

## How this is examined
Questions give a charging scenario and ask which way electrons move, predict attraction or repulsion, explain an application or hazard, and apply Q = I × t. Criterion D tasks might ask you to evaluate whether a safety procedure is effective.

Exam tip: When explaining charging, always say which object gains or loses electrons, and state the sign of charge that results.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('physics')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;