-- Part 3 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Home and Daily Life > Rooms and Furniture
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Home and Daily Life$mq$, 5, 3 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Rooms and Furniture$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Home and Daily Life$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Rooms and Furniture$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'la cuisine' mean?$mq$, $mq$["the kitchen","the bedroom","the bathroom","the garden"]$mq$, 0, $mq$'La cuisine' is the kitchen, the room where meals are cooked. The bedroom is 'la chambre'.$mq$, $mq$easy$mq$),
($mq$Which French word means 'bedroom'?$mq$, $mq$["la salle de bains","le salon","la cuisine","la chambre"]$mq$, 3, $mq$'La chambre' is the bedroom. 'La salle de bains' is the bathroom and 'le salon' is the living room.$mq$, $mq$easy$mq$),
($mq$What does 'un lit' mean?$mq$, $mq$["a table","a wardrobe","a bed","a window"]$mq$, 2, $mq$'Un lit' is a bed. A table is 'une table' and a wardrobe is 'une armoire'.$mq$, $mq$easy$mq$),
($mq$What does 'le salon' mean?$mq$, $mq$["the garage","the living room","the kitchen","the bathroom"]$mq$, 1, $mq$'Le salon' is the living room, where the family relaxes. It is not a 'salon' for hairdressing in this context.$mq$, $mq$easy$mq$),
($mq$Which word means 'a chair'?$mq$, $mq$["une chaise","une chambre","un chat","une chaussure"]$mq$, 0, $mq$'Une chaise' is a chair. The other words look similar at the start but mean bedroom, cat and shoe.$mq$, $mq$easy$mq$),
($mq$Where do you usually eat the family meal in a large house?$mq$, $mq$["dans la salle de bains","dans le garage","dans la chambre","dans la salle à manger"]$mq$, 3, $mq$'La salle à manger' is the dining room, from 'manger' (to eat). 'La salle de bains' is for washing.$mq$, $mq$medium$mq$),
($mq$What does 'Il y a un canapé dans le salon' mean?$mq$, $mq$["There is a table in the kitchen.","He has a sofa in the bedroom.","There is a sofa in the living room.","The sofa is in the garden."]$mq$, 2, $mq$'Il y a' means 'there is/there are'. 'Un canapé' is a sofa and 'le salon' is the living room.$mq$, $mq$medium$mq$),
($mq$Which phrase correctly says 'a house'?$mq$, $mq$["un maison","une maison","le maison","un maisons"]$mq$, 1, $mq$'Maison' is feminine, so it takes 'une'. Learn each noun together with its article.$mq$, $mq$medium$mq$),
($mq$'J'habite dans un appartement au deuxième étage.' What does this mean?$mq$, $mq$["I live in a flat on the second floor.","I work in a flat on the second floor.","I live in a house with two floors.","I am looking for a flat with two rooms."]$mq$, 0, $mq$'J'habite' is 'I live', 'un appartement' is a flat and 'au deuxième étage' is on the second floor.$mq$, $mq$medium$mq$),
($mq$'Le chat est sous la table.' Where is the cat?$mq$, $mq$["on the table","behind the table","next to the table","under the table"]$mq$, 3, $mq$'Sous' means under. 'Sur' is on, 'derrière' is behind and 'à côté de' is next to.$mq$, $mq$medium$mq$),
($mq$'Le livre est sur le bureau.' Where is the book?$mq$, $mq$["under the desk","in the desk","on the desk","in front of the desk"]$mq$, 2, $mq$'Sur' means on, and 'le bureau' is the desk (it can also mean office).$mq$, $mq$medium$mq$),
($mq$In which room do you take a shower?$mq$, $mq$["dans la cuisine","dans la salle de bains","dans le salon","dans le jardin"]$mq$, 1, $mq$'La salle de bains' is the bathroom, where you wash. The shower is 'la douche'.$mq$, $mq$medium$mq$),
($mq$'Ma chambre est petite mais confortable.' What does this mean?$mq$, $mq$["My bedroom is small but comfortable.","My room is big and comfortable.","My bedroom is small and untidy.","My kitchen is small but modern."]$mq$, 0, $mq$'Petite' is small, 'mais' is but and 'confortable' is the same as in English.$mq$, $mq$medium$mq$),
($mq$Read the description. 'Voici ma maison. Au rez-de-chaussée, il y a la cuisine et le salon. À l'étage, il y a trois chambres et une salle de bains. Derrière la maison, il y a un jardin.' Which statement is true?$mq$, $mq$["The kitchen is upstairs.","The garden is in front of the house.","There is no living room.","There are three bedrooms upstairs."]$mq$, 3, $mq$'À l'étage' means upstairs, where there are three bedrooms. The kitchen is on the ground floor and the garden is 'derrière' (behind).$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'Dans ma chambre, j'ai un lit, une armoire et un bureau. Il n'y a pas de télévision.' Which item is NOT in the bedroom?$mq$, $mq$["a wardrobe","a desk","a television","a bed"]$mq$, 2, $mq$'Il n'y a pas de télévision' means there is no television. A bed, wardrobe and desk are all mentioned.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'There is no garden'?$mq$, $mq$["Il n'y a pas un jardin.","Il n'y a pas de jardin.","Il y a pas de jardin.","Il n'y a pas du jardin."]$mq$, 1, $mq$After a negative, 'un/une/du' becomes 'de', and the 'ne' must be kept: 'Il n'y a pas de jardin'.$mq$, $mq$hard$mq$),
($mq$'Le lit est à côté de la fenêtre. Le bureau est en face du lit.' Where is the desk?$mq$, $mq$["opposite the bed","next to the window","under the bed","behind the window"]$mq$, 0, $mq$'En face de' means opposite. The bed is next to the window, but the desk is across from the bed.$mq$, $mq$hard$mq$),
($mq$Flat advert: 'À louer : appartement, trois pièces, cuisine équipée, balcon, pas d'ascenseur.' Which statement is true?$mq$, $mq$["It has a lift.","It has a garden.","It has no kitchen.","It has a balcony."]$mq$, 3, $mq$'Un balcon' is a balcony. 'Pas d'ascenseur' means no lift, and 'cuisine équipée' means a fitted kitchen.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Rooms and Furniture$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$la salle de bains$mq$, $mq$the bathroom$mq$),
($mq$le salon$mq$, $mq$the living room$mq$),
($mq$une armoire$mq$, $mq$a wardrobe$mq$),
($mq$Il y a...$mq$, $mq$There is / there are...$mq$),
($mq$Il n'y a pas de...$mq$, $mq$There is no... / there are no... (de after a negative)$mq$),
($mq$à côté de / en face de$mq$, $mq$next to / opposite$mq$),
($mq$sous / sur / derrière$mq$, $mq$under / on / behind$mq$),
($mq$au rez-de-chaussée$mq$, $mq$on the ground floor$mq$),
($mq$J'habite dans un appartement.$mq$, $mq$I live in a flat.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Rooms and Furniture$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Talking about your home is one of the most common topics in a beginner French exam. This note gives you the vocabulary for the rooms and furniture, and the simple structures you need to describe where things are.

## The rooms
- la maison (the house) and un appartement (a flat)
- la cuisine (the kitchen)
- le salon (the living room) and la salle à manger (the dining room)
- la chambre (the bedroom)
- la salle de bains (the bathroom) and les toilettes (the toilet)
- le jardin (the garden), le garage (the garage), le balcon (the balcony)
- l'étage (the upper floor) and le rez-de-chaussée (the ground floor)

Always learn the article with the noun. In French every noun is masculine or feminine, so it is "un jardin" but "une cuisine". Do not guess from the English word.

## The furniture
- un lit (a bed), une armoire (a wardrobe), un bureau (a desk)
- une table (a table), une chaise (a chair), un canapé (a sofa)
- une lampe (a lamp), une fenêtre (a window), une porte (a door)
- un fauteuil (an armchair), une étagère (a shelf), un tapis (a rug)

## Saying what there is
Use "il y a" for both "there is" and "there are". Example: "Dans ma chambre, il y a un lit et une armoire" (In my bedroom there is a bed and a wardrobe). To say there is not, use "il n'y a pas de": "Il n'y a pas de télévision" (There is no television). After a negative, un, une and des all change to "de" (or "d'" before a vowel).

## Saying where things are
These small words are very examinable:
- sur (on), sous (under), dans (in)
- devant (in front of), derrière (behind)
- à côté de (next to), en face de (opposite), entre (between)

Remember that "de" joins with le and les: "à côté du lit" (next to the bed), "en face des fenêtres" (opposite the windows). With la you keep the two words: "à côté de la table".

## Describing your home
Use "j'habite" (I live) with "dans une maison" or "dans un appartement". Add adjectives, and make them agree: "Ma chambre est petite" (feminine), "Mon salon est grand" (masculine). Useful words include grand (big), petit (small), moderne (modern), confortable and clair (bright). Note that "au deuxième étage" means on the second floor.

## Common mistakes
- Writing "un maison" instead of "une maison".
- Writing "il n'y a pas un jardin" instead of "il n'y a pas de jardin".
- Mixing up "la salle de bains" (bathroom) with "la chambre" (bedroom), or "le bureau" (desk) with the English word "bureau".
- Forgetting that "au rez-de-chaussée" is the ground floor, so "au premier étage" is what English calls the first floor up.

## How this is examined
In reading tasks you may see a short estate agent advert, a message from a pen friend describing their house, or a plan with labels. In listening tasks (given to you as a transcript) someone describes their bedroom and you must note which items are present or absent. In writing tasks you describe your own home in three to five sentences, using "il y a", a preposition and an adjective.

Exam tip: Look out for "pas de" in a text. Students often pick an item that is mentioned even though the speaker says it is not there.$mq$ from st;

-- Home and Daily Life > Daily Routines
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Home and Daily Life$mq$, 5, 3 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Daily Routines$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Home and Daily Life$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Daily Routines$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'Je me réveille' mean?$mq$, $mq$["I wake up","I get dressed","I go to bed","I have lunch"]$mq$, 0, $mq$'Se réveiller' means to wake up. 'Je me couche' is I go to bed.$mq$, $mq$easy$mq$),
($mq$What does 'Je prends le petit déjeuner' mean?$mq$, $mq$["I have lunch","I have dinner","I make a snack","I have breakfast"]$mq$, 3, $mq$'Le petit déjeuner' is breakfast, 'le déjeuner' is lunch and 'le dîner' is dinner.$mq$, $mq$easy$mq$),
($mq$What does 'Je me couche' mean?$mq$, $mq$["I get up","I have a shower","I go to bed","I do my homework"]$mq$, 2, $mq$'Se coucher' means to go to bed. 'Se lever' means to get up.$mq$, $mq$easy$mq$),
($mq$What does 'Je vais à l'école' mean?$mq$, $mq$["I leave school","I go to school","I like school","I come from school"]$mq$, 1, $mq$'Aller à' means to go to. 'Je vais' is 'I go'.$mq$, $mq$easy$mq$),
($mq$What does 'le matin' mean?$mq$, $mq$["in the morning","in the evening","at night","in the afternoon"]$mq$, 0, $mq$'Le matin' is the morning, 'l'après-midi' is the afternoon and 'le soir' is the evening.$mq$, $mq$easy$mq$),
($mq$Complete the sentence: 'Elle ___ à sept heures.'$mq$, $mq$["me lève","te lève","nous levons","se lève"]$mq$, 3, $mq$With 'elle' the reflexive pronoun is 'se'. 'Se lever' means to get up.$mq$, $mq$medium$mq$),
($mq$What does 'Je me brosse les dents' mean?$mq$, $mq$["I wash my hair","I tidy my room","I brush my teeth","I take a shower"]$mq$, 2, $mq$'Les dents' are teeth and 'se brosser' means to brush. French uses 'les' instead of 'my' for body parts.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Nous ___ au collège à pied.'$mq$, $mq$["allez","allons","vont","vais"]$mq$, 1, $mq$'Aller' with 'nous' is 'allons'. 'Allez' goes with vous and 'vont' with ils/elles.$mq$, $mq$medium$mq$),
($mq$'Je fais mes devoirs le soir.' When does the speaker do homework?$mq$, $mq$["in the evening","in the morning","at lunchtime","at the weekend"]$mq$, 0, $mq$'Le soir' means in the evening. 'Mes devoirs' is my homework.$mq$, $mq$medium$mq$),
($mq$Which word means 'then / afterwards' when you describe your day?$mq$, $mq$["toujours","jamais","souvent","ensuite"]$mq$, 3, $mq$'Ensuite' means then or next. 'Toujours' is always, 'jamais' never and 'souvent' often.$mq$, $mq$medium$mq$),
($mq$'D'habitude, je déjeune à la cantine.' What does 'd'habitude' mean?$mq$, $mq$["never","sometimes","usually","yesterday"]$mq$, 2, $mq$'D'habitude' means usually. The sentence says I usually have lunch at the canteen.$mq$, $mq$medium$mq$),
($mq$Which verb means 'to get dressed'?$mq$, $mq$["se laver","s'habiller","se coucher","se réveiller"]$mq$, 1, $mq$'S'habiller' is to get dressed. 'Se laver' is to wash.$mq$, $mq$medium$mq$),
($mq$What does 'Tu te couches à quelle heure ?' ask?$mq$, $mq$["What time do you go to bed?","What time do you wake up?","Where do you go to bed?","Why do you go to bed?"]$mq$, 0, $mq$'À quelle heure' is 'at what time' and 'te couches' is 'you go to bed'.$mq$, $mq$medium$mq$),
($mq$Chloé writes: 'Je me lève à six heures et demie. Je prends le bus à sept heures et quart. Les cours commencent à huit heures. Après l'école, je fais mes devoirs et je dîne avec ma famille.' What does Chloé do after school?$mq$, $mq$["takes the bus to the market","gets up and has breakfast","watches television with friends","homework and dinner with her family"]$mq$, 3, $mq$'Après l'école' introduces her evening: 'je fais mes devoirs et je dîne avec ma famille'. The bus and getting up are in the morning.$mq$, $mq$hard$mq$),
($mq$Which sentence is the correct negative?$mq$, $mq$["Je ne réveille me pas tôt.","Je me ne réveille pas tôt.","Je ne me réveille pas tôt.","Je pas me réveille tôt."]$mq$, 2, $mq$With a reflexive verb, 'ne' goes before the pronoun and 'pas' after the verb: 'ne me réveille pas'.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'Le week-end, je ne me lève pas tôt. Je me lève à dix heures et je regarde la télé.' What is different at the weekend?$mq$, $mq$["She goes to school.","She gets up later.","She gets up earlier.","She never watches television."]$mq$, 1, $mq$She does not get up early ('pas tôt'); she gets up at ten o'clock, so later than on school days.$mq$, $mq$hard$mq$),
($mq$Complete the sentence: 'Nous ___ couchons à vingt-deux heures.'$mq$, $mq$["nous","me","se","vous"]$mq$, 0, $mq$The reflexive pronoun must match the subject: 'nous nous couchons'.$mq$, $mq$hard$mq$),
($mq$'Mon frère ne se douche jamais le matin ; il se douche le soir.' Which statement is true?$mq$, $mq$["He showers every morning.","He never showers.","He showers in the afternoon.","He showers in the evening."]$mq$, 3, $mq$'Ne... jamais' means never, so he never showers in the morning. He showers in the evening instead.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Daily Routines$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$se lever$mq$, $mq$to get up: je me lève, tu te lèves, il se lève, nous nous levons$mq$),
($mq$Je me couche à dix heures.$mq$, $mq$I go to bed at ten o'clock.$mq$),
($mq$le petit déjeuner / le déjeuner / le dîner$mq$, $mq$breakfast / lunch / dinner$mq$),
($mq$d'abord, puis, ensuite, enfin$mq$, $mq$first, then, next, finally$mq$),
($mq$toujours / souvent / parfois / jamais$mq$, $mq$always / often / sometimes / never$mq$),
($mq$Je ne me lève pas tôt.$mq$, $mq$I do not get up early. (ne before the reflexive pronoun, pas after the verb)$mq$),
($mq$faire mes devoirs$mq$, $mq$to do my homework: je fais mes devoirs$mq$),
($mq$aller (present)$mq$, $mq$je vais, tu vas, il va, nous allons, vous allez, ils vont$mq$),
($mq$s'habiller$mq$, $mq$to get dressed: je m'habille (me becomes m' before a vowel)$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Daily Routines$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Describing your daily routine is a favourite exam topic because it lets you show verbs, times and linking words at the same time. At beginner level you only need the present tense and a good stock of everyday actions.

## Key actions
- Je me réveille (I wake up)
- Je me lève (I get up)
- Je me lave / Je prends une douche (I wash / I have a shower)
- Je m'habille (I get dressed)
- Je me brosse les dents (I brush my teeth)
- Je prends le petit déjeuner (I have breakfast)
- Je vais à l'école (I go to school) and je rentre à la maison (I go home)
- Je fais mes devoirs (I do my homework)
- Je dîne (I have dinner)
- Je me couche (I go to bed)

## Reflexive verbs
Many routine verbs are reflexive. They have an extra small word between the subject and the verb: me, te, se, nous, vous, se. For example, se lever:
- je me lève, tu te lèves, il/elle se lève
- nous nous levons, vous vous levez, ils/elles se lèvent

Before a vowel, me becomes m' and se becomes s': "je m'habille", "il s'habille". Note the accent change in "je me lève" (è) but not in "nous nous levons".

## Negatives with reflexive verbs
Put "ne" before the reflexive pronoun and "pas" after the verb: "Je ne me lève pas tôt" (I do not get up early). Other useful negatives follow the same pattern: "ne... jamais" (never), as in "Il ne se couche jamais avant minuit".

## Linking your day together
- d'abord (first), puis / ensuite (then), après (afterwards), enfin (finally)
- le matin (in the morning), l'après-midi (in the afternoon), le soir (in the evening)
- toujours (always), souvent (often), parfois (sometimes), d'habitude (usually), jamais (never)

A model answer: "D'habitude, je me réveille à sept heures. Ensuite, je prends une douche et je m'habille. Je prends le petit déjeuner avec ma famille, puis je vais à l'école en bus. Le soir, je fais mes devoirs et je me couche à dix heures."

## Useful irregular verbs
- aller: je vais, tu vas, il va, nous allons, vous allez, ils vont
- faire: je fais, tu fais, il fait, nous faisons, vous faites, ils font
- prendre: je prends, tu prends, il prend, nous prenons, vous prenez, ils prennent

## Common mistakes
- Forgetting the reflexive pronoun: writing "Je lève" instead of "Je me lève".
- Using the wrong pronoun for the subject, such as "nous me couchons".
- Putting "pas" in the wrong place in a negative sentence.
- Confusing "le petit déjeuner" (breakfast), "le déjeuner" (lunch) and "le dîner" (dinner).

## How this is examined
You may read a short blog or message where someone describes a typical day and answer questions on what they do and when. In the listening transcript you might hear two friends compare a weekday with a weekend. In writing you describe your routine in four to six sentences, using times, frequency words and at least one reflexive verb.

Exam tip: Watch frequency words. "Toujours", "souvent" and "jamais" change the meaning completely, so underline them in the text before you choose an answer.$mq$ from st;

-- Home and Daily Life > Telling the Time
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Home and Daily Life$mq$, 5, 3 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Telling the Time$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Home and Daily Life$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Telling the Time$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'Il est huit heures' mean?$mq$, $mq$["It is eight o'clock.","It is eighteen minutes.","He is eight years old.","It is half past eight."]$mq$, 0, $mq$'Il est... heures' tells the time. 'Huit heures' is eight o'clock.$mq$, $mq$easy$mq$),
($mq$What does 'midi' mean?$mq$, $mq$["midnight","half past twelve","midday meal","noon (12 p.m.)"]$mq$, 3, $mq$'Midi' is noon. Midnight is 'minuit'.$mq$, $mq$easy$mq$),
($mq$What does 'minuit' mean?$mq$, $mq$["noon","a minute","midnight","one o'clock"]$mq$, 2, $mq$'Minuit' is midnight. Do not confuse it with 'minute' (a minute) in English.$mq$, $mq$easy$mq$),
($mq$Which time is 'Il est trois heures et demie'?$mq$, $mq$["2:30","3:30","3:15","3:45"]$mq$, 1, $mq$'Et demie' means half past, so three o'clock and a half is 3:30.$mq$, $mq$easy$mq$),
($mq$Which time is 'Il est dix heures et quart'?$mq$, $mq$["10:15","9:45","10:30","10:45"]$mq$, 0, $mq$'Et quart' means quarter past, so 10:15.$mq$, $mq$easy$mq$),
($mq$How do you say 7:45 in French?$mq$, $mq$["Il est sept heures et quart.","Il est sept heures et demie.","Il est huit heures et quart.","Il est huit heures moins le quart."]$mq$, 3, $mq$7:45 is a quarter to eight, so 'huit heures moins le quart'. 'Moins' means minus (to).$mq$, $mq$medium$mq$),
($mq$Which time is 'Il est trois heures moins dix'?$mq$, $mq$["3:10","2:10","2:50","3:50"]$mq$, 2, $mq$'Moins dix' means ten minutes to, so ten to three is 2:50.$mq$, $mq$medium$mq$),
($mq$How do you say 9:20?$mq$, $mq$["Il est neuf heures moins vingt.","Il est neuf heures vingt.","Il est vingt heures neuf.","Il est neuf heures et quart."]$mq$, 1, $mq$For minutes past the hour, say the hour then the number: 'neuf heures vingt'. 'Moins vingt' would be 8:40.$mq$, $mq$medium$mq$),
($mq$What does 'À quelle heure commence le film ?' ask?$mq$, $mq$["At what time does the film start?","How long is the film?","Where is the film shown?","Which film is on?"]$mq$, 0, $mq$'À quelle heure' means at what time and 'commence' means starts.$mq$, $mq$medium$mq$),
($mq$A French train timetable says 'Le train part à 14h30.' What time is this?$mq$, $mq$["4:30 a.m.","12:30 p.m.","2:30 a.m.","2:30 p.m."]$mq$, 3, $mq$The French often use the 24-hour clock. 14h is 2 p.m., so 14h30 is 2:30 p.m.$mq$, $mq$medium$mq$),
($mq$How do you write 18:05 in words?$mq$, $mq$["huit heures cinq","dix-huit heures et demie","dix-huit heures cinq","huit heures moins cinq"]$mq$, 2, $mq$On the 24-hour clock 18h is 'dix-huit heures'; then add 'cinq' for five minutes past.$mq$, $mq$medium$mq$),
($mq$What time is 'Il est midi et demi'?$mq$, $mq$["12:15","12:30","11:30","1:30"]$mq$, 1, $mq$'Midi' is 12 noon and 'et demi' adds half an hour, so 12:30. With 'midi' and 'minuit' the word is 'demi' (no e).$mq$, $mq$medium$mq$),
($mq$'Le cours finit à seize heures quinze.' When does the lesson finish?$mq$, $mq$["4:15 p.m.","6:15 a.m.","1:15 p.m.","4:50 p.m."]$mq$, 0, $mq$Sixteen hours is 4 p.m. (16 − 12 = 4) and 'quinze' means 15 minutes past.$mq$, $mq$medium$mq$),
($mq$Timetable: 'Train Paris–Lyon : départ 09h12, arrivée 11h27.' How long is the journey?$mq$, $mq$["2 hours 25 minutes","1 hour 15 minutes","2 hours 45 minutes","2 hours 15 minutes"]$mq$, 3, $mq$From 09:12 to 11:12 is 2 hours; then 15 more minutes reach 11:27. Total 2 hours 15 minutes.$mq$, $mq$hard$mq$),
($mq$School notice: 'Les cours commencent à huit heures moins le quart et la récréation est à dix heures dix.' Which times are given?$mq$, $mq$["8:15 and 10:10","7:45 and 9:50","7:45 and 10:10","8:45 and 10:10"]$mq$, 2, $mq$'Huit heures moins le quart' is 7:45 and 'dix heures dix' is 10:10.$mq$, $mq$hard$mq$),
($mq$Cinema: 'Séance de 20h45. Le film dure une heure et demie.' At what time does the film end?$mq$, $mq$["21h45","22h15","22h45","21h15"]$mq$, 1, $mq$20h45 plus 1 hour 30 minutes is 22h15 (20:45 + 1:30). In words: 'vingt-deux heures quinze'.$mq$, $mq$hard$mq$),
($mq$Which time is 'Il est minuit moins cinq'?$mq$, $mq$["11:55 p.m.","12:05 a.m.","11:05 p.m.","12:55 a.m."]$mq$, 0, $mq$'Moins cinq' means five minutes before, so five to midnight is 11:55 p.m.$mq$, $mq$hard$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["Il est une heure.","Il est trois heures.","Il est midi et quart.","Il est quatre heure et demie."]$mq$, 3, $mq$'Heure' needs an 's' for plural: 'quatre heures et demie'. The other sentences are correct.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Telling the Time$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Quelle heure est-il ?$mq$, $mq$What time is it?$mq$),
($mq$Il est une heure.$mq$, $mq$It is one o'clock. (une heure is singular; others take heures)$mq$),
($mq$et quart / et demie$mq$, $mq$quarter past / half past (midi et demi, minuit et demi)$mq$),
($mq$moins le quart$mq$, $mq$quarter to: Il est huit heures moins le quart = 7:45$mq$),
($mq$moins dix$mq$, $mq$ten to: trois heures moins dix = 2:50$mq$),
($mq$midi / minuit$mq$, $mq$noon / midnight$mq$),
($mq$14h30$mq$, $mq$quatorze heures trente = 2:30 p.m. (24-hour clock)$mq$),
($mq$À quelle heure commence le film ?$mq$, $mq$At what time does the film start?$mq$),
($mq$Le train part à 18h05.$mq$, $mq$The train leaves at 6:05 p.m.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Telling the Time$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Being able to read and say times is an essential skill, because timetables, tickets, posters and school notices all use them. The good news is that French follows a clear pattern.

## The basic question and answer
- Quelle heure est-il ? (What time is it?)
- Il est... (It is...)
- À quelle heure ? (At what time?)
- À... (At...)

Examples: "Il est huit heures" (It is eight o'clock), "Le cours commence à neuf heures" (The lesson starts at nine).

## On the hour
Say "il est" + number + "heure(s)". Only one o'clock is singular: "Il est une heure". All others take an s: "deux heures", "trois heures". Two special words exist:
- midi (noon) and minuit (midnight)
They are never followed by "heures".

## Minutes past, half past, quarter past
- Il est cinq heures cinq (5:05), cinq heures dix (5:10), cinq heures vingt (5:20)
- Il est cinq heures et quart (5:15)
- Il est cinq heures et demie (5:30)
With midi and minuit the word is "demi" with no e: "midi et demi" (12:30).

## Minutes to the hour
Use "moins" (minus) and the next hour:
- Il est six heures moins vingt-cinq (5:35)
- Il est six heures moins vingt (5:40)
- Il est six heures moins le quart (5:45)
- Il est six heures moins dix (5:50)
- Il est six heures moins cinq (5:55)
Do not say "cinq heures quarante-cinq" in a normal conversation, although this is correct on a timetable.

## The 24-hour clock
French timetables, tickets and TV guides use the 24-hour clock. You say the hour and then the minutes, with no "et quart" or "moins":
- 14h30 = quatorze heures trente (2:30 p.m.)
- 18h05 = dix-huit heures cinq (6:05 p.m.)
- 21h45 = vingt et une heures quarante-cinq (9:45 p.m.)
To convert from the 24-hour clock, subtract twelve from any hour above 12: 16h becomes 4 p.m.

## Useful time words
- le matin (morning), l'après-midi (afternoon), le soir (evening), la nuit (night)
- ce matin (this morning), demain (tomorrow), hier (yesterday)
- commencer (to start), finir (to finish), partir (to leave), arriver (to arrive)
- un horaire (a timetable), la durée (the length of time)

## Worked example
A train leaves at 16h20 and arrives at 18h05. From 16:20 to 18:20 would be two hours, but 18:05 is 15 minutes earlier, so the journey lasts 1 hour 45 minutes ("une heure quarante-cinq").

## Common mistakes
- Forgetting the s in "heures" (except for une heure).
- Reading "moins le quart" as quarter past instead of quarter to.
- Not converting 24-hour times, so thinking "17h" is 7 o'clock.
- Mixing "minuit" (midnight) with "minute".

## How this is examined
Expect timetables, cinema listings, transport announcements and school schedules. In the listening transcript you may have to hear two times and pick the right one. The question often asks you to work out an ending time or a duration, so practise adding and subtracting.

Exam tip: Write the digits next to the French text as soon as you read it, for example "moins le quart = :45 of the hour before", so that you do not misread a time under pressure.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;