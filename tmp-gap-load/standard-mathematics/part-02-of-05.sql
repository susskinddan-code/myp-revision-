-- Part 2 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Number Properties and Time > Time Zones, Clocks and Timetables
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Number Properties and Time$mq$, 5, 1 from public.subjects s where s.slug = $mq$standard-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Time Zones, Clocks and Timetables$mq$, 5, p.id, 4
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$standard-mathematics$mq$ and p.grade = 5 and p.name = $mq$Number Properties and Time$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Time Zones, Clocks and Timetables$mq$ and p.name = $mq$Number Properties and Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Write 7:45 pm in 24-hour time.$mq$, $mq$["19:45","07:45","17:45","18:45"]$mq$, 0, $mq$For pm times add 12 to the hour: 7 + 12 = 19, so 19:45.$mq$, $mq$easy$mq$),
($mq$A film starts at 14:35 and lasts 3 hours 40 minutes. When does it finish?$mq$, $mq$["17:75","18:05","17:55","18:15"]$mq$, 3, $mq$14:35 + 3 h = 17:35. Adding 40 min gives 18:15 (35 + 40 = 75 min = 1 h 15 min past 17:00).$mq$, $mq$easy$mq$),
($mq$How long is it from 09:20 to 11:05?$mq$, $mq$["2 hours 15 minutes","1 hour 85 minutes","1 hour 45 minutes","1 hour 15 minutes"]$mq$, 2, $mq$09:20 to 10:00 is 40 min, then 10:00 to 11:05 is 65 min: 40 + 65 = 105 min = 1 h 45 min. Time is not decimal.$mq$, $mq$easy$mq$),
($mq$London is on UTC+0 and Tokyo is on UTC+9. When it is 12:00 in London, what time is it in Tokyo?$mq$, $mq$["03:00","21:00","09:00","15:00"]$mq$, 1, $mq$Tokyo is 9 hours ahead of London, so add 9 hours: 21:00.$mq$, $mq$easy$mq$),
($mq$How many minutes are in 2.5 hours?$mq$, $mq$["150","250","120","205"]$mq$, 0, $mq$2.5 × 60 = 150 minutes. Do not treat the decimal part as minutes.$mq$, $mq$easy$mq$),
($mq$A flight leaves Dubai (UTC+4) at 02:30 and takes 7 h 30 min. London is on UTC+0. What is the local arrival time in London?$mq$, $mq$["10:00","02:00","14:00","06:00"]$mq$, 3, $mq$02:30 in Dubai is 22:30 UTC the previous day. Adding 7 h 30 min gives 06:00 UTC, which is 06:00 London time.$mq$, $mq$medium$mq$),
($mq$A coach travels 135 km between two stops. It leaves at 10:15 and arrives at 11:45. What is its average speed?$mq$, $mq$["135 km/h","67.5 km/h","90 km/h","1.5 km/h"]$mq$, 2, $mq$The time is 1 h 30 min = 1.5 h. Speed = 135 ÷ 1.5 = 90 km/h.$mq$, $mq$medium$mq$),
($mq$Write 3.4 hours in hours and minutes.$mq$, $mq$["3 h 40 min","3 h 24 min","3 h 4 min","3 h 34 min"]$mq$, 1, $mq$0.4 h × 60 = 24 minutes, so 3 h 24 min. Writing 40 min is a common slip.$mq$, $mq$medium$mq$),
($mq$New York is on UTC−5 and Sydney is on UTC+11. A meeting starts at 09:00 in New York. What is the local time in Sydney?$mq$, $mq$["01:00 the next day","01:00 the same day","17:00 the same day","20:00 the previous day"]$mq$, 0, $mq$The difference is 11 − (−5) = 16 hours. 09:00 + 16 h = 25:00, which is 01:00 the next day.$mq$, $mq$medium$mq$),
($mq$A night train leaves at 22:50 and the journey takes 5 h 25 min. When does it arrive?$mq$, $mq$["03:15 the next day","04:15 the same day","03:75 the next day","04:15 the next day"]$mq$, 3, $mq$22:50 + 1 h 10 min = 00:00. The remaining 4 h 15 min gives 04:15 the next day.$mq$, $mq$medium$mq$),
($mq$A train is timetabled to leave one station at 08:12 and reach the next at 08:47. The stations are 28 km apart. What is its average speed?$mq$, $mq$["28 km/h","80 km/h","48 km/h","0.8 km/h"]$mq$, 2, $mq$Time = 35 min = 35/60 h. Speed = 28 ÷ (35/60) = 48 km/h.$mq$, $mq$medium$mq$),
($mq$City A is on UTC+2 and city B is on UTC−3. A 9-hour flight leaves A at 14:00 local time. What is the local arrival time in B?$mq$, $mq$["23:00","18:00","04:00","09:00"]$mq$, 1, $mq$14:00 at A is 12:00 UTC. Add 9 h: 21:00 UTC. B is on UTC−3, so local time is 18:00.$mq$, $mq$medium$mq$),
($mq$A stopwatch shows 1 h 15 min 30 s. How many seconds is this?$mq$, $mq$["4530","4530 minutes","1530","3930"]$mq$, 0, $mq$1 h = 3600 s, 15 min = 900 s, plus 30 s: 3600 + 900 + 30 = 4530 s.$mq$, $mq$medium$mq$),
($mq$A plane leaves London (UTC+0) at 22:15 on Monday and flies to Singapore (UTC+8) in 13 h 10 min. When does it land by Singapore local time?$mq$, $mq$["11:25 on Tuesday","09:25 on Tuesday","03:25 on Wednesday","19:25 on Tuesday"]$mq$, 3, $mq$22:15 + 13 h 10 min = 11:25 UTC on Tuesday. Singapore is 8 hours ahead: 19:25 Tuesday.$mq$, $mq$hard$mq$),
($mq$A plane lands in Delhi (UTC+5:30) at 06:40 local time. What is the time in UTC+0 at that moment?$mq$, $mq$["12:10","06:40","01:10","00:10"]$mq$, 2, $mq$Delhi is 5 h 30 min ahead of UTC. Subtract: 06:40 − 5:30 = 01:10.$mq$, $mq$hard$mq$),
($mq$Paris is on UTC+1 and Los Angeles is on UTC−8. A call is arranged for 17:00 in Paris. What time is it in Los Angeles?$mq$, $mq$["02:00","08:00","16:00","09:00"]$mq$, 1, $mq$The difference is 9 hours. Los Angeles is behind, so 17:00 − 9 h = 08:00.$mq$, $mq$hard$mq$),
($mq$A jet takes off at 10:00 UTC+0 and lands 5600 km away at 21:24 local time, where the time zone is UTC+5. What is its average speed for the flight?$mq$, $mq$["875 km/h","491 km/h","560 km/h","1300 km/h"]$mq$, 0, $mq$21:24 local is 16:24 UTC. Flying time is 6 h 24 min = 6.4 h. Speed = 5600 ÷ 6.4 = 875 km/h. Ignoring the time zone gives 11.4 h and a wrong answer.$mq$, $mq$hard$mq$),
($mq$Buses leave a terminal every 24 minutes starting at 06:10. Abdul arrives at 09:00. When is the first bus he can catch?$mq$, $mq$["09:10","08:58","09:34","09:22"]$mq$, 3, $mq$From 06:10 to 09:00 is 170 minutes. The 8th bus after the first is at 8 × 24 = 192 min after 06:10, which is 09:22. The 7th leaves at 168 min = 08:58, too early.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Time Zones, Clocks and Timetables$mq$ and p.name = $mq$Number Properties and Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$12-hour to 24-hour$mq$, $mq$Add 12 to pm hours (7:45 pm = 19:45). 12:00 am is 00:00 and 12:00 pm is 12:00.$mq$),
($mq$Convert 3.4 h to h and min$mq$, $mq$Multiply the decimal part by 60: 0.4 × 60 = 24, so 3 h 24 min.$mq$),
($mq$Speed formula$mq$, $mq$Speed = distance ÷ time. Use hours for time, so 30 min = 0.5 h.$mq$),
($mq$What does UTC+9 mean?$mq$, $mq$Local time is 9 hours AHEAD of UTC, so add 9 to UTC to get local time.$mq$),
($mq$What does UTC−5 mean?$mq$, $mq$Local time is 5 hours BEHIND UTC, so subtract 5 from UTC to get local time.$mq$),
($mq$Method for time zone journeys$mq$, $mq$Local departure → UTC → add flight time → UTC arrival → local arrival. Watch for date changes.$mq$),
($mq$Time difference between two zones$mq$, $mq$Subtract offsets: New York (UTC−5) and Sydney (UTC+11) differ by 11 − (−5) = 16 hours.$mq$),
($mq$Seconds in 1 hour and 1 day$mq$, $mq$1 hour = 3600 s. 1 day = 86 400 s.$mq$),
($mq$Duration trick$mq$, $mq$Count up to the next whole hour, then add the rest: 09:20 to 11:05 = 40 + 65 = 105 min.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Time Zones, Clocks and Timetables$mq$ and p.name = $mq$Number Properties and Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## 12-hour and 24-hour time
The 24-hour clock avoids am/pm confusion. For times after noon add 12: 7:45 pm is 19:45. Midnight is 00:00. Never forget that time works in base 60, not base 10: 14:35 plus 40 minutes is 15:15 and not 14:75.

## Durations
To find how long something lasts, count up to the next whole hour and then onwards. From 09:20 to 11:05: 40 minutes to 10:00, then 65 minutes to 11:05, making 105 minutes or 1 h 45 min. Convert between decimals and minutes by multiplying the decimal part by 60: 3.4 h = 3 h + 0.4 × 60 min = 3 h 24 min.

## Speed, distance and time
Use speed = distance ÷ time, with time in hours. A coach covers 135 km in 1 h 30 min, so its speed is 135 ÷ 1.5 = 90 km/h. If you are given minutes, divide by 60: 35 minutes is 35/60 h.

## Reading timetables
A timetable lists departure and arrival times for each stop. Subtract to find the journey time between stops, and look for gaps between services. For buses every 24 minutes starting at 06:10, the times are 06:10, 06:34, 06:58 and so on. To find the first bus after 09:00, count how many whole 24-minute steps fit, then check the next one is not earlier than the arrival time.

## Time zones
The world is divided into zones measured from UTC (Coordinated Universal Time, which is the same as Greenwich time). A zone written UTC+9 is 9 hours ahead of UTC, so its clocks show a later time. UTC−5 is 5 hours behind.
Method for any time zone question:
1. Convert the local time to UTC (subtract the offset).
2. Add any travel time.
3. Convert to the new local time (add the offset).
Check whether you cross midnight, because that changes the date.
Example: London to Singapore. Depart 22:15 Monday UTC+0. Flight 13 h 10 min. Arrive 11:25 UTC Tuesday. Singapore is UTC+8, so local arrival is 19:25 Tuesday. Notice that the flight time is not 19:25 − 22:15. Time zone differences must be accounted for.
Some places have half-hour offsets, such as UTC+5:30. Subtract or add 5 h 30 min exactly.

## Common mistakes
- Treating minutes as decimals (1.45 h is not 1 h 45 min).
- Adding the time difference in the wrong direction for places west of UTC.
- Working out the flight duration directly from local departure and arrival times.
- Forgetting that the date changes after midnight.

## How this is examined
Real tasks give a travel plan or timetable and ask you to find arrival times, journey durations and average speeds, then evaluate the plan. For example, can a student attend a video call across time zones, and will they have enough time between connecting flights? Show every conversion step and state the date as well as the time.

Exam tip: Convert everything to UTC first, do the arithmetic there, then convert back to local time. Write the date change next to your answer if you cross midnight.$mq$ from st;

-- Further Geometry and Trigonometry > Circle Geometry and Theorems
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Further Geometry and Trigonometry$mq$, 5, 2 from public.subjects s where s.slug = $mq$standard-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Circle Geometry and Theorems$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$standard-mathematics$mq$ and p.grade = 5 and p.name = $mq$Further Geometry and Trigonometry$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Circle Geometry and Theorems$mq$ and p.name = $mq$Further Geometry and Trigonometry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$AB is a diameter of a circle and C is another point on the circle. What is the size of angle ACB?$mq$, $mq$["90°","45°","180°","60°"]$mq$, 0, $mq$The angle in a semicircle is always 90°, whatever position C takes on the circumference.$mq$, $mq$easy$mq$),
($mq$A tangent touches a circle at point T. O is the centre. What is the size of angle OTP, where P is a point on the tangent?$mq$, $mq$["45°","180°","It depends on the radius","90°"]$mq$, 3, $mq$A tangent is perpendicular to the radius at the point of contact, so the angle is 90°.$mq$, $mq$easy$mq$),
($mq$The angle at the centre of a circle standing on an arc is 80°. What is the angle at the circumference standing on the same arc?$mq$, $mq$["160°","80°","40°","100°"]$mq$, 2, $mq$The angle at the centre is twice the angle at the circumference, so the circumference angle is 80° ÷ 2 = 40°.$mq$, $mq$easy$mq$),
($mq$ABCD is a cyclic quadrilateral. Angle ABC = 105°. What is angle ADC?$mq$, $mq$["105°","75°","255°","85°"]$mq$, 1, $mq$Opposite angles of a cyclic quadrilateral add up to 180°, so 180° − 105° = 75°.$mq$, $mq$easy$mq$),
($mq$Two tangents are drawn from an external point P to touch a circle at A and B. Which statement is true?$mq$, $mq$["PA = PB","PA = AB","PA is parallel to PB","Angle PAB = 90°"]$mq$, 0, $mq$Tangents drawn from the same external point are equal in length. Angle PAB is not 90°; it is the angle OAP that is 90°.$mq$, $mq$easy$mq$),
($mq$PT is a tangent to a circle with centre O and radius 5 cm. OP = 13 cm. Find the length PT.$mq$, $mq$["8 cm","18 cm","√194 cm","12 cm"]$mq$, 3, $mq$Triangle OTP has a right angle at T (tangent ⟂ radius). PT² = 13² − 5² = 144, so PT = 12 cm.$mq$, $mq$medium$mq$),
($mq$A chord 16 cm long is in a circle of radius 10 cm. How far is the chord from the centre?$mq$, $mq$["2 cm","8 cm","6 cm","√164 cm"]$mq$, 2, $mq$The perpendicular from the centre bisects the chord, forming a right-angled triangle with sides 8 and 10 (hypotenuse). Distance = √(100 − 64) = 6 cm.$mq$, $mq$medium$mq$),
($mq$AB is a diameter of a circle. C is on the circumference and angle BAC = 35°. Find angle ABC.$mq$, $mq$["35°","55°","90°","145°"]$mq$, 1, $mq$Angle ACB = 90° (angle in a semicircle). The angles in triangle ABC add to 180°: 180 − 90 − 35 = 55°.$mq$, $mq$medium$mq$),
($mq$In cyclic quadrilateral ABCD, angle DAB = 95°. Find angle BCD.$mq$, $mq$["85°","95°","180°","265°"]$mq$, 0, $mq$Opposite angles in a cyclic quadrilateral are supplementary: 180° − 95° = 85°.$mq$, $mq$medium$mq$),
($mq$Points A, B, C and D are on a circle, with C and D on the same side of chord AB. Angle ACB = 42°. What is angle ADB?$mq$, $mq$["84°","138°","21°","42°"]$mq$, 3, $mq$Angles subtended by the same chord (arc) at the circumference in the same segment are equal, so ADB = 42°.$mq$, $mq$medium$mq$),
($mq$O is the centre of a circle and A, B are on the circumference. Angle AOB = 110°. Find angle OAB.$mq$, $mq$["110°","70°","35°","55°"]$mq$, 2, $mq$OA = OB (radii), so triangle OAB is isosceles. The base angles are (180° − 110°) ÷ 2 = 35°.$mq$, $mq$medium$mq$),
($mq$A, B and C are on a circle with centre O, with C on the major arc. Angle ACB = 50°. What is the reflex angle AOB?$mq$, $mq$["100°","260°","50°","310°"]$mq$, 1, $mq$The angle AOB (minor) = 2 × 50° = 100°. The reflex angle is 360° − 100° = 260°.$mq$, $mq$medium$mq$),
($mq$ABCD is a cyclic quadrilateral. The side AB is extended to E, and angle CBE = 78°. Find angle ADC.$mq$, $mq$["78°","102°","180°","39°"]$mq$, 0, $mq$The exterior angle of a cyclic quadrilateral equals the interior opposite angle. Check: ABC = 102°, so ADC = 180 − 102 = 78°.$mq$, $mq$medium$mq$),
($mq$PA and PB are tangents to a circle at A and B, and angle APB = 50°. Find angle PAB.$mq$, $mq$["50°","130°","40°","65°"]$mq$, 3, $mq$PA = PB, so triangle PAB is isosceles. Angle PAB = (180° − 50°) ÷ 2 = 65°.$mq$, $mq$hard$mq$),
($mq$PA and PB are tangents to a circle with centre O, touching at A and B. Angle AOB = 130°. Find angle APB.$mq$, $mq$["130°","65°","50°","90°"]$mq$, 2, $mq$Quadrilateral OAPB has angles 90° at A and B (tangent ⟂ radius). So APB = 360° − 90° − 90° − 130° = 50°.$mq$, $mq$hard$mq$),
($mq$In a cyclic quadrilateral, two opposite angles are (2x + 10)° and (3x − 20)°. Find x.$mq$, $mq$["34","38","36","40"]$mq$, 1, $mq$Opposite angles sum to 180°: 5x − 10 = 180, so x = 38. The angles are 86° and 94°.$mq$, $mq$hard$mq$),
($mq$AB is a diameter and C lies on the circle. AC = 8 cm and BC = 15 cm. Find the radius.$mq$, $mq$["8.5 cm","17 cm","11.5 cm","7.5 cm"]$mq$, 0, $mq$Angle ACB = 90°, so AB² = 8² + 15² = 289 and AB = 17 cm. The radius is half the diameter: 8.5 cm.$mq$, $mq$hard$mq$),
($mq$A, B, C are on a circle with centre O. Angle ABC = 125° with B on the minor arc AC. Find the minor angle AOC.$mq$, $mq$["125°","250°","55°","110°"]$mq$, 3, $mq$ABCD cyclic (D on the major arc): ADC = 180° − 125° = 55°. Angle at the centre is double: AOC = 110°.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Circle Geometry and Theorems$mq$ and p.name = $mq$Further Geometry and Trigonometry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Angle in a semicircle$mq$, $mq$90°. The diameter must be the base of the triangle.$mq$),
($mq$Angle at centre vs circumference$mq$, $mq$Angle at the centre = 2 × the angle at the circumference, on the same arc.$mq$),
($mq$Angles in the same segment$mq$, $mq$Angles standing on the same chord from the same side of it are equal.$mq$),
($mq$Cyclic quadrilateral$mq$, $mq$All four vertices on a circle. Opposite angles add up to 180°.$mq$),
($mq$Tangent and radius$mq$, $mq$A tangent meets the radius at 90° at the point of contact.$mq$),
($mq$Tangents from an external point$mq$, $mq$The two tangent lengths are equal, so triangle PAB is isosceles.$mq$),
($mq$Perpendicular from centre to a chord$mq$, $mq$It bisects the chord. Use Pythagoras: half-chord² + distance² = radius².$mq$),
($mq$Exterior angle of a cyclic quadrilateral$mq$, $mq$Equals the interior opposite angle.$mq$),
($mq$Isosceles triangle from radii$mq$, $mq$Two radii form two equal sides, so base angles are equal: (180° − centre angle) ÷ 2.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Circle Geometry and Theorems$mq$ and p.name = $mq$Further Geometry and Trigonometry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The circle language you need
A circle has a **radius**, **diameter** (twice the radius), **chord** (line joining two points on the circle), **tangent** (line touching the circle at one point), **arc** (part of the circumference) and **segment** (region between a chord and an arc). In circle theorem questions you write a reason for every angle. Reasons are marks.

## The key theorems
1. **Angle in a semicircle is 90°.** If AB is a diameter and C is on the circle, angle ACB = 90°.
2. **Angle at the centre is twice the angle at the circumference** when both stand on the same arc.
3. **Angles in the same segment are equal.** Angles at the circumference standing on the same chord, and on the same side of it, are equal.
4. **Opposite angles of a cyclic quadrilateral add up to 180°.** The exterior angle of a cyclic quadrilateral equals the interior opposite angle.
5. **A tangent is perpendicular to the radius** at the point of contact.
6. **Tangents from an external point are equal in length**, so the kite OAPB formed by two tangents has two right angles.
7. **The perpendicular from the centre to a chord bisects the chord.**
8. Radii are equal, so any triangle with two radii as sides is isosceles.

## Worked example
Two tangents PA and PB touch a circle with centre O at A and B. Angle AOB = 130°.
Step 1: angle OAP = angle OBP = 90° (tangent perpendicular to radius).
Step 2: angles in quadrilateral OAPB add to 360°, so angle APB = 360° − 90° − 90° − 130° = 50°.
Step 3: PA = PB (tangents from a point), so angle PAB = (180° − 50°) ÷ 2 = 65°.

Another example: a chord is 16 cm long in a circle with radius 10 cm. The perpendicular from the centre bisects the chord, forming a right-angled triangle with hypotenuse 10 and one side 8. The distance from the centre is √(10² − 8²) = 6 cm.

## Strategy
- Mark all known angles on a diagram. Look for diameters, tangents, centre points and isosceles triangles made by two radii.
- When you see a right angle in a circle, check for a tangent or a semicircle.
- When the centre is given, think "double". When two angles stand on the same chord, think "equal".
- Use Pythagoras and trigonometry when lengths are asked.

## Common mistakes
- Using the centre angle theorem when the angle is not at the centre.
- Forgetting that the angle in a semicircle needs a diameter.
- Saying the opposite angles of ANY quadrilateral sum to 180°. Only cyclic ones do.
- Writing "angle at the centre = 2 × circumference" with the wrong arc, e.g. for a reflex angle.
- Giving the answer without a reason.

## How this is examined
Circle theorems appear in diagrams from design settings such as a circular window, a roundabout, a stadium or a clock face. You are asked to find angles and give reasons, or to show that two lengths are equal, and sometimes to justify why a quadrilateral cannot be cyclic. Write each step as "angle = value (reason)".

Exam tip: Write the name of the theorem next to each angle you find, for example "angle ACB = 90° (angle in a semicircle)", because method marks go to the reason as well as the number.$mq$ from st;

-- Further Geometry and Trigonometry > Sine Rule, Cosine Rule and Area of a Triangle
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Further Geometry and Trigonometry$mq$, 5, 2 from public.subjects s where s.slug = $mq$standard-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Sine Rule, Cosine Rule and Area of a Triangle$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$standard-mathematics$mq$ and p.grade = 5 and p.name = $mq$Further Geometry and Trigonometry$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Sine Rule, Cosine Rule and Area of a Triangle$mq$ and p.name = $mq$Further Geometry and Trigonometry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$A triangle has sides 8 cm and 5 cm with an included angle of 30°. Find its area using ½ab sin C.$mq$, $mq$["10 cm²","20 cm²","40 cm²","17.3 cm²"]$mq$, 0, $mq$Area = ½ × 8 × 5 × sin 30° = 20 × 0.5 = 10 cm².$mq$, $mq$easy$mq$),
($mq$You know two sides of a triangle and the angle between them. Which rule finds the third side?$mq$, $mq$["Sine rule","Pythagoras only","Area rule","Cosine rule"]$mq$, 3, $mq$With two sides and the included angle (SAS) use c² = a² + b² − 2ab cos C. The sine rule needs a matching side and angle pair.$mq$, $mq$easy$mq$),
($mq$Which expression is the sine rule?$mq$, $mq$["a sin A = b sin B","a² = b² + c² − 2bc sin A","a / sin A = b / sin B","a / cos A = b / cos B"]$mq$, 2, $mq$The sine rule says each side divided by the sine of its opposite angle is the same for the whole triangle.$mq$, $mq$easy$mq$),
($mq$You know two angles and one side of a triangle. Which rule do you use to find another side?$mq$, $mq$["Cosine rule","Sine rule","Area formula only","Pythagoras"]$mq$, 1, $mq$Two angles give the third angle, and then you have a side with its opposite angle: use the sine rule.$mq$, $mq$easy$mq$),
($mq$What is sin 150°?$mq$, $mq$["0.5","−0.5","0.866","−0.866"]$mq$, 0, $mq$sin(180° − θ) = sin θ, so sin 150° = sin 30° = 0.5.$mq$, $mq$easy$mq$),
($mq$In triangle ABC, a = 7 cm, angle A = 40° and angle B = 65°. Find b to 2 decimal places.$mq$, $mq$["4.84 cm","10.76 cm","6.35 cm","9.87 cm"]$mq$, 3, $mq$By the sine rule b/sin 65° = 7/sin 40°. So b = 7 × sin 65° ÷ sin 40° = 9.87 cm.$mq$, $mq$medium$mq$),
($mq$In triangle ABC, a = 6 cm, b = 9 cm and angle C = 50°. Find side c to 1 decimal place.$mq$, $mq$["10.8 cm","13.9 cm","6.9 cm","11.7 cm"]$mq$, 2, $mq$c² = 6² + 9² − 2 × 6 × 9 × cos 50° = 117 − 69.4 = 47.6, so c = 6.9 cm.$mq$, $mq$medium$mq$),
($mq$A triangle has sides 5 cm, 7 cm and 10 cm. Find the largest angle to the nearest degree.$mq$, $mq$["68°","112°","44°","34°"]$mq$, 1, $mq$The largest angle is opposite the longest side. cos C = (5² + 7² − 10²) ÷ (2 × 5 × 7) = −26/70, so C = 111.8° ≈ 112°. A negative cosine gives an obtuse angle.$mq$, $mq$medium$mq$),
($mq$Find the area of a triangle with sides 9 cm and 12 cm and an included angle of 70°, to 1 decimal place.$mq$, $mq$["50.7 cm²","54.0 cm²","108.0 cm²","18.5 cm²"]$mq$, 0, $mq$Area = ½ × 9 × 12 × sin 70° = 54 × 0.9397 = 50.7 cm². Do not forget the ½.$mq$, $mq$medium$mq$),
($mq$A ship sails 12 km on a bearing of 040°, then turns and sails 15 km on a bearing of 100°. The angle inside the path at the turning point is 120°. How far is the ship from its start, to 1 decimal place?$mq$, $mq$["19.2 km","27.0 km","16.0 km","23.4 km"]$mq$, 3, $mq$d² = 12² + 15² − 2 × 12 × 15 × cos 120° = 369 + 180 = 549, so d = 23.4 km. cos 120° = −0.5, which adds to the total.$mq$, $mq$medium$mq$),
($mq$A triangular plot has two boundaries of 120 m and 150 m meeting at 50°. Find its area to the nearest square metre.$mq$, $mq$["9000 m²","5309 m²","6894 m²","6000 m²"]$mq$, 2, $mq$Area = ½ × 120 × 150 × sin 50° = 9000 × 0.7660 = 6894 m².$mq$, $mq$medium$mq$),
($mq$In an acute-angled triangle ABC, a = 8 cm, b = 11 cm and angle A = 35°. Find angle B to 1 decimal place.$mq$, $mq$["127.9°","52.1°","35.0°","46.3°"]$mq$, 1, $mq$sin B / 11 = sin 35° / 8, so sin B = 11 × 0.5736 ÷ 8 = 0.7887 and B = 52.1°. The other solution, 127.9°, is obtuse, so it is not allowed in an acute triangle.$mq$, $mq$medium$mq$),
($mq$A triangle has area 30 cm² and two sides of 10 cm and 8 cm. The included angle is acute. Find it to 1 decimal place.$mq$, $mq$["48.6°","41.4°","22.5°","75.0°"]$mq$, 0, $mq$30 = ½ × 10 × 8 × sin C = 40 sin C, so sin C = 0.75 and C = 48.6° (acute).$mq$, $mq$medium$mq$),
($mq$Points A and B lie on level ground in line with the foot of a tower, with AB = 20 m and B nearer the tower. The angle of elevation of the top T is 62° from A and 71° from B. Find the height of the tower to the nearest metre.$mq$, $mq$["19 m","57 m","121 m","107 m"]$mq$, 3, $mq$Angle ABT = 180° − 71° = 109° and angle ATB = 71° − 62° = 9°. By the sine rule AT = 20 × sin 109° ÷ sin 9° = 120.9 m. Height = AT × sin 62° = 106.7 m, so 107 m. The 121 m answer is the slant length AT.$mq$, $mq$hard$mq$),
($mq$A triangle has sides 8 cm, 11 cm and 13 cm. Find its area to 1 decimal place.$mq$, $mq$["44.0 cm²","52.0 cm²","43.8 cm²","88.0 cm²"]$mq$, 2, $mq$The largest angle is opposite 13 cm: cos θ = (8² + 11² − 13²) ÷ (2 × 8 × 11) = 16/176, so θ = 84.8°. Area = ½ × 8 × 11 × sin 84.8° = 43.8 cm².$mq$, $mq$hard$mq$),
($mq$In triangle ABC, A = 30°, a = 5 cm and b = 8 cm. Which values of angle B are possible?$mq$, $mq$["53.1° only","53.1° or 126.9°","126.9° only","30° or 150°"]$mq$, 1, $mq$sin B = 8 sin 30° ÷ 5 = 0.8, giving B = 53.1° or 180° − 53.1° = 126.9°. Both fit because the side opposite the known angle (5) is shorter than b (8) but longer than b sin A = 4: this is the ambiguous case.$mq$, $mq$hard$mq$),
($mq$In quadrilateral ABCD, AB = 6 cm, BC = 8 cm and angle ABC = 90°. Diagonal AC splits it into triangle ABC and triangle ACD, where CD = 9 cm and angle ACD = 40°. Find the area of ABCD to 1 decimal place.$mq$, $mq$["52.9 cm²","24.0 cm²","28.9 cm²","76.6 cm²"]$mq$, 0, $mq$Triangle ABC has area ½ × 6 × 8 = 24, and AC = 10 cm. Triangle ACD has area ½ × 10 × 9 × sin 40° = 28.9. Total = 52.9 cm².$mq$, $mq$hard$mq$),
($mq$B is 8 km from A on a bearing of 070°. C is 11 km from B on a bearing of 150°. The angle ABC is 100°. Find the distance AC to 1 decimal place.$mq$, $mq$["13.6 km","12.2 km","18.0 km","14.7 km"]$mq$, 3, $mq$AC² = 8² + 11² − 2 × 8 × 11 × cos 100° = 185 + 30.6 = 215.6, so AC = 14.7 km. Note cos 100° is negative, so the term adds.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Sine Rule, Cosine Rule and Area of a Triangle$mq$ and p.name = $mq$Further Geometry and Trigonometry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Sine rule$mq$, $mq$a / sin A = b / sin B = c / sin C. Needs a side and its opposite angle.$mq$),
($mq$Cosine rule for a side$mq$, $mq$c² = a² + b² − 2ab cos C. Use for SAS (two sides and the included angle).$mq$),
($mq$Cosine rule for an angle$mq$, $mq$cos C = (a² + b² − c²) ÷ (2ab). Use for SSS (three sides).$mq$),
($mq$Area of a triangle$mq$, $mq$Area = ½ab sin C, where C is the angle between sides a and b.$mq$),
($mq$Ambiguous case$mq$, $mq$With SSA, sin B can give B and 180° − B. Check which angles fit in the triangle.$mq$),
($mq$Which angle is largest?$mq$, $mq$The one opposite the longest side. If cos is negative, the angle is obtuse.$mq$),
($mq$Bearings$mq$, $mq$Measured clockwise from north, written with 3 digits. Back bearing = bearing ± 180°.$mq$),
($mq$sin 150° and cos 120°$mq$, $mq$sin 150° = sin 30° = 0.5. cos 120° = −cos 60° = −0.5.$mq$),
($mq$Order of operations in cosine rule$mq$, $mq$Work out 2ab cos C first, then subtract from a² + b². Take the square root last.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Sine Rule, Cosine Rule and Area of a Triangle$mq$ and p.name = $mq$Further Geometry and Trigonometry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Beyond right-angled triangles
SOH CAH TOA only works when there is a right angle. For any triangle, label the angles A, B, C and the sides opposite them a, b, c. Then you can use the sine rule, the cosine rule and the area formula.

## The sine rule
a / sin A = b / sin B = c / sin C
Use it when you know a matching pair (a side and its opposite angle) plus one more piece of information: two angles and a side (AAS), or two sides and a non-included angle (SSA). To find an angle, flip the rule: sin A / a = sin B / b.
Example: a = 7, A = 40°, B = 65°. Then b = 7 × sin 65° ÷ sin 40° = 9.87.

**The ambiguous case.** With SSA, sin B can give two angles: B and 180° − B. Example: A = 30°, a = 5, b = 8 gives sin B = 0.8, so B = 53.1° or 126.9°. Check which fit by seeing whether the angles add to less than 180°, or use any extra information such as "acute".

## The cosine rule
Side: c² = a² + b² − 2ab cos C. Use with two sides and the included angle (SAS).
Angle: cos C = (a² + b² − c²) ÷ (2ab). Use with three sides (SSS).
A negative cosine means an obtuse angle. The largest angle is opposite the longest side, so find it first if you want a quick check.

## Area of a triangle
Area = ½ab sin C, where C is the angle between sides a and b. Example: sides 9 and 12 with 70° between them give ½ × 9 × 12 × sin 70° = 50.7. Use this when no perpendicular height is given.

## Choosing the right tool
- Right angle: Pythagoras or SOH CAH TOA.
- Side + opposite angle known, plus one more: sine rule.
- Two sides + included angle: cosine rule (side).
- Three sides: cosine rule (angle).
- Area with two sides and the angle between: ½ab sin C.

## Bearings and bigger problems
Bearings are measured clockwise from north in three digits. For a path with two legs, work out the angle inside the turn using parallel lines and back bearings. Split quadrilaterals into two triangles by a diagonal. Draw a clear diagram, label what you know, and only round at the end. Keep your calculator in degree mode.

## Common mistakes
- Using the sine rule with a side and an angle that are not opposite each other.
- Forgetting the order of operations: 2ab cos C means (2 × a × b) × cos C, and the subtraction happens after that.
- Subtracting before multiplying inside the cosine rule.
- Missing the second solution in the ambiguous case.
- Giving a rounded value from an earlier step instead of storing the full calculator value.

## How this is examined
Typical tasks involve a surveyor measuring a field, a boat or plane travelling on bearings, or a roof frame. You choose the correct rule, calculate, and then comment on accuracy, for example by comparing a calculated length with a measured one and finding the percentage error.

Exam tip: Before pressing any buttons, write which rule you are using and the substituted formula. If you press a wrong key, you still gain method marks.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('standard-mathematics')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;