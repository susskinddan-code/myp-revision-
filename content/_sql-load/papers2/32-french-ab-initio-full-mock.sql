-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- French ab initio MYP 5 Full eAssessment Mock (112 marks)
with sub as (select id from public.subjects where slug = $mq$french-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French ab initio MYP 5 Full eAssessment Mock$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French ab initio MYP 5 Full eAssessment Mock$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Section A: Listening. Listening transcript (imagine you hear this voice message twice). Read it, then answer in English.

Message vocal de Madame Lambert :
« Bonjour Anna, c'est Madame Lambert. Je suis au supermarché. Ce soir, nous avons des invités : mon frère Antoine et sa femme Sophie. Nous mangeons à vingt heures. Je prépare un gratin de pommes de terre et une salade verte. Nous sommes six à table. Peux-tu mettre la table, s'il te plaît ? Après, tu peux promener le chien, Max, dans le jardin public. Ne rentre pas après dix-neuf heures trente. Moi, je rentre à dix-huit heures. À tout à l'heure ! »

(a) Where is Madame Lambert now? (1 mark)
(b) Who are the two guests tonight? (2 marks)
(c) At what time will they eat? (1 mark)
(d) What is the main dish? (1 mark)
(e) What is Anna asked to do first? (1 mark)
(f) How many people will sit at the table? (1 mark)
(g) What is Anna asked to do afterwards, and where? (2 marks)
(h) What is the latest time Anna should be home? (1 mark)

(Total 10 marks)$mq$, $mq$(a) [1] At the supermarket
(b) [1] Her brother Antoine
[1] His wife Sophie
(c) [1] 8 pm / 20:00
(d) [1] Potato gratin (accept: a potato bake)
(e) [1] Set/lay the table
(f) [1] Six
(g) [1] Walk the dog (Max)
[1] In the public park/garden
(h) [1] 7.30 pm / 19:30 (do not accept 6 pm, which is when Madame Lambert returns)$mq$, $mq$A$mq$),
(2, $mq$Listening transcript (imagine you hear this conversation twice). Read it, then answer in English.

Dans un magasin de vêtements
Vendeuse : Bonjour, je peux vous aider ?
Cliente : Oui, je cherche un pull pour mon frère. Il aime le bleu ou le vert.
Vendeuse : Quelle taille fait-il ?
Cliente : Il porte du M.
Vendeuse : Voici un pull bleu à vingt-cinq euros et un pull vert à trente euros.
Cliente : Le vert est joli, mais il est un peu cher. Je prends le bleu.
Vendeuse : Très bien. Vous voulez autre chose ?
Cliente : Oui, un chapeau pour moi. Vous avez des chapeaux rouges ?
Vendeuse : Non, désolée, seulement noirs ou gris. Ils coûtent dix euros.
Cliente : Alors je prends un chapeau gris. Je paie en espèces. Voici cinquante euros.
Vendeuse : Voilà votre monnaie : quinze euros.

(a) Who is the pullover for? (1 mark)
(b) Which two colours does he like? (2 marks)
(c) What size does he wear? (1 mark)
(d) How much is the green pullover? (1 mark)
(e) Why does the customer not choose the green pullover? (1 mark)
(f) Which colour of hat does she buy? (1 mark)
(g) Why can she not have a red hat? (1 mark)
(h) How much does she spend in total? (1 mark)
(i) How much change does she receive? (1 mark)

(Total 10 marks)$mq$, $mq$(a) [1] Her brother
(b) [1] Blue
[1] Green
(c) [1] M (medium)
(d) [1] 30 euros
(e) [1] It is a bit expensive
(f) [1] Grey
(g) [1] The shop only has black or grey hats (no red ones)
(h) [1] 35 euros (25 + 10)
(i) [1] 15 euros$mq$, $mq$A$mq$),
(3, $mq$Listening transcript (imagine you hear this radio advertisement twice). Read it, then answer in English.

« Vous aimez le sport ? Venez au centre sportif Aqua-Forme ! Nous avons une piscine, deux terrains de tennis et une salle de musculation. Le centre est ouvert tous les jours, de sept heures à vingt-deux heures, sauf le dimanche (sauf = except). Pour les jeunes de moins de dix-huit ans, l'entrée coûte trois euros. Il y a aussi des cours de natation le mardi et le jeudi à dix-sept heures. Pour ceux qui ont faim, il y a un snack-bar. Le parking est gratuit. Pour réserver un terrain de tennis, allez sur notre site internet ! »

(a) Name two facilities at the centre. (2 marks)
(b) What are the opening hours? (1 mark)
(c) On which day is the centre closed? (1 mark)
(d) How much is entry for people under eighteen? (1 mark)
(e) On which two days are the swimming lessons? (2 marks)
(f) At what time are the swimming lessons? (1 mark)
(g) What is free? (1 mark)
(h) How do you book a tennis court? (1 mark)

(Total 10 marks)$mq$, $mq$(a) [1] Any one of: swimming pool / tennis courts / weights (fitness) room / snack bar
[1] A different one of these
(b) [1] 7 am to 10 pm (07:00-22:00)
(c) [1] Sunday
(d) [1] 3 euros
(e) [1] Tuesday
[1] Thursday
(f) [1] 5 pm / 17:00
(g) [1] The car park / parking
(h) [1] On the website / online$mq$, $mq$A$mq$),
(4, $mq$Section B: Reading. Read this email, then answer the questions in English.

De : ines.martin@exemple.fr
Objet : Mon école

Bonjour Emma, merci pour ton message ! Tu me demandes comment est mon école. Je vais au lycée Jean-Moulin, à Toulouse. Les cours commencent à huit heures et finissent à seize heures trente. J'ai cours de maths, de français, d'histoire et d'anglais, mais ma matière préférée, c'est la biologie, parce que le professeur est drôle. Je déteste la géographie : c'est ennuyeux ! À midi, je mange à la cantine avec mes amies Zoé et Manon. Le mercredi après-midi, je n'ai pas cours, alors je fais de la natation. Mon école est grande, avec un gymnase et une grande cour. Il y a mille élèves. Je prends le bus pour y aller, ça prend vingt minutes. Et ton école, comment est-elle ? À bientôt !
Inès

(a) Name Inès's school and the city. (2 marks)
(b) At what times do lessons start and finish? (2 marks)
(c) What is Inès's favourite subject and why? (2 marks)
(d) Which subject does Inès dislike? (1 mark)
(e) Who does Inès eat lunch with? (2 marks)
(f) What does Inès do on Wednesday afternoon, and why? (2 marks)
(g) How many students are there in the school? (1 mark)

(Total 12 marks)$mq$, $mq$(a) [1] Lycée Jean-Moulin
[1] Toulouse
(b) [1] 8 am / 08:00 (start)
[1] 4.30 pm / 16:30 (finish)
(c) [1] Biology
[1] The teacher is funny
(d) [1] Geography
(e) [1] Zoé
[1] Manon
(f) [1] She goes swimming
[1] She has no lessons (on Wednesday afternoon)
(g) [1] 1000 / one thousand$mq$, $mq$B$mq$),
(5, $mq$Read this programme for a school trip, then answer the questions in English.

VOYAGE SCOLAIRE À PARIS – 12 et 13 mai
Jeudi 12 mai : 7 h 30 départ en car devant le collège · 10 h 30 arrivée à Paris · 11 h 00 visite de la tour Eiffel · 12 h 30 pique-nique dans le parc · 14 h 30 musée du Louvre · 18 h 30 dîner à l'hôtel · 20 h 00 promenade en bateau sur la Seine
Vendredi 13 mai : 8 h 00 petit-déjeuner · 9 h 30 visite du Centre Pompidou · 12 h 00 déjeuner au restaurant · 14 h 00 shopping · 16 h 00 retour en car · 19 h 30 arrivée au collège
Prix : 120 €. Il faut apporter : une carte d'identité, un sac à dos, des chaussures confortables.

(a) When and where does the coach leave? (2 marks)
(b) How do the students travel to Paris? (1 mark)
(c) At what time do they arrive in Paris? (1 mark)
(d) What do they do at 12.30 on Thursday? (1 mark)
(e) What is the evening activity on Thursday after dinner? (1 mark)
(f) At what time is breakfast on Friday? (1 mark)
(g) Where do they have lunch on Friday? (1 mark)
(h) At what time do they leave Paris on Friday? (1 mark)
(i) How much does the trip cost? (1 mark)
(j) Name two things students must bring. (2 marks)

(Total 12 marks)$mq$, $mq$(a) [1] 7.30 am / 07:30 on Thursday
[1] In front of the school
(b) [1] By coach
(c) [1] 10.30 am / 10:30
(d) [1] A picnic in the park
(e) [1] A boat trip on the Seine
(f) [1] 8 am / 08:00
(g) [1] In a restaurant
(h) [1] 4 pm / 16:00
(i) [1] 120 euros
(j) [1] Any one of: ID card / backpack / comfortable shoes
[1] A different one of these$mq$, $mq$B$mq$),
(6, $mq$Read this blog post, then answer the questions in English.

Ma semaine de footballeur
Je m'appelle Kévin et je joue au foot dans un petit club. Le lundi, je me lève à six heures et demie. Je prends mon petit-déjeuner : du pain avec de la confiture et un chocolat chaud. Je vais au collège à vélo. Les cours commencent à huit heures et demie. Après l'école, je rentre à la maison et je fais mes devoirs. À dix-sept heures, j'ai entraînement au stade : nous courons, nous jouons au foot et nous travaillons la technique. Je rentre à dix-neuf heures. Je dîne avec ma famille, puis je regarde la télé ou j'écoute de la musique. Je me couche à vingt-deux heures. Le dimanche, nous avons un match : c'est le meilleur jour de la semaine ! Mon rêve, c'est de devenir joueur professionnel.

(a) Which sport does Kévin play? (1 mark)
(b) At what time does he get up on Monday? (1 mark)
(c) What does he have for breakfast? Give two details. (2 marks)
(d) How does he get to school? (1 mark)
(e) At what time do lessons start? (1 mark)
(f) What does he do when he gets home from school? (1 mark)
(g) At what time is training? (1 mark)
(h) Give two things the players do at training. (2 marks)
(i) At what time does he go to bed? (1 mark)
(j) What is Kévin's dream? (1 mark)

(Total 12 marks)$mq$, $mq$(a) [1] Football
(b) [1] 6.30 am / 06:30
(c) [1] Bread with jam
[1] Hot chocolate
(d) [1] By bike
(e) [1] 8.30 am / 08:30
(f) [1] Homework
(g) [1] 5 pm / 17:00
(h) [1] Any one of: run / play football / work on technique
[1] A different one of these
(i) [1] 10 pm / 22:00
(j) [1] To become a professional player/footballer$mq$, $mq$B$mq$),
(7, $mq$Section C: Language use and writing. Answer all parts.

Part 1. Choose the correct word from the box to complete each sentence. Use each word once.
du · de la · des · au · à la
(a) Je mange ______ pain au petit-déjeuner. (1 mark)
(b) Tu veux ______ salade ? (1 mark)
(c) Il y a ______ pommes dans le panier. (1 mark)
(d) Nous allons ______ piscine. (1 mark)
(e) Mon frère joue ______ football. (1 mark)

Part 2. Write these sentences in French. (3 marks)
(f) My sister is twelve years old.
(g) We are going to the cinema.
(h) I do not like fish.

Part 3. Each sentence has one mistake. Rewrite it correctly. (2 marks)
(i) Elle est quinze ans.
(j) Les garçons est contents.

(Total 10 marks)$mq$, $mq$(a) [1] du
(b) [1] de la
(c) [1] des
(d) [1] à la
(e) [1] au
(f) [1] Ma sœur a douze ans.
(g) [1] Nous allons au cinéma.
(h) [1] Je n'aime pas le poisson.
(i) [1] Elle a quinze ans. (avoir, not être, for age)
(j) [1] Les garçons sont contents. (plural verb form)
Accept minor spelling slips in (f)-(h) if the meaning and grammar are clear.$mq$, $mq$D$mq$),
(8, $mq$Writing task 1. You have just arrived at your exchange partner's house in France. Write a message of 60 to 80 words in French to your parents. In your message:
- say where you are and who you are staying with
- describe the weather
- say what you did today
- say what you will do tomorrow
- say what you think of the food
- ask them a question. (12 marks)

(Total 12 marks)$mq$, $mq$Communication (task points)
[1] Says where they are and who they are staying with
[1] Describes the weather (e.g. Il fait beau / Il pleut)
[1] Says what they did today (simple past or a clear attempt, e.g. J'ai visité la ville)
[1] Says what they will do tomorrow (e.g. Demain, je vais aller au musée)
[1] Gives an opinion on the food (e.g. La cuisine est délicieuse)
[1] Asks a question (e.g. Et vous, ça va ?)
Language
[4] Vocabulary and grammar: 4 = mostly accurate with some variety of structures; 3 = generally accurate, simple structures; 2 = frequent errors, message still understood; 1 = very limited; 0 = not understandable
Organisation and register
[2] Greeting and closing used; consistent register (Chers parents / Bisous); 1 if only one feature
Writing below about 40 words: cap the language marks at 2.
Note: Writing marks are awarded on the task, not on perfection: ab initio candidates are rewarded for clear, simple, mostly accurate French. Indicative Language Acquisition criterion levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$C$mq$),
(9, $mq$Writing task 2. Read this message from your French friend Chloé, then write a reply of 80 to 100 words in French.

Salut ! Samedi, je vais au parc d'attractions avec ma classe. Tu veux venir avec nous ? On part à neuf heures et on rentre à dix-huit heures. Le billet coûte vingt euros. Dis-moi si tu viens et ce que tu aimes comme attractions. Chloé

In your reply:
- thank Chloé and say whether you can come (give a reason if you cannot)
- say which rides you like or dislike
- ask where to meet
- ask what to bring. (12 marks)

(Total 12 marks)$mq$, $mq$Communication (task points)
[2] Thanks Chloé and says whether they can come; a reason or a positive reaction is given (1 mark for each)
[2] Says which rides they like and dislike (e.g. J'adore les montagnes russes, mais je n'aime pas la grande roue) (1 mark for each)
[1] Asks where to meet (e.g. On se retrouve où ?); also accept a question about when
[1] Asks what to bring
Language
[4] Vocabulary and grammar: 4 = mostly accurate with some variety; 3 = generally accurate, simple structures; 2 = frequent errors, message still understood; 1 = very limited; 0 = not understandable
Organisation and register
[2] Greeting and closing used; informal tu form kept throughout; 1 if only one feature
Accept any logical, original content. Writing below about 50 words: cap the language marks at 2.
Note: Writing marks are awarded on the task, not on perfection: ab initio candidates are rewarded for clear, simple, mostly accurate French. Indicative Language Acquisition criterion levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$C$mq$),
(10, $mq$Writing task 3. Write a blog post of 100 to 120 words in French with the title « Mes vacances idéales ». Include:
- where you would like to go and with whom
- what the weather is like there
- three activities you would do
- what you would eat
- why this would be your ideal holiday. (12 marks)

(Total 12 marks)$mq$, $mq$Content
[1] Where and with whom (e.g. Je voudrais aller en Espagne avec ma famille)
[1] Weather (e.g. Il fait chaud et il y a du soleil)
[3] Three activities (1 mark each; e.g. nager, visiter des musées, jouer au football)
[1] What they would eat
[1] A reason or opinion (e.g. parce que j'adore la plage)
Language
[3] Vocabulary and grammar: 3 = mostly accurate with some variety (including je voudrais / j'aimerais or future with aller); 2 = generally accurate, simple structures; 1 = frequent errors; 0 = not understandable
Organisation
[2] Title, clear paragraphs or sequence, connectives (et, mais, parce que, ensuite)
Writing below about 60 words: cap the language marks at 1.
Note: Writing marks are awarded on the task, not on perfection: ab initio candidates are rewarded for clear, simple, mostly accurate French. Indicative Language Acquisition criterion levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
