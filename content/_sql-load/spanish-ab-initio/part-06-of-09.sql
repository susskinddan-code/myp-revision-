-- Part 6 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Town and Travel > Places in Town
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Town and Travel$mq$, 5, 6 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Places in Town$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Town and Travel$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Places in Town$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'la biblioteca' mean?$mq$, $mq$["library","bookshop","school","bank"]$mq$, 0, $mq$'La biblioteca' is a library, where you borrow books. A bookshop is 'la librería', which looks similar but is a different word.$mq$, $mq$easy$mq$),
($mq$Which Spanish word is a place where you can buy medicine?$mq$, $mq$["la panadería","la piscina","el cine","la farmacia"]$mq$, 3, $mq$'La farmacia' is the chemist's (pharmacy). 'La panadería' sells bread, 'la piscina' is a swimming pool and 'el cine' is the cinema.$mq$, $mq$easy$mq$),
($mq$You want to buy bread. Where do you go?$mq$, $mq$["a la biblioteca","al museo","a la panadería","al banco"]$mq$, 2, $mq$'La panadería' is the bakery. The other places are not shops for food.$mq$, $mq$easy$mq$),
($mq$What does 'el cine' mean?$mq$, $mq$["the circus","the cinema","the church","the centre"]$mq$, 1, $mq$'El cine' is the cinema. 'La iglesia' is the church and 'el centro' is the town centre.$mq$, $mq$easy$mq$),
($mq$What does 'En mi ciudad hay un parque' mean?$mq$, $mq$["In my town there is a park.","My town is a park.","In my town I have a park.","My town has no park."]$mq$, 0, $mq$'Hay' means 'there is / there are'. 'En mi ciudad' means 'in my town'.$mq$, $mq$easy$mq$),
($mq$Complete the sentence: 'En mi barrio ___ una piscina y dos supermercados.'$mq$, $mq$["es","están","tiene","hay"]$mq$, 3, $mq$To say that something exists in a place we use 'hay' (there is / there are). It does not change for singular or plural.$mq$, $mq$medium$mq$),
($mq$Read the description.

'El banco está al lado de la farmacia, enfrente del cine.'

Where is the bank?$mq$, $mq$["Opposite the chemist's and next to the cinema","Behind the chemist's and the cinema","Next to the chemist's and opposite the cinema","Between the chemist's and the cinema"]$mq$, 2, $mq$'Al lado de' means next to, and 'enfrente de' means opposite. 'Entre' would be needed for between.$mq$, $mq$medium$mq$),
($mq$What does 'Mi casa está lejos del colegio' mean?$mq$, $mq$["My house is next to the school.","My house is far from the school.","My house is near the school.","My house is behind the school."]$mq$, 1, $mq$'Lejos de' means far from. Its opposite is 'cerca de' (near to). 'De + el' becomes 'del'.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'El museo está cerca ___ ayuntamiento.'$mq$, $mq$["del","de el","al","de la"]$mq$, 0, $mq$'De' + 'el' always joins to make 'del'. 'Ayuntamiento' (town hall) is masculine, so 'de la' is also wrong.$mq$, $mq$medium$mq$),
($mq$Read the sign on the door of the post office.

'Oficina de correos. Abierto de lunes a viernes, de 9:00 a 14:00. Cerrado sábados y domingos.'

Can you post a letter there on Saturday?$mq$, $mq$["Yes, it is open until 14:00.","Yes, but only in the afternoon.","No, it is only closed on Sundays.","No, it is closed at the weekend."]$mq$, 3, $mq$'Cerrado sábados y domingos' means closed on Saturdays and Sundays, so the answer is no.$mq$, $mq$medium$mq$),
($mq$Listening transcript:

'Vivo en un pueblo pequeño. Hay una iglesia, un mercado y una plaza, pero no hay cine ni piscina. Para ir al cine, tengo que ir a la ciudad.'

Which two places does the village NOT have?$mq$, $mq$["A church and a market","A square and a cinema","A cinema and a swimming pool","A market and a swimming pool"]$mq$, 2, $mq$'No hay cine ni piscina' means there is neither a cinema nor a swimming pool. The church, market and square are in the village.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'There are two banks next to the park'?$mq$, $mq$["Hay dos banco al lado del parque.","Hay dos bancos al lado del parque.","Hay dos bancos al lado de el parque.","Están dos bancos al lado del parque."]$mq$, 1, $mq$The noun needs a plural -s ('bancos'), and 'de + el' becomes 'del'. 'Hay' is used for introducing things that exist, not 'están'.$mq$, $mq$medium$mq$),
($mq$Read the message.

'Quedamos delante del cine a las cinco.' ('Quedamos' means 'we are meeting'.)

What is the plan?$mq$, $mq$["Meet in front of the cinema at five o'clock","Meet behind the cinema at five o'clock","Meet inside the cinema at four o'clock","Meet next to the cinema at fifteen minutes past five"]$mq$, 0, $mq$'Delante de' means in front of, and 'a las cinco' means at five o'clock.$mq$, $mq$medium$mq$),
($mq$Read the email.

'Mi ciudad es grande. Hay un museo famoso en el centro, pero está lejos de mi casa. Cerca de mi casa hay un parque con una piscina, y me gusta nadar allí los sábados.'

What does the writer do on Saturdays?$mq$, $mq$["Visits the famous museum in the centre","Walks to the park to play football","Goes to the swimming pool in the centre","Swims in the park near home"]$mq$, 3, $mq$The museum is far away, but near the house there is a park with a pool where the writer likes swimming ('nadar') on Saturdays.$mq$, $mq$hard$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["Hay una biblioteca en mi barrio.","La farmacia está enfrente del banco.","El parque son cerca de mi casa.","Mi colegio está lejos de la estación."]$mq$, 2, $mq$Location uses 'estar', and 'parque' is singular, so it should be 'El parque está cerca de mi casa'. 'Son' is the plural of 'ser' and is not used for location.$mq$, $mq$hard$mq$),
($mq$Read the tourist leaflet.

'Bienvenidos a Villalba. El mercado está en la plaza mayor, entre el ayuntamiento y la iglesia.'

Where exactly is the market?$mq$, $mq$["Next to the town hall only","Between the town hall and the church","In front of the church only","Behind the town hall and the church"]$mq$, 1, $mq$'Entre ... y ...' means between ... and ... . The market is in the main square, between the two buildings.$mq$, $mq$hard$mq$),
($mq$Which question means 'Is there a chemist's near here?'$mq$, $mq$["¿Hay una farmacia cerca de aquí?","¿Es una farmacia cerca de aquí?","¿Tiene una farmacia aquí cerca?","¿Está una farmacia hay?"]$mq$, 0, $mq$To ask whether something exists we use 'hay'. 'Cerca de aquí' means near here. The other questions use the wrong verbs.$mq$, $mq$hard$mq$),
($mq$Listening transcript:

'Mi barrio tiene de todo: hay un supermercado, una panadería y un polideportivo. Lo que más me gusta es el polideportivo porque juego al baloncesto. Lo que no me gusta es que no hay ningún parque.'

What does the speaker like and dislike?$mq$, $mq$["Likes the park; dislikes the sports centre","Likes the bakery; dislikes the supermarket","Likes basketball; dislikes the sports centre","Likes the sports centre; dislikes that there is no park"]$mq$, 3, $mq$'Lo que más me gusta' introduces the favourite thing (the sports centre). 'No hay ningún parque' means there is no park at all, which the speaker dislikes.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Places in Town$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$la biblioteca / la librería$mq$, $mq$library / bookshop. Do not mix them up: 'biblioteca' is where you borrow books.$mq$),
($mq$hay$mq$, $mq$there is / there are. It never changes and is used to say something exists: 'Hay un parque en mi barrio.'$mq$),
($mq$estar for location$mq$, $mq$El banco está en la calle Mayor. Use 'está / están' to say where a known place is.$mq$),
($mq$cerca de / lejos de$mq$, $mq$near to / far from. 'Mi casa está cerca del parque.'$mq$),
($mq$al lado de / enfrente de$mq$, $mq$next to / opposite. 'La farmacia está al lado del banco, enfrente del cine.'$mq$),
($mq$entre ... y ...$mq$, $mq$between ... and ... 'El mercado está entre el museo y la iglesia.'$mq$),
($mq$de + el / a + el$mq$, $mq$They join: del and al. 'Cerca del parque', 'Voy al cine'. 'De la' and 'a la' stay separate.$mq$),
($mq$la panadería$mq$, $mq$the bakery, where you buy bread. Shops often end in -ería: la farmacia is the exception.$mq$),
($mq$¿Hay un banco por aquí?$mq$, $mq$Is there a bank around here? A polite way to ask whether a place exists nearby.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Places in Town$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why this matters
Describing where you live is one of the most common tasks in beginner Spanish. In reading texts you will meet leaflets, signs and emails about a town. In writing you will often be asked to describe your neighbourhood. This topic gives you the places, the words for where things are, and the grammar to put them together.

## Places in town
- el banco (bank)
- la biblioteca (library)
- el cine (cinema)
- el supermercado (supermarket)
- la farmacia (chemist's)
- la panadería (bakery)
- el parque (park)
- la piscina (swimming pool)
- el polideportivo (sports centre)
- el museo (museum)
- el mercado (market)
- la iglesia (church)
- el ayuntamiento (town hall)
- la oficina de correos (post office)
- la estación (station)
- la plaza (square)
- el centro (town centre)
- el barrio (neighbourhood)

Learn each noun with its article. Most nouns ending in -o are masculine and most ending in -a are feminine, but remember that 'el mapa' and 'el día' are masculine.

## Saying what there is: hay
'Hay' means both 'there is' and 'there are'. It never changes.
- En mi ciudad hay un cine. (In my town there is a cinema.)
- Hay dos bancos en mi calle. (There are two banks on my street.)
- No hay piscina. (There is no swimming pool.)
- ¿Hay una farmacia cerca de aquí? (Is there a chemist's near here?)

## Saying where things are: estar
For location we use 'estar', not 'hay', when we talk about a specific place we already know about.
- El museo está en el centro. (The museum is in the centre.)
- Las tiendas están cerca de la plaza. (The shops are near the square.)

## Position words
- cerca de (near) / lejos de (far from)
- al lado de (next to)
- enfrente de (opposite)
- delante de (in front of) / detrás de (behind)
- entre ... y ... (between ... and ...)

Remember the contractions: de + el = del, and a + el = al. So we say 'El banco está al lado del cine' and 'Voy al parque'. But 'de la' and 'a la' never change.

## Worked example
Read: 'Vivo en un barrio tranquilo. Mi casa está cerca de la biblioteca, enfrente de un parque. Hay una panadería al lado del banco.'
Question: What is opposite the writer's house? Answer: a park ('enfrente de un parque').

## How this is examined
In the reading paper you may see a leaflet, map description or short email and have to decide where a building is or what a town has. In listening transcripts someone describes their neighbourhood, often mentioning what they like and dislike ('lo que no me gusta es que no hay...'). In writing you may be asked for three or four sentences about your town, using 'hay', 'está' and at least one position word.

## Common mistakes
- Using 'es' or 'son' for location instead of 'está' or 'están'
- Writing 'de el' instead of 'del'
- Making 'hay' plural ('hayn')
- Mixing up 'la biblioteca' (library) with 'la librería' (bookshop)
- Forgetting to make the noun plural after a number: 'dos bancos'

Exam tip: Underline the position word in a text (cerca, lejos, enfrente, al lado, entre) before you read the answer options, because wrong answers usually swap one of these words.$mq$ from st;

-- Town and Travel > Asking for and Giving Directions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Town and Travel$mq$, 5, 6 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Asking for and Giving Directions$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Town and Travel$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Asking for and Giving Directions$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'a la derecha' mean?$mq$, $mq$["to the right","to the left","straight on","at the corner"]$mq$, 0, $mq$'Derecha' is right and 'izquierda' is left. 'Todo recto' is straight on.$mq$, $mq$easy$mq$),
($mq$What does 'todo recto' mean?$mq$, $mq$["turn round","on the left","at the end","straight on"]$mq$, 3, $mq$'Todo recto' means straight on. It is used with verbs like 'sigue' (go on).$mq$, $mq$easy$mq$),
($mq$What does 'a la izquierda' mean?$mq$, $mq$["to the right","behind","to the left","in front"]$mq$, 2, $mq$'A la izquierda' means to the left. Do not confuse it with 'derecha' (right).$mq$, $mq$easy$mq$),
($mq$What is 'la esquina' in English?$mq$, $mq$["the street","the corner","the bridge","the lift"]$mq$, 1, $mq$'La esquina' is the corner of a street. 'El puente' is the bridge.$mq$, $mq$easy$mq$),
($mq$What does '¿Dónde está el banco?' mean?$mq$, $mq$["Where is the bank?","When does the bank open?","How much is the bank?","Who is at the bank?"]$mq$, 0, $mq$'Dónde' means where. It is the key question word for asking about locations.$mq$, $mq$easy$mq$),
($mq$Read the directions.

'Sigue todo recto y toma la segunda calle a la izquierda. El cine está a la derecha.'

Where is the cinema?$mq$, $mq$["On the left, in the first street","Straight on, at the end of the road","On the right, in the first street on the right","On the right, in the second street on the left"]$mq$, 3, $mq$First go straight on, then take the second street on the left. Once in that street, the cinema is on the right.$mq$, $mq$medium$mq$),
($mq$A stranger in the street says: 'Gire a la derecha.' How is the stranger speaking to you?$mq$, $mq$["Informally, using tú","To a group of friends","Formally, using usted","As if giving a command to a child"]$mq$, 2, $mq$'Gire' is the formal (usted) command. The informal (tú) form is 'gira'.$mq$, $mq$medium$mq$),
($mq$You stop an adult stranger. Which question is the most suitable?$mq$, $mq$["¿Cómo eres la estación?","Perdone, ¿cómo se va a la estación?","Perdone, ¿cuándo es la estación?","¿Quién está la estación, tío?"]$mq$, 1, $mq$'Perdone' is the polite way to get attention and '¿Cómo se va a...?' asks how to get to a place. The other questions use the wrong question words or are too casual.$mq$, $mq$medium$mq$),
($mq$What does 'Cruza el puente' tell you to do?$mq$, $mq$["Cross the bridge","Cross the road at the lights","Walk round the roundabout","Walk under the bridge"]$mq$, 0, $mq$'Cruzar' means to cross, and 'el puente' is the bridge.$mq$, $mq$medium$mq$),
($mq$You hear: 'Gira a la izquierda en el semáforo.' Where do you turn left?$mq$, $mq$["At the roundabout","At the corner","At the station","At the traffic lights"]$mq$, 3, $mq$'El semáforo' means the traffic lights. A roundabout is 'la rotonda'.$mq$, $mq$medium$mq$),
($mq$Read the directions.

'Estás en la plaza. Toma la calle Mayor, sigue todo recto hasta la rotonda y el museo está enfrente.'

Where is the museum?$mq$, $mq$["In the square, next to the street","On the left of the street","Opposite you when you reach the roundabout","Before the roundabout"]$mq$, 2, $mq$'Hasta la rotonda' means as far as the roundabout, and 'enfrente' means opposite (straight ahead).$mq$, $mq$medium$mq$),
($mq$Listening transcript:

'Para ir a la biblioteca, sal del colegio y gira a la derecha. Sigue unos doscientos metros. La biblioteca está en la esquina, al lado de la panadería.'

What do we learn about the library?$mq$, $mq$["It is about 20 metres away, opposite the bakery","It is about 200 metres away, on the corner next to the bakery","It is about 200 metres away, behind the school","It is on the left, next to the school"]$mq$, 1, $mq$The distance is 'doscientos metros' (200 m), and the library is 'en la esquina, al lado de la panadería'.$mq$, $mq$medium$mq$),
($mq$Which phrase means 'the third street on the right'?$mq$, $mq$["la tercera calle a la derecha","la tercer calle a la derecha","la tercera calle a la izquierda","la segunda calle a la derecha"]$mq$, 0, $mq$'Calle' is feminine, so the ordinal must be 'tercera'. 'Tercer' is only used before a masculine singular noun, as in 'el tercer piso'.$mq$, $mq$medium$mq$),
($mq$Read the directions.

'Sal del hotel. Gira a la izquierda. Cruza la calle. Toma la primera calle a la derecha. La farmacia está al final, a mano izquierda.'

What do you do straight after crossing the street?$mq$, $mq$["Turn left again","Go to the end of the street","Go into the chemist's","Take the first street on the right"]$mq$, 3, $mq$The actions are in order: leave, turn left, cross, then take the first street on the right. The chemist's is only at the end of that street.$mq$, $mq$hard$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["Sigue todo recto hasta la esquina.","Cruza la plaza.","Gira a la izquierdo en el semáforo.","Toma la segunda calle a la derecha."]$mq$, 2, $mq$'Izquierda' ends in -a and does not change. The phrase is 'a la izquierda', never 'a la izquierdo'.$mq$, $mq$hard$mq$),
($mq$Marta replies to a friend who has just arrived at the station.

'Sal por la puerta principal, cruza la plaza y gira a la izquierda. Mi casa está en el número 12, enfrente de la farmacia.'

Which description is correct?$mq$, $mq$["Leave the station, turn left, cross the square; number 12 is next to the chemist's","Leave the station, cross the square, turn left; number 12 is opposite the chemist's","Leave the station, cross the square, turn right; number 12 is opposite the chemist's","Leave the station, cross the square, turn left; number 12 is behind the chemist's"]$mq$, 1, $mq$The order is: main door, cross the square, then turn left. 'Enfrente de' means opposite, not next to or behind.$mq$, $mq$hard$mq$),
($mq$Which sentence says 'Turn right at the roundabout and go straight on'?$mq$, $mq$["Gira a la derecha en la rotonda y sigue todo recto.","Gira a la izquierda en la rotonda y sigue todo recto.","Gira a la derecha en el semáforo y sigue todo recto.","Gira a la derecha en la rotonda y cruza el puente."]$mq$, 0, $mq$Only the first option has the correct direction (derecha), the correct place (rotonda) and the correct second instruction (sigue todo recto).$mq$, $mq$hard$mq$),
($mq$Listening transcript:

'Perdona, ¿hay un supermercado por aquí? —Sí, hay uno bastante cerca. Está a cinco minutos andando. Toma esta calle, cruza el puente y está a la izquierda, al lado del banco.'

Which summary is correct?$mq$, $mq$["It is five minutes by bus: it is on the right next to the bank","It is a five-minute walk: it is on the right before the bridge","It is far away: you need to take a bus past the bank","It is a five-minute walk: cross the bridge and it is on the left next to the bank"]$mq$, 3, $mq$'Andando' means on foot. The directions are: this street, cross the bridge, then it is on the left next to the bank.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Asking for and Giving Directions$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$a la derecha / a la izquierda$mq$, $mq$to the right / to the left. 'Gira a la derecha' = Turn right. Never write 'izquierdo' here.$mq$),
($mq$todo recto$mq$, $mq$straight on. 'Sigue todo recto hasta la esquina.' = Go straight on to the corner.$mq$),
($mq$¿Cómo se va a...?$mq$, $mq$How do you get to...? '¿Cómo se va a la estación?' = How do I get to the station?$mq$),
($mq$Perdone / Perdona$mq$, $mq$Excuse me. 'Perdone' is formal (usted); 'perdona' is informal (tú).$mq$),
($mq$Gira / Gire$mq$, $mq$Turn. 'Gira' is informal (tú); 'gire' is formal (usted).$mq$),
($mq$Sigue / Siga$mq$, $mq$Go on / Carry on. 'Sigue' is informal; 'siga' is formal. Both come from 'seguir'.$mq$),
($mq$el semáforo / la rotonda$mq$, $mq$the traffic lights / the roundabout. 'Gira a la izquierda en el semáforo.'$mq$),
($mq$la tercera calle$mq$, $mq$the third street. Ordinals agree with the noun: la primera, la segunda, la tercera calle.$mq$),
($mq$a cinco minutos andando$mq$, $mq$five minutes away on foot. 'Andando' or 'a pie' means walking.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Asking for and Giving Directions$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why this matters
Asking for and giving directions is a classic task in beginner Spanish exams. You might read a message from a friend who is lost, listen to someone explaining the way to the station, or write directions to your school. Directions use a small set of words, so they are very learnable.

## Asking the way
- Perdone, ¿dónde está el banco? (Excuse me, where is the bank?)
- ¿Cómo se va a la estación? (How do you get to the station?)
- ¿Para ir al museo? (How do I get to the museum?)
- ¿Hay una farmacia por aquí? (Is there a chemist's around here?)
- ¿Está lejos? (Is it far?)

Use 'perdone' with adults you do not know and 'perdona' with people your age.

## Direction words
- a la derecha (to the right)
- a la izquierda (to the left)
- todo recto (straight on)
- al final de la calle (at the end of the street)
- en la esquina (on the corner)
- en el semáforo (at the traffic lights)
- en la rotonda (at the roundabout)
- el puente (the bridge)
- la primera / segunda / tercera calle (the first / second / third street)
- a cien metros (a hundred metres away)
- a cinco minutos andando (five minutes on foot)

Ordinals agree with the noun: 'la primera calle' but 'el primer edificio'. Note that 'primero' and 'tercero' lose the final -o before a masculine singular noun.

## Giving instructions
Informal (tú), used with friends:
- Sigue todo recto. (Go straight on.)
- Gira a la derecha. (Turn right.)
- Cruza la plaza. (Cross the square.)
- Toma la segunda calle. (Take the second street.)

Formal (usted), used with strangers and adults:
- Siga todo recto.
- Gire a la derecha.
- Cruce la plaza.
- Tome la segunda calle.

The tú form looks like the 'he/she' present tense (sigue, gira, cruza, toma). The usted form ends in -e (gire, cruce, tome) except for 'seguir', which becomes 'siga'.

## Worked example
Read: 'Sal del colegio, gira a la izquierda y sigue todo recto hasta el semáforo. Cruza la calle y el parque está enfrente.'
Steps: 1 leave the school, 2 turn left, 3 straight on to the traffic lights, 4 cross the road. The park is opposite. If the question asks 'What do you do at the traffic lights?', the answer is 'cross the street'.

## How this is examined
Texts usually contain three or four instructions in a row, and questions test whether you can keep them in order and decide where the place ends up. Distractors swap left and right, or first and second. In listening transcripts, numbers (metros, minutos) and landmarks (puente, esquina) are often the key detail. In writing you may be asked to give directions from school to a shop in two or three sentences.

## Common mistakes
- Confusing derecha (right) and izquierda (left)
- Writing 'izquierdo' instead of 'izquierda' after 'a la'
- Using tú commands with a stranger
- Using 'hay' instead of 'está' when you ask where a known place is

Exam tip: Draw a quick sketch with arrows while you read or listen to directions. Doing this takes ten seconds and makes it much harder to mix up left, right and the order of the streets.$mq$ from st;

-- Town and Travel > Transport and Holidays
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Town and Travel$mq$, 5, 6 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Transport and Holidays$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Town and Travel$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Transport and Holidays$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'el aeropuerto' mean?$mq$, $mq$["the airport","the harbour","the bus station","the aeroplane"]$mq$, 0, $mq$'El aeropuerto' is the airport. The aircraft itself is 'el avión'.$mq$, $mq$easy$mq$),
($mq$What does 'a pie' mean in 'Voy al colegio a pie'?$mq$, $mq$["by bus","by bike","by car","on foot"]$mq$, 3, $mq$'A pie' means on foot. With vehicles we use 'en': 'en autobús', 'en coche'.$mq$, $mq$easy$mq$),
($mq$What is 'un billete de ida y vuelta'?$mq$, $mq$["a single ticket","a platform ticket","a return ticket","a plane"]$mq$, 2, $mq$'Ida' is the outward journey and 'vuelta' is the return. 'Ida y vuelta' means both.$mq$, $mq$easy$mq$),
($mq$What does 'la playa' mean?$mq$, $mq$["the square","the beach","the mountain","the plane"]$mq$, 1, $mq$'La playa' is the beach. 'La montaña' is the mountain.$mq$, $mq$easy$mq$),
($mq$What does 'Voy en tren' mean?$mq$, $mq$["I go by train.","I go to the train.","I have a train.","I am on foot."]$mq$, 0, $mq$'Voy' is 'I go' and 'en tren' means by train.$mq$, $mq$easy$mq$),
($mq$Complete the sentence: 'Mi hermana va al colegio ___ bicicleta.'$mq$, $mq$["a","por","de","en"]$mq$, 3, $mq$With means of transport we use 'en' (en bicicleta, en tren). The exception is 'a pie' for walking.$mq$, $mq$medium$mq$),
($mq$Read the timetable.

'Tren Madrid–Toledo: salida 9:15, llegada 10:00. Andén 3.'

How long is the journey?$mq$, $mq$["15 minutes","1 hour 15 minutes","45 minutes","1 hour"]$mq$, 2, $mq$From 9:15 to 10:00 is 45 minutes. 'Salida' is departure, 'llegada' is arrival and 'andén' is platform.$mq$, $mq$medium$mq$),
($mq$What does 'Este verano voy a visitar Barcelona' mean?$mq$, $mq$["Last summer I visited Barcelona.","This summer I am going to visit Barcelona.","This summer I am visiting Barcelona every day.","This summer I like Barcelona."]$mq$, 1, $mq$'Ir a + infinitive' expresses a future plan. 'Este verano' means this summer.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Nosotros ___ de vacaciones a la playa.'$mq$, $mq$["vamos","van","voy","vas"]$mq$, 0, $mq$'Ir' in the present tense: yo voy, tú vas, él va, nosotros vamos, ellos van. The subject 'nosotros' needs 'vamos'.$mq$, $mq$medium$mq$),
($mq$Read the postcard.

'¡Hola, Sara! Estoy de vacaciones en la costa. Hace sol y tomo el sol en la playa. Me quedo en un hotel pequeño. ¡Es genial! Un beso, Tomás.'

Where is Tomás staying?$mq$, $mq$["In a campsite","With his family at home","In a big apartment","In a small hotel"]$mq$, 3, $mq$'Me quedo en un hotel pequeño' means I am staying in a small hotel.$mq$, $mq$medium$mq$),
($mq$Listening transcript:

'Atención, pasajeros del vuelo 305 a Sevilla: la salida es por la puerta 12. El avión sale con diez minutos de retraso.' ('Un retraso' means a delay.)

What is the announcement about?$mq$, $mq$["Flight 305 from Seville arrives at gate 12 early","Flight 312 to Seville leaves ten minutes early","Flight 305 to Seville leaves from gate 12, ten minutes late","Flight 305 to Seville is cancelled"]$mq$, 2, $mq$The announcement gives the flight number (305), destination (Sevilla), gate (puerta 12) and a ten-minute delay.$mq$, $mq$medium$mq$),
($mq$Which sentence says 'I prefer travelling by plane because it is fast'?$mq$, $mq$["Prefiero viajar a avión porque es rápido.","Prefiero viajar en avión porque es rápido.","Prefiero viajar en avión porque son rápido.","Prefiero viajar en avión porque está rápido."]$mq$, 1, $mq$We use 'en' with transport, and 'es rápido' describes a characteristic of the plane. 'Está rápido' would describe a temporary state.$mq$, $mq$medium$mq$),
($mq$What does 'Hago camping en agosto' mean?$mq$, $mq$["I go camping in August.","I make a tent in August.","I go to a campsite shop in August.","I stay at a hotel in August."]$mq$, 0, $mq$'Hacer camping' means to go camping. 'Agosto' is August.$mq$, $mq$medium$mq$),
($mq$Read the text.

'Este año mis padres y yo vamos a pasar dos semanas en Galicia. Vamos en coche porque el viaje es largo pero barato. Nos quedamos en un camping cerca del mar. Mi hermano prefiere la montaña, pero yo prefiero la playa.'

Which statement is true?$mq$, $mq$["They travel by train and stay at a hotel in the mountains.","They travel by car and stay in a hotel near the beach.","They travel by plane and stay at a campsite.","They travel by car and stay at a campsite near the sea."]$mq$, 3, $mq$'En coche' is by car and 'un camping cerca del mar' is a campsite near the sea. Only the writer's brother prefers the mountains.$mq$, $mq$hard$mq$),
($mq$Which sentence is correct?$mq$, $mq$["Mis amigos vamos a la playa en autobús.","Mis amigos va a la playa en autobús.","Mis amigos van a la playa en autobús.","Mis amigos voy a la playa en autobús."]$mq$, 2, $mq$The plural subject 'mis amigos' needs 'van'. 'Vamos' goes with 'nosotros'.$mq$, $mq$hard$mq$),
($mq$Read the price list.

'Billete de ida: 14 €. Billete de ida y vuelta: 24 €.'

Ana needs to go and come back. How much does she save by buying one return ticket instead of two single tickets?$mq$, $mq$["10 euros","4 euros","14 euros","6 euros"]$mq$, 1, $mq$Two single tickets cost 2 × 14 = 28 euros. The return costs 24 euros, so she saves 28 − 24 = 4 euros.$mq$, $mq$hard$mq$),
($mq$Which sentence says 'Last year I went to Mexico by plane'?$mq$, $mq$["El año pasado fui a México en avión.","El año pasado voy a México en avión.","El año pasado fue a México en avión.","El año pasado fui a México a avión."]$mq$, 0, $mq$'Fui' is 'I went' (past of 'ir'). 'Fue' is the he/she form, and 'voy' is present. Transport takes 'en'.$mq$, $mq$hard$mq$),
($mq$Listening transcript:

'Este verano no vamos a ir al extranjero. Vamos a visitar a mis abuelos en un pueblo de la montaña. Allí no hay playa, pero hay un río y podemos nadar. Vamos en tren y después en autobús.'

Which statement is correct?$mq$, $mq$["They will fly abroad to a village with a beach.","They will take a bus and then a train to a village with a beach.","They will stay at home and swim in the pool.","They will take a train and then a bus to a mountain village where they can swim in a river."]$mq$, 3, $mq$'No vamos a ir al extranjero' means they are not going abroad. The village has a river, not a beach, and they travel by train then bus.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Transport and Holidays$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$ir: voy, vas, va, vamos, vais, van$mq$, $mq$The present tense of 'ir' (to go) is irregular. 'Nosotros vamos a la playa.'$mq$),
($mq$en autobús / en tren / en coche$mq$, $mq$by bus / by train / by car. Transport takes 'en'. Walking is the exception: 'a pie'.$mq$),
($mq$un billete de ida y vuelta$mq$, $mq$a return ticket. 'Un billete de ida' is a single ticket.$mq$),
($mq$la salida / la llegada$mq$, $mq$departure / arrival. Timetables list both: 'salida 9:15, llegada 10:00'.$mq$),
($mq$el andén$mq$, $mq$the platform at a station. 'El tren sale del andén 3.'$mq$),
($mq$voy a + infinitive$mq$, $mq$I am going to... A near-future plan: 'Voy a visitar a mis abuelos.'$mq$),
($mq$tomar el sol$mq$, $mq$to sunbathe (literally to take the sun). 'Tomo el sol en la playa.'$mq$),
($mq$fui a...$mq$, $mq$I went to... Past of 'ir': 'El año pasado fui a México.' Fue = he/she went; fuimos = we went.$mq$),
($mq$quedarse en un hotel$mq$, $mq$to stay in a hotel. 'Me quedo en un hotel pequeño.' = I am staying in a small hotel.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Transport and Holidays$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why this matters
Holidays and travel appear in nearly every set of beginner Spanish materials. Typical tasks include reading a postcard, understanding a travel announcement, working out a timetable and writing about where you went or where you are going. This topic combines vocabulary with the verb 'ir' (to go).

## Transport
- el autobús (bus)
- el tren (train)
- el metro (underground)
- el coche (car)
- la bicicleta / la bici (bicycle)
- el avión (plane)
- el barco (boat, ship)
- a pie (on foot)

Say how you travel with 'en': voy en tren, vamos en coche. The only exception is walking: voy a pie.

## Stations and airports
- la estación (station)
- el aeropuerto (airport)
- el andén (platform)
- la salida / la llegada (departure / arrival)
- un billete de ida (single ticket)
- un billete de ida y vuelta (return ticket)
- el vuelo (flight)
- la puerta (gate)
- un retraso (a delay)

## Holiday vocabulary
- las vacaciones (holidays)
- la playa (beach) / la montaña (mountain) / el campo (countryside)
- el hotel / el camping (campsite)
- tomar el sol (to sunbathe)
- hacer camping (to go camping)
- visitar museos (to visit museums)
- quedarse (to stay): me quedo, nos quedamos

## The verb ir
- yo voy
- tú vas
- él / ella va
- nosotros vamos
- vosotros vais
- ellos / ellas van

We say 'voy a la playa' (a + la) and 'voy al parque' (a + el = al).

## Talking about the future
Use ir + a + infinitive for plans: 'Voy a visitar Madrid' (I am going to visit Madrid), 'Vamos a hacer camping' (we are going to go camping). Time words help: este verano, el año que viene, mañana.

## Talking about the past
You only need a few useful past forms at this level: 'fui' (I went), 'fue' (he/she went) and 'fuimos' (we went). Time words such as 'el año pasado' (last year) signal the past: 'El año pasado fui a México en avión.'

## How this is examined
Reading texts are often postcards, timetables, tickets or adverts. Questions ask for times, prices, destinations and the means of transport. Distractors usually change one detail, such as train for bus or single for return. In listening transcripts, announcements give a flight, a gate and a time; focus on numbers. In writing, you might describe your last holiday or your plans: where, with whom, how you travel and what you do.

## Common mistakes
- Using 'a' for transport instead of 'en'
- Using 'va' with 'nosotros' instead of 'vamos'
- Forgetting 'a' in 'voy a visitar'
- Mixing up salida and llegada

Exam tip: When a question includes arithmetic, such as ticket prices or journey times, write the numbers from the text first, then calculate. Do not trust a first glance at the options.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;