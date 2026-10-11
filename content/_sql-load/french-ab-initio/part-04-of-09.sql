-- Part 4 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- School and Work > School Subjects and Objects
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$School and Work$mq$, 5, 4 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$School Subjects and Objects$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$School and Work$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$School Subjects and Objects$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does the French word “un cahier” mean?$mq$, $mq$["an exercise book","a pencil case","a ruler","a rubber"]$mq$, 0, $mq$Un cahier is an exercise book. A pencil case is une trousse, a ruler is une règle and a rubber is une gomme.$mq$, $mq$easy$mq$),
($mq$Which French word means “history”?$mq$, $mq$["la géographie","l'anglais","la musique","l'histoire"]$mq$, 3, $mq$L'histoire means history. La géographie is geography, l'anglais is English and la musique is music.$mq$, $mq$easy$mq$),
($mq$Which is the correct way to say “a pencil case”?$mq$, $mq$["un trousse","des trousse","une trousse","le trousse"]$mq$, 2, $mq$Trousse is feminine, so it takes une. Un trousse is a gender mistake.$mq$, $mq$easy$mq$),
($mq$Mina writes: “Ma matière préférée est l'informatique.” What is her favourite subject?$mq$, $mq$["music","ICT / computing","art","PE"]$mq$, 1, $mq$L'informatique means ICT or computing. Matière préférée means favourite subject.$mq$, $mq$easy$mq$),
($mq$Which sentence means “I like music”?$mq$, $mq$["J'aime la musique.","Je déteste la musique.","J'aime le dessin.","J'aime le sport."]$mq$, 0, $mq$J'aime means I like. Je déteste means I hate, and dessin and sport are different subjects.$mq$, $mq$easy$mq$),
($mq$Lina's timetable: “lundi: 8h30 maths, 9h30 français, 10h30 récréation, 11h00 anglais.” What does Lina have straight after maths on Monday?$mq$, $mq$["break time","English","nothing","French"]$mq$, 3, $mq$After maths at 8h30 comes français at 9h30. Récréation is at 10h30 and English follows at 11h00.$mq$, $mq$medium$mq$),
($mq$“Pourquoi tu aimes les sciences ? — Parce que c'est intéressant.” What reason is given?$mq$, $mq$["Science is boring.","Science is difficult.","Science is interesting.","Science is easy."]$mq$, 2, $mq$Intéressant means interesting. Ennuyeux is boring, difficile is difficult and facile is easy.$mq$, $mq$medium$mq$),
($mq$A note says: “Il faut apporter une calculatrice, une règle et un cahier pour le cours de maths.” Which item is NOT mentioned?$mq$, $mq$["a calculator","a pencil","a ruler","an exercise book"]$mq$, 1, $mq$The note lists calculatrice, règle and cahier. A pencil (un crayon) is not mentioned.$mq$, $mq$medium$mq$),
($mq$Which sentence is correct?$mq$, $mq$["Je déteste les maths.","Je déteste le maths.","Je déteste la maths.","Je déteste l'maths."]$mq$, 0, $mq$Les maths is plural in French, so it takes les. Le, la and l' are all wrong.$mq$, $mq$medium$mq$),
($mq$Message from Léa: “Salut Tom ! Demain, j'ai besoin d'un stylo, d'un classeur et de ciseaux. Tu as de la colle ?” What does Léa ask Tom?$mq$, $mq$["whether he has scissors","whether he has a pen","whether he has a folder","whether he has any glue"]$mq$, 3, $mq$Tu as de la colle ? means Do you have any glue? The other items are things Léa says she needs.$mq$, $mq$medium$mq$),
($mq$Which sentence says “My favourite subject is geography”?$mq$, $mq$["Mon matière préférée est la géographie.","Ma matière préféré est la géographie.","Ma matière préférée est la géographie.","Mon matière préféré est le géographie."]$mq$, 2, $mq$Matière is feminine, so we need ma and préférée. Géographie is also feminine, so la.$mq$, $mq$medium$mq$),
($mq$“Je n'aime pas la physique parce que c'est trop difficile.” What does the student think of physics?$mq$, $mq$["It is too boring.","It is too difficult.","It is very useful.","It is very easy."]$mq$, 1, $mq$Trop difficile means too difficult. Je n'aime pas shows the student dislikes it.$mq$, $mq$medium$mq$),
($mq$A school sign says: “Cantine: ouverte de 12h à 13h30.” At what time does the canteen close?$mq$, $mq$["1.30 pm","12.00 pm","1.00 pm","12.30 pm"]$mq$, 0, $mq$13h30 is 1.30 pm on the 24-hour clock. Ouverte de 12h à 13h30 means open from 12.00 to 13.30.$mq$, $mq$medium$mq$),
($mq$Listening transcript: “Alors, mardi, j'ai anglais et dessin, mais je n'ai pas sport. Le sport, c'est le jeudi, et je déteste ça !” Which statement is true?$mq$, $mq$["Sport is on Tuesday and the speaker hates it.","Sport is on Thursday and the speaker loves it.","The speaker has art and sport on Tuesday.","Sport is on Thursday and the speaker hates it."]$mq$, 3, $mq$Je n'ai pas sport on Tuesday, and le sport, c'est le jeudi. Je déteste ça means I hate it.$mq$, $mq$hard$mq$),
($mq$Which sentence is completely correct?$mq$, $mq$["J'ai deux cahier et une règle.","J'ai deux cahiers et un règle.","J'ai deux cahiers et une règle.","J'ai deux cahiers et une règles."]$mq$, 2, $mq$Cahier takes -s after deux, and règle is feminine singular so une règle.$mq$, $mq$hard$mq$),
($mq$Email: “Mon emploi du temps est difficile ! Je n'ai pas de pause le mercredi, mais j'adore l'informatique, donc c'est bien. Le vendredi, j'ai EPS et je déteste ça.” Which statement matches the email?$mq$, $mq$["The writer likes PE but dislikes ICT.","The writer likes ICT but dislikes PE.","The writer has a long break on Wednesday.","The writer dislikes ICT and PE."]$mq$, 1, $mq$J'adore l'informatique shows a positive view of ICT, and je déteste ça refers to EPS on Fridays. Wednesday has no break.$mq$, $mq$hard$mq$),
($mq$How do you say “I do not have a ruler”?$mq$, $mq$["Je n'ai pas de règle.","Je n'ai pas une règle.","Je ne pas ai de règle.","Je n'ai pas règle de."]$mq$, 0, $mq$After a negative, une becomes de: pas de règle. The ne goes before the verb and pas after it.$mq$, $mq$hard$mq$),
($mq$“Pour les arts plastiques, il faut du papier, des crayons de couleur et de la colle. J'ai déjà du papier et des crayons de couleur.” What does the writer still need?$mq$, $mq$["paper","coloured pencils","scissors","glue"]$mq$, 3, $mq$The writer already has paper and coloured pencils, so what remains from the list is la colle (glue).$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$School Subjects and Objects$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$les maths$mq$, $mq$maths (always plural in French: les maths)$mq$),
($mq$une règle$mq$, $mq$a ruler (feminine)$mq$),
($mq$Ma matière préférée est...$mq$, $mq$My favourite subject is... (matière is feminine: ma ... préférée)$mq$),
($mq$Je déteste l'EPS.$mq$, $mq$I hate PE.$mq$),
($mq$parce que c'est ennuyeux$mq$, $mq$because it is boring$mq$),
($mq$Il faut apporter...$mq$, $mq$You must bring...$mq$),
($mq$J'ai besoin d'un stylo.$mq$, $mq$I need a pen (besoin de + un becomes d'un).$mq$),
($mq$Je n'ai pas de calculatrice.$mq$, $mq$I do not have a calculator (pas de after a negative).$mq$),
($mq$l'emploi du temps$mq$, $mq$the timetable$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$School Subjects and Objects$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What you need to know
In the eAssessment you will meet school vocabulary in timetables, notices, messages and short opinions. This sub-topic covers school subjects, classroom objects and how to give an opinion about them.

## School subjects
- les maths (maths; always plural: les maths)
- le français (French)
- l'anglais (English)
- l'histoire (history, feminine)
- la géographie (geography)
- les sciences (science)
- l'informatique (ICT, computing, feminine)
- la musique (music)
- le dessin (drawing) and les arts plastiques (art)
- l'EPS or le sport (PE)

Notice that most subjects take le, la, l' or les. Use l' before a vowel or a silent h (l'anglais, l'histoire). Learn each word with its article so you remember the gender.

## Objects in your bag
- un stylo (a pen), un crayon (a pencil), une gomme (a rubber)
- un cahier (an exercise book), un livre (a book), un classeur (a folder)
- une règle (a ruler), une trousse (a pencil case), une calculatrice (a calculator)
- un sac à dos (a rucksack), un ordinateur (a computer)
- des ciseaux (scissors), de la colle (glue)

Plural nouns usually add -s: deux cahiers, trois stylos. Ciseaux is always plural.

## Giving opinions
- J'aime les maths. (I like maths.)
- J'adore la musique. (I love music.)
- Je n'aime pas la physique. (I do not like physics.)
- Je déteste l'EPS. (I hate PE.)
- Ma matière préférée est la géographie. (My favourite subject is geography.)

Add a reason with parce que (because): Je n'aime pas les sciences parce que c'est difficile. Useful adjectives are intéressant (interesting), facile (easy), difficile (difficult), ennuyeux (boring), utile (useful) and amusant (fun). After c'est, the adjective stays in its basic masculine form.

Careful with agreement: matière is feminine, so we say ma matière préférée, never mon matière préféré.

## Timetables and school life
Une journée à l'école is written as an emploi du temps (timetable). You will read lines such as: lundi: 8h30 maths, 9h30 français, 10h30 récréation. Remember la cantine (canteen), la cour (playground), le prof (teacher), le collège (secondary school) and le cours (lesson). Le lundi means every Monday, while lundi alone means this Monday.

## Saying what you need
- Il faut apporter une calculatrice. (You must bring a calculator.)
- J'ai besoin d'un stylo. (I need a pen.) After besoin de, un becomes d'un/d'une.
- Tu as de la colle ? (Do you have any glue?)
- Je n'ai pas de règle. (I do not have a ruler.) After a negative, un/une/du/de la become de or d'.

## How this is examined
Typical tasks give a short timetable, a school notice or a message between two friends. You are asked which subject comes after another, which item is missing, what opinion is given and why. In listening, a transcript gives days and opinions and you match them. In writing, you describe your timetable and justify an opinion with parce que.

## Common mistakes
- Using the wrong gender: une règle, not un règle.
- Writing la maths: say les maths.
- Forgetting accents: français, géographie, règle.
- Confusing j'aime (I like) with je déteste (I hate).

Exam tip: Read the whole text first, underline days, times and opinion words (aime, déteste, parce que), then match them to the question before choosing an answer.$mq$ from st;

-- School and Work > Jobs and Workplaces
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$School and Work$mq$, 5, 4 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Jobs and Workplaces$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$School and Work$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Jobs and Workplaces$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does the French word “un médecin” mean?$mq$, $mq$["a doctor","a teacher","a nurse","a baker"]$mq$, 0, $mq$Un médecin is a doctor. A teacher is un professeur, a nurse is un infirmier or une infirmière and a baker is un boulanger.$mq$, $mq$easy$mq$),
($mq$Where does a baker (un boulanger) work?$mq$, $mq$["dans un hôpital","dans un garage","dans une école","dans une boulangerie"]$mq$, 3, $mq$A boulanger works in une boulangerie. The other places match other jobs.$mq$, $mq$easy$mq$),
($mq$Which sentence means “She is a nurse”?$mq$, $mq$["Elle est infirmier.","Il est infirmière.","Elle est infirmière.","Elle a infirmière."]$mq$, 2, $mq$A woman is infirmière, with the feminine ending. Elle est means she is, while elle a means she has.$mq$, $mq$easy$mq$),
($mq$Hugo writes: “Mon père est professeur.” Who is the teacher?$mq$, $mq$["Hugo's mother","Hugo's father","Hugo's brother","Hugo's sister"]$mq$, 1, $mq$Mon père means my father. Mère is mother, frère is brother and sœur is sister.$mq$, $mq$easy$mq$),
($mq$What does “un hôpital” mean?$mq$, $mq$["a hospital","a hotel","an office","a farm"]$mq$, 0, $mq$Un hôpital is a hospital. A hotel is un hôtel, an office is un bureau and a farm is une ferme.$mq$, $mq$easy$mq$),
($mq$Message: “Ma mère est avocate. Elle travaille dans un bureau au centre-ville. Mon père est cuisinier et il travaille dans un restaurant.” Where does the father work?$mq$, $mq$["in an office","in a hospital","in a shop","in a restaurant"]$mq$, 3, $mq$The father is cuisinier, and il travaille dans un restaurant. The office belongs to the mother.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says “My brother is a mechanic”?$mq$, $mq$["Ma frère est mécanicien.","Mon frère est mécanicienne.","Mon frère est mécanicien.","Mon frère a mécanicien."]$mq$, 2, $mq$Frère is masculine, so mon and the masculine mécanicien. Mécanicienne is for a woman.$mq$, $mq$medium$mq$),
($mq$Advert: “Recherchons serveur ou serveuse pour le samedi et le dimanche, de 10h à 16h. Restaurant Le Soleil.” When is the work?$mq$, $mq$["Monday to Friday, 10.00 to 16.00","Saturday and Sunday, 10.00 to 16.00","Saturday and Sunday, 16.00 to 22.00","Sunday only, 10.00 to 16.00"]$mq$, 1, $mq$Pour le samedi et le dimanche means Saturday and Sunday, and de 10h à 16h gives the hours.$mq$, $mq$medium$mq$),
($mq$What does the question “Que fait ta mère ?” ask?$mq$, $mq$["What job your mother does","Where your mother lives","How old your mother is","What your mother looks like"]$mq$, 0, $mq$Que fait ...? is the standard way to ask what someone does for a living.$mq$, $mq$medium$mq$),
($mq$Which sentence is correct?$mq$, $mq$["Elle travaille dans un usine.","Elle travaillent dans une usine.","Elle travailles dans une usine.","Elle travaille dans une usine."]$mq$, 3, $mq$Usine is feminine, so une. With elle the verb is travaille, with no extra -s or -nt.$mq$, $mq$medium$mq$),
($mq$Marie sells clothes in a shop. Which sentence describes her?$mq$, $mq$["Marie est vendeur.","Marie est vendeure.","Marie est vendeuse.","Marie est un vendeuse."]$mq$, 2, $mq$Vendeur becomes vendeuse for a woman, and no article is used after être with a job alone.$mq$, $mq$medium$mq$),
($mq$Karim writes: “Plus tard, je voudrais être ingénieur parce que j'aime les maths et j'aime construire des choses.” Why does Karim want this job?$mq$, $mq$["He loves animals.","He likes maths and building things.","He likes cooking.","He wants to help sick people."]$mq$, 1, $mq$Parce que j'aime les maths et j'aime construire des choses gives the reason.$mq$, $mq$medium$mq$),
($mq$Listening transcript: “Mon oncle est policier. Il travaille au commissariat, mais le week-end il aide à la ferme de ma grand-mère.” Where does he help at weekends?$mq$, $mq$["on his grandmother's farm","at the police station","at a restaurant","at the speaker's school"]$mq$, 0, $mq$Le week-end il aide à la ferme de ma grand-mère: at weekends he helps on the speaker's grandmother's farm.$mq$, $mq$medium$mq$),
($mq$Which sentence is completely correct?$mq$, $mq$["Mon tante est actrice et elle travaille au théâtre.","Ma tante est acteur et il travaille au théâtre.","Ma tante est actrice et il travaille au théâtre.","Ma tante est actrice et elle travaille au théâtre."]$mq$, 3, $mq$Tante is feminine, so ma, actrice and elle all agree. Au théâtre is à + le.$mq$, $mq$hard$mq$),
($mq$Advert: “Cherchons coiffeur ou coiffeuse. Pas d'expérience nécessaire. Du mardi au samedi.” Which statement is true?$mq$, $mq$["Experience is essential and the work is Tuesday to Saturday.","Experience is not needed and the work is Monday to Friday.","Experience is not needed and the work is Tuesday to Saturday.","Experience is not needed and the work is on Sundays only."]$mq$, 2, $mq$Pas d'expérience nécessaire means no experience is needed. Du mardi au samedi means Tuesday to Saturday.$mq$, $mq$hard$mq$),
($mq$Which reply best answers the question “Où travaille ton père ?”$mq$, $mq$["Il est ingénieur.","Il travaille dans une usine.","Il a quarante-trois ans.","Il travaille le lundi."]$mq$, 1, $mq$Où asks for a place, so only the factory answers it. Il est ingénieur answers Que fait ton père ?$mq$, $mq$hard$mq$),
($mq$“Je travaille le samedi de 10h à 14h dans un café. Je gagne 9 euros de l'heure.” (Je gagne = I earn.) How much does the writer earn for one Saturday?$mq$, $mq$["36 euros","32 euros","45 euros","90 euros"]$mq$, 0, $mq$From 10h to 14h is 4 hours, and 4 × 9 = 36 euros. 90 would multiply 9 by 10 instead of using the hours worked.$mq$, $mq$hard$mq$),
($mq$Listening transcript: “Moi, je voudrais être vétérinaire parce que j'adore les animaux. Mon frère voudrait être pilote, mais ma sœur n'a pas d'idée.” Which statement is true?$mq$, $mq$["The speaker wants to be a pilot and the sister loves animals.","The brother wants to work with animals and the sister is a pilot.","The speaker and the sister both want to be vets.","The speaker wants to work with animals and the sister is undecided."]$mq$, 3, $mq$The speaker is the vet-to-be, the brother wants to be a pilot and the sister has no idea yet (n'a pas d'idée).$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Jobs and Workplaces$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$un médecin$mq$, $mq$a doctor$mq$),
($mq$une infirmière$mq$, $mq$a (female) nurse; the masculine is un infirmier.$mq$),
($mq$Que fait ton père ?$mq$, $mq$What does your father do (for a job)?$mq$),
($mq$Où travaille ta mère ?$mq$, $mq$Where does your mother work?$mq$),
($mq$Il travaille dans un hôpital.$mq$, $mq$He works in a hospital.$mq$),
($mq$Elle est serveuse.$mq$, $mq$She is a waitress (no un/une after être with a job alone).$mq$),
($mq$Je voudrais être ingénieur.$mq$, $mq$I would like to be an engineer.$mq$),
($mq$du lundi au vendredi$mq$, $mq$from Monday to Friday$mq$),
($mq$une usine$mq$, $mq$a factory (feminine)$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Jobs and Workplaces$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What you need to know
This sub-topic is about naming jobs, saying where people work and talking about future plans. These ideas appear in adverts, family descriptions and short messages.

## Jobs
Many jobs have a masculine and a feminine form.
- un médecin / une femme médecin (doctor)
- un infirmier / une infirmière (nurse)
- un professeur (teacher; the same word for men and women)
- un vendeur / une vendeuse (shop assistant)
- un boulanger / une boulangère (baker)
- un serveur / une serveuse (waiter / waitress)
- un cuisinier / une cuisinière (cook)
- un coiffeur / une coiffeuse (hairdresser)
- un acteur / une actrice (actor)
- un policier / une policière (police officer)
- un mécanicien / une mécanicienne (mechanic)
- un avocat / une avocate (lawyer)
- un ingénieur, un dentiste, un journaliste, un vétérinaire (these stay the same for men and women)

The pattern is usually: -eur becomes -euse, -ier becomes -ière, -ien becomes -ienne, and many jobs just add -e. Words ending in -iste or -e often do not change.

## Workplaces
- un hôpital (hospital), un bureau (office), un magasin (shop)
- une école (school), une usine (factory), une ferme (farm)
- un restaurant, une boulangerie (bakery), un garage
- un commissariat (police station), un théâtre (theatre)

## Saying what someone does
With a job, French usually leaves out the article after être:
- Mon père est professeur. (My father is a teacher.)
- Ma mère est avocate. (My mother is a lawyer.)
- Elle est infirmière. (She is a nurse.)

If you use c'est, you add the article: C'est un médecin. (He is a doctor.)

To ask about a job: Que fait ton père ? (What does your father do?) To ask where: Où travaille ta mère ? (Where does your mother work?)

## Saying where people work
Use travailler (to work): je travaille, tu travailles, il/elle travaille, nous travaillons, vous travaillez, ils/elles travaillent.
- Il travaille dans un hôpital. (He works in a hospital.)
- Elle travaille dans une usine. (She works in a factory.)
- Il travaille au commissariat. (He works at the police station.)
- Elle travaille à la ferme. (She works on the farm.)

Remember à + le = au, à + les = aux. Dans un/une means inside a place.

## Hours and plans
- Il travaille de 9h à 17h. (He works from 9 to 5.)
- Elle travaille du lundi au vendredi. (She works Monday to Friday.)
- Plus tard, je voudrais être ingénieur. (Later, I would like to be an engineer.)
- Je voudrais travailler avec les animaux parce que j'adore les animaux.

## How this is examined
Expect a job advert, an email about a family member's job or a listening transcript. Questions ask which job fits a description, where someone works, which days or hours are given, and which reason is stated. You may need to match a reason (j'aime les maths) to a job (ingénieur). In writing, you might say what your parents do and what you would like to do later.

## Common mistakes
- Putting mon before a feminine noun: ma tante, not mon tante.
- Adding un or une after être when the job is alone.
- Mixing up Que fait... ? (what job) and Où travaille... ? (where).
- Forgetting the feminine form when a woman is described: elle est serveuse.

Exam tip: Find the question word first. Que fait asks for the job, où asks for the place, quand asks for days or times, and pourquoi asks for the reason after parce que.$mq$ from st;

-- School and Work > Classroom Language and Instructions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$School and Work$mq$, 5, 4 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Classroom Language and Instructions$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$School and Work$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Classroom Language and Instructions$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does the instruction “Écoutez !” mean?$mq$, $mq$["Listen!","Read!","Write!","Repeat!"]$mq$, 0, $mq$Écoutez comes from écouter, to listen. Lisez is read, écrivez is write and répétez is repeat.$mq$, $mq$easy$mq$),
($mq$What does “Ouvrez votre cahier” tell you to do?$mq$, $mq$["Close your exercise book.","Lose your exercise book.","Find your exercise book.","Open your exercise book."]$mq$, 3, $mq$Ouvrez means open. Close is fermez.$mq$, $mq$easy$mq$),
($mq$The teacher says “Levez la main.” What should you do?$mq$, $mq$["Sit down.","Be quiet.","Raise your hand.","Stand up."]$mq$, 2, $mq$Lever la main means to raise your hand. Sit down is asseyez-vous and be quiet is taisez-vous.$mq$, $mq$easy$mq$),
($mq$Which sentence is the best way to ask your teacher to say something again?$mq$, $mq$["Je peux aller aux toilettes ?","Pouvez-vous répéter, s'il vous plaît ?","Comment ça s'écrit ?","Je suis en retard."]$mq$, 1, $mq$Pouvez-vous répéter ? asks someone to repeat. Comment ça s'écrit asks about spelling.$mq$, $mq$easy$mq$),
($mq$A teacher says: “Silence, s'il vous plaît !” What does she want?$mq$, $mq$["Everyone to be quiet","Everyone to sit down","Someone to open the door","Everyone to come in"]$mq$, 0, $mq$Silence means be quiet, and s'il vous plaît means please.$mq$, $mq$easy$mq$),
($mq$Board: “Page 24, exercice 3. Lisez le texte, puis répondez aux questions.” What do you do first?$mq$, $mq$["Answer the questions","Listen to a recording","Write a new text","Read the text"]$mq$, 3, $mq$Lisez le texte comes first. Puis means then, so répondez aux questions is the second task.$mq$, $mq$medium$mq$),
($mq$You want to ask how to say “pen” in French. Which question do you use?$mq$, $mq$["Que veut dire « pen » en français ?","Où est le stylo ?","Comment dit-on « pen » en français ?","Comment ça s'écrit ?"]$mq$, 2, $mq$Comment dit-on ... en français ? asks for the French word. Comment ça s'écrit ? asks for the spelling.$mq$, $mq$medium$mq$),
($mq$Sign: “Interdit de manger en classe. Téléphones éteints, s'il vous plaît.” What are the rules?$mq$, $mq$["Eating is allowed and phones are off","No eating in class and phones switched off","No eating but phones can be used","No talking and phones can be used"]$mq$, 1, $mq$Interdit means forbidden, so no eating. Téléphones éteints means phones switched off.$mq$, $mq$medium$mq$),
($mq$The teacher tells the whole class to write the answers. Which sentence does she say?$mq$, $mq$["Écrivez les réponses.","Écris les réponses.","Écrivons les réponses.","Écrivent les réponses."]$mq$, 0, $mq$To a group we use the vous command: écrivez. Écris is for one friend, and écrivons means let us write.$mq$, $mq$medium$mq$),
($mq$A student says: “Madame, je suis désolé, je suis en retard. J'ai oublié mon livre.” What has happened?$mq$, $mq$["He is early and forgot his book.","He is late and lost his pen.","He is ill and has no book.","He is late and forgot his book."]$mq$, 3, $mq$En retard means late and j'ai oublié means I forgot.$mq$, $mq$medium$mq$),
($mq$What does “Ne parlez pas !” mean?$mq$, $mq$["Speak!","Do not write!","Do not talk!","Do not listen!"]$mq$, 2, $mq$Ne ... pas around the verb makes it negative, and parlez comes from parler, to speak or talk.$mq$, $mq$medium$mq$),
($mq$A student asks: “Je peux aller aux toilettes, s'il vous plaît ?” What does the student want?$mq$, $mq$["to go to the canteen","permission to go to the toilets","to borrow a pen","to open the window"]$mq$, 1, $mq$Aux toilettes means to the toilets, and je peux ... ? asks for permission.$mq$, $mq$medium$mq$),
($mq$Homework note: “Pour demain, faites l'exercice 5 et apprenez le vocabulaire.” What must students do?$mq$, $mq$["Do exercise 5 and learn the vocabulary for tomorrow.","Do exercise 5 and learn the vocabulary by next Monday.","Do exercise 5 and write a text tomorrow.","Learn the vocabulary but skip exercise 5."]$mq$, 0, $mq$Pour demain means for tomorrow, faites is do and apprenez is learn.$mq$, $mq$medium$mq$),
($mq$Listening transcript: “Bonjour la classe. Asseyez-vous. Ouvrez vos livres à la page douze. Regardez l'image, puis écoutez le texte deux fois. Ne parlez pas pendant l'écoute.” What should students do after looking at the picture?$mq$, $mq$["Talk with a partner","Read page twelve aloud","Close their books","Listen to the text twice"]$mq$, 3, $mq$Puis écoutez le texte deux fois: after the picture they listen twice. They must not talk during the listening.$mq$, $mq$hard$mq$),
($mq$A teacher says to one pupil: “Ferme la fenêtre, Léo.” Now she gives the same instruction to the whole class. Which sentence is correct?$mq$, $mq$["Fermes la fenêtre.","Fermons la fenêtre.","Fermez la fenêtre.","Fermez la fenêtres."]$mq$, 2, $mq$For a group the command ends in -ez. Fermes is a wrong spelling, and fermons means let us close.$mq$, $mq$hard$mq$),
($mq$Which is the most polite way to ask your teacher to repeat?$mq$, $mq$["Répétez !","Pouvez-vous répéter, s'il vous plaît ?","Tu répètes ça ?","Répète, toi !"]$mq$, 1, $mq$With a teacher use vous and a question with s'il vous plaît. Bare commands and tu forms sound rude.$mq$, $mq$hard$mq$),
($mq$Listening transcript: “Excusez-moi, madame, que veut dire « ciseaux » ? — Ça veut dire scissors. — Merci. Comment ça s'écrit ? — C-I-S-E-A-U-X.” What did the student ask about?$mq$, $mq$["the meaning of the word and how to spell it","the pronunciation of the word and where to find it","the meaning of the word and the page number","the spelling of the word and when the lesson ends"]$mq$, 0, $mq$Que veut dire asks for the meaning and comment ça s'écrit asks for the spelling.$mq$, $mq$hard$mq$),
($mq$Class rules: “1. Levez la main pour parler. 2. Écoutez quand un camarade parle. 3. Ne mangez pas. 4. Travaillez en silence pendant le contrôle.” Léo eats a sandwich and speaks without waiting. Which rules does he break?$mq$, $mq$["2 and 4","1 and 4","2 and 3","3 and 1"]$mq$, 3, $mq$Ne mangez pas is rule 3, and speaking without raising his hand breaks rule 1 (levez la main pour parler).$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Classroom Language and Instructions$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Écoutez !$mq$, $mq$Listen! (vous command to a class; to one friend: Écoute !)$mq$),
($mq$Ouvrez votre livre.$mq$, $mq$Open your book.$mq$),
($mq$Levez la main.$mq$, $mq$Raise your hand.$mq$),
($mq$Je ne comprends pas.$mq$, $mq$I do not understand.$mq$),
($mq$Que veut dire « cahier » ?$mq$, $mq$What does cahier mean?$mq$),
($mq$Comment ça s'écrit ?$mq$, $mq$How is that spelled?$mq$),
($mq$Ne parlez pas !$mq$, $mq$Do not talk! (ne before the verb, pas after)$mq$),
($mq$Pouvez-vous répéter, s'il vous plaît ?$mq$, $mq$Can you repeat, please? (polite, with vous)$mq$),
($mq$Je suis désolé(e), je suis en retard.$mq$, $mq$I am sorry, I am late.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Classroom Language and Instructions$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What you need to know
In a French class you hear and read short instructions all the time. For the eAssessment you must understand what you are told to do, and be able to ask for help politely.

## Teacher instructions (vous form)
A teacher speaking to the class uses the vous form of the imperative. For -er verbs, take the vous form of the verb and drop the word vous: vous écoutez becomes Écoutez !
- Écoutez ! (Listen!)
- Regardez le tableau. (Look at the board.)
- Ouvrez votre livre à la page 12. (Open your book at page 12.)
- Fermez votre cahier. (Close your exercise book.)
- Lisez le texte. (Read the text.)
- Écrivez les réponses. (Write the answers.)
- Répétez, s'il vous plaît. (Repeat, please.)
- Répondez aux questions. (Answer the questions.)
- Levez la main. (Raise your hand.)
- Asseyez-vous. (Sit down.)
- Taisez-vous. / Silence ! (Be quiet.)
- Travaillez avec un partenaire. (Work with a partner.)

## Talking to one friend (tu form)
With one person you use tu. For -er verbs the tu command has no -s: Écoute ! Regarde ! Ferme la porte ! Other verbs keep the s: Écris ! Lis ! Fais l'exercice !

## Negative commands
Put ne before the verb and pas after it: Ne parlez pas ! (Do not talk!) Ne mangez pas en classe ! (Do not eat in class!)

## Useful questions for students
- Pouvez-vous répéter, s'il vous plaît ? (Can you repeat, please?)
- Je ne comprends pas. (I do not understand.)
- Que veut dire « cahier » ? (What does cahier mean?)
- Comment dit-on « pen » en français ? (How do you say pen in French?)
- Comment ça s'écrit ? (How is that spelled?)
- C'est quelle page ? (Which page is it?)
- Je peux aller aux toilettes, s'il vous plaît ? (May I go to the toilet?)
- Excusez-moi, madame / monsieur. (Excuse me, miss / sir.)
- Je suis désolé(e), je suis en retard. (Sorry, I am late.)
- J'ai oublié mon livre. (I forgot my book.)

When you speak to a teacher, use vous and add s'il vous plaît.

## School signs and homework
- Interdit de manger en classe. (Eating in class is forbidden.)
- Téléphones éteints. (Phones off.)
- Pour demain, faites l'exercice 5. (For tomorrow, do exercise 5.)
- Apprenez le vocabulaire. (Learn the vocabulary.)
- Il y a un contrôle lundi. (There is a test on Monday.)

## How this is examined
You may read a note on the board, a list of class rules or a teacher's homework instructions, or hear a short transcript of a lesson beginning. Questions ask what you must do, in which order, what is forbidden and which polite question fits a situation. In writing you may be asked to write a short message to a teacher saying you are late or that you forgot something.

## Common mistakes
- Using tu commands with a teacher or a whole class. Use the vous form.
- Forgetting the accent in écoutez, répétez and répondez.
- Putting the negative around the wrong word: ne ... pas goes around the verb.
- Confusing que veut dire (meaning) with comment ça s'écrit (spelling).

Exam tip: Look for the verb at the start of each sentence. Imperatives come first, so a list of verbs like lisez, puis répondez tells you the order of tasks.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;