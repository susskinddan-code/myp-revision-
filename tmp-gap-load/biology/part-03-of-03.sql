-- Part 3 of 3: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Interactions Between Organisms > Habitats and Interdependence
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Interactions Between Organisms$mq$, 5, 3 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Habitats and Interdependence$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 5 and p.name = $mq$Interactions Between Organisms$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Habitats and Interdependence$mq$ and p.name = $mq$Interactions Between Organisms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a habitat?$mq$, $mq$["The place where an organism lives","The number of organisms in an area","The food an animal eats","A group of different species"]$mq$, 0, $mq$A habitat is the place where an organism lives, such as a pond, woodland or rock pool.$mq$, $mq$easy$mq$),
($mq$A group of organisms of the same species living in one area at the same time is called a:$mq$, $mq$["Community","Ecosystem","Biome","Population"]$mq$, 3, $mq$A population is one species in an area. A community is all populations, and an ecosystem includes the community plus the non-living environment.$mq$, $mq$easy$mq$),
($mq$Which of these is a biotic factor?$mq$, $mq$["Temperature","Soil pH","Number of predators","Rainfall"]$mq$, 2, $mq$Biotic factors are living (predators, food, disease, competition). Abiotic factors are non-living (temperature, pH, light).$mq$, $mq$easy$mq$),
($mq$In a food chain, what is the role of a producer?$mq$, $mq$["It eats other animals","It makes its own food by photosynthesis","It breaks down dead matter","It eats only plants"]$mq$, 1, $mq$Producers, such as plants and algae, make food using light energy. All other organisms depend on them.$mq$, $mq$easy$mq$),
($mq$Which organisms break down dead plants and animals and return nutrients to the soil?$mq$, $mq$["Decomposers","Producers","Predators","Primary consumers"]$mq$, 0, $mq$Decomposers such as bacteria and fungi break down dead organic matter, releasing nutrients that producers can absorb.$mq$, $mq$easy$mq$),
($mq$A pond community includes algae, water fleas, small fish and herons. Which food chain is correctly written?$mq$, $mq$["Herons → small fish → water fleas → algae","Water fleas → algae → herons → small fish","Small fish → algae → herons → water fleas","Algae → water fleas → small fish → herons"]$mq$, 3, $mq$Arrows show the direction of energy transfer, from food to the organism that eats it.$mq$, $mq$medium$mq$),
($mq$In a food web, the arrows point from:$mq$, $mq$["The predator to the prey","The consumer to the producer","The organism that is eaten to the organism that eats it","The sun to the decomposers only"]$mq$, 2, $mq$Arrows represent the flow of energy and matter, from food to feeder.$mq$, $mq$medium$mq$),
($mq$Which statement describes an abiotic factor that affects the distribution of plants in a woodland?$mq$, $mq$["The number of rabbits","Light intensity on the woodland floor","Presence of a parasite","Competition from other plants"]$mq$, 1, $mq$Light is non-living, so it is abiotic. The other options are biotic factors.$mq$, $mq$medium$mq$),
($mq$Why is only about 10% of the energy at one trophic level passed on to the next?$mq$, $mq$["Much is lost through respiration, movement, heat and uneaten parts","Organisms refuse to eat more","Energy cannot be transferred","All the energy is used to make glucose"]$mq$, 0, $mq$Energy is lost as heat from respiration, in waste, and in parts that are not eaten or digested, so only a small portion is passed on.$mq$, $mq$medium$mq$),
($mq$Why are food chains rarely longer than four or five links?$mq$, $mq$["Predators dislike eating other predators","Plants cannot grow tall enough","Food chains must be short","Too little energy is left for further consumers"]$mq$, 3, $mq$At each step most energy is lost, so very little remains at the top.$mq$, $mq$medium$mq$),
($mq$In a grassland food web, hawks eat both snakes and mice, and snakes also eat mice. If all the snakes are removed, what is the most likely immediate effect?$mq$, $mq$["Mouse numbers rise with no effect on hawks","Hawks become producers","Hawks eat more mice, and the mouse population may decrease","Grass disappears immediately"]$mq$, 2, $mq$Hawks lose one food source and may switch to more mice. Interdependence means removing one species affects others.$mq$, $mq$medium$mq$),
($mq$A student uses a quadrat to count daisies in a 1 m² square at 10 random places and finds an average of 6 daisies per quadrat. The field is 2000 m². What is the estimated population?$mq$, $mq$["6000","12 000","2000","3000"]$mq$, 1, $mq$6 daisies per m² × 2000 m² = 12 000 daisies. Random sampling helps make the estimate representative.$mq$, $mq$medium$mq$),
($mq$Which of the following best explains why decomposers are essential to an ecosystem?$mq$, $mq$["They recycle nutrients from dead matter so producers can use them again","They make food by photosynthesis","They are the top predators","They remove all energy from the ecosystem"]$mq$, 0, $mq$Decomposers release mineral nutrients from dead organisms and waste into the soil, where plants absorb them. Without them nutrients would stay locked in dead matter.$mq$, $mq$medium$mq$),
($mq$A pyramid of numbers for an oak tree has one tree at the base, then 5000 caterpillars, then 40 birds. Why is the shape unusual?$mq$, $mq$["Caterpillars are producers","Birds produce food by photosynthesis","The tree is a consumer","One large producer supports many consumers, so the base is narrow"]$mq$, 3, $mq$One large tree supports many caterpillars, so the base of the pyramid of numbers is narrow. A pyramid of biomass would be a more normal shape.$mq$, $mq$hard$mq$),
($mq$A food chain: grass (10 000 kJ) → rabbits → foxes. If 10% of energy is passed on at each step, how much energy reaches the foxes?$mq$, $mq$["1000 kJ","10 kJ","100 kJ","1 kJ"]$mq$, 2, $mq$10% of 10 000 = 1000 kJ for rabbits. 10% of 1000 = 100 kJ for foxes.$mq$, $mq$hard$mq$),
($mq$A pesticide that kills insects is sprayed on a pond margin. Several months later, the frogs, which eat insects, decline. Which explanation is best?$mq$, $mq$["Frogs prefer pesticides","Loss of their insect food reduced the frog population, showing interdependence","Frogs are producers","Frogs only eat plants"]$mq$, 1, $mq$Frogs depend on insects as food. When the insects are removed, the frogs lose their food supply.$mq$, $mq$hard$mq$),
($mq$Two nearby ponds have similar light and temperature. Pond A has many fish; Pond B has none. Pond A has many more water plants. A student concludes fish cause the plants to grow. Which is the best evaluation?$mq$, $mq$["The data show a link, but other factors such as nutrients, depth or the plants providing shelter for fish could explain it","The conclusion is definitely correct","Fish cannot affect plants","Plants never affect fish"]$mq$, 0, $mq$Correlation does not prove cause. Plants may provide food and shelter, attracting fish, so the cause may run the other way.$mq$, $mq$hard$mq$),
($mq$Why does the loss of a single keystone species, such as a sea otter that eats sea urchins, cause large changes in a kelp forest?$mq$, $mq$["Otters eat the kelp directly","Kelp is a predator of otters","Urchins are producers","Without otters, urchin numbers rise and overgraze the kelp, affecting all species that depend on it"]$mq$, 3, $mq$Keystone species have a big effect on community structure. Removing otters leads to urchin booms and the loss of kelp habitat.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Habitats and Interdependence$mq$ and p.name = $mq$Interactions Between Organisms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Habitat$mq$, $mq$The place where an organism lives.$mq$),
($mq$Population, community, ecosystem$mq$, $mq$Population: one species in an area. Community: all species in an area. Ecosystem: community plus the non-living environment.$mq$),
($mq$Biotic vs abiotic factors$mq$, $mq$Biotic: living (predators, food, disease). Abiotic: non-living (light, temperature, pH, water).$mq$),
($mq$Producer$mq$, $mq$An organism that makes its own food by photosynthesis, e.g. plants and algae.$mq$),
($mq$Decomposers$mq$, $mq$Bacteria and fungi that break down dead material and return nutrients to the soil.$mq$),
($mq$Direction of arrows in a food web$mq$, $mq$From the organism that is eaten to the organism that eats it (direction of energy flow).$mq$),
($mq$Energy transfer between trophic levels$mq$, $mq$About 10% passes on. The rest is lost as heat, in waste and uneaten parts.$mq$),
($mq$Estimating population size with quadrats$mq$, $mq$Average count per quadrat × total area ÷ quadrat area. Place quadrats randomly.$mq$),
($mq$Keystone species$mq$, $mq$A species with a large effect on its community, e.g. sea otters controlling urchins in kelp forests.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Habitats and Interdependence$mq$ and p.name = $mq$Interactions Between Organisms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$No organism lives alone. Each lives in a habitat and depends on other organisms and on the non-living environment. This idea is called **interdependence**.

## Key terms
- **Habitat:** the place where an organism lives.
- **Population:** all the organisms of one species in an area.
- **Community:** all the populations living in an area.
- **Ecosystem:** the community together with the non-living environment.
- **Biotic factors:** living factors such as predators, food, disease and competition.
- **Abiotic factors:** non-living factors such as light, temperature, water, pH and oxygen.

## Trophic levels
- **Producers** make their own food by photosynthesis (plants, algae).
- **Primary consumers** eat producers (herbivores).
- **Secondary and tertiary consumers** eat other animals (carnivores).
- **Decomposers** (bacteria and fungi) break down dead material and return nutrients to the soil.

## Food chains and webs
A **food chain** shows who eats whom in a straight line. A **food web** joins many chains together and is more realistic. The arrows point from the food to the feeder, showing the direction of energy flow. For example: algae → water flea → small fish → heron.

## Energy transfer
The Sun is the source of energy for almost all ecosystems. Only about **10%** of the energy at one level is passed on to the next. The rest is lost as heat through respiration, in waste and in parts not eaten. That is why food chains are short and why there are fewer top predators than herbivores.

### Worked example
Grass contains 10 000 kJ. Rabbits receive 10% = 1000 kJ. Foxes receive 10% of that = 100 kJ.

## Sampling
To estimate the size of a population, use **random quadrats**. Average number per quadrat × total area ÷ quadrat area gives an estimate. For 6 daisies per m² in a 2000 m² field the estimate is 12 000. Larger samples and random placement improve reliability.

## Interdependence in action
Removing or adding one species affects others. If a pesticide kills insects, insect-eating frogs may lose food. A **keystone species**, like the sea otter in a kelp forest, has a large effect on the community. By eating sea urchins, otters stop the urchins from overgrazing the kelp.

## Common mistakes
- Drawing arrows from predator to prey.
- Confusing population, community and ecosystem.
- Saying energy is 'used up'. It is transferred to the environment as heat.
- Treating correlation as proof of cause.

## How this is examined
Questions use a food web or short scenario and ask you to predict the effects of removing a species, calculate energy transfer or population estimates, and evaluate sampling methods. Extended items ask you to link a human action (pesticide, introduced species) to knock-on effects through the web.

Exam tip: For 'predict' questions, trace the effect one link at a time (who eats it, who it eats) and use the words 'increase', 'decrease' and 'because'.$mq$ from st;

-- Biotechnology > Genome Mapping and Genetic Testing
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Biotechnology$mq$, 5, 4 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Genome Mapping and Genetic Testing$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 5 and p.name = $mq$Biotechnology$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Genome Mapping and Genetic Testing$mq$ and p.name = $mq$Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a genome?$mq$, $mq$["All the genetic material (DNA) of an organism","A single gene","A type of protein","A cell organelle"]$mq$, 0, $mq$The genome is the complete set of DNA in an organism, including all of its genes.$mq$, $mq$easy$mq$),
($mq$Which four bases make up DNA?$mq$, $mq$["Adenine, uracil, cytosine, guanine","Adenine, thymine, glucose, guanine","Alanine, thymine, cytosine, guanine","Adenine, thymine, cytosine, guanine"]$mq$, 3, $mq$DNA bases are A, T, C and G. Uracil is found in RNA, not DNA.$mq$, $mq$easy$mq$),
($mq$In DNA, which bases pair together?$mq$, $mq$["A with C, and T with G","A with G, and C with T","A with T, and C with G","A with A, and C with C"]$mq$, 2, $mq$Complementary base pairing: adenine pairs with thymine and cytosine pairs with guanine.$mq$, $mq$easy$mq$),
($mq$What was the aim of the Human Genome Project, completed in 2003?$mq$, $mq$["To clone a human","To determine the sequence of the human genome","To cure all diseases","To create new species"]$mq$, 1, $mq$The project mapped and sequenced the human genome, which has about 3 billion base pairs.$mq$, $mq$easy$mq$),
($mq$Which of these is an example of a genetic disorder?$mq$, $mq$["Cystic fibrosis","Influenza","A broken leg","Sunburn"]$mq$, 0, $mq$Cystic fibrosis is caused by a faulty allele of a gene that can be inherited. Influenza is caused by a virus.$mq$, $mq$easy$mq$),
($mq$What is the main purpose of genetic testing?$mq$, $mq$["To make people taller","To check if someone has eaten a balanced diet","To change a person's genes","To look for changes in DNA that may cause or increase the risk of a disease"]$mq$, 3, $mq$Genetic tests look for particular alleles or chromosome changes linked to disease. They do not alter a person's genes.$mq$, $mq$medium$mq$),
($mq$Cystic fibrosis is caused by a recessive allele. Two parents who are both carriers (Ff) have a child. What is the probability that the child has cystic fibrosis?$mq$, $mq$["50%","75%","25%","0%"]$mq$, 2, $mq$A Punnett square gives FF, Ff, Ff, ff. Only ff (1 out of 4 = 25%) has the disorder.$mq$, $mq$medium$mq$),
($mq$Huntington's disease is caused by a dominant allele. If one parent is heterozygous (Hh) and the other is hh, what is the chance a child inherits the disease?$mq$, $mq$["25%","50%","75%","100%"]$mq$, 1, $mq$Crossing Hh × hh gives half Hh (affected) and half hh (unaffected).$mq$, $mq$medium$mq$),
($mq$Why can a genome map be useful to doctors?$mq$, $mq$["It helps locate genes linked to diseases and design tests or treatments","It tells doctors a patient's exact future","It replaces all medical tests","It is only useful for plants"]$mq$, 0, $mq$Knowing where genes are and what they do helps researchers find disease-linked alleles and develop targeted treatments. It rarely gives certain predictions.$mq$, $mq$medium$mq$),
($mq$A newborn baby is tested for a rare but treatable genetic disorder. What is a benefit of this screening?$mq$, $mq$["It prevents the baby from ever having the allele","It changes the baby's DNA","It makes the disorder dominant","Early treatment can begin before serious symptoms develop"]$mq$, 3, $mq$Early detection allows treatment or dietary management to start sooner. It does not remove the allele.$mq$, $mq$medium$mq$),
($mq$Which is an ethical concern about genetic testing?$mq$, $mq$["Tests are always inaccurate","Genetic tests change the person's DNA","Insurance companies or employers might misuse the results","Tests are only possible for animals"]$mq$, 2, $mq$Privacy and discrimination are major concerns. Results could affect insurance, employment or family relationships.$mq$, $mq$medium$mq$),
($mq$Which statement best explains why identical twins have almost identical DNA profiles but are not identical in every way?$mq$, $mq$["They do not share any DNA","Environment and lifestyle also affect characteristics","Genes never affect characteristics","Twins have different genomes entirely"]$mq$, 1, $mq$Identical twins come from one fertilised egg and share DNA. Differences in diet, activity and environment can lead to different characteristics.$mq$, $mq$medium$mq$),
($mq$A DNA strand has the base sequence A-T-G-C-C-A. What is the sequence on the complementary strand?$mq$, $mq$["T-A-C-G-G-T","A-T-G-C-C-A","U-A-C-G-G-U","T-A-C-C-G-T"]$mq$, 0, $mq$A pairs with T, T with A, G with C, C with G, C with G and A with T, giving T-A-C-G-G-T.$mq$, $mq$medium$mq$),
($mq$A genetic test shows a woman carries a harmful allele that increases her risk of a cancer from 12% to 60% over her lifetime. Which interpretation is most accurate?$mq$, $mq$["She definitely will develop cancer","She cannot develop cancer","The test proves the cancer is already present","She has a higher risk but it is not certain she will develop cancer"]$mq$, 3, $mq$A risk allele increases probability but does not guarantee disease. Lifestyle and other genes play a part.$mq$, $mq$hard$mq$),
($mq$A family history suggests a faulty recessive allele. A child has the disorder (ff). Neither parent has it. What can be concluded about the parents?$mq$, $mq$["Both parents must be FF","One parent must be ff","Both parents must be carriers (Ff)","Neither parent has the allele"]$mq$, 2, $mq$The child inherited one f from each parent. Because the parents are unaffected, they must each be Ff.$mq$, $mq$hard$mq$),
($mq$A genome has 3.2 billion base pairs and a particular gene is 27 000 base pairs long. What percentage of the genome does this gene make up (to 3 significant figures)?$mq$, $mq$["0.00844%","0.000844%","0.0844%","0.844%"]$mq$, 1, $mq$27 000 ÷ 3 200 000 000 = 0.000008438, which is 0.000844% to 3 significant figures. Genes are a very small fraction of the genome.$mq$, $mq$hard$mq$),
($mq$Parents are offered a test to find out whether an unborn baby has a serious genetic disorder. Which statement represents a balanced evaluation?$mq$, $mq$["The test offers information to prepare or make decisions, but may cause anxiety and raises ethical questions about what to do with results","The test should always be compulsory","The test has no risks or ethical issues","The test can cure the disorder"]$mq$, 0, $mq$A balanced answer weighs benefits (information, preparation) against drawbacks (stress, ethical and social issues, possible errors).$mq$, $mq$hard$mq$),
($mq$Scientists compare the DNA of a crime scene sample with two suspects. Suspect A matches 13 of 13 markers; Suspect B matches 4 of 13. Which conclusion is most reasonable?$mq$, $mq$["Suspect B is guilty","DNA profiling is never reliable","Suspect A is guilty with no other evidence needed","Suspect A's DNA matches strongly and B's does not, but DNA is one piece of evidence to be combined with others"]$mq$, 3, $mq$The match is strong for A. A careful conclusion notes that the sample could be contaminated, that relatives share DNA, and that other evidence is also needed.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Genome Mapping and Genetic Testing$mq$ and p.name = $mq$Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Genome$mq$, $mq$The complete set of DNA in an organism. The human genome has about 3 billion base pairs.$mq$),
($mq$Complementary base pairs in DNA$mq$, $mq$A pairs with T. C pairs with G.$mq$),
($mq$Human Genome Project$mq$, $mq$International project that determined the sequence of human DNA. Completed in 2003.$mq$),
($mq$Gene vs allele$mq$, $mq$A gene is a section of DNA coding for a protein. An allele is a version of a gene.$mq$),
($mq$Cystic fibrosis inheritance$mq$, $mq$Caused by a recessive allele. Two carriers (Ff × Ff) have a 25% chance of an affected child.$mq$),
($mq$Huntington's disease inheritance$mq$, $mq$Caused by a dominant allele. One copy is enough. Hh × hh gives a 50% chance of an affected child.$mq$),
($mq$Genetic test$mq$, $mq$A test that looks for specific alleles or chromosome changes. It reads DNA; it does not change it.$mq$),
($mq$Ethical issues of genetic testing$mq$, $mq$Privacy, discrimination by insurers or employers, anxiety, decisions about pregnancy and embryos.$mq$),
($mq$DNA profiling$mq$, $mq$Comparing variable regions of DNA to link a sample to a person or to test family relationships.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Genome Mapping and Genetic Testing$mq$ and p.name = $mq$Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Biotechnology uses living things, or parts of living things, to make products or solve problems. Mapping the human genome and testing for genetic conditions are major examples. They show how biology, medicine and ethics meet.

## DNA, genes and the genome
**DNA** is a double helix made of two strands joined by pairs of bases. The four bases are **adenine (A), thymine (T), cytosine (C) and guanine (G)**. A always pairs with T, and C always pairs with G (complementary base pairing). A **gene** is a section of DNA that codes for a protein. The **genome** is all the DNA of an organism. The human genome has about 3 billion base pairs and around 20 000 protein-coding genes.

## Genome mapping
The **Human Genome Project** was an international research effort that determined the sequence of bases in human DNA. It was completed in 2003. Sequencing means reading the order of the bases. Mapping means finding where genes are on the chromosomes. Genome information helps scientists to:
- find alleles linked to inherited disorders
- design medicines suited to a person's genes
- compare species to study evolution.
Sequencing technology has become much faster and cheaper since the project.

## Genetic disorders and inheritance
Some disorders are caused by faulty alleles.
- **Cystic fibrosis** is caused by a recessive allele. A child needs two copies (ff). Two carriers (Ff × Ff) have a 25% chance of an affected child.
- **Huntington's disease** is caused by a dominant allele. One copy is enough. Hh × hh gives a 50% chance of an affected child.

## Genetic testing
A **genetic test** looks for specific alleles or changes in chromosomes. Uses include:
- **carrier testing** for people planning a family
- **prenatal testing** during pregnancy
- **newborn screening** so treatment can start early
- **testing for risk alleles**, such as those that raise the risk of some cancers.
A risk allele raises probability but does not guarantee the disease. Lifestyle and other genes also matter.

## DNA profiling
DNA profiling compares patterns in parts of the DNA that vary between people. It is used to link a sample to a person in forensic work or to test family relationships. Identical twins share DNA profiles.

## Benefits, risks and ethics
- Benefits: early diagnosis, treatment planning, informed decisions.
- Risks: anxiety, mistakes, difficulty interpreting probabilities.
- Ethical issues: privacy, discrimination by employers or insurers, who owns genetic data, decisions about embryos and pregnancy.

## Common mistakes
- Saying a genetic test 'changes' DNA. It only reads it.
- Treating a risk allele as a certain diagnosis.
- Mixing up gene, allele and genome.
- Writing U in a DNA sequence. That is RNA.

## How this is examined
Expect a short scenario, such as a family with an inherited disorder, with a Punnett square or probability question, followed by 'discuss' or 'evaluate' about the ethics of testing. Quality answers weigh benefits against concerns, use correct terms and refer to the evidence in the stem.

Exam tip: For 'discuss' questions, give at least one benefit and one concern, link each to the scenario, and end with a short judgement.$mq$ from st;

-- Biotechnology > 3D Bioprinting and Tissue Engineering
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Biotechnology$mq$, 5, 4 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$3D Bioprinting and Tissue Engineering$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 5 and p.name = $mq$Biotechnology$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$3D Bioprinting and Tissue Engineering$mq$ and p.name = $mq$Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is 3D bioprinting?$mq$, $mq$["Building structures layer by layer using bio-ink that contains living cells","Printing a picture of an organ on paper","Cloning a whole animal","Growing plants in a greenhouse"]$mq$, 0, $mq$A bioprinter deposits bio-ink (cells in a supportive gel) in layers to build tissue-like structures.$mq$, $mq$easy$mq$),
($mq$What is tissue engineering?$mq$, $mq$["Removing tissues from a body","Studying fossils","Changing the weather","Making or repairing tissues using cells, scaffolds and growth factors"]$mq$, 3, $mq$Tissue engineering combines cells, a supporting structure (scaffold) and signals to create or repair tissue.$mq$, $mq$easy$mq$),
($mq$Why is there a need for new methods to make organs and tissues?$mq$, $mq$["Organs are never needed","Transplants cause no problems","There are not enough organ donors for everyone who needs a transplant","Everyone has spare organs"]$mq$, 2, $mq$Demand for organs is higher than the supply of donors, so many patients wait a long time.$mq$, $mq$easy$mq$),
($mq$Which type of cell can develop into many different cell types?$mq$, $mq$["Red blood cell","Stem cell","Nerve cell","Skin cell that is fully specialised"]$mq$, 1, $mq$Stem cells are unspecialised and can differentiate into different types of specialised cells.$mq$, $mq$easy$mq$),
($mq$Which of the following could be made by bioprinting or tissue engineering today in research or early clinical use?$mq$, $mq$["Skin and cartilage","A complete working human brain","A fully working heart ready for all patients","A new species"]$mq$, 0, $mq$Simple tissues such as skin and cartilage are the most advanced. Complex organs with many tissue types and blood vessels remain a research challenge.$mq$, $mq$easy$mq$),
($mq$In tissue engineering, what is the role of a scaffold?$mq$, $mq$["It kills bacteria in the body","It provides all the energy for cells","It is the final organ","It supports cells and gives the tissue shape while it grows"]$mq$, 3, $mq$A scaffold gives structure so cells can attach, grow and organise. Some scaffolds dissolve as the new tissue forms.$mq$, $mq$medium$mq$),
($mq$Why is using a patient's own cells to build a tissue an advantage?$mq$, $mq$["It makes the tissue grow faster than natural tissue","It stops the need for any doctors","It reduces the risk of the immune system rejecting the tissue","It makes the tissue immune to all disease"]$mq$, 2, $mq$Cells from the patient have the same antigens, so the immune system is less likely to attack them. Immunosuppressant drugs may be unnecessary.$mq$, $mq$medium$mq$),
($mq$A burns patient receives skin grown from their own cells. Which benefit is most likely?$mq$, $mq$["No scarring at all in every case","Less chance of rejection than skin from a donor","The skin grows instantly","The patient will never need further treatment"]$mq$, 1, $mq$Using the patient's own cells lowers the risk of rejection. Results vary and treatment may still be needed.$mq$, $mq$medium$mq$),
($mq$Which sequence best describes how a tissue may be made using bioprinting?$mq$, $mq$["Collect cells, mix with a gel to make bio-ink, print in layers, then culture the tissue","Print the tissue, then collect cells","Remove the gel and discard cells","Freeze cells permanently"]$mq$, 0, $mq$Cells are collected and multiplied, mixed with a hydrogel to form bio-ink, printed according to a digital design and then kept in suitable conditions to mature.$mq$, $mq$medium$mq$),
($mq$Why must the printed cells be kept at about 37°C with nutrients and oxygen after printing?$mq$, $mq$["Cold makes cells divide faster","Cells need no oxygen","Heat destroys the gel","Living cells need suitable conditions to survive and grow"]$mq$, 3, $mq$Human cells need warmth, nutrients, oxygen and removal of waste, similar to conditions in the body.$mq$, $mq$medium$mq$),
($mq$Which statement describes an advantage of bioprinted tissue for testing new medicines?$mq$, $mq$["Drugs do not need to be tested","Printed tissue can predict all effects perfectly","Drugs can be tested on human tissue without using patients or, in some cases, animals","It replaces all clinical trials"]$mq$, 2, $mq$Printed tissues can model how human cells respond to drugs, which may reduce animal testing. However they cannot perfectly copy a whole body.$mq$, $mq$medium$mq$),
($mq$Which of these is a major challenge in printing a large organ such as a kidney?$mq$, $mq$["Finding a printer large enough only","Creating a network of blood vessels to supply all the cells with oxygen and nutrients","Making the cells invisible","Keeping the cells cold"]$mq$, 1, $mq$Cells deeper than a few tenths of a millimetre from a blood supply cannot get enough oxygen. Vascularisation is a major challenge.$mq$, $mq$medium$mq$),
($mq$What is the main reason embryonic stem cells raise ethical debate?$mq$, $mq$["They are obtained from early embryos, which some people believe have a right to life","They are too cheap","They cannot divide","They are only found in plants"]$mq$, 0, $mq$Using embryonic stem cells involves embryos. Adult stem cells and induced pluripotent stem cells avoid some of these concerns.$mq$, $mq$medium$mq$),
($mq$A bioprinted cartilage sample was 2 mm thick. Within 7 days, 90% of cells in the centre die, but surface cells survive. What is the best explanation?$mq$, $mq$["Surface cells are poisonous","The centre is too hot","Cells die when they are touched","Oxygen and nutrients cannot diffuse far enough to the centre"]$mq$, 3, $mq$Diffusion is only effective over very short distances. Without blood vessels, cells deep in a thick tissue are starved of oxygen and nutrients.$mq$, $mq$hard$mq$),
($mq$A researcher tests a drug on 5 samples of bioprinted liver tissue. Four show reduced function and one shows no change. Which statement is the most reasonable?$mq$, $mq$["The drug is proven safe","The drug is proven harmful in all humans","The drug probably affects liver tissue, but more samples and a control group are needed","The experiment is useless"]$mq$, 2, $mq$Four out of five suggests an effect, but a small sample size and no control weaken the conclusion. A full evaluation also notes tissue models differ from real organs.$mq$, $mq$hard$mq$),
($mq$A hospital must decide whether to spend its budget on a bioprinter for skin or on more beds. Which statement gives the best balanced argument?$mq$, $mq$["Bioprinting is always the better choice","Bioprinting could improve burn treatment in the future but is costly and still developing, so this should be weighed against immediate needs","Beds are never important","Technology has no costs"]$mq$, 1, $mq$A balanced judgement considers cost, how developed the technology is, potential benefits and alternative uses of funds.$mq$, $mq$hard$mq$),
($mq$Which statement explains why a bioprinted organ made from a patient's induced pluripotent stem cells could still carry risks?$mq$, $mq$["Uncontrolled cell division could form tumours and long-term safety is not fully known","The cells are not living","The organ would always be rejected","The cells cannot divide"]$mq$, 0, $mq$Stem cells divide readily and a small number could grow abnormally. Long-term safety needs thorough testing.$mq$, $mq$hard$mq$),
($mq$A student says: 'Bioprinting will solve the organ shortage next year.' Which evaluation is best?$mq$, $mq$["Correct; all organs can already be printed","Incorrect; bioprinting cannot print any living cells","Correct; regulation is not required","Overstated; simple tissues are advancing, but complex organs need blood vessels, function testing and regulation, which will take much longer"]$mq$, 3, $mq$A good evaluation separates what has been achieved (simple tissues, models for testing) from what is still experimental (whole, long-lasting organs).$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$3D Bioprinting and Tissue Engineering$mq$ and p.name = $mq$Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$3D bioprinting$mq$, $mq$Building tissue layer by layer using bio-ink, which is living cells mixed with a supporting gel.$mq$),
($mq$Tissue engineering$mq$, $mq$Making or repairing tissue using cells, a scaffold and growth factors in suitable conditions.$mq$),
($mq$Stem cell$mq$, $mq$An unspecialised cell that can divide and differentiate into different types of specialised cells.$mq$),
($mq$Role of a scaffold$mq$, $mq$Supports cells and gives the tissue shape while it grows. Some scaffolds dissolve as new tissue forms.$mq$),
($mq$Why use the patient's own cells?$mq$, $mq$They carry the patient's antigens, so the risk of immune rejection is lower.$mq$),
($mq$Transplant rejection$mq$, $mq$The immune system attacks the donor organ because it recognises foreign antigens.$mq$),
($mq$Main challenge in printing large organs$mq$, $mq$Making blood vessels. Cells far from a blood supply cannot get oxygen and nutrients by diffusion.$mq$),
($mq$Tissues most successfully bioprinted so far$mq$, $mq$Simple tissues such as skin and cartilage.$mq$),
($mq$Ethical issues with stem cells and bioprinting$mq$, $mq$Use of embryos for embryonic stem cells, cost and fairness of access, safety such as tumour risk.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$3D Bioprinting and Tissue Engineering$mq$ and p.name = $mq$Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Tissue engineering and 3D bioprinting aim to build new tissue to replace damaged parts of the body. They are growing areas of biotechnology and link biology with engineering, medicine and ethics.

## The problem they try to solve
Many people need organ transplants, but there are far fewer donors than patients. Transplanted organs may also be **rejected**: the immune system recognises the foreign antigens on donor cells and attacks them. Patients often have to take drugs to suppress the immune system, which increases the risk of infection.

## Tissue engineering
Tissue engineering combines three main ingredients:
- **Cells**, often the patient's own, or **stem cells** that can develop into different cell types.
- A **scaffold**, a framework that supports the cells and gives the tissue shape. Some scaffolds slowly dissolve as new tissue forms.
- **Growth factors** and suitable conditions (about 37°C, nutrients, oxygen) so the cells divide and specialise.
Stem cells can come from embryos (embryonic stem cells), from adult tissues such as bone marrow, or can be made from adult cells by reprogramming (induced pluripotent stem cells).

## 3D bioprinting
A **bioprinter** works like a 3D printer, but its 'ink' is **bio-ink**: living cells mixed with a gel. Steps:
- collect cells from the patient
- grow more cells in the lab
- mix with gel to make bio-ink
- print layer by layer following a digital design
- keep the printed tissue in an incubator so it matures.
Bioprinting can place different cell types in exact positions. Skin and cartilage have been the most successful tissues. Printed tissue is also used to test drugs, which may reduce the need for animal testing.

## Challenges
- **Blood supply:** cells more than a fraction of a millimetre from a blood vessel cannot get enough oxygen by diffusion, so thick tissues die in the middle. Printing networks of blood vessels is a big challenge.
- **Complex organs** such as the heart have many cell types working together.
- **Cost, safety and regulation:** long-term safety must be tested. Stem cells can sometimes divide abnormally.
- **Ethical concerns:** use of embryonic stem cells, fairness of access and long-term effects.

## Benefits
- Reduced rejection when using the patient's own cells.
- Less waiting for donors.
- Safer, more human-relevant drug testing.

## Common mistakes
- Saying scientists can already print any organ.
- Forgetting why blood vessels are needed (oxygen and nutrient supply by diffusion).
- Confusing stem cells (unspecialised) with specialised cells.
- Presenting only one side in an ethics question.

## How this is examined
This topic fits Criterion D style questions on the impact of science. You might read a short report on a bioprinted skin graft, then explain why own cells reduce rejection, interpret data on cell survival, or discuss benefits and limitations for different groups. Expect command words such as describe, explain, discuss and evaluate.

Exam tip: When evaluating a new technology, give a benefit, a limitation, and a clear judgement about how ready it is, using evidence from the question.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('biology')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;