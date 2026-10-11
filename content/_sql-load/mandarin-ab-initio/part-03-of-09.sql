-- Part 3 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Home and Daily Life > Rooms and Furniture
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Home and Daily Life$mq$, 5, 3 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Rooms and Furniture$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Home and Daily Life$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Rooms and Furniture$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 客厅 (kètīng) mean?$mq$, $mq$["Living room","Kitchen","Bedroom","Bathroom"]$mq$, 0, $mq$客厅 is the living room, where the family sits and watches TV. The kitchen is 厨房 (chúfáng).$mq$, $mq$easy$mq$),
($mq$What does 厨房 (chúfáng) mean?$mq$, $mq$["Bathroom","Garden","Bedroom","Kitchen"]$mq$, 3, $mq$厨房 is the kitchen. A bedroom is 卧室 (wòshì).$mq$, $mq$easy$mq$),
($mq$Which word means 'bed'?$mq$, $mq$["桌子 (zhuōzi)","椅子 (yǐzi)","床 (chuáng)","门 (mén)"]$mq$, 2, $mq$床 means bed. 桌子 is a table, 椅子 is a chair and 门 is a door.$mq$, $mq$easy$mq$),
($mq$What does 椅子 (yǐzi) mean?$mq$, $mq$["Table","Chair","Lamp","Sofa"]$mq$, 1, $mq$椅子 is a chair. A table is 桌子 (zhuōzi) and a sofa is 沙发 (shāfā).$mq$, $mq$easy$mq$),
($mq$What does 窗户 (chuānghu) mean?$mq$, $mq$["Window","Door","Lamp","Fridge"]$mq$, 0, $mq$窗户 is a window. A door is 门 (mén).$mq$, $mq$easy$mq$),
($mq$What does 我家有三个卧室 (wǒ jiā yǒu sān ge wòshì) mean?$mq$, $mq$["I have three homes","My bedroom has three beds","I live in three rooms","My home has three bedrooms"]$mq$, 3, $mq$家 is home, 有 is 'has', 三个 is 'three' and 卧室 is bedroom.$mq$, $mq$medium$mq$),
($mq$What does 书在桌子上 (shū zài zhuōzi shàng) mean?$mq$, $mq$["The book is under the table","The book is beside the table","The book is on the table","The book is in the table"]$mq$, 2, $mq$上 (shàng) means on or above. Under would be 下面 (xiàmiàn).$mq$, $mq$medium$mq$),
($mq$What does 猫在床下面 (māo zài chuáng xiàmiàn) mean? [猫 = cat]$mq$, $mq$["The cat is on the bed","The cat is under the bed","The cat is behind the bed","The cat is in the kitchen"]$mq$, 1, $mq$下面 means underneath, so the cat is under the bed.$mq$, $mq$medium$mq$),
($mq$Choose the word that completes the sentence: 我的书___椅子旁边。(wǒ de shū ___ yǐzi pángbiān.) 'My book is beside the chair.'$mq$, $mq$["在 (zài)","有 (yǒu)","是 (shì)","很 (hěn)"]$mq$, 0, $mq$在 means 'is located at'. It is used to say where something is. 有 means 'there is / has'.$mq$, $mq$medium$mq$),
($mq$In which room would you most likely find a 冰箱 (bīngxiāng, fridge)?$mq$, $mq$["卧室 (wòshì)","花园 (huāyuán)","卫生间 (wèishēngjiān)","厨房 (chúfáng)"]$mq$, 3, $mq$A fridge belongs in the kitchen, 厨房. 花园 is the garden and 卫生间 is the bathroom.$mq$, $mq$medium$mq$),
($mq$Read: 我家有一个客厅、两个卧室和一个厨房。客厅里有沙发和电视。(Wǒ jiā yǒu yí ge kètīng, liǎng ge wòshì hé yí ge chúfáng. Kètīng lǐ yǒu shāfā hé diànshì.)

What is in the living room?$mq$, $mq$["A bed and a desk","A fridge and a table","A sofa and a TV","A sofa and a fridge"]$mq$, 2, $mq$The second sentence says 客厅里有沙发和电视: in the living room there is a sofa and a TV.$mq$, $mq$medium$mq$),
($mq$How do you say 'There is no desk in my room'?$mq$, $mq$["我的房间不有书桌 (wǒ de fángjiān bù yǒu shūzhuō)","我的房间没有书桌 (wǒ de fángjiān méiyǒu shūzhuō)","我的房间不是书桌 (wǒ de fángjiān bú shì shūzhuō)","我的房间没书桌有 (wǒ de fángjiān méi shūzhuō yǒu)"]$mq$, 1, $mq$The negative of 有 is 没有, not 不有. 不是 would mean 'is not a desk'.$mq$, $mq$medium$mq$),
($mq$Which is the correct pinyin for 厨房?$mq$, $mq$["chúfáng","chǔfáng","chùfáng","chúfàng"]$mq$, 0, $mq$厨 is second tone (chú) and 房 is also second tone (fáng).$mq$, $mq$medium$mq$),
($mq$Listening transcript: 小明: 我的房间很小。有一张床、一张书桌和一把椅子。书桌在窗户旁边。(Xiǎomíng: Wǒ de fángjiān hěn xiǎo. Yǒu yì zhāng chuáng, yì zhāng shūzhuō hé yì bǎ yǐzi. Shūzhuō zài chuānghu pángbiān.)

Where is the desk?$mq$, $mq$["Under the bed","Next to the door","On the chair","Beside the window"]$mq$, 3, $mq$书桌在窗户旁边: the desk is beside the window. 张 and 把 are measure words for bed/desk and chair.$mq$, $mq$hard$mq$),
($mq$Read: 妈妈在厨房。爸爸在客厅，他在看电视。姐姐在卧室，她不在客厅。(Māma zài chúfáng. Bàba zài kètīng, tā zài kàn diànshì. Jiějie zài wòshì, tā bú zài kètīng.) [看电视 = watch TV]

Who is in the living room?$mq$, $mq$["Mum","Older sister","Dad","Mum and older sister"]$mq$, 2, $mq$Only 爸爸 is said to be in the 客厅. Mum is in the kitchen and the sister is in the bedroom.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'There is a lamp on the desk'?$mq$, $mq$["灯有书桌上 (dēng yǒu shūzhuō shàng)","书桌上有灯 (shūzhuō shàng yǒu dēng)","书桌在灯上有 (shūzhuō zài dēng shàng yǒu)","有灯书桌上 (yǒu dēng shūzhuō shàng)"]$mq$, 1, $mq$For 'there is', use place + 有 + thing. You could also say 灯在书桌上 (the lamp is on the desk), but that uses thing + 在 + place.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'The sofa is in the living room'?$mq$, $mq$["沙发在客厅里 (shāfā zài kètīng lǐ)","沙发有客厅里 (shāfā yǒu kètīng lǐ)","客厅里在沙发 (kètīng lǐ zài shāfā)","沙发是在客厅有 (shāfā shì zài kètīng yǒu)"]$mq$, 0, $mq$Thing + 在 + place tells where something is. 里 (lǐ) means inside.$mq$, $mq$hard$mq$),
($mq$A student writes 我家是三个卧室 (wǒ jiā shì sān ge wòshì) to mean 'My home has three bedrooms'. What is the mistake?$mq$, $mq$["个 should be 吗","三 should come after 卧室","There is no mistake","是 should be 有"]$mq$, 3, $mq$是 links two nouns, but here we want 'has', which is 有: 我家有三个卧室.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Rooms and Furniture$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$客厅 / 卧室 / 厨房$mq$, $mq$客厅 (kètīng) = living room; 卧室 (wòshì) = bedroom; 厨房 (chúfáng) = kitchen.$mq$),
($mq$卫生间 (wèishēngjiān)$mq$, $mq$Bathroom. 花园 (huāyuán) is the garden and 餐厅 (cāntīng) is the dining room.$mq$),
($mq$桌子 / 椅子 / 床$mq$, $mq$桌子 (zhuōzi) = table; 椅子 (yǐzi) = chair; 床 (chuáng) = bed. The 子 in the first two is neutral tone.$mq$),
($mq$沙发 / 冰箱 / 电视$mq$, $mq$沙发 (shāfā) = sofa; 冰箱 (bīngxiāng) = fridge; 电视 (diànshì) = television.$mq$),
($mq$我家有…$mq$, $mq$Wǒ jiā yǒu… = My home has… For example 我家有三个卧室 (wǒ jiā yǒu sān ge wòshì), my home has three bedrooms.$mq$),
($mq$没有 (méiyǒu)$mq$, $mq$The negative of 有 (to have / there is). Say 没有, never 不有: 房间里没有桌子 = there is no table in the room.$mq$),
($mq$书在桌子上$mq$, $mq$Shū zài zhuōzi shàng = The book is on the table. Thing + 在 + place says where something is.$mq$),
($mq$上 / 下 / 里 / 旁边$mq$, $mq$上 (shàng) on; 下 (xià) under; 里 (lǐ) inside; 旁边 (pángbiān) beside. 前面 (qiánmian) = in front; 后面 (hòumiàn) = behind.$mq$),
($mq$有 or 在?$mq$, $mq$Place + 有 + thing = there is (客厅里有沙发). Thing + 在 + place = is located (沙发在客厅里).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Rooms and Furniture$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Talking about your home
Describing where you live is a popular topic in reading and listening tasks. In Mandarin a home is 家 (jiā) and a house or flat is 房子 (fángzi). A single room in a house is 房间 (fángjiān), as in 我的房间 (wǒ de fángjiān), "my room". Always learn each word with its pinyin and tone marks.

## Rooms
- 客厅 (kètīng): living room
- 卧室 (wòshì): bedroom
- 厨房 (chúfáng): kitchen
- 卫生间 (wèishēngjiān): bathroom
- 餐厅 (cāntīng): dining room
- 花园 (huāyuán): garden

## Furniture and objects
- 桌子 (zhuōzi): table
- 椅子 (yǐzi): chair
- 床 (chuáng): bed
- 沙发 (shāfā): sofa
- 书桌 (shūzhuō): desk
- 书架 (shūjià): bookshelf
- 冰箱 (bīngxiāng): fridge
- 电视 (diànshì): television
- 灯 (dēng): lamp
- 窗户 (chuānghu): window
- 门 (mén): door

## Saying what your home has: 有
Use 有 (yǒu) for "there is / has". The negative is 没有 (méiyǒu), never 不有. 我家有三个卧室 (wǒ jiā yǒu sān ge wòshì) means "My home has three bedrooms". 厨房里没有桌子 (chúfáng lǐ méiyǒu zhuōzi) means "There is no table in the kitchen". Numbers go before a measure word: 个 (ge) is the general one, and 间 (jiān) is often used for rooms. Beds and desks use 张 (zhāng), and chairs use 把 (bǎ). Note that two is 两 (liǎng) before a measure word, so say 两个卧室, not 二个卧室.

## Saying where things are: 在
Use 在 (zài) to say where something is, with the pattern thing + 在 + place. 书在桌子上 (shū zài zhuōzi shàng) means "The book is on the table". Useful position words:
- 上 / 上面 (shàng / shàngmiàn): on, above
- 下 / 下面 (xià / xiàmiàn): under
- 里 / 里面 (lǐ / lǐmiàn): inside
- 旁边 (pángbiān): beside
- 前面 (qiánmian): in front of
- 后面 (hòumiàn): behind

Examples: 猫在床下面 (māo zài chuáng xiàmiàn), "The cat is under the bed". 沙发在客厅里 (shāfā zài kètīng lǐ), "The sofa is in the living room". 书桌在窗户旁边 (shūzhuō zài chuānghu pángbiān), "The desk is beside the window".

## Describing size
Put 很 (hěn, very) before an adjective and do not use 是: 我的房间很小 (wǒ de fángjiān hěn xiǎo), "My room is small". Big is 大 (dà), small is 小 (xiǎo). 

## Two patterns, two meanings
- Place + 有 + thing introduces what is in a place: 客厅里有沙发 (there is a sofa in the living room).
- Thing + 在 + place says where a known thing is: 沙发在客厅里 (the sofa is in the living room).

## Common mistakes
- Using 是 instead of 有 for "has".
- Saying 不有 instead of 没有.
- Using 二 instead of 两 before a measure word.
- Putting the place before the thing when using 在.
- Forgetting the neutral tone in 桌子 (zhuōzi) and 椅子 (yǐzi).

## How this is examined
Rooms and furniture appear in short descriptions of a house, estate agent style adverts, a message to a host family or a floor plan described in words. You may be asked what is in a given room, where an object is, or how many rooms there are. In writing you can describe your own home in four or five sentences: how many rooms, what is in your room and where things are.

Exam tip: Read the position word slowly (上, 下, 里, 旁边) because the whole answer often depends on it. Underline the room name, then find the object that is linked to it, and always check whether the text uses 有 or 在 before choosing.$mq$ from st;

-- Home and Daily Life > Daily Routines
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Home and Daily Life$mq$, 5, 3 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Daily Routines$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Home and Daily Life$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Daily Routines$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 起床 (qǐchuáng) mean?$mq$, $mq$["Get up","Go to bed","Brush your teeth","Have breakfast"]$mq$, 0, $mq$起床 means to get up. Going to bed is 睡觉 (shuìjiào).$mq$, $mq$easy$mq$),
($mq$What does 睡觉 (shuìjiào) mean?$mq$, $mq$["Wake up","Do homework","Take a shower","Sleep / go to bed"]$mq$, 3, $mq$睡觉 means to sleep. Showering is 洗澡 (xǐzǎo).$mq$, $mq$easy$mq$),
($mq$What does 吃早饭 (chī zǎofàn) mean?$mq$, $mq$["Eat lunch","Eat dinner","Eat breakfast","Cook"]$mq$, 2, $mq$吃 is eat and 早饭 is breakfast. Lunch is 午饭 (wǔfàn) and dinner is 晚饭 (wǎnfàn).$mq$, $mq$easy$mq$),
($mq$What does 做作业 (zuò zuòyè) mean?$mq$, $mq$["Watch TV","Do homework","Go to school","Play football"]$mq$, 1, $mq$做 means do and 作业 means homework.$mq$, $mq$easy$mq$),
($mq$What does 每天 (měitiān) mean?$mq$, $mq$["Every day","Tomorrow","Today","Every week"]$mq$, 0, $mq$每 means every and 天 means day. Tomorrow is 明天 (míngtiān).$mq$, $mq$easy$mq$),
($mq$What does 我七点起床 (wǒ qī diǎn qǐchuáng) mean?$mq$, $mq$["I go to bed at seven o'clock","I have breakfast at seven o'clock","I sleep for seven hours","I get up at seven o'clock"]$mq$, 3, $mq$七点 is seven o'clock and 起床 is get up.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'I go to school at eight o'clock'?$mq$, $mq$["我上学八点 (wǒ shàngxué bā diǎn)","八点上学我 (bā diǎn shàngxué wǒ)","我八点上学 (wǒ bā diǎn shàngxué)","上学我八点 (shàngxué wǒ bā diǎn)"]$mq$, 2, $mq$In Mandarin the time word goes before the verb: subject + time + verb.$mq$, $mq$medium$mq$),
($mq$What does 放学 (fàngxué) mean?$mq$, $mq$["School starts","School finishes","Go home","Do homework"]$mq$, 1, $mq$放学 means school is over for the day. Going home is 回家 (huí jiā), which usually comes after it.$mq$, $mq$medium$mq$),
($mq$Read: 我每天早上六点半起床，然后刷牙，吃早饭。(Wǒ měitiān zǎoshang liù diǎn bàn qǐchuáng, ránhòu shuāyá, chī zǎofàn.) [刷牙 = brush teeth, 半 = half]

What does the writer do straight after getting up?$mq$, $mq$["Brushes their teeth","Eats breakfast","Goes to school","Takes a shower"]$mq$, 0, $mq$然后 means 'then'. After 起床 comes 刷牙, and breakfast comes after that.$mq$, $mq$medium$mq$),
($mq$What does 然后 (ránhòu) mean?$mq$, $mq$["First","Never","Often","Then, afterwards"]$mq$, 3, $mq$然后 links two actions in order. 先 (xiān) means first.$mq$, $mq$medium$mq$),
($mq$How do you say 'I often watch TV in the evening'?$mq$, $mq$["我常常看电视晚上 (wǒ chángcháng kàn diànshì wǎnshang)","我看晚上电视常常 (wǒ kàn wǎnshang diànshì chángcháng)","我晚上常常看电视 (wǒ wǎnshang chángcháng kàn diànshì)","晚上看电视我常常 (wǎnshang kàn diànshì wǒ chángcháng)"]$mq$, 2, $mq$Time word and frequency word come before the verb: 我 + 晚上 + 常常 + 看电视.$mq$, $mq$medium$mq$),
($mq$Choose the word that completes the sentence: 我在学校___午饭。(wǒ zài xuéxiào ___ wǔfàn.) 'I eat lunch at school.'$mq$, $mq$["睡 (shuì)","吃 (chī)","看 (kàn)","洗 (xǐ)"]$mq$, 1, $mq$吃午饭 means to eat lunch. 睡 is sleep, 看 is look/watch and 洗 is wash.$mq$, $mq$medium$mq$),
($mq$How do you say 'I do not eat breakfast'?$mq$, $mq$["我不吃早饭 (wǒ bù chī zǎofàn)","我吃不早饭 (wǒ chī bù zǎofàn)","我是不吃早饭 (wǒ shì bù chī zǎofàn)","我不是吃早饭 (wǒ bú shì chī zǎofàn)"]$mq$, 0, $mq$Put 不 directly before the verb. 不是 means 'is not', so it cannot be used here.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 玲玲: 我每天七点吃早饭，七点半上学。下午四点放学，然后回家做作业。晚上十点睡觉。(Línglíng: Wǒ měitiān qī diǎn chī zǎofàn, qī diǎn bàn shàngxué. Xiàwǔ sì diǎn fàngxué, ránhòu huí jiā zuò zuòyè. Wǎnshang shí diǎn shuìjiào.)

What does Lingling do after school finishes?$mq$, $mq$["Eats breakfast","Goes to bed","Goes to school","Goes home and does homework"]$mq$, 3, $mq$After 放学 at four o'clock she goes home (回家) and does homework (做作业). She sleeps at ten in the evening.$mq$, $mq$hard$mq$),
($mq$Read: 周末我不上学。我十点起床，然后看电视。下午我和朋友玩。(Zhōumò wǒ bú shàngxué. Wǒ shí diǎn qǐchuáng, ránhòu kàn diànshì. Xiàwǔ wǒ hé péngyou wán.) [周末 = weekend, 玩 = play, spend time]

Which statement is true?$mq$, $mq$["At the weekend the writer goes to school at ten","The writer watches TV in the afternoon and has no friends","At the weekend the writer gets up at ten and spends the afternoon with friends","The writer gets up at four in the afternoon"]$mq$, 2, $mq$The text says no school, up at 10:00, TV, then the afternoon with friends.$mq$, $mq$hard$mq$),
($mq$Which sentence says 'First I do homework, then I watch TV'?$mq$, $mq$["我先看电视，然后做作业 (wǒ xiān kàn diànshì, ránhòu zuò zuòyè)","我先做作业，然后看电视 (wǒ xiān zuò zuòyè, ránhòu kàn diànshì)","我然后做作业，先看电视 (wǒ ránhòu zuò zuòyè, xiān kàn diànshì)","我做作业先，看电视然后 (wǒ zuò zuòyè xiān, kàn diànshì ránhòu)"]$mq$, 1, $mq$先 (first) goes before the first action and 然后 (then) before the second. The first distractor reverses the order.$mq$, $mq$hard$mq$),
($mq$A student writes 我吃早饭在家 (wǒ chī zǎofàn zài jiā) for 'I eat breakfast at home'. What is the mistake?$mq$, $mq$["The place phrase should go before the verb: 我在家吃早饭","吃 should be 睡","早饭 should be 晚饭","There is no mistake"]$mq$, 0, $mq$Place phrases with 在 go before the verb: subject + 在 + place + verb.$mq$, $mq$hard$mq$),
($mq$Which is the correct pinyin with tone marks for 我不上学 (I do not go to school)?$mq$, $mq$["wǒ bù shàngxué","wǒ bǔ shàngxué","wǒ bú shǎngxué","wǒ bú shàngxué"]$mq$, 3, $mq$不 changes to bú before a fourth-tone syllable, and 上 (shàng) is fourth tone.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Daily Routines$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$起床 / 睡觉$mq$, $mq$起床 (qǐchuáng) = get up; 睡觉 (shuìjiào) = go to bed, sleep.$mq$),
($mq$吃早饭 / 午饭 / 晚饭$mq$, $mq$吃 (chī) = eat. 早饭 (zǎofàn) breakfast; 午饭 (wǔfàn) lunch; 晚饭 (wǎnfàn) dinner.$mq$),
($mq$上学 / 放学 / 回家$mq$, $mq$上学 (shàngxué) = go to school; 放学 (fàngxué) = school finishes; 回家 (huí jiā) = go home.$mq$),
($mq$做作业 (zuò zuòyè)$mq$, $mq$Do homework. 作业 (zuòyè) means homework.$mq$),
($mq$每天 / 常常$mq$, $mq$每天 (měitiān) = every day; 常常 (chángcháng) = often. Both go before the verb.$mq$),
($mq$我七点起床$mq$, $mq$Wǒ qī diǎn qǐchuáng = I get up at seven. The time word comes before the verb.$mq$),
($mq$先…然后…$mq$, $mq$先 (xiān) = first, 然后 (ránhòu) = then: 我先做作业，然后看电视 = first I do homework, then I watch TV.$mq$),
($mq$我在学校吃午饭$mq$, $mq$Wǒ zài xuéxiào chī wǔfàn = I eat lunch at school. 在 + place goes before the verb.$mq$),
($mq$我不吃早饭$mq$, $mq$Wǒ bù chī zǎofàn = I don't eat breakfast. 不 goes before the verb and becomes bú before a fourth tone.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Daily Routines$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Talking about your day
A daily routine is a very common topic in beginner reading and writing tasks. Your aim is to say what you do, at what time, and in which order. Mandarin sentences are short and follow one clear order, so once you know the pattern you can build many sentences.

## Key routine verbs
- 起床 (qǐchuáng): get up
- 刷牙 (shuāyá): brush teeth
- 洗澡 (xǐzǎo): have a shower or bath
- 吃早饭 (chī zǎofàn): eat breakfast
- 吃午饭 (chī wǔfàn): eat lunch
- 吃晚饭 (chī wǎnfàn): eat dinner
- 上学 (shàngxué): go to school
- 放学 (fàngxué): school finishes
- 回家 (huí jiā): go home
- 做作业 (zuò zuòyè): do homework
- 看电视 (kàn diànshì): watch TV
- 睡觉 (shuìjiào): go to sleep

## Time words
- 每天 (měitiān): every day
- 早上 (zǎoshang): morning
- 中午 (zhōngwǔ): noon
- 下午 (xiàwǔ): afternoon
- 晚上 (wǎnshang): evening
- 周末 (zhōumò): weekend
- 常常 (chángcháng): often
- 点 (diǎn): o'clock, so 七点 (qī diǎn) is seven o'clock, and 半 (bàn) means half, so 六点半 is half past six

## The golden rule: time before verb
In English we can say "I get up at seven" or "At seven I get up". In Mandarin the time word must come before the verb, either right after the subject or at the very start of the sentence.
- 我七点起床 (wǒ qī diǎn qǐchuáng): I get up at seven.
- 我每天早上七点起床 (wǒ měitiān zǎoshang qī diǎn qǐchuáng): I get up at seven every morning.
- 晚上我常常看电视 (wǎnshang wǒ chángcháng kàn diànshì): In the evening I often watch TV.
Never put the time at the end, so 我起床七点 is wrong.

## Place before verb too
A place with 在 (zài) also goes before the verb: 我在学校吃午饭 (wǒ zài xuéxiào chī wǔfàn), "I eat lunch at school". So the full order is subject + time + place + verb + object.

## Linking actions
Use 先 (xiān, first) and 然后 (ránhòu, then) to put actions in order: 我先做作业，然后看电视 (wǒ xiān zuò zuòyè, ránhòu kàn diànshì), "First I do homework, then I watch TV". 和 (hé) means "and" between nouns or people: 我和朋友玩 (wǒ hé péngyou wán), "I spend time with a friend".

## Negatives
Put 不 (bù) before the verb: 我不吃早饭 (wǒ bù chī zǎofàn), "I don't eat breakfast". Remember the tone change: 不 becomes bú before a fourth tone, as in 我不上学 (wǒ bú shàngxué).

## Worked example
Lingling's day: 我七点半上学 (I go to school at 7:30). 下午四点放学 (school finishes at 4 p.m.). 然后回家做作业 (then I go home and do homework). 晚上十点睡觉 (I go to bed at 10 p.m.).

## Common mistakes
- Putting the time or place after the verb.
- Using 是 before a verb, as in 我是吃早饭.
- Mixing up 早饭 (breakfast), 午饭 (lunch) and 晚饭 (dinner).
- Forgetting that 不 changes to bú before a fourth tone.

## How this is examined
Routines appear as short diary entries, emails to a penfriend and listening passages about a typical day. Questions ask for a time, the order of two events, or what someone does after school. In writing tasks you should give four or five routine sentences with times, using 先 and 然后 for extra credit.

Exam tip: In a listening or reading text about a day, write the times down in a list next to the activities. Then check each answer against the time word that comes before the verb, and watch for 然后 because it tells you what happens next.$mq$ from st;

-- Home and Daily Life > Telling the Time
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Home and Daily Life$mq$, 5, 3 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Telling the Time$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Home and Daily Life$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Telling the Time$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 现在几点？(xiànzài jǐ diǎn?) ask?$mq$, $mq$["What time is it now?","What day is it today?","How old are you?","Where are you now?"]$mq$, 0, $mq$现在 means now and 几点 means 'what o'clock'.$mq$, $mq$easy$mq$),
($mq$What time is 三点 (sān diǎn)?$mq$, $mq$["3 minutes","Half past three","3 hours","3 o'clock"]$mq$, 3, $mq$点 means o'clock, so 三点 is three o'clock.$mq$, $mq$easy$mq$),
($mq$What does 半 (bàn) mean in a time?$mq$, $mq$["Quarter","Minute","Half","O'clock"]$mq$, 2, $mq$半 means half. 七点半 is half past seven.$mq$, $mq$easy$mq$),
($mq$Which time is 两点 (liǎng diǎn)?$mq$, $mq$["12:00","2:00","4:00","10:00"]$mq$, 1, $mq$For 2 o'clock we use 两 (liǎng), not 二. 十二点 is 12 o'clock.$mq$, $mq$easy$mq$),
($mq$What does 下午 (xiàwǔ) mean?$mq$, $mq$["Afternoon","Morning","Evening","Night"]$mq$, 0, $mq$下午 is afternoon. Morning is 上午 (shàngwǔ).$mq$, $mq$easy$mq$),
($mq$Which time is 七点半 (qī diǎn bàn)?$mq$, $mq$["7:15","7:50","6:30","7:30"]$mq$, 3, $mq$半 means half, so 七点半 is half past seven.$mq$, $mq$medium$mq$),
($mq$Which time is 九点一刻 (jiǔ diǎn yí kè)?$mq$, $mq$["9:45","9:10","9:15","1:09"]$mq$, 2, $mq$刻 (kè) means a quarter of an hour. 一刻 is 15 minutes and 三刻 is 45 minutes.$mq$, $mq$medium$mq$),
($mq$Which time is 八点零五分 (bā diǎn líng wǔ fēn)?$mq$, $mq$["8:50","8:05","5:08","8:15"]$mq$, 1, $mq$分 (fēn) means minutes. 零 (líng) is used for single-digit minutes, so 零五分 is 05.$mq$, $mq$medium$mq$),
($mq$How do you say 'I get up at half past six'?$mq$, $mq$["我六点半起床 (wǒ liù diǎn bàn qǐchuáng)","我起床六点半 (wǒ qǐchuáng liù diǎn bàn)","我半六点起床 (wǒ bàn liù diǎn qǐchuáng)","我六半点起床 (wǒ liù bàn diǎn qǐchuáng)"]$mq$, 0, $mq$The time word comes before the verb, and half goes after 点: 六点半.$mq$, $mq$medium$mq$),
($mq$What does 上午九点 (shàngwǔ jiǔ diǎn) mean?$mq$, $mq$["9 p.m.","9:30 a.m.","12 noon","9 a.m."]$mq$, 3, $mq$上午 is the morning, so 上午九点 is nine in the morning.$mq$, $mq$medium$mq$),
($mq$Read: 八点上课，十二点吃午饭，三点半放学。(Bā diǎn shàngkè, shí'èr diǎn chī wǔfàn, sān diǎn bàn fàngxué.) [上课 = lessons begin]

When does school finish?$mq$, $mq$["3:00","12:00","3:30","8:30"]$mq$, 2, $mq$放学 means school finishes, and it is linked to 三点半, half past three.$mq$, $mq$medium$mq$),
($mq$What time is 差五分十点 (chà wǔ fēn shí diǎn)? [差 = short of, to]$mq$, $mq$["10:05","9:55","5:10","10:55"]$mq$, 1, $mq$差五分十点 means five minutes short of ten o'clock, which is 9:55.$mq$, $mq$medium$mq$),
($mq$Which question means 'What time do you get up?'$mq$, $mq$["你几点起床？(nǐ jǐ diǎn qǐchuáng?)","你起床几点吗？(nǐ qǐchuáng jǐ diǎn ma?)","你点几起床？(nǐ diǎn jǐ qǐchuáng?)","你几月起床？(nǐ jǐ yuè qǐchuáng?)"]$mq$, 0, $mq$几点 asks for the time and comes before the verb. 几月 asks for the month.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 老师: 现在是八点五十分。九点上课。(Lǎoshī: Xiànzài shì bā diǎn wǔshí fēn. Jiǔ diǎn shàngkè.)

How many minutes are left before the lesson starts?$mq$, $mq$["5","50","60","10"]$mq$, 3, $mq$8:50 to 9:00 is ten minutes.$mq$, $mq$hard$mq$),
($mq$Station notice: 火车八点二十分开。(Huǒchē bā diǎn èrshí fēn kāi.) [火车 = train, 开 = leaves] Ming checks his watch: 现在差一刻八点。(Xiànzài chà yí kè bā diǎn.)

How long must he wait?$mq$, $mq$["15 minutes","25 minutes","35 minutes","45 minutes"]$mq$, 2, $mq$差一刻八点 is a quarter to eight, 7:45. From 7:45 to 8:20 is 35 minutes.$mq$, $mq$hard$mq$),
($mq$Invitation: 周六下午两点半在我家。(Zhōuliù xiàwǔ liǎng diǎn bàn zài wǒ jiā.) [周六 = Saturday]

When is the party?$mq$, $mq$["Saturday at 2:30 a.m.","Saturday at 2:30 p.m.","Saturday at 3:30 p.m.","Sunday at 2:30 p.m."]$mq$, 1, $mq$周六 is Saturday, 下午 is afternoon, and 两点半 is half past two.$mq$, $mq$hard$mq$),
($mq$Which of these is NOT a correct way to say 3:45?$mq$, $mq$["三点一刻 (sān diǎn yí kè)","三点四十五分 (sān diǎn sìshíwǔ fēn)","三点三刻 (sān diǎn sān kè)","差一刻四点 (chà yí kè sì diǎn)"]$mq$, 0, $mq$三点一刻 is 3:15. 3:45 can be 三点四十五分, 三点三刻 or 差一刻四点.$mq$, $mq$hard$mq$),
($mq$Read: 小明七点一刻起床，七点三刻吃早饭，八点上学。(Xiǎomíng qī diǎn yí kè qǐchuáng, qī diǎn sān kè chī zǎofàn, bā diǎn shàngxué.)

How long is it between getting up and breakfast?$mq$, $mq$["15 minutes","45 minutes","60 minutes","30 minutes"]$mq$, 3, $mq$七点一刻 is 7:15 and 七点三刻 is 7:45. 7:45 − 7:15 = 30 minutes.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Telling the Time$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$点 / 分$mq$, $mq$点 (diǎn) = o'clock; 分 (fēn) = minute. 三点十分 (sān diǎn shí fēn) = 3:10.$mq$),
($mq$现在几点？$mq$, $mq$Xiànzài jǐ diǎn? = What time is it now? Answer: 现在七点 (xiànzài qī diǎn), it is 7 o'clock.$mq$),
($mq$两点 (liǎng diǎn)$mq$, $mq$2 o'clock. Use 两, not 二, before 点 and measure words.$mq$),
($mq$半 (bàn)$mq$, $mq$Half: 七点半 (qī diǎn bàn) = 7:30.$mq$),
($mq$一刻 / 三刻$mq$, $mq$一刻 (yí kè) = quarter hour, 15 minutes: 九点一刻 = 9:15. 三刻 (sān kè) = 45 minutes: 九点三刻 = 9:45.$mq$),
($mq$零 (líng) in times$mq$, $mq$Used for minutes under ten: 八点零五分 (bā diǎn líng wǔ fēn) = 8:05.$mq$),
($mq$差 (chà)$mq$, $mq$Short of, to: 差五分十点 (chà wǔ fēn shí diǎn) = five to ten = 9:55.$mq$),
($mq$上午 / 下午 / 晚上$mq$, $mq$上午 (shàngwǔ) = morning; 下午 (xiàwǔ) = afternoon; 晚上 (wǎnshang) = evening.$mq$),
($mq$我七点半起床$mq$, $mq$Wǒ qī diǎn bàn qǐchuáng = I get up at 7:30. The time comes before the verb.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Telling the Time$mq$ and p.name = $mq$Home and Daily Life$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Saying the time
Telling the time in Mandarin follows the clock very closely, which makes it easy once you know the numbers from one to sixty. Time is tested in timetables, notices, messages and listening passages, so aim to read it without translating each part.

## Key words
- 点 (diǎn): o'clock
- 分 (fēn): minute
- 半 (bàn): half
- 刻 (kè): quarter of an hour
- 差 (chà): short of, to
- 现在 (xiànzài): now
- 几点 (jǐ diǎn): what time
- 上午 (shàngwǔ): morning
- 中午 (zhōngwǔ): noon
- 下午 (xiàwǔ): afternoon
- 晚上 (wǎnshang): evening

## Full hours
Use number + 点. 三点 (sān diǎn) is 3:00 and 十一点 (shíyī diǎn) is 11:00. For two o'clock use 两点 (liǎng diǎn), not 二点. Ask 现在几点？(xiànzài jǐ diǎn?), "What time is it now?". Answer 现在九点 (xiànzài jiǔ diǎn), "It is nine o'clock".

## Half and quarter hours
- 七点半 (qī diǎn bàn): 7:30
- 九点一刻 (jiǔ diǎn yí kè): 9:15
- 九点三刻 (jiǔ diǎn sān kè): 9:45
You can also use the minutes: 九点十五分 (jiǔ diǎn shíwǔ fēn) is 9:15 and 九点四十五分 (jiǔ diǎn sìshíwǔ fēn) is 9:45.

## Minutes
Say the hour, then the minutes, then 分. When the minutes are below ten, add 零 (líng): 八点零五分 (bā diǎn líng wǔ fēn) is 8:05. For other minutes just say the number: 八点二十分 (bā diǎn èrshí fēn) is 8:20.

## Minutes to the hour
差 (chà) means "short of" and works like "to" in English: 差五分十点 (chà wǔ fēn shí diǎn) is five to ten, 9:55. 差一刻八点 (chà yí kè bā diǎn) is a quarter to eight, 7:45.

## Morning, afternoon, evening
Put the part of the day before the time: 上午九点 (shàngwǔ jiǔ diǎn) is 9 a.m., 下午三点 (xiàwǔ sān diǎn) is 3 p.m. and 晚上八点 (wǎnshang bā diǎn) is 8 p.m.

## Time in a sentence
Time goes before the verb, so say 我七点半起床 (wǒ qī diǎn bàn qǐchuáng), "I get up at 7:30". Ask 你几点起床？(nǐ jǐ diǎn qǐchuáng?), "What time do you get up?". Never put the time at the end of the sentence.

## Worked example
A notice says 火车八点二十分开 (the train leaves at 8:20) and your watch says 差一刻八点 (7:45). To find how long you wait, work in minutes: from 7:45 to 8:00 is 15 minutes and from 8:00 to 8:20 is 20 minutes, so you wait 15 + 20 = 35 minutes.

## Common mistakes
- Saying 二点 instead of 两点.
- Reading 一刻 as 1 minute instead of 15 minutes.
- Forgetting 零 in times such as 8:05.
- Reading 差 as an addition, when it takes time away.
- Putting the time at the end of the sentence.

## How this is examined
Time appears in timetables, train and cinema notices, invitations and short dialogues. Typical questions ask when something starts, how long you wait, or what time a person does something. Writing tasks often ask for a short plan with times.

Exam tip: Turn every Chinese time into digits as you read, like 7:45, and then do the sums with digits. In listening, 刻 and 差 are the key words that make a time earlier or later than it first sounds, so listen for them.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('mandarin-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;