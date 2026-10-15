-- Part 5 of 6: 6 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Reproduction and Inheritance > Alleles, Genotype and Phenotype
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Reproduction and Inheritance$mq$, 4, 9 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Alleles, Genotype and Phenotype$mq$, 4, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Reproduction and Inheritance$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Alleles, Genotype and Phenotype$mq$ and p.name = $mq$Reproduction and Inheritance$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a section of DNA that codes for a protein or characteristic called?$mq$, $mq$["Gene","Chromosome","Nucleus","Cell"]$mq$, 0, $mq$A gene is a length of DNA that carries the instructions for making a protein, which affects a characteristic.$mq$, $mq$easy$mq$),
($mq$In which part of a cell are chromosomes found?$mq$, $mq$["Ribosome","Cell wall","Vacuole","Nucleus"]$mq$, 3, $mq$Chromosomes are made of DNA and are found in the nucleus of the cell.$mq$, $mq$easy$mq$),
($mq$How many chromosomes are in a normal human body cell?$mq$, $mq$["23","44","46","92"]$mq$, 2, $mq$Human body cells have 46 chromosomes, arranged in 23 pairs.$mq$, $mq$easy$mq$),
($mq$What are different versions of the same gene called?$mq$, $mq$["Genomes","Alleles","Clones","Gametes"]$mq$, 1, $mq$For example, the gene for pea plant height has an allele for tall and an allele for dwarf.$mq$, $mq$easy$mq$),
($mq$Which term describes the observable characteristics of an organism?$mq$, $mq$["Phenotype","Genome","Genotype","Allele"]$mq$, 0, $mq$The phenotype is what you can observe, such as height or flower colour.$mq$, $mq$easy$mq$),
($mq$What word describes an organism with two different alleles of a gene, such as Tt?$mq$, $mq$["Homozygous dominant","Homozygous recessive","Haploid","Heterozygous"]$mq$, 3, $mq$Hetero means different. A heterozygous organism has two different alleles for a gene.$mq$, $mq$medium$mq$),
($mq$In pea plants T is the dominant allele for tall and t is the recessive allele for dwarf. What is the phenotype of Tt?$mq$, $mq$["Dwarf","Medium height","Tall","Both tall and dwarf"]$mq$, 2, $mq$The dominant allele T is expressed when it is present, so Tt is tall.$mq$, $mq$medium$mq$),
($mq$How many copies of a recessive allele are needed for the recessive characteristic to show?$mq$, $mq$["Three","Two","One","None"]$mq$, 1, $mq$A recessive allele is only expressed when there is no dominant allele, so both alleles must be recessive.$mq$, $mq$medium$mq$),
($mq$What word describes the genotype TT?$mq$, $mq$["Homozygous dominant","Haploid","Homozygous recessive","Heterozygous"]$mq$, 0, $mq$Homo means same. TT has two identical dominant alleles.$mq$, $mq$medium$mq$),
($mq$A person has one normal allele and one cystic fibrosis allele, which is recessive, but has no symptoms. What is this person called?$mq$, $mq$["Clone","Donor","Mutant","Carrier"]$mq$, 3, $mq$A carrier has the recessive allele but also has a dominant allele, so does not show the disorder but can pass it on.$mq$, $mq$medium$mq$),
($mq$In DNA, which base pairs with adenine?$mq$, $mq$["Uracil","Guanine","Thymine","Cytosine"]$mq$, 2, $mq$A pairs with T, and C pairs with G. Uracil replaces thymine in RNA.$mq$, $mq$medium$mq$),
($mq$How many chromosomes are in a normal human gamete?$mq$, $mq$["22","23","46","92"]$mq$, 1, $mq$Gametes are haploid. They have one chromosome from each of the 23 pairs.$mq$, $mq$medium$mq$),
($mq$What is the shape of a DNA molecule?$mq$, $mq$["Double helix","Single strand","Sphere","Cube"]$mq$, 0, $mq$DNA is two strands twisted around each other in a double helix, joined by pairs of bases.$mq$, $mq$medium$mq$),
($mq$Huntington's disease is caused by a dominant allele H. Which genotypes result in a person having the disease?$mq$, $mq$["Heterozygous or homozygous recessive (Hh or hh)","Only HH (two dominant alleles)","Only hh (two recessive alleles)","Homozygous dominant or heterozygous (HH or Hh)"]$mq$, 3, $mq$One copy of a dominant allele is enough to show the characteristic, so HH and Hh both have the disease.$mq$, $mq$hard$mq$),
($mq$Two parents do not have cystic fibrosis, but their child does. The allele for cystic fibrosis is recessive (f). What are the parents' genotypes?$mq$, $mq$["Both FF (homozygous dominant)","One FF and one Ff","Both Ff","Both ff (affected)"]$mq$, 2, $mq$The child must be ff, so each parent passed on an f allele. The parents are unaffected, so they must each carry a dominant F allele as well.$mq$, $mq$hard$mq$),
($mq$Two identical twins have the same genotype, but one is taller than the other. What is the best explanation?$mq$, $mq$["They have different genes","The environment affects phenotype","Their alleles are different","One has more chromosomes"]$mq$, 1, $mq$Phenotype is determined by genotype and the environment, for example diet or illness during growth.$mq$, $mq$hard$mq$),
($mq$A tall pea plant has a phenotype that does not show its genotype. Why?$mq$, $mq$["It could be TT or Tt","It must be TT (two dominant alleles)","It must be Tt (heterozygous)","It must be tt (two recessive alleles)"]$mq$, 0, $mq$Both TT and Tt give a tall phenotype, so extra evidence from a cross is needed to find the genotype.$mq$, $mq$hard$mq$),
($mq$In a double-stranded DNA molecule, 30% of the bases are adenine. What percentage of the bases are cytosine?$mq$, $mq$["40%","30%","70%","20%"]$mq$, 3, $mq$A pairs with T, so T is also 30%. A + T = 60%, leaving 40% for C + G. C pairs with G, so cytosine is 20%.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Alleles, Genotype and Phenotype$mq$ and p.name = $mq$Reproduction and Inheritance$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Gene$mq$, $mq$A section of DNA that codes for a protein, which helps determine a characteristic.$mq$),
($mq$Allele$mq$, $mq$A version of a gene. For example, the alleles for tall and dwarf in pea plants.$mq$),
($mq$Chromosome$mq$, $mq$A coiled structure of DNA in the nucleus. Human body cells have 46 (23 pairs).$mq$),
($mq$Dominant allele$mq$, $mq$An allele that shows its effect even when only one copy is present. Written with a capital letter.$mq$),
($mq$Recessive allele$mq$, $mq$An allele that only shows its effect when two copies are present. Written with a lower-case letter.$mq$),
($mq$Genotype vs phenotype$mq$, $mq$Genotype is the combination of alleles (for example Tt). Phenotype is the observable characteristic (for example tall).$mq$),
($mq$Homozygous vs heterozygous$mq$, $mq$Homozygous: two identical alleles (TT or tt). Heterozygous: two different alleles (Tt).$mq$),
($mq$Carrier$mq$, $mq$A heterozygous person who has a recessive allele for a disorder but does not show the disorder.$mq$),
($mq$Base pairing in DNA$mq$, $mq$Adenine pairs with thymine (A-T). Cytosine pairs with guanine (C-G).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Alleles, Genotype and Phenotype$mq$ and p.name = $mq$Reproduction and Inheritance$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Inheritance is the passing of characteristics from parents to offspring. To understand how it works you need to know the meaning of several linked terms.

## DNA, genes and chromosomes
**DNA** is the molecule that carries genetic information. It has the shape of a double helix, two strands twisted around each other. The strands are joined by pairs of bases: adenine (A) always pairs with thymine (T), and cytosine (C) always pairs with guanine (G). A **gene** is a short section of DNA that codes for a particular protein, which helps to determine a characteristic. DNA is tightly coiled into structures called **chromosomes**, found in the nucleus. Human body cells have 46 chromosomes in 23 pairs. We get one chromosome of each pair from each parent. Gametes have 23 chromosomes, one from each pair.

## Alleles
Genes come in different versions called **alleles**. For example, the gene for height in pea plants has an allele for tall and an allele for dwarf. Because chromosomes come in pairs, a body cell has two alleles for each gene, one on each chromosome of the pair.
- A **dominant allele** shows its effect even when there is only one copy. It is written with a capital letter, such as T.
- A **recessive allele** only shows its effect when there are two copies. It is written with a lower-case letter, such as t.

## Genotype and phenotype
The **genotype** is the combination of alleles an organism has, for example Tt. The **phenotype** is the characteristic that can be observed, for example tall. Phenotype is affected by genotype and also by the environment. For example, identical twins have the same genotype but can differ in height if one has a better diet.

## Homozygous and heterozygous
- **Homozygous**: two identical alleles (TT is homozygous dominant, tt is homozygous recessive).
- **Heterozygous**: two different alleles (Tt).

A heterozygous person who has a recessive allele for a disorder but does not show it is a **carrier**. For example, a person with the alleles Ff, where f is the cystic fibrosis allele, has no symptoms but can pass on the f allele.

## Worked examples
1. A pea plant with the genotype Tt has a tall phenotype. A tall plant could be TT or Tt, so its phenotype does not tell us its genotype.
2. Two unaffected parents have a child with cystic fibrosis (ff). The child must have received an f from each parent, and as the parents are unaffected, both must be Ff.
3. In a DNA molecule, 30% of bases are adenine. Thymine is 30% too (A pairs with T), so A + T = 60%. The remaining 40% is C + G, and C = G = 20%.

## Common mistakes
- Using "gene" and "allele" as if they mean the same. A gene is a section of DNA; an allele is a version of that gene.
- Thinking dominant means more common. Dominant means expressed when present; some dominant disorders are rare.
- Writing genotype in a question about phenotype.
- Saying that gametes have 46 chromosomes. They have 23.

## How this is examined
You may be asked to define the key terms, to read a genetic diagram, or to work out an unknown genotype from information about offspring. In Criterion A you should use the correct terms (genotype, phenotype, allele, dominant, recessive, homozygous, heterozygous) rather than general descriptions.

Exam tip: when you write alleles, choose a letter where the capital and lower-case forms look different, such as T and t, and state clearly what each allele stands for.$mq$ from st;

-- Reproduction and Inheritance > Monohybrid Crosses and Punnett Squares
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Reproduction and Inheritance$mq$, 4, 9 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Monohybrid Crosses and Punnett Squares$mq$, 4, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Reproduction and Inheritance$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Monohybrid Crosses and Punnett Squares$mq$ and p.name = $mq$Reproduction and Inheritance$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the probability that a baby is male?$mq$, $mq$["50%","25%","75%","100%"]$mq$, 0, $mq$Half of sperm carry X and half carry Y, so the chance of a boy is about 50%.$mq$, $mq$easy$mq$),
($mq$Which sex chromosomes does a human male have?$mq$, $mq$["XO","XX","YY","XY"]$mq$, 3, $mq$Males have one X and one Y chromosome. Females have two X chromosomes.$mq$, $mq$easy$mq$),
($mq$What does a Punnett square show?$mq$, $mq$["The stages of a food chain","The order of bases in DNA","Possible allele combinations in offspring","The number of chromosomes in a cell"]$mq$, 2, $mq$A Punnett square shows all the ways that the parent gametes can combine, and so the possible genotypes of offspring.$mq$, $mq$easy$mq$),
($mq$In pea plants, TT is crossed with tt. What is the genotype of all the offspring?$mq$, $mq$["tt (all homozygous recessive)","Tt","TT (all homozygous dominant)","Half TT and half tt"]$mq$, 1, $mq$Every offspring receives T from one parent and t from the other.$mq$, $mq$easy$mq$),
($mq$Which gametes can a parent with the genotype Tt produce?$mq$, $mq$["T and t","Only the dominant allele T","Only the recessive allele t","Tt together in each gamete"]$mq$, 0, $mq$Gametes receive one allele from each pair, so half carry T and half carry t.$mq$, $mq$easy$mq$),
($mq$Two heterozygous pea plants (Tt × Tt) are crossed. What is the probability of a dwarf (tt) offspring?$mq$, $mq$["50%","75%","100%","25%"]$mq$, 3, $mq$The offspring are TT, Tt, Tt and tt, so one out of four, or 25%, is tt.$mq$, $mq$medium$mq$),
($mq$Two heterozygous pea plants (Tt × Tt) are crossed. What is the expected ratio of tall to dwarf offspring?$mq$, $mq$["1 tall : 3 dwarf","1 tall : 1 dwarf","3 tall : 1 dwarf","All tall"]$mq$, 2, $mq$TT, Tt and Tt are tall and tt is dwarf, giving 3 : 1.$mq$, $mq$medium$mq$),
($mq$A cross Tt × tt is carried out. What is the expected ratio of tall to dwarf offspring?$mq$, $mq$["1 tall : 3 dwarf","1 tall : 1 dwarf","3 tall : 1 dwarf","All tall"]$mq$, 1, $mq$Offspring are Tt, Tt, tt and tt, which is half tall and half dwarf.$mq$, $mq$medium$mq$),
($mq$Two carriers of cystic fibrosis (Ff × Ff) have a child. What is the probability that the child is a carrier?$mq$, $mq$["50%","25%","75%","100%"]$mq$, 0, $mq$The offspring are FF, Ff, Ff and ff, so two out of four, or 50%, are carriers (Ff).$mq$, $mq$medium$mq$),
($mq$A couple who are both carriers (Ff) have a first child with cystic fibrosis. What is the probability that their second child also has it?$mq$, $mq$["12.5%","50%","0%","25%"]$mq$, 3, $mq$Each fertilisation is an independent event, so the chance is 25% every time, regardless of earlier children.$mq$, $mq$medium$mq$),
($mq$A cross between two Tt plants produces 1600 seeds. How many dwarf plants are expected?$mq$, $mq$["800","1200","400","100"]$mq$, 2, $mq$One quarter are dwarf: 1600 × 0.25 = 400.$mq$, $mq$medium$mq$),
($mq$Which gamete determines the sex of a human baby?$mq$, $mq$["Placenta","Sperm","Egg","Ovary"]$mq$, 1, $mq$All eggs carry an X chromosome, but sperm carry either X or Y, so the sperm determines the sex.$mq$, $mq$medium$mq$),
($mq$A tall pea plant of unknown genotype is crossed with a dwarf plant (tt). Half of the offspring are dwarf. What is the genotype of the tall parent?$mq$, $mq$["Tt","TT (homozygous dominant)","tt (homozygous recessive)","It cannot be known"]$mq$, 0, $mq$Dwarf offspring (tt) must have received a t from the tall parent, so it is Tt. If it were TT, all offspring would be tall.$mq$, $mq$medium$mq$),
($mq$Two unaffected parents have a daughter with a genetic disorder. What type of allele causes the disorder?$mq$, $mq$["Dominant","An allele that only males carry","An allele caused by the environment","Recessive"]$mq$, 3, $mq$If the allele were dominant, one of the parents would have to have the disorder. The parents are unaffected carriers.$mq$, $mq$hard$mq$),
($mq$Two carriers of cystic fibrosis (Ff × Ff) have a child. What is the probability that the child does not have the disorder?$mq$, $mq$["100%","25%","75%","50%"]$mq$, 2, $mq$Only ff is affected. FF, Ff and Ff are unaffected, which is three out of four, or 75%.$mq$, $mq$hard$mq$),
($mq$Both parents are Ff. What is the probability that two children are both ff?$mq$, $mq$["12.5%","6.25%","25%","50%"]$mq$, 1, $mq$Each child has a probability of 0.25. The probability of both is 0.25 × 0.25 = 0.0625, or 6.25%.$mq$, $mq$hard$mq$),
($mq$A father has Huntington's disease (Hh, where H is dominant). The mother does not have it (hh). What is the probability that a child has the disease?$mq$, $mq$["50%","25%","75%","100%"]$mq$, 0, $mq$The cross Hh × hh gives Hh, Hh, hh and hh, so half of the children inherit the dominant allele.$mq$, $mq$hard$mq$),
($mq$A cross between two pea plants gives 62 tall and 18 dwarf offspring. Which parental genotypes best explain this result?$mq$, $mq$["Homozygous dominant and homozygous recessive (TT × tt)","Heterozygous and homozygous recessive (Tt × tt)","Homozygous dominant and heterozygous (TT × Tt)","Both heterozygous (Tt × Tt)"]$mq$, 3, $mq$The ratio of 62 : 18 is close to 3 : 1, which is expected from Tt × Tt. A Tt × tt cross would give about 1 : 1.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Monohybrid Crosses and Punnett Squares$mq$ and p.name = $mq$Reproduction and Inheritance$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Monohybrid cross$mq$, $mq$A cross that follows the inheritance of one gene with two alleles.$mq$),
($mq$Tt × Tt results$mq$, $mq$Genotypes 1 TT : 2 Tt : 1 tt. Phenotypes 3 dominant : 1 recessive. 25% chance of tt.$mq$),
($mq$Tt × tt results$mq$, $mq$Genotypes 1 Tt : 1 tt. Phenotypes 1 dominant : 1 recessive.$mq$),
($mq$Steps to make a Punnett square$mq$, $mq$Choose letters, write parent genotypes, write gametes, draw the grid, fill in the boxes, then give ratios or probabilities.$mq$),
($mq$Human sex chromosomes$mq$, $mq$Females are XX, males are XY. Sperm decide the sex, so there is a 50% chance of a boy or a girl.$mq$),
($mq$Test cross$mq$, $mq$Cross an organism of unknown dominant phenotype with a homozygous recessive one. Any recessive offspring show the parent was heterozygous.$mq$),
($mq$Carrier × carrier (Ff × Ff)$mq$, $mq$25% affected (ff), 50% carriers (Ff), 25% homozygous normal (FF). 75% are unaffected.$mq$),
($mq$Are children's probabilities independent?$mq$, $mq$Yes. Each fertilisation is a separate event, so the chance is the same for every child.$mq$),
($mq$Cystic fibrosis vs Huntington's$mq$, $mq$Cystic fibrosis is caused by a recessive allele (needs ff). Huntington's disease is caused by a dominant allele (HH or Hh).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Monohybrid Crosses and Punnett Squares$mq$ and p.name = $mq$Reproduction and Inheritance$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$A monohybrid cross follows the inheritance of a single gene with two alleles. A Punnett square is a diagram used to predict the genotypes and phenotypes of offspring.

## Steps to complete a Punnett square
1. Choose letters for the alleles. Use the capital letter for the dominant allele, for example T for tall and t for dwarf.
2. Write the genotypes of the parents, for example Tt × Tt.
3. Write the possible gametes of each parent. A gamete only carries one allele of each gene. Tt produces gametes T and t.
4. Draw a grid. Put one parent's gametes along the top and the other parent's down the side.
5. Fill in each box by combining the alleles from the row and the column.
6. Count the genotypes and phenotypes. Give the ratio or probability, and state that this is only what is expected.

## Worked example 1: Tt × Tt
The four boxes are TT, Tt, Tt and tt. The genotype ratio is 1 TT : 2 Tt : 1 tt. Three of the four are tall, so the phenotype ratio is 3 tall : 1 dwarf. The probability of a dwarf plant is 1 in 4, or 25%. If 1600 seeds are planted, we expect 400 dwarf plants (1600 × 0.25).

## Worked example 2: Tt × tt
The boxes are Tt, Tt, tt and tt. Half the offspring are tall and half are dwarf, a ratio of 1 : 1. This cross can be used as a **test cross**: if a tall plant of unknown genotype is crossed with a dwarf (tt) plant, any dwarf offspring show that the tall parent is Tt, and if all offspring are tall the parent is probably TT.

## Sex determination
Human females have two X chromosomes (XX) and males have X and Y (XY). All eggs carry an X. Sperm carry X or Y. A Punnett square for XX × XY gives XX, XX, XY and XY, so the chance of a boy or a girl is 50%.

## Inherited disorders
Cystic fibrosis is caused by a recessive allele (f). Two carriers (Ff × Ff) have a 25% chance of an affected child (ff), a 50% chance of a carrier (Ff) and a 25% chance of a child with two normal alleles (FF). So 75% are unaffected. Huntington's disease is caused by a dominant allele (H). A person with Hh has the disease.

## Probability reminders
Each fertilisation is independent. If the first child has cystic fibrosis, the chance for the second child is still 25%. The ratios are expected, not guaranteed, because fertilisation is random. In a small sample, you might get different numbers. The larger the sample, the closer the results are to the expected ratio. For two independent events, multiply: the probability of two affected children is 0.25 × 0.25 = 0.0625, or 6.25%.

## Common mistakes
- Writing a gamete with two alleles of the same gene, such as Tt. A gamete has one allele.
- Giving the genotype ratio when asked for the phenotype ratio.
- Saying that after one affected child "the next three will be healthy". Each child has the same probability.
- Forgetting a key that explains the letters used.

## How this is examined
Expect a pedigree chart or a short scenario, such as an inherited disorder in a family, and a Punnett square to complete. Criterion D tasks may ask you to discuss the ethical issues of genetic testing for inherited disorders.

Exam tip: always show the gametes, draw the square, and state both the genotype and the phenotype results as a ratio or probability.$mq$ from st;

-- Ecosystems and Human Impact > Trophic Levels and Energy in Food Webs
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Ecosystems and Human Impact$mq$, 4, 10 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Trophic Levels and Energy in Food Webs$mq$, 4, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Ecosystems and Human Impact$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Trophic Levels and Energy in Food Webs$mq$ and p.name = $mq$Ecosystems and Human Impact$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does an arrow in a food chain show?$mq$, $mq$["Energy flow","The direction the animal moves","Which animal is bigger","The number of organisms"]$mq$, 0, $mq$The arrow points from the organism that is eaten to the organism that eats it, showing the direction of energy transfer.$mq$, $mq$easy$mq$),
($mq$What are organisms that make their own food by photosynthesis called?$mq$, $mq$["Consumers","Decomposers","Predators","Producers"]$mq$, 3, $mq$Producers, such as plants and algae, make food using light energy.$mq$, $mq$easy$mq$),
($mq$What is an animal that eats only plants called?$mq$, $mq$["Decomposer","Carnivore","Herbivore","Omnivore"]$mq$, 2, $mq$Herbivores are primary consumers because they eat producers.$mq$, $mq$easy$mq$),
($mq$In the food chain grass, rabbit, fox, what trophic level is the rabbit?$mq$, $mq$["Producer","Primary consumer","Secondary consumer","Decomposer"]$mq$, 1, $mq$The rabbit eats the producer, so it is the primary consumer.$mq$, $mq$easy$mq$),
($mq$Which organisms break down dead plants and animals?$mq$, $mq$["Decomposers","Herbivores","Producers","Predators"]$mq$, 0, $mq$Decomposers such as bacteria and fungi break down dead material and return nutrients to the soil.$mq$, $mq$easy$mq$),
($mq$Approximately what percentage of the energy is passed on from one trophic level to the next?$mq$, $mq$["90%","50%","1%","10%"]$mq$, 3, $mq$Only about 10% of the energy is transferred, because most is lost as heat, in waste and in parts that are not eaten.$mq$, $mq$medium$mq$),
($mq$What is the original source of energy for most food chains?$mq$, $mq$["Soil","Water","The Sun","Decomposers"]$mq$, 2, $mq$Producers capture light energy from the Sun in photosynthesis. All other organisms depend on this energy.$mq$, $mq$medium$mq$),
($mq$In the food chain algae, water fleas, small fish, heron, which organism is the tertiary consumer?$mq$, $mq$["Water fleas","Heron","Small fish","Algae"]$mq$, 1, $mq$Algae are producers, water fleas are primary consumers, small fish are secondary consumers and the heron is the tertiary consumer.$mq$, $mq$medium$mq$),
($mq$All the snakes in a food web are removed. The snakes ate mice. What is the most likely short-term effect on the mice?$mq$, $mq$["They increase in number","They stay the same","They decrease in number","They become extinct"]$mq$, 0, $mq$With the predator gone, fewer mice are eaten, so their population is likely to grow.$mq$, $mq$medium$mq$),
($mq$What is one way that energy is lost between trophic levels?$mq$, $mq$["Used in photosynthesis","Converted to more food","Absorbed by the soil","Lost as heat from respiration"]$mq$, 3, $mq$Organisms release energy by respiration, and much is lost as heat. Energy is also lost in faeces and in uneaten parts such as bones.$mq$, $mq$medium$mq$),
($mq$Producers contain 20 000 kJ of energy. If 10% passes to each trophic level, how much energy do the secondary consumers contain in kJ?$mq$, $mq$["20","2000","200","2"]$mq$, 2, $mq$Primary consumers: 20 000 × 0.1 = 2000 kJ. Secondary consumers: 2000 × 0.1 = 200 kJ.$mq$, $mq$medium$mq$),
($mq$Why are food chains rarely longer than four or five links?$mq$, $mq$["Predators are too large","Too little energy is left","Producers run out of space","Decomposers eat top consumers"]$mq$, 1, $mq$Energy is lost at every transfer, so very little remains for any higher trophic level.$mq$, $mq$medium$mq$),
($mq$What does a pyramid of biomass show?$mq$, $mq$["Mass of living material at each trophic level","Number of organisms at each level","Energy lost as heat","Number of species"]$mq$, 0, $mq$A biomass pyramid shows the dry mass of living material at each trophic level. It narrows towards the top.$mq$, $mq$medium$mq$),
($mq$Primary consumers receive 8000 kJ of energy and secondary consumers receive 640 kJ. What is the percentage energy transfer between these two levels?$mq$, $mq$["80%","12.5%","0.8%","8%"]$mq$, 3, $mq$Transfer = 640 ÷ 8000 × 100 = 8%.$mq$, $mq$hard$mq$),
($mq$A pyramid of numbers for one large oak tree and 5000 caterpillars is inverted. What is the explanation?$mq$, $mq$["The oak is a consumer","Caterpillars are the producers","One large tree supports many small insects","Energy flows from the caterpillars to the oak"]$mq$, 2, $mq$The producer is a single huge organism, so the number of individuals is small even though its biomass is large.$mq$, $mq$hard$mq$),
($mq$A disease kills most of the mice in an area. Mice eat grass and are eaten by snakes. What is the short-term effect on the grass and on the snakes?$mq$, $mq$["Both decrease","Grass increases and snakes decrease","Grass decreases and snakes increase","Both increase"]$mq$, 1, $mq$Fewer mice eat the grass, so it increases. Fewer mice are available as prey for snakes, so the snakes decrease unless they have other food.$mq$, $mq$hard$mq$),
($mq$A farm has 5000 kg of producer biomass. The secondary consumers have 50 kg of biomass. What percentage of the producer biomass is the secondary consumers' biomass?$mq$, $mq$["1%","10%","0.1%","100%"]$mq$, 0, $mq$50 ÷ 5000 × 100 = 1%. This is the result of two transfers each of roughly 10%.$mq$, $mq$hard$mq$),
($mq$Why is it more energy-efficient for people to eat plants than to eat meat?$mq$, $mq$["Plants have more protein than meat","Animals are poisonous","Humans cannot digest meat","Less energy is lost between producer and human"]$mq$, 3, $mq$Eating plants removes a trophic level. At each trophic level around 90% of energy is lost, so more of the energy from the Sun reaches people.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Trophic Levels and Energy in Food Webs$mq$ and p.name = $mq$Ecosystems and Human Impact$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Trophic level$mq$, $mq$A feeding level in a food chain: producer, primary consumer, secondary consumer, tertiary consumer.$mq$),
($mq$Meaning of arrows in a food chain$mq$, $mq$They show the direction of energy flow, from the organism that is eaten to the one that eats it.$mq$),
($mq$Producer$mq$, $mq$An organism that makes its own food by photosynthesis, using energy from the Sun.$mq$),
($mq$Decomposer$mq$, $mq$An organism, such as a bacterium or fungus, that breaks down dead material and returns nutrients to the soil.$mq$),
($mq$Energy transfer between levels$mq$, $mq$About 10% passes to the next level. The rest is lost as heat, in waste and in uneaten parts.$mq$),
($mq$Why are food chains short?$mq$, $mq$So much energy is lost at each stage that too little remains to support more levels.$mq$),
($mq$Food web$mq$, $mq$A network of interconnected food chains in an ecosystem.$mq$),
($mq$Percentage energy transfer$mq$, $mq$Energy gained by the next level ÷ energy available at the previous level × 100.$mq$),
($mq$Pyramid of biomass$mq$, $mq$Shows the mass of living material at each trophic level. It narrows towards the top.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Trophic Levels and Energy in Food Webs$mq$ and p.name = $mq$Ecosystems and Human Impact$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$An ecosystem is a community of living organisms interacting with each other and with their non-living environment. The feeding relationships between the organisms show how energy and matter move through the ecosystem.

## Food chains and trophic levels
A **food chain** shows what eats what. Each stage is called a **trophic level**. Arrows point from the organism being eaten to the organism that eats it, because they show the direction of energy flow.
- **Producers** make food by photosynthesis, using energy from the Sun. They are the first trophic level.
- **Primary consumers** are herbivores that eat producers.
- **Secondary consumers** are carnivores that eat primary consumers.
- **Tertiary consumers** eat secondary consumers. The consumer at the top of a chain is an apex predator.
- **Decomposers** such as bacteria and fungi break down dead material and waste at every level, returning nutrients to the soil.

A **food web** is a set of linked food chains. Most organisms eat more than one thing, so webs are more realistic. If one species changes in number, the effects spread through the web. For example, if a predator is removed, its prey may increase and then overgraze the producers.

## Energy transfer
Only about **10%** of the energy in one trophic level is passed on to the next. The rest is lost.
- Much is released as heat by respiration, which also provides energy for movement.
- Some is lost in waste such as faeces and urine.
- Some of the organism is not eaten, such as bones, roots or shells.

This is why food chains are short, usually with four or five trophic levels. It is also why there are fewer top predators than herbivores.

## Pyramids
A **pyramid of numbers** shows how many organisms there are at each level. A **pyramid of biomass** shows the mass of living material at each level and is usually pyramid-shaped. A pyramid of numbers can be inverted. For example, one oak tree supports thousands of caterpillars because the producer is very large.

## Worked examples
1. Producers contain 20 000 kJ. Primary consumers have 20 000 × 0.1 = 2000 kJ. Secondary consumers have 2000 × 0.1 = 200 kJ.
2. Percentage transfer = energy gained ÷ energy available × 100. If primary consumers have 8000 kJ and secondary consumers gain 640 kJ, transfer = 640 ÷ 8000 × 100 = 8%.

## Common mistakes
- Pointing arrows the wrong way. Arrows point towards the consumer.
- Saying energy is "used up" or "destroyed". Energy is transferred or lost as heat.
- Forgetting that decomposers can feed on any level.
- Saying that removing a predator always helps the prey in the long term. The prey may increase and then run out of food.

## How this is examined
Typical questions give a food web and ask you to identify trophic levels, to write food chains, or to predict the effect of removing one species. Calculations of energy transfer and percentage efficiency are also common. Criterion D tasks may ask you to evaluate the effect of overfishing on a marine food web.

Exam tip: when predicting what happens when a population changes, trace the effects one link at a time, and use words such as "so" and "therefore" to show each step.$mq$ from st;

-- Ecosystems and Human Impact > Carbon and Nitrogen Cycles
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Ecosystems and Human Impact$mq$, 4, 10 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Carbon and Nitrogen Cycles$mq$, 4, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Ecosystems and Human Impact$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Carbon and Nitrogen Cycles$mq$ and p.name = $mq$Ecosystems and Human Impact$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which process removes carbon dioxide from the atmosphere?$mq$, $mq$["Photosynthesis","Respiration","Combustion","Decomposition"]$mq$, 0, $mq$Plants and algae use carbon dioxide in photosynthesis to make glucose.$mq$, $mq$easy$mq$),
($mq$Which gas makes up about 78% of the air?$mq$, $mq$["Hydrogen","Oxygen","Carbon dioxide","Nitrogen"]$mq$, 3, $mq$Nitrogen is the most abundant gas in air, but it is unreactive and most organisms cannot use it directly.$mq$, $mq$easy$mq$),
($mq$Which process releases carbon dioxide when wood or fossil fuels are burned?$mq$, $mq$["Digestion","Photosynthesis","Combustion","Nitrogen fixation"]$mq$, 2, $mq$Combustion is burning. Carbon in the fuel combines with oxygen to form carbon dioxide.$mq$, $mq$easy$mq$),
($mq$Coal, oil and gas formed from what?$mq$, $mq$["Volcanic gas","Remains of dead organisms","Sea water","Sand"]$mq$, 1, $mq$Fossil fuels formed over millions of years from the remains of dead plants and animals that were buried and compressed.$mq$, $mq$easy$mq$),
($mq$In what form do plants take up nitrogen from the soil?$mq$, $mq$["Nitrates","Ammonia gas","Nitrogen gas","Urea"]$mq$, 0, $mq$Plant roots absorb dissolved nitrate ions and use them to make amino acids and proteins.$mq$, $mq$easy$mq$),
($mq$Which process in living things returns carbon dioxide to the air?$mq$, $mq$["Photosynthesis","Nitrogen fixation","Absorption","Respiration"]$mq$, 3, $mq$All living things, including plants, release carbon dioxide by respiration.$mq$, $mq$medium$mq$),
($mq$Which bacteria live in the root nodules of legumes and convert nitrogen gas into nitrogen compounds?$mq$, $mq$["Denitrifying bacteria","Nitrifying bacteria","Nitrogen-fixing bacteria","Photosynthetic bacteria"]$mq$, 2, $mq$Nitrogen-fixing bacteria such as Rhizobium turn nitrogen gas into ammonia, which the plant can use.$mq$, $mq$medium$mq$),
($mq$How does carbon pass from plants to animals in a food chain?$mq$, $mq$["Photosynthesis","Feeding","Combustion","Fixation"]$mq$, 1, $mq$Animals eat plants and take in the carbon compounds, such as carbohydrates, proteins and fats.$mq$, $mq$medium$mq$),
($mq$What is the name of the process in which bacteria in waterlogged soil convert nitrates into nitrogen gas?$mq$, $mq$["Denitrification","Nitrification","Nitrogen fixation","Decomposition"]$mq$, 0, $mq$Denitrifying bacteria release nitrogen gas to the atmosphere. This reduces the nitrates available to plants.$mq$, $mq$medium$mq$),
($mq$Which human activity adds extra carbon dioxide to the atmosphere?$mq$, $mq$["Planting forests","Using solar panels","Building wetlands","Burning fossil fuels"]$mq$, 3, $mq$Burning coal, oil and gas releases carbon that had been locked away for millions of years.$mq$, $mq$medium$mq$),
($mq$Which gas is released when decomposers break down proteins and urea?$mq$, $mq$["Oxygen","Hydrogen","Ammonia","Carbon monoxide"]$mq$, 2, $mq$Decomposers release ammonia (ammonium ions), which nitrifying bacteria convert to nitrates.$mq$, $mq$medium$mq$),
($mq$Why do farmers plant legumes such as clover in a crop rotation?$mq$, $mq$["They add carbon dioxide","Their root bacteria fix nitrogen","They kill pathogens","They absorb ammonia"]$mq$, 1, $mq$Legumes have bacteria in root nodules which fix nitrogen, so more nitrate is available for the next crop.$mq$, $mq$medium$mq$),
($mq$Atmospheric carbon dioxide rose from 280 ppm to 420 ppm. What is the percentage increase?$mq$, $mq$["50%","140%","33%","67%"]$mq$, 0, $mq$Increase = 420 − 280 = 140 ppm. 140 ÷ 280 × 100 = 50%.$mq$, $mq$medium$mq$),
($mq$Why does deforestation increase the level of carbon dioxide in the atmosphere?$mq$, $mq$["Trees do not respire","Trees produce CO₂ by photosynthesis","Soil absorbs more CO₂","Fewer trees remove CO₂ by photosynthesis"]$mq$, 3, $mq$Fewer trees means less CO₂ is removed from the air. Burning or decay of the cleared trees also releases CO₂.$mq$, $mq$hard$mq$),
($mq$Why do farmers add nitrate fertilisers to the soil?$mq$, $mq$["The soil has too much nitrogen gas","Crops add nitrates to the soil","Crops remove nitrates from the soil","Fertiliser replaces photosynthesis"]$mq$, 2, $mq$When crops are harvested, the nitrogen compounds in them are removed. Fertilisers replace the nitrates so that the next crop can grow well.$mq$, $mq$hard$mq$),
($mq$A field becomes waterlogged for several weeks. What is the likely effect on soil nitrate?$mq$, $mq$["No change","Nitrate level falls","Nitrate level rises","Plants convert it to protein faster"]$mq$, 1, $mq$There is little oxygen in waterlogged soil, so denitrifying bacteria thrive. They convert nitrates to nitrogen gas, which is lost to the air.$mq$, $mq$hard$mq$),
($mq$A forest takes in 12 tonnes of carbon dioxide per hectare each year through photosynthesis and releases 9 tonnes through respiration. What is the net carbon dioxide taken in, in tonnes?$mq$, $mq$["3","21","9","12"]$mq$, 0, $mq$Net = 12 − 9 = 3 tonnes per hectare per year.$mq$, $mq$hard$mq$),
($mq$How does lightning contribute to the nitrogen cycle?$mq$, $mq$["It makes carbon dioxide","It converts nitrates into nitrogen gas","It kills decomposers","It converts nitrogen gas into nitrates"]$mq$, 3, $mq$The energy in lightning makes nitrogen and oxygen combine. The compounds dissolve in rain and enter the soil as nitrates.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Carbon and Nitrogen Cycles$mq$ and p.name = $mq$Ecosystems and Human Impact$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Photosynthesis in the carbon cycle$mq$, $mq$Removes CO₂ from the air and builds carbon compounds such as glucose in producers.$mq$),
($mq$Processes that release CO₂$mq$, $mq$Respiration, combustion of wood and fossil fuels, and decomposition by decomposers.$mq$),
($mq$Fossil fuels$mq$, $mq$Coal, oil and gas formed over millions of years from the remains of dead organisms. Burning them releases stored carbon as CO₂.$mq$),
($mq$Nitrogen fixation$mq$, $mq$Conversion of nitrogen gas into ammonia or nitrates by nitrogen-fixing bacteria (for example in legume root nodules) and by lightning.$mq$),
($mq$Nitrification$mq$, $mq$Nitrifying bacteria convert ammonia (ammonium) in the soil into nitrates.$mq$),
($mq$Denitrification$mq$, $mq$Denitrifying bacteria convert nitrates into nitrogen gas, mainly in waterlogged soil with little oxygen.$mq$),
($mq$How do plants and animals get nitrogen?$mq$, $mq$Plants absorb nitrates through their roots. Animals get nitrogen by eating plants or other animals.$mq$),
($mq$Role of decomposers$mq$, $mq$They break down dead organisms and waste. They release CO₂ and ammonia so the elements can be recycled.$mq$),
($mq$Why plant legumes in crop rotation?$mq$, $mq$Bacteria in their root nodules fix nitrogen, which adds nitrate to the soil for later crops.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Carbon and Nitrogen Cycles$mq$ and p.name = $mq$Ecosystems and Human Impact$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Elements such as carbon and nitrogen are not used up. They are recycled between the living and non-living parts of the environment in cycles. Decomposers are needed in every cycle.

## The carbon cycle
Carbon is the basis of all organic molecules. The main steps are:
- **Photosynthesis**: producers take carbon dioxide from the air and use it to make glucose. This removes CO₂ from the atmosphere.
- **Feeding**: carbon compounds pass from plants to herbivores and then to carnivores.
- **Respiration**: all organisms, including plants and decomposers, release CO₂ as they respire.
- **Decomposition**: decomposers break down dead organisms and waste, releasing CO₂ by respiration.
- **Combustion**: burning wood and fossil fuels releases CO₂. Fossil fuels formed over millions of years from the remains of dead organisms.

The atmosphere contains about 0.04% carbon dioxide. Deforestation and burning fossil fuels have increased it from about 280 ppm before the industrial period to over 400 ppm now. This is a major cause of global warming.

## The nitrogen cycle
Air is about 78% nitrogen gas, but plants and animals cannot use it directly. Organisms need nitrogen to make proteins and DNA.
- **Nitrogen fixation**: nitrogen-fixing bacteria, some in the root nodules of legumes such as peas, clover and beans, convert nitrogen gas into ammonia. Lightning also converts nitrogen into nitrates.
- **Nitrification**: nitrifying bacteria in the soil convert ammonia (ammonium ions) into nitrates.
- **Absorption**: plants absorb nitrates through their roots and use them to make amino acids and proteins.
- **Feeding**: animals get nitrogen by eating plants or other animals.
- **Decomposition**: decomposers break down dead organisms and waste such as urea, releasing ammonia.
- **Denitrification**: denitrifying bacteria, which thrive in waterlogged soil with little oxygen, convert nitrates into nitrogen gas that returns to the air.

## Human effects and farming
Crops take nitrates out of the soil, and harvesting removes them from the field. Farmers replace them with fertilisers or by growing legumes in crop rotation. Excess fertiliser can run into rivers and cause problems that are discussed in the next topic.

## Worked examples
1. A forest absorbs 12 tonnes of CO₂ per hectare per year by photosynthesis and releases 9 tonnes by respiration. The net uptake is 12 − 9 = 3 tonnes.
2. CO₂ rises from 280 ppm to 420 ppm. Percentage increase = (420 − 280) ÷ 280 × 100 = 50%.

## Common mistakes
- Saying plants only photosynthesise. They also respire all the time.
- Saying that plants take in nitrogen gas. They absorb nitrates.
- Mixing up nitrogen fixation (nitrogen gas to ammonia or nitrates) and denitrification (nitrates to nitrogen gas).
- Forgetting the role of decomposers. Without them, nutrients stay locked in dead matter.

## How this is examined
Questions show a cycle diagram with missing labels, or ask you to explain how an event, such as ploughing in a waterlogged field, changes the cycle. Criterion D questions may ask you to discuss ways to reduce atmospheric carbon dioxide.

Exam tip: name the process and the organism for each step in the cycle, such as "denitrifying bacteria carry out denitrification".$mq$ from st;

-- Ecosystems and Human Impact > Pollution, Habitat Loss and Conservation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Ecosystems and Human Impact$mq$, 4, 10 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Pollution, Habitat Loss and Conservation$mq$, 4, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Ecosystems and Human Impact$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Pollution, Habitat Loss and Conservation$mq$ and p.name = $mq$Ecosystems and Human Impact$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which gas contributes most to the enhanced greenhouse effect?$mq$, $mq$["Carbon dioxide","Oxygen","Nitrogen","Argon"]$mq$, 0, $mq$Carbon dioxide traps heat in the atmosphere. Burning fossil fuels has increased its concentration.$mq$, $mq$easy$mq$),
($mq$What is the clearing of large areas of forest called?$mq$, $mq$["Afforestation","Eutrophication","Conservation","Deforestation"]$mq$, 3, $mq$Deforestation removes trees for farmland, timber, mining or buildings.$mq$, $mq$easy$mq$),
($mq$What is the variety of living things in an ecosystem called?$mq$, $mq$["Food web","Population","Biodiversity","Habitat"]$mq$, 2, $mq$Biodiversity includes the number of species and the genetic variety within them.$mq$, $mq$easy$mq$),
($mq$Sulfur dioxide released by burning fossil fuels causes which environmental problem?$mq$, $mq$["Eutrophication","Acid rain","Overfishing","Soil erosion"]$mq$, 1, $mq$Sulfur dioxide dissolves in rain water to form acid rain, which damages trees and lakes.$mq$, $mq$easy$mq$),
($mq$What is the protection and management of species and habitats called?$mq$, $mq$["Conservation","Pollution","Deforestation","Extinction"]$mq$, 0, $mq$Conservation aims to protect biodiversity and ecosystems.$mq$, $mq$easy$mq$),
($mq$Fertiliser runs into a lake and causes excess growth of algae. What is this called?$mq$, $mq$["Bioaccumulation","Acid rain","Deforestation","Eutrophication"]$mq$, 3, $mq$Nitrates and phosphates act as nutrients, causing algae to multiply rapidly in an algal bloom.$mq$, $mq$medium$mq$),
($mq$What happens to fish in a lake that has become eutrophic?$mq$, $mq$["They grow faster","They get more food","They die from lack of oxygen","They move onto land"]$mq$, 2, $mq$Decomposers use up the oxygen as they break down dead algae and plants, so fish suffocate.$mq$, $mq$medium$mq$),
($mq$Which gas produced by cattle and in rice fields is a greenhouse gas?$mq$, $mq$["Nitrogen","Methane","Oxygen","Argon"]$mq$, 1, $mq$Methane is a powerful greenhouse gas made by microorganisms in the guts of cattle and in waterlogged paddy fields.$mq$, $mq$medium$mq$),
($mq$What increases when trees are removed from a hillside?$mq$, $mq$["Soil erosion","Biodiversity","Soil fertility","Oxygen in the soil"]$mq$, 0, $mq$Roots hold soil together. Without them, rain washes soil away.$mq$, $mq$medium$mq$),
($mq$Toxic substances such as mercury become more concentrated in the bodies of organisms at higher levels of a food chain. What is this called?$mq$, $mq$["Eutrophication","Decomposition","Photosynthesis","Biomagnification"]$mq$, 3, $mq$Toxins are not broken down or excreted, so they build up in each organism and become more concentrated at every higher level, because each consumer takes in the toxins from all of the prey it eats.$mq$, $mq$medium$mq$),
($mq$Which conservation method protects animals in their natural habitat?$mq$, $mq$["Zoo breeding programmes","Seed banks","National parks","Laboratory cloning"]$mq$, 2, $mq$Protected areas such as national parks keep habitats safe, with laws that control hunting and building.$mq$, $mq$medium$mq$),
($mq$What is the purpose of a seed bank?$mq$, $mq$["Remove carbon dioxide","Protect plant species from extinction","Grow crops faster","Feed animals"]$mq$, 1, $mq$Seed banks store seeds from many species, which can be used to regrow populations if species are lost in the wild.$mq$, $mq$medium$mq$),
($mq$A forest of 4000 hectares loses 5% of its area each year. How many hectares are lost in one year?$mq$, $mq$["200","20","800","2000"]$mq$, 0, $mq$5% of 4000 = 0.05 × 4000 = 200 hectares.$mq$, $mq$medium$mq$),
($mq$Why does acid rain kill fish in some lakes?$mq$, $mq$["Rain washes in fertilisers","Lake water becomes too warm","Rain adds extra oxygen","Lake water becomes too acidic"]$mq$, 3, $mq$A low pH damages the gills and eggs of fish, and releases toxic metals from the soil into the water.$mq$, $mq$hard$mq$),
($mq$In eutrophication, what happens after an algal bloom forms on the surface of a lake?$mq$, $mq$["Oxygen levels rise","Fish numbers increase","Plants below die because light is blocked","Nitrate runs out immediately"]$mq$, 2, $mq$The thick surface layer blocks light, so plants below cannot photosynthesise and die. Decomposers then use up the oxygen.$mq$, $mq$hard$mq$),
($mq$A pesticide has a concentration of 0.04 ppm in plankton and 25 ppm in fish-eating birds. How many times more concentrated is it in the birds?$mq$, $mq$["25","625","6.25","1250"]$mq$, 1, $mq$25 ÷ 0.04 = 625 times.$mq$, $mq$hard$mq$),
($mq$A government introduces fishing quotas. What is the best argument in support of this?$mq$, $mq$["Fish stocks can recover for the future","Fish no longer need food","Everyone can catch as many fish as they like","Fishing boats become cheaper"]$mq$, 0, $mq$Quotas limit the numbers caught, so fish can breed and populations are maintained. This is sustainable fishing.$mq$, $mq$hard$mq$),
($mq$Clearing a rainforest for farmland provides income now. Which is a long-term disadvantage?$mq$, $mq$["Cheaper food in the short term","Jobs for farmers","More crop land","Loss of habitats and biodiversity"]$mq$, 3, $mq$Rainforest species may become extinct, and soils may lose fertility and wash away, so the benefits may not last.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Pollution, Habitat Loss and Conservation$mq$ and p.name = $mq$Ecosystems and Human Impact$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Deforestation$mq$, $mq$The clearing of large areas of forest. It reduces habitats, increases soil erosion and means less CO₂ is removed.$mq$),
($mq$Enhanced greenhouse effect$mq$, $mq$Extra warming caused by increased CO₂ and methane from human activities that trap more heat in the atmosphere.$mq$),
($mq$Acid rain$mq$, $mq$Rain made acidic by sulfur dioxide and nitrogen oxides from burning fossil fuels. It damages trees and kills life in lakes.$mq$),
($mq$Eutrophication: sequence$mq$, $mq$Fertiliser runoff, algal bloom, light blocked so plants die, decomposers use up oxygen, fish die.$mq$),
($mq$Bioaccumulation and biomagnification$mq$, $mq$Toxins such as mercury or pesticides build up in organisms (bioaccumulation) and become more concentrated at each higher trophic level (biomagnification).$mq$),
($mq$Biodiversity$mq$, $mq$The variety of living things in a habitat or ecosystem, including the number of species.$mq$),
($mq$Causes of extinction$mq$, $mq$Habitat loss, overhunting and overfishing, pollution, invasive species and climate change.$mq$),
($mq$Conservation methods$mq$, $mq$National parks, captive breeding, seed banks, quotas, replanting and laws or agreements.$mq$),
($mq$Sustainable fishing$mq$, $mq$Using quotas and limits so fish can breed and populations recover, so fishing can continue in the future.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Pollution, Habitat Loss and Conservation$mq$ and p.name = $mq$Ecosystems and Human Impact$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Human activities are changing ecosystems more quickly than ever before. The main impacts are pollution, habitat loss and loss of biodiversity. Conservation tries to reduce the damage.

## Air pollution and climate
- **Greenhouse effect and global warming**: gases such as carbon dioxide and methane trap heat in the atmosphere. Burning fossil fuels, deforestation and farming have increased their concentrations. Possible effects include melting ice, rising sea levels and changes in habitats.
- **Acid rain**: sulfur dioxide and nitrogen oxides from burning fossil fuels dissolve in rain water. Acid rain damages trees and makes lakes too acidic for fish, as well as eroding buildings.

## Water pollution
- **Eutrophication**: fertilisers or sewage run into rivers and lakes. The extra nitrates and phosphates cause algae to grow quickly in an algal bloom. The algae block light, so plants below die. Decomposers breaking down the dead material use up oxygen, and fish and other animals suffocate.
- **Bioaccumulation and biomagnification**: toxic chemicals such as pesticides and mercury are not broken down. They build up in the body of each organism (bioaccumulation) and become more concentrated at each higher trophic level (biomagnification), harming top predators.

## Habitat loss
Habitats are destroyed by deforestation, farming, building, mining and draining wetlands. Cutting trees also increases soil erosion and reduces the amount of carbon dioxide removed from the air. Habitat loss is the biggest cause of species becoming extinct, along with overhunting, overfishing and invasive species.

## Conservation methods
- **Protected areas** such as national parks and reserves, with laws about hunting and building.
- **Captive breeding programmes** in zoos, followed by release.
- **Seed banks** to store seeds of many species.
- **Quotas and regulations** on fishing and hunting.
- **Replanting forests** and managing them sustainably.
- **Education and international agreements** to reduce trade in endangered species.

## Evaluating solutions
Conservation often involves conflicts between people. A reserve may protect species but remove farmland from local people. Good solutions consider environmental, economic and social effects, and involve local communities.

## Worked example
A pesticide is 0.04 ppm in plankton and 25 ppm in fish-eating birds. The concentration in the birds is 25 ÷ 0.04 = 625 times greater. This shows biomagnification. A second example: a forest of 4000 hectares loses 5% each year, which is 0.05 × 4000 = 200 hectares.

## Common mistakes
- Mixing up the greenhouse effect (a natural process that keeps Earth warm) with the enhanced greenhouse effect (extra warming from human activity).
- Saying that algae directly use up oxygen in eutrophication. It is the decomposers that use up the oxygen.
- Confusing acid rain (sulfur dioxide, nitrogen oxides) with global warming (carbon dioxide, methane).
- Writing only "pollution is bad". Name the pollutant, the process and the effect.

## How this is examined
Criterion D questions often give a case study, such as a lake affected by fertiliser runoff or a reserve in a developing country, and ask you to describe the impact, suggest solutions and evaluate them. You may be given data on pollutant levels or forest area and asked to calculate percentage change.

Exam tip: for evaluate questions, give at least one advantage and one limitation of a solution and finish with a justified judgement.$mq$ from st;

-- Disease and Immunity > Pathogens and How Diseases Spread
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Disease and Immunity$mq$, 4, 11 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Pathogens and How Diseases Spread$mq$, 4, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Disease and Immunity$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Pathogens and How Diseases Spread$mq$ and p.name = $mq$Disease and Immunity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a microorganism that causes disease called?$mq$, $mq$["Pathogen","Vector","Antibody","Antigen"]$mq$, 0, $mq$A pathogen is a microorganism, such as a bacterium, virus, fungus or protist, that causes disease.$mq$, $mq$easy$mq$),
($mq$Which type of pathogen causes malaria?$mq$, $mq$["Fungus","Bacterium","Virus","Protist"]$mq$, 3, $mq$Malaria is caused by a single-celled protist called Plasmodium.$mq$, $mq$easy$mq$),
($mq$What is a disease that can be passed from one person to another called?$mq$, $mq$["Non-communicable disease","Genetic disease","Communicable disease","Deficiency disease"]$mq$, 2, $mq$Communicable (infectious) diseases are caused by pathogens that spread between hosts.$mq$, $mq$easy$mq$),
($mq$What is an organism that carries a pathogen from one host to another without usually being harmed called?$mq$, $mq$["Antigen","Vector","Antibody","Producer"]$mq$, 1, $mq$A vector such as a mosquito transmits a pathogen, but does not get the disease itself.$mq$, $mq$easy$mq$),
($mq$Which type of pathogen causes influenza?$mq$, $mq$["Virus","Bacterium","Fungus","Protist"]$mq$, 0, $mq$Influenza (flu) is caused by an influenza virus.$mq$, $mq$easy$mq$),
($mq$Which animal is the vector for malaria?$mq$, $mq$["Housefly","Rat","Tick","Mosquito"]$mq$, 3, $mq$Female Anopheles mosquitoes pick up the pathogen from infected people when they feed on blood and pass it to the next person they bite.$mq$, $mq$medium$mq$),
($mq$Antibiotics are used to treat infections caused by which type of pathogen?$mq$, $mq$["Cancer cells","Viruses","Bacteria","Human cells"]$mq$, 2, $mq$Antibiotics kill bacteria or stop them growing. They do not work against viruses.$mq$, $mq$medium$mq$),
($mq$Cholera is usually spread by what?$mq$, $mq$["Mosquito bites","Contaminated water","Sexual contact","Droplets in the air"]$mq$, 1, $mq$Cholera bacteria spread through drinking water or food contaminated with faeces from an infected person.$mq$, $mq$medium$mq$),
($mq$How does influenza spread from person to person?$mq$, $mq$["Droplets from coughs and sneezes","Soil","Contaminated water","Mosquito bites"]$mq$, 0, $mq$Tiny droplets containing the virus are breathed in or picked up on hands and surfaces.$mq$, $mq$medium$mq$),
($mq$Which measure helps to prevent food-borne diseases?$mq$, $mq$["Using mosquito nets","Draining ponds","Vaccinating mosquitoes","Cooking food thoroughly"]$mq$, 3, $mq$Heat kills most bacteria in food. Washing hands and storing food correctly also help.$mq$, $mq$medium$mq$),
($mq$Why does draining pools of stagnant water help to reduce malaria?$mq$, $mq$["Mosquitoes drink the water","The pathogen lives in the water","Mosquitoes breed in standing water","Water carries the vaccine"]$mq$, 2, $mq$Mosquito larvae develop in still water, so removing it reduces the number of mosquitoes.$mq$, $mq$medium$mq$),
($mq$One bacterium divides every 30 minutes. How many bacteria are there after 4 hours?$mq$, $mq$["128","256","8","16"]$mq$, 1, $mq$4 hours = 240 minutes = 8 divisions. 2⁸ = 256 bacteria.$mq$, $mq$medium$mq$),
($mq$How do many bacteria make us ill?$mq$, $mq$["They release toxins","They make antibodies","They absorb all the oxygen","They are too large to digest"]$mq$, 0, $mq$Bacteria can release toxins that damage tissues, as well as damaging cells directly.$mq$, $mq$medium$mq$),
($mq$Why are antibiotics not used to treat a cold?$mq$, $mq$["Colds are not infectious","Colds are caused by fungi","Antibiotics are too weak","Colds are caused by viruses"]$mq$, 3, $mq$Antibiotics target bacteria. Viruses live inside host cells, and need to be treated in other ways, such as the immune system or antiviral drugs.$mq$, $mq$hard$mq$),
($mq$After bed nets were provided in a region, malaria cases fell from 2400 to 1560 per year. What is the percentage decrease?$mq$, $mq$["65%","54%","35%","840%"]$mq$, 2, $mq$Decrease = 2400 − 1560 = 840. 840 ÷ 2400 × 100 = 35%.$mq$, $mq$hard$mq$),
($mq$Why is controlling a vector often an effective way to control a disease?$mq$, $mq$["The vector makes antibodies","The pathogen cannot reach new hosts without it","The vector is the only host of the pathogen","Vectors cannot reproduce"]$mq$, 1, $mq$Breaking the transmission cycle prevents new infections even when infected people are still present.$mq$, $mq$hard$mq$),
($mq$A filter paper disc with an antibiotic placed on an agar plate of bacteria produces a circular clear zone of radius 10 mm. Using π = 3.14, what is the area of the clear zone in mm²?$mq$, $mq$["314","63","31.4","100"]$mq$, 0, $mq$Area = πr² = 3.14 × 10 × 10 = 314 mm².$mq$, $mq$hard$mq$),
($mq$Three antibiotic discs on the same bacteria give clear zones of diameter: A 12 mm, B 20 mm and C 8 mm. Which antibiotic is likely to be most effective against these bacteria?$mq$, $mq$["Antibiotic A","Antibiotic C","They are equally effective","Antibiotic B"]$mq$, 3, $mq$The largest clear zone shows the antibiotic prevented bacterial growth over the greatest distance. The same size of disc, concentration and agar are needed for a fair test.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Pathogens and How Diseases Spread$mq$ and p.name = $mq$Disease and Immunity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Pathogen$mq$, $mq$A microorganism that causes disease: bacteria, viruses, fungi and protists.$mq$),
($mq$Communicable disease$mq$, $mq$A disease caused by a pathogen that can be passed from one organism to another.$mq$),
($mq$Bacteria vs viruses$mq$, $mq$Bacteria are living cells that reproduce on their own and can be killed by antibiotics. Viruses are not cells and reproduce inside host cells.$mq$),
($mq$Malaria$mq$, $mq$Caused by the protist Plasmodium. It is spread by mosquitoes, which are the vector.$mq$),
($mq$Four ways diseases spread$mq$, $mq$Direct contact, airborne droplets, contaminated food or water, and vectors.$mq$),
($mq$Vector$mq$, $mq$An organism that transmits a pathogen between hosts, for example the Anopheles mosquito for malaria.$mq$),
($mq$Prevention of cholera$mq$, $mq$Clean drinking water and proper sewage treatment, as the bacteria spread through contaminated water.$mq$),
($mq$Do antibiotics work on viruses?$mq$, $mq$No. Antibiotics only kill bacteria. Viruses live inside host cells.$mq$),
($mq$Clear zone on an agar plate$mq$, $mq$The area around an antibiotic disc where bacteria cannot grow. A larger clear zone means a more effective antibiotic.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Pathogens and How Diseases Spread$mq$ and p.name = $mq$Disease and Immunity$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$A **pathogen** is a microorganism that causes disease. Diseases caused by pathogens that can pass from one organism to another are called **communicable** (infectious) diseases. Diseases that cannot be passed on, such as diabetes or heart disease, are non-communicable.

## Types of pathogen
- **Bacteria**: single-celled organisms with no nucleus. They reproduce quickly by binary fission and make you ill by releasing toxins and damaging cells. Examples: cholera, salmonella food poisoning, tuberculosis.
- **Viruses**: tiny particles that are not cells. They can only reproduce inside the cells of a host, which they damage. Examples: influenza, measles, HIV, the common cold.
- **Fungi**: for example athlete's foot, a skin infection.
- **Protists**: single-celled organisms with a nucleus. Malaria is caused by the protist Plasmodium.

## How pathogens spread
- **Direct contact**: touching an infected person or surface, or exchanging body fluids. Athlete's foot and HIV can spread this way.
- **Airborne droplets**: coughing and sneezing release droplets. Influenza and measles spread like this.
- **Contaminated food and water**: cholera and salmonella spread when food or water contains the pathogen.
- **Vectors**: organisms that carry pathogens. Female Anopheles mosquitoes carry the malaria protist from person to person.

## Preventing the spread
- Washing hands, covering coughs, and cooking food well.
- Clean water and good sewage treatment, which stop cholera.
- Controlling vectors: draining stagnant water, using insecticides and bed nets.
- Isolating infected people and using vaccination (covered in the next sub-topic).
- Using condoms to reduce the spread of HIV.

## Treating infections
**Antibiotics** such as penicillin kill bacteria but do not work against viruses, which live inside cells. Overusing antibiotics lets resistant bacteria survive and multiply, which is natural selection. For viruses, doctors may use antiviral drugs, rest and vaccination.

## Testing antibiotics
In the lab, bacteria are spread on an agar plate and discs soaked in different antibiotics are placed on top. After incubation, a clear zone appears around a disc where bacteria could not grow. A larger clear zone means a more effective antibiotic. For a fair test the discs must have the same size and concentration, and the plates the same temperature and time. Area of a clear zone = πr². A zone of radius 10 mm has area 3.14 × 10 × 10 = 314 mm².

## Worked example
One bacterium divides every 30 minutes. In 4 hours there are 240 ÷ 30 = 8 divisions, so there are 2⁸ = 256 bacteria. This shows why an infection can spread quickly once it begins. Percentage decrease: malaria cases fall from 2400 to 1560. Decrease = 840, and 840 ÷ 2400 × 100 = 35%.

## Common mistakes
- Saying that antibiotics kill viruses.
- Saying that the mosquito "gets" malaria. It is a vector that carries the protist.
- Calling all pathogens "germs" or "bacteria". Be specific.
- Confusing "contagious" with "caused by any microbe". Many microbes are harmless or useful.

## How this is examined
Expect a table comparing the pathogens and routes of transmission, or a case study of an outbreak. Data tasks include percentage change in cases and bacterial growth. Criterion D tasks may ask you to evaluate different strategies to control malaria, such as bed nets, drugs and drainage.

Exam tip: name the pathogen type, the way it spreads, and the control measure, and make sure each control measure links to the way the disease spreads.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('biology')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;