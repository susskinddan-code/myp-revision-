-- Part 1 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Greetings and Introductions > Greetings and Farewells
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Greetings and Introductions$mq$, 5, 1 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Greetings and Farewells$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Greetings and Introductions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Greetings and Farewells$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'Au revoir' mean?$mq$, $mq$["Goodbye","Hello","Please","Thank you"]$mq$, 0, $mq$'Au revoir' is the standard way to say goodbye. 'Bonjour' is hello and 'merci' is thank you.$mq$, $mq$easy$mq$),
($mq$Which greeting is informal and used with friends your own age?$mq$, $mq$["Bonjour, Madame","Enchanté","Bonsoir, Monsieur","Salut"]$mq$, 3, $mq$'Salut' is the casual way to say hi (and sometimes bye) to friends. The other options are formal or are used for introductions.$mq$, $mq$easy$mq$),
($mq$Someone asks you 'Comment ça va ?' and you feel fine. Which reply fits best?$mq$, $mq$["Je m'appelle Luc.","J'ai quinze ans.","Ça va bien, merci.","À demain."]$mq$, 2, $mq$'Comment ça va ?' means 'How are you?' so 'Ça va bien, merci' (I'm fine, thanks) answers it. The others answer different questions.$mq$, $mq$easy$mq$),
($mq$What does 'À demain' mean?$mq$, $mq$["See you soon","See you tomorrow","See you later","Goodbye forever"]$mq$, 1, $mq$'Demain' means tomorrow, so 'À demain' is 'See you tomorrow'. 'À bientôt' is 'See you soon'.$mq$, $mq$easy$mq$),
($mq$What does 'Merci beaucoup' mean?$mq$, $mq$["Thank you very much","You're welcome","Excuse me","I'm sorry"]$mq$, 0, $mq$'Merci' is thank you and 'beaucoup' means very much or a lot. 'De rien' is 'you're welcome'.$mq$, $mq$easy$mq$),
($mq$It is 9 a.m. and you meet your teacher, Madame Lefèvre, at the school gate. Which greeting is most appropriate?$mq$, $mq$["Salut, Lefèvre !","Coucou !","Ça roule ?","Bonjour, Madame."]$mq$, 3, $mq$With a teacher you use a polite, formal greeting: 'Bonjour, Madame'. 'Salut', 'Coucou' and 'Ça roule ?' are all casual.$mq$, $mq$medium$mq$),
($mq$Léa says: 'Salut, Karim ! Ça va ?' Karim replies: 'Pas mal, et toi ?' What does Karim mean?$mq$, $mq$["He is not well at all","He is very tired","He is not bad","He does not know"]$mq$, 2, $mq$'Pas mal' means 'not bad'. 'Et toi ?' returns the question: 'And you?'$mq$, $mq$medium$mq$),
($mq$Which question is the formal way to ask how someone is?$mq$, $mq$["Ça va ?","Comment allez-vous ?","Quoi de neuf ?","Tu vas bien ?"]$mq$, 1, $mq$'Comment allez-vous ?' uses 'vous', the polite form. 'Tu vas bien ?' and 'Ça va ?' are informal.$mq$, $mq$medium$mq$),
($mq$A sign on a shop door says: 'Bonne journée et à bientôt !' What is the message?$mq$, $mq$["Have a good day and see you soon","Welcome, please come in","Closed until tomorrow","Thank you and goodbye forever"]$mq$, 0, $mq$'Bonne journée' is 'have a good day' and 'à bientôt' is 'see you soon'. Shops say this as customers leave.$mq$, $mq$medium$mq$),
($mq$Someone says 'Merci !' to you. Which is the correct reply?$mq$, $mq$["Enchanté.","Bonne nuit.","Pardon ?","De rien."]$mq$, 3, $mq$'De rien' means 'you're welcome'. 'Pardon ?' means 'Sorry?' or 'Pardon me?'.$mq$, $mq$medium$mq$),
($mq$A child says: 'Bonne nuit, Maman ! À demain !' When is this most likely said?$mq$, $mq$["On the way to school in the morning","At lunchtime","Before going to bed","At a birthday party"]$mq$, 2, $mq$'Bonne nuit' is said only at night, just before sleeping. 'À demain' means see you tomorrow.$mq$, $mq$medium$mq$),
($mq$Complete the greeting at 3 p.m.: '___, Monsieur Dupont. Comment allez-vous ?'$mq$, $mq$["Salut","Bonjour","Bonne nuit","Coucou"]$mq$, 1, $mq$'Bonjour' is correct in the afternoon and polite with Monsieur Dupont. 'Bonne nuit' is not a greeting, and 'Salut' and 'Coucou' are too casual.$mq$, $mq$medium$mq$),
($mq$You bump into someone in the corridor. Which word means 'Excuse me / Sorry'?$mq$, $mq$["Pardon","Bientôt","Parfait","Peut-être"]$mq$, 0, $mq$'Pardon' is used to say sorry or excuse me. 'Bientôt' is soon, 'parfait' is perfect and 'peut-être' is maybe.$mq$, $mq$medium$mq$),
($mq$Listening transcript: Théo: 'Bonsoir, Madame Roy. Comment allez-vous ?' Madame Roy: 'Je vais très bien, merci. Et vous ?' Which statement is true?$mq$, $mq$["They are close friends using 'tu'","It is morning","Madame Roy is unwell","Théo speaks formally and it is evening"]$mq$, 3, $mq$'Bonsoir' means good evening and both speakers use 'vous', which is formal. Madame Roy says she is very well.$mq$, $mq$hard$mq$),
($mq$Listening transcript: Hugo: 'Allô, Julie ? Salut ! Tu vas bien ?' Julie: 'Oui, très bien. Mais je suis en retard. Au revoir, à tout à l'heure !' What is true?$mq$, $mq$["Julie is ill and is going home","Hugo is late","Julie is late and expects to see Hugo later today","They will meet next week"]$mq$, 2, $mq$'En retard' means late and 'à tout à l'heure' means see you in a little while (later the same day). Julie is well: 'très bien'.$mq$, $mq$hard$mq$),
($mq$Which pair of sentences is correct for speaking to your headteacher?$mq$, $mq$["Salut, Madame ! Ça va ?","Bonjour, Madame. Comment allez-vous ?","Bonjour, Madame. Tu vas bien ?","Coucou, Madame. Comment allez-vous ?"]$mq$, 1, $mq$Only option B stays formal throughout: 'Bonjour' and 'vous'. The others mix a casual greeting or 'tu' with a formal title.$mq$, $mq$hard$mq$),
($mq$You are writing an email to the head of a French school you want to visit. Which closing is most suitable?$mq$, $mq$["Cordialement,","Bisous !","Salut, ciao !","À plus, mec !"]$mq$, 0, $mq$'Cordialement' means 'kind regards' and suits a formal email. 'Bisous' (kisses) and 'À plus' are for friends and family.$mq$, $mq$hard$mq$),
($mq$You are leaving a friend's house at 6 p.m. and she will have dinner soon. Which farewell is the most natural?$mq$, $mq$["Bonne nuit !","Bonjour !","Bonne journée !","Bonne soirée !"]$mq$, 3, $mq$'Bonne soirée' (have a good evening) is used from late afternoon. 'Bonne nuit' is only for going to bed, and 'bonjour' is a greeting rather than a farewell.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Greetings and Farewells$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Bonjour vs Bonsoir$mq$, $mq$Bonjour = hello or good day (morning to early evening). Bonsoir = good evening, used when it is evening or dark.$mq$),
($mq$Salut$mq$, $mq$Informal 'hi' or 'bye', used with friends and family. Not for teachers or adults you do not know.$mq$),
($mq$Comment allez-vous ?$mq$, $mq$How are you? (formal, uses vous). Informal forms: Ça va ? / Comment vas-tu ?$mq$),
($mq$Ça va bien, merci. Et toi ?$mq$, $mq$I'm fine, thanks. And you? Use 'Et vous ?' for formal situations.$mq$),
($mq$Pas mal$mq$, $mq$Not bad. Related: comme ci, comme ça = so-so; ça ne va pas = I'm not well.$mq$),
($mq$Au revoir / À bientôt$mq$, $mq$Goodbye / See you soon.$mq$),
($mq$À demain / À tout à l'heure$mq$, $mq$See you tomorrow / See you in a little while (later today).$mq$),
($mq$Bonne nuit$mq$, $mq$Good night. Only said before bed, never as a greeting. For the evening, say Bonne soirée.$mq$),
($mq$Merci / De rien / Pardon$mq$, $mq$Thank you / You're welcome / Sorry or excuse me.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Greetings and Farewells$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why greetings matter
Greetings are the first thing you learn and the first thing examiners expect you to get right. French people care about politeness: you greet people when you enter a shop, a classroom or a lift. The key skill is choosing between formal and informal language, so learn both sets.

## Saying hello
- Bonjour (hello, good day) works from morning until early evening and is safe with anyone.
- Bonsoir (good evening) is used once it gets dark or in the evening.
- Salut (hi or bye) is informal and for friends and family.
- Coucou (hey) is very casual, often in messages.
- Bonne nuit (good night) is only used before sleeping. It is not a greeting.

## Asking and answering how someone is
Informal (tu): Ça va ? / Comment vas-tu ? / Tu vas bien ?
Formal (vous): Comment allez-vous ?
Answers:
- Ça va très bien, merci. (I'm very well, thanks.)
- Ça va bien. (I'm fine.)
- Pas mal. (Not bad.)
- Comme ci, comme ça. (So-so.)
- Ça ne va pas. (I'm not well.)
After answering, return the question: Et toi ? (informal) or Et vous ? (formal).

## Saying goodbye
- Au revoir (goodbye)
- À bientôt (see you soon)
- À demain (see you tomorrow)
- À tout à l'heure (see you in a little while, later today)
- À plus tard (see you later)
- Bonne journée (have a good day)
- Bonne soirée (have a good evening)
- Bonne nuit (good night)

## Politeness words
- s'il vous plaît / s'il te plaît (please)
- merci / merci beaucoup (thanks / thank you very much)
- De rien (you're welcome)
- Pardon (sorry, excuse me)
- Excusez-moi (excuse me, formal)

## Titles
Use Monsieur (Mr), Madame (Mrs or Ms) and Mademoiselle (Miss, less common now) with a surname: Bonjour, Madame Roy. French does not use a surname without a title when you speak to an adult politely.

## Example dialogues
Friends: Salut, Inès ! Ça va ? / Oui, ça va bien, et toi ? / Pas mal. À demain ! / Salut !
Formal: Bonjour, Monsieur Bernard. Comment allez-vous ? / Très bien, merci. Et vous ? / Bien, merci. Au revoir, Monsieur. / Au revoir, bonne journée !

## Common mistakes
- Using tu with a teacher or adult you do not know. Use vous.
- Saying Bonne nuit to mean hello in the evening. Use Bonsoir.
- Forgetting the apostrophe and accents: à, tout à l'heure, Ça.
- Mixing registers, such as 'Salut, Madame'.

## How this is examined
In reading tasks you meet short notices, signs, text messages or emails with greetings and farewells, and you must work out who is speaking to whom and when. In listening tasks (read as a transcript here) you pick out the greeting, the time of day and the farewell. In writing, you are expected to open and close a message in the right register, for example 'Cher Paul' and 'À bientôt' for a friend, or 'Bonjour, Madame' and 'Cordialement' for an adult.

Exam tip: Underline the greeting and the farewell in any text first. They tell you how formal the writer is, which often decides between two similar answer options.$mq$ from st;

-- Greetings and Introductions > Introducing Yourself and Others
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Greetings and Introductions$mq$, 5, 1 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Introducing Yourself and Others$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Greetings and Introductions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Introducing Yourself and Others$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'Je m'appelle Chloé' mean?$mq$, $mq$["My name is Chloé","I am from Chloé","I like Chloé","I have Chloé"]$mq$, 0, $mq$'Je m'appelle' literally means 'I call myself' and is the normal way to say 'My name is'.$mq$, $mq$easy$mq$),
($mq$How do you ask a friend 'What is your name?'$mq$, $mq$["Tu habites où ?","Tu as quel âge ?","Tu viens d'où ?","Tu t'appelles comment ?"]$mq$, 3, $mq$'Tu t'appelles comment ?' asks for a name. The other questions ask where you live, your age and where you come from.$mq$, $mq$easy$mq$),
($mq$What does 'J'habite à Lyon' mean?$mq$, $mq$["I work in Lyon","I am visiting Lyon","I live in Lyon","I like Lyon"]$mq$, 2, $mq$'Habiter' means to live. 'À' before a town means 'in' or 'at'.$mq$, $mq$easy$mq$),
($mq$What does 'Voici mon ami Paul' mean?$mq$, $mq$["Paul is my teacher","Here is my friend Paul","Paul is my brother","I like Paul"]$mq$, 1, $mq$'Voici' means 'here is' (when introducing) and 'mon ami' is 'my friend' (a male friend).$mq$, $mq$easy$mq$),
($mq$What does 'Enchanté' mean when you meet someone?$mq$, $mq$["Delighted to meet you","Goodbye","Excuse me","Please"]$mq$, 0, $mq$'Enchanté' means 'pleased to meet you'. A girl or woman can write 'enchantée' with an extra e.$mq$, $mq$easy$mq$),
($mq$Which sentence correctly describes a boy from France?$mq$, $mq$["Il est française.","Elle est français.","Il est françaises.","Il est français."]$mq$, 3, $mq$A masculine singular subject takes the masculine singular adjective: 'Il est français'. The feminine form is 'française'.$mq$, $mq$medium$mq$),
($mq$Read this message: 'Salut ! Je m'appelle Amina. J'ai quinze ans et j'habite à Montréal. Je suis canadienne.' What is Amina's nationality?$mq$, $mq$["French","Belgian","Canadian","Swiss"]$mq$, 2, $mq$'Canadienne' is the feminine form of 'canadien', meaning Canadian. She lives in Montréal, which is in Canada.$mq$, $mq$medium$mq$),
($mq$Which question asks where someone lives?$mq$, $mq$["Comment t'appelles-tu ?","Où habites-tu ?","Quel âge as-tu ?","D'où viens-tu ?"]$mq$, 1, $mq$'Où habites-tu ?' means 'Where do you live?'. 'D'où viens-tu ?' asks where you come from, which can be a different place.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Elle ___ Sophie.'$mq$, $mq$["s'appelle","m'appelle","t'appelle","vous appelez"]$mq$, 0, $mq$With elle (she) the reflexive pronoun is 's': 'Elle s'appelle Sophie'.$mq$, $mq$medium$mq$),
($mq$You are introducing your sister Inès to your teacher. Which sentence is best?$mq$, $mq$["Salut, voilà ma sœur Inès.","Madame, tu présentes Inès.","Inès, c'est moi.","Madame, je vous présente ma sœur, Inès."]$mq$, 3, $mq$'Je vous présente' is the polite way to introduce someone to an adult. The other options are informal, ungrammatical or mean something else.$mq$, $mq$medium$mq$),
($mq$A boy writes: 'Je viens du Maroc mais j'habite en Belgique.' What does this tell us?$mq$, $mq$["He was born in Belgium and lives in Morocco","He lives in Morocco and Belgium","He comes from Morocco and lives in Belgium","He is on holiday in Morocco"]$mq$, 2, $mq$'Je viens de' means 'I come from' and 'j'habite' means 'I live'. So Morocco is where he comes from and Belgium is where he lives.$mq$, $mq$medium$mq$),
($mq$A girl wants to say 'I am English'. Which sentence is correct?$mq$, $mq$["Je suis anglais.","Je suis anglaise.","Je suis Angleterre.","J'ai anglaise."]$mq$, 1, $mq$A girl uses the feminine adjective 'anglaise' with 'je suis'. 'Angleterre' is the country, not the nationality.$mq$, $mq$medium$mq$),
($mq$Choose the correct verb form: 'Nous ___ à Paris.'$mq$, $mq$["habitons","habite","habites","habitez"]$mq$, 0, $mq$With 'nous' the -er verb ending is -ons: 'nous habitons'. 'Habitez' goes with 'vous'.$mq$, $mq$medium$mq$),
($mq$Read this email extract: 'Je m'appelle Marc Lambert. Je suis suisse et j'habite à Genève avec ma famille. Mon meilleur ami s'appelle Noah. Il est belge.' Which statement is true?$mq$, $mq$["Marc is Belgian","Noah lives in Geneva","Noah is Swiss","Marc is Swiss and Noah is Belgian"]$mq$, 3, $mq$Marc says 'je suis suisse' and Noah 'est belge'. We are not told where Noah lives, so B cannot be assumed.$mq$, $mq$hard$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["Elle s'appelle Lina.","Je suis allemande.","Tu t'appelle Marc.","Il habite à Nice."]$mq$, 2, $mq$With 'tu' the verb needs -s: 'Tu t'appelles Marc'. The other three sentences are correct.$mq$, $mq$hard$mq$),
($mq$Complete: 'Voici ___ amie, Clara. Elle ___ espagnole.'$mq$, $mq$["ma ... est","mon ... est","mon ... a","ma ... a"]$mq$, 1, $mq$Before a feminine noun starting with a vowel, French uses 'mon': 'mon amie'. 'Être' (est) is used for nationality, not 'avoir' (a).$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'Bonjour, je m'appelle Ibrahim. J'habite à Dakar et je suis sénégalais.' Which form entry is correct for the nationality?$mq$, $mq$["Sénégalais","Sénégalaise","Sénégal","Dakar"]$mq$, 0, $mq$Ibrahim is male and says 'sénégalais'. 'Sénégalaise' is feminine, 'Sénégal' is the country and Dakar is the city.$mq$, $mq$hard$mq$),
($mq$Who would you normally address with 'Comment vous appelez-vous ?'$mq$, $mq$["A classmate you know well","Your younger brother","Yourself","An adult you have just met"]$mq$, 3, $mq$'Vous' is the polite form used for adults you do not know well (and also for more than one person).$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Introducing Yourself and Others$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Je m'appelle...$mq$, $mq$My name is... Forms: tu t'appelles, il/elle s'appelle, nous nous appelons, vous vous appelez, ils/elles s'appellent.$mq$),
($mq$J'ai quinze ans.$mq$, $mq$I am fifteen. French uses avoir (to have) for age, never être.$mq$),
($mq$J'habite à... / Je viens de...$mq$, $mq$I live in... / I come from... Use à or de with a town: j'habite à Lyon, je viens de Paris.$mq$),
($mq$Voici... / Je te présente...$mq$, $mq$Here is... / Let me introduce... (to you, informal). Formal: Je vous présente...$mq$),
($mq$Enchanté / Enchantée$mq$, $mq$Pleased to meet you. Add an extra e if the speaker is female.$mq$),
($mq$Nationalities: masculine vs feminine$mq$, $mq$français / française, anglais / anglaise, espagnol / espagnole, canadien / canadienne. belge and suisse do not change.$mq$),
($mq$Où habites-tu ? vs D'où viens-tu ?$mq$, $mq$Where do you live? vs Where do you come from? They can have different answers.$mq$),
($mq$être: present tense$mq$, $mq$je suis, tu es, il/elle est, nous sommes, vous êtes, ils/elles sont.$mq$),
($mq$Why mon amie, not ma amie?$mq$, $mq$Before a feminine noun starting with a vowel sound, French uses mon: mon amie, mon école.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Introducing Yourself and Others$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Saying who you are
In the exam you often have to introduce yourself or understand someone else's introduction. You need a small set of sentence patterns and the right verb forms. Learn the patterns below and you can build dozens of sentences.

## Core patterns
- Je m'appelle Chloé. (My name is Chloé.)
- Je suis anglais / anglaise. (I am English.)
- J'ai quinze ans. (I am fifteen. Age uses avoir, 'to have'.)
- J'habite à Lyon. (I live in Lyon.)
- Je viens de Londres. (I come from London.)
- Voici mon ami Paul. (This is my friend Paul.)
- Je te présente ma sœur. (Let me introduce my sister to you, informal.)
- Je vous présente ma sœur. (formal)
- Enchanté / Enchantée. (Pleased to meet you.)

## Asking the questions
- Tu t'appelles comment ? / Comment t'appelles-tu ? (informal)
- Comment vous appelez-vous ? (formal)
- Où habites-tu ? (Where do you live?)
- D'où viens-tu ? (Where do you come from?)
- Quel âge as-tu ? (How old are you?)
- Quelle est ta nationalité ? (What is your nationality?)

## Verbs you need now
S'appeler: je m'appelle, tu t'appelles, il/elle s'appelle, nous nous appelons, vous vous appelez, ils/elles s'appellent.
Habiter: j'habite, tu habites, il/elle habite, nous habitons, vous habitez, ils/elles habitent.
Être (to be): je suis, tu es, il/elle est, nous sommes, vous êtes, ils/elles sont.

## Nationalities and agreement
Nationalities are adjectives, so they agree with the person. Add -e for a girl: français / française, anglais / anglaise, espagnol / espagnole, allemand / allemande, canadien / canadienne, italien / italienne. Some end in -e already and do not change: belge, suisse. In a sentence there is no capital letter: Il est suisse. Countries do have a capital: la Suisse, la France.

## Using à and de
Use à with a town: J'habite à Paris. Use de or d' with a town to say where you are from: Je viens de Paris, d'Édimbourg. Countries need an article, for example en France, en Belgique, au Maroc, aux États-Unis.

## Introducing others
Use il/elle plus the same patterns: Il s'appelle Noah. Elle a quatorze ans. Elle est belge. Remember mon/ma/mes: mon ami, ma sœur, mes parents. Before a vowel use mon even for feminine words: mon amie.

## Common mistakes
- Je suis quinze ans. French uses avoir for age: J'ai quinze ans.
- Tu t'appelle. The tu form ends in -s.
- Using the masculine nationality for a girl.
- Forgetting the apostrophe: j'habite, d'où, s'appelle.

## How this is examined
You will usually read a short profile, message or email in which a fictional person gives name, age, home town and nationality, and you answer questions or fill in a form. In writing you may need to introduce yourself and a friend in four to six sentences using the patterns above, with correct verbs.

Exam tip: In a profile text, underline each piece of personal information (name, age, town, nationality) and check whether the person is describing themselves or someone else before picking an answer.$mq$ from st;

-- Greetings and Introductions > Numbers, Age and Dates
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Greetings and Introductions$mq$, 5, 1 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Numbers, Age and Dates$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Greetings and Introductions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Numbers, Age and Dates$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What number is 'quinze'?$mq$, $mq$["15","5","50","14"]$mq$, 0, $mq$Quinze is 15. Cinq is 5, cinquante is 50 and quatorze is 14.$mq$, $mq$easy$mq$),
($mq$What does 'J'ai douze ans' mean?$mq$, $mq$["I have twelve brothers","I live at number twelve","I have twelve euros","I am twelve years old"]$mq$, 3, $mq$'Avoir' plus 'ans' gives age: 'J'ai douze ans' means 'I am twelve years old'.$mq$, $mq$easy$mq$),
($mq$Which English month is 'mars'?$mq$, $mq$["May","June","March","July"]$mq$, 2, $mq$'Mars' is March. May is 'mai', June is 'juin' and July is 'juillet'.$mq$, $mq$easy$mq$),
($mq$Which French word means Wednesday?$mq$, $mq$["mardi","mercredi","jeudi","vendredi"]$mq$, 1, $mq$Mercredi is Wednesday. Mardi is Tuesday and jeudi is Thursday.$mq$, $mq$easy$mq$),
($mq$How do you say the number 20 in French?$mq$, $mq$["vingt","dix","trente","douze"]$mq$, 0, $mq$Vingt is 20. Dix is 10, trente is 30 and douze is 12.$mq$, $mq$easy$mq$),
($mq$Someone asks 'Quel âge as-tu ?'. Which answer is correct?$mq$, $mq$["Je suis quinze ans.","Je m'appelle quinze.","Il a quinze ans.","J'ai quinze ans."]$mq$, 3, $mq$Age uses avoir: 'J'ai quinze ans'. 'Il a quinze ans' talks about someone else.$mq$, $mq$medium$mq$),
($mq$How is the number 17 written in French?$mq$, $mq$["sept-dix","dix et sept","dix-sept","soixante-dix"]$mq$, 2, $mq$17 is 'dix-sept' (ten-seven). Soixante-dix is 70.$mq$, $mq$medium$mq$),
($mq$Which is the standard French word for 70?$mq$, $mq$["quatre-vingts","soixante-dix","cinquante-dix","soixante-sept"]$mq$, 1, $mq$In standard French 70 is 'soixante-dix' (sixty-ten). 'Quatre-vingts' is 80.$mq$, $mq$medium$mq$),
($mq$A girl writes: 'Mon anniversaire est le trois avril.' What is the date?$mq$, $mq$["3 April","4 March","3 August","30 April"]$mq$, 0, $mq$'Trois' is 3 and 'avril' is April. August is 'août'.$mq$, $mq$medium$mq$),
($mq$A calendar says 'lundi 14 septembre'. Which month is it?$mq$, $mq$["July","November","December","September"]$mq$, 3, $mq$'Septembre' is September, the ninth month, even though 'sept' also means seven.$mq$, $mq$medium$mq$),
($mq$What is 80 in standard French?$mq$, $mq$["huitante-dix","soixante-vingt","quatre-vingts","vingt-quatre"]$mq$, 2, $mq$80 is 'quatre-vingts' (four twenties). 'Huitante' is used in some parts of Switzerland, not in standard French.$mq$, $mq$medium$mq$),
($mq$A sign on a shop reads: 'Fermé du premier juillet au quinze août.' When is the shop closed?$mq$, $mq$["From June 1 to August 15","From July 1 to August 15","From July 15 to August 1","All of July"]$mq$, 1, $mq$'Premier' is the first, 'juillet' is July, 'quinze' is 15 and 'août' is August. The dates run from 1 July to 15 August.$mq$, $mq$medium$mq$),
($mq$Mon frère a quatorze ans. Ma sœur a trois ans de plus que lui. Quel âge a ma sœur ?$mq$, $mq$["Dix-sept ans","Seize ans","Onze ans","Dix-huit ans"]$mq$, 0, $mq$Fourteen plus three is seventeen, which is 'dix-sept ans'. Eleven would be fourteen minus three.$mq$, $mq$medium$mq$),
($mq$How do you write 91 in French?$mq$, $mq$["soixante-onze","quatre-vingt-un","neuf-dix-un","quatre-vingt-onze"]$mq$, 3, $mq$91 is 'quatre-vingt-onze' (four twenties and eleven). 'Soixante-onze' is 71.$mq$, $mq$hard$mq$),
($mq$Un billet de cinéma coûte soixante-quinze euros pour un groupe. La réduction est de vingt euros. Combien le groupe paie-t-il ?$mq$, $mq$["Quatre-vingt-quinze euros","Soixante-cinq euros","Cinquante-cinq euros","Cinquante euros"]$mq$, 2, $mq$75 minus 20 is 55, which is 'cinquante-cinq'. Ninety-five would be 75 plus 20.$mq$, $mq$hard$mq$),
($mq$Which is the correct way to write the date 5 May in French?$mq$, $mq$["mai le cinq","le cinq mai","le mai cinq","cinq le mai"]$mq$, 1, $mq$French puts the article first, then the day number, then the month: 'le cinq mai'.$mq$, $mq$hard$mq$),
($mq$Which of these number forms is NOT correct?$mq$, $mq$["vingt et deux","vingt et un","vingt-deux","trente et un"]$mq$, 0, $mq$'Et' is used only with 21, 31, 41, 51, 61 and 71 (ending in un or onze). 22 is 'vingt-deux', so 'vingt et deux' is wrong.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'Mon anniversaire, c'est le vingt-deux décembre. J'ai seize ans. Ma sœur est née le vingt-sept décembre.' How many days after the speaker's birthday is the sister's birthday?$mq$, $mq$["Seven","Four","Twenty-seven","Five"]$mq$, 3, $mq$27 minus 22 is 5, so her birthday is five days later. The speaker's age (16) is not needed.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Numbers, Age and Dates$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$11 to 16$mq$, $mq$onze, douze, treize, quatorze, quinze, seize.$mq$),
($mq$17, 18, 19$mq$, $mq$dix-sept, dix-huit, dix-neuf.$mq$),
($mq$20, 30, 40, 50, 60$mq$, $mq$vingt, trente, quarante, cinquante, soixante.$mq$),
($mq$70, 80, 90$mq$, $mq$soixante-dix, quatre-vingts, quatre-vingt-dix. French counts in twenties from 80.$mq$),
($mq$When is 'et' used in numbers?$mq$, $mq$Only with 21, 31, 41, 51, 61 and 71: vingt et un, soixante et onze. Not 22, 23 and so on: vingt-deux.$mq$),
($mq$How do you say your age?$mq$, $mq$J'ai quinze ans. Use avoir (to have), never être, and always include 'ans'.$mq$),
($mq$Days of the week$mq$, $mq$lundi, mardi, mercredi, jeudi, vendredi, samedi, dimanche. Written without a capital letter.$mq$),
($mq$Months of the year$mq$, $mq$janvier, février, mars, avril, mai, juin, juillet, août, septembre, octobre, novembre, décembre.$mq$),
($mq$How to say a date$mq$, $mq$le + day + month: le vingt-deux décembre. The first is le premier: le premier mai.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Numbers, Age and Dates$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why numbers matter
Numbers appear everywhere in the eAssessment: ages, prices, phone numbers, times, dates and addresses. Hearing or reading a number wrongly can make you miss an answer, so learn them thoroughly.

## Numbers
- 0 zéro, 1 un, 2 deux, 3 trois, 4 quatre, 5 cinq, 6 six, 7 sept, 8 huit, 9 neuf, 10 dix
- 11 onze, 12 douze, 13 treize, 14 quatorze, 15 quinze, 16 seize
- 17 dix-sept, 18 dix-huit, 19 dix-neuf
- 20 vingt, 30 trente, 40 quarante, 50 cinquante, 60 soixante
- 21 vingt et un, 22 vingt-deux, 31 trente et un, 32 trente-deux
- 70 soixante-dix, 71 soixante et onze, 72 soixante-douze
- 80 quatre-vingts, 81 quatre-vingt-un, 90 quatre-vingt-dix, 91 quatre-vingt-onze
- 100 cent, 1000 mille

The patterns: from 17 on you say ten-seven, ten-eight and so on. From 70 French counts in twenties: soixante-dix is sixty-ten, and 80 is quatre-vingts, four-twenties. 'Et' appears only in 21, 31, 41, 51, 61 and 71.

## Age
French uses avoir for age.
- Quel âge as-tu ? (How old are you?)
- J'ai quinze ans. (I am fifteen.)
- Il a douze ans. Elle a seize ans.
Never say 'Je suis quinze ans'. The word ans (years) must be included.

## Days and months
Days (no capital letters): lundi, mardi, mercredi, jeudi, vendredi, samedi, dimanche.
Months (no capital letters): janvier, février, mars, avril, mai, juin, juillet, août, septembre, octobre, novembre, décembre.
Be careful with mars (March) and mai (May), and with juin and juillet.

## Dates
- Quelle est la date aujourd'hui ? (What is the date today?)
- C'est le quatorze septembre. (It's 14 September.)
- Mon anniversaire est le vingt-deux décembre. (My birthday is on 22 December.)
The order is le + day + month. For the first of the month use le premier: le premier mai. Other days use ordinary numbers. A weekday can go in front: lundi 14 septembre.

## Worked example
Mon frère a quatorze ans. Ma sœur a trois ans de plus. 14 + 3 = 17, so ma sœur a dix-sept ans. Always do the sum in numerals first, then write the French word.

## Common mistakes
- Confusing sept (7) with septembre (September, the ninth month).
- Writing 70 as 'septante' (this is used in Belgium and Switzerland but not in standard French).
- Adding 'et' to 22, 23 and so on.
- Putting the month before the day.
- Forgetting accents in février, août and décembre.

## How this is examined
In listening and reading tasks numbers are hidden in contexts: a train departure, a shop price, a birthday invitation, an opening time sign. Questions often need a short calculation, such as a total, a difference or a time. In writing you may give your age and birthday or invite a friend on a date.

Exam tip: In a listening transcript, jot each number as digits as you hear it, then check which one the question asks for. Writers often include two similar numbers, such as 15 and 50, on purpose.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;