-- Part 9 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- eAssessment Skills for Languages > Reading Comprehension Strategies
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Languages$mq$, 5, 9 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Reading Comprehension Strategies$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Languages$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Reading Comprehension Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$A sign on a door says 'Défense de fumer'. What does it mean?$mq$, $mq$["Smoking is forbidden","Smoking is allowed here","Fire exit","No entry for children"]$mq$, 0, $mq$'Défense de' means 'it is forbidden to', and 'fumer' is to smoke.$mq$, $mq$easy$mq$),
($mq$A shop window says 'Ouvert du lundi au samedi'. When is the shop open?$mq$, $mq$["Saturday only","Every day of the week","Monday to Friday","Monday to Saturday"]$mq$, 3, $mq$'Du lundi au samedi' means from Monday to Saturday, so Sunday is not included.$mq$, $mq$easy$mq$),
($mq$A door has the word 'Poussez'. What should you do?$mq$, $mq$["Pull the door","Knock on the door","Push the door","Wait outside"]$mq$, 2, $mq$'Poussez' means push. The opposite instruction is 'Tirez' (pull).$mq$, $mq$easy$mq$),
($mq$What does the sign 'Fermé' mean?$mq$, $mq$["Open","Closed","Free","Far away"]$mq$, 1, $mq$'Fermé' is closed, from 'fermer' (to close). 'Ouvert' is open.$mq$, $mq$easy$mq$),
($mq$What is the best thing to do BEFORE you read a French text in the exam?$mq$, $mq$["Read the title and the questions first","Translate every word in order","Skip the questions until the end","Guess the answers without reading"]$mq$, 0, $mq$Skimming the title and reading the questions first tells you what to look for, which saves time and helps you focus.$mq$, $mq$easy$mq$),
($mq$Tom writes: 'Salut Léa, je ne peux pas venir samedi parce que je suis malade.' Why can't Tom come on Saturday?$mq$, $mq$["He is tired","He has a football match","He is on holiday","He is ill"]$mq$, 3, $mq$'Parce que' introduces the reason and 'malade' means ill or sick.$mq$, $mq$medium$mq$),
($mq$'Je suis à la bibliothèque.' Where is the speaker?$mq$, $mq$["In the bookshop","In the bakery","In the library","At the swimming pool"]$mq$, 2, $mq$'Bibliothèque' is a false friend: it means library, not bookshop (which is 'librairie').$mq$, $mq$medium$mq$),
($mq$'Le magasin ouvre à neuf heures et ferme à dix-huit heures.' When does the shop close?$mq$, $mq$["9 am","6 pm","8 pm","6 am"]$mq$, 1, $mq$'Dix-huit heures' is 18:00, which is 6 pm. 'Neuf heures' is 9 o'clock, when it opens.$mq$, $mq$medium$mq$),
($mq$An exam question starts with 'Pourquoi'. What kind of answer is it asking for?$mq$, $mq$["A reason","A time","A place","A price"]$mq$, 0, $mq$'Pourquoi' means why, so you need a reason. Look for 'parce que' or 'car' in the text.$mq$, $mq$medium$mq$),
($mq$Timetable: 'Train pour Lyon: départ 14h25, arrivée 16h40.' How long is the journey?$mq$, $mq$["2 hours 25 minutes","1 hour 55 minutes","3 hours 15 minutes","2 hours 15 minutes"]$mq$, 3, $mq$From 14:25 to 16:40 is 2 hours and 15 minutes (14:25 to 16:25 is 2 hours, plus 15 minutes).$mq$, $mq$medium$mq$),
($mq$'Je n'aime pas le poisson.' Which statement is true?$mq$, $mq$["The speaker loves fish","The speaker does not eat meat","The speaker does not like fish","The speaker likes fish a little"]$mq$, 2, $mq$'Ne ... pas' makes a sentence negative. Spot it so you do not give the opposite meaning.$mq$, $mq$medium$mq$),
($mq$You do not know the word 'cadeau' in: 'Pour l'anniversaire de ma mère, j'achète un cadeau.' What is the best guess from context?$mq$, $mq$["A cake","A present","A card","A party"]$mq$, 1, $mq$A birthday, buying something: 'cadeau' is a present. Using context is a key reading strategy.$mq$, $mq$medium$mq$),
($mq$'Le concert commence à vingt heures, mais les portes ouvrent à dix-neuf heures.' When do the doors open?$mq$, $mq$["7 pm","8 pm","9 pm","6 pm"]$mq$, 0, $mq$'Dix-neuf heures' is 19:00, so 7 pm. Careful: 8 pm is when the concert starts, which is a distractor.$mq$, $mq$medium$mq$),
($mq$Message: 'Salut Inès ! Samedi, je vais au cinéma avec Paul, mais dimanche je suis libre. On peut faire du vélo ?' What does the writer suggest?$mq$, $mq$["Going to the cinema on Sunday","Going cycling on Saturday","Meeting Paul on Sunday","Going cycling on Sunday"]$mq$, 3, $mq$The writer is busy on Saturday ('mais' signals the contrast) and free on Sunday, when they suggest 'faire du vélo' (cycling).$mq$, $mq$hard$mq$),
($mq$'Chloé n'a pas aimé le concert parce que la musique était trop forte.' Why did Chloé not enjoy the concert?$mq$, $mq$["The tickets were too expensive","The concert was too long","The music was too loud","She did not like the singer"]$mq$, 2, $mq$'Parce que' gives the reason: 'trop forte' means too loud. The past tense is not needed to find the answer.$mq$, $mq$hard$mq$),
($mq$'Les magasins sont fermés le dimanche, sauf la boulangerie.' Which shop may be open on Sunday?$mq$, $mq$["The supermarket","The bakery","The bookshop","All the shops"]$mq$, 1, $mq$'Sauf' means except. Only the bakery is an exception to the Sunday closing.$mq$, $mq$hard$mq$),
($mq$Menu: 'Menu enfant : 8 € (jusqu'à 12 ans). Menu adulte : 15 €.' Two adults and a 10-year-old each take the set menu. What is the total?$mq$, $mq$["38 €","31 €","45 €","23 €"]$mq$, 0, $mq$The child is under 12, so pays 8 €. Two adults pay 2 × 15 = 30 €. Total 30 + 8 = 38 €.$mq$, $mq$hard$mq$),
($mq$'Ce soir, il pleut et il fait froid. Nous restons à la maison et nous regardons un film.' Which conclusion is best supported?$mq$, $mq$["They are going to the cinema","They are playing outside","They are on holiday by the sea","They chose an indoor activity because of the weather"]$mq$, 3, $mq$'Il pleut' (it rains) and 'il fait froid' (it is cold) explain why they stay home ('restons à la maison'). Always back an answer with evidence.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Reading Comprehension Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Défense de fumer$mq$, $mq$No smoking (smoking is forbidden).$mq$),
($mq$Poussez / Tirez$mq$, $mq$Push / Pull (signs on doors).$mq$),
($mq$Ouvert / Fermé$mq$, $mq$Open / Closed.$mq$),
($mq$la bibliothèque (false friend)$mq$, $mq$The library, NOT a bookshop. The bookshop is 'la librairie'.$mq$),
($mq$sauf$mq$, $mq$Except. 'Ouvert tous les jours sauf le lundi' = open every day except Monday.$mq$),
($mq$parce que$mq$, $mq$Because. It introduces a reason, which answers the question 'Pourquoi ?'.$mq$),
($mq$Qui ? Où ? Quand ? Combien ? Pourquoi ?$mq$, $mq$Who? Where? When? How much/many? Why? Match the question word to the type of answer.$mq$),
($mq$What are the four steps for reading comprehension?$mq$, $mq$Preview the questions, skim for the gist, scan for details, then check your answer against the text.$mq$),
($mq$ne ... pas / ne ... jamais$mq$, $mq$Not / never. These negatives reverse the meaning, so spot them: 'Je ne mange jamais de viande' = I never eat meat.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Reading Comprehension Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Reading comprehension in the MYP eAssessment asks you to understand short, everyday French texts: signs, messages, emails, menus, timetables and notices. You do not need to understand every word. You need a good method, and this note gives you one.

## How this is examined
You read a short text and answer multiple-choice questions in English. The questions often use a key word from the text, and the distractors may use words from the text that are in the wrong place. Marks go to students who find the exact detail that answers the question, not to those who match the first familiar word they see.

## The four-step method
- **Preview**: read the title, the type of text (email, sign, menu) and the questions first. This tells you what to hunt for.
- **Skim**: read the whole text quickly for the general idea: who, where, what, when.
- **Scan**: go back and look for the precise detail the question needs (a time, a price, a reason).
- **Check**: make sure your answer matches the text and that no word like "pas", "sauf" or "mais" changes the meaning.

## Clues you can use
- **Cognates** are words that look like English and mean the same: le restaurant, la musique, important, le sport, le chocolat.
- **False friends** look like English but mean something different: la bibliothèque (library, not bookshop; the bookshop is la librairie), actuellement (currently, not actually).
- **Context**: if you do not know "cadeau" in "J'achète un cadeau pour l'anniversaire de ma mère", the birthday tells you it is a present.
- **Word families**: "fermé" (closed) links to "fermer", "ouvert" (open) links to "ouvrir".

## Small words that change meaning
- ne ... pas (not): Je n'aime pas le poisson (I do not like fish)
- ne ... jamais (never): Il ne mange jamais de viande (He never eats meat)
- mais (but): shows a contrast, so the key information often comes after it
- parce que / car (because): introduces the reason
- sauf (except): Ouvert tous les jours sauf le lundi (open every day except Monday)
- avant / après (before / after), puis (then)

## Question words
- Qui? (who) - a person
- Où? (where) - a place
- Quand? (when) - a time or date
- Combien? (how much / how many) - a number or price
- Pourquoi? (why) - a reason
- Comment? (how) - a way or description

## Numbers, times and prices
Check numbers carefully, since distractors are often similar. "Dix-sept" is 17 but "soixante-dix" is 70. "Quinze heures trente" is 15:30, which is 3:30 pm. When you work out a journey time, subtract carefully: a train leaving at 14h25 and arriving at 16h40 takes 2 hours 15 minutes.

## Worked example
Text: "Salut Inès ! Samedi, je vais au cinéma avec Paul, mais dimanche je suis libre. On peut faire du vélo ?" Question: what does the writer suggest? The word "mais" signals that Saturday is busy and Sunday is free. "Faire du vélo" means to go cycling. Answer: cycling on Sunday. The trap answers use "cinéma" and "samedi".

## Common mistakes
- Choosing an option just because it contains a word from the text
- Ignoring "pas", "jamais" or "sauf"
- Spending ages on one unknown word instead of using context
- Writing what you think happens rather than what the text says

Exam tip: Underline the key word in each question, find that word (or its meaning) in the text, and read the words just before and after it. Then check every option against the text before choosing.$mq$ from st;

-- eAssessment Skills for Languages > Listening Text Strategies
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Languages$mq$, 5, 9 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Listening Text Strategies$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Languages$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Listening Text Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a 'Listening transcript' in this course?$mq$, $mq$["A written version of what is said in the recording","A list of vocabulary words","A translation into English","A French grammar table"]$mq$, 0, $mq$The transcript gives you the exact French that was spoken, so you can practise the same skills as in a listening task.$mq$, $mq$easy$mq$),
($mq$Listening transcript: 'Il est quinze heures trente.' What time is it?$mq$, $mq$["5:30 pm","3:15 pm","1:30 pm","3:30 pm"]$mq$, 3, $mq$'Quinze heures' is 15:00, which is 3 pm, and 'trente' means thirty minutes.$mq$, $mq$easy$mq$),
($mq$What should you do before the recording starts?$mq$, $mq$["Close your eyes and relax","Write the answers from memory","Read the questions and predict the kind of answer","Translate the whole recording"]$mq$, 2, $mq$Reading the questions first tells you what to listen for (a number, a place, a reason).$mq$, $mq$easy$mq$),
($mq$Listening transcript: 'Je m'appelle Karim et j'ai quinze ans.' How old is Karim?$mq$, $mq$["50","15","14","16"]$mq$, 1, $mq$'J'ai quinze ans' means I am fifteen. French uses 'avoir' (to have) for age.$mq$, $mq$easy$mq$),
($mq$Listening transcript: 'Aujourd'hui, il fait beau.' What is the weather like?$mq$, $mq$["Nice","Rainy","Cold","Windy"]$mq$, 0, $mq$'Il fait beau' means the weather is nice. Rain is 'il pleut'.$mq$, $mq$easy$mq$),
($mq$Listening transcript: 'Le billet coûte soixante-dix euros.' How much is the ticket?$mq$, $mq$["60 euros","17 euros","77 euros","70 euros"]$mq$, 3, $mq$'Soixante-dix' is literally sixty-ten, which is 70. Seventeen is 'dix-sept'.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'Rendez-vous devant le cinéma à dix-neuf heures quinze.' When and where do they meet?$mq$, $mq$["7:50 pm outside the cinema","9:15 pm inside the cinema","7:15 pm outside the cinema","7:15 pm outside the school"]$mq$, 2, $mq$'Dix-neuf heures quinze' is 19:15, i.e. 7:15 pm, and 'devant' means in front of.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'Je ne mange jamais de viande.' What does the speaker say?$mq$, $mq$["They often eat meat","They never eat meat","They eat meat once a week","They do not like vegetables"]$mq$, 1, $mq$'Ne ... jamais' means never. Do not miss the negative when you listen.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'Le match est mardi... non, pardon, mercredi.' When is the match?$mq$, $mq$["Wednesday","Tuesday","Thursday","Monday"]$mq$, 0, $mq$The speaker corrects themselves. The final word 'mercredi' is the answer, so keep listening to the end.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'Le train pour Paris partira du quai numéro quatre.' Which platform is it?$mq$, $mq$["Platform 14","Platform 40","Platform 2","Platform 4"]$mq$, 3, $mq$'Quatre' is four. 'Quatorze' would be fourteen and 'quarante' forty.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'J'adore le foot, mais je déteste le tennis.' Which sport does the speaker dislike?$mq$, $mq$["Football","Both sports","Tennis","Neither sport"]$mq$, 2, $mq$'Déteste' means hate. 'Mais' shows a contrast with 'j'adore' (I love).$mq$, $mq$medium$mq$),
($mq$You hear a word you do not know in the middle of a recording. What is the best strategy?$mq$, $mq$["Stop and try to remember it","Keep listening and use the context","Give up on the whole question","Write the first answer you think of"]$mq$, 1, $mq$Dwelling on one word makes you miss the next part. Use the words around it and move on.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'J'ai deux frères et une sœur. Ma sœur s'appelle Zoé.' How many brothers and sisters does the speaker have?$mq$, $mq$["3","2","1","4"]$mq$, 0, $mq$Two brothers plus one sister make three. Zoé is only the sister's name, not an extra person.$mq$, $mq$medium$mq$),
($mq$Voicemail: 'Allô Sophie, c'est Théo. Le cours de natation n'est plus à seize heures mais à dix-sept heures. Apporte ton maillot de bain et une serviette.' What is the new time and what should Sophie bring?$mq$, $mq$["4 pm; a swimsuit and a towel","5 pm; a swimsuit and a hat","4 pm; a water bottle and a towel","5 pm; a swimsuit and a towel"]$mq$, 3, $mq$'N'est plus à seize heures mais à dix-sept heures' means no longer at 4 pm but at 5 pm. 'Maillot de bain' is a swimsuit and 'serviette' a towel.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'Le magasin ouvre à neuf heures, sauf le lundi où il ouvre à midi.' When does the shop open on Monday?$mq$, $mq$["At 9 am","At 9 pm","At midday","It is closed on Monday"]$mq$, 2, $mq$'Sauf' means except. On Monday the opening time is 'midi', which is 12:00.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'Le film commence à vingt heures, mais on mange avant, à dix-huit heures trente.' When do they eat?$mq$, $mq$["8:00 pm","6:30 pm","8:30 pm","6:00 pm"]$mq$, 1, $mq$They eat at 18:30, which is 6:30 pm. The film at 8 pm is the distractor.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'Je voudrais une glace à la fraise et un thé, s'il vous plaît. Non, pas de thé, un jus d'orange.' What does the customer finally order?$mq$, $mq$["A strawberry ice cream and an orange juice","A strawberry ice cream and a tea","A vanilla ice cream and an orange juice","An orange juice only"]$mq$, 0, $mq$The customer changes their mind: 'pas de thé' replaces the tea with an orange juice.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'Demain, il y a du soleil le matin et de la pluie l'après-midi.' When is the best time for a picnic?$mq$, $mq$["In the afternoon","In the evening","Both morning and afternoon","In the morning"]$mq$, 3, $mq$The morning is sunny ('du soleil') and the afternoon is rainy ('de la pluie'), so the picnic should be in the morning.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Listening Text Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$quatre / quatorze / quarante$mq$, $mq$4 / 14 / 40. Listen to the whole word because the endings differ.$mq$),
($mq$seize / soixante$mq$, $mq$16 / 60. A common listening trap.$mq$),
($mq$dix-sept / soixante-dix$mq$, $mq$17 / 70. Soixante-dix is literally 'sixty-ten'.$mq$),
($mq$midi / minuit$mq$, $mq$Midday (12:00) / midnight.$mq$),
($mq$et quart / et demie$mq$, $mq$Quarter past / half past: 'trois heures et quart' = 3:15, 'trois heures et demie' = 3:30.$mq$),
($mq$non, pardon...$mq$, $mq$No, sorry... A speaker is correcting themselves, so the NEXT word is the answer.$mq$),
($mq$ne ... plus$mq$, $mq$No longer: 'Le cours n'est plus à seize heures' = the lesson is no longer at 4 pm.$mq$),
($mq$d'abord, puis, ensuite, enfin$mq$, $mq$First, then, next, finally. They tell you the order of events.$mq$),
($mq$What should you do before the recording starts?$mq$, $mq$Read the questions, underline what type of answer you need, and predict likely vocabulary.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Listening Text Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$In the MYP eAssessment you listen to short French recordings and answer questions in English. On this site we cannot play audio, so listening practice is given as a written "Listening transcript". The skills are the same: catch the key details, ignore the noise and avoid the traps.

## How this is examined
You usually hear a short announcement, message or conversation, often twice. The questions ask for specific details: a time, a number, a place, an opinion or a reason. Distractors are things the speaker mentions but then changes, or numbers that sound similar.

## Before the recording
- Read all the questions and the options. Underline what kind of answer you need.
- Predict vocabulary: a question about a train means numbers, times and platforms.
- Note the question words: Quand? (when) needs a time, Combien? (how much) needs a number, Où? (where) needs a place.

## During the recording
- Do not try to understand every word. Listen for the words that answer the questions.
- Write short notes in French or English, such as numbers or key words, and do not write full sentences.
- If you miss something, move on. Use the second listening to fill the gaps.
- Listen all the way to the end of each part, because speakers often correct themselves: "Le match est mardi... non, pardon, mercredi" means Wednesday.

## Number traps
Numbers are the most common source of lost marks. Practise these pairs.
- quatre (4) and quatorze (14) and quarante (40)
- seize (16) and soixante (60)
- dix-sept (17) and soixante-dix (70)
- quinze (15) and cinquante (50)
Times: "dix-neuf heures quinze" is 19:15, so 7:15 pm. "Midi" is 12:00 and "minuit" is midnight. "Et demie" means half past and "et quart" means quarter past.

## Signal words
- mais (but): the information after it is often the important part
- non, pardon / plutôt (I mean / rather): a correction
- sauf (except), pas de (no/none), ne ... jamais (never), ne ... plus (no longer)
- d'abord, puis, ensuite, enfin (first, then, next, finally): the order of events

## Worked example
Transcript: "Allô Sophie, c'est Théo. Le cours de natation n'est plus à seize heures mais à dix-sept heures. Apporte ton maillot de bain et une serviette." Notes: swimming, not 16h, now 17h, swimsuit and towel. Answer: 5 pm, bring a swimsuit and a towel. The old time (4 pm) is the distractor.

## Useful listening vocabulary
- un message (a message), une annonce (an announcement), un rendez-vous (a meeting)
- à quelle heure? (at what time?), un billet (a ticket), le quai (the platform)
- il fait beau (it is nice), il pleut (it is raining), il fait froid (it is cold)

## Common mistakes
- Choosing the first number you hear, even when it is later corrected
- Mixing up similar numbers such as seize and soixante
- Missing "ne ... pas" or "ne ... jamais" and giving the opposite meaning
- Panicking over one unknown word and losing the next sentence

Exam tip: Write the numbers you hear as digits straight away (for example 17h00 or 70 €), and wait until the speaker has finished before you lock in an answer.$mq$ from st;

-- eAssessment Skills for Languages > Writing a Short Response
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Languages$mq$, 5, 9 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Writing a Short Response$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Languages$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Writing a Short Response$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$You write an informal email to a friend. Which greeting is best?$mq$, $mq$["Salut Marie !","Monsieur le Directeur,","Madame,","Au revoir Marie !"]$mq$, 0, $mq$'Salut' is a friendly greeting for a friend. 'Au revoir' is a goodbye, and 'Monsieur' or 'Madame' are formal.$mq$, $mq$easy$mq$),
($mq$Which sign-off suits an email to a friend?$mq$, $mq$["Bonjour !","Bienvenue !","Excusez-moi !","À bientôt !"]$mq$, 3, $mq$'À bientôt' means see you soon. The other options are a greeting, a welcome and an apology.$mq$, $mq$easy$mq$),
($mq$Which sentence correctly says 'I live in London'?$mq$, $mq$["Je habite à Londres.","J'habites à Londres.","J'habite à Londres.","Je habiter à Londres."]$mq$, 2, $mq$'Je' becomes 'j'' before a vowel or silent h, and the verb ends in -e for 'je'.$mq$, $mq$easy$mq$),
($mq$Which phrase means 'because'?$mq$, $mq$["pourquoi","parce que","alors","aussi"]$mq$, 1, $mq$'Parce que' gives a reason. 'Pourquoi' means why, 'alors' means so and 'aussi' means also.$mq$, $mq$easy$mq$),
($mq$Which sentence correctly says 'My name is Ana'?$mq$, $mq$["Je m'appelle Ana.","Je appelle Ana.","Mon nom appelle Ana.","Je suis appelle Ana."]$mq$, 0, $mq$'Je m'appelle' is the reflexive verb s'appeler and is the standard way to give your name.$mq$, $mq$easy$mq$),
($mq$A task asks you to write about your hobbies in about 50 words. What is the best first step?$mq$, $mq$["Write in English, then translate","Write as much as possible without stopping","Copy a text from memory","Plan a few ideas using French you know"]$mq$, 3, $mq$A short plan keeps you on topic. Use words and structures you are sure of rather than risky translations.$mq$, $mq$medium$mq$),
($mq$Which linking word shows contrast?$mq$, $mq$["et","donc","mais","parce que"]$mq$, 2, $mq$'Mais' means but: 'J'aime le tennis, mais je n'aime pas le golf.' 'Et' adds, 'donc' gives a result and 'parce que' gives a reason.$mq$, $mq$medium$mq$),
($mq$Which sentence is correct?$mq$, $mq$["J'aime jouer à le football parce que c'est amusant.","J'aime jouer au football parce que c'est amusant.","J'aime joue au football parce que c'est amusant.","J'aime jouer au football parce que sont amusant."]$mq$, 1, $mq$'À' + 'le' becomes 'au'. After 'aimer' the verb stays in the infinitive (jouer), and 'c'est' is the correct form for 'it is'.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'Tomorrow I am going to play tennis'?$mq$, $mq$["Demain, je vais jouer au tennis.","Demain, je suis jouer au tennis.","Demain, je vais joue au tennis.","Demain, je vais jouer à le tennis."]$mq$, 0, $mq$The near future is 'aller' (present) + infinitive: 'je vais jouer'. Also 'à le' contracts to 'au'.$mq$, $mq$medium$mq$),
($mq$A task has three bullet points: school, family and weekend. What should you do?$mq$, $mq$["Write only about the weekend","Write about school only, in great detail","Ignore the bullet points and write freely","Write something about each bullet point"]$mq$, 3, $mq$The marks reward covering every part of the task. Missing a bullet point loses marks, however good the rest is.$mq$, $mq$medium$mq$),
($mq$Which sentence is fully correct?$mq$, $mq$["Mon sœur est petite.","Ma sœur est petit.","Ma sœur est petite.","Ma sœur sont petite."]$mq$, 2, $mq$'Sœur' is feminine, so use 'ma' and the feminine 'petite'. The verb 'est' agrees with one person.$mq$, $mq$medium$mq$),
($mq$What does 'À mon avis' mean?$mq$, $mq$["In my house","In my opinion","At my age","On my way"]$mq$, 1, $mq$'À mon avis' introduces an opinion, for example 'À mon avis, le français est facile.'$mq$, $mq$medium$mq$),
($mq$A student wants to give a reason for liking a sport. Which sentence works best?$mq$, $mq$["J'aime la natation parce que c'est relaxant.","J'aime la natation parce que.","J'aime parce que la natation relaxant.","Parce que la natation j'aime."]$mq$, 0, $mq$A full reason needs 'parce que' followed by a complete clause: 'c'est relaxant'.$mq$, $mq$medium$mq$),
($mq$Task: you receive an invitation to the cinema. You must accept, suggest a time and ask a question. Which reply covers all three?$mq$, $mq$["Merci pour l'invitation ! Oui, je veux bien venir. À bientôt !","Merci ! On se retrouve à quinze heures devant le cinéma.","Non, je ne peux pas venir. Tu apportes quelque chose ?","Merci pour l'invitation ! Oui, je veux bien venir. On se retrouve à quinze heures ? Tu apportes quelque chose ?"]$mq$, 3, $mq$The first reply accepts ('je veux bien venir'), suggests a time ('à quinze heures') and asks a question ('Tu apportes quelque chose ?'). The others miss at least one part.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'I do not have a brother'?$mq$, $mq$["Je n'ai pas un frère.","Je ne ai pas de frère.","Je n'ai pas de frère.","Je n'ai pas des frère."]$mq$, 2, $mq$'Ne' becomes 'n'' before 'ai', and after a negative 'un/une/des' becomes 'de' (or 'd'').$mq$, $mq$hard$mq$),
($mq$Which sentence correctly gives someone's age?$mq$, $mq$["Elle est quinze ans.","Elle a quinze ans.","Elle a quinze années.","Elle a quinze an."]$mq$, 1, $mq$In French you 'have' an age (avoir), and 'ans' is plural. Using 'être' is the classic mistake.$mq$, $mq$hard$mq$),
($mq$Which response is best because it adds detail and a reason?$mq$, $mq$["J'aime la musique, surtout le rock, parce que c'est énergique. Le week-end, j'écoute de la musique avec mes amis.","J'aime la musique.","Musique, j'aime.","J'aime la musique, la musique, la musique."]$mq$, 0, $mq$It gives an opinion, a detail ('surtout le rock'), a reason and an extra fact. Repeating words adds nothing.$mq$, $mq$hard$mq$),
($mq$A student writes: 'Mon amie est grand et sportif.' Which correction is right?$mq$, $mq$["Mon amie est grand et sportive.","Mon amie est grande et sportif.","Mon amie sont grande et sportive.","Mon amie est grande et sportive."]$mq$, 3, $mq$'Amie' is feminine, so both adjectives take the feminine form: grande and sportive.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Writing a Short Response$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Salut ! / À bientôt !$mq$, $mq$Hi! / See you soon! Informal greeting and sign-off for a friend.$mq$),
($mq$J'habite à ...$mq$, $mq$I live in ... (j' before a vowel; the verb ends in -e).$mq$),
($mq$Elle a quinze ans.$mq$, $mq$She is fifteen. French uses avoir (to have) for age, never être.$mq$),
($mq$Je n'ai pas de frère.$mq$, $mq$I do not have a brother. After a negative, un/une/des become de (or d').$mq$),
($mq$à + le / à + les$mq$, $mq$Au and aux: je joue au tennis, je vais aux magasins.$mq$),
($mq$Demain, je vais jouer au tennis.$mq$, $mq$Near future: aller (present) + infinitive.$mq$),
($mq$parce que / mais / alors$mq$, $mq$Because / but / so. Linking words that make your writing flow.$mq$),
($mq$À mon avis, ...$mq$, $mq$In my opinion, ... Use it to introduce an opinion and then give a reason.$mq$),
($mq$What are the steps to write a short response?$mq$, $mq$Underline the bullet points, plan ideas, write one short part for each, then proofread verbs, agreements, accents.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Writing a Short Response$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$In the MYP eAssessment, writing tasks ask for a short response, usually an informal email, a message or a few sentences answering bullet points. Success depends on three things: answering the task fully, writing accurate French, and using a little variety.

## How this is examined
You are given a situation (for example a message from a French friend) and several bullet points to cover. A strong response answers every bullet point, uses the correct form (greeting, sign-off), stays close to the word count and shows control of simple grammar. Quality of language matters more than length.

## Plan in 60 seconds
- Read the task and underline the bullet points.
- Jot down one or two ideas for each point, using French you are certain of.
- Decide on a simple structure: greeting, one short paragraph per bullet point, sign-off.
- Never write in English first and translate it. Choose ideas you can say in French.

## Greetings and sign-offs
- Salut Marie ! (Hi Marie!) - for a friend
- Cher Paul / Chère Sophie (Dear Paul / Dear Sophie)
- À bientôt ! (See you soon!), Bises (love, informal), Amicalement (best wishes)
- Merci pour ton message (Thanks for your message)

## Useful building blocks
- Je m'appelle ... (my name is), J'ai quinze ans (I am fifteen), J'habite à ... (I live in)
- J'aime / Je n'aime pas / Je déteste + noun or infinitive: J'aime la musique. J'aime jouer au tennis.
- Opinions and reasons: à mon avis (in my opinion), parce que (because), c'est amusant (it is fun)
- Linking words: et (and), mais (but), aussi (also), alors (so), puis (then)
- Near future: je vais + infinitive: Demain, je vais jouer au football.
- Questions to ask: Et toi ? Tu aimes ...? Qu'est-ce que tu fais le week-end ?

## Accuracy checklist
- **Verbs agree with the subject**: je joue, tu joues, nous jouons.
- **Elision**: je + vowel becomes j' (j'habite), ne + vowel becomes n' (je n'ai pas).
- **Gender and agreement**: ma sœur est grande, mon frère est grand. Adjectives agree with the noun they describe.
- **After a negative**: Je n'ai pas de frère (not "un frère").
- **à + le = au, à + les = aux**: je joue au tennis, je vais aux magasins.
- **Age**: Elle a quinze ans (avoir, not être).
- **Accents**: école, à, où, français. Learn them with the word.

## Worked example
Task: reply to an invitation to the cinema. Accept, suggest a time and ask a question. Response: "Salut Léa ! Merci pour l'invitation. Oui, je veux bien venir. On se retrouve à quinze heures devant le cinéma ? Tu apportes quelque chose ? À bientôt ! Tom". Check: accepted, time suggested, question asked, friendly greeting and sign-off.

## Adding quality
- Give a reason: J'aime la natation parce que c'est relaxant.
- Add a detail: surtout (especially), souvent (often), avec mes amis (with my friends)
- Use a short contrast with mais.
- Avoid repeating the same sentence pattern throughout.

## Common mistakes
- Missing a bullet point
- Writing far too much or far too little
- Using "être" for age or forgetting agreement of adjectives
- Using risky vocabulary from a translator instead of safe words you know

Exam tip: Leave one minute at the end for proofreading. Check verbs, agreements, accents and that every bullet point is answered.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;