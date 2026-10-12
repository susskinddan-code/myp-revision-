-- Part 3 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Further Geometry and Trigonometry > Enlargement and Tessellations
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Further Geometry and Trigonometry$mq$, 5, 2 from public.subjects s where s.slug = $mq$standard-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Enlargement and Tessellations$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$standard-mathematics$mq$ and p.grade = 5 and p.name = $mq$Further Geometry and Trigonometry$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Enlargement and Tessellations$mq$ and p.name = $mq$Further Geometry and Trigonometry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$A line of length 4 cm is enlarged by scale factor 3. What is the new length?$mq$, $mq$["12 cm","7 cm","4/3 cm","1.33 cm"]$mq$, 0, $mq$Multiply lengths by the scale factor: 4 × 3 = 12 cm.$mq$, $mq$easy$mq$),
($mq$An enlargement has scale factor 0.5. What happens to the shape?$mq$, $mq$["It gets bigger","It stays the same size","It is reflected","It gets smaller"]$mq$, 3, $mq$A scale factor between 0 and 1 reduces the shape. It is still called an enlargement.$mq$, $mq$easy$mq$),
($mq$Which regular polygon tessellates on its own?$mq$, $mq$["Pentagon","Octagon","Hexagon","Decagon"]$mq$, 2, $mq$Regular hexagons have interior angles 120°, and 3 × 120° = 360° fit around a point. Regular pentagons, octagons and decagons leave gaps.$mq$, $mq$easy$mq$),
($mq$A shape is enlarged by scale factor 2 about the origin. Point (3, 4) is on the shape. Where is its image?$mq$, $mq$["(5, 6)","(6, 8)","(1.5, 2)","(6, 4)"]$mq$, 1, $mq$Multiply both coordinates by 2 when the centre is the origin: (6, 8).$mq$, $mq$easy$mq$),
($mq$The angles around a point add up to what?$mq$, $mq$["360°","180°","90°","270°"]$mq$, 0, $mq$A full turn is 360°. Shapes in a tessellation must have angles totalling 360° at every vertex.$mq$, $mq$easy$mq$),
($mq$A shape has area 5 cm². It is enlarged by scale factor 3. What is the area of the image?$mq$, $mq$["15 cm²","135 cm²","8 cm²","45 cm²"]$mq$, 3, $mq$Area scales by k² = 9, so 5 × 9 = 45 cm². Multiplying by 3 is the mistake for lengths only.$mq$, $mq$medium$mq$),
($mq$An enlargement has centre (1, 1) and scale factor 3. Find the image of (2, 3).$mq$, $mq$["(6, 9)","(3, 5)","(4, 7)","(7, 4)"]$mq$, 2, $mq$Vector from centre to point is (1, 2). Multiply by 3: (3, 6). Add to the centre: (1 + 3, 1 + 6) = (4, 7).$mq$, $mq$medium$mq$),
($mq$A(2, 4) is mapped to A'(6, 12) by an enlargement with centre the origin. What is the scale factor?$mq$, $mq$["2","3","4","1/3"]$mq$, 1, $mq$6 ÷ 2 = 3 and 12 ÷ 4 = 3. The scale factor is image divided by object.$mq$, $mq$medium$mq$),
($mq$A cuboid of volume 20 cm³ is enlarged by scale factor 2. What is the new volume?$mq$, $mq$["160 cm³","40 cm³","80 cm³","400 cm³"]$mq$, 0, $mq$Volume scales by k³ = 8, so 20 × 8 = 160 cm³.$mq$, $mq$medium$mq$),
($mq$Enlarge the point (1, 3) with scale factor −2 and centre the origin. What is the image?$mq$, $mq$["(2, 6)","(−1, −3)","(−2, 6)","(−2, −6)"]$mq$, 3, $mq$A negative scale factor sends the image to the opposite side of the centre. Multiply each coordinate by −2: (−2, −6).$mq$, $mq$medium$mq$),
($mq$Why can't regular pentagons tessellate?$mq$, $mq$["They have too many sides","Their sides are unequal","Their interior angle of 108° does not divide 360°","Their interior angle is 120°"]$mq$, 2, $mq$Interior angle = 108°. 360 ÷ 108 = 3.33, not a whole number, so copies would leave a gap or overlap.$mq$, $mq$medium$mq$),
($mq$Triangle ABC has area 12 cm² and is enlarged to give a similar triangle of area 75 cm². What is the scale factor?$mq$, $mq$["6.25","2.5","5.2","63"]$mq$, 1, $mq$Area factor = 75 ÷ 12 = 6.25. The linear scale factor is the square root: √6.25 = 2.5.$mq$, $mq$medium$mq$),
($mq$A regular octagon has interior angle 135°. Which shape combines with octagons to tessellate?$mq$, $mq$["Square","Triangle","Pentagon","Hexagon"]$mq$, 0, $mq$At each vertex 135° + 135° + 90° = 360°, so two octagons and one square fit exactly.$mq$, $mq$medium$mq$),
($mq$A model of a building at scale 1:50 has volume 40 cm³. What is the real volume in m³?$mq$, $mq$["2000 m³","0.8 m³","500 m³","5 m³"]$mq$, 3, $mq$Volume scale factor = 50³ = 125 000. Real volume = 40 × 125 000 = 5 000 000 cm³ = 5 m³ (1 m³ = 1 000 000 cm³).$mq$, $mq$hard$mq$),
($mq$An enlargement with scale factor 3 maps A(1, 3) to A'(5, 5). Find the centre of enlargement.$mq$, $mq$["(3, 4)","(1, 1)","(−1, 2)","(2, 1)"]$mq$, 2, $mq$If the centre is C then A' = C + 3(A − C), so C = (3A − A') ÷ 2 = ((3 − 5) ÷ 2, (9 − 5) ÷ 2) = (−1, 2).$mq$, $mq$hard$mq$),
($mq$Each interior angle of a regular polygon is 144°. How many sides does it have?$mq$, $mq$["8","10","9","12"]$mq$, 1, $mq$Interior angle = 180°(n − 2) ÷ n. 144n = 180n − 360, so 36n = 360 and n = 10. It does not tessellate alone because 360 ÷ 144 = 2.5.$mq$, $mq$hard$mq$),
($mq$A floor plan is drawn to a scale of 1:200. A room has an area of 30 cm² on the plan. What is the real area in m²?$mq$, $mq$["120 m²","6000 m²","600 m²","1.5 m²"]$mq$, 0, $mq$Area scale factor = 200² = 40 000. Real area = 30 × 40 000 = 1 200 000 cm². Divide by 10 000 to convert to m²: 120 m².$mq$, $mq$hard$mq$),
($mq$Which combination of regular polygons fits exactly around a point with no gaps?$mq$, $mq$["2 pentagons and 1 square","3 squares and 1 hexagon","1 triangle, 1 square and 1 hexagon","4 triangles and 1 hexagon"]$mq$, 3, $mq$4 × 60° + 120° = 360°. The others give 306°, 390° and 270°.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Enlargement and Tessellations$mq$ and p.name = $mq$Further Geometry and Trigonometry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Enlargement needs...$mq$, $mq$A centre of enlargement and a scale factor k. Lengths multiply by k; angles stay the same.$mq$),
($mq$Scale factor from object and image$mq$, $mq$k = image length ÷ object length.$mq$),
($mq$Area and volume scale factors$mq$, $mq$Area × k², volume × k³. For scale 1:50 the volume factor is 50³ = 125 000.$mq$),
($mq$Negative scale factor$mq$, $mq$The image lies on the opposite side of the centre and is inverted. Size is multiplied by |k|.$mq$),
($mq$Enlarging from the origin$mq$, $mq$Multiply each coordinate by k: (3, 4) with k = 2 becomes (6, 8).$mq$),
($mq$Enlargement about another centre C$mq$, $mq$Image = C + k × (point − C).$mq$),
($mq$Interior angle of a regular n-gon$mq$, $mq$180°(n − 2) ÷ n. Hexagon 120°, octagon 135°, decagon 144°.$mq$),
($mq$Condition for a tessellation$mq$, $mq$No gaps or overlaps, so the angles at each vertex sum to 360°.$mq$),
($mq$Regular polygons that tessellate alone$mq$, $mq$Equilateral triangle, square and regular hexagon.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Enlargement and Tessellations$mq$ and p.name = $mq$Further Geometry and Trigonometry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Enlargement
An **enlargement** changes the size of a shape but keeps its angles the same, so the image is similar to the original. You need two things: a **scale factor** k and a **centre of enlargement**. Every length is multiplied by k.
- k > 1: the image is bigger.
- 0 < k < 1: the image is smaller (a reduction).
- k < 0: the image is on the opposite side of the centre and is upside down.

## Enlargement with coordinates
If the centre is the origin, multiply both coordinates by k: (3, 4) with k = 2 becomes (6, 8). For another centre C, find the vector from C to the point, multiply it by k, and add it to C. Example: centre (1, 1), k = 3, point (2, 3). Vector = (1, 2), times 3 = (3, 6), so the image is (4, 7).
To find the centre: draw lines from corresponding points through each other. They meet at the centre. With algebra, C = (kA − A') ÷ (k − 1).

## Scale factors for length, area and volume
- Length scales by k.
- Area scales by k².
- Volume scales by k³.
Examples: scale factor 3 turns 5 cm² into 45 cm². Scale factor 2 turns 20 cm³ into 160 cm³. For a model at scale 1:50, the real volume is 50³ = 125 000 times bigger. If you are given area factors, take the square root to get k: areas 12 and 75 give k = √6.25 = 2.5.
Convert units at the end. 1 m² = 10 000 cm² and 1 m³ = 1 000 000 cm³.

## Tessellations
A **tessellation** is a pattern of shapes that fit together with no gaps and no overlaps. The angles at every vertex must add to 360°.
For a regular polygon with n sides, the interior angle is 180°(n − 2) ÷ n.
- Triangle 60°, square 90°, hexagon 120°: these divide 360° exactly, so they tessellate alone.
- Pentagon 108° and octagon 135°: they do not.
Combinations can work: two octagons and a square (135 + 135 + 90 = 360), or four triangles and a hexagon (4 × 60 + 120 = 360). Any triangle or quadrilateral, even irregular ones, will tessellate because their angles total 180° or 360°.
To describe a tessellation, state the shapes, how they are arranged at a vertex and the transformations used (translation, rotation or reflection).

## Common mistakes
- Applying the length scale factor to areas or volumes.
- Measuring the scale factor from the image to the object, which gives its reciprocal.
- Forgetting that a fractional scale factor still counts as an enlargement.
- Saying any shape of the same type tessellates.

## How this is examined
Tasks use models, maps, floor plans, tiling and design contexts. You work out the scale factor, apply it to lengths, areas or volumes, convert units, then judge whether a pattern of tiles or paving stones would work and justify your reasoning with angle sums.

Exam tip: Write k, k² or k³ before multiplying so you do not mix up which quantity you are scaling. Scale factors for area and volume appear often in context questions.$mq$ from st;

-- Further Statistics and Probability > Cumulative Frequency, Box Plots and IQR
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Further Statistics and Probability$mq$, 5, 3 from public.subjects s where s.slug = $mq$standard-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Cumulative Frequency, Box Plots and IQR$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$standard-mathematics$mq$ and p.grade = 5 and p.name = $mq$Further Statistics and Probability$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Cumulative Frequency, Box Plots and IQR$mq$ and p.name = $mq$Further Statistics and Probability$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the median of 3, 5, 7, 9, 11?$mq$, $mq$["7","5","9","35"]$mq$, 0, $mq$With five ordered values the median is the middle (3rd) value: 7.$mq$, $mq$easy$mq$),
($mq$The smallest value in a data set is 4 and the largest is 19. What is the range?$mq$, $mq$["23","11.5","19","15"]$mq$, 3, $mq$Range = largest − smallest = 19 − 4 = 15.$mq$, $mq$easy$mq$),
($mq$What does the last value on a cumulative frequency table equal?$mq$, $mq$["The median","The largest class width","The total number of data values","The mean"]$mq$, 2, $mq$Cumulative frequency adds up as you go, so the last entry is the total frequency.$mq$, $mq$easy$mq$),
($mq$Which expression gives the interquartile range?$mq$, $mq$["Q3 + Q1","Q3 − Q1","Max − Min","Q2 − Q1"]$mq$, 1, $mq$IQR is the spread of the middle 50% of data: upper quartile minus lower quartile.$mq$, $mq$easy$mq$),
($mq$For n values, at which cumulative frequency value do you read the median from the curve?$mq$, $mq$["n/2","n/4","3n/4","n"]$mq$, 0, $mq$The median is the middle value, which sits at the cumulative frequency n/2.$mq$, $mq$easy$mq$),
($mq$Data: 12, 15, 17, 18, 20, 22, 25, 28, 30, 35. Using the middle of each half, find the interquartile range.$mq$, $mq$["23","10.5","13","11"]$mq$, 3, $mq$Lower half 12, 15, 17, 18, 20 gives Q1 = 17. Upper half 22, 25, 28, 30, 35 gives Q3 = 28. IQR = 28 − 17 = 11.$mq$, $mq$medium$mq$),
($mq$Test marks: 0–10: 4 students, 10–20: 9, 20–30: 15, 30–40: 12. In which class does the median lie?$mq$, $mq$["10–20","0–10","20–30","30–40"]$mq$, 2, $mq$The cumulative frequencies are 4, 13, 28, 40. The median is around the 20th student, which falls in the 20–30 class because 13 < 20 ≤ 28.$mq$, $mq$medium$mq$),
($mq$80 students sit a test. At which cumulative frequencies do you read the lower and upper quartiles from the curve?$mq$, $mq$["10 and 30","20 and 60","40 and 80","25 and 75"]$mq$, 1, $mq$Q1 is at n/4 = 20 and Q3 is at 3n/4 = 60. The percentages 25 and 75 would be used on a percentage cumulative frequency axis.$mq$, $mq$medium$mq$),
($mq$Q1 = 20 and Q3 = 32. A value is an outlier if it is more than 1.5 × IQR above Q3. What is the upper boundary?$mq$, $mq$["50","38","44","68"]$mq$, 0, $mq$IQR = 12 and 1.5 × 12 = 18. Upper boundary = 32 + 18 = 50.$mq$, $mq$medium$mq$),
($mq$Class A scores have median 62 and IQR 10. Class B has median 62 and IQR 22. What can you conclude?$mq$, $mq$["Class B did better overall","Class A's marks are more spread out","The classes have identical results","Class B's marks are more spread out"]$mq$, 3, $mq$Equal medians show similar typical performance. The larger IQR means class B's middle 50% is more spread out.$mq$, $mq$medium$mq$),
($mq$80 students were tested. A cumulative frequency curve shows that 52 students scored 30 marks or less. How many scored more than 30?$mq$, $mq$["52","30","28","132"]$mq$, 2, $mq$Total minus cumulative frequency: 80 − 52 = 28.$mq$, $mq$medium$mq$),
($mq$A box plot has minimum 5, Q1 = 14, median 20, Q3 = 31 and maximum 48. What percentage of values lie between 14 and 31?$mq$, $mq$["25%","50%","75%","100%"]$mq$, 1, $mq$Q1 to Q3 contains the middle half of the data. The IQR here is 17.$mq$, $mq$medium$mq$),
($mq$In a bus company, route A journey times have median 24 min and IQR 6 min. Route B has median 26 min and IQR 14 min. Which route is more reliable and why?$mq$, $mq$["Route A: smaller IQR means times are more consistent","Route B: higher median","Route A: lower maximum","Route B: larger IQR means more consistent"]$mq$, 0, $mq$A smaller IQR means the typical journey times vary less. Route A also has the lower median.$mq$, $mq$medium$mq$),
($mq$Using the table: 0–10: 4, 10–20: 9, 20–30: 15, 30–40: 12, estimate the median by linear interpolation to 1 decimal place.$mq$, $mq$["25.0","20.0","23.3","24.7"]$mq$, 3, $mq$There are 40 values, so the median is the 20th. 13 values lie below 20, so we need 7 more from the 15 in the 20–30 class: 20 + (7/15) × 10 = 24.7.$mq$, $mq$hard$mq$),
($mq$The ordered data 4, 6, 8, 10, 12, 14, 16 gains a new value, 40. Which statistic is unchanged?$mq$, $mq$["The range","The median","The interquartile range","The mean"]$mq$, 2, $mq$Before: Q1 = 6, Q3 = 14, IQR = 8. After adding 40 (n = 8): Q1 = 7, Q3 = 15, IQR = 8. The range jumps from 12 to 36, the median goes from 10 to 11, and the mean also changes.$mq$, $mq$hard$mq$),
($mq$Q1 = 34 and Q3 = 46. How many of the values 12, 20, 60 and 70 are outliers using the 1.5 × IQR rule?$mq$, $mq$["1","2","3","4"]$mq$, 1, $mq$IQR = 12, so the fences are 34 − 18 = 16 and 46 + 18 = 64. 12 and 70 are beyond them; 20 and 60 are not.$mq$, $mq$hard$mq$),
($mq$120 runners finish a race. Q1 = 42 minutes and Q3 = 58 minutes. How many runners finished between 42 and 58 minutes?$mq$, $mq$["60","30","16","90"]$mq$, 0, $mq$Q1 is at the 30th runner and Q3 at the 90th. The runners between them are 90 − 30 = 60, which is half of 120.$mq$, $mq$hard$mq$),
($mq$A box plot has Q1 = 14, median = 20 and Q3 = 40. What does it suggest about the distribution?$mq$, $mq$["Symmetrical","Negatively skewed","All values equal","Positively skewed (longer upper tail)"]$mq$, 3, $mq$The median is much closer to Q1 than to Q3, so the upper half is more spread out. This is positive skew.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Cumulative Frequency, Box Plots and IQR$mq$ and p.name = $mq$Further Statistics and Probability$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Interquartile range$mq$, $mq$IQR = Q3 − Q1. The spread of the middle 50% of the data; not affected by outliers.$mq$),
($mq$Reading a cumulative frequency curve$mq$, $mq$For n values: median at n/2, Q1 at n/4, Q3 at 3n/4.$mq$),
($mq$Plotting cumulative frequency$mq$, $mq$Plot against the UPPER class boundary, then join with a smooth curve.$mq$),
($mq$Five-number summary$mq$, $mq$Minimum, Q1, median, Q3, maximum. These make a box plot.$mq$),
($mq$Outlier rule$mq$, $mq$Outlier if below Q1 − 1.5 × IQR or above Q3 + 1.5 × IQR.$mq$),
($mq$Positive skew in a box plot$mq$, $mq$Median close to Q1, longer upper whisker or box: the upper half is more spread out.$mq$),
($mq$Comparing two data sets$mq$, $mq$Compare one average (median) and one spread (IQR or range), and write in context.$mq$),
($mq$Number of values above a reading$mq$, $mq$Total frequency − cumulative frequency at that value.$mq$),
($mq$Estimating a median from grouped data$mq$, $mq$Interpolate: lower boundary + (needed ÷ class frequency) × class width.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Cumulative Frequency, Box Plots and IQR$mq$ and p.name = $mq$Further Statistics and Probability$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Summarising spread
Averages tell you the middle; **spread** tells you how consistent the data is. The **range** (max − min) uses only two values, so one extreme value can change it a lot. The **interquartile range (IQR)** measures the spread of the middle 50% and is not affected by outliers.

## Quartiles
Order the data. The **median** (Q2) splits it in two halves. The **lower quartile** Q1 is the median of the lower half, and the **upper quartile** Q3 is the median of the upper half. For 12, 15, 17, 18, 20, 22, 25, 28, 30, 35: Q1 = 17, median = 21, Q3 = 28, and IQR = Q3 − Q1 = 11.

## Cumulative frequency
A cumulative frequency table adds frequencies as you go, so the last value is the total. Plot the cumulative frequency against the **upper class boundary** and join the points with a smooth curve.
To read values from the curve for n data values:
- Median: read across at n/2.
- Q1: read across at n/4.
- Q3: read across at 3n/4.
For 80 students the readings are at 40, 20 and 60. To find how many scored more than 30 marks, read the cumulative frequency at 30 and subtract it from the total: 80 − 52 = 28.
Estimate a median from a table by interpolation: with 40 values the median is the 20th. If 13 values lie below 20 and the class 20–30 holds 15, we move 7/15 of the way across: 20 + (7/15) × 10 = 24.7.

## Box plots
A box plot shows five numbers: minimum, Q1, median, Q3 and maximum. The box covers the middle 50% and the whiskers show the rest. Equal lengths either side of the median suggest a symmetrical distribution. If the median is closer to Q1 and the upper whisker is longer, the data is **positively skewed**.

## Outliers
A common rule marks a value as an outlier if it is more than 1.5 × IQR below Q1 or above Q3. With Q1 = 20 and Q3 = 32, IQR = 12, so the upper fence is 32 + 18 = 50. Outliers are plotted as separate crosses.

## Comparing data sets
Compare one measure of average (usually the median) and one measure of spread (usually the IQR). Example: Class A has median 62 and IQR 10, class B has median 62 and IQR 22. The typical marks are the same but class A is more consistent. Always write your comparison in context, for example "route A is more reliable because its journey times vary less".

## Common mistakes
- Plotting cumulative frequency at the class midpoint instead of the upper boundary.
- Reading the median at the wrong height, such as at the total instead of half the total.
- Treating IQR as Q1 + Q3, or the range between the whiskers.
- Comparing only averages without a comment on spread.

## How this is examined
Tasks show data in a context, such as waiting times, battery life, ages at a fair or heights of seedlings, and ask for a cumulative frequency curve and box plot. You compare two groups using median and IQR, decide whether a value is an outlier, and justify a recommendation.

Exam tip: Write the five-number summary down first. Then every later part, from IQR to outlier test to comparison, is quick, and your working is easy to follow.$mq$ from st;

-- Further Statistics and Probability > Histograms and Standard Deviation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Further Statistics and Probability$mq$, 5, 3 from public.subjects s where s.slug = $mq$standard-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Histograms and Standard Deviation$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$standard-mathematics$mq$ and p.grade = 5 and p.name = $mq$Further Statistics and Probability$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Histograms and Standard Deviation$mq$ and p.name = $mq$Further Statistics and Probability$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$How is frequency density calculated?$mq$, $mq$["Frequency ÷ class width","Frequency × class width","Class width ÷ frequency","Frequency ÷ total"]$mq$, 0, $mq$Frequency density = frequency ÷ class width. The area of a bar then equals the frequency.$mq$, $mq$easy$mq$),
($mq$In a histogram with unequal class widths, what represents the frequency of a class?$mq$, $mq$["The height of the bar","The width of the bar","The bar's position","The area of the bar"]$mq$, 3, $mq$Because widths vary, the vertical axis shows frequency density, and the area (width × height) equals the frequency.$mq$, $mq$easy$mq$),
($mq$What does the standard deviation measure?$mq$, $mq$["The most common value","The middle value","How spread out the data is around the mean","The total of all values"]$mq$, 2, $mq$Standard deviation describes the typical distance of values from the mean.$mq$, $mq$easy$mq$),
($mq$Two data sets have the same mean. Set A has standard deviation 2 and set B has standard deviation 9. Which is more spread out?$mq$, $mq$["Set A","Set B","They are equally spread out","It cannot be said"]$mq$, 1, $mq$A larger standard deviation means the values are more widely spread around the mean.$mq$, $mq$easy$mq$),
($mq$The class 10–20 has frequency 30. What is its frequency density?$mq$, $mq$["3","300","0.3","30"]$mq$, 0, $mq$Class width = 10, so frequency density = 30 ÷ 10 = 3.$mq$, $mq$easy$mq$),
($mq$The class 20–40 has frequency 50. Find the frequency density.$mq$, $mq$["1000","0.4","30","2.5"]$mq$, 3, $mq$Class width = 20, so 50 ÷ 20 = 2.5.$mq$, $mq$medium$mq$),
($mq$A histogram bar has frequency density 4 and class width 5. What is the frequency?$mq$, $mq$["0.8","9","20","1.25"]$mq$, 2, $mq$Frequency = frequency density × class width = 4 × 5 = 20.$mq$, $mq$medium$mq$),
($mq$The data 2, 4, 4, 4, 5, 5, 7, 9 has mean 5. What is its standard deviation (population)?$mq$, $mq$["4","2","3.5","1.5"]$mq$, 1, $mq$Squared deviations: 9, 1, 1, 1, 0, 0, 4, 16 total 32. Variance = 32 ÷ 8 = 4. Standard deviation = √4 = 2.$mq$, $mq$medium$mq$),
($mq$Find the standard deviation of 3, 5, 7 (population formula) to 2 decimal places.$mq$, $mq$["1.63","2.00","2.67","8.00"]$mq$, 0, $mq$The mean is 5. Squared deviations 4, 0, 4 add to 8. Variance = 8 ÷ 3 = 2.67 and standard deviation = √2.67 = 1.63. The variance 2.67 is not the standard deviation.$mq$, $mq$medium$mq$),
($mq$A data set has standard deviation 4. Every value is increased by 10 and then multiplied by 3. What is the new standard deviation?$mq$, $mq$["42","16","4","12"]$mq$, 3, $mq$Adding a constant does not change the spread. Multiplying by 3 multiplies the standard deviation by 3: 4 × 3 = 12.$mq$, $mq$medium$mq$),
($mq$Class A scores: mean 60, standard deviation 4. Class B scores: mean 60, standard deviation 12. What is a valid conclusion?$mq$, $mq$["Class B's scores are more consistent","Class A scored higher on average","Class A's scores are more consistent","Class B has a lower mean"]$mq$, 2, $mq$The means are equal. The smaller standard deviation in class A shows its scores cluster closer to the mean.$mq$, $mq$medium$mq$),
($mq$In a histogram, the class 10–30 has a bar of height 2.5 (frequency density). What is the frequency of this class?$mq$, $mq$["2.5","50","12.5","25"]$mq$, 1, $mq$Width = 20. Frequency = 2.5 × 20 = 50.$mq$, $mq$medium$mq$),
($mq$Grouped data: 0–10: 4 values, 10–20: 6 values, 20–30: 10 values. Estimate the mean using class midpoints.$mq$, $mq$["18","20","15","12.5"]$mq$, 0, $mq$Midpoints 5, 15, 25. Sum of f × midpoint = 20 + 90 + 250 = 360. Mean = 360 ÷ 20 = 18.$mq$, $mq$medium$mq$),
($mq$Find the standard deviation of 6, 8, 10, 12, 14 (population) to 2 decimal places.$mq$, $mq$["8.00","2.00","3.16","2.83"]$mq$, 3, $mq$The mean is 10. Deviations squared: 16, 4, 0, 4, 16 total 40. Variance 8 and standard deviation √8 = 2.83. The variance 8 is not the standard deviation.$mq$, $mq$hard$mq$),
($mq$In a histogram, the bar for 20–25 has frequency density 6 and the bar for 25–40 has frequency density 2. How many values are in the range 20–40 altogether?$mq$, $mq$["8","120","60","12"]$mq$, 2, $mq$The 20–25 class has 6 × 5 = 30 values and 25–40 has 2 × 15 = 30 values. Total 60.$mq$, $mq$hard$mq$),
($mq$Test scores have mean 70 and standard deviation 5. Every score is multiplied by 1.1 and then 2 marks are added. What are the new mean and standard deviation?$mq$, $mq$["Mean 79, standard deviation 7.5","Mean 79, standard deviation 5.5","Mean 77, standard deviation 5","Mean 79, standard deviation 5"]$mq$, 1, $mq$Mean: 70 × 1.1 + 2 = 79. Standard deviation: only the multiplication changes it, 5 × 1.1 = 5.5. Adding 2 has no effect.$mq$, $mq$hard$mq$),
($mq$A student scored 82. The class mean is 70 and the standard deviation is 4. How many standard deviations above the mean is this score?$mq$, $mq$["3","12","0.33","18"]$mq$, 0, $mq$(82 − 70) ÷ 4 = 3 standard deviations above the mean.$mq$, $mq$hard$mq$),
($mq$A histogram has bars: 0–5 with frequency density 2, 5–15 with frequency density 3, and 15–20 with frequency density 1. In which class does the median lie?$mq$, $mq$["0–5","15–20","It cannot be found","5–15"]$mq$, 3, $mq$Frequencies: 10, 30 and 5, so the total is 45. The median is the 22.5th value. After 0–5 there are 10, after 5–15 there are 40, so the median is in 5–15.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Histograms and Standard Deviation$mq$ and p.name = $mq$Further Statistics and Probability$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Frequency density$mq$, $mq$Frequency ÷ class width. It is the height of a histogram bar.$mq$),
($mq$Area in a histogram$mq$, $mq$The area of each bar = the frequency of that class (width × frequency density).$mq$),
($mq$Estimated mean from grouped data$mq$, $mq$Σ(f × midpoint) ÷ Σf. It is an estimate because the exact values are unknown.$mq$),
($mq$Standard deviation$mq$, $mq$A measure of spread around the mean. Smaller SD = more consistent data.$mq$),
($mq$Steps to find SD$mq$, $mq$Mean → squared deviations → average them (variance) → square root.$mq$),
($mq$Variance vs SD$mq$, $mq$Variance = SD². Always take the square root at the end.$mq$),
($mq$Effect of adding a constant$mq$, $mq$Mean changes by the constant; standard deviation is unchanged.$mq$),
($mq$Effect of multiplying by k$mq$, $mq$Both the mean and the standard deviation are multiplied by k.$mq$),
($mq$Comparing two data sets$mq$, $mq$Use a mean (or median) for average and SD (or IQR) for spread, and refer to the context.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Histograms and Standard Deviation$mq$ and p.name = $mq$Further Statistics and Probability$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Histograms with unequal class widths
A bar chart for grouped data works fine when every class has the same width. When classes have **different widths**, you must draw a **histogram**, where the vertical axis is **frequency density** and the AREA of each bar is the frequency.
- Frequency density = frequency ÷ class width
- Frequency = frequency density × class width
Example: class 20–40 has 50 values. Width 20, so density is 50 ÷ 20 = 2.5. A bar of height 2.5 over a width of 20 has area 50. If you plot raw frequency instead of density, wide classes look unfairly large.
To find the total from a histogram, work out each frequency (height × width) and add them. For bars of density 6 over width 5 and density 2 over width 15 the total is 30 + 30 = 60. To locate the median, find the total, halve it, and use the running total to see which class holds it.

## Estimating the mean from grouped data
You do not know the actual values, so use the class midpoint. Mean ≈ Σ(f × midpoint) ÷ Σf. For classes 0–10, 10–20, 20–30 with frequencies 4, 6, 10 the midpoints are 5, 15, 25, so the estimate is (20 + 90 + 250) ÷ 20 = 18. It is only an estimate.

## Standard deviation
The **standard deviation** (SD) tells you how far values typically lie from the mean. A small SD means the data is bunched up; a large SD means it is spread out.
Steps for a small data set:
1. Find the mean.
2. Find each deviation (value − mean) and square it.
3. Add the squares and divide by the number of values. This is the variance.
4. Take the square root.
Example: 3, 5, 7. Mean 5. Squared deviations 4, 0, 4. Variance 8 ÷ 3 = 2.67. SD = 1.63. Calculators have an SD function, so know how to find σ on yours (the population standard deviation).

## What happens to SD when data changes
- Adding the same number to every value: mean changes, SD stays the same.
- Multiplying every value by k: mean and SD both multiply by k.
This is why SD measures spread, not position.

## Interpreting SD
Compare two data sets using mean and SD together. Two machines both fill bottles with mean 500 mL. If machine A has SD 2 mL and machine B has SD 7 mL, machine A is more reliable because its output varies less. You can also say how many SDs a value lies from the mean: a score of 82 with mean 70 and SD 4 is 3 SDs above the mean, which is unusually high.

## Common mistakes
- Plotting frequency on the vertical axis of a histogram with unequal widths.
- Mixing up variance and standard deviation. SD is the square root of variance.
- Forgetting to divide by the number of values.
- Saying a larger SD means a higher mean.

## How this is examined
Tasks give a table of grouped data such as ages, masses, times or lengths of manufactured parts. You calculate frequency densities, draw or read a histogram, estimate a mean, and compare two sets using SD. The top levels ask you to evaluate whether a machine or process is acceptable.

Exam tip: When a question gives bars with different widths, immediately add a column to your table for frequency density, and later add one for area. It prevents the most common error.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('standard-mathematics')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;