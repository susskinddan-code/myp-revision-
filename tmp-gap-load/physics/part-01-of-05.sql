-- Part 1 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Atomic Physics and Radioactivity > Atomic Structure and Isotopes
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Atomic Physics and Radioactivity$mq$, 5, 1 from public.subjects s where s.slug = $mq$physics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Atomic Structure and Isotopes$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physics$mq$ and p.grade = 5 and p.name = $mq$Atomic Physics and Radioactivity$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Atomic Structure and Isotopes$mq$ and p.name = $mq$Atomic Physics and Radioactivity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which particle in an atom has a negative charge and a very small mass?$mq$, $mq$["Electron","Proton","Neutron","Nucleus"]$mq$, 0, $mq$Electrons carry a charge of −1 and have a mass of about 1/1836 of a proton.$mq$, $mq$easy$mq$),
($mq$The atomic number of an element tells you the number of which particles in one atom?$mq$, $mq$["Neutrons","Protons plus neutrons","Neutrons plus electrons","Protons"]$mq$, 3, $mq$Atomic number (proton number) is the number of protons, and it identifies the element.$mq$, $mq$easy$mq$),
($mq$A neutral atom of sodium-23 has atomic number 11. How many neutrons does it contain?$mq$, $mq$["11","23","12","34"]$mq$, 2, $mq$Neutrons = mass number − atomic number = 23 − 11 = 12.$mq$, $mq$easy$mq$),
($mq$Isotopes of the same element always have the same number of …$mq$, $mq$["neutrons","protons","nucleons","mass number"]$mq$, 1, $mq$Isotopes differ only in neutron number, so proton number (and element) stays the same.$mq$, $mq$easy$mq$),
($mq$In the gold foil experiment, most alpha particles passed straight through the foil. What does this show?$mq$, $mq$["An atom is mostly empty space","The atom is a solid ball of positive charge","Electrons are heavier than alpha particles","Gold atoms have no nucleus"]$mq$, 0, $mq$If most particles pass undeflected, most of the atom must be empty space.$mq$, $mq$easy$mq$),
($mq$An atom has 6 protons, 8 neutrons and 6 electrons. Which description is correct?$mq$, $mq$["Carbon-12, mass number 12","Oxygen-14, mass number 14","Carbon-14, mass number 6","Carbon-14, mass number 14"]$mq$, 3, $mq$Six protons means carbon. Mass number = 6 + 8 = 14, so it is carbon-14.$mq$, $mq$medium$mq$),
($mq$A magnesium ion Mg²⁺ has 12 protons in its nucleus. How many electrons does it have?$mq$, $mq$["12","14","10","2"]$mq$, 2, $mq$The 2+ charge means two more protons than electrons, so 12 − 2 = 10 electrons.$mq$, $mq$medium$mq$),
($mq$Chlorine-35 and chlorine-37 are isotopes. What is the difference between their atoms?$mq$, $mq$["Chlorine-37 has 2 more protons","Chlorine-37 has 2 more neutrons","Chlorine-37 has 2 more electrons","Chlorine-37 has 2 fewer neutrons"]$mq$, 1, $mq$Both have 17 protons. Mass number differs by 2, so chlorine-37 has 20 neutrons and chlorine-35 has 18.$mq$, $mq$medium$mq$),
($mq$Why is a normal atom electrically neutral?$mq$, $mq$["It has equal numbers of protons and electrons","It has equal numbers of protons and neutrons","It has no charged particles","Neutrons cancel the protons"]$mq$, 0, $mq$Positive charge of protons balances negative charge of electrons when their numbers are equal.$mq$, $mq$medium$mq$),
($mq$In the gold foil experiment a very small number of alpha particles bounced almost straight back. Which conclusion does this support?$mq$, $mq$["Electrons repel alpha particles strongly","The atom has a uniform positive charge","Alpha particles are absorbed by neutrons","The nucleus is small, dense and positively charged"]$mq$, 3, $mq$Large deflections need a concentrated positive charge. Only a tiny nucleus could do that, which is why so few were deflected.$mq$, $mq$medium$mq$),
($mq$Which two particles have approximately the same mass?$mq$, $mq$["Proton and electron","Neutron and electron","Proton and neutron","Electron and alpha particle"]$mq$, 2, $mq$Protons and neutrons each have relative mass 1, while an electron is about 1/1836.$mq$, $mq$medium$mq$),
($mq$A uranium nuclide is written ²³⁸₉₂U. How many neutrons does it have?$mq$, $mq$["92","146","238","330"]$mq$, 1, $mq$Neutrons = 238 − 92 = 146.$mq$, $mq$medium$mq$),
($mq$A fluoride ion is written ¹⁹₉F⁻. Which row gives its protons, neutrons and electrons?$mq$, $mq$["9, 10, 10","9, 10, 9","10, 9, 10","9, 19, 10"]$mq$, 0, $mq$Protons = 9. Neutrons = 19 − 9 = 10. The ion has gained one electron so it has 10.$mq$, $mq$medium$mq$),
($mq$An atom has a diameter of about 1 × 10⁻¹⁰ m and its nucleus has a diameter of about 1 × 10⁻¹⁵ m. About how many times wider is the atom than the nucleus?$mq$, $mq$["1000","10 000 000","5","100 000"]$mq$, 3, $mq$1 × 10⁻¹⁰ ÷ 1 × 10⁻¹⁵ = 1 × 10⁵ = 100 000. This shows the atom is mostly empty space.$mq$, $mq$hard$mq$),
($mq$Three particles are described. X: 17 protons, 18 neutrons, 18 electrons. Y: 17 protons, 20 neutrons, 17 electrons. Z: 18 protons, 22 neutrons, 18 electrons. Which statement is correct?$mq$, $mq$["X and Z are isotopes of the same element","Y and Z are isotopes of the same element","X and Y are isotopes of the same element","None of them are the same element"]$mq$, 2, $mq$X and Y both have 17 protons so they are the same element with different neutron numbers. Z has 18 protons so it is a different element.$mq$, $mq$hard$mq$),
($mq$A student says: 'Carbon-12 and carbon-14 must react differently because they have different masses.' Which evaluation is best?$mq$, $mq$["Correct: heavier atoms always react more slowly because of their mass","Incorrect: chemical behaviour depends on electron arrangement, which is the same for both","Incorrect: isotopes have different numbers of electrons","Correct: the extra neutrons change the charge on the nucleus"]$mq$, 1, $mq$Chemical reactions involve electrons. Isotopes have the same proton and electron numbers, so they behave almost identically chemically.$mq$, $mq$hard$mq$),
($mq$Before 1909 the plum pudding model pictured a ball of positive charge with electrons embedded in it. Which observation could this model NOT explain?$mq$, $mq$["A few alpha particles deflected through angles over 90°","Most alpha particles passing through the foil","Atoms being electrically neutral","Electrons having a negative charge"]$mq$, 0, $mq$A spread-out positive charge would only cause small deflections. Large-angle scattering showed a concentrated nucleus.$mq$, $mq$hard$mq$),
($mq$A sample of an element contains two isotopes: mass number 10 (20% of atoms) and mass number 11 (80% of atoms). What is the average mass number of its atoms?$mq$, $mq$["10.5","10.2","11.0","10.8"]$mq$, 3, $mq$(0.20 × 10) + (0.80 × 11) = 2.0 + 8.8 = 10.8.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Atomic Structure and Isotopes$mq$ and p.name = $mq$Atomic Physics and Radioactivity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Proton$mq$, $mq$Relative mass 1, charge +1, found in the nucleus. Its number is the atomic number.$mq$),
($mq$Neutron$mq$, $mq$Relative mass 1, charge 0, found in the nucleus.$mq$),
($mq$Electron$mq$, $mq$Relative mass about 1/1836, charge −1, found outside the nucleus.$mq$),
($mq$Mass number$mq$, $mq$Number of protons plus neutrons (nucleons) in an atom's nucleus.$mq$),
($mq$How do you find the number of neutrons?$mq$, $mq$Neutrons = mass number − atomic number.$mq$),
($mq$Isotopes$mq$, $mq$Atoms of the same element with the same number of protons but different numbers of neutrons.$mq$),
($mq$Ion$mq$, $mq$An atom that has gained or lost electrons, so it has an overall charge.$mq$),
($mq$What did the gold foil experiment show?$mq$, $mq$Most alpha particles passed through, so the atom is mostly empty space. Few large deflections showed a small, dense, positively charged nucleus.$mq$),
($mq$Size of atom vs nucleus$mq$, $mq$Atom about 10⁻¹⁰ m across, nucleus about 10⁻¹⁵ m, so the atom is roughly 100 000 times wider.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Atomic Structure and Isotopes$mq$ and p.name = $mq$Atomic Physics and Radioactivity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The particles in an atom
Every atom has a tiny central nucleus made of protons and neutrons (together called nucleons) with electrons moving around it. You must know the relative mass and charge of each particle.
- **Proton**: relative mass 1, charge +1, in the nucleus.
- **Neutron**: relative mass 1, charge 0, in the nucleus.
- **Electron**: relative mass about 1/1836 (so tiny it is treated as almost zero), charge −1, found outside the nucleus.
A normal atom is neutral because it has the same number of protons and electrons.

## Atomic number and mass number
- **Atomic number (Z)** is the number of protons. It decides which element the atom is.
- **Mass number (A)** is the number of protons plus neutrons.
- Number of neutrons = A − Z.
We write a nuclide as ²³⁸₉₂U, with the mass number at the top and the atomic number at the bottom. For uranium-238 that gives 92 protons and 238 − 92 = 146 neutrons.

## Isotopes
**Isotopes** are atoms of the same element (same number of protons) with different numbers of neutrons. Carbon-12 has 6 protons and 6 neutrons. Carbon-14 has 6 protons and 8 neutrons. Their chemical behaviour is almost identical because chemistry depends on electrons, and both have 6. Their nuclei differ, so one isotope can be stable while another is radioactive.

## Ions
An atom that gains or loses electrons becomes an **ion**. Losing electrons gives a positive ion, gaining electrons gives a negative ion. The nucleus does not change. For example Mg²⁺ has 12 protons but only 10 electrons.

## How the model developed
Early on, the plum pudding model pictured a ball of positive charge with electrons embedded in it. In the gold foil experiment, alpha particles were fired at a very thin sheet of gold. Most went straight through, a small number were deflected, and a very few bounced almost straight back. This led to the nuclear model:
- Most of the atom is empty space (most particles passed through).
- The nucleus is small, dense and positively charged (a few were deflected, a very few came back).
The atom has a diameter of about 10⁻¹⁰ m while the nucleus is about 10⁻¹⁵ m across, around 100 000 times smaller.

## Worked example
An atom is written ³⁵₁₇Cl. Protons = 17, electrons (neutral atom) = 17, neutrons = 35 − 17 = 18. The ion Cl⁻ has one extra electron, so 18 electrons, with 17 protons and 18 neutrons unchanged.

## Common mistakes
- Mixing up atomic number and mass number. Atomic number is always the smaller number.
- Changing the number of protons when an ion forms. Only electrons change.
- Saying isotopes have different numbers of electrons. They have the same number in a neutral atom.

## How this is examined
Questions usually give a nuclide symbol or a table of particle numbers and ask you to find protons, neutrons or electrons, identify isotopes, or explain a result of the scattering experiment. Criterion D style tasks may ask you to evaluate how new evidence changed a scientific model.

Exam tip: Always show the subtraction when finding neutrons (mass number − atomic number) and, in a table question, check proton numbers first to decide which particles belong to the same element.$mq$ from st;

-- Atomic Physics and Radioactivity > Radioactive Decay and Half-life
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Atomic Physics and Radioactivity$mq$, 5, 1 from public.subjects s where s.slug = $mq$physics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Radioactive Decay and Half-life$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physics$mq$ and p.grade = 5 and p.name = $mq$Atomic Physics and Radioactivity$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Radioactive Decay and Half-life$mq$ and p.name = $mq$Atomic Physics and Radioactivity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which type of nuclear radiation is a helium nucleus?$mq$, $mq$["Alpha","Beta","Gamma","X-ray"]$mq$, 0, $mq$An alpha particle is two protons and two neutrons, the same as a helium-4 nucleus.$mq$, $mq$easy$mq$),
($mq$Which radiation is a form of electromagnetic wave with no mass or charge?$mq$, $mq$["Alpha","Beta-minus","Neutron","Gamma"]$mq$, 3, $mq$Gamma rays are high-frequency electromagnetic radiation.$mq$, $mq$easy$mq$),
($mq$Radioactive decay is described as random. What does this mean?$mq$, $mq$["Decay only happens at night","All nuclei decay at the same moment","We cannot predict when a particular nucleus will decay","Decay depends on the temperature"]$mq$, 2, $mq$For one nucleus the time of decay is unpredictable, though large samples follow a pattern.$mq$, $mq$easy$mq$),
($mq$What is meant by the half-life of a radioactive isotope?$mq$, $mq$["The time for all the nuclei to decay","The time for half the nuclei in a sample to decay","Half the time for the activity to reach zero","The time for the mass of the sample to halve"]$mq$, 1, $mq$Half-life is the average time for the number of undecayed nuclei (and the activity) to fall to half.$mq$, $mq$easy$mq$),
($mq$Which instrument is used to detect and count radiation?$mq$, $mq$["Geiger-Müller tube","Voltmeter","Thermometer","Ammeter"]$mq$, 0, $mq$A Geiger-Müller tube with a counter detects ionising radiation as counts per second or minute.$mq$, $mq$easy$mq$),
($mq$A sample has a half-life of 6 hours and an initial activity of 240 counts per second. What is its activity after 24 hours?$mq$, $mq$["60 counts per second","30 counts per second","0 counts per second","15 counts per second"]$mq$, 3, $mq$24 hours is 4 half-lives. 240 → 120 → 60 → 30 → 15.$mq$, $mq$medium$mq$),
($mq$Which row correctly ranks the penetrating power of the three radiations from least to most?$mq$, $mq$["Gamma, beta, alpha","Beta, alpha, gamma","Alpha, beta, gamma","Alpha, gamma, beta"]$mq$, 2, $mq$Alpha is stopped by paper, beta by a few millimetres of aluminium, and gamma needs thick lead or concrete to reduce it.$mq$, $mq$medium$mq$),
($mq$Radium-226 (atomic number 88) decays by emitting an alpha particle. What are the mass number and atomic number of the new nucleus?$mq$, $mq$["222 and 88","222 and 86","226 and 90","230 and 90"]$mq$, 1, $mq$Alpha emission removes 4 from the mass number and 2 from the atomic number: 226 − 4 = 222 and 88 − 2 = 86.$mq$, $mq$medium$mq$),
($mq$A nucleus undergoes beta-minus decay. What happens in the nucleus?$mq$, $mq$["A neutron changes into a proton and an electron is emitted","A proton changes into a neutron","Two protons and two neutrons are emitted","The nucleus loses energy only"]$mq$, 0, $mq$In beta-minus decay a neutron becomes a proton, so atomic number rises by 1 while mass number stays the same.$mq$, $mq$medium$mq$),
($mq$Carbon-14 decays by beta-minus emission. Its nucleus has 6 protons and 8 neutrons. What does the daughter nucleus have?$mq$, $mq$["5 protons and 9 neutrons","6 protons and 8 neutrons","8 protons and 6 neutrons","7 protons and 7 neutrons"]$mq$, 3, $mq$A neutron becomes a proton: protons 6 + 1 = 7, neutrons 8 − 1 = 7. The mass number is still 14 (nitrogen-14).$mq$, $mq$medium$mq$),
($mq$A radioactive source has a half-life of 3 days. What fraction of the original nuclei remain after 9 days?$mq$, $mq$["1/6","1/3","1/8","1/9"]$mq$, 2, $mq$9 days is 3 half-lives, so (1/2)³ = 1/8.$mq$, $mq$medium$mq$),
($mq$The background count in a laboratory is 20 counts per minute. A source gives a total reading of 260 counts per minute. What is the count rate from the source alone?$mq$, $mq$["280 counts per minute","240 counts per minute","260 counts per minute","13 counts per minute"]$mq$, 1, $mq$Subtract background radiation: 260 − 20 = 240 counts per minute.$mq$, $mq$medium$mq$),
($mq$Which of these is a source of background radiation?$mq$, $mq$["Radon gas from rocks","Visible light from a lamp","Sound waves","A battery"]$mq$, 0, $mq$Natural sources include radon gas, rocks and soil, cosmic rays and food. Visible light, sound and batteries are not ionising radiation sources.$mq$, $mq$medium$mq$),
($mq$The count rate (corrected for background) from a sample falls from 800 to 100 counts per minute in 36 minutes. What is the half-life?$mq$, $mq$["9 minutes","18 minutes","36 minutes","12 minutes"]$mq$, 3, $mq$800 → 400 → 200 → 100 is 3 halvings in 36 minutes, so the half-life is 36 ÷ 3 = 12 minutes.$mq$, $mq$hard$mq$),
($mq$Uranium-238 (atomic number 92) emits an alpha particle, and the new nucleus then emits a beta-minus particle. What is the final nucleus?$mq$, $mq$["Mass number 234, atomic number 90","Mass number 238, atomic number 91","Mass number 234, atomic number 91","Mass number 232, atomic number 90"]$mq$, 2, $mq$After alpha: 234, 90. After beta-minus the mass number stays 234 and atomic number goes up by 1 to 91.$mq$, $mq$hard$mq$),
($mq$Student data: count rate corrected for background is 640 at 0 min, 320 at 5 min, 160 at 10 min, 80 at 15 min. Which statement is best supported?$mq$, $mq$["Half-life is 10 minutes because the rate fell to 160","Half-life is 5 minutes and it is constant for each interval","The half-life increases as the sample gets smaller","The sample will reach zero at 20 minutes"]$mq$, 1, $mq$The rate halves every 5 minutes, which is the pattern for exponential decay. The sample never reaches exactly zero.$mq$, $mq$hard$mq$),
($mq$A source of half-life 2 hours has an activity of 960 counts per minute. A technician needs to know when it falls below 100 counts per minute. Which is the earliest time listed after which this is true?$mq$, $mq$["8 hours","6 hours","4 hours","2 hours"]$mq$, 0, $mq$960 → 480 (2 h) → 240 (4 h) → 120 (6 h) → 60 (8 h). It is first below 100 at 8 hours.$mq$, $mq$hard$mq$),
($mq$Sample P has a half-life of 10 minutes. Sample Q has a half-life of 10 days. Both start with the same number of nuclei. Which statement is correct about their initial activities?$mq$, $mq$["Q has the higher activity because it lasts longer","They have the same activity because they have the same number of nuclei","Neither is radioactive","P has the higher activity because its nuclei decay faster"]$mq$, 3, $mq$A short half-life means each nucleus is more likely to decay in a given time, so P has the higher initial activity but runs out sooner.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Radioactive Decay and Half-life$mq$ and p.name = $mq$Atomic Physics and Radioactivity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Alpha particle$mq$, $mq$Two protons and two neutrons (a helium nucleus). Strongly ionising, stopped by paper.$mq$),
($mq$Beta-minus particle$mq$, $mq$A fast electron emitted when a neutron changes to a proton. Stopped by a few millimetres of aluminium.$mq$),
($mq$Gamma ray$mq$, $mq$High-frequency electromagnetic wave from the nucleus. Weakly ionising, needs thick lead or concrete to reduce it.$mq$),
($mq$Alpha decay changes$mq$, $mq$Mass number falls by 4 and atomic number falls by 2.$mq$),
($mq$Beta-minus decay changes$mq$, $mq$Mass number stays the same and atomic number rises by 1.$mq$),
($mq$Half-life$mq$, $mq$The time taken for half the undecayed nuclei, or the activity, of a radioactive sample to fall to half.$mq$),
($mq$Activity$mq$, $mq$The number of nuclei decaying per second, measured in becquerel (Bq).$mq$),
($mq$Why is decay random?$mq$, $mq$It is impossible to predict when one given nucleus will decay, although the behaviour of a large sample is predictable.$mq$),
($mq$Background radiation$mq$, $mq$Radiation always present from radon gas, rocks, cosmic rays and food. Subtract it from the measured count.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Radioactive Decay and Half-life$mq$ and p.name = $mq$Atomic Physics and Radioactivity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is radioactive decay?
Some nuclei are unstable because of the balance of protons and neutrons. They become more stable by emitting radiation. This is **radioactive decay**. It is **random**: you cannot say when one particular nucleus will decay, but in a large sample the overall pattern is predictable. It is also **spontaneous**, meaning it is not affected by temperature, pressure or chemical reactions.

## Three types of radiation
- **Alpha (α)**: two protons and two neutrons (a helium nucleus), charge +2. Strongly ionising, stopped by paper or a few centimetres of air.
- **Beta-minus (β)**: a fast electron from the nucleus, charge −1. Moderately ionising, stopped by a few millimetres of aluminium.
- **Gamma (γ)**: high-frequency electromagnetic radiation, no charge. Weakly ionising, reduced by thick lead or concrete.
Alpha is the most ionising but the least penetrating. Gamma is the opposite.

## Nuclear equations
In decay, mass number and atomic number must balance on both sides.
- Alpha decay: mass number falls by 4, atomic number falls by 2. Radium-226 (88) becomes radon-222 (86).
- Beta-minus decay: a neutron turns into a proton plus an electron. Mass number stays the same, atomic number rises by 1. Carbon-14 (6) becomes nitrogen-14 (7).
- Gamma emission: no change in mass number or atomic number, the nucleus only loses energy.

## Activity and half-life
**Activity** is the number of nuclei decaying each second, measured in becquerel (Bq). The **half-life** is the time for the activity (or the number of undecayed nuclei) of a sample to fall to half. It is constant for a given isotope, from seconds to billions of years.

Worked example: a sample has an activity of 800 Bq and a half-life of 4 hours. After 12 hours, that is 3 half-lives, the activity is 800 → 400 → 200 → 100 Bq.

On a graph of activity against time, the curve falls steeply at first, then more slowly, and never quite reaches zero. To find the half-life, read the time for the value to drop by half, and check it with a second halving to be sure.

## Background radiation
A Geiger-Müller tube always counts some radiation even with no source nearby. This comes from radon gas, rocks, cosmic rays and food. Always subtract the background count to find the count from the source.

## Common mistakes
- Thinking that after two half-lives everything has decayed. A quarter is left.
- Forgetting that mass number does not change in beta decay.
- Using the raw count without subtracting background.

## How this is examined
You may be given a table of count rates over time and asked to draw a graph, determine the half-life, predict a later reading, and evaluate the reliability of the data (for example the effect of background radiation and random fluctuations). Nuclear equations are usually in a short calculation question.

Exam tip: For half-life problems, write out each halving step (800 → 400 → 200) so you can pick up method marks even if you miscount the number of half-lives.$mq$ from st;

-- Atomic Physics and Radioactivity > Uses and Dangers of Radiation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Atomic Physics and Radioactivity$mq$, 5, 1 from public.subjects s where s.slug = $mq$physics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Uses and Dangers of Radiation$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physics$mq$ and p.grade = 5 and p.name = $mq$Atomic Physics and Radioactivity$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Uses and Dangers of Radiation$mq$ and p.name = $mq$Atomic Physics and Radioactivity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which radioactive isotope is commonly used inside smoke detectors?$mq$, $mq$["Americium-241, an alpha emitter","Cobalt-60, a gamma emitter","Technetium-99m, a gamma emitter","Carbon-14, a beta emitter"]$mq$, 0, $mq$Smoke detectors use an alpha source because alpha particles ionise air to make a small current, which smoke interrupts.$mq$, $mq$easy$mq$),
($mq$Why is gamma radiation used to sterilise surgical instruments?$mq$, $mq$["It makes instruments radioactive","It heats the instruments to 100 °C","It dissolves bacteria","It is penetrating and kills microorganisms"]$mq$, 3, $mq$Gamma passes through packaging and kills bacteria. The instruments do not become radioactive.$mq$, $mq$easy$mq$),
($mq$Ionising radiation is dangerous mainly because it can …$mq$, $mq$["make people magnetic","cool down body tissue","damage or mutate cells in living things","stop the heart immediately in all cases"]$mq$, 2, $mq$Ionising radiation can damage DNA, causing cell death or mutations that may lead to cancer.$mq$, $mq$easy$mq$),
($mq$Which is the best way to reduce the dose from a gamma source?$mq$, $mq$["Hold it close with bare hands","Stand further away and use lead shielding","Keep it in a plastic bag","Warm the source"]$mq$, 1, $mq$Dose falls with distance and with absorbers such as lead. Less time in exposure also helps.$mq$, $mq$easy$mq$),
($mq$What is a radioactive tracer?$mq$, $mq$["A radioactive substance used to follow a process","A device for measuring speed","A type of X-ray machine","A gas used in smoke alarms"]$mq$, 0, $mq$Tracers are injected or added and then detected from outside to follow flow, leaks or organ function.$mq$, $mq$easy$mq$),
($mq$A hospital needs a tracer to inject into a patient for a scan. Which properties are best?$mq$, $mq$["Alpha emitter with a long half-life","Beta emitter with a long half-life","Alpha emitter with a short half-life","Gamma emitter with a short half-life"]$mq$, 3, $mq$Gamma passes out of the body to be detected, and a short half-life means activity quickly falls, reducing dose.$mq$, $mq$medium$mq$),
($mq$A factory monitors the thickness of aluminium foil with a radiation source on one side and a detector on the other. Which source is most suitable?$mq$, $mq$["Alpha emitter","Gamma emitter","Beta emitter","Visible light"]$mq$, 2, $mq$Alpha cannot get through the foil, and gamma passes through almost unaffected. Beta is partly absorbed, so the reading changes with thickness.$mq$, $mq$medium$mq$),
($mq$Radiotherapy uses beams of gamma rays from several directions that meet at a tumour. Why?$mq$, $mq$["To make the tumour radioactive","To give a high dose to the tumour and a lower dose to healthy tissue","To heat the body evenly","To avoid needing any shielding"]$mq$, 1, $mq$Beams overlap only at the tumour, so healthy tissue along each path receives a smaller dose.$mq$, $mq$medium$mq$),
($mq$What is the difference between irradiation and contamination?$mq$, $mq$["Irradiation is exposure to radiation from outside, contamination is radioactive material getting on or in the body","Irradiation is for alpha only and contamination is for gamma only","They mean the same thing","Contamination is exposure through a lead shield"]$mq$, 0, $mq$An irradiated object does not become radioactive. A contaminated object carries radioactive atoms that keep emitting.$mq$, $mq$medium$mq$),
($mq$Why is an alpha source more dangerous when swallowed than when held outside the body?$mq$, $mq$["Alpha penetrates through the body to the detector","Alpha is weaker inside the body","It turns into gamma","Its radiation is strongly ionising and is absorbed by internal tissue"]$mq$, 3, $mq$Outside the body, skin and air stop alpha. Inside, all its energy is absorbed by living cells.$mq$, $mq$medium$mq$),
($mq$Carbon-14 has a half-life of 5730 years. A wooden object has one quarter of the carbon-14 activity of living wood. About how old is it?$mq$, $mq$["5730 years","22 920 years","11 460 years","2865 years"]$mq$, 2, $mq$One quarter is two half-lives: 2 × 5730 = 11 460 years.$mq$, $mq$medium$mq$),
($mq$Workers who handle radioactive sources wear a film badge. What is its purpose?$mq$, $mq$["To block all radiation","To measure how much radiation they have been exposed to","To make the source safe","To detect smoke"]$mq$, 1, $mq$A film badge darkens with radiation, which allows staff dose to be monitored.$mq$, $mq$medium$mq$),
($mq$Which storage method is best for long-lived, highly radioactive nuclear waste?$mq$, $mq$["Sealed in shielded containers and buried deep underground","Dumped in a river","Burned in a normal furnace","Left in an open pit"]$mq$, 0, $mq$Waste stays hazardous for thousands of years, so it must be isolated and shielded.$mq$, $mq$medium$mq$),
($mq$A technician must choose a tracer to check for a leak in an underground water pipe. Which choice is best?$mq$, $mq$["An alpha emitter with a half-life of 1000 years","A beta emitter with a half-life of 30 years","An alpha emitter with a half-life of a few hours","A gamma emitter with a half-life of a few hours"]$mq$, 3, $mq$Gamma passes through soil to a detector at the surface. A few hours means it will not stay in the environment for long.$mq$, $mq$hard$mq$),
($mq$A source has a half-life of 8 days. A technician is allowed to work around it only when the activity is below 10% of its initial value. Which is the earliest time listed that is safe?$mq$, $mq$["16 days","24 days","32 days","8 days"]$mq$, 2, $mq$After 3 half-lives the activity is 12.5%, after 4 it is 6.25%. So 4 × 8 = 32 days is the first listed time below 10%.$mq$, $mq$hard$mq$),
($mq$Which argument best justifies using radiotherapy even though radiation is harmful?$mq$, $mq$["Radiation is completely safe in medical use","The benefit of destroying the tumour can outweigh the risk, and the dose is controlled and targeted","Gamma rays only affect cancer cells","The treatment makes the patient radioactive"]$mq$, 1, $mq$Risks and benefits are weighed. Targeting and controlled dose reduce harm, but healthy tissue can still be damaged.$mq$, $mq$hard$mq$),
($mq$A student suggests that a thick sheet of paper will protect them from a cobalt-60 gamma source. Which evaluation is correct?$mq$, $mq$["Incorrect: gamma passes through paper and needs thick lead or concrete","Correct: paper stops all radiation","Correct: gamma is the same as alpha","Incorrect: paper makes gamma more dangerous"]$mq$, 0, $mq$Paper only stops alpha. Gamma is highly penetrating and is only reduced, not fully stopped, by dense shielding.$mq$, $mq$hard$mq$),
($mq$A sealed gamma source is used to sterilise food. Which statement about the food is correct?$mq$, $mq$["The food becomes radioactive because it absorbs gamma","The food becomes hot enough to cook","Only the packaging is sterilised","The food is not made radioactive because gamma only irradiates it"]$mq$, 3, $mq$Irradiation exposes food to radiation, but does not transfer radioactive atoms, so the food does not become radioactive.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Uses and Dangers of Radiation$mq$ and p.name = $mq$Atomic Physics and Radioactivity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Smoke detector source$mq$, $mq$Americium-241, an alpha emitter. Smoke reduces the small ionisation current in air and triggers the alarm.$mq$),
($mq$Why is a medical tracer a gamma emitter with short half-life?$mq$, $mq$Gamma leaves the body to be detected, and a short half-life means the activity (and dose to the patient) falls quickly.$mq$),
($mq$Thickness gauge radiation$mq$, $mq$Beta emitter: partly absorbed by foil, so the detected count changes with thickness. Alpha is stopped, gamma passes through.$mq$),
($mq$Radiotherapy$mq$, $mq$Gamma beams from several directions meet at the tumour, giving it a high dose while healthy tissue gets less.$mq$),
($mq$Radiocarbon dating$mq$, $mq$Carbon-14 (half-life 5730 years) decays after death. Comparing remaining activity with living material gives the age.$mq$),
($mq$Irradiation$mq$, $mq$Exposure to radiation from an outside source. The object or person does not become radioactive.$mq$),
($mq$Contamination$mq$, $mq$Radioactive material gets on or inside an object or person, so it keeps emitting radiation.$mq$),
($mq$Ways to reduce exposure$mq$, $mq$Reduce time, increase distance (use tongs), and use shielding such as lead or concrete.$mq$),
($mq$Why is ionising radiation harmful?$mq$, $mq$It can damage DNA in cells, causing cell death or mutation, which may lead to cancer.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physics$mq$ and t.grade = 5 and t.name = $mq$Uses and Dangers of Radiation$mq$ and p.name = $mq$Atomic Physics and Radioactivity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why radiation is useful
Different radiations have different properties, so we choose the type, source and half-life to match the job. The main thing to think about is which radiation can reach the detector or the target, and how long the source stays active.

## Medical uses
- **Tracers**: a small amount of a gamma-emitting isotope, such as technetium-99m (half-life about 6 hours), is injected. A gamma camera outside the body detects where it goes, to check organs or blood flow. A short half-life means the patient's dose falls quickly.
- **Radiotherapy**: narrow beams of gamma rays from several directions are focused on a tumour. This gives the tumour a high dose while each healthy area receives a smaller one.
- **Sterilising equipment**: gamma kills bacteria on sealed surgical tools without heating them.

## Industrial and other uses
- **Smoke detectors** contain an alpha source (americium-241). Alpha particles ionise air to make a tiny current. When smoke enters, the current drops and the alarm sounds.
- **Thickness gauges**: for paper, plastic or metal foil, a beta source on one side and a detector on the other. If the material gets thicker, fewer particles get through and the machine adjusts the rollers.
- **Leak detection**: a gamma tracer in a pipe is detected above ground where it escapes.
- **Radiocarbon dating**: living things take in carbon-14. After death, no more is taken in and the carbon-14 decays with a half-life of 5730 years. Comparing a sample's activity with living material gives its age. Example: one quarter of the original activity means 2 half-lives, 2 × 5730 = 11 460 years.
- **Food irradiation**: gamma kills microbes so food lasts longer.

## Dangers
Ionising radiation can remove electrons from atoms, damaging DNA in cells. High doses kill cells and cause radiation sickness. Lower doses can cause mutations and cancer later. Alpha is most dangerous inside the body, while gamma is dangerous from outside because it penetrates.

**Irradiation** means being exposed to radiation from a source outside the body. The person does not become radioactive. **Contamination** means radioactive atoms get onto or into the body or an object, which keeps emitting until they decay or are removed.

## Reducing the risk
- Limit the time of exposure.
- Increase the distance, using tongs to handle sources.
- Use shielding such as lead or concrete.
- Store sources in lead-lined containers and wear a film badge to measure the dose.
- Dispose of nuclear waste in shielded containers, buried deep underground.

## Weighing risks and benefits
Many exam tasks ask you to evaluate. A good answer states the benefit (for example, treating cancer), the risk (damage to healthy cells), how the risk is controlled (targeting, limited dose) and a clear judgement.

## How this is examined
You will often get a scenario and a table of sources (type of radiation, half-life) and have to choose the best one and justify it using penetration, half-life and safety.

Exam tip: When justifying a choice of source, link three things: the type of radiation (penetrating power), the half-life (how long it lasts) and the hazard (inside or outside the body).$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('physics')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;