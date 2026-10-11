-- Part 4 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Developing Ideas > Research and Inspiration
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Developing Ideas$mq$, 5, 4 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Research and Inspiration$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Developing Ideas$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Research and Inspiration$mq$ and p.name = $mq$Developing Ideas$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a process journal (or sketchbook) mainly used for?$mq$, $mq$["Recording ideas, research, experiments and reflections as your work develops","Storing only finished artworks","Writing the final exam","Keeping receipts"]$mq$, 0, $mq$A process journal documents thinking and making, giving evidence of development.$mq$, $mq$easy$mq$),
($mq$Which is the best example of primary research for an art project on a local park?$mq$, $mq$["Reading a stranger's blog only","Copying a postcard","Using someone else's photo without credit","Making your own observational drawings and photographs at the park"]$mq$, 3, $mq$Primary research is first-hand: you observe, record and collect your own material.$mq$, $mq$easy$mq$),
($mq$What is a mood board?$mq$, $mq$["A list of exam topics","A final artwork frame","A collage of images, colours, textures and words that capture the feel of a project","A type of paint"]$mq$, 2, $mq$Mood boards gather visual inspiration and help set a direction.$mq$, $mq$easy$mq$),
($mq$Why do artists gather inspiration from other artists?$mq$, $mq$["To copy them exactly","To learn techniques and ideas, then develop their own responses","To avoid making their own choices","To skip experimenting"]$mq$, 1, $mq$Looking at artists' work informs ideas, but the aim is to develop your own original response.$mq$, $mq$easy$mq$),
($mq$What does it mean to credit a source?$mq$, $mq$["To say clearly where an image or idea came from","To hide the source","To sell the source","To make the source smaller"]$mq$, 0, $mq$Acknowledging sources shows honesty and supports good research habits.$mq$, $mq$easy$mq$),
($mq$A student researching 'water' as a theme lists: photos of waves, a poem about rain, paintings by Hokusai, and their own sketches of a river. What does this show?$mq$, $mq$["Only secondary research","Only primary research","No research","A range of sources, including primary and secondary research"]$mq$, 3, $mq$Their own sketches are primary; the poem and paintings are secondary sources.$mq$, $mq$medium$mq$),
($mq$Which method best turns research into creative ideas?$mq$, $mq$["Copying one picture exactly","Waiting for inspiration","Brainstorming, sketching thumbnails and selecting the strongest ideas","Choosing the first idea only"]$mq$, 2, $mq$Generating many ideas and then choosing and refining leads to stronger results.$mq$, $mq$medium$mq$),
($mq$A mind map for a project on 'identity' includes branches for family, culture, hobbies and memories. What is its purpose?$mq$, $mq$["To record marks","To explore the theme and connect possible directions","To display the final result","To list materials"]$mq$, 1, $mq$Mind maps generate and connect ideas before deciding on a direction.$mq$, $mq$medium$mq$),
($mq$An artist-study page includes a copy of a painting, notes on colour, line and composition, and a link to the student's own plan. Why is the link important?$mq$, $mq$["It shows how the research will influence their own work","It replaces the analysis","It is unnecessary","It proves the student copied"]$mq$, 0, $mq$Research gains value when it informs your own decisions.$mq$, $mq$medium$mq$),
($mq$Which source is generally the most reliable when researching an artist's life?$mq$, $mq$["An anonymous comment","A random meme","An unverified social post","A museum or gallery website or an established art reference"]$mq$, 3, $mq$Reliable sources are written by experts, show authors and can be checked.$mq$, $mq$medium$mq$),
($mq$A student says: 'Looking at other artists is cheating.' Which reply is best?$mq$, $mq$["Yes, never look at others","Copy only the best one","Artists study others constantly; it is fine if you analyse, credit and make original work","Hide your references"]$mq$, 2, $mq$Learning from artists is expected. Plagiarism is the problem: presenting others' work as your own.$mq$, $mq$medium$mq$),
($mq$What is a 'visual reference'?$mq$, $mq$["A rule for spelling","An image, object or scene you look at to inform your drawing or painting","A frame for display","A glossary"]$mq$, 1, $mq$References can be photographs, objects, or direct observation.$mq$, $mq$medium$mq$),
($mq$A student wants to avoid copying an artist's painting in a project. What approach helps?$mq$, $mq$["Take a technique or idea from the artist and apply it to your own subject and style","Trace the painting","Change the signature","Copy it in a different size"]$mq$, 0, $mq$Transform what you learn into new work with your own subject and decisions.$mq$, $mq$medium$mq$),
($mq$Why is it useful to annotate research pages?$mq$, $mq$["Notes make pages longer","Notes are just decoration","Notes remove the need for images","Notes explain what you noticed and how it will influence your work"]$mq$, 3, $mq$Annotation shows understanding and links research to development.$mq$, $mq$hard$mq$),
($mq$A student's research is a collection of nice pictures with no notes. What is the main weakness?$mq$, $mq$["It uses too many images","It is too colourful","It does not show analysis or how it informs their own ideas","It is too neat"]$mq$, 2, $mq$Research should be selected, analysed and connected to the student's intentions.$mq$, $mq$hard$mq$),
($mq$A student wants to explore a global issue, such as plastic waste, through art. Which research combination is strongest?$mq$, $mq$["Only one photograph","Data or articles, artists who address the issue, and the student's own observations","Only a title","Only copying a poster"]$mq$, 1, $mq$Combining factual context, artists' approaches and personal observation gives depth and originality.$mq$, $mq$hard$mq$),
($mq$When selecting images for an inspiration page, which test is most useful?$mq$, $mq$["Does each image help answer a question about my theme, technique or intention?","Is it the biggest image?","Does it match the page colour?","Is it the first search result?"]$mq$, 0, $mq$Purposeful selection makes research relevant and manageable.$mq$, $mq$hard$mq$),
($mq$A student photographs people in a market without asking, for a portfolio piece. What is the best next step?$mq$, $mq$["Post the photos with names","Ignore consent since it's public","Give photos to strangers","Consider consent and privacy, ask permission where appropriate, and avoid showing identifiable people without agreement"]$mq$, 3, $mq$Ethical research respects people's privacy and consent.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Research and Inspiration$mq$ and p.name = $mq$Developing Ideas$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Primary research$mq$, $mq$First-hand: your own observation, drawings, photographs, experiments, interviews or gallery visits.$mq$),
($mq$Secondary research$mq$, $mq$Second-hand: books, websites, museum collections, articles and other artists' work.$mq$),
($mq$Mood board$mq$, $mq$A collage of images, colours, textures and words that capture the feel and direction of a project.$mq$),
($mq$Mind map$mq$, $mq$A diagram branching out from a theme to explore ideas and connect directions.$mq$),
($mq$Plagiarism$mq$, $mq$Presenting another person's work or ideas as your own. Avoid it by transforming ideas, crediting sources and being honest.$mq$),
($mq$How to study an artist well$mq$, $mq$Describe and analyse their work, explain technique and context, then show what you will take and apply to your own subject.$mq$),
($mq$Referencing images$mq$, $mq$Record title, creator, source and date accessed; check licences and credit the creator.$mq$),
($mq$Annotating research$mq$, $mq$Notes that explain what you noticed and how it will influence your work, linking research to development.$mq$),
($mq$Ethics in research$mq$, $mq$Respect copyright, ask consent before photographing or interviewing people, and keep their privacy.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Research and Inspiration$mq$ and p.name = $mq$Developing Ideas$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Strong artworks rarely appear from nowhere. They grow from curiosity, investigation and thoughtful choices. In MYP Arts, research and inspiration sit at the start of the creative process and feed criterion C (Thinking creatively) as well as criterion A (Knowing and understanding). Your process journal is where this thinking lives.

## What research looks like in art
Research means finding out about your theme, artists, techniques, contexts and audiences, then deciding what to do with it. It is not just collecting pretty pictures.
- **Primary research**: first-hand. You observe objects, draw from life, take photographs, interview someone, visit a gallery or run your own experiments with materials.
- **Secondary research**: second-hand. You study books, websites, museum collections, articles, documentaries and other artists' work.
A good project uses both. Your own observation adds originality, while secondary sources give context and ideas.

## Finding and choosing inspiration
Inspiration can come from a theme, a place, a memory, an object, music, a news story or another artist. To gather it:
- Build a **mood board** of images, colours, textures and words that capture the feel of an idea.
- Make a **mind map** to explore a theme such as 'identity' or 'water' and connect possible directions.
- Look at several artists with different approaches, not only one.
- Collect samples: textures, rubbings, colour swatches, photographs.
Select with purpose. Ask: does this help answer a question about my theme, technique or intention?

## Studying other artists
When you study an artist, do more than copy. Describe their work, analyse the elements and principles, explain their technique and context, and then show what you will take from them. A study might include a small copy exercise to learn the technique, but then you must apply that technique to **your own subject**. That is how learning from others differs from plagiarism, which means presenting someone else's work or ideas as your own.

## Referencing and honesty
Always credit images and sources. Keep a list as you go: title, creator, website or book and the date you accessed it. Check copyright and licences before using images in a final piece. Be honest in your journal about what you made and what came from elsewhere. Consider consent and privacy if you photograph or interview people.

## From research to ideas
Turn your research into ideas using brainstorming, thumbnail sketches, scale models and quick experiments. Create several ideas and then choose the strongest, explaining why. Annotate your pages. Notes such as 'I like how the artist uses overlapping transparent layers; I will test this with tissue paper' show a clear link between research and development.

## Common mistakes
- Gathering lots of images with no notes or analysis.
- Using only internet searches and no first-hand observation.
- Copying an artist's work instead of learning from their approach.
- Forgetting to credit sources.
- Using unreliable sources.

## How this is examined
Questions might show a research page description and ask how to improve it, ask which source type is primary, or ask which choice best links research to a plan. They reward purposeful, analysed, ethical research.

Exam tip: finish every research page with a sentence beginning 'This will influence my work by...'. It shows the link between inspiration and your own ideas.$mq$ from st;

-- Developing Ideas > Experimenting and Refining
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Developing Ideas$mq$, 5, 4 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Experimenting and Refining$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Developing Ideas$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Experimenting and Refining$mq$ and p.name = $mq$Developing Ideas$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Why do artists experiment with different materials and techniques?$mq$, $mq$["To discover what works best for their ideas","To waste time","To avoid decisions","To copy others"]$mq$, 0, $mq$Experimentation reveals the strengths and limits of materials and leads to better choices.$mq$, $mq$easy$mq$),
($mq$What is a test piece (or sample)?$mq$, $mq$["The final artwork","A written exam","A sales receipt","A small trial to check how a material or technique behaves"]$mq$, 3, $mq$Test pieces reduce risk before you commit to the final work.$mq$, $mq$easy$mq$),
($mq$Which activity is part of refining a drawing?$mq$, $mq$["Throwing it away without reflection","Signing it only","Improving proportions, adding detail and adjusting tones","Changing nothing"]$mq$, 2, $mq$Refinement means making deliberate improvements.$mq$, $mq$easy$mq$),
($mq$An artist makes three thumbnail sketches of a composition before starting. What is the purpose?$mq$, $mq$["To fill the page","To compare layouts quickly and choose the strongest","To avoid planning","To replace the final work"]$mq$, 1, $mq$Thumbnails are small and fast, so you can test ideas cheaply.$mq$, $mq$easy$mq$),
($mq$What does 'iteration' mean in art development?$mq$, $mq$["Repeating a process with improvements each time","Using one attempt only","Copying","Selling work"]$mq$, 0, $mq$Iteration means making versions, reflecting, and improving.$mq$, $mq$easy$mq$),
($mq$A student tries painting with a sponge, a card edge and a brush to create tree bark. What are they doing?$mq$, $mq$["Finishing their final piece","Copying a photo","Cleaning brushes","Experimenting with tools to find the best texture"]$mq$, 3, $mq$Trying different tools helps find the most effective marks for the intention.$mq$, $mq$medium$mq$),
($mq$After a test, a student notes that thick ink bled on thin paper. What is the best response?$mq$, $mq$["Ignore the problem","Hide the test","Try thicker paper or less ink, and record the result","Use thinner paper"]$mq$, 2, $mq$Responding to problems with changes and recording them shows development.$mq$, $mq$medium$mq$),
($mq$A student's first design is cluttered. Which refinement is likely to help?$mq$, $mq$["Add more shapes","Simplify the composition and strengthen the focal point","Reduce contrast everywhere","Use more different colours"]$mq$, 1, $mq$Reducing clutter and strengthening emphasis improves clarity.$mq$, $mq$medium$mq$),
($mq$Why should failed experiments stay in your process journal?$mq$, $mq$["They show learning and explain later decisions","They are embarrassing","They are not allowed","They make the journal longer only"]$mq$, 0, $mq$Documenting what did not work, and why, is valuable evidence of reflection.$mq$, $mq$medium$mq$),
($mq$A student combines watercolour and wax resist. The wax repels the paint. Which result occurs?$mq$, $mq$["The paint sinks into the wax","The wax turns the paint into oil","Nothing changes","Waxed areas stay white or the paper colour while the rest takes colour"]$mq$, 3, $mq$Wax resists water-based paint, which is useful for textures and highlights.$mq$, $mq$medium$mq$),
($mq$Which method helps you evaluate whether a composition is working?$mq$, $mq$["Look only at close range","Never get feedback","Step back, view it from a distance, take a photo or ask for feedback","Wait until it is finished"]$mq$, 2, $mq$Distance and feedback show balance and focal points that are hard to notice up close.$mq$, $mq$medium$mq$),
($mq$An artist photographs their work-in-progress at each stage. How does this help?$mq$, $mq$["It replaces the artwork","It documents development and allows comparison between versions","It hides mistakes","It is required to sell the work"]$mq$, 1, $mq$Photographs record progress and support reflection.$mq$, $mq$medium$mq$),
($mq$A student tests four colour palettes for a poster and picks the one with the clearest contrast. What is the key decision method?$mq$, $mq$["Comparing options against the intention and choosing with reasons","Choosing at random","Choosing the cheapest","Choosing the first palette"]$mq$, 0, $mq$Informed decisions link evidence from experiments to the aims.$mq$, $mq$medium$mq$),
($mq$A student's first print has uneven ink. They adjust roller pressure and test again. Which skill does this show?$mq$, $mq$["Ignoring feedback","Giving up","Copying","Problem-solving through trial and improvement"]$mq$, 3, $mq$Identifying a problem, changing a variable and retesting is deliberate refinement.$mq$, $mq$hard$mq$),
($mq$Why is it useful to change only one variable at a time in an experiment (for example the paper type, but not the ink)?$mq$, $mq$["It saves paper","It makes it look neat","You can tell which change caused the result","It prevents any difference"]$mq$, 2, $mq$Fair testing helps you understand cause and effect, as in other subjects.$mq$, $mq$hard$mq$),
($mq$A student reviews feedback: 'The shadows are too flat.' Which refinement responds best?$mq$, $mq$["Reduce contrast","Add a wider range of values and a darker darkest tone","Use only mid-greys","Erase the shadows"]$mq$, 1, $mq$Feedback should lead to specific changes that address the issue.$mq$, $mq$hard$mq$),
($mq$A student must decide whether to keep a surprising accident (an ink blot) in a drawing. What is the most mature approach?$mq$, $mq$["Consider whether it supports the intention and keep it if it helps, noting the decision","Always remove accidents","Always keep accidents","Ignore the drawing"]$mq$, 0, $mq$Artists often use chance creatively, but decisions should relate to purpose.$mq$, $mq$hard$mq$),
($mq$Which of these shows the strongest development from experiment to final piece?$mq$, $mq$["Three unrelated samples then a different final piece","A final piece with no preparation","A copy of a sample with no change","Samples lead to a selected technique, a justified plan and a final work that uses it with improvements"]$mq$, 3, $mq$Clear links between experiments, decisions and outcome demonstrate development.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Experimenting and Refining$mq$ and p.name = $mq$Developing Ideas$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Test piece / sample$mq$, $mq$A small trial of a material or technique to see how it behaves before using it in the final work.$mq$),
($mq$Thumbnail sketches$mq$, $mq$Quick small drawings of possible compositions used to compare ideas and choose the strongest.$mq$),
($mq$Iteration$mq$, $mq$Repeating the process with improvements each time: make, reflect, adjust, remake.$mq$),
($mq$Fair test in art$mq$, $mq$Change only one variable at a time (e.g. paper type) so you know what caused the result.$mq$),
($mq$Maquette$mq$, $mq$A small preliminary model used to plan a sculpture or 3D design.$mq$),
($mq$Ways to refine a work$mq$, $mq$Adjust composition, elements, craftsmanship and respond to feedback.$mq$),
($mq$Wax resist$mq$, $mq$Wax repels water-based paint, leaving the waxed areas uncoloured; useful for texture and highlights.$mq$),
($mq$Why keep failed experiments?$mq$, $mq$They show learning, explain later decisions and provide evidence of development.$mq$),
($mq$Try, observe, decide$mq$, $mq$A simple structure for annotation: what you tried, what happened, and what you will do next.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Experimenting and Refining$mq$ and p.name = $mq$Developing Ideas$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Experimenting and refining are the heart of making art. Few artists get a perfect result on the first try. They test materials, make mistakes, notice what happens, and gradually improve. In MYP Arts this is central to criterion B (Developing skills) and criterion C (Thinking creatively). Your process journal should show this journey, not just the result.

## Why experiment?
Experiments help you:
- Discover how materials behave (does this ink bleed? does this clay crack?).
- Find new effects and unexpected ideas.
- Reduce risk before working on the final piece.
- Build technical skill through practice.
- Choose techniques that suit your intention.
Treat every experiment as a question: 'What happens if I...?' Then record the answer.

## Test pieces and samples
Make small **test pieces** or samples on the same kind of surface as your final work. Try:
- Different tools (brush, sponge, card edge, stick).
- Different materials (pencil, ink, wax resist, collage).
- Different colour mixes and palettes.
- Different pressures, layers and drying times.
When you test, change **one variable at a time** so you can see what causes the effect, as in a fair test in science. Label each sample and write what you did and what you learned.

## Thumbnails and drafts
**Thumbnail sketches** are quick small drawings of possible compositions. They let you compare layouts cheaply. Draft versions go further: a mock-up of a poster, a maquette (small model) of a sculpture or a digital draft. Compare options against your intention and choose with reasons.

## Refining
**Refining** means improving deliberately. This can involve:
- Adjusting composition: simplify, strengthen the focal point, change balance.
- Adjusting elements: increase value contrast, change colour temperature, vary line.
- Improving craftsmanship: neater cutting, cleaner edges, more control.
- Responding to feedback from teachers, peers or your intended audience.
**Iteration** means repeating the process with improvements each time. Step back from your work, view from a distance, photograph it, and ask others what they notice.

## Using problems and chance
Problems are information. If paint cracks, work out why and adjust. Sometimes accidents are useful, such as a drip that adds energy. Decide whether it supports your intention, and note your decision.

## Documenting the process
Annotate your pages with what you tried, what happened, what you learned and what you will do next. Include failures. Photograph work at each stage. This evidence shows that you can evaluate and respond to your work.

## Common mistakes
- Making a single sample and jumping to the final piece.
- Changing many variables at once.
- Hiding failed experiments.
- Not linking experiments to the final decision.

## How this is examined
Questions describe an experiment or draft and ask what to change, what a result shows, or which sequence best demonstrates development.

Exam tip: use the pattern try, observe, decide. 'I tried a card edge to apply paint; it gave sharper lines; so I will use it for the building outlines.'$mq$ from st;

-- Developing Ideas > Planning and Reviewing Work
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Developing Ideas$mq$, 5, 4 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Planning and Reviewing Work$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Developing Ideas$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Planning and Reviewing Work$mq$ and p.name = $mq$Developing Ideas$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a project plan?$mq$, $mq$["A schedule and list of steps, materials and tasks needed to complete the work","The final artwork","A review of the exam","A gallery label"]$mq$, 0, $mq$A plan helps you manage time and resources.$mq$, $mq$easy$mq$),
($mq$Which of these is a good first step when planning a large artwork?$mq$, $mq$["Buy expensive materials immediately","Start the final piece without any sketches","Ignore the deadline","Define your idea and intention"]$mq$, 3, $mq$Knowing your idea guides decisions about materials, techniques and timing.$mq$, $mq$easy$mq$),
($mq$Why make a materials list?$mq$, $mq$["To make the work longer","To avoid decisions","To make sure you have what you need and can prepare in advance","To impress the audience"]$mq$, 2, $mq$Preparing equipment avoids delays and wasted lessons.$mq$, $mq$easy$mq$),
($mq$What does 'reviewing' your work mean?$mq$, $mq$["Selling the work","Checking progress against your aims and deciding what to do next","Throwing it away","Ignoring feedback"]$mq$, 1, $mq$Review stops you drifting from your goals and supports improvement.$mq$, $mq$easy$mq$),
($mq$A deadline is in four weeks. Which action best helps?$mq$, $mq$["Breaking the project into smaller steps with dates","Starting the night before","Doing nothing until week 4","Waiting for inspiration"]$mq$, 0, $mq$A timeline with milestones makes progress manageable.$mq$, $mq$easy$mq$),
($mq$A student lists 'Week 1: research; Week 2: experiments; Week 3: final piece; Week 4: evaluate'. What is this?$mq$, $mq$["A mood board","A critique","A glossary","A timeline or schedule"]$mq$, 3, $mq$Timelines allocate time to stages of the process.$mq$, $mq$medium$mq$),
($mq$What is a risk assessment in art?$mq$, $mq$["A judgement of beauty","A list of art movements","Identifying hazards, such as sharp tools or fumes, and planning how to stay safe","A score for neatness"]$mq$, 2, $mq$Safety planning is part of responsible making.$mq$, $mq$medium$mq$),
($mq$A student's clay piece must dry slowly to avoid cracking. How should this affect planning?$mq$, $mq$["Ignore drying time","Allow enough drying and firing time before the deadline","Dry it with a hair dryer on high","Skip the firing"]$mq$, 1, $mq$Material properties influence time scheduling.$mq$, $mq$medium$mq$),
($mq$Which is the best way to respond when a plan does not go as expected?$mq$, $mq$["Review what happened, adjust the plan and record the change","Hide the problem","Give up","Pretend it was planned"]$mq$, 0, $mq$Flexible planning with documented changes shows reflection.$mq$, $mq$medium$mq$),
($mq$Why might a student create a scale drawing or maquette before making a large sculpture?$mq$, $mq$["To avoid using real materials ever","To make the final work smaller","To replace research","To check proportions, structure and stability before committing materials"]$mq$, 3, $mq$Models allow problems to be found early.$mq$, $mq$medium$mq$),
($mq$A peer suggests that your poster text is hard to read. What should you do?$mq$, $mq$["Reject it immediately","Remove all text","Consider the feedback, test a clearer font or colour, and decide with reasons","Copy their poster"]$mq$, 2, $mq$Feedback is useful when evaluated and tested against the purpose.$mq$, $mq$medium$mq$),
($mq$Which question is most useful during an ongoing review?$mq$, $mq$["Is it big?","Is the work communicating my intention to my audience?","Is it finished?","Did someone else make it?"]$mq$, 1, $mq$Review should link evidence in the work to aims.$mq$, $mq$medium$mq$),
($mq$When reviewing, why compare work-in-progress photographs from different stages?$mq$, $mq$["To see how the piece has developed and what changed","To hide the early stages","To create more pages","To avoid revising"]$mq$, 0, $mq$Comparing stages makes progress visible.$mq$, $mq$medium$mq$),
($mq$A student has two weeks left and several tasks. How should they decide priorities?$mq$, $mq$["Do the easiest tasks first only","Begin new experiments","Leave important steps unplanned","Focus first on essential tasks that affect the main intention and quality"]$mq$, 3, $mq$Prioritising by importance to the aim keeps the project achievable.$mq$, $mq$hard$mq$),
($mq$A student keeps adding new ideas and never finishes. What planning strategy would help?$mq$, $mq$["Add more ideas","Change topics weekly","Set a clear scope with checkpoints and decide when to stop exploring","Start again after each lesson"]$mq$, 2, $mq$Scoping helps balance exploration with completion.$mq$, $mq$hard$mq$),
($mq$Which review comment best shows analytical thinking?$mq$, $mq$["I like it","The darker background improves focal emphasis, but the lower left feels empty; I will add a small texture there","Looks fine","It is okay"]$mq$, 1, $mq$Evidence, evaluation and a next step show strong review.$mq$, $mq$hard$mq$),
($mq$A student's plan allows no time for mistakes. Why is this risky?$mq$, $mq$["Problems are normal in making, so a buffer for fixing or redoing is needed","Problems never happen","Buffers are unneeded","Teachers do not mind"]$mq$, 0, $mq$Realistic planning includes contingency time.$mq$, $mq$hard$mq$),
($mq$A student's final evaluation compares the finished piece with their original plan, noting what changed and why. What does this show?$mq$, $mq$["Poor planning","A lack of ideas","Copying a classmate","Reflective, evidence-based review of the whole process"]$mq$, 3, $mq$Linking outcome, plan and decisions shows critical reflection.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Planning and Reviewing Work$mq$ and p.name = $mq$Developing Ideas$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Four planning questions$mq$, $mq$What am I making? Why (intention)? How (techniques and materials)? When (time and deadlines)?$mq$),
($mq$Timeline$mq$, $mq$A schedule that breaks a project into stages with dates, such as research, experiments, drafts, final piece, evaluation.$mq$),
($mq$Maquette$mq$, $mq$A small scale model or scale drawing used to test proportion, structure and stability before the full-size work.$mq$),
($mq$Risk assessment$mq$, $mq$Identifying hazards (e.g. sharp tools, fumes, heat) and planning how to stay safe with ventilation, protection and safe handling.$mq$),
($mq$Why include a time buffer?$mq$, $mq$Problems and drying/firing times are normal in making, so allow spare time to fix or redo steps.$mq$),
($mq$Scope$mq$, $mq$The size and limits of your project. A clear scope helps you finish instead of endlessly adding new ideas.$mq$),
($mq$Reviewing$mq$, $mq$Checking progress against your intention and plan, then deciding on a next action.$mq$),
($mq$Ways to review work$mq$, $mq$Compare with intention, step back or photograph it, get feedback, list strengths and improvements, record next steps.$mq$),
($mq$Strong review comment$mq$, $mq$Specific and evidence-based with a next step, e.g. 'the dark background improves emphasis, but the lower left feels empty; I will add texture.'$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Planning and Reviewing Work$mq$ and p.name = $mq$Developing Ideas$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Good art takes thinking ahead. Planning and reviewing help you manage your time, materials and ideas so that you can make your best work. These habits matter for criterion B (Developing skills) and criterion C (Thinking creatively), and they are essential for portfolio work completed over weeks.

## Planning
A **plan** answers four questions: What am I making? Why (what is my intention)? How (techniques and materials)? When (time)?
- **Clarify the idea**: write a short statement of your intention and audience.
- **Break it into steps**: research, experiments, drafts, final piece, evaluation. Put dates on each stage using a **timeline**.
- **List materials and equipment**: tools, surfaces, paints, digital software, space and any special access. Check what you have and what you need to order or borrow.
- **Consider processes**: drying times for clay, paint or glue, firing schedules and printing set-up take real time.
- **Make a maquette or scale drawing** for large or 3D work so you can test proportion and structure.
- **Do a risk assessment**: identify hazards (sharp tools, fumes, hot equipment) and how to manage them with ventilation, protective equipment and safe handling.

## Time management
- Work back from the deadline. Allow time for the unexpected.
- Prioritise: do the steps that most affect your intention first.
- Set a clear **scope** so that you can finish. Keep extra ideas for later.
- Use checkpoints: at the end of each week, compare progress with the timeline.

## Reviewing
**Reviewing** means stopping at points during the project to ask how it is going and what to do next. Use these steps:
- Compare the work with your intention and plan.
- Step back and view from a distance, or photograph it.
- Seek feedback from peers, teachers and your intended audience.
- Identify strengths and areas to improve.
- Decide on a next action and record it.
A strong review comment is specific and evidence-based: 'The darker background improves the focal emphasis, but the lower left feels empty; I will add a texture there.'

## Flexibility
Plans change. A strong student notices a problem, explains it, adjusts the plan, and records the change in the journal. Changing a plan is not failure; it is evidence of reflection.

## Final evaluation
At the end, compare the finished artwork with your initial aims and plan. Describe what changed, why, what you learned and what you would do differently. Link to evidence from the work and your process pages.

## Common mistakes
- No timeline or leaving the main work until the last lesson.
- Forgetting drying or firing time.
- Ignoring safety.
- Reviewing with vague comments like 'It looks good'.
- Not recording changes to the plan.

## How this is examined
You may be asked to order stages of a project, spot what is missing from a plan, or choose the best review comment or next step.

Exam tip: use specific, evidence-based review language and always end with a next action: 'I will...'.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('visual-arts')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;