-- Part 4 of 6: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Everyday Life and Culture > Daily Life and Households Over Time
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Everyday Life and Culture$mq$, 5, 4 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Daily Life and Households Over Time$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Everyday Life and Culture$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Daily Life and Households Over Time$mq$ and p.name = $mq$Everyday Life and Culture$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$A historian wants a primary source about daily life in a British town in 1900. Which is the best example?$mq$, $mq$["A diary kept by a housewife in 1900","A documentary made in 2020 about Victorian homes","A textbook published in 2015","A historian's essay written in 1990"]$mq$, 0, $mq$A primary source was created at the time by someone who lived through it. The other options were produced long afterwards.$mq$, $mq$easy$mq$),
($mq$Which development did most to reduce the time spent on housework in many homes during the 20th century?$mq$, $mq$["The invention of the printing press","The growth of overseas empires","The spread of compulsory military service","Electricity and household appliances"]$mq$, 3, $mq$Electric power allowed washing machines, cookers, irons and vacuum cleaners to become common in homes.$mq$, $mq$easy$mq$),
($mq$During the Industrial Revolution many families left villages to live in growing towns and cities. What is this movement called?$mq$, $mq$["Colonisation","Mechanisation","Urbanisation","Globalisation"]$mq$, 2, $mq$Urbanisation is the growth of towns and the movement of people into them. Mechanisation means using machines.$mq$, $mq$easy$mq$),
($mq$Which description best fits an extended family household?$mq$, $mq$["A single adult living alone","Parents, children and other relatives such as grandparents living together","Two unrelated friends sharing a flat","A parent and one child only"]$mq$, 1, $mq$An extended family includes relatives beyond parents and children. A nuclear family is parents and children only.$mq$, $mq$easy$mq$),
($mq$Why do historians use census records when studying daily life?$mq$, $mq$["They are official counts that record who lived in each household, their ages and jobs","They contain the private thoughts of every citizen","They were always written by newspapers","They only describe the richest families"]$mq$, 0, $mq$Censuses give large-scale evidence about households, occupations and population, though not people's feelings.$mq$, $mq$easy$mq$),
($mq$Census records for England and Wales in 1851 showed that, for the first time, more people lived in towns than in the countryside. What is the most valid conclusion?$mq$, $mq$["Farming had completely disappeared","Everyone in towns worked in factories","Living standards were equal across the country","Britain had become a mainly urban society"]$mq$, 3, $mq$A majority living in towns means Britain was mainly urban. Farming and rural life still continued, and conditions varied greatly.$mq$, $mq$medium$mq$),
($mq$In a fictional town the average household had 5.2 people in 1850 and 2.4 people in 2000. Which is the most likely explanation?$mq$, $mq$["Homes became smaller than they had been","Fewer people lived in the town","Smaller families and more people living alone","More servants were employed in each home"]$mq$, 2, $mq$Falling family size and more single-person households explain a fall in average household size. The other options do not fit the data.$mq$, $mq$medium$mq$),
($mq$A factory owner writes in 1840 that the children in his mill are 'happy and well cared for'. What is the main limitation of this source for a historian?$mq$, $mq$["It is too old to be useful","The owner had a reason to present his factory in a good light","It was written in the same year as the events","It mentions children"]$mq$, 1, $mq$Provenance and purpose matter. An owner defending his business may not give a fair account of working conditions.$mq$, $mq$medium$mq$),
($mq$In a fictional country, a typical household spent 60% of its income on food in 1900 and 15% in 2000. What does this most strongly suggest?$mq$, $mq$["Food took a much smaller share of household budgets, leaving more money for other things","People ate much less food in 2000","Food was more expensive in 2000","Incomes fell between 1900 and 2000"]$mq$, 0, $mq$A smaller share spent on food usually means incomes grew faster than food costs, so more could be spent on other goods and leisure.$mq$, $mq$medium$mq$),
($mq$Why did the building of sewers and piped clean water in 19th-century cities improve daily life?$mq$, $mq$["It made factories run faster","It raised the price of housing","It ended the need for doctors","It reduced water-borne diseases such as cholera"]$mq$, 3, $mq$Dirty water spread cholera and typhoid. Clean water supplies and sewers cut deaths from these diseases.$mq$, $mq$medium$mq$),
($mq$Which is the best example of continuity, rather than change, in daily life between 1850 and today?$mq$, $mq$["Households using electric lighting","Most people travelling by train","Families gathering to share meals and celebrate religious or cultural festivals","Children attending school until their mid-teens"]$mq$, 2, $mq$Shared meals and festivals have continued over time. The other options describe changes that arrived during the period.$mq$, $mq$medium$mq$),
($mq$Which was an effect of the First World War on the daily lives of many British women?$mq$, $mq$["Women were banned from paid work","Many took jobs in factories, transport and offices that men had done","All women moved to the countryside","Housework was shared equally with men"]$mq$, 1, $mq$With millions of men serving in the forces, women filled many jobs, including in munitions factories.$mq$, $mq$medium$mq$),
($mq$Why can one diary not describe daily life for everyone in a society?$mq$, $mq$["It shows only one person's experience, which depends on their class, gender and place","Diaries are always false","Diaries are never written in the past","Diaries only describe weather"]$mq$, 0, $mq$Experience varied widely. A single source is one viewpoint and must be compared with others.$mq$, $mq$medium$mq$),
($mq$Source A is the diary of a wealthy woman in 1880 who writes that servants make daily life easy. Source B is a report describing eight people sharing one room in a poor district of the same city. What is the best conclusion?$mq$, $mq$["Source A is wrong and Source B is right","Both sources show that everyone lived in poverty","Both sources prove that servants were unnecessary","Daily life in the same city differed greatly by social class, and neither source alone is typical"]$mq$, 3, $mq$Sources can both be accurate yet show different groups. Good historians combine them to build a fuller picture.$mq$, $mq$hard$mq$),
($mq$A historian claims 'washing machines freed women from housework'. Which evidence would best challenge this claim?$mq$, $mq$["A photograph of a new washing machine","A list of washing machine makers","Time-use surveys showing that hours of housework fell much less than expected","A diary entry praising a neighbour's garden"]$mq$, 2, $mq$Rising standards of cleanliness meant that time saved on one task was often spent on others. Surveys of how people used time test the claim directly.$mq$, $mq$hard$mq$),
($mq$Which was a long-term consequence of rapid urban growth in 19th-century Britain?$mq$, $mq$["A fall in the number of towns","Growing pressure for public health laws, sewers and clean water","An end to factory work","A return of most families to farming"]$mq$, 1, $mq$Overcrowded towns and epidemics such as cholera led to reforms, including the Public Health Act of 1848.$mq$, $mq$hard$mq$),
($mq$Which argument best explains why the refrigerator is historically significant for daily life?$mq$, $mq$["It changed how food was stored and bought, cut food poisoning and affected very many households for decades","It was invented by one person","It looks modern","It was expensive when first sold"]$mq$, 0, $mq$Significance is judged by how many people were affected, how deeply, and for how long.$mq$, $mq$hard$mq$),
($mq$A 1950s advertisement shows a smiling woman delighted with a new kitchen appliance. How should a historian use it?$mq$, $mq$["As proof that all women enjoyed housework","As useless because it is an advert","As a reliable census record","As evidence of the ideals and marketing of the time, not proof of typical home life"]$mq$, 3, $mq$Adverts show how products were sold and what ideals were promoted. Their purpose means they are not a balanced record of reality.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Daily Life and Households Over Time$mq$ and p.name = $mq$Everyday Life and Culture$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Primary source$mq$, $mq$Evidence created at the time of the events, for example a diary, letter, census return or photograph.$mq$),
($mq$Urbanisation$mq$, $mq$The growth of towns and the movement of people from the countryside into them.$mq$),
($mq$Nuclear family vs extended family$mq$, $mq$Nuclear: parents and children only. Extended: also includes relatives such as grandparents, aunts and uncles.$mq$),
($mq$Why use census records?$mq$, $mq$Official population counts that record households, ages and jobs. They show large-scale patterns but not people's feelings.$mq$),
($mq$Public Health Act 1848$mq$, $mq$British law that began reform of sewers, water supply and sanitation after cholera epidemics in crowded towns.$mq$),
($mq$Effect of WWI on women's work$mq$, $mq$Many women took jobs in factories, transport and offices while men served in the forces.$mq$),
($mq$Change and continuity$mq$, $mq$Change: what is different over time. Continuity: what stays the same. Good answers give examples of both.$mq$),
($mq$OPCVL$mq$, $mq$Origin, Purpose, Content, Value, Limitations: a checklist for judging a source.$mq$),
($mq$Why is class important?$mq$, $mq$Daily life varied hugely between rich and poor in the same place, so one source cannot show everyone's experience.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Daily Life and Households Over Time$mq$ and p.name = $mq$Everyday Life and Culture$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What this topic covers
Daily life means the ordinary routines of people in the past: where they lived, what they ate, how they worked, how they spent free time and how families were organised. Historians study it to understand how change in politics and technology affected normal people, not only rulers and generals.

## Key changes over time
- **Urbanisation**: during the Industrial Revolution many people moved from villages to towns for factory work. The 1851 census in Britain showed that, for the first time, more people lived in towns than in the countryside.
- **Housing and health**: early industrial towns were often overcrowded, with poor sanitation. Epidemics such as cholera led to reforms, including the Public Health Act of 1848, and later to sewers and piped clean water.
- **Technology in the home**: electricity brought lighting, irons, cookers, refrigerators and washing machines to more homes during the 20th century. This changed how food was kept and how much physical work housework needed.
- **Family and household size**: households tended to become smaller over time, with more people living alone or in nuclear families (parents and children).
- **Women's lives**: during the First World War many women took on jobs in factories, transport and offices. Over the 20th century more women entered paid work, though attitudes and pay changed slowly.
- **Social class**: in the same town, a wealthy family with servants and a poor family sharing one room lived very differently. Never write about "the Victorians" as if everyone had the same experience.

## Continuity and change
Strong answers show both. Technology and housing changed greatly, but family bonds, shared meals and festivals continued. Ask: what changed, what stayed the same, and for whom? Also consider the pace of change: some changes were gradual and others, like wartime work for women, were sudden.

## Sources for daily life
- **Primary sources**: diaries, letters, photographs, census records, adverts, household bills.
- **Secondary sources**: textbooks and documentaries written later.
Always consider origin, purpose, content, value and limitations. A census gives numbers but not feelings. A diary gives feelings but only one person's view. An advert shows ideals, not typical reality.

## Worked example
A fictional town had an average household size of 5.2 in 1850 and 2.4 in 2000. The fall is (5.2 - 2.4) / 5.2 = 0.538, about 54%. A good explanation would link this to smaller families and more people living alone, then check it with other sources.

## Common mistakes
- Treating one person's diary as typical of a whole society.
- Describing change without saying when, how much or for whom.
- Forgetting that some groups, such as the poor, left fewer written records.

## How this is examined
Questions give you short sources, such as an extract from a diary, a statistic or an image description. You are asked to identify what it shows, judge its value and limitations using its origin and purpose, compare two sources, and explain change or continuity. Extended tasks ask you to evaluate how far daily life changed, supporting each point with specific evidence.

Exam tip: Always name the group of people your evidence is about and comment on the source's purpose before you decide how much to trust it.$mq$ from st;

-- Everyday Life and Culture > Art, Literature and Culture as Evidence
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Everyday Life and Culture$mq$, 5, 4 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Art, Literature and Culture as Evidence$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Everyday Life and Culture$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Art, Literature and Culture as Evidence$mq$ and p.name = $mq$Everyday Life and Culture$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$A painting from 1850 shows a street scene. What can it show a historian?$mq$, $mq$["Clothing, buildings and attitudes, as seen by the artist","Exactly what every person in the city thought","Nothing, because paintings are always invented","The census figures for the town"]$mq$, 0, $mq$Art gives a viewpoint on how people dressed and lived, but it is selected and interpreted by the artist.$mq$, $mq$easy$mq$),
($mq$What is the main purpose of a propaganda poster?$mq$, $mq$["To record the weather","To list laws in detail","To provide neutral statistics","To persuade people to think or act in a particular way"]$mq$, 3, $mq$Propaganda is designed to influence opinion, for example to recruit soldiers or support a government.$mq$, $mq$easy$mq$),
($mq$A novel published in the 1840s describes poverty in a large city. For a historian studying that decade, it is best described as which kind of source?$mq$, $mq$["A secondary source written long afterwards","A census record","A primary source for attitudes of the time, written by someone living then","A source with no value because it is fiction"]$mq$, 2, $mq$Fiction written at the time is a primary source for ideas and attitudes, though it is not a factual record.$mq$, $mq$easy$mq$),
($mq$Which of these is a cultural artefact?$mq$, $mq$["A tax law","A folk song passed down through a community","A river","A battle plan"]$mq$, 1, $mq$Songs, stories, art and clothing express the culture of a group and can be used as evidence.$mq$, $mq$easy$mq$),
($mq$What does 'bias' mean when judging a source?$mq$, $mq$["Leaning unfairly towards one side or viewpoint","Being written in the past","Being very long","Having a title"]$mq$, 0, $mq$A biased source favours one viewpoint. Bias does not make a source useless but affects how it should be used.$mq$, $mq$easy$mq$),
($mq$A 1915 poster shows a smiling soldier urging men to enlist. What is the best statement about its value?$mq$, $mq$["It proves that all soldiers were happy","It is useless because it is a poster","It shows exactly what the front line looked like","It shows what the government wanted people to do, not how soldiers felt"]$mq$, 3, $mq$Its purpose was recruitment. It is valuable evidence of government aims and methods but not of soldiers' real experience.$mq$, $mq$medium$mq$),
($mq$Wilfred Owen served as a soldier in the First World War and wrote poems about it. Why are his poems valuable evidence?$mq$, $mq$["They are official government statistics","They were written a century later","They record a soldier's first-hand impressions of the war","They prove how every soldier felt"]$mq$, 2, $mq$A soldier-poet offers an eyewitness view. It is still one person's emotional account, so it is not proof for all soldiers.$mq$, $mq$medium$mq$),
($mq$The Harlem Renaissance of the 1920s is best described as which of the following?$mq$, $mq$["A military campaign in the First World War","A flowering of African American art, music and literature centred on Harlem in New York","A change of government in Britain","A scientific discovery"]$mq$, 1, $mq$Writers, musicians and artists in Harlem expressed African American identity and gave historians a rich cultural record.$mq$, $mq$medium$mq$),
($mq$The Bayeux Tapestry was made in the years after the Norman Conquest of 1066. Why must historians be careful when using it?$mq$, $mq$["It was made on the Norman side and presents events from a viewpoint favourable to them","It is too colourful to be real","It is too short to be useful","It is a secondary source written in the 20th century"]$mq$, 0, $mq$Provenance matters. The people who commissioned and made it affected what it showed and how.$mq$, $mq$medium$mq$),
($mq$In the OPCVL method for judging a source, what does the 'P' stand for?$mq$, $mq$["Population","Politics","Position in a museum","Purpose: why the source was created"]$mq$, 3, $mq$Origin, Purpose, Content, Value and Limitations. Knowing purpose shows why a creator chose what to include.$mq$, $mq$medium$mq$),
($mq$Protest songs became popular during the US civil rights movement of the 1950s and 1960s. What can a historian learn from them?$mq$, $mq$["The exact number of marchers on each day","The names of every senator","The mood, values and demands of people who took part in the campaign","Nothing, since music is not evidence"]$mq$, 2, $mq$Songs show attitudes and shared identity. They are weaker evidence of precise facts such as numbers.$mq$, $mq$medium$mq$),
($mq$A student says: 'This newspaper article is biased, so it is useless.' Which reply is most accurate?$mq$, $mq$["Biased sources should always be ignored","Bias can itself be useful evidence about the writer's views and the audience","Only unbiased sources have any value","Bias only appears in modern sources"]$mq$, 1, $mq$A biased source can reveal attitudes and propaganda methods. Historians use it with care rather than throw it away.$mq$, $mq$medium$mq$),
($mq$Soviet art of the 1930s often showed smiling workers and heroic leaders. Why is this useful to a historian?$mq$, $mq$["It shows how the state wanted society to be seen and which ideals it promoted","It proves that factories were pleasant places","It gives accurate figures for production","It shows the opinions of Soviet critics"]$mq$, 0, $mq$State-sponsored art was used for propaganda. It tells us about official ideals, not actual conditions.$mq$, $mq$medium$mq$),
($mq$Two sources describe the same parade. A government film shows enthusiastic crowds, and a private diary describes people attending out of fear. What is the best approach?$mq$, $mq$["Believe the film because it shows images","Believe the diary because it is handwritten","Ignore both and rely on memory","Cross-reference both with other sources and consider each source's purpose"]$mq$, 3, $mq$Comparing sources and checking their purposes helps reach a balanced judgement.$mq$, $mq$hard$mq$),
($mq$A British newspaper cartoon from 1900 shows a foreign leader as a monster. How can a historian best use it?$mq$, $mq$["As proof that the leader was cruel","As a photograph of the leader","As evidence of attitudes and stereotypes among the newspaper's readers, not of the leader's real character","As a neutral report of events"]$mq$, 2, $mq$Cartoons exaggerate to make a point. They show the opinions the paper expected its audience to share.$mq$, $mq$hard$mq$),
($mq$In a country with strict censorship, published novels contain no criticism of the government. What can a historian reasonably infer?$mq$, $mq$["That everyone supported the government","Little about public opinion, because censorship limited what could be published","That novels were not read","That the government was unpopular"]$mq$, 1, $mq$Absence of criticism may result from censorship. Other evidence, such as private letters, is needed.$mq$, $mq$hard$mq$),
($mq$Which response best evaluates the claim 'Art tells us nothing reliable about the past'?$mq$, $mq$["Art can mislead about facts but is valuable for attitudes, values and what creators or patrons wanted to show","The claim is entirely correct","Art is the most reliable source of all","Only photographs count as evidence"]$mq$, 0, $mq$A balanced answer weighs limitations and strengths and links them to the question being asked.$mq$, $mq$hard$mq$),
($mq$A historian describes a whole society using three paintings, all commissioned by wealthy patrons. What is the main weakness?$mq$, $mq$["Three is too many","Paintings cannot be dated","Wealthy people never owned art","The sample is unrepresentative, since the paintings reflect the tastes and interests of the elite"]$mq$, 3, $mq$Patrons chose what was painted. Ordinary people were rarely shown, so conclusions about everyone are unsafe.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Art, Literature and Culture as Evidence$mq$ and p.name = $mq$Everyday Life and Culture$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Cultural evidence$mq$, $mq$Art, literature, music, film and other creations that show the attitudes and values of a society.$mq$),
($mq$Propaganda$mq$, $mq$Material designed to persuade people to think or act a certain way, often one-sided or exaggerated.$mq$),
($mq$Does bias make a source useless?$mq$, $mq$No. Bias can reveal the creator's views and the opinions they wanted the audience to hold.$mq$),
($mq$OPCVL$mq$, $mq$Origin, Purpose, Content, Value, Limitations: steps for evaluating a source.$mq$),
($mq$Harlem Renaissance$mq$, $mq$1920s flowering of African American art, music and literature, centred on Harlem in New York.$mq$),
($mq$Wilfred Owen$mq$, $mq$British soldier-poet of the First World War whose poems give a first-hand but personal view of the war.$mq$),
($mq$Bayeux Tapestry$mq$, $mq$Embroidered account of the Norman Conquest of 1066, made from the Norman viewpoint.$mq$),
($mq$Why can censorship limit a source?$mq$, $mq$Silence about criticism may mean it was not allowed, so you cannot assume that people agreed.$mq$),
($mq$Representativeness$mq$, $mq$Whether a source reflects the wider society. One painting or song may reflect only the creator or patron.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Art, Literature and Culture as Evidence$mq$ and p.name = $mq$Everyday Life and Culture$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why culture matters to historians
Historians use more than official records. Paintings, novels, poems, songs, films, posters and cartoons all tell us something about what people valued, feared and believed. This kind of evidence is called cultural evidence. It is especially useful for attitudes and emotions, which statistics cannot show.

## Types of cultural evidence
- **Visual art**: paintings, sculptures, tapestries, photographs and cartoons show clothing, buildings and how people wanted to be seen. They are chosen and shaped by the creator.
- **Literature**: novels, plays and poems written at the time reveal ideas and concerns. A novel is not a factual record, but a primary source for attitudes. The poems of First World War soldier-poets such as Wilfred Owen give an eyewitness impression of war.
- **Music**: songs, such as protest songs in the US civil rights movement, express shared hopes and anger.
- **Propaganda**: posters, films and state-approved art try to persuade. The Soviet state of the 1930s promoted pictures of heroic workers. These show official ideals, not everyday reality.
- **Movements**: the Harlem Renaissance of the 1920s was a flowering of African American art, music and literature in New York that expressed identity and challenged stereotypes.

## How to judge cultural sources
Use OPCVL: Origin, Purpose, Content, Value, Limitations.
- Who made it, and who paid for it? The Bayeux Tapestry was made after the Norman Conquest of 1066 and presents events from a viewpoint favourable to the Normans.
- Why was it made: to persuade, entertain, record or protest?
- What is shown, and what is left out?
- Is the creator's bias useful? A biased source is not useless. It can reveal the opinions the creator wanted the audience to hold.

## Representativeness and censorship
One painting or song cannot represent a society. Wealthy patrons paid for most art, so the poor appear less often. Under censorship, such as in states that controlled publishing, the absence of criticism does not show that people agreed. It may show that criticism was not allowed.

## Worked example
Source: a 1915 recruitment poster shows a smiling soldier. Content: a cheerful volunteer. Purpose: to persuade men to enlist. Value: shows methods used by the government and the images of bravery it promoted. Limitation: does not show the reality of the trenches. A soldier's poem could be used alongside it to give a contrasting view.

## Common mistakes
- Saying 'the source is biased so it is useless'.
- Treating a painting as a photograph.
- Judging only by content and ignoring who made it and why.
- Generalising about a whole society from one source.

## How this is examined
You are usually given two short sources, such as a poster and a poem, or a cartoon and a diary. Questions ask what each shows, how reliable each is given origin and purpose, and how useful each is for a specific enquiry. Longer answers ask you to compare them and reach a supported judgement about how far they agree.

Exam tip: Judge usefulness for the question asked. A poster can be useless for finding soldiers' feelings but excellent for finding government methods of persuasion.$mq$ from st;

-- Everyday Life and Culture > Sport, Leisure and Popular Culture
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Everyday Life and Culture$mq$, 5, 4 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Sport, Leisure and Popular Culture$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Everyday Life and Culture$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Sport, Leisure and Popular Culture$mq$ and p.name = $mq$Everyday Life and Culture$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In which year were the first modern Olympic Games held in Athens?$mq$, $mq$["1896","1066","1914","1948"]$mq$, 0, $mq$The first modern Olympics took place in Athens in 1896, inspired by ancient Greek games.$mq$, $mq$easy$mq$),
($mq$Which technology brought news and entertainment into many homes during the 1920s?$mq$, $mq$["The internet","The smartphone","Satellite television","Radio"]$mq$, 3, $mq$Radio broadcasting spread in the 1920s, and families could listen to music and news at home.$mq$, $mq$easy$mq$),
($mq$What does 'leisure' mean?$mq$, $mq$["Working hours in a factory","Time spent in school","Free time used for activities people choose to do","Military service"]$mq$, 2, $mq$Leisure activities include sport, music, cinema and hobbies.$mq$, $mq$easy$mq$),
($mq$The Football Association, founded in England in 1863, was created mainly to do what?$mq$, $mq$["Organise the first World Cup","Agree common rules for football","Train professional referees abroad","Replace rugby"]$mq$, 1, $mq$The FA created standard rules so that clubs could play each other under the same laws.$mq$, $mq$easy$mq$),
($mq$What is 'popular culture'?$mq$, $mq$["Music, film, sport, television and fashions enjoyed by large numbers of ordinary people","Only the art in museums","Laws passed by governments","Religious texts"]$mq$, 0, $mq$Popular culture is mass entertainment and everyday trends, as opposed to elite or formal culture.$mq$, $mq$easy$mq$),
($mq$Why did leisure time increase for many British workers during the 19th century?$mq$, $mq$["Factories closed down","Families moved abroad","Children took over adult jobs","Laws limited working hours, wages rose and public holidays were introduced"]$mq$, 3, $mq$Reforms, trade union pressure and the Bank Holiday Act of 1871 gave more time off for many workers.$mq$, $mq$medium$mq$),
($mq$Why was the 1936 Berlin Olympics important to the Nazi regime?$mq$, $mq$["It was boycotted by all countries","It was held in secret","It was used to present a positive image of Germany and promote its ideas","It was the first Games ever"]$mq$, 2, $mq$The regime put on a large display, but Jesse Owens' four gold medals challenged its claims of racial superiority.$mq$, $mq$medium$mq$),
($mq$The United States led a boycott of the 1980 Moscow Olympics and the Soviet Union led a boycott of the 1984 Los Angeles Games. What do these events show?$mq$, $mq$["Sport and politics are separate","Cold War tensions affected sport","The Olympics were cancelled","Both events were held on the same day"]$mq$, 1, $mq$The boycotts show how superpower rivalry spilled into international sport.$mq$, $mq$medium$mq$),
($mq$At the 1968 Mexico City Olympics, medallists Tommie Smith and John Carlos raised gloved fists on the podium. What were they protesting about?$mq$, $mq$["Racial inequality in the United States","Rules about doping","The price of tickets","The location of the Games"]$mq$, 0, $mq$Their gesture drew attention to racial injustice and the civil rights struggle.$mq$, $mq$medium$mq$),
($mq$What was 'ping-pong diplomacy' in 1971?$mq$, $mq$["A war between two table tennis clubs","A ban on sport between nations","A trade deal between Japan and Britain","An American table tennis team visited China, helping to ease relations between the two countries"]$mq$, 3, $mq$The exchange of players was a first step before official political contact.$mq$, $mq$medium$mq$),
($mq$In a fictional country, weekly cinema attendance was 30 million in 1940 and 15 million in 1960. During the same period, television licences rose from 0.1 million to 10 million. What is the percentage fall in cinema attendance, and what is its most likely cause?$mq$, $mq$["15%, the rise of radio","50%, the invention of cinema","50%, the rise of television","30%, the fall of television"]$mq$, 2, $mq$(30 - 15) / 30 = 0.5, so a 50% fall. The rapid growth of television in the same period offers a likely explanation, though other factors may also matter.$mq$, $mq$medium$mq$),
($mq$Rock and roll spread rapidly among teenagers in the 1950s. Which combination best explains its spread?$mq$, $mq$["It was banned in every country","Radio, records and television reached young audiences who had more spending money","It was only played in concert halls","It was invented in 1850"]$mq$, 1, $mq$Mass media and growing teenage spending power helped new music spread quickly.$mq$, $mq$medium$mq$),
($mq$Early rules of amateurism in some sports required that players were not paid. What effect did this often have?$mq$, $mq$["It favoured people wealthy enough to play without pay and excluded many working-class players","It made sport cheaper for everyone","It banned wealthy players","It ended all competitions"]$mq$, 0, $mq$Unpaid play was easier for those with independent income, which linked sport to social class.$mq$, $mq$medium$mq$),
($mq$In 1995 South Africa hosted and won the Rugby World Cup soon after the end of apartheid. Why is this event considered historically significant?$mq$, $mq$["It was the first rugby match ever played","It ended the Cold War","It proved sport has no political effects","It was used to promote national unity in a divided society"]$mq$, 3, $mq$President Nelson Mandela supported the team, and the event became a symbol of reconciliation, though it did not solve all inequalities.$mq$, $mq$hard$mq$),
($mq$A student writes: 'Sport is separate from politics.' Which evidence best challenges this claim?$mq$, $mq$["The rules of football","The number of teams in a league","The 1936 Berlin Games, the 1968 podium protest and the 1980 and 1984 boycotts","The size of a stadium"]$mq$, 2, $mq$These examples show governments and athletes using sport for political messages.$mq$, $mq$hard$mq$),
($mq$A newsreel film of the 1936 Olympics was made by the German state. How should a historian use it?$mq$, $mq$["As a reliable neutral report","As evidence of how the regime wanted to be seen, but not as a neutral record","As worthless because it is a film","As proof that no one criticised the regime"]$mq$, 1, $mq$State-made films serve propaganda purposes. They are valuable for studying the regime's methods and aims.$mq$, $mq$hard$mq$),
($mq$Which feature of leisure shows continuity between 1850 and today?$mq$, $mq$["Sport and music remain ways for communities to gather and share an identity","Television is the main form of entertainment","Everyone has the same amount of leisure time","Cinema is the only popular entertainment"]$mq$, 0, $mq$Social activities such as sport and music have lasted, even though the forms and technology have changed.$mq$, $mq$hard$mq$),
($mq$Which statement best explains how football spread across the world in the 20th century?$mq$, $mq$["It was spread by one inventor","It spread only through military conquest","It was banned in most countries until 1990","British workers, sailors and traders carried the game abroad, and international bodies such as FIFA (1904) and the World Cup (first held in 1930) organised it"]$mq$, 3, $mq$Several factors interacted: contacts through trade and empire, then organisation through FIFA and international tournaments.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Sport, Leisure and Popular Culture$mq$ and p.name = $mq$Everyday Life and Culture$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$First modern Olympics$mq$, $mq$Athens, 1896.$mq$),
($mq$Football Association$mq$, $mq$Founded in England in 1863 to agree common rules for football.$mq$),
($mq$FIFA and first World Cup$mq$, $mq$FIFA was founded in 1904. The first World Cup was held in Uruguay in 1930.$mq$),
($mq$Berlin Olympics 1936$mq$, $mq$Used by the Nazi regime for propaganda. Jesse Owens won four gold medals, challenging its racial claims.$mq$),
($mq$Mexico City 1968 protest$mq$, $mq$Tommie Smith and John Carlos raised gloved fists on the podium to protest racial inequality in the United States.$mq$),
($mq$Olympic boycotts, 1980 and 1984$mq$, $mq$US-led boycott of Moscow 1980. Soviet-led boycott of Los Angeles 1984. Cold War tensions spilled into sport.$mq$),
($mq$Ping-pong diplomacy$mq$, $mq$1971 visit of a US table tennis team to China that helped ease relations between the two countries.$mq$),
($mq$Popular culture$mq$, $mq$Music, film, sport, television and trends enjoyed by large numbers of ordinary people.$mq$),
($mq$Why did leisure time grow in the 19th century?$mq$, $mq$Shorter working hours, rising wages and holidays such as those created by the Bank Holiday Act 1871.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Sport, Leisure and Popular Culture$mq$ and p.name = $mq$Everyday Life and Culture$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Sport, leisure and popular culture
Leisure is time people spend on activities they choose. Sport, music, cinema, radio and television can show how ordinary people lived and what they valued. Popular culture is the entertainment and trends enjoyed by large numbers of people. Historians study it to learn about society, class, gender, identity and politics.

## Key developments
- **More free time**: during the 19th century in Britain, laws limited working hours and the Bank Holiday Act of 1871 created public holidays. As wages and free time grew, so did leisure industries, such as seaside holidays and organised sport.
- **Organised sport**: the Football Association (1863) set common rules. FIFA was founded in 1904 and the first World Cup was held in 1930. The first modern Olympic Games took place in Athens in 1896.
- **Mass media**: cinema became popular early in the 20th century, radio in the 1920s and television in homes after the Second World War. Each new medium reached more people and spread trends faster. Rock and roll in the 1950s spread to teenagers through records, radio and television.
- **Class and sport**: some sports had amateur rules that favoured those who could afford to play without pay, linking sport to social class.

## Sport and politics
Sport is often used for political ends.
- **Berlin 1936**: the Nazi regime used the Olympics to promote a positive image of Germany. Jesse Owens' four gold medals challenged its claims of racial superiority.
- **Mexico City 1968**: Tommie Smith and John Carlos raised gloved fists on the podium to protest racial inequality in the United States.
- **Moscow 1980 and Los Angeles 1984**: boycotts led by the United States and the Soviet Union show the Cold War reaching sport.
- **Ping-pong diplomacy 1971**: an American table tennis team visited China, helping ease relations.
- **South Africa 1995**: the Rugby World Cup was used to promote unity soon after apartheid ended.

## Worked example
A fictional country had weekly cinema attendance of 30 million in 1940 and 15 million in 1960. Percentage change = (15 - 30) / 30 x 100 = -50%. During the same years television ownership grew from 0.1 million to 10 million homes. A reasonable explanation is competition from television, but also consider other factors such as the cost of tickets or changes in lifestyle. Use evidence, not assumption.

## Using leisure as historical evidence
- Films, posters, newsreels and match programmes show what was promoted. State-made films such as 1930s newsreels serve a purpose, so judge their origin and aim.
- Attendance figures show popularity but not why people attended.
- Remember that leisure differed by class, gender and region.

## Common mistakes
- Saying 'sport and politics are separate' without testing the claim.
- Claiming that one factor, such as television, caused everything.
- Forgetting to mention continuity, such as communities still gathering around sport and music.

## How this is examined
Typical tasks give a source such as a poster, a newsreel description or attendance data. You may be asked what the source suggests about leisure and society, how reliable it is, and what other sources would help. Extended questions ask how far leisure changed or how sport has been used for political purposes.

Exam tip: When asked about causes of change in leisure, name at least two factors, such as technology and rising free time, and explain which was more important and why.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('history')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;