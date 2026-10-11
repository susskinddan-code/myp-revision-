-- Part 3 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Health and Wellbeing > Nutrition and Hydration
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Health and Wellbeing$mq$, 5, 3 from public.subjects s where s.slug = $mq$physical-and-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Nutrition and Hydration$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-and-health-education$mq$ and p.grade = 5 and p.name = $mq$Health and Wellbeing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-and-health-education$mq$ and t.grade = 5 and t.name = $mq$Nutrition and Hydration$mq$ and p.name = $mq$Health and Wellbeing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which nutrient is the body's main and fastest source of energy during exercise?$mq$, $mq$["Carbohydrate","Vitamins","Fibre","Calcium"]$mq$, 0, $mq$Carbohydrate is broken down to glucose, which muscles use quickly. Vitamins and minerals help body processes but do not supply energy.$mq$, $mq$easy$mq$),
($mq$Which macronutrient is mainly used for growth and repair of muscle tissue?$mq$, $mq$["Carbohydrate","Water","Iron","Protein"]$mq$, 3, $mq$Protein is made of amino acids, the building blocks used to build and repair tissue.$mq$, $mq$easy$mq$),
($mq$Which mineral is needed for strong bones and teeth?$mq$, $mq$["Iron","Sodium","Calcium","Vitamin C"]$mq$, 2, $mq$Calcium is the main mineral in bone. Iron is used to carry oxygen in the blood.$mq$, $mq$easy$mq$),
($mq$Which of these is a macronutrient?$mq$, $mq$["Vitamin D","Fat","Iron","Zinc"]$mq$, 1, $mq$Carbohydrate, protein and fat are macronutrients, needed in large amounts. Vitamins and minerals are micronutrients.$mq$, $mq$easy$mq$),
($mq$A player's urine is dark yellow after training. What is the most likely cause?$mq$, $mq$["Dehydration","Too much protein","Overhydration","A lack of fibre"]$mq$, 0, $mq$Dark urine is a common sign of dehydration, because the urine is more concentrated when the body is short of water.$mq$, $mq$easy$mq$),
($mq$A snack contains 30 g of carbohydrate, 10 g of protein and 5 g of fat. Using 4 kcal per gram for carbohydrate and protein and 9 kcal per gram for fat, what is its energy content?$mq$, $mq$["165 kcal","450 kcal","45 kcal","205 kcal"]$mq$, 3, $mq$Carbohydrate 30 × 4 = 120, protein 10 × 4 = 40, fat 5 × 9 = 45. The total is 205 kcal. Adding the grams (45) ignores the different energy values.$mq$, $mq$medium$mq$),
($mq$Which statement about fat in the diet is most accurate?$mq$, $mq$["It should be removed from the diet completely","It is the main fuel for short, explosive actions","It provides a concentrated energy source and helps absorb some vitamins","It repairs muscle after training"]$mq$, 2, $mq$Fat gives more energy per gram than carbohydrate or protein and carries fat-soluble vitamins. A small amount is essential.$mq$, $mq$medium$mq$),
($mq$Why is fibre included in a balanced diet?$mq$, $mq$["It is the main source of energy for muscles","It helps digestion and keeps food moving through the gut","It builds new muscle fibres","It replaces water lost in sweat"]$mq$, 1, $mq$Fibre is not digested for energy but supports healthy digestion. Protein, not fibre, builds muscle.$mq$, $mq$medium$mq$),
($mq$A food label shows that a cereal is high in sugar and low in fibre. What is the best conclusion for a student choosing breakfast?$mq$, $mq$["It may give quick energy but is less filling and less balanced than a wholegrain option","It is the best choice before every match","It contains no carbohydrate","It is automatically unhealthy to eat in any amount"]$mq$, 0, $mq$Sugary, low-fibre foods give quick energy but little lasting fullness. A balanced judgement looks at the overall diet, not one food.$mq$, $mq$medium$mq$),
($mq$Which is the best reason for eating a meal rich in carbohydrate a few hours before a long match?$mq$, $mq$["To build new bone","To avoid needing to drink","To increase flexibility","To top up glycogen stores that fuel the muscles"]$mq$, 3, $mq$Carbohydrate is stored as glycogen in muscles and liver and is used during sustained activity.$mq$, $mq$medium$mq$),
($mq$During a hot 90-minute training session, which drinking plan is most sensible for most students?$mq$, $mq$["Drink nothing until the session ends","Drink a large amount just once at the start","Sip water regularly before, during and after","Only drink when severely thirsty"]$mq$, 2, $mq$Regular small drinks help replace sweat. Waiting until you are very thirsty means fluid loss has already begun.$mq$, $mq$medium$mq$),
($mq$Why does sweating during exercise matter for hydration?$mq$, $mq$["Sweating stores water for later","Sweat removes water from the body to cool it, so the water must be replaced","Sweat adds minerals to the blood","Sweating means the body is overhydrated"]$mq$, 1, $mq$Sweat evaporates to cool the body. The lost fluid reduces blood volume and performance unless replaced.$mq$, $mq$medium$mq$),
($mq$Which meal is best described as balanced?$mq$, $mq$["Grilled chicken, rice and mixed vegetables with water","Chips and a fizzy drink","A large bowl of sweets","White bread only"]$mq$, 0, $mq$A balanced meal combines carbohydrate, protein, vegetables (vitamins, minerals, fibre) and a sensible drink.$mq$, $mq$medium$mq$),
($mq$Two students each drink the same amount of water per day. Maya trains for 2 hours in the heat and Leo is inactive. Which statement is the best evaluation?$mq$, $mq$["Both are certainly hydrated because the amount is equal","Leo needs more because he is inactive","Neither needs more because water needs are fixed","Maya probably needs more fluid because she loses more through sweat"]$mq$, 3, $mq$Fluid needs depend on activity, temperature and body size. Equal intake does not mean equal need.$mq$, $mq$hard$mq$),
($mq$A student says: 'Protein shakes are necessary for every teenager to build muscle.' Which response is the most accurate?$mq$, $mq$["Correct, food alone can never supply protein","Protein is only needed by adults","Most teenagers get enough protein from a varied diet, and training also drives muscle change","Protein shakes replace the need for training"]$mq$, 2, $mq$Meat, fish, eggs, dairy, beans and nuts supply protein. Muscle growth needs training, rest and overall nutrition, not just supplements.$mq$, $mq$hard$mq$),
($mq$An investigation compares two drinks on 10 students' performance in a repeated sprint test. Which change would make the results more valid?$mq$, $mq$["Let students choose which drink to have","Keep the test, time of day and warm-up the same for both drinks","Use a different test for each drink","Test one drink in the morning and the other at night"]$mq$, 1, $mq$A fair test changes one variable (the drink) and controls the others, such as the test, timing and warm-up.$mq$, $mq$hard$mq$),
($mq$A food label lists per 100 g: carbohydrate 60 g, protein 8 g, fat 10 g. Using 4, 4 and 9 kcal per gram, which statement is correct?$mq$, $mq$["Fat provides 90 kcal and carbohydrate 240 kcal per 100 g","Fat provides the largest share of energy","Protein provides 80 kcal","The food provides 78 kcal in total"]$mq$, 0, $mq$Carbohydrate 60 × 4 = 240, protein 8 × 4 = 32, fat 10 × 9 = 90. Carbohydrate gives the largest share, and the total is 362 kcal.$mq$, $mq$hard$mq$),
($mq$A student wants to evaluate whether their own diet is balanced. Which approach gives the most useful evidence?$mq$, $mq$["Remember what they ate yesterday only","Count only the snacks","Ask a friend what they think","Record all food and drink for several days and compare it with food-group guidelines"]$mq$, 3, $mq$A multi-day record gives a fuller and more reliable picture than one day's memory. It can then be compared with guidelines.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-and-health-education$mq$ and t.grade = 5 and t.name = $mq$Nutrition and Hydration$mq$ and p.name = $mq$Health and Wellbeing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Name the three macronutrients$mq$, $mq$Carbohydrate, protein and fat. They are needed in large amounts and supply energy (water is also needed in large amounts but gives no energy).$mq$),
($mq$Main role of carbohydrate$mq$, $mq$The body's main and fastest energy source. It is stored as glycogen in the muscles and liver.$mq$),
($mq$Main role of protein$mq$, $mq$Growth and repair of body tissue, including muscle. It is made of amino acids.$mq$),
($mq$Energy per gram of each macronutrient$mq$, $mq$Carbohydrate about 4 kcal/g, protein about 4 kcal/g, fat about 9 kcal/g.$mq$),
($mq$Why do athletes need iron?$mq$, $mq$Iron is used to make haemoglobin in red blood cells, which carries oxygen to the muscles.$mq$),
($mq$Why is calcium important?$mq$, $mq$It builds and maintains strong bones and teeth and helps muscles work.$mq$),
($mq$What is dehydration?$mq$, $mq$Losing more water than you take in. Signs include thirst, headache, dark urine, tiredness and poorer concentration.$mq$),
($mq$Simple check of good hydration$mq$, $mq$Pale yellow urine suggests good hydration. Dark yellow suggests you need to drink more.$mq$),
($mq$What is a balanced diet?$mq$, $mq$A variety of foods giving the right amounts of all nutrients, water and fibre for your age, size and activity level.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-and-health-education$mq$ and t.grade = 5 and t.name = $mq$Nutrition and Hydration$mq$ and p.name = $mq$Health and Wellbeing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Nutrition is about giving your body the fuel and materials it needs to grow, move, think and recover. Good nutrition and hydration support performance, health and mood.

## Nutrients
- **Carbohydrates** are the main energy source, especially for activity. They are stored as glycogen in muscles and the liver. Sources include rice, pasta, bread, fruit and potatoes.
- **Proteins** are used for growth and repair. They are made of amino acids. Sources include fish, eggs, meat, dairy, beans and nuts.
- **Fats** provide a concentrated energy store, protect organs and carry some vitamins. Small amounts are essential.
- **Vitamins and minerals** are micronutrients needed in small amounts. Calcium builds bones, iron helps blood carry oxygen and vitamin C supports healing.
- **Fibre** is not used for energy, but keeps the digestive system working well.
- **Water** is involved in almost every process in the body.

## Energy values
Carbohydrate and protein give about 4 kcal per gram, and fat gives about 9 kcal per gram. Worked example: a meal has 50 g carbohydrate, 20 g protein and 10 g fat. Energy = (50 × 4) + (20 × 4) + (10 × 9) = 200 + 80 + 90 = 370 kcal. Always multiply each nutrient by its own value before adding.

## A balanced diet
A balanced diet contains the right mix of nutrients from a variety of foods, in amounts that match your age, activity and size. No single food is "good" or "bad" on its own; it is the overall pattern over days and weeks that matters. Reading food labels helps you compare foods, noticing sugar, fat, salt and fibre content.

## Hydration
Your body loses water through sweat, breathing and urine. During exercise sweat cools the body, but losing too much fluid is called **dehydration**. Signs include thirst, headache, tiredness, dark yellow urine and poorer concentration. Performance can fall even with mild dehydration.
- Drink regularly through the day, and before, during and after activity.
- Drink more in hot weather or long sessions.
- Pale yellow urine is a simple sign of good hydration.
- Drinking an extreme amount is also unsafe, so sip steadily rather than gulp.

## Timing of food
Eating a meal with carbohydrate a few hours before exercise helps fill energy stores. Afterwards, food containing protein and carbohydrate supports recovery.

## Common mistakes
- Adding grams of nutrients instead of multiplying by their energy values.
- Believing supplements are needed by everyone; most young people can meet needs with varied food.
- Waiting until you feel very thirsty to drink.
- Thinking fat or carbohydrate should be removed completely.

## How this is examined
You may be given a short scenario, such as an athlete's meal or a food label, and asked to identify nutrients, calculate energy, explain the role of hydration or evaluate whether a plan is balanced. Command words such as describe, explain and evaluate decide the depth: describe states what happens, explain gives reasons, and evaluate weighs strengths and limits using evidence from the scenario.

Exam tip: When asked to evaluate a diet or drinking plan, name the nutrient or fluid, state its function, then link it to the person in the scenario, for example their sport, climate or training time.$mq$ from st;

-- Health and Wellbeing > Physical, Social and Mental Wellbeing
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Health and Wellbeing$mq$, 5, 3 from public.subjects s where s.slug = $mq$physical-and-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Physical, Social and Mental Wellbeing$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-and-health-education$mq$ and p.grade = 5 and p.name = $mq$Health and Wellbeing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-and-health-education$mq$ and t.grade = 5 and t.name = $mq$Physical, Social and Mental Wellbeing$mq$ and p.name = $mq$Health and Wellbeing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which of these is an example of physical wellbeing?$mq$, $mq$["Having the energy to complete everyday activities","Feeling included in a group","Coping calmly with worry","Having supportive friendships"]$mq$, 0, $mq$Physical wellbeing is about the body: energy, fitness, health and the ability to do daily tasks.$mq$, $mq$easy$mq$),
($mq$Which of these is an example of social wellbeing?$mq$, $mq$["Having strong muscles","Eating regularly","Having low body fat","Having friendships and feeling that you belong"]$mq$, 3, $mq$Social wellbeing is about relationships, belonging and communication with others.$mq$, $mq$easy$mq$),
($mq$Which of these is an example of mental wellbeing?$mq$, $mq$["Being able to run 5 km","Having good flexibility","Managing emotions and feeling able to cope with challenges","Having a balanced diet"]$mq$, 2, $mq$Mental (and emotional) wellbeing is about thoughts, feelings and coping.$mq$, $mq$easy$mq$),
($mq$The World Health Organization describes health as$mq$, $mq$["having no illness","a state of physical, mental and social wellbeing, not only the absence of disease","being able to play a sport","having a high level of fitness"]$mq$, 1, $mq$Health is wider than not being ill. It includes physical, mental and social aspects together.$mq$, $mq$easy$mq$),
($mq$For young people aged 5 to 17, the World Health Organization recommends an average of how much moderate-to-vigorous physical activity per day?$mq$, $mq$["60 minutes","10 minutes","20 minutes","3 hours"]$mq$, 0, $mq$The recommendation is an average of at least 60 minutes a day, across the week.$mq$, $mq$easy$mq$),
($mq$Which activity most clearly improves social wellbeing as well as physical wellbeing?$mq$, $mq$["Exercising alone at night every day","Watching a match on television","Skipping meals before training","Joining a team sport or group class"]$mq$, 3, $mq$Team and group activity combines exercise with teamwork, friendships and belonging.$mq$, $mq$medium$mq$),
($mq$After a stressful week, Ana goes for a walk with a friend and feels calmer. Which aspects of wellbeing has she most improved?$mq$, $mq$["Physical only","Social only","Physical, social and mental","None, because walking is not intense"]$mq$, 2, $mq$The walk is physical activity, the friend adds social contact, and feeling calmer is a mental benefit. Wellbeing areas are linked.$mq$, $mq$medium$mq$),
($mq$Which statement shows that the three areas of wellbeing are linked?$mq$, $mq$["Physical health has no effect on mood","Poor sleep can lower mood and make social contact harder","Friendships only affect the body","Mental wellbeing is separate from everything else"]$mq$, 1, $mq$A problem in one area often affects the others. For example, poor sleep affects mood, energy and relationships.$mq$, $mq$medium$mq$),
($mq$Which of these is a regular physical activity benefit for mental wellbeing?$mq$, $mq$["Release of chemicals that can improve mood and reduce feelings of stress","Permanent removal of all worries","Immediate fitness gains","Guaranteed better grades"]$mq$, 0, $mq$Exercise can improve mood and help manage stress, but it does not remove every problem.$mq$, $mq$medium$mq$),
($mq$A student feels left out and stops going to training. What is the most helpful first step?$mq$, $mq$["Quit all activities","Train harder alone to feel better","Ignore the feeling and hope it goes","Talk to a trusted friend, coach or teacher about how they feel"]$mq$, 3, $mq$Talking to a trusted person is a positive coping strategy. Withdrawing completely often makes feelings worse.$mq$, $mq$medium$mq$),
($mq$Which of these is a risk of very low physical activity over many years?$mq$, $mq$["Better sleep always","Stronger bones","Higher chance of conditions such as heart disease and weight gain","Guaranteed higher fitness"]$mq$, 2, $mq$Regular activity protects health. Inactivity is linked with several long-term health risks.$mq$, $mq$medium$mq$),
($mq$Which behaviour best supports positive social wellbeing?$mq$, $mq$["Teasing people to fit in","Listening to others and including them in activities","Avoiding every group","Competing against friends in every situation"]$mq$, 1, $mq$Respect, communication and inclusion strengthen relationships.$mq$, $mq$medium$mq$),
($mq$A school offers lunchtime clubs for walking, chess and dance. Which reason best explains why a variety is useful?$mq$, $mq$["Different students enjoy different activities, so more of them stay active and connected","Everyone should do the same activity","Only sports are good for wellbeing","Clubs have no effect on friendships"]$mq$, 0, $mq$Choice increases participation and allows different wellbeing needs, physical, social and mental, to be met.$mq$, $mq$medium$mq$),
($mq$Which is the best example of a healthy way to cope with a stressful exam period?$mq$, $mq$["Avoiding all activity to save time","Staying up all night to study","Keeping worries secret","Short breaks, activity, sleep and talking to others"]$mq$, 3, $mq$Healthy coping strategies protect physical and mental wellbeing and keep support available.$mq$, $mq$hard$mq$),
($mq$A student spends most free time on screens, rarely sees friends and feels low. Which plan would best improve their overall wellbeing?$mq$, $mq$["Remove all screens permanently","Train alone for two hours daily","Set screen limits and schedule active, social time with friends","Do nothing, since feelings always pass quickly"]$mq$, 2, $mq$A balanced plan works on all three areas. Extreme changes are hard to keep, and ignoring the problem may not help.$mq$, $mq$hard$mq$),
($mq$Which evidence would be most reliable for judging whether a school's wellbeing programme works?$mq$, $mq$["The opinion of one student","Surveys and activity records from many students before and after the programme","The teacher's guess","The number of posters displayed"]$mq$, 1, $mq$Data from many students collected before and after gives a fairer comparison than one opinion.$mq$, $mq$hard$mq$),
($mq$A student says: 'Being healthy only means not being ill.' Which is the best response?$mq$, $mq$["Health also includes mental and social wellbeing, so someone can be free of illness and still struggle","That is correct","Health only means fitness","Health is only about diet"]$mq$, 0, $mq$Health is multi-dimensional. A person without disease may still have low mood or poor social connection.$mq$, $mq$hard$mq$),
($mq$Which statement is the best evaluation of a 30-minute walk each day for a student who was previously inactive?$mq$, $mq$["It guarantees perfect health","It is useless unless intense","It only helps social wellbeing","It supports physical health and mood, though it should be combined with sleep, food and social contact"]$mq$, 3, $mq$Moderate regular activity brings real benefits, but wellbeing depends on several lifestyle factors together.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-and-health-education$mq$ and t.grade = 5 and t.name = $mq$Physical, Social and Mental Wellbeing$mq$ and p.name = $mq$Health and Wellbeing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Define health (WHO)$mq$, $mq$A state of complete physical, mental and social wellbeing, and not merely the absence of disease or illness.$mq$),
($mq$Physical wellbeing$mq$, $mq$How well the body is functioning: energy, fitness, growth, sleep, nutrition and the ability to carry out daily activities.$mq$),
($mq$Social wellbeing$mq$, $mq$Having healthy relationships, a sense of belonging, good communication and feeling included and respected.$mq$),
($mq$Mental and emotional wellbeing$mq$, $mq$Being able to manage thoughts and emotions, cope with pressure, feel confident and ask for help when needed.$mq$),
($mq$Recommended daily activity for ages 5 to 17 (WHO)$mq$, $mq$An average of at least 60 minutes of moderate-to-vigorous physical activity per day across the week.$mq$),
($mq$Give a link between physical and mental wellbeing$mq$, $mq$Regular exercise can improve mood and reduce stress, while poor sleep or inactivity can lower mood and energy.$mq$),
($mq$Give a way sport supports social wellbeing$mq$, $mq$Teamwork, shared goals and friendships build belonging, communication and respect for others.$mq$),
($mq$Healthy coping strategy for stress$mq$, $mq$Talk to someone you trust, take a break, be active, sleep well and plan your time. Asking for help is a strength.$mq$),
($mq$Why is health described as multi-dimensional?$mq$, $mq$Because physical, social and mental parts are linked and all affect overall wellbeing, not just the absence of illness.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-and-health-education$mq$ and t.grade = 5 and t.name = $mq$Physical, Social and Mental Wellbeing$mq$ and p.name = $mq$Health and Wellbeing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Wellbeing means how well you are in your whole life, not just whether you are ill. In PHE we study three linked parts: physical, social and mental (including emotional) wellbeing. The World Health Organization describes health as a state of physical, mental and social wellbeing, not merely the absence of disease.

## Physical wellbeing
This is about the body. It includes energy levels, fitness, healthy growth, sleep and nutrition. Regular activity builds the heart, lungs, muscles and bones and lowers the risk of long-term health problems. For young people aged 5 to 17 the World Health Organization recommends an average of at least 60 minutes of moderate-to-vigorous physical activity a day.

## Social wellbeing
This is about relationships and belonging. It includes friendships, family, teamwork, communication, respect and feeling included. Sport and group activity give chances to cooperate, make friends and build a sense of identity. Social wellbeing can be harmed by bullying, exclusion and long periods of isolation.

## Mental and emotional wellbeing
This is about thoughts and feelings. It includes managing emotions, coping with pressure, having confidence and feeling that life has purpose. Everyone has ups and downs, and good mental wellbeing does not mean always feeling happy. It means being able to cope, ask for help and recover.

## How the parts connect
The three areas affect each other. For example:
- Exercise (physical) can improve mood (mental) and is often done with others (social).
- Feeling left out (social) can lower confidence (mental) and make you less likely to be active (physical).
- Poor sleep (physical) can make you more irritable (mental) and harder to be around (social).

## Ways to support wellbeing
- Be active in ways you enjoy, such as team games, dance, walking or swimming.
- Eat a variety of foods and drink enough water.
- Keep contact with friends and family, and include others.
- Take breaks from screens and schoolwork.
- Talk to a trusted adult, friend, coach or school counsellor when things feel difficult. Asking for help is a strength.

## Common mistakes
- Treating health as only physical.
- Claiming exercise "fixes" every problem; it helps, but it works alongside sleep, food and support.
- Writing about only one type of wellbeing when the question asks for all three.

## How this is examined
Questions often give a short scenario about a student or school and ask you to identify which type of wellbeing is affected, explain links between the types, or evaluate a plan to improve wellbeing. Higher marks come from using evidence from the scenario and showing how one area influences another.

Exam tip: When a question mentions a person's feelings, friends and activity, comment on all three types of wellbeing and explain at least one link between them.$mq$ from st;

-- Health and Wellbeing > Sleep, Stress and Lifestyle
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Health and Wellbeing$mq$, 5, 3 from public.subjects s where s.slug = $mq$physical-and-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Sleep, Stress and Lifestyle$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-and-health-education$mq$ and p.grade = 5 and p.name = $mq$Health and Wellbeing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-and-health-education$mq$ and t.grade = 5 and t.name = $mq$Sleep, Stress and Lifestyle$mq$ and p.name = $mq$Health and Wellbeing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$How many hours of sleep per night are generally recommended for teenagers?$mq$, $mq$["8 to 10 hours","3 to 4 hours","5 to 6 hours","12 to 14 hours"]$mq$, 0, $mq$Teenagers usually need about 8 to 10 hours for growth, learning and recovery.$mq$, $mq$easy$mq$),
($mq$During sleep, which process happens in the body?$mq$, $mq$["Muscles stop being able to repair","Energy stores are used up completely","Hydration is no longer needed","Growth and repair of tissues"]$mq$, 3, $mq$Much tissue repair and growth occurs during sleep, and the brain processes information.$mq$, $mq$easy$mq$),
($mq$Which of these is a stressor?$mq$, $mq$["A good night's sleep","A walk in the park","An upcoming exam","A healthy meal"]$mq$, 2, $mq$A stressor is anything that triggers the stress response, such as a deadline or pressure.$mq$, $mq$easy$mq$),
($mq$Which hormone is released in the 'fight or flight' response and raises heart rate?$mq$, $mq$["Insulin","Adrenaline","Calcium","Haemoglobin"]$mq$, 1, $mq$Adrenaline prepares the body for action by increasing heart rate and breathing rate.$mq$, $mq$easy$mq$),
($mq$Which of these is a sedentary behaviour?$mq$, $mq$["Sitting watching television for long periods","Cycling to school","Playing football","Dancing"]$mq$, 0, $mq$Sedentary means sitting or lying with very low energy use.$mq$, $mq$easy$mq$),
($mq$Which habit most helps a student fall asleep more easily?$mq$, $mq$["Drinking energy drinks late in the evening","Napping for hours late in the afternoon","Studying in bed with the lights on","Keeping a regular bedtime and avoiding screens just before bed"]$mq$, 3, $mq$A routine and a calm, screen-free wind-down support sleep. Caffeine late in the day can delay it.$mq$, $mq$medium$mq$),
($mq$Why might lack of sleep reduce sporting performance?$mq$, $mq$["It increases muscle strength","It improves coordination","Reaction time, concentration and recovery are all reduced","It gives more energy"]$mq$, 2, $mq$Tiredness slows reactions, harms decisions and limits recovery, and also raises injury risk.$mq$, $mq$medium$mq$),
($mq$Which of these is a short-term physical sign of stress?$mq$, $mq$["Stronger bones","Faster heartbeat and sweaty palms","Improved flexibility","Lower resting heart rate"]$mq$, 1, $mq$The stress response raises heart rate and breathing and can cause sweating.$mq$, $mq$medium$mq$),
($mq$Which is an example of positive stress (eustress)?$mq$, $mq$["Feeling excited and alert before a match","Constant worry that lasts for weeks","Feeling too overwhelmed to start","Losing sleep from fear"]$mq$, 0, $mq$Positive stress can motivate and sharpen focus. Long-lasting, overwhelming stress is harmful.$mq$, $mq$medium$mq$),
($mq$A student is on screens until midnight and wakes tired. Which change is most likely to help?$mq$, $mq$["Sleep less to adjust","Add an evening coffee","Do more late-night homework","Switch screens off an hour before bed and keep a fixed bedtime"]$mq$, 3, $mq$Reducing bright light and stimulation before bed helps the body prepare for sleep.$mq$, $mq$medium$mq$),
($mq$Which lifestyle choice is a risk to long-term health?$mq$, $mq$["Walking to school","Eating varied foods","Smoking or vaping","Sleeping regularly"]$mq$, 2, $mq$Smoking and vaping harm the lungs and heart and carry addiction risks.$mq$, $mq$medium$mq$),
($mq$Which strategy is most likely to reduce exam stress?$mq$, $mq$["Leaving all revision to the night before","Making a realistic study plan with breaks","Skipping meals","Avoiding talking to anyone"]$mq$, 1, $mq$Planning spreads work out and gives a sense of control. Good food and breaks help focus.$mq$, $mq$medium$mq$),
($mq$Why can long periods of high stress harm health?$mq$, $mq$["Stress hormones stay high, which can affect sleep, mood and the immune system","Stress always improves immunity","Stress has only mental effects","It increases sleep quality"]$mq$, 0, $mq$Short bursts are normal, but ongoing stress can disturb sleep, mood and the body's defences.$mq$, $mq$medium$mq$),
($mq$A student sleeps 6 hours each school night, but the recommendation for teenagers is 9 hours. How much sleep is lost over 5 school nights compared with the recommendation?$mq$, $mq$["3 hours","9 hours","30 hours","15 hours"]$mq$, 3, $mq$Each night is 9 − 6 = 3 hours short. Over five nights that is 3 × 5 = 15 hours.$mq$, $mq$hard$mq$),
($mq$A student's weekly log: Mon 9 h of screen time for entertainment, 0 min activity; Tue 8 h, 10 min; Wed 9 h, 0 min. Which conclusion is best supported?$mq$, $mq$["They are very active","Screen time is low","Their lifestyle is mainly sedentary and below activity guidance","The data is too small to say anything at all"]$mq$, 2, $mq$Almost no activity and long screen time shows a mostly sedentary pattern. Three days still give some evidence, though more days would be better.$mq$, $mq$hard$mq$),
($mq$Which plan is the best evaluation of how to balance schoolwork, sport and rest?$mq$, $mq$["Dropping sport entirely before exams","A weekly timetable that includes study, activity, meals, social time and enough sleep","Studying until very late each night","Doing all activity on one day"]$mq$, 1, $mq$A balanced timetable protects all parts of wellbeing. Removing activity or sleep can reduce both health and learning.$mq$, $mq$hard$mq$),
($mq$A coach notices a player is tired, irritable and making more mistakes. Which action is most appropriate?$mq$, $mq$["Discuss sleep, workload and stress with the player and adjust training if needed","Add extra sessions to build resilience","Ignore it as laziness","Tell the player to drink a caffeinated drink"]$mq$, 0, $mq$These are common signs of poor recovery or stress. A supportive conversation and adjustment are better than pushing harder.$mq$, $mq$hard$mq$),
($mq$Which statement correctly links lifestyle choices and long-term health?$mq$, $mq$["One day's choices decide your lifelong health","Lifestyle only affects health in old age","Only genetics matter","Habits such as activity, diet, sleep and avoiding smoking build up over years to affect risk of illness"]$mq$, 3, $mq$Genes matter, but repeated everyday habits strongly influence long-term health.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-and-health-education$mq$ and t.grade = 5 and t.name = $mq$Sleep, Stress and Lifestyle$mq$ and p.name = $mq$Health and Wellbeing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Recommended sleep for teenagers$mq$, $mq$About 8 to 10 hours per night, for growth, repair, learning and mood.$mq$),
($mq$Two effects of too little sleep on performance$mq$, $mq$Slower reactions and poorer concentration. Recovery is also reduced and injury risk can rise.$mq$),
($mq$What is a stressor?$mq$, $mq$Anything that causes the body to feel pressure or stress, for example exams, competition, conflict or deadlines.$mq$),
($mq$What happens in the fight or flight response?$mq$, $mq$Adrenaline is released and heart rate, breathing rate and muscle tension increase to prepare for action.$mq$),
($mq$Eustress versus distress$mq$, $mq$Eustress is positive, motivating stress. Distress is overwhelming or long-lasting stress that harms health and performance.$mq$),
($mq$Name three ways to manage stress$mq$, $mq$Plan your time, be active, use breathing or relaxation, talk to someone you trust, and keep time for hobbies and friends.$mq$),
($mq$What is sedentary behaviour?$mq$, $mq$Sitting or lying down for long periods with very low energy use, such as long screen time.$mq$),
($mq$Good sleep habits$mq$, $mq$Regular bedtime, a calm screen-free wind-down, no late caffeine, a cool dark room and daytime activity.$mq$),
($mq$Why do daily habits matter for long-term health?$mq$, $mq$Repeated habits like activity, diet, sleep and avoiding smoking build up over years and affect risk of illness.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-and-health-education$mq$ and t.grade = 5 and t.name = $mq$Sleep, Stress and Lifestyle$mq$ and p.name = $mq$Health and Wellbeing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Your lifestyle is the pattern of everyday habits you follow: sleeping, eating, moving, relaxing and how you deal with pressure. These habits add up over time and affect your fitness, mood, learning and long-term health.

## Sleep
Teenagers generally need about 8 to 10 hours a night. During sleep the body repairs tissue and releases hormones needed for growth, and the brain organises memories and learning. Too little sleep can lead to:
- slower reaction time and poorer concentration;
- lower mood and more irritability;
- slower recovery after exercise and a higher risk of injury;
- weaker decisions in sport and in school.

Habits that support sleep:
- a regular bedtime and wake time;
- a calm routine and a cool, dark room;
- avoiding screens, caffeine and heavy meals close to bedtime;
- daytime activity and daylight.

## Stress
A **stressor** is anything that puts you under pressure, such as exams, a big match or conflict with friends. The body responds with the "fight or flight" reaction: adrenaline is released, and heart rate, breathing rate and muscle tension increase. This is useful in short bursts and can even help performance (this is sometimes called **eustress**). When stress is strong or lasts a long time, it can cause tiredness, headaches, poor sleep, low mood and difficulty concentrating (**distress**).

Ways to manage stress:
- plan your time and break big tasks into small ones;
- be physically active;
- use breathing or relaxation techniques;
- talk to a trusted person;
- keep time for hobbies and friends.

## Lifestyle choices
**Sedentary behaviour** means sitting or lying for long periods. Too much of it, especially long screen time, is linked to lower fitness and poorer health. Taking regular movement breaks helps. Other lifestyle risks include smoking and vaping, which harm lungs and circulation. Healthy habits, such as being active, eating a variety of foods, sleeping well and staying connected with others, protect health over the long term.

## Worked example
A student sleeps 6 hours on school nights, but needs about 9. The shortfall each night is 9 − 6 = 3 hours, so over five nights it is 3 × 5 = 15 hours. This is why weekend lie-ins may not fully make up for the effect, so a regular routine is better.

## Common mistakes
- Saying all stress is bad; short-term stress can help.
- Suggesting extreme changes that are unrealistic to keep.
- Forgetting that sleep, stress and activity affect one another.

## How this is examined
Expect a case study of a student or athlete with a lifestyle problem, followed by questions asking you to identify causes, explain effects and recommend realistic changes. Evaluate command terms ask for strengths and limits of the plan.

Exam tip: Give recommendations that are specific and realistic, such as "switch off screens one hour before bed", and explain which benefit each one brings.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('physical-and-health-education')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;