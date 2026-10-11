-- Part 5 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Food and Shopping > Food and Drink
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Food and Shopping$mq$, 5, 5 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Food and Drink$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Food and Shopping$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Food and Drink$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is 'el queso' in English?$mq$, $mq$["cheese","bread","milk","ham"]$mq$, 0, $mq$El queso is cheese. Bread is el pan, milk is la leche and ham is el jamón.$mq$, $mq$easy$mq$),
($mq$Which English word matches 'el pescado'?$mq$, $mq$["chicken","rice","egg","fish"]$mq$, 3, $mq$El pescado is fish (once caught and eaten). Chicken is el pollo, rice is el arroz and an egg is el huevo.$mq$, $mq$easy$mq$),
($mq$What does 'el desayuno' mean?$mq$, $mq$["lunch","dinner","breakfast","snack"]$mq$, 2, $mq$El desayuno is breakfast. Lunch is la comida or el almuerzo, dinner is la cena and a snack is la merienda.$mq$, $mq$easy$mq$),
($mq$Choose the correct word: Me ____ las fresas.$mq$, $mq$["gusta","gustan","gusto","gustas"]$mq$, 1, $mq$Las fresas (strawberries) is plural, so the verb is gustan.$mq$, $mq$easy$mq$),
($mq$Which of these is a drink?$mq$, $mq$["el zumo","el queso","el pollo","el arroz"]$mq$, 0, $mq$El zumo is juice. Cheese, chicken and rice are all foods.$mq$, $mq$easy$mq$),
($mq$Read the text.
'Para el desayuno tomo pan con mantequilla y un vaso de leche. Para la comida como pasta con pollo. Para la cena, ensalada.'
What does the writer eat for lunch?$mq$, $mq$["Bread and butter","Salad","A glass of milk","Pasta with chicken"]$mq$, 3, $mq$La comida is lunch, and the writer eats pasta con pollo. Bread, butter and milk are for breakfast and salad is for dinner.$mq$, $mq$medium$mq$),
($mq$A vegetarian friend visits you. Which dish would they NOT eat?$mq$, $mq$["una ensalada","una tortilla de queso","pollo con arroz","pasta con tomate"]$mq$, 2, $mq$Pollo is chicken, which contains meat. Vegetarians eat salad, cheese omelette and tomato pasta.$mq$, $mq$medium$mq$),
($mq$What does 'una docena de huevos' mean?$mq$, $mq$["half a kilo of eggs","a dozen eggs","a carton of milk","ten eggs"]$mq$, 1, $mq$Una docena is a dozen, which means twelve. Huevos are eggs.$mq$, $mq$medium$mq$),
($mq$Which meal is 'la cena'?$mq$, $mq$["dinner","breakfast","lunch","afternoon snack"]$mq$, 0, $mq$La cena is dinner (the evening meal). The afternoon snack is la merienda.$mq$, $mq$medium$mq$),
($mq$Which noun is masculine and takes 'el'?$mq$, $mq$["la leche","la carne","la fruta","el pan"]$mq$, 3, $mq$El pan is masculine. Leche, carne and fruta are all feminine and take la.$mq$, $mq$medium$mq$),
($mq$Read the shopping list.
'Necesito: un kilo de naranjas, dos litros de leche, una lata de atún, un paquete de arroz.'
What comes in a tin?$mq$, $mq$["rice","oranges","tuna","milk"]$mq$, 2, $mq$Una lata de atún is a tin of tuna. Rice comes in a packet (paquete), oranges are by the kilo and milk by the litre.$mq$, $mq$medium$mq$),
($mq$A student says: 'Prefiero el té al café.' What does she prefer?$mq$, $mq$["Coffee","Tea","Both equally","Neither of them"]$mq$, 1, $mq$Prefiero X a Y means I prefer X to Y, so she prefers el té (tea) to el café (coffee).$mq$, $mq$medium$mq$),
($mq$Read the sign in a restaurant.
'Atención: Este plato contiene frutos secos (nueces). No es apto para alérgicos.'
Who should NOT eat this dish?$mq$, $mq$["People who are allergic to nuts","People who are vegetarian","People who dislike fruit","People who are on a diet"]$mq$, 0, $mq$Frutos secos and nueces refer to nuts, and no es apto para alérgicos means it is not suitable for people with allergies.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'En mi casa desayunamos a las ocho. Yo tomo cereales y zumo de naranja. Mi hermano no desayuna, solo bebe café. Comemos a las dos de la tarde y cenamos tarde, a las nueve.'
Which statement is correct?$mq$, $mq$["The speaker has coffee only for breakfast.","The brother has cereal and juice for breakfast.","The family has lunch at nine in the evening.","The speaker has cereal and juice; the brother only has coffee."]$mq$, 3, $mq$The speaker takes cereales y zumo, while the brother solo bebe café. Lunch is at two in the afternoon and dinner is at nine.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'I love fruit but I don't like fish'?$mq$, $mq$["Encanto la fruta pero no gusto el pescado.","Me encantan la fruta pero no me gustan el pescado.","Me encanta la fruta pero no me gusta el pescado.","Me encanta la fruta pero no me gusta los pescados."]$mq$, 2, $mq$La fruta and el pescado are both singular, so you need encanta and gusta. Gustar and encantar work with me, not with the I form.$mq$, $mq$hard$mq$),
($mq$Read the menu.
'Menú del día: Primero: sopa o ensalada. Segundo: pollo con patatas o pescado con arroz. Postre: fruta o helado. Bebida incluida. 12 €.'
Which statement is true?$mq$, $mq$["You can have both soup and salad.","The dessert and drink are included in the 12 € price.","The price does not include a drink.","The fish is served with potatoes."]$mq$, 1, $mq$Bebida incluida means a drink is included, and the postre is part of the menú. The starter is soup OR salad, and fish comes with rice.$mq$, $mq$hard$mq$),
($mq$Read the message.
'Hola Sofía, el sábado hago una fiesta. Necesito pan, queso, tomates y dos botellas de agua. No compres jamón ni pollo porque Luis es vegetariano.'
What should Sofía NOT buy, and why?$mq$, $mq$["Ham and chicken, because Luis is vegetarian.","Cheese, because Luis is allergic.","Bread and tomatoes, because Luis is on a diet.","Water, because Luis is thirsty."]$mq$, 0, $mq$No compres means don't buy, and the reason is porque Luis es vegetariano. Ham and chicken are meat.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'I am hungry and thirsty'?$mq$, $mq$["Soy hambre y sed.","Estoy hambre y sed.","Tengo hambriento y sed.","Tengo hambre y sed."]$mq$, 3, $mq$In Spanish you 'have' hunger and thirst: tengo hambre y tengo sed (or tengo hambre y sed). Ser and estar are not used for these.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Food and Drink$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$el queso / el jamón$mq$, $mq$cheese / ham$mq$),
($mq$el desayuno, la comida, la cena$mq$, $mq$breakfast, lunch, dinner$mq$),
($mq$Me gusta el pescado. / Me gustan las fresas.$mq$, $mq$I like fish. / I like strawberries. (gusta + singular, gustan + plural)$mq$),
($mq$Tengo hambre. / Tengo sed.$mq$, $mq$I'm hungry. / I'm thirsty. (Use tener, not ser or estar.)$mq$),
($mq$una docena de huevos$mq$, $mq$a dozen eggs (twelve)$mq$),
($mq$una lata de atún$mq$, $mq$a tin of tuna$mq$),
($mq$Soy vegetariano.$mq$, $mq$I am vegetarian (a girl says: Soy vegetariana).$mq$),
($mq$Prefiero el té al café.$mq$, $mq$I prefer tea to coffee.$mq$),
($mq$el agua$mq$, $mq$water (feminine noun with el: el agua fría)$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Food and Drink$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Food (la comida)
Learn food words with their articles, because the gender matters for adjectives and for gustar.
- el pan (bread), el queso (cheese), el jamón (ham), el huevo (egg), la leche (milk)
- el pollo (chicken), el pescado (fish), la carne (meat), el arroz (rice), la pasta (pasta)
- las patatas (potatoes), las verduras (vegetables), la fruta (fruit), la ensalada (salad)
- la manzana (apple), el plátano (banana), la naranja (orange), las fresas (strawberries), el tomate (tomato)

## Drinks (las bebidas)
- el agua (water), el zumo (juice), el café (coffee), el té (tea), la leche (milk), el refresco (soft drink)
Note: el agua is feminine but uses el because it starts with a stressed a. You still say el agua fría (cold water).

## Meals (las comidas)
- el desayuno (breakfast), la comida or el almuerzo (lunch), la merienda (afternoon snack), la cena (dinner)
- Verbs: desayunar (to have breakfast), comer (to eat), beber (to drink), cenar (to have dinner)
- Spanish mealtimes are often later than in the UK: lunch around two in the afternoon and dinner around nine.
- Example: Para el desayuno tomo cereales y zumo. (For breakfast I have cereal and juice.)

## Quantities
- un kilo de (a kilo of), un litro de (a litre of), una botella de (a bottle of)
- un paquete de (a packet of), una lata de (a tin of), una docena de huevos (a dozen eggs)
- Remember the de: un kilo de naranjas, not un kilo naranjas.

## Likes, dislikes and needs
- Me gusta + singular: Me gusta el queso.
- Me gustan + plural: Me gustan las fresas.
- Me encanta / Me encantan (I love); No me gusta (I don't like); Prefiero (I prefer)
- Soy vegetariano / vegetariana (I'm vegetarian); Soy alérgico / alérgica a los frutos secos (I'm allergic to nuts)
- Tengo hambre (I'm hungry); Tengo sed (I'm thirsty). Use tener, never ser or estar.

## Worked example
Read: 'Me encanta la fruta, pero no me gusta el pescado. Prefiero la carne.' It means I love fruit, but I don't like fish. I prefer meat. Notice that fruta and pescado are singular, so you use gusta and encanta.

## Common mistakes
- Writing 'Me gusta las patatas'. Patatas is plural, so use gustan.
- Saying 'Soy hambre'. Use tengo hambre.
- Confusing la comida (lunch, or food in general) with el comer (eating).
- Mixing the false friend: el pan is bread, not a pan.
- Forgetting the accent in jamón.

## How this is examined
In reading tasks you meet a menu, a shopping list, an email about a party or a short text about eating habits and answer detail questions. In listening tasks a speaker describes what they eat at different times of day, so you need to link each meal with the correct food. In writing you describe your favourite foods, what you eat for different meals, and give opinions with porque.

Exam tip: Match each food word with its meal and time. Texts often include distractors like a brother who drinks coffee, so read carefully who eats or drinks what.$mq$ from st;

-- Food and Shopping > Ordering in a Café
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Food and Shopping$mq$, 5, 5 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Ordering in a Café$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Food and Shopping$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Ordering in a Café$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In a café, what does 'la carta' mean?$mq$, $mq$["the menu","the bill","the table","the letter"]$mq$, 0, $mq$In a restaurant or café, la carta is the menu. The bill is la cuenta, and the table is la mesa.$mq$, $mq$easy$mq$),
($mq$What does 'un café con leche' mean?$mq$, $mq$["a black coffee","a hot chocolate","a tea with lemon","a coffee with milk"]$mq$, 3, $mq$Café con leche is coffee with milk. Café solo is black coffee.$mq$, $mq$easy$mq$),
($mq$How do you ask for the bill politely?$mq$, $mq$["La carta, por favor.","La mesa, por favor.","La cuenta, por favor.","La taza, por favor."]$mq$, 2, $mq$La cuenta is the bill. Do not mix it up with la carta (menu).$mq$, $mq$easy$mq$),
($mq$A waiter says '¡Buen provecho!' What does he mean?$mq$, $mq$["Good morning!","Enjoy your meal!","Pay now!","See you soon!"]$mq$, 1, $mq$Buen provecho is said before a meal, like 'Enjoy your meal' or 'Bon appétit'.$mq$, $mq$easy$mq$),
($mq$What is 'un bocadillo'?$mq$, $mq$["a sandwich made with a bread roll","a cake","a drink","a bill"]$mq$, 0, $mq$Un bocadillo is a sandwich made with a long bread roll. It is very common in Spain.$mq$, $mq$easy$mq$),
($mq$Read the dialogue.
'—Buenos días, ¿qué desea? —Un café con leche y una tortilla de patatas, por favor. —¿Algo más? —No, nada más, gracias.'
What does the customer order?$mq$, $mq$["A black coffee and a sandwich","Tea and a cake","Coffee with milk and chips","Coffee with milk and a potato omelette"]$mq$, 3, $mq$The customer asks for un café con leche and una tortilla de patatas (a Spanish potato omelette) and nothing else.$mq$, $mq$medium$mq$),
($mq$Read the menu board.
'Café solo 1,30 €. Café con leche 1,60 €. Zumo de naranja 2,40 €. Churros 2,90 €. Bocadillo de jamón 3,80 €.'
Sara orders a café con leche and churros. How much is it?$mq$, $mq$["4,10 €","4,90 €","4,50 €","5,40 €"]$mq$, 2, $mq$1,60 + 2,90 = 4,50 €. The others come from adding the wrong prices.$mq$, $mq$medium$mq$),
($mq$Which sentence is a polite way to order a tea?$mq$, $mq$["Soy un té, por favor.","Quisiera un té, por favor.","Tengo un té, por favor.","Estoy un té, por favor."]$mq$, 1, $mq$Quisiera means 'I would like' and is polite. You cannot be, have or stay a tea in this context.$mq$, $mq$medium$mq$),
($mq$The waiter asks '¿Algo más?' You do not want anything else. What do you say?$mq$, $mq$["No, nada más, gracias.","Sí, tengo veinte años.","Buenos días.","Soy estudiante."]$mq$, 0, $mq$¿Algo más? means 'Anything else?' and the natural reply is No, nada más, gracias.$mq$, $mq$medium$mq$),
($mq$A customer asks for 'agua sin gas'. What does she want?$mq$, $mq$["sparkling water","hot water","water with ice","still water"]$mq$, 3, $mq$Sin gas means without bubbles, so still water. Con gas is sparkling.$mq$, $mq$medium$mq$),
($mq$A customer asks '¿Cuánto es?' and the waiter answers 'Son siete euros con cincuenta.' How much must the customer pay?$mq$, $mq$["7,15 €","17,50 €","7,50 €","70,50 €"]$mq$, 2, $mq$Siete euros con cincuenta is 7 euros and 50 cents, so 7,50 €.$mq$, $mq$medium$mq$),
($mq$Read the notice.
'Cerrado los lunes. Abierto de martes a domingo, de 8:00 a 20:00. Se aceptan tarjetas.'
Which statement is true?$mq$, $mq$["The café is open on Mondays.","Customers can pay by card.","The café closes at 8:00 in the morning.","The café is only open at weekends."]$mq$, 1, $mq$Se aceptan tarjetas means cards are accepted. The café is closed on Mondays and is open from 8:00 to 20:00, Tuesday to Sunday.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly asks if they have vegetarian dishes?$mq$, $mq$["¿Tienen platos vegetarianos?","¿Tienes platos vegetariano?","¿Tiene platos vegetarianas?","¿Tengo platos vegetarianos?"]$mq$, 0, $mq$Platos is masculine plural, so the adjective is vegetarianos. Tienen is the they form, used when asking a restaurant.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'Camarero: Buenas tardes, ¿qué van a tomar? Chica: Yo quiero un bocadillo de queso y una limonada. Chico: Para mí, una ensalada mixta y agua con gas. Camarero: Muy bien. Chica: Perdón, ¿tienen helados? Camarero: Sí, de chocolate y de fresa. Chica: Entonces, un helado de fresa después.'
What drink does the boy order and what dessert does the girl choose?$mq$, $mq$["Lemonade; chocolate ice cream","Still water; strawberry ice cream","Sparkling water; chocolate ice cream","Sparkling water; strawberry ice cream"]$mq$, 3, $mq$The boy orders agua con gas (sparkling water). The girl asks for un helado de fresa, a strawberry ice cream. The lemonade is the girl's drink.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'We want two teas and a cake'?$mq$, $mq$["Quiero dos tés y un pastel.","Queremos dos té y una pastel.","Queremos dos tés y un pastel.","Quieren dos tés y un pastel."]$mq$, 2, $mq$Queremos is the 'we' form of querer. Quiero means I want and quieren means they want. Pastel is masculine, so un pastel.$mq$, $mq$hard$mq$),
($mq$Read the menu.
'Bocadillo de queso 3,50 €. Zumo 2,20 €. Helado 2,80 €.'
Two friends go to the café. One has a cheese sandwich and a juice. The other has an ice cream and a juice. What is the total?$mq$, $mq$["9,70 €","10,70 €","10,20 €","11,70 €"]$mq$, 1, $mq$3,50 + 2,20 + 2,80 + 2,20 = 10,70 €. Remember that there are two juices.$mq$, $mq$hard$mq$),
($mq$Read the review.
'Café Luna: Me gusta mucho este café. El camarero es simpático y el chocolate caliente es riquísimo, pero los bocadillos son caros y la música es muy alta.'
What does the writer NOT like?$mq$, $mq$["The expensive sandwiches and loud music","The waiter and the hot chocolate","The cheap prices and quiet atmosphere","The cold drinks and slow service"]$mq$, 0, $mq$The word pero introduces the negatives: los bocadillos son caros (expensive) y la música es muy alta (loud).$mq$, $mq$hard$mq$),
($mq$Read the dialogue.
'—¿Puedo pagar con tarjeta? —Lo siento, solo efectivo.'
What is the problem for the customer?$mq$, $mq$["The café is closed.","The food is cold.","The bill is too expensive.","The café only accepts cash."]$mq$, 3, $mq$Solo efectivo means cash only, so the customer cannot pay by card (con tarjeta).$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Ordering in a Café$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$la carta / la cuenta$mq$, $mq$the menu / the bill$mq$),
($mq$Quisiera un café con leche, por favor.$mq$, $mq$I would like a coffee with milk, please.$mq$),
($mq$¿Algo más?$mq$, $mq$Anything else? Reply: No, nada más, gracias.$mq$),
($mq$¿Cuánto es?$mq$, $mq$How much is it?$mq$),
($mq$agua con gas / sin gas$mq$, $mq$sparkling water / still water$mq$),
($mq$¿Puedo pagar con tarjeta?$mq$, $mq$Can I pay by card? (cash = efectivo)$mq$),
($mq$Queremos dos tés.$mq$, $mq$We want two teas. (quiero = I want; quieren = they want)$mq$),
($mq$¡Buen provecho!$mq$, $mq$Enjoy your meal!$mq$),
($mq$un bocadillo de queso$mq$, $mq$a cheese roll (a sandwich made with a bread roll)$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Ordering in a Café$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## In a café (en una cafetería)
A trip to a Spanish café is a very common exam context. You need vocabulary for food and drink, and polite phrases for ordering and paying.

## Drinks and food
- un café solo (black coffee), un café con leche (coffee with milk), un cortado (coffee with a little milk)
- un té (tea), un chocolate caliente (hot chocolate), un zumo de naranja (orange juice)
- agua con gas / sin gas (sparkling / still water), un refresco (soft drink), una limonada (lemonade)
- un bocadillo de jamón / queso (a ham / cheese roll), una tortilla de patatas (potato omelette)
- unos churros (churros), un helado (ice cream), un pastel (cake), una ensalada (salad), unas tapas (small snacks)

## Things in the café
- el camarero / la camarera (waiter / waitress), la mesa (table), la carta or el menú (menu)
- la cuenta (the bill), la propina (tip), la taza (cup), el vaso (glass), el plato (plate)
- efectivo (cash), la tarjeta (card)

## Phrases for the customer
- Quisiera un café con leche, por favor. (I would like a coffee with milk, please.)
- Quiero... / Me gustaría... (I want... / I would like...)
- Para mí, un té. (For me, a tea.)
- ¿Tienen helados? (Do you have ice cream?)
- ¿Tienen platos vegetarianos? (Do you have vegetarian dishes?)
- Nada más, gracias. (Nothing else, thank you.)
- La cuenta, por favor. (The bill, please.) ¿Cuánto es? (How much is it?)
- ¿Puedo pagar con tarjeta? (Can I pay by card?)

## Phrases from the waiter
- ¿Qué desea? / ¿Qué van a tomar? (What would you like?)
- ¿Algo más? (Anything else?)
- Aquí tiene. (Here you are.)
- Son siete euros con cincuenta. (It's 7.50 euros.)
- ¡Buen provecho! (Enjoy your meal!)

## Prices
In Spain a comma is used for decimals: 1,60 € is one euro sixty. You say uno con sesenta, or un euro con sesenta. Practise adding prices, because exam questions often ask for a total.

## Common mistakes
- Mixing up la carta (menu) and la cuenta (bill).
- Forgetting that queremos is we want and quieren is they want.
- Using the wrong gender: un pastel, una limonada.
- Reading 3,50 as three thousand five hundred: the comma is a decimal point.

## Worked example
A dialogue says: 'Un café con leche y dos churros.' Prices: café con leche 1,60 €, churros 2,90 €. The total is 4,50 €.

## How this is examined
Reading tasks give a café menu, a dialogue or a review and ask what someone orders, how much it costs, or what the opinion is. Listening tasks often play a conversation between a waiter and two customers. In writing, you may be asked to write a short dialogue or a message to a friend about a café visit.

Exam tip: When a listening text has two people ordering, write down each person's order separately as you listen, because the questions often swap the details.$mq$ from st;

-- Food and Shopping > Shopping, Prices and Clothes
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Food and Shopping$mq$, 5, 5 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Shopping, Prices and Clothes$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Food and Shopping$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Shopping, Prices and Clothes$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is 'la falda' in English?$mq$, $mq$["skirt","dress","shirt","scarf"]$mq$, 0, $mq$La falda is a skirt. A dress is el vestido, a shirt is la camisa and a scarf is la bufanda.$mq$, $mq$easy$mq$),
($mq$A shop window says 'Rebajas'. What does this mean?$mq$, $mq$["New arrivals","Closed","Free delivery","Sales"]$mq$, 3, $mq$Las rebajas are the sales, when prices are reduced.$mq$, $mq$easy$mq$),
($mq$Which English word matches 'los zapatos'?$mq$, $mq$["socks","boots","shoes","trousers"]$mq$, 2, $mq$Los zapatos are shoes. Socks are los calcetines, boots are las botas and trousers are los pantalones.$mq$, $mq$easy$mq$),
($mq$What colour is 'azul'?$mq$, $mq$["green","blue","red","yellow"]$mq$, 1, $mq$Azul is blue. Verde is green, rojo is red and amarillo is yellow.$mq$, $mq$easy$mq$),
($mq$Which question asks the price of one item?$mq$, $mq$["¿Cuánto cuesta?","¿Cuántos años tienes?","¿Cómo te llamas?","¿A qué hora abre?"]$mq$, 0, $mq$¿Cuánto cuesta? means How much does it cost? For plural items, you say ¿Cuánto cuestan?$mq$, $mq$easy$mq$),
($mq$Choose the correct word: Me gusta la camiseta ____.$mq$, $mq$["rojo","rojos","rojas","roja"]$mq$, 3, $mq$Camiseta is feminine singular, so the adjective must be roja.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: Los pantalones son ____.$mq$, $mq$["negro","negra","negros","negras"]$mq$, 2, $mq$Pantalones is masculine plural, so the adjective is negros.$mq$, $mq$medium$mq$),
($mq$Read the label.
'Jersey de lana. Talla M. 39,95 €. 20 % de descuento.'
What does the label tell you?$mq$, $mq$["A cotton shirt, size M, with no discount","A wool jumper, size M, with a 20 % discount","A leather jacket, size L, with a 20 % discount","A wool jumper, size S, with a 30 % discount"]$mq$, 1, $mq$Jersey de lana is a wool jumper, talla M is size medium and 20 % de descuento is a 20 per cent discount.$mq$, $mq$medium$mq$),
($mq$Read the dialogue.
'—¿Puedo probarme estos zapatos? —Claro, el probador está allí. —Me quedan pequeños. ¿Tiene el número 40? —Sí, un momento.'
What is the problem with the shoes?$mq$, $mq$["They are too small.","They are too expensive.","They are the wrong colour.","They are too big."]$mq$, 0, $mq$Me quedan pequeños means they are too small for me. That is why the customer asks for a bigger size (el número 40).$mq$, $mq$medium$mq$),
($mq$A customer says 'Es demasiado caro.' What does she mean?$mq$, $mq$["It's very cheap.","It's too small.","It's very nice.","It's too expensive."]$mq$, 3, $mq$Demasiado means too (much) and caro means expensive. Barato is cheap.$mq$, $mq$medium$mq$),
($mq$A T-shirt costs 12,50 € and trousers cost 29,90 €. What is the total cost?$mq$, $mq$["41,40 €","42,90 €","42,40 €","52,40 €"]$mq$, 2, $mq$12,50 + 29,90 = 42,40 €.$mq$, $mq$medium$mq$),
($mq$A jacket costs 80 € and has a 25 % discount. How much does it cost now?$mq$, $mq$["20 €","60 €","55 €","65 €"]$mq$, 1, $mq$25 % of 80 is 20, and 80 − 20 = 60 €. The 20 € option is the discount, not the new price.$mq$, $mq$medium$mq$),
($mq$Choose the correct word: ____ botas son muy bonitas.$mq$, $mq$["Estas","Este","Esta","Estos"]$mq$, 0, $mq$Botas is feminine plural, so you need estas (these). Este and esta are singular, and estos is masculine plural.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'Hola, busco una chaqueta negra para mi hermano. Es talla L y mi presupuesto es de cincuenta euros. —Tenemos esta chaqueta por cuarenta y cinco euros, pero solo en azul. —¿Y en negro? —En negro cuesta sesenta euros.'
Why can the customer NOT buy the black jacket?$mq$, $mq$["It is the wrong size.","It is not available.","It is too small for her brother.","It costs more than her budget."]$mq$, 3, $mq$The black jacket costs 60 euros but her budget is 50 euros. The blue jacket (45 euros) is within the budget, but it is the wrong colour.$mq$, $mq$hard$mq$),
($mq$Read the text.
'Mi tienda favorita es Moda Joven. Vende ropa barata y moderna. Siempre compro allí los vaqueros y las camisetas. Las zapatillas son más caras, por eso las compro en el mercado.'
Where does the writer buy trainers, and why?$mq$, $mq$["In Moda Joven, because they are cheap","In the market, because they are modern","In the market, because they are cheaper there","In Moda Joven, because they are more expensive"]$mq$, 2, $mq$Las zapatillas son más caras (in Moda Joven), por eso las compro en el mercado: the writer buys them at the market because it is cheaper there.$mq$, $mq$hard$mq$),
($mq$Jeans cost 36 € and trainers cost 48 €. The shop offers 'Todo con un 15 % de descuento'. What is the total price after the discount?$mq$, $mq$["12,60 €","71,40 €","83,85 €","96,60 €"]$mq$, 1, $mq$36 + 48 = 84, and 15 % of 84 is 12,60. So the price is 84 − 12,60 = 71,40 €. The 12,60 € option is the discount only.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly asks 'Can I try on this skirt?'$mq$, $mq$["¿Puedo probarme esta falda?","¿Puedo comprarme esta falda?","¿Puedo probarme este falda?","¿Puedo probarme esta faldas?"]$mq$, 0, $mq$Probarse means to try on. Falda is feminine singular, so you need esta falda. Comprarse means to buy for oneself.$mq$, $mq$hard$mq$),
($mq$Read the advert.
'Gran liquidación: camisetas a 5 €, vaqueros a 15 €, abrigos a 30 €. Solo hoy. No se aceptan devoluciones.'
Which statement is true?$mq$, $mq$["You can return items.","The sale lasts all week.","T-shirts cost 15 €.","Items cannot be returned."]$mq$, 3, $mq$No se aceptan devoluciones means returns are not accepted. Solo hoy means only today, and the T-shirts cost 5 €.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Shopping, Prices and Clothes$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$la camiseta / el jersey / la falda$mq$, $mq$T-shirt / jumper / skirt$mq$),
($mq$los pantalones / los vaqueros$mq$, $mq$trousers / jeans (both plural in Spanish)$mq$),
($mq$una camiseta roja, unos zapatos negros$mq$, $mq$a red T-shirt, black shoes (colours agree with the noun and follow it)$mq$),
($mq$¿Cuánto cuesta? / ¿Cuánto cuestan?$mq$, $mq$How much does it cost? / How much do they cost?$mq$),
($mq$¿Puedo probarme esta chaqueta?$mq$, $mq$Can I try on this jacket?$mq$),
($mq$Es demasiado caro.$mq$, $mq$It's too expensive. (barato = cheap)$mq$),
($mq$este / esta / estos / estas$mq$, $mq$this (m) / this (f) / these (m) / these (f)$mq$),
($mq$las rebajas / el descuento$mq$, $mq$the sales / the discount$mq$),
($mq$la talla / el número$mq$, $mq$clothes size / shoe size$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Shopping, Prices and Clothes$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Clothes (la ropa)
- la camiseta (T-shirt), la camisa (shirt), el jersey (jumper), la chaqueta (jacket), el abrigo (coat)
- los pantalones (trousers), los vaqueros (jeans), la falda (skirt), el vestido (dress)
- los zapatos (shoes), las zapatillas (trainers), las botas (boots), los calcetines (socks)
- la gorra (cap), la bufanda (scarf), el cinturón (belt)

## Colours (los colores)
Colours are adjectives, so they agree with the noun and normally come after it.
- rojo/a (red), azul (blue), verde (green), amarillo/a (yellow), negro/a (black), blanco/a (white)
- gris (grey), rosa (pink), naranja (orange), marrón (brown), morado/a (purple)
- Endings: una camiseta roja, un jersey rojo, unos pantalones negros, unas botas negras.
- Azul, verde, gris, rosa, naranja and marrón do not change for gender: una falda azul, un coche azul. Add -es in the plural if they end in a consonant: azules, grises.

## In the shop (en la tienda)
- ¿Cuánto cuesta? / ¿Cuánto cuestan? (How much does it cost? / How much do they cost?)
- Cuesta veinte euros. (It costs 20 euros.)
- ¿Puedo probarme esta camiseta? (Can I try on this T-shirt?) El probador is the changing room.
- ¿Tiene otra talla? (Do you have another size?) La talla means clothes size, and el número is shoe size.
- Me queda bien / pequeño / grande. (It fits me well / it is small / it is big.)
- Es demasiado caro. (It's too expensive.) Es barato. (It's cheap.)
- Me lo llevo. (I'll take it.) La caja is the till.
- las rebajas (sales), el descuento (discount), la oferta (special offer)

## Demonstratives (this / these)
- este jersey, esta camisa, estos zapatos, estas botas
They agree with the noun in gender and number.

## Percentages and totals
MYP exam questions often include prices and discounts. Example: a coat costs 60 €, with a 10 % discount. 10 % of 60 is 6, so the new price is 54 €. Always check whether the question asks for the discount or the final price.

## Common mistakes
- Putting the colour before the noun and forgetting to make it agree: write una camisa blanca, not una blanco camisa.
- Confusing la talla (size of clothes) with el número (shoe size).
- Confusing comprar (to buy) with probar (to try).
- Reading 12,50 € incorrectly: the comma is the decimal point.

## How this is examined
Reading tasks include shop adverts, price labels, short dialogues in a clothes shop or an email about shopping. You must read details such as colour, size, price and discount. Listening tasks may give a customer and an assistant discussing what is available, so listen for numbers. In writing you describe clothes you want to buy, saying colour, size and price.

Exam tip: Underline every number and colour in the text first. Distractors usually use the same words with a different number or colour, such as the black jacket at 60 € versus the blue jacket at 45 €.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;