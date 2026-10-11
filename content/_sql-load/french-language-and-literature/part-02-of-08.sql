-- Part 2 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Language Devices > Figurative Language
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Language Devices$mq$, 5, 2 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Figurative Language$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Language Devices$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Figurative Language$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Quelle figure compare deux éléments à l'aide d'un outil de comparaison (comme, tel, semblable à) ?$mq$, $mq$["La comparaison","La métaphore","L'hyperbole","L'antithèse"]$mq$, 0, $mq$La comparaison relie un comparé et un comparant par un mot outil : « Il est fort comme un lion ».$mq$, $mq$easy$mq$),
($mq$Quelle figure identifie directement deux éléments sans outil de comparaison ?$mq$, $mq$["La comparaison","La litote","L'accumulation","La métaphore"]$mq$, 3, $mq$La métaphore est une comparaison sans outil : « Cet homme est un lion ».$mq$, $mq$easy$mq$),
($mq$Quelle figure consiste à exagérer pour impressionner ?$mq$, $mq$["L'euphémisme","La litote","L'hyperbole","La répétition"]$mq$, 2, $mq$L'hyperbole amplifie : « Je meurs de faim » signifie simplement « j'ai très faim ».$mq$, $mq$easy$mq$),
($mq$Quelle figure donne des qualités humaines à un animal, un objet ou une idée ?$mq$, $mq$["L'antithèse","La personnification","La gradation","L'oxymore"]$mq$, 1, $mq$La personnification rend humain ce qui ne l'est pas : « La mer murmure ».$mq$, $mq$easy$mq$),
($mq$Qu'est-ce qu'une antithèse ?$mq$, $mq$["Un rapprochement de deux idées opposées","Une répétition de mots","Une phrase sans verbe","Une question sans réponse"]$mq$, 0, $mq$L'antithèse oppose deux termes ou idées : « Le jour et la nuit », « petit et immense ».$mq$, $mq$easy$mq$),
($mq$Extrait inventé : « Le vent mordait les joues des passants. » Quelle figure repère-t-on ?$mq$, $mq$["Comparaison","Oxymore","Litote","Personnification"]$mq$, 3, $mq$Mordre est une action d'être vivant, attribuée au vent : c'est une personnification qui souligne le froid.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Ses yeux étaient deux lacs d'automne. » Quelle figure est employée ?$mq$, $mq$["Une comparaison","Une hyperbole","Une métaphore","Une gradation"]$mq$, 2, $mq$Il n'y a pas d'outil de comparaison : les yeux sont directement identifiés à deux lacs, d'où la métaphore.$mq$, $mq$medium$mq$),
($mq$Citation de Corneille (Le Cid) : « Cette obscure clarté qui tombe des étoiles. » Quelle figure marque « obscure clarté » ?$mq$, $mq$["Une anaphore","Un oxymore","Une comparaison","Une énumération"]$mq$, 1, $mq$L'oxymore associe deux termes contradictoires dans une même expression : « obscure » et « clarté ».$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Ce n'est pas une mauvaise idée » pour dire « c'est une très bonne idée ». Quelle figure est utilisée ?$mq$, $mq$["Une litote","Une hyperbole","Une métonymie","Une personnification"]$mq$, 0, $mq$La litote dit moins pour faire comprendre plus : on atténue l'expression pour renforcer l'idée.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Ce soir, on va boire un verre ensemble. » Quelle figure désigne la boisson par son récipient ?$mq$, $mq$["Une litote","Une anaphore","Un oxymore","Une métonymie (le contenant pour le contenu)"]$mq$, 3, $mq$La métonymie désigne une chose par une autre qui lui est liée : le verre pour la boisson qu'il contient.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Il entra, regarda, s'avança, s'assit, se tut. » Quelle figure domine ?$mq$, $mq$["Une gradation","Une antithèse","Une accumulation de verbes d'action qui donne du rythme","Une comparaison"]$mq$, 2, $mq$La suite de verbes d'action courts forme une accumulation qui accélère le récit.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Un murmure, une rumeur, un vacarme. » Quelle figure organise cette phrase ?$mq$, $mq$["La litote","La gradation (progression croissante)","L'euphémisme","La métaphore filée"]$mq$, 1, $mq$Les trois noms augmentent en intensité : c'est une gradation ascendante.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Il est parti pour un long voyage » pour dire qu'un homme est mort. Quelle figure est employée ?$mq$, $mq$["Un euphémisme","Une hyperbole","Une anaphore","Une antithèse"]$mq$, 0, $mq$L'euphémisme adoucit une réalité pénible en la nommant par une formule plus douce.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « La ville était une ruche : les rues bourdonnaient, les passants butinaient les vitrines, les voitures cherchaient leur alvéole. » Quelle figure organise le passage ?$mq$, $mq$["Une simple litote","Une comparaison unique","Une question rhétorique","Une métaphore filée"]$mq$, 3, $mq$La métaphore initiale (la ville est une ruche) est développée par plusieurs images du même champ lexical : c'est une métaphore filée.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Je t'ai attendu cent ans. » Pourquoi ne peut-on pas interpréter cela à la lettre ?$mq$, $mq$["Parce que c'est une litote","Parce que c'est un oxymore","Parce que c'est une hyperbole qui exprime la longueur d'une attente ressentie","Parce que le verbe est au futur"]$mq$, 2, $mq$« Cent ans » est impossible : l'exagération traduit l'impatience ou l'ennui, et non une durée réelle.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Le silence criait dans la pièce. » Quelle analyse est la plus précise ?$mq$, $mq$["Une simple comparaison","Une personnification associée à un oxymore, qui rend le silence presque insupportable","Une énumération","Une litote qui atténue le silence"]$mq$, 1, $mq$« Crier » attribue une action humaine au silence (personnification) et s'oppose à son sens (oxymore) : le malaise est à son comble.$mq$, $mq$hard$mq$),
($mq$Une élève écrit : « La métaphore « son cœur est de glace » montre que le personnage est froid. » Quel est le manque principal ?$mq$, $mq$["Elle n'explique pas l'effet : insensibilité, dureté, absence d'émotion, et ce que cela révèle du personnage","Elle cite le texte","Elle utilise le présent","Elle emploie un guillemet"]$mq$, 0, $mq$Nommer la figure ne suffit pas : il faut expliquer ce qu'elle évoque (insensibilité, dureté) et son effet sur la lecture.$mq$, $mq$hard$mq$),
($mq$Quelle phrase contient à la fois une comparaison et une hyperbole ?$mq$, $mq$["Elle courait vite.","Elle était fatiguée.","Elle courait, il pleuvait.","Elle courait comme l'éclair, et chaque foulée faisait trembler la terre entière."]$mq$, 3, $mq$« Comme l'éclair » est une comparaison ; « faisait trembler la terre entière » est une exagération (hyperbole).$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Figurative Language$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Comparaison$mq$, $mq$Rapprochement de deux éléments avec un outil (comme, tel, pareil à). Exemple : « fort comme un lion ».$mq$),
($mq$Métaphore$mq$, $mq$Identification de deux éléments sans outil de comparaison. Exemple : « Cet homme est un lion ». Développée, elle devient métaphore filée.$mq$),
($mq$Personnification$mq$, $mq$Attribuer des traits ou actions humains à un animal, un objet ou une idée : « Le vent mordait les joues ».$mq$),
($mq$Hyperbole$mq$, $mq$Exagération pour marquer une émotion ou impressionner : « Je meurs de faim ».$mq$),
($mq$Litote$mq$, $mq$Dire moins pour suggérer plus, par exemple « Ce n'est pas mauvais » pour « c'est très bon ».$mq$),
($mq$Euphémisme$mq$, $mq$Adoucir une réalité pénible : « Il nous a quittés » pour dire qu'il est mort.$mq$),
($mq$Antithèse$mq$, $mq$Opposition de deux termes ou idées dans une même phrase : « le jour et la nuit ».$mq$),
($mq$Oxymore$mq$, $mq$Association de deux mots contradictoires dans une même expression : « une obscure clarté ».$mq$),
($mq$Analyser une figure : 4 étapes$mq$, $mq$Repérer, citer, interpréter (ce que l'image évoque), relier à l'effet sur le ton ou le thème.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Figurative Language$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Que sont les figures de style ?
Les figures de style sont des procédés d'écriture qui s'écartent du langage ordinaire pour produire un effet : rendre une image plus vive, souligner une idée, créer une émotion. Elles sont au cœur de l'analyse littéraire. Analyser ne consiste jamais à les nommer seulement : il faut les relever, les citer, puis expliquer leur effet sur le lecteur et leur rapport avec le sens du texte.

## Les figures d'analogie
- **La comparaison** rapproche deux éléments avec un outil (comme, tel, pareil à, semblable à). Exemple : « Il courait comme un lièvre ». Elle comporte un comparé (il), un comparant (un lièvre) et un point commun (la vitesse).
- **La métaphore** identifie deux éléments sans outil. Exemple : « Ses yeux étaient deux lacs d'automne ». Quand l'image se développe sur plusieurs phrases, on parle de **métaphore filée**.
- **La personnification** attribue des traits humains à un animal, un objet ou une idée : « Le vent mordait les joues des passants ».
- **La métonymie** désigne une chose par un élément qui lui est lié : « boire un verre ».

## Les figures d'insistance et d'atténuation
- **L'hyperbole** exagère : « Je t'ai attendu cent ans ». Elle exprime une émotion forte.
- **La litote** dit peu pour suggérer beaucoup : « Ce n'est pas mal du tout » pour « c'est très bien ».
- **L'euphémisme** adoucit une réalité pénible : « Il nous a quittés ».
- **La gradation** présente des termes en progression croissante ou décroissante : « Un murmure, une rumeur, un vacarme ».
- **L'accumulation** (ou énumération) enchaîne des éléments pour créer une impression de foisonnement ou de rapidité.

## Les figures d'opposition
- **L'antithèse** oppose deux idées dans un même contexte : « Le jour et la nuit ».
- **L'oxymore** unit deux termes contradictoires dans une même expression : « une obscure clarté », « un silence assourdissant ».

## Comment analyser une figure
Utilisez la démarche suivante :
- **Repérer** : identifier le passage et nommer la figure.
- **Citer** : donner les mots exacts entre guillemets.
- **Interpréter** : dire ce que l'image évoque (froid, force, solitude, douleur...).
- **Relier** : montrer l'effet sur le ton, l'atmosphère, la vision d'un personnage ou le thème.
Exemple : « La métaphore « son cœur est de glace » suggère l'insensibilité du personnage : la glace est dure et froide, ce qui laisse penser que ses sentiments sont fermés aux autres. »

## Pourquoi un auteur choisit une figure
Une image frappe l'imagination : elle condense une idée en peu de mots et fait ressentir plutôt qu'expliquer. L'hyperbole traduit l'émotion, la litote la pudeur, l'euphémisme la délicatesse, l'oxymore le trouble, la personnification la présence vivante d'un décor.

## Erreurs fréquentes
- Nommer la figure sans expliquer l'effet.
- Confondre comparaison (outil présent) et métaphore (outil absent).
- Citer une expression littérale comme si elle était une image : « il a mangé une pomme » n'est pas figuré.
- Chercher une figure dans chaque phrase : choisissez les passages les plus parlants.
- Oublier de relier l'image au thème ou au ton de l'ensemble.

## Comment cela est évalué
À l'examen, on propose un court extrait et la consigne : « Analysez deux procédés d'écriture et leur effet. » Les critères A et B récompensent la précision du vocabulaire, la qualité des citations et la clarté de l'explication.

Exam tip: ne vous contentez jamais d'écrire « c'est une métaphore » ; ajoutez toujours « qui suggère... » ou « ce qui crée... » pour montrer l'effet de l'image.$mq$ from st;

-- Language Devices > Sound and Rhythm
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Language Devices$mq$, 5, 2 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Sound and Rhythm$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Language Devices$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Sound and Rhythm$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Qu'est-ce qu'une allitération ?$mq$, $mq$["La répétition d'un son consonne","La répétition d'un son voyelle","Une comparaison","Une inversion de mots"]$mq$, 0, $mq$L'allitération répète un son consonne proche : « Pour qui sont ces serpents qui sifflent sur vos têtes ? » (le son [s]).$mq$, $mq$easy$mq$),
($mq$Qu'est-ce qu'une assonance ?$mq$, $mq$["La répétition d'une consonne","La répétition d'un mot entier","Un mot inventé","La répétition d'un son voyelle"]$mq$, 3, $mq$L'assonance répète un son voyelle, par exemple le son [ou] dans « Le loup dans la cour roule vers nous ».$mq$, $mq$easy$mq$),
($mq$Qu'est-ce que l'onomatopée ?$mq$, $mq$["Un mot très long","Un mot de la même famille","Un mot qui imite un bruit","Un mot étranger"]$mq$, 2, $mq$Les onomatopées reproduisent un son : « boum », « miaou », « glou-glou ».$mq$, $mq$easy$mq$),
($mq$Que désigne le rythme d'une phrase ?$mq$, $mq$["Le sens de chaque mot","La succession et la longueur des groupes de mots","L'orthographe","La couleur de l'encre"]$mq$, 1, $mq$Le rythme vient de la longueur des phrases, des pauses et des accents : il peut être rapide, lent, saccadé ou régulier.$mq$, $mq$easy$mq$),
($mq$Quel effet produisent généralement des phrases très courtes ?$mq$, $mq$["Un rythme rapide ou tendu","Un rythme lent et rêveur uniquement","Un effet comique obligatoire","Aucun effet"]$mq$, 0, $mq$Les phrases brèves accélèrent le texte et peuvent exprimer l'urgence, la peur ou la tension.$mq$, $mq$easy$mq$),
($mq$Extrait inventé : « Le serpent siffle, glisse, s'efface. » Quel son est répété ?$mq$, $mq$["Le son [p]","Le son [m]","Le son [r]","Le son [s] (allitération)"]$mq$, 3, $mq$Les sons [s] de « serpent », « siffle », « glisse » et « s'efface » créent un effet de sifflement qui imite le reptile.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Le gong grave grondait. » Quel effet cherche la répétition du son [g] ?$mq$, $mq$["Créer une douceur de berceuse","Imiter un chant d'oiseau","Évoquer un bruit grave, sourd et menaçant","Exprimer la légèreté"]$mq$, 2, $mq$La consonne occlusive [g], répétée avec le [r], est dure et rauque : elle suggère un grondement.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Mon cœur pleure, lourd et peureux, sous la pluie de l'heure. » Quel son voyelle revient dans « cœur », « pleure », « peureux », « heure » ?$mq$, $mq$["Le son [a]","Le son [œ] / [ø], proche et doux","Le son [i]","Le son [on]"]$mq$, 1, $mq$Les sons voisins [œ] et [ø] sont répétés : c'est une assonance qui crée un effet de plainte monotone, comme la pluie.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Courir. Tomber. Se relever. Courir encore. » Quel rythme et quel effet ?$mq$, $mq$["Un rythme saccadé qui traduit l'effort et l'urgence","Un rythme calme de berceuse","Un rythme interminable de longues phrases","Aucun rythme particulier"]$mq$, 0, $mq$Les phrases nominales ou infinitives très courtes suggèrent l'effort répété et le souffle coupé.$mq$, $mq$medium$mq$),
($mq$Quel procédé produit un rythme lent et rêveur ?$mq$, $mq$["Des impératifs et des exclamations","Des phrases de deux mots","Des onomatopées bruyantes","Des phrases longues, des subordonnées et des sons doux"]$mq$, 3, $mq$Les phrases amples et les sons fluides ([l], [m], voyelles ouvertes) ralentissent la lecture et créent une atmosphère apaisée.$mq$, $mq$medium$mq$),
($mq$Dans un poème, qu'est-ce qu'une rime ?$mq$, $mq$["Une comparaison entre deux vers","Une répétition de mot au début d'un vers","Le retour d'un même son à la fin de deux vers","Une phrase sans verbe"]$mq$, 2, $mq$Les rimes répètent les derniers sons de vers différents : « soleil / sommeil ».$mq$, $mq$medium$mq$),
($mq$Quelle phrase contient une anaphore ?$mq$, $mq$["« Il court vite. »","« Je marche, je pense, je reste sans voix. »","« Elle chante et danse. »","« Plus tard, nous partirons. »"]$mq$, 1, $mq$L'anaphore répète le même mot (« je ») au début de plusieurs segments successifs, ce qui crée un effet d'insistance et de rythme.$mq$, $mq$medium$mq$),
($mq$Un vers de douze syllabes s'appelle :$mq$, $mq$["Un alexandrin","Un octosyllabe","Un décasyllabe","Un hexasyllabe"]$mq$, 0, $mq$L'alexandrin compte douze syllabes, avec souvent une coupe (pause) au milieu, la césure.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Tic-tac, tic-tac, l'horloge égrène l'heure, et chaque heure se traîne. » Quelle analyse est la plus complète ?$mq$, $mq$["Il n'y a aucun effet sonore","Le texte est une liste d'ingrédients","Il s'agit d'une métaphore filée seulement","L'onomatopée et la répétition imitent le tic-tac, tandis que le verbe « se traîne » ralentit le rythme et exprime l'ennui"]$mq$, 3, $mq$Les sons imitent la régularité de l'horloge et le choix du verbe traduit la lenteur ressentie : le son et le sens se renforcent.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « La nuit tombe, lente, lourde, silencieuse. » Quel rapport existe entre l'allitération en [l] et le sens ?$mq$, $mq$["Les sons [l] évoquent un choc violent","Les sons [l] n'ont jamais de valeur expressive","Les sons liquides [l] créent une douceur fluide qui accompagne la lenteur de la nuit","Les sons [l] imitent un cri"]$mq$, 2, $mq$La consonne liquide [l] glisse : sa fluidité sonore soutient l'idée de lenteur et d'apaisement.$mq$, $mq$hard$mq$),
($mq$Pourquoi faut-il être prudent quand on interprète la valeur d'un son ?$mq$, $mq$["Parce que les sons n'ont jamais d'effet","Parce que l'effet dépend du contexte : un même son peut évoquer la douceur ou la violence selon le sens des mots","Parce que seul le sens compte","Parce que les allitérations sont interdites en prose"]$mq$, 1, $mq$Un son ne signifie rien seul : l'effet sonore se justifie par son accord avec le sens du passage et ne doit jamais être affirmé sans lien avec lui.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Je n'ai pas peur. Je n'ai pas peur. Je n'ai pas… peur. » Quel est l'effet de la dernière phrase brisée ?$mq$, $mq$["Elle trahit une peur qui s'avoue malgré les mots répétés","Elle prouve un courage total","Elle ralentit à cause d'une description","Elle est une erreur de ponctuation"]$mq$, 0, $mq$La répétition tente de rassurer, mais les points de suspension coupent le rythme : la voix flanche, révélant l'angoisse.$mq$, $mq$hard$mq$),
($mq$Quelle réponse analyse correctement le rythme du passage : « Elle ouvrit la porte. Rien. Elle avança. Un craquement. Elle se figea. » ?$mq$, $mq$["Les phrases longues décrivent un paysage","Le rythme est régulier et sans effet","Le passage est un dialogue joyeux","Les phrases très brèves et les mots isolés (« Rien », « Un craquement ») créent un suspense par un rythme haché qui imite le souffle retenu"]$mq$, 3, $mq$La brièveté et les fragments donnent une impression de tension : on avance pas à pas, avec le personnage, en retenant son souffle.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Sound and Rhythm$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Allitération$mq$, $mq$Répétition d'un son consonne dans une suite de mots. Exemple : « Le serpent siffle, glisse, s'efface » ([s]).$mq$),
($mq$Assonance$mq$, $mq$Répétition d'un son voyelle dans une suite de mots, qui crée une musicalité.$mq$),
($mq$Onomatopée$mq$, $mq$Mot qui imite un bruit : boum, tic-tac, miaou, crac.$mq$),
($mq$Rime$mq$, $mq$Retour du même son à la fin de deux vers ou plus, comme « soleil / sommeil ».$mq$),
($mq$Anaphore$mq$, $mq$Répétition d'un même mot ou groupe de mots au début de plusieurs phrases ou vers, pour insister.$mq$),
($mq$Alexandrin$mq$, $mq$Vers de douze syllabes, avec souvent une coupe au milieu appelée césure.$mq$),
($mq$Effet des phrases courtes$mq$, $mq$Rythme rapide, saccadé, qui crée de la tension, de l'urgence ou du suspense.$mq$),
($mq$Sons doux et sons durs$mq$, $mq$Les sons [l], [m], [n] suggèrent douceur ou lenteur ; les sons [k], [t], [g] suggèrent dureté ou choc, selon le contexte.$mq$),
($mq$Analyser un effet sonore$mq$, $mq$Repérer le procédé, citer les mots, relier le son au sens, conclure sur l'effet produit chez le lecteur.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Sound and Rhythm$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Écouter un texte
Un texte est fait pour être lu à voix haute, même en silence. Les sons et le rythme participent au sens : ils créent une atmosphère, imitent un bruit, accélèrent ou ralentissent l'action. En poésie comme en prose, analyser l'effet sonore est un signe de lecture fine. Mais attention : un son n'a pas de valeur en soi, il doit s'accorder avec le sens du passage.

## Les effets de sons
- **L'allitération** est la répétition d'un son consonne. Exemple inventé : « Le serpent siffle, glisse, s'efface » (le son [s] imite le sifflement).
- **L'assonance** est la répétition d'un son voyelle. Exemple : « Mon cœur pleure de douleur » avec la reprise du son [œ].
- **L'onomatopée** est un mot qui imite un bruit : « boum », « tic-tac », « crac ».
- **La rime** est le retour du même son à la fin de deux vers. Elle structure le poème et crée une musique.
- **Les sons doux** (consonnes douces [l], [m], [n], voyelles ouvertes) suggèrent la douceur, la lenteur, le rêve. **Les sons durs** (consonnes [k], [t], [g], [r] marqué) suggèrent la rudesse, le choc ou la menace.

## Le rythme
Le rythme dépend de la longueur des phrases, de la ponctuation, des pauses et de la répétition.
- **Phrases courtes** : rythme rapide, saccadé, tension. Exemple : « Courir. Tomber. Se relever. »
- **Phrases longues** : rythme ample, lent, rêveur ou descriptif.
- **Anaphore** : répétition d'un mot au début de segments successifs, qui crée un effet d'insistance.
- **Gradation** et **accumulation** : accélération ou foisonnement.
- **Ponctuation expressive** : points de suspension (hésitation), points d'exclamation (émotion), virgules en série (enchaînement rapide).
En poésie, on compte aussi les **syllabes** : l'alexandrin compte douze syllabes avec une césure au milieu, l'octosyllabe huit, le décasyllabe dix. La régularité donne de la solennité ; un vers brisé marque une émotion forte.

## Comment analyser un effet sonore ou rythmique
- **Repérer** le procédé (répétition de [s], phrases brèves).
- **Citer** les mots où il apparaît.
- **Associer** le son ou le rythme au sens (le sifflement du serpent, le souffle retenu).
- **Conclure** sur l'effet : tension, calme, menace, mélancolie.
Exemple : « Dans « Elle ouvrit la porte. Rien. Elle avança. Un craquement. », les phrases très brèves et les fragments créent un suspense : le rythme haché imite le souffle retenu du personnage. »

## Erreurs fréquentes
- Nommer l'allitération sans citer les mots concernés.
- Affirmer qu'un son est « toujours doux » ou « toujours violent » sans regarder le sens.
- Confondre allitération (consonne) et assonance (voyelle).
- Confondre sons et lettres : on parle de sons, pas d'orthographe.
- Oublier de lier le rythme au sens ou à l'émotion.

## Comment cela est évalué
Dans les tâches d'analyse, les critères A et B récompensent la capacité à relier une forme (son, rythme, ponctuation) à un sens. Cherchez des phrases courtes, des répétitions et des sons répétés, puis expliquez ce qu'ils font ressentir.

Exam tip: lisez le passage à voix basse avant de répondre ; vous entendrez les répétitions de sons et les ruptures de rythme, puis vous pourrez dire précisément ce qu'elles suggèrent.$mq$ from st;

-- Language Devices > Register and Word Choice
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Language Devices$mq$, 5, 2 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Register and Word Choice$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Language Devices$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Register and Word Choice$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Que désigne le « registre de langue » ?$mq$, $mq$["Le niveau de langue : familier, courant ou soutenu","Le nombre de mots dans un texte","Le genre littéraire d'un roman","La langue maternelle de l'auteur"]$mq$, 0, $mq$Le registre de langue (ou niveau de langue) est la manière de parler selon la situation : familier, courant, soutenu.$mq$, $mq$easy$mq$),
($mq$Lequel de ces mots appartient au registre familier ?$mq$, $mq$["Voiture","Automobile","Véhicule","Bagnole"]$mq$, 3, $mq$« Bagnole » est familier ; « voiture » est courant ; « automobile » et « véhicule » sont plus soutenus ou neutres.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce qu'un synonyme ?$mq$, $mq$["Un mot de sens opposé","Un mot qui rime","Un mot de sens proche","Un mot inventé"]$mq$, 2, $mq$Un synonyme a un sens voisin, mais rarement identique : « gai » et « joyeux ».$mq$, $mq$easy$mq$),
($mq$Qu'est-ce qu'un champ lexical ?$mq$, $mq$["Un champ cultivé","L'ensemble des mots d'un texte qui se rapportent à un même thème","Une liste de verbes irréguliers","La ponctuation d'une phrase"]$mq$, 1, $mq$Un champ lexical regroupe des mots liés à la même idée : mer, vague, sable, plage...$mq$, $mq$easy$mq$),
($mq$Quel mot est péjoratif (dépréciatif) pour désigner un employé de bureau ?$mq$, $mq$["Un gratte-papier","Un employé","Un secrétaire","Un fonctionnaire"]$mq$, 0, $mq$« Gratte-papier » exprime un jugement défavorable sur le métier ; les autres mots sont neutres.$mq$, $mq$easy$mq$),
($mq$Extrait inventé : « Le gosse a paumé son sac. » Quel est le registre de langue ?$mq$, $mq$["Soutenu","Littéraire","Scientifique","Familier"]$mq$, 3, $mq$« Gosse » et « paumer » sont des mots familiers, typiques de l'oral détendu.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Il convient de procéder à l'examen minutieux des faits. » Quel registre domine ?$mq$, $mq$["Familier","Argotique","Soutenu","Enfantin"]$mq$, 2, $mq$Le vocabulaire recherché (« convient », « procéder », « minutieux ») et la tournure formelle relèvent du registre soutenu.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « La demeure était vaste ; elle semblait dormir sous la neige. » Quel est l'effet du mot « demeure » plutôt que « maison » ?$mq$, $mq$["Un ton familier","Un ton plus noble, littéraire","Un ton technique","Un ton enfantin"]$mq$, 1, $mq$« Demeure » est plus recherché que « maison » : il donne de la solennité et un caractère poétique à la description.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Il marchait d'un pas lourd » / « Il traînait des pieds ». Quelle différence de connotation ?$mq$, $mq$["« Traînait des pieds » suggère la fatigue ou la mauvaise volonté, « pas lourd » suggère le poids ou l'effort","Aucune différence","« Pas lourd » est plus joyeux","Les deux sont sans sens"]$mq$, 0, $mq$Chaque verbe ajoute une nuance : le choix précis du mot construit l'image du personnage.$mq$, $mq$medium$mq$),
($mq$Qu'est-ce que la connotation d'un mot ?$mq$, $mq$["Sa définition exacte du dictionnaire","Son origine latine","Sa place dans le vers","Les idées ou émotions associées au mot, en plus de son sens littéral"]$mq$, 3, $mq$La dénotation est le sens de base ; la connotation est ce que le mot suggère : « foyer » évoque la chaleur, la famille.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « La vieille bâtisse dominait le quartier, sombre et silencieuse. » Quel champ lexical est présent ?$mq$, $mq$["Celui de la fête","Celui du sport","Celui de l'inquiétude ou de la solitude : vieille, sombre, silencieuse","Celui de la cuisine"]$mq$, 2, $mq$Les adjectifs « vieille », « sombre » et « silencieuse » forment un champ lexical qui crée une atmosphère austère.$mq$, $mq$medium$mq$),
($mq$Pourquoi l'auteur d'un roman fait-il parler un personnage au registre familier ?$mq$, $mq$["Pour allonger le texte","Pour le rendre vivant et crédible, et caractériser son milieu ou sa personnalité","Pour éviter les verbes","Pour cacher le sens"]$mq$, 1, $mq$Le registre familier dans un dialogue rend le personnage réaliste et révèle son milieu, son âge ou son humeur.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Notre terre, notre mère nourricière, souffre. » Quel est l'effet du mot « mère » ?$mq$, $mq$["Il personnifie la terre et crée un lien affectif","Il désigne la mère de l'auteur","Il introduit un calcul","Il n'a aucun effet"]$mq$, 0, $mq$« Mère nourricière » associe la terre à une figure protectrice : le lecteur ressent une responsabilité affective.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Le directeur a quitté ses fonctions. » / « Le directeur s'est fait virer. » Quelle phrase conviendrait le mieux à un communiqué officiel ?$mq$, $mq$["La seconde, car elle est plus vivante","Les deux sans différence","Aucune des deux","La première, car elle est neutre et formelle"]$mq$, 3, $mq$Un communiqué officiel exige un registre courant ou soutenu. « Virer » est familier et peu adapté.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Il ne mentit pas, il arrangea la vérité. » Que révèle le choix du verbe « arranger » ?$mq$, $mq$["Une description neutre sans nuance","Un registre scientifique","Un euphémisme qui adoucit le mensonge, peut-être avec ironie","Une hyperbole"]$mq$, 2, $mq$« Arranger la vérité » atténue le mot « mentir ». Selon le contexte, l'auteur peut excuser le personnage ou, au contraire, souligner son hypocrisie.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Le bureau était un mausolée de dossiers. » Quelle analyse du mot « mausolée » est la plus fine ?$mq$, $mq$["Il désigne un type de chaise","Il évoque la mort et le silence, suggérant un lieu figé et sans vie, ce qui critique le travail administratif","Il est un synonyme de « gai »","Il indique la date"]$mq$, 1, $mq$Le terme funéraire transforme le bureau en tombeau de papiers : la métaphore dépréciative renforce la critique.$mq$, $mq$hard$mq$),
($mq$Dans un dialogue, un personnage passe soudain du registre familier au registre soutenu devant un inconnu. Que peut montrer l'auteur ?$mq$, $mq$["Que le personnage adapte son langage à la situation, ou joue un rôle","Que l'auteur a fait une erreur","Que le texte change de langue","Que le personnage ne parle plus"]$mq$, 0, $mq$Le changement de registre peut révéler le respect, l'intimidation ou la volonté de paraître différent.$mq$, $mq$hard$mq$),
($mq$Quelle phrase combine un vocabulaire mélioratif et un registre soutenu ?$mq$, $mq$["Cette baraque était pas mal.","Ça cassait la baraque.","Le truc était super.","Cette cathédrale majestueuse s'élevait vers le ciel avec une noblesse incomparable."]$mq$, 3, $mq$« Majestueuse », « noblesse » et « incomparable » sont valorisants et recherchés : ils créent un ton admiratif et solennel.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Register and Word Choice$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Registre de langue$mq$, $mq$Niveau de langue adapté à la situation : familier, courant ou soutenu.$mq$),
($mq$Registre familier : exemples$mq$, $mq$Bagnole, gosse, bouquin, paumer. Il appartient à l'oral détendu ou aux dialogues réalistes.$mq$),
($mq$Registre soutenu : exemples$mq$, $mq$Demeure, s'enquérir, automobile. Il est recherché et formel, courant dans les discours officiels et la littérature.$mq$),
($mq$Dénotation$mq$, $mq$Sens précis et objectif d'un mot, tel qu'il figure dans le dictionnaire.$mq$),
($mq$Connotation$mq$, $mq$Idées ou émotions que le mot suggère en plus de son sens littéral. Exemple : « foyer » évoque la chaleur et la famille.$mq$),
($mq$Lexique mélioratif / péjoratif$mq$, $mq$Mélioratif : mots valorisants (majestueux). Péjoratif : mots dépréciatifs (minable).$mq$),
($mq$Champ lexical$mq$, $mq$Ensemble des mots d'un texte liés au même thème. Il révèle l'atmosphère ou le thème.$mq$),
($mq$Pourquoi changer de registre ?$mq$, $mq$Pour caractériser un personnage, créer un effet comique, marquer une rupture ou adapter le discours à l'interlocuteur.$mq$),
($mq$Analyser un mot : méthode$mq$, $mq$Relever le mot, donner son sens, expliquer sa connotation (en le comparant à un synonyme), relier à l'effet.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Register and Word Choice$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Choisir ses mots avec précision
Le choix des mots est un outil essentiel de l'auteur. Un même événement peut se raconter de dix façons : « Il est parti », « Il s'est enfui », « Il a quitté les lieux ». Chaque formulation transmet une nuance différente. En analyse littéraire, on cherche à expliquer pourquoi l'auteur a choisi tel mot et quel effet ce choix produit sur le lecteur.

## Les registres de langue
Le **registre de langue** (ou niveau de langue) dépend de la situation et du public.
- **Familier** : langage oral détendu, mots comme *bagnole*, *gosse*, *bouquin*, *paumer*. On l'emploie entre amis ou dans les dialogues réalistes.
- **Courant** : langage neutre, correct, compris de tous. C'est le niveau par défaut : *voiture*, *enfant*, *livre*.
- **Soutenu** : langage recherché, formel ou littéraire : *automobile*, *demeure*, *s'enquérir*. On le trouve dans les discours officiels et la littérature classique.
L'auteur peut changer de registre pour caractériser un personnage, créer un effet comique ou marquer une rupture. Un personnage qui passe soudain du familier au soutenu peut jouer un rôle ou adapter son langage à son interlocuteur.

## Dénotation et connotation
- La **dénotation** est le sens précis, objectif d'un mot (celui du dictionnaire).
- La **connotation** est l'ensemble des idées, images ou émotions associées au mot. Le mot *foyer* signifie « lieu d'habitation » (dénotation) mais évoque la chaleur, la famille, la sécurité (connotation).
Deux synonymes ont rarement la même connotation : *maison*, *demeure*, *baraque* ou *logis* ne produisent pas le même effet. Un lexique **mélioratif** valorise (*majestueux*, *noble*), un lexique **péjoratif** déprécie (*misérable*, *minable*).

## Les champs lexicaux
Un **champ lexical** est un ensemble de mots d'un texte qui se rapportent à un même thème : la peur (*trembler*, *sombre*, *frisson*), la mer (*vague*, *sable*, *écume*). Repérer un champ lexical permet de dégager l'atmosphère, le thème ou le point de vue. Dans « La vieille bâtisse dominait le quartier, sombre et silencieuse », les adjectifs forment un champ lexical de l'austérité et de la solitude.

## Comment analyser le choix d'un mot
- **Relever** un mot ou une expression précise.
- **Définir** son sens littéral.
- **Expliquer** sa connotation, en le comparant si possible à un autre mot possible.
- **Relier** cette nuance au ton, au personnage ou au thème.
Exemple : « Le bureau était un mausolée de dossiers. » Le mot *mausolée* évoque la mort, le silence et l'immobilité : le bureau paraît figé et sans vie, ce qui critique le travail administratif.

## Erreurs fréquentes
- Dire que le mot est « bien choisi » sans expliquer pourquoi.
- Confondre registre (niveau de langue) et ton (attitude).
- Ignorer la connotation et ne donner que la définition.
- Relever un champ lexical sans préciser quel thème il construit.
- Utiliser dans ses propres textes des mots familiers dans un contexte formel.

## Comment cela est évalué
À l'examen, une question typique est : « Comment le vocabulaire choisi par l'auteur crée-t-il une atmosphère ? » Le critère A récompense l'analyse des mots précis, le critère D récompense votre propre choix de registre adapté à la tâche. Votre vocabulaire d'analyse doit rester varié et précis.

Exam tip: choisissez un mot clé dans l'extrait, comparez-le à un synonyme plus neutre et expliquez ce que le mot choisi ajoute : cette méthode de comparaison montre la nuance et donne de la profondeur à votre analyse.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;