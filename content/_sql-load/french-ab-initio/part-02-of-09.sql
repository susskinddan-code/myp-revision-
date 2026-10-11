-- Part 2 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Family and Friends > Family Members
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Family and Friends$mq$, 5, 2 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Family Members$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Family and Friends$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Family Members$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'la grand-mère' mean?$mq$, $mq$["grandmother","aunt","cousin","mother"]$mq$, 0, $mq$'Grand-mère' is grandmother. 'Tante' is aunt and 'mère' is mother.$mq$, $mq$easy$mq$),
($mq$What does 'mon frère' mean?$mq$, $mq$["my sister","my father","my cousin","my brother"]$mq$, 3, $mq$'Frère' is brother. Sister is 'sœur' and father is 'père'.$mq$, $mq$easy$mq$),
($mq$What does 'J'ai deux sœurs' mean?$mq$, $mq$["I have two brothers","I have two cousins","I have two sisters","I have two parents"]$mq$, 2, $mq$'Sœur' means sister and 'deux' means two. 'J'ai' is 'I have'.$mq$, $mq$easy$mq$),
($mq$What does the French word 'les parents' mean?$mq$, $mq$["relatives","mother and father","grandparents","cousins"]$mq$, 1, $mq$'Les parents' means mother and father. It is a false friend: relatives in general are 'la famille' or 'les proches'.$mq$, $mq$easy$mq$),
($mq$What does 'l'oncle' mean?$mq$, $mq$["uncle","aunt","father","grandfather"]$mq$, 0, $mq$'L'oncle' is uncle. The feminine word is 'la tante' (aunt).$mq$, $mq$easy$mq$),
($mq$What does 'Je suis fille unique' tell you?$mq$, $mq$["The speaker has a twin sister","The speaker has many sisters","The speaker is the oldest girl","The speaker is a girl with no brothers or sisters"]$mq$, 3, $mq$'Fille unique' means only child (girl). A boy says 'je suis fils unique'; 'enfant unique' works for both.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: '___ mère s'appelle Claire.' (my)$mq$, $mq$["Mon","Mes","Ma","Son"]$mq$, 2, $mq$'Mère' is feminine singular, so 'my' is 'ma'.$mq$, $mq$medium$mq$),
($mq$Read: 'Dans ma famille, il y a cinq personnes : mes parents, mon frère Hugo, ma sœur Zoé et moi.' How many children are in the family?$mq$, $mq$["Two","Three","Four","Five"]$mq$, 1, $mq$The children are Hugo, Zoé and the speaker. The other two people are the parents.$mq$, $mq$medium$mq$),
($mq$What does 'Je n'ai pas de frère' mean?$mq$, $mq$["I have no brother","I have one brother","I don't like my brother","I have two brothers"]$mq$, 0, $mq$After a negative, 'un' or 'des' becomes 'de': 'Je n'ai pas de frère' means I don't have a brother.$mq$, $mq$medium$mq$),
($mq$Ma tante et mon oncle ont une fille. Pour moi, elle est ma ___.$mq$, $mq$["sœur","nièce","tante","cousine"]$mq$, 3, $mq$The daughter of your aunt and uncle is your cousin, 'ma cousine'.$mq$, $mq$medium$mq$),
($mq$Marie says: 'Voici mon ami Paul et sa sœur.' Whose sister is it?$mq$, $mq$["Marie's","Both Marie's and Paul's","Paul's","Nobody's"]$mq$, 2, $mq$'Sa' means his or her and agrees with the noun 'sœur' (feminine). The owner here is Paul, so it is 'his sister'.$mq$, $mq$medium$mq$),
($mq$Which sentence is correct?$mq$, $mq$["J'ai un sœur.","J'ai une sœur.","J'ai une frère.","J'ai un sœurs."]$mq$, 1, $mq$'Sœur' is feminine, so it takes 'une'. 'Un' goes with masculine nouns such as 'frère'.$mq$, $mq$medium$mq$),
($mq$In a family description, 'mon beau-père' most likely means:$mq$, $mq$["my stepfather","my grandfather","my uncle","my handsome father"]$mq$, 0, $mq$'Beau-père' means stepfather (or father-in-law). The word 'beau' here does not mean handsome.$mq$, $mq$medium$mq$),
($mq$Read: 'Ma mère est la sœur de mon oncle Paul. Paul a deux enfants, Léo et Jade.' Who is Léo to the speaker?$mq$, $mq$["Brother","Uncle","Nephew","Cousin"]$mq$, 3, $mq$Paul is the speaker's uncle, so Paul's son Léo is the speaker's cousin.$mq$, $mq$hard$mq$),
($mq$Read: 'Ils ont trois enfants : deux fils et une fille.' Which statement is true?$mq$, $mq$["They have two daughters and one son","They have three sons","They have two sons and one daughter","They have two sons and two daughters"]$mq$, 2, $mq$'Fils' means sons and 'fille' means daughter. Two sons plus one daughter makes three children.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'J'ai un frère et deux demi-sœurs. Mon père s'est remarié. Ma belle-mère s'appelle Nadia.' Who is Nadia?$mq$, $mq$["The speaker's sister","The speaker's stepmother","The speaker's aunt","The speaker's mother"]$mq$, 1, $mq$The father remarried, so his new wife is the speaker's 'belle-mère' (stepmother).$mq$, $mq$hard$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["Il n'a pas des frères.","Elle a deux frères.","Nous avons une sœur.","Ils ont un cousin."]$mq$, 0, $mq$After a negative the article becomes 'de': 'Il n'a pas de frères'. The other sentences are correct.$mq$, $mq$hard$mq$),
($mq$Emma writes: 'Je suis enfant unique, mais j'ai trois cousins.' What does she have?$mq$, $mq$["Three brothers or sisters","Three cousins and a twin","No cousins","No brothers or sisters, but three cousins"]$mq$, 3, $mq$'Enfant unique' means only child, and 'mais j'ai trois cousins' says she nevertheless has three cousins.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Family Members$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$le père / la mère / les parents$mq$, $mq$father / mother / parents (mother and father). 'Les parents' does NOT mean relatives.$mq$),
($mq$le frère / la sœur$mq$, $mq$brother / sister. J'ai un frère et une sœur.$mq$),
($mq$grand-père, grand-mère, grands-parents$mq$, $mq$grandfather, grandmother, grandparents.$mq$),
($mq$l'oncle / la tante / le cousin / la cousine$mq$, $mq$uncle / aunt / male cousin / female cousin.$mq$),
($mq$fils unique / fille unique / enfant unique$mq$, $mq$only child (boy / girl / either). Je suis fille unique = I am an only child (girl).$mq$),
($mq$beau-père / belle-mère / demi-frère$mq$, $mq$stepfather (or father-in-law) / stepmother / half-brother.$mq$),
($mq$avoir: present tense$mq$, $mq$j'ai, tu as, il/elle a, nous avons, vous avez, ils/elles ont.$mq$),
($mq$Je n'ai pas de frère.$mq$, $mq$I don't have a brother. After a negative, un/une/des become de (d').$mq$),
($mq$mon, ma, mes / son, sa, ses$mq$, $mq$my (masc, fem, plural) / his or her. They agree with the noun, not the owner. Before a vowel: mon amie.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Family Members$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Talking about your family
Family is one of the most common topics in the eAssessment. Texts often describe who lives in a house, who is related to whom, and how old people are. You need the vocabulary, the verb avoir (to have) and possessive words (my, your, his or her).

## Family vocabulary
- le père (father), la mère (mother), les parents (mother and father)
- le frère (brother), la sœur (sister)
- le grand-père (grandfather), la grand-mère (grandmother), les grands-parents (grandparents)
- l'oncle (uncle), la tante (aunt)
- le cousin (male cousin), la cousine (female cousin)
- le fils (son), la fille (daughter or girl), l'enfant (child)
- le mari (husband), la femme (wife or woman)
- le beau-père (stepfather), la belle-mère (stepmother)
- le demi-frère (half-brother), la demi-sœur (half-sister)
- fils unique / fille unique / enfant unique (only child)

Watch the false friend: les parents means mother and father, not relatives.

## Saying what you have
Avoir: j'ai, tu as, il/elle a, nous avons, vous avez, ils/elles ont.
- J'ai un frère et deux sœurs. (I have one brother and two sisters.)
- Elle a une cousine à Paris.
- Il y a cinq personnes dans ma famille. (There are five people in my family.)

In the negative the article changes to de (or d'): Je n'ai pas de frère. Nous n'avons pas de sœur. The exception is the verb être: Ce n'est pas un frère.

## Possessive adjectives
They agree with the noun that follows, not with the owner.
- mon père, ma mère, mes parents (my)
- ton père, ta mère, tes parents (your, informal)
- son père, sa mère, ses parents (his or her)
- notre père, nos parents (our)
- votre père, vos parents (your, formal or plural)
- leur père, leurs parents (their)
Before a vowel use mon, ton, son even with feminine nouns: mon amie, ton école.
So 'sa sœur' can mean his sister or her sister. The context tells you whose she is.

## Worked example
Read: Ma mère est la sœur de mon oncle Paul. Paul a deux enfants, Léo et Jade.
Step 1: Paul is the speaker's uncle. Step 2: his children are the uncle's children. Step 3: the speaker's uncle's children are the speaker's cousins. So Léo is mon cousin.

## Describing a family in 4 lines
Dans ma famille, il y a cinq personnes : mes parents, mon frère Hugo, ma sœur Zoé et moi. Mon père s'appelle Marc et ma mère s'appelle Sara. Hugo a douze ans et Zoé a neuf ans. Mes grands-parents habitent à Lille.

## Common mistakes
- Using un with feminine nouns: une sœur, une tante, une cousine.
- Using pas des / pas un after a negative instead of pas de.
- Mixing up son/sa: choose it from the noun, not the owner.
- Reading les parents as relatives.

## How this is examined
Typical tasks are a short email or profile in which someone describes their family, followed by questions such as 'How many brothers and sisters does Nina have?' or 'Who is Marc?'. You must count people and work out relationships. In writing, you may be asked to describe your family in 40 to 60 words.

Exam tip: When a text names several people, sketch a mini family tree with initials as you read. It stops you confusing brother, cousin and uncle under time pressure.$mq$ from st;

-- Family and Friends > Describing People
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Family and Friends$mq$, 5, 2 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Describing People$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Family and Friends$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Describing People$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'petit' mean?$mq$, $mq$["small or short","tall","fat","old"]$mq$, 0, $mq$'Petit' means small or short. 'Grand' means tall or big.$mq$, $mq$easy$mq$),
($mq$What does 'Il a les cheveux blonds' mean?$mq$, $mq$["He has blue eyes","He is tall and blond","He has brown hair","He has blond hair"]$mq$, 3, $mq$'Les cheveux' is hair and 'blonds' means blond. It says nothing about height or eyes.$mq$, $mq$easy$mq$),
($mq$What does 'timide' mean?$mq$, $mq$["funny","kind","shy","lazy"]$mq$, 2, $mq$'Timide' means shy. Funny is 'drôle', kind is 'gentil' and lazy is 'paresseux'.$mq$, $mq$easy$mq$),
($mq$What does 'les yeux bleus' mean?$mq$, $mq$["blue hair","blue eyes","green eyes","big eyes"]$mq$, 1, $mq$'Les yeux' means the eyes (plural of 'œil') and 'bleus' means blue.$mq$, $mq$easy$mq$),
($mq$What does 'âgé' mean in 'un homme âgé'?$mq$, $mq$["old, elderly","tall","young","kind"]$mq$, 0, $mq$'Âgé' means old or elderly, and 'jeune' means young.$mq$, $mq$easy$mq$),
($mq$What is the feminine form of 'sportif'?$mq$, $mq$["sportife","sportifle","sportif","sportive"]$mq$, 3, $mq$Adjectives ending in -if change to -ive in the feminine: sportif becomes sportive.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Ma sœur est ___.'$mq$, $mq$["gentil","gentils","gentille","gentilles"]$mq$, 2, $mq$'Sœur' is feminine singular, so the adjective is 'gentille'.$mq$, $mq$medium$mq$),
($mq$Read: 'Mon ami Tom est grand et mince. Il a les cheveux roux et les yeux verts.' Which description matches Tom?$mq$, $mq$["Short and fat with brown hair","Tall and slim with red hair and green eyes","Tall with blond hair and blue eyes","Slim with black hair and green eyes"]$mq$, 1, $mq$'Grand' is tall, 'mince' is slim, 'roux' is red or ginger and 'verts' is green.$mq$, $mq$medium$mq$),
($mq$Which adjective stays the same in the feminine?$mq$, $mq$["timide","petit","gentil","sportif"]$mq$, 0, $mq$Adjectives that already end in -e do not change in the feminine: un garçon timide, une fille timide.$mq$, $mq$medium$mq$),
($mq$Which sentence is correct?$mq$, $mq$["Elle est grand.","Elle est grandes.","Elle a grande.","Elle est grande."]$mq$, 3, $mq$A feminine singular subject needs a feminine singular adjective: 'grande'. The verb 'être' is needed with adjectives of size.$mq$, $mq$medium$mq$),
($mq$What does 'Mon frère est bavard' tell you?$mq$, $mq$["He is quiet","He is lazy","He is talkative","He is shy"]$mq$, 2, $mq$'Bavard' means talkative or chatty.$mq$, $mq$medium$mq$),
($mq$What is the opposite of 'paresseux'?$mq$, $mq$["timide","travailleur","gros","triste"]$mq$, 1, $mq$'Paresseux' means lazy, so its opposite is 'travailleur' (hard-working).$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Mes amies sont ___.' (sympa)$mq$, $mq$["sympas","sympa","sympathe","sympate"]$mq$, 0, $mq$'Sympa' has the same form in the masculine and feminine but takes -s in the plural: 'sympas'.$mq$, $mq$medium$mq$),
($mq$Read: 'Ma cousine Lola est très drôle mais un peu timide. Elle est petite et elle a les cheveux longs et châtains.' Which statement is true?$mq$, $mq$["She is tall with short hair","She is serious and loud","She is old with grey hair","She is funny but a little shy and has long brown hair"]$mq$, 3, $mq$'Drôle' is funny, 'un peu timide' is a little shy, 'longs' is long and 'châtains' is chestnut or brown.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'She has long dark hair'?$mq$, $mq$["Elle est les cheveux longs noirs.","Elle a des cheveux longues noirs.","Elle a les cheveux longs et noirs.","Elle a le cheveu long noir."]$mq$, 2, $mq$Hair description uses avoir, and 'cheveux' is masculine plural, so the adjectives are 'longs' and 'noirs'.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'Mon professeur est un homme assez âgé. Il est mince, il porte des lunettes et il est très patient. Il n'est pas sévère.' Which statement is true?$mq$, $mq$["He is young and strict","He is fairly old, patient and not strict","He is fat and strict","He is young and patient"]$mq$, 1, $mq$'Assez âgé' is fairly old, 'patient' is patient and 'pas sévère' is not strict.$mq$, $mq$hard$mq$),
($mq$Complete the sentence: 'Mes sœurs sont ___ et ___.'$mq$, $mq$["travailleuses / généreuses","travailleurs / généreux","travailleuse / généreuse","travailleuses / généreux"]$mq$, 0, $mq$The subject is feminine plural, so both adjectives need feminine plural endings: -euses.$mq$, $mq$hard$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["Il est paresseux.","Elles sont amusantes.","Ils sont sympas.","Elle est sportif."]$mq$, 3, $mq$A feminine subject needs the feminine form: 'Elle est sportive'. The other sentences agree correctly.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Describing People$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$grand / petit / mince / gros$mq$, $mq$tall / short or small / slim / big or plump. Feminine: grande, petite, mince, grosse.$mq$),
($mq$Il a les cheveux courts et bruns.$mq$, $mq$He has short brown hair. Hair and eyes use avoir, and cheveux and yeux are plural.$mq$),
($mq$les yeux bleus / verts / gris / noirs$mq$, $mq$blue / green / grey / black eyes.$mq$),
($mq$Feminine of sportif, généreux, gentil$mq$, $mq$sportive, généreuse, gentille. Rules: -if to -ive, -eux to -euse, -il to -ille.$mq$),
($mq$Adjectives that do not change in the feminine$mq$, $mq$Those already ending in -e: timide, jeune, mince, sympa. Plural adds -s: timides, sympas.$mq$),
($mq$timide / bavard / drôle / paresseux$mq$, $mq$shy / talkative / funny / lazy.$mq$),
($mq$travailleur / travailleuse$mq$, $mq$hard-working (masculine / feminine). Opposite: paresseux / paresseuse.$mq$),
($mq$très, assez, un peu$mq$, $mq$very, quite, a little. They change the strength of the adjective: assez timide = quite shy.$mq$),
($mq$Where do adjectives usually go?$mq$, $mq$After the noun: les cheveux bruns. Short common ones (grand, petit, jeune, bon) go before: un grand garçon.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Describing People$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Describing appearance and personality
In reading and writing tasks you must describe people (a friend, a family member, a teacher) and understand descriptions. The words are adjectives, and in French adjectives agree with the noun they describe. That means gender (masculine or feminine) and number (singular or plural).

## Appearance vocabulary
- grand(e) (tall), petit(e) (short, small), mince (slim), gros / grosse (big or plump), jeune (young), âgé(e) (old, elderly)
- Il a les cheveux courts, longs, blonds, bruns, noirs, roux (red), châtains (brown). (He has short, long, blond, brown, black, red, chestnut hair.)
- Elle a les yeux bleus, verts, gris, noirs. (She has blue, green, grey, black eyes.)
- Il porte des lunettes. (He wears glasses.)

Use avoir for hair and eyes (Elle a les yeux verts) and être for height and build (Elle est grande).

## Personality vocabulary
- sympa (nice), gentil / gentille (kind), drôle (funny), amusant(e) (fun), timide (shy), bavard(e) (talkative)
- sportif / sportive (sporty), intelligent(e), travailleur / travailleuse (hard-working), paresseux / paresseuse (lazy), généreux / généreuse (generous)
- patient(e), sévère (strict), content(e) (happy), triste (sad)

## Agreement rules
- Feminine: usually add -e. grand, grande; petit, petite; intelligent, intelligente.
- No change if it already ends in -e: timide, jeune, mince, sympa.
- -if becomes -ive: sportif, sportive.
- -eux becomes -euse: généreux, généreuse; paresseux, paresseuse.
- -eur often becomes -euse: travailleur, travailleuse.
- -il becomes -ille: gentil, gentille.
- Plural: add -s (grands, grandes). Words already ending in -s or -x stay the same: gros, paresseux.
- Colours of hair: blond, blonde, blonds, blondes. For cheveux (masculine plural): les cheveux blonds, longs.

Sympa takes -s in the plural but not an -e in the feminine: des amies sympas.

## Word order
Most adjectives come after the noun (les cheveux bruns). Short common ones like grand, petit, jeune and bon come before it (un grand garçon).

## Worked example
Mon ami Tom est grand et mince. Il a les cheveux roux et les yeux verts. Il est très sympa et assez timide.
Translation: My friend Tom is tall and slim. He has red hair and green eyes. He is very nice and quite shy.
Now his sister: Ma copine Léa est grande et mince. Elle a les cheveux roux et les yeux verts. Elle est très sympa et assez timide.
Notice what changes: only the adjectives that have a different feminine form, and the pronoun.

## Common mistakes
- Forgetting agreement: Elle est grand. Write Elle est grande.
- Using être for hair: Elle est les cheveux longs. Write Elle a les cheveux longs.
- Writing the wrong plural: Mes sœurs sont gentil. Write gentilles.
- Mixing up gros (big) with grand (tall).

## How this is examined
You will often read a short profile or message and match it to a picture described in words, or find which person fits a description. Listening transcripts describe a teacher, a friend or a missing person. Marks in writing are given for correct agreement and a variety of adjectives such as très, assez and un peu.

Exam tip: Intensifiers like très (very), assez (quite) and un peu (a little) change the meaning of the whole description. Underline them before choosing between two similar options.$mq$ from st;

-- Family and Friends > Pets and Possessions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Family and Friends$mq$, 5, 2 from public.subjects s where s.slug = $mq$french-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Pets and Possessions$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Family and Friends$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Pets and Possessions$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'un chien' mean?$mq$, $mq$["a dog","a cat","a fish","a rabbit"]$mq$, 0, $mq$'Un chien' is a dog. A cat is 'un chat'.$mq$, $mq$easy$mq$),
($mq$What does 'J'ai un chat' mean?$mq$, $mq$["I am a cat","I like cats","I see a dog","I have a cat"]$mq$, 3, $mq$'J'ai' is 'I have' and 'un chat' is a cat.$mq$, $mq$easy$mq$),
($mq$What does 'un oiseau' mean?$mq$, $mq$["a horse","a mouse","a bird","a turtle"]$mq$, 2, $mq$'Un oiseau' is a bird. A mouse is 'une souris' and a turtle is 'une tortue'.$mq$, $mq$easy$mq$),
($mq$What does 'un téléphone portable' mean?$mq$, $mq$["a laptop","a mobile phone","a watch","a bag"]$mq$, 1, $mq$'Téléphone portable' is a mobile phone. A laptop is 'un ordinateur portable'.$mq$, $mq$easy$mq$),
($mq$What does 'un lapin' mean?$mq$, $mq$["a rabbit","a horse","a hamster","a pig"]$mq$, 0, $mq$'Un lapin' is a rabbit. A horse is 'un cheval'.$mq$, $mq$easy$mq$),
($mq$Complete the question: 'Tu ___ un hamster ?'$mq$, $mq$["a","ai","avez","as"]$mq$, 3, $mq$With 'tu' the verb avoir is 'as': 'Tu as un hamster ?'.$mq$, $mq$medium$mq$),
($mq$What does 'Je n'ai pas de chien' mean?$mq$, $mq$["I have a dog","I don't like dogs","I have no dog","I want a dog"]$mq$, 2, $mq$'Ne ... pas de' means 'not any'. The sentence says the speaker does not have a dog.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'C'est ___ vélo.' (his/her)$mq$, $mq$["sa","son","ses","leur"]$mq$, 1, $mq$'Vélo' is masculine singular, so 'his or her' is 'son'.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Voici ___ chiens.' (our)$mq$, $mq$["nos","notre","leur","vos"]$mq$, 0, $mq$'Chiens' is plural, so 'our' is 'nos'. Notre is singular.$mq$, $mq$medium$mq$),
($mq$Read: 'J'ai deux chats. Ils s'appellent Minou et Tigre. Minou est noir et Tigre est blanc.' Which statement is correct?$mq$, $mq$["Both cats are black","Tigre is black and Minou is white","Both cats are white","Minou is black and Tigre is white"]$mq$, 3, $mq$'Noir' is black and 'blanc' is white. Minou is black and Tigre is white.$mq$, $mq$medium$mq$),
($mq$Read: 'Mon chien est très gentil, mais il mange beaucoup !' What do we learn about the dog?$mq$, $mq$["He sleeps a lot","He runs fast","He eats a lot","He barks a lot"]$mq$, 2, $mq$'Il mange beaucoup' means 'he eats a lot'.$mq$, $mq$medium$mq$),
($mq$What does 'le chat de Marie' mean?$mq$, $mq$["the cat is Marie","Marie's cat","Marie has cats","the cat with Marie"]$mq$, 1, $mq$French shows possession with 'de': 'le chat de Marie' is Marie's cat.$mq$, $mq$medium$mq$),
($mq$Complete the sentence: 'Ils ___ une tortue.'$mq$, $mq$["ont","a","sont","avons"]$mq$, 0, $mq$'Avoir' with 'ils' is 'ont': 'Ils ont une tortue' (They have a turtle).$mq$, $mq$medium$mq$),
($mq$Read: 'Léo a un lapin. Sa sœur a deux poissons. Leurs parents n'ont pas d'animaux.' How many pets does the whole family have?$mq$, $mq$["Two","Four","None","Three"]$mq$, 3, $mq$Léo has one rabbit and his sister has two fish: 1 + 2 = 3. The parents have no pets.$mq$, $mq$hard$mq$),
($mq$Which sentence uses 'leurs' correctly?$mq$, $mq$["Ils aiment leur chiens.","Elles aiment leurs chien.","Ils aiment leurs chiens.","Ils aiment ses chiens."]$mq$, 2, $mq$'Chiens' is plural, so 'their' is 'leurs'. 'Leur' is for a singular noun.$mq$, $mq$hard$mq$),
($mq$Which sentence is NOT correct?$mq$, $mq$["Je n'ai pas de livres.","Elle n'a pas des animaux.","Il n'a pas de sac.","Nous n'avons pas de chien."]$mq$, 1, $mq$After a negative, 'des' becomes 'de' (d' before a vowel): 'Elle n'a pas d'animaux'.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 'J'ai un chien, il s'appelle Max. Il est grand et marron. J'ai aussi un ordinateur et une tablette, mais je n'ai pas de téléphone portable.' Which item does the speaker NOT have?$mq$, $mq$["A mobile phone","A dog","A tablet","A computer"]$mq$, 0, $mq$The speaker has a dog, a computer and a tablet, but says 'je n'ai pas de téléphone portable'.$mq$, $mq$hard$mq$),
($mq$'À qui est ce sac ? - C'est le sac de ma sœur.' Whose bag is it?$mq$, $mq$["The speaker's","The teacher's","Nobody's","The speaker's sister's"]$mq$, 3, $mq$'À qui est...' means 'Whose is...' and the answer 'le sac de ma sœur' says the bag belongs to the speaker's sister.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Pets and Possessions$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$un chien, un chat, un lapin$mq$, $mq$a dog, a cat, a rabbit.$mq$),
($mq$un oiseau, un poisson, un cheval$mq$, $mq$a bird, a fish, a horse.$mq$),
($mq$une tortue, une souris, un hamster$mq$, $mq$a turtle (tortoise), a mouse, a hamster.$mq$),
($mq$un téléphone portable, un ordinateur, une tablette$mq$, $mq$a mobile phone, a computer, a tablet.$mq$),
($mq$un vélo, un sac, une montre$mq$, $mq$a bike, a bag, a watch.$mq$),
($mq$Je n'ai pas de chien.$mq$, $mq$I don't have a dog. After a negative, un/une/des become de (d').$mq$),
($mq$leur vs leurs$mq$, $mq$Their. Leur with a singular noun (leur chien), leurs with a plural noun (leurs chiens).$mq$),
($mq$le chat de Marie$mq$, $mq$Marie's cat. French shows possession with de, never with an apostrophe-s.$mq$),
($mq$À qui est ce sac ?$mq$, $mq$Whose bag is this? Answer: C'est le sac de ma sœur or C'est à moi (it's mine).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Pets and Possessions$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Pets and possessions
Talking about animals and the things you own gives you chances to use avoir, possessive words, the negative and simple descriptions in the same sentence. These topics appear in friendly emails, pen-friend profiles and classified-ad style texts.

## Pets
- un chien (dog), un chat (cat), un lapin (rabbit), un hamster (hamster), un cochon d'Inde (guinea pig)
- un oiseau (bird), un poisson (fish), un cheval (horse), une tortue (turtle or tortoise), une souris (mouse)
- un animal, des animaux (pet or animal, animals)

Talking about them:
- J'ai un chien. Il s'appelle Max. Il est grand et marron.
- Mon chat est noir et blanc. Il dort beaucoup.
- Je n'ai pas d'animaux. (I have no pets.)
- Nous avons deux poissons.

## Possessions
- un téléphone portable (mobile phone), un ordinateur (computer), une tablette (tablet)
- un vélo (bike), une planche à roulettes (skateboard), un sac (bag), une montre (watch)
- un livre (book), des jeux vidéo (video games), un appareil photo (camera)

## Avoir and the negative
Avoir: j'ai, tu as, il/elle a, nous avons, vous avez, ils/elles ont.
- Tu as un chien ? Non, je n'ai pas de chien.
- Elle a un vélo. Elle n'a pas de téléphone.
After ne ... pas, un, une and des all become de (d' before a vowel): Il n'a pas d'ordinateur.

## Possessive adjectives
Singular nouns: mon / ma, ton / ta, son / sa, notre, votre, leur.
Plural nouns: mes, tes, ses, nos, vos, leurs.
They agree with the thing owned, not with the owner. 'Son chat' is his cat or her cat. 'Leurs chats' means their cats.

## Showing who owns something
French has no apostrophe-s. Use de:
- le chat de Marie (Marie's cat)
- le vélo de mon frère (my brother's bike)
- À qui est ce sac ? (Whose bag is this?) C'est le sac de ma sœur. / C'est à moi. (It's mine.)

## Worked example
Read: Léo a un lapin. Sa sœur a deux poissons. Leurs parents n'ont pas d'animaux.
Step 1: Léo has 1 rabbit. Step 2: his sister has 2 fish. Step 3: 1 + 2 = 3 pets in total; the parents have none. The answer is three.

## Common mistakes
- Keeping un or des after a negative: Je n'ai pas un chien. Write Je n'ai pas de chien.
- Mixing up leur and leurs, and son, sa and ses.
- Forgetting that animal(s) become animaux in the plural.

## How this is examined
Expect a friend's message or a short advert such as a lost-pet notice. You identify the animal, its colour and its owner, and count items. In listening transcripts someone lists what they have and what they do not have, and you must spot the negative. In writing you describe your pets and one or two possessions in correct sentences.

Exam tip: Look for ne ... pas (or n'... pas) before you decide whether someone has an item. A single negative word reverses the answer.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;