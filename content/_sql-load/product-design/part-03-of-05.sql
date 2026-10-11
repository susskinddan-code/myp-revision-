-- Part 3 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Materials and Making > Joining and Finishing
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Materials and Making$mq$, 5, 2 from public.subjects s where s.slug = $mq$product-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Joining and Finishing$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$product-design$mq$ and p.grade = 5 and p.name = $mq$Materials and Making$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Joining and Finishing$mq$ and p.name = $mq$Materials and Making$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which adhesive is commonly used for gluing wood in furniture?$mq$, $mq$["PVA glue","Superglue only","Solder","Weld"]$mq$, 0, $mq$PVA (polyvinyl acetate) is a white wood glue that sets strongly when clamped.$mq$, $mq$easy$mq$),
($mq$What is the purpose of a finish on wood?$mq$, $mq$["To make it heavier","To weaken it","To remove all grain","To protect it and improve appearance"]$mq$, 3, $mq$Finishes such as paint, varnish and oil protect against moisture and wear, and can improve appearance.$mq$, $mq$easy$mq$),
($mq$Which fastener has a thread and is turned with a screwdriver?$mq$, $mq$["Nail","Rivet","Screw","Dowel"]$mq$, 2, $mq$A screw has a helical thread that grips the material. Nails are driven in with a hammer.$mq$, $mq$easy$mq$),
($mq$Which joint is made by cutting interlocking tails and pins?$mq$, $mq$["Butt joint","Dovetail joint","Dowel joint","Lap joint"]$mq$, 1, $mq$Dovetail joints interlock and resist being pulled apart, used for drawers.$mq$, $mq$easy$mq$),
($mq$What process uses a low melting-point alloy to join metal parts such as electronic components?$mq$, $mq$["Soldering","Gluing","Riveting","Stitching"]$mq$, 0, $mq$Soldering joins metals with a molten filler alloy (solder), commonly used in electronics.$mq$, $mq$easy$mq$),
($mq$A student joins two plywood panels at right angles using glue and a few small dowels. Why are dowels added?$mq$, $mq$["To make the wood softer","To stop glue working","To reduce strength","To align the parts and increase the glued area"]$mq$, 3, $mq$Dowels help alignment and strengthen a butt joint by adding extra bonding surface.$mq$, $mq$medium$mq$),
($mq$What is a permanent fixing?$mq$, $mq$["One that is easily taken apart, such as a bolt","One for temporary use only","One that cannot be undone without damage, such as welding or rivets","One that uses no materials"]$mq$, 2, $mq$Permanent fixings include adhesives, rivets and welds. Temporary (knock-down) fixings include bolts and screws.$mq$, $mq$medium$mq$),
($mq$Why would flat-pack furniture use cam locks and bolts rather than permanent glue?$mq$, $mq$["They are cheaper only","They allow assembly and disassembly by the user","They are invisible","They make furniture stronger than glue always"]$mq$, 1, $mq$Knock-down fittings let customers assemble products at home and make transport compact.$mq$, $mq$medium$mq$),
($mq$A designer wants to protect a metal garden gate from rust. Which finish is suitable?$mq$, $mq$["Zinc-rich paint or galvanising","Clear paper","No finish","A wax crayon"]$mq$, 0, $mq$Coatings that block oxygen and moisture prevent iron corroding. Galvanising applies a protective zinc layer.$mq$, $mq$medium$mq$),
($mq$What is the main advantage of using a rivet to join two sheets of aluminium?$mq$, $mq$["It can be easily taken apart","It melts the aluminium","It needs no tools","It makes a strong permanent joint without heat"]$mq$, 3, $mq$Rivets are used where welding is difficult. Heat can distort thin sheets or damage coatings.$mq$, $mq$medium$mq$),
($mq$Why should a surface be sanded before painting wood?$mq$, $mq$["To make the wood weaker","To add moisture","To create a smooth surface so paint adheres and looks even","To remove the need for paint"]$mq$, 2, $mq$Preparation influences finish quality. Sanding removes roughness and gives the paint a key to bond to.$mq$, $mq$medium$mq$),
($mq$Which statement about finishing plastics is correct?$mq$, $mq$["Plastics can never be finished","Acrylic edges can be polished to a shiny finish","All plastics are finished with varnish","Plastics should be oiled like wood"]$mq$, 1, $mq$Acrylic can be polished with abrasives and buffing to give a clear, glossy edge.$mq$, $mq$medium$mq$),
($mq$A wooden child's toy must be safe if chewed. Which finish is the best choice?$mq$, $mq$["A non-toxic, food-safe oil or water-based paint","Lead paint","Solvent-based varnish with toxic additives","No consideration of safety"]$mq$, 0, $mq$Products for children must use safe finishes that meet toy safety standards.$mq$, $mq$medium$mq$),
($mq$A table top glued from several boards cracks after a year indoors near a radiator. What is the most likely reason?$mq$, $mq$["Wood is a metal","Glue conducts electricity","The boards were too smooth","Wood shrinks as it dries, and the glued panels were held rigidly"]$mq$, 3, $mq$Timber moves with moisture and temperature, so joints and fixings must allow for movement or the wood must be well seasoned.$mq$, $mq$hard$mq$),
($mq$A designer needs a joint that can resist pulling apart in a box corner, and appearance matters. Which joint and reason are best?$mq$, $mq$["Butt joint only, because it has no gluing area","Nail only, because nails never loosen","Finger joint, because it has large glued surfaces and interlocks","A staple joint, because it is invisible"]$mq$, 2, $mq$Finger and dovetail joints add a large gluing area and mechanical locking, giving strength and an attractive appearance.$mq$, $mq$hard$mq$),
($mq$A company compares fixing options for a kitchen cabinet: screws (removable) or permanent glue. The cabinet might need repair or recycling later. Which statement is the best evaluation?$mq$, $mq$["Glue is always better","Screws make repair and recycling easier, but may need a stronger design to resist loosening","Screws are never strong","Recycling is unrelated to joining methods"]$mq$, 1, $mq$Design for disassembly helps repair and recycling. The designer should also consider how to keep screws secure.$mq$, $mq$hard$mq$),
($mq$Two finishes are tested on pine. Oil takes 2 hours to apply and protects for about 2 years. Polyurethane varnish takes 3 hours to apply and protects for about 6 years. Both need re-coating at the end of life. Per hour of application, which gives more years of protection?$mq$, $mq$["Varnish: 6 ÷ 3 = 2 years per hour compared with oil's 1 year per hour","Oil: 2 ÷ 2 = 1 year per hour compared with varnish's 0.5","They are equal","Cannot be compared"]$mq$, 0, $mq$Oil gives 2 ÷ 2 = 1 year per hour of application. Varnish gives 6 ÷ 3 = 2 years per hour, so varnish is more efficient on this measure.$mq$, $mq$hard$mq$),
($mq$A product is soldered, but a customer drops it and a joint fails. Which improvement is most appropriate?$mq$, $mq$["Use less solder","Remove all fixings","Paint over the joint","Reinforce the joint and reduce strain on the solder, for example with a clip or strain relief"]$mq$, 3, $mq$Solder is weak under strain. Mechanical support reduces the force on the joint.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Joining and Finishing$mq$ and p.name = $mq$Materials and Making$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Permanent vs temporary fixing$mq$, $mq$Permanent cannot be undone without damage (glue, rivets, welds). Temporary can be taken apart (screws, bolts).$mq$),
($mq$PVA$mq$, $mq$Polyvinyl acetate: a white wood glue. Parts need clamping while it sets.$mq$),
($mq$Dowel joint$mq$, $mq$A joint where wooden pegs align two pieces and increase the glued area.$mq$),
($mq$Dovetail joint$mq$, $mq$Interlocking tails and pins that resist being pulled apart. Strong and attractive, used for drawers.$mq$),
($mq$Mortise and tenon$mq$, $mq$A tongue (tenon) fits into a slot (mortise). Very strong for frames and furniture legs.$mq$),
($mq$Soldering$mq$, $mq$Joining metals with a molten low-melting-point alloy. Common for electronics and copper pipe.$mq$),
($mq$Galvanising$mq$, $mq$Coating iron or steel with zinc to protect it from rusting.$mq$),
($mq$Surface preparation$mq$, $mq$Cleaning and sanding a surface before finishing so the coating sticks and looks even.$mq$),
($mq$Design for disassembly$mq$, $mq$Using screws and clips instead of permanent glue so products can be repaired and recycled more easily.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Joining and Finishing$mq$ and p.name = $mq$Materials and Making$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why joining and finishing matter
Most products are made of several parts that must be fixed together, and nearly all benefit from a finish that protects them and improves appearance. The choices affect strength, cost, safety, repair and recycling.

## Types of fixing
**Permanent fixings** cannot be undone without damage. **Temporary** or **knock-down** fixings can be taken apart.
- **Adhesives**: PVA for wood, epoxy resin for strong joins of many materials, solvent cement for some plastics, hot glue for quick low-strength joins. Surfaces must be clean and clamped while the glue sets.
- **Mechanical fastenings**: nails, screws, bolts and nuts, rivets and staples. Screws and bolts are temporary. Rivets are permanent.
- **Heat joining**: welding fuses metals, brazing uses a brass filler, and soldering uses a low-melting alloy to join electronic components and copper pipes.

## Wood joints
- **Butt joint**: two pieces simply meeting. Weak unless reinforced with dowels, screws or corner blocks.
- **Dowel joint**: wooden pegs align the parts and increase gluing area.
- **Lap and halving joints**: overlapping surfaces give more glue area.
- **Finger (box) joint**: interlocking fingers give large glue area, used in boxes.
- **Dovetail joint**: tails and pins lock against pulling, ideal for drawers.
- **Mortise and tenon**: a tongue fits in a slot, strong for frames and legs.
Joint choice depends on strength required, appearance, tools available and whether the product needs to be taken apart.

## Joining metals and plastics
Sheet metal can be riveted, bolted or welded. Thermoplastics can be joined with solvent cement or heat welded. Acrylic is cut and cemented with a solvent that softens the surfaces.

## Finishes
- **Wood**: sanding, then paint, varnish, stain, wax or oil. Finishes protect against moisture and wear.
- **Metal**: paint, powder coating, plating, galvanising (zinc coating) and polishing. Finishes prevent corrosion.
- **Plastic**: usually self-finished but can be polished or printed. Edges can be sanded and buffed.
Surface preparation is vital: clean, sand smooth and remove dust before finishing.

## Worked example
A tray is to be made in pine for outdoor use. A designer compares options. Oil is quick but needs frequent reapplying. Exterior varnish takes longer but lasts longer. The designer considers safety for food contact and chooses a food-safe oil, planning a maintenance schedule.

## Design for disassembly
Using screws and clips instead of glue makes it easier to repair or recycle parts. Using fewer different materials also helps recycling.

## How this is examined
In exam-style practice questions you could be given a product scenario and asked to select a suitable joint or finish, explain why a joint fails, or evaluate a fixing for repair and recycling. Command terms include **identify**, **explain** and **evaluate**. Think about forces on the joint, the material, appearance and end of life.

## Common mistakes
- Using screws in a place where a permanent joint is needed.
- Forgetting surface preparation before finishing.
- Using toxic finishes on children's items.
- Ignoring wood movement.

Exam tip: Link every fixing or finish to both a property (for example strength or water resistance) and a use.$mq$ from st;

-- Designing for People > Ergonomics and Anthropometrics
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Designing for People$mq$, 5, 3 from public.subjects s where s.slug = $mq$product-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Ergonomics and Anthropometrics$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$product-design$mq$ and p.grade = 5 and p.name = $mq$Designing for People$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Ergonomics and Anthropometrics$mq$ and p.name = $mq$Designing for People$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does anthropometrics study?$mq$, $mq$["The measurements of the human body","The strength of materials","The cost of manufacturing","The history of design"]$mq$, 0, $mq$Anthropometrics is the collection and use of human body measurements, such as height, hand width and reach.$mq$, $mq$easy$mq$),
($mq$Ergonomics is mainly about which of the following?$mq$, $mq$["How cheaply a product can be made","How a product looks in a photograph","How a product is advertised","How well products and spaces fit the people who use them"]$mq$, 3, $mq$Ergonomics is the study of the fit between people and the things they use, covering comfort, safety and efficiency.$mq$, $mq$easy$mq$),
($mq$A chair has a seat that is too high for a short user, so their feet dangle. Which area of design has been ignored?$mq$, $mq$["Recycling","Branding","Ergonomics","Batch production"]$mq$, 2, $mq$The seat height does not match the user's body, which is an ergonomic failure.$mq$, $mq$easy$mq$),
($mq$The 50th percentile of a measurement, such as height, is best described as which of these?$mq$, $mq$["The smallest value in the group","The middle value, with half the group smaller","The largest value in the group","The value everybody has"]$mq$, 1, $mq$At the 50th percentile half the group is smaller and half is larger, so it is close to the average.$mq$, $mq$easy$mq$),
($mq$Which of these is an anthropometric measurement?$mq$, $mq$["Elbow-to-fingertip length","Melting point of a plastic","Price of a tool","Thickness of a drawing line"]$mq$, 0, $mq$Elbow-to-fingertip length is a measurement of the human body, so it is anthropometric data.$mq$, $mq$easy$mq$),
($mq$A doorway is designed so that 95% of adults can walk through without ducking. Which data was the designer most likely to use?$mq$, $mq$["The 5th percentile standing height","The 5th percentile arm length","The average shoe size","The 95th percentile standing height"]$mq$, 3, $mq$Clearances such as doorways are designed for the largest users, so the 95th percentile (or higher) is used. Taller people then fit too.$mq$, $mq$medium$mq$),
($mq$A shelf in a school library should be reachable by almost every student. Which percentile of reach should the designer use for the highest shelf?$mq$, $mq$["The 95th percentile, because tall students can reach it","The 50th percentile only","The 5th percentile, because a short reach is the limiting case","The 100th percentile of height"]$mq$, 2, $mq$Reach is designed for the smallest users (5th percentile). If the shortest students can reach it, everyone else can too.$mq$, $mq$medium$mq$),
($mq$A designer wants one product to fit a wide range of users, such as an office chair with a seat height lever. What approach is this?$mq$, $mq$["Designing for the average only","Designing for adjustability","Designing for extremes only","Designing for disposal"]$mq$, 1, $mq$Adjustable features let each user set the product to fit, covering a wider range than a fixed size can.$mq$, $mq$medium$mq$),
($mq$A class of 200 students is measured. How many students are expected to be shorter than the 5th percentile height?$mq$, $mq$["About 10 students","About 5 students","About 95 students","About 190 students"]$mq$, 0, $mq$5% of 200 is 10, so roughly 10 students fall below the 5th percentile.$mq$, $mq$medium$mq$),
($mq$A student measures the hand span of 10 classmates in mm: 170, 180, 175, 165, 190, 185, 172, 178, 168, 187. The mean is 177 mm. A designer picks 177 mm for the span of a game controller. What is the main limitation?$mq$, $mq$["The mean can never be used in design","Hand span is not a body measurement","Ten measurements are always enough","Many users will be larger or smaller than the mean and may find it uncomfortable"]$mq$, 3, $mq$Designing only for the mean leaves out those at the extremes. Using a range or percentiles, and a larger sample, gives a better fit.$mq$, $mq$medium$mq$),
($mq$Which is the best example of dynamic (functional) anthropometric data?$mq$, $mq$["Their standing height","Their shoulder width","How far a person can reach while seated and twisting","Their foot length"]$mq$, 2, $mq$Dynamic data measures the body in movement or doing a task. Standing height, width and length are static (structural) data.$mq$, $mq$medium$mq$),
($mq$A designer collects data from 30 adult men to design a backpack for a whole school aged 11 to 18. What is the most serious problem?$mq$, $mq$["The sample is too tall","The sample does not represent the target user group","The backpack must be heavy","Data should never come from people"]$mq$, 1, $mq$Data must match the target users in age and gender. Adult men do not represent students aged 11 to 18, so the fit would be poor.$mq$, $mq$medium$mq$),
($mq$Which is the best way to test the ergonomics of a prototype kitchen knife handle?$mq$, $mq$["Ask users from the target group to use it and give feedback on comfort and grip","Ask the designer to look at it carefully","Weigh the prototype","Compare the price with other knives"]$mq$, 0, $mq$Ergonomics is about people, so testing with real users from the target group gives the most useful evidence.$mq$, $mq$medium$mq$),
($mq$A kettle handle is designed for the 5th percentile hand size only. Who is most likely to be affected badly?$mq$, $mq$["Users with small hands","Nobody, since small is safe","Only left-handed users","Users with large hands, who may not fit their fingers through"]$mq$, 3, $mq$A design for the smallest hand can be too tight for larger hands. Handles usually need a clearance suited to larger users.$mq$, $mq$hard$mq$),
($mq$An adjustable desk can be set from 65 cm to 85 cm. The 5th percentile elbow height is 62 cm when seated on a 40 cm chair, and the 95th percentile is 78 cm. The designer concludes the range suits the target group. Which statement best evaluates this?$mq$, $mq$["The range is perfect because 85 cm is the biggest number","The range fails because 78 cm is below 85 cm","The top of the range covers the 95th percentile but the bottom (65 cm) is above the 5th percentile, so the smallest users are not catered for","The range is correct because adjustable desks suit everyone"]$mq$, 2, $mq$The lowest setting should reach at or below the 5th percentile value (62 cm). Here the desk's minimum of 65 cm is too high for the smallest users.$mq$, $mq$hard$mq$),
($mq$A designer says the best seat depth is the 95th percentile buttock-to-knee length, so that everyone's thighs are fully supported. Why is this a poor decision?$mq$, $mq$["Tall users will sit on the floor","Short users cannot reach the backrest and the seat edge presses behind their knees","It makes the chair cheaper","Seat depth does not matter"]$mq$, 1, $mq$Seat depth should suit the small user (5th percentile), since a deep seat leaves short users without back support. Taller users can still sit comfortably.$mq$, $mq$hard$mq$),
($mq$A company wants a hand-held device for both children aged 8 and adults. Which design response best balances ergonomic needs?$mq$, $mq$["Use data for each group, then offer sizes or adjustable parts to suit both","Use adult data and hope children manage","Use the average of all measurements and ignore range","Choose the shape that looks best only"]$mq$, 0, $mq$Different user groups need different data. Providing sizes or adjustability serves both, whereas a single average rarely fits either group well.$mq$, $mq$hard$mq$),
($mq$An evaluation says: 'Testing with 8 users showed grip discomfort for 6, so the handle diameter should be reduced from 38 mm to about 32 mm.' Which feature makes this a strong evaluation statement?$mq$, $mq$["It uses a long sentence","It mentions the price","It only describes what the product looks like","It uses user evidence and gives a specific, measurable improvement"]$mq$, 3, $mq$Strong evaluation links test results to a specific improvement. This is the kind of reasoning rewarded in Criterion D.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Ergonomics and Anthropometrics$mq$ and p.name = $mq$Designing for People$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Ergonomics$mq$, $mq$The study of how well products and spaces fit people, covering comfort, safety and efficiency.$mq$),
($mq$Anthropometrics$mq$, $mq$The measurement of the human body (height, reach, hand size) used to size products.$mq$),
($mq$Percentile$mq$, $mq$A value showing the share of a group at or below a measurement; the 95th percentile has 95% of people equal or smaller.$mq$),
($mq$5th to 95th percentile range$mq$, $mq$The range commonly designed for; it covers about 90% of users.$mq$),
($mq$When to use the 95th percentile$mq$, $mq$For clearances: doorways, seat width, handle openings, gaps under tables.$mq$),
($mq$When to use the 5th percentile$mq$, $mq$For reach: shelf height, distance to controls, so the smallest user can still manage.$mq$),
($mq$Static vs dynamic data$mq$, $mq$Static data is measured with the body still (height). Dynamic data is measured during movement (reach while twisting).$mq$),
($mq$Designing for adjustability$mq$, $mq$Giving a product adjustable parts, such as a chair lever, so it can fit a wide range of users.$mq$),
($mq$Why not design only for the average?$mq$, $mq$Many users are larger or smaller than the mean and would find the product uncomfortable or unsafe.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Ergonomics and Anthropometrics$mq$ and p.name = $mq$Designing for People$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Ergonomics is the study of how well products, tools and spaces fit the people who use them. A well-designed product feels comfortable, is safe, and lets the user work efficiently without strain. Anthropometrics is the part of that study which deals with measurements of the human body, such as height, arm length, hand width and grip size. Together they help a designer answer a vital question: will this product suit the people it is made for?

## Why it matters
Poor ergonomics causes real problems: sore backs from badly designed chairs, wrist strain from awkward tools, or accidents from controls that are out of reach. Good ergonomics improves comfort, safety, performance and customer satisfaction. In MYP Design it supports Criterion A (research into user needs), Criterion B (specifications) and Criterion D (testing).

## Types of data
- **Static (structural) data** is measured with the body still, for example standing height or hand length.
- **Dynamic (functional) data** is measured while the body moves or works, for example reach while twisting.
- **Physiological factors** include comfort, fatigue and strength. **Psychological factors** include how easy a product is to understand and how it makes the user feel.

## Percentiles
A **percentile** shows where a measurement sits within a group. If a person is on the 95th percentile for height, then 95% of the group is the same height or shorter. The 5th percentile is a small value (only 5% are smaller) and the 50th percentile is the middle of the group. Designers often cover the range from the 5th to the 95th percentile, which includes about 90% of users.

## Which percentile should I use?
- **Design for the largest (95th percentile)** when the product must provide clearance: doorways, seat width, handle openings, the gap under a table.
- **Design for the smallest (5th percentile)** when the user must reach something: shelf height, distance to a control, height of a step.
- **Design for the average (50th percentile)** when a fixed middle value is acceptable and extremes are not safety-critical.
- **Design for adjustability** when a range is needed: office chairs, bicycle saddles, car seats.

## Worked example
A designer is making a classroom stool for 12 to 14 year olds. Seat height is based on the popliteal height (floor to the back of the knee while seated). If the 5th percentile is 36 cm and the 95th is 46 cm, a fixed stool of 41 cm would fit the average student but be too high for some and too low for others. An adjustable stool from 36 to 46 cm would cover about 90% of the group.

## Collecting good data
Data must come from the right people: age, gender and background should match the target user. A larger sample gives more reliable results. Always state units (mm or cm) and say where the information came from. Testing a model or prototype with real users is the best check of ergonomics.

## Common mistakes
- Designing only for the average and forgetting the extremes.
- Using adult data for children.
- Using the 95th percentile for reach, when the smallest user should limit the distance.
- Saying a product is 'ergonomic' without evidence.

## How this is examined
Questions usually give a short scenario, such as a school bag or a hand tool, with a few measurements. You may be asked to choose which percentile to use, explain how the data affects a dimension, or judge test results and suggest a specific improvement. Command terms like justify and evaluate expect you to link data to a decision.

Exam tip: Always say which user (largest or smallest) limits the dimension, and back your choice with a number from the data.$mq$ from st;

-- Designing for People > Sustainable Design
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Designing for People$mq$, 5, 3 from public.subjects s where s.slug = $mq$product-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Sustainable Design$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$product-design$mq$ and p.grade = 5 and p.name = $mq$Designing for People$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Sustainable Design$mq$ and p.name = $mq$Designing for People$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does sustainable design aim to do?$mq$, $mq$["Meet people's needs without harming the environment or future generations","Make products as cheaply as possible","Make products that wear out quickly","Use only new raw materials"]$mq$, 0, $mq$Sustainability means meeting present needs while protecting resources and the environment for the future.$mq$, $mq$easy$mq$),
($mq$Which of these is a renewable resource?$mq$, $mq$["Crude oil","Coal","Natural gas","Timber from a managed forest"]$mq$, 3, $mq$Managed forests can be replanted so timber can be replaced. Oil, coal and gas are finite fossil fuels.$mq$, $mq$easy$mq$),
($mq$Which of the 6Rs means using a product again for the same or a new purpose?$mq$, $mq$["Refuse","Rethink","Reuse","Reduce"]$mq$, 2, $mq$Reuse keeps a product in use without reprocessing it, for example refilling a bottle.$mq$, $mq$easy$mq$),
($mq$Which word describes a material that can break down naturally by bacteria or fungi?$mq$, $mq$["Thermosetting","Biodegradable","Finite","Ductile"]$mq$, 1, $mq$Biodegradable materials are broken down by living organisms and return to the environment.$mq$, $mq$easy$mq$),
($mq$Recycling a product means what?$mq$, $mq$["Processing its material so it can be made into new products","Throwing it into landfill","Repairing it for the same owner","Refusing to buy it"]$mq$, 0, $mq$Recycling breaks down used materials to make new items, which saves raw materials and energy.$mq$, $mq$easy$mq$),
($mq$A life cycle assessment (LCA) of a mobile phone looks at which stages?$mq$, $mq$["Only the design drawings","Only the advertising campaign","Only the cost of the screen","Raw material extraction, manufacture, distribution, use and disposal"]$mq$, 3, $mq$An LCA follows the whole life of a product, so impacts at every stage can be compared.$mq$, $mq$medium$mq$),
($mq$A company makes a kettle that is designed to stop working after two years so customers buy again. What is this practice called?$mq$, $mq$["Design for disassembly","Closed-loop recycling","Planned obsolescence","Fair trade"]$mq$, 2, $mq$Planned obsolescence deliberately limits product life, which creates extra waste and uses more resources.$mq$, $mq$medium$mq$),
($mq$Which design decision best supports repair and recycling?$mq$, $mq$["Gluing all parts permanently together","Using screws and clips so parts can be separated","Mixing many plastics in one component","Hiding fixings under permanent labels"]$mq$, 1, $mq$Design for disassembly lets parts be replaced and materials be sorted for recycling.$mq$, $mq$medium$mq$),
($mq$The linear economy is often described as 'take, make, dispose'. How does a circular economy differ?$mq$, $mq$["Materials are kept in use through reuse, repair and recycling","Products are made faster","Products are sold at a higher price","Waste is moved to other countries"]$mq$, 0, $mq$A circular economy aims to keep products and materials in use for as long as possible and reduce waste.$mq$, $mq$medium$mq$),
($mq$A designer chooses a local timber instead of one shipped 12 000 km. Which environmental benefit is most directly gained?$mq$, $mq$["Lower density","Higher melting point","Improved colour","Lower transport emissions"]$mq$, 3, $mq$Shorter transport distances use less fuel and release less carbon dioxide.$mq$, $mq$medium$mq$),
($mq$Which choice best reduces the environmental impact of packaging for a small gift?$mq$, $mq$["Use a large plastic box with foam inside","Use several layers of different plastic films","Use a thin card box made from recycled card that can be recycled again","Use a sealed metal tin only used once"]$mq$, 2, $mq$Using less material, recycled content and a recyclable material reduces impact across the life cycle.$mq$, $mq$medium$mq$),
($mq$Embodied energy refers to which of the following?$mq$, $mq$["The energy the user feels when using it","The total energy used to produce and transport a product","The energy stored in a battery","The energy needed to recycle only"]$mq$, 1, $mq$Embodied energy counts all the energy used to extract, process, make and deliver a product.$mq$, $mq$medium$mq$),
($mq$The 'triple bottom line' of sustainability includes which three areas?$mq$, $mq$["Environment, society and economy","Cost, colour and size","Plastic, metal and wood","Design, make and sell"]$mq$, 0, $mq$A sustainable design should be environmentally friendly, socially fair and economically viable.$mq$, $mq$medium$mq$),
($mq$A bamboo toothbrush has a biodegradable handle but is sent in plastic wrap and shipped by air from overseas. Which statement is the best evaluation?$mq$, $mq$["It is completely sustainable because the handle is bamboo","It is unsustainable because bamboo is a grass","It cannot be assessed without a price","The handle is sustainable but packaging and transport reduce the overall benefit"]$mq$, 3, $mq$Evaluating sustainability means looking at the whole life cycle, not a single feature.$mq$, $mq$hard$mq$),
($mq$A plastic water bottle weighs 24 g and is used once. A steel bottle weighs 300 g, needs far more energy to make, but can be used for years. What is the best way to compare them?$mq$, $mq$["Compare only the weights","Compare only the colours","Compare the impact per use over the expected life of each bottle","Choose whichever is lighter"]$mq$, 2, $mq$The steel bottle has a higher upfront impact, but spread across hundreds of uses it can be lower per use. A life cycle approach captures this.$mq$, $mq$hard$mq$),
($mq$A designer claims a product is 'eco-friendly' because it is 100% recyclable. Which point best challenges this claim?$mq$, $mq$["Recyclable products are always bad","It may be recycled rarely in practice and may use a lot of energy to make","Recycling only works for glass","Eco-friendly products are always cheaper"]$mq$, 1, $mq$Recyclable does not mean recycled. A claim must be supported by evidence across production, use and disposal.$mq$, $mq$hard$mq$),
($mq$A school wants a sustainable bench. Option X: recycled plastic lumber, lasts 30 years, no painting needed. Option Y: untreated softwood, lasts 8 years, repainted every 2 years. Which justification is strongest for X?$mq$, $mq$["It lasts longer and avoids repeated paint and replacements, lowering impact over its life","It is plastic, and plastic is natural","It is cheaper in every case","It needs no material at all"]$mq$, 0, $mq$The justification links durability and maintenance to total life cycle impact, rather than just the material type.$mq$, $mq$hard$mq$),
($mq$Which statement shows the rethink strategy of the 6Rs?$mq$, $mq$["Throwing a product into the correct bin","Refilling a pen","Declining a free plastic bag","Questioning whether a product is needed or can serve several functions"]$mq$, 3, $mq$Rethink means challenging the design itself, for example a tool that combines functions so fewer products are needed.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Sustainable Design$mq$ and p.name = $mq$Designing for People$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Sustainable design$mq$, $mq$Designing to meet present needs without harming the environment or the ability of future generations to meet theirs.$mq$),
($mq$Finite resource$mq$, $mq$A resource that cannot be replaced in a human lifetime, such as oil, coal and metal ores.$mq$),
($mq$Renewable resource$mq$, $mq$A resource that can be regrown or replaced if managed well, such as timber from managed forests.$mq$),
($mq$Life cycle assessment (LCA)$mq$, $mq$Evaluating a product's impact at each stage: extraction, manufacture, distribution, use and disposal.$mq$),
($mq$The 6Rs$mq$, $mq$Reduce, reuse, recycle, repair, refuse and rethink.$mq$),
($mq$Planned obsolescence$mq$, $mq$Designing a product to fail or become outdated early so people buy replacements, creating extra waste.$mq$),
($mq$Circular economy$mq$, $mq$A system that keeps materials in use through reuse, repair and recycling, instead of take, make, dispose.$mq$),
($mq$Design for disassembly$mq$, $mq$Making products easy to take apart with screws or clips so parts can be repaired and materials recycled.$mq$),
($mq$Triple bottom line$mq$, $mq$Considering the environment, society and the economy together when judging sustainability.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$product-design$mq$ and t.grade = 5 and t.name = $mq$Sustainable Design$mq$ and p.name = $mq$Designing for People$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Sustainable design means creating products that meet people's needs today without damaging the environment or reducing the ability of future generations to meet theirs. Every product uses materials and energy, and eventually becomes waste, so a designer who thinks about sustainability tries to reduce harm at every stage. This is important in MYP Design because Criterion A asks you to research the impact of existing products, and Criterion D asks you to explain the impact of your own solution on the client or target audience, including wider effects such as those on the environment.

## Finite and renewable resources
**Finite** resources, such as crude oil, coal, natural gas and metal ores, cannot be replaced within a human lifetime. **Renewable** resources, such as timber from managed forests, cotton and bamboo, can be regrown. Even renewable resources must be managed carefully. Cutting down a forest faster than it regrows is not sustainable.

## Life cycle assessment
A **life cycle assessment (LCA)** looks at the impact of a product at each stage of its life:
- **Extraction** of raw materials (mining, drilling, harvesting)
- **Manufacture** (energy use, waste, pollution)
- **Distribution** (packaging and transport emissions)
- **Use** (energy, water, maintenance)
- **Disposal** (landfill, incineration, reuse or recycling)

The stage with the biggest impact is different for different products. A washing machine uses most of its energy during use, whereas a plastic spoon causes most of its impact at manufacture and disposal.

## The 6Rs
- **Reduce**: use less material or energy
- **Reuse**: use the product again
- **Recycle**: turn old material into new products
- **Repair**: fix a product instead of replacing it
- **Refuse**: decline products that are wasteful or harmful
- **Rethink**: question whether the product is needed or can be designed differently

## Linear and circular thinking
A **linear economy** takes raw materials, makes products and throws them away. A **circular economy** keeps materials in use through repair, reuse and recycling. Design for disassembly, using screws and clips rather than permanent glue, makes this possible. Using a single material or clearly labelled materials helps recyclers to sort them.

## Planned obsolescence
Some products are designed to fail or to go out of fashion quickly, which makes consumers buy replacements. This is called **planned obsolescence** and it increases waste. Sustainable designers aim for durability, repairability and timeless style.

## Three parts of sustainability
The **triple bottom line** considers the environment, society (fair pay, safe working conditions, fair trade) and the economy (the product must still be affordable and viable).

## Worked example
Compare a paper bag with a cotton tote bag. The paper bag uses less energy to make but is used once or twice. The cotton bag uses more water and energy to grow and weave, but can be used hundreds of times. A good judgement compares impact per use: the tote bag only wins if it is used many times.

## Common mistakes
- Saying 'biodegradable' means harmless. Some materials only break down in industrial composters.
- Assuming 'recyclable' means 'recycled'.
- Judging a product by one feature (such as the handle material) and ignoring transport, packaging and lifespan.

## How this is examined
Questions often present two products with a few facts about materials, weight and lifespan and ask you to compare or justify which is more sustainable. Strong answers refer to stages of the life cycle and give a reason, not just an opinion.

Exam tip: When asked to evaluate sustainability, name at least two life cycle stages and compare them, rather than only describing the material.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('product-design')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;