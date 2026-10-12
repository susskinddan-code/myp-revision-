-- Part 3 of 12: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Forces and Motion > Speed, Velocity and Acceleration
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Forces and Motion$mq$, 5, 3 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Speed, Velocity and Acceleration$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Forces and Motion$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Speed, Velocity and Acceleration$mq$ and p.name = $mq$Forces and Motion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which equation gives average speed?$mq$, $mq$["Speed = distance ÷ time","Speed = time ÷ distance","Speed = distance × time","Speed = mass ÷ time"]$mq$, 0, $mq$Speed is how far something travels per unit of time.$mq$, $mq$easy$mq$),
($mq$What is the difference between speed and velocity?$mq$, $mq$["Velocity is always faster","Speed has a direction","They are exactly the same","Velocity has a direction as well as a size"]$mq$, 3, $mq$Velocity is a vector quantity. Speed is a scalar.$mq$, $mq$easy$mq$),
($mq$What is the SI unit of acceleration?$mq$, $mq$["m/s","N","m/s²","J"]$mq$, 2, $mq$Acceleration is the change in velocity per second, so metres per second per second.$mq$, $mq$easy$mq$),
($mq$What does a horizontal line on a distance-time graph show?$mq$, $mq$["The object is moving at constant speed","The object is stationary","The object is accelerating","The object is moving backwards"]$mq$, 1, $mq$Distance is not changing as time passes, so the object is at rest.$mq$, $mq$easy$mq$),
($mq$A car travels at a constant 20 m/s for 5 s. How far does it travel?$mq$, $mq$["100 m","4 m","25 m","10 m"]$mq$, 0, $mq$Distance = speed × time = 20 × 5 = 100 m.$mq$, $mq$easy$mq$),
($mq$A runner completes 400 m in 50 s. What is the average speed?$mq$, $mq$["0.125 m/s","20 000 m/s","450 m/s","8 m/s"]$mq$, 3, $mq$Speed = 400 ÷ 50 = 8 m/s.$mq$, $mq$medium$mq$),
($mq$A cyclist speeds up from rest to 12 m/s in 4 s. What is the acceleration?$mq$, $mq$["48 m/s²","0.33 m/s²","3 m/s²","8 m/s²"]$mq$, 2, $mq$Acceleration = change in velocity ÷ time = 12 ÷ 4 = 3 m/s².$mq$, $mq$medium$mq$),
($mq$On a velocity-time graph, what does the gradient (slope) represent?$mq$, $mq$["Distance travelled","Acceleration","Speed","Force"]$mq$, 1, $mq$Gradient = change in velocity ÷ time, which is acceleration.$mq$, $mq$medium$mq$),
($mq$An object travels at a steady 10 m/s for 6 s. What does the area under its velocity-time graph show?$mq$, $mq$["60 m, the distance travelled","60 m/s, the acceleration","1.7 m, the displacement","16 m/s, the speed"]$mq$, 0, $mq$Area under a velocity-time graph is distance: 10 × 6 = 60 m.$mq$, $mq$medium$mq$),
($mq$A car slows from 20 m/s to 8 m/s in 3 s. What is its acceleration?$mq$, $mq$["+4 m/s²","−12 m/s²","−36 m/s²","−4 m/s²"]$mq$, 3, $mq$(8 − 20) ÷ 3 = −4 m/s². The negative sign shows deceleration.$mq$, $mq$medium$mq$),
($mq$Which conversion is correct?$mq$, $mq$["72 km/h = 72 m/s","72 km/h = 259 m/s","72 km/h = 20 m/s","72 km/h = 7.2 m/s"]$mq$, 2, $mq$72 000 m ÷ 3600 s = 20 m/s.$mq$, $mq$medium$mq$),
($mq$A satellite moves in a circle at constant speed. Why is it accelerating?$mq$, $mq$["Its speed is changing","Its direction, and so its velocity, keeps changing","It has no forces on it","It is stationary"]$mq$, 1, $mq$Acceleration is a change in velocity, which can be a change in direction as well as speed.$mq$, $mq$medium$mq$),
($mq$On a distance-time graph, which line represents the faster object?$mq$, $mq$["The line with the steeper gradient","The line that is lower","The line that is shorter","The line that starts later"]$mq$, 0, $mq$Gradient = distance ÷ time = speed.$mq$, $mq$medium$mq$),
($mq$A velocity-time graph goes from 0 to 8 m/s in 4 s, stays at 8 m/s for 6 s, then falls to 0 in 2 s. What total distance is travelled?$mq$, $mq$["96 m","48 m","12 m","72 m"]$mq$, 3, $mq$Areas: 0.5 × 4 × 8 = 16 m, 6 × 8 = 48 m, 0.5 × 2 × 8 = 8 m. Total 72 m.$mq$, $mq$hard$mq$),
($mq$A van travels 60 km from A to B at 30 km/h, then returns at 60 km/h. What is its average speed for the whole trip?$mq$, $mq$["45 km/h","30 km/h","40 km/h","90 km/h"]$mq$, 2, $mq$Total distance 120 km, total time 2 h + 1 h = 3 h. 120 ÷ 3 = 40 km/h, not the mean of the speeds.$mq$, $mq$hard$mq$),
($mq$A trolley's velocity is 2, 5, 8 and 11 m/s at 0, 1, 2 and 3 s. Assuming the pattern continues, what is its velocity at 6 s?$mq$, $mq$["18 m/s","20 m/s","17 m/s","14 m/s"]$mq$, 1, $mq$Acceleration = 3 m/s². v = 2 + 3 × 6 = 20 m/s.$mq$, $mq$hard$mq$),
($mq$Students time a trolley over 1.20 m with a stopwatch and then with light gates. Why are the light-gate results more accurate?$mq$, $mq$["They remove the human reaction-time error in starting and stopping the timer","They make the trolley go faster","They measure the mass of the trolley","They remove the need to repeat the experiment"]$mq$, 0, $mq$Reaction time can be 0.2 s or more, which is large compared with short times.$mq$, $mq$hard$mq$),
($mq$A driver has a reaction time of 0.7 s. How far does the car travel during the reaction time at 25 m/s?$mq$, $mq$["0.028 m","35.7 m","25.7 m","17.5 m"]$mq$, 3, $mq$Thinking distance = speed × reaction time = 25 × 0.7 = 17.5 m. Doubling speed doubles this distance.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Speed, Velocity and Acceleration$mq$ and p.name = $mq$Forces and Motion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Speed formula$mq$, $mq$Speed = distance ÷ time (m/s).$mq$),
($mq$Velocity$mq$, $mq$Speed in a given direction; it is a vector. A change of direction is a change in velocity.$mq$),
($mq$Acceleration formula$mq$, $mq$Acceleration = change in velocity ÷ time (m/s²).$mq$),
($mq$Gradient of a distance-time graph$mq$, $mq$Gives the speed. A horizontal line means stationary.$mq$),
($mq$Gradient and area of a velocity-time graph$mq$, $mq$Gradient = acceleration. Area under the graph = distance travelled.$mq$),
($mq$Average speed$mq$, $mq$Total distance ÷ total time, not the average of two speeds.$mq$),
($mq$Convert km/h to m/s$mq$, $mq$Divide by 3.6; e.g. 72 km/h = 20 m/s.$mq$),
($mq$Stopping distance$mq$, $mq$Thinking distance + braking distance. Thinking distance = speed × reaction time.$mq$),
($mq$Why use light gates instead of a stopwatch?$mq$, $mq$They remove human reaction-time error and give more accurate times.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Speed, Velocity and Acceleration$mq$ and p.name = $mq$Forces and Motion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Describing motion
To describe motion we measure distance, time and direction. **Speed** is how fast something moves: speed = distance ÷ time. **Velocity** is speed in a given direction, so it is a vector. Two cars moving at 20 m/s in opposite directions have the same speed but different velocities. **Acceleration** is the rate of change of velocity: acceleration = change in velocity ÷ time, in m/s². Slowing down is negative acceleration, or deceleration.

Worked example: a cyclist goes from rest to 12 m/s in 4 s. Acceleration = (12 − 0) ÷ 4 = 3 m/s².

## Average speed
Average speed = total distance ÷ total time. It is not the mean of two speeds. If a van travels 60 km at 30 km/h (2 h) and returns at 60 km/h (1 h), the total distance is 120 km and total time 3 h, so the average speed is 40 km/h, not 45 km/h.

Unit conversion: to change km/h into m/s divide by 3.6. So 72 km/h is 20 m/s.

## Graphs of motion
**Distance-time graphs**: the gradient gives speed. A horizontal line means stationary. A straight sloping line means constant speed. A steeper line means faster. A curve upwards means accelerating.

**Velocity-time graphs**: the gradient gives acceleration. A horizontal line is constant velocity. The area under the line is the distance travelled. For a graph that rises from 0 to 8 m/s in 4 s, stays at 8 m/s for 6 s and falls to 0 in 2 s, the distance is 16 + 48 + 8 = 72 m (triangle, rectangle, triangle).

## Stopping distances
Stopping distance = thinking distance + braking distance. Thinking distance = speed × reaction time. At 25 m/s with a 0.7 s reaction time, the thinking distance is 17.5 m. Speed, tiredness, alcohol or phone use increase the thinking distance. Wet roads and worn tyres increase the braking distance.

## Measuring motion
A stopwatch involves human reaction time, which causes error, especially over short times. Light gates and data loggers measure time more accurately. Repeating readings and calculating a mean improves reliability. To find acceleration, measure the change in velocity between two points and the time between them.

## Common mistakes
- Confusing the gradient of a distance-time graph (speed) with that of a velocity-time graph (acceleration).
- Forgetting that a change in direction is a change in velocity.
- Averaging two speeds instead of dividing total distance by total time.
- Using minutes or km with seconds and metres without converting.

## How this is examined
Science criteria B and C may give a table of trolley times or a velocity-time graph from a road-safety context. You find speeds and accelerations, identify the pattern, predict values, and evaluate how reliable the data collection was, including the effect of reaction time.

Exam tip: Write the equation, substitute with units, and give the answer with the correct unit. For graphs, say whether you are using the gradient or the area.$mq$ from st;

-- Forces and Motion > Forces, Newton's Laws and Pressure
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Forces and Motion$mq$, 5, 3 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Forces, Newton's Laws and Pressure$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Forces and Motion$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Forces, Newton's Laws and Pressure$mq$ and p.name = $mq$Forces and Motion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the SI unit of force?$mq$, $mq$["Newton (N)","Joule (J)","Watt (W)","Pascal (Pa)"]$mq$, 0, $mq$Force is measured in newtons. Joules measure energy, watts power, pascals pressure.$mq$, $mq$easy$mq$),
($mq$Taking g = 10 N/kg, what is the weight of a 5 kg object?$mq$, $mq$["5 N","0.5 N","15 N","50 N"]$mq$, 3, $mq$Weight = mass × g = 5 × 10 = 50 N.$mq$, $mq$easy$mq$),
($mq$Newton's first law says that an object stays at rest or moves at constant velocity unless what happens?$mq$, $mq$["Its mass changes","It is heated","A resultant force acts on it","It touches the ground"]$mq$, 2, $mq$If the forces are balanced, the motion does not change.$mq$, $mq$easy$mq$),
($mq$Which statement about friction is correct?$mq$, $mq$["It always speeds objects up","It opposes motion between surfaces","It only acts in liquids","It acts in the same direction as motion"]$mq$, 1, $mq$Friction acts against the direction of sliding or intended sliding.$mq$, $mq$easy$mq$),
($mq$Which equation defines pressure?$mq$, $mq$["Pressure = force ÷ area","Pressure = force × area","Pressure = area ÷ force","Pressure = mass ÷ volume"]$mq$, 0, $mq$Pressure is force per unit area, in pascals (N/m²).$mq$, $mq$easy$mq$),
($mq$A 1200 kg car is pushed with a resultant force of 3000 N. What is its acceleration?$mq$, $mq$["0.4 m/s²","36 000 m/s²","4200 m/s²","2.5 m/s²"]$mq$, 3, $mq$a = F ÷ m = 3000 ÷ 1200 = 2.5 m/s².$mq$, $mq$medium$mq$),
($mq$A box is pushed right with 50 N and left with 30 N. What is the resultant force?$mq$, $mq$["80 N to the right","20 N to the left","20 N to the right","1500 N"]$mq$, 2, $mq$Forces in opposite directions are subtracted: 50 − 30 = 20 N to the right.$mq$, $mq$medium$mq$),
($mq$A skydiver reaches terminal velocity. Which statement is correct?$mq$, $mq$["Air resistance is greater than weight","Air resistance equals weight and the resultant force is zero","Weight is zero","The skydiver has stopped moving"]$mq$, 1, $mq$Balanced forces mean constant velocity, so no further acceleration.$mq$, $mq$medium$mq$),
($mq$A person of weight 600 N stands on feet with a total area of 0.04 m². What pressure do they exert?$mq$, $mq$["15 000 Pa","24 N","600 Pa","0.00007 Pa"]$mq$, 0, $mq$Pressure = force ÷ area = 600 ÷ 0.04 = 15 000 Pa.$mq$, $mq$medium$mq$),
($mq$A rocket pushes hot gas backwards and the gas pushes the rocket forwards. Which law is this?$mq$, $mq$["Newton's first law","Newton's second law","The law of conservation of mass","Newton's third law"]$mq$, 3, $mq$Forces come in equal and opposite pairs acting on different objects.$mq$, $mq$medium$mq$),
($mq$An astronaut has a mass of 80 kg. On the Moon g = 1.6 N/kg. What is the astronaut's weight there?$mq$, $mq$["800 N","80 N","128 N","50 N"]$mq$, 2, $mq$Weight = 80 × 1.6 = 128 N. The mass is still 80 kg.$mq$, $mq$medium$mq$),
($mq$Why is wearing a seat belt important in terms of Newton's first law?$mq$, $mq$["The belt increases the car's mass","The passenger tends to keep moving forwards when the car stops suddenly","The belt reduces the friction","The belt makes the car stop faster"]$mq$, 1, $mq$Without a force, the passenger keeps moving at the car's original velocity.$mq$, $mq$medium$mq$),
($mq$Why do snowshoes stop a person sinking into snow?$mq$, $mq$["They spread the weight over a larger area, reducing pressure","They increase the force on the snow","They reduce the person's mass","They make the snow warmer"]$mq$, 0, $mq$The same force over a bigger area gives a smaller pressure.$mq$, $mq$medium$mq$),
($mq$A skydiver of mass 80 kg has weight 800 N and air resistance of 500 N. What is the acceleration downward?$mq$, $mq$["6.25 m/s²","10 m/s²","0.5 m/s²","3.75 m/s²"]$mq$, 3, $mq$Resultant force = 800 − 500 = 300 N. a = 300 ÷ 80 = 3.75 m/s².$mq$, $mq$hard$mq$),
($mq$A 1000 kg car travels at a constant 25 m/s on flat ground with an engine force of 600 N. What is the resistive force?$mq$, $mq$["0 N","25 000 N","600 N","Greater than 600 N"]$mq$, 2, $mq$Constant velocity means the resultant force is zero, so the resistive forces balance the engine force.$mq$, $mq$hard$mq$),
($mq$A trolley is pulled by forces of 1, 2, 3 and 4 N and the accelerations are 0.5, 1.0, 1.5 and 2.0 m/s². What conclusions are supported?$mq$, $mq$["Acceleration is inversely proportional to force and the mass is 0.5 kg","Acceleration is directly proportional to force and the mass is 2 kg","Acceleration is unaffected by force and the mass is 1 kg","Acceleration is proportional to force squared and the mass is 4 kg"]$mq$, 1, $mq$The ratio F ÷ a is 2 kg each time, so the mass is constant at 2 kg and acceleration doubles when force doubles.$mq$, $mq$hard$mq$),
($mq$A horse pulls a cart and the cart pulls back on the horse with an equal and opposite force. Why can they still accelerate forward?$mq$, $mq$["The ground pushes the horse forward with more force than the resistive forces on the system","Newton's third law does not apply to horses","The forces cancel but the cart moves anyway","The cart has no mass"]$mq$, 0, $mq$Third-law pairs act on different objects. The resultant force on the horse-cart system comes from the ground friction on the horse's hooves.$mq$, $mq$hard$mq$),
($mq$Water pressure at a depth h is given by pressure = density × g × h. For water (1000 kg/m³, g = 10 N/kg) at a depth of 10 m, what is the pressure due to the water?$mq$, $mq$["1000 Pa","10 000 Pa","1 000 000 Pa","100 000 Pa"]$mq$, 3, $mq$1000 × 10 × 10 = 100 000 Pa. This is in addition to atmospheric pressure. Pressure increases with depth.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Forces, Newton's Laws and Pressure$mq$ and p.name = $mq$Forces and Motion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Newton's first law$mq$, $mq$An object stays at rest or moves at constant velocity unless a resultant force acts on it.$mq$),
($mq$Newton's second law$mq$, $mq$Resultant force = mass × acceleration (F = ma).$mq$),
($mq$Newton's third law$mq$, $mq$If A exerts a force on B, B exerts an equal and opposite force on A. The forces act on different objects.$mq$),
($mq$Weight formula$mq$, $mq$Weight = mass × gravitational field strength (W = mg). About 10 N/kg on Earth, 1.6 N/kg on the Moon.$mq$),
($mq$Mass vs weight$mq$, $mq$Mass is the amount of matter in kg and does not change. Weight is a force in N that depends on gravity.$mq$),
($mq$Resultant force$mq$, $mq$The single force with the same effect as all forces on an object. Subtract opposite forces, add forces in the same direction.$mq$),
($mq$Terminal velocity$mq$, $mq$Reached when air resistance equals weight, so the resultant force is zero and velocity is constant.$mq$),
($mq$Pressure formula$mq$, $mq$Pressure = force ÷ area (Pa = N/m²). A smaller area gives a greater pressure.$mq$),
($mq$Pressure in a liquid$mq$, $mq$Pressure = density × g × depth; it increases with depth.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Forces, Newton's Laws and Pressure$mq$ and p.name = $mq$Forces and Motion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is a force?
A **force** is a push or pull, measured in newtons (N). Forces can change the speed, direction or shape of an object. Contact forces include friction, air resistance, tension and upthrust. Non-contact forces include gravity, magnetism and electrostatic force. Forces are vectors, so we show direction in diagrams.

**Weight** is the force of gravity on an object: weight = mass × gravitational field strength (W = m × g). On Earth g is about 10 N/kg, so a 5 kg object weighs 50 N. On the Moon g = 1.6 N/kg, so an 80 kg astronaut weighs 128 N. Mass stays the same.

## Resultant force
The **resultant force** is the single force that has the same effect as all the forces acting. Forces in the same direction are added. In opposite directions, subtract. If the resultant is zero, the forces are balanced.

## Newton's laws
- **First law**: an object stays at rest or moves at constant velocity unless a resultant force acts. A seat belt is needed because a passenger tends to keep moving when a car stops.
- **Second law**: resultant force = mass × acceleration (F = m × a). A 1200 kg car with a resultant force of 3000 N accelerates at 2.5 m/s². Acceleration is directly proportional to the resultant force and inversely proportional to the mass.
- **Third law**: when object A exerts a force on B, B exerts an equal and opposite force on A. The two forces act on different objects.

## Terminal velocity
A falling skydiver speeds up because weight is bigger than air resistance. As the speed rises, air resistance increases until it equals the weight. The resultant force is zero, so the velocity stays constant at the terminal velocity. Opening the parachute increases air resistance, which slows the skydiver down to a new, lower terminal velocity. For a skydiver of mass 80 kg, with weight 800 N and 500 N of air resistance, the acceleration is (800 − 500) ÷ 80 = 3.75 m/s².

## Pressure
Pressure = force ÷ area, in pascals (Pa), where 1 Pa = 1 N/m². A 600 N person standing on 0.04 m² exerts 15 000 Pa. A small area gives a high pressure, so knives are sharp and snowshoes are wide. In liquids, pressure increases with depth: pressure = density × g × depth. At 10 m of water this is 1000 × 10 × 10 = 100 000 Pa, which is why submarines need strong hulls.

## Common mistakes
- Confusing mass and weight.
- Thinking that a constant velocity needs a constant resultant force. It needs zero resultant force.
- Thinking that third-law pairs cancel. They act on different objects.
- Forgetting to convert area into m².

## How this is examined
Typical contexts include a parachutist, a car braking, a trolley experiment or a submarine. You use F = ma, interpret force-acceleration data to find a pattern and a rule, justify using Newton's laws, and evaluate methods for reliability and safety.

Exam tip: Always start with a free-body diagram or list the forces, find the resultant, then apply F = ma. Quote the direction of the resultant force.$mq$ from st;

-- Forces and Motion > Work, Energy and Power
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Forces and Motion$mq$, 5, 3 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Work, Energy and Power$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Forces and Motion$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Work, Energy and Power$mq$ and p.name = $mq$Forces and Motion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the unit of work done?$mq$, $mq$["Joule (J)","Watt (W)","Newton (N)","Pascal (Pa)"]$mq$, 0, $mq$Work and energy are measured in joules.$mq$, $mq$easy$mq$),
($mq$What is the unit of power?$mq$, $mq$["Joule (J)","Newton (N)","Hertz (Hz)","Watt (W)"]$mq$, 3, $mq$1 watt = 1 joule per second.$mq$, $mq$easy$mq$),
($mq$Which equation gives work done?$mq$, $mq$["Work = force ÷ distance","Work = mass × speed","Work = force × distance moved in the direction of the force","Work = power ÷ force"]$mq$, 2, $mq$Work is energy transferred by a force.$mq$, $mq$easy$mq$),
($mq$What does the kinetic energy of a moving object depend on?$mq$, $mq$["Only its height","Its mass and its speed","Only its temperature","Only its weight"]$mq$, 1, $mq$KE = ½ × m × v².$mq$, $mq$easy$mq$),
($mq$Which equation gives gravitational potential energy near Earth's surface?$mq$, $mq$["GPE = mass × g × height","GPE = ½ × m × v²","GPE = force × time","GPE = mass × speed"]$mq$, 0, $mq$The higher and heavier the object, the more GPE it has.$mq$, $mq$easy$mq$),
($mq$A 50 N force pushes a trolley 4 m in the direction of the force. How much work is done?$mq$, $mq$["12.5 J","54 J","46 J","200 J"]$mq$, 3, $mq$Work = force × distance = 50 × 4 = 200 J.$mq$, $mq$medium$mq$),
($mq$A machine does 600 J of work in 20 s. What is its power?$mq$, $mq$["12 000 W","580 W","30 W","0.033 W"]$mq$, 2, $mq$Power = work ÷ time = 600 ÷ 20 = 30 W.$mq$, $mq$medium$mq$),
($mq$With g = 10 N/kg, how much GPE is gained by raising 2 kg through 3 m?$mq$, $mq$["6 J","60 J","5 J","23 J"]$mq$, 1, $mq$GPE = mgh = 2 × 10 × 3 = 60 J.$mq$, $mq$medium$mq$),
($mq$A 4 kg trolley moves at 3 m/s. What is its kinetic energy?$mq$, $mq$["18 J","36 J","12 J","6 J"]$mq$, 0, $mq$KE = ½ × 4 × 3² = 2 × 9 = 18 J.$mq$, $mq$medium$mq$),
($mq$A ball falls from 5 m. Ignoring air resistance and with g = 10 N/kg, what is its speed just before landing?$mq$, $mq$["50 m/s","5 m/s","25 m/s","10 m/s"]$mq$, 3, $mq$mgh = ½mv², so v² = 2gh = 2 × 10 × 5 = 100 and v = 10 m/s.$mq$, $mq$medium$mq$),
($mq$A cyclist doubles her speed. What happens to her kinetic energy?$mq$, $mq$["It doubles","It stays the same","It increases by a factor of four","It halves"]$mq$, 2, $mq$KE ∝ v², so doubling v gives 2² = 4 times as much.$mq$, $mq$medium$mq$),
($mq$A lift of mass 500 kg is raised 12 m in 20 s with g = 10 N/kg. What power is needed (ignoring losses)?$mq$, $mq$["300 W","3000 W","6000 W","60 000 W"]$mq$, 1, $mq$Work = 500 × 10 × 12 = 60 000 J. Power = 60 000 ÷ 20 = 3000 W.$mq$, $mq$medium$mq$),
($mq$A person carries a bag of shopping at a steady speed along a flat road. What work does the upward force on the bag do?$mq$, $mq$["None, because the force is at right angles to the movement","A lot, because the bag is heavy","It equals the weight times the distance","It equals the person's power"]$mq$, 0, $mq$Work is done only by the part of a force in the direction of movement.$mq$, $mq$medium$mq$),
($mq$A roller coaster car starts from rest at 40 m. Ignoring friction and with g = 10 N/kg, what is its speed at a height of 10 m?$mq$, $mq$["About 30 m/s","About 10 m/s","About 600 m/s","About 24.5 m/s"]$mq$, 3, $mq$v² = 2gΔh = 2 × 10 × 30 = 600, so v ≈ 24.5 m/s.$mq$, $mq$hard$mq$),
($mq$A 1000 kg car travelling at 20 m/s brakes with a constant force of 5000 N. What is its stopping distance?$mq$, $mq$["4 m","20 m","40 m","400 m"]$mq$, 2, $mq$KE = ½ × 1000 × 20² = 200 000 J. Work done by the brakes = 5000 × d = 200 000, so d = 40 m.$mq$, $mq$hard$mq$),
($mq$Why does doubling a car's speed more than double the braking distance?$mq$, $mq$["Mass doubles","Kinetic energy increases with the square of speed","Friction halves","Gravity increases"]$mq$, 1, $mq$Four times the energy has to be removed by the same force, giving four times the distance.$mq$, $mq$hard$mq$),
($mq$Student A (weight 600 N) climbs 3 m of stairs in 4 s. Student B (weight 500 N) climbs the same stairs in 3 s. Which statement is correct?$mq$, $mq$["B has more power: 500 W against 450 W","A has more power: 450 W against 500 W","They have equal power","A does less work than B"]$mq$, 0, $mq$A: 600 × 3 ÷ 4 = 450 W. B: 500 × 3 ÷ 3 = 500 W.$mq$, $mq$hard$mq$),
($mq$A ball dropped from 1.0 m bounces back to 0.7 m. Assuming mass is constant, what percentage of its original gravitational energy was transferred to other forms such as sound and heat?$mq$, $mq$["70%","0.3%","7%","30%"]$mq$, 3, $mq$Energy is proportional to height. 0.7 ÷ 1.0 = 70% remains, so 30% was transferred elsewhere. Total energy is conserved.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Work, Energy and Power$mq$ and p.name = $mq$Forces and Motion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Work done formula$mq$, $mq$Work done (J) = force (N) × distance moved in the direction of the force (m).$mq$),
($mq$Power formula$mq$, $mq$Power (W) = work done (J) ÷ time (s); 1 W = 1 J/s.$mq$),
($mq$Kinetic energy formula$mq$, $mq$KE = ½ × mass × speed². Doubling speed gives four times the KE.$mq$),
($mq$Gravitational potential energy formula$mq$, $mq$GPE = mass × g × height (g ≈ 10 N/kg on Earth).$mq$),
($mq$Conservation of energy$mq$, $mq$Energy cannot be created or destroyed, only transferred between stores or dissipated.$mq$),
($mq$Speed of a falling object (no air resistance)$mq$, $mq$v = √(2gh), from mgh = ½mv².$mq$),
($mq$Why does doubling speed quadruple braking distance?$mq$, $mq$KE ∝ v². Four times as much energy must be removed by the same braking force.$mq$),
($mq$When is no work done?$mq$, $mq$When the force is at right angles to the movement, e.g. carrying a bag horizontally at steady height.$mq$),
($mq$Why does a bouncing ball bounce lower each time?$mq$, $mq$Some energy is transferred to sound and heat with each bounce, so less is available as GPE.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Work, Energy and Power$mq$ and p.name = $mq$Forces and Motion$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Work and energy
Energy is the ability to do work, measured in joules (J). **Work done** is the energy transferred when a force moves an object: work done = force × distance moved in the direction of the force. A 50 N push moving a trolley 4 m does 50 × 4 = 200 J of work. If the force is at right angles to the movement, no work is done on that motion. For example, the upward force of a hand carrying a bag at steady height along flat ground does no work.

## Energy stores in motion
- **Kinetic energy** (movement): KE = ½ × m × v². A 4 kg trolley at 3 m/s has ½ × 4 × 9 = 18 J. Doubling speed multiplies KE by four.
- **Gravitational potential energy** (height): GPE = m × g × h. Raising 2 kg by 3 m with g = 10 N/kg stores 2 × 10 × 3 = 60 J.

## Conservation of energy
Energy cannot be created or destroyed, only transferred between stores. When an object falls, GPE changes to KE. If air resistance is ignored, mgh = ½mv², so v = √(2gh). A ball falling 5 m reaches √(2 × 10 × 5) = 10 m/s. In real life some energy is dissipated as heat and sound, so a bouncing ball rises less each time. If a ball dropped from 1.0 m rises to 0.7 m, 70% of its energy is returned and 30% is transferred to the surroundings.

## Braking and safety
The kinetic energy of a moving vehicle is removed by the work done by the brakes. A 1000 kg car at 20 m/s has 200 000 J of KE. With a braking force of 5000 N, the stopping distance is 200 000 ÷ 5000 = 40 m. Because KE depends on speed squared, doubling speed means four times the braking distance for the same braking force. This is the scientific reason behind speed limits near schools.

## Power
**Power** is the rate of doing work: power = work done ÷ time, in watts (1 W = 1 J/s). A machine doing 600 J in 20 s has a power of 30 W. A lift of 500 kg raised 12 m in 20 s needs 500 × 10 × 12 ÷ 20 = 3000 W. Two people can do the same work but the one who does it in less time has more power.

## Common mistakes
- Using the wrong distance: only count distance in the direction of the force.
- Forgetting to square the speed in the KE formula.
- Using grams or centimetres without converting to kg and metres.
- Confusing work (J) with power (W).

## How this is examined
In the eAssessment, you could see a roller coaster, a lift, a braking car or a sports context. You calculate energy changes, find an unknown speed or height, compare power, then judge assumptions such as ignoring friction. Criterion D tasks ask about safety, speed limits and the environmental cost of energy use.

Exam tip: Write the formula, show each substitution with units, and state any assumption such as "ignoring air resistance". The assumption often earns marks in evaluation.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('integrated-science')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;