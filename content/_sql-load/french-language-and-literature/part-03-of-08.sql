-- Part 3 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Prose and Fiction > Narrative Voice
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Prose and Fiction$mq$, 5, 3 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Narrative Voice$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Prose and Fiction$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Narrative Voice$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Quel pronom caractérise un narrateur à la première personne ?$mq$, $mq$["Je","Il / elle","Tu","Vous"]$mq$, 0, $mq$Un narrateur à la première personne raconte sa propre histoire avec « je » : il est un personnage du récit.$mq$, $mq$easy$mq$),
($mq$Dans un récit à la troisième personne, le narrateur est...$mq$, $mq$["Un personnage qui dit « je »","Toujours le héros","Toujours le lecteur","Une voix extérieure qui parle des personnages avec « il » ou « elle »"]$mq$, 3, $mq$À la troisième personne, le narrateur raconte l'histoire des autres sans en être un personnage.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce que le point de vue (ou focalisation) ?$mq$, $mq$["La longueur du récit","Le titre du livre","La perspective à travers laquelle on perçoit l'histoire","Le lieu de publication"]$mq$, 2, $mq$Le point de vue indique qui voit, qui sait et jusqu'où va la connaissance du récit.$mq$, $mq$easy$mq$),
($mq$Quel est le temps de base d'un récit au passé ?$mq$, $mq$["Le futur simple uniquement","Le passé simple et l'imparfait","L'impératif","Le conditionnel présent uniquement"]$mq$, 1, $mq$Le passé simple raconte les actions principales, l'imparfait décrit le décor et les actions de fond.$mq$, $mq$easy$mq$),
($mq$Que fait un narrateur omniscient ?$mq$, $mq$["Il sait tout : actions, pensées et sentiments de tous les personnages","Il ne sait rien","Il ne connaît que son propre point de vue","Il parle uniquement par dialogues"]$mq$, 0, $mq$La focalisation zéro (narrateur omniscient) donne accès à tout : intérieur des personnages, passé et futur.$mq$, $mq$easy$mq$),
($mq$Extrait inventé : « J'ai ouvert la porte et j'ai senti mon cœur battre plus fort. » Quelle voix narrative ?$mq$, $mq$["Troisième personne, narrateur extérieur","Narrateur omniscient","Deuxième personne","Première personne, narrateur-personnage"]$mq$, 3, $mq$« J'ai ouvert », « mon cœur » : le narrateur est un personnage qui raconte ce qu'il vit.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Nora entra. Elle ignorait que, dans la pièce voisine, son frère préparait une surprise. » Quelle focalisation ?$mq$, $mq$["Interne : on ne connaît que ce que sait Nora","Externe : on ne sait rien","Omnisciente : le narrateur sait plus que le personnage","Aucune"]$mq$, 2, $mq$Le narrateur sait ce que Nora ignore : il en sait plus que le personnage, ce qui caractérise la focalisation zéro.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Marc se leva. Il traversa la cour, ouvrit la grille, regarda à droite, à gauche, puis s'éloigna. » Le narrateur ne dit rien de ses pensées. Quelle focalisation ?$mq$, $mq$["Interne","Externe","Omnisciente","Subjective"]$mq$, 1, $mq$On ne voit que les gestes, comme une caméra : on ne connaît ni les pensées ni les sentiments de Marc. C'est la focalisation externe.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Élise voyait la scène par la fenêtre. Pourquoi cet homme restait-il là, immobile ? Elle se sentait inquiète. » Quelle focalisation ?$mq$, $mq$["Interne : on perçoit à travers Élise","Externe","Omnisciente","Collective"]$mq$, 0, $mq$On accède aux perceptions et aux questions d'Élise seulement : le récit est limité à son point de vue.$mq$, $mq$medium$mq$),
($mq$Quel est l'effet d'un narrateur à la première personne ?$mq$, $mq$["Il donne la connaissance totale de tous les personnages","Il supprime les émotions","Il est toujours objectif","Il rapproche le lecteur du personnage mais limite la connaissance"]$mq$, 3, $mq$La première personne crée de l'intimité et de l'identification, mais le lecteur ne voit que ce que le narrateur perçoit.$mq$, $mq$medium$mq$),
($mq$Qu'est-ce qu'un narrateur « non fiable » ?$mq$, $mq$["Un narrateur qui n'existe pas","Un narrateur qui dit toujours la vérité","Un narrateur dont le récit est trompeur, biaisé ou limité","Un narrateur sans nom"]$mq$, 2, $mq$Un narrateur non fiable peut mentir, se tromper ou déformer les faits : le lecteur doit rester critique.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Tout le monde dit que j'ai tout compris. En vérité, je n'ai rien compris du tout. » Que révèle ce passage sur le narrateur ?$mq$, $mq$["Il est omniscient","Il reconnaît un écart entre l'image publique et la réalité, ce qui rend son récit nuancé","Il parle à la troisième personne","Il décrit un paysage"]$mq$, 1, $mq$Le contraste entre « tout le monde dit » et « en vérité » montre un narrateur honnête sur ses limites, qui invite à la réflexion.$mq$, $mq$medium$mq$),
($mq$Quel temps verbal sert à raconter une action ponctuelle importante dans un récit littéraire ?$mq$, $mq$["Le passé simple","L'imparfait","Le futur","Le présent de l'impératif"]$mq$, 0, $mq$Le passé simple marque les actions achevées et successives qui font avancer l'histoire : « Il ouvrit la porte ».$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Tu ouvres la lettre. Tu hésites. Tes mains tremblent. » Quel effet produit la deuxième personne ?$mq$, $mq$["Elle rend le récit objectif","Elle supprime la tension","Elle signale un dialogue","Elle implique directement le lecteur dans l'action et crée une impression d'intimité ou d'étrangeté"]$mq$, 3, $mq$Le « tu » est rare : il interpelle le lecteur ou une conscience intérieure, créant une proximité inhabituelle.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Je jure que la soirée fut parfaite. Il n'y eut ni cris ni larmes, rien que des rires. » Plus tard, on découvre que la fête s'est terminée en dispute. Que dit cela de ce narrateur à la première personne ?$mq$, $mq$["Il est omniscient","Il est un narrateur extérieur","Il est probablement non fiable : il embellit ou dissimule","Il raconte à la deuxième personne"]$mq$, 2, $mq$Quand un récit est contredit par d'autres informations, on soupçonne le narrateur d'une distorsion volontaire ou involontaire.$mq$, $mq$hard$mq$),
($mq$Un auteur choisit de raconter une enquête uniquement à travers le regard d'un jeune enfant qui comprend mal ce qu'il observe. Quel est l'effet principal ?$mq$, $mq$["Le lecteur sait tout dès le début","Le lecteur devine plus que le narrateur, ce qui crée suspense et ironie dramatique","Le lecteur ne comprend rien","Le récit devient un article"]$mq$, 1, $mq$Une perspective naïve laisse au lecteur le soin de combler les silences : on lit entre les lignes ce que l'enfant ne saisit pas.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « La ville ne dormait jamais, pensa Jules, et pourtant elle semblait suspendue, comme retenant son souffle. » Quelle analyse de la voix narrative est la plus précise ?$mq$, $mq$["Narration à la troisième personne qui bascule vers la pensée de Jules (focalisation interne) et se colore de personnification","Narration à la première personne pure","Description scientifique neutre","Dialogue direct sans narrateur"]$mq$, 0, $mq$Le verbe « pensa » ancre le point de vue dans Jules, tandis que « retenant son souffle » personnifie la ville : on lit sa perception subjective.$mq$, $mq$hard$mq$),
($mq$Pourquoi un auteur peut-il changer de point de vue au cours d'un roman ?$mq$, $mq$["Parce qu'il a oublié le premier point de vue","Pour économiser des mots","Parce que c'est obligatoire au chapitre trois","Pour offrir plusieurs perspectives sur les mêmes événements et nuancer la vérité"]$mq$, 3, $mq$Les points de vue multiples enrichissent le récit : le lecteur compare les versions et construit sa propre interprétation.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Narrative Voice$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Narrateur$mq$, $mq$La voix qui raconte l'histoire. Il ne faut pas le confondre avec l'auteur, personne réelle qui écrit.$mq$),
($mq$Narration à la 1re personne$mq$, $mq$Le narrateur est un personnage (« je »). Effet : intimité, subjectivité, mais connaissance limitée.$mq$),
($mq$Narration à la 3e personne$mq$, $mq$Le narrateur est extérieur (« il / elle »). Il peut avoir une vue d'ensemble sur plusieurs personnages.$mq$),
($mq$Focalisation zéro (omnisciente)$mq$, $mq$Le narrateur sait tout : pensées de tous les personnages, passé, futur, ce que chacun ignore.$mq$),
($mq$Focalisation interne$mq$, $mq$Le récit est limité à ce que perçoit, pense et ressent un personnage.$mq$),
($mq$Focalisation externe$mq$, $mq$Le narrateur décrit seulement les gestes et les paroles, sans accès aux pensées, comme une caméra.$mq$),
($mq$Narrateur non fiable$mq$, $mq$Narrateur dont le récit est trompeur, biaisé ou limité. Le lecteur doit rester critique et chercher les contradictions.$mq$),
($mq$Passé simple et imparfait$mq$, $mq$Passé simple : actions achevées qui font avancer le récit. Imparfait : décor, habitudes, actions de fond.$mq$),
($mq$Analyser la voix narrative$mq$, $mq$Identifier la personne et la focalisation, citer des indices, expliquer l'effet sur le lecteur, relier au thème.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Narrative Voice$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Qui raconte l'histoire ?
Tout récit est raconté par une voix : le **narrateur**. Il ne faut jamais confondre le narrateur (la voix qui raconte) avec l'auteur (la personne réelle qui écrit). Le choix de la voix narrative change totalement la manière dont le lecteur comprend et ressent l'histoire. En analyse littéraire, on se pose toujours trois questions : qui parle, qui voit, que sait-on ?

## Les personnes grammaticales
- **Première personne (« je »)** : le narrateur est un personnage. Le récit est intime, subjectif, proche des émotions, mais limité à ce que le narrateur perçoit. Exemple inventé : « J'ai ouvert la porte et j'ai senti mon cœur battre plus fort. »
- **Troisième personne (« il / elle »)** : le narrateur est extérieur. Il peut raconter plusieurs personnages et avoir une vue d'ensemble.
- **Deuxième personne (« tu / vous »)** : plus rare. Elle implique le lecteur ou une conscience intérieure et crée une impression d'intimité ou d'étrangeté.

## La focalisation
La **focalisation** (ou point de vue) désigne la quantité d'informations que le narrateur donne.
- **Focalisation zéro (omnisciente)** : le narrateur sait tout, y compris les pensées de tous et ce que les personnages ignorent. Exemple : « Nora entra. Elle ignorait que son frère préparait une surprise. »
- **Focalisation interne** : le récit est limité à ce que perçoit un personnage : ses sensations, ses pensées, ses doutes. Exemple : « Élise voyait la scène par la fenêtre. Pourquoi cet homme restait-il là ? »
- **Focalisation externe** : le narrateur décrit seulement les gestes et les paroles, comme une caméra, sans accès à l'intérieur des personnages.

## Le narrateur non fiable
Un narrateur est **non fiable** quand son récit peut être trompeur : il ment, se trompe, embellit ou ne comprend pas ce qu'il voit. Le lecteur doit alors lire avec méfiance, repérer les contradictions et se demander ce qui n'est pas dit. Un jeune enfant qui raconte une dispute adulte est un bon exemple : il décrit les faits sans en saisir la portée, et le lecteur devine ce que le narrateur ignore.

## Les temps du récit
Dans un récit au passé, le **passé simple** raconte les actions achevées qui font avancer l'histoire (« Il ouvrit la porte »), tandis que l'**imparfait** décrit le décor, les habitudes et les actions de fond (« Il pleuvait »). Le **présent de narration** donne de la vivacité en rapprochant l'action du lecteur. Un changement de temps est souvent significatif.

## Comment analyser la voix narrative
- **Identifier** la personne grammaticale et la focalisation.
- **Citer** des indices : pronoms, verbes de pensée (« pensa », « il ignorait »), description neutre ou subjective.
- **Expliquer** l'effet : proximité, suspense, ironie, mystère, objectivité.
- **Relier** au thème ou au caractère du personnage.

## Erreurs fréquentes
- Confondre l'auteur et le narrateur.
- Dire « il s'agit d'un narrateur à la première personne » sans expliquer l'effet.
- Confondre focalisation et personne grammaticale : un récit à la troisième personne peut être en focalisation interne.
- Ne pas remarquer un changement de point de vue entre deux paragraphes.
- Croire que le narrateur dit toujours la vérité.

## Comment cela est évalué
À l'examen, on propose un extrait de fiction et on demande : « Comment le choix du narrateur influence-t-il votre lecture ? » La réponse efficace nomme la voix, cite deux indices, puis explique ce que le lecteur sait ou ignore.

Exam tip: écrivez toujours qui raconte, ce que le narrateur sait, puis l'effet sur le lecteur ; ces trois éléments forment une réponse complète et structurée.$mq$ from st;

-- Prose and Fiction > Character and Setting
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Prose and Fiction$mq$, 5, 3 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Character and Setting$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Prose and Fiction$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Character and Setting$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Qu'est-ce que la caractérisation ?$mq$, $mq$["L'ensemble des moyens qui présentent un personnage","Le titre du roman","Le nombre de personnages","Le décor seulement"]$mq$, 0, $mq$La caractérisation désigne les procédés (description, actions, paroles, pensées) qui nous font connaître un personnage.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce qu'un protagoniste ?$mq$, $mq$["Un personnage secondaire sans importance","Le narrateur obligatoirement","L'auteur","Le personnage principal"]$mq$, 3, $mq$Le protagoniste est le personnage central dont le parcours structure le récit.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce que le cadre spatio-temporel d'un récit ?$mq$, $mq$["Le plan du livre","La couverture","Le lieu et l'époque où se déroule l'histoire","La table des matières"]$mq$, 2, $mq$Le cadre spatio-temporel indique où et quand l'action se passe.$mq$, $mq$easy$mq$),
($mq$Quel mot désigne le personnage qui s'oppose au héros ?$mq$, $mq$["Le narrateur","L'antagoniste","Le lecteur","Le figurant"]$mq$, 1, $mq$L'antagoniste est le personnage ou la force qui s'oppose au protagoniste et crée le conflit.$mq$, $mq$easy$mq$),
($mq$Comment un auteur peut-il révéler le caractère d'un personnage ?$mq$, $mq$["Par ses actions, ses paroles, ses pensées et sa description physique","Uniquement par le titre","Uniquement par la couverture","Par le nombre de pages"]$mq$, 0, $mq$On montre un personnage par ce qu'il fait, dit et pense, et par ce que les autres disent de lui.$mq$, $mq$easy$mq$),
($mq$Extrait inventé : « Antoine rangea ses crayons par couleur, puis par taille, puis, pour finir, par ordre alphabétique. » Que suggère ce détail ?$mq$, $mq$["Un caractère nonchalant","Un caractère violent","Un caractère timide","Un caractère méticuleux, voire obsessionnel"]$mq$, 3, $mq$Une action répétée et excessive révèle le souci d'ordre : une caractérisation indirecte par le comportement.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « La cuisine sentait le pain chaud et la cannelle ; sur la table, une nappe à carreaux attendait. » Quelle atmosphère crée ce cadre ?$mq$, $mq$["Menaçante","Futuriste","Chaleureuse et accueillante","Industrielle"]$mq$, 2, $mq$Les odeurs de pain et de cannelle et la nappe à carreaux évoquent un foyer chaleureux.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « L'immeuble penchait sous un ciel de plomb ; les fenêtres, sans rideaux, fixaient la rue comme des yeux vides. » Quelle fonction a la description ?$mq$, $mq$["Informer sur le prix des appartements","Créer une atmosphère sinistre qui annonce un drame","Faire rire le lecteur","Résumer le chapitre précédent"]$mq$, 1, $mq$Le ciel de plomb et les fenêtres « comme des yeux vides » créent un climat d'inquiétude qui prépare la suite de l'histoire.$mq$, $mq$medium$mq$),
($mq$Qu'est-ce qu'un personnage « rond » ?$mq$, $mq$["Un personnage complexe, qui évolue et a des contradictions","Un personnage au visage rond","Un personnage qui ne change jamais","Un personnage inventé par l'éditeur"]$mq$, 0, $mq$Un personnage rond est nuancé et change au fil de l'histoire ; un personnage plat reste simple et prévisible.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « — Je m'en fiche, lança Clara, mais elle serra si fort sa tasse que ses doigts blanchirent. » Que révèle le contraste ?$mq$, $mq$["Clara est détendue","Clara a froid","Clara a faim","Clara prétend l'indifférence alors qu'elle est émue ou tendue"]$mq$, 3, $mq$Le geste contredit la parole : la caractérisation indirecte révèle ce que le personnage cache.$mq$, $mq$medium$mq$),
($mq$Qu'est-ce que l'évolution d'un personnage ?$mq$, $mq$["Son âge uniquement","Son déménagement","Le changement de ses idées, valeurs ou attitudes au cours du récit","Le nombre de ses répliques"]$mq$, 2, $mq$L'évolution marque un parcours intérieur : le personnage au début n'est pas le même qu'à la fin.$mq$, $mq$medium$mq$),
($mq$Quelle fonction a un lieu fermé (cave, île, train) dans un récit ?$mq$, $mq$["Allonger le texte","Intensifier la tension en limitant les possibilités d'échapper","Cacher le titre","Rendre l'histoire documentaire"]$mq$, 1, $mq$Le huis clos concentre l'action et accentue la tension entre les personnages.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Le village qu'il avait quitté enfant lui parut minuscule, mais ses rues l'enveloppèrent comme un vieux manteau. » Quelle double impression crée la description ?$mq$, $mq$["Un mélange de distance et de nostalgie réconfortante","Une hostilité totale","Une indifférence complète","Un émerveillement technologique"]$mq$, 0, $mq$« Minuscule » exprime l'écart avec le souvenir, « vieux manteau » la protection familière : le cadre révèle l'émotion du personnage.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Le boulevard, large et ensoleillé, grouillait de vie. Pourtant, Samia avançait la tête basse, comme si chaque passant lui reprochait quelque chose. » Quel effet produit ce contraste entre cadre et personnage ?$mq$, $mq$["Il prouve que Samia est heureuse","Il décrit un paysage sans importance","Il montre l'ennui du narrateur","Il souligne la solitude ou la culpabilité de Samia malgré un décor joyeux"]$mq$, 3, $mq$Un cadre lumineux opposé à un état intérieur sombre fait ressortir le malaise du personnage : le décor met en relief son émotion.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Monsieur Dubois soignait sa pelouse avec un soin que d'autres réservaient à leurs enfants. Les rares fois où son fils appelait, il laissait sonner. » Quelle conclusion est la mieux justifiée ?$mq$, $mq$["Le personnage est généreux avec sa famille","Le personnage ne possède pas de jardin","Le personnage investit ses affections dans les apparences ou les objets plutôt que dans ses relations humaines","Le personnage est un narrateur"]$mq$, 2, $mq$La comparaison avec « leurs enfants » et le contraste avec l'indifférence au téléphone suggèrent une affection mal placée : caractérisation indirecte et critique implicite.$mq$, $mq$hard$mq$),
($mq$Pourquoi un auteur ajoute-t-il un personnage secondaire qui sert de contraste au protagoniste ?$mq$, $mq$["Pour remplir les pages","Pour mettre en valeur, par comparaison, les qualités ou les défauts du protagoniste","Pour supprimer le conflit","Pour changer de narrateur"]$mq$, 1, $mq$Un personnage-repoussoir ou un double permet de faire ressortir, par contraste, les traits du héros (le « faire-valoir »).$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « La maison, repeinte à neuf, cachait mal les fissures qui montaient le long du mur. » Comment le décor peut-il être symbolique ?$mq$, $mq$["Il suggère une façade soignée masquant une fragilité cachée, peut-être celle de la famille","Il informe sur le coût de la peinture","Il montre un décor sans lien avec l'histoire","Il prouve que la maison est neuve"]$mq$, 0, $mq$Un détail concret (peinture neuve, fissures) peut symboliser un contraste apparence/réalité. Une bonne analyse relie le détail au sens du récit.$mq$, $mq$hard$mq$),
($mq$Quelle réponse analyse le mieux un portrait en début de roman ?$mq$, $mq$["Elle recopie la description","Elle résume le roman","Elle donne son opinion sur le physique du personnage","Elle relève des détails précis (vêtements, attitude, paroles), explique ce qu'ils suggèrent du caractère et indique ce que cela annonce"]$mq$, 3, $mq$Une bonne analyse relève, interprète et anticipe : le portrait annonce souvent le rôle et l'évolution du personnage.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Character and Setting$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Caractérisation directe$mq$, $mq$Le narrateur nomme les traits du personnage : « Antoine était méticuleux ».$mq$),
($mq$Caractérisation indirecte$mq$, $mq$On déduit le caractère par les actions, paroles, pensées, apparence et réactions des autres.$mq$),
($mq$Protagoniste / antagoniste$mq$, $mq$Le protagoniste est le personnage principal ; l'antagoniste s'oppose à lui et crée le conflit.$mq$),
($mq$Personnage rond / plat$mq$, $mq$Rond : complexe, nuancé, évolue. Plat : simple, défini par un seul trait, prévisible.$mq$),
($mq$Faire-valoir$mq$, $mq$Personnage qui met en valeur le héros par contraste ou par admiration.$mq$),
($mq$Cadre spatio-temporel$mq$, $mq$Le lieu (espace) et l'époque (temps) où se déroule l'histoire.$mq$),
($mq$Fonctions du cadre$mq$, $mq$Informer, créer une atmosphère, révéler un personnage, annoncer l'action, symboliser une idée.$mq$),
($mq$Huis clos$mq$, $mq$Lieu fermé où les personnages sont enfermés : il intensifie la tension et les conflits.$mq$),
($mq$Analyser un portrait$mq$, $mq$Relever des détails précis, interpréter ce qu'ils suggèrent, relier à ce que cela annonce ou au thème.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Character and Setting$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Personnages et cadre : construire un monde
Un récit repose sur deux piliers : les **personnages**, qui agissent, et le **cadre**, qui les entoure. Les deux sont liés : le lieu et l'époque influencent les choix des personnages, et les personnages donnent au décor une couleur émotionnelle. Analyser ces éléments, c'est comprendre comment l'auteur construit un univers crédible et chargé de sens.

## Les types de personnages
- Le **protagoniste** est le personnage principal dont le parcours structure l'histoire.
- L'**antagoniste** s'oppose au protagoniste : personne, groupe ou force (la nature, la société).
- Les personnages **secondaires** soutiennent l'intrigue. Un **faire-valoir** met en valeur le héros par contraste.
- Un personnage **rond** est complexe, nuancé, et évolue. Un personnage **plat** est simple et prévisible, souvent défini par un seul trait.

## La caractérisation
L'auteur nous fait connaître un personnage de plusieurs façons.
- **Caractérisation directe** : le narrateur décrit : « Antoine était méticuleux. »
- **Caractérisation indirecte** : on déduit le caractère à partir des **actions**, des **paroles**, des **pensées**, de l'apparence, des réactions des autres et du **cadre**. Exemple inventé : « Antoine rangea ses crayons par couleur, puis par taille, puis par ordre alphabétique » suggère un caractère méticuleux.
La caractérisation indirecte est souvent plus subtile : le contraste entre ce qu'un personnage dit et ce qu'il fait révèle ce qu'il cache. Dans « — Je m'en fiche, lança Clara, mais elle serra si fort sa tasse que ses doigts blanchirent », le geste contredit la parole.

## L'évolution du personnage
Un personnage évolue quand ses idées, ses valeurs ou ses comportements changent à cause d'événements. Pour l'analyser, comparez le début et la fin : que pensait-il ? qu'a-t-il appris ? quel moment a provoqué le changement ? Les verbes de mouvement intérieur (comprendre, renoncer, accepter) signalent souvent cette évolution.

## Le cadre spatio-temporel
Le cadre précise **où** et **quand** se passe l'histoire. Il peut avoir plusieurs fonctions.
- **Informer** sur l'époque, le milieu, la société.
- **Créer une atmosphère** : une cuisine chaleureuse qui sent la cannelle, un immeuble qui penche sous un ciel de plomb.
- **Révéler un personnage** : sa chambre, sa rue, son village montrent ses habitudes et ses émotions.
- **Annoncer l'action** : un décor sinistre prépare un drame.
- **Symboliser** : une maison repeinte à neuf qui cache des fissures peut suggérer une façade soignée masquant une fragilité.
Un lieu fermé (huis clos) intensifie la tension : les personnages ne peuvent pas s'échapper.

## Comment analyser un portrait ou une description
- **Relever** deux ou trois détails précis.
- **Interpréter** ce qu'ils suggèrent (caractère, émotion, atmosphère).
- **Relier** à ce que le passage annonce ou à un thème du récit.
- **Nuancer** si l'auteur crée un contraste entre cadre et personnage.
Exemple : un boulevard ensoleillé traversé par un personnage qui avance la tête basse souligne sa culpabilité ou sa solitude.

## Erreurs fréquentes
- Résumer le passage au lieu d'analyser.
- Décrire le personnage sans citer de détail précis.
- Oublier que le cadre peut refléter l'état intérieur d'un personnage.
- Confondre caractérisation directe et indirecte.
- Juger le personnage comme une personne réelle au lieu d'étudier les choix de l'auteur.

## Comment cela est évalué
À l'examen, une question peut demander : « Comment l'auteur présente-t-il le personnage dans ce passage ? » ou « Quel rôle joue le cadre ? » Le critère A évalue la précision de l'analyse et l'usage de citations.

Exam tip: pour chaque personnage, citez un détail, dites ce qu'il suggère, puis ajoutez ce que l'auteur veut nous faire ressentir ; cela transforme une description en véritable analyse.$mq$ from st;

-- Prose and Fiction > Themes and Symbols
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Prose and Fiction$mq$, 5, 3 from public.subjects s where s.slug = $mq$french-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Themes and Symbols$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$french-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Prose and Fiction$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Themes and Symbols$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Qu'est-ce qu'un thème dans un récit ?$mq$, $mq$["Une idée centrale que le texte explore, comme l'amitié ou la liberté","L'ordre des chapitres","Le nom du narrateur","Le lieu de l'action"]$mq$, 0, $mq$Un thème est une idée générale traitée par l'œuvre : la perte, la justice, le courage, la solitude.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce qu'un symbole ?$mq$, $mq$["Une faute d'orthographe","Une ponctuation","Un nom propre","Un objet, un lieu ou une image qui représente une idée plus large"]$mq$, 3, $mq$Le symbole renvoie à autre chose que lui-même : la colombe symbolise la paix, par exemple.$mq$, $mq$easy$mq$),
($mq$Quelle phrase formule un thème (et non un simple sujet) ?$mq$, $mq$["Une fille et son chien.","Un voyage en train.","La solitude peut pousser à chercher de vrais liens.","Le chapitre trois."]$mq$, 2, $mq$Un thème est une idée générale, exprimée en phrase complète : elle va plus loin que l'intrigue.$mq$, $mq$easy$mq$),
($mq$Que symbolise le plus souvent une porte fermée dans un récit ?$mq$, $mq$["Une fête","Un obstacle ou un secret","Un repas","Un voyage"]$mq$, 1, $mq$Une porte fermée suggère un secret, une séparation ou une barrière à franchir.$mq$, $mq$easy$mq$),
($mq$Qu'est-ce qu'un motif dans une œuvre ?$mq$, $mq$["Un élément qui se répète (objet, image, mot) et qui construit un sens","Une raison de l'auteur","Une date de publication","Un titre"]$mq$, 0, $mq$Un motif est un élément récurrent qui, en se répétant, renforce un thème.$mq$, $mq$easy$mq$),
($mq$Extrait inventé : « La vieille horloge s'était arrêtée le jour du départ de Mamie. Personne n'osait la remonter. » Que symbolise l'horloge arrêtée ?$mq$, $mq$["Une fête d'anniversaire","Une panne électrique ordinaire","La réussite scolaire","Le temps suspendu par le deuil, l'incapacité à tourner la page"]$mq$, 3, $mq$Une horloge figée au moment d'une perte symbolise l'immobilité du chagrin : l'objet représente un état émotionnel.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Chaque matin, Tom regardait la mer par la fenêtre, puis baissait les yeux. » Quel thème cette répétition peut-elle suggérer ?$mq$, $mq$["La passion pour la cuisine","Le goût du sport","Le désir de partir et la peur de s'y résoudre","L'indifférence totale"]$mq$, 2, $mq$Le regard vers l'horizon puis détourné suggère le conflit entre aspiration et crainte : motif et thème sont liés.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Le seul arbre de la cour, malgré le béton, avait fleuri. » Quelle interprétation symbolique est la plus plausible ?$mq$, $mq$["La défaite du héros","La vie ou l'espoir qui résiste dans un environnement hostile","La richesse d'une famille","L'arrivée de la nuit"]$mq$, 1, $mq$Un arbre qui fleurit malgré le béton symbolise la résilience : un petit détail porte une idée générale.$mq$, $mq$medium$mq$),
($mq$Pourquoi un auteur répète-t-il un motif (par exemple la pluie) au cours d'un récit ?$mq$, $mq$["Pour souligner un thème et créer une unité de sens","Pour allonger le roman","Pour prévenir d'une météo","Pour changer de narrateur"]$mq$, 0, $mq$La répétition d'un motif relie les scènes entre elles et renforce une idée centrale (tristesse, purification, renouveau).$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Le dernier jour, Lina rendit la clé à son père, sans un mot. » Que peut symboliser la clé ?$mq$, $mq$["Une recette","Un métier de serrurier","Une ponctuation","L'accès à une vie, une responsabilité ou un foyer ; ici, un adieu ou un passage"]$mq$, 3, $mq$La clé symbolise souvent l'accès, la confiance ou la propriété. Rendre la clé marque une rupture ou un passage vers l'indépendance.$mq$, $mq$medium$mq$),
($mq$Quelle est la différence entre le sujet et le thème d'un récit ?$mq$, $mq$["Il n'y a aucune différence","Le sujet est la fin ; le thème est le début","Le sujet est ce dont parle l'histoire ; le thème est l'idée générale qu'elle développe","Le thème est toujours un nom propre"]$mq$, 2, $mq$Le sujet : « un garçon perd son chien ». Le thème : « la perte et le chagrin ». Le thème est plus abstrait.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Au fil des pages, Maya troquait peu à peu son manteau gris pour des vêtements de couleur. » Que suggère cette évolution ?$mq$, $mq$["Une mode qui passe","Un changement intérieur : de la tristesse vers la confiance ou l'ouverture","Une panne de machine à laver","Une erreur de l'auteur"]$mq$, 1, $mq$Les couleurs symbolisent l'état émotionnel : le passage du gris à la couleur accompagne l'évolution du personnage.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Le pont qui reliait les deux rives était fermé depuis des années ; Léo et son frère ne se parlaient plus non plus. » Quelle interprétation relie le décor au thème ?$mq$, $mq$["Le pont fermé symbolise la rupture entre les frères","Le pont est un détail sans importance","Les frères aiment la construction","Le pont est neuf"]$mq$, 0, $mq$Le parallèle explicite entre le pont fermé et le silence des frères fait du pont un symbole de la séparation.$mq$, $mq$medium$mq$),
($mq$Extrait inventé : « Le héros brûle la lettre. Les cendres retombent dans le jardin, où l'herbe repousse au printemps. » Quelle lecture est la plus nuancée ?$mq$, $mq$["Le héros est un pyromane","L'extrait est une recette","Le jardin est un décor sans importance","Le geste détruit un lien du passé, mais l'herbe qui repousse suggère un renouveau après la perte"]$mq$, 3, $mq$Deux symboles s'opposent : le feu (fin, destruction) et l'herbe (renaissance). La lecture nuancée combine les deux pour dégager un thème : renaître après la perte.$mq$, $mq$hard$mq$),
($mq$Une élève affirme : « L'oiseau en cage symbolise forcément la liberté. » Quelle réserve est la plus juste ?$mq$, $mq$["Un symbole a toujours un seul sens universel","Un oiseau ne peut pas être symbolique","Un symbole dépend du contexte : ici, la cage souligne plutôt la privation de liberté ou l'enfermement","Cela n'a aucun lien avec le thème"]$mq$, 2, $mq$Les symboles sont interprétés selon le contexte du texte. Un oiseau en cage évoque plutôt la contrainte, même si l'oiseau seul peut symboliser la liberté.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Dans la pièce où grandit Zoé, la lumière entrait toujours par une seule petite fenêtre haute. Le jour de son départ, elle ouvrit toutes les persiennes. » Quelle analyse relie lumière et thème ?$mq$, $mq$["La lumière ne change rien au récit","La lumière limitée, puis accueillie, symbolise une émancipation progressive","La fenêtre est décorative","Le thème est la cuisine"]$mq$, 1, $mq$Le passage d'une petite fenêtre haute à toutes les persiennes ouvertes marque le passage d'un espace restreint à une ouverture vers le monde.$mq$, $mq$hard$mq$),
($mq$Quelle structure de réponse est la plus convaincante pour analyser un symbole ?$mq$, $mq$["Nommer le symbole, citer le passage, expliquer ce qu'il représente dans ce contexte, puis relier à un thème du récit","Écrire « c'est un symbole »","Raconter l'histoire entière","Donner une définition de dictionnaire du mot"]$mq$, 0, $mq$Une bonne réponse identifie, prouve, interprète et relie au thème. La seule étiquette « symbole » ne suffit pas.$mq$, $mq$hard$mq$),
($mq$Extrait inventé : « Les voisins ne se saluaient plus. Chaque soir, une lumière s'éteignait, puis une autre : le quartier se vidait de ses fenêtres. » Quel thème peut être dégagé, avec le procédé qui le soutient ?$mq$, $mq$["La joie d'une fête de quartier","L'importance du sport","Le plaisir des vacances","L'isolement croissant d'une communauté, soutenu par la gradation des lumières qui s'éteignent"]$mq$, 3, $mq$Les lumières qui s'éteignent une à une forment une image progressive du repli et de la solitude, étayée par « ne se saluaient plus ».$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Themes and Symbols$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Thème$mq$, $mq$Idée générale explorée par le récit (la perte, la liberté, l'amitié). On la formule en une phrase complète.$mq$),
($mq$Sujet / thème$mq$, $mq$Le sujet : ce dont parle l'histoire. Le thème : l'idée générale qu'elle développe.$mq$),
($mq$Symbole$mq$, $mq$Objet, lieu, couleur ou personnage qui représente une idée plus large que son sens littéral.$mq$),
($mq$Motif$mq$, $mq$Élément qui se répète dans une œuvre (objet, image, mot) et construit du sens en renforçant un thème.$mq$),
($mq$Allégorie$mq$, $mq$Récit dont les éléments représentent des idées abstraites, comme une fable qui illustre une morale.$mq$),
($mq$Symbole et contexte$mq$, $mq$Le sens d'un symbole dépend du texte : il faut l'interpréter selon l'usage qu'en fait l'auteur.$mq$),
($mq$Exemple de symbole$mq$, $mq$Une porte fermée : obstacle ou secret. Une clé : accès, confiance. Une horloge arrêtée : temps suspendu, deuil.$mq$),
($mq$Dégager un thème$mq$, $mq$Observer événements et conflits, repérer les images récurrentes, comparer début et fin, formuler une phrase, prouver par citations.$mq$),
($mq$Analyser un symbole$mq$, $mq$Nommer le symbole, citer le passage, expliquer ce qu'il représente ici, relier à un thème.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Themes and Symbols$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Le sens profond d'un récit
Un récit raconte des événements, mais il dit aussi quelque chose sur la vie, les êtres humains, la société. Cette dimension s'appelle le **thème**. Pour la faire sentir sans l'expliquer directement, l'auteur utilise des **symboles** et des **motifs**. Analyser un thème, c'est passer de l'histoire (« que se passe-t-il ? ») au sens (« que veut-on nous faire comprendre ? »).

## Sujet et thème
Il ne faut pas confondre le **sujet** et le **thème**. Le sujet est ce dont parle l'histoire : « un garçon perd son chien ». Le thème est l'idée générale : « la perte et le chagrin », ou plus précisément « apprendre à accepter l'absence ». Pour formuler un thème, écrivez une phrase complète qui exprime une idée générale, et pas seulement un thème-mot : « La solitude peut pousser à chercher de vrais liens ».
Thèmes fréquents : l'identité, la liberté, l'amitié, la famille, le passage de l'enfance à l'âge adulte, la justice, la mémoire, la nature et la société.

## Symboles et motifs
- Un **symbole** est un objet, un lieu, un personnage ou une couleur qui représente une idée au-delà de son sens littéral. La colombe symbolise la paix, la clé l'accès ou la confiance, la porte fermée un obstacle ou un secret.
- Un **motif** est un élément qui se répète (un objet, une image, un son, un mot) et dont la récurrence construit du sens. Par exemple, la pluie qui revient à chaque scène triste.
- Une **allégorie** est un récit entier dont les éléments représentent des idées abstraites.
Attention : le sens d'un symbole dépend du **contexte**. Un oiseau en cage ne signifie pas toujours la même chose qu'un oiseau libre : il faut regarder comment le texte l'utilise.

## Exemples inventés
- « La vieille horloge s'était arrêtée le jour du départ de Mamie. » L'horloge symbolise le temps suspendu par le deuil.
- « Le seul arbre de la cour, malgré le béton, avait fleuri. » L'arbre représente la vie ou l'espoir qui résiste.
- « Le pont qui reliait les deux rives était fermé depuis des années ; Léo et son frère ne se parlaient plus non plus. » Le pont fermé symbolise la rupture entre les frères, car le texte établit lui-même le parallèle.

## Comment dégager un thème
- **Observer** les événements, les conflits, le dénouement.
- **Repérer** les images, objets et couleurs qui reviennent.
- **Comparer** le début et la fin : qu'a changé ?
- **Formuler** le thème en une phrase générale.
- **Prouver** avec deux citations ou plus.

## Rédiger une analyse symbolique
Utilisez la démarche suivante : **nommer** le symbole, **citer** le passage, **expliquer** ce qu'il représente dans ce contexte, puis **relier** à un thème du récit. Dans l'exemple de Maya qui passe peu à peu d'un manteau gris à des vêtements de couleur, on peut écrire que les couleurs symbolisent un changement intérieur, de la tristesse vers la confiance, ce qui illustre le thème de la reconstruction.

## Erreurs fréquentes
- Confondre thème et résumé de l'histoire.
- Donner un sens universel à un symbole sans tenir compte du contexte.
- Citer un symbole sans l'expliquer.
- Voir des symboles partout : tout objet n'en est pas un, cherchez ceux qui se répètent ou sont mis en valeur.
- Formuler un thème en un seul mot au lieu d'une idée développée.

## Comment cela est évalué
À l'examen, on propose un extrait et la consigne : « Quels thèmes se dégagent de ce passage ? Comment l'auteur les met-il en valeur ? » Le critère A récompense une interprétation justifiée par le texte et par des procédés précis.

Exam tip: ne dites jamais seulement « le thème est la liberté » ; formulez une phrase complète, par exemple « la liberté a un prix », puis appuyez-la avec deux citations expliquées.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('french-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;