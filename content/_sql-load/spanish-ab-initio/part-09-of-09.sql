-- Part 9 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- eAssessment Skills for Languages > Reading Comprehension Strategies
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Languages$mq$, 5, 9 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Reading Comprehension Strategies$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Languages$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Reading Comprehension Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the best first step when you start a reading task?$mq$, $mq$["Read the questions and look at the title and text type","Translate every word of the text","Skip the questions until you finish","Guess answers without reading"]$mq$, 0, $mq$Previewing the questions and the text type tells you what to look for, so your reading has a purpose.$mq$, $mq$easy$mq$),
($mq$A word in a text looks like English: 'la información'. What is the best guess?$mq$, $mq$["informer","inflation","interview","information"]$mq$, 3, $mq$Many Spanish words are cognates, which look and mean almost the same as English words. La información means information.$mq$, $mq$easy$mq$),
($mq$Read the notice.
'Se vende bicicleta. 50 euros. Llamar al 600 123 456.'
What type of text is this?$mq$, $mq$["A recipe","A timetable","An advertisement","A school report"]$mq$, 2, $mq$Se vende means 'for sale', and the text gives a price and a phone number, which is typical of an advertisement.$mq$, $mq$easy$mq$),
($mq$Which English word matches 'la biblioteca'?$mq$, $mq$["bookshop","library","school","desk"]$mq$, 1, $mq$La biblioteca is a library. It is a false friend of bookshop, which is la librería.$mq$, $mq$easy$mq$),
($mq$The text says: 'No hay clases el viernes.' Is this statement true or false? 'There are classes on Friday.'$mq$, $mq$["False","True","Not mentioned","True only in the morning"]$mq$, 0, $mq$No hay clases means there are no classes, so the statement is false.$mq$, $mq$easy$mq$),
($mq$Read the message.
'Hola Marta: El sábado voy a la piscina con Pablo a las diez. ¿Quieres venir? Mándame un mensaje. Un abrazo, Eva.'
What is Eva asking Marta?$mq$, $mq$["To lend her a swimsuit","To meet at ten at school","To call Pablo","Whether she wants to come to the pool"]$mq$, 3, $mq$¿Quieres venir? means 'Do you want to come?' and Mándame un mensaje means 'send me a message'. Un abrazo is just a friendly sign-off.$mq$, $mq$medium$mq$),
($mq$Read the notice.
'Abrimos de lunes a viernes de 9:00 a 17:00. Los sábados abrimos solo por la mañana.'
Can you visit on Saturday at 3 p.m.?$mq$, $mq$["Yes, it is open until 17:00","Yes, it is open all day","No, it is only open on Saturday mornings","No, it is closed on Saturdays"]$mq$, 2, $mq$The shop is open on Saturdays, but solo por la mañana means only in the morning. The 9:00 to 17:00 hours apply Monday to Friday.$mq$, $mq$medium$mq$),
($mq$You find an unknown word in a text. What is the best approach?$mq$, $mq$["Stop and leave the question blank","Use the context and similar words, then keep reading","Translate every word in the sentence","Change the meaning of the question"]$mq$, 1, $mq$Context clues and words you already know often give enough meaning, and you do not need every word to answer.$mq$, $mq$medium$mq$),
($mq$Read the information.
'Las entradas cuestan quince euros para adultos y ocho euros para niños.'
How much do two adults and one child pay?$mq$, $mq$["38 euros","23 euros","31 euros","30 euros"]$mq$, 0, $mq$Two adults pay 2 × 15 = 30 euros, plus 8 euros for the child gives 38. The answer 23 only counts one adult.$mq$, $mq$medium$mq$),
($mq$You need to find the departure time of a train in a timetable. Which technique is most useful?$mq$, $mq$["Reading every line slowly","Translating the whole timetable","Looking only at the headline","Scanning for the place name and the numbers"]$mq$, 3, $mq$Scanning means looking quickly for specific key words or numbers. A timetable is made for this.$mq$, $mq$medium$mq$),
($mq$Read the message.
'Querida Ana: Gracias por la invitación. Lo siento, no puedo ir a tu fiesta porque tengo un examen el lunes. ¡Que lo pases bien!'
Why can the writer not go to the party?$mq$, $mq$["Because she is ill","Because she is travelling","Because of an exam on Monday","Because she has no invitation"]$mq$, 2, $mq$Porque introduces the reason: tengo un examen el lunes. Lo siento means 'I am sorry'.$mq$, $mq$medium$mq$),
($mq$Read the text.
'Hace mucho frío y llevo bufanda y guantes.'
Which season is it most likely?$mq$, $mq$["Summer (verano)","Winter (invierno)","Spring (primavera)","Autumn (otoño)"]$mq$, 1, $mq$Hace mucho frío means it is very cold, and a scarf and gloves also suggest winter. Using clues like this is called inference.$mq$, $mq$medium$mq$),
($mq$Read the text.
'Me gusta el fútbol, pero prefiero el tenis.'
Which sport does the writer prefer?$mq$, $mq$["Tennis","Football","Both equally","Neither"]$mq$, 0, $mq$Pero signals a contrast, and prefiero el tenis says tennis is preferred.$mq$, $mq$medium$mq$),
($mq$Read the text.
'Normalmente voy al colegio en autobús, pero hoy voy a pie porque el autobús llega tarde.'
Why does the writer walk today?$mq$, $mq$["The bus is full","It is a sunny day","The school is close","The bus is late"]$mq$, 3, $mq$Voy a pie means 'I go on foot', and porque el autobús llega tarde means because the bus arrives late.$mq$, $mq$hard$mq$),
($mq$Read the notice.
'El museo está cerrado los lunes. El martes es gratis para estudiantes. Los otros días la entrada cuesta seis euros.'
A student visits on Tuesday. How much does the student pay?$mq$, $mq$["6 euros","3 euros","Nothing, it is free","The museum is closed"]$mq$, 2, $mq$Gratis means free, and the notice says Tuesday is free for students. Six euros is the price for the other days.$mq$, $mq$hard$mq$),
($mq$Read the text.
'Lola está contenta porque mañana empiezan las vacaciones.'
Why is Lola happy?$mq$, $mq$["The holidays ended yesterday","The holidays start tomorrow","She has won a prize","She is going to a party"]$mq$, 1, $mq$Mañana empiezan las vacaciones means the holidays begin tomorrow. Do not confuse mañana (tomorrow) with the morning.$mq$, $mq$hard$mq$),
($mq$After choosing an answer in a reading task, what is the most reliable way to check it?$mq$, $mq$["Find the exact words in the text that support it","Choose the longest option","Check that it sounds familiar","Pick the answer that mentions a number"]$mq$, 0, $mq$A correct answer must be supported by the text. Going back to the evidence avoids falling for distractors.$mq$, $mq$hard$mq$),
($mq$Read the text.
'Mi hermana tiene tres años más que yo. Yo tengo doce años.'
How old is the writer's sister?$mq$, $mq$["9","12","3","15"]$mq$, 3, $mq$Más que means 'more than', so the sister is 12 + 3 = 15. The numbers 12 and 3 are both in the text but neither is the answer.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Reading Comprehension Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Cognate$mq$, $mq$A word that looks like and means almost the same as an English word, such as la información (information) or el restaurante.$mq$),
($mq$False friend: la biblioteca$mq$, $mq$It means library, not bookshop. A bookshop is la librería.$mq$),
($mq$False friend: simpático$mq$, $mq$It means nice or friendly, not sympathetic.$mq$),
($mq$Scanning$mq$, $mq$Looking quickly for specific details such as numbers, names, times or prices, without reading every word.$mq$),
($mq$Skimming$mq$, $mq$Reading quickly for the general idea, using the title, first line and last line.$mq$),
($mq$porque, pero, también$mq$, $mq$because, but, also. Link words help you follow reasons, contrasts and extra information.$mq$),
($mq$Why do negatives matter?$mq$, $mq$No abre los lunes means it does NOT open on Mondays. Missing no, nunca or nadie flips the meaning.$mq$),
($mq$¿Cuánto? ¿Cuándo? ¿Por qué?$mq$, $mq$How much? When? Why? They tell you whether to look for a price, a time or a reason.$mq$),
($mq$How to check an answer$mq$, $mq$Go back to the text and find the exact words that support your choice. Do not choose an answer just because one word matches.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Reading Comprehension Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why reading strategies matter
At ab initio level you will not know every word, and the real eAssessment does not expect you to. It tests whether you can find the right information in a short text, such as a message, a sign, an advertisement, a menu or a timetable. Good strategies often win more marks than a big vocabulary.

## Before you read
- Look at the text type. A notice, an email, a menu and a timetable each have familiar words. A message starts with Hola or Querida and ends with Un abrazo or Hasta pronto.
- Read the questions first. They tell you what to hunt for: a time, a place, a price, a reason, an opinion.
- Notice the command word in English: "State", "Identify", "Explain why".

## While you read
- **Scan** for numbers, names and key words. Use this for timetables and prices.
- **Skim** for the main idea. Read the first and last sentences and any title.
- Use **cognates**, words that look like English: el restaurante, la información, importante, el teléfono.
- Beware of **false friends**: la biblioteca (library, not bookshop), simpático (nice, not sympathetic), el éxito (success, not exit).
- Use **context clues** and your knowledge of word families. If you know trabajar (to work), then el trabajo is probably work or job.
- Look for **link words**: porque (because), pero (but), y (and), también (also), además (as well), nunca (never).
- Spot **negatives**. No abre los domingos is the opposite of abre los domingos.

## Watching out for distractors
Exam writers often include numbers or details that are true in the text but do not answer the question. For example, in 'Mi hermana tiene tres años más que yo. Yo tengo doce años' you must add before answering. Always check exactly who or what the question is about and which time or day it asks about.

## A quick method
1. Read the question. 2. Find the matching part of the text. 3. Read that part twice. 4. Choose the answer supported by the words. 5. Check you have answered what was asked.

## Common mistakes
- Trying to translate every word and running out of time.
- Choosing an answer because one word in it appears in the text.
- Ignoring words such as no, nunca, solo and menos.
- Mixing up days, times and numbers.

## How this is examined
Reading tasks usually give a short, simple text and ask multiple-choice questions about detail, reason or opinion. You might also see true or false statements. The answer is nearly always stated or can be worked out from a clear clue in the text.

Exam tip: Underline the word in the question that tells you what to find (who, when, why, how much), then look for words of that type in the text. If you cannot find the exact word, look for a close one with a similar meaning.$mq$ from st;

-- eAssessment Skills for Languages > Listening Text Strategies
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Languages$mq$, 5, 9 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Listening Text Strategies$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Languages$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Listening Text Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What should you do before the audio begins in a listening task?$mq$, $mq$["Read the questions and predict the kind of words you will hear","Close your eyes and wait","Write a summary of the topic","Translate the instructions"]$mq$, 0, $mq$Reading the questions first tells you what details to listen for, such as a price, a time or a name.$mq$, $mq$easy$mq$),
($mq$You hear 'quince'. Which number is it?$mq$, $mq$["50","5","14","15"]$mq$, 3, $mq$Quince is 15. Cincuenta is 50, cinco is 5 and catorce is 14.$mq$, $mq$easy$mq$),
($mq$Listening transcript: 'Hola, me llamo Rosa y tengo trece años.'
How old is Rosa?$mq$, $mq$["30","3","13","12"]$mq$, 2, $mq$Trece is 13. Treinta is 30. Do not confuse the endings -ce and -nta.$mq$, $mq$easy$mq$),
($mq$You miss an answer in a listening task. What is best to do?$mq$, $mq$["Stop and wait for the recording again","Move on and write your best guess","Leave the whole task blank","Change your earlier answers"]$mq$, 1, $mq$Stay with the recording. Write a guess, listen for the next question and keep going.$mq$, $mq$easy$mq$),
($mq$What should you write down while you listen?$mq$, $mq$["Key words such as numbers, names and times","Every sentence in full","Only the first word","A translation of the whole text"]$mq$, 0, $mq$Short notes of key details are fast and useful. Full sentences make you miss the next piece of information.$mq$, $mq$easy$mq$),
($mq$Listening transcript: 'El tren para Valencia sale a las ocho y cuarto del andén tres.'
What time does the train leave?$mq$, $mq$["8:45","7:45","8:30","8:15"]$mq$, 3, $mq$Y cuarto means quarter past, so ocho y cuarto is 8:15. Y media would be 8:30 and menos cuarto would be 7:45.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'El concierto es el sábado, no el viernes. Empieza a las siete.'
On which day is the concert?$mq$, $mq$["Friday","Sunday","Saturday","Thursday"]$mq$, 2, $mq$The speaker corrects the day: es el sábado, no el viernes. Words like no signal a correction.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'Normalmente tomo café, pero hoy tomo té.'
What does the speaker drink today?$mq$, $mq$["Coffee","Tea","Water","Juice"]$mq$, 1, $mq$Pero signals a change: normally coffee, but today (hoy) tea. The question asks about today.$mq$, $mq$medium$mq$),
($mq$Listening transcript: '— ¿Cuánto es? — Son doce euros con cincuenta.'
How much is it?$mq$, $mq$["€12.50","€15.20","€12.05","€50.12"]$mq$, 0, $mq$Doce euros con cincuenta is 12 euros and 50 cents. Listen for the order of the numbers.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'Quedamos a las nueve y media.'
What time are they meeting?$mq$, $mq$["8:30","9:50","10:30","9:30"]$mq$, 3, $mq$Y media means half past, so nueve y media is 9:30.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'Mi cumpleaños es el veinte de marzo.'
When is the speaker's birthday?$mq$, $mq$["2 March","20 May","20 March","12 March"]$mq$, 2, $mq$El veinte de marzo is the 20th of March. Marzo is March and mayo is May.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'No quiero la camiseta roja, quiero la azul.'
Which colour does the speaker want?$mq$, $mq$["Red","Blue","Green","Black"]$mq$, 1, $mq$The speaker rejects red (no quiero la roja) and chooses blue (azul). Distractors often use a colour that is mentioned but rejected.$mq$, $mq$medium$mq$),
($mq$What is the best use of the first listening?$mq$, $mq$["Understand the general topic and write the easier answers","Write down every word","Answer only the final question","Translate the text in your head"]$mq$, 0, $mq$The first listening gives you the general idea. Use the second to check details and fill gaps.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 'Hola, soy Jorge. El partido no es a las cinco, es a las seis, porque el campo está ocupado.'
Why has the match time changed?$mq$, $mq$["It is raining","The coach is ill","It is too cold","The pitch is in use"]$mq$, 3, $mq$El campo está ocupado means the pitch is occupied. The time moves from 5 to 6 o'clock.$mq$, $mq$hard$mq$),
($mq$Listening transcript: '— Quiero dos entradas para la película de las siete. — Lo siento, está completa. Hay una sesión a las nueve.'
What is the problem?$mq$, $mq$["The cinema is closed","The tickets are too expensive","The 7 o'clock showing is full","The film has finished"]$mq$, 2, $mq$Está completa means it is full. The clerk offers another showing at nine, but the question asks about the problem.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'Tengo dos hermanos: Luis, que tiene diez años, y Pablo, que tiene quince.'
How old is the younger brother?$mq$, $mq$["15","10","12","25"]$mq$, 1, $mq$Luis is 10 and Pablo is 15, so Luis is the younger one. Read the question carefully, as it asks for the younger brother.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'No hay clase de música hoy, hay clase de arte.'
What lesson is there today?$mq$, $mq$["Art","Music","Sport","No lesson"]$mq$, 0, $mq$No hay clase de música means there is no music class, and hay clase de arte says there is art.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'Salimos de casa a las ocho menos diez y llegamos al colegio a las ocho y diez.'
How long is the journey?$mq$, $mq$["10 minutes","40 minutes","60 minutes","20 minutes"]$mq$, 3, $mq$Ocho menos diez is 7:50 and ocho y diez is 8:10, so the journey takes 20 minutes.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Listening Text Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Listening transcript$mq$, $mq$In our practice, the written text of what you would hear. In the exam you hear a recording once or twice.$mq$),
($mq$quince / cincuenta$mq$, $mq$15 / 50. Do not mix them up when you hear numbers.$mq$),
($mq$trece / treinta$mq$, $mq$13 / 30. Listen to the ending: -ce for the teens, -nta for the tens.$mq$),
($mq$y cuarto, y media, menos cuarto$mq$, $mq$quarter past, half past, quarter to. For example, las ocho y media is 8:30 and las ocho menos cuarto is 7:45.$mq$),
($mq$pero$mq$, $mq$but. It signals a change or contrast, and the real answer often comes after it.$mq$),
($mq$no es..., es...$mq$, $mq$It is not..., it is... A correction: no es a las cinco, es a las seis (not at five, at six).$mq$),
($mq$¿Cuánto es?$mq$, $mq$How much is it? Listen for the price: doce euros con cincuenta is 12.50 euros.$mq$),
($mq$How should you take notes?$mq$, $mq$Write key words, numbers, names and times, not full sentences.$mq$),
($mq$What if you miss an answer?$mq$, $mq$Move on, write a guess and be ready for the next question. You can check again in the second listening.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Listening Text Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What the listening task is like
In the real eAssessment you listen to short recordings, such as announcements, phone messages and conversations, and answer questions. Because we cannot play audio here, our practice questions show a written "Listening transcript". Practise reading each one slowly, then imagine hearing it once or twice at normal speed.

## Before you listen
- Read all the questions and the options. They show the topic and the kind of details to catch.
- Predict vocabulary. If the question mentions a train, expect times, platforms (el andén) and places.
- Notice the question word: cuándo (time or date), cuánto (price or amount), dónde (place), por qué (reason).

## While you listen
- Write only **key words**: numbers, names, days, times, colours, places. Use quick spellings or digits rather than full sentences.
- Listen for **signals of change**: pero (but), no... sino, en realidad, ahora, hoy. They often introduce the real answer. In 'Normalmente tomo café, pero hoy tomo té', the answer is tea.
- Listen for **corrections**: El concierto es el sábado, no el viernes. The speaker gives both days, but only one is the answer.
- Watch for **negatives**: No hay clase de música means there is no music class.
- Do not panic if you miss a word. Keep listening for the next piece of information.

## Numbers and times
Practise hearing numbers because they are easy to mix up.
- quince (15) and cincuenta (50); trece (13) and treinta (30)
- y cuarto (quarter past), y media (half past), menos cuarto (quarter to), menos diez (ten to)
- The price 12,50 € is doce euros con cincuenta.
Write the digits as you hear them, then re-read your answer.

## After the first listening
Use the break to fill in what you can. During the second listening, check your answers and fill the gaps. If you still do not know an answer, write a sensible guess based on the question, because you do not lose marks for a guess.

## Common mistakes
- Choosing the first number or day you hear without waiting for a correction.
- Answering about the wrong person, such as the older brother instead of the younger one.
- Writing too much and missing the next question.
- Mixing up time expressions such as y media and menos cuarto.

## How this is examined
Listening questions test detail (a time, a price, a place), reason (por qué) and sometimes opinion. Speakers often say a wrong detail and then correct it, or give two options and choose one. Careful attention to small words such as no, pero and solo is rewarded.

Exam tip: In the preparation time, circle the question word in each question and write a tiny reminder next to it, such as "time?", "price?" or "reason?". Then listen for exactly that kind of information.$mq$ from st;

-- eAssessment Skills for Languages > Writing a Short Response
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Languages$mq$, 5, 9 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Writing a Short Response$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Languages$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Writing a Short Response$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which opening is suitable for an informal email to a friend?$mq$, $mq$["Hola Marta,","Estimado señor,","Muy señor mío:","A quien corresponda:"]$mq$, 0, $mq$Hola followed by the friend's name is friendly and informal. The others are formal greetings.$mq$, $mq$easy$mq$),
($mq$Which sign-off is suitable for a friend?$mq$, $mq$["Atentamente","Muy atentamente","Le saluda atentamente","Un abrazo"]$mq$, 3, $mq$Un abrazo (a hug) is a warm, informal ending. The other options are formal.$mq$, $mq$easy$mq$),
($mq$The task asks for 50 to 70 words. What should you do?$mq$, $mq$["Write as much as you can","Write only one sentence","Write within the range and cover every bullet point","Write in English if you run out of Spanish"]$mq$, 2, $mq$Staying within the range and covering all the points shows you have understood the task and keeps your language accurate.$mq$, $mq$easy$mq$),
($mq$Which sentence is correct?$mq$, $mq$["Me gusto jugar al fútbol.","Me gusta jugar al fútbol.","Yo gusta fútbol jugar.","Me gustan jugar al fútbol."]$mq$, 1, $mq$Me gusta is followed by a verb in the infinitive. Jugar al fútbol means to play football.$mq$, $mq$easy$mq$),
($mq$What does 'porque' mean?$mq$, $mq$["because","but","also","never"]$mq$, 0, $mq$Porque is used to give reasons: Me gusta el verano porque hace sol.$mq$, $mq$easy$mq$),
($mq$The task: 'Write about your weekend: where you go, who with and your opinion.' Which answer covers all three?$mq$, $mq$["Me gusta el cine.","Voy al cine los sábados.","Mi hermano es simpático y tiene quince años.","Los sábados voy al cine con mi hermano. Me gusta mucho porque las películas son divertidas."]$mq$, 3, $mq$This answer gives the place (cine), the person (con mi hermano) and an opinion with a reason (me gusta porque...). The others miss one or more points.$mq$, $mq$medium$mq$),
($mq$In which sentence are capital letters used correctly?$mq$, $mq$["El Lunes voy al colegio.","Soy Española y vivo en Madrid.","El martes voy al colegio.","Mi amigo es Francés."]$mq$, 2, $mq$In Spanish, days, months and nationalities begin with a small letter. Only the first word of a sentence and proper names such as Madrid are capitalised.$mq$, $mq$medium$mq$),
($mq$Choose the best link word: Me gusta el verano ____ hace sol.$mq$, $mq$["pero","porque","o","también"]$mq$, 1, $mq$Porque gives a reason: I like summer because it is sunny.$mq$, $mq$medium$mq$),
($mq$Which sentence means 'I think the town is boring'?$mq$, $mq$["Creo que la ciudad es aburrida.","Creo que la ciudad es aburrido.","Creo la que ciudad es aburrida.","Pienso de la ciudad aburrida."]$mq$, 0, $mq$Creo que introduces an opinion, and the adjective aburrida agrees with ciudad (feminine).$mq$, $mq$medium$mq$),
($mq$Which sentence says 'Next weekend I am going to visit my grandparents'?$mq$, $mq$["El próximo fin de semana voy visitar a mis abuelos.","El próximo fin de semana voy a visitando a mis abuelos.","El próximo fin de semana voy a visito a mis abuelos.","El próximo fin de semana voy a visitar a mis abuelos."]$mq$, 3, $mq$The future is formed with ir + a + infinitive: voy a visitar. The infinitive never changes after voy a.$mq$, $mq$medium$mq$),
($mq$Which question is correctly written?$mq$, $mq$["¿Como estás?","Cómo estás?","¿Cómo estás?","¿Cómo estas?"]$mq$, 2, $mq$The question word cómo needs an accent, and estás (you are) needs its accent to be different from estas (these). The question also needs ¿.$mq$, $mq$medium$mq$),
($mq$The task has three bullet points but you only write about two. What is the likely result?$mq$, $mq$["Nothing, because the Spanish is accurate","You lose marks for an incomplete answer","You gain extra marks","The examiner ignores the missing point"]$mq$, 1, $mq$Covering all the points is part of the task. Plan one or two sentences for each bullet.$mq$, $mq$medium$mq$),
($mq$The task: 'Describe your best friend.' Which answer is best?$mq$, $mq$["Mi mejor amiga se llama Sara. Es alta y simpática y tiene el pelo largo.","Sara.","Mi mejor amiga Sara alto simpático.","My best friend Sara is tall."]$mq$, 0, $mq$The best answer uses full, correct sentences in Spanish with agreement (alta, simpática). The others are too short, have errors or are in English.$mq$, $mq$medium$mq$),
($mq$A student wrote 'Mi hermano es 12 años.' Which correction is right?$mq$, $mq$["Mi hermano está doce años.","Mi hermano es doce años.","Mi hermano tienes doce años.","Mi hermano tiene doce años."]$mq$, 3, $mq$Spanish uses tener for age, and the verb must be tiene for él.$mq$, $mq$hard$mq$),
($mq$Which sentence contains an agreement error?$mq$, $mq$["Tengo dos gatos negros.","Mi casa es muy bonita.","Las clases son aburrido.","Mis amigos son simpáticos."]$mq$, 2, $mq$Clases is plural and feminine, so the adjective must be aburridas.$mq$, $mq$hard$mq$),
($mq$Your friend asks: '¿Qué haces en tu tiempo libre?' Which opening sentence of your reply answers it?$mq$, $mq$["Sí, gracias.","En mi tiempo libre juego al baloncesto y escucho música.","Me llamo Pablo y tengo quince años.","Vivo en una casa grande."]$mq$, 1, $mq$The question is about free time, so the reply should mention activities. The other sentences are correct Spanish but do not answer the question.$mq$, $mq$hard$mq$),
($mq$A student wrote 'Yo tiene quince años.' What is the error?$mq$, $mq$["The verb does not match yo; it should be tengo","Tener is not used for age","Quince should be quinze","Yo must be removed"]$mq$, 0, $mq$With yo, the verb tener is tengo. Tiene is for él/ella/usted.$mq$, $mq$hard$mq$),
($mq$Which sentence has the correct word order and form?$mq$, $mq$["Me no gusta el pescado porque huele mal.","No gusta me el pescado porque huele mal.","No me gusta el pescado porque huele malo.","No me gusta el pescado porque huele mal."]$mq$, 3, $mq$No goes before me gusta, and mal (adverb, not changing) follows the verb huele. Malo is an adjective and is not used here.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Writing a Short Response$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Hola Marta, ... Un abrazo$mq$, $mq$An informal email: start with Hola and the name, end with Un abrazo (a hug) or Hasta pronto (see you soon).$mq$),
($mq$Estimado señor, ... Atentamente$mq$, $mq$A formal letter: dear sir, ... yours sincerely. Do not use these with friends.$mq$),
($mq$Me gusta + infinitive$mq$, $mq$Me gusta jugar al fútbol: I like to play football. Use me gustan with plural nouns: me gustan los deportes.$mq$),
($mq$Giving a reason$mq$, $mq$Use porque: Me gusta el verano porque hace sol (I like summer because it is sunny).$mq$),
($mq$Opinion starters$mq$, $mq$Creo que... (I think that...), En mi opinión... (in my opinion...), Me parece que... (it seems to me that...).$mq$),
($mq$Talking about the future$mq$, $mq$ir + a + infinitive: Voy a visitar a mis abuelos (I am going to visit my grandparents).$mq$),
($mq$Saying your age$mq$, $mq$Tengo quince años. Use tener, not ser. Tengo with yo, tiene with él/ella.$mq$),
($mq$Punctuation in Spanish$mq$, $mq$¿Cómo estás? ¡Hola! Questions and exclamations start with an upside-down mark. Days and months start with a small letter.$mq$),
($mq$Proofreading checklist$mq$, $mq$Check verb endings, ser/estar/tener, adjective agreement, accents, bullet points covered and word count.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Writing a Short Response$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What the writing task is like
In the eAssessment writing task you usually respond to a short prompt, such as an email from a friend, an advert or a topic like "my family" or "my town". You are normally told how many words to write and which points to include. At ab initio level, clear, accurate sentences matter more than long or complicated ones.

## Plan before you write
1. Read the task twice and underline the bullet points. Each one needs at least one sentence.
2. Note the text type and who you are writing to. A friend gets Hola and Un abrazo. Formal letters use Estimado/a and Atentamente.
3. Jot down useful words for each point.
4. Choose simple structures you are sure about.

## Building good sentences
Use patterns you know well and add detail:
- Introduce yourself: Me llamo Ana y tengo quince años. Soy de Londres.
- Describe: Mi mejor amigo es alto y simpático. Tiene el pelo corto.
- Give opinions with reasons: Me gusta el fútbol porque es divertido. No me gustan las matemáticas porque son difíciles.
- Talk about routines and places: Vivo en una casa pequeña. Por la mañana voy al colegio en autobús.
- Talk about plans: El sábado voy a ir al cine con mis amigos.
Link ideas with y (and), pero (but), porque (because), también (also) and por eso (so, therefore).

## Check your accuracy
After writing, check each sentence against this list:
- The verb ending matches the subject (yo tengo, ella tiene).
- You used ser, estar and tener correctly.
- Adjectives agree in gender and number (las clases aburridas).
- Accents and punctuation are present (¿Cómo estás?, ¡Hola!), and days and months have small letters.
- The word count is in the range.

## A model answer
Task: write to a penfriend about your free time (about 60 words). Hola Carlos: Gracias por tu correo. En mi tiempo libre juego al baloncesto con mis amigos y escucho música. Me gusta el baloncesto porque es muy divertido. Los fines de semana voy al cine con mi hermana. Mi película favorita es una comedia. ¿Y tú? ¿Qué haces en tu tiempo libre? Un abrazo, Sam. Notice the greeting, answers to the topic, reasons, a question for the reader and a friendly ending.

## Common mistakes
- Writing in English or mixing in English words.
- Missing out one of the bullet points.
- Writing long, complicated sentences that contain errors.
- Using words from another language. Stick to the Spanish you are sure about.
- Forgetting the verb altogether, as in Mi casa muy grande.

## How this is examined
Writing is marked for how well you communicate the required message, how clear and accurate your language is and how well you use vocabulary and structures. A short answer with all points covered in simple, correct Spanish scores better than a long one with many errors.

Exam tip: Use the last two minutes to proofread. Look at every verb and every adjective and ask: "Does it match its subject or noun?" These are the easiest errors to fix and often the most visible.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;