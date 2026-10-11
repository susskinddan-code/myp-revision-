-- Part 5 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Non-Fiction and Media > Persuasive Techniques
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Non-Fiction and Media$mq$, 5, 5 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Persuasive Techniques$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Non-Fiction and Media$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Persuasive Techniques$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Qu'est-ce que le pathos dans un texte persuasif ?$mq$, $mq$["Un appel aux émotions du destinataire","Un appel à la logique et aux chiffres","Un appel à la crédibilité de l'auteur","Une répétition de sons"]$mq$, 0, $mq$Le pathos cherche à émouvoir (pitié, peur, joie, indignation). La logique relève du logos et la crédibilité de l'ethos.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce qu'une question rhétorique ?$mq$, $mq$["Une question dont la réponse figure dans le texte","Une question posée par le professeur en classe","Une question qui contient une faute","Une question posée sans attendre de vraie réponse, pour renforcer un argument"]$mq$, 3, $mq$« Peut-on vraiment rester sans rien faire ? » n'attend pas de réponse : elle suggère que la réponse est évidente.$mq$, $mq$easy$mq$),
($mq$« Rejoignez-nous ! Signez maintenant ! Agissez ! » Quel mode verbal domine dans cet appel ?$mq$, $mq$["Le subjonctif","Le conditionnel","L'impératif","L'infinitif"]$mq$, 2, $mq$L'impératif donne des ordres ou des conseils pressants : il pousse le lecteur à l'action.$mq$, $mq$easy$mq$),
($mq$Le logos désigne l'appel…$mq$, $mq$["à la pitié","à la raison : faits, chiffres, raisonnement","à la réputation de l'orateur","à l'humour"]$mq$, 1, $mq$Le logos s'appuie sur des preuves logiques : statistiques, exemples vérifiables, enchaînement d'arguments.$mq$, $mq$easy$mq$),
($mq$Quel procédé consiste à répéter le même mot au début de phrases successives ?$mq$, $mq$["L'anaphore","L'antithèse","La litote","La comparaison"]$mq$, 0, $mq$L'anaphore (« Nous voulons… Nous voulons… ») crée un effet de rythme et d'insistance.$mq$, $mq$easy$mq$),
($mq$Affiche inventée : « Plus d'un million de jeunes ont déjà adopté ce carnet : et vous ? » Quel type d'argument est utilisé ?$mq$, $mq$["Le recours à un expert","La menace","L'humour noir","L'appel à la majorité (effet de groupe)"]$mq$, 3, $mq$On pousse le lecteur à suivre « tout le monde ». Ce n'est pas une preuve que le produit est bon.$mq$, $mq$medium$mq$),
($mq$« En tant que médecin depuis vingt ans, je vous assure que ce sirop est efficace. » Quel appel l'auteur utilise-t-il surtout ?$mq$, $mq$["Le pathos","Le logos","L'ethos","L'ironie"]$mq$, 2, $mq$L'ethos s'appuie sur la crédibilité de celui qui parle (son métier, son expérience). Aucun fait n'est cité.$mq$, $mq$medium$mq$),
($mq$« Ce bruit gêne, fatigue, rend malade. » Quel procédé organise cette phrase ?$mq$, $mq$["Une antithèse","Une gradation","Un euphémisme","Une métaphore filée"]$mq$, 1, $mq$Gêner, fatiguer, rendre malade : l'intensité augmente à chaque verbe. C'est une gradation.$mq$, $mq$medium$mq$),
($mq$Quelle phrase exprime une opinion et non un fait ?$mq$, $mq$["Les bus sont beaucoup trop lents.","Le réseau compte douze lignes de bus.","La ligne 4 passe toutes les dix minutes.","Le billet coûte deux euros."]$mq$, 0, $mq$« Beaucoup trop lents » est un jugement personnel. Les autres phrases donnent des informations vérifiables.$mq$, $mq$medium$mq$),
($mq$« Nous devons protéger notre rivière. » Quel est l'effet du pronom « nous » ?$mq$, $mq$["Il exclut le lecteur du débat","Il rend le texte plus objectif","Il indique que l'auteur hésite","Il inclut le lecteur et crée une complicité"]$mq$, 3, $mq$« Nous » et « notre » rassemblent l'auteur et son public : le lecteur se sent concerné.$mq$, $mq$medium$mq$),
($mq$« Neuf élèves sur dix sont d'accord. » On ne précise ni qui a été interrogé ni combien de personnes. Quelle est la faiblesse de cet argument ?$mq$, $mq$["Il est trop poétique","Il utilise l'impératif","Il manque de source, donc il est difficile à vérifier","Il est écrit au passé"]$mq$, 2, $mq$Une statistique sans source, sans échantillon ni date peut être trompeuse, même si elle paraît objective.$mq$, $mq$medium$mq$),
($mq$« Cette montagne de devoirs m'écrase ! » Quel procédé est employé ?$mq$, $mq$["L'euphémisme","L'hyperbole","La litote","L'énumération"]$mq$, 1, $mq$Une « montagne » de devoirs exagère pour impressionner : c'est une hyperbole.$mq$, $mq$medium$mq$),
($mq$Pourquoi les slogans utilisent-ils souvent trois éléments (« Informer, convaincre, mobiliser ») ?$mq$, $mq$["Pour créer un rythme facile à retenir","Parce que trois est obligatoire par la loi","Pour éviter les verbes","Pour allonger le texte"]$mq$, 0, $mq$La construction ternaire donne un rythme équilibré et se mémorise facilement.$mq$, $mq$medium$mq$),
($mq$Affiche inventée : « Vous avez droit à un air pur. Vous avez droit à une rue calme. Vous avez droit à l'avenir de vos enfants. Signez la pétition. » Quelle analyse est la plus complète ?$mq$, $mq$["Une métaphore filée et un registre comique","Une description neutre sans intention","Une litote suivie d'une question rhétorique","Une anaphore, un pathos avec « vos enfants », puis un impératif final qui appelle à agir"]$mq$, 3, $mq$La répétition de « Vous avez droit » est une anaphore ; « vos enfants » touche l'émotion ; « Signez » est un impératif d'action.$mq$, $mq$hard$mq$),
($mq$« Si vous refusez ce projet, c'est que vous ne vous souciez pas de la nature. » Quel défaut de raisonnement observe-t-on ?$mq$, $mq$["Un argument d'autorité","Une statistique précise","Un faux dilemme : on réduit le choix à deux positions caricaturales","Une concession honnête"]$mq$, 2, $mq$Refuser le projet n'empêche pas de se soucier de la nature. Le faux dilemme est un procédé manipulateur.$mq$, $mq$hard$mq$),
($mq$Le maire parle d'un « réaménagement » du parc ; son opposant, d'un « bétonnage ». Que montre ce choix de mots ?$mq$, $mq$["Que les deux mots sont parfaitement neutres","Que les connotations servent à défendre un point de vue","Que l'un des deux se trompe d'orthographe","Que le parc n'existe pas"]$mq$, 1, $mq$Même fait, mots différents : « réaménagement » est valorisant, « bétonnage » est dévalorisant. Le vocabulaire oriente le lecteur.$mq$, $mq$hard$mq$),
($mq$Question d'examen : « Comment l'auteur cherche-t-il à convaincre ? » Quelle réponse est la plus efficace ?$mq$, $mq$["Elle nomme un procédé, cite un court passage et explique l'effet sur le lecteur","Elle raconte le texte en résumé","Elle donne seulement son avis sur le sujet","Elle recopie le premier paragraphe"]$mq$, 0, $mq$Les critères valorisent la chaîne procédé, preuve, effet. Un résumé ou un avis personnel n'analyse pas la persuasion.$mq$, $mq$hard$mq$),
($mq$« Certes, le vélo demande un effort ; mais il rend la ville plus respirable. » Quelle est la fonction de « certes… mais » ?$mq$, $mq$["Elle exprime une peur","Elle annonce une description","Elle répète la même idée","Elle reconnaît un argument adverse puis le réfute, ce qui renforce la crédibilité"]$mq$, 3, $mq$La concession (« certes ») montre que l'auteur est honnête, puis « mais » replace son argument principal.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Persuasive Techniques$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Ethos$mq$, $mq$Appel à la crédibilité de l'orateur : son métier, son expérience, sa réputation inspirent confiance.$mq$),
($mq$Pathos$mq$, $mq$Appel aux émotions du destinataire : pitié, peur, indignation, espoir.$mq$),
($mq$Logos$mq$, $mq$Appel à la raison : faits, chiffres, exemples vérifiables, raisonnement logique.$mq$),
($mq$Question rhétorique$mq$, $mq$Question posée sans attendre de réponse, pour suggérer que la réponse est évidente et renforcer l'argument.$mq$),
($mq$Anaphore$mq$, $mq$Répétition d'un même mot en début de phrases ou de vers successifs : effet de rythme et d'insistance.$mq$),
($mq$Gradation$mq$, $mq$Suite de termes d'intensité croissante : « gêne, fatigue, rend malade ».$mq$),
($mq$Hyperbole$mq$, $mq$Exagération volontaire pour frapper l'esprit : « une montagne de devoirs ».$mq$),
($mq$Concession (« certes… mais »)$mq$, $mq$On reconnaît un argument adverse, puis on le réfute : cela rend l'auteur plus crédible.$mq$),
($mq$Faux dilemme$mq$, $mq$Argument manipulateur qui réduit un débat à deux choix extrêmes : « Avec nous ou contre la nature ».$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Persuasive Techniques$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## L'essentiel
Un texte persuasif cherche à convaincre ou à pousser à agir : publicité, tract, pétition, éditorial, discours. En Langue et Littérature, tu dois repérer les techniques, les nommer, les citer et expliquer leur effet sur le lecteur. Nommer un procédé ne suffit jamais : il faut dire ce qu'il produit.

## Les trois piliers de la persuasion
- **Ethos** : la crédibilité de celui qui parle. Exemple : « En tant qu'infirmière depuis quinze ans… ». L'auteur se présente comme digne de confiance.
- **Pathos** : l'émotion. Une photo d'un animal blessé, un récit touchant, des mots comme « drame », « injustice » ou « espoir ».
- **Logos** : la raison. Des chiffres, des faits, un raisonnement logique, des exemples précis.
Un bon texte mélange souvent les trois. Ton travail est de dire lequel domine et pourquoi.

## Les procédés les plus fréquents
- **L'impératif** : « Agissez ! Rejoignez-nous ! » pousse à l'action.
- **La question rhétorique** : elle n'attend pas de réponse, elle suggère l'évidence.
- **L'anaphore** : la répétition d'un mot en début de phrase donne un rythme martelé.
- **La gradation** : l'intensité augmente (« gêne, fatigue, rend malade »).
- **L'hyperbole** : l'exagération marque les esprits (« une montagne de devoirs »).
- **La construction ternaire** : trois éléments, facile à retenir (« informer, convaincre, mobiliser »).
- **Les pronoms** : « nous » inclut le lecteur, « vous » l'interpelle directement, « ils » désigne un adversaire.
- **Les connotations** : « réaménagement » ou « bétonnage » désignent le même fait avec deux jugements différents.
- **La concession** : « certes… mais » reconnaît un argument adverse pour mieux le réfuter.

## Fait ou opinion ?
Un fait est vérifiable : « Le réseau compte douze lignes de bus. » Une opinion est un jugement : « Les bus sont trop lents. » Les textes persuasifs mélangent les deux et présentent parfois une opinion comme un fait. Méfie-toi des adverbes d'intensité (« beaucoup trop », « absolument ») : ils signalent souvent un jugement.

## Les arguments trompeurs
- **L'appel à la majorité** : « Tout le monde l'a déjà adopté. » Ce n'est pas une preuve de qualité.
- **Le faux dilemme** : « Si vous n'êtes pas d'accord, vous ne vous souciez de rien. » Le choix est caricaturé.
- **La statistique sans source** : « Neuf personnes sur dix » ne prouve rien si l'on ignore qui a été interrogé.

## Exemple d'analyse
Affiche inventée : « Vous avez droit à un air pur. Vous avez droit à une rue calme. Vous avez droit à l'avenir de vos enfants. Signez la pétition. » Réponse modèle : l'anaphore de « Vous avez droit » martèle l'idée d'un droit légitime ; la mention des « enfants » fait appel au pathos ; l'impératif « Signez » transforme l'émotion en action.

## Comment c'est évalué
À l'eAssessment, un document court (affiche, extrait de discours, article d'opinion) est suivi de questions du type « Comment l'auteur cherche-t-il à convaincre ? » ou « Quel est l'effet de ce choix de mots ? ». Les critères valorisent l'analyse précise : procédé, citation, effet, puis lien avec le public visé.

## Erreurs fréquentes
- Lister des procédés sans citer le texte.
- Confondre ethos, pathos et logos.
- Oublier le destinataire : un procédé est efficace pour un public donné.

Exam tip: utilise toujours la structure « procédé, preuve, effet » : nomme la technique, cite quelques mots, puis explique ce que le lecteur ressent ou comprend.$mq$ from st;

-- Non-Fiction and Media > Articles and Speeches
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Non-Fiction and Media$mq$, 5, 5 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Articles and Speeches$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Non-Fiction and Media$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Articles and Speeches$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Dans un article de presse, que désigne le chapô ?$mq$, $mq$["Le court texte placé sous le titre qui résume l'essentiel","Le titre principal","La dernière phrase de l'article","La photo de couverture"]$mq$, 0, $mq$Le chapô est un petit paragraphe d'introduction, souvent en gras, qui donne l'information principale.$mq$, $mq$easy$mq$),
($mq$Que signifie la structure en « pyramide inversée » ?$mq$, $mq$["Les détails viennent avant l'essentiel","Le texte est écrit à l'envers","L'article n'a pas de conclusion","Les informations les plus importantes viennent en premier"]$mq$, 3, $mq$Le lecteur peut s'arrêter quand il veut : l'essentiel est au début, les détails suivent.$mq$, $mq$easy$mq$),
($mq$Quel ensemble de questions permet de résumer un fait d'actualité ?$mq$, $mq$["Combien ? Jamais ? Peut-être ? Et si ?","Avant ? Après ? Plus tard ?","Qui ? Quoi ? Où ? Quand ? Pourquoi ?","Beau ? Laid ? Bon ? Mauvais ?"]$mq$, 2, $mq$Ces cinq questions couvrent les informations de base d'un article d'information.$mq$, $mq$easy$mq$),
($mq$Un éditorial est…$mq$, $mq$["une simple liste de faits","un texte qui exprime l'opinion du journal sur un sujet","une publicité cachée","un poème sur l'actualité"]$mq$, 1, $mq$L'éditorial est un article d'opinion : le journal prend position et argumente.$mq$, $mq$easy$mq$),
($mq$Dans un discours, la péroraison est…$mq$, $mq$["la conclusion, souvent un appel final","l'introduction","un exemple au milieu du texte","une pause pour boire"]$mq$, 0, $mq$La péroraison termine le discours : elle résume et marque les esprits, parfois par un appel à l'action.$mq$, $mq$easy$mq$),
($mq$Le titre inventé « Le collège met les bouchées doubles » annonce un projet de cantine. Quel est son rôle ?$mq$, $mq$["Il cache le sujet à tout prix","Il remplace l'article","Il donne les sources","Il attire l'attention grâce à une expression imagée tout en annonçant le sujet"]$mq$, 3, $mq$Un titre accrocheur joue sur une expression ou un jeu de mots pour donner envie de lire.$mq$, $mq$medium$mq$),
($mq$« Selon la directrice, Mme Aubert, « le projet sera prêt en juin ». » Quel est l'intérêt de cette citation directe ?$mq$, $mq$["Elle ajoute de la poésie","Elle prouve que le journaliste a tort","Elle donne une source identifiable et appuie l'information","Elle remplace le titre"]$mq$, 2, $mq$Citer une personne nommée rend l'information plus crédible et plus vivante.$mq$, $mq$medium$mq$),
($mq$Quelle phrase d'article est la plus objective ?$mq$, $mq$["Ce tournoi extraordinaire restera dans les mémoires.","Le tournoi a réuni 120 élèves samedi.","Il fallait absolument organiser ce tournoi.","Les élèves ont adoré, évidemment."]$mq$, 1, $mq$La première phrase donne un fait chiffré. Les autres contiennent des jugements (« extraordinaire », « absolument », « évidemment »).$mq$, $mq$medium$mq$),
($mq$« Mesdames et Messieurs, chers camarades… » Quelle est la fonction de cette ouverture de discours ?$mq$, $mq$["Elle s'adresse au public pour capter son attention et créer le contact","Elle conclut le discours","Elle donne des chiffres","Elle décrit un paysage"]$mq$, 0, $mq$Les formules d'adresse établissent le contact avec l'auditoire dès le début.$mq$, $mq$medium$mq$),
($mq$Pourquoi un discours utilise-t-il souvent des phrases courtes et des répétitions ?$mq$, $mq$["Parce que l'orateur manque de vocabulaire","Parce que c'est interdit de faire des phrases longues","Parce que les discours sont toujours drôles","Parce que l'auditeur ne peut pas relire : il faut faciliter l'écoute et la mémorisation"]$mq$, 3, $mq$À l'oral, on ne peut pas revenir en arrière : répétitions et phrases courtes aident à suivre.$mq$, $mq$medium$mq$),
($mq$Un texte composé de questions du journaliste et de réponses d'une personne est…$mq$, $mq$["un reportage","un éditorial","une interview","une brève"]$mq$, 2, $mq$L'interview alterne questions et réponses, avec la parole de l'invité mise en avant.$mq$, $mq$medium$mq$),
($mq$Un article titre « Le parc est sauvé ! », mais le texte précise que seule la moitié du parc est protégée. Que montre cet écart ?$mq$, $mq$["L'article est écrit sans titre","Le titre est peut-être exagéré par rapport au contenu","Le journaliste ne connaît pas le sujet","Le texte est un poème"]$mq$, 1, $mq$Il faut comparer le titre et le corps du texte : un titre peut simplifier ou exagérer pour attirer le lecteur.$mq$, $mq$medium$mq$),
($mq$Quel type de texte utilise souvent « je », l'ironie et un ton personnel sur un sujet d'actualité ?$mq$, $mq$["La chronique ou le billet d'humeur","La dépêche d'agence","Le procès-verbal","L'annuaire"]$mq$, 0, $mq$La chronique assume la subjectivité de son auteur, contrairement à la dépêche qui reste neutre.$mq$, $mq$medium$mq$),
($mq$Discours inventé : « Nous voulons des classes lumineuses. Nous voulons des classes calmes. Nous voulons, enfin, des classes où chacun peut apprendre. » Quelle analyse est la plus juste ?$mq$, $mq$["Une description objective d'un bâtiment","Une suite de questions rhétoriques","Un récit au passé simple","Une anaphore qui martèle la revendication, avec une progression vers l'idée la plus importante"]$mq$, 3, $mq$« Nous voulons » est répété (anaphore). Le dernier élément, plus long et plus fort, crée une gradation.$mq$, $mq$hard$mq$),
($mq$Un article sur le même festival paraît dans un magazine pour adolescents et dans un quotidien régional. Quelle différence est la plus probable ?$mq$, $mq$["Aucune : tous les textes se ressemblent","Le festival n'aura pas la même date","Le vocabulaire, le registre et les exemples seront adaptés au lectorat","Le quotidien n'utilisera pas de verbes"]$mq$, 2, $mq$Le public cible détermine le registre, la longueur, les exemples et même l'angle choisi.$mq$, $mq$hard$mq$),
($mq$« Selon des sources proches de l'entreprise, il n'y a aucun risque. » Quelle est la faiblesse de cette information ?$mq$, $mq$["Elle est trop courte","La source est vague et partielle : on ne peut pas la vérifier","Elle utilise le futur","Elle contient une hyperbole"]$mq$, 1, $mq$Des « sources proches de l'entreprise » ne sont ni nommées ni indépendantes : l'information est à interpréter avec prudence.$mq$, $mq$hard$mq$),
($mq$Question d'examen : « Comment la structure du discours renforce-t-elle son effet ? » Quelle réponse est la plus pertinente ?$mq$, $mq$["Il commence par capter l'auditoire, développe des arguments de plus en plus forts, puis termine par un appel à agir","Il contient des paragraphes","Il est long","Il a un titre"]$mq$, 0, $mq$Une analyse de structure décrit la progression et son effet sur l'auditoire, pas seulement la présence de paragraphes.$mq$, $mq$hard$mq$),
($mq$« Le nouveau gymnase, inauguré en mars, est un magnifique succès. » Quelle partie est subjective ?$mq$, $mq$["« inauguré en mars »","« Le nouveau gymnase »","« en mars »","« un magnifique succès »"]$mq$, 3, $mq$La date est vérifiable, tandis que « magnifique succès » est une appréciation. Un même énoncé peut mêler fait et opinion.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Articles and Speeches$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Chapô$mq$, $mq$Court paragraphe placé sous le titre d'un article, qui en résume l'information principale.$mq$),
($mq$Pyramide inversée$mq$, $mq$Structure de l'article d'information : l'essentiel d'abord, puis les détails par ordre d'importance décroissante.$mq$),
($mq$Les questions de base d'un article$mq$, $mq$Qui ? Quoi ? Où ? Quand ? Pourquoi ? (et Comment ?) : elles résument l'information principale.$mq$),
($mq$Éditorial$mq$, $mq$Article d'opinion qui exprime la position du journal sur un sujet d'actualité.$mq$),
($mq$Chronique / billet d'humeur$mq$, $mq$Texte subjectif, à la première personne, souvent ironique ou humoristique, sur l'actualité.$mq$),
($mq$Source vague$mq$, $mq$« Selon des sources proches de… » : information difficile à vérifier, donc à lire avec prudence.$mq$),
($mq$Ouverture d'un discours$mq$, $mq$Formule d'adresse (« Mesdames et Messieurs ») et accroche qui captent l'attention du public.$mq$),
($mq$Péroraison$mq$, $mq$Conclusion d'un discours : elle résume, marque les esprits et appelle souvent à l'action.$mq$),
($mq$Pourquoi des répétitions à l'oral ?$mq$, $mq$L'auditeur ne peut pas relire : phrases courtes, répétitions et anaphores aident à suivre et à retenir.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Articles and Speeches$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## L'essentiel
Les articles et les discours sont des textes non littéraires que l'on rencontre tous les jours : presse, site d'actualité, allocution de l'école, prise de parole en public. Pour les analyser, il faut comprendre leur structure, leur but, leur public et la façon dont ils mêlent faits et opinions.

## L'article de presse
Un article d'information suit généralement la **pyramide inversée** : l'essentiel d'abord, les détails ensuite. Ses éléments :
- **Le titre** : il attire l'attention, parfois par un jeu de mots ou une expression imagée, et annonce le sujet.
- **Le chapô** : court paragraphe sous le titre qui résume l'information principale.
- **L'introduction et le corps** : ils répondent aux questions Qui ? Quoi ? Où ? Quand ? Pourquoi ? Comment ?
- **Les intertitres** : ils guident la lecture.
- **Les citations et les sources** : ils appuient les faits et les rendent crédibles.
Un reportage décrit sur le terrain ; une interview alterne questions et réponses ; un éditorial exprime l'opinion du journal ; une chronique ou un billet d'humeur assume la voix personnelle de l'auteur.

## Objectif ou subjectif ?
Un article d'information vise l'objectivité : faits chiffrés, vocabulaire neutre, sources nommées. Mais aucun texte n'est parfaitement neutre. Observe :
- le **choix du titre** (un titre peut exagérer ce que dit le texte) ;
- les **adjectifs** appréciatifs (« magnifique », « inquiétant ») ;
- les **sources** : sont-elles nommées, variées, vérifiables ? « Des sources proches de l'entreprise » est une source vague ;
- **ce qui est omis** : quel point de vue est absent ?
Exemple : dans « Le nouveau gymnase, inauguré en mars, est un magnifique succès », « inauguré en mars » est un fait, « magnifique succès » est une opinion.

## Le discours
Un discours est écrit pour être entendu. Sa structure classique :
- **L'ouverture** : formule d'adresse (« Mesdames et Messieurs ») et accroche pour capter l'attention.
- **Le développement** : arguments organisés, souvent du moins fort au plus fort.
- **La péroraison** : conclusion qui résume et appelle à agir.
À l'oral, l'orateur ne peut pas être relu. Il utilise donc des phrases courtes, des répétitions et des anaphores (« Nous voulons… Nous voulons… »), des questions rhétoriques, des gradations, le pronom « nous » et parfois des silences. Exemple inventé : « Nous voulons des classes lumineuses. Nous voulons des classes calmes. Nous voulons, enfin, des classes où chacun peut apprendre. » L'anaphore martèle la revendication ; le dernier élément, plus long, est le sommet de la gradation.

## Public et intention
Pose-toi toujours trois questions : qui parle ? à qui ? dans quel but (informer, divertir, convaincre, émouvoir) ? Un même événement n'est pas raconté de la même manière dans un magazine pour adolescents et dans un quotidien régional : registre, exemples et longueur changent.

## Comment c'est évalué
À l'eAssessment, tu liras un extrait d'article ou de discours, puis tu répondras à des questions sur le sens, la structure, les procédés et l'effet sur le public. On te demandera de justifier avec une citation courte et d'expliquer l'intention de l'auteur.

## Erreurs fréquentes
- Résumer au lieu d'analyser.
- Prendre une opinion pour un fait.
- Ne pas distinguer le but de l'auteur du but du texte.

Exam tip: quand on te demande l'effet de la structure, décris la progression (début, milieu, fin) et dis comment elle guide le lecteur ou l'auditeur.$mq$ from st;

-- Non-Fiction and Media > Visual and Multimodal Texts
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Non-Fiction and Media$mq$, 5, 5 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Visual and Multimodal Texts$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Non-Fiction and Media$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Visual and Multimodal Texts$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Qu'est-ce qu'un texte multimodal ?$mq$, $mq$["Un texte qui combine plusieurs modes : écrit, image, couleur, son, mise en page","Un texte écrit uniquement à la main","Un texte sans image","Un texte écrit en plusieurs langues"]$mq$, 0, $mq$Une affiche, une page web ou une bande dessinée associent plusieurs modes de communication pour produire un sens.$mq$, $mq$easy$mq$),
($mq$Que montre un gros plan ?$mq$, $mq$["Un paysage entier","Une foule vue de loin","Un texte sans image","Un détail (visage, objet) de très près"]$mq$, 3, $mq$Le gros plan rapproche le détail : il met en valeur les émotions ou un objet précis.$mq$, $mq$easy$mq$),
($mq$Dans une image en plongée, la caméra est placée…$mq$, $mq$["en dessous du sujet, qui paraît puissant","à la hauteur des yeux, sans effet","au-dessus du sujet, qui paraît souvent petit ou fragile","derrière le lecteur"]$mq$, 2, $mq$La plongée écrase le sujet : on peut ressentir sa faiblesse ou son isolement.$mq$, $mq$easy$mq$),
($mq$Quelle impression donnent le plus souvent les couleurs chaudes (rouge, orange) ?$mq$, $mq$["Calme total, froideur","Énergie, chaleur, parfois danger","Tristesse uniquement","Aucune impression"]$mq$, 1, $mq$Le rouge peut signifier l'énergie, la passion ou l'alerte. Les couleurs froides évoquent plutôt le calme ou la fraîcheur.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce qu'une légende sous une photo ?$mq$, $mq$["Un court texte qui explique ou précise l'image","Une histoire fantastique","Un slogan publicitaire obligatoire","Le nom du photographe seulement"]$mq$, 0, $mq$La légende situe et explique l'image. Elle oriente aussi l'interprétation.$mq$, $mq$easy$mq$),
($mq$Une affiche montre un athlète filmé en contre-plongée. Quel effet est le plus probable ?$mq$, $mq$["Il paraît petit et faible","Il paraît invisible","Il paraît ennuyé","Il paraît puissant, admirable"]$mq$, 3, $mq$En contre-plongée, la caméra regarde vers le haut : le sujet semble dominant, valorisé.$mq$, $mq$medium$mq$),
($mq$Sur une affiche, un personnage regarde droit vers le lecteur. Quel est l'effet ?$mq$, $mq$["Il rend l'image abstraite","Il cache le message","Il interpelle le lecteur et l'implique","Il indique que le texte est inutile"]$mq$, 2, $mq$Le regard direct établit un contact et peut créer de la complicité ou de la pression.$mq$, $mq$medium$mq$),
($mq$Qu'est-ce qui attire en général l'œil en premier dans une image ?$mq$, $mq$["L'arrière-plan flou","Les éléments du premier plan, contrastés ou plus grands","Les marges blanches","Le bas de page"]$mq$, 1, $mq$Taille, contraste et position de premier plan guident le regard du lecteur.$mq$, $mq$medium$mq$),
($mq$Une publicité d'eau minérale utilise surtout du bleu et du blanc. Quelle association est visée ?$mq$, $mq$["La pureté et la fraîcheur","La colère et la violence","L'énergie du feu","Le danger"]$mq$, 0, $mq$Le bleu évoque l'eau, le blanc la pureté : les couleurs soutiennent l'argument du produit.$mq$, $mq$medium$mq$),
($mq$Affiche inventée : « Notre ville est propre ! » au-dessus d'une photo de rues couvertes de déchets. Quel effet est créé ?$mq$, $mq$["Une cohérence parfaite","Un effet de rime","Une gradation","Une ironie : le texte contredit l'image"]$mq$, 3, $mq$Le contraste entre le slogan et l'image produit de l'ironie, souvent pour dénoncer.$mq$, $mq$medium$mq$),
($mq$Pourquoi une affiche met-elle un mot en grandes lettres capitales grasses ?$mq$, $mq$["Pour économiser de l'encre","Pour cacher le message","Pour le rendre plus visible et insister sur l'urgence ou l'importance","Parce que c'est obligatoire"]$mq$, 2, $mq$La typographie fait partie du message : taille et graisse hiérarchisent l'information.$mq$, $mq$medium$mq$),
($mq$Avant de faire confiance à une infographie, quelle vérification est la plus utile ?$mq$, $mq$["La couleur du fond","La source des données et la date","Le nombre de pictogrammes","La police de caractères"]$mq$, 1, $mq$Une infographie n'est crédible que si ses données viennent d'une source fiable et récente.$mq$, $mq$medium$mq$),
($mq$Dans une bande dessinée, une bulle en forme de nuage avec de petits ronds indique…$mq$, $mq$["une pensée du personnage","une parole prononcée à voix haute","un cri","un bruit de fond"]$mq$, 0, $mq$La bulle-nuage représente les pensées, la bulle ordinaire les paroles.$mq$, $mq$medium$mq$),
($mq$Affiche inventée : fond très sombre, un seul élève éclairé au centre, un slogan en petites lettres tout en bas. Quelle interprétation est la mieux justifiée ?$mq$, $mq$["Il y a trop de couleurs différentes","L'image est un paysage","Le slogan est le plus important","La lumière isole l'élève et attire l'attention sur lui, le slogan est discret pour laisser parler l'image"]$mq$, 3, $mq$Le contraste ombre-lumière crée un point focal. La petite taille du slogan le place au second plan.$mq$, $mq$hard$mq$),
($mq$Un graphique à barres commence l'axe vertical à 90 % au lieu de 0 %. Quel effet cela produit-il ?$mq$, $mq$["Il rend les barres plus honnêtes","Il supprime les données","Il exagère visuellement les petites différences","Il change les unités"]$mq$, 2, $mq$Un axe tronqué amplifie les écarts : un procédé qui peut tromper le lecteur.$mq$, $mq$hard$mq$),
($mq$Une affiche vise des personnes âgées. Quels choix de conception sont les plus adaptés ?$mq$, $mq$["Texte minuscule et couleurs pâles","Grande police lisible et fort contraste entre texte et fond","Argot récent et nombreux émojis","Fond très chargé"]$mq$, 1, $mq$On adapte la forme au public : lisibilité, registre et références doivent correspondre aux destinataires.$mq$, $mq$hard$mq$),
($mq$Question d'examen : « Analysez comment l'image et le texte fonctionnent ensemble. » Quelle réponse est la plus efficace ?$mq$, $mq$["Elle associe un élément visuel et un élément du texte, puis explique l'effet produit sur le public","Elle décrit l'image puis le texte séparément sans les relier","Elle donne seulement son goût personnel","Elle recopie le slogan"]$mq$, 0, $mq$On évalue la capacité à relier les modes entre eux : complémentarité, contraste ou ironie, avec effet sur le lecteur.$mq$, $mq$hard$mq$),
($mq$Un plan large montre un personnage minuscule au milieu d'un immense paysage vide. Quelle interprétation est la plus probable ?$mq$, $mq$["Une scène de fête","Un gros plan","Une publicité de luxe","Un sentiment d'isolement ou de petitesse face au monde"]$mq$, 3, $mq$Le contraste d'échelle entre le personnage et le décor suggère la solitude ou la vulnérabilité.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Visual and Multimodal Texts$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Texte multimodal$mq$, $mq$Texte qui associe plusieurs modes : mots, images, couleurs, typographie, mise en page, son.$mq$),
($mq$Gros plan / plan large$mq$, $mq$Le gros plan montre un détail ou une émotion de très près ; le plan large montre le décor et l'échelle du personnage.$mq$),
($mq$Plongée / contre-plongée$mq$, $mq$Plongée : vue d'en haut, le sujet paraît petit ou faible. Contre-plongée : vue d'en bas, le sujet paraît puissant.$mq$),
($mq$Couleurs chaudes / froides$mq$, $mq$Chaudes (rouge, orange) : énergie, passion, danger. Froides (bleu, vert) : calme, fraîcheur, parfois tristesse.$mq$),
($mq$Regard direct$mq$, $mq$Un personnage qui regarde le lecteur l'interpelle, l'implique et peut créer de la complicité.$mq$),
($mq$Légende$mq$, $mq$Court texte sous une image qui l'explique ou la situe, et qui oriente son interprétation.$mq$),
($mq$Ironie texte-image$mq$, $mq$Le texte contredit l'image (slogan « ville propre » sur une photo de déchets) : effet de dénonciation.$mq$),
($mq$Axe tronqué$mq$, $mq$Un graphique dont l'axe ne part pas de zéro exagère visuellement les petites différences.$mq$),
($mq$Formule d'analyse visuelle$mq$, $mq$Détail, interprétation, effet : je vois ceci, cela suggère cela, donc le public ressent ou comprend ainsi.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Visual and Multimodal Texts$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## L'essentiel
Un texte multimodal combine plusieurs modes de communication : mots, images, couleurs, typographie, mise en page, parfois son. Affiches, publicités, bandes dessinées, pages web, couvertures de livres et infographies sont des textes multimodaux. Pour les analyser, il faut décrire chaque mode, puis montrer comment ils se complètent.

## Lire une image
- **Le cadrage** : gros plan (détail, émotion), plan moyen (personnage et contexte), plan large (décor, échelle).
- **L'angle** : la plongée (vue d'en haut) rend le sujet petit ou fragile ; la contre-plongée (vue d'en bas) le rend puissant.
- **Le regard** : un personnage qui regarde le lecteur l'interpelle ; un regard détourné crée la distance ou le mystère.
- **La composition** : premier plan et arrière-plan, centre ou marges, lignes qui guident l'œil. Souvent, on lit une page du coin supérieur gauche vers le coin inférieur droit.
- **La lumière et les couleurs** : les couleurs chaudes (rouge, orange) évoquent l'énergie, la passion ou le danger ; les couleurs froides (bleu, vert) suggèrent le calme, la fraîcheur, parfois la tristesse. Un fort contraste ombre-lumière isole un élément.

## Lire le texte et la typographie
La taille, la graisse, la police et la couleur des lettres hiérarchisent l'information. Un mot en grandes capitales grasses attire l'œil et peut signaler l'urgence. Le **slogan** est une phrase courte et mémorable ; la **légende** explique une image ; le **logo** identifie une marque.

## Relation texte-image
- **Complémentarité** : l'image montre, le texte précise.
- **Redondance** : les deux disent la même chose pour insister.
- **Contraste ou ironie** : le texte contredit l'image. Exemple inventé : le slogan « Notre ville est propre ! » au-dessus d'une photo de rues pleines de déchets. L'ironie dénonce le problème.

## Quelques formats particuliers
- **La bande dessinée** : cases, bulles de parole (bord arrondi), bulles de pensée (forme de nuage), onomatopées, cadrages variés.
- **L'infographie** : titre, données chiffrées, légende, échelle, source. Vérifie toujours la source, la date et l'échelle : un axe qui ne part pas de zéro exagère les différences.
- **La page web** : menus, liens, boutons, hiérarchie visuelle qui guide la navigation.

## Public et intention
Une affiche pour des personnes âgées utilise une grande police et un fort contraste ; une application pour adolescents peut utiliser un registre familier et des couleurs vives. Demande-toi : qui est visé, quel est le but (informer, vendre, sensibiliser) et quels choix servent ce but.

## Exemple d'analyse
Affiche inventée : fond très sombre, un seul élève éclairé au centre, slogan en petites lettres en bas. Réponse modèle : le contraste ombre-lumière isole l'élève et en fait le point focal, ce qui suggère l'importance de chaque individu ; le slogan discret laisse la place à l'image et invite à s'approcher pour lire.

## Comment c'est évalué
À l'eAssessment, tu auras souvent un document visuel décrit ou présenté avec du texte. Les questions portent sur les choix de l'auteur, l'effet sur le public et la relation entre les modes. Les meilleures réponses relient toujours un détail précis à un effet.

## Erreurs fréquentes
- Décrire l'image sans interpréter.
- Oublier le public cible.
- Traiter le texte et l'image comme deux documents séparés.

Exam tip: utilise la formule « détail, interprétation, effet » : je vois ceci, cela suggère cela, donc le lecteur ressent ou comprend ainsi.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;