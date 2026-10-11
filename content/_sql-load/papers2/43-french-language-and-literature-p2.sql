-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- French Language & Literature MYP 5 eAssessment-style Practice Paper 2 (44 marks)
with sub as (select id from public.subjects where slug = $mq$french-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French Language & Literature MYP 5 eAssessment-style Practice Paper 2$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French Language & Literature MYP 5 eAssessment-style Practice Paper 2$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Texte A (un récit de voyage, écrit pour cette épreuve)

On arrive à Port-Calade comme on entre dans une phrase longue : sans savoir où elle finira. Le train de nuit nous a déposés à six heures du matin sur un quai encore humide, et la ville, devant nous, se réveillait par morceaux : un volet qui claque, un camion de livraison qui recule en poussant son petit cri électrique, une odeur de pain chaud qui sortait d'une porte entrouverte comme une promesse.

J'ai suivi cette odeur. Elle m'a conduit à travers des ruelles si étroites que les balcons s'embrassaient presque au-dessus de ma tête, puis sur le port, où les bateaux de pêche se balançaient, orange et bleus, dans une eau couleur d'étain. Des hommes réparaient des filets en échangeant des phrases courtes, rythmées, comme on joue aux cartes.

— Vous êtes perdu ? m'a demandé une boulangère en essuyant ses mains sur son tablier.

— Je crois que je viens de me trouver, ai-je répondu, et j'ai tout de suite regretté cette phrase trop belle.

Elle a ri, m'a tendu une brioche encore tiède et n'a rien voulu en échange.

Le soleil s'est levé derrière la jetée à ce moment-là, et toute la ville a pris la couleur du miel. J'ai pensé que certains endroits ne se visitent pas : ils vous adoptent.

Lisez le texte A, puis répondez aux questions.

(a) Relevez deux détails du premier paragraphe qui montrent que la ville est en train de se réveiller. (2 marks)

(b) Expliquez ce que la réaction du narrateur à la question de la boulangère suggère de ses sentiments. (2 marks)$mq$, $mq$(a)
[1] One relevant detail, e.g. « un volet qui claque » ; « un camion de livraison qui recule » ; « une odeur de pain chaud » ; la ville « se réveillait par morceaux ».
[1] A second, different relevant detail from the first paragraph.
(b)
[1] A valid inference, e.g. the narrator feels welcomed, happy and a little self-conscious; he has found a place where he feels at home.
[1] Supported by reference, e.g. « Je crois que je viens de me trouver » followed by « j'ai tout de suite regretté cette phrase trop belle » (he is moved but embarrassed by his own sentimental words).
Accept other valid inferences supported by the text.$mq$, $mq$A$mq$),
(2, $mq$Texte A (un récit de voyage, écrit pour cette épreuve)

On arrive à Port-Calade comme on entre dans une phrase longue : sans savoir où elle finira. Le train de nuit nous a déposés à six heures du matin sur un quai encore humide, et la ville, devant nous, se réveillait par morceaux : un volet qui claque, un camion de livraison qui recule en poussant son petit cri électrique, une odeur de pain chaud qui sortait d'une porte entrouverte comme une promesse.

J'ai suivi cette odeur. Elle m'a conduit à travers des ruelles si étroites que les balcons s'embrassaient presque au-dessus de ma tête, puis sur le port, où les bateaux de pêche se balançaient, orange et bleus, dans une eau couleur d'étain. Des hommes réparaient des filets en échangeant des phrases courtes, rythmées, comme on joue aux cartes.

— Vous êtes perdu ? m'a demandé une boulangère en essuyant ses mains sur son tablier.

— Je crois que je viens de me trouver, ai-je répondu, et j'ai tout de suite regretté cette phrase trop belle.

Elle a ri, m'a tendu une brioche encore tiède et n'a rien voulu en échange.

Le soleil s'est levé derrière la jetée à ce moment-là, et toute la ville a pris la couleur du miel. J'ai pensé que certains endroits ne se visitent pas : ils vous adoptent.

Analysez comment l'auteur crée une impression d'accueil et de découverte dans ce récit de voyage. Vous pouvez commenter, par exemple : les comparaisons, les sens, les couleurs, le dialogue et la dernière phrase. (6 marks)$mq$, $mq$[1] Explains the opening simile « comme on entre dans une phrase longue » : arrival as an open-ended journey, uncertainty mixed with curiosity.
[1] Comments on the sensory details (le volet, le cri du camion, l'odeur du pain) : the town wakes up through sounds and smells, which draws the reader in.
[1] Comments on the personification « les balcons s'embrassaient » : the narrow streets feel friendly and intimate.
[1] Comments on colour imagery (bateaux orange et bleus, eau couleur d'étain, ville couleur du miel) : a palette that moves from cool to warm as the day opens.
[1] Comments on the dialogue and the baker's kindness (brioche tiède, rien en échange) : warmth of the people.
[1] Explains the final sentence « ils vous adoptent » : reversal of the tourist's role, ending on belonging.
Award marks for effect, not for feature-spotting. Accept other valid, well-supported points.$mq$, $mq$A$mq$),
(3, $mq$Texte B (une courte scène de théâtre, écrite pour cette épreuve)

LA CLÉ

Décor : le couloir d'un lycée, tard le vendredi. Des casiers métalliques alignés. NORA, seize ans, est assise par terre devant un casier ouvert. M. BELLOC, le surveillant, arrive en faisant tinter un trousseau de clés.

M. BELLOC : Dix-huit heures, Nora. À dix-huit heures, je ferme.
NORA : (sans lever la tête) Encore deux minutes.
M. BELLOC : Tu dis ça depuis vingt minutes.
(Silence. Au loin, une porte claque. Nora sort du casier une feuille froissée et la lisse du plat de la main.)
NORA : La liste de l'équipe pour le championnat régional. Ils ont pris Léa.
M. BELLOC : (s'asseyant lentement, avec un craquement de genoux) Ah.
NORA : « Ah » ? C'est tout ?
M. BELLOC : Quand j'avais ton âge, je voulais être pilote. On ne m'a pas pris non plus. (Un temps.) Je ne dis pas que ça aide.
NORA : (un petit rire qui ressemble à un hoquet) Non. Ça n'aide pas.
M. BELLOC : Mais regarde : je suis toujours ici, et je ferme encore l'école chaque soir. Quelqu'un doit le faire.
(Il se relève et lui tend la main. Nora hésite, puis la prend. Les lumières du couloir clignotent, puis s'éteignent une à une.)
NORA : (dans la pénombre) Monsieur ? Demain, vous ouvrez à quelle heure ?
M. BELLOC : Sept heures.
NORA : Alors je serai là à sept heures cinq.

Lisez le texte B.

Analysez comment l'auteur utilise les didascalies, le dialogue et le rythme pour créer de la tension, puis de l'espoir. (6 marks)$mq$, $mq$[1] Comments on the opening setting (couloir vide, casiers, tard le vendredi) : isolation and a sense of the end of the day.
[1] Explains how the repeated closing time (« Dix-huit heures... à dix-huit heures, je ferme ») creates a ticking-clock pressure.
[1] Comments on sound and silence in the stage directions (porte qui claque au loin, silences, craquement de genoux) : the awkwardness and fragility of the moment.
[1] Comments on the short, plain lines (« Ah. » / « C'est tout ? ») : emotional distance that shows Nora's hurt and Belloc's clumsiness.
[1] Comments on the gesture of the hand and the lights going out one by one : physical action replaces words, tension eases into comfort.
[1] Explains the final exchange (« sept heures cinq ») : humour and determination show hope for tomorrow.
Accept other valid, well-supported points on stagecraft and dialogue.$mq$, $mq$A$mq$),
(4, $mq$Texte B (une courte scène de théâtre, écrite pour cette épreuve)

LA CLÉ

Décor : le couloir d'un lycée, tard le vendredi. Des casiers métalliques alignés. NORA, seize ans, est assise par terre devant un casier ouvert. M. BELLOC, le surveillant, arrive en faisant tinter un trousseau de clés.

M. BELLOC : Dix-huit heures, Nora. À dix-huit heures, je ferme.
NORA : (sans lever la tête) Encore deux minutes.
M. BELLOC : Tu dis ça depuis vingt minutes.
(Silence. Au loin, une porte claque. Nora sort du casier une feuille froissée et la lisse du plat de la main.)
NORA : La liste de l'équipe pour le championnat régional. Ils ont pris Léa.
M. BELLOC : (s'asseyant lentement, avec un craquement de genoux) Ah.
NORA : « Ah » ? C'est tout ?
M. BELLOC : Quand j'avais ton âge, je voulais être pilote. On ne m'a pas pris non plus. (Un temps.) Je ne dis pas que ça aide.
NORA : (un petit rire qui ressemble à un hoquet) Non. Ça n'aide pas.
M. BELLOC : Mais regarde : je suis toujours ici, et je ferme encore l'école chaque soir. Quelqu'un doit le faire.
(Il se relève et lui tend la main. Nora hésite, puis la prend. Les lumières du couloir clignotent, puis s'éteignent une à une.)
NORA : (dans la pénombre) Monsieur ? Demain, vous ouvrez à quelle heure ?
M. BELLOC : Sept heures.
NORA : Alors je serai là à sept heures cinq.

Lisez le texte B.

(a) Identifiez le but de ce texte et le public visé. Appuyez-vous sur un élément du texte. (2 marks)

(b) Nora dit « vous » à M. Belloc, qui lui dit « tu ». Expliquez ce que ce choix de registre révèle de leur relation. (2 marks)$mq$, $mq$(a)
[1] Purpose: to entertain and to explore a young person's disappointment and the comfort of an unexpected adult, supported by e.g. « Ils ont pris Léa » or « Je ne dis pas que ça aide ».
[1] Audience: a school or youth theatre audience, or teenage readers who can recognise rejection and a kind adult.
(b)
[1] Identifies the difference: Nora uses the respectful « vous » (and « Monsieur »), while Belloc uses the familiar « tu ».
[1] Explains: it reflects the school hierarchy and respect, but his « tu » shows he treats her with warmth and closeness, so the relationship is formal on the surface and caring underneath.
Accept other valid comments on register (e.g. short colloquial sentences, « Ah »).$mq$, $mq$D$mq$),
(5, $mq$Texte C (un poème, écrit pour cette épreuve)

Grenier

Sous le toit, la poussière dort
comme une neige qui n'a pas fondu.
Les malles gardent leurs secrets
avec des serrures rouillées de silence.

J'y retrouve la robe de ma mère,
bleue encore, d'un bleu de dimanche,
et ses manches vides qui m'attendent
comme deux bras qu'on n'ose plus ouvrir.

On croit que le temps s'en va.
Non : il s'assoit, il se tait,
il attend dans l'ombre des cartons
qu'un enfant monte l'escalier.

Alors je ferme la malle doucement,
comme on ferme les yeux d'un ami,
et je laisse un peu de lumière
sous la porte, pour qu'il ne s'ennuie pas.

Analysez comment le poète utilise les images et la structure pour présenter le temps et la mémoire. Vous pouvez commenter, par exemple : les comparaisons, la personnification, la progression des strophes et la dernière strophe. (6 marks)$mq$, $mq$[1] Explains the simile « comme une neige qui n'a pas fondu » and « serrures rouillées de silence » : dust and silence preserve the past, stillness and age.
[1] Comments on the mother's dress, « bleue encore, d'un bleu de dimanche » : colour and detail make memory concrete and tender.
[1] Explains « manches vides » compared to « deux bras qu'on n'ose plus ouvrir » : absence, and the speaker's hesitation to face grief.
[1] Comments on the personification of time (« il s'assoit, il se tait, il attend ») : time is patient, not an enemy, which changes the usual view of loss.
[1] Comments on structure : four stanzas that move from the attic, to the dress, to a general reflection, to a gesture of care.
[1] Explains the ending : closing the trunk « comme on ferme les yeux d'un ami » and leaving light under the door show respect and love; the last line is gentle and consoling.
Accept other valid, well-supported points.$mq$, $mq$A$mq$),
(6, $mq$Texte A (un récit de voyage, écrit pour cette épreuve)

On arrive à Port-Calade comme on entre dans une phrase longue : sans savoir où elle finira. Le train de nuit nous a déposés à six heures du matin sur un quai encore humide, et la ville, devant nous, se réveillait par morceaux : un volet qui claque, un camion de livraison qui recule en poussant son petit cri électrique, une odeur de pain chaud qui sortait d'une porte entrouverte comme une promesse.

J'ai suivi cette odeur. Elle m'a conduit à travers des ruelles si étroites que les balcons s'embrassaient presque au-dessus de ma tête, puis sur le port, où les bateaux de pêche se balançaient, orange et bleus, dans une eau couleur d'étain. Des hommes réparaient des filets en échangeant des phrases courtes, rythmées, comme on joue aux cartes.

— Vous êtes perdu ? m'a demandé une boulangère en essuyant ses mains sur son tablier.

— Je crois que je viens de me trouver, ai-je répondu, et j'ai tout de suite regretté cette phrase trop belle.

Elle a ri, m'a tendu une brioche encore tiède et n'a rien voulu en échange.

Le soleil s'est levé derrière la jetée à ce moment-là, et toute la ville a pris la couleur du miel. J'ai pensé que certains endroits ne se visitent pas : ils vous adoptent.

Texte C (un poème, écrit pour cette épreuve)

Grenier

Sous le toit, la poussière dort
comme une neige qui n'a pas fondu.
Les malles gardent leurs secrets
avec des serrures rouillées de silence.

J'y retrouve la robe de ma mère,
bleue encore, d'un bleu de dimanche,
et ses manches vides qui m'attendent
comme deux bras qu'on n'ose plus ouvrir.

On croit que le temps s'en va.
Non : il s'assoit, il se tait,
il attend dans l'ombre des cartons
qu'un enfant monte l'escalier.

Alors je ferme la malle doucement,
comme on ferme les yeux d'un ami,
et je laisse un peu de lumière
sous la porte, pour qu'il ne s'ennuie pas.

Comparez la manière dont les auteurs des textes A et C présentent un lieu et son effet sur celui qui parle. Dans votre réponse, comparez les idées, puis le langage ou la structure, en citant brièvement les textes. (6 marks)$mq$, $mq$[1] Identifies a similarity, e.g. both texts give their settings human qualities (les balcons qui « s'embrassent » ; le temps qui « s'assoit » dans le grenier) and present them as comforting to the speaker.
[1] Identifies a difference in tone or mood : Text A is lively and joyful (discovery in the present), Text C is quiet and nostalgic (memory in the past).
[1] Compares the use of imagery, e.g. a sensory, outdoor, colourful setting versus a dark, enclosed, silent attic.
[1] Compares structure or form : a first-person travel narrative with dialogue and a closing reflection versus a short free-verse poem in stanzas with a gesture at the end.
[1] Supports at least one point from each text with an accurate short quotation.
[1] The comparison is sustained and organised, with connectives such as « alors que », « tandis que », « de même ».
Accept other valid comparisons.$mq$, $mq$B$mq$),
(7, $mq$Rédigez un texte descriptif d'environ 300 mots intitulé « Le premier matin ». Vous pouvez l'écrire sous forme de récit de voyage ou de début de nouvelle. Choisissez un lieu que vous connaissez ou que vous imaginez. Votre texte doit captiver un lecteur adolescent. (12 marks)

Vous serez évalué(e) sur le but et la conscience du public, la structure de votre texte, vos techniques descriptives, ainsi que la richesse et la justesse de votre langue.$mq$, $mq$[1] The purpose, to describe and engage, is clear and sustained.
[1] There is clear awareness of a teenage audience, with appropriate tone and content.
[1] The chosen form (travel writing or story opening) is recognisable and the register is consistent.
[1] The opening is engaging and establishes place and time.
[1] Sensory details (at least three senses, or varied senses) bring the place to life.
[1] Figurative language (comparisons, metaphors, personification) is used purposefully and is original rather than cliché.
[1] The description is organised, e.g. moving from wide to close focus, or following the narrator's movement.
[1] Paragraphs are used effectively, with a clear progression.
[1] Connectives and time markers create cohesion.
[1] Sentence length and structure are varied for effect.
[1] Verb tenses (e.g. imparfait/passé composé or présent) are controlled; agreement, accents and spelling are mostly accurate.
[1] The ending is effective and leaves an impression.
Credit any valid approach that meets these qualities.$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
