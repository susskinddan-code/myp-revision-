-- Part 8 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Mandarin Grammar Essentials > Sentence Order, Shi, You and Negation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Mandarin Grammar Essentials$mq$, 5, 8 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Sentence Order, Shi, You and Negation$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Mandarin Grammar Essentials$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Sentence Order, Shi, You and Negation$mq$ and p.name = $mq$Mandarin Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which sentence means 'I am a student'?$mq$, $mq$["我是学生 (wǒ shì xuésheng)","我有学生 (wǒ yǒu xuésheng)","我不是学生 (wǒ bú shì xuésheng)","我没有学生 (wǒ méiyǒu xuésheng)"]$mq$, 0, $mq$是 (shì) links two nouns, so 我是学生 means 'I am a student'. 我有学生 would mean 'I have a student' and the other two are negatives.$mq$, $mq$easy$mq$),
($mq$What does 我没有哥哥 (wǒ méiyǒu gēge) mean?$mq$, $mq$["I am not an older brother","I do not like my older brother","I have an older brother","I do not have an older brother"]$mq$, 3, $mq$没有 (méiyǒu) is the negative of 有 (yǒu, to have), so the sentence says the speaker has no older brother.$mq$, $mq$easy$mq$),
($mq$Which is the correct negative of 我是中国人 (wǒ shì Zhōngguó rén)?$mq$, $mq$["我没是中国人 (wǒ méi shì Zhōngguó rén)","我不有中国人 (wǒ bù yǒu Zhōngguó rén)","我不是中国人 (wǒ bú shì Zhōngguó rén)","我是不中国人 (wǒ shì bù Zhōngguó rén)"]$mq$, 2, $mq$是 is negated with 不, placed directly before it. 不 changes to bú (second tone) before the fourth tone of 是.$mq$, $mq$easy$mq$),
($mq$Which sentence correctly says 'She likes tea'?$mq$, $mq$["喜欢她茶 (xǐhuan tā chá)","她喜欢茶 (tā xǐhuan chá)","茶喜欢她 (chá xǐhuan tā)","她茶喜欢 (tā chá xǐhuan)"]$mq$, 1, $mq$Mandarin basic word order is subject + verb + object, like English. 茶喜欢她 would mean 'Tea likes her'.$mq$, $mq$easy$mq$),
($mq$Which word means 'to have'?$mq$, $mq$["有 (yǒu)","是 (shì)","在 (zài)","要 (yào)"]$mq$, 0, $mq$有 means 'to have' (or 'there is'). 是 is 'to be', 在 is 'to be at' and 要 is 'to want'.$mq$, $mq$easy$mq$),
($mq$How do you say 'I do not have a pen' in Mandarin?$mq$, $mq$["我不有笔 (wǒ bù yǒu bǐ)","我有不笔 (wǒ yǒu bù bǐ)","我不是笔 (wǒ bú shì bǐ)","我没有笔 (wǒ méiyǒu bǐ)"]$mq$, 3, $mq$有 is always negated with 没, giving 没有. 不有 does not exist, and 我不是笔 means 'I am not a pen'.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'I am tall'?$mq$, $mq$["我是高 (wǒ shì gāo)","我是很高 (wǒ shì hěn gāo)","我很高 (wǒ hěn gāo)","我有高 (wǒ yǒu gāo)"]$mq$, 2, $mq$Adjectives do not need 是. Use subject + 很 + adjective. 很 here is often just a link word, so it does not always mean 'very'.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'I am a student too'?$mq$, $mq$["我是也学生 (wǒ shì yě xuésheng)","我也是学生 (wǒ yě shì xuésheng)","也我是学生 (yě wǒ shì xuésheng)","我是学生也 (wǒ shì xuésheng yě)"]$mq$, 1, $mq$也 (yě, also) goes after the subject and before the verb. It never goes after the verb or at the end of a sentence.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'They are all Chinese'?$mq$, $mq$["他们都是中国人 (tāmen dōu shì Zhōngguó rén)","他们是都中国人 (tāmen shì dōu Zhōngguó rén)","都他们是中国人 (dōu tāmen shì Zhōngguó rén)","他们是中国人都 (tāmen shì Zhōngguó rén dōu)"]$mq$, 0, $mq$都 (dōu, all) goes before the verb, after the subject. It cannot sit after 是 or at the end.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'I study Chinese at school'?$mq$, $mq$["我学中文在学校 (wǒ xué Zhōngwén zài xuéxiào)","我学在学校中文 (wǒ xué zài xuéxiào Zhōngwén)","我中文学在学校 (wǒ Zhōngwén xué zài xuéxiào)","我在学校学中文 (wǒ zài xuéxiào xué Zhōngwén)"]$mq$, 3, $mq$Place phrases such as 在学校 (at school) come before the main verb in Mandarin, unlike English where they usually come last.$mq$, $mq$medium$mq$),
($mq$Read: 我叫王明 (wǒ jiào Wáng Míng)。我是中学生 (wǒ shì zhōngxuéshēng)。我没有哥哥，也没有姐姐 (wǒ méiyǒu gēge, yě méiyǒu jiějie)。我有一个弟弟 (wǒ yǒu yí ge dìdi)。 Which brothers and sisters does Wang Ming have?$mq$, $mq$["One older brother and one older sister","One younger brother and one older sister","One younger brother only","No brothers or sisters"]$mq$, 2, $mq$He has no older brother (哥哥) and no older sister (姐姐), but he has one younger brother (弟弟).$mq$, $mq$medium$mq$),
($mq$A student wrote 我不有手机 (wǒ bù yǒu shǒujī) for 'I do not have a mobile phone'. What is the mistake?$mq$, $mq$["手机 must come before 有","有 must be negated with 没, not 不","是 is missing before 有","不 must go after 手机"]$mq$, 1, $mq$The correct sentence is 我没有手机 (wǒ méiyǒu shǒujī). 不 negates 是 and most other verbs, but 有 uses 没.$mq$, $mq$medium$mq$),
($mq$Which sentence is NOT correct Mandarin?$mq$, $mq$["她是漂亮 (tā shì piàoliang)","他很忙 (tā hěn máng)","我们都是学生 (wǒmen dōu shì xuésheng)","我也有狗 (wǒ yě yǒu gǒu)"]$mq$, 0, $mq$Adjectives such as 漂亮 (pretty) take 很, not 是. The correct sentence is 她很漂亮 (tā hěn piàoliang).$mq$, $mq$medium$mq$),
($mq$Someone asks 你是老师吗？(nǐ shì lǎoshī ma?). Which reply correctly says 'No, I am a student'?$mq$, $mq$["没是，我是学生 (méi shì, wǒ shì xuésheng)","不有，我是学生 (bù yǒu, wǒ shì xuésheng)","我不吗，是学生 (wǒ bù ma, shì xuésheng)","不是，我是学生 (bú shì, wǒ shì xuésheng)"]$mq$, 3, $mq$The question uses 是, so the short negative answer repeats the verb with 不: 不是. 没 is only used with 有 and past events.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'My friends also all have dogs'?$mq$, $mq$["我的朋友都也有狗 (wǒ de péngyou dōu yě yǒu gǒu)","我的朋友有也都狗 (wǒ de péngyou yǒu yě dōu gǒu)","我的朋友也都有狗 (wǒ de péngyou yě dōu yǒu gǒu)","也都我的朋友有狗 (yě dōu wǒ de péngyou yǒu gǒu)"]$mq$, 2, $mq$When both appear, 也 comes before 都, and both go between the subject and the verb: subject + 也 + 都 + verb.$mq$, $mq$hard$mq$),
($mq$Read: 小红：你有哥哥吗？(Xiǎohóng: nǐ yǒu gēge ma?) 小丽：我没有哥哥，但是我有两个姐姐 (Xiǎolì: wǒ méiyǒu gēge, dànshì wǒ yǒu liǎng ge jiějie). What does Xiaoli have?$mq$, $mq$["Two older brothers and no sisters","Two older sisters and no older brother","One older sister and one older brother","Two younger sisters and no brothers"]$mq$, 1, $mq$但是 (dànshì) means 'but'. 没有哥哥 means no older brother; 两个姐姐 means two older sisters.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'My father is not a doctor, and he does not have a car'?$mq$, $mq$["我爸爸不是医生，也没有车 (wǒ bàba bú shì yīshēng, yě méiyǒu chē)","我爸爸没是医生，也不有车 (wǒ bàba méi shì yīshēng, yě bù yǒu chē)","我爸爸不是医生，也不有车 (wǒ bàba bú shì yīshēng, yě bù yǒu chē)","我爸爸没是医生，也没有车 (wǒ bàba méi shì yīshēng, yě méiyǒu chē)"]$mq$, 0, $mq$Use 不 for 是 (不是) and 没 for 有 (没有). Each negative must match its own verb, and only one option does this twice.$mq$, $mq$hard$mq$),
($mq$A student wants to write 'I am not tired' and chooses 我不是累 (wǒ bú shì lèi). Which correction is right and why?$mq$, $mq$["我没累 (wǒ méi lèi); adjectives always take 没","我是不累 (wǒ shì bú lèi); 不 must follow 是","我有不累 (wǒ yǒu bú lèi); 有 is needed for feelings","我不累 (wǒ bú lèi); an adjective is negated with 不 and needs no 是"]$mq$, 3, $mq$Adjectives work as the predicate on their own, so they are negated directly with 不: 我不累. Adding 是 is a common English-influenced error.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Sentence Order, Shi, You and Negation$mq$ and p.name = $mq$Mandarin Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$我是学生 (wǒ shì xuésheng)$mq$, $mq$I am a student. 是 links two nouns: subject + 是 + noun.$mq$),
($mq$我很高 (wǒ hěn gāo)$mq$, $mq$I am tall. Adjectives take 很 and no 是. Wrong: 我是高.$mq$),
($mq$我没有哥哥 (wǒ méiyǒu gēge)$mq$, $mq$I do not have an older brother. 有 is negated with 没, never 不.$mq$),
($mq$我不是老师 (wǒ bú shì lǎoshī)$mq$, $mq$I am not a teacher. 不 negates 是. 不 becomes bú before a fourth tone.$mq$),
($mq$Order for time and place in a Mandarin sentence$mq$, $mq$Subject + time + place + verb + object, e.g. 我明天在家学中文 (wǒ míngtiān zài jiā xué Zhōngwén): Tomorrow I will study Chinese at home.$mq$),
($mq$也 (yě) and 都 (dōu): where do they go?$mq$, $mq$Between the subject and the verb. If both appear, 也 comes first: 我们也都是学生 (wǒmen yě dōu shì xuésheng).$mq$),
($mq$你是学生吗？(nǐ shì xuésheng ma?)$mq$, $mq$Are you a student? 吗 turns a statement into a yes/no question. Answer 是 or 不是.$mq$),
($mq$他们都有狗 (tāmen dōu yǒu gǒu)$mq$, $mq$They all have dogs. 都 means all or both and goes before the verb.$mq$),
($mq$Which word negates 有?$mq$, $mq$没 (méi): 没有 (méiyǒu) means do not have, or there is not. 不有 is always wrong.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Sentence Order, Shi, You and Negation$mq$ and p.name = $mq$Mandarin Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why word order matters
Mandarin has no verb endings and no plurals, so almost all meaning comes from word order. If you learn a few patterns well, you can build hundreds of correct sentences. In a reading task a wrong guess at word order can reverse the meaning, and in writing it loses marks for accuracy.

## Basic order: subject, verb, object
Mandarin uses the same basic order as English: subject + verb + object.
- 我喜欢茶 (wǒ xǐhuan chá): I like tea
- 她学中文 (tā xué Zhōngwén): She studies Chinese
- 他们喝水 (tāmen hē shuǐ): They drink water

Time words and place phrases come BEFORE the main verb. The order is subject + time + place + verb + object.
- 我明天去学校 (wǒ míngtiān qù xuéxiào): I am going to school tomorrow
- 我在学校学中文 (wǒ zài xuéxiào xué Zhōngwén): I study Chinese at school

## 是 (shì): to be
Use 是 to link two nouns, for identity, nationality and jobs.
- 我是学生 (wǒ shì xuésheng): I am a student
- 他是老师 (tā shì lǎoshī): He is a teacher
- 她是中国人 (tā shì Zhōngguó rén): She is Chinese
Do NOT use 是 before an adjective. Say 我很高 (wǒ hěn gāo), not 我是高. The word 很 (hěn) works as a link here and often needs no 'very' in English.

## 有 (yǒu): to have, there is
- 我有一只猫 (wǒ yǒu yì zhī māo): I have a cat
- 她有两个姐姐 (tā yǒu liǎng ge jiějie): She has two older sisters

## Negation: 不 and 没
This is the most tested point in the topic.
- **不** (bù) negates 是 and most verbs and adjectives: 我不是老师 (wǒ bú shì lǎoshī), 我不喝咖啡 (wǒ bù hē kāfēi), 我不累 (wǒ bú lèi)
- **没** (méi) negates 有: 我没有哥哥 (wǒ méiyǒu gēge). Never say 不有.
- 没 also negates past actions, covered in the aspect topic.
Tone note: 不 is bù, but it becomes bú before a fourth-tone syllable, so 不是 is written bú shì.

## 也 and 都
- 也 (yě) means also or too: 我也是学生 (wǒ yě shì xuésheng)
- 都 (dōu) means all or both: 我们都是学生 (wǒmen dōu shì xuésheng)
Both go between the subject and the verb. If you need both, 也 comes first: 他们也都有狗 (tāmen yě dōu yǒu gǒu).

## Yes/no questions with 吗
Add 吗 (ma) to the end of a statement: 你是学生吗？ (nǐ shì xuésheng ma?). A short answer repeats the verb: 是 (yes) or 不是 (no); 有 (yes) or 没有 (no).

## Common mistakes
- Using 不有 instead of 没有
- Writing 我是高 instead of 我很高
- Putting the place after the verb, as in English
- Putting 也 or 都 after the verb

## How this is examined
In reading tasks you meet short messages and profiles, such as 我没有哥哥，但是我有两个姐姐, and you must decide who has what. Negation is a favourite trap, because a student who skims past 没 or 不 picks the opposite answer. In writing tasks, accuracy marks depend on correct basic order, correct negation and sensible use of 很, 也 and 都.

Exam tip: Before you answer a reading question, circle every 不 and 没 in the text, then check whether the answer you chose says the opposite of what the writer meant.$mq$ from st;

-- Mandarin Grammar Essentials > Measure Words and Question Forms
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Mandarin Grammar Essentials$mq$, 5, 8 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Measure Words and Question Forms$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Mandarin Grammar Essentials$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Measure Words and Question Forms$mq$ and p.name = $mq$Mandarin Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which measure word is the general-purpose one, used with people and many objects?$mq$, $mq$["个 (gè)","本 (běn)","杯 (bēi)","张 (zhāng)"]$mq$, 0, $mq$个 is the all-purpose measure word, as in 一个人 (yí ge rén, one person). The others are for books, cups and flat objects.$mq$, $mq$easy$mq$),
($mq$Choose the correct measure word: 三___书 (sān ___ shū, three books).$mq$, $mq$["只 (zhī)","杯 (bēi)","条 (tiáo)","本 (běn)"]$mq$, 3, $mq$本 is used for books and notebooks: 三本书 (sān běn shū).$mq$, $mq$easy$mq$),
($mq$Choose the correct measure word: 两___猫 (liǎng ___ māo, two cats).$mq$, $mq$["本 (běn)","张 (zhāng)","只 (zhī)","杯 (bēi)"]$mq$, 2, $mq$只 is the measure word for most small animals, such as cats and birds: 两只猫 (liǎng zhī māo).$mq$, $mq$easy$mq$),
($mq$What does 什么 (shénme) mean?$mq$, $mq$["Who","What","Where","Why"]$mq$, 1, $mq$什么 means 'what', as in 这是什么？ (zhè shì shénme?, What is this?). Who is 谁, where is 哪儿 and why is 为什么.$mq$, $mq$easy$mq$),
($mq$Which word, placed at the end of a statement, turns it into a yes/no question?$mq$, $mq$["吗 (ma)","了 (le)","的 (de)","都 (dōu)"]$mq$, 0, $mq$吗 makes a yes/no question: 你有哥哥吗？ (nǐ yǒu gēge ma?). 了 marks a completed action and 的 shows possession.$mq$, $mq$easy$mq$),
($mq$Complete: 我想喝一___水 (wǒ xiǎng hē yì ___ shuǐ, I want to drink a glass of water).$mq$, $mq$["本 (běn)","张 (zhāng)","只 (zhī)","杯 (bēi)"]$mq$, 3, $mq$杯 is the measure word for cups and glasses of drinks: 一杯水 (yì bēi shuǐ).$mq$, $mq$medium$mq$),
($mq$Which question means 'Who is that?'$mq$, $mq$["那是什么？(nà shì shénme?)","那在哪儿？(nà zài nǎr?)","那是谁？(nà shì shéi?)","那是几？(nà shì jǐ?)"]$mq$, 2, $mq$谁 (shéi) asks about people. 什么 asks 'what', 哪儿 asks 'where' and 几 asks 'how many'.$mq$, $mq$medium$mq$),
($mq$Which question correctly asks 'Where is the library?'$mq$, $mq$["图书馆在谁？(túshūguǎn zài shéi?)","图书馆在哪儿？(túshūguǎn zài nǎr?)","图书馆在什么吗？(túshūguǎn zài shénme ma?)","图书馆哪儿在？(túshūguǎn nǎr zài?)"]$mq$, 1, $mq$The question word replaces the answer in the same place. 在哪儿 (zài nǎr) asks where something is. Question words never take 吗.$mq$, $mq$medium$mq$),
($mq$Which phrase correctly says 'two people'?$mq$, $mq$["两个人 (liǎng ge rén)","二个人 (èr ge rén)","两人个 (liǎng rén gè)","二人个 (èr rén gè)"]$mq$, 0, $mq$Before a measure word, 'two' is 两 (liǎng), not 二 (èr). The measure word follows the number and comes before the noun.$mq$, $mq$medium$mq$),
($mq$Which question is NOT correct Mandarin?$mq$, $mq$["你叫什么名字？(nǐ jiào shénme míngzi?)","你是学生吗？(nǐ shì xuésheng ma?)","你有几个哥哥？(nǐ yǒu jǐ ge gēge?)","你叫什么名字吗？(nǐ jiào shénme míngzi ma?)"]$mq$, 3, $mq$A question that already has a question word such as 什么 must not also end with 吗. Use one or the other.$mq$, $mq$medium$mq$),
($mq$Read: 小李：我要一杯茶、两个面包和三瓶水 (Xiǎo Lǐ: wǒ yào yì bēi chá, liǎng ge miànbāo hé sān píng shuǐ). What does Xiao Li order?$mq$, $mq$["2 cups of tea, 1 bread roll, 3 bottles of water","1 cup of tea, 3 bread rolls, 2 bottles of water","1 cup of tea, 2 bread rolls, 3 bottles of water","3 cups of tea, 2 bread rolls, 1 bottle of water"]$mq$, 2, $mq$Match each number to its measure word: 一杯茶 (one cup of tea), 两个面包 (two bread rolls), 三瓶水 (three bottles of water).$mq$, $mq$medium$mq$),
($mq$Which question word is best for asking a large number, such as how many students are in a school?$mq$, $mq$["几 (jǐ)","多少 (duōshao)","谁 (shéi)","哪 (nǎ)"]$mq$, 1, $mq$多少 is used for any number, especially large ones. 几 is normally used when you expect a small number, under about ten.$mq$, $mq$medium$mq$),
($mq$Which phrase uses the measure word correctly?$mq$, $mq$["一张桌子 (yì zhāng zhuōzi, a table)","一本桌子 (yì běn zhuōzi)","一只书 (yì zhī shū)","一杯猫 (yì bēi māo)"]$mq$, 0, $mq$张 is used for flat objects such as tables, paper and tickets. 本 is for books, 只 for small animals and 杯 for cups.$mq$, $mq$medium$mq$),
($mq$Read: 小明：我有两个姐姐，你呢？(Xiǎomíng: wǒ yǒu liǎng ge jiějie, nǐ ne?) 小红：我没有姐姐，我有一个哥哥 (Xiǎohóng: wǒ méiyǒu jiějie, wǒ yǒu yí ge gēge). What does 你呢 (nǐ ne) mean, and what does Xiaohong have?$mq$, $mq$["'Who are you?'; she has one older sister","'And you?'; she has two older sisters","'Where are you?'; she has one older brother","'And you?'; she has one older brother"]$mq$, 3, $mq$呢 (ne) after a noun or pronoun asks 'and what about...?' Xiaohong says she has no older sisters but one older brother.$mq$, $mq$hard$mq$),
($mq$A student wrote 我有二本书 (wǒ yǒu èr běn shū). Which correction is right?$mq$, $mq$["我有两书本 (wǒ yǒu liǎng shū běn)","我有本两书 (wǒ yǒu běn liǎng shū)","我有两本书 (wǒ yǒu liǎng běn shū)","我有两本书吗 (wǒ yǒu liǎng běn shū ma)"]$mq$, 2, $mq$Use 两 for 'two' before a measure word, then the measure word, then the noun. Adding 吗 would turn the statement into a question.$mq$, $mq$hard$mq$),
($mq$Which is the correct A-not-A question meaning 'Is he your teacher?'$mq$, $mq$["他是不你的老师？(tā shì bù nǐ de lǎoshī?)","他是不是你的老师？(tā shì bu shì nǐ de lǎoshī?)","他不是是你的老师？(tā bú shì shì nǐ de lǎoshī?)","他是吗不你的老师？(tā shì ma bù nǐ de lǎoshī?)"]$mq$, 1, $mq$In an A-not-A question you repeat the verb with its negative: 是不是 (shì bu shì). It does not need 吗.$mq$, $mq$hard$mq$),
($mq$At a restaurant, the waiter asks 请问，几位？(qǐngwèn, jǐ wèi?). The customer answers 三位 (sān wèi). What is the waiter asking?$mq$, $mq$["How many people are in your group?","How many dishes would you like?","How many nights will you stay?","Which table would you like?"]$mq$, 0, $mq$位 (wèi) is the polite measure word for people. 几位 asks how many people, and 三位 means a group of three.$mq$, $mq$hard$mq$),
($mq$Match the measure words in order: 一___鱼 (fish), 一___椅子 (chair), 一___雨伞 (umbrella).$mq$, $mq$["只 (zhī), 张 (zhāng), 个 (gè)","个 (gè), 条 (tiáo), 本 (běn)","杯 (bēi), 把 (bǎ), 张 (zhāng)","条 (tiáo), 把 (bǎ), 把 (bǎ)"]$mq$, 3, $mq$鱼 takes 条 (long, thin things). Chairs and umbrellas, which have a handle or something to hold, take 把.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Measure Words and Question Forms$mq$ and p.name = $mq$Mandarin Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$个 (gè)$mq$, $mq$The general measure word, used for people and many objects: 一个人 (yí ge rén). Use it when you are not sure which measure word to choose.$mq$),
($mq$本 (běn)$mq$, $mq$Measure word for books and notebooks: 一本书 (yì běn shū), 三本书 (sān běn shū).$mq$),
($mq$只 (zhī)$mq$, $mq$Measure word for most small animals: 一只猫 (yì zhī māo), 两只狗 (liǎng zhī gǒu).$mq$),
($mq$杯 (bēi) and 瓶 (píng)$mq$, $mq$杯 is for cups and glasses: 一杯茶 (yì bēi chá). 瓶 is for bottles: 两瓶水 (liǎng píng shuǐ).$mq$),
($mq$张 (zhāng)$mq$, $mq$Measure word for flat objects such as paper, tables and tickets: 一张纸 (yì zhāng zhǐ), 一张桌子 (yì zhāng zhuōzi).$mq$),
($mq$Two people: 二个人 or 两个人?$mq$, $mq$两个人 (liǎng ge rén). Use 两 (liǎng) for 'two' before a measure word. Use 二 (èr) only for counting and in numbers like 十二.$mq$),
($mq$什么 / 谁 / 哪儿 (shénme / shéi / nǎr)$mq$, $mq$What / who / where. They take the place of the answer in the sentence and never need 吗.$mq$),
($mq$几 (jǐ) vs 多少 (duōshao)$mq$, $mq$Both mean how many. 几 is for small numbers, usually under ten. 多少 can be used for any number, and is used for prices: 多少钱？ (duōshao qián?).$mq$),
($mq$你呢？(nǐ ne?)$mq$, $mq$And you? 呢 gives a question back after you have answered: 我很好，你呢？ (wǒ hěn hǎo, nǐ ne?)$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Measure Words and Question Forms$mq$ and p.name = $mq$Mandarin Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why measure words matter
In English we say 'three books' or 'a cup of tea'. In Mandarin, between a number and a noun you must add a **measure word** (also called a classifier). The pattern is number + measure word + noun. Measure words appear in almost every reading text, so they are worth learning properly.

## The pattern
- 三本书 (sān běn shū): three books
- 一杯茶 (yì bēi chá): a cup of tea
- 两只猫 (liǎng zhī māo): two cats

The word for 'two' is 两 (liǎng), not 二 (èr), before a measure word. You still use 二 when counting or in numbers like 十二 (shí'èr, twelve).

## Essential measure words
- 个 (gè): general, for people and many objects: 一个人 (yí ge rén, one person)
- 本 (běn): books and notebooks: 一本书 (yì běn shū)
- 支 (zhī): pens: 一支笔 (yì zhī bǐ)
- 张 (zhāng): flat things such as paper, tables and tickets: 一张纸 (yì zhāng zhǐ, a sheet of paper)
- 只 (zhī): small animals: 一只狗 (yì zhī gǒu, a dog)
- 条 (tiáo): long, thin things such as fish, rivers and trousers: 一条鱼 (yì tiáo yú)
- 杯 (bēi): cups and glasses: 一杯水 (yì bēi shuǐ)
- 瓶 (píng): bottles: 两瓶水 (liǎng píng shuǐ)
- 碗 (wǎn): bowls: 一碗米饭 (yì wǎn mǐfàn, a bowl of rice)
- 件 (jiàn): clothes worn on the upper body: 一件衣服 (yí jiàn yīfu)
- 双 (shuāng): pairs: 一双鞋 (yì shuāng xié, a pair of shoes)
- 把 (bǎ): things with a handle, such as chairs and umbrellas: 一把椅子 (yì bǎ yǐzi)
- 位 (wèi): polite, for people: 三位客人 (sān wèi kèrén, three guests)
- 口 (kǒu): members of a family: 我家有四口人 (wǒ jiā yǒu sì kǒu rén, there are four people in my family)
When in doubt, 个 is the safest choice.

## Question forms
- 吗 (ma): yes/no questions: 你喜欢猫吗？ (nǐ xǐhuan māo ma?)
- 什么 (shénme): what: 你喝什么？ (nǐ hē shénme?)
- 谁 (shéi): who: 她是谁？ (tā shì shéi?)
- 哪儿 (nǎr): where: 你在哪儿？ (nǐ zài nǎr?)
- 几 (jǐ): how many, small numbers: 你有几个朋友？ (nǐ yǒu jǐ ge péngyou?)
- 多少 (duōshao): how many or how much: 这个多少钱？ (zhège duōshao qián?, How much is this?)
- 为什么 (wèishénme): why
- 呢 (ne): 'and you?': 我很好，你呢？ (wǒ hěn hǎo, nǐ ne?)
- A-not-A: 你是不是学生？ (nǐ shì bu shì xuésheng?)

The key rule: the question word takes the place of the answer, so word order does not change. Question-word questions never end with 吗.

## Common mistakes
- Forgetting the measure word: 三书 instead of 三本书
- Using 二 instead of 两: 二个人
- Adding 吗 to a question that already has 什么 or 谁
- Moving the question word to the front, as in English

## How this is examined
Menus, shopping lists and short dialogues are packed with numbers and measure words, such as 一杯茶、两个面包 and 三瓶水. Questions then ask you to total items or choose what a person ordered. In writing tasks, correct use of 个, 本 and 杯 shows control of the language.

Exam tip: In a shopping or menu text, pair every number with its measure word and noun before you do any sums, so that you never mix up a quantity of tea with a quantity of bread.$mq$ from st;

-- Mandarin Grammar Essentials > Time Words and Aspect Particles
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Mandarin Grammar Essentials$mq$, 5, 8 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Time Words and Aspect Particles$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Mandarin Grammar Essentials$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Time Words and Aspect Particles$mq$ and p.name = $mq$Mandarin Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 明天 (míngtiān) mean?$mq$, $mq$["Tomorrow","Yesterday","Today","Now"]$mq$, 0, $mq$明天 means tomorrow. Yesterday is 昨天 (zuótiān), today is 今天 (jīntiān) and now is 现在 (xiànzài).$mq$, $mq$easy$mq$),
($mq$What does 昨天 (zuótiān) mean?$mq$, $mq$["Tomorrow","Every day","Last year","Yesterday"]$mq$, 3, $mq$昨天 means yesterday. Every day is 每天 (měitiān).$mq$, $mq$easy$mq$),
($mq$What does the question 现在几点？(xiànzài jǐ diǎn?) ask?$mq$, $mq$["What day is it today?","Where are you now?","What time is it now?","How old are you?"]$mq$, 2, $mq$现在 means now, 几 means how many, and 点 (diǎn) means o'clock, so the question asks for the time.$mq$, $mq$easy$mq$),
($mq$What time is 三点半 (sān diǎn bàn)?$mq$, $mq$["3:15","3:30","3:45","5:30"]$mq$, 1, $mq$半 (bàn) means half. 三点半 is half past three, 3:30.$mq$, $mq$easy$mq$),
($mq$Which particle shows that an action has been completed?$mq$, $mq$["了 (le)","吗 (ma)","呢 (ne)","的 (de)"]$mq$, 0, $mq$了 after a verb shows completion: 我吃了 (wǒ chī le, I ate). 吗 makes questions and 的 shows possession.$mq$, $mq$easy$mq$),
($mq$Which sentence correctly says 'I went to school yesterday'?$mq$, $mq$["我去学校昨天了 (wǒ qù xuéxiào zuótiān le)","我昨天学校去了 (wǒ zuótiān xuéxiào qù le)","我去了学校昨天 (wǒ qù le xuéxiào zuótiān)","我昨天去学校了 (wǒ zuótiān qù xuéxiào le)"]$mq$, 3, $mq$The time word 昨天 goes before the verb, after the subject. 了 marks the completed action.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'I did not eat breakfast'?$mq$, $mq$["我不吃了早饭 (wǒ bù chī le zǎofàn)","我没吃了早饭 (wǒ méi chī le zǎofàn)","我没吃早饭 (wǒ méi chī zǎofàn)","我没有吃了早饭 (wǒ méiyǒu chī le zǎofàn)"]$mq$, 2, $mq$To negate a past action, use 没 or 没有 and drop 了. Never use 没 and 了 together on the same verb.$mq$, $mq$medium$mq$),
($mq$What does 我去过北京 (wǒ qù guo Běijīng) mean?$mq$, $mq$["I am going to Beijing tomorrow","I have been to Beijing before","I am in Beijing now","I want to go to Beijing"]$mq$, 1, $mq$过 (guo) after a verb shows past experience: you did it at least once in your life.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'I get up at 6:30 every day'?$mq$, $mq$["我每天六点半起床 (wǒ měitiān liù diǎn bàn qǐchuáng)","我起床每天六点半 (wǒ qǐchuáng měitiān liù diǎn bàn)","我起床六点半每天 (wǒ qǐchuáng liù diǎn bàn měitiān)","六点半起床我每天 (liù diǎn bàn qǐchuáng wǒ měitiān)"]$mq$, 0, $mq$Time words go before the verb. Larger time words come first (每天), then the clock time (六点半), then the verb.$mq$, $mq$medium$mq$),
($mq$Read: 今天星期五 (jīntiān xīngqīwǔ)。下午三点我有中文课 (xiàwǔ sān diǎn wǒ yǒu Zhōngwén kè)。四点半我去打篮球 (sì diǎn bàn wǒ qù dǎ lánqiú)。晚上七点我在家吃饭 (wǎnshang qī diǎn wǒ zài jiā chī fàn). What does the writer do at 4:30 pm?$mq$, $mq$["Has a Chinese lesson","Eats dinner at home","Goes to school","Goes to play basketball"]$mq$, 3, $mq$四点半 is 4:30 and 去打篮球 means goes to play basketball. The Chinese lesson is at 3:00 and dinner is at 7:00.$mq$, $mq$medium$mq$),
($mq$What does 我妈妈在做饭 (wǒ māma zài zuò fàn) mean?$mq$, $mq$["My mum cooked","My mum will cook","My mum is cooking","My mum has never cooked"]$mq$, 2, $mq$在 before a verb shows an action in progress, like 'is ...ing'. 做饭 means to cook.$mq$, $mq$medium$mq$),
($mq$Which is the correct way to say 'two o'clock'?$mq$, $mq$["二点 (èr diǎn)","两点 (liǎng diǎn)","两个点 (liǎng ge diǎn)","二个点 (èr ge diǎn)"]$mq$, 1, $mq$Use 两 for two o'clock: 两点. Clock times do not take 个.$mq$, $mq$medium$mq$),
($mq$In Chinese, dates go from large to small. What date is 三月五日 (sān yuè wǔ rì)?$mq$, $mq$["5 March","3 May","3 March","5 May"]$mq$, 0, $mq$月 (yuè) is month and 日 (rì) is day. 三月 is March, 五日 is the fifth, so the date is 5 March.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'I have never eaten Chinese food'?$mq$, $mq$["我不吃过中国菜 (wǒ bù chī guo Zhōngguó cài)","我没吃了中国菜 (wǒ méi chī le Zhōngguó cài)","我不吃了中国菜 (wǒ bù chī le Zhōngguó cài)","我没吃过中国菜 (wǒ méi chī guo Zhōngguó cài)"]$mq$, 3, $mq$Negative experience uses 没 + verb + 过. 不 is not used with 过 or 了 for a past event, and 没吃了 is wrong.$mq$, $mq$hard$mq$),
($mq$Read: A：你吃午饭了吗？(nǐ chī wǔfàn le ma?) B：还没有，我现在在写作业 (hái méiyǒu, wǒ xiànzài zài xiě zuòyè). What is B's situation?$mq$, $mq$["B has finished lunch and is doing homework","B will eat lunch and do homework tomorrow","B has not eaten lunch yet and is doing homework now","B never eats lunch"]$mq$, 2, $mq$还没有 (hái méiyǒu) means 'not yet', and 在写作业 means is doing homework now.$mq$, $mq$hard$mq$),
($mq$What does 要下雨了 (yào xià yǔ le) mean?$mq$, $mq$["It rained yesterday","It is going to rain","It is raining now","It never rains"]$mq$, 1, $mq$要...了 (yào ... le) shows something is about to happen. Rain right now would be 在下雨 (zài xià yǔ).$mq$, $mq$hard$mq$),
($mq$A student wrote 我昨天不去学校了 (wǒ zuótiān bú qù xuéxiào le) to mean 'I did not go to school yesterday'. Which correction is best?$mq$, $mq$["我昨天没去学校 (wǒ zuótiān méi qù xuéxiào)","我昨天不去过学校 (wǒ zuótiān bú qù guo xuéxiào)","我昨天去学校没了 (wǒ zuótiān qù xuéxiào méi le)","我没昨天去学校 (wǒ méi zuótiān qù xuéxiào)"]$mq$, 0, $mq$A past event that did not happen is negated with 没 directly before the verb, and 了 is dropped. The time word still comes before 没.$mq$, $mq$hard$mq$),
($mq$Read: 我们星期一到星期五上课 (wǒmen xīngqīyī dào xīngqīwǔ shàngkè)，早上八点上课 (zǎoshang bā diǎn shàngkè)，下午三点半放学 (xiàwǔ sān diǎn bàn fàngxué)。星期六和星期天不上课 (xīngqīliù hé xīngqītiān bú shàngkè). Which statement is true?$mq$, $mq$["Lessons start at 9:00 am","Lessons also run on Saturday morning","Lessons end at 3:00 pm","Lessons end at 3:30 pm on weekdays"]$mq$, 3, $mq$下午三点半放学 means school finishes at 3:30 pm. Lessons start at 8:00 am and there are none on Saturday or Sunday.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Time Words and Aspect Particles$mq$ and p.name = $mq$Mandarin Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$今天 / 明天 / 昨天$mq$, $mq$Today / tomorrow / yesterday: jīntiān / míngtiān / zuótiān. Time words go before the verb, after the subject.$mq$),
($mq$三点半 (sān diǎn bàn)$mq$, $mq$3:30. 半 means half. 3:15 is 三点一刻 (sān diǎn yí kè). Two o'clock is 两点, not 二点.$mq$),
($mq$了 (le)$mq$, $mq$Marks a completed action, placed after the verb: 我吃了早饭 (wǒ chī le zǎofàn): I ate breakfast.$mq$),
($mq$How do you make a past sentence negative?$mq$, $mq$Use 没 (méi) before the verb and drop 了: 我没吃早饭 (wǒ méi chī zǎofàn): I did not eat breakfast.$mq$),
($mq$过 (guo)$mq$, $mq$Shows past experience: 我去过北京 (wǒ qù guo Běijīng): I have been to Beijing. Negative: 我没去过北京.$mq$),
($mq$在 + verb (zài)$mq$, $mq$Shows an action in progress: 他在看书 (tā zài kàn shū): He is reading.$mq$),
($mq$要...了 (yào ... le)$mq$, $mq$Something is about to happen: 要下雨了 (yào xià yǔ le): It is going to rain.$mq$),
($mq$五月三日 (wǔ yuè sān rì)$mq$, $mq$3 May. Chinese dates run large to small: year, month, day. 月 is month and 日 is day.$mq$),
($mq$还没有 (hái méiyǒu)$mq$, $mq$Not yet. Used as a short answer: 你吃饭了吗？还没有。(Have you eaten? Not yet.)$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Time Words and Aspect Particles$mq$ and p.name = $mq$Mandarin Grammar Essentials$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why time words matter
Mandarin verbs do not change for past, present or future. Instead, time is shown by time words (like yesterday or tomorrow) and by small particles that show whether an action is finished, ongoing or experienced. Time words are among the most common clues in reading and listening texts.

## Key time words
- 今天 (jīntiān): today
- 明天 (míngtiān): tomorrow
- 昨天 (zuótiān): yesterday
- 现在 (xiànzài): now
- 每天 (měitiān): every day
- 早上 (zǎoshang): morning
- 下午 (xiàwǔ): afternoon
- 晚上 (wǎnshang): evening
- 今年 (jīnnián): this year; 去年 (qùnián): last year; 明年 (míngnián): next year
- 星期一 (xīngqīyī) to 星期六 (xīngqīliù): Monday to Saturday; 星期天 (xīngqītiān): Sunday

Time words go BEFORE the verb: 我明天去学校 (wǒ míngtiān qù xuéxiào, I am going to school tomorrow). If you use a time and a place, put the time first: 我今天在家学中文 (wǒ jīntiān zài jiā xué Zhōngwén).

## Telling the time
- 三点 (sān diǎn): 3:00
- 两点 (liǎng diǎn): 2:00 (use 两, not 二)
- 三点半 (sān diǎn bàn): 3:30
- 三点一刻 (sān diǎn yí kè): 3:15
- 三点十分 (sān diǎn shí fēn): 3:10

Dates go from large to small: 2026年10月9日 (èr líng èr liù nián shí yuè jiǔ rì). Month and day are written with 月 (yuè) and 日 (rì), or 号 (hào) when speaking.

## Aspect particles
**了 (le): completed action.** Put it after the verb: 我吃了早饭 (wǒ chī le zǎofàn, I ate breakfast). The negative drops 了 and uses 没: 我没吃早饭 (wǒ méi chī zǎofàn). Never write 没...了 on the same verb.

**过 (guo): past experience.** 我去过北京 (wǒ qù guo Běijīng, I have been to Beijing). The negative is 没...过: 我没去过北京 (wǒ méi qù guo Běijīng, I have never been to Beijing).

**在 (zài): action in progress.** Put it before the verb: 他在看书 (tā zài kàn shū, he is reading). Compare this with the place word 在, as in 他在家 (he is at home).

**要...了 (yào ... le): about to happen.** 要下雨了 (yào xià yǔ le): it is going to rain.

Useful extras: 已经 (yǐjīng, already), 还没有 (hái méiyǒu, not yet), 常常 (chángcháng, often).

## Common mistakes
- Putting the time word after the verb
- Using 不 instead of 没 for a past event
- Keeping 了 in a negative sentence
- Writing 二点 for two o'clock
- Confusing the date order with English day-month order

## How this is examined
Timetables, diary entries, invitations and messages test your ability to find the right time and day. A typical question asks what someone does at a given time, or whether something has already happened. The particle 了 and the word 没 are common clues about what is done and what is not.

Exam tip: Underline every time word in the text first, then match each one to its activity before you read the answer options.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('mandarin-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;