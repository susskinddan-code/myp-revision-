-- Part 3 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Home and Daily Life > Rooms and Furniture
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Home and Daily Life$mq$, 5, 3 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Rooms and Furniture$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Home and Daily Life$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Rooms and Furniture$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'la cocina' mean?$mq$, $mq$["The kitchen","The living room","The bathroom","The garden"]$mq$, 0, $mq$'La cocina' is the kitchen. The living room is 'el salón' and the bathroom is 'el baño'.$mq$, $mq$easy$mq$),
($mq$What does 'el dormitorio' mean?$mq$, $mq$["The dining room","The garage","The corridor","The bedroom"]$mq$, 3, $mq$'Dormitorio' comes from 'dormir' (to sleep) and means bedroom. 'La habitación' also means room or bedroom.$mq$, $mq$easy$mq$),
($mq$What does 'la cama' mean?$mq$, $mq$["The chair","The table","The bed","The wardrobe"]$mq$, 2, $mq$'La cama' is the bed. The chair is 'la silla' and the wardrobe is 'el armario'.$mq$, $mq$easy$mq$),
($mq$Where would you take a shower?$mq$, $mq$["en la cocina","en el baño","en el jardín","en el garaje"]$mq$, 1, $mq$'El baño' is the bathroom, where you take a shower ('ducharse').$mq$, $mq$easy$mq$),
($mq$What does 'el jardín' mean?$mq$, $mq$["The garden","The garage","The kitchen","The balcony"]$mq$, 0, $mq$'El jardín' is the garden, with an accent on the í. A balcony is 'el balcón'.$mq$, $mq$easy$mq$),
($mq$Read: 'El libro está sobre la mesa.'

Where is the book?$mq$, $mq$["Under the table","Next to the table","In the table","On the table"]$mq$, 3, $mq$'Sobre' means on. 'Debajo de' is under and 'al lado de' is next to.$mq$, $mq$medium$mq$),
($mq$Read: 'El gato está debajo de la silla.'

Where is the cat?$mq$, $mq$["On the chair","In front of the chair","Under the chair","Behind the chair"]$mq$, 2, $mq$'Debajo de' means under. 'Encima de' would be on top of, 'delante de' in front of and 'detrás de' behind.$mq$, $mq$medium$mq$),
($mq$Read the flat description.

'Vivo en un piso en Valencia. Tiene tres dormitorios, una cocina, un salón y dos baños. No tiene jardín, pero tiene una terraza.'

Which statement is true?$mq$, $mq$["The flat has a garden.","The flat has two bathrooms.","The flat has two bedrooms.","The flat has no kitchen."]$mq$, 1, $mq$'Dos baños' means two bathrooms. The flat has three bedrooms and a kitchen; it has no garden but does have a terrace.$mq$, $mq$medium$mq$),
($mq$Complete: '___ una lámpara en mi habitación.'$mq$, $mq$["Hay","Están","Es","Soy"]$mq$, 0, $mq$'Hay' means 'there is/there are' and is used to say that something exists in a place.$mq$, $mq$medium$mq$),
($mq$Complete: 'El sofá ___ en el salón.'$mq$, $mq$["hay","es","tiene","está"]$mq$, 3, $mq$'Estar' is used to say where a specific object is located: 'El sofá está en el salón'.$mq$, $mq$medium$mq$),
($mq$Which noun is feminine?$mq$, $mq$["el sofá","el armario","la estantería","el garaje"]$mq$, 2, $mq$'La estantería' (shelves/bookcase) is feminine. 'Sofá', 'armario' and 'garaje' are masculine, even though 'sofá' ends in a vowel with an accent.$mq$, $mq$medium$mq$),
($mq$Listening transcript:

'Mi habitación es pequeña. La cama está a la izquierda de la puerta y el escritorio está delante de la ventana. El armario está al lado del escritorio.'

Where is the desk?$mq$, $mq$["Behind the window","In front of the window","Next to the bed","Under the window"]$mq$, 1, $mq$'Delante de' means in front of. The wardrobe is next to the desk, and the bed is on the left of the door.$mq$, $mq$medium$mq$),
($mq$Read: 'El baño está a la derecha de la cocina.'

What does it say?$mq$, $mq$["The bathroom is to the right of the kitchen.","The bathroom is to the left of the kitchen.","The bathroom is behind the kitchen.","The kitchen is to the right of the bathroom."]$mq$, 0, $mq$'A la derecha de' means to the right of. The bathroom is the thing being located, so it is to the right of the kitchen.$mq$, $mq$medium$mq$),
($mq$Read: 'El comedor está entre la cocina y el salón.'

Which room is in the middle?$mq$, $mq$["The kitchen","The living room","The garden","The dining room"]$mq$, 3, $mq$'Entre' means between. The dining room is between the kitchen and the living room.$mq$, $mq$hard$mq$),
($mq$Read the plan of a house.

'Planta baja: cocina, comedor, salón. Primera planta: tres dormitorios y un baño.'

Where are the bedrooms?$mq$, $mq$["On the ground floor","In the garden","On the first floor","In the garage"]$mq$, 2, $mq$'Planta baja' is the ground floor and 'primera planta' is the first floor. The bedrooms are listed under the first floor.$mq$, $mq$hard$mq$),
($mq$Which phrase is correct for 'next to the sofa'?$mq$, $mq$["al lado de el sofá","al lado del sofá","al lado a el sofá","al lado de la sofá"]$mq$, 1, $mq$'De' + 'el' contracts to 'del': 'al lado del sofá'. 'Sofá' is masculine, so 'la sofá' is wrong.$mq$, $mq$hard$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["El armario está en el cocina.","La lámpara está encima de la mesa.","Los libros están en la estantería.","Hay una silla debajo de la mesa."]$mq$, 0, $mq$'Cocina' is feminine, so the article must be 'la': 'en la cocina'. The other sentences are correct.$mq$, $mq$hard$mq$),
($mq$Marta needs a home with three bedrooms and a garden. Read this advert.

'Piso de dos dormitorios, cocina grande, un baño y balcón. Cerca del parque.'

Does the flat suit Marta?$mq$, $mq$["Yes, it has everything she needs.","No, it has no kitchen.","Yes, because it is near a park.","No, it has two bedrooms and no garden."]$mq$, 3, $mq$The flat has only two bedrooms (not three) and a balcony instead of a garden. A park nearby is not the same as a garden.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Rooms and Furniture$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$la cocina, el salón, el comedor$mq$, $mq$kitchen, living room, dining room.$mq$),
($mq$el dormitorio / la habitación$mq$, $mq$bedroom (la habitación can also mean any room).$mq$),
($mq$Hay vs está$mq$, $mq$Hay = there is/are (introduces things: Hay una silla). Está/están = is/are located (La silla está en la cocina).$mq$),
($mq$encima de / debajo de$mq$, $mq$on top of / under. Example: El gato está debajo de la silla.$mq$),
($mq$delante de / detrás de$mq$, $mq$in front of / behind. Example: El escritorio está delante de la ventana.$mq$),
($mq$a la izquierda de / a la derecha de$mq$, $mq$to the left of / to the right of.$mq$),
($mq$al lado de + el → ?$mq$, $mq$al lado del. 'De + el' always contracts to 'del': al lado del sofá.$mq$),
($mq$la planta baja$mq$, $mq$The ground floor. 'La primera planta' is the first floor.$mq$),
($mq$el sofá, el garaje, el salón$mq$, $mq$All masculine, even though some do not end in -o. Learn the article with each noun.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Rooms and Furniture$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Describing your home
Talking about where you live is a very common topic. In the eAssessment you may read an advert for a flat, listen to someone describing their bedroom, or write an email to an exchange student about your house. You need room names, furniture, and words for position.

## Types of home
- la casa (house), el piso (flat, in Spain), el apartamento (apartment)
- el edificio (building), la planta baja (ground floor), la primera planta (first floor)

## Rooms
- la cocina (kitchen), el salón (living room), el comedor (dining room)
- el dormitorio / la habitación (bedroom), el baño (bathroom)
- el jardín (garden), la terraza (terrace), el balcón (balcony)
- el garaje (garage), el pasillo (corridor)

## Furniture and objects
- la mesa (table), la silla (chair), el sofá (sofa)
- la cama (bed), el armario (wardrobe), la estantería (shelves)
- el escritorio (desk), la lámpara (lamp), la ventana (window), la puerta (door)

## Position words
- en (in / on), sobre / encima de (on top of)
- debajo de (under), al lado de (next to)
- delante de (in front of), detrás de (behind)
- entre (between), a la izquierda de (to the left of), a la derecha de (to the right of)

Watch the contractions: 'de + el' becomes 'del' and 'a + el' becomes 'al'. So we say 'al lado del sofá' but 'al lado de la mesa'.

## Hay or estar?
- 'Hay' means there is / there are. It introduces something: Hay una lámpara en mi habitación. Hay tres sillas.
- 'Estar' says where a known thing is: La lámpara está encima de la mesa. Los libros están en la estantería.

Trick: if the noun has 'el, la, mi, tu', you usually need 'está/están'. If it has 'un, una, dos', you usually need 'hay'.

## Describing a room
'Mi habitación es pequeña pero cómoda. Hay una cama, un escritorio y un armario. La cama está a la izquierda de la ventana. El escritorio está delante de la ventana.' (My bedroom is small but comfortable. There is a bed, a desk and a wardrobe. The bed is on the left of the window. The desk is in front of the window.)

## Gender
Most nouns ending in -o are masculine and those ending in -a are feminine, but beware: el sofá, el garaje and el salón are masculine. Learn the article with each noun.

## How this is examined
In reading, an advert or a floor plan is often given and you must find rooms, numbers or the position of an object, or decide whether the home suits someone's needs. In listening, you may hear someone say where furniture is, and the key is to catch the position word (a la izquierda, delante de). In writing, you describe your house in five to six sentences using 'hay', 'está', adjectives and position words.

## Common mistakes
- Using 'es' for location (El sofá es en el salón): use 'está'
- Writing 'de el' instead of 'del'
- Forgetting the accent in 'jardín', 'balcón', 'sofá'
- Using the wrong article: 'la cocina', not 'el cocina'

Exam tip: In plan or advert questions, check the numbers (how many bedrooms) and the exact words (garden, balcony, terrace) before choosing, as options are often close.$mq$ from st;

-- Home and Daily Life > Daily Routines
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Home and Daily Life$mq$, 5, 3 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Daily Routines$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Home and Daily Life$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Daily Routines$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'Me levanto' mean?$mq$, $mq$["I get up","I go to bed","I have breakfast","I get dressed"]$mq$, 0, $mq$'Levantarse' means to get up, so 'me levanto' is 'I get up'.$mq$, $mq$easy$mq$),
($mq$What does 'Desayuno' mean?$mq$, $mq$["I have dinner","I have lunch","I have a snack","I have breakfast"]$mq$, 3, $mq$'Desayuno' means 'I have breakfast'. Lunch is 'almuerzo' (or the verb 'comer') and dinner is 'cena'.$mq$, $mq$easy$mq$),
($mq$What does 'Me acuesto' mean?$mq$, $mq$["I wake up","I have a shower","I go to bed","I go out"]$mq$, 2, $mq$'Acostarse' means to go to bed. 'Me despierto' means I wake up.$mq$, $mq$easy$mq$),
($mq$What does 'por la mañana' mean?$mq$, $mq$["at night","in the morning","in the afternoon","at midday"]$mq$, 1, $mq$'Por la mañana' means in the morning. 'Por la tarde' is in the afternoon and 'por la noche' is at night.$mq$, $mq$easy$mq$),
($mq$What does 'nunca' mean?$mq$, $mq$["never","always","sometimes","often"]$mq$, 0, $mq$'Nunca' means never. 'Siempre' means always and 'a veces' means sometimes.$mq$, $mq$easy$mq$),
($mq$Complete: 'Mi hermano ___ a las siete.'$mq$, $mq$["me levanto","te levantas","nos levantamos","se levanta"]$mq$, 3, $mq$'Mi hermano' is third person singular, so the reflexive pronoun is 'se' and the verb is 'levanta': 'se levanta'.$mq$, $mq$medium$mq$),
($mq$Complete: 'Yo ___ los deberes por la tarde.'$mq$, $mq$["haces","hace","hago","hacemos"]$mq$, 2, $mq$'Hacer' is irregular in the 'yo' form: 'hago'. 'Los deberes' means homework.$mq$, $mq$medium$mq$),
($mq$Read the text.

'Normalmente me despierto a las seis y media. Me ducho, me visto y desayuno cereales. Voy al colegio en autobús. Vuelvo a casa a las tres.'

How does the writer travel to school?$mq$, $mq$["On foot","By bus","By car","By bike"]$mq$, 1, $mq$'Voy al colegio en autobús' means 'I go to school by bus'.$mq$, $mq$medium$mq$),
($mq$Which sentence means 'I never have breakfast'?$mq$, $mq$["Nunca desayuno.","Siempre desayuno.","A veces desayuno.","Todos los días desayuno."]$mq$, 0, $mq$'Nunca' means never. 'Siempre' means always, 'a veces' sometimes and 'todos los días' every day.$mq$, $mq$medium$mq$),
($mq$Read: 'Primero me ducho, luego me visto y después desayuno.'

What does the speaker do second?$mq$, $mq$["Has a shower","Has breakfast","Goes to bed","Gets dressed"]$mq$, 3, $mq$The order words are 'primero' (first), 'luego' (then) and 'después' (afterwards). The second action is 'me visto', get dressed.$mq$, $mq$medium$mq$),
($mq$What does 'Vuelvo a casa' mean?$mq$, $mq$["I leave home","I stay at school","I return home","I go out with friends"]$mq$, 2, $mq$'Volver' means to return or come back, so 'vuelvo a casa' means 'I return home'.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'I get up at seven and take a shower'?$mq$, $mq$["Levanto me a las siete y ducho me.","Me levanto a las siete y me ducho.","Me levanto a las siete y ducho.","Se levanto a las siete y se ducho."]$mq$, 1, $mq$Both verbs are reflexive and the subject is 'yo', so each needs 'me': 'me levanto' and 'me ducho'.$mq$, $mq$medium$mq$),
($mq$Listening transcript:

'Los sábados no me levanto temprano. Me levanto a las diez y desayuno con mi familia. Por la tarde juego al fútbol y por la noche veo la tele.'

What does the speaker do on Saturday afternoons?$mq$, $mq$["Plays football","Watches television","Has breakfast with the family","Gets up early"]$mq$, 0, $mq$'Por la tarde juego al fútbol' means in the afternoon the speaker plays football. Television is at night.$mq$, $mq$medium$mq$),
($mq$Two friends describe their mornings.

Ana: 'Me levanto a las siete y cuarto.'
Beto: 'Me levanto a las siete y media.'

Who gets up earlier and by how many minutes?$mq$, $mq$["Beto, by 15 minutes","Ana, by 30 minutes","Beto, by 30 minutes","Ana, by 15 minutes"]$mq$, 3, $mq$Ana gets up at 7:15 and Beto at 7:30. Ana is earlier by 15 minutes.$mq$, $mq$hard$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["Mi madre se ducha por la mañana.","Yo me acuesto a las once.","Ellos se despierta a las ocho.","Nosotros nos levantamos temprano."]$mq$, 2, $mq$'Ellos' (they) needs the plural verb: 'se despiertan'. 'Se despierta' is for one person.$mq$, $mq$hard$mq$),
($mq$Read the message.

'Mi día no es fácil: me levanto a las cinco porque el colegio está lejos. Voy en tren y llego a las siete. Por la noche estoy muy cansada.'

Why does the writer get up at five?$mq$, $mq$["She likes the morning.","School is far away.","She has football practice.","She has a part-time job."]$mq$, 1, $mq$'Porque el colegio está lejos' means 'because school is far away'. 'Cansada' also shows the writer is a girl.$mq$, $mq$hard$mq$),
($mq$In the sentence 'Me ducho', what is the job of the word 'me'?$mq$, $mq$["It is a reflexive pronoun showing the person does the action to themselves","It means 'my' in front of a noun","It is the object in 'give me', meaning someone gives something to the speaker","It makes the sentence negative"]$mq$, 0, $mq$'Me' is a reflexive pronoun: the subject does the action to or for themselves (I shower myself). It must change with the subject: te, se, nos, os, se.$mq$, $mq$hard$mq$),
($mq$Which sentence uses the correct form of 'dormir' (to sleep) for 'nosotros'?$mq$, $mq$["Nosotros duermemos ocho horas.","Nosotros duermimos ocho horas.","Nosotros dormemos ocho horas.","Nosotros dormimos ocho horas."]$mq$, 3, $mq$'Dormir' changes its stem (duermo, duermes, duerme, duermen) except in 'nosotros' and 'vosotros'. So it is 'dormimos'.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Daily Routines$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$me levanto, te levantas, se levanta$mq$, $mq$I get up, you get up, he/she gets up. Reflexive verbs need a pronoun that matches the subject.$mq$),
($mq$hacer → yo$mq$, $mq$hago. Irregular 'yo' form. Yo hago los deberes = I do my homework.$mq$),
($mq$ir (to go) – present tense$mq$, $mq$voy, vas, va, vamos, vais, van.$mq$),
($mq$volver (to return)$mq$, $mq$vuelvo, vuelves, vuelve, volvemos, volvéis, vuelven. The o changes to ue except in nosotros and vosotros.$mq$),
($mq$dormir → nosotros$mq$, $mq$dormimos. The stem change (duermo) does not happen in nosotros and vosotros.$mq$),
($mq$siempre, a veces, nunca$mq$, $mq$always, sometimes, never. Frequency words used in routines.$mq$),
($mq$primero, luego, después$mq$, $mq$first, then, afterwards. Sequencing words to put actions in order.$mq$),
($mq$por la mañana / tarde / noche$mq$, $mq$in the morning / afternoon / at night.$mq$),
($mq$Me acuesto a las diez$mq$, $mq$I go to bed at ten. 'Acostarse' is reflexive and stem-changing (o to ue).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Daily Routines$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Talking about your day
Daily routine is a favourite topic because it combines verbs, time expressions and sequencing words. In the eAssessment you might read a blog post by a student about a typical day, listen to someone describing what they do on weekends, or write about your own routine.

## Key verbs (present tense)
Regular verbs follow patterns. For -ar verbs: -o, -as, -a, -amos, -áis, -an. For -er verbs: -o, -es, -e, -emos, -éis, -en. For -ir verbs: -o, -es, -e, -imos, -ís, -en.
- desayunar (to have breakfast): desayuno, desayunas, desayuna...
- comer (to eat): como, comes, come...
- vivir (to live): vivo, vives, vive...

Irregular and stem-changing verbs are very common in routines:
- hacer (to do/make): hago, haces, hace, hacemos, hacéis, hacen
- ir (to go): voy, vas, va, vamos, vais, van
- volver (to return): vuelvo, vuelves, vuelve, volvemos, volvéis, vuelven
- dormir (to sleep): duermo, duermes, duerme, dormimos, dormís, duermen

## Reflexive verbs
Many routine verbs are reflexive and need a pronoun: me, te, se, nos, os, se.
- levantarse (to get up): me levanto, te levantas, se levanta, nos levantamos, os levantáis, se levantan
- ducharse (to shower), vestirse (to get dressed: me visto), acostarse (to go to bed: me acuesto), despertarse (to wake up: me despierto)

The pronoun must match the subject: 'Mi hermano se levanta', not 'se levanto'.

## Time expressions and frequency
- por la mañana (in the morning), por la tarde (in the afternoon), por la noche (at night)
- todos los días (every day), los sábados (on Saturdays)
- siempre (always), normalmente (usually), a veces (sometimes), nunca (never)

## Sequencing words
- primero (first), luego (then), después (afterwards), por último (finally)

## A model routine
'Normalmente me levanto a las siete. Primero me ducho, luego me visto y después desayuno. Voy al colegio en autobús. Vuelvo a casa a las tres, hago los deberes y por la noche ceno con mi familia. Me acuesto a las diez.' (I usually get up at seven. First I shower, then I get dressed and afterwards I have breakfast. I go to school by bus. I return home at three, do my homework and in the evening I have dinner with my family. I go to bed at ten.)

## Worked example
Question: 'Ana se levanta a las 7:15 y Beto a las 7:30. ¿Quién se levanta antes?' Compare the times: 7:15 is before 7:30, so Ana gets up earlier, by 15 minutes.

## How this is examined
Reading texts are often diaries, blogs or timetables. Questions ask when someone does an activity, in what order, or why. In listening, sequencing words and times are the key clues. In writing you describe your routine using at least five different verbs, a few reflexives, frequency words and sequencing words.

## Common mistakes
- Leaving out the reflexive pronoun: 'levanto' instead of 'me levanto'
- Using the wrong person: 'ellos se despierta'
- Forgetting stem changes: 'duermo', not 'dormo'
- Forgetting that reflexive pronouns change with the subject

Exam tip: Underline the subject and check that the verb ending and the reflexive pronoun both match it before you pick or write an answer.$mq$ from st;

-- Home and Daily Life > Telling the Time
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Home and Daily Life$mq$, 5, 3 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Telling the Time$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Home and Daily Life$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Telling the Time$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What time is 'Son las tres'?$mq$, $mq$["3:00","2:00","13:00","3:30"]$mq$, 0, $mq$'Son las tres' is three o'clock. Hours from two onwards use 'son las'.$mq$, $mq$easy$mq$),
($mq$What time is 'Es la una'?$mq$, $mq$["11:00","12:00","2:00","1:00"]$mq$, 3, $mq$One o'clock uses the singular: 'Es la una'. Eleven would be 'Son las once'.$mq$, $mq$easy$mq$),
($mq$What does 'y media' mean when telling the time?$mq$, $mq$["quarter past","quarter to","half past","o'clock"]$mq$, 2, $mq$'Y media' means 'and a half', that is, half past the hour: 'Son las cinco y media' is 5:30.$mq$, $mq$easy$mq$),
($mq$What time is 'las cinco y cuarto'?$mq$, $mq$["4:45","5:15","5:30","5:45"]$mq$, 1, $mq$'Y cuarto' means quarter past, so 'las cinco y cuarto' is 5:15.$mq$, $mq$easy$mq$),
($mq$What does '¿Qué hora es?' mean?$mq$, $mq$["What time is it?","What day is it?","What is the date?","What time does it start?"]$mq$, 0, $mq$'¿Qué hora es?' asks the current time. '¿A qué hora...?' asks at what time something happens.$mq$, $mq$easy$mq$),
($mq$What time is 'Son las ocho menos cuarto'?$mq$, $mq$["8:15","8:45","7:15","7:45"]$mq$, 3, $mq$'Menos cuarto' means quarter to. A quarter to eight is 7:45.$mq$, $mq$medium$mq$),
($mq$'La clase empieza a las nueve y media.' When does the class start?$mq$, $mq$["8:30","9:15","9:30","9:45"]$mq$, 2, $mq$'Nueve y media' is half past nine: 9:30.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'It is ten past one'?$mq$, $mq$["Son la una y diez.","Es la una y diez.","Son las una y diez.","Es las una y diez."]$mq$, 1, $mq$For one o'clock we use the singular 'es la una'. So '1:10' is 'Es la una y diez'.$mq$, $mq$medium$mq$),
($mq$Read the timetable.

'Matemáticas: las ocho y media. Inglés: las nueve y media. Recreo: las diez y media. Ciencias: las once.'

At what time is Science?$mq$, $mq$["11:00","10:30","9:30","8:30"]$mq$, 0, $mq$'Las once' is 11:00. The break (recreo) is at 10:30.$mq$, $mq$medium$mq$),
($mq$Listening transcript:

'El tren a Sevilla sale a las cuatro y veinte de la tarde y llega a las siete menos cinco.'

When does the train leave and arrive?$mq$, $mq$["4:20 p.m.; 7:05","4:40 p.m.; 6:55","3:20 p.m.; 7:05","4:20 p.m.; 6:55"]$mq$, 3, $mq$'Las cuatro y veinte de la tarde' is 4:20 p.m. 'Las siete menos cinco' is five minutes to seven, which is 6:55.$mq$, $mq$medium$mq$),
($mq$What does 'las dos de la tarde' mean?$mq$, $mq$["2 a.m.","12 noon","2 p.m.","midnight"]$mq$, 2, $mq$'De la tarde' means in the afternoon, so 'las dos de la tarde' is 2 p.m. ('De la madrugada' would be in the early hours.)$mq$, $mq$medium$mq$),
($mq$What does 'el mediodía' mean?$mq$, $mq$["midnight","midday","mid-morning","mid-afternoon"]$mq$, 1, $mq$'Mediodía' is midday (noon) and 'medianoche' is midnight.$mq$, $mq$medium$mq$),
($mq$What does the question '¿A qué hora empieza la clase?' ask?$mq$, $mq$["At what time does the class start?","What time is it now?","How long is the class?","Where is the class?"]$mq$, 0, $mq$'¿A qué hora...?' asks at what time something happens. The reply usually begins 'A las...'.$mq$, $mq$medium$mq$),
($mq$Read: 'La clase empieza a las ocho y veinte y dura (lasts) cincuenta minutos.'

At what time does the class finish?$mq$, $mq$["9:00","9:20","8:50","9:10"]$mq$, 3, $mq$8:20 plus 50 minutes is 9:10, which is 'las nueve y diez'.$mq$, $mq$hard$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["Son las siete y cuarto.","Es la una y media.","Es las tres en punto.","Son las dos menos diez."]$mq$, 2, $mq$From two o'clock onwards we use 'Son las...': 'Son las tres en punto'. Only one o'clock uses 'Es la una'.$mq$, $mq$hard$mq$),
($mq$Read: 'La película empieza a las cinco y media y termina a las siete y cuarto.'

How long is the film?$mq$, $mq$["1 hour 15 minutes","1 hour 45 minutes","1 hour 30 minutes","2 hours"]$mq$, 1, $mq$From 5:30 to 7:15 is 1 hour 45 minutes (5:30 to 7:00 is 1 h 30 min, plus 15 min).$mq$, $mq$hard$mq$),
($mq$A bus timetable says: 'El autobús sale a las diecisiete cuarenta y cinco.'

What time is this on a 12-hour clock?$mq$, $mq$["5:45 p.m.","6:45 p.m.","4:45 p.m.","7:15 p.m."]$mq$, 0, $mq$Timetables use the 24-hour clock. 17:45 minus 12 hours is 5:45 p.m., or 'las seis menos cuarto de la tarde'.$mq$, $mq$hard$mq$),
($mq$Marcos writes: 'Quedamos (we are meeting) a las cuatro menos veinte en el cine.'

At what time are they meeting?$mq$, $mq$["4:20","3:20","4:40","3:40"]$mq$, 3, $mq$'Menos veinte' means twenty to. Twenty to four is 3:40.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Telling the Time$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Es la una / Son las dos$mq$, $mq$It is one o'clock (singular) / it is two o'clock (plural). From two onwards always 'son las'.$mq$),
($mq$y cuarto vs menos cuarto$mq$, $mq$quarter past vs quarter to. Son las cinco y cuarto = 5:15. Son las seis menos cuarto = 5:45.$mq$),
($mq$y media$mq$, $mq$half past. Son las nueve y media = 9:30.$mq$),
($mq$Son las ocho menos veinte$mq$, $mq$It is twenty to eight: 7:40. 'Menos' counts back from the next hour.$mq$),
($mq$¿A qué hora empieza la clase?$mq$, $mq$At what time does the class start? Answer with 'A las...': Empieza a las nueve.$mq$),
($mq$de la mañana / de la tarde / de la noche$mq$, $mq$in the morning / in the afternoon / at night, used instead of a.m. and p.m.$mq$),
($mq$el mediodía / la medianoche$mq$, $mq$midday (noon) / midnight.$mq$),
($mq$las diecisiete cuarenta y cinco$mq$, $mq$17:45, which is 5:45 p.m. Subtract 12 from 24-hour clock hours above 12.$mq$),
($mq$en punto$mq$, $mq$exactly, on the dot. Son las cuatro en punto = it is exactly four o'clock.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Telling the Time$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why time matters
Time appears in almost every real-life text: timetables, invitations, notices, train tickets. In the eAssessment you need to read and hear times accurately, because wrong times are the most common distractor. Fortunately, the system is logical.

## Asking the time
- ¿Qué hora es? (what time is it?)
- ¿A qué hora empieza la clase? (at what time does the class start?)
- ¿A qué hora sales? (at what time do you leave?)

Answer 'what time is it' with 'Es' or 'Son'. Answer 'at what time' with 'A la' or 'A las'.

## On the hour
- Es la una (1:00) – singular
- Son las dos (2:00), Son las tres (3:00) ... Son las doce (12:00) – plural
- en punto (exactly): Son las cuatro en punto

## Minutes past and to
Up to half past, add the minutes with 'y'. After half past, take minutes from the next hour with 'menos'.
- Son las cinco y cinco (5:05), y diez (5:10)
- y cuarto (quarter past): Son las cinco y cuarto (5:15)
- y veinte, y veinticinco, y media (half past): Son las cinco y media (5:30)
- menos veinticinco (25 to), menos veinte (20 to), menos cuarto (quarter to)
- Son las seis menos cuarto (5:45), Son las seis menos diez (5:50)

A useful method: for 'menos', take the hour given and subtract. 'Las ocho menos cuarto' is a quarter to eight, so 7:45. For 'a las': 'A las nueve y media' is 'at 9:30'.

## Parts of the day
- de la mañana (a.m.), de la tarde (afternoon and early evening p.m.), de la noche (night)
- el mediodía (midday), la medianoche (midnight)

Example: Son las tres de la tarde (3 p.m.).

## 24-hour clock
Timetables for trains, planes and films often use the 24-hour clock. You say the number and then the minutes: las diecisiete cuarenta y cinco is 17:45. To change to the 12-hour clock subtract 12 from hours over 12: 17:45 is 5:45 p.m.

## Worked example
Question: 'La película empieza a las cinco y media y termina a las siete y cuarto. ¿Cuánto dura?' Go from 5:30 to 7:00 (1 hour 30 minutes) and then add 15 minutes to reach 7:15. The film lasts 1 hour 45 minutes.

## Useful phrases
- Empieza a las nueve (it starts at nine)
- Termina a las doce y cuarto (it finishes at quarter past twelve)
- Quedamos a las cuatro (let's meet at four)
- Llego a casa a las seis (I get home at six)

## How this is examined
Reading tasks often present a school timetable, a bus or train table or a cinema programme and ask you to find a start time, a duration or the right connection. In listening, times are given quickly so you must recognise pairs like 'y veinte' and 'menos veinte'. In writing, include times naturally in a description of your routine: 'Me levanto a las siete y media.'

## Common mistakes
- Saying 'Es las tres' instead of 'Son las tres'
- Mixing 'y cuarto' (quarter past) with 'menos cuarto' (quarter to)
- Forgetting that 'menos' goes back to the previous hour
- Reading 17:45 as quarter to seven instead of quarter to six

Exam tip: Write the times in digits on your rough paper as you read or listen, then compare. Be extra careful with 'menos'.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;