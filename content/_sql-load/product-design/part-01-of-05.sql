-- Part 1 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- The Design Cycle > Inquiring and Analysing
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$The Design Cycle$mq$, 5, 1 from public.subjects s where s.slug = $mq$product-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Inquiring and Analysing$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$product-design$mq$ and p.grade = 5 and p.name = $mq$The Design Cycle$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Inquiring and Analysing$mq$ and p.name = $mq$The Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In the MYP design cycle, which criterion is called Inquiring and analysing?$mq$, $mq$["Criterion A","Criterion B","Criterion C","Criterion D"]$mq$, 0, $mq$Criterion A is Inquiring and analysing. B is Developing ideas, C is Creating the solution and D is Evaluating.$mq$, $mq$easy$mq$),
($mq$Which of these is the main purpose of a design brief?$mq$, $mq$["To list the final materials and prices","To show the finished product drawing","To record how well the product performed","To state the problem the designer will solve"]$mq$, 3, $mq$A brief tells the designer what problem or need is being addressed. Materials, drawings and testing come later in the cycle.$mq$, $mq$easy$mq$),
($mq$Asking people questions in a survey to find out what they want is an example of which kind of research?$mq$, $mq$["Secondary research","Prototype testing","Primary research","Manufacturing"]$mq$, 2, $mq$Primary research is information you collect yourself, for example surveys, interviews and observation. Secondary research uses information others have already published.$mq$, $mq$easy$mq$),
($mq$Reading a magazine article about existing bicycle lights is which type of research?$mq$, $mq$["Primary research","Secondary research","Evaluation","Sketching"]$mq$, 1, $mq$The designer is using information someone else produced, so it is secondary research.$mq$, $mq$easy$mq$),
($mq$What is a 'target user' in a design project?$mq$, $mq$["The group of people the product is designed for","The person who manufactures the product","The teacher who marks the project","The shop that sells the product"]$mq$, 0, $mq$The target user (or client group) is who the design must suit, such as primary-school children or elderly walkers.$mq$, $mq$easy$mq$),
($mq$A student is designing a lunch box for 8 year olds. She watches 10 children opening their current lunch boxes and notes that many struggle with the clip. Which statement is the best conclusion to record in her analysis?$mq$, $mq$["Children like the colour blue","Lunch boxes are made of plastic","The product will cost 5 dollars","Clips should be easy to open with small hands"]$mq$, 3, $mq$A good analysis turns an observation into a clear design requirement. The other statements are not supported by what she observed.$mq$, $mq$medium$mq$),
($mq$A designer lists the strengths and weaknesses of three existing desk lamps and compares them. What is this task usually called?$mq$, $mq$["Prototype testing","Orthographic projection","Product analysis","Batch production"]$mq$, 2, $mq$Comparing existing products to learn what works and what does not is a product analysis, a common part of criterion A.$mq$, $mq$medium$mq$),
($mq$Which research question is most useful for a student designing a school bag for Grade 6 students?$mq$, $mq$["Is the school bag industry large?","What is the typical mass a Grade 6 student carries each day?","Which bag looks best?","Who invented the zip?"]$mq$, 1, $mq$A useful question is specific and leads directly to a measurable requirement such as a maximum mass. The other questions are vague or irrelevant to the user.$mq$, $mq$medium$mq$),
($mq$A survey asks: 'Do you agree that our wonderful new recycling bin is easy to use?' What is the main problem with this question?$mq$, $mq$["It is a leading question that pushes people to agree","It is too short","It uses numbers","It asks about the user"]$mq$, 0, $mq$Words like 'wonderful' push respondents toward a particular answer, which makes the data biased. Questions should be neutral.$mq$, $mq$medium$mq$),
($mq$Which source is most reliable for finding the safe maximum temperature of a toy's surface?$mq$, $mq$["An anonymous online forum post","A friend's opinion","An advertisement on social media","A national safety standards document"]$mq$, 3, $mq$Standards bodies and regulators are authoritative and checked. Anonymous posts, opinions and adverts may be wrong or biased.$mq$, $mq$medium$mq$),
($mq$A student's analysis says: 'The chair must be comfortable.' Why would a teacher ask her to improve this?$mq$, $mq$["It is too long","It mentions the user","It is not measurable or specific","It uses a verb"]$mq$, 2, $mq$A design requirement should be testable, for example 'seat height adjustable between 38 cm and 46 cm'. 'Comfortable' alone cannot be tested.$mq$, $mq$medium$mq$),
($mq$Which is the best use of a mind map at the start of a project?$mq$, $mq$["To produce a final working drawing","To explore the problem and the factors affecting it","To calculate manufacturing cost","To test a prototype"]$mq$, 1, $mq$A mind map helps organise the aspects of a problem such as user, function, materials and environment before research begins.$mq$, $mq$medium$mq$),
($mq$A student interviews a carpenter about how often a wooden bench needs repainting. Why is this interview a good source for a bench design project?$mq$, $mq$["It gives expert primary information about durability and maintenance","It guarantees that the bench will be sold","It replaces the need for a design brief","It shows the final bench dimensions"]$mq$, 0, $mq$Experts provide relevant first-hand knowledge. It informs the analysis but does not replace the brief or give final dimensions.$mq$, $mq$medium$mq$),
($mq$A student writes a design specification item: 'The water bottle holds 500 ml ± 20 ml and fits in a bag side pocket 7 cm wide.' Which feature makes this a strong specification?$mq$, $mq$["It describes the colour only","It avoids numbers","It states the designer's feelings","It gives measurable limits linked to user needs"]$mq$, 3, $mq$Strong specification points are measurable and justified by research. Here capacity and width can both be tested objectively.$mq$, $mq$hard$mq$),
($mq$A team investigates a bus shelter. Research shows 70% of commuters wait for under 5 minutes, but elderly users often wait over 15 minutes in heavy rain. Which design requirement is best justified by this data?$mq$, $mq$["Make the shelter as small as possible","Use bright advertising panels","Provide seating and full side protection for long, wet waits","Remove the roof to save cost"]$mq$, 2, $mq$The data shows a minority group with a stronger need. A justified requirement links the finding directly to a feature. Removing the roof contradicts the rain finding.$mq$, $mq$hard$mq$),
($mq$A survey of 20 students is used to claim 'all teenagers want a red phone case'. Which is the strongest criticism?$mq$, $mq$["The survey used a pen","The sample is small and may not represent all teenagers","Red is not a colour","Phone cases are not designed"]$mq$, 1, $mq$A small, unrepresentative sample cannot support a general claim. Larger and more varied samples give more reliable conclusions.$mq$, $mq$hard$mq$),
($mq$Two existing products both fail the 'easy to clean' requirement. Product X is 40% cheaper but has deep grooves; Product Y costs more but is smooth. Which analysis statement shows the deepest thinking?$mq$, $mq$["The grooves in X trap dirt, so a smooth surface should be a requirement even if cost rises slightly","Y is better because it is more expensive","X is better because it is cheaper","Both are the same so no conclusion is possible"]$mq$, 0, $mq$The best analysis explains why a feature affects function and turns it into a requirement while recognising the trade-off with cost.$mq$, $mq$hard$mq$),
($mq$Which sequence best describes how a strong Criterion A response is built?$mq$, $mq$["Draw the final product, then choose a problem, then write a survey","Buy materials, build, then write the brief","Test the product, then state the need, then draw","Explain the problem, research it, analyse existing products, then write a design brief"]$mq$, 3, $mq$Criterion A moves from understanding the need and its context, through research and analysis, to a design brief that leads into the specification and later criteria.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Inquiring and Analysing$mq$ and p.name = $mq$The Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Criterion A$mq$, $mq$Inquiring and analysing: explain the need, research it, analyse existing products and write a design brief.$mq$),
($mq$Primary research$mq$, $mq$Information you collect yourself, such as surveys, interviews, observation and testing existing products.$mq$),
($mq$Secondary research$mq$, $mq$Information gathered from sources others created, such as books, websites, standards and reports.$mq$),
($mq$Leading question$mq$, $mq$A question worded to push the respondent toward a certain answer, which makes the data biased. Questions should be neutral.$mq$),
($mq$Product analysis$mq$, $mq$Examining existing products for function, materials, cost, safety and appearance to decide what to keep, change or avoid.$mq$),
($mq$Design specification$mq$, $mq$A list of measurable, justified requirements that the final product must meet.$mq$),
($mq$Target user$mq$, $mq$The group of people the product is designed for. Their needs, size and abilities guide the design.$mq$),
($mq$Why use a larger sample?$mq$, $mq$A bigger and more representative sample gives more reliable evidence and avoids unfair generalisations.$mq$),
($mq$What makes a source reliable?$mq$, $mq$Expertise, official status (such as a standards body), recent date and evidence. Anonymous or advertising sources are weaker.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Inquiring and Analysing$mq$ and p.name = $mq$The Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What Criterion A is about
Criterion A, **Inquiring and analysing**, is the first stage of the MYP design cycle. Before you sketch a single idea you must understand the problem, the people affected and the situation the product will be used in. Strong work here makes everything later easier, because your ideas, your making and your evaluation are all measured against what you discover now.

## Explaining the need for a solution
Start with a **design brief** or problem statement. Describe the need, who has it, where it occurs and why a design solution is worthwhile. Good statements give a clear context, for example "Students in our school lose water bottles because there is nowhere safe to place them during sport." A weak statement is just "I will make a bottle holder."

## Research
Research must be planned. Decide what you need to know, then choose suitable sources.
- **Primary research** is information you collect yourself: surveys, interviews, observation, measuring and testing existing products.
- **Secondary research** is information others produced: websites, books, standards, catalogues and reports.
Check that sources are reliable. Official standards, trained experts and well-known organisations are stronger than anonymous posts. Write down where information came from so it can be referenced.

### Writing good questions
Questions must be neutral, clear and linked to the design. "How many minutes do you spend carrying your bag each day?" is a better question than "Is your heavy bag annoying?" because the first gives data you can use. Avoid leading questions, and ask enough people from the actual target group. A tiny or unrepresentative sample makes weak evidence.

## Analysing existing products
A **product analysis** looks at similar products. Describe what each one does, its materials, size, cost, safety and appearance. Then judge strengths and weaknesses and say what you will keep, change or avoid. Use headings like function, user needs, materials, sustainability and aesthetics to give structure. Always finish by saying what the analysis means for your own design.

## Developing a design brief
Your research and product analysis end with a **design brief**, a short statement of the need, the user and the context that sums up what you found. This is the last strand of Criterion A. The **design specification**, a list of testable requirements the final product must meet, is written next at the start of Criterion B, but it must be built on this research. Each specification point should be:
- **Measurable or testable** (for example "supports 3 kg" rather than "strong").
- **Justified** by your research.
- Linked to a clear category such as function, ergonomics, safety, materials, cost, appearance and sustainability.
Example: "The lunch box must open using one hand because 7 of 10 children surveyed said they carry other items." This gives a reason the evaluator can later check.

## How this is examined
In exam-style practice questions you are often given a short scenario with data, such as survey results, a product extract or user comments. Command terms include **identify**, **outline**, **analyse** and **justify**. You may be asked which research method is best, what a data set suggests the user needs, which specification point is weak, or which source is most reliable. Read the stimulus carefully and pull out the numbers or facts that matter before choosing.

## Common mistakes
- Copying large amounts of information without saying why it matters.
- Writing a specification that cannot be tested.
- Asking leading questions or surveying only friends.
- Researching things unrelated to the problem.

Exam tip: When asked to justify a requirement, use the pattern "because" and refer to a specific finding from the data or research given.$mq$ from st;

-- The Design Cycle > Developing Ideas
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$The Design Cycle$mq$, 5, 1 from public.subjects s where s.slug = $mq$product-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Developing Ideas$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$product-design$mq$ and p.grade = 5 and p.name = $mq$The Design Cycle$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Developing Ideas$mq$ and p.name = $mq$The Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which criterion of the MYP design cycle is Developing ideas?$mq$, $mq$["Criterion B","Criterion A","Criterion C","Criterion D"]$mq$, 0, $mq$Criterion B is Developing ideas. It follows Inquiring and analysing and comes before Creating the solution.$mq$, $mq$easy$mq$),
($mq$What is brainstorming used for?$mq$, $mq$["Checking the final product","Writing a bibliography","Calculating cost","Generating many ideas quickly"]$mq$, 3, $mq$Brainstorming produces many ideas without judging them straight away, which widens your choices.$mq$, $mq$easy$mq$),
($mq$Which of these is a design idea rather than a design specification?$mq$, $mq$["A requirement that the rack holds 20 kg","A survey result","A sketch of a folding bike rack","A list of sources"]$mq$, 2, $mq$Ideas are possible solutions, usually drawn and annotated. A specification states requirements.$mq$, $mq$easy$mq$),
($mq$Why should you develop more than one design idea?$mq$, $mq$["To make the project longer","To compare options and choose the best","To avoid using the specification","To skip testing"]$mq$, 1, $mq$Having several ideas allows fair comparison against the specification so the best one is chosen with reasons.$mq$, $mq$easy$mq$),
($mq$What is a 'design specification' used for in Criterion B?$mq$, $mq$["To judge which idea best meets the requirements","To decide the school fees","To record the weather","To choose a teacher"]$mq$, 0, $mq$Ideas are compared with the specification so the choice is evidence-based.$mq$, $mq$easy$mq$),
($mq$A student draws three phone-stand ideas. Idea 1 is stable but bulky, Idea 2 is portable but tips over, Idea 3 is stable and folds flat. The specification says 'stable and fits in a pocket'. Which should she choose?$mq$, $mq$["Idea 1","Idea 2","None, she must start again","Idea 3"]$mq$, 3, $mq$Idea 3 meets both requirements. Idea 1 is not pocket sized and Idea 2 is not stable.$mq$, $mq$medium$mq$),
($mq$Which annotation on a sketch is most useful?$mq$, $mq$["This is nice","Looks good","The hinge is brass so it resists rust near the sink","Drawn on Monday"]$mq$, 2, $mq$Useful annotation explains a feature and gives a reason. Vague comments and dates earn no credit.$mq$, $mq$medium$mq$),
($mq$A student scores three ideas out of 5 for cost, safety and appearance, but her specification says safety is most important. What improves her decision chart?$mq$, $mq$["Removing safety from the chart","Weighting safety so it counts for more","Scoring only appearance","Giving every idea 5"]$mq$, 1, $mq$Weighting reflects priorities from the specification. Otherwise a risky but attractive idea could win.$mq$, $mq$medium$mq$),
($mq$What does 'iterative' mean in design?$mq$, $mq$["Ideas are improved by repeating cycles of testing and changing","The design is only done once","The design is copied from another","Only the teacher can change it"]$mq$, 0, $mq$Iteration means improving a design through repeated rounds of feedback and refinement.$mq$, $mq$medium$mq$),
($mq$A client reviews a sketch of a school bag and says the shoulder straps are too narrow. What should the designer do?$mq$, $mq$["Ignore it because sketches cannot be wrong","Delete the sketch","Change the client","Record the feedback and modify the design with a reason"]$mq$, 3, $mq$Using feedback to improve an idea is central to developing ideas. Changes should be recorded and justified.$mq$, $mq$medium$mq$),
($mq$Which technique helps combine good features of two earlier ideas?$mq$, $mq$["Copying a competitor exactly","Drawing only in colour","Developing a hybrid idea","Deleting both"]$mq$, 2, $mq$Combining strengths of different ideas is a common way to refine a design.$mq$, $mq$medium$mq$),
($mq$A student selects a design and writes: 'I chose Idea B because it is 40% lighter than A and meets the 2 kg limit in my specification.' Why is this good justification?$mq$, $mq$["It mentions a colour","It gives a measurable reason linked to the specification","It is long","It names the teacher"]$mq$, 1, $mq$Strong justification uses evidence and links it to a requirement.$mq$, $mq$medium$mq$),
($mq$A plan lists steps in order with materials, tools, times and safety notes. Which part of Criterion B does this support?$mq$, $mq$["Planning the making of the chosen design","Analysing the market","Writing the brief","Evaluating the product"]$mq$, 0, $mq$Developing ideas includes presenting the chosen design and planning how it will be made so that the next stage runs smoothly.$mq$, $mq$medium$mq$),
($mq$A student's final design drawing has no dimensions, materials or finishes. What is the main problem?$mq$, $mq$["The drawing is too colourful","The idea is too original","The sketch is too big","Another person could not make it from the drawing"]$mq$, 3, $mq$A design that can be made by someone else needs sizes, materials and construction details.$mq$, $mq$hard$mq$),
($mq$Two ideas both pass the specification. Idea P costs 12 dollars and is made of recycled plastic. Idea Q costs 10 dollars and uses virgin plastic. The brief says sustainability is a top priority. What is the strongest reasoning?$mq$, $mq$["Choose Q because it is cheaper","Choose either because they are the same","Choose P because the small extra cost is justified by the sustainability priority","Choose neither because cost is irrelevant"]$mq$, 2, $mq$Choices should reflect the stated priorities. A 2 dollar increase is a reasonable trade-off if sustainability is the priority.$mq$, $mq$hard$mq$),
($mq$A student's cardboard model shows that a drawer sticks. How should this be used in Criterion B?$mq$, $mq$["Hide the problem","Improve the design and record the change with reasons","Start a different project","Remove the model"]$mq$, 1, $mq$Testing a model at the ideas stage identifies faults early and the resulting improvement shows strong development.$mq$, $mq$hard$mq$),
($mq$A decision matrix gives Idea 1 total 18 and Idea 2 total 17, but Idea 1 failed the safety requirement. What is the best conclusion?$mq$, $mq$["Idea 1 should be rejected or changed because failing safety outweighs the score","Idea 1 wins because 18 is higher","Idea 2 wins because 17 is lower","The matrix proves both are equal"]$mq$, 0, $mq$A pass/fail requirement such as safety should not be traded off by points. Totals can mislead if non-negotiable requirements are ignored.$mq$, $mq$hard$mq$),
($mq$A designer wants to show how a mechanism moves before choosing materials. Which approach is most appropriate?$mq$, $mq$["Order expensive metal parts","Skip testing","Write a poem","Make a quick low-cost model from card"]$mq$, 3, $mq$Cheap, quick models test function early and prevent costly mistakes later.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Developing Ideas$mq$ and p.name = $mq$The Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Criterion B$mq$, $mq$Developing ideas: write the design specification, generate design ideas, choose and justify the best, present the final design and plan how it will be made.$mq$),
($mq$Brainstorming$mq$, $mq$Quickly generating many ideas without judging them so that you have lots of options to develop.$mq$),
($mq$SCAMPER$mq$, $mq$A prompt list: Substitute, Combine, Adapt, Modify, Put to another use, Eliminate, Reverse. Used to improve or invent ideas.$mq$),
($mq$Decision matrix$mq$, $mq$A table scoring each idea against specification points so the best idea can be chosen with evidence.$mq$),
($mq$Weighting$mq$, $mq$Giving important requirements a bigger multiplier in a decision matrix so they influence the total more.$mq$),
($mq$Iteration$mq$, $mq$Improving a design by repeating rounds of feedback, testing and modification.$mq$),
($mq$Why annotate sketches?$mq$, $mq$Annotation explains how a feature works and why it was chosen, giving evidence of your thinking.$mq$),
($mq$What should a final design drawing include?$mq$, $mq$Dimensions, materials, finishes, construction details and enough information for someone else to make it.$mq$),
($mq$What should a making plan include?$mq$, $mq$Ordered steps, tools, materials, time estimates, safety precautions and quality checks.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Developing Ideas$mq$ and p.name = $mq$The Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Criterion B overview
Criterion B, **Developing ideas**, is where your research becomes possible solutions. It begins with writing the design specification, the testable success criteria that follow from your research. You then use the specification to generate ideas, evaluate them, pick the best, and then present it clearly enough for another person to make it. You will also plan the steps for making the product. This stage should show creativity and also careful thinking.

## Generating ideas
Start by producing a range of different ideas. Techniques include:
- **Brainstorming**: write down as many ideas as possible without judging them.
- **Mind maps and mood boards**: collect themes, shapes, colours and materials.
- **SCAMPER**: ask how you could Substitute, Combine, Adapt, Modify, Put to another use, Eliminate or Reverse parts of an existing product.
- **Sketching**: quick drawings showing shape, parts and how it works.
Your ideas should be different from each other, not three copies of one design with different colours. Include annotation explaining how each idea works and how it meets the specification.

## Evaluating ideas
Compare ideas against your specification. A **decision matrix** gives each idea a score for each requirement. If some requirements matter more, use **weighting**, meaning a heavier multiplier. Be careful with scores: some requirements, such as safety, are pass/fail. An idea that fails a safety requirement should not win simply because it scores well elsewhere.

Worked example: Idea A scores 4 for safety, 3 for cost and 5 for appearance. Idea B scores 5, 4 and 2. If safety is weighted by 3 and the others by 1, A scores 12 + 3 + 5 = 20 and B scores 15 + 4 + 2 = 21. B wins. If appearance had been doubled instead, the result would change, so explain why your weights are fair.

## Refining and justifying the chosen design
Use feedback from the client, test users or teacher to modify your chosen idea. Record what you changed and why. This is called **iteration**. Models made from card or foam help you test fit, movement and size cheaply. Your justification should refer to specific requirements, for example "I chose a sliding lid because 6 of 8 testers found a hinged lid awkward."

## Presenting the final design
The chosen design should be shown with enough detail that someone else could build it. Include:
- Views with key dimensions and a scale.
- Materials, components and finishes.
- Notes on construction and any special processes.
- A sketch or render showing the finished appearance.

## Planning for making
Prepare a plan: the order of steps, tools and equipment, materials list, time for each step, safety precautions and quality checks. Good plans anticipate problems and show alternatives.

## How this is examined
In exam-style practice questions you may be shown several sketches with notes and asked to choose the best option against a specification, interpret a decision matrix, or identify missing information from a plan. Command terms include **outline**, **explain**, **justify** and **evaluate**. Read the specification first and mark each idea against it one requirement at a time.

## Common mistakes
- Producing ideas that are all similar.
- Choosing an idea without comparing it to the specification.
- Annotating with phrases like "looks good".
- Leaving out dimensions and materials from the final drawing.

Exam tip: When you justify a choice, name the requirement and give a number or fact from the stimulus.$mq$ from st;

-- The Design Cycle > Creating the Solution
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$The Design Cycle$mq$, 5, 1 from public.subjects s where s.slug = $mq$product-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Creating the Solution$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$product-design$mq$ and p.grade = 5 and p.name = $mq$The Design Cycle$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Creating the Solution$mq$ and p.name = $mq$The Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which criterion of the MYP design cycle is Creating the solution?$mq$, $mq$["Criterion C","Criterion A","Criterion B","Criterion D"]$mq$, 0, $mq$Criterion C is Creating the solution. It is where you follow your plan and make the product.$mq$, $mq$easy$mq$),
($mq$Why should you wear safety glasses when using a drill or saw?$mq$, $mq$["To see colours better","To keep your hair neat","To make the tool quieter","To protect your eyes from flying debris"]$mq$, 3, $mq$Safety equipment reduces the risk of injury from particles, sparks or dust.$mq$, $mq$easy$mq$),
($mq$What is a 'deviation' from a plan?$mq$, $mq$["A mistake you hide","A new brief","A change made while making, with a reason","A teacher's mark"]$mq$, 2, $mq$Deviations are sensible changes when something does not work as planned. They must be recorded and explained.$mq$, $mq$easy$mq$),
($mq$Why take photographs while making a product?$mq$, $mq$["To make the product heavier","To record evidence of the process","To avoid planning","To save money"]$mq$, 1, $mq$Photos show what you did, how you used tools and how the product developed, which supports the assessment of Criterion C.$mq$, $mq$easy$mq$),
($mq$Which of these is a good habit before cutting material?$mq$, $mq$["Measure twice and mark clearly","Cut straight away","Guess the length","Ask a friend to estimate"]$mq$, 0, $mq$Careful measuring and marking reduces waste and errors.$mq$, $mq$easy$mq$),
($mq$A student planned to cut a 300 mm length of wood but found the saw blade wandered and the piece ended 4 mm too short. What is the best action?$mq$, $mq$["Pretend it is the correct size","Add glue to hide the gap","Remove the plan","Record the problem and remake or adjust, explaining the change"]$mq$, 3, $mq$Good practice is to be honest, record the issue and decide a sensible fix. Remaking or modifying with a reason shows problem solving.$mq$, $mq$medium$mq$),
($mq$What does 'technical skill' mean in Criterion C?$mq$, $mq$["Drawing quickly","Writing long paragraphs","Using tools, materials and processes correctly and safely","Buying expensive parts"]$mq$, 2, $mq$Technical skill refers to competent and safe use of tools and processes, shown through the quality of the work.$mq$, $mq$medium$mq$),
($mq$Which action shows good time management?$mq$, $mq$["Leaving all work to the final day","Following a schedule and adjusting when delays occur","Skipping planning","Changing the brief repeatedly"]$mq$, 1, $mq$Time management uses the plan and adapts to problems rather than ignoring the plan.$mq$, $mq$medium$mq$),
($mq$A student sands a plastic part before checking its fit with other parts. Which is the better order of work?$mq$, $mq$["Check the fit, then finish the surface","Finish first and fit later","Never check fit","Paint the part before cutting"]$mq$, 0, $mq$Fit and shape should be correct before finishing. Otherwise finishing may be damaged by later adjustments.$mq$, $mq$medium$mq$),
($mq$A product must be made in a class of 24 students sharing three band saws. What is the best way to plan the schedule?$mq$, $mq$["All students use one saw at the same time","Skip machining","Wait until the end of term","Rotate use of machines and prepare other tasks while waiting"]$mq$, 3, $mq$Sharing equipment needs planning so everyone can progress safely.$mq$, $mq$medium$mq$),
($mq$A student's log reads: 'Used a coping saw to cut curve; blade snapped so I changed to a thicker blade and cut slower.' What does this show?$mq$, $mq$["A planning failure only","A lack of safety","Problem solving with a recorded reason","Evidence of copying"]$mq$, 2, $mq$A reasoned change in tool or technique shows that the maker responded to a problem.$mq$, $mq$medium$mq$),
($mq$Why is it important for a final product to match the plan and the specification as far as possible?$mq$, $mq$["So the teacher need not read it","It allows fair evaluation of whether the solution meets requirements","To avoid using any tools","So the product is cheaper"]$mq$, 1, $mq$A product that follows the plan can be tested against the specification, and deviations are explained.$mq$, $mq$medium$mq$),
($mq$A student uses a pillar drill to make a hole in a small metal plate. What is the safest way to hold the plate?$mq$, $mq$["Clamp it in a machine vice","Hold it with bare fingers","Hold it with a cloth wrapped round the hand","Let it spin freely"]$mq$, 0, $mq$Small workpieces must be clamped so they cannot spin and cause injury. Holding by hand or cloth is dangerous.$mq$, $mq$medium$mq$),
($mq$A student must make 30 identical key rings. Which approach improves consistency and speed?$mq$, $mq$["Mark each one by eye","Make each differently","Cut without measuring","Make a jig or template for repeated cutting and drilling"]$mq$, 3, $mq$Jigs and templates improve accuracy and speed in repeated tasks.$mq$, $mq$hard$mq$),
($mq$A student cuts a hole 2 mm too large for a switch. Which solution best shows reflection and skill?$mq$, $mq$["Hide the gap with tape and say nothing","Ignore the specification","Add a neat bezel plate that covers the gap and note the change","Restart the whole project without recording"]$mq$, 2, $mq$A practical, recorded solution that keeps the function and appearance shows problem solving and honesty.$mq$, $mq$hard$mq$),
($mq$A student finishes the product two days early but has not written a log. How does this affect Criterion C?$mq$, $mq$["It does not matter","Without a record, the teacher has little evidence of process and decisions","The product is marked without any evidence","The log is only for the client"]$mq$, 1, $mq$Evidence of process, such as logs and photos, is needed to show the plan was followed and changes were justified.$mq$, $mq$hard$mq$),
($mq$A teacher notes that a student's chosen finish takes 24 hours to cure but the lesson plan shows only 2 hours before the product is due. What should the student do?$mq$, $mq$["Adjust the schedule or pick a faster finish and record the reason","Ignore the drying time","Remove the plan","Blame the teacher"]$mq$, 0, $mq$A good plan includes realistic times. Recognising an issue and adjusting shows planning and problem solving.$mq$, $mq$hard$mq$),
($mq$Which statement best compares 'following the plan' with 'blindly following the plan'?$mq$, $mq$["They are the same","Blindly following is better","Plans must never change","Following the plan includes changing it sensibly when needed"]$mq$, 3, $mq$Real design involves unexpected problems, so adapting with justification is a strength.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Creating the Solution$mq$ and p.name = $mq$The Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Criterion C$mq$, $mq$Creating the solution: follow the plan, use skills safely, justify changes and produce a working solution with evidence.$mq$),
($mq$Deviation$mq$, $mq$A change from the original plan made during making. It should be recorded with a reason.$mq$),
($mq$Jig$mq$, $mq$A guide or fixture that holds work or tools in position so repeated parts are made accurately and quickly.$mq$),
($mq$Template$mq$, $mq$A shape cut from thin material used to mark out identical parts.$mq$),
($mq$Making log$mq$, $mq$A dated record with photographs and notes showing steps, decisions and problems solved during making.$mq$),
($mq$Test fit$mq$, $mq$Putting parts together without glue or finish to check they match before final assembly.$mq$),
($mq$Safe workshop habits$mq$, $mq$Eye protection, tied-back hair, secure clamping, guards in place, tidy workspace and no loose clothing.$mq$),
($mq$Correct order of operations$mq$, $mq$Measure and mark, cut, shape, test fit, join, then finish.$mq$),
($mq$Why include time for curing or drying?$mq$, $mq$Glues and finishes need set times. Ignoring them can ruin the product or delay the schedule.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Creating the Solution$mq$ and p.name = $mq$The Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Criterion C overview
Criterion C, **Creating the solution**, is where you turn your chosen design into a real product or prototype. You follow your plan, use tools and materials safely and correctly, and explain any changes you make. You also show that your finished product can be made by following your documentation. The quality of your making and your records both matter.

## Following the plan
Your plan from Criterion B lists steps, tools, materials, times and safety checks. Use it as a guide while you work. Tick off steps, note the time taken and keep your plan up to date. A plan is not a prison: real making brings surprises, such as a part that does not fit or a tool that is unavailable. When this happens, you must decide what to do and **record the deviation** with a reason.

### Example of a justified deviation
"The plan was to join the two panels with a butt joint. During a test fit the joint was weak, so I changed to a dowel joint, which gave extra glue area and better alignment."

## Technical skills
Technical skills include marking out, measuring, cutting, shaping, joining and finishing accurately. For example:
- Measure twice and cut once.
- Use a marking gauge or a template for repeated shapes.
- Clamp work securely before cutting or drilling.
- Test the fit of components before gluing or finishing.
- Keep a tidy workshop and look after tools.
Good technical skill is not about speed. It is about accuracy, appropriate tool choice and safe habits.

## Safety
Always follow workshop rules. Typical precautions are eye protection, tied-back hair, no loose clothing, correct footwear, dust extraction or masks when sanding, and using machine guards. Identify risks in your plan, for example hot glue, sharp blades or fumes, and say how you will control them. If you are unsure, ask before you proceed.

## Time and resource management
Estimate how long each step will take and allow extra time for drying, curing or machine queues. Order materials early. Cut parts efficiently to reduce waste. If you run out of time, decide which features are essential and which can be simplified, and record why.

## Recording evidence
Keep a **making log** with dated entries and photographs. Show key stages: marking out, cutting, joining, finishing and testing. Annotate photographs to explain what you are doing and why. This evidence shows that the product is yours and demonstrates your skills and decisions.

## Making the solution functional
The final product should work as intended and should match your specification. Test the product as you make it. For example, check that a hinge opens fully, a lid fits and a surface is smooth. Fix small issues before moving on.

## How this is examined
In exam-style practice questions you might read a short making log or plan and be asked to identify the best next action, explain why a deviation is justified, spot a safety issue, or choose the right order of operations. Command terms are **identify**, **explain** and **justify**. Look for logical sequencing: measure and mark, cut, shape, join, then finish.

## Common mistakes
- Not recording changes to the plan.
- Starting finishing before checking fit.
- Ignoring safety steps.
- Having no photographic or written evidence.

Exam tip: If asked what to do when a problem occurs while making, choose the answer that fixes the problem sensibly and records the change with a reason.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('product-design')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;