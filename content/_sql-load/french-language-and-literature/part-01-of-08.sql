-- Part 1 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Reading and Comprehension > Literal and Inferential Understanding
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Reading and Comprehension$mq$, 5, 1 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Literal and Inferential Understanding$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Reading and Comprehension$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Literal and Inferential Understanding$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Qu'est-ce que la compréhension littérale d'un texte ?$mq$, $mq$["Comprendre ce qui est dit explicitement dans le texte","Deviner ce que l'auteur pense en secret","Juger si le texte est beau","Résumer le texte en un seul mot"]$mq$, 0, $mq$La compréhension littérale porte sur les informations écrites noir sur blanc : qui, quoi, où, quand.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce qu'une inférence ?$mq$, $mq$["Une citation exacte du texte","Une faute d'orthographe","Le titre d'un chapitre","Une conclusion tirée d'indices du texte et de ses connaissances"]$mq$, 3, $mq$Inférer, c'est « lire entre les lignes » : on combine des indices du texte et ce que l'on sait pour comprendre ce qui n'est pas dit directement.$mq$, $mq$easy$mq$),
($mq$Extrait inventé : « Léa referma son parapluie et secoua ses bottes sur le paillasson. » Quelle information est littérale ?$mq$, $mq$["Léa vient d'arriver chez quelqu'un","Il a plu toute la journée","Léa referme son parapluie","Léa est fatiguée"]$mq$, 2, $mq$Le texte dit explicitement que Léa referme son parapluie. Les autres propositions sont des déductions ou des suppositions.$mq$, $mq$easy$mq$),
($mq$Quelle question demande une réponse littérale ?$mq$, $mq$["Pourquoi le narrateur semble-t-il inquiet ?","Où se passe la scène d'ouverture ?","Que ressent probablement le personnage ?","Quel message l'auteur veut-il transmettre ?"]$mq$, 1, $mq$« Où se passe la scène ? » se répond en repérant une information donnée dans le texte. Les autres exigent une interprétation.$mq$, $mq$easy$mq$),
($mq$Quand on justifie une inférence, que faut-il faire ?$mq$, $mq$["Appuyer sa réponse sur un mot ou une phrase du texte","Donner son opinion sans preuve","Recopier tout le paragraphe","Changer le sens du texte"]$mq$, 0, $mq$Une inférence valable s'appuie toujours sur une preuve précise du texte, citée brièvement.$mq$, $mq$easy$mq$),
($mq$Extrait inventé : « Samir regardait l'horloge toutes les trente secondes. Ses doigts tambourinaient sur la table. » Quelle inférence est la mieux justifiée ?$mq$, $mq$["Samir est en colère contre son voisin","Samir s'ennuie profondément à la cantine","Samir vient de gagner un prix","Samir est impatient ou nerveux"]$mq$, 3, $mq$Regarder l'horloge sans cesse et tambouriner sont des indices d'impatience ou de nervosité. Rien n'indique la colère ou la joie.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Le village dormait encore quand Inès referma la porte sans bruit. Sa valise l'attendait sur le chemin. » Que peut-on inférer ?$mq$, $mq$["Inès rentre chez elle après un long voyage","Inès déménage avec toute sa famille","Inès part discrètement, peut-être en cachette","Inès prépare un pique-nique"]$mq$, 2, $mq$« Dormait encore », « sans bruit » et la valise prête suggèrent un départ discret. Le texte ne dit pas qu'elle rentre ni qu'elle est accompagnée.$mq$, $mq$medium$mq$),
($mq$Une élève écrit : « Le personnage est triste parce qu'il pleure. » Quel est le principal défaut de cette réponse ?$mq$, $mq$["Elle est trop longue","Elle confond l'émotion et la cause : la cause n'est pas prouvée","Elle ne cite aucun mot du texte","Elle utilise le présent"]$mq$, 1, $mq$Pleurer peut venir de la joie, de la douleur ou de la tristesse. Il faut chercher dans le texte la cause réelle, avec une citation.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Il était 8 h 05 quand le car démarra, avec cinq minutes de retard. » Quelle réponse est littérale ?$mq$, $mq$["Le car part à 8 h 05","Le chauffeur est irresponsable","Les passagers sont furieux","Le car ratera sa correspondance"]$mq$, 0, $mq$L'heure du départ est écrite dans le texte. Les autres réponses sont des suppositions non confirmées.$mq$, $mq$medium$mq$),
($mq$Pourquoi le contexte aide-t-il à comprendre un mot inconnu ?$mq$, $mq$["Parce que le dictionnaire est interdit","Parce que tous les mots ont le même sens","Parce que l'on peut ignorer le mot","Parce que les mots voisins donnent des indices sur son sens"]$mq$, 3, $mq$Les mots et phrases autour d'un terme inconnu (synonymes, exemples, opposition) orientent vers son sens.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « La cour était silencieuse. Même les pigeons avaient déserté le toit. » Que suggère cette phrase ?$mq$, $mq$["Une ambiance joyeuse","Une fête de quartier","Une atmosphère pesante, vide ou inquiétante","Un concours d'oiseaux"]$mq$, 2, $mq$Le silence total et l'absence même des pigeons créent une impression de vide et de tension. C'est une inférence sur l'atmosphère.$mq$, $mq$medium$mq$),
($mq$Quelle structure de réponse correspond à une bonne réponse inférentielle ?$mq$, $mq$["Citation seule, sans commentaire","Affirmation + citation + explication du lien","Résumé de toute l'histoire","Opinion personnelle sans référence au texte"]$mq$, 1, $mq$On avance une idée, on la prouve par une citation courte, puis on explique en quoi la citation la soutient (modèle de type PEE).$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Madame Roux sourit en lisant la lettre, puis la glissa dans son tiroir, sous les factures. » Quelle question est inférentielle ?$mq$, $mq$["Pourquoi Madame Roux cache-t-elle peut-être la lettre ?","Où Madame Roux range-t-elle la lettre ?","Que fait Madame Roux en lisant ?","Quel objet lit-elle ?"]$mq$, 0, $mq$Les trois autres questions ont une réponse écrite dans le texte. « Pourquoi la cache-t-elle ? » demande une hypothèse appuyée sur « sous les factures ».$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Quand le directeur annonça le nom du gagnant, Tom applaudit le premier, mais ses yeux restèrent fixés sur ses chaussures. » Quelle lecture est la plus nuancée ?$mq$, $mq$["Tom est sincèrement ravi pour le gagnant","Tom est indifférent à tout","Tom est sourd","Tom feint peut-être la joie : il applaudit mais évite les regards, ce qui trahit de la déception"]$mq$, 3, $mq$Le contraste entre le geste (applaudir) et l'attitude (regard baissé) permet d'inférer une émotion cachée. Une bonne réponse relie les deux indices.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « — Tout va très bien, dit Hugo en rangeant pour la quatrième fois son sac. » Quel effet produit la répétition « pour la quatrième fois » ?$mq$, $mq$["Elle prouve que Hugo est ordonné et serein","Elle sert uniquement à donner l'heure","Elle contredit ses paroles et révèle son anxiété","Elle montre que le sac est trop petit"]$mq$, 2, $mq$Le geste répété contredit l'affirmation « tout va très bien » : l'écart entre dire et faire révèle l'inquiétude du personnage.$mq$, $mq$hard$mq$),
($mq$Un élève répond : « Le narrateur déteste la ville. » Citation à l'appui : « Elle l'entourait de toutes parts, immense, indifférente. » Pourquoi cette inférence est-elle fragile ?$mq$, $mq$["Le mot « ville » n'est pas dans la citation","La citation montre l'impression d'écrasement et d'indifférence, pas forcément la haine","La citation est trop courte","Il ne faut jamais citer"]$mq$, 1, $mq$« Immense, indifférente » exprime un sentiment d'écrasement ou de solitude. « Déteste » va plus loin que les indices : il faut des preuves proportionnées à la conclusion.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Il y avait trois tasses sur la table, mais Claire n'en sortit que deux du placard. » Quelle inférence est la plus plausible ?$mq$, $mq$["Quelqu'un manque ou n'est plus attendu, ce que Claire sait peut-être déjà","Claire a oublié la troisième tasse","Claire déteste le thé","Les tasses sont cassées"]$mq$, 0, $mq$Le décalage entre trois tasses déjà présentes et deux sorties suggère une absence significative. Un lecteur attentif formule l'hypothèse et la nuance (« peut-être »).$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Le facteur déposa l'enveloppe. Elle resta trois jours sur le buffet, intacte, tandis que Mathis passait devant sans la regarder. » Quelle formulation montre l'inférence la plus convaincante ?$mq$, $mq$["Mathis est paresseux car il ne lit pas","Mathis ne sait pas lire","Le facteur s'est trompé d'adresse","Mathis évite peut-être cette lettre : « sans la regarder » suggère qu'il craint son contenu"]$mq$, 3, $mq$La durée (trois jours), l'enveloppe « intacte » et l'évitement du regard convergent vers la crainte. La bonne réponse cite un indice et reste prudente.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Literal and Inferential Understanding$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Compréhension littérale$mq$, $mq$Comprendre les informations écrites explicitement dans le texte : qui, quoi, où, quand. La réponse se repère directement dans le texte.$mq$),
($mq$Inférence$mq$, $mq$Conclusion tirée d'indices du texte et de ses connaissances, sur ce qui n'est pas dit directement. On « lit entre les lignes ».$mq$),
($mq$Structure d'une réponse inférentielle$mq$, $mq$Affirmation, citation courte du texte, puis explication du lien entre la citation et l'idée.$mq$),
($mq$Verbes de nuance utiles$mq$, $mq$suggérer, laisser penser, révéler, sembler, évoquer, laisser deviner. Ils évitent les certitudes que le texte ne permet pas.$mq$),
($mq$Indice textuel$mq$, $mq$Mot, geste, contraste, répétition ou détail du cadre qui permet de justifier une interprétation.$mq$),
($mq$Pourquoi citer le texte ?$mq$, $mq$La citation prouve que l'interprétation vient du texte et non d'une opinion personnelle. Elle doit être courte et bien choisie.$mq$),
($mq$Erreur : confondre fait et supposition$mq$, $mq$« Il pleure donc il est triste » n'est pas prouvé : il faut chercher la cause dans le texte avant de conclure.$mq$),
($mq$Consigne « relevez »$mq$, $mq$Elle demande un repérage littéral : on copie ou reformule avec précision une information ou un mot du texte.$mq$),
($mq$Consigne « que suggère... ? »$mq$, $mq$Elle demande une inférence : interpréter l'effet ou le sens implicite d'un passage en s'appuyant sur une preuve.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Literal and Inferential Understanding$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## L'essentiel
Lire un texte, c'est d'abord comprendre ce qu'il dit, puis ce qu'il suggère. En classe de Langue et Littérature, on distingue donc deux niveaux de compréhension : la compréhension **littérale** et la compréhension **inférentielle**. Les épreuves d'examen testent presque toujours les deux, souvent dans la même question.

## La compréhension littérale
Elle porte sur les informations explicites : les personnages, le lieu, le moment, les actions, les faits. La réponse se trouve directement dans le texte, parfois dans une seule phrase. Pour répondre, il suffit de repérer, de relever ou de reformuler avec précision.
- **Qui ?** Les personnages et le narrateur.
- **Où et quand ?** Les indications de lieu et de temps.
- **Quoi ?** Les événements dans leur ordre.
- **Comment ?** Les manières d'agir, les descriptions.
Exemple : dans la phrase « Léa referma son parapluie », l'information littérale est que Léa referme son parapluie. On ne dit pas qu'il pleut, même si l'on peut le deviner.

## La compréhension inférentielle
Inférer signifie tirer une conclusion à partir d'indices. L'auteur ne dit pas tout : il laisse le lecteur combler les silences. Pour inférer, on associe trois éléments : un **indice** du texte, une **connaissance** du monde ou du contexte, et un **raisonnement**.
Exemple : « Samir regardait l'horloge toutes les trente secondes. » Indice : le regard répété sur l'horloge. Connaissance : on regarde l'heure quand on attend ou quand on s'ennuie. Conclusion : Samir est impatient.

## Comment justifier une inférence
Une bonne réponse suit une structure simple : **affirmation, preuve, explication**.
- J'affirme une idée (le personnage cache sa déception).
- Je cite un court passage entre guillemets, comme « ses yeux restèrent fixés sur ses chaussures ».
- J'explique le lien : ce regard baissé contredit les applaudissements et trahit un sentiment contraire.
Utilisez des verbes de nuance : *suggérer*, *laisser penser*, *révéler*, *sembler*. Évitez les certitudes quand le texte n'en donne pas.

## Types d'indices à repérer
- Les actions et gestes (tambouriner, détourner le regard).
- Les choix de mots, avec leurs connotations.
- Les contrastes entre ce que dit un personnage et ce qu'il fait.
- Les répétitions, les silences, la ponctuation.
- Le cadre et l'atmosphère (une cour vide, un ciel lourd).

## Erreurs fréquentes
- Confondre un fait et une supposition : « il pleure donc il est triste » est trop rapide, car on peut pleurer de joie.
- Répondre sans citer le texte.
- Recopier une longue phrase au lieu de choisir les mots clés.
- Aller plus loin que les indices : une conclusion forte exige des preuves fortes.
- Résumer au lieu d'interpréter quand la consigne demande « expliquez ce que cela suggère ».

## Comment cela est évalué
À l'examen, un texte court est suivi de questions qui commencent par un repérage (« relevez », « indiquez »), puis passent à l'interprétation (« expliquez », « que suggère... »). Le critère A récompense la compréhension du contenu et du contexte, l'analyse des choix de l'auteur et l'appui sur des exemples précis.

Exam tip: pour chaque question inférentielle, écrivez une idée, une citation courte et une phrase qui explique le lien entre les deux ; si vous ne pouvez pas citer d'indice, votre inférence est trop fragile.$mq$ from st;

-- Reading and Comprehension > Purpose and Audience
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Reading and Comprehension$mq$, 5, 1 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Purpose and Audience$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Reading and Comprehension$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Purpose and Audience$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Que désigne le « but » (ou l'intention) d'un texte ?$mq$, $mq$["Ce que l'auteur cherche à obtenir : informer, convaincre, divertir, etc.","Le nombre de ses pages","Le nom de son éditeur","La couleur de la couverture"]$mq$, 0, $mq$Le but est l'objectif de l'auteur : informer, persuader, divertir, émouvoir, expliquer, avertir.$mq$, $mq$easy$mq$),
($mq$Que désigne le « public cible » d'un texte ?$mq$, $mq$["L'auteur du texte","Les lecteurs du siècle dernier","Les personnages","Les personnes à qui le texte s'adresse en priorité"]$mq$, 3, $mq$Le public cible est le groupe de lecteurs visé : enfants, élèves, habitants d'un quartier, spécialistes, etc.$mq$, $mq$easy$mq$),
($mq$Une brochure invite les habitants à voter « oui » pour la création d'une piste cyclable. Quel est son but principal ?$mq$, $mq$["Divertir","Raconter une légende","Convaincre","Décrire un paysage"]$mq$, 2, $mq$Inviter à voter d'une certaine façon relève de la persuasion : l'auteur veut influencer le lecteur.$mq$, $mq$easy$mq$),
($mq$Quel texte a pour but principal d'informer ?$mq$, $mq$["Un tract électoral","Un article scientifique sur la migration des oies","Une publicité pour des baskets","Un poème d'amour"]$mq$, 1, $mq$Un article scientifique présente des faits de façon objective, dans un but informatif.$mq$, $mq$easy$mq$),
($mq$Quel type de contenu s'adresse le plus probablement à de jeunes enfants ?$mq$, $mq$["Des phrases courtes, un vocabulaire simple et des illustrations","Des termes techniques et de longues phrases","Des statistiques détaillées","Des citations de lois"]$mq$, 0, $mq$Le registre, la longueur des phrases et les images s'adaptent à l'âge du public visé.$mq$, $mq$easy$mq$),
($mq$Extrait inventé : « Vous êtes fatigué de chercher en vain vos clés ? Offrez-vous la sérénité ! » Quelle marque de l'intention de l'auteur est la plus claire ?$mq$, $mq$["Le récit au passé simple","Le ton neutre d'un dictionnaire","L'absence de verbes","La question adressée directement au lecteur et la promesse"]$mq$, 3, $mq$L'interpellation (« vous ») et la promesse sont typiques d'un texte publicitaire qui cherche à convaincre d'acheter.$mq$, $mq$medium$mq$),
($mq$Extrait inventé d'une affiche : « Cet été, sauvons ensemble nos plages ! Rejoignez la collecte du samedi. » Quel public est le plus probablement visé ?$mq$, $mq$["Les touristes étrangers uniquement","Les professeurs de physique","Les habitants prêts à agir localement","Les nourrissons"]$mq$, 2, $mq$« Nos plages » et « le samedi » visent une communauté locale invitée à participer à une action.$mq$, $mq$medium$mq$),
($mq$Un texte utilise « nous » dans « Nous devons agir maintenant ». Quel effet cherche-t-il ?$mq$, $mq$["Exclure le lecteur","Créer une impression de communauté et d'urgence partagée","Montrer que l'auteur ne s'intéresse à personne","Écrire à la troisième personne"]$mq$, 1, $mq$Le « nous » inclusif rapproche l'auteur du lecteur et invite à agir collectivement.$mq$, $mq$medium$mq$),
($mq$Deux textes parlent du même sujet : l'un dans un journal pour adolescents, l'autre dans une revue médicale. Qu'est-ce qui changera le plus ?$mq$, $mq$["Le niveau de langue, le vocabulaire et les exemples","Le sujet","L'alphabet","Le nombre de lettres par mot"]$mq$, 0, $mq$Le public détermine le registre, le lexique technique et le type d'exemples choisis.$mq$, $mq$medium$mq$),
($mq$Extrait inventé d'un règlement : « Il est interdit de courir dans les couloirs. » Quel est son but principal ?$mq$, $mq$["Émouvoir","Faire rire","Raconter une anecdote","Instruire et imposer une règle"]$mq$, 3, $mq$La forme impersonnelle et l'interdiction montrent un texte normatif : il informe et fixe une obligation.$mq$, $mq$medium$mq$),
($mq$Un texte peut-il avoir plusieurs buts ?$mq$, $mq$["Non, un seul but est possible","Seulement s'il est un roman","Oui : par exemple informer et convaincre à la fois","Seulement s'il est court"]$mq$, 2, $mq$Beaucoup de textes combinent des buts : un article d'opinion informe puis cherche à persuader. On identifie le but dominant.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Tu as 15 ans ? Alors tu sais déjà ce que valent trois heures d'écran de trop ! » Quel indice montre le public visé ?$mq$, $mq$["Le point d'exclamation seulement","Le tutoiement et la référence à l'âge","Le mot « heures »","Le passé simple"]$mq$, 1, $mq$Le tutoiement et la mention de l'âge ciblent explicitement des adolescents.$mq$, $mq$medium$mq$),
($mq$Pourquoi une association écologiste choisit-elle plutôt un ton émotionnel qu'un ton purement statistique pour un tract ?$mq$, $mq$["Parce que l'émotion peut mobiliser un large public et déclencher l'action","Par erreur","Parce que les chiffres sont interdits","Parce que le tract est un roman"]$mq$, 0, $mq$Lorsque le but est de convaincre un public large, l'émotion, associée à quelques faits, peut être plus efficace que des chiffres seuls.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Selon une enquête, 62 % des élèves dorment moins de huit heures. Pourtant, rien ne change dans nos emplois du temps. » Quelle analyse est la plus précise ?$mq$, $mq$["Le texte informe uniquement, sans point de vue","Il raconte une aventure","Il n'a aucun public","Il utilise un fait pour amorcer une critique : il informe puis cherche à persuader"]$mq$, 3, $mq$Le chiffre sert d'argument, et le « pourtant » introduit un reproche : le but est mixte, avec une visée persuasive dominante.$mq$, $mq$hard$mq$),
($mq$Un discours inventé commence par : « Chers camarades, je ne vais pas vous mentir : l'année a été difficile. » Que produit ce début ?$mq$, $mq$["Un effet de distance formelle","Un effet comique obligatoire","Un effet de franchise qui crée la confiance avant l'argumentation","Un résumé du discours"]$mq$, 2, $mq$« Je ne vais pas vous mentir » met en scène l'honnêteté de l'orateur et prépare l'adhésion du public.$mq$, $mq$hard$mq$),
($mq$Un même éditorial est publié dans un quotidien national, puis adapté pour un site d'élèves de 12 ans. Quelle modification serait la plus pertinente pour le second public ?$mq$, $mq$["Ajouter du jargon juridique","Raccourcir les phrases, expliquer les termes difficiles et choisir des exemples proches de leur vie","Supprimer le titre","Doubler la longueur du texte"]$mq$, 1, $mq$Adapter un texte à un public plus jeune, c'est simplifier la syntaxe, expliciter les mots complexes et rapprocher les exemples de son vécu.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Le Conseil rappelle que les inscriptions se terminent le 30. Aucune exception ne sera tolérée. » Quelle conclusion sur l'auteur et le public est la mieux fondée ?$mq$, $mq$["Une institution s'adresse à des administrés avec un ton autoritaire et impersonnel","Un ami s'adresse affectueusement à un autre","Un enfant écrit à son grand-père","Un poète évoque la nature"]$mq$, 0, $mq$« Le Conseil », la forme impersonnelle et « aucune exception » révèlent une voix institutionnelle qui impose une règle.$mq$, $mq$hard$mq$),
($mq$Dans une question d'examen, on demande : « Comment l'auteur adapte-t-il son texte à son public ? » Quelle réponse est la plus complète ?$mq$, $mq$["Il écrit en français.","Il utilise des lettres.","Il parle de lui.","Il emploie le tutoiement, un vocabulaire courant et des exemples de la vie scolaire, ce qui crée une proximité avec des élèves"]$mq$, 3, $mq$Une réponse complète nomme des procédés précis, cite ou décrit des exemples et explique leur effet sur le public visé.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Purpose and Audience$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$But d'un texte$mq$, $mq$Ce que l'auteur veut obtenir : informer, convaincre, divertir, émouvoir, expliquer ou avertir. On identifie le but dominant.$mq$),
($mq$Public cible$mq$, $mq$Le groupe de lecteurs visé par l'auteur. On le repère grâce au pronom, au niveau de langue, au vocabulaire et aux exemples.$mq$),
($mq$Effet du « nous » inclusif$mq$, $mq$Il crée une communauté entre l'auteur et le lecteur et suggère une responsabilité ou une action partagée.$mq$),
($mq$Effet du tutoiement$mq$, $mq$Il crée de la proximité et de la complicité, souvent pour s'adresser à des jeunes ou à des proches.$mq$),
($mq$Texte persuasif : exemples$mq$, $mq$Publicité, tract, discours, éditorial, affiche de campagne. Ils cherchent à influencer les idées ou les actes du lecteur.$mq$),
($mq$Texte informatif : traits$mq$, $mq$Ton neutre, faits vérifiables, vocabulaire précis, structure claire (titres, paragraphes). Exemples : article, encyclopédie.$mq$),
($mq$Texte à but mixte$mq$, $mq$Un texte peut informer puis persuader. On nomme le but dominant et on explique comment les autres buts le soutiennent.$mq$),
($mq$Adapter son texte au public$mq$, $mq$Choisir le ton, le registre, le vocabulaire et les exemples qui conviennent aux lecteurs visés.$mq$),
($mq$Réponse sur le public : structure$mq$, $mq$Nommer le but, nommer le public, citer un procédé, expliquer son effet sur ce public.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Purpose and Audience$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Pourquoi se poser ces questions ?
Tout texte est écrit par quelqu'un, pour quelqu'un, dans un but précis. Comprendre le **but** (ou l'intention) et le **public** (ou destinataire) permet d'expliquer pourquoi l'auteur choisit tel ton, tel vocabulaire ou tel procédé. À l'examen, ces notions servent presque toujours de point de départ à l'analyse.

## Les principaux buts d'un texte
- **Informer** : donner des faits clairs, souvent dans un ton neutre (article scientifique, encyclopédie, compte rendu).
- **Convaincre ou persuader** : amener le lecteur à penser ou à agir d'une certaine façon (publicité, tract, discours, éditorial).
- **Divertir** : amuser, faire rêver ou raconter (roman, nouvelle, bande dessinée).
- **Émouvoir** : toucher les sentiments (poème, témoignage, lettre).
- **Expliquer ou instruire** : montrer comment faire ou ce qu'il faut respecter (mode d'emploi, règlement).
- **Avertir** : prévenir d'un danger (affiche de prévention).
Un texte peut combiner plusieurs buts. Par exemple, un article d'opinion informe d'abord avec un chiffre, puis persuade grâce à une critique. On identifie alors le but **dominant**.

## Le public cible
Le public est le groupe de lecteurs que l'auteur a en tête. On le repère grâce à plusieurs indices.
- Le **pronom** : *tu* (proximité, jeunes), *vous* (formel ou collectif), *nous* (communauté), *on* (voix commune).
- Le **niveau de langue** : familier, courant, soutenu.
- Le **vocabulaire** : technique ou accessible.
- Les **références** : exemples tirés de la vie scolaire, du sport, de la politique locale...
- La **forme** : phrases courtes ou longues, présence d'illustrations, mise en page.
Exemple inventé : « Tu as 15 ans ? Alors tu sais déjà ce que valent trois heures d'écran de trop ! » Le tutoiement et l'âge cité désignent des adolescents. L'auteur veut créer de la complicité.

## Le lien entre but, public et choix d'écriture
On ne parle pas de la même manière à un enfant de 8 ans, à un conseil municipal ou à des camarades. L'auteur ajuste :
- le **ton** (sérieux, ironique, chaleureux, autoritaire) ;
- le **registre de langue** ;
- les **arguments** (faits, émotions, exemples) ;
- la **structure** (titre accrocheur, paragraphes courts, appel à l'action).
Une association écologiste qui veut mobiliser un large public mélangera souvent faits et émotion. Une institution qui rappelle une règle emploiera plutôt le ton impersonnel : « Aucune exception ne sera tolérée. »

## Comment rédiger une bonne réponse
Pour répondre à « Quel est le but du texte et comment s'adresse-t-il à son public ? », suivez ces étapes.
- Nommez le but dominant en un mot précis.
- Nommez le public visé.
- Citez un ou deux procédés (pronom, question, exemple, ton).
- Expliquez l'effet de chaque procédé sur le lecteur.

## Erreurs fréquentes
- Dire seulement « le texte informe » alors qu'un texte persuade aussi par ses choix de mots.
- Citer un indice sans expliquer son effet.
- Confondre l'auteur et le narrateur, ou le public visé et le public réel.
- Oublier le contexte de publication : journal, affiche, site, discours.

## Comment cela est évalué
Les questions d'examen demandent de relever des indices de but et de public, puis de justifier avec précision l'intention de l'auteur. Le critère A valorise l'analyse des choix de l'auteur en relation avec le public et le contexte.

Exam tip: commencez toujours par nommer le but dominant et le public, puis reliez chaque procédé cité à son effet sur ce public, par exemple : « Le tutoiement crée de la proximité avec des adolescents ».$mq$ from st;

-- Reading and Comprehension > Tone and Attitude
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Reading and Comprehension$mq$, 5, 1 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Tone and Attitude$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Reading and Comprehension$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Tone and Attitude$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Que désigne le « ton » d'un texte ?$mq$, $mq$["L'attitude de l'auteur ou du narrateur perceptible dans l'écriture","Le nombre de phrases","Le volume de la voix du lecteur","La police de caractères"]$mq$, 0, $mq$Le ton est la manière dont l'auteur s'exprime et l'attitude qu'on perçoit : ironique, joyeux, grave, etc.$mq$, $mq$easy$mq$),
($mq$Quel mot décrit un ton qui se moque en disant le contraire de ce que l'on pense ?$mq$, $mq$["Lyrique","Neutre","Épique","Ironique"]$mq$, 3, $mq$L'ironie consiste à dire une chose pour en faire comprendre une autre, souvent pour critiquer.$mq$, $mq$easy$mq$),
($mq$Extrait inventé : « Quel délicieux temps de chien ! » dit-il en patinant dans la boue. Quel ton domine ?$mq$, $mq$["Admiratif","Solennel","Ironique","Technique"]$mq$, 2, $mq$« Délicieux » contredit « temps de chien » et la boue : le personnage ironise sur une situation désagréable.$mq$, $mq$easy$mq$),
($mq$Quel ton est le plus proche de l'indifférence calme, sans émotion visible ?$mq$, $mq$["Passionné","Détaché","Indigné","Enthousiaste"]$mq$, 1, $mq$Un ton détaché évite l'émotion et décrit sans s'impliquer.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce qu'un ton « mélancolique » ?$mq$, $mq$["Une tristesse douce, nostalgique","Une colère explosive","Une joie bruyante","Une moquerie légère"]$mq$, 0, $mq$La mélancolie évoque une tristesse rêveuse, souvent liée à un souvenir ou à l'absence.$mq$, $mq$easy$mq$),
($mq$Extrait inventé : « Les feuilles tombaient une à une, comme les années. Je ne les comptais plus. » Quel ton ressort ?$mq$, $mq$["Comique","Agressif","Publicitaire","Mélancolique"]$mq$, 3, $mq$La comparaison avec les années qui passent et « je ne les comptais plus » expriment une tristesse nostalgique.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Encore une réunion sur la réunion précédente : quel progrès extraordinaire pour l'humanité ! » Quel est l'effet principal ?$mq$, $mq$["Admiration sincère","Description scientifique","Satire amusée et critique","Tristesse profonde"]$mq$, 2, $mq$L'hyperbole « progrès extraordinaire pour l'humanité » appliquée à une réunion inutile produit une critique ironique.$mq$, $mq$medium$mq$),
($mq$Quelle attitude de l'auteur montre l'expression « ce misérable petit règlement » ?$mq$, $mq$["Du respect","Du mépris ou de l'agacement","De l'indifférence","De la reconnaissance"]$mq$, 1, $mq$« Misérable » et « petit » sont des adjectifs dépréciatifs : ils révèlent un jugement négatif.$mq$, $mq$medium$mq$),
($mq$Quel procédé crée le plus clairement un ton urgent ?$mq$, $mq$["Des phrases courtes, des impératifs et des points d'exclamation","Des phrases longues et lentes","Des subordonnées enchaînées","Des descriptions détaillées du ciel"]$mq$, 0, $mq$Rythme rapide, impératifs et exclamations donnent une impression d'urgence : « Agissez ! Vite ! »$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Le vieux pont tenait encore. Fier, il portait le poids de tous les étés. » Quelle figure marque l'attitude du narrateur ?$mq$, $mq$["Une antithèse violente","Une énumération technique","Une négation","Une personnification qui exprime de la tendresse et du respect"]$mq$, 3, $mq$Le pont « fier » qui « porte » est personnifié : le narrateur lui prête des qualités humaines avec affection.$mq$, $mq$medium$mq$),
($mq$Quelle différence y a-t-il entre le ton et le thème ?$mq$, $mq$["Aucune","Le ton est le titre ; le thème est la fin","Le thème est le sujet traité ; le ton est la manière de le traiter","Le ton est toujours drôle"]$mq$, 2, $mq$Un même thème, comme la perte d'un objet, peut être traité sur un ton comique, grave ou tendre.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Je dois admettre que le chat m'a battu : il a mangé mon sandwich avec une élégance remarquable. » Quel ton domine ?$mq$, $mq$["Tragique","Humoristique et autodérision","Solennel","Menaçant"]$mq$, 1, $mq$Le narrateur rit de sa propre défaite et attribue de l'élégance à un vol : c'est humoristique, avec de l'autodérision.$mq$, $mq$medium$mq$),
($mq$Pour justifier qu'un ton est « nostalgique », quelle réponse est la plus solide ?$mq$, $mq$["Le champ lexical du souvenir (« jadis », « autrefois ») et l'imparfait évoquent un passé regretté, ce qui crée une douce nostalgie.","Le texte est nostalgique parce qu'il est triste.","Le texte est long.","Le texte utilise des mots."]$mq$, 0, $mq$Une bonne justification nomme des procédés précis (lexique, temps verbal), les cite et explique l'effet produit.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « On nous a dit de rester calmes. Calmes ! Alors que la porte tremblait... » Quel effet produit la reprise de « Calmes ! » ?$mq$, $mq$["Elle montre que tout va bien","Elle explique un règlement","Elle crée un ton neutre","Elle exprime l'indignation et l'inquiétude du narrateur"]$mq$, 3, $mq$La répétition exclamative contredit la consigne par la situation : le narrateur est révolté et angoissé.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Il lui serra la main avec une chaleur de réfrigérateur. » Quelle lecture est la plus fine ?$mq$, $mq$["Le geste est très chaleureux","Le narrateur parle de cuisine","La comparaison inattendue révèle la froideur réelle du personnage, avec une pointe d'humour","Le personnage est malade"]$mq$, 2, $mq$« Chaleur de réfrigérateur » associe deux idées contradictoires (chaleur et froid) : l'effet est comique, car il dit la froideur en feignant de parler de chaleur.$mq$, $mq$hard$mq$),
($mq$Un narrateur décrit une scène terrible avec des phrases brèves, des mots simples et aucun adjectif. Quel effet recherche-t-il probablement ?$mq$, $mq$["Faire rire le lecteur","Atténuer l'horreur par un ton volontairement neutre qui la rend plus frappante","Allonger le texte","Cacher le lieu"]$mq$, 1, $mq$Le contraste entre un style sobre et une situation dramatique renforce l'impact : c'est un effet de retenue.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Nos ancêtres, disait-on, étaient sages. Pourtant, ils ont construit la ville sur le marais. Quelle sagesse ! » Quelle attitude l'auteur adopte-t-il ?$mq$, $mq$["Il critique avec ironie la prétendue sagesse des ancêtres","Il admire les ancêtres sans réserve","Il décrit objectivement la géographie","Il raconte une légende sans commentaire"]$mq$, 0, $mq$« Pourtant » oppose la réputation à un fait, et « Quelle sagesse ! » renverse le sens : il s'agit d'une ironie critique.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Elle sourit poliment. Elle sourit encore. Elle sourit jusqu'à ce que ses joues tremblent. » Que révèle la gradation ?$mq$, $mq$["Un bonheur croissant","Une leçon de grammaire","Un simple compte rendu","Un effort pénible pour cacher un malaise"]$mq$, 3, $mq$La répétition et la précision « jusqu'à ce que ses joues tremblent » montrent que le sourire est forcé : le ton devient tendu et mal à l'aise.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Tone and Attitude$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Ton$mq$, $mq$L'attitude perceptible de l'auteur ou du narrateur dans l'écriture : ironique, mélancolique, solennel, humoristique, etc.$mq$),
($mq$Différence ton / thème$mq$, $mq$Le thème est le sujet traité ; le ton est la manière de le traiter. Un même thème peut être grave ou comique.$mq$),
($mq$Ironie$mq$, $mq$Dire le contraire de ce que l'on pense, ou feindre d'approuver, pour critiquer ou se moquer. Elle repose sur un décalage.$mq$),
($mq$Ton mélancolique$mq$, $mq$Une tristesse douce et rêveuse, souvent liée au souvenir, au temps qui passe ou à l'absence.$mq$),
($mq$Ton urgent$mq$, $mq$Il se marque par des phrases courtes, des impératifs et des exclamations qui donnent un rythme rapide.$mq$),
($mq$Lexique dépréciatif$mq$, $mq$Mots négatifs (misérable, médiocre) qui révèlent un jugement défavorable. Le lexique mélioratif exprime une opinion positive.$mq$),
($mq$Atmosphère$mq$, $mq$L'impression générale que le texte produit sur le lecteur : pesante, légère, inquiétante, apaisante.$mq$),
($mq$Analyser un ton en trois étapes$mq$, $mq$Nommer le ton avec précision, citer deux indices, expliquer comment ils créent ce ton et quel effet ils ont.$mq$),
($mq$Style sobre devant un drame$mq$, $mq$Des phrases simples et neutres face à un événement terrible peuvent renforcer l'émotion par contraste : c'est un effet de retenue.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Tone and Attitude$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Ton, attitude et atmosphère
Le **ton** est la couleur émotionnelle d'un texte : c'est ce que l'on perçoit de l'attitude de l'auteur ou du narrateur envers son sujet ou son lecteur. L'**attitude** est le point de vue ou le sentiment sous-jacent : admiration, mépris, tendresse, indifférence. Il ne faut pas confondre le ton avec le **thème** (le sujet) ni avec l'**atmosphère**, qui est l'impression générale produite sur le lecteur, par exemple une ambiance pesante.

## Quelques tons à connaître
- **Ironique** : on dit le contraire de ce que l'on pense pour critiquer.
- **Humoristique** : on cherche à amuser, parfois avec de l'autodérision.
- **Mélancolique** : une tristesse douce, liée au souvenir ou à l'absence.
- **Lyrique** : l'expression de sentiments personnels intenses.
- **Solennel** : grave et formel, comme dans un discours officiel.
- **Indigné** : la colère face à une injustice.
- **Détaché** ou **neutre** : peu d'émotion visible, on décrit sans s'impliquer.
- **Urgent** ou **pressant** : phrases courtes, impératifs, exclamations.
- **Nostalgique** : un regret tendre du passé.
- **Sarcastique** : une ironie plus dure, blessante.

## Comment identifier le ton
Pour repérer le ton, observez plusieurs éléments.
- Le **lexique** : mots valorisants (merveilleux, noble) ou dépréciatifs (misérable, médiocre). Les adjectifs et adverbes sont très révélateurs.
- La **ponctuation** : points d'exclamation, points de suspension, questions.
- Le **rythme** : phrases courtes (tension, urgence) ou longues (rêverie, lenteur).
- Les **figures de style** : hyperbole, personnification, comparaison, oxymore.
- Le **contraste** entre ce qui est dit et la situation : c'est la base de l'ironie.
Exemple inventé : « Encore une réunion sur la réunion précédente : quel progrès extraordinaire pour l'humanité ! » L'hyperbole appliquée à une chose banale signale la critique ironique.

## Le ton peut changer
Dans un même texte, le ton évolue parfois. Un récit peut commencer sur un ton léger puis devenir grave. Relever ce changement et l'expliquer (rupture, contraste, phrase pivot) est un signe d'analyse fine. Le narrateur peut aussi paraître neutre et pourtant orienter le lecteur par ses choix de mots : un style sobre devant un événement dramatique peut renforcer l'émotion.

## Rédiger une analyse du ton
Utilisez la démarche suivante :
- **Nommer** le ton avec un mot précis (pas seulement « triste » ou « gentil »).
- **Citer** deux indices courts : mot, ponctuation, figure ou rythme.
- **Expliquer** comment chaque indice crée ce ton.
- **Relier** à l'effet sur le lecteur ou au sens du texte.
Exemple : « Le ton est mélancolique : le narrateur compare les feuilles qui tombent aux années, et l'expression « je ne les comptais plus » exprime une lassitude résignée. »

## Erreurs fréquentes
- Employer un adjectif vague (« le ton est bien ») sans preuve.
- Nommer le ton sans citer d'indice.
- Confondre ton et sujet : « le ton est la guerre » est incorrect.
- Ne pas voir l'ironie et lire la phrase au premier degré.
- Ignorer l'évolution du ton au fil du texte.

## Comment cela est évalué
Les questions d'examen demandent souvent : « Quel ton se dégage de ce passage ? Justifiez avec des exemples. » Le critère A évalue la précision du vocabulaire d'analyse et la qualité des preuves. Un lexique varié pour nommer les tons améliore nettement la réponse.

Exam tip: quand vous hésitez entre ironie et sincérité, cherchez un décalage entre les mots employés et la situation décrite ; si les deux se contredisent, c'est très probablement de l'ironie.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;