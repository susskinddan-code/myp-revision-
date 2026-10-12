-- Part 9 of 12: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Genetics, Evolution and Biotechnology > DNA, Inheritance and Variation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Genetics, Evolution and Biotechnology$mq$, 5, 9 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$DNA, Inheritance and Variation$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Genetics, Evolution and Biotechnology$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$DNA, Inheritance and Variation$mq$ and p.name = $mq$Genetics, Evolution and Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In a human liver cell, where is most of the DNA found?$mq$, $mq$["In the nucleus","In the cell membrane","In the cytoplasm only","In the ribosomes"]$mq$, 0, $mq$Most DNA is packed into chromosomes inside the nucleus. A very small amount is found in mitochondria.$mq$, $mq$easy$mq$),
($mq$In a DNA molecule, which base always pairs with adenine (A)?$mq$, $mq$["Cytosine (C)","Guanine (G)","Uracil (U)","Thymine (T)"]$mq$, 3, $mq$Complementary base pairing: A pairs with T and C pairs with G. Uracil is found in RNA, not DNA.$mq$, $mq$easy$mq$),
($mq$What is an allele?$mq$, $mq$["A section of a cell membrane","A type of body cell","A different version of the same gene","A single DNA base"]$mq$, 2, $mq$A gene can exist in several forms called alleles, for example the alleles for tall or short pea plants.$mq$, $mq$easy$mq$),
($mq$How many chromosomes are in a normal human sperm cell?$mq$, $mq$["46","23","92","12"]$mq$, 1, $mq$Gametes are haploid, so they contain half the usual number. Body cells have 46 chromosomes, sperm and egg cells have 23.$mq$, $mq$easy$mq$),
($mq$What does it mean if an allele is dominant?$mq$, $mq$["Its effect shows even when only one copy is present","It only shows when two copies are present","It is always the more common allele","It is found only on the X chromosome"]$mq$, 0, $mq$A dominant allele is expressed in the phenotype whether the genotype is homozygous or heterozygous.$mq$, $mq$easy$mq$),
($mq$In pea plants, tall (T) is dominant to short (t). Two heterozygous tall plants are crossed. What is the probability that an offspring is short?$mq$, $mq$["1/2","3/4","0","1/4"]$mq$, 3, $mq$Tt × Tt gives TT, Tt, Tt and tt in a 1:2:1 genotype ratio. Only tt is short, so the probability is 1/4.$mq$, $mq$medium$mq$),
($mq$A couple already has three sons. What is the probability that their fourth child is a girl?$mq$, $mq$["1/4","3/4","1/2","Less than 1/2 because they had boys"]$mq$, 2, $mq$Each fertilisation is an independent event. The sperm carries X or Y with equal chance, so the probability stays 1/2 whatever happened before.$mq$, $mq$medium$mq$),
($mq$One strand of a DNA section reads ATGCCA. What is the sequence of the complementary strand?$mq$, $mq$["UACGGU","TACGGT","TAGCCT","ATGCCA"]$mq$, 1, $mq$Pair each base: A–T, T–A, G–C, C–G, C–G, A–T giving TACGGT. Uracil does not appear in DNA.$mq$, $mq$medium$mq$),
($mq$Cystic fibrosis is caused by a recessive allele. Two unaffected parents are both carriers. What is the chance that their child has cystic fibrosis?$mq$, $mq$["25%","50%","75%","0%"]$mq$, 0, $mq$Carriers are Cc × Cc. One in four offspring is cc, which is 25%.$mq$, $mq$medium$mq$),
($mq$Identical twins are separated at birth. One grows 4 cm taller than the other. What is the best explanation?$mq$, $mq$["Different DNA sequences","A mutation in one twin's gametes","The twins have different numbers of chromosomes","Environmental differences such as diet"]$mq$, 3, $mq$Identical twins share the same DNA, so differences between them come from the environment, such as diet and health.$mq$, $mq$medium$mq$),
($mq$A student crosses two pea plants and counts 200 offspring: 152 purple flowers and 48 white flowers. Which statement best fits the data?$mq$, $mq$["It is a 1:1 ratio, so one parent was homozygous recessive","It is a 1:2:1 ratio, so the allele is codominant","It is close to a 3:1 ratio, suggesting both parents were heterozygous","All offspring should have been purple, so the data is wrong"]$mq$, 2, $mq$152 : 48 is about 3.2 : 1, close to 3:1, which is what Aa × Aa produces. Real results rarely match the ratio exactly because fertilisation is random.$mq$, $mq$medium$mq$),
($mq$Which of the following is most likely to cause a mutation?$mq$, $mq$["Eating a high-protein diet","Exposure to ultraviolet radiation","Exercising regularly","Drinking more water"]$mq$, 1, $mq$UV radiation, X-rays and some chemicals damage DNA and can change the base sequence. Diet and exercise do not alter DNA.$mq$, $mq$medium$mq$),
($mq$Which of these is an example of continuous variation in humans?$mq$, $mq$["Height","Blood group","Ability to roll the tongue","Having attached earlobes"]$mq$, 0, $mq$Continuous variation shows a full range of values, like height. Blood group and tongue rolling fall into distinct categories.$mq$, $mq$medium$mq$),
($mq$Two unaffected parents have a child with a genetic disorder. Which conclusion is best supported?$mq$, $mq$["The disorder is dominant and both parents have it","The disorder is caused by the environment only","The child must have had a new mutation, so the parents cannot be carriers","The disorder is recessive and both parents are carriers"]$mq$, 3, $mq$If a dominant allele were present in a parent they would be affected. So the allele is recessive and both parents carry one copy. A new mutation is possible but is not the best-supported conclusion.$mq$, $mq$hard$mq$),
($mq$A heterozygous tall plant (Tt) is crossed with a short plant (tt). If 40 seeds are grown, how many tall plants would you expect?$mq$, $mq$["10","30","20","40"]$mq$, 2, $mq$Tt × tt gives Tt and tt in a 1:1 ratio. Half of 40 is 20 tall plants.$mq$, $mq$hard$mq$),
($mq$Colour blindness is caused by a recessive allele on the X chromosome. A carrier mother and a father with normal vision have a son. What is the probability the son is colour blind?$mq$, $mq$["25%","50%","100%","0%"]$mq$, 1, $mq$The son receives his Y from the father and one of the mother's X chromosomes. Half of the mother's eggs carry the faulty allele, so 50%.$mq$, $mq$hard$mq$),
($mq$A woman has blood group AB (genotype IᴬIᴮ) and a man has group O (ii). Which groups are possible in their children?$mq$, $mq$["A or B only","A, B, AB or O","AB only","O only"]$mq$, 0, $mq$Children receive Iᴬ or Iᴮ from the mother and i from the father, giving IᴬI (group A) or IᴮI (group B).$mq$, $mq$hard$mq$),
($mq$A gene section is 12 bases long and each three bases code for one amino acid. One base is deleted near the start. What is the most likely effect?$mq$, $mq$["Only one amino acid is changed","No change, because DNA repairs itself every time","The protein is made faster","Most of the following amino acids are changed"]$mq$, 3, $mq$Deleting a base shifts the way the remaining bases are read in groups of three, so many later amino acids change. This is why deletions can be more harmful than some substitutions.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$DNA, Inheritance and Variation$mq$ and p.name = $mq$Genetics, Evolution and Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Complementary base pairing$mq$, $mq$In DNA, adenine pairs with thymine (A–T) and cytosine pairs with guanine (C–G).$mq$),
($mq$Gene$mq$, $mq$A section of DNA that codes for a protein, which gives a characteristic.$mq$),
($mq$Allele$mq$, $mq$A different version of the same gene, for example the allele for tall or short.$mq$),
($mq$Genotype vs phenotype$mq$, $mq$Genotype is the combination of alleles (Tt). Phenotype is the observable characteristic (tall).$mq$),
($mq$Homozygous vs heterozygous$mq$, $mq$Homozygous: two identical alleles (TT or tt). Heterozygous: two different alleles (Tt).$mq$),
($mq$Recessive allele$mq$, $mq$Only shows in the phenotype when two copies are present (homozygous recessive).$mq$),
($mq$Tt × Tt offspring ratio$mq$, $mq$Genotypes TT:Tt:tt = 1:2:1. Phenotypes 3 dominant : 1 recessive, a probability of 1/4 for the recessive phenotype.$mq$),
($mq$Mutation$mq$, $mq$A random change in the DNA base sequence. More likely after UV radiation, X-rays or some chemicals.$mq$),
($mq$Human sex chromosomes$mq$, $mq$Females XX, males XY. The chance of a boy or girl is 1/2 each time.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$DNA, Inheritance and Variation$mq$ and p.name = $mq$Genetics, Evolution and Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$DNA, or deoxyribonucleic acid, is the molecule that carries the instructions for building and running a living organism. In animal cells most DNA is found in the nucleus, wound into structures called chromosomes. Humans have 46 chromosomes in each body cell, arranged as 23 pairs. Gametes (egg and sperm) are made by meiosis and have only 23 chromosomes, so when they fuse at fertilisation the full 46 is restored.

## DNA structure
DNA is a double helix: two strands twisted together. Each strand is a chain of units called nucleotides. The strands are held together by pairs of bases. There are four bases, adenine (A), thymine (T), guanine (G) and cytosine (C). The pairing rule is **A with T** and **C with G**. This is called complementary base pairing. If one strand reads ATGC, the matching strand must read TACG.

## Genes, alleles and proteins
- A **gene** is a section of DNA that codes for a protein.
- Each three bases in a row (a triplet) codes for one amino acid. Amino acids join in order to make a protein.
- An **allele** is a version of a gene. You inherit one allele from each parent.
- The **genotype** is the combination of alleles, for example Tt. The **phenotype** is the characteristic that shows, for example tall.
- **Homozygous** means two identical alleles (TT or tt). **Heterozygous** means two different alleles (Tt).
- A **dominant** allele shows in the phenotype if at least one copy is present. A **recessive** allele only shows when two copies are present.

## Predicting inheritance
A Punnett square shows the possible combinations of gametes. For Tt × Tt, the offspring are TT, Tt, Tt, tt, so the genotype ratio is 1:2:1 and the phenotype ratio is 3 tall to 1 short. A 3:1 ratio does not mean exactly three of every four offspring. Fertilisation is random, so a small sample such as 8 offspring may give 5:3, while a large sample such as 200 will be much closer to 3:1. Each child is an independent event, so a family with three sons still has a 1/2 chance of a girl next time.

Sex is decided by the sex chromosomes. Females are XX and males are XY. The father's sperm carries X or Y, so the chance of either sex is 1/2. Some alleles, such as the one for red-green colour blindness, are carried on the X chromosome and are recessive. Males have only one X, so one faulty allele is enough to make a son colour blind. Females need two faulty alleles, so many are carriers without showing the condition.

## Variation
Differences between individuals of the same species are called variation. Variation can be caused by genes (inherited), by the environment (for example diet or sunlight) or by both. Height is affected by both. Identical twins have the same DNA, so differences between them come from the environment. Variation can be continuous (a range, like height) or discontinuous (clear categories, like blood group).

A **mutation** is a change in the DNA base sequence. Mutations happen at random but are more likely after exposure to ultraviolet radiation, X-rays or certain chemicals. Most have no effect, some are harmful and a few are beneficial. Mutations in gametes can be passed on to offspring.

## How this is examined
Questions give a short scenario, such as a pea plant cross with offspring counts or a family pedigree in words. You are asked to state the genotype, calculate a probability or ratio, and then evaluate whether the results support a prediction. Strong answers state the parental genotypes, show the Punnett square, give the ratio and then comment on sample size and random fertilisation.

## Common mistakes
- Saying a dominant allele is the most common allele. It is not.
- Writing genotype ratios when the question asks for phenotype ratios.
- Thinking previous children change the probability for the next.

Exam tip: Always write the parental genotypes, draw the Punnett square and give the answer as a probability or ratio with a short sentence. Remember that observed results will rarely match predictions exactly.$mq$ from st;

-- Genetics, Evolution and Biotechnology > Natural Selection and Evolution
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Genetics, Evolution and Biotechnology$mq$, 5, 9 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Natural Selection and Evolution$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Genetics, Evolution and Biotechnology$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Natural Selection and Evolution$mq$ and p.name = $mq$Genetics, Evolution and Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which statement best describes natural selection?$mq$, $mq$["Individuals with advantageous features survive and reproduce more, passing on their alleles","Organisms change their features during their lifetime to cope with the environment, and pass these on","The strongest individual always wins and survives","Mutations happen because the organism needs them"]$mq$, 0, $mq$Natural selection acts on existing variation. Better-adapted individuals are more likely to survive and reproduce, so their alleles become more common.$mq$, $mq$easy$mq$),
($mq$Who proposed the theory of evolution by natural selection, published in 1859 in On the Origin of Species?$mq$, $mq$["Gregor Mendel","Louis Pasteur","Isaac Newton","Charles Darwin"]$mq$, 3, $mq$Charles Darwin published On the Origin of Species in 1859. Alfred Russel Wallace independently reached a similar idea.$mq$, $mq$easy$mq$),
($mq$What is a fossil?$mq$, $mq$["A living organism that has not changed for millions of years","A rock formed from volcanic lava","The preserved remains or traces of an organism from long ago","A type of bone found only in dinosaurs"]$mq$, 2, $mq$Fossils are preserved remains or traces, such as bones, shells, footprints or imprints, usually found in sedimentary rock.$mq$, $mq$easy$mq$),
($mq$What does it mean when a species becomes extinct?$mq$, $mq$["The species moves to a new habitat","No individuals of the species remain alive","The species has too few predators","The population has decreased slightly"]$mq$, 1, $mq$Extinction means the whole species has died out. A population that is only smaller is not extinct.$mq$, $mq$easy$mq$),
($mq$Which of the following is needed for natural selection to occur?$mq$, $mq$["Variation within a population","All individuals being identical","No competition for resources","A change within one individual's lifetime"]$mq$, 0, $mq$Without variation there would be nothing for selection to act on. Competition and differences in survival drive the process.$mq$, $mq$easy$mq$),
($mq$A population of moths has light and dark forms. After a nearby wood is covered with soot, the dark form becomes much more common. What is the best explanation?$mq$, $mq$["Light moths changed to dark to match the soot","Soot caused mutations that made moths dark","Dark moths are naturally stronger","Dark moths were better camouflaged, so more survived and reproduced"]$mq$, 3, $mq$Predators ate more of the visible light moths. Dark moths survived and reproduced, passing on the allele for dark colour.$mq$, $mq$medium$mq$),
($mq$Bacteria are exposed to an antibiotic. A few resistant bacteria survive and reproduce. What is the best description of this process?$mq$, $mq$["Mutation caused by the antibiotic to help bacteria","Artificial selection","Natural selection","Acclimatisation"]$mq$, 2, $mq$Resistant bacteria arose by random mutation. The antibiotic acts as the selection pressure, so resistant bacteria survive and reproduce.$mq$, $mq$medium$mq$),
($mq$Which action best helps slow the spread of antibiotic-resistant bacteria?$mq$, $mq$["Taking antibiotics at the first sign of any illness","Finishing the full course of antibiotics and not using them for viral infections","Using weaker antibiotics for longer","Stopping the antibiotic as soon as you feel better"]$mq$, 1, $mq$Using antibiotics only when needed and completing the course reduces the chance that resistant bacteria survive and multiply.$mq$, $mq$medium$mq$),
($mq$Farmers breed only the cows that produce the most milk, generation after generation. What is this called?$mq$, $mq$["Selective breeding","Natural selection","Genetic modification","Cloning"]$mq$, 0, $mq$Selective breeding (artificial selection) is when humans choose which individuals breed. In natural selection the environment decides.$mq$, $mq$medium$mq$),
($mq$Which piece of evidence supports evolution from a common ancestor?$mq$, $mq$["The fact that fish live in water","The fact that all plants make glucose","The existence of different habitats","Similar bone structure in the forelimbs of bats, whales and humans"]$mq$, 3, $mq$Homologous structures such as the pentadactyl limb suggest shared ancestry despite different uses.$mq$, $mq$medium$mq$),
($mq$A population of 500 beetles contains green and brown forms. The brown form is easier for birds to see on green leaves. Over many generations, what is most likely to happen to the proportion of green beetles?$mq$, $mq$["It decreases","It stays exactly the same","It increases","It falls to zero within one generation"]$mq$, 2, $mq$Green beetles are better camouflaged, so more survive and reproduce, and the proportion increases gradually.$mq$, $mq$medium$mq$),
($mq$The fossil record shows a gradual change in the shape of a horse's leg bones over millions of years. What does this suggest?$mq$, $mq$["Horses are only recently evolved","Species change over long periods of time","All species have stayed the same","Fossils are not reliable at all"]$mq$, 1, $mq$A sequence of fossils in layers of different ages can show gradual change, supporting evolution.$mq$, $mq$medium$mq$),
($mq$Which statement correctly describes the origin of new alleles?$mq$, $mq$["They arise by random mutation","They are produced when an organism needs them","They are made by exercising","They are copied from other species deliberately"]$mq$, 0, $mq$New alleles arise from random mutations in DNA. Selection then determines whether they become more common.$mq$, $mq$medium$mq$),
($mq$A scientist records the following. Year 1: 10% of mosquitoes resistant to an insecticide. Year 4 after repeated spraying: 70% resistant. Which conclusion is best supported?$mq$, $mq$["The insecticide caused mosquitoes to adapt during their lives","Mosquitoes learned to avoid the insecticide","Resistance is not inherited","The insecticide has acted as a selection pressure"]$mq$, 3, $mq$Repeated spraying killed more susceptible mosquitoes, so resistant ones bred more. The data shows a rise in the proportion of resistant mosquitoes, consistent with selection.$mq$, $mq$hard$mq$),
($mq$A student says: 'The giraffe stretched its neck to reach leaves, and its offspring were born with longer necks.' What is wrong with this explanation?$mq$, $mq$["Giraffes cannot stretch their necks","Offspring never resemble their parents","Acquired features such as a stretched neck are not inherited","Leaves do not grow high enough"]$mq$, 2, $mq$This is the Lamarckian idea. Changes during an individual's life do not alter its DNA. Natural selection acts on inherited variation.$mq$, $mq$hard$mq$),
($mq$Why is a population with very low genetic variation more at risk of extinction when a new disease appears?$mq$, $mq$["All individuals will immediately develop resistance","Few individuals may have alleles that give resistance","Variation has no effect on disease","Disease only affects large populations"]$mq$, 1, $mq$With little variation, it is less likely that any individuals have a resistant allele, so the whole population may be affected.$mq$, $mq$hard$mq$),
($mq$Species A and species B are from the same genus. DNA analysis shows 98% similarity between A and B but only 91% between A and species C. What can be inferred?$mq$, $mq$["A and B probably share a more recent common ancestor","C is the ancestor of A","B is older than A","A and C are the same species"]$mq$, 0, $mq$The greater the DNA similarity, the more recently the species probably diverged. A and B are more closely related than A and C.$mq$, $mq$hard$mq$),
($mq$Which of these is the best definition of a species for MYP level?$mq$, $mq$["A group of organisms living in the same habitat","A group with similar colour","A group of organisms with the same diet","A group of organisms that can interbreed to produce fertile offspring"]$mq$, 3, $mq$The biological species concept uses fertile offspring as the test. A horse and a donkey make a mule, which is sterile, so they are separate species.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Natural Selection and Evolution$mq$ and p.name = $mq$Genetics, Evolution and Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Natural selection$mq$, $mq$Better-adapted individuals survive and reproduce more, passing on their alleles, so those alleles become more common over generations.$mq$),
($mq$Steps of natural selection$mq$, $mq$Variation, competition, survival of the better adapted, reproduction, inheritance of alleles, change in allele proportions.$mq$),
($mq$Source of new alleles$mq$, $mq$Random mutation in DNA.$mq$),
($mq$Selection pressure$mq$, $mq$An environmental factor, such as predation, disease or an antibiotic, that affects which individuals survive.$mq$),
($mq$Antibiotic resistance$mq$, $mq$Resistant bacteria survive treatment and reproduce, so resistance becomes common. Finish courses and avoid unnecessary antibiotics.$mq$),
($mq$Selective breeding$mq$, $mq$Humans choose which individuals breed to produce desired features, such as milk yield. Also called artificial selection.$mq$),
($mq$Extinction$mq$, $mq$The death of all individuals of a species. Causes include habitat loss, disease, new predators and climate change.$mq$),
($mq$Evidence for evolution$mq$, $mq$Fossil record, similar bone structures (homologous structures), DNA similarities, and observed changes such as pesticide resistance.$mq$),
($mq$Acquired features$mq$, $mq$Features gained during a lifetime, such as larger muscles. They are not inherited, because they do not change DNA in gametes.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Natural Selection and Evolution$mq$ and p.name = $mq$Genetics, Evolution and Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Evolution is the gradual change in the inherited features of populations over many generations. Today's species have developed from earlier, simpler species over billions of years. Charles Darwin proposed the main mechanism, natural selection, in his 1859 book On the Origin of Species. Alfred Russel Wallace independently came to a similar idea at about the same time.

## The steps of natural selection
Natural selection can be explained in a clear sequence. Use these steps in written answers.
- There is **variation** within a population, because of different alleles.
- New alleles arise by random **mutation**.
- More offspring are born than can survive, so there is **competition** for food, mates and space, and there are other pressures such as predators and disease.
- Individuals with features that suit the environment are more likely to **survive and reproduce**.
- They pass on the advantageous **alleles** to their offspring.
- Over many generations, the proportion of the advantageous allele in the population increases.

Notice that individuals do not change during their lives to meet a need, and that acquired features are not inherited. A giraffe that stretches its neck does not pass on a longer neck. Selection works on variation that already exists.

## Worked example: peppered moths
Before industrial pollution, most peppered moths in some English woods were pale, which camouflaged them on lichen-covered bark. When soot darkened the trees, pale moths were easier for birds to see and eat. Dark moths survived more often, bred, and the dark allele became common. When air quality improved, pale moths became more common again. The environment acted as the selection pressure.

## Antibiotic resistance
Bacteria reproduce quickly. A random mutation may give one bacterium resistance to an antibiotic. When the antibiotic is used, non-resistant bacteria die and resistant bacteria survive and multiply. The population becomes resistant. This is natural selection happening in real time. To slow it, doctors prescribe antibiotics only when needed, and patients should complete the full course.

## Evidence for evolution
- **Fossils** show how organisms have changed in layers of rock of different ages.
- **Comparative anatomy**, for example the similar arrangement of bones in the limbs of a human, a bat and a whale, suggests a common ancestor.
- **DNA comparison**: the more similar the DNA of two species, the more recently they probably shared a common ancestor.
- Observed changes, such as pesticide resistance in insects.

## Selective breeding and extinction
In **selective breeding**, humans choose which individuals breed, for example cows with high milk yield. This is artificial selection and is faster than natural selection. A species becomes **extinct** when no individuals remain. Causes include habitat loss, new predators or diseases, climate change and hunting. Low genetic variation makes a population more vulnerable.

## How this is examined
You may be given a data set such as the percentage of resistant bacteria over several years, then asked to describe the trend, explain it using natural selection, and evaluate how reliable the conclusion is. Better answers link each step: variation, selection pressure, survival, reproduction, inheritance.

Exam tip: When explaining natural selection, always include variation, a selection pressure, differential survival and reproduction, and the passing on of alleles. Never say that organisms change because they need to.$mq$ from st;

-- Genetics, Evolution and Biotechnology > Genetic Engineering and Cloning
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Genetics, Evolution and Biotechnology$mq$, 5, 9 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Genetic Engineering and Cloning$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Genetics, Evolution and Biotechnology$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Genetic Engineering and Cloning$mq$ and p.name = $mq$Genetics, Evolution and Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is genetic engineering?$mq$, $mq$["Changing an organism's DNA by adding, removing or altering genes","Breeding two organisms together","Growing plants in a greenhouse","Giving an organism vitamins"]$mq$, 0, $mq$Genetic engineering is the direct modification of an organism's genome, usually by moving a gene from one organism to another.$mq$, $mq$easy$mq$),
($mq$Which of these is a clone?$mq$, $mq$["A child with two different parents","A mutated organism","A hybrid of two species","A genetically identical copy of an organism"]$mq$, 3, $mq$A clone has the same DNA as the organism it was copied from.$mq$, $mq$easy$mq$),
($mq$Which cell type does a human insulin gene get inserted into so that bacteria can make insulin?$mq$, $mq$["Red blood cell","Human nerve cell","Bacterial cell","Plant root cell"]$mq$, 2, $mq$The human gene for insulin is inserted into bacteria, which then make human insulin in fermenters.$mq$, $mq$easy$mq$),
($mq$Which of the following is an example of a genetically modified crop trait?$mq$, $mq$["Being grown in rows","Resistance to a pest insect","Being watered daily","Being picked by hand"]$mq$, 1, $mq$Genetic modification can give crops traits such as pest resistance or enhanced vitamin content.$mq$, $mq$easy$mq$),
($mq$What is the name of the process used to produce Dolly the sheep in 1996?$mq$, $mq$["Cloning by nuclear transfer","Gene therapy","Selective breeding","Mutation"]$mq$, 0, $mq$Dolly was produced by transferring the nucleus of an adult cell into an egg cell that had its own nucleus removed.$mq$, $mq$easy$mq$),
($mq$In genetic engineering, which enzymes cut DNA at specific places?$mq$, $mq$["Digestive enzymes","Lipase","Amylase","Restriction enzymes"]$mq$, 3, $mq$Restriction enzymes cut DNA at particular sequences. Ligase enzymes then join DNA pieces together.$mq$, $mq$medium$mq$),
($mq$Put these steps of making human insulin in bacteria into the best order: 1 insert the plasmid into bacteria, 2 cut out the insulin gene, 3 join the gene into a plasmid, 4 grow the bacteria in a fermenter.$mq$, $mq$["1, 2, 3, 4","3, 2, 4, 1","2, 3, 1, 4","4, 1, 2, 3"]$mq$, 2, $mq$First isolate the gene (2), join it into a plasmid (3), put the plasmid in bacteria (1), and finally grow them to make the product (4).$mq$, $mq$medium$mq$),
($mq$Which statement about a cloned sheep made by nuclear transfer is correct?$mq$, $mq$["It has DNA from the egg donor only","It has almost the same DNA as the sheep that donated the nucleus","It has a mixture of DNA from two parents","It has no DNA"]$mq$, 1, $mq$The nucleus holds nearly all of the DNA, so the clone is genetically almost identical to the nucleus donor.$mq$, $mq$medium$mq$),
($mq$A company develops rice with extra beta-carotene to help reduce vitamin A deficiency. Which is the strongest argument in favour?$mq$, $mq$["It could improve nutrition in areas where diets lack vitamin A","It will make the rice taste of carrots","It will stop all pests","It makes farming unnecessary"]$mq$, 0, $mq$The potential benefit is better health through nutrition. Other statements make claims the technique does not support.$mq$, $mq$medium$mq$),
($mq$Which of these is a possible risk of growing GM crops?$mq$, $mq$["They always make less food","They cannot grow in soil","They cause climate change by themselves","Modified genes might spread to wild relatives"]$mq$, 3, $mq$Gene flow to wild plants is a concern, along with effects on other organisms and ownership of seeds. Risk assessments are used to study them.$mq$, $mq$medium$mq$),
($mq$Why are plant tissue culture clones useful for growers?$mq$, $mq$["They have more genetic variation","They need no light","All plants are identical with the desired features","They can be grown from any cell without a nutrient"]$mq$, 2, $mq$Cloned plants keep the desired features of the parent. The downside is low variation, so all are vulnerable to the same disease.$mq$, $mq$medium$mq$),
($mq$A farmer grows 4000 cloned banana plants of one variety. Which is the greatest risk?$mq$, $mq$["The plants will be too different","A single disease could affect all plants","The plants will not produce fruit","The plants will not be able to photosynthesise"]$mq$, 1, $mq$Clones are genetically identical, so if one is susceptible to a disease, all are.$mq$, $mq$medium$mq$),
($mq$A scientist suggests using gene therapy to treat cystic fibrosis by putting a working allele into lung cells. Why would the change not be passed to the patient's children?$mq$, $mq$["Only body cells would be changed, not the gametes","Lungs have no DNA","The new allele would be destroyed by oxygen","Children cannot inherit alleles"]$mq$, 0, $mq$Changes to body (somatic) cells do not affect sperm or egg cells, so they are not inherited.$mq$, $mq$medium$mq$),
($mq$A student evaluates a claim: 'GM crops are unsafe.' Which evidence would best test this claim?$mq$, $mq$["A single online post from an unnamed person","The opinion of the student's friend","The price of GM seeds","Controlled long-term studies comparing GM and non-GM food on health"]$mq$, 3, $mq$Reliable evidence is from controlled, replicated, peer-reviewed studies. Unsupported opinions do not test the claim.$mq$, $mq$hard$mq$),
($mq$Dolly the sheep was cloned from a 6-year-old sheep and was found to age faster than normal. Which conclusion is best supported?$mq$, $mq$["Cloning always makes animals healthier","The experiment proved that cloning never works","More research was needed on the long-term health of clones","Dolly had no DNA"]$mq$, 2, $mq$One animal does not prove a general rule, but it raised questions about the health of clones. Further research was needed.$mq$, $mq$hard$mq$),
($mq$Why is it ethically difficult to use embryos in research on stem cells?$mq$, $mq$["Embryos have no cells","Some people believe an embryo has the same moral status as a human life","Stem cells cannot divide","It is illegal in every country"]$mq$, 1, $mq$Ethical debates centre on the status of the embryo. Laws differ between countries, so it is not illegal everywhere.$mq$, $mq$hard$mq$),
($mq$A researcher inserts a gene into a plant and 3 of 60 treated plants show the new trait. What is the success rate and is it enough to conclude the method is reliable?$mq$, $mq$["5%; no, the method needs improvement and repeated trials","5%; yes, because some plants worked","50%; yes, because most worked","0.5%; the method failed completely"]$mq$, 0, $mq$3 ÷ 60 × 100 = 5%. This low rate suggests the method is not yet reliable, and repeats are needed.$mq$, $mq$hard$mq$),
($mq$Which is the best reason that insulin made by genetically modified bacteria is preferred to insulin extracted from pig pancreases?$mq$, $mq$["Bacteria contain more insulin than pigs","Pig insulin cannot work in humans at all","It does not require any equipment","It is identical to human insulin and can be produced in large quantities"]$mq$, 3, $mq$Bacterial insulin is human insulin, avoids animal sources and can be scaled up. Pig insulin does work, but it differs slightly from human insulin.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Genetic Engineering and Cloning$mq$ and p.name = $mq$Genetics, Evolution and Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Genetic engineering$mq$, $mq$Altering an organism's DNA by adding, removing or changing genes, often by moving a gene from one species to another.$mq$),
($mq$Restriction enzyme$mq$, $mq$An enzyme that cuts DNA at specific base sequences.$mq$),
($mq$Ligase$mq$, $mq$An enzyme that joins pieces of DNA together, for example a gene into a plasmid.$mq$),
($mq$Plasmid$mq$, $mq$A small ring of DNA in bacteria, used as a vector to carry a gene into a host cell.$mq$),
($mq$Steps to make human insulin in bacteria$mq$, $mq$Isolate the gene, cut a plasmid, join the gene in, insert plasmid into bacteria, grow in a fermenter, collect the insulin.$mq$),
($mq$Clone$mq$, $mq$An organism that is genetically identical to its parent.$mq$),
($mq$Nuclear transfer cloning$mq$, $mq$A nucleus from an adult cell is placed in an egg with its nucleus removed. The embryo is placed in a surrogate. Dolly the sheep (1996).$mq$),
($mq$Risk of cloning$mq$, $mq$Low genetic variation, so a single disease could affect the whole population.$mq$),
($mq$Gene therapy$mq$, $mq$Putting working alleles into body cells to treat a genetic disorder. Changes in body cells are not inherited by children.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Genetic Engineering and Cloning$mq$ and p.name = $mq$Genetics, Evolution and Biotechnology$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Genetic engineering is the deliberate changing of an organism's DNA by adding, removing or altering genes. The organism that results is called a **genetically modified (GM)** organism. Cloning is different: it produces genetically identical copies of an organism and does not change the DNA.

## Making a GM organism
A common method uses these steps.
- **Isolate** the gene you want, for example the gene for human insulin, using restriction enzymes that cut DNA at specific sequences.
- **Cut** a bacterial plasmid, which is a small ring of DNA, with the same enzyme.
- **Join** the gene into the plasmid using ligase enzyme. The result is a recombinant plasmid.
- **Insert** the plasmid into a host cell, such as a bacterium.
- **Grow** the bacteria in a fermenter so that they multiply and make the protein, which is then collected and purified.

## Examples and applications
- **Medicine**: human insulin and growth hormone made by bacteria. Gene therapy aims to put working alleles into the body cells of patients with genetic disorders. Because only body cells are changed, the change is not usually passed on to children.
- **Agriculture**: crops engineered to resist pests or herbicides, or to contain extra nutrients such as beta-carotene in rice to help reduce vitamin A deficiency.

## Cloning
- **Plants** are cloned by taking cuttings or by tissue culture in nutrient jelly. All the plants are identical copies of the parent, which is useful when the parent has desirable features.
- **Animals** can be cloned by nuclear transfer. The nucleus of an adult body cell is placed in an egg cell whose nucleus has been removed. The egg is stimulated to divide and the embryo is placed in a surrogate mother. Dolly the sheep, born in 1996, was the first mammal cloned from an adult cell.
- A major risk of cloning is **low genetic variation**. If a population is made of clones, one disease could affect all of them.

Stem cells are unspecialised cells that can divide and become different cell types. They are studied for treating diseases such as some types of paralysis and diabetes.

## Benefits, risks and ethics
Benefits include higher yields, healthier food, cheaper medicines and fewer pesticides. Concerns include possible effects on wild species if modified genes spread, long-term health effects (which scientists study with controlled trials), companies owning seeds and the cost to farmers. Ethical questions include whether it is acceptable to alter organisms, how embryos should be treated in stem cell research, and who should benefit. Decisions are made by governments, scientists and society together, so there is rarely a single correct answer. Good evaluations weigh evidence for and against and avoid sweeping statements such as all GM food is dangerous.

## How this is examined
Typically you will receive a short article or data about a GM crop or a cloned animal. You may need to identify the steps of a process, calculate a success rate (successful ÷ total × 100), and evaluate the reliability of the evidence and the ethical impact for different groups. Use the criteria: evidence, sample size, who gains, who might be harmed.

Exam tip: For discussion questions give at least one benefit and one risk, support each with a reason or evidence, and finish with a justified conclusion. Remember that cloning copies DNA, whereas genetic engineering changes it.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('integrated-science')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;