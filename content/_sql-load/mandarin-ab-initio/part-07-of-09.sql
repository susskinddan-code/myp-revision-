-- Part 7 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Free Time and Health > Hobbies and Sports
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Free Time and Health$mq$, 5, 7 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Hobbies and Sports$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Free Time and Health$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Hobbies and Sports$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 踢足球 (tī zúqiú) mean?$mq$, $mq$["Play football","Play basketball","Swim","Run"]$mq$, 0, $mq$踢 means kick and 足球 is football (soccer). Basketball is 篮球 (lánqiú).$mq$, $mq$easy$mq$),
($mq$What does 游泳 (yóuyǒng) mean?$mq$, $mq$["Run","Dance","Sing","Swim"]$mq$, 3, $mq$游泳 means to swim. Running is 跑步 (pǎobù).$mq$, $mq$easy$mq$),
($mq$What does 唱歌 (chànggē) mean?$mq$, $mq$["Dance","Draw","Sing","Read"]$mq$, 2, $mq$唱歌 is to sing. Dancing is 跳舞 (tiàowǔ).$mq$, $mq$easy$mq$),
($mq$What does 爱好 (àihào) mean?$mq$, $mq$["Sport","Hobby","Friend","Homework"]$mq$, 1, $mq$爱好 means hobby or interest. 你的爱好是什么？ asks 'What are your hobbies?'$mq$, $mq$easy$mq$),
($mq$What does 跳舞 (tiàowǔ) mean?$mq$, $mq$["Dance","Sing","Swim","Cycle"]$mq$, 0, $mq$跳舞 means to dance. Singing is 唱歌.$mq$, $mq$easy$mq$),
($mq$What does 我喜欢打篮球 (wǒ xǐhuan dǎ lánqiú) mean?$mq$, $mq$["I like watching basketball","I do not like basketball","I can play basketball","I like playing basketball"]$mq$, 3, $mq$喜欢 is like and 打篮球 is play basketball.$mq$, $mq$medium$mq$),
($mq$Which verb is used with 足球 (zúqiú, football)?$mq$, $mq$["打 (dǎ)","弹 (tán)","踢 (tī)","唱 (chàng)"]$mq$, 2, $mq$Football uses 踢 (kick). 打 is used for basketball, tennis and table tennis, and 弹 for instruments.$mq$, $mq$medium$mq$),
($mq$What does 他弹钢琴 (tā tán gāngqín) mean?$mq$, $mq$["He sings","He plays the piano","He buys a piano","He listens to the piano"]$mq$, 1, $mq$弹 is used with instruments that you pluck or press, such as the piano.$mq$, $mq$medium$mq$),
($mq$Which is the best reply to 你的爱好是什么？(nǐ de àihào shì shénme?)$mq$, $mq$["我的爱好是画画 (wǒ de àihào shì huàhuà)","我十五岁 (wǒ shíwǔ suì)","我住在上海 (wǒ zhù zài Shànghǎi)","我是学生 (wǒ shì xuéshēng)"]$mq$, 0, $mq$The question asks about hobbies. 画画 means draw or paint.$mq$, $mq$medium$mq$),
($mq$What does 我不太喜欢跑步 (wǒ bú tài xǐhuan pǎobù) mean?$mq$, $mq$["I like running a lot","I cannot run","I run every day","I do not like running very much"]$mq$, 3, $mq$不太 means 'not very'. Note that 不 becomes bú before the fourth tone 太.$mq$, $mq$medium$mq$),
($mq$Read: 小明喜欢踢足球，也喜欢打乒乓球。他不喜欢游泳。(Xiǎomíng xǐhuan tī zúqiú, yě xǐhuan dǎ pīngpāngqiú. Tā bù xǐhuan yóuyǒng.)

What does Xiaoming NOT like?$mq$, $mq$["Football","Table tennis","Swimming","Playing sport"]$mq$, 2, $mq$不喜欢游泳 means he does not like swimming. He likes football and table tennis.$mq$, $mq$medium$mq$),
($mq$What does 我周末经常骑自行车 (wǒ zhōumò jīngcháng qí zìxíngchē) mean?$mq$, $mq$["At weekends I never cycle","At weekends I often cycle","On weekdays I walk to school","I cycle once a year"]$mq$, 1, $mq$周末 is weekend, 经常 is often and 骑自行车 is ride a bike.$mq$, $mq$medium$mq$),
($mq$Which is the correct pinyin for 乒乓球 (table tennis)?$mq$, $mq$["pīngpāngqiú","pīngbāngqiú","pǐngpāngqiú","pīngpàngqiú"]$mq$, 0, $mq$乒 is pīng, 乓 is pāng and 球 is qiú. The first two syllables are first tone.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 玲玲: 你周末做什么？(Línglíng: Nǐ zhōumò zuò shénme?) 大卫: 星期六我踢足球，星期天我在家看书。你呢？(Dàwèi: Xīngqīliù wǒ tī zúqiú, xīngqītiān wǒ zài jiā kànshū. Nǐ ne?) 玲玲: 我星期六游泳，星期天和朋友唱歌。(Línglíng: Wǒ xīngqīliù yóuyǒng, xīngqītiān hé péngyou chànggē.)

What does Lingling do on Sunday?$mq$, $mq$["Reads at home","Plays football","Swims","Sings with friends"]$mq$, 3, $mq$星期天 is Sunday. Lingling sings with friends (和朋友唱歌). David reads at home and she swims on Saturday.$mq$, $mq$hard$mq$),
($mq$Message: 明天下午三点我们打篮球，你来吗？(Míngtiān xiàwǔ sān diǎn wǒmen dǎ lánqiú, nǐ lái ma?) Reply: 我不会打篮球，但是我想看。(Wǒ bú huì dǎ lánqiú, dànshì wǒ xiǎng kàn.) [来 = come, 但是 = but]

What does the reply say?$mq$, $mq$["I cannot come because I am busy","I can play basketball and I want to watch","I cannot play basketball but I want to watch","I do not like basketball"]$mq$, 2, $mq$不会 means 'cannot (not know how to)'. 但是 means 'but', and 想看 means 'want to watch'.$mq$, $mq$hard$mq$),
($mq$Which sentence says 'I can swim'?$mq$, $mq$["我游泳会 (wǒ yóuyǒng huì)","我会游泳 (wǒ huì yóuyǒng)","我是游泳 (wǒ shì yóuyǒng)","我有游泳 (wǒ yǒu yóuyǒng)"]$mq$, 1, $mq$会 (huì) means 'can' as a learned skill, and goes before the verb.$mq$, $mq$hard$mq$),
($mq$A student writes 我喜欢打足球 (wǒ xǐhuan dǎ zúqiú). What is the mistake?$mq$, $mq$["The verb for football should be 踢","喜欢 should be 是","足球 should be 篮球","There is no mistake"]$mq$, 0, $mq$Football uses 踢: 我喜欢踢足球. 打 is used for basketball, tennis and table tennis.$mq$, $mq$hard$mq$),
($mq$Class survey (each student chose one): 十个人喜欢游泳，八个人喜欢跑步，六个人喜欢跳舞。(Shí ge rén xǐhuan yóuyǒng, bā ge rén xǐhuan pǎobù, liù ge rén xǐhuan tiàowǔ.)

How many students answered the survey in total?$mq$, $mq$["18","16","14","24"]$mq$, 3, $mq$10 + 8 + 6 = 24.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Hobbies and Sports$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$踢足球 / 打篮球$mq$, $mq$踢足球 (tī zúqiú) = play football; 打篮球 (dǎ lánqiú) = play basketball. Football uses 踢, ball games with a racket or hand use 打.$mq$),
($mq$打乒乓球 / 打网球$mq$, $mq$打乒乓球 (dǎ pīngpāngqiú) = play table tennis; 打网球 (dǎ wǎngqiú) = play tennis.$mq$),
($mq$游泳 / 跑步$mq$, $mq$游泳 (yóuyǒng) = swim; 跑步 (pǎobù) = run.$mq$),
($mq$唱歌 / 跳舞 / 画画$mq$, $mq$唱歌 (chànggē) = sing; 跳舞 (tiàowǔ) = dance; 画画 (huàhuà) = draw or paint.$mq$),
($mq$弹钢琴 / 弹吉他$mq$, $mq$弹钢琴 (tán gāngqín) = play the piano; 弹吉他 (tán jítā) = play the guitar. Use 弹 with instruments.$mq$),
($mq$你的爱好是什么？$mq$, $mq$Nǐ de àihào shì shénme? = What are your hobbies? Reply: 我的爱好是… (wǒ de àihào shì…).$mq$),
($mq$我不太喜欢…$mq$, $mq$Wǒ bú tài xǐhuan… = I don't like… very much. 不太 (bú tài) = not very.$mq$),
($mq$经常 / 周末$mq$, $mq$经常 (jīngcháng) = often, before the verb; 周末 (zhōumò) = weekend.$mq$),
($mq$会 (huì)$mq$, $mq$Can, as a learned skill: 我会游泳 (wǒ huì yóuyǒng) = I can swim. Negative: 不会 (bú huì).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Hobbies and Sports$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Free-time vocabulary
Hobbies are a favourite topic for beginner reading, listening and writing tasks. You are expected to name hobbies, say what you like and dislike, and talk about what you do at weekends. Remember to learn each word with pinyin and tone marks.

## Sports
- 踢足球 (tī zúqiú): play football
- 打篮球 (dǎ lánqiú): play basketball
- 打乒乓球 (dǎ pīngpāngqiú): play table tennis
- 打网球 (dǎ wǎngqiú): play tennis
- 游泳 (yóuyǒng): swim
- 跑步 (pǎobù): run
- 骑自行车 (qí zìxíngchē): ride a bike

## Other hobbies
- 唱歌 (chànggē): sing
- 跳舞 (tiàowǔ): dance
- 画画 (huàhuà): draw, paint
- 看书 (kànshū): read
- 听音乐 (tīng yīnyuè): listen to music
- 弹钢琴 (tán gāngqín): play the piano
- 弹吉他 (tán jítā): play the guitar
- 玩游戏 (wán yóuxì): play games

## Choosing the right verb
Mandarin uses a different verb with different activities, so learn them as a set.
- 踢 (tī, kick) is used for football: 踢足球.
- 打 (dǎ, hit) is used for ball games with a bat, racket or hand: 打篮球, 打网球, 打乒乓球.
- 弹 (tán, play) is used for the piano and the guitar: 弹钢琴, 弹吉他.
- 骑 (qí, ride) is used for bikes: 骑自行车.
Using the wrong verb, such as 打足球, is a very common mistake.

## Likes and dislikes
Use 喜欢 (xǐhuan) followed by the activity: 我喜欢游泳 (wǒ xǐhuan yóuyǒng). Add 很 (hěn) before 喜欢 for "like a lot" and 不 (bù) for a dislike: 我不喜欢跑步 (wǒ bù xǐhuan pǎobù). 不太 (bú tài) means "not very": 我不太喜欢跑步. Use 也 (yě, also) before the verb: 他也喜欢踢足球 (tā yě xǐhuan tī zúqiú). To ask, say 你的爱好是什么？(nǐ de àihào shì shénme?), "What are your hobbies?", and answer 我的爱好是画画 (wǒ de àihào shì huàhuà).

## Frequency and ability
- 经常 (jīngcháng) / 常常 (chángcháng): often, placed before the verb: 我经常骑自行车.
- 周末 (zhōumò): weekend: 周末我踢足球.
- 会 (huì): can, a learned skill: 我会游泳 (wǒ huì yóuyǒng), "I can swim". The negative is 不会: 我不会打篮球 (wǒ bú huì dǎ lánqiú).
- 想 (xiǎng): want to: 我想看 (wǒ xiǎng kàn), "I want to watch".
- 但是 (dànshì): but.

## Worked example
Read: 星期六我踢足球，星期天我在家看书。 This means "On Saturday I play football, on Sunday I read at home". To answer "What does he do on Sunday?", find 星期天 first. The answer is after it: reading at home.

## Common mistakes
- Using 打 with 足球 (it should be 踢).
- Writing 我会不游泳 instead of 我不会游泳.
- Forgetting the tone change 不 to bú in 不太 and 不会.
- Putting 经常 after the verb.

## How this is examined
Hobby questions appear in messages inviting a friend, surveys, short profiles and listening dialogues comparing two people's weekends. You will often be asked who likes what, which day an activity happens, or whether someone can do something. In writing, give two or three hobbies, a reason or frequency, and a sentence about a friend.

Exam tip: In dialogues with two speakers, write A and B at the top of your notes and record each person's hobbies separately. The wrong options in the exam are usually correct facts about the other speaker.$mq$ from st;

-- Free Time and Health > Weather and Seasons
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Free Time and Health$mq$, 5, 7 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Weather and Seasons$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Free Time and Health$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Weather and Seasons$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 下雨 (xià yǔ) mean?$mq$, $mq$["It is raining","It is snowing","It is windy","It is sunny"]$mq$, 0, $mq$下 is to fall and 雨 is rain. 下雪 (xià xuě) is snow.$mq$, $mq$easy$mq$),
($mq$What does 夏天 (xiàtiān) mean?$mq$, $mq$["Spring","Autumn","Winter","Summer"]$mq$, 3, $mq$夏天 is summer. Winter is 冬天 (dōngtiān).$mq$, $mq$easy$mq$),
($mq$What does 冷 (lěng) mean?$mq$, $mq$["Hot","Warm","Cold","Wet"]$mq$, 2, $mq$冷 means cold. Hot is 热 (rè).$mq$, $mq$easy$mq$),
($mq$What does 晴天 (qíngtiān) mean?$mq$, $mq$["A cloudy day","A sunny day","A rainy day","A snowy day"]$mq$, 1, $mq$晴天 is a clear, sunny day. A cloudy day is 阴天 (yīntiān).$mq$, $mq$easy$mq$),
($mq$What does 冬天 (dōngtiān) mean?$mq$, $mq$["Winter","Spring","Summer","Autumn"]$mq$, 0, $mq$冬天 is winter, the cold season. Spring is 春天 (chūntiān).$mq$, $mq$easy$mq$),
($mq$What does 今天天气怎么样？(jīntiān tiānqì zěnmeyàng?) ask?$mq$, $mq$["What day is it today?","How old are you today?","What time is it?","What is the weather like today?"]$mq$, 3, $mq$天气 is weather and 怎么样 means 'how is it?'$mq$, $mq$medium$mq$),
($mq$What does 今天二十八度，很热 (jīntiān èrshíbā dù, hěn rè) tell you?$mq$, $mq$["Today is 8 degrees and very hot","Today is 28 degrees and very cold","Today is 28 degrees and very hot","Yesterday was 28 degrees"]$mq$, 2, $mq$度 (dù) means degrees. 二十八 is 28 and 很热 is very hot.$mq$, $mq$medium$mq$),
($mq$Which is the correct pinyin for 秋天 (autumn)?$mq$, $mq$["qiùtiān","qiūtiān","qiūtián","quītiān"]$mq$, 1, $mq$秋 is first tone (qiū) and 天 is first tone (tiān).$mq$, $mq$medium$mq$),
($mq$Forecast: 明天会下雨，请带雨伞。(Míngtiān huì xiàyǔ, qǐng dài yǔsǎn.) [会 = will, 带 = bring, 雨伞 = umbrella]

What is the advice?$mq$, $mq$["Bring an umbrella","Stay at home","Wear a winter coat","Go swimming"]$mq$, 0, $mq$请带雨伞 means 'please bring an umbrella' because it will rain tomorrow.$mq$, $mq$medium$mq$),
($mq$What does 零下五度 (língxià wǔ dù) mean?$mq$, $mq$["Five degrees above zero","Fifteen degrees","Fifty degrees","Five degrees below zero"]$mq$, 3, $mq$零下 means 'below zero'.$mq$, $mq$medium$mq$),
($mq$Read: 北京的冬天很冷，常常下雪。(Běijīng de dōngtiān hěn lěng, chángcháng xiàxuě.)

What is winter in Beijing like?$mq$, $mq$["Warm and rainy","Hot and sunny","Very cold and often snowy","Cool and windy"]$mq$, 2, $mq$很冷 means very cold, and 常常下雪 means it often snows.$mq$, $mq$medium$mq$),
($mq$What does 今天不冷 (jīntiān bù lěng) mean?$mq$, $mq$["Today is very cold","Today is not cold","Yesterday was not cold","Today is cold and windy"]$mq$, 1, $mq$不 makes the adjective negative. 今天 is today.$mq$, $mq$medium$mq$),
($mq$What does 太热了 (tài rè le) mean?$mq$, $mq$["Too hot!","Not hot","A little hot","Not very hot"]$mq$, 0, $mq$太…了 means 'too…'. 太热了 says it is too hot.$mq$, $mq$medium$mq$),
($mq$Read: 星期一晴天，二十度。星期二阴天，十八度。星期三下雨，十五度。(Xīngqīyī qíngtiān, èrshí dù. Xīngqī'èr yīntiān, shíbā dù. Xīngqīsān xiàyǔ, shíwǔ dù.)

Which day is the coldest and wettest?$mq$, $mq$["Monday","Tuesday","Thursday","Wednesday"]$mq$, 3, $mq$星期三 is Wednesday: it rains and it is the lowest temperature at 15 degrees.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 小明: 你喜欢哪个季节？(Xiǎomíng: Nǐ xǐhuan nǎ ge jìjié?) 玲玲: 我喜欢秋天，因为不冷也不热。(Línglíng: Wǒ xǐhuan qiūtiān, yīnwèi bù lěng yě bú rè.) [季节 = season]

Why does Lingling like autumn?$mq$, $mq$["It is always snowing","It is the hottest season","It is neither cold nor hot","It is her birthday season"]$mq$, 2, $mq$不冷也不热 means 'not cold and also not hot'.$mq$, $mq$hard$mq$),
($mq$Read: 昨天二十五度，今天二十度。今天比昨天冷。(Zuótiān èrshíwǔ dù, jīntiān èrshí dù. Jīntiān bǐ zuótiān lěng.) [比 = than, 昨天 = yesterday]

How many degrees colder is today than yesterday?$mq$, $mq$["45 degrees","5 degrees","20 degrees","25 degrees"]$mq$, 1, $mq$25 − 20 = 5 degrees.$mq$, $mq$hard$mq$),
($mq$A student writes 今天天气是很热 (jīntiān tiānqì shì hěn rè). What is the mistake?$mq$, $mq$["是 should not be used before an adjective","热 should be 冷","很 should come after 热","There is no mistake"]$mq$, 0, $mq$Adjectives are not linked with 是: 今天天气很热.$mq$, $mq$hard$mq$),
($mq$Which sentence is TRUE?$mq$, $mq$["北京的一月很热 (Běijīng de yī yuè hěn rè)","北京的七月是冬天 (Běijīng de qī yuè shì dōngtiān)","澳大利亚的七月是夏天 (Àodàlìyà de qī yuè shì xiàtiān)","澳大利亚的十二月是夏天 (Àodàlìyà de shí'èr yuè shì xiàtiān)"]$mq$, 3, $mq$Australia is in the southern hemisphere, so December is summer and July is winter. In Beijing, January is cold and July is summer.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Weather and Seasons$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$春天 / 夏天$mq$, $mq$春天 (chūntiān) = spring; 夏天 (xiàtiān) = summer.$mq$),
($mq$秋天 / 冬天$mq$, $mq$秋天 (qiūtiān) = autumn; 冬天 (dōngtiān) = winter.$mq$),
($mq$晴天 / 阴天$mq$, $mq$晴天 (qíngtiān) = sunny; 阴天 (yīntiān) = cloudy.$mq$),
($mq$下雨 / 下雪 / 刮风$mq$, $mq$下雨 (xià yǔ) = rain; 下雪 (xià xuě) = snow; 刮风 (guā fēng) = windy.$mq$),
($mq$热 / 冷$mq$, $mq$热 (rè) = hot; 冷 (lěng) = cold. Use 很 before them: 很热, and do not add 是.$mq$),
($mq$今天天气怎么样？$mq$, $mq$Jīntiān tiānqì zěnmeyàng? = What is the weather like today? Reply: 今天很热 (jīntiān hěn rè).$mq$),
($mq$度 / 零下$mq$, $mq$度 (dù) = degrees: 二十五度 = 25 degrees. 零下 (língxià) = below zero: 零下五度 = minus 5 degrees.$mq$),
($mq$比 (bǐ)$mq$, $mq$Than: 今天比昨天冷 (jīntiān bǐ zuótiān lěng) = Today is colder than yesterday.$mq$),
($mq$明天会下雨$mq$, $mq$Míngtiān huì xiàyǔ = It will rain tomorrow. 会 (huì) can mean 'will'.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Weather and Seasons$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Describing the weather
Weather is a classic beginner topic because it uses short, simple sentences. In Mandarin you can say a lot with only a few key words. You will meet weather in forecasts, messages to friends and holiday postcards.

## Weather words
- 天气 (tiānqì): weather
- 晴天 (qíngtiān): sunny day
- 阴天 (yīntiān): cloudy day
- 下雨 (xià yǔ): rain, it is raining
- 下雪 (xià xuě): snow, it is snowing
- 刮风 (guā fēng): windy
- 热 (rè): hot
- 冷 (lěng): cold
- 暖和 (nuǎnhuo): warm
- 凉快 (liángkuai): pleasantly cool
- 雨伞 (yǔsǎn): umbrella

## Seasons
- 春天 (chūntiān): spring
- 夏天 (xiàtiān): summer
- 秋天 (qiūtiān): autumn
- 冬天 (dōngtiān): winter
- 季节 (jìjié): season

## Asking and answering
Ask 今天天气怎么样？(jīntiān tiānqì zěnmeyàng?), "What is the weather like today?". Possible answers:
- 今天很热 (jīntiān hěn rè): It's very hot today.
- 今天下雨 (jīntiān xiàyǔ): It's raining today.
- 今天不冷 (jīntiān bù lěng): It's not cold today.
- 太热了！(tài rè le!): It's too hot!
Remember that adjectives do not need 是. Say 今天很热, not 今天是很热. Put 很 before the adjective; with 不 there is no 很: 今天不冷.

## Temperature
度 (dù) means degrees: 二十五度 (èrshíwǔ dù) is 25 degrees. 零下 (língxià) means below zero: 零下五度 (língxià wǔ dù) is minus five degrees.

## Comparing
比 (bǐ) means "than": 今天比昨天冷 (jīntiān bǐ zuótiān lěng), "Today is colder than yesterday". 昨天 (zuótiān) is yesterday. The adjective stays at the end.

## Future weather
会 (huì) can mean "will": 明天会下雨 (míngtiān huì xiàyǔ), "It will rain tomorrow". A forecast often adds advice: 请带雨伞 (qǐng dài yǔsǎn), "Please bring an umbrella".

## Seasons around the world
In China the seasons are like those of the northern hemisphere. In Beijing the winter is cold and sometimes snowy, and July is in summer. In Australia the seasons are reversed, so December is summer and July is winter. A text may also say which season people like with 喜欢 and 因为.

## Common mistakes
- Using 是 before an adjective.
- Mixing up 春天 (spring) and 冬天 (winter), or 夏天 and 秋天.
- Forgetting 度 after the number of degrees.
- Missing 零下 and reading a minus temperature as a positive one.

## How this is examined
Forecasts appear as a short list of days with weather and temperature, and questions ask which day is hottest, coldest or wettest. In listening tasks speakers describe a holiday or a favourite season. In writing tasks you describe the weather in your town in each season.

Exam tip: With a forecast, write the days and temperatures in a quick table before answering. Look out for 零下 (below zero) and 不 (not), because one small word reverses the meaning.$mq$ from st;

-- Free Time and Health > Health and the Body
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Free Time and Health$mq$, 5, 7 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Health and the Body$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Free Time and Health$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Health and the Body$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 头 (tóu) mean?$mq$, $mq$["Head","Hand","Foot","Leg"]$mq$, 0, $mq$头 is the head. The hand is 手 (shǒu).$mq$, $mq$easy$mq$),
($mq$What does 眼睛 (yǎnjing) mean?$mq$, $mq$["Ears","Nose","Mouth","Eyes"]$mq$, 3, $mq$眼睛 means eyes. Ears are 耳朵 (ěrduo).$mq$, $mq$easy$mq$),
($mq$What does 手 (shǒu) mean?$mq$, $mq$["Foot","Mouth","Hand","Leg"]$mq$, 2, $mq$手 is hand. Foot is 脚 (jiǎo).$mq$, $mq$easy$mq$),
($mq$What does 药 (yào) mean?$mq$, $mq$["Water","Medicine","Doctor","Hospital"]$mq$, 1, $mq$药 is medicine. 吃药 (chī yào) means take medicine.$mq$, $mq$easy$mq$),
($mq$What does 肚子 (dùzi) mean?$mq$, $mq$["Stomach, belly","Back","Tooth","Throat"]$mq$, 0, $mq$肚子 is the stomach or belly. 肚子疼 (dùzi téng) means a stomach ache.$mq$, $mq$easy$mq$),
($mq$What does 你怎么了？(nǐ zěnme le?) ask?$mq$, $mq$["How old are you?","Where are you?","Who are you?","What is wrong with you?"]$mq$, 3, $mq$怎么了 means 'what happened?' and is used to ask what is wrong.$mq$, $mq$medium$mq$),
($mq$What does 我头疼 (wǒ tóu téng) mean?$mq$, $mq$["I have a stomach ache","I have a cold","I have a headache","I am tired"]$mq$, 2, $mq$头 is head and 疼 means painful, so 头疼 is a headache.$mq$, $mq$medium$mq$),
($mq$Which sentence means 'I have a toothache'?$mq$, $mq$["我眼睛疼 (wǒ yǎnjing téng)","我牙疼 (wǒ yá téng)","我腿疼 (wǒ tuǐ téng)","我肚子疼 (wǒ dùzi téng)"]$mq$, 1, $mq$牙 is tooth, so 牙疼 is a toothache. The distractors are painful eyes, legs and stomach.$mq$, $mq$medium$mq$),
($mq$Read: 我感冒了，发烧，还咳嗽。(Wǒ gǎnmào le, fāshāo, hái késou.) [还 = also]

What symptoms does the writer have?$mq$, $mq$["A cold, a fever and a cough","A toothache and a cough","A stomach ache and a fever","A cold and a sore leg"]$mq$, 0, $mq$感冒 is a cold, 发烧 is a fever and 咳嗽 is a cough.$mq$, $mq$medium$mq$),
($mq$The doctor says: 多喝水，多休息。(duō hē shuǐ, duō xiūxi.) What is the advice?$mq$, $mq$["Eat more and rest less","Do more sport and drink less","Go to school and drink milk","Drink plenty of water and rest"]$mq$, 3, $mq$多 means 'more / a lot of', 喝水 is drink water and 休息 is rest.$mq$, $mq$medium$mq$),
($mq$Choose the word that completes the sentence: 我不舒服，我想去___。(wǒ bù shūfu, wǒ xiǎng qù ___.) 'I feel unwell, I want to go to the ...'$mq$, $mq$["商店 (shāngdiàn)","饭馆 (fànguǎn)","医院 (yīyuàn)","公园 (gōngyuán)"]$mq$, 2, $mq$When you are unwell you go to a hospital, 医院. 不舒服 means 'not comfortable / unwell'.$mq$, $mq$medium$mq$),
($mq$Which is the correct pinyin for 眼睛?$mq$, $mq$["yǎnjīng","yǎnjing","yánjing","yànjing"]$mq$, 1, $mq$眼 is third tone and 睛 is a neutral tone.$mq$, $mq$medium$mq$),
($mq$How do you say 'I do not have a fever'?$mq$, $mq$["我没发烧 (wǒ méi fāshāo)","我不有发烧 (wǒ bù yǒu fāshāo)","我没是发烧 (wǒ méi shì fāshāo)","我不是发烧 (wǒ bú shì fāshāo)"]$mq$, 0, $mq$没 negates things that have happened or exist. 有 is omitted: 我没发烧.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 医生: 你怎么了？(Yīshēng: Nǐ zěnme le?) 学生: 我头疼，还有点儿咳嗽。(Xuésheng: Wǒ tóu téng, hái yǒudiǎnr késou.) 医生: 你发烧吗？(Yīshēng: Nǐ fāshāo ma?) 学生: 不，我没发烧。(Xuésheng: Bù, wǒ méi fāshāo.) [有点儿 = a little]

What is true about the student?$mq$, $mq$["He has a fever and a cough","He has a stomach ache","He has a toothache and no cough","He has a headache and a slight cough but no fever"]$mq$, 3, $mq$头疼 is a headache, 有点儿咳嗽 a slight cough, and 没发烧 means no fever.$mq$, $mq$hard$mq$),
($mq$Note: 小红今天不能上学。她发烧了，在家休息。(Xiǎohóng jīntiān bù néng shàngxué. Tā fāshāo le, zài jiā xiūxi.) [不能 = cannot]

Why is Xiaohong not at school?$mq$, $mq$["She is at the hospital for a visit","She is on holiday","She has a fever and is resting at home","She has a toothache"]$mq$, 2, $mq$发烧了 means she has a fever and 在家休息 means she is resting at home.$mq$, $mq$hard$mq$),
($mq$A health poster says: 多运动，早睡觉，多喝水，少吃糖。(Duō yùndòng, zǎo shuìjiào, duō hē shuǐ, shǎo chī táng.) [糖 = sugar, 少 = less]

Which advice is NOT on the poster?$mq$, $mq$["Do more exercise","Eat more sugar","Go to bed early","Drink more water"]$mq$, 1, $mq$少吃糖 means eat less sugar. The poster does not advise eating more sugar.$mq$, $mq$hard$mq$),
($mq$A student writes 我疼头 (wǒ téng tóu) for 'I have a headache'. What is the mistake?$mq$, $mq$["The body part comes first: 我头疼","头 should be 手","疼 should be 很","There is no mistake"]$mq$, 0, $mq$The pattern is subject + body part + 疼: 我头疼, 我牙疼, 我肚子疼.$mq$, $mq$hard$mq$),
($mq$Read: 大卫头疼，玲玲牙疼，小明肚子疼。(Dàwèi tóu téng, Línglíng yá téng, Xiǎomíng dùzi téng.)

Who does NOT have a pain in the head or stomach?$mq$, $mq$["David","Xiaoming","Both David and Xiaoming","Lingling"]$mq$, 3, $mq$David has a headache and Xiaoming has a stomach ache. Lingling has toothache.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Health and the Body$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$头 / 眼睛 / 鼻子 / 嘴$mq$, $mq$头 (tóu) head; 眼睛 (yǎnjing) eyes; 鼻子 (bízi) nose; 嘴 (zuǐ) mouth.$mq$),
($mq$耳朵 / 手 / 脚 / 腿$mq$, $mq$耳朵 (ěrduo) ears; 手 (shǒu) hand; 脚 (jiǎo) foot; 腿 (tuǐ) leg.$mq$),
($mq$肚子 / 牙 / 背$mq$, $mq$肚子 (dùzi) stomach; 牙 (yá) tooth; 背 (bèi) back.$mq$),
($mq$你怎么了？$mq$, $mq$Nǐ zěnme le? = What's wrong? Reply with the body part first: 我头疼 (wǒ tóu téng), I have a headache.$mq$),
($mq$我牙疼$mq$, $mq$Wǒ yá téng = I have a toothache. Pattern: subject + body part + 疼 (téng).$mq$),
($mq$感冒 / 发烧 / 咳嗽$mq$, $mq$感冒 (gǎnmào) = a cold; 发烧 (fāshāo) = fever; 咳嗽 (késou) = to cough.$mq$),
($mq$我没发烧$mq$, $mq$Wǒ méi fāshāo = I don't have a fever. Use 没 to negate things that have happened or exist.$mq$),
($mq$多喝水，多休息$mq$, $mq$Duō hē shuǐ, duō xiūxi = Drink plenty of water and rest a lot. 多 (duō) = more; 少 (shǎo) = less.$mq$),
($mq$我不舒服$mq$, $mq$Wǒ bù shūfu = I feel unwell. You might then say 我想去医院 (wǒ xiǎng qù yīyuàn), I want to go to the hospital.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Health and the Body$mq$ and p.name = $mq$Free Time and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The body and feeling unwell
Health vocabulary is useful in real life and is tested in short dialogues at the doctor's, notes to teachers and posters. In this topic you learn the main parts of the body, how to say where it hurts and basic healthy-living advice. This is general school-level language, not medical advice.

## Parts of the body
- 头 (tóu): head
- 眼睛 (yǎnjing): eyes
- 耳朵 (ěrduo): ears
- 鼻子 (bízi): nose
- 嘴 (zuǐ): mouth
- 牙 (yá): tooth
- 手 (shǒu): hand
- 脚 (jiǎo): foot
- 腿 (tuǐ): leg
- 肚子 (dùzi): stomach, belly
- 背 (bèi): back
- 喉咙 (hóulóng): throat

## Illnesses
- 感冒 (gǎnmào): a cold
- 发烧 (fāshāo): to have a fever
- 咳嗽 (késou): to cough
- 生病 (shēngbìng): to be ill
- 不舒服 (bù shūfu): unwell

## Saying where it hurts
The pattern is subject + body part + 疼 (téng, hurts): 我头疼 (wǒ tóu téng) is "I have a headache", 我牙疼 (wǒ yá téng) is "I have a toothache" and 我肚子疼 (wǒ dùzi téng) is "I have a stomach ache". The body part always comes before 疼, so 我疼头 is wrong. To ask what is wrong, say 你怎么了？(nǐ zěnme le?).

## Symptoms and negatives
You can say 我感冒了 (wǒ gǎnmào le), "I have a cold", and 我发烧了 (wǒ fāshāo le), "I have a fever". 了 (le) shows a new situation. Negatives use 没: 我没发烧 (wǒ méi fāshāo), "I don't have a fever". 有点儿 (yǒudiǎnr) means "a bit": 我有点儿咳嗽, "I have a bit of a cough". 还 (hái) means "also" or "still".

## Advice
- 多喝水 (duō hē shuǐ): drink plenty of water
- 多休息 (duō xiūxi): rest a lot
- 吃药 (chī yào): take medicine
- 去医院 (qù yīyuàn): go to the hospital
- 多运动 (duō yùndòng): do more exercise
- 早睡觉 (zǎo shuìjiào): go to bed early
- 少吃糖 (shǎo chī táng): eat less sugar
Notice that 多 (duō) means "more" and 少 (shǎo) means "less". They go before the verb.

## Worked example
Doctor: 你怎么了？ Student: 我头疼，还有点儿咳嗽。 Doctor: 你发烧吗？ Student: 不，我没发烧。 To describe the student, list what is present (headache, slight cough) and what is absent (no fever). Many exam options reverse these, so read the negative words carefully.

## Common mistakes
- Putting the body part after 疼.
- Using 不有 instead of 没有.
- Mixing up 手 (hand), 脚 (foot) and 腿 (leg), which are all limbs.
- Forgetting 医生 is a doctor and 医院 is a hospital.
- Writing 眼睛 with the wrong tones. The pinyin is yǎnjing.

## How this is examined
Health appears in dialogues with a doctor, absence notes from school, posters about healthy habits and lists of symptoms. You may be asked what is wrong, what the doctor advises or which statements are true. In writing, you can write a short note saying you are ill and cannot come to school, including one symptom and one piece of advice.

Exam tip: Make a two-column list for any health dialogue, with "has" and "does not have", then match the options to your list. Check whether the text uses 多 (more) or 少 (less) before choosing advice.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('mandarin-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;