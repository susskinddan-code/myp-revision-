-- Part 3 of 3: 1 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Number and Indices > Number Systems, Sets and Notation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Number and Indices$mq$, 5, 6 from public.subjects s where s.slug = $mq$extended-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Number Systems, Sets and Notation$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$extended-mathematics$mq$ and p.grade = 5 and p.name = $mq$Number and Indices$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Number Systems, Sets and Notation$mq$ and p.name = $mq$Number and Indices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which set of numbers contains −3 but does not contain 1/2?$mq$, $mq$["The integers, ℤ","The natural numbers, ℕ","The rational numbers, ℚ","The real numbers, ℝ"]$mq$, 0, $mq$ℤ contains whole numbers including negatives, but not fractions. ℕ has no negatives, while ℚ and ℝ contain both −3 and 1/2.$mq$, $mq$easy$mq$),
($mq$Which statement about √2 is correct?$mq$, $mq$["It is rational because it has a square root sign","It is rational because it equals 1.4","It is an integer","It is irrational, because it cannot be written as a fraction of two integers"]$mq$, 3, $mq$√2 = 1.41421... never ends and never repeats, so it is irrational. 1.4 is only a rounded value.$mq$, $mq$easy$mq$),
($mq$A = {1, 2, 3, 4} and B = {3, 4, 5}. What is A ∩ B?$mq$, $mq$["{1, 2, 3, 4, 5}","{1, 2}","{3, 4}","{5}"]$mq$, 2, $mq$The intersection contains the elements that are in both sets, which are 3 and 4. The set {1, 2, 3, 4, 5} is the union A ∪ B.$mq$, $mq$easy$mq$),
($mq$A = {1, 2, 3, 4} and B = {3, 4, 5}. What is A ∪ B?$mq$, $mq$["{3, 4}","{1, 2, 3, 4, 5}","{1, 2, 5}","{1, 2, 3, 3, 4, 4, 5}"]$mq$, 1, $mq$The union contains everything that is in A or B or both. Each element is listed once.$mq$, $mq$easy$mq$),
($mq$What does the symbol ∈ mean in 7 ∈ ℕ?$mq$, $mq$["7 is an element of the natural numbers","7 is a subset of the natural numbers","7 is not an element of the natural numbers","7 is less than the natural numbers"]$mq$, 0, $mq$The symbol ∈ means "is an element of". The symbol ⊂ is used when one set is inside another set.$mq$, $mq$easy$mq$),
($mq$What fraction is equal to the recurring decimal 0.777... (written 0.7̇)?$mq$, $mq$["7/10","77/100","7/90","7/9"]$mq$, 3, $mq$Let x = 0.777.... Then 10x = 7.777..., so 9x = 7 and x = 7/9. The fraction 7/10 is only 0.7, which does not recur.$mq$, $mq$medium$mq$),
($mq$Of 40 students, 25 play football, 18 play basketball and 8 play both. How many play neither?$mq$, $mq$["0","7","5","13"]$mq$, 2, $mq$The number playing at least one sport is 25 + 18 − 8 = 35. Then 40 − 35 = 5 play neither. Without subtracting the 8, the students who play both are counted twice.$mq$, $mq$medium$mq$),
($mq$In the same group (40 students, 25 football, 18 basketball, 8 both), how many play basketball only?$mq$, $mq$["18","10","7","17"]$mq$, 1, $mq$Basketball only = 18 − 8 = 10, because the 8 who play both are not 'only' basketball. The number 17 is football only.$mq$, $mq$medium$mq$),
($mq$The universal set is U = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10} and A is the set of even numbers in U. What is A′, the complement of A?$mq$, $mq$["{1, 3, 5, 7, 9}","{2, 4, 6, 8, 10}","{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}","{3, 5, 7}"]$mq$, 0, $mq$A′ contains the elements of U that are not in A, which are the odd numbers. {3, 5, 7} leaves out 1 and 9.$mq$, $mq$medium$mq$),
($mq$How many integers are in the set {x ∈ ℤ : −2 < x ≤ 5}?$mq$, $mq$["8","6","5","7"]$mq$, 3, $mq$Since −2 < x, −2 is not included, but 5 is. The integers are −1, 0, 1, 2, 3, 4 and 5, so there are 7.$mq$, $mq$medium$mq$),
($mq$Which of these numbers is irrational?$mq$, $mq$["√16","22/7","√20","0.25"]$mq$, 2, $mq$√16 = 4 and 0.25 = 1/4 are rational, as is 22/7, which is a fraction. √20 is not a perfect square, so it is irrational.$mq$, $mq$medium$mq$),
($mq$Which chain correctly shows how the number sets fit inside each other?$mq$, $mq$["ℚ ⊂ ℤ ⊂ ℕ ⊂ ℝ","ℕ ⊂ ℤ ⊂ ℚ ⊂ ℝ","ℤ ⊂ ℕ ⊂ ℚ ⊂ ℝ","ℝ ⊂ ℚ ⊂ ℤ ⊂ ℕ"]$mq$, 1, $mq$Every natural number is an integer, every integer is rational (n = n/1) and every rational number is real. The larger sets contain the smaller ones.$mq$, $mq$medium$mq$),
($mq$Set A has 14 elements and Set B has 11 elements. Five elements are in both. What is n(A ∪ B)?$mq$, $mq$["20","25","30","19"]$mq$, 0, $mq$n(A ∪ B) = n(A) + n(B) − n(A ∩ B) = 14 + 11 − 5 = 20. Adding 14 + 11 = 25 counts the shared elements twice.$mq$, $mq$medium$mq$),
($mq$Which fraction equals the recurring decimal 0.1222... (0.12̇)?$mq$, $mq$["11/99","12/99","11/100","11/90"]$mq$, 3, $mq$Write it as 0.1 + 0.0222... = 1/10 + 2/90 = 9/90 + 2/90 = 11/90. Check with a calculator: 11 ÷ 90 = 0.12222...$mq$, $mq$hard$mq$),
($mq$A = {x ∈ ℤ : x² < 20}. What is n(A)?$mq$, $mq$["8","4","9","10"]$mq$, 2, $mq$The squares less than 20 come from x = −4, −3, −2, −1, 0, 1, 2, 3, 4 since 4² = 16 but 5² = 25. That is 9 elements. Forgetting the negatives or zero gives the wrong count.$mq$, $mq$hard$mq$),
($mq$A student claims: "The product of two irrational numbers is always irrational." Which example shows the claim is false?$mq$, $mq$["√2 × √3 = √6","√2 × √8 = 4","π × 2 = 2π","√7 × 3 = 3√7"]$mq$, 1, $mq$√2 and √8 are irrational, but √2 × √8 = √16 = 4, which is rational. One counterexample is enough to disprove a general claim.$mq$, $mq$hard$mq$),
($mq$U = {1, 2, 3, ..., 12}, A is the set of multiples of 2 and B is the set of multiples of 3. What is n((A ∪ B)′)?$mq$, $mq$["4","8","6","3"]$mq$, 0, $mq$A ∪ B = {2, 3, 4, 6, 8, 9, 10, 12}, which has 8 elements. The complement has 12 − 8 = 4 elements: 1, 5, 7 and 11.$mq$, $mq$hard$mq$),
($mq$In a group of 40 students, 18 study Art, 15 study Music and 12 study Drama. 6 study Art and Music, 5 study Art and Drama, 4 study Music and Drama, and 2 study all three. How many study none of the three?$mq$, $mq$["5","9","10","8"]$mq$, 3, $mq$Using inclusion and exclusion, n(A ∪ M ∪ D) = 18 + 15 + 12 − 6 − 5 − 4 + 2 = 32. So 40 − 32 = 8 study none. Forgetting to add back the 2 students in all three gives 6.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Number Systems, Sets and Notation$mq$ and p.name = $mq$Number and Indices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$ℕ, ℤ, ℚ, ℝ$mq$, $mq$Natural numbers, integers, rational numbers, real numbers, with ℕ ⊂ ℤ ⊂ ℚ ⊂ ℝ.$mq$),
($mq$Rational number$mq$, $mq$A number that can be written as a/b with a and b integers and b ≠ 0. Includes terminating and recurring decimals.$mq$),
($mq$Irrational number$mq$, $mq$A decimal that never ends or repeats, such as √2 or π. It cannot be written as a fraction.$mq$),
($mq$∈ and ⊂$mq$, $mq$∈ means "is an element of". ⊂ means "is a subset of".$mq$),
($mq$∪ and ∩$mq$, $mq$∪ (union): in A or B or both. ∩ (intersection): in both A and B.$mq$),
($mq$A′$mq$, $mq$The complement of A: the elements of the universal set that are not in A.$mq$),
($mq$n(A ∪ B)$mq$, $mq$n(A) + n(B) − n(A ∩ B). Subtract the overlap so it is not counted twice.$mq$),
($mq$Converting 0.777... to a fraction$mq$, $mq$Let x = 0.777..., then 10x = 7.777..., so 9x = 7 and x = 7/9.$mq$),
($mq$Counterexample$mq$, $mq$One example that breaks a general claim, enough to disprove it. For example √2 × √8 = 4 disproves "irrational × irrational is irrational".$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Number Systems, Sets and Notation$mq$ and p.name = $mq$Number and Indices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The number systems
Numbers are grouped into sets, each inside the next.
- **Natural numbers, ℕ**: counting numbers 1, 2, 3, ...
- **Integers, ℤ**: whole numbers including negatives and zero.
- **Rational numbers, ℚ**: any number that can be written as a fraction a/b of two integers (b ≠ 0). This includes terminating decimals such as 0.25 and recurring decimals such as 0.333...
- **Irrational numbers**: decimals that never end or repeat, such as √2 and π.
- **Real numbers, ℝ**: all rational and irrational numbers together.

So ℕ ⊂ ℤ ⊂ ℚ ⊂ ℝ. The roots of numbers that are not perfect squares, such as √20, are irrational, while √16 = 4 is rational.

## Converting recurring decimals
To write 0.777... as a fraction, let x = 0.777.... Multiply by 10 to get 10x = 7.777.... Subtract: 9x = 7, so x = 7/9. For 0.1222..., write it as 0.1 + 0.0222... = 1/10 + 2/90 = 11/90. Always check on a calculator.

## Set notation
- ∈ means "is an element of" and ∉ means "is not an element of".
- ⊂ means "is a subset of".
- ∪ (union) means "in A or B or both".
- ∩ (intersection) means "in both A and B".
- A′ (complement) means "in the universal set U but not in A".
- n(A) means the number of elements in A.
- ∅ is the empty set.

Set-builder notation describes a set by a rule. {x ∈ ℤ : −2 < x ≤ 5} means "all integers x such that x is more than −2 and at most 5", which is {−1, 0, 1, 2, 3, 4, 5}. Read the colon as "such that".

## Venn diagrams and counting
A Venn diagram shows how sets overlap. To count correctly, always start in the middle, where the sets overlap, and work outward. For two sets:
n(A ∪ B) = n(A) + n(B) − n(A ∩ B).
Example: of 40 students, 25 play football, 18 play basketball and 8 play both. Football only is 17, basketball only is 10, both is 8, so 35 play at least one sport and 40 − 35 = 5 play neither.

For three sets you also add back the centre: n(A ∪ B ∪ C) = n(A) + n(B) + n(C) − n(A ∩ B) − n(A ∩ C) − n(B ∩ C) + n(A ∩ B ∩ C).

## Proving and disproving
To disprove a general claim, one counterexample is enough. For example, "the product of two irrational numbers is irrational" is false because √2 × √8 = √16 = 4. To support a claim you need a general argument, not just examples.

## Common mistakes
- Counting the overlap twice and forgetting to subtract it.
- Putting the total (such as 25 football) into the football-only region.
- Including or excluding endpoints wrongly (< versus ≤).
- Confusing ∪ and ∩, or ⊂ and ∈.
- Thinking a rounded decimal such as 1.4 is the same as √2.

## How this is examined
Questions give a survey or a group of people and ask you to complete a Venn diagram, use set notation and interpret the regions in context. Number questions test classification of numbers, recurring decimals and justifying statements. Extended tasks ask you to explain or test a general statement about number types and to check for assumptions such as whether every person belongs to exactly one group.

Exam tip: Fill in the overlap of a Venn diagram first, then check that the regions add up to the total number in the universal set.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('extended-mathematics')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;