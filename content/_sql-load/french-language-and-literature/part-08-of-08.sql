-- Part 8 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- eAssessment Skills for Literature > Command Terms and Question Types
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Literature$mq$, 5, 8 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Command Terms and Question Types$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Literature$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Command Terms and Question Types$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Que demande le terme de consigne « Identifiez » ?$mq$, $mq$["Nommer ou relever un élément sans longue explication","Écrire une dissertation complète","Comparer deux textes en détail","Juger l'efficacité d'un texte"]$mq$, 0, $mq$« Identifiez » demande de repérer et de nommer, par exemple un procédé ou une information, sans développer.$mq$, $mq$easy$mq$),
($mq$Que demande le terme « Expliquez » ?$mq$, $mq$["Recopier le texte","Donner uniquement un titre","Dessiner un schéma","Donner les raisons ou le fonctionnement avec précision"]$mq$, 3, $mq$Expliquer, c'est dire comment ou pourquoi quelque chose se produit, avec des raisons claires.$mq$, $mq$easy$mq$),
($mq$Que demande le terme « Comparez » ?$mq$, $mq$["Résumer un seul texte","Inventer une fin","Montrer les ressemblances et les différences","Corriger les fautes"]$mq$, 2, $mq$Comparer exige de mettre en relation au moins deux éléments, avec similitudes et différences.$mq$, $mq$easy$mq$),
($mq$Que signifie « Justifiez votre réponse » ?$mq$, $mq$["Répéter la question","Appuyer sa réponse sur des preuves du texte","Changer d'avis","Écrire un poème"]$mq$, 1, $mq$On justifie en citant ou en reformulant un passage précis qui soutient la réponse.$mq$, $mq$easy$mq$),
($mq$Que demande le terme « Résumez » ?$mq$, $mq$["Restituer l'essentiel de façon brève","Analyser chaque mot","Critiquer le style","Recopier le texte en entier"]$mq$, 0, $mq$Un résumé garde les idées principales et supprime les détails.$mq$, $mq$easy$mq$),
($mq$Quelle est la différence entre « Décrivez » et « Analysez » ?$mq$, $mq$["Il n'y a aucune différence","Analyser demande moins de précision","Décrire demande un jugement","Décrire dit ce qu'on voit ; analyser examine comment et pourquoi, avec l'effet produit"]$mq$, 3, $mq$Analyser va plus loin que décrire : on identifie un choix de l'auteur et on explique son effet.$mq$, $mq$medium$mq$),
($mq$Que demande le terme « Discutez » ?$mq$, $mq$["Donner une seule opinion sans preuve","Recopier un passage","Examiner plusieurs aspects ou points de vue avant de conclure","Faire une liste de mots"]$mq$, 2, $mq$Discuter, c'est peser des arguments pour et contre, puis aboutir à une position nuancée.$mq$, $mq$medium$mq$),
($mq$Que demande le terme « Évaluez » ?$mq$, $mq$["Citer un mot","Porter un jugement argumenté sur l'efficacité ou la valeur","Compter les paragraphes","Traduire le texte"]$mq$, 1, $mq$Évaluer implique un jugement appuyé sur des critères et des preuves.$mq$, $mq$medium$mq$),
($mq$Dans « Relevez une expression qui montre la joie du personnage », que doit-on faire ?$mq$, $mq$["Copier exactement un passage du texte","Résumer le texte","Écrire sa propre opinion","Inventer une expression"]$mq$, 0, $mq$« Relevez » demande une citation exacte, entre guillemets.$mq$, $mq$medium$mq$),
($mq$Quelle question est inférentielle ?$mq$, $mq$["Où se passe la scène ?","Combien de personnages sont nommés ?","Quel est le titre du texte ?","Pourquoi le narrateur hésite-t-il à ouvrir la lettre ?"]$mq$, 3, $mq$Il faut interpréter des indices pour expliquer pourquoi, ce qui n'est pas dit explicitement.$mq$, $mq$medium$mq$),
($mq$Dans une question à choix multiples, quelle stratégie est la plus fiable ?$mq$, $mq$["Choisir toujours la plus longue","Choisir au hasard sans lire","Éliminer les options manifestement fausses, puis vérifier la restante dans le texte","Ne pas répondre"]$mq$, 2, $mq$L'élimination réduit le nombre de réponses possibles. La vérification dans le texte confirme.$mq$, $mq$medium$mq$),
($mq$Dans « Quel est l'effet de la répétition de « nous » ? », qu'attend-on ?$mq$, $mq$["Un résumé du texte","L'impression produite sur le lecteur ou l'auditoire","La date de publication","Le genre de l'auteur"]$mq$, 1, $mq$Les questions d'effet demandent de relier un procédé à l'impression ou à la réaction du lecteur.$mq$, $mq$medium$mq$),
($mq$Quelle phrase comparative est la mieux construite ?$mq$, $mq$["Alors que le texte A utilise un ton ironique, le texte B adopte un ton grave.","Le texte A et le texte B.","Les deux textes sont des textes.","Texte A ironique texte B."]$mq$, 0, $mq$Un connecteur comme « alors que » met deux textes en regard avec une précision commune (le ton).$mq$, $mq$medium$mq$),
($mq$Question : « Dans quelle mesure l'auteur réussit-il à émouvoir le lecteur ? » Quelle réponse correspond le mieux à la demande ?$mq$, $mq$["Un résumé de l'histoire","Une liste de mots difficiles","Une opinion sans exemple","Un jugement nuancé, appuyé sur deux ou trois procédés cités et leur effet"]$mq$, 3, $mq$« Dans quelle mesure » invite à évaluer : réussite partielle ou totale, avec preuves.$mq$, $mq$hard$mq$),
($mq$Question : « Expliquez l'effet de la répétition dans cet extrait. » Quelle réponse est la plus complète ?$mq$, $mq$["« Il y a des répétitions. »","« L'auteur répète. »","« La répétition de « encore » (l. 3) montre l'épuisement du personnage et donne un rythme monotone. »","« C'est beau. »"]$mq$, 2, $mq$La meilleure réponse contient le procédé, la citation et l'effet. Les autres n'expliquent rien.$mq$, $mq$hard$mq$),
($mq$Question à choix multiples : « Quelle citation justifie le mieux l'idée que le héros est inquiet ? » Comment choisir ?$mq$, $mq$["Choisir la citation la plus longue","Prendre la citation qui contient un indice précis (geste ou mot) en lien direct avec l'inquiétude","Choisir la citation qui mentionne le héros","Choisir celle du début du texte"]$mq$, 1, $mq$Une bonne preuve est directement liée à l'idée à justifier, pas simplement longue ou proche du sujet.$mq$, $mq$hard$mq$),
($mq$Un élève répond à « Évaluez l'efficacité du discours » en décrivant seulement le contenu. Quel est son principal défaut ?$mq$, $mq$["Il n'émet aucun jugement argumenté","Il a trop cité","Il a écrit trop de mots","Il a utilisé le bon registre"]$mq$, 0, $mq$« Évaluez » exige un jugement avec critères et preuves, pas seulement une description.$mq$, $mq$hard$mq$),
($mq$Consigne : « Identifiez un procédé, puis expliquez son effet. » Un élève nomme seulement l'anaphore. Que manque-t-il ?$mq$, $mq$["Rien, la réponse est complète","Un résumé du texte","La date de l'extrait","L'explication de l'effet : la consigne comporte deux tâches"]$mq$, 3, $mq$Une consigne en deux temps exige deux réponses. La seconde (l'effet) est la plus valorisée.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Command Terms and Question Types$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Identifiez / Relevez$mq$, $mq$Repérer et nommer brièvement ; « relevez » demande une citation exacte du texte.$mq$),
($mq$Expliquez$mq$, $mq$Dire comment ou pourquoi, avec des raisons claires.$mq$),
($mq$Analysez$mq$, $mq$Décomposer, examiner un choix de l'auteur et son effet sur le lecteur.$mq$),
($mq$Comparez$mq$, $mq$Montrer les ressemblances et les différences entre deux éléments, à propos du même point.$mq$),
($mq$Justifiez$mq$, $mq$Appuyer sa réponse sur une preuve précise du texte (citation ou reformulation).$mq$),
($mq$Discutez$mq$, $mq$Examiner plusieurs aspects ou points de vue, puis conclure de façon nuancée.$mq$),
($mq$Évaluez$mq$, $mq$Porter un jugement argumenté sur l'efficacité ou la valeur, avec critères et preuves.$mq$),
($mq$Chaîne de réponse$mq$, $mq$Procédé, preuve (citation courte), effet sur le lecteur : trois éléments pour une réponse complète.$mq$),
($mq$Consigne en deux temps$mq$, $mq$« Identifiez puis expliquez » : deux tâches, deux réponses. En oublier une fait perdre des points.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Command Terms and Question Types$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## L'essentiel
Les termes de consigne (ou verbes d'action) disent ce qu'on attend de toi et à quelle profondeur. Beaucoup de points se perdent non par manque de connaissances, mais parce que la réponse ne correspond pas au verbe de la question. Apprendre ces termes, c'est apprendre à lire l'énoncé comme un correcteur.

## Les principaux termes de consigne
- **Identifiez / Relevez / Nommez** : repère et indique, brièvement. « Relevez » demande une citation exacte entre guillemets.
- **Décrivez / Résumez** : dis ce qui est présent ou l'essentiel, sans jugement.
- **Expliquez** : dis comment ou pourquoi, avec des raisons.
- **Analysez** : décompose, examine un choix de l'auteur et son effet sur le lecteur.
- **Comparez** : montre les ressemblances et les différences entre deux éléments, à propos du même point.
- **Justifiez** : appuie ton idée sur une preuve précise du texte.
- **Discutez** : examine plusieurs aspects ou points de vue avant de conclure.
- **Évaluez** : porte un jugement argumenté sur l'efficacité ou la valeur.
Si la consigne contient deux verbes (« Identifiez puis expliquez »), il faut faire les deux.

## Les types de questions
- **Repérage (littérale)** : l'information est dans le texte (« Où se passe la scène ? »).
- **Inférence** : il faut interpréter des indices (« Pourquoi le narrateur hésite-t-il ? »).
- **Procédés et effets** : nomme la technique et explique son effet (« Quel est l'effet de la répétition de « nous » ? »).
- **Question de comparaison** : deux textes ou deux passages.
- **Jugement** : « Dans quelle mesure… ? » appelle une réponse nuancée.

## Répondre selon la consigne
Une réponse efficace suit la chaîne **procédé, preuve, effet**. Exemple : « La répétition de « encore » (l. 3) montre l'épuisement du personnage et donne un rythme monotone. » Pour comparer, relie les textes par un connecteur : « Alors que le texte A utilise un ton ironique, le texte B adopte un ton grave. »

## Les questions à choix multiples
- Lis l'énoncé en entier, y compris la consigne.
- Élimine les options fausses ou hors sujet.
- Vérifie l'option restante dans le texte.
- Méfie-toi des options très « attirantes » qui contiennent un mot du texte mais disent autre chose.
- Pour « quelle citation justifie… », choisis la preuve la plus directement liée à l'idée.

## Comment c'est évalué
Dans un examen sur écran, les questions de compréhension, d'analyse et d'écriture portent sur des textes courts et variés. Les critères valorisent la précision et le lien explicite entre ton idée et le texte. Une bonne réponse est ciblée : ni trop courte, ni hors sujet.

## Erreurs fréquentes
- Décrire au lieu d'analyser.
- Oublier une des deux tâches d'une consigne double.
- Donner une opinion sans preuve.
- Citer sans expliquer.

Exam tip: souligne le verbe de la consigne et écris-le en haut de ta réponse au brouillon : tu sauras ainsi à chaque phrase si tu décris, expliques ou juges.$mq$ from st;

-- eAssessment Skills for Literature > Time Management
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Literature$mq$, 5, 8 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Time Management$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Literature$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Time Management$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Que faut-il faire en premier au début d'une épreuve ?$mq$, $mq$["Lire les consignes et repérer la répartition des tâches","Écrire sans lire","Relire la conclusion","Fermer les yeux"]$mq$, 0, $mq$Une vue d'ensemble permet de prévoir le temps pour chaque tâche.$mq$, $mq$easy$mq$),
($mq$Que faire si une question bloque ?$mq$, $mq$["Y passer tout le temps","Abandonner l'épreuve","Écrire au hasard une longue réponse","La marquer, passer à la suivante et y revenir plus tard"]$mq$, 3, $mq$Cela évite de perdre du temps et permet de gagner des points faciles ailleurs.$mq$, $mq$easy$mq$),
($mq$Pourquoi garder quelques minutes à la fin ?$mq$, $mq$["Pour dormir","Pour écrire une nouvelle introduction","Pour relire et corriger","Pour changer de sujet"]$mq$, 2, $mq$La relecture permet de corriger des erreurs et de compléter les réponses.$mq$, $mq$easy$mq$),
($mq$Une question vaut peu de points. Combien de temps y consacrer ?$mq$, $mq$["Autant qu'à la tâche principale","Peu : une réponse précise et brève","Aucun temps","Tout le temps restant"]$mq$, 1, $mq$Le temps doit être proportionnel aux points disponibles.$mq$, $mq$easy$mq$),
($mq$Que faire pour une question à choix multiples dont on n'est pas sûr ?$mq$, $mq$["Éliminer des options et choisir la plus probable","Laisser vide","Écrire un long paragraphe","Demander à son voisin"]$mq$, 0, $mq$Une réponse raisonnée vaut mieux qu'une case vide.$mq$, $mq$easy$mq$),
($mq$Une épreuve dure 90 minutes : 5 minutes de lecture initiale, 10 minutes de relecture, et 3 tâches de poids égal. Combien de minutes pour chaque tâche ?$mq$, $mq$["20","30","15","25"]$mq$, 3, $mq$90 − 5 − 10 = 75 minutes disponibles ; 75 ÷ 3 = 25 minutes par tâche.$mq$, $mq$medium$mq$),
($mq$Pourquoi consacrer cinq minutes à un plan avant une tâche d'écriture ?$mq$, $mq$["Cela fait gagner des points automatiquement","Cela remplace la rédaction","Le texte sera mieux organisé et on perdra moins de temps à hésiter","C'est obligatoire dans toutes les épreuves"]$mq$, 2, $mq$Un plan court réduit les hésitations et évite les digressions.$mq$, $mq$medium$mq$),
($mq$Face à un long extrait, quelle méthode est la plus efficace ?$mq$, $mq$["Lire seulement la première ligne","Lire une fois en entier, puis relire en annotant les éléments utiles pour les questions","Lire sans réfléchir","Ne lire que les questions"]$mq$, 1, $mq$Une première lecture donne la vue d'ensemble, la seconde permet de cibler les indices.$mq$, $mq$medium$mq$),
($mq$Que faire si l'épreuve se passe sur écran avec un minuteur ?$mq$, $mq$["Vérifier régulièrement l'heure restante et ajuster","Ne jamais regarder","Cacher le minuteur et ignorer le temps","Attendre la dernière minute"]$mq$, 0, $mq$Le suivi du temps permet de corriger le rythme à temps.$mq$, $mq$medium$mq$),
($mq$Une question vaut 2 points. Quelle longueur de réponse est adaptée ?$mq$, $mq$["Trois pages","Un seul mot sans explication","Aucune réponse","Deux idées clairement développées en une ou deux phrases"]$mq$, 3, $mq$Souvent, un nombre de points correspond à un nombre d'idées à donner.$mq$, $mq$medium$mq$),
($mq$Tu te sens stressé(e) en plein milieu de l'épreuve. Quelle réaction est la plus utile ?$mq$, $mq$["Quitter la salle","Écrire plus vite sans lire","Respirer calmement quelques secondes puis reprendre la question suivante","Rayer tout ce que tu as écrit"]$mq$, 2, $mq$Quelques secondes de calme aident à retrouver la concentration.$mq$, $mq$medium$mq$),
($mq$Si l'outil le permet, que faire d'une question incertaine ?$mq$, $mq$["L'effacer","La marquer pour la revoir","La répéter 10 fois","L'ignorer pour toujours"]$mq$, 1, $mq$Marquer une question permet d'y revenir facilement pendant la relecture.$mq$, $mq$medium$mq$),
($mq$Un test contient 25 questions à choix multiples à traiter en 30 minutes. Combien de secondes par question en moyenne ?$mq$, $mq$["72","60","90","120"]$mq$, 0, $mq$30 minutes = 1 800 secondes ; 1 800 ÷ 25 = 72 secondes.$mq$, $mq$medium$mq$),
($mq$Temps utile : 80 minutes. La tâche A vaut 40 % des points, la tâche B 60 %. Quelle répartition proportionnelle convient ?$mq$, $mq$["A : 40 min, B : 40 min","A : 48 min, B : 32 min","A : 20 min, B : 60 min","A : 32 min, B : 48 min"]$mq$, 3, $mq$40 % de 80 = 32 minutes et 60 % de 80 = 48 minutes.$mq$, $mq$hard$mq$),
($mq$Un élève passe 35 minutes sur une tâche qui vaut un quart des points, dans une épreuve de 60 minutes. Quel est le problème ?$mq$, $mq$["Il a trop relu","Il a un bon rythme","Le temps n'est pas proportionnel : il en reste trop peu pour les autres tâches","Il n'a pas lu l'énoncé"]$mq$, 2, $mq$Un quart des points mérite environ un quart du temps, soit 15 minutes, et non plus de la moitié.$mq$, $mq$hard$mq$),
($mq$20 questions de 1 point doivent être traitées en 15 minutes. Un élève met en moyenne 50 secondes par question. De combien dépasse-t-il le temps ?$mq$, $mq$["50 secondes","1 minute 40 secondes","3 minutes","Il ne dépasse pas"]$mq$, 1, $mq$20 × 50 s = 1 000 s = 16 min 40 s ; 15 minutes = 900 s ; dépassement de 100 s, soit 1 min 40 s.$mq$, $mq$hard$mq$),
($mq$Il reste dix minutes. Quel ordre de relecture est le plus rentable ?$mq$, $mq$["Vérifier que toutes les questions ont une réponse, puis les termes de consigne et les citations, puis l'orthographe","Corriger d'abord les virgules de la première page","Réécrire tout depuis le début","Ne rien relire"]$mq$, 0, $mq$Les réponses manquantes coûtent le plus de points ; ensuite on s'assure de répondre à la consigne ; l'orthographe vient en dernier.$mq$, $mq$hard$mq$),
($mq$Il reste trois minutes et ton texte n'a pas de conclusion. Que faire ?$mq$, $mq$["Recommencer l'introduction","Ajouter un nouveau paragraphe d'arguments","Laisser la copie telle quelle","Écrire une conclusion courte plutôt que laisser le texte inachevé"]$mq$, 3, $mq$Un texte complet et cohérent est mieux noté qu'un texte inachevé, même avec une conclusion brève.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Time Management$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Budget de temps$mq$, $mq$Temps total moins lecture et relecture, divisé selon le poids des tâches. Ex. : (90 − 5 − 10) ÷ 3 = 25 min par tâche.$mq$),
($mq$Proportionnalité$mq$, $mq$Le temps consacré à une tâche doit correspondre à son poids : 40 % des points, environ 40 % du temps.$mq$),
($mq$Rythme des QCM$mq$, $mq$Diviser le temps par le nombre de questions : 25 questions en 30 min = 72 secondes chacune.$mq$),
($mq$Question bloquante$mq$, $mq$Marquer, passer à la suivante et y revenir si le temps le permet.$mq$),
($mq$Plan rapide$mq$, $mq$Environ 5 minutes : trois idées, un mot-clé par paragraphe, avant de rédiger.$mq$),
($mq$Lecture d'un long extrait$mq$, $mq$Une lecture d'ensemble, puis une relecture avec annotations ciblées sur les questions.$mq$),
($mq$Ordre de relecture$mq$, $mq$1. Réponses manquantes ; 2. respect de la consigne ; 3. preuves ; 4. grammaire et orthographe.$mq$),
($mq$Manque de temps en écriture$mq$, $mq$Écrire une conclusion courte plutôt que laisser le texte inachevé.$mq$),
($mq$Gérer le stress$mq$, $mq$Respirer calmement, continuer avec la question suivante : sauter une question est une stratégie.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Time Management$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## L'essentiel
Dans un examen sur écran, le temps est une ressource comme une autre : on la répartit, on la surveille et on la protège. Des élèves qui connaissent bien le programme perdent parfois des points à cause d'une mauvaise gestion du temps. L'objectif est de terminer toutes les tâches, avec une relecture, sans paniquer.

## Avant de commencer
- Lis les consignes générales et regarde combien de tâches et de points il y a.
- Calcule un budget de temps. Exemple : épreuve de 90 minutes, 5 minutes de lecture initiale, 10 minutes de relecture, trois tâches de poids égal : (90 − 5 − 10) ÷ 3 = 25 minutes par tâche.
- Note les heures de fin visées pour chaque tâche.

## Répartir proportionnellement aux points
Le temps doit correspondre au poids de chaque tâche. Si tu disposes de 80 minutes et que la tâche A vaut 40 % des points et la tâche B 60 %, prévois 32 minutes pour A et 48 minutes pour B. Consacrer 35 minutes à une tâche qui vaut un quart des points d'une épreuve de 60 minutes est une erreur de gestion.

## Les questions à choix multiples
Compte ton rythme : 25 questions en 30 minutes, c'est en moyenne 72 secondes par question. Lis, élimine, vérifie dans le texte, choisis. Si tu hésites, marque la question (si l'outil le permet) et continue : tu y reviendras si tu as du temps. Ne laisse pas de case vide.

## Les tâches d'écriture
- **Plan (environ 5 minutes)** : trois idées, un mot-clé par paragraphe.
- **Rédaction** : écris d'abord ce qui apporte le plus de points.
- **Relecture (au moins 5 minutes)** : relis plusieurs fois avec un but précis.
Si le temps manque, écris une conclusion courte plutôt que de laisser le texte inachevé : un texte complet est plus cohérent.

## Bien lire les textes
Pour un long extrait, lis une première fois sans t'arrêter pour comprendre l'ensemble, puis une seconde fois en annotant les indices utiles. Lire les questions avant le texte peut t'aider à cibler tes annotations.

## La relecture dans l'ordre d'importance
1. Toutes les questions ont-elles une réponse ?
2. As-tu répondu à la consigne (identifier, expliquer, justifier) ?
3. Chaque idée est-elle appuyée sur une preuve du texte ?
4. Grammaire, ponctuation et orthographe.

## Gérer le stress
Respire calmement quelques secondes, bois un peu d'eau avant l'épreuve, et rappelle-toi que passer à la question suivante est une stratégie, pas un échec.

## Comment c'est évalué
Le temps ne se note pas directement, mais il influence tous les critères : une réponse inachevée ou bâclée perd en analyse, en organisation et en précision. S'entraîner en conditions réelles avec un minuteur aide beaucoup.

## Erreurs fréquentes
- Dépasser son budget sur la première tâche.
- Ne rien garder pour la relecture.
- S'acharner sur une question difficile.
- Laisser des réponses vides.

Exam tip: écris au brouillon l'heure de fin visée pour chaque tâche dès le début, puis compare avec le minuteur à chaque changement de tâche.$mq$ from st;

-- eAssessment Skills for Literature > Using the Criteria
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Literature$mq$, 5, 8 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Using the Criteria$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Literature$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Using the Criteria$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Combien de critères sont utilisés pour évaluer la Langue et Littérature en MYP ?$mq$, $mq$["Quatre","Deux","Trois","Cinq"]$mq$, 0, $mq$Les critères sont A (Analyse), B (Organisation), C (Production de textes) et D (Utilisation de la langue).$mq$, $mq$easy$mq$),
($mq$Quel critère évalue la capacité à analyser un texte ?$mq$, $mq$["Le critère B","Le critère C","Le critère D","Le critère A"]$mq$, 3, $mq$Le critère A porte sur l'analyse du contenu, du contexte, du langage, de la structure et des choix de l'auteur.$mq$, $mq$easy$mq$),
($mq$Que mesure le critère D ?$mq$, $mq$["Le plan du texte","L'originalité du sujet seulement","L'utilisation de la langue : vocabulaire, grammaire, ponctuation, orthographe","La longueur du devoir"]$mq$, 2, $mq$Le critère D évalue la qualité et la précision de la langue écrite.$mq$, $mq$easy$mq$),
($mq$Sur quelle échelle chaque critère est-il noté ?$mq$, $mq$["Niveaux de 1 à 4","Niveaux de 1 à 8","Notes de 1 à 20","Pourcentage de 0 à 100"]$mq$, 1, $mq$Chaque critère est évalué en niveaux de 1 à 8, selon des descripteurs qui précisent ce qu'on attend.$mq$, $mq$easy$mq$),
($mq$Que mesure le critère B ?$mq$, $mq$["L'organisation : structure, paragraphes, transitions, adaptation au type de texte","L'analyse littéraire seulement","L'orthographe seulement","La vitesse d'écriture"]$mq$, 0, $mq$Le critère B évalue l'organisation des idées et la cohérence.$mq$, $mq$easy$mq$),
($mq$Quel comportement répond le mieux au critère A ?$mq$, $mq$["Résumer l'histoire","Donner son avis sans preuve","Recopier le texte","Citer un passage précis puis expliquer l'effet produit sur le lecteur"]$mq$, 3, $mq$L'analyse exige preuve et explication des choix de l'auteur.$mq$, $mq$medium$mq$),
($mq$Que valorise surtout le critère C ?$mq$, $mq$["Le nombre de pages","L'imitation exacte d'un texte","La production de textes créatifs ou réfléchis, avec des choix délibérés de forme et de perspective","Le seul respect de la grammaire"]$mq$, 2, $mq$Le critère C porte sur la création et l'exploration de perspectives et de choix de style.$mq$, $mq$medium$mq$),
($mq$Qu'est-ce qui distingue en général un niveau élevé d'un niveau moyen dans les descripteurs ?$mq$, $mq$["Plus de pages","Plus de nuance, de justesse et de cohérence sur l'ensemble du devoir","Des mots plus rares seulement","Moins d'exemples"]$mq$, 1, $mq$Les niveaux supérieurs décrivent une analyse perspicace, soutenue et bien argumentée.$mq$, $mq$medium$mq$),
($mq$Une copie présente des idées dans un ordre aléatoire, sans paragraphes ni transitions. Quel critère est le plus touché ?$mq$, $mq$["Le critère B","Le critère A","Le critère D","Aucun"]$mq$, 0, $mq$L'organisation, la cohérence et la structure relèvent du critère B.$mq$, $mq$medium$mq$),
($mq$Une copie est riche en idées mais contient tant d'erreurs de grammaire que le sens est parfois difficile à saisir. Quel critère est le plus touché ?$mq$, $mq$["Le critère B","Aucun","Le critère C seulement","Le critère D"]$mq$, 3, $mq$La clarté de la communication et la maîtrise de la langue dépendent du critère D.$mq$, $mq$medium$mq$),
($mq$Pourquoi lire les descripteurs avant de s'entraîner ?$mq$, $mq$["Pour apprendre les réponses par cœur","Pour éviter de rédiger","Pour savoir précisément ce qu'on doit montrer à chaque niveau","Pour changer les critères"]$mq$, 2, $mq$Connaître les attentes permet de cibler ses efforts et d'évaluer ses propres textes.$mq$, $mq$medium$mq$),
($mq$Un élève cite beaucoup de passages avec de courts commentaires. Un autre cite moins, mais explique en détail l'effet de chaque citation. Lequel est plus proche d'un niveau élevé au critère A ?$mq$, $mq$["Le premier","Le second","Les deux sont identiques","Aucun"]$mq$, 1, $mq$La profondeur de l'explication, pas la quantité de citations, caractérise une analyse de haut niveau.$mq$, $mq$medium$mq$),
($mq$Un devoir est parfaitement organisé mais sans aucune référence précise au texte. Que peut-on conclure ?$mq$, $mq$["Il est solide au critère B mais faible au critère A","Il est faible au critère B","Il est solide au critère A","Il n'a pas de critère"]$mq$, 0, $mq$Une belle structure ne remplace pas la preuve : l'analyse reste insuffisante.$mq$, $mq$medium$mq$),
($mq$Pour passer d'un niveau intermédiaire à un niveau supérieur dans un essai, que faut-il ajouter ?$mq$, $mq$["Seulement plus de longueur","Seulement des mots plus longs","Des citations sans explication","Davantage de perspicacité, de précision et d'argumentation soutenue"]$mq$, 3, $mq$La longueur ne fait pas monter de niveau ; la qualité de la pensée et de l'argumentation, oui.$mq$, $mq$hard$mq$),
($mq$Quel objectif d'amélioration est le plus utile pour un élève ?$mq$, $mq$["« Je veux mieux écrire. »","« Je vais essayer plus. »","« Je vais expliquer l'effet de chaque citation en une phrase complète. »","« Je n'aime pas les examens. »"]$mq$, 2, $mq$Un bon objectif est précis, mesurable et lié à un critère.$mq$, $mq$hard$mq$),
($mq$Un devoir créatif contient des idées originales (critère C) mais un ordre confus (critère B). Quelle amélioration est la plus rentable ?$mq$, $mq$["Supprimer toutes les idées originales","Réorganiser avec un plan clair et des transitions, sans perdre les idées","Allonger le texte","Changer de sujet"]$mq$, 1, $mq$On préserve la force du critère C et on corrige la faiblesse du critère B.$mq$, $mq$hard$mq$),
($mq$Tu relis ton analyse avec la grille. Pour monter au critère A, quelle phrase de remplacement est la plus efficace pour « L'auteur utilise une métaphore » ?$mq$, $mq$["« La métaphore « un tableau gris » (l. 2) donne au ciel un aspect figé et mélancolique. »","« L'auteur est doué. »","« Il y a une figure. »","« C'est une jolie phrase. »"]$mq$, 0, $mq$La version améliorée contient le procédé, la citation, la localisation et l'effet précis.$mq$, $mq$hard$mq$),
($mq$Pourquoi un élève ne doit-il pas se concentrer sur un seul critère ?$mq$, $mq$["Parce que les critères n'existent plus","Parce que le critère A est inutile","Parce que l'examinateur ne lit pas la copie","Parce que le résultat final dépend de tous les critères évalués dans la tâche"]$mq$, 3, $mq$Un texte équilibré qui satisfait plusieurs critères est mieux évalué que le travail qui n'en travaille qu'un.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Using the Criteria$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Critère A$mq$, $mq$Analyse : comprendre et analyser le contenu, le contexte, le langage, la structure et les choix de l'auteur, avec preuves.$mq$),
($mq$Critère B$mq$, $mq$Organisation : structure claire, paragraphes, transitions, cohérence, adaptation au type de texte.$mq$),
($mq$Critère C$mq$, $mq$Production de textes : créer un texte réfléchi ou créatif avec des choix délibérés de forme, de style et de perspective.$mq$),
($mq$Critère D$mq$, $mq$Utilisation de la langue : vocabulaire, grammaire, syntaxe, ponctuation, orthographe, registre.$mq$),
($mq$Échelle des critères$mq$, $mq$Chaque critère est évalué en niveaux de 1 à 8 grâce à des descripteurs par paliers.$mq$),
($mq$Monter de niveau$mq$, $mq$Il faut plus de précision, de nuance et de cohérence, pas simplement plus de longueur.$mq$),
($mq$Citation expliquée$mq$, $mq$Citer un passage précis puis expliquer son effet sur le lecteur : base d'une bonne analyse (critère A).$mq$),
($mq$Auto-évaluation$mq$, $mq$Relire son travail avec la grille, trouver une preuve pour chaque critère, fixer un objectif précis.$mq$),
($mq$Objectif précis$mq$, $mq$« J'expliquerai l'effet de chaque citation en une phrase » est plus utile que « Je veux mieux écrire ».$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Using the Criteria$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## L'essentiel
Les devoirs de Langue et Littérature en MYP sont évalués selon des critères publics. Les connaître, c'est savoir précisément ce que le correcteur cherche. Un élève qui lit les critères avant d'écrire fait de meilleurs choix et sait comment progresser.

## Les quatre critères
- **Critère A : Analyse.** Tu montres que tu comprends le contenu, le contexte, le langage, la structure et les choix de l'auteur, avec des preuves tirées du texte.
- **Critère B : Organisation.** Ton texte est structuré (introduction, paragraphes, conclusion), cohérent et adapté au type de texte demandé, avec des transitions claires.
- **Critère C : Production de textes.** Tu crées un texte réfléchi ou créatif, en faisant des choix délibérés de forme, de style et de perspective.
- **Critère D : Utilisation de la langue.** Tu emploies un vocabulaire riche, une grammaire correcte, une ponctuation et une orthographe maîtrisées, dans un registre adapté.
Chaque critère est évalué en **niveaux de 1 à 8**, selon des descripteurs par paliers (1-2, 3-4, 5-6, 7-8).

## Lire les descripteurs
Les mots-clés varient : « limité », « adéquat », « solide », « perspicace ». Pour monter de niveau, il ne suffit pas d'écrire plus : il faut plus de précision, de nuance et de cohérence sur l'ensemble du devoir. Surligne les verbes d'action des descripteurs : ils indiquent ce que tu dois faire.

## Ce que les niveaux élevés demandent
- **A** : analyse perspicace et soutenue, avec des citations précises dont l'effet est expliqué.
- **B** : structure claire, paragraphes équilibrés, transitions efficaces.
- **C** : choix créatifs délibérés, voix personnelle, exploration de perspectives.
- **D** : langue précise et variée, peu d'erreurs, registre contrôlé.
Un devoir peut être fort pour un critère et faible pour un autre. Un devoir parfaitement organisé mais sans référence précise au texte est solide pour B et faible pour A.

## Exemple d'amélioration
Phrase faible : « L'auteur utilise une métaphore. » Phrase améliorée : « La métaphore « un tableau gris » (l. 2) donne au ciel un aspect figé et mélancolique. » On ajoute la citation, la localisation et l'effet.

## S'auto-évaluer
1. Relis ton devoir avec la grille.
2. Entoure ce que chaque critère demande et trouve une preuve dans ta copie.
3. Écris un objectif précis pour la prochaine fois : « J'expliquerai l'effet de chaque citation en une phrase complète » plutôt que « Je veux mieux écrire ».

## Comment c'est évalué
Dans l'examen, les questions sont construites pour permettre d'atteindre ces critères : des questions d'analyse (A), des questions de structure (B), des tâches d'écriture (C) et l'exactitude de la langue (D). Les copies équilibrées obtiennent les meilleurs résultats d'ensemble.

## Erreurs fréquentes
- Écrire beaucoup sans analyser.
- Citer sans expliquer l'effet.
- Négliger la relecture linguistique.
- Se fixer des objectifs vagues.

Exam tip: avant de rendre ton devoir, vérifie un point par critère : A, une citation expliquée ; B, des transitions ; C, un choix créatif assumé ; D, une relecture des accords.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;