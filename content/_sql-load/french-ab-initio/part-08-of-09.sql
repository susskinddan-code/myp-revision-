-- Part 8 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- French Grammar Essentials > Present Tense of Regular and Key Irregular Verbs
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$French Grammar Essentials$mq$, 5, 8 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Present Tense of Regular and Key Irregular Verbs$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$French Grammar Essentials$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Present Tense of Regular and Key Irregular Verbs$mq$ and p.name = $mq$French Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Choose the correct form: 'Je ___ français.' (parler)$mq$, $mq$["parle","parles","parlons","parlent"]$mq$, 0, $mq$With 'je', -er verbs end in -e: je parle.$mq$, $mq$easy$mq$),
($mq$Which form of 'être' goes with 'nous'?$mq$, $mq$["sont","êtes","est","sommes"]$mq$, 3, $mq$être: je suis, tu es, il est, nous sommes, vous êtes, ils sont.$mq$, $mq$easy$mq$),
($mq$Which sentence means 'They have a dog'?$mq$, $mq$["Ils avons un chien.","Ils ont une chien.","Ils ont un chien.","Ils sont un chien."]$mq$, 2, $mq$avoir: ils ont. 'Sont' comes from être, and 'chien' is masculine (un).$mq$, $mq$easy$mq$),
($mq$What is the correct form of 'aller' with 'je'?$mq$, $mq$["vas","vais","va","allons"]$mq$, 1, $mq$aller: je vais, tu vas, il va, nous allons, vous allez, ils vont.$mq$, $mq$easy$mq$),
($mq$Which sentence is correct?$mq$, $mq$["Elle habite à Paris.","Elle habites à Paris.","Elle habitent à Paris.","Elle habitons à Paris."]$mq$, 0, $mq$With 'elle', regular -er verbs end in -e: elle habite.$mq$, $mq$easy$mq$),
($mq$Complete: 'Vous ___ de la musique ?' (faire)$mq$, $mq$["faisez","faisons","font","faites"]$mq$, 3, $mq$faire: je fais, tu fais, il fait, nous faisons, vous faites, ils font. 'Faites' is irregular.$mq$, $mq$medium$mq$),
($mq$Which is the correct present tense of 'finir' with 'nous'?$mq$, $mq$["finons","finions","finissons","finissent"]$mq$, 2, $mq$Regular -ir verbs add -iss- in the plural: nous finissons, vous finissez, ils finissent.$mq$, $mq$medium$mq$),
($mq$Choose the correct sentence.$mq$, $mq$["Nous mangons à midi.","Nous mangeons à midi.","Nous mangez à midi.","Nous mange à midi."]$mq$, 1, $mq$Verbs in -ger keep the e before -ons to keep a soft g: nous mangeons.$mq$, $mq$medium$mq$),
($mq$What is the correct form of 'prendre' with 'ils'?$mq$, $mq$["prennent","prendent","prenons","prend"]$mq$, 0, $mq$prendre: je prends, tu prends, il prend, nous prenons, vous prenez, ils prennent (double n).$mq$, $mq$medium$mq$),
($mq$A friend asks: 'Tu veux venir au cinéma ?' Which reply says 'Yes, I can come on Saturday'?$mq$, $mq$["Oui, je pouvons venir samedi.","Oui, je peut venir samedi.","Oui, je pouvoir venir samedi.","Oui, je peux venir samedi."]$mq$, 3, $mq$pouvoir: je peux, tu peux, il peut. After 'peux' the next verb stays in the infinitive (venir).$mq$, $mq$medium$mq$),
($mq$Which sentence uses the vowel rule correctly?$mq$, $mq$["Je aime le chocolat.","Je'aime le chocolat.","J'aime le chocolat.","J'aimes le chocolat."]$mq$, 2, $mq$Je becomes j' before a vowel or silent h, and the verb takes the -e ending: j'aime.$mq$, $mq$medium$mq$),
($mq$Read: 'Mes parents vendent leur voiture.' What does 'vendent' mean in this sentence?$mq$, $mq$["are buying","are selling","are washing","are driving"]$mq$, 1, $mq$'Vendre' = to sell. Regular -re verbs: ils vendent.$mq$, $mq$medium$mq$),
($mq$Which sentence contains an error?$mq$, $mq$["Tu vas au cinéma et ton frère vont au parc.","Tu vas au cinéma et ton frère va au parc.","Nous allons au cinéma et eux vont au parc.","Vous allez au cinéma et ils vont au parc."]$mq$, 0, $mq$'Ton frère' is singular (il), so the verb is 'va', not 'vont'.$mq$, $mq$hard$mq$),
($mq$Which pair of verbs completes the sentence correctly? 'Mon père ___ à Lyon et mes sœurs ___ à Nice.' (habiter)$mq$, $mq$["habites / habite","habite / habites","habitent / habite","habite / habitent"]$mq$, 3, $mq$Singular subject: habite; plural subject: habitent. The endings -e and -ent sound the same but are written differently.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly expresses 'We are going to eat at the café'?$mq$, $mq$["Nous allons mangeons au café.","Nous vont manger au café.","Nous allons manger au café.","Nous allez manger au café."]$mq$, 2, $mq$Aller (conjugated) + infinitive expresses the near future: nous allons manger. 'Nous' goes with 'allons'.$mq$, $mq$hard$mq$),
($mq$Which sentence has every verb correct?$mq$, $mq$["Elle est quinze ans et elle a sportive.","Elle a quinze ans et elle est sportive.","Elle a quinze ans et elle a sportive.","Elle est quinze ans et elle est sportive."]$mq$, 1, $mq$French uses avoir for age (elle a quinze ans) and être with adjectives (elle est sportive).$mq$, $mq$hard$mq$),
($mq$A message says: 'Je me lève à sept heures, puis je prends mon petit déjeuner.' Which verb is reflexive?$mq$, $mq$["me lève","prends","lève","petit"]$mq$, 0, $mq$'Se lever' (to get up) is reflexive: je me lève. 'Prends' is a normal verb (prendre).$mq$, $mq$hard$mq$),
($mq$Which is the correct question-and-answer pair?$mq$, $mq$["Vous pouvez parler anglais ? Oui, nous pouvez.","Vous pouvez parler anglais ? Oui, je pouvons.","Vous pouvez parler anglais ? Oui, nous peuvent.","Vous pouvez parler anglais ? Oui, nous pouvons."]$mq$, 3, $mq$The answer subject nous needs 'pouvons'. -ez goes with vous, -ent with ils/elles.$mq$, $mq$medium$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Present Tense of Regular and Key Irregular Verbs$mq$ and p.name = $mq$French Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$parler (regular -er)$mq$, $mq$je parle, tu parles, il parle, nous parlons, vous parlez, ils parlent$mq$),
($mq$être$mq$, $mq$je suis, tu es, il est, nous sommes, vous êtes, ils sont$mq$),
($mq$avoir$mq$, $mq$j'ai, tu as, il a, nous avons, vous avez, ils ont. Also used for age: J'ai quinze ans.$mq$),
($mq$aller$mq$, $mq$je vais, tu vas, il va, nous allons, vous allez, ils vont$mq$),
($mq$faire$mq$, $mq$je fais, tu fais, il fait, nous faisons, vous faites, ils font$mq$),
($mq$finir (regular -ir)$mq$, $mq$je finis, tu finis, il finit, nous finissons, vous finissez, ils finissent$mq$),
($mq$prendre$mq$, $mq$je prends, tu prends, il prend, nous prenons, vous prenez, ils prennent (double n)$mq$),
($mq$vouloir / pouvoir$mq$, $mq$veux, veux, veut, voulons, voulez, veulent / peux, peux, peut, pouvons, pouvez, peuvent$mq$),
($mq$nous mangeons / nous commençons$mq$, $mq$Verbs in -ger keep the e (mangeons); verbs in -cer take ç (commençons) in the nous form.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Present Tense of Regular and Key Irregular Verbs$mq$ and p.name = $mq$French Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why this matters
Almost every French sentence needs a verb in the right form. At beginner level you mainly use the present tense, so correct verb endings are a big source of accuracy marks in writing and help you decode who does what in reading and listening.

## The three regular patterns
Regular -er verbs (the biggest group): remove -er, add endings.
- parler: je parle, tu parles, il/elle parle, nous parlons, vous parlez, ils/elles parlent
Regular -ir verbs: finir: je finis, tu finis, il finit, nous finissons, vous finissez, ils finissent
Regular -re verbs: vendre: je vends, tu vends, il vend, nous vendons, vous vendez, ils vendent
Note that the je form and the il form of -er verbs both end in -e. The -es of tu and -ent of ils are silent when you speak, so you must learn them for writing.

## Key irregular verbs
- être (to be): je suis, tu es, il est, nous sommes, vous êtes, ils sont
- avoir (to have): j'ai, tu as, il a, nous avons, vous avez, ils ont
- aller (to go): je vais, tu vas, il va, nous allons, vous allez, ils vont
- faire (to do, make): je fais, tu fais, il fait, nous faisons, vous faites, ils font
- prendre (to take): je prends, tu prends, il prend, nous prenons, vous prenez, ils prennent
- vouloir (to want): je veux, tu veux, il veut, nous voulons, vous voulez, ils veulent
- pouvoir (can): je peux, tu peux, il peut, nous pouvons, vous pouvez, ils peuvent

## Special spelling points
- Before a vowel, je becomes j': j'aime, j'habite.
- Verbs in -ger add an e before -ons: nous mangeons. Verbs in -cer change to ç: nous commençons.
- Reflexive verbs have a pronoun: je me lève, tu te lèves, il se lève, nous nous levons.
- Use avoir for age: J'ai quinze ans (not je suis quinze ans).

## Useful structures
- aller + infinitive = going to (near future): Je vais jouer au foot.
- vouloir / pouvoir + infinitive: Je veux sortir. Tu peux venir ?
- Keep your own sentences simple and correct rather than ambitious and wrong.

## Worked example
Nous habitons à Lille. Mon père travaille dans une banque et ma mère est professeur. Le week-end, nous faisons du vélo.
Meaning: We live in Lille. My father works in a bank and my mother is a teacher. At weekends we go cycling.

## Common mistakes
- Using the infinitive after a subject: wrong je parler; right je parle.
- Using a singular verb with a plural subject: wrong mes parents habite; right mes parents habitent.
- Writing vous faisez (right: vous faites) or ils prendent (right: ils prennent).
- Dropping j' before a vowel: wrong je aime.

## How this is examined
In reading tasks, a verb ending reveals who is acting (ils ont versus il a). In writing, markers reward verbs that agree with their subject in sentences you create yourself. Multiple-choice items often offer the same verb with four different endings.

Exam tip: Before you write a verb, ask "who is doing it?" and look at your list. Check every verb in your final answer once for subject agreement.$mq$ from st;

-- French Grammar Essentials > Articles, Questions and Negatives
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$French Grammar Essentials$mq$, 5, 8 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Articles, Questions and Negatives$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$French Grammar Essentials$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Articles, Questions and Negatives$mq$ and p.name = $mq$French Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which article goes with 'livre' (masculine)?$mq$, $mq$["un","une","des","la"]$mq$, 0, $mq$'Un livre' is a book. 'Livre' is a masculine noun, so it takes 'un'; 'une' is for feminine nouns and 'des' for plurals.$mq$, $mq$easy$mq$),
($mq$What does 'les' mean in 'les élèves'?$mq$, $mq$["a","some (feminine)","of the","the (plural)"]$mq$, 3, $mq$'Les' is the plural definite article, for masculine and feminine nouns.$mq$, $mq$easy$mq$),
($mq$Which sentence is a question?$mq$, $mq$["Tu aimes le sport.","Je n'aime pas le sport.","Tu aimes le sport ?","Il aime le sport."]$mq$, 2, $mq$Raising the voice (and the question mark) turns a statement into a question.$mq$, $mq$easy$mq$),
($mq$How do you say 'I do not like fish'?$mq$, $mq$["Je aime pas le poisson.","Je n'aime pas le poisson.","Je ne aime pas le poisson.","Je pas aime le poisson."]$mq$, 1, $mq$Negative = ne ... pas around the verb; ne becomes n' before a vowel: je n'aime pas.$mq$, $mq$easy$mq$),
($mq$What does 'Où habites-tu ?' ask?$mq$, $mq$["Where do you live?","When do you live?","Who lives there?","How old are you?"]$mq$, 0, $mq$'Où' = where; 'habites-tu' = do you live (inverted form).$mq$, $mq$easy$mq$),
($mq$Choose the right article: 'Je mange ___ pain.' (some bread)$mq$, $mq$["de la","des","un","du"]$mq$, 3, $mq$Pain is masculine, so 'some bread' = du pain (de + le).$mq$, $mq$medium$mq$),
($mq$Which sentence is correct?$mq$, $mq$["Je vais à le marché et à la pharmacie.","Je vais au marché et au pharmacie.","Je vais au marché et à la pharmacie.","Je vais aux marché et à la pharmacie."]$mq$, 2, $mq$à + le = au (au marché). Pharmacie is feminine, so à la pharmacie.$mq$, $mq$medium$mq$),
($mq$Complete the question: '___ tu fais le samedi ?' (What do you do on Saturdays?)$mq$, $mq$["Qui est-ce que","Qu'est-ce que","Où est-ce que","Quand est-ce que"]$mq$, 1, $mq$'Qu'est-ce que' asks 'what'. Qui = who, où = where, quand = when.$mq$, $mq$medium$mq$),
($mq$Which question asks for a reason?$mq$, $mq$["Pourquoi tu ris ?","Comment tu ris ?","Combien tu ris ?","Quand tu ris ?"]$mq$, 0, $mq$'Pourquoi' = why. Comment = how, combien = how much/many, quand = when.$mq$, $mq$medium$mq$),
($mq$Which is the correct negative form of 'J'ai un frère'?$mq$, $mq$["Je n'ai pas un frère.","Je n'ai pas du frère.","Je ne pas ai de frère.","Je n'ai pas de frère."]$mq$, 3, $mq$After a negative, un/une/des/du change to de (or d'): Je n'ai pas de frère.$mq$, $mq$medium$mq$),
($mq$What does 'Je ne mange jamais de viande' mean?$mq$, $mq$["I always eat meat.","I do not eat meat today.","I never eat meat.","I sometimes eat meat."]$mq$, 2, $mq$'Ne ... jamais' = never. 'De' replaces 'de la/du' after a negative.$mq$, $mq$medium$mq$),
($mq$Which is a correct question using 'est-ce que'?$mq$, $mq$["Est-ce que habites tu ici ?","Est-ce que tu habites ici ?","Est-ce tu habites que ici ?","Que est-ce tu habites ici ?"]$mq$, 1, $mq$'Est-ce que' goes before the subject and verb: Est-ce que tu habites ici ?$mq$, $mq$medium$mq$),
($mq$Which sentence is entirely correct?$mq$, $mq$["Il n'y a pas de pharmacie dans la rue.","Il n'y a pas une pharmacie dans la rue.","Il ne y a pas de pharmacie dans la rue.","Il y a pas de pharmacie dans la rue."]$mq$, 0, $mq$Ne becomes n' before y; and 'une pharmacie' becomes 'de pharmacie' after pas. Spoken French often drops ne, but formal writing keeps it.$mq$, $mq$hard$mq$),
($mq$Read: 'Je n'aime pas les fruits, mais j'adore les légumes.' Which statement is correct?$mq$, $mq$["The speaker likes fruit but not vegetables.","The speaker likes neither.","The speaker likes both.","The speaker likes vegetables but not fruit."]$mq$, 3, $mq$'Je n'aime pas' = I do not like (fruits); 'mais' signals a contrast, 'j'adore' (vegetables).$mq$, $mq$hard$mq$),
($mq$Which question and answer match correctly?$mq$, $mq$["Combien coûte ce livre ? Il est rouge.","Quand coûte ce livre ? Il coûte douze euros.","Combien coûte ce livre ? Il coûte douze euros.","Comment coûte ce livre ? Il est à la table."]$mq$, 2, $mq$'Combien' asks the price or quantity, and the answer gives a price. The other options mismatch the question word.$mq$, $mq$hard$mq$),
($mq$Which sentence is correct for 'We do not have any apples'?$mq$, $mq$["Nous n'avons pas des pommes.","Nous n'avons pas de pommes.","Nous n'avons pas de la pommes.","Nous ne avons pas de pommes."]$mq$, 1, $mq$Des becomes de after a negative, and ne becomes n' before a vowel (avons).$mq$, $mq$hard$mq$),
($mq$Which is the correct inverted question for 'Do you (vous) have a pen?'$mq$, $mq$["Avez-vous un stylo ?","Vous avez-vous un stylo ?","Avez un stylo vous ?","Est-ce avez-vous un stylo ?"]$mq$, 0, $mq$Inversion: verb first, then a hyphen and the pronoun. 'Avez-vous un stylo ?' is formal and correct.$mq$, $mq$hard$mq$),
($mq$Which choice completes the dialogue? '— ___ est ton professeur de français ? — C'est Madame Roux.'$mq$, $mq$["Quand","Où","Combien","Qui"]$mq$, 3, $mq$The answer is a person (Madame Roux), so the question word is 'Qui' (who).$mq$, $mq$medium$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Articles, Questions and Negatives$mq$ and p.name = $mq$French Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$le / la / l' / les$mq$, $mq$the (masculine / feminine / before a vowel / plural)$mq$),
($mq$un / une / des$mq$, $mq$a or an (masculine / feminine) / some or plural a$mq$),
($mq$du / de la / de l' / des$mq$, $mq$some (masculine / feminine / vowel / plural). Je mange du pain; elle boit de l'eau.$mq$),
($mq$au / aux$mq$, $mq$to the: à + le = au; à + les = aux. À la and à l' do not change.$mq$),
($mq$Est-ce que tu ... ?$mq$, $mq$A question form: place before subject and verb. Est-ce que tu habites ici ? (Do you live here?)$mq$),
($mq$qui / où / quand / pourquoi / comment / combien$mq$, $mq$who / where / when / why / how / how much or how many$mq$),
($mq$ne ... pas$mq$, $mq$not. Je ne parle pas. Before a vowel: Je n'aime pas.$mq$),
($mq$ne ... jamais / plus / rien$mq$, $mq$never / no longer / nothing: Je ne mange jamais de viande.$mq$),
($mq$Je n'ai pas de frère.$mq$, $mq$I do not have a brother. After a negative un, une, des and du become de or d'.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Articles, Questions and Negatives$mq$ and p.name = $mq$French Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why this matters
Articles, questions and negatives are the three small structures that appear in almost every task. If you can build a question and its negative answer correctly, you can handle dialogues, emails and interviews.

## Articles
Definite (the): le (masc.), la (fem.), l' (before a vowel), les (plural).
Indefinite (a, an, some): un (masc.), une (fem.), des (plural).
Partitive (some, any, with food and drink): du (masc.), de la (fem.), de l' (vowel), des (plural). Je mange du pain. Elle boit de l'eau.
Contractions with à and de:
- à + le = au, à + les = aux (but à la and à l' do not change): Je vais au parc. Il parle aux élèves.
- de + le = du, de + les = des: la voiture du professeur.

## Asking questions
Three ways to ask the same thing:
- Intonation: Tu habites ici ? (informal)
- Est-ce que: Est-ce que tu habites ici ?
- Inversion (formal): Habites-tu ici ? Avez-vous un stylo ?
Question words:
- qui (who), que / qu'est-ce que (what), où (where), quand (when), comment (how), pourquoi (why), combien (how much / how many), quel / quelle / quels / quelles (which, what)
- Example: Où est-ce que tu habites ? Quel âge as-tu ?
Answer pourquoi with parce que: Pourquoi ? Parce que j'aime ça.

## Negatives
Put ne ... pas around the verb: Je ne parle pas allemand. Ne becomes n' before a vowel: Il n'aime pas ça.
Other negatives follow the same pattern:
- ne ... jamais (never): Je ne mange jamais de viande.
- ne ... plus (no longer, no more): Il ne joue plus au tennis.
- ne ... rien (nothing): Je ne sais rien.
After a negative, un / une / des / du / de la change to de (d' before a vowel):
- J'ai un frère. → Je n'ai pas de frère.
- Elle a des amis. → Elle n'a pas d'amis.
Exception: after être the article does not change: Ce n'est pas un chat.

## Worked example
Est-ce que tu aimes le sport ? Non, je n'aime pas le sport, mais j'adore la musique. Je joue du piano.
Meaning: Do you like sport? No, I do not like sport, but I love music. I play the piano.

## Common mistakes
- Forgetting n' before a vowel: wrong je ne aime pas.
- Leaving un or des after pas: wrong je n'ai pas un frère.
- Writing à le or de le (wrong) instead of au and du.
- Inverting in the wrong way: wrong Vous avez-vous ... (the pronoun appears once only).

## How this is examined
In reading, you may have to identify what question word fits an answer (who, where, when). In writing you are expected to produce at least one question and one negative sentence. MCQs usually test contractions (au, du), the negative article de, and matching question words to answers.

Exam tip: To build a negative, find the verb, wrap ne ... pas around it, then check whether the noun after it needs de instead of un, une, des.$mq$ from st;

-- French Grammar Essentials > Adjectives, Agreement and Possessives
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$French Grammar Essentials$mq$, 5, 8 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Adjectives, Agreement and Possessives$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$French Grammar Essentials$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Adjectives, Agreement and Possessives$mq$ and p.name = $mq$French Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which adjective agrees with 'une fille'?$mq$, $mq$["petite","petit","petits","petites"]$mq$, 0, $mq$Fille is feminine singular, so the adjective takes -e: petite.$mq$, $mq$easy$mq$),
($mq$What does 'mon frère' mean?$mq$, $mq$["your brother","his brother","our brother","my brother"]$mq$, 3, $mq$Mon = my (masculine singular); ton = your; son = his/her; notre = our.$mq$, $mq$easy$mq$),
($mq$Which phrase is correct for 'my sister'?$mq$, $mq$["mon sœur","mes sœur","ma sœur","me sœur"]$mq$, 2, $mq$Sœur is feminine, so ma. Mon (masculine), mes (plural).$mq$, $mq$easy$mq$),
($mq$Which sentence is correct?$mq$, $mq$["Les livres sont intéressant.","Les livres sont intéressants.","Les livres est intéressants.","Les livres sont intéressante."]$mq$, 1, $mq$Plural noun, plural adjective (+ s), and the plural verb 'sont'.$mq$, $mq$easy$mq$),
($mq$What does 'mes amis' mean?$mq$, $mq$["my friends","my friend (male)","our friends","his friend"]$mq$, 0, $mq$Mes is the plural of mon/ma, so mes amis = my friends.$mq$, $mq$easy$mq$),
($mq$Choose the correct adjective: 'Ma mère est ___.' (grand)$mq$, $mq$["grand","grands","grandes","grande"]$mq$, 3, $mq$Mère is feminine singular, so grande.$mq$, $mq$medium$mq$),
($mq$Which is the feminine of 'heureux'?$mq$, $mq$["heureux","heureuxe","heureuse","heureuses"]$mq$, 2, $mq$Adjectives in -eux change to -euse in the feminine: heureux → heureuse.$mq$, $mq$medium$mq$),
($mq$Choose the correct possessive: 'Anna a un chat. ___ chat s'appelle Mimi.'$mq$, $mq$["Sa","Son","Ses","Leur"]$mq$, 1, $mq$Son/sa/ses agree with the noun possessed, not the owner. Chat is masculine singular, so son.$mq$, $mq$medium$mq$),
($mq$Which sentence is correct?$mq$, $mq$["J'ai une nouvelle voiture.","J'ai une nouveau voiture.","J'ai un nouvelle voiture.","J'ai une voiture nouveau."]$mq$, 0, $mq$Nouveau changes to nouvelle with a feminine noun, and it usually goes before the noun.$mq$, $mq$medium$mq$),
($mq$Where does the adjective go? 'Un chat ___' (noir)$mq$, $mq$["Un noir chat","Noir un chat","Un chat noirs","Un chat noir"]$mq$, 3, $mq$Colours come after the noun, and agree with it: un chat noir.$mq$, $mq$medium$mq$),
($mq$Which phrase means 'our house'?$mq$, $mq$["nos maison","votre maison","notre maison","leur maison"]$mq$, 2, $mq$Notre = our (singular). Nos is the plural; votre = your (vous).$mq$, $mq$medium$mq$),
($mq$Which sentence uses the vowel rule correctly?$mq$, $mq$["Ma amie est française.","Mon amie est française.","Mon amie est français.","Ma amie est français."]$mq$, 1, $mq$Before a feminine noun starting with a vowel, use mon instead of ma for sound. The adjective still agrees with the girl: française.$mq$, $mq$medium$mq$),
($mq$Which sentence is entirely correct?$mq$, $mq$["Mes cousines sont grandes et sportives.","Mes cousines sont grand et sportif.","Mes cousine sont grandes et sportive.","Mes cousines est grandes et sportives."]$mq$, 0, $mq$Feminine plural subject: cousines, plural verb sont, adjectives with -es.$mq$, $mq$hard$mq$),
($mq$Read: 'Léo parle de sa sœur et de ses parents.' Why is it 'sa' and not 'son'?$mq$, $mq$["Because Léo is a girl","Because there is more than one sister","Because Léo's sister is older than him","Because sœur is a feminine noun"]$mq$, 3, $mq$Son/sa/ses agree with the noun owned, not with the owner. Sœur is feminine singular, so sa; parents is plural, so ses. Léo's own gender does not matter.$mq$, $mq$hard$mq$),
($mq$Which sentence is correct for 'Their friends are nice'?$mq$, $mq$["Leur amis sont gentils.","Leurs amis sont gentil.","Leurs amis sont gentils.","Leurs ami sont gentils."]$mq$, 2, $mq$Leurs agrees with plural 'amis', and the adjective gentils takes -s.$mq$, $mq$hard$mq$),
($mq$Which is the correct French for 'a beautiful girl'?$mq$, $mq$["une beau fille","une belle fille","une beaue fille","un belle fille"]$mq$, 1, $mq$Beau becomes belle before a feminine noun. The article must also be feminine (une).$mq$, $mq$hard$mq$),
($mq$Choose the correct phrase: 'her brothers' when talking about Marie.$mq$, $mq$["ses frères","sa frères","ses frère","leurs frères"]$mq$, 0, $mq$Frères is plural, so ses is used (the owner's gender does not matter).$mq$, $mq$medium$mq$),
($mq$Which description is grammatically correct?$mq$, $mq$["Mon petit frère est sympas et mes grandes sœurs sont drôle.","Ma petit frère est sympa et mes grande sœurs sont drôles.","Mon petite frère est sympa et mes grandes sœurs sont drôles.","Mon petit frère est sympa et mes grandes sœurs sont drôles."]$mq$, 3, $mq$Petit/frère are masculine singular, grandes/sœurs are feminine plural, drôles agrees with sœurs, and sympa is invariable in the singular and plural.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Adjectives, Agreement and Possessives$mq$ and p.name = $mq$French Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$grand → grande, grands, grandes$mq$, $mq$Adjectives agree with the noun: add -e (feminine), -s (plural), -es (feminine plural).$mq$),
($mq$heureux / sportif / beau$mq$, $mq$feminine: heureuse / sportive / belle$mq$),
($mq$mon / ma / mes$mq$, $mq$my (masculine / feminine / plural). Use mon before a vowel: mon amie.$mq$),
($mq$son / sa / ses$mq$, $mq$his or her. Chosen by the noun owned, not the owner: son frère, sa sœur, ses parents.$mq$),
($mq$notre / nos; votre / vos; leur / leurs$mq$, $mq$our; your (vous); their. Singular / plural.$mq$),
($mq$un chat noir$mq$, $mq$Colours and most adjectives come after the noun.$mq$),
($mq$BAGS adjectives$mq$, $mq$Beauty, Age, Goodness, Size come before the noun: beau, joli, jeune, vieux, bon, mauvais, petit, grand, gros, nouveau.$mq$),
($mq$Invariable adjectives$mq$, $mq$marron and orange do not change with gender or number: des chaussures marron.$mq$),
($mq$Mon amie est française.$mq$, $mq$My (female) friend is French. Mon before vowel; française agrees with a girl.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Adjectives, Agreement and Possessives$mq$ and p.name = $mq$French Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why this matters
Describing people and things uses adjectives and possessives: my brother is tall, her sisters are friendly. French makes these words agree with the noun, so accurate agreement is one of the clearest signals of good writing at beginner level.

## Basic agreement
Most adjectives change like this:
- masculine singular: grand
- feminine singular: add -e → grande
- masculine plural: add -s → grands
- feminine plural: add -es → grandes
If the masculine already ends in -e, the feminine does not change: jeune, drôle and rouge stay the same. The everyday word sympa does not add -e either: une fille sympa.
The adjective agrees with the noun, not with the speaker: Mes sœurs sont petites.

## Common irregular patterns
- -eux → -euse: heureux → heureuse
- -if → -ive: sportif → sportive
- -on / -en → -onne / -enne: bon → bonne
- blanc → blanche, long → longue, gentil → gentille
- beau → belle (nouveau → nouvelle, vieux → vieille); before a masculine vowel noun: un bel homme, un nouvel ami
- Invariable colours: marron (brown), orange (orange)

## Where does the adjective go?
Most adjectives come after the noun: un chat noir, une voiture rouge, une fille sympa.
A small group come before: petit, grand, jeune, vieux, beau, joli, bon, mauvais, nouveau, gros. Un petit garçon, une jolie maison.

## Possessive adjectives
These agree with the noun owned (not the owner):
- my: mon (masc.), ma (fem.), mes (plural)
- your (tu): ton, ta, tes
- his / her: son, sa, ses
- our: notre (singular), nos (plural)
- your (vous): votre, vos
- their: leur, leurs
Before a feminine noun that starts with a vowel use mon, ton, son: mon amie, ton école.
Son frère = his brother or her brother. Only the context shows whose.

## Describing a person: a model
Ma sœur s'appelle Chloé. Elle est grande et sportive. Elle a les cheveux longs et noirs. Ses amis sont gentils et ses parents sont sympas.
Meaning: My sister is called Chloé. She is tall and sporty. She has long black hair. Her friends are nice and her parents are kind.

## Common mistakes
- Forgetting to add -e or -s: wrong ma sœur est petit.
- Using ma with a vowel: wrong ma amie (right: mon amie).
- Choosing son or sa by looking at the owner (wrong): Marie parle de son père (père is masculine, so son).
- Putting a colour before the noun: wrong un rouge livre.

## How this is examined
Reading questions often rely on agreement to show who is being described (grande means a girl). In writing, markers look for agreement and correct possessives in your descriptions. MCQs offer the same adjective in four forms and ask for the right one.

Exam tip: After writing an adjective, point back to the noun and ask "masculine or feminine, one or more?" It takes five seconds and saves marks.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;