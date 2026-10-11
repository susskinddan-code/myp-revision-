-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- French ab initio MYP 5 eAssessment-style Practice Paper 2 (51 marks)
with sub as (select id from public.subjects where slug = $mq$french-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French ab initio MYP 5 eAssessment-style Practice Paper 2$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French ab initio MYP 5 eAssessment-style Practice Paper 2$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Listening transcript (imagine you hear this conversation twice). Read it, then answer in English.

À la gare
Client : Bonjour, je voudrais un billet pour Bordeaux, s'il vous plaît.
Employé : Un aller simple ou un aller-retour ?
Client : Un aller-retour. Je pars demain matin et je reviens dimanche.
Employé : Il y a un train à sept heures dix et un autre à neuf heures quarante.
Client : Je prends le train de neuf heures quarante. Ça coûte combien ?
Employé : Quarante-cinq euros. Vous payez par carte ou en espèces ?
Client : Par carte. Le train part de quel quai ?
Employé : Du quai numéro quatre.

(a) Where does the customer want to go? (1 mark)
(b) What type of ticket does he buy? (1 mark)
(c) On which day does he come back? (1 mark)
(d) Which train does he choose? (1 mark)
(e) How much does the ticket cost? (1 mark)
(f) How does he pay? (1 mark)
(g) From which platform does the train leave? (1 mark)

(Total 7 marks)$mq$, $mq$(a) [1] Bordeaux
(b) [1] Return (round-trip) ticket
(c) [1] Sunday
(d) [1] The 9.40 train (accept 09:40)
(e) [1] 45 euros
(f) [1] By card
(g) [1] Platform 4$mq$, $mq$A$mq$),
(2, $mq$Listening transcript (imagine you hear this weather forecast twice). Read it, then answer in English.

« Voici la météo pour demain. Dans le nord, il pleut le matin, mais l'après-midi il fait beau. Dans le sud, il fait très chaud : trente-deux degrés. À l'est, il y a du vent et il neige dans les montagnes. À l'ouest, le ciel est nuageux. Pour le week-end, on annonce du soleil partout. »

(a) What is the weather in the north in the morning? (1 mark)
(b) What is the temperature in the south? (1 mark)
(c) What is happening in the mountains in the east? (1 mark)
(d) Which region is windy? (1 mark)
(e) What is the sky like in the west? (1 mark)
(f) What weather is forecast for the weekend? (1 mark)

(Total 6 marks)$mq$, $mq$(a) [1] Rain / it is raining
(b) [1] 32 degrees
(c) [1] It is snowing
(d) [1] The east
(e) [1] Cloudy
(f) [1] Sunny everywhere / sun in all regions$mq$, $mq$A$mq$),
(3, $mq$Read this poster, then answer the questions in English.

CLUB DE THÉÂTRE – Collège Victor-Hugo
Tu aimes jouer, chanter ou danser ? Rejoins-nous !
Quand ? Le mercredi, de 14 h à 16 h.
Où ? Dans la salle des fêtes (pas dans le gymnase).
Prix : gratuit pour les élèves du collège ; 15 € par an pour les autres.
Le spectacle de fin d'année est le 12 juin.
Il faut apporter des vêtements confortables.
Inscriptions chez Madame Roche, au secrétariat, avant le 30 septembre.

(a) Name two activities mentioned in the poster. (2 marks)
(b) On which day and at what times does the club meet? (2 marks)
(c) How much do students from other schools pay? (1 mark)
(d) What should members bring? (1 mark)
(e) Who must you see to register, and by when? (2 marks)

(Total 8 marks)$mq$, $mq$(a) [1] Any one of: acting / singing / dancing
[1] A different one of these
(b) [1] Wednesday
[1] 2 pm to 4 pm (14:00-16:00)
(c) [1] 15 euros (a year)
(d) [1] Comfortable clothes
(e) [1] Madame Roche (at the school office)
[1] Before 30 September$mq$, $mq$B$mq$),
(4, $mq$Read this blog post, then answer the questions in English.

Mon week-end à la mer
Samedi, nous sommes partis à la plage en voiture. Il y avait beaucoup de monde parce qu'il faisait très chaud. J'ai nagé dans la mer, puis j'ai mangé une glace à la fraise avec ma cousine Inès. L'après-midi, nous avons joué au volley. Malheureusement, j'ai oublié ma crème solaire et j'ai pris un coup de soleil ! Dimanche, je suis restée à la maison pour faire mes devoirs et regarder un film. La semaine prochaine, nous allons visiter un château.

(a) How did the writer travel to the beach? (1 mark)
(b) Why was the beach crowded? (1 mark)
(c) Give two things the writer did at the beach. (2 marks)
(d) What went wrong at the beach? (1 mark)
(e) What did the writer do on Sunday? Give two details. (2 marks)
(f) What are they going to do next week? (1 mark)

(Total 8 marks)$mq$, $mq$(a) [1] By car
(b) [1] Because it was very hot
(c) [1] Any one of: swam in the sea / ate a strawberry ice cream / played volleyball
[1] A different one of these
(d) [1] She/he forgot the sunscreen and got sunburnt
(e) [1] Stayed at home
[1] Any one of: did homework / watched a film
(f) [1] Visit a castle$mq$, $mq$B$mq$),
(5, $mq$Complete each sentence with the correct French word or form. Write only the missing word(s).

(a) Marie ______ (prendre) le bus pour aller à l'école. (1 mark)
(b) Nous ______ (faire) nos devoirs après le dîner. (1 mark)
(c) Je n'______ pas de frère. (avoir) (1 mark)
(d) ______ chat s'appelle Moka. (my) (1 mark)
(e) Put this sentence into the negative: Il mange de la viande. (1 mark)
(f) Write in French: I play tennis on Saturdays. (1 mark)

(Total 6 marks)$mq$, $mq$(a) [1] prend
(b) [1] faisons
(c) [1] ai
(d) [1] Mon
(e) [1] Il ne mange pas de viande.
(f) [1] Je joue au tennis le samedi. (accept: Je joue au tennis tous les samedis)$mq$, $mq$D$mq$),
(6, $mq$Writing task. You are organising your birthday party. Write an invitation message of about 60 words in French to your friend Léo. In your message:
- say when the party is and where
- say what time it starts
- say what food and drink there will be
- ask Léo to reply. (8 marks)

(Total 8 marks)$mq$, $mq$Communication (task points)
[1] Says when the party is (e.g. samedi 14 mai) and where (e.g. chez moi / au parc)
[1] Says what time it starts (e.g. à dix-huit heures)
[1] Says what food and drink there will be (e.g. Il y a de la pizza et du jus d'orange)
[1] Asks Léo to reply (e.g. Réponds-moi vite ! / Tu peux venir ?)
Language
[2] Vocabulary and grammar: 2 = mostly accurate and understandable, some variety; 1 = frequent errors but the message can be understood; 0 = not understandable
Organisation and register
[2] Greeting (Salut Léo !) and closing (À bientôt) used; informal tu form used consistently; 1 if only one of these features
Writing below about 40 words: cap the language marks at 1.
Note: Writing marks are awarded on the task, not on perfection: ab initio candidates are rewarded for clear, simple, mostly accurate French. Indicative Language Acquisition criterion levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$C$mq$),
(7, $mq$Writing task. A French exchange student has asked about the town where you live. Write an email of 80 to 100 words in French. Include:
- the name of your town and where it is
- two places in the town and what you do there
- what you did last weekend
- an invitation for the student to visit. (8 marks)

(Total 8 marks)$mq$, $mq$Content
[2] Names the town and says where it is (e.g. J'habite à Camden, c'est dans le nord de Londres)
[2] Two places and activities (e.g. Il y a un parc où je joue au football ; il y a un cinéma)
[1] Says what they did last weekend (simple past or a clear attempt, e.g. Samedi, j'ai regardé un film)
[1] Invitation to visit (e.g. Tu peux venir chez moi en été !)
Language
[1] Correct verb forms (avoir, être, aller, jouer) and agreement in most places
Structure
[1] Greeting and closing used; ideas linked with et, mais, parce que

Note: Writing marks are awarded on the task, not on perfection: ab initio candidates are rewarded for clear, simple, mostly accurate French. Indicative Language Acquisition criterion levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
