-- Part 4 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- School and Work > School Subjects and Objects
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$School and Work$mq$, 5, 4 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$School Subjects and Objects$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$School and Work$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$School Subjects and Objects$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 数学 (shùxué) mean?$mq$, $mq$["Maths","Science","History","Music"]$mq$, 0, $mq$数学 is mathematics. Science is 科学 (kēxué).$mq$, $mq$easy$mq$),
($mq$What does 英语 (Yīngyǔ) mean?$mq$, $mq$["Chinese","Geography","Art","English"]$mq$, 3, $mq$英语 is the English language. Chinese is 中文 (Zhōngwén).$mq$, $mq$easy$mq$),
($mq$What does 书包 (shūbāo) mean?$mq$, $mq$["Ruler","Dictionary","Schoolbag","Book"]$mq$, 2, $mq$书 is book and 包 is bag, so 书包 is a schoolbag.$mq$, $mq$easy$mq$),
($mq$What does 笔 (bǐ) mean?$mq$, $mq$["Book","Pen","Ruler","Eraser"]$mq$, 1, $mq$笔 is a pen. 铅笔 (qiānbǐ) is a pencil, literally 'lead pen'.$mq$, $mq$easy$mq$),
($mq$What does 体育 (tǐyù) mean?$mq$, $mq$["PE (physical education)","Music","Art","Science"]$mq$, 0, $mq$体育 is PE. Music is 音乐 (yīnyuè) and art is 美术 (měishù).$mq$, $mq$easy$mq$),
($mq$What does 我最喜欢音乐 (wǒ zuì xǐhuan yīnyuè) mean?$mq$, $mq$["I am the best at music","I never have music","I play music every day","I like music the most"]$mq$, 3, $mq$最 means most, so 最喜欢 is 'like the most' or 'favourite'.$mq$, $mq$medium$mq$),
($mq$Which sentence means 'I have a Chinese book'?$mq$, $mq$["我是中文书 (wǒ shì Zhōngwén shū)","我在一本中文书 (wǒ zài yì běn Zhōngwén shū)","我有一本中文书 (wǒ yǒu yì běn Zhōngwén shū)","我很一本中文书 (wǒ hěn yì běn Zhōngwén shū)"]$mq$, 2, $mq$有 means 'have' and 本 (běn) is the measure word for books.$mq$, $mq$medium$mq$),
($mq$What does 因为 (yīnwèi) mean?$mq$, $mq$["But","Because","Why","Also"]$mq$, 1, $mq$因为 introduces a reason. 为什么 (wèishénme) means 'why'.$mq$, $mq$medium$mq$),
($mq$Read: 我喜欢科学，因为很有意思。我不喜欢历史，因为很难。(Wǒ xǐhuan kēxué, yīnwèi hěn yǒu yìsi. Wǒ bù xǐhuan lìshǐ, yīnwèi hěn nán.) [有意思 = interesting]

Why does the writer not like history?$mq$, $mq$["It is difficult","It is interesting","It is easy","There is too much homework"]$mq$, 0, $mq$很难 means 'very difficult'. The writer likes science because it is interesting.$mq$, $mq$medium$mq$),
($mq$Read: 书包里有两本书和一支笔。(Shūbāo lǐ yǒu liǎng běn shū hé yì zhī bǐ.)

What is in the bag?$mq$, $mq$["Two pens and one book","One book and two rulers","Two books and one pencil","Two books and one pen"]$mq$, 3, $mq$两本书 is two books and 一支笔 is one pen. A pencil would be 铅笔.$mq$, $mq$medium$mq$),
($mq$Which is the best reply to 你为什么喜欢体育？(nǐ wèishénme xǐhuan tǐyù?)$mq$, $mq$["我是学生 (wǒ shì xuéshēng)","在学校 (zài xuéxiào)","因为很有意思 (yīnwèi hěn yǒu yìsi)","星期三 (xīngqīsān)"]$mq$, 2, $mq$A 为什么 question asks for a reason, which begins with 因为.$mq$, $mq$medium$mq$),
($mq$Which is the correct pinyin for 铅笔?$mq$, $mq$["qiánbí","qiānbǐ","qiānbì","qiǎnbǐ"]$mq$, 1, $mq$铅 is first tone (qiān) and 笔 is third tone (bǐ).$mq$, $mq$medium$mq$),
($mq$Which word is the odd one out?$mq$, $mq$["铅笔 (qiānbǐ)","数学 (shùxué)","科学 (kēxué)","历史 (lìshǐ)"]$mq$, 0, $mq$数学, 科学 and 历史 are school subjects. 铅笔 is a pencil, a school object.$mq$, $mq$medium$mq$),
($mq$Read: 星期一有数学、英语和体育。星期二有科学、音乐和地理。(Xīngqīyī yǒu shùxué, Yīngyǔ hé tǐyù. Xīngqī'èr yǒu kēxué, yīnyuè hé dìlǐ.) [地理 = geography]

Which subjects are on Tuesday?$mq$, $mq$["Maths, English and PE","Science, music and PE","Maths, music and geography","Science, music and geography"]$mq$, 3, $mq$星期二 is Tuesday. The list after it is 科学, 音乐 and 地理.$mq$, $mq$hard$mq$),
($mq$Notice: 请带铅笔、尺子和橡皮。明天有数学考试。(Qǐng dài qiānbǐ, chǐzi hé xiàngpí. Míngtiān yǒu shùxué kǎoshì.) [带 = bring, 考试 = test]

What should students do?$mq$, $mq$["Bring a pen and dictionary for an English test","Hand in their homework tomorrow","Bring a pencil, ruler and eraser for tomorrow's maths test","Stay at home tomorrow"]$mq$, 2, $mq$请带 means 'please bring'. 数学考试 is a maths test and it is tomorrow (明天).$mq$, $mq$hard$mq$),
($mq$Listening transcript: 大卫: 你最喜欢什么课？(Dàwèi: Nǐ zuì xǐhuan shénme kè?) 玲玲: 我最喜欢美术，因为我喜欢画画。你呢？(Línglíng: Wǒ zuì xǐhuan měishù, yīnwèi wǒ xǐhuan huàhuà. Nǐ ne?) 大卫: 我喜欢体育，不喜欢美术。(Dàwèi: Wǒ xǐhuan tǐyù, bù xǐhuan měishù.) [画画 = draw, paint]

Which statement is true?$mq$, $mq$["Both students like art","Lingling likes art but David does not","David likes art and PE","Lingling's favourite is PE"]$mq$, 1, $mq$Lingling's favourite is 美术 (art). David says he likes PE and does not like art.$mq$, $mq$hard$mq$),
($mq$A student writes 我喜欢很数学 (wǒ xǐhuan hěn shùxué) to mean 'I like maths a lot'. What is the mistake?$mq$, $mq$["很 should come before 喜欢","数学 should be before 我","喜欢 should be 是","There is no mistake"]$mq$, 0, $mq$Degree words go before the verb: 我很喜欢数学.$mq$, $mq$hard$mq$),
($mq$Which measure word completes 一___铅笔 (yì ___ qiānbǐ), 'one pencil'?$mq$, $mq$["本 (běn)","张 (zhāng)","间 (jiān)","支 (zhī)"]$mq$, 3, $mq$支 is used for pens and pencils. 本 is for books, 张 for flat things like paper, and 间 for rooms.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$School Subjects and Objects$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$数学 / 英语 / 科学$mq$, $mq$数学 (shùxué) = maths; 英语 (Yīngyǔ) = English; 科学 (kēxué) = science.$mq$),
($mq$历史 / 地理$mq$, $mq$历史 (lìshǐ) = history; 地理 (dìlǐ) = geography.$mq$),
($mq$体育 / 音乐 / 美术$mq$, $mq$体育 (tǐyù) = PE; 音乐 (yīnyuè) = music; 美术 (měishù) = art.$mq$),
($mq$书包 / 笔 / 铅笔$mq$, $mq$书包 (shūbāo) = schoolbag; 笔 (bǐ) = pen; 铅笔 (qiānbǐ) = pencil.$mq$),
($mq$尺子 / 橡皮$mq$, $mq$尺子 (chǐzi) = ruler; 橡皮 (xiàngpí) = eraser.$mq$),
($mq$我最喜欢…$mq$, $mq$Wǒ zuì xǐhuan… = I like… the most. 最 (zuì) means most: 我最喜欢音乐 = music is my favourite.$mq$),
($mq$为什么 / 因为$mq$, $mq$为什么 (wèishénme) = why; 因为 (yīnwèi) = because. 因为 introduces the reason.$mq$),
($mq$很有意思 / 很难$mq$, $mq$很有意思 (hěn yǒu yìsi) = very interesting; 很难 (hěn nán) = very difficult. Put 很 before the adjective.$mq$),
($mq$本 / 支 (measure words)$mq$, $mq$本 (běn) for books: 一本书. 支 (zhī) for pens and pencils: 一支笔. Use 两 (liǎng) for two: 两本书.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$School Subjects and Objects$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## School life in Mandarin
School is a very natural topic in beginner tasks because you can talk about things you see every day. In this sub-topic you will learn subject names, classroom objects, how to say what you like and why, and a few measure words. Always learn pinyin and tones with every word.

## School subjects
- 数学 (shùxué): maths
- 英语 (Yīngyǔ): English
- 中文 (Zhōngwén): Chinese
- 科学 (kēxué): science
- 历史 (lìshǐ): history
- 地理 (dìlǐ): geography
- 体育 (tǐyù): PE
- 音乐 (yīnyuè): music
- 美术 (měishù): art
- 课 (kè): lesson, class

## School objects
- 书 (shū): book
- 本子 (běnzi): notebook
- 笔 (bǐ): pen
- 铅笔 (qiānbǐ): pencil
- 橡皮 (xiàngpí): eraser
- 尺子 (chǐzi): ruler
- 书包 (shūbāo): schoolbag
- 词典 (cídiǎn): dictionary
- 电脑 (diànnǎo): computer
- 黑板 (hēibǎn): blackboard
- 教室 (jiàoshì): classroom

## Giving opinions
Use 喜欢 (xǐhuan, like). 我喜欢数学 (wǒ xǐhuan shùxué) means "I like maths". Add 最 (zuì, most) for a favourite: 我最喜欢音乐 (wǒ zuì xǐhuan yīnyuè), "I like music the most". Put 很 (hěn) before 喜欢 for "like a lot": 我很喜欢科学. The negative is 不喜欢 (bù xǐhuan): 我不喜欢历史.

To ask about a favourite say 你最喜欢什么课？(nǐ zuì xǐhuan shénme kè?), "Which subject do you like most?".

## Giving reasons
为什么 (wèishénme) means "why" and 因为 (yīnwèi) means "because". Useful describing words are 有意思 (yǒu yìsi, interesting), 难 (nán, difficult) and 容易 (róngyì, easy). Remember to put 很 before adjectives: 数学很难 (shùxué hěn nán), "Maths is difficult". Full example: 我喜欢科学，因为很有意思 (wǒ xǐhuan kēxué, yīnwèi hěn yǒu yìsi), "I like science because it is interesting".

## Having things and measure words
Use 有 (yǒu) for "have": 我有一本书 (wǒ yǒu yì běn shū), "I have a book". Between a number and a noun Mandarin needs a measure word.
- 本 (běn): books and notebooks, as in 两本书 (liǎng běn shū), two books
- 支 (zhī): pens and pencils, as in 一支笔 (yì zhī bǐ), one pen
- 把 (bǎ): rulers and chairs, as in 一把尺子 (yì bǎ chǐzi)
- 个 (ge): the general measure word, as in 一个书包 (yí ge shūbāo)
Use 两 (liǎng) for "two" before a measure word. The negative of 有 is 没有: 我没有尺子 (wǒ méiyǒu chǐzi), "I don't have a ruler".

## Timetable language
Days of the week and subjects are often combined in a timetable: 星期一有数学 (xīngqīyī yǒu shùxué), "On Monday there is maths". 

## Common mistakes
- Putting 很 after 喜欢 instead of before it.
- Using 是 before an adjective, such as 数学是很难.
- Using the wrong measure word, such as 一本笔.
- Forgetting that 铅笔 means pencil, not just pen.
- Missing tone marks on 数学 (shùxué) and 历史 (lìshǐ).

## How this is examined
School topics appear in timetables, notices, short school profiles and conversations about favourite subjects. Questions often ask which lesson is on a certain day, why someone likes a subject, or what to bring. Writing tasks ask you to describe your school day and give an opinion with a reason.

Exam tip: When you see 因为, the reason follows it. Mark the subject name, then the opinion word (喜欢 or 不喜欢) and finally the reason, so you never mix up what the writer likes and dislikes.$mq$ from st;

-- School and Work > Jobs and Workplaces
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$School and Work$mq$, 5, 4 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Jobs and Workplaces$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$School and Work$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Jobs and Workplaces$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 医生 (yīshēng) mean?$mq$, $mq$["Doctor","Nurse","Teacher","Driver"]$mq$, 0, $mq$医生 is a doctor. A nurse is 护士 (hùshi).$mq$, $mq$easy$mq$),
($mq$What does 司机 (sījī) mean?$mq$, $mq$["Doctor","Cook","Farmer","Driver"]$mq$, 3, $mq$司机 means driver, for example of a bus or taxi.$mq$, $mq$easy$mq$),
($mq$What does 医院 (yīyuàn) mean?$mq$, $mq$["School","Bank","Hospital","Shop"]$mq$, 2, $mq$医 is medicine and 院 is an institution, so 医院 is a hospital.$mq$, $mq$easy$mq$),
($mq$What does 商店 (shāngdiàn) mean?$mq$, $mq$["Bank","Shop","Office","Factory"]$mq$, 1, $mq$商店 is a shop. A bank is 银行 (yínháng).$mq$, $mq$easy$mq$),
($mq$What does 厨师 (chúshī) mean?$mq$, $mq$["Chef, cook","Waiter","Nurse","Engineer"]$mq$, 0, $mq$厨师 is a cook or chef. 厨房 (chúfáng) is the kitchen, and the same 厨 appears in both words.$mq$, $mq$easy$mq$),
($mq$What does 我妈妈是护士 (wǒ māma shì hùshi) mean?$mq$, $mq$["My mum is a doctor","My mum has a nurse","My mum likes nurses","My mum is a nurse"]$mq$, 3, $mq$是 links two nouns: 妈妈 (mum) = 护士 (nurse).$mq$, $mq$medium$mq$),
($mq$What does 她在医院工作 (tā zài yīyuàn gōngzuò) mean?$mq$, $mq$["She is a patient in hospital","She studies at the hospital","She works in a hospital","She likes hospitals"]$mq$, 2, $mq$在 + place + 工作 means 'work at a place'. 工作 is work.$mq$, $mq$medium$mq$),
($mq$Where does a 服务员 (fúwùyuán, waiter) work?$mq$, $mq$["银行 (yínháng, bank)","饭馆 (fànguǎn, restaurant)","医院 (yīyuàn, hospital)","学校 (xuéxiào, school)"]$mq$, 1, $mq$A waiter serves customers in a restaurant, 饭馆.$mq$, $mq$medium$mq$),
($mq$Which is the best reply to 你做什么工作？(nǐ zuò shénme gōngzuò?)$mq$, $mq$["我是工程师 (wǒ shì gōngchéngshī)","我十五岁 (wǒ shíwǔ suì)","我住在北京 (wǒ zhù zài Běijīng)","我很好 (wǒ hěn hǎo)"]$mq$, 0, $mq$The question asks 'What job do you do?', so the reply names a job with 是.$mq$, $mq$medium$mq$),
($mq$What does 我想当老师 (wǒ xiǎng dāng lǎoshī) mean?$mq$, $mq$["I am a teacher","I like teachers","My teacher is coming","I want to be a teacher"]$mq$, 3, $mq$想 means want to, and 当 means become or be (as a job).$mq$, $mq$medium$mq$),
($mq$Read: 我叫王明。我爸爸是司机，他在公司工作。我妈妈是医生，她在医院工作。(Wǒ jiào Wáng Míng. Wǒ bàba shì sījī, tā zài gōngsī gōngzuò. Wǒ māma shì yīshēng, tā zài yīyuàn gōngzuò.) [公司 = company]

Where does Wang Ming's father work?$mq$, $mq$["At a hospital","At a school","At a company","At a bank"]$mq$, 2, $mq$The father is a driver who works at a 公司 (company). The mother works at the hospital.$mq$, $mq$medium$mq$),
($mq$How do you say 'My father is not a police officer'?$mq$, $mq$["我爸爸没是警察 (wǒ bàba méi shì jǐngchá)","我爸爸不是警察 (wǒ bàba bú shì jǐngchá)","我爸爸不警察 (wǒ bàba bù jǐngchá)","我爸爸是不警察 (wǒ bàba shì bù jǐngchá)"]$mq$, 1, $mq$The negative of 是 is 不是. 没 is for 有, and 是 cannot be dropped.$mq$, $mq$medium$mq$),
($mq$Which is the correct pinyin for 医生?$mq$, $mq$["yīshēng","yíshēng","yīshèng","yǐshēng"]$mq$, 0, $mq$Both 医 and 生 are first tone, so there are no tone changes.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 小红: 我爸爸是农民，他不在城市工作。他在农场工作。(Xiǎohóng: Wǒ bàba shì nóngmín, tā bú zài chéngshì gōngzuò. Tā zài nóngchǎng gōngzuò.) [城市 = city, 农场 = farm]

Where does Xiaohong's father work?$mq$, $mq$["In a city","In a hospital","In a factory","On a farm"]$mq$, 3, $mq$He is a farmer (农民). He does not work in the city; he works on a 农场, a farm.$mq$, $mq$hard$mq$),
($mq$Advert: 我们的饭馆需要服务员。星期六和星期天工作。请给我们打电话。(Wǒmen de fànguǎn xūyào fúwùyuán. Xīngqīliù hé xīngqītiān gōngzuò. Qǐng gěi wǒmen dǎ diànhuà.) [需要 = need, 打电话 = phone]

What is the advert for?$mq$, $mq$["A cook at a restaurant on weekdays","A teacher at a school at weekends","A waiter at a restaurant, working at the weekend","A driver for a company on Saturdays only"]$mq$, 2, $mq$The restaurant needs a 服务员 (waiter) who works on Saturday and Sunday.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 大明: 我想当医生，因为我想帮助人。(Dàmíng: Wǒ xiǎng dāng yīshēng, yīnwèi wǒ xiǎng bāngzhù rén.) 小英: 我不想当医生，我想当工程师。(Xiǎoyīng: Wǒ bù xiǎng dāng yīshēng, wǒ xiǎng dāng gōngchéngshī.) [帮助 = help]

Which statement is true?$mq$, $mq$["Both want to be doctors","Daming wants to be a doctor and Xiaoying wants to be an engineer","Daming wants to be an engineer and Xiaoying a doctor","Neither wants a job"]$mq$, 1, $mq$Daming says 想当医生. Xiaoying says 不想当医生 and 想当工程师.$mq$, $mq$hard$mq$),
($mq$A student writes 我妈妈工作在医院 (wǒ māma gōngzuò zài yīyuàn) for 'My mum works in a hospital'. What is the mistake?$mq$, $mq$["The place phrase should come before the verb: 在医院工作","妈妈 should be 爸爸","医院 should be 学校","There is no mistake"]$mq$, 0, $mq$In Mandarin the place phrase goes before the verb: 她在医院工作.$mq$, $mq$hard$mq$),
($mq$Which job and workplace pair does NOT match?$mq$, $mq$["老师 (teacher) – 学校 (school)","医生 (doctor) – 医院 (hospital)","厨师 (cook) – 饭馆 (restaurant)","护士 (nurse) – 银行 (bank)"]$mq$, 3, $mq$A nurse works in a hospital, not a bank. The other three pairs match.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Jobs and Workplaces$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$医生 / 护士$mq$, $mq$医生 (yīshēng) = doctor; 护士 (hùshi) = nurse. Both usually work at a 医院 (yīyuàn), a hospital.$mq$),
($mq$老师 / 司机 / 警察$mq$, $mq$老师 (lǎoshī) = teacher; 司机 (sījī) = driver; 警察 (jǐngchá) = police officer.$mq$),
($mq$厨师 / 服务员$mq$, $mq$厨师 (chúshī) = cook, chef; 服务员 (fúwùyuán) = waiter or waitress.$mq$),
($mq$工程师 / 农民$mq$, $mq$工程师 (gōngchéngshī) = engineer; 农民 (nóngmín) = farmer, who works on a 农场 (nóngchǎng), a farm.$mq$),
($mq$你做什么工作？$mq$, $mq$Nǐ zuò shénme gōngzuò? = What job do you do? Reply: 我是… (wǒ shì…), I am a…$mq$),
($mq$她在医院工作$mq$, $mq$Tā zài yīyuàn gōngzuò = She works in a hospital. Pattern: 在 + place + 工作. The place goes before the verb.$mq$),
($mq$公司 / 银行 / 商店$mq$, $mq$公司 (gōngsī) = company; 银行 (yínháng) = bank; 商店 (shāngdiàn) = shop.$mq$),
($mq$我想当…$mq$, $mq$Wǒ xiǎng dāng… = I want to be a… For example 我想当老师 (wǒ xiǎng dāng lǎoshī), I want to be a teacher.$mq$),
($mq$我爸爸不是医生$mq$, $mq$Wǒ bàba bú shì yīshēng = My dad is not a doctor. Negate 是 with 不, giving 不是.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Jobs and Workplaces$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Talking about jobs
Jobs and workplaces are part of everyday conversations, such as asking about someone's family. You must be able to name common jobs, say where people work and say what you want to be in the future.

## Jobs
- 医生 (yīshēng): doctor
- 护士 (hùshi): nurse
- 老师 (lǎoshī): teacher
- 司机 (sījī): driver
- 警察 (jǐngchá): police officer
- 厨师 (chúshī): cook, chef
- 工程师 (gōngchéngshī): engineer
- 律师 (lǜshī): lawyer
- 农民 (nóngmín): farmer
- 服务员 (fúwùyuán): waiter, waitress
- 售货员 (shòuhuòyuán): shop assistant

## Workplaces
- 医院 (yīyuàn): hospital
- 学校 (xuéxiào): school
- 商店 (shāngdiàn): shop
- 饭馆 (fànguǎn): restaurant
- 办公室 (bàngōngshì): office
- 公司 (gōngsī): company
- 工厂 (gōngchǎng): factory
- 银行 (yínháng): bank
- 农场 (nóngchǎng): farm

## Saying what someone does
Use 是 (shì) with a job name: 我爸爸是医生 (wǒ bàba shì yīshēng), "My dad is a doctor". To ask, say 你做什么工作？(nǐ zuò shénme gōngzuò?), "What job do you do?". For a parent you can ask 你爸爸做什么工作？. The negative is 不是: 他不是警察 (tā bú shì jǐngchá), "He is not a police officer". A word like 工作 (gōngzuò) is both a noun, "job", and a verb, "to work".

## Saying where someone works
Use 在 (zài) + workplace + 工作 (gōngzuò). The place phrase must go before the verb.
- 她在医院工作 (tā zài yīyuàn gōngzuò): she works in a hospital.
- 我爸爸在公司工作 (wǒ bàba zài gōngsī gōngzuò): my dad works at a company.
- 他不在城市工作 (tā bú zài chéngshì gōngzuò): he doesn't work in the city.
You can join the two ideas: 我妈妈是护士，她在医院工作 (my mum is a nurse; she works in a hospital).

## Saying what you want to be
想 (xiǎng) means "want to" and 当 (dāng) means "to become" a job. 我想当老师 (wǒ xiǎng dāng lǎoshī) means "I want to be a teacher". The negative is 不想: 我不想当医生 (wǒ bù xiǎng dāng yīshēng), "I don't want to be a doctor". Add a reason with 因为 (yīnwèi, because): 我想当医生，因为我想帮助人 (I want to be a doctor because I want to help people).

## Matching job and place
A good revision habit is to learn pairs: 老师 – 学校, 医生 and 护士 – 医院, 服务员 and 厨师 – 饭馆, 农民 – 农场, 售货员 – 商店.

## Common mistakes
- Putting the workplace after the verb: 她工作在医院.
- Using 没 to negate 是 (it should be 不是).
- Mixing up 医生 (doctor) and 医院 (hospital) because they share 医.
- Missing the neutral tone in 护士 (hùshi).

## How this is examined
Jobs appear in family descriptions, profiles, job adverts and conversations about the future. Typical tasks ask what job a person does, where they work, or what someone wants to be. Writing tasks often ask you to describe two family members and their jobs.

Exam tip: When a text lists several people, draw a quick table of person, job and place. Check which person each detail belongs to before you answer, because exam texts often compare two people.$mq$ from st;

-- School and Work > Classroom Language and Instructions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$School and Work$mq$, 5, 4 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Classroom Language and Instructions$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$School and Work$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Classroom Language and Instructions$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 站起来 (zhàn qǐlai) mean?$mq$, $mq$["Stand up","Sit down","Open your book","Be quiet"]$mq$, 0, $mq$站 means stand. To sit down is 坐下 (zuòxia).$mq$, $mq$easy$mq$),
($mq$What does 听 (tīng) mean?$mq$, $mq$["Read","Write","Speak","Listen"]$mq$, 3, $mq$听 means to listen. Reading is 读 (dú), writing is 写 (xiě) and speaking is 说 (shuō).$mq$, $mq$easy$mq$),
($mq$What does 写 (xiě) mean?$mq$, $mq$["Read","Listen","Write","Draw"]$mq$, 2, $mq$写 means to write. Reading aloud is 读 (dú).$mq$, $mq$easy$mq$),
($mq$What does 我不明白 (wǒ bù míngbai) mean?$mq$, $mq$["I do not agree","I do not understand","I do not have a pen","I am not here"]$mq$, 1, $mq$明白 means to understand, and 不 makes it negative.$mq$, $mq$easy$mq$),
($mq$What does 请安静 (qǐng ānjìng) mean?$mq$, $mq$["Please be quiet","Please sit down","Please come in","Please read aloud"]$mq$, 0, $mq$安静 means quiet. 请 means please.$mq$, $mq$easy$mq$),
($mq$What does 请打开书，第十页 (qǐng dǎkāi shū, dì shí yè) mean?$mq$, $mq$["Please close your book at page ten","Please write ten pages","Please read ten books","Please open your book to page ten"]$mq$, 3, $mq$打开 is open and 第十页 is 'page ten'. 第 (dì) makes numbers ordinal.$mq$, $mq$medium$mq$),
($mq$You did not hear the teacher. What do you say?$mq$, $mq$["老师，再见 (lǎoshī, zàijiàn)","老师，请坐 (lǎoshī, qǐng zuò)","老师，请再说一遍 (lǎoshī, qǐng zài shuō yí biàn)","老师，我很好 (lǎoshī, wǒ hěn hǎo)"]$mq$, 2, $mq$再说一遍 means 'say it once more'. The other replies do not ask for repetition.$mq$, $mq$medium$mq$),
($mq$A sign says 请不要说话 (qǐng búyào shuōhuà). What does it mean?$mq$, $mq$["Please speak Chinese","Please do not talk","Please talk louder","Please listen to me"]$mq$, 1, $mq$不要 means 'do not' and 说话 means to talk.$mq$, $mq$medium$mq$),
($mq$What does the teacher want when she says 请举手 (qǐng jǔ shǒu)?$mq$, $mq$["Raise your hand","Stand up","Hand in your homework","Wave goodbye"]$mq$, 0, $mq$举 is raise and 手 is hand.$mq$, $mq$medium$mq$),
($mq$What does 书用英语怎么说？(shū yòng Yīngyǔ zěnme shuō?) ask?$mq$, $mq$["Where is the book?","How many books are there?","What do you read?","How do you say 书 in English?"]$mq$, 3, $mq$用英语 means 'using English' and 怎么说 means 'how to say'.$mq$, $mq$medium$mq$),
($mq$The teacher says 对了！(duì le!). What does she mean?$mq$, $mq$["Wrong!","Sit down!","Correct!","Be quiet!"]$mq$, 2, $mq$对 means correct. Wrong is 错 (cuò).$mq$, $mq$medium$mq$),
($mq$Notice: 下课以后请关灯和关门。(Xiàkè yǐhòu qǐng guān dēng hé guān mén.) [下课 = class ends, 以后 = after, 关 = turn off/close]

What must students do after class?$mq$, $mq$["Switch on the light and open the door","Turn off the light and close the door","Clean the board","Stay in the classroom"]$mq$, 1, $mq$关灯 is turn off the light and 关门 is close the door.$mq$, $mq$medium$mq$),
($mq$Which is the correct pinyin for 请坐?$mq$, $mq$["qǐng zuò","qīng zuò","qǐng zuó","qíng zuò"]$mq$, 0, $mq$请 is third tone and 坐 is fourth tone, so qǐng zuò.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 老师: 同学们好！请坐。请打开书，第五页。先听，然后跟我读。(Lǎoshī: Tóngxuémen hǎo! Qǐng zuò. Qǐng dǎkāi shū, dì wǔ yè. Xiān tīng, ránhòu gēn wǒ dú.) [跟我读 = read after me]

What do students do first after they open their books?$mq$, $mq$["Read aloud","Write","Stand up","Listen"]$mq$, 3, $mq$先听 means 'first listen'. Reading after the teacher comes later, after 然后.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 学生: 老师，我有问题。(Xuésheng: Lǎoshī, wǒ yǒu wèntí.) 老师: 请说。(Lǎoshī: Qǐng shuō.) 学生: “谢谢”用英语怎么说？(Xuésheng: “Xièxie” yòng Yīngyǔ zěnme shuō?) [问题 = question]

What is the student asking?$mq$, $mq$["How to say 'thank you' in Chinese","Whether he can leave the room","How to say 谢谢 in English","What the homework is"]$mq$, 2, $mq$The student asks how 谢谢 is said in English.$mq$, $mq$hard$mq$),
($mq$The teacher says: 请站起来，请看黑板，请坐下。(Qǐng zhàn qǐlai, qǐng kàn hēibǎn, qǐng zuòxia.) What is the correct order of actions?$mq$, $mq$["Sit down, look at the board, stand up","Stand up, look at the board, sit down","Look at the board, stand up, sit down","Stand up, sit down, look at the board"]$mq$, 1, $mq$The instructions are given in the order they should be done.$mq$, $mq$hard$mq$),
($mq$Which sentence means 'Don't write!'?$mq$, $mq$["不要写！(búyào xiě!)","没写！(méi xiě!)","我不写。(wǒ bù xiě.)","不是写！(bú shì xiě!)"]$mq$, 0, $mq$不要 gives a negative command. 我不写 means 'I won't write', which is a statement about yourself.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 老师: 你明白吗？(Lǎoshī: Nǐ míngbai ma?) 学生: 对不起，我不明白。(Xuésheng: Duìbuqǐ, wǒ bù míngbai.) 老师: 没关系，我再说一遍。(Lǎoshī: Méi guānxi, wǒ zài shuō yí biàn.)

How does the teacher respond?$mq$, $mq$["She tells the student off","She ends the lesson","She asks him to leave","She says it is fine and will explain again"]$mq$, 3, $mq$没关系 means 'no problem' and 我再说一遍 means 'I will say it again'.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Classroom Language and Instructions$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$请坐 / 请站起来$mq$, $mq$请坐 (qǐng zuò) = please sit; 请站起来 (qǐng zhàn qǐlai) = please stand up.$mq$),
($mq$请打开书，第十页$mq$, $mq$Qǐng dǎkāi shū, dì shí yè = Please open your book to page ten. 第…页 (dì…yè) = page number.$mq$),
($mq$听 / 读 / 写 / 说$mq$, $mq$听 (tīng) listen; 读 (dú) read; 写 (xiě) write; 说 (shuō) speak.$mq$),
($mq$请再说一遍$mq$, $mq$Qǐng zài shuō yí biàn = Please say it again. Use it when you did not hear or understand.$mq$),
($mq$我不明白 / 我明白了$mq$, $mq$我不明白 (wǒ bù míngbai) = I don't understand; 我明白了 (wǒ míngbai le) = I understand now.$mq$),
($mq$不要 (búyào)$mq$, $mq$Don't. 请不要说话 (qǐng búyào shuōhuà) = please don't talk. Different from 不 alone, which means 'not'.$mq$),
($mq$上课 / 下课$mq$, $mq$上课 (shàngkè) = the lesson begins; 下课 (xiàkè) = the lesson ends.$mq$),
($mq$对 / 错$mq$, $mq$对 (duì) = correct; 错 (cuò) = wrong. 对了！(duì le!) = Correct!$mq$),
($mq$“书”用英语怎么说？$mq$, $mq$Shū yòng Yīngyǔ zěnme shuō? = How do you say 书 in English? Useful for asking vocabulary.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Classroom Language and Instructions$mq$ and p.name = $mq$School and Work$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Understanding the classroom
Classroom language is the Mandarin you hear and use in lessons. It appears in listening tasks, because teachers give instructions, and in dialogues where students ask for help. A short list of key phrases will make you more confident and also improves your writing and speaking.

## Teacher instructions
- 请坐 (qǐng zuò) / 坐下 (zuòxia): sit down
- 请站起来 (qǐng zhàn qǐlai): please stand up
- 请打开书 (qǐng dǎkāi shū): please open your book
- 请合上书 (qǐng hé shàng shū): please close your book
- 请看黑板 (qǐng kàn hēibǎn): please look at the board
- 请听 (qǐng tīng): please listen
- 请读 (qǐng dú): please read
- 请写 (qǐng xiě): please write
- 请说 (qǐng shuō): please speak
- 请跟我读 (qǐng gēn wǒ dú): please read after me
- 请安静 (qǐng ānjìng): please be quiet
- 请举手 (qǐng jǔ shǒu): please raise your hand
The word 请 (qǐng, please) is the most common start of an instruction. A page number uses 第 (dì) + number + 页 (yè): 第十页 (dì shí yè) means page ten.

## Negative commands
Use 不要 (búyào) to say "don't": 请不要说话 (qǐng búyào shuōhuà), "Please don't talk". Do not confuse it with 不 alone, which describes what you do: 我不写 (wǒ bù xiě) means "I don't write / I won't write".

## What students say
- 我不明白 (wǒ bù míngbai) or 我不懂 (wǒ bù dǒng): I don't understand
- 我明白了 (wǒ míngbai le): I understand now
- 请再说一遍 (qǐng zài shuō yí biàn): please say it again
- 老师，我有问题 (lǎoshī, wǒ yǒu wèntí): teacher, I have a question
- 请问… (qǐngwèn…): excuse me, may I ask…
- “书”用英语怎么说？(“shū” yòng Yīngyǔ zěnme shuō?): how do you say 书 in English?
- 对 (duì) correct and 错 (cuò) wrong

## Lesson start and end
- 上课 (shàngkè): the lesson begins
- 下课 (xiàkè): the lesson ends
- 开始 (kāishǐ): to begin
- 作业 (zuòyè): homework
- 同学们好 (tóngxuémen hǎo) is the teacher's greeting, answered with 老师好 (lǎoshī hǎo).

## Worked example
Teacher: 请打开书，第五页。(Open your books to page five.) Teacher: 先听，然后跟我读。(First listen, then read after me.) The key order words are 先 (first) and 然后 (then). If a question asks what you do first, choose the action after 先, which is listening.

## Putting a request politely
Start with 老师 and add 请: 老师，请再说一遍。(Teacher, please say it again.) Finish with 谢谢 if the teacher helps you. If you are sorry, say 对不起 and the teacher may reply 没关系.

## Common mistakes
- Mixing 听 (listen) and 看 (look) because both are used for senses.
- Confusing 不要 (don't!) and 不 (not).
- Reading 第十页 (page ten) as ten pages.
- Forgetting tone marks on 请 (qǐng) and 坐 (zuò).

## How this is examined
Classroom language appears in listening transcripts of lessons, signs on classroom doors and notes from teachers. You might be asked what the teacher wants you to do, in which order, or what a student is asking. In writing, you might write a short note to a teacher asking for help.

Exam tip: Look for 请 and 先 / 然后 because they mark the instruction and the sequence. When a question asks for the order of actions, number each action in the text before you read the answer options.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('mandarin-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;