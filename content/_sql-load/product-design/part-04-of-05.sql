-- Part 4 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Designing for People > Design Briefs and Specifications
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Designing for People$mq$, 5, 3 from public.subjects s where s.slug = $mq$product-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Design Briefs and Specifications$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$product-design$mq$ and p.grade = 5 and p.name = $mq$Designing for People$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Design Briefs and Specifications$mq$ and p.name = $mq$Designing for People$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a design brief?$mq$, $mq$["A short statement describing the problem or need and what will be designed","A detailed list of every material and tool","A drawing of the final prototype","A report about the testing results"]$mq$, 0, $mq$The brief summarises the need, user and context in a few sentences. The detailed requirements come in the specification.$mq$, $mq$easy$mq$),
($mq$What is the purpose of a design specification?$mq$, $mq$["To advertise the product","To record a sales total","To show the colour of a logo","To list the requirements the final solution must meet"]$mq$, 3, $mq$A specification sets out the success criteria that the product will be judged against.$mq$, $mq$easy$mq$),
($mq$Which MYP Design criterion asks students to develop a design specification?$mq$, $mq$["Criterion A: Inquiring and analysing","Criterion C: Creating the solution","Criterion B: Developing ideas","Criterion D: Evaluating"]$mq$, 2, $mq$Criterion B includes developing a design specification that states the success criteria. The brief is developed in Criterion A.$mq$, $mq$easy$mq$),
($mq$Which is a measurable specification point?$mq$, $mq$["The bag should be nice","The bag must hold at least 8 kg without tearing","The bag should be modern","The bag should be popular"]$mq$, 1, $mq$Measurable points include numbers and units so they can be tested. Words like nice or modern are subjective.$mq$, $mq$easy$mq$),
($mq$The word 'client' in a design project means what?$mq$, $mq$["The person or group who needs the solution","The person who sells the tools","The teacher's assistant","The factory manager only"]$mq$, 0, $mq$The client is the person or group whose problem the designer is solving.$mq$, $mq$easy$mq$),
($mq$A student writes: 'Design a storage unit for a small bedroom that helps a teenager keep sports kit organised.' This is best described as which?$mq$, $mq$["A specification","A test plan","An evaluation","A design brief"]$mq$, 3, $mq$It gives the need, user and context in a sentence, with no measurable detail yet.$mq$, $mq$medium$mq$),
($mq$Which specification point is best written?$mq$, $mq$["The stand should be small","The stand must look good","The stand must be no taller than 300 mm so it fits under a standard shelf","The stand will be made quickly"]$mq$, 2, $mq$A strong point includes a measurable limit and a reason that links to the user's context.$mq$, $mq$medium$mq$),
($mq$The factors often used to organise a specification (such as function, size, safety, cost, aesthetics, materials, environment and the user) help the student to do what?$mq$, $mq$["Choose the cheapest material","Make sure all important areas are covered","Avoid researching","Skip testing"]$mq$, 1, $mq$A checklist of factors stops the designer forgetting an important requirement.$mq$, $mq$medium$mq$),
($mq$Which pair of terms best describes ways to rank requirements?$mq$, $mq$["Must-have and should-have","Round and square","Early and late","Light and dark"]$mq$, 0, $mq$Prioritising requirements into must-haves and should-haves helps choose between ideas and test the solution fairly.$mq$, $mq$medium$mq$),
($mq$Why should each specification point be linked to research?$mq$, $mq$["It makes the document longer","It allows the student to copy a product","It removes the need for a brief","It justifies the requirement with evidence"]$mq$, 3, $mq$Linking to research (such as a survey result) shows the requirement is based on real needs.$mq$, $mq$medium$mq$),
($mq$A survey shows 14 of 20 users want the lunchbox to fit in a bag pocket 180 mm wide. Which specification point best uses this?$mq$, $mq$["The lunchbox should be wide","The lunchbox must fit 20 bags","The lunchbox must be less than 180 mm wide, so it fits in the bag pocket (14 of 20 users asked for this)","The lunchbox will be 14 mm wide"]$mq$, 2, $mq$The best point is measurable, testable and states the research reason. 14 of 20 is 70% of users.$mq$, $mq$medium$mq$),
($mq$During testing, how is the specification used?$mq$, $mq$["As a way to market the product","As the list of success criteria to judge the product against","As a drawing of the finished design","As a record of the time spent"]$mq$, 1, $mq$In Criterion D the student tests the product against the specification to decide how successful it is.$mq$, $mq$medium$mq$),
($mq$Which of these is a weakness in a brief?$mq$, $mq$["It describes the final product's exact shape before research","It names the user","It describes the context","It states the need"]$mq$, 0, $mq$A brief should state the problem, not decide the answer in advance. That keeps room for creative ideas.$mq$, $mq$medium$mq$),
($mq$Which of these specification points is NOT testable?$mq$, $mq$["The product will weigh less than 450 g","The handle will be at least 25 mm in diameter","The product must withstand 30 drops from 1 m","The product will be exciting"]$mq$, 3, $mq$Exciting is a personal opinion with no test. The other points have numbers and can be checked.$mq$, $mq$hard$mq$),
($mq$A student's brief says: 'Make a phone stand from acrylic.' A teacher says it is too narrow. What is the main problem?$mq$, $mq$["It mentions a phone","It is too short to be a brief","It names a material before research, which limits possible solutions","It lacks a price"]$mq$, 2, $mq$A brief should present the need and context. Choosing the material too early takes away options for Criterion B.$mq$, $mq$hard$mq$),
($mq$A specification states: 'Must be safe for children aged 6 to 8.' Which revision makes this stronger for testing?$mq$, $mq$["Make it very safe","No sharp edges: all corners rounded to a radius of at least 3 mm, and no parts smaller than 30 mm","Children should like it","Avoid anything dangerous"]$mq$, 1, $mq$The revision gives measurable limits for safety that can be checked with a ruler or gauge.$mq$, $mq$hard$mq$),
($mq$A student tests a torch against a specification. It meets 7 of 10 points but the 3 failed points are all 'must-have' safety features. Which judgement is most justified?$mq$, $mq$["The product is not successful because the failed points are essential","The product is successful because 70% were passed","The test is invalid because torches cannot be tested","The product is perfect since most points were met"]$mq$, 0, $mq$Not all points have equal weight. Failing must-have safety points is more serious than missing a nice-to-have feature.$mq$, $mq$hard$mq$),
($mq$Two students write specifications for the same bike light. Student 1 lists 'bright, small, cheap'. Student 2 lists 'visible from 100 m at night, under 60 g, material cost under 4 dollars', each linked to a survey result. Which statement is the best comparison?$mq$, $mq$["Student 1 is stronger because the points are shorter","They are equal because both mention brightness","Student 1 is stronger because there is less to test","Student 2 is stronger because the points are measurable and justified by research"]$mq$, 3, $mq$A top-level specification is detailed, measurable and justified, which supports higher achievement levels in Criterion B.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Design Briefs and Specifications$mq$ and p.name = $mq$Designing for People$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Design brief$mq$, $mq$A short statement of the need, user and context. It describes the problem, not the finished solution.$mq$),
($mq$Design specification$mq$, $mq$A list of requirements and success criteria that the final solution must meet; used again when testing.$mq$),
($mq$Which criterion covers the specification?$mq$, $mq$Criterion B (Developing ideas); the brief belongs to Criterion A, and the specification is used for testing in Criterion D.$mq$),
($mq$Measurable specification point$mq$, $mq$A requirement with a number and unit, such as 'weigh less than 450 g', so it can be tested.$mq$),
($mq$Why justify a specification point?$mq$, $mq$Linking it to research (survey, interview, data) shows the requirement is based on real needs.$mq$),
($mq$Must-have vs should-have$mq$, $mq$Must-have points are essential to the design; should-have points are desirable but not vital.$mq$),
($mq$Common specification factors$mq$, $mq$Function, user, size, safety, materials, environment, aesthetics and cost.$mq$),
($mq$Weakness in a brief$mq$, $mq$Naming the final material or shape before research, which limits creative options.$mq$),
($mq$Using the specification in testing$mq$, $mq$It is the checklist for judging how successful the product is; failed must-haves are the most serious.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Design Briefs and Specifications$mq$ and p.name = $mq$Designing for People$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Every successful design project starts by being clear about the problem and what a good solution must do. Two documents help with this: the **design brief** and the **design specification**. Students often mix them up, so it is worth knowing the difference clearly.

## The design brief
A **design brief** is a short statement, usually a few sentences, that explains the need, who the product is for, and the context in which it will be used. It does not describe the solution in detail. For example: 'Design a compact storage solution that helps a teenager keep football kit organised in a small shared bedroom.' This brief names the user (a teenager), the need (organised kit storage) and the context (a small shared bedroom), but it does not say what the product looks like or what it is made from. A good brief leaves room for creative ideas. In MYP Design, the brief is developed at the end of Criterion A, using the results of your research and product analysis.

## The design specification
A **design specification** is a list of requirements that the final solution must meet. It states the success criteria, which is why it appears in Criterion B and then returns in Criterion D when you test and evaluate your product. Each point should be:
- **Measurable**: include numbers and units where possible
- **Testable**: someone should be able to check whether it has been met
- **Justified**: linked to research such as a survey, an interview, anthropometric data or a product analysis

Compare a weak point and a strong point.
- Weak: 'The box should be small.'
- Strong: 'The box must be no longer than 300 mm so that it fits under the bed, as 12 of 15 survey respondents said under-bed space was their main complaint.'

## Organising your specification
Many students use headings or factors to make sure nothing is forgotten, for example:
- **Function**: what the product must do, e.g. hold 6 kg of kit
- **User and ergonomics**: grip size, height, reach
- **Size and weight**: maximum dimensions and mass
- **Safety**: no sharp edges, non-toxic finishes
- **Materials and manufacture**: available tools and skills
- **Environment and sustainability**: recyclable materials, durability
- **Aesthetics**: colour, style and finish
- **Cost**: a maximum budget

You can also rank points as **must-have** (essential) or **should-have** (desirable). This helps when choosing between ideas and when judging the final product.

## Using the specification later
When you generate ideas, you compare each design against the specification. When you test your prototype, the specification becomes your checklist. If your product fails a must-have point, you should explain why and suggest an improvement. Design is **iterative**, so it is fine to update the brief or specification when new evidence appears, as long as you explain the change.

## Common mistakes
- Naming the material or the finished product in the brief before researching.
- Using vague words such as 'nice', 'good', 'modern' or 'strong' with no measurement.
- Writing a specification that is not linked to research.
- Treating every point equally when some are essential.

## How this is examined
Questions might give a short design scenario and ask you to choose the strongest brief or specification point, spot why a point cannot be tested, or judge a product against a set of success criteria. You may also be asked to justify a requirement using data from a survey.

Exam tip: Check every specification point for a number, a unit and a reason. If it has none of these, rewrite it before you use it.$mq$ from st;

-- Drawing and Communicating > Sketching and Orthographic Drawing
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Drawing and Communicating$mq$, 5, 4 from public.subjects s where s.slug = $mq$product-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Sketching and Orthographic Drawing$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$product-design$mq$ and p.grade = 5 and p.name = $mq$Drawing and Communicating$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Sketching and Orthographic Drawing$mq$ and p.name = $mq$Drawing and Communicating$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the main purpose of a quick thumbnail sketch in the early design stage?$mq$, $mq$["To explore many ideas rapidly","To show the final dimensions","To plan the manufacturing steps","To test the strength of a material"]$mq$, 0, $mq$Thumbnail sketches are small, fast drawings used to generate and compare many ideas.$mq$, $mq$easy$mq$),
($mq$How many views are usually shown in a basic orthographic drawing of an object?$mq$, $mq$["One only","Two: top and bottom only","Six: always","Three: front, side and plan"]$mq$, 3, $mq$The standard set is front elevation, side elevation and plan (top) view, drawn at right angles to each other.$mq$, $mq$easy$mq$),
($mq$Which line type is used to show hidden edges in a technical drawing?$mq$, $mq$["A thick continuous line","A wavy line","Short dashes","A dotted double line"]$mq$, 2, $mq$Hidden detail is drawn as thin dashed lines so the viewer knows an edge exists behind a surface.$mq$, $mq$easy$mq$),
($mq$In an isometric drawing, at what angle are the sloping axes drawn from the horizontal?$mq$, $mq$["45 degrees","30 degrees","60 degrees from the vertical only","90 degrees"]$mq$, 1, $mq$Isometric drawings use vertical lines and two axes at 30° to the horizontal, which keeps all lengths at full scale.$mq$, $mq$easy$mq$),
($mq$What does a scale of 1:2 mean on a drawing?$mq$, $mq$["The drawing is half the size of the real object","The drawing is twice the size of the object","The drawing is the same size as the object","The object has two parts"]$mq$, 0, $mq$1:2 means each unit on the drawing represents 2 units on the object, so the drawing is half size.$mq$, $mq$easy$mq$),
($mq$On a drawing at scale 1:5, a line is 24 mm long. What is the real length of this edge?$mq$, $mq$["4.8 mm","29 mm","240 mm","120 mm"]$mq$, 3, $mq$Real length is 24 × 5 = 120 mm. Dividing by 5 gives 4.8, which is the common wrong step.$mq$, $mq$medium$mq$),
($mq$A designer wants to show how a hinge and its screws fit together, with parts pulled apart along a line. Which drawing is most suitable?$mq$, $mq$["A plan view only","A thumbnail sketch only","An exploded view","A flat pattern of the hinge"]$mq$, 2, $mq$An exploded view separates parts in their assembly order so the viewer can see how they fit.$mq$, $mq$medium$mq$),
($mq$In third angle orthographic projection, where is the plan view placed relative to the front view?$mq$, $mq$["Directly below it","Directly above it","To its left","Behind it on another sheet"]$mq$, 1, $mq$In third angle projection the plan sits above the front view and the right-hand end view is placed to the right of the front view.$mq$, $mq$medium$mq$),
($mq$Which drawing method gives the most realistic image by making objects appear smaller as they get further away?$mq$, $mq$["Perspective drawing","Isometric drawing","Orthographic drawing","Exploded drawing"]$mq$, 0, $mq$Perspective uses vanishing points, so parallel lines converge. Isometric and orthographic keep sizes constant.$mq$, $mq$medium$mq$),
($mq$Why are construction lines drawn lightly when sketching a box?$mq$, $mq$["They are the final outline of the object","They show hidden edges","They are required for dimensions","They guide proportion and can be erased or covered by darker outlines"]$mq$, 3, $mq$Light construction lines help set proportions and perspective. The final outline is drawn darker over them.$mq$, $mq$medium$mq$),
($mq$Which of these correctly describes dimensioning on a working drawing?$mq$, $mq$["Every size is estimated by eye","Dimensions are placed inside the object outlines","Sizes are given in millimetres with the unit stated once, and lines do not cross unnecessarily","Sizes are given in different units on the same view"]$mq$, 2, $mq$Dimensions must be clear and consistent so that someone else can make the object without asking questions.$mq$, $mq$medium$mq$),
($mq$A student draws a cube in oblique projection with the front face true shape and the depth lines at 45°. The depth lines are drawn at half length (cabinet oblique). If the real depth is 60 mm, how long are the depth lines on the drawing?$mq$, $mq$["60 mm","30 mm","45 mm","120 mm"]$mq$, 1, $mq$In cabinet oblique the receding lines are drawn at half scale, so 60 ÷ 2 = 30 mm.$mq$, $mq$medium$mq$),
($mq$Which view in an orthographic drawing shows the object as seen from above?$mq$, $mq$["Plan","Front elevation","End elevation","Isometric"]$mq$, 0, $mq$The plan view looks straight down onto the object.$mq$, $mq$medium$mq$),
($mq$A chair leg has a hole drilled through it that cannot be seen from the front. How should the hole appear in the front elevation?$mq$, $mq$["It is not shown anywhere","As a thick continuous line","As a wavy line","As dashed lines showing its hidden edges"]$mq$, 3, $mq$Hidden features that are not visible from a given direction are shown with dashed lines.$mq$, $mq$hard$mq$),
($mq$The front elevation of a rectangular block is 80 mm wide and 40 mm high. Its plan view is 80 mm wide and 25 mm deep. The side elevation (end view) is drawn next to the front view. What size is the side elevation?$mq$, $mq$["80 mm wide and 25 mm high","40 mm wide and 25 mm high","25 mm wide and 40 mm high","80 mm wide and 40 mm high"]$mq$, 2, $mq$The side view shows depth and height, so it is 25 mm across and 40 mm tall. Views must agree with each other.$mq$, $mq$hard$mq$),
($mq$A designer's orthographic drawing has a front view 100 mm wide, while the matching plan view is 90 mm wide. What is the most likely problem?$mq$, $mq$["The drawing is a perspective view","The views are inconsistent, so the drawing is wrong or unclear","The object is rotating","This is normal, as plan views are always smaller"]$mq$, 1, $mq$Width shown in the front and plan views must match. A mismatch means a drawing error.$mq$, $mq$hard$mq$),
($mq$A student needs to present an idea to a client who cannot read technical drawings and also needs a drawing for a workshop technician to make the part. Which combination is best?$mq$, $mq$["A rendered 3D sketch for the client and a dimensioned orthographic drawing for the technician","A dimensioned orthographic drawing for both","A quick thumbnail for both","A rendered sketch for both"]$mq$, 0, $mq$Different audiences need different drawings. A sketch communicates appearance, whereas orthographic drawings give precise manufacturing information.$mq$, $mq$hard$mq$),
($mq$A part is drawn at scale 2:1 and a line measures 36 mm. The student writes the real size as 72 mm. What is the correct size and what error was made?$mq$, $mq$["72 mm; the answer is correct","36 mm; scale has no effect","9 mm; the student divided twice","18 mm; the student multiplied instead of dividing"]$mq$, 3, $mq$2:1 means the drawing is twice the real size, so the real length is 36 ÷ 2 = 18 mm.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Sketching and Orthographic Drawing$mq$ and p.name = $mq$Drawing and Communicating$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Thumbnail sketch$mq$, $mq$A small, quick sketch used early on to explore many ideas.$mq$),
($mq$Isometric drawing$mq$, $mq$A 3D drawing with a vertical axis and two axes at 30° to the horizontal; lengths are drawn at full scale.$mq$),
($mq$Cabinet oblique$mq$, $mq$Front face in true shape, with depth lines at 45° drawn at half length.$mq$),
($mq$Perspective drawing$mq$, $mq$A realistic 3D drawing using vanishing points, so objects get smaller as they get further away.$mq$),
($mq$Orthographic projection$mq$, $mq$Showing an object as separate flat views (front, side and plan) viewed straight on.$mq$),
($mq$Third angle projection$mq$, $mq$The plan view sits above the front view, and the right end view is placed to the right of the front view.$mq$),
($mq$Hidden detail and centre lines$mq$, $mq$Hidden edges use short dashes. Centre lines use long-dash, short-dash chain lines.$mq$),
($mq$Scale 1:2 and 2:1$mq$, $mq$1:2: drawing is half real size. 2:1: drawing is double real size. 1:1: full size.$mq$),
($mq$Exploded view$mq$, $mq$A drawing with parts separated along assembly lines, showing how they fit together.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Sketching and Orthographic Drawing$mq$ and p.name = $mq$Drawing and Communicating$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Drawing is one of the main ways designers think and communicate. Some drawings help you explore ideas quickly, while others give exact information so a product can be made. Knowing which type to use, and for which audience, is an important MYP Design skill, particularly for Criterion B (developing ideas) and Criterion C (creating the solution).

## Freehand sketching
Early in a project, designers produce **thumbnail sketches**, which are small, quick drawings that explore many ideas. Use light **construction lines** (box shapes and guidelines) to get the proportions right, then draw darker outlines over the top. Add shading, simple colour and **annotations** to explain materials, features and how the product works. Sketches do not need to be perfect, but they must be clear.

## Pictorial (3D) drawings
- **Isometric** drawings use a vertical axis and two axes at 30° to the horizontal. All lengths along the axes are drawn at full scale, which makes measuring easy, but there is no sense of distance.
- **Oblique** drawings show the front face in true shape, with depth lines at 45°. In **cabinet oblique** the depth is drawn at half length to reduce distortion.
- **Perspective** drawings use one or two vanishing points on a horizon line, so objects appear smaller with distance. They look the most realistic and are often used for presentation.

## Orthographic projection
**Orthographic projection** shows an object as separate flat views, each looking straight at one face. The standard set includes:
- **Front elevation**: looking at the front
- **Side (end) elevation**: looking from the side
- **Plan**: looking down from above

In **third angle projection**, the plan view is drawn directly above the front elevation, and the right-hand end elevation is drawn to the right of the front. Views must line up so that matching edges have the same size. A drawing is wrong if the width in the front view differs from the width in the plan.

## Line types and dimensions
- **Thick continuous lines** for visible outlines
- **Thin continuous lines** for dimensions and projection lines
- **Short dashes** for hidden detail
- **Chain lines** (long dash, short dash) for centre lines, such as the centre of a hole

Dimensions are normally given in millimetres, with the unit stated once on the drawing. Place dimensions outside the object when possible, keep them clear, and avoid repeating the same size. State the **scale** too: 1:2 means the drawing is half the size of the real object, 2:1 means it is twice the size, and 1:1 is full size.

## Worked example
A drawing of a pencil case is at scale 1:2. The length on paper is 95 mm. The real length is 95 × 2 = 190 mm. A common mistake is to divide by 2 instead of multiplying: with a reduction scale you multiply the drawing size to find the real size.

## Choosing the right drawing
- To explore ideas: thumbnails and sketches
- To show a client: rendered 3D sketches or perspective drawings
- To make the product: dimensioned orthographic drawings
- To explain assembly: exploded views

## Common mistakes
- Inconsistent views that do not line up
- Forgetting hidden detail or centre lines
- Mixing up the scale direction
- Writing sizes in different units on one drawing
- Sketches with no annotations to show reasoning

## How this is examined
You may be given a short description of an object and asked to identify the correct view, calculate a real size from a scale, or decide which drawing type suits a particular audience. Drawings themselves are described in words, so you need to picture what each view would show.

Exam tip: When a question gives a scale, write down whether the drawing is reduced or enlarged before calculating.$mq$ from st;

-- Drawing and Communicating > Modelling and Prototyping
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Drawing and Communicating$mq$, 5, 4 from public.subjects s where s.slug = $mq$product-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Modelling and Prototyping$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$product-design$mq$ and p.grade = 5 and p.name = $mq$Drawing and Communicating$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Modelling and Prototyping$mq$ and p.name = $mq$Drawing and Communicating$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a prototype?$mq$, $mq$["A first working or testable version of a design","A final advert for the product","A list of customers","A sketch of the logo"]$mq$, 0, $mq$A prototype is made to test and improve a design before the final product is made.$mq$, $mq$easy$mq$),
($mq$Which material is cheap and quick for making a first model of a box-shaped product?$mq$, $mq$["Stainless steel","Hardwood","Titanium","Card"]$mq$, 3, $mq$Card and foam board are cheap and easy to cut and fix, so they suit early models.$mq$, $mq$easy$mq$),
($mq$Why do designers make models before the final product?$mq$, $mq$["To make the final product more expensive","To avoid doing research","To test and improve ideas before spending time and money on the final version","To remove the need for drawing"]$mq$, 2, $mq$Models allow problems to be found early, when changes are cheap.$mq$, $mq$easy$mq$),
($mq$What does CAD stand for?$mq$, $mq$["Cutting and drawing","Computer-aided design","Copy and display","Colour and detail"]$mq$, 1, $mq$CAD is software used to create precise 2D and 3D models on a computer.$mq$, $mq$easy$mq$),
($mq$A 3D printer builds an object by adding material layer by layer. This type of process is called what?$mq$, $mq$["Additive manufacturing","Subtractive manufacturing","Casting","Forging"]$mq$, 0, $mq$3D printing adds material, whereas machining and cutting remove it.$mq$, $mq$easy$mq$),
($mq$A student makes a chair model at scale 1:10. The real seat height is 450 mm. What is the seat height of the model?$mq$, $mq$["4.5 mm","450 mm","4500 mm","45 mm"]$mq$, 3, $mq$450 ÷ 10 = 45 mm. A 1:10 model is one tenth of the real size.$mq$, $mq$medium$mq$),
($mq$Which type of model is best for testing how a handle feels in the hand?$mq$, $mq$["A tiny scale model made of paper","A flat sketch","A full-size model in foam or clay","A CAD image on a screen"]$mq$, 2, $mq$Ergonomic testing needs a full-size model so grip and comfort can be judged by touch.$mq$, $mq$medium$mq$),
($mq$A student wants to check how a flat-pack storage box fits together, using a quick low-cost method. What is the best first step?$mq$, $mq$["Order an injection mould","Make a card mock-up","Machine a metal prototype","Print an advert"]$mq$, 1, $mq$A card mock-up checks sizes and assembly quickly. Expensive tooling should only be used after the design is proven.$mq$, $mq$medium$mq$),
($mq$Which is an advantage of a virtual (CAD) model over a physical model?$mq$, $mq$["It can be changed quickly and tested on screen","It can be held in the hand","It always uses less electricity","It needs no skill to use"]$mq$, 0, $mq$CAD lets designers change dimensions and simulate use before making anything physical.$mq$, $mq$medium$mq$),
($mq$Which is a limitation of a card model of a load-bearing shelf?$mq$, $mq$["It cannot show the size","It cannot show the shape","It cannot be drawn","It cannot test whether the real material is strong enough"]$mq$, 3, $mq$A model made from a different material shows form and fit, but not the strength of the final material.$mq$, $mq$medium$mq$),
($mq$A designer creates a rough, low-fidelity model first and a polished, high-fidelity prototype later. Why is this a good approach?$mq$, $mq$["It wastes time but is required","It avoids testing completely","Simple models test basic ideas cheaply, and detailed prototypes check final details","It guarantees a perfect first design"]$mq$, 2, $mq$Starting simple and adding detail saves resources and allows early feedback.$mq$, $mq$medium$mq$),
($mq$Which statement best describes the difference between a model and a prototype?$mq$, $mq$["They are always the same","A model represents some aspects of a design, while a prototype is a working version for testing","A model is the final product","A prototype can only be a drawing"]$mq$, 1, $mq$A model may show shape or size only, while a prototype is closer to the final product and can be tested for function.$mq$, $mq$medium$mq$),
($mq$Which process removes material to make a part from a block?$mq$, $mq$["Laser cutting or milling","3D printing","Layering clay on a frame","Folding a net"]$mq$, 0, $mq$Cutting, milling and drilling are subtractive. 3D printing is additive.$mq$, $mq$medium$mq$),
($mq$A student 3D prints a prototype phone case at 100% size. It is 2 mm too tight on the phone. What is the best next step?$mq$, $mq$["Ignore the error as printing is always approximate","Make the case from steel instead","Remove the phone from the specification","Increase the internal dimensions in the CAD file and print again"]$mq$, 3, $mq$Testing found a fit problem. Iteration means adjusting the model and checking again.$mq$, $mq$hard$mq$),
($mq$Which of the following best justifies using a clay model before a final plastic product?$mq$, $mq$["Clay is stronger than plastic","Clay is recyclable in every case","Clay allows quick changes to a curved form and can be handled to check comfort","Clay is the final material"]$mq$, 2, $mq$Clay is easy to reshape, so organic forms can be developed. It is not meant to test the final material.$mq$, $mq$hard$mq$),
($mq$A prototype bicycle bell works well in the lab but breaks when tested outdoors on a bumpy path. What does this show about the testing process?$mq$, $mq$["Lab tests are always enough","Testing in realistic conditions can reveal faults missed in controlled tests","The bell should be removed from the bike","Outdoor tests are not valid evidence"]$mq$, 1, $mq$Realistic conditions expose problems with durability, which allows improvements before manufacture.$mq$, $mq$hard$mq$),
($mq$A student produces three prototypes. Test results for a drinks holder: V1 spilled 6 of 10 times, V2 spilled 3 of 10 times, V3 spilled 1 of 10 times. Which conclusion is best supported?$mq$, $mq$["Changes between versions improved performance, but V3 still does not eliminate spills","V3 is perfect","V1 was the best design","The results prove nothing"]$mq$, 0, $mq$Spills fell from 60% to 30% to 10%, showing an improvement. A remaining 10% means more work is needed.$mq$, $mq$hard$mq$),
($mq$Which statement shows strong evaluation of a prototype?$mq$, $mq$["It says the model looks fine","It lists the tools used","It repeats the design brief","It compares test results to the specification and proposes a specific change"]$mq$, 3, $mq$High-level evaluation uses evidence and suggests improvements, as expected in Criterion D.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Modelling and Prototyping$mq$ and p.name = $mq$Drawing and Communicating$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Model vs prototype$mq$, $mq$A model represents some aspects of a design (shape, size). A prototype is a testable version, closer to the final product.$mq$),
($mq$Mock-up$mq$, $mq$A quick, low-cost model from card or foam used to check size, layout and proportion.$mq$),
($mq$Scale model$mq$, $mq$A smaller or larger copy of an object. At 1:10 each model length is one tenth of the real length.$mq$),
($mq$Why use a full-size model?$mq$, $mq$To test ergonomics such as grip, comfort and body fit.$mq$),
($mq$CAD$mq$, $mq$Computer-aided design: software for making accurate 2D and 3D models that are easy to edit and share.$mq$),
($mq$Additive vs subtractive$mq$, $mq$Additive processes (3D printing) add material layer by layer. Subtractive processes (cutting, milling) remove material.$mq$),
($mq$Iterative design$mq$, $mq$Repeatedly making, testing and improving a design based on feedback.$mq$),
($mq$Limitation of a card model$mq$, $mq$It shows shape and fit but cannot prove the strength of the real material.$mq$),
($mq$Good prototype evaluation$mq$, $mq$Compare results with the specification, record evidence, and propose a specific improvement.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Modelling and Prototyping$mq$ and p.name = $mq$Drawing and Communicating$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Before a product is made in its final form, designers build **models** and **prototypes** to test their ideas. Making mistakes on a cheap model is far better than discovering them after an expensive manufacturing run. Modelling links Criterion B (developing and checking ideas), Criterion C (creating the solution) and Criterion D (testing and evaluating).

## Models and prototypes
A **model** represents part of a design, such as its shape, size or appearance. It may be made from simple materials and may not work. A **prototype** is a testable version of the product that is closer to the final design. It should be able to show how the product will function, fit and feel. Prototypes are tested, improved and tested again, so design is **iterative**.

## Types of models
- **Mock-ups**: quick, rough models from card, paper or foam to check size, proportion and layout.
- **Scale models**: smaller (or larger) copies of an object, such as a 1:10 model of a bench. They show how a large design will look without using much material.
- **Full-size models**: used for ergonomics, such as checking the grip of a handle or the width of a seat.
- **Working prototypes**: made with materials and processes close to the final ones, to test function and strength.
- **Virtual models**: CAD models and renders on a computer, which can be changed quickly and shared easily.

## Materials for modelling
Card, corrugated board and foam board are cheap and easy to cut. Modelling clay and plasticine are good for curved, organic forms. Wood offcuts and acrylic give a neater finish. Remember that the material used for a model is often different from the final material, so a model may show shape and fit but not real strength.

## Making models
Models can be made by hand or with machines. **Subtractive** methods, such as cutting, drilling and laser cutting, remove material. **Additive** methods, such as 3D printing, add material in layers. CAD lets you create accurate parts, check dimensions and share files with a laser cutter or 3D printer.

## Scale calculations
A scale of 1:10 means the model is one tenth of the real size, so you divide real sizes by 10 to find model sizes. Worked example: a real table is 1200 mm long. At 1:10 the model is 1200 ÷ 10 = 120 mm long. To go back to real size, multiply the model size by 10.

## Why test with models?
You can check:
- **Function**: does it work as intended?
- **Fit and size**: do parts fit together and does the user fit the product?
- **Ergonomics**: is it comfortable and safe to use?
- **Appearance**: does the form and colour work?
- **Cost and manufacture**: can it be made with the available tools and skills?

Record your tests carefully with photos, results and user comments, and use the specification as your checklist.

## Common mistakes
- Using only one model and never improving it
- Testing strength with a model made from a weaker material
- Not recording the changes made after testing
- Choosing an expensive prototype when a cheap mock-up would do

## How this is examined
Questions usually describe a design problem and ask which type of model suits a purpose, what a test result shows, or how to improve a prototype. Scale calculations also appear. Strong answers link the type of model to what is being tested.

Exam tip: Match the model to the question you are asking. Use a full-size model for comfort, a card mock-up for layout, and a working prototype for strength and function.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('product-design')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;