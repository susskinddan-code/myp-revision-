-- Part 5 of 6: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Significant Individuals > Reformers and Revolutionaries
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Significant Individuals$mq$, 5, 5 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Reformers and Revolutionaries$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Significant Individuals$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Reformers and Revolutionaries$mq$ and p.name = $mq$Significant Individuals$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the main difference between a reformer and a revolutionary?$mq$, $mq$["A reformer seeks to change a system from within, while a revolutionary seeks to overthrow it","A reformer always uses violence","A revolutionary never wants change","They mean exactly the same thing"]$mq$, 0, $mq$Reformers aim for gradual change within existing institutions. Revolutionaries aim for rapid, fundamental change, often by overthrowing those in power.$mq$, $mq$easy$mq$),
($mq$For what is Florence Nightingale best remembered?$mq$, $mq$["Leading the Russian Revolution","Inventing the steam engine","Writing the Declaration of Independence","Improving nursing and hospital hygiene, beginning with her work in the Crimean War"]$mq$, 3, $mq$She nursed British soldiers in the Crimean War (1854-56) and later helped found professional nurse training.$mq$, $mq$easy$mq$),
($mq$Which method did Mahatma Gandhi use to campaign against British rule in India?$mq$, $mq$["Armed rebellion","Terrorist attacks","Nonviolent civil disobedience","Military coup"]$mq$, 2, $mq$Gandhi promoted nonviolent resistance, including boycotts, marches and refusing to obey unjust laws.$mq$, $mq$easy$mq$),
($mq$In which year did Nelson Mandela become president of South Africa?$mq$, $mq$["1948","1994","1960","2004"]$mq$, 1, $mq$Mandela was elected in the first democratic elections in 1994 and served until 1999.$mq$, $mq$easy$mq$),
($mq$Emmeline Pankhurst founded the Women's Social and Political Union in 1903 to campaign for what?$mq$, $mq$["Votes for women","Free school meals","An end to the monarchy","Independence for India"]$mq$, 0, $mq$The WSPU, whose members became known as suffragettes, used more militant tactics than earlier campaigners.$mq$, $mq$easy$mq$),
($mq$What was the aim of Gandhi's Salt March of 1930?$mq$, $mq$["To capture a British fort","To start a war with Pakistan","To ask for a new currency","To protest the British salt tax and monopoly"]$mq$, 3, $mq$Gandhi and his followers marched to the sea to make salt, breaking the law, in a symbolic act of nonviolent protest.$mq$, $mq$medium$mq$),
($mq$The Montgomery Bus Boycott of 1955-56 was a protest against what?$mq$, $mq$["High bus fares only","The invention of the car","Racial segregation on city buses","A ban on trade unions"]$mq$, 2, $mq$African American residents refused to use the buses for over a year. The campaign helped to launch Martin Luther King Jr. as a national leader.$mq$, $mq$medium$mq$),
($mq$Toussaint Louverture is remembered for his leadership in which event?$mq$, $mq$["The unification of Italy","The revolution of enslaved people against French colonial rule in Saint-Domingue, leading to independent Haiti","The American Civil War","The Russian Revolution"]$mq$, 1, $mq$The Haitian Revolution led to independence in 1804, creating the first state led by formerly enslaved people.$mq$, $mq$medium$mq$),
($mq$Nelson Mandela was imprisoned after 1962 and released in 1990. Approximately how long did he spend in prison?$mq$, $mq$["27 years","8 years","18 years","37 years"]$mq$, 0, $mq$From 1962 to 1990 is 28 calendar years, and he was in prison for about 27 years because he was released in February 1990.$mq$, $mq$medium$mq$),
($mq$What is the main difference between suffragists and suffragettes in Britain?$mq$, $mq$["Suffragists were against votes for women","Suffragettes were men only","Suffragists lived in France","Suffragists used peaceful methods, while suffragettes used more militant tactics"]$mq$, 3, $mq$Millicent Fawcett's suffragists used petitions and lawful campaigning, while the WSPU's suffragettes broke windows and disrupted events.$mq$, $mq$medium$mq$),
($mq$In October 1917 the Bolsheviks under Lenin did what?$mq$, $mq$["Signed the Treaty of Versailles","Declared Russia a monarchy","Took power in Russia by overthrowing the Provisional Government","Began the French Revolution"]$mq$, 2, $mq$The Bolsheviks seized control of Petrograd, and Lenin became head of the new Soviet government.$mq$, $mq$medium$mq$),
($mq$William Wilberforce, a Member of Parliament, campaigned for the abolition of the slave trade. How is he best classified?$mq$, $mq$["A revolutionary who overthrew the king","A reformer who worked within the political system","A military general","A colonial governor"]$mq$, 1, $mq$Wilberforce worked through Parliament. Slavery was abolished across most of the British Empire by the Slavery Abolition Act of 1833.$mq$, $mq$medium$mq$),
($mq$A student claims that Gandhi alone caused Indian independence in 1947. Which additional factor best shows the claim is too simple?$mq$, $mq$["Britain was financially and militarily weakened by the Second World War","India had no railways","The monarchy of France collapsed","Gandhi was born in 1869"]$mq$, 0, $mq$Independence resulted from several causes, including other nationalist leaders, mass movements and British weakness after 1945.$mq$, $mq$medium$mq$),
($mq$Which statement most accurately compares Gandhi and Mandela?$mq$, $mq$["Both led armed revolutions from the start","Neither ever went to prison","Both held office in the same government","Both challenged unjust systems, but Mandela later supported armed sabotage after peaceful protest was met with repression"]$mq$, 3, $mq$Mandela helped found the armed wing of the ANC, Umkhonto we Sizwe, in 1961, after the Sharpeville killings of 1960. Later he negotiated an end to apartheid.$mq$, $mq$hard$mq$),
($mq$Which argument best supports the view that Florence Nightingale was historically significant?$mq$, $mq$["She was born into a wealthy family","She travelled to Turkey","Her work shaped professional nurse training and used statistics to argue for better hospital conditions, with lasting impact","She lived to an old age"]$mq$, 2, $mq$Significance is judged by lasting influence on many people, not by personal details.$mq$, $mq$hard$mq$),
($mq$Some historians criticise the 'great man' approach to history. What is their main objection?$mq$, $mq$["It says leaders never existed","It overlooks the roles of ordinary people and wider social forces","It uses too many primary sources","It only studies the modern world"]$mq$, 1, $mq$Movements succeed because thousands of people take part. Leaders are important, but so are the groups and conditions around them.$mq$, $mq$hard$mq$),
($mq$Robespierre was a leader during the French Revolution, including the Reign of Terror of 1793-94. What does this suggest about revolutions?$mq$, $mq$["Revolutionary change can bring violence and repression, as well as hopes for equality","Revolutions are always peaceful","Revolutions never change anything","Revolutions only happen in Asia"]$mq$, 0, $mq$The Terror saw thousands executed. Evaluations of revolutionaries should consider both their aims and their methods.$mq$, $mq$hard$mq$),
($mq$In 1993 Nelson Mandela and F. W. de Klerk shared the Nobel Peace Prize. What does this best suggest?$mq$, $mq$["That de Klerk had always opposed apartheid","That the apartheid system had already ended in 1960","That Mandela had never been in prison","International recognition that ending apartheid required negotiation between both sides"]$mq$, 3, $mq$The award honoured their joint work in negotiating a peaceful transition to democracy. It does not imply that de Klerk's earlier role was blameless.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Reformers and Revolutionaries$mq$ and p.name = $mq$Significant Individuals$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Reformer vs revolutionary$mq$, $mq$A reformer changes a system from within, often through laws. A revolutionary seeks to overthrow the system, often rapidly.$mq$),
($mq$Florence Nightingale$mq$, $mq$Nursed soldiers in the Crimean War (1854-56) and promoted hygiene, statistics and professional nurse training.$mq$),
($mq$Gandhi's method$mq$, $mq$Nonviolent civil disobedience, for example the Salt March of 1930 against the British salt tax.$mq$),
($mq$Suffragists vs suffragettes$mq$, $mq$Suffragists, led by Millicent Fawcett, used peaceful campaigning. Suffragettes, in the WSPU led by Emmeline Pankhurst, used militant tactics.$mq$),
($mq$Slavery Abolition Act 1833$mq$, $mq$Law that ended slavery in most of the British Empire. William Wilberforce was a leading campaigner.$mq$),
($mq$Toussaint Louverture$mq$, $mq$Leader in the Haitian Revolution against French colonial rule. Haiti became independent in 1804.$mq$),
($mq$Martin Luther King Jr.$mq$, $mq$US civil rights leader prominent in the Montgomery Bus Boycott (1955-56) and the March on Washington (1963).$mq$),
($mq$Nelson Mandela$mq$, $mq$Anti-apartheid leader, imprisoned 1962-1990, Nobel Peace Prize 1993 with de Klerk, president of South Africa 1994-1999.$mq$),
($mq$Criticism of the 'great man' view$mq$, $mq$It overlooks the roles of ordinary people and wider forces that made change possible.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Reformers and Revolutionaries$mq$ and p.name = $mq$Significant Individuals$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Reformers and revolutionaries
Historians often study individuals because their decisions and actions had a large effect on events. A **reformer** works to change a system from within, usually through laws, campaigns and persuasion. A **revolutionary** wants to overthrow the existing system, often rapidly and sometimes through violence. The line between them can blur, and some people change approach over time.

## Key individuals and what to remember
- **Elizabeth Fry**: campaigned for better conditions for prisoners in early 19th-century Britain.
- **Florence Nightingale**: nursed soldiers in the Crimean War (1854-56), then promoted hygiene, statistics and professional nurse training.
- **William Wilberforce**: an MP who led campaigns against the slave trade. The Slavery Abolition Act of 1833 ended slavery across most of the British Empire.
- **Emmeline Pankhurst**: founded the Women's Social and Political Union in 1903. Suffragettes used militant tactics, whereas suffragists such as Millicent Fawcett used peaceful, lawful methods.
- **Toussaint Louverture**: leader of the Haitian Revolution of enslaved people against French colonial rule. Haiti became independent in 1804.
- **Robespierre**: a leading figure in the French Revolution, closely linked to the Reign of Terror (1793-94).
- **Lenin**: led the Bolsheviks to power in Russia in October 1917.
- **Gandhi**: used nonviolent civil disobedience, such as the Salt March of 1930, against British rule in India, which ended in 1947.
- **Martin Luther King Jr.**: leader of the civil rights movement, prominent in the Montgomery Bus Boycott (1955-56) and the March on Washington (1963).
- **Nelson Mandela**: opposed apartheid, was imprisoned from 1962 to 1990, shared the Nobel Peace Prize with F. W. de Klerk in 1993 and became president in 1994.

## Judging significance
Ask these questions: How many people were affected? How deeply? For how long? Did the individual cause change, or were wider forces at work? For example, Gandhi's campaigns mattered, but Britain's weakness after the Second World War and other nationalist movements also help explain Indian independence in 1947.

## Interpretations
Historians disagree about individuals. Some praise leaders as heroes; others stress the role of ordinary people and wider social forces and criticise the 'great man' view of history. Evaluate interpretations by checking their evidence and purposes.

## Worked example
Question: Compare Gandhi and Mandela. Both challenged unjust systems and both spent time in prison. Gandhi stayed committed to nonviolence. Mandela began with peaceful protest, but after the Sharpeville killings of 1960 and the banning of the ANC, he helped found an armed wing in 1961. Later he negotiated a peaceful transition. A strong answer gives a similarity, a difference and a judgement.

## Common mistakes
- Describing an individual's life without explaining their impact.
- Crediting a single person for a change with many causes.
- Giving dates or details from memory without checking, which damages accuracy.

## How this is examined
You may receive a short biographical source, a speech extract described in your own words, or a portrait with a caption. Questions ask you to explain why the person was significant, compare two individuals, assess the reliability of a source about them and evaluate how far change was due to the individual.

Exam tip: Always link the person to the change they caused and then weigh it against other factors; do not just list facts about their life.$mq$ from st;

-- Significant Individuals > Pioneers and Innovators
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Significant Individuals$mq$, 5, 5 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Pioneers and Innovators$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Significant Individuals$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Pioneers and Innovators$mq$ and p.name = $mq$Significant Individuals$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$For what is Marie Curie best known?$mq$, $mq$["Pioneering research on radioactivity","Inventing the telephone","Discovering America","Writing the first novel"]$mq$, 0, $mq$Marie Curie and her husband Pierre discovered the elements polonium and radium and she developed the study of radioactivity.$mq$, $mq$easy$mq$),
($mq$Which substance did Alexander Fleming discover in 1928?$mq$, $mq$["Insulin","Aspirin","Chlorine","Penicillin"]$mq$, 3, $mq$Fleming noticed that a mould killed bacteria on a culture dish. Penicillin became a usable medicine later.$mq$, $mq$easy$mq$),
($mq$What did the Wright brothers achieve in 1903?$mq$, $mq$["The first crossing of the Atlantic by ship","The first Moon landing","The first powered, controlled aeroplane flights","The first radio broadcast"]$mq$, 2, $mq$Orville and Wilbur Wright flew at Kitty Hawk, North Carolina, in December 1903.$mq$, $mq$easy$mq$),
($mq$What does 'innovation' mean?$mq$, $mq$["Copying exactly what others do","Introducing a new idea, method or device","Destroying old machines","Keeping things the same"]$mq$, 1, $mq$Innovations may be new inventions or new ways of using existing ideas.$mq$, $mq$easy$mq$),
($mq$Edward Jenner is remembered for developing a vaccine against which disease?$mq$, $mq$["Smallpox","Cholera","Measles","Malaria"]$mq$, 0, $mq$In 1796 Jenner showed that cowpox inoculation protected against smallpox.$mq$, $mq$easy$mq$),
($mq$Why is Gutenberg's printing press, developed in the 15th century, historically significant?$mq$, $mq$["It ended all wars in Europe","It created the first electricity grid","It made books impossible to copy","It allowed books to be produced more cheaply and ideas to spread faster"]$mq$, 3, $mq$Movable-type printing in Europe increased the supply of books and helped spread ideas widely.$mq$, $mq$medium$mq$),
($mq$A factory took 12 hours to assemble a car before it introduced a moving assembly line and 2 hours afterwards. By what percentage did the assembly time fall (to the nearest whole number)?$mq$, $mq$["17%","10%","83%","600%"]$mq$, 2, $mq$The fall is 10 hours. 10 / 12 = 0.833, which is about 83%.$mq$, $mq$medium$mq$),
($mq$Why is it misleading to credit only Fleming for penicillin as a medicine?$mq$, $mq$["Fleming did not exist","Howard Florey, Ernst Chain and their team developed it into a usable drug, and all three shared a Nobel Prize in 1945","Penicillin was discovered in 1700","Only governments can invent medicines"]$mq$, 1, $mq$Innovations often involve teams. Fleming made the discovery in 1928 and later researchers turned it into a medicine.$mq$, $mq$medium$mq$),
($mq$Alan Turing is remembered for which work during the Second World War?$mq$, $mq$["Codebreaking at Bletchley Park, helping to read German encrypted messages","Leading the Allied invasion of Normandy","Inventing the telephone","Building the first nuclear reactor in Britain"]$mq$, 0, $mq$Turing worked at Bletchley Park. He had also described the idea of a general-purpose computing machine in 1936.$mq$, $mq$medium$mq$),
($mq$Rosalind Franklin's X-ray images of DNA were important because they did what?$mq$, $mq$["They proved DNA does not exist","They were used to build aeroplanes","They were taken in the 1700s","They provided evidence that helped Watson and Crick work out the double-helix structure in 1953"]$mq$, 3, $mq$Franklin's work was key to understanding DNA, but her contribution was not widely recognised at the time.$mq$, $mq$medium$mq$),
($mq$Which statement about the World Wide Web is correct?$mq$, $mq$["It is identical to the internet","It was invented in the 1700s","It is a system for sharing information using hyperlinks over the internet, developed by Tim Berners-Lee at CERN","It was developed by the Wright brothers"]$mq$, 2, $mq$The internet is the underlying network. The Web is a service that runs on it. Berners-Lee developed it around 1989-1991.$mq$, $mq$medium$mq$),
($mq$Marie Curie won Nobel Prizes in Physics (1903, shared) and Chemistry (1911). Why is this unusual?$mq$, $mq$["She won them in the same year","She won in two different sciences, which was a very rare achievement","She won them for literature","She won them for sport"]$mq$, 1, $mq$Her two prizes in different scientific fields made her a famous pioneer, and she was the first woman to win a Nobel Prize.$mq$, $mq$medium$mq$),
($mq$Which measure best shows that an innovation is historically significant?$mq$, $mq$["The number of people affected and how long the effects lasted","The cost of its first model","How famous its inventor was at birth","The colour of its design"]$mq$, 0, $mq$Historians judge significance by breadth, depth and duration of impact.$mq$, $mq$medium$mq$),
($mq$Thomas Edison is often called the inventor of the light bulb. Which statement is most accurate?$mq$, $mq$["Edison invented electricity","No one else worked on electric lights","The bulb was invented in 1700","Several inventors, such as Joseph Swan, developed electric lamps, and Edison improved a practical bulb and a supply system"]$mq$, 3, $mq$Many inventions are the result of several people's work. Historians weigh who improved, developed and popularised them.$mq$, $mq$hard$mq$),
($mq$Why did penicillin move from laboratory discovery to mass production in the 1940s?$mq$, $mq$["Fleming left science","Nobody wanted antibiotics","The Second World War created high demand for medicine to treat wounded soldiers, and governments supported production","It was easily made at home"]$mq$, 2, $mq$Context matters: wartime need and funding helped turn discovery into large-scale manufacturing.$mq$, $mq$hard$mq$),
($mq$Henry Ford's assembly line made cars cheaper, but some critics said it made factory work repetitive. What does this show about innovation?$mq$, $mq$["Innovation always benefits everyone equally","Innovations can bring benefits for some groups and costs for others","Innovations never have consequences","Innovation only affects the rich"]$mq$, 1, $mq$Evaluation requires considering several groups and both positive and negative effects.$mq$, $mq$hard$mq$),
($mq$A biography of a famous pioneer was written by a member of their family. What is the main limitation?$mq$, $mq$["The author may emphasise achievements and leave out faults","Family members never know the subject","It was written too early","It contains no facts"]$mq$, 0, $mq$Close relationships can affect balance. The author's origin and purpose should be checked, and other sources used.$mq$, $mq$hard$mq$),
($mq$Tu Youyou received the 2015 Nobel Prize in Physiology or Medicine for work on a malaria treatment, and her research drew on traditional Chinese medicine texts. Which conclusion is best supported?$mq$, $mq$["Traditional knowledge is always wrong","Science never uses past knowledge","Malaria was eradicated in 1900","Modern science can build on older knowledge traditions"]$mq$, 3, $mq$Innovation can combine new methods with earlier knowledge. It does not mean that all traditional remedies work.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Pioneers and Innovators$mq$ and p.name = $mq$Significant Individuals$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Innovation$mq$, $mq$Introducing a new idea, method or device.$mq$),
($mq$Edward Jenner$mq$, $mq$Developed smallpox vaccination in 1796 using cowpox.$mq$),
($mq$Marie Curie$mq$, $mq$Pioneer of radioactivity research. Discovered polonium and radium. Nobel Prizes in Physics (1903, shared) and Chemistry (1911).$mq$),
($mq$Wright brothers$mq$, $mq$Made the first powered, controlled aeroplane flights in December 1903 at Kitty Hawk, North Carolina.$mq$),
($mq$Penicillin$mq$, $mq$Discovered by Alexander Fleming in 1928. Developed into a medicine by Florey, Chain and their team in the 1940s.$mq$),
($mq$Rosalind Franklin$mq$, $mq$Her X-ray images of DNA helped Watson and Crick work out the double-helix structure in 1953.$mq$),
($mq$Alan Turing$mq$, $mq$Codebreaker at Bletchley Park in the Second World War and early thinker on general-purpose computing.$mq$),
($mq$World Wide Web$mq$, $mq$Information system using hyperlinks that runs on the internet. Developed by Tim Berners-Lee at CERN around 1989-1991.$mq$),
($mq$How do you judge significance?$mq$, $mq$Consider how many people were affected, how deeply, for how long, and for whom there were benefits and costs.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Pioneers and Innovators$mq$ and p.name = $mq$Significant Individuals$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Pioneers and innovators
A **pioneer** is the first to explore or develop something new. An **innovation** is the introduction of a new idea, method or device. Historians study pioneers to understand how knowledge and technology change society, but they also ask who else contributed and who benefited.

## Key individuals and what to remember
- **Johannes Gutenberg**: developed movable-type printing in Europe in the 15th century, making books cheaper and helping ideas spread.
- **Edward Jenner**: in 1796 showed that cowpox inoculation protected against smallpox, an early step towards vaccination.
- **Marie Curie**: pioneered research on radioactivity, discovered polonium and radium and won Nobel Prizes in Physics (1903, shared) and Chemistry (1911).
- **Wright brothers**: made the first powered, controlled aeroplane flights in December 1903 at Kitty Hawk, North Carolina.
- **Alexander Fleming**: discovered penicillin in 1928. Howard Florey, Ernst Chain and their team developed it into a medicine in the 1940s, and all three shared the 1945 Nobel Prize.
- **Rosalind Franklin**: her X-ray images of DNA helped Watson and Crick work out the double helix in 1953.
- **Alan Turing**: codebreaker at Bletchley Park in the Second World War and an early thinker about general-purpose computing.
- **Tim Berners-Lee**: developed the World Wide Web at CERN around 1989-1991. The Web is a service that runs on the internet, not the same thing.
- **Tu Youyou**: won the 2015 Nobel Prize in Physiology or Medicine for work on a malaria treatment, using traditional Chinese medicine texts as one source of ideas.

## Judging significance
Ask: How many people were affected? How deeply? For how long? Did the innovation change daily life, health, work or communication? Also look at limitations and costs. Henry Ford's moving assembly line cut production times and made cars cheaper, but critics said it made work repetitive.

## Credit and teamwork
Historians are cautious about crediting a single person. Many inventions involve teams, earlier ideas and the right context. Thomas Edison improved the practical electric light bulb, but other inventors, such as Joseph Swan, also developed electric lamps. Penicillin became a mass-produced medicine in the 1940s partly because wartime needs created demand.

## Worked example
Before its moving line, a factory took 12 hours to assemble one car. After, it took 2 hours. Fall in time = 12 - 2 = 10 hours. Percentage fall = 10 / 12 x 100 = 83.3%, about 83%. A good evaluation then asks: who gained (customers, owners) and who may have lost (workers whose jobs became repetitive)?

## Common mistakes
- Saying 'X invented Y' when many people contributed.
- Describing what the innovation was but not its effect.
- Forgetting negative effects or groups who did not benefit.
- Confusing the internet with the World Wide Web.

## How this is examined
Questions might give a short source about a discovery and ask what it shows about the process of innovation, who deserves credit, and how far it changed life. Extended tasks ask you to evaluate the significance of an innovation using criteria such as reach, depth and duration, and to consider different perspectives.

Exam tip: Support every claim of significance with evidence about who was affected and for how long; avoid claiming that one person worked alone.$mq$ from st;

-- Superpowers, Empires and Institutions > The Rise and Fall of Empires
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Superpowers, Empires and Institutions$mq$, 5, 6 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$The Rise and Fall of Empires$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Superpowers, Empires and Institutions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$The Rise and Fall of Empires$mq$ and p.name = $mq$Superpowers, Empires and Institutions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which definition best describes an empire?$mq$, $mq$["A state that rules over many territories and peoples under one central authority","A country with no government","A group of farms","A trade union"]$mq$, 0, $mq$Empires expand by conquest, settlement or influence and control diverse regions.$mq$, $mq$easy$mq$),
($mq$The Western Roman Empire is traditionally said to have ended in which year?$mq$, $mq$["27 BCE","1066 CE","1453 CE","476 CE"]$mq$, 3, $mq$In 476 CE the last Western emperor, Romulus Augustulus, was deposed by Odoacer.$mq$, $mq$easy$mq$),
($mq$Who founded the Mongol Empire in 1206?$mq$, $mq$["Julius Caesar","Napoleon","Genghis Khan","Suleiman"]$mq$, 2, $mq$Temujin was proclaimed Genghis Khan in 1206 and united the Mongol tribes.$mq$, $mq$easy$mq$),
($mq$Which modern state was proclaimed in 1923 following the end of the Ottoman Empire?$mq$, $mq$["The Republic of Egypt","The Republic of Turkey","The Kingdom of Spain","The Republic of Iran"]$mq$, 1, $mq$Mustafa Kemal Ataturk led the new republic after the Ottoman defeat in the First World War.$mq$, $mq$easy$mq$),
($mq$What does 'decolonisation' mean?$mq$, $mq$["The process by which colonies gained independence from imperial powers","The creation of new colonies","A war between two empires","The building of railways"]$mq$, 0, $mq$After the Second World War many colonies in Asia and Africa became independent.$mq$, $mq$easy$mq$),
($mq$What is 'imperial overstretch'?$mq$, $mq$["When an empire becomes too small","When an empire stops using money","When a ruler builds tall buildings","When an empire expands beyond its ability to defend and pay for its territories"]$mq$, 3, $mq$Large frontiers, armies and administration can become too costly, weakening the empire.$mq$, $mq$medium$mq$),
($mq$In 1521 a small Spanish force led by Hernan Cortes conquered the Aztec capital Tenochtitlan. Which statement best explains this?$mq$, $mq$["The Aztecs had no army","The Spanish had a larger army than the Aztecs and their allies","The Spanish gained local allies and disease devastated the Aztecs, as well as having military technology","There was no fighting"]$mq$, 2, $mq$Many indigenous peoples allied with Cortes against Aztec rule, and diseases such as smallpox caused huge losses. Weapons alone do not explain the outcome.$mq$, $mq$medium$mq$),
($mq$Mansa Musa, ruler of the Mali Empire in the early 1300s, became famous for his pilgrimage to Mecca. What did it show?$mq$, $mq$["Mali had no trade","The great wealth of Mali, based on gold and trade","Mali was ruled by Rome","Mali had just been conquered"]$mq$, 1, $mq$His journey, carrying large amounts of gold, made Mali known across the Mediterranean world and showed its importance in trans-Saharan trade.$mq$, $mq$medium$mq$),
($mq$Which empire ended as a result of the First World War?$mq$, $mq$["The Austro-Hungarian Empire","The British Empire","The French Empire","The Japanese Empire"]$mq$, 0, $mq$Austria-Hungary broke up in 1918, as did the Russian, German and Ottoman empires. The British and French empires continued, though weakened.$mq$, $mq$medium$mq$),
($mq$A fictional empire covered 2 million km² in 1700, grew by 15% by 1750, then lost 40% of that area by 1800. What was its area in 1800?$mq$, $mq$["1.2 million km²","2.3 million km²","0.92 million km²","1.38 million km²"]$mq$, 3, $mq$1750 area = 2 x 1.15 = 2.3 million. A 40% loss leaves 60%: 2.3 x 0.6 = 1.38 million km².$mq$, $mq$medium$mq$),
($mq$The Suez Crisis of 1956 showed what about Britain's position in the world?$mq$, $mq$["Britain controlled Egypt permanently","Britain had won every war since 1945","Its ability to act independently as an imperial power had declined, since pressure from the United States forced withdrawal","The United States supported the invasion"]$mq$, 2, $mq$Britain, France and Israel attacked Egypt after Nasser nationalised the Suez Canal, but had to withdraw.$mq$, $mq$medium$mq$),
($mq$Which pair of factors best explains India's independence in 1947?$mq$, $mq$["A war with Russia and a famine","A strong nationalist movement and a Britain weakened by the Second World War","A British decision made in 1800","The invention of television"]$mq$, 1, $mq$Several causes interacted: mass nationalist campaigns, political negotiation and Britain's weakened economy.$mq$, $mq$medium$mq$),
($mq$Why do historians usually reject single-cause explanations for the fall of an empire?$mq$, $mq$["Empires usually fall because several factors interact, such as war, economy and internal conflict","Because empires never fall","Because there is no evidence","Because historians dislike simple answers"]$mq$, 0, $mq$Strong explanations consider multiple causes and how they link.$mq$, $mq$medium$mq$),
($mq$For the Austro-Hungarian Empire, which factor is best classed as a long-term cause of collapse?$mq$, $mq$["Defeat in 1918 alone","The signing of a peace treaty","A single speech","Rising nationalism among its many ethnic groups"]$mq$, 3, $mq$Nationalism developed over decades, weakening loyalty to the empire. Military defeat in the First World War acted as the trigger.$mq$, $mq$hard$mq$),
($mq$A student writes: 'Empires fall because of internal weaknesses, not outside attacks.' Which response is best?$mq$, $mq$["The statement is always true","The statement is always false","Both matter and interact, as in Rome, where civil wars and economic strain weakened defences against migrating peoples","Empires never fall"]$mq$, 2, $mq$A balanced answer examines internal and external causes and how one made the other more damaging.$mq$, $mq$hard$mq$),
($mq$Why do many historians link colonial borders, such as those drawn in Africa after the Berlin Conference of 1884-85, to later conflicts?$mq$, $mq$["The borders were drawn by Africans only","Borders often ignored local ethnic and political groupings, grouping rivals or splitting communities","The borders matched every cultural region","The borders were never used"]$mq$, 1, $mq$The conference set rules for European claims on Africa without African participation. Boundaries influenced the shape of independent states, though other causes also matter.$mq$, $mq$hard$mq$),
($mq$Which statement about the Mongol Empire is best supported?$mq$, $mq$["Skilled cavalry warfare helped conquest, and for a time safe long-distance trade, but the empire later split into separate khanates","It never fought wars","It lasted unchanged for 1000 years","It controlled only one city"]$mq$, 0, $mq$The empire's size made it hard to rule as one unit, and it divided into several khanates.$mq$, $mq$hard$mq$),
($mq$How should a historian best evaluate the legacy of a large empire?$mq$, $mq$["Use only the ruler's records","Use only modern opinions","Ignore evidence of conflict","Consider the viewpoints of rulers and colonised peoples, including benefits such as trade links and costs such as exploitation"]$mq$, 3, $mq$Balanced evaluation requires multiple perspectives and evidence from different groups.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$The Rise and Fall of Empires$mq$ and p.name = $mq$Superpowers, Empires and Institutions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Empire$mq$, $mq$A state that rules over many territories and peoples under one central authority.$mq$),
($mq$Imperial overstretch$mq$, $mq$When an empire expands beyond its ability to defend and finance its territories.$mq$),
($mq$Fall of the Western Roman Empire$mq$, $mq$Traditionally dated 476 CE, when Romulus Augustulus was deposed by Odoacer.$mq$),
($mq$Why did the Aztec capital fall in 1521?$mq$, $mq$Cortes gained local allies, smallpox devastated the population, and Spanish weapons helped.$mq$),
($mq$Mansa Musa$mq$, $mq$Ruler of the Mali Empire in the early 1300s. His pilgrimage to Mecca showed Mali's great wealth from gold and trade.$mq$),
($mq$Which empires ended after the First World War?$mq$, $mq$Austro-Hungarian, German, Russian and Ottoman. The Republic of Turkey was proclaimed in 1923.$mq$),
($mq$Decolonisation$mq$, $mq$The process by which colonies gained independence, mostly after 1945. India became independent in 1947.$mq$),
($mq$Suez Crisis 1956$mq$, $mq$Britain, France and Israel attacked Egypt after Nasser nationalised the Suez Canal. They withdrew under US pressure, showing Britain's decline.$mq$),
($mq$Long-term cause vs trigger$mq$, $mq$Long-term causes build up over years (for example nationalism). A trigger is the event that sets off the final change.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$The Rise and Fall of Empires$mq$ and p.name = $mq$Superpowers, Empires and Institutions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is an empire?
An empire is a state that rules over many territories and peoples under one central authority. Empires expand through conquest, settlement, trade or alliances. Examples include the Roman, Mongol, Mali, Ottoman, Spanish and British empires. Studying their rise and fall helps explain how the modern world was shaped.

## Why empires rise
- **Military strength**: organised armies and tactics, such as the Mongol cavalry.
- **Wealth and trade**: control of trade routes and resources, such as the gold and trade of the Mali Empire. Mansa Musa's pilgrimage to Mecca in the early 1300s showed this wealth.
- **Technology and disease**: Spanish firearms and ships mattered, but in 1521 Cortes conquered the Aztec capital Tenochtitlan largely because he gained local allies who resented Aztec rule and because smallpox devastated the population.
- **Organisation**: roads, laws and administration, as in Rome, help rulers hold large areas.

## Why empires decline
Historians usually find several causes working together.
- **Imperial overstretch**: defending and governing huge territories becomes too expensive.
- **Economic problems**: heavy taxes, debt or loss of trade.
- **Internal conflict**: civil wars, rebellions and weak or divided rulers. The Western Roman Empire is traditionally said to have ended in 476 CE.
- **Nationalism**: peoples in multi-ethnic empires, such as Austria-Hungary, wanted their own states. The empire broke up in 1918.
- **External pressure and war**: defeat in the First World War ended the German, Russian, Austro-Hungarian and Ottoman empires. The Republic of Turkey was proclaimed in 1923.
- **Decolonisation**: after the Second World War, Britain and France were weakened and independence movements grew. India became independent in 1947. In 1956 the Suez Crisis showed Britain's reduced power, when it had to withdraw from Egypt under American pressure.

## Long-term causes, short-term causes and triggers
- Long-term causes build up over many years, such as nationalism.
- Short-term causes act more quickly, such as military defeat.
- A trigger is the event that starts the final change.
Separating these makes explanations clearer.

## Worked example
A fictional empire has 2 million km² in 1700. It grows by 15% to 2.3 million km² in 1750 (2 x 1.15). By 1800 it loses 40% of that area. Remaining = 60% of 2.3 = 1.38 million km². A common error is to take 40% from the original 2 million, which would give 1.2 million.

## Legacies
Empires left languages, borders, trade links and conflict. For example, borders drawn by European powers after the Berlin Conference of 1884-85 often ignored local groupings. Evaluate legacies from different perspectives, including those of rulers and colonised peoples.

## Common mistakes
- Offering a single cause for the fall of an empire.
- Mixing up long-term causes and triggers.
- Describing only the ruler's perspective.
- Forgetting that the British and French empires survived the First World War.

## How this is examined
You are usually given a short source, such as an extract or a map description, about the growth or decline of an empire. Questions ask for causes, comparison between two empires, the reliability of the source and a supported judgement about the most important cause or about the legacy.

Exam tip: When asked for the most important cause, rank at least two causes, explain how they connect and justify why one mattered more.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('history')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;