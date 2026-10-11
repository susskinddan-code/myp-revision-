-- Part 2 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Family and Friends > Family Members
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Family and Friends$mq$, 5, 2 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Family Members$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Family and Friends$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Family Members$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 爸爸 (bàba) mean?$mq$, $mq$["Dad","Mum","Older brother","Grandfather"]$mq$, 0, $mq$爸爸 means dad. Mum is 妈妈 (māma).$mq$, $mq$easy$mq$),
($mq$What does 妈妈 (māma) mean?$mq$, $mq$["Dad","Younger sister","Aunt","Mum"]$mq$, 3, $mq$妈妈 is mum. Notice the 女 (woman) part on the left of 妈.$mq$, $mq$easy$mq$),
($mq$What does 哥哥 (gēge) mean?$mq$, $mq$["Younger brother","Older sister","Older brother","Father"]$mq$, 2, $mq$哥哥 is an older brother. A younger brother is 弟弟 (dìdi).$mq$, $mq$easy$mq$),
($mq$What does 妹妹 (mèimei) mean?$mq$, $mq$["Older sister","Younger sister","Younger brother","Daughter"]$mq$, 1, $mq$妹妹 is a younger sister. An older sister is 姐姐 (jiějie).$mq$, $mq$easy$mq$),
($mq$What does 家 (jiā) mean?$mq$, $mq$["Home or family","School","Friend","Classroom"]$mq$, 0, $mq$家 means home and also family, as in 我家 (wǒ jiā), 'my family / my home'.$mq$, $mq$easy$mq$),
($mq$What does 弟弟 (dìdi) mean?$mq$, $mq$["Older brother","Younger sister","Uncle","Younger brother"]$mq$, 3, $mq$弟弟 is a younger brother. Compare 哥哥, older brother.$mq$, $mq$medium$mq$),
($mq$What does 我有一个姐姐 (wǒ yǒu yí gè jiějie) mean?$mq$, $mq$["I am an older sister","I have a younger sister","I have an older sister","I have two sisters"]$mq$, 2, $mq$有 means 'have', 一个 means 'one' and 姐姐 is an older sister.$mq$, $mq$medium$mq$),
($mq$How do you say 'I don't have an older brother'?$mq$, $mq$["我不有哥哥 (wǒ bù yǒu gēge)","我没有哥哥 (wǒ méiyǒu gēge)","我没哥哥有 (wǒ méi gēge yǒu)","我不是哥哥 (wǒ bú shì gēge)"]$mq$, 1, $mq$有 is negated with 没, giving 没有. 不有 is always wrong.$mq$, $mq$medium$mq$),
($mq$What does 我家有四口人 (wǒ jiā yǒu sì kǒu rén) mean?$mq$, $mq$["There are four people in my family","I have four brothers","My family has four rooms","I am four years old"]$mq$, 0, $mq$口 (kǒu) is the measure word used for family members, so 四口人 is 'four people in the family'.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 我家有五口人：爸爸、妈妈、哥哥、妹妹和我。(Wǒ jiā yǒu wǔ kǒu rén: bàba, māma, gēge, mèimei hé wǒ.) [和 = and]

How many brothers and sisters does the speaker have?$mq$, $mq$["3","4","5","2"]$mq$, 3, $mq$The siblings are one older brother (哥哥) and one younger sister (妹妹). Parents and the speaker are not counted.$mq$, $mq$medium$mq$),
($mq$How do you say 'I have two younger brothers'?$mq$, $mq$["我有二个弟弟 (wǒ yǒu èr gè dìdi)","我有两弟弟 (wǒ yǒu liǎng dìdi)","我有两个弟弟 (wǒ yǒu liǎng gè dìdi)","我有弟弟两个 (wǒ yǒu dìdi liǎng gè)"]$mq$, 2, $mq$Use 两 (liǎng) rather than 二 before a measure word, and keep the order number + measure word + noun.$mq$, $mq$medium$mq$),
($mq$What does 外婆 (wàipó) mean?$mq$, $mq$["Paternal grandmother (father's mother)","Maternal grandmother (mother's mother)","Aunt","Older sister"]$mq$, 1, $mq$外婆 is the mother's mother. The father's mother is 奶奶 (nǎinai).$mq$, $mq$medium$mq$),
($mq$Which word is a mother's father, rather than a father's father?$mq$, $mq$["外公 (wàigōng)","爷爷 (yéye)","爸爸 (bàba)","叔叔 (shūshu)"]$mq$, 0, $mq$外 (outside) marks the mother's side: 外公 is the mother's father and 外婆 is her mother. 爷爷 is the father's father.$mq$, $mq$medium$mq$),
($mq$Read: 我叫小林。我有一个姐姐，没有哥哥。我姐姐叫小美，她是学生。(Wǒ jiào Xiǎolín. Wǒ yǒu yí gè jiějie, méiyǒu gēge. Wǒ jiějie jiào Xiǎoměi, tā shì xuéshēng.)

Which statement is true?$mq$, $mq$["Xiaolin has one older brother and no sister","Xiaomei is Xiaolin's teacher","Xiaolin has two older sisters","Xiaolin has one older sister and no older brother"]$mq$, 3, $mq$The text says 有一个姐姐 and 没有哥哥, and that Xiaomei is a student.$mq$, $mq$hard$mq$),
($mq$Xiaohong says: 他是我爸爸的爸爸 (tā shì wǒ bàba de bàba). Who is he?$mq$, $mq$["外公 (wàigōng), her maternal grandfather","叔叔 (shūshu), her uncle","爷爷 (yéye), her paternal grandfather","哥哥 (gēge), her older brother"]$mq$, 2, $mq$'My dad's dad' is the paternal grandfather, 爷爷. 外公 is the mother's father.$mq$, $mq$hard$mq$),
($mq$What does 我没有兄弟姐妹 (wǒ méiyǒu xiōngdì jiěmèi) tell you?$mq$, $mq$["The speaker has only brothers","The speaker has no brothers or sisters","The speaker has many sisters","The speaker has no parents"]$mq$, 1, $mq$兄弟姐妹 means brothers and sisters. 没有 makes it negative, so the speaker is an only child.$mq$, $mq$hard$mq$),
($mq$The text says: 我有一个哥哥和两个妹妹 (wǒ yǒu yí gè gēge hé liǎng gè mèimei). How many siblings does the speaker have in total?$mq$, $mq$["3","2","4","12"]$mq$, 0, $mq$One older brother plus two younger sisters gives 1 + 2 = 3.$mq$, $mq$hard$mq$),
($mq$Which of these sentences contains a mistake?$mq$, $mq$["我没有妹妹 (wǒ méiyǒu mèimei)","我有一个弟弟 (wǒ yǒu yí gè dìdi)","我家有三口人 (wǒ jiā yǒu sān kǒu rén)","我不有姐姐 (wǒ bù yǒu jiějie)"]$mq$, 3, $mq$You cannot negate 有 with 不. The correct form is 我没有姐姐.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Family Members$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$爸爸 / 妈妈$mq$, $mq$bàba = dad; māma = mum.$mq$),
($mq$哥哥 / 弟弟$mq$, $mq$gēge = older brother; dìdi = younger brother.$mq$),
($mq$姐姐 / 妹妹$mq$, $mq$jiějie = older sister; mèimei = younger sister.$mq$),
($mq$爷爷 / 奶奶$mq$, $mq$yéye = father's father; nǎinai = father's mother.$mq$),
($mq$外公 / 外婆$mq$, $mq$wàigōng = mother's father; wàipó = mother's mother. 外 marks the mother's side.$mq$),
($mq$我有… / 我没有…$mq$, $mq$wǒ yǒu… = I have…; wǒ méiyǒu… = I don't have… Never 不有.$mq$),
($mq$我家有四口人$mq$, $mq$Wǒ jiā yǒu sì kǒu rén = There are four people in my family. 口 (kǒu) counts family members.$mq$),
($mq$两 (liǎng) vs 二 (èr)$mq$, $mq$Use 两 when counting things: 两个妹妹 (liǎng gè mèimei). Use 二 in number words such as 二十 (èrshí).$mq$),
($mq$兄弟姐妹$mq$, $mq$xiōngdì jiěmèi = brothers and sisters. 我没有兄弟姐妹 = I have no brothers or sisters.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Family Members$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Family words
Family vocabulary is among the most useful for beginners because Mandarin has separate words for older and younger siblings and for each side of the family.
- 爸爸 (bàba): dad
- 妈妈 (māma): mum
- 哥哥 (gēge): older brother
- 弟弟 (dìdi): younger brother
- 姐姐 (jiějie): older sister
- 妹妹 (mèimei): younger sister
- 爷爷 (yéye): paternal grandfather (father's father)
- 奶奶 (nǎinai): paternal grandmother (father's mother)
- 外公 (wàigōng): maternal grandfather (mother's father)
- 外婆 (wàipó): maternal grandmother (mother's mother)
- 叔叔 (shūshu): uncle (father's younger brother)
- 阿姨 (āyí): aunt, or a friendly name for a woman of your parents' age
- 兄弟姐妹 (xiōngdì jiěmèi): brothers and sisters
- 家 (jiā): home, family

## Having and not having
The verb 有 (yǒu) means "to have". 我有一个哥哥 (wǒ yǒu yí gè gēge) is "I have an older brother". The negative of 有 is 没有 (méiyǒu), never 不有: 我没有姐姐 (wǒ méiyǒu jiějie), "I don't have an older sister". Because 个 (gè) is a fourth tone, 一 changes to yí in 一个.

## Counting people
To say how many people are in a family use 口 (kǒu): 我家有四口人 (wǒ jiā yǒu sì kǒu rén), "There are four people in my family". Use 个 (gè) for siblings: 两个妹妹 (liǎng gè mèimei), "two younger sisters". Use 两 (liǎng) rather than 二 when you count things: 两个, not 二个. List members with 和 (hé, and) before the last item: 爸爸、妈妈和我 (bàba, māma hé wǒ).

## Reading the word structure
Doubled syllables such as 爸爸 and 哥哥 are typical for family terms, and the second syllable is often said in the neutral tone. Notice the radicals: many female relatives have 女 (woman) on the left, such as 妈, 姐 and 妹. This is a useful memory trick when characters look similar.

## Worked example
Read: 我家有五口人：爸爸、妈妈、哥哥、妹妹和我 (wǒ jiā yǒu wǔ kǒu rén: bàba, māma, gēge, mèimei hé wǒ). This says there are five people in the family. The speaker has two siblings, one older brother and one younger sister.

## Common mistakes
- Writing 不有 instead of 没有.
- Saying 二个 instead of 两个.
- Mixing up 哥哥 and 弟弟, or 姐姐 and 妹妹. The first of each pair is older.
- Forgetting the 外 in 外公 and 外婆, which marks the mother's side.
- Forgetting the measure word between the number and the noun.

## How this is examined
Family vocabulary appears in short texts where someone introduces their family, in family trees described in a few lines, and in listening clips. Typical questions ask how many people are in a family, who a relative is, or whether the speaker has brothers or sisters. In writing, you may describe your family in four or five sentences.

Exam tip: Draw a quick family diagram while you read or listen, marking older and younger siblings and parents' sides. Many wrong answers come from counting the speaker as a sibling or missing a 没有.$mq$ from st;

-- Family and Friends > Describing People
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Family and Friends$mq$, 5, 2 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Describing People$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Family and Friends$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Describing People$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 高 (gāo) mean?$mq$, $mq$["Tall","Short","Fat","Thin"]$mq$, 0, $mq$高 means tall (or high). Its opposite is 矮 (ǎi), short in height.$mq$, $mq$easy$mq$),
($mq$What does 矮 (ǎi) mean?$mq$, $mq$["Tall","Long","Young","Short (in height)"]$mq$, 3, $mq$矮 describes a person's height. Short hair uses 短 (duǎn).$mq$, $mq$easy$mq$),
($mq$What does 漂亮 (piàoliang) mean?$mq$, $mq$["Clever","Quiet","Pretty","Old"]$mq$, 2, $mq$漂亮 means pretty or beautiful. Clever is 聪明 (cōngming).$mq$, $mq$easy$mq$),
($mq$What does 聪明 (cōngming) mean?$mq$, $mq$["Funny","Clever","Friendly","Tall"]$mq$, 1, $mq$聪明 means clever or smart. Funny or interesting is 有趣 (yǒuqù).$mq$, $mq$easy$mq$),
($mq$What does 头发 (tóufa) mean?$mq$, $mq$["Hair","Eyes","Hand","Face"]$mq$, 0, $mq$头发 means hair on the head. Eyes are 眼睛 (yǎnjing).$mq$, $mq$easy$mq$),
($mq$What does 她很高 (tā hěn gāo) mean?$mq$, $mq$["She is not tall","She is a teacher","She is taller than me","She is very tall"]$mq$, 3, $mq$很 (hěn) is placed before an adjective. In plain statements it often just means 'is' rather than a strong 'very'.$mq$, $mq$medium$mq$),
($mq$How do you say 'He is tall' in Mandarin?$mq$, $mq$["他是高 (tā shì gāo)","他高很 (tā gāo hěn)","他很高 (tā hěn gāo)","他是很高 (tā shì hěn gāo)"]$mq$, 2, $mq$Adjectives work as verbs in Chinese, so you do not use 是 before them. 很 comes before the adjective.$mq$, $mq$medium$mq$),
($mq$What does 他不高 (tā bù gāo) mean?$mq$, $mq$["He is very tall","He is not tall","He is not a teacher","He is short and thin"]$mq$, 1, $mq$不 negates the adjective directly: 不高 means not tall.$mq$, $mq$medium$mq$),
($mq$What does 我的头发很短 (wǒ de tóufa hěn duǎn) mean?$mq$, $mq$["My hair is short","My hair is long","My hair is black","My eyes are small"]$mq$, 0, $mq$短 means short in length and 长 (cháng) means long. 头发 is hair.$mq$, $mq$medium$mq$),
($mq$What does 她的眼睛是蓝色的 (tā de yǎnjing shì lánsè de) say?$mq$, $mq$["Her hair is blue","She is wearing blue","Her eyes are small","Her eyes are blue"]$mq$, 3, $mq$眼睛 is eyes, 蓝色 (lánsè) is blue and the structure 是…的 follows the colour.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 我的朋友小刚很高，也很瘦。他的头发很短，眼睛很大。他很友好。(Wǒ de péngyou Xiǎogāng hěn gāo, yě hěn shòu. Tā de tóufa hěn duǎn, yǎnjing hěn dà. Tā hěn yǒuhǎo.) [瘦 = thin, 友好 = friendly]

Which description matches Xiaogang?$mq$, $mq$["Short, fat, long hair, small eyes","Tall, thin, long hair, friendly","Tall, thin, short hair, big eyes, friendly","Short, thin, short hair, quiet"]$mq$, 2, $mq$The text says 高, 瘦, 头发很短, 眼睛很大 and 友好.$mq$, $mq$medium$mq$),
($mq$What is the opposite of 长 (cháng) when describing hair?$mq$, $mq$["高 (gāo)","短 (duǎn)","矮 (ǎi)","大 (dà)"]$mq$, 1, $mq$长 means long and 短 means short in length. 矮 is for height only.$mq$, $mq$medium$mq$),
($mq$What does 她不太高 (tā bú tài gāo) mean?$mq$, $mq$["She is not very tall","She is extremely tall","She is not at all short","She is taller than me"]$mq$, 0, $mq$不太 means 'not very'. 非常 (fēicháng) means 'extremely'.$mq$, $mq$medium$mq$),
($mq$What does 我哥哥很高，但是我很矮 (wǒ gēge hěn gāo, dànshì wǒ hěn ǎi) mean?$mq$, $mq$["My brother and I are both tall","My brother is short, but I am tall","My older brother is taller than the teacher","My older brother is tall, but I am short"]$mq$, 3, $mq$但是 (dànshì) means 'but' and shows a contrast between 高 and 矮.$mq$, $mq$hard$mq$),
($mq$Read: 我的老师姓王，她不高也不矮。她的头发很长。她很有趣，也很聪明。(Wǒ de lǎoshī xìng Wáng, tā bù gāo yě bù ǎi. Tā de tóufa hěn cháng. Tā hěn yǒuqù, yě hěn cōngming.)

Which statement is true?$mq$, $mq$["Teacher Wang is tall with short hair","Teacher Wang is short and shy","Teacher Wang is average height, has long hair, and is funny and clever","Teacher Wang is tall, clever and quiet"]$mq$, 2, $mq$不高也不矮 means neither tall nor short. The text also says long hair, funny (有趣) and clever.$mq$, $mq$hard$mq$),
($mq$Which sentence contains a mistake?$mq$, $mq$["她很漂亮 (tā hěn piàoliang)","她是很漂亮 (tā shì hěn piàoliang)","她不漂亮 (tā bú piàoliang)","她非常漂亮 (tā fēicháng piàoliang)"]$mq$, 1, $mq$Do not use 是 before an adjective. The correct sentence is 她很漂亮.$mq$, $mq$hard$mq$),
($mq$Which is the correct pinyin with tone marks for 漂亮?$mq$, $mq$["piàoliang","piāoliàng","piàoliáng","piǎoliang"]$mq$, 0, $mq$漂亮 is fourth tone on 漂 (piào) and the second syllable is neutral, so piàoliang.$mq$, $mq$hard$mq$),
($mq$Read: 小丽的头发不长也不短，眼睛是黑色的。(Xiǎolì de tóufa bù cháng yě bù duǎn, yǎnjing shì hēisè de.)

What do we learn about Xiaoli?$mq$, $mq$["Her hair is long and her eyes are black","Her hair is short and her eyes are blue","Her hair is medium length and her eyes are blue","Her hair is medium length and her eyes are black"]$mq$, 3, $mq$不长也不短 means neither long nor short, so medium length. 黑色 is black.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Describing People$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$高 / 矮$mq$, $mq$gāo = tall; ǎi = short in height. Use 短 (duǎn) for short hair.$mq$),
($mq$长 / 短$mq$, $mq$cháng = long; duǎn = short in length, for hair and so on.$mq$),
($mq$漂亮 / 帅$mq$, $mq$piàoliang = pretty; shuài = handsome.$mq$),
($mq$聪明 / 友好 / 有趣$mq$, $mq$cōngming = clever; yǒuhǎo = friendly; yǒuqù = fun or interesting.$mq$),
($mq$他很高 (not 他是高)$mq$, $mq$Tā hěn gāo = He is tall. Adjectives do not take 是; use 很 before them.$mq$),
($mq$不 / 不太 / 非常$mq$, $mq$bù = not; bú tài = not very; fēicháng = extremely. For example 她不太高 = she isn't very tall.$mq$),
($mq$但是 (dànshì)$mq$, $mq$But. Example: 我很高，但是他很矮 (wǒ hěn gāo, dànshì tā hěn ǎi) = I am tall but he is short.$mq$),
($mq$不高也不矮$mq$, $mq$bù gāo yě bù ǎi = neither tall nor short, of average height.$mq$),
($mq$她的眼睛是蓝色的$mq$, $mq$Tā de yǎnjing shì lánsè de = Her eyes are blue. 色 (sè) follows colours: 黑色 black, 棕色 brown.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Describing People$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Describing appearance
To describe a person, use an adjective. In Mandarin the adjective works like a verb, so you do not need the word 是 ("is"). Compare 他很高 (tā hěn gāo), "He is tall", with the wrong 他是高. Always put 很 (hěn) before the adjective in a simple sentence. It is not strongly "very" here, it just makes the sentence sound complete. For the real meaning "very" say 非常 (fēicháng), and for "not very" use 不太 (bú tài).

## Useful adjectives
- 高 (gāo): tall
- 矮 (ǎi): short in height
- 胖 (pàng): plump
- 瘦 (shòu): thin
- 年轻 (niánqīng): young
- 老 (lǎo): old
- 漂亮 (piàoliang): pretty
- 帅 (shuài): handsome
- 可爱 (kě'ài): cute
- 长 (cháng): long
- 短 (duǎn): short in length
- 大 (dà): big
- 小 (xiǎo): small

## Personality
- 聪明 (cōngming): clever
- 友好 (yǒuhǎo): friendly
- 有趣 (yǒuqù): fun, interesting
- 安静 (ānjìng): quiet
- 害羞 (hàixiū): shy

## Hair and eyes
Say 她的头发很长 (tā de tóufa hěn cháng), "Her hair is long". For colour use 色 (sè) after a colour word: 黑色 (hēisè, black), 棕色 (zōngsè, brown), 黄色 (huángsè, yellow) and 蓝色 (lánsè, blue). To describe eyes: 她的眼睛是蓝色的 (tā de yǎnjing shì lánsè de), "Her eyes are blue". Here 是…的 is used because a colour is a noun-like phrase.

## Joining ideas
- 和 (hé): and, between nouns only
- 也 (yě): also, before the adjective: 她也很高
- 但是 (dànshì): but: 我很高，但是我哥哥很矮.
- 不高也不矮 (bù gāo yě bù ǎi): neither tall nor short, meaning average height

## Making negatives
Put 不 before the adjective: 他不高 (tā bù gāo). With 太 add 不太: 他不太高 (tā bú tài gāo), "He is not very tall". 不 changes to bú before a fourth tone, which is why you write bú tài.

## Worked example
我的朋友小刚很高，也很瘦 (wǒ de péngyou Xiǎogāng hěn gāo, yě hěn shòu). This tells us Xiaogang is tall and also thin. The word 也 shows a second feature, so you do not need 是.

## Common mistakes
- Using 是 before an adjective (她是很漂亮 is wrong).
- Forgetting 很 in simple statements.
- Using 矮 for short hair (use 短).
- Using 和 to join two adjectives. Use 也 or just repeat 很.

## How this is examined
Descriptions are typically examined through short texts about friends, family or a lost person at an airport or school. You may match a description to the right person, tick the true statements, or decide whether a statement is true or false. In writing, a good answer describes someone's looks and character with at least two adjectives joined by 也 or 但是.

Exam tip: Underline every adjective and then look for 不, 不太 and 也. A single 不 can reverse the meaning of a whole sentence, and 但是 signals a contrast.$mq$ from st;

-- Family and Friends > Pets and Possessions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Family and Friends$mq$, 5, 2 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Pets and Possessions$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$Family and Friends$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Pets and Possessions$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 猫 (māo) mean?$mq$, $mq$["Cat","Dog","Fish","Bird"]$mq$, 0, $mq$猫 is a cat. A dog is 狗 (gǒu).$mq$, $mq$easy$mq$),
($mq$What does 狗 (gǒu) mean?$mq$, $mq$["Cat","Rabbit","Horse","Dog"]$mq$, 3, $mq$狗 means dog. Many pet words include a 犭 or 鱼 part that hints at animals or fish.$mq$, $mq$easy$mq$),
($mq$What does 鱼 (yú) mean?$mq$, $mq$["Bird","Book","Fish","Bag"]$mq$, 2, $mq$鱼 means fish. A bird is 鸟 (niǎo).$mq$, $mq$easy$mq$),
($mq$What does 书 (shū) mean?$mq$, $mq$["Pen","Book","Bag","Phone"]$mq$, 1, $mq$书 is a book. The measure word for books is 本 (běn).$mq$, $mq$easy$mq$),
($mq$What does 手机 (shǒujī) mean?$mq$, $mq$["Mobile phone","Computer","Hand","Bicycle"]$mq$, 0, $mq$手机 literally means 'hand machine', a mobile phone. A computer is 电脑 (diànnǎo).$mq$, $mq$easy$mq$),
($mq$What does 我有一只猫 (wǒ yǒu yì zhī māo) mean?$mq$, $mq$["I have a dog","I like cats","I am a cat","I have a cat"]$mq$, 3, $mq$一只 is 'one' plus the measure word for small animals, and 猫 means cat.$mq$, $mq$medium$mq$),
($mq$Which measure word fits: 一___书 (yì ___ shū), 'a book'?$mq$, $mq$["只 (zhī)","条 (tiáo)","本 (běn)","辆 (liàng)"]$mq$, 2, $mq$本 is the measure word for books and bound items. 只 is for many animals and 辆 is for vehicles.$mq$, $mq$medium$mq$),
($mq$Which measure word fits: 三___鱼 (sān ___ yú), 'three fish'?$mq$, $mq$["本 (běn)","条 (tiáo)","辆 (liàng)","台 (tái)"]$mq$, 1, $mq$条 is used for long, thin things such as fish, roads and rivers.$mq$, $mq$medium$mq$),
($mq$What does 我没有宠物 (wǒ méiyǒu chǒngwù) mean?$mq$, $mq$["I don't have any pets","I like pets","I have two pets","I have a pet cat"]$mq$, 0, $mq$宠物 (chǒngwù) means pet and 没有 means don't have.$mq$, $mq$medium$mq$),
($mq$What does 她有两只小鸟 (tā yǒu liǎng zhī xiǎo niǎo) mean?$mq$, $mq$["She has two big cats","She has a small bird","She has two fish","She has two small birds"]$mq$, 3, $mq$两只 is 'two' with the animal measure word, 小 is small and 鸟 is bird.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 我的宠物是一只狗。它叫旺旺。它很可爱，也很聪明。(Wǒ de chǒngwù shì yì zhī gǒu. Tā jiào Wàngwang. Tā hěn kě'ài, yě hěn cōngming.) [它 = it]

What is the dog's name?$mq$, $mq$["Kě'ài","Cōngming","Wangwang","Xiǎogǒu"]$mq$, 2, $mq$它叫旺旺 means 'It is called Wangwang'. 可爱 and 聪明 are adjectives, not a name.$mq$, $mq$medium$mq$),
($mq$What does 这是小明的书 (zhè shì Xiǎomíng de shū) mean?$mq$, $mq$["Xiaoming is a book","This is Xiaoming's book","I have Xiaoming's book","This is a book for Xiaoming's teacher"]$mq$, 1, $mq$的 (de) after a name shows possession, like 's in English.$mq$, $mq$medium$mq$),
($mq$How do you say 'I have a bicycle'?$mq$, $mq$["我有一辆自行车 (wǒ yǒu yí liàng zìxíngchē)","我有一只自行车 (wǒ yǒu yì zhī zìxíngchē)","我有一本自行车 (wǒ yǒu yì běn zìxíngchē)","我有自行车一辆 (wǒ yǒu zìxíngchē yí liàng)"]$mq$, 0, $mq$辆 (liàng) is the measure word for vehicles including bicycles, and the order is number + measure word + noun.$mq$, $mq$medium$mq$),
($mq$The text says: 我有两只猫和三条鱼 (wǒ yǒu liǎng zhī māo hé sān tiáo yú). How many animals does the speaker have?$mq$, $mq$["2","3","23","5"]$mq$, 3, $mq$Two cats plus three fish gives 2 + 3 = 5 animals.$mq$, $mq$hard$mq$),
($mq$Read: 我哥哥有一台电脑，没有手机。我有手机，但是没有电脑。(Wǒ gēge yǒu yì tái diànnǎo, méiyǒu shǒujī. Wǒ yǒu shǒujī, dànshì méiyǒu diànnǎo.) [台 = measure word for machines]

Who has a mobile phone?$mq$, $mq$["The older brother only","Both of them","The writer only","Neither of them"]$mq$, 2, $mq$The brother has a computer but no phone; the writer has a phone but no computer.$mq$, $mq$hard$mq$),
($mq$Which sentence is missing a measure word?$mq$, $mq$["我有三只猫 (wǒ yǒu sān zhī māo)","我有三猫 (wǒ yǒu sān māo)","我有一条鱼 (wǒ yǒu yì tiáo yú)","我有两本书 (wǒ yǒu liǎng běn shū)"]$mq$, 1, $mq$In Mandarin a number must be followed by a measure word before the noun: 三只猫.$mq$, $mq$hard$mq$),
($mq$Read: 小丽的兔子叫雪雪。它是白色的，很小。(Xiǎolì de tùzi jiào Xuěxue. Tā shì báisè de, hěn xiǎo.) [白色 = white]

Which description fits Xuexue?$mq$, $mq$["A small white rabbit","A big white dog","A small black cat","A white bird"]$mq$, 0, $mq$兔子 is a rabbit, 白色 is white and 很小 means small.$mq$, $mq$hard$mq$),
($mq$Transcript: 大卫: 这是你的书包吗？(Dàwèi: Zhè shì nǐ de shūbāo ma?) 玲玲: 不是，这不是我的书包，这是小明的。(Línglíng: Bú shì, zhè bú shì wǒ de shūbāo, zhè shì Xiǎomíng de.)

Whose school bag is it?$mq$, $mq$["Lingling's","David's","Nobody's","Xiaoming's"]$mq$, 3, $mq$Lingling says it is not hers (不是我的) and that it belongs to Xiaoming (小明的).$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Pets and Possessions$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$猫 / 狗 / 鱼 / 鸟$mq$, $mq$māo = cat; gǒu = dog; yú = fish; niǎo = bird.$mq$),
($mq$宠物 (chǒngwù)$mq$, $mq$Pet. 我没有宠物 (wǒ méiyǒu chǒngwù) = I don't have a pet.$mq$),
($mq$只 (zhī)$mq$, $mq$Measure word for small animals: 一只猫 (yì zhī māo), a cat; 两只鸟 (liǎng zhī niǎo), two birds.$mq$),
($mq$条 (tiáo)$mq$, $mq$Measure word for long, thin things such as fish: 三条鱼 (sān tiáo yú) = three fish.$mq$),
($mq$本 (běn)$mq$, $mq$Measure word for books: 一本书 (yì běn shū) = a book.$mq$),
($mq$辆 / 台$mq$, $mq$辆 (liàng) for vehicles: 一辆自行车 (a bicycle); 台 (tái) for machines: 一台电脑 (a computer).$mq$),
($mq$手机 / 电脑 / 书包$mq$, $mq$shǒujī = mobile phone; diànnǎo = computer; shūbāo = school bag.$mq$),
($mq$的 (de)$mq$, $mq$Shows belonging, like 's: 小明的书 (Xiǎomíng de shū) = Xiaoming's book; 我的猫 = my cat.$mq$),
($mq$它叫旺旺$mq$, $mq$Tā jiào Wàngwang = It is called Wangwang. 它 (tā) means 'it' for animals and things.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Pets and Possessions$mq$ and p.name = $mq$Family and Friends$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Pets
Talking about pets is a common beginner topic, and it is a good way to practise measure words. A pet is 宠物 (chǒngwù).
- 猫 (māo): cat
- 狗 (gǒu): dog
- 鱼 (yú): fish
- 鸟 (niǎo): bird
- 兔子 (tùzi): rabbit
- 仓鼠 (cāngshǔ): hamster
- 马 (mǎ): horse

Say what you have with 有: 我有一只狗 (wǒ yǒu yì zhī gǒu), "I have a dog". Say you have none with 没有: 我没有宠物 (wǒ méiyǒu chǒngwù), "I don't have a pet". Give the name with 叫: 它叫旺旺 (tā jiào Wàngwang), "It is called Wangwang". For animals the word for "it" is 它 (tā).

## Measure words
Mandarin needs a measure word between a number and a noun. You must choose the right one.
- 只 (zhī): small animals such as cats, birds and rabbits: 两只猫 (liǎng zhī māo)
- 条 (tiáo): long, thin things such as fish: 三条鱼 (sān tiáo yú)
- 本 (běn): books: 一本书 (yì běn shū)
- 辆 (liàng): vehicles and bicycles: 一辆自行车 (yí liàng zìxíngchē)
- 台 (tái): machines such as computers: 一台电脑 (yì tái diànnǎo)
- 个 (gè): general measure word for many things: 一个手机 (yí gè shǒujī)

The order is always number + measure word + noun. With two, use 两 (liǎng), not 二.

## Possessions
- 书包 (shūbāo): school bag
- 手机 (shǒujī): mobile phone
- 电脑 (diànnǎo): computer
- 自行车 (zìxíngchē): bicycle
- 笔 (bǐ): pen

## Saying whose it is
Use 的 (de), like 's in English. 小明的书 (Xiǎomíng de shū) is "Xiaoming's book" and 我的猫 (wǒ de māo) is "my cat". To answer "Is this your bag?" say 不是，这不是我的书包 (bú shì, zhè bú shì wǒ de shūbāo), "No, this isn't my bag". You can drop the noun if it is clear: 这是小明的 (zhè shì Xiǎomíng de), "This is Xiaoming's".

## Adding description
Use adjectives from the last topic: 我的狗很可爱 (wǒ de gǒu hěn kě'ài), "My dog is very cute". Colours work with 色 (sè): 白色 (báisè, white), 黑色 (hēisè, black).

## Worked example
我有两只猫和三条鱼 (wǒ yǒu liǎng zhī māo hé sān tiáo yú). Cats use 只 and fish use 条, so the sentence is right. Altogether 2 + 3 = 5 animals.

## Common mistakes
- Leaving out the measure word (我有三猫 is wrong).
- Using 只 for books or 本 for animals.
- Using 二 instead of 两 before a measure word.
- Mixing up 不是 and 没有. Use 是 for "to be" and 有 for "to have".

## How this is examined
Pets and possessions turn up in short descriptions of a bedroom, lost-property notices and message exchanges. You might be asked what animals someone owns, how many, or who a bag belongs to. In writing you can describe a pet in three or four sentences using a number, measure word, name and adjective.

Exam tip: Treat measure words as clues. 只 usually signals an animal, 本 a book and 辆 a vehicle, so you can often guess the noun even if it is a new word.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('mandarin-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;