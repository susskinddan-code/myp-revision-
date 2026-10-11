-- Part 6 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Writing > Planning Your Writing
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Writing$mq$, 5, 6 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Planning Your Writing$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Writing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Planning Your Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Quelle est la première étape d'une bonne rédaction ?$mq$, $mq$["Lire attentivement le sujet et repérer les mots-clés","Écrire immédiatement la conclusion","Recopier un texte déjà lu","Choisir un titre original"]$mq$, 0, $mq$Sans analyse du sujet, on risque le hors-sujet. On repère le type de texte, le destinataire, le but et les mots-clés.$mq$, $mq$easy$mq$),
($mq$Que fait-on pendant un remue-méninges ?$mq$, $mq$["On corrige l'orthographe","On recopie au propre","On choisit la conclusion","On note librement un maximum d'idées avant de les trier"]$mq$, 3, $mq$Le remue-méninges génère des idées sans les juger. Le tri se fait ensuite.$mq$, $mq$easy$mq$),
($mq$À quoi sert un plan ?$mq$, $mq$["À remplacer le brouillon et la copie","À augmenter le nombre de mots","À organiser les idées dans un ordre logique avant de rédiger","À éviter la relecture"]$mq$, 2, $mq$Un plan structure le texte et évite répétitions et contradictions.$mq$, $mq$easy$mq$),
($mq$Quelle est la structure de base d'un texte argumentatif ?$mq$, $mq$["Titre, image, légende","Introduction, développement, conclusion","Question, réponse, question","Début, fin, début"]$mq$, 1, $mq$Introduction (présentation), développement (arguments), conclusion (bilan) : c'est la base de la plupart des textes.$mq$, $mq$easy$mq$),
($mq$Que font les connecteurs comme « d'abord », « ensuite », « enfin » ?$mq$, $mq$["Ils relient les idées et marquent l'ordre du texte","Ils remplacent les verbes","Ils servent seulement à allonger","Ils créent des rimes"]$mq$, 0, $mq$Les connecteurs guident le lecteur et rendent la progression claire.$mq$, $mq$easy$mq$),
($mq$Consigne inventée : « Rédigez une lettre au maire pour demander plus d'espaces verts. » Quelle analyse du sujet est complète ?$mq$, $mq$["Type : poème ; destinataire : un ami ; but : s'amuser","Type : récit ; destinataire : la classe ; but : raconter","Type : dialogue ; destinataire : le public ; but : informer","Type : lettre formelle ; destinataire : le maire ; but : le convaincre d'agir"]$mq$, 3, $mq$Il faut identifier le type de texte, le destinataire et le but. Cela détermine le registre et la structure.$mq$, $mq$medium$mq$),
($mq$Quelle structure de paragraphe est la plus efficace pour argumenter ?$mq$, $mq$["Trois exemples sans idée","Une citation seule","Une idée, un exemple, une explication de l'effet","Une question sans réponse"]$mq$, 2, $mq$Idée, exemple, explication relie l'argument à la thèse et évite l'affirmation gratuite.$mq$, $mq$medium$mq$),
($mq$Quel connecteur exprime une opposition ?$mq$, $mq$["Donc","Cependant","D'abord","Ainsi"]$mq$, 1, $mq$« Cependant » introduit une idée qui s'oppose à la précédente. « Donc » et « ainsi » marquent la conséquence.$mq$, $mq$medium$mq$),
($mq$Quel connecteur introduit une cause ?$mq$, $mq$["Parce que","Par conséquent","Pourtant","Enfin"]$mq$, 0, $mq$« Parce que » donne la raison. « Par conséquent » exprime la conséquence.$mq$, $mq$medium$mq$),
($mq$Tu as dix idées en brouillon. Que faire ?$mq$, $mq$["Toutes les utiliser pour ne rien perdre","Choisir au hasard","Ne retenir que la plus courte","Garder les trois ou quatre plus solides et les développer"]$mq$, 3, $mq$Mieux vaut peu d'arguments bien développés qu'une liste superficielle. La sélection fait partie du plan.$mq$, $mq$medium$mq$),
($mq$Pour une tâche d'écriture de 40 minutes, quelle répartition du temps est la plus raisonnable ?$mq$, $mq$["1 minute de plan, 39 minutes d'écriture","30 minutes de plan, 10 minutes d'écriture","6 minutes de plan, 28 minutes d'écriture, 6 minutes de relecture","Aucune relecture"]$mq$, 2, $mq$Planifier et relire améliore nettement la clarté et la correction. Trop peu de plan mène à un texte désordonné.$mq$, $mq$medium$mq$),
($mq$Que doit contenir une bonne introduction ?$mq$, $mq$["Seulement la conclusion","Une accroche, la présentation du sujet et l'annonce de la direction du texte","Tous les arguments en détail","Un résumé du dernier paragraphe seulement"]$mq$, 1, $mq$L'introduction accroche, situe le sujet et prépare le lecteur à la suite.$mq$, $mq$medium$mq$),
($mq$Quelle erreur faut-il éviter dans la conclusion ?$mq$, $mq$["Introduire un argument majeur tout nouveau","Résumer l'idée principale","Ouvrir sur une perspective","Rappeler la thèse"]$mq$, 0, $mq$La conclusion fait le bilan. Un argument nouveau et non développé déséquilibre le texte.$mq$, $mq$medium$mq$),
($mq$Plan d'un élève : 1. Les transports sont chers. 2. Les bus sont en retard. 3. Les bus coûtent cher. Quel est le problème principal ?$mq$, $mq$["Il y a trop de parties","Il n'y a pas de verbes","Il est trop court","Les parties 1 et 3 se recoupent : le plan manque de variété"]$mq$, 3, $mq$Un bon plan a des parties distinctes. Ici les parties 1 et 3 disent presque la même chose.$mq$, $mq$hard$mq$),
($mq$Sujet : « Pensez-vous que les réseaux sociaux aident les adolescents ? Discutez. » Quel plan convient le mieux ?$mq$, $mq$["Seulement les avantages, sans nuance","Un récit personnel","Avantages, limites, puis conclusion nuancée","Une liste de réseaux célèbres"]$mq$, 2, $mq$Le verbe « discutez » demande d'examiner plusieurs points de vue puis de prendre position de manière nuancée.$mq$, $mq$hard$mq$),
($mq$Pour une nouvelle, quel ordre du schéma narratif est correct ?$mq$, $mq$["Dénouement, situation initiale, péripéties, élément perturbateur","Situation initiale, élément perturbateur, péripéties, dénouement, situation finale","Péripéties, situation finale, situation initiale, dénouement","Situation finale, dénouement, élément perturbateur"]$mq$, 1, $mq$Le schéma narratif suit l'ordre : équilibre, rupture, aventures, résolution, nouvel équilibre.$mq$, $mq$hard$mq$),
($mq$Pour réviser sa copie, quelle méthode est la plus efficace ?$mq$, $mq$["Plusieurs relectures ciblées : sens et structure, puis grammaire, puis orthographe","Une seule lecture rapide du début à la fin","Ne relire que la conclusion","Changer tous les mots"]$mq$, 0, $mq$Chercher tout en même temps est moins efficace. Des relectures ciblées permettent de repérer davantage d'erreurs.$mq$, $mq$hard$mq$),
($mq$Sujet : « Décrivez les effets de la pollution de la rivière du village. » Un élève écrit surtout sur la pollution de l'air dans le monde. Que risque-t-il ?$mq$, $mq$["Rien : tous les textes sur la pollution sont acceptés","Un texte trop poétique","Une conclusion trop courte","Le hors-sujet, car son texte ne répond pas au sujet précis"]$mq$, 3, $mq$Il faut rester dans les limites du sujet. Relier chaque paragraphe aux mots-clés (« rivière », « village », « effets ») évite le hors-sujet.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Planning Your Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Analyser le sujet$mq$, $mq$Repérer le type de texte, le destinataire, le but et les mots-clés avant d'écrire, pour éviter le hors-sujet.$mq$),
($mq$Remue-méninges$mq$, $mq$Noter librement beaucoup d'idées sans les juger, puis trier pour garder les plus solides.$mq$),
($mq$Structure d'un paragraphe argumentatif$mq$, $mq$Idée principale, exemple précis, explication de l'effet sur la thèse.$mq$),
($mq$Plan de base$mq$, $mq$Introduction (accroche, sujet, annonce), développement (un argument par paragraphe), conclusion (bilan, ouverture).$mq$),
($mq$Schéma narratif$mq$, $mq$Situation initiale, élément perturbateur, péripéties, dénouement, situation finale.$mq$),
($mq$Connecteur d'opposition$mq$, $mq$Cependant, pourtant, mais, en revanche : ils introduisent une idée contraire à la précédente.$mq$),
($mq$Connecteur de conséquence$mq$, $mq$Donc, par conséquent, ainsi, c'est pourquoi : ils introduisent le résultat d'une cause.$mq$),
($mq$Hors-sujet$mq$, $mq$Écrire sur un thème proche mais pas sur la question posée : à éviter en reliant chaque paragraphe aux mots-clés.$mq$),
($mq$Gestion du temps (40 min)$mq$, $mq$Environ 6 min de plan, 28 min de rédaction et 6 min de relecture ciblée (sens, grammaire, orthographe).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Planning Your Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## L'essentiel
Un bon texte ne commence jamais par la première phrase : il commence par un plan. Les élèves qui prennent quelques minutes pour analyser le sujet, rassembler des idées et les organiser écrivent des textes plus clairs, plus précis et mieux notés. Planifier n'est pas une perte de temps, c'est ce qui rend l'écriture rapide ensuite.

## Étape 1 : analyser le sujet
Lis la consigne deux fois. Repère :
- **le type de texte** (lettre, article, récit, discours, description) ;
- **le destinataire** (le maire, un ami, la direction, le lecteur d'un journal) ;
- **le but** (informer, convaincre, raconter, décrire) ;
- **les mots-clés** et les limites du sujet.
Exemple inventé : « Rédigez une lettre au maire pour demander plus d'espaces verts. » Type : lettre formelle. Destinataire : le maire. But : le convaincre. Mots-clés : « espaces verts », « demander ». Si tu écris sur la pollution en général, tu es hors-sujet.
Le verbe de la consigne décide de la démarche : « décrivez » demande du détail, « discutez » demande plusieurs points de vue, « convainquez » demande une thèse claire.

## Étape 2 : trouver des idées
Fais un remue-méninges : note tout ce qui te vient, sans juger. Tu peux utiliser une carte mentale, une liste ou des questions (Qui ? Quoi ? Où ? Pourquoi ? Comment ?). Ensuite, trie : garde les trois ou quatre idées les plus solides et les plus différentes. Mieux vaut moins d'arguments bien développés qu'une longue liste superficielle.

## Étape 3 : construire le plan
- **Introduction** : accroche, présentation du sujet, annonce de la direction.
- **Développement** : un paragraphe par idée principale. Chaque paragraphe suit la structure idée, exemple, explication.
- **Conclusion** : bilan, rappel de la thèse, ouverture. Elle ne contient pas de nouvel argument majeur.
Pour un récit, le plan suit le schéma narratif : situation initiale, élément perturbateur, péripéties, dénouement, situation finale.
Vérifie que tes parties sont distinctes : un plan qui répète deux fois la même idée est faible.

## Étape 4 : les connecteurs
Ils relient les idées et guident le lecteur :
- ordre : d'abord, ensuite, enfin ;
- addition : de plus, en outre ;
- opposition : cependant, pourtant, mais ;
- cause : parce que, car, en effet ;
- conséquence : donc, par conséquent, ainsi.

## Gérer le temps
Pour une tâche de quarante minutes, vise environ six minutes de plan, vingt-huit minutes de rédaction et six minutes de relecture. Relis plusieurs fois, avec un but différent à chaque fois : sens et structure, puis grammaire, puis orthographe.

## Comment c'est évalué
Les critères d'écriture valorisent l'organisation, la clarté, la pertinence et la maîtrise de la langue. Un plan apparent n'est pas toujours demandé, mais ses effets se voient : introduction claire, paragraphes équilibrés, transitions efficaces.

## Erreurs fréquentes
- Commencer sans analyser la consigne.
- Écrire tout ce qu'on sait sur le thème.
- Oublier le destinataire.
- Ne pas garder de temps pour relire.

Exam tip: écris ton plan en cinq lignes maximum au brouillon, avec un mot-clé par paragraphe, puis coche chaque mot-clé quand tu l'as traité.$mq$ from st;

-- Writing > Narrative and Descriptive Writing
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Writing$mq$, 5, 6 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Narrative and Descriptive Writing$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Writing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Narrative and Descriptive Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Que désigne le schéma narratif ?$mq$, $mq$["Les étapes d'un récit, de la situation initiale à la situation finale","La liste des personnages","Le titre et le sous-titre","Le nombre de pages"]$mq$, 0, $mq$Le schéma narratif organise l'histoire : situation initiale, élément perturbateur, péripéties, dénouement, situation finale.$mq$, $mq$easy$mq$),
($mq$Dans un récit à la première personne, quel pronom désigne le narrateur ?$mq$, $mq$["Il","Elle","Ils","Je"]$mq$, 3, $mq$Le narrateur-personnage dit « je » et raconte sa propre expérience.$mq$, $mq$easy$mq$),
($mq$Quel temps du passé sert surtout à décrire le décor et l'arrière-plan d'un récit ?$mq$, $mq$["Le passé simple","Le futur simple","L'imparfait","Le subjonctif présent"]$mq$, 2, $mq$L'imparfait décrit les situations qui durent et le cadre. Le passé simple raconte les actions ponctuelles.$mq$, $mq$easy$mq$),
($mq$Que fait une description sensorielle ?$mq$, $mq$["Elle utilise seulement la vue","Elle utilise la vue, l'ouïe, l'odorat, le goût et le toucher","Elle évite les adjectifs","Elle ne contient que des verbes"]$mq$, 1, $mq$Mobiliser plusieurs sens rend la scène plus vivante et plus crédible.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce que l'élément perturbateur ?$mq$, $mq$["L'événement qui rompt l'équilibre de la situation initiale","La dernière phrase de l'histoire","Le portrait du narrateur","Le titre du récit"]$mq$, 0, $mq$C'est lui qui lance l'histoire : une arrivée, une disparition, une découverte.$mq$, $mq$easy$mq$),
($mq$« Il ouvrit la porte alors que le vent soufflait fort. » Pourquoi « soufflait » est-il à l'imparfait ?$mq$, $mq$["Il exprime un futur proche","Il indique un ordre","Il est une faute","Il décrit une circonstance qui dure en arrière-plan"]$mq$, 3, $mq$« Ouvrit » est une action ponctuelle (passé simple), « soufflait » décrit le contexte qui continue (imparfait).$mq$, $mq$medium$mq$),
($mq$Quelle phrase montre la nervosité au lieu de la dire ?$mq$, $mq$["Elle avait très peur.","Elle était nerveuse.","Ses mains tremblaient sur la poignée de sa valise.","Elle se sentait mal."]$mq$, 2, $mq$« Montrer plutôt que dire » consiste à décrire des gestes ou des détails qui font comprendre l'émotion.$mq$, $mq$medium$mq$),
($mq$Quelle ponctuation de dialogue est correcte ?$mq$, $mq$["« Viens vite ! » cria, Zoé.","« Viens vite ! » cria Zoé.","« Viens vite ! cria Zoé. »","Viens vite ! cria Zoé"]$mq$, 1, $mq$Après les guillemets fermants, la proposition incise commence par une minuscule : « Viens vite ! » cria Zoé.$mq$, $mq$medium$mq$),
($mq$« Le ciel était un tableau gris. » Quel procédé est employé ?$mq$, $mq$["Une métaphore","Une comparaison","Une litote","Une anaphore"]$mq$, 0, $mq$Il n'y a pas d'outil de comparaison (comme, tel, semblable à) : le ciel est directement assimilé à un tableau. C'est une métaphore.$mq$, $mq$medium$mq$),
($mq$Que signifie commencer un récit « in medias res » ?$mq$, $mq$["Commencer par la fin","Commencer par le titre","Commencer par une citation","Commencer au milieu de l'action"]$mq$, 3, $mq$Cette ouverture accroche immédiatement le lecteur, puis le récit peut revenir en arrière pour expliquer.$mq$, $mq$medium$mq$),
($mq$Quelle technique crée du suspense ?$mq$, $mq$["Révéler tout dès le début","Supprimer les descriptions","Retarder la révélation et semer des indices","Écrire uniquement des dialogues longs"]$mq$, 2, $mq$Le suspense naît de l'attente : informations retenues, phrases courtes, indices ambigus.$mq$, $mq$medium$mq$),
($mq$Un narrateur omniscient est un narrateur qui…$mq$, $mq$["est un personnage de l'histoire","connaît les pensées de tous les personnages","ne raconte que ce qu'il voit","parle toujours au présent"]$mq$, 1, $mq$Le narrateur omniscient sait tout : pensées, passé et avenir des personnages.$mq$, $mq$medium$mq$),
($mq$Pour décrire une pièce de façon claire, quel ordre est le plus efficace ?$mq$, $mq$["Un ordre spatial : du plus proche au plus lointain, ou de gauche à droite","Un ordre aléatoire","Seulement les couleurs","Les détails sans vue d'ensemble"]$mq$, 0, $mq$Une description progressive guide l'imagination du lecteur. L'ordre doit être annoncé ou facile à suivre.$mq$, $mq$medium$mq$),
($mq$Quelle version de la phrase « La forêt était belle et grande, il y avait beaucoup d'arbres » est la plus efficace ?$mq$, $mq$["La forêt était très très belle.","La forêt avait des arbres.","Il y avait une forêt magnifique.","Les sapins se dressaient comme des colonnes et l'air sentait la résine humide."]$mq$, 3, $mq$La version riche utilise une comparaison, des verbes précis et des sensations (odorat). Les autres restent vagues.$mq$, $mq$hard$mq$),
($mq$Dans un récit au passé simple, un élève écrit : « Elle entra dans la salle. Elle voit un homme. » Quelle correction rétablit la cohérence ?$mq$, $mq$["Elle verrait un homme.","Elle verra un homme.","Elle vit un homme.","Elle a vu un homme."]$mq$, 2, $mq$Le récit est au passé simple : l'action ponctuelle « voit » devient « vit ». Les temps doivent rester cohérents.$mq$, $mq$hard$mq$),
($mq$Nouvelle sur un garçon qui a perdu son chien. Quelle fin est la mieux cohérente avec l'intrigue ?$mq$, $mq$["Un extraterrestre arrive sans lien avec l'histoire","Il retrouve son chien ou apprend à vivre sans lui, ce qui résout le problème central","Le texte s'arrête au milieu d'une phrase","Un nouveau personnage inconnu raconte autre chose"]$mq$, 1, $mq$Le dénouement doit répondre à la tension créée par l'élément perturbateur.$mq$, $mq$hard$mq$),
($mq$Un narrateur-personnage de douze ans raconte à la première personne. Quelle limite en découle ?$mq$, $mq$["Il ne peut pas connaître directement les pensées des autres personnages","Il connaît tous les secrets","Il ne peut pas utiliser l'imparfait","Il ne peut pas décrire un lieu"]$mq$, 0, $mq$Le point de vue est limité : il peut seulement supposer ce que ressentent les autres, ce qui peut créer du mystère.$mq$, $mq$hard$mq$),
($mq$Qu'est-ce qui distingue une écriture créative très maîtrisée ?$mq$, $mq$["Un texte très long quel que soit son contenu","Beaucoup d'adjectifs sans choix","Un récit sans fin","Des choix délibérés de voix, de structure et de vocabulaire qui produisent un effet précis"]$mq$, 3, $mq$Les critères récompensent le contrôle : chaque choix a un effet voulu sur le lecteur.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Narrative and Descriptive Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Schéma narratif$mq$, $mq$Situation initiale, élément perturbateur, péripéties, dénouement, situation finale.$mq$),
($mq$In medias res$mq$, $mq$Commencer le récit au milieu de l'action pour accrocher le lecteur, puis revenir en arrière si besoin.$mq$),
($mq$Imparfait / passé simple$mq$, $mq$Imparfait : décor, durée, habitude. Passé simple : actions ponctuelles qui font avancer le récit.$mq$),
($mq$Montrer plutôt que dire$mq$, $mq$Décrire gestes et détails qui font comprendre l'émotion : « Ses mains tremblaient » plutôt que « Elle avait peur ».$mq$),
($mq$Narrateur omniscient$mq$, $mq$Narrateur qui connaît les pensées, le passé et l'avenir de tous les personnages.$mq$),
($mq$Narrateur-personnage (« je »)$mq$, $mq$Raconte à la première personne : proche des émotions, mais limité à ce qu'il sait et voit.$mq$),
($mq$Description sensorielle$mq$, $mq$Mobiliser les cinq sens (vue, ouïe, odorat, goût, toucher) pour rendre une scène vivante.$mq$),
($mq$Métaphore / comparaison$mq$, $mq$Comparaison : avec outil (comme, tel). Métaphore : assimilation directe, sans outil (« un tableau gris »).$mq$),
($mq$Dialogue rapporté$mq$, $mq$Guillemets, ponctuation et incise : « Viens vite ! » cria Zoé (minuscule après les guillemets fermants).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Narrative and Descriptive Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## L'essentiel
L'écriture narrative raconte une histoire ; l'écriture descriptive fait voir un lieu, un personnage ou une atmosphère. Les deux se mélangent presque toujours. Pour réussir, tu dois contrôler la structure, le point de vue, les temps verbaux et le choix des mots.

## La structure d'un récit
Le **schéma narratif** comprend cinq étapes :
- **la situation initiale** : personnages, lieu, équilibre de départ ;
- **l'élément perturbateur** : événement qui rompt l'équilibre ;
- **les péripéties** : épreuves et actions qui suivent ;
- **le dénouement** : résolution du problème ;
- **la situation finale** : nouvel équilibre.
Tu peux ouvrir **in medias res**, c'est-à-dire en pleine action, pour accrocher le lecteur, puis revenir en arrière. Le suspense naît d'informations retenues, d'indices et de phrases courtes au moment critique. La fin doit répondre au problème posé au début.

## Le point de vue
- **Première personne (« je »)** : proche des émotions, mais limité à ce que le narrateur sait.
- **Troisième personne, point de vue interne** : on suit les pensées d'un seul personnage.
- **Narrateur omniscient** : il connaît tout, y compris les pensées des autres.
Choisis un point de vue et garde-le tout au long du texte.

## Les temps du récit
Au passé, l'**imparfait** décrit le cadre et les actions qui durent ; le **passé simple** (ou le passé composé à l'oral) exprime les actions ponctuelles. Exemple : « Il ouvrit la porte alors que le vent soufflait fort. » Reste cohérent : ne passe pas du passé simple au présent par erreur (« Elle entra… Elle vit… », pas « Elle voit »).

## Décrire efficacement
- **Les cinq sens** : ce qu'on voit, entend, sent, goûte, touche.
- **Les figures** : comparaison (« se dressaient comme des colonnes »), métaphore (« le ciel était un tableau gris »), personnification.
- **Montrer plutôt que dire** : au lieu de « Elle avait peur », écris « Ses mains tremblaient sur la poignée de sa valise ».
- **Un ordre clair** : du proche au lointain, de gauche à droite, du général au détail.
- **Des verbes précis** plutôt que des adjectifs vagues comme « beau » ou « grand ».
Exemple inventé : au lieu de « La forêt était belle et grande », écris « Les sapins se dressaient comme des colonnes et l'air sentait la résine humide ».

## Les dialogues
Ils rendent les personnages vivants. Utilise des guillemets ou des tirets, une ponctuation précise et des verbes de parole variés. Exemple : « Viens vite ! » cria Zoé. Remarque la minuscule après les guillemets fermants. Chaque réplique doit apprendre quelque chose sur le personnage ou faire avancer l'action.

## Comment c'est évalué
L'écriture créative est jugée selon la richesse des idées, l'organisation, le contrôle du style et l'exactitude de la langue. Les meilleurs textes ne cumulent pas les figures : chaque choix a un effet voulu.

## Erreurs fréquentes
- Raconter trop d'événements sans en développer aucun.
- Changer de temps sans raison.
- Dire les émotions au lieu de les montrer.
- Terminer la nouvelle sans résoudre le problème central.

Exam tip: pendant la relecture, souligne un verbe vague (« être », « avoir », « faire ») dans chaque paragraphe et remplace-le par un verbe plus précis.$mq$ from st;

-- Writing > Argument and Formal Writing
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Writing$mq$, 5, 6 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Argument and Formal Writing$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Writing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Argument and Formal Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Quelle formule d'appel convient pour une lettre formelle à un destinataire inconnu ?$mq$, $mq$["Madame, Monsieur,","Salut !","Coucou,","Cher ami,"]$mq$, 0, $mq$« Madame, Monsieur, » est la formule d'appel neutre et respectueuse de la lettre formelle.$mq$, $mq$easy$mq$),
($mq$Quel registre de langue convient à une lettre adressée à la direction ?$mq$, $mq$["Familier","Argotique","Uniquement des abréviations","Soutenu ou courant, poli et précis"]$mq$, 3, $mq$Une lettre formelle évite l'argot, les abréviations et les expressions familières.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce que la thèse d'un texte argumentatif ?$mq$, $mq$["Le titre du paragraphe","Un exemple de la vie quotidienne","L'opinion principale que l'auteur défend","Une citation du dictionnaire"]$mq$, 2, $mq$Tous les arguments servent à soutenir la thèse.$mq$, $mq$easy$mq$),
($mq$Quel élément doit accompagner un argument pour le rendre convaincant ?$mq$, $mq$["Un point d'exclamation","Un exemple ou une preuve","Une répétition de la thèse","Un mot familier"]$mq$, 1, $mq$Un argument sans exemple reste une simple affirmation.$mq$, $mq$easy$mq$),
($mq$Quel pronom utilise-t-on pour s'adresser à un destinataire adulte dans une lettre formelle ?$mq$, $mq$["Vous","Tu","On","Ils"]$mq$, 0, $mq$Le vouvoiement marque le respect et la distance appropriée.$mq$, $mq$easy$mq$),
($mq$Quelle phrase est la plus adaptée à une lettre formelle ?$mq$, $mq$["Salut, j'voulais te demander un truc.","Alors voilà, il faut que ça change.","Faut m'dire oui !","Je vous écris afin de solliciter l'autorisation d'organiser une collecte."]$mq$, 3, $mq$La phrase utilise un registre soutenu, un vouvoiement et un vocabulaire précis.$mq$, $mq$medium$mq$),
($mq$À quoi sert un contre-argument ?$mq$, $mq$["À changer de sujet","À supprimer la thèse","À reconnaître un point de vue opposé afin de le réfuter","À allonger l'introduction"]$mq$, 2, $mq$Le contre-argument montre que l'auteur a réfléchi à d'autres opinions, puis il y répond.$mq$, $mq$medium$mq$),
($mq$Quel connecteur exprime la conséquence ?$mq$, $mq$["Pourtant","Par conséquent","En revanche","Malgré tout"]$mq$, 1, $mq$« Par conséquent » introduit le résultat de ce qui précède.$mq$, $mq$medium$mq$),
($mq$Quelle formule finale est correcte dans une lettre formelle ?$mq$, $mq$["Veuillez agréer, Madame, Monsieur, l'expression de mes salutations distinguées.","Bisous de ma part.","Salut et à la prochaine !","À plus, bonne chance !"]$mq$, 0, $mq$C'est la formule de politesse classique d'une lettre officielle.$mq$, $mq$medium$mq$),
($mq$Que doit indiquer l'objet d'une lettre formelle ?$mq$, $mq$["Le nom de l'expéditeur","La date de naissance","Une citation","Le sujet précis de la lettre en quelques mots"]$mq$, 3, $mq$Par exemple : « Objet : demande d'autorisation pour une collecte ».$mq$, $mq$medium$mq$),
($mq$Quelle suite complète le mieux l'idée « Les écrans fatiguent les yeux » ?$mq$, $mq$["« Voilà. »","« Tout le monde le sait. »","« Une étude interne à l'école a montré que beaucoup d'élèves se plaignent de maux de tête après deux heures d'écran. »","« Je n'aime pas ça. »"]$mq$, 2, $mq$L'exemple précis (même fictif) soutient l'argument. Les autres suites n'apportent aucune preuve.$mq$, $mq$medium$mq$),
($mq$Quelle introduction convient à un article d'opinion ?$mq$, $mq$["Une liste de sources","Une accroche, la présentation du sujet et la thèse","Une conclusion","Un dialogue sans lien"]$mq$, 1, $mq$L'introduction doit situer le débat et annoncer clairement la position.$mq$, $mq$medium$mq$),
($mq$Pour un effet maximal, comment ordonner ses arguments ?$mq$, $mq$["Souvent du moins fort au plus fort","Toujours le plus faible en dernier","Dans un ordre aléatoire","En répétant le premier"]$mq$, 0, $mq$Une progression croissante laisse l'impression finale la plus forte sur le lecteur.$mq$, $mq$medium$mq$),
($mq$Un élève écrit : « Les écrans sont mauvais. Tout le monde le sait. » Quel est le défaut principal ?$mq$, $mq$["Un excès de ponctuation","Un vocabulaire trop soutenu","Une trop longue explication","Une affirmation sans preuve et un appel à la majorité"]$mq$, 3, $mq$On ne démontre rien : « tout le monde le sait » n'est pas un argument. Il faut une preuve ou un exemple.$mq$, $mq$hard$mq$),
($mq$« Je vous prie de bien vouloir m'excuser, mais franchement c'est nul. » Quelle est la principale erreur ?$mq$, $mq$["Un manque de verbes","Une phrase au futur","Un mélange de registres : soutenu au début, familier ensuite","Un excès de formules de politesse"]$mq$, 2, $mq$« Franchement c'est nul » est familier et contredit le ton formel du début de la phrase.$mq$, $mq$hard$mq$),
($mq$Quelle version intègre le mieux un contre-argument ?$mq$, $mq$["« Le projet coûte cher. »","« Certes, ce projet coûte cher ; mais il rendrait le quartier plus sûr pendant des décennies. »","« Ce projet est nul, ceux qui l'aiment ont tort. »","« Peut-être, je ne sais pas. »"]$mq$, 1, $mq$La concession reconnaît l'objection puis la réfute. Elle renforce la crédibilité de l'auteur.$mq$, $mq$hard$mq$),
($mq$Consigne : « Rédigez un article pour convaincre la direction d'installer des fontaines. » Quelle liste de contrôle est la plus complète ?$mq$, $mq$["Destinataire, but, registre, thèse, arguments avec exemples, contre-argument, relecture","Titre seulement","Dessin et slogan","Longueur seulement"]$mq$, 0, $mq$Une liste de contrôle couvre la situation d'écriture, la structure argumentative et la correction finale.$mq$, $mq$hard$mq$),
($mq$Quelle reformulation de « Tous les adolescents passent leur vie sur leur téléphone » est la plus précise et défendable ?$mq$, $mq$["« Les adolescents n'ont jamais de vie. »","« Personne ne lâche jamais son téléphone. »","« Les téléphones sont tout. »","« Beaucoup d'adolescents passent plusieurs heures par jour sur leur téléphone. »"]$mq$, 3, $mq$Éviter les généralisations absolues (« tous », « jamais ») rend l'argument plus crédible et nuancé.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Argument and Formal Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Formule d'appel (destinataire inconnu)$mq$, $mq$« Madame, Monsieur, » : neutre et respectueuse dans une lettre formelle.$mq$),
($mq$Formule de politesse$mq$, $mq$« Veuillez agréer, Madame, Monsieur, l'expression de mes salutations distinguées. »$mq$),
($mq$Thèse$mq$, $mq$L'opinion principale défendue dans le texte, annoncée dès l'introduction.$mq$),
($mq$Registre formel$mq$, $mq$Vouvoiement, vocabulaire précis, pas d'argot ni d'abréviations, ton courtois et cohérent.$mq$),
($mq$Objet de la lettre$mq$, $mq$Ligne qui indique le sujet en quelques mots : « Objet : demande d'autorisation pour une collecte ».$mq$),
($mq$Contre-argument$mq$, $mq$Reconnaître l'opinion adverse puis la réfuter : « Certes… mais… ».$mq$),
($mq$Structure d'un argument$mq$, $mq$Idée + exemple ou preuve + explication de l'effet qui soutient la thèse.$mq$),
($mq$Généralisation absolue$mq$, $mq$« Tous », « jamais », « personne » : à éviter. Préférer « beaucoup », « souvent », « plusieurs ».$mq$),
($mq$Ordre des arguments$mq$, $mq$Souvent du moins fort au plus fort, pour terminer sur une impression forte.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Argument and Formal Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## L'essentiel
L'écriture argumentative et formelle sert à défendre une opinion ou à demander quelque chose de façon claire, polie et structurée. On la retrouve dans les lettres officielles, les articles d'opinion, les discours et les rapports. Ton objectif : convaincre un destinataire précis avec un ton adapté et des preuves solides.

## Le registre formel
- Utilise le **vouvoiement** avec un adulte ou une institution.
- Évite l'argot, les abréviations, les expressions familières et les mots comme « truc » ou « nul ».
- Choisis un vocabulaire précis et des phrases bien construites.
Exemple : « Je vous écris afin de solliciter l'autorisation d'organiser une collecte » plutôt que « Salut, j'voulais te demander un truc ». Garde le même registre du début à la fin : « Je vous prie de bien vouloir m'excuser, mais franchement c'est nul » mélange deux registres et affaiblit le texte.

## La lettre formelle
- **Coordonnées** de l'expéditeur et du destinataire, date et lieu.
- **Objet** : le sujet en quelques mots (« Objet : demande d'autorisation pour une collecte »).
- **Formule d'appel** : « Madame, Monsieur, » si tu ne connais pas le nom.
- **Corps** : introduction de la demande, développement avec arguments, conclusion avec la demande précise.
- **Formule de politesse** : « Veuillez agréer, Madame, Monsieur, l'expression de mes salutations distinguées. »
- **Signature**.

## Construire une argumentation
- **La thèse** : ton opinion principale, énoncée clairement dès l'introduction.
- **Les arguments** : trois idées distinctes, chacune avec un exemple ou une preuve et une explication.
- **Le contre-argument** : tu reconnais l'opinion opposée, puis tu la réfutes. « Certes, ce projet coûte cher ; mais il rendrait le quartier plus sûr pendant des années. »
- **L'ordre** : va souvent du moins fort au plus fort pour finir avec impact.
- **La conclusion** : rappelle la thèse, résume les arguments, ouvre ou formule la demande.
Les connecteurs logiques rendent le raisonnement visible : d'abord, de plus, cependant, par conséquent, en effet, pour conclure.

## Éviter les pièges
- **L'affirmation sans preuve** : « Les écrans sont mauvais. Tout le monde le sait. » N'est pas un argument.
- **La généralisation absolue** : « Tous les adolescents passent leur vie sur leur téléphone. » Préfère « Beaucoup d'adolescents passent plusieurs heures par jour sur leur téléphone ».
- **Le ton agressif** : attaquer les personnes plutôt que les idées réduit ta crédibilité.

## Exemple de paragraphe
« D'abord, une fontaine à eau réduirait les déchets plastiques. Dans notre établissement, plus de deux cents bouteilles sont jetées chaque semaine. En installant des fontaines, la direction diminuerait ce volume et encouragerait des gestes durables. » On trouve l'idée, un exemple chiffré (fictif) et l'explication de l'effet.

## Comment c'est évalué
À l'eAssessment, on te demandera de rédiger un texte argumentatif ou formel adapté à une situation donnée. Les critères valorisent l'adaptation au destinataire, la qualité des arguments, l'organisation, le registre et l'exactitude de la langue.

## Erreurs fréquentes
- Mélanger tutoiement et vouvoiement.
- Oublier la formule de politesse.
- Empiler des opinions sans exemples.
- Terminer sans formuler la demande.

Exam tip: avant de rendre ta copie, vérifie trois choses : le destinataire est-il bien vouvoyé, chaque argument a-t-il un exemple, et la demande finale est-elle claire ?$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;