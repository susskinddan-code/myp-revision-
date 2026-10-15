-- Accuracy fixes for language content (French/Spanish/Mandarin ab initio MYP5, French/Spanish/English Language and Literature MYP5, language practice papers).
-- Generated alongside content/fixes/language-review.md. Run in the Supabase SQL editor. Safe to re-run: every statement matches the exact old text, so a second run changes nothing (the three options/answer statements rewrite the same values and report UPDATE 1 again). Tested against a local Postgres loaded with the pre-fix content: 42 statements, each UPDATE 1 on the first run.
-- Question rows are matched by sub-topic + exact old question text. Options/answer updates write the load-time shuffled order
-- (correct option at index (i*3)%4, i = 0-based question index in the sub-topic), exactly as scripts/json-to-sql.mjs stores it.
-- This file does not depend on content/review/languages-fixes.sql having been applied.
-- Paper updates are matched by subject slug + grade + exact paper title + question position.

begin;

-- 1a. french-ab-initio-myp5/02-family-and-friends.json | Family and Friends > Describing People | flashcard 5: back
update public.flashcards f set back = $mq$Those already ending in -e: timide, jeune, mince. Sympa is also invariable (it is short for sympathique). Plural adds -s: timides, sympas.$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where f.topic_id = t.id and s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Describing People$mq$ and p.name = $mq$Family and Friends$mq$
  and f.front = $mq$Adjectives that do not change in the feminine$mq$ and f.back = $mq$Those already ending in -e: timide, jeune, mince, sympa. Plural adds -s: timides, sympas.$mq$;

-- 1b. french-ab-initio-myp5/02-family-and-friends.json | Family and Friends > Describing People | note
update public.notes n set content = replace(n.content, $mq$No change if it already ends in -e: timide, jeune, mince, sympa.$mq$, $mq$No change if it already ends in -e: timide, jeune, mince. Sympa (short for sympathique) is also invariable in the feminine.$mq$)
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where n.topic_id = t.id and s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Describing People$mq$ and p.name = $mq$Family and Friends$mq$
  and position($mq$No change if it already ends in -e: timide, jeune, mince, sympa.$mq$ in n.content) > 0;

-- 2. french-ab-initio-myp5/04-school-and-work.json | School and Work > Classroom Language and Instructions | Q18: content
update public.questions q set content = $mq$Class rules: “1. Levez la main pour parler. 2. Écoutez quand un camarade parle. 3. Ne mangez pas. 4. Travaillez en silence pendant le contrôle.” Léo eats a sandwich and speaks without raising his hand. Which rules does he break?$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Classroom Language and Instructions$mq$ and p.name = $mq$School and Work$mq$
  and q.content = $mq$Class rules: “1. Levez la main pour parler. 2. Écoutez quand un camarade parle. 3. Ne mangez pas. 4. Travaillez en silence pendant le contrôle.” Léo eats a sandwich and speaks without waiting. Which rules does he break?$mq$;

-- 3. french-ab-initio-myp5/05-food-and-shopping.json | Food and Shopping > Food and Drink | Q12: options + answer (stored order, correct option at index 1)
update public.questions q set options = $mq$["du","de","au","des"]$mq$::jsonb, answer = 1
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Food and Drink$mq$ and p.name = $mq$Food and Shopping$mq$
  and q.content = $mq$Complete the sentence: 'Je ne bois pas ___ lait.'$mq$;

-- 4. french-ab-initio-myp5/07-free-time-and-health.json | Free Time and Health > Hobbies and Sports | Q3: options + answer (stored order, correct option at index 2)
update public.questions q set options = $mq$["Je joue à la guitare.","Je fais la guitare.","Je joue de la guitare.","Je joue la guitare."]$mq$::jsonb, answer = 2
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Hobbies and Sports$mq$ and p.name = $mq$Free Time and Health$mq$
  and q.content = $mq$Which sentence means 'I play the guitar'?$mq$;

-- 5. english-language-and-literature-myp5/02-language-techniques.json | Language Techniques > Figurative Language | Q2: options + answer (stored order, correct option at index 3)
update public.questions q set options = $mq$["Simile","Oxymoron","Hyperbole","Personification"]$mq$::jsonb, answer = 3
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$english-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Figurative Language$mq$ and p.name = $mq$Language Techniques$mq$
  and q.content = $mq$"The wind whispered through the trees." Which technique is this?$mq$;

-- 6. english-language-and-literature-myp5/12-language-accuracy.json | Language Accuracy > Grammar, Punctuation and Syntax | Q14: explanation
update public.questions q set explanation = $mq$'Its' (possessive) has no apostrophe, 'their' should be 'they're' or 'it is', and the corrected sentence keeps one consistent singular subject (has ... it is). (British English also allows 'the committee have', but the other choices still contain errors.) The answer fixes every error with consistent agreement.$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$english-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Grammar, Punctuation and Syntax$mq$ and p.name = $mq$Language Accuracy$mq$
  and q.content = $mq$Read this invented sentence: "The committee have made it's decision, and their announcing it tomorrow." Which choice corrects ALL the errors?$mq$ and q.explanation = $mq$'Its' (possessive) has no apostrophe, 'their' should be 'they're/it is', and committee as a unit takes 'has'. The answer fixes every error with consistent agreement.$mq$;

-- 7. spanish-ab-initio-myp5/06-town-and-travel.json | Town and Travel > Asking for and Giving Directions | Q17: explanation
update public.questions q set explanation = $mq$Only one option has the correct direction (derecha), the correct place (rotonda) and the correct second instruction (sigue todo recto). The others change one of the three.$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Asking for and Giving Directions$mq$ and p.name = $mq$Town and Travel$mq$
  and q.content = $mq$Which sentence says 'Turn right at the roundabout and go straight on'?$mq$ and q.explanation = $mq$Only the first option has the correct direction (derecha), the correct place (rotonda) and the correct second instruction (sigue todo recto).$mq$;

-- 8. mandarin-ab-initio-myp5/06-town-and-travel.json | Town and Travel > Places in Town | Q15: explanation
update public.questions q set explanation = $mq$To say where something is, use thing + 在 + place. 有 and 去 do not fit, and 学校附近邮局在 breaks the word order (the place cannot come before the thing).$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Places in Town$mq$ and p.name = $mq$Town and Travel$mq$
  and q.content = $mq$Which sentence correctly says 'The post office is near the school'?$mq$ and q.explanation = $mq$To say where something is, use thing + 在 + place. 有 and 去 do not fit, and the last option breaks the word order.$mq$;

-- 9. mandarin-ab-initio-myp5/06-town-and-travel.json | Town and Travel > Asking for and Giving Directions | Q11: explanation
update public.questions q set explanation = $mq$Only the reply 公园在超市后面 says where the park is: 'behind the supermarket'. The others describe size, opinion and number.$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Asking for and Giving Directions$mq$ and p.name = $mq$Town and Travel$mq$
  and q.content = $mq$Someone asks 请问，公园在哪儿？(Qǐngwèn, gōngyuán zài nǎr?) Which reply gives a location?$mq$ and q.explanation = $mq$Only the last reply says where the park is: 'behind the supermarket'. The others describe size, opinion and number.$mq$;

-- 10. french-ab-initio-myp5/09-eassessment-skills-for-languages.json | eAssessment Skills for Languages > Writing a Short Response | Q14: explanation
update public.questions q set explanation = $mq$The reply that begins 'Merci pour l'invitation ! Oui, je veux bien venir. On se retrouve...' accepts ('je veux bien venir'), suggests a time ('à quinze heures') and asks a question ('Tu apportes quelque chose ?'). The others miss at least one part.$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Writing a Short Response$mq$ and p.name = $mq$eAssessment Skills for Languages$mq$
  and q.content = $mq$Task: you receive an invitation to the cinema. You must accept, suggest a time and ask a question. Which reply covers all three?$mq$ and q.explanation = $mq$The first reply accepts ('je veux bien venir'), suggests a time ('à quinze heures') and asks a question ('Tu apportes quelque chose ?'). The others miss at least one part.$mq$;

-- 11. french-language-and-literature-myp5/05-non-fiction-and-media.json | Non-Fiction and Media > Articles and Speeches | Q8: explanation
update public.questions q set explanation = $mq$La phrase « Le tournoi a réuni 120 élèves samedi » donne un fait chiffré. Les autres contiennent des jugements (« extraordinaire », « absolument », « évidemment »).$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$french-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Articles and Speeches$mq$ and p.name = $mq$Non-Fiction and Media$mq$
  and q.content = $mq$Quelle phrase d'article est la plus objective ?$mq$ and q.explanation = $mq$La première phrase donne un fait chiffré. Les autres contiennent des jugements (« extraordinaire », « absolument », « évidemment »).$mq$;

-- 12. papers-myp5/133-s7-french-ab-initio-paper-b.json | "French ab initio MYP 5 eAssessment Paper B (7 tasks, 64 marks)" | question position 1: mark_scheme
update public.paper_questions pq set mark_scheme = replace(pq.mark_scheme, $mq$[1] Students in year 4 ('quatrième')$mq$, $mq$[1] Students in quatrième (the French year group for ages 13-14)$mq$)
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$french-ab-initio$mq$ and pp.grade = 5 and pp.title = $mq$French ab initio MYP 5 eAssessment Paper B (7 tasks, 64 marks)$mq$
  and pq.position = 1 and position($mq$[1] Students in year 4 ('quatrième')$mq$ in pq.mark_scheme) > 0;

-- 13. papers-myp5/82-spanish-ab-initio-structure-mock-a.json | "Spanish ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 68 marks)" | question position 5: content
update public.paper_questions pq set content = replace(pq.content, $mq$Ana ______ muy simpática.$mq$, $mq$Ana ______ española.$mq$)
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$spanish-ab-initio$mq$ and pp.grade = 5 and pp.title = $mq$Spanish ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 68 marks)$mq$
  and pq.position = 5 and position($mq$Ana ______ muy simpática.$mq$ in pq.content) > 0;

-- 14. papers-myp5/87-spanish-language-and-literature-structure-mock-a.json | "Spanish Language & Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks)" | question position 7: mark_scheme
update public.paper_questions pq set mark_scheme = replace(pq.mark_scheme, $mq$«es importante que» and «creo que no»$mq$, $mq$«es importante que» and «no creo que»$mq$)
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$spanish-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$Spanish Language & Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks)$mq$
  and pq.position = 7 and position($mq$«es importante que» and «creo que no»$mq$ in pq.mark_scheme) > 0;

-- 15. papers-myp5/106-s3-01.json | "English Language and Literature MYP 5 eAssessment Paper A (3 tasks, 80 marks)" | question position 2: content
update public.paper_questions pq set content = replace(pq.content, $mq$Explain the effect of the simile 'a name$mq$, $mq$Explain the effect of the image 'a name$mq$)
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 eAssessment Paper A (3 tasks, 80 marks)$mq$
  and pq.position = 2 and position($mq$Explain the effect of the simile 'a name$mq$ in pq.content) > 0;

-- 16. papers-myp5/106-s3-01.json | "English Language and Literature MYP 5 eAssessment Paper A (3 tasks, 80 marks)" | question position 2: content
update public.paper_questions pq set content = replace(pq.content, $mq$Note: the simile is in stanza two;$mq$, $mq$Note: that image is in stanza two;$mq$)
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 eAssessment Paper A (3 tasks, 80 marks)$mq$
  and pq.position = 2 and position($mq$Note: the simile is in stanza two;$mq$ in pq.content) > 0;

-- 17. papers-myp5/106-s3-01.json | "English Language and Literature MYP 5 eAssessment Paper A (3 tasks, 80 marks)" | question position 2: mark_scheme
update public.paper_questions pq set mark_scheme = replace(pq.mark_scheme, $mq$the image of the language 'rattling in my throat like loose change' links her heritage to something small and worthless in the new place, adding to the sense of shame.$mq$, $mq$the simile 'zipped like a held breath' suggests she is holding in her tension and fear of letting anything slip out, adding to the sense of unease.$mq$)
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 eAssessment Paper A (3 tasks, 80 marks)$mq$
  and pq.position = 2 and position($mq$the image of the language 'rattling in my throat like loose change' links her heritage to something small and worthless in the new place, adding to the sense of shame.$mq$ in pq.mark_scheme) > 0;

-- 18. papers-myp5/106-s3-01.json | "English Language and Literature MYP 5 eAssessment Paper A (3 tasks, 80 marks)" | question position 2: mark_scheme
update public.paper_questions pq set mark_scheme = replace(pq.mark_scheme, $mq$Accept 'zipped like a held breath' as the second image.$mq$, $mq$Accept 'zipped like a held breath' or 'sealed with wax, sweating in the heat of my hand' as the second image.$mq$)
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 eAssessment Paper A (3 tasks, 80 marks)$mq$
  and pq.position = 2 and position($mq$Accept 'zipped like a held breath' as the second image.$mq$ in pq.mark_scheme) > 0;

-- 19. papers-myp5/28-english-language-and-literature-full-mock.json | "English Language and Literature MYP 5 Full eAssessment Mock" | question position 1: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$(a)
[1] One valid detail, e.g. the ferry does not run at all in the weeks after Christmas; it runs only once a day in winter; Tobias watches the grey water 'as if it might change its mind' because he already knows the ferry is not running.
[1] A second, different valid detail.
(b)
[1] A valid inference, e.g. the relationship is close and has been important to Tobias; he feels worry or loss now the letters have stopped.
[1] Supported by a reference, e.g. 'stopped writing letters' / he has read the last letter so often that its sentences 'had worn smooth, like pebbles'.
[1] Developed comment on the effect or a second linked point, e.g. the lamp image suggests his grandfather's steadiness or a message of hope.
(c)
[1] Identifies a valid impression: tired, indifferent, resigned, blunt but not unkind.
[1] Supported by quotation or close reference, e.g. 'He did not look up'; 'the flatness of someone who has said the same thing to many people'.
[1] Explains the effect, e.g. shows that refusals are routine, which makes Tobias's wish to cross seem lonely or hopeless.
Band guidance: award marks for inference supported by text, not for retelling. Do not credit a quotation on its own.
Common errors: paraphrasing the story instead of inferring; giving two versions of the same detail in (a); naming a technique with no effect.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 1 and pq.mark_scheme = $mq$(a)
[1] One valid detail, e.g. the ferry does not run at all in the weeks after Christmas; it runs only once a day in winter; Tobias watches the grey water 'as if it might change its mind' because he already knows the ferry is not running.
[1] A second, different valid detail.
(b)
[1] A valid inference, e.g. the relationship is close and has been important to Tobias; he feels worry or loss now the letters have stopped.
[1] Supported by a reference, e.g. 'stopped writing letters' / he has read the last letter so often that its sentences 'had worn smooth, like pebbles'.
[1] Developed comment on the effect or a second linked point, e.g. the lamp image suggests his grandfather's steadiness or a message of hope.
(c)
[1] Identifies a valid impression: tired, indifferent, resigned, blunt but not unkind.
[1] Supported by quotation or close reference, e.g. 'He did not look up'; 'the flatness of someone who has said the same thing to many people'.
[1] Explains the effect, e.g. shows that refusals are routine, which makes Tobias's wish to cross seem lonely or hopeless.
Levels of response guidance: award marks for inference supported by text, not for retelling. Do not credit a quotation on its own.
Common errors: paraphrasing the story instead of inferring; giving two versions of the same detail in (a); naming a technique with no effect.$mq$;

-- 19. papers-myp5/28-english-language-and-literature-full-mock.json | "English Language and Literature MYP 5 Full eAssessment Mock" | question position 2: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$Indicative content (credit any valid, well-supported point):
[1] Setting and pathetic fallacy: grey water, drizzle and the island 'half-erased' suggest that what Tobias wants is fading and out of reach.
[1] The personification of the water ('as if it might change its mind') shows Tobias's hopeful but irrational thinking.
[1] The gulls (sleeping; one 'hung for a moment on nothing') suggest freedom and emptiness, contrasting with Tobias's being stuck.
[1] The simile 'worn smooth, like pebbles' shows repeated reading and emotional attachment; links to the sea setting.
[1] The motif of the lamp ('The lamp still turns...') acts as a symbol of constancy and hope, and gives the extract thematic unity.
[1] Contrast between the factual first sentence and the emotional second paragraph shows a shift from information to feeling.
[1] The dialogue of the man on the quay is short and final, contrasting with Tobias's silence.
[1] Sentence variety: a long, flowing first sentence suggests the routine of the ferry; the short final sentence creates tension.
[1] The ending is open: the step into cold water is a symbolic act of defiance but nothing is resolved, which sustains uncertainty.
[1] Overall judgement about how these choices work together, with precise terminology.
Band guidance: Band 1 (1-3 marks) identifies features with limited comment; Band 2 (4-7 marks) explains effects with evidence; Band 3 (8-10 marks) analyses how choices combine to develop the extract's ideas, with precise terminology and quotations.
Common errors: narrating the plot; naming techniques (e.g. 'personification') without effects; treating the ending as resolved.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 2 and pq.mark_scheme = $mq$Indicative content (credit any valid, well-supported point):
[1] Setting and pathetic fallacy: grey water, drizzle and the island 'half-erased' suggest that what Tobias wants is fading and out of reach.
[1] The personification of the water ('as if it might change its mind') shows Tobias's hopeful but irrational thinking.
[1] The gulls (sleeping; one 'hung for a moment on nothing') suggest freedom and emptiness, contrasting with Tobias's being stuck.
[1] The simile 'worn smooth, like pebbles' shows repeated reading and emotional attachment; links to the sea setting.
[1] The motif of the lamp ('The lamp still turns...') acts as a symbol of constancy and hope, and gives the extract thematic unity.
[1] Contrast between the factual first sentence and the emotional second paragraph shows a shift from information to feeling.
[1] The dialogue of the man on the quay is short and final, contrasting with Tobias's silence.
[1] Sentence variety: a long, flowing first sentence suggests the routine of the ferry; the short final sentence creates tension.
[1] The ending is open: the step into cold water is a symbolic act of defiance but nothing is resolved, which sustains uncertainty.
[1] Overall judgement about how these choices work together, with precise terminology.
Levels of response guidance: Level 1-2 (1-3 marks) identifies features with limited comment; Level 3-4 (4-7 marks) explains effects with evidence; Level 5-6 (8-10 marks) analyses how choices combine to develop the extract's ideas, with precise terminology and quotations.
Common errors: narrating the plot; naming techniques (e.g. 'personification') without effects; treating the ending as resolved.$mq$;

-- 19. papers-myp5/28-english-language-and-literature-full-mock.json | "English Language and Literature MYP 5 Full eAssessment Mock" | question position 3: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$(a)
[1] Fish (the speaker 'thought she meant fish').
(b)
[1] A valid inference, e.g. the memory is vivid and sensory but is fading or slipping away.
[1] Supported by reference, e.g. the taste of wind on the platform brings her back suddenly; the jar is 'lost'.
[1] Developed comment, e.g. the mother's wisdom was only understood with age; the loss is gentle rather than bitter.
(c)
[1] Identifies the salt simile 'like salt: small, bright, and impossible to hold'.
[1] Explains that salt suggests something precious yet impossible to keep.
[1] Identifies another image, e.g. 'the whole slow tide of her voice' (tide as a repeated, comforting rhythm; a metaphor linking voice to the sea).
[1] Explains its effect, e.g. the voice seems large, natural and gradual, which links to the opening idea of the sea.
[1] Comment on how the imagery connects to the poem as a whole (the sea, the jar, the giving and taking in the first stanza) or on the effect of the colon and list of adjectives.
[1] Precise use of terminology and quotation within an analytical line of argument.
Band guidance for (c): Band 1 (1-2 marks) feature spotting or retelling; Band 2 (3-4 marks) explains effects of one or two images with relevant quotation; Band 3 (5-6 marks) analyses how images work together and links to the poem's ideas, with precise terminology.
Common errors: calling any comparison a metaphor; listing devices without effects; treating the poem as being about cooking or about the sea literally.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 3 and pq.mark_scheme = $mq$(a)
[1] Fish (the speaker 'thought she meant fish').
(b)
[1] A valid inference, e.g. the memory is vivid and sensory but is fading or slipping away.
[1] Supported by reference, e.g. the taste of wind on the platform brings her back suddenly; the jar is 'lost'.
[1] Developed comment, e.g. the mother's wisdom was only understood with age; the loss is gentle rather than bitter.
(c)
[1] Identifies the salt simile 'like salt: small, bright, and impossible to hold'.
[1] Explains that salt suggests something precious yet impossible to keep.
[1] Identifies another image, e.g. 'the whole slow tide of her voice' (tide as a repeated, comforting rhythm; a metaphor linking voice to the sea).
[1] Explains its effect, e.g. the voice seems large, natural and gradual, which links to the opening idea of the sea.
[1] Comment on how the imagery connects to the poem as a whole (the sea, the jar, the giving and taking in the first stanza) or on the effect of the colon and list of adjectives.
[1] Precise use of terminology and quotation within an analytical line of argument.
Levels of response guidance for (c): Level 1-2 (1-2 marks) feature spotting or retelling; Level 3-4 (3-4 marks) explains effects of one or two images with relevant quotation; Level 5-6 (5-6 marks) analyses how images work together and links to the poem's ideas, with precise terminology.
Common errors: calling any comparison a metaphor; listing devices without effects; treating the poem as being about cooking or about the sea literally.$mq$;

-- 19. papers-myp5/28-english-language-and-literature-full-mock.json | "English Language and Literature MYP 5 Full eAssessment Mock" | question position 4: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$[1] Identifies loss in Text A (the grandfather's silence, the unreachable island).
[1] Identifies loss in Text B (the mother, the lost jar, the vanished kitchen).
[1] Valid point of similarity, e.g. both link an ordinary object (letter; jar) to a person who is absent.
[1] Valid point of difference, e.g. Text A is unresolved and anxious as the action happens in the present; Text B is reflective and looks back from adulthood.
[1] Quotation from Text A used accurately.
[1] Quotation from Text B used accurately.
[1] Language comparison, e.g. Text A's similes ('worn smooth, like pebbles') and Text B's simile ('like salt') both use natural images, but one shows repetition and the other shows fading.
[1] Explains the effect of the language in at least one text.
[1] Structure or form comparison, e.g. third person narrative building to a physical step into the water versus a free verse lyric with a first person voice and a shift from past to present.
[1] Explains the effect of structure or form in at least one text.
[1] Comparison is sustained and linked, using connectives such as 'whereas' and 'similarly' with developed points.
[1] Overall judgement or synthesis, e.g. both writers suggest the past cannot be fully recovered but remains alive in objects and words.
Band guidance: Band 1 (1-4 marks) separate descriptions of each text with little comparison; Band 2 (5-8 marks) explicit comparison of ideas with some language or structure; Band 3 (9-12 marks) sustained, integrated comparison of ideas and writers' choices with precise evidence.
Common errors: writing about each text in turn with no links; comparing only the plots; quotations with no comment on effect.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 4 and pq.mark_scheme = $mq$[1] Identifies loss in Text A (the grandfather's silence, the unreachable island).
[1] Identifies loss in Text B (the mother, the lost jar, the vanished kitchen).
[1] Valid point of similarity, e.g. both link an ordinary object (letter; jar) to a person who is absent.
[1] Valid point of difference, e.g. Text A is unresolved and anxious as the action happens in the present; Text B is reflective and looks back from adulthood.
[1] Quotation from Text A used accurately.
[1] Quotation from Text B used accurately.
[1] Language comparison, e.g. Text A's similes ('worn smooth, like pebbles') and Text B's simile ('like salt') both use natural images, but one shows repetition and the other shows fading.
[1] Explains the effect of the language in at least one text.
[1] Structure or form comparison, e.g. third person narrative building to a physical step into the water versus a free verse lyric with a first person voice and a shift from past to present.
[1] Explains the effect of structure or form in at least one text.
[1] Comparison is sustained and linked, using connectives such as 'whereas' and 'similarly' with developed points.
[1] Overall judgement or synthesis, e.g. both writers suggest the past cannot be fully recovered but remains alive in objects and words.
Levels of response guidance: Level 1-2 (1-4 marks) separate descriptions of each text with little comparison; Level 3-4 (5-8 marks) explicit comparison of ideas with some language or structure; Level 5-6 (9-12 marks) sustained, integrated comparison of ideas and writers' choices with precise evidence.
Common errors: writing about each text in turn with no links; comparing only the plots; quotations with no comment on effect.$mq$;

-- 19. papers-myp5/28-english-language-and-literature-full-mock.json | "English Language and Literature MYP 5 Full eAssessment Mock" | question position 5: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$(a)
[1] One valid fact, e.g. the library will close on weekday evenings from January; evening opening costs 38,000 pounds a year; 4 per cent of residents visit after five o'clock.
[1] A second valid fact (not an opinion).
(b)
[1] Valid purpose, e.g. to give concrete, human examples before making an argument.
[1] Reference to the examples, e.g. the job applicant, the sisters who need warmth, the reading club.
[1] Explains the effect, e.g. creates sympathy and shows the range of people who rely on the library, which counters the low-percentage statistic.
(c)
[1] Purpose: to persuade or call readers to action.
[1] Audience: local residents / readers of the paper (and by extension councillors).
[1] Evidence, e.g. imperatives such as 'Write to your councillor', the direct address 'readers', the inclusive 'Let us'.
Band guidance: do not credit opinions in (a). In (b) the second and third marks require reference to the text.
Common errors: copying statistics as if they were explanation; saying the audience is 'everyone'; confusing purpose with topic.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 5 and pq.mark_scheme = $mq$(a)
[1] One valid fact, e.g. the library will close on weekday evenings from January; evening opening costs 38,000 pounds a year; 4 per cent of residents visit after five o'clock.
[1] A second valid fact (not an opinion).
(b)
[1] Valid purpose, e.g. to give concrete, human examples before making an argument.
[1] Reference to the examples, e.g. the job applicant, the sisters who need warmth, the reading club.
[1] Explains the effect, e.g. creates sympathy and shows the range of people who rely on the library, which counters the low-percentage statistic.
(c)
[1] Purpose: to persuade or call readers to action.
[1] Audience: local residents / readers of the paper (and by extension councillors).
[1] Evidence, e.g. imperatives such as 'Write to your councillor', the direct address 'readers', the inclusive 'Let us'.
Levels of response guidance: do not credit opinions in (a). In (b) the second and third marks require reference to the text.
Common errors: copying statistics as if they were explanation; saying the audience is 'everyone'; confusing purpose with topic.$mq$;

-- 19. papers-myp5/28-english-language-and-literature-full-mock.json | "English Language and Literature MYP 5 Full eAssessment Mock" | question position 6: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$Indicative content (credit any valid, well-supported point):
[1] Personal, anecdotal opening ('I counted the people inside it') gives credibility as a first-hand witness.
[1] Specific, varied examples create emotional appeal (pathos) and show the library's range.
[1] Concession and reframing of statistics ('Both figures are accurate. Neither is the whole truth.') shows fairness while undermining the council's case; short sentences give emphasis.
[1] Analogy of the fire station: explains that value is not measured by use, an effective argument by comparison.
[1] Tricolon / parallel structure in 'the application not abandoned, the exam not failed, the afternoon of loneliness' builds a cumulative effect.
[1] Rhetorical question ('Surely that is a question of priorities, not budgets?') invites agreement and implies the council is at fault; contrast of 2.4 million pounds with 'a few lamps'.
[1] Structure: moves from anecdote to evidence to rebuttal to appeal, so the argument is built logically before the call to action.
[1] Imperatives and inclusive pronouns ('Write', 'Let us') in the closing paragraphs make readers feel responsible.
[1] Circular ending: the lights image echoes the title and gives a hopeful, memorable close.
[1] Overall evaluation of how the combination of techniques works, using precise terminology.
Band guidance: Band 1 (1-3 marks) identifies features with little comment; Band 2 (4-7 marks) explains the effects of a range of language and structural features with evidence; Band 3 (8-10 marks) analyses how techniques work together to shape the reader's response, with precise terminology and well-chosen quotation.
Common errors: listing techniques without effects; calling facts 'statistics' when they are not; discussing only the content of the argument; ignoring structure.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 6 and pq.mark_scheme = $mq$Indicative content (credit any valid, well-supported point):
[1] Personal, anecdotal opening ('I counted the people inside it') gives credibility as a first-hand witness.
[1] Specific, varied examples create emotional appeal (pathos) and show the library's range.
[1] Concession and reframing of statistics ('Both figures are accurate. Neither is the whole truth.') shows fairness while undermining the council's case; short sentences give emphasis.
[1] Analogy of the fire station: explains that value is not measured by use, an effective argument by comparison.
[1] Tricolon / parallel structure in 'the application not abandoned, the exam not failed, the afternoon of loneliness' builds a cumulative effect.
[1] Rhetorical question ('Surely that is a question of priorities, not budgets?') invites agreement and implies the council is at fault; contrast of 2.4 million pounds with 'a few lamps'.
[1] Structure: moves from anecdote to evidence to rebuttal to appeal, so the argument is built logically before the call to action.
[1] Imperatives and inclusive pronouns ('Write', 'Let us') in the closing paragraphs make readers feel responsible.
[1] Circular ending: the lights image echoes the title and gives a hopeful, memorable close.
[1] Overall evaluation of how the combination of techniques works, using precise terminology.
Levels of response guidance: Level 1-2 (1-3 marks) identifies features with little comment; Level 3-4 (4-7 marks) explains the effects of a range of language and structural features with evidence; Level 5-6 (8-10 marks) analyses how techniques work together to shape the reader's response, with precise terminology and well-chosen quotation.
Common errors: listing techniques without effects; calling facts 'statistics' when they are not; discussing only the content of the argument; ignoring structure.$mq$;

-- 19. papers-myp5/28-english-language-and-literature-full-mock.json | "English Language and Literature MYP 5 Full eAssessment Mock" | question position 7: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$(a)
[1] One valid feature, e.g. large white capital letters; a striking photograph of a boy in a floodlit empty pitch; the use of blue and yellow colours.
[1] A second, different valid feature.
(b)
[1] Headline uses a bold statement and a direct question ('WHERE ARE YOU?') that addresses the reader personally and creates a slightly challenging tone.
[1] Sub-heading answers the question practically: 'Free. No experience needed.' removes barriers; short fragments are easy to read.
[1] Explains the combined effect: the headline creates emotional pull and the sub-heading makes the action seem easy and welcoming.
(c)
[1] Layout moves top to bottom: image (emotional hook) then headline then sub-heading then practical detail.
[1] Body text is separated into columns, with the left giving benefits and the right giving details, so information is easy to scan; the dark background makes it stand out.
[1] The call to action (scan, text KICK) is placed last and the crest and slogan close the poster with a sense of belonging.
Band guidance: marks in (b) and (c) need an explanation of effect; description of the poster alone gains at most one mark per part.
Common errors: describing the poster without linking features to purpose; confusing headline and sub-heading; ignoring the image.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 7 and pq.mark_scheme = $mq$(a)
[1] One valid feature, e.g. large white capital letters; a striking photograph of a boy in a floodlit empty pitch; the use of blue and yellow colours.
[1] A second, different valid feature.
(b)
[1] Headline uses a bold statement and a direct question ('WHERE ARE YOU?') that addresses the reader personally and creates a slightly challenging tone.
[1] Sub-heading answers the question practically: 'Free. No experience needed.' removes barriers; short fragments are easy to read.
[1] Explains the combined effect: the headline creates emotional pull and the sub-heading makes the action seem easy and welcoming.
(c)
[1] Layout moves top to bottom: image (emotional hook) then headline then sub-heading then practical detail.
[1] Body text is separated into columns, with the left giving benefits and the right giving details, so information is easy to scan; the dark background makes it stand out.
[1] The call to action (scan, text KICK) is placed last and the crest and slogan close the poster with a sense of belonging.
Levels of response guidance: marks in (b) and (c) need an explanation of effect; description of the poster alone gains at most one mark per part.
Common errors: describing the poster without linking features to purpose; confusing headline and sub-heading; ignoring the image.$mq$;

-- 19. papers-myp5/28-english-language-and-literature-full-mock.json | "English Language and Literature MYP 5 Full eAssessment Mock" | question position 8: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$Criterion C: producing text
[8] Band 1 (1-3 marks): ideas are limited or generic; little control of voice or atmosphere. Band 2 (4-6 marks): clear, sustained idea with a developed setting and character; some deliberate choices of technique for effect. Band 3 (7-8 marks): original, controlled and engaging opening; atmosphere and character convincingly developed; techniques (imagery, sensory detail, pacing, perspective) used purposefully and linked to the stimulus.
Criterion B: organising
[6] Band 1 (1-2 marks): little structure, ideas are listed or repeated. Band 2 (3-4 marks): clear opening and development with paragraphing and some variation in pace. Band 3 (5-6 marks): shaped, cohesive piece with deliberate structural choices (e.g. a shift in focus, a withheld detail, a hook ending); paragraphs and transitions enhance meaning.
Criterion D: using language
[8] Band 1 (1-3 marks): frequent errors affect clarity; limited vocabulary. Band 2 (4-6 marks): generally accurate spelling, punctuation and grammar; some range of vocabulary and sentence types. Band 3 (7-8 marks): accurate, fluent and varied writing with precise vocabulary; sentence variety used for effect.
Indicative content: any suitable narrative; accept first or third person; strong answers might use the still-turning wheel as a symbol of a sudden departure or an interruption. Do not reward length for its own sake; writing significantly below 450 words should be placed in the lower part of the level.
Common errors: summarising the whole story rather than an opening; listing the items in the image; clichés such as 'it was a dark and stormy night'; inconsistent tense.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 8 and pq.mark_scheme = $mq$Criterion C: producing text
[8] Level 1-2 (1-3 marks): ideas are limited or generic; little control of voice or atmosphere. Level 3-4 (4-6 marks): clear, sustained idea with a developed setting and character; some deliberate choices of technique for effect. Level 5-6 (7-8 marks): original, controlled and engaging opening; atmosphere and character convincingly developed; techniques (imagery, sensory detail, pacing, perspective) used purposefully and linked to the stimulus.
Criterion B: organising
[6] Level 1-2 (1-2 marks): little structure, ideas are listed or repeated. Level 3-4 (3-4 marks): clear opening and development with paragraphing and some variation in pace. Level 5-6 (5-6 marks): shaped, cohesive piece with deliberate structural choices (e.g. a shift in focus, a withheld detail, a hook ending); paragraphs and transitions enhance meaning.
Criterion D: using language
[8] Level 1-2 (1-3 marks): frequent errors affect clarity; limited vocabulary. Level 3-4 (4-6 marks): generally accurate spelling, punctuation and grammar; some range of vocabulary and sentence types. Level 5-6 (7-8 marks): accurate, fluent and varied writing with precise vocabulary; sentence variety used for effect.
Indicative content: any suitable narrative; accept first or third person; strong answers might use the still-turning wheel as a symbol of a sudden departure or an interruption. Do not reward length for its own sake; writing significantly below 450 words should be placed in the lower part of the level.
Common errors: summarising the whole story rather than an opening; listing the items in the image; clichés such as 'it was a dark and stormy night'; inconsistent tense.$mq$;

-- 19. papers-myp5/28-english-language-and-literature-full-mock.json | "English Language and Literature MYP 5 Full eAssessment Mock" | question position 9: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$Criterion C: producing text
[8] Band 1 (1-3 marks): ideas are simple or assertions without support; limited awareness of purpose and audience. Band 2 (4-6 marks): relevant, developed points with some examples; viewpoint is clear; some evaluation of an opposing view. Band 3 (7-8 marks): convincing, insightful argument with well-chosen evidence and sustained evaluation of counter-arguments; clear sense of the magazine audience and a deliberate tone.
Criterion B: organising
[6] Band 1 (1-2 marks): limited organisation; ideas not grouped. Band 2 (3-4 marks): recognisable article features (headline, introduction, paragraphs, conclusion) and logical order. Band 3 (5-6 marks): purposeful structure, such as a hook introduction, linked paragraphs, signposting and a memorable conclusion; conventions of the article form used skilfully.
Criterion D: using language
[8] Band 1 (1-3 marks): frequent errors; informal or repetitive language. Band 2 (4-6 marks): generally accurate and clear; register is mostly appropriate; some rhetorical devices. Band 3 (7-8 marks): fluent, precise and varied; rhetorical devices (e.g. rhetorical questions, tricolon, anecdote, direct address) used for effect; consistently controlled register.
Indicative content: accept any position. Possible points for: reduces inequality when home conditions differ; improves rest and wellbeing; teachers can help in real time. Possible points against: removes independence and time management skills; shortens the lessons or the school day; some tasks need reflection at home. Strong answers consider the counter-argument rather than ignoring it.
Common errors: a list of points with no evaluation; no conclusion; shifting between formal and chatty registers; copying phrases from Text C without adapting them.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 9 and pq.mark_scheme = $mq$Criterion C: producing text
[8] Level 1-2 (1-3 marks): ideas are simple or assertions without support; limited awareness of purpose and audience. Level 3-4 (4-6 marks): relevant, developed points with some examples; viewpoint is clear; some evaluation of an opposing view. Level 5-6 (7-8 marks): convincing, insightful argument with well-chosen evidence and sustained evaluation of counter-arguments; clear sense of the magazine audience and a deliberate tone.
Criterion B: organising
[6] Level 1-2 (1-2 marks): limited organisation; ideas not grouped. Level 3-4 (3-4 marks): recognisable article features (headline, introduction, paragraphs, conclusion) and logical order. Level 5-6 (5-6 marks): purposeful structure, such as a hook introduction, linked paragraphs, signposting and a memorable conclusion; conventions of the article form used skilfully.
Criterion D: using language
[8] Level 1-2 (1-3 marks): frequent errors; informal or repetitive language. Level 3-4 (4-6 marks): generally accurate and clear; register is mostly appropriate; some rhetorical devices. Level 5-6 (7-8 marks): fluent, precise and varied; rhetorical devices (e.g. rhetorical questions, tricolon, anecdote, direct address) used for effect; consistently controlled register.
Indicative content: accept any position. Possible points for: reduces inequality when home conditions differ; improves rest and wellbeing; teachers can help in real time. Possible points against: removes independence and time management skills; shortens the lessons or the school day; some tasks need reflection at home. Strong answers consider the counter-argument rather than ignoring it.
Common errors: a list of points with no evaluation; no conclusion; shifting between formal and chatty registers; copying phrases from Text C without adapting them.$mq$;

-- 19. papers-myp5/44-french-language-and-literature-full-mock.json | "French Language & Literature MYP 5 Full eAssessment Mock" | question position 1: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$(a)
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
Band guidance: award marks for inference supported by the text, not for retelling.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$french-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$French Language & Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 1 and pq.mark_scheme = $mq$(a)
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
Levels of response guidance: award marks for inference supported by the text, not for retelling.$mq$;

-- 19. papers-myp5/44-french-language-and-literature-full-mock.json | "French Language & Literature MYP 5 Full eAssessment Mock" | question position 2: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$Indicative content (credit any valid, well-supported point):
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
Band guidance: Band 1 (1-3 marks) identify features with little explanation; Band 2 (4-6 marks) explain effects with some support; Band 3 (7-10 marks) sustained, precise analysis of language and structure.
Common errors: retelling the story; naming features (simile, personification) without explaining the effect.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$french-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$French Language & Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 2 and pq.mark_scheme = $mq$Indicative content (credit any valid, well-supported point):
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
Common errors: retelling the story; naming features (simile, personification) without explaining the effect.$mq$;

-- 19. papers-myp5/44-french-language-and-literature-full-mock.json | "French Language & Literature MYP 5 Full eAssessment Mock" | question position 3: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$(a)
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
Band guidance: award marks for explained effects, not for feature-spotting.
Common errors: assuming the father is dead without textual support; ignoring structure.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$french-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$French Language & Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 3 and pq.mark_scheme = $mq$(a)
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
Common errors: assuming the father is dead without textual support; ignoring structure.$mq$;

-- 19. papers-myp5/44-french-language-and-literature-full-mock.json | "French Language & Literature MYP 5 Full eAssessment Mock" | question position 4: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$[1] Identifies absence/loss in Text A (the brother who will not come; the name unspoken since March).
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
Band guidance: Band 1 (1-4 marks) separate descriptions with little comparison; Band 2 (5-8 marks) explicit comparison of ideas with some language or structure; Band 3 (9-12 marks) sustained, integrated comparison with precise evidence.
Common errors: writing about each text in turn with no links; comparing only plots.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$french-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$French Language & Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 4 and pq.mark_scheme = $mq$[1] Identifies absence/loss in Text A (the brother who will not come; the name unspoken since March).
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
Common errors: writing about each text in turn with no links; comparing only plots.$mq$;

-- 19. papers-myp5/44-french-language-and-literature-full-mock.json | "French Language & Literature MYP 5 Full eAssessment Mock" | question position 6: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$Indicative content (credit any valid, well-supported point):
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
Band guidance: Band 1 (1-3 marks) list devices; Band 2 (4-6 marks) explain effects with examples; Band 3 (7-10 marks) sustained, precise evaluation of how choices persuade.
Common errors: retelling; naming devices without effect.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$french-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$French Language & Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 6 and pq.mark_scheme = $mq$Indicative content (credit any valid, well-supported point):
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
Common errors: retelling; naming devices without effect.$mq$;

-- 19. papers-myp5/44-french-language-and-literature-full-mock.json | "French Language & Literature MYP 5 Full eAssessment Mock" | question position 8: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$Criterion C: producing text
[8] Band 1 (1-3 marks): ideas are limited or generic; little sense of purpose, audience or voice. Band 2 (4-6 marks): clear, sustained ideas with relevant development; some deliberate choices for effect. Band 3 (7-8 marks): original, controlled and convincing; atmosphere and character are convincingly developed; techniques (imagery, sensory detail, pacing, point of view) are used purposefully and linked to the stimulus.
Criterion B: organising
[6] Band 1 (1-2 marks): little structure; ideas are listed or repeated. Band 2 (3-4 marks): clear opening and development with paragraphing and some linking. Band 3 (5-6 marks): shaped, cohesive piece with deliberate structural choices; e.g. a shift in focus, a withheld detail or a hook ending; paragraphs and transitions enhance meaning.
Criterion D: using language
[8] Band 1 (1-3 marks): frequent errors affect meaning; limited vocabulary. Band 2 (4-6 marks): generally accurate spelling, accents, agreement and verb forms; some range of vocabulary and sentence types. Band 3 (7-8 marks): accurate, fluent and varied writing with precise vocabulary and a range of tenses and structures; sentence variety is used for effect; verb tenses (passé simple or passé composé with imparfait) are controlled.
Indicative content: any suitable narrative; accept first or third person. Strong answers might use the abandoned red coat as a symbol of a hurried departure or a secret. Do not reward length for its own sake; writing well below 350 words belongs in the lower part of the level.
Common errors: summarising the whole story rather than writing an opening; listing the objects in the image; clichés such as « c'était une nuit sombre et orageuse » ; inconsistent tenses; anglicisms; missing accents and agreement errors.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$french-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$French Language & Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 8 and pq.mark_scheme = $mq$Criterion C: producing text
[8] Levels 1-2 (1-3 marks): ideas are limited or generic; little sense of purpose, audience or voice. Levels 3-4 (4-6 marks): clear, sustained ideas with relevant development; some deliberate choices for effect. Levels 5-6 (7-8 marks): original, controlled and convincing; atmosphere and character are convincingly developed; techniques (imagery, sensory detail, pacing, point of view) are used purposefully and linked to the stimulus.
Criterion B: organising
[6] Levels 1-2 (1-2 marks): little structure; ideas are listed or repeated. Levels 3-4 (3-4 marks): clear opening and development with paragraphing and some linking. Levels 5-6 (5-6 marks): shaped, cohesive piece with deliberate structural choices; e.g. a shift in focus, a withheld detail or a hook ending; paragraphs and transitions enhance meaning.
Criterion D: using language
[8] Levels 1-2 (1-3 marks): frequent errors affect meaning; limited vocabulary. Levels 3-4 (4-6 marks): generally accurate spelling, accents, agreement and verb forms; some range of vocabulary and sentence types. Levels 5-6 (7-8 marks): accurate, fluent and varied writing with precise vocabulary and a range of tenses and structures; sentence variety is used for effect; verb tenses (passé simple or passé composé with imparfait) are controlled.
Indicative content: any suitable narrative; accept first or third person. Strong answers might use the abandoned red coat as a symbol of a hurried departure or a secret. Do not reward length for its own sake; writing well below 350 words belongs in the lower part of the level.
Common errors: summarising the whole story rather than writing an opening; listing the objects in the image; clichés such as « c'était une nuit sombre et orageuse » ; inconsistent tenses; anglicisms; missing accents and agreement errors.$mq$;

-- 19. papers-myp5/44-french-language-and-literature-full-mock.json | "French Language & Literature MYP 5 Full eAssessment Mock" | question position 9: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$Criterion C: producing text
[8] Band 1 (1-3 marks): ideas are limited or generic; little sense of purpose, audience or voice. Band 2 (4-6 marks): clear, sustained ideas with relevant development; some deliberate choices for effect. Band 3 (7-8 marks): original, controlled and convincing; a convincing, insightful argument with well-chosen evidence and sustained evaluation of counter-arguments; a clear sense of the teenage readership and a deliberate tone.
Criterion B: organising
[6] Band 1 (1-2 marks): little structure; ideas are listed or repeated. Band 2 (3-4 marks): clear opening and development with paragraphing and some linking. Band 3 (5-6 marks): shaped, cohesive piece with deliberate structural choices; e.g. a hook introduction, linked paragraphs, signposting and a memorable conclusion; the conventions of a magazine article (titre, chapeau) used skilfully.
Criterion D: using language
[8] Band 1 (1-3 marks): frequent errors affect meaning; limited vocabulary. Band 2 (4-6 marks): generally accurate spelling, accents, agreement and verb forms; some range of vocabulary and sentence types. Band 3 (7-8 marks): accurate, fluent and varied writing with precise vocabulary and a range of tenses and structures; rhetorical devices (question rhétorique, règle de trois, anecdote, adresse directe) used precisely; a range of connectives and verb forms, including the subjunctive after expressions such as « il faut que » where appropriate.
Indicative content: accept for, against or balanced views; strong answers use concrete examples (sommeil, harcèlement, créativité, amitié, information) and weigh them. Writing significantly below 400 words belongs in the lower part of the level.
Common errors: a list of points with no evaluation; ignoring the opposing view; an overly informal or text-message register; confusing « leur/leurs », « ce/se », « a/à », « ces/ses ».$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$french-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$French Language & Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 9 and pq.mark_scheme = $mq$Criterion C: producing text
[8] Levels 1-2 (1-3 marks): ideas are limited or generic; little sense of purpose, audience or voice. Levels 3-4 (4-6 marks): clear, sustained ideas with relevant development; some deliberate choices for effect. Levels 5-6 (7-8 marks): original, controlled and convincing; a convincing, insightful argument with well-chosen evidence and sustained evaluation of counter-arguments; a clear sense of the teenage readership and a deliberate tone.
Criterion B: organising
[6] Levels 1-2 (1-2 marks): little structure; ideas are listed or repeated. Levels 3-4 (3-4 marks): clear opening and development with paragraphing and some linking. Levels 5-6 (5-6 marks): shaped, cohesive piece with deliberate structural choices; e.g. a hook introduction, linked paragraphs, signposting and a memorable conclusion; the conventions of a magazine article (titre, chapeau) used skilfully.
Criterion D: using language
[8] Levels 1-2 (1-3 marks): frequent errors affect meaning; limited vocabulary. Levels 3-4 (4-6 marks): generally accurate spelling, accents, agreement and verb forms; some range of vocabulary and sentence types. Levels 5-6 (7-8 marks): accurate, fluent and varied writing with precise vocabulary and a range of tenses and structures; rhetorical devices (question rhétorique, règle de trois, anecdote, adresse directe) used precisely; a range of connectives and verb forms, including the subjunctive after expressions such as « il faut que » where appropriate.
Indicative content: accept for, against or balanced views; strong answers use concrete examples (sommeil, harcèlement, créativité, amitié, information) and weigh them. Writing significantly below 400 words belongs in the lower part of the level.
Common errors: a list of points with no evaluation; ignoring the opposing view; an overly informal or text-message register; confusing « leur/leurs », « ce/se », « a/à », « ces/ses ».$mq$;

-- 19. papers-myp5/47-spanish-language-and-literature-full-mock.json | "Spanish Language & Literature MYP 5 Full eAssessment Mock" | question position 1: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$(a)
[1] One valid detail, e.g. «a las siete y cuarenta todavía estaba de pie en la cola»; la señora discute por un paquete; «llevaba treinta y cuatro minutos allí»; Sofía cuenta los chasquidos del reloj.
[1] A second, different valid detail.
(b)
[1] A valid inference, e.g. Sofía is anxious and unsure, and the letter is extremely important to her.
[1] Supported by reference, e.g. she holds the envelope «apretado contra el pecho como si pudiera escaparse»; she wrote, tore up and rewrote the letter throughout October.
[1] Developed comment, e.g. the envelope without a sender and the doubt about posting it show fear of the answer, or of rejection by her father.
(c)
[1] Identifies a valid impression: tired, routine, indifferent, mechanical.
[1] Supported by quotation or close reference, e.g. «sin levantar la vista»; «la voz de quien repite la misma palabra desde hace treinta años y ya no la oye».
[1] Explains the effect, e.g. his indifference contrasts with Sofía's inner turmoil and makes her moment feel lonelier and more important.
Band guidance: award marks for inference supported by the text, not for retelling.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$spanish-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$Spanish Language & Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 1 and pq.mark_scheme = $mq$(a)
[1] One valid detail, e.g. «a las siete y cuarenta todavía estaba de pie en la cola»; la señora discute por un paquete; «llevaba treinta y cuatro minutos allí»; Sofía cuenta los chasquidos del reloj.
[1] A second, different valid detail.
(b)
[1] A valid inference, e.g. Sofía is anxious and unsure, and the letter is extremely important to her.
[1] Supported by reference, e.g. she holds the envelope «apretado contra el pecho como si pudiera escaparse»; she wrote, tore up and rewrote the letter throughout October.
[1] Developed comment, e.g. the envelope without a sender and the doubt about posting it show fear of the answer, or of rejection by her father.
(c)
[1] Identifies a valid impression: tired, routine, indifferent, mechanical.
[1] Supported by quotation or close reference, e.g. «sin levantar la vista»; «la voz de quien repite la misma palabra desde hace treinta años y ya no la oye».
[1] Explains the effect, e.g. his indifference contrasts with Sofía's inner turmoil and makes her moment feel lonelier and more important.
Levels of response guidance: award marks for inference supported by the text, not for retelling.$mq$;

-- 19. papers-myp5/47-spanish-language-and-literature-full-mock.json | "Spanish Language & Literature MYP 5 Full eAssessment Mock" | question position 2: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$Indicative content (credit any valid, well-supported point):
[1] Setting: a post office near closing time («cerraba a las ocho», «siete y cuarenta») builds time pressure and a sense that the chance will soon be gone.
[1] The simile «apretado contra el pecho como si pudiera escaparse»: the letter is alive and precious; Sofía's fear of losing it or of letting go of it.
[1] The comic anecdote of the parcel that «había vuelto sin que nadie supiera por qué»: ordinary bureaucracy contrasts with Sofía's private drama and raises the question of whether messages ever arrive.
[1] The clock («un chasquido seco, una pausa, otro chasquido») and the rhythm of the sentence: the waiting is heard; a pause creates suspense.
[1] The detail of October, with the letter «escrito, roto y vuelto a escribir»: obsessive effort and uncertainty.
[1] The official's voice «ya no la oye»: mechanical routine contrasts with her emotion.
[1] The scale «brillante y paciente»: personification; the scale waits as Sofía does and will «weigh» her decision.
[1] The father's house «al otro lado del mar» and «la puerta que quizá no se abriría»: distance and fear of rejection.
[1] Sentence length: long sentences of waiting give way to short ones of action («Puso el sobre en el platillo»), showing the decision.
[1] The ending: the needle that «tembló», «dudó» and «se quedó quieta, como si también ella hubiera decidido esperar»: the final personification mirrors Sofía's feelings and leaves the outcome open.
Band guidance: Band 1 (1-3 marks) identify features with little explanation; Band 2 (4-6 marks) explain effects with some support; Band 3 (7-10 marks) sustained, precise analysis of language and structure.
Common errors: retelling the story; naming features without explaining the effect.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$spanish-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$Spanish Language & Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 2 and pq.mark_scheme = $mq$Indicative content (credit any valid, well-supported point):
[1] Setting: a post office near closing time («cerraba a las ocho», «siete y cuarenta») builds time pressure and a sense that the chance will soon be gone.
[1] The simile «apretado contra el pecho como si pudiera escaparse»: the letter is alive and precious; Sofía's fear of losing it or of letting go of it.
[1] The comic anecdote of the parcel that «había vuelto sin que nadie supiera por qué»: ordinary bureaucracy contrasts with Sofía's private drama and raises the question of whether messages ever arrive.
[1] The clock («un chasquido seco, una pausa, otro chasquido») and the rhythm of the sentence: the waiting is heard; a pause creates suspense.
[1] The detail of October, with the letter «escrito, roto y vuelto a escribir»: obsessive effort and uncertainty.
[1] The official's voice «ya no la oye»: mechanical routine contrasts with her emotion.
[1] The scale «brillante y paciente»: personification; the scale waits as Sofía does and will «weigh» her decision.
[1] The father's house «al otro lado del mar» and «la puerta que quizá no se abriría»: distance and fear of rejection.
[1] Sentence length: long sentences of waiting give way to short ones of action («Puso el sobre en el platillo»), showing the decision.
[1] The ending: the needle that «tembló», «dudó» and «se quedó quieta, como si también ella hubiera decidido esperar»: the final personification mirrors Sofía's feelings and leaves the outcome open.
Levels of response guidance: Levels 1-2 (1-3 marks) identify features with little explanation; Levels 3-4 (4-6 marks) explain effects with some support; Levels 5-6 (7-10 marks) sustained, precise analysis of language and structure.
Common errors: retelling the story; naming features without explaining the effect.$mq$;

-- 19. papers-myp5/47-spanish-language-and-literature-full-mock.json | "Spanish Language & Literature MYP 5 Full eAssessment Mock" | question position 3: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$(a)
[1] He said «No te suelto» but in fact he let go («y me soltaba»).
(b)
[1] A valid inference, e.g. the speaker feels gratitude and understanding; she/he no longer sees the lie as a betrayal.
[1] Supported by reference, e.g. the oxymoron «mintió con ternura» shows that the lie was an act of love.
[1] Developed comment, e.g. the speaker recognises that the grandfather's trust gave them the courage to reach «hasta aquí» in life.
(c)
[1] The image of the grandfather holding «con la otra el miedo, que era mío»: fear is given a physical form and is shared.
[1] The promise and its contradiction «No te suelto —decía, y me soltaba»: tender irony, the dash and the comma create a turn.
[1] «sosteniendo el mundo» and «pequeño»: the child's belief against the adult's reality; the grandfather fades into the distance.
[1] The shift from past to present («Hoy subo la cuesta»): a mature voice that now rides alone, a visible structure of growth.
[1] The generalisation «Sé que nada se sostiene solo»: a short, reflective line that gives the poem its central idea.
[1] The structure of four short stanzas and the final stanza's reflection with enjambement: gentle, conversational rhythm and a closing sense of resolution.
Band guidance: award marks for explained effects, not for feature-spotting.
Common errors: assuming the grandfather has died without textual support; ignoring structure.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$spanish-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$Spanish Language & Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 3 and pq.mark_scheme = $mq$(a)
[1] He said «No te suelto» but in fact he let go («y me soltaba»).
(b)
[1] A valid inference, e.g. the speaker feels gratitude and understanding; she/he no longer sees the lie as a betrayal.
[1] Supported by reference, e.g. the oxymoron «mintió con ternura» shows that the lie was an act of love.
[1] Developed comment, e.g. the speaker recognises that the grandfather's trust gave them the courage to reach «hasta aquí» in life.
(c)
[1] The image of the grandfather holding «con la otra el miedo, que era mío»: fear is given a physical form and is shared.
[1] The promise and its contradiction «No te suelto —decía, y me soltaba»: tender irony, the dash and the comma create a turn.
[1] «sosteniendo el mundo» and «pequeño»: the child's belief against the adult's reality; the grandfather fades into the distance.
[1] The shift from past to present («Hoy subo la cuesta»): a mature voice that now rides alone, a visible structure of growth.
[1] The generalisation «Sé que nada se sostiene solo»: a short, reflective line that gives the poem its central idea.
[1] The structure of four short stanzas and the final stanza's reflection with enjambement: gentle, conversational rhythm and a closing sense of resolution.
Levels of response guidance: award marks for explained effects, not for feature-spotting.
Common errors: assuming the grandfather has died without textual support; ignoring structure.$mq$;

-- 19. papers-myp5/47-spanish-language-and-literature-full-mock.json | "Spanish Language & Literature MYP 5 Full eAssessment Mock" | question position 4: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$[1] Identifies the family relationship and fear in Text A (Sofía and her father; fear that the door will not open).
[1] Identifies the family relationship and fear in Text B (the grandfather and the child's fear on the bicycle).
[1] A valid similarity, e.g. in both texts a physical object (el sobre; la bicicleta) is the means by which a character crosses a threshold with the help of someone far away.
[1] A valid difference, e.g. Text A is tense and unresolved in a single present moment, whereas Text B looks back and finds peace and gratitude.
[1] Quotation from Text A used accurately.
[1] Quotation from Text B used accurately.
[1] Language comparison, e.g. the personifying similes of Text A («como si pudiera escaparse», «como si también ella hubiera decidido esperar») versus the paradox and direct speech of Text B («No te suelto»).
[1] Explains the effect of the language in at least one text.
[1] Structure or form comparison, e.g. third-person narrative ending with a suspended image versus free verse in short stanzas with a shift from past to present.
[1] Explains the effect of structure or form in at least one text.
[1] The comparison is sustained and linked, using connectives such as «mientras que», «igualmente», «en cambio».
[1] Overall judgement, e.g. both writers suggest that crossing a threshold requires trust, and that love can be expressed through distance and risk.
Band guidance: Band 1 (1-4 marks) separate descriptions with little comparison; Band 2 (5-8 marks) explicit comparison of ideas with some language or structure; Band 3 (9-12 marks) sustained, integrated comparison with precise evidence.
Common errors: writing about each text in turn with no links; comparing only plots.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$spanish-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$Spanish Language & Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 4 and pq.mark_scheme = $mq$[1] Identifies the family relationship and fear in Text A (Sofía and her father; fear that the door will not open).
[1] Identifies the family relationship and fear in Text B (the grandfather and the child's fear on the bicycle).
[1] A valid similarity, e.g. in both texts a physical object (el sobre; la bicicleta) is the means by which a character crosses a threshold with the help of someone far away.
[1] A valid difference, e.g. Text A is tense and unresolved in a single present moment, whereas Text B looks back and finds peace and gratitude.
[1] Quotation from Text A used accurately.
[1] Quotation from Text B used accurately.
[1] Language comparison, e.g. the personifying similes of Text A («como si pudiera escaparse», «como si también ella hubiera decidido esperar») versus the paradox and direct speech of Text B («No te suelto»).
[1] Explains the effect of the language in at least one text.
[1] Structure or form comparison, e.g. third-person narrative ending with a suspended image versus free verse in short stanzas with a shift from past to present.
[1] Explains the effect of structure or form in at least one text.
[1] The comparison is sustained and linked, using connectives such as «mientras que», «igualmente», «en cambio».
[1] Overall judgement, e.g. both writers suggest that crossing a threshold requires trust, and that love can be expressed through distance and risk.
Levels of response guidance: Levels 1-2 (1-4 marks) separate descriptions with little comparison; Levels 3-4 (5-8 marks) explicit comparison of ideas with some language or structure; Levels 5-6 (9-12 marks) sustained, integrated comparison with precise evidence.
Common errors: writing about each text in turn with no links; comparing only plots.$mq$;

-- 19. papers-myp5/47-spanish-language-and-literature-full-mock.json | "Spanish Language & Literature MYP 5 Full eAssessment Mock" | question position 6: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$Indicative content (credit any valid, well-supported point):
[1] The personal, anecdotal opening («me acerqué a la puerta y conté a la gente») gives credibility and a first-hand viewpoint.
[1] Specific, varied examples (el abuelo y su nieta, los estudiantes, la cuidadora) create pathos and show who would be harmed.
[1] The detail «Ninguno miraba el móvil» and «paciencia de quien espera algo bueno»: positive, human image of shared attention.
[1] The concession «No lo discuto» makes the writer seem reasonable.
[1] Rhetorical questions («¿Cuánto vale una tarde...?») force the reader to reconsider what is valuable.
[1] Statistics (85 000 euros, 7 %, dos mil ochocientas personas) and the reframing of «Puede parecer poco»: logos used to defend the cinema.
[1] The shift from «yo» to «nosotros» («Si fracasamos, apagaremos nosotros mismos las luces») involves the community.
[1] The practical proposal («dennos un año», ciclos de cine escolar, abrir los domingos): constructive tone.
[1] Structure: anecdote, objection, evidence, proposal; clear logical progression.
[1] The final image («quién hay sentado en la oscuridad») and the use of the formal imperative «no las apaguen»: memorable ending that challenges the decision-makers.
Band guidance: Band 1 (1-3 marks) list devices; Band 2 (4-6 marks) explain effects with examples; Band 3 (7-10 marks) sustained, precise evaluation of how choices persuade.
Common errors: retelling; naming devices without effect.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$spanish-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$Spanish Language & Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 6 and pq.mark_scheme = $mq$Indicative content (credit any valid, well-supported point):
[1] The personal, anecdotal opening («me acerqué a la puerta y conté a la gente») gives credibility and a first-hand viewpoint.
[1] Specific, varied examples (el abuelo y su nieta, los estudiantes, la cuidadora) create pathos and show who would be harmed.
[1] The detail «Ninguno miraba el móvil» and «paciencia de quien espera algo bueno»: positive, human image of shared attention.
[1] The concession «No lo discuto» makes the writer seem reasonable.
[1] Rhetorical questions («¿Cuánto vale una tarde...?») force the reader to reconsider what is valuable.
[1] Statistics (85 000 euros, 7 %, dos mil ochocientas personas) and the reframing of «Puede parecer poco»: logos used to defend the cinema.
[1] The shift from «yo» to «nosotros» («Si fracasamos, apagaremos nosotros mismos las luces») involves the community.
[1] The practical proposal («dennos un año», ciclos de cine escolar, abrir los domingos): constructive tone.
[1] Structure: anecdote, objection, evidence, proposal; clear logical progression.
[1] The final image («quién hay sentado en la oscuridad») and the use of the formal imperative «no las apaguen»: memorable ending that challenges the decision-makers.
Levels of response guidance: Levels 1-2 (1-3 marks) list devices; Levels 3-4 (4-6 marks) explain effects with examples; Levels 5-6 (7-10 marks) sustained, precise evaluation of how choices persuade.
Common errors: retelling; naming devices without effect.$mq$;

-- 19. papers-myp5/47-spanish-language-and-literature-full-mock.json | "Spanish Language & Literature MYP 5 Full eAssessment Mock" | question position 8: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$Criterion C: producing text
[8] Band 1 (1-3 marks): ideas are limited or generic; little sense of purpose, audience or voice. Band 2 (4-6 marks): clear, sustained ideas with relevant development; some deliberate choices for effect. Band 3 (7-8 marks): original, controlled and convincing; atmosphere and character are convincingly developed; techniques (imagery, sensory detail, pacing, point of view) are used purposefully and linked to the stimulus.
Criterion B: organising
[6] Band 1 (1-2 marks): little structure; ideas are listed or repeated. Band 2 (3-4 marks): clear opening and development with paragraphing and some linking. Band 3 (5-6 marks): shaped, cohesive piece with deliberate structural choices; e.g. a shift in focus, a withheld detail or a hook ending; paragraphs and transitions enhance meaning.
Criterion D: using language
[8] Band 1 (1-3 marks): frequent errors affect meaning; limited vocabulary. Band 2 (4-6 marks): generally accurate spelling, accents, agreement and verb forms; some range of vocabulary and sentence types. Band 3 (7-8 marks): accurate, fluent and varied writing with precise vocabulary and a range of tenses and structures; sentence variety is used for effect; tenses (pretérito indefinido and imperfecto) are controlled.
Indicative content: any suitable narrative; accept first or third person. Strong answers might use the abandoned umbrella and half-closed suitcase as symbols of a sudden departure or an interrupted plan. Do not reward length for its own sake; writing well below 350 words belongs in the lower part of the level.
Common errors: summarising the whole story rather than writing an opening; listing the objects in the image; clichés such as «era una noche oscura y tormentosa»; inconsistent tenses; anglicisms; missing accents, agreement errors and confusion between ser/estar or por/para.$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$spanish-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$Spanish Language & Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 8 and pq.mark_scheme = $mq$Criterion C: producing text
[8] Levels 1-2 (1-3 marks): ideas are limited or generic; little sense of purpose, audience or voice. Levels 3-4 (4-6 marks): clear, sustained ideas with relevant development; some deliberate choices for effect. Levels 5-6 (7-8 marks): original, controlled and convincing; atmosphere and character are convincingly developed; techniques (imagery, sensory detail, pacing, point of view) are used purposefully and linked to the stimulus.
Criterion B: organising
[6] Levels 1-2 (1-2 marks): little structure; ideas are listed or repeated. Levels 3-4 (3-4 marks): clear opening and development with paragraphing and some linking. Levels 5-6 (5-6 marks): shaped, cohesive piece with deliberate structural choices; e.g. a shift in focus, a withheld detail or a hook ending; paragraphs and transitions enhance meaning.
Criterion D: using language
[8] Levels 1-2 (1-3 marks): frequent errors affect meaning; limited vocabulary. Levels 3-4 (4-6 marks): generally accurate spelling, accents, agreement and verb forms; some range of vocabulary and sentence types. Levels 5-6 (7-8 marks): accurate, fluent and varied writing with precise vocabulary and a range of tenses and structures; sentence variety is used for effect; tenses (pretérito indefinido and imperfecto) are controlled.
Indicative content: any suitable narrative; accept first or third person. Strong answers might use the abandoned umbrella and half-closed suitcase as symbols of a sudden departure or an interrupted plan. Do not reward length for its own sake; writing well below 350 words belongs in the lower part of the level.
Common errors: summarising the whole story rather than writing an opening; listing the objects in the image; clichés such as «era una noche oscura y tormentosa»; inconsistent tenses; anglicisms; missing accents, agreement errors and confusion between ser/estar or por/para.$mq$;

-- 19. papers-myp5/47-spanish-language-and-literature-full-mock.json | "Spanish Language & Literature MYP 5 Full eAssessment Mock" | question position 9: mark_scheme (Level -> Band labels)
update public.paper_questions pq set mark_scheme = $mq$Criterion C: producing text
[8] Band 1 (1-3 marks): ideas are limited or generic; little sense of purpose, audience or voice. Band 2 (4-6 marks): clear, sustained ideas with relevant development; some deliberate choices for effect. Band 3 (7-8 marks): original, controlled and convincing; a convincing, insightful argument with well-chosen evidence and sustained evaluation of counter-arguments; a clear sense of the teenage readership and a deliberate tone.
Criterion B: organising
[6] Band 1 (1-2 marks): little structure; ideas are listed or repeated. Band 2 (3-4 marks): clear opening and development with paragraphing and some linking. Band 3 (5-6 marks): shaped, cohesive piece with deliberate structural choices; e.g. a hook introduction, linked paragraphs, signposting and a memorable conclusion; the conventions of a magazine article (titular, entradilla) used skilfully.
Criterion D: using language
[8] Band 1 (1-3 marks): frequent errors affect meaning; limited vocabulary. Band 2 (4-6 marks): generally accurate spelling, accents, agreement and verb forms; some range of vocabulary and sentence types. Band 3 (7-8 marks): accurate, fluent and varied writing with precise vocabulary and a range of tenses and structures; rhetorical devices (pregunta retórica, enumeración de tres elementos, anécdota, apelación directa) used precisely; a range of connectives and verb forms, including the subjunctive after expressions such as «es importante que» where appropriate.
Indicative content: accept for, against or balanced views; strong answers use concrete examples (igualdad, identidad, coste, comodidad, pertenencia) and weigh them. Writing significantly below 400 words belongs in the lower part of the level.
Common errors: a list of points with no evaluation; ignoring the opposing view; an overly informal or text-message register; confusing «a ver/haber», «porque/porqué», «hay/ahí/ay», «tuvo/tubo».$mq$
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$spanish-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$Spanish Language & Literature MYP 5 Full eAssessment Mock$mq$
  and pq.position = 9 and pq.mark_scheme = $mq$Criterion C: producing text
[8] Levels 1-2 (1-3 marks): ideas are limited or generic; little sense of purpose, audience or voice. Levels 3-4 (4-6 marks): clear, sustained ideas with relevant development; some deliberate choices for effect. Levels 5-6 (7-8 marks): original, controlled and convincing; a convincing, insightful argument with well-chosen evidence and sustained evaluation of counter-arguments; a clear sense of the teenage readership and a deliberate tone.
Criterion B: organising
[6] Levels 1-2 (1-2 marks): little structure; ideas are listed or repeated. Levels 3-4 (3-4 marks): clear opening and development with paragraphing and some linking. Levels 5-6 (5-6 marks): shaped, cohesive piece with deliberate structural choices; e.g. a hook introduction, linked paragraphs, signposting and a memorable conclusion; the conventions of a magazine article (titular, entradilla) used skilfully.
Criterion D: using language
[8] Levels 1-2 (1-3 marks): frequent errors affect meaning; limited vocabulary. Levels 3-4 (4-6 marks): generally accurate spelling, accents, agreement and verb forms; some range of vocabulary and sentence types. Levels 5-6 (7-8 marks): accurate, fluent and varied writing with precise vocabulary and a range of tenses and structures; rhetorical devices (pregunta retórica, enumeración de tres elementos, anécdota, apelación directa) used precisely; a range of connectives and verb forms, including the subjunctive after expressions such as «es importante que» where appropriate.
Indicative content: accept for, against or balanced views; strong answers use concrete examples (igualdad, identidad, coste, comodidad, pertenencia) and weigh them. Writing significantly below 400 words belongs in the lower part of the level.
Common errors: a list of points with no evaluation; ignoring the opposing view; an overly informal or text-message register; confusing «a ver/haber», «porque/porqué», «hay/ahí/ay», «tuvo/tubo».$mq$;

commit;
