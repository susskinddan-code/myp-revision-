-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Mandarin ab initio MYP 5 eAssessment-style Practice Paper 2 (40 marks)
with sub as (select id from public.subjects where slug = $mq$mandarin-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Mandarin ab initio MYP 5 eAssessment-style Practice Paper 2$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Mandarin ab initio MYP 5 eAssessment-style Practice Paper 2$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Listening transcript. Xiao Wang leaves a phone message for Xiao Li.

小王：喂，小李，我是小王。这个周末天气很好，星期六不下雨，二十五度。我们去公园玩，好吗？我八点半在你家门口等你。我们带水和面包。星期天下雨，我们在家看电影。再见！
(Xiǎo Wáng: Wèi, Xiǎo Lǐ, wǒ shì Xiǎo Wáng. Zhège zhōumò tiānqì hěn hǎo, xīngqīliù bú xiàyǔ, èrshíwǔ dù. Wǒmen qù gōngyuán wán, hǎo ma? Wǒ bā diǎn bàn zài nǐ jiā ménkǒu děng nǐ. Wǒmen dài shuǐ hé miànbāo. Xīngqītiān xiàyǔ, wǒmen zài jiā kàn diànyǐng. Zàijiàn!)

(a) Describe the weather on Saturday. (2 marks)
(b) Where does Xiao Wang suggest going? (1 mark)
(c) When and where will he wait for Xiao Li? (2 marks)
(d) What two things will they take? (2 marks)
(e) What will they do on Sunday? (1 mark)

(Total 8 marks)$mq$, $mq$(a) [1] It does not rain / no rain
[1] 25 degrees
(b) [1] The park
(c) [1] 8:30 (half past eight)
[1] At the door of Xiao Li's home (outside Xiao Li's house)
(d) [1] Water
[1] Bread
(e) [1] Watch a film at home (it rains on Sunday)$mq$, $mq$A$mq$),
(2, $mq$Read this notice on the door of a library.

图书馆
请安静！不能吃东西。
开门：早上八点
关门：晚上七点
(Túshūguǎn. Qǐng ānjìng! Bù néng chī dōngxi. Kāi mén: zǎoshang bā diǎn. Guān mén: wǎnshang qī diǎn.)

(a) What does the notice ask you to be? (1 mark)
(b) What is not allowed? (1 mark)
(c) At what time does the library open? (1 mark)
(d) At what time does it close? (1 mark)
(e) For how many hours is the library open each day? Show your working. (2 marks)

(Total 6 marks)$mq$, $mq$(a) [1] Quiet
(b) [1] Eating (food)
(c) [1] 8 am
(d) [1] 7 pm
(e) [1] 7 pm is 19:00, and 19 − 8 (or counting from 8 am to 7 pm)
[1] 11 hours$mq$, $mq$B$mq$),
(3, $mq$Read this text written by a student.

我叫张雨。我每天早上六点半起床，七点吃早饭。我坐公共汽车去学校，要二十分钟。学校八点开始上课。我中午在学校吃饭。下午四点放学，我回家做作业。晚上我常常看书，十点睡觉。
(Wǒ jiào Zhāng Yǔ. Wǒ měitiān zǎoshang liù diǎn bàn qǐchuáng, qī diǎn chī zǎofàn. Wǒ zuò gōnggòng qìchē qù xuéxiào, yào èrshí fēnzhōng. Xuéxiào bā diǎn kāishǐ shàngkè. Wǒ zhōngwǔ zài xuéxiào chī fàn. Xiàwǔ sì diǎn fàngxué, wǒ huí jiā zuò zuòyè. Wǎnshang wǒ chángcháng kàn shū, shí diǎn shuìjiào.)

(a) What time does Zhang Yu get up? (1 mark)
(b) How does Zhang Yu travel to school? (1 mark)
(c) How long does the journey take? (1 mark)
(d) Where does Zhang Yu eat lunch? (1 mark)
(e) What does Zhang Yu do after getting home? (1 mark)
(f) What time does Zhang Yu go to sleep? (1 mark)

(Total 6 marks)$mq$, $mq$(a) [1] 6:30 (half past six)
(b) [1] By bus
(c) [1] 20 minutes
(d) [1] At school
(e) [1] Homework
(f) [1] 10 o'clock (10 pm)$mq$, $mq$B$mq$),
(4, $mq$Answer these language questions.

(a) Turn this statement into a question using 吗 (ma): 你是学生。(Nǐ shì xuésheng.) (1 mark)
(b) Choose the correct word to complete the sentence 书___桌子上。(Shū ___ zhuōzi shàng. "The book is on the table.") 在 (zài) / 有 (yǒu) / 是 (shì) (1 mark)
(c) Put the words in the correct order: 我 / 七点 / 起床 / 早上 (2 marks)
(d) Translate into Chinese (characters or pinyin): "She likes to eat noodles." (2 marks)

(Total 6 marks)$mq$, $mq$(a) [1] 你是学生吗？(Nǐ shì xuésheng ma?)
(b) [1] 在 (zài)
(c) [1] Time words 早上 and 七点 both placed before the verb 起床
[1] Complete correct sentence 我早上七点起床。(Wǒ zǎoshang qī diǎn qǐchuáng.) Accept 早上我七点起床。
(d) [1] 她喜欢 (tā xǐhuan) with the correct pronoun 她
[1] 吃面条 (chī miàntiáo) to give 她喜欢吃面条。$mq$, $mq$C$mq$),
(5, $mq$Writing task. Write a message of about 40 to 60 characters to a friend to invite him or her to the cinema this weekend. Include:
- the film you want to see
- the day and time
- where you will meet
- a request for a reply

You may write in characters, or in characters with pinyin if you wish. Begin with a greeting and end with your name. (8 marks)

(Total 8 marks)$mq$, $mq$Award marks for the following (any suitable vocabulary is accepted).
[1] Greeting at the start, for example 小明，你好！(Xiǎo Míng, nǐ hǎo!)
[1] Invitation is clear, for example 我们去看电影，好吗？(wǒmen qù kàn diànyǐng, hǎo ma?)
[1] Names a film, for example 我想看一个新电影 (wǒ xiǎng kàn yí ge xīn diànyǐng)
[1] Gives the day, for example 星期六 (xīngqīliù)
[1] Gives the time, for example 下午三点 (xiàwǔ sān diǎn)
[1] Gives a meeting place, for example 在电影院门口 (zài diànyǐngyuàn ménkǒu)
[1] Asks for a reply, for example 请回信 (qǐng huíxìn) or 你可以来吗？(nǐ kěyǐ lái ma?)
[1] Mostly accurate word order and characters, with a closing and the writer's name$mq$, $mq$D$mq$),
(6, $mq$Read this conversation in a clothes shop.

顾客：你好，这件衬衫多少钱？
店员：一百二十元。
顾客：太贵了！有便宜一点儿的吗？
店员：有。这件蓝色的八十元。
顾客：我要这件。给你一百元。
店员：找您二十元。谢谢！
(Gùkè: Nǐ hǎo, zhè jiàn chènshān duōshao qián? Diànyuán: Yìbǎi èrshí yuán. Gùkè: Tài guì le! Yǒu piányi yìdiǎnr de ma? Diànyuán: Yǒu. Zhè jiàn lánsè de bāshí yuán. Gùkè: Wǒ yào zhè jiàn. Gěi nǐ yìbǎi yuán. Diànyuán: Zhǎo nín èrshí yuán. Xièxie!)

(a) What is the customer asking about? (1 mark)
(b) How much is the first item? (1 mark)
(c) Why does the customer not buy the first item? (1 mark)
(d) What colour is the shirt the customer buys? (1 mark)
(e) Show that the change of 20 yuan is correct. (2 marks)

(Total 6 marks)$mq$, $mq$(a) [1] A shirt
(b) [1] 120 yuan
(c) [1] It is too expensive
(d) [1] Blue
(e) [1] The customer pays 100 yuan for an 80 yuan shirt: 100 − 80
[1] = 20 yuan, which matches the change given$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
