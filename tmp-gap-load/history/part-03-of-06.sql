-- Part 3 of 6: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Ideas and Ideologies > The Enlightenment and Revolutions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Ideas and Ideologies$mq$, 5, 3 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$The Enlightenment and Revolutions$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Ideas and Ideologies$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$The Enlightenment and Revolutions$mq$ and p.name = $mq$Ideas and Ideologies$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$The Enlightenment was a movement of the 1700s that stressed which of the following?$mq$, $mq$["Reason, science and questioning traditional authority","Obedience to absolute monarchs","Blind faith","Isolation from other countries"]$mq$, 0, $mq$Enlightenment thinkers believed that reason could improve society and challenged the divine right of kings and the power of the Church.$mq$, $mq$easy$mq$),
($mq$Which French thinker wrote The Spirit of the Laws (1748), arguing for the separation of powers?$mq$, $mq$["Napoleon","Robespierre","Louis XVI","Montesquieu"]$mq$, 3, $mq$Montesquieu argued that dividing power between lawmakers, rulers and judges prevents tyranny. His ideas influenced the US Constitution.$mq$, $mq$easy$mq$),
($mq$On which date was the US Declaration of Independence adopted?$mq$, $mq$["14 July 1789","1 January 1804","4 July 1776","11 November 1918"]$mq$, 2, $mq$The Declaration announced that thirteen American colonies were separating from Britain.$mq$, $mq$easy$mq$),
($mq$What happened at the Bastille in Paris on 14 July 1789?$mq$, $mq$["Louis XVI was executed","A crowd stormed the royal fortress-prison, a symbol of royal power","Napoleon became emperor","The Estates General first met"]$mq$, 1, $mq$The attack on the Bastille became a symbol of the French Revolution. Louis XVI was executed in January 1793.$mq$, $mq$easy$mq$),
($mq$Which country became independent in 1804 after a revolution led by formerly enslaved people, including Toussaint Louverture?$mq$, $mq$["Haiti","Brazil","Mexico","Canada"]$mq$, 0, $mq$The Haitian Revolution began in 1791 in the French colony of Saint-Domingue. Haiti declared independence on 1 January 1804.$mq$, $mq$easy$mq$),
($mq$John Locke argued that people have natural rights. Which three did he stress?$mq$, $mq$["Wealth, power and fame","Faith, hope and charity","Land, labour and capital only","Life, liberty and property"]$mq$, 3, $mq$Locke's ideas influenced the American Declaration of Independence, which spoke of life, liberty and the pursuit of happiness.$mq$, $mq$medium$mq$),
($mq$Which idea did Jean-Jacques Rousseau promote in The Social Contract (1762)?$mq$, $mq$["Kings rule by divine right","Society needs no laws","Government should rest on the general will of the people","Only nobles may vote"]$mq$, 2, $mq$Rousseau argued that legitimate authority comes from agreement of the people. He inspired many revolutionaries.$mq$, $mq$medium$mq$),
($mq$Why were many Americans angry about British taxes in the 1760s-70s?$mq$, $mq$["They wanted to pay more","They had no representatives in the British Parliament","They were taxed by France","The taxes were abolished"]$mq$, 1, $mq$'No taxation without representation' was a slogan of colonists. Acts such as the Stamp Act (1765) led to protests.$mq$, $mq$medium$mq$),
($mq$Which problem in 1789 France helped cause the Revolution?$mq$, $mq$["A financial crisis and an unfair tax system where the Third Estate paid most taxes","A Spanish invasion","An unbroken period of prosperity","The abolition of the monarchy"]$mq$, 0, $mq$France was in debt after wars and bad harvests raised bread prices. The Third Estate (ordinary people) paid heavy taxes while clergy and nobles had privileges.$mq$, $mq$medium$mq$),
($mq$The Declaration of the Rights of Man and of the Citizen (August 1789) stated what?$mq$, $mq$["That the king has unlimited power","That only the clergy can vote","That slavery must continue","That men are born free and equal in rights"]$mq$, 3, $mq$It was inspired by Enlightenment ideas. It did not give equal rights to women or end slavery in French colonies at that time.$mq$, $mq$medium$mq$),
($mq$Which event is associated with Robespierre and the Committee of Public Safety in 1793-94?$mq$, $mq$["The Storming of the Bastille","The Congress of Vienna","The Reign of Terror","The Marshall Plan"]$mq$, 2, $mq$During the Terror, thousands were executed by guillotine, including Louis XVI (January 1793). Robespierre fell in July 1794.$mq$, $mq$medium$mq$),
($mq$Mary Wollstonecraft applied Enlightenment ideas in 1792 by arguing for what?$mq$, $mq$["The divine right of kings","Education and rights for women","Slavery","War between nations"]$mq$, 1, $mq$In A Vindication of the Rights of Woman she argued that women's apparent weaknesses came from poor education.$mq$, $mq$medium$mq$),
($mq$What happened in France in 1799?$mq$, $mq$["Napoleon Bonaparte seized power","The Bastille fell","The monarchy was restored at once","The Terror began"]$mq$, 0, $mq$Napoleon took power in a coup and later became emperor in 1804. He kept some revolutionary reforms, such as equality before the law.$mq$, $mq$medium$mq$),
($mq$Evaluate: 'The French Revolution achieved the Enlightenment's ideals.' Which response is the most balanced?$mq$, $mq$["It achieved every ideal","It achieved nothing","It had no link to Enlightenment ideas","It ended feudal privileges and promoted equality in law, but violence, the Terror and later dictatorship contradicted liberty"]$mq$, 3, $mq$A strong answer considers successes and failures. Rights were declared, but many were suspended during the Terror and women were excluded.$mq$, $mq$hard$mq$),
($mq$Why can the Haitian Revolution be described as a challenge to Enlightenment ideas as well as an example of them?$mq$, $mq$["It was led by Napoleon","It supported slavery","It used ideas of liberty and equality against slavery, exposing the contradiction of Europeans who claimed these ideals while enslaving people","It was fought against Britain over tea"]$mq$, 2, $mq$Enslaved people in Haiti demanded rights that revolutionary France claimed to support. It showed the limits of how the ideals were applied.$mq$, $mq$hard$mq$),
($mq$A historian says the American Revolution was 'a political revolution but not a social one.' Which fact best supports this?$mq$, $mq$["Britain lost the colonies","Slavery continued in the new United States and women and many men could not vote","The Constitution was written in 1787","George Washington became president"]$mq$, 1, $mq$The new government changed who ruled but left many social inequalities. Evaluation of such claims needs evidence about who gained and who did not.$mq$, $mq$hard$mq$),
($mq$Which of these best explains the link between Enlightenment ideas and the revolutions of 1776 and 1789?$mq$, $mq$["Ideas about natural rights and popular sovereignty gave people reasons to challenge unfair rule, but economic and political crises triggered action","The ideas alone caused each revolution","The ideas had no role","Only the weather caused them"]$mq$, 0, $mq$Causation needs both long-term causes (ideas, inequality) and short-term triggers (debt, taxes, bad harvests, particular events).$mq$, $mq$hard$mq$),
($mq$Which statement compares the American and French Revolutions most accurately?$mq$, $mq$["Both were fought to remove the same king","Neither used Enlightenment ideas","Both ended slavery immediately","The American Revolution was a war for independence from a distant ruler, while the French Revolution overturned the monarchy and social order inside France"]$mq$, 3, $mq$Both used ideas of rights and the French Revolution was more radical in changing society. The French revolutionaries were influenced by the American example.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$The Enlightenment and Revolutions$mq$ and p.name = $mq$Ideas and Ideologies$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Enlightenment$mq$, $mq$1700s movement stressing reason, science and individual rights, and challenging absolute monarchy and traditional authority.$mq$),
($mq$John Locke$mq$, $mq$English thinker who argued for natural rights to life, liberty and property, and government by consent.$mq$),
($mq$Montesquieu$mq$, $mq$French thinker who argued in The Spirit of the Laws (1748) for separation of powers to prevent tyranny.$mq$),
($mq$Rousseau$mq$, $mq$Wrote The Social Contract (1762), arguing that legitimate government rests on the general will of the people.$mq$),
($mq$4 July 1776$mq$, $mq$US Declaration of Independence adopted, announcing the separation of thirteen colonies from Britain.$mq$),
($mq$French Revolution, 1789$mq$, $mq$Began with financial crisis and the Estates General. Bastille stormed 14 July 1789. Rights of Man declared in August.$mq$),
($mq$Reign of Terror (1793-94)$mq$, $mq$Period under Robespierre and the Committee of Public Safety when thousands were executed, including opponents of the Revolution.$mq$),
($mq$Haitian Revolution$mq$, $mq$Enslaved people in Saint-Domingue rose in 1791 under leaders including Toussaint Louverture. Haiti became independent on 1 January 1804.$mq$),
($mq$Third Estate$mq$, $mq$In France before 1789, the commoners (everyone except clergy and nobles), who paid most taxes but had little power.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$The Enlightenment and Revolutions$mq$ and p.name = $mq$Ideas and Ideologies$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$The Enlightenment was an intellectual movement, mainly in the 1700s, in which thinkers argued that reason, science and evidence should guide how people understand the world and how societies are governed. Their ideas helped inspire revolutions in America, France, Haiti and Latin America.

## Key thinkers
- **John Locke** (England) argued that people have natural rights to life, liberty and property, and that governments rule with the consent of the governed.
- **Montesquieu** (France), in The Spirit of the Laws (1748), argued for the separation of powers between legislature, executive and judiciary.
- **Voltaire** (France) defended freedom of speech and religious toleration.
- **Rousseau** (Switzerland and France), in The Social Contract (1762), argued that government should reflect the general will.
- **Mary Wollstonecraft** (England), in 1792, argued for women's education and rights.
These thinkers challenged absolute monarchy and the divine right of kings.

## The American Revolution
Britain taxed its American colonies after the Seven Years' War. Colonists objected because they had no representation in Parliament. Tension led to war in 1775, and on 4 July 1776 the Declaration of Independence announced that thirteen colonies were free. After the war, the Constitution of 1787 created a republic with separation of powers. Yet slavery continued, and women and many men could not vote.

## The French Revolution
In 1789 France faced debt, bad harvests and an unfair system: the Third Estate (commoners) paid most taxes while the clergy and nobles had privileges. The Estates General met in May 1789. On 14 July a crowd stormed the Bastille. In August the Declaration of the Rights of Man and of the Citizen proclaimed liberty and equality before the law. Louis XVI was executed in January 1793, and during the Reign of Terror (1793-94), led by Robespierre, thousands were executed. In 1799 Napoleon Bonaparte took power.

## The Haitian and Latin American Revolutions
In the French colony of Saint-Domingue, enslaved people rose up in 1791. Led by Toussaint Louverture and later others, they defeated French forces, and Haiti became independent on 1 January 1804. It was the first state founded by formerly enslaved people. In the early 1800s leaders such as Simón Bolívar led independence movements in Spanish South America.

## Common mistakes
- Do not say Enlightenment ideas alone caused revolutions. Economic crisis, taxes and events were triggers.
- Remember that Enlightenment ideals were not applied to everyone at the time.
- Do not confuse the Declaration of Independence (1776) with the Declaration of the Rights of Man (1789).

## How this is examined
You may be given an extract from a speech or declaration (provided in the paper) and asked to identify which Enlightenment idea it reflects, explain its origin and purpose, and evaluate its value and limitations as a source. Questions about causes and consequences ask you to weigh long-term causes against short-term triggers.

Exam tip: Separate long-term causes (ideas, inequality) from short-term triggers (a crisis or event) when you explain why a revolution happened.$mq$ from st;

-- Ideas and Ideologies > Nationalism, Liberalism and Socialism
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Ideas and Ideologies$mq$, 5, 3 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Nationalism, Liberalism and Socialism$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Ideas and Ideologies$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Nationalism, Liberalism and Socialism$mq$ and p.name = $mq$Ideas and Ideologies$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is nationalism?$mq$, $mq$["Strong loyalty to one's nation and the belief that people sharing a culture should have their own state","Belief that all property is shared","Rule by one family","Belief in world government"]$mq$, 0, $mq$Nationalism played a big role in the 1800s in places such as Italy and Germany.$mq$, $mq$easy$mq$),
($mq$Which ideology stresses individual freedom, rights and limited government?$mq$, $mq$["Fascism","Absolutism","Feudalism","Liberalism"]$mq$, 3, $mq$Liberals supported free speech, constitutions and often free markets.$mq$, $mq$easy$mq$),
($mq$Which ideology focuses on greater equality and often on public or shared ownership?$mq$, $mq$["Absolutism","Imperialism","Socialism","Liberalism"]$mq$, 2, $mq$Socialists argued that industrial wealth should benefit workers as a whole rather than a few owners.$mq$, $mq$easy$mq$),
($mq$Which two men published The Communist Manifesto in 1848?$mq$, $mq$["Adam Smith and John Locke","Karl Marx and Friedrich Engels","Bismarck and Cavour","Lenin and Stalin"]$mq$, 1, $mq$The Manifesto described history as a struggle between social classes and predicted that workers would overthrow capitalism.$mq$, $mq$easy$mq$),
($mq$Which Prussian chancellor was the main architect of German unification in 1871?$mq$, $mq$["Otto von Bismarck","Giuseppe Garibaldi","Metternich","Napoleon"]$mq$, 0, $mq$Bismarck used wars against Denmark (1864), Austria (1866) and France (1870-71) to unite Germany under Prussian leadership.$mq$, $mq$easy$mq$),
($mq$Which statement best summarises Adam Smith's argument in The Wealth of Nations (1776)?$mq$, $mq$["The state should own all factories","Kings should control prices","Trade is harmful","Free markets with competition can create prosperity"]$mq$, 3, $mq$Smith is associated with the free market and the idea of the 'invisible hand', an important source of economic liberalism.$mq$, $mq$medium$mq$),
($mq$John Stuart Mill's On Liberty (1859) defended what principle?$mq$, $mq$["Governments should control opinions","The state should own property","People should be free to act and speak unless they harm others","Nations should fight for land"]$mq$, 2, $mq$Mill is a key liberal thinker who defended freedom of expression and individuality.$mq$, $mq$medium$mq$),
($mq$Italy was unified between 1859 and 1871. Which person led the red-shirted volunteers who conquered Sicily and Naples in 1860?$mq$, $mq$["Otto von Bismarck","Giuseppe Garibaldi","Karl Marx","Mussolini"]$mq$, 1, $mq$Garibaldi's campaign helped join southern Italy to the northern kingdom led by Piedmont-Sardinia under Cavour. Italy's kingdom was proclaimed in 1861 and Rome joined in 1871.$mq$, $mq$medium$mq$),
($mq$The Congress of Vienna (1814-15), led by Metternich, aimed to do what?$mq$, $mq$["Restore the old order and balance of power after Napoleon","Create democracy everywhere","Unite Italy","Give vote to women"]$mq$, 0, $mq$Conservative rulers tried to restrain liberal and nationalist ideas. These ideas continued to grow, and led to revolutions in 1848.$mq$, $mq$medium$mq$),
($mq$In Marx's view, who are the 'proletariat'?$mq$, $mq$["Factory owners","Nobles","Priests","The working class who sell their labour"]$mq$, 3, $mq$The bourgeoisie owned factories and capital. Marx predicted a class struggle between the two.$mq$, $mq$medium$mq$),
($mq$Why did socialism grow in the industrial cities of the 1800s?$mq$, $mq$["Cities were empty","Workers were rich","Workers faced low wages, long hours and unsafe conditions","Factories were small"]$mq$, 2, $mq$Industrialisation created large working-class communities. Trade unions and socialist parties campaigned for change.$mq$, $mq$medium$mq$),
($mq$Robert Owen's mill community at New Lanark in Scotland is an early example of what?$mq$, $mq$["A military camp","Reform to improve working and living conditions","A feudal estate","A colonial settlement"]$mq$, 1, $mq$Owen reduced child labour, built schools and improved housing, influencing socialist ideas and showing a reformist approach.$mq$, $mq$medium$mq$),
($mq$Nationalism could cause tension in multi-ethnic empires such as Austria-Hungary. Why?$mq$, $mq$["Different national groups wanted self-rule or independence","Everyone supported the emperor","There were no minorities","Nobody spoke different languages"]$mq$, 0, $mq$Groups such as Czechs, Hungarians and Serbs sought more autonomy. Such tensions contributed to the build-up to the First World War.$mq$, $mq$medium$mq$),
($mq$Which statement correctly compares liberalism and socialism?$mq$, $mq$["Both reject all private property","Liberals favour absolute monarchy","Socialists oppose all trade unions","Liberals emphasise individual freedom and often free markets, while socialists emphasise equality and collective or public ownership"]$mq$, 3, $mq$Both grew in the 1800s as responses to change. In practice there are many varieties of each, including liberal support for reform and democratic socialist parties.$mq$, $mq$hard$mq$),
($mq$Evaluate the claim 'Nationalism was a force for unity in the 1800s.' Which answer is the strongest?$mq$, $mq$["Nationalism had only positive effects","Nationalism had no effect","It united Italy and Germany, but it also divided empires and encouraged rivalry between states","Nationalism only affected Asia"]$mq$, 2, $mq$Nationalism united people with shared identity, yet it also created conflict, especially where borders and nationalities did not match.$mq$, $mq$hard$mq$),
($mq$Why did Bismarck's unification of Germany depend on war?$mq$, $mq$["He never used war","Prussia defeated rivals in 1864, 1866 and 1870-71, removing Austrian influence and rallying German states against France","He relied only on elections","Germany unified in 1848 peacefully"]$mq$, 1, $mq$The Kaiser was proclaimed at Versailles in January 1871. Unification involved diplomacy as well as war, but the wars were crucial.$mq$, $mq$hard$mq$),
($mq$Which evidence best supports the claim that the 1848 revolutions failed in the short term?$mq$, $mq$["Most revolts were suppressed and conservative rulers kept control","The revolutions achieved all aims","No revolutions took place","The Congress of Vienna was created in 1848"]$mq$, 0, $mq$Revolutions broke out across Europe in 1848 for liberal and nationalist aims, but divisions and the army let rulers regain control. Yet the ideas continued.$mq$, $mq$hard$mq$),
($mq$A source from 1850 criticises trade unions for harming free competition. Which ideology does this view most likely reflect?$mq$, $mq$["Marxism","Socialism","Anarchism","Economic liberalism"]$mq$, 3, $mq$Economic liberals favoured free markets with little interference. Socialists generally supported unions, which they saw as defending workers.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Nationalism, Liberalism and Socialism$mq$ and p.name = $mq$Ideas and Ideologies$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Liberalism$mq$, $mq$Ideology valuing individual freedom, rights, constitutions and (for economic liberals) free markets with limited state control.$mq$),
($mq$Nationalism$mq$, $mq$Loyalty to a nation and the belief that a people sharing identity should govern themselves.$mq$),
($mq$Socialism$mq$, $mq$Ideology that seeks greater equality, with shared or public ownership of key resources. Grew in response to industrial poverty.$mq$),
($mq$Communist Manifesto$mq$, $mq$Written by Marx and Engels in 1848. Describes class struggle between the bourgeoisie (owners) and proletariat (workers).$mq$),
($mq$Congress of Vienna (1814-15)$mq$, $mq$Meeting of great powers led by Metternich to restore the old order and balance of power after Napoleon.$mq$),
($mq$Italian unification$mq$, $mq$Cavour's diplomacy and Garibaldi's 1860 campaign. Kingdom of Italy proclaimed 1861. Rome joined in 1871.$mq$),
($mq$German unification$mq$, $mq$Led by Bismarck and Prussia: wars against Denmark (1864), Austria (1866) and France (1870-71). Empire proclaimed in January 1871.$mq$),
($mq$Adam Smith$mq$, $mq$Wrote The Wealth of Nations (1776), arguing that free markets and competition can create prosperity.$mq$),
($mq$1848 revolutions$mq$, $mq$Liberal and nationalist uprisings across Europe. Most were suppressed in the short term, but the ideas continued.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Nationalism, Liberalism and Socialism$mq$ and p.name = $mq$Ideas and Ideologies$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$In the nineteenth century, three big ideas shaped politics: **liberalism**, **nationalism** and **socialism**. They grew out of the Enlightenment and revolutions and were also reactions to the Industrial Revolution.

## Liberalism
Liberals believed in individual freedom, equality before the law, written constitutions and elected governments. Economic liberals, following Adam Smith (The Wealth of Nations, 1776), supported free markets with little state control. John Stuart Mill's On Liberty (1859) defended freedom of speech and thought, so long as people did not harm others. Liberals often supported reforms such as extending the vote, though early liberals usually wanted the vote limited to men with property.

## Nationalism
Nationalism is loyalty to a nation sharing language, culture or history, and the belief that such a group should govern itself. After the Congress of Vienna (1814-15), conservative leaders such as Metternich tried to restore old rulers and contain new ideas, but nationalism grew. There were revolutions across Europe in 1848; most were defeated.

- **Italy**: Cavour, prime minister of Piedmont-Sardinia, used diplomacy, Garibaldi's volunteers conquered the south in 1860, and the kingdom of Italy was proclaimed in 1861. Rome joined in 1871.
- **Germany**: Bismarck led Prussia in wars against Denmark (1864), Austria (1866) and France (1870-71). The German Empire was proclaimed at Versailles in January 1871.
Nationalism could also threaten multi-ethnic empires such as Austria-Hungary and the Ottoman Empire, and it increased rivalry between states.

## Socialism
Industrialisation created large cities, factories, low wages and dangerous conditions. Socialists wanted a fairer sharing of wealth. Some reformers, such as Robert Owen, improved conditions in their factories. Karl Marx and Friedrich Engels wrote The Communist Manifesto (1848), describing history as a struggle between classes: the **bourgeoisie** (owners) and the **proletariat** (workers). Marx predicted that workers would overthrow capitalism. Marx's later book Das Kapital appeared in 1867. Trade unions and socialist parties grew. In Britain, the Labour Representation Committee formed in 1900 and became the Labour Party in 1906. Not all socialists favoured revolution; many wanted reform through elections.

## Comparing the ideas
- Liberalism: freedom, rights, free markets.
- Nationalism: the nation and self-determination.
- Socialism: equality and collective ownership.
The ideas often overlapped: some liberals were also nationalists, and some socialists were internationalists who believed workers of all nations shared interests.

## How this is examined
You may get an extract from a pamphlet or speech and be asked to say which ideology it represents, why the author wrote it, and how useful it is as evidence. Another common task is to compare two ideologies or to explain the causes of national unification.

Exam tip: Define the ideology in one clear sentence before applying it. Then link your example (such as Bismarck or the Manifesto) to the key idea in the definition.$mq$ from st;

-- Ideas and Ideologies > Capitalism, Communism and Competing Ideologies
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Ideas and Ideologies$mq$, 5, 3 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Capitalism, Communism and Competing Ideologies$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Ideas and Ideologies$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Capitalism, Communism and Competing Ideologies$mq$ and p.name = $mq$Ideas and Ideologies$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which system is based on private ownership of businesses and competition for profit?$mq$, $mq$["Capitalism","Communism","Feudalism","Absolutism"]$mq$, 0, $mq$In capitalism, individuals and companies own businesses and prices are set largely by supply and demand.$mq$, $mq$easy$mq$),
($mq$Which party, led by Lenin, took power in Russia in October 1917?$mq$, $mq$["The Nazis","The Liberals","The Conservatives","The Bolsheviks"]$mq$, 3, $mq$The Bolsheviks overthrew the Provisional Government and later became the Communist Party.$mq$, $mq$easy$mq$),
($mq$Who became Chancellor of Germany in January 1933, leading the Nazi Party?$mq$, $mq$["Benito Mussolini","Joseph Stalin","Adolf Hitler","Winston Churchill"]$mq$, 2, $mq$Hitler's government soon became a dictatorship. Mussolini led fascist Italy from 1922.$mq$, $mq$easy$mq$),
($mq$What name is given to the period of tension between the USA and the USSR from about 1947 to 1991, without direct large-scale war between them?$mq$, $mq$["The Hundred Years' War","The Cold War","The Napoleonic Wars","The Opium Wars"]$mq$, 1, $mq$The superpowers competed through alliances, an arms race and support for different sides abroad.$mq$, $mq$easy$mq$),
($mq$Which wall, built in 1961, divided a city between East and West?$mq$, $mq$["The Berlin Wall","Hadrian's Wall","The Great Wall","The Atlantic Wall"]$mq$, 0, $mq$East Germany built the Wall to stop people fleeing to the West. It came down in 1989.$mq$, $mq$easy$mq$),
($mq$Which feature was typical of a communist state such as the USSR under Stalin?$mq$, $mq$["Free elections with many parties","Free market competition","Private ownership of all factories","A one-party state with a planned economy"]$mq$, 3, $mq$The state owned industry and ran it through Five-Year Plans from 1928. Political opposition was not allowed.$mq$, $mq$medium$mq$),
($mq$What was the main idea behind Roosevelt's New Deal after 1933?$mq$, $mq$["Abolish capitalism","Stop all trade","Government action to create jobs and support the economy during the Great Depression","Reduce the army to zero"]$mq$, 2, $mq$The New Deal kept capitalism but increased state involvement. It shows that capitalist countries could use government to deal with crisis.$mq$, $mq$medium$mq$),
($mq$The Wall Street Crash of October 1929 led to what?$mq$, $mq$["The end of the Cold War","A Great Depression, with unemployment and falling trade worldwide","The start of the Russian Revolution","A global economic boom"]$mq$, 1, $mq$The crash shook confidence in capitalism and contributed to political extremism in some countries, such as Germany.$mq$, $mq$medium$mq$),
($mq$Which of these is a feature of fascism, as in Mussolini's Italy?$mq$, $mq$["Extreme nationalism, a single leader and suppression of opposition","Democracy","Rule by workers' councils","Free speech for all"]$mq$, 0, $mq$Fascists such as Mussolini (in power from 1922) glorified the nation and used force and propaganda.$mq$, $mq$medium$mq$),
($mq$Which policy announced in 1947 promised US support to countries resisting communism?$mq$, $mq$["The Marshall Plan only","The Warsaw Pact","The Treaty of Rome","The Truman Doctrine"]$mq$, 3, $mq$Truman's policy, linked to aid for Greece and Turkey, was about containment. The Marshall Plan gave economic help to Western Europe.$mq$, $mq$medium$mq$),
($mq$In 1949, communists led by Mao Zedong won power in which country?$mq$, $mq$["Japan","Brazil","China","Poland"]$mq$, 2, $mq$The People's Republic of China was proclaimed on 1 October 1949.$mq$, $mq$medium$mq$),
($mq$The Cuban Missile Crisis of October 1962 was dangerous because of what?$mq$, $mq$["A civil war in France","Soviet missiles in Cuba brought the USA and USSR close to nuclear war","The Berlin Blockade","A trade treaty"]$mq$, 1, $mq$The USA blockaded Cuba and negotiated; the crisis ended when the USSR removed missiles and the USA promised not to invade Cuba.$mq$, $mq$medium$mq$),
($mq$Which statement describes a mixed economy?$mq$, $mq$["Private businesses exist alongside government ownership and welfare","All businesses are state-owned","There is no government","Everything is privately run"]$mq$, 0, $mq$Many countries after 1945, including Britain, combined markets with state services such as the NHS.$mq$, $mq$medium$mq$),
($mq$Evaluate: 'Communism failed because it denied freedom.' Which response is the most balanced?$mq$, $mq$["Only freedom mattered","Communism did not fail","Only the weather mattered","Lack of freedom was important, but economic inefficiency, the arms race and pressure for reform also helped cause the USSR's collapse in 1991"]$mq$, 3, $mq$Strong answers consider multiple causes: economic stagnation, costs of competing with the USA, nationalism in the republics and Gorbachev's reforms.$mq$, $mq$hard$mq$),
($mq$Which factor best explains why many Germans supported extremist parties after 1929?$mq$, $mq$["Germany had full employment","The USSR invaded","The Depression brought mass unemployment and loss of faith in the existing government","Germany joined the EU"]$mq$, 2, $mq$Economic hardship made radical promises attractive. Nazi support grew from a small share of votes in the 1920s to the largest party by 1932.$mq$, $mq$hard$mq$),
($mq$Which statement best compares the economies of the USSR and the USA in the Cold War?$mq$, $mq$["Both used central planning only","The USSR used central planning while the USA relied mostly on markets, though both spent heavily on arms","Neither had factories","The USA abolished private property"]$mq$, 1, $mq$The USSR's planned economy had success in heavy industry but struggled with consumer goods. The USA mixed market capitalism with government spending.$mq$, $mq$hard$mq$),
($mq$A source from 1950 describes the USSR as a danger to the 'free world'. How should a historian treat it?$mq$, $mq$["As evidence of Cold War attitudes, noting that its origin and purpose may make it biased","As a neutral fact","As worthless","As proof that war was inevitable"]$mq$, 0, $mq$Sources reflect the time and the author's views. They are useful for showing opinions, but need to be checked against other evidence.$mq$, $mq$hard$mq$),
($mq$Which comparison between fascism and communism is most accurate?$mq$, $mq$["They had identical economic ideas","Both supported free elections","Both abolished the state at once","Both could be one-party dictatorships using propaganda, but fascism stressed nation and communism stressed class and state ownership"]$mq$, 3, $mq$Both rejected liberal democracy in practice. They differed in ideology, such as private property under fascism versus state ownership under communism.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Capitalism, Communism and Competing Ideologies$mq$ and p.name = $mq$Ideas and Ideologies$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Capitalism$mq$, $mq$System where businesses are privately owned and run for profit, with prices set mainly by supply and demand.$mq$),
($mq$Communism$mq$, $mq$Ideology aiming at a classless society with collective ownership. In practice, one-party states with planned economies, such as the USSR.$mq$),
($mq$Fascism$mq$, $mq$Ideology of extreme nationalism, a single dictator, military strength and suppression of opposition. Mussolini (1922) and Hitler (1933).$mq$),
($mq$Five-Year Plans$mq$, $mq$Stalin's state targets for industry from 1928, aiming to build heavy industry rapidly under central planning.$mq$),
($mq$New Deal$mq$, $mq$Roosevelt's programme from 1933 using government action to create jobs and support recovery after the Great Depression.$mq$),
($mq$Wall Street Crash (1929)$mq$, $mq$Collapse of US share prices that helped trigger the Great Depression and mass unemployment around the world.$mq$),
($mq$Truman Doctrine (1947)$mq$, $mq$US pledge to support countries resisting communism, a policy of containment. Linked to aid for Greece and Turkey.$mq$),
($mq$Cold War$mq$, $mq$Period of tension (about 1947-1991) between the USA and USSR and their allies, without direct large-scale war between them.$mq$),
($mq$Mixed economy$mq$, $mq$An economy mixing private business and market competition with state ownership, welfare and regulation.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Capitalism, Communism and Competing Ideologies$mq$ and p.name = $mq$Ideas and Ideologies$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$In the twentieth century, competing ideologies shaped world events. Understanding the main features of each helps you explain conflicts such as the Cold War.

## Capitalism
In **capitalism**, businesses are privately owned and run for profit. Prices are set mainly by supply and demand, and competition is meant to encourage efficiency. Critics say it can cause inequality and economic crises. After the Wall Street Crash of 1929, the Great Depression caused mass unemployment. Governments such as Roosevelt's in the USA used the New Deal (from 1933) to create jobs. Economists such as John Maynard Keynes argued that governments should spend to support demand. After 1945 many countries adopted a **mixed economy**, combining markets with welfare.

## Communism
**Communism**, based on the ideas of Marx, aims at a classless society where the means of production are collectively owned. In practice, communist states became one-party states with planned economies. The Bolsheviks under Lenin took power in Russia in October 1917. After Lenin, Stalin introduced Five-Year Plans from 1928, collectivised farms and built heavy industry, but millions suffered, and opposition was suppressed. In 1949, Mao Zedong's communists won power in China.

## Fascism
**Fascism** emphasised extreme nationalism, a dictator, military strength and the suppression of opposition. Mussolini took power in Italy in 1922. Hitler became Chancellor of Germany in January 1933, and his Nazi regime added a racist ideology. Fascists opposed communism and liberal democracy, and used propaganda and violence.

## The Cold War
After 1945 the USA (capitalist, democratic) and the USSR (communist) became superpowers. The Truman Doctrine (1947) pledged support to countries resisting communism, and the Marshall Plan gave economic aid to Western Europe. The USSR dominated Eastern Europe. Tensions included the Berlin Blockade, the Korean War (1950-53), the building of the Berlin Wall (1961), and the Cuban Missile Crisis (1962). The USSR collapsed in December 1991.

## Common mistakes
- Do not use 'communism' and 'the Soviet Union' as if they meant the same thing; communism is an idea and the USSR was one state that claimed to apply it.
- Fascism and communism are opposed ideologies, even though both produced dictatorships.
- The Cold War was not a direct war between the USA and the USSR, but it included proxy conflicts such as Korea.

## Judging ideologies
When you compare ideologies, consider their economic ideas, political system (democracy or dictatorship), and use of force and propaganda. Avoid calling an ideology simply 'good' or 'bad'. Instead, describe what its supporters hoped and what happened in practice.

## How this is examined
Typical tasks ask you to interpret a poster, a speech or a statistic, identify the ideology, and explain how the source reflects it. You might also compare how two states applied an ideology, or evaluate why one system lasted longer than another. Use evidence and a clear judgement.

Exam tip: When comparing ideologies, use a table-like structure in your head: economy, politics, control of opposition. Then write full sentences that show similarities and differences with examples.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('history')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;