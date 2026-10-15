-- Humanities and English accuracy fixes for the live DB.
-- Rows are matched by exact old text. Run in the Supabase SQL editor.
begin;

-- content/economics-myp5/03-elasticity.json / Price Elasticity of Demand / Q7
update public.questions set content = $mq$A cafe cuts the price of a party sandwich tray from $50 to $45. Orders rise from 200 to 260. What is the PED (ignoring the sign) and the revenue change?$mq$ where content = $mq$A cafe cuts the price of a sandwich from $50 to $45 per party tray. Orders rise from 200 to 260. What is the PED (ignoring the sign) and the revenue change?$mq$ and explanation = $mq$%ΔP = −10%; %ΔQ = +30%; PED = 30 ÷ 10 = 3 (elastic). Revenue: 50 × 200 = $10,000 and 45 × 260 = $11,700, so a price cut increases revenue when demand is elastic.$mq$;

-- content/english-language-and-literature-myp5/02-language-techniques.json / Figurative Language / Q0
update public.questions set explanation = $mq$A simile compares two things using 'like' or 'as'. 'The classroom was a library' is a metaphor, 'whispered' is personification and the remaining option is a figurative phrase, not a simile.$mq$ where content = $mq$Which sentence contains a simile?$mq$ and explanation = $mq$A simile compares two things using 'like' or 'as'. The second option is a metaphor and the others use personification.$mq$;

-- content/english-language-and-literature-myp5/03-structure-and-form.json / Narrative Voice and Point of View / Q10
update public.questions set content = $mq$Invented extract: "Tomas shivered. Cold, and nobody coming. Surely someone would come soon? The lane was empty, and the lamp flickered." What is the effect of free indirect style here?$mq$ where content = $mq$Invented extract: "Cold, he thought. Cold, and nobody coming. The lane was empty, and the lamp flickered." What is the effect of free indirect style here?$mq$ and explanation = $mq$Free indirect style presents thoughts without 'he thought' in a separate frame, bringing the reader close.$mq$;

-- content/english-language-and-literature-myp5/07-non-fiction-and-media.json / Articles, Speeches and Opinion Pieces / Q5
update public.questions set content = $mq$Read this invented opening. "Council approves £3 million for a new library after months of protest." Which feature does this sentence show?$mq$ where content = $mq$Read this invented opening. "Council approves £3 million for a new library after months of protest." Which feature is the sentence?$mq$ and explanation = $mq$It states the central facts concisely, typical of headlines and news leads.$mq$;

-- content/english-language-and-literature-myp5/09-creative-writing.json / Descriptive Writing / Q2
update public.questions set explanation = $mq$A simile compares using "like" or "as". 'The moon was a silver coin' is a metaphor because it has no "like" or "as".$mq$ where content = $mq$Which is a simile?$mq$ and explanation = $mq$A simile compares using "like" or "as". The second option is a metaphor.$mq$;

-- content/english-language-and-literature-myp5/10-argument-and-discursive-writing.json / Writing to Persuade / Q7
update public.questions set explanation = $mq$Ethos builds trust by showing the writer's experience or character. The nurse sentence is ethos; the sentence citing studies is logos and the sentence about tired faces is pathos.$mq$ where content = $mq$Which sentence uses ethos (credibility) to persuade?$mq$ and explanation = $mq$Ethos builds trust by showing the writer's experience or character. The second option is logos and the first is pathos.$mq$;

-- content/english-language-and-literature-myp5/10-argument-and-discursive-writing.json / Writing to Persuade / Q16
update public.questions set explanation = $mq$A balanced and specific proposal invites agreement from people who might reject an extreme claim. Writer B does make a suggestion, so the option claiming it avoids making any suggestion is wrong.$mq$ where content = $mq$Writer A says: "Phones must be banned." Writer B says: "Phones should be limited in lessons, and a trial term would let us test the effect on results." Why might Writer B persuade a sceptical reader better?$mq$ and explanation = $mq$A balanced and specific proposal invites agreement from people who might reject an extreme claim. Writer B does make a suggestion, so the last option is wrong.$mq$;

-- content/english-language-and-literature-myp5/11-literary-analysis.json / Writing Analytical Paragraphs / Q4
update public.questions set explanation = $mq$The correct sentence weaves the quote into a clear sentence and then explains it.$mq$ where content = $mq$Which of these is a quotation correctly embedded in a sentence about an invented text?$mq$ and explanation = $mq$The first option weaves the quote into a clear sentence and then explains it.$mq$;

-- content/english-language-and-literature-myp5/11-literary-analysis.json / Writing Analytical Paragraphs / Q15
update public.questions set explanation = $mq$The second student unpicks the word's meaning and what it implies, which is deeper than a general label.$mq$ where content = $mq$A student writes: "The word 'drifted' shows she was sad." Another writes: "'Drifted' suggests a lack of direction, so her sadness is shown as aimless rather than dramatic." Why is the second better?$mq$ and explanation = $mq$The second answer unpicks the word's meaning and what it implies, which is deeper than a general label.$mq$;

-- content/english-language-and-literature-myp5/12-language-accuracy.json / Spelling, Vocabulary and Editing / Q10
update public.questions set explanation = $mq$The concise version says the same with the fewest words. The version beginning "In spite of the fact" also changes the meaning.$mq$ where content = $mq$A student is editing for concision. Which version is best?$mq$ and explanation = $mq$The first version says the same with fewer words. The last option also changes the meaning.$mq$;

-- content/english-language-and-literature-myp5/12-language-accuracy.json / Register and Style Control / Q16
update public.questions set explanation = $mq$The pair that says "We regret to inform you" to parents and "Bad news, everyone" to students matches formality to each audience. In the pair with the registers swapped, the formal wording goes to students and the casual wording to parents.$mq$ where content = $mq$Which pair of sentences shows the writer adapting the tone for different audiences about the same event?$mq$ and explanation = $mq$The first pair matches formality to each audience. In the second pair, the registers are reversed.$mq$;

-- content/gap/history/01-health-and-medicine-through-time.json / Modern Medicine and Global Health Challenges / Q11
update public.questions set explanation = $mq$Vaccines create immunity before illness and reduce spread in communities. Like all medicines they can have rare side effects, so the claim that vaccines have no side effects at all is false.$mq$ where content = $mq$Why might a global health organisation encourage vaccination programmes rather than only treatment?$mq$ and explanation = $mq$Vaccines create immunity before illness and reduce spread in communities. Like all medicines they can have rare side effects, so the claim in the last option is false.$mq$;

-- content/gap/history/03-ideas-and-ideologies.json / Nationalism, Liberalism and Socialism / Q4
update public.questions set content = $mq$Which Prussian statesman, later Chancellor of the German Empire, was the main architect of German unification in 1871?$mq$ where content = $mq$Which Prussian chancellor was the main architect of German unification in 1871?$mq$ and explanation = $mq$Bismarck used wars against Denmark (1864), Austria (1866) and France (1870-71) to unite Germany under Prussian leadership.$mq$;

-- content/geography-myp5/07-population.json / Population Policies and Challenges / Q16
update public.questions set explanation = $mq$Strict limits can cause serious social and ethical issues. Voluntary approaches often reduce fertility through education and choice, but usually more slowly, so the claims that voluntary methods are faster in every case or that strict limits are always cheaper overstate the case.$mq$ where content = $mq$Which is the strongest justification for a government choosing voluntary policies (education, contraception) over strict limits such as fines?$mq$ and explanation = $mq$Strict limits can cause serious social and ethical issues. Voluntary approaches often reduce fertility through education and choice, but usually more slowly, so options A and B overstate the case.$mq$;

-- content/geography-myp5/08-urbanisation.json / Urban Growth and Megacities / Q3
update public.questions set content = $mq$Which of these cities is among the largest urban areas in the world, with more than 30 million people in its greater metropolitan area?$mq$ where content = $mq$Which of these cities is among the largest urban areas in the world, with a population of around 37 million in the greater metropolitan area?$mq$ and explanation = $mq$Greater Tokyo is one of the world's largest urban agglomerations, with more than 30 million people (estimates vary with the definition and the year). The other three are small cities.$mq$;

commit;

-- Third independent accuracy review (humanities). Idempotent: each statement matches the old text exactly.
begin;

-- history-myp5/06 Fascism and Nazism: OVRA dating (parties banned 1926, OVRA from 1927)
update public.notes n set content = replace(n.content, $mq$By 1925–26 Mussolini ruled as **Il Duce**: opposition parties were banned, newspapers were censored, a secret police (OVRA) operated, and propaganda promoted his cult.$mq$, $mq$By 1926 Mussolini ruled as **Il Duce**: opposition parties were banned, newspapers were censored, a secret police (OVRA, set up in 1927) operated, and propaganda promoted his cult.$mq$)
from public.topics t join public.subjects s on s.id = t.subject_id
where n.topic_id = t.id and s.slug = 'history' and t.grade = 5 and n.content like '%By 1925–26 Mussolini ruled as **Il Duce**%';

update public.questions q set explanation = $mq$By 1926 he had banned opposition parties and censored newspapers, and from 1927 he used secret police such as the OVRA.$mq$
from public.topics t join public.subjects s on s.id = t.subject_id
where q.topic_id = t.id and s.slug = 'history' and t.grade = 5
  and q.explanation = $mq$By 1925–26 he had banned opposition parties, censored newspapers and used secret police such as the OVRA.$mq$;

-- gap/history/06 Superpower Rivalry and Regional Blocs Q11: ambiguous wording
update public.questions q set content = $mq$In 1957 six countries founded the European Economic Community. By 2020 the European Union had 27 members. How many more members did the EU have in 2020 than the six founding members?$mq$
from public.topics t join public.subjects s on s.id = t.subject_id
where q.topic_id = t.id and s.slug = 'history' and t.grade = 5
  and q.content = $mq$In 1957 six countries founded the European Economic Community. By 2020 the European Union had 27 members. How many countries joined after 1957?$mq$;

-- papers: 128 Geography S6 C, Q4(c) mark scheme
update public.paper_questions pq set mark_scheme = replace(pq.mark_scheme, $mq$Site B: 3 + 1 + (2 x 1) + 3 = 8 + 1 = 9.$mq$, $mq$Site B: 3 + 1 + (2 x 1) + 3 = 9.$mq$)
from public.past_papers p join public.subjects s on s.id = p.subject_id
where pq.paper_id = p.id and s.slug = 'geography' and p.grade = 5 and pq.mark_scheme like '%Site B: 3 + 1 + (2 x 1) + 3 = 8 + 1 = 9.%';

-- papers: 70 Geography Structure Mock B, Q4(e) and Q7 mark schemes
update public.paper_questions pq set mark_scheme = replace(replace(pq.mark_scheme,
  $mq$so renewable output must increase from 36 PJ to 420 PJ$mq$, $mq$so wind and solar output must increase from 36 PJ to 420 PJ$mq$),
  $mq$so the remaining 30 million gap would be exceeded within about two years$mq$, $mq$so the remaining gap would more than double within about two years (30 + 2 x 23 = 76 million cubic metres)$mq$)
from public.past_papers p join public.subjects s on s.id = p.subject_id
where pq.paper_id = p.id and s.slug = 'geography' and p.grade = 5 and p.title like 'Geography MYP 5 eAssessment Structure Mock B%'
  and (pq.mark_scheme like '%so renewable output must increase from 36 PJ%' or pq.mark_scheme like '%remaining 30 million gap would be exceeded%');

commit;
