-- Part 9 of 9: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- eAssessment Skills for Languages > Reading Comprehension Strategies
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Languages$mq$, 5, 9 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Reading Comprehension Strategies$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Languages$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Reading Comprehension Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$You open a reading task in Mandarin. What is the best first step?$mq$, $mq$["Read the questions and skim the text type and title before reading in detail","Translate every character one by one","Ignore characters you do not know and guess every answer","Read only the last line of the text"]$mq$, 0, $mq$Skimming the title, text type and questions first tells you who is writing, why, and what details to look for. Word-by-word translation wastes time.$mq$, $mq$easy$mq$),
($mq$You are looking for the way out of a building. Which sign do you follow?$mq$, $mq$["入口 (rùkǒu)","洗手间 (xǐshǒujiān)","电梯 (diàntī)","出口 (chūkǒu)"]$mq$, 3, $mq$出口 means exit, 入口 means entrance, 洗手间 means toilet and 电梯 means lift. The character 出 means 'to go out'.$mq$, $mq$easy$mq$),
($mq$Characters such as 妈 (mā), 姐 (jiě) and 妹 (mèi) share the component 女 (nǚ, woman). What does this suggest about their meaning?$mq$, $mq$["They are about water","They are about food","They are about female relatives","They are about hands"]$mq$, 2, $mq$Many Chinese characters contain a part that hints at meaning. 女 often appears in words for women and female family members.$mq$, $mq$easy$mq$),
($mq$Read: 我有一个哥哥和两个姐姐 (wǒ yǒu yí ge gēge hé liǎng ge jiějie). How many older brothers and sisters does the writer have in total?$mq$, $mq$["2","3","4","1"]$mq$, 1, $mq$One older brother plus two older sisters makes three. Add the numbers attached to each measure word.$mq$, $mq$easy$mq$),
($mq$A question asks 'When does the film start?' Which type of words should you look for in the text?$mq$, $mq$["Time words such as 点 or 星期","Family words such as 妈妈","Food words such as 面条","Colour words such as 红"]$mq$, 0, $mq$Match the question word to the type of detail: 'when' means a time or day, such as 七点 (qī diǎn) or 星期六 (xīngqīliù).$mq$, $mq$easy$mq$),
($mq$Read: 小美，我今天不去学校，因为我头疼。明天见！(Xiǎoměi, wǒ jīntiān bú qù xuéxiào, yīnwèi wǒ tóu téng. Míngtiān jiàn!) Why is the writer not going to school today?$mq$, $mq$["The writer has a test","It is a holiday","The writer is visiting a friend","The writer has a headache"]$mq$, 3, $mq$因为 (yīnwèi) means 'because', and the reason follows it: 头疼 means headache. 不去 means is not going.$mq$, $mq$medium$mq$),
($mq$Read: 我不喜欢咖啡，我喜欢茶 (wǒ bù xǐhuan kāfēi, wǒ xǐhuan chá). What does the writer like?$mq$, $mq$["Coffee","Both tea and coffee","Tea","Neither tea nor coffee"]$mq$, 2, $mq$不喜欢 means does not like, so coffee is a distractor. The writer likes tea.$mq$, $mq$medium$mq$),
($mq$Read a menu: 牛肉面 25 元 (niúròu miàn, 25 yuan)，鸡蛋炒饭 18 元 (jīdàn chǎofàn, 18 yuan)，红茶 8 元 (hóngchá, 8 yuan). How much do fried rice with egg and one black tea cost together?$mq$, $mq$["33 yuan","26 yuan","43 yuan","51 yuan"]$mq$, 1, $mq$18 + 8 = 26. 33 would be the beef noodles with tea, and 51 is all three items together.$mq$, $mq$medium$mq$),
($mq$Read: 电影七点半开始，九点半结束 (diànyǐng qī diǎn bàn kāishǐ, jiǔ diǎn bàn jiéshù). How long is the film?$mq$, $mq$["2 hours","1 hour","2 and a half hours","9 and a half hours"]$mq$, 0, $mq$开始 (kāishǐ) is start and 结束 (jiéshù) is finish. From 7:30 to 9:30 is 2 hours.$mq$, $mq$medium$mq$),
($mq$Read: 妈妈在厨房做饭 (māma zài chúfáng zuò fàn). You do not know 厨房. What does the context suggest it means?$mq$, $mq$["Bedroom","School","Park","Kitchen"]$mq$, 3, $mq$做饭 means cooking, and the place where Mum is cooking is most likely the kitchen. Using context is a core reading strategy.$mq$, $mq$medium$mq$),
($mq$Read: 王老师：我星期三不能来上课，因为我要去医院。谢谢！小刚 (Wáng lǎoshī: wǒ xīngqīsān bù néng lái shàngkè, yīnwèi wǒ yào qù yīyuàn. Xièxie! Xiǎogāng). What is Xiaogang telling the teacher?$mq$, $mq$["He cannot come on Thursday because he has a test","He is coming early on Wednesday to see the doctor","He cannot come to class on Wednesday because he is going to the hospital","The teacher must go to the hospital on Wednesday"]$mq$, 2, $mq$The writer signs at the end (小刚). 不能来上课 means cannot come to class, 星期三 is Wednesday and 医院 is hospital.$mq$, $mq$medium$mq$),
($mq$Read: 我星期一和星期二有数学课，星期三有英语课 (wǒ xīngqīyī hé xīngqī'èr yǒu shùxué kè, xīngqīsān yǒu Yīngyǔ kè). On which days does the writer have maths?$mq$, $mq$["Tuesday and Wednesday","Monday and Tuesday","Monday and Wednesday","Wednesday only"]$mq$, 1, $mq$数学 is maths. It is linked to 星期一和星期二, which is Monday and Tuesday. English is on Wednesday.$mq$, $mq$medium$mq$),
($mq$Read: 我家在北京，但是我现在在上海学习中文 (wǒ jiā zài Běijīng, dànshì wǒ xiànzài zài Shànghǎi xuéxí Zhōngwén). Where is the writer studying Chinese now?$mq$, $mq$["Shanghai","Beijing","London","Hong Kong"]$mq$, 0, $mq$但是 (dànshì, but) signals a contrast. The home is in Beijing, but 现在 (now) the writer is studying in Shanghai.$mq$, $mq$medium$mq$),
($mq$Read: 她的房间里有一张床、一张桌子和两把椅子 (tā de fángjiān lǐ yǒu yì zhāng chuáng, yì zhāng zhuōzi hé liǎng bǎ yǐzi). How many pieces of furniture are in her room?$mq$, $mq$["3","2","5","4"]$mq$, 3, $mq$One bed, one table and two chairs make four. Counting the nouns, not just the number words, avoids the trap of answering 3.$mq$, $mq$hard$mq$),
($mq$Read: 周末我和朋友去公园。我们先打羽毛球，然后吃午饭，下午四点回家 (zhōumò wǒ hé péngyou qù gōngyuán. wǒmen xiān dǎ yǔmáoqiú, ránhòu chī wǔfàn, xiàwǔ sì diǎn huí jiā). What is the order of events?$mq$, $mq$["Lunch, then badminton, then home","Home, then badminton, then lunch","Badminton, then lunch, then home","Badminton, then home, then lunch"]$mq$, 2, $mq$先 (xiān) means first and 然后 (ránhòu) means then. The writer plays badminton first, has lunch, then goes home at 4 pm.$mq$, $mq$hard$mq$),
($mq$Read: 我喜欢夏天，因为我可以去游泳 (wǒ xǐhuan xiàtiān, yīnwèi wǒ kěyǐ qù yóuyǒng). Which statement matches the text?$mq$, $mq$["The writer likes summer because it is hot","The writer likes summer and can go swimming then","The writer likes winter and cannot swim","The writer swims every day in summer"]$mq$, 1, $mq$Only choose what the text actually says. Heat and 'every day' are not mentioned, so those options add information.$mq$, $mq$hard$mq$),
($mq$Read: 一杯奶茶十五块，两杯二十八块 (yì bēi nǎichá shíwǔ kuài, liǎng bēi èrshíbā kuài). How much do you save by buying two cups together instead of buying two single cups?$mq$, $mq$["2 kuài","1 kuài","3 kuài","5 kuài"]$mq$, 0, $mq$Two single cups cost 2 × 15 = 30 kuài. The two-cup price is 28 kuài, so you save 30 − 28 = 2 kuài.$mq$, $mq$hard$mq$),
($mq$Read: 昨天我没去上学，因为我生病了。今天我好了，明天我要去学校 (zuótiān wǒ méi qù shàngxué, yīnwèi wǒ shēngbìng le. jīntiān wǒ hǎo le, míngtiān wǒ yào qù xuéxiào). Which statement is true?$mq$, $mq$["The writer went to school yesterday and is ill today","The writer was ill yesterday and will stay home tomorrow","The writer is ill today and missed school yesterday","The writer missed school yesterday, is better today and will go tomorrow"]$mq$, 3, $mq$没去 means did not go, 生病了 means became ill, 好了 means is well now and 明天要去 means will go tomorrow. Track each time word.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Reading Comprehension Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$First step in a reading task$mq$, $mq$Read the questions, then skim the title, text type and writer. This tells you what to look for before you read in detail.$mq$),
($mq$出口 (chūkǒu) / 入口 (rùkǒu)$mq$, $mq$Exit / entrance. 出 means go out and 入 means go in. Common on signs in reading tasks.$mq$),
($mq$因为 (yīnwèi)$mq$, $mq$Because. The reason follows it: 我不去学校，因为我头疼 (I am not going to school because I have a headache).$mq$),
($mq$但是 (dànshì) and 可是 (kěshì)$mq$, $mq$Both mean but. The real answer often comes after them: 我家在北京，但是我现在在上海 (My home is in Beijing, but now I am in Shanghai).$mq$),
($mq$先 (xiān), 然后 (ránhòu), 最后 (zuìhòu)$mq$, $mq$First, then, finally. They show the order of events in a text.$mq$),
($mq$What do 不 (bù) and 没 (méi) do in a text?$mq$, $mq$They make the verb negative and reverse the meaning. 不喜欢 means does not like. Circle them before answering.$mq$),
($mq$Unknown character strategy$mq$, $mq$Use context, look for meaning components such as 女 in 妈/姐/妹, check the measure word, and read any pinyin or English glosses given.$mq$),
($mq$块 (kuài) and 元 (yuán)$mq$, $mq$Both mean yuan, the unit of money. 块 is spoken and 元 is written: 十五块 (shíwǔ kuài) or 15 元.$mq$),
($mq$Matching question words to clues$mq$, $mq$When: 点, 星期. Where: 在, 去. Why: 因为. How much: 块, 元. Who: names, family words.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Reading Comprehension Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What reading tasks look like
In an on-screen language acquisition exam, reading tasks give you short, everyday texts: messages, emails, notices, menus, timetables and short stories. You answer multiple-choice or short questions. At beginner level the texts are short, but the questions often hide traps, so a calm strategy is more useful than knowing every word.

## Step 1: Get the big picture
Before you read closely:
- Look at the title, the text type (message, menu, timetable) and who is writing to whom
- Read the questions first, so you know what to look for
- Skim the text once for the general topic

Example: for 小美，我今天不去学校 (Xiǎoměi, wǒ jīntiān bú qù xuéxiào) you can already see it is a personal message, because it opens with a name.

## Step 2: Match question words to detail types
- When: look for 点 (diǎn), 星期 (xīngqī), 今天 (jīntiān), 明天 (míngtiān)
- Where: look for 在 (zài), 去 (qù), and place nouns such as 学校 (xuéxiào) and 公园 (gōngyuán)
- How much: look for numbers with 块 (kuài) or 元 (yuán)
- Why: look for 因为 (yīnwèi, because)
- Who: look for names and family words such as 妈妈 and 哥哥

## Step 3: Use clues for unknown words
You will meet characters you do not know. Do not panic.
- **Context**: in 妈妈在厨房做饭, the word 做饭 (cooking) suggests 厨房 is the kitchen.
- **Components**: 女 often appears in female relatives (妈, 姐, 妹); 氵 appears in water words (河, 湖); 饣 appears in food words.
- **Measure words**: 一张 suggests a flat object, 一只 suggests an animal.
- **Pinyin or English glosses**, when given, are there to help.

## Step 4: Watch for traps
- **Negatives**: 不 (bù) and 没 (méi) reverse the meaning. 我不喜欢咖啡 means I do NOT like coffee.
- **Contrast words**: 但是 (dànshì, but) and 可是 (kěshì, but) often introduce the real answer.
- **Several numbers**: texts give times, prices and quantities. Always check which number belongs to which item.
- **Order words**: 先 (first), 然后 (then), 最后 (finally) tell you the sequence.
- **Adding extra information**: choose only what the text says, not what seems likely.

## Step 5: Do the arithmetic carefully
Questions may ask you to add prices or work out the length of an event. Write the sum: 18 + 8 = 26 yuan, or 7:30 to 9:30 is 2 hours. Check that you used the right items.

## Common mistakes
- Answering from a single word you recognise, without reading the sentence
- Missing a 不 or 没
- Choosing an answer because the same character appears in the text, when the meaning is different
- Spending too long on one hard question

## How this is examined
Expect a mixture of short texts, each followed by several questions. Easy questions ask for a single fact; harder ones need you to combine two sentences, count items, compare prices or follow a sequence. Distractors are usually details that appear in the text but answer a different question.

Exam tip: After you choose an answer, point to the exact characters in the text that prove it. If you cannot, look again.$mq$ from st;

-- eAssessment Skills for Languages > Listening Text Strategies
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Languages$mq$, 5, 9 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Listening Text Strategies$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Languages$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Listening Text Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the best thing to do before the listening text starts?$mq$, $mq$["Read the questions and underline the key words","Close your eyes and relax","Translate the options into English","Write down all the characters you know"]$mq$, 0, $mq$Reading the questions first lets you predict the kind of information you need, such as a time, a place or an item.$mq$, $mq$easy$mq$),
($mq$Listening transcript: shí sì (十四). Which number is this?$mq$, $mq$["4","10","40","14"]$mq$, 3, $mq$十四 is ten plus four, which is 14. Forty is 四十 (sì shí), where the four comes first.$mq$, $mq$easy$mq$),
($mq$Listening transcript: 我想买一本书 (wǒ xiǎng mǎi yì běn shū). What does the speaker want to do?$mq$, $mq$["Sell a book","Read a book","Buy a book","Borrow a book"]$mq$, 2, $mq$买 (mǎi, third tone) means buy; 卖 (mài, fourth tone) means sell. The tone difference changes the meaning completely.$mq$, $mq$easy$mq$),
($mq$You miss one word in the middle of the recording. What should you do?$mq$, $mq$["Stop and stay on that word","Keep listening and use the context to continue","Leave the whole question blank","Change your earlier answers"]$mq$, 1, $mq$Listening texts keep moving. Use context, note what you caught, and move on. Many are played more than once, so you can return to the gap.$mq$, $mq$easy$mq$),
($mq$Listening transcript: 我妈妈在家 (wǒ māma zài jiā). Who is at home?$mq$, $mq$["Mum","Dad","The teacher","A horse"]$mq$, 0, $mq$妈妈 (māma) is mum, with a first tone. 马 (mǎ, third tone) means horse, a classic tone confusion, but the text says 妈妈.$mq$, $mq$easy$mq$),
($mq$Listening transcript: 现在是下午两点。飞机三点十分起飞 (xiànzài shì xiàwǔ liǎng diǎn. fēijī sān diǎn shí fēn qǐfēi). What time does the plane take off?$mq$, $mq$["2:00 pm","3:00 pm","3:15 pm","3:10 pm"]$mq$, 3, $mq$The speaker gives the current time (2:00) as well as the take-off time. 三点十分 means 3:10. 起飞 means to take off.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 我星期二有钢琴课，不对，星期三有钢琴课 (wǒ xīngqī'èr yǒu gāngqín kè, bú duì, xīngqīsān yǒu gāngqín kè). On which day is the piano lesson?$mq$, $mq$["Tuesday","Thursday","Wednesday","Monday"]$mq$, 2, $mq$不对 (bú duì) means 'not right', so the speaker corrects themselves. The final answer is 星期三, Wednesday.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 服务员：您要喝什么？小林：我要一杯热茶，不要咖啡 (fúwùyuán: nín yào hē shénme? Xiǎolín: wǒ yào yì bēi rè chá, bú yào kāfēi). What does Xiaolin order?$mq$, $mq$["A cup of coffee","A cup of hot tea","A bottle of water","A cup of cold tea"]$mq$, 1, $mq$热 (rè) means hot. 不要咖啡 means 'do not want coffee', so coffee is a distractor.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 我要吃水饺 (wǒ yào chī shuǐjiǎo). What does the speaker want?$mq$, $mq$["To eat dumplings","To sleep","To drink water","To buy a book"]$mq$, 0, $mq$水饺 (shuǐjiǎo) are boiled dumplings. 睡觉 (shuìjiào) means sleep, which sounds similar but has different tones. The verb 吃 (chī) also says eat.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 这本书二十八块，那本书三十八块。我买便宜的 (zhè běn shū èrshíbā kuài, nà běn shū sānshíbā kuài. wǒ mǎi piányi de). How much does the speaker pay?$mq$, $mq$["38 kuài","10 kuài","66 kuài","28 kuài"]$mq$, 3, $mq$便宜 (piányi) means cheap, so the speaker buys the cheaper book, which is 28 kuài. Listen for the word that tells you which price to pick.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 我是小丽。我们明天下午四点在学校门口见面。别忘了带书 (wǒ shì Xiǎolì. wǒmen míngtiān xiàwǔ sì diǎn zài xuéxiào ménkǒu jiànmiàn. bié wàng le dài shū). Where will they meet?$mq$, $mq$["In the library","At the cinema","At the school gate","In the park"]$mq$, 2, $mq$门口 (ménkǒu) means doorway or gate and 在学校门口 means at the school gate. 见面 means to meet.$mq$, $mq$medium$mq$),
($mq$The question says 'What does Li buy?' What kind of word should you listen for?$mq$, $mq$["A number of years","A noun naming an item, after a verb like 买","A weather word","A person's name only"]$mq$, 1, $mq$Predicting the answer type helps. 'What' about buying means an item, which usually follows 买 (mǎi).$mq$, $mq$medium$mq$),
($mq$Listening transcript: 明天北京下雨，十五度；上海晴天，二十二度 (míngtiān Běijīng xià yǔ, shíwǔ dù; Shànghǎi qíngtiān, èrshí'èr dù). What will the weather in Shanghai be tomorrow?$mq$, $mq$["Sunny and 22°C","Rainy and 15°C","Rainy and 22°C","Sunny and 15°C"]$mq$, 0, $mq$Match each city to its details. Beijing is rainy at 15°C; Shanghai is sunny (晴天) at 22°C.$mq$, $mq$medium$mq$),
($mq$Listening transcript: 我们平时六点吃饭，今天爸爸很忙，我们七点吃饭 (wǒmen píngshí liù diǎn chīfàn, jīntiān bàba hěn máng, wǒmen qī diǎn chīfàn). When does the family eat today?$mq$, $mq$["6:00","6:30","8:00","7:00"]$mq$, 3, $mq$平时 (píngshí) means usually, and 今天 (today) signals the exception. The usual time, 6:00, is the distractor.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 我家有四口人：爸爸、妈妈、姐姐和我 (wǒ jiā yǒu sì kǒu rén: bàba, māma, jiějie hé wǒ). Who is NOT in the family?$mq$, $mq$["A sister","A father","A brother","A mother"]$mq$, 2, $mq$The four members are dad, mum, older sister and the speaker. No brother is mentioned. Read the question carefully for 'NOT'.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 对不起，我不是八点到，我是八点半到。路上车很多 (duìbuqǐ, wǒ bú shì bā diǎn dào, wǒ shì bā diǎn bàn dào. lùshang chē hěn duō). What happened?$mq$, $mq$["The speaker arrived at 8:00 because of the weather","The speaker arrived at 8:30 because there was a lot of traffic","The speaker arrived at 8:30 because of a long lesson","The speaker did not arrive"]$mq$, 1, $mq$不是八点到 means did not arrive at 8:00, and 是八点半到 means arrived at 8:30. 路上车很多 means there were many cars on the road.$mq$, $mq$hard$mq$),
($mq$Listening transcript (a station announcement): 去北京的火车在三号站台，下午五点二十分开 (qù Běijīng de huǒchē zài sān hào zhàntái, xiàwǔ wǔ diǎn èrshí fēn kāi). What is the platform and departure time of the train to Beijing?$mq$, $mq$["Platform 3 at 5:20 pm","Platform 5 at 3:20 pm","Platform 3 at 3:25 pm","Platform 2 at 5:30 pm"]$mq$, 0, $mq$三号站台 is platform 3 and 五点二十分 is 5:20. Swapping the two numbers is a common error, so write both down as you hear them.$mq$, $mq$hard$mq$),
($mq$Listening transcript: 我不喜欢踢足球，我喜欢打篮球，可是我哥哥喜欢踢足球 (wǒ bù xǐhuan tī zúqiú, wǒ xǐhuan dǎ lánqiú, kěshì wǒ gēge xǐhuan tī zúqiú). Which statement is correct?$mq$, $mq$["The speaker likes football and the brother likes basketball","Both like football","Both like basketball","The speaker likes basketball and the brother likes football"]$mq$, 3, $mq$Track who likes what. 不喜欢踢足球 means the speaker does not like football, while 可是 (but) introduces the brother, who does.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Listening Text Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Before the listening starts$mq$, $mq$Read all the questions and options, underline key words, and predict the type of answer: a time, price, place or item.$mq$),
($mq$买 (mǎi) vs 卖 (mài)$mq$, $mq$买 (third tone) means buy. 卖 (fourth tone) means sell. Tone changes the meaning.$mq$),
($mq$妈 (mā) vs 马 (mǎ)$mq$, $mq$妈 (first tone) is mum. 马 (third tone) is horse. Use context if you cannot hear the tone.$mq$),
($mq$十四 (shí sì) vs 四十 (sì shí)$mq$, $mq$14 versus 40. In Chinese numbers the tens come first: 十四 is ten and four, 四十 is four tens.$mq$),
($mq$不对 (bú duì)$mq$, $mq$Not right. A speaker who says this is correcting themselves, so the answer is what comes after it.$mq$),
($mq$平时 (píngshí)$mq$, $mq$Usually. It introduces the normal situation, often followed by what is different today: 平时六点，今天七点 (usually six, today seven).$mq$),
($mq$Why take notes as digits?$mq$, $mq$Digits are quick to write. Label each number with a word, e.g. 'usual 6, today 7', so you can choose the right one when the question asks.$mq$),
($mq$水饺 (shuǐjiǎo) vs 睡觉 (shuìjiào)$mq$, $mq$Dumplings versus sleep. The sounds are similar but the tones differ. Use the context: 吃 (eat) goes with dumplings, while 睡觉 is itself the verb "to sleep".$mq$),
($mq$What should you do on the second listening?$mq$, $mq$Check and complete your notes, confirm numbers and names, and only change an answer if you are sure it was wrong.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Listening Text Strategies$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What listening tasks look like
In the listening part of an on-screen language exam, you hear a short recording such as a phone message, an announcement, a conversation or a weather forecast, and answer questions about it. On this site we cannot play audio, so each listening practice question gives a written "Listening transcript". Practise by reading the transcript aloud, using the pinyin, and listening for the same clues.

## Before you listen
- Read the questions and options first
- Underline key words: who, when, where, how much
- Predict the type of answer: a number, a place, an item, a reason
- Notice that options often differ only by one detail, such as 3:10 and 3:15, so you know which detail to catch

## While you listen
- Write short notes: numbers, times, names and days. Use digits, not characters or full sentences
- Do not stop on one word you missed. Keep listening
- Listen for the answer, not for every word
- Catch signal words:
  - 但是 (dànshì) and 可是 (kěshì): but
  - 不对 (bú duì): not right, a correction is coming
  - 不是...是... (bú shì ... shì ...): not X but Y
  - 因为 (yīnwèi): because
  - 平时 (píngshí): usually, followed by what is different today

## Tone traps
Because Mandarin is tonal, similar sounds with different tones have different meanings.
- 买 (mǎi, buy) and 卖 (mài, sell)
- 妈 (mā, mum) and 马 (mǎ, horse)
- 水饺 (shuǐjiǎo, dumplings) and 睡觉 (shuìjiào, sleep)
- 十四 (shí sì, 14) and 四十 (sì shí, 40)
- 十五 (shíwǔ, 15) and 五十 (wǔshí, 50)

When there is a tone clash, use the context. In a restaurant, dumplings make more sense than sleep.

## Number traps
Numbers are the most tested detail. Listen for the unit: 点 (diǎn, o'clock), 块 (kuài, yuan), 号 (hào, date or platform number), 度 (dù, degrees). Check which number is the answer. A speaker may give the current time (2:00) and then the event time (3:10), or the usual time and then the changed one.

## Corrections and contrast
Speakers often change their mind: 我星期二有钢琴课，不对，星期三有钢琴课 (I have piano on Tuesday, no wait, on Wednesday). The final version is the answer. Likewise, 不要咖啡 (do not want coffee) means coffee is a distractor.

## Second listening
Use it to check your answer, fill in gaps and confirm numbers. Do not change an answer unless you are sure.

## Common mistakes
- Picking the first number you hear
- Missing a negative such as 不 or 没
- Confusing similar-sounding words and not checking the context
- Writing too much and missing the next sentence

## How this is examined
Typical items include phone messages, announcements, short dialogues and forecasts. Questions test specific facts (a time, price or place) and your ability to cope with corrections and contrast words. Distractors are usually other details from the same recording.

Exam tip: Write numbers as digits while you listen and label each one with a word, such as "usual 6, today 7", so that you can pick the right one at the end.$mq$ from st;

-- eAssessment Skills for Languages > Writing a Short Response
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Languages$mq$, 5, 9 from public.subjects s where s.slug = $mq$mandarin-ab-initio$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Writing a Short Response$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$mandarin-ab-initio$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Languages$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Writing a Short Response$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$A writing task has three bullet points. What should you do first?$mq$, $mq$["Check what each bullet point asks and plan one or more sentences for each","Write about any topic you like","Write the longest sentence you can","Start with your favourite hobby"]$mq$, 0, $mq$Task fulfilment depends on answering every bullet point. Plan your response so that each one gets a clear answer.$mq$, $mq$easy$mq$),
($mq$Which punctuation mark ends a statement in Chinese writing?$mq$, $mq$[".","!",";","。"]$mq$, 3, $mq$Chinese uses the full-width full stop 。 (jùhào) at the end of a sentence. Use full-width ，、？ and ！ too.$mq$, $mq$easy$mq$),
($mq$Which version of the sentence uses proper Chinese punctuation?$mq$, $mq$["我喜欢猫,也喜欢狗.","我 喜欢 猫 也 喜欢 狗","我喜欢猫，也喜欢狗。","wǒ xǐhuan māo, yě xǐhuan gǒu"]$mq$, 2, $mq$Write in characters with no spaces between words, and use Chinese punctuation (，。). Pinyin alone would not be accepted for a character writing task.$mq$, $mq$easy$mq$),
($mq$You type 'zài' with a pinyin keyboard and several characters appear. Which one gives 'I am at home' in 我__家?$mq$, $mq$["再","在","载","仔"]$mq$, 1, $mq$在 (zài) means to be at. 再 (zài) means again, as in 再见. Homophones are common, so pick the character by meaning.$mq$, $mq$easy$mq$),
($mq$You are writing about your mother. Which pronoun should you use?$mq$, $mq$["她 (tā)","他 (tā)","它 (tā)","你 (nǐ)"]$mq$, 0, $mq$她 is she, 他 is he, and 它 is it. They sound the same, so the written form matters in writing.$mq$, $mq$easy$mq$),
($mq$Complete: 我喜欢夏天，____我可以去游泳。 (wǒ xǐhuan xiàtiān, ____ wǒ kěyǐ qù yóuyǒng)$mq$, $mq$["但是 (dànshì)","所以 (suǒyǐ)","和 (hé)","因为 (yīnwèi)"]$mq$, 3, $mq$The second part gives the reason, so use 因为 (because). 但是 means but, 所以 means so and 和 means and.$mq$, $mq$medium$mq$),
($mq$A task says: 'Write about your family.' Which opening sentence is most relevant?$mq$, $mq$["我喜欢吃面条。","昨天我去了商店。","我家有五口人：爸爸、妈妈、哥哥、妹妹和我。","今天天气很好。"]$mq$, 2, $mq$The first sentence should answer the task directly. The family sentence names family members with the right measure word 口 (kǒu).$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'This is my book'?$mq$, $mq$["这是书我的 (zhè shì shū wǒ de)","这是我的书 (zhè shì wǒ de shū)","这是我书的 (zhè shì wǒ shū de)","这是的我书 (zhè shì de wǒ shū)"]$mq$, 1, $mq$Possession is written as owner + 的 + thing. The pattern is 我的书, 他的狗, 老师的车.$mq$, $mq$medium$mq$),
($mq$A student writes 我去学校明天 (wǒ qù xuéxiào míngtiān). Which correction is right?$mq$, $mq$["我明天去学校 (wǒ míngtiān qù xuéxiào)","明天学校我去 (míngtiān xuéxiào wǒ qù)","我去明天学校 (wǒ qù míngtiān xuéxiào)","去学校我明天 (qù xuéxiào wǒ míngtiān)"]$mq$, 0, $mq$Time words go before the verb, so 明天 comes before 去. This is the most common word-order error in beginner writing.$mq$, $mq$medium$mq$),
($mq$Which sentence correctly says 'My school is big'?$mq$, $mq$["我的学校是大 (wǒ de xuéxiào shì dà)","我的学校有大 (wǒ de xuéxiào yǒu dà)","我的学校不大是 (wǒ de xuéxiào bú dà shì)","我的学校很大 (wǒ de xuéxiào hěn dà)"]$mq$, 3, $mq$Adjectives take 很, not 是. This pattern is useful for any description in writing: 她很高, 书很好, 天气很冷.$mq$, $mq$medium$mq$),
($mq$You are writing a friendly message to a classmate you will see tomorrow. Which closing is the most suitable?$mq$, $mq$["老师好 (lǎoshī hǎo)","我是学生 (wǒ shì xuésheng)","明天见！(míngtiān jiàn!)","谢谢您 (xièxie nín)"]$mq$, 2, $mq$明天见 means 'see you tomorrow' and fits a friendly message. 老师好 is a greeting to a teacher and 您 is a formal 'you'.$mq$, $mq$medium$mq$),
($mq$A task asks for your name, age and a hobby. Which response covers all three?$mq$, $mq$["我叫李明，我十五岁。","我叫李明，我十五岁，我喜欢踢足球。","我叫李明，我喜欢踢足球。","我十五岁，我喜欢踢足球。"]$mq$, 1, $mq$Each option is correct Chinese, but only one gives name (叫李明), age (十五岁) and hobby (踢足球). Always tick off each bullet.$mq$, $mq$medium$mq$),
($mq$You cannot remember how to write the word for 'library'. What is the best approach?$mq$, $mq$["Say it in a simpler way using words you know","Leave the sentence out","Write the word in English","Write random characters"]$mq$, 0, $mq$Rephrase with vocabulary you know, such as 我去学校看书 (I go to school to read). A correct simple sentence scores better than a failed complex one.$mq$, $mq$medium$mq$),
($mq$Which is the best correction of 我很喜欢吃苹果，因为苹果是好吃 (wǒ hěn xǐhuan chī píngguǒ, yīnwèi píngguǒ shì hǎochī)?$mq$, $mq$["我很喜欢吃苹果，因为苹果有好吃","我很喜欢吃苹果，因为苹果不好吃","我很喜欢吃苹果，因为是苹果好吃","我很喜欢吃苹果，因为苹果很好吃"]$mq$, 3, $mq$Adjectives such as 好吃 (tasty) take 很, not 是. 不好吃 would mean not tasty and contradict the sentence.$mq$, $mq$hard$mq$),
($mq$Which sentence correctly says 'On Saturday I went to the park with my friends'?$mq$, $mq$["我去公园和朋友星期六了 (wǒ qù gōngyuán hé péngyou xīngqīliù le)","我和朋友去公园星期六 (wǒ hé péngyou qù gōngyuán xīngqīliù)","星期六我和朋友去了公园 (xīngqīliù wǒ hé péngyou qù le gōngyuán)","星期六我去和朋友公园 (xīngqīliù wǒ qù hé péngyou gōngyuán)"]$mq$, 2, $mq$Put the time word first, then the subject, then 和朋友 before the verb, and 了 after the verb for the completed action.$mq$, $mq$hard$mq$),
($mq$The task is 'Describe your best friend'. Which response develops the ideas best?$mq$, $mq$["我的朋友。","我的好朋友叫小美。她十五岁，很高，也很聪明。我们常常一起打羽毛球。","朋友好。","我有朋友。"]$mq$, 1, $mq$A strong response gives a name, age, description and shared activity in correct sentences. The other options are too short and give no information.$mq$, $mq$hard$mq$),
($mq$Which sentence contains a mistake that a pinyin keyboard could cause?$mq$, $mq$["我的妹妹十岁，他很可爱。","我有一个姐姐，她很高。","我们是好朋友。","他是我的哥哥。"]$mq$, 0, $mq$The sister should be 她 (she), not 他. All the pronouns sound like tā, so the wrong character is easy to choose when typing. Check them during proofreading.$mq$, $mq$hard$mq$),
($mq$A task asks for a short text of about 60 to 80 characters. A student writes only 20 characters. What is the main risk?$mq$, $mq$["The response will be too long","Characters will be marked down for being simple","The marker will not read it","The response is too short to cover the task and show their language"]$mq$, 3, $mq$A response that is far too short cannot answer every bullet point or show a range of language. Aim for the required length, and avoid long sentences you cannot write accurately.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Writing a Short Response$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$First step in a writing task$mq$, $mq$Underline each bullet point and the type of text, then plan at least one clear sentence for each point.$mq$),
($mq$Chinese punctuation$mq$, $mq$Use full-width marks: 。 for a full stop, ，for a comma, ？ and ！. Do not put spaces between words.$mq$),
($mq$他 / 她 / 它 (tā)$mq$, $mq$He / she / it. All sound the same, so pinyin typing gives all three. Choose by meaning: 她 for your mother or sister.$mq$),
($mq$在 (zài) vs 再 (zài)$mq$, $mq$在 means to be at or in progress: 我在家. 再 means again: 再见 (zàijiàn, goodbye). Choose by meaning when typing.$mq$),
($mq$因为 (yīnwèi)$mq$, $mq$Because. Use it to give reasons and develop ideas: 我喜欢夏天，因为我可以去游泳。$mq$),
($mq$Connectors to use in writing$mq$, $mq$和 (and), 也 (also), 但是 (but), 因为 (because), 先...然后... (first... then...). They link ideas and raise your level of communication.$mq$),
($mq$Pattern for possession$mq$, $mq$Owner + 的 + thing: 我的书 (wǒ de shū, my book), 老师的车 (lǎoshī de chē, the teacher's car).$mq$),
($mq$Word order check$mq$, $mq$Subject + time + place + verb + object: 我明天在家学中文. Time and place go before the verb.$mq$),
($mq$What if you forget a word?$mq$, $mq$Rephrase with words you know. A simple correct sentence is better than English, random characters or a gap.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Writing a Short Response$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What a short writing response is
In the writing part of an on-screen language exam you respond to a task, such as writing a message, an email, a diary entry or a short description. At beginner level you write in simplified characters, usually by typing with a pinyin keyboard. You are marked on how well you complete the task, how much you communicate, and how accurate and varied your language is.

## Plan before you write
- Read the task and underline each bullet point (for example: name, age, hobby)
- Note the text type and reader: a message to a friend, or an email to a teacher
- Choose simple sentences you know are correct
- Check the length requirement and aim for it

## A simple structure
1. A greeting or opening that fits the reader: 你好 (nǐ hǎo) or 老师好 (lǎoshī hǎo)
2. One or two sentences for each bullet point
3. A closing: 谢谢！(xièxie!) or 明天见！(míngtiān jiàn!)

Example (about yourself): 我叫李明，我十五岁。我家有四口人：爸爸、妈妈、姐姐和我。我喜欢踢足球，因为很好玩。(Wǒ jiào Lǐ Míng, wǒ shíwǔ suì. Wǒ jiā yǒu sì kǒu rén: bàba, māma, jiějie hé wǒ. Wǒ xǐhuan tī zúqiú, yīnwèi hěn hǎowán.)

## Make your writing richer
- Connect ideas: 和 (and), 也 (also), 但是 (but), 因为 (because), 先...然后... (first... then...)
- Add detail: 很, 常常 (often), 每天 (every day)
- Use a range of verbs and time words
- Give reasons: 我喜欢夏天，因为我可以去游泳。(I like summer because I can go swimming.)

## Accuracy checklist
- **Word order**: subject + time + place + verb + object. 我明天去学校, not 我去学校明天
- **Adjectives**: 很 + adjective, no 是. 我的学校很大
- **Negation**: 不 for 是 and most verbs, 没 for 有 and the past
- **Measure words**: 一个人, 两本书, 三杯茶
- **的** for possession: 我的书
- **Pronouns**: 他 (he), 她 (she), 它 (it) sound the same, so check each one
- **Homophones**: pinyin gives several characters. 在 (at) versus 再 (again) must be chosen by meaning
- **Punctuation**: full-width ，。？！ and no spaces between words

## Strategy when you do not know a word
Do not write English and do not guess characters. Say what you can using words you know. Simple, correct language earns more than complicated language with errors.

## Proofread
Spend the last minute reading your text aloud in your head. Check pronouns, tone-sensitive words, negatives, and whether every bullet point has been answered.

## Common mistakes
- Missing a bullet point
- Writing very short responses or copying the task wording
- Putting time or place after the verb
- Using 是 before adjectives
- Choosing the wrong homophone, such as 他 for 她

## How this is examined
The task gives a situation and several prompts. Marks reward completing every part, giving detail, using connectors and keeping language accurate. A short, accurate response that answers all prompts beats a long one full of errors.

Exam tip: Tick off each bullet point of the task in the margin as you write. Before submitting, check one thing at a time: first pronouns, then negatives, then word order.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('mandarin-ab-initio')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;