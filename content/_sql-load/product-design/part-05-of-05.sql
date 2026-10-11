-- Part 5 of 5: 1 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Drawing and Communicating > Presenting Design Solutions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Drawing and Communicating$mq$, 5, 4 from public.subjects s where s.slug = $mq$product-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Presenting Design Solutions$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$product-design$mq$ and p.grade = 5 and p.name = $mq$Drawing and Communicating$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Presenting Design Solutions$mq$ and p.name = $mq$Drawing and Communicating$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Who should a designer consider when deciding how to present a design?$mq$, $mq$["The audience, such as a client or a manufacturer","Only the designer","Only competitors","Nobody, as presentation does not matter"]$mq$, 0, $mq$A good presentation is matched to its audience: clients need clear appearance, manufacturers need exact details.$mq$, $mq$easy$mq$),
($mq$What is an annotation on a drawing?$mq$, $mq$["A line that shows hidden edges","A type of 3D print","A colour code for paint","A short written note that explains a feature"]$mq$, 3, $mq$Annotations explain materials, sizes, features and reasons, so the drawing communicates more clearly.$mq$, $mq$easy$mq$),
($mq$What is a mood board mostly used to show?$mq$, $mq$["The cost of the product","The strength of a joint","The style, colours and feel of a design","The steps of manufacture"]$mq$, 2, $mq$A mood board collects images and colours that communicate a theme or style.$mq$, $mq$easy$mq$),
($mq$In MYP Design, which criterion asks students to present the chosen design and give reasons for its selection?$mq$, $mq$["Criterion A","Criterion B","Criterion C","Criterion D"]$mq$, 1, $mq$Criterion B includes presenting the chosen design and outlining the reasons for choosing it.$mq$, $mq$easy$mq$),
($mq$What is a cutting list?$mq$, $mq$["A list of the parts and sizes to be cut from materials","A list of customers","A list of safety signs","A list of colours"]$mq$, 0, $mq$A cutting list gives each part, material and dimensions so the maker can plan.$mq$, $mq$easy$mq$),
($mq$A client wants to see how a lamp would look in a living room. Which presentation tool is most suitable?$mq$, $mq$["A plan view with dimensions only","A table of materials only","A list of tools","A rendered image or sketch in colour showing the lamp in context"]$mq$, 3, $mq$Clients respond best to realistic images, which show appearance and context.$mq$, $mq$medium$mq$),
($mq$A planning document lists steps, tools, materials, and the time for each stage of making a stool. What is it?$mq$, $mq$["A mood board","A product analysis","A production plan","A survey"]$mq$, 2, $mq$A production plan shows how the product will be made. It supports Criterion C and the planning drawings in Criterion B.$mq$, $mq$medium$mq$),
($mq$Which of these makes a presentation board clearer?$mq$, $mq$["Crowding as many images as possible","A consistent layout with clear headings and limited text","Using many fonts and colours","Small text so more fits"]$mq$, 1, $mq$Clear structure and consistent style help the viewer find key information quickly.$mq$, $mq$medium$mq$),
($mq$Why might a designer include a sectional view in their final presentation?$mq$, $mq$["To show the inside of a product, such as how parts fit within a case","To show the price","To show the logo","To show the customer's name"]$mq$, 0, $mq$A section cuts through an object in the drawing to reveal internal detail.$mq$, $mq$medium$mq$),
($mq$Which statement best justifies choosing one final design from three ideas?$mq$, $mq$["Idea 2 was drawn last","I like Idea 2","Idea 2 is the biggest","Idea 2 meets 9 of the 10 specification points and is easier to make than the others"]$mq$, 3, $mq$Reasons for selection should link to the specification and to evidence such as ease of manufacture.$mq$, $mq$medium$mq$),
($mq$A student presents a final design with a 3D rendered image, a dimensioned orthographic drawing and a materials list. Why is this combination effective?$mq$, $mq$["It makes the product cheaper","It avoids the need for planning","It communicates appearance, exact sizes and the resources needed","It replaces testing"]$mq$, 2, $mq$Each item has a different job: appearance, precise measurements and resources. Together they give a complete picture.$mq$, $mq$medium$mq$),
($mq$Which is a sign of poor presentation?$mq$, $mq$["Annotated sketches","Unlabelled diagrams with no scale or dimensions","Clear headings","Consistent colours"]$mq$, 1, $mq$Without labels, scale or dimensions the viewer cannot judge the design or make it.$mq$, $mq$medium$mq$),
($mq$A flowchart for manufacturing shows start, process and decision symbols. What is its main use?$mq$, $mq$["To show the order of steps and decisions in making","To show the final appearance","To show body measurements","To record test data"]$mq$, 0, $mq$Flowcharts present sequences clearly, such as 'cut, sand, check size, assemble'.$mq$, $mq$medium$mq$),
($mq$A student's final presentation says 'My design is good.' What would most improve it?$mq$, $mq$["Add more adjectives","Make the font larger","Repeat the sentence on each page","Give evidence, such as test results and links to the specification"]$mq$, 3, $mq$Judgements need evidence. Linking to results and the specification raises the level of the reasoning.$mq$, $mq$hard$mq$),
($mq$A planning chart gives these durations: cut 40 min, sand 30 min, assemble 50 min, finish 60 min (finish begins after assembly, and 25 min of drying then follows). What is the total time to completion if steps run one after another?$mq$, $mq$["180 minutes","155 minutes","205 minutes","230 minutes"]$mq$, 2, $mq$40 + 30 + 50 + 60 + 25 = 205 minutes. Leaving out the drying time gives 180, a common slip.$mq$, $mq$hard$mq$),
($mq$A manufacturer receives a presentation with a beautiful render but no dimensions, materials or tolerances. What is the most likely consequence?$mq$, $mq$["The product will be cheaper","The product cannot be made accurately without asking for more information","The product will be sustainable","The product will be tested faster"]$mq$, 1, $mq$Renders show appearance only. Manufacturing information must be supplied in technical drawings and lists.$mq$, $mq$hard$mq$),
($mq$Two plans for making a lamp are compared. Plan A includes safety checks, tools, time estimates and quality checks at each stage. Plan B lists only 'cut, join, finish'. Which evaluation is best?$mq$, $mq$["Plan A is stronger because it is detailed, logical and anticipates problems","Plan B is stronger because it is shorter","They are the same because both finish the lamp","Plan B is stronger because it has fewer risks"]$mq$, 0, $mq$A top-level plan is logical, detailed enough for another person to follow, and includes safety and quality control.$mq$, $mq$hard$mq$),
($mq$While making, a student changes the joint type because the planned glue joint was too weak. Which action best shows good communication of this change?$mq$, $mq$["Change it silently","Delete the original plan","Say the plan was never needed","Record the change in the plan, explain why, and show the new joint with a sketch"]$mq$, 3, $mq$Criterion C expects students to justify changes made to the plan. Evidence helps the reader see the reasoning.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Presenting Design Solutions$mq$ and p.name = $mq$Drawing and Communicating$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Audience$mq$, $mq$The people a presentation is for. Clients need appearance; manufacturers need exact sizes, materials and steps.$mq$),
($mq$Annotation$mq$, $mq$A short written note on a drawing that explains a feature, material or reason.$mq$),
($mq$Rendered image$mq$, $mq$A realistic, shaded or coloured picture (often from CAD) that shows appearance and context.$mq$),
($mq$Exploded view and sectional view$mq$, $mq$An exploded view separates parts to show assembly. A sectional view cuts through an object to show inside detail.$mq$),
($mq$Mood board$mq$, $mq$A collage of images, colours and textures that communicates the style or feel of a design.$mq$),
($mq$Cutting list$mq$, $mq$A list of parts, materials and sizes to be cut, used for planning making.$mq$),
($mq$Production plan$mq$, $mq$A logical, detailed plan of making steps, tools, materials, times, safety and quality checks.$mq$),
($mq$Justifying the chosen design$mq$, $mq$Compare ideas with the specification and give evidence such as test results or survey data.$mq$),
($mq$Justifying changes (Criterion C)$mq$, $mq$Record any change to the plan, explain why it was needed, and show it with a sketch or photo.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Presenting Design Solutions$mq$ and p.name = $mq$Drawing and Communicating$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Having a great design is not enough: you must also communicate it clearly. **Presenting design solutions** means showing your chosen design, your reasons for choosing it, and how it will be made, in a way that suits your audience. In MYP Design this appears in Criterion B (presenting the chosen design and planning drawings), Criterion C (the plan and justifying changes) and, in the final stage, Criterion D (presenting test results and evaluation clearly).

## Know your audience
The same design can be presented in different ways:
- A **client** or user wants to see how the product looks, feels and solves the problem, so use rendered images, coloured sketches and simple explanations.
- A **manufacturer or technician** needs exact information, so use dimensioned drawings, materials lists and tolerances.
- An **exam or portfolio reader** wants to see your thinking, so link choices to research and the specification.

## Tools for presentation
- **Rendered sketches and CAD images** show appearance and context. Colour, shading and a realistic background make them easy to understand.
- **Orthographic drawings** give exact sizes, using a stated scale and dimensions in millimetres.
- **Exploded views** show how parts fit together. **Sectional views** reveal inside detail.
- **Annotations** explain materials, finishes, features and reasons.
- **Mood boards** express colour and style.
- **Materials lists and cutting lists** give the parts, materials and sizes needed.
- **Flowcharts and time plans** show the order of making steps, with times and quality checks.

## Justifying your chosen design
When you present your final idea, explain **why** it was chosen. Compare ideas against the design specification and give evidence: 'Idea 2 meets 9 of the 10 specification points, uses a joint our workshop can make, and was preferred by 8 of 12 users in the survey.' Statements such as 'I like this one' are weak because they give no evidence.

## Planning the making
A good **production plan** is logical and detailed. Another person should be able to follow it and make the product. It includes:
- The steps in order
- The tools, equipment and materials for each step
- The time for each stage, including waiting time such as glue drying
- Safety precautions
- Quality checks, such as measuring parts against the drawing

Worked example: if cutting takes 40 minutes, sanding 30, assembly 50 and finishing 60, followed by 25 minutes of drying, the total is 40 + 30 + 50 + 60 + 25 = 205 minutes. Remember to include every stage, including waiting.

## Recording changes
Real projects rarely go exactly to plan. If you change a material, joint or method, record what you changed and explain why, supporting this with a sketch or photo. This is what Criterion C means by justifying changes.

## Good layout
Use headings, consistent fonts and colours, clear labels, and a balance of images and text. Avoid clutter. Make sure each image is labelled with what it shows.

## Common mistakes
- A pretty render with no sizes or materials
- Not stating the scale on drawings
- Giving no reasons for the chosen design
- Ignoring the audience
- Changing the plan without recording it

## How this is examined
Questions usually give a short scenario, then ask you to choose the best presentation method for a particular audience, spot what is missing from a plan or drawing, or judge the quality of a justification. Time calculations from a production plan may also appear.

Exam tip: Say who the audience is, then choose the presentation method that gives them exactly what they need and give a reason.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('product-design')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;