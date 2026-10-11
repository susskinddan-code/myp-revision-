-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- French Language & Literature MYP 5 Full eAssessment Mock (110 marks)
with sub as (select id from public.subjects where slug = $mq$french-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French Language & Literature MYP 5 Full eAssessment Mock$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French Language & Literature MYP 5 Full eAssessment Mock$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Texte A (extrait d'une nouvelle, écrit pour cette épreuve)

Dans la gare de Montrevel, le piano était là depuis si longtemps que personne ne se rappelait qui l'avait posé. Un panneau fatigué disait : « Piano en libre service. Merci de ne pas jouer après vingt-deux heures. » Il était vingt-deux heures dix, et Malik, assis sur le tabouret, n'avait pas encore touché une seule touche.

Les derniers voyageurs traversaient le hall en traînant leurs valises, dont les roulettes faisaient sur le carrelage un grondement lointain, comme un orage qui ne se décide pas. Au-dessus des quais, le tableau d'affichage faisait défiler ses lettres orange : RETARD, RETARD, SUPPRIMÉ. Malik regardait ses mains. Elles lui semblaient appartenir à quelqu'un d'autre.

— Tu joues ou tu comptes les touches ? demanda une femme en gilet fluo, un balai à la main.

Il haussa les épaules. Dans sa poche, son téléphone vibrait pour la troisième fois ; sur l'écran s'affichait le prénom de son frère, qu'il n'avait plus prononcé depuis le mois de mars. Son frère avait promis de venir ce soir. Il ne viendrait pas : Malik le savait comme on sait que l'hiver va revenir.

Il posa enfin un doigt sur une touche. La note monta, claire, hésitante, et resta suspendue sous la verrière un long moment, comme si la gare tout entière retenait son souffle pour l'écouter.

Lisez le texte A, puis répondez aux questions.

(a) Relevez deux détails du premier paragraphe qui montrent que le piano est rarement utilisé ou que Malik hésite. (2 marks)

(b) Expliquez ce que le texte suggère des sentiments de Malik envers son frère. (3 marks)

(c) Expliquez comment la femme au balai est présentée. (3 marks)

Total pour la question 1 : 8 marks$mq$, $mq$(a)
[1] One valid detail, e.g. personne ne se rappelait qui l'avait posé ; le panneau est « fatigué » ; Malik n'a pas encore touché une seule touche alors qu'il est déjà vingt-deux heures dix.
[1] A second, different valid detail.
(b)
[1] A valid inference, e.g. Malik is hurt, anxious or disappointed, and he avoids facing the situation.
[1] Supported by reference, e.g. he has not said his brother's name since March; the phone vibrates three times and he does not answer.
[1] Developed comment, e.g. « comme on sait que l'hiver va revenir » shows resignation: he expects his brother not to come.
(c)
[1] Identifies a valid impression: practical, direct, kind, unceremonious.
[1] Supported by quotation or close reference, e.g. « Tu joues ou tu comptes les touches ? » ; « un balai à la main ».
[1] Explains the effect, e.g. her humour and plain speech gently push Malik to act and break his paralysis.
Levels of response guidance: award marks for inference supported by the text, not for retelling.$mq$, $mq$A$mq$),
(2, $mq$Reportez-vous au texte A (l'extrait sur Malik) imprimé à la question 1.

Analysez comment l'auteur utilise le langage et la structure pour créer une impression d'attente, de tension et d'espoir dans cet extrait. (10 marks)

Vous pouvez commenter, par exemple : le décor, les comparaisons, le tableau d'affichage, la longueur des phrases et la fin.

Total pour la question 2 : 10 marks$mq$, $mq$Indicative content (credit any valid, well-supported point):
[1] Setting : a station at night, a forgotten piano and the sign « Merci de ne pas jouer après vingt-deux heures » create rules versus feeling, a tension about whether to act.
[1] The simile « un grondement lointain, comme un orage qui ne se décide pas » : unresolved tension, something about to break.
[1] The departure board « RETARD, RETARD, SUPPRIMÉ » : repetition and escalation mirror hope fading, and foreshadow the brother's absence.
[1] « Elles lui semblaient appartenir à quelqu'un d'autre » : detachment, he feels unable to act.
[1] The phone vibrating a third time and the brother's name unspoken since March : avoidance and buried hurt.
[1] « comme on sait que l'hiver va revenir » : inevitability, calm resignation.
[1] Sentence length : short sentences (« Il haussa les épaules. ») slow the action, and the long final sentence lets the note hang.
[1] The cleaner's question gives a turning point and prepares the action.
[1] The ending : the note « resta suspendue » and the station « retenait son souffle » : personification that turns private grief into shared attention and a small hope.
[1] Overall structure : from static description, to inner life, to a single action, a shape that moves from inertia to release.
Levels of response guidance: Levels 1-2 (1-3 marks) identify features with little explanation; Levels 3-4 (4-6 marks) explain effects with some support; Levels 5-6 (7-10 marks) sustained, precise analysis of language and structure.
Common errors: retelling the story; naming features (simile, personification) without explaining the effect.$mq$, $mq$A$mq$),
(3, $mq$Texte B (un poème, écrit pour cette épreuve)

Cerf-volant

Mon père tenait le fil comme on tient une promesse :
sans serrer trop, sans jamais lâcher.
J'avais neuf ans. Je croyais que le vent lui obéissait.

Aujourd'hui, sur la dune, le vent n'obéit à personne.
Le cerf-volant monte quand même,
rouge, minuscule, un cœur qui bat au bout d'une ficelle.

Je ne sais plus qui, de nous deux, tenait l'autre.
Si je lâche, il part.
Si je tiens, je reste.

Je tiens.

Lisez le texte B (un poème).

(a) Qu'est-ce que le jeune narrateur croyait, à neuf ans, à propos du vent ? (1 mark)

(b) Expliquez ce que la phrase « Je ne sais plus qui, de nous deux, tenait l'autre » suggère de la relation entre le père et son enfant. (3 marks)

(c) Analysez comment le poète utilise les images et la structure pour exprimer la tension entre tenir et lâcher. (6 marks)

Total pour la question 3 : 10 marks$mq$, $mq$(a)
[1] He believed that the wind obeyed his father (« le vent lui obéissait »).
(b)
[1] A valid inference, e.g. the bond was mutual: the father supported the child, but the child also kept the father connected to life.
[1] Supported by reference, e.g. « qui, de nous deux, tenait l'autre » shows that the roles have become blurred.
[1] Developed comment, e.g. the memory is now ambiguous and emotional, suggesting love, loss and dependence.
(c)
[1] The opening simile « comme on tient une promesse » : holding the thread is a loving, careful commitment.
[1] The metaphor « un cœur qui bat au bout d'une ficelle » : the kite is fragile and alive, and linked to the father.
[1] The contrast between the childhood belief and the present (« n'obéit à personne ») : loss of certainty.
[1] The parallel structure « Si je lâche, il part. / Si je tiens, je reste. » : a dilemma between freedom and memory.
[1] The one-line final stanza « Je tiens. » : short, emphatic and resolved; the isolation on the page adds weight.
[1] Visual detail (« rouge, minuscule ») against the vast sky : fragility and persistence.
Levels of response guidance: award marks for explained effects, not for feature-spotting.
Common errors: assuming the father is dead without textual support; ignoring structure.$mq$, $mq$A$mq$),
(4, $mq$Le texte A (l'extrait sur Malik) et le texte B (le poème « Cerf-volant ») sont imprimés plus haut. Reportez-vous aux deux textes.

Comparez la manière dont les auteurs des textes A et B présentent l'absence d'un proche et la difficulté d'agir.

Dans votre réponse, vous devez :
- comparer les idées présentées par chaque auteur
- comparer les choix de langage, de structure ou de forme
- appuyer vos remarques sur de courtes citations. (12 marks)

Total pour la question 4 : 12 marks$mq$, $mq$[1] Identifies absence/loss in Text A (the brother who will not come; the name unspoken since March).
[1] Identifies absence/loss in Text B (the father's guiding hand; the lost certainty of childhood).
[1] A valid similarity, e.g. in both texts an object (le piano ; le cerf-volant) is the focus of a character's struggle with an absent or distant loved one.
[1] A valid difference, e.g. Text A is anxious and unresolved, set in one present moment; Text B looks back from adulthood and arrives at a decision (« Je tiens »).
[1] Quotation from Text A used accurately.
[1] Quotation from Text B used accurately.
[1] Language comparison, e.g. similes from nature (« comme un orage », « comme l'hiver ») versus the extended image of the thread and the heart that beats.
[1] Explains the effect of the language in at least one text.
[1] Structure or form comparison, e.g. third-person narrative ending on a suspended note versus free verse in short stanzas ending on a one-line affirmation.
[1] Explains the effect of structure or form in at least one text.
[1] The comparison is sustained and linked, using connectives such as « alors que », « de même », « tandis que ».
[1] Overall judgement, e.g. both writers suggest that a small gesture (a key pressed, a thread held) is a way of keeping a bond alive.
Levels of response guidance: Levels 1-2 (1-4 marks) separate descriptions with little comparison; Levels 3-4 (5-8 marks) explicit comparison of ideas with some language or structure; Levels 5-6 (9-12 marks) sustained, integrated comparison with precise evidence.
Common errors: writing about each text in turn with no links; comparing only plots.$mq$, $mq$A$mq$),
(5, $mq$Texte C (un article de presse, écrit pour cette épreuve)

SAUVONS LA PISCINE DES ACACIAS
par Rémi Delaunay, chroniqueur

Le soir où la mairie a annoncé la fermeture de la piscine des Acacias, j'y suis allé. J'ai compté les nageurs : vingt-trois. Une dame de quatre-vingts ans faisait ses longueurs avec une élégance de championne ; un groupe d'adolescents apprenait à plonger en riant ; un petit garçon, le visage crispé, lâchait pour la première fois la perche de son moniteur.

La mairie invoque le coût : 120 000 euros par an pour l'entretien. Je ne le conteste pas. Mais combien coûte un enfant qui ne sait pas nager ? Combien coûte une personne âgée qui perd sa seule activité physique ? Ces dépenses-là n'apparaissent dans aucun budget, et pourtant nous les paierons.

Selon les chiffres publiés par la mairie elle-même, 6 % des habitants fréquentent la piscine chaque semaine. Six pour cent, cela peut sembler peu ; c'est pourtant trois mille personnes dans une ville de cinquante mille habitants.

Alors, messieurs les élus, je vous propose un marché : donnez-nous un an. Un an pour inventer des horaires plus malins, des tarifs plus justes, des associations qui s'investissent. Si nous échouons, nous éteindrons nous-mêmes les lumières. Mais ne les éteignez pas avant d'avoir regardé qui nage dans leur reflet.

Lisez le texte C (un article de presse).

(a) Relevez deux faits (et non des opinions) présentés dans l'article. (2 marks)

(b) Expliquez le but de l'anecdote au début de l'article. (2 marks)

(c) Expliquez comment l'auteur répond à l'argument de la mairie sur le coût de la piscine. (4 marks)

Total pour la question 5 : 8 marks$mq$, $mq$(a)
[1] One valid fact, e.g. la mairie a annoncé la fermeture ; l'entretien coûte 120 000 euros par an ; 6 % des habitants fréquentent la piscine chaque semaine ; la ville compte cinquante mille habitants.
[1] A second valid fact (not an opinion).
(b)
[1] Identifies the purpose: to give a concrete, human image before the argument, and to show the writer as a first-hand witness.
[1] Explains the effect, e.g. the varied swimmers (une dame, des adolescents, un petit garçon) create emotional appeal and show that the pool serves everybody.
(c)
[1] Concession : « Je ne le conteste pas » shows the writer is fair and reasonable.
[1] Rhetorical questions : « Mais combien coûte un enfant qui ne sait pas nager ? ».
[1] Reframing : the real costs are social and hidden, « n'apparaissent dans aucun budget ».
[1] Explains the effect : the argument seems balanced yet turns the cost argument against the council; the future tense « nous les paierons » adds a warning.
Accept other valid points supported by the text.$mq$, $mq$A$mq$),
(6, $mq$Reportez-vous de nouveau au texte C (l'article sur la piscine des Acacias), imprimé à la question 5.

Analysez comment l'auteur utilise le langage et la structure pour convaincre les lecteurs que la piscine doit rester ouverte. (10 marks)

Vous pouvez commenter, par exemple : l'ouverture, les faits et les chiffres, les questions rhétoriques, le ton, la structure des paragraphes et la fin.

Total pour la question 6 : 10 marks$mq$, $mq$Indicative content (credit any valid, well-supported point):
[1] The personal anecdotal opening (« j'y suis allé. J'ai compté les nageurs ») gives credibility and a first-hand viewpoint.
[1] Varied, vivid examples (la dame, les adolescents, le petit garçon) create pathos and show who would be harmed.
[1] The concession in the second paragraph (« Je ne le conteste pas ») makes the writer sound reasonable.
[1] Rhetorical questions (« Combien coûte... ? ») force the reader to reconsider the costs.
[1] Repetition of « Combien coûte » : builds rhythm and pressure.
[1] Use of statistics (6 %, 120 000 euros) and their reframing (« trois mille personnes ») : logos and the answer to « cela peut sembler peu ».
[1] The change from « je » to « nous » and the direct address « messieurs les élus » : involves the community and targets decision-makers.
[1] The proposed compromise (« donnez-nous un an ») : constructive tone, practical solution.
[1] The structure : anecdote, objection, evidence, proposal; a clear logical progression.
[1] The final image (« qui nage dans leur reflet ») : memorable ending combining a metaphor and a challenge.
Levels of response guidance: Levels 1-2 (1-3 marks) list devices; Levels 3-4 (4-6 marks) explain effects with examples; Levels 5-6 (7-10 marks) sustained, precise evaluation of how choices persuade.
Common errors: retelling; naming devices without effect.$mq$, $mq$A$mq$),
(7, $mq$Texte D (un texte multimodal : une affiche de quartier, décrite avec des mots)

[Description de l'image : Une photographie occupe les deux tiers supérieurs de l'affiche. Elle montre une fille d'une dizaine d'années, assise sur un muret au crépuscule. Son cartable est posé à côté d'elle, intact. Elle fixe un téléphone dont l'écran éclaire son visage d'une lueur bleutée ; derrière elle, une aire de jeux brille sous les lampadaires, vide.]

Texte en grandes lettres blanches : OÙ ES-TU ?
Texte plus petit, en jaune : Du 4 au 10 novembre, la Semaine sans écran revient au quartier des Lilas. Jeux, ateliers, goûter offert.
Texte en bas, en petits caractères : Entrée libre. Maison des jeunes des Lilas, de 17 h à 19 h. Venez avec vos amis et vos parents.

Lisez le texte D (une affiche).

(a) Relevez deux éléments visuels ou typographiques de l'affiche. (2 marks)

(b) Expliquez comment le titre et la photographie fonctionnent ensemble pour attirer l'attention du public. (3 marks)

(c) Expliquez comment l'organisation de l'affiche (l'ordre et la taille des éléments) aide le lecteur à comprendre le message. (3 marks)

Total pour la question 7 : 8 marks$mq$, $mq$(a)
[1] One valid feature, e.g. grandes lettres blanches ; photographie de fille avec un téléphone ; couleurs bleue et jaune ; aire de jeux vide.
[1] A second, different valid feature.
(b)
[1] The headline is a direct question (« OÙ ES-TU ? ») that addresses the reader as « tu ».
[1] The photograph shows the child absorbed in a screen while the playground is empty : the question and the image suggest what has been lost.
[1] Explains the effect : an emotional hook, a little guilt or worry, that invites the reader to read on.
(c)
[1] The large image and headline come first and catch the eye (visual hierarchy).
[1] The smaller yellow text then gives the event details (dates, activities), so the reader moves from emotion to information.
[1] Practical details at the bottom in small print (lieu, horaires, entrée libre) and the invitation to « vos amis et vos parents » target families and make the message easy to act on.
Accept other valid points on layout and audience.$mq$, $mq$B$mq$),
(8, $mq$Tâche d'écriture 1 : écriture créative

Lisez la description de photographie ci-dessous.

[Description de l'image : Une valise ouverte est posée sur un quai désert. Un manteau rouge est jeté sur la valise, comme si on l'avait abandonné à la hâte. Au fond, un train s'éloigne dans la brume, ses feux arrière encore visibles.]

Rédigez le début d'une nouvelle (environ 350 à 450 mots) qui commence par cette scène. Vous devez :
- créer un cadre et une atmosphère clairs
- développer au moins un personnage
- utiliser une variété de techniques de langage et de structure pour créer des effets. (22 marks)

Les points sont attribués pour la production de texte (8 points), l'organisation des idées et de la structure (6 points) et l'emploi d'une langue précise et efficace (8 points).

Total pour la question 8 : 22 marks$mq$, $mq$Criterion C: producing text
[8] Levels 1-2 (1-3 marks): ideas are limited or generic; little sense of purpose, audience or voice. Levels 3-4 (4-6 marks): clear, sustained ideas with relevant development; some deliberate choices for effect. Levels 5-6 (7-8 marks): original, controlled and convincing; atmosphere and character are convincingly developed; techniques (imagery, sensory detail, pacing, point of view) are used purposefully and linked to the stimulus.
Criterion B: organising
[6] Levels 1-2 (1-2 marks): little structure; ideas are listed or repeated. Levels 3-4 (3-4 marks): clear opening and development with paragraphing and some linking. Levels 5-6 (5-6 marks): shaped, cohesive piece with deliberate structural choices; e.g. a shift in focus, a withheld detail or a hook ending; paragraphs and transitions enhance meaning.
Criterion D: using language
[8] Levels 1-2 (1-3 marks): frequent errors affect meaning; limited vocabulary. Levels 3-4 (4-6 marks): generally accurate spelling, accents, agreement and verb forms; some range of vocabulary and sentence types. Levels 5-6 (7-8 marks): accurate, fluent and varied writing with precise vocabulary and a range of tenses and structures; sentence variety is used for effect; verb tenses (passé simple or passé composé with imparfait) are controlled.
Indicative content: any suitable narrative; accept first or third person. Strong answers might use the abandoned red coat as a symbol of a hurried departure or a secret. Do not reward length for its own sake; writing well below 350 words belongs in the lower part of the level.
Common errors: summarising the whole story rather than writing an opening; listing the objects in the image; clichés such as « c'était une nuit sombre et orageuse » ; inconsistent tenses; anglicisms; missing accents and agreement errors.$mq$, $mq$C$mq$),
(9, $mq$Tâche d'écriture 2 : écriture argumentative

Lisez l'affirmation ci-dessous.

« Les réseaux sociaux font plus de mal que de bien aux adolescents. »

Rédigez un article pour le journal d'un collège ou d'un lycée (environ 400 à 500 mots) dans lequel vous donnez votre avis sur cette affirmation. Vous pouvez être pour, contre ou nuancé, mais vous devez arriver à une conclusion claire. Vous devez :
- exprimer clairement un point de vue
- appuyer vos idées par des exemples et évaluer les arguments opposés
- organiser votre texte pour un public d'adolescents
- employer un langage adapté au but et au public. (22 marks)

Les points sont attribués pour la production de texte (8 points), l'organisation des idées et de la structure (6 points) et l'emploi d'une langue précise et efficace (8 points).

Total pour la question 9 : 22 marks$mq$, $mq$Criterion C: producing text
[8] Levels 1-2 (1-3 marks): ideas are limited or generic; little sense of purpose, audience or voice. Levels 3-4 (4-6 marks): clear, sustained ideas with relevant development; some deliberate choices for effect. Levels 5-6 (7-8 marks): original, controlled and convincing; a convincing, insightful argument with well-chosen evidence and sustained evaluation of counter-arguments; a clear sense of the teenage readership and a deliberate tone.
Criterion B: organising
[6] Levels 1-2 (1-2 marks): little structure; ideas are listed or repeated. Levels 3-4 (3-4 marks): clear opening and development with paragraphing and some linking. Levels 5-6 (5-6 marks): shaped, cohesive piece with deliberate structural choices; e.g. a hook introduction, linked paragraphs, signposting and a memorable conclusion; the conventions of a magazine article (titre, chapeau) used skilfully.
Criterion D: using language
[8] Levels 1-2 (1-3 marks): frequent errors affect meaning; limited vocabulary. Levels 3-4 (4-6 marks): generally accurate spelling, accents, agreement and verb forms; some range of vocabulary and sentence types. Levels 5-6 (7-8 marks): accurate, fluent and varied writing with precise vocabulary and a range of tenses and structures; rhetorical devices (question rhétorique, règle de trois, anecdote, adresse directe) used precisely; a range of connectives and verb forms, including the subjunctive after expressions such as « il faut que » where appropriate.
Indicative content: accept for, against or balanced views; strong answers use concrete examples (sommeil, harcèlement, créativité, amitié, information) and weigh them. Writing significantly below 400 words belongs in the lower part of the level.
Common errors: a list of points with no evaluation; ignoring the opposing view; an overly informal or text-message register; confusing « leur/leurs », « ce/se », « a/à », « ces/ses ».$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
