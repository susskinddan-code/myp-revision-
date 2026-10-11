-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Spanish ab initio MYP 5 Full eAssessment Mock (112 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish ab initio MYP 5 Full eAssessment Mock$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish ab initio MYP 5 Full eAssessment Mock$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Section A: Listening. Listening transcript (imagine you hear this voice message twice). Read it, then answer in English.

Mensaje de voz de la señora López:
« Hola, Anna, soy la señora López. Estoy en el supermercado. Esta noche tenemos invitados: mi hermano Antonio y su mujer, Sofía. Cenamos a las ocho. Preparo una tortilla de patatas y una ensalada verde. Somos seis en la mesa. ¿Puedes poner la mesa, por favor? Después, puedes pasear al perro, Max, por el parque. No vuelvas después de las siete y media. Yo vuelvo a las seis. ¡Hasta luego! »

(a) Where is Señora López now? (1 mark)
(b) Who are the two guests tonight? (2 marks)
(c) At what time will they eat? (1 mark)
(d) What is the main dish? (1 mark)
(e) What is Anna asked to do first? (1 mark)
(f) How many people will sit at the table? (1 mark)
(g) What is Anna asked to do afterwards, and where? (2 marks)
(h) What is the latest time Anna should be home? (1 mark)

(Total 10 marks)$mq$, $mq$(a) [1] At the supermarket
(b) [1] Her brother Antonio
[1] His wife Sofía
(c) [1] 8 pm / 20:00
(d) [1] Potato omelette (Spanish tortilla)
(e) [1] Set/lay the table
(f) [1] Six
(g) [1] Walk the dog (Max)
[1] In/through the park
(h) [1] 7.30 pm / 19:30 (do not accept 6 pm, which is when Señora López returns)$mq$, $mq$A$mq$),
(2, $mq$Listening transcript (imagine you hear this conversation twice). Read it, then answer in English.

En una tienda de ropa
Dependienta: Buenas tardes, ¿en qué puedo ayudarla?
Clienta: Busco un jersey para mi hermano. Le gusta el azul o el verde.
Dependienta: ¿Qué talla usa?
Clienta: Usa la M.
Dependienta: Aquí tiene un jersey azul de veinticinco euros y uno verde de treinta euros.
Clienta: El verde es bonito, pero es un poco caro. Me llevo el azul.
Dependienta: Muy bien. ¿Algo más?
Clienta: Sí, un sombrero para mí. ¿Tienen sombreros rojos?
Dependienta: No, lo siento, solo negros o grises. Cuestan diez euros.
Clienta: Entonces, me llevo uno gris. Pago en efectivo. Aquí tiene cincuenta euros.
Dependienta: Aquí tiene su cambio: quince euros.

(a) Who is the pullover for? (1 mark)
(b) Which two colours does he like? (2 marks)
(c) What size does he wear? (1 mark)
(d) How much is the green pullover? (1 mark)
(e) Why does the customer not choose the green pullover? (1 mark)
(f) Which colour of hat does she buy? (1 mark)
(g) Why can she not have a red hat? (1 mark)
(h) How much does she spend in total? (1 mark)
(i) How much change does she receive? (1 mark)

(Total 10 marks)$mq$, $mq$(a) [1] Her brother
(b) [1] Blue
[1] Green
(c) [1] M (medium)
(d) [1] 30 euros
(e) [1] It is a bit expensive
(f) [1] Grey
(g) [1] The shop only has black or grey hats (no red ones)
(h) [1] 35 euros (25 + 10)
(i) [1] 15 euros$mq$, $mq$A$mq$),
(3, $mq$Listening transcript (imagine you hear this radio advertisement twice). Read it, then answer in English.

« ¿Te gusta el deporte? ¡Ven al Centro Deportivo Agua Viva! Tenemos una piscina, dos pistas de tenis y un gimnasio. El centro está abierto todos los días, de siete de la mañana a diez de la noche, excepto los domingos. Para los menores de dieciocho años, la entrada cuesta tres euros. También hay clases de natación los martes y los jueves a las cinco de la tarde. Si tienes hambre, hay una cafetería. El aparcamiento es gratis. Para reservar una pista de tenis, entra en nuestra página web. »

(a) Name two facilities at the centre. (2 marks)
(b) What are the opening hours? (1 mark)
(c) On which day is the centre closed? (1 mark)
(d) How much is entry for people under eighteen? (1 mark)
(e) On which two days are the swimming lessons? (2 marks)
(f) At what time are the swimming lessons? (1 mark)
(g) What is free? (1 mark)
(h) How do you book a tennis court? (1 mark)

(Total 10 marks)$mq$, $mq$(a) [1] Any one of: swimming pool / tennis courts / gym / cafe
[1] A different one of these
(b) [1] 7 am to 10 pm (07:00-22:00)
(c) [1] Sunday
(d) [1] 3 euros
(e) [1] Tuesday
[1] Thursday
(f) [1] 5 pm / 17:00
(g) [1] The car park / parking
(h) [1] On the website / online$mq$, $mq$A$mq$),
(4, $mq$Section B: Reading. Read this email, then answer the questions in English.

De: ines.garcia@ejemplo.es
Asunto: Mi instituto

Hola, Emma:
¡Gracias por tu mensaje! Me preguntas cómo es mi instituto. Voy al instituto Sierra Verde, en Toledo. Las clases empiezan a las ocho y terminan a las cuatro y media. Tengo matemáticas, lengua, historia e inglés, pero mi asignatura favorita es la biología porque el profesor es muy gracioso. Odio la geografía: ¡es aburrida! A mediodía como en el comedor con mis amigas Zoe y Manuela. Los miércoles por la tarde no tengo clase, así que hago natación. Mi instituto es grande, con un gimnasio y un patio enorme. Hay mil alumnos. Voy en autobús y tardo veinte minutos. Y tu colegio, ¿cómo es? ¡Hasta pronto!
Inés

(a) Name Inés's school and the city. (2 marks)
(b) At what times do lessons start and finish? (2 marks)
(c) What is Inés's favourite subject and why? (2 marks)
(d) Which subject does Inés dislike? (1 mark)
(e) Who does Inés eat lunch with? (2 marks)
(f) What does Inés do on Wednesday afternoon, and why? (2 marks)
(g) How many students are there in the school? (1 mark)

(Total 12 marks)$mq$, $mq$(a) [1] Instituto Sierra Verde
[1] Toledo
(b) [1] 8 am / 08:00 (start)
[1] 4.30 pm / 16:30 (finish)
(c) [1] Biology
[1] The teacher is very funny
(d) [1] Geography
(e) [1] Zoe
[1] Manuela
(f) [1] She goes swimming
[1] She has no lessons (on Wednesday afternoon)
(g) [1] 1000 / one thousand$mq$, $mq$B$mq$),
(5, $mq$Read this programme for a school trip, then answer the questions in English.

VIAJE ESCOLAR A BARCELONA – 12 y 13 de mayo
Jueves 12: 7:30 salida en autocar delante del colegio · 10:30 llegada a Barcelona · 11:00 visita a la Sagrada Familia · 12:30 picnic en el parque · 14:30 Museo Picasso · 18:30 cena en el hotel · 20:00 paseo en barco por el puerto
Viernes 13: 8:00 desayuno · 9:30 visita al Parque Güell · 12:00 almuerzo en un restaurante · 14:00 compras · 16:00 vuelta en autocar · 19:30 llegada al colegio
Precio: 120 €. Hay que traer: documento de identidad, mochila, zapatos cómodos.

(a) When and where does the coach leave? (2 marks)
(b) How do the students travel to Barcelona? (1 mark)
(c) At what time do they arrive in Barcelona? (1 mark)
(d) What do they do at 12.30 on Thursday? (1 mark)
(e) What is the evening activity on Thursday after dinner? (1 mark)
(f) At what time is breakfast on Friday? (1 mark)
(g) Where do they have lunch on Friday? (1 mark)
(h) At what time do they leave Barcelona on Friday? (1 mark)
(i) How much does the trip cost? (1 mark)
(j) Name two things students must bring. (2 marks)

(Total 12 marks)$mq$, $mq$(a) [1] 7.30 am / 07:30 on Thursday
[1] In front of the school
(b) [1] By coach
(c) [1] 10.30 am / 10:30
(d) [1] A picnic in the park
(e) [1] A boat trip around the port
(f) [1] 8 am / 08:00
(g) [1] In a restaurant
(h) [1] 4 pm / 16:00
(i) [1] 120 euros
(j) [1] Any one of: ID document / backpack / comfortable shoes
[1] A different one of these$mq$, $mq$B$mq$),
(6, $mq$Read this blog post, then answer the questions in English.

Mi semana de futbolista
Me llamo Javier y juego al fútbol en un club pequeño. Los lunes me levanto a las seis y media. Desayuno pan con mermelada y un chocolate caliente. Voy al instituto en bicicleta. Las clases empiezan a las ocho y media. Después del instituto vuelvo a casa y hago los deberes. A las cinco tengo entrenamiento en el estadio: corremos, jugamos al fútbol y trabajamos la técnica. Vuelvo a casa a las siete. Ceno con mi familia y luego veo la tele o escucho música. Me acuesto a las diez. Los domingos tenemos un partido: ¡es el mejor día de la semana! Mi sueño es ser jugador profesional.

(a) Which sport does Javier play? (1 mark)
(b) At what time does he get up on Monday? (1 mark)
(c) What does he have for breakfast? Give two details. (2 marks)
(d) How does he get to school? (1 mark)
(e) At what time do lessons start? (1 mark)
(f) What does he do when he gets home from school? (1 mark)
(g) At what time is training? (1 mark)
(h) Give two things the players do at training. (2 marks)
(i) At what time does he go to bed? (1 mark)
(j) What is Javier's dream? (1 mark)

(Total 12 marks)$mq$, $mq$(a) [1] Football
(b) [1] 6.30 am / 06:30
(c) [1] Bread with jam
[1] Hot chocolate
(d) [1] By bike
(e) [1] 8.30 am / 08:30
(f) [1] Homework
(g) [1] 5 pm / 17:00
(h) [1] Any one of: run / play football / work on technique
[1] A different one of these
(i) [1] 10 pm / 22:00
(j) [1] To be a professional player/footballer$mq$, $mq$B$mq$),
(7, $mq$Section C: Language use and writing. Answer all parts.

Part 1. Choose the correct word from the box to complete each sentence. Use each word once.
soy · estoy · tengo · hay · voy
(a) ______ quince años. (1 mark)
(b) Yo ______ estudiante. (1 mark)
(c) Hoy ______ muy cansado. (1 mark)
(d) En mi ciudad ______ un parque grande. (1 mark)
(e) Mañana ______ al cine con mis amigos. (1 mark)

Part 2. Write these sentences in Spanish. (3 marks)
(f) My sister is twelve years old.
(g) We are going to the cinema.
(h) I do not like fish.

Part 3. Each sentence has one mistake. Rewrite it correctly. (2 marks)
(i) Ella es quince años.
(j) Los chicos está contentos.

(Total 10 marks)$mq$, $mq$(a) [1] Tengo
(b) [1] soy
(c) [1] estoy
(d) [1] hay
(e) [1] voy
(f) [1] Mi hermana tiene doce años.
(g) [1] Vamos al cine. (accept: Nosotros vamos al cine)
(h) [1] No me gusta el pescado.
(i) [1] Ella tiene quince años. (tener, not ser, for age)
(j) [1] Los chicos están contentos. (plural verb form)
Accept minor spelling slips in (f)-(h) if the meaning and grammar are clear.$mq$, $mq$D$mq$),
(8, $mq$Writing task 1. You have just arrived at your exchange partner's house in Spain. Write a message of 60 to 80 words in Spanish to your parents. In your message:
- say where you are and who you are staying with
- describe the weather
- say what you did today
- say what you will do tomorrow
- say what you think of the food
- ask them a question. (12 marks)

(Total 12 marks)$mq$, $mq$Communication (task points)
[1] Says where they are and who they are staying with
[1] Describes the weather (e.g. Hace buen tiempo / Llueve)
[1] Says what they did today (simple past or a clear attempt, e.g. Visité la ciudad)
[1] Says what they will do tomorrow (e.g. Mañana voy a ir al museo)
[1] Gives an opinion on the food (e.g. La comida es deliciosa)
[1] Asks a question (e.g. Y vosotros, ¿qué tal?)
Language
[4] Vocabulary and grammar: 4 = mostly accurate with some variety of structures; 3 = generally accurate, simple structures; 2 = frequent errors, message still understood; 1 = very limited; 0 = not understandable
Organisation and register
[2] Greeting and closing used; consistent register (Queridos papás / Un beso); 1 if only one feature
Writing below about 40 words: cap the language marks at 2.
Note: Writing marks are awarded on the task, not on perfection: ab initio candidates are rewarded for clear, simple, mostly accurate Spanish. Indicative Language Acquisition criterion levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$C$mq$),
(9, $mq$Writing task 2. Read this message from your Spanish friend Carla, then write a reply of 80 to 100 words in Spanish.

¡Hola! El sábado voy al parque de atracciones con mi clase. ¿Quieres venir con nosotros? Salimos a las nueve y volvemos a las seis de la tarde. La entrada cuesta veinte euros. Dime si vienes y qué atracciones te gustan. Carla

In your reply:
- thank Carla and say whether you can come (give a reason if you cannot)
- say which rides you like or dislike
- ask where to meet
- ask what to bring. (12 marks)

(Total 12 marks)$mq$, $mq$Communication (task points)
[2] Thanks Carla and says whether they can come; a reason or a positive reaction is given (1 mark for each)
[2] Says which rides they like and dislike (e.g. Me encantan las montañas rusas, pero no me gusta la noria) (1 mark for each)
[1] Asks where to meet (e.g. ¿Dónde quedamos?); also accept a question about when
[1] Asks what to bring
Language
[4] Vocabulary and grammar: 4 = mostly accurate with some variety; 3 = generally accurate, simple structures; 2 = frequent errors, message still understood; 1 = very limited; 0 = not understandable
Organisation and register
[2] Greeting and closing used; informal tú form kept throughout; 1 if only one feature
Accept any logical, original content. Writing below about 50 words: cap the language marks at 2.
Note: Writing marks are awarded on the task, not on perfection: ab initio candidates are rewarded for clear, simple, mostly accurate Spanish. Indicative Language Acquisition criterion levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$C$mq$),
(10, $mq$Writing task 3. Write a blog post of 100 to 120 words in Spanish with the title « Mis vacaciones ideales ». Include:
- where you would like to go and with whom
- what the weather is like there
- three activities you would do
- what you would eat
- why this would be your ideal holiday. (12 marks)

(Total 12 marks)$mq$, $mq$Content
[1] Where and with whom (e.g. Me gustaría ir a Italia con mi familia)
[1] Weather (e.g. Hace calor y hay sol)
[3] Three activities (1 mark each; e.g. nadar, visitar museos, jugar al fútbol)
[1] What they would eat
[1] A reason or opinion (e.g. porque me encanta la playa)
Language
[3] Vocabulary and grammar: 3 = mostly accurate with some variety (including me gustaría / quiero or ir a + infinitive); 2 = generally accurate, simple structures; 1 = frequent errors; 0 = not understandable
Organisation
[2] Title, clear paragraphs or sequence, connectives (y, pero, porque, luego)
Writing below about 60 words: cap the language marks at 1.
Note: Writing marks are awarded on the task, not on perfection: ab initio candidates are rewarded for clear, simple, mostly accurate Spanish. Indicative Language Acquisition criterion levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
