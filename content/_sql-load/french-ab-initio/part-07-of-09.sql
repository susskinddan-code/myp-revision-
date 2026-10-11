-- Part 7 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Free Time and Health > Hobbies and Sports
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Free Time and Health$mq$, 5, 7 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Hobbies and Sports$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Free Time and Health$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Hobbies and Sports$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'J'aime nager' mean?$mq$, $mq$["I like swimming","I like sailing","I am swimming now","I do not like swimming"]$mq$, 0, $mq$'J'aime' = I like, and 'nager' = to swim. After 'j'aime' French uses the infinitive.$mq$, $mq$easy$mq$),
($mq$Which sentence means 'I play football'?$mq$, $mq$["Je joue du football.","Je fais au football.","Je jouer football.","Je joue au football."]$mq$, 3, $mq$Sports use 'jouer à' (au = à + le), so 'Je joue au football'. 'Jouer de' is for musical instruments.$mq$, $mq$easy$mq$),
($mq$Which sentence means 'I play the guitar'?$mq$, $mq$["Je joue à la guitare.","Je fais de la guitare.","Je joue de la guitare.","Je joue la guitare."]$mq$, 2, $mq$Instruments take 'jouer de': de la guitare, du piano, de la batterie.$mq$, $mq$easy$mq$),
($mq$Marie writes: 'Le samedi, je regarde la télé.' What does she do on Saturdays?$mq$, $mq$["Reads the news","Watches TV","Listens to the radio","Plays video games"]$mq$, 1, $mq$'Regarder la télé' = to watch TV. 'Le samedi' means on Saturdays (every Saturday).$mq$, $mq$easy$mq$),
($mq$Which word means 'rarely'?$mq$, $mq$["rarement","souvent","toujours","parfois"]$mq$, 0, $mq$'Rarement' = rarely. 'Souvent' = often, 'toujours' = always, 'parfois' = sometimes.$mq$, $mq$easy$mq$),
($mq$Choose the correct completion: 'Ma sœur ___ de la danse le mardi.'$mq$, $mq$["joue","fais","font","fait"]$mq$, 3, $mq$'Faire de la danse' is the expression for dancing as an activity. With 'ma sœur' (she), the verb is 'fait'.$mq$, $mq$medium$mq$),
($mq$Read the message: 'Salut ! Je m'appelle Hugo. J'adore le basket mais je déteste la natation. Je joue au basket tous les samedis.' How often does Hugo play basketball?$mq$, $mq$["Every day","Every weekend, Saturday and Sunday","Every Saturday","Once a month"]$mq$, 2, $mq$'Tous les samedis' means every Saturday. He loves basketball and hates swimming.$mq$, $mq$medium$mq$),
($mq$Which phrase correctly says 'I do cycling'?$mq$, $mq$["Je fais le vélo.","Je fais du vélo.","Je joue au vélo.","Je fais de vélo."]$mq$, 1, $mq$'Faire du vélo' uses du (de + le) because 'vélo' is masculine.$mq$, $mq$medium$mq$),
($mq$Léa says: 'Je n'aime pas lire, je préfère écouter de la musique.' Which statement is true?$mq$, $mq$["She prefers listening to music to reading.","She likes reading more than music.","She likes both equally.","She plays an instrument."]$mq$, 0, $mq$'Je n'aime pas lire' = I do not like reading; 'je préfère' = I prefer.$mq$, $mq$medium$mq$),
($mq$Which is the best French for 'I go to the cinema with my friends on Fridays'?$mq$, $mq$["Le vendredi, je vais à cinéma avec mes amis.","Le vendredi, je joue au cinéma avec mes amis.","Le vendredi, je vas au cinéma avec mes amis.","Le vendredi, je vais au cinéma avec mes amis."]$mq$, 3, $mq$'Aller' = je vais, and à + le = au, giving 'au cinéma'. 'Je vas' is not a French form.$mq$, $mq$medium$mq$),
($mq$Which sentence means 'He plays the piano and plays tennis'?$mq$, $mq$["Il joue au piano et il joue du tennis.","Il joue du piano et il fait au tennis.","Il joue du piano et il joue au tennis.","Il joue le piano et le tennis."]$mq$, 2, $mq$Instrument = jouer de (du piano); sport = jouer à (au tennis). The other options swap the prepositions.$mq$, $mq$medium$mq$),
($mq$Notice on a club board: 'Atelier théâtre : mercredi, 14 h – 16 h. Pas de cours en juillet.' What is the information?$mq$, $mq$["The drama workshop is on Wednesday mornings and in July.","The drama workshop is on Wednesday afternoons and not in July.","The dance class is on Tuesday afternoons.","The drama workshop is every day except July."]$mq$, 1, $mq$'Atelier théâtre' = drama workshop; 14 h–16 h is afternoon; 'pas de cours en juillet' = no classes in July.$mq$, $mq$medium$mq$),
($mq$Which word completes: 'Nous ___ du ski en hiver.'$mq$, $mq$["faisons","faites","font","fais"]$mq$, 0, $mq$With 'nous' the verb 'faire' is 'faisons'. 'Faire du ski' = to go skiing.$mq$, $mq$medium$mq$),
($mq$Karim writes: 'Je ne joue jamais au golf, mais je fais souvent de la natation.' Which summary is correct?$mq$, $mq$["He often plays golf but never swims.","He plays golf sometimes and swims rarely.","He never swims and never plays golf.","He never plays golf but often swims."]$mq$, 3, $mq$'Ne ... jamais' = never; 'souvent' = often. Pay attention to which activity each word is attached to.$mq$, $mq$hard$mq$),
($mq$Which sentence is entirely correct?$mq$, $mq$["Elle aime jouer à la flûte et faire de l'escalade.","Elle aime joue de la flûte et faire de l'escalade.","Elle aime jouer de la flûte et faire de l'escalade.","Elle aime jouer de la flûte et faire d'escalade."]$mq$, 2, $mq$The infinitive follows 'aime', 'jouer de' goes with instruments, and 'de l'' is used before a vowel (escalade).$mq$, $mq$hard$mq$),
($mq$A text says: 'Après l'école, Thomas fait ses devoirs, puis il joue à des jeux vidéo. Le soir il lit un peu.' What is the order of his activities?$mq$, $mq$["Video games, homework, reading","Homework, video games, reading","Reading, homework, video games","Homework, reading, video games"]$mq$, 1, $mq$'Puis' (then) and 'le soir' (in the evening) give the sequence: homework, then video games, then reading.$mq$, $mq$hard$mq$),
($mq$Which sentence expresses a preference AND a reason correctly?$mq$, $mq$["Je préfère le judo parce que c'est dynamique.","Je préfère le judo parce que c'est dynamiques.","Je préfère judo car dynamique est.","Je préfère le judo parce que il dynamique."]$mq$, 0, $mq$'Parce que' introduces a reason followed by a full clause: 'c'est dynamique'. The adjective stays singular after 'c'est'.$mq$, $mq$hard$mq$),
($mq$You want to invite a friend (informal) to play tennis on Sunday. Which message is best?$mq$, $mq$["Voulez-vous jouer du tennis dimanche ?","Tu veux jouer au tennis le dimanches ?","Tu veux faire au tennis dimanche ?","Tu veux jouer au tennis dimanche ?"]$mq$, 3, $mq$'Tu veux' is informal, 'jouer au tennis' is correct, and 'dimanche' alone means this coming Sunday. 'Voulez-vous' is formal and 'du tennis' is wrong.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Hobbies and Sports$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$jouer à vs jouer de$mq$, $mq$Sports and games: jouer à (je joue au tennis). Musical instruments: jouer de (je joue de la guitare).$mq$),
($mq$j'aime / j'adore / je déteste$mq$, $mq$I like / I love / I hate. They are followed by an infinitive: J'aime nager.$mq$),
($mq$faire du vélo$mq$, $mq$to cycle. Faire de + activity: du (masc.), de la (fem.), de l' (vowel), des (plural).$mq$),
($mq$tous les samedis$mq$, $mq$every Saturday. Also: le samedi (on Saturdays), le week-end (at weekends).$mq$),
($mq$souvent / parfois / rarement / jamais$mq$, $mq$often / sometimes / rarely / never. Never is ne ... jamais: Je ne joue jamais au golf.$mq$),
($mq$regarder la télé$mq$, $mq$to watch TV$mq$),
($mq$Je préfère le judo parce que c'est amusant.$mq$, $mq$I prefer judo because it is fun. 'Parce que' introduces a reason.$mq$),
($mq$au / à la / à l' / aux$mq$, $mq$to the / to the / to the / to the (plural). au = à + le; aux = à + les. Je joue au football, aux cartes.$mq$),
($mq$Tu veux jouer au tennis ?$mq$, $mq$Do you want to play tennis? An informal invitation to a friend.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Hobbies and Sports$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why this matters
Talking about what you like to do is one of the most common topics in beginner French. You will meet it in reading texts (messages, club notices, profiles), in listening texts (someone describing their weekend) and in writing tasks (a short email to a penpal). The grammar is small, but examiners reward accuracy with the little words: au, du, de la.

## Expressing likes and dislikes
After these verbs, use the infinitive (the "to ..." form):
- j'aime (I like) / j'adore (I love) / je préfère (I prefer) / je déteste (I hate)
- Example: J'aime nager. (I like swimming.) Je déteste courir. (I hate running.)
- To make it negative put ne ... pas around the first verb: Je n'aime pas lire. (I do not like reading.)

## Jouer à or jouer de?
This is the most tested point in the topic.
- Sports and games use jouer à: Je joue au football (à + le = au), Elle joue à la pétanque, Nous jouons aux cartes (à + les = aux).
- Musical instruments use jouer de: Il joue de la guitare, Je joue du piano (de + le = du), Elles jouent des percussions.

## Faire de
Many activities use faire + de:
- faire du sport (to do sport), faire du vélo (to cycle), faire du judo, faire de la natation (to swim), faire de la danse, faire de l'escalade (de l' before a vowel).
- Remember: de + le = du, de + les = des, de + la stays de la.

## Other useful verbs and phrases
- lire (to read), écouter de la musique (to listen to music), regarder la télé (to watch TV), aller au cinéma (to go to the cinema), sortir avec mes amis (to go out with my friends), dessiner (to draw), cuisiner (to cook), se promener (to go for a walk)
- les jeux vidéo (video games), un club (a club), un match (a match), une équipe (a team)

## How often?
- toujours (always), souvent (often), parfois / quelquefois (sometimes), rarement (rarely), ne ... jamais (never)
- le samedi or tous les samedis (every Saturday), le week-end (at weekends), après l'école (after school)
- Put the frequency word after the verb: Je joue souvent au tennis. Je ne joue jamais au golf.

## Giving a reason
Use parce que (because): J'aime le judo parce que c'est amusant. Useful adjectives: amusant (fun), intéressant (interesting), ennuyeux (boring), fatigant (tiring), difficile (difficult), facile (easy).

## Worked example
Salut ! Je m'appelle Hugo. J'adore le basket et je joue tous les samedis. Je déteste la natation, c'est ennuyeux. Et toi ?
Meaning: Hi! I'm Hugo. I love basketball and I play every Saturday. I hate swimming, it is boring. And you?

## Common mistakes
- Using jouer de with a sport (wrong: je joue du football).
- Forgetting the article contraction (wrong: je joue à le tennis; right: au tennis).
- Using a conjugated verb after aime (wrong: j'aime je nage).
- Putting jamais without ne.

## How this is examined
Reading tasks give a short message or club notice and ask who does what, when, and how often. Listening transcripts describe a weekend and ask you to match a person to an activity. In writing you are asked to describe your hobbies, give one opinion with a reason and say how often you do something.

Exam tip: Underline the frequency word (souvent, jamais, tous les ...) in a text before answering, because the question is often about how often, not just what.$mq$ from st;

-- Free Time and Health > Weather and Seasons
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Free Time and Health$mq$, 5, 7 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Weather and Seasons$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Free Time and Health$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Weather and Seasons$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'Il pleut' mean?$mq$, $mq$["It is raining","It is snowing","It is windy","It is sunny"]$mq$, 0, $mq$'Il pleut' comes from the verb pleuvoir (to rain).$mq$, $mq$easy$mq$),
($mq$Which phrase means 'It is cold'?$mq$, $mq$["Il fait chaud.","Il fait beau.","Il neige.","Il fait froid."]$mq$, 3, $mq$'Il fait froid' = it is cold. 'Il fait chaud' means it is hot.$mq$, $mq$easy$mq$),
($mq$Which season is 'l'été'?$mq$, $mq$["Spring","Autumn","Summer","Winter"]$mq$, 2, $mq$L'été = summer; le printemps = spring; l'automne = autumn; l'hiver = winter.$mq$, $mq$easy$mq$),
($mq$What does 'Il y a du soleil' tell you?$mq$, $mq$["It is foggy","It is sunny","It is stormy","It is cloudy"]$mq$, 1, $mq$'Du soleil' means sun, so the weather is sunny.$mq$, $mq$easy$mq$),
($mq$Which month is 'juillet'?$mq$, $mq$["July","June","January","August"]$mq$, 0, $mq$Juillet = July; juin = June; janvier = January; août = August.$mq$, $mq$easy$mq$),
($mq$Read: 'À Lyon, il fait 28 degrés et il y a du soleil.' What is the weather?$mq$, $mq$["Cold and sunny","Warm and rainy","Hot and cloudy","Hot and sunny"]$mq$, 3, $mq$28 degrees is hot, and 'du soleil' means sunny.$mq$, $mq$medium$mq$),
($mq$What is the correct way to ask 'What is the weather like today?'$mq$, $mq$["Quelle heure est-il aujourd'hui ?","Comment vas-tu aujourd'hui ?","Quel temps fait-il aujourd'hui ?","Qu'est-ce que tu fais aujourd'hui ?"]$mq$, 2, $mq$'Quel temps fait-il ?' asks about the weather. 'Quelle heure est-il ?' asks for the time.$mq$, $mq$medium$mq$),
($mq$Which sentence is correct for 'In spring it is often windy'?$mq$, $mq$["En printemps, il y a souvent du vent.","Au printemps, il y a souvent du vent.","Au printemps, il fait souvent vent.","Au printemps, il est souvent du vent."]$mq$, 1, $mq$Use 'au' with printemps and 'il y a du vent' for windy. 'En' is used with été, automne, hiver.$mq$, $mq$medium$mq$),
($mq$Which preposition goes with 'hiver' in 'In winter, it snows'?$mq$, $mq$["En hiver, il neige.","Au hiver, il neige.","À l'hiver, il neige.","Dans hiver, il neige."]$mq$, 0, $mq$Seasons beginning with a vowel use 'en': en été, en automne, en hiver. Only 'printemps' takes 'au'.$mq$, $mq$medium$mq$),
($mq$Forecast: 'Demain, il pleut le matin, puis il y a du soleil l'après-midi.' What is true?$mq$, $mq$["Sun in the morning, rain in the afternoon","Rain all day","Sun all day","Rain in the morning, sun in the afternoon"]$mq$, 3, $mq$'Le matin' = morning, 'l'après-midi' = afternoon. 'Puis' (then) gives the order.$mq$, $mq$medium$mq$),
($mq$Choose the correct date: 'My birthday is on 14 February.'$mq$, $mq$["Mon anniversaire est le février quatorze.","Mon anniversaire est quatorze de février.","Mon anniversaire est le quatorze février.","Mon anniversaire est au quatorze février."]$mq$, 2, $mq$French gives the day first with 'le': le quatorze février. No 'of' is used.$mq$, $mq$medium$mq$),
($mq$Lucas says: 'Je n'aime pas l'hiver, il fait trop froid. Je préfère l'été.' Which is true?$mq$, $mq$["He prefers winter because it is cold.","He prefers summer because winter is too cold.","He prefers summer because it rains.","He dislikes all seasons."]$mq$, 1, $mq$'Trop froid' = too cold; 'je préfère l'été' = I prefer summer.$mq$, $mq$medium$mq$),
($mq$Which sentence is wrong?$mq$, $mq$["Il fait pleut aujourd'hui.","Il pleut aujourd'hui.","Il fait beau aujourd'hui.","Il neige aujourd'hui."]$mq$, 0, $mq$'Il pleut' is already a full verb, so 'il fait' must not be added. 'Il fait beau' is correct because 'faire' is used with beau, chaud and froid.$mq$, $mq$medium$mq$),
($mq$A postcard says: 'En août, il fait très chaud ici, mais en décembre il neige et il fait moins deux.' What does 'moins deux' mean?$mq$, $mq$["two degrees above zero","twenty degrees","less than two hours","minus two degrees"]$mq$, 3, $mq$'Moins' before a number means minus, so it is −2 °C in December.$mq$, $mq$hard$mq$),
($mq$Which statement matches this forecast: 'Mardi : nuageux, 12°. Mercredi : pluie, 9°. Jeudi : soleil, 15°.'?$mq$, $mq$["Tuesday will be the warmest day.","It will rain on Thursday.","Thursday will be the warmest and sunniest day.","Wednesday will be sunny and mild."]$mq$, 2, $mq$Jeudi has soleil and the highest temperature, 15°. Mercredi has pluie and the lowest.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly combines a season and a weather description?$mq$, $mq$["En automne, il pleut souvent et il fait fraise.","En automne, il pleut souvent et il fait frais.","À automne, il pleut souvent et il est frais.","En l'automne, il pleut souvent et il fait frais."]$mq$, 1, $mq$'En automne' is correct, 'il pleut' is full on its own, and 'il fait frais' means it is cool. 'Fraise' is a strawberry.$mq$, $mq$hard$mq$),
($mq$Mia has only learnt the present tense. Which sentence correctly tells a penpal that it is sunny today?$mq$, $mq$["Aujourd'hui, il y a du soleil.","Hier, il fait soleil.","Aujourd'hui, il est soleil.","Aujourd'hui, il y a des soleils."]$mq$, 0, $mq$In the exam stick to forms you control. 'Il y a du soleil' is correct and clear; 'il est soleil' is not French and 'hier' needs a past tense.$mq$, $mq$hard$mq$),
($mq$Which reply best answers: 'Quel temps fait-il en été chez toi et qu'est-ce que tu fais ?'$mq$, $mq$["En été, je fais chaud et il nage à la piscine.","En été, il chaud fait et je nager.","En été, il est chaud et je nager à la piscine.","En été, il fait chaud et je nage à la piscine."]$mq$, 3, $mq$The weather uses 'il fait chaud'; the activity uses 'je' + a conjugated verb (nage). The others have the wrong subject or word order.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Weather and Seasons$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Quel temps fait-il ?$mq$, $mq$What is the weather like? Typical answers: Il fait beau / Il pleut / Il neige.$mq$),
($mq$Il fait chaud / froid / frais$mq$, $mq$It is hot / cold / cool. These use 'faire'.$mq$),
($mq$Il pleut / Il neige$mq$, $mq$It is raining / It is snowing. Never add 'fait' before these verbs.$mq$),
($mq$Il y a du soleil / du vent / du brouillard$mq$, $mq$It is sunny / windy / foggy. Weather with 'il y a' + du, de la, des or de l'.$mq$),
($mq$au printemps / en été / en automne / en hiver$mq$, $mq$in spring / in summer / in autumn / in winter. Only 'printemps' takes 'au'.$mq$),
($mq$Il fait moins deux.$mq$, $mq$It is minus two (degrees). 'Moins' means minus.$mq$),
($mq$le quatorze février$mq$, $mq$14 February. Dates: le + number + month. The first of the month is 'le premier'.$mq$),
($mq$la météo$mq$, $mq$the weather forecast$mq$),
($mq$Je préfère l'été parce qu'il fait chaud.$mq$, $mq$I prefer summer because it is hot. A preference plus a reason with 'parce que'.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Weather and Seasons$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why this matters
Weather and seasons turn up in forecasts, postcards, penpal emails and listening texts. Because they are short, set phrases, they are an easy place to gain marks if you learn them exactly. The biggest trap is the verb: French uses faire (to do/make) for many weather expressions where English uses "to be".

## Asking about the weather
- Quel temps fait-il ? (What is the weather like?)
- Il fait quel temps aujourd'hui ? (informal)

## Weather phrases
With il fait:
- Il fait beau. (It is nice weather.)
- Il fait chaud. (It is hot.)
- Il fait froid. (It is cold.)
- Il fait frais. (It is cool.)
- Il fait mauvais. (It is bad weather.)
- Il fait du vent. (It is windy.) Il y a du vent also works.
With il y a:
- Il y a du soleil. (It is sunny.)
- Il y a des nuages. (It is cloudy.) The adjective nuageux also exists.
- Il y a de l'orage. (There is a storm.)
- Il y a du brouillard. (It is foggy.)
With a verb of its own (do NOT add il fait):
- Il pleut. (It is raining.)
- Il neige. (It is snowing.)

## Temperature
- Il fait vingt degrés. (It is twenty degrees.)
- Il fait moins cinq. (It is minus five.)
- la température (the temperature), la météo (the weather forecast)

## Seasons
- le printemps (spring) - au printemps
- l'été (summer) - en été
- l'automne (autumn) - en automne
- l'hiver (winter) - en hiver
Only printemps takes au. The other three take en.

## Months and dates
- janvier, février, mars, avril, mai, juin, juillet, août, septembre, octobre, novembre, décembre (months are not capitalised)
- Dates use le + number + month: le quatorze février (14 February); only the first of the month uses premier: le premier mai.
- en juillet or au mois de juillet = in July

## Time words for forecasts
- aujourd'hui (today), demain (tomorrow), le matin (in the morning), l'après-midi (in the afternoon), le soir (in the evening), puis (then), mais (but)

## Worked example
Forecast: Demain, à Nice, il fait beau le matin, mais il y a des nuages l'après-midi. Il fait vingt-deux degrés.
Meaning: Tomorrow in Nice it is nice in the morning, but it is cloudy in the afternoon. It is 22 degrees.

## Giving preferences
J'aime l'été parce qu'il fait chaud. Je préfère le printemps parce qu'il y a du soleil et il ne fait pas trop chaud.

## Common mistakes
- Saying il fait pleut or il fait neige (wrong: il pleut, il neige).
- Using je (I) or est (is): wrong je fais chaud for a general weather statement, wrong il est chaud.
- Using au with été, automne, hiver (wrong: au hiver).
- Capitalising months or writing the date as février quatorze.

## How this is examined
Typical reading tasks give a short forecast or postcard and ask which weather happens at which time or place. In listening transcripts, numbers and time words matter. In writing, you may describe your favourite season with a reason and one activity.

Exam tip: In a forecast, match each weather phrase with its time word (le matin, l'après-midi, demain) and watch for mais (but), which signals a change.$mq$ from st;

-- Free Time and Health > Health and the Body
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Free Time and Health$mq$, 5, 7 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Health and the Body$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Free Time and Health$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Health and the Body$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'la tête' mean?$mq$, $mq$["the head","the hand","the leg","the stomach"]$mq$, 0, $mq$La tête = head; la main = hand; la jambe = leg; le ventre = stomach.$mq$, $mq$easy$mq$),
($mq$Which phrase means 'I have a headache'?$mq$, $mq$["Je suis mal à la tête.","Je fais mal à la tête.","J'ai mal la tête.","J'ai mal à la tête."]$mq$, 3, $mq$The structure is 'avoir mal à' + body part: J'ai mal à la tête.$mq$, $mq$easy$mq$),
($mq$What does 'le médecin' mean?$mq$, $mq$["the dentist","the chemist","the doctor","the nurse"]$mq$, 2, $mq$Le médecin = doctor; le dentiste = dentist; le pharmacien = chemist (pharmacist); l'infirmier/l'infirmière = nurse.$mq$, $mq$easy$mq$),
($mq$Which body part is 'le pied'?$mq$, $mq$["finger","foot","knee","arm"]$mq$, 1, $mq$Le pied = foot. Le doigt = finger; le genou = knee; le bras = arm.$mq$, $mq$easy$mq$),
($mq$What does 'Je suis malade' mean?$mq$, $mq$["I am ill","I am hungry","I am tired","I am late"]$mq$, 0, $mq$'Malade' = ill, sick. J'ai faim = I am hungry; je suis fatigué(e) = I am tired.$mq$, $mq$easy$mq$),
($mq$Which sentence means 'My arm hurts'?$mq$, $mq$["J'ai mal à la bras.","J'ai mal du bras.","Je mal au bras.","J'ai mal au bras."]$mq$, 3, $mq$Bras is masculine, so à + le = au: J'ai mal au bras.$mq$, $mq$medium$mq$),
($mq$Choose the correct form: 'J'ai mal ___ pieds.'$mq$, $mq$["au","à la","aux","à l'"]$mq$, 2, $mq$'Pieds' is plural, so à + les = aux: J'ai mal aux pieds.$mq$, $mq$medium$mq$),
($mq$At the pharmacy, a note says: 'Prenez deux comprimés le matin et un le soir.' How many tablets in a day?$mq$, $mq$["Two","Three","One","Four"]$mq$, 1, $mq$Two in the morning plus one in the evening makes three tablets.$mq$, $mq$medium$mq$),
($mq$Read: 'Salut Anna, je ne vais pas à l'école aujourd'hui. J'ai de la fièvre et mal à la gorge.' What symptoms does the writer have?$mq$, $mq$["A temperature and a sore throat","A cold and a headache","A broken leg","A stomach ache and a cough"]$mq$, 0, $mq$'De la fièvre' = a fever/temperature; 'la gorge' = throat.$mq$, $mq$medium$mq$),
($mq$Which advice means 'You must rest'?$mq$, $mq$["Tu dois courir.","Tu dois manger plus de sucre.","Tu dois aller à l'école.","Tu dois te reposer."]$mq$, 3, $mq$'Devoir' = must; 'se reposer' = to rest. Tu dois te reposer = You must rest.$mq$, $mq$medium$mq$),
($mq$Which sentence recommends something healthy?$mq$, $mq$["Il faut jouer toute la nuit.","Il faut manger des bonbons.","Il faut boire de l'eau et dormir huit heures.","Il ne faut jamais faire de sport."]$mq$, 2, $mq$'Il faut' = one must. Drinking water and sleeping are healthy habits.$mq$, $mq$medium$mq$),
($mq$Which sentence is correct for 'She has a stomach ache'?$mq$, $mq$["Elle est mal au ventre.","Elle a mal au ventre.","Elle a mal à le ventre.","Elle a mal de ventre."]$mq$, 1, $mq$'Avoir mal à' + body part, with à + le = au: Elle a mal au ventre.$mq$, $mq$medium$mq$),
($mq$A doctor says: 'Ça fait mal quand je touche ici ?' Which would be an appropriate patient reply?$mq$, $mq$["Oui, ça fait mal.","Oui, il pleut.","Non, je suis content.","Oui, j'ai quinze ans."]$mq$, 0, $mq$The question asks whether it hurts when touched; 'Oui, ça fait mal' answers it.$mq$, $mq$medium$mq$),
($mq$Which sentence has an error?$mq$, $mq$["Il a mal aux dents.","Il a mal à la dent.","Il a mal au dos.","Il a mal à les dents."]$mq$, 3, $mq$à + les must become aux: 'Il a mal aux dents'. The other three are correct.$mq$, $mq$hard$mq$),
($mq$Tom writes: 'Hier j'ai joué au foot et maintenant j'ai mal aux jambes, mais je n'ai pas mal au dos.' Which statement is correct?$mq$, $mq$["His back hurts but his legs do not.","Both his legs and back hurt.","His legs hurt but his back does not.","Nothing hurts."]$mq$, 2, $mq$'Mais' marks a contrast; 'je n'ai pas mal au dos' = my back does not hurt.$mq$, $mq$hard$mq$),
($mq$Which sentence gives the best health advice for someone with a cold?$mq$, $mq$["Va nager dans la mer en hiver.","Reste à la maison, bois du thé chaud et repose-toi.","Mange beaucoup de glace.","Joue au football sous la pluie."]$mq$, 1, $mq$Staying home, drinking hot drinks and resting is sensible. The other options would make a cold worse.$mq$, $mq$hard$mq$),
($mq$What is the best response to a pharmacist who asks 'Qu'est-ce qui ne va pas ?'$mq$, $mq$["J'ai mal à la gorge et je tousse.","Je vais à la gorge et je tousse.","Je suis mal gorge et tousser.","Gorge est mal et je toussent."]$mq$, 0, $mq$'Qu'est-ce qui ne va pas ?' = What is wrong? A correct reply uses 'j'ai mal à' + body part and a conjugated verb (je tousse = I cough).$mq$, $mq$hard$mq$),
($mq$Which pair of sentences correctly describes feelings and a body part?$mq$, $mq$["Je suis fatigué et je suis mal à la tête.","J'ai fatigué et j'ai mal la tête.","Je suis fatigué et ai mal à tête.","Je suis fatigué et j'ai mal à la tête."]$mq$, 3, $mq$'Être fatigué' for feelings, and 'avoir mal à la tête' for pain. Do not mix être and avoir in these expressions.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Health and the Body$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$J'ai mal à la tête.$mq$, $mq$I have a headache. Pattern: avoir mal à + body part.$mq$),
($mq$au / à la / à l' / aux$mq$, $mq$j'ai mal au dos, à la gorge, à l'oreille, aux pieds. au = à + le, aux = à + les.$mq$),
($mq$le ventre / le dos / le genou$mq$, $mq$stomach / back / knee$mq$),
($mq$la jambe / le pied / la main$mq$, $mq$leg / foot / hand$mq$),
($mq$Je suis malade.$mq$, $mq$I am ill. Feminine writer: malade stays the same; fatigué becomes fatiguée.$mq$),
($mq$J'ai de la fièvre.$mq$, $mq$I have a temperature (fever).$mq$),
($mq$Il faut + infinitive$mq$, $mq$One must ...: Il faut boire de l'eau. Negative: Il ne faut pas fumer.$mq$),
($mq$le médecin / le pharmacien / l'infirmière$mq$, $mq$doctor / chemist (pharmacist) / nurse$mq$),
($mq$Qu'est-ce qui ne va pas ?$mq$, $mq$What is wrong? A doctor's or pharmacist's question; answer with J'ai mal à ...$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Health and the Body$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why this matters
Health vocabulary appears in appointment dialogues, pharmacy notices and messages explaining why someone is absent. The vocabulary is a fixed list of body parts, so it is very learnable, and one grammar rule (avoir mal à) unlocks most of the topic.

## Parts of the body
- la tête (head), le visage (face), l'œil / les yeux (eye / eyes), le nez (nose), la bouche (mouth), l'oreille (ear), la dent / les dents (tooth / teeth), la gorge (throat)
- le cou (neck), l'épaule (shoulder), le bras (arm), la main (hand), le doigt (finger)
- le dos (back), le ventre (stomach, tummy), le cœur (heart)
- la jambe (leg), le genou (knee), le pied (foot)

## Saying something hurts
Use avoir mal à + body part. The à changes with the noun:
- J'ai mal à la tête. (la = feminine, so à la)
- J'ai mal au dos. (à + le = au)
- J'ai mal à l'oreille. (vowel, so à l')
- J'ai mal aux pieds. (à + les = aux)
Other ways: Ça fait mal. (It hurts.) Mon bras me fait mal. (My arm hurts.)

## Saying how you feel
- Je suis malade. (I am ill.) Je suis fatigué(e). (I am tired.) Je suis enrhumé(e). (I have a cold.)
- J'ai de la fièvre. (I have a temperature.) J'ai froid. (I am cold.) J'ai faim / soif. (I am hungry / thirsty.)
- Je tousse. (I cough.) Je ne me sens pas bien. (I do not feel well.)

## People and places
- le médecin / le docteur (doctor), l'infirmier / l'infirmière (nurse), le dentiste (dentist), le pharmacien / la pharmacienne (chemist)
- la pharmacie (pharmacy), l'hôpital (hospital), un rendez-vous (appointment), une ordonnance (prescription), un médicament (medicine), un comprimé (tablet)

## Giving advice
- Il faut + infinitive (One must ...): Il faut boire de l'eau. Il faut dormir.
- Tu dois / Vous devez + infinitive (You must ...): Tu dois te reposer.
- Il ne faut pas + infinitive (You must not): Il ne faut pas fumer.
- Healthy lifestyle: manger des fruits et des légumes, boire de l'eau, faire du sport, dormir huit heures, se laver les mains.

## Worked example
Dialogue at the doctor:
- Qu'est-ce qui ne va pas ? (What is wrong?)
- J'ai mal à la gorge et j'ai de la fièvre depuis hier. (I have a sore throat and a temperature since yesterday.)
- Vous devez rester à la maison et boire beaucoup d'eau. (You must stay at home and drink lots of water.)

## Common mistakes
- Writing à le or à les (wrong); always contract to au or aux.
- Using être instead of avoir in the pain expression (wrong: je suis mal à la tête).
- Forgetting the feminine -e on fatiguée or malade when a girl writes.
- Mixing up le pied (foot) with la main (hand), or forgetting that genou (knee) takes -x in the plural: les genoux.

## How this is examined
Expect a short note or dialogue where you pick out the symptom, the body part, the advice or the appointment time. Distractors often change one detail, such as arm for leg or morning for evening. Writing tasks may ask you to message a teacher to explain why you are absent.

Exam tip: Do not translate "mal" as "bad" in your head. In this topic it means pain, and avoir mal à + body part is the pattern to follow every time.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;