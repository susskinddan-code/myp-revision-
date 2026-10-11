-- Part 2 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Family and Friends > Family Members
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Family and Friends$mq$, 5, 2 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Family Members$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Family and Friends$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Family Members$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'la abuela' mean?$mq$, $mq$["The grandmother","The aunt","The sister","The mother"]$mq$, 0, $mq$'La abuela' is the grandmother and 'el abuelo' is the grandfather. 'La tía' is the aunt.$mq$, $mq$easy$mq$),
($mq$What does 'mi tío' mean?$mq$, $mq$["My cousin","My brother","My grandfather","My uncle"]$mq$, 3, $mq$'Tío' is uncle and 'tía' is aunt. A cousin is 'primo' or 'prima'.$mq$, $mq$easy$mq$),
($mq$Which word means 'sister'?$mq$, $mq$["hermano","hija","hermana","prima"]$mq$, 2, $mq$'Hermana' is sister and 'hermano' is brother. 'Hija' means daughter and 'prima' means female cousin.$mq$, $mq$easy$mq$),
($mq$What does 'mis padres' mean?$mq$, $mq$["My fathers","My parents","My grandparents","My cousins"]$mq$, 1, $mq$In Spanish the plural 'padres' means 'parents' (mother and father). 'Abuelos' means grandparents.$mq$, $mq$easy$mq$),
($mq$Which word means 'male cousin'?$mq$, $mq$["primo","sobrino","tío","hijo"]$mq$, 0, $mq$'Primo' is a male cousin and 'prima' is a female cousin. 'Sobrino' is nephew and 'hijo' is son.$mq$, $mq$easy$mq$),
($mq$Someone says 'Tengo dos hermanos.' Which situation is possible?$mq$, $mq$["Two sisters only","Two cousins","Two parents","Two brothers, or one brother and one sister"]$mq$, 3, $mq$The masculine plural 'hermanos' can mean brothers or a mixed group of brothers and sisters. Two girls would be 'dos hermanas'.$mq$, $mq$medium$mq$),
($mq$Who is 'la hermana de mi madre'?$mq$, $mq$["My cousin","My niece","My aunt","My grandmother"]$mq$, 2, $mq$Your mother's sister is your aunt: 'mi tía'.$mq$, $mq$medium$mq$),
($mq$Read: 'Somos cinco en mi familia: mis padres, mi hermano Rafa, mi hermana Alba y yo.'

Which family member is NOT mentioned?$mq$, $mq$["A sister","A grandmother","A brother","A father"]$mq$, 1, $mq$The text lists parents (so a father), a brother (Rafa), a sister (Alba) and the writer. There is no grandmother.$mq$, $mq$medium$mq$),
($mq$Which sentence is correct?$mq$, $mq$["Mis abuelos viven en Bilbao.","Mi abuelos viven en Bilbao.","Mis abuelos vive en Bilbao.","Mi abuelos vive en Bilbao."]$mq$, 0, $mq$A plural noun needs 'mis' and a plural verb 'viven': 'Mis abuelos viven en Bilbao'.$mq$, $mq$medium$mq$),
($mq$A boy says: 'Soy hijo único.' What does he mean?$mq$, $mq$["He is the youngest son.","He is a single father.","He is the oldest brother.","He is an only child."]$mq$, 3, $mq$'Hijo único' means 'only child'. A girl would say 'hija única'.$mq$, $mq$medium$mq$),
($mq$Read the dialogue.

'¿Tienes hermanos?' – 'No, soy hija única.'

What does the girl say?$mq$, $mq$["She has two brothers.","She has a twin sister.","She is an only child.","She has many cousins."]$mq$, 2, $mq$'Hija única' means only daughter, so she has no brothers or sisters.$mq$, $mq$medium$mq$),
($mq$Listening transcript:

'Mi familia es grande. Tengo tres tíos y dos tías. Mi prima Carmen tiene diez años y mi primo Hugo tiene catorce.'

How many aunts and uncles does the speaker have in total?$mq$, $mq$["Three","Five","Four","Six"]$mq$, 1, $mq$Three uncles plus two aunts makes five (3 + 2 = 5). The cousins are not counted.$mq$, $mq$medium$mq$),
($mq$Which phrase can only mean 'my female cousins'?$mq$, $mq$["mis primas","mis primos","mi prima","mi primo"]$mq$, 0, $mq$'Mis primas' is feminine plural. 'Mis primos' could include boys, and 'mi prima' is only one girl.$mq$, $mq$medium$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["Mi madre y mi padre son mis padres.","Mis hermanas se llaman Eva y Rosa.","Tengo un tío en Lima.","Mi tía es muy simpático."]$mq$, 3, $mq$'Tía' is feminine, so the adjective must be feminine too: 'Mi tía es muy simpática'.$mq$, $mq$hard$mq$),
($mq$Who is 'el hijo de mi tío'?$mq$, $mq$["My brother","My nephew","My cousin","My grandfather"]$mq$, 2, $mq$Your uncle's son is your cousin: 'mi primo'. A nephew would be 'el hijo de mi hermano' or 'de mi hermana'.$mq$, $mq$hard$mq$),
($mq$Read: 'Me llamo Inés. Mi abuela María tiene setenta años. Su hija, mi madre, se llama Pilar. El hermano de Pilar se llama Jorge.'

Who is Jorge to Inés?$mq$, $mq$["Her grandfather","Her uncle","Her cousin","Her brother"]$mq$, 1, $mq$Pilar is Inés's mother, and Jorge is Pilar's brother, so he is Inés's uncle (tío).$mq$, $mq$hard$mq$),
($mq$Read: 'En mi casa vivimos mis padres, mi abuela, mis dos hermanos y yo.'

How many people live in the house?$mq$, $mq$["Six","Five","Seven","Eight"]$mq$, 0, $mq$Two parents + one grandmother + two brothers + the writer = 6 people.$mq$, $mq$hard$mq$),
($mq$Which sentence is fully correct?$mq$, $mq$["Tengo dos hermanas gemelos.","Tengo dos hermana gemelas.","Tengo dos hermanas gemela.","Tengo dos hermanas gemelas."]$mq$, 3, $mq$The noun, number and adjective must agree: 'dos hermanas gemelas' is feminine plural throughout.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Family Members$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$los padres vs los abuelos$mq$, $mq$los padres = parents (mother and father). los abuelos = grandparents. Do not confuse them.$mq$),
($mq$mis hermanos$mq$, $mq$My brothers, or my brothers and sisters together. Only 'mis hermanas' is for girls only.$mq$),
($mq$el tío / la tía$mq$, $mq$Uncle / aunt. 'Los tíos' can mean uncle and aunt together.$mq$),
($mq$el primo / la prima$mq$, $mq$Male cousin / female cousin.$mq$),
($mq$hijo único / hija única$mq$, $mq$Only child (boy / girl). Soy hijo único = I am an only child.$mq$),
($mq$mi vs mis$mq$, $mq$mi + singular (mi madre), mis + plural (mis padres). Same for masculine and feminine.$mq$),
($mq$Somos cinco en mi familia$mq$, $mq$There are five of us in my family. 'Somos' is the 'we' form of 'ser'.$mq$),
($mq$se llama / se llaman$mq$, $mq$is called / are called. Mi hermana se llama Eva. Mis primos se llaman Leo y Hugo.$mq$),
($mq$el hijo de mi tío$mq$, $mq$My cousin (my uncle's son). The word is 'mi primo'.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Family Members$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Talking about your family
Family is one of the most popular topics in the eAssessment. You may read an email from a penpal about their relatives, listen to someone describing a family photo, or write a short paragraph about your own family. The key skill is knowing the words and keeping masculine, feminine, singular and plural correct.

## Core vocabulary
- el padre (father), la madre (mother), los padres (parents)
- el hermano (brother), la hermana (sister), los hermanos (brothers, or brothers and sisters)
- el hijo (son), la hija (daughter), los hijos (children)
- el abuelo (grandfather), la abuela (grandmother), los abuelos (grandparents)
- el tío (uncle), la tía (aunt), los tíos (uncles, or uncle and aunt)
- el primo (male cousin), la prima (female cousin)
- el sobrino (nephew), la sobrina (niece)
- hijo único / hija única (only child)
- gemelos / gemelas (twins)

## Masculine plural rule
When a group includes both males and females, Spanish uses the masculine plural. So 'mis hermanos' can mean two brothers or a brother and a sister. Only when everyone is female do we use 'hermanas'. This is a favourite exam trap.

## Useful sentence patterns
- Tengo un hermano y dos hermanas (I have one brother and two sisters)
- No tengo hermanos. Soy hijo único (I have no brothers or sisters. I am an only child)
- Somos cinco en mi familia (there are five of us in my family)
- Mi abuela vive en Valencia (my grandmother lives in Valencia)
- Mis tíos se llaman Pedro y Laura (my aunt and uncle are called Pedro and Laura)
- Mi padre es el hermano de mi tío (my father is my uncle's brother)

Notice 'se llama' for one person and 'se llaman' for several people.

## Describing relationships
Questions often give a chain of relationships. Work through it step by step.
Example: 'Mi abuela tiene una hija. Se llama Pilar y es mi madre. Pilar tiene un hermano, Jorge.' (My grandmother has a daughter. She is called Pilar and is my mother. Pilar has a brother, Jorge.) Pilar is the mother, so her brother Jorge is the writer's uncle.

## Possessives
'Mi' (my) is used with singular nouns and 'mis' with plural nouns: mi hermano, mis hermanos. They do not change for masculine or feminine: mi madre, mi padre.

## Counting people
Exam questions often ask you to add up people. Worked example: 'En mi casa vivimos mis padres, mi abuela, mis dos hermanos y yo.' Count: 2 + 1 + 2 + 1 = 6 people, so 'seis personas'.

## How this is examined
In reading you may meet a short email, a family tree described in words or a message to a host family, and you must pick out relationships, numbers and names. In listening, speakers often give several names quickly, so write down who is who. In writing you describe your family in five to six sentences: 'Tengo un hermano y una hermana. Mi hermano se llama Leo y tiene doce años.'

## Common mistakes
- Using 'mi' with plural nouns: say 'mis abuelos', not 'mi abuelos'
- Forgetting that the verb must be plural too: 'mis abuelos viven'
- Using masculine endings with feminine nouns: 'mi tía es simpática'
- Mixing up 'primo' (cousin) with 'sobrino' (nephew)

Exam tip: In listening and reading, underline each relationship word (tío, prima, abuela) and check whether it is male or female before you answer.$mq$ from st;

-- Family and Friends > Describing People
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Family and Friends$mq$, 5, 2 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Describing People$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Family and Friends$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Describing People$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'alto' mean?$mq$, $mq$["Tall","Short","Thin","Old"]$mq$, 0, $mq$'Alto' means tall and its opposite is 'bajo' (short).$mq$, $mq$easy$mq$),
($mq$What does 'pelo corto' mean?$mq$, $mq$["Long hair","Curly hair","Blond hair","Short hair"]$mq$, 3, $mq$'Pelo' is hair and 'corto' is short. Long hair is 'pelo largo'.$mq$, $mq$easy$mq$),
($mq$What does 'ojos azules' mean?$mq$, $mq$["Green eyes","Brown eyes","Blue eyes","Big eyes"]$mq$, 2, $mq$'Ojos' means eyes and 'azules' means blue. Green is 'verdes' and brown is 'marrones'.$mq$, $mq$easy$mq$),
($mq$What does 'simpático' mean?$mq$, $mq$["Serious","Nice, friendly","Lazy","Clever"]$mq$, 1, $mq$'Simpático' is nice or friendly, and its opposite is 'antipático'. It is a false friend: it does not mean 'sympathetic'.$mq$, $mq$easy$mq$),
($mq$What does 'Ella es rubia' mean?$mq$, $mq$["She is blonde.","She is tall.","She is clever.","She is young."]$mq$, 0, $mq$'Rubia' is the feminine form of 'rubio' (blond/blonde).$mq$, $mq$easy$mq$),
($mq$Complete: 'Mi hermana es ___.'$mq$, $mq$["alto","altos","altas","alta"]$mq$, 3, $mq$'Hermana' is feminine singular, so the adjective is 'alta'.$mq$, $mq$medium$mq$),
($mq$What does 'Tiene el pelo largo y rizado' mean?$mq$, $mq$["He/She has short straight hair.","He/She has long blond hair.","He/She has long curly hair.","He/She is tall with curly hair."]$mq$, 2, $mq$'Largo' is long and 'rizado' is curly. Straight hair is 'liso'.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'My female friends are intelligent'?$mq$, $mq$["Mis amigas son inteligente.","Mis amigas son inteligentes.","Mis amigas es inteligentes.","Mi amigas son inteligentes."]$mq$, 1, $mq$Adjectives ending in -e, like 'inteligente', add -s in the plural and do not change for gender. The plural noun also needs a plural verb 'son' and 'mis'.$mq$, $mq$medium$mq$),
($mq$Read the description.

'Mi mejor amigo, Nico, es alto y delgado. Tiene el pelo moreno y los ojos verdes. Lleva gafas. Es muy gracioso.'

Which detail is true?$mq$, $mq$["He wears glasses.","He has blue eyes.","He is short.","He has blond hair."]$mq$, 0, $mq$'Lleva gafas' means he wears glasses. He is tall, has dark hair and green eyes.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'He has black hair'?$mq$, $mq$["Es el pelo negro.","Está el pelo negro.","Tiene pelo es negro.","Tiene el pelo negro."]$mq$, 3, $mq$In Spanish we say people 'have' hair and eyes (tener), but we use 'ser' for general characteristics like tall or friendly.$mq$, $mq$medium$mq$),
($mq$Complete: 'La profesora de música es muy ___.'$mq$, $mq$["divertido","divertidas","divertida","divertidos"]$mq$, 2, $mq$'Profesora' is feminine singular, so we need 'divertida'.$mq$, $mq$medium$mq$),
($mq$Listening transcript:

'Busco a mi hermana. Es baja, pelirroja y tiene los ojos marrones. Lleva una camiseta azul.'

Which description matches her?$mq$, $mq$["Tall, red hair, brown eyes","Short, red hair, brown eyes","Short, red hair, green eyes","Short, black hair, brown eyes"]$mq$, 1, $mq$'Baja' is short, 'pelirroja' means red-haired and 'ojos marrones' are brown eyes.$mq$, $mq$medium$mq$),
($mq$What is the opposite of 'simpático'?$mq$, $mq$["antipático","simpática","divertido","guapo"]$mq$, 0, $mq$The opposite of 'simpático' (nice) is 'antipático' (unpleasant, unfriendly). 'Simpática' is just the feminine form of the same word.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'My mother has green eyes'?$mq$, $mq$["Mi madre es los ojos verdes.","Mi madre tiene los ojos verde.","Mi madre está ojos verdes.","Mi madre tiene los ojos verdes."]$mq$, 3, $mq$'Tiene' is used for physical features, and 'verdes' agrees with the plural 'ojos'.$mq$, $mq$hard$mq$),
($mq$Four friends are described.

Eva es alta y morena. Luis es bajo y rubio. Marta es alta y rubia. Pablo es bajo y moreno.

Who matches: 'Busco a una chica alta y rubia'?$mq$, $mq$["Eva","Luis","Marta","Pablo"]$mq$, 2, $mq$The person must be a girl (chica, rubia), tall (alta) and blonde (rubia). Only Marta matches all three.$mq$, $mq$hard$mq$),
($mq$Complete: 'Mi prima y mi tía son muy ___.'$mq$, $mq$["trabajador","trabajadoras","trabajadora","trabajadores"]$mq$, 1, $mq$Two women means feminine plural, so the adjective is 'trabajadoras'.$mq$, $mq$hard$mq$),
($mq$Which adjective does NOT change between masculine and feminine singular?$mq$, $mq$["inteligente","alto","rubio","simpático"]$mq$, 0, $mq$Adjectives ending in -e (inteligente, grande) have the same form for masculine and feminine. Those ending in -o change to -a.$mq$, $mq$hard$mq$),
($mq$Read the message.

'Mi profesor de música es joven y muy simpático, pero mi profesora de matemáticas es seria y un poco antipática.'

What does the writer think of the maths teacher?$mq$, $mq$["She is funny and young.","She is serious but very friendly.","She is old and strict.","She is serious and a little unfriendly."]$mq$, 3, $mq$'Seria' means serious and 'un poco antipática' means a little unfriendly. Nothing is said about her age.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Describing People$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Tiene el pelo largo y rizado$mq$, $mq$He/She has long curly hair. Use 'tener' for hair and eyes.$mq$),
($mq$alto / bajo$mq$, $mq$tall / short. Feminine: alta / baja.$mq$),
($mq$rubio, moreno, pelirrojo$mq$, $mq$blond, dark-haired, red-haired. Feminine: rubia, morena, pelirroja.$mq$),
($mq$ojos azules, verdes, marrones$mq$, $mq$blue, green, brown eyes. These adjectives are plural to match 'ojos'.$mq$),
($mq$Lleva gafas$mq$, $mq$He/She wears glasses. 'Llevar' means to wear or carry.$mq$),
($mq$simpático vs antipático$mq$, $mq$nice, friendly vs unfriendly. 'Simpático' does not mean 'sympathetic'.$mq$),
($mq$inteligente / inteligentes$mq$, $mq$clever. The same for masculine and feminine; add -s for the plural.$mq$),
($mq$trabajador → feminine and plural$mq$, $mq$trabajadora (f.), trabajadores (m. pl.), trabajadoras (f. pl.). It means hard-working.$mq$),
($mq$Where does the adjective go?$mq$, $mq$Normally after the noun and agreeing with it: una amiga simpática, unos ojos verdes.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Describing People$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why describing people matters
Describing people is a classic task in language exams. You might read a message about a lost friend at a station, listen to a description of a new teacher, or write about your best friend. To do it well you need vocabulary, the verbs 'ser' and 'tener', and careful agreement of adjectives.

## Physical vocabulary
- alto / alta (tall), bajo / baja (short)
- delgado / delgada (slim)
- joven (young), mayor (older), viejo / vieja (old)
- guapo / guapa (good-looking)
- rubio / rubia (blond), moreno / morena (dark-haired), pelirrojo / pelirroja (red-haired), calvo (bald)
- el pelo largo (long hair), corto (short), liso (straight), rizado (curly)
- los ojos azules (blue eyes), verdes (green), marrones (brown), negros (black)
- Lleva gafas (he/she wears glasses)

## Personality vocabulary
- simpático / simpática (nice, friendly) and antipático / antipática (unfriendly)
- divertido (fun), gracioso (funny)
- inteligente (clever), trabajador / trabajadora (hard-working)
- serio / seria (serious), tímido (shy)

## Ser or tener?
Use 'ser' for general description: Es alto. Es muy simpática. Use 'tener' for hair and eyes: Tiene el pelo negro. Tiene los ojos verdes. Saying 'Es el pelo negro' is wrong.

## Adjective agreement
Adjectives must match the noun they describe in gender (masculine/feminine) and number (singular/plural), and they normally come after the noun.
- Adjectives ending in -o: alto, alta, altos, altas
- Adjectives ending in -e: inteligente, inteligentes (no change for gender)
- Adjectives ending in a consonant like -or: trabajador, trabajadora, trabajadores, trabajadoras
- Adjectives ending in -ista or -e do not change for gender, such as optimista or grande

Examples: Mi madre es alta y delgada. Mis hermanos son altos y morenos. Mis primas son trabajadoras.

## A model description
'Mi mejor amiga se llama Lola. Es alta y delgada. Tiene el pelo largo y rubio y los ojos azules. Lleva gafas. Es muy simpática y divertida.' (My best friend is called Lola. She is tall and slim. She has long blond hair and blue eyes. She wears glasses. She is very friendly and fun.)

## Useful linking words
- y (and), pero (but), también (also), muy (very), un poco (a bit)

## How this is examined
Reading and listening tasks often present several people and ask you to match a description to the right one, which means checking every detail: hair, eyes, height, glasses. In writing, you describe a friend or family member. Marks go for variety (appearance and personality), for correct use of 'es' and 'tiene', and for agreement.

## Common mistakes
- Writing 'Mi hermana es alto' (masculine ending with a feminine noun)
- Using 'ser' for hair or eyes
- Forgetting the plural -s on adjectives
- Translating 'sympathetic' for 'simpático': it means nice

Exam tip: When matching descriptions, tick off each detail in turn. Wrong answers are usually right in one detail but wrong in another, such as eye colour.$mq$ from st;

-- Family and Friends > Pets and Possessions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Family and Friends$mq$, 5, 2 from public.subjects s where s.slug = $mq$spanish-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Pets and Possessions$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Family and Friends$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Pets and Possessions$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'el gato' mean?$mq$, $mq$["The cat","The dog","The fish","The rabbit"]$mq$, 0, $mq$'Gato' is cat. Dog is 'perro', fish is 'pez' and rabbit is 'conejo'.$mq$, $mq$easy$mq$),
($mq$What does 'Tengo un perro' mean?$mq$, $mq$["I am a dog.","I like dogs.","I see a dog.","I have a dog."]$mq$, 3, $mq$'Tengo' comes from 'tener' (to have), so 'Tengo un perro' means 'I have a dog'.$mq$, $mq$easy$mq$),
($mq$Which pet is 'un pez'?$mq$, $mq$["A bird","A horse","A fish","A turtle"]$mq$, 2, $mq$'Pez' is a fish while it is alive in water. A bird is 'un pájaro' and a turtle is 'una tortuga'.$mq$, $mq$easy$mq$),
($mq$What does 'el ordenador' mean?$mq$, $mq$["The mobile phone","The computer","The notebook","The television"]$mq$, 1, $mq$In Spain 'ordenador' is the computer. The mobile phone is 'el móvil'.$mq$, $mq$easy$mq$),
($mq$What does 'la bicicleta' mean?$mq$, $mq$["The bicycle","The car","The bus","The motorbike"]$mq$, 0, $mq$'La bicicleta' is the bicycle. It is often shortened to 'la bici'.$mq$, $mq$easy$mq$),
($mq$Complete: 'Nosotros ___ un conejo.'$mq$, $mq$["tengo","tienes","tienen","tenemos"]$mq$, 3, $mq$The 'nosotros' (we) form of 'tener' is 'tenemos'.$mq$, $mq$medium$mq$),
($mq$Complete: 'Mi hermana ___ una tortuga.'$mq$, $mq$["tienes","tengo","tiene","tienen"]$mq$, 2, $mq$With a singular third person (mi hermana) the verb is 'tiene'.$mq$, $mq$medium$mq$),
($mq$Read the text.

'Tengo un perro que se llama Max. Es grande y negro. También tengo dos peces, pero no tengo gato.'

Which pets does the writer have?$mq$, $mq$["A dog and a cat","A dog and two fish","Two dogs and a fish","A cat and two fish"]$mq$, 1, $mq$The writer has a dog (Max) and two fish ('dos peces'). 'No tengo gato' says there is no cat.$mq$, $mq$medium$mq$),
($mq$What is the plural of 'pez'?$mq$, $mq$["peces","pezes","pezs","pez"]$mq$, 0, $mq$Words ending in -z change to -ces in the plural: pez becomes peces.$mq$, $mq$medium$mq$),
($mq$A friend asks if you have a pet. You reply 'No tengo mascota.' What have you said?$mq$, $mq$["I do not like pets.","I have lost my pet.","I have no friends.","I do not have a pet."]$mq$, 3, $mq$'Mascota' means pet and 'no tengo' means I do not have.$mq$, $mq$medium$mq$),
($mq$Which phrase is correct for 'a black dog'?$mq$, $mq$["una perro negro","un perro negra","un perro negro","una perra negro"]$mq$, 2, $mq$'Perro' is masculine, so we use 'un' and 'negro'. 'Una perra negra' would be a female black dog.$mq$, $mq$medium$mq$),
($mq$Listening transcript:

'Tengo un móvil nuevo y una bicicleta roja. No tengo ordenador en mi habitación. Mi hermano tiene dos videojuegos.'

What does the speaker NOT have?$mq$, $mq$["A mobile phone","A computer","A red bicycle","A brother"]$mq$, 1, $mq$'No tengo ordenador' means the speaker has no computer. The speaker does have a phone, a bicycle and a brother.$mq$, $mq$medium$mq$),
($mq$'Mi gato tiene tres años.' What does this tell you?$mq$, $mq$["The cat is three years old.","The cat has three owners.","The cat has three kittens.","The cat is called Tres."]$mq$, 0, $mq$Spanish uses 'tener' for age, so 'tiene tres años' means 'is three years old'.$mq$, $mq$medium$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["Mis padres tienen un caballo.","Tengo un pájaro azul.","Tenemos dos gatos.","Mi hermana tienen un hámster."]$mq$, 3, $mq$'Mi hermana' is singular, so the verb must be 'tiene', not 'tienen'.$mq$, $mq$hard$mq$),
($mq$Read: 'Tengo dos perros, tres gatos y un pez. Mi hermano tiene un conejo y dos tortugas.'

How many pets are there in total?$mq$, $mq$["Six","Seven","Nine","Ten"]$mq$, 2, $mq$The writer has 2 + 3 + 1 = 6 pets, and the brother has 1 + 2 = 3 pets. Together that is 9.$mq$, $mq$hard$mq$),
($mq$Which sentence is fully correct?$mq$, $mq$["Mis dos peces se llama Nemo y Dory.","Mis dos peces se llaman Nemo y Dory.","Mis dos peces se llamas Nemo y Dory.","Mis dos peces me llaman Nemo y Dory."]$mq$, 1, $mq$The subject is plural (dos peces), so the reflexive verb must be plural: 'se llaman'.$mq$, $mq$hard$mq$),
($mq$Read the advert.

'Vendo bicicleta azul, casi nueva. Precio: ochenta euros. Llamar por la tarde.'

Which statement is true?$mq$, $mq$["It is a nearly new blue bicycle for 80 euros.","It is a brand-new red bicycle.","It is a nearly new blue bicycle for 18 euros.","It is an old blue bicycle for 80 euros."]$mq$, 0, $mq$'Casi nueva' means nearly new, 'azul' is blue and 'ochenta' is 80. Eighteen would be 'dieciocho'.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'My brother has a small white rabbit'?$mq$, $mq$["Mi hermano tiene un conejo blanca pequeña.","Mi hermano tiene una conejo blanco pequeño.","Mi hermano tienes un conejo blanco pequeño.","Mi hermano tiene un conejo blanco pequeño."]$mq$, 3, $mq$'Conejo' is masculine singular, so 'un', 'blanco' and 'pequeño' all agree, and the verb 'tiene' matches 'mi hermano'.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Pets and Possessions$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$tener (present tense)$mq$, $mq$tengo, tienes, tiene, tenemos, tenéis, tienen. Irregular verb meaning 'to have'.$mq$),
($mq$Tengo un perro y dos gatos$mq$, $mq$I have a dog and two cats.$mq$),
($mq$el pez → plural$mq$, $mq$los peces. Words ending in -z change to -ces in the plural.$mq$),
($mq$la mascota$mq$, $mq$Pet. It is feminine whatever animal it is: mi mascota es un conejo.$mq$),
($mq$el móvil / el ordenador$mq$, $mq$mobile phone / computer (in Spain). The plural of ordenador is ordenadores.$mq$),
($mq$No tengo hermanos$mq$, $mq$I do not have brothers or sisters. After 'no tengo' Spanish often omits un/una.$mq$),
($mq$Mi gato tiene tres años$mq$, $mq$My cat is three years old. Age uses 'tener'.$mq$),
($mq$se llama vs se llaman$mq$, $mq$is called / are called. Mi perro se llama Max. Mis peces se llaman Nemo y Dory.$mq$),
($mq$una tortuga pequeña$mq$, $mq$A small turtle. The adjective goes after the noun and agrees with it.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Pets and Possessions$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Pets and possessions
This sub-topic mixes everyday vocabulary with one very important verb, 'tener' (to have). You will meet it constantly in descriptions of family, pets, belongings and age. In the eAssessment, a message about a lost pet, an advert for a second-hand bike or an email about your new phone are typical texts.

## Pets
- el perro (dog), el gato (cat), el pez (fish), los peces (fish, plural)
- el pájaro (bird), el conejo (rabbit), el hámster (hamster)
- la tortuga (turtle), el caballo (horse), la serpiente (snake)
- la mascota (pet)

Note that 'mascota' is feminine even though it can be a male animal: 'mi mascota es un perro'.

## Possessions
- el móvil (mobile phone), el ordenador (computer)
- la bicicleta (bicycle), la mochila (backpack)
- el libro (book), el videojuego (video game)
- la tableta (tablet), la cámara (camera)

## The verb tener
- yo tengo (I have)
- tú tienes (you have)
- él / ella tiene (he / she has)
- nosotros tenemos (we have)
- vosotros tenéis (you all have)
- ellos / ellas tienen (they have)

It is irregular: the 'e' becomes 'ie' in most forms, and the 'yo' form is 'tengo'. Use it to say what you have: Tengo un gato. Mi hermano tiene un ordenador. Tenemos dos perros.

## Saying you do not have something
Put 'no' before the verb: No tengo mascota. No tenemos coche. Notice that Spanish often drops 'un/una' after 'no tengo'.

## Describing your pet
Use ser for what it is like, tener for age, and llamarse for its name.
- Mi perro se llama Max (my dog is called Max)
- Es grande y negro (it is big and black)
- Tiene tres años (it is three years old)
- Mis peces se llaman Nemo y Dory (my fish are called Nemo and Dory)

The adjective agrees with the noun, so 'una tortuga pequeña' but 'un conejo pequeño'.

## Plurals
Add -s after a vowel (gato, gatos) and -es after a consonant (ordenador, ordenadores). Words ending in -z change to -ces: pez becomes peces.

## Worked example
Question: 'Tengo dos perros, tres gatos y un pez. ¿Cuántas mascotas tengo?' Add them: 2 + 3 + 1 = 6, so the answer is 'seis'. Read carefully whether the text includes someone else's pets before you add.

## How this is examined
Reading texts include adverts, notices about lost pets and emails about birthday presents. Questions usually ask which item, how many, what colour or how old. In writing, you may be asked to describe your pet or a gift you received, using tener, colours and adjectives.

## Common mistakes
- Using 'tengo' for every person: say 'mi hermana tiene', not 'mi hermana tengo'
- Forgetting the plural -es: 'ordenadores', and 'peces' for fish
- Mixing up gender: 'el móvil', 'la bicicleta'
- Forgetting that a plural subject needs a plural verb

Exam tip: Check the person in the sentence (yo, mi hermana, mis padres) and choose the right form of 'tener' before you look at the answer options.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;