begin;
-- History MYP 5 eAssessment Structure Mock A (7 tasks, 76 marks) (76 marks)
with sub as (select id from public.subjects where slug = $mq$history$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$History MYP 5 eAssessment Structure Mock A (7 tasks, 76 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$History MYP 5 eAssessment Structure Mock A (7 tasks, 76 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: Industrialization in Britain. This task focuses on the key concept of change.

Source A: a timeline of selected developments (compiled for this paper)
1733: John Kay patents the flying shuttle, a device that makes weaving faster.
c. 1764: James Hargreaves invents the spinning jenny.
1769: Richard Arkwright patents the water frame. In the same year James Watt patents his separate condenser, which makes the steam engine far more efficient.
1779: Samuel Crompton completes the spinning mule.
1785: Edmund Cartwright patents a power loom.
1830: The Liverpool and Manchester Railway opens.

(a) State two inventions from Source A that were used to make cotton thread or cloth before 1800. (2 marks)

(b) Show that 66 years separate the invention of the spinning jenny from the opening of the Liverpool and Manchester Railway. (1 mark)

(c) Describe one way in which Arkwright's water frame changed where or how cotton was spun. (2 marks)

(d) Explain why steam power allowed factories to be built in places far from fast-flowing rivers. (3 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] [1] Any two from: flying shuttle; spinning jenny; water frame; spinning mule; power loom. Do not accept the separate condenser or the railway.
(b) [1] 1830 - 1764 = 66 years (must show the subtraction).
(c) [1] A valid change, e.g. the machine was large and driven by a water wheel, so spinning moved out of cottages into mills built beside fast-flowing rivers (such as Cromford in Derbyshire); or it spun strong, hard thread suitable for the warp of cloth.
[1] Developed with detail, e.g. workers had to come to the machine and work set hours under one roof, an early form of the factory system; or thread became cheaper and more plentiful.
(d) [1] Water wheels needed a strong, steady flow of water, so mills had to be sited on fast rivers or streams.
[1] Steam engines burned coal to make power, so a factory could be built anywhere coal could be delivered.
[1] Canals and later railways carried coal cheaply, so factories could be built in towns close to workers, markets or ports; or Watt's condenser made engines efficient enough to be worth buying.
Accept other accurate, developed explanations.$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 3 | B 7]]
Task 2: Growth of a mill town. This task focuses on the key concept of change and the global context of orientation in space and time.

Ashbury is an invented mill town. The figures and descriptions below were created for this paper to illustrate typical patterns of the period. They are not real statistics.

Source B: population of Ashbury
Year: 1801, 1821, 1841, 1861
Population: 6,200; 14,800; 31,500; 52,300

Source C: average age at death in Ashbury, 1841
Professionals and gentry: 41 years
Shopkeepers and tradesmen: 27 years
Mill workers and labourers: 19 years

Source D: a description of an engraving of Ashbury's mill district, 1845 (imagined, written for this paper)
[Description: Rows of back-to-back houses crowd round narrow courts. Each court has one water pump and two shared privies for about forty people. An open drain runs down the middle of the court. Smoke from tall mill chimneys hangs over the roofs, and washing is strung between upper windows.]

(a) Calculate the increase in the population of Ashbury between 1801 and 1861. (1 mark)

(b) Calculate the percentage increase in the population of Ashbury between 1821 and 1841. Give your answer to one decimal place. (2 marks)

(c) Describe one trend shown in Source B and suggest one reason for it. (2 marks)

(d) Explain how living conditions like those in Source D could help to explain the figures in Source C. (3 marks)

(e) State one limitation of using Sources B and C alone to judge how most people lived in industrial Britain, and explain why it is a limitation. (2 marks)

Total for Question 2: 10 marks$mq$, $mq$(a) [1] 52,300 - 6,200 = 46,100.
(b) [1] Method: (31,500 - 14,800) / 14,800 x 100 (or 16,700 / 14,800).
[1] 112.8% (accept 113% only if working shows 112.8).
(c) [1] A valid trend, e.g. the population grew rapidly and continuously; the increase was larger in each period (8,600 then 16,700 then 20,800); the population was more than eight times larger in 1861 than in 1801.
[1] A valid reason, e.g. people moved from the countryside to find work in the mills; large families and a falling death rate in the early period.
(d) [1] Houses were overcrowded and shared one pump and privies, so there was little clean water or sanitation.
[1] Open drains and shared pumps spread water-borne diseases such as cholera, typhoid and dysentery; smoke and damp caused lung disease.
[1] Mill workers and labourers lived in these courts while wealthier groups could afford better, cleaner housing, which explains why their average age at death (19) was much lower than that of professionals (41).
(e) [1] A valid limitation, e.g. the sources cover only one (invented) town, so it may not be typical; the average age at death is lowered by high infant mortality and does not show how long adults lived; the sources give no information about wages, hours or work conditions; the sources are not from workers themselves.
[1] A clear explanation of why this limits their use.
Accept other valid limitations.$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | A 4 | B 6]]
Task 3: The Montgomery bus boycott. This task focuses on the key concept of perspective and the global context of fairness and development.

In 1955 city buses in Montgomery, Alabama, were segregated by law. On Thursday 1 December 1955 a Black woman, Rosa Parks, was arrested for refusing to give up her seat to a white passenger. The boycott of the buses began on Monday 5 December 1955 and lasted 381 days.

Source A: a leaflet distributed in Montgomery in December 1955 (written for this paper)
A woman of our city was arrested last Thursday evening because she would not give up her seat on a city bus to a white passenger. She has been fined and her case will be heard in court. Every one of us has stood on those buses while seats stayed empty. On Monday, do not ride. Share a car, take a taxi that charges the bus fare, or walk. Come to the meeting on Monday evening at the church to decide what we do next. The buses cannot run without us.

Source B: part of a statement by a bus company manager, December 1956 (an imagined person, written for this paper)
Since the protest began our buses have carried only a fraction of the usual number of passengers, because most of our regular customers have stayed away. Our income has fallen sharply. We have raised fares, cut services and laid off drivers, and the company cannot continue like this. The court order leaves us no choice but to change our seating rules.

(a) Identify two ways in which the bus system in Montgomery in 1955 discriminated against Black passengers. (2 marks)

(b) Explain one way in which legal action, as well as the boycott, helped to end segregation on Montgomery's buses. (2 marks)

(c) Assess the value and limitations of Source A for a historian studying how the Montgomery bus boycott was organised. Refer to the origin, purpose and content of the source. (4 marks)

(d) Explain how far Source B supports the view that economic pressure was the main reason segregation on Montgomery's buses ended. (2 marks)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] [1] Any two from: Black passengers had to sit in the back rows while front seats were reserved for white passengers; Black passengers could be ordered to give up seats if the white section filled; Black passengers had to pay at the front and then re-board through the rear door; drivers had the power to enforce segregation and Black passengers could be arrested for refusing. Accept other accurate details.
(b) [1] A court case was brought: in Browder v. Gayle a federal court ruled in 1956 that segregated buses were unconstitutional, and the United States Supreme Court upheld the ruling on 13 November 1956.
[1] The order came into force in December 1956 and the city had to desegregate its buses, ending the boycott. (Accept: legal action showed that segregation itself was unlawful, not merely unpopular.)
(c) [1] Origin: a leaflet produced by supporters of the boycott within days of the arrest (December 1955).
[1] Purpose: to persuade Black residents to stay off the buses on the first Monday and to attend a mass meeting.
[1] Value: shows how the protest was organised in practice (fast leafleting, alternatives such as car sharing and taxis, a mass meeting) and how the arrest was used to unite people.
[1] Limitation: it is a call to action, so it shows plans and hopes, not how many people actually took part; it is one-sided and gives no information about leadership, finance or the white authorities' response.
(d) [1] Supports: the manager says the loss of passengers, falling income, higher fares and layoffs meant the company could not continue.
[1] Limits: the manager also says the court order forced the change, so the legal ruling was decisive too; a company manager may exaggerate the damage, and the source cannot show which factor mattered more. Award this mark for a reasoned judgement.$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | A 2 | B 4 | C 2 | D 4]]
Task 4: The Treaty of Versailles. This task focuses on the key concept of perspective and the global context of fairness and development.

The Treaty of Versailles was signed on 28 June 1919. Germany was required to accept responsibility for causing the First World War, to pay reparations, to lose territory and to disarm.

Source C: from an editorial in an imagined German newspaper, June 1919 (written for this paper)
This so-called peace is a sentence passed on a defeated people without a hearing. Our delegates were not allowed to negotiate; they were handed the terms and told to sign. We are made to confess sole guilt for the war, to hand over land to our neighbours, to cut our army to a shadow, and to pay a bill that no one has even named. How can a people that has lost its sons, its colonies and its pride rebuild under such a burden? Such a peace will breed only bitterness.

Source D: from a private letter by an imagined British civil servant, July 1919 (written for this paper)
I have read the treaty through twice. It is hard on Germany, and in places harder than it should be; I fear that the reparations clause may cause trouble for years. And yet I cannot call it cruel. Germany keeps her unity, her industry and her place in Europe, and the French wanted far more than they got. Germany began this war and invaded Belgium, and some price had to be paid. The real question is whether the peace will be enforced by those who made it.

(a) State two terms of the Treaty of Versailles that limited Germany's military power. (2 marks)

(b) Compare and contrast the views of Source C and Source D about the Treaty of Versailles. (4 marks)

(c) 'The Treaty of Versailles was too harsh on Germany.' Evaluate this claim using Sources C and D and your own knowledge. Structure your answer clearly and use historical terms accurately. (6 marks)

Total for Question 4: 12 marks$mq$, $mq$(a) [1] [1] Any two from: army limited to 100,000 men; conscription banned; no tanks, heavy artillery, military aircraft or submarines; navy limited (for example six battleships); the Rhineland was demilitarised.
(b) [1] Similarity: both agree that the treaty is hard on Germany / that the reparations are a danger (Source D: 'hard on Germany', 'reparations clause may cause trouble'; Source C: 'a bill that no one has even named').
[1] Similarity, second point or developed: both suggest it may cause future problems (bitterness / trouble for years).
[1] Difference: Source C sees the treaty as unjust and imposed, while Source D thinks it is not cruel and that some penalty was deserved.
[1] Difference developed with evidence: Source C rejects the war-guilt clause ('sole guilt'), while Source D says Germany began the war and invaded Belgium; or Source D notes Germany kept its unity and industry and France wanted more, while Source C stresses loss of land, colonies and army.
(c) Criterion D (4 marks) [4]: 1 mark for a limited judgement from one side only; 2 marks for arguments on both sides with some use of sources; 3 marks for balanced, developed evaluation using both sources and accurate own knowledge; 4 marks for a clear, supported overall judgement that weighs the evidence (including provenance, such as the German editorial's strong political purpose against the private letter's more candid tone).
Indicative content, harsh: war-guilt clause (Article 231); Germany lost about 13 percent of its territory and all its colonies; Alsace-Lorraine returned to France; reparations (fixed in 1921 at 132 billion gold marks); army cut to 100,000; the Diktat (no negotiation); Germany excluded from the League of Nations at first.
Indicative content, not too harsh: Germany remained united and a large industrial power; Treaty of Brest-Litovsk (1918) was harsher on Russia; France had suffered heavy devastation; the Allies had wanted more (for example Foch and the Rhineland); reparations were later reduced (Dawes Plan 1924, Young Plan 1929).
Criterion C (2 marks) [2]: 1 mark for a mostly organised answer with some accurate historical terms; 2 marks for a clearly structured response (introduction or claim, developed paragraphs, conclusion) with accurate historical terminology and clear reference to sources.$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | A 3 | B 3 | D 4]]
Task 5: The eradication of smallpox. This task focuses on the key concept of change and the global context of globalization and sustainability.

Smallpox was a deadly viral disease. The World Health Organization (WHO) began an intensified worldwide eradication programme in 1967, and in 1980 it declared that smallpox had been eradicated.

Source E: part of a field report by a smallpox team leader, 1970s (imagined, written for this paper)
Our team does not try to vaccinate everyone in the district. When a case is reported we visit the village the same day, isolate the patient, and vaccinate the household, everyone who has been in contact with them, and the neighbouring houses. We then search the nearby markets and paths for anyone who may have met the patient. We pay a small reward to people who report cases. The vaccine arrives in a freeze-dried form that stays usable without a refrigerator, which allows us to reach remote villages. Some families still hide their sick because they fear the authorities.

(a) Describe how Edward Jenner developed the first smallpox vaccination. (3 marks)

(b) Explain the value and one limitation of Source E for a historian studying how smallpox was eradicated. (3 marks)

(c) Analyse why smallpox could be eradicated worldwide, while diseases such as malaria have not been. (4 marks)

Total for Question 5: 10 marks$mq$, $mq$(a) [1] Jenner noticed that milkmaids who had caught cowpox seemed not to catch smallpox.
[1] In 1796 he took matter from a cowpox sore on a milkmaid's hand and inoculated a boy, James Phipps.
[1] He later exposed the boy to smallpox and the boy did not become ill; Jenner published his findings in 1798. Accept any three accurate, distinct points.
(b) [1] Value (origin): a first-hand report by someone who worked in the field, so it gives practical insight into methods.
[1] Value (content): it explains the strategy of surveillance and containment (ring vaccination), rewards for reporting cases and the freeze-dried vaccine, which were key to eradication.
[1] Limitation: it covers one team in one district, so it may not be typical; as a report to superiors it may present the work positively; it gives little on global co-ordination by the WHO.
(c) [1] Smallpox had no animal reservoir; it infected only humans, so breaking the chain of transmission could end it. Malaria is carried by Anopheles mosquitoes and the parasite also lives in people who show no symptoms.
[1] Smallpox cases were easy to recognise (a distinct rash), so outbreaks could be found and contained; malaria symptoms resemble other fevers.
[1] There was an effective, cheap, stable vaccine giving long protection, which could be freeze-dried; there has been no similarly effective vaccine for malaria and the parasite changes its form.
[1] Infected people did not stay infectious for long and survivors were immune, and international co-operation and funding were sustained over many years; malaria is widespread in poorer tropical regions where health systems are weaker and the mosquito breeds in many places.
Accept other valid, developed reasons.$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | A 3 | B 4 | D 3]]
Task 6: The Salt March. This task focuses on the key concept of perspective and the global context of identity and relationships.

In March 1930 Mohandas Gandhi led a march from his ashram near Ahmedabad to the coast at Dandi to protest against the British salt laws in India.

Source F: a cartoon in an imagined British newspaper, 1930 (written for this paper)
[Description: A thin, barefoot man with a staff and a loincloth walks along a dusty road with a small line of followers. By the roadside a large, well-dressed figure labelled 'Government' sits in a deckchair and smiles, holding a tiny pinch of salt between finger and thumb. The caption reads: 'A great deal of walking for a very small pinch.']

Source G: an account by a marcher, written later (imagined, written for this paper)
We walked for 24 days and covered about 240 miles, rising before dawn and resting in the heat of the day. In every village crowds waited with water and flowers, and the leader spoke to them about the salt tax. On the last morning we reached the sea at Dandi. On 6 April he lifted a lump of natural salt from the mud, and by doing so broke the law. Within weeks thousands of people along the coast were making salt, and many were arrested.

(a) Show that the marchers in Source G averaged 10 miles per day. (1 mark)

(b) Explain why Gandhi chose the salt tax as the target of the 1930 campaign. (3 marks)

(c) Interpret the message of Source F. In your answer, refer to its origin and purpose. (3 marks)

(d) Suggest two factors, other than Gandhi's campaigns, that helped India to achieve independence in 1947. Support each with a detail. (3 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) [1] 240 / 24 = 10 miles per day (working must be shown).
(b) [1] Salt was used by everyone, rich or poor, so the issue touched every Indian household.
[1] The British government held a monopoly on salt production and taxed it, so the tax was unjust and hit the poorest hardest.
[1] Making salt from sea water was a simple, non-violent way of breaking an unjust law that anyone could copy, which supported Gandhi's strategy of civil disobedience and could attract international attention.
(c) [1] Message: the cartoon belittles the march, suggesting it is a great effort for a trivial result and that the government is not worried.
[1] Origin: a British newspaper cartoon of 1930, probably reflecting a view that supported British rule.
[1] Purpose: to mock the protest and reassure readers that the authorities were in control; the exaggerated contrast between the confident official and the thin walker is intended to make the protest look foolish. (Source G and later events suggest the government was in fact challenged.)
(d) [1] [1] Two valid factors, one mark each, from: the Second World War weakened Britain economically and militarily; the Quit India Movement of 1942 and continuing unrest; the election of the Labour government in 1945, which was more willing to grant independence; trials of Indian National Army officers and mutinies in the armed forces in 1946, which made Britain doubt Indian loyalty; the Muslim League's demand for Pakistan and communal violence, which pushed Britain to leave by a set date.
[1] A relevant, accurate supporting detail for at least one factor (for example the date or event named).$mq$, $mq$B$mq$),
(7, $mq$[[Q 7 | A 5 | C 5 | D 6]]
Task 7: The Cuban Missile Crisis. This task focuses on the key concept of consequences and the global context of orientation in space and time.

Source H: timeline of events (compiled for this paper)
14 October 1962: A United States U-2 reconnaissance plane photographs missile sites being built in Cuba.
22 October: The American President announces a naval 'quarantine' of Cuba and demands that the missiles be removed.
24 October: Soviet ships heading for Cuba approach the quarantine line, and some stop or turn back.
27 October: A United States reconnaissance plane is shot down over Cuba and its pilot is killed.
28 October: The Soviet leader announces that the missiles will be removed.
April 1963: United States missiles in Turkey are quietly withdrawn, as part of a private understanding.
June 1963: An agreement sets up a direct telephone link between Moscow and Washington.
August 1963: The Partial Test Ban Treaty is signed.

Source I: from the diary of an imagined student in a United States coastal city, 26 October 1962 (written for this paper)
Nobody at school talked about anything else today. Our teacher drew a map showing how far a missile from Cuba could travel, and she said that we are inside the circle. We practised getting under our desks. At home my father stacked tins of food in the cellar. I tried to look brave for my little brother, but I could not eat my dinner.

Source J: from the memoir of an imagined Soviet sailor, written many years later (written for this paper)
We were told only that we were carrying equipment to help Cuba defend itself. When the order came to turn back I was relieved, though some officers were angry. We did not understand until later how close it had been, and that decisions were being made in Moscow and Washington in a few hours rather than days. Afterwards our leaders seemed more careful.

Evaluate the extent to which the Cuban Missile Crisis made the world a safer place. In your answer, use Sources H, I and J and your own knowledge. Reach a clear judgement. (16 marks)

Total for Question 7: 16 marks$mq$, $mq$Criterion A, knowledge and understanding [5]: 0 marks for no relevant knowledge. 1-2 marks for limited, general or partly inaccurate knowledge (for example that there was a crisis over missiles in Cuba). 3-4 marks for mostly accurate, relevant knowledge of causes, events and consequences with some detail. 5 marks for accurate, detailed and well-selected knowledge of the crisis and its consequences, beyond what is given in the sources.
Criterion D, thinking critically [6]: 0 marks for no relevant argument. 1-2 marks for a one-sided or descriptive response, with a limited judgement. 3-4 marks for an argument that considers both sides and uses the sources, with some evaluation of their reliability or perspective. 5-6 marks for a balanced, well-supported evaluation that weighs the evidence (including source origin, purpose and perspective), considers alternative interpretations and reaches a clear, justified overall judgement.
Criterion C, communicating [5]: 0 marks for no organisation. 1-2 marks for a basic structure with limited use of historical terms. 3-4 marks for a clear structure, fluent writing, accurate terminology and references to sources. 5 marks for a well-organised, coherent and precise argument, with an introduction, developed paragraphs, a conclusion and consistently accurate historical language.
Indicative content, safer: both superpowers had come close to nuclear war and became more cautious (Source J: 'our leaders seemed more careful'); the hotline (June 1963) allowed direct communication; the Partial Test Ban Treaty (August 1963) ended atmospheric testing by the signatories; later arms-control talks such as the Strategic Arms Limitation Talks and the Nuclear Non-Proliferation Treaty (1968) followed; the crisis ended without war through negotiation and a face-saving compromise, including the private withdrawal of missiles from Turkey (Source H).
Indicative content, not safer: the nuclear arms race accelerated, because the Soviet Union determined never again to be seen as weaker and expanded its arsenal; the Cold War continued (Vietnam, Berlin, proxy wars); ordinary people still lived under threat (Source I); the near-misses on 27 October (the shot-down plane) showed how easily accidents could trigger war; the Soviet leader was removed in 1964, partly because of the humiliation; France left NATO's integrated command in 1966.
Evaluation of sources: Source I is a contemporary diary which shows fear, but it is one person's view and written by a schoolchild; Source J is a later memoir, so it benefits from hindsight but may be shaped by later knowledge; Source H is a factual timeline but gives no sense of how people felt or what was said in private.
Award credit for a reasoned judgement, for example that the crisis made the world safer in the short term through better communication and arms control, but did not remove the underlying rivalry.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- History MYP 5 eAssessment Structure Mock B (7 tasks, 76 marks) (76 marks)
with sub as (select id from public.subjects where slug = $mq$history$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$History MYP 5 eAssessment Structure Mock B (7 tasks, 76 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$History MYP 5 eAssessment Structure Mock B (7 tasks, 76 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: The campaign for votes for women in Britain. This task focuses on the key concept of change.

Source A: a timeline of selected events (compiled for this paper)
1897: The National Union of Women's Suffrage Societies (NUWSS) is formed under the leadership of Millicent Fawcett.
1903: Emmeline Pankhurst founds the Women's Social and Political Union (WSPU).
June 1913: Emily Wilding Davison is fatally injured at the Epsom Derby.
1914 to 1918: The First World War.
1918: The Representation of the People Act gives the vote to women over 30 who meet a property qualification, and to all men over 21.
1928: The Equal Franchise Act gives the vote to women over 21.

(a) State the name of the organisation, founded in 1903, whose members became known as suffragettes. (1 mark)

(b) Show that ten years passed between the Representation of the People Act and the Equal Franchise Act. (1 mark)

(c) Describe how the methods of the NUWSS differed from the methods of the WSPU. (3 marks)

(d) Explain how the First World War helped women to win the vote in 1918. (3 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] The Women's Social and Political Union (WSPU). Accept 'WSPU'.
(b) [1] 1928 - 1918 = 10 years (working must be shown).
(c) [1] The NUWSS (suffragists) used peaceful, law-abiding methods such as petitions, meetings, lobbying MPs and marches.
[1] The WSPU (suffragettes) used militant tactics such as window-smashing, arson, chaining themselves to railings and disrupting meetings, and went on hunger strike when imprisoned.
[1] Developed comparison, e.g. the WSPU's motto 'Deeds not words' against the NUWSS's belief that persuasion would win the vote; or the WSPU's tactics risked public opposition while the NUWSS aimed to win support.
(d) [1] Women did essential war work in factories, munitions works, farms, transport and nursing, which showed that they could contribute to the nation.
[1] The suffragettes stopped their militant campaign and supported the war effort, improving their public image.
[1] Politicians accepted that it would be unfair to deny the vote to women who had served the country, and the franchise had to be reformed anyway so that soldiers who had been away from home could vote. Accept other accurate, developed points.$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 3 | B 7]]
Task 2: The Great Depression and the rise of the Nazi Party. This task focuses on the key concept of causation and the global context of globalization and sustainability.

Source B: unemployment in Germany (annual averages, rounded)
Year: 1928, 1929, 1930, 1931, 1932, 1933
Unemployed (millions): 1.4, 1.9, 3.0, 4.5, 5.6, 4.8

Source C: share of the vote won by the Nazi Party in Reichstag elections (rounded)
Election: May 1928, September 1930, July 1932, November 1932, March 1933
Share of the vote (%): 2.6, 18.3, 37.3, 33.1, 43.9

(a) Calculate the percentage increase in the number of unemployed Germans between 1928 and 1932. (2 marks)

(b) Calculate by how many percentage points the Nazi share of the vote rose between September 1930 and July 1932. (1 mark)

(c) Describe the relationship between unemployment and the Nazi share of the vote shown in Sources B and C. (2 marks)

(d) Explain two reasons, other than unemployment, why many Germans voted for the Nazi Party by 1932. (3 marks)

(e) Explain one limitation of Sources B and C for a historian who wants to prove that unemployment caused the rise in Nazi support. (2 marks)

Total for Question 2: 10 marks$mq$, $mq$(a) [1] Method: (5.6 - 1.4) / 1.4 x 100.
[1] 300%.
(b) [1] 37.3 - 18.3 = 19.0 percentage points.
(c) [1] Broadly positive: as unemployment rose from 1.4 million (1928) to 5.6 million (1932), the Nazi share of the vote rose from 2.6% to 37.3% (July 1932).
[1] But the relationship is not exact: the Nazi vote fell in November 1932 although unemployment stayed very high, and the vote rose again in March 1933 when unemployment (4.8 million) had begun to fall.
(d) [1] [1] [1] Two reasons, with at most 2 marks for identifying and 1 for development, from: resentment of the Treaty of Versailles and the 'stab in the back' myth; fear of communism, which many middle-class and business voters believed the Nazis would stop; Hitler's leadership and the Nazis' propaganda, rallies and promises of jobs and national pride; the weakness of the Weimar governments, which relied on rule by decree; the loss of savings in the hyperinflation of 1923 and the loss of confidence in democracy. Award one mark for each reason identified and a third mark for development of either.
(e) [1] A valid limitation, e.g. a correlation does not show cause; the data are national averages and do not show who voted for the Nazis or why; other factors changed at the same time; the March 1933 election took place after Hitler became Chancellor, in a climate of intimidation.
[1] A clear explanation of why this prevents a firm conclusion.$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | A 4 | B 6]]
Task 3: Appeasement and the Munich Agreement. This task focuses on the key concept of perspective and the global context of fairness and development.

In September 1938 the leaders of Britain, France, Germany and Italy met in Munich. They agreed that Germany would take the Sudetenland, a border region of Czechoslovakia where many people spoke German.

Source D: from an editorial in an imagined British newspaper, 1 October 1938 (written for this paper)
Across the country there is relief tonight. A war that many feared would begin within days has been avoided. The agreement reached in Munich gives Germany a district where most of the people are German-speaking, and in return the German leader has promised that he seeks no further territory in Europe. We would not ask the young men of Britain to march to war over a distant border region. Let us hope that this settlement will give Europe a long period of quiet.

Source E: from a letter by an imagined schoolteacher in Prague to her cousin abroad, October 1938 (written for this paper)
No one asked us. The decision about our country was made by four men in a room, and our own government was told to accept it. The border districts hold our mountain forts and many of our factories, so we are left almost defenceless. People here are numb and ashamed, and some are saying that our allies have abandoned us. I do not believe that the promises made will be kept.

(a) State two countries, other than Germany, whose leaders signed the Munich Agreement. (2 marks)

(b) Explain why the British government followed a policy of appeasement towards Germany in the 1930s. (2 marks)

(c) Assess the value and limitations of Source E for a historian studying reactions to the Munich Agreement. Refer to the origin, purpose and content of the source. (4 marks)

(d) Compare how Source D and Source E differ in their views of the Munich Agreement. (2 marks)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] [1] Any two from: Britain; France; Italy. (Czechoslovakia and the Soviet Union were not invited.)
(b) [1] [1] Any two developed reasons from: fear of another war so soon after 1914-18 and a strong public wish for peace; the cost of rearmament during the Depression; a belief that the Treaty of Versailles had treated Germany too harshly and that some German demands were reasonable; fear of communism, with Germany as a buffer against the Soviet Union; Britain was not yet ready for war. Award one mark for each reason, or one for a reason and one for development.
(c) [1] Origin: a private letter written in October 1938 by a Czech teacher, so it comes from someone directly affected, soon after the agreement.
[1] Purpose: a private message to a relative, likely to be candid rather than written for propaganda.
[1] Value: it shows how the agreement was received in Czechoslovakia (shame, feeling of betrayal, loss of forts and factories) and the exclusion of Czechoslovakia from the decision.
[1] Limitation: it is one person's view and may not represent all Czechs; the writer is not an official and may lack information about diplomatic detail; it gives no information about reaction in Britain, France or Germany; it was written before the events of March 1939 that proved her fears correct.
(d) [1] Source D welcomes the agreement as having avoided war and settled a reasonable claim, whereas Source E sees it as a betrayal imposed without consultation.
[1] Supported by evidence from both sources, e.g. D: 'relief', 'long period of quiet'; E: 'No one asked us', 'our allies have abandoned us'.$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | A 3 | B 4 | D 5]]
Task 4: Enlightenment ideas and the French Revolution. This task focuses on the key concept of change and the global context of fairness and development.

In August 1789 the National Assembly in France issued the Declaration of the Rights of Man and of the Citizen, which stated that men are born free and equal in rights.

Source F: from a pamphlet by an imagined woman writer in Paris, 1791 (written for this paper)
The Declaration promises that all are born free and equal in rights. Yet half the nation is left outside it. Women pay taxes, raise the citizens of the future, and are punished by the law, but they may not vote, hold office or sit on a jury. A liberty that stops at the door of half the population is not liberty. It is a privilege.

(a) Outline one idea of an Enlightenment thinker and explain how it challenged the power of an absolute monarch. (3 marks)

(b) Assess the value and limitations of Source F for a historian studying whether the ideals of the French Revolution applied to everyone. Refer to the origin, purpose and content of the source. (4 marks)

(c) 'Between 1789 and 1793 the French Revolution achieved liberty and equality for the people of France.' To what extent do you agree? (5 marks)

Total for Question 4: 12 marks$mq$, $mq$(a) [1] A named thinker and idea, e.g. Montesquieu (separation of powers), Rousseau (the general will and popular sovereignty), Locke (natural rights to life, liberty and property), Voltaire (freedom of speech and religious tolerance).
[1] An accurate outline of the idea.
[1] Explanation of how it challenged absolutism, e.g. power should be divided or limited rather than held by one king; government depends on the consent of the people; rights belong to all people by nature, not by the king's favour.
(b) [1] Origin: a pamphlet by a woman writer in Paris in 1791, two years after the Declaration, so she was a contemporary observer of the Revolution's ideals.
[1] Purpose: to argue publicly for women's political rights and to persuade readers that the Declaration was incomplete.
[1] Value: it shows that some people at the time noticed that the Declaration excluded women, and it sets out women's tax-paying and legal position.
[1] Limitation: it is a persuasive, one-sided pamphlet; it reflects the view of an educated minority and is not evidence of how most women felt; it says nothing about other excluded groups or about the later years of the Revolution.
(c) Criterion D [5]: 1 mark for a one-sided or descriptive answer; 2 marks for two supported points; 3 marks for points on both sides with accurate evidence; 4 marks for a developed, balanced evaluation; 5 marks for a balanced evaluation that reaches a clear, justified judgement about the extent.
Indicative content, agree: feudal privileges abolished on 4 August 1789; the Declaration of 1789 and the 1791 constitution gave equality before the law and ended the nobility's legal privileges; Jews were granted full citizenship in 1791; the monarchy was abolished and a republic proclaimed in September 1792; careers were opened to talent.
Indicative content, disagree: the 1791 constitution divided men into 'active' and 'passive' citizens by wealth, so many men could not vote; women were excluded (Source F); slavery continued in the colonies until 1794; the Law of Suspects (September 1793) and the Terror removed liberty for suspected opponents; Louis XVI was executed in January 1793 and the radical republicans suppressed their opponents.$mq$, $mq$D$mq$),
(5, $mq$[[Q 5 | A 4 | B 3 | D 3]]
Task 5: Independence for Ghana. This task focuses on the key concept of change and the global context of identity and relationships.

Source G: a description of a photograph taken in Accra on the night of 5 to 6 March 1957
[Description: A large crowd fills an open space after dark. Many people wear cloth in red, gold and green. Some are raising their arms; others hold flags with a black star in the centre. Floodlights light a platform in the background. At the front a woman holds a small child on her shoulders.]

(a) State the former name of the colony that became Ghana and the date on which Ghana became independent. (2 marks)

(b) Describe one method used by Kwame Nkrumah's Convention People's Party (CPP) in its struggle for independence. (2 marks)

(c) Explain the value of Source G for a historian studying what independence meant to ordinary people in Ghana. (3 marks)

(d) Explain why the British government was willing to grant independence to the Gold Coast in the 1950s. (3 marks)

Total for Question 5: 10 marks$mq$, $mq$(a) [1] The Gold Coast.
[1] 6 March 1957.
(b) [1] A valid method, e.g. 'Positive Action' in January 1950, a campaign of strikes, boycotts and non-violent protest; contesting elections (in 1951 the CPP won while Nkrumah was in prison); mass rallies; a party newspaper; appeals to ordinary people, including women and the young.
[1] Accurate detail or explanation of its effect, e.g. Nkrumah was released to become Leader of Government Business in 1951 and Prime Minister in 1952; the CPP's repeated election wins showed the strength of support, so independence could not be ignored.
(c) [1] The photograph is a visual record of the moment itself, so it shows the scale of the celebration and the public mood.
[1] It shows symbols of national identity (the red, gold and green colours and the black star), suggesting that independence was linked to pride and a new national identity.
[1] The presence of women and children suggests that independence mattered across the community, not only to political leaders. (A limitation, such as that a single photograph cannot show the views of those who opposed the CPP or stayed away, may earn the third mark if linked to value.)
(d) [1] Britain was weakened economically and militarily by the Second World War and could no longer afford to hold large colonies.
[1] Unrest, such as the riots in Accra in 1948, and the CPP's election victories showed that the colonial government could not rule against the wishes of the people.
[1] Britain had a policy of preparing colonies for self-government; the Gold Coast was relatively prosperous and had an educated elite, and the British hoped to keep Ghana as a friendly member of the Commonwealth and avoid a costly conflict. Accept other accurate, developed explanations.$mq$, $mq$A$mq$),
(6, $mq$[[Q 6 | A 2 | B 5 | D 3]]
Task 6: Cholera and public health. This task focuses on the key concept of causation and the global context of scientific and technical innovation.

Cholera outbreaks killed thousands of people in nineteenth-century British towns. Many doctors believed that disease was caused by 'miasma', or bad air.

Source H: a description of a map of an imagined town district during a cholera outbreak (written for this paper)
[Description: The map shows 44 deaths from cholera in one week, each marked with a black bar on the house. Three water pumps are marked: at Crown Street, at East Lane and at the church. Of the 44 deaths, 38 are within 100 metres of the Crown Street pump, 3 are near the East Lane pump and 3 are near the church pump. A factory with 70 workers, 200 metres from the Crown Street pump, has its own well and had no deaths.]

(a) Outline the miasma theory of disease. (2 marks)

(b) Calculate the percentage of the deaths in Source H that occurred within 100 metres of the Crown Street pump. Give your answer to one decimal place. (2 marks)

(c) Explain what Source H suggests about the cause of the outbreak. (3 marks)

(d) Explain why evidence like that in Source H was not immediately accepted by the authorities in the nineteenth century. (3 marks)

Total for Question 6: 10 marks$mq$, $mq$(a) [1] The theory was that diseases were caused by foul smells or 'bad air' rising from rotting waste, marshes or sewage.
[1] Supporters believed that cleaning up smells and dirt would prevent illness; it was not understood that living microbes caused disease. (Accept: it was the main theory before germ theory.)
(b) [1] Method: 38 / 44 x 100.
[1] 86.4%.
(c) [1] The deaths are concentrated around one pump, which suggests that something at that pump caused the outbreak.
[1] The other two pumps are linked to far fewer deaths, so the cause was not general across the district, as foul air would be.
[1] The factory 200 metres from the pump, with its own well, had no deaths, which suggests that the disease was spread by water rather than air.
(d) [1] The miasma theory was widely believed by doctors and officials, and it seemed to fit the smells of crowded towns.
[1] Microbes were not yet identified as the cause: germ theory was not established until Pasteur's work in the 1860s and Koch's work in the 1870s and 1880s, so there was no known mechanism.
[1] Acting on the evidence would have been expensive (new water and sewage systems) and politically difficult, as it would blame water companies and local councils; and evidence from a single outbreak could be dismissed as coincidence. Accept other valid points.$mq$, $mq$B$mq$),
(7, $mq$[[Q 7 | A 5 | C 5 | D 6]]
Task 7: The end of apartheid in South Africa. This task focuses on the key concept of causation and the global context of fairness and development.

Source I: timeline of selected events (compiled for this paper)
1948: The National Party wins power in South Africa and begins to introduce apartheid laws.
21 March 1960: Police kill 69 protesters at Sharpeville. The African National Congress (ANC) and the Pan Africanist Congress are banned.
1964: Nelson Mandela is sentenced to life imprisonment.
16 June 1976: Students in Soweto protest against being taught in Afrikaans. The police response leads to many deaths and wider unrest.
1977: The United Nations Security Council imposes a mandatory arms embargo on South Africa.
1985: A state of emergency is declared in parts of South Africa.
1986: The United States Congress passes the Comprehensive Anti-Apartheid Act.
11 February 1990: Mandela is released from prison, nine days after the ANC is unbanned.
27 April 1994: South Africa holds its first elections open to all adults.

Source J: from a memo by an imagined South African business executive, 1987 (written for this paper)
Our company can no longer plan ahead. Foreign banks are reluctant to lend, some overseas customers have stopped buying, and sports and cultural isolation is felt by our young managers. At the same time, strikes and township unrest disrupt production every month. Whatever the government says in public, the present system cannot be kept going without a heavy price.

Source K: from the recollection of an imagined township activist, written years later (written for this paper)
We did not wait for the world. We boycotted rents and shops, and stayed away from work on days of protest. Unions grew strong, and young people in the streets would not be silenced, however many were detained. When foreign governments spoke, it helped, but it was our own struggle that made the country ungovernable.

'International pressure was the main reason apartheid ended in South Africa.' To what extent do you agree? In your answer, use Sources I, J and K and your own knowledge. Reach a clear judgement. (16 marks)

Total for Question 7: 16 marks$mq$, $mq$Criterion A, knowledge and understanding [5]: 0 marks for no relevant knowledge. 1-2 marks for limited, general or partly inaccurate knowledge. 3-4 marks for mostly accurate, relevant knowledge of apartheid and the reasons for its end, with some detail. 5 marks for accurate, detailed and well-selected knowledge of both internal and external factors, going beyond the sources.
Criterion D, thinking critically [6]: 0 marks for no relevant argument. 1-2 marks for a one-sided or descriptive response with a limited judgement. 3-4 marks for an argument considering both internal and external factors, using the sources and showing some awareness of their perspective. 5-6 marks for a balanced, well-supported evaluation that weighs the factors against each other, assesses the sources' origin, purpose and reliability, and reaches a clear, justified judgement about the extent of agreement.
Criterion C, communicating [5]: 0 marks for no organisation. 1-2 marks for a basic structure with limited use of historical terms. 3-4 marks for a clear structure, fluent writing, accurate terminology and references to sources. 5 marks for a well-organised, coherent, precise argument with an introduction, developed paragraphs, a conclusion and consistently accurate historical language.
Indicative content, international pressure: the United Nations arms embargo (1977); the sports, cultural and academic boycotts; the United States Comprehensive Anti-Apartheid Act (1986) and sanctions by the European Community and the Commonwealth; foreign banks' refusal to lend, which damaged the economy (Source J); the end of the Cold War reduced the West's willingness to tolerate South Africa as an anti-communist ally and reduced the government's argument that it was resisting communism.
Indicative content, internal pressure: continued resistance after Sharpeville (the ANC's armed wing, Soweto in 1976); the United Democratic Front (1983) and the trade union federation COSATU (1985), strikes, rent and consumer boycotts, school boycotts and township unrest; states of emergency from 1985 showed the government could not restore order; the economy was stagnating; the imprisoned Mandela had become an international symbol; the decision of President F. W. de Klerk to unban the ANC on 2 February 1990 and negotiate; Mandela's and the ANC's willingness to negotiate.
Evaluation of sources: Source J is a contemporary business memo from within the system, so it is useful for the economic pressure but mixes international and internal pressure; Source K is a retrospective by a participant, so it may overstate internal resistance, but it also acknowledges that foreign governments 'helped'; Source I is a factual timeline with no explanation of causes and omits internal events such as the unrest after 1984.
Award credit for any reasoned judgement, for example that the two kinds of pressure were interdependent, with internal resistance making the country ungovernable and external pressure making the cost of apartheid unsustainable.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Geography MYP 5 eAssessment Structure Mock A (7 tasks, 74 marks) (74 marks)
with sub as (select id from public.subjects where slug = $mq$geography$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Geography MYP 5 eAssessment Structure Mock A (7 tasks, 74 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Geography MYP 5 eAssessment Structure Mock A (7 tasks, 74 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 4 | B 2]]
Task 1: Population change. This task focuses on the key concept of change and the global context of globalization and sustainability.

Lantara is an invented low-income country. The figures below were created for this paper.
Total population: 24 million
Birth rate: 38 per 1,000 people per year
Death rate: 11 per 1,000 people per year

(a) Show that the rate of natural increase in Lantara is 2.7 per cent per year. (2 marks)

(b) State the stage of the demographic transition model that Lantara is most likely to be in. (1 mark)

(c) Explain two reasons why death rates fall in this stage of the demographic transition model. (3 marks)

Total for Question 1: 6 marks$mq$, $mq$(a) [1] Natural increase = birth rate - death rate = 38 - 11 = 27 per 1,000.
[1] 27 per 1,000 = 2.7 per cent (27 / 1,000 x 100).
(b) [1] Stage 2.
(c) [1] [1] [1] Two reasons, with one mark for each reason and a third mark for development of either, from: improved medical care, vaccination and clinics; better sanitation and clean water supply, reducing diseases such as cholera; improved food supply and nutrition through better farming; improved education about hygiene; reduced infant mortality as health care for mothers and babies improves.$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 3 | B 7]]
Task 2: Urban growth. This task focuses on the key concept of change and the global context of globalization and sustainability.

Karuma is an invented city. The figures were created for this paper.

Source A: population of Karuma and the share of people living in informal settlements
Year: 1990, 2000, 2010, 2020
Population (millions): 1.8, 3.1, 5.6, 9.4
People living in informal settlements (%): 22, 28, 34, 39

(a) Calculate the percentage increase in the population of Karuma between 1990 and 2020. Give your answer to the nearest whole number. (2 marks)

(b) Calculate the number of people living in informal settlements in Karuma in 2020. Give your answer in millions to one decimal place. (2 marks)

(c) Describe the trend in the share of people living in informal settlements between 1990 and 2020. (1 mark)

(d) Explain two push or pull factors that have caused people to move to cities such as Karuma. (3 marks)

(e) Suggest one way in which the city authorities could improve life in an informal settlement and explain why it would be effective. (2 marks)

Total for Question 2: 10 marks$mq$, $mq$(a) [1] Method: (9.4 - 1.8) / 1.8 x 100.
[1] 422%.
(b) [1] Method: 9.4 million x 0.39 (or 39 / 100 x 9.4).
[1] 3.7 million (accept 3.67 million).
(c) [1] The share rose steadily in every period, from 22% to 39% (an increase of 17 percentage points).
(d) [1] [1] [1] Two factors, one mark for each identified and a third mark for development, from: push factors such as lack of jobs in rural areas, land shortage, drought or crop failure, poor services, conflict; pull factors such as jobs in industry and services, higher wages, better schools and hospitals, the hope of a better quality of life, family already in the city.
(e) [1] A valid strategy, e.g. self-help schemes giving residents legal land tenure, piped water and sanitation, paved roads, or site-and-service schemes.
[1] Explanation, e.g. giving tenure encourages residents to invest in their homes; clean water and sanitation reduce disease; the improvements are cheaper than demolishing and rebuilding.$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | A 3 | B 4 | C 3]]
Task 3: River discharge and flooding. This task focuses on the key concept of systems and the global context of globalization and sustainability.

The data below were created for this paper. They show a rainstorm and the response of two river channels that drain catchments of similar size: one mostly rural and one mostly urban.

Source B: rainfall and river discharge
Hours after the start of the rainfall: 0, 2, 4, 6, 8, 10, 12, 14, 16
Rainfall (mm per hour): 0, 8, 14, 6, 2, 0, 0, 0, 0
Rural catchment discharge (cubic metres per second): 4, 4, 6, 14, 30, 42, 31, 17, 8
Urban catchment discharge (cubic metres per second): 4, 7, 22, 58, 36, 19, 10, 6, 5

(a) State the peak discharge of the rural catchment and the time at which it occurred. (1 mark)

(b) Lag time is the time between the peak of the rainfall and the peak discharge. Calculate the lag time for each catchment. (2 marks)

(c) Calculate how much higher the peak discharge of the urban catchment is than that of the rural catchment. (1 mark)

(d) Explain why the urban catchment has a shorter lag time and a higher peak discharge. (3 marks)

(e) Describe how you would present the data in Source B so that the two catchments can be compared. (3 marks)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] 42 cubic metres per second at 10 hours after the start of rainfall (both needed).
(b) [1] Rural: 10 - 4 = 6 hours.
[1] Urban: 6 - 4 = 2 hours.
(c) [1] 58 - 42 = 16 cubic metres per second.
(d) [1] Urban surfaces such as roads, roofs and pavements are impermeable, so there is little infiltration and more surface runoff.
[1] Drains and sewers carry water quickly and directly to the river, so water reaches the channel sooner (shorter lag time).
[1] More water reaches the channel at the same time, so the discharge peaks higher; in the rural catchment, vegetation intercepts rainfall and the soil absorbs it, delaying and reducing the flow.
(e) [1] A line graph (a storm hydrograph) with time (hours) on the horizontal axis and discharge on the vertical axis, with a suitable scale and labelled units; rainfall could be shown as bars on a secondary axis.
[1] Both catchments plotted on the same axes with different colours or line styles and a key, so the peaks can be compared directly.
[1] A clear title; lag times or the peaks can be marked or annotated.$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | A 4 | B 3 | D 3]]
Task 4: Earthquakes. This task focuses on the key concept of consequences and the global context of fairness and development.

Source C: four earthquakes (invented for this paper)
Earthquake: P, Q, R, S
Magnitude: 7.0, 7.1, 5.9, 6.8
Focal depth (km): 10, 12, 8, 110
Deaths: 21,000; 46; 1,100; 0
Gross national income per person in the country (US dollars): 1,200; 48,000; 900; 41,000

Each whole number increase in magnitude means that about 32 times more energy is released.

(a) Show that an earthquake of magnitude 7.0 releases about 32 times as much energy as one of magnitude 6.0. (1 mark)

(b) Compare the impacts of earthquakes P and Q and suggest two reasons for the difference. (3 marks)

(c) Explain why earthquake S caused no deaths even though its magnitude was 6.8. (2 marks)

(d) Calculate the mean number of deaths for earthquakes P and R, which both occurred in low-income countries. (2 marks)

(e) Explain the difference between the primary and secondary effects of an earthquake, giving one example of each. (2 marks)

Total for Question 4: 10 marks$mq$, $mq$(a) [1] Each whole number is 10 to the power 1.5, which is about 31.6 (10^1.5), so the increase is about 32 times. Accept: 31.6 rounds to 32.
(b) [1] Similar magnitude and shallow depth, but P caused 21,000 deaths while Q caused only 46.
[1] Reason 1: Q occurred in a high-income country that can afford earthquake-resistant building codes, so buildings were less likely to collapse.
[1] Reason 2: better emergency services, hospitals, warning systems and public preparedness in Q; accept population density or the time of day if developed.
(c) [1] The focus was deep (110 km), so seismic energy was dissipated before reaching the surface and shaking was weaker.
[1] The high-income country was likely to have strong buildings and good preparedness. (Accept: the epicentre may have been in an area of low population.)
(d) [1] Method: (21,000 + 1,100) / 2.
[1] 11,050 deaths.
(e) [1] Primary effects are caused directly by ground shaking, e.g. collapsed buildings, bridges and roads, and deaths from falling debris.
[1] Secondary effects follow from the primary effects or the shaking, e.g. fires from broken gas pipes, tsunamis, landslides, disease from contaminated water and loss of jobs.$mq$, $mq$A$mq$),
(5, $mq$[[Q 5 | A 4 | B 4 | D 2]]
Task 5: Climate change. This task focuses on the key concept of change and the global context of globalization and sustainability.

Source D: atmospheric carbon dioxide and global temperature (approximate values, rounded)
Year: 1960, 1980, 2000, 2020
Carbon dioxide concentration (parts per million): 317, 339, 370, 414
Global average temperature compared with a baseline (degrees Celsius): 0.0, 0.3, 0.4, 1.0

(a) Calculate the percentage increase in the concentration of carbon dioxide between 1960 and 2020. Give your answer to one decimal place. (2 marks)

(b) Use data from Source D to describe how the rate of increase in carbon dioxide changed between 1960 and 2020. (2 marks)

(c) Explain how the greenhouse effect works. (3 marks)

(d) State one human activity that has increased the concentration of carbon dioxide in the atmosphere. (1 mark)

(e) Suggest one way in which rising sea levels might affect a low-lying coastal community. (2 marks)

Total for Question 5: 10 marks$mq$, $mq$(a) [1] Method: (414 - 317) / 317 x 100.
[1] 30.6%.
(b) [1] The rate of increase has speeded up.
[1] Supported with data, e.g. 1960 to 1980: 22 ppm in 20 years (11 ppm per decade); 2000 to 2020: 44 ppm in 20 years (22 ppm per decade), twice as fast.
(c) [1] Short-wave radiation from the Sun passes through the atmosphere and warms the Earth's surface.
[1] The Earth emits longer-wave (infrared) heat radiation, which is absorbed by greenhouse gases such as carbon dioxide and methane.
[1] These gases re-emit heat in all directions, including back to the surface, so less heat escapes to space and the lower atmosphere warms. (Accept: human activity strengthens this natural effect.)
(d) [1] E.g. burning fossil fuels in power stations, transport or industry; deforestation; cement production.
(e) [1] A valid effect, e.g. flooding of homes and farmland; saltwater contaminating drinking water and soil; more coastal erosion; loss of beaches and tourism income.
[1] A developed consequence, e.g. people forced to migrate; loss of livelihoods in farming or fishing; costs of building sea defences.$mq$, $mq$A$mq$),
(6, $mq$[[Q 6 | B 5 | C 3 | D 4]]
Task 6: Using GIS to plan for coastal flooding. This task focuses on the key concept of systems and the global context of scientific and technical innovation.

Port Alder is an invented coastal city with a population of 96,000. The city council uses a geographic information system (GIS) with these layers: ground elevation, population density, roads and hospitals. The elevation layer shows that land below 5 metres above sea level would flood in a 1-in-50-year storm surge. Overlaying the layers shows that 41,000 people live below 5 metres.

The council wants to build one flood shelter. There are three possible sites.

Source E: candidate sites
Site: X, Y, Z
Height above sea level (m): 2.5, 9, 14
People living within 1 km: 18,000; 7,500; 2,100
Distance to nearest main road (km): 0.2, 0.5, 4.0

(a) Explain how overlaying layers in a GIS helps planners to identify the people at risk from flooding. (3 marks)

(b) Calculate the percentage of Port Alder's population who live below 5 metres above sea level. Give your answer to one decimal place. (2 marks)

(c) Recommend which site the council should choose. Use data from Source E to justify your decision and explain why one other site is less suitable. (4 marks)

(d) Describe how a choropleth map could be used to show the population density layer. (3 marks)

Total for Question 6: 12 marks$mq$, $mq$(a) [1] Each layer shows one type of data for the same area, so the layers can be placed on top of each other (a spatial overlay).
[1] The planner selects the areas below 5 metres from the elevation layer and combines them with the population density layer.
[1] The GIS can then calculate or highlight the number of people, roads and hospitals inside the flood zone (accept: this is quicker and more accurate than comparing separate paper maps).
(b) [1] Method: 41,000 / 96,000 x 100.
[1] 42.7%.
(c) Criterion D [4]: 1 mark for a clear recommendation. 1 mark for using data to justify it. 1 mark for a reasoned explanation of why another site is less suitable using data. 1 mark for a balanced judgement, for example recognising a trade-off.
Indicative content: Site Y is the best choice: it is 9 metres above sea level, so it is safe from a surge below 5 metres, it serves 7,500 people within 1 km and is only 0.5 km from a main road for access and evacuation. Site X is unsuitable because at 2.5 metres it would itself flood. Site Z is safe and the highest but is 4.0 km from a main road, and only 2,100 people live within 1 km, so few people could reach it quickly. Accept Site Z with strong justification (the safest), or Site X with justification, as long as the risk is addressed.
(d) [1] The map divides the area into zones and shades each by density class (for example, fewer than 1,000, 1,000 to 5,000, more than 5,000 people per square kilometre).
[1] A graded colour scale from light to dark shows low to high density, with a key.
[1] A title and the unit are given, and classes are chosen so that each has a similar number of zones; the map allows patterns, such as dense areas along the coast, to be identified quickly.$mq$, $mq$B$mq$),
(7, $mq$[[Q 7 | A 5 | C 5 | D 6]]
Task 7: Managing a growing city. This task focuses on the key concept of sustainability and the global context of globalization and sustainability.

Karuma (from Task 2) has 9.4 million people, and 39 per cent of them live in informal settlements. The city council can afford only one of the following options. All figures were created for this paper.

Source F: three options
Option 1: Build 12,000 new apartments on the edge of the city for 600 million US dollars. The apartments would be rented at prices few informal residents can afford. Most would be 25 km from the main areas of employment.
Option 2: Upgrade 40 informal settlements, each with about 3,000 households, with piped water, sanitation, drainage, paved paths and legal land tenure, for 240 million US dollars. Residents would build and repair their own homes.
Option 3: Build an 18 km metro line for 1.5 billion US dollars. It is expected to carry 400,000 passengers per day and would cut travel times across the city.

Evaluate which option the council should choose. In your answer, calculate the cost per household for Options 1 and 2, use the information in Source F and your own knowledge of urban management, and reach a justified conclusion. (16 marks)

Total for Question 7: 16 marks$mq$, $mq$Criterion A, knowledge and understanding [5]: 0 marks for no relevant knowledge. 1-2 marks for limited or general knowledge of urban problems. 3-4 marks for mostly accurate knowledge of informal settlements, transport and housing strategies, with some detail. 5 marks for accurate, detailed and well-applied knowledge, including terms such as self-help schemes, tenure, sustainable urban development and urban sprawl.
Criterion D, thinking critically [6]: 0 marks for no relevant argument. 1-2 marks for a one-sided or descriptive response. 3-4 marks for an evaluation of at least two options, using the data. 5-6 marks for a balanced, justified evaluation that weighs costs, benefits, stakeholders and sustainability (social, economic, environmental), considers the limitations of the data, and reaches a clear conclusion.
Criterion C, communicating [5]: 0 marks for no organisation. 1-2 marks for a basic structure with limited geographical terms. 3-4 marks for a clear structure, accurate terminology and correct calculations presented. 5 marks for a well-organised, coherent argument with a conclusion, accurate geographical language and clearly presented calculations.
Calculations: Option 1: 600,000,000 / 12,000 = 50,000 US dollars per household. Option 2: 40 x 3,000 = 120,000 households; 240,000,000 / 120,000 = 2,000 US dollars per household. Option 2 is 25 times cheaper per household. Option 3: 1,500 million / 18 = about 83.3 million US dollars per kilometre.
Indicative content: Option 2 benefits 120,000 households (about 10 times as many as Option 1) at less than half the total cost, keeps communities and livelihoods in place, is socially sustainable, and uses residents' own labour; tenure encourages investment. Limitations: it improves living conditions but does not create new land or employment, density remains high, and some sites may be on flood-prone or hazardous land. Option 1: the apartments are costly, unaffordable, and far from work (25 km), which would increase commuting and sprawl, and so is unlikely to reach those in need. Option 3: improves mobility and reduces road congestion and emissions in the long run and may support economic growth, but is the most expensive and does not directly address housing or sanitation; the poorest may not afford fares; construction would displace people.
Accept a justified choice of any option, but a high-level response must engage with the data and sustainability, and acknowledge that a combination of strategies over time may be needed.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Geography MYP 5 eAssessment Structure Mock B (7 tasks, 76 marks) (76 marks)
with sub as (select id from public.subjects where slug = $mq$geography$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Geography MYP 5 eAssessment Structure Mock B (7 tasks, 76 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Geography MYP 5 eAssessment Structure Mock B (7 tasks, 76 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 3 | B 3]]
Task 1: Map skills. This task focuses on the key concept of space and the global context of scientific and technical innovation.

Source A: information from an imagined topographic map with a scale of 1:50 000 and a contour interval of 10 metres (written for this paper)
Point A is a farm at a height of 40 metres above sea level.
Point B is a hilltop at a height of 100 metres above sea level.
On the map the straight-line distance between the village church and the railway station is 7.5 cm.
The straight-line distance from Point A to Point B is 1.5 km.

(a) Calculate the real distance, in kilometres, between the church and the station. (1 mark)

(b) Calculate the average gradient between Point A and Point B. Give your answer in the form 1 in n. (2 marks)

(c) Explain how contour lines on a map show (i) a steep slope and (ii) a river valley. (3 marks)

Total for Question 1: 6 marks$mq$, $mq$(a) [1] 7.5 cm x 50,000 = 375,000 cm = 3.75 km.
(b) [1] Height difference 100 - 40 = 60 m; gradient = 60 / 1,500 (distance converted to metres).
[1] 1 in 25.
(c) [1] Steep slopes: contour lines are close together.
[1] Gentle slopes: contour lines are far apart (accept as a contrast with the steep slope).
[1] River valleys: contour lines form V-shapes (or U-shapes) that point uphill, towards the source of the river.$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 4 | B 6]]
Task 2: Tropical storms. This task focuses on the key concept of change and the global context of fairness and development.

Marisol is an invented tropical storm. The data below were created for this paper.

Source B: Tropical storm Marisol
Day: 1, 2, 3, 4, 5, 6
Maximum sustained wind speed (km/h): 85, 120, 185, 230, 150, 70
Location: open ocean, open ocean, open ocean, open ocean, coast at landfall, inland
Sea surface temperature (degrees Celsius) on days 1 to 4: 27.5, 28.0, 29.0, 29.5

Source C: the Saffir-Simpson scale for hurricanes (maximum sustained wind speed)
Category 1: 119 to 153 km/h
Category 2: 154 to 177 km/h
Category 3: 178 to 208 km/h
Category 4: 209 to 251 km/h
Category 5: 252 km/h or more

(a) State the category of Marisol on day 3. (1 mark)

(b) State two conditions needed for a tropical storm to form. (2 marks)

(c) Calculate the percentage increase in the maximum sustained wind speed between day 1 and day 4. Give your answer to one decimal place. (2 marks)

(d) Explain why the wind speed of Marisol fell after it moved over land. (2 marks)

(e) Describe the changes in the wind speed of Marisol over the six days. (3 marks)

Total for Question 2: 10 marks$mq$, $mq$(a) [1] Category 3 (185 km/h lies between 178 and 208).
(b) [1] [1] Any two from: sea surface temperature of at least about 26.5 degrees Celsius; warm water to a depth of about 50 metres; a location more than about 5 degrees north or south of the equator so that the Coriolis effect can make the storm spin; low wind shear; an existing area of low pressure or disturbance.
(c) [1] Method: (230 - 85) / 85 x 100.
[1] 170.6%.
(d) [1] The storm was cut off from its energy source, the warm ocean water that supplies heat and moisture (evaporation and latent heat).
[1] Friction with the land surface slowed the winds. (Accept: less moisture available for condensation.)
(e) [1] Wind speed rose steadily from 85 km/h on day 1 to a peak of 230 km/h on day 4 (category 4).
[1] Wind speed fell after day 4, to 150 km/h on day 5 at landfall.
[1] It continued to fall to 70 km/h on day 6 as it moved inland. Accept reference to the sea surface temperature rising to 29.5 degrees Celsius during the intensification. Award a mark for data used correctly.$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | A 2 | B 4 | D 4]]
Task 3: Coastal erosion and management. This task focuses on the key concept of systems and the global context of globalization and sustainability.

Source D: cliff-top retreat between 1980 and 2020 at four imagined sites
Site 1, chalk cliff with no protection: 52 m
Site 2, glacial till (clay and boulders) cliff with no protection: 120 m
Site 3, concrete sea wall: 0 m
Site 4, beach with timber groynes: 8 m

Source E: a proposal to protect Site 2 (figures created for this paper)
Length of coast to be protected: 2.4 km.
Cost of a sea wall: 6,500 US dollars per metre. Maintenance: 120,000 US dollars per year for 30 years.
Value of property at risk in the next 30 years: 85 houses worth 180,000 US dollars each, and farmland worth 2.1 million US dollars.

(a) Calculate the mean rate of cliff retreat per year at Site 2. (1 mark)

(b) Suggest two reasons why Site 2 is eroding faster than Site 1. (2 marks)

(c) Calculate the cost of constructing the sea wall in Source E. (1 mark)

(d) Calculate the total cost of constructing and maintaining the sea wall over 30 years. (2 marks)

(e) The local council must decide whether to build the sea wall at Site 2 or to allow managed retreat. Using calculations from Source E and your own knowledge, justify the decision you recommend. (4 marks)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] 120 / 40 = 3.0 metres per year.
(b) [1] [1] Any two from: glacial till is made of loose, weak, unconsolidated material, whereas chalk is more resistant to erosion; till slumps when saturated; Site 2 may face stronger waves because of its fetch or exposure; less beach in front of the cliff to absorb wave energy; human activity such as removing the beach.
(c) [1] 2.4 km = 2,400 m; 2,400 x 6,500 = 15.6 million US dollars.
(d) [1] Maintenance 120,000 x 30 = 3.6 million US dollars.
[1] Total 15.6 + 3.6 = 19.2 million US dollars.
(e) Criterion D [4]: 1 mark for a clear decision. 1 mark for use of calculated data (19.2 million against property value of 17.4 million, that is 85 x 180,000 = 15.3 million plus 2.1 million). 1 mark for a consideration of other factors (social, environmental or economic). 1 mark for a justified, balanced conclusion.
Indicative content: the total cost of the wall (19.2 million) is 1.8 million more than the value of the property protected (17.4 million), so a purely financial cost-benefit analysis does not support the wall. Managed retreat (compensating owners, moving homes, allowing natural erosion) would be cheaper and more sustainable, and a wall may increase erosion down the coast by stopping longshore drift of sediment. However, residents would lose homes, community and farmland; compensation may be costly; the benefits of the wall may continue beyond 30 years; and the human cost cannot be measured in money. Accept a justified recommendation either way as long as the calculations are used.$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | A 2 | B 4 | D 4]]
Task 4: Energy resources. This task focuses on the key concept of sustainability and the global context of globalization and sustainability.

Veldara is an invented country. The figures were created for this paper.

Source F: Veldara's primary energy supply
Energy source: coal, oil, gas, hydroelectric, wind and solar, nuclear
Share in 2020 (%): 46, 24, 18, 6, 4, 2
Government target for 2040 (%): 15, 15, 20, 8, 35, 7
Total energy demand in 2020: 900 petajoules (PJ)
Predicted total energy demand in 2040: 1,200 PJ

(a) State the percentage of Veldara's energy that came from renewable sources in 2020. Hydroelectric, wind and solar are renewable. (1 mark)

(b) Calculate the amount of energy that coal is expected to supply in 2040. (1 mark)

(c) Calculate the percentage change in the amount of energy supplied by coal between 2020 and 2040. Give your answer to one decimal place. (2 marks)

(d) Explain why coal is described as a non-renewable resource and describe one environmental problem caused by burning it. (2 marks)

(e) Discuss two challenges that Veldara may face in meeting its 2040 target. (4 marks)

Total for Question 4: 10 marks$mq$, $mq$(a) [1] 6 + 4 = 10%.
(b) [1] 15% of 1,200 = 180 PJ.
(c) [1] Coal in 2020: 46% of 900 = 414 PJ; change = (180 - 414) / 414 x 100.
[1] -56.5% (a decrease of 56.5%).
(d) [1] Coal takes millions of years to form, so it is used faster than it is replaced (a finite stock).
[1] Burning coal releases carbon dioxide, which adds to climate change; accept sulphur dioxide causing acid rain, or particulates harming health.
(e) [1] [1] [1] [1] Two challenges, each with 1 mark for the challenge and 1 mark for development, from: the cost of building wind and solar farms, grid upgrades and storage; the intermittent nature of wind and solar, which requires back-up or storage; rising demand (900 to 1,200 PJ, an increase of one third), so renewable output must increase from 36 PJ to 420 PJ; opposition from people employed in coal mining and power generation; the need for imported technology and skilled workers; public opposition to nuclear power or to the sites of wind farms and dams (environmental and social impacts).$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | A 5 | B 4 | D 3]]
Task 5: Tourism. This task focuses on the key concept of globalization and the global context of globalization and sustainability.

Isla Marena is an invented island whose economy depends on tourism. The figures were created for this paper.

Source G: international tourist arrivals
Year: 2005, 2010, 2015, 2019, 2020
Arrivals (thousands): 120, 210, 340, 520, 90

Source H: tourism receipts in 2019
Total spending by tourists: 780 million US dollars.
About 55 per cent of this spending leaves the island's economy as leakage, for example to pay foreign hotel owners, airlines and tour operators and to import food and goods.

(a) Calculate the percentage increase in international arrivals between 2005 and 2019. Give your answer to one decimal place. (2 marks)

(b) Calculate how much of the tourist spending in 2019 stayed in the island's economy. (2 marks)

(c) Suggest why arrivals fell in 2020 and explain what this shows about the risks of depending on tourism. (2 marks)

(d) Explain what is meant by economic leakage and describe two causes of leakage. (3 marks)

(e) The government is considering a switch to small-scale ecotourism. Evaluate this strategy. (3 marks)

Total for Question 5: 12 marks$mq$, $mq$(a) [1] Method: (520 - 120) / 120 x 100.
[1] 333.3%.
(b) [1] 100 - 55 = 45% remained; 45% of 780 million.
[1] 351 million US dollars.
(c) [1] A valid reason, e.g. global travel restrictions and flight cancellations during the 2020 pandemic, an economic downturn or a natural disaster.
[1] An explanation of the risk, e.g. an economy dependent on one sector suffers a collapse in income, jobs and government revenue when tourism falls (overdependence).
(d) [1] Leakage is the share of tourist spending that leaves the local economy rather than benefiting local people.
[1] A cause, e.g. foreign-owned hotels and airlines take profits abroad; imported food, drinks and building materials for the hotels.
[1] A second, different cause, e.g. all-inclusive packages mean tourists spend little locally; foreign management staff are paid more than local staff, and money is sent abroad. Accept other valid causes.
(e) Criterion D [3]: 1 mark for a benefit of ecotourism; 1 mark for a limitation or risk; 1 mark for a judgement.
Indicative content: ecotourism uses local guides, locally owned lodges and local food, so less leakage; fewer visitors cause less damage to reefs and forests and less pressure on water; benefits the community. But the number of visitors and income would be lower than the 520,000 arrivals of 2019, so jobs and incomes may fall; it needs training and marketing; it is still vulnerable to external shocks; the cost of conserving habitats. A balanced judgement, such as combining ecotourism with a managed reduction of mass tourism, should be rewarded.$mq$, $mq$A$mq$),
(6, $mq$[[Q 6 | B 4 | C 4 | D 4]]
Task 6: Measuring development. This task focuses on the key concept of globalization and the global context of fairness and development.

Source I: development indicators for four imagined countries (created for this paper)
Country: P, Q, R, S
Gross national income per person (US dollars): 1,250; 4,800; 14,500; 2,300
Life expectancy at birth (years): 61, 72, 78, 66
Deaths of children under five per 1,000 live births: 68, 24, 9, 41
Adult literacy (%): 58, 91, 99, 76

(a) Calculate the mean gross national income per person for the four countries. (1 mark)

(b) Calculate the median gross national income per person and explain why the median gives a better picture of a typical country than the mean in this case. (3 marks)

(c) Write a paragraph of about 80 words comparing the level of development of Country P with Country R. Use data from Source I with correct units, and use comparative language. (4 marks)

(d) A charity has funds to help only one of the four countries. Recommend which country it should choose. Use at least three indicators from Source I to justify your decision and explain why the other countries were not chosen. (4 marks)

Total for Question 6: 12 marks$mq$, $mq$(a) [1] (1,250 + 4,800 + 14,500 + 2,300) / 4 = 5,712.50 US dollars (accept 5,713).
(b) [1] Order the values: 1,250; 2,300; 4,800; 14,500.
[1] The median is (2,300 + 4,800) / 2 = 3,550 US dollars.
[1] The mean is pulled up by the very high value for Country R, so it is higher than three of the four countries; the median is less affected by this extreme value.
(c) Criterion C [4]: 1 mark for a mostly accurate comparison with some data. 2 marks for accurate use of several data with units and some comparative language. 3 marks for a clear, organised comparison covering income, health and education. 4 marks for a concise, well-structured paragraph that uses at least three accurate comparisons with units, correct comparatives (for example 'nearly twelve times', 'seventeen years longer') and accurate geographical vocabulary such as 'gross national income', 'life expectancy' and 'literacy'.
Data for reference: income of R is 11.6 times that of P (14,500 / 1,250); life expectancy 17 years longer; under-five mortality 59 deaths fewer per 1,000 (68 - 9); literacy 41 percentage points higher (99 - 58).
(d) Criterion D [4]: 1 mark for a clear recommendation. 1 mark for use of three indicators. 1 mark for an explanation of why another country was not chosen, using data. 1 mark for a balanced evaluation or limitation.
Indicative content: Country P has the lowest income (1,250 US dollars), the lowest life expectancy (61 years), the highest child mortality (68 per 1,000) and the lowest literacy (58 per cent), so it has the greatest need. Country R has the highest values on every indicator and needs the least support. Country S is next in need but better than P on every indicator. Limitations: only four indicators, national averages hide inequality within countries, and need is not the only criterion (the charity must consider whether aid can be delivered effectively and whether the government is stable).$mq$, $mq$B$mq$),
(7, $mq$[[Q 7 | A 5 | C 5 | D 6]]
Task 7: Sharing a river. This task focuses on the key concept of sustainability and the global context of fairness and development.

The Kandara Basin is an invented river basin. All figures were created for this paper. The Kandara River flows through the country of Orlen, home to 3.2 million people, and then into the neighbouring country of Essara.

Source J: water in the Kandara Basin
Water demand in Orlen: 1,150 million cubic metres per year.
Water supply available to Orlen: 980 million cubic metres per year.
Demand is expected to grow by about 2 per cent every year.
The river provides about 40 per cent of Essara's irrigation water.

Source K: two proposals to reduce the shortage
Proposal 1, a dam: it would add 260 million cubic metres per year to supply and generate hydroelectricity (90 megawatts). It would cost 540 million US dollars, take seven years to build, flood 62 square kilometres of farmland and forest, and force 14,000 people to move. It would reduce the flow into Essara.
Proposal 2, an efficiency package: repair leaking urban pipes (35 per cent of the water entering the city system is currently lost) and introduce drip irrigation. It would save 140 million cubic metres per year, cost 180 million US dollars and take three years.

Source L: from a statement by an imagined farmer in Essara (written for this paper)
We were not asked about the dam. Our fields depend on this river from planting to harvest. If less water comes down, we lose our harvest, and if we lose our harvest our children will leave the village.

Evaluate the two proposals and recommend which, if either, the government of Orlen should adopt. In your answer, calculate the cost per million cubic metres of water for each proposal, use Sources J, K and L and your own knowledge of water management, and reach a justified conclusion. (16 marks)

Total for Question 7: 16 marks$mq$, $mq$Criterion A, knowledge and understanding [5]: 0 marks for no relevant knowledge. 1-2 marks for limited, general knowledge of water supply. 3-4 marks for mostly accurate knowledge of water management strategies and their impacts, with some detail. 5 marks for accurate, detailed and well-applied knowledge, including terms such as water stress, supply and demand, trans-boundary rivers, hard and soft management, sustainability and opportunity cost.
Criterion D, thinking critically [6]: 0 marks for no relevant argument. 1-2 marks for a one-sided or descriptive response. 3-4 marks for an evaluation of both proposals using the data and at least two stakeholders. 5-6 marks for a balanced, justified evaluation that weighs economic, social and environmental factors in the short and long term, considers the perspective of Essara and the limitations of the data, and reaches a clear, justified conclusion.
Criterion C, communicating [5]: 0 marks for no organisation. 1-2 marks for a basic structure with limited geographical terms. 3-4 marks for a clear structure, accurate terminology and correct calculations. 5 marks for a well-organised, coherent argument, accurate geographical language, clearly presented calculations and a conclusion.
Calculations: the shortage is 1,150 - 980 = 170 million cubic metres per year (demand is 117.3% of supply). Proposal 1: 540 / 260 = about 2.08 million US dollars per million cubic metres. Proposal 2: 180 / 140 = about 1.29 million US dollars per million cubic metres. The dam adds 90 million cubic metres more than the present shortage; the efficiency package covers 140 / 170 = 82.4% of the shortage.
Indicative content: Proposal 2 is cheaper per unit of water, quicker (three years against seven), does not displace anyone or flood habitats, and does not reduce the flow to Essara (avoids conflict over a shared river); it is more sustainable. Limitations: it does not fully close the gap (30 million cubic metres short) and demand is growing by 2 per cent a year (growth of 2 per cent is about 23 million cubic metres a year, so the remaining 30 million gap would be exceeded within about two years), and it needs maintenance and farmers' cooperation. Proposal 1 provides a surplus and renewable electricity (90 MW), supports growth and flood control, but the cost per unit is higher, 14,000 people are displaced, 62 square kilometres of habitat are lost, there are risks to downstream farmers (Source L) and potential international conflict, and sediment trapping can reduce dam life.
Accept a justified recommendation, including a combination (efficiency package immediately, with further options explored in partnership with Essara). A high-level response must use data, consider both countries' perspectives, and weigh long-term sustainability.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Economics MYP 5 eAssessment Structure Mock A (8 tasks, 83 marks) (83 marks)
with sub as (select id from public.subjects where slug = $mq$economics$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Economics MYP 5 eAssessment Structure Mock A (8 tasks, 83 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Economics MYP 5 eAssessment Structure Mock A (8 tasks, 83 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
The mango market in the island nation of Tavara. The table shows the weekly demand for and supply of mangoes at different prices.

Price per kg ($): 2, 3, 4, 5, 6, 7
Quantity demanded (tonnes per week): 90, 80, 70, 60, 50, 40
Quantity supplied (tonnes per week): 30, 40, 50, 60, 70, 80

(a) State the equilibrium price and the equilibrium quantity. (2 marks)
(b) Calculate the size of the shortage or surplus if the price is $3 per kg, and state which it is. (2 marks)
(c) A cyclone destroys many mango trees. Explain, using supply and demand, why the equilibrium price rises. (2 marks)
(d) After the cyclone, the quantity supplied is 20 tonnes lower at every price. Determine the new equilibrium price and quantity. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) Equilibrium price $5 per kg [1]; equilibrium quantity 60 tonnes per week [1] (where quantity demanded equals quantity supplied).
(b) At $3 demand is 80 tonnes and supply is 40 tonnes, so 80 - 40 = 40 tonnes [1]; this is a shortage (excess demand) because demand is greater than supply [1].
(c) The cyclone reduces supply (the supply curve shifts to the left) [1]; at the old price of $5 there is now a shortage, so competition among buyers pushes the price up until supply and demand are equal again [1].
(d) New supply at each price: 10, 20, 30, 40, 50, 60 tonnes (for $2 to $7) [1]; demand equals supply at $6 per kg and 50 tonnes per week [1]. Award the second mark for a correct answer read from a consistent table; accept price $6 or quantity 50 given alone only with evidence of the new supply row.$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 9]]
Sunrise Bakery in the town of Palmera sells loaves for $1.50 each. Its fixed costs are $400 per week (rent, oven lease and insurance). Each loaf costs $0.50 in flour, yeast and energy to make.

Loaves made and sold per week: 0, 200, 400, 600, 800
Total cost ($): 400, 500, 600, 700, 800

(a) State one example of a fixed cost and one example of a variable cost for the bakery. (2 marks)
(b) Calculate the bakery's weekly profit when it sells 600 loaves. Show your working. (2 marks)
(c) Determine the number of loaves the bakery must sell each week to break even. (2 marks)
(d) Calculate the average total cost per loaf when 800 loaves are made. (1 mark)
(e) Explain why the average total cost per loaf falls as output rises from 200 to 800 loaves. (2 marks)

Total for Question 2: 9 marks$mq$, $mq$(a) Fixed cost: rent, oven lease or insurance (any one from the stimulus or similar, e.g. manager's salary) [1]; variable cost: flour, yeast or energy (or hourly wages for baking extra loaves) [1].
(b) Total revenue = 600 x 1.50 = $900 [1]; profit = 900 - 700 = $200 [1].
(c) At 400 loaves total revenue = 400 x 1.50 = $600 and total cost = $600 [1]; so break-even output is 400 loaves [1]. (Algebra accepted: 1.5Q = 400 + 0.5Q so Q = 400.)
(d) 800 / 800 = $1.00 per loaf [1].
(e) Fixed costs of $400 stay the same however many loaves are made [1]; so they are spread over more loaves and the fixed cost per loaf falls (while variable cost per loaf stays at $0.50), pulling average cost down [1]. Accept economies of scale explained with an example.$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 10]]
The government of Selvora introduced a fuel tax. Read Source A and Source B.

Source A: Press release from the Ministry of Transport and Environment of Selvora, 3 March 2025.
"From 1 July 2025 a fuel tax of 12 cents per litre will be added to the price of petrol and diesel. The Ministry expects the tax to raise 240 million dollars a year, which will be spent on new buses and rail services. Ministry modelling suggests that petrol and diesel use will fall by 4 per cent in the first year as some drivers switch to public transport. The Minister, Anja Kolr, said: 'This is a fair and necessary step towards cleaner, less congested cities.'"

Source B: Blog post called "Notes from the taxi rank", posted on 9 March 2025 by a licensed taxi driver in the port city of Merrin.
"I drive nine hours a day, six days a week, and my car uses about 55 litres of fuel every shift. At today's prices that is already $38.50 of my takings gone before I pay for repairs. Another 12 cents a litre will cost me an extra $6.60 every shift, which is more than $2,000 a year. My customers will not accept higher fares, so the Ministry is taking money straight out of my family's pocket. Half the drivers at my rank are talking about quitting. The Minister has never driven a taxi for a living."

(a) State the origin of Source A and the likely purpose of Source B. (2 marks)
(b) Explain one value and one limitation of Source A for a student investigating the effects of the fuel tax on drivers. (4 marks)
(c) Compare Source A and Source B by identifying one similarity and one difference in what they suggest about how drivers will respond to the tax. (2 marks)
(d) Suggest two further sources or methods the student could use to investigate the effect of the tax on drivers' incomes. (2 marks)

Total for Question 3: 10 marks$mq$, $mq$(a) Origin of Source A: the Ministry of Transport and Environment (the Selvoran government), a press release dated 3 March 2025 [1]. Purpose of Source B: to persuade readers that the tax is unfair to taxi drivers / to criticise the tax and gain support for drivers (accept to inform others of the personal cost) [1].
(b) Value (one, 2 marks): identification [1], e.g. it gives official figures (240 million dollars raised, 12 cents per litre, 4 per cent fall in fuel use) and explains what the money will be used for; development [1], e.g. because it comes from the body that designed the policy it shows the intended effects and the exact size of the tax. Limitation (one, 2 marks): identification [1], e.g. it is written to promote the policy and may be one-sided or optimistic (the 4 per cent forecast is only a model); development [1], e.g. it says nothing about the costs to people who must drive for work, such as taxi drivers, so it cannot show effects on their incomes.
(c) Similarity [1], e.g. both agree the tax is 12 cents per litre and will increase the cost of driving / both expect some people to change what they do. Difference [1], e.g. Source A expects some drivers to switch to public transport and fuel use to fall by only 4 per cent, whereas Source B says drivers cannot pass on the cost and may quit their jobs altogether (A is a mild, forecast response; B is a severe, personal one).
(d) Any two from: survey or interview a sample of taxi drivers about their costs and incomes before and after July; official statistics on average fuel prices, fares and taxi licence numbers; data from the taxi drivers' association or fuel retailers; reports on fuel taxes in other countries [1][1]. Each must be linked to drivers' incomes.$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | A 3 | C 7]]
The table shows economic data for the country of Marnoval. The Consumer Price Index (CPI) uses 2020 as the base year (CPI = 100).

Year: 2020, 2021, 2022, 2023, 2024, 2025
CPI: 100.0, 103.0, 107.1, 113.5, 117.0, 119.4
Unemployment rate (%): 7.8, 7.1, 6.4, 5.9, 6.3, 6.9
Average weekly wage ($): 2022 = 620, 2023 = 651

(a) Calculate the rate of inflation in 2023, to one decimal place. (2 marks)
(b) Describe the relationship between inflation and unemployment from 2021 to 2023. (2 marks)
(c) Calculate the percentage increase in the average weekly wage between 2022 and 2023. (1 mark)
(d) Use your answers to (a) and (c) to explain whether workers' purchasing power rose or fell between 2022 and 2023. (2 marks)
(e) Using data from the table, write a short paragraph (three to four sentences) describing Marnoval's economic performance from 2023 to 2025. Use appropriate economic terms. (3 marks)

Total for Question 4: 10 marks$mq$, $mq$(a) (113.5 - 107.1) / 107.1 x 100 [1] = 6.0% [1] (accept 5.98 or 6).
(b) Inflation rose (from 3.0% to 4.0% to 6.0%, using the CPI) while unemployment fell (7.1% to 6.4% to 5.9%) [1]; so they moved in opposite directions: an inverse relationship, as demand and employment grew prices rose faster [1].
(c) (651 - 620) / 620 x 100 = 5.0% [1].
(d) Wages rose 5.0% but prices rose 6.0% [1]; so real wages / purchasing power fell (about 1% lower), because workers could buy fewer goods with the extra money [1]. (Real wage check: 620 / 107.1 x 100 = 578.9 and 651 / 113.5 x 100 = 573.6.)
(e) Award up to 3: accurate use of data, e.g. inflation fell from 6.0% in 2023 to 3.1% in 2024 and 2.1% in 2025 [1]; unemployment rose from 5.9% to 6.9% over the same period [1]; correct terminology and a link, e.g. prices are still rising but more slowly (disinflation), while the labour market has weakened, which suggests a slowing economy or weaker demand [1].$mq$, $mq$C$mq$),
(5, $mq$[[Q 5 | A 10]]
The city of Port Alvan has a shortage of flats to rent. The table shows the monthly market for flats.

Monthly rent per flat ($): 400, 500, 600, 700, 800
Quantity demanded (thousands of flats): 90, 75, 60, 45, 30
Quantity supplied (thousands of flats): 30, 45, 60, 75, 90

The city council introduces a maximum rent (a price ceiling) of $500 per month to help low-income families.

(a) Identify the equilibrium monthly rent before the council acts. (1 mark)
(b) Show that a maximum rent of $500 creates a shortage of 30 thousand flats. (2 marks)
(c) Explain why a maximum rent set at $700 would have no effect on the market. (2 marks)
(d) Describe two possible consequences of the shortage created by the $500 maximum rent. (2 marks)
(e) Calculate the total rent paid by all tenants each month before the maximum rent and after it, and state the change. (3 marks)

Total for Question 5: 10 marks$mq$, $mq$(a) $600 [1].
(b) At $500 quantity demanded is 75 thousand and quantity supplied is 45 thousand [1]; 75 - 45 = 30 thousand, so there is a shortage of 30 thousand flats [1].
(c) $700 is above the equilibrium rent of $600 [1]; so the market rent ($600) is already below the ceiling and it is not binding (landlords and tenants can still trade at $600) [1].
(d) Any two, each described, from: black market / illegal extra payments ("key money"); landlords spend less on maintenance so quality falls; some landlords leave the market or convert flats to other uses, reducing supply further; long waiting lists or unfair allocation (first come, first served or favouritism) [1][1].
(e) Before: 60 thousand x $600 = $36 million per month [1]. After: only 45 thousand flats are supplied, so 45 thousand x $500 [1] = $22.5 million per month; total rent falls by $13.5 million [1].$mq$, $mq$A$mq$),
(6, $mq$[[Q 6 | A 9 | D 5]]
Karvan is a small trading economy. Its currency is the Karvan dollar (KD). Eltria, its main trading partner, uses the Eltrian crown (EC). Karvan's furniture makers buy most of their machinery from Eltria.

Karvan's trade in 2024 ($ millions): Exports: furniture 480, textiles 300, fruit 220. Imports: machinery 520, fuel 410, food 130.

During 2025 the exchange rate moved from 1 KD = 2.0 EC to 1 KD = 1.6 EC. A Karvan-made chair is priced at 150 KD. A machine from Eltria costs 24,000 EC. The government is considering a 15% tariff on imported machinery.

(a) Calculate Karvan's trade balance in 2024 and state whether it is a surplus or a deficit. (2 marks)
(b) Calculate the percentage of Karvan's total export value that comes from furniture. (1 mark)
(c) Calculate the price of the chair in Eltria, in EC, after the exchange rate change. (1 mark)
(d) Explain how the exchange rate change is likely to affect (i) Karvan's furniture exports and (ii) the cost, in KD, of a machine from Eltria. (3 marks)
(e) Calculate the tariff revenue that Karvan would raise from a 15% tariff on its 2024 machinery imports, assuming the quantity imported stays the same. (2 marks)
(f) Justify whether the government of Karvan should introduce the tariff on machinery. Use evidence from the information above. (5 marks)

Total for Question 6: 14 marks$mq$, $mq$(a) Exports = 480 + 300 + 220 = 1,000; imports = 520 + 410 + 130 = 1,060 [1]; balance = 1,000 - 1,060 = -60, a deficit of $60 million [1].
(b) 480 / 1,000 x 100 = 48% [1].
(c) 150 x 2.0 = 300 EC before; 150 x 1.6 = 240 EC after [1] (answer 240 EC).
(d) (i) The chair is now cheaper for buyers in Eltria (240 EC rather than 300 EC) [1], so the quantity demanded of Karvan's furniture is likely to rise and export volumes increase [1]. (ii) A machine costs 24,000 / 1.6 = 15,000 KD instead of 24,000 / 2.0 = 12,000 KD, so imports of machinery become more expensive for Karvan [1].
(e) 520 x 0.15 [1] = $78 million [1].
(f) Level-based, 5 marks. Indicative content: for the tariff: raises $78 million, more than the $60 million deficit; protects local machine makers (if any); machines are already dearer after depreciation, so imports may fall anyway. Against: furniture (48% of exports) relies on Eltrian machines, so the tariff raises their costs by a further 15% on top of the 25% rise from depreciation (15,000 KD to about 17,250 KD per machine) and could cut export competitiveness; Eltria may retaliate with tariffs on Karvan's furniture; if the quantity imported falls, revenue will be below $78 million; consumers/firms bear the cost. Mark bands: 1 to 2 marks for a decision with one relevant point and little use of data; 3 to 4 marks for a clear decision with two or more developed points using figures from the stimulus; 5 marks for balanced weighing of both sides, specific data, and a justified conclusion that addresses a limitation (e.g. revenue may fall, retaliation risk). Total for part (f) [5].$mq$, $mq$A$mq$),
(7, $mq$[[Q 7 | A 3 | C 7]]
The table compares two developing countries, Hallan and Orsik.

Indicator: Hallan / Orsik
Population (millions): 24 / 8
GDP per capita (US dollars): 3,200 / 11,800
Life expectancy at birth (years): 64 / 76
Adult literacy rate (%): 71 / 96
Infant deaths per 1,000 live births: 48 / 9
Share of workers in agriculture (%): 58 / 9
Internet users (% of population): 22 / 85

(a) Calculate the total GDP of each country, in billions of US dollars. (2 marks)
(b) Calculate how many times greater Orsik's GDP per capita is than Hallan's, to one decimal place. (1 mark)
(c) Compare and contrast Hallan and Orsik, using at least three indicators from the table. (3 marks)
(d) Explain why GDP per capita alone is an incomplete measure of a country's development. (2 marks)
(e) Suggest one policy the government of Hallan could use to raise literacy, and explain how it could help economic growth. (2 marks)

Total for Question 7: 10 marks$mq$, $mq$(a) Hallan: 3,200 x 24 million = $76.8 billion [1]; Orsik: 11,800 x 8 million = $94.4 billion [1].
(b) 11,800 / 3,200 = 3.7 times (3.6875) [1].
(c) Up to 3, for comparison using data from at least three indicators: income, e.g. Orsik is richer per person (11,800 vs 3,200) [1]; health or education, e.g. life expectancy 76 vs 64, infant deaths 9 vs 48, literacy 96% vs 71% [1]; a further indicator or a contrast in structure, e.g. 58% of Hallan's workers are in agriculture vs 9% in Orsik, internet use 85% vs 22%, or Hallan has three times the population but a lower total GDP [1]. Lists with no comparison earn a maximum of 1.
(d) GDP per capita is an average and does not show how income is distributed / inequality [1]; it ignores non-income factors such as health, education, environment and quality of life (e.g. Hallan's infant mortality) [1]. Accept informal economy or unpaid work not counted.
(e) Policy, e.g. build more schools / train teachers / provide free primary education / school meals to encourage attendance [1]; more literate workers are more productive and can use technology, raising output and growth (and attracting investment) [1].$mq$, $mq$C$mq$),
(8, $mq$[[Q 8 | A 3 | B 2 | C 2 | D 5]]
Conceptual link: sustainability. Global context: globalization and sustainability.

Westmark is a coastal town of 18,000 people that depends on fishing. A foreign company, Oceanic Foods Ltd, has asked the town council for permission to build a large fish-processing factory. Study Sources D, E and F.

Source D: Council report on the proposed factory.
Indicator: Now / Expected in five years if the factory opens
Jobs in fishing and fish processing: 640 / 1,040
Average monthly wage in these jobs ($): 1,150 / 1,300
Annual fish catch (tonnes): 9,500 / 14,000
Maximum sustainable catch estimated by marine scientists (tonnes per year): 11,000 / 11,000
Annual value of fish exports ($ millions): 38 / 61

Source E: Statement from the Westmark Fishers' Cooperative.
"Our families have fished these waters for generations. The scientists tell us the sea can give about 11,000 tonnes a year without the stocks collapsing. A factory that needs more fish than that will not employ our children for long, because there will be nothing left to catch. We want jobs, but we want jobs that last."

Source F: Statement from Oceanic Foods Ltd.
"We will invest $45 million in Westmark, creating 400 new jobs paying above the local average, and we will help the town sell its fish in international markets. Our plan assumes a local catch of up to 14,000 tonnes a year, but if the local catch is limited we can also buy fish from fleets in other countries to keep the factory running."

Using Sources D, E and F and your own economic knowledge, evaluate whether Westmark Town Council should approve the factory. In your answer you should: use data from Source D; refer to Sources E and F, commenting on their origin or purpose; consider economic, social and environmental effects; and reach a justified conclusion. (12 marks)

Total for Question 8: 12 marks$mq$, $mq$This is an extended response. Marks are awarded by criterion: A (knowing and understanding) [3], B (investigating, use and evaluation of sources) [2], C (communicating) [2], D (thinking critically) [5].

Indicative content (data checked): jobs rise by 400, from 640 to 1,040, an increase of 62.5%; average monthly wage rises from $1,150 to $1,300, up 13.0%; the monthly wage bill rises from about $0.74 million to about $1.35 million (annual $8.8 million to $16.2 million); export value rises from $38 million to $61 million, up 60.5%; the expected catch of 14,000 tonnes is 3,000 tonnes (27.3%) above the sustainable maximum of 11,000, while today's 9,500 tonnes is 86.4% of it, so the town currently fishes sustainably but would not with the factory.
Knowledge (A): opportunity cost; short-run vs long-run benefits; common resource / overfishing (stocks depleted, future income lost); multiplier effect on local spending; foreign investment and globalization (profits may leave the town; dependence on one employer); sustainable development.
Sources (B): Source D is a council report (official, numerical, but the 14,000 figure is a forecast and the author's purpose is to inform a decision); Source E is from fishers with a vested interest in protecting their livelihoods, but is backed by scientific estimates; Source F is from the company, which wants approval, offers imported fish as a fall-back (which would remove the overfishing risk but reduce local benefit and raise costs) and gives no guarantee of the 400 jobs lasting.
Evaluation (D): weighing short-term benefits (jobs, wages, export income) against long-term risk (stock collapse would end both the factory and traditional fishing); possible conditions (approve with a catch quota of 11,000 tonnes, use imported fish for the rest, local hiring targets); a decision should be supported by data and recognise uncertainty.

Level descriptors. Criterion A (3 marks): 1 mark - limited, mainly descriptive economic knowledge; 2 marks - relevant concepts used with some accuracy (e.g. opportunity cost, sustainability, exports); 3 marks - accurate, wide-ranging use of terminology and concepts across economic, social and environmental effects. Criterion B (2 marks): 1 mark - uses the sources but with little comment on origin or purpose; 2 marks - uses data from Source D and evaluates the origin, purpose, value or limitation of at least one of Sources E and F. Criterion C (2 marks): 1 mark - some structure, basic terminology; 2 marks - clear, logical structure with a conclusion and consistent use of appropriate terms and accurate figures. Criterion D (5 marks): 1 to 2 marks - one-sided or unsupported judgement; 3 to 4 marks - considers both benefits and costs with some supporting evidence and a judgement; 5 marks - balanced, well-supported evaluation that weighs short-term against long-term effects, recognises limits of the evidence (forecasts, bias) and reaches a justified, possibly conditional, conclusion.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);
commit;
