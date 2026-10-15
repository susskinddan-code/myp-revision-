-- Accuracy fixes for language content (French/Spanish/Mandarin ab initio MYP5, French/Spanish Language and Literature MYP5).
-- Rows are matched by exact old text within the sub-topic. Each statement should report UPDATE 1.
-- Question options in the live DB were shuffled by scripts/json-to-sql.mjs (correct option at index (i*3)%4), so the options fix writes the shuffled order.

begin;

-- 1. french-ab-initio-myp5/01-greetings-and-introductions.json | Greetings and Introductions > Greetings and Farewells | Q16: explanation
update public.questions q set explanation = $mq$Only 'Bonjour, Madame. Comment allez-vous ?' stays formal throughout: 'Bonjour' and 'vous'. The others mix a casual greeting or 'tu' with a formal title.$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Greetings and Farewells$mq$ and p.name = $mq$Greetings and Introductions$mq$
  and q.explanation = $mq$Only option B stays formal throughout: 'Bonjour' and 'vous'. The others mix a casual greeting or 'tu' with a formal title.$mq$;

-- 2. french-ab-initio-myp5/01-greetings-and-introductions.json | Greetings and Introductions > Introducing Yourself and Others | Q14: explanation
update public.questions q set explanation = $mq$Marc says 'je suis suisse' and Noah 'est belge'. We are not told where Noah lives, so 'Noah lives in Geneva' cannot be assumed.$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Introducing Yourself and Others$mq$ and p.name = $mq$Greetings and Introductions$mq$
  and q.explanation = $mq$Marc says 'je suis suisse' and Noah 'est belge'. We are not told where Noah lives, so B cannot be assumed.$mq$;

-- 3. french-ab-initio-myp5/04-school-and-work.json | School and Work > School Subjects and Objects | note
update public.notes n set content = replace(n.content, $mq$Une journée à l'école is written as an emploi du temps (timetable). You will read$mq$, $mq$A school week is set out in an emploi du temps (timetable). You will read$mq$)
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where n.topic_id = t.id and s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$School Subjects and Objects$mq$ and p.name = $mq$School and Work$mq$
  and position($mq$Une journée à l'école is written as an emploi du temps (timetable). You will read$mq$ in n.content) > 0;

-- 4. french-ab-initio-myp5/04-school-and-work.json | School and Work > Classroom Language and Instructions | Q15: explanation
update public.questions q set explanation = $mq$For a group the command ends in -ez. 'Fermes' is the tu form of the present tense, not a command (the tu command is 'ferme'), and 'fermons' means let us close.$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Classroom Language and Instructions$mq$ and p.name = $mq$School and Work$mq$
  and q.explanation = $mq$For a group the command ends in -ez. Fermes is a wrong spelling, and fermons means let us close.$mq$;

-- 5. french-ab-initio-myp5/06-town-and-travel.json | Town and Travel > Transport and Holidays | note
update public.notes n set content = replace(n.content, $mq$Saying "en pied" instead of "à pied", or "à bus" instead of "en bus", or "à bus" instead of "en bus".$mq$, $mq$Saying "en pied" instead of "à pied", or "à bus" instead of "en bus".$mq$)
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where n.topic_id = t.id and s.slug = $mq$french-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Transport and Holidays$mq$ and p.name = $mq$Town and Travel$mq$
  and position($mq$Saying "en pied" instead of "à pied", or "à bus" instead of "en bus", or "à bus" instead of "en bus".$mq$ in n.content) > 0;

-- 6. spanish-ab-initio-myp5/01-greetings-and-introductions.json | Greetings and Introductions > Greetings and Farewells | Q12: content
update public.questions q set content = $mq$Listening transcript:

Profesor: Buenos días, Marta. ¿Cómo estás hoy?
Alumna: Buenos días, profesor. Estoy regular, gracias. ¿Y usted?
Profesor: Muy bien, gracias.

How does the student say she feels?$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Greetings and Farewells$mq$ and p.name = $mq$Greetings and Introductions$mq$
  and q.content = $mq$Listening transcript:

Profesor: Buenos días, Marta. ¿Cómo está usted hoy?
Alumna: Buenos días, profesor. Estoy regular, gracias. ¿Y usted?
Profesor: Muy bien, gracias.

How does the student say she feels?$mq$;

-- 7. spanish-ab-initio-myp5/04-school-and-work.json | School and Work > Classroom Language and Instructions | Q11: content
update public.questions q set content = $mq$Read the notice.
'Prohibido usar el móvil en clase. Los móviles deben estar en la mochila.'
Where must phones be kept?$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Classroom Language and Instructions$mq$ and p.name = $mq$School and Work$mq$
  and q.content = $mq$Read the notice.
'Prohibido usar el móvil en clase. Los móviles están en la mochila.'
Where must phones be kept?$mq$;

-- 8. spanish-ab-initio-myp5/04-school-and-work.json | School and Work > Classroom Language and Instructions | Q11: explanation
update public.questions q set explanation = $mq$Los móviles deben estar en la mochila means that phones must be kept in the backpack. Prohibido usar el móvil means mobile use is forbidden.$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$spanish-ab-initio$mq$ and t.grade = 5 and t.name = $mq$Classroom Language and Instructions$mq$ and p.name = $mq$School and Work$mq$
  and q.explanation = $mq$Los móviles están en la mochila means that the phones are in the backpack. Prohibido usar el móvil means mobile use is forbidden.$mq$;

-- 9. spanish-language-and-literature-myp5/02-language-devices.json | Language Devices > Sound and Rhythm | Q7: explanation
update public.questions q set explanation = $mq$«cuento» y «lento», las palabras finales de los versos, coinciden en todos los sonidos desde la vocal tónica: -ento.$mq$
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Sound and Rhythm$mq$ and p.name = $mq$Language Devices$mq$
  and q.explanation = $mq$«viento» y «lento» coinciden en todos los sonidos desde la vocal tónica: -ento.$mq$;

-- 10. spanish-language-and-literature-myp5/07-grammar-and-accuracy.json | Grammar and Accuracy > Verb Tenses and Moods | Q6: options
update public.questions q set options = $mq$["tomara", "tomaba", "tomaré", "he tomado"]$mq$::jsonb, answer = 3
from public.topics t
join public.subjects s on s.id = t.subject_id
join public.topics p on p.id = t.parent_topic_id
where q.topic_id = t.id and s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Verb Tenses and Moods$mq$ and p.name = $mq$Grammar and Accuracy$mq$
  and q.content = $mq$Completa: «Esta mañana ___ fruta para desayunar».$mq$
  and q.options = $mq$["desayuné", "desayunaba", "desayunaré", "he desayunado"]$mq$::jsonb;

commit;
