-- Part 2 of 6: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Globalisation and Trade > Trade, Exchange and Early Globalisation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Globalisation and Trade$mq$, 5, 2 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Trade, Exchange and Early Globalisation$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Globalisation and Trade$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Trade, Exchange and Early Globalisation$mq$ and p.name = $mq$Globalisation and Trade$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$The Silk Roads were networks of trade routes linking which two regions in particular?$mq$, $mq$["China and the Mediterranean world","Australia and Antarctica","North and South America only","Scandinavia and Iceland"]$mq$, 0, $mq$Goods such as silk, spices and paper travelled along the Silk Roads between East Asia, Central Asia, the Middle East and Europe, often passing through many traders.$mq$, $mq$easy$mq$),
($mq$What name is given to the movement of plants, animals, diseases and people between the Americas and the rest of the world after 1492?$mq$, $mq$["The Silk Exchange","The Marshall Plan","The Hanseatic League","The Columbian Exchange"]$mq$, 3, $mq$The Columbian Exchange moved crops such as potatoes and maize to the Old World and horses, wheat and diseases to the Americas.$mq$, $mq$easy$mq$),
($mq$Which two goods were carried across the Sahara in the trans-Saharan trade, among others?$mq$, $mq$["Oil and cars","Tea and coffee only","Gold and salt","Computers and cotton"]$mq$, 2, $mq$West African gold was traded north, and salt from the Sahara came south. Cities such as Timbuktu became wealthy.$mq$, $mq$easy$mq$),
($mq$Which company, founded in 1600, gained a trade monopoly in Asia and later ruled large parts of India?$mq$, $mq$["The Hudson Bay Gazette","The British East India Company","The Hanseatic Bank","The Silk Road Union"]$mq$, 1, $mq$The East India Company began as a trading company. Over time it gained political and military power in India.$mq$, $mq$easy$mq$),
($mq$Which waterway, opened in 1869, shortened the sea route between Europe and Asia?$mq$, $mq$["The Suez Canal","The Panama Canal","The Thames Barrier","The Rhine"]$mq$, 0, $mq$The Suez Canal in Egypt removed the need to sail around Africa. The Panama Canal opened in 1914 and links the Atlantic and Pacific.$mq$, $mq$easy$mq$),
($mq$Which statement best explains why Mansa Musa's pilgrimage to Mecca in 1324 is remembered?$mq$, $mq$["He opened the Suez Canal","He founded the East India Company","He ended the slave trade","He travelled with huge quantities of gold, showing the wealth of Mali and its trade links"]$mq$, 3, $mq$Mansa Musa, ruler of the Mali Empire, made a famous hajj. His wealth came from gold and trans-Saharan trade, and Mali appeared on later European maps.$mq$, $mq$medium$mq$),
($mq$How did the Silk Roads help spread the Black Death in the 1300s?$mq$, $mq$["Silk itself carried the virus","Merchants deliberately brought plague","Trade and travel carried infected fleas and people between regions","The plague only spread by sea ships from Africa"]$mq$, 2, $mq$Disease spreads along contact routes. The plague moved along trade routes and ports, showing a negative side of exchange.$mq$, $mq$medium$mq$),
($mq$Which was an effect of the Columbian Exchange on Native American populations?$mq$, $mq$["They gained immunity to all diseases","Diseases such as smallpox killed very large numbers","Their population grew rapidly","Europeans carried no diseases"]$mq$, 1, $mq$Native Americans had no immunity to diseases like smallpox and measles brought by Europeans, and populations fell sharply.$mq$, $mq$medium$mq$),
($mq$Look at the following description: 'Ships carried manufactured goods from Britain to West Africa, enslaved Africans to the Americas, and sugar and cotton back to Britain.' What was this system known as?$mq$, $mq$["The triangular trade","The Silk Road","The Marshall Plan","The Common Market"]$mq$, 0, $mq$The transatlantic slave trade formed part of a triangular pattern. Millions of Africans were forced across the Atlantic in brutal conditions.$mq$, $mq$medium$mq$),
($mq$The Slavery Abolition Act of 1833 applied to which empire?$mq$, $mq$["The Mali Empire","The Roman Empire","The Mongol Empire","The British Empire"]$mq$, 3, $mq$Britain banned the slave trade in 1807 and slavery in most of its empire in 1833. Other countries abolished slavery at different times.$mq$, $mq$medium$mq$),
($mq$Which development between 1870 and 1914 most helped the growth of global trade?$mq$, $mq$["The internet","Container ships","Steamships, railways and the telegraph","Jet aircraft"]$mq$, 2, $mq$Faster, cheaper transport and communication connected markets. The internet and containers came in the late 1900s.$mq$, $mq$medium$mq$),
($mq$Why did the Hanseatic League, a group of northern European trading cities, form in the Middle Ages?$mq$, $mq$["To spread Islam","To protect merchants and trade and negotiate privileges","To fight the Black Death","To build the Suez Canal"]$mq$, 1, $mq$Cities such as Lübeck and Hamburg cooperated to protect trade in the Baltic and North Sea, showing that trade networks required organisation.$mq$, $mq$medium$mq$),
($mq$Which of these was a long-term consequence of European control of trade routes to Asia in the 1600s-1700s?$mq$, $mq$["European companies gained wealth and political influence in parts of Asia","Asian empires lost all trade","Trade ended for 200 years","European people stopped consuming spices"]$mq$, 0, $mq$Companies such as the Dutch VOC (1602) and British East India Company created trading posts and later power in Asia. Trade did not stop.$mq$, $mq$medium$mq$),
($mq$Evaluate: 'Early globalisation benefited everyone involved.' Which response is the most accurate?$mq$, $mq$["It benefited everyone equally","It harmed everyone equally","It had no effect","It brought wealth and new goods to some, but also disease, exploitation and slavery for others"]$mq$, 3, $mq$Trade created wealth, cultural exchange and new foods, but many people suffered through forced labour, loss of land and disease.$mq$, $mq$hard$mq$),
($mq$Which source would be most valuable for judging how large the transatlantic slave trade was?$mq$, $mq$["A modern film","One merchant's diary entry on weather","Shipping records and port records of captives transported","A cookery book"]$mq$, 2, $mq$Shipping records give figures that historians can combine into estimates. Better evidence comes from many records rather than one personal account.$mq$, $mq$hard$mq$),
($mq$The potato, introduced to Europe from the Americas, is linked to population growth in parts of Europe. Which reasoning is strongest?$mq$, $mq$["It was the first crop in Europe","It grew in poor soil and gave many calories per hectare, helping people to be fed","It contained medicines","It ended all famines"]$mq$, 1, $mq$The potato's productivity supported growth, but dependence on it could be dangerous. The Irish famine of the 1840s followed potato blight.$mq$, $mq$hard$mq$),
($mq$A historian says the Silk Road is better described as 'many routes and many traders' than as 'one road'. Which fact best supports this view?$mq$, $mq$["Goods were usually passed along between different merchants and over varied routes rather than carried by a single trader for the whole journey","The road was a single paved highway","Only one empire controlled it","No goods other than silk were traded"]$mq$, 0, $mq$The network included overland and sea routes, with goods and ideas exchanged at cities along the way.$mq$, $mq$hard$mq$),
($mq$Which comparison between the Silk Roads and the Atlantic trade of the 1600s-1700s is most accurate?$mq$, $mq$["The Silk Roads had slavery as their only feature","The Atlantic trade was only about silk","Neither involved long-distance travel","The Atlantic trade involved large-scale forced labour of enslaved people as a central feature, which was a major difference in scale and organisation"]$mq$, 3, $mq$Both were long-distance networks, but the Atlantic system centred on plantation economies and the enslavement of millions of Africans.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Trade, Exchange and Early Globalisation$mq$ and p.name = $mq$Globalisation and Trade$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Silk Roads$mq$, $mq$Network of land and sea routes linking China with Central Asia, the Middle East and Europe, carrying silk, spices, paper, ideas, religions and disease.$mq$),
($mq$Trans-Saharan trade$mq$, $mq$Trade across the Sahara: West African gold went north and salt came south. Helped the Mali Empire grow rich.$mq$),
($mq$Mansa Musa$mq$, $mq$Ruler of Mali who made a famous pilgrimage to Mecca in 1324, showing the empire's gold wealth.$mq$),
($mq$Columbian Exchange$mq$, $mq$The transfer of crops, animals, diseases and people between the Americas and the Old World after 1492.$mq$),
($mq$Triangular trade$mq$, $mq$Atlantic pattern linking Europe, West Africa and the Americas, with the forced transport of enslaved Africans at its centre.$mq$),
($mq$British East India Company$mq$, $mq$Trading company founded in 1600 which gained monopoly rights in Asia and later political and military power in India.$mq$),
($mq$Abolition dates$mq$, $mq$Britain banned the slave trade in 1807 and abolished slavery in most of its empire in 1833.$mq$),
($mq$Steamships, railways, telegraph$mq$, $mq$Technologies that made world trade faster and cheaper in 1870-1914, driving the first wave of modern globalisation.$mq$),
($mq$Suez and Panama Canals$mq$, $mq$Suez (1869) linked the Mediterranean and Red Sea. Panama (1914) linked the Atlantic and Pacific. Both shortened sea routes.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Trade, Exchange and Early Globalisation$mq$ and p.name = $mq$Globalisation and Trade$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Globalisation means that countries, economies and cultures become more connected. This is not new: for thousands of years people traded goods and exchanged ideas over long distances. The 'early globalisation' you need to know about includes trade routes, empires and the movement of people, crops and diseases.

## Trade routes
The **Silk Roads** were a network of land and sea routes linking China with Central Asia, India, the Middle East and Europe from around the second century BC under the Han dynasty. Silk, spices, paper and porcelain moved west, and horses, glass and silver moved east. Religions such as Buddhism and Islam spread along these routes, but so did disease: the Black Death moved along trade routes in the 1300s.

In Africa, the **trans-Saharan trade** carried gold from West Africa north and salt south. The Mali Empire grew rich, and its ruler Mansa Musa made a famous pilgrimage to Mecca in 1324. Indian Ocean trade used the monsoon winds to link East Africa, Arabia, India and Southeast Asia. In the early 1400s the Chinese admiral Zheng He led large fleets across the Indian Ocean.

## The Atlantic world
After 1492 voyages by Europeans connected the Americas with Europe, Africa and Asia. The **Columbian Exchange** moved potatoes, maize and tomatoes to Europe and Africa, and horses, wheat and cattle to the Americas. It also moved disease: smallpox and measles devastated Native American communities that had no immunity.

European companies such as the British East India Company (founded 1600) and the Dutch VOC (1602) had monopolies on trade in Asia. In the Americas, plantations growing sugar, cotton and tobacco depended on the **transatlantic slave trade**, in which millions of Africans were taken in terrible conditions. Britain banned the slave trade in 1807 and slavery in most of its empire in 1833, but the effects lasted far longer.

## The nineteenth century
Between about 1870 and 1914, steamships, railways and the telegraph made trade faster and cheaper. The Suez Canal opened in 1869 and the Panama Canal in 1914. European empires controlled raw materials and markets, and trade grew quickly. This period is sometimes called the first wave of modern globalisation.

## Consequences
- Positive: new foods and technologies, wealth, cultural exchange and growth of cities.
- Negative: disease, slavery, loss of land and unequal power between regions.
- Different groups experienced globalisation differently, so always ask who benefited and who lost.

## How this is examined
Questions might show a map or a short source about a trade route, then ask you to explain causes, describe consequences or evaluate how far globalisation benefited different groups. Command terms: explain, compare, evaluate. Support points with specific names, dates and places and consider the origin and purpose of each source.

Exam tip: Avoid one-sided answers. Say who gained and who lost from a trade link, and finish with a judgement.$mq$ from st;

-- Globalisation and Trade > Post-1945 Globalisation and Institutions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Globalisation and Trade$mq$, 5, 2 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Post-1945 Globalisation and Institutions$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Globalisation and Trade$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Post-1945 Globalisation and Institutions$mq$ and p.name = $mq$Globalisation and Trade$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which organisation, created in 1995, deals with the rules of trade between countries and replaced GATT?$mq$, $mq$["The World Trade Organization (WTO)","The World Health Organization","The League of Nations","NATO"]$mq$, 0, $mq$The WTO is based in Geneva. GATT was the earlier agreement on tariffs from 1947.$mq$, $mq$easy$mq$),
($mq$What is a tariff?$mq$, $mq$["A subsidy to farmers","A ban on exports","A loan from the IMF","A tax on imported goods"]$mq$, 3, $mq$Tariffs raise the price of imports to protect home industries. Free trade agreements reduce them.$mq$, $mq$easy$mq$),
($mq$Which international body, created after the 1944 Bretton Woods conference, lends money to countries with economic difficulties?$mq$, $mq$["The European Court","The Red Cross","The International Monetary Fund (IMF)","The Warsaw Pact"]$mq$, 2, $mq$The IMF and World Bank were set up to rebuild and stabilise the world economy after the Second World War.$mq$, $mq$easy$mq$),
($mq$What do we call a company that operates in several countries, such as a car maker with factories on different continents?$mq$, $mq$["A charity","A transnational (multinational) corporation","A trade union","A tariff union"]$mq$, 1, $mq$TNCs can produce goods where costs are lowest and sell worldwide.$mq$, $mq$easy$mq$),
($mq$Which treaty of 1957 created the European Economic Community?$mq$, $mq$["The Treaty of Rome","The Treaty of Versailles","The Treaty of Maastricht","The Treaty of Vienna"]$mq$, 0, $mq$The EEC began with six countries. It became the European Union under the Maastricht Treaty, which took effect in 1993.$mq$, $mq$easy$mq$),
($mq$Which development in the 1950s lowered shipping costs and speeded up world trade?$mq$, $mq$["The telegraph","Sailing ships","The printing press","Containerisation of cargo"]$mq$, 3, $mq$Standard steel containers could be moved between ship, train and lorry. Malcolm McLean's first container voyage was in 1956.$mq$, $mq$medium$mq$),
($mq$Why do many companies outsource manufacturing to countries such as Bangladesh or Vietnam?$mq$, $mq$["Taxes are always higher there","They want to avoid selling goods","Lower wages and costs raise profits","It is illegal to produce at home"]$mq$, 2, $mq$Lower labour costs are the main reason. Critics point to poor working conditions in some factories.$mq$, $mq$medium$mq$),
($mq$The 2013 collapse of the Rana Plaza factory building in Bangladesh killed more than 1,100 workers. What debate did it raise?$mq$, $mq$["Whether tariffs should be abolished","Whether global companies were responsible for safe conditions in their suppliers' factories","Whether the euro should be adopted","Whether containers should be banned"]$mq$, 1, $mq$Clothing brands sourced goods from factories in the building. The disaster led to agreements on safety inspections.$mq$, $mq$medium$mq$),
($mq$Which is an argument in favour of free trade?$mq$, $mq$["It can lower prices and give consumers more choice","It always protects local jobs","It prevents imports","It makes tariffs higher"]$mq$, 0, $mq$Free trade removes barriers so countries can specialise. The disadvantage is that some industries and workers lose out.$mq$, $mq$medium$mq$),
($mq$Which is an argument against rapid globalisation?$mq$, $mq$["Trade makes goods cheaper","It increases consumer choice","It lets countries specialise","Factories in richer countries may close, causing job losses in some regions"]$mq$, 3, $mq$Competition from cheaper imports can hurt industries such as steel or textiles. Governments sometimes respond with tariffs or retraining.$mq$, $mq$medium$mq$),
($mq$Which statement describes the 'Asian Tigers' (South Korea, Taiwan, Hong Kong, Singapore)?$mq$, $mq$["They stayed poor and closed to trade","They were members of the EEC","They grew rapidly from the 1960s by exporting manufactured goods","They were colonies of the USSR"]$mq$, 2, $mq$Export-led growth moved these economies from low to high income within a few decades.$mq$, $mq$medium$mq$),
($mq$In 1978 China began economic reforms under Deng Xiaoping. What was one result?$mq$, $mq$["China left all trade","Foreign investment and exports grew, and China joined the WTO in 2001","China adopted the euro","China became a member of NAFTA"]$mq$, 1, $mq$Special economic zones attracted investment. China became a major exporter and the world's 'factory'.$mq$, $mq$medium$mq$),
($mq$Which statement about NAFTA is correct?$mq$, $mq$["It was a free trade agreement between the USA, Canada and Mexico from 1994","It was a military alliance","It created a single currency","It was founded in 1957"]$mq$, 0, $mq$NAFTA removed most tariffs between three North American countries. It was replaced by the USMCA in 2020.$mq$, $mq$medium$mq$),
($mq$A country joins a free trade area and its farmers face cheaper imported food. Which prediction is most reasonable?$mq$, $mq$["Everyone is better off","Everyone is worse off","Nothing changes","Consumers may benefit from lower prices, while farmers may see falling incomes unless they adapt"]$mq$, 3, $mq$Trade usually creates winners and losers. Governments may provide subsidies or help for those who lose out.$mq$, $mq$hard$mq$),
($mq$Which evidence would best support the claim that globalisation has reduced extreme poverty in China?$mq$, $mq$["A photo of a modern city","A single factory worker's complaint","Statistics showing the share of people living below a poverty line falling over several decades","A list of Chinese products"]$mq$, 2, $mq$Data over time gives stronger evidence than a single example. Even so, inequality within China also grew and the data come from specific measures.$mq$, $mq$hard$mq$),
($mq$Which statement best explains why the WTO and IMF are criticised by some people?$mq$, $mq$["They give all countries identical rights and power","Critics say rules and loan conditions favour richer countries and can harm poorer ones","They have no influence","They only deal with sport"]$mq$, 1, $mq$Some argue that wealthy states have more bargaining power and that IMF conditions can force cuts in public spending. Supporters say the bodies promote stability and growth.$mq$, $mq$hard$mq$),
($mq$COVID-19 caused shortages of goods when factories closed. What does this show about global supply chains?$mq$, $mq$["They can be efficient but are vulnerable to disruption in one place","They cannot be disrupted","They only exist inside one country","They are unaffected by disease"]$mq$, 0, $mq$Many products depend on parts from several countries, so a closure or shipping delay can affect production elsewhere.$mq$, $mq$hard$mq$),
($mq$Evaluate: 'Globalisation since 1945 has been mostly positive.' Which answer shows the best judgement?$mq$, $mq$["It has had no effect on the environment","It has made all countries equal","It has caused only harm","It has raised living standards and connections but has increased inequality in some places and put pressure on the environment"]$mq$, 3, $mq$A balanced judgement looks at economic, social and environmental effects and considers different groups before concluding.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Post-1945 Globalisation and Institutions$mq$ and p.name = $mq$Globalisation and Trade$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Bretton Woods (1944)$mq$, $mq$Conference that created the IMF and World Bank to stabilise currencies and help rebuild after the Second World War.$mq$),
($mq$GATT and WTO$mq$, $mq$GATT (1947) cut tariffs between countries. The WTO replaced it in 1995 and can settle trade disputes.$mq$),
($mq$Tariff$mq$, $mq$A tax on imported goods, used to protect home industries by making imports more expensive.$mq$),
($mq$Protectionism vs free trade$mq$, $mq$Protectionism uses tariffs, quotas and subsidies to shield local firms. Free trade removes barriers.$mq$),
($mq$European Union$mq$, $mq$Began as the EEC (Treaty of Rome, 1957). Became the EU under the Maastricht Treaty (in force 1993). Euro notes and coins from 2002.$mq$),
($mq$NAFTA$mq$, $mq$Free trade area of the USA, Canada and Mexico from 1994. Replaced by the USMCA in 2020.$mq$),
($mq$Containerisation$mq$, $mq$Standard shipping containers (first voyage 1956) made moving goods far cheaper and faster, boosting world trade.$mq$),
($mq$Transnational corporation$mq$, $mq$A company operating in several countries, locating production where costs are lowest.$mq$),
($mq$Rana Plaza (2013)$mq$, $mq$Factory building collapse in Bangladesh killing more than 1,100 workers, raising questions about global brands and safe working conditions.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Post-1945 Globalisation and Institutions$mq$ and p.name = $mq$Globalisation and Trade$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$After the Second World War, leaders wanted to avoid the economic problems that had followed the First World War, such as the Great Depression and trade barriers. They created institutions to cooperate on trade and finance, and world trade then grew rapidly. Technology and politics speeded this up.

## Institutions
In 1944 the Bretton Woods conference in the USA set up the **International Monetary Fund** (IMF) and the **World Bank** to stabilise currencies and fund rebuilding and development. In 1947 countries signed the General Agreement on Tariffs and Trade (**GATT**), which cut tariffs. In 1995 the **World Trade Organization** (WTO) replaced it and gained powers to settle trade disputes. China joined the WTO in 2001.

Regional groups also grew. The Treaty of Rome (1957) set up the European Economic Community, which developed into the **European Union** under the Maastricht Treaty (in force 1993); euro notes and coins appeared in 2002. NAFTA (1994) created a free trade area between the USA, Canada and Mexico and was replaced by the USMCA in 2020. ASEAN, formed in 1967, links Southeast Asian countries.

## Drivers of globalisation
- **Technology**: container ships (from 1956), jet travel, satellites and the internet.
- **Politics**: the end of the Cold War in 1991 opened new markets, and countries such as China (from 1978) reformed their economies.
- **Transnational corporations**: firms such as car makers and phone companies produce in many countries to lower costs and sell worldwide.

## Effects
Advantages include cheaper goods, more choice, economic growth, jobs and the spread of ideas. The 'Asian Tigers' (South Korea, Taiwan, Hong Kong and Singapore) grew quickly through exports. China's growth lifted hundreds of millions of people out of poverty.

Disadvantages include job losses in industries that cannot compete, low wages and unsafe conditions in some factories (the 2013 Rana Plaza collapse in Bangladesh killed more than 1,100 people), growing inequality, pollution and the loss of local cultures. Global supply chains can also be fragile, as COVID-19 showed.

## Free trade versus protectionism
Supporters of **free trade** want few barriers. Supporters of **protectionism** use tariffs (taxes on imports), quotas (limits on amounts) and subsidies (state help for local firms) to protect jobs. In 2018 the USA and China raised tariffs on each other's goods in a trade dispute.

## How this is examined
You could receive data, such as the growth of world trade or the location of a company's factories, and be asked to describe the trend, explain causes and evaluate the effects on different groups. Use clear command-term responses: describe what the data shows, explain why, then evaluate with evidence and a judgement.

Exam tip: Name specific institutions and dates (for example IMF 1944, WTO 1995) and always say who gains and who loses.$mq$ from st;

-- Globalisation and Trade > Aid, Migration and Global Flows
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Globalisation and Trade$mq$, 5, 2 from public.subjects s where s.slug = $mq$history$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Aid, Migration and Global Flows$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$history$mq$ and p.grade = 5 and p.name = $mq$Globalisation and Trade$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Aid, Migration and Global Flows$mq$ and p.name = $mq$Globalisation and Trade$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What was the Marshall Plan?$mq$, $mq$["American aid to help rebuild Western European economies after the Second World War","A plan to build the Berlin Wall","A trade agreement in Asia","A treaty ending the First World War"]$mq$, 0, $mq$From 1948 the USA gave about 13 billion dollars to Western Europe. It also aimed to stop the spread of communism.$mq$, $mq$easy$mq$),
($mq$What is a refugee?$mq$, $mq$["Any person on holiday abroad","Anyone moving for a better job","A tourist","A person who flees their country because of a well-founded fear of persecution"]$mq$, 3, $mq$The 1951 Refugee Convention defines refugees. Economic migrants move for work and are different in law.$mq$, $mq$easy$mq$),
($mq$Which word describes aid given quickly after an earthquake or flood?$mq$, $mq$["Tied aid","Development loans","Emergency (humanitarian) aid","Tariff relief"]$mq$, 2, $mq$Emergency aid covers food, shelter and medicine in a crisis. Long-term aid builds schools or infrastructure.$mq$, $mq$easy$mq$),
($mq$Which of these is a 'push factor' for migration?$mq$, $mq$["Higher wages abroad","War or lack of jobs in the home area","Better schools abroad","Safer cities abroad"]$mq$, 1, $mq$Push factors drive people away from where they live. The other options are pull factors that attract migrants.$mq$, $mq$easy$mq$),
($mq$What are remittances?$mq$, $mq$["Money that migrants send home to family","Taxes on imports","Loans from the IMF","Gifts to governments"]$mq$, 0, $mq$Remittances are a major source of income in many developing countries and can exceed aid.$mq$, $mq$easy$mq$),
($mq$The ship HMT Empire Windrush arrived in Britain in June 1948. Who was on board?$mq$, $mq$["Soldiers returning from Korea","Refugees from Syria","Emigrants to Canada","Passengers from the Caribbean invited to work and settle in Britain"]$mq$, 3, $mq$People from Caribbean colonies, many wanting work, travelled to Britain, which needed labour after the war. They became known as the Windrush generation.$mq$, $mq$medium$mq$),
($mq$Which of the following is an example of tied aid?$mq$, $mq$["Money given freely with no conditions","Food sent after a flood","A donor country gives money but requires the receiving country to buy goods from the donor","Debts cancelled completely"]$mq$, 2, $mq$Tied aid benefits the donor as well. Critics say it can reduce the value of aid for the receiver.$mq$, $mq$medium$mq$),
($mq$A country's doctors and engineers move abroad to earn more. What is this called, and what is its effect?$mq$, $mq$["Brain gain, which helps the home country only","Brain drain, which can leave the home country short of skilled workers","Tied aid, which lowers prices","Protectionism, which stops migration"]$mq$, 1, $mq$Brain drain can harm health and education systems at home, although remittances may partly offset the loss.$mq$, $mq$medium$mq$),
($mq$In 1947 the partition of British India led to what consequence?$mq$, $mq$["Mass migration of millions of people between India and Pakistan","The creation of the EU","The start of the Marshall Plan","Independence for Australia"]$mq$, 0, $mq$Millions of Hindus, Muslims and Sikhs crossed new borders, and there was violence. Estimates of those displaced are around 10 to 15 million.$mq$, $mq$medium$mq$),
($mq$Which organisation, founded in 1950, helps protect refugees worldwide?$mq$, $mq$["The IMF","The WTO","NATO","UNHCR"]$mq$, 3, $mq$The United Nations High Commissioner for Refugees works with governments and NGOs to protect and support refugees.$mq$, $mq$medium$mq$),
($mq$Which of these is a strength of non-governmental organisations (NGOs) such as Oxfam in giving aid?$mq$, $mq$["They have unlimited funds","They make laws","They can work directly with communities and often respond quickly","They control borders"]$mq$, 2, $mq$NGOs rely on donations and have limited resources, but can reach local people. Governments and the UN provide larger funding.$mq$, $mq$medium$mq$),
($mq$The UN set a target of donating 0.7 per cent of national income as aid. What does '0.7 per cent of GNI' mean for a country with GNI of 2,000 billion dollars?$mq$, $mq$["7 billion dollars","14 billion dollars","140 billion dollars","1.4 billion dollars"]$mq$, 1, $mq$0.7% of 2,000 billion = 0.007 × 2,000 = 14 billion dollars.$mq$, $mq$medium$mq$),
($mq$Since the 1950s, workers from Turkey and Southern Europe were recruited to West Germany. What were they often called?$mq$, $mq$["Guest workers (Gastarbeiter)","Refugees","Settlers","Colonists"]$mq$, 0, $mq$West Germany needed labour for its post-war economic boom and made agreements with other countries. Many workers stayed permanently.$mq$, $mq$medium$mq$),
($mq$Evaluate: 'Aid is the best way to help poor countries.' Which response is most balanced?$mq$, $mq$["Aid always works","Aid never works","Aid is irrelevant","Aid can save lives and fund development, but can create dependency, corruption or serve the donor's interests, so it works best with trade and good governance"]$mq$, 3, $mq$Strong answers weigh benefits and problems and consider alternatives like fair trade and debt relief.$mq$, $mq$hard$mq$),
($mq$Which factor best explains why the number of displaced people rose sharply after 2011 in the Middle East?$mq$, $mq$["The creation of the WTO","The Marshall Plan","The Syrian civil war forced millions to flee","The opening of the Suez Canal"]$mq$, 2, $mq$More than 6 million Syrians left the country, many to Turkey, Lebanon, Jordan and Europe, and millions more were displaced inside Syria.$mq$, $mq$hard$mq$),
($mq$Which statement about migration and receiving countries is the most accurate?$mq$, $mq$["Migrants never work","Migrants often fill labour shortages and contribute taxes, though rapid change can cause pressure on housing and services in some areas","Migration has no economic effect","Migration only causes problems"]$mq$, 1, $mq$Effects differ by place and time. A balanced answer considers both benefits and pressures and avoids generalisations.$mq$, $mq$hard$mq$),
($mq$Muhammad Yunus's Grameen Bank gave small loans to poor people, mostly women, in Bangladesh. Which describes this approach?$mq$, $mq$["Microfinance, which aims to help people start small businesses","Tied aid","Emergency aid","Protectionism"]$mq$, 0, $mq$Microfinance gives access to credit for those excluded from banks. Supporters point to success stories; critics note that debt can become a burden.$mq$, $mq$hard$mq$),
($mq$Which of the following is the best example of a 'global flow' other than goods?$mq$, $mq$["A local market sale","A walk to school","A family dinner","The movement of data and money across borders by the internet"]$mq$, 3, $mq$Globalisation includes flows of people, money, data, ideas and disease as well as goods.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Aid, Migration and Global Flows$mq$ and p.name = $mq$Globalisation and Trade$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Marshall Plan$mq$, $mq$US aid of about 13 billion dollars (1948-52) to rebuild Western Europe after the Second World War and limit the appeal of communism.$mq$),
($mq$Tied aid$mq$, $mq$Aid given on condition that the receiving country spends it on goods or services from the donor.$mq$),
($mq$Humanitarian vs development aid$mq$, $mq$Humanitarian aid responds quickly to emergencies. Development aid supports long-term projects such as schools and clean water.$mq$),
($mq$Push and pull factors$mq$, $mq$Push: reasons to leave, such as war or poverty. Pull: reasons to move to a place, such as jobs, safety or education.$mq$),
($mq$Refugee$mq$, $mq$A person outside their country who has a well-founded fear of persecution (1951 Refugee Convention). Not the same as an economic migrant.$mq$),
($mq$Remittances$mq$, $mq$Money migrants send home to their families. A major income for many developing countries.$mq$),
($mq$Brain drain$mq$, $mq$Skilled workers such as doctors leaving their country for better pay, leaving gaps in the home country.$mq$),
($mq$Partition of India (1947)$mq$, $mq$Division of British India into India and Pakistan, causing mass migration of about 10 to 15 million people and violence.$mq$),
($mq$Windrush (1948)$mq$, $mq$HMT Empire Windrush brought Caribbean passengers to Britain in June 1948, helping to fill post-war labour shortages.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$history$mq$ and t.grade = 5 and t.name = $mq$Aid, Migration and Global Flows$mq$ and p.name = $mq$Globalisation and Trade$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Globalisation involves flows of goods, money, people, ideas and information. This sub-topic looks at three important flows: aid from richer to poorer countries, the movement of people (migration) and wider global connections.

## Aid
**Aid** is help given from one country, organisation or person to another. After the Second World War, the USA gave about 13 billion dollars in the **Marshall Plan** (1948-52) to rebuild Western Europe. The aim was to help economies recover and to reduce the appeal of communism.

Types of aid:
- **Emergency (humanitarian) aid**: food, shelter and medicines after disasters or war.
- **Development aid**: long-term projects such as schools, clinics or clean water.
- **Bilateral aid**: from one government to another. **Multilateral aid**: through organisations like the UN or World Bank.
- **Tied aid**: given on condition that the money is spent on the donor's goods or services.
- **NGOs** such as Oxfam or the Red Cross raise money from the public and work directly with communities.

In 1970 the UN set a target for rich countries to give 0.7 per cent of national income as aid; few countries meet it. Aid can save lives, but it can also create dependency, be wasted through corruption or serve the donor's interests. Other approaches include debt relief, fair trade and microfinance. The Grameen Bank, begun by Muhammad Yunus in Bangladesh, gives small loans to poor people to start businesses.

## Migration
Migration is the movement of people from one place to another. People move because of **push factors** (war, poverty, lack of jobs, natural disasters) and **pull factors** (jobs, safety, family, education). A **refugee** flees because of a well-founded fear of persecution, as defined in the 1951 Refugee Convention. UNHCR, founded in 1950, protects refugees. **Internally displaced people** flee but stay inside their country. **Economic migrants** move to find work.

Important examples include partition of British India in 1947, which saw millions move between India and Pakistan; the arrival of the Windrush passengers from the Caribbean in 1948; guest workers recruited to West Germany from the 1950s; and the Syrian civil war from 2011, which displaced millions.

Effects: migrants may fill labour shortages, pay taxes and bring skills and culture. Their home countries can gain from **remittances** (money sent home) but may suffer **brain drain** if skilled workers leave. Receiving areas can feel pressure on housing and services.

## Other global flows
Money moves instantly between banks, data crosses borders online, ideas and trends spread through media and social networks, and diseases travel with people and trade. This connectivity brings opportunity but also risk.

## How this is examined
Tasks may give a short source, such as a statistic on refugee numbers or the description of an aid project, and ask you to explain the causes, assess the usefulness of the source, and evaluate the effects on different groups. State the origin and purpose of a source, support points with examples and reach a balanced judgement.

Exam tip: When asked to evaluate aid or migration, give at least one benefit and one problem, and explain which is stronger and why.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('history')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;