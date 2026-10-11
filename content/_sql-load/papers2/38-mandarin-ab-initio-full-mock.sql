-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Mandarin ab initio MYP 5 Full eAssessment Mock (100 marks)
with sub as (select id from public.subjects where slug = $mq$mandarin-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Mandarin ab initio MYP 5 Full eAssessment Mock$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Mandarin ab initio MYP 5 Full eAssessment Mock$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Listening transcript. A teacher makes an announcement at school.

各位同学，大家好！下个星期五是我们学校的运动会。运动会早上九点开始，下午三点结束。地点在学校的大操场。比赛有跑步、跳远和乒乓球。请同学们穿运动服和运动鞋。中午学校有免费的午饭：鸡肉饭和水果。如果下雨，运动会改到下个星期一。谢谢大家！
(Gèwèi tóngxué, dàjiā hǎo! Xià ge xīngqīwǔ shì wǒmen xuéxiào de yùndònghuì. Yùndònghuì zǎoshang jiǔ diǎn kāishǐ, xiàwǔ sān diǎn jiéshù. Dìdiǎn zài xuéxiào de dà cāochǎng. Bǐsài yǒu pǎobù, tiàoyuǎn hé pīngpāngqiú. Qǐng tóngxuémen chuān yùndòngfú hé yùndòngxié. Zhōngwǔ xuéxiào yǒu miǎnfèi de wǔfàn: jīròu fàn hé shuǐguǒ. Rúguǒ xiàyǔ, yùndònghuì gǎi dào xià ge xīngqīyī. Xièxie dàjiā!)

(a) On which day is the sports day? (1 mark)
(b) At what times does it start and finish? (2 marks)
(c) Where will it take place? (1 mark)
(d) Name the three events. (3 marks)
(e) What should students wear? (2 marks)
(f) What is the lunch, and how much does it cost? (2 marks)
(g) What happens if it rains? (1 mark)

(Total 12 marks)$mq$, $mq$(a) [1] Next Friday (Friday)
(b) [1] Starts at 9 am (nine o'clock in the morning)
[1] Finishes at 3 pm (three o'clock in the afternoon)
(c) [1] On the big sports field (school playing field)
(d) [1] Running
[1] Long jump
[1] Table tennis
(e) [1] Sports clothes (sportswear)
[1] Sports shoes
(f) [1] Chicken rice and fruit
[1] Free (no cost)
(g) [1] It is moved to next Monday$mq$, $mq$A$mq$),
(2, $mq$Listening transcript. Xiao Mei phones a restaurant.

服务员：你好，美味饭店。
小美：你好，我想订一张桌子。
服务员：好的。几个人？
小美：五个人。
服务员：什么时候？
小美：这个星期六晚上六点半。
服务员：对不起，六点半没有桌子。七点可以吗？
小美：可以。
服务员：请问你叫什么名字？
小美：我姓陈，叫陈小美。
服务员：好的。你的电话号码是多少？
小美：我的电话号码是一三八，五五六，二零九七。
服务员：谢谢。星期六见！
(Fúwùyuán: Nǐ hǎo, Měiwèi fàndiàn. Xiǎo Měi: Nǐ hǎo, wǒ xiǎng dìng yì zhāng zhuōzi. Fúwùyuán: Hǎo de. Jǐ ge rén? Xiǎo Měi: Wǔ ge rén. Fúwùyuán: Shénme shíhou? Xiǎo Měi: Zhège xīngqīliù wǎnshang liù diǎn bàn. Fúwùyuán: Duìbuqǐ, liù diǎn bàn méiyǒu zhuōzi. Qī diǎn kěyǐ ma? Xiǎo Měi: Kěyǐ. Fúwùyuán: Qǐngwèn nǐ jiào shénme míngzi? Xiǎo Měi: Wǒ xìng Chén, jiào Chén Xiǎoměi. Fúwùyuán: Hǎo de. Nǐ de diànhuà hàomǎ shì duōshao? Xiǎo Měi: Wǒ de diànhuà hàomǎ shì yī sān bā, wǔ wǔ liù, èr líng jiǔ qī. Fúwùyuán: Xièxie. Xīngqīliù jiàn!)

(a) For how many people does Xiao Mei want a table? (1 mark)
(b) Which day does she want to go? (1 mark)
(c) What time does she ask for first? (1 mark)
(d) Why can she not have that time? (1 mark)
(e) What time is the table finally booked for? (1 mark)
(f) What is Xiao Mei's family name (surname)? (1 mark)
(g) Write down her phone number as digits. (3 marks)
(h) What does 星期六见 (xīngqīliù jiàn) mean? (1 mark)
(i) Apart from the number of people and the time, name two things the waiter asks Xiao Mei for. (2 marks)

(Total 12 marks)$mq$, $mq$(a) [1] 5 (five)
(b) [1] Saturday
(c) [1] 6:30 pm (half past six in the evening)
(d) [1] There is no table at that time
(e) [1] 7 o'clock (7 pm)
(f) [1] Chén (陈)
(g) [1] 138
[1] 556
[1] 2097 (so the full number is 1385562097)
(h) [1] See you on Saturday
(i) [1] Her name
[1] Her phone number$mq$, $mq$A$mq$),
(3, $mq$Read this email.

亲爱的小林：
你好！我是马克，我住在上海。上海是一个很大的城市，有两千多万人。我家在市中心，旁边有一个公园和一家电影院。我家有五口人，还有一只小狗。它的名字叫“豆豆”。我的学校离家很近，走路十分钟。我最喜欢的科目是数学，因为数学老师很好。我不太喜欢历史，因为历史课很难。周末我常常和朋友去打篮球。你呢？请给我写信！
你的朋友
马克
(Qīn'ài de Xiǎo Lín: Nǐ hǎo! Wǒ shì Mǎkè, wǒ zhù zài Shànghǎi. Shànghǎi shì yí ge hěn dà de chéngshì, yǒu liǎng qiān duō wàn rén. Wǒ jiā zài shì zhōngxīn, pángbiān yǒu yí ge gōngyuán hé yì jiā diànyǐngyuàn. Wǒ jiā yǒu wǔ kǒu rén, hái yǒu yì zhī xiǎo gǒu. Tā de míngzi jiào “Dòudou”. Wǒ de xuéxiào lí jiā hěn jìn, zǒulù shí fēnzhōng. Wǒ zuì xǐhuan de kēmù shì shùxué, yīnwèi shùxué lǎoshī hěn hǎo. Wǒ bù tài xǐhuan lìshǐ, yīnwèi lìshǐ kè hěn nán. Zhōumò wǒ chángcháng hé péngyou qù dǎ lánqiú. Nǐ ne? Qǐng gěi wǒ xiě xìn! Nǐ de péngyou, Mǎkè)

(a) In which city does Mark live? (1 mark)
(b) Name two places near his home. (2 marks)
(c) How many people are in his family? (1 mark)
(d) What pet does he have, and what is its name? (2 marks)
(e) How long does he take to walk to school? (1 mark)
(f) What is his favourite subject, and why? (2 marks)
(g) Which subject does he not like very much, and why? (2 marks)
(h) What does he often do at the weekend? (1 mark)

(Total 12 marks)$mq$, $mq$(a) [1] Shanghai
(b) [1] A park
[1] A cinema
(c) [1] 5 (five)
(d) [1] A dog
[1] Doudou (豆豆)
(e) [1] 10 minutes
(f) [1] Maths
[1] The maths teacher is good
(g) [1] History
[1] The lessons are difficult
(h) [1] Plays basketball with friends$mq$, $mq$B$mq$),
(4, $mq$Read this travel poster.

北京三日游
第一天：上午参观故宫，下午去天安门广场。
第二天：全天爬长城，晚上吃北京烤鸭。
第三天：上午去颐和园，下午自由活动，晚上坐飞机回家。
价格：每人二千八百元（包括酒店和车）
十二岁以下的孩子：一千八百元
(Běijīng sān rì yóu. Dì yī tiān: shàngwǔ cānguān Gùgōng, xiàwǔ qù Tiān'ānmén Guǎngchǎng. Dì èr tiān: quán tiān pá Chángchéng, wǎnshang chī Běijīng kǎoyā. Dì sān tiān: shàngwǔ qù Yíhéyuán, xiàwǔ zìyóu huódòng, wǎnshang zuò fēijī huí jiā. Jiàgé: měi rén liǎng qiān bā bǎi yuán (bāokuò jiǔdiàn hé chē). Shí'èr suì yǐxià de háizi: yì qiān bā bǎi yuán.)

(a) How many days is the trip? (1 mark)
(b) Where do the visitors go on the morning of day 1? (1 mark)
(c) On which day do they climb the Great Wall? (1 mark)
(d) What do they eat on the evening of day 2? (1 mark)
(e) What can visitors do on the afternoon of day 3? (1 mark)
(f) How do they travel home? (1 mark)
(g) What is the price for one adult? (1 mark)
(h) A family of two adults and one 10-year-old child books the trip. Calculate the total cost. Show your working. (3 marks)
(i) What two things are included in the price? (2 marks)

(Total 12 marks)$mq$, $mq$(a) [1] 3 (three) days
(b) [1] The Forbidden City (故宫)
(c) [1] Day 2
(d) [1] Peking duck (Beijing roast duck)
(e) [1] Free activities (free time / do what they like)
(f) [1] By plane
(g) [1] 2800 yuan
(h) [1] Two adults: 2 × 2800 = 5600
[1] Child under 12: 1800
[1] Total 7400 yuan
(i) [1] Hotel
[1] Transport (the bus / car)$mq$, $mq$B$mq$),
(5, $mq$Read this diary entry.

今天是星期日，天气很冷。早上我和妈妈去超市买东西。我们买了苹果、牛奶和鸡蛋。苹果六块钱一斤，牛奶十块钱。回家以后，我给奶奶打电话。奶奶住在乡下，她说她下个月来我们家。我很高兴，因为我很想她。下午我做作业，晚上我和爸爸一起做饭。我们做了鱼和青菜。今天我很累，可是很快乐。
(Jīntiān shì xīngqīrì, tiānqì hěn lěng. Zǎoshang wǒ hé māma qù chāoshì mǎi dōngxi. Wǒmen mǎile píngguǒ, niúnǎi hé jīdàn. Píngguǒ liù kuài qián yì jīn, niúnǎi shí kuài qián. Huí jiā yǐhòu, wǒ gěi nǎinai dǎ diànhuà. Nǎinai zhù zài xiāngxia, tā shuō tā xià ge yuè lái wǒmen jiā. Wǒ hěn gāoxìng, yīnwèi wǒ hěn xiǎng tā. Xiàwǔ wǒ zuò zuòyè, wǎnshang wǒ hé bàba yìqǐ zuò fàn. Wǒmen zuòle yú hé qīngcài. Jīntiān wǒ hěn lèi, kěshì hěn kuàilè.)

(a) What was the weather like? (1 mark)
(b) Who went shopping with the writer? (1 mark)
(c) Name the three things they bought. (3 marks)
(d) How much was the milk? (1 mark)
(e) Apples cost 6 yuan per jin (斤). How much would 3 jin cost? Show your working. (2 marks)
(f) Where does the writer's grandmother live, and when will she visit? (2 marks)
(g) Why is the writer happy about the visit? (1 mark)
(h) How does the writer feel at the end of the day? (1 mark)

(Total 12 marks)$mq$, $mq$(a) [1] Cold
(b) [1] Mother (mum)
(c) [1] Apples
[1] Milk
[1] Eggs
(d) [1] 10 yuan
(e) [1] 3 × 6
[1] 18 yuan
(f) [1] In the countryside
[1] Next month
(g) [1] The writer misses her (wants to see her)
(h) [1] Tired but happy$mq$, $mq$B$mq$),
(6, $mq$Vocabulary and grammar.

(a) Match each Chinese word to its English meaning. Write the number and the letter. (5 marks)
1 医生 (yīshēng)   2 图书馆 (túshūguǎn)   3 苹果 (píngguǒ)   4 火车 (huǒchē)   5 手机 (shǒujī)
A mobile phone   B train   C library   D doctor   E apple

(b) Choose the correct measure word for each phrase from: 个 (gè), 只 (zhī), 本 (běn), 件 (jiàn). Use each once. (4 marks)
一___猫 (yì ___ māo, "a cat")
三___书 (sān ___ shū, "three books")
两___人 (liǎng ___ rén, "two people")
一___衣服 (yí ___ yīfu, "a piece of clothing")

(c) This sentence has a mistake: 我不有哥哥。(Wǒ bù yǒu gēge.) Write the correct sentence and give the rule in English. (2 marks)

(d) What does 对不起 (duìbuqǐ) mean? (1 mark)

(Total 12 marks)$mq$, $mq$(a) [1] 1 D
[1] 2 C
[1] 3 E
[1] 4 B
[1] 5 A
(b) [1] 只 (zhī) for the cat
[1] 本 (běn) for the books
[1] 个 (gè) for the people
[1] 件 (jiàn) for the clothing
(c) [1] 我没有哥哥。(Wǒ méiyǒu gēge.)
[1] The rule: 有 (yǒu) is made negative with 没 (méi), not 不 (bù)
(d) [1] Sorry / I am sorry$mq$, $mq$C$mq$),
(7, $mq$Writing task 1. Your Chinese pen friend, Lín, has asked about your school. Write an email of about 60 to 80 characters. Include:
- the name of your school and where it is
- how you travel to school and how long it takes
- two school subjects you like and one reason
- what time school starts
- what you eat for lunch
- one question for Lin

You may write in characters, or in characters with pinyin if you wish. (14 marks)

(Total 14 marks)$mq$, $mq$Content (6 marks): one mark for each point, communicated clearly and correctly.
[1] School name and place (for example 我的学校叫……，在……)
[1] How you travel and how long (for example 我坐公共汽车去学校，要二十分钟)
[1] Two subjects liked (for example 我喜欢数学和英语)
[1] A reason (for example 因为老师很好)
[1] Start time (for example 八点上课)
[1] Lunch (for example 中午我吃米饭和鱼)
Language (6 marks):
[1] Appropriate greeting and closing
[1] A question for Lin that is correctly formed (for example 你的学校呢？)
[1] Uses a connective or linking word (for example 和, 因为, 然后)
[1] Uses time words or measure words correctly
[1] Most characters or pinyin are accurate and the message is easy to understand
[1] Sentence word order is mostly correct (subject, time, place, verb)
Communication (2 marks):
[1] The message is logically organised
[1] The length is suitable and the register is friendly and appropriate$mq$, $mq$D$mq$),
(8, $mq$Writing task 2. Write a short paragraph of about 60 to 80 characters on the topic "My family and my weekend". Include:
- who is in your family and one detail about two of them (job or age)
- where you live
- what you like to do at the weekend
- a plan for next Saturday (use 想 or 要)
- one thing you do not like to do

You may write in characters, or in characters with pinyin if you wish. (14 marks)

(Total 14 marks)$mq$, $mq$Content (6 marks): one mark for each point, communicated clearly and correctly.
[1] Names family members and gives a detail (job or age) about one of them (for example 我家有三口人，我爸爸是医生)
[1] A detail (job or age) about a second family member
[1] Where the writer lives (for example 我住在伦敦)
[1] A weekend activity (for example 周末我喜欢踢足球)
[1] A plan for next Saturday using 想 or 要 (for example 星期六我想去看电影)
[1] One thing the writer does not like to do (for example 我不喜欢做作业)
Language (6 marks):
[1] Uses 有 correctly
[1] Uses 是 or an adjective with 很 correctly
[1] Uses a negative (不 or 没) correctly
[1] Uses 想 or 要 correctly before a verb
[1] Uses a measure word, time word or linking word correctly
[1] Most characters or pinyin are accurate and the message is easy to understand
Communication (2 marks):
[1] The paragraph is logically organised
[1] The length is suitable and the writing is complete$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
