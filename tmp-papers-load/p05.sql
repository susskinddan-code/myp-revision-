begin;
-- History MYP 5 eAssessment Paper C (7 tasks, 65 marks) (65 marks)
with sub as (select id from public.subjects where slug = $mq$history$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$History MYP 5 eAssessment Paper C (7 tasks, 65 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$History MYP 5 eAssessment Paper C (7 tasks, 65 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: The Aztec Empire and the Spanish conquest.

Source A: a timeline of selected events (compiled for this paper)
1325: The Mexica found the city of Tenochtitlan on an island in Lake Texcoco.
1519: Hernan Cortes lands on the coast of Mexico with about 500 Spanish soldiers.
1519: Cortes enters Tenochtitlan and meets the ruler Moctezuma II.
1520: An epidemic of smallpox spreads through central Mexico.
1521: Spanish soldiers and thousands of Indigenous allies capture Tenochtitlan.

(a) Show that 196 years passed between the founding of Tenochtitlan and its capture by the Spanish. (1 mark)

(b) Describe how the Aztec Empire used tribute. (2 marks)

(c) Explain why a small Spanish force was able to defeat the Aztec Empire. (3 marks)

(d) Explain one consequence of the fall of Tenochtitlan for the people of central Mexico. (2 marks)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] 1521 - 1325 = 196 (the subtraction must be shown).
(b) [1] Conquered peoples had to send regular payments of goods, e.g. cotton cloth, cacao, feathers, food or gold, to Tenochtitlan. [1] Tribute supported the capital and its rulers and priests; peoples who refused could be attacked, which created resentment.
(c) [1] Indigenous allies, such as the Tlaxcalans, who resented Aztec tribute, supplied tens of thousands of warriors. [1] Spanish steel weapons, armour, horses and guns gave them military advantages in some battles. [1] Diseases such as smallpox killed many Aztecs and weakened their leaders and armies. Accept other accurate, developed reasons, e.g. the Aztecs' uncertainty about how to respond to the Spanish.
(d) [1] The Aztec Empire ended and Spanish colonial rule began (the city became the basis of New Spain's capital, Mexico City). [1] Developed, e.g. Indigenous people were forced to pay tribute and work for Spanish landowners, and Catholicism was imposed in place of traditional religion.$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 3 | B 4 | D 3]]
Task 2: Abolition in the British Empire.

Source B: facts about the Slavery Abolition Act (compiled for this paper)
The Act was passed by Parliament in August 1833 and came into force on 1 August 1834. In the colonies, formerly enslaved children under six were freed, but most adults were made to work for their former owners as unpaid apprentices for several more years. The government paid about 20 million pounds in compensation to the owners. The formerly enslaved people received no compensation.

Source C: petitions against slavery presented to the House of Commons (invented figures for this paper; not real statistics)
Year: 1830, 1831, 1832, 1833
Petitions: 200; 600; 1,200; 5,000

(a) State two facts from Source B about the Slavery Abolition Act. (2 marks)

(b) How many times larger was the number of petitions in 1833 than in 1830? (1 mark)

(c) Describe the trend shown in Source C. (2 marks)

(d) Using Source B, explain what the Act suggests about the attitudes of Parliament in 1833 towards slave owners and towards enslaved people. (3 marks)

(e) Explain one limitation of Source C as evidence of public opinion about slavery in Britain. (2 marks)

Total for Question 2: 10 marks$mq$, $mq$(a) [1] First accurate fact from the source (e.g. it came into force on 1 August 1834; owners received about 20 million pounds). [1] A second accurate and different fact (e.g. adults had to work as apprentices; the formerly enslaved received no compensation).
(b) [1] 5,000 / 200 = 25 times larger.
(c) [1] The number of petitions rose every year. [1] The increase became sharper in 1833 (1,200 to 5,000), the year the Act was passed.
(d) [1] Parliament accepted that owners had a right to be paid for losing their property. [1] The enslaved were given no compensation, and adults had to work as apprentices, which suggests their freedom and welfare were treated as less important. [1] Overall judgement or inference, e.g. it suggests Parliament wanted to end slavery without harming the interests of wealthy owners.
(e) [1] Counting petitions does not tell us how many people signed each one or who they were. [1] Not everyone could sign or take part (for example, the figures are invented and there were few voters), so the numbers may not reflect public opinion. Accept other developed limitations.$mq$, $mq$B$mq$),
(3, $mq$[[Q 3 | B 7 | D 3]]
Task 3: Science and society: the radium craze.

Background: In 1898 Marie and Pierre Curie announced the discovery of two new elements, polonium and radium. Radium gave out invisible radiation. In the years that followed some businesses sold products said to contain radium. The sources below are imagined and written for this paper.

Source D: a newspaper advertisement (imagined, 1925)
"RADIOLUX Tonic Water. Contains genuine radium, the wonder element of science! Revives the tired, strengthens the weak and restores youth. Doctors are astonished. One bottle a day, and feel the glow of health. Sold in all good chemists at one shilling."

Source E: an extract from a medical journal (imagined, written for this paper by a fictional doctor, 1932)
"In the last two years I have treated patients who drank large amounts of radium-containing tonics. The damage to their bones is severe, and recovery is unlikely. The public have been misled by sellers who claim that radium is a harmless health aid. I urge the authorities to ban such products."

(a) Identify the origin and the purpose of Source D. (2 marks)

(b) Explain one way in which Source D is valuable to a historian studying public attitudes to new scientific discoveries in the 1920s. (3 marks)

(c) Explain one limitation of Source E. (2 marks)

(d) How far do Sources D and E show that attitudes to radium changed between 1925 and 1932? Use both sources. (3 marks)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] Origin: a newspaper advertisement for a product called Radiolux, published in 1925. [1] Purpose: to persuade people to buy the tonic by claiming health benefits and linking it to the excitement of scientific discovery.
(b) [1] A valid value, e.g. it shows that radium was seen by many as exciting and beneficial. [1] Explained with the content or purpose, e.g. companies used words such as wonder element and doctors are astonished because they expected the public to trust science. [1] Developed, e.g. the advert shows how little the public knew about radiation dangers then.
(c) [1] A valid limitation, e.g. it is the view of one doctor who treated a small number of patients. [1] Developed, e.g. he is campaigning for a ban and may select the worst cases; the extract does not show how common the injuries were.
(d) [1] Source D shows enthusiastic, uncritical belief in radium's powers. [1] Source E shows growing awareness of the harm and calls for regulation. [1] A supported judgement, e.g. attitudes did change among doctors, but D and E come from different people with different purposes, so they cannot show how the general public thought.$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 10]]
Task 4: Planning an investigation: the League of Nations.

A student is investigating how effective the League of Nations was in the 1930s. Some facts he has found:
- In September 1931 Japanese soldiers took control of Manchuria, a region of China.
- The League sent a commission, led by Lord Lytton, which reported in 1932 that Japan had acted wrongly.
- In 1933 Japan left the League. The League had no army of its own and members did not agree on sanctions.

He has found three sources:
Source F: the report of the League's commission, 1932.
Source G: an editorial in a Japanese newspaper, 1932.
Source H: a history textbook published in 2015.

(a) Write a research question and identify two key terms in it that the student should define before he starts his research. (3 marks)

(b) Describe two lines of enquiry the student should follow to answer his question. (2 marks)

(c) Choose the source (F, G or H) that would be most useful for finding out why the League failed to stop Japan. Explain your choice, referring to the origin of the source and to one limitation of it. (3 marks)

(d) Explain why it is important for the student to reference all of his sources in his final report. (2 marks)

Total for Question 4: 10 marks$mq$, $mq$(a) [1] A clear, focused research question (e.g. How effective was the League of Nations in dealing with the Manchurian crisis of 1931 to 1933?). [1] A first key term to define (e.g. effective, sanctions). [1] A second key term to define, with an explanation of why it needs defining.
(b) [1] One valid line of enquiry (e.g. what actions the League took). [1] A second line of enquiry that is different (e.g. why the League could not enforce its decisions / how members voted).
(c) [1] A source is chosen with a reasoned link to the question (e.g. H, because a modern textbook can use many sources and summarise the causes of failure). [1] Reference to the source's origin, e.g. H was written long after the events by a historian who has had access to evidence. [1] A limitation is identified (e.g. a textbook is secondary, so it depends on the author's interpretation; F is an official report so may avoid blaming members).
(d) [1] So readers can check where evidence came from and judge its reliability. [1] It gives credit to the original authors and avoids passing off other people's work as his own (plagiarism).$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | A 2 | C 6]]
Task 5: The Berlin Wall.

Background: After the Second World War, Germany was divided. Berlin lay inside East Germany but was itself divided into East and West. On 13 August 1961 East German soldiers began to close the border in Berlin with barbed wire, and a concrete wall followed. The border was opened on 9 November 1989.

(a) State two reasons why the East German government built the Berlin Wall. (2 marks)

(b) Write a museum label of about 100 words for an exhibition on the Berlin Wall. Your label should explain why it was built and how it affected the people of Berlin. Marks are given for your knowledge and for how clearly and appropriately you communicate to a museum visitor. (6 marks)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] To stop skilled and educated East Germans leaving for the West through Berlin (the loss of workers). [1] To stop the growing embarrassment of people choosing life in the West, or to strengthen control and prevent Western influence. Accept other accurate reasons.
(b) [1] Accurate account of why the wall was built (date 13 August 1961; to stop people leaving East Germany). [1] Accurate account of the effect on families and daily life (families separated, crossing points restricted, people killed trying to escape). [1] A link to the wider Cold War, e.g. it became a symbol of the division of Europe or tension between the superpowers. [1] Includes a relevant fact or detail (e.g. the wall stood until 9 November 1989; Checkpoint Charlie). [1] Communication: clear, concise language suited to a general audience, with a suitable title or opening. [1] Communication: logical order and accurate use of terms (e.g. East Germany, communist, border, Cold War).$mq$, $mq$C$mq$),
(6, $mq$[[Q 6 | D 7]]
Task 6: Algeria and decolonisation.

Background: France ruled Algeria from 1830 and treated it as part of France. A war for independence began in 1954 when the National Liberation Front (FLN) launched attacks. In March 1962 France and the FLN agreed a ceasefire (the Evian Accords). Algerian voters supported independence in a referendum, and independence was declared in July 1962.

Source G: an extract from a letter (imagined, written for this paper by a French farmer in Algeria, 1961)
"My family has farmed this land for three generations. We built the roads and planted the vines. Now they say we must leave. Our home is here, and no government in Paris has the right to give it away to terrorists who burn and murder."

Source H: an extract from a leaflet (imagined, written for this paper by an FLN supporter, 1956)
"For more than a century our land has been taken and our people treated as strangers in our own country. We do not choose violence for its own sake. When every peaceful request is refused, a people must fight for the right to rule itself."

(a) Identify two differences in the views of Source G and Source H. (2 marks)

(b) Explain why the authors of Sources G and H had such different views. (2 marks)

(c) Violence was the main reason Algeria won independence. How far do you agree? Use the sources and your own knowledge. (3 marks)

Total for Question 6: 7 marks$mq$, $mq$(a) [1] Source G sees Algeria as the French settlers' home, while Source H sees it as land taken from Algerians. [1] Source G calls the FLN terrorists, while Source H presents violence as a last resort in a fight for self-rule.
(b) [1] The authors had different experiences: a settler with property to lose and an Algerian who had faced discrimination. [1] Their purposes differed: G is a private defence of settler rights, while H is a leaflet written to recruit supporters and justify the fight.
(c) [1] A supported point for the claim (e.g. the long war from 1954 to 1962 cost France heavily and made it unpopular at home). [1] A supported point for other factors (e.g. international pressure at the United Nations; the decision of de Gaulle's government to negotiate; the loss of French public support). [1] A balanced judgement on the claim, e.g. violence mattered because it forced negotiation, but political pressure decided the timing and form of independence.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | C 2 | D 10]]
Task 7: Daily life: extended response.

Statement: Between 1800 and 2000, new technology did more than war to change the daily lives of ordinary people.

Evaluate this statement. Use specific examples that you have studied, such as railways, electricity, antibiotics, the telephone, computers and the internet, or the effects of the two world wars. You should:
- explain how technology changed daily life,
- explain how war changed daily life,
- reach a supported judgement.

(a) Evaluate the statement. Your answer will be marked for your knowledge and evaluation (10 marks) and for the quality of your communication (2 marks). (12 marks)

Total for Question 7: 12 marks$mq$, $mq$(a) [1] Technology is explained with a precise example (e.g. railways shortened journey times, allowed cheaper goods, and let people live far from their work). [1] A second technology example with a developed effect (e.g. electricity brought lighting and household machines; antibiotics from the 1940s reduced deaths from infection). [1] Recognition of unequal effects or limits of technology (e.g. rich people and towns benefited first; some groups lost jobs). [1] War is explained with a precise example (e.g. rationing and the rise of women's war work in the world wars; conscription). [1] A developed point about the longer-term impact of war (e.g. the creation of welfare systems after 1945; war advanced technologies such as radar and penicillin production). [1] Recognition of the limit or temporary nature of some effects of war (e.g. many wartime changes ended with peace). [1] Links between war and technology are considered (e.g. wartime research led to inventions that changed daily life). [1] The scale of change is compared (e.g. how many people were affected and for how long). [1] A clear judgement about which had more impact. [1] The judgement is supported by weighing the evidence, not just listing it. [1] Communication: a clear introduction, structured paragraphs and a conclusion. [1] Communication: accurate vocabulary and precise facts (dates, names, places).$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- French ab initio MYP 5 eAssessment Paper A (7 tasks, 64 marks) (64 marks)
with sub as (select id from public.subjects where slug = $mq$french-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French ab initio MYP 5 eAssessment Paper A (7 tasks, 64 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French ab initio MYP 5 eAssessment Paper A (7 tasks, 64 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: Listening - identity and culture. Chloé introduces herself in a voice message.
Listening. [Audio transcript - read twice] Read the transcript, then answer in English.

Message vocal de Chloé :
« Bonjour, je m'appelle Chloé Martin. J'ai quinze ans et j'habite à Lyon avec ma mère, mon père et mon petit frère. Il s'appelle Hugo et il a sept ans. Mes grands-parents habitent en Italie. Je suis grande et j'ai les cheveux longs et noirs. J'adore le sport : je joue au basket le mardi et je fais de la natation le samedi. Pour mon anniversaire, le vingt mars, je voudrais un nouveau téléphone. Ma fête préférée est Noël, parce que toute la famille mange ensemble. »

(a) How old is Chloé? (1 mark)
(b) Who is Hugo? (1 mark)
(c) Where do Chloé's grandparents live? (1 mark)
(d) Describe Chloé's hair. (2 marks)
(e) Which two sports does Chloé do? (2 marks)
(f) What does she want for her birthday? (1 mark)

Total for Question 1: 8 marks$mq$, $mq$[1] 15 / fifteen
[1] Her little brother
[1] In Italy
[1] Long
[1] Black
[1] Basketball
[1] Swimming
[1] A new (mobile) phone$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Task 2: Listening - education and work. Two friends talk after school.
Listening. [Audio transcript - read twice] Read the transcript, then answer in English.

Sophie : Salut Paul ! Tu as cours de maths aujourd'hui ?
Paul : Oui, à dix heures. Mais je n'aime pas les maths. Je préfère l'histoire, parce que le professeur est amusant.
Sophie : Moi, j'adore les sciences. Plus tard, je voudrais être médecin.
Paul : Ah bon ? Moi, je voudrais être journaliste. Mon oncle travaille pour un journal à Paris.
Sophie : Qu'est-ce que tu fais ce week-end ?
Paul : Je travaille dans le café de ma tante le samedi matin. Je gagne dix euros par heure.
Sophie : Dix euros ! C'est bien. Moi, je fais mes devoirs à la bibliothèque.
Paul : On mange à la cantine à midi ?
Sophie : D'accord, à midi et demi.

(a) At what time is Paul's maths lesson? (1 mark)
(b) Why does Paul prefer history? (1 mark)
(c) What job would Sophie like to do? (1 mark)
(d) What job would Paul like to do? (1 mark)
(e) Where does Paul's uncle work? (1 mark)
(f) Where does Paul work on Saturday morning? (1 mark)
(g) How much does Paul earn per hour? (1 mark)
(h) At what time will they eat in the canteen? (1 mark)

Total for Question 2: 8 marks$mq$, $mq$[1] 10 am / ten o'clock
[1] The teacher is funny / amusing
[1] Doctor
[1] Journalist
[1] For a newspaper in Paris (accept 'in Paris')
[1] In his aunt's café
[1] 10 euros
[1] 12.30 / half past twelve$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
Task 3: Listening - local area, travel and tourism. A tourist office announcement.
Listening. [Audio transcript - read twice] Read the transcript, then answer in English.

« Bonjour à tous et bienvenue à Annecy ! Voici les informations pour aujourd'hui. Il fait beau, mais il y a du vent. La température est de vingt-deux degrés. Le château ouvre à neuf heures et ferme à dix-sept heures. L'entrée coûte six euros pour les adultes et c'est gratuit pour les enfants de moins de douze ans. Pour visiter le lac, vous pouvez louer un vélo ou prendre un bateau. Le bateau part du port à quinze heures. Il y a aussi un marché dans le centre-ville : il est ouvert le matin seulement. Pour le déjeuner, nous recommandons le restaurant « Chez Léa », à côté de la bibliothèque. Bonne journée ! »

(a) Give two details about today's weather. (2 marks)
(b) At what time does the castle close? (1 mark)
(c) Who can enter the castle for free? (1 mark)
(d) How can visitors explore the lake? (2 marks)
(e) At what time does the boat leave? (1 mark)
(f) When is the market open? (1 mark)

Total for Question 3: 8 marks$mq$, $mq$[1] Fine / nice weather (accept sunny)
[1] Windy (accept 22 degrees)
[1] 5 pm / 17:00
[1] Children under 12
[1] Rent a bike
[1] Take a boat
[1] 3 pm / 15:00
[1] In the morning only$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 8]]
Task 4: Reading - three short texts.
Texte 1 - Affiche du collège
CLUB DE THÉÂTRE. Nouveau ! Tous les jeudis de 16 h à 17 h 30, salle 12. Pas besoin d'expérience. Premier cours gratuit. Inscription chez Madame Roux.

Texte 2 - Message
« Salut Amir ! Je suis à la gare, mais mon train a vingt minutes de retard. Je serai chez toi vers sept heures. Peux-tu acheter du pain ? Merci ! Inès »

Texte 3 - Annonce
Appartement à louer. Deux chambres, un salon, une cuisine moderne. Près du métro et des magasins. Pas d'animaux. 650 euros par mois.

(a) On which day does the theatre club meet? (1 mark)
(b) At what time does the club finish? (1 mark)
(c) What experience do you need? (1 mark)
(d) Where is Inès? (1 mark)
(e) Why will she be late? (1 mark)
(f) What does she ask Amir to buy? (1 mark)
(g) Give one thing that is not allowed in the flat and the cost per month. (2 marks)

Total for Question 4: 8 marks$mq$, $mq$[1] Thursday
[1] 5.30 pm / 17:30
[1] None / no experience needed
[1] At the station
[1] Her train is 20 minutes late
[1] Bread
[1] Pets / animals
[1] 650 euros$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | B 12]]
Task 5: Reading - technology and media.
Ma vie avec mon téléphone, par Julie, 16 ans

Je me réveille à sept heures et la première chose que je fais, c'est regarder mon téléphone. Je lis mes messages et je regarde des vidéos de musique. Avant, je passais cinq heures par jour sur les réseaux sociaux, mais c'était trop. Maintenant, je limite mon temps à deux heures. Mes parents ont installé une application qui coupe internet à vingt-deux heures.

Mon téléphone est utile : je cherche des informations pour mes devoirs et j'apprends l'anglais avec une application. Mais il y a des dangers. Un jour, un inconnu m'a écrit un message bizarre et j'ai eu peur. Maintenant, je ne parle jamais à des personnes que je ne connais pas.

Le dimanche, je laisse mon téléphone dans ma chambre et je sors avec mes amis. Nous jouons au football ou nous faisons un pique-nique. C'est mieux pour la santé !

(a) What does Julie do first every morning? (1 mark)
(b) How much time did Julie spend on social media before, and how much now? (2 marks)
(c) What does the app installed by her parents do, and when? (2 marks)
(d) Give two ways in which the phone helps Julie. (2 marks)
(e) Why was Julie afraid one day? (1 mark)
(f) What rule does she follow now? (1 mark)
(g) Name two things she does with friends on Sundays. (2 marks)
(h) Find the French word in the text that means 'strange'. (1 mark)

Total for Question 5: 12 marks$mq$, $mq$[1] She looks at her phone
[1] Before: five hours a day
[1] Now: two hours a day
[1] Cuts / switches off the internet
[1] At 10 pm / 22:00
[1] Finds information for homework
[1] Learns English with an app
[1] A stranger sent her a strange message
[1] She never talks to people she does not know
[1] Plays football
[1] Has a picnic
[1] bizarre$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 8]]
Task 6: Writing a postcard.
You are on holiday near your French friend Léo's town. Write a postcard to Léo in French of about 40 to 50 words. Include:
- where you are
- what the weather is like
- what you did yesterday
- one thing you plan to do tomorrow

Write your postcard. (8 marks)

Total for Question 6: 8 marks$mq$, $mq$Content (4 marks): one mark for each required point communicated clearly.
[1] Says where they are
[1] Describes the weather
[1] Says what they did yesterday (past tense expected)
[1] Gives one plan for tomorrow (future or 'aller' + infinitive)
Language (4 marks):
[1] Vocabulary is appropriate and mostly accurate
[1] Verb forms (and tense where required) are mostly correct
[1] Uses simple connectors or varied sentence patterns, not only isolated phrases
[1] Accents, agreement and spelling are mostly correct (for example é/è, à/a, le/la)
Example: Cher Léo, je suis à Nice. Il fait beau et chaud. Hier, j'ai visité le vieux port et j'ai mangé une glace. Demain, je vais nager à la plage. À bientôt !$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | C 12]]
Task 7: Writing an article.
Your school's French club is making a magazine called « Mon école idéale ». Write an article in French of about 80 to 100 words. Include:
- a description of your school now (for example subjects or uniform)
- what you like and dislike, with reasons
- the job you would like to do in the future, and why
- one change you would make at your school

Write your article. (12 marks)

Total for Question 7: 12 marks$mq$, $mq$Content (4 marks): one mark for each required point, developed with a detail or reason where asked.
[1] Describes the school or subjects
[1] States likes and dislikes with a reason
[1] Names a future job and gives a reason
[1] Suggests one change at school
Range of language (4 marks):
[1] A variety of vocabulary relevant to the topic
[1] Gives at least one opinion with a reason
[1] Uses more than one tense or time reference correctly
[1] Uses connectors to link ideas (for example the equivalents of 'and', 'but', 'because', 'then')
Accuracy (4 marks):
[1] Verb forms are mostly correct
[1] Agreement (gender and plural of nouns and adjectives) is mostly correct
[1] Spelling is mostly correct
[1] The message is clear throughout and the length is appropriate (a text far below the length cannot score this mark)$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

-- French ab initio MYP 5 eAssessment Paper B (7 tasks, 64 marks) (64 marks)
with sub as (select id from public.subjects where slug = $mq$french-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French ab initio MYP 5 eAssessment Paper B (7 tasks, 64 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French ab initio MYP 5 eAssessment Paper B (7 tasks, 64 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: Listening - the world we live in. The headteacher talks about school and the environment.
Listening. [Audio transcript - read twice] Read the transcript, then answer in English.

« Bonjour à tous. Je suis Madame Dubois, la directrice. Notre collège veut devenir plus écologique. Depuis septembre, nous avons trois poubelles dans chaque classe : une pour le papier, une pour le plastique et une pour les autres déchets. Chaque matin, des élèves de quatrième vérifient les poubelles. Nous avons aussi un jardin derrière le gymnase. Les élèves y plantent des légumes, et ils les mangent à la cantine. Vendredi prochain, c'est la journée sans voiture : venez au collège à pied ou à vélo ! Un élève de chaque classe gagnera un livre sur la nature. Merci de votre aide. »

(a) Who is speaking? (1 mark)
(b) What are the three bins in each classroom for? (3 marks)
(c) Who checks the bins every morning? (1 mark)
(d) Where is the school garden? (1 mark)
(e) What happens to the vegetables from the garden? (1 mark)
(f) How are students asked to come to school on the car-free day? (1 mark)

Total for Question 1: 8 marks$mq$, $mq$[1] The headteacher (Madame Dubois)
[1] Paper
[1] Plastic
[1] Other waste
[1] Students in year 4 ('quatrième')
[1] Behind the gym
[1] They are eaten in the canteen
[1] On foot or by bike$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Task 2: Listening - identity and culture. Two friends talk about the weekend.
Listening. [Audio transcript - read twice] Read the transcript, then answer in English.

Zoé : Salut Karim ! Tu as passé un bon week-end ?
Karim : Oui, très bon ! Samedi, c'était l'anniversaire de ma grand-mère. Elle a soixante-dix ans.
Zoé : Super ! Qu'est-ce que vous avez fait ?
Karim : Toute la famille est venue chez nous. Mon père a préparé un couscous, et ma tante a apporté un grand gâteau au citron.
Zoé : Miam ! Et tu as offert un cadeau ?
Karim : Oui, un album de photos de la famille. Elle l'a adoré. Et toi, ton week-end ?
Zoé : Moi, j'ai regardé un film à la maison avec ma sœur. C'était ennuyeux.
Karim : Dommage ! Dimanche, on peut aller au cinéma ensemble ?
Zoé : Oui, bonne idée. Le film commence à quinze heures.

(a) Whose birthday was it on Saturday? (1 mark)
(b) How old is she? (1 mark)
(c) Where did the family meet? (1 mark)
(d) What did Karim's father cook? (1 mark)
(e) What did Karim's aunt bring? (1 mark)
(f) What present did Karim give? (1 mark)
(g) What did Zoé think of the film she watched at home? (1 mark)
(h) At what time does the film start on Sunday? (1 mark)

Total for Question 2: 8 marks$mq$, $mq$[1] Karim's grandmother
[1] 70 / seventy
[1] At Karim's house
[1] Couscous
[1] A (big) lemon cake
[1] A family photo album
[1] Boring
[1] 3 pm / 15:00$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
Task 3: Listening - technology and media. A radio programme.
Listening. [Audio transcript - read twice] Read the transcript, then answer in English.

« Bienvenue sur Radio Jeunes ! Voici le programme de la journée. À sept heures, « Le Réveil », avec de la musique et les nouvelles. À midi, notre émission sur la technologie : aujourd'hui, nous parlons des robots à l'école. Un professeur explique comment un robot aide les élèves à apprendre les langues. À seize heures, un jeu : vous pouvez gagner deux places pour un concert. Pour participer, envoyez un message sur notre site internet avant seize heures. À vingt heures, le grand film de la soirée est une comédie française. »

(a) What can listeners hear at 7 am? (2 marks)
(b) What is the topic of the midday programme? (1 mark)
(c) What do the robots help students to do? (1 mark)
(d) What is the prize in the game? (1 mark)
(e) How can listeners take part? (1 mark)
(f) What is the deadline to take part? (1 mark)
(g) What kind of film is on in the evening? (1 mark)

Total for Question 3: 8 marks$mq$, $mq$[1] Music
[1] News
[1] Robots at school (technology)
[1] Learn languages
[1] Two tickets for a concert
[1] Send a message on the website
[1] 4 pm / 16:00
[1] A French comedy$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 8]]
Task 4: Reading - two short texts.
Texte 1 - Météo
Demain à Marseille : le matin, il fait chaud, vingt-huit degrés, avec beaucoup de soleil. L'après-midi, il y a des orages. Le soir, il pleut et il fait frais.

Texte 2 - Offre d'emploi
Restaurant « Le Petit Port » cherche serveur ou serveuse. Vous travaillez le vendredi et le samedi soir, de dix-huit heures à vingt-deux heures. Vous aimez parler avec les gens ? Vous parlez anglais ? Envoyez votre CV à Monsieur Girard.

(a) What is the weather like tomorrow morning? (1 mark)
(b) What is the weather like in the afternoon? (1 mark)
(c) What is the weather like in the evening? (1 mark)
(d) What job is advertised? (1 mark)
(e) On which days would you work? (1 mark)
(f) At what time does work finish? (1 mark)
(g) Which language is useful for the job? (1 mark)
(h) Who should you send your CV to? (1 mark)

Total for Question 4: 8 marks$mq$, $mq$[1] Hot and sunny (accept either; 28 degrees)
[1] Storms
[1] Rainy and cool
[1] Waiter / waitress
[1] Friday and Saturday (both needed)
[1] 10 pm / 22:00
[1] English
[1] Monsieur Girard$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | B 12]]
Task 5: Reading - education and work.
Mon stage dans une boulangerie, par Thomas

La semaine dernière, j'ai fait un stage dans une boulangerie près de chez moi. Je suis arrivé à quatre heures et demie du matin, et c'était très tôt ! Le boulanger, Monsieur Petit, m'a montré comment faire le pain. J'ai mélangé la farine et l'eau, puis j'ai mis les baguettes dans le four. Après, j'ai aidé dans le magasin. J'ai vendu des croissants et j'ai parlé aux clients. Une dame âgée m'a dit : « Vous êtes très gentil ! » J'étais content.

Ce n'était pas facile. Je suis resté debout toute la journée et j'avais mal aux pieds. Mais j'ai appris beaucoup de choses. Je sais maintenant que le métier de boulanger est difficile, mais intéressant. Plus tard, je voudrais peut-être ouvrir ma propre boulangerie. Pour l'instant, je veux d'abord finir mes études.

(a) At what time did Thomas arrive at the bakery? (1 mark)
(b) What did Monsieur Petit show him? (1 mark)
(c) Give two things Thomas did when making the bread. (2 marks)
(d) What did Thomas sell? (1 mark)
(e) What did the old lady say to him? (1 mark)
(f) How did Thomas feel after this? (1 mark)
(g) Why did his feet hurt? (1 mark)
(h) What does Thomas now think of the baker's job? (2 marks)
(i) What might he do in the future? (1 mark)
(j) What does he want to do first? (1 mark)

Total for Question 5: 12 marks$mq$, $mq$[1] 4.30 am
[1] How to make bread
[1] Mixed flour and water
[1] Put the baguettes in the oven
[1] Croissants
[1] That he was very kind / nice
[1] Happy / pleased
[1] He stood all day
[1] Difficult
[1] Interesting
[1] Open his own bakery
[1] Finish his studies$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 8]]
Task 6: Writing an email.
Your French friend Camille has asked about technology in your life. Write an email in French of about 40 to 50 words. Include:
- what technology you use at home
- what you do online
- what you watched or listened to last weekend
- one question for Camille

Write your email. (8 marks)

Total for Question 6: 8 marks$mq$, $mq$Content (4 marks): one mark for each required point communicated clearly.
[1] Names technology used at home
[1] Says what they do online
[1] Says what they watched or listened to last weekend (past tense expected)
[1] Asks Camille one question
Language (4 marks):
[1] Vocabulary is appropriate and mostly accurate
[1] Verb forms (and tense where required) are mostly correct
[1] Uses simple connectors or varied sentence patterns, not only isolated phrases
[1] Accents, agreement and spelling are mostly correct (for example é/è, à/a, le/la)
Example: Salut Camille ! À la maison, j'utilise un ordinateur et un téléphone. Sur internet, je regarde des vidéos et je parle avec mes amis. Samedi, j'ai écouté de la musique. Et toi, tu aimes les jeux vidéo ?$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | C 12]]
Task 7: Writing a blog post.
A French website for young visitors wants blog posts about different towns. Write a blog post in French of about 80 to 100 words about your town or a place you know well. Include:
- a description of the place
- what tourists can do there
- how to travel there or get around
- a visit or trip you made there in the past, and your opinion of it

Write your blog post. (12 marks)

Total for Question 7: 12 marks$mq$, $mq$Content (4 marks): one mark for each required point, developed with a detail or reason where asked.
[1] Describes the town or place
[1] Says what tourists can do
[1] Gives information about transport
[1] Describes a past visit and gives an opinion
Range of language (4 marks):
[1] A variety of vocabulary relevant to the topic
[1] Gives at least one opinion with a reason
[1] Uses more than one tense or time reference correctly
[1] Uses connectors to link ideas (for example the equivalents of 'and', 'but', 'because', 'then')
Accuracy (4 marks):
[1] Verb forms are mostly correct
[1] Agreement (gender and plural of nouns and adjectives) is mostly correct
[1] Spelling is mostly correct
[1] The message is clear throughout and the length is appropriate (a text far below the length cannot score this mark)$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

-- Spanish ab initio MYP 5 eAssessment Paper A (7 tasks, 64 marks) (64 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish ab initio MYP 5 eAssessment Paper A (7 tasks, 64 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish ab initio MYP 5 eAssessment Paper A (7 tasks, 64 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: Listening - identity and culture. Daniel introduces himself in a voice message.
Listening. [Audio transcript - read twice] Read the transcript, then answer in English.

Mensaje de voz de Daniel:
« Hola, me llamo Daniel Ortega y tengo catorce años. Vivo en Valencia con mi madre y mi hermana mayor. Mi padre vive en Madrid. Mi hermana se llama Marta y tiene diecinueve años. Soy bajo y tengo el pelo corto y rubio. Mi pasatiempo favorito es tocar la guitarra. Toco todos los días después de las clases. El doce de mayo es mi cumpleaños y quiero comer paella con mis abuelos. Mi fiesta favorita son las Fallas, en marzo, porque hay música y fuegos artificiales. »

(a) How old is Daniel? (1 mark)
(b) Who does Daniel live with? (2 marks)
(c) Where does Daniel's father live? (1 mark)
(d) Describe Daniel's hair. (2 marks)
(e) What is his favourite hobby? (1 mark)
(f) In which month are the Fallas? (1 mark)

Total for Question 1: 8 marks$mq$, $mq$[1] 14 / fourteen
[1] His mother
[1] His older sister
[1] In Madrid
[1] Short
[1] Blond(e)
[1] Playing the guitar
[1] March$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Task 2: Listening - education and work. Two friends talk at school.
Listening. [Audio transcript - read twice] Read the transcript, then answer in English.

Clara: Hola, Pablo. ¿Qué tienes ahora?
Pablo: Tengo clase de inglés a las nueve y media. Después tengo educación física.
Clara: ¡Qué bien! A mí no me gusta el inglés, pero me encanta la informática.
Pablo: A mí me gustan las ciencias. Quiero ser ingeniero, como mi tío.
Clara: Yo quiero ser veterinaria porque me gustan mucho los animales. Los fines de semana trabajo en una tienda de mascotas.
Pablo: ¿Cuánto ganas?
Clara: Gano cinco euros por hora. No es mucho, pero es divertido.
Pablo: ¿Comemos juntos en el comedor?
Clara: Sí, a la una y cuarto.

(a) At what time is Pablo's English lesson? (1 mark)
(b) Which lesson does Pablo have after English? (1 mark)
(c) Which subject does Clara love? (1 mark)
(d) What does Pablo want to be? (1 mark)
(e) Why does Clara want to be a vet? (1 mark)
(f) Where does Clara work at weekends? (1 mark)
(g) How much does Clara earn per hour? (1 mark)
(h) At what time will they have lunch? (1 mark)

Total for Question 2: 8 marks$mq$, $mq$[1] 9.30 / half past nine
[1] PE / physical education
[1] IT / computing
[1] An engineer
[1] She likes animals a lot
[1] In a pet shop
[1] 5 euros
[1] 1.15 / quarter past one$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
Task 3: Listening - local area, travel and tourism. A guide speaks to visitors.
Listening. [Audio transcript - read twice] Read the transcript, then answer in English.

« Buenos días y bienvenidos a Toledo. Hoy hace sol por la mañana, pero por la tarde hay tormentas. La catedral abre a las diez y cierra a las seis. La entrada cuesta ocho euros para los adultos y es gratis para los niños menores de diez años. Para ver la ciudad, pueden hacer una visita en autobús turístico o caminar con un guía. El autobús sale de la plaza principal a las doce. Hay un mercado en la calle Real los sábados por la mañana. Para comer, recomendamos el restaurante « La Plaza », que está al lado del museo. ¡Disfruten de su visita! »

(a) What will the weather be like in the morning and in the afternoon? (2 marks)
(b) At what time does the cathedral close? (1 mark)
(c) Who can enter the cathedral for free? (1 mark)
(d) Give two ways to see the city. (2 marks)
(e) Where does the bus leave from? (1 mark)
(f) On which day is the market? (1 mark)

Total for Question 3: 8 marks$mq$, $mq$[1] Morning: sunny
[1] Afternoon: storms
[1] 6 pm / 18:00
[1] Children under 10
[1] Tourist bus tour
[1] Walking with a guide
[1] The main square
[1] Saturday (morning)$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 8]]
Task 4: Reading - three short texts.
Texto 1 - Cartel del instituto
CLUB DE AJEDREZ. ¿Quieres aprender? Todos los martes de 15:00 a 16:30 en el aula 8. No necesitas experiencia. La primera clase es gratis. Habla con el profesor Gómez.

Texto 2 - Mensaje
« Hola, Lucía. Estoy en la estación, pero mi tren llega con treinta minutos de retraso. Estaré en tu casa a las siete. ¿Puedes comprar fruta para la cena? Gracias. Elena »

Texto 3 - Anuncio
Se alquila piso. Tres habitaciones, cocina moderna y terraza. Cerca del metro y de las tiendas. No se admiten mascotas. 700 euros al mes.

(a) On which day does the chess club meet? (1 mark)
(b) At what time does the club start? (1 mark)
(c) How much is the first class? (1 mark)
(d) Where is Elena now? (1 mark)
(e) How late is her train? (1 mark)
(f) What does she ask Lucía to buy? (1 mark)
(g) Give one thing that is not allowed in the flat and the cost per month. (2 marks)

Total for Question 4: 8 marks$mq$, $mq$[1] Tuesday
[1] 3 pm / 15:00
[1] Free
[1] At the station
[1] 30 minutes
[1] Fruit
[1] Pets
[1] 700 euros$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | B 12]]
Task 5: Reading - technology and media.
Mi canal de cocina, por Andrés, 15 años

Hace un año, empecé a hacer vídeos de cocina con mi hermano. Los subimos a internet cada sábado. Al principio, solo nuestra familia los veía, pero ahora tenemos más de dos mil seguidores. Mi plato favorito para grabar es la tortilla de patatas, porque es fácil y a todo el mundo le gusta.

Para grabar usamos el móvil de mi padre y un micrófono pequeño que compré con mi dinero. Es importante tener buen sonido. Después, mi hermano edita los vídeos en el ordenador. Tarda unas tres horas.

Algunas personas escriben comentarios muy simpáticos, pero otras escriben cosas malas. Mi madre dice que no debo leerlos. Tiene razón, porque a veces me ponen triste.

El año que viene queremos hacer vídeos en inglés para tener seguidores de otros países. ¿Y tú? ¿Te gustaría hacer un canal?

(a) What do Andrés and his brother make? (1 mark)
(b) How often do they put a video online? (1 mark)
(c) How many followers do they have now? (1 mark)
(d) Why is the Spanish omelette his favourite dish to film? (2 marks)
(e) What equipment do they use to film? (2 marks)
(f) Who edits the videos and how long does it take? (2 marks)
(g) Why does his mother say he should not read the comments? (1 mark)
(h) What do they plan to do next year? (1 mark)
(i) Find the Spanish word in the text that means 'nice / kind'. (1 mark)

Total for Question 5: 12 marks$mq$, $mq$[1] Cooking videos
[1] Every Saturday
[1] More than 2,000
[1] It is easy
[1] Everybody likes it
[1] His father's phone
[1] A small microphone
[1] His brother
[1] About three hours
[1] Some are unkind / they sometimes make him sad
[1] Make videos in English (to get followers from other countries)
[1] simpáticos$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 8]]
Task 6: Writing a message.
A Spanish exchange student, Nuria, is coming to stay with you. Write a message to Nuria in Spanish of about 40 to 50 words. Include:
- your name and age
- a description of your family
- one of your hobbies
- one thing you want to do together during her visit

Write your message. (8 marks)

Total for Question 6: 8 marks$mq$, $mq$Content (4 marks): one mark for each required point communicated clearly.
[1] Gives name and age
[1] Describes family members
[1] Mentions one hobby
[1] Suggests an activity to do together
Language (4 marks):
[1] Vocabulary is appropriate and mostly accurate
[1] Verb forms (and tense where required) are mostly correct
[1] Uses simple connectors or varied sentence patterns, not only isolated phrases
[1] Accents, ñ, punctuation (¿ ¡) and agreement are mostly correct; uses ser/tener/vivir forms correctly
Example: Hola, Nuria. Me llamo Sam y tengo quince años. Mi familia es pequeña: mi madre, mi padre y mi hermano. Me gusta nadar. ¿Quieres ir a la playa conmigo?$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | C 12]]
Task 7: Writing an article.
A website for visitors is collecting articles about different towns. Write an article in Spanish of about 80 to 100 words about your town or a place you know well. Include:
- a description of the place
- what tourists can do there
- how to travel there or get around
- a visit you made there in the past, and your opinion of it

Write your article. (12 marks)

Total for Question 7: 12 marks$mq$, $mq$Content (4 marks): one mark for each required point, developed with a detail or reason where asked.
[1] Describes the town or place
[1] Says what tourists can do
[1] Gives information about transport
[1] Describes a past visit and gives an opinion
Range of language (4 marks):
[1] A variety of vocabulary relevant to the topic
[1] Gives at least one opinion with a reason
[1] Uses more than one tense or time reference correctly
[1] Uses connectors to link ideas (for example the equivalents of 'and', 'but', 'because', 'then')
Accuracy (4 marks):
[1] Verb forms are mostly correct
[1] Agreement of nouns, articles and adjectives (gender and number) is mostly correct
[1] Spelling is mostly correct
[1] The message is clear throughout and the length is appropriate (a text far below the length cannot score this mark)$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

-- Spanish ab initio MYP 5 eAssessment Paper B (7 tasks, 64 marks) (64 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish ab initio MYP 5 eAssessment Paper B (7 tasks, 64 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish ab initio MYP 5 eAssessment Paper B (7 tasks, 64 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: Listening - the world we live in. A town hall worker talks about recycling.
Listening. [Audio transcript - read twice] Read the transcript, then answer in English.

« Buenas tardes. Soy Ana Ruiz, del ayuntamiento. En nuestro barrio queremos cuidar el planeta. Desde enero hay contenedores de colores en todas las calles: el azul es para el papel, el amarillo para el plástico y el verde para el vidrio. Los camiones de basura pasan por la mañana, a las seis. Además, el domingo próximo vamos a limpiar el parque. Necesitamos voluntarios. Empezamos a las nueve de la mañana, en la entrada del parque. Los voluntarios reciben una camiseta y un bocadillo gratis. Para apuntarse, hay que llamar al ayuntamiento o ir a la biblioteca. »

(a) Where does Ana Ruiz work? (1 mark)
(b) What goes in the blue, yellow and green containers? (3 marks)
(c) At what time do the rubbish trucks come? (1 mark)
(d) What will happen in the park next Sunday? (1 mark)
(e) When and where will the volunteers start? (2 marks)

Total for Question 1: 8 marks$mq$, $mq$[1] At the town hall
[1] Blue: paper
[1] Yellow: plastic
[1] Green: glass
[1] 6 am
[1] A clean-up / the park will be cleaned
[1] 9 am
[1] At the entrance to the park$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Task 2: Listening - identity and culture. Two friends talk about Christmas.
Listening. [Audio transcript - read twice] Read the transcript, then answer in English.

Laura: ¿Qué haces en Navidad, Diego?
Diego: El día veinticuatro cenamos en casa de mis abuelos. Somos doce personas.
Laura: ¡Doce! ¿Qué coméis?
Diego: Mi abuela prepara sopa y cordero. De postre, comemos turrón.
Laura: Me encanta el turrón. En mi familia, hacemos una cena más pequeña, pero abrimos los regalos el seis de enero.
Diego: Ah, el día de los Reyes Magos.
Laura: Sí. Este año quiero una bicicleta nueva. ¿Y tú?
Diego: Yo quiero unos auriculares. Después de la cena, vamos a la iglesia a medianoche y luego jugamos a las cartas.
Laura: ¡Qué divertido!

(a) On what date does Diego's family have dinner? (1 mark)
(b) Where is the dinner? (1 mark)
(c) How many people are at the dinner? (1 mark)
(d) What does Diego's grandmother prepare? (2 marks)
(e) What do they eat for dessert? (1 mark)
(f) When does Laura's family open presents? (1 mark)
(g) What does Laura want this year? (1 mark)

Total for Question 2: 8 marks$mq$, $mq$[1] 24 December (accept the 24th)
[1] At his grandparents' house
[1] 12 / twelve
[1] Soup
[1] Lamb
[1] Turrón (nougat)
[1] 6 January
[1] A new bicycle$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
Task 3: Listening - technology and media. A radio presenter describes today's programme.
Listening. [Audio transcript - read twice] Read the transcript, then answer in English.

« Hola a todos, bienvenidos a Radio Joven. Hoy tenemos tres secciones. A las cinco de la tarde, la sección de videojuegos: probamos un juego nuevo sobre el espacio. A las seis, entrevistamos a un youtuber de dieciséis años que graba vídeos de deportes. Nos va a contar cómo empezó. A las siete, el concurso: si respondes bien a tres preguntas sobre cine, ganas una entrada para el cine. Para participar, tienes que enviar un mensaje de texto antes de las siete. Y recuerda: mañana, a la misma hora, hablaremos sobre cómo usar internet de manera segura. »

(a) At what time is the video game section? (1 mark)
(b) What is the new game about? (1 mark)
(c) Who will be interviewed at 6 pm? (1 mark)
(d) What kind of videos does he make? (1 mark)
(e) What do you have to do to win the prize in the competition? (1 mark)
(f) What is the prize? (1 mark)
(g) How do you take part? (1 mark)
(h) What will tomorrow's programme be about? (1 mark)

Total for Question 3: 8 marks$mq$, $mq$[1] 5 pm / 17:00
[1] Space
[1] A 16-year-old youtuber
[1] Sports videos
[1] Answer three questions (about cinema) correctly
[1] A cinema ticket
[1] By sending a text message
[1] Using the internet safely$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 8]]
Task 4: Reading - two short texts.
Texto 1 - Parque de atracciones
Parque « Mundo Aventura ». Horario: de martes a domingo, de 10:00 a 20:00. Los lunes está cerrado. Entrada: adultos 25 euros, niños 15 euros. Si compras la entrada por internet, tienes un 10 % de descuento.

Texto 2 - Oferta de trabajo
Se busca camarero o camarera para el restaurante « El Puerto ». Trabajo los viernes y sábados por la noche, de seis a diez. Es necesario hablar inglés. Enviar currículum a la señora Vega.

(a) On which day is the park closed? (1 mark)
(b) At what time does the park close on other days? (1 mark)
(c) How much is a child's ticket? (1 mark)
(d) How can you get a discount? (1 mark)
(e) What job is advertised? (1 mark)
(f) On which days is the work? (1 mark)
(g) Which language is necessary? (1 mark)
(h) Who should receive the CV? (1 mark)

Total for Question 4: 8 marks$mq$, $mq$[1] Monday
[1] 8 pm / 20:00
[1] 15 euros
[1] By buying the ticket online / on the internet
[1] Waiter / waitress
[1] Friday and Saturday (both needed)
[1] English
[1] Señora Vega$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | B 12]]
Task 5: Reading - education and work.
Mi semana de prácticas, por Sergio

La semana pasada hice prácticas en una clínica veterinaria cerca de mi casa. Llegué a las ocho de la mañana. La veterinaria, la doctora Navarro, me enseñó a cuidar a los animales. El lunes limpié las jaulas y di de comer a los perros. El martes ayudé con un gato enfermo. Tenía una pata rota, pero la doctora lo curó y el gato volvió a andar. Me puse muy contento. También hablé con los dueños de las mascotas y respondí al teléfono.

No fue fácil. Estuve de pie casi todo el día y me dolían las piernas. Además, un perro grande me mordió un poco el dedo, pero no fue grave. A pesar de todo, aprendí mucho. Ahora sé que trabajar con animales es difícil, pero muy bonito. En el futuro, me gustaría estudiar veterinaria en la universidad. Primero tengo que sacar buenas notas en matemáticas y ciencias.

(a) At what time did Sergio arrive at the clinic? (1 mark)
(b) What did Dr Navarro teach him? (1 mark)
(c) What two things did he do on Monday? (2 marks)
(d) What was wrong with the cat? (1 mark)
(e) What happened to the cat in the end? (1 mark)
(f) How did Sergio feel about this? (1 mark)
(g) Give two other things he did during the week. (2 marks)
(h) Why did his legs hurt? (1 mark)
(i) What happened with the big dog? (1 mark)
(j) What would he like to study in the future? (1 mark)

Total for Question 5: 12 marks$mq$, $mq$[1] 8 am
[1] How to look after animals
[1] Cleaned the cages
[1] Fed the dogs
[1] A broken leg
[1] It walked again / was cured
[1] Very happy
[1] Talked to the pets' owners
[1] Answered the phone
[1] He stood all day
[1] It bit his finger a little
[1] Veterinary science / to be a vet at university$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 8]]
Task 6: Writing an email.
Your Spanish friend Nuria wants to know about your school life. Write an email in Spanish of about 40 to 50 words. Include:
- two subjects you study
- your favourite subject and why
- what you did yesterday after school
- one question for Nuria

Write your email. (8 marks)

Total for Question 6: 8 marks$mq$, $mq$Content (4 marks): one mark for each required point communicated clearly.
[1] Names two subjects
[1] Gives a favourite subject with a reason
[1] Says what they did yesterday after school (past tense expected)
[1] Asks Nuria a question
Language (4 marks):
[1] Vocabulary is appropriate and mostly accurate
[1] Verb forms (and tense where required) are mostly correct
[1] Uses simple connectors or varied sentence patterns, not only isolated phrases
[1] Accents, ñ, punctuation (¿ ¡) and agreement are mostly correct
Example: Hola, Nuria. Estudio matemáticas e inglés. Mi asignatura favorita es el arte porque es creativa. Ayer, después de clase, hice los deberes y vi la televisión. ¿Qué asignaturas estudias tú?$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | C 12]]
Task 7: Writing a blog post.
Your school is writing a blog called « Cuidamos el planeta ». Write a blog post in Spanish of about 80 to 100 words. Include:
- one environmental problem in your area
- what you do at home or at school to help
- something you did recently to protect the environment
- what you plan to do in the future, and why

Write your blog post. (12 marks)

Total for Question 7: 12 marks$mq$, $mq$Content (4 marks): one mark for each required point, developed with a detail or reason where asked.
[1] Describes an environmental problem
[1] Says what they do to help
[1] Describes something done recently (past tense)
[1] States a future plan with a reason
Range of language (4 marks):
[1] A variety of vocabulary relevant to the topic
[1] Gives at least one opinion with a reason
[1] Uses more than one tense or time reference correctly
[1] Uses connectors to link ideas (for example the equivalents of 'and', 'but', 'because', 'then')
Accuracy (4 marks):
[1] Verb forms are mostly correct
[1] Agreement of nouns, articles and adjectives (gender and number) is mostly correct
[1] Spelling is mostly correct
[1] The message is clear throughout and the length is appropriate (a text far below the length cannot score this mark)$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

-- Mandarin ab initio MYP 5 eAssessment Paper A (7 tasks, 64 marks) (64 marks)
with sub as (select id from public.subjects where slug = $mq$mandarin-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Mandarin ab initio MYP 5 eAssessment Paper A (7 tasks, 64 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Mandarin ab initio MYP 5 eAssessment Paper A (7 tasks, 64 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: Listening - identity and culture. A student introduces his family.
Listening. [Audio transcript - read twice] Read the transcript (characters with pinyin), then answer in English.

王明：
我叫王明，今年十四岁。我家有五口人：爸爸、妈妈、哥哥、妹妹和我。我们住在北京。我哥哥十八岁，他喜欢踢足球。我喜欢画画儿。我的生日是五月三号。我最喜欢的节日是春节，因为我们全家一起吃饺子。
(Wǒ jiào Wáng Míng, jīnnián shísì suì. Wǒ jiā yǒu wǔ kǒu rén: bàba, māma, gēge, mèimei hé wǒ. Wǒmen zhù zài Běijīng. Wǒ gēge shíbā suì, tā xǐhuan tī zúqiú. Wǒ xǐhuan huà huàr. Wǒ de shēngrì shì wǔ yuè sān hào. Wǒ zuì xǐhuan de jiérì shì Chūnjié, yīnwèi wǒmen quánjiā yìqǐ chī jiǎozi.)

(a) How old is Wang Ming? (1 mark)
(b) How many people are in his family? (1 mark)
(c) Where does his family live? (1 mark)
(d) What does his older brother like to do? (1 mark)
(e) What is Wang Ming's own hobby? (1 mark)
(f) When is his birthday? (1 mark)
(g) Which festival does he like best? (1 mark)
(h) What does his family eat at this festival? (1 mark)

Total for Question 1: 8 marks$mq$, $mq$[1] 14 / fourteen
[1] Five
[1] In Beijing
[1] Play football
[1] Drawing / painting
[1] 3 May
[1] Spring Festival (Chinese New Year)
[1] Dumplings (jiaozi)$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Task 2: Listening - education and work. Two friends talk about school.
Listening. [Audio transcript - read twice] Read the transcript (characters with pinyin), then answer in English.

小红：小明，你今天有几节课？
小明：我有六节课。第一节是数学，八点开始。
小红：你喜欢数学吗？
小明：不太喜欢。我最喜欢体育课，因为我喜欢跑步。你呢？
小红：我喜欢英语。我想当老师。
小明：真的吗？我想当医生，因为我想帮助别人。
小红：周末你做什么？
小明：星期六上午我在饭馆工作，一小时赚十五块钱。
小红：不错！中午我们一起在食堂吃饭，好吗？
小明：好，十二点半见。
(Xiǎohóng: Xiǎomíng, nǐ jīntiān yǒu jǐ jié kè? Xiǎomíng: Wǒ yǒu liù jié kè. Dì-yī jié shì shùxué, bā diǎn kāishǐ. Xiǎohóng: Nǐ xǐhuan shùxué ma? Xiǎomíng: Bú tài xǐhuan. Wǒ zuì xǐhuan tǐyù kè, yīnwèi wǒ xǐhuan pǎobù. Nǐ ne? Xiǎohóng: Wǒ xǐhuan Yīngyǔ. Wǒ xiǎng dāng lǎoshī. Xiǎomíng: Zhēn de ma? Wǒ xiǎng dāng yīshēng, yīnwèi wǒ xiǎng bāngzhù biérén. Xiǎohóng: Zhōumò nǐ zuò shénme? Xiǎomíng: Xīngqīliù shàngwǔ wǒ zài fànguǎn gōngzuò, yì xiǎoshí zhuàn shíwǔ kuài qián. Xiǎohóng: Búcuò! Zhōngwǔ wǒmen yìqǐ zài shítáng chīfàn, hǎo ma? Xiǎomíng: Hǎo, shí'èr diǎn bàn jiàn.)

(a) How many lessons does Xiaoming have today? (1 mark)
(b) What is his first lesson? (1 mark)
(c) Which lesson does he like best? (1 mark)
(d) Why does he like it? (1 mark)
(e) What job would Xiaohong like to do? (1 mark)
(f) Where does Xiaoming work on Saturday morning? (1 mark)
(g) How much does he earn per hour? (1 mark)
(h) At what time will they meet for lunch? (1 mark)

Total for Question 2: 8 marks$mq$, $mq$[1] Six
[1] Maths
[1] PE (physical education)
[1] He likes running
[1] Teacher
[1] In a restaurant
[1] 15 yuan (kuai)
[1] 12.30 / half past twelve$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
Task 3: Listening - local area, travel and tourism. A guide welcomes visitors.
Listening. [Audio transcript - read twice] Read the transcript (characters with pinyin), then answer in English.

各位游客，欢迎来到西安。今天天气很好，不冷也不热，二十度。博物馆早上九点开门，下午五点关门。大人票四十块，小孩票免费。如果你想参观老城，可以租自行车，也可以坐观光巴士。巴士从火车站出发，十点开车。市场在城中心，每天都开。想吃饭，我们介绍“老王饭店”，在博物馆对面。祝大家旅行愉快！
(Gèwèi yóukè, huānyíng láidào Xī'ān. Jīntiān tiānqì hěn hǎo, bù lěng yě bú rè, èrshí dù. Bówùguǎn zǎoshang jiǔ diǎn kāimén, xiàwǔ wǔ diǎn guānmén. Dàrén piào sìshí kuài, xiǎohái piào miǎnfèi. Rúguǒ nǐ xiǎng cānguān lǎochéng, kěyǐ zū zìxíngchē, yě kěyǐ zuò guānguāng bāshì. Bāshì cóng huǒchēzhàn chūfā, shí diǎn kāichē. Shìchǎng zài chéng zhōngxīn, měitiān dōu kāi. Xiǎng chīfàn, wǒmen jièshào “Lǎo Wáng Fàndiàn”, zài bówùguǎn duìmiàn. Zhù dàjiā lǚxíng yúkuài!)

(a) What is the weather like today? (2 marks)
(b) At what time does the museum close? (1 mark)
(c) How much is an adult ticket? (1 mark)
(d) Who can enter the museum for free? (1 mark)
(e) Give two ways to visit the old town. (2 marks)
(f) Where does the bus leave from? (1 mark)

Total for Question 3: 8 marks$mq$, $mq$[1] Fine / good weather
[1] Neither cold nor hot (accept 20 degrees)
[1] 5 pm
[1] 40 yuan (kuai)
[1] Children
[1] Rent a bicycle
[1] Take the sightseeing bus
[1] The railway station$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 8]]
Task 4: Reading - two short texts.
Text 1 - 学校通知
学校通知：星期四下午四点到五点半，学校有书法课。在三楼教室。不用带笔，老师给你们笔和纸。免费。
(Xuéxiào tōngzhī: Xīngqīsì xiàwǔ sì diǎn dào wǔ diǎn bàn, xuéxiào yǒu shūfǎ kè. Zài sān lóu jiàoshì. Búyòng dài bǐ, lǎoshī gěi nǐmen bǐ hé zhǐ. Miǎnfèi.)

Text 2 - 短信
小丽，我在地铁站，可是地铁晚了二十分钟。我七点到你家。你能买一些水果吗？谢谢！小云
(Xiǎolì, wǒ zài dìtiězhàn, kěshì dìtiě wǎn le èrshí fēnzhōng. Wǒ qī diǎn dào nǐ jiā. Nǐ néng mǎi yìxiē shuǐguǒ ma? Xièxie! Xiǎoyún)

(a) On which day is the calligraphy class? (1 mark)
(b) At what time does the class end? (1 mark)
(c) Where is the class? (1 mark)
(d) What do students need to bring? (1 mark)
(e) Where is Xiaoyun? (1 mark)
(f) How late is the train? (1 mark)
(g) What does she ask Xiaoli to buy? (1 mark)
(h) At what time will she arrive? (1 mark)

Total for Question 4: 8 marks$mq$, $mq$[1] Thursday
[1] 5.30 pm
[1] In a classroom on the third floor
[1] Nothing (the teacher gives pens and paper)
[1] At the metro / underground station
[1] 20 minutes
[1] Some fruit
[1] 7 o'clock$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | B 12]]
Task 5: Reading - technology and media.
我的手机，李文
我今年十五岁，有一个手机。每天早上我先看手机上的新闻，然后吃早饭。以前，我每天玩游戏四个小时，太多了。现在我一天只玩一个小时。妈妈在我的手机上下载了一个应用，晚上九点以后不能上网。
手机很有用。我用手机查作业的资料，也用它学中文。我每天跟中国朋友视频聊天，练习说话。可是手机也有问题。有一次，我在网上看到一个不好的广告，很害怕。现在我只看老师和爸爸妈妈说可以看的网站。
星期天我不用手机。我和朋友去公园骑自行车，或者在家看书。我觉得这样很好，因为我睡得好，也不累。

(Wǒ de shǒujī, Lǐ Wén
Wǒ jīnnián shíwǔ suì, yǒu yí gè shǒujī. Měitiān zǎoshang wǒ xiān kàn shǒujī shàng de xīnwén, ránhòu chī zǎofàn. Yǐqián, wǒ měitiān wán yóuxì sì gè xiǎoshí, tài duō le. Xiànzài wǒ yì tiān zhǐ wán yí gè xiǎoshí. Māma zài wǒ de shǒujī shàng xiàzài le yí gè yìngyòng, wǎnshang jiǔ diǎn yǐhòu bù néng shàngwǎng.
Shǒujī hěn yǒuyòng. Wǒ yòng shǒujī chá zuòyè de zīliào, yě yòng tā xué Zhōngwén. Wǒ měitiān gēn Zhōngguó péngyou shìpín liáotiān, liànxí shuōhuà. Kěshì shǒujī yě yǒu wèntí. Yǒu yí cì, wǒ zài wǎngshàng kàndào yí gè bù hǎo de guǎnggào, hěn hàipà. Xiànzài wǒ zhǐ kàn lǎoshī hé bàba māma shuō kěyǐ kàn de wǎngzhàn.
Xīngqītiān wǒ bú yòng shǒujī. Wǒ hé péngyou qù gōngyuán qí zìxíngchē, huòzhě zài jiā kàn shū. Wǒ juéde zhèyàng hěn hǎo, yīnwèi wǒ shuì de hǎo, yě bú lèi.)

(a) What does Li Wen do first every morning? (1 mark)
(b) How many hours a day did he play games before? (1 mark)
(c) How long does he play games now? (1 mark)
(d) What does the app his mother installed do? (2 marks)
(e) Give two ways he uses his phone for study. (2 marks)
(f) How does he practise speaking? (1 mark)
(g) Why was he afraid one time? (1 mark)
(h) Which websites does he look at now? (1 mark)
(i) What two things does he do on Sundays? (2 marks)

Total for Question 5: 12 marks$mq$, $mq$[1] Reads the news on his phone
[1] Four
[1] One hour a day
[1] Stops him going online
[1] After 9 pm
[1] Looks up information for homework
[1] Learns Chinese
[1] Video chats with Chinese friends
[1] He saw a bad advertisement online
[1] Only those the teacher / parents say are fine
[1] Cycles in the park with friends
[1] Reads at home$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 8]]
Task 6: Writing a message.
A Chinese exchange student, Xiao Yu, is coming to stay with you. Write a message to Xiao Yu in Chinese of about 30 to 40 characters. Include:
- your name and age
- the people in your family
- one of your hobbies
- one thing you want to do together during the visit

You may write in characters, or in characters with pinyin if you wish.

Write your message. (8 marks)

Total for Question 6: 8 marks$mq$, $mq$Content (4 marks): one mark for each required point communicated clearly.
[1] Gives name and age
[1] Names members of the family
[1] Mentions one hobby
[1] Suggests an activity to do together
Language (4 marks):
[1] Vocabulary is appropriate and mostly accurate
[1] Word order is mostly correct (for example time words before the verb, subject-verb-object)
[1] Uses a suitable sentence pattern (for example 我想……, 我喜欢……, 昨天我……, ……吗？) beyond isolated words
[1] Characters (or pinyin with tones, if used) are mostly accurate and the message is clear
Example: 小玉，你好！我叫山姆，十五岁。我家有四口人：爸爸、妈妈、弟弟和我。我喜欢游泳。你想跟我去公园吗？$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | C 12]]
Task 7: Writing an article.
A website for young visitors is collecting articles about different towns. Write an article in Chinese of about 60 to 80 characters about your town or a place you know well. Include:
- a description of the place
- what visitors can do there
- how to get there or get around
- a visit you made there in the past, and your opinion of it

You may write in characters, or in characters with pinyin if you wish.

Write your article. (12 marks)

Total for Question 7: 12 marks$mq$, $mq$Content (4 marks): one mark for each required point, developed with a detail or reason where asked.
[1] Describes the town or place
[1] Says what visitors can do
[1] Gives information about transport
[1] Describes a past visit and gives an opinion
Range of language (4 marks):
[1] A variety of vocabulary relevant to the topic
[1] Gives at least one opinion or reason (for example 因为……, 我觉得……)
[1] Uses time words or aspect markers correctly (for example 上个星期, 以后, 了, 要)
[1] Links ideas with connectors (for example 和, 也, 可是, 因为, 然后)
Accuracy (4 marks):
[1] Word order is mostly correct
[1] Measure words and negation (不 / 没) are mostly correct
[1] Characters (or pinyin with tones, if used) are mostly accurate
[1] The message is clear throughout and the length is appropriate (a text far below the length cannot score this mark)$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

-- Mandarin ab initio MYP 5 eAssessment Paper B (7 tasks, 64 marks) (64 marks)
with sub as (select id from public.subjects where slug = $mq$mandarin-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Mandarin ab initio MYP 5 eAssessment Paper B (7 tasks, 64 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Mandarin ab initio MYP 5 eAssessment Paper B (7 tasks, 64 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Task 1: Listening - the world we live in. A headteacher talks about the school and the environment.
Listening. [Audio transcript - read twice] Read the transcript (characters with pinyin), then answer in English.

同学们好！我是校长。我们学校想做一所环保的学校。从九月开始，每个教室有三个垃圾桶：一个放纸，一个放塑料，一个放别的垃圾。每天早上，八年级的同学检查垃圾桶。学校后面有一个小花园，同学们在那儿种菜，菜在食堂吃。下星期五是“无车日”，请大家走路或者骑自行车来学校。谢谢大家！
(Tóngxuémen hǎo! Wǒ shì xiàozhǎng. Wǒmen xuéxiào xiǎng zuò yì suǒ huánbǎo de xuéxiào. Cóng jiǔ yuè kāishǐ, měi gè jiàoshì yǒu sān gè lājītǒng: yí gè fàng zhǐ, yí gè fàng sùliào, yí gè fàng bié de lājī. Měitiān zǎoshang, bā niánjí de tóngxué jiǎnchá lājītǒng. Xuéxiào hòumian yǒu yí gè xiǎo huāyuán, tóngxuémen zài nàr zhòng cài, cài zài shítáng chī. Xià xīngqīwǔ shì “wúchē rì”, qǐng dàjiā zǒulù huòzhě qí zìxíngchē lái xuéxiào. Xièxie dàjiā!)

(a) Who is speaking? (1 mark)
(b) What kind of school does the school want to become? (1 mark)
(c) What goes in each of the three bins? (3 marks)
(d) Who checks the bins every morning? (1 mark)
(e) Where is the small garden? (1 mark)
(f) Where are the vegetables eaten? (1 mark)

Total for Question 1: 8 marks$mq$, $mq$[1] The headteacher / principal
[1] An environmentally friendly (green) school
[1] Paper
[1] Plastic
[1] Other rubbish
[1] Students in Year 8 (eighth grade)
[1] Behind the school
[1] In the canteen$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Task 2: Listening - identity and culture. Two friends talk about the Mid-Autumn Festival.
Listening. [Audio transcript - read twice] Read the transcript (characters with pinyin), then answer in English.

大卫：小美，中秋节你们做什么？
小美：我们全家去奶奶家。有十个人。
大卫：你们吃什么？
小美：我们吃月饼，还有鱼和鸡。
大卫：月饼是什么味道的？
小美：有的是甜的，有的是咸的。我最喜欢豆沙的。晚上我们在院子里看月亮。
大卫：真好！我们国家没有这个节日。
小美：你想来吗？这个星期六就是中秋节。
大卫：太好了，我很想去！
(Dàwèi: Xiǎoměi, Zhōngqiūjié nǐmen zuò shénme? Xiǎoměi: Wǒmen quánjiā qù nǎinai jiā. Yǒu shí gè rén. Dàwèi: Nǐmen chī shénme? Xiǎoměi: Wǒmen chī yuèbǐng, hái yǒu yú hé jī. Dàwèi: Yuèbǐng shì shénme wèidào de? Xiǎoměi: Yǒu de shì tián de, yǒu de shì xián de. Wǒ zuì xǐhuan dòushā de. Wǎnshang wǒmen zài yuànzi lǐ kàn yuèliang. Dàwèi: Zhēn hǎo! Wǒmen guójiā méiyǒu zhège jiérì. Xiǎoměi: Nǐ xiǎng lái ma? Zhège xīngqīliù jiùshì Zhōngqiūjié. Dàwèi: Tài hǎo le, wǒ hěn xiǎng qù!)

(a) Where does Xiaomei's family go for the festival? (1 mark)
(b) How many people are there? (1 mark)
(c) What do they eat? (3 marks)
(d) What two flavours of mooncake does Xiaomei mention? (2 marks)
(e) Which kind of mooncake does she like best? (1 mark)

Total for Question 2: 8 marks$mq$, $mq$[1] To her grandmother's home
[1] Ten
[1] Mooncakes
[1] Fish
[1] Chicken
[1] Sweet
[1] Salty
[1] Red bean paste$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | A 8]]
Task 3: Listening - technology and media. A radio presenter describes today's programme.
Listening. [Audio transcript - read twice] Read the transcript (characters with pinyin), then answer in English.

欢迎收听青少年广播。今天的节目有三个。下午四点是游戏时间，我们介绍一个新的赛车游戏。五点，我们请一位十五岁的女孩，她每个星期拍跳舞视频放在网上。她会告诉我们她怎么开始的。六点是比赛：如果你答对三个关于电影的问题，就能得到两张电影票。想参加，请在六点以前发短信给我们。明天同一个时间，我们谈怎么安全地上网。
(Huānyíng shōutīng Qīngshàonián Guǎngbō. Jīntiān de jiémù yǒu sān gè. Xiàwǔ sì diǎn shì yóuxì shíjiān, wǒmen jièshào yí gè xīn de sàichē yóuxì. Wǔ diǎn, wǒmen qǐng yí wèi shíwǔ suì de nǚhái, tā měi gè xīngqī pāi tiàowǔ shìpín fàng zài wǎngshàng. Tā huì gàosu wǒmen tā zěnme kāishǐ de. Liù diǎn shì bǐsài: rúguǒ nǐ dá duì sān gè guānyú diànyǐng de wèntí, jiù néng dédào liǎng zhāng diànyǐngpiào. Xiǎng cānjiā, qǐng zài liù diǎn yǐqián fā duǎnxìn gěi wǒmen. Míngtiān tóng yí gè shíjiān, wǒmen tán zěnme ānquán de shàngwǎng.)

(a) At what time is the game section? (1 mark)
(b) What kind of game will be introduced? (1 mark)
(c) Who will be interviewed at 5 o'clock? (1 mark)
(d) What kind of videos does she make? (1 mark)
(e) What must you do to win in the competition? (1 mark)
(f) What is the prize? (1 mark)
(g) What is the deadline for taking part? (1 mark)
(h) What will tomorrow's programme be about? (1 mark)

Total for Question 3: 8 marks$mq$, $mq$[1] 4 pm
[1] A new racing game
[1] A 15-year-old girl
[1] Dance videos
[1] Answer three questions (about films) correctly
[1] Two cinema tickets
[1] Before 6 o'clock
[1] Going online safely$mq$, $mq$A$mq$),
(4, $mq$[[Q 4 | B 8]]
Task 4: Reading - two short texts.
Text 1 - 天气预报
明天上海：上午晴天，二十八度，很热。下午有雷雨。晚上下雨，天气凉快。
(Míngtiān Shànghǎi: shàngwǔ qíngtiān, èrshíbā dù, hěn rè. Xiàwǔ yǒu léiyǔ. Wǎnshang xiàyǔ, tiānqì liángkuai.)

Text 2 - 招聘
饭馆招人：“小龙饭馆”要一个服务员。星期五和星期六晚上六点到十点工作。会说英语的人更好。请把简历发给高先生。
(Fànguǎn zhāo rén: “Xiǎolóng Fànguǎn” yào yí gè fúwùyuán. Xīngqīwǔ hé xīngqīliù wǎnshang liù diǎn dào shí diǎn gōngzuò. Huì shuō Yīngyǔ de rén gèng hǎo. Qǐng bǎ jiǎnlì fā gěi Gāo xiānsheng.)

(a) What is the weather like tomorrow morning? (1 mark)
(b) What is the weather like in the afternoon? (1 mark)
(c) What is the weather like in the evening? (1 mark)
(d) What job is advertised? (1 mark)
(e) On which days is the work? (1 mark)
(f) At what time does the work finish? (1 mark)
(g) What would be an advantage for an applicant? (1 mark)
(h) Who should receive the CV? (1 mark)

Total for Question 4: 8 marks$mq$, $mq$[1] Sunny and hot (accept either; 28 degrees)
[1] Thunderstorms
[1] Rainy and cool
[1] Waiter / waitress
[1] Friday and Saturday (both needed)
[1] 10 o'clock (pm)
[1] Being able to speak English
[1] Mr Gao$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | B 12]]
Task 5: Reading - education and work.
我在书店实习，王海
上个星期，我在一家书店实习。我早上八点到书店，书店的经理张女士给我看怎么放书。我把新书放在书架上，还帮客人找书。有一位老爷爷想找一本关于中国历史的书，我找到了，他很高兴，对我说：“谢谢你，你真好！”我也很高兴。
工作不容易。我站了一天，腿很累。有的客人不太客气，我有点儿生气。可是我学到了很多东西。我知道了做服务员要有耐心。我以后可能想当老师，不过现在我想先把书念好，再上大学。

(Wǒ zài shūdiàn shíxí, Wáng Hǎi
Shàng ge xīngqī, wǒ zài yì jiā shūdiàn shíxí. Wǒ zǎoshang bā diǎn dào shūdiàn, shūdiàn de jīnglǐ Zhāng nǚshì gěi wǒ kàn zěnme fàng shū. Wǒ bǎ xīn shū fàng zài shūjià shàng, hái bāng kèrén zhǎo shū. Yǒu yí wèi lǎo yéye xiǎng zhǎo yì běn guānyú Zhōngguó lìshǐ de shū, wǒ zhǎodào le, tā hěn gāoxìng, duì wǒ shuō: “Xièxie nǐ, nǐ zhēn hǎo!” Wǒ yě hěn gāoxìng.
Gōngzuò bù róngyì. Wǒ zhàn le yì tiān, tuǐ hěn lèi. Yǒu de kèrén bú tài kèqi, wǒ yǒudiǎnr shēngqì. Kěshì wǒ xué dào le hěn duō dōngxi. Wǒ zhīdào le zuò fúwùyuán yào yǒu nàixīn. Wǒ yǐhòu kěnéng xiǎng dāng lǎoshī, búguò xiànzài wǒ xiǎng xiān bǎ shū niàn hǎo, zài shàng dàxué.)

(a) At what time did Wang Hai arrive at the bookshop? (1 mark)
(b) What did the manager show him? (1 mark)
(c) Give two things Wang Hai did at the shop. (2 marks)
(d) What kind of book did the old man want? (1 mark)
(e) What did the old man say to Wang Hai? (1 mark)
(f) How did Wang Hai feel about this? (1 mark)
(g) Why were his legs tired? (1 mark)
(h) Why was he a little angry? (1 mark)
(i) What did he learn about being a shop assistant? (1 mark)
(j) What job might he want to do in the future? (1 mark)
(k) What does he want to do before university? (1 mark)

Total for Question 5: 12 marks$mq$, $mq$[1] 8 am
[1] How to put books out / arrange books
[1] Put new books on the shelves
[1] Helped customers find books
[1] A book about Chinese history
[1] Thank you / you are very kind
[1] Happy
[1] He stood all day
[1] Some customers were not very polite
[1] You need patience
[1] Teacher
[1] Study well / do well at school$mq$, $mq$B$mq$),
(6, $mq$[[Q 6 | C 8]]
Task 6: Writing an email.
Your Chinese friend Xiao Yu wants to know about your school life. Write an email in Chinese of about 30 to 40 characters. Include:
- two subjects you study
- your favourite subject and why
- what you did yesterday after school
- one question for Xiao Yu

You may write in characters, or in characters with pinyin if you wish.

Write your email. (8 marks)

Total for Question 6: 8 marks$mq$, $mq$Content (4 marks): one mark for each required point communicated clearly.
[1] Names two subjects
[1] Gives a favourite subject with a reason
[1] Says what they did yesterday after school
[1] Asks Xiao Yu a question
Language (4 marks):
[1] Vocabulary is appropriate and mostly accurate
[1] Word order is mostly correct (for example time words before the verb, subject-verb-object)
[1] Uses a suitable sentence pattern (for example 我想……, 我喜欢……, 昨天我……, ……吗？) beyond isolated words
[1] Characters (or pinyin with tones, if used) are mostly accurate and the message is clear
Example: 小玉，你好！我学数学和英语。我最喜欢美术，因为很有意思。昨天放学以后，我做了作业。你喜欢什么课？$mq$, $mq$C$mq$),
(7, $mq$[[Q 7 | C 12]]
Task 7: Writing a blog post.
Your school is writing a blog called « 爱护地球 ». Write a blog post in Chinese of about 60 to 80 characters. Include:
- one environmental problem in your area
- what you do at home or at school to help
- something you did recently to protect the environment
- what you plan to do in the future, and why

You may write in characters, or in characters with pinyin if you wish.

Write your blog post. (12 marks)

Total for Question 7: 12 marks$mq$, $mq$Content (4 marks): one mark for each required point, developed with a detail or reason where asked.
[1] Describes an environmental problem
[1] Says what they do to help
[1] Describes something done recently
[1] States a future plan with a reason
Range of language (4 marks):
[1] A variety of vocabulary relevant to the topic
[1] Gives at least one opinion or reason (for example 因为……, 我觉得……)
[1] Uses time words or aspect markers correctly (for example 上个星期, 以后, 了, 要)
[1] Links ideas with connectors (for example 和, 也, 可是, 因为, 然后)
Accuracy (4 marks):
[1] Word order is mostly correct
[1] Measure words and negation (不 / 没) are mostly correct
[1] Characters (or pinyin with tones, if used) are mostly accurate
[1] The message is clear throughout and the length is appropriate (a text far below the length cannot score this mark)$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);
commit;
