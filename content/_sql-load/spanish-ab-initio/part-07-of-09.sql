-- Part 7 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Free Time and Health > Hobbies and Sports
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Free Time and Health$mq$, 5, 7 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Hobbies and Sports$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Free Time and Health$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Hobbies and Sports$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'nadar' mean?$mq$, $mq$["to swim","to dance","to read","to run"]$mq$, 0, $mq$'Nadar' is to swim. 'Bailar' is to dance, 'leer' is to read and 'correr' is to run.$mq$, $mq$easy$mq$),
($mq$What does 'leer' mean?$mq$, $mq$["to write","to listen","to play","to read"]$mq$, 3, $mq$'Leer' is to read. Do not mix it up with 'escribir' (to write).$mq$, $mq$easy$mq$),
($mq$What does 'Me gusta bailar' mean?$mq$, $mq$["I like singing.","I do not like dancing.","I like dancing.","I am dancing now."]$mq$, 2, $mq$'Me gusta' + infinitive means I like doing something. 'Bailar' is to dance.$mq$, $mq$easy$mq$),
($mq$Which verb do we use for playing a musical instrument, such as the guitar?$mq$, $mq$["jugar","tocar","hacer","ver"]$mq$, 1, $mq$We use 'tocar' for instruments ('toco la guitarra') and 'jugar' for games and sports ('juego al fútbol').$mq$, $mq$easy$mq$),
($mq$What does 'los fines de semana' mean?$mq$, $mq$["at weekends","every day","on weekdays","at the end of the year"]$mq$, 0, $mq$'Fin de semana' is weekend. With 'los' it means regularly, on weekends.$mq$, $mq$easy$mq$),
($mq$Complete the sentence: 'Mi hermano ___ al tenis los sábados.'$mq$, $mq$["jugo","juegas","jugamos","juega"]$mq$, 3, $mq$'Jugar' changes its stem (u → ue) in the present tense: juego, juegas, juega, jugamos, jugáis, juegan. A brother is 'él', so 'juega'.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'I play the piano'?$mq$, $mq$["Juego el piano.","Juego al piano.","Toco el piano.","Toco al piano."]$mq$, 2, $mq$For instruments we use 'tocar' with the article and no 'a': 'Toco el piano'. 'Jugar a' is for games and sports.$mq$, $mq$medium$mq$),
($mq$Read the text.

'Me llamo Elena. Me encanta el deporte. Juego al baloncesto los martes y los jueves y nado los sábados. No me gusta correr.'

On which days does Elena play basketball?$mq$, $mq$["Saturdays only","Tuesdays and Thursdays","Tuesdays and Saturdays","Every day"]$mq$, 1, $mq$'Los martes y los jueves' means on Tuesdays and Thursdays. She swims on Saturdays.$mq$, $mq$medium$mq$),
($mq$Which sentence means 'I hate playing video games'?$mq$, $mq$["Odio jugar a los videojuegos.","Me encanta jugar a los videojuegos.","Prefiero jugar a los videojuegos.","Nunca juego a los videojuegos."]$mq$, 0, $mq$'Odio' means I hate. 'Me encanta' is I love, 'prefiero' is I prefer, and 'nunca juego' only says that I never play.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'A mis amigos ___ gusta ver películas.'$mq$, $mq$["le","me","nos","les"]$mq$, 3, $mq$'A mis amigos' is 'to them', so the pronoun is 'les'. Singular 'a mi amigo' would take 'le'.$mq$, $mq$medium$mq$),
($mq$Listening transcript:

'¿Qué haces en tu tiempo libre? —Normalmente salgo con mis amigos y vamos al cine. A veces toco la guitarra en casa. Nunca veo la tele.'

What does the speaker never do?$mq$, $mq$["Play the guitar","Go to the cinema","Watch television","Go out with friends"]$mq$, 2, $mq$'Nunca' means never, and 'ver la tele' is to watch TV. 'A veces' means sometimes.$mq$, $mq$medium$mq$),
($mq$Read the message.

'Hola, Leo: ¿Quieres jugar al fútbol mañana a las cuatro en el parque? Trae tu balón. Marcos.'

What does Marcos want?$mq$, $mq$["To go to the cinema tomorrow at four","To play football with Leo in the park tomorrow at four","To play basketball in the park today","To buy a ball with Leo at four"]$mq$, 1, $mq$'¿Quieres jugar...?' is an invitation. 'Mañana a las cuatro en el parque' gives the day, time and place, and 'trae tu balón' asks Leo to bring a ball.$mq$, $mq$medium$mq$),
($mq$What does 'Prefiero la natación al fútbol' mean?$mq$, $mq$["I prefer swimming to football.","I prefer football to swimming.","I like swimming and football.","I hate swimming but like football."]$mq$, 0, $mq$'Preferir A a B' means to prefer A to B. 'La natación' is swimming.$mq$, $mq$medium$mq$),
($mq$Read the text.

'Mi hermana y yo no tenemos los mismos gustos. A ella le encanta leer y escuchar música clásica, pero a mí me gusta más el deporte. Yo juego al fútbol cada día.'

Which statement is correct?$mq$, $mq$["The writer loves reading, but his sister plays football daily.","Both of them love classical music.","The writer's sister plays football and reads every day.","The writer's sister loves reading, but the writer plays football daily."]$mq$, 3, $mq$'A ella le encanta leer' refers to the sister. The writer prefers sport and plays football every day ('cada día').$mq$, $mq$hard$mq$),
($mq$Which sentence is correct?$mq$, $mq$["Nosotros juegamos al baloncesto los viernes.","Nosotros jugamos baloncesto al los viernes.","Nosotros jugamos al baloncesto los viernes.","Nosotros juegan al baloncesto los viernes."]$mq$, 2, $mq$The 'nosotros' form of 'jugar' is 'jugamos' (no stem change). The stem change only happens in the other forms except 'vosotros'.$mq$, $mq$hard$mq$),
($mq$Which sentence says 'My sister likes dancing and singing'?$mq$, $mq$["A mi hermana me gusta bailar y cantar.","A mi hermana le gusta bailar y cantar.","A mi hermana le gustan bailar y cantar.","Mi hermana gusta bailar y cantar."]$mq$, 1, $mq$We use 'le' for 'to her', and 'gusta' (singular) before infinitives, even two of them. 'Me' would mean 'to me'.$mq$, $mq$hard$mq$),
($mq$Read the survey answers.

'¿Con qué frecuencia? Nadar: todos los días. Leer: a menudo. Ver la tele: a veces. Videojuegos: nunca.'

Which statement is correct?$mq$, $mq$["She swims every day and never plays video games.","She reads every day and sometimes swims.","She often watches TV and never reads.","She plays video games sometimes and swims often."]$mq$, 0, $mq$'Todos los días' is every day, 'a menudo' often, 'a veces' sometimes and 'nunca' never.$mq$, $mq$hard$mq$),
($mq$Listening transcript:

'Los fines de semana, mis amigos y yo jugamos al fútbol por la mañana. Por la tarde, mi amigo Paco toca la guitarra y yo escucho música. Los domingos no salimos porque tenemos que estudiar.'

What do they do on Sundays?$mq$, $mq$["They play football in the morning.","They go out and listen to music.","They go to a concert with Paco.","They stay in because they have to study."]$mq$, 3, $mq$'No salimos' means we do not go out, and 'porque tenemos que estudiar' gives the reason: they have to study.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Hobbies and Sports$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$jugar: juego, juegas, juega, jugamos, jugáis, juegan$mq$, $mq$Stem-changing verb (u → ue) except in 'nosotros' and 'vosotros'. 'Mi amigo juega al tenis.'$mq$),
($mq$jugar a / tocar$mq$, $mq$Jugar a + game or sport (juego al fútbol); tocar + instrument (toco la guitarra).$mq$),
($mq$Me encanta / Me gusta / Odio$mq$, $mq$I love / I like / I hate. They are followed by an infinitive: 'Me encanta bailar.'$mq$),
($mq$A mi hermana le gusta...$mq$, $mq$My sister likes... 'Le' = to her/him; 'les' = to them. 'A mis amigos les gusta ver películas.'$mq$),
($mq$a menudo / a veces / nunca$mq$, $mq$often / sometimes / never. Frequency words appear in nearly every free-time text.$mq$),
($mq$los fines de semana$mq$, $mq$at weekends (regularly). 'Los sábados' = on Saturdays (every Saturday).$mq$),
($mq$ver la tele$mq$, $mq$to watch television. 'Nunca veo la tele.' = I never watch TV.$mq$),
($mq$salir con amigos$mq$, $mq$to go out with friends. 'Salgo con mis amigos los viernes.'$mq$),
($mq$¿Qué haces en tu tiempo libre?$mq$, $mq$What do you do in your free time? A typical question in a listening or speaking task.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Hobbies and Sports$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why this matters
Free time is one of the friendliest topics in Spanish. Almost every beginner text includes people talking about what they like, what they play and how often they do it. You will practise opinions, a few key verbs and frequency words.

## Hobbies and sports
- jugar al fútbol / al baloncesto / al tenis (to play football / basketball / tennis)
- jugar a los videojuegos (to play video games)
- nadar (to swim)
- correr (to run)
- montar en bici (to ride a bike)
- bailar (to dance)
- cantar (to sing)
- leer (to read)
- escuchar música (to listen to music)
- ver la tele (to watch television)
- ir al cine (to go to the cinema)
- salir con amigos (to go out with friends)
- tocar la guitarra / el piano (to play the guitar / the piano)

Notice the difference between 'jugar a' for games and sports, and 'tocar' for instruments: 'juego al tenis' but 'toco la guitarra'.

## Giving opinions
- Me encanta... (I love...)
- Me gusta... (I like...)
- No me gusta... (I do not like...)
- Odio... (I hate...)
- Prefiero... (I prefer...)

After these phrases use the infinitive: 'Me gusta nadar.' For other people change the pronoun: 'A mi hermana le gusta bailar' and 'A mis amigos les gusta ver películas.' With a plural noun use 'gustan': 'Me gustan los deportes.'

## The verb jugar
- yo juego
- tú juegas
- él / ella juega
- nosotros jugamos
- vosotros jugáis
- ellos / ellas juegan

The vowel u changes to ue in all forms except nosotros and vosotros. Say 'Mi amigo juega al tenis' and 'Jugamos al fútbol'.

## How often?
- todos los días (every day)
- los fines de semana (at weekends)
- a menudo (often)
- a veces (sometimes)
- una vez a la semana (once a week)
- nunca (never)

Position matters: 'Nunca veo la tele' means 'I never watch TV'. You can also say 'No veo la tele nunca'.

## Worked example
Read: 'Los sábados juego al fútbol con mis amigos. Por la tarde veo una película. Los domingos no salgo porque tengo que estudiar.'
Question: What does the writer do on Saturday afternoon? Answer: watches a film ('por la tarde veo una película').

## How this is examined
Reading texts are often profiles, forum posts or emails about hobbies. Questions ask what a person likes, how often they do something and what they do not like. Distractors swap people (he / she) or frequency words. In listening transcripts someone answers '¿Qué haces en tu tiempo libre?' and the answer includes several activities with frequency words. In writing you may be asked to write three sentences about your hobbies and one reason.

## Common mistakes
- Using 'jugar' for an instrument
- Forgetting the 'a' after 'jugar': juego al fútbol
- Saying 'jugamos' as 'juegamos'
- Mixing up 'me gusta' (singular) and 'me gustan' (plural noun)
- Mixing up 'a menudo' (often) and 'a veces' (sometimes)

Exam tip: Look for the little words that change the meaning of an activity: nunca, a veces, todos los días and no me gusta. They are the most common reason students choose the wrong answer.$mq$ from st;

-- Free Time and Health > Weather and Seasons
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Free Time and Health$mq$, 5, 7 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Weather and Seasons$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Free Time and Health$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Weather and Seasons$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'hace calor' mean?$mq$, $mq$["it is hot","it is cold","it is windy","it is raining"]$mq$, 0, $mq$'Hace calor' means it is hot. 'Hace frío' is cold and 'hace viento' is windy.$mq$, $mq$easy$mq$),
($mq$What does 'llueve' mean?$mq$, $mq$["it is snowing","it is sunny","it is foggy","it is raining"]$mq$, 3, $mq$'Llover' means to rain. 'Nevar' (nieva) means to snow.$mq$, $mq$easy$mq$),
($mq$Which season is 'el otoño'?$mq$, $mq$["spring","summer","autumn","winter"]$mq$, 2, $mq$'El otoño' is autumn. 'La primavera' is spring, 'el verano' summer and 'el invierno' winter.$mq$, $mq$easy$mq$),
($mq$What does the question '¿Qué tiempo hace?' mean?$mq$, $mq$["What time is it?","What is the weather like?","What day is it?","What are you doing?"]$mq$, 1, $mq$'El tiempo' can mean both time and weather. With 'hace' the question is about the weather.$mq$, $mq$easy$mq$),
($mq$What does 'nieva' mean?$mq$, $mq$["it is snowing","it is raining","it is cloudy","it is hot"]$mq$, 0, $mq$'Nevar' is to snow. The nouns are 'la nieve' (snow) and 'la lluvia' (rain).$mq$, $mq$easy$mq$),
($mq$Complete the sentence: 'En invierno ___ mucho frío.'$mq$, $mq$["es","está","tiene","hace"]$mq$, 3, $mq$Weather expressions use 'hacer': hace frío, hace calor, hace viento. 'Tiene frío' describes a person who feels cold.$mq$, $mq$medium$mq$),
($mq$Read the forecast.

'Mañana en Sevilla: sol y 34 grados. En Bilbao: nublado y lluvia, 17 grados.'

How many degrees warmer is Seville than Bilbao?$mq$, $mq$["34","51","17","7"]$mq$, 2, $mq$The difference is 34 − 17 = 17 degrees. 'Nublado' means cloudy.$mq$, $mq$medium$mq$),
($mq$Read the sentence.

'Me gusta el verano porque hace calor y puedo ir a la playa.'

Why does the speaker like summer?$mq$, $mq$["It is cold and they can ski.","It is hot and they can go to the beach.","It is rainy and they can stay at home.","It is windy and they can fly a kite."]$mq$, 1, $mq$'Hace calor' means it is hot, and 'puedo ir a la playa' means I can go to the beach.$mq$, $mq$medium$mq$),
($mq$Which sentence says 'It is windy and cloudy'?$mq$, $mq$["Hace viento y está nublado.","Hace viento y hay nublado.","Está viento y hace nublado.","Hace viento y es nublado."]$mq$, 0, $mq$Wind uses 'hace viento'. For cloud we use 'está nublado' (it is cloudy). The other options mix the verbs.$mq$, $mq$medium$mq$),
($mq$Which Spanish month means 'March'?$mq$, $mq$["mayo","junio","agosto","marzo"]$mq$, 3, $mq$'Marzo' is March and 'mayo' is May, which look similar. 'Junio' is June and 'agosto' is August.$mq$, $mq$medium$mq$),
($mq$Listening transcript:

'Hoy hace mucho frío y nieva en las montañas. En la costa llueve un poco, pero por la tarde sale el sol.'

What is the weather like on the coast today?$mq$, $mq$["Snow all day","Sun in the morning, rain in the afternoon","Rain at first, then sun in the afternoon","Cold and snowing in the afternoon"]$mq$, 2, $mq$'Llueve un poco' is a little rain, and 'por la tarde sale el sol' means the sun comes out in the afternoon.$mq$, $mq$medium$mq$),
($mq$What does 'Hace buen tiempo, así que vamos a la playa' mean?$mq$, $mq$["The weather is bad, so we are not going to the beach.","The weather is nice, so we are going to the beach.","It is hot, so we are going home.","It is time to go to the beach."]$mq$, 1, $mq$'Buen tiempo' means good weather, and 'así que' means so.$mq$, $mq$medium$mq$),
($mq$Which expression is the opposite of 'hace buen tiempo'?$mq$, $mq$["hace mal tiempo","hace frío","hace sol","hace calor"]$mq$, 0, $mq$The direct opposite of good weather is bad weather. 'Hace frío' is only one type of bad weather.$mq$, $mq$medium$mq$),
($mq$Read the postcard.

'Estoy en Buenos Aires con mi tío. Aquí es julio y es invierno: ¡hace frío y llueve mucho! En mi país ahora es verano. Mañana voy a visitar un museo porque llueve.'

Which statement is correct?$mq$, $mq$["It is summer in Buenos Aires in July, so it is hot.","The writer will go to the beach tomorrow.","The writer's country has winter now.","It is winter in Buenos Aires in July, so it is cold and rainy."]$mq$, 3, $mq$Argentina is in the southern hemisphere, where seasons are the opposite of Spain's. The writer says it is winter in July and that they will visit a museum because of the rain.$mq$, $mq$hard$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["Llueve mucho en otoño.","Hace sol y calor.","Hace llueve en abril.","En primavera hace buen tiempo."]$mq$, 2, $mq$'Llover' is a verb on its own: 'Llueve en abril'. 'Hace' is used only with nouns such as sol, calor, frío and viento.$mq$, $mq$hard$mq$),
($mq$Read the weather chart.

'Temperaturas en Madrid: lunes 12°, martes 15°, miércoles 18°, jueves 21°, viernes 17°.'

Which day is warmest, and how much warmer is it than Monday?$mq$, $mq$["Wednesday, 6 degrees warmer","Thursday, 9 degrees warmer","Thursday, 21 degrees warmer","Friday, 5 degrees warmer"]$mq$, 1, $mq$The highest value is 21° on Thursday ('jueves'). The difference from Monday is 21 − 12 = 9 degrees.$mq$, $mq$hard$mq$),
($mq$Which sentence says 'In spring it often rains, but in summer it is hot'?$mq$, $mq$["En primavera llueve a menudo, pero en verano hace calor.","En primavera hace llueve a menudo, pero en verano hace calor.","En primavera llueve a menudo, pero en verano es calor.","En primavera llueve a menudo, pero en verano tiene calor."]$mq$, 0, $mq$'Llueve' stands alone and weather heat uses 'hace calor'. 'Es calor' is wrong and 'tiene calor' describes a person.$mq$, $mq$hard$mq$),
($mq$Listening transcript:

'El sábado va a hacer sol y mucho calor, 30 grados. El domingo va a haber tormenta por la tarde.' ('Tormenta' means storm.)

Which plan matches the forecast?$mq$, $mq$["Stay in on Saturday and go to the beach on Sunday afternoon","Go skiing on Saturday and Sunday","Have a picnic on Sunday afternoon","Go to the beach on Saturday and stay in on Sunday afternoon"]$mq$, 3, $mq$Saturday will be sunny and hot, so the beach is a good idea. On Sunday afternoon there will be a storm, so it is better to stay in.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Weather and Seasons$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$¿Qué tiempo hace?$mq$, $mq$What is the weather like? Answer with 'hace' + noun: 'Hace sol.'$mq$),
($mq$hace calor / hace frío$mq$, $mq$it is hot / it is cold (weather). 'Tengo calor' means I (a person) am hot.$mq$),
($mq$llueve / nieva$mq$, $mq$it rains / it snows. These verbs stand alone: never 'hace llueve'.$mq$),
($mq$está nublado$mq$, $mq$it is cloudy. Cloud uses 'estar', not 'hacer'.$mq$),
($mq$hace buen / mal tiempo$mq$, $mq$the weather is good / bad. 'Hace buen tiempo, vamos a la playa.'$mq$),
($mq$la primavera, el verano, el otoño, el invierno$mq$, $mq$spring, summer, autumn, winter. Use 'en': 'En otoño llueve mucho.'$mq$),
($mq$enero, febrero, marzo, abril, mayo, junio$mq$, $mq$January to June. Months are not capitalised in Spanish.$mq$),
($mq$julio, agosto, septiembre, octubre, noviembre, diciembre$mq$, $mq$July to December. Months are written with a small letter, and 'septiembre' has a p.$mq$),
($mq$va a hacer sol$mq$, $mq$it is going to be sunny. 'Ir a + infinitive' gives the future forecast.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Weather and Seasons$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why this matters
Weather is a classic beginner topic, because it appears in forecasts, postcards, emails and conversations. It also gives you a perfect chance to practise one of Spanish's most useful verbs: 'hacer'.

## Asking about the weather
- ¿Qué tiempo hace? (What is the weather like?)
- ¿Qué tiempo va a hacer mañana? (What will the weather be like tomorrow?)
- ¿Cuántos grados hace? (How many degrees is it?)

## Weather expressions with hacer
- Hace sol (it is sunny)
- Hace calor (it is hot)
- Hace frío (it is cold)
- Hace viento (it is windy)
- Hace buen tiempo (the weather is good)
- Hace mal tiempo (the weather is bad)

## Other weather expressions
- Llueve (it rains / it is raining)
- Nieva (it snows / it is snowing)
- Está nublado (it is cloudy)
- Hay niebla (it is foggy)
- Hay tormenta (there is a storm)
- Hace 25 grados (it is 25 degrees)

Do not write 'hace llueve'. The verbs 'llover' and 'nevar' do not need 'hace'. Do not use 'tener' for weather, because 'tengo calor' means 'I am hot' (the person), but 'hace calor' means 'it is hot' (the weather).

## Seasons and months
- la primavera (spring)
- el verano (summer)
- el otoño (autumn)
- el invierno (winter)

Months: enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre. In Spanish months and seasons do not begin with a capital letter. Use 'en' with seasons and months: 'En verano hace calor', 'En enero nieva'.

Remember that in the southern hemisphere, in countries such as Argentina and Chile, the seasons are reversed. When it is July, it is winter there.

## Talking about the future weather
Use 'va a' + infinitive: 'Mañana va a llover' (it is going to rain tomorrow), 'Va a hacer sol' (it is going to be sunny), 'Va a haber tormenta' (there will be a storm).

## Worked example
Read: 'Hoy hace viento y está nublado, pero no llueve. Por la tarde hace 18 grados.' What is the weather like today? Windy and cloudy, no rain, 18° in the afternoon.

## How this is examined
In reading, you may meet a short weather forecast for several cities or a postcard. You may have to compare temperatures, find the warmest or coldest place, or choose an activity that suits the weather. In listening, the forecast contains times of day (mañana, por la tarde) which can change the answer. In writing, you may describe the weather in your town in each season and say which you prefer and why.

## Common mistakes
- Writing 'hace llueve' or 'hace nieva'
- Using 'es calor' or 'tiene calor' for the weather
- Mixing up 'frío' (cold) and 'fresco' (cool)
- Forgetting that seasons are opposite in the southern hemisphere

Exam tip: For forecast questions, write down each city or day with its weather and temperature as you read. Then answer the question with your notes, not from memory.$mq$ from st;

-- Free Time and Health > Health and the Body
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Free Time and Health$mq$, 5, 7 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Health and the Body$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Free Time and Health$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Health and the Body$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'la cabeza' mean?$mq$, $mq$["the head","the hand","the leg","the back"]$mq$, 0, $mq$'La cabeza' is the head. 'La mano' is the hand, 'la pierna' the leg and 'la espalda' the back.$mq$, $mq$easy$mq$),
($mq$What does 'el brazo' mean?$mq$, $mq$["the leg","the foot","the neck","the arm"]$mq$, 3, $mq$'El brazo' is the arm. 'La pierna' is the leg.$mq$, $mq$easy$mq$),
($mq$What does 'Tengo fiebre' mean?$mq$, $mq$["I have a cold.","I am hungry.","I have a temperature.","I am cold."]$mq$, 2, $mq$'Fiebre' is fever. A cold is 'un resfriado' or 'un catarro'.$mq$, $mq$easy$mq$),
($mq$What is 'la espalda' in English?$mq$, $mq$["the shoulder","the back","the stomach","the knee"]$mq$, 1, $mq$'La espalda' is the back. 'La rodilla' is the knee and 'el estómago' is the stomach.$mq$, $mq$easy$mq$),
($mq$Who is 'el médico'?$mq$, $mq$["the doctor","the dentist","the chemist","the teacher"]$mq$, 0, $mq$'El médico' is the doctor. A dentist is 'el dentista'.$mq$, $mq$easy$mq$),
($mq$Complete the sentence: 'Me ___ la cabeza.'$mq$, $mq$["duelen","dolor","duelo","duele"]$mq$, 3, $mq$'Doler' works like 'gustar': use 'duele' with a singular body part and 'duelen' with a plural one.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Me ___ los pies.'$mq$, $mq$["duele","duelo","duelen","dolores"]$mq$, 2, $mq$'Los pies' is plural, so the verb is 'duelen'.$mq$, $mq$medium$mq$),
($mq$What does 'Tengo dolor de estómago' mean?$mq$, $mq$["I have a sore throat.","I have stomach ache.","I have a headache.","I have toothache."]$mq$, 1, $mq$'Dolor de' + body part means pain in that part. 'Estómago' is the stomach.$mq$, $mq$medium$mq$),
($mq$Read the dialogue.

'—¿Qué te pasa? —Me duele la garganta y tengo tos. —Debes beber agua caliente y descansar.'

What advice does the speaker get?$mq$, $mq$["Drink hot water and rest","Take a cold shower","Go to the dentist","Do more sport"]$mq$, 0, $mq$'Debes' means you should. 'Beber agua caliente' is to drink hot water and 'descansar' is to rest.$mq$, $mq$medium$mq$),
($mq$What does 'Hay que beber mucha agua' mean?$mq$, $mq$["I drink a lot of water.","There is a lot of water.","Water is expensive.","You have to drink lots of water."]$mq$, 3, $mq$'Hay que' + infinitive is an impersonal expression meaning one must / you have to.$mq$, $mq$medium$mq$),
($mq$Listening transcript:

'Hoy no voy al colegio porque estoy enfermo. Tengo fiebre y me duele todo el cuerpo. Mi madre llama al médico.'

Why is the speaker staying at home?$mq$, $mq$["He has a doctor's appointment.","He is on holiday.","He is ill with a temperature.","He has hurt his foot at football."]$mq$, 2, $mq$'Estoy enfermo' means I am ill and 'tengo fiebre' means I have a temperature.$mq$, $mq$medium$mq$),
($mq$Which sentence says 'My legs hurt'?$mq$, $mq$["Me duele las piernas.","Me duelen las piernas.","Me duelen la pierna.","Tengo duelen las piernas."]$mq$, 1, $mq$'Las piernas' is plural so the verb is 'duelen'. 'Me duelen' already means 'hurt me', so you do not add 'tengo'.$mq$, $mq$medium$mq$),
($mq$What does 'Tengo un resfriado' mean?$mq$, $mq$["I have a cold.","I have a fever.","I have a cough.","I have a headache."]$mq$, 0, $mq$'Un resfriado' (or 'un catarro') is a cold. 'La gripe' is flu.$mq$, $mq$medium$mq$),
($mq$Read the notice in a chemist's.

'Farmacia Sol. Abierto de 9:00 a 21:00. Para la tos: jarabe, dos cucharadas al día. Si tienes fiebre más de tres días, ve al médico.'

When should you see a doctor?$mq$, $mq$["If you have a cough for one day","If you take two spoonfuls of syrup","If the chemist's is closed","If you have a fever for more than three days"]$mq$, 3, $mq$'Más de tres días' means more than three days, and 've al médico' means go to the doctor.$mq$, $mq$hard$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["Me duele el brazo.","Me duelen los dientes.","Me duele las manos.","Tengo dolor de cabeza."]$mq$, 2, $mq$'Las manos' is plural, so the verb must be 'duelen': 'Me duelen las manos'.$mq$, $mq$hard$mq$),
($mq$Read the email.

'Para estar sano, como fruta y verdura todos los días, hago ejercicio tres veces por semana y duermo ocho horas. No bebo refrescos porque tienen mucho azúcar.'

Which statement is correct?$mq$, $mq$["The writer exercises every day and drinks lemonade.","The writer exercises three times a week and avoids sugary drinks.","The writer sleeps three hours and eats fruit.","The writer eats fruit once a week."]$mq$, 1, $mq$'Tres veces por semana' is three times a week. The writer does not drink soft drinks ('refrescos') because they contain a lot of sugar.$mq$, $mq$hard$mq$),
($mq$Which sentence says 'You should rest and take the medicine'?$mq$, $mq$["Debes descansar y tomar la medicina.","Debes descansas y tomas la medicina.","Debo descansar y tomar la medicina.","Debes descansar y toman la medicina."]$mq$, 0, $mq$'Debes' + infinitive means you should. After 'debes' we use the infinitive for both verbs; 'debo' would mean I should.$mq$, $mq$hard$mq$),
($mq$Listening transcript:

'—Buenos días. ¿Qué le pasa? —Me duele mucho la espalda desde el lunes. —¿Hace deporte? —Sí, juego al tenis tres veces a la semana. —Entonces no puede jugar durante dos semanas. Tiene que descansar.'

What is the doctor's advice?$mq$, $mq$["Play more tennis to strengthen the back","Take medicine for three days","Rest for one week, then play tennis","No tennis for two weeks, and rest"]$mq$, 3, $mq$'No puede jugar durante dos semanas' means he cannot play for two weeks, and 'tiene que descansar' means he must rest.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Health and the Body$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Me duele / Me duelen$mq$, $mq$My ... hurts / hurt. 'Me duele la cabeza.' 'Me duelen los pies.' The body part decides singular or plural.$mq$),
($mq$Tengo dolor de cabeza$mq$, $mq$I have a headache. Also: dolor de estómago, de garganta, de muelas (toothache).$mq$),
($mq$Tengo fiebre / tos$mq$, $mq$I have a temperature / a cough. 'Tengo un resfriado' = I have a cold.$mq$),
($mq$Estoy enfermo / enferma$mq$, $mq$I am ill. Use 'estoy' for health. Enfermo = male, enferma = female.$mq$),
($mq$Debes + infinitive$mq$, $mq$You should... 'Debes descansar y beber agua.'$mq$),
($mq$Tienes que + infinitive$mq$, $mq$You have to... 'Tienes que ir al médico.'$mq$),
($mq$Hay que + infinitive$mq$, $mq$One must... (impersonal). 'Hay que dormir ocho horas.'$mq$),
($mq$la mano$mq$, $mq$the hand. Feminine even though it ends in -o: 'la mano', 'las manos'.$mq$),
($mq$¿Qué te pasa?$mq$, $mq$What is wrong with you? Informal. The formal form is '¿Qué le pasa?'$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Health and the Body$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why this matters
Health and the body is a practical topic. It is useful if you are ever unwell in a Spanish-speaking country, and it appears in dialogues at the doctor's, notices in a chemist's and emails about healthy lifestyles. It also teaches the useful verb 'doler' (to hurt).

## Parts of the body
- la cabeza (head)
- el cuello (neck)
- la garganta (throat)
- el brazo (arm)
- la mano (hand)
- la espalda (back)
- el estómago (stomach)
- la pierna (leg)
- la rodilla (knee)
- el pie (foot)
- los ojos (eyes)
- la nariz (nose)
- la boca (mouth)
- los dientes (teeth)

Be careful with gender: 'la mano' is feminine even though it ends in -o.

## Saying what hurts
There are two ways:
- Me duele la cabeza. / Me duelen los pies. (My head hurts. / My feet hurt.)
- Tengo dolor de cabeza / de estómago / de garganta. (I have a headache / stomach ache / sore throat.)

Use 'duele' for one thing and 'duelen' for more than one: 'Me duele el brazo' but 'Me duelen las piernas'. Be careful: the body part is the subject of the sentence, so it decides if the verb is singular or plural.

## Illnesses
- Estoy enfermo / enferma (I am ill)
- Tengo fiebre (I have a temperature)
- Tengo tos (I have a cough)
- Tengo un resfriado (I have a cold)
- Tengo gripe (I have flu)

## Advice
- Debes descansar. (You should rest.)
- Debes beber agua. (You should drink water.)
- Tienes que ir al médico. (You have to go to the doctor.)
- Hay que dormir ocho horas. (One must sleep eight hours.)
- Es bueno hacer ejercicio. (It is good to do exercise.)

After these phrases use the infinitive.

## Healthy living
- comer fruta y verdura (to eat fruit and vegetables)
- beber mucha agua (to drink lots of water)
- hacer ejercicio (to do exercise)
- dormir ocho horas (to sleep eight hours)
- la comida sana (healthy food)
- el azúcar (sugar)

## Doctor's dialogue
- ¿Qué te pasa? / ¿Qué le pasa? (What is wrong? informal / formal)
- Me duele la garganta. (My throat hurts.)
- Tiene que descansar. (You have to rest. formal)

## How this is examined
Reading tasks include a notice in a chemist's, an email about a healthy lifestyle or a message from someone who is ill. You will need to choose what hurts, how long it has lasted, or what advice is given. Listening transcripts usually come as a dialogue with the doctor, and the advice often includes numbers (days, times a week). In writing you may write a short message saying you are ill, what hurts and what you will do.

## Common mistakes
- Saying 'Me duele los pies' instead of 'Me duelen los pies'
- Using 'tengo' with a body part ('tengo la cabeza') instead of 'tengo dolor de cabeza'
- Using 'es' instead of 'estoy' for illness
- Forgetting the article with a body part: 'me duele la cabeza', not 'me duele mi cabeza'

Exam tip: Check whether the body part is singular or plural, because 'duele' and 'duelen' tell you the answer, and always read the advice sentence carefully for numbers and for words like 'no' and 'durante'.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;