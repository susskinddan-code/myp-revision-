-- Part 2 of 3: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Global Flows and Interdependence > Trade, Investment and Supply Chains
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Global Flows and Interdependence$mq$, 5, 2 from public.subjects s where s.slug = $mq$geography$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Trade, Investment and Supply Chains$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$geography$mq$ and p.grade = 5 and p.name = $mq$Global Flows and Interdependence$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Trade, Investment and Supply Chains$mq$ and p.name = $mq$Global Flows and Interdependence$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does globalisation mean?$mq$, $mq$["The growing connection and interdependence of countries through flows of goods, money, people and ideas","The decline of trade between countries","Governments controlling all industries","Everyone living in one country"]$mq$, 0, $mq$Globalisation is the process of increasing worldwide connections. It involves trade, investment, migration and information flows.$mq$, $mq$easy$mq$),
($mq$What is a transnational corporation (TNC)?$mq$, $mq$["A company that sells only within its own city","A government department","A charity that does not earn money","A company that operates in more than one country"]$mq$, 3, $mq$TNCs have offices, factories or shops in several countries and often have global supply chains.$mq$, $mq$easy$mq$),
($mq$A tax added to imported goods is called a$mq$, $mq$["Quota","Subsidy","Tariff","Dividend"]$mq$, 2, $mq$A tariff makes imports more expensive so home-produced goods become relatively cheaper. A quota limits quantities.$mq$, $mq$easy$mq$),
($mq$Which of these is an example of a regional trading bloc?$mq$, $mq$["The Sahara","The European Union","The United Nations Children's Fund","A shipping container"]$mq$, 1, $mq$Trading blocs are groups of countries that reduce trade barriers among themselves. The EU is the best known.$mq$, $mq$easy$mq$),
($mq$Foreign direct investment (FDI) occurs when$mq$, $mq$["A company from one country sets up or buys business operations in another country","A tourist buys souvenirs abroad","A government cancels a debt","A worker sends money home"]$mq$, 0, $mq$FDI involves building factories, shops or offices abroad or buying a share in foreign firms.$mq$, $mq$easy$mq$),
($mq$A smartphone is designed in one country, its parts are made in several others and it is assembled in another. This is an example of$mq$, $mq$["A local monopoly","Import substitution","A trade embargo","A global supply chain"]$mq$, 3, $mq$Different stages of production take place in different countries to use skills, costs or resources where they are best.$mq$, $mq$medium$mq$),
($mq$Why do many TNCs locate factories in lower-income countries?$mq$, $mq$["Wages are always higher there","To avoid using any raw materials","Labour costs are often lower and there may be incentives such as tax breaks","Because shipping is impossible from high-income countries"]$mq$, 2, $mq$Lower costs increase profit. However, workers may face poor conditions, so the benefit is debated.$mq$, $mq$medium$mq$),
($mq$Which of these is a likely BENEFIT of FDI for a host country?$mq$, $mq$["Guaranteed higher wages for all workers","New jobs and skills, and increased exports","Complete control of the company by local government","No profits leaving the country"]$mq$, 1, $mq$FDI can create jobs and improve skills and technology. However, profits are often sent back to the home country.$mq$, $mq$medium$mq$),
($mq$In 2021 the container ship Ever Given blocked the Suez Canal for about six days. What does this show about global supply chains?$mq$, $mq$["A single disruption in a key route can delay trade worldwide","Supply chains never depend on shipping","Canals have no effect on trade","Ships are no longer used for trade"]$mq$, 0, $mq$The Suez Canal links the Mediterranean and Red Sea. The blockage held up hundreds of ships and showed the fragility of just-in-time supply.$mq$, $mq$medium$mq$),
($mq$What is meant by comparative advantage?$mq$, $mq$["A country is the best at producing everything","A country does not trade with others","A country produces goods only for itself","A country can produce a good at a lower opportunity cost than another country"]$mq$, 3, $mq$Countries gain by specialising in goods where their opportunity cost is lower and trading for the rest.$mq$, $mq$medium$mq$),
($mq$A country exported goods worth $320 billion and imported goods worth $350 billion. What is its balance of trade in goods?$mq$, $mq$["A surplus of $30 billion","A surplus of $670 billion","A deficit of $30 billion","A deficit of $350 billion"]$mq$, 2, $mq$Exports minus imports = 320 − 350 = −30, so a trade deficit of $30 billion.$mq$, $mq$medium$mq$),
($mq$Which is the best argument AGAINST rapid globalisation?$mq$, $mq$["It makes all goods more expensive for everyone","Local industries may be unable to compete and workers can lose jobs or face poor conditions","It stops information being shared","It increases isolation"]$mq$, 1, $mq$Opening markets can hurt local firms and workers. Evidence on its effects is mixed so a balanced answer is needed.$mq$, $mq$medium$mq$),
($mq$Fairtrade schemes aim to$mq$, $mq$["Give farmers in developing countries a guaranteed minimum price and better working conditions","Raise the price of all goods to consumers by a fixed amount","Stop farmers exporting goods","End all use of cocoa and coffee"]$mq$, 0, $mq$Fairtrade standards include minimum prices and a premium for community projects. Critics note that not all benefit reaches farmers.$mq$, $mq$medium$mq$),
($mq$A country imposes a 20% tariff on imported steel. Which effect is most likely?$mq$, $mq$["Steel prices fall for all buyers","Foreign steel producers gain sales","The country will export more steel","Home steel producers gain a price advantage, but steel-using industries may face higher costs and may retaliate"]$mq$, 3, $mq$Tariffs protect home producers but raise costs for buyers, and trading partners may respond with their own tariffs.$mq$, $mq$hard$mq$),
($mq$A clothing brand sources T-shirts from a factory in a lower-income country where workers earn the legal minimum wage, but pay is below a living wage. Which statement is most accurate?$mq$, $mq$["The brand cannot be criticised if it follows the law","Minimum wage always equals a living wage","The factory complies with the law, but the brand could still be criticised ethically for low pay","Workers are not affected by supply chain decisions"]$mq$, 2, $mq$Legal compliance and ethical responsibility differ. Consumers and campaigners often press brands to pay a living wage.$mq$, $mq$hard$mq$),
($mq$A TNC announces it will move production from Country A to Country B. In Country A, 2,000 jobs are lost. In Country B, 1,200 factory jobs are created, and local suppliers add 600 more. What is the total number of jobs created in B, and what is the net change for the two countries combined?$mq$, $mq$["1,200 created in B; net change −800","1,800 jobs created in B; net change −200","1,800 created in B; net change +200","2,000 created in B; net change 0"]$mq$, 1, $mq$Jobs in B = 1,200 + 600 = 1,800. Net = 1,800 − 2,000 = −200. Forgetting the supplier jobs gives −800.$mq$, $mq$hard$mq$),
($mq$Evaluate: 'Trade barriers should be removed so every country benefits equally.' Which response is strongest?$mq$, $mq$["Free trade can raise efficiency and choice, but benefits are uneven and some industries and workers lose, so support measures are needed","It is true because all countries gain the same","It is false because trade never benefits anyone","It is true because tariffs raise government income for all"]$mq$, 0, $mq$A strong answer recognises gains and losses and that outcomes depend on a country's economy and policies.$mq$, $mq$hard$mq$),
($mq$Just-in-time production keeps very small stocks of parts. During a sudden port closure, what is the likely effect on a factory using this system?$mq$, $mq$["Output will increase because costs are lower","Nothing changes since stocks are huge","Prices must fall immediately","Production may stop quickly because there is little stock to fall back on"]$mq$, 3, $mq$Lean stocks save money in normal times but make firms vulnerable when deliveries are delayed.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Trade, Investment and Supply Chains$mq$ and p.name = $mq$Global Flows and Interdependence$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Globalisation$mq$, $mq$The growing connection and interdependence of the world through flows of goods, money, people, ideas and technology.$mq$),
($mq$Comparative advantage$mq$, $mq$A country can produce a good at a lower opportunity cost than others, so specialising and trading benefits both sides.$mq$),
($mq$Balance of trade$mq$, $mq$Value of exports minus imports. Positive = surplus; negative = deficit.$mq$),
($mq$Tariff, quota, subsidy$mq$, $mq$Tariff: tax on imports. Quota: limit on import quantity. Subsidy: payment to home producers to lower their costs.$mq$),
($mq$Trading bloc$mq$, $mq$A group of countries that reduce trade barriers among themselves, e.g. the European Union or ASEAN.$mq$),
($mq$FDI$mq$, $mq$Foreign direct investment: a company sets up or buys operations abroad.$mq$),
($mq$Multiplier effect$mq$, $mq$New jobs and wages create extra spending in the local area, supporting further jobs and businesses.$mq$),
($mq$Global supply chain$mq$, $mq$The linked stages of making and delivering a product, often spread across several countries.$mq$),
($mq$Just-in-time risk$mq$, $mq$Little stock is held, so a disruption such as a blocked canal can quickly stop production.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Trade, Investment and Supply Chains$mq$ and p.name = $mq$Global Flows and Interdependence$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Globalisation is the increasing connection of countries and people through trade, investment, technology and migration. It means that events in one place can quickly affect many others. In this sub-topic we focus on the flows of goods, services and money.

## Trade
Trade is the buying and selling of goods and services across borders. Countries trade because they have different resources, skills and costs. **Comparative advantage** means a country can make something at a lower opportunity cost than another, so both gain from specialising and trading. The **balance of trade** is exports minus imports: a positive value is a surplus, a negative value a deficit.

Governments sometimes use trade barriers:
- **Tariffs**: taxes on imports that raise their price
- **Quotas**: limits on the quantity of imports
- **Subsidies**: payments to home producers to lower their prices

Trade barriers protect local jobs but can raise prices and lead to retaliation. Countries often form **trading blocs** such as the European Union or ASEAN to lower barriers between members. The World Trade Organization (WTO), set up in 1995, provides rules and a place to settle disputes.

## Investment and TNCs
**Foreign direct investment (FDI)** is when a business sets up or buys operations in another country. Transnational corporations (TNCs) invest abroad to reach new customers, use cheaper labour or resources, or avoid trade barriers. Host countries can benefit through jobs, skills, technology and tax income, and the **multiplier effect**, where wages spent locally create further jobs. Drawbacks can include low wages, poor conditions, profits sent abroad, damage to local firms and environmental harm.

## Global supply chains
A supply chain links all the stages from raw materials to the customer. A smartphone, for example, may be designed in one country, use minerals from others, have parts made in several places and be assembled elsewhere. Containerisation, which put goods in standard-size steel boxes, made shipping cheaper and faster and helped this pattern grow.

Long supply chains are efficient but fragile. When the Ever Given ship blocked the Suez Canal for about six days in 2021, hundreds of vessels were delayed. Just-in-time systems, which hold little stock, are especially exposed to shocks such as port closures, pandemics or conflicts. Some firms now diversify suppliers or move production closer to customers.

## Fair and ethical trade
Fairtrade schemes pay farmers a minimum price plus a premium for community projects. Many consumers and companies also pressure suppliers to improve wages and safety. Complying with the law is not always the same as being ethical, since legal minimum wages can be below a living wage.

## Evaluating globalisation
Winners often include consumers, skilled workers and countries that attract investment. Losers can include workers in industries that shut, farmers who cannot compete with cheap imports and people in places that remain poorly connected. The overall effect depends on the country, the sector and government policy.

## How this is examined
You may be given trade figures, a short report about a TNC, or a map of a supply chain. Typical tasks are calculating a trade balance or job totals, explaining why a firm chooses a location, and evaluating whether a change is good for different groups.

Exam tip: Name the stakeholders (workers, firms, consumers, government) and give one benefit and one cost for at least two of them before you make a judgement.$mq$ from st;

-- Global Flows and Interdependence > Migration, Information and Cultural Flows
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Global Flows and Interdependence$mq$, 5, 2 from public.subjects s where s.slug = $mq$geography$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Migration, Information and Cultural Flows$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$geography$mq$ and p.grade = 5 and p.name = $mq$Global Flows and Interdependence$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Migration, Information and Cultural Flows$mq$ and p.name = $mq$Global Flows and Interdependence$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is migration?$mq$, $mq$["The movement of people from one place to another to live, usually for a long period","The movement of goods by ship","The daily flow of data over the internet","A short holiday abroad"]$mq$, 0, $mq$Migration involves a change of residence. It can be within a country (internal) or between countries (international).$mq$, $mq$easy$mq$),
($mq$Which is a PULL factor that attracts migrants to a place?$mq$, $mq$["War in the home region","Drought and crop failure","Lack of healthcare at home","Better job opportunities"]$mq$, 3, $mq$Pull factors are attractions of the destination. War, drought and poor services are push factors.$mq$, $mq$easy$mq$),
($mq$Which is a PUSH factor?$mq$, $mq$["High wages abroad","Good schools abroad","Conflict or persecution in the home country","A welcoming climate abroad"]$mq$, 2, $mq$Push factors are negative conditions that make people leave.$mq$, $mq$easy$mq$),
($mq$Money sent home by migrants to their families is called$mq$, $mq$["Tariffs","Remittances","Subsidies","Royalties"]$mq$, 1, $mq$Remittances are a major source of income for many countries, for example the Philippines and Nepal.$mq$, $mq$easy$mq$),
($mq$Which of these is an example of an information flow?$mq$, $mq$["Video calls and social media messages sent between countries","A cargo ship carrying cars","A farmer harvesting wheat","A migrant boarding a train"]$mq$, 0, $mq$Information flows are movements of data, ideas and communication, often via the internet and mobile phones.$mq$, $mq$easy$mq$),
($mq$Under the 1951 Refugee Convention a refugee is generally a person who$mq$, $mq$["Moves abroad only to earn more money","Moves from one city to another in the same country","Travels as a tourist","Is outside their country and has a well-founded fear of persecution so cannot or will not return"]$mq$, 3, $mq$Refugees leave because of persecution or conflict. Economic migrants mainly move to seek work or better living conditions.$mq$, $mq$medium$mq$),
($mq$The UK and several other EU countries opened their labour markets to workers from Poland and other new members after 1 May 2004. What does this show?$mq$, $mq$["Migration is only driven by climate","Migration cannot be controlled at all","Government rules and agreements can strongly influence migration flows","Countries never change migration policies"]$mq$, 2, $mq$EU enlargement in 2004 allowed freedom of movement for workers, increasing migration from new member states to some older ones.$mq$, $mq$medium$mq$),
($mq$Brain drain happens when$mq$, $mq$["Unskilled people arrive in large numbers","Skilled workers such as doctors leave a country, reducing its supply of skills","A country imports too many goods","Schools close"]$mq$, 1, $mq$Source countries lose people they have trained, but they may gain remittances and returning skills.$mq$, $mq$medium$mq$),
($mq$Which is a likely benefit of immigration to a country with an ageing population?$mq$, $mq$["More workers of working age pay taxes and fill job vacancies","Fewer people of working age","Less demand for services","A reduction in the cultural mix"]$mq$, 0, $mq$Younger migrants can help balance the dependency ratio, though integration and housing need planning.$mq$, $mq$medium$mq$),
($mq$M-Pesa, a mobile phone money service launched in Kenya in 2007, shows how$mq$, $mq$["Phones prevent trade","Banks are necessary for all transactions","Information flows reduce income","Mobile technology can let people send and receive money without a bank account"]$mq$, 3, $mq$M-Pesa allowed users to transfer money by text message, widening financial access and supporting remittances within countries.$mq$, $mq$medium$mq$),
($mq$What is meant by the digital divide?$mq$, $mq$["The gap between daytime and night","Different screen sizes","The gap between people with good access to digital technology and those with little or none","A fault in an internet cable"]$mq$, 2, $mq$Access varies by income, location, age and infrastructure, so information flows are unequal.$mq$, $mq$medium$mq$),
($mq$Globalisation sometimes leads to 'glocalisation'. Which example fits best?$mq$, $mq$["A shop selling identical goods everywhere","A fast-food chain that adds local flavours to its menu in different countries","A country banning foreign brands","A language dying out"]$mq$, 1, $mq$Glocalisation means adapting global products to local tastes, mixing global and local cultures.$mq$, $mq$medium$mq$),
($mq$Some critics argue that global media can cause cultural homogenisation. What does this mean?$mq$, $mq$["Cultures become more alike as global brands, languages and media dominate","Cultures become more different","Cultures stop interacting","Every country has its own language only"]$mq$, 0, $mq$Homogenisation is the loss of local differences. Others argue cultures adapt and blend instead (hybridisation).$mq$, $mq$medium$mq$),
($mq$Net migration for a city is calculated as immigration minus emigration. Last year 52,000 people moved in and 38,500 moved out. What is the net migration?$mq$, $mq$["−13,500","+90,500","+38,500","+13,500"]$mq$, 3, $mq$52,000 − 38,500 = 13,500, a positive net gain. Adding the figures would give the total movement, not net migration.$mq$, $mq$hard$mq$),
($mq$Country X has a net outflow of 80,000 skilled workers over five years but receives remittances equal to 9% of its national income. Which judgement is most balanced?$mq$, $mq$["The outflow has only benefits","Remittances have no effect on development","Remittances support families and the economy, but losing skilled workers may harm healthcare and industry","Skilled worker loss always makes a country richer"]$mq$, 2, $mq$Strong answers consider both economic benefits and social or skill losses and note the difference between short and long term.$mq$, $mq$hard$mq$),
($mq$A rural region receives faster internet. Which outcome is the LEAST likely direct effect?$mq$, $mq$["Easier access to online education","An immediate fall in the cost of fertiliser to zero","New home-based businesses","Better access to market prices for farmers"]$mq$, 1, $mq$Faster internet can improve information and opportunities, but it does not directly make inputs free.$mq$, $mq$hard$mq$),
($mq$A news report says: 'Thousands cross the border due to drought and food shortages.' A student concludes these people are refugees under the 1951 definition. What is the best critique?$mq$, $mq$["Drought and hunger are push factors, but the legal refugee definition focuses on persecution, so the label may not strictly apply","Drought is the only cause of refugee status","Anyone who crosses a border is a refugee","Refugees can never be affected by drought"]$mq$, 0, $mq$Environmental migrants face real hardship but are not covered by the 1951 definition unless persecution is involved. Precision with terms matters.$mq$, $mq$hard$mq$),
($mq$Evaluate whether social media increases cultural understanding between countries.$mq$, $mq$["It always increases understanding","It never has any effect","It replaces all other forms of communication","It can share ideas quickly and connect people, but algorithms and misinformation can also deepen stereotypes, so the effect depends on use"]$mq$, 3, $mq$A strong evaluation considers benefits and limitations, and who has access.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Migration, Information and Cultural Flows$mq$ and p.name = $mq$Global Flows and Interdependence$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Push and pull factors$mq$, $mq$Push: negative conditions at home (conflict, poverty, drought). Pull: attractions of the destination (jobs, safety, education).$mq$),
($mq$Refugee$mq$, $mq$A person outside their country with a well-founded fear of persecution (1951 Refugee Convention), unable or unwilling to return.$mq$),
($mq$Economic migrant$mq$, $mq$A person who moves mainly to find work or improve living standards, not because of persecution.$mq$),
($mq$Remittances$mq$, $mq$Money sent home by migrants, an important source of income for many countries.$mq$),
($mq$Brain drain$mq$, $mq$Loss of skilled workers, such as doctors and engineers, from a country when they emigrate.$mq$),
($mq$Net migration$mq$, $mq$Immigration minus emigration. Positive = net gain; negative = net loss.$mq$),
($mq$Digital divide$mq$, $mq$Gap between those with good access to digital technology and those with little or none.$mq$),
($mq$Cultural diffusion$mq$, $mq$Spread of cultural features such as food, music, language and fashion between places.$mq$),
($mq$Homogenisation vs glocalisation$mq$, $mq$Homogenisation: cultures become more alike. Glocalisation: global products are adapted to local tastes.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Migration, Information and Cultural Flows$mq$ and p.name = $mq$Global Flows and Interdependence$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$People, information and culture also flow around the world. Migration, communication technology and the spread of ideas make countries more interdependent. This sub-topic looks at why people move, what the consequences are, and how information and culture travel.

## Migration
**Migration** is a long-term change in where someone lives. **Internal migration** happens within a country, for example from villages to cities. **International migration** crosses borders. Reasons are often explained as push and pull factors.
- **Push factors** are negative conditions at home, such as conflict, persecution, poverty, lack of jobs, drought or poor services.
- **Pull factors** attract people to a destination, such as jobs, higher wages, safety, education and family links.
Migration may be voluntary (choosing to move for work or study) or forced (fleeing conflict). A **refugee**, under the 1951 Refugee Convention, is someone outside their country with a well-founded fear of persecution. An economic migrant moves mainly to find work. Be careful to use these terms accurately.

Governments influence migration through visas, border controls and agreements. For example, after the 2004 enlargement of the European Union, workers from new member states such as Poland gained the right to look for work in several older member states.

## Impacts of migration
For the **source country** the benefits include remittances (money sent home), which can be a major source of income, and skills gained abroad. Costs include **brain drain**, when skilled people such as doctors leave. For the **destination country** the benefits include filling labour shortages, paying taxes and cultural diversity. The challenges include pressure on housing and services, and the need to support integration. Impacts differ by place, so avoid saying that migration is simply good or bad.

## Information flows
The internet, mobile phones and satellites let information travel almost instantly. Examples include video calls, online learning and financial services. M-Pesa, which started in Kenya in 2007, allows people to send money by mobile phone, even without a bank account. But there is a **digital divide**: poorer, rural or older people often have less access, which can widen inequality. Misinformation can also spread rapidly, so critical thinking about sources matters.

## Cultural flows
**Cultural diffusion** is the spread of music, food, language, fashion and ideas across the world. Migration, tourism, trade and media all drive it. Two views are common:
- **Homogenisation**: cultures become more alike as global brands and English-language media dominate
- **Hybridisation or glocalisation**: global ideas are adapted to local tastes, such as a fast-food chain adding local menu items
Many places experience both. Local traditions may weaken, but they can also be revived and shared worldwide through the same technologies.

## Calculations and data
Net migration = immigration minus emigration. Always check which number is bigger and give the sign. Population change also includes natural change (births minus deaths).

## How this is examined
Typical tasks show migration statistics, a news extract or a graph of internet use. You are asked to explain push and pull factors, calculate net migration, compare impacts on source and destination countries, and evaluate how information and culture flows affect different groups.

Common mistakes: using "refugee" and "migrant" as if they were the same; listing only positive or only negative impacts; describing homogenisation as if it were the only possible outcome.

Exam tip: When asked to evaluate, show both sides, name the groups affected (for example young people, employers, local residents) and finish with a clear judgement supported by evidence from the source.$mq$ from st;

-- Resource Extraction and Consumption > Extraction and Production of Resources
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Resource Extraction and Consumption$mq$, 5, 3 from public.subjects s where s.slug = $mq$geography$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Extraction and Production of Resources$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$geography$mq$ and p.grade = 5 and p.name = $mq$Resource Extraction and Consumption$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Extraction and Production of Resources$mq$ and p.name = $mq$Resource Extraction and Consumption$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which of the following is a non-renewable resource?$mq$, $mq$["Coal","Wind","Solar energy","Timber from a well-managed forest"]$mq$, 0, $mq$Coal formed over millions of years and cannot be replaced within a human timescale. Wind and sun are renewable.$mq$, $mq$easy$mq$),
($mq$What is open-cast (surface) mining?$mq$, $mq$["Drilling for oil under the sea","Collecting rainwater","Harvesting crops by machine","Digging minerals from a large pit at the surface"]$mq$, 3, $mq$Open-cast mining removes soil and rock to reach shallow deposits. It is cheaper than underground mining but changes the landscape.$mq$, $mq$easy$mq$),
($mq$Which resource is a fossil fuel?$mq$, $mq$["Uranium","Geothermal heat","Natural gas","Biomass"]$mq$, 2, $mq$Fossil fuels are coal, oil and natural gas formed from ancient organisms. Uranium is used in nuclear power but is not a fossil fuel.$mq$, $mq$easy$mq$),
($mq$A resource that can be replaced naturally within a human lifetime if managed properly is called$mq$, $mq$["Finite","Renewable","Extinct","Reserve-limited"]$mq$, 1, $mq$Renewable resources such as timber, fish and solar energy can be replaced, but only if not over-used.$mq$, $mq$easy$mq$),
($mq$Which is a likely environmental impact of mining?$mq$, $mq$["Habitat destruction and water pollution","Increased soil fertility","Reduced noise","More forest cover"]$mq$, 0, $mq$Mining removes vegetation and can pollute water with chemicals and waste rock.$mq$, $mq$easy$mq$),
($mq$Which of these best defines a 'reserve' of a resource?$mq$, $mq$["All the resource that exists anywhere","The amount already used","A resource that is renewable","The amount that can be extracted profitably with current technology"]$mq$, 3, $mq$Reserves are the known deposits that are economically and technically recoverable now. Resources can be larger overall.$mq$, $mq$medium$mq$),
($mq$Norway began oil production in the North Sea after discovering the Ekofisk field in 1969. Since 1990 it has saved oil income in a government pension fund. Why was this a sensible policy?$mq$, $mq$["Oil is renewable so there is no reason to save","It stops the country selling oil","It spreads the benefit to future generations rather than spending all the income immediately","It means companies pay no tax"]$mq$, 2, $mq$Oil is finite, so investing revenues helps the economy after oil runs out and avoids boom-and-bust cycles.$mq$, $mq$medium$mq$),
($mq$The 'resource curse' describes a situation where$mq$, $mq$["Resources cannot be sold","A country rich in natural resources has weak growth, corruption or conflict instead of benefits","A country has no resources","A resource is renewable"]$mq$, 1, $mq$Dependence on exports of one resource can lead to unstable income and conflict over revenues. It is not inevitable.$mq$, $mq$medium$mq$),
($mq$The Democratic Republic of Congo produces a large share of the world's cobalt, used in rechargeable batteries. Which issue is most associated with this mining?$mq$, $mq$["Concerns about working conditions, child labour in informal mines and environmental damage","A lack of any cobalt deposits","No international demand","Reliance on offshore platforms"]$mq$, 0, $mq$Informal artisanal mining has been linked to unsafe conditions. Campaigns call for traceable, ethical supply chains.$mq$, $mq$medium$mq$),
($mq$The Deepwater Horizon explosion in the Gulf of Mexico (April 2010) is best described as$mq$, $mq$["A tidal wave caused by an earthquake","A planned oil-saving scheme","A coal mine collapse in Chile","A major offshore oil spill disaster that harmed marine and coastal ecosystems and killed 11 workers"]$mq$, 3, $mq$The rig explosion released millions of barrels of oil, affecting fisheries and wildlife and leading to major clean-up and compensation.$mq$, $mq$medium$mq$),
($mq$Alberta's oil sands (Canada) are controversial mainly because$mq$, $mq$["The deposits are tiny","The oil is renewable","Extracting oil from them is energy intensive and causes land disturbance and large greenhouse gas emissions","They are in the Sahara"]$mq$, 2, $mq$Both surface mining and in-situ methods use large amounts of energy and water. They also bring jobs and income.$mq$, $mq$medium$mq$),
($mq$A copper mine's output rose from 400,000 tonnes in 2015 to 520,000 tonnes in 2025. What was the percentage increase?$mq$, $mq$["23%","30%","120,000%","130%"]$mq$, 1, $mq$Increase = 120,000. 120,000 ÷ 400,000 × 100 = 30%. 23% divides by the new value, which is the wrong base.$mq$, $mq$medium$mq$),
($mq$Which statement about extracting oil in the Niger Delta is best supported by evidence?$mq$, $mq$["Oil spills and gas flaring have damaged local farming and fishing, causing conflict with communities","The spills improved fish catches","The region has no oil industry","Local communities have no concerns"]$mq$, 0, $mq$Repeated spills and flaring have been widely reported to harm livelihoods and health in parts of the Niger Delta.$mq$, $mq$medium$mq$),
($mq$A government wants to open a new coal mine that will create 800 jobs in a poor region but will damage a nearby wetland. Which approach is most balanced?$mq$, $mq$["Approve it because jobs are the only factor","Reject it because mining is always bad","Ignore the views of local residents","Compare economic benefits with environmental costs, consult local people and consider alternatives such as renewable energy projects"]$mq$, 3, $mq$A balanced decision weighs economic, social and environmental criteria and includes stakeholder views.$mq$, $mq$hard$mq$),
($mq$Between 2010 and 2020 a country's solar capacity increased from 50 MW to 4,050 MW. How many times larger is the 2020 capacity?$mq$, $mq$["80 times","8,100 times","81 times","4,000 times"]$mq$, 2, $mq$4,050 ÷ 50 = 81. The increase is 4,000 MW (80 times the original) but the new capacity is 81 times the original.$mq$, $mq$hard$mq$),
($mq$Lithium is used in electric vehicle batteries. Lithium brine extraction in the Atacama region of Chile uses large amounts of water. What is the best geographical issue to consider?$mq$, $mq$["Whether lithium is renewable","Balancing global demand for clean-energy materials with local water scarcity and community rights","Whether Chile is in the northern hemisphere","How to cool the brine with ice"]$mq$, 1, $mq$Resources that help the energy transition can create local environmental and social costs in dry regions, so management is a trade-off.$mq$, $mq$hard$mq$),
($mq$An analyst says: 'Because renewable energy has no environmental impact, we do not need to regulate its development.' Which critique is most valid?$mq$, $mq$["Renewables have lower emissions in use but can still affect land, wildlife, materials supply and communities, so regulation is needed","The claim is correct because renewables are perfect","Renewables cannot generate electricity","Only coal needs regulation"]$mq$, 0, $mq$Wind farms, hydroelectric dams and solar farms have impacts such as habitat disturbance, so planning and regulation matter.$mq$, $mq$hard$mq$),
($mq$Evaluate whether a developing country should sell its mineral resources as raw ore or process them locally first.$mq$, $mq$["Raw ore always earns more than processed goods","Processing creates no jobs","Processing is impossible for any country","Processing locally adds value, jobs and skills, but needs investment and technology, so a phased approach may be best"]$mq$, 3, $mq$Value-added processing increases income, but requires capital, energy and skills. A good evaluation notes these constraints.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Extraction and Production of Resources$mq$ and p.name = $mq$Resource Extraction and Consumption$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Renewable vs non-renewable$mq$, $mq$Renewable: replaced naturally in a human timescale (wind, timber). Non-renewable: finite (coal, oil, metal ores).$mq$),
($mq$Reserve$mq$, $mq$The amount of a resource that can be extracted profitably with current technology and prices.$mq$),
($mq$Open-cast mining$mq$, $mq$Surface mining in a large pit. Cheaper than underground mining but removes vegetation and alters landscapes.$mq$),
($mq$Resource curse$mq$, $mq$A resource-rich country grows slowly or suffers corruption and conflict, often due to reliance on one export.$mq$),
($mq$Norway's oil fund$mq$, $mq$After Ekofisk (1969) Norway created a government pension fund (1990) to invest oil income for future generations.$mq$),
($mq$Deepwater Horizon$mq$, $mq$2010 offshore oil rig explosion in the Gulf of Mexico; 11 workers died and a huge spill damaged ecosystems and fisheries.$mq$),
($mq$Value added$mq$, $mq$Extra income from processing raw materials into finished goods, e.g. refining ore locally.$mq$),
($mq$Environmental impacts of extraction$mq$, $mq$Habitat loss, water and air pollution, greenhouse gas emissions, noise, dust and waste rock.$mq$),
($mq$Percentage change$mq$, $mq$(new − old) ÷ old × 100. Divide by the original value.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$geography$mq$ and t.grade = 5 and t.name = $mq$Extraction and Production of Resources$mq$ and p.name = $mq$Resource Extraction and Consumption$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Resources are materials from the natural environment that people use. In this sub-topic we look at how resources are extracted and produced, who gains and loses, and how extraction can be managed.

## Types of resource
- **Renewable** resources can be replaced naturally in a human timescale, if they are not over-used. Examples are timber, fish, wind and solar energy.
- **Non-renewable** (finite) resources cannot be replaced in a human lifetime. Examples are coal, oil, natural gas and metal ores.
Fossil fuels were formed from ancient organisms over millions of years. A **reserve** is the amount of a resource that can be extracted profitably with current technology, so reserves can change as prices and technology change.

## Extraction methods
Minerals near the surface are mined by **open-cast** (surface) mining, which is cheaper but changes the landscape. Deep deposits need **underground** mining, which is more dangerous and expensive. Oil and gas are produced from wells on land or offshore platforms. In Alberta, Canada, oil is obtained from oil sands by surface mining or by injecting steam underground (in-situ). Both methods are energy intensive.

## Impacts of extraction
Positive impacts include jobs, export income, tax revenue and new infrastructure. Negative impacts include:
- habitat loss, soil damage and water pollution
- greenhouse gas emissions, noise and dust
- accidents, such as the Deepwater Horizon explosion in the Gulf of Mexico in 2010, in which 11 workers died and a huge spill harmed marine life
- conflict over land and revenues, and unsafe working conditions in informal mines, as reported in cobalt mining in the Democratic Republic of Congo

Oil spills and gas flaring in the Niger Delta have affected farming and fishing and caused tension with local communities.

## The resource curse
Some countries rich in resources grow slowly or suffer corruption and conflict. This is called the **resource curse**. Relying on a single export makes a country's income unstable when prices fall. Norway offers a contrasting example. After discovering the Ekofisk field in 1969 and building its oil industry, it created a government pension fund in 1990 to invest oil income for future generations.

## Adding value
Selling raw materials usually earns less than selling processed goods. Local processing can create jobs and skills but needs capital, energy and technology. Many countries try to move up the value chain over time.

## Managing extraction
- strict environmental laws, impact assessments and monitoring
- restoring mined land (rehabilitation)
- sharing revenue with local communities
- ethical sourcing and traceability of materials such as cobalt
- shifting towards renewable energy and recycling to reduce demand for new extraction

Renewables are not impact-free. Wind farms, solar farms and hydroelectric dams use land and materials and can affect wildlife and communities. Clean energy also needs minerals like lithium and cobalt, so extraction continues in a different form.

## Calculations
Practise percentage change: (new − old) ÷ old × 100. Always divide by the original value. For multiples, divide the new value by the old (for example 4,050 ÷ 50 = 81).

## How this is examined
You may be given a short case study of a mine, oil field or wind farm, plus production data. You calculate changes, describe positive and negative impacts for different stakeholders, and evaluate a decision such as whether a project should go ahead.

Exam tip: Use a clear structure in your answer: economic, social and environmental impacts, then a judgement that says which matters most and why.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('geography')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;