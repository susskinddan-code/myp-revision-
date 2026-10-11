-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Spanish ab initio MYP 5 eAssessment-style Practice Paper 2 (51 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish ab initio MYP 5 eAssessment-style Practice Paper 2$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish ab initio MYP 5 eAssessment-style Practice Paper 2$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Listening transcript (imagine you hear this conversation twice). Read it, then answer in English.

En la estación
Cliente: Buenos días, quiero un billete para Valencia, por favor.
Empleado: ¿De ida o de ida y vuelta?
Cliente: De ida y vuelta. Salgo mañana por la mañana y vuelvo el domingo.
Empleado: Hay un tren a las siete y diez y otro a las nueve y cuarenta.
Cliente: Prefiero el de las nueve y cuarenta. ¿Cuánto cuesta?
Empleado: Cuarenta y cinco euros. ¿Paga con tarjeta o en efectivo?
Cliente: Con tarjeta. ¿De qué andén sale?
Empleado: Del andén número cuatro.

(a) Where does the customer want to go? (1 mark)
(b) What type of ticket does he buy? (1 mark)
(c) On which day does he come back? (1 mark)
(d) Which train does he choose? (1 mark)
(e) How much does the ticket cost? (1 mark)
(f) How does he pay? (1 mark)
(g) From which platform does the train leave? (1 mark)

(Total 7 marks)$mq$, $mq$(a) [1] Valencia
(b) [1] Return (round-trip) ticket
(c) [1] Sunday
(d) [1] The 9.40 train (accept 09:40)
(e) [1] 45 euros
(f) [1] By card
(g) [1] Platform 4$mq$, $mq$A$mq$),
(2, $mq$Listening transcript (imagine you hear this weather forecast twice). Read it, then answer in English.

« Este es el tiempo para mañana. En el norte llueve por la mañana, pero por la tarde hace buen tiempo. En el sur hace mucho calor: treinta y dos grados. En el este hace viento y nieva en las montañas. En el oeste el cielo está nublado. Para el fin de semana, se espera sol en todas partes. »

(a) What is the weather in the north in the morning? (1 mark)
(b) What is the temperature in the south? (1 mark)
(c) What is happening in the mountains in the east? (1 mark)
(d) Which region is windy? (1 mark)
(e) What is the sky like in the west? (1 mark)
(f) What weather is forecast for the weekend? (1 mark)

(Total 6 marks)$mq$, $mq$(a) [1] Rain / it is raining
(b) [1] 32 degrees
(c) [1] It is snowing
(d) [1] The east
(e) [1] Cloudy
(f) [1] Sunny everywhere / sun in all regions$mq$, $mq$A$mq$),
(3, $mq$Read this poster, then answer the questions in English.

CLUB DE TEATRO – Instituto Miguel Hernández
¿Te gusta actuar, cantar o bailar? ¡Apúntate!
¿Cuándo? Los miércoles, de 14:00 a 16:00.
¿Dónde? En el salón de actos (no en el gimnasio).
Precio: gratis para los alumnos del instituto; 15 € al año para los demás.
La función de fin de curso es el 12 de junio.
Hay que traer ropa cómoda.
Inscripciones con la señora Rocha, en la secretaría, antes del 30 de septiembre.

(a) Name two activities mentioned in the poster. (2 marks)
(b) On which day and at what times does the club meet? (2 marks)
(c) How much do students from other schools pay? (1 mark)
(d) What should members bring? (1 mark)
(e) Who must you see to register, and by when? (2 marks)

(Total 8 marks)$mq$, $mq$(a) [1] Any one of: acting / singing / dancing
[1] A different one of these
(b) [1] Wednesday
[1] 2 pm to 4 pm (14:00-16:00)
(c) [1] 15 euros (a year)
(d) [1] Comfortable clothes
(e) [1] Señora Rocha (at the school office)
[1] Before 30 September$mq$, $mq$B$mq$),
(4, $mq$Read this blog post, then answer the questions in English.

Mi fin de semana en la playa
El sábado fuimos a la playa en coche. Había mucha gente porque hacía mucho calor. Nadé en el mar y luego comí un helado de fresa con mi prima Inés. Por la tarde jugamos al voleibol. Por desgracia, olvidé la crema solar y me quemé. El domingo me quedé en casa para hacer los deberes y ver una película. La semana que viene vamos a visitar un castillo.

(a) How did the writer travel to the beach? (1 mark)
(b) Why was the beach crowded? (1 mark)
(c) Give two things the writer did at the beach. (2 marks)
(d) What went wrong at the beach? (1 mark)
(e) What did the writer do on Sunday? Give two details. (2 marks)
(f) What are they going to do next week? (1 mark)

(Total 8 marks)$mq$, $mq$(a) [1] By car
(b) [1] Because it was very hot
(c) [1] Any one of: swam in the sea / ate a strawberry ice cream / played volleyball
[1] A different one of these
(d) [1] The writer forgot the sun cream and got sunburnt
(e) [1] Stayed at home
[1] Any one of: did homework / watched a film
(f) [1] Visit a castle$mq$, $mq$B$mq$),
(5, $mq$Complete each sentence with the correct Spanish word or form. Write only the missing word(s).

(a) María ______ (tomar) el autobús para ir al instituto. (1 mark)
(b) Nosotros ______ (hacer) los deberes después de la cena. (1 mark)
(c) Yo no ______ (tener) hermanos. (1 mark)
(d) ______ gato se llama Moka. (my) (1 mark)
(e) Put this sentence into the negative: Él come carne. (1 mark)
(f) Write in Spanish: I play tennis on Saturdays. (1 mark)

(Total 6 marks)$mq$, $mq$(a) [1] toma
(b) [1] hacemos
(c) [1] tengo
(d) [1] Mi
(e) [1] Él no come carne.
(f) [1] Juego al tenis los sábados. (accept: Juego al tenis todos los sábados)$mq$, $mq$D$mq$),
(6, $mq$Writing task. You are organising your birthday party. Write an invitation message of about 60 words in Spanish to your friend Leo. In your message:
- say when the party is and where
- say what time it starts
- say what food and drink there will be
- ask Leo to reply. (8 marks)

(Total 8 marks)$mq$, $mq$Communication (task points)
[1] Says when the party is (e.g. el sábado 14 de mayo) and where (e.g. en mi casa / en el parque)
[1] Says what time it starts (e.g. a las seis de la tarde)
[1] Says what food and drink there will be (e.g. Hay pizza y zumo de naranja)
[1] Asks Leo to reply (e.g. ¡Contesta pronto! / ¿Puedes venir?)
Language
[2] Vocabulary and grammar: 2 = mostly accurate and understandable, some variety; 1 = frequent errors but the message can be understood; 0 = not understandable
Organisation and register
[2] Greeting (¡Hola, Leo!) and closing (¡Hasta pronto!) used; informal tú form used consistently; 1 if only one of these features
Writing below about 40 words: cap the language marks at 1.
Note: Writing marks are awarded on the task, not on perfection: ab initio candidates are rewarded for clear, simple, mostly accurate Spanish. Indicative Language Acquisition criterion levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$C$mq$),
(7, $mq$Writing task. A Spanish exchange student has asked about the town where you live. Write an email of 80 to 100 words in Spanish. Include:
- the name of your town and where it is
- two places in the town and what you do there
- what you did last weekend
- an invitation for the student to visit. (8 marks)

(Total 8 marks)$mq$, $mq$Content
[2] Names the town and says where it is (e.g. Vivo en Camden, está en el norte de Londres)
[2] Two places and activities (e.g. Hay un parque donde juego al fútbol; hay un cine)
[1] Says what they did last weekend (simple past or a clear attempt, e.g. El sábado vi una película)
[1] Invitation to visit (e.g. ¿Quieres venir a mi casa en verano?)
Language
[1] Correct verb forms (tener, ser, ir, jugar) and agreement in most places
Structure
[1] Greeting and closing used; ideas linked with y, pero, porque

Note: Writing marks are awarded on the task, not on perfection: ab initio candidates are rewarded for clear, simple, mostly accurate Spanish. Indicative Language Acquisition criterion levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
