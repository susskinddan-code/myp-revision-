-- Part 6 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Town and Travel > Places in Town
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Town and Travel$mq$, 5, 6 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Places in Town$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Town and Travel$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Places in Town$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 银行 (yínháng) mean?$mq$, $mq$["Bank","Post office","Market","School"]$mq$, 0, $mq$银行 (yínháng) is a bank. The post office is 邮局 (yóujú) and a school is 学校 (xuéxiào).$mq$, $mq$easy$mq$),
($mq$What does 医院 (yīyuàn) mean?$mq$, $mq$["Hotel","Library","Cinema","Hospital"]$mq$, 3, $mq$医院 (yīyuàn) is a hospital. A hotel is 酒店 (jiǔdiàn).$mq$, $mq$easy$mq$),
($mq$What does 我去公园 (wǒ qù gōngyuán) mean?$mq$, $mq$["I am at the park","I have a park","I am going to the park","I do not like parks"]$mq$, 2, $mq$去 (qù) means go or go to. 在 (zài) would mean 'be at'.$mq$, $mq$easy$mq$),
($mq$Where would you go to borrow books?$mq$, $mq$["邮局 (yóujú)","图书馆 (túshūguǎn)","超市 (chāoshì)","银行 (yínháng)"]$mq$, 1, $mq$图书馆 (túshūguǎn) is a library. A post office handles letters, a supermarket sells food and a bank handles money.$mq$, $mq$easy$mq$),
($mq$What does 电影院 (diànyǐngyuàn) mean?$mq$, $mq$["Cinema","Museum","Restaurant","Station"]$mq$, 0, $mq$电影 (diànyǐng) is a film and 院 means a public building, so 电影院 is a cinema.$mq$, $mq$easy$mq$),
($mq$What does 超市在学校旁边 (Chāoshì zài xuéxiào pángbiān.) mean?$mq$, $mq$["The supermarket is a school","The school is far from the supermarket","The supermarket is opposite the school","The supermarket is next to the school"]$mq$, 3, $mq$在 (zài) says where something is and 旁边 (pángbiān) means next to. Opposite would be 对面 (duìmiàn).$mq$, $mq$medium$mq$),
($mq$What does 这里附近有银行吗？(Zhèlǐ fùjìn yǒu yínháng ma?) ask?$mq$, $mq$["Where is the bank?","Is the bank open?","Is there a bank near here?","How do I get to the bank?"]$mq$, 2, $mq$附近 (fùjìn) means nearby, 有…吗 asks 'is there…?' It does not ask for directions.$mq$, $mq$medium$mq$),
($mq$Which sentence says 'There is a park in my city'?$mq$, $mq$["我的城市在一个公园。(Wǒ de chéngshì zài yí ge gōngyuán.)","我的城市有一个公园。(Wǒ de chéngshì yǒu yí ge gōngyuán.)","我的城市是一个公园。(Wǒ de chéngshì shì yí ge gōngyuán.)","我的城市没有公园。(Wǒ de chéngshì méiyǒu gōngyuán.)"]$mq$, 1, $mq$有 (yǒu) says something exists. 在 would put the whole city inside a park, 是 would say the city IS a park, and 没有 means there is no park.$mq$, $mq$medium$mq$),
($mq$Read: 我家附近有一个超市、一家银行和一个小公园，但是没有电影院。(Wǒ jiā fùjìn yǒu yí ge chāoshì, yì jiā yínháng hé yí ge xiǎo gōngyuán, dànshì méiyǒu diànyǐngyuàn.) What is NOT near the writer's home?$mq$, $mq$["A cinema","A supermarket","A bank","A park"]$mq$, 0, $mq$The word 但是 (dànshì, but) introduces 没有电影院 (there is no cinema). Shops and banks use 家 (jiā) as a measure word.$mq$, $mq$medium$mq$),
($mq$Which place would you visit to buy fruit and vegetables?$mq$, $mq$["医院 (yīyuàn)","邮局 (yóujú)","图书馆 (túshūguǎn)","超市 (chāoshì)"]$mq$, 3, $mq$A 超市 (chāoshì, supermarket) sells food. A hospital treats patients, a post office sends mail and a library lends books.$mq$, $mq$medium$mq$),
($mq$A sign reads: 图书馆九点开门，五点关门。(Túshūguǎn jiǔ diǎn kāi mén, wǔ diǎn guān mén.) When does the library close?$mq$, $mq$["9 o'clock","6 o'clock","5 o'clock","3 o'clock"]$mq$, 2, $mq$开门 (kāi mén) is 'open the door' so opens, and 关门 (guān mén) is closes. 五点 (wǔ diǎn) is five o'clock.$mq$, $mq$medium$mq$),
($mq$Which sentence means 'I am at the bank (now)'?$mq$, $mq$["我去银行。(Wǒ qù yínháng.)","我在银行。(Wǒ zài yínháng.)","我有银行。(Wǒ yǒu yínháng.)","我是银行。(Wǒ shì yínháng.)"]$mq$, 1, $mq$在 (zài) means be at. 去 means go to, 有 means have and 是 means am (a bank), which makes no sense here.$mq$, $mq$medium$mq$),
($mq$Listening transcript: A: 你周末去哪儿？(Nǐ zhōumò qù nǎr?) B: 我去图书馆，下午去电影院。(Wǒ qù túshūguǎn, xiàwǔ qù diànyǐngyuàn.) Where does B go in the afternoon?$mq$, $mq$["The cinema","The library","The park","Home"]$mq$, 0, $mq$下午 (xiàwǔ) means afternoon, so the cinema is the afternoon plan. The library comes first.$mq$, $mq$medium$mq$),
($mq$Read: 学校的左边是医院，右边是公园。银行在医院旁边。(Xuéxiào de zuǒbian shì yīyuàn, yòubian shì gōngyuán. Yínháng zài yīyuàn pángbiān.) Which two places are next to the hospital?$mq$, $mq$["The park and the bank","The park and the school","Only the school","The school and the bank"]$mq$, 3, $mq$The hospital is left of the school, so the school is next to it. The text also says the bank is beside the hospital. The park is on the other side of the school.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'The post office is near the school'?$mq$, $mq$["邮局有学校附近。(Yóujú yǒu xuéxiào fùjìn.)","邮局去学校附近。(Yóujú qù xuéxiào fùjìn.)","邮局在学校附近。(Yóujú zài xuéxiào fùjìn.)","学校附近邮局在。(Xuéxiào fùjìn yóujú zài.)"]$mq$, 2, $mq$To say where something is, use thing + 在 + place. 有 and 去 do not fit, and the last option breaks the word order.$mq$, $mq$hard$mq$),
($mq$Read: 我喜欢我的城市，因为有很多公园，但是没有大商店，所以我想去大城市买衣服。(Wǒ xǐhuan wǒ de chéngshì, yīnwèi yǒu hěn duō gōngyuán, dànshì méiyǒu dà shāngdiàn, suǒyǐ wǒ xiǎng qù dà chéngshì mǎi yīfu.) Why does the writer want to visit a big city?$mq$, $mq$["To visit parks, because her city has none","To buy clothes, because her city has no big shops","To see a film, because there is no cinema","To find a job"]$mq$, 1, $mq$The city has many parks but no big shops (没有大商店). 所以 (suǒyǐ, so) leads to the wish to go to a big city to buy clothes.$mq$, $mq$hard$mq$),
($mq$Read: 红红每天先去学校，然后去图书馆，最后回家。(Hónghong měi tiān xiān qù xuéxiào, ránhòu qù túshūguǎn, zuìhòu huí jiā.) What does she do last?$mq$, $mq$["She goes home","She goes to school","She goes to the library","She goes to the park"]$mq$, 0, $mq$先 (xiān) is first, 然后 (ránhòu) is then and 最后 (zuìhòu) is finally. 回家 (huí jiā) means go home.$mq$, $mq$hard$mq$),
($mq$Read: 小李说：我不去超市，我去市场买水果。(Xiǎo Lǐ shuō: Wǒ bú qù chāoshì, wǒ qù shìchǎng mǎi shuǐguǒ.) Where does Xiao Li go and why?$mq$, $mq$["To the supermarket, to buy fruit","To the market, to sell fruit","To the supermarket, to buy bread","To the market, to buy fruit"]$mq$, 3, $mq$Xiao Li says he does NOT go to the supermarket (不去超市). 市场 (shìchǎng) is a market and 买水果 (mǎi shuǐguǒ) is buy fruit.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Places in Town$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$银行 / 邮局 / 医院$mq$, $mq$yínháng bank / yóujú post office / yīyuàn hospital.$mq$),
($mq$图书馆$mq$, $mq$túshūguǎn: library. 图书 = books, 馆 = a public building.$mq$),
($mq$有 vs 在 vs 去$mq$, $mq$yǒu = there is / have; zài = is at (location); qù = go to. 公园有… / 我在公园 / 我去公园.$mq$),
($mq$我家附近有超市。$mq$, $mq$Wǒ jiā fùjìn yǒu chāoshì. There is a supermarket near my home. 附近 (fùjìn) = nearby.$mq$),
($mq$没有电影院$mq$, $mq$méiyǒu diànyǐngyuàn: there is no cinema. 没有 is the negative of 有 (never 不有).$mq$),
($mq$一家银行 vs 一个公园$mq$, $mq$yì jiā yínháng / yí ge gōngyuán. 家 (jiā) for businesses; 个 (gè) for most other places.$mq$),
($mq$开门 / 关门$mq$, $mq$kāi mén opens / guān mén closes. 图书馆九点开门 = the library opens at nine.$mq$),
($mq$先…，然后…，最后…$mq$, $mq$xiān…, ránhòu…, zuìhòu…: first…, then…, finally… Used to order events.$mq$),
($mq$但是$mq$, $mq$dànshì: but. The information after it often contains the key contrast.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Places in Town$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Talking about your town
This sub-topic gives you the building and place names you need to describe where you live. Exam texts include town leaflets, short messages ("I am at the library"), signs, and invitations such as "Let us meet at the park". The same place words reappear in the next sub-topic on directions, so learn them well.

## Place vocabulary
- 城市 (chéngshì, city)
- 商店 (shāngdiàn, shop)
- 超市 (chāoshì, supermarket)
- 市场 (shìchǎng, market)
- 银行 (yínháng, bank)
- 邮局 (yóujú, post office)
- 医院 (yīyuàn, hospital)
- 学校 (xuéxiào, school)
- 图书馆 (túshūguǎn, library)
- 公园 (gōngyuán, park)
- 电影院 (diànyǐngyuàn, cinema)
- 博物馆 (bówùguǎn, museum)
- 饭馆 (fànguǎn, restaurant)
- 火车站 (huǒchēzhàn, train station)
- 酒店 (jiǔdiàn, hotel)

Useful extras: 附近 (fùjìn, nearby), 开门 (kāi mén, to open), 关门 (guān mén, to close), 很多 (hěn duō, many).

## Three small words: 有, 在, 去
These three verbs do different jobs.
- 有 (yǒu) says that something exists: 我的城市有一个公园。(There is a park in my city.) The negative is 没有 (méiyǒu): 我家附近没有电影院。(There is no cinema near my home.)
- 在 (zài) says where something is: 银行在学校旁边。(The bank is next to the school.) The pattern is thing + 在 + place.
- 去 (qù) says where someone is going: 我去图书馆。(I am going to the library.)
Compare 我在银行 (I am at the bank) with 我去银行 (I am going to the bank). English uses different prepositions (at / to), while Chinese uses different verbs.

## Measure words for places
Use 个 (gè) for most places: 一个公园 (yí ge gōngyuán), 一个超市 (yí ge chāoshì). Use 家 (jiā) for businesses such as banks, restaurants and shops: 一家银行 (yì jiā yínháng), 一家饭馆 (yì jiā fànguǎn).

## Joining ideas
Longer texts use linking words.
- 但是 (dànshì, but): 有公园，但是没有电影院。
- 因为 (yīnwèi, because) and 所以 (suǒyǐ, so): 因为我喜欢书，所以我常去图书馆。
- 先 (xiān, first), 然后 (ránhòu, then), 最后 (zuìhòu, finally): 我先去学校，然后去图书馆，最后回家。
These help you follow the order of events and the reasons in a reading text.

## How this is examined
A typical reading item is a short description of a town: "My town has a park, a library and two supermarkets, but no cinema." Questions then ask which place exists and which does not, which place is next to another, or what the writer likes and why. In listening transcripts, speakers often mention two places and the question asks about the second. Writing tasks ask you to describe your own town in three or four sentences, so practise 我的城市有…，但是没有…。

## Common mistakes
- Using 在 when you mean 去, or the reverse.
- Missing 没有 and choosing a place the writer does NOT have.
- Using 个 for every business instead of 家 (this is usually forgiven but 家 shows control).
- Confusing 超市 (supermarket) with 市场 (market); they sell similar things but are different places.

Exam tip: Circle the contrast word 但是 (but). The part after it usually carries the answer to "what is missing?" or "what is the problem?" questions.$mq$ from st;

-- Town and Travel > Asking for and Giving Directions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Town and Travel$mq$, 5, 6 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Asking for and Giving Directions$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Town and Travel$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Asking for and Giving Directions$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 左 (zuǒ) mean?$mq$, $mq$["Left","Right","Straight","Behind"]$mq$, 0, $mq$左 (zuǒ) is left; right is 右 (yòu).$mq$, $mq$easy$mq$),
($mq$What does 直走 (zhí zǒu) mean?$mq$, $mq$["Turn left","Turn right","Stop","Go straight"]$mq$, 3, $mq$直 (zhí) means straight and 走 (zǒu) means walk or go.$mq$, $mq$easy$mq$),
($mq$What does 请问，银行在哪儿？(Qǐngwèn, yínháng zài nǎr?) ask?$mq$, $mq$["Excuse me, what time is it?","Excuse me, how much is this?","Excuse me, where is the bank?","Excuse me, who are you?"]$mq$, 2, $mq$请问 (qǐngwèn) is 'excuse me, may I ask' and 哪儿 (nǎr) means where.$mq$, $mq$easy$mq$),
($mq$What does 远 (yuǎn) mean?$mq$, $mq$["Near","Far","Big","Fast"]$mq$, 1, $mq$远 (yuǎn) is far; its opposite is 近 (jìn, near).$mq$, $mq$easy$mq$),
($mq$What does 对面 (duìmiàn) mean?$mq$, $mq$["Opposite","Behind","Next to","Between"]$mq$, 0, $mq$对面 (duìmiàn) is 'across from'. 后面 (hòumiàn) is behind and 旁边 (pángbiān) is next to.$mq$, $mq$easy$mq$),
($mq$What does 请问，去火车站怎么走？(Qǐngwèn, qù huǒchēzhàn zěnme zǒu?) ask?$mq$, $mq$["Where does the train go?","What time does the train leave?","How much is a train ticket?","How do I get to the train station?"]$mq$, 3, $mq$怎么走 (zěnme zǒu) means 'how do I walk/get there'.$mq$, $mq$medium$mq$),
($mq$Directions: 一直走，在红绿灯右转。(Yìzhí zǒu, zài hónglǜdēng yòu zhuǎn.) What do you do at the traffic lights?$mq$, $mq$["Turn left","Go straight on","Turn right","Stop and wait"]$mq$, 2, $mq$红绿灯 (hónglǜdēng) are traffic lights and 右转 (yòu zhuǎn) is 'turn right'.$mq$, $mq$medium$mq$),
($mq$Read: 邮局在银行对面。(Yóujú zài yínháng duìmiàn.) Where is the post office?$mq$, $mq$["Next to the bank","Opposite the bank","Behind the bank","Inside the bank"]$mq$, 1, $mq$对面 (duìmiàn) means opposite or across the road.$mq$, $mq$medium$mq$),
($mq$Read: 图书馆离这儿很近，走路五分钟。(Túshūguǎn lí zhèr hěn jìn, zǒulù wǔ fēnzhōng.) How far is the library?$mq$, $mq$["Near, about five minutes on foot","Far, about five minutes by bus","Near, about fifteen minutes on foot","Far, about fifty minutes on foot"]$mq$, 0, $mq$离 (lí) means 'away from', 很近 is very near, 走路 is walk and 五分钟 is five minutes.$mq$, $mq$medium$mq$),
($mq$Which sentence means 'Turn left at the first junction'?$mq$, $mq$["在第一个路口右转。(Zài dì yī ge lùkǒu yòu zhuǎn.)","在第二个路口左转。(Zài dì èr ge lùkǒu zuǒ zhuǎn.)","在第一个路口直走。(Zài dì yī ge lùkǒu zhí zǒu.)","在第一个路口左转。(Zài dì yī ge lùkǒu zuǒ zhuǎn.)"]$mq$, 3, $mq$第一个 (dì yī ge) is 'the first', 路口 (lùkǒu) is a junction and 左转 is 'turn left'. Check direction AND number.$mq$, $mq$medium$mq$),
($mq$Someone asks 请问，公园在哪儿？(Qǐngwèn, gōngyuán zài nǎr?) Which reply gives a location?$mq$, $mq$["公园很大。(Gōngyuán hěn dà.)","我喜欢公园。(Wǒ xǐhuan gōngyuán.)","公园在超市后面。(Gōngyuán zài chāoshì hòumiàn.)","公园有三个。(Gōngyuán yǒu sān ge.)"]$mq$, 2, $mq$Only the last reply says where the park is: 'behind the supermarket'. The others describe size, opinion and number.$mq$, $mq$medium$mq$),
($mq$Which word is the opposite of 近 (jìn)?$mq$, $mq$["大 (dà)","远 (yuǎn)","小 (xiǎo)","多 (duō)"]$mq$, 1, $mq$近 (jìn) is near and 远 (yuǎn) is far. 大 big, 小 small and 多 many are not directions or distances.$mq$, $mq$medium$mq$),
($mq$Listening transcript: A: 请问，医院在哪儿？B: 往前走，第二个路口右转，医院就在左边。(Wǎng qián zǒu, dì èr ge lùkǒu yòu zhuǎn, yīyuàn jiù zài zuǒbian.) Where is the hospital after the turn?$mq$, $mq$["On the left","On the right","Straight ahead at the lights","Behind you"]$mq$, 0, $mq$After turning right at the second junction, B says the hospital is 在左边 (on the left).$mq$, $mq$medium$mq$),
($mq$Read: 先直走，在第二个路口左转，然后公园就在前面。(Xiān zhí zǒu, zài dì èr ge lùkǒu zuǒ zhuǎn, ránhòu gōngyuán jiù zài qiánmiàn.) What do you do?$mq$, $mq$["Turn left at the first junction, then the park is behind you","Turn right at the second junction, then the park is on the left","Go straight and the park is at the first junction","Pass one junction, turn left at the second, then the park is ahead"]$mq$, 3, $mq$The order is: go straight (先直走), left at the second junction, then the park is 前面 (in front).$mq$, $mq$hard$mq$),
($mq$A student writes 我左转在红绿灯。 What is wrong?$mq$, $mq$["左转 should be 右转","红绿灯 should be 红灯","The place phrase should come first: 我在红绿灯左转","我 should be removed"]$mq$, 2, $mq$In Chinese, place and time words go BEFORE the verb: 我在红绿灯左转 (wǒ zài hónglǜdēng zuǒ zhuǎn).$mq$, $mq$hard$mq$),
($mq$Read: 小云的家在学校对面，离超市很远，走路二十分钟。(Xiǎo Yún de jiā zài xuéxiào duìmiàn, lí chāoshì hěn yuǎn, zǒulù èrshí fēnzhōng.) Which statement is true?$mq$, $mq$["Her home is next to the supermarket","Her home is opposite the school and a 20-minute walk from the supermarket","Her home is far from the school","Her home is 12 minutes from the supermarket"]$mq$, 1, $mq$对面 means opposite the school. The supermarket is 很远 (very far), a 二十 (20) minute walk. 12 would be 十二.$mq$, $mq$hard$mq$),
($mq$Listening transcript: A: 请问，超市怎么走？B: 不远。一直走，过红绿灯，超市在右边。(Bù yuǎn. Yìzhí zǒu, guò hónglǜdēng, chāoshì zài yòubian.) What should A do at the lights?$mq$, $mq$["Go straight across them","Turn right","Turn left","Wait for a bus"]$mq$, 0, $mq$过 (guò) means pass or cross. B never says to turn; the supermarket appears on the right afterwards.$mq$, $mq$hard$mq$),
($mq$Read: 学校到图书馆走路十分钟，坐公共汽车五分钟。(Xuéxiào dào túshūguǎn zǒulù shí fēnzhōng, zuò gōnggòng qìchē wǔ fēnzhōng.) How many minutes does the bus save?$mq$, $mq$["10 minutes","15 minutes","2 minutes","5 minutes"]$mq$, 3, $mq$Walking takes 10 minutes and the bus takes 5, so 10 − 5 = 5. Adding the times (15) is a common slip.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Asking for and Giving Directions$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$请问，…在哪儿？$mq$, $mq$Qǐngwèn, … zài nǎr? Excuse me, where is…? 哪儿 (nǎr) = where.$mq$),
($mq$去…怎么走？$mq$, $mq$qù … zěnme zǒu? How do I get to…?$mq$),
($mq$左转 / 右转$mq$, $mq$zuǒ zhuǎn turn left / yòu zhuǎn turn right. Say 在路口左转 (at the junction turn left).$mq$),
($mq$直走 / 过$mq$, $mq$zhí zǒu go straight / guò pass, cross. 过红绿灯 = go through the traffic lights.$mq$),
($mq$第一个路口$mq$, $mq$dì yī ge lùkǒu: the first junction. 第二个 = the second.$mq$),
($mq$旁边 / 对面 / 中间$mq$, $mq$pángbiān next to / duìmiàn opposite / zhōngjiān between.$mq$),
($mq$前面 / 后面$mq$, $mq$qiánmiàn in front / hòumiàn behind. 公园在超市后面 = the park is behind the supermarket.$mq$),
($mq$近 / 远 / 离$mq$, $mq$jìn near / yuǎn far / lí away from. 学校离这儿很近 = the school is very near here.$mq$),
($mq$在红绿灯左转$mq$, $mq$zài hónglǜdēng zuǒ zhuǎn: turn left at the lights. Place phrase goes BEFORE the verb.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Asking for and Giving Directions$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why directions matter
Asking and giving directions is a classic beginner task. In an exam you may read a short conversation, follow a route on a described map, or write directions to your school. The language is formulaic, which is good news: once you know the pattern, you can handle almost any question.

## Asking the way
- 请问，…在哪儿？(Qǐngwèn, … zài nǎr? Excuse me, where is…?)
- 请问，去…怎么走？(Qǐngwèn, qù … zěnme zǒu? Excuse me, how do I get to…?)
- 远吗？(Yuǎn ma? Is it far?) Replies: 不远 (bù yuǎn, not far), 很近 (hěn jìn, very near).
哪儿 (nǎr) and 哪里 (nǎlǐ) both mean where.

## Direction and position words
Movement:
- 直走 / 一直走 (zhí zǒu / yìzhí zǒu, go straight)
- 往前走 (wǎng qián zǒu, walk forward)
- 左转 (zuǒ zhuǎn, turn left)
- 右转 (yòu zhuǎn, turn right)
- 过 (guò, pass or cross)

Landmarks:
- 红绿灯 (hónglǜdēng, traffic lights)
- 路口 (lùkǒu, junction)
- 第一个路口 (dì yī ge lùkǒu, the first junction)
- 第二个路口 (dì èr ge lùkǒu, the second junction)

Position:
- 左边 (zuǒbian, left side)
- 右边 (yòubian, right side)
- 前面 (qiánmiàn, in front)
- 后面 (hòumiàn, behind)
- 旁边 (pángbiān, next to)
- 对面 (duìmiàn, opposite)
- 中间 (zhōngjiān, between)

Distance: 近 (jìn, near), 远 (yuǎn, far), 离 (lí, away from), 走路五分钟 (zǒulù wǔ fēnzhōng, five minutes on foot).

## Word order for directions
The golden rule: place phrases come BEFORE the verb. Say 在红绿灯左转 (zài hónglǜdēng zuǒ zhuǎn, turn left at the lights), not 左转在红绿灯. A full set of directions might be:
一直走，在第二个路口右转，银行就在左边。(Yìzhí zǒu, zài dì èr ge lùkǒu yòu zhuǎn, yínháng jiù zài zuǒbian.) Go straight, turn right at the second junction, and the bank is on the left.
就 (jiù) here adds emphasis: "is right there".
To describe location, use thing + 在 + position: 邮局在银行对面 (the post office is opposite the bank). 离 expresses distance: 学校离这儿很近 (xuéxiào lí zhèr hěn jìn, the school is very near here).

## Following a route
Always track your direction in order: first instruction, second instruction, and what is on your left or right AFTER the turn. Draw a quick sketch on scrap paper if the exam allows. Remember that "turn left at the second junction" means you walk past the first one.

## How this is examined
Reading items give written directions and ask where you end up, or which place is described. Listening transcripts often contain a correction ("No, not left, right!") and you must pick the final instruction. Questions also test numbers (first, second) and distance (time on foot compared with time by bus). In writing you may be asked to give directions from your school to the station in three or four short sentences.

## Common mistakes
- Putting 在 + place after the verb.
- Mixing up 左 (zuǒ) and 右 (yòu), or 前面 and 后面.
- Counting the junction you are at as the first.
- Forgetting that 过 means pass, so no turn is needed.

Exam tip: When a transcript contains a correction, the LAST direction mentioned is nearly always the one the question wants. Underline each 左 and 右 as you read.$mq$ from st;

-- Town and Travel > Transport and Holidays
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Town and Travel$mq$, 5, 6 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Transport and Holidays$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Town and Travel$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Transport and Holidays$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 飞机 (fēijī) mean?$mq$, $mq$["Aeroplane","Train","Boat","Taxi"]$mq$, 0, $mq$飞机 (fēijī) is a plane. A train is 火车 (huǒchē) and a boat is 船 (chuán).$mq$, $mq$easy$mq$),
($mq$What does 地铁 (dìtiě) mean?$mq$, $mq$["Bus","Bicycle","Airport","Underground railway"]$mq$, 3, $mq$地铁 (dìtiě) is the underground or subway. A bus is 公共汽车 (gōnggòng qìchē).$mq$, $mq$easy$mq$),
($mq$Which verb do you use with 自行车 (zìxíngchē, bicycle)?$mq$, $mq$["坐 (zuò)","开 (kāi)","骑 (qí)","吃 (chī)"]$mq$, 2, $mq$骑 (qí) means ride (a bike or horse). 坐 is for buses, trains and planes.$mq$, $mq$easy$mq$),
($mq$What does 机场 (jīchǎng) mean?$mq$, $mq$["Station","Airport","Hotel","Harbour"]$mq$, 1, $mq$机场 (jīchǎng) is an airport. 机 comes from 飞机 (plane) and 场 means a field or place.$mq$, $mq$easy$mq$),
($mq$What does 我坐火车去上海 (wǒ zuò huǒchē qù Shànghǎi) mean?$mq$, $mq$["I take the train to Shanghai","I drive to Shanghai","I live in Shanghai","I fly from Shanghai"]$mq$, 0, $mq$坐 (zuò) means travel by, 火车 is train and 去 is go to.$mq$, $mq$easy$mq$),
($mq$Which sentence says 'I go to school by bus'?$mq$, $mq$["我骑公共汽车去学校。(Wǒ qí gōnggòng qìchē qù xuéxiào.)","我开公共汽车去学校。(Wǒ kāi gōnggòng qìchē qù xuéxiào.)","我走公共汽车去学校。(Wǒ zǒu gōnggòng qìchē qù xuéxiào.)","我坐公共汽车去学校。(Wǒ zuò gōnggòng qìchē qù xuéxiào.)"]$mq$, 3, $mq$For buses, trains and planes use 坐 (zuò). 骑 is for bikes, 开 means drive and 走 means walk.$mq$, $mq$medium$mq$),
($mq$Which sentence means 'I go to Beijing by plane'?$mq$, $mq$["我去飞机坐北京。(Wǒ qù fēijī zuò Běijīng.)","我北京坐飞机去。(Wǒ Běijīng zuò fēijī qù.)","我坐飞机去北京。(Wǒ zuò fēijī qù Běijīng.)","坐飞机我去北京。(Zuò fēijī wǒ qù Běijīng.)"]$mq$, 2, $mq$The pattern is subject + 坐 + vehicle + 去 + place. Other orders are not natural.$mq$, $mq$medium$mq$),
($mq$Read: 去北京坐飞机要三个小时，坐火车要九个小时。(Qù Běijīng zuò fēijī yào sān ge xiǎoshí, zuò huǒchē yào jiǔ ge xiǎoshí.) How much longer does the train take?$mq$, $mq$["3 hours","6 hours","9 hours","12 hours"]$mq$, 1, $mq$The plane takes 3 hours and the train takes 9, so the train is 9 − 3 = 6 hours longer.$mq$, $mq$medium$mq$),
($mq$Read: 我的假期打算去海边玩。(Wǒ de jiàqī dǎsuan qù hǎibiān wán.) What is the writer's plan?$mq$, $mq$["To go to the seaside for fun","To stay at home","To visit a museum","To work at the sea"]$mq$, 0, $mq$假期 (jiàqī) is holiday, 打算 (dǎsuan) is plan, 海边 (hǎibiān) is seaside and 玩 (wán) means play or have fun.$mq$, $mq$medium$mq$),
($mq$Read: 我家离学校很近，所以我走路去。(Wǒ jiā lí xuéxiào hěn jìn, suǒyǐ wǒ zǒulù qù.) Why does the writer walk?$mq$, $mq$["The bus is cheap","The weather is good","The school is far","The school is near home"]$mq$, 3, $mq$所以 (suǒyǐ) means 'so', so the reason comes before it: 离学校很近, very near the school.$mq$, $mq$medium$mq$),
($mq$Which would you buy at a station to take a trip by train?$mq$, $mq$["机票 (jīpiào)","菜单 (càidān)","火车票 (huǒchē piào)","地图 (dìtú)"]$mq$, 2, $mq$票 (piào) is a ticket. 火车票 is a train ticket, 机票 is a plane ticket, 菜单 is a menu and 地图 is a map.$mq$, $mq$medium$mq$),
($mq$Listening transcript: A: 你假期去哪儿？B: 我去上海。A: 怎么去？B: 坐火车，不坐飞机，因为飞机票太贵。(Zuò huǒchē, bú zuò fēijī, yīnwèi fēijī piào tài guì.) Why does B not fly?$mq$, $mq$["The plane is too slow","The plane ticket is too expensive","B is afraid of flying","B lives near the airport"]$mq$, 1, $mq$因为 (yīnwèi) gives the reason: 飞机票太贵, plane tickets are too expensive.$mq$, $mq$medium$mq$),
($mq$A student writes 我骑地铁去学校。 What is the mistake?$mq$, $mq$["The verb should be 坐: 我坐地铁去学校","去 should be 在","学校 should come first","地铁 should be 公共汽车"]$mq$, 0, $mq$You do not ride the underground like a bike. Use 坐 (zuò) for public transport.$mq$, $mq$medium$mq$),
($mq$Read: 今年我们一家人去中国旅行。我们先坐飞机去北京，然后坐火车去上海，最后坐飞机回家。(Jīnnián wǒmen yì jiā rén qù Zhōngguó lǚxíng. Wǒmen xiān zuò fēijī qù Běijīng, ránhòu zuò huǒchē qù Shànghǎi, zuìhòu zuò fēijī huí jiā.) How many journeys do they make by plane?$mq$, $mq$["1","3","0","2"]$mq$, 3, $mq$They fly to Beijing (先) and fly home (最后). The Beijing to Shanghai leg is by train.$mq$, $mq$hard$mq$),
($mq$Listening transcript: A: 去机场怎么走最快？B: 坐地铁要三十分钟，坐出租车要二十分钟，但是出租车很贵。A: 我没有很多钱，我坐地铁。(…Wǒ méiyǒu hěn duō qián, wǒ zuò dìtiě.) Why does A take the underground?$mq$, $mq$["It is faster than a taxi","There are no taxis","It is cheaper, although slower","The airport is next door"]$mq$, 2, $mq$A says 没有很多钱 (does not have much money). The taxi (20 minutes) is quicker but 很贵 (very expensive).$mq$, $mq$hard$mq$),
($mq$Read: 我们在海边的酒店，天气很好。明天我们坐船去小岛。(Wǒmen zài hǎibiān de jiǔdiàn, tiānqì hěn hǎo. Míngtiān wǒmen zuò chuán qù xiǎo dǎo.) Where are they staying and how will they reach the island tomorrow?$mq$, $mq$["In a mountain hotel; by plane","In a seaside hotel; by boat","In a seaside hotel; by train","At home; by boat"]$mq$, 1, $mq$在海边的酒店 is 'at the seaside hotel'. 坐船 (zuò chuán) means travel by boat and 明天 means tomorrow.$mq$, $mq$hard$mq$),
($mq$Train tickets cost 150元 each and plane tickets cost 400元 each. Two people travel. How much cheaper is the train for the two of them?$mq$, $mq$["500元","250元","550元","1100元"]$mq$, 0, $mq$Plane: 2 × 400 = 800. Train: 2 × 150 = 300. The difference is 800 − 300 = 500. 1100 is the cost of both trips added together.$mq$, $mq$hard$mq$),
($mq$Read: 我们打算去海边玩，但是天气不好，所以不去海边，去博物馆。(…dànshì tiānqì bù hǎo, suǒyǐ bú qù hǎibiān, qù bówùguǎn.) Where do they actually go?$mq$, $mq$["The seaside","The airport","Nowhere","The museum"]$mq$, 3, $mq$The weather is not good (天气不好), so the plan changes. 所以 introduces the result: they go to the 博物馆 (museum).$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Transport and Holidays$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$坐 vs 骑$mq$, $mq$zuò = take (bus, train, plane); qí = ride (bike). 坐地铁, 骑自行车.$mq$),
($mq$我坐公共汽车去学校。$mq$, $mq$Wǒ zuò gōnggòng qìchē qù xuéxiào. I go to school by bus. Vehicle comes BEFORE 去.$mq$),
($mq$飞机 / 火车 / 地铁$mq$, $mq$fēijī plane / huǒchē train / dìtiě underground.$mq$),
($mq$出租车$mq$, $mq$chūzūchē: taxi. Often described as quick but 贵 (guì, expensive).$mq$),
($mq$机场 / 车站$mq$, $mq$jīchǎng airport / chēzhàn station or stop.$mq$),
($mq$坐飞机要三个小时$mq$, $mq$zuò fēijī yào sān ge xiǎoshí: it takes three hours by plane. 要 (yào) = takes (time).$mq$),
($mq$假期 / 旅行$mq$, $mq$jiàqī holiday / lǚxíng to travel. 我的假期打算去旅行 = I plan to travel in my holiday.$mq$),
($mq$海边 / 酒店$mq$, $mq$hǎibiān seaside / jiǔdiàn hotel.$mq$),
($mq$因为…，所以…$mq$, $mq$yīnwèi…, suǒyǐ…: because…, so… 因为太贵，所以不坐飞机。$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Transport and Holidays$mq$ and p.name = $mq$Town and Travel$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Travel and holidays
Transport and holiday language links your daily life (how you get to school) with bigger plans (a trip to China). Texts include postcards, travel plans, short timetables with prices, and conversations about the best way to travel. This sub-topic builds on the place words and direction words you have already met.

## Transport vocabulary
- 公共汽车 (gōnggòng qìchē, bus)
- 地铁 (dìtiě, underground)
- 火车 (huǒchē, train)
- 飞机 (fēijī, aeroplane)
- 出租车 (chūzūchē, taxi)
- 自行车 (zìxíngchē, bicycle)
- 船 (chuán, boat)
- 机场 (jīchǎng, airport)
- 车站 (chēzhàn, station or stop)
- 票 (piào, ticket)

## Choosing the right verb
The verb depends on the type of transport.
- 坐 (zuò) for buses, trains, planes, boats and taxis: 我坐火车。
- 骑 (qí) for bicycles: 我骑自行车。
- 开车 (kāichē) to drive a car.
- 走路 (zǒulù) to walk.
Never say 骑地铁 or 坐自行车. This is a very common error.

## The pattern: how do you go?
你怎么去学校？(Nǐ zěnme qù xuéxiào? How do you go to school?)
我坐公共汽车去学校。(Wǒ zuò gōnggòng qìchē qù xuéxiào. I go to school by bus.)
The transport phrase comes BEFORE 去, so the order is subject + 坐/骑 + vehicle + 去 + place.
To give time taken use 要 (yào): 坐飞机要三个小时 (zuò fēijī yào sān ge xiǎoshí, it takes three hours by plane).

## Holidays
- 假期 (jiàqī, holiday)
- 旅行 (lǚxíng, to travel)
- 海边 (hǎibiān, seaside)
- 酒店 (jiǔdiàn, hotel)
- 玩 (wán, to play or have fun)
- 打算 (dǎsuan, to plan)
- 中国 (Zhōngguó, China)
- 北京 (Běijīng) and 上海 (Shànghǎi)
A holiday plan: 我打算去海边玩。(I plan to go to the seaside.) Add reasons with 因为 (because) and 所以 (so): 因为飞机票太贵，所以我坐火车。(Because plane tickets are too expensive, I take the train.)

## Comparing costs and times
Exam texts like numbers. If a plane takes 3 hours and a train takes 9, the difference is 6 hours. If a ticket costs 150元 and two people travel, the total is 300元. Always read whether the question asks for ONE person or all of them, and whether it asks for the total or the difference.

## How this is examined
Expect a short email or postcard such as "This year we travel to China. First we fly to Beijing, then we take the train to Shanghai." Questions ask how many times someone flies, what transport they use for each leg, why they choose one option, or how long a journey takes. Listening transcripts often include a decision: "The taxi is faster but expensive, so I take the underground." The reason after 因为 or the choice after 所以 is the answer. In writing, you may describe how you travel to school and a holiday plan in four to five sentences.

## Common mistakes
- Using 骑 or 开 with public transport.
- Putting the vehicle after 去 instead of before it.
- Forgetting the order words 先, 然后, 最后 and miscounting journeys.
- Giving a plan that was CANCELLED. Look for 但是 and 所以 near the end.

Exam tip: Number the stages of a journey in the margin (1, 2, 3) and write the vehicle beside each. Then counting planes or trains is quick and accurate.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('mandarin-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;