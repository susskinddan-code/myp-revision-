-- Part 4 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- School and Work > School Subjects and Objects
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$School and Work$mq$, 5, 4 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$School Subjects and Objects$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$School and Work$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$School Subjects and Objects$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does the Spanish word 'la regla' mean in a school context?$mq$, $mq$["ruler","eraser","pencil case","calculator"]$mq$, 0, $mq$La regla is a ruler. The eraser is la goma, the pencil case is el estuche and the calculator is la calculadora.$mq$, $mq$easy$mq$),
($mq$Which English word matches 'el cuaderno'?$mq$, $mq$["pen","backpack","timetable","notebook"]$mq$, 3, $mq$El cuaderno is a notebook. A pen is el bolígrafo, a backpack is la mochila and a timetable is el horario.$mq$, $mq$easy$mq$),
($mq$Which school subject is 'la educación física'?$mq$, $mq$["Geography","Music","Physical Education (PE)","Maths"]$mq$, 2, $mq$La educación física is PE. Remember that física with an accent also appears in la física (physics), so read the full phrase.$mq$, $mq$easy$mq$),
($mq$Choose the correct word to complete the sentence: Me ____ las matemáticas.$mq$, $mq$["gusta","gustan","gusto","gustas"]$mq$, 1, $mq$Las matemáticas is plural, so you need gustan. Use gusta only with singular nouns (Me gusta la música).$mq$, $mq$easy$mq$),
($mq$What do you carry your books and notebooks in? Choose the Spanish word.$mq$, $mq$["la mochila","el estuche","la regla","la pizarra"]$mq$, 0, $mq$La mochila is a backpack. El estuche is a pencil case and la pizarra is the board.$mq$, $mq$easy$mq$),
($mq$Read Lucas's timetable.
Lunes: 9:00 matemáticas, 10:00 inglés, 11:00 recreo, 11:30 historia, 12:30 arte.
Which lesson does Lucas have straight after break on Monday?$mq$, $mq$["inglés","arte","matemáticas","historia"]$mq$, 3, $mq$The break (recreo) is at 11:00 and the next entry, at 11:30, is historia. Arte comes later at 12:30.$mq$, $mq$medium$mq$),
($mq$Read the message.
'Hola Lucía, mañana necesito un bolígrafo, una regla y mi calculadora para matemáticas. ¿Tienes una calculadora?'
Which object is NOT mentioned in the message?$mq$, $mq$["a pen","a ruler","a dictionary","a calculator"]$mq$, 2, $mq$The message names un bolígrafo (pen), una regla (ruler) and una calculadora (calculator). There is no mention of un diccionario.$mq$, $mq$medium$mq$),
($mq$Choose the correct article: ____ geografía es interesante.$mq$, $mq$["El","La","Los","Las"]$mq$, 1, $mq$Geografía ends in -a and is feminine singular, so it takes la. Las would be needed for a plural noun such as las ciencias.$mq$, $mq$medium$mq$),
($mq$Read the sentence: 'Me encanta la música porque es divertida.'
Why does the speaker like music?$mq$, $mq$["It is fun.","It is easy.","It is useful.","It is difficult."]$mq$, 0, $mq$Divertida means fun. Fácil is easy, útil is useful and difícil is difficult.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'I don't like science because it is boring'?$mq$, $mq$["No me gusta las ciencias porque es aburridas.","Me no gusta las ciencias porque son aburrido.","No gusto las ciencias porque son aburridas.","No me gustan las ciencias porque son aburridas."]$mq$, 3, $mq$Las ciencias is plural, so you need gustan, son and the feminine plural aburridas. The 'no' goes before me gustan.$mq$, $mq$medium$mq$),
($mq$What is the correct plural of 'el lápiz' (the pencil)?$mq$, $mq$["los lápizes","las lápices","los lápices","los lápiz"]$mq$, 2, $mq$Words ending in -z change z to c before adding -es, and lápiz stays masculine: los lápices. The accent stays on the first a.$mq$, $mq$medium$mq$),
($mq$Read the sign in a school.
'Biblioteca. Silencio, por favor. Abierta de lunes a viernes, de 8:00 a 15:00.'
When is the library open?$mq$, $mq$["Every day of the week","Monday to Friday, in the morning and early afternoon","Only at weekends","Monday to Saturday, in the evening"]$mq$, 1, $mq$De lunes a viernes means Monday to Friday and the hours are 8:00 to 15:00, which is morning and early afternoon.$mq$, $mq$medium$mq$),
($mq$Read the text.
'Mi asignatura favorita es la informática porque el profesor es simpático. No me gusta la educación física porque es muy difícil.'
Which statement is true?$mq$, $mq$["The writer's favourite subject is IT.","The writer likes PE.","The writer thinks IT is difficult.","The writer's teacher is strict."]$mq$, 0, $mq$Mi asignatura favorita es la informática means the favourite subject is IT. The writer does not like PE, and simpático means friendly, not strict.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'Buenos días, soy Marcos. Tengo cinco clases hoy: primero matemáticas, después arte y luego inglés. Después del recreo tengo música y educación física. Mi clase favorita es el arte porque me encanta dibujar.'
Which statement is correct?$mq$, $mq$["He has four classes and his favourite is art.","He has five classes and his favourite is music.","He has five classes and PE is before break.","He has five classes and his favourite is art."]$mq$, 3, $mq$Marcos says tengo cinco clases and mi clase favorita es el arte. PE comes after the break, and music is not his favourite.$mq$, $mq$hard$mq$),
($mq$Choose the correct sentence: 'My teachers (female) are very friendly.'$mq$, $mq$["Mis profesoras son muy simpático.","Mis profesoras son muy simpática.","Mis profesoras son muy simpáticas.","Mis profesoras son muy simpáticos."]$mq$, 2, $mq$Profesoras is feminine plural, so the adjective must be simpáticas. Keep the accent on the á.$mq$, $mq$hard$mq$),
($mq$Read the email.
'Querida Ana: En mi colegio nuevo hay una biblioteca grande. Mi profesor de ciencias se llama señor Ruiz y es muy estricto, pero me gusta porque sus clases son interesantes. Tengo ciencias los martes y los jueves.'
Why does the writer like Mr Ruiz's lessons?$mq$, $mq$["Because he is very strict, so the class is quiet.","Because the lessons are interesting, even though he is strict.","Because the school library is big.","Because there is science every day."]$mq$, 1, $mq$The word pero (but) signals contrast: he is strict, but the writer likes the lessons because they are interesting. Science is only on Tuesdays and Thursdays.$mq$, $mq$hard$mq$),
($mq$You are asking a friend for equipment. Which sentence says 'I need a ruler and an eraser'?$mq$, $mq$["Necesito una regla y una goma.","Necesito un regla y una goma.","Necesitas una regla y una goma.","Necesito una reglas y una goma."]$mq$, 0, $mq$Regla and goma are both feminine singular, so una is correct for both. Necesitas means 'you need', and una reglas mixes singular and plural.$mq$, $mq$hard$mq$),
($mq$Read the opinion.
'Odio las matemáticas porque son difíciles, pero me gusta la informática porque es útil.'
Which pair of reasons is correct?$mq$, $mq$["Maths is useful; IT is difficult.","Maths is boring; IT is fun.","Maths is easy; IT is useful.","Maths is difficult; IT is useful."]$mq$, 3, $mq$Difíciles means difficult (maths) and útil means useful (IT). Odio means I hate, so the first opinion is negative and the second positive.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$School Subjects and Objects$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$las matemáticas$mq$, $mq$maths (always plural, so: Me gustan las matemáticas)$mq$),
($mq$el cuaderno / el bolígrafo$mq$, $mq$the notebook / the pen$mq$),
($mq$la regla / la goma$mq$, $mq$the ruler / the eraser$mq$),
($mq$la mochila$mq$, $mq$the backpack$mq$),
($mq$How do you say 'My favourite subject is art'?$mq$, $mq$Mi asignatura favorita es el arte.$mq$),
($mq$Me gusta vs. Me gustan$mq$, $mq$Me gusta + singular noun (la música); me gustan + plural noun (las ciencias).$mq$),
($mq$porque es aburrido$mq$, $mq$because it is boring (use aburrida with a feminine subject)$mq$),
($mq$el recreo$mq$, $mq$break time (playtime)$mq$),
($mq$los lunes vs. el lunes$mq$, $mq$los lunes = on Mondays (every week); el lunes = on Monday (one day)$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$School Subjects and Objects$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## School subjects (las asignaturas)
In Spanish, school subjects are called las asignaturas or las materias. Most are feminine, and some are plural, so watch the article.
- las matemáticas (maths) – always plural
- el inglés (English), el español (Spanish), el francés (French)
- la historia (history), la geografía (geography)
- las ciencias (science), la biología (biology), la física (physics), la química (chemistry)
- la educación física (PE), el arte (art), la música (music), el dibujo (drawing)
- la informática (IT), la tecnología (technology), el teatro (drama)

## School objects (los objetos de clase)
- el libro (book), el cuaderno (notebook), el bolígrafo (pen), el lápiz (pencil; plural: los lápices)
- la regla (ruler), la goma (eraser), el sacapuntas (pencil sharpener), las tijeras (scissors), el pegamento (glue)
- la mochila (backpack), el estuche (pencil case), la carpeta (folder), la calculadora (calculator)
- el ordenador (computer), la tableta (tablet), la pizarra (board), el diccionario (dictionary)
- el profesor / la profesora (teacher), el alumno / la alumna (pupil), el compañero / la compañera (classmate)

## Places and times
- el colegio / el instituto (school), la clase (class or classroom), la biblioteca (library), el patio (playground), el recreo (break), el horario (timetable)
- Days of the week are masculine and have no capital letter: lunes, martes, miércoles, jueves, viernes.
- Los lunes means 'on Mondays' (every week). El lunes means 'on Monday' (one day).
- To say what lessons you have, use tener: Tengo matemáticas a las nueve. Tengo inglés los martes.

## Giving opinions
- Me gusta + singular noun: Me gusta la música.
- Me gustan + plural noun: Me gustan las matemáticas.
- No me gusta... (I don't like), Me encanta... (I love), Odio... (I hate)
- Mi asignatura favorita es... (My favourite subject is...)
- Give a reason with porque + es / son + adjective: fácil (easy), difícil (difficult), aburrido/a (boring), interesante (interesting), divertido/a (fun), útil (useful).

The adjective agrees with the subject: Me gusta el arte porque es divertido. Me gusta la historia porque es interesante. No me gustan las ciencias porque son aburridas.

## Worked example
Look at this model answer: 'Mi asignatura favorita es la música porque es divertida. Tengo música los miércoles a las diez. No me gustan las matemáticas porque son difíciles.' It gives an opinion, a reason, a time and a contrast, all in correct Spanish.

## Common mistakes
- Writing 'Me gusta las matemáticas'. The noun is plural, so use gustan.
- Forgetting accents: matemáticas, bolígrafo, lápiz, inglés, música, física.
- Mixing up false friends: la biblioteca is a library, but la librería is a bookshop.
- Forgetting agreement: la clase es divertida, but el examen es divertido.

## How this is examined
In reading tasks you meet a timetable, a school notice or a short email and answer questions about subjects, times and opinions. In listening tasks a student describes their day, and you must pick out which subject is liked, which is disliked and why. In writing tasks you describe your school day or give opinions about subjects with a reason. Marks reward accurate vocabulary, correct agreement and clear reasons using porque.

Exam tip: Underline the reason word (porque) and the opinion word (me gusta, odio, me encanta) in every text, because questions often ask WHY someone likes or dislikes a subject.$mq$ from st;

-- School and Work > Jobs and Workplaces
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$School and Work$mq$, 5, 4 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Jobs and Workplaces$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$School and Work$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Jobs and Workplaces$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is 'el bombero' in English?$mq$, $mq$["firefighter","police officer","postman","waiter"]$mq$, 0, $mq$El bombero is a firefighter. The police officer is el policía, the postman is el cartero and the waiter is el camarero.$mq$, $mq$easy$mq$),
($mq$What does 'Mi padre es médico' mean?$mq$, $mq$["My father is a nurse.","My mother is a doctor.","My father has a doctor.","My father is a doctor."]$mq$, 3, $mq$Mi padre is my father and médico is a doctor. Spanish does not use un before a job after ser.$mq$, $mq$easy$mq$),
($mq$Complete the sentence with the best workplace: 'El camarero trabaja en un ____.'$mq$, $mq$["hospital","colegio","restaurante","banco"]$mq$, 2, $mq$A waiter (camarero) works in a restaurante. Doctors work in a hospital and teachers in a colegio.$mq$, $mq$easy$mq$),
($mq$'La enfermera' refers to which person?$mq$, $mq$["a male nurse","a female nurse","a dentist","a teacher"]$mq$, 1, $mq$La enfermera is a female nurse (the male nurse is el enfermero). The -a ending and the article la show feminine.$mq$, $mq$easy$mq$),
($mq$What is the feminine form of 'el profesor'?$mq$, $mq$["la profesora","la profesor","la profesoro","las profesor"]$mq$, 0, $mq$Many jobs ending in -or add -a for the feminine: el profesor, la profesora. The article also changes to la.$mq$, $mq$easy$mq$),
($mq$A man says he is a teacher. Which sentence does he use?$mq$, $mq$["Soy profesora.","Estoy profesor.","Tengo profesor.","Soy profesor."]$mq$, 3, $mq$Jobs use the verb ser: Soy profesor. Profesora is the feminine form, and estar and tener do not express a job.$mq$, $mq$medium$mq$),
($mq$Read the advert.
'Se busca camarero. Restaurante La Plaza. Trabajo de viernes a domingo, de 18:00 a 23:00. Tel: 600 123 456.'
When would the person work?$mq$, $mq$["Monday to Friday mornings","Every day at lunchtime","Friday to Sunday evenings","Weekends in the morning"]$mq$, 2, $mq$De viernes a domingo is Friday to Sunday and 18:00 to 23:00 is the evening. Se busca means 'wanted'.$mq$, $mq$medium$mq$),
($mq$'Trabaja en un hospital y ayuda a los enfermos.' Who is being described?$mq$, $mq$["una jardinera","una doctora","una peluquera","una dependienta"]$mq$, 1, $mq$A person who works in a hospital and helps sick people (los enfermos) is a doctor, una doctora. The other jobs are gardener, hairdresser and shop assistant.$mq$, $mq$medium$mq$),
($mq$What is the feminine form of 'el dentista'?$mq$, $mq$["la dentista","la dentisa","la dentisto","las dentista"]$mq$, 0, $mq$Jobs ending in -ista keep the same form for both genders. Only the article changes: el dentista, la dentista.$mq$, $mq$medium$mq$),
($mq$Read the text.
'Mi tía Carmen es peluquera. Trabaja en una peluquería en el centro. Le gusta su trabajo porque habla con mucha gente.'
Why does Carmen like her job?$mq$, $mq$["She earns a lot of money.","She works in the evening.","She works from home.","She talks to many people."]$mq$, 3, $mq$Porque habla con mucha gente means because she talks with many people. There is no mention of money or of working at home.$mq$, $mq$medium$mq$),
($mq$Which question asks 'Where do you work?'$mq$, $mq$["¿Cuándo trabajas?","¿Qué trabajas?","¿Dónde trabajas?","¿Quién trabajas?"]$mq$, 2, $mq$Dónde means where. Cuándo means when, qué means what and quién means who.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Mi hermano ____ en una oficina.'$mq$, $mq$["trabajo","trabaja","trabajas","trabajan"]$mq$, 1, $mq$Mi hermano is he/she, so the verb ends in -a: trabaja. Trabajo is I, trabajas is you and trabajan is they.$mq$, $mq$medium$mq$),
($mq$A girl says: 'Quiero ser veterinaria porque me encantan los animales.' Which statement is true?$mq$, $mq$["She wants to be a vet because she loves animals.","She is already a vet.","She does not like animals.","Her mother is a vet."]$mq$, 0, $mq$Quiero ser means I want to be, and me encantan los animales means I love animals. Veterinaria is the feminine form of vet.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'Hola, me llamo Pablo. Mi madre es ingeniera y trabaja en una fábrica. Mi padre es cocinero y trabaja por la noche en un restaurante italiano. Yo quiero ser bombero, pero mi hermana quiere ser periodista.'
Who works at night, and where?$mq$, $mq$["His mother, in a factory","His sister, in an office","Pablo, in a fire station","His father, in a restaurant"]$mq$, 3, $mq$Mi padre es cocinero y trabaja por la noche en un restaurante italiano. His mother works in a factory but no time is given, and Pablo only wants to be a firefighter.$mq$, $mq$hard$mq$),
($mq$Which sentence is grammatically correct?$mq$, $mq$["Las enfermero trabajan en el hospital.","Los enfermeras trabajan en el hospital.","Las enfermeras trabajan en el hospital.","Las enfermeras trabaja en el hospital."]$mq$, 2, $mq$Article, noun and verb must all agree: las (feminine plural), enfermeras (feminine plural) and trabajan (they).$mq$, $mq$hard$mq$),
($mq$Read the advert.
'Se necesita dependienta para tienda de ropa. Buen salario. Horario: lunes a sábado, de 10:00 a 14:00. Con experiencia.'
Which statement matches the advert?$mq$, $mq$["The shop needs a cook to work in the evenings.","The shop needs a female assistant for Monday to Saturday mornings, with experience.","The shop needs a male driver for weekends.","The shop needs a hairdresser with no experience."]$mq$, 1, $mq$Dependienta is a female shop assistant, the hours 10:00 to 14:00 are morning hours, and con experiencia means with experience.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'My sister is a lawyer and works in an office'?$mq$, $mq$["Mi hermana es abogada y trabaja en una oficina.","Mi hermana es abogado y trabaja en una oficina.","Mi hermana está abogada y trabaja en una oficina.","Mi hermana es abogada y trabajan en una oficina."]$mq$, 0, $mq$Use ser for a job, the feminine abogada for a woman, and trabaja for she works. The other options have the wrong gender, the wrong verb or the wrong person.$mq$, $mq$hard$mq$),
($mq$A boy says he wants to be a male nurse when he grows up. Which sentence is correct?$mq$, $mq$["De mayor quiero estar enfermero.","De mayor quiero ser enfermera.","De mayor quiero tener enfermero.","De mayor quiero ser enfermero."]$mq$, 3, $mq$Use querer + ser for a future job, and the masculine enfermero for a boy. Enfermera would be feminine, and estar or tener cannot express a job.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Jobs and Workplaces$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$el médico / la médica$mq$, $mq$the doctor (male / female)$mq$),
($mq$el camarero / la camarera$mq$, $mq$the waiter / the waitress$mq$),
($mq$el policía, el dentista, el periodista$mq$, $mq$Jobs that keep the same form for men and women: only the article changes (la policía, la dentista).$mq$),
($mq$How do you say 'I am a student'?$mq$, $mq$Soy estudiante. (No un/una after ser with a job.)$mq$),
($mq$Mi madre trabaja en un hospital.$mq$, $mq$My mother works in a hospital.$mq$),
($mq$¿En qué trabajas?$mq$, $mq$What do you do for a living? / What is your job?$mq$),
($mq$De mayor quiero ser veterinaria.$mq$, $mq$When I am older I want to be a vet.$mq$),
($mq$la fábrica / la oficina / la tienda$mq$, $mq$the factory / the office / the shop$mq$),
($mq$trabajar: I, he/she, they$mq$, $mq$trabajo, trabaja, trabajan$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Jobs and Workplaces$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Jobs (las profesiones)
In Spanish, most jobs have a masculine and a feminine form. Learn them in pairs.
- el médico / la médica (doctor; also el doctor / la doctora), el enfermero / la enfermera (nurse)
- el profesor / la profesora (teacher), el camarero / la camarera (waiter)
- el cocinero / la cocinera (cook), el abogado / la abogada (lawyer)
- el ingeniero / la ingeniera (engineer), el dependiente / la dependienta (shop assistant)
- el peluquero / la peluquera (hairdresser), el cartero / la cartera (postman / postwoman)
- el bombero / la bombera (firefighter), el mecánico / la mecánica (mechanic)
- el policía / la policía, el dentista / la dentista, el periodista / la periodista (same form for both genders)

## Workplaces (los lugares de trabajo)
- el hospital (hospital), el colegio (school), el restaurante (restaurant), la oficina (office)
- la tienda (shop), la fábrica (factory), la comisaría (police station), el taller (garage)
- la peluquería (hairdresser's), el banco (bank), la granja (farm), el parque de bomberos (fire station)

## Saying what someone does
With jobs use ser, and do not use un or una:
- Mi padre es médico. (My father is a doctor.)
- Soy estudiante. (I am a student.)
- Mi tía es peluquera. (My aunt is a hairdresser.)

To say where someone works use trabajar en:
- Trabajo en una tienda. (I work in a shop.)
- Mi madre trabaja en un hospital. (My mother works in a hospital.)

Useful verb forms of trabajar: trabajo (I), trabajas (you), trabaja (he/she), trabajamos (we), trabajan (they).

## Asking questions
- ¿En qué trabajas? (What do you do for a living?)
- ¿Dónde trabaja tu padre? (Where does your father work?)
- ¿Qué quieres ser de mayor? (What do you want to be when you are older?)
Answer: De mayor quiero ser veterinaria. (When I am older I want to be a vet.)

## Giving reasons and times
- porque ayudo a la gente (because I help people)
- porque me gustan los animales (because I like animals)
- Trabaja de lunes a viernes. (She works Monday to Friday.)
- Trabaja por la noche. (He works at night.)

## Common mistakes
- Saying 'Soy un médico'. In Spanish you normally say Soy médico.
- Using estar for a job. Use ser: Es dentista, not Está dentista.
- Forgetting to change the ending for a woman: abogada, not abogado.
- Mixing trabajo (I work) with el trabajo (the job).

## How this is examined
Reading tasks often show a job advert, a short profile or an email in which someone describes their family's jobs. You may need to match a person to a job or to a workplace, or find the working hours. Listening tasks give a short interview about jobs. In writing you describe your family's jobs or your dream career, using ser, trabajar en and querer ser with a reason.

Exam tip: When a text mentions a person, check the gender endings (-o / -a), because they tell you whether the text is about a man or a woman and can help you choose the right answer.$mq$ from st;

-- School and Work > Classroom Language and Instructions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$School and Work$mq$, 5, 4 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Classroom Language and Instructions$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$School and Work$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Classroom Language and Instructions$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does the teacher want you to do when she says 'Abre el libro'?$mq$, $mq$["Open the book.","Close the book.","Read the book aloud.","Buy a book."]$mq$, 0, $mq$Abre comes from abrir (to open). Close the book would be Cierra el libro.$mq$, $mq$easy$mq$),
($mq$What does 'Silencio, por favor' mean?$mq$, $mq$["Hello, please.","Sit down, please.","Come in, please.","Be quiet, please."]$mq$, 3, $mq$Silencio is silence, so the teacher asks the class to be quiet.$mq$, $mq$easy$mq$),
($mq$What do you do when you hear the instruction 'Escucha'?$mq$, $mq$["write","read","listen","speak"]$mq$, 2, $mq$Escucha comes from escuchar (to listen). Escribe is write, lee is read and habla is speak.$mq$, $mq$easy$mq$),
($mq$A student asks '¿Puedo ir al baño?' What is the student asking?$mq$, $mq$["May I go home?","May I go to the toilet?","May I open the window?","May I have a pen?"]$mq$, 1, $mq$Puedo ir means 'can I go' and al baño is to the toilet/bathroom.$mq$, $mq$easy$mq$),
($mq$Your teacher says 'Gracias.' What do you answer?$mq$, $mq$["De nada.","Lo siento.","Hasta luego.","Buenas noches."]$mq$, 0, $mq$De nada means 'you're welcome', which is the standard reply to gracias. Lo siento means I'm sorry.$mq$, $mq$easy$mq$),
($mq$The teacher says: 'Abre tu cuaderno en la página 24 y haz el ejercicio tres.' What must you do?$mq$, $mq$["Close your notebook and read page 24.","Open your book at page 3 and do exercise 24.","Write your name on page 24 of the book.","Open your notebook at page 24 and do exercise 3."]$mq$, 3, $mq$Abre tu cuaderno en la página 24 means open your notebook at page 24, and haz el ejercicio tres means do exercise three.$mq$, $mq$medium$mq$),
($mq$You did not hear what the teacher said. Which phrase asks her to say it again?$mq$, $mq$["¿Puedo salir, por favor?","Lo siento, llego tarde.","¿Puede repetir, por favor?","¿Cómo te llamas?"]$mq$, 2, $mq$¿Puede repetir, por favor? means 'Can you repeat, please?' The others ask to leave, apologise for being late or ask someone's name.$mq$, $mq$medium$mq$),
($mq$In an exam you read: 'Escoge la respuesta correcta.' What do you have to do?$mq$, $mq$["Write the answer in full.","Choose the correct answer.","Copy the question.","Underline the verbs."]$mq$, 1, $mq$Escoge comes from escoger (to choose), and la respuesta correcta is the correct answer.$mq$, $mq$medium$mq$),
($mq$The instruction says: 'Une las palabras con los dibujos.' What is the task?$mq$, $mq$["Match the words to the pictures.","Draw pictures of the words.","Colour the pictures.","Write the words in a list."]$mq$, 0, $mq$Unir means to join or match, so you link each word to its picture.$mq$, $mq$medium$mq$),
($mq$Which question asks 'How do you say "pencil" in Spanish?'$mq$, $mq$["¿Cuándo se dice 'pencil' en español?","¿Dónde se dice 'pencil' en español?","¿Quién se dice 'pencil' en español?","¿Cómo se dice 'pencil' en español?"]$mq$, 3, $mq$¿Cómo se dice...? asks how to say something. Cuándo is when, dónde is where and quién is who.$mq$, $mq$medium$mq$),
($mq$Read the notice.
'Prohibido usar el móvil en clase. Los móviles están en la mochila.'
Where must phones be kept?$mq$, $mq$["On the teacher's desk","In the locker","In the bag","In your pocket"]$mq$, 2, $mq$Los móviles están en la mochila means that the phones are in the backpack. Prohibido usar el móvil means mobile use is forbidden.$mq$, $mq$medium$mq$),
($mq$You arrive late to class. Which phrase is most suitable to say to your teacher?$mq$, $mq$["Gracias, hasta luego.","Lo siento, llego tarde.","De nada, profesora.","Buenas noches, profesora."]$mq$, 1, $mq$Lo siento, llego tarde means 'I'm sorry, I'm late'. The other phrases are goodbye, you're welcome and good night, none of which apologise.$mq$, $mq$medium$mq$),
($mq$Which pair of instruction and meaning is correct?$mq$, $mq$["Levántate = Stand up","Siéntate = Stand up","Copia = Listen","Borra = Read"]$mq$, 0, $mq$Levántate means stand up. Siéntate means sit down, copia means copy, and borra means rub out or delete.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'Buenos días a todos. Hoy trabajamos en parejas. Primero, lee el texto de la página 40. Después, contesta las preguntas en tu cuaderno. No uses el diccionario. Si tienes una pregunta, levanta la mano.'
What are you told NOT to do?$mq$, $mq$["Read page 40.","Work with a partner.","Raise your hand.","Use the dictionary."]$mq$, 3, $mq$No uses el diccionario means do not use the dictionary. The other three are instructions the teacher gives you to do.$mq$, $mq$hard$mq$),
($mq$An exam rubric says: 'Completa las frases con una palabra del recuadro. Hay una palabra extra.' What does the last sentence tell you?$mq$, $mq$["You need to add an extra word to each sentence.","You must write one more sentence.","One word in the box is not needed.","Every word in the box is used twice."]$mq$, 2, $mq$Hay una palabra extra means there is one extra word, so one word in the box will not fit any gap.$mq$, $mq$hard$mq$),
($mq$Read the dialogue.
'Alumno: Perdone, profesora, no entiendo el ejercicio cuatro. Profesora: Lee otra vez la instrucción y mira el ejemplo. Alumno: Vale, gracias.'
What does the teacher tell the student to do?$mq$, $mq$["Ask a classmate for help.","Read the instruction again and look at the example.","Leave the classroom.","Do exercise four on the board."]$mq$, 1, $mq$Lee otra vez la instrucción means read the instruction again, and mira el ejemplo means look at the example. No entiendo means I don't understand.$mq$, $mq$hard$mq$),
($mq$You want to know how to spell a word. Which question do you ask?$mq$, $mq$["¿Cómo se escribe?","¿Cómo se llama?","¿Cómo estás?","¿Cómo se dice?"]$mq$, 0, $mq$¿Cómo se escribe? means 'How do you write/spell it?'. ¿Cómo se dice? asks how to say something, and ¿Cómo se llama? asks for a name.$mq$, $mq$hard$mq$),
($mq$You are very cold and want the teacher's permission to close the window. Which is the most polite and correct request?$mq$, $mq$["Cierro la ventana.","Cierra la ventana ahora.","La ventana es cerrada.","¿Puedo cerrar la ventana, por favor?"]$mq$, 3, $mq$¿Puedo + infinitive, por favor? is the standard polite way to ask permission. The other options are a statement, an order or a wrong structure.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Classroom Language and Instructions$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Abre el libro. / Cierra el libro.$mq$, $mq$Open the book. / Close the book.$mq$),
($mq$Siéntate / Levántate$mq$, $mq$Sit down / Stand up$mq$),
($mq$¿Puede repetir, por favor?$mq$, $mq$Can you repeat, please?$mq$),
($mq$No entiendo.$mq$, $mq$I don't understand.$mq$),
($mq$¿Cómo se dice 'ruler' en español?$mq$, $mq$How do you say 'ruler' in Spanish?$mq$),
($mq$Escoge la respuesta correcta.$mq$, $mq$Choose the correct answer.$mq$),
($mq$Une las palabras con los dibujos.$mq$, $mq$Match the words to the pictures.$mq$),
($mq$Lo siento, llego tarde.$mq$, $mq$Sorry, I'm late.$mq$),
($mq$¿Puedo ir al baño?$mq$, $mq$May I go to the toilet?$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Classroom Language and Instructions$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Classroom instructions
Teachers give instructions using the imperative (the command form). In the singular tú form most commands look like the he/she present tense form, for example abre (open). You need to understand these instructions, and also use polite phrases yourself.
- Abre el libro / el cuaderno. (Open the book / the notebook.)
- Cierra el libro. (Close the book.)
- Escucha. (Listen.) Lee. (Read.) Escribe. (Write.)
- Mira la pizarra. (Look at the board.)
- Repite, por favor. (Repeat, please.)
- Contesta las preguntas. (Answer the questions.)
- Copia las frases. (Copy the sentences.)
- Siéntate. (Sit down.) Levántate. (Stand up.)
- Trabaja con tu compañero / en parejas. (Work with your partner / in pairs.)
- Haz el ejercicio tres. (Do exercise three.) Haz is an irregular command from hacer.
- Presta atención. (Pay attention.) Silencio, por favor. (Quiet, please.)
- Levanta la mano. (Raise your hand.)

## Exam instructions
The eAssessment instructions are mostly in the target language, so learn these:
- Lee el texto. (Read the text.)
- Escoge la respuesta correcta. (Choose the correct answer.)
- Completa las frases. (Complete the sentences.)
- Une las palabras con los dibujos. (Match the words to the pictures.)
- Marca con una cruz. (Mark with a cross.)
- Verdadero o falso. (True or false.)
- Escribe una respuesta de tres frases. (Write an answer of three sentences.)
- Hay una palabra extra. (There is an extra word.)

## What students say
- ¿Puedo ir al baño? (May I go to the toilet?)
- ¿Puedo abrir la ventana, por favor? (May I open the window, please?)
- ¿Puede repetir, por favor? (Can you repeat, please?)
- No entiendo. (I don't understand.) / Más despacio, por favor. (More slowly, please.)
- ¿Cómo se dice 'pencil' en español? (How do you say 'pencil' in Spanish?)
- ¿Qué significa...? (What does ... mean?) / ¿Cómo se escribe? (How do you spell it?)
- Tengo una pregunta. (I have a question.)
- Lo siento, llego tarde. (Sorry, I'm late.)
- No tengo mi cuaderno. (I don't have my notebook.)
- Gracias. / De nada. (Thank you. / You're welcome.)

## Be polite
Use por favor (please) and perdone (excuse me) or perdón. Use ¿Puedo...? followed by an infinitive to ask permission: ¿Puedo salir? (May I leave?).

## Common mistakes
- Confusing levántate (stand up) with siéntate (sit down).
- Forgetting that ¿Puedo...? is followed by the infinitive, not a conjugated verb.
- Using lo siento (I'm sorry) when you mean gracias.
- Missing the inverted question mark at the start of a question.

## How this is examined
Reading tasks present instructions on a classroom notice, a rubric or a worksheet and ask what you should do. Listening tasks may play a teacher giving instructions, so you must identify what to do and what not to do. In writing you may need to ask for help or explain a problem in a short message, using polite structures.

Exam tip: Look for the word no in an instruction (No uses el diccionario). It reverses the meaning completely, and examiners like to test it.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;