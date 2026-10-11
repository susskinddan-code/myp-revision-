-- Part 5 of 5: 1 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Technology and Society > Impacts of Technology
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Technology and Society$mq$, 5, 4 from public.subjects s where s.slug = $mq$digital-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Impacts of Technology$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$digital-design$mq$ and p.grade = 5 and p.name = $mq$Technology and Society$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Impacts of Technology$mq$ and p.name = $mq$Technology and Society$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the 'digital divide'?$mq$, $mq$["The gap between people who have access to technology and those who do not","A crack in a phone screen","A type of computer file","A division in a spreadsheet"]$mq$, 0, $mq$The digital divide describes unequal access to devices, the internet and digital skills.$mq$, $mq$easy$mq$),
($mq$Which is a positive impact of technology on communication?$mq$, $mq$["Phones always run out of battery","All messages are private","Everyone must use the same app","People can contact others across the world instantly"]$mq$, 3, $mq$Technology allows fast, low-cost communication over long distances.$mq$, $mq$easy$mq$),
($mq$What is e-waste?$mq$, $mq$["Email that is deleted","Unwanted adverts","Discarded electronic devices such as old phones and laptops","Wasted internet data"]$mq$, 2, $mq$E-waste includes old electronic products. It can contain harmful materials if not recycled properly.$mq$, $mq$easy$mq$),
($mq$Which is an example of automation?$mq$, $mq$["A person writing a letter by hand","A robot arm welding car parts","A teacher speaking in class","A student reading a book"]$mq$, 1, $mq$Automation uses machines or software to do tasks with little human input.$mq$, $mq$easy$mq$),
($mq$Which is a health concern linked to heavy screen use?$mq$, $mq$["Eye strain and disrupted sleep","Faster running","Stronger hearing","Lower rent"]$mq$, 0, $mq$Long periods on screens can cause eye strain, poor posture and tired sleep patterns if breaks are not taken.$mq$, $mq$easy$mq$),
($mq$A town replaces cashiers with self-service tills. Which is a likely social impact?$mq$, $mq$["Cheaper bread for everyone, always","All shops will close","No one will use money","Some cashier jobs may disappear while other technical jobs appear"]$mq$, 3, $mq$Automation can remove some roles while creating new ones, so workers may need retraining.$mq$, $mq$medium$mq$),
($mq$Which action reduces the environmental impact of a phone?$mq$, $mq$["Replacing it every month","Throwing it in a bin","Repairing it and recycling it at the end of its life","Leaving it charging all day"]$mq$, 2, $mq$Repair and proper recycling reduce resource use and pollution from manufacturing and waste.$mq$, $mq$medium$mq$),
($mq$Online learning platforms let rural students attend lessons from far away. Which condition is needed for this benefit to reach everyone?$mq$, $mq$["Everyone owns a car","Everyone has reliable internet and a suitable device","Lessons must be shorter","Teachers must stop using computers"]$mq$, 1, $mq$Without access to devices and connections, the benefit does not reach people on the wrong side of the digital divide.$mq$, $mq$medium$mq$),
($mq$Which is an advantage of cloud storage?$mq$, $mq$["Files can be accessed from different devices with internet access","It never needs electricity","It cannot be hacked","It makes files larger"]$mq$, 0, $mq$Cloud storage syncs files across devices, though it needs a connection and good security.$mq$, $mq$medium$mq$),
($mq$A social media app uses an algorithm that shows users more of what they already like. Which problem can this cause?$mq$, $mq$["The app uses less data","Users forget how to type","The screen becomes brighter","Users may only see similar views, creating a 'filter bubble'"]$mq$, 3, $mq$Recommendation systems can narrow what we see, which may reinforce existing views.$mq$, $mq$medium$mq$),
($mq$Which statement best describes a social benefit of assistive technology such as screen readers?$mq$, $mq$["It only benefits games","It makes devices cost less","It helps people with disabilities access information and take part","It replaces all teachers"]$mq$, 2, $mq$Assistive technology removes barriers and supports inclusion.$mq$, $mq$medium$mq$),
($mq$A factory buys robots that produce 480 units a day. Before, 12 workers produced 20 units each a day. How many extra units per day does the robot add?$mq$, $mq$["120","240","480","720"]$mq$, 1, $mq$Before: 12 × 20 = 240. Robots: 480. Increase is 480 − 240 = 240 units.$mq$, $mq$medium$mq$),
($mq$Which is an environmental cost of the growth in data centres?$mq$, $mq$["They use large amounts of electricity and cooling water","They reduce all pollution","They cost nothing to run","They make Wi-Fi invisible"]$mq$, 0, $mq$Data centres require energy and cooling, which has an environmental impact unless powered by renewable sources.$mq$, $mq$medium$mq$),
($mq$A company claims its new smartwatch is 'green' because it is small. Which evidence would best test this claim?$mq$, $mq$["Its colour options","The number of adverts for it","The price of the strap","A life-cycle assessment covering materials, energy use, repair and recycling"]$mq$, 3, $mq$A claim about environmental impact should be tested across the whole life cycle, not just one feature such as size.$mq$, $mq$hard$mq$),
($mq$A city uses facial recognition cameras to cut crime. Which evaluation is most balanced?$mq$, $mq$["It is good because crime always falls","It is bad because cameras are ugly","It may improve safety but raises privacy, accuracy and fairness concerns that need rules and oversight","It is irrelevant to society"]$mq$, 2, $mq$Evaluating technology means weighing benefits against risks and considering who is affected and what safeguards exist.$mq$, $mq$hard$mq$),
($mq$A school gives every student a tablet, but 15% of families have no home internet. Out of 600 students, how many may be unable to complete online homework at home, and what is the best response?$mq$, $mq$["15 students; ignore it","90 students; provide offline work or loan Wi-Fi so no one is disadvantaged","600 students; cancel tablets","60 students; do nothing"]$mq$, 1, $mq$15% of 600 = 90 students. A fair response addresses the access gap, for example with offline tasks or loaned connections.$mq$, $mq$hard$mq$),
($mq$A designer wants a low-impact product. Which pair of decisions best supports sustainability?$mq$, $mq$["Make parts replaceable and use recycled materials","Use glued parts and a sealed battery","Add more packaging for protection","Release a new model every year"]$mq$, 0, $mq$Repairable designs and recycled materials extend product life and reduce resource use. Sealed, glued products are harder to repair or recycle.$mq$, $mq$hard$mq$),
($mq$An article says, 'AI will take all jobs, so we should stop developing it.' Which response shows the best critical thinking?$mq$, $mq$["Agree, because change is always bad","Disagree, because technology never has costs","Ignore it, because articles are never useful","Examine evidence on which tasks are automated, which new jobs appear, and how workers can retrain, before deciding"]$mq$, 3, $mq$A strong answer separates evidence from opinion, considers both costs and benefits, and avoids absolute claims.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Impacts of Technology$mq$ and p.name = $mq$Technology and Society$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Digital divide$mq$, $mq$The gap between people who have access to technology, internet and digital skills and those who do not.$mq$),
($mq$Automation$mq$, $mq$Using machines or software to carry out tasks with little human input; it can raise productivity but change or remove some jobs.$mq$),
($mq$E-waste$mq$, $mq$Discarded electronic products such as phones and laptops, which can release harmful materials if not recycled well.$mq$),
($mq$Assistive technology$mq$, $mq$Tools such as screen readers, captions and speech recognition that help people with disabilities access and use technology.$mq$),
($mq$Filter bubble$mq$, $mq$A situation where algorithms show you mostly content similar to what you already like, narrowing the views you see.$mq$),
($mq$Life-cycle assessment$mq$, $mq$A review of a product's environmental impact from materials and manufacture through use to disposal and recycling.$mq$),
($mq$Three categories of impact$mq$, $mq$Social, economic and environmental. Strong evaluations consider benefits and risks in each.$mq$),
($mq$Why do data centres matter environmentally?$mq$, $mq$They use large amounts of electricity and cooling water, so their energy source and efficiency affect pollution.$mq$),
($mq$How to structure an evaluation$mq$, $mq$Benefit, risk, who is affected, evidence, and a justified conclusion or recommendation.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Impacts of Technology$mq$ and p.name = $mq$Technology and Society$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Technology changes the way we live, learn, work and relate to each other. In design, you need to do more than describe these changes. You must **evaluate** them: weigh benefits and risks, think about who is affected, and suggest improvements. It helps to organise impacts into **social**, **economic** and **environmental** categories, and to ask whether the effect is positive, negative or both.

## Social impacts
- **Communication**: messaging and video calls connect families and communities across the world instantly. However, they can also spread misinformation and encourage unhealthy comparison.
- **Education**: online platforms, simulations and digital libraries give access to learning. This only helps people who have devices and internet.
- **Inclusion**: **assistive technology**, such as screen readers, speech recognition and captions, removes barriers for people with disabilities.
- **Health and wellbeing**: apps can support exercise and mental health, but heavy screen use can lead to eye strain, poor posture and disrupted sleep. Breaks and boundaries matter.
- **Algorithms**: recommendation systems choose what we see. They can be useful, but may create **filter bubbles** where we only meet similar views.
- **The digital divide**: the gap between people who have access to technology and skills and those who do not. It can be caused by cost, location, age or disability, and it can increase inequality.

## Economic impacts
- **Automation** uses machines or software to carry out tasks. It can increase productivity and lower costs, but may replace some jobs while creating new ones, such as maintenance and programming. Workers may need retraining.
- Technology creates new industries, such as app development and online shopping, and changes how businesses reach customers.
- New products can be expensive, which leaves some groups behind.

## Environmental impacts
- Manufacturing devices uses metals, energy and water.
- **Data centres** need large amounts of electricity and cooling.
- **E-waste** from discarded phones and laptops can contain harmful materials. Recycling and repair reduce harm.
- Technology can also help the environment, for example smart energy meters, remote meetings that cut travel, and sensors that monitor pollution.
- A **life-cycle assessment** looks at a product from materials and manufacture, through use, to disposal, so claims such as 'green' can be tested.

## Evaluating technology
Good evaluations are balanced. For any technology ask: Who benefits? Who might be harmed? What are the short-term and long-term effects? What rules or design changes could reduce harm? Use evidence, such as numbers, rather than opinions.

## Worked example
A school gives each of 600 students a tablet, but 15% of families have no home internet. Number affected: 0.15 × 600 = 90 students. Evaluation: the tablets improve access to resources for most students, but 90 students could fall behind. Improvement: offer offline homework, library time or loaned Wi-Fi devices.

## How this is examined
Questions often give a short article, statistic or scenario, such as a new automated system, and ask you to discuss or evaluate its effects. Marks are earned for naming impacts across several categories, supporting them with evidence, and reaching a justified conclusion.

Common mistakes: describing only benefits or only harms, using vague statements like 'it is bad for the environment' without saying how, and treating a claim in an advert as proof.

Exam tip: Structure an evaluation as benefit, risk, who is affected, and your justified recommendation. Always reach a conclusion.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('digital-design')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;