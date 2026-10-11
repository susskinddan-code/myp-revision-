-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Mandarin ab initio MYP 5 eAssessment-style Practice Paper 1 (45 marks)
with sub as (select id from public.subjects where slug = $mq$mandarin-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Mandarin ab initio MYP 5 eAssessment-style Practice Paper 1$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Mandarin ab initio MYP 5 eAssessment-style Practice Paper 1$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Listening transcript (read it as if you were hearing it). A student introduces himself.

李明：你好！我叫李明，我是中国人。我十五岁。我家有四口人：爸爸、妈妈、一个姐姐和我。我爸爸是医生，我妈妈是老师。我喜欢踢足球。
(Lǐ Míng: Nǐ hǎo! Wǒ jiào Lǐ Míng, wǒ shì Zhōngguó rén. Wǒ shíwǔ suì. Wǒ jiā yǒu sì kǒu rén: bàba, māma, yí ge jiějie hé wǒ. Wǒ bàba shì yīshēng, wǒ māma shì lǎoshī. Wǒ xǐhuan tī zúqiú.)

Answer in English.
(a) How old is Li Ming? (1 mark)
(b) How many people are in his family? (1 mark)
(c) What is his mother's job? (1 mark)
(d) What is his father's job? (1 mark)
(e) What sport does he like to play? (1 mark)

(Total 5 marks)$mq$, $mq$(a) [1] 15 (fifteen)
(b) [1] 4 (four)
(c) [1] Teacher
(d) [1] Doctor
(e) [1] Football (soccer)$mq$, $mq$A$mq$),
(2, $mq$Read this school notice.

学校社团活动通知
星期一：篮球，下午四点
星期三：画画，下午三点半
星期五：中文，下午四点
地点：二楼教室
(Xuéxiào shètuán huódòng tōngzhī. Xīngqīyī: lánqiú, xiàwǔ sì diǎn. Xīngqīsān: huà huà, xiàwǔ sān diǎn bàn. Xīngqīwǔ: Zhōngwén, xiàwǔ sì diǎn. Dìdiǎn: èr lóu jiàoshì.)

(a) On which day is the art club (画画)? (1 mark)
(b) What time does the Chinese club start? (1 mark)
(c) Which club meets on Monday? (1 mark)
(d) Where do the clubs meet? (1 mark)
(e) Anna cannot arrive at school before 3:45 pm. Which two clubs can she join? (2 marks)

(Total 6 marks)$mq$, $mq$(a) [1] Wednesday (星期三)
(b) [1] 4 o'clock / 4:00 pm
(c) [1] Basketball
(d) [1] In a classroom on the second floor
(e) [1] Basketball
[1] Chinese. (Art starts at 3:30, which is before she arrives, so it is not possible. Award the marks in either order.)$mq$, $mq$B$mq$),
(3, $mq$Read the menu of a small restaurant. Prices are in yuan (元).

米饭 (mǐfàn) 3元
面条 (miàntiáo) 8元
饺子 (jiǎozi) 12元
鸡肉 (jīròu) 15元
茶 (chá) 2元
可乐 (kělè) 5元

(a) How much are the noodles (面条)? (1 mark)
(b) Wang Fang orders dumplings (饺子) and tea (茶). How much does she pay in total? Show your working. (2 marks)
(c) What does 鸡肉 (jīròu) mean in English? (1 mark)
(d) Tom has 20 yuan. Can he buy chicken (鸡肉) and a cola (可乐)? Answer yes or no and show how you know. (2 marks)

(Total 6 marks)$mq$, $mq$(a) [1] 8 yuan
(b) [1] 12 + 2 (dumplings plus tea)
[1] 14 yuan
(c) [1] Chicken
(d) [1] 15 + 5 = 20 yuan
[1] Yes, he has exactly enough money. (Award the second mark only for a conclusion that matches the calculation.)$mq$, $mq$B$mq$),
(4, $mq$Answer these language questions.

(a) Put the words in the correct order to make a sentence: 我 / 每天 / 学 / 中文 (2 marks)
(b) Choose the correct measure word to complete 三___书 (sān ___ shū, "three books"): 个 (gè) / 本 (běn) / 只 (zhī) (1 mark)
(c) Translate into Chinese (characters or pinyin): "I have a younger brother." (2 marks)
(d) Which sentence correctly says "I do not have a cat"? (1 mark)
    A 我不有猫。(Wǒ bù yǒu māo.)
    B 我没有猫。(Wǒ méiyǒu māo.)
(e) Complete the question with the correct word: 你___去商店吗？(Nǐ ___ qù shāngdiàn ma? "Do you want to go to the shop?") Choose from 想 (xiǎng) / 是 (shì) / 在 (zài). (1 mark)

(Total 7 marks)$mq$, $mq$(a) [1] 每天 (every day) placed before the verb 学 (e.g. 我每天学…… or 每天我学……)
[1] Complete correct sentence 我每天学中文。(Wǒ měitiān xué Zhōngwén.) Accept 每天我学中文。
(b) [1] 本 (běn)
(c) [1] 我有 (wǒ yǒu) used correctly.
[1] 一个弟弟 (yí ge dìdi) to give 我有一个弟弟。 Do not penalise a wrong tone mark if characters are given.
(d) [1] B. 有 (yǒu) is negated with 没 (méi), never with 不.
(e) [1] 想 (xiǎng, "want to")$mq$, $mq$C$mq$),
(5, $mq$Writing task. You have a new Chinese pen friend called Wáng Lín (王林). Write an email of about 40 to 60 characters to introduce yourself. Include:
- your name and age
- your family
- one hobby
- one question for Wang Lin

You may write in characters, or in characters with pinyin if you wish. Begin with a greeting and finish with your name. (8 marks)

(Total 8 marks)$mq$, $mq$Award marks for the following (candidates may use any suitable vocabulary).
[1] Greeting at the start, for example 王林，你好！(Wáng Lín, nǐ hǎo!)
[1] Gives name correctly, for example 我叫…… (wǒ jiào ...)
[1] Gives age correctly, for example 我十五岁 (wǒ shíwǔ suì)
[1] Mentions family clearly, for example 我家有四口人 (wǒ jiā yǒu sì kǒu rén)
[1] Gives one hobby, for example 我喜欢踢足球 (wǒ xǐhuan tī zúqiú)
[1] Asks a question that is understandable, for example 你喜欢什么？(nǐ xǐhuan shénme?)
[1] Mostly correct word order and vocabulary, so that the message is easy to understand
[1] Appropriate length and a closing with the writer's name$mq$, $mq$D$mq$),
(6, $mq$Read this message.

小红，
明天是我的生日。我想请你来我家吃晚饭。我家在学校旁边，六点开始。请你带一个朋友来。我们一起唱歌，玩游戏。
大卫
(Xiǎo Hóng, míngtiān shì wǒ de shēngrì. Wǒ xiǎng qǐng nǐ lái wǒ jiā chī wǎnfàn. Wǒ jiā zài xuéxiào pángbiān, liù diǎn kāishǐ. Qǐng nǐ dài yí ge péngyou lái. Wǒmen yìqǐ chàng gē, wán yóuxì. Dàwèi)

(a) What is the occasion? (1 mark)
(b) When is it? (1 mark)
(c) What time does it start? (1 mark)
(d) Where is David's home? (1 mark)
(e) What should Xiao Hong bring? (1 mark)
(f) Give two activities they will do. (2 marks)

(Total 7 marks)$mq$, $mq$(a) [1] David's birthday
(b) [1] Tomorrow
(c) [1] 6 o'clock
(d) [1] Next to the school
(e) [1] A friend
(f) [1] Sing (songs)
[1] Play games$mq$, $mq$B$mq$),
(7, $mq$Listening transcript. A person asks for directions in the street.

A：请问，火车站在哪儿？
B：往前走，然后在红绿灯往右拐。火车站在银行的左边。
A：远吗？
B：不远，走路五分钟。
A：谢谢！
B：不客气。
(A: Qǐngwèn, huǒchēzhàn zài nǎr? B: Wǎng qián zǒu, ránhòu zài hónglǜdēng wǎng yòu guǎi. Huǒchēzhàn zài yínháng de zuǒbian. A: Yuǎn ma? B: Bù yuǎn, zǒulù wǔ fēnzhōng. A: Xièxie! B: Bú kèqi.)

(a) What place is the first speaker looking for? (1 mark)
(b) Which way must they turn at the traffic lights? (1 mark)
(c) Where is the place in relation to the bank? Give the building and the side. (2 marks)
(d) How long does it take to walk there? (1 mark)
(e) What does 不客气 (bú kèqi) mean? (1 mark)

(Total 6 marks)$mq$, $mq$(a) [1] The train station
(b) [1] Right
(c) [1] The bank
[1] On its left side (left of the bank)
(d) [1] Five minutes
(e) [1] You are welcome / do not mention it$mq$, $mq$A$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
