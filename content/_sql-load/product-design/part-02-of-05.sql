-- Part 2 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- The Design Cycle > Evaluating the Product
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$The Design Cycle$mq$, 5, 1 from public.subjects s where s.slug = $mq$product-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Evaluating the Product$mq$, 5, p.id, 4
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$product-design$mq$ and p.grade = 5 and p.name = $mq$The Design Cycle$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Evaluating the Product$mq$ and p.name = $mq$The Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which criterion of the MYP design cycle is Evaluating?$mq$, $mq$["Criterion D","Criterion A","Criterion B","Criterion C"]$mq$, 0, $mq$Criterion D is Evaluating. It looks at how well the product meets the specification and what could be improved.$mq$, $mq$easy$mq$),
($mq$What is the purpose of testing a finished product?$mq$, $mq$["To make it look old","To avoid improvements","To hide faults","To see whether it meets the specification"]$mq$, 3, $mq$Tests give evidence about how well the product performs against requirements.$mq$, $mq$easy$mq$),
($mq$Which of these is an objective test result?$mq$, $mq$["I think the bag is pretty","The bag feels nice","The bag carried 6 kg without tearing","My friend likes the bag"]$mq$, 2, $mq$Objective results are measurable facts. Opinions are subjective.$mq$, $mq$easy$mq$),
($mq$What is 'client feedback'?$mq$, $mq$["The teacher's mark","Opinions from the person the product is for","A material list","A drawing scale"]$mq$, 1, $mq$Client feedback tells the designer if the product satisfies real needs.$mq$, $mq$easy$mq$),
($mq$An improvement suggestion should be…$mq$, $mq$["Specific and linked to a weakness found in testing","Vague and general","Unrelated to the product","Always about price"]$mq$, 0, $mq$Good improvements are targeted and justified, for example: 'Add a wider strap because the strap dug into shoulders during the carry test.'$mq$, $mq$easy$mq$),
($mq$A student tests a paper-clip holder 10 times. It holds 8 paper clips successfully each time but falls off the desk edge twice. Which conclusion is best?$mq$, $mq$["It failed completely","The test is invalid because it was repeated","It is perfect","It performs its main function but needs a way to stay fixed to the desk"]$mq$, 3, $mq$Results show mostly good performance with a specific weakness. Repeated trials increase reliability.$mq$, $mq$medium$mq$),
($mq$A specification says: 'Mass must be below 400 g.' The product measures 430 g. How should this be recorded?$mq$, $mq$["The requirement was met","Mass is not important","The requirement was not met by 30 g","The scale is wrong without checking"]$mq$, 2, $mq$Evaluation compares results against the exact requirement and states the difference honestly.$mq$, $mq$medium$mq$),
($mq$Why is it useful to test with several users?$mq$, $mq$["It makes testing slower only","Different users may reveal different problems","One user is always enough","It changes the specification"]$mq$, 1, $mq$Different heights, ages and abilities can reveal issues missed by one user.$mq$, $mq$medium$mq$),
($mq$A student claims: 'The product is successful because it looks good.' What is missing?$mq$, $mq$["Evidence from tests against the specification","More colours","A longer title","A bigger font"]$mq$, 0, $mq$A judgement needs evidence from testing and feedback, not only appearance.$mq$, $mq$medium$mq$),
($mq$What is the difference between 'function' and 'aesthetics'?$mq$, $mq$["They mean the same","Function is cost; aesthetics is safety","Function is weight; aesthetics is size","Function is how it works; aesthetics is how it looks"]$mq$, 3, $mq$Function relates to performance and purpose. Aesthetics relates to appearance and sensory qualities.$mq$, $mq$medium$mq$),
($mq$A product costs 14 dollars to make but the specification limit was 12 dollars. Which suggestion is realistic?$mq$, $mq$["Ignore the cost","Double the price of materials","Reduce material use or buy parts in bulk to lower the cost","Delete the specification"]$mq$, 2, $mq$Improvements should be practical and link to the issue found.$mq$, $mq$medium$mq$),
($mq$A student wants to know the impact of her product on the environment. Which approach is best?$mq$, $mq$["Look only at colour","Consider materials, manufacture, use and disposal","Ignore disposal","Count the number of parts only"]$mq$, 1, $mq$Impact is considered across the life cycle, including end of life.$mq$, $mq$medium$mq$),
($mq$Why should a student describe how others can use the results to improve the product?$mq$, $mq$["It shows the evaluation leads to action","It increases the word count only","It avoids tests","It removes the need for a client"]$mq$, 0, $mq$Evaluation should lead to improvements, not simply describe what happened.$mq$, $mq$medium$mq$),
($mq$A test shows that 9 of 10 users found a toothbrush holder easy to clean, but the one who did not was left-handed. What is the most thoughtful response?$mq$, $mq$["Ignore the result because 9 is most","Say the test failed","Remove the toothbrush","Investigate whether the design disadvantages left-handed users and consider changes"]$mq$, 3, $mq$A minority result can reveal an inclusion issue. Considering it improves the design.$mq$, $mq$hard$mq$),
($mq$Testing 3 times gave bending loads of 48 N, 50 N and 49 N. A fourth test gave 30 N. Which approach to the outlier is best?$mq$, $mq$["Delete it silently","Average all four and ignore the problem","Investigate why it differed (e.g. a faulty part or method) before deciding how to treat it","Say the product is useless"]$mq$, 2, $mq$Unusual results should be examined, not hidden. The cause may be a testing error or a real weakness.$mq$, $mq$hard$mq$),
($mq$A student concludes that a bird feeder is 'sustainable' because it is wooden. What further evidence would strengthen the claim?$mq$, $mq$["The shape of the roof","Wood source (certified or local), finishes used and ability to reuse or recycle","The colour of the paint","The number of birds in the neighbourhood"]$mq$, 1, $mq$A sustainability claim needs evidence about sourcing, processing, use and end of life.$mq$, $mq$hard$mq$),
($mq$A student evaluates a chair: 'Meets 7 of 9 specification points. Fails stacking and weight limits. Users reported lower back discomfort after 30 minutes.' Which next step makes the evaluation most useful?$mq$, $mq$["Propose changes to the back support, stacking design and weight, ranked by importance","State the chair is perfect","Rewrite the specification so the chair passes","Remove the discomfort result"]$mq$, 0, $mq$A strong evaluation proposes specific, prioritised improvements based on the evidence rather than changing goals after the fact.$mq$, $mq$hard$mq$),
($mq$Why should an evaluation consider the impact of the product on the client and on others?$mq$, $mq$["Because it fills the page","Because it avoids testing","Because the client wrote it","Products affect users, communities and the environment beyond the original purpose"]$mq$, 3, $mq$Design has wider consequences, such as safety, access, waste and cultural impact, so evaluation should consider them.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Evaluating the Product$mq$ and p.name = $mq$The Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Criterion D$mq$, $mq$Evaluating: design tests, judge the product against the specification, consider its impact and suggest improvements.$mq$),
($mq$Objective result$mq$, $mq$A measurable fact, such as mass, time, force or number of successful trials.$mq$),
($mq$Subjective result$mq$, $mq$An opinion or feeling, such as comfort or attractiveness, often gathered by feedback.$mq$),
($mq$Why repeat tests?$mq$, $mq$Repeated trials show whether results are consistent and reduce the effect of chance or a one-off error.$mq$),
($mq$Outlier$mq$, $mq$A result that is very different from the others. Investigate the cause before deciding how to treat it.$mq$),
($mq$Client feedback$mq$, $mq$Opinions from the person or group the product is for. It shows whether real needs are met.$mq$),
($mq$Good improvement suggestion$mq$, $mq$Specific, linked to a weakness found in testing, and explained, for example a wider handle to spread pressure.$mq$),
($mq$Impact of a product$mq$, $mq$Effects on users, society and the environment across materials, manufacture, use and disposal.$mq$),
($mq$Evaluation sentence structure$mq$, $mq$Result, comparison with the requirement, reason for the outcome, and a practical improvement.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Evaluating the Product$mq$ and p.name = $mq$The Design Cycle$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Criterion D overview
Criterion D, **Evaluating**, asks you to judge how successful your product is and how it could be better. You design methods to test the solution, collect results, compare them with your specification, think about the impact of the product and suggest improvements. The aim is honest, evidence-based thinking, not praise.

## Designing tests
Plan tests that measure whether each requirement in your specification is met. Good tests are:
- **Linked to the specification**: if the requirement is "carries 5 kg", test with 5 kg.
- **Fair and repeatable**: use the same method each time and repeat trials.
- **Safe**: do not test in ways that could cause injury.
- **Recorded**: collect results in a table or list with units.
Example: To test a phone stand, place a 200 g phone at three angles, tilt the desk by 10° and see whether it stays in place. Record pass or fail for each trial.

## Objective and subjective results
**Objective** results are measurable facts, such as mass, time, force, length or number of trials passed. **Subjective** results are opinions, such as how comfortable something feels. Both are valuable. Use objective tests where possible, and collect feedback from your client and test users for subjective qualities like comfort and appearance.

## Evaluating against the specification
Go through the specification point by point and state whether each is met, partly met or not met, giving evidence. If the specification said "mass below 400 g" and your product measures 430 g, write that the point was not met by 30 g and explain what caused this. Be honest: a clear account of a failure is better than an unsupported claim of success.

## Considering impact
Products affect people and the environment. Think about:
- **The client and users**: Is it safe, accessible and enjoyable?
- **Society**: Does it benefit or disadvantage anyone?
- **The environment**: What are the effects of materials, manufacture, use, transport and disposal?
Link your comments to evidence, such as the material used or the number of replaceable parts.

## Suggesting improvements
Each improvement should be specific and linked to a weakness. For example: "The handle caused discomfort for 4 of 6 testers. A wider, rounded handle would spread pressure over a larger area." Rank suggestions by importance and say how they would be tested next time.

## Evaluating your own performance
Reflect on your design process too. What went well, which skills improved, what you would plan differently and how you managed time. Keep it focused on evidence.

## How this is examined
In exam-style practice questions you may be shown a short results table or paragraph and asked to decide which conclusion is justified, identify a weakness in a test, interpret client feedback, or select the best improvement. Command terms include **evaluate**, **justify**, **suggest** and **assess**. Compare each result with the matching specification point before answering.

## Common mistakes
- Saying a product is "good" without evidence.
- Changing the specification afterwards so the product passes.
- Testing only once.
- Giving improvements that are vague.

Exam tip: Structure an evaluation sentence as result, comparison with requirement, reason, improvement.$mq$ from st;

-- Materials and Making > Properties of Materials
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Materials and Making$mq$, 5, 2 from public.subjects s where s.slug = $mq$product-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Properties of Materials$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$product-design$mq$ and p.grade = 5 and p.name = $mq$Materials and Making$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Properties of Materials$mq$ and p.name = $mq$Materials and Making$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which property describes how well a material resists being scratched or dented?$mq$, $mq$["Hardness","Elasticity","Conductivity","Malleability"]$mq$, 0, $mq$Hardness is resistance to scratching, denting and abrasion. Elasticity is the ability to return to shape after being stretched.$mq$, $mq$easy$mq$),
($mq$Which of these is a hardwood?$mq$, $mq$["Pine","Spruce","Fir","Oak"]$mq$, 3, $mq$Oak comes from broad-leaved deciduous trees and is a hardwood. Pine, spruce and fir are softwoods from conifers.$mq$, $mq$easy$mq$),
($mq$Which material is a thermoplastic?$mq$, $mq$["Epoxy resin","Melamine formaldehyde","Polypropylene","Urea formaldehyde"]$mq$, 2, $mq$Thermoplastics can be softened by heat and reshaped many times. The other three are thermosetting plastics.$mq$, $mq$easy$mq$),
($mq$Which property allows a metal to be hammered or rolled into thin sheets?$mq$, $mq$["Brittleness","Malleability","Toughness","Density"]$mq$, 1, $mq$Malleability is the ability to be shaped by compression without cracking. Ductility is the ability to be drawn into wire.$mq$, $mq$easy$mq$),
($mq$Which of these is a ferrous metal?$mq$, $mq$["Mild steel","Aluminium","Copper","Brass"]$mq$, 0, $mq$Ferrous metals contain iron. Aluminium and copper are non-ferrous, and brass is a non-ferrous alloy of copper and zinc.$mq$, $mq$easy$mq$),
($mq$A designer needs a handle for a saucepan that stays cool while the pan is hot. Which property is most important?$mq$, $mq$["High electrical conductivity","High density","High malleability","Low thermal conductivity"]$mq$, 3, $mq$Low thermal conductivity means heat passes slowly through the handle so it is comfortable to hold.$mq$, $mq$medium$mq$),
($mq$Why are electrical cables made of copper with a plastic covering?$mq$, $mq$["Copper insulates and plastic conducts","Both are good conductors","Copper conducts electricity well and plastic insulates","Both are brittle"]$mq$, 2, $mq$Copper has low electrical resistance, while the plastic sheath prevents shocks and short circuits.$mq$, $mq$medium$mq$),
($mq$Which material is a composite?$mq$, $mq$["Pure copper","Glass reinforced plastic (GRP)","Brass","Polythene"]$mq$, 1, $mq$A composite combines two or more materials, here glass fibres in a resin. Brass is an alloy, which is a mixture of metals, not a composite.$mq$, $mq$medium$mq$),
($mq$Plywood is often used in furniture instead of solid timber. What is a key advantage?$mq$, $mq$["Layers with grain at right angles resist warping and splitting","It is a metal","It is a thermosetting plastic","It conducts heat well"]$mq$, 0, $mq$Alternating the grain direction of the veneers makes plywood strong in both directions and stable.$mq$, $mq$medium$mq$),
($mq$A kettle body must withstand heat without softening. Why is a thermosetting plastic more suitable than a thermoplastic for a hot cooking handle?$mq$, $mq$["Thermosets are always cheaper","Thermosets melt easily","Thermosets are metals","Thermosets do not soften again once set"]$mq$, 3, $mq$Thermosetting plastics have cross-links that do not melt when reheated, so they stay rigid at moderate high temperatures.$mq$, $mq$medium$mq$),
($mq$A material can be stretched under load and then returns to its original shape when the load is removed. What is this property?$mq$, $mq$["Plasticity","Brittleness","Elasticity","Corrosion"]$mq$, 2, $mq$Elasticity is the ability to return to the original shape after being deformed. Plastic deformation is permanent.$mq$, $mq$medium$mq$),
($mq$Why is aluminium often chosen for aircraft and bicycle frames?$mq$, $mq$["High density and heavy","Low density with good strength and corrosion resistance","It rusts quickly","It is a thermoplastic"]$mq$, 1, $mq$Aluminium (usually in alloys) has a high strength-to-weight ratio and forms a protective oxide layer.$mq$, $mq$medium$mq$),
($mq$A student must choose a material for an outdoor garden bench. Which option is the best combination of properties?$mq$, $mq$["Treated hardwood: durable and weather resistant","Untreated cardboard: cheap and light","Thin glass: transparent","Raw mild steel without any coating: strong"]$mq$, 0, $mq$Outdoor materials must resist moisture and decay. Treated hardwood does this. Bare mild steel rusts and cardboard degrades.$mq$, $mq$medium$mq$),
($mq$The table in a report states: 'Material X density 2.7 g/cm³, Material Y density 7.8 g/cm³. Both parts have the same volume of 100 cm³.' What is the mass of part Y?$mq$, $mq$["270 g","78 g","7800 g","780 g"]$mq$, 3, $mq$Mass = density × volume = 7.8 × 100 = 780 g. X would be 270 g.$mq$, $mq$hard$mq$),
($mq$A bridge model must resist being pulled apart. Which test measures this property?$mq$, $mq$["Hardness scratch test","Conductivity test","Tensile strength test","Colour test"]$mq$, 2, $mq$Tensile strength is the ability to resist pulling forces. Hardness and conductivity are different properties.$mq$, $mq$hard$mq$),
($mq$Which statement about alloys is correct?$mq$, $mq$["Alloys are always pure elements","Alloys are mixtures of metals that often have improved properties","Alloys are always plastics","Alloys are made of timber"]$mq$, 1, $mq$Alloys combine metals (or a metal and another element) to improve properties such as strength or corrosion resistance. Brass and stainless steel are examples.$mq$, $mq$hard$mq$),
($mq$A designer compares two materials for a phone case. Material M is tough but scratches easily; material N is hard but brittle. The phone is often dropped on tiles. Which is the best justified choice?$mq$, $mq$["M, because toughness absorbs impact without shattering","N, because hardness always prevents cracking","N, because brittle materials absorb impact well","Neither property matters"]$mq$, 0, $mq$Toughness is resistance to fracture under impact. A brittle material may crack when dropped, so toughness matters more here, though a coating could add scratch resistance.$mq$, $mq$hard$mq$),
($mq$Why might a manufacturer choose recycled PET for a drinks bottle rather than virgin PET, even if the cost is similar?$mq$, $mq$["It makes the bottle a metal","It makes the bottle thermosetting","It removes the need for design","It reduces the use of new resources and waste"]$mq$, 3, $mq$Recycled content reduces demand for virgin raw materials and landfill waste, supporting sustainable design.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Properties of Materials$mq$ and p.name = $mq$Materials and Making$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Hardness$mq$, $mq$Resistance to scratching, denting and wear.$mq$),
($mq$Toughness vs brittleness$mq$, $mq$A tough material absorbs impact without breaking; a brittle material snaps or shatters suddenly.$mq$),
($mq$Malleable vs ductile$mq$, $mq$Malleable: can be hammered or rolled into shape. Ductile: can be drawn into a wire.$mq$),
($mq$Hardwood vs softwood$mq$, $mq$Hardwoods come from broad-leaved trees (oak, beech); softwoods come from conifers (pine, spruce).$mq$),
($mq$Ferrous and non-ferrous metals$mq$, $mq$Ferrous metals contain iron (mild steel, cast iron). Non-ferrous do not (aluminium, copper).$mq$),
($mq$Alloy$mq$, $mq$A mixture of metals, or a metal with another element, with improved properties, such as brass or stainless steel.$mq$),
($mq$Thermoplastic vs thermosetting plastic$mq$, $mq$Thermoplastics soften repeatedly when heated; thermosetting plastics set permanently and do not soften again.$mq$),
($mq$Composite$mq$, $mq$A material made from two or more materials combined to get the benefits of both, such as GRP.$mq$),
($mq$Density formula$mq$, $mq$Density = mass ÷ volume. Mass = density × volume. Lower density gives a lighter product.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Properties of Materials$mq$ and p.name = $mq$Materials and Making$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why materials matter
A designer must choose materials that suit the product's function, the user, the manufacturing process, the cost and the environment. To choose well you need to know the **properties** of materials and the families they belong to.

## Key properties
- **Hardness**: resistance to scratching, denting and wear.
- **Toughness**: ability to absorb impact without breaking. Opposite: **brittleness**, where a material snaps or shatters suddenly.
- **Strength**: resistance to forces. Tensile strength resists pulling and compressive strength resists squashing.
- **Elasticity**: returns to shape after being stretched or bent. **Plasticity**: stays deformed.
- **Malleability**: can be hammered or pressed into shape. **Ductility**: can be drawn into wire.
- **Density**: mass per unit volume, calculated as mass ÷ volume. Lower density gives lighter products.
- **Thermal and electrical conductivity**: how easily heat or electricity passes through. Metals conduct well, plastics and wood mostly insulate.
- **Corrosion resistance**: ability to resist chemical attack, such as rusting in iron.

## Material families
### Timber
**Hardwoods** come from broad-leaved trees such as oak, beech and mahogany. They are usually slower growing, denser and more expensive. **Softwoods** come from conifers such as pine and spruce. They are quick growing and cheaper. **Manufactured boards** include plywood, MDF and chipboard, which are made from layers, fibres or chips bonded with adhesive. They are stable and available in large flat sheets.

### Metals
**Ferrous** metals contain iron, for example mild steel (strong and cheap but rusts) and cast iron (hard but brittle). **Non-ferrous** metals do not contain iron: aluminium (light and corrosion resistant), copper (excellent conductor) and zinc. An **alloy** is a mixture of metals, such as brass (copper and zinc) or stainless steel (iron with chromium).

### Plastics
**Thermoplastics** soften when heated and can be reshaped repeatedly. Examples are polythene, polypropylene and acrylic. **Thermosetting plastics** set permanently and do not soften again, for example epoxy resin and melamine formaldehyde, which is used for hard-wearing surfaces.

### Composites and smart materials
**Composites** combine two materials to gain the benefits of both, such as glass reinforced plastic (GRP) or carbon fibre reinforced plastic. **Smart materials** respond to a change in their environment, such as thermochromic film that changes colour with temperature.

## Worked example: density
A metal part has a volume of 50 cm³ and a density of 2.7 g/cm³. Its mass is 2.7 × 50 = 135 g. A steel part of the same volume with density 7.8 g/cm³ has a mass of 7.8 × 50 = 390 g, almost three times as much.

## Choosing materials
Match properties to the need: a garden chair needs weather resistance, a saucepan handle needs low thermal conductivity, a cable core needs high electrical conductivity. Consider cost, availability, ease of working, appearance and environmental impact, including whether the material can be reused or recycled.

## How this is examined
In exam-style practice questions you might read a short product scenario and be asked to select the most suitable material and justify it, compare two materials from data such as density or cost, or identify a property from its description. Command terms include **identify**, **state**, **explain** and **justify**. Link each property to the function in the question.

## Common mistakes
- Confusing hardness with strength.
- Mixing up thermoplastic and thermosetting plastics.
- Saying all metals are magnetic. Only some ferrous metals are.
- Naming a property without linking it to the product's use.

Exam tip: To justify a material choice, name the property, then say why that property matters for the product.$mq$ from st;

-- Materials and Making > Tools and Manufacturing Methods
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Materials and Making$mq$, 5, 2 from public.subjects s where s.slug = $mq$product-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Tools and Manufacturing Methods$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$product-design$mq$ and p.grade = 5 and p.name = $mq$Materials and Making$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Tools and Manufacturing Methods$mq$ and p.name = $mq$Materials and Making$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which tool is best for cutting a thin curved shape in plywood?$mq$, $mq$["Coping saw","Tenon saw","Hacksaw","Chisel"]$mq$, 0, $mq$A coping saw has a thin blade that can turn tight curves. A tenon saw is for straight joint cuts and a hacksaw is for metal.$mq$, $mq$easy$mq$),
($mq$What is a 'prototype'?$mq$, $mq$["A final mass-produced item","A drawing only","A sales brochure","A first model made to test a design"]$mq$, 3, $mq$A prototype is a model or early version used to test ideas before production.$mq$, $mq$easy$mq$),
($mq$Which type of production makes one item at a time, often to a customer's needs?$mq$, $mq$["Mass production","Continuous production","One-off production","Batch production"]$mq$, 2, $mq$One-off (job) production makes a single, often custom, product, such as a bespoke piece of furniture.$mq$, $mq$easy$mq$),
($mq$What does CNC stand for?$mq$, $mq$["Cutting new components","Computer numerical control","Central nylon casting","Careful normal cutting"]$mq$, 1, $mq$CNC machines follow coded instructions from a computer to cut or shape material accurately.$mq$, $mq$easy$mq$),
($mq$Which process heats plastic until soft and then forms it over a mould using vacuum?$mq$, $mq$["Vacuum forming","Injection moulding","Casting","Laminating"]$mq$, 0, $mq$Vacuum forming sucks softened plastic sheet onto a mould to make shapes such as trays and packaging.$mq$, $mq$easy$mq$),
($mq$A company makes 500 identical water bottles in a run, then switches the machine to produce 500 bottles of a different colour. What type of production is this?$mq$, $mq$["One-off production","Continuous production","Prototype production","Batch production"]$mq$, 3, $mq$Batch production makes a set quantity of identical products before changing to another.$mq$, $mq$medium$mq$),
($mq$Why is injection moulding suitable for making thousands of identical plastic parts?$mq$, $mq$["The mould is cheap and simple","It needs no machine","Once the mould is made, parts are produced quickly and consistently","It works only for single items"]$mq$, 2, $mq$Moulds are expensive but allow fast, repeatable production, so the cost per part falls with large quantity.$mq$, $mq$medium$mq$),
($mq$A laser cutter is used to cut shapes from acrylic sheet. Which is an advantage over cutting by hand?$mq$, $mq$["Slower for complicated shapes","High accuracy and repeatability","Needs no design file","Works without electricity"]$mq$, 1, $mq$Laser cutters follow digital drawings, producing precise, repeatable parts.$mq$, $mq$medium$mq$),
($mq$Which is the main reason for using a marking gauge in woodwork?$mq$, $mq$["To mark a line parallel to an edge at a set distance","To cut curves","To sand surfaces","To drill holes"]$mq$, 0, $mq$A marking gauge scribes a consistent line parallel to an edge, useful for joints.$mq$, $mq$medium$mq$),
($mq$A designer wants to produce a complex hollow shape in metal, such as an engine part. Which process is suitable?$mq$, $mq$["Sanding","Bending thin wire","Folding paper","Casting by pouring molten metal into a mould"]$mq$, 3, $mq$Casting allows complex solid or hollow shapes using a mould.$mq$, $mq$medium$mq$),
($mq$Which is a safety reason for using a vice or clamp?$mq$, $mq$["It makes material stronger","It heats the material","It holds the workpiece securely so both hands are free","It prevents corrosion"]$mq$, 2, $mq$Securing work prevents movement and reduces the risk of injury and inaccuracy.$mq$, $mq$medium$mq$),
($mq$Why might a company choose 3D printing for prototypes rather than injection moulding?$mq$, $mq$["It always produces cheaper large batches","No expensive mould is needed for small quantities","It works only with timber","It is slower and less flexible than a mould for one item"]$mq$, 1, $mq$Additive manufacturing builds directly from a digital file, so changes are quick and there is no tooling cost for one-off prototypes.$mq$, $mq$medium$mq$),
($mq$What is the difference between a subtractive and additive process?$mq$, $mq$["Subtractive removes material; additive builds layer by layer","Subtractive adds; additive removes","They are identical","Subtractive only works on plastic"]$mq$, 0, $mq$Milling and drilling are subtractive. 3D printing is additive.$mq$, $mq$medium$mq$),
($mq$A factory's injection mould costs 12 000 dollars and each part then costs 0.40 dollars in materials and energy. What is the average cost per part if 20 000 are made?$mq$, $mq$["0.60 dollars","12.40 dollars","0.40 dollars","1.00 dollars"]$mq$, 3, $mq$Mould cost per part = 12 000 ÷ 20 000 = 0.60. Adding 0.40 gives 1.00 dollar per part.$mq$, $mq$hard$mq$),
($mq$For the same mould, how many parts must be made for the average cost per part to fall to 0.80 dollars?$mq$, $mq$["15 000","12 000","30 000","60 000"]$mq$, 2, $mq$Average = 12 000 ÷ n + 0.40 = 0.80, so 12 000 ÷ n = 0.40 and n = 30 000.$mq$, $mq$hard$mq$),
($mq$A company currently makes 50 custom wooden signs a month by hand. Orders rise to 5000 identical signs a month. Which change is most appropriate?$mq$, $mq$["Continue entirely by hand","Move to CNC routing with jigs for repeatable cutting","Stop making signs","Use only pencils"]$mq$, 1, $mq$High-volume, identical output suits automated machining. Hand work would be slow and inconsistent.$mq$, $mq$hard$mq$),
($mq$A student states that CNC machines remove the need for human skill. Which is the best response?$mq$, $mq$["Skilled people still design, program, set up, monitor and maintain the machines","Correct, no skill is required","Machines never need maintenance","Designers are not needed"]$mq$, 0, $mq$CNC changes the type of skill needed but does not remove it. Operators check settings, safety and quality.$mq$, $mq$hard$mq$),
($mq$A product must be produced quickly in thousands but must also allow quick colour changes. Which production approach fits best?$mq$, $mq$["One-off production","Hand carving","Only prototyping","Batch production with flexible machinery"]$mq$, 3, $mq$Batch production makes sets of identical items and allows changes between runs while still being efficient.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Tools and Manufacturing Methods$mq$ and p.name = $mq$Materials and Making$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$CAD and CAM$mq$, $mq$CAD: computer-aided design (digital drawing). CAM: computer-aided manufacture, where design files control machines.$mq$),
($mq$CNC machine$mq$, $mq$A computer numerical control machine follows coded instructions to cut or shape material accurately and repeatedly.$mq$),
($mq$Additive vs subtractive$mq$, $mq$Additive builds a part up layer by layer (3D printing). Subtractive removes material (milling, drilling, sawing).$mq$),
($mq$Vacuum forming$mq$, $mq$Heated thermoplastic sheet is pulled over a mould by vacuum. Used for trays, packaging and food containers.$mq$),
($mq$Injection moulding$mq$, $mq$Molten plastic is forced into a mould. Fast and repeatable, but the mould is expensive, so it suits large quantities.$mq$),
($mq$One-off production$mq$, $mq$A single item made, often to order. High skill and high cost per item, but very flexible.$mq$),
($mq$Batch production$mq$, $mq$A set number of identical items made together, then the machinery changes to another product.$mq$),
($mq$Mass production$mq$, $mq$Large numbers of identical items on production lines. High set-up cost but low cost per item.$mq$),
($mq$Average cost per unit$mq$, $mq$(Tooling cost ÷ number made) + cost per unit for materials and energy. Larger quantities lower the average.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Tools and Manufacturing Methods$mq$ and p.name = $mq$Materials and Making$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Making a design real
Once a design is chosen, it has to be made. The tools, processes and scale of production you pick affect cost, quality, speed and impact on the environment. You need to know common hand tools, machine tools and manufacturing methods, and when each is best.

## Hand tools and measuring
- **Marking out**: pencils, scribers, rules, squares, marking gauges and templates. Accurate marking makes accurate parts.
- **Cutting**: tenon saw (straight cuts in wood), coping saw (curves), hacksaw (metal and plastic), snips (thin sheet), craft knife (card and foam).
- **Shaping**: files, rasps, chisels and sandpaper.
- **Holding**: vices, clamps and workholding jigs keep the workpiece steady.
Always use the correct tool for the material and keep it sharp and clean.

## Machine tools
- **Pillar drill**: drills accurate holes. Clamp small pieces.
- **Lathe**: spins the workpiece while a cutting tool shapes it, producing round shapes like table legs.
- **Band saw and scroll saw**: cut curves and shapes.
- **Milling machine**: removes material with a rotating cutter.
All machines require training, guards and eye protection.

## Digital manufacturing
**CAD (computer-aided design)** produces digital drawings. **CAM (computer-aided manufacture)** uses those files to control machines. A **CNC** machine follows coded instructions to cut or mill accurately and repeatedly. A **laser cutter** cuts or engraves sheet materials. A **3D printer** is an **additive** process, building a part layer by layer, while milling and drilling are **subtractive**, removing material.

## Forming plastics and metals
- **Vacuum forming**: heated thermoplastic sheet is drawn over a mould by vacuum.
- **Injection moulding**: molten plastic is injected into a metal mould. Very fast and repeatable but the mould is expensive.
- **Casting**: molten metal or resin poured into a mould.
- **Bending**: heating a thermoplastic or folding sheet metal.

## Scales of production
- **One-off**: a single item, high skill, high cost per item, flexible.
- **Batch**: a set number made together, then changed to another product.
- **Mass**: large quantities of identical products on production lines, low cost per item, expensive setup.
- **Continuous**: runs constantly, for example producing paper or plastic film.

### Worked example
A mould costs 8000 dollars and each part costs 0.50 dollars to make. For 10 000 parts, the average cost per part is 8000 ÷ 10 000 + 0.50 = 1.30 dollars. If 40 000 parts are made, it falls to 0.20 + 0.50 = 0.70 dollars. This is why mass production is cheaper per item.

## Quality and safety
Quality control checks sizes, finish and function at stages. Use jigs, templates and gauges to keep parts consistent. Follow workshop safety rules and wear protective equipment.

## How this is examined
In exam-style practice questions you may be shown a product and asked to choose a suitable process, explain why a tool or method is used, compare production types using cost data or calculate average cost per unit. Command terms include **identify**, **explain**, **calculate** and **justify**. Match the process to the material, quantity and shape required.

## Common mistakes
- Confusing batch with mass production.
- Choosing injection moulding for a single prototype.
- Forgetting tooling costs in cost comparisons.
- Using a tool name without saying what it does.

Exam tip: For production questions, always consider the quantity needed. Quantity often decides which method is best.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('product-design')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;