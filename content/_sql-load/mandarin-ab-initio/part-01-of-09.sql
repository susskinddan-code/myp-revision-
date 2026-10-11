-- Part 1 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Greetings and Introductions > Greetings and Farewells
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Greetings and Introductions$mq$, 5, 1 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Greetings and Farewells$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Greetings and Introductions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Greetings and Farewells$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 再见 (zàijiàn) mean?$mq$, $mq$["Goodbye","Hello","Thank you","Sorry"]$mq$, 0, $mq$再见 is the standard way to say goodbye. Literally it means 'again see'.$mq$, $mq$easy$mq$),
($mq$What does 谢谢 (xièxie) mean?$mq$, $mq$["Excuse me","Good night","You're welcome","Thank you"]$mq$, 3, $mq$谢谢 means thank you. The reply 'you're welcome' is 不客气 (bú kèqi).$mq$, $mq$easy$mq$),
($mq$Which phrase means 'Good morning'?$mq$, $mq$["晚上好 (wǎnshang hǎo)","晚安 (wǎn'ān)","早上好 (zǎoshang hǎo)","再见 (zàijiàn)"]$mq$, 2, $mq$早上 means morning, so 早上好 is good morning. 晚上好 is good evening and 晚安 is good night.$mq$, $mq$easy$mq$),
($mq$What does 晚安 (wǎn'ān) mean?$mq$, $mq$["Good morning","Good night","See you tomorrow","Hello"]$mq$, 1, $mq$晚安 is said when someone is going to bed. It is a farewell, not a greeting.$mq$, $mq$easy$mq$),
($mq$Which phrase means 'You're welcome'?$mq$, $mq$["不客气 (bú kèqi)","对不起 (duìbuqǐ)","你好 (nǐ hǎo)","请进 (qǐng jìn)"]$mq$, 0, $mq$不客气 literally means 'don't be polite' and is the usual reply to 谢谢. 对不起 means sorry.$mq$, $mq$easy$mq$),
($mq$You meet your grandmother's friend, an elderly lady, for the first time. Which greeting is the most polite?$mq$, $mq$["你好 (nǐ hǎo)","再见 (zàijiàn)","晚安 (wǎn'ān)","您好 (nín hǎo)"]$mq$, 3, $mq$您 is the respectful form of 你 and is used for elders and teachers. 再见 and 晚安 are farewells.$mq$, $mq$medium$mq$),
($mq$Mei asks you: 你好吗？(nǐ hǎo ma?) Which reply fits best?$mq$, $mq$["不客气。(bú kèqi.)","再见。(zàijiàn.)","我很好，谢谢。(wǒ hěn hǎo, xièxie.)","对不起。(duìbuqǐ.)"]$mq$, 2, $mq$你好吗 means 'How are you?' and 我很好，谢谢 means 'I'm very well, thanks'. The other replies answer different things.$mq$, $mq$medium$mq$),
($mq$What does 明天见 (míngtiān jiàn) mean?$mq$, $mq$["See you tonight","See you tomorrow","Good morning","Good night"]$mq$, 1, $mq$明天 means tomorrow and 见 means see, so 明天见 is 'see you tomorrow'.$mq$, $mq$medium$mq$),
($mq$Your teacher walks in and says 同学们好 (tóngxuémen hǎo), 'Hello, everyone'. What do students usually reply?$mq$, $mq$["老师好 (lǎoshī hǎo)","晚安 (wǎn'ān)","不客气 (bú kèqi)","对不起 (duìbuqǐ)"]$mq$, 0, $mq$Students greet the teacher with 老师好, meaning 'Hello, teacher'. The other phrases do not fit a classroom greeting.$mq$, $mq$medium$mq$),
($mq$You step on a classmate's foot and say 对不起 (duìbuqǐ). What does your classmate say to show it is okay?$mq$, $mq$["谢谢 (xièxie)","早上好 (zǎoshang hǎo)","再见 (zàijiàn)","没关系 (méi guānxi)"]$mq$, 3, $mq$没关系 means 'it doesn't matter / no problem' and answers an apology. 谢谢 would reply to a favour.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 小明: 早上好，李老师！(Xiǎomíng: Zǎoshang hǎo, Lǐ lǎoshī!) 李老师: 早上好，小明。你好吗？(Lǐ lǎoshī: Zǎoshang hǎo, Xiǎomíng. Nǐ hǎo ma?) 小明: 我很好，谢谢。(Xiǎomíng: Wǒ hěn hǎo, xièxie.)

When does this conversation take place?$mq$, $mq$["In the evening","At bedtime","In the morning","In the afternoon"]$mq$, 2, $mq$Both speakers say 早上好, 'good morning'. Teacher Li also asks how Xiaoming is, and he says he is well.$mq$, $mq$medium$mq$),
($mq$A sign on a classroom door says 请进 (qǐng jìn). What does it ask you to do?$mq$, $mq$["Please be quiet","Please come in","Please sit down","Please go away"]$mq$, 1, $mq$请 means please and 进 means enter. 'Please sit down' is 请坐 (qǐng zuò).$mq$, $mq$medium$mq$),
($mq$Which is the correct pinyin with tone marks for 谢谢?$mq$, $mq$["xièxie","xiéxie","xièxiě","xiěxie"]$mq$, 0, $mq$谢 is fourth tone (è) and the second 谢 is normally said in the neutral tone, so we write xièxie.$mq$, $mq$medium$mq$),
($mq$In 你好 (nǐ hǎo), both syllables are third tone. How is it actually pronounced?$mq$, $mq$["Both syllables sound like first tone","The second syllable sounds like fourth tone","Both syllables are said low and flat","The first syllable sounds like second tone (ní hǎo)"]$mq$, 3, $mq$When two third tones meet, the first changes to a rising second tone. We still write nǐ hǎo.$mq$, $mq$hard$mq$),
($mq$Li says 晚上好 (wǎnshang hǎo) to her teacher at 8 a.m. What is the mistake?$mq$, $mq$["晚上好 is too informal for a teacher","晚上好 means 'goodbye'; she should say 再见","晚上好 means 'good evening'; she should say 早上好","There is no mistake; 晚上好 means hello at any time"]$mq$, 2, $mq$晚上 means evening or night. In the morning the correct greeting is 早上好.$mq$, $mq$hard$mq$),
($mq$Transcript: 小红: 晚安，妈妈！(Xiǎohóng: Wǎn'ān, māma!) 妈妈: 晚安，明天见！(Māma: Wǎn'ān, míngtiān jiàn!)

What can you conclude?$mq$, $mq$["It is morning and they are meeting for the first time","It is bedtime and they will meet again tomorrow","It is evening and they will not meet again","It is lunchtime and they are saying thank you"]$mq$, 1, $mq$晚安 shows it is bedtime and 明天见 means 'see you tomorrow'. Nothing in the text suggests a first meeting or a thank-you.$mq$, $mq$hard$mq$),
($mq$Which question-and-answer pair is NOT a natural exchange?$mq$, $mq$["A: 谢谢！(xièxie!) B: 早上好。(zǎoshang hǎo.)","A: 你好吗？(nǐ hǎo ma?) B: 我很好。(wǒ hěn hǎo.)","A: 对不起！(duìbuqǐ!) B: 没关系。(méi guānxi.)","A: 谢谢！(xièxie!) B: 不客气。(bú kèqi.)"]$mq$, 0, $mq$'Thanks' should be answered with 不客气, not with a morning greeting. The other three pairs are normal.$mq$, $mq$hard$mq$),
($mq$Tom is visiting his friend's grandfather in the evening. Which pair of phrases is the best polite greeting on arrival and farewell on leaving?$mq$, $mq$["晚安 (wǎn'ān) ... 您好 (nín hǎo)","早上好 (zǎoshang hǎo) ... 不客气 (bú kèqi)","对不起 (duìbuqǐ) ... 请进 (qǐng jìn)","您好 (nín hǎo) ... 再见 (zàijiàn)"]$mq$, 3, $mq$您好 greets an elder politely and 再见 says goodbye. 晚安 is only for bedtime and 不客气 is a reply to thanks.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Greetings and Farewells$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$你好 (nǐ hǎo)$mq$, $mq$Hello. Written nǐ hǎo but said ní hǎo, because the first of two third tones becomes a second tone.$mq$),
($mq$您好 (nín hǎo)$mq$, $mq$Hello, polite form. 您 is the respectful 'you', used with elders, teachers and strangers.$mq$),
($mq$早上好 / 晚上好$mq$, $mq$早上好 (zǎoshang hǎo) = good morning; 晚上好 (wǎnshang hǎo) = good evening.$mq$),
($mq$晚安 (wǎn'ān)$mq$, $mq$Good night. Said only at bedtime as a farewell, never as a hello.$mq$),
($mq$再见 / 明天见$mq$, $mq$再见 (zàijiàn) = goodbye; 明天见 (míngtiān jiàn) = see you tomorrow.$mq$),
($mq$谢谢 → ?$mq$, $mq$The reply to 谢谢 (xièxie, thank you) is 不客气 (bú kèqi), 'you're welcome'.$mq$),
($mq$对不起 → ?$mq$, $mq$对不起 (duìbuqǐ) means 'I'm sorry'. Reply with 没关系 (méi guānxi), 'it doesn't matter'.$mq$),
($mq$你好吗？ → ?$mq$, $mq$How are you? Reply: 我很好，谢谢。(wǒ hěn hǎo, xièxie.) = I'm very well, thank you. 吗 (ma) makes a question.$mq$),
($mq$请进 / 请坐$mq$, $mq$请进 (qǐng jìn) = please come in; 请坐 (qǐng zuò) = please sit down. 请 (qǐng) means please.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Greetings and Farewells$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why greetings matter
Greetings are the first thing tested in beginner Mandarin, and they appear in nearly every reading and listening task. Mandarin is a tonal language, so always learn each word together with its pinyin (the Roman-letter spelling) and tone marks. The four tones are first (ā, high and flat), second (á, rising), third (ǎ, dipping) and fourth (à, falling). A fifth, neutral tone has no mark.

## Hello and how are you
- 你好 (nǐ hǎo): hello, the all-purpose greeting
- 您好 (nín hǎo): hello, very polite, for elders and teachers
- 早上好 (zǎoshang hǎo): good morning
- 晚上好 (wǎnshang hǎo): good evening
- 老师好 (lǎoshī hǎo): hello, teacher
- 同学们好 (tóngxuémen hǎo): hello, everyone (said by a teacher to students)
- 你好吗？(nǐ hǎo ma?): how are you?
- 我很好，谢谢。(wǒ hěn hǎo, xièxie.): I'm very well, thank you.

The word 吗 (ma) turns a statement into a yes/no question, so 你好 becomes 你好吗？. Notice that you say 很 (hěn, very) before 好 when describing yourself.

## Goodbyes
- 再见 (zàijiàn): goodbye
- 明天见 (míngtiān jiàn): see you tomorrow
- 一会儿见 (yíhuìr jiàn): see you in a moment
- 晚安 (wǎn'ān): good night, only said at bedtime

## Thanks, sorry and polite words
- 谢谢 (xièxie): thank you
- 不客气 (bú kèqi): you're welcome
- 对不起 (duìbuqǐ): I'm sorry
- 没关系 (méi guānxi): it doesn't matter, no problem
- 请 (qǐng): please, as in 请进 (qǐng jìn, please come in) and 请坐 (qǐng zuò, please sit)

## Tone changes you must know
When two third tones come together, the first one is pronounced as a second tone. So 你好 is written nǐ hǎo but said ní hǎo. Also, 不 (bù) becomes bú before a fourth-tone syllable, which is why 不客气 is written bú kèqi. You write the changed form for 不 but the original form for the third-tone rule.

## Formal or friendly?
Use 您 with teachers, grandparents and strangers who are clearly older. Use 你 with friends and classmates. In a classroom, students stand and say 老师好 when the teacher arrives.

## Common mistakes
- Mixing up 早上好 (morning) and 晚上好 (evening) because both end in 好.
- Using 晚安 as hello. It means good night and is only a farewell.
- Replying 谢谢 to 谢谢. The reply is 不客气.
- Forgetting tone marks. Without them the pinyin is wrong in an exam.

## How this is examined
In the reading and listening papers, greetings appear in short dialogues, notes and signs. You may be asked to match a phrase to its English meaning, choose a suitable reply, work out the time of day from the greeting, or decide whether a speaker is being formal or informal. In writing tasks you can earn marks by opening and closing a message with a correct greeting and farewell, such as 你好 at the start and 再见 or 明天见 at the end.

Exam tip: Look for the key character in each phrase (早, 晚, 谢, 对, 见). Spotting one known character is often enough to choose the right answer, and always copy pinyin tone marks carefully.$mq$ from st;

-- Greetings and Introductions > Introducing Yourself and Others
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Greetings and Introductions$mq$, 5, 1 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Introducing Yourself and Others$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Greetings and Introductions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Introducing Yourself and Others$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 我叫大卫 (wǒ jiào Dàwèi) mean?$mq$, $mq$["My name is David","I like David","I am David's teacher","David is my friend"]$mq$, 0, $mq$我叫 means 'I am called' and is the usual way to give your name.$mq$, $mq$easy$mq$),
($mq$What does 你叫什么名字？(nǐ jiào shénme míngzi?) ask?$mq$, $mq$["Where do you live?","How old are you?","Who is your teacher?","What is your name?"]$mq$, 3, $mq$什么名字 means 'what name', so the question asks for the person's name.$mq$, $mq$easy$mq$),
($mq$What does 学生 (xuéshēng) mean?$mq$, $mq$["Teacher","Friend","Student","Parent"]$mq$, 2, $mq$学生 means student. A teacher is 老师 (lǎoshī).$mq$, $mq$easy$mq$),
($mq$What does 我是英国人 (wǒ shì Yīngguó rén) mean?$mq$, $mq$["I am Chinese","I am British","I live in Britain","I like Britain"]$mq$, 1, $mq$Country + 人 (rén, person) gives a nationality, so 英国人 is a British person.$mq$, $mq$easy$mq$),
($mq$Which word means 'we'?$mq$, $mq$["我们 (wǒmen)","你们 (nǐmen)","他们 (tāmen)","朋友 (péngyou)"]$mq$, 0, $mq$我们 is 'we'. 你们 is 'you' (plural) and 他们 is 'they'.$mq$, $mq$easy$mq$),
($mq$What does 她是我的朋友 (tā shì wǒ de péngyou) mean?$mq$, $mq$["He is my teacher","She is my student","I am her friend's teacher","She is my friend"]$mq$, 3, $mq$她 means she, 是 means is, 我的 means my and 朋友 means friend.$mq$, $mq$medium$mq$),
($mq$Choose the word that completes the sentence: 我___美国人。(wǒ ___ Měiguó rén.) 'I am American.'$mq$, $mq$["叫 (jiào)","很 (hěn)","是 (shì)","有 (yǒu)"]$mq$, 2, $mq$是 links two nouns, 'I am an American person'. 叫 means 'is called' and 有 means 'have'.$mq$, $mq$medium$mq$),
($mq$You meet a new classmate for the first time. Which phrase is the best thing to say?$mq$, $mq$["明天见 (míngtiān jiàn)","很高兴认识你 (hěn gāoxìng rènshi nǐ)","不客气 (bú kèqi)","晚安 (wǎn'ān)"]$mq$, 1, $mq$很高兴认识你 means 'Nice to meet you'. The other phrases are goodbyes or a reply to thanks.$mq$, $mq$medium$mq$),
($mq$How do you say 'I am not Chinese'?$mq$, $mq$["我不是中国人 (wǒ bú shì Zhōngguó rén)","我不中国人 (wǒ bù Zhōngguó rén)","我没是中国人 (wǒ méi shì Zhōngguó rén)","我是不中国人 (wǒ shì bù Zhōngguó rén)"]$mq$, 0, $mq$The negative is 不 placed directly before 是, and 不 becomes bú before the fourth tone. 没 is used with 有, not 是.$mq$, $mq$medium$mq$),
($mq$Read: 这是我的朋友，她叫玲玲。(Zhè shì wǒ de péngyou, tā jiào Línglíng.)

Who is being introduced?$mq$, $mq$["A male teacher named Lingling","The speaker's sister named Lingling","A student who is not a friend","A female friend named Lingling"]$mq$, 3, $mq$这是 means 'this is', 朋友 is friend and 她 shows the person is female.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 大家好！我叫马克，我是澳大利亚人。我是学生。我住在悉尼。(Dàjiā hǎo! Wǒ jiào Mǎkè, wǒ shì Àodàlìyà rén. Wǒ shì xuéshēng. Wǒ zhù zài Xīní.) [大家 = everyone]

Where does Mark live?$mq$, $mq$["Australia's capital, Canberra","London","Sydney","Beijing"]$mq$, 2, $mq$住在 means 'live in' and the place after it is 悉尼 (Sydney). Mark is Australian, but the question asks where he lives.$mq$, $mq$medium$mq$),
($mq$Someone asks 你是哪国人？(nǐ shì nǎ guó rén?). Which reply is correct for a person from France?$mq$, $mq$["我叫法国。(wǒ jiào Fǎguó.)","我是法国人。(wǒ shì Fǎguó rén.)","我住法国人。(wǒ zhù Fǎguó rén.)","我是学生吗。(wǒ shì xuéshēng ma.)"]$mq$, 1, $mq$哪国人 asks 'which country person?', so the answer is country + 人 with 是.$mq$, $mq$medium$mq$),
($mq$What does 我是学生，她也是学生 (wǒ shì xuéshēng, tā yě shì xuéshēng) mean?$mq$, $mq$["I am a student and she is also a student","I am a student but she is not","I am a student and she is a teacher","We are both teachers"]$mq$, 0, $mq$也 (yě) means 'also' and goes before the verb 是.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'My name is Li Hua and I live in Beijing'?$mq$, $mq$["我是叫李华，我住是北京。(wǒ shì jiào Lǐ Huá, wǒ zhù shì Běijīng.)","我李华叫，我北京住在。(wǒ Lǐ Huá jiào, wǒ Běijīng zhù zài.)","我叫在李华，我住北京人。(wǒ jiào zài Lǐ Huá, wǒ zhù Běijīng rén.)","我叫李华，我住在北京。(wǒ jiào Lǐ Huá, wǒ zhù zài Běijīng.)"]$mq$, 3, $mq$Chinese keeps subject, verb, object order: 我叫李华 and 我住在北京. The other options scramble the order or misuse 是 and 在.$mq$, $mq$hard$mq$),
($mq$You hear: tā shì wǒ de lǎoshī. Can you tell from the sound alone whether the teacher is male or female?$mq$, $mq$["Yes, 她 has a falling tone","Yes, 他 has a rising tone","No, 他, 她 and 它 are all pronounced tā","Yes, the word 的 (de) shows the gender"]$mq$, 2, $mq$他 (he), 她 (she) and 它 (it) are written differently but sound identical. In listening you need other clues, such as a name.$mq$, $mq$hard$mq$),
($mq$Read: 这是我的老师。她叫张老师。她是中国人，她也是我的朋友。(Zhè shì wǒ de lǎoshī. Tā jiào Zhāng lǎoshī. Tā shì Zhōngguó rén, tā yě shì wǒ de péngyou.)

Which statement is true?$mq$, $mq$["Teacher Zhang is a student and the writer's friend","Teacher Zhang is Chinese and also the writer's friend","Teacher Zhang is American and the writer's teacher","Teacher Zhang is the writer's friend but not a teacher"]$mq$, 1, $mq$The text says she is a teacher (老师), Chinese (中国人) and also (也) a friend (朋友).$mq$, $mq$hard$mq$),
($mq$A student writes 我是叫小明 (wǒ shì jiào Xiǎomíng). What is the problem?$mq$, $mq$["是 and 叫 should not be used together; it should be 我叫小明","小明 should come before 我","叫 must be changed to 住","There is no problem"]$mq$, 0, $mq$叫 already means 'am called', so no 是 is needed. 我叫小明 is correct.$mq$, $mq$hard$mq$),
($mq$Someone asks 你是学生吗？(nǐ shì xuéshēng ma?). Which is a correct 'no' answer?$mq$, $mq$["没是，我没学生。(méi shì, wǒ méi xuéshēng.)","不，我不学生吗。(bù, wǒ bù xuéshēng ma.)","是，我不是学生。(shì, wǒ bú shì xuéshēng.)","不是，我不是学生。(bú shì, wǒ bú shì xuéshēng.)"]$mq$, 3, $mq$Answer a 是…吗 question with 是 or 不是 and repeat the sentence. 不 negates 是, while 没 does not.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Introducing Yourself and Others$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$我叫… (wǒ jiào…)$mq$, $mq$I am called… Use it for your name only, with no 是: 我叫大卫 (wǒ jiào Dàwèi).$mq$),
($mq$你叫什么名字？$mq$, $mq$Nǐ jiào shénme míngzi? = What is your name?$mq$),
($mq$我是… (wǒ shì…)$mq$, $mq$I am… 是 links two nouns: 我是学生 (wǒ shì xuéshēng), I am a student. Negative: 我不是… (wǒ bú shì…).$mq$),
($mq$你是哪国人？$mq$, $mq$Nǐ shì nǎ guó rén? = Which country are you from? Answer with country + 人: 我是中国人 (wǒ shì Zhōngguó rén).$mq$),
($mq$我住在… (wǒ zhù zài…)$mq$, $mq$I live in… For example 我住在伦敦 (wǒ zhù zài Lúndūn), I live in London.$mq$),
($mq$这是我的朋友$mq$, $mq$Zhè shì wǒ de péngyou = This is my friend. 的 (de) shows belonging.$mq$),
($mq$他 / 她 / 我们$mq$, $mq$他 (tā) = he; 她 (tā) = she, both sound the same; 我们 (wǒmen) = we.$mq$),
($mq$也 (yě)$mq$, $mq$Also. It goes before the verb: 她也是学生 (tā yě shì xuéshēng), she is also a student.$mq$),
($mq$很高兴认识你$mq$, $mq$Hěn gāoxìng rènshi nǐ = Nice to meet you. Said when you meet someone for the first time.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Introducing Yourself and Others$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Saying who you are
In Mandarin you give your name with 我叫 (wǒ jiào) plus your name: 我叫大卫 (wǒ jiào Dàwèi), "My name is David". Chinese names put the family name first, so 李华 (Lǐ Huá) has the family name Li and the given name Hua. To ask someone's name, say 你叫什么名字？(nǐ jiào shénme míngzi?).

## The verb 是 (shì)
The verb 是 means "to be" and links two nouns: 我是学生 (wǒ shì xuéshēng), "I am a student". It is not used before adjectives. For the negative, put 不 straight before 是: 我不是老师 (wǒ bú shì lǎoshī), "I am not a teacher". Remember that 不 changes to bú before a fourth tone. Add 吗 (ma) to ask a yes/no question: 你是学生吗？(nǐ shì xuéshēng ma?).

## Pronouns
- 我 (wǒ): I
- 你 (nǐ): you
- 他 (tā): he
- 她 (tā): she
- 我们 (wǒmen): we
- 你们 (nǐmen): you (plural)
- 他们 (tāmen): they
- 的 (de): shows belonging, as in 我的朋友 (wǒ de péngyou), my friend

Notice that 他 and 她 sound exactly the same, so in listening you rely on names and context.

## People and jobs
- 学生 (student)
- 老师 (teacher)
- 朋友 (friend)
- 同学 (classmate)

## Countries and nationalities
Add 人 (rén, person) to a country name to make a nationality:
- 中国 (Zhōngguó, China) → 中国人 (Chinese person)
- 英国 (Yīngguó, Britain) → 英国人
- 美国 (Měiguó, USA) → 美国人
- 法国 (Fǎguó, France) → 法国人
- 澳大利亚 (Àodàlìyà, Australia) → 澳大利亚人

Ask 你是哪国人？(nǐ shì nǎ guó rén?), "Which country are you from?". To say where you live use 住在 (zhù zài): 我住在伦敦 (wǒ zhù zài Lúndūn), "I live in London".

## Introducing others
Use 这是 (zhè shì), "this is": 这是我的朋友，她叫玲玲 (zhè shì wǒ de péngyou, tā jiào Línglíng). To add "also", place 也 (yě) before the verb: 她也是学生 (tā yě shì xuéshēng). When meeting someone say 很高兴认识你 (hěn gāoxìng rènshi nǐ), "Nice to meet you".

## Common mistakes
- Saying 我是叫… Use 我叫… only.
- Using 没 to negate 是. Always 不是.
- Putting 也 after the verb. It goes before: 她也是, not 她是也.
- Putting 很 before 是. Never write 我很是学生.

## How this is examined
Self-introductions are a favourite for reading and listening. You might read a short profile or hear a speaker give a name, nationality, home city and job, then answer questions about one detail. In writing you may be asked to introduce yourself and a friend in four or five sentences, so practise a full model: name, nationality, where you live and one fact about a friend.

Exam tip: In listening, note the key detail words (name, country, city, job). Check whether the question asks where someone is from or where they live, because the answers can be different.$mq$ from st;

-- Greetings and Introductions > Numbers, Age and Dates
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Greetings and Introductions$mq$, 5, 1 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Numbers, Age and Dates$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Greetings and Introductions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Numbers, Age and Dates$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What number is 五 (wǔ)?$mq$, $mq$["5","4","6","9"]$mq$, 0, $mq$五 is five. Four is 四 (sì), six is 六 (liù) and nine is 九 (jiǔ).$mq$, $mq$easy$mq$),
($mq$What number is 八 (bā)?$mq$, $mq$["7","9","10","8"]$mq$, 3, $mq$八 is eight. Seven is 七 (qī) and nine is 九 (jiǔ).$mq$, $mq$easy$mq$),
($mq$What does 十 (shí) mean?$mq$, $mq$["1","4","10","100"]$mq$, 2, $mq$十 is ten. It looks like a plus sign. One is 一 (yī) and four is 四 (sì).$mq$, $mq$easy$mq$),
($mq$Which day is 星期一 (xīngqīyī)?$mq$, $mq$["Sunday","Monday","Tuesday","Friday"]$mq$, 1, $mq$星期 means week and 一 means one, so 星期一 is the first day, Monday. Tuesday is 星期二.$mq$, $mq$easy$mq$),
($mq$Which month is 三月 (sān yuè)?$mq$, $mq$["March","February","June","September"]$mq$, 0, $mq$Months are number + 月 (yuè). Three is 三, so 三月 is March.$mq$, $mq$easy$mq$),
($mq$What number is 十五 (shíwǔ)?$mq$, $mq$["5","50","10","15"]$mq$, 3, $mq$十五 is ten plus five, which is fifteen. Fifty would be 五十 (wǔshí).$mq$, $mq$medium$mq$),
($mq$What does 我十六岁 (wǒ shíliù suì) mean?$mq$, $mq$["I have 6 friends","I am 10 years old","I am 16 years old","I was born in June"]$mq$, 2, $mq$十六 is 16 and 岁 (suì) means years of age.$mq$, $mq$medium$mq$),
($mq$What number is 二十三 (èrshísān)?$mq$, $mq$["32","23","203","13"]$mq$, 1, $mq$二十三 means two tens and three, so 23. Thirty-two is 三十二 (sānshí'èr).$mq$, $mq$medium$mq$),
($mq$How do you say 'twelve' in Mandarin?$mq$, $mq$["十二 (shí'èr)","二十 (èrshí)","一二 (yī èr)","二十一 (èrshíyī)"]$mq$, 0, $mq$Teen numbers are 十 + a digit, so twelve is 十二. 二十 is 20 and 二十一 is 21.$mq$, $mq$medium$mq$),
($mq$What does 你几岁？(nǐ jǐ suì?) ask?$mq$, $mq$["What day is it?","Which month is your birthday?","How many brothers do you have?","How old are you? (usually asked to a child)"]$mq$, 3, $mq$几 means 'how many' and 岁 means years of age. For older people you can use 你多大？(nǐ duō dà?).$mq$, $mq$medium$mq$),
($mq$What does 今天星期四 (jīntiān xīngqīsì) mean?$mq$, $mq$["Tomorrow is Thursday","Today is Sunday","Today is Thursday","Today is the fourth of the month"]$mq$, 2, $mq$今天 means today and 星期四 is Thursday (week + four).$mq$, $mq$medium$mq$),
($mq$What does 我的生日是六月八号 (wǒ de shēngrì shì liù yuè bā hào) mean?$mq$, $mq$["My birthday is on 6 August","My birthday is on 8 June","I am 68 years old","My birthday is on the 6th of the eighth month"]$mq$, 1, $mq$Month comes before day in Chinese: 六月 is June and 八号 is the 8th. 号 (hào) is the spoken word for 'day of the month'.$mq$, $mq$medium$mq$),
($mq$Which is November?$mq$, $mq$["十一月 (shíyī yuè)","十月 (shí yuè)","一月 (yī yuè)","十二月 (shí'èr yuè)"]$mq$, 0, $mq$November is the eleventh month, so 十一月. 十月 is October and 十二月 is December.$mq$, $mq$medium$mq$),
($mq$Complete the sum: 三加九等于几？(sān jiā jiǔ děngyú jǐ?) [加 = plus, 等于 = equals]$mq$, $mq$["十 (shí)","二十 (èrshí)","九三 (jiǔ sān)","十二 (shí'èr)"]$mq$, 3, $mq$3 + 9 = 12, which is 十二. 二十 would be 20.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 玲玲: 你的生日是几月几号？(Línglíng: Nǐ de shēngrì shì jǐ yuè jǐ hào?) 大卫: 我的生日是十二月二十五号。(Dàwèi: Wǒ de shēngrì shì shí'èr yuè èrshíwǔ hào.)

When is David's birthday?$mq$, $mq$["12 May","15 December","25 December","25 February"]$mq$, 2, $mq$十二月 is December and 二十五号 is the 25th. Chinese says the month first, then the day.$mq$, $mq$hard$mq$),
($mq$How is the date 3月14日 read aloud in written style?$mq$, $mq$["十四月三日 (shísì yuè sān rì)","三月十四日 (sān yuè shísì rì)","三十四月 (sānshísì yuè)","三月四十一日 (sān yuè sìshíyī rì)"]$mq$, 1, $mq$Month comes first: 3 = 三, and 14 = 十四 (ten and four). 日 (rì) is the written form of 号.$mq$, $mq$hard$mq$),
($mq$Read: 小红: 我今年十四岁，我哥哥十七岁。(Xiǎohóng: Wǒ jīnnián shísì suì, wǒ gēge shíqī suì.) [今年 = this year, 哥哥 = older brother]

How many years older is her brother?$mq$, $mq$["3 years","2 years","4 years","31 years"]$mq$, 0, $mq$十七 is 17 and 十四 is 14, and 17 − 14 = 3.$mq$, $mq$hard$mq$),
($mq$Today is 星期五 (xīngqīwǔ). 后天 (hòutiān) means 'the day after tomorrow'. What day is 后天?$mq$, $mq$["星期六 (xīngqīliù)","星期四 (xīngqīsì)","星期一 (xīngqīyī)","星期日 (xīngqīrì)"]$mq$, 3, $mq$Friday is the fifth day; tomorrow is Saturday (星期六) and the day after tomorrow is Sunday, 星期日 (also called 星期天).$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Numbers, Age and Dates$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$一 二 三 四 五$mq$, $mq$yī, èr, sān, sì, wǔ = 1, 2, 3, 4, 5.$mq$),
($mq$六 七 八 九 十$mq$, $mq$liù, qī, bā, jiǔ, shí = 6, 7, 8, 9, 10.$mq$),
($mq$十五 / 二十三$mq$, $mq$十五 (shíwǔ) = 15 (ten + five); 二十三 (èrshísān) = 23 (two tens + three). Tens come first, then units.$mq$),
($mq$我十五岁$mq$, $mq$Wǒ shíwǔ suì = I am 15 years old. 岁 (suì) means years of age.$mq$),
($mq$你几岁？/ 你多大？$mq$, $mq$Nǐ jǐ suì? asks a child's age. Nǐ duō dà? asks an older person's age. Both mean 'How old are you?'$mq$),
($mq$三月 / 十二月$mq$, $mq$三月 (sān yuè) = March; 十二月 (shí'èr yuè) = December. Months are number + 月 (yuè).$mq$),
($mq$星期一 … 星期日$mq$, $mq$星期 (xīngqī) = week. 星期一 Monday to 星期六 Saturday; Sunday is 星期日 (xīngqīrì) or 星期天 (xīngqītiān).$mq$),
($mq$今天几月几号？$mq$, $mq$Jīntiān jǐ yuè jǐ hào? = What is today's date? Month first, then day. 号 (hào) is spoken; 日 (rì) is written.$mq$),
($mq$今天 / 明天 / 后天$mq$, $mq$今天 (jīntiān) = today; 明天 (míngtiān) = tomorrow; 后天 (hòutiān) = the day after tomorrow.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Numbers, Age and Dates$mq$ and p.name = $mq$Greetings and Introductions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Numbers 0 to 10
Chinese numbers are very logical, so they are worth learning well.
- 零 (líng): 0
- 一 (yī): 1
- 二 (èr): 2
- 三 (sān): 3
- 四 (sì): 4
- 五 (wǔ): 5
- 六 (liù): 6
- 七 (qī): 7
- 八 (bā): 8
- 九 (jiǔ): 9
- 十 (shí): 10

## Building bigger numbers
For 11 to 19 say ten + digit: 十一 (shíyī) is 11, 十五 (shíwǔ) is 15 and 十九 (shíjiǔ) is 19. For tens say digit + ten: 二十 (èrshí) is 20 and 三十 (sānshí) is 30. Add the units last: 二十三 (èrshísān) is 23. Watch word order: 三十二 is 32 but 二十三 is 23. For 100 say 一百 (yìbǎi).

## Talking about age
Use 岁 (suì), which means "years of age". I am fifteen is 我十五岁 (wǒ shíwǔ suì). Ask a child 你几岁？(nǐ jǐ suì?). Ask a teenager or adult 你多大？(nǐ duō dà?). Use 今年 (jīnnián, this year) to add "this year".

## Months
Months are number + 月 (yuè): 一月 (yī yuè) January, 二月 February, 三月 March, up to 十二月 (shí'èr yuè) December. Mandarin does not use separate names for months.

## Days of the week
Days are 星期 (xīngqī, week) + number: 星期一 Monday, 星期二 Tuesday, 星期三 Wednesday, 星期四 Thursday, 星期五 Friday, 星期六 Saturday. Sunday is special: 星期日 (xīngqīrì) or 星期天 (xīngqītiān).

## Dates
Chinese dates go from big to small: year, month, day. 2027年3月14日 is read as the year, then 三月 and 十四日. In speech, 号 (hào) is used for the day: 三月十四号 (sān yuè shísì hào). The written form is 日 (rì). Ask the date with 今天几月几号？(jīntiān jǐ yuè jǐ hào?) and the weekday with 今天星期几？(jīntiān xīngqī jǐ?). Useful time words: 今天 (today), 明天 (tomorrow), 后天 (the day after tomorrow) and 生日 (shēngrì, birthday): 我的生日是六月八号 (wǒ de shēngrì shì liù yuè bā hào), "My birthday is on 8 June".

## Worked example
三加九等于几？(sān jiā jiǔ děngyú jǐ?) uses 加 (plus) and 等于 (equals). 3 + 9 = 12, so the answer is 十二 (shí'èr).

## Common mistakes
- Swapping tens and units (二十三 is 23, not 32).
- Putting the day before the month. Mandarin always goes month first.
- Forgetting that 星期日 is Sunday, not 星期七.
- Writing 十一 for November. November is 十一月, with 月.

## How this is examined
Number and date questions appear in notices, tickets, birthday invitations and timetables. You may be asked to read a date from a short invitation, work out a person's age from a message, or spot which day an event happens. Writing tasks often include a birthday or age in a short profile.

Exam tip: Convert every Chinese number to digits as you read, and write the digits next to the text in your notes. In listening, numbers go quickly, so listen for the 十 (shí) in teens and tens and double-check month before day.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('mandarin-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;