-- Part 6 of 6: 2 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Superpowers, Empires and Institutions > The League of Nations and the United Nations
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Superpowers, Empires and Institutions$mq$, 5, 6 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$The League of Nations and the United Nations$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Superpowers, Empires and Institutions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$The League of Nations and the United Nations$mq$ and p.name = $mq$Superpowers, Empires and Institutions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$The League of Nations was created after which conflict?$mq$, $mq$["The First World War","The Second World War","The Crimean War","The Cold War"]$mq$, 0, $mq$It was set up in 1920 as part of the post-war settlement, with the aim of keeping peace.$mq$, $mq$easy$mq$),
($mq$Which major power never joined the League of Nations?$mq$, $mq$["Britain","France","Italy","The United States"]$mq$, 3, $mq$The US Senate refused to ratify the Treaty of Versailles, so the US did not join.$mq$, $mq$easy$mq$),
($mq$In which year was the United Nations founded?$mq$, $mq$["1919","1920","1945","1991"]$mq$, 2, $mq$The UN was founded after the Second World War, and its charter came into force in October 1945.$mq$, $mq$easy$mq$),
($mq$How many permanent members does the UN Security Council have?$mq$, $mq$["Three","Five","Ten","Fifteen"]$mq$, 1, $mq$The five are the United States, Russia (Soviet Union at the time), the United Kingdom, France and China.$mq$, $mq$easy$mq$),
($mq$What was the main shared aim of the League of Nations and the United Nations?$mq$, $mq$["To maintain international peace and security","To conquer other countries","To control world trade prices","To replace national governments"]$mq$, 0, $mq$Both organisations were created to prevent war through cooperation and collective action.$mq$, $mq$easy$mq$),
($mq$Why was the League's lack of its own army a weakness?$mq$, $mq$["Armies were forbidden","It had too many soldiers","It could not afford buildings","It depended on members to enforce decisions, and they often did not wish to"]$mq$, 3, $mq$Without its own force, the League's main tools were moral pressure and sanctions.$mq$, $mq$medium$mq$),
($mq$In 1931 Japan invaded Manchuria, in China. What was the League's response?$mq$, $mq$["It declared war on Japan","It sent a large army","It condemned Japan, but took no effective action, and Japan left the League in 1933","It rewarded Japan"]$mq$, 2, $mq$The Lytton Report criticised Japan, but members were unwilling to impose strong measures.$mq$, $mq$medium$mq$),
($mq$Italy invaded Abyssinia (Ethiopia) in 1935. Why were League sanctions on Italy ineffective?$mq$, $mq$["Italy had no trade","They did not include vital goods such as oil, and Britain and France were reluctant to act strongly","The League had no members","Italy was a permanent member of the Security Council"]$mq$, 1, $mq$The weak response damaged the League's reputation.$mq$, $mq$medium$mq$),
($mq$What is the effect of the veto held by permanent members of the UN Security Council?$mq$, $mq$["Any one of them can block a substantive resolution","They can overrule the General Assembly in all matters","They must always vote together","They can join the war automatically"]$mq$, 0, $mq$A single 'no' vote by a permanent member stops a resolution passing, even if the others agree.$mq$, $mq$medium$mq$),
($mq$Which is an example of League of Nations success?$mq$, $mq$["Preventing the Second World War","Stopping Italy's invasion of Abyssinia","Forcing Japan out of Manchuria","Settling the Aland Islands dispute between Sweden and Finland peacefully in 1921"]$mq$, 3, $mq$The League also worked on refugees, health and labour conditions, though it failed in major crises.$mq$, $mq$medium$mq$),
($mq$In the UN General Assembly, how many votes does each member state have?$mq$, $mq$["Five","As many as its population in millions","One","None, only the Security Council votes"]$mq$, 2, $mq$Every member state has an equal vote in the General Assembly.$mq$, $mq$medium$mq$),
($mq$A resolution in the Security Council gets 14 votes in favour and one permanent member votes against. What is the outcome?$mq$, $mq$["It passes because 14 is a majority","The resolution fails because of the veto","It passes after a second vote","It goes to the League for approval"]$mq$, 1, $mq$A negative vote by any permanent member blocks the resolution. The council has 15 members and needs 9 votes in favour with no veto.$mq$, $mq$medium$mq$),
($mq$How did the decision-making in the League's Council differ from that of the UN Security Council?$mq$, $mq$["League Council decisions generally required agreement from all its members, while UN decisions need nine votes and no veto","There was no difference","The League used majority voting only","The UN requires all 193 members to agree"]$mq$, 0, $mq$The League's unanimity rule made quick action hard. The UN veto also limits action but is held only by five states.$mq$, $mq$medium$mq$),
($mq$Why is the UN generally considered to have lasted longer than the League?$mq$, $mq$["It had no veto","It had a larger army than any state","It only dealt with trade","It included the United States and the Soviet Union, had a peacekeeping role and a wider membership"]$mq$, 3, $mq$Membership of the strongest powers helped the UN survive, but disagreements among them often blocked action during the Cold War.$mq$, $mq$hard$mq$),
($mq$In 1950 the UN authorised military help for South Korea. This was possible partly because the Soviet Union was boycotting the Security Council. Why did the boycott matter?$mq$, $mq$["The Soviet Union voted in favour","The League of Nations supported the action","The Soviet Union was absent and so could not use its veto","The General Assembly had banned the veto"]$mq$, 2, $mq$The USSR was protesting at China's seat being held by the Nationalist government. Its absence let the resolution pass.$mq$, $mq$hard$mq$),
($mq$Which long-term factor best helps to explain the League's failure in the 1930s?$mq$, $mq$["Too many members were rich","The Great Depression led countries to focus on their own economies, while aggressive nationalist governments rose","There were no disputes","The League had a huge army"]$mq$, 1, $mq$Economic crisis and aggressive governments in Japan, Italy and Germany challenged the League when it was already weak.$mq$, $mq$hard$mq$),
($mq$A cartoon from the 1930s shows the League as a toothless lion. What should a historian conclude?$mq$, $mq$["It shows the cartoonist's opinion of the League's weakness, which should be checked against other evidence","It proves the League had no members","It is a neutral government record","It is useless because it is a drawing"]$mq$, 0, $mq$Cartoons show viewpoints. Their value lies in showing opinions at the time.$mq$, $mq$hard$mq$),
($mq$Which evidence best challenges the claim 'The UN has achieved nothing'?$mq$, $mq$["The UN has a headquarters in New York","The UN has many committees","The UN's flag is blue","WHO's vaccination campaign led to smallpox being declared eradicated in 1980"]$mq$, 3, $mq$UN agencies such as WHO, UNICEF and UNESCO have had real successes, even if the Security Council has often been blocked.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$The League of Nations and the United Nations$mq$ and p.name = $mq$Superpowers, Empires and Institutions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$League of Nations$mq$, $mq$Created in 1920 after the First World War, based in Geneva, to keep peace through collective security.$mq$),
($mq$Why was the League weak?$mq$, $mq$US absence, no army, slow decision-making, and Depression-era nationalism.$mq$),
($mq$Manchuria 1931$mq$, $mq$Japan invaded China's Manchuria. The League condemned it but acted weakly, and Japan left in 1933.$mq$),
($mq$Abyssinia 1935$mq$, $mq$Italy invaded Ethiopia. League sanctions did not include oil and were ineffective.$mq$),
($mq$Aland Islands 1921$mq$, $mq$League settled this Sweden-Finland dispute peacefully, a rare clear success.$mq$),
($mq$United Nations$mq$, $mq$Founded in 1945 to maintain international peace and security and promote cooperation.$mq$),
($mq$Security Council$mq$, $mq$15 members: five permanent with veto (US, Russia, UK, France, China) and ten elected. Needs nine votes and no veto.$mq$),
($mq$General Assembly$mq$, $mq$All UN member states, each with one vote.$mq$),
($mq$UN success example$mq$, $mq$WHO-led vaccination efforts led to smallpox being declared eradicated in 1980.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$The League of Nations and the United Nations$mq$ and p.name = $mq$Superpowers, Empires and Institutions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Two international organisations
After the two world wars, states created organisations to keep peace through cooperation. The **League of Nations** was set up in 1920 after the First World War, with headquarters in Geneva. The **United Nations (UN)** was founded in 1945 after the Second World War.

## The League of Nations
**Aims**: prevent war through collective security, encourage disarmament, settle disputes by negotiation and improve living and working conditions.

**Weaknesses**
- The United States never joined, as the Senate refused to approve the Treaty of Versailles.
- Germany joined in 1926 and left in 1933. Japan left in 1933 and Italy later. The Soviet Union joined in 1934.
- It had no army of its own, so relied on members to act.
- Decisions generally needed agreement, which made quick action difficult.
- During the Great Depression of the 1930s, states put their own economies first.

**Failures**: In 1931 Japan invaded Manchuria and left the League in 1933 after criticism. In 1935 Italy invaded Abyssinia, and sanctions did not include oil, so they had little effect.

**Successes**: The Aland Islands dispute between Sweden and Finland was settled peacefully in 1921. The League also worked on refugees, health and labour conditions.

## The United Nations
**Main bodies**: the General Assembly (all members, one vote each), the Security Council (15 members, five permanent), the Secretary-General and specialised agencies such as WHO, UNICEF and UNESCO.

**Veto**: the five permanent members (United States, Soviet Union and later Russia, United Kingdom, France, China) can each block a substantive resolution. A resolution needs nine votes in favour and no veto.

**Examples**: In 1950 the UN authorised help for South Korea because the Soviet Union was boycotting the Security Council and so could not use its veto. WHO led a campaign that saw smallpox declared eradicated in 1980. UN peacekeeping has had successes and failures.

## Comparing the League and the UN
Both aimed to keep peace. The UN lasted longer because it included the strongest powers, had a wider membership and a peacekeeping role. However, the veto often blocked action during the Cold War.

## Worked example
A Security Council vote has 14 votes in favour and one permanent member votes against. The council has 15 members, and 9 votes are needed, so 14 is enough in number. But the negative vote of a permanent member is a veto, so the resolution fails.

## Common mistakes
- Saying the League failed only because the US was absent.
- Confusing the Security Council with the General Assembly.
- Treating UN abstentions as vetoes: an abstention does not block a resolution.
- Judging an organisation by one failure.

## How this is examined
You may be given a cartoon, a table of membership or a short extract about a crisis. Questions ask what the source shows about the organisation's strengths or weaknesses, how reliable it is and how far one organisation was more successful than another. Extended tasks ask you to evaluate success using several criteria.

Exam tip: Pick criteria for success (for example, preventing war, helping people, lasting influence) and judge the organisation against each, rather than giving only a list of failures.$mq$ from st;

-- Superpowers, Empires and Institutions > Superpower Rivalry and Regional Blocs
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Superpowers, Empires and Institutions$mq$, 5, 6 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Superpower Rivalry and Regional Blocs$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Superpowers, Empires and Institutions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Superpower Rivalry and Regional Blocs$mq$ and p.name = $mq$Superpowers, Empires and Institutions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which two states were the superpowers in the Cold War?$mq$, $mq$["The United States and the Soviet Union","Britain and France","Germany and Italy","Japan and China"]$mq$, 0, $mq$After 1945 the US and the USSR were the dominant world powers, and they led rival blocs.$mq$, $mq$easy$mq$),
($mq$In which year was NATO founded?$mq$, $mq$["1914","1955","1991","1949"]$mq$, 3, $mq$NATO is a military alliance formed by Western countries, including the US and Canada.$mq$, $mq$easy$mq$),
($mq$In which year did East Germany begin building the Berlin Wall?$mq$, $mq$["1948","1975","1961","1989"]$mq$, 2, $mq$The wall divided East and West Berlin until it opened in November 1989.$mq$, $mq$easy$mq$),
($mq$In which region is ASEAN, founded in 1967, located?$mq$, $mq$["South America","Southeast Asia","Western Europe","North Africa"]$mq$, 1, $mq$The original members were Indonesia, Malaysia, the Philippines, Singapore and Thailand.$mq$, $mq$easy$mq$),
($mq$What best describes the 'Cold War'?$mq$, $mq$["A period of tension and rivalry between the superpowers without direct large-scale war between them","A war fought only in Arctic regions","A war between Britain and France","A period when no tension existed"]$mq$, 0, $mq$Rivalry was played out through alliances, arms races, propaganda and proxy wars.$mq$, $mq$easy$mq$),
($mq$What was the policy of 'containment'?$mq$, $mq$["Spreading democracy by invasion","Closing all borders","Creating new empires","Preventing the spread of communism to new countries"]$mq$, 3, $mq$US foreign policy after 1947 tried to stop communism from expanding, as shown by the Truman Doctrine.$mq$, $mq$medium$mq$),
($mq$What was the purpose of the Marshall Plan (1948)?$mq$, $mq$["To arm the Soviet Union","To end the League of Nations","To give US economic aid to rebuild Western European economies","To build the Berlin Wall"]$mq$, 2, $mq$It aimed to help recovery and reduce the appeal of communism.$mq$, $mq$medium$mq$),
($mq$The Warsaw Pact was formed in 1955. It was set up as what?$mq$, $mq$["A trade deal between Britain and France","A military alliance of the Soviet Union and its Eastern European allies, in response to NATO","A UN agency","An alliance against the Soviet Union"]$mq$, 1, $mq$It was established after West Germany joined NATO.$mq$, $mq$medium$mq$),
($mq$How was the Cuban Missile Crisis of 1962 resolved?$mq$, $mq$["The Soviet Union agreed to remove its missiles from Cuba, and the US pledged not to invade Cuba","Nuclear war broke out","The UN invaded Cuba","The US built the Berlin Wall"]$mq$, 0, $mq$The US also secretly agreed to remove missiles from Turkey. Both sides avoided direct war.$mq$, $mq$medium$mq$),
($mq$Which is the correct order for these stages of European cooperation?$mq$, $mq$["Maastricht, then Treaty of Rome, then Coal and Steel Community","Treaty of Rome, Maastricht, Coal and Steel Community","Coal and Steel Community, Maastricht, Treaty of Rome","European Coal and Steel Community (1951), Treaty of Rome (1957), Maastricht Treaty (1992 signed, in force 1993)"]$mq$, 3, $mq$Cooperation began with coal and steel, expanded to a common market, and became the European Union.$mq$, $mq$medium$mq$),
($mq$Which of these is a typical benefit of joining a regional trade bloc?$mq$, $mq$["Higher taxes on all trade","Ending all national governments","Reduced tariffs on trade between members","Compulsory military service"]$mq$, 2, $mq$Blocs often lower trade barriers within the group, though members give up some independence.$mq$, $mq$medium$mq$),
($mq$In 1957 six countries founded the European Economic Community. By 2020 the European Union had 27 members. How many countries joined after 1957?$mq$, $mq$["27","21","33","6"]$mq$, 1, $mq$27 - 6 = 21. The calculation counts only members in 2020, after the United Kingdom left.$mq$, $mq$medium$mq$),
($mq$What is a 'proxy war'?$mq$, $mq$["A conflict in which superpowers support opposing sides without fighting each other directly","A war between two superpowers' armies","A war fought only at sea","A peaceful election"]$mq$, 0, $mq$The Korean War (1950-53) and the Vietnam War are examples.$mq$, $mq$medium$mq$),
($mq$The launch of Sputnik in 1957 alarmed the United States. What was one result?$mq$, $mq$["The US surrendered","The US joined the Warsaw Pact","The Cold War ended","The US created NASA in 1958 and invested more in science education"]$mq$, 3, $mq$The space race became a symbol of superpower rivalry.$mq$, $mq$hard$mq$),
($mq$Which combination best explains the collapse of the Soviet Union in 1991?$mq$, $mq$["A single military defeat in 1990","A US invasion of Moscow","Economic stagnation, the cost of the arms race and Afghanistan war, reforms such as glasnost and perestroika, and growing nationalism in republics","The founding of NATO"]$mq$, 2, $mq$Several causes interacted. Reform opened up criticism and nationalist movements grew.$mq$, $mq$hard$mq$),
($mq$The Non-Aligned Movement was founded in 1961. What was its purpose?$mq$, $mq$["To join NATO","To let states avoid taking sides with either superpower bloc","To create a Soviet empire","To restore the League of Nations"]$mq$, 1, $mq$Leaders including Nehru, Tito and Nasser led the movement, which stressed independence from both blocs.$mq$, $mq$hard$mq$),
($mq$How do NATO and the Warsaw Pact differ from the EU and ASEAN?$mq$, $mq$["The first two were military alliances, while the others are mainly economic and political groupings","There is no difference","NATO is a trade group","The EU is a military alliance only"]$mq$, 0, $mq$Different types of blocs serve different purposes, though some have overlapping roles.$mq$, $mq$hard$mq$),
($mq$Which statement best evaluates the claim 'The Cold War was a peaceful period'?$mq$, $mq$["It was peaceful everywhere","It was the most violent war ever fought directly","Nothing important happened","There was no direct war between the superpowers, but proxy wars, crises and arms races caused great suffering and risk"]$mq$, 3, $mq$Peace between the superpowers did not mean peace for places such as Korea or Vietnam.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Superpower Rivalry and Regional Blocs$mq$ and p.name = $mq$Superpowers, Empires and Institutions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Superpower$mq$, $mq$A state with great military, economic and political influence. In the Cold War: the United States and the Soviet Union.$mq$),
($mq$Containment$mq$, $mq$US policy after 1947 of preventing the spread of communism.$mq$),
($mq$Marshall Plan (1948)$mq$, $mq$US economic aid to rebuild Western European countries after the Second World War.$mq$),
($mq$NATO and the Warsaw Pact$mq$, $mq$NATO: Western military alliance, 1949. Warsaw Pact: Soviet-led military alliance, 1955.$mq$),
($mq$Cuban Missile Crisis (1962)$mq$, $mq$Soviet missiles in Cuba. Resolved when the Soviet Union removed them and the US pledged not to invade Cuba.$mq$),
($mq$Proxy war$mq$, $mq$A conflict where superpowers back opposing sides without fighting each other directly, for example in Korea.$mq$),
($mq$Collapse of the Soviet Union (1991)$mq$, $mq$Caused by economic problems, arms race and war costs, reforms (glasnost, perestroika) and nationalism.$mq$),
($mq$European integration steps$mq$, $mq$European Coal and Steel Community 1951, Treaty of Rome 1957, Maastricht Treaty (in force 1993).$mq$),
($mq$ASEAN$mq$, $mq$Association of Southeast Asian Nations, founded 1967 by Indonesia, Malaysia, the Philippines, Singapore and Thailand.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Superpower Rivalry and Regional Blocs$mq$ and p.name = $mq$Superpowers, Empires and Institutions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The Cold War and the superpowers
After the Second World War the United States and the Soviet Union emerged as **superpowers**. The Cold War (about 1947 to 1991) was a rivalry between them without direct large-scale war between their armies. They led rival blocs, competed in arms and space, and supported opposing sides in other countries' conflicts.

## Key events
- **1947**: the Truman Doctrine and the policy of **containment**, aimed at stopping the spread of communism.
- **1948**: the Marshall Plan gave US aid to rebuild Western Europe. The Berlin Blockade (1948-49) was answered by the Berlin Airlift.
- **1949**: NATO was founded as a Western military alliance.
- **1955**: the Warsaw Pact was formed by the Soviet Union and its Eastern European allies.
- **1950-53**: the Korean War, a proxy war.
- **1957**: Sputnik launched, starting the space race. NASA was created in 1958.
- **1961**: the Berlin Wall was built.
- **1962**: the Cuban Missile Crisis. The Soviet Union agreed to remove its missiles from Cuba, and the US pledged not to invade Cuba.
- **1991**: the Soviet Union collapsed after economic problems, the cost of the arms race and the Afghanistan war, reforms such as glasnost and perestroika, and rising nationalism in its republics.

A **proxy war** is a conflict where superpowers support opposing sides without fighting each other directly.

## Regional blocs
A regional bloc is a group of neighbouring countries that cooperate, often on trade.
- **European Union**: began with the European Coal and Steel Community (1951), then the Treaty of Rome (1957) creating a common market of six members, later the Maastricht Treaty (signed 1992, in force 1993). The United Kingdom left in 2020, leaving 27 members.
- **ASEAN** (1967): in Southeast Asia, founded by Indonesia, Malaysia, the Philippines, Singapore and Thailand.
- **African Union** (2002): successor to the Organisation of African Unity (1963).
- **Non-Aligned Movement** (1961): states that avoided taking sides in the Cold War.

Benefits include easier trade, shared security and stronger bargaining power. Costs include some loss of national control over decisions and unequal gains.

## Worked example
Six countries founded the European Economic Community in 1957. By 2020 the EU had 27 members. Number joining = 27 - 6 = 21. Check what is being counted: the figure for 2020 is after the UK left, so it is not the total number that ever joined.

## Comparing alliances and blocs
NATO and the Warsaw Pact were mainly military alliances. The EU and ASEAN focus mainly on economic and political cooperation. Always explain purpose, membership and methods when comparing.

## Common mistakes
- Saying the Cold War involved no fighting at all: there were proxy wars.
- Mixing up NATO (1949) and the Warsaw Pact (1955).
- Blaming one cause for the collapse of the Soviet Union.
- Treating regional blocs as identical.

## How this is examined
Source-based questions might use a cartoon about the Berlin Wall or a table of bloc membership. You might be asked to explain what the source shows, evaluate its usefulness and judge how far a Cold War event increased or reduced tension. Extended tasks ask you to compare blocs or evaluate causes of change.

Exam tip: Use precise dates and names, and for any judgement about tension, give evidence both for escalation and for easing.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('history')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;