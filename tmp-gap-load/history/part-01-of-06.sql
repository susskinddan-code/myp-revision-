-- Part 1 of 6: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Health and Medicine Through Time > Ancient and Medieval Medicine
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Health and Medicine Through Time$mq$, 5, 1 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Ancient and Medieval Medicine$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Health and Medicine Through Time$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Ancient and Medieval Medicine$mq$ and p.name = $mq$Health and Medicine Through Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Ancient Greek doctors believed that illness was caused by an imbalance of four fluids in the body. What name is given to this theory?$mq$, $mq$["The theory of the four humours","The germ theory","The theory of miasma only","The theory of the four seasons"]$mq$, 0, $mq$The Greeks, following Hippocrates, taught that blood, phlegm, yellow bile and black bile had to stay in balance. Germ theory came much later.$mq$, $mq$easy$mq$),
($mq$Which Roman-era physician dissected animals such as pigs and apes and wrote books that European doctors trusted for about 1,400 years?$mq$, $mq$["Hippocrates","Vesalius","Pasteur","Galen"]$mq$, 3, $mq$Galen worked in the Roman Empire in the 2nd century AD. Hippocrates lived earlier, and Vesalius and Pasteur lived much later.$mq$, $mq$easy$mq$),
($mq$Which ancient civilisation produced the Ebers Papyrus, a medical text listing remedies and treatments from around 1550 BC?$mq$, $mq$["Ancient Rome","Medieval England","Ancient Egypt","Ancient China"]$mq$, 2, $mq$The Ebers Papyrus is an Egyptian medical document. It shows that Egyptians used herbs and recorded treatments.$mq$, $mq$easy$mq$),
($mq$Which disease killed a very large share of Europe's population between 1347 and the early 1350s?$mq$, $mq$["Smallpox","The Black Death","Polio","Cholera"]$mq$, 1, $mq$The Black Death, a plague pandemic, reached Europe in the late 1340s and killed perhaps a third or more of the population. Cholera became a major killer in the 1800s.$mq$, $mq$easy$mq$),
($mq$Why did Roman engineers build aqueducts and public baths?$mq$, $mq$["To bring in clean water and support public hygiene","To cure the Black Death","To prove the humours theory","To train doctors in dissection"]$mq$, 0, $mq$Romans linked cleanliness with health. Aqueducts supplied fresh water, and baths and sewers helped remove waste, although they did not know about germs.$mq$, $mq$easy$mq$),
($mq$A medieval doctor tells a patient with a fever that the body has too much blood and cuts a vein to drain some. Which idea is the doctor using?$mq$, $mq$["Germ theory, treated by antiseptics","Miasma, treated by quarantine","Vaccination, treated by cowpox","The four humours, treated by bloodletting"]$mq$, 3, $mq$Bloodletting was meant to restore the balance of the humours. It usually weakened patients rather than helping them.$mq$, $mq$medium$mq$),
($mq$Why did Galen's ideas stay almost unchallenged in medieval Europe?$mq$, $mq$["His work had been proved correct by dissecting human bodies","Printed copies were available to every household","The Church approved of his belief in a single creator and discouraged questioning him","Islamic scholars had banned any other books"]$mq$, 2, $mq$Galen's ideas fitted Christian teaching, and the Church controlled universities. Galen mostly used animal dissection, so his anatomy had errors, and printing had not yet arrived.$mq$, $mq$medium$mq$),
($mq$Which statement best describes Islamic medicine between roughly 800 and 1200?$mq$, $mq$["It rejected all Greek ideas","Scholars preserved Greek texts and added their own observations, and built hospitals","It invented germ theory","It banned the use of herbs"]$mq$, 1, $mq$Scholars in places such as Baghdad translated Greek texts and tested ideas. Ibn Sina wrote the Canon of Medicine and al-Razi distinguished smallpox from measles.$mq$, $mq$medium$mq$),
($mq$During the Black Death, some people whipped themselves in processions. What belief lay behind this?$mq$, $mq$["That the plague was a punishment from God and had to be atoned for","That whipping killed the fleas","That the humours needed heating","That the plague was caused by bacteria in water"]$mq$, 0, $mq$Flagellants thought the disease was divine punishment. Other explanations at the time included bad air (miasma), the position of the planets and blaming minorities.$mq$, $mq$medium$mq$),
($mq$A source says that in 1348 people carried flowers and burned herbs to avoid breathing 'bad air'. Which medieval belief does this show?$mq$, $mq$["Germ theory","Vaccination","Contagion through DNA","Miasma"]$mq$, 3, $mq$Miasma was the belief that disease spread from foul-smelling air. It was a common explanation for illness before germs were discovered.$mq$, $mq$medium$mq$),
($mq$Which of these was a strength of Roman medicine, compared with medieval medicine in much of Europe?$mq$, $mq$["A correct understanding of the causes of plague","Widespread use of anaesthetics","Strong public health, including sewers and army hospitals","Accurate human dissection by all surgeons"]$mq$, 2, $mq$The Romans built sewers such as the Cloaca Maxima and organised army hospitals (valetudinaria). Their understanding of causes was still wrong.$mq$, $mq$medium$mq$),
($mq$Which pair correctly matches a physician with his achievement?$mq$, $mq$["Hippocrates - discovered penicillin","Ibn Sina - wrote the Canon of Medicine","Galen - proved blood circulates","Vesalius - invented vaccination"]$mq$, 1, $mq$Ibn Sina (Avicenna) wrote the Canon of Medicine in the early 11th century. Harvey explained circulation, Fleming discovered penicillin and Jenner developed vaccination.$mq$, $mq$medium$mq$),
($mq$Look at this claim: 'Medicine made no progress in the Middle Ages.' Which fact most clearly challenges the claim?$mq$, $mq$["Islamic hospitals and medical writing, and universities such as Salerno, developed knowledge","Doctors cured the plague with bloodletting","Surgeons used germ theory","Galen's books were burned"]$mq$, 0, $mq$Progress did occur in places, for example in Islamic medicine and in teaching at medieval universities. The other statements are false.$mq$, $mq$medium$mq$),
($mq$Which reason best explains why a medieval town might have had worse public health than a Roman city of similar size?$mq$, $mq$["Romans understood germs","Medieval towns had no doctors","Medieval people did not value cleanliness at all","Roman government organised water supply and drainage, while medieval towns often relied on local efforts and open waste"]$mq$, 3, $mq$Roman authorities funded aqueducts and sewers. Many medieval towns had cess pits, open drains and polluted rivers, though some did regulate waste. Neither culture knew about germs.$mq$, $mq$hard$mq$),
($mq$Evaluate: 'The ideas of Hippocrates were mostly wrong, so he had no significance.' Which response is the most balanced?$mq$, $mq$["He is insignificant because every idea he had was disproved","He is the most significant because he discovered germs","He is significant for encouraging careful observation and natural explanations, even though the humours theory was wrong","He is significant only because he dissected humans"]$mq$, 2, $mq$Hippocrates moved medicine away from supernatural explanations towards observation of symptoms. Judging significance means looking at influence, not only whether ideas were correct.$mq$, $mq$hard$mq$),
($mq$The Black Death of 1348 reached England, and the king's government passed laws about labour afterwards. What does this show about the impact of the plague?$mq$, $mq$["It ended all belief in religion","It had social and economic effects as well as medical ones, since fewer workers raised wages","It proved the miasma theory correct","It caused the invention of surgery"]$mq$, 1, $mq$Because so many workers died, labour became scarce and wages rose, which led to attempts to control wages such as the Ordinance of Labourers (1349). The plague changed society, not just health.$mq$, $mq$hard$mq$),
($mq$A historian argues that Galen held back medicine. Which evidence best supports that argument?$mq$, $mq$["Vesalius found in 1543 that Galen's descriptions of the human body contained errors, after centuries of acceptance","Galen dissected animals","Galen wrote many books","Galen worked in the Roman Empire"]$mq$, 0, $mq$Vesalius, using human dissection, showed errors in Galen's anatomy. Respect for Galen's authority had discouraged people from checking his claims.$mq$, $mq$hard$mq$),
($mq$Which comparison between Ancient Egyptian and Ancient Greek medicine is most accurate?$mq$, $mq$["Egyptians developed germ theory and Greeks did not","Greeks only used prayer while Egyptians only used herbs","Neither used any natural remedies","Both used observation and remedies, but the Greeks developed a more rational theory of natural causes of disease"]$mq$, 3, $mq$Egyptians used herbs, practical treatments and some religious ideas. The Greeks developed rational theories such as the four humours. Neither knew about germs.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Ancient and Medieval Medicine$mq$ and p.name = $mq$Health and Medicine Through Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Four humours$mq$, $mq$The Greek theory that health depended on balance between blood, phlegm, yellow bile and black bile. Linked with Hippocrates and used for about 2,000 years.$mq$),
($mq$Hippocrates (c.460-370 BC)$mq$, $mq$Greek doctor who encouraged careful observation of symptoms and natural explanations of disease. The Hippocratic Oath is linked to his tradition.$mq$),
($mq$Galen$mq$, $mq$Greek doctor in the Roman Empire (2nd century AD). Dissected animals, so made errors about human anatomy. His books dominated European medicine for about 1,400 years.$mq$),
($mq$Miasma$mq$, $mq$The belief that disease was spread by bad air or foul smells from rotting matter.$mq$),
($mq$Bloodletting$mq$, $mq$Draining blood from a patient to restore the balance of the humours. Common from ancient times to the 1800s.$mq$),
($mq$Roman public health$mq$, $mq$Aqueducts, public baths, sewers (such as the Cloaca Maxima) and army hospitals (valetudinaria), built to supply clean water and remove waste.$mq$),
($mq$Black Death$mq$, $mq$Plague pandemic that reached Europe in 1347 and England in 1348, killing perhaps a third or more of the population.$mq$),
($mq$Ibn Sina (Avicenna)$mq$, $mq$Islamic scholar who wrote the Canon of Medicine in the early 11th century. His book was used in Europe for centuries.$mq$),
($mq$Why was Galen trusted so long?$mq$, $mq$His ideas fitted Christian teaching, the Church controlled education, and few people dissected human bodies to check him.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Ancient and Medieval Medicine$mq$ and p.name = $mq$Health and Medicine Through Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Medicine before the modern age was shaped by what people believed caused disease. Over many centuries the main explanations were supernatural, then rational, and later scientific. In this topic you need to know the ideas, the key people and why some ideas lasted so long.

## Ancient medicine
The Ancient Egyptians used herbs, honey and simple surgery, and recorded treatments on papyrus, such as the Ebers Papyrus from about 1550 BC. They also linked illness with gods and spirits. Their practice of mummification gave them some knowledge of the body.

The Ancient Greeks moved towards rational explanations. Hippocrates, who lived around 460-370 BC, encouraged doctors to observe symptoms carefully and to look for natural causes. He and his followers supported the theory of the **four humours**: blood, phlegm, yellow bile and black bile. Illness was thought to come from an imbalance, so treatment aimed to restore balance, for example by **bloodletting** or changing diet. The Hippocratic Oath, an ethical code for doctors, comes from this tradition.

The Romans learned from the Greeks. Galen, a Greek doctor working in the Roman Empire in the 2nd century AD, dissected animals and wrote many books. Because Roman law limited human dissection, he made mistakes about human anatomy. The Romans were most successful in **public health**: aqueducts, public baths, sewers such as the Cloaca Maxima and hospitals for soldiers called valetudinaria. They did not know about germs, but they believed that clean water and hygiene helped health.

## Medieval medicine
In medieval Europe the Church was powerful, and Galen's ideas were accepted partly because they fitted Christian beliefs. People did not question him much, so progress was slow. Monks copied books and cared for the sick. Many people also believed that disease could be a punishment from God, or be caused by bad air (**miasma**) or the stars.

The **Black Death** reached Europe in 1347 and England in 1348, killing perhaps a third or more of the population. People tried many responses: prayer, processions, flagellants who whipped themselves, herbs, strong smells, bloodletting and fleeing from towns. Some groups were blamed unfairly and persecuted. None of these cured the disease because nobody knew it was caused by bacteria carried by fleas.

At the same time, scholars in the Islamic world made real progress. They translated Greek texts, and Ibn Sina (Avicenna) wrote the Canon of Medicine, used in Europe for centuries. Al-Razi distinguished smallpox from measles. Hospitals called bimaristans treated patients in cities such as Baghdad. Universities such as Salerno also taught medicine in Europe.

## Common mistakes
- Do not say medieval people were stupid. Their explanations made sense with the evidence they had.
- Do not mix up Hippocrates (humours) with Galen (anatomy and dissection of animals).
- Remember that neither the Greeks, Romans nor medieval doctors knew about germs.

## How this is examined
You may be given a short source, such as a description of a plague remedy, and asked to explain which belief it reflects, how useful it is as evidence, or to compare periods. Questions ask you to identify continuity and change and to judge significance, using command terms such as explain, compare and evaluate. Always link your point to evidence from the source and your own knowledge.

Exam tip: When you explain a treatment, name the belief behind it (humours, miasma or religion) and then say why people thought it would work.$mq$ from st;

-- Health and Medicine Through Time > Germ Theory, Vaccines and Public Health
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Health and Medicine Through Time$mq$, 5, 1 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Germ Theory, Vaccines and Public Health$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Health and Medicine Through Time$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Germ Theory, Vaccines and Public Health$mq$ and p.name = $mq$Health and Medicine Through Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Who developed the first vaccine, using cowpox to protect against smallpox, in 1796?$mq$, $mq$["Edward Jenner","Louis Pasteur","Joseph Lister","Alexander Fleming"]$mq$, 0, $mq$Jenner tested cowpox material on a boy, James Phipps, and showed he was protected from smallpox. Pasteur later developed other vaccines.$mq$, $mq$easy$mq$),
($mq$What did Louis Pasteur's germ theory claim?$mq$, $mq$["That disease comes from bad air","That the humours cause fever","That disease is a punishment from God","That microbes cause disease"]$mq$, 3, $mq$Pasteur showed that microbes in the air caused decay, and the theory was applied to disease. Miasma, humours and divine punishment were older explanations.$mq$, $mq$easy$mq$),
($mq$Which doctor introduced carbolic acid as an antiseptic in surgery in 1865?$mq$, $mq$["Robert Koch","Edward Jenner","Joseph Lister","John Snow"]$mq$, 2, $mq$Lister used carbolic acid on wounds, instruments and in sprays, which cut infection rates after operations.$mq$, $mq$easy$mq$),
($mq$Which scientist identified the bacterium that causes anthrax in 1876, and later tuberculosis and cholera?$mq$, $mq$["Florey","Robert Koch","Semmelweis","Simpson"]$mq$, 1, $mq$Koch linked specific bacteria to specific diseases, using stains and solid growth media to isolate them.$mq$, $mq$easy$mq$),
($mq$What did John Snow remove in 1854 to stop a cholera outbreak in Soho, London?$mq$, $mq$["The handle of the Broad Street water pump","A sewer pipe","A hospital door","A bakery oven"]$mq$, 0, $mq$Snow mapped cases and saw they clustered around the Broad Street pump. His work supported the idea that cholera was spread by water.$mq$, $mq$easy$mq$),
($mq$Which of these was a key breakthrough made by Pasteur's swan-neck flask experiment?$mq$, $mq$["It proved that penicillin kills bacteria","It showed that blood circulates","It created the first vaccine","It showed that microbes in the air, not spontaneous generation, caused broth to go off"]$mq$, 3, $mq$Broth in a flask with a curved neck stayed clear because dust and microbes were trapped. This challenged spontaneous generation.$mq$, $mq$medium$mq$),
($mq$Why was the work of Robert Koch important for developing cures and vaccines?$mq$, $mq$["He proved all diseases were caused by bad air","He abolished all hospitals","Identifying the specific microbe for each disease let scientists target it","He discovered anaesthetics"]$mq$, 2, $mq$Once the cause of a disease was known, others could search for ways to stop that specific microbe. Koch's methods helped identify the agents of anthrax, TB and cholera.$mq$, $mq$medium$mq$),
($mq$Before 1847, many women died of puerperal fever in Vienna General Hospital. Ignaz Semmelweis reduced deaths by ordering doctors to do what?$mq$, $mq$["Use ether during births","Wash their hands in a chlorine solution","Take cowpox vaccine","Open all windows"]$mq$, 1, $mq$Semmelweis noticed that deaths were higher in the ward where doctors came from autopsies. His hand-washing order cut the death rate, but many doctors rejected his ideas because there was no accepted germ theory yet.$mq$, $mq$medium$mq$),
($mq$Which problem did early anaesthetics, such as chloroform (used by James Simpson from 1847), NOT solve?$mq$, $mq$["The risk of infection after surgery","Pain during surgery","Patients struggling on the table","Surgeons having to work too quickly"]$mq$, 0, $mq$Anaesthetics removed pain and let surgeons work more slowly, but infection (sepsis) remained deadly until antiseptics and aseptic methods arrived.$mq$, $mq$medium$mq$),
($mq$Why did the government pass the Public Health Act of 1875, unlike the weak 1848 Act?$mq$, $mq$["It banned all vaccinations","It abolished cities","It made doctors pay for patients","The 1875 Act forced local councils to provide clean water, sewers and waste removal"]$mq$, 3, $mq$The 1848 Act was voluntary in many areas. The 1875 Act required local authorities to act on sewers, water supply and refuse. Germ theory and cholera outbreaks had strengthened the case for action.$mq$, $mq$medium$mq$),
($mq$Which statement about Salvarsan 606 (1909) is correct?$mq$, $mq$["It was the first antibiotic made from mould","It was a vaccine for smallpox","Paul Ehrlich's team found a chemical that killed the bacterium causing syphilis","It was an anaesthetic"]$mq$, 2, $mq$Ehrlich called it a 'magic bullet' because it targeted a specific microbe. Penicillin, an antibiotic from mould, was found by Fleming in 1928.$mq$, $mq$medium$mq$),
($mq$A source claims the 'Great Stink' of 1858 forced action in London. What was the main result?$mq$, $mq$["Vaccination became compulsory","Joseph Bazalgette was given the job of building a large new sewer system","Hospitals were closed","Carbolic acid was banned"]$mq$, 1, $mq$The smell from the polluted Thames pressured Parliament. Bazalgette's sewers carried waste away from central London and reduced cholera.$mq$, $mq$medium$mq$),
($mq$Edwin Chadwick's 1842 report on the living conditions of the poor argued that disease could be reduced by which measure?$mq$, $mq$["Providing clean water, drains and sewers","Introducing compulsory vaccination against all diseases","Using carbolic acid in homes","Stopping people moving to cities"]$mq$, 0, $mq$Chadwick, who believed in miasma, still pushed for better drainage and water supply, which did help cut disease. His report led to the Public Health Act of 1848.$mq$, $mq$medium$mq$),
($mq$Which statement best explains why germ theory was not accepted at once by all doctors?$mq$, $mq$["Pasteur's work was never published","Microscopes had not been invented","The Church banned all microbiology","Many doctors held to miasma and humours, and the theory did not itself show how to cure disease"]$mq$, 3, $mq$Old beliefs were strong and doctors resisted change. Germ theory (1861) explained causes, but cures and vaccines took time to develop.$mq$, $mq$hard$mq$),
($mq$Which comparison of Jenner and Pasteur is most accurate?$mq$, $mq$["Jenner proved germ theory and Pasteur did not use vaccines","Both discovered penicillin","Jenner found a vaccine without knowing why it worked, but Pasteur's germ theory gave a scientific explanation that led to new vaccines","Pasteur worked before Jenner"]$mq$, 2, $mq$Jenner's smallpox vaccine (1796) came before germ theory. Pasteur went on to develop vaccines for chicken cholera, anthrax and rabies (1885) using his understanding of microbes.$mq$, $mq$hard$mq$),
($mq$Evaluate the claim 'Government action was more important than individual scientists in reducing disease in 19th-century Britain.' Which line of argument is strongest?$mq$, $mq$["Only scientists mattered because laws did nothing","Both mattered: scientists showed the causes, but laws and sewer building made improvements reach the whole population","Only the Church mattered","Neither mattered as disease fell by chance"]$mq$, 1, $mq$Strong answers weigh factors together. Discoveries by Snow, Pasteur and Koch gave understanding, and Acts such as 1875 forced towns to build sewers and supply clean water.$mq$, $mq$hard$mq$),
($mq$By the early 1900s deaths from many infectious diseases were falling in Britain. Which combination of factors explains this best?$mq$, $mq$["Cleaner water and sewers, better food, and new vaccines and antiseptics","Only penicillin","Only the NHS","Only bloodletting"]$mq$, 0, $mq$Penicillin came in the 1940s and the NHS in 1948, so they cannot explain earlier falls. Public health, nutrition and early vaccines and hygiene did.$mq$, $mq$hard$mq$),
($mq$Penicillin was discovered by Fleming in 1928 but was not used widely until the 1940s. What explains the delay?$mq$, $mq$["Fleming refused to publish","The Church opposed antibiotics","Penicillin had been banned by Parliament","Florey and Chain's team had to find a way to purify and mass-produce it, which was driven by the need during the Second World War"]$mq$, 3, $mq$Fleming noticed that mould killed bacteria but could not produce enough. Florey and Chain's team developed it in 1940-41 and large-scale production followed, helping the wounded by D-Day in 1944.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Germ Theory, Vaccines and Public Health$mq$ and p.name = $mq$Health and Medicine Through Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Edward Jenner (1796)$mq$, $mq$Used cowpox to protect against smallpox, creating the first vaccine. He did not know why it worked.$mq$),
($mq$Germ theory$mq$, $mq$The idea that microbes cause disease. Pasteur's work in the early 1860s gave it scientific support.$mq$),
($mq$Robert Koch$mq$, $mq$German scientist who identified bacteria for anthrax (1876), TB (1882) and cholera (1883), using stains and solid growth media.$mq$),
($mq$Joseph Lister (1865)$mq$, $mq$Used carbolic acid as an antiseptic on wounds, instruments and in the air, reducing deaths from infection after surgery.$mq$),
($mq$Anaesthetic vs antiseptic$mq$, $mq$Anaesthetics (ether, chloroform) stop pain. Antiseptics (carbolic acid) kill germs. Both were needed to make surgery safer.$mq$),
($mq$John Snow (1854)$mq$, $mq$Mapped cholera cases in Soho and traced them to the Broad Street pump, supporting the water-borne theory of cholera.$mq$),
($mq$Public Health Act 1875$mq$, $mq$Forced local authorities to provide clean water, sewers and waste removal. Much stronger than the largely voluntary 1848 Act.$mq$),
($mq$Magic bullet$mq$, $mq$Paul Ehrlich's idea of a chemical that targets a specific microbe. His team produced Salvarsan 606 against syphilis in 1909.$mq$),
($mq$Penicillin$mq$, $mq$Discovered by Fleming in 1928, developed by Florey and Chain's team in 1940-41 and mass-produced during the Second World War.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Germ Theory, Vaccines and Public Health$mq$ and p.name = $mq$Health and Medicine Through Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$In the 1800s medicine changed faster than in all earlier centuries. The key change was a new explanation of disease, **germ theory**, which led to vaccines, better surgery and government action on public health.

## Early steps
In 1796 Edward Jenner noticed that milkmaids who caught cowpox seemed not to get smallpox. He tested the idea on a boy, James Phipps, and showed the boy was protected. This was the first **vaccine**. Vaccination became compulsory in Britain in 1853, though some people objected on grounds of liberty. Jenner did not know why it worked.

In the 1840s two advances helped surgery. Anaesthetics such as ether and chloroform (James Simpson, 1847) removed pain. Yet more patients died after surgery because surgeons worked more and infection spread, so death rates actually rose in some hospitals. Ignaz Semmelweis showed in Vienna in 1847 that doctors washing their hands in chlorine reduced deaths from puerperal fever, but most doctors ignored him.

## Germ theory
Louis Pasteur, a French scientist, showed in the early 1860s that microbes in the air cause decay, and this led to the idea that microbes cause disease. Robert Koch, a German doctor, identified the specific bacteria for anthrax (1876), TB (1882) and cholera (1883). Koch used stains and solid growth jellies to grow pure samples. Pasteur then developed vaccines for chicken cholera, anthrax and rabies (1885).

Joseph Lister used carbolic acid in 1865 to clean wounds and instruments, and survival rates after surgery rose. Later, surgeons moved from antiseptic methods to aseptic surgery, where everything is sterilised from the start. Paul Ehrlich created Salvarsan 606 in 1909, a chemical aimed at the bacterium that causes syphilis. Alexander Fleming noticed in 1928 that mould killed bacteria, and Howard Florey and Ernst Chain's team developed penicillin into a usable drug in 1940-41.

## Public health
Cholera outbreaks showed the need for clean water. John Snow in 1854 traced a Soho outbreak to the Broad Street pump. The Great Stink of 1858 led to Bazalgette's sewer system in London. The Public Health Act of 1848 created a Board of Health but was mostly voluntary. The Public Health Act of 1875 forced local councils to provide clean water, drains and waste removal. Governments acted because disease affected the economy and because voters now had more influence.

## Common mistakes
- Jenner's vaccine came before germ theory. Do not say he used germ theory.
- Lister's carbolic acid is antiseptic; anaesthetics only stop pain.
- Penicillin was discovered in 1928 but used widely in the 1940s.

## How this is examined
Typical tasks give a short extract about one scientist or law and ask you to explain its importance, or to assess how far one factor (science, war, government, individuals) caused change. Command terms include explain, analyse and evaluate. Build answers with a point, evidence (names, dates) and a link to the question.

Exam tip: To judge importance, ask what changed, how many people it affected and how long it lasted, then reach a clear conclusion.$mq$ from st;

-- Health and Medicine Through Time > Modern Medicine and Global Health Challenges
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Health and Medicine Through Time$mq$, 5, 1 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Modern Medicine and Global Health Challenges$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Health and Medicine Through Time$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Modern Medicine and Global Health Challenges$mq$ and p.name = $mq$Health and Medicine Through Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In which year was the National Health Service (NHS) founded in Britain?$mq$, $mq$["1948","1918","1965","1990"]$mq$, 0, $mq$The NHS began on 5 July 1948, under Aneurin Bevan, giving free healthcare for all.$mq$, $mq$easy$mq$),
($mq$Which disease was declared eradicated worldwide by the World Health Organization in 1980?$mq$, $mq$["Polio","Malaria","Tuberculosis","Smallpox"]$mq$, 3, $mq$A global vaccination campaign ended smallpox. Polio is close to eradication but still occurs in a few countries.$mq$, $mq$easy$mq$),
($mq$What did Watson and Crick (with data from Rosalind Franklin and Maurice Wilkins) help to discover in 1953?$mq$, $mq$["The first antibiotic","The cause of cholera","The double-helix structure of DNA","The first vaccine"]$mq$, 2, $mq$Understanding DNA's structure opened the way to genetics and later to genetic medicine.$mq$, $mq$easy$mq$),
($mq$Which type of drug is becoming less effective because bacteria are evolving resistance?$mq$, $mq$["Anaesthetics","Antibiotics","Vaccines against viruses only","Painkillers"]$mq$, 1, $mq$Over-use and misuse of antibiotics let resistant bacteria survive and multiply, creating problems like MRSA.$mq$, $mq$easy$mq$),
($mq$What does the abbreviation WHO stand for?$mq$, $mq$["World Health Organization","World Hospital Office","Western Health Organisation","World Humanitarian Order"]$mq$, 0, $mq$The WHO is a United Nations agency set up in 1948 to coordinate international health.$mq$, $mq$easy$mq$),
($mq$Why is a lifestyle disease such as heart disease now a bigger cause of death in wealthy countries than infectious disease?$mq$, $mq$["Vaccines cause heart disease","Antibiotics create heart problems","Doctors stopped treating it","People live longer and infections are better controlled, while diet, smoking and inactivity increase other risks"]$mq$, 3, $mq$As infectious diseases fell, long-term (non-communicable) diseases became more significant. Doll and Hill's research in the 1950s linked smoking with lung cancer.$mq$, $mq$medium$mq$),
($mq$Which development in 1967 marked a key advance in surgery?$mq$, $mq$["The first use of anaesthetics","The first vaccine","Christiaan Barnard performed the first human heart transplant in South Africa","The invention of the X-ray"]$mq$, 2, $mq$Barnard's operation in Cape Town showed organ transplants were possible. Many early patients died from rejection, which improved with new drugs.$mq$, $mq$medium$mq$),
($mq$Use the data: A vaccination programme raised coverage in a country from 40% to 85% over ten years, and cases of measles fell from 20,000 to 1,500 a year. Which conclusion is best supported?$mq$, $mq$["Vaccines caused measles to rise","Higher vaccine coverage is linked to a large fall in measles cases, though other factors might also play a part","The data prove nothing at all","Measles cases fell by exactly 85%"]$mq$, 1, $mq$A fall from 20,000 to 1,500 is a decrease of 92.5%, so the 'exactly 85%' option is wrong. Data shows a strong link but a careful answer notes other possible influences.$mq$, $mq$medium$mq$),
($mq$Which is a reason why health problems in poorer countries are often harder to solve?$mq$, $mq$["Lack of clean water, funding, trained staff and healthcare facilities","Their people cannot be vaccinated","Diseases there are not real","They have too many doctors"]$mq$, 0, $mq$Poverty, conflict and weak health systems make prevention and treatment harder. Inequality also affects access to medicines.$mq$, $mq$medium$mq$),
($mq$HIV/AIDS was first recognised in the early 1980s. What changed for patients from the mid-1990s?$mq$, $mq$["A vaccine wiped out the virus","Antibiotics cured it","It was declared eradicated","Antiretroviral therapy let many people with HIV live long lives"]$mq$, 3, $mq$Combination antiretroviral drugs reduce the virus in the body. There is still no cure and no widely available vaccine.$mq$, $mq$medium$mq$),
($mq$Which statement about the COVID-19 pandemic is accurate?$mq$, $mq$["Vaccines were authorised in 1918","It was caused by bacteria","The WHO declared a pandemic in March 2020 and vaccines were authorised in under a year","It was the first global disease in history"]$mq$, 2, $mq$The virus SARS-CoV-2 spread worldwide in early 2020. Vaccines were approved from December 2020, an unusually fast process built on earlier research.$mq$, $mq$medium$mq$),
($mq$Why might a global health organisation encourage vaccination programmes rather than only treatment?$mq$, $mq$["Treatments never work","Prevention protects many people at lower cost and can stop outbreaks spreading","Vaccination reduces population","Vaccines have no side effects at all"]$mq$, 1, $mq$Vaccines create immunity before illness and reduce spread in communities. Like all medicines they can have rare side effects, so the claim in the last option is false.$mq$, $mq$medium$mq$),
($mq$Which is an example of a medical technology that has improved diagnosis?$mq$, $mq$["MRI and CT scanners","Carbolic spray","Bloodletting bowls","The Broad Street pump"]$mq$, 0, $mq$Scanners let doctors see inside the body without surgery. The others belong to earlier eras.$mq$, $mq$medium$mq$),
($mq$Evaluate: 'Science and technology are the main reason life expectancy has risen since 1900.' Which response is the strongest?$mq$, $mq$["Only science mattered","Only luck mattered","Life expectancy has not risen","Science mattered a great deal, but sanitation, nutrition, education and government action also contributed"]$mq$, 3, $mq$Strong answers weigh several factors. Improved sanitation, better food and healthcare systems worked alongside vaccines and drugs.$mq$, $mq$hard$mq$),
($mq$Which explains why polio is not yet fully eradicated although effective vaccines (Salk 1955, Sabin early 1960s) exist?$mq$, $mq$["The vaccine does not work","Polio is caused by bacteria","Conflict, poor health systems and mistrust in some areas make reaching every child difficult","No country has tried to vaccinate"]$mq$, 2, $mq$Vaccines work, but eradication needs near-total coverage. Wild polio remains in places such as Afghanistan and Pakistan, partly due to access and security problems.$mq$, $mq$hard$mq$),
($mq$Which source of evidence would be most useful for judging whether the NHS improved access to healthcare after 1948?$mq$, $mq$["A novel set in the 1700s","Records of patient numbers and waiting times before and after 1948","A list of Roman hospitals","A modern advert for vitamins"]$mq$, 1, $mq$Good evidence is relevant, from the right period and reliable. Before 1948 many people could not afford a doctor, and statistics on use of services help show change.$mq$, $mq$hard$mq$),
($mq$Antibiotic resistance is described as a global threat. Which action would best slow it?$mq$, $mq$["Using antibiotics only when needed and completing prescribed courses","Taking antibiotics for every cold","Stopping research into new drugs","Giving antibiotics to healthy people regularly"]$mq$, 0, $mq$Colds are caused by viruses, which antibiotics do not treat. Careless use gives resistant bacteria an advantage.$mq$, $mq$hard$mq$),
($mq$Compare the impact of the 1918-19 influenza pandemic with COVID-19 on medical response. Which statement is most accurate?$mq$, $mq$["Both pandemics were stopped by the same vaccine","Medical knowledge was identical","Neither affected any country outside Europe","In 2020 scientists could sequence the virus and develop vaccines quickly, but in 1918 there were no vaccines or antibiotics for the illness"]$mq$, 3, $mq$Modern genetics, global communication and mass manufacturing allowed a fast response in 2020. Even so, inequality in vaccine access was a major problem, as the COVAX scheme tried to address.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Modern Medicine and Global Health Challenges$mq$ and p.name = $mq$Health and Medicine Through Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$NHS$mq$, $mq$National Health Service, founded in 1948 under Aneurin Bevan, providing healthcare free at the point of use.$mq$),
($mq$WHO$mq$, $mq$World Health Organization, a UN agency founded in 1948 to coordinate international health work such as the smallpox campaign.$mq$),
($mq$Smallpox eradication$mq$, $mq$Declared eradicated by the WHO in 1980 after a worldwide vaccination campaign. The only human disease eradicated so far.$mq$),
($mq$DNA (1953)$mq$, $mq$Watson and Crick, using data from Franklin and Wilkins, described its double-helix structure, opening the way for genetic medicine.$mq$),
($mq$Antibiotic resistance$mq$, $mq$When bacteria evolve to survive antibiotics, due to overuse and misuse. Creates dangerous infections such as MRSA.$mq$),
($mq$Lifestyle diseases$mq$, $mq$Long-term conditions such as heart disease, type 2 diabetes and lung cancer, linked to factors such as smoking, diet and inactivity.$mq$),
($mq$HIV/AIDS$mq$, $mq$Recognised in the early 1980s. Antiretroviral therapy from the mid-1990s lets many people live long lives, but there is no cure.$mq$),
($mq$COVID-19 response$mq$, $mq$WHO declared a pandemic in March 2020. Vaccines were authorised from December 2020. Uneven access led to the COVAX scheme.$mq$),
($mq$Health inequality$mq$, $mq$Differences in health between and within countries caused by poverty, weak health systems, conflict and lack of clean water.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Modern Medicine and Global Health Challenges$mq$ and p.name = $mq$Health and Medicine Through Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$In the twentieth and twenty-first centuries, medicine has been transformed by science, technology, government action and international cooperation. Yet new challenges have appeared, and the benefits have not reached everyone equally.

## Key developments
The **NHS** was founded in 1948 by the Labour government, with Aneurin Bevan as Health Minister, building on the 1942 Beveridge Report. It offered healthcare free at the point of use. The **World Health Organization** (WHO) was also set up in 1948 to coordinate international health.

Vaccines achieved huge success. Jonas Salk's injected polio vaccine appeared in 1955 and Albert Sabin's oral vaccine in the early 1960s. A global campaign, led by the WHO, eradicated **smallpox**, declared in 1980. The Global Polio Eradication Initiative began in 1988, and wild polio has been reduced to a very small number of countries.

Science brought new knowledge. Watson and Crick, using evidence from Rosalind Franklin and Maurice Wilkins, described the structure of DNA in 1953. The Human Genome Project finished mapping human genes in 2003. Medical technology improved too: X-rays, scanners (CT and MRI), keyhole surgery, dialysis and organ transplants. Christiaan Barnard carried out the first human heart transplant in 1967 in South Africa, and Louise Brown, the first baby born by IVF, was born in Britain in 1978.

## Modern challenges
- **Lifestyle diseases**: As people live longer, cancers, heart disease and diabetes are leading killers. Research by Doll and Hill in the 1950s linked smoking with lung cancer, and governments have since used education, taxes and laws to change behaviour.
- **Antibiotic resistance**: Overuse lets bacteria evolve resistance, producing bugs like MRSA.
- **New diseases**: HIV/AIDS appeared in the early 1980s. Antiretroviral drugs since the mid-1990s allow many people to live long lives, but there is no cure. Ebola struck West Africa in 2014-16. The COVID-19 pandemic began in 2020 and the WHO declared it a pandemic in March; vaccines were authorised from December 2020.
- **Inequality**: Poorer countries often lack clean water, clinics, trained staff and money. Global schemes, such as the Millennium Development Goals (2000) and the Sustainable Development Goals (2015), aim to improve this. During COVID-19 the COVAX scheme tried to share vaccines more fairly.

## Evaluating change
When judging why health improved, think about several factors: science and technology, war (which drove surgery and penicillin production), government action, education, individuals and international cooperation. A strong answer compares them and explains which was most important and why.

## How this is examined
Expect a short stimulus, such as statistics on vaccine coverage or a description of a health campaign, followed by questions asking you to interpret the data, explain causes and evaluate impact. State what the data shows, support it with knowledge, and mention limitations such as the source or missing information.

Exam tip: Quote a specific number or date from the stimulus and then explain what it shows, instead of just saying that things 'got better'.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('history')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;