-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Spanish ab initio MYP 5 eAssessment-style Practice Paper 1 (53 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish ab initio MYP 5 eAssessment-style Practice Paper 1$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish ab initio MYP 5 eAssessment-style Practice Paper 1$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Listening transcript (imagine you hear this voice message twice). Read it, then answer in English.

Mensaje de voz de Marta:
« Hola, Pablo, soy Marta. El sábado vamos a la playa con Lucía y Diego. El autobús sale de la estación a las nueve y media. El billete cuesta cuatro euros. Después, comemos paella en un restaurante. Lleva una gorra y crema solar, porque hace mucho sol. ¿Puedes contestar antes del jueves? ¡Hasta el sábado! »

(a) Where are the friends going on Saturday? (1 mark)
(b) At what time does the bus leave? (1 mark)
(c) Where does the bus leave from? (1 mark)
(d) How much does a ticket cost? (1 mark)
(e) What will they eat after the beach? (1 mark)
(f) What two things should Pablo take? (2 marks)

(Total 7 marks)$mq$, $mq$(a) [1] To the beach
(b) [1] 9.30 am / 09:30
(c) [1] The (bus) station
(d) [1] 4 euros
(e) [1] Paella
(f) [1] A cap
[1] Sun cream
Common error: giving 'Thursday' as a time; it is the reply deadline.$mq$, $mq$A$mq$),
(2, $mq$Listening transcript (imagine you hear this school announcement twice). Read it, then answer in English.

Anuncio del instituto:
« Buenos días, alumnos. Tenemos información para mañana. La clase de educación física es en el gimnasio, no en el patio, porque llueve. La clase 10B tiene un examen de inglés a las diez. El almuerzo es a la una y cuarto en el comedor: hay pollo con arroz o una ensalada de verduras. La excursión al museo es el viernes y cuesta diez euros. Gracias y buen día. »

(a) Where is the PE lesson tomorrow, and why? (2 marks)
(b) What exam does class 10B have? (1 mark)
(c) At what time is the exam? (1 mark)
(d) At what time is lunch? (1 mark)
(e) Give the two lunch choices. (2 marks)
(f) How much does the museum trip cost? (1 mark)

(Total 8 marks)$mq$, $mq$(a) [1] In the gym (not in the playground)
[1] Because it is raining
(b) [1] English
(c) [1] 10 o'clock / 10 am
(d) [1] 1.15 pm / 13:15 / quarter past one
(e) [1] Chicken with rice
[1] Vegetable salad
(f) [1] 10 euros$mq$, $mq$A$mq$),
(3, $mq$Read this email, then answer the questions in English.

De: sofia.ruiz@ejemplo.es
Asunto: Mi familia

Hola, Tom:
Me llamo Sofía y tengo quince años. Vivo en Sevilla, en una casa con jardín. En mi familia somos cuatro: mis padres, mi hermano Álvaro y yo. Mi padre es cocinero y mi madre es médica. Álvaro tiene nueve años y le encanta jugar al fútbol. También tengo un perro que se llama Toby. Los fines de semana vamos a casa de mis abuelos. Y tú, ¿tienes hermanos? ¡Escríbeme pronto!
Sofía

(a) How old is Sofía? (1 mark)
(b) What type of home does she live in? (1 mark)
(c) How many people are in Sofía's family? (1 mark)
(d) What is her father's job? (1 mark)
(e) Write True, False or Not mentioned for each statement. (3 marks)
   (i) Álvaro is nine years old.
   (ii) Sofía has a cat.
   (iii) Sofía's mother works in a hospital.
(f) What does the family do at weekends? (1 mark)

(Total 8 marks)$mq$, $mq$(a) [1] 15
(b) [1] A house with a garden
(c) [1] Four
(d) [1] Cook / chef
(e) [1] (i) True
[1] (ii) False (she has a dog)
[1] (iii) Not mentioned (she is a doctor; no workplace is given)
(f) [1] They go to her grandparents' house$mq$, $mq$B$mq$),
(4, $mq$Read this café menu, then answer the questions in English.

RESTAURANTE EL PATIO
Bebidas: agua 1,50 € · zumo de naranja 3 € · café 2 € · limonada 2,50 €
Platos: sopa de verduras 5 € · tortilla española 6,50 € · pollo con patatas 9 € · ensalada mixta 7 €
Postres: helado (vainilla, fresa o chocolate) 4 € · flan 3,50 € · fruta del tiempo 3 €
Menú infantil (menores de 10 años): tortilla + zumo + helado = 9 €
Cerrado los martes. Abierto de 12:00 a 23:00.

(a) On which day is the restaurant closed? (1 mark)
(b) Name two ice cream flavours. (2 marks)
(c) Elena orders the vegetable soup and a flan. How much does she pay? Show your working. (2 marks)
(d) What is included in the children's menu? (3 marks)

(Total 8 marks)$mq$, $mq$(a) [1] Tuesday
(b) [1] Any one of vanilla / strawberry / chocolate
[1] A different one of the three
(c) [1] 5 + 3.50 (working shown)
[1] 8.50 euros
(d) [1] (Spanish) omelette / tortilla
[1] Orange juice
[1] Ice cream$mq$, $mq$B$mq$),
(5, $mq$Complete each sentence with the correct Spanish word or form. Write only the missing word(s).

(a) Nosotros ______ (vivir) en Madrid. (1 mark)
(b) Ella ______ (tener) quince años. (1 mark)
(c) Mis amigos ______ (ir) al cine los sábados. (1 mark)
(d) Tú ______ (ser) muy simpático. (1 mark)
(e) Mi prima es muy ______ (trabajador). (1 mark)
(f) Mis hermanas son ______ (alto). (1 mark)

(Total 6 marks)$mq$, $mq$(a) [1] vivimos
(b) [1] tiene
(c) [1] van
(d) [1] eres
(e) [1] trabajadora (feminine agreement)
(f) [1] altas (feminine plural agreement)$mq$, $mq$D$mq$),
(6, $mq$Writing task. You are staying with a Spanish host family. Write a text message of about 60 words in Spanish to your host sister Ana. In your message:
- say where you are now
- say what you did at school today
- say what you would like to eat this evening
- ask what time dinner is. (8 marks)

(Total 8 marks)$mq$, $mq$Communication (task points)
[1] Says where they are (e.g. Estoy en la biblioteca / en el instituto)
[1] Says what they did at school today (accept simple present or past, e.g. Jugué al baloncesto / Hago deporte)
[1] Says what they would like to eat (e.g. Quiero pasta / Me gustaría comer pizza)
[1] Asks the time of dinner (e.g. ¿A qué hora es la cena?)
Language
[2] Vocabulary and grammar: 2 = mostly accurate and understandable, some variety; 1 = frequent errors but the message can be understood; 0 = not understandable
Organisation and register
[2] Greeting (¡Hola, Ana!) and closing (¡Hasta luego!) used; informal tú form used consistently; 1 if only one of these features
Accept any logical, original content. Writing below about 40 words: cap the language marks at 1.
Note: Writing marks are awarded on the task, not on perfection: ab initio candidates are rewarded for clear, simple, mostly accurate Spanish. Indicative Language Acquisition criterion levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$C$mq$),
(7, $mq$Writing task. A Spanish penfriend, Carlos, has asked you to introduce yourself. Write an email of 80 to 100 words in Spanish. Include:
- your name, age and where you live
- two people in your family
- two hobbies you like and one you do not like
- a question for Carlos. (8 marks)

(Total 8 marks)$mq$, $mq$Content
[2] Gives name, age and where they live (Me llamo..., tengo ... años, vivo en ...)
[2] Describes two family members (e.g. Mi padre se llama Paul; tengo una hermana pequeña)
[2] Two likes and one dislike (Me gusta..., me encanta..., no me gusta...) and a question for Carlos (1 mark for hobbies, 1 mark for the question)
Language
[1] Correct verb forms (ser, tener, vivir, gustar) and gender agreement in most places
Structure
[1] Greeting and closing used; ideas linked with y, pero, porque

Note: Writing marks are awarded on the task, not on perfection: ab initio candidates are rewarded for clear, simple, mostly accurate Spanish. Indicative Language Acquisition criterion levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
