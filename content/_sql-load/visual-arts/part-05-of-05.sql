-- Part 5 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Presenting and Reflecting > Curating and Displaying Work
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Presenting and Reflecting$mq$, 5, 5 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Curating and Displaying Work$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Presenting and Reflecting$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Curating and Displaying Work$mq$ and p.name = $mq$Presenting and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a curator?$mq$, $mq$["A person who selects and organises works for an exhibition","A person who sells paint","A person who cleans galleries","A printing machine"]$mq$, 0, $mq$Curators choose which works to show and how to arrange them so the display tells a clear story.$mq$, $mq$easy$mq$),
($mq$What does a label (caption) next to an artwork usually include?$mq$, $mq$["Only the price","Only the colour names","The viewer's name","Title, artist, date, medium and sometimes a short explanation"]$mq$, 3, $mq$Labels provide key information that helps viewers understand the work.$mq$, $mq$easy$mq$),
($mq$Why is lighting important in an exhibition?$mq$, $mq$["It has no effect","It only matters for sculpture","It affects how colours, textures and details are seen","It replaces labels"]$mq$, 2, $mq$Good lighting highlights the work without causing glare, shadows or damage.$mq$, $mq$easy$mq$),
($mq$What is an artist statement?$mq$, $mq$["A shopping list","A short text explaining the ideas and intention behind the work","A weather report","A price tag"]$mq$, 1, $mq$Artist statements help viewers understand your aims and choices.$mq$, $mq$easy$mq$),
($mq$Which hanging height is generally recommended for most 2D works in a gallery?$mq$, $mq$["The centre of the work around average eye level","On the floor","As high as possible","At random heights"]$mq$, 0, $mq$Hanging at eye level makes viewing comfortable and consistent.$mq$, $mq$easy$mq$),
($mq$A student arranges portrait drawings in a group, spacing them evenly with the same frame style. Which principle does this support?$mq$, $mq$["Random chaos","Loss of balance","Asymmetric disorder","Unity and rhythm in the display"]$mq$, 3, $mq$Consistent framing and spacing connect works as a set.$mq$, $mq$medium$mq$),
($mq$Why might a curator group works by theme rather than by date?$mq$, $mq$["Because dates are not important in any exhibition","To hide the works","To help viewers see connections between ideas","To avoid labels"]$mq$, 2, $mq$Thematic groupings tell a story and encourage comparisons.$mq$, $mq$medium$mq$),
($mq$A watercolour is displayed in strong direct sunlight. What is the main risk?$mq$, $mq$["It will get bigger","The colours may fade and the paper be damaged","The paint will get thicker","It will change into oil"]$mq$, 1, $mq$Light, especially UV, can damage sensitive works, so museums control it.$mq$, $mq$medium$mq$),
($mq$A sculpture is placed so that visitors can only see the front. Which problem does this create?$mq$, $mq$["Viewers miss the form from other angles","Viewers see too many colours","It changes materials","It becomes 2D"]$mq$, 0, $mq$3D work should usually be viewable from all sides if designed that way.$mq$, $mq$medium$mq$),
($mq$Which choice is best for presenting a small delicate drawing?$mq$, $mq$["Leaving it loose on the floor","Folding it","Taping it with strong tape to the wall","A clean mount and frame with space around it"]$mq$, 3, $mq$Mounting protects the work and creates a neat visual frame.$mq$, $mq$medium$mq$),
($mq$A digital artwork is to be shown in a school gallery. Which consideration is most relevant?$mq$, $mq$["Only the paint thickness","Whether it has a frame of wood","Screen size, resolution, power, and whether it will play reliably","Whether it is hung with nails"]$mq$, 2, $mq$Digital display needs technology planning and testing.$mq$, $mq$medium$mq$),
($mq$A student arranges works from darkest to lightest across the wall. Which effect might this create?$mq$, $mq$["Randomness","A visual flow guiding viewers along the display","Loss of unity","No movement"]$mq$, 1, $mq$Ordering by value or colour can create rhythm and direction for the viewer.$mq$, $mq$medium$mq$),
($mq$A visitor with limited vision attends your exhibition. Which step improves accessibility?$mq$, $mq$["Provide large-print labels, good lighting and clear paths","Use tiny text","Lower the lighting","Place objects in the walkway"]$mq$, 0, $mq$Accessible design makes displays usable for more people.$mq$, $mq$medium$mq$),
($mq$Why is it useful to test a display layout with a floor plan or mock-up first?$mq$, $mq$["Because real works are not allowed","To avoid curating","To remove the need for labels","To check spacing, viewing flow and what fits before hanging real work"]$mq$, 3, $mq$Mock-ups show problems without risking the artwork.$mq$, $mq$hard$mq$),
($mq$A student includes a QR code on a label linking to a video of their process. What is the purpose?$mq$, $mq$["To hide the artwork","To replace the artwork","To give extra context for interested viewers","To reduce information"]$mq$, 2, $mq$Extra media can enrich the viewer's understanding while keeping labels short.$mq$, $mq$hard$mq$),
($mq$An exhibition aims to raise awareness of ocean pollution. Which curatorial decision best supports this aim?$mq$, $mq$["Hanging works in random order with no text","Using a cool, consistent palette in the display, a clear introduction panel and a layout that builds from problem to solution","Using only unrelated paintings","Hiding the title"]$mq$, 1, $mq$The display should reinforce the message through text, layout and design.$mq$, $mq$hard$mq$),
($mq$Two classmates curate the same set of eight works. One group displays them in a crowded cluster with a small label; the other spaces them with clear pathways and consistent labels. Which statement is most accurate?$mq$, $mq$["The second approach likely improves viewing and communicates more clearly","The first approach is always better","Spacing has no effect","Labels reduce understanding"]$mq$, 0, $mq$Space, consistency and clarity help viewers focus and understand.$mq$, $mq$hard$mq$),
($mq$A student considers whether to display a controversial artwork in a school exhibition. What is the most responsible approach?$mq$, $mq$["Hide the context","Ignore the audience","Remove all labels","Consider audience, context and school guidelines, and add contextual information"]$mq$, 3, $mq$Curators balance freedom of expression with audience, age and policies, and explain context.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Curating and Displaying Work$mq$ and p.name = $mq$Presenting and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Curator$mq$, $mq$A person who selects, organises and explains artworks for an exhibition.$mq$),
($mq$Ways to group work$mq$, $mq$By theme, technique, colour, chronology or idea, to help viewers see connections.$mq$),
($mq$Hanging height for 2D work$mq$, $mq$Generally with the centre of the work near average eye level, with consistent spacing.$mq$),
($mq$What goes on a label?$mq$, $mq$Title, artist, date, medium and, if useful, a short note. Keep it clear, readable and consistent.$mq$),
($mq$Artist statement$mq$, $mq$A short text explaining your intention and ideas behind the work, in your own words.$mq$),
($mq$Lighting for display$mq$, $mq$Show colour and texture clearly without glare or heat; avoid strong direct sunlight, which can fade work.$mq$),
($mq$Displaying 3D work$mq$, $mq$Use plinths or tables at comfortable height and allow viewing from all sides if the piece is designed that way.$mq$),
($mq$Accessible exhibitions$mq$, $mq$Clear pathways, good lighting, large readable text and consideration for different visitors' needs.$mq$),
($mq$Why make a floor plan or mock-up?$mq$, $mq$To test spacing, flow and fit before hanging real work, avoiding problems and damage.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Curating and Displaying Work$mq$ and p.name = $mq$Presenting and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Presenting your work is the final stage of making. A thoughtful display helps viewers understand your ideas, and it shows that you care about your art. Curating and displaying work is part of the MYP Arts cycle of exploring, making and presenting, and it relates strongly to criterion D (Responding), where you communicate and evaluate your work for an audience.

## What is curating?
A **curator** selects and organises artworks for an exhibition and decides how they are displayed and explained. Even in a school show, you act as a curator when you choose which pieces to include and how to arrange them. Good curators think about the **audience**, the **message** and the **space**.

## Choosing and grouping work
- Select pieces that show your best work and your creative journey, not simply everything you made.
- Group works by **theme**, **technique**, **colour**, **chronology** (order made) or **idea**. Groupings help viewers see connections.
- Create a **flow**: where will visitors begin and end? Use an opening piece or panel to introduce the idea and a strong finishing piece.
- Consider balance and rhythm in the layout: repeated frames, even spacing and aligned edges create unity. A single larger work can act as a focal point.

## Display techniques
- **2D works**: mount or frame them to protect and present them. Hang with the centre near average eye level. Keep spacing consistent.
- **3D works**: use plinths or tables at a comfortable height, and allow viewers to walk around if the piece is designed to be viewed from all sides.
- **Digital works**: plan for screens, projection, sound, power and testing. Check that files play reliably and loop correctly.
- **Lighting**: choose lighting that shows colours and textures without glare or heat. Avoid strong direct sunlight, which can fade or damage works.
- **Safety**: secure heavy objects, keep walkways clear, and use safe fixings.

## Labels and text
Labels should be clear and consistent: title, artist, date, medium and a short note if useful. An **artist statement** explains your intention and ideas in your own words. Use readable fonts and enough contrast, and keep text concise. A QR code can link to extra material such as a process video.

## Accessibility and audience
Think about who will visit. Provide clear pathways, good lighting, text large enough to read, and consider seating or alternative formats. If an artwork deals with sensitive topics, give context and think about the age of the audience and school guidelines.

## Planning and testing
Make a **floor plan** or mock-up before hanging real work. Test sightlines, spacing and where people will stand. Ask for feedback during setup.

## Common mistakes
- Crowding too many works close together.
- Inconsistent labels or frames that distract from the art.
- Poor lighting or glare.
- Forgetting protection and safety.
- Not explaining the idea to the audience.

## How this is examined
Questions describe an exhibition situation and ask for the best arrangement, label content, or display choice for a given aim or audience. Look for answers that match the message and care for both artwork and visitors.

Exam tip: link each display decision to audience and intention: 'Even spacing and matching frames create unity so the viewer reads the six portraits as one series.'$mq$ from st;

-- Presenting and Reflecting > Reflecting on Your Own Work
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Presenting and Reflecting$mq$, 5, 5 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Reflecting on Your Own Work$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Presenting and Reflecting$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Reflecting on Your Own Work$mq$ and p.name = $mq$Presenting and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is reflection in the creative process?$mq$, $mq$["Thinking critically about what you made, how, and what you learned","Looking in a mirror","Copying a model","Selling work"]$mq$, 0, $mq$Reflection links evidence in your work to your learning and next steps.$mq$, $mq$easy$mq$),
($mq$Which sentence is reflective?$mq$, $mq$["I painted a picture","It is done","I like painting","I learned that layering thin glazes gave me smoother tones than one thick coat"]$mq$, 3, $mq$A reflective statement explains what you did, what happened and what you learned.$mq$, $mq$easy$mq$),
($mq$Why should you reflect during the process, not just at the end?$mq$, $mq$["So you can avoid finishing","Because the final piece is not important","So you can improve your work while you are still making it","Because reflection replaces art"]$mq$, 2, $mq$Ongoing reflection guides decisions and development.$mq$, $mq$easy$mq$),
($mq$Which prompt best starts a reflection?$mq$, $mq$["Who is the winner?","What worked well and what would I change?","Is it big?","How many pages did I fill?"]$mq$, 1, $mq$Questions about success and change prompt analysis and planning.$mq$, $mq$easy$mq$),
($mq$What does 'strength' mean in an evaluation of your work?$mq$, $mq$["A part that works well and achieves your aim","A heavy item","A rule","A mistake"]$mq$, 0, $mq$Strengths and weaknesses should be identified with reasons.$mq$, $mq$easy$mq$),
($mq$A student writes: 'The final piece is good.' How could it be improved?$mq$, $mq$["Add the word very","Remove all details","Write it again the same way","Add evidence and explanation of why it is effective for the intention"]$mq$, 3, $mq$Evidence-based comments are stronger than general opinions.$mq$, $mq$medium$mq$),
($mq$Why compare your final work with your original intention?$mq$, $mq$["To find a different subject","To copy it","To judge how far you achieved your aims","To avoid improving"]$mq$, 2, $mq$Measuring outcome against aims shows how successful the work is.$mq$, $mq$medium$mq$),
($mq$Which kind of feedback is generally most useful for reflection?$mq$, $mq$["General praise","Specific comments linked to your aims from different viewers","Insults","A single word"]$mq$, 1, $mq$Specific, varied feedback reveals strengths and blind spots.$mq$, $mq$medium$mq$),
($mq$A student says their sculpture collapsed because the base was too narrow. What does this show?$mq$, $mq$["Honest identification of a cause and a lesson for next time","A poor attitude","A reason to hide the work","Something not worth recording"]$mq$, 0, $mq$Naming causes of problems and what you will change is high-quality reflection.$mq$, $mq$medium$mq$),
($mq$Which of these links reflection to future action best?$mq$, $mq$["I hope it goes better","Nothing to change","It was bad","Next time I will test the paint on the paper first, because it bled in my final piece"]$mq$, 3, $mq$Reflection that sets specific next steps shows growth.$mq$, $mq$medium$mq$),
($mq$A student reflects on how a classmate's feedback changed their idea. What should they include?$mq$, $mq$["Only who gave it","Only the date","What the feedback was, what they changed and the effect of the change","Only that they disagreed"]$mq$, 2, $mq$Showing how feedback influenced decisions demonstrates responsiveness.$mq$, $mq$medium$mq$),
($mq$Which format could be used for reflection in a portfolio?$mq$, $mq$["Only a single title","Annotated images, written notes, video or audio commentary","Only a signature","Only a price"]$mq$, 1, $mq$Reflection can take many forms, as long as it is clear and evidence-based.$mq$, $mq$medium$mq$),
($mq$Why is it valuable to reflect on your own learning and not only the artwork?$mq$, $mq$["It shows what skills and ideas you have developed","It replaces the artwork","It is optional in all cases","It makes the project shorter"]$mq$, 0, $mq$Learning reflection includes skills, approaches and changes in thinking.$mq$, $mq$medium$mq$),
($mq$A student wants to be balanced in a self-evaluation. Which approach is best?$mq$, $mq$["Only list successes","Only list failures","Avoid details","Discuss both successes and limitations with evidence"]$mq$, 3, $mq$Balanced evaluation is more credible and useful.$mq$, $mq$hard$mq$),
($mq$A student writes: 'My use of warm complementary accents gave a clear focal point, but the empty lower third weakened balance. Next I will add a darker foreground.' Which features make this strong?$mq$, $mq$["Length only","Use of the word accents","Evidence, evaluation of effect and a specific next step","A vague opinion"]$mq$, 2, $mq$It names choices, judges their effect and plans improvement.$mq$, $mq$hard$mq$),
($mq$A student believes reflection is just saying sorry for mistakes. Which correction is best?$mq$, $mq$["Reflection is blaming others","Reflection is analysing decisions and outcomes to learn and improve, whether things went well or not","Reflection is only for failures","Reflection is optional decoration"]$mq$, 1, $mq$Reflection covers successes and problems alike.$mq$, $mq$hard$mq$),
($mq$A classmate says your work does not communicate your stated aim of peace, because the palette is harsh. How should you respond reflectively?$mq$, $mq$["Consider the evidence, test alternatives such as softer colours, and record what you decide and why","Ignore the comment","Change the aim secretly","Argue the viewer is wrong"]$mq$, 0, $mq$Taking feedback seriously and testing a response shows critical thinking.$mq$, $mq$hard$mq$),
($mq$Which statement shows the deepest reflection on creative thinking?$mq$, $mq$["I chose the first idea","I followed the teacher's example","I did not change anything","I rejected my first idea because it copied the artist too closely, and combined two sketches to make a more original concept"]$mq$, 3, $mq$Explaining how and why ideas evolved shows creative thinking and self-awareness.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Reflecting on Your Own Work$mq$ and p.name = $mq$Presenting and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Three areas of reflection$mq$, $mq$The work (how well it communicates), the process (what you tried and solved), and yourself as a learner (skills developed, response to feedback).$mq$),
($mq$Reflective chain$mq$, $mq$'I did... because... it resulted in... so next time I will...'$mq$),
($mq$Why reflect during the process?$mq$, $mq$So you can improve the work while you are still making it, not only at the end.$mq$),
($mq$Strong vs weak reflection$mq$, $mq$Strong: specific, evidence-based, balanced, ends with action. Weak: vague opinion such as 'I like it' or 'it was good'.$mq$),
($mq$Strengths and limitations$mq$, $mq$A balanced self-evaluation identifies both with reasons. Honesty about problems is a sign of maturity.$mq$),
($mq$Using feedback$mq$, $mq$Record it, decide which comments to act on, explain your choices and note the effect of changes.$mq$),
($mq$Forms of reflection$mq$, $mq$Annotations, voice or video recordings, labelled photographs, draft comparisons or a final evaluation page.$mq$),
($mq$Comparing with intention$mq$, $mq$Judge how far the final work achieves your original aims, using visible evidence.$mq$),
($mq$Reflection ends with...$mq$, $mq$Action: say what you will test, change or research next, linking one piece of work to the next.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Reflecting on Your Own Work$mq$ and p.name = $mq$Presenting and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Reflection is the thinking you do about your art and about yourself as an artist. It turns experience into learning. In MYP Arts you reflect throughout the process in your journal and at the end in an evaluation. It supports criterion C (Thinking creatively), criterion B (Developing skills) and criterion D (Responding).

## What reflection includes
Good reflection covers three areas:
- **The work**: what it looks like, how elements and principles were used, how well it communicates your intention.
- **The process**: what you tried, what worked, what did not, and how you solved problems.
- **Yourself as a learner**: what skills and ideas you developed, how you responded to feedback and what you would do next.

## Reflection prompts
Use questions to start:
- What was my intention and did I achieve it?
- What worked well and why? What would I change?
- What did feedback show me, and what did I do about it?
- Which decisions most improved the work?
- What did I learn about the media, the theme or myself?
- How does my work connect to the artists and contexts I studied?

## Reflecting with evidence
Compare a vague comment and a strong one. 'I like my painting' is an opinion. 'The warm accents against a cool background created a clear focal point, but the empty lower third weakened the balance' uses evidence and judgement. Tie each point to something visible in the work, a sample or a photograph, and be specific.

## Balanced and honest
A trustworthy self-evaluation identifies both **strengths** and **limitations**. If something failed, explain the cause and what you learned. For example: 'The sculpture collapsed because the base was too narrow; next time I will build a wider base and test the structure.' Honest reflection is a sign of maturity, not weakness.

## Using feedback
Gather feedback from teachers, classmates and your intended audience. Record what they said, decide which comments to act on, and note the effect of your changes. You do not need to accept every suggestion, but you should consider each and justify your choices.

## Looking forward
Reflection ends with action. Say what you will do next: test a new material, adjust a composition, research an artist or plan a bigger project. This links one piece of work to the next and shows development.

## Forms of reflection
Reflection can be written annotations, voice or video recordings, labelled photographs, side-by-side comparisons of drafts, or a final evaluation page. Choose the form that makes your thinking clearest.

## Common mistakes
- Only describing what you did, without judging it.
- Using vague praise or criticism.
- Hiding problems.
- Leaving reflection until the very end.
- Not linking comments to evidence or next steps.

## How this is examined
Questions give sample reflections and ask which is strongest, how to improve a weak one, or what a next step should be. Choose answers that include evidence, judgement and action.

Exam tip: use the chain 'I did... because... it resulted in... so next time I will...'.$mq$ from st;

-- Presenting and Reflecting > Using the Arts Criteria
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Presenting and Reflecting$mq$, 5, 5 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Using the Arts Criteria$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Presenting and Reflecting$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Using the Arts Criteria$mq$ and p.name = $mq$Presenting and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$How many criteria are used to assess MYP Arts?$mq$, $mq$["Four","Two","Three","Five"]$mq$, 0, $mq$MYP Arts is assessed with criteria A, B, C and D.$mq$, $mq$easy$mq$),
($mq$What is criterion A in MYP Arts?$mq$, $mq$["Developing skills","Thinking creatively","Responding","Knowing and understanding"]$mq$, 3, $mq$Criterion A covers knowledge of the art form, its concepts, and its context.$mq$, $mq$easy$mq$),
($mq$What is criterion B in MYP Arts?$mq$, $mq$["Knowing and understanding","Thinking creatively","Developing skills","Responding"]$mq$, 2, $mq$Criterion B focuses on applying skills and techniques and showing artistic process.$mq$, $mq$easy$mq$),
($mq$What is criterion C in MYP Arts?$mq$, $mq$["Responding","Thinking creatively","Knowing and understanding","Developing skills"]$mq$, 1, $mq$Criterion C is about developing a creative idea, exploring options and taking risks.$mq$, $mq$easy$mq$),
($mq$What is criterion D in MYP Arts?$mq$, $mq$["Responding","Developing skills","Thinking creatively","Knowing and understanding"]$mq$, 0, $mq$Criterion D is about responding to and evaluating art, including your own work and its context.$mq$, $mq$easy$mq$),
($mq$What is the maximum level a student can earn in each criterion?$mq$, $mq$["Level 7","Level 6","Level 10","Level 8"]$mq$, 3, $mq$MYP achievement levels run from Levels 1-8 within each criterion.$mq$, $mq$medium$mq$),
($mq$Levels are grouped into bands. Which band contains Level 5?$mq$, $mq$["1–2","3–4","5–6","7–8"]$mq$, 2, $mq$Bands are 1–2, 3–4, 5–6 and 7–8.$mq$, $mq$medium$mq$),
($mq$What is the maximum total mark across all four criteria?$mq$, $mq$["28","32","24","40"]$mq$, 1, $mq$Four criteria × a maximum of Level 8 gives 32.$mq$, $mq$medium$mq$),
($mq$A teacher says your work 'demonstrates excellent knowledge of art concepts and context'. Which criterion is this?$mq$, $mq$["A: Knowing and understanding","B: Developing skills","C: Thinking creatively","D: Responding"]$mq$, 0, $mq$Knowledge of concepts, conventions and context is criterion A.$mq$, $mq$medium$mq$),
($mq$A student's journal shows several experiments, evidence of technical improvement and use of the media with control. Which criterion does this mainly support?$mq$, $mq$["A: Knowing and understanding","D: Responding","None of them","B: Developing skills"]$mq$, 3, $mq$Application of skills and techniques, plus process, is criterion B.$mq$, $mq$medium$mq$),
($mq$A student explores unusual ideas, tests different directions and develops an original concept. Which criterion is this?$mq$, $mq$["A: Knowing and understanding","B: Developing skills","C: Thinking creatively","D: Responding"]$mq$, 2, $mq$Creative thinking involves ideas, exploration and a willingness to take risks.$mq$, $mq$medium$mq$),
($mq$A student writes a critical evaluation of their finished piece and compares it with other artists. Which criterion does this relate to?$mq$, $mq$["A: Knowing and understanding","D: Responding","B: Developing skills","C: Thinking creatively"]$mq$, 1, $mq$Evaluating and reflecting on art and its context is criterion D.$mq$, $mq$medium$mq$),
($mq$A student has a very good, finished artwork but no journal pages or experiments. Which criteria are at risk?$mq$, $mq$["B and C, because process evidence is limited","Only criterion A","None","Criterion D only"]$mq$, 0, $mq$Without process evidence, development of skills and creative thinking cannot be shown clearly.$mq$, $mq$medium$mq$),
($mq$A student receives Levels 6, 5, 7 and 6 across criteria A, B, C and D. What is their total?$mq$, $mq$["22","26","20","24"]$mq$, 3, $mq$6 + 5 + 7 + 6 = 24 out of 32. A separate conversion is later used to give an overall subject grade.$mq$, $mq$hard$mq$),
($mq$A student has a total of 20 across the four criteria. Which statement is accurate?$mq$, $mq$["Their average is Level 4","Their average is Level 6","Their average is Level 5 per criterion","Their average cannot be found"]$mq$, 2, $mq$20 ÷ 4 = 5.$mq$, $mq$hard$mq$),
($mq$A teacher's feedback says 'Your evaluation lists what you did but doesn't judge how well it worked'. Which action will best raise the criterion D level?$mq$, $mq$["Add more pictures only","Add specific judgements about effectiveness with evidence and reasons","Remove the evaluation","Make the text bigger"]$mq$, 1, $mq$Higher levels in D need critical, evidence-based evaluation, not just description.$mq$, $mq$hard$mq$),
($mq$A student plans to improve their criterion C level. Which action fits best?$mq$, $mq$["Generate several different ideas, justify the selected one and show how it develops through exploration","Copy the first idea","Choose the safest design without exploring","Skip planning"]$mq$, 0, $mq$Creative thinking rewards exploring alternatives, developing ideas and taking considered risks.$mq$, $mq$hard$mq$),
($mq$A student's work is secure on criterion B but they struggle on A. Which approach helps most?$mq$, $mq$["Add more decoration","Make the work larger","Ignore the vocabulary","Research art concepts and contexts, and use correct vocabulary in explanations of how their work relates to them"]$mq$, 3, $mq$Criterion A rewards knowledge and understanding, shown through accurate terminology and context links.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Using the Arts Criteria$mq$ and p.name = $mq$Presenting and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$The four MYP Arts criteria$mq$, $mq$A: Knowing and understanding. B: Developing skills. C: Thinking creatively. D: Responding.$mq$),
($mq$Achievement levels$mq$, $mq$Each criterion is marked in Levels 1-8, grouped into bands 1–2, 3–4, 5–6 and 7–8.$mq$),
($mq$Maximum total$mq$, $mq$32 (four criteria × Level 8). Totals are converted to an overall subject grade on a separate scale using boundaries.$mq$),
($mq$Criterion A evidence$mq$, $mq$Accurate vocabulary, knowledge of concepts, processes and conventions, and links to context.$mq$),
($mq$Criterion B evidence$mq$, $mq$Control of media, experiments, drafts, and visible improvement in skills across the process.$mq$),
($mq$Criterion C evidence$mq$, $mq$A clear intention, alternative ideas, risk-taking and justified decisions as the concept develops.$mq$),
($mq$Criterion D evidence$mq$, $mq$Critical evaluation of your own and others' art, comparisons, and understanding of context and impact.$mq$),
($mq$Descriptor words$mq$, $mq$Lower to higher: limited, adequate, substantial, excellent. Higher levels show detail, insight and justification.$mq$),
($mq$Why keep process evidence?$mq$, $mq$A strong final piece alone cannot show criteria B and C; journals, tests and drafts demonstrate development and creative thinking.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Using the Arts Criteria$mq$ and p.name = $mq$Presenting and Reflecting$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Your MYP Arts work is judged using four assessment criteria. Knowing them well lets you plan your portfolio, understand your teacher's feedback and target the next level. Remember that MYP achievement uses **Levels 1-8** for each criterion.

## The four criteria
- **Criterion A: Knowing and understanding.** You show knowledge of the art form, its concepts, processes and conventions, and of the contexts in which art is made. You use subject vocabulary accurately and explain how knowledge informs your work.
- **Criterion B: Developing skills.** You learn and apply skills and techniques, and demonstrate the application of those skills in your art. This shows through your control of media, your experiments, and evidence of improving craft across the process.
- **Criterion C: Thinking creatively.** You develop a clear artistic intention, explore alternative ideas, take risks and show how your concept evolves. Original thinking and well-justified decisions are key.
- **Criterion D: Responding.** You respond to and evaluate art, including your own and that of others, in different cultural and historical contexts. You reflect critically and communicate your understanding of the impact of art on people and society.

## Levels, bands and totals
Each criterion is marked from Level 1 to Level 8. Levels are grouped into four bands: 1–2, 3–4, 5–6 and 7–8. A criterion level is chosen by comparing your work with the descriptors and finding the best fit. The four criterion levels are added to give a total out of 32. Teachers then use grade boundaries to convert the total into an overall subject grade, reported on a separate scale. Always keep the two apart: criterion achievement is Levels 1-8, while the overall grade is a different scale.

Example: Levels of 6, 5, 7 and 6 add up to 24 out of 32. Dividing by four gives an average of Level 6 per criterion.

## How levels differ
Descriptors move from limited to excellent. At the lower bands, work shows limited or basic knowledge, skills or ideas, with little explanation. In the middle bands, work shows adequate to substantial understanding, with good control and some explanation. At the top band, work shows excellent, insightful, well-justified and consistent quality supported by detailed evidence. Words to watch: **limited, adequate, substantial, excellent**; **basic, good, extensive**; **superficial, sound, detailed, critical**.

## Evidence matters
- For A, show vocabulary, concepts and context.
- For B, keep process evidence: tests, drafts and photographs of stages.
- For C, show alternatives, risks and reasons for decisions.
- For D, include critical evaluation, comparisons and links to context.
A great finished piece with no process evidence cannot demonstrate B and C fully.

## Using the criteria to improve
Read the descriptors for the next band up and turn them into a checklist. Ask your teacher for examples. Self-assess your journal using the same language. Spend your effort on the criterion you find weakest.

## Common mistakes
- Thinking only the final artwork matters.
- Writing description where evaluation is needed.
- Forgetting vocabulary and context.
- Confusing criteria letters, for example C (creative thinking) with D (responding).

## How this is examined
Questions test whether you can match evidence to criteria, calculate totals from levels, and decide the best action to reach a higher level.

Exam tip: memorise the sequence A Knowing, B Developing, C Thinking creatively, D Responding, and the total of 32 across four criteria.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('visual-arts')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;