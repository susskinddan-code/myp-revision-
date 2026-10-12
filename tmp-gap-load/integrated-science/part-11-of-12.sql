-- Part 11 of 12: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Earth, Atmosphere and Space > The Atmosphere and Climate Change
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Earth, Atmosphere and Space$mq$, 5, 11 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$The Atmosphere and Climate Change$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Earth, Atmosphere and Space$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$The Atmosphere and Climate Change$mq$ and p.name = $mq$Earth, Atmosphere and Space$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which gas makes up the largest proportion of the Earth's atmosphere?$mq$, $mq$["Nitrogen","Oxygen","Carbon dioxide","Argon"]$mq$, 0, $mq$Nitrogen makes up about 78% of dry air, oxygen about 21%.$mq$, $mq$easy$mq$),
($mq$Which of these is a greenhouse gas?$mq$, $mq$["Nitrogen","Argon","Helium","Methane"]$mq$, 3, $mq$Methane, carbon dioxide, water vapour and nitrous oxide absorb infrared radiation and warm the atmosphere. Nitrogen and argon do not.$mq$, $mq$easy$mq$),
($mq$Which layer of the atmosphere contains the ozone layer?$mq$, $mq$["Troposphere","The ground","Stratosphere","Ocean surface"]$mq$, 2, $mq$The ozone layer is in the stratosphere and absorbs much of the Sun's harmful ultraviolet radiation.$mq$, $mq$easy$mq$),
($mq$Which human activity adds the most carbon dioxide to the atmosphere?$mq$, $mq$["Planting forests","Burning fossil fuels","Using wind turbines","Recycling glass"]$mq$, 1, $mq$Burning coal, oil and gas for electricity, transport and heating is the largest source of extra CO₂.$mq$, $mq$easy$mq$),
($mq$Which of these is an expected effect of global warming?$mq$, $mq$["Rising sea level","Smaller deserts everywhere","Colder oceans","More ice in all regions"]$mq$, 0, $mq$Melting land ice and thermal expansion of water cause sea level to rise.$mq$, $mq$easy$mq$),
($mq$Which statement best describes the greenhouse effect?$mq$, $mq$["The Earth is covered by a glass layer","The Sun gets hotter","Ozone traps heat from the ground","Greenhouse gases absorb and re-emit infrared radiation, warming the Earth"]$mq$, 3, $mq$The Earth emits infrared radiation. Greenhouse gases absorb some of it and re-emit it in all directions, including back down.$mq$, $mq$medium$mq$),
($mq$The ozone layer has been damaged mainly by$mq$, $mq$["carbon dioxide from cars","oxygen from plants","CFCs from old fridges and aerosols","nitrogen from fertilisers"]$mq$, 2, $mq$Chlorine-containing CFCs break down ozone. The Montreal Protocol of 1987 phased out most of them.$mq$, $mq$medium$mq$),
($mq$Sulfur dioxide from burning fuels causes which problem?$mq$, $mq$["Ozone depletion","Acid rain","Rising sea level","Greater sunlight"]$mq$, 1, $mq$Sulfur dioxide dissolves in rain to form acidic solutions, damaging trees, lakes and buildings. Carbon dioxide, in contrast, is linked to global warming.$mq$, $mq$medium$mq$),
($mq$Atmospheric CO₂ was about 280 parts per million before industrialisation and is now about 420 parts per million. What is the percentage increase?$mq$, $mq$["50%","33%","140%","67%"]$mq$, 0, $mq$(420 − 280) ÷ 280 × 100 = 50%.$mq$, $mq$medium$mq$),
($mq$Why are air bubbles trapped in ice cores useful to scientists?$mq$, $mq$["They show the colour of the sky","They show what animals ate","They show where the glacier will move","They give a record of past atmospheric gases"]$mq$, 3, $mq$Ice cores contain trapped air from thousands of years ago, so scientists can measure past CO₂ and temperature.$mq$, $mq$medium$mq$),
($mq$Which statement correctly separates weather and climate?$mq$, $mq$["Weather is the average over decades","They mean the same","Climate is the average weather over many years","Climate changes every hour"]$mq$, 2, $mq$Weather is the short-term state of the atmosphere. Climate is the long-term average, usually over 30 years or more.$mq$, $mq$medium$mq$),
($mq$A student tests the greenhouse effect with two identical bottles, one with air and one with extra CO₂, under a lamp. After 20 minutes the CO₂ bottle is 2.1°C warmer. What would improve the investigation?$mq$, $mq$["Use different sized bottles","Repeat several times and use temperature probes with the same lamp distance","Move the lamp closer to one bottle","Measure the temperature only once"]$mq$, 1, $mq$Repeats reduce random error, and controlling variables such as distance and bottle size keeps the test fair.$mq$, $mq$medium$mq$),
($mq$Which pair correctly matches a gas to its main source?$mq$, $mq$["Methane: cattle and rice fields","Carbon dioxide: refrigerants","CFCs: respiration","Sulfur dioxide: photosynthesis"]$mq$, 0, $mq$Methane comes from livestock digestion, rice paddies and landfill. CFCs came from old refrigerants and aerosols.$mq$, $mq$medium$mq$),
($mq$A graph shows global average temperature and CO₂ both rising steadily over 100 years. Which statement is most appropriate?$mq$, $mq$["The data prove CO₂ is the only cause","The data show there is no link","The data are useless because both rose","The data show a correlation, and the greenhouse effect gives a mechanism linking them"]$mq$, 3, $mq$A correlation alone does not prove a cause, but the known greenhouse mechanism and other evidence supports a link. Other factors also matter.$mq$, $mq$hard$mq$),
($mq$Why does a rise in sea level occur even before all land ice melts?$mq$, $mq$["Fish breathe out more","Rivers flow faster","Warm water expands (thermal expansion)","Waves become larger"]$mq$, 2, $mq$As oceans warm they expand, which raises sea level in addition to meltwater from glaciers and ice sheets.$mq$, $mq$hard$mq$),
($mq$A country plans to cut emissions by 40% from 500 million tonnes of CO₂ per year. What will be the new yearly emissions?$mq$, $mq$["200 million tonnes","300 million tonnes","460 million tonnes","340 million tonnes"]$mq$, 1, $mq$40% of 500 = 200, so the new level is 500 − 200 = 300 million tonnes.$mq$, $mq$hard$mq$),
($mq$Which action reduces the net CO₂ in the atmosphere in the long term while also preserving habitats?$mq$, $mq$["Protecting existing forests and reducing fossil fuel use","Cutting forests and planting a single crop","Burning wood for fuel","Draining peat bogs"]$mq$, 0, $mq$Forests store carbon and support biodiversity. Cutting emissions addresses the source. Draining peat releases stored carbon.$mq$, $mq$hard$mq$),
($mq$Why might a scientist be cautious about a claim based on a single hot summer?$mq$, $mq$["Hot summers never occur","Temperature cannot be measured","Summers are always the same","Climate is a long-term pattern, and one summer is weather"]$mq$, 3, $mq$One season shows weather variability. Climate trends need long-term data.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$The Atmosphere and Climate Change$mq$ and p.name = $mq$Earth, Atmosphere and Space$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Composition of dry air$mq$, $mq$About 78% nitrogen, 21% oxygen, about 1% argon, about 0.04% carbon dioxide, plus water vapour.$mq$),
($mq$Greenhouse gases$mq$, $mq$Carbon dioxide, methane, water vapour, nitrous oxide. They absorb and re-emit infrared radiation.$mq$),
($mq$Greenhouse effect steps$mq$, $mq$Sun's energy warms the Earth, the Earth emits infrared, greenhouse gases absorb and re-emit it, so the atmosphere warms.$mq$),
($mq$Sources of extra CO₂ and methane$mq$, $mq$CO₂: burning fossil fuels, deforestation. Methane: cattle, rice fields, landfill.$mq$),
($mq$Effects of global warming$mq$, $mq$Melting ice, rising sea level (including thermal expansion), extreme weather, habitat change.$mq$),
($mq$Ozone layer$mq$, $mq$In the stratosphere. Absorbs UV radiation. Damaged by CFCs, which were phased out by the Montreal Protocol (1987).$mq$),
($mq$Acid rain$mq$, $mq$Caused by sulfur dioxide and nitrogen oxides dissolving in rain. Damages trees, lakes and buildings.$mq$),
($mq$Ice cores$mq$, $mq$Air bubbles trapped in ice give a record of past atmospheric gases and temperatures.$mq$),
($mq$Weather vs climate$mq$, $mq$Weather is short-term atmospheric conditions. Climate is the average over many years (30 or more).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$The Atmosphere and Climate Change$mq$ and p.name = $mq$Earth, Atmosphere and Space$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$The Earth is surrounded by a thin layer of gases called the atmosphere. It holds the oxygen we breathe, shields us from harmful radiation and controls the temperature of the planet.

## Composition and layers
Dry air is about **78% nitrogen**, **21% oxygen**, about 1% argon and a tiny amount (about 0.04%) of carbon dioxide, along with variable water vapour. The lowest layer, the **troposphere**, is where weather happens. Above it the **stratosphere** contains the **ozone layer**, which absorbs much of the Sun's ultraviolet (UV) radiation. UV can damage DNA and cause skin cancer.

## The greenhouse effect
The Sun's energy passes through the atmosphere and warms the surface. The Earth emits infrared radiation. **Greenhouse gases** such as carbon dioxide, methane, water vapour and nitrous oxide absorb some of this infrared and re-emit it in all directions, including back towards the ground. This natural greenhouse effect keeps the Earth warm enough for life. Without it, the average temperature would be far below freezing.

## The enhanced greenhouse effect and climate change
Human activity has increased the concentration of greenhouse gases.
- **Burning fossil fuels** (coal, oil, gas) releases CO₂.
- **Deforestation** reduces photosynthesis and releases carbon.
- **Farming** releases methane from cattle and rice fields.
Atmospheric CO₂ has risen from about 280 parts per million before industrialisation to about 420 parts per million. Percentage increase = (420 − 280) ÷ 280 × 100 = 50%. Global average temperatures have risen. Possible consequences include melting glaciers and ice sheets, sea level rise (from meltwater and thermal expansion of seawater), more extreme weather, changes to habitats and pressure on food and water supplies.

## Evidence
Scientists use direct measurements of temperature and CO₂, ice cores (trapped air bubbles that record past gases), tree rings, ocean data and satellite observations. A correlation between two variables does not prove a cause, but the known mechanism of the greenhouse effect plus many separate lines of evidence give confidence in the link.

## Other atmospheric problems
- **Ozone depletion**: CFCs from old refrigerators and aerosols release chlorine in the stratosphere, destroying ozone. The 1987 Montreal Protocol phased out most CFCs, and the ozone layer is slowly recovering.
- **Acid rain**: sulfur dioxide and nitrogen oxides from burning fuels dissolve in rain to form acids that damage trees, lakes and stonework.

## Solutions
Use renewable energy, improve energy efficiency, use public transport, protect forests, reduce waste and agree on international targets. Each has costs and benefits, and different countries have different capacities to act.

## How this is examined
Look for a context such as a coastal city, a data table of CO₂ levels or a classroom bottle experiment. You may need to calculate percentage change, describe a trend, explain the greenhouse effect in steps, plan a fair test, and evaluate whether data supports a claim. Be careful to distinguish weather from climate, and global warming from ozone depletion, which are different problems.

## Common mistakes
- Saying the ozone hole causes global warming.
- Saying that greenhouse gases "trap heat" without mentioning that they absorb and re-emit infrared radiation.
- Claiming correlation proves a cause.

Exam tip: Describe the greenhouse effect in steps: Sun's energy reaches the Earth, the Earth emits infrared, greenhouse gases absorb and re-emit it, so the atmosphere warms. When evaluating evidence, mention the sample size, the time period and whether the data come from reliable sources.$mq$ from st;

-- Earth, Atmosphere and Space > Radioactivity and Atomic Structure
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Earth, Atmosphere and Space$mq$, 5, 11 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Radioactivity and Atomic Structure$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Earth, Atmosphere and Space$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Radioactivity and Atomic Structure$mq$ and p.name = $mq$Earth, Atmosphere and Space$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the charge of a proton?$mq$, $mq$["Positive","Negative","Neutral","It varies"]$mq$, 0, $mq$Protons are positively charged, neutrons have no charge and electrons are negatively charged.$mq$, $mq$easy$mq$),
($mq$Which particles are found in the nucleus of an atom?$mq$, $mq$["Protons and electrons","Neutrons and electrons","Only electrons","Protons and neutrons"]$mq$, 3, $mq$The nucleus contains protons and neutrons. Electrons occupy energy levels around it.$mq$, $mq$easy$mq$),
($mq$Which type of radiation is the most penetrating?$mq$, $mq$["Alpha","Beta","Gamma","All are equal"]$mq$, 2, $mq$Gamma rays pass through most materials and need thick lead or concrete to reduce them. Alpha is stopped by paper.$mq$, $mq$easy$mq$),
($mq$What instrument is used to detect radioactivity?$mq$, $mq$["Voltmeter","Geiger–Müller counter","Thermometer","Ammeter"]$mq$, 1, $mq$A Geiger–Müller tube detects ionising radiation and a counter shows the count rate.$mq$, $mq$easy$mq$),
($mq$An alpha particle is the same as$mq$, $mq$["a helium nucleus","an electron","a proton","a neutron"]$mq$, 0, $mq$An alpha particle has 2 protons and 2 neutrons, the same as a helium nucleus.$mq$, $mq$easy$mq$),
($mq$An atom has 11 protons and 12 neutrons. What is its mass number?$mq$, $mq$["11","12","1","23"]$mq$, 3, $mq$Mass number = protons + neutrons = 11 + 12 = 23.$mq$, $mq$medium$mq$),
($mq$Two atoms are isotopes of the same element. What is the same?$mq$, $mq$["The number of neutrons","The mass number","The number of protons","The total number of particles"]$mq$, 2, $mq$Isotopes have the same atomic number (protons) but different numbers of neutrons.$mq$, $mq$medium$mq$),
($mq$A radioactive source has a half-life of 3 days. Its mass is 80 g. How much of the radioactive isotope remains after 9 days?$mq$, $mq$["40 g","10 g","26.7 g","0 g"]$mq$, 1, $mq$9 days is 3 half-lives. 80 → 40 → 20 → 10 g.$mq$, $mq$medium$mq$),
($mq$A radioactive source has a count rate of 800 counts per minute, which falls to 100 counts per minute in 24 hours. What is the half-life?$mq$, $mq$["8 hours","12 hours","24 hours","6 hours"]$mq$, 0, $mq$800 → 400 → 200 → 100 is 3 half-lives, so 24 ÷ 3 = 8 hours. (Count rates should be corrected for background radiation.)$mq$, $mq$medium$mq$),
($mq$A student measures a count rate of 45 counts per minute with no source nearby. What is this called?$mq$, $mq$["Half-life","Alpha emission","Contamination","Background radiation"]$mq$, 3, $mq$Background radiation comes from natural sources such as rocks, cosmic rays and radon gas, and must be subtracted from readings.$mq$, $mq$medium$mq$),
($mq$Radium-226 (atomic number 88) emits an alpha particle. What are the mass number and atomic number of the new nucleus?$mq$, $mq$["Mass 226, atomic number 89","Mass 230, atomic number 90","Mass 222, atomic number 86","Mass 222, atomic number 88"]$mq$, 2, $mq$An alpha particle removes 4 from the mass number and 2 from the atomic number, so 226 − 4 = 222 and 88 − 2 = 86.$mq$, $mq$medium$mq$),
($mq$Which use of radiation relies on its ability to kill living cells?$mq$, $mq$["Smoke alarm","Sterilising medical equipment","Thickness gauge for paper","Dating rocks"]$mq$, 1, $mq$Gamma radiation sterilises equipment by killing bacteria. A smoke alarm uses alpha ionisation of air.$mq$, $mq$medium$mq$),
($mq$A student says 'After two half-lives, all the radioactive atoms have decayed.' What is wrong with this?$mq$, $mq$["After two half-lives, one quarter remains","After two half-lives, half remains","After two half-lives, none remains","Half-life is the time for all atoms to decay"]$mq$, 0, $mq$Each half-life halves the number of remaining radioactive atoms: 1/2, then 1/4. The process is random but predictable for large numbers.$mq$, $mq$medium$mq$),
($mq$Why is a source that emits only alpha radiation more dangerous inside the body than outside it?$mq$, $mq$["Alpha is more penetrating","Alpha is a gamma ray","Alpha has no charge","Alpha is strongly ionising and is not stopped by skin when it is inside"]$mq$, 3, $mq$Outside the body the skin stops alpha. Inside it, the particle deposits all its energy in nearby cells.$mq$, $mq$hard$mq$),
($mq$Carbon-14 has a half-life of 5 730 years. A wooden object has one quarter of the carbon-14 of a living tree. About how old is the object?$mq$, $mq$["5 730 years","22 920 years","11 460 years","17 190 years"]$mq$, 2, $mq$One quarter is 2 half-lives: 2 × 5 730 = 11 460 years.$mq$, $mq$hard$mq$),
($mq$Carbon-14 (atomic number 6) decays by beta emission. Which nucleus is formed?$mq$, $mq$["Carbon-13","Nitrogen-14 (atomic number 7)","Boron-14 (atomic number 5)","Oxygen-14"]$mq$, 1, $mq$In beta decay, a neutron becomes a proton, so the atomic number increases by 1 and the mass number stays 14. Nitrogen-14 has atomic number 7.$mq$, $mq$hard$mq$),
($mq$A hospital needs a medical tracer injected into a patient to image an organ. Which properties are most important?$mq$, $mq$["Emits gamma radiation and has a short half-life","Emits alpha and has a half-life of 1 000 years","Emits beta and is a solid that stays in the body for decades","Emits no radiation"]$mq$, 0, $mq$Gamma passes out of the body to be detected, and a short half-life means the radiation falls quickly, limiting the dose.$mq$, $mq$hard$mq$),
($mq$Workers who use radioactive sources wear badges and use lead shielding. Which combination of safety ideas is correct?$mq$, $mq$["Increase exposure time, stay close, remove shielding","Hold the source with bare hands to check it","Store it in a warm place","Limit exposure time, increase distance, use shielding"]$mq$, 3, $mq$Reduce time, increase distance and shield. Sources are handled with tongs and stored in lead-lined containers.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Radioactivity and Atomic Structure$mq$ and p.name = $mq$Earth, Atmosphere and Space$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Atomic number and mass number$mq$, $mq$Atomic number = number of protons. Mass number = protons + neutrons.$mq$),
($mq$Isotopes$mq$, $mq$Atoms of the same element (same protons) with different numbers of neutrons.$mq$),
($mq$Alpha particle$mq$, $mq$2 protons + 2 neutrons (helium nucleus). Strongly ionising, stopped by paper. Mass number −4, atomic number −2.$mq$),
($mq$Beta particle$mq$, $mq$A fast electron from the nucleus. Stopped by a few mm of aluminium. Atomic number +1, mass number unchanged.$mq$),
($mq$Gamma ray$mq$, $mq$Electromagnetic radiation. Most penetrating, reduced by thick lead or concrete. No change to the nucleus's mass number or atomic number.$mq$),
($mq$Half-life$mq$, $mq$The time for half the radioactive nuclei in a sample to decay, or for the count rate to halve.$mq$),
($mq$Background radiation$mq$, $mq$Radiation from natural and artificial sources (rocks, radon, cosmic rays). Subtract it from count rates.$mq$),
($mq$Carbon dating$mq$, $mq$Measures carbon-14 left in once-living material. Half-life 5 730 years. A quarter remaining means about 11 460 years.$mq$),
($mq$Radiation safety$mq$, $mq$Limit time, increase distance and use shielding (lead or concrete).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Radioactivity and Atomic Structure$mq$ and p.name = $mq$Earth, Atmosphere and Space$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Everything is made of atoms. Understanding the structure of the atom helps us explain radioactivity, which has important uses in medicine and industry as well as risks to health.

## Atomic structure
An atom has a tiny, dense **nucleus** containing **protons** and **neutrons**, with **electrons** moving around it in energy levels.
- Proton: relative charge +1, relative mass 1.
- Neutron: charge 0, relative mass 1.
- Electron: charge −1, negligible mass.
The **atomic number** is the number of protons. The **mass number** is protons plus neutrons. **Isotopes** are atoms of the same element with the same number of protons but different numbers of neutrons. For example, carbon-12 and carbon-14 both have 6 protons.

## Radioactive decay
Some nuclei are unstable and emit radiation to become more stable. This is random: we cannot predict when a single nucleus will decay, but for a large number we can predict how many will.
- **Alpha (α)**: a helium nucleus (2 protons, 2 neutrons). Strongly ionising, stopped by paper or a few centimetres of air. Mass number falls by 4 and atomic number by 2. Example: radium-226 (88 protons) becomes radon-222 (86 protons).
- **Beta (β)**: a fast electron from the nucleus (a neutron changes into a proton). Stopped by a few millimetres of aluminium. Atomic number rises by 1 and mass number stays the same. Example: carbon-14 (6) becomes nitrogen-14 (7).
- **Gamma (γ)**: electromagnetic radiation from the nucleus. Weakly ionising but very penetrating, and reduced by thick lead or concrete. No change in mass number or atomic number.
Ionising radiation can damage cells and DNA. High doses can cause radiation sickness, and lower doses can increase the risk of cancer.

## Half-life
The **half-life** is the time taken for half the radioactive nuclei in a sample to decay, or for the count rate to fall to half. Worked example: a sample of 80 g has a half-life of 3 days. After 9 days there are 3 half-lives, so the mass is 80 → 40 → 20 → 10 g. If a count rate falls from 800 to 100 counts per minute in 24 hours, that is 800 → 400 → 200 → 100, which is three half-lives, so the half-life is 8 hours. Always subtract **background radiation** (from rocks, radon gas, cosmic rays and medical sources) from readings first.

## Uses
- Smoke alarms use a source of alpha radiation.
- Medical tracers use gamma emitters with short half-lives.
- Radiotherapy uses gamma rays to destroy cancer cells.
- Sterilising food and equipment with gamma rays.
- Thickness control in paper mills uses beta radiation.
- Carbon dating: living things take in carbon-14, which decays after death. If a wooden object has a quarter of the original carbon-14, two half-lives of 5 730 years have passed, so it is about 11 460 years old.

## Safety
Reduce exposure by limiting time, keeping a distance and using shielding. Sources are handled with tongs and stored in lead-lined containers. Workers wear dosimeter badges.

## How this is examined
Questions use a context such as a hospital, a nuclear site or an archaeological dig. You may be given count-rate data and asked to find the half-life, evaluate which isotope is suitable for a purpose, or explain risks and benefits.

## Common mistakes
- Forgetting to subtract background radiation.
- Thinking half-life means all atoms decay in two half-lives.
- Mixing up radioactive decay with chemical reactions or with the Sun's radiation.

Exam tip: For half-life questions show each halving step. For suitability questions link the type of radiation and the half-life to the use, for example a tracer needs gamma and a short half-life.$mq$ from st;

-- Earth, Atmosphere and Space > The Solar System, Stars and the Big Bang
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Earth, Atmosphere and Space$mq$, 5, 11 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$The Solar System, Stars and the Big Bang$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Earth, Atmosphere and Space$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$The Solar System, Stars and the Big Bang$mq$ and p.name = $mq$Earth, Atmosphere and Space$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is at the centre of our Solar System?$mq$, $mq$["The Sun","The Earth","The Moon","Jupiter"]$mq$, 0, $mq$The Sun contains over 99% of the Solar System's mass and its gravity holds the planets in orbit.$mq$, $mq$easy$mq$),
($mq$Which planet is closest to the Sun?$mq$, $mq$["Venus","Earth","Mars","Mercury"]$mq$, 3, $mq$The order outward is Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune.$mq$, $mq$easy$mq$),
($mq$What is a galaxy?$mq$, $mq$["A single star","A planet and its moons","A huge group of stars, gas and dust held together by gravity","A cluster of comets only"]$mq$, 2, $mq$Our Sun is one of hundreds of billions of stars in the Milky Way galaxy.$mq$, $mq$easy$mq$),
($mq$What force keeps planets in orbit around the Sun?$mq$, $mq$["Friction","Gravity","Magnetism","Air resistance"]$mq$, 1, $mq$The Sun's gravitational attraction provides the centripetal force that keeps planets in orbit.$mq$, $mq$easy$mq$),
($mq$Which process releases energy in the Sun?$mq$, $mq$["Nuclear fusion","Nuclear fission","Burning of coal","Chemical respiration"]$mq$, 0, $mq$In the Sun's core, hydrogen nuclei fuse to form helium, releasing energy.$mq$, $mq$easy$mq$),
($mq$A light year is a unit of$mq$, $mq$["time","speed","brightness","distance"]$mq$, 3, $mq$A light year is the distance light travels in one year, about 9.46 × 10¹⁵ m.$mq$, $mq$medium$mq$),
($mq$Sunlight takes about 500 s to reach the Earth at a speed of 3.0 × 10⁸ m/s. What is the distance, using distance = speed × time?$mq$, $mq$["1.5 × 10⁶ m","6.0 × 10⁵ m","1.5 × 10¹¹ m","1.5 × 10⁹ m"]$mq$, 2, $mq$3.0 × 10⁸ × 500 = 1.5 × 10¹¹ m.$mq$, $mq$medium$mq$),
($mq$Why do we have seasons on Earth?$mq$, $mq$["The Earth is closer to the Sun in summer","The Earth's axis is tilted at about 23.5°","The Sun moves up and down","The Moon blocks sunlight"]$mq$, 1, $mq$The tilt changes the angle and length of daylight over the year. Distance from the Sun is not the cause.$mq$, $mq$medium$mq$),
($mq$On the Moon, gravitational field strength is about 1.6 N/kg, and on the Earth about 10 N/kg. What is the weight of a 60 kg astronaut on the Moon?$mq$, $mq$["96 N","600 N","60 N","37.5 N"]$mq$, 0, $mq$Weight = mass × g = 60 × 1.6 = 96 N. The mass stays 60 kg.$mq$, $mq$medium$mq$),
($mq$Which statement about the Big Bang theory is correct?$mq$, $mq$["The Big Bang was an explosion in space","The universe has always been the same size","The Big Bang happened 4.5 billion years ago","The universe began about 13.8 billion years ago and has been expanding since"]$mq$, 3, $mq$The Big Bang was the expansion of space itself from an extremely hot, dense state about 13.8 billion years ago. The Earth is about 4.5 billion years old.$mq$, $mq$medium$mq$),
($mq$Light from distant galaxies is shifted towards the red end of the spectrum. What does this suggest?$mq$, $mq$["The galaxies are moving towards us","The galaxies are stationary","The galaxies are moving away from us","The galaxies are cooling down"]$mq$, 2, $mq$Redshift means the wavelengths are stretched, which indicates that the galaxies are moving away, evidence for an expanding universe.$mq$, $mq$medium$mq$),
($mq$Which of these is the correct sequence for the life cycle of a star similar in mass to the Sun?$mq$, $mq$["Nebula, red giant, main sequence, supernova, black hole","Nebula, protostar, main sequence, red giant, white dwarf","Protostar, white dwarf, red giant, nebula","Main sequence, protostar, black hole, nebula"]$mq$, 1, $mq$A star like the Sun forms from a nebula, lives on the main sequence, expands into a red giant, and finally forms a white dwarf.$mq$, $mq$medium$mq$),
($mq$Which is NOT evidence for the Big Bang?$mq$, $mq$["The Sun rises every day","Redshift of distant galaxies","Cosmic microwave background radiation","The observed abundance of hydrogen and helium"]$mq$, 0, $mq$The Sun rising is caused by the Earth's rotation. The other three are evidence supporting the Big Bang theory.$mq$, $mq$medium$mq$),
($mq$The Earth orbits the Sun at a distance of 1.5 × 10¹¹ m in about 3.16 × 10⁷ s. Which is the best estimate of its orbital speed? (Circumference = 2πr)$mq$, $mq$["300 km/s","3 km/s","30 m/s","30 km/s"]$mq$, 3, $mq$2π × 1.5 × 10¹¹ = 9.4 × 10¹¹ m. Divided by 3.16 × 10⁷ s gives about 2.98 × 10⁴ m/s, which is about 30 km/s.$mq$, $mq$hard$mq$),
($mq$A star is 4.2 light years away. What does this mean?$mq$, $mq$["The star is 4.2 km away","The star is 4.2 years old","Light from the star takes 4.2 years to reach us","The star travels for 4.2 years"]$mq$, 2, $mq$We see the star as it was 4.2 years ago. This shows that looking at distant objects is looking back in time.$mq$, $mq$hard$mq$),
($mq$A massive star ends its life with a supernova. Which of these can remain afterwards?$mq$, $mq$["A white dwarf only","A neutron star or black hole","A red giant","A new nebula that is a planet"]$mq$, 1, $mq$After a supernova a very massive star's core can become a neutron star or a black hole. Elements heavier than iron are made in supernovae.$mq$, $mq$hard$mq$),
($mq$Which statement about gravity is correct?$mq$, $mq$["Gravitational force increases with mass and decreases as distance increases","Gravity is only on Earth","Gravity depends on colour","Gravity is the same at all distances"]$mq$, 0, $mq$The gravitational force between two objects depends on their masses and gets weaker as distance increases.$mq$, $mq$hard$mq$),
($mq$Scientists replace one model of the universe with a new one when new evidence appears. Why is this a strength of science?$mq$, $mq$["Scientists always disagree","Old models are never useful","Models cannot be tested","Models are tested and revised in the light of evidence"]$mq$, 3, $mq$Science progresses through testing, peer review and replacing models when better evidence appears. This is not a weakness.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$The Solar System, Stars and the Big Bang$mq$ and p.name = $mq$Earth, Atmosphere and Space$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Order of the planets$mq$, $mq$Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune.$mq$),
($mq$Light year$mq$, $mq$The distance light travels in one year, about 9.46 × 10¹⁵ m. A unit of distance, not time.$mq$),
($mq$Cause of seasons$mq$, $mq$The tilt of the Earth's axis (about 23.5°), not the distance from the Sun.$mq$),
($mq$Weight formula$mq$, $mq$Weight = mass × gravitational field strength. About 10 N/kg on Earth and 1.6 N/kg on the Moon.$mq$),
($mq$Nuclear fusion in stars$mq$, $mq$Hydrogen nuclei fuse into helium in the core, releasing energy.$mq$),
($mq$Life cycle of a Sun-like star$mq$, $mq$Nebula, protostar, main sequence, red giant, white dwarf.$mq$),
($mq$Life cycle of a massive star$mq$, $mq$Nebula, protostar, main sequence, red supergiant, supernova, neutron star or black hole.$mq$),
($mq$Big Bang theory$mq$, $mq$The universe began about 13.8 billion years ago from a hot, dense state and has been expanding since.$mq$),
($mq$Evidence for the Big Bang$mq$, $mq$Red-shift of distant galaxies and the cosmic microwave background radiation.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$The Solar System, Stars and the Big Bang$mq$ and p.name = $mq$Earth, Atmosphere and Space$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$The universe is vast, and our own Solar System is a tiny part of it. Space science combines physics and chemistry and shows how scientific models change as new evidence is collected.

## The Solar System
The Sun is a star at the centre of the Solar System. Eight planets orbit it: Mercury, Venus, Earth, Mars (the rocky inner planets), then Jupiter, Saturn, Uranus and Neptune (the gas and ice giants). There are also dwarf planets, asteroids, comets and moons. **Gravity** from the Sun keeps the planets in orbit. The strength of gravity depends on the masses of the objects and gets weaker as the distance increases. Gravitational field strength is about 10 N/kg on Earth and about 1.6 N/kg on the Moon. Weight = mass × gravitational field strength, so a 60 kg astronaut weighs 600 N on Earth and 96 N on the Moon, but still has a mass of 60 kg.

The Earth's rotation every 24 hours gives day and night. The Earth orbits the Sun in about 365.25 days. The Earth's axis is tilted by about 23.5°, which causes the seasons. It is not caused by the Earth being closer to the Sun. The Moon orbits the Earth in about 27 days, and its phases depend on how much of the sunlit half we see.

## Distances in space
Space distances are huge, so astronomers use the **light year**, the distance light travels in one year (about 9.46 × 10¹⁵ m). Light travels at 3.0 × 10⁸ m/s. Sunlight takes about 500 s to travel 1.5 × 10¹¹ m to the Earth (distance = speed × time). If a star is 4.2 light years away, we see it as it was 4.2 years ago.

## Stars
Stars form in clouds of gas and dust called **nebulae**. Gravity pulls the material together into a **protostar**. When the core is hot enough, hydrogen nuclei fuse to form helium (**nuclear fusion**), releasing energy, and the star becomes a **main sequence** star. The Sun is in this stable stage. When the hydrogen runs low:
- A star like the Sun swells into a **red giant**, then loses its outer layers and shrinks into a **white dwarf**.
- A much more massive star becomes a red supergiant, then explodes as a **supernova**, leaving a **neutron star** or a **black hole**. Elements heavier than iron are formed in supernovae and spread into space. Many of the atoms in our bodies were made inside stars.

## The Big Bang
The **Big Bang** theory says that the universe began about 13.8 billion years ago from a very hot, dense state and has been expanding ever since. The Earth is about 4.5 billion years old. Evidence includes:
- **Red-shift**: light from distant galaxies is shifted towards longer wavelengths, showing they are moving away from us. More distant galaxies show a greater red-shift.
- **Cosmic microwave background radiation**: weak microwave radiation from all directions, thought to be left over from the early universe.
- The proportions of hydrogen and helium in the universe match predictions.

## How scientific models change
Models of the universe have changed over time, from an Earth-centred model to a Sun-centred one, and then to a universe containing billions of galaxies. New instruments such as telescopes and space probes provide new evidence. Models are tested and revised, which is a strength of science.

## How this is examined
Questions might provide a space mission scenario with distances and speeds, or data about red-shift. You may be asked to calculate a time or distance, order stages of a star's life, or explain why the Big Bang is accepted by scientists.

Exam tip: In calculations, convert to standard units and write the equation before you substitute. In explanation questions name the evidence (red-shift, cosmic microwave background) and say how it supports the theory.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('integrated-science')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;