-- Part 7 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Grammar and Accuracy > Verb Tenses and Moods
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Grammar and Accuracy$mq$, 5, 7 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Verb Tenses and Moods$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Grammar and Accuracy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Verb Tenses and Moods$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Complète : « Hier, nous ____ au cinéma. » (aller, passé composé)$mq$, $mq$["sommes allés","avons allé","allons","irons"]$mq$, 0, $mq$Le verbe « aller » se conjugue avec l'auxiliaire être au passé composé, et le participe s'accorde avec le sujet : nous sommes allés.$mq$, $mq$easy$mq$),
($mq$Quelle est la forme correcte de « finir » à l'imparfait, avec « je » ?$mq$, $mq$["je finis","je finirai","je finisse","je finissais"]$mq$, 3, $mq$L'imparfait de « finir » se forme sur le radical « finiss- » : je finissais.$mq$, $mq$easy$mq$),
($mq$Quel mode sert à exprimer un ordre ou un conseil direct ?$mq$, $mq$["Le subjonctif","Le conditionnel","L'impératif","L'infinitif passé"]$mq$, 2, $mq$L'impératif s'emploie pour ordonner, conseiller, inviter : « Écoute ! »$mq$, $mq$easy$mq$),
($mq$Quel est le futur simple de « faire » avec « tu » ?$mq$, $mq$["tu fais","tu feras","tu faisais","tu ferais"]$mq$, 1, $mq$Le futur simple de « faire » est irrégulier : je ferai, tu feras. « Tu ferais » est le conditionnel.$mq$, $mq$easy$mq$),
($mq$Quel auxiliaire utilise-t-on avec « aller » au passé composé ?$mq$, $mq$["Être","Avoir","Aucun","Pouvoir"]$mq$, 0, $mq$« Aller » fait partie des verbes de mouvement conjugués avec être : elle est allée.$mq$, $mq$easy$mq$),
($mq$Complète : « Il faut que tu ____ à l'heure. » (venir)$mq$, $mq$["viens","viendras","venais","viennes"]$mq$, 3, $mq$« Il faut que » exige le subjonctif présent : que tu viennes.$mq$, $mq$medium$mq$),
($mq$Complète : « Si j'avais le temps, je ____ plus. » (lire)$mq$, $mq$["lirai","lis","lirais","lisais"]$mq$, 2, $mq$Après « si » + imparfait, on emploie le conditionnel présent : je lirais.$mq$, $mq$medium$mq$),
($mq$Complète : « Les lettres que j'ai ____ sont parties hier. » (écrire)$mq$, $mq$["écrit","écrites","écrire","écrits"]$mq$, 1, $mq$Avec avoir, le participe s'accorde avec le COD placé avant le verbe : « les lettres » (féminin pluriel), donc écrites.$mq$, $mq$medium$mq$),
($mq$Quel est le passé simple de « prendre » à la 3e personne du singulier ?$mq$, $mq$["il prit","il prend","il prenait","il prendra"]$mq$, 0, $mq$« Il prit la clé » : le passé simple exprime une action ponctuelle dans un récit.$mq$, $mq$medium$mq$),
($mq$Complète : « Il ____ quand je suis sorti. » (pleuvoir)$mq$, $mq$["pleuvra","pleut","plut","pleuvait"]$mq$, 3, $mq$L'imparfait décrit une situation en cours quand une autre action ponctuelle (passé composé) se produit.$mq$, $mq$medium$mq$),
($mq$Quelle valeur a le plus-que-parfait dans « Elle avait fini avant mon arrivée » ?$mq$, $mq$["Une action future","Un ordre","Une action antérieure à une autre action passée","Une hypothèse"]$mq$, 2, $mq$Le plus-que-parfait exprime l'antériorité par rapport à un moment du passé.$mq$, $mq$medium$mq$),
($mq$Complète : « Bien que tu ____ fatigué, viens avec nous. » (être)$mq$, $mq$["es","sois","seras","étais"]$mq$, 1, $mq$La conjonction « bien que » est suivie du subjonctif : que tu sois.$mq$, $mq$medium$mq$),
($mq$Quel est l'impératif présent de « aller » à la 2e personne du singulier ?$mq$, $mq$["Va","Allez","Vas","Aille"]$mq$, 0, $mq$L'impératif de « aller » est « va » (sans s), sauf devant « y » : vas-y.$mq$, $mq$medium$mq$),
($mq$Complète : « Si elle ____, elle serait venue. » (savoir)$mq$, $mq$["savait","saura","sait","avait su"]$mq$, 3, $mq$Hypothèse irréalisable dans le passé : si + plus-que-parfait, puis conditionnel passé. Elle avait su → elle serait venue.$mq$, $mq$hard$mq$),
($mq$Choisis la forme correcte : « Elles se sont ____ les mains. » (laver)$mq$, $mq$["lavées","lavés","lavé","laver"]$mq$, 2, $mq$Avec un verbe pronominal, le participe s'accorde avec le COD placé avant. Ici le COD « les mains » est placé après : lavé reste invariable.$mq$, $mq$hard$mq$),
($mq$Quelle phrase est correcte ?$mq$, $mq$["Je veux que tu viens demain.","Je veux que tu viennes demain.","Je veux que tu viendras demain.","Je veux que tu venais demain."]$mq$, 1, $mq$« Vouloir que » est suivi du subjonctif : que tu viennes.$mq$, $mq$hard$mq$),
($mq$Complète : « Pendant qu'elle ____ , le téléphone ____ . » (lire, sonner)$mq$, $mq$["lisait ... sonna","lut ... sonnait","lisait ... sonnera","lit ... sonna"]$mq$, 0, $mq$L'imparfait décrit l'action en cours (elle lisait), le passé simple l'événement soudain qui l'interrompt (le téléphone sonna).$mq$, $mq$hard$mq$),
($mq$Quelle phrase emploie correctement le mode après une expression de certitude ?$mq$, $mq$["Je suis sûr qu'il vienne.","Je suis sûr qu'il venait venir.","Je suis sûr qu'il viennent.","Je suis sûr qu'il viendra."]$mq$, 3, $mq$Après une expression de certitude, on utilise l'indicatif. Avec le doute (« Je doute qu'il vienne »), on utilise le subjonctif.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Verb Tenses and Moods$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Passé composé$mq$, $mq$Auxiliaire avoir ou être au présent + participe passé : action terminée (« nous sommes allés »).$mq$),
($mq$Imparfait / passé simple$mq$, $mq$Imparfait : décor, habitude, durée. Passé simple : action ponctuelle du récit écrit.$mq$),
($mq$Plus-que-parfait$mq$, $mq$Auxiliaire à l'imparfait + participe passé : action antérieure à une autre action passée (« elle avait fini »).$mq$),
($mq$Subjonctif présent$mq$, $mq$Après « il faut que », « vouloir que », « bien que », « pour que » : « Il faut que tu viennes ».$mq$),
($mq$Hypothèse irréelle du passé$mq$, $mq$Si + plus-que-parfait, conditionnel passé : « Si elle avait su, elle serait venue ».$mq$),
($mq$Si + imparfait$mq$, $mq$Conditionnel présent dans la principale : « Si j'avais le temps, je lirais ». Jamais de conditionnel après « si ».$mq$),
($mq$Participe passé avec être$mq$, $mq$S'accorde avec le sujet : « Elles sont parties ».$mq$),
($mq$Participe passé avec avoir$mq$, $mq$S'accorde avec le COD placé avant le verbe : « les lettres que j'ai écrites ».$mq$),
($mq$Impératif de aller$mq$, $mq$« Va » sans s à la 2e personne du singulier, mais « vas-y » devant le pronom y.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Verb Tenses and Moods$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## L'essentiel
Les verbes sont la colonne vertébrale de la phrase. Choisir le bon temps (quand ?) et le bon mode (avec quelle attitude ?) est indispensable pour que ton texte soit compris et jugé précis. À l'examen, une grande partie des erreurs de langue viennent des conjugaisons et des accords.

## Les principaux temps de l'indicatif
- **Présent** : action actuelle, vérité générale, parfois récit vivant.
- **Passé composé** : action terminée, très courante (avoir ou être + participe passé).
- **Imparfait** : décor, habitude, action qui dure (« Il pleuvait »).
- **Passé simple** : actions ponctuelles du récit écrit (« Il prit la clé »).
- **Plus-que-parfait** : antériorité dans le passé (« Elle avait fini avant mon arrivée »).
- **Futur simple** : action à venir (« tu feras »).
Dans un récit, associe l'imparfait pour l'arrière-plan et le passé simple ou le passé composé pour les actions : « Pendant qu'elle lisait, le téléphone sonna. »

## Les modes
- **Indicatif** : faits réels.
- **Subjonctif** : souhait, doute, obligation, sentiment. On le trouve après « il faut que », « vouloir que », « bien que », « pour que », « avant que ». Exemple : « Il faut que tu viennes. »
- **Conditionnel** : hypothèse, politesse, souhait. « Si j'avais le temps, je lirais plus. »
- **Impératif** : ordre ou conseil (« Va ! »). Attention : « va » ne prend pas de s, sauf devant « y » (« vas-y »).
Après une expression de certitude (« je suis sûr que »), on emploie l'indicatif ; après un doute (« je doute que »), le subjonctif.

## Les accords du participe passé
- Avec **être**, le participe s'accorde avec le sujet : « Elles sont parties. »
- Avec **avoir**, il s'accorde avec le COD placé avant : « Les lettres que j'ai écrites. » Si le COD est après, pas d'accord : « J'ai écrit des lettres. »
- Verbes pronominaux : accord avec le COD placé avant. « Elles se sont lavé les mains » (COD après : invariable), mais « Elles se sont lavées » (le pronom « se » est COD).

## La concordance des temps dans l'hypothèse
- Si + présent, futur : « S'il pleut, nous resterons. »
- Si + imparfait, conditionnel présent : « Si j'avais le temps, je lirais. »
- Si + plus-que-parfait, conditionnel passé : « Si elle avait su, elle serait venue. »
Ne mets jamais un conditionnel après « si » de condition.

## Erreurs fréquentes
- Écrire « je veux que tu viens » au lieu de « tu viennes ».
- Oublier l'accord du participe passé avec avoir.
- Confondre imparfait et passé simple dans un récit.
- Mélanger les temps sans raison dans un même paragraphe.

## Comment c'est évalué
À l'eAssessment, la précision de la langue est évaluée dans les productions écrites et parfois par des questions de grammaire en contexte (compléter une phrase, repérer l'erreur, choisir le bon temps). Les questions se situent dans des textes courts réalistes.

## Méthode de contrôle
Quand tu relis, repère tous les verbes, puis pose-toi trois questions : à quel temps suis-je ? Y a-t-il un mode imposé par une conjonction ? Le sujet est-il accordé avec le verbe et le participe ?

Exam tip: lors de la relecture, surligne mentalement chaque verbe conjugué et vérifie son sujet, son temps et son accord avant de passer à l'orthographe des autres mots.$mq$ from st;

-- Grammar and Accuracy > Sentence Structure and Punctuation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Grammar and Accuracy$mq$, 5, 7 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Sentence Structure and Punctuation$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Grammar and Accuracy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Sentence Structure and Punctuation$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Quelle conjonction est une conjonction de coordination ?$mq$, $mq$["Donc","Parce que","Lorsque","Bien que"]$mq$, 0, $mq$Les conjonctions de coordination sont : mais, ou, et, donc, or, ni, car. Les autres introduisent des subordonnées.$mq$, $mq$easy$mq$),
($mq$Quels éléments forment une phrase minimale ?$mq$, $mq$["Un adjectif seul","Un adverbe et un nom","Un titre","Un sujet et un verbe conjugué"]$mq$, 3, $mq$« Il dort. » est une phrase complète : sujet et verbe.$mq$, $mq$easy$mq$),
($mq$Quelle ponctuation termine une phrase interrogative ?$mq$, $mq$["Le point","Les deux-points","Le point d'interrogation","Le point-virgule"]$mq$, 2, $mq$Une phrase interrogative se termine par un point d'interrogation.$mq$, $mq$easy$mq$),
($mq$Dans quels cas met-on une majuscule ?$mq$, $mq$["À chaque nom commun","Au début d'une phrase et aux noms propres","À chaque verbe","À chaque adjectif"]$mq$, 1, $mq$On met une majuscule en début de phrase et aux noms propres : Paris, Marie, la Seine.$mq$, $mq$easy$mq$),
($mq$À quoi sert la virgule dans une énumération ?$mq$, $mq$["À séparer les éléments de même nature","À terminer la phrase","À remplacer le point d'interrogation","À introduire une citation"]$mq$, 0, $mq$« Elle achète des pommes, des poires et des raisins. » La virgule sépare les éléments sauf avant « et ».$mq$, $mq$easy$mq$),
($mq$Complète : « Le livre ____ j'ai lu hier est passionnant. »$mq$, $mq$["qui","où","dont","que"]$mq$, 3, $mq$« Que » est COD du verbe « ai lu » : j'ai lu le livre.$mq$, $mq$medium$mq$),
($mq$Complète : « C'est la ville ____ j'habite. »$mq$, $mq$["que","dont","où","quoi"]$mq$, 2, $mq$« Où » est un pronom relatif de lieu.$mq$, $mq$medium$mq$),
($mq$Complète : « Le film ____ je te parle est sorti cette semaine. »$mq$, $mq$["que","dont","qui","où"]$mq$, 1, $mq$On dit « parler de quelque chose » : le pronom relatif est « dont ».$mq$, $mq$medium$mq$),
($mq$Dans « Quand il pleut, nous restons à l'intérieur », quelle est la proposition subordonnée ?$mq$, $mq$["Quand il pleut","Nous restons à l'intérieur","Il pleut nous","Restons"]$mq$, 0, $mq$« Quand il pleut » dépend de la principale « nous restons à l'intérieur ».$mq$, $mq$medium$mq$),
($mq$Quelle phrase est correctement ponctuée ?$mq$, $mq$["Demain matin nous, partirons.","Demain, matin nous partirons.","Demain matin nous partirons,.","Demain matin, nous partirons."]$mq$, 3, $mq$Un complément circonstanciel placé en tête de phrase est souvent suivi d'une virgule.$mq$, $mq$medium$mq$),
($mq$Quel est l'usage principal des deux-points ?$mq$, $mq$["Terminer toutes les phrases","Remplacer la virgule dans une énumération","Introduire une énumération, une explication ou une citation","Marquer une question"]$mq$, 2, $mq$« Il faut trois ingrédients : farine, œufs, lait. »$mq$, $mq$medium$mq$),
($mq$Pourquoi « Parce que j'étais fatigué. » est-il une erreur lorsque la phrase est isolée ?$mq$, $mq$["Il manque une majuscule","C'est une subordonnée sans proposition principale : un fragment","Il y a trop de mots","Le verbe est au futur"]$mq$, 1, $mq$Une subordonnée seule ne forme pas une phrase complète. Il faut la rattacher à une principale.$mq$, $mq$medium$mq$),
($mq$Quel est le rôle du point-virgule ?$mq$, $mq$["Séparer deux propositions indépendantes proches par le sens","Terminer un texte","Introduire une citation","Marquer l'exclamation"]$mq$, 0, $mq$« Il fait nuit ; la ville s'endort. » Le point-virgule marque un lien plus fort qu'un point.$mq$, $mq$medium$mq$),
($mq$Quelle phrase est correctement construite ?$mq$, $mq$["Bien qu'il est tard, nous continuons à travailler.","Bien qu'il soit tard nous continuons, travailler à.","Bien tard qu'il soit, nous travailler.","Bien qu'il soit tard, nous continuons à travailler."]$mq$, 3, $mq$« Bien que » entraîne le subjonctif : qu'il soit. L'ordre des mots reste logique.$mq$, $mq$hard$mq$),
($mq$Quelle phrase évite l'ambiguïté du sujet ?$mq$, $mq$["En arrivant, la porte était fermée.","En arrivant, fermée la porte.","Quand nous sommes arrivés, la porte était fermée.","Arrivant, porte fermée."]$mq$, 2, $mq$Dans la première phrase, « en arrivant » semble se rapporter à « la porte ». La subordonnée avec « nous » est claire.$mq$, $mq$hard$mq$),
($mq$Quelle phrase utilise correctement les virgules pour une apposition ?$mq$, $mq$["Mon frère un passionné, de théâtre joue ce soir.","Mon frère, un passionné de théâtre, joue ce soir.","Mon frère, un passionné de théâtre joue, ce soir.","Mon, frère un passionné de théâtre joue ce soir."]$mq$, 1, $mq$L'apposition « un passionné de théâtre » est encadrée par deux virgules.$mq$, $mq$hard$mq$),
($mq$Comment fusionner « Il fait froid. Nous restons à la maison. » avec la bonne relation logique ?$mq$, $mq$["Comme il fait froid, nous restons à la maison.","Il fait froid parce que nous restons à la maison.","Nous restons à la maison bien qu'il fait froid.","Il fait froid ; mais restons nous."]$mq$, 0, $mq$« Comme » exprime la cause dans le bon sens. La deuxième version inverse la cause et la conséquence.$mq$, $mq$hard$mq$),
($mq$Quel effet produit une succession de phrases très courtes dans un récit ?$mq$, $mq$["Un ton lent et contemplatif","Un registre soutenu","Une description détaillée","Un rythme rapide qui crée de la tension"]$mq$, 3, $mq$« Il courut. Une porte. Fermée. » Les phrases courtes accélèrent le rythme et accentuent l'urgence.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Sentence Structure and Punctuation$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Conjonctions de coordination$mq$, $mq$Mais, ou, et, donc, or, ni, car : elles relient des mots ou des propositions de même nature.$mq$),
($mq$Proposition subordonnée$mq$, $mq$Proposition qui dépend d'une principale et commence souvent par une conjonction (quand, parce que, bien que).$mq$),
($mq$Fragment de phrase$mq$, $mq$Subordonnée isolée sans principale : « Parce que j'étais fatigué. » Il faut la rattacher à une principale.$mq$),
($mq$Pronom relatif « qui »$mq$, $mq$Sujet du verbe de la relative : « L'élève qui parle ».$mq$),
($mq$Pronom relatif « que »$mq$, $mq$COD du verbe de la relative : « Le livre que j'ai lu ».$mq$),
($mq$Pronom relatif « dont »$mq$, $mq$Remplace un complément introduit par « de » : « Le film dont je te parle ».$mq$),
($mq$Point-virgule$mq$, $mq$Relie deux propositions indépendantes proches par le sens : lien plus fort qu'un point.$mq$),
($mq$Deux-points$mq$, $mq$Introduisent une énumération, une explication ou une citation.$mq$),
($mq$Phrases courtes en série$mq$, $mq$Créent un rythme rapide et de la tension : « Il courut. Une porte. Fermée. »$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Sentence Structure and Punctuation$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## L'essentiel
Une phrase bien construite et bien ponctuée se lit sans effort et dit exactement ce que tu veux dire. À l'examen, la précision de la langue dépend beaucoup de la structure des phrases : sujet et verbe clairs, liens logiques explicites, ponctuation maîtrisée.

## Les types de phrase
- **Déclarative** : elle affirme (point).
- **Interrogative** : elle questionne (point d'interrogation).
- **Impérative** : elle ordonne ou conseille (point ou point d'exclamation).
- **Exclamative** : elle exprime une émotion (point d'exclamation).
Une phrase minimale contient un sujet et un verbe conjugué : « Il dort. »

## Phrase simple et phrase complexe
- **Phrase simple** : un seul verbe conjugué.
- **Phrase complexe** : plusieurs propositions, reliées par coordination, juxtaposition ou subordination.
Les conjonctions de coordination sont : mais, ou, et, donc, or, ni, car. Les conjonctions de subordination (parce que, quand, bien que, comme, si) introduisent une proposition subordonnée qui dépend d'une principale. « Quand il pleut, nous restons à l'intérieur » : « Quand il pleut » est la subordonnée.
Une subordonnée seule est un **fragment** : « Parce que j'étais fatigué. » Il faut une principale : « Je suis rentré tôt parce que j'étais fatigué. »

## Les pronoms relatifs
- **qui** : sujet (« L'élève qui parle »).
- **que** : COD (« Le livre que j'ai lu »).
- **où** : lieu ou temps (« La ville où j'habite »).
- **dont** : complément introduit par « de » (« Le film dont je te parle »).
Choisis-le d'après la fonction dans la proposition relative.

## La ponctuation
- **La virgule** sépare les éléments d'une énumération, isole un complément en tête de phrase (« Demain matin, nous partirons. »), encadre une apposition (« Mon frère, un passionné de théâtre, joue ce soir. »).
- **Le point-virgule** relie deux propositions proches par le sens.
- **Les deux-points** introduisent une énumération, une explication ou une citation.
- **Les guillemets** encadrent une citation ou un dialogue.
- **L'apostrophe** marque l'élision : l'homme, qu'il.
En français, on met une espace avant « ; : ! ? » et à l'intérieur des guillemets « comme ceci ».

## Clarté et style
- **Évite l'ambiguïté** : « En arrivant, la porte était fermée » semble dire que la porte arrive. Écris « Quand nous sommes arrivés, la porte était fermée ».
- **Varie la longueur** : une succession de phrases courtes crée de la tension (« Il courut. Une porte. Fermée. »), alors que de longues phrases peuvent exprimer la réflexion.
- **Utilise la bonne relation logique** : « Comme il fait froid, nous restons à la maison » exprime la cause dans le bon sens.

## Comment c'est évalué
Dans les productions écrites, les critères évaluent la précision de la langue : phrases complètes, ponctuation, variété des structures. Dans les questions, on te demande de repérer une phrase mal construite ou de choisir la meilleure reformulation.

## Erreurs fréquentes
- Écrire des fragments.
- Mettre une virgule entre le sujet et le verbe.
- Confondre « qui », « que », « dont ».
- Utiliser « bien que » avec l'indicatif.

Exam tip: pendant la relecture, lis ta phrase à voix basse : si tu as besoin de reprendre ton souffle au mauvais endroit, il manque probablement une virgule ou la phrase est trop longue.$mq$ from st;

-- Grammar and Accuracy > Spelling and Vocabulary
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Grammar and Accuracy$mq$, 5, 7 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Spelling and Vocabulary$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Grammar and Accuracy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Spelling and Vocabulary$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Complète : « Il ____ un livre dans son sac. » (a / à)$mq$, $mq$["a","à","as","ah"]$mq$, 0, $mq$« a » est le verbe avoir (on peut dire « avait »). « à » est une préposition.$mq$, $mq$easy$mq$),
($mq$Complète : « Elle va ____ Paris. » (a / à)$mq$, $mq$["a","as","ha","à"]$mq$, 3, $mq$« à » est une préposition de lieu : on ne peut pas le remplacer par « avait ».$mq$, $mq$easy$mq$),
($mq$Complète : « ____ chat est noir. »$mq$, $mq$["Se","Ceux","Ce","Sa"]$mq$, 2, $mq$« Ce » est un déterminant démonstratif devant un nom masculin singulier.$mq$, $mq$easy$mq$),
($mq$Quel est le pluriel de « cheval » ?$mq$, $mq$["chevals","chevaux","chevales","chevaus"]$mq$, 1, $mq$Beaucoup de noms en -al font leur pluriel en -aux : cheval, chevaux ; journal, journaux.$mq$, $mq$easy$mq$),
($mq$Le préfixe « in- » dans « inutile » exprime…$mq$, $mq$["la négation ou le contraire","la répétition","la taille","le lieu"]$mq$, 0, $mq$« Inutile » signifie « pas utile ». Devant b, m, p, on écrit im- : impossible.$mq$, $mq$easy$mq$),
($mq$Complète : « Ils ____ partis tôt ce matin. » (sont / son)$mq$, $mq$["son","ont","sons","sont"]$mq$, 3, $mq$« sont » est le verbe être (on peut dire « étaient »). « son » est un déterminant possessif.$mq$, $mq$medium$mq$),
($mq$Complète : « Elle ____ réveillée à six heures. » (s'est / c'est)$mq$, $mq$["c'est","ces","s'est","ses"]$mq$, 2, $mq$« s'est » est le pronom « se » + être, devant un verbe pronominal : elle s'est réveillée.$mq$, $mq$medium$mq$),
($mq$Complète : « ____ habites-tu ? » (ou / où)$mq$, $mq$["Ou","Où","Ouh","Oû"]$mq$, 1, $mq$« où » avec accent indique le lieu. « ou » sans accent signifie « ou bien ».$mq$, $mq$medium$mq$),
($mq$Que signifie le faux ami « actuellement » ?$mq$, $mq$["À présent, en ce moment","En réalité","Autrefois","Parfois"]$mq$, 0, $mq$« Actuellement » veut dire « à présent ». L'anglais « actually » se traduit plutôt par « en fait ».$mq$, $mq$medium$mq$),
($mq$Que désigne le mot « librairie » ?$mq$, $mq$["Une bibliothèque","Un lieu pour prêter des livres gratuitement","Un éditeur","Un magasin où l'on achète des livres"]$mq$, 3, $mq$« Librairie » est un commerce. L'anglais « library » se dit « bibliothèque ».$mq$, $mq$medium$mq$),
($mq$Quel mot n'appartient PAS à la famille du mot « terre » ?$mq$, $mq$["terrain","atterrir","terrible","enterrer"]$mq$, 2, $mq$« Terrible » vient du latin « terrere » (effrayer). Les autres mots dérivent de « terre ».$mq$, $mq$medium$mq$),
($mq$Quel est l'adverbe formé à partir de « suffisant » ?$mq$, $mq$["suffisament","suffisamment","suffisantement","suffisemment"]$mq$, 1, $mq$Les adjectifs en -ant font leur adverbe en -amment : suffisamment, constamment, brillamment.$mq$, $mq$medium$mq$),
($mq$Lequel de ces mots est familier pour désigner un livre ?$mq$, $mq$["bouquin","ouvrage","volume","recueil"]$mq$, 0, $mq$« Bouquin » est du registre familier. « Ouvrage » appartient au registre soutenu.$mq$, $mq$medium$mq$),
($mq$Complète : « Je crois ____ est déjà partie. »$mq$, $mq$["quelle","qu'elles","quel","qu'elle"]$mq$, 3, $mq$« qu'elle » = que + elle. « Quelle » est un déterminant interrogatif ou exclamatif.$mq$, $mq$hard$mq$),
($mq$Quel nom est dérivé du verbe « détruire » ?$mq$, $mq$["détruction","destrucsion","destruction","détrusion"]$mq$, 2, $mq$Le nom est « destruction », issu du radical latin. Le suffixe -tion forme des noms d'action.$mq$, $mq$hard$mq$),
($mq$Quelle formulation est la plus précise et correcte ? « Il a fait un discours. »$mq$, $mq$["Il a mis un discours.","Il a prononcé un discours.","Il a dit un discours.","Il a pris un discours."]$mq$, 1, $mq$« Prononcer un discours » est la collocation courante. Remplacer « faire » par un verbe précis améliore le style.$mq$, $mq$hard$mq$),
($mq$Quelle phrase ne contient aucune erreur d'orthographe ?$mq$, $mq$["Elles sont arrivées tôt, et leurs amies les ont accueillies.","Elles sont arrivé tôt, et leurs amies les ont accueillies.","Elles sont arrivées tôt, et leur amies les ont accueillis.","Elles sont arrivées tôt, et leurs amis les ont accueilli."]$mq$, 0, $mq$Le participe « arrivées » s'accorde avec « elles ». « Accueillies » s'accorde avec le COD « les » (féminin pluriel) placé avant.$mq$, $mq$hard$mq$),
($mq$« Nous pourrons éventuellement venir. » Que signifie « éventuellement » ?$mq$, $mq$["Finalement, à la fin","Immédiatement","Toujours","Peut-être, selon les circonstances"]$mq$, 3, $mq$« Éventuellement » veut dire « si le cas se présente ». L'anglais « eventually » correspond plutôt à « finalement ».$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Spelling and Vocabulary$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$a / à$mq$, $mq$« a » est le verbe avoir (remplaçable par « avait »). « à » est une préposition.$mq$),
($mq$sont / son$mq$, $mq$« sont » est le verbe être (remplaçable par « étaient »). « son » est un déterminant possessif.$mq$),
($mq$s'est / c'est$mq$, $mq$« s'est » = se + être devant un participe : elle s'est réveillée. « c'est » = cela est.$mq$),
($mq$ou / où$mq$, $mq$« où » (accent) indique le lieu ou le temps ; « ou » (sans accent) signifie « ou bien ».$mq$),
($mq$qu'elle / quelle$mq$, $mq$« qu'elle » = que + elle. « quelle » est un déterminant interrogatif ou exclamatif (« quelle idée ! »).$mq$),
($mq$Pluriel des noms en -al$mq$, $mq$Souvent -aux : cheval, chevaux ; journal, journaux ; animal, animaux.$mq$),
($mq$Adverbes en -amment / -emment$mq$, $mq$Adjectifs en -ant donnent -amment (constamment) ; adjectifs en -ent donnent -emment (évidemment).$mq$),
($mq$Faux amis$mq$, $mq$actuellement = à présent ; librairie = magasin de livres ; éventuellement = peut-être selon les cas.$mq$),
($mq$Préfixes in- / dé- / re-$mq$, $mq$in- : contraire (inutile) ; dé- : action inverse (défaire) ; re- : répétition (refaire).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Spelling and Vocabulary$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## L'essentiel
Une orthographe soignée et un vocabulaire riche rendent un texte plus crédible et plus clair. À l'examen, les erreurs répétées d'orthographe ou de lexique abaissent la note de précision de la langue. La bonne nouvelle : la plupart des erreurs viennent de quelques familles de mots que l'on peut apprendre à contrôler.

## Les homophones les plus fréquents
Technique de contrôle : remplace le mot par un autre pour tester.
- **a / à** : « a » = verbe avoir (essaie « avait »). « Il a un livre » ; « Elle va à Paris ».
- **et / est** : « est » = verbe être (essaie « était »).
- **on / ont** : « ont » = avoir au pluriel (essaie « avaient »).
- **son / sont** : « sont » = être (essaie « étaient »). « Ils sont partis. »
- **ce / se** : « ce » est un déterminant ou pronom démonstratif (« ce chat ») ; « se » accompagne un verbe pronominal.
- **c'est / s'est** : « s'est » = se + être (« elle s'est réveillée »).
- **ou / où** : « où » indique le lieu ; « ou » = « ou bien ».
- **qu'elle / quelle** : « qu'elle » = que + elle ; « quelle » est un déterminant (« quelle idée ! »).
- **leur / leurs** : « leurs » prend un s si le nom qui suit est pluriel (« leurs amies »).

## Les accords et les pluriels
Le pluriel des noms n'est pas toujours en -s : cheval, chevaux ; journal, journaux ; travail, travaux. Les adjectifs et les participes s'accordent : « Elles sont arrivées. » N'oublie pas les terminaisons muettes, qui sont une source majeure d'erreurs.

## Former des mots
- **Préfixes** : in-/im-/il-/ir- (contraire : inutile, impossible), dé- (action inverse : défaire), re- (répétition : refaire).
- **Suffixes** : -tion (nom d'action : destruction), -ment (adverbe : évidemment, suffisamment), -able (possibilité : lisible).
- **Familles de mots** : terre, terrain, atterrir, enterrer. Le mot « terrible » n'en fait pas partie.
Les adjectifs en -ant font l'adverbe en -amment (constamment, brillamment), ceux en -ent en -emment (évidemment).

## Enrichir son vocabulaire
- Remplace les verbes vagues (faire, mettre, dire, avoir) : « prononcer un discours », « formuler une hypothèse ».
- Utilise des synonymes et des champs lexicaux pour éviter les répétitions.
- Contrôle le **registre** : « bouquin » est familier, « livre » est courant, « ouvrage » est soutenu.

## Les faux amis
- **actuellement** = en ce moment (anglais « currently »), pas « actually ».
- **librairie** = magasin de livres (anglais « bookshop »), pas « library ».
- **éventuellement** = peut-être, selon les cas, pas « eventually ».

## Comment c'est évalué
La précision de la langue est examinée dans tes écrits (richesse du vocabulaire, exactitude de l'orthographe) et parfois par de courtes questions en contexte : compléter une phrase, repérer l'erreur, choisir le mot adapté.

## Erreurs fréquentes
- Confondre les homophones (a/à, ou/où, ces/ses).
- Oublier l'accord du participe ou du pluriel.
- Utiliser un faux ami.
- Répéter le même mot dans toute la copie.

Exam tip: garde une liste personnelle de tes cinq erreurs d'orthographe les plus fréquentes et vérifie-les systématiquement pendant la relecture.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;