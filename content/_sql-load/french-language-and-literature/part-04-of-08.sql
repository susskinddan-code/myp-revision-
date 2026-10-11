-- Part 4 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Poetry > Reading Poems Closely
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Poetry$mq$, 5, 4 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Reading Poems Closely$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Poetry$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Reading Poems Closely$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Qui est le locuteur (ou « je » lyrique) d'un poème ?$mq$, $mq$["La voix qui s'exprime dans le poème, sans être forcément le poète","Forcément le poète lui-même","L'éditeur du recueil","Le lecteur"]$mq$, 0, $mq$Le locuteur est la voix qui parle dans le poème. On ne doit pas l'assimiler automatiquement à l'auteur.$mq$, $mq$easy$mq$),
($mq$Comment appelle-t-on un groupe de vers séparé des autres par un blanc ?$mq$, $mq$["Un chapitre","Un paragraphe","Une rime","Une strophe"]$mq$, 3, $mq$Une strophe est un groupe de vers formant une unité, séparée par un espace blanc.$mq$, $mq$easy$mq$),
($mq$Que faire en premier face à un poème inconnu ?$mq$, $mq$["Compter les lettres","Chercher seulement les rimes","Lire le titre et lire le poème en entier pour dégager le sujet et l'impression générale","Écrire la conclusion avant de lire"]$mq$, 2, $mq$Une première lecture globale (titre, sujet, émotion) donne une base avant l'analyse précise des procédés.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce qu'un champ lexical dans un poème ?$mq$, $mq$["Une liste de rimes","Un ensemble de mots liés à un même thème","Un vers libre","Un titre"]$mq$, 1, $mq$Le champ lexical regroupe des mots d'un même domaine (ex. nuit, ombre, silence) et révèle le thème ou l'atmosphère.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce que l'imagerie d'un poème ?$mq$, $mq$["L'ensemble des images, surtout sensorielles, que le poème fait naître","Le dessin sur la page","La musique du poème uniquement","La biographie du poète"]$mq$, 0, $mq$L'imagerie regroupe les images (visuelles, sonores, tactiles) et figures qui font voir et ressentir.$mq$, $mq$easy$mq$),
($mq$Poème inventé : « Le vieux banc, sous l'arbre nu, / attend encore ceux qui ne reviennent pas. » Quelle est la thématique dominante ?$mq$, $mq$["La joie d'une fête","La compétition sportive","La technologie","L'absence et l'attente"]$mq$, 3, $mq$« Attend encore » et « ne reviennent pas » évoquent l'absence ; l'arbre nu renforce une impression de vide et d'hiver.$mq$, $mq$medium$mq$),
($mq$Poème inventé : « Mon cœur est une barque abandonnée sur la grève. » Quelle figure est présente ?$mq$, $mq$["Une comparaison","Une anaphore","Une métaphore","Une litote"]$mq$, 2, $mq$Le cœur est directement identifié à une barque abandonnée, sans mot de comparaison : c'est une métaphore qui suggère la solitude.$mq$, $mq$medium$mq$),
($mq$Poème inventé : « Je suis seul. / Seul comme la lune. / Seul, / Et la nuit n'a pas de fin. » Quel effet produit la répétition de « seul » ?$mq$, $mq$["Elle crée un effet comique","Elle insiste sur le sentiment d'isolement","Elle introduit une description","Elle n'a aucun rôle"]$mq$, 1, $mq$La répétition du mot clé, aidée par les vers très courts, imite un écho et renforce l'isolement du locuteur.$mq$, $mq$medium$mq$),
($mq$Que signifie « lire entre les vers » ?$mq$, $mq$["Interpréter ce que le poème suggère sans le dire directement","Sauter des lignes","Ne lire que la dernière strophe","Réciter par cœur"]$mq$, 0, $mq$La poésie est souvent allusive : on s'appuie sur les images, les sons et les silences pour comprendre ce qui est suggéré.$mq$, $mq$medium$mq$),
($mq$Poème inventé : « Au premier vers, le printemps éclate ; / au dernier, la neige efface tout. » Que montre ce contraste ?$mq$, $mq$["Une erreur du poète","Un poème de météo","Une description technique","Un retournement qui exprime l'éphémère et la fragilité de la joie"]$mq$, 3, $mq$Le contraste entre la naissance du printemps et la neige finale exprime le passage du temps, thème fréquent en poésie.$mq$, $mq$medium$mq$),
($mq$À quoi sert un enjambement ?$mq$, $mq$["À mettre fin à un poème","À rimer deux vers","À faire déborder une phrase sur le vers suivant pour créer rythme, surprise ou emphase","À changer de strophe"]$mq$, 2, $mq$L'enjambement fait passer le sens au vers suivant : il peut accélérer, suspendre ou mettre en relief le mot rejeté.$mq$, $mq$medium$mq$),
($mq$Poème inventé : « Les mots se posent, un à un, comme des cendres. » Comment analyser la comparaison ?$mq$, $mq$["Elle décrit une cuisine","Elle suggère à la fois la légèreté et la perte, car les cendres évoquent ce qui reste après la fin","Elle indique la date","Elle est neutre"]$mq$, 1, $mq$Les cendres associent légèreté et disparition : la comparaison colore les mots d'une tonalité de deuil.$mq$, $mq$medium$mq$),
($mq$Quelle phrase représente la meilleure introduction à l'analyse d'un poème ?$mq$, $mq$["Ce poème exprime la nostalgie d'un locuteur qui regrette un lieu d'enfance, à travers des images de lumière et de silence.","Ce poème est très beau.","Il y a des rimes dans le poème.","L'auteur est mort."]$mq$, 0, $mq$Une bonne introduction identifie thème, voix et procédés principaux, sans jugement vague.$mq$, $mq$medium$mq$),
($mq$Poème inventé : « Dans la rue, la pluie lave les pas de ceux qui sont partis. Je les cherche encore dans les flaques, où brille un morceau de ciel. » Quelle analyse est la plus précise ?$mq$, $mq$["Le poème décrit uniquement le temps qu'il fait","Le locuteur déteste la pluie sans nuance","Le poème est un mode d'emploi","La pluie qui efface et les flaques où le ciel brille associent deuil et espoir fragile : le locuteur cherche une trace des absents tout en trouvant de la lumière"]$mq$, 3, $mq$Deux images s'opposent : effacement (pluie qui lave) et lueur (ciel dans les flaques). La lecture fine rend compte de cette ambivalence.$mq$, $mq$hard$mq$),
($mq$Poème inventé : « Je t'écris sans papier, / sans encre, / avec le vent. » Que révèle l'accumulation de négations (« sans... sans... ») ?$mq$, $mq$["Un manque de moyens matériels du poète","Une critique de l'écriture","Le caractère impossible ou immatériel de la communication, qui donne à l'amour ou au souvenir une dimension insaisissable","Un jeu de mots comique"]$mq$, 2, $mq$Les négations enlèvent les supports habituels de l'écriture : ce qui reste est impalpable. L'image du vent suggère un message qui ne se fixe pas.$mq$, $mq$hard$mq$),
($mq$Poème inventé en deux strophes. Strophe 1 : « La maison chante, pleine de voix. » Strophe 2 : « La maison se tait, les volets clos. » Que fait la structure du poème ?$mq$, $mq$["Elle répète exactement la même idée","Elle oppose un avant et un après, soulignant l'effet du temps ou d'une perte","Elle décrit deux maisons différentes sans lien","Elle supprime le sens"]$mq$, 1, $mq$La structure en deux temps (voix / silence) met en scène un changement. Le parallélisme des deux phrases rend le contraste plus frappant.$mq$, $mq$hard$mq$),
($mq$Pourquoi faut-il éviter de dire « le poète pense que... » sans précaution ?$mq$, $mq$["Parce que le locuteur est une voix construite : on parle plutôt du « locuteur » ou de « la voix du poème »","Parce que les poètes ne pensent pas","Parce que le verbe penser est interdit","Parce que les poèmes n'ont pas de sens"]$mq$, 0, $mq$On distingue le poète réel de la voix mise en scène dans le poème. Cela permet une analyse fidèle au texte.$mq$, $mq$hard$mq$),
($mq$Poème inventé : « Le silence — immense — ne dit rien. Et pourtant, il me répond. » Comment décrire l'effet de « ne dit rien » / « il me répond » ?$mq$, $mq$["Une erreur de logique","Une définition scientifique","Une répétition sans effet","Un paradoxe qui montre que le silence est ressenti comme une présence qui communique"]$mq$, 3, $mq$Le paradoxe fait coexister deux idées contraires : le silence, vide en apparence, devient interlocuteur. L'effet est poétique et intime.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Reading Poems Closely$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Locuteur lyrique$mq$, $mq$La voix qui s'exprime dans le poème (« je »). On ne la confond pas automatiquement avec le poète.$mq$),
($mq$Strophe$mq$, $mq$Groupe de vers séparé des autres par un blanc. Distique : 2 vers. Tercet : 3. Quatrain : 4. Quintil : 5. Sizain : 6.$mq$),
($mq$Enjambement$mq$, $mq$Phrase qui se prolonge sur le vers suivant. Il crée un rythme, une surprise ou met un mot en relief.$mq$),
($mq$Champ lexical$mq$, $mq$Ensemble de mots d'un même domaine (nuit, ombre, silence). Il révèle le thème ou l'atmosphère.$mq$),
($mq$Paradoxe poétique$mq$, $mq$Association d'idées contraires qui produit un sens inattendu, par exemple « le silence me répond ».$mq$),
($mq$Poésie allusive$mq$, $mq$Elle suggère plus qu'elle ne dit : on lit entre les vers en interprétant images, sons et silences.$mq$),
($mq$Trois lectures d'un poème$mq$, $mq$1. Comprendre (titre, sujet, émotion). 2. Observer (lexique, images, sons, structure). 3. Interpréter (sentiment, effets, thème).$mq$),
($mq$Structure en deux temps$mq$, $mq$Beaucoup de poèmes opposent un avant et un après (joie / perte). Le retournement final change le sens.$mq$),
($mq$Méthode de commentaire$mq$, $mq$Relever un mot, nommer le procédé, expliquer l'effet, relier au thème du poème.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Reading Poems Closely$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Entrer dans un poème
Un poème dit beaucoup en peu de mots. Chaque mot, chaque blanc, chaque son compte. Pour le lire de près, on avance par étapes : on comprend d'abord, on observe ensuite, on interprète enfin. Une lecture rapide ne suffit presque jamais : il faut revenir plusieurs fois sur le texte.

## Première lecture : comprendre
- Lisez le **titre** : il annonce parfois le sujet, parfois il crée un contraste ou une ironie.
- Lisez le poème en entier, si possible à voix basse.
- Identifiez le **sujet** (de quoi parle-t-il ?), l'**émotion** dominante et le **locuteur** (qui parle, à qui ?).
Le locuteur, ou « je » lyrique, est la voix du poème. On ne l'assimile pas automatiquement au poète : mieux vaut écrire « le locuteur » ou « la voix du poème ».

## Deuxième lecture : observer
Relevez les éléments suivants.
- **Le lexique** : repérez les champs lexicaux (nuit, ombre, silence) et les mots chargés de connotations.
- **Les images** : comparaisons, métaphores, personnifications. Exemple inventé : « Mon cœur est une barque abandonnée sur la grève » évoque la solitude.
- **Les sons** : rimes, allitérations, assonances.
- **Le rythme** : longueur des vers, enjambements, ponctuation, blancs.
- **La structure** : nombre de strophes, progression, retournement. Un poème peut s'organiser en deux temps (avant/après) ou par un changement de ton à la dernière strophe.
- **Les répétitions** : un mot repris (« seul... seul... seul ») insiste et crée un écho.

## Troisième lecture : interpréter
Posez-vous trois questions.
- **Que ressent le locuteur ?** Nostalgie, colère, émerveillement, deuil.
- **Comment les procédés créent-ils ce sentiment ?** Reliez chaque procédé à un effet.
- **Quelle idée générale se dégage ?** Le thème : l'absence, le temps, la nature, l'identité.
La poésie est souvent **allusive** : elle suggère plus qu'elle ne dit. Le poème « Le vieux banc, sous l'arbre nu, attend encore ceux qui ne reviennent pas » ne parle pas seulement d'un banc : il évoque l'absence et l'attente.

## Le paradoxe et l'ambivalence
Un poème peut associer des sentiments opposés. Dans l'exemple inventé « Le silence ne dit rien. Et pourtant, il me répond », le paradoxe transforme le silence en présence. Dans « la pluie lave les pas de ceux qui sont partis... un morceau de ciel brille dans les flaques », deux images s'opposent : l'effacement et la lueur. Une lecture fine tient compte de ces contrastes.

## Rédiger l'analyse
Une bonne analyse suit un fil : **introduction** (thème, voix, idée générale), **développement** (deux ou trois axes, chacun appuyé sur des citations courtes expliquées), **conclusion** (synthèse et ouverture). Pour chaque exemple, appliquez la méthode **relever, citer, expliquer l'effet, relier au thème**.

## Erreurs fréquentes
- Paraphraser le poème au lieu de l'analyser.
- Nommer des procédés sans en expliquer l'effet.
- Assimiler systématiquement le locuteur au poète.
- Ignorer la forme (strophes, rythme) pour ne commenter que le sens.
- Donner un jugement vague (« c'est beau », « c'est triste ») sans preuve.

## Comment cela est évalué
À l'examen, un court poème inventé ou emprunté au domaine public est proposé, accompagné de questions comme : « Quelle émotion domine ? Comment l'auteur l'exprime-t-il ? » Le critère A évalue la compréhension et l'analyse, le critère B la clarté de l'organisation de la réponse.

Exam tip: dans chaque paragraphe d'analyse, citez un mot précis du poème, nommez le procédé, puis écrivez « ce qui suggère... » : c'est la phrase qui transforme un relevé en interprétation.$mq$ from st;

-- Poetry > Poetic Forms
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Poetry$mq$, 5, 4 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Poetic Forms$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Poetry$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Poetic Forms$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Combien de vers compte un sonnet ?$mq$, $mq$["14","8","12","20"]$mq$, 0, $mq$Un sonnet compte quatorze vers, répartis en deux quatrains puis deux tercets.$mq$, $mq$easy$mq$),
($mq$Combien de syllabes compte un alexandrin ?$mq$, $mq$["10","8","6","12"]$mq$, 3, $mq$L'alexandrin est le vers de douze syllabes, avec souvent une césure au milieu.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce que le vers libre ?$mq$, $mq$["Un vers de douze syllabes","Un vers qui rime toujours","Un vers sans rime ni mesure régulière","Un vers interdit"]$mq$, 2, $mq$Le vers libre n'obéit ni à une mesure fixe ni à un système de rimes régulier.$mq$, $mq$easy$mq$),
($mq$Quel poème japonais bref suit traditionnellement le schéma 5-7-5 syllabes ?$mq$, $mq$["Le sonnet","Le haïku","L'ode","La ballade"]$mq$, 1, $mq$Le haïku est un poème très court de trois vers (5, 7, 5), souvent consacré à un instant de nature.$mq$, $mq$easy$mq$),
($mq$Comment appelle-t-on un groupe de quatre vers ?$mq$, $mq$["Un quatrain","Un tercet","Un distique","Un sizain"]$mq$, 0, $mq$Quatrain : 4 vers. Tercet : 3. Distique : 2. Sizain : 6.$mq$, $mq$easy$mq$),
($mq$Quatrain inventé : « Le vent chante au village, / La nuit tombe en silence, / Les enfants sont bien sages, / Et la lune s'avance. » Quel schéma de rimes ?$mq$, $mq$["AABB (rimes plates)","ABBA (rimes embrassées)","Aucune rime","ABAB (rimes croisées)"]$mq$, 3, $mq$village / sages (A) alternent avec silence / avance (B) : ABAB, c'est-à-dire des rimes croisées.$mq$, $mq$medium$mq$),
($mq$Quatrain inventé : « La rose rit au jardin, / Le chat dort sur le chemin, / Le soir pose sa lumière / Sur les toits et la rivière. » Quel schéma de rimes ?$mq$, $mq$["ABAB (rimes croisées)","ABBA (rimes embrassées)","AABB (rimes plates)","ABCD"]$mq$, 2, $mq$jardin / chemin (A A) puis lumière / rivière (B B) : les rimes se suivent deux à deux, ce sont des rimes plates.$mq$, $mq$medium$mq$),
($mq$Quatrain inventé : « Sur la mer, le bateau s'éloigne, / Le vent souffle, le ciel est clair ; / Les mouettes crient dans l'éther, / Et le marin que l'oubli soigne. » Quel schéma de rimes ?$mq$, $mq$["ABAB (rimes croisées)","ABBA (rimes embrassées)","AABB (rimes plates)","AAAA"]$mq$, 1, $mq$éloigne / soigne (A, premier et dernier vers) enveloppent clair / éther (B B) : les rimes sont embrassées.$mq$, $mq$medium$mq$),
($mq$Quelle est la structure d'un sonnet classique ?$mq$, $mq$["Deux quatrains suivis de deux tercets","Quatre tercets","Un seul bloc de 14 vers sans pause","Trois quatrains et un distique"]$mq$, 0, $mq$Le sonnet classique : 4 + 4 + 3 + 3 vers. La dernière strophe contient souvent une chute ou un retournement.$mq$, $mq$medium$mq$),
($mq$Qu'est-ce qu'une rime féminine ?$mq$, $mq$["Une rime qui parle de femmes","Une rime de plus de trois sons","Une rime absente","Une rime qui se termine par un e muet"]$mq$, 3, $mq$Une rime féminine se termine par un e muet (ex. « rivière »). Une rime masculine ne se termine pas ainsi (ex. « chemin »).$mq$, $mq$medium$mq$),
($mq$Qu'est-ce qu'un calligramme ?$mq$, $mq$["Un poème sans verbes","Un poème de quatorze vers","Un poème dont la disposition des mots dessine un objet lié au sujet","Un poème sans titre"]$mq$, 2, $mq$Le calligramme associe texte et image : la forme typographique reprend le thème, comme une pluie de mots qui tombent.$mq$, $mq$medium$mq$),
($mq$Qu'est-ce qu'une ode ?$mq$, $mq$["Un poème comique de deux vers","Un poème lyrique qui célèbre une personne, un lieu ou une idée","Un poème sans rimes","Une chanson populaire seulement"]$mq$, 1, $mq$L'ode est un poème d'éloge, souvent solennel ou enthousiaste, adressé à son objet.$mq$, $mq$medium$mq$),
($mq$Qu'est-ce qu'un poème en prose ?$mq$, $mq$["Un texte poétique sans vers, organisé en paragraphes, avec images et rythme","Un roman de plusieurs chapitres","Un article de journal","Un dialogue de théâtre"]$mq$, 0, $mq$Le poème en prose emploie les ressources poétiques (images, musicalité) sans la forme du vers.$mq$, $mq$medium$mq$),
($mq$Un poète choisit le vers libre pour exprimer un souvenir confus. Quel est l'effet probable ?$mq$, $mq$["Il veut respecter le sonnet","Il veut compter exactement 12 syllabes","Il renonce à tout rythme","La liberté de forme reflète le désordre ou la spontanéité des émotions"]$mq$, 3, $mq$Le vers libre épouse le mouvement de la pensée : des vers de longueurs variables imitent hésitations, élans et ruptures.$mq$, $mq$hard$mq$),
($mq$Dans un sonnet inventé, les quatrains décrivent un paysage paisible, puis le dernier tercet s'ouvre sur « Mais l'orage vient ». Quel rôle joue ce dernier tercet ?$mq$, $mq$["Il répète le début","Il est inutile","Il crée une chute ou un retournement qui change la lecture du poème","Il prouve que le poème est en prose"]$mq$, 2, $mq$La fin du sonnet apporte souvent une chute ou une pointe qui renverse la vision précédente : le contraste donne tout son sens au poème.$mq$, $mq$hard$mq$),
($mq$Un poème est écrit en alexandrins parfaitement réguliers avec rimes plates pour évoquer un deuil. Quel effet la régularité peut-elle produire ?$mq$, $mq$["Un effet comique obligatoire","Une solennité contenue, qui exprime la dignité ou la retenue face à la douleur","Une impression de désordre","Aucun effet"]$mq$, 1, $mq$La forme régulière peut contenir la douleur dans un cadre rigoureux : la retenue formelle accentue la gravité.$mq$, $mq$hard$mq$),
($mq$Un poème se compose de trois quatrains en rimes croisées, et le même vers revient à la fin de chaque strophe. Quelle fonction a ce vers répété (refrain) ?$mq$, $mq$["Il crée un effet d'obsession, de musique et d'unité","Il remplace la rime","Il termine le poème par une erreur","Il rend le poème en prose"]$mq$, 0, $mq$Un refrain donne un effet de ritournelle et renforce un thème qui revient en boucle, comme un souvenir.$mq$, $mq$hard$mq$),
($mq$Quelle réponse analyse correctement le lien entre forme et sens dans un calligramme représentant une pluie de mots qui tombent ?$mq$, $mq$["Les mots sont placés au hasard","La disposition est sans rapport avec le sujet","Le calligramme supprime tout sens","La disposition verticale des mots imite visuellement la chute de la pluie et renforce l'impression de mélancolie liée au thème"]$mq$, 3, $mq$Le calligramme fait de la forme un élément du sens : l'image typographique prolonge le thème et touche le lecteur par la vue.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Poetic Forms$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Alexandrin$mq$, $mq$Vers de 12 syllabes, souvent coupé en deux par une césure au milieu.$mq$),
($mq$Décasyllabe / octosyllabe$mq$, $mq$Décasyllabe : vers de 10 syllabes. Octosyllabe : vers de 8 syllabes.$mq$),
($mq$Rimes plates, croisées, embrassées$mq$, $mq$Plates : AABB. Croisées : ABAB. Embrassées : ABBA.$mq$),
($mq$Rime féminine / masculine$mq$, $mq$Féminine : se termine par un e muet (rivière). Masculine : sans e muet final (chemin).$mq$),
($mq$Sonnet$mq$, $mq$Poème de 14 vers : deux quatrains puis deux tercets, avec souvent une chute dans le dernier tercet.$mq$),
($mq$Haïku$mq$, $mq$Poème bref d'origine japonaise, de trois vers, traditionnellement 5-7-5 syllabes, centré sur un instant de nature.$mq$),
($mq$Vers libre$mq$, $mq$Vers sans mesure ni rime régulière, qui suit le mouvement de la pensée ou de l'émotion.$mq$),
($mq$Calligramme$mq$, $mq$Poème dont la disposition typographique dessine un objet lié au sujet. Apollinaire l'a rendu célèbre.$mq$),
($mq$Poème en prose$mq$, $mq$Texte poétique sans vers, organisé en paragraphes, riche en images et en rythme.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Poetic Forms$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Pourquoi la forme compte
En poésie, la forme n'est pas un simple décor : elle participe au sens. La longueur des vers, la disposition des strophes, les rimes et même l'espace blanc sur la page influencent la façon dont on comprend et on ressent le poème. Savoir nommer les formes poétiques permet donc d'analyser avec précision.

## Le vers et la strophe
Le **vers** est une ligne de poème. On le mesure en **syllabes**.
- **L'alexandrin** : 12 syllabes, avec souvent une coupe au milieu appelée **césure**.
- **Le décasyllabe** : 10 syllabes. **L'octosyllabe** : 8 syllabes.
- **Le vers libre** : sans mesure ni rime régulière, il suit le mouvement de la pensée ou de l'émotion.
La **strophe** est un groupe de vers : le **distique** (2), le **tercet** (3), le **quatrain** (4), le **quintil** (5), le **sizain** (6).

## Les rimes
La **rime** est le retour du même son à la fin de deux vers. On repère le schéma en notant les rimes par des lettres.
- **Rimes plates (AABB)** : les rimes se suivent deux à deux. Exemple inventé : jardin / chemin, lumière / rivière.
- **Rimes croisées (ABAB)** : elles alternent. Exemple : village / silence / sages / avance.
- **Rimes embrassées (ABBA)** : une rime en enveloppe une autre. Exemple : éloigne / clair / éther / soigne.
Les rimes **féminines** se terminent par un e muet (rivière), les rimes **masculines** non (chemin). On alterne souvent les deux en poésie classique.

## Les grandes formes à connaître
- **Le sonnet** : 14 vers, soit deux quatrains puis deux tercets. La dernière strophe contient souvent une chute ou un retournement.
- **Le haïku** : poème très bref d'origine japonaise, de trois vers, traditionnellement de 5, 7 et 5 syllabes, qui saisit un instant de nature.
- **L'ode** : poème lyrique qui célèbre quelqu'un, un lieu ou une idée.
- **La ballade** : poème à strophes avec refrain.
- **Le calligramme** : les mots dessinent un objet lié au sujet, par exemple une pluie ou une tour. Guillaume Apollinaire l'a rendu célèbre.
- **Le poème en prose** : un texte poétique sans vers, organisé en paragraphes, mais riche en images et en musicalité.
- **Le refrain** : vers ou groupe de vers répété, qui crée une ritournelle ou une obsession.

## Forme et sens : comment analyser
Posez-vous trois questions.
- **Quelle forme le poète a-t-il choisie ?** Régulière (alexandrins, rimes) ou libre.
- **Pourquoi ce choix ?** La régularité peut exprimer la solennité, la retenue ou l'harmonie. Le vers libre peut exprimer la spontanéité, le trouble ou la rupture.
- **Où la forme se brise-t-elle ?** Un vers plus court, un enjambement, un blanc ou une rime manquante marque souvent un moment important.
Exemple : un sonnet qui décrit un paysage paisible puis se termine par « Mais l'orage vient » utilise la chute du dernier tercet pour renverser notre lecture.

## Erreurs fréquentes
- Nommer la forme sans expliquer son effet.
- Confondre rimes croisées (ABAB) et embrassées (ABBA).
- Compter les syllabes sans tenir compte du e muet : seuls certains e se prononcent en poésie classique, donc revérifiez avec précaution.
- Penser qu'un poème sans rimes n'est pas un poème.
- Oublier que les blancs et la disposition font partie de la forme.

## Comment cela est évalué
À l'examen, vous pouvez devoir identifier la forme d'un poème (strophes, rimes) puis expliquer comment elle soutient le thème. Le critère A valorise la précision du vocabulaire technique et le lien établi entre forme et sens.

Exam tip: après avoir identifié le schéma de rimes ou la forme, ajoutez toujours une phrase du type « ce choix de forme exprime... » ; sans cette phrase, vous ne faites que décrire.$mq$ from st;

-- Poetry > Comparing Poems
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Poetry$mq$, 5, 4 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Comparing Poems$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Poetry$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Comparing Poems$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Que signifie comparer deux poèmes ?$mq$, $mq$["Relever leurs ressemblances et leurs différences sur des points précis","Résumer successivement chaque poème sans lien","Dire lequel est le plus beau","Les recopier côte à côte"]$mq$, 0, $mq$Comparer, c'est mettre en relation deux textes selon des critères précis : thème, voix, ton, forme, images.$mq$, $mq$easy$mq$),
($mq$Quel mot de liaison exprime une ressemblance ?$mq$, $mq$["Cependant","En revanche","Au contraire","De même"]$mq$, 3, $mq$« De même » introduit une similitude. « Cependant », « en revanche » et « au contraire » marquent une opposition.$mq$, $mq$easy$mq$),
($mq$Quel mot de liaison exprime une différence ?$mq$, $mq$["De même","Également","En revanche","Tout comme"]$mq$, 2, $mq$« En revanche » introduit un contraste entre les deux textes.$mq$, $mq$easy$mq$),
($mq$Quels critères peut-on comparer entre deux poèmes ?$mq$, $mq$["Seulement la longueur de la page","Le thème, le ton, la voix, la forme et les images","Seulement le titre","Seulement l'année d'impression"]$mq$, 1, $mq$On compare le fond (thème, ton, sentiment) et la forme (rimes, rythme, structure, images).$mq$, $mq$easy$mq$),
($mq$Quelle organisation est la plus efficace pour une comparaison ?$mq$, $mq$["Un paragraphe par point de comparaison, avec les deux poèmes dans chaque paragraphe","Tout le poème A puis tout le poème B sans lien","Un paragraphe de résumé seulement","Une liste de citations"]$mq$, 0, $mq$Une structure par points (thème, ton, forme...) force à confronter les deux textes à chaque étape.$mq$, $mq$easy$mq$),
($mq$Poème A (inventé) : « Dans l'automne, mon père s'éloigne comme une feuille. » Poème B (inventé) : « Dans l'automne, ma mère revient avec la lumière. » Quel point commun existe ?$mq$, $mq$["Les deux parlent de la mer","Les deux sont des haïkus","Les deux emploient le futur","Les deux associent l'automne à une figure familiale"]$mq$, 3, $mq$Le cadre de l'automne et une figure familiale unissent les deux textes. La différence porte sur l'éloignement ou le retour.$mq$, $mq$medium$mq$),
($mq$Poème A : « Le silence pèse sur la ville endormie. » Poème B : « Le silence, doux, berce la ville. » Quelle différence principale ?$mq$, $mq$["Les deux ont le même ton","A est en prose et B en vers","A rend le silence oppressant, B le rend apaisant","B est plus court"]$mq$, 2, $mq$« Pèse » connote l'oppression ; « berce » connote la douceur. Le choix du verbe change l'atmosphère.$mq$, $mq$medium$mq$),
($mq$Poème A (inventé) : trois quatrains en alexandrins réguliers, rimes croisées. Poème B (inventé) : vers libre, sans rimes. Quelle comparaison de forme est la plus juste ?$mq$, $mq$["A et B sont identiques","A exprime l'ordre et la maîtrise ; B suggère la spontanéité ou la liberté","A est un haïku","B est un sonnet"]$mq$, 1, $mq$La forme régulière donne une impression de contrôle ; le vers libre reflète le mouvement de l'émotion. On compare l'effet des choix formels.$mq$, $mq$medium$mq$),
($mq$Poème A : « Je pars. » Poème B : « Je m'en vais lentement, longuement, comme on quitte un souvenir. » Quel contraste de rythme ?$mq$, $mq$["A est abrupt et bref ; B est lent et ample","Les deux sont identiques","A est plus long que B","B n'a pas de verbe"]$mq$, 0, $mq$La brièveté crée un geste net et froid ; la phrase longue et les adverbes dessinent un départ hésitant et nostalgique.$mq$, $mq$medium$mq$),
($mq$Quelle phrase est une bonne phrase de comparaison ?$mq$, $mq$["Le poème A est triste et le poème B aussi.","Le poème A a douze vers.","Je préfère le poème B.","Alors que le poème A évoque la solitude avec des images de froid, le poème B la présente comme un refuge, grâce à un lexique de chaleur."]$mq$, 3, $mq$La phrase relie les deux textes, précise le thème commun, souligne la différence et nomme un procédé (champ lexical).$mq$, $mq$medium$mq$),
($mq$Pourquoi est-il important de citer les deux poèmes dans une comparaison ?$mq$, $mq$["Pour allonger la réponse","Pour éviter d'expliquer","Pour prouver chaque affirmation avec des exemples précis","Parce que c'est facultatif"]$mq$, 2, $mq$Chaque point de comparaison doit être soutenu par un court exemple tiré de chaque texte.$mq$, $mq$medium$mq$),
($mq$Poème A : « L'enfance est un jardin perdu. » Poème B : « L'enfance est un jardin que je porte. » Quelle nuance les distingue ?$mq$, $mq$["Les deux disent exactement la même chose","A exprime la perte irrémédiable, B la présence intérieure du souvenir","A parle de jardinage, B de peinture","A est au futur"]$mq$, 1, $mq$« Perdu » ferme le passé ; « que je porte » en fait une ressource intérieure. Le même motif sert deux visions différentes.$mq$, $mq$medium$mq$),
($mq$En conclusion d'une comparaison, que doit-on faire ?$mq$, $mq$["Synthétiser ce que la comparaison révèle sur la façon dont chaque poète traite le même thème et exprimer ce que l'on retient","Répéter exactement l'introduction","Raconter sa vie","Ne rien ajouter"]$mq$, 0, $mq$La conclusion répond à la question posée en synthétisant ressemblances et différences, et peut proposer une ouverture.$mq$, $mq$medium$mq$),
($mq$Poème A : le locuteur parle à un « tu » (un être aimé absent). Poème B : le locuteur parle à la nature. Quelle différence de voix et d'adresse peut-on relever ?$mq$, $mq$["A et B s'adressent au lecteur","A est un narrateur extérieur","B est un dialogue de théâtre","A est intime et personnel ; B élargit le propos vers le monde ou le paysage"]$mq$, 3, $mq$Le destinataire change la portée : un « tu » précis crée l'intimité, la nature crée un ton plus contemplatif ou universel.$mq$, $mq$hard$mq$),
($mq$Deux poèmes inventés évoquent la guerre. A décrit des soldats avec des verbes d'action brutaux ; B décrit une mère qui attend avec des phrases douces et lentes. Quelle analyse est la plus complète ?$mq$, $mq$["Les deux poèmes n'ont aucun point commun","A et B sont identiques","Même thème, mais A choisit le choc et la violence, B l'attente et l'intime ; les rythmes et le lexique renforcent ces deux regards complémentaires","Seul A parle de guerre"]$mq$, 2, $mq$Une comparaison fine part d'un point commun (le thème), puis met en évidence des différences de point de vue, de lexique et de rythme, avec une idée de synthèse.$mq$, $mq$hard$mq$),
($mq$Poème A (inventé) se termine sur « le jour se lève » ; poème B (inventé) sur « la nuit referme ses mains ». Les deux parlent d'un deuil. Que révèle la comparaison des chutes ?$mq$, $mq$["Les deux fins sont identiques","A ouvre sur une consolation ou l'espoir ; B reste dans la clôture du chagrin","A est plus long","B n'a pas de dernière strophe"]$mq$, 1, $mq$Les images finales opposent l'aube (renouveau) à la nuit qui se referme (enfermement). La comparaison des fins éclaire le sens global.$mq$, $mq$hard$mq$),
($mq$Une élève traite le poème A en entier puis le poème B en entier, sans jamais les relier. Quel est le principal défaut ?$mq$, $mq$["Ce n'est pas une comparaison : elle juxtapose deux analyses au lieu de les confronter point par point","Elle a trop cité","Elle a utilisé des connecteurs","Elle a choisi un thème"]$mq$, 0, $mq$Comparer demande des liens constants (« de même », « en revanche »). Une simple juxtaposition ne répond pas à la consigne.$mq$, $mq$hard$mq$),
($mq$Poème A : « Le temps passe, dit l'horloge. » Poème B : « Le temps nous porte, dit la rivière. » Quelle analyse met le mieux en valeur la comparaison ?$mq$, $mq$["Les deux sont des litotes","Il n'y a aucune figure","Seul A est figuré","Les deux personnifient le temps par un élément, mais l'horloge évoque une mesure froide et inévitable, tandis que la rivière suggère un mouvement naturel qui emporte"]$mq$, 3, $mq$Même procédé (personnification), mais deux images aux connotations différentes (mécanique contre naturel) : c'est la nuance qui montre une compréhension fine.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Comparing Poems$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Comparer deux poèmes$mq$, $mq$Confronter deux textes selon des critères précis (thème, voix, ton, images, forme) en relevant ressemblances et différences.$mq$),
($mq$Points de comparaison$mq$, $mq$Thème, voix, ton, lexique et images, forme, rythme, structure et fin du poème.$mq$),
($mq$Connecteurs de ressemblance$mq$, $mq$De même, également, tout comme, dans les deux cas, pareillement.$mq$),
($mq$Connecteurs de différence$mq$, $mq$Alors que, tandis que, en revanche, au contraire, à l'inverse, cependant.$mq$),
($mq$Organisation par points$mq$, $mq$Un paragraphe par critère (thème, images, forme), avec les deux poèmes et un exemple de chacun dans chaque paragraphe.$mq$),
($mq$Erreur : juxtaposition$mq$, $mq$Traiter le poème A puis le poème B sans les relier. Ce n'est pas une comparaison.$mq$),
($mq$Comparer les fins$mq$, $mq$Observer la chute ou la dernière image : consolation, ouverture, clôture, retournement. Elle éclaire le sens global.$mq$),
($mq$Nuance de lexique$mq$, $mq$Deux synonymes ou verbes proches ont des connotations différentes (peser / bercer) : elles changent l'atmosphère.$mq$),
($mq$Conclusion d'une comparaison$mq$, $mq$Synthétiser ce que la comparaison révèle sur le traitement du thème par chaque poète, sans répéter l'introduction.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Comparing Poems$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Pourquoi comparer ?
Comparer deux poèmes, c'est mieux comprendre chacun d'eux. En voyant comment deux auteurs traitent un même thème de façon différente, ou un thème différent de façon semblable, on repère des choix d'écriture que l'on n'aurait peut-être pas remarqués en lisant un poème seul. C'est une tâche fréquente en Langue et Littérature, souvent sous la forme : « Comparez la manière dont ces deux poèmes évoquent le temps. »

## Les points de comparaison
Avant d'écrire, notez pour chaque poème :
- le **thème** (de quoi parle-t-il ? quelle idée générale ?) ;
- la **voix** (qui parle ? à qui ? « je », « tu », la nature ?) ;
- le **ton** et l'**atmosphère** (mélancolique, joyeux, révolté, apaisé) ;
- les **images** et le **lexique** (champs lexicaux, métaphores, connotations) ;
- la **forme** (strophes, rimes, vers réguliers ou libres) ;
- le **rythme** et les **sons** ;
- la **structure** et la **fin** (progression, retournement, chute).

## Ressemblances et différences
Partez d'un point commun, puis faites ressortir les nuances. Deux poèmes inventés sur l'enfance peuvent partager le motif du jardin : « L'enfance est un jardin perdu » exprime la perte irrémédiable, alors que « L'enfance est un jardin que je porte » en fait une présence intérieure. Même motif, deux visions. De même, « Le silence pèse sur la ville endormie » et « Le silence, doux, berce la ville » rendent le silence oppressant dans un cas, apaisant dans l'autre, grâce au choix des verbes *peser* et *bercer*.

## Les connecteurs de comparaison
- **Ressemblance** : de même, également, tout comme, les deux poèmes, dans les deux cas, pareillement.
- **Différence** : alors que, tandis que, en revanche, au contraire, à l'inverse, cependant.
- **Nuance** : néanmoins, toutefois, plus subtilement.
Une bonne phrase relie les deux textes : « Alors que le poème A évoque la solitude avec des images de froid, le poème B la présente comme un refuge, grâce à un lexique de chaleur. »

## Organiser la réponse
Plutôt que de traiter un poème puis l'autre, structurez par **points de comparaison**.
- **Introduction** : présentez les deux poèmes et le thème commun, annoncez deux ou trois axes.
- **Paragraphe 1** : thème et point de vue (A et B).
- **Paragraphe 2** : images et lexique (A et B).
- **Paragraphe 3** : forme et rythme (A et B).
- **Conclusion** : synthétisez ce que la comparaison révèle, sans répéter l'introduction.
Dans chaque paragraphe, mentionnez les deux poèmes, citez un exemple de chacun, expliquez l'effet, puis comparez.

## Comparer les fins et la forme
La chute d'un poème est souvent un moment clé. Deux poèmes sur le deuil peuvent se terminer l'un sur « le jour se lève » (consolation), l'autre sur « la nuit referme ses mains » (enfermement). De même, un poème en alexandrins réguliers exprime la maîtrise ou la solennité, un autre en vers libre la spontanéité ou le trouble.

## Erreurs fréquentes
- Juxtaposer deux analyses sans jamais les relier.
- Dire seulement « les deux poèmes parlent de la nature » sans nuance.
- Oublier de citer l'un des deux poèmes.
- Donner une préférence personnelle au lieu d'analyser.
- Ne comparer que le sens en ignorant la forme, ou l'inverse.

## Comment cela est évalué
Les tâches de comparaison évaluent la compréhension (critère A), l'organisation claire de la réponse (critère B) et la maîtrise de la langue (critère D). Les meilleures réponses combinent des points communs clairs, des différences nuancées et une conclusion qui synthétise.

Exam tip: dans chaque paragraphe, écrivez au moins une phrase qui contient les deux poèmes et un connecteur comme « alors que » ou « de même » ; vous serez sûr de comparer et non de juxtaposer.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;