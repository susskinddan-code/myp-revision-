-- Part 1 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Number Properties and Time > Factors, Primes, HCF and LCM
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Number Properties and Time$mq$, 5, 1 from public.subjects s where s.slug = $mq$standard-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Factors, Primes, HCF and LCM$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$standard-mathematics$mq$ and p.grade = 5 and p.name = $mq$Number Properties and Time$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Factors, Primes, HCF and LCM$mq$ and p.name = $mq$Number Properties and Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which of these numbers is prime?$mq$, $mq$["59","51","57","91"]$mq$, 0, $mq$51 = 3 × 17, 57 = 3 × 19 and 91 = 7 × 13, so each has a factor other than 1 and itself. 59 has no factors apart from 1 and 59.$mq$, $mq$easy$mq$),
($mq$Write 60 as a product of prime factors.$mq$, $mq$["2 × 3 × 10","2² × 15","4 × 3 × 5","2² × 3 × 5"]$mq$, 3, $mq$Divide by primes: 60 = 2 × 30 = 2 × 2 × 15 = 2 × 2 × 3 × 5. The other options contain 10, 15 or 4, which are not prime.$mq$, $mq$easy$mq$),
($mq$What is the highest common factor (HCF) of 12 and 18?$mq$, $mq$["3","36","6","2"]$mq$, 2, $mq$Factors of 12: 1, 2, 3, 4, 6, 12. Factors of 18: 1, 2, 3, 6, 9, 18. The largest shared factor is 6. 36 is the LCM.$mq$, $mq$easy$mq$),
($mq$What is the lowest common multiple (LCM) of 4 and 6?$mq$, $mq$["24","12","2","10"]$mq$, 1, $mq$Multiples of 4: 4, 8, 12 ... Multiples of 6: 6, 12 ... The first shared multiple is 12. 24 is a common multiple but not the lowest.$mq$, $mq$easy$mq$),
($mq$How many factors does 36 have?$mq$, $mq$["9","8","6","12"]$mq$, 0, $mq$The factors are 1, 2, 3, 4, 6, 9, 12, 18, 36. Nine in total. Because 36 = 6², the factor 6 pairs with itself and is counted once.$mq$, $mq$easy$mq$),
($mq$84 = 2² × 3 × 7 and 126 = 2 × 3² × 7. Use these to find the HCF of 84 and 126.$mq$, $mq$["252","21","84","42"]$mq$, 3, $mq$For the HCF take the lowest power of each shared prime: 2 × 3 × 7 = 42. The LCM would use the highest powers (2² × 3² × 7 = 252).$mq$, $mq$medium$mq$),
($mq$Two buses leave a station together at 08:00. One returns every 12 minutes and the other every 18 minutes. When will they next leave together?$mq$, $mq$["08:06","08:30","08:36","09:00"]$mq$, 2, $mq$We need the LCM of 12 and 18, which is 36. So they leave together again 36 minutes after 08:00, at 08:36.$mq$, $mq$medium$mq$),
($mq$A floor measures 240 cm by 180 cm. It is covered with identical square tiles with no cutting. What is the least number of tiles needed?$mq$, $mq$["20","12","60","24"]$mq$, 1, $mq$The largest square tile has side HCF(240, 180) = 60 cm. Tiles needed: (240 ÷ 60) × (180 ÷ 60) = 4 × 3 = 12.$mq$, $mq$medium$mq$),
($mq$Three lights flash every 6 s, 8 s and 10 s. They all flash together at the start. After how many seconds do they next flash together?$mq$, $mq$["120","24","60","240"]$mq$, 0, $mq$Find LCM(6, 8, 10). 6 = 2 × 3, 8 = 2³, 10 = 2 × 5, so LCM = 2³ × 3 × 5 = 120 seconds.$mq$, $mq$medium$mq$),
($mq$72 = 2³ × 3². What is the smallest whole number that 72 must be multiplied by to give a perfect square?$mq$, $mq$["3","6","4","2"]$mq$, 3, $mq$A square has every prime to an even power. 3² is already even but 2³ is odd. One more factor of 2 gives 2⁴ × 3² = 144 = 12².$mq$, $mq$medium$mq$),
($mq$For 8 and 20 the HCF is 4 and the LCM is 40. What is HCF × LCM, and how does it compare with 8 × 20?$mq$, $mq$["160, bigger than 8 × 20","32, equal to 8 + 20 + 4","160, equal to 8 × 20","80, half of 8 × 20"]$mq$, 2, $mq$For any two numbers, HCF × LCM = the product of the numbers. Here 4 × 40 = 160 = 8 × 20.$mq$, $mq$medium$mq$),
($mq$N = 2³ × 3² × 5. How many factors does N have?$mq$, $mq$["6","24","14","12"]$mq$, 1, $mq$Add 1 to each power and multiply: (3 + 1)(2 + 1)(1 + 1) = 4 × 3 × 2 = 24.$mq$, $mq$medium$mq$),
($mq$Which pair of numbers is coprime (has an HCF of 1)?$mq$, $mq$["15 and 28","14 and 21","12 and 18","20 and 35"]$mq$, 0, $mq$15 = 3 × 5 and 28 = 2² × 7 share no prime. 14 and 21 share 7, 12 and 18 share 6, 20 and 35 share 5.$mq$, $mq$medium$mq$),
($mq$Two numbers a and b have HCF 6 and LCM 180. Given a = 36, find b.$mq$, $mq$["5","60","90","30"]$mq$, 3, $mq$HCF × LCM = a × b, so 6 × 180 = 1080 = 36 × b, giving b = 30. Check: HCF(36, 30) = 6 and LCM = 180.$mq$, $mq$hard$mq$),
($mq$A number leaves remainder 3 when divided by 8, by 12 and by 18. What is the smallest such number bigger than 3?$mq$, $mq$["72","147","75","24"]$mq$, 2, $mq$The number minus 3 must be a multiple of 8, 12 and 18. LCM(8, 12, 18) = 72, so the number is 72 + 3 = 75.$mq$, $mq$hard$mq$),
($mq$What is the largest number that divides 130 leaving remainder 4 and divides 175 leaving remainder 7?$mq$, $mq$["21","42","6","126"]$mq$, 1, $mq$Remove the remainders: 130 − 4 = 126 and 175 − 7 = 168. The divisor is HCF(126, 168) = 42, which is larger than both remainders. Check: 130 = 3 × 42 + 4 and 175 = 4 × 42 + 7.$mq$, $mq$hard$mq$),
($mq$A jeweller has 168 red beads and 120 blue beads. She makes as many identical bracelets as possible using every bead. How many blue beads are on each bracelet?$mq$, $mq$["5","7","24","12"]$mq$, 0, $mq$The number of bracelets is HCF(168, 120) = 24. Each has 168 ÷ 24 = 7 red and 120 ÷ 24 = 5 blue beads.$mq$, $mq$hard$mq$),
($mq$What is the smallest positive integer that has exactly 6 factors?$mq$, $mq$["16","24","30","12"]$mq$, 3, $mq$12 has factors 1, 2, 3, 4, 6, 12, which is six. Every smaller number has a different count. 16 has 5, while 24 and 30 each have 8.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Factors, Primes, HCF and LCM$mq$ and p.name = $mq$Number Properties and Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Prime number$mq$, $mq$A whole number greater than 1 with exactly two factors: 1 and itself. 2 is the only even prime; 1 is not prime.$mq$),
($mq$Prime factorisation of 60$mq$, $mq$60 = 2² × 3 × 5. Use a factor tree and write repeated primes with powers.$mq$),
($mq$HCF from prime factors$mq$, $mq$Multiply the lowest power of each prime common to both numbers.$mq$),
($mq$LCM from prime factors$mq$, $mq$Multiply the highest power of each prime appearing in either number.$mq$),
($mq$HCF × LCM rule$mq$, $mq$For two numbers a and b: HCF × LCM = a × b. It does not work for three numbers.$mq$),
($mq$Number of factors rule$mq$, $mq$Write as primes, add 1 to each power, multiply. 2³ × 3² has 4 × 3 = 12 factors.$mq$),
($mq$When is a number a perfect square?$mq$, $mq$When every prime in its factorisation has an even power. Example: 144 = 2⁴ × 3².$mq$),
($mq$Coprime numbers$mq$, $mq$Two numbers whose HCF is 1, such as 15 and 28. They need not be prime themselves.$mq$),
($mq$Which situations need LCM?$mq$, $mq$Repeating events meeting again (buses, lights, gears). HCF is for splitting into equal groups or the largest equal pieces.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Factors, Primes, HCF and LCM$mq$ and p.name = $mq$Number Properties and Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Factors and multiples are the building blocks of number work. A **factor** of a number divides into it exactly, so the factors of 18 are 1, 2, 3, 6, 9 and 18. A **multiple** is what you get when you multiply by whole numbers, so multiples of 6 are 6, 12, 18, 24 and so on. A **prime number** has exactly two factors, 1 and itself (2, 3, 5, 7, 11, 13 ...). Remember that 1 is not prime and 2 is the only even prime.

## Prime factorisation
Every whole number greater than 1 can be written as a product of primes in exactly one way. Use a factor tree or repeated division. For 252: 252 = 2 × 126 = 2 × 2 × 63 = 2 × 2 × 3 × 21 = 2² × 3² × 7. Write answers with index (power) notation.

## HCF and LCM from prime factors
- **HCF** (highest common factor): the largest number that divides both. Take the lowest power of each prime that appears in BOTH numbers.
- **LCM** (lowest common multiple): the smallest number both divide into. Take the highest power of each prime that appears in EITHER number.

Worked example: 84 = 2² × 3 × 7 and 126 = 2 × 3² × 7.
HCF = 2 × 3 × 7 = 42. LCM = 2² × 3² × 7 = 252.
Check: HCF × LCM = 42 × 252 = 10 584 = 84 × 126. This useful rule, HCF × LCM = a × b, works for two numbers only.

## Counting factors
Write the number as primes, add 1 to each power, then multiply. For 2³ × 3² × 5 the number of factors is 4 × 3 × 2 = 24. A number is a perfect square exactly when every prime power is even.

## Which one do I use?
- Splitting into equal groups, cutting the biggest equal pieces, or fitting square tiles: think HCF.
- Events that repeat and meet again (buses, flashing lights, planets lining up): think LCM.
Example: buses every 12 and 18 minutes leave together every LCM = 36 minutes. A 240 cm by 180 cm floor needs square tiles of side HCF = 60 cm, so 4 × 3 = 12 tiles.

## Remainder problems
If a number leaves remainder r when divided by several numbers, subtract r first, find the LCM, then add r back. If a divisor leaves different remainders, subtract each remainder from its own number and find the HCF of the results.

## Common mistakes
- Calling 1 a prime, or listing 9 or 15 as primes.
- Mixing up HCF and LCM, or giving the LCM as something smaller than one of the numbers. The LCM is never smaller than the larger number and the HCF is never larger than the smaller number.
- Stopping a factor tree before every branch is prime.
- Using the lowest powers for the LCM instead of the highest.

## How this is examined
Real eAssessment tasks wrap this topic in a context such as a timetable, a tiling job, packing items into boxes or planning a repeating event. You pull the numbers out of the situation, decide whether HCF or LCM is needed, and calculate. Later parts may ask you to show that a number is prime or justify why a pattern repeats. Always show the prime factorisation, state which method you used and finish with a sentence that answers the context.

Exam tip: Write both numbers as products of primes in a neat table first, then choose lowest powers (HCF) or highest powers (LCM); finish by checking that your answer divides, or is divisible by, both numbers.$mq$ from st;

-- Number Properties and Time > Surds, Exponents and Recurring Decimals
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Number Properties and Time$mq$, 5, 1 from public.subjects s where s.slug = $mq$standard-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Surds, Exponents and Recurring Decimals$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$standard-mathematics$mq$ and p.grade = 5 and p.name = $mq$Number Properties and Time$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Surds, Exponents and Recurring Decimals$mq$ and p.name = $mq$Number Properties and Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Simplify √50.$mq$, $mq$["5√2","25√2","2√5","10√5"]$mq$, 0, $mq$50 = 25 × 2, so √50 = √25 × √2 = 5√2.$mq$, $mq$easy$mq$),
($mq$Simplify 2³ × 2⁴.$mq$, $mq$["2¹²","4⁷","2¹","2⁷"]$mq$, 3, $mq$When multiplying powers of the same base, add the indices: 3 + 4 = 7. The base stays 2.$mq$, $mq$easy$mq$),
($mq$What is the value of 5⁰?$mq$, $mq$["0","5","1","undefined"]$mq$, 2, $mq$Any non-zero number to the power 0 equals 1, because a⁰ = aⁿ ÷ aⁿ = 1.$mq$, $mq$easy$mq$),
($mq$What is 3⁻² as a fraction?$mq$, $mq$["−9","1/9","−1/9","1/6"]$mq$, 1, $mq$A negative index means reciprocal: 3⁻² = 1/3² = 1/9. It does not make the answer negative.$mq$, $mq$easy$mq$),
($mq$Which of these numbers is rational?$mq$, $mq$["0.333... (3 recurring)","√2","π","√3"]$mq$, 0, $mq$0.333... equals 1/3, a fraction of integers. √2, √3 and π are irrational: their decimals never end or repeat.$mq$, $mq$easy$mq$),
($mq$Simplify √12 × √3.$mq$, $mq$["√15","3√2","36","6"]$mq$, 3, $mq$√12 × √3 = √36 = 6.$mq$, $mq$medium$mq$),
($mq$Evaluate (2³)⁴ ÷ 2⁵.$mq$, $mq$["2","16","128","4096"]$mq$, 2, $mq$(2³)⁴ = 2¹². Dividing by 2⁵ subtracts the indices: 2⁷ = 128.$mq$, $mq$medium$mq$),
($mq$Write 0.454545... (45 recurring) as a fraction in its simplest form.$mq$, $mq$["45/100","5/11","9/20","4/9"]$mq$, 1, $mq$Let x = 0.4545... Then 100x = 45.4545..., so 99x = 45 and x = 45/99 = 5/11.$mq$, $mq$medium$mq$),
($mq$Rationalise the denominator of 6/√3.$mq$, $mq$["2√3","6√3","√3","2/√3"]$mq$, 0, $mq$Multiply top and bottom by √3: 6√3/3 = 2√3.$mq$, $mq$medium$mq$),
($mq$x = 0.1666... (6 recurring). Which fraction is equal to x?$mq$, $mq$["16/100","1/7","2/15","1/6"]$mq$, 3, $mq$10x = 1.666... and 100x = 16.666... Subtract: 90x = 15, so x = 15/90 = 1/6.$mq$, $mq$medium$mq$),
($mq$Expand and simplify (3 + √2)(3 − √2).$mq$, $mq$["11","9 − √2","7","7 − 6√2"]$mq$, 2, $mq$Difference of two squares: 3² − (√2)² = 9 − 2 = 7. The middle terms cancel.$mq$, $mq$medium$mq$),
($mq$Calculate (4 × 10⁵) × (3 × 10⁻²) and give the answer in standard form.$mq$, $mq$["12 × 10³","1.2 × 10⁴","1.2 × 10⁷","7 × 10³"]$mq$, 1, $mq$4 × 3 = 12 and 10⁵ × 10⁻² = 10³, so 12 × 10³. This is not standard form, so rewrite as 1.2 × 10⁴.$mq$, $mq$medium$mq$),
($mq$Solve 2ˣ = 1/8.$mq$, $mq$["x = −3","x = 3","x = −4","x = 1/4"]$mq$, 0, $mq$1/8 = 1/2³ = 2⁻³, so x = −3.$mq$, $mq$medium$mq$),
($mq$Simplify √75 + √27.$mq$, $mq$["√102","15√3","5√3 + 9","8√3"]$mq$, 3, $mq$√75 = 5√3 and √27 = 3√3. Add the like surds: 5√3 + 3√3 = 8√3. You cannot add numbers inside roots.$mq$, $mq$hard$mq$),
($mq$Expand and simplify (2 + √3)².$mq$, $mq$["7","4 + 3 = 7 + 3√3","7 + 4√3","4 + √3"]$mq$, 2, $mq$(2 + √3)(2 + √3) = 4 + 2√3 + 2√3 + 3 = 7 + 4√3. The middle term does not vanish for a perfect square.$mq$, $mq$hard$mq$),
($mq$Write 4/(3 − √5) in the form a + √b.$mq$, $mq$["12 + 4√5","3 + √5","3 − √5","(3 + √5)/4"]$mq$, 1, $mq$Multiply by (3 + √5)/(3 + √5). Denominator: 9 − 5 = 4. Numerator: 4(3 + √5). So the result is 3 + √5.$mq$, $mq$hard$mq$),
($mq$Solve 9ˣ = 27.$mq$, $mq$["x = 1.5","x = 3","x = 3/9","x = 2"]$mq$, 0, $mq$Write both with base 3: 9ˣ = 3²ˣ and 27 = 3³. So 2x = 3 and x = 1.5.$mq$, $mq$hard$mq$),
($mq$x = 0.27777... (only the 7 repeats). Which fraction equals x?$mq$, $mq$["27/99","7/25","1/4","5/18"]$mq$, 3, $mq$10x = 2.7777... and 100x = 27.7777... Subtract: 90x = 25, so x = 25/90 = 5/18. Check: 5 ÷ 18 = 0.2777...$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Surds, Exponents and Recurring Decimals$mq$ and p.name = $mq$Number Properties and Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Simplify √72$mq$, $mq$√72 = √(36 × 2) = 6√2. Pull out the largest square factor.$mq$),
($mq$Rule for multiplying surds$mq$, $mq$√a × √b = √(ab). For example √12 × √3 = √36 = 6.$mq$),
($mq$Rationalise 1/√2$mq$, $mq$Multiply top and bottom by √2: 1/√2 = √2/2.$mq$),
($mq$Rationalise 1/(a + √b)$mq$, $mq$Multiply top and bottom by (a − √b). The denominator becomes a² − b, which is rational.$mq$),
($mq$The three main index laws$mq$, $mq$aᵐ × aⁿ = aᵐ⁺ⁿ, aᵐ ÷ aⁿ = aᵐ⁻ⁿ, (aᵐ)ⁿ = aᵐⁿ.$mq$),
($mq$a⁰ and a⁻ⁿ$mq$, $mq$a⁰ = 1 (a ≠ 0) and a⁻ⁿ = 1/aⁿ. A negative index means reciprocal, not a negative number.$mq$),
($mq$Standard form$mq$, $mq$a × 10ⁿ where 1 ≤ a < 10 and n is an integer. Example: 0.00045 = 4.5 × 10⁻⁴.$mq$),
($mq$Convert 0.333... to a fraction$mq$, $mq$x = 0.333..., 10x = 3.333..., subtract: 9x = 3, so x = 1/3.$mq$),
($mq$Rational vs irrational$mq$, $mq$Rational: can be written as a fraction of integers (terminating or recurring decimals). Irrational: cannot (√2, π).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Surds, Exponents and Recurring Decimals$mq$ and p.name = $mq$Number Properties and Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Surds
A **surd** is a root that cannot be written as an exact fraction, such as √2, √3 or √7. Surds are irrational: their decimals never end and never repeat. √9 = 3 is NOT a surd. Surds keep answers exact, which is why exam questions say "leave your answer in surd form".

Key rules, for positive a and b:
- √a × √b = √(ab)
- √a ÷ √b = √(a/b)
- √(a²) = a

To simplify, pull out the largest square factor: √50 = √(25 × 2) = 5√2 and √72 = √(36 × 2) = 6√2. You can only add or subtract "like" surds: 5√3 + 3√3 = 8√3, but √2 + √3 cannot be combined.

Expanding brackets works as normal: (2 + √3)² = 4 + 4√3 + 3 = 7 + 4√3. The difference of two squares gives a rational answer: (3 + √2)(3 − √2) = 9 − 2 = 7.

**Rationalising the denominator** means removing a surd from the bottom of a fraction. For 6/√3 multiply top and bottom by √3 to get 6√3/3 = 2√3. For 4/(3 − √5) multiply by (3 + √5) to use the difference of two squares: denominator 9 − 5 = 4, so the result is 3 + √5.

## Exponent (index) laws
- aᵐ × aⁿ = aᵐ⁺ⁿ
- aᵐ ÷ aⁿ = aᵐ⁻ⁿ
- (aᵐ)ⁿ = aᵐⁿ
- a⁰ = 1
- a⁻ⁿ = 1/aⁿ
- a^(1/2) = √a

Worked example: solve 9ˣ = 27. Write both with base 3: 3²ˣ = 3³, so 2x = 3 and x = 1.5. Standard form is a × 10ⁿ with 1 ≤ a < 10, so 12 × 10³ must be rewritten as 1.2 × 10⁴.

## Recurring decimals
Every recurring decimal is a fraction. Method:
1. Let x equal the decimal.
2. Multiply by 10, 100 and so on until the repeating parts line up.
3. Subtract to cancel the repeat.
4. Solve and simplify.

Example: x = 0.4545... gives 100x = 45.4545..., so 99x = 45 and x = 45/99 = 5/11. If only some digits repeat, such as 0.2777..., use 10x and 100x: 100x − 10x = 25, so 90x = 25 and x = 5/18.

## Common mistakes
- Writing √(a + b) = √a + √b. It is false.
- Thinking a negative index gives a negative number.
- Treating 2⁻³ as −8.
- Forgetting to simplify the fraction at the end.
- Leaving a surd in the denominator when asked to rationalise.

## How this is examined
In eAssessment style tasks, surds and indices appear in measurement contexts such as the diagonal of a screen, the side of a square plot given its area, or population growth by powers of 2. You may be asked to show that a length equals 3√2, to give an exact value, and then to compare it with a rounded decimal to comment on accuracy.

Exam tip: When a question says "exact" or "leave in surd form", never use a calculator decimal as your final answer. Simplify the surd, rationalise the denominator, and only then give a rounded value if asked.$mq$ from st;

-- Number Properties and Time > Inequalities on Number Lines
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Number Properties and Time$mq$, 5, 1 from public.subjects s where s.slug = $mq$standard-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Inequalities on Number Lines$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$standard-mathematics$mq$ and p.grade = 5 and p.name = $mq$Number Properties and Time$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Inequalities on Number Lines$mq$ and p.name = $mq$Number Properties and Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Solve x + 3 > 7.$mq$, $mq$["x > 4","x > 10","x < 4","x ≥ 4"]$mq$, 0, $mq$Subtract 3 from both sides: x > 4. The sign stays the same because we did not multiply or divide by a negative.$mq$, $mq$easy$mq$),
($mq$A number line has an open circle at 2 and an arrow pointing to the right. Which inequality does it show?$mq$, $mq$["x ≥ 2","x < 2","x ≤ 2","x > 2"]$mq$, 3, $mq$An open circle means 2 is not included, and an arrow to the right means larger values. So x > 2.$mq$, $mq$easy$mq$),
($mq$How many integers satisfy −2 ≤ x < 2?$mq$, $mq$["3","5","4","2"]$mq$, 2, $mq$The integers are −2, −1, 0 and 1. The value 2 is not included because of the strict inequality, but −2 is included.$mq$, $mq$easy$mq$),
($mq$Solve 2x ≤ 10.$mq$, $mq$["x ≤ 12","x ≤ 5","x ≥ 5","x ≤ 20"]$mq$, 1, $mq$Divide both sides by 2, a positive number, so the sign does not change: x ≤ 5.$mq$, $mq$easy$mq$),
($mq$On a number line, what does a closed (filled) circle at a number mean?$mq$, $mq$["The number is included in the solution","The number is excluded","The solution is negative","The line stops there for good"]$mq$, 0, $mq$A closed circle goes with ≤ or ≥ and shows the boundary value is part of the solution. An open circle excludes it.$mq$, $mq$easy$mq$),
($mq$Solve −3x < 12.$mq$, $mq$["x < −4","x > 4","x < 4","x > −4"]$mq$, 3, $mq$Dividing by −3 reverses the inequality: x > −4.$mq$, $mq$medium$mq$),
($mq$Solve 3x − 5 ≥ 10.$mq$, $mq$["x ≥ 5/3","x ≤ 5","x ≥ 5","x ≥ 15"]$mq$, 2, $mq$Add 5: 3x ≥ 15. Divide by 3: x ≥ 5.$mq$, $mq$medium$mq$),
($mq$Solve 2(x + 3) < 4x − 2.$mq$, $mq$["x < 4","x > 4","x > 2","x > −4"]$mq$, 1, $mq$2x + 6 < 4x − 2, so 8 < 2x, which gives x > 4. Collect x terms on the side that stays positive.$mq$, $mq$medium$mq$),
($mq$How many integers satisfy −3 < 2x + 1 ≤ 7?$mq$, $mq$["5","4","6","3"]$mq$, 0, $mq$Subtract 1: −4 < 2x ≤ 6. Divide by 2: −2 < x ≤ 3. The integers are −1, 0, 1, 2, 3.$mq$, $mq$medium$mq$),
($mq$A lift can carry at most 600 kg. Sam weighs 80 kg and carries identical boxes of 25 kg. What is the greatest number of boxes he can take in one trip?$mq$, $mq$["21","24","25","20"]$mq$, 3, $mq$80 + 25n ≤ 600 gives 25n ≤ 520, so n ≤ 20.8. n must be a whole number, so the greatest is 20.$mq$, $mq$medium$mq$),
($mq$Combine the conditions x > 1 and x ≤ 6. Which inequality describes values satisfying BOTH?$mq$, $mq$["x ≤ 1 or x > 6","x > 6","1 < x ≤ 6","1 ≤ x < 6"]$mq$, 2, $mq$Both must be true, so x lies between 1 and 6, excluding 1 and including 6.$mq$, $mq$medium$mq$),
($mq$Solve x/4 − 1 > 2.$mq$, $mq$["x > 4","x > 12","x > 3/4","x > 7"]$mq$, 1, $mq$Add 1: x/4 > 3. Multiply by 4: x > 12.$mq$, $mq$medium$mq$),
($mq$A phone plan costs $15 plus $0.05 per minute. Aisha wants to pay less than $25 in a month. Which inequality gives the minutes m she can use?$mq$, $mq$["m < 200","m ≤ 200","m > 200","m < 500"]$mq$, 0, $mq$15 + 0.05m < 25 gives 0.05m < 10, so m < 200. Exactly 200 minutes would cost $25, which is not less than $25.$mq$, $mq$medium$mq$),
($mq$Solve −5 ≤ 3 − 2x < 9.$mq$, $mq$["−4 ≤ x < 3","3 ≤ x < −4","−3 ≤ x < 4","−3 < x ≤ 4"]$mq$, 3, $mq$Subtract 3: −8 ≤ −2x < 6. Divide by −2 and reverse both signs: 4 ≥ x > −3, which reads −3 < x ≤ 4.$mq$, $mq$hard$mq$),
($mq$What is the largest integer n that satisfies 7n − 3 < 2n + 40?$mq$, $mq$["9","43/5","8","7"]$mq$, 2, $mq$5n < 43 gives n < 8.6. The largest integer below 8.6 is 8. Rounding to 9 would break the strict inequality.$mq$, $mq$hard$mq$),
($mq$What is the smallest integer x that satisfies 5 − x ≤ 2x + 1?$mq$, $mq$["1","2","4/3","0"]$mq$, 1, $mq$4 ≤ 3x, so x ≥ 4/3 ≈ 1.33. The smallest integer that is at least 1.33 is 2.$mq$, $mq$hard$mq$),
($mq$A rectangular garden has sides x metres and (x + 4) metres. The fence around it must be less than 40 m. What is the greatest whole-number value of x?$mq$, $mq$["7","8","9","10"]$mq$, 0, $mq$Perimeter = 2x + 2(x + 4) = 4x + 8. 4x + 8 < 40 gives x < 8. The greatest whole number below 8 is 7.$mq$, $mq$hard$mq$),
($mq$A student solves −2x > 8 and writes x > −4. What is the error and the correct answer?$mq$, $mq$["Divided wrongly; x > −16","No error; x > −4","Sign should be ≥; x ≥ −4","Sign not reversed; x < −4"]$mq$, 3, $mq$Dividing by a negative number reverses the inequality sign. −2x > 8 gives x < −4.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Inequalities on Number Lines$mq$ and p.name = $mq$Number Properties and Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Open vs closed circle$mq$, $mq$Open circle: end value not included (< or >). Closed circle: included (≤ or ≥).$mq$),
($mq$Key rule when solving$mq$, $mq$Multiplying or dividing both sides by a NEGATIVE number reverses the inequality sign.$mq$),
($mq$Solve −2x > 8$mq$, $mq$Divide by −2 and reverse the sign: x < −4.$mq$),
($mq$Meaning of 'at most'$mq$, $mq$At most n means ≤ n. 'At least n' means ≥ n.$mq$),
($mq$Meaning of 'fewer than' / 'more than'$mq$, $mq$'Fewer than n' means < n. 'More than n' means > n. These are strict, so n is not allowed.$mq$),
($mq$Solve a double inequality$mq$, $mq$Apply each step to all three parts. If you divide by a negative number, reverse both signs.$mq$),
($mq$'and' vs 'or' with inequalities$mq$, $mq$'and': both true, so one overlapping range. 'or': at least one true, so possibly two separate ranges.$mq$),
($mq$Integer solutions of −2 ≤ x < 2$mq$, $mq$−2, −1, 0, 1. Check whether each end value is included.$mq$),
($mq$Check an answer$mq$, $mq$Substitute a value from your solution set into the original inequality. It should make the statement true.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$standard-mathematics$mq$ and t.grade = 5 and t.name = $mq$Inequalities on Number Lines$mq$ and p.name = $mq$Number Properties and Time$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What an inequality says
An **inequality** compares quantities using <, >, ≤ or ≥. Where an equation usually has one solution, an inequality has a whole range of solutions. Read the symbols carefully: < means "less than", ≤ means "less than or equal to".

## Showing solutions on a number line
- Open circle for < or > (the end value is NOT included).
- Closed (filled) circle for ≤ or ≥ (the end value IS included).
- Draw an arrow in the direction of the solutions.
For −2 ≤ x < 2 you draw a closed circle at −2, an open circle at 2 and a line between them. The integers in that range are −2, −1, 0 and 1.

## Solving linear inequalities
Solve almost exactly as an equation: do the same to both sides. The one special rule is that **multiplying or dividing both sides by a negative number reverses the inequality sign**.
Example: −3x < 12. Divide by −3: x > −4.
Example: 2(x + 3) < 4x − 2 gives 2x + 6 < 4x − 2, so 8 < 2x, so x > 4.
A trick that avoids the reversing rule is to move the x terms to the side where the coefficient stays positive.

## Double inequalities
Do the same operation to all three parts. For −3 < 2x + 1 ≤ 7, subtract 1 to get −4 < 2x ≤ 6, then divide by 2 to get −2 < x ≤ 3. If you divide by a negative, reverse both signs and rewrite so the smaller number comes first: −5 ≤ 3 − 2x < 9 becomes −8 ≤ −2x < 6, then 4 ≥ x > −3, which is −3 < x ≤ 4.

## Combining conditions
- "and" means both conditions are true: x > 1 and x ≤ 6 gives 1 < x ≤ 6.
- "or" means at least one is true: x < −1 or x ≥ 3 gives two separate pieces on the line.

## Inequalities in context
Translate carefully. "At most" means ≤, "at least" means ≥, "fewer than" means <, "more than" means >. Example: a lift carries at most 600 kg and a person of 80 kg adds boxes of 25 kg each, so 80 + 25n ≤ 600 and n ≤ 20.8. Because boxes are whole items, the answer is 20, not 21. Always check whether the variable must be an integer.

## Common mistakes
- Forgetting to reverse the sign when dividing by a negative.
- Using a closed circle for a strict inequality.
- Giving 20.8 boxes as the answer.
- Writing a double inequality in the wrong order, such as 3 ≤ x < −4.

## How this is examined
Problems appear as budgets, load limits, speed limits, ticket prices or plans with fixed and variable costs. You build the inequality from the text, solve it, then interpret what the answer means for the situation. Later parts often ask you to justify a decision, for example whether a plan stays within a limit.

Exam tip: After solving, test one value from your solution set in the original inequality. It takes ten seconds and catches reversed-sign errors.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('standard-mathematics')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;