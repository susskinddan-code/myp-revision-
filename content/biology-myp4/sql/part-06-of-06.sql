-- Part 6 of 6: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Disease and Immunity > Defences, Antibodies and Vaccination
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Disease and Immunity$mq$, 4, 11 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Defences, Antibodies and Vaccination$mq$, 4, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Disease and Immunity$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Defences, Antibodies and Vaccination$mq$ and p.name = $mq$Disease and Immunity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which part of the body is the first barrier against pathogens?$mq$, $mq$["Skin","Kidney","Liver","Heart"]$mq$, 0, $mq$Unbroken skin is a physical barrier that stops pathogens entering the body.$mq$, $mq$easy$mq$),
($mq$Which white blood cells make antibodies?$mq$, $mq$["Phagocytes","Platelets","Red blood cells","Lymphocytes"]$mq$, 3, $mq$Lymphocytes make antibodies that are specific to a particular antigen.$mq$, $mq$easy$mq$),
($mq$What do phagocytes do to pathogens?$mq$, $mq$["Make antibodies for them","Form clots around them","Engulf and digest them","Release hormones"]$mq$, 2, $mq$Phagocytes surround pathogens and digest them by phagocytosis.$mq$, $mq$easy$mq$),
($mq$What is a harmless form of a pathogen put into the body to give immunity called?$mq$, $mq$["Antibiotic","Vaccine","Antibody","Antitoxin"]$mq$, 1, $mq$A vaccine contains dead, weakened or part of a pathogen, so it triggers an immune response without causing illness.$mq$, $mq$easy$mq$),
($mq$What sticky substance in the nose and trachea traps pathogens?$mq$, $mq$["Mucus","Bile","Plasma","Sweat"]$mq$, 0, $mq$Mucus traps pathogens and dust, and cilia move it away from the lungs.$mq$, $mq$easy$mq$),
($mq$What name is given to a molecule on the surface of a pathogen that triggers an immune response?$mq$, $mq$["Antibody","Antibiotic","Antitoxin","Antigen"]$mq$, 3, $mq$Antigens are recognised by lymphocytes as foreign, and trigger antibody production.$mq$, $mq$medium$mq$),
($mq$Antibodies are specific. What does this mean?$mq$, $mq$["They match any pathogen","They are only made by phagocytes","Each type matches only one antigen","They can only work once"]$mq$, 2, $mq$An antibody has a shape that fits one antigen, like a key in a lock.$mq$, $mq$medium$mq$),
($mq$Which cells stay in the blood after an infection and allow a faster response the next time?$mq$, $mq$["Red blood cells","Memory cells","Platelets","Phagocytes"]$mq$, 1, $mq$Memory cells remember the antigen, so antibodies are made quickly if the same pathogen returns.$mq$, $mq$medium$mq$),
($mq$Who developed the first vaccine, against smallpox, in 1796?$mq$, $mq$["Edward Jenner","Louis Pasteur","Alexander Fleming","Charles Darwin"]$mq$, 0, $mq$Edward Jenner showed that infection with cowpox protected people from smallpox.$mq$, $mq$medium$mq$),
($mq$What is meant by herd immunity?$mq$, $mq$["Only children are vaccinated","Every person is immune to every disease","Animals are vaccinated against disease","Enough people are immune to limit the spread"]$mq$, 3, $mq$If a large proportion of a population is immune, the pathogen finds it hard to spread, which protects those who are not immune.$mq$, $mq$medium$mq$),
($mq$Why can a vaccine not cause the disease it protects against?$mq$, $mq$["It contains antibiotics","It contains antibodies","The pathogen in it is dead or weakened","It contains no antigens"]$mq$, 2, $mq$Vaccines contain dead or weakened pathogens, or parts of them. They still contain antigens, so they trigger an immune response.$mq$, $mq$medium$mq$),
($mq$How does the second immune response to a pathogen compare with the first?$mq$, $mq$["Slower and smaller","Faster and larger","The same speed","There is no response"]$mq$, 1, $mq$Memory cells produce a higher concentration of antibodies more quickly the second time.$mq$, $mq$medium$mq$),
($mq$In a trial, 1000 vaccinated children and 1000 unvaccinated children were followed. 20 vaccinated and 400 unvaccinated children caught the disease. What percentage of the vaccinated children caught the disease?$mq$, $mq$["2%","40%","20%","98%"]$mq$, 0, $mq$20 ÷ 1000 × 100 = 2%. In the unvaccinated group the figure was 40%.$mq$, $mq$medium$mq$),
($mq$Why is a new flu vaccine needed almost every year?$mq$, $mq$["Flu is caused by a bacterium","Memory cells die within a week","Vaccines contain antibiotics that wear out","The flu virus mutates, so its antigens change"]$mq$, 3, $mq$Mutations change the antigens on the virus, so antibodies made against the old form may not recognise the new one.$mq$, $mq$hard$mq$),
($mq$After the first exposure to an antigen, the antibody level peaks at 10 units. After the second exposure it peaks at 80 units. How many times higher is the second peak?$mq$, $mq$["0.125","70","8","80"]$mq$, 2, $mq$80 ÷ 10 = 8 times higher.$mq$, $mq$hard$mq$),
($mq$Why does a vaccine not cure someone who is already ill with the disease?$mq$, $mq$["Vaccines kill the patient's cells","Immune memory takes time to develop","Vaccines contain no antigens","Ill people cannot make antibodies"]$mq$, 1, $mq$A vaccine prepares the immune system for future infection. The response takes days to build up, and the infection is already under way.$mq$, $mq$hard$mq$),
($mq$A disease needs 95% of the population to be immune to achieve herd immunity. The population is 20 000. How many people must be immune?$mq$, $mq$["19000","1000","9500","19500"]$mq$, 0, $mq$95% of 20 000 = 0.95 × 20 000 = 19 000.$mq$, $mq$hard$mq$),
($mq$Some babies are too young to be vaccinated. Why does a high vaccination rate in the rest of the population protect them?$mq$, $mq$["Antibiotics are passed on","The babies make antibodies from the vaccine","The pathogen becomes extinct","It gives herd immunity"]$mq$, 3, $mq$If few people can carry the pathogen, the babies are less likely to be exposed to it.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Defences, Antibodies and Vaccination$mq$ and p.name = $mq$Disease and Immunity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$First line of defence$mq$, $mq$Skin, mucus and cilia, and stomach acid stop pathogens entering the body.$mq$),
($mq$Phagocyte$mq$, $mq$A white blood cell that engulfs and digests pathogens (phagocytosis). It is not specific.$mq$),
($mq$Lymphocyte$mq$, $mq$A white blood cell that makes antibodies specific to one antigen.$mq$),
($mq$Antigen vs antibody$mq$, $mq$An antigen is a molecule on a pathogen. An antibody is a protein made by lymphocytes that fits one antigen.$mq$),
($mq$Memory cells$mq$, $mq$Stay in the blood after an infection and produce antibodies faster and in greater amounts if the pathogen returns.$mq$),
($mq$How does a vaccine work?$mq$, $mq$It contains dead or weakened pathogens or their antigens. They trigger lymphocytes to make antibodies and memory cells, without causing disease.$mq$),
($mq$Herd immunity$mq$, $mq$When enough of a population is immune that the pathogen cannot spread easily, which also protects people who are not immune.$mq$),
($mq$Why does flu need a new vaccine each year?$mq$, $mq$The flu virus mutates, so its antigens change and old antibodies may not recognise them.$mq$),
($mq$Who developed the first vaccine?$mq$, $mq$Edward Jenner developed the smallpox vaccine in 1796 using cowpox.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Defences, Antibodies and Vaccination$mq$ and p.name = $mq$Disease and Immunity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$The body has several lines of defence against pathogens. The first stops them getting in, and the second destroys any that do.

## First line: barriers
- **Skin**: a tough physical barrier. If it is cut, platelets form a clot to seal the wound.
- **Mucus and cilia**: in the nose, trachea and bronchi, sticky mucus traps pathogens and cilia sweep it away.
- **Stomach acid**: hydrochloric acid kills most pathogens in food and drink.

## Second line: white blood cells
- **Phagocytes** engulf pathogens and digest them. This is phagocytosis. Phagocytes are not specific, they attack anything that is foreign.
- **Lymphocytes** produce **antibodies**. Each lymphocyte recognises one type of **antigen**, which is a molecule on the surface of a pathogen. When a lymphocyte meets its antigen, it divides to make many cells that produce large amounts of the matching antibody. The antibodies bind to pathogens, clump them together and mark them for destruction by phagocytes. Some lymphocytes also release antitoxins that neutralise toxins.
- **Memory cells** stay in the blood after the infection. If the same antigen appears again, memory cells make the correct antibody much faster and in larger amounts. This second response often destroys the pathogen before you feel ill. This is immunity.

## Vaccination
A **vaccine** contains dead or weakened pathogens, or just their antigens. It cannot cause the disease, but the antigens trigger lymphocytes to make antibodies and memory cells. If the real pathogen arrives later, the immune response is fast and strong. Edward Jenner developed the first vaccine, for smallpox, in 1796. Smallpox has now been eradicated.

Some vaccines need booster doses to maintain the level of memory cells. Viruses that mutate quickly, such as influenza, need new vaccines regularly because their antigens change.

## Herd immunity
When a high proportion of a population is vaccinated, the pathogen cannot spread easily, so people who cannot be vaccinated, such as very young babies or those with weak immune systems, are also protected. For a highly infectious disease such as measles, around 95% of the population needs to be immune. If 95% of 20 000 people are immune, that is 0.95 × 20 000 = 19 000 people.

## Evaluating vaccines
Benefits: prevent serious illness and death, can eradicate disease, protect others. Risks: minor side effects such as a sore arm or mild fever are common, and serious reactions are very rare. A vaccine does not cure an existing infection.

## Worked example
Trial results: 20 of 1000 vaccinated children caught the disease, compared with 400 of 1000 unvaccinated children. Percentage of vaccinated children = 20 ÷ 1000 × 100 = 2%. Percentage of unvaccinated children = 40%. The vaccine reduced the risk by a large amount.

## Common mistakes
- Saying that vaccines contain antibodies. They contain antigens.
- Mixing up antigens (on the pathogen) and antibodies (made by lymphocytes).
- Saying that antibiotics give immunity. Antibiotics are drugs that kill bacteria.
- Saying that phagocytes make antibodies.

## How this is examined
You may be given a graph of antibody concentration after a first and second exposure, a vaccination trial, or a vaccination coverage map. You are expected to describe the pattern using values, to explain it using memory cells and to evaluate vaccination programmes.

Exam tip: in graph questions, describe first, quoting values with units (for example "the peak is 8 times higher"), and then explain using the words antigen, antibody and memory cells.$mq$ from st;

-- Variation, Natural Selection and Evolution > Causes of Variation and Mutations
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Variation, Natural Selection and Evolution$mq$, 4, 12 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Causes of Variation and Mutations$mq$, 4, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Variation, Natural Selection and Evolution$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Causes of Variation and Mutations$mq$ and p.name = $mq$Variation, Natural Selection and Evolution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What are the differences between individuals of the same species called?$mq$, $mq$["Variation","Extinction","Evolution","Adaptation"]$mq$, 0, $mq$Variation means that individuals of the same species are not identical.$mq$, $mq$easy$mq$),
($mq$What is a random change in the DNA of an organism called?$mq$, $mq$["Digestion","Adaptation","Fertilisation","Mutation"]$mq$, 3, $mq$A mutation is a change in the sequence of bases in DNA. It can alter a gene.$mq$, $mq$easy$mq$),
($mq$Which type of radiation from the Sun can cause mutations in skin cells?$mq$, $mq$["Infrared radiation","Radio waves","Ultraviolet radiation","Sound waves"]$mq$, 2, $mq$UV radiation can damage DNA in skin cells, which may lead to skin cancer.$mq$, $mq$easy$mq$),
($mq$Which characteristic shows continuous variation?$mq$, $mq$["Attached earlobes","Height","ABO blood group","Sex"]$mq$, 1, $mq$Height can take any value within a range, so it shows continuous variation.$mq$, $mq$easy$mq$),
($mq$Which characteristic is controlled only by genes?$mq$, $mq$["ABO blood group","Body mass","Suntan","Muscle size"]$mq$, 0, $mq$Blood group is inherited and is not changed by diet or lifestyle. The other characteristics are affected by the environment.$mq$, $mq$easy$mq$),
($mq$Cuttings from the same parent plant are grown in different soils and reach different heights. What causes the variation?$mq$, $mq$["Mutation","Different alleles","Random fertilisation","The environment"]$mq$, 3, $mq$Cuttings are clones, so they have the same alleles. The differences must be caused by the environment.$mq$, $mq$medium$mq$),
($mq$Which process in sexual reproduction gives gametes different combinations of alleles?$mq$, $mq$["Binary fission","Mitosis","Meiosis","Photosynthesis"]$mq$, 2, $mq$In meiosis the chromosomes are shuffled, so each gamete is genetically different.$mq$, $mq$medium$mq$),
($mq$The heights of 100 students are grouped into ranges of 5 cm. What is the best way to display this data?$mq$, $mq$["Pie chart","Histogram","Scatter graph","Pictogram"]$mq$, 1, $mq$Continuous data are shown as a histogram, where the bars touch because the ranges are continuous.$mq$, $mq$medium$mq$),
($mq$A mutation in which type of cell can be passed on to offspring?$mq$, $mq$["Gametes","Skin cells","Liver cells","Muscle cells"]$mq$, 0, $mq$Only mutations in the gametes (sperm and egg cells) can be inherited by the next generation.$mq$, $mq$medium$mq$),
($mq$Chemicals in tobacco smoke increase the rate of mutation in body cells. What are such chemicals called?$mq$, $mq$["Antibodies","Enzymes","Hormones","Mutagens"]$mq$, 3, $mq$A mutagen is a substance that increases the rate of mutation. Mutations in the cells of the lungs can cause cancer.$mq$, $mq$medium$mq$),
($mq$Sickle cell anaemia is caused by a mutation in the gene for which protein?$mq$, $mq$["Amylase","Insulin","Haemoglobin","Keratin"]$mq$, 2, $mq$A change in one base alters the haemoglobin molecule, so red blood cells become sickle-shaped.$mq$, $mq$medium$mq$),
($mq$Five seedlings have heights of 12 cm, 15 cm, 11 cm, 14 cm and 13 cm. What is the range of heights in cm?$mq$, $mq$["13","4","15","11"]$mq$, 1, $mq$Range = highest − lowest = 15 − 11 = 4 cm.$mq$, $mq$medium$mq$),
($mq$What is the mean height of the five seedlings (12, 15, 11, 14 and 13 cm), in cm?$mq$, $mq$["13","4","14","65"]$mq$, 0, $mq$Total = 12 + 15 + 11 + 14 + 13 = 65. Mean = 65 ÷ 5 = 13 cm.$mq$, $mq$medium$mq$),
($mq$Identical twins have different body masses as adults. What is the best explanation?$mq$, $mq$["They have different DNA sequences","A mutation at fertilisation","They have different numbers of chromosomes","They had different diets and lifestyles"]$mq$, 3, $mq$Identical twins have the same genotype, so differences come from the environment, such as diet and exercise.$mq$, $mq$hard$mq$),
($mq$Most mutations have no effect on the phenotype. What is one reason?$mq$, $mq$["Mutations are always repaired","Mutations only occur in dead cells","Many do not change the protein that is made","Mutations always make new proteins"]$mq$, 2, $mq$Many mutations occur in parts of DNA that do not code for a protein, or change the protein very little.$mq$, $mq$hard$mq$),
($mq$People with one sickle cell allele are more resistant to malaria. Why is the allele common in regions where malaria is common?$mq$, $mq$["The allele protects against all diseases","Carriers are more likely to survive and pass on the allele","Malaria causes the allele","Everyone there has two copies"]$mq$, 1, $mq$Carriers survive malaria better, so they reproduce more and the allele stays common even though two copies cause sickle cell anaemia.$mq$, $mq$hard$mq$),
($mq$Heights of 60 students: 150-154 cm, 3 students; 155-159 cm, 12; 160-164 cm, 21; 165-169 cm, 17; 170-174 cm, 7. Which is the modal class?$mq$, $mq$["160-164 cm","150-154 cm","155-159 cm","165-169 cm"]$mq$, 0, $mq$The modal class is the group with the highest frequency, which is 21 students. The frequencies add to 60.$mq$, $mq$hard$mq$),
($mq$A student says that a suntan will be inherited by her children. What is the best response?$mq$, $mq$["Yes, all characteristics are inherited","Yes, because UV changes all DNA","No, because children never inherit skin colour","No, a tan is not in the DNA of her gametes"]$mq$, 3, $mq$A suntan is an acquired characteristic caused by the environment. Only changes in the DNA of gametes can be inherited.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Causes of Variation and Mutations$mq$ and p.name = $mq$Variation, Natural Selection and Evolution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Variation$mq$, $mq$Differences between individuals of the same species, caused by genes, the environment or both.$mq$),
($mq$Sources of genetic variation$mq$, $mq$Different alleles, meiosis (shuffling of chromosomes), random fertilisation and mutation.$mq$),
($mq$Environmental variation$mq$, $mq$Differences caused by surroundings, such as diet, sunlight, climate and accidents. They are not inherited.$mq$),
($mq$Continuous variation$mq$, $mq$A characteristic with any value in a range, such as height. Shown on a histogram.$mq$),
($mq$Discontinuous variation$mq$, $mq$A characteristic with distinct categories, such as blood group. Shown on a bar chart.$mq$),
($mq$Mutation$mq$, $mq$A random change in the base sequence of DNA. It is the only source of new alleles.$mq$),
($mq$Causes of mutation$mq$, $mq$Copying errors, radiation such as UV light, X-rays and gamma rays, and chemical mutagens such as those in tobacco smoke.$mq$),
($mq$Can a mutation be inherited?$mq$, $mq$Only if it occurs in a gamete (sex cell). Mutations in body cells are not passed to offspring.$mq$),
($mq$Sickle cell anaemia$mq$, $mq$Caused by a mutation in the haemoglobin gene. Carriers with one allele are more resistant to malaria.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Causes of Variation and Mutations$mq$ and p.name = $mq$Variation, Natural Selection and Evolution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Variation means that the individuals of a species are not all identical. Even brothers and sisters differ, and so do the plants in a field. There are two causes: genes and the environment, and most characteristics are affected by both.

## Genetic variation
- **Different alleles**: individuals inherit different combinations of alleles from their parents.
- **Meiosis**: when gametes are made, the chromosomes are shuffled, so every gamete is different.
- **Random fertilisation**: any sperm may fertilise any egg, producing a new combination of alleles.
- **Mutation**: a random change in DNA that produces a new allele. This is the only source of completely new alleles.

## Environmental variation
Differences caused by surroundings include diet, exercise, sunlight, temperature, soil and accidents. A suntan, scars, a language and body mass are examples. These are acquired characteristics. They are not caused by changes to DNA in the gametes and cannot be inherited. Clones or identical twins have the same genes, so any differences are caused by the environment.

## Continuous and discontinuous variation
- **Continuous variation**: a characteristic can have any value in a range, such as height or mass. It is usually affected by many genes and the environment. Data are shown as a histogram, and often form a bell-shaped curve.
- **Discontinuous variation**: there are a few distinct categories, such as ABO blood group. It is often controlled by one gene and not affected by the environment. Data are shown as a bar chart with gaps between the bars.

## Mutations
A mutation is a random change in the sequence of bases in a gene.
- Causes: natural copying errors in DNA, **radiation** such as X-rays, gamma rays and ultraviolet light, and chemicals called **mutagens**, such as those in tobacco smoke.
- Mutations in body cells can cause cancer, but are not inherited. Mutations in gametes can be inherited.
- Most mutations are harmless or harmful. A few are beneficial, and these are the raw material for evolution.

**Example: sickle cell anaemia.** A change in one base in the haemoglobin gene produces abnormal haemoglobin, so red blood cells become sickle-shaped and carry less oxygen. A person with two sickle alleles has the disease. A carrier with one sickle allele does not, and is more resistant to malaria. In regions where malaria is common, carriers survive better, so the allele remains common.

## Worked examples
Five seedlings have heights 12, 15, 11, 14 and 13 cm. Range = 15 − 11 = 4 cm. Mean = (12 + 15 + 11 + 14 + 13) ÷ 5 = 65 ÷ 5 = 13 cm. For grouped data, the modal class is the class with the highest frequency. With heights of 60 students, the group 160-164 cm has 21 students, which is the highest, so it is the modal class.

## Common mistakes
- Saying that mutations are always harmful. Many have no effect and some are beneficial.
- Saying that mutations happen because an organism "needs" them. They are random.
- Saying that acquired characteristics are inherited.
- Using a bar chart with gaps for continuous data. Use a histogram.

## How this is examined
Questions ask you to classify characteristics, to explain the cause of differences between clones or twins, or to process data such as mean, range and modal class. Criterion B tasks may ask you to design an investigation to find if the environment affects plant height, with clear controlled variables.

Exam tip: if you are asked whether a difference is genetic or environmental, check whether the individuals share the same genes. If they do, the difference must be environmental.$mq$ from st;

-- Variation, Natural Selection and Evolution > Natural Selection and the Evidence for Evolution
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Variation, Natural Selection and Evolution$mq$, 4, 12 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Natural Selection and the Evidence for Evolution$mq$, 4, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Variation, Natural Selection and Evolution$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Natural Selection and the Evidence for Evolution$mq$ and p.name = $mq$Variation, Natural Selection and Evolution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Who proposed the theory of evolution by natural selection, alongside Alfred Russel Wallace?$mq$, $mq$["Charles Darwin","Gregor Mendel","Louis Pasteur","Isaac Newton"]$mq$, 0, $mq$Darwin and Wallace independently proposed that species change by natural selection. Darwin published On the Origin of Species in 1859.$mq$, $mq$easy$mq$),
($mq$What are features that help an organism survive in its environment called?$mq$, $mq$["Mutations","Fossils","Habitats","Adaptations"]$mq$, 3, $mq$An adaptation is a feature that increases the chance of survival and reproduction.$mq$, $mq$easy$mq$),
($mq$What are the preserved remains of organisms found in rock called?$mq$, $mq$["Alleles","Genes","Fossils","Clones"]$mq$, 2, $mq$Fossils show what organisms looked like in the past and give evidence for evolution.$mq$, $mq$easy$mq$),
($mq$Evolution is a change in the inherited characteristics of what over many generations?$mq$, $mq$["A food web","A population","An individual","A single cell"]$mq$, 1, $mq$Individuals do not evolve in their lifetime. Populations change as the frequency of alleles changes over generations.$mq$, $mq$easy$mq$),
($mq$What may happen to a species that cannot adapt to a change in its environment?$mq$, $mq$["Extinction","Speciation","Migration only","Mutation"]$mq$, 0, $mq$If no individuals survive and reproduce, the species dies out.$mq$, $mq$easy$mq$),
($mq$In natural selection, which individuals are more likely to survive and reproduce?$mq$, $mq$["The largest individuals","The oldest individuals","Those that have mutated","Those best adapted to the environment"]$mq$, 3, $mq$Individuals with the advantageous alleles survive better, reproduce more and pass these alleles on.$mq$, $mq$medium$mq$),
($mq$In polluted areas where tree trunks were blackened by soot, dark peppered moths became more common. Why?$mq$, $mq$["Dark moths ate more","Light moths ran out of food","They were better camouflaged from birds","Dark moths mutated because of pollution"]$mq$, 2, $mq$Dark moths were harder to see, so birds ate fewer of them. They survived to reproduce and pass on the dark allele.$mq$, $mq$medium$mq$),
($mq$Which is an example of a behavioural adaptation?$mq$, $mq$["Sharp claws","Bird migration","Thick fur","Webbed feet"]$mq$, 1, $mq$Behavioural adaptations are actions an organism takes, such as migration or hibernation. The others are structural.$mq$, $mq$medium$mq$),
($mq$A polar bear's thick white fur is what type of adaptation?$mq$, $mq$["Structural","Behavioural","Learned","Accidental"]$mq$, 0, $mq$A structural adaptation is a physical feature, here providing insulation and camouflage.$mq$, $mq$medium$mq$),
($mq$Forelimbs of a human, bat and whale have the same arrangement of bones, though they have different uses. What are such similar structures called?$mq$, $mq$["Vestigial organs","Fossil records","Selective breeds","Homologous structures"]$mq$, 3, $mq$Homologous structures suggest that these animals evolved from a common ancestor.$mq$, $mq$medium$mq$),
($mq$Why do resistant bacteria become more common when antibiotics are overused?$mq$, $mq$["Non-resistant bacteria become resistant overnight","Bacteria choose to change","Resistant bacteria survive and reproduce","Antibiotics make all bacteria resistant"]$mq$, 2, $mq$Antibiotics kill non-resistant bacteria. The few resistant bacteria survive, reproduce and pass on the resistance allele.$mq$, $mq$medium$mq$),
($mq$A survey finds 150 dark moths in a sample of 200 moths. What percentage are dark?$mq$, $mq$["150%","75%","25%","50%"]$mq$, 1, $mq$150 ÷ 200 × 100 = 75%.$mq$, $mq$medium$mq$),
($mq$In undisturbed layers of sedimentary rock, where are the oldest fossils found?$mq$, $mq$["In the deepest layers","In the top layers","In the middle layers","In the surface soil"]$mq$, 0, $mq$New layers are laid down on top of older ones, so the deepest layers contain the oldest fossils.$mq$, $mq$medium$mq$),
($mq$Which sequence correctly describes natural selection?$mq$, $mq$["Struggle to survive, alleles passed on, variation, best adapted reproduce","Best adapted reproduce, variation, alleles passed on, struggle to survive","Alleles passed on, variation, best adapted reproduce, struggle to survive","Variation, struggle to survive, best adapted reproduce, alleles passed on"]$mq$, 3, $mq$Individuals vary, more offspring are born than survive, the best adapted survive and breed, and their alleles become more common in the next generation.$mq$, $mq$hard$mq$),
($mq$A culture contains 1 000 000 bacteria. 0.01% of them are resistant to an antibiotic because of a mutation. How many resistant bacteria are there at the start?$mq$, $mq$["10000","1","100","10"]$mq$, 2, $mq$0.01% of 1 000 000 = 0.0001 × 1 000 000 = 100. After treatment, the survivors are all resistant and they multiply.$mq$, $mq$hard$mq$),
($mq$Which statement best explains how giraffes evolved long necks?$mq$, $mq$["Giraffes stretched their necks and their offspring inherited the stretch","Giraffes with alleles for longer necks survived better and passed them on","Giraffes needed longer necks, so they grew them","Mutations happened because giraffes needed them"]$mq$, 1, $mq$Stretching is an acquired characteristic and is not inherited. Mutations are random. Natural selection explains the change.$mq$, $mq$hard$mq$),
($mq$Humans and chimpanzees have more than 98% of their DNA in common. What does this suggest?$mq$, $mq$["They share a recent common ancestor","Humans evolved from chimpanzees","Chimpanzees evolved from humans","They are the same species"]$mq$, 0, $mq$Similar DNA suggests that two species share a recent common ancestor. Neither species evolved from the other.$mq$, $mq$hard$mq$),
($mq$Beetles live on brown soil. Birds spot green beetles more easily than brown ones. What is the most likely change after many generations?$mq$, $mq$["Green beetles become more common","Individual green beetles turn brown","The population stays exactly the same","Brown beetles become more common"]$mq$, 3, $mq$Brown beetles are eaten less, so more survive and breed, which increases the frequency of the allele for brown colour. Individuals do not change colour.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Natural Selection and the Evidence for Evolution$mq$ and p.name = $mq$Variation, Natural Selection and Evolution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Evolution$mq$, $mq$A change in the inherited characteristics of a population over many generations.$mq$),
($mq$Natural selection$mq$, $mq$Better-adapted individuals survive, reproduce and pass on their alleles, so those alleles become more common.$mq$),
($mq$Steps of natural selection$mq$, $mq$Variation, struggle to survive, survival of the best adapted, reproduction, and change in allele frequency.$mq$),
($mq$Adaptation$mq$, $mq$A feature that helps an organism survive and reproduce: structural, behavioural or physiological.$mq$),
($mq$Peppered moth example$mq$, $mq$Dark moths were better camouflaged on soot-darkened trees, survived bird predation and reproduced, so dark moths became more common.$mq$),
($mq$Antibiotic resistance$mq$, $mq$A mutation makes a bacterium resistant. Antibiotics kill the others, so resistant bacteria survive and multiply.$mq$),
($mq$Evidence from fossils$mq$, $mq$Fossils in rock layers show how organisms changed. Deeper layers hold older fossils.$mq$),
($mq$Homologous structures$mq$, $mq$Structures with the same bone pattern but different uses, such as the limbs of humans, bats and whales. They suggest a common ancestor.$mq$),
($mq$Why does extinction happen?$mq$, $mq$A species cannot adapt quickly enough to a change in its environment, so no individuals survive and reproduce.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Natural Selection and the Evidence for Evolution$mq$ and p.name = $mq$Variation, Natural Selection and Evolution$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Evolution is the change in the inherited characteristics of a population over many generations. Charles Darwin and Alfred Russel Wallace independently suggested that it happens by **natural selection**. Darwin published his ideas in On the Origin of Species in 1859.

## How natural selection works
1. **Variation**: individuals in a population differ, because of different alleles and mutations.
2. **Struggle to survive**: more offspring are born than can survive. They compete for food, mates and space, and they face predators and disease.
3. **Survival of the best adapted**: individuals with alleles that give an advantage are more likely to survive. This is sometimes called "survival of the fittest".
4. **Reproduction**: the survivors breed and pass their advantageous alleles to their offspring.
5. **Change over generations**: the frequency of the advantageous alleles increases in the population.

Individuals do not change during their lives to meet their needs, and mutations do not appear because an organism "needs" them. Mutations are random. The environment only selects which variants survive.

## Examples
- **Peppered moths**: before the Industrial Revolution most were pale, which camouflaged them on lichen-covered trees. As soot darkened tree trunks, pale moths were easier for birds to see, and dark moths became more common. After pollution laws reduced the soot, pale moths increased again.
- **Antibiotic resistance**: a random mutation may make a bacterium resistant. When antibiotics are used, resistant bacteria survive and reproduce, so resistant strains such as MRSA become common. To slow this, antibiotics should not be overused.

## Adaptations
An **adaptation** is a feature that helps an organism survive and reproduce. Structural adaptations are body features, such as the thick fur of a polar bear. Behavioural adaptations are actions, such as migration. Physiological adaptations are processes, such as venom production. If an environment changes faster than a species can adapt, the species may become **extinct**.

## Evidence for evolution
- **Fossils**: remains in rock show how species have changed. Older fossils are found in deeper rock layers. Gaps exist because few organisms become fossils.
- **Comparative anatomy**: the forelimbs of humans, bats and whales have the same bones in the same pattern, though they are used differently. These homologous structures suggest a common ancestor.
- **DNA**: related species have similar DNA. Humans and chimpanzees share more than 98% of their DNA, which suggests a recent common ancestor.
- **Observed change**: antibiotic resistance in bacteria and pesticide resistance in insects are evolution seen within our lifetimes.

## Worked example
A culture of 1 000 000 bacteria contains 0.01% resistant cells. Number resistant = 0.0001 × 1 000 000 = 100. An antibiotic kills the other 999 900, and the 100 resistant bacteria then multiply, so the new population is mostly resistant.

## Common mistakes
- Saying that organisms "try" or "need" to adapt.
- Saying that individuals evolve. Populations evolve.
- Saying that humans evolved from chimpanzees. They share a common ancestor.
- Using "theory" to mean "guess". A scientific theory is supported by a large body of evidence.

## How this is examined
Expect a scenario in which an environment changes, such as a new predator or a new pesticide, and a request to explain the change in the population step by step. Criterion D tasks may ask you to discuss the global impact of antibiotic resistance.

Exam tip: structure your explanation of natural selection in order: variation, selection pressure, survival and reproduction, alleles passed on, and a change in allele frequency.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('biology')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;