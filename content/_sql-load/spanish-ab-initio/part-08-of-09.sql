-- Part 8 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Spanish Grammar Essentials > Present Tense, Ser and Estar
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Spanish Grammar Essentials$mq$, 5, 8 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Present Tense, Ser and Estar$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Spanish Grammar Essentials$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Present Tense, Ser and Estar$mq$ and p.name = $mq$Spanish Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Choose the correct word: Yo ____ estudiante.$mq$, $mq$["soy","eres","es","estoy"]$mq$, 0, $mq$With yo (I), the verb ser is soy. Eres is for tú, es is for he/she, and estoy is a form of estar.$mq$, $mq$easy$mq$),
($mq$Choose the correct word: Ellos ____ en casa.$mq$, $mq$["son","estás","es","están"]$mq$, 3, $mq$Ellos (they) with estar is están. We use estar for where someone is, so están en casa means they are at home.$mq$, $mq$easy$mq$),
($mq$Which is the correct form of 'hablar' for 'nosotros' (we)?$mq$, $mq$["hablan","hablo","hablamos","hablas"]$mq$, 2, $mq$Regular -ar verbs take -amos for nosotros: hablamos. Hablan is ellos, hablo is yo and hablas is tú.$mq$, $mq$easy$mq$),
($mq$Choose the correct word: Tú ____ pan en el desayuno. (comer)$mq$, $mq$["como","comes","come","comen"]$mq$, 1, $mq$Regular -er verbs end in -es for tú: comes. Como is yo, come is él/ella and comen is ellos.$mq$, $mq$easy$mq$),
($mq$Choose the correct word: Mi hermana ____ doce años.$mq$, $mq$["tiene","es","está","tienes"]$mq$, 0, $mq$Spanish uses tener for age, so mi hermana tiene doce años. Ser and estar are never used to say how old someone is.$mq$, $mq$easy$mq$),
($mq$Choose the correct word: Madrid ____ la capital de España.$mq$, $mq$["está","son","estás","es"]$mq$, 3, $mq$Ser is used for identity and definitions, so Madrid es la capital. Está would be used for temporary states or location, not for a definition.$mq$, $mq$medium$mq$),
($mq$Choose the correct word: La tienda ____ cerca del banco.$mq$, $mq$["es","son","está","hay"]$mq$, 2, $mq$Estar is used for the location of things, so la tienda está cerca del banco. Hay cannot be used with a definite subject like la tienda in this pattern.$mq$, $mq$medium$mq$),
($mq$Choose the correct word: Ella ____ cansada hoy.$mq$, $mq$["es","está","tiene","hay"]$mq$, 1, $mq$Tiredness is a temporary state, so we use estar: ella está cansada. Ser would suggest tiredness is part of her character.$mq$, $mq$medium$mq$),
($mq$Which sentence is correct?$mq$, $mq$["Mi padre es médico.","Mi padre está médico.","Mi padre tiene médico.","Mi padre ser médico."]$mq$, 0, $mq$Jobs use ser: es médico. Está is wrong for a job, tiene means has, and ser is the infinitive, which cannot follow mi padre.$mq$, $mq$medium$mq$),
($mq$What is the correct form of 'vivir' for 'vosotros' (you all, informal)?$mq$, $mq$["vives","viven","vivimos","vivís"]$mq$, 3, $mq$Regular -ir verbs take -ís for vosotros: vivís. Vives is tú, viven is ellos/ellas and vivimos is nosotros.$mq$, $mq$medium$mq$),
($mq$Read the text.
'Me llamo Lucía. Soy de Chile pero ahora vivo en Sevilla. Mi casa está cerca del centro.'
Where does Lucía live now?$mq$, $mq$["In Chile","In the centre of Santiago","In Seville","In Madrid"]$mq$, 2, $mq$Ahora vivo en Sevilla means 'now I live in Seville'. She is from Chile (soy de Chile) but no longer lives there.$mq$, $mq$medium$mq$),
($mq$Choose the correct word: Yo ____ un perro y dos gatos. (tener)$mq$, $mq$["tiengo","tengo","teno","tengos"]$mq$, 1, $mq$Tener is irregular in the yo form: tengo. Tiengo, teno and tengos do not exist.$mq$, $mq$medium$mq$),
($mq$Choose the correct word: Ella ____ un helado de fresa. (querer)$mq$, $mq$["quiere","quere","quiera","queres"]$mq$, 0, $mq$Querer is a stem-changing verb (e to ie) in the singular: quiere for él/ella. The stem does not change in nosotros (queremos).$mq$, $mq$medium$mq$),
($mq$Choose the correct pair: Mis padres ____ de México y ahora ____ en Canadá.$mq$, $mq$["están / son","son / son","están / están","son / están"]$mq$, 3, $mq$Origin uses ser (son de México). Where someone is at present uses estar (están en Canadá).$mq$, $mq$hard$mq$),
($mq$Which sentence is INCORRECT?$mq$, $mq$["Soy de Argentina.","Estoy muy contento.","Mi madre está profesora.","Ellas son amigas."]$mq$, 2, $mq$A job uses ser, so it should be 'Mi madre es profesora'. The other three sentences use ser and estar correctly.$mq$, $mq$hard$mq$),
($mq$What are the correct yo forms of 'hacer' and 'salir'?$mq$, $mq$["hazo, salo","hago, salgo","hago, salo","hacio, salgo"]$mq$, 1, $mq$Both verbs add a g in the yo form: hago and salgo. The rest of the verb is regular.$mq$, $mq$hard$mq$),
($mq$Read the message.
'Hola Pablo: Estoy en la playa con mi familia. Es un día muy bonito y estamos contentos. Mi hermano es deportista y juega al tenis.'
Which statement is TRUE?$mq$, $mq$["The writer is at the beach with the family.","The writer is at home.","The brother is unhappy.","The writer plays tennis."]$mq$, 0, $mq$Estoy en la playa con mi familia confirms the beach. It is the brother who plays tennis (juega al tenis), and everyone is happy (contentos).$mq$, $mq$hard$mq$),
($mq$Why does the sentence 'Estamos en clase' use estar and not ser?$mq$, $mq$["Ser is never used with nosotros.","Estamos is a form of ser.","Location is shown with tener.","Estar is used to say where someone is."]$mq$, 3, $mq$A useful memory aid is that location uses estar. Estamos is nosotros in the present of estar, while ser would be somos.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Present Tense, Ser and Estar$mq$ and p.name = $mq$Spanish Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$soy, eres, es, somos, sois, son$mq$, $mq$The present tense of ser (to be): used for identity, origin, job, description and time.$mq$),
($mq$estoy, estás, está, estamos, estáis, están$mq$, $mq$The present tense of estar (to be): used for location and temporary states or feelings.$mq$),
($mq$Ser or estar? Estoy cansada.$mq$, $mq$Estar, because tiredness is a temporary feeling. Estoy cansada means I am tired.$mq$),
($mq$Ser or estar? Es profesor.$mq$, $mq$Ser, because a job is an identity. Es profesor means he is a teacher.$mq$),
($mq$How do you say 'I am 14' in Spanish?$mq$, $mq$Tengo catorce años. Spanish uses tener (to have) for age, not ser.$mq$),
($mq$Endings of regular -ar verbs (hablar)$mq$, $mq$-o, -as, -a, -amos, -áis, -an: hablo, hablas, habla, hablamos, habláis, hablan.$mq$),
($mq$Endings of regular -er verbs (comer)$mq$, $mq$-o, -es, -e, -emos, -éis, -en: como, comes, come, comemos, coméis, comen.$mq$),
($mq$yo form of tener, hacer, salir$mq$, $mq$tengo, hago, salgo. These are irregular in the yo form only (tener also changes its stem in other forms).$mq$),
($mq$querer (to want): stem change$mq$, $mq$quiero, quieres, quiere, queremos, queréis, quieren. The e becomes ie, except for nosotros and vosotros.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Present Tense, Ser and Estar$mq$ and p.name = $mq$Spanish Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Present tense: the basics
Spanish verbs change their endings to show who is doing the action. This means you can often drop the subject pronoun (yo, tú, él...) because the ending already tells the reader who it is. There are three groups of regular verbs, shown here with hablar (to speak), comer (to eat) and vivir (to live).
- -ar verbs: hablo, hablas, habla, hablamos, habláis, hablan
- -er verbs: como, comes, come, comemos, coméis, comen
- -ir verbs: vivo, vives, vive, vivimos, vivís, viven
Remember the order: yo, tú, él/ella/usted, nosotros, vosotros, ellos/ellas/ustedes. In Latin America, ustedes is used instead of vosotros.

## Common irregular verbs
Some very common verbs do not follow the pattern. You must learn them by heart.
- tener (to have): tengo, tienes, tiene, tenemos, tenéis, tienen
- hacer (to do, make): hago, haces, hace, hacemos, hacéis, hacen
- ir (to go): voy, vas, va, vamos, vais, van
- querer (to want): quiero, quieres, quiere, queremos, queréis, quieren
Querer is a stem-changing verb: the e becomes ie, except in nosotros and vosotros. Other examples are poder (puedo) and dormir (duermo).

## Ser and estar: two verbs for "to be"
English has one verb "to be", but Spanish has two. Both are irregular.
- ser: soy, eres, es, somos, sois, son
- estar: estoy, estás, está, estamos, estáis, están
Use **ser** for identity and permanent features: name, nationality, job, origin, description, time and relationships. Examples: Soy Ana. Es profesor. Somos de Perú. Son las tres.
Use **estar** for location and temporary states or feelings: Estoy en casa. Está cansada. La tienda está cerca. Estamos contentos.
A helpful memory trick is that "How you feel and where you are always use the verb estar."

## Age with tener
Spanish does not use ser for age. Say Tengo quince años (I have fifteen years), never Soy quince años.

## Common mistakes
- Using ser for location: say Estoy en el colegio, not Soy en el colegio.
- Using estar for jobs: say Es médico, not Está médico.
- Forgetting that the verb ending must match the subject: Yo tengo, not Yo tiene.
- Translating "I am 15" word for word.

## How this is examined
In the reading and writing tasks you rarely see grammar questions in isolation. Instead, the correct verb form is the difference between a message that makes sense and one that does not. You may be asked to choose the correct word to complete a short text, to spot the sentence with an error, or to write a short message about yourself, your family and where you live. Examiners reward accurate use of ser, estar and tener with age.

Exam tip: Before you write any sentence with "to be", ask yourself two quick questions: "Is it where? Is it a feeling that can change?" If yes, use estar. If it is who, what, where from or what job, use ser.$mq$ from st;

-- Spanish Grammar Essentials > Articles, Questions and Negatives
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Spanish Grammar Essentials$mq$, 5, 8 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Articles, Questions and Negatives$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Spanish Grammar Essentials$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Articles, Questions and Negatives$mq$ and p.name = $mq$Spanish Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Choose the correct article: ____ libro (the book)$mq$, $mq$["el","la","los","las"]$mq$, 0, $mq$Libro is masculine singular, so the article is el.$mq$, $mq$easy$mq$),
($mq$Choose the correct article: ____ casa (the house)$mq$, $mq$["el","los","un","la"]$mq$, 3, $mq$Casa is feminine singular, so the definite article is la.$mq$, $mq$easy$mq$),
($mq$Choose the correct article: ____ chicos (the boys)$mq$, $mq$["las","el","los","unos"]$mq$, 2, $mq$Chicos is masculine plural, so the article is los. Unos means 'some', not 'the'.$mq$, $mq$easy$mq$),
($mq$Which question word means 'where'?$mq$, $mq$["¿Cuándo?","¿Dónde?","¿Quién?","¿Cómo?"]$mq$, 1, $mq$Dónde asks about place. Cuándo is when, quién is who and cómo is how.$mq$, $mq$easy$mq$),
($mq$How do you say 'I don't like it' in Spanish?$mq$, $mq$["No me gusta.","Me no gusta.","Me gusta no.","No gusto."]$mq$, 0, $mq$To make a sentence negative, put no directly before the verb phrase: No me gusta.$mq$, $mq$easy$mq$),
($mq$Choose the correct article: Tengo ____ mesa en mi habitación.$mq$, $mq$["un","el","unos","una"]$mq$, 3, $mq$Mesa is feminine singular, so 'a table' is una mesa.$mq$, $mq$medium$mq$),
($mq$What is the plural of 'el lápiz'?$mq$, $mq$["los lápizes","las lápices","los lápices","los lápiz"]$mq$, 2, $mq$Words ending in -z change z to c and add -es in the plural: lápiz becomes lápices. The article stays masculine: los.$mq$, $mq$medium$mq$),
($mq$Choose the correct question word: ¿____ años tienes?$mq$, $mq$["Cuánto","Cuántos","Cuántas","Cuándo"]$mq$, 1, $mq$Años is masculine plural, so cuántos must agree. Cuándo means 'when' and does not fit a question about number.$mq$, $mq$medium$mq$),
($mq$What does 'Nunca como carne' mean?$mq$, $mq$["I never eat meat.","I always eat meat.","I sometimes eat meat.","I do not like meat."]$mq$, 0, $mq$Nunca means never. Como is the yo form of comer, so nunca como carne means I never eat meat.$mq$, $mq$medium$mq$),
($mq$Which sentence means 'I don't have any pets'?$mq$, $mq$["Tengo no mascotas.","No tengo no mascotas.","Yo no mascotas tengo.","No tengo mascotas."]$mq$, 3, $mq$The negative word no goes before the verb. Spanish does not put it after the verb or use it twice here.$mq$, $mq$medium$mq$),
($mq$Choose the correct word: Voy ____ cine con mis amigos.$mq$, $mq$["a el","del","al","a la"]$mq$, 2, $mq$The preposition a and the article el join to make al. A el is never written.$mq$, $mq$medium$mq$),
($mq$Complete the dialogue.
'— ¿____ estudias español? — ____ me gusta.'$mq$, $mq$["Porque / Por qué","Por qué / Porque","Por qué / Por qué","Porque / Porque"]$mq$, 1, $mq$Two words with an accent (por qué) ask the question. One word without an accent (porque) gives the answer.$mq$, $mq$medium$mq$),
($mq$Which question is correctly written?$mq$, $mq$["¿Dónde vives?","Dónde vives?","¿Dónde vives","Dónde vives¿"]$mq$, 0, $mq$Spanish questions begin with an upside-down question mark and end with a normal one.$mq$, $mq$medium$mq$),
($mq$Which pair is correct?$mq$, $mq$["la día, el mano","el día, el mano","la día, la mano","el día, la mano"]$mq$, 3, $mq$Día is masculine even though it ends in -a, and mano is feminine even though it ends in -o. These are common exceptions.$mq$, $mq$hard$mq$),
($mq$Which sentence means 'Nobody comes to the party'?$mq$, $mq$["No nadie viene a la fiesta.","Nadie no viene a la fiesta.","Nadie viene a la fiesta.","Viene nadie a la fiesta."]$mq$, 2, $mq$When nadie comes before the verb, you do not add no. If it comes after the verb, you need no: No viene nadie a la fiesta.$mq$, $mq$hard$mq$),
($mq$Read the notice.
'El museo abre de martes a sábado. No abre los domingos ni los lunes.'
On which days is the museum closed?$mq$, $mq$["Only Monday","Sunday and Monday","Tuesday and Saturday","Saturday and Sunday"]$mq$, 1, $mq$Ni means 'nor', so no abre los domingos ni los lunes means it does not open on Sundays or Mondays.$mq$, $mq$hard$mq$),
($mq$You want to know when a film begins. Which question do you ask?$mq$, $mq$["¿A qué hora empieza la película?","¿Cuántos empieza la película?","¿Quién empieza la película?","¿Dónde hora empieza la película?"]$mq$, 0, $mq$A qué hora asks 'at what time'. Cuántos means how many, quién means who and dónde hora makes no sense.$mq$, $mq$hard$mq$),
($mq$Choose the correct pair: Tengo ____ amigas españolas y ____ amigo mexicano.$mq$, $mq$["unos / una","unas / una","unos / un","unas / un"]$mq$, 3, $mq$Amigas is feminine plural, so unas. Amigo is masculine singular, so un.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Articles, Questions and Negatives$mq$ and p.name = $mq$Spanish Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$el, la, los, las$mq$, $mq$The definite articles (the): el masculine singular, la feminine singular, los masculine plural, las feminine plural.$mq$),
($mq$un, una, unos, unas$mq$, $mq$The indefinite articles (a, some): un perro, una mesa, unos amigos, unas amigas.$mq$),
($mq$al and del$mq$, $mq$a + el = al (Voy al cine); de + el = del (el libro del profesor). Only el combines, not la, los or las.$mq$),
($mq$¿Dónde? ¿Cuándo? ¿Quién?$mq$, $mq$Where? When? Who? Question words always carry a written accent.$mq$),
($mq$¿Por qué? vs porque$mq$, $mq$¿Por qué? (two words, accent) means why? Porque (one word) means because.$mq$),
($mq$¿Cuántos? vs ¿Cuántas?$mq$, $mq$How many? They agree with the noun: ¿Cuántos años? (masculine), ¿Cuántas hermanas? (feminine).$mq$),
($mq$How do you make a sentence negative?$mq$, $mq$Put no before the verb: No vivo en Madrid. No me gusta el pescado.$mq$),
($mq$nunca, nadie, nada$mq$, $mq$Never, nobody, nothing. After the verb you also need no: No como nada. Before the verb, no is not needed: Nadie come.$mq$),
($mq$Plural of lápiz and ciudad$mq$, $mq$lápiz becomes lápices (z becomes c, add -es); ciudad becomes ciudades (add -es after a consonant).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Articles, Questions and Negatives$mq$ and p.name = $mq$Spanish Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Articles: the, a and some
In Spanish every noun has a gender (masculine or feminine) and a number (singular or plural). The article must match both. Learn each noun together with its article.
- Definite articles (the): el (masculine singular), la (feminine singular), los (masculine plural), las (feminine plural). Examples: el libro, la casa, los chicos, las chicas.
- Indefinite articles (a, some): un, una, unos, unas. Examples: un perro, una mesa, unos amigos, unas amigas.
Most nouns ending in -o are masculine and most ending in -a are feminine, but there are exceptions: el día, el mapa, la mano. Nouns ending in -ción or -dad are feminine: la estación, la ciudad.
To make a plural, add -s after a vowel (casa becomes casas) and -es after a consonant (ciudad becomes ciudades). A noun ending in -z changes to -ces: lápiz becomes lápices.
Remember al (a + el) and del (de + el): Voy al parque. Es el libro del profesor.

## Asking questions
Questions start with ¿ and end with ?. Question words always have an accent.
- ¿Qué? (what), ¿Quién? (who), ¿Dónde? (where), ¿Cuándo? (when), ¿Cómo? (how), ¿Cuánto? (how much), ¿Cuántos? (how many), ¿Por qué? (why), ¿Cuál? (which)
Cuánto and cuántos agree with the noun: ¿Cuántos años tienes? ¿Cuántas hermanas tienes?
Do not confuse ¿Por qué? (why) with porque (because): ¿Por qué estudias español? Porque me gusta.

## Negatives
To make a sentence negative, put no before the verb: Vivo en Madrid becomes No vivo en Madrid. Other negative words are nunca (never), nadie (nobody), nada (nothing) and ninguno (none).
If the negative word comes after the verb, you also need no before the verb: No como nada. No hablo nunca con él. If it comes before the verb, you do not need no: Nadie vive aquí. Nunca como carne.
For opinions, use No me gusta or No me gustan: No me gustan las matemáticas.

## Common mistakes
- Writing el casa instead of la casa.
- Forgetting the upside-down ¿ at the start of a question.
- Mixing up porque and por qué.
- Putting no after the verb instead of before it.

## How this is examined
These ideas appear in almost every task. In reading and listening you must understand what a question word is asking (for example, cuándo asks for a time or date). In writing you are expected to use articles correctly, ask or answer simple questions and give a negative opinion. A typical question gives a notice or message with negatives such as no abre los lunes, and asks which days or things are affected.

Exam tip: When you see a question word in a task, underline it. It tells you the kind of detail you need to find: ¿Cuándo? means a time or date, ¿Dónde? means a place, ¿Cuánto? means a price or amount.$mq$ from st;

-- Spanish Grammar Essentials > Adjectives, Agreement and Possessives
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Spanish Grammar Essentials$mq$, 5, 8 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Adjectives, Agreement and Possessives$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Spanish Grammar Essentials$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Adjectives, Agreement and Possessives$mq$ and p.name = $mq$Spanish Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Choose the correct word: Mi hermana es ____. (alto)$mq$, $mq$["alta","alto","altos","altas"]$mq$, 0, $mq$Hermana is feminine singular, so the adjective must be feminine singular: alta.$mq$, $mq$easy$mq$),
($mq$Choose the correct word: Los libros son ____. (nuevo)$mq$, $mq$["nuevo","nueva","nuevas","nuevos"]$mq$, 3, $mq$Libros is masculine plural, so the adjective becomes nuevos.$mq$, $mq$easy$mq$),
($mq$Complete the sentence with 'my': ____ amigos viven en Bogotá.$mq$, $mq$["Mi","Tus","Mis","Su"]$mq$, 2, $mq$Amigos is plural, so 'my' becomes mis. Mi is singular, and tus and su mean your and his/her/their.$mq$, $mq$easy$mq$),
($mq$What does 'simpático' mean?$mq$, $mq$["sympathetic","friendly, nice","strict","funny"]$mq$, 1, $mq$Simpático means nice or friendly. It is a false friend, as it does not mean sympathetic.$mq$, $mq$easy$mq$),
($mq$Complete the sentence with 'your' (informal): ____ casa es grande.$mq$, $mq$["Tu","Tú","Ti","Te"]$mq$, 0, $mq$Tu without an accent means 'your'. Tú with an accent means 'you'.$mq$, $mq$easy$mq$),
($mq$Choose the correct word: Las chicas son ____. (inteligente)$mq$, $mq$["inteligente","inteligentas","inteligentos","inteligentes"]$mq$, 3, $mq$Adjectives ending in -e have the same masculine and feminine form, but add -s in the plural: inteligentes.$mq$, $mq$medium$mq$),
($mq$Which phrase is correct?$mq$, $mq$["una casa blanco","un casa blanco","una casa blanca","unas casa blanca"]$mq$, 2, $mq$Colour adjectives go after the noun and agree with it. Casa is feminine, so blanca.$mq$, $mq$medium$mq$),
($mq$Complete the sentence with 'our': ____ profesora es simpática.$mq$, $mq$["Nuestro","Nuestra","Nuestras","Nuestros"]$mq$, 1, $mq$Profesora is feminine singular, so nuestra. The possessive agrees with the thing owned, not the owner.$mq$, $mq$medium$mq$),
($mq$Ana y Luis tienen un perro. ____ perro se llama Toby.$mq$, $mq$["Su","Sus","Tu","Nuestro"]$mq$, 0, $mq$Su means 'their' (or his/her) before a singular noun. Perro is singular, so su, not sus.$mq$, $mq$medium$mq$),
($mq$Choose the correct word: Mi madre y mi tía son ____. (español)$mq$, $mq$["españoles","español","española","españolas"]$mq$, 3, $mq$Both people are female, so the adjective is feminine plural: españolas.$mq$, $mq$medium$mq$),
($mq$Which phrase is correct?$mq$, $mq$["un bueno amigo","una buen amigo","un buen amigo","un amigo buen"]$mq$, 2, $mq$Bueno shortens to buen before a masculine singular noun. You can also say un amigo bueno.$mq$, $mq$medium$mq$),
($mq$Choose the correct word: Mis primos son de México. Son ____.$mq$, $mq$["mexicanas","mexicanos","mexicano","mexicanes"]$mq$, 1, $mq$Primos is masculine plural, so mexicanos. Nationalities agree like other adjectives, and they begin with a small letter.$mq$, $mq$medium$mq$),
($mq$Read the text.
'Mi mejor amigo se llama Diego. Es alto y delgado, con el pelo corto y negro. Sus ojos son verdes. Es muy simpático.'
What colour are Diego's eyes?$mq$, $mq$["green","black","brown","blue"]$mq$, 0, $mq$Sus ojos son verdes: verdes means green. Negro (black) describes his hair.$mq$, $mq$medium$mq$),
($mq$Which sentence is fully correct?$mq$, $mq$["Mis hermanas son alto y rubio.","Mi hermanas son altas y rubias.","Mis hermanas es altas y rubias.","Mis hermanas son altas y rubias."]$mq$, 3, $mq$The possessive (mis), the verb (son) and both adjectives (altas, rubias) must all be plural and feminine where needed.$mq$, $mq$hard$mq$),
($mq$Marta says: 'Nuestros profesores son jóvenes.' What does 'nuestros' agree with?$mq$, $mq$["Marta, the owner","jóvenes","profesores, the thing owned","the gender of the speaker"]$mq$, 2, $mq$A possessive adjective agrees with the noun it describes (profesores: masculine plural), not with the person who owns it.$mq$, $mq$hard$mq$),
($mq$Which phrase is correct?$mq$, $mq$["dos camisas verdes y unos pantalones gris","dos camisas verdes y unos pantalones grises","dos camisas verdes y unas pantalones grises","dos camisa verdes y unos pantalones grises"]$mq$, 1, $mq$Camisas is plural, so dos camisas. Pantalones is masculine plural, so unos pantalones grises.$mq$, $mq$hard$mq$),
($mq$Read the text.
'Mi familia es pequeña. Mi padre es profesor y mi madre es enfermera. Tengo un hermano mayor, que es muy gracioso, y una hermana pequeña, que es muy tímida.'
How is the younger sister described?$mq$, $mq$["shy","funny","tall","strict"]$mq$, 0, $mq$Una hermana pequeña is the younger sister, and que es muy tímida says she is shy. Gracioso (funny) describes the older brother.$mq$, $mq$hard$mq$),
($mq$Which sentence translates 'Our dogs are big'?$mq$, $mq$["Nuestras perros son grandes.","Nuestro perros son grandes.","Nuestros perros son grande.","Nuestros perros son grandes."]$mq$, 3, $mq$Perros is masculine plural, so nuestros and grandes must both be plural.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Adjectives, Agreement and Possessives$mq$ and p.name = $mq$Spanish Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$alto, alta, altos, altas$mq$, $mq$The four forms of an adjective ending in -o: masculine and feminine, singular and plural.$mq$),
($mq$inteligente: masculine or feminine?$mq$, $mq$Both: un chico inteligente, una chica inteligente. The plural is inteligentes.$mq$),
($mq$Where does the adjective go?$mq$, $mq$Usually after the noun: una casa blanca, un perro negro. It must agree in gender and number.$mq$),
($mq$mi, tu, su$mq$, $mq$my, your (informal), his/her/their. Add -s for plural nouns: mis, tus, sus.$mq$),
($mq$nuestro, nuestra, nuestros, nuestras$mq$, $mq$Our. The possessive agrees with the thing owned: nuestras amigas.$mq$),
($mq$tu vs tú$mq$, $mq$Tu without an accent means your (tu casa). Tú with an accent means you (tú eres).$mq$),
($mq$simpático/a$mq$, $mq$Nice, friendly. It is a false friend: it does not mean sympathetic.$mq$),
($mq$bueno becomes buen$mq$, $mq$Before a masculine singular noun: un buen amigo. The feminine stays buena: una buena amiga.$mq$),
($mq$español → española$mq$, $mq$Nationalities ending in a consonant add -a for the feminine. They begin with a small letter in Spanish.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Adjectives, Agreement and Possessives$mq$ and p.name = $mq$Spanish Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Adjectives must agree
In Spanish an adjective describes a noun and must agree with it in gender and number. Unlike English, the adjective usually comes after the noun: un perro negro (a black dog), not un negro perro.
Adjectives that end in -o have four forms:
- alto (masculine singular), alta (feminine singular), altos (masculine plural), altas (feminine plural)
Adjectives that end in -e or most consonants have two forms: inteligente / inteligentes, fácil / fáciles, azul / azules.
Adjectives of nationality that end in a consonant add -a for the feminine: español becomes española, francés becomes francesa. When a group contains both males and females, use the masculine plural.
Colours agree too: una falda roja, unos zapatos negros, dos camisas verdes. Some words shorten before a masculine noun: bueno becomes buen (un buen día), and grande becomes gran before any singular noun (un gran amigo).

## Useful describing words
- alto/a (tall), bajo/a (short), delgado/a (thin), rubio/a (blond), moreno/a (dark-haired)
- simpático/a (nice), antipático/a (unpleasant), divertido/a (fun), tímido/a (shy), trabajador/a (hard-working)
- joven (young), mayor (older), guapo/a (good-looking), pequeño/a (small), grande (big)
Remember that simpático means friendly, not sympathetic.

## Possessive adjectives
These show who owns something.
- mi / mis (my), tu / tus (your), su / sus (his, her, their, your formal)
- nuestro / nuestra / nuestros / nuestras (our), vuestro / vuestra / vuestros / vuestras (your, plural informal)
They agree with the thing owned, not with the owner. Nuestros profesores means our teachers (profesores is masculine plural). Mi hermano but mis hermanos.
Do not confuse tu (your) with tú (you), or mi (my) with mí (me).

## A worked example
Let us describe a family in a few lines: Mi familia es grande. Mi padre es alto y moreno, y mi madre es rubia y muy simpática. Mis hermanos son divertidos, pero mi hermana pequeña es un poco tímida. Nuestra casa es blanca y tiene un jardín enorme. Notice that every adjective matches its noun (padre alto, madre simpática, hermanos divertidos) and that the possessives mi, mis and nuestra match the thing owned.

## Common mistakes
- Putting the adjective before the noun as in English: say una casa grande.
- Forgetting to make the adjective plural: say Mis amigos son simpáticos.
- Making the possessive agree with the owner instead of the thing owned.
- Writing nationalities with a capital letter: in Spanish they are lower case (mexicano, española).

## How this is examined
Describing people, places and objects is one of the most common tasks. In a reading text you may need to match a description (Es alto y delgado, con el pelo negro) to the right person. In writing you may have to describe your family or best friend in a few lines. Accurate agreement is easy to check, so examiners notice it.

Exam tip: After you write a description, check every adjective by asking two questions: "Is the noun masculine or feminine? Is it singular or plural?" Then make the adjective and possessive match.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;