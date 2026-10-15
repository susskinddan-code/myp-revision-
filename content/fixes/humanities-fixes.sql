-- Accuracy fixes for Individuals & Societies / Environmental Systems / Interdisciplinary content (2026-10-14).
-- Idempotent: each statement matches the exact OLD text, so re-running after it has applied changes nothing.
-- options/answer are stored in the shuffled order used by json-to-sql.mjs (correct option at position (i*3)%4).
begin;

-- history-myp5/05-revolution-in-russia.json [Lenin, Stalin and the Soviet State] Q5
update public.questions set content=$mq$What were the 'purges' (or Great Terror) of the 1930s?$mq$, explanation=$mq$Over a million people were arrested in 1937-38 alone, many sent to the Gulag labour camps or shot, including many Communist Party leaders and army officers.$mq$
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$history$mq$ and t.grade=5 and t.name=$mq$Lenin, Stalin and the Soviet State$mq$) and content=$mq$What were the 'purges' (or Great Terror) of the 1930s?$mq$;

-- history-myp5/05-revolution-in-russia.json [Lenin, Stalin and the Soviet State] flashcard 8
update public.flashcards set front=$mq$Great Terror (1936–38)$mq$, back=$mq$Purges and show trials after Kirov's murder (1934); over a million arrested by the NKVD, many shot or sent to the Gulag, including army officers.$mq$
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$history$mq$ and t.grade=5 and t.name=$mq$Lenin, Stalin and the Soviet State$mq$) and front=$mq$Great Terror (1936–38)$mq$ and back=$mq$Purges and show trials after Kirov's murder (1934); millions arrested by the NKVD, many shot or sent to the Gulag, including army officers.$mq$;

-- history-myp5/05-revolution-in-russia.json [Lenin, Stalin and the Soviet State] note
update public.notes set content=replace(content, $mq$the secret police (NKVD) arrested millions.$mq$, $mq$the secret police (NKVD) arrested well over a million people in 1937-38.$mq$)
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$history$mq$ and t.grade=5 and t.name=$mq$Lenin, Stalin and the Soviet State$mq$) and position($mq$the secret police (NKVD) arrested millions.$mq$ in content)>0;

-- gap/history/03-ideas-and-ideologies.json [The Enlightenment and Revolutions] Q11
update public.questions set content=$mq$Which event is associated with Robespierre and the Committee of Public Safety in 1793-94?$mq$, explanation=$mq$During the Terror (1793-94), thousands were executed by guillotine. Louis XVI had been executed earlier, in January 1793. Robespierre fell in July 1794.$mq$
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$history$mq$ and t.grade=5 and t.name=$mq$The Enlightenment and Revolutions$mq$) and content=$mq$Which event is associated with Robespierre and the Committee of Public Safety in 1793-94?$mq$;

-- gap/history/04-everyday-life-and-culture.json [Art, Literature and Culture as Evidence] Q9
update public.questions set content=$mq$The Bayeux Tapestry was made in the years after the Norman Conquest of 1066. Why must historians be careful when using it?$mq$, explanation=$mq$Provenance matters. The people who commissioned and made it affected what it showed and how.$mq$, options=$mq$["It was probably commissioned by a Norman bishop and is usually read as presenting events from a viewpoint favourable to the Normans","It is too colourful to be real","It is too short to be useful","It is a secondary source written in the 20th century"]$mq$::jsonb, answer=0
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$history$mq$ and t.grade=5 and t.name=$mq$Art, Literature and Culture as Evidence$mq$) and content=$mq$The Bayeux Tapestry was made in the years after the Norman Conquest of 1066. Why must historians be careful when using it?$mq$;

-- gap/history/04-everyday-life-and-culture.json [Art, Literature and Culture as Evidence] flashcard 7
update public.flashcards set front=$mq$Bayeux Tapestry$mq$, back=$mq$Embroidered account of the Norman Conquest of 1066, probably commissioned by Bishop Odo and usually read as favouring the Norman viewpoint.$mq$
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$history$mq$ and t.grade=5 and t.name=$mq$Art, Literature and Culture as Evidence$mq$) and front=$mq$Bayeux Tapestry$mq$ and back=$mq$Embroidered account of the Norman Conquest of 1066, made from the Norman viewpoint.$mq$;

-- gap/history/04-everyday-life-and-culture.json [Art, Literature and Culture as Evidence] note
update public.notes set content=replace(content, $mq$The Bayeux Tapestry was made after the Norman Conquest of 1066 and presents events from a viewpoint favourable to the Normans.$mq$, $mq$The Bayeux Tapestry was made after the Norman Conquest of 1066, probably for the Norman bishop Odo, and is usually read as presenting events from a viewpoint favourable to the Normans.$mq$)
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$history$mq$ and t.grade=5 and t.name=$mq$Art, Literature and Culture as Evidence$mq$) and position($mq$The Bayeux Tapestry was made after the Norman Conquest of 1066 and presents events from a viewpoint favourable to the Normans.$mq$ in content)>0;

-- geography-myp5/05-weather-and-climate.json [Causes and Evidence of Climate Change] Q6
update public.questions set content=$mq$Atmospheric CO₂ has risen from about 280 ppm before the industrial era to about 420 ppm in the early 2020s. What is the percentage increase?$mq$, explanation=$mq$Increase = 420 – 280 = 140 ppm. 140 ÷ 280 × 100 = 50%. Using 420 as the base gives 33%.$mq$
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$geography$mq$ and t.grade=5 and t.name=$mq$Causes and Evidence of Climate Change$mq$) and content=$mq$Atmospheric CO₂ has risen from about 280 ppm before the industrial era to about 420 ppm today. What is the percentage increase?$mq$;

-- geography-myp5/05-weather-and-climate.json [Causes and Evidence of Climate Change] Q10
update public.questions set content=$mq$According to the IPCC, average global temperature in 2011-2020 was about 1.1°C higher than in the late 1800s. Which statement is accurate?$mq$, explanation=$mq$The figure is a global mean. The Arctic has warmed faster, and individual cold spells still occur because weather varies from year to year.$mq$
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$geography$mq$ and t.grade=5 and t.name=$mq$Causes and Evidence of Climate Change$mq$) and content=$mq$Average global temperature has risen by about 1.1°C since the late 1800s. Which statement is accurate?$mq$;

-- geography-myp5/05-weather-and-climate.json [Causes and Evidence of Climate Change] flashcard 7
update public.flashcards set front=$mq$CO₂ levels$mq$, back=$mq$About 280 ppm before the industrial era and about 420 ppm in the early 2020s, an increase of 50%.$mq$
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$geography$mq$ and t.grade=5 and t.name=$mq$Causes and Evidence of Climate Change$mq$) and front=$mq$CO₂ levels$mq$ and back=$mq$About 280 ppm before the industrial era and about 420 ppm today, an increase of 50%.$mq$;

-- geography-myp5/05-weather-and-climate.json [Causes and Evidence of Climate Change] flashcard 8
update public.flashcards set front=$mq$Global temperature rise$mq$, back=$mq$About 1.1°C above late 19th-century levels (2011-2020 average, IPCC); recent years are higher. It is a global average, and the Arctic has warmed faster.$mq$
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$geography$mq$ and t.grade=5 and t.name=$mq$Causes and Evidence of Climate Change$mq$) and front=$mq$Global temperature rise$mq$ and back=$mq$About 1.1°C above late 19th-century levels. It is a global average, and the Arctic has warmed faster.$mq$;

-- geography-myp5/05-weather-and-climate.json [Causes and Evidence of Climate Change] note
update public.notes set content=replace(content, $mq$to about 420 ppm, an increase of 50%.$mq$, $mq$to about 420 ppm by the early 2020s, an increase of 50%.$mq$)
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$geography$mq$ and t.grade=5 and t.name=$mq$Causes and Evidence of Climate Change$mq$) and position($mq$to about 420 ppm, an increase of 50%.$mq$ in content)>0;

-- geography-myp5/05-weather-and-climate.json [Causes and Evidence of Climate Change] note
update public.notes set content=replace(content, $mq$global average temperature has risen by about 1.1°C since the late 1800s.$mq$, $mq$global average temperature in 2011-2020 was about 1.1°C higher than in the late 1800s (IPCC), and recent years have been warmer still.$mq$)
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$geography$mq$ and t.grade=5 and t.name=$mq$Causes and Evidence of Climate Change$mq$) and position($mq$global average temperature has risen by about 1.1°C since the late 1800s.$mq$ in content)>0;

-- environmental-systems-myp5/05-climate-and-atmosphere.json [Greenhouse Effect and Climate Change] Q7
update public.questions set content=$mq$Atmospheric CO₂ was about 280 ppm before the Industrial Revolution and about 420 ppm in the early 2020s. What is the percentage increase?$mq$, explanation=$mq$Increase = 420 − 280 = 140 ppm. 140 ÷ 280 × 100 = 50%. A common slip is dividing by the new value (33%).$mq$
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$environmental-systems$mq$ and t.grade=5 and t.name=$mq$Greenhouse Effect and Climate Change$mq$) and content=$mq$Atmospheric CO₂ was about 280 ppm before the Industrial Revolution and about 420 ppm today. What is the percentage increase?$mq$;

-- environmental-systems-myp5/05-climate-and-atmosphere.json [Greenhouse Effect and Climate Change] note
update public.notes set content=replace(content, $mq$to about 420 ppm today.$mq$, $mq$to about 420 ppm in the early 2020s.$mq$)
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$environmental-systems$mq$ and t.grade=5 and t.name=$mq$Greenhouse Effect and Climate Change$mq$) and position($mq$to about 420 ppm today.$mq$ in content)>0;

-- economics-myp5/05-government-intervention.json [Evaluating Government Intervention] note
update public.notes set content=replace(content, $mq$This is the core of the real-world application criterion.$mq$, $mq$This draws mainly on Criterion D, Thinking critically.$mq$)
where topic_id in (select t.id from public.topics t join public.subjects s on s.id=t.subject_id where s.slug=$mq$economics$mq$ and t.grade=5 and t.name=$mq$Evaluating Government Intervention$mq$) and position($mq$This is the core of the real-world application criterion.$mq$ in content)>0;

-- ===== PAPERS (past_papers / paper_questions) =====
-- 25-history-full-mock: Pakistan's independence day is 14 August (India 15 August).
update public.paper_questions set content=replace(content, $mq$India and Pakistan became independent on 15 August 1947 after Britain left the subcontinent.$mq$, $mq$Pakistan became independent on 14 August 1947 and India on 15 August 1947 after Britain left the subcontinent.$mq$), mark_scheme=replace(mark_scheme, $mq$India and Pakistan became independent on 15 August 1947 after Britain left the subcontinent.$mq$, $mq$Pakistan became independent on 14 August 1947 and India on 15 August 1947 after Britain left the subcontinent.$mq$)
where paper_id in (select p.id from public.past_papers p join public.subjects s on s.id=p.subject_id where s.slug=$mq$history$mq$ and p.grade=5 and p.title=$mq$History MYP 5 Full eAssessment Mock$mq$)
  and (position($mq$India and Pakistan became independent on 15 August 1947 after Britain left the subcontinent.$mq$ in content)>0 or position($mq$India and Pakistan became independent on 15 August 1947 after Britain left the subcontinent.$mq$ in coalesce(mark_scheme,''))>0);

-- 67-history-structure-mock-a: Montgomery leaflet: Rosa Parks was fined at the Monday trial, after the leaflet was distributed, so "has been fined" is anachronistic.
update public.paper_questions set content=replace(content, $mq$She has been fined and her case will be heard in court.$mq$, $mq$Her case will be heard in court on Monday.$mq$), mark_scheme=replace(mark_scheme, $mq$She has been fined and her case will be heard in court.$mq$, $mq$Her case will be heard in court on Monday.$mq$)
where paper_id in (select p.id from public.past_papers p join public.subjects s on s.id=p.subject_id where s.slug=$mq$history$mq$ and p.grade=5 and p.title=$mq$History MYP 5 eAssessment Structure Mock A (7 tasks, 76 marks)$mq$)
  and (position($mq$She has been fined and her case will be heard in court.$mq$ in content)>0 or position($mq$She has been fined and her case will be heard in court.$mq$ in coalesce(mark_scheme,''))>0);

-- 68-history-structure-mock-b: Timeline implied the ANC/PAC ban was on 21 March 1960; the ban was in April 1960.
update public.paper_questions set content=replace(content, $mq$The African National Congress (ANC) and the Pan Africanist Congress are banned.$mq$, $mq$In April 1960 the African National Congress (ANC) and the Pan Africanist Congress are banned.$mq$), mark_scheme=replace(mark_scheme, $mq$The African National Congress (ANC) and the Pan Africanist Congress are banned.$mq$, $mq$In April 1960 the African National Congress (ANC) and the Pan Africanist Congress are banned.$mq$)
where paper_id in (select p.id from public.past_papers p join public.subjects s on s.id=p.subject_id where s.slug=$mq$history$mq$ and p.grade=5 and p.title=$mq$History MYP 5 eAssessment Structure Mock B (7 tasks, 76 marks)$mq$)
  and (position($mq$The African National Congress (ANC) and the Pan Africanist Congress are banned.$mq$ in content)>0 or position($mq$The African National Congress (ANC) and the Pan Africanist Congress are banned.$mq$ in coalesce(mark_scheme,''))>0);

-- 127-s6-geography-B: Mark scheme said December is 24 C; Source B gives 23 C.
update public.paper_questions set content=replace(content, $mq$(24 degrees Celsius at the start and end of the year)$mq$, $mq$(24 degrees Celsius in January and February, 23 in December)$mq$), mark_scheme=replace(mark_scheme, $mq$(24 degrees Celsius at the start and end of the year)$mq$, $mq$(24 degrees Celsius in January and February, 23 in December)$mq$)
where paper_id in (select p.id from public.past_papers p join public.subjects s on s.id=p.subject_id where s.slug=$mq$geography$mq$ and p.grade=5 and p.title=$mq$Geography MYP 5 eAssessment Paper B (7 tasks, 68 marks)$mq$)
  and (position($mq$(24 degrees Celsius at the start and end of the year)$mq$ in content)>0 or position($mq$(24 degrees Celsius at the start and end of the year)$mq$ in coalesce(mark_scheme,''))>0);

-- 123-s6-economics-A: Unit-elastic PED by simple percentage change does not keep revenue constant for a 25% change; actual revenue falls 6.25%.
update public.paper_questions set content=replace(content, $mq$so revenue stays about the same$mq$, $mq$so revenue changes only a little (daily revenue falls from 20,000 to 18,750 dollars)$mq$), mark_scheme=replace(mark_scheme, $mq$so revenue stays about the same$mq$, $mq$so revenue changes only a little (daily revenue falls from 20,000 to 18,750 dollars)$mq$)
where paper_id in (select p.id from public.past_papers p join public.subjects s on s.id=p.subject_id where s.slug=$mq$economics$mq$ and p.grade=5 and p.title=$mq$Economics MYP 5 eAssessment Paper A (7 tasks, 69 marks)$mq$)
  and (position($mq$so revenue stays about the same$mq$ in content)>0 or position($mq$so revenue stays about the same$mq$ in coalesce(mark_scheme,''))>0);

-- 129-s6-history-A: France did not test a nuclear weapon until 1960, so "both ... nuclear weapons" was wrong for 1956.
update public.paper_questions set content=replace(content, $mq$both still had large armed forces and nuclear weapons,$mq$, $mq$both still had large armed forces and Britain had nuclear weapons,$mq$), mark_scheme=replace(mark_scheme, $mq$both still had large armed forces and nuclear weapons,$mq$, $mq$both still had large armed forces and Britain had nuclear weapons,$mq$)
where paper_id in (select p.id from public.past_papers p join public.subjects s on s.id=p.subject_id where s.slug=$mq$history$mq$ and p.grade=5 and p.title=$mq$History MYP 5 eAssessment Paper A (7 tasks, 67 marks)$mq$)
  and (position($mq$both still had large armed forces and nuclear weapons,$mq$ in content)>0 or position($mq$both still had large armed forces and nuclear weapons,$mq$ in coalesce(mark_scheme,''))>0);

-- 75-environmental-systems-structure-mock-a: Undated "now" statistic hedged.
update public.paper_questions set content=replace(content, $mq$It is now about 420 ppm$mq$, $mq$In the early 2020s it was about 420 ppm$mq$), mark_scheme=replace(mark_scheme, $mq$It is now about 420 ppm$mq$, $mq$In the early 2020s it was about 420 ppm$mq$)
where paper_id in (select p.id from public.past_papers p join public.subjects s on s.id=p.subject_id where s.slug=$mq$environmental-systems$mq$ and p.grade=5 and p.title=$mq$Environmental Systems MYP 5 eAssessment Structure Mock A (8 tasks, 80 marks)$mq$)
  and (position($mq$It is now about 420 ppm$mq$ in content)>0 or position($mq$It is now about 420 ppm$mq$ in coalesce(mark_scheme,''))>0);

commit;
