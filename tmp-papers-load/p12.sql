begin;
-- Spanish ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 68 marks) (68 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 68 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 68 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the voice message, then answer in English.

Mensaje de voz de Marta:
« Hola, Pablo, soy Marta. Te llamo porque mañana es el cumpleaños de mi abuela. Cumple setenta años. Vamos a comer en un restaurante italiano que se llama La Piazza, a las dos de la tarde. Somos doce personas: mis padres, mis tíos, mis primos y mis hermanos. Después de la comida, vamos a casa de mi abuela y comemos tarta. ¿Puedes comprar flores? Cuestan unos diez euros en la tienda de la esquina. ¡Gracias y hasta mañana! »

(a) Whose birthday is it tomorrow? (1 mark)
(b) How old is she going to be? (1 mark)
(c) What kind of restaurant are they going to? (1 mark)
(d) At what time is the meal? (1 mark)
(e) How many people will be at the meal? (1 mark)
(f) What will they do after the meal? Give two details. (2 marks)
(g) What is Pablo asked to buy? (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] Marta's grandmother's
(b) [1] 70 / seventy
(c) [1] Italian
(d) [1] 2 pm / 14:00
(e) [1] 12 / twelve
(f) [1] Go to the grandmother's house
[1] Eat cake
(g) [1] Flowers$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the conversation, then answer in English.

En un restaurante
Camarero: Buenas tardes. ¿Qué van a tomar?
Cliente: De primero, quiero una sopa de verduras. Mi hija quiere pescado con ensalada de segundo.
Camarero: Muy bien. ¿Y para beber?
Cliente: Agua para mí y un zumo de naranja para ella.
Camarero: De postre, tenemos helado de chocolate o fruta.
Cliente: Helado para los dos, por favor.
(Más tarde)
Cliente: La cuenta, por favor.
Camarero: Son veintiocho euros.
Cliente: ¿Puedo pagar con tarjeta?
Camarero: Lo siento, solo en efectivo.

(a) What does the customer order as a first course? (1 mark)
(b) What does the daughter order as her main course? Give two details. (2 marks)
(c) What do the customer and his or her daughter drink? (2 marks)
(d) What do they have for dessert? (1 mark)
(e) How much is the bill? (1 mark)
(f) Can the customer pay by card? (1 mark)

Total for Question 2: 8 marks$mq$, $mq$(a) [1] Vegetable soup
(b) [1] Fish
[1] Salad
(c) [1] Water (customer)
[1] Orange juice (daughter)
(d) [1] Chocolate ice cream
(e) [1] 28 euros
(f) [1] No, cash only$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 10]]
Reading. Read the text, then answer in English.

COLEGIO SAN MIGUEL - ACTIVIDADES DESPUÉS DE CLASE
El lunes hay teatro, de las cuatro a las cinco y media, en el aula cuatro. El martes hay fútbol en el polideportivo, de las cuatro a las cinco. El miércoles hay ajedrez en la biblioteca, y el jueves hay un taller de fotografía en el laboratorio de informática. Cada alumno puede elegir un máximo de dos actividades. Cada actividad cuesta quince euros al mes. Para apuntarse, hay que hablar con la señora Ruiz, en la secretaría, antes del treinta de septiembre.

(a) At what time does the theatre activity start and finish? (2 marks)
(b) Where does the football take place? (1 mark)
(c) Which activity is on Wednesday? (1 mark)
(d) Where is the photography workshop? (1 mark)
(e) What is the maximum number of activities a student can choose? (1 mark)
(f) How much does one activity cost? (1 mark)
(g) How much would a student pay each month for two activities? (1 mark)
(h) Who should students speak to in order to sign up? (1 mark)
(i) What is the deadline for signing up? (1 mark)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] Starts at 4 pm / 16:00
[1] Finishes at 5.30 pm / 17:30
(b) [1] In the sports hall / sports centre
(c) [1] Chess
(d) [1] In the computer lab / IT room
(e) [1] Two
(f) [1] 15 euros a month
(g) [1] 30 euros
(h) [1] Mrs Ruiz / Señora Ruiz
(i) [1] 30 September$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 12]]
Reading. Read the text, then answer in English.

Hola, Ben:
Me preguntas cómo es mi pueblo. Vivo en Villaverde, un pueblo pequeño en el norte de España, cerca de las montañas. Hay unos tres mil habitantes. En el centro hay una plaza grande con una iglesia antigua, un mercado y muchos bares. No hay cine ni piscina, pero hay un parque muy bonito con un lago. En invierno nieva y mucha gente viene a esquiar. En verano hace buen tiempo y hacemos excursiones por la montaña. Mi casa está lejos del instituto, a cinco kilómetros, y voy en autobús. Los sábados juego al baloncesto con mis amigos en el parque. El año pasado visitaste España con tu familia; este verano puedes visitar mi pueblo. ¡Te va a gustar!
Un abrazo, Javier

(a) Where is Villaverde? Give two details. (2 marks)
(b) How many people live in Villaverde? (1 mark)
(c) Name two things in the centre of the village. (2 marks)
(d) Name two things the village does not have. (2 marks)
(e) What happens in winter? Give two details. (2 marks)
(f) How does Javier travel to school? (1 mark)
(g) How far is his house from the school? (1 mark)
(h) What does Javier do on Saturdays? (1 mark)

Total for Question 4: 12 marks$mq$, $mq$(a) [1] In the north of Spain
[1] Near the mountains
(b) [1] About 3000 / three thousand
(c) [1] Any one of: large square / old church / market / bars
[1] A different one of these
(d) [1] Cinema
[1] Swimming pool
(e) [1] It snows
[1] Many people come to ski
(f) [1] By bus
(g) [1] 5 km / five kilometres
(h) [1] Plays basketball (with friends in the park)$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | D 8]]
Language in context. Answer all parts. Parts (a) to (d) are verb forms, (e) and (f) are choices, (g) and (h) are translations into Spanish.

(a) Complete with the correct form of the verb in brackets: Mi hermano ______ (tener) quince años. (1 mark)
(b) Complete with the correct form of the verb in brackets: Nosotros ______ (vivir) en un piso pequeño. (1 mark)
(c) Complete with the correct form of the verb in brackets: ¿______ (tú, hablar) inglés? (1 mark)
(d) Complete with the correct form of the verb in brackets: Mis padres ______ (trabajar) en un banco. (1 mark)
(e) Choose the correct verb, es or está: Mi casa ______ cerca del parque. (1 mark)
(f) Choose the correct verb, es or está: Ana ______ muy simpática. (1 mark)
(g) Translate into Spanish: I like playing tennis. (1 mark)
(h) Translate into Spanish: Tomorrow we are going to eat paella. (1 mark)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] tiene
(b) [1] vivimos
(c) [1] Hablas
(d) [1] trabajan
(e) [1] está
(f) [1] es
(g) [1] Me gusta jugar al tenis.
(h) [1] Mañana vamos a comer paella. (accept: Vamos a comer paella mañana.)$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | D 10]]
Writing. You are joining a school exchange website for students who want to learn Spanish. Write a message to introduce yourself. Include: your name and age; where you live; one family member; two hobbies; a question for your new friend.

Write 60 to 70 words in Spanish. (10 marks)

Total for Question 6: 10 marks$mq$, $mq$Content (1 mark each)
[1] Gives name and age (e.g. Me llamo Sam y tengo quince años)
[1] Says where they live
[1] Describes at least one family member
[1] Mentions a first hobby (e.g. Me gusta jugar al fútbol)
[1] Mentions a second hobby
[1] Asks a question to the friend (e.g. ¿Y tú, qué haces en tu tiempo libre?)
Language
[3] Vocabulary and grammar: 3 = mostly accurate with some variety of structures; 2 = generally accurate, simple structures; 1 = frequent errors, message still understood; 0 = not understandable
Organisation
[1] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 40 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | D 12]]
Writing. Your school magazine has a competition called « Cuidemos el planeta ». Write an article. Include: one environmental problem; two things you do at home to protect the planet; one thing you did recently to help; one thing you are going to do next week; why you think it is important.

Write 80 to 90 words in Spanish. (12 marks)

Total for Question 7: 12 marks$mq$, $mq$Content (1 mark each)
[1] Names a problem (e.g. la contaminación, la basura, el plástico)
[1] Gives a first action at home (e.g. Reciclo el papel)
[1] Gives a second action at home (e.g. Apago la luz)
[1] Says what they did recently (past tense or a clear attempt, e.g. Ayer recogí basura en el parque)
[1] Says what they will do next week (e.g. Voy a ir al colegio en bicicleta)
[1] Gives a reason or opinion (e.g. Es importante porque el planeta es nuestra casa)
Language
[4] Vocabulary and grammar: 4 = mostly accurate with some variety of structures; 3 = generally accurate, simple structures; 2 = frequent errors, message still understood; 1 = very limited; 0 = not understandable
Organisation
[2] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 50 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Spanish ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 67 marks) (67 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 67 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 67 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the radio advertisement, then answer in English.

Anuncio de radio:
« ¿Necesitas un ordenador nuevo? ¡Ven a Tecno-Mundo! Estamos en la calle Mayor, número veinte, al lado del banco. Abrimos de lunes a sábado, de diez de la mañana a ocho de la tarde. Esta semana, los ordenadores portátiles cuestan solo cuatrocientos euros. Los móviles tienen un descuento del veinte por ciento. Si compras un móvil, la funda es gratis. Además, hay clases de informática para jóvenes los sábados por la mañana. ¡Visita también nuestra página web! »

(a) Where is the shop? Give two details. (2 marks)
(b) On which days is the shop open? (1 mark)
(c) What are the opening hours? (2 marks)
(d) How much are the laptops this week? (1 mark)
(e) What discount is there on mobile phones? (1 mark)
(f) What is free if you buy a mobile phone? (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] Calle Mayor, number 20
[1] Next to the bank
(b) [1] Monday to Saturday
(c) [1] From 10 am / 10:00
[1] To 8 pm / 20:00
(d) [1] 400 euros
(e) [1] 20% / twenty per cent
(f) [1] A (phone) case$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the conversation, then answer in English.

Dos amigos hablan del verano
Lucía: Hola, Carlos. ¿Qué haces este verano?
Carlos: Voy a trabajar en la heladería de mi tío, en la playa.
Lucía: ¿Cuántas horas trabajas?
Carlos: Seis horas al día, de las once a las cinco.
Lucía: ¿Y cuánto ganas?
Carlos: Ocho euros la hora.
Lucía: ¡Qué bien! ¿Te gusta el trabajo?
Carlos: Sí, me gusta porque hablo con mucha gente, pero hace mucho calor.
Lucía: Yo voy a estudiar inglés en Dublín durante dos semanas.
Carlos: ¡Qué suerte! ¿Cuándo sales?
Lucía: El quince de julio.

(a) Where is Carlos going to work? (1 mark)
(b) At what time does he start and finish work? (2 marks)
(c) How much does Carlos earn per hour? (1 mark)
(d) What does Carlos like about the job? (1 mark)
(e) What is the problem with the job? (1 mark)
(f) What is Lucía going to do? (1 mark)
(g) When does she leave? (1 mark)

Total for Question 2: 8 marks$mq$, $mq$(a) [1] In his uncle's ice-cream shop (on the beach)
(b) [1] Starts at 11 am / 11:00
[1] Finishes at 5 pm / 17:00
(c) [1] 8 euros
(d) [1] He talks to lots of people
(e) [1] It is very hot
(f) [1] Study English (in Dublin)
(g) [1] 15 July$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 9]]
Reading. Read the text, then answer in English.

Mi vida con el móvil
Me llamo Daniel y tengo catorce años. Tengo un móvil desde los doce años. Lo uso para hablar con mis amigos, escuchar música y ver vídeos. Por la noche, no uso el móvil después de las diez, porque necesito dormir ocho horas. Mis padres dicen que paso demasiado tiempo con la pantalla, pero yo creo que el móvil es útil para hacer los deberes. Mi aplicación favorita es un diccionario de inglés. El fin de semana prefiero salir con mis amigos y jugar al fútbol.

(a) How old is Daniel? (1 mark)
(b) How old was he when he got his phone? (1 mark)
(c) What does Daniel use his phone for? Give three details. (3 marks)
(d) What is his rule about the phone at night? (1 mark)
(e) Why does he have this rule? (1 mark)
(f) What do his parents say? (1 mark)
(g) Why does Daniel think the phone is useful? (1 mark)

Total for Question 3: 9 marks$mq$, $mq$(a) [1] 14 / fourteen
(b) [1] 12 / twelve
(c) [1] Talking to friends
[1] Listening to music
[1] Watching videos
(d) [1] No phone after 10 pm / 22:00
(e) [1] He needs eight hours of sleep
(f) [1] He spends too much time on the screen
(g) [1] For doing homework$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 12]]
Reading. Read the text, then answer in English.

Querida Sofía:
¡Saludos desde la costa! Estoy de vacaciones con mi familia en un hotel pequeño, cerca de la playa. Llegamos el sábado por la noche en tren; el viaje duró cinco horas. La habitación es grande y tiene vista al mar. Cada mañana desayunamos en la terraza: tostadas con tomate y zumo de naranja. Ayer visitamos un acuario y vimos tortugas y tiburones. Mi hermano pequeño se bañó en el mar, pero el agua estaba muy fría. Hoy llueve, así que vamos a ir al museo. Mañana vamos a alquilar bicicletas y vamos a ir a un pueblo cercano. Volvemos a casa el domingo. ¡Hasta pronto!
Un abrazo, Irene

(a) Who is Irene on holiday with? (1 mark)
(b) Where are they staying? (1 mark)
(c) How did they travel? (1 mark)
(d) How long did the journey take? (1 mark)
(e) What do they have for breakfast? Give two details. (2 marks)
(f) Where did they go yesterday? (1 mark)
(g) Which two animals did they see? (2 marks)
(h) What was the problem when her brother swam in the sea? (1 mark)
(i) What is the weather like today? (1 mark)
(j) What are they going to do today because of the weather? (1 mark)

Total for Question 4: 12 marks$mq$, $mq$(a) [1] Her family
(b) [1] In a small hotel near the beach
(c) [1] By train
(d) [1] Five hours
(e) [1] Toast with tomato
[1] Orange juice
(f) [1] To an aquarium
(g) [1] Turtles
[1] Sharks
(h) [1] The water was very cold
(i) [1] It is raining
(j) [1] Go to the museum$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | D 8]]
Language in context. Answer all parts. Parts (a) to (d) use the words in the box: es · está · hay · tiene. Parts (e) and (f) are adjective agreements. Parts (g) and (h) are translations into Spanish.

(a) Complete with a word from the box: Mi tía ______ cuarenta años. (1 mark)
(b) Complete with a word from the box: En mi ciudad ______ un museo muy grande. (1 mark)
(c) Complete with a word from the box: Mi padre ______ ingeniero. (1 mark)
(d) Complete with a word from the box: El banco ______ al lado de la farmacia. (1 mark)
(e) Write the adjective in the correct form: Las casas son ______ (blanco). (1 mark)
(f) Write the adjective in the correct form: Mi hermana es muy ______ (alto). (1 mark)
(g) Translate into Spanish: I have a brother and two sisters. (1 mark)
(h) Translate into Spanish: She does not eat meat. (1 mark)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] tiene
(b) [1] hay
(c) [1] es
(d) [1] está
(e) [1] blancas
(f) [1] alta
(g) [1] Tengo un hermano y dos hermanas.
(h) [1] No come carne. (accept: Ella no come carne.)$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | D 10]]
Writing. Your Spanish friend asks about your school. Write a message to answer. Include: the name of your school and where it is; your favourite subject and why; what time lessons start; what you eat at lunchtime; a question about your friend's school.

Write 60 to 70 words in Spanish. (10 marks)

Total for Question 6: 10 marks$mq$, $mq$Content (1 mark each)
[1] Gives the name or the location of the school
[1] Says their favourite subject (e.g. Mi asignatura favorita es el inglés)
[1] Gives a reason (e.g. porque el profesor es simpático)
[1] Says what time lessons start (e.g. Las clases empiezan a las ocho)
[1] Says what they eat at lunchtime
[1] Asks a question about the friend's school (e.g. ¿Cómo es tu colegio?)
Language
[3] Vocabulary and grammar: 3 = mostly accurate with some variety of structures; 2 = generally accurate, simple structures; 1 = frequent errors, message still understood; 0 = not understandable
Organisation
[1] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 40 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | D 12]]
Writing. A Spanish-speaking visitor is coming to your town or city. Write a short guide for them. Include: where your town or city is; two places to visit; the weather in summer; what the visitor can eat; one thing you are going to do together at the weekend.

Write 80 to 90 words in Spanish. (12 marks)

Total for Question 7: 12 marks$mq$, $mq$Content (1 mark each)
[1] Says where the town or city is
[1] Gives a first place to visit (e.g. Hay un castillo muy antiguo)
[1] Gives a second place to visit
[1] Describes the weather in summer (e.g. En verano hace calor)
[1] Says what the visitor can eat or drink (e.g. Puedes comer pescado con patatas)
[1] Says what they will do together at the weekend (e.g. El sábado vamos a ir al parque)
Language
[4] Vocabulary and grammar: 4 = mostly accurate with some variety of structures; 3 = generally accurate, simple structures; 2 = frequent errors, message still understood; 1 = very limited; 0 = not understandable
Organisation
[2] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 50 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Mandarin ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 70 marks) (70 marks)
with sub as (select id from public.subjects where slug = $mq$mandarin-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Mandarin ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 70 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Mandarin ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 70 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: Listening. Two friends talk about a birthday.

[Audio transcript - read twice]
丽丽：大卫，你的生日是几月几号？
大卫：我的生日是十月二十号。
丽丽：这个星期六是我的生日。
大卫：真的吗？生日快乐！你想做什么？
丽丽：我想请朋友来我家吃蛋糕。你来吗？
大卫：好啊。我送你一本书，好不好？
丽丽：太好了！我喜欢看书。
大卫：几点来？
丽丽：下午四点。我家在学校旁边，是红色的房子。
(Lìli: Dàwèi, nǐ de shēngrì shì jǐ yuè jǐ hào? Dàwèi: Wǒ de shēngrì shì shí yuè èrshí hào. Lìli: Zhège xīngqīliù shì wǒ de shēngrì. Dàwèi: Zhēn de ma? Shēngrì kuàilè! Nǐ xiǎng zuò shénme? Lìli: Wǒ xiǎng qǐng péngyou lái wǒ jiā chī dàngāo. Nǐ lái ma? Dàwèi: Hǎo a. Wǒ sòng nǐ yì běn shū, hǎo bu hǎo? Lìli: Tài hǎo le! Wǒ xǐhuan kàn shū. Dàwèi: Jǐ diǎn lái? Lìli: Xiàwǔ sì diǎn. Wǒ jiā zài xuéxiào pángbiān, shì hóngsè de fángzi.)

(a) When is David's birthday? (1 mark)
(b) What does Lili want to do for her birthday? (2 marks)
(c) What present will David give her? (1 mark)
(d) Why does Lili like this present? (1 mark)
(e) At what time should David arrive? (1 mark)
(f) Give two details that will help David find Lili's home. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] 20 October (the 20th of October)
(b) [1] Invite friends to her home
[1] Eat cake
(c) [1] A book
(d) [1] She likes reading (books)
(e) [1] 4 pm (four o'clock in the afternoon)
(f) [1] It is next to the school
[1] It is a red house
Do not award a mark for the date of Lili's birthday (Saturday) in (a).$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 12]]
Task 2: Listening. A teacher leaves a voice message about a school trip.

[Audio transcript - read twice]
各位同学：你们好！我是王老师。下个星期三我们去科技馆。我们早上七点四十五分在学校门口见面，坐大巴去。科技馆在城市的东边，坐车要四十分钟。门票每人三十五块，请星期一以前给我钱。带午饭和水，不要带手机，因为科技馆里不能用手机。我们下午四点回学校。如果你有问题，请到二楼二零五办公室找我。谢谢！
(Gèwèi tóngxué: nǐmen hǎo! Wǒ shì Wáng lǎoshī. Xià ge xīngqīsān wǒmen qù kējìguǎn. Wǒmen zǎoshang qī diǎn sìshíwǔ fēn zài xuéxiào ménkǒu jiànmiàn, zuò dàbā qù. Kējìguǎn zài chéngshì de dōngbian, zuò chē yào sìshí fēnzhōng. Ménpiào měi rén sānshíwǔ kuài, qǐng xīngqīyī yǐqián gěi wǒ qián. Dài wǔfàn hé shuǐ, bú yào dài shǒujī, yīnwèi kējìguǎn lǐ bù néng yòng shǒujī. Wǒmen xiàwǔ sì diǎn huí xuéxiào. Rúguǒ nǐ yǒu wèntí, qǐng dào èr lóu èr líng wǔ bàngōngshì zhǎo wǒ. Xièxie!)

(a) Where is the class going? (1 mark)
(b) On which day of the week is the trip? (1 mark)
(c) Where and when do the students meet? (2 marks)
(d) How will they travel there? (1 mark)
(e) How much is the ticket for one student? (1 mark)
(f) By when must students give the teacher the money? (1 mark)
(g) Name two things students must bring. (2 marks)
(h) What must students not bring, and why? (2 marks)
(i) At what time do they return to school? (1 mark)

Total for Question 2: 12 marks$mq$, $mq$(a) [1] The science (and technology) museum
(b) [1] Wednesday
(c) [1] At the school gate (entrance)
[1] At 7:45 am (a quarter to eight in the morning)
(d) [1] By coach (bus)
(e) [1] 35 yuan
(f) [1] Before Monday (by Monday)
(g) [1] Lunch
[1] Water
(h) [1] Mobile phones
[1] Phones cannot be used inside the museum
(i) [1] 4 pm (four o'clock in the afternoon)
Do not award marks for the journey time (40 minutes) or the office number (205), which are not asked for.$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 8]]
Task 3: Reading. Read this notice in a school library.

图书馆通知
开放时间：星期一到星期五，早上八点到下午五点；星期六，早上九点到十二点；星期日不开。
一次可以借五本书，借书时间是两个星期。
在图书馆里不可以吃东西，也不可以大声说话。手机请关机。
(Túshūguǎn tōngzhī. Kāifàng shíjiān: xīngqīyī dào xīngqīwǔ, zǎoshang bā diǎn dào xiàwǔ wǔ diǎn; xīngqīliù, zǎoshang jiǔ diǎn dào shí'èr diǎn; xīngqīrì bù kāi. Yí cì kěyǐ jiè wǔ běn shū, jiè shū shíjiān shì liǎng ge xīngqī. Zài túshūguǎn lǐ bù kěyǐ chī dōngxi, yě bù kěyǐ dàshēng shuōhuà. Shǒujī qǐng guānjī.)

(a) At what time does the library close on Friday? (1 mark)
(b) What are the opening times on Saturday? (2 marks)
(c) On which day is the library closed? (1 mark)
(d) How many books can a student borrow, and for how long? (2 marks)
(e) Give two rules for behaviour in the library. (2 marks)

Total for Question 3: 8 marks$mq$, $mq$(a) [1] 5 pm (five o'clock in the afternoon)
(b) [1] Opens at 9 am
[1] Closes at 12 (noon)
(c) [1] Sunday
(d) [1] 5 books
[1] Two weeks
(e) [1] Any one rule: no eating / no loud talking / phones switched off
[1] A second, different rule from the same list$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 12]]
Task 4: Reading. Zhang Wen writes in a class blog.

我叫张文，今年十五岁。上个月是我的生日，爸爸送给我一部新手机。我很喜欢它，因为它很轻，照片拍得很好。我每天放学以后用手机听音乐，也跟朋友聊天。可是妈妈说我玩手机的时间太长了。她说晚上九点以后不可以用手机。我有点儿不高兴，不过妈妈是对的，因为我常常睡得很晚，早上很累。现在我每天最多看两个小时手机。周末我想和朋友一起去公园，不带手机。
(Wǒ jiào Zhāng Wén, jīnnián shíwǔ suì. Shàng ge yuè shì wǒ de shēngrì, bàba sòng gěi wǒ yí bù xīn shǒujī. Wǒ hěn xǐhuan tā, yīnwèi tā hěn qīng, zhàopiàn pāi de hěn hǎo. Wǒ měi tiān fàngxué yǐhòu yòng shǒujī tīng yīnyuè, yě gēn péngyou liáotiān. Kěshì māma shuō wǒ wán shǒujī de shíjiān tài cháng le. Tā shuō wǎnshang jiǔ diǎn yǐhòu bù kěyǐ yòng shǒujī. Wǒ yǒudiǎnr bù gāoxìng, bùguò māma shì duì de, yīnwèi wǒ chángcháng shuì de hěn wǎn, zǎoshang hěn lèi. Xiànzài wǒ měi tiān zuì duō kàn liǎng ge xiǎoshí shǒujī. Zhōumò wǒ xiǎng hé péngyou yìqǐ qù gōngyuán, bú dài shǒujī.)

(a) How old is Zhang Wen? (1 mark)
(b) Who gave him the phone, and for what occasion? (2 marks)
(c) Give two reasons why he likes the phone. (2 marks)
(d) What two things does he do on the phone after school? (2 marks)
(e) What does his mother say about the time he spends on the phone? (1 mark)
(f) After what time is he not allowed to use the phone? (1 mark)
(g) Why does Zhang Wen think his mother is right? Give two details. (2 marks)
(h) What does he plan to do at the weekend? (1 mark)

Total for Question 4: 12 marks$mq$, $mq$(a) [1] 15 (fifteen)
(b) [1] His father (dad)
[1] His birthday (a birthday present)
(c) [1] It is light
[1] It takes good photos (the photos are good)
(d) [1] Listens to music
[1] Chats with friends
(e) [1] He plays on it for too long (too much time)
(f) [1] 9 pm (nine o'clock in the evening)
(g) [1] He often goes to sleep late
[1] He is tired in the morning
(h) [1] Go to the park with friends (and not take the phone)$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | B 10]]
Task 5: Vocabulary and grammar in context.

(a) Complete each sentence with a word from the box. Use each word once. (5 marks)
Box: 在 (zài)   和 (hé)   吗 (ma)   都 (dōu)   的 (de)
1 你喜欢吃中国菜___？(Nǐ xǐhuan chī Zhōngguó cài ___?)
2 我家___北京。(Wǒ jiā ___ Běijīng.)
3 我爸爸___妈妈都是老师。(Wǒ bàba ___ māma dōu shì lǎoshī.)
4 这是我___书包。(Zhè shì wǒ ___ shūbāo.)
5 我们___喜欢游泳。(Wǒmen ___ xǐhuan yóuyǒng.)

(b) Put the words in the correct order to make a sentence. Write the sentence in characters. (2 marks)
1 去 / 我 / 学校 / 明天 / 想 (qù / wǒ / xuéxiào / míngtiān / xiǎng)
2 两 / 有 / 哥哥 / 我 / 个 (liǎng / yǒu / gēge / wǒ / gè)

(c) Write the English meaning of each word. (3 marks)
1 医院 (yīyuàn)   2 便宜 (piányi)   3 同学 (tóngxué)

Total for Question 5: 10 marks$mq$, $mq$(a) [1] 1 吗 (ma)
[1] 2 在 (zài)
[1] 3 和 (hé)
[1] 4 的 (de)
[1] 5 都 (dōu)
(b) [1] 1 我明天想去学校。or 明天我想去学校。(Accept either position of the time word before the verb phrase.)
[1] 2 我有两个哥哥。
(c) [1] 1 Hospital
[1] 2 Cheap (inexpensive)
[1] 3 Classmate (fellow student)$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | D 6]]
Task 6: Writing a short message.

You cannot go to your friend Xiao Yu's party on Saturday. Write a message to Xiao Yu of about 20 to 30 characters. Include:
- say sorry
- one reason why you cannot come
- suggest another day to meet

You may write in characters, or in characters with pinyin if you wish. (6 marks)

Total for Question 6: 6 marks$mq$, $mq$Content (4 marks): one mark for each point, communicated clearly and correctly.
[1] Says sorry (for example 对不起)
[1] Gives a reason (for example 我星期六要看奶奶 or 我要做作业)
[1] Suggests another day (for example 星期日我们一起去看电影，好吗？)
[1] Greets or names Xiao Yu, or says the party is on Saturday, in a clear way
Language (2 marks):
[1] Uses a correct sentence pattern (for example 我要……, 我不能……, 我们……好吗？)
[1] Characters or pinyin are mostly accurate, and word order is mostly correct$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | D 14]]
Task 7: Writing. Your Chinese pen friend, Xiao Hua, wants to know about the area where you live. Write an email of about 60 to 80 characters. Include:
- where you live (the town or city) and one thing about it
- two places near your home
- how you go to the town centre and how long it takes
- what you like to do there at the weekend
- one thing you do not like about your area
- an invitation to Xiao Hua to visit next month (use 想 or 可以)

You may write in characters, or in characters with pinyin if you wish. (14 marks)

Total for Question 7: 14 marks$mq$, $mq$Content (6 marks): one mark for each point, communicated clearly and correctly.
[1] Where the writer lives, with one detail (for example 我住在伦敦，伦敦很大)
[1] Names two places near home (for example 我家旁边有一个公园和一家商店)
[1] How the writer travels to the town centre (for example 我坐公共汽车去市中心)
[1] How long it takes (for example 要二十分钟)
[1] A weekend activity in the town centre (for example 周末我喜欢去那里买东西)
[1] One dislike about the area (for example 我不喜欢这里的天气 or 这里的车太多)
Language (6 marks):
[1] Uses 有 or 在 correctly to say where things are
[1] Uses 很 with an adjective, or 是, correctly
[1] Uses 喜欢 or 不喜欢 with a verb correctly
[1] Uses a time expression or 要 for duration in a correct position
[1] Uses 想 or 可以 before a verb in the invitation
[1] Most characters or pinyin are accurate and the message is easy to understand
Communication (2 marks):
[1] Appropriate greeting and closing, with a friendly and suitable register
[1] Sensible length and logical order, with at least one linking word such as 和, 也, 因为 or 可是$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Mandarin ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 70 marks) (70 marks)
with sub as (select id from public.subjects where slug = $mq$mandarin-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Mandarin ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 70 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Mandarin ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 70 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 10]]
Task 1: Listening. Xiao Ming buys train tickets.

[Audio transcript - read twice]
售票员：你好，请问你要去哪儿？
小明：我要去杭州。请问多少钱？
售票员：二等座一百二十块。你买几张？
小明：买两张。我和妹妹一起去。
售票员：你们什么时候走？
小明：下个星期六上午。
售票员：有九点十五分和十点半的火车。
小明：九点十五分太早了。我要十点半的。
售票员：好的，一共二百四十块。火车在三号站台上车。
小明：谢谢！
(Shòupiàoyuán: Nǐ hǎo, qǐngwèn nǐ yào qù nǎr? Xiǎo Míng: Wǒ yào qù Hángzhōu. Qǐngwèn duōshao qián? Shòupiàoyuán: Èrděngzuò yì bǎi èrshí kuài. Nǐ mǎi jǐ zhāng? Xiǎo Míng: Mǎi liǎng zhāng. Wǒ hé mèimei yìqǐ qù. Shòupiàoyuán: Nǐmen shénme shíhou zǒu? Xiǎo Míng: Xià ge xīngqīliù shàngwǔ. Shòupiàoyuán: Yǒu jiǔ diǎn shíwǔ fēn hé shí diǎn bàn de huǒchē. Xiǎo Míng: Jiǔ diǎn shíwǔ fēn tài zǎo le. Wǒ yào shí diǎn bàn de. Shòupiàoyuán: Hǎo de, yígòng èr bǎi sìshí kuài. Huǒchē zài sān hào zhàntái shàng chē. Xiǎo Míng: Xièxie!)

(a) Where is Xiao Ming going? (1 mark)
(b) How much is one ticket? (1 mark)
(c) How many tickets does he buy, and who is going with him? (2 marks)
(d) On which day, and at what part of the day, does he want to travel? (2 marks)
(e) Which train does he choose, and why does he not choose the earlier one? (2 marks)
(f) Show that the total price of 240 yuan is correct. (1 mark)
(g) Which platform does the train leave from? (1 mark)

Total for Question 1: 10 marks$mq$, $mq$(a) [1] Hangzhou
(b) [1] 120 yuan
(c) [1] Two tickets
[1] With his (younger) sister
(d) [1] Next Saturday
[1] In the morning
(e) [1] The 10:30 train (half past ten)
[1] The 9:15 train is too early
(f) [1] 2 × 120 = 240 (two tickets at 120 yuan each)
(g) [1] Platform 3 (number three platform)$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 10]]
Task 2: Listening. A radio presenter gives the weather forecast and a local announcement.

[Audio transcript - read twice]
各位听众，大家好！这是今天的天气预报。今天北京天气很好，是晴天，最高气温二十八度，最低气温十九度。明天有雨，最高气温比今天低五度。后天天气会好一点儿，但是有风。现在是夏天，天气很热，要多喝水。另外，这个周末我们城市有环保活动，上午九点在中心公园，大家一起捡垃圾。参加的人可以得到一个免费的环保袋。
(Gèwèi tīngzhòng, dàjiā hǎo! Zhè shì jīntiān de tiānqì yùbào. Jīntiān Běijīng tiānqì hěn hǎo, shì qíngtiān, zuì gāo qìwēn èrshíbā dù, zuì dī qìwēn shíjiǔ dù. Míngtiān yǒu yǔ, zuì gāo qìwēn bǐ jīntiān dī wǔ dù. Hòutiān tiānqì huì hǎo yìdiǎnr, dànshì yǒu fēng. Xiànzài shì xiàtiān, tiānqì hěn rè, yào duō hē shuǐ. Lìngwài, zhège zhōumò wǒmen chéngshì yǒu huánbǎo huódòng, shàngwǔ jiǔ diǎn zài Zhōngxīn Gōngyuán, dàjiā yìqǐ jiǎn lājī. Cānjiā de rén kěyǐ dédào yí ge miǎnfèi de huánbǎo dài.)

(a) What is the weather like today? (1 mark)
(b) What are today's highest and lowest temperatures? (2 marks)
(c) What will the weather be like tomorrow? (1 mark)
(d) Calculate tomorrow's highest temperature. Show your working. (2 marks)
(e) What will be different about the weather the day after tomorrow? (1 mark)
(f) What advice does the presenter give about the hot weather? (1 mark)
(g) When and where is the environmental activity? (2 marks)

Total for Question 2: 10 marks$mq$, $mq$(a) [1] Sunny (fine, good weather)
(b) [1] Highest 28 degrees
[1] Lowest 19 degrees
(c) [1] Rain (rainy)
(d) [1] 28 - 5 (five degrees lower than today)
[1] 23 degrees
(e) [1] It will be windy (accept: a little better but windy)
(f) [1] Drink more water
(g) [1] 9 am at the weekend (accept: 9 in the morning)
[1] (In) Central Park
Do not award a mark for the free bag, which is not asked for.$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 10]]
Task 3: Reading. Read this poster in a shop window.

书店需要小帮手
我们的书店在学校对面。周末需要两个学生来帮忙。
工作时间：星期六和星期日，上午十点到下午四点。
工作：整理书，帮客人找书。
工资：每小时二十五块。
条件：十五岁以上，爱看书，喜欢跟人说话。会说一点儿英语更好。
有兴趣的同学，请星期五以前来书店找李老板。
(Shūdiàn xūyào xiǎo bāngshǒu. Wǒmen de shūdiàn zài xuéxiào duìmiàn. Zhōumò xūyào liǎng ge xuésheng lái bāngmáng. Gōngzuò shíjiān: xīngqīliù hé xīngqīrì, shàngwǔ shí diǎn dào xiàwǔ sì diǎn. Gōngzuò: zhěnglǐ shū, bāng kèrén zhǎo shū. Gōngzī: měi xiǎoshí èrshíwǔ kuài. Tiáojiàn: shíwǔ suì yǐshàng, ài kàn shū, xǐhuan gēn rén shuōhuà. Huì shuō yìdiǎnr Yīngyǔ gèng hǎo. Yǒu xìngqù de tóngxué, qǐng xīngqīwǔ yǐqián lái shūdiàn zhǎo Lǐ lǎobǎn.)

(a) Where is the bookshop? (1 mark)
(b) On which days and at what times is the work? (2 marks)
(c) What two jobs will the helpers do? (2 marks)
(d) How much is the pay for one hour? (1 mark)
(e) A student works from 10 am to 4 pm on Saturday. Calculate how much the student earns for that day. Show your working. (2 marks)
(f) Give one requirement for the job. (1 mark)
(g) By when should interested students go to the shop? (1 mark)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] Opposite the school
(b) [1] Saturday and Sunday
[1] 10 am to 4 pm
(c) [1] Tidy (arrange) the books
[1] Help customers find books
(d) [1] 25 yuan
(e) [1] 10 am to 4 pm is 6 hours
[1] 6 × 25 = 150 yuan
(f) [1] Any one: over 15 years old / loves reading / likes talking to people (speaking some English is better but is not required)
(g) [1] Before Friday (by Friday)$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 12]]
Task 4: Reading. Read this letter from a pen friend.

亲爱的朋友：
你好！我叫林美玲，今年十四岁，住在广州。我家有六口人：爷爷、奶奶、爸爸、妈妈、弟弟和我。爷爷奶奶退休了，每天早上去公园打太极拳。爸爸是司机，妈妈是护士，在医院工作。我弟弟九岁，他很可爱，可是很吵。
我每天六点半起床，七点吃早饭，然后坐地铁去学校，要二十五分钟。我们八点上课，下午三点半放学。放学以后我常常去游泳馆游泳，因为我想参加比赛。晚上我先做作业，然后看一个小时电视，十点睡觉。
你家有几口人？你每天做什么？请告诉我！
你的朋友
美玲
(Qīn'ài de péngyou: Nǐ hǎo! Wǒ jiào Lín Měilíng, jīnnián shísì suì, zhù zài Guǎngzhōu. Wǒ jiā yǒu liù kǒu rén: yéye, nǎinai, bàba, māma, dìdi hé wǒ. Yéye nǎinai tuìxiū le, měi tiān zǎoshang qù gōngyuán dǎ tàijíquán. Bàba shì sījī, māma shì hùshi, zài yīyuàn gōngzuò. Wǒ dìdi jiǔ suì, tā hěn kě'ài, kěshì hěn chǎo. Wǒ měi tiān liù diǎn bàn qǐchuáng, qī diǎn chī zǎofàn, ránhòu zuò dìtiě qù xuéxiào, yào èrshíwǔ fēnzhōng. Wǒmen bā diǎn shàng kè, xiàwǔ sān diǎn bàn fàngxué. Fàngxué yǐhòu wǒ chángcháng qù yóuyǒngguǎn yóuyǒng, yīnwèi wǒ xiǎng cānjiā bǐsài. Wǎnshang wǒ xiān zuò zuòyè, ránhòu kàn yí ge xiǎoshí diànshì, shí diǎn shuìjiào. Nǐ jiā yǒu jǐ kǒu rén? Nǐ měi tiān zuò shénme? Qǐng gàosu wǒ! Nǐ de péngyou, Měilíng)

(a) In which city does Meiling live? (1 mark)
(b) How many people are in her family? (1 mark)
(c) What do her grandparents do every morning? (1 mark)
(d) What are her parents' jobs? (2 marks)
(e) Give two details about her younger brother. (2 marks)
(f) How does Meiling travel to school, and how long does it take? (2 marks)
(g) At what time do lessons start and finish? (2 marks)
(h) Why does she go swimming after school? (1 mark)

Total for Question 4: 12 marks$mq$, $mq$(a) [1] Guangzhou
(b) [1] 6 (six)
(c) [1] They go to the park (and do tai chi)
(d) [1] Father is a driver
[1] Mother is a nurse
(e) [1] He is 9 years old
[1] He is cute (lovable) / he is noisy (Accept either description.)
(f) [1] By metro (underground)
[1] 25 minutes
(g) [1] Start at 8 o'clock (8 am)
[1] Finish at 3:30 pm (half past three)
(h) [1] She wants to take part in a competition$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | B 8]]
Task 5: Vocabulary and grammar in context.

(a) Choose the correct word to complete each sentence. Write only the letter. (4 marks)
1 她___三个姐姐。(Tā ___ sān ge jiějie.)   A 有 (yǒu)   B 在 (zài)   C 很 (hěn)
2 这件衣服___那件便宜。(Zhè jiàn yīfu ___ nà jiàn piányi.)   A 和 (hé)   B 比 (bǐ)   C 都 (dōu)
3 他___医院工作。(Tā ___ yīyuàn gōngzuò.)   A 在 (zài)   B 有 (yǒu)   C 吗 (ma)
4 你想喝___？(Nǐ xiǎng hē ___?)   A 谁 (shéi)   B 哪儿 (nǎr)   C 什么 (shénme)

(b) Translate into Chinese: "I like drinking tea." Write in characters or in pinyin. (2 marks)

(c) This sentence has a mistake: 我很有三本书。(Wǒ hěn yǒu sān běn shū.) Write the correct sentence and explain the mistake in English. (2 marks)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] 1 A
[1] 2 B
[1] 3 A
[1] 4 C
(b) [1] 我喜欢喝茶。(Wǒ xǐhuan hē chá.) Verb order correct: subject + 喜欢 + 喝 + 茶
[1] Characters or pinyin accurate (no wrong word for "like", "drink" or "tea")
(c) [1] 我有三本书。(Wǒ yǒu sān běn shū.)
[1] 很 (hěn) is used before adjectives, not before 有 with a number and measure word, so 很 must be removed$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | D 6]]
Task 6: Writing a postcard.

You are on holiday in Chengdu. Write a postcard to your friend Xiao Lin of about 20 to 30 characters. Include:
- where you are
- what the weather is like
- one thing you eat or do there
- when you come home

You may write in characters, or in characters with pinyin if you wish. (6 marks)

Total for Question 6: 6 marks$mq$, $mq$Content (4 marks): one mark for each point, communicated clearly and correctly.
[1] Says where the writer is (for example 我在成都)
[1] Says what the weather is like (for example 天气很热 or 今天下雨)
[1] Says one thing eaten or done (for example 我吃了火锅 or 我去看大熊猫)
[1] Says when the writer comes home (for example 我星期日回家)
Language (2 marks):
[1] Uses a correct sentence pattern (for example 我在……, 天气很……, 我想/要……)
[1] Characters or pinyin are mostly accurate, and word order is mostly correct$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | D 14]]
Task 7: Writing. Your Chinese pen friend, Xiao Wei, is writing a school magazine article about free time and technology. Write a blog post of about 60 to 80 characters about your own free time. Include:
- what you like to do on your phone or computer
- how many hours you use it every day
- one other free-time activity that does not use technology
- one rule about technology at home or at school
- your favourite TV programme, film or kind of music, and why
- a plan for next weekend (use 想 or 要)

You may write in characters, or in characters with pinyin if you wish. (14 marks)

Total for Question 7: 14 marks$mq$, $mq$Content (6 marks): one mark for each point, communicated clearly and correctly.
[1] Says what the writer does on a phone or computer (for example 我喜欢用手机听音乐)
[1] Says how many hours a day (for example 我每天用两个小时)
[1] Names another free-time activity without technology (for example 我也喜欢踢足球)
[1] Gives one rule (for example 晚上九点以后不可以用手机)
[1] Names a favourite programme, film or music and gives a reason (for example 我最喜欢看电影，因为很有意思)
[1] A plan for next weekend using 想 or 要 (for example 下个周末我想去看朋友)
Language (6 marks):
[1] Uses 喜欢 with a verb correctly
[1] Uses a number with the measure word 个 or the time word 小时 correctly
[1] Uses 不可以 or 不能 correctly in the rule
[1] Uses 因为 or another linking word correctly
[1] Uses 想 or 要 before a verb in the plan
[1] Most characters or pinyin are accurate and the message is easy to understand
Communication (2 marks):
[1] The post is organised logically, with an opening and a clear ending
[1] The length is suitable and the tone is friendly and suitable for a blog$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- French Language & Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks) (80 marks)
with sub as (select id from public.subjects where slug = $mq$french-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French Language & Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French Language & Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1.1 | A 2]]
Tâche 1 : analyse
Les questions 1.1 à 1.4 portent sur le concept clé de communication. La question 1.5 porte sur le concept clé de connexions. Les critères évalués sont A (analyse) et B (organisation). Temps conseillé : 15 minutes pour les questions 1.1 à 1.4 ; 35 minutes pour la question 1.5.

Texte A : « Le dernier marché » (extrait d'une nouvelle, écrit pour cette épreuve)
Cet extrait raconte le dernier samedi d'un marché de quartier, vu par Camille, qui aide son grand-père à ranger son stand.

Le marché de la place des Tilleuls fermait pour de bon ce samedi-là. Personne ne l'avait dit à haute voix, mais tout le monde le savait : sur la façade de la mairie, une affiche annonçait « Début des travaux : lundi ».

Camille aidait son grand-père à plier la bâche, comme chaque semaine depuis qu'elle savait porter une caisse. Lucien, lui, ne se pressait pas. Il rangeait les tomates par couleur, du rouge sombre au jaune pâle, avec le soin d'un horloger. « Elles ne partiront pas toutes seules », grommela-t-il, bien qu'il ne reste plus un seul client.

Autour d'eux, les stands se vidaient dans un bruit de ferraille et de portières claquées. La fromagère avait laissé un morceau de tomme sur la caisse sans rien dire. Le boucher passa en lui serrant l'épaule. Personne ne se disait adieu ; on se disait « à samedi », par habitude ou par entêtement.

Camille regardait les mains de son grand-père, noires de terre malgré le savon, qui tremblaient légèrement sur la dernière cagette. Elle voulut dire quelque chose de réconfortant, mais les mots restaient coincés, comme des graines dans une main fermée.

— Tu sais, dit-il enfin sans la regarder, quarante ans, c'est long pour une place. Mais une place, ça ne se ferme pas tout à fait. Il suffit que quelqu'un revienne s'y asseoir.

Il lui tendit une tomate, la plus belle. Elle la serra contre elle comme on garde un secret. Sur la place, les tilleuls bruissaient, indifférents et patients.

Texte B : transcription de « Ma place, mon marché », un film de deux minutes réalisé par une association de quartier (écrit pour cette épreuve ; dans l'examen réel, il s'agirait d'une vidéo)
[Image : plan large d'une place vide, recouverte de bitume gris, avec quelques voitures garées. Musique : un accordéon lent, presque hésitant.]
Voix off (une femme, chaleureuse) : « Il y a un an, ici, on se disputait le dernier panier de fraises. »
[Image : séquence accélérée, en couleurs vives : des étals, des enfants, une vieille dame qui goûte un fromage. L'accordéon s'accélère.]
Voix off : « On y apprenait le prénom des voisins. On y apprenait aussi qu'une tomate a une saison. »
[Image : gros plan sur les mains d'un maraîcher, plan fixe pendant cinq secondes, silence total.]
Voix off : « Un marché, ce n'est pas seulement des légumes. C'est un endroit où personne n'est seul. »
[Image : retour au présent, la place grise sous la pluie, un seul lampadaire allumé. Musique grave.]
Texte à l'écran, lettres blanches sur fond vert : 2 800 SIGNATURES POUR LE FAIRE REVENIR. ET VOUS ? Signez la pétition à la mairie ou en ligne.

Question 1.1 : Commentez l'effet de la phrase suivante du texte A : « Personne ne se disait adieu ; on se disait "à samedi", par habitude ou par entêtement. » (2 marks)

Total pour la question 1.1 : 2 marks$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies an effect with reference to the sentence but does not develop it, e.g. the characters avoid saying goodbye because they do not want to accept that the market is ending. [1] Level 2 (2 marks): comments on the effect with explanation and a precise reference, e.g. the repeated habitual phrase « à samedi » shows denial and loyalty: the stallholders pretend that nothing has changed, and « par entêtement » suggests a stubborn refusal that makes the scene moving, because the reader knows the market closes on Monday. [1] Award 0 for no or incorrect reference to the text. Accept comments on the semicolon, the contrast between « adieu » and « à samedi », or the generalising pronoun « on ».$mq$, $mq$A$mq$),
(2, $mq$[[Q 1.2 | A 3]]
Référez-vous au texte A (imprimé à la question 1.1). Expliquez l'effet de la phrase suivante : « Elle voulut dire quelque chose de réconfortant, mais les mots restaient coincés, comme des graines dans une main fermée. » (3 marks)

Total pour la question 1.2 : 3 marks$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies an effect without developing it, e.g. Camille cannot find the words to comfort her grandfather. [1] Level 2 (2 marks): describes the effect of the simile with some explanation, e.g. words are compared to seeds held in a closed hand: they are valuable and ready to grow, but they cannot come out, so the reader feels Camille's emotion and awkwardness. [1] Level 3 (3 marks): explains the effect consistently, with precise reference and a link to the wider text, e.g. the seed image belongs to the world of the market and the garden, which links her silence to her grandfather's trade; « coincés » and « fermée » suggest physical blockage and so a feeling too strong for speech; the image also hints that something might still grow from what is unsaid, which prepares the grandfather's hopeful final words. [1] Accept any valid interpretation supported by the text.$mq$, $mq$A$mq$),
(3, $mq$[[Q 1.3 | A 2]]
Référez-vous au texte B (imprimé à la question 1.1). Décrivez le but de la musique dans le film. (2 marks)

Total pour la question 1.3 : 2 marks$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a purpose without explanation, e.g. the music sets the mood. [1] Level 2 (2 marks): describes a purpose with an example, e.g. the slow, hesitant accordion over the empty square creates sadness and absence; it speeds up during the lively market scene to show energy and joy; the silence on the market gardener's hands focuses attention on a person; the low music at the end returns the viewer to a bleak present and prepares the call to sign the petition. [1] Award 0 for no or incorrect reference to the film.$mq$, $mq$A$mq$),
(4, $mq$[[Q 1.4 | A 3]]
Référez-vous au texte B (imprimé à la question 1.1). Analysez l'effet d'une technique utilisée dans le film. (3 marks)

Total pour la question 1.4 : 3 marks$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies a technique and an effect with no development, e.g. the voice-over speaks directly to the audience. [1] Level 2 (2 marks): describes the effect of one technique with some justification, e.g. the sped-up sequence in bright colours shows the market as lively and warm, which contrasts with the grey, empty square and makes the loss clearer. [1] Level 3 (3 marks): analyses the effect consistently with a precise example, e.g. the cut from the vivid past to the grey present (colour contrast), together with the on-screen question « ET VOUS ? », moves the viewer from nostalgia to a personal call to act, and the green background of the final text recalls the fresh produce and hope. [1] Accept any valid technique: voice-over, direct address, close-up, silence, fast motion, colour, on-screen text, rhetorical question.$mq$, $mq$A$mq$),
(5, $mq$[[Q 1.5 | A 10 | B 10]]
Référez-vous au texte A et au texte B (imprimés à la question 1.1). Comparez et opposez la manière dont l'idée de communauté est explorée dans les deux textes. (Environ 350 mots) (20 marks)

Le critère A (analyse) vaut 10 points et le critère B (organisation) vaut 10 points.

Total pour la question 1.5 : 20 marks$mq$, $mq$Criterion A (10 marks) and Criterion B (10 marks), 20 marks in total. Criterion A: 9 to 10 marks for effective, perceptive analysis of content, language, structure and technique in BOTH texts with extensive well-chosen evidence; 6 to 8 for considerable analysis with sufficient evidence; 3 to 5 for adequate analysis with some evidence; 1 to 2 for limited analysis with few examples. Indicative content: Text A shows community through small gestures (the cheese seller leaves a piece of tomme, the butcher squeezes Camille's shoulder, « à samedi »), through the grandfather's care for his tomatoes and through the lime trees as silent witnesses; the tone is quiet, nostalgic and accepting, and the story ends with a hopeful image of someone coming back to sit on the square. Text B shows community through collective memory (« on y apprenait le prénom des voisins ») and the statement « personne n'est seul », using colour contrast, music and silence to move the audience; the purpose is persuasive and ends with a direct call to action (the petition, « ET VOUS ? »). Contrast: private, subtle and emotional (narrative, implied) versus public, explicit and persuasive (film, direct address); loss accepted with dignity versus loss resisted through action; the place as memory versus the place as something to be won back. Award up to [10] for Criterion A. Criterion B: 9 to 10 marks for effective organisation with a clear structure, comparison and contrast sustained throughout, effective linking (par contre, alors que, de même, tandis que) and a conclusion; 6 to 8 for a considerable degree; 3 to 5 for an adequate degree with some comparison; 1 to 2 for limited, mostly separate treatment of each text. Award up to [10] for Criterion B.$mq$, $mq$A$mq$),
(6, $mq$[[Q 2.1 | C 10 | D 10]]
Tâche 2 : produire un texte littéraire
Cette tâche porte sur le concept clé de créativité. Les critères évalués sont C (produire un texte) et D (utiliser la langue). Temps conseillé : 35 minutes.

Image 1 (décrite par des mots) : Une échelle en bois est appuyée contre le mur d'une cour déserte. Tout en haut, une seule fenêtre est éclairée. Sur les pavés traînent des feuilles mortes et une paire de gants de jardinage.
Image 2 (décrite par des mots) : Une vieille cabine téléphonique rouillée, envahie par le lierre, se dresse au bord d'un champ. Le combiné pend au bout de son fil. Le ciel est lourd d'orage.

À partir d'une des deux images, rédigez une scène d'une nouvelle dans laquelle un personnage doit prendre une décision difficile. Vous pouvez tenir compte du but, des personnages, du cadre, de l'atmosphère et du point de vue. Indiquez l'image choisie avant de commencer. (Environ 350 mots) (20 marks)

Total pour la question 2.1 : 20 marks$mq$, $mq$Criterion C (10 marks): 9 to 10 high degree of insight and imagination, perceptive stylistic choices (imagery, pacing, point of view, sensory detail) and extensive, precise detail; 6 to 8 considerable insight, thoughtful choices, sufficient detail; 3 to 5 some insight, some stylistic choices, some detail; 1 to 2 limited. A response that uses neither image nor the prompt scores 0 for C. A response with no difficult decision cannot score above 5. Award up to [10] for Criterion C. Criterion D (10 marks): 9 to 10 effective range of vocabulary and sentence structures, consistently purposeful register, high accuracy with minor errors only (accents, agreement, verb forms, use of passé composé with imparfait or passé simple with imparfait); 6 to 8 varied range, considerable accuracy, errors do not hinder communication; 3 to 5 adequate range, a degree of accuracy, errors sometimes hinder; 1 to 2 limited range, errors often hinder meaning. Award up to [10] for Criterion D. Indicative content: a clearly named image; a character with a real dilemma (for example whether to climb towards the lit window, or whether to pick up the phone); rising tension; controlled atmosphere; an ending that leaves the decision meaningful. Common errors: summarising a whole story; describing the image without any action; clichés such as « c'était une nuit sombre et orageuse » ; inconsistent tenses; anglicisms; missing agreement.$mq$, $mq$C$mq$),
(7, $mq$[[Q 3.1 | B 10 | C 10 | D 10]]
Tâche 3 : produire un texte non littéraire
Cette tâche porte sur le concept clé de perspective. Vous allez écrire un texte non littéraire en lien avec le contexte global mondialisation et durabilité : le tourisme et ses effets sur les lieux et les populations. Les critères évalués sont B (organisation), C (produire un texte) et D (utiliser la langue). Temps conseillé : 35 minutes.

Rédigez un article de blog pour le site d'une association de jeunes voyageurs, intitulé « Comment voyager sans abîmer la planète ni les lieux que l'on visite ? ». Utilisez une structure claire (titre, introduction, paragraphes, conclusion) et un ton adapté à des lecteurs de votre âge. (Environ 350 mots) (30 marks)

Total pour la question 3.1 : 30 marks$mq$, $mq$Criterion B (10 marks): organisation suited to a blog article: an engaging title and introduction, clearly separated paragraphs with topic sentences, linking words, a clear conclusion and an awareness of the conventions of the text type (direct address to the reader, short subheadings, a call to action); 9 to 10 effective, 6 to 8 considerable, 3 to 5 adequate, 1 to 2 limited. Award up to [10] for Criterion B. Criterion C (10 marks): a perspective on the global context shown through insight, relevant detail and examples (for example transport and carbon emissions, overcrowding, respect for local culture, buying from local people, water and waste, seasonal travel, slow travel); 9 to 10 high degree of insight and extensive detail, 6 to 8 considerable, 3 to 5 some, 1 to 2 limited. Award up to [10] for Criterion C. Criterion D (10 marks): register suited to young readers (tutoiement or vouvoiement used consistently), varied sentence structures, appropriate connectives, accurate use of the conditional, the imperative and the subjunctive where relevant (for example « il faut que nous choisissions »), and accuracy of spelling, accents and agreement; 9 to 10 high accuracy with minor errors, 6 to 8 considerable accuracy, 3 to 5 a degree of accuracy, 1 to 2 minimal accuracy. Award up to [10] for Criterion D. Common errors: a list of tips without development; no sense of audience; confusing « leur/leurs », « ce/se », « a/à », « ces/ses »; anglicisms such as « réaliser » for « se rendre compte »; mixing tu and vous.$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- Spanish Language & Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks) (80 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish Language & Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish Language & Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1.1 | A 2]]
Tarea 1: análisis
Las preguntas 1.1 a 1.4 se centran en el concepto clave de comunicación. La pregunta 1.5 se centra en el concepto clave de conexiones. Los criterios evaluados son A (análisis) y B (organización). Tiempo sugerido: 15 minutos para las preguntas 1.1 a 1.4; 35 minutos para la pregunta 1.5.

Texto A: «La última noche en la casa de la abuela» (fragmento de un cuento, escrito para esta prueba)
Este fragmento cuenta la noche antes de que Mateo y su familia dejen su pueblo de montaña para mudarse a la capital.

Esa noche, la cocina de la abuela Rosa olía a leña y a maíz tostado, como siempre, aunque nada era como siempre. En un rincón, las maletas esperaban junto a la puerta, apiladas con prisa, y el autobús que los llevaría a la capital saldría a las cinco de la mañana.

Mateo fingía repasar la lista de las cosas que había que llevar. En realidad miraba cómo su abuela removía la olla con una calma exagerada, de esas que se usan para no llorar. Cada vez que la cuchara rozaba el fondo, el ruido llenaba la cocina como un reloj que alguien hubiera olvidado parar.

—Allí tendrás internet —dijo ella sin volverse—. Y ascensores. Y mucha gente que no te saludará.

—Te llamaré todos los domingos —prometió él.

—Los domingos —repitió la abuela, y la palabra quedó flotando en el vapor, tan frágil como una promesa.

Después le tendió un frasquito de cristal lleno de tierra del huerto, cerrado con un trozo de tela.

—Para que no se te olvide de dónde eres —murmuró, y volvió a la olla.

Mateo guardó el frasco en el bolsillo más hondo de la mochila, donde ponía las cosas que no podía perder. Fuera, un perro ladró una sola vez y el valle entero se quedó escuchando.

Texto B: transcripción de «Un libro llega al valle», un vídeo de dos minutos de una fundación que lleva libros a zonas rurales (escrito para esta prueba; en el examen real sería un vídeo)
[Imagen: un autobús azul cargado de estanterías avanza por una carretera de tierra entre montañas. Música: una guitarra suave, con ritmo de caminata.]
Narradora (voz cálida): «En el valle de Tarucas hay veintitrés pueblos y una sola biblioteca.»
[Imagen: plano general del valle vacío; después, primer plano de una niña que mira por la ventana.]
Narradora: «Hasta que la biblioteca aprendió a andar.»
[Imagen: el autobús se detiene en una plaza; niños y ancianos hacen cola. La música se acelera con palmas.]
Marta, 11 años (mirando a cámara): «Antes leía el mismo libro cuatro veces. Ahora le pido uno nuevo al conductor, y él me lo guarda.»
[Imagen: silencio durante tres segundos; un hombre mayor recorre las líneas de un libro con el dedo, deletreando.]
Narradora: «Nadie es demasiado joven, ni demasiado viejo, para empezar una historia.»
Texto en pantalla, letras blancas sobre fondo azul: CADA LIBRO ES UN CAMINO. AYÚDANOS A SEGUIR RODANDO. Dona libros o tu tiempo.

Pregunta 1.1: Comenta el uso de los olores y de los objetos en el primer párrafo del texto A. (2 marks)

Total para la pregunta 1.1: 2 marks$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a use of smells or objects with reference to the text but does not explain it, e.g. the kitchen smells of firewood and toasted maize, and the suitcases are by the door. [1] Level 2 (2 marks): comments with an example and an explanation, e.g. the familiar smells (« leña », « maíz tostado ») create warmth and memory, while the hurriedly stacked suitcases (« apiladas con prisa ») and the contrast « como siempre, aunque nada era como siempre » show that the home is already being left behind, which creates a bittersweet, anxious mood. [1] Award 0 for no or incorrect reference to the text.$mq$, $mq$A$mq$),
(2, $mq$[[Q 1.2 | A 3]]
Consulta el texto A (impreso en la pregunta 1.1). Explica el efecto de la siguiente frase: «En realidad miraba cómo su abuela removía la olla con una calma exagerada, de esas que se usan para no llorar.» (3 marks)

Total para la pregunta 1.2: 3 marks$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies an effect without developing it, e.g. the grandmother is pretending to be calm. [1] Level 2 (2 marks): describes the effect with some explanation, e.g. « calma exagerada » shows that her calm is an act, so the reader understands that she is sad and is hiding it from Mateo. [1] Level 3 (3 marks): explains the effect consistently with precise reference, e.g. the generalising phrase « de esas que se usan para no llorar » tells the reader what the calm hides, using a quiet, almost understated tone; Mateo's observation (« en realidad miraba ») shows that he too is pretending to be busy, so both characters hide emotion for the other's sake, and the pathos grows from what is not said. [1] Accept any valid interpretation supported by the text.$mq$, $mq$A$mq$),
(3, $mq$[[Q 1.3 | A 2]]
Consulta el texto B (impreso en la pregunta 1.1). Describe la función del silencio y de la música en el vídeo. (2 marks)

Total para la pregunta 1.3: 2 marks$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a purpose without explanation, e.g. the music sets the mood. [1] Level 2 (2 marks): describes a purpose with an example, e.g. the soft guitar with a walking rhythm suggests a slow, hopeful journey; the music speeds up with clapping when the bus reaches the square to convey community joy; the three seconds of silence on the old man spelling out the words focus the viewer on his effort and dignity and make the emotional point that reading is never too late. [1] Award 0 for no or incorrect reference to the video.$mq$, $mq$A$mq$),
(4, $mq$[[Q 1.4 | A 3]]
Consulta el texto B (impreso en la pregunta 1.1). Analiza el efecto de una técnica utilizada en el vídeo. (3 marks)

Total para la pregunta 1.4: 3 marks$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies a technique and an effect with no development, e.g. the child speaks to the camera. [1] Level 2 (2 marks): describes the effect of one technique with some justification, e.g. Marta looking straight at the camera and talking about reading the same book four times makes the problem personal and believable. [1] Level 3 (3 marks): analyses the effect consistently with a precise example, e.g. the movement from the empty wide shot of the valley to the close-up of the girl at the window makes the audience feel the isolation of one child, and the personification « la biblioteca aprendió a andar » presents the bus as a living friend, so that the final on-screen call (« AYÚDANOS A SEGUIR RODANDO ») invites viewers to become part of the journey. [1] Accept any valid technique: direct address, testimony, close-up, wide shot, personification, music, silence, on-screen text, imperative.$mq$, $mq$A$mq$),
(5, $mq$[[Q 1.5 | A 10 | B 10]]
Consulta el texto A y el texto B (impresos en la pregunta 1.1). Compara y contrasta cómo se explora la idea de pertenencia a una comunidad en los dos textos. (Unas 350 palabras) (20 marks)

El criterio A (análisis) vale 10 puntos y el criterio B (organización) vale 10 puntos.

Total para la pregunta 1.5: 20 marks$mq$, $mq$Criterion A (10 marks) and Criterion B (10 marks), 20 marks in total. Criterion A: 9 to 10 marks for effective, perceptive analysis of content, language, structure and technique in BOTH texts with extensive well-chosen evidence; 6 to 8 for considerable analysis with sufficient evidence; 3 to 5 for adequate analysis with some evidence; 1 to 2 for limited analysis with few examples. Indicative content: Text A explores belonging as a bond with a place and a family: the jar of earth (« para que no se te olvide de dónde eres »), the smells of the kitchen, the dog and the listening valley; leaving threatens that bond (« mucha gente que no te saludará »), and the tone is intimate, restrained and elegiac. Text B explores belonging as something a community builds and shares: the bus brings books, neighbours queue together, an old man and a child are both included (« nadie es demasiado joven, ni demasiado viejo »); its tone is warm, hopeful and persuasive and ends with a direct call to action. Contrast: belonging as loss and memory (individual, private, implied) versus belonging as connection and access (collective, public, explicit); leaving the valley versus bringing the world to the valley; the symbolism of the jar of earth versus the bus that rolls on. Award up to [10] for Criterion A. Criterion B: 9 to 10 marks for effective organisation with a clear structure, comparison and contrast sustained throughout, effective linking (en cambio, mientras que, de igual modo, por el contrario) and a conclusion; 6 to 8 for a considerable degree; 3 to 5 for an adequate degree with some comparison; 1 to 2 for limited, mostly separate treatment of each text. Award up to [10] for Criterion B.$mq$, $mq$A$mq$),
(6, $mq$[[Q 2.1 | C 10 | D 10]]
Tarea 2: producir un texto literario
Esta tarea se centra en el concepto clave de creatividad. Los criterios evaluados son C (producir un texto) y D (usar la lengua). Tiempo sugerido: 35 minutos.

Imagen 1 (descrita con palabras): Un viejo buzón de metal, oxidado, se alza solo en medio de un campo de girasoles secos. Del buzón sobresale la esquina de una carta amarillenta. El cielo es de un rosa pálido, como al amanecer o al atardecer.
Imagen 2 (descrita con palabras): Una bicicleta está apoyada contra la pared de una casa cerrada, con las persianas bajadas. De un manillar cuelga una llave sujeta con un cordel rojo. En el suelo hay hojas secas y un charco pequeño.

A partir de una de las dos imágenes, escribe una escena de un cuento en la que un personaje encuentra algo que cambia su día. Puedes tener en cuenta el propósito, los personajes, el escenario, la atmósfera y el punto de vista. Indica la imagen elegida antes de empezar. (Unas 350 palabras) (20 marks)

Total para la pregunta 2.1: 20 marks$mq$, $mq$Criterion C (10 marks): 9 to 10 high degree of insight and imagination, perceptive stylistic choices (imagery, pacing, point of view, sensory detail) and extensive, precise detail; 6 to 8 considerable insight, thoughtful choices, sufficient detail; 3 to 5 some insight, some stylistic choices, some detail; 1 to 2 limited. A response that uses neither image nor the prompt scores 0 for C. A response in which nothing is found or nothing changes cannot score above 5. Award up to [10] for Criterion C. Criterion D (10 marks): 9 to 10 effective range of vocabulary and sentence structures, consistently purposeful register, high accuracy with minor errors only (accents, agreement, ser/estar, por/para, control of pretérito indefinido and pretérito imperfecto); 6 to 8 varied range, considerable accuracy, errors do not hinder communication; 3 to 5 adequate range, a degree of accuracy, errors sometimes hinder; 1 to 2 limited range, errors often hinder meaning. Award up to [10] for Criterion D. Indicative content: a clearly named image; a character who finds the letter or the key and has to react; rising tension or curiosity; sensory detail (colour, sound, smell, texture); an ending that shows how the day has changed. Common errors: summarising a whole story; describing the image without any action; clichés such as «era una noche oscura y tormentosa»; inconsistent tenses; anglicisms; missing accents and agreement.$mq$, $mq$C$mq$),
(7, $mq$[[Q 3.1 | B 10 | C 10 | D 10]]
Tarea 3: producir un texto no literario
Esta tarea se centra en el concepto clave de perspectiva. Vas a escribir un texto no literario relacionado con el contexto global equidad y desarrollo: las comunidades y el acceso a oportunidades. Los criterios evaluados son B (organización), C (producir un texto) y D (usar la lengua). Tiempo sugerido: 35 minutos.

Escribe un artículo de opinión para la revista de tu instituto con el título «¿Deberían los jóvenes dedicar parte de su tiempo libre al voluntariado?». Usa una estructura clara (título, introducción, párrafos, conclusión) y un tono adecuado para lectores de tu edad. (Unas 350 palabras) (30 marks)

Total para la pregunta 3.1: 30 marks$mq$, $mq$Criterion B (10 marks): organisation suited to an opinion article: a title and an introduction that raise the question, clearly separated paragraphs with topic sentences, linking words, a clear conclusion and the conventions of the text type (direct address to the reader, rhetorical questions, a call to action); 9 to 10 effective, 6 to 8 considerable, 3 to 5 adequate, 1 to 2 limited. Award up to [10] for Criterion B. Criterion C (10 marks): a perspective on the global context shown through insight, relevant detail and examples (for example helping neighbours or elderly people, tutoring younger pupils, food banks, environmental clean-ups, skills and confidence gained, the risk of overload for students, voluntary versus compulsory service); 9 to 10 high degree of insight and extensive detail, 6 to 8 considerable, 3 to 5 some, 1 to 2 limited. Accept any clear position, including a balanced one. Award up to [10] for Criterion C. Criterion D (10 marks): register suited to teenage readers (tú or usted used consistently), varied sentence structures, appropriate connectives, accurate use of the subjunctive after expressions such as «es importante que» and «creo que no», the conditional, and accuracy of spelling, accents and agreement; 9 to 10 high accuracy with minor errors, 6 to 8 considerable accuracy, 3 to 5 a degree of accuracy, 1 to 2 minimal accuracy. Award up to [10] for Criterion D. Common errors: a list of reasons without development; ignoring the counter-argument; informal text-message register; confusing «a ver/haber», «porque/por qué/porqué», «hay/ahí/ay», «sino/si no».$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);
commit;
