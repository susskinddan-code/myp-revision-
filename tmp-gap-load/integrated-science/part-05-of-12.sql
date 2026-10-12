-- Part 5 of 12: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Waves, Light and Sound > Wave Properties and Sound
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Waves, Light and Sound$mq$, 5, 5 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Wave Properties and Sound$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Waves, Light and Sound$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Wave Properties and Sound$mq$ and p.name = $mq$Waves, Light and Sound$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$A student makes a wave on a slinky spring by moving one end up and down. Which describes a transverse wave?$mq$, $mq$["The vibrations are at right angles to the direction the wave travels","The vibrations are in the same direction as the wave travels","The medium moves along with the wave","The wave carries matter from one end to the other"]$mq$, 0, $mq$In a transverse wave the particles vibrate perpendicular to the direction of energy transfer. Waves transfer energy, not matter.$mq$, $mq$easy$mq$),
($mq$Sound travels through air as a longitudinal wave. What are the regions where the particles are pushed close together called?$mq$, $mq$["Rarefactions","Crests","Troughs","Compressions"]$mq$, 3, $mq$Compressions are high-pressure regions where particles are squashed together; rarefactions are where they are spread apart. Crests and troughs belong to transverse waves.$mq$, $mq$easy$mq$),
($mq$What is the SI unit of frequency?$mq$, $mq$["Metre (m)","Metres per second (m/s)","Hertz (Hz)","Decibel (dB)"]$mq$, 2, $mq$Frequency is the number of waves per second, measured in hertz. Metres measure wavelength and m/s measures wave speed.$mq$, $mq$easy$mq$),
($mq$A loudspeaker is turned up so the sound gets louder but stays the same note. Which wave property has increased?$mq$, $mq$["Frequency","Amplitude","Wavelength","Wave speed"]$mq$, 1, $mq$Loudness depends on amplitude (the size of the vibration). Pitch depends on frequency, which stayed the same.$mq$, $mq$easy$mq$),
($mq$Why can sound not travel through a vacuum?$mq$, $mq$["There are no particles to pass the vibrations on","Sound is too fast to travel through empty space","Sound waves need light to carry them","The particles in a vacuum are too hot"]$mq$, 0, $mq$Sound is a mechanical wave that needs a medium made of particles. Space is almost empty so there is nothing to vibrate.$mq$, $mq$easy$mq$),
($mq$A tuning fork produces a note of frequency 500 Hz. The wavelength of the sound in air is 0.68 m. What is the speed of sound?$mq$, $mq$["735 m/s","0.00136 m/s","500.68 m/s","340 m/s"]$mq$, 3, $mq$v = f × λ = 500 × 0.68 = 340 m/s. Dividing instead of multiplying gives the wrong answers.$mq$, $mq$medium$mq$),
($mq$Aisha claps near a tall cliff and hears an echo 0.60 s later. The speed of sound is 340 m/s. How far away is the cliff?$mq$, $mq$["204 m","57 m","102 m","567 m"]$mq$, 2, $mq$The sound travels to the cliff and back, so the total distance is 340 × 0.60 = 204 m. The cliff is half of that: 102 m.$mq$, $mq$medium$mq$),
($mq$An oscilloscope shows the trace of two notes with the same amplitude. Trace X has 3 complete waves on the screen and trace Y has 6 complete waves on the same time scale. Which statement is correct?$mq$, $mq$["Y is twice as loud as X","Y has twice the frequency of X, so it has a higher pitch","X has the higher pitch","X and Y have the same pitch but different loudness"]$mq$, 1, $mq$More waves in the same time means higher frequency, which is heard as higher pitch. Equal amplitudes mean equal loudness.$mq$, $mq$medium$mq$),
($mq$Sound travels at about 340 m/s in air, 1500 m/s in water and 5000 m/s in steel. What is the best explanation?$mq$, $mq$["Particles are closer together in denser media, so vibrations are passed on faster","Sound is a transverse wave in solids","Sound needs more energy to travel through air","Particles in solids move faster because they are hotter"]$mq$, 0, $mq$In liquids and solids the particles are closer and bonded more strongly, so vibrations pass between them quickly.$mq$, $mq$medium$mq$),
($mq$Eight complete waves pass a point on a rope in 4.0 seconds. What are the frequency and period of the wave?$mq$, $mq$["0.50 Hz and 2.0 s","32 Hz and 0.031 s","8.0 Hz and 4.0 s","2.0 Hz and 0.50 s"]$mq$, 3, $mq$Frequency = 8 ÷ 4.0 = 2.0 Hz. Period = 1 ÷ frequency = 0.50 s.$mq$, $mq$medium$mq$),
($mq$A group measures the speed of sound by timing a starter pistol sound over 200 m. The time is 0.59 s. What speed do they calculate (3 significant figures)?$mq$, $mq$["118 m/s","0.00295 m/s","339 m/s","678 m/s"]$mq$, 2, $mq$Speed = distance ÷ time = 200 ÷ 0.59 = 339 m/s.$mq$, $mq$medium$mq$),
($mq$Humans can hear frequencies from about 20 Hz to 20 000 Hz. A bat produces a call of 60 000 Hz. What can you conclude?$mq$, $mq$["It is infrasound, so humans cannot hear it","It is ultrasound, so humans cannot hear it","It is audible but very quiet","It is audible only in water"]$mq$, 1, $mq$Frequencies above 20 000 Hz are ultrasound. Infrasound is below 20 Hz.$mq$, $mq$medium$mq$),
($mq$The distance from one crest to the next crest of a water wave is 0.25 m. What does this distance represent?$mq$, $mq$["The wavelength","The amplitude","The period","The frequency"]$mq$, 0, $mq$Wavelength is the distance between two identical points on neighbouring waves. Amplitude is measured from the rest line to a crest.$mq$, $mq$medium$mq$),
($mq$A source is vibrating at 8 Hz and then at 16 Hz in the same ripple tank. The wave speed in the water does not change. What happens to the wavelength?$mq$, $mq$["It doubles","It stays the same","It increases by 8 times","It halves"]$mq$, 3, $mq$Since v = fλ and v is constant, doubling f halves λ.$mq$, $mq$hard$mq$),
($mq$A medical ultrasound pulse takes 0.00020 s to travel to a tissue boundary and back. The speed of ultrasound in tissue is 1540 m/s. How deep is the boundary?$mq$, $mq$["0.308 m","0.0000001 m","0.154 m","7700 m"]$mq$, 2, $mq$Total distance = 1540 × 0.00020 = 0.308 m. The pulse went there and back, so the depth is 0.308 ÷ 2 = 0.154 m.$mq$, $mq$hard$mq$),
($mq$A class times the speed of sound over 100 m with a hand-held stopwatch. Their results are 15 % too high. Which change would most reduce the percentage error?$mq$, $mq$["Use the same distance but a quieter sound","Use a longer distance, so reaction-time error is a smaller fraction of the time","Time only once to avoid fatigue","Use a shorter distance so the sound is clearer"]$mq$, 1, $mq$Human reaction time adds a roughly fixed error. A longer distance gives a longer measured time, so the same error is a smaller percentage.$mq$, $mq$hard$mq$),
($mq$Sound passes from air into water. Which row describes what happens to its frequency, speed and wavelength?$mq$, $mq$["Frequency same, speed increases, wavelength increases","Frequency increases, speed same, wavelength decreases","Frequency same, speed decreases, wavelength decreases","Frequency decreases, speed increases, wavelength same"]$mq$, 0, $mq$Frequency is set by the source and does not change. Speed is greater in water, and since λ = v ÷ f, the wavelength increases too.$mq$, $mq$hard$mq$),
($mq$Two students compare an oscilloscope trace for a violin note and a flute note of the same pitch and loudness. The shapes differ. What is the best explanation?$mq$, $mq$["The notes must have different frequencies","The notes must have different amplitudes","One note is a transverse wave and the other is longitudinal","The instruments have different quality (timbre) from the mix of extra vibrations they produce"]$mq$, 3, $mq$Same frequency and amplitude give the same pitch and loudness. The wave shape reflects timbre, which depends on the instrument.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Wave Properties and Sound$mq$ and p.name = $mq$Waves, Light and Sound$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Transverse wave$mq$, $mq$Vibrations are at right angles to the direction of energy transfer, e.g. light and water ripples. They have crests and troughs.$mq$),
($mq$Longitudinal wave$mq$, $mq$Vibrations are parallel to the direction of energy transfer. Sound is an example, with compressions and rarefactions.$mq$),
($mq$Wave equation$mq$, $mq$v = f × λ: wave speed (m/s) = frequency (Hz) × wavelength (m).$mq$),
($mq$Frequency and period$mq$, $mq$Frequency is waves per second (Hz). Period is time for one wave: T = 1 ÷ f.$mq$),
($mq$What does amplitude affect in sound?$mq$, $mq$Loudness. A bigger amplitude means a louder sound. Pitch depends on frequency, not amplitude.$mq$),
($mq$Range of human hearing$mq$, $mq$About 20 Hz to 20 000 Hz. Above this is ultrasound; below is infrasound.$mq$),
($mq$Why does sound travel faster in solids?$mq$, $mq$Particles are closer together and strongly bonded, so vibrations are passed on more quickly than in liquids or gases.$mq$),
($mq$Echo distance$mq$, $mq$Distance = speed × time ÷ 2, because the sound travels to the surface and back.$mq$),
($mq$What changes when a wave enters a new medium?$mq$, $mq$Speed and wavelength change. Frequency stays the same because it is set by the source.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Wave Properties and Sound$mq$ and p.name = $mq$Waves, Light and Sound$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is a wave?
A wave is a way of transferring energy from one place to another without transferring matter. When sound travels from a speaker to your ear, the air particles only vibrate backwards and forwards about a fixed position. The energy moves; the air does not travel with it.

## Two types of wave
- **Transverse waves**: the vibrations are at right angles to the direction the wave travels. Water ripples, light and a wave on a rope are examples. They have crests and troughs.
- **Longitudinal waves**: the vibrations are parallel to the direction of travel. Sound is the main example. They have compressions (particles squashed together) and rarefactions (particles spread apart).

## Wave quantities
- **Amplitude**: the maximum displacement from the rest position. It relates to the energy carried, and to loudness in sound.
- **Wavelength (λ)**: the distance between two matching points on neighbouring waves, measured in metres.
- **Frequency (f)**: the number of complete waves per second, measured in hertz (Hz). It controls the pitch of a sound.
- **Period (T)**: the time for one wave, T = 1 ÷ f.
- **Wave speed (v)**: how fast the wave moves. The wave equation is v = f × λ.

Worked example: a note has a frequency of 400 Hz and a wavelength of 0.85 m in air. Speed = 400 × 0.85 = 340 m/s.

## Sound in more detail
Sound is made by vibrating objects and needs a medium, so it cannot travel through a vacuum. It travels fastest in solids (steel about 5000 m/s), slower in liquids (water about 1500 m/s) and slowest in gases (air about 340 m/s) because particles are closer together in denser materials.
Humans hear roughly 20 Hz to 20 000 Hz. Higher than that is **ultrasound**, which is used for medical scans, cleaning jewellery and sonar. When a wave moves into a new medium its frequency stays the same, but its speed and wavelength change.

## Echoes and distance
An echo is sound reflected from a hard surface. Because the sound goes there and back, use distance = speed × time ÷ 2. If an echo returns after 0.60 s in air, the surface is 340 × 0.60 ÷ 2 = 102 m away.

## Common mistakes
- Saying that louder sounds are higher in pitch. Loudness is amplitude; pitch is frequency.
- Forgetting to halve the time for echo and sonar questions.
- Thinking the air travels from the speaker to your ear. Only the energy does.
- Mixing up period and frequency.

## How this is examined
Questions usually give a context such as sonar on a ship, a medical ultrasound scan or an investigation into the speed of sound. You may be asked to pull values out of the stimulus, use v = fλ or distance = speed × time, interpret an oscilloscope trace, and then evaluate the method: why reaction time causes error, how to repeat readings, and how to improve accuracy. Criterion D style items also ask how ultrasound or sonar helps society.

Exam tip: Write down the equation, substitute with units, and check whether the sound makes a round trip before you divide. Always state which property (amplitude or frequency) explains loudness and pitch.$mq$ from st;

-- Waves, Light and Sound > Light, Reflection and Refraction
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Waves, Light and Sound$mq$, 5, 5 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Light, Reflection and Refraction$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Waves, Light and Sound$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Light, Reflection and Refraction$mq$ and p.name = $mq$Waves, Light and Sound$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$A ray of light hits a plane mirror. Which statement is the law of reflection?$mq$, $mq$["The angle of incidence equals the angle of reflection","The angle of incidence is half the angle of reflection","The angle of reflection is always 90°","The reflected ray follows the normal"]$mq$, 0, $mq$Both angles are measured from the normal, and the law of reflection says they are equal.$mq$, $mq$easy$mq$),
($mq$What describes the image formed by a plane mirror?$mq$, $mq$["Real, inverted and smaller","Virtual, inverted and larger","Real, upright and the same size","Virtual, upright and the same size as the object"]$mq$, 3, $mq$A plane mirror makes a virtual image (it cannot be projected on a screen) that is upright, same size and as far behind the mirror as the object is in front.$mq$, $mq$easy$mq$),
($mq$What is the approximate speed of light in a vacuum?$mq$, $mq$["3.4 × 10² m/s","3.0 × 10⁶ m/s","3.0 × 10⁸ m/s","3.0 × 10¹⁰ m/s"]$mq$, 2, $mq$Light travels at about 300 000 000 m/s in a vacuum. 340 m/s is the speed of sound in air.$mq$, $mq$easy$mq$),
($mq$What is refraction?$mq$, $mq$["The bouncing of light off a surface","The change in direction of light when its speed changes on entering another medium","The splitting of light into separate colours only","The absorption of light by a surface"]$mq$, 1, $mq$Refraction happens because light changes speed at a boundary between materials, causing it to bend (unless it enters along the normal).$mq$, $mq$easy$mq$),
($mq$A ray of light passes from air into a glass block at an angle. What happens to it?$mq$, $mq$["It bends towards the normal","It bends away from the normal","It continues in a straight line","It reflects back into the air only"]$mq$, 0, $mq$Glass is optically denser than air, so light slows down and bends towards the normal.$mq$, $mq$easy$mq$),
($mq$A ray strikes a plane mirror so that it makes an angle of 30° with the mirror surface. What is the angle between the incident ray and the reflected ray?$mq$, $mq$["60°","30°","90°","120°"]$mq$, 3, $mq$The angle of incidence is measured from the normal: 90° − 30° = 60°. The reflected angle is also 60°, so the angle between the rays is 120°.$mq$, $mq$medium$mq$),
($mq$Kofi stands 2.5 m in front of a plane mirror. How far is he from his image?$mq$, $mq$["2.5 m","1.25 m","5.0 m","7.5 m"]$mq$, 2, $mq$The image is as far behind the mirror as the object is in front: 2.5 m + 2.5 m = 5.0 m.$mq$, $mq$medium$mq$),
($mq$A ray inside a glass block reaches the glass-air boundary at an angle larger than the critical angle. What happens?$mq$, $mq$["Refraction away from the normal","Total internal reflection","Absorption of the light","The ray travels along the normal"]$mq$, 1, $mq$When light moves from a denser to a less dense medium at an angle above the critical angle, all of it is reflected back inside.$mq$, $mq$medium$mq$),
($mq$A student measures an angle of incidence of 40° and an angle of refraction of 25° for light entering a block. Use n = sin i ÷ sin r. What is the refractive index (2 d.p.)?$mq$, $mq$["1.52","1.60","0.66","1.88"]$mq$, 0, $mq$sin 40° = 0.643 and sin 25° = 0.423, so n = 0.643 ÷ 0.423 = 1.52.$mq$, $mq$medium$mq$),
($mq$Parallel rays of light hit a converging (convex) lens. Where do they meet?$mq$, $mq$["At the optical centre of the lens","At the lens surface","They never meet","At the principal focus"]$mq$, 3, $mq$A converging lens brings parallel rays to a point called the principal focus.$mq$, $mq$medium$mq$),
($mq$Why does a straw in a glass of water look bent at the surface?$mq$, $mq$["Water reflects light in the straw","The straw really bends in water","Light is refracted as it leaves the water into air","Light travels faster in water than in air"]$mq$, 2, $mq$Light from the submerged part bends as it exits the water, so the part below appears in a different position.$mq$, $mq$medium$mq$),
($mq$Which is a use of total internal reflection?$mq$, $mq$["Plane mirrors in bathrooms","Optical fibres carrying data","Sunglasses blocking UV","Pinhole cameras"]$mq$, 1, $mq$Light stays inside the glass core of an optical fibre by repeated total internal reflection.$mq$, $mq$medium$mq$),
($mq$Two groups compare how much different glass blocks bend light. Which variable must they keep the same to make it a fair test?$mq$, $mq$["The angle of incidence","The refractive index","The angle of refraction","The type of glass"]$mq$, 0, $mq$The angle of incidence should be controlled. The glass type is the independent variable and the angle of refraction is the dependent variable.$mq$, $mq$medium$mq$),
($mq$The refractive index of a glass is 1.50. What is its critical angle (to the nearest degree)?$mq$, $mq$["48°","34°","56°","42°"]$mq$, 3, $mq$sin c = 1 ÷ n = 1 ÷ 1.50 = 0.667, so c = 41.8°, which rounds to 42°.$mq$, $mq$hard$mq$),
($mq$A ray enters water (n = 1.33) from air at an angle of incidence of 45°. What is the angle of refraction?$mq$, $mq$["34°","60°","32°","45°"]$mq$, 2, $mq$sin r = sin 45° ÷ 1.33 = 0.532, so r = 32.1°. It must be less than 45° because the ray bends towards the normal.$mq$, $mq$hard$mq$),
($mq$The refractive index of a glass is 1.50 and the speed of light in a vacuum is 3.0 × 10⁸ m/s. Using n = c ÷ v, what is the speed of light in the glass?$mq$, $mq$["4.5 × 10⁸ m/s","2.0 × 10⁸ m/s","1.5 × 10⁸ m/s","2.0 × 10⁶ m/s"]$mq$, 1, $mq$v = c ÷ n = 3.0 × 10⁸ ÷ 1.50 = 2.0 × 10⁸ m/s. Light slows in glass.$mq$, $mq$hard$mq$),
($mq$White light passes through a glass prism and spreads into a spectrum. Which statement is the best explanation?$mq$, $mq$["Different colours travel at different speeds in glass, so they refract by different amounts","The prism adds colours to the light","Red light is reflected and violet is refracted","Only violet light slows down in glass"]$mq$, 0, $mq$Each colour has a slightly different refractive index in glass. Violet slows most and bends most, red least.$mq$, $mq$hard$mq$),
($mq$A student reads an angle of incidence of 20° on a protractor with an uncertainty of ±1°. What is the percentage uncertainty, and how could it be reduced?$mq$, $mq$["1 %; repeat the readings","20 %; use a shorter ray","0.05 %; use a thicker block","5 %; use larger angles or a larger protractor"]$mq$, 3, $mq$1 ÷ 20 × 100 = 5 %. Larger angles make the same ±1° a smaller percentage, so accuracy improves.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Light, Reflection and Refraction$mq$ and p.name = $mq$Waves, Light and Sound$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Law of reflection$mq$, $mq$The angle of incidence equals the angle of reflection. Both are measured from the normal.$mq$),
($mq$Properties of a plane mirror image$mq$, $mq$Virtual, upright, same size as the object, and as far behind the mirror as the object is in front.$mq$),
($mq$What is the normal?$mq$, $mq$An imaginary line at 90° to the surface at the point where the ray hits. All angles are measured from it.$mq$),
($mq$Define refraction$mq$, $mq$The change in direction of a wave when it changes speed on moving from one medium into another.$mq$),
($mq$Bending in glass$mq$, $mq$Air to glass: light slows and bends towards the normal. Glass to air: light speeds up and bends away from it.$mq$),
($mq$Refractive index formulae$mq$, $mq$n = sin i ÷ sin r, and n = c ÷ v (speed of light in vacuum ÷ speed in the material).$mq$),
($mq$Critical angle$mq$, $mq$The angle of incidence in a dense medium above which total internal reflection happens. sin c = 1 ÷ n.$mq$),
($mq$Total internal reflection uses$mq$, $mq$Optical fibres for communications, endoscopes in medicine and prismatic reflectors in binoculars.$mq$),
($mq$What is dispersion?$mq$, $mq$The splitting of white light into colours because each colour refracts by a different amount. Violet bends most, red least.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Light, Reflection and Refraction$mq$ and p.name = $mq$Waves, Light and Sound$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Light and rays
Light is an electromagnetic wave that travels in straight lines through a uniform medium at about 3.0 × 10⁸ m/s in a vacuum. We draw light as rays. Light is a transverse wave and it does not need a medium to travel.

## Reflection
When light hits a smooth surface such as a mirror it bounces back. Angles are always measured from the **normal**, an imaginary line at 90° to the surface.
- **Law of reflection**: angle of incidence = angle of reflection.
- A plane mirror forms a **virtual** image. It is upright, the same size as the object, and as far behind the mirror as the object is in front. A virtual image cannot be projected on to a screen.
- Rough surfaces scatter light in many directions (diffuse reflection), which is why you can see a wall from any angle.

Worked example: a ray hits a mirror making 30° with the surface. The angle of incidence is 90° − 30° = 60°, so the angle of reflection is 60° and the angle between the two rays is 120°.

## Refraction
Light changes speed when it passes from one transparent medium into another, and this can change its direction. This is **refraction**.
- Into a denser medium (air to glass): light slows down and bends towards the normal.
- Into a less dense medium (glass to air): light speeds up and bends away from the normal.
- Along the normal: no change of direction, but still a change of speed.
The refractive index is n = sin i ÷ sin r, and also n = c ÷ v where v is the speed of light in the material. For glass with n = 1.50, v = 3.0 × 10⁸ ÷ 1.50 = 2.0 × 10⁸ m/s.

## Total internal reflection
If light moves from a denser to a less dense medium and the angle of incidence is bigger than the **critical angle**, all the light is reflected. The critical angle satisfies sin c = 1 ÷ n. For glass with n = 1.50, c = 42°. Optical fibres use this to carry telephone and internet signals, and endoscopes use them to see inside the body.

## Lenses and dispersion
A converging (convex) lens brings parallel rays to a point called the principal focus. White light is a mixture of colours. In a prism each colour has a slightly different speed in glass, so each refracts by a different amount; violet bends most and red least. This is **dispersion**, and it also makes rainbows.

## Common mistakes
- Measuring angles from the mirror or glass surface instead of from the normal.
- Saying the image in a mirror is real.
- Drawing the refracted ray bending the wrong way at the boundary.
- Using total internal reflection when light goes from a less dense into a denser medium.

## How this is examined
Questions are normally set in an investigation: students shine a ray box through a glass block, record angles and calculate the refractive index. You are asked to identify variables, process data, comment on accuracy (for example a ±1° reading error) and suggest improvements. Context items might be optical fibres in communications or periscopes in design.

Exam tip: Draw the normal first, mark every angle from it, and check that your refracted ray bends towards the normal when entering a denser material.$mq$ from st;

-- Waves, Light and Sound > The Electromagnetic Spectrum and Its Uses
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Waves, Light and Sound$mq$, 5, 5 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$The Electromagnetic Spectrum and Its Uses$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Waves, Light and Sound$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$The Electromagnetic Spectrum and Its Uses$mq$ and p.name = $mq$Waves, Light and Sound$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the correct order of the electromagnetic spectrum from lowest to highest frequency?$mq$, $mq$["Radio, microwave, infrared, visible, ultraviolet, X-ray, gamma","Gamma, X-ray, ultraviolet, visible, infrared, microwave, radio","Radio, infrared, microwave, visible, X-ray, ultraviolet, gamma","Microwave, radio, visible, infrared, ultraviolet, gamma, X-ray"]$mq$, 0, $mq$Frequency rises from radio waves to gamma rays, while wavelength falls.$mq$, $mq$easy$mq$),
($mq$What do all electromagnetic waves have in common?$mq$, $mq$["They have the same wavelength","They have the same frequency","They are all harmful to humans","They travel at the same speed in a vacuum"]$mq$, 3, $mq$All electromagnetic waves travel at 3.0 × 10⁸ m/s in a vacuum, but their frequencies and wavelengths differ.$mq$, $mq$easy$mq$),
($mq$Electromagnetic waves are which type of wave?$mq$, $mq$["Longitudinal","Compression","Transverse","Mechanical"]$mq$, 2, $mq$EM waves are transverse and can travel through a vacuum, unlike mechanical sound waves.$mq$, $mq$easy$mq$),
($mq$Which type of electromagnetic wave does a television remote control use?$mq$, $mq$["Ultraviolet","Infrared","X-rays","Gamma rays"]$mq$, 1, $mq$Remote controls send pulses of infrared radiation to the television.$mq$, $mq$easy$mq$),
($mq$Which radiation is used to take images of broken bones?$mq$, $mq$["X-rays","Radio waves","Microwaves","Infrared"]$mq$, 0, $mq$X-rays pass through soft tissue but are absorbed by dense bone, giving an image.$mq$, $mq$easy$mq$),
($mq$A radio station broadcasts at 100 MHz (1.0 × 10⁸ Hz). The speed of radio waves is 3.0 × 10⁸ m/s. What is the wavelength?$mq$, $mq$["0.33 m","3.0 × 10¹⁶ m","30 m","3.0 m"]$mq$, 3, $mq$λ = v ÷ f = 3.0 × 10⁸ ÷ 1.0 × 10⁸ = 3.0 m.$mq$, $mq$medium$mq$),
($mq$Why is too much exposure to ultraviolet radiation harmful?$mq$, $mq$["It heats the body’s internal organs","It makes objects radioactive","It can damage skin cells and cause sunburn and skin cancer","It blocks blood flow"]$mq$, 2, $mq$UV carries enough energy per photon to damage DNA in skin cells. Sunscreen and clothing reduce exposure.$mq$, $mq$medium$mq$),
($mq$How does a microwave oven heat food?$mq$, $mq$["The oven walls become hot and conduct heat","Water molecules in the food absorb the microwaves and heat up","The microwaves make the food radioactive","Microwaves turn the food into steam directly"]$mq$, 1, $mq$Microwave radiation is absorbed by water molecules, transferring energy as heat inside the food.$mq$, $mq$medium$mq$),
($mq$Which use matches the radiation correctly?$mq$, $mq$["Gamma rays: sterilising medical equipment","Radio waves: toasting bread","Ultraviolet: mobile phone calls","Infrared: seeing broken bones"]$mq$, 0, $mq$Gamma rays kill microbes and are used to sterilise sealed equipment. Toasters use infrared, phones use microwaves, and bones are imaged by X-rays.$mq$, $mq$medium$mq$),
($mq$Which radiation in the spectrum has the shortest wavelength?$mq$, $mq$["Radio waves","Ultraviolet","Visible light","Gamma rays"]$mq$, 3, $mq$Wavelength decreases as frequency increases, so gamma rays have the shortest wavelength.$mq$, $mq$medium$mq$),
($mq$Which statement about visible light is correct?$mq$, $mq$["Violet has a longer wavelength than red","All colours have the same wavelength","Red has a longer wavelength than violet","Visible light has the longest wavelength in the spectrum"]$mq$, 2, $mq$Visible wavelengths range from about 400 nm (violet) to 700 nm (red).$mq$, $mq$medium$mq$),
($mq$Light has a frequency of 5.0 × 10¹⁴ Hz. What is its wavelength in nanometres? (c = 3.0 × 10⁸ m/s)$mq$, $mq$["60 nm","600 nm","6000 nm","1.5 × 10²³ nm"]$mq$, 1, $mq$λ = 3.0 × 10⁸ ÷ 5.0 × 10¹⁴ = 6.0 × 10⁻⁷ m = 600 nm.$mq$, $mq$medium$mq$),
($mq$Which group contains only ionising radiations?$mq$, $mq$["Ultraviolet (high end), X-rays and gamma rays","Radio waves, microwaves and infrared","Visible light and infrared","Microwaves and X-rays"]$mq$, 0, $mq$X-rays, gamma rays and the high-energy end of UV can remove electrons from atoms, which damages cells.$mq$, $mq$medium$mq$),
($mq$An X-ray has a wavelength of 0.10 nm (1.0 × 10⁻¹⁰ m). What is its frequency? (c = 3.0 × 10⁸ m/s)$mq$, $mq$["3.0 × 10⁻² Hz","3.3 × 10⁻¹⁹ Hz","3.0 × 10¹⁷ Hz","3.0 × 10¹⁸ Hz"]$mq$, 3, $mq$f = v ÷ λ = 3.0 × 10⁸ ÷ 1.0 × 10⁻¹⁰ = 3.0 × 10¹⁸ Hz.$mq$, $mq$hard$mq$),
($mq$Radiation A has wavelength 2 × 10⁻⁷ m, B has 5 × 10⁻⁷ m and C has 1 × 10⁻³ m. Which carries the most energy per photon and why?$mq$, $mq$["C, because it has the longest wavelength","B, because it is visible","A, because it has the highest frequency","They are equal because they all travel at c"]$mq$, 2, $mq$Energy per photon rises with frequency. A has the shortest wavelength so the highest frequency (1.5 × 10¹⁵ Hz), in the ultraviolet region.$mq$, $mq$hard$mq$),
($mq$A signal is sent from a ground station to a satellite 3.6 × 10⁷ m above and back. How long does the round trip take? (c = 3.0 × 10⁸ m/s)$mq$, $mq$["0.12 s","0.24 s","7.2 s","0.024 s"]$mq$, 1, $mq$Distance = 2 × 3.6 × 10⁷ = 7.2 × 10⁷ m. Time = 7.2 × 10⁷ ÷ 3.0 × 10⁸ = 0.24 s.$mq$, $mq$hard$mq$),
($mq$Dental X-ray staff stand behind a lead screen and patients wear a lead apron. What is the best evaluation of this practice?$mq$, $mq$["It limits exposure to ionising radiation to keep the risk low compared with the diagnostic benefit","It stops X-rays being produced","It makes the X-ray image clearer","It converts X-rays into harmless light"]$mq$, 0, $mq$Lead absorbs X-rays. The risk of cell damage is balanced against the benefit of a diagnosis, so exposure is kept as low as practical.$mq$, $mq$hard$mq$),
($mq$A hospital sterilises sealed syringes with gamma rays instead of steam. Which is the main advantage?$mq$, $mq$["Gamma rays are cheaper and need no safety precautions","Gamma rays make the syringes radioactive and safer","Steam cannot kill bacteria","Gamma rays pass through packaging and sterilise without heating the plastic"]$mq$, 3, $mq$Gamma rays penetrate the sealed package and kill microbes without melting plastic. The source still needs careful shielding.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$The Electromagnetic Spectrum and Its Uses$mq$ and p.name = $mq$Waves, Light and Sound$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Order of the EM spectrum$mq$, $mq$Radio, microwave, infrared, visible, ultraviolet, X-ray, gamma: frequency and energy increase, wavelength decreases.$mq$),
($mq$Speed of EM waves$mq$, $mq$All travel at 3.0 × 10⁸ m/s in a vacuum.$mq$),
($mq$Wave equation for EM waves$mq$, $mq$c = f × λ, so λ = 3.0 × 10⁸ ÷ f. Convert nm to m by multiplying by 10⁻⁹.$mq$),
($mq$Uses of radio waves and microwaves$mq$, $mq$Radio: broadcasting. Microwaves: mobile phones, satellite links, Wi-Fi and cooking food.$mq$),
($mq$Uses of infrared$mq$, $mq$Remote controls, thermal imaging cameras, electric grills and heaters, and some night-vision systems.$mq$),
($mq$Dangers of UV$mq$, $mq$Can cause sunburn, eye damage and skin cancer by damaging DNA in cells.$mq$),
($mq$Uses of X-rays$mq$, $mq$Imaging bones and teeth, and airport security scanners. They pass through soft tissue but not dense bone.$mq$),
($mq$Uses of gamma rays$mq$, $mq$Treating cancer, sterilising medical equipment and food packaging, and tracers in medicine.$mq$),
($mq$What is ionising radiation?$mq$, $mq$Radiation with enough energy to remove electrons from atoms: high-end UV, X-rays and gamma rays. It can damage cells.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$The Electromagnetic Spectrum and Its Uses$mq$ and p.name = $mq$Waves, Light and Sound$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## One family of waves
The electromagnetic (EM) spectrum is a family of transverse waves that carry energy as oscillating electric and magnetic fields. All EM waves travel at the same speed in a vacuum, 3.0 × 10⁸ m/s, and can travel without a medium. They differ in wavelength and frequency.

## The order of the spectrum
From longest wavelength (lowest frequency) to shortest wavelength (highest frequency):
- **Radio waves**: broadcasting, radar and communications.
- **Microwaves**: mobile phones, Wi-Fi, satellite signals and cooking.
- **Infrared**: remote controls, thermal imaging, grills and toasters.
- **Visible light**: seeing, photography and optical fibres.
- **Ultraviolet (UV)**: sterilising water, detecting forged banknotes and sun tanning.
- **X-rays**: medical imaging and airport security.
- **Gamma rays**: treating cancer and sterilising equipment.
A memory aid: Really Mad Instructors Verbally Undermine Xylophone Games.

## The wave equation still works
For every EM wave, v = f × λ with v = 3.0 × 10⁸ m/s.
Worked example: a Wi-Fi signal has frequency 2.4 × 10⁹ Hz. Its wavelength is 3.0 × 10⁸ ÷ 2.4 × 10⁹ = 0.125 m. A visible light wave of 600 nm (6.0 × 10⁻⁷ m) has frequency 3.0 × 10⁸ ÷ 6.0 × 10⁻⁷ = 5.0 × 10¹⁴ Hz.

## Energy and danger
The higher the frequency, the more energy each photon carries. Radio, microwave and infrared are non-ionising. Ultraviolet, X-rays and gamma rays carry enough energy to damage cells and DNA, which can cause burns, mutations and cancer.
- UV: sunburn, eye damage and skin cancer. Use sunscreen, hats and sunglasses.
- X-rays and gamma rays: ionising. Staff use shielding and limit exposure time, and patients only have scans when the benefit outweighs the small risk.
- Microwaves: heating effect. Phone signals are low in power, and the current evidence is that they do not cause health damage at normal exposure.

## Applications and society
EM waves make modern life possible, from satellites carrying television to hospitals imaging patients. Every technology has risk and benefit. A student answering a criterion D question should weigh up the benefit (earlier diagnosis, communication across the world) against risk (exposure, cost, access) and say who is affected.

## Common mistakes
- Saying gamma rays are slower than radio waves. They all travel at the same speed in a vacuum.
- Confusing wavelength with frequency: short wavelength means high frequency.
- Saying all EM waves are dangerous. Radio waves are not ionising.
- Writing nanometres in the equation without converting to metres.

## How this is examined
Typical items give a context such as a satellite link, a hospital imaging department or a solar-protection campaign. You are asked to order waves, use v = fλ with standard form, explain why a particular wave suits a use, and evaluate risk against benefit for society.

Exam tip: Convert units to metres and hertz before calculating, and link every use to the property of that wave (for example, penetration or absorption), not just its name.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('integrated-science')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;