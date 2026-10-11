-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- French ab initio MYP 5 eAssessment-style Practice Paper 1 (52 marks)
with sub as (select id from public.subjects where slug = $mq$french-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French ab initio MYP 5 eAssessment-style Practice Paper 1$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French ab initio MYP 5 eAssessment-style Practice Paper 1$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Listening transcript (imagine you hear this voice message twice). Read it, then answer in English.

Message vocal de Camille :
« Salut Léa, c'est Camille. Samedi, on va au cinéma avec Hugo et Nina. Le film commence à quinze heures trente. On se retrouve devant la gare à quinze heures. Le billet coûte huit euros. Après le film, nous mangeons une pizza chez Hugo. Prends un parapluie, il va pleuvoir ! Tu peux répondre avant jeudi ? À samedi ! »

(a) What are the friends going to do on Saturday? (1 mark)
(b) At what time does the film start? (1 mark)
(c) Where and at what time will they meet? (2 marks)
(d) How much does a ticket cost? (1 mark)
(e) What will they do after the film, and where? (2 marks)

(Total 7 marks)$mq$, $mq$(a) [1] Go to the cinema / see a film
(b) [1] 3.30 pm / 15:30
(c) [1] In front of the (train) station
[1] At 3 pm / 15:00 (do not accept 3.30 pm)
(d) [1] 8 euros
(e) [1] Eat pizza
[1] At Hugo's (house)
Common error: giving 'on Thursday' for the meeting time; Thursday is the reply deadline.$mq$, $mq$A$mq$),
(2, $mq$Listening transcript (imagine you hear this school announcement twice). Read it, then answer in English.

Annonce du collège :
« Bonjour à tous les élèves. Voici les informations pour demain. Le cours de sport est annulé parce que le professeur est malade. Les élèves de la classe 10B vont à la bibliothèque à neuf heures. Le déjeuner est à midi vingt à la cantine. Il y a du poulet avec du riz ou une pizza végétarienne. N'oubliez pas : la sortie au musée est vendredi, et il faut apporter vingt euros. Merci et bonne journée ! »

(a) Why is the sport lesson cancelled? (1 mark)
(b) Where does class 10B go tomorrow, and at what time? (2 marks)
(c) At what time is lunch? (1 mark)
(d) Give the two lunch choices. (2 marks)
(e) What must students bring for the museum trip? (1 mark)

(Total 7 marks)$mq$, $mq$(a) [1] The teacher is ill / sick
(b) [1] The library
[1] 9 o'clock / 9 am
(c) [1] 12.20 / twenty past twelve
(d) [1] Chicken with rice
[1] Vegetarian pizza
(e) [1] 20 euros / money (accept: twenty euros)$mq$, $mq$A$mq$),
(3, $mq$Read this email, then answer the questions in English.

De : maxime.durand@exemple.fr
Objet : Ma famille

Salut Tom !
Je m'appelle Maxime et j'ai quinze ans. J'habite à Lyon, dans un appartement près du centre-ville. Dans ma famille, nous sommes cinq : mes parents, ma sœur Chloé, mon petit frère Louis et moi. Mon père est infirmier et ma mère est professeure de musique. Chloé a dix-sept ans ; elle aime lire et elle déteste le sport. Louis a sept ans et il adore jouer au football. Nous avons aussi un chat qui s'appelle Moka. Le week-end, nous faisons souvent une promenade au parc. Et toi, tu as des frères et sœurs ? Écris-moi vite !
Maxime

(a) How old is Maxime? (1 mark)
(b) What type of home does Maxime live in? (1 mark)
(c) How many people are in Maxime's family? (1 mark)
(d) What is Maxime's mother's job? (1 mark)
(e) Write True, False or Not mentioned for each statement. (3 marks)
   (i) Chloé loves sport.
   (ii) Louis is seven years old.
   (iii) Maxime's father works in a hospital.
(f) What does the family often do at the weekend? (1 mark)

(Total 8 marks)$mq$, $mq$(a) [1] 15
(b) [1] An apartment / a flat
(c) [1] Five
(d) [1] Music teacher
(e) [1] (i) False (she hates sport)
[1] (ii) True
[1] (iii) Not mentioned (he is a nurse; no place of work is given)
(f) [1] They go for a walk in the park$mq$, $mq$B$mq$),
(4, $mq$Read this café menu, then answer the questions in English.

CAFÉ LE SOLEIL
Boissons : café 2 € · thé 2,50 € · jus d'orange 3 € · eau minérale 1,50 €
Plats : soupe du jour 5 € · croque-monsieur 6,50 € · omelette au fromage 7 € · salade niçoise 8 €
Desserts : glace (vanille, fraise ou chocolat) 4 € · tarte aux pommes 4,50 € · crêpe au sucre 3,50 €
Menu enfant (moins de 10 ans) : croque-monsieur + jus d'orange + glace = 9 €
Fermé le lundi. Ouvert de 8 h à 21 h.

(a) On which day is the café closed? (1 mark)
(b) Name two ice cream flavours. (2 marks)
(c) Nadia orders the soup of the day and an apple tart. How much does she pay? Show your working. (2 marks)
(d) What is included in the children's menu? (3 marks)

(Total 8 marks)$mq$, $mq$(a) [1] Monday
(b) [1] Any one of vanilla / strawberry / chocolate
[1] A different one of the three
(c) [1] 5 + 4.50 (working shown)
[1] 9.50 euros
(d) [1] Croque-monsieur (toasted ham and cheese sandwich)
[1] Orange juice
[1] Ice cream$mq$, $mq$B$mq$),
(5, $mq$Complete each sentence with the correct French word or form. Write only the missing word(s).

(a) Nous ______ (habiter) à Marseille. (1 mark)
(b) Elle ______ (avoir) quinze ans. (1 mark)
(c) Mes amis ______ (aller) au cinéma le samedi. (1 mark)
(d) Tu ______ (être) content de ton cadeau ? (1 mark)
(e) Ma cousine est très ______ (intelligent). (1 mark)
(f) Mes sœurs sont ______ (grand). (1 mark)

(Total 6 marks)$mq$, $mq$(a) [1] habitons
(b) [1] a
(c) [1] vont
(d) [1] es
(e) [1] intelligente (feminine agreement)
(f) [1] grandes (feminine plural agreement)$mq$, $mq$D$mq$),
(6, $mq$Writing task. You are staying with a French host family. Write a text message of about 60 words in French to your host brother Sam. In your message:
- say where you are now
- say what you did at school today
- say what you would like to eat this evening
- ask what time dinner is. (8 marks)

(Total 8 marks)$mq$, $mq$Communication (task points)
[1] Says where they are (e.g. Je suis à la bibliothèque / à l'école)
[1] Says what they did at school today (accept simple present or past, e.g. J'ai joué au basket / Je fais du sport)
[1] Says what they would like to eat (e.g. Je voudrais des pâtes)
[1] Asks the time of dinner (e.g. Le dîner est à quelle heure ?)
Language
[2] Vocabulary and grammar: 2 = mostly accurate and understandable, some variety; 1 = frequent errors but the message can be understood; 0 = not understandable
Organisation and register
[2] Greeting (Salut Sam !) and closing (À tout à l'heure) used; informal tu form used consistently; 1 if only one of these features
Accept any logical, original content. Writing below about 40 words: cap the language marks at 1.
Note: Writing marks are awarded on the task, not on perfection: ab initio candidates are rewarded for clear, simple, mostly accurate French. Indicative Language Acquisition criterion levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$C$mq$),
(7, $mq$Writing task. A French penfriend, Julie, has asked you to introduce yourself. Write an email of 80 to 100 words in French. Include:
- your name, age and where you live
- two people in your family
- two hobbies you like and one you do not like
- a question for Julie. (8 marks)

(Total 8 marks)$mq$, $mq$Content
[2] Gives name, age and where they live (Je m'appelle..., j'ai ... ans, j'habite à ...)
[2] Describes two family members (e.g. Mon père s'appelle Paul ; j'ai une petite sœur)
[2] Two likes and one dislike (J'aime..., j'adore..., je n'aime pas...) and a question for Julie (1 mark for hobbies, 1 mark for the question)
Language
[1] Correct verb forms (être, avoir, habiter, aimer) and gender agreement in most places
Structure
[1] Greeting and closing used; ideas linked with et, mais, parce que
Note: Writing marks are awarded on the task, not on perfection: ab initio candidates are rewarded for clear, simple, mostly accurate French. Indicative Language Acquisition criterion levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
