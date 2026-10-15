-- Language accuracy review fixes (second pass), MYP 5.
-- Matches the CURRENT working-tree text. Run AFTER content/fixes/language-fixes.sql and content/review/languages-fixes.sql
-- (those earlier fixes touch other rows; this file touches only the rows below).
-- Every statement matches the exact old text, so it is idempotent: a statement that matches nothing updates 0 rows and is harmless.
-- Question options in the live DB were shuffled by scripts/json-to-sql.mjs (correct option at index (i*3)%4 for 0-based question i),
-- so the option fixes below write the shuffled order and the answer index is unchanged.
-- Expect UPDATE 1 for every statement (UPDATE 0 means it was already applied or the live text differs).

begin;

-- 1. mandarin-ab-initio-myp5/02-family-and-friends.json | Family and Friends > Describing People | Q6: keyed 'She is very tall' -> 'She is tall' (很 is not strong 'very' in plain statements) | options
update public.questions qq set options = $mq$["She is not tall","She is a teacher","She is taller than me","She is tall"]$mq$::jsonb
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where qq.topic_id = t.id and s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Describing People$mq$ and p.name = $mq$Family and Friends$mq$
  and qq.content = $mq$What does 她很高 (tā hěn gāo) mean?$mq$ and qq.options = $mq$["She is not tall","She is a teacher","She is taller than me","She is very tall"]$mq$::jsonb;

-- 2. mandarin-ab-initio-myp5/03-home-and-daily-life.json | Home and Daily Life > Rooms and Furniture: 前面 pinyin qiánmian -> qiánmiàn (note) | note
update public.notes nn set content = replace(nn.content, $mq$前面 (qiánmian): in front of$mq$, $mq$前面 (qiánmiàn): in front of$mq$)
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where nn.topic_id = t.id and s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Rooms and Furniture$mq$ and p.name = $mq$Home and Daily Life$mq$
  and position($mq$前面 (qiánmian): in front of$mq$ in nn.content) > 0;

-- 3. mandarin-ab-initio-myp5/03-home-and-daily-life.json | Home and Daily Life > Rooms and Furniture: 前面 pinyin in flashcard back
update public.flashcards ff set back = replace(ff.back, $mq$前面 (qiánmian) = in front$mq$, $mq$前面 (qiánmiàn) = in front$mq$)
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where ff.topic_id = t.id and s.slug = $mq$mandarin-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Rooms and Furniture$mq$ and p.name = $mq$Home and Daily Life$mq$
  and position($mq$前面 (qiánmian) = in front$mq$ in ff.back) > 0;

-- 4. spanish-ab-initio-myp5/06-town-and-travel.json | Town and Travel > Asking for and Giving Directions: wrong claim about tú/usted imperative forms | note
update public.notes nn set content = replace(nn.content, $mq$The tú form looks like the 'he/she' present tense (sigue, gira, cruza, toma). The usted form ends in -e (gire, cruce, tome) except for 'seguir', which becomes 'siga'.$mq$, $mq$The usted form of -ar verbs ends in -e (gire, cruce, tome); -er and -ir verbs end in -a, so 'seguir' becomes 'siga'.$mq$)
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where nn.topic_id = t.id and s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Asking for and Giving Directions$mq$ and p.name = $mq$Town and Travel$mq$
  and position($mq$The tú form looks like the 'he/she' present tense (sigue, gira, cruza, toma). The usted form ends in -e (gire, cruce, tome) except for 'seguir', which becomes 'siga'.$mq$ in nn.content) > 0;

-- 5. spanish-language-and-literature-myp5/03-prose-and-fiction.json | Prose and Fiction > Character and Setting | Q5: keyed option called a physical description 'direct characterization' (the note defines direct characterization as the narrator stating a trait) | options
update public.questions qq set options = $mq$["Una descripción física que caracteriza al personaje y sugiere cansancio o nervios","Una rima","Un diálogo","Una metáfora de un paisaje"]$mq$::jsonb
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where qq.topic_id = t.id and s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Character and Setting$mq$ and p.name = $mq$Prose and Fiction$mq$
  and qq.content = $mq$¿Qué muestra una descripción física como «ojos hundidos y manos temblorosas»?$mq$ and qq.options = $mq$["Una caracterización directa que sugiere cansancio o nervios","Una rima","Un diálogo","Una metáfora de un paisaje"]$mq$::jsonb;

-- 6. english-language-and-literature-myp5/12-language-accuracy.json | Language Accuracy > Grammar, Punctuation and Syntax: 'no point in staying' is not an error ('no point staying' is also correct); worked example claimed a missing preposition | note
update public.notes nn set content = replace(nn.content, $mq$Corrected: "The film was long, so we left early; there was no point in staying." Errors fixed: the comma splice, the confusion of "their" and "there", and the missing preposition "in".$mq$, $mq$Corrected: "The film was long, so we left early; there was no point staying." Errors fixed: the comma splice and the confusion of "their" and "there".$mq$)
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where nn.topic_id = t.id and s.slug = $mq$english-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Grammar, Punctuation and Syntax$mq$ and p.name = $mq$Language Accuracy$mq$
  and position($mq$Corrected: "The film was long, so we left early; there was no point in staying." Errors fixed: the comma splice, the confusion of "their" and "there", and the missing preposition "in".$mq$ in nn.content) > 0;

-- 7. english-language-and-literature-myp5/12-language-accuracy.json | Language Accuracy > Spelling, Vocabulary and Editing: 'friend' follows i-before-e, so it is not an exception | note
update public.notes nn set content = replace(nn.content, $mq$(received, but friend is an exception)$mq$, $mq$(receive, but weird is an exception)$mq$)
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where nn.topic_id = t.id and s.slug = $mq$english-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Spelling, Vocabulary and Editing$mq$ and p.name = $mq$Language Accuracy$mq$
  and position($mq$(received, but friend is an exception)$mq$ in nn.content) > 0;

-- 8. papers-myp5/137-s7-mandarin-ab-initio-paper-b.json Q7: French guillemets around a Chinese blog title -> Chinese quotation marks
update public.paper_questions pq set content = replace(pq.content, $mq$a blog called « 爱护地球 ».$mq$, $mq$a blog called “爱护地球”.$mq$)
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$mandarin-ab-initio$mq$ and pp.grade = 5 and pp.title = $mq$Mandarin ab initio MYP 5 eAssessment Paper B (7 tasks, 64 marks)$mq$ and pq.position = 7
  and position($mq$a blog called « 爱护地球 ».$mq$ in pq.content) > 0;

-- 9. papers-myp5/79-english-language-and-literature-structure-mock-b.json Q1: 'Mara: you up?' is two words, text said 'Three words.'
update public.paper_questions pq set content = replace(pq.content, $mq$Three words. He typed$mq$, $mq$Two words. He typed$mq$)
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 eAssessment Structure Mock B (7 tasks, 80 marks)$mq$ and pq.position = 1
  and position($mq$Three words. He typed$mq$ in pq.content) > 0;

-- 10. papers-myp5/107-s3-02.json Q1: question said 'second paragraph' but the repeated 'They do not say' is the third block of the speech
update public.paper_questions pq set content = replace(pq.content, $mq$in the second paragraph of Text A. (3 marks)$mq$, $mq$in the paragraph beginning 'They do not say that on the fourteenth of October' in Text A. (3 marks)$mq$)
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 eAssessment Paper B (3 tasks, 80 marks)$mq$ and pq.position = 1
  and position($mq$in the second paragraph of Text A. (3 marks)$mq$ in pq.content) > 0;

-- 11. papers-myp5/78-english-language-and-literature-structure-mock-a.json Q1: exhibition 14 March to 30 April is not six weeks
update public.paper_questions pq set content = replace(pq.content, $mq$For six weeks they sit under glass$mq$, $mq$For almost seven weeks they sit under glass$mq$)
from public.past_papers pp
join public.subjects s on s.id = pp.subject_id
where pq.paper_id = pp.id and s.slug = $mq$english-language-and-literature$mq$ and pp.grade = 5 and pp.title = $mq$English Language and Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks)$mq$ and pq.position = 1
  and position($mq$For six weeks they sit under glass$mq$ in pq.content) > 0;

commit;
