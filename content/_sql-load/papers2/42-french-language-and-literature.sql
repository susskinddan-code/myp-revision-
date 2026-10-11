-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- French Language & Literature MYP 5 eAssessment-style Practice Paper 1 (44 marks)
with sub as (select id from public.subjects where slug = $mq$french-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French Language & Literature MYP 5 eAssessment-style Practice Paper 1$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French Language & Literature MYP 5 eAssessment-style Practice Paper 1$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Texte A (extrait d'une nouvelle, écrit pour cette épreuve)

Le marché de Saint-Aubin fermait à treize heures, mais dès midi et demi les allées étaient à moitié vides, et l'air sentait le poisson, le melon trop mûr et la bâche mouillée. Théo rangeait les pots de miel dans leur caisse, un par un, sans se presser, comme si chaque pot méritait un adieu.

Derrière l'étal, sa grand-mère pliait la nappe à carreaux : en quatre, puis en huit, puis en seize, avec la patience de quelqu'un qui n'a plus aucune raison de se dépêcher. Cela faisait quarante ans qu'elle vendait ici le miel de ses ruches. Demain, un camion de déménagement viendrait chercher ses meubles.

— Tu n'es pas obligé de rester, dit-elle sans le regarder.

Il ne répondit pas. Il avait préparé un discours pendant toute la semaine : Mamie, ne vends pas la maison. Mais, sur le chemin du marché, les mots s'étaient dissous comme du sucre dans de l'eau chaude, et il ne se rappelait plus comment la phrase commençait.

Un voisin passa avec son chariot, souleva sa casquette et dit simplement : « À jeudi prochain, Odette. » Personne ne corrigea son erreur.

Le dernier pot, celui que Théo avait gardé pour la fin, brillait dans sa main comme un petit soleil mis en bocal.

— Prends-le, dit sa grand-mère. Il parlera mieux que moi.

Théo serra le pot contre sa poitrine. Au-dessus du marché, les cloches de l'église sonnèrent une heure, et il lui sembla qu'elles sonnaient pour quelqu'un d'autre.

Lisez le texte A, puis répondez aux questions.

(a) Relevez deux détails du premier paragraphe qui montrent que le marché touche à sa fin. (2 marks)

(b) Expliquez ce que le texte suggère des sentiments de Théo envers sa grand-mère. (2 marks)$mq$, $mq$(a)
[1] One relevant detail from the first paragraph, e.g. « dès midi et demi les allées étaient à moitié vides » ; le marché ferme à treize heures ; l'air sent le melon trop mûr et la bâche mouillée (fin de journée) ; Théo range les pots un par un.
[1] A second, different relevant detail.
(b)
[1] A valid inference, e.g. Théo est très attaché à sa grand-mère et il est triste ou impuissant devant son départ.
[1] Supported by a reference, e.g. « comme si chaque pot méritait un adieu » ; il ne répond pas ; ses mots « s'étaient dissous comme du sucre dans de l'eau chaude ».
Accept other valid inferences supported by the text.$mq$, $mq$A$mq$),
(2, $mq$Texte A (extrait d'une nouvelle, écrit pour cette épreuve)

Le marché de Saint-Aubin fermait à treize heures, mais dès midi et demi les allées étaient à moitié vides, et l'air sentait le poisson, le melon trop mûr et la bâche mouillée. Théo rangeait les pots de miel dans leur caisse, un par un, sans se presser, comme si chaque pot méritait un adieu.

Derrière l'étal, sa grand-mère pliait la nappe à carreaux : en quatre, puis en huit, puis en seize, avec la patience de quelqu'un qui n'a plus aucune raison de se dépêcher. Cela faisait quarante ans qu'elle vendait ici le miel de ses ruches. Demain, un camion de déménagement viendrait chercher ses meubles.

— Tu n'es pas obligé de rester, dit-elle sans le regarder.

Il ne répondit pas. Il avait préparé un discours pendant toute la semaine : Mamie, ne vends pas la maison. Mais, sur le chemin du marché, les mots s'étaient dissous comme du sucre dans de l'eau chaude, et il ne se rappelait plus comment la phrase commençait.

Un voisin passa avec son chariot, souleva sa casquette et dit simplement : « À jeudi prochain, Odette. » Personne ne corrigea son erreur.

Le dernier pot, celui que Théo avait gardé pour la fin, brillait dans sa main comme un petit soleil mis en bocal.

— Prends-le, dit sa grand-mère. Il parlera mieux que moi.

Théo serra le pot contre sa poitrine. Au-dessus du marché, les cloches de l'église sonnèrent une heure, et il lui sembla qu'elles sonnaient pour quelqu'un d'autre.

Analysez comment l'auteur crée une atmosphère de fin et d'émotion retenue dans ce texte. Vous pouvez commenter, par exemple : le décor, les comparaisons, les gestes de la grand-mère, le silence de Théo et la dernière phrase. (6 marks)$mq$, $mq$[1] Setting and sensory detail (allées vides, odeurs de fin de marché, bâche mouillée) create a tired, fading mood at the end of the day.
[1] Explains the effect of « comme si chaque pot méritait un adieu » : Théo gives ordinary objects the weight of a farewell.
[1] Comments on the repeated folding « en quatre, puis en huit, puis en seize » : slow pace and ritual suggest grief held inside a routine, and the grandmother's calm.
[1] Explains the simile « comme du sucre dans de l'eau chaude » : Théo's words dissolve, so he cannot speak; the image links sweetness with loss.
[1] Comments on the neighbour's mistake (« À jeudi prochain, Odette ») and « Personne ne corrigea son erreur » : the community avoids the truth out of tenderness.
[1] Comments on the ending (le pot comme « un petit soleil mis en bocal » ; les cloches qui sonnent « pour quelqu'un d'autre ») : warmth and detachment, a sense that Théo is already outside his old world.
Award marks for effect, not for feature-spotting. Accept other valid, well-supported points.$mq$, $mq$A$mq$),
(3, $mq$Texte B (un article d'opinion, écrit pour cette épreuve)

DEVANT L'ÉCOLE, ON RESPIRE MAL
par Camille Roux, chroniqueuse

Chaque matin à huit heures vingt, la rue des Tilleuls ressemble à un parking en colère. Des moteurs qui tournent, des klaxons, des parents pressés qui déposent leurs enfants en double file. Nous appelons cela « la circulation du matin », comme s'il s'agissait d'un phénomène naturel, comme la pluie. Ce n'est pas le cas. C'est un choix, et nous le faisons tous les jours.

Les chiffres sont têtus. Selon une étude menée l'an dernier par une association locale, Air Clair, l'air devant les écoles de notre ville contient jusqu'à deux fois plus de particules fines que celui des parcs voisins. Or les enfants, plus petits et plus actifs, respirent plus vite que nous. Faut-il vraiment attendre un drame pour réagir ?

On me répondra que fermer la rue pendant vingt minutes compliquerait la vie des familles. C'est vrai, et je ne le nie pas. Mais combien de minutes perdons-nous déjà dans les embouteillages que nous créons nous-mêmes ? Une rue fermée, c'est aussi un trottoir où l'on marche, où l'on bavarde, où les enfants arrivent réveillés plutôt que stressés.

Alors, à la mairie, je dis ceci : fermez la rue des Tilleuls. Aux parents, je dis : garez-vous plus loin et marchez. Nos enfants n'ont pas besoin de notre voiture ; ils ont besoin de notre exemple.

Lisez le texte B, puis répondez aux questions.

(a) Identifiez le but de cet article et le public visé, en vous appuyant sur le texte. (2 marks)

(b) Expliquez comment la structure de l'article aide l'auteure à convaincre le lecteur. Vous pouvez commenter le titre, l'ouverture, les chiffres, la réponse aux objections et la conclusion. (4 marks)$mq$, $mq$(a)
[1] Purpose: to persuade readers/authorities that the street in front of the school should be closed to cars, supported by e.g. « fermez la rue des Tilleuls ».
[1] Audience: the town hall and parents, supported by the direct address « à la mairie, je dis ceci » / « Aux parents, je dis ».
(b)
[1] The headline and the opening image (« un parking en colère ») engage the reader and state the problem at once.
[1] The statistic from the study and the rhetorical question « Faut-il vraiment attendre un drame ? » add credibility and urgency in the second paragraph.
[1] The concession followed by a rebuttal (« On me répondra... C'est vrai... Mais combien de minutes... ») shows the writer is fair while answering the objection.
[1] The conclusion uses imperatives and a balanced closing sentence (« pas besoin de notre voiture ; ils ont besoin de notre exemple ») to finish with a call to action.
Accept other valid structural points.$mq$, $mq$B$mq$),
(4, $mq$Texte C (un poème, écrit pour cette épreuve)

Retour

Le vent a rangé les feuilles
dans les coins de la cour,
comme on range des lettres
qu'on n'a jamais envoyées.

Mon père lisait le ciel
comme un horaire de train :
pluie à midi, soleil à quatre heures,
les oiseaux ponctuels comme des facteurs.
« Patience », disait-il. « Tout revient. »

Aujourd'hui je marche seul
le long du mur qui fut le sien.
Les feuilles n'ont pas de mémoire.
Moi, j'en ai trop.

Et pourtant, ce soir,
quelqu'un a laissé une lumière
à la fenêtre de la maison vide
— ou peut-être est-ce seulement le couchant
qui joue à se souvenir.

Analysez comment le poète utilise le langage et la structure pour exprimer la mémoire et l'absence. Vous pouvez commenter, par exemple : les images, les comparaisons, la répétition, les temps verbaux et la dernière strophe. (6 marks)$mq$, $mq$[1] Identifies and explains the simile of the leaves « comme on range des lettres qu'on n'a jamais envoyées » : things left unsaid, absence, messages that never arrive.
[1] Explains the comparison of the father reading the sky « comme un horaire de train » and the birds « ponctuels comme des facteurs » : reliability, comfort, a father who made the world seem orderly.
[1] Comments on « Tout revient » and its contrast with the present loss : the father's promise is now uncertain or ironic.
[1] Comments on the antithesis and short sentences « Les feuilles n'ont pas de mémoire. Moi, j'en ai trop. » : emotional emphasis, the speaker is burdened by memory.
[1] Comments on structure or tense : the imperfect (« lisait », « disait ») gives way to the present (« je marche seul »), marking the gap between past and present; or the movement through four stanzas.
[1] Comments on the ending : the light in the empty house and the sunset that « joue à se souvenir » leave hope and doubt in balance (personification, ambiguity).
Accept other valid, well-supported points.$mq$, $mq$A$mq$),
(5, $mq$Texte D (un paragraphe provisoire tiré d'un compte rendu d'élève pour le journal du collège)

La semaine dernière, la chorale du collège a participé à un concours à la salle des fêtes. Les élèves étaient très nerveux, mais leur prestation à été excellente. Le chef de chœur, Monsieur Okoro à dit que c'était le meilleur concert qu'ils avaient jamais donné, et tout le monde était trop content grave. Nous pensons que la chorale sont formidable et nous gagnerons sûrement l'année prochaine. Merci a tous ceux qui nous on soutenus !

Lisez le texte D, puis répondez aux questions.

(a) Relevez trois erreurs de grammaire, d'orthographe ou de ponctuation dans le texte et corrigez-les. (3 marks)

(b) Relevez une expression trop familière pour un journal scolaire et proposez une expression plus soutenue. (1 mark)

(c) Réécrivez la dernière phrase (« Merci a tous ceux qui nous on soutenus ! ») en français correct et dans un registre soutenu. (2 marks)$mq$, $mq$(a) One mark for each error correctly identified AND corrected (maximum three).
[1] First correct identification and correction.
[1] Second correct identification and correction.
[1] Third correct identification and correction.
Acceptable errors: « à été » becomes « a été » ; « Okoro à dit » becomes « Okoro a dit » ; the missing comma after « Okoro » (« Le chef de chœur, Monsieur Okoro, a dit ») ; « la chorale sont » becomes « la chorale est » ; « Merci a » becomes « Merci à » ; « nous on soutenus » becomes « nous ont soutenus ».
(b)
[1] « trop content grave » (or « tout le monde était trop content grave ») is slang; accept « très heureux », « ravi » or « enchanté ».
(c)
[1] Correct spelling and agreement : « à », « ont soutenus » (accept « nous ont soutenus »), no spelling error left.
[1] Formal register, e.g. « Nous remercions chaleureusement tous ceux qui nous ont soutenus. »$mq$, $mq$D$mq$),
(6, $mq$Texte A (extrait d'une nouvelle, écrit pour cette épreuve)

Le marché de Saint-Aubin fermait à treize heures, mais dès midi et demi les allées étaient à moitié vides, et l'air sentait le poisson, le melon trop mûr et la bâche mouillée. Théo rangeait les pots de miel dans leur caisse, un par un, sans se presser, comme si chaque pot méritait un adieu.

Derrière l'étal, sa grand-mère pliait la nappe à carreaux : en quatre, puis en huit, puis en seize, avec la patience de quelqu'un qui n'a plus aucune raison de se dépêcher. Cela faisait quarante ans qu'elle vendait ici le miel de ses ruches. Demain, un camion de déménagement viendrait chercher ses meubles.

— Tu n'es pas obligé de rester, dit-elle sans le regarder.

Il ne répondit pas. Il avait préparé un discours pendant toute la semaine : Mamie, ne vends pas la maison. Mais, sur le chemin du marché, les mots s'étaient dissous comme du sucre dans de l'eau chaude, et il ne se rappelait plus comment la phrase commençait.

Un voisin passa avec son chariot, souleva sa casquette et dit simplement : « À jeudi prochain, Odette. » Personne ne corrigea son erreur.

Le dernier pot, celui que Théo avait gardé pour la fin, brillait dans sa main comme un petit soleil mis en bocal.

— Prends-le, dit sa grand-mère. Il parlera mieux que moi.

Théo serra le pot contre sa poitrine. Au-dessus du marché, les cloches de l'église sonnèrent une heure, et il lui sembla qu'elles sonnaient pour quelqu'un d'autre.

Texte C (un poème, écrit pour cette épreuve)

Retour

Le vent a rangé les feuilles
dans les coins de la cour,
comme on range des lettres
qu'on n'a jamais envoyées.

Mon père lisait le ciel
comme un horaire de train :
pluie à midi, soleil à quatre heures,
les oiseaux ponctuels comme des facteurs.
« Patience », disait-il. « Tout revient. »

Aujourd'hui je marche seul
le long du mur qui fut le sien.
Les feuilles n'ont pas de mémoire.
Moi, j'en ai trop.

Et pourtant, ce soir,
quelqu'un a laissé une lumière
à la fenêtre de la maison vide
— ou peut-être est-ce seulement le couchant
qui joue à se souvenir.

Comparez la manière dont les textes A et C présentent la relation entre un enfant et un proche et le poids du souvenir. (4 marks)$mq$, $mq$[1] A valid similarity, e.g. both show a young person facing a loss or change linked to a family member (la grand-mère, le père) and both leave important things unsaid.
[1] A valid difference, e.g. Text A shows one precise moment as it happens, whereas Text C looks back from the present with a more reflective, melancholy voice.
[1] Compares a technique, e.g. both use a comparison drawn from daily life (« comme du sucre dans de l'eau chaude » ; « comme un horaire de train »), or both use an image of light (le petit soleil du pot ; la lumière à la fenêtre).
[1] Uses a short accurate quotation from each text and the comparison is explicit (« alors que », « de même »).
Accept other valid comparisons.$mq$, $mq$A$mq$),
(7, $mq$Écrivez un discours d'environ 300 mots, destiné à être prononcé devant l'assemblée de votre collège. Vous y soutenez que chaque élève devrait consacrer une heure par semaine au bénévolat, par exemple en aidant une association ou des voisins. Vous devez convaincre à la fois les élèves et les professeurs. (12 marks)

Vous serez évalué(e) sur le but et la conscience du public, la structure de votre discours, vos techniques de persuasion, ainsi que la richesse et la justesse de votre langue.$mq$, $mq$[1] The purpose is clear and sustained: the speech argues a definite position about volunteering.
[1] There is clear awareness of the audience of students and teachers, e.g. direct address with « vous » and « nous ».
[1] The register is appropriate for a spoken school assembly, formal but engaging.
[1] The opening is engaging, e.g. a question, anecdote or striking statement.
[1] The central argument is clear and easy to follow.
[1] Ideas are developed with relevant examples, reasons or evidence.
[1] A range of persuasive techniques is used purposefully, e.g. rhetorical questions, repetition, la règle de trois, emotive language.
[1] An opposing view is acknowledged and answered (e.g. « certains diront que nous manquons de temps... »).
[1] The speech is organised logically in paragraphs with a clear progression of ideas.
[1] Connectives create cohesion (d'abord, en outre, cependant, enfin, c'est pourquoi).
[1] Vocabulary and sentence structures are varied; verb forms, agreement, accents and spelling are mostly accurate.
[1] The conclusion is effective and ends with a memorable call to action.
Credit any valid approach that meets these qualities.$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
