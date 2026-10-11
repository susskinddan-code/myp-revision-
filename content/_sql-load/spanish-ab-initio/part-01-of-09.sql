-- Part 1 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Greetings and Introductions > Greetings and Farewells
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Greetings and Introductions$mq$, 5, 1 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Greetings and Farewells$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Greetings and Introductions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Greetings and Farewells$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$You arrive at school at 8:00 in the morning. Which greeting means 'Good morning'?$mq$, $mq$["Buenos días","Buenas tardes","Buenas noches","Hasta luego"]$mq$, 0, $mq$'Buenos días' is used in the morning. 'Buenas tardes' is for the afternoon and 'Buenas noches' is for the evening or night. 'Hasta luego' is a farewell.$mq$, $mq$easy$mq$),
($mq$Which of these expressions is a farewell (a way of saying goodbye)?$mq$, $mq$["Hola","Buenas tardes","Mucho gusto","Hasta luego"]$mq$, 3, $mq$'Hasta luego' means 'See you later'. 'Hola' and 'Buenas tardes' are greetings and 'Mucho gusto' is said when meeting someone.$mq$, $mq$easy$mq$),
($mq$What does '¿Cómo estás?' mean?$mq$, $mq$["What is your name?","Where are you from?","How are you?","How old are you?"]$mq$, 2, $mq$'¿Cómo estás?' is the informal way to ask 'How are you?'. Names, origin and age use different questions.$mq$, $mq$easy$mq$),
($mq$Your friend asks '¿Cómo estás?' and you answer 'Muy bien, gracias.' What have you said?$mq$, $mq$["I am very tired, thanks.","I am very well, thank you.","I am very sad, sorry.","I am very well, goodbye."]$mq$, 1, $mq$'Muy bien' means 'very well' and 'gracias' means 'thank you'.$mq$, $mq$easy$mq$),
($mq$It is 10 p.m. and you meet a neighbour in the street. Which greeting is the most natural?$mq$, $mq$["Buenas noches","Buenos días","Buenas tardes","Hasta mañana"]$mq$, 0, $mq$After dark we say 'Buenas noches'. 'Hasta mañana' means 'See you tomorrow' and is a farewell, not a greeting.$mq$, $mq$easy$mq$),
($mq$You meet your teacher, Señora López, in the corridor. Which question is the most polite and correct?$mq$, $mq$["¿Cómo estás, tía?","¿Qué tal, chica?","¡Hola, guapa!","¿Cómo está usted, señora?"]$mq$, 3, $mq$With a teacher or an older person we use the formal 'usted' form: '¿Cómo está usted?'. The other options are too informal.$mq$, $mq$medium$mq$),
($mq$A friend says '¿Qué tal?' to you. Which reply fits best?$mq$, $mq$["Me llamo Ana.","Tengo quince años.","Bien, ¿y tú?","Soy de Madrid."]$mq$, 2, $mq$'¿Qué tal?' means 'How's it going?', so a reply such as 'Bien, ¿y tú?' (Fine, and you?) is logical. The other replies answer different questions.$mq$, $mq$medium$mq$),
($mq$Read the message from Lucía to her friend.

'¡Hola, Pablo! Buenas tardes. ¿Qué tal? Yo estoy muy bien. Hasta mañana.'

At what time of day does she write, and how does she end the message?$mq$, $mq$["Morning; she says goodbye for ever","Afternoon; she says see you tomorrow","Evening; she says see you later","Afternoon; she says see you soon"]$mq$, 1, $mq$'Buenas tardes' means good afternoon and 'Hasta mañana' means see you tomorrow. 'Hasta luego' would be 'see you later' and 'Hasta pronto' 'see you soon'.$mq$, $mq$medium$mq$),
($mq$A learner matched Spanish expressions with English meanings. Which match is WRONG?$mq$, $mq$["Buenas tardes – Good morning","Hasta luego – See you later","Hasta mañana – See you tomorrow","Adiós – Goodbye"]$mq$, 0, $mq$'Buenas tardes' means 'Good afternoon', not 'Good morning'. 'Good morning' is 'Buenos días'.$mq$, $mq$medium$mq$),
($mq$Complete the greeting to your teacher in the morning: '___ días, profesor.'$mq$, $mq$["Buenas","Bueno","Buena","Buenos"]$mq$, 3, $mq$'Día' is a masculine noun, and 'días' is plural, so the adjective must be masculine plural: 'Buenos días'.$mq$, $mq$medium$mq$),
($mq$Complete the greeting for the afternoon: 'Buenas ___, señor Ramos.'$mq$, $mq$["días","mañanas","tardes","noche"]$mq$, 2, $mq$'Buenas tardes' means good afternoon. 'Buenas' is feminine plural because 'tardes' is feminine plural.$mq$, $mq$medium$mq$),
($mq$Listening transcript:

Profesor: Buenos días, Marta. ¿Cómo está usted hoy?
Alumna: Buenos días, profesor. Estoy regular, gracias. ¿Y usted?
Profesor: Muy bien, gracias.

How does the student say she feels?$mq$, $mq$["Very well","So-so","Very badly","Very tired"]$mq$, 1, $mq$'Regular' means 'so-so' or 'okay'. The teacher is the one who is 'muy bien'.$mq$, $mq$medium$mq$),
($mq$A café has this sign on the door:

'Buenos días. Abierto de nueve a dos. ¡Hasta pronto!'

What does 'Hasta pronto' mean?$mq$, $mq$["See you soon","Until tomorrow","Thank you","Welcome"]$mq$, 0, $mq$'Hasta pronto' means 'See you soon'. 'Hasta mañana' is 'until tomorrow' and 'Bienvenidos' is 'welcome'.$mq$, $mq$medium$mq$),
($mq$A learner is talking to an older neighbour, Señor García. Which sentence contains a mistake?$mq$, $mq$["¿Cómo estás, Carlos?","¿Cómo está usted, señor?","¿Qué tal, Marta?","¿Cómo estás usted, señora?"]$mq$, 3, $mq$'Estás' goes with 'tú' and 'está' goes with 'usted'. Mixing them ('estás usted') is wrong. The correct formal question is '¿Cómo está usted?'.$mq$, $mq$hard$mq$),
($mq$Read the dialogue.

Marta: ¡Hola, Luis! ¿Qué tal?
Luis: Más o menos. Estoy un poco cansado.
Marta: Lo siento. Hasta luego.

Which statement is true?$mq$, $mq$["Luis is very happy.","Marta is tired.","Luis is a little tired.","Marta says she will see Luis tomorrow."]$mq$, 2, $mq$'Más o menos' means 'so-so' and 'cansado' means 'tired'. Marta says 'Hasta luego' (see you later), not 'Hasta mañana'.$mq$, $mq$hard$mq$),
($mq$At 9 a.m. a student writes 'Buenas días' in an email. What is the mistake and the correction?$mq$, $mq$["There is no mistake","'Días' is masculine, so it should be 'Buenos días'","It should be 'Buenos tardes'","It should be 'Bueno día'"]$mq$, 1, $mq$The noun 'día' is masculine (el día), so the adjective must agree: 'Buenos días'. 'Tardes' and 'noches' are feminine, so 'Buenas tardes' and 'Buenas noches' are correct.$mq$, $mq$hard$mq$),
($mq$Your teacher asks you formally, '¿Cómo está usted?' Which answer is consistent and polite?$mq$, $mq$["Muy bien, gracias. ¿Y usted?","Muy bien, gracias. ¿Y tú?","Me llamo Pedro. ¿Y usted?","Muy bien. ¿Cómo te llamas?"]$mq$, 0, $mq$When the question uses 'usted', the answer should return the question with 'usted' too. 'Y tú' switches to informal, and the other options do not answer the question.$mq$, $mq$hard$mq$),
($mq$Which ONE phrase can be used both to greet someone late in the evening and to say good night before going to bed?$mq$, $mq$["Buenos días","Buenas tardes","Hasta mañana","Buenas noches"]$mq$, 3, $mq$'Buenas noches' works as 'Good evening' and as 'Good night'. 'Hasta mañana' is only a farewell and the other two are used earlier in the day.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Greetings and Farewells$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Buenos días$mq$, $mq$Good morning. Note 'días' is masculine plural, so it is 'buenos', never 'buenas días'.$mq$),
($mq$Buenas tardes / Buenas noches$mq$, $mq$Good afternoon / Good evening or good night. Both are feminine plural.$mq$),
($mq$¿Cómo estás? vs ¿Cómo está usted?$mq$, $mq$'¿Cómo estás?' is informal (to a friend). '¿Cómo está usted?' is formal (to a teacher or older person). Both mean 'How are you?'$mq$),
($mq$Muy bien, gracias. ¿Y tú?$mq$, $mq$Very well, thank you. And you? (informal). To a teacher say '¿Y usted?'$mq$),
($mq$Regular / Más o menos$mq$, $mq$So-so, okay. Both are used to answer '¿Qué tal?' when you are neither good nor bad.$mq$),
($mq$Hasta luego, hasta mañana, hasta pronto$mq$, $mq$See you later, see you tomorrow, see you soon.$mq$),
($mq$Adiós$mq$, $mq$Goodbye. A general farewell for any situation.$mq$),
($mq$Por favor / De nada$mq$, $mq$Please / You are welcome (the reply to 'gracias').$mq$),
($mq$How do you say 'I am tired' if you are a girl?$mq$, $mq$Estoy cansada. A boy says 'Estoy cansado'. The ending -a or -o matches the speaker.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Greetings and Farewells$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why greetings matter
Greetings are the first thing you learn in any language, and they appear in almost every reading and listening text in the eAssessment. Spanish speakers greet each other all day long, and choosing the right greeting for the time of day and for the person is a sign of good manners.

## Greetings by time of day
- Hola (hello, hi) – works at any time and with anyone
- Buenos días (good morning) – until about midday
- Buenas tardes (good afternoon) – from midday until it gets dark
- Buenas noches (good evening / good night) – after dark, and also when going to bed

Notice the endings: 'día' is masculine, so we say 'buenos días'. 'Tarde' and 'noche' are feminine, so we say 'buenas tardes' and 'buenas noches'. A common mistake is to write 'buenas días'.

## Asking and answering 'How are you?'
- ¿Cómo estás? (How are you? – informal, to a friend)
- ¿Qué tal? (How's it going? – informal)
- ¿Cómo está usted? (How are you? – formal, to a teacher or older person)

Possible answers:
- Muy bien, gracias (very well, thank you)
- Bien (fine)
- Regular / Más o menos (so-so)
- Mal (bad)
- Estoy cansado / cansada (I am tired – use -o if you are male and -a if you are female)

After your answer, return the question: '¿Y tú?' to a friend or '¿Y usted?' to a teacher. Always keep the same level of formality: if someone says 'usted' to you, answer with 'usted'.

## Tú and usted
Spanish has two ways to say 'you'. 'Tú' is informal (friends, family, classmates). 'Usted' is formal (teachers, shop assistants, people you do not know well). The verb changes too: tú estás, usted está. Mixing them, like '¿Cómo estás usted?', is wrong.

## Saying goodbye
- Adiós (goodbye)
- Hasta luego (see you later)
- Hasta mañana (see you tomorrow)
- Hasta pronto (see you soon)
- Chao (bye – very informal)

## Polite words
- Por favor (please)
- Gracias (thank you)
- De nada (you are welcome)
- Perdón (sorry / excuse me)

## Spanish punctuation and accents
Questions start with ¿ and end with ?. Exclamations start with ¡ and end with !. Accents matter: 'días' needs its accent, and 'cómo' in a question has an accent, while 'como' without it means something else (I eat / like).

## How this is examined
In reading texts you may see a short message, a shop sign or a dialogue, and you must work out the time of day, who is speaking, or how someone feels. In listening you will hear (or read as a transcript) a short conversation and pick out the greeting and the farewell. In writing you need to start and end a message correctly, for example 'Hola, Ana. ¿Qué tal? ... Hasta pronto.'

## Common mistakes
- Writing 'buenas días' instead of 'buenos días'
- Using 'tú' forms with a teacher
- Forgetting the opening ¿ or ¡
- Forgetting that adjectives like cansado change for male and female speakers

Exam tip: Check the time of day in the text before choosing a greeting, and match the level of formality (tú or usted) to the person being spoken to.$mq$ from st;

-- Greetings and Introductions > Introducing Yourself and Others
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Greetings and Introductions$mq$, 5, 1 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Introducing Yourself and Others$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Greetings and Introductions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Introducing Yourself and Others$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'Me llamo Sofía' mean?$mq$, $mq$["My name is Sofía.","I am from Sofía.","I am Sofía's friend.","I live in Sofía."]$mq$, 0, $mq$'Me llamo' literally means 'I call myself', so it is used to say 'My name is...'.$mq$, $mq$easy$mq$),
($mq$Which question asks for someone's name?$mq$, $mq$["¿De dónde eres?","¿Cuántos años tienes?","¿Cómo estás?","¿Cómo te llamas?"]$mq$, 3, $mq$'¿Cómo te llamas?' means 'What is your name?'. The other questions ask about origin, age and health.$mq$, $mq$easy$mq$),
($mq$You meet a new classmate. Which phrase means 'Pleased to meet you'?$mq$, $mq$["Hasta luego","Buenos días","Mucho gusto","De nada"]$mq$, 2, $mq$'Mucho gusto' means 'pleased to meet you'. A boy can also say 'Encantado' and a girl 'Encantada'.$mq$, $mq$easy$mq$),
($mq$What does 'Soy de México' mean?$mq$, $mq$["I live in Mexico.","I am from Mexico.","I like Mexico.","I go to Mexico."]$mq$, 1, $mq$'Ser de' is used to say where you are from: 'Soy de México' means 'I am from Mexico'.$mq$, $mq$easy$mq$),
($mq$You introduce a male friend: 'Este es mi amigo Tomás.' What does 'Este es' mean?$mq$, $mq$["This is","That was","Here are","He has"]$mq$, 0, $mq$'Este es...' means 'This is...' when introducing a male person. For a female person we say 'Esta es...'.$mq$, $mq$easy$mq$),
($mq$A girl meets her new neighbour and says 'Encantada.' Why does the word end in -a?$mq$, $mq$["The neighbour is female","The word is plural","It is the formal form","The speaker is female"]$mq$, 3, $mq$'Encantado/encantada' agrees with the person who is speaking. A girl says 'encantada' and a boy says 'encantado'.$mq$, $mq$medium$mq$),
($mq$Someone asks you '¿De dónde eres?' Which answer is correct?$mq$, $mq$["Me llamo Colombia.","Tengo Colombia años.","Soy de Colombia.","Vivo Colombia."]$mq$, 2, $mq$'¿De dónde eres?' asks where you are from, so we answer 'Soy de...'. The other options mix up the verbs.$mq$, $mq$medium$mq$),
($mq$Read the introduction.

'Hola, me llamo Daniel. Tengo quince años y soy de Chile. Vivo en Santiago con mi familia.'

How old is Daniel and where does he live?$mq$, $mq$["Sixteen; in Santiago","Fifteen; in Santiago","Fifteen; in Lima","Fifty; in Chile"]$mq$, 1, $mq$'Tengo quince años' means he is 15, and 'Vivo en Santiago' means he lives in Santiago. He is from Chile, but Santiago is where he lives.$mq$, $mq$medium$mq$),
($mq$You introduce a female friend called Clara. Which sentence is fully correct?$mq$, $mq$["Esta es mi amiga Clara.","Este es mi amiga Clara.","Esta es mi amigo Clara.","Este es mi amigo Clara."]$mq$, 0, $mq$Clara is female, so we use 'Esta' and 'amiga' (feminine). 'Este' and 'amigo' are masculine.$mq$, $mq$medium$mq$),
($mq$Rosa is from Spain. Complete the sentence: 'Ella es ___.'$mq$, $mq$["español","españoles","españolas","española"]$mq$, 3, $mq$Rosa is one female person, so the nationality must be feminine singular: 'española'.$mq$, $mq$medium$mq$),
($mq$How do you say 'She is called Rosa'?$mq$, $mq$["Me llamo Rosa.","Te llamas Rosa.","Se llama Rosa.","Llamas Rosa."]$mq$, 2, $mq$'Se llama' is the third-person form of 'llamarse' and is used for 'he/she is called'. 'Me llamo' is for 'I' and 'te llamas' is for 'you'.$mq$, $mq$medium$mq$),
($mq$Listening transcript:

'Hola, buenos días. Me llamo Javier Ruiz. Soy argentino, de Buenos Aires. Tengo catorce años. Mi mejor amigo se llama Mateo.'

What nationality is Javier and how old is he?$mq$, $mq$["Argentinian; 40","Argentinian; 14","Spanish; 14","Chilean; 15"]$mq$, 1, $mq$'Argentino' is his nationality and 'catorce' is 14. Catorce (14) is easy to confuse with cuarenta (40).$mq$, $mq$medium$mq$),
($mq$Which sentence means 'He is from Peru'?$mq$, $mq$["Él es de Perú.","Ella es de Perú.","Yo soy de Perú.","Ellos son de Perú."]$mq$, 0, $mq$'Él es' means 'he is'. 'Ella es' is 'she is', 'yo soy' is 'I am' and 'ellos son' is 'they are'.$mq$, $mq$medium$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["Mi amigo se llama Pedro.","Me llamo Elena y soy española.","Ellos son mexicanos.","Mi amiga es inglés."]$mq$, 3, $mq$'Amiga' is feminine, so the nationality must be feminine too: 'Mi amiga es inglesa'.$mq$, $mq$hard$mq$),
($mq$María and Ana are both girls from France. Which sentence describes them correctly?$mq$, $mq$["Son francés.","Son francesa.","Son francesas.","Son franceses."]$mq$, 2, $mq$Two girls means feminine plural, so the nationality ends in '-as': 'francesas'. 'Franceses' would be a mixed or male group.$mq$, $mq$hard$mq$),
($mq$At a school event the head teacher says: 'Le presento a la señora Vega.' What is she doing?$mq$, $mq$["Giving Mrs Vega a present","Introducing Mrs Vega to you","Telling you that she lives near Mrs Vega","Saying her own name is Mrs Vega"]$mq$, 1, $mq$'Presentar a alguien' means to introduce someone. 'Le presento a...' is a formal way to say 'Let me introduce...'.$mq$, $mq$hard$mq$),
($mq$Read Irene's email to a new penpal.

'Querido Hugo: Me llamo Irene y tengo dieciséis años. Mi hermana se llama Paula y ella tiene doce años. Somos de Sevilla, en España. ¿Y tú?'

Which statement is true?$mq$, $mq$["Irene is sixteen and Paula is twelve.","Paula is sixteen and Irene is twelve.","Irene and Paula are from Chile.","Hugo is Irene's brother."]$mq$, 0, $mq$'Irene ... dieciséis años' and 'Paula ... doce años'. They are from Sevilla in Spain, and Hugo is the penpal she is writing to.$mq$, $mq$hard$mq$),
($mq$A learner writes 'Yo llamo Carlos.' What is the mistake?$mq$, $mq$["It should be 'Soy llamo Carlos'","It should be 'Tengo Carlos'","There is no mistake","The reflexive pronoun 'me' is missing: 'Me llamo Carlos'"]$mq$, 3, $mq$'Llamarse' is a reflexive verb, so it needs the pronoun: 'Yo me llamo Carlos' or simply 'Me llamo Carlos'.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Introducing Yourself and Others$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Me llamo... / ¿Cómo te llamas?$mq$, $mq$My name is... / What is your name? 'Llamarse' is reflexive, so never drop 'me'.$mq$),
($mq$Soy de... / ¿De dónde eres?$mq$, $mq$I am from... / Where are you from? Use 'ser de' for origin and 'vivir en' for where you live.$mq$),
($mq$Mucho gusto / Encantado / Encantada$mq$, $mq$Pleased to meet you. 'Encantado' is said by a boy, 'encantada' by a girl.$mq$),
($mq$Este es... / Esta es...$mq$, $mq$This is... Use 'este' before a male person and 'esta' before a female person.$mq$),
($mq$Se llama$mq$, $mq$He/she is called. Third person of 'llamarse': Mi amiga se llama Clara.$mq$),
($mq$español, española, españoles, españolas$mq$, $mq$Spanish: male, female, male or mixed group, female group.$mq$),
($mq$francés → ?$mq$, $mq$Feminine: francesa. Plural: franceses / francesas. The accent disappears when you add an ending.$mq$),
($mq$Vivo en Santiago$mq$, $mq$I live in Santiago. 'Vivo' comes from 'vivir' (to live).$mq$),
($mq$Le presento a...$mq$, $mq$Let me introduce... (formal). It is used when presenting one person to another.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Introducing Yourself and Others$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Introducing yourself
In the first days of any language course you learn to say who you are. This is also one of the most common writing tasks in the eAssessment: a short profile or a message to a penpal. Let us build it step by step.

## Saying your name
- Me llamo Ana (my name is Ana)
- ¿Cómo te llamas? (what is your name? – informal)
- ¿Cómo se llama usted? (what is your name? – formal)
- Se llama Pedro (he is called Pedro / his name is Pedro)

'Llamarse' is a reflexive verb, so you need the little word 'me', 'te' or 'se'. Saying 'Yo llamo Ana' is a typical mistake.

## Saying where you are from
Use 'ser de': Soy de Madrid (I am from Madrid). Ask: ¿De dónde eres? (where are you from?). To say where you live use 'vivir en': Vivo en Londres (I live in London).

## Nationalities
Nationalities are adjectives, so they agree with the person. They are written with a small letter in Spanish.
- español / española / españoles / españolas (Spanish)
- mexicano / mexicana (Mexican)
- argentino / argentina (Argentinian)
- francés / francesa (French)
- inglés / inglesa (English)
- chileno / chilena (Chilean)
- peruano / peruana (Peruvian)

Rule of thumb: -o becomes -a for girls. If the word ends in a consonant (francés, inglés), add -a for girls: francesa, inglesa. Notice that the accent disappears in the feminine and plural forms: franceses, francesa.

## Meeting someone
- Mucho gusto (pleased to meet you)
- Encantado (said by a boy) / Encantada (said by a girl)
- Igualmente (likewise)

## Introducing other people
- Este es mi amigo Tomás (this is my friend Tomás – male)
- Esta es mi amiga Clara (this is my friend Clara – female)
- Estos son mis amigos (these are my friends)
- Le presento a... (let me introduce... – formal)

## Putting it together
'Hola, me llamo Daniel. Tengo quince años y soy de Chile. Vivo en Santiago. Mi amiga se llama Elena y es mexicana.' (Hello, my name is Daniel. I am fifteen and I am from Chile. I live in Santiago. My friend is called Elena and she is Mexican.)

## How this is examined
Reading texts often contain a short profile, an email to a penpal or a name badge. Questions ask you to pick out the name, age, nationality or town. In writing, you may be asked to introduce yourself and a friend in four to six sentences, and marks go to correct verbs (me llamo, tengo, soy, vivo) and agreement.

## Common mistakes
- Forgetting 'me' in 'me llamo'
- Using the masculine nationality for a girl (Mi amiga es español)
- Writing nationalities with a capital letter as in English
- Confusing 'soy de' (origin) with 'vivo en' (where you live)

Exam tip: Always check the gender of the person before choosing 'este/esta', 'amigo/amiga' and the nationality ending.$mq$ from st;

-- Greetings and Introductions > Numbers, Age and Dates
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Greetings and Introductions$mq$, 5, 1 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Numbers, Age and Dates$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Greetings and Introductions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Numbers, Age and Dates$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which number is 'quince'?$mq$, $mq$["15","5","50","14"]$mq$, 0, $mq$'Quince' is 15. Five is 'cinco' and fifty is 'cincuenta'; fourteen is 'catorce'.$mq$, $mq$easy$mq$),
($mq$A boy says 'Tengo trece años.' How old is he?$mq$, $mq$["Twelve","Fourteen","Thirty","Thirteen"]$mq$, 3, $mq$'Trece' is 13. Spanish uses 'tener' (to have) for age: 'Tengo trece años' literally means 'I have thirteen years'.$mq$, $mq$easy$mq$),
($mq$Which English day is 'lunes'?$mq$, $mq$["Tuesday","Sunday","Monday","Friday"]$mq$, 2, $mq$'Lunes' is Monday (it comes from 'luna', moon). Tuesday is 'martes' and Friday is 'viernes'.$mq$, $mq$easy$mq$),
($mq$Which English month is 'julio'?$mq$, $mq$["June","July","March","May"]$mq$, 1, $mq$'Julio' is July. June is 'junio', March is 'marzo' and May is 'mayo'. Months have no capital letters in Spanish.$mq$, $mq$easy$mq$),
($mq$Which number is 'veinte'?$mq$, $mq$["20","2","12","200"]$mq$, 0, $mq$'Veinte' is 20. Twelve is 'doce' and two is 'dos'.$mq$, $mq$easy$mq$),
($mq$Which Spanish word is the number 30?$mq$, $mq$["trece","tres","cuarenta","treinta"]$mq$, 3, $mq$'Treinta' is 30. 'Trece' is 13, 'tres' is 3 and 'cuarenta' is 40.$mq$, $mq$medium$mq$),
($mq$Ana says: 'Mi cumpleaños es el veintitrés de abril.' When is her birthday?$mq$, $mq$["22 April","23 March","23 April","13 April"]$mq$, 2, $mq$'Veintitrés' is 23 and 'abril' is April. Dates in Spanish use the pattern 'el + number + de + month'.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'I am fifteen years old'?$mq$, $mq$["Soy quince años.","Tengo quince años.","Estoy quince años.","Hay quince años."]$mq$, 1, $mq$Age uses the verb 'tener' (to have): 'Tengo quince años'. English speakers often wrongly use 'soy'.$mq$, $mq$medium$mq$),
($mq$Read the notice on the school board.

'Club de ajedrez: martes y jueves a las cuatro. Gran torneo: sábado doce de octubre.'

On which days does the chess club meet?$mq$, $mq$["Tuesday and Thursday","Monday and Wednesday","Saturday and Sunday","Friday only"]$mq$, 0, $mq$'Martes' is Tuesday and 'jueves' is Thursday. 'Sábado' is the day of the tournament, not the weekly meeting.$mq$, $mq$medium$mq$),
($mq$Complete the sum: 'Ocho y nueve son...'$mq$, $mq$["dieciséis","dieciocho","setenta","diecisiete"]$mq$, 3, $mq$8 + 9 = 17, which is 'diecisiete'. 'Dieciséis' is 16 and 'dieciocho' is 18.$mq$, $mq$medium$mq$),
($mq$Which month comes immediately after 'agosto'?$mq$, $mq$["julio","octubre","septiembre","junio"]$mq$, 2, $mq$After August (agosto) comes September (septiembre). July is 'julio', before August.$mq$, $mq$medium$mq$),
($mq$Listening transcript:

'Mi cumpleaños es el treinta y uno de diciembre, y mi hermano cumple años el dos de enero.'

Which two dates are mentioned?$mq$, $mq$["30 December and 2 January","31 December and 2 January","31 December and 12 January","13 December and 2 January"]$mq$, 1, $mq$'Treinta y uno' is 31, 'diciembre' is December, 'dos' is 2 and 'enero' is January.$mq$, $mq$medium$mq$),
($mq$Which spelling of the number 16 is correct, including the accent?$mq$, $mq$["dieciséis","dieciseis","diesiséis","dieciseís"]$mq$, 0, $mq$The correct form is 'dieciséis', with the accent on the final 'é'. Numbers from 16 to 19 are written as one word: dieciséis, diecisiete, dieciocho, diecinueve.$mq$, $mq$medium$mq$),
($mq$Which is the correct way to write the number 21 in Spanish?$mq$, $mq$["veinteuno","veinte uno","dos y uno","veintiuno"]$mq$, 3, $mq$Numbers 21 to 29 are written as one word: veintiuno, veintidós, veintitrés... From 31 upwards we write the pieces separately: treinta y uno.$mq$, $mq$hard$mq$),
($mq$Read: 'En mi clase hay veintiocho alumnos. Trece son chicas. ¿Cuántos chicos hay?'

How many boys are in the class?$mq$, $mq$["Thirteen","Forty-one","Fifteen","Seventeen"]$mq$, 2, $mq$28 − 13 = 15, which is 'quince'. Forty-one (cuarenta y uno) would be the result of adding the numbers.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'Today is Friday, 5 March'?$mq$, $mq$["Hoy es viernes, cinco de mayo.","Hoy es viernes, cinco de marzo.","Hoy es jueves, cinco de marzo.","Hoy es viernes, marzo de cinco."]$mq$, 1, $mq$The pattern is 'Hoy es + day, + number + de + month'. 'Viernes' is Friday and 'marzo' is March; 'mayo' is May.$mq$, $mq$hard$mq$),
($mq$Read the email extract.

'Mi hermano pequeño tiene nueve años y mi hermana mayor tiene diecinueve. Yo tengo quince.'

How many years older is the sister than the little brother?$mq$, $mq$["Ten","Eight","Twenty-eight","Six"]$mq$, 0, $mq$19 − 9 = 10. Twenty-eight is the sum of the two ages. The writer's own age (15) is not needed.$mq$, $mq$hard$mq$),
($mq$A museum notice says: 'Niños menores de doce años: gratis. Jóvenes de doce a diecisiete años: cinco euros. Adultos desde dieciocho años: ocho euros.'

Elena tiene doce años. How much does she pay?$mq$, $mq$["Nothing","Eight euros","Thirteen euros","Five euros"]$mq$, 3, $mq$'Menores de doce' means under twelve, so twelve-year-olds are not free. They fall in the 'de doce a diecisiete' group and pay five euros.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Numbers, Age and Dates$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$¿Cuántos años tienes?$mq$, $mq$How old are you? Answer with 'tener': Tengo quince años. Never use 'ser' for age.$mq$),
($mq$dieciséis, diecisiete, dieciocho, diecinueve$mq$, $mq$16, 17, 18, 19. Written as one word. Note the accent on dieciséis.$mq$),
($mq$veintiuno, veintidós, veintitrés$mq$, $mq$21, 22, 23. Numbers 21-29 are one word, and veintidós and veintitrés have accents.$mq$),
($mq$treinta y uno / cuarenta / cincuenta$mq$, $mq$31 / 40 / 50. From 31, tens and units are separate words joined by 'y'.$mq$),
($mq$trece vs treinta$mq$, $mq$trece = 13, treinta = 30. Also catorce = 14 vs cuarenta = 40, and quince = 15 vs cincuenta = 50.$mq$),
($mq$Days: lunes, martes, miércoles, jueves$mq$, $mq$Monday, Tuesday, Wednesday, Thursday. Also viernes (Friday), sábado (Saturday), domingo (Sunday). No capital letters.$mq$),
($mq$Months of the year$mq$, $mq$enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre.$mq$),
($mq$Mi cumpleaños es el ocho de junio$mq$, $mq$My birthday is on 8 June. Pattern: el + number + de + month.$mq$),
($mq$¿Qué fecha es hoy?$mq$, $mq$What is the date today? Answer: Hoy es lunes, tres de mayo.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Numbers, Age and Dates$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Numbers
Numbers appear everywhere in the eAssessment: ages, prices, dates, phone numbers, times and timetables. Learn them well, including the spelling and accents.

## Numbers 0 to 30
- cero (0), uno (1), dos (2), tres (3), cuatro (4), cinco (5)
- seis (6), siete (7), ocho (8), nueve (9), diez (10)
- once (11), doce (12), trece (13), catorce (14), quince (15)
- dieciséis (16), diecisiete (17), dieciocho (18), diecinueve (19), veinte (20)
- veintiuno (21), veintidós (22), veintitrés (23), veinticuatro (24), veinticinco (25)
- treinta (30), treinta y uno (31)

Numbers 16 to 19 and 21 to 29 are written as one word. Notice the accents on dieciséis, veintidós and veintitrés.

## Tens
- cuarenta (40), cincuenta (50), sesenta (60), setenta (70)
- ochenta (80), noventa (90), cien (100)

From 31 we link tens and units with 'y': treinta y cinco (35), sesenta y ocho (68). Beware of look-alikes: trece (13) and treinta (30), catorce (14) and cuarenta (40), quince (15) and cincuenta (50).

## Age with tener
In Spanish you do not 'be' an age, you 'have' it.
- ¿Cuántos años tienes? (how old are you?)
- Tengo quince años (I am fifteen)
- Mi hermana tiene diez años (my sister is ten)

The verb 'tener': tengo, tienes, tiene, tenemos, tenéis, tienen.

## Days of the week
lunes (Monday), martes (Tuesday), miércoles (Wednesday), jueves (Thursday), viernes (Friday), sábado (Saturday), domingo (Sunday). They are not written with capital letters. The week starts on Monday in Spanish calendars.

## Months
enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre.

## Saying the date
- ¿Qué fecha es hoy? (what is the date today?)
- Hoy es lunes, tres de mayo (today is Monday, 3 May)
- Mi cumpleaños es el catorce de febrero (my birthday is on 14 February)

The pattern is 'el + number + de + month'. For the first of the month Spanish often uses 'el primero de junio'.

## Worked example
Question: 'Mi hermano tiene nueve años y yo tengo quince. ¿Cuántos años más tengo?' (My brother is nine and I am fifteen. How many years older am I?) Work out 15 − 9 = 6, so the answer is 'seis años más'.

## How this is examined
In reading you may see a notice, a calendar or a price list and be asked to find a date, an age limit or a total. In listening, numbers are read quickly, so you must recognise pairs like 14 and 40. In writing, you need to state your age and birthday correctly: 'Tengo quince años y mi cumpleaños es el ocho de junio.'

## Common mistakes
- Saying 'soy quince años' instead of 'tengo quince años'
- Writing capital letters on days and months
- Forgetting accents: dieciséis, veintidós, miércoles, sábado
- Mixing up trece/treinta and catorce/cuarenta

Exam tip: When a text gives age bands or date ranges, read the boundary words carefully (menores de, desde, de ... a) before choosing your answer.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;