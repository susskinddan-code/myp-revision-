-- Part 5 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Food and Shopping > Food and Drink
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Food and Shopping$mq$, 5, 5 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Food and Drink$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Food and Shopping$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Food and Drink$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'du pain' mean?$mq$, $mq$["some bread","some cheese","some water","some milk"]$mq$, 0, $mq$'Pain' is bread, and 'du' means some (masculine partitive).$mq$, $mq$easy$mq$),
($mq$What does 'une pomme' mean?$mq$, $mq$["a pear","a potato","an orange","an apple"]$mq$, 3, $mq$'Une pomme' is an apple. 'Une pomme de terre' is a potato.$mq$, $mq$easy$mq$),
($mq$What does 'l'eau' mean?$mq$, $mq$["milk","juice","water","wine"]$mq$, 2, $mq$'L'eau' is water. Milk is 'le lait' and juice is 'le jus'.$mq$, $mq$easy$mq$),
($mq$What does 'le fromage' mean?$mq$, $mq$["ham","cheese","butter","bread"]$mq$, 1, $mq$'Le fromage' is cheese, famous in France. Ham is 'le jambon'.$mq$, $mq$easy$mq$),
($mq$What does 'le poulet' mean?$mq$, $mq$["chicken","fish","beef","pork"]$mq$, 0, $mq$'Le poulet' is chicken. Fish is 'le poisson'.$mq$, $mq$easy$mq$),
($mq$Which of these words is a fruit?$mq$, $mq$["la carotte","le jambon","le riz","la fraise"]$mq$, 3, $mq$'La fraise' is a strawberry. A carrot is a vegetable, ham is meat and rice is a grain.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Je voudrais ___ eau.'$mq$, $mq$["du","des","de l'","de la"]$mq$, 2, $mq$Before a vowel or silent h, 'du/de la' both become 'de l'': 'de l'eau'.$mq$, $mq$medium$mq$),
($mq$What does 'Je n'aime pas les légumes' mean?$mq$, $mq$["I like vegetables.","I do not like vegetables.","I do not eat fruit.","I never cook."]$mq$, 1, $mq$'Ne... pas' makes it negative, and 'les légumes' are vegetables. After 'aimer' you use 'le/la/les', not 'du'.$mq$, $mq$medium$mq$),
($mq$Which sentence says you love chocolate?$mq$, $mq$["J'adore le chocolat.","Je déteste le chocolat.","Je mange du chocolat.","Je n'aime pas le chocolat."]$mq$, 0, $mq$'J'adore' means I love. 'Je déteste' means I hate.$mq$, $mq$medium$mq$),
($mq$What does 'le déjeuner' mean?$mq$, $mq$["breakfast","dinner","a snack","lunch"]$mq$, 3, $mq$'Le déjeuner' is lunch. 'Le petit déjeuner' is breakfast and 'le dîner' is dinner.$mq$, $mq$medium$mq$),
($mq$'Je suis végétarien, je ne mange pas de viande.' What does the speaker avoid?$mq$, $mq$["vegetables","cheese","meat","bread"]$mq$, 2, $mq$'La viande' is meat. Notice that the false friend is not 'viand' in English.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Je ne bois pas ___ lait.'$mq$, $mq$["du","de","le","des"]$mq$, 1, $mq$After a negative, the partitive (du, de la, des) becomes 'de' or 'd'': 'pas de lait'.$mq$, $mq$medium$mq$),
($mq$Which phrase means 'I am thirsty'?$mq$, $mq$["J'ai soif.","J'ai faim.","Je suis soif.","Je suis content."]$mq$, 0, $mq$French uses 'avoir' (to have) for hunger and thirst: 'j'ai soif'. 'J'ai faim' means I am hungry.$mq$, $mq$medium$mq$),
($mq$Menu du jour: 'Entrée : salade verte. Plat : poulet avec des frites. Dessert : tarte aux pommes. Boisson comprise.' Which statement is true?$mq$, $mq$["The dessert is chocolate cake.","There is a fish dish.","There is no starter.","A drink is included."]$mq$, 3, $mq$'Boisson comprise' means drink included. The dessert is an apple tart and the starter is a green salad.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'Le matin, je prends des céréales et du lait. Je ne mange pas de pain parce que je n'aime pas ça.' What does the speaker NOT eat for breakfast?$mq$, $mq$["cereal","milk","bread","chocolate"]$mq$, 2, $mq$'Je ne mange pas de pain' means I do not eat bread. Cereal and milk are what the speaker has.$mq$, $mq$hard$mq$),
($mq$Which sentence is completely correct?$mq$, $mq$["Je mange de fromage et je bois de l'eau.","Je mange du fromage et je bois de l'eau.","Je mange du fromage et je bois du l'eau.","Je mange des fromage et je bois de eau."]$mq$, 1, $mq$'Fromage' is masculine so 'du fromage'; 'eau' starts with a vowel so 'de l'eau'. The others break these rules.$mq$, $mq$hard$mq$),
($mq$'Léo est allergique aux noix et aux œufs.' What can Léo NOT eat?$mq$, $mq$["nuts and eggs","fish and milk","bread and eggs","nuts and cheese"]$mq$, 0, $mq$'Aux noix' means to nuts and 'aux œufs' means to eggs. 'Allergique à' means allergic to.$mq$, $mq$hard$mq$),
($mq$Sofia reads 'des raisins' on a market stall. What are they selling?$mq$, $mq$["raisins (dried fruit)","plums","cherries","grapes"]$mq$, 3, $mq$'Un raisin' is a grape. Dried grapes are 'des raisins secs'. This is a false friend.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Food and Drink$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$du pain / de la salade / de l'eau / des légumes$mq$, $mq$some bread / some salad / some water / some vegetables (the four partitives)$mq$),
($mq$Je ne mange pas de viande.$mq$, $mq$I do not eat meat. (du/de la/des become de after a negative)$mq$),
($mq$J'ai faim. / J'ai soif.$mq$, $mq$I am hungry. / I am thirsty. (avoir, not être)$mq$),
($mq$le petit déjeuner / le déjeuner / le dîner$mq$, $mq$breakfast / lunch / dinner$mq$),
($mq$J'adore / J'aime / Je n'aime pas / Je déteste$mq$, $mq$I love / I like / I do not like / I hate$mq$),
($mq$un raisin$mq$, $mq$a grape (false friend; dried grapes are des raisins secs)$mq$),
($mq$la viande / le poisson / le poulet$mq$, $mq$meat / fish / chicken$mq$),
($mq$Je suis végétarien(ne).$mq$, $mq$I am vegetarian.$mq$),
($mq$beaucoup de fruits$mq$, $mq$lots of fruit (de after quantity words)$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Food and Drink$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Food is a topic that appears in almost every beginner French course and exam. This note gives you the key words and the grammar of "some", "the" and negatives, which is where most marks are lost.

## Meals and drinks
- le petit déjeuner (breakfast), le déjeuner (lunch), le goûter (an afternoon snack), le dîner (dinner)
- l'eau (water), le lait (milk), le jus d'orange (orange juice), le thé (tea), le café (coffee)
- une limonade (lemonade), un chocolat chaud (hot chocolate)

## Foods
- le pain (bread), le fromage (cheese), le beurre (butter), les œufs (eggs)
- le poulet (chicken), le jambon (ham), le poisson (fish), la viande (meat)
- les légumes (vegetables): une carotte, des haricots verts (green beans), des pommes de terre (potatoes)
- les fruits (fruit): une pomme, une banane, une fraise (strawberry), un raisin (a grape)
- le riz (rice), les pâtes (pasta), les frites (chips), la salade, un gâteau (a cake), une glace (an ice cream)

## Saying what you like
Use "j'aime" (I like), "j'adore" (I love), "je n'aime pas" (I do not like) and "je déteste" (I hate) with the definite article le, la, l', les: "J'aime les fruits", "Je déteste le poisson". The article here talks about things in general.

## Saying what you eat or drink: the partitive
To say "some", use du (masculine), de la (feminine), de l' (before a vowel or silent h) and des (plural).
- Je mange du pain. (I eat some bread.)
- Je mange de la salade. (I eat some salad.)
- Je bois de l'eau. (I drink some water.)
- Je mange des légumes. (I eat vegetables.)

After a negative, all of these become de (or d'): "Je ne mange pas de viande", "Il ne boit pas d'eau". After a quantity word you also use de: "un verre de lait" (a glass of milk), "beaucoup de fruits" (lots of fruit).

## Hungry, thirsty and diets
French uses avoir: "J'ai faim" (I am hungry), "J'ai soif" (I am thirsty). Useful for diets: "Je suis végétarien / végétarienne" (I am vegetarian), "Je suis allergique aux noix" (I am allergic to nuts).

## False friends
- un raisin is a grape, not a raisin (dried grape: un raisin sec)
- la viande is meat, not "viand"
- un pain is a loaf or bread, not a pan

## Common mistakes
- Writing "Je mange de pain" (it should be du pain) or "Je ne mange pas du pain" (de pain).
- Forgetting the article after "j'aime": "J'aime fromage" should be "J'aime le fromage".
- Saying "Je suis faim" instead of "J'ai faim".
- Mixing up "le déjeuner" (lunch) with "le petit déjeuner" (breakfast).

## How this is examined
Reading tasks often use a menu, a recipe list or a short blog about favourite meals. You may be given a school canteen menu and asked what a vegetarian can choose. Listening transcripts give two people discussing what they eat for breakfast and lunch. In writing, you describe your favourite meal and say what you do not like, using "j'aime", "je n'aime pas" and at least one partitive.

Exam tip: When you see "pas de" or "ne... jamais de" in a text, circle the food that follows it. That item is the one the speaker does NOT eat, and examiners love this trap.$mq$ from st;

-- Food and Shopping > Ordering in a Café
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Food and Shopping$mq$, 5, 5 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Ordering in a Café$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Food and Shopping$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Ordering in a Café$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'Je voudrais un café' mean?$mq$, $mq$["I would like a coffee.","I am making a coffee.","I have a coffee.","I do not like coffee."]$mq$, 0, $mq$'Je voudrais' means I would like and is the polite way to order.$mq$, $mq$easy$mq$),
($mq$You want to pay in a café. What do you say?$mq$, $mq$["La carte, s'il vous plaît.","Une table, s'il vous plaît.","Un menu, s'il vous plaît.","L'addition, s'il vous plaît."]$mq$, 3, $mq$'L'addition' is the bill. 'La carte' is the menu.$mq$, $mq$easy$mq$),
($mq$What does 'un jus d'orange' mean?$mq$, $mq$["an orange","an orange cake","an orange juice","an orange tea"]$mq$, 2, $mq$'Un jus' is a juice, so 'un jus d'orange' is orange juice.$mq$, $mq$easy$mq$),
($mq$A waiter asks, 'Qu'est-ce que vous désirez ?' What is he asking?$mq$, $mq$["Where do you live?","What would you like?","Do you have a reservation?","How much do you want to pay?"]$mq$, 1, $mq$'Qu'est-ce que vous désirez ?' is a standard way to ask what a customer would like.$mq$, $mq$easy$mq$),
($mq$What does 'un sandwich au jambon' mean?$mq$, $mq$["a ham sandwich","a cheese sandwich","a sandwich with butter","a chicken sandwich"]$mq$, 0, $mq$'Au jambon' means with ham, and 'jambon' is ham.$mq$, $mq$easy$mq$),
($mq$The waiter says 'Et comme boisson ?' What does he mean?$mq$, $mq$["And for dessert?","And how are you?","And for how long?","And to drink?"]$mq$, 3, $mq$'Une boisson' is a drink, so 'comme boisson' means as a drink.$mq$, $mq$medium$mq$),
($mq$Which is the most polite way to ask for a lemonade?$mq$, $mq$["Donne-moi limonade.","Une limonade maintenant.","Je voudrais une limonade, s'il vous plaît.","Je veux limonade."]$mq$, 2, $mq$'Je voudrais... s'il vous plaît' is polite and grammatically correct, with 'une' before the noun.$mq$, $mq$medium$mq$),
($mq$What is 'un croque-monsieur'?$mq$, $mq$["a type of coffee","a toasted ham and cheese sandwich","a dessert with chocolate","a vegetable soup"]$mq$, 1, $mq$A croque-monsieur is a grilled sandwich with ham and cheese, common on café menus.$mq$, $mq$medium$mq$),
($mq$How do you ask 'How much is it?'$mq$, $mq$["C'est combien ?","C'est quand ?","C'est où ?","C'est qui ?"]$mq$, 0, $mq$'Combien' means how much. 'Quand' is when, 'où' is where and 'qui' is who.$mq$, $mq$medium$mq$),
($mq$The waiter says 'Ça fait huit euros cinquante.' How much is it?$mq$, $mq$["€5.80","€8.05","€18.50","€8.50"]$mq$, 3, $mq$'Huit euros cinquante' is 8 euros and 50 cents, so €8.50.$mq$, $mq$medium$mq$),
($mq$Menu: 'Thé 2,50 € ; Chocolat chaud 3,20 € ; Eau minérale 2 €'. How much is a hot chocolate?$mq$, $mq$["€2.50","€2.00","€3.20","€3.50"]$mq$, 2, $mq$'Chocolat chaud' is hot chocolate and its price is 3,20 € (trois euros vingt). French uses a comma where English uses a decimal point.$mq$, $mq$medium$mq$),
($mq$The waiter asks 'Vous avez choisi ?' What does he want to know?$mq$, $mq$["Do you have a table?","Have you chosen?","Have you paid?","Are you hungry?"]$mq$, 1, $mq$'Choisir' means to choose. 'Vous avez choisi' is 'you have chosen'.$mq$, $mq$medium$mq$),
($mq$A customer says 'Je prendrai une crêpe au sucre.' What will they have?$mq$, $mq$["a pancake with sugar","a cake with salt","a coffee with sugar","a crêpe with ham"]$mq$, 0, $mq$'Je prendrai' means I will have. 'Au sucre' means with sugar.$mq$, $mq$medium$mq$),
($mq$Dialogue: Serveur : 'Bonjour, vous désirez ?' Client : 'Un croque-monsieur et un jus de pomme.' Serveur : 'Très bien.' Client : 'Et l'addition, s'il vous plaît.' Serveur : 'Voilà, ça fait neuf euros.' What does the customer order to drink?$mq$, $mq$["an orange juice","a coffee","a bottle of water","an apple juice"]$mq$, 3, $mq$'Un jus de pomme' is an apple juice. The croque-monsieur is food.$mq$, $mq$hard$mq$),
($mq$Prices: café 2,20 € ; croissant 1,40 €. Léa orders 'Deux cafés et un croissant, s'il vous plaît.' What is the total?$mq$, $mq$["€5.60","€6.00","€5.80","€3.60"]$mq$, 2, $mq$2 × 2.20 = 4.40, and 4.40 + 1.40 = 5.80. The total is 5,80 € (cinq euros quatre-vingts).$mq$, $mq$hard$mq$),
($mq$Listening transcript: Client : 'Je voudrais une table pour trois personnes, s'il vous plaît.' Serveur : 'Désolé, c'est complet à l'intérieur. Il y a de la place à la terrasse.' What does the waiter say?$mq$, $mq$["The café is closed.","There is no space inside but there is space on the terrace.","There is a table free inside only.","The terrace is full."]$mq$, 1, $mq$'Complet' means full, 'à l'intérieur' means inside, and 'de la place à la terrasse' means room on the terrace.$mq$, $mq$hard$mq$),
($mq$Sign: 'Menu enfant : un plat, une boisson et une glace, 7 €. Pas de menu enfant après 21 h.' Which statement is true?$mq$, $mq$["The children's menu is not served after 9 p.m.","It costs 21 euros.","It includes a starter and a dessert.","Adults must order it."]$mq$, 0, $mq$'Pas... après 21 h' means not after 9 p.m. The price is 7 euros and the menu has a main, a drink and an ice cream.$mq$, $mq$hard$mq$),
($mq$A customer says 'Un thé sans sucre et un gâteau, s'il vous plaît.' What does he want?$mq$, $mq$["a tea with sugar and a cake","a coffee without sugar","a tea and a salad","a tea without sugar and a cake"]$mq$, 3, $mq$'Sans' means without and 'avec' means with. The order is tea with no sugar plus a cake.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Ordering in a Café$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Je voudrais...$mq$, $mq$I would like... (polite way to order)$mq$),
($mq$L'addition, s'il vous plaît.$mq$, $mq$The bill, please.$mq$),
($mq$Vous désirez ?$mq$, $mq$What would you like? (waiter)$mq$),
($mq$Et comme boisson ?$mq$, $mq$And to drink?$mq$),
($mq$sans / avec$mq$, $mq$without / with: un thé sans sucre = a tea without sugar$mq$),
($mq$la carte / le menu$mq$, $mq$the full list of dishes / a fixed-price meal$mq$),
($mq$C'est combien ?$mq$, $mq$How much is it?$mq$),
($mq$3,20 €$mq$, $mq$trois euros vingt (French uses a comma)$mq$),
($mq$un croque-monsieur$mq$, $mq$a toasted ham and cheese sandwich$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Ordering in a Café$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Ordering food and drink in French is a very practical situation, and it is a favourite for role-plays, dialogue reading and short transcripts. The language is predictable once you know a few polite phrases.

## Key phrases for the customer
- Bonjour, une table pour deux personnes, s'il vous plaît. (A table for two, please.)
- Je voudrais... (I would like...)
- Je prends... / Je prendrai... (I'll have... / I will have...)
- Avez-vous...? / Vous avez...? (Do you have...?)
- C'est combien ? / Ça fait combien ? (How much is it?)
- L'addition, s'il vous plaît. (The bill, please.)
- Merci, c'était très bon. (Thank you, it was very good.)

## What the waiter says
- Vous désirez ? / Qu'est-ce que vous désirez ? (What would you like?)
- Vous avez choisi ? (Have you chosen?)
- Et comme boisson ? (And to drink?)
- Ce sera tout ? (Will that be all?)
- Voilà. (Here you are.)
- Ça fait dix euros. (That's ten euros.)

## Menu vocabulary
- une boisson chaude (hot drink): un café, un thé, un chocolat chaud
- une boisson froide (cold drink): une eau minérale, une limonade, un jus de pomme
- un croissant, une baguette, un sandwich au fromage, un croque-monsieur
- une crêpe, une glace, une tarte aux pommes
- le plat du jour (today's special), le menu (a fixed-price meal), la carte (the list of everything)
- sans (without), avec (with): un thé sans sucre, un café avec du lait

## Politeness and register
Always use "vous" and "s'il vous plaît" with the waiter. "Je voudrais" is much more polite than "je veux" (I want). Say "Bonjour" when you enter, and "Merci, au revoir" when you leave.

## Prices
French writes prices with a comma: 3,20 € is "trois euros vingt". 2,50 € is "deux euros cinquante". A price like 5,80 € can be read "cinq euros quatre-vingts". Practise adding two or three prices, because exams often ask for a total.

## Worked example
Menu: un café 2,20 €, un croissant 1,40 €. If you order two coffees and a croissant, calculate 2 × 2.20 = 4.40 and then add 1.40 to get 5.80 €. In French: "Ça fait cinq euros quatre-vingts."

## Common mistakes
- Forgetting the article: "Je voudrais café" should be "Je voudrais un café".
- Confusing "la carte" (the menu list) with "le menu" (a set meal).
- Confusing "sans" (without) and "avec" (with), which changes the order completely.
- Writing a decimal point instead of a comma for prices.

## How this is examined
Typical items include a café dialogue, a menu with prices, a sign about opening or menu times, and a short transcript in which customers order. You are usually asked to say what was ordered, calculate a total, or spot a detail such as "no sugar" or "terrace only". In the writing task you may be asked to write a short dialogue in a café using polite phrases.

Exam tip: Re-read the order word by word. Examiners often swap "avec" and "sans", or change a quantity, so the correct answer is not simply the first drink you notice.$mq$ from st;

-- Food and Shopping > Shopping, Prices and Clothes
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Food and Shopping$mq$, 5, 5 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Shopping, Prices and Clothes$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Food and Shopping$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Shopping, Prices and Clothes$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'un pantalon' mean?$mq$, $mq$["a pair of trousers","a shirt","a skirt","a coat"]$mq$, 0, $mq$'Un pantalon' is trousers (singular in French). A shirt is 'une chemise'.$mq$, $mq$easy$mq$),
($mq$What does 'une chemise' mean?$mq$, $mq$["a chemistry lesson","a jacket","a sock","a shirt"]$mq$, 3, $mq$'Une chemise' is a shirt. Do not confuse it with 'la chimie' (chemistry).$mq$, $mq$easy$mq$),
($mq$What does 'des chaussures' mean?$mq$, $mq$["socks","gloves","shoes","hats"]$mq$, 2, $mq$'Des chaussures' are shoes, and 'des chaussettes' are socks.$mq$, $mq$easy$mq$),
($mq$What does 'Combien ça coûte ?' mean?$mq$, $mq$["Where is it?","How much does it cost?","What size is it?","When does it open?"]$mq$, 1, $mq$'Combien' is how much and 'coûter' is to cost.$mq$, $mq$easy$mq$),
($mq$What does 'une robe' mean?$mq$, $mq$["a dress","a robe for a bath","a coat","a jumper"]$mq$, 0, $mq$'Une robe' is a dress. A dressing gown is 'une robe de chambre'.$mq$, $mq$easy$mq$),
($mq$'Ça coûte vingt euros.' What is the price?$mq$, $mq$["€2","€12","€200","€20"]$mq$, 3, $mq$'Vingt' is twenty, so the price is 20 euros.$mq$, $mq$medium$mq$),
($mq$What does 'Je cherche un pull' mean?$mq$, $mq$["I am buying a pull.","I am wearing a jumper.","I am looking for a jumper.","I like this jumper."]$mq$, 2, $mq$'Chercher' means to look for. A 'pull' is a jumper.$mq$, $mq$medium$mq$),
($mq$The shop assistant asks 'Quelle taille faites-vous ?' What does she want to know?$mq$, $mq$["your colour","your size","your name","your budget"]$mq$, 1, $mq$'La taille' is size. 'Quelle pointure ?' is used for shoe size.$mq$, $mq$medium$mq$),
($mq$Which phrase correctly says 'a green skirt'?$mq$, $mq$["une jupe verte","un jupe vert","une jupe vert","une jupes vertes"]$mq$, 0, $mq$'Jupe' is feminine so the adjective takes an extra e: 'verte'. 'Une' agrees with the feminine noun.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Les chaussettes sont ___.'$mq$, $mq$["noir","noire","noirs","noires"]$mq$, 3, $mq$'Chaussettes' is feminine plural, so the adjective adds e and s: 'noires'.$mq$, $mq$medium$mq$),
($mq$What does 'C'est trop cher' mean?$mq$, $mq$["It is very cheap.","It is the right price.","It is too expensive.","It is not available."]$mq$, 2, $mq$'Trop' means too and 'cher' means expensive (or dear).$mq$, $mq$medium$mq$),
($mq$A shop window says 'Soldes !' What does it mean?$mq$, $mq$["Closed!","Sale!","New arrivals!","Free gift!"]$mq$, 1, $mq$'Les soldes' are the sales. 'C'est en solde' means it is on sale.$mq$, $mq$medium$mq$),
($mq$You want to try on a jacket. What do you ask?$mq$, $mq$["Je peux l'essayer ?","Je peux l'acheter ?","Je peux le laver ?","Je peux le payer ?"]$mq$, 0, $mq$'Essayer' means to try on. 'Acheter' is to buy.$mq$, $mq$medium$mq$),
($mq$Price tags: T-shirt 12,50 € ; jean 39,90 €. Chloé buys both. What is the total?$mq$, $mq$["€51.40","€52.30","€62.40","€52.40"]$mq$, 3, $mq$12.50 + 39.90 = 52.40. In French: 'cinquante-deux euros quarante'.$mq$, $mq$hard$mq$),
($mq$A shop sign says: 'Pull : 40 €. Moins 25 % aujourd'hui.' What is the price today?$mq$, $mq$["€15","€25","€30","€35"]$mq$, 2, $mq$25 % of 40 is 10, and 40 − 10 = 30 euros. 'Moins' here means a reduction.$mq$, $mq$hard$mq$),
($mq$Listening transcript: Cliente : 'Je voudrais cette veste en taille M.' Vendeur : 'Désolé, nous n'avons plus de M en bleu, mais nous avons du L.' Cliente : 'Alors je prends la noire.' What does the customer decide?$mq$, $mq$["She buys the blue jacket in size L.","She buys the black jacket.","She leaves without buying.","She buys a black skirt."]$mq$, 1, $mq$No blue M is left, so she says 'je prends la noire' (I'll take the black one).$mq$, $mq$hard$mq$),
($mq$Which sentence is completely correct?$mq$, $mq$["Elle porte une jupe blanche et des chaussures noires.","Elle porte une jupe blanc et des chaussures noir.","Elle porte un jupe blanche et des chaussures noires.","Elle porte une jupe blanche et des chaussures noire."]$mq$, 0, $mq$'Jupe' (f. sing.) needs 'blanche'; 'chaussures' (f. plural) needs 'noires'. Only one option agrees everywhere.$mq$, $mq$hard$mq$),
($mq$Sign: 'Magasin ouvert du lundi au samedi, de 9 h à 19 h. Fermé le dimanche.' It is Sunday at 10 a.m. What is true?$mq$, $mq$["The shop is open until 19 h.","The shop opens at 9 h only.","The shop is closed on Saturday.","The shop is closed."]$mq$, 3, $mq$'Fermé le dimanche' means closed on Sunday. It is open Monday to Saturday.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Shopping, Prices and Clothes$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$un pantalon / une jupe / une robe$mq$, $mq$trousers / a skirt / a dress$mq$),
($mq$des chaussures / des chaussettes$mq$, $mq$shoes / socks$mq$),
($mq$Quelle taille faites-vous ?$mq$, $mq$What size are you?$mq$),
($mq$Je peux l'essayer ?$mq$, $mq$Can I try it on?$mq$),
($mq$C'est trop cher.$mq$, $mq$It is too expensive.$mq$),
($mq$une jupe verte / des chaussures noires$mq$, $mq$a green skirt / black shoes (colours agree with the noun)$mq$),
($mq$les soldes$mq$, $mq$the sales (en solde = on sale)$mq$),
($mq$Moins 25 %$mq$, $mq$25 % off (a 40 € item costs 30 €)$mq$),
($mq$39,90 €$mq$, $mq$trente-neuf euros quatre-vingt-dix$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Shopping, Prices and Clothes$mq$ and p.name = $mq$Food and Shopping$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Shopping and clothes appear in many tasks, from reading a shop sign to listening to a dialogue in a clothes shop. You need clothing vocabulary, number skills for prices and the rules of adjective agreement.

## Clothes
- un pantalon (trousers), un jean (jeans), un short (shorts)
- une chemise (a shirt), un tee-shirt, un pull (a jumper), une veste (a jacket), un manteau (a coat)
- une robe (a dress), une jupe (a skirt)
- des chaussures (shoes), des chaussettes (socks), des baskets (trainers)
- un chapeau (a hat), une écharpe (a scarf), des gants (gloves)

## Colours
rouge (red), bleu (blue), vert (green), jaune (yellow), noir (black), blanc (white), gris (grey), rose (pink), marron (brown, never changes). Colours are adjectives, so they agree with the noun: "une jupe verte", "des chaussures noires", "un pull rouge". Add e for feminine and s for plural. Rouge, jaune and rose already end in e, so they only add s in the plural.

## Shopping language
- Je cherche... (I am looking for...)
- Vous avez ça en bleu ? (Do you have this in blue?)
- Quelle taille faites-vous ? (What size are you?)
- Je peux l'essayer ? (Can I try it on?)
- Ça me va bien. (It suits/fits me well.)
- C'est trop grand / petit / cher. (It is too big / small / expensive.)
- Je le prends. (I'll take it.)
- Je peux payer par carte ? (Can I pay by card?)
- les soldes (the sales), en solde (on sale), une réduction (a discount)

## Prices and numbers
Remember the numbers 20 to 100: vingt, trente, quarante, cinquante, soixante, soixante-dix (60+10), quatre-vingts (4×20), quatre-vingt-dix (4×20+10), cent. A price like 39,90 € is "trente-neuf euros quatre-vingt-dix". For a total, add carefully: 12,50 + 39,90 = 52,40.

## Percentages and reductions
"Moins 25 %" means 25 % off. Example: a 40 € jumper with 25 % off costs 40 − 10 = 30 €. To find 25 %, divide by four.

## Opening hours
Signs say "ouvert" (open) and "fermé" (closed), often with days: "du lundi au samedi" (Monday to Saturday), "tous les jours" (every day). Many French shops are closed on Sundays or Monday mornings.

## Common mistakes
- Forgetting agreement: "une jupe noir" should be "une jupe noire".
- Using the English word order. French puts colour after the noun: "un pull bleu".
- Saying "trop" when you mean "très". "Trop cher" is too expensive; "très cher" is very expensive.
- Confusing "une chemise" (shirt) with chemistry.

## How this is examined
Look for shop adverts, price tags, sales posters, and a short dialogue between a customer and an assistant. You might have to calculate a total, work out a discount, or decide which item matches a description (for example "une robe rouge à 30 euros"). In writing you may describe what you wear to school or at the weekend, or write a short shopping message.

Exam tip: Check three things for each item: the colour, the size and the price. Wrong answers often match two of these but fail on the third.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;