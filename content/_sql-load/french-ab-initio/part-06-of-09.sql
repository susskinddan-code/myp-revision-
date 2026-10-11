-- Part 6 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Town and Travel > Places in Town
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Town and Travel$mq$, 5, 6 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Places in Town$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Town and Travel$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Places in Town$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'la boulangerie' mean?$mq$, $mq$["the bakery","the library","the bank","the butcher's"]$mq$, 0, $mq$'La boulangerie' is where you buy bread. The library is 'la bibliothèque'.$mq$, $mq$easy$mq$),
($mq$What does 'la gare' mean?$mq$, $mq$["the garage","the airport","the bus stop","the train station"]$mq$, 3, $mq$'La gare' is the train station. 'La gare routière' is the bus station.$mq$, $mq$easy$mq$),
($mq$What does 'la piscine' mean?$mq$, $mq$["the pharmacy","the park","the swimming pool","the market"]$mq$, 2, $mq$'La piscine' is the swimming pool.$mq$, $mq$easy$mq$),
($mq$What does 'le supermarché' mean?$mq$, $mq$["the market","the supermarket","the restaurant","the school"]$mq$, 1, $mq$'Le supermarché' is the supermarket. 'Le marché' is the market.$mq$, $mq$easy$mq$),
($mq$What does 'la poste' mean?$mq$, $mq$["the post office","the police station","the bank","the hospital"]$mq$, 0, $mq$'La poste' is the post office, where you send letters and parcels.$mq$, $mq$easy$mq$),
($mq$Where do you buy bread in France?$mq$, $mq$["à la pharmacie","à la mairie","à la banque","à la boulangerie"]$mq$, 3, $mq$The boulangerie sells bread and croissants. A pharmacy sells medicine.$mq$, $mq$medium$mq$),
($mq$What does 'Il y a un cinéma dans ma ville' mean?$mq$, $mq$["I go to the cinema in town.","My town has no cinema.","There is a cinema in my town.","The cinema is opposite my house."]$mq$, 2, $mq$'Il y a' means there is, and 'ma ville' means my town.$mq$, $mq$medium$mq$),
($mq$What does 'Il n'y a pas de piscine' mean?$mq$, $mq$["There is a big swimming pool.","There is no swimming pool.","The pool is closed.","I do not like swimming."]$mq$, 1, $mq$'Il n'y a pas de' means there is no / there are no.$mq$, $mq$medium$mq$),
($mq$'La banque est à côté de la mairie.' Where is the bank?$mq$, $mq$["next to the town hall","opposite the town hall","behind the town hall","inside the town hall"]$mq$, 0, $mq$'À côté de' means next to. 'La mairie' is the town hall.$mq$, $mq$medium$mq$),
($mq$Where can you borrow books for free?$mq$, $mq$["à la librairie","à la boulangerie","à la boucherie","à la bibliothèque"]$mq$, 3, $mq$'La bibliothèque' is a library. 'La librairie' is a bookshop where you buy books.$mq$, $mq$medium$mq$),
($mq$What does 'à la campagne' mean?$mq$, $mq$["in the camp","in the town centre","in the countryside","at the seaside"]$mq$, 2, $mq$'La campagne' is the countryside. It is different from 'le camping'.$mq$, $mq$medium$mq$),
($mq$'Ma ville est petite et tranquille.' What does this say?$mq$, $mq$["My town is big and noisy.","My town is small and quiet.","My town is old and pretty.","My town is small and dangerous."]$mq$, 1, $mq$'Petite' is small and 'tranquille' is quiet, calm.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Je vais ___ supermarché.'$mq$, $mq$["au","à la","aux","à l'"]$mq$, 0, $mq$'À' + 'le' becomes 'au': 'au supermarché'.$mq$, $mq$medium$mq$),
($mq$Text: 'J'habite à Lilleville, une petite ville. Il y a un parc, une église et un marché le samedi. Mais il n'y a pas de cinéma.' Which statement is true?$mq$, $mq$["There is a cinema.","The town is big.","The market is on Sundays.","There is a market on Saturdays."]$mq$, 3, $mq$'Un marché le samedi' means a market on Saturdays. 'Il n'y a pas de cinéma' means no cinema.$mq$, $mq$hard$mq$),
($mq$Complete the sentence: 'Elle habite près ___ gare, à côté ___ cinéma.'$mq$, $mq$["de le / de la","du / de la","de la / du","à la / au"]$mq$, 2, $mq$'De la' stays as it is with a feminine noun, and 'de' + 'le' becomes 'du'.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'J'aime ma ville parce qu'il y a beaucoup de magasins, mais c'est bruyant et il y a trop de voitures.' What is the speaker's complaint?$mq$, $mq$["There are not enough shops.","It is noisy and has too much traffic.","The town is too small.","There is nowhere to park."]$mq$, 1, $mq$'Bruyant' means noisy and 'trop de voitures' means too many cars.$mq$, $mq$hard$mq$),
($mq$Advert: 'Nouveau centre commercial : 80 magasins, cinéma, parking gratuit.' What is free?$mq$, $mq$["the car park","the cinema","the shops","the entrance only"]$mq$, 0, $mq$'Parking gratuit' means free parking.$mq$, $mq$hard$mq$),
($mq$Léa wants to buy a novel. Where should she go?$mq$, $mq$["à la bibliothèque","à la boucherie","à la mairie","à la librairie"]$mq$, 3, $mq$'La librairie' is a bookshop, so you can buy a novel there. The library lends books.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Places in Town$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$la bibliothèque / la librairie$mq$, $mq$library / bookshop (false friend)$mq$),
($mq$Il y a... / Il n'y a pas de...$mq$, $mq$There is... / There is no...$mq$),
($mq$à + le = au; à + les = aux$mq$, $mq$au cinéma, aux magasins (but à la piscine, à l'école)$mq$),
($mq$de + le = du$mq$, $mq$près du parc, à côté du cinéma (but près de la gare)$mq$),
($mq$la mairie$mq$, $mq$the town hall$mq$),
($mq$la boulangerie / la pharmacie$mq$, $mq$bakery / chemist's$mq$),
($mq$bruyant / tranquille$mq$, $mq$noisy / quiet$mq$),
($mq$à la campagne / en ville$mq$, $mq$in the countryside / in town$mq$),
($mq$J'habite dans une petite ville.$mq$, $mq$I live in a small town.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Places in Town$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Talking about your town is a classic exam topic. You will need the names of places, "il y a" for saying what exists, and a few prepositions to say where things are.

## Places in town
- la boulangerie (bakery), la pâtisserie (cake shop), la boucherie (butcher's)
- la pharmacie (chemist's), la banque (bank), la poste (post office)
- le supermarché (supermarket), le marché (market), le centre commercial (shopping centre)
- l'école / le collège (school), la bibliothèque (library), la librairie (bookshop)
- le cinéma, le théâtre, le musée (museum), la piscine (swimming pool), le stade (stadium)
- la mairie (town hall), l'église (church), le parc (park), la gare (train station)
- la rue (street), la place (square), le pont (bridge)

## Beware of false friends
- la bibliothèque = library, la librairie = bookshop
- une librairie sells books; a library lends them
- la gare = station, but "le garage" is a garage

## There is, there is not
Use "il y a" (there is / are) and "il n'y a pas de" (there is no): "Dans ma ville, il y a un musée et deux parcs" (In my town there is a museum and two parks). "Il n'y a pas de cinéma" (There is no cinema).

## Where things are: prepositions
- près de (near), loin de (far from), à côté de (next to), en face de (opposite)
- devant (in front of), derrière (behind), entre (between), au centre (in the centre)
With "de" followed by le or les, you must contract: de + le = du, de + les = des. So: "près du parc" (near the park) but "près de la gare" (near the station) and "près de l'église".

## Going to places: à + article
- à + le = au: "Je vais au cinéma."
- à + la = à la: "Je vais à la piscine."
- à + l' = à l': "Je vais à l'école."
- à + les = aux: "Je vais aux magasins."

## Describing your town
Use adjectives such as petit, grand, calme, tranquille, bruyant (noisy), animé (lively), ancien (old), moderne, pollué. Start with "J'habite à..." (I live in...) then add "C'est une ville..." (It is a town...). You can also say "en ville" (in town), "à la campagne" (in the countryside), "à la montagne" (in the mountains), "au bord de la mer" (by the sea).

Model: "J'habite dans une petite ville près de Lyon. Il y a une belle église, un parc et un marché le samedi. Il n'y a pas de piscine, mais c'est tranquille. J'aime ma ville parce que c'est calme."

## Common mistakes
- Saying "à le cinéma" instead of "au cinéma".
- Writing "il n'y a pas un parc" instead of "il n'y a pas de parc".
- Mixing up "bibliothèque" and "librairie".
- Using the wrong article with a place: "la parc" instead of "le parc".

## How this is examined
Reading texts include an advert for a town, a tourist leaflet or a pen-friend email describing the area. Listening transcripts have a speaker comparing their town with another, listing pros and cons. In writing, you describe your town in four to six sentences saying what there is, what there is not, and whether you like it.

Exam tip: Look at "pas de" and "trop de". "Il n'y a pas de cinéma" means none exists, and "trop de voitures" is a complaint, not a compliment.$mq$ from st;

-- Town and Travel > Asking for and Giving Directions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Town and Travel$mq$, 5, 6 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Asking for and Giving Directions$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Town and Travel$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Asking for and Giving Directions$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'tout droit' mean?$mq$, $mq$["straight on","turn right","turn left","go back"]$mq$, 0, $mq$'Tout droit' means straight ahead. 'À droite' means right.$mq$, $mq$easy$mq$),
($mq$What does 'à gauche' mean?$mq$, $mq$["on the right","straight on","opposite","on the left"]$mq$, 3, $mq$'À gauche' means to the left; 'à droite' means to the right.$mq$, $mq$easy$mq$),
($mq$What does 'à droite' mean?$mq$, $mq$["on the left","next to","on the right","behind"]$mq$, 2, $mq$'À droite' means to/on the right.$mq$, $mq$easy$mq$),
($mq$What does 'Où est la gare ?' ask?$mq$, $mq$["When does the station open?","Where is the station?","Who is at the station?","How far is the station?"]$mq$, 1, $mq$'Où' means where.$mq$, $mq$easy$mq$),
($mq$What does 'en face de' mean?$mq$, $mq$["opposite","next to","behind","between"]$mq$, 0, $mq$'En face de' means opposite, directly across from something.$mq$, $mq$easy$mq$),
($mq$What does 'Tournez à gauche' tell you to do?$mq$, $mq$["Turn right.","Go straight on.","Stop here.","Turn left."]$mq$, 3, $mq$'Tournez' is the polite command form of 'tourner' (to turn), and 'à gauche' is left.$mq$, $mq$medium$mq$),
($mq$What does 'Prenez la deuxième rue à droite' mean?$mq$, $mq$["Take the first street on the left.","Take the second bridge on the right.","Take the second street on the right.","Take the street on the right, then stop."]$mq$, 2, $mq$'La deuxième rue' is the second street and 'prenez' is take.$mq$, $mq$medium$mq$),
($mq$What does 'Continuez jusqu'au feu rouge' mean?$mq$, $mq$["Stop at the red car.","Carry on until the traffic lights.","Turn at the red house.","Cross the red bridge."]$mq$, 1, $mq$'Jusqu'à' means until, and 'le feu rouge' is the red light/traffic light.$mq$, $mq$medium$mq$),
($mq$'C'est loin ?' 'Non, c'est à cinq minutes à pied.' What does the reply mean?$mq$, $mq$["No, it is a five-minute walk.","Yes, it is five kilometres away.","No, it is five minutes by bus.","Yes, it is five minutes by car."]$mq$, 0, $mq$'À pied' means on foot. 'Cinq minutes' is five minutes.$mq$, $mq$medium$mq$),
($mq$What does 'Traversez le pont' mean?$mq$, $mq$["Follow the river.","Go under the bridge.","Turn at the bridge.","Cross the bridge."]$mq$, 3, $mq$'Traverser' means to cross, and 'le pont' is the bridge.$mq$, $mq$medium$mq$),
($mq$What does 'le rond-point' mean?$mq$, $mq$["the crossroads","the car park","the roundabout","the traffic light"]$mq$, 2, $mq$'Le rond-point' is the roundabout. 'Le carrefour' is the crossroads.$mq$, $mq$medium$mq$),
($mq$Which question asks the way politely?$mq$, $mq$["Où poste ?","Excusez-moi, pour aller à la poste, s'il vous plaît ?","Je vais à la poste ?","Donnez-moi la poste !"]$mq$, 1, $mq$'Pour aller à...' means how do I get to. Adding 'excusez-moi' and 's'il vous plaît' makes it polite.$mq$, $mq$medium$mq$),
($mq$What does 'au coin de la rue' mean?$mq$, $mq$["on the corner of the street","at the end of the world","next to the road works","in the middle of the street"]$mq$, 0, $mq$'Le coin' is the corner.$mq$, $mq$medium$mq$),
($mq$Directions: 'Allez tout droit. Au rond-point, tournez à droite. La banque est sur votre gauche, en face de l'église.' Where is the bank?$mq$, $mq$["Before the roundabout, on your right","At the roundabout, next to the church","After the roundabout, on your right, behind the church","After the roundabout, on your left, opposite the church"]$mq$, 3, $mq$You go straight, turn right at the roundabout, and the bank is then 'sur votre gauche' (on your left), 'en face de l'église'.$mq$, $mq$hard$mq$),
($mq$Directions: 'Prenez la première rue à gauche, puis la deuxième à droite. La pharmacie est entre le café et la boulangerie.' Which statement is true?$mq$, $mq$["The pharmacy is next to the bank.","The pharmacy is opposite the café.","The pharmacy is between the café and the bakery.","The pharmacy is the first on the left."]$mq$, 2, $mq$'Entre... et...' means between... and... The pharmacy is between the café and the bakery.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'Pour aller à la piscine, vous prenez le bus numéro 12 et vous descendez à l'arrêt Mairie. Ensuite, c'est à cent mètres.' Which statement is true?$mq$, $mq$["You walk 12 minutes to the pool.","You get off at the town hall stop and walk 100 metres.","You take the bus to the pool entrance.","You get off at the station."]$mq$, 1, $mq$'Vous descendez à l'arrêt Mairie' means you get off at the Town Hall stop, then the pool is 100 m away.$mq$, $mq$hard$mq$),
($mq$Which instruction tells you to go back the way you came?$mq$, $mq$["Faites demi-tour.","Continuez tout droit.","Traversez la rue.","Tournez à droite."]$mq$, 0, $mq$'Faire demi-tour' means to turn round.$mq$, $mq$hard$mq$),
($mq$'Tournez à gauche, passez devant la mairie, puis prenez la troisième rue à droite.' What is the correct order?$mq$, $mq$["right, past the town hall, third street on the left","left, third street on the right, past the town hall","left, past the town hall, second street on the right","left, past the town hall, third street on the right"]$mq$, 3, $mq$The three steps are: turn left, go past the front of the town hall ('devant'), then take the third street on the right.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Asking for and Giving Directions$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$tout droit$mq$, $mq$straight on$mq$),
($mq$à gauche / à droite$mq$, $mq$left / right$mq$),
($mq$Tournez à gauche.$mq$, $mq$Turn left.$mq$),
($mq$Prenez la deuxième rue à droite.$mq$, $mq$Take the second street on the right.$mq$),
($mq$Continuez jusqu'au feu rouge.$mq$, $mq$Carry on until the traffic lights.$mq$),
($mq$en face de / à côté de / entre$mq$, $mq$opposite / next to / between$mq$),
($mq$Pour aller à la gare, s'il vous plaît ?$mq$, $mq$How do I get to the station, please?$mq$),
($mq$C'est à cinq minutes à pied.$mq$, $mq$It is a five-minute walk.$mq$),
($mq$le rond-point / le carrefour$mq$, $mq$the roundabout / the crossroads$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Asking for and Giving Directions$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Giving and following directions tests your listening carefully because one word (gauche or droite, première or deuxième) changes the route completely. This note gives you the key phrases and shows you how to follow a route step by step.

## Asking the way
- Excusez-moi, où est la gare, s'il vous plaît ? (Excuse me, where is the station?)
- Pour aller au musée, s'il vous plaît ? (How do I get to the museum?)
- Est-ce qu'il y a une pharmacie près d'ici ? (Is there a chemist's near here?)
- C'est loin ? (Is it far?) / C'est près ? (Is it near?)

## Giving directions
Directions use the polite command form, which is the "vous" form without the pronoun:
- Allez tout droit. (Go straight on.)
- Tournez à gauche / à droite. (Turn left / right.)
- Prenez la première / deuxième / troisième rue. (Take the first / second / third street.)
- Continuez jusqu'au feu rouge. (Carry on to the traffic lights.)
- Traversez la place / le pont. (Cross the square / the bridge.)
- Passez devant l'église. (Go past the church.)
- Faites demi-tour. (Turn round.)
- Descendez la rue. (Go down the street.)

## Position words
- sur votre gauche / sur votre droite (on your left / right)
- au coin de la rue (on the street corner)
- au carrefour (at the crossroads), au rond-point (at the roundabout), au feu (at the lights)
- à côté de (next to), en face de (opposite), entre (between), derrière (behind), devant (in front)
- après (after), avant (before), jusqu'à (until)

## Distances
- C'est à cent mètres. (It is 100 metres away.)
- C'est à cinq minutes à pied. (It is a five-minute walk.)
- C'est à dix minutes en bus. (It is a ten-minute bus ride.)

## Ordinal numbers
première (first), deuxième (second), troisième (third), quatrième (fourth). They are used with "rue" to count the roads.

## Worked example
"Allez tout droit. Prenez la deuxième rue à gauche. La poste est en face du parc." Step 1: walk straight. Step 2: pass one street, then turn left on the second. Step 3: the post office is opposite the park. Draw a tiny sketch map as you listen or read, because it makes mistakes easier to spot.

## Common mistakes
- Mixing gauche (left) and droite (right), or thinking "tout droit" means right. It means straight on.
- Forgetting that "jusqu'à" + "le" becomes "jusqu'au".
- Confusing "devant" (in front of) with "derrière" (behind).
- Misreading "la deuxième rue" as the second street after turning rather than the second on your route.

## How this is examined
The reading paper may include a text message giving directions to a friend's house or a leaflet for a tourist trail. In listening, a speaker describes a route and you must choose the place on a map or decide where someone ends up. Writing tasks may ask you to explain to a visitor how to get from school to the station, using at least three direction words.

Exam tip: Number each instruction (1, 2, 3) as you read or listen. Then follow them on a simple sketch before choosing your answer.$mq$ from st;

-- Town and Travel > Transport and Holidays
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Town and Travel$mq$, 5, 6 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Transport and Holidays$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Town and Travel$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Transport and Holidays$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'l'avion' mean?$mq$, $mq$["the plane","the train","the boat","the bus"]$mq$, 0, $mq$'L'avion' is the plane. The train is 'le train'.$mq$, $mq$easy$mq$),
($mq$What does 'en bus' mean?$mq$, $mq$["in a bus station","at a bus stop","with a friend","by bus"]$mq$, 3, $mq$'En' is used with most vehicles: en bus, en train, en voiture.$mq$, $mq$easy$mq$),
($mq$What does 'à vélo' mean?$mq$, $mq$["by car","by motorbike","by bike","on foot"]$mq$, 2, $mq$'Un vélo' is a bicycle. French uses 'à' for bike and foot.$mq$, $mq$easy$mq$),
($mq$What does 'les vacances' mean?$mq$, $mq$["the vacations of the school only","the holidays","the weekend","the travel"]$mq$, 1, $mq$'Les vacances' is always plural in French and means the holidays.$mq$, $mq$easy$mq$),
($mq$What does 'la plage' mean?$mq$, $mq$["the beach","the page","the park","the lake"]$mq$, 0, $mq$'La plage' is the beach. A page is 'une page' but looks similar.$mq$, $mq$easy$mq$),
($mq$'Je vais à l'école à pied.' How does the speaker get to school?$mq$, $mq$["by bike","by bus","by car","on foot"]$mq$, 3, $mq$'À pied' means on foot.$mq$, $mq$medium$mq$),
($mq$What does 'Je voudrais un billet aller-retour pour Lyon' mean?$mq$, $mq$["I would like a single ticket to Lyon.","I would like a seat on the plane to Lyon.","I would like a return ticket to Lyon.","I would like to leave Lyon."]$mq$, 2, $mq$'Un aller-retour' is a return ticket. A one-way ticket is 'un aller simple'.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Elle va au collège ___ pied.'$mq$, $mq$["en","à","par","sur"]$mq$, 1, $mq$Use 'à' for walking and things you ride (à pied, à vélo). Use 'en' for most vehicles you sit inside (en bus, en voiture).$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Nous allons ___ Italie.'$mq$, $mq$["en","au","à","aux"]$mq$, 0, $mq$Feminine countries (and those starting with a vowel) take 'en': en Italie, en France, en Espagne.$mq$, $mq$medium$mq$),
($mq$What does 'Cet été, nous allons visiter Paris' mean?$mq$, $mq$["Last summer, we visited Paris.","We live in Paris in summer.","We would like to visit Paris.","This summer, we are going to visit Paris."]$mq$, 3, $mq$'Aller' + infinitive expresses the near future: 'nous allons visiter' is 'we are going to visit'.$mq$, $mq$medium$mq$),
($mq$The announcement says 'Le train part du quai 3.' What does it tell you?$mq$, $mq$["The train arrives at 3 o'clock.","The train has 3 carriages.","The train leaves from platform 3.","Ticket number 3 is valid."]$mq$, 2, $mq$'Un quai' is a platform; 'partir' means to leave.$mq$, $mq$medium$mq$),
($mq$What does 'un aller simple' mean?$mq$, $mq$["a return ticket","a single (one-way) ticket","a simple holiday","a first-class seat"]$mq$, 1, $mq$'Aller simple' is a one-way ticket.$mq$, $mq$medium$mq$),
($mq$What does 'Je loge à l'hôtel' mean?$mq$, $mq$["I am staying at a hotel.","I am looking for a hotel.","I work in a hotel.","I am leaving the hotel."]$mq$, 0, $mq$'Loger' means to stay or lodge.$mq$, $mq$medium$mq$),
($mq$Notice: 'TGV 8421 : Paris 07h45 → Marseille 10h50. Quai 6. Retard : 10 minutes.' Which statement is true?$mq$, $mq$["The train arrives at 6 o'clock.","The train goes to Paris at 10h50.","The train is on time.","The train leaves from platform 6 and is 10 minutes late."]$mq$, 3, $mq$'Quai 6' is platform 6 and 'retard' means delay.$mq$, $mq$hard$mq$),
($mq$Postcard: 'Salut Inès ! Je suis en vacances à Nice avec ma famille. On loge dans un petit hôtel près de la plage. Il fait très chaud ! Demain, nous allons visiter le vieux port. Bisous, Tom'. What will Tom do tomorrow?$mq$, $mq$["go to the beach","go home","visit the old port","stay in the hotel"]$mq$, 2, $mq$'Demain, nous allons visiter le vieux port' means they will visit the old port tomorrow.$mq$, $mq$hard$mq$),
($mq$Complete the sentence: 'Je vais au collège ___ bus, mais mon frère y va ___ pied.'$mq$, $mq$["à / en","en / à","en / en","à / à"]$mq$, 1, $mq$Use 'en' with bus and 'à' with pied: 'en bus', 'à pied'.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'Cette année, on ne part pas à l'étranger. On va rester en France, dans les Alpes, pour faire de la randonnée.' What is the plan?$mq$, $mq$["a hiking holiday in France","a beach holiday abroad","a skiing trip to Switzerland","a city break in Paris"]$mq$, 0, $mq$'Ne... pas à l'étranger' means not going abroad. They stay in France in the Alps to go hiking.$mq$, $mq$hard$mq$),
($mq$Which sentence is correct?$mq$, $mq$["Nous allons en Japon à avion.","Nous allons au Japon à avion.","Nous allons à Japon en l'avion.","Nous allons au Japon en avion."]$mq$, 3, $mq$'Japon' is masculine, so 'au Japon'; 'en avion' is the correct way to say by plane.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Transport and Holidays$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$en train / en bus / en voiture / en avion$mq$, $mq$by train / bus / car / plane$mq$),
($mq$à vélo / à pied / à moto$mq$, $mq$by bike / on foot / by motorbike$mq$),
($mq$un aller simple / un aller-retour$mq$, $mq$a single ticket / a return ticket$mq$),
($mq$le quai / le retard$mq$, $mq$the platform / the delay$mq$),
($mq$en France / au Canada / aux États-Unis$mq$, $mq$to France / to Canada / to the United States$mq$),
($mq$Je vais visiter Rome.$mq$, $mq$I am going to visit Rome. (aller + infinitive = near future)$mq$),
($mq$les vacances$mq$, $mq$the holidays (always plural)$mq$),
($mq$à l'étranger$mq$, $mq$abroad$mq$),
($mq$faire de la randonnée$mq$, $mq$to go hiking$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Transport and Holidays$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Transport and holidays give you the chance to use the near future ("I am going to...") and to talk about where you went, how you travelled and what you do on holiday. At beginner level you need vocabulary, prepositions for countries and vehicles, and simple future plans.

## Transport vocabulary
- le train (train), le bus / l'autobus (bus), le métro (underground), le tram (tram)
- la voiture (car), le vélo (bike), la moto (motorbike), l'avion (plane), le bateau (boat)
- la gare (train station), l'aéroport (airport), l'arrêt de bus (bus stop), le quai (platform)
- un billet (ticket): un aller simple (single) and un aller-retour (return)
- un horaire (timetable), le départ (departure), l'arrivée (arrival), le retard (delay)

## How do you travel? en or à?
Use "en" with most vehicles you sit inside: en voiture, en bus, en train, en avion, en bateau. Use "à" for things you ride or do on foot: à vélo, à moto, à pied.
- Je vais à l'école à pied. (I walk to school.)
- Nous voyageons en train. (We travel by train.)

## Holiday vocabulary
- les vacances (holidays), un voyage (a trip), un séjour (a stay)
- la plage (beach), la mer (sea), la montagne (mountains), la campagne (countryside), la ville (city)
- un hôtel, un camping (campsite), une auberge de jeunesse (youth hostel)
- faire du camping, faire de la randonnée (hiking), nager, visiter un musée, bronzer
- à l'étranger (abroad), rester (to stay)

## Going to countries
- Feminine countries and those beginning with a vowel take "en": en France, en Espagne, en Italie.
- Masculine countries take "au": au Canada, au Japon, au Maroc.
- Plural countries take "aux": aux États-Unis.
- Cities take "à": à Paris, à Londres.

## Talking about future plans
Use the near future: present tense of aller + infinitive.
- Cet été, je vais visiter Rome. (This summer I am going to visit Rome.)
- Nous allons loger dans un petit hôtel. (We are going to stay in a small hotel.)
- Ils vont faire de la randonnée. (They are going to go hiking.)
Remember aller: je vais, tu vas, il va, nous allons, vous allez, ils vont.

## Writing a postcard
A model: "Salut Marie ! Je suis en vacances à Nice. Il fait chaud et je vais à la plage tous les jours. Demain, nous allons visiter le musée. À bientôt, Paul." Useful openers are "Salut" and "Cher / Chère"; closings include "Bisous" and "À bientôt".

## Common mistakes
- Saying "en pied" instead of "à pied", or "à bus" instead of "en bus", or "à bus" instead of "en bus".
- Choosing the wrong preposition with a country: "en Japon" should be "au Japon".
- Forgetting that "les vacances" is plural.
- Misreading "retard" (delay) as "arrivée".

## How this is examined
Typical items are a timetable or travel notice, a postcard or email from a holiday, and a transcript of someone planning their next trip. Questions ask how they travel, where they stay, what the weather is like and what they plan to do next. In writing you describe a holiday, saying where you go, who with, how you travel and one future plan.

Exam tip: Check the tense of the verb. "Je vais visiter" is a plan for the future, while a present-tense "je visite" describes what you do now. Questions often hinge on that difference.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;