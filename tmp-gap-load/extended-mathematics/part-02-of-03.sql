-- Part 2 of 3: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Exponentials and Logarithms > Laws of Logarithms and Solving Exponential Equations
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Exponentials and Logarithms$mq$, 5, 3 from public.subjects s where s.slug = $mq$extended-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Laws of Logarithms and Solving Exponential Equations$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$extended-mathematics$mq$ and p.grade = 5 and p.name = $mq$Exponentials and Logarithms$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Laws of Logarithms and Solving Exponential Equations$mq$ and p.name = $mq$Exponentials and Logarithms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the value of log₂ 8?$mq$, $mq$["3","4","8","16"]$mq$, 0, $mq$log₂ 8 asks "2 to what power gives 8?". Since 2³ = 8, the answer is 3.$mq$, $mq$easy$mq$),
($mq$What is log₁₀ 1000?$mq$, $mq$["2","10","100","3"]$mq$, 3, $mq$10³ = 1000, so log₁₀ 1000 = 3. The logarithm is the power.$mq$, $mq$easy$mq$),
($mq$Which logarithm statement is equivalent to 2⁵ = 32?$mq$, $mq$["log₅ 32 = 2","log₃₂ 2 = 5","log₂ 32 = 5","log₂ 5 = 32"]$mq$, 2, $mq$If bˣ = N then log_b N = x. Here b = 2, x = 5 and N = 32, so log₂ 32 = 5.$mq$, $mq$easy$mq$),
($mq$What is log 2 + log 5 (base 10) as a single number?$mq$, $mq$["7","1","log 7","10"]$mq$, 1, $mq$Add logs by multiplying: log 2 + log 5 = log (2 × 5) = log 10 = 1.$mq$, $mq$easy$mq$),
($mq$Solve 2ˣ = 16.$mq$, $mq$["x = 4","x = 8","x = 3","x = 32"]$mq$, 0, $mq$16 = 2⁴ so x = 4. Dividing 16 by 2 to get 8 is a common slip: the unknown is the power.$mq$, $mq$easy$mq$),
($mq$Simplify log₅ 25 + log₅ 5.$mq$, $mq$["2","log₅ 30","1","3"]$mq$, 3, $mq$log₅ 25 = 2 and log₅ 5 = 1, so the sum is 3. Using the product law gives log₅ 125 = 3, which agrees. Adding the numbers inside the logs (30) is wrong.$mq$, $mq$medium$mq$),
($mq$Which is the value of log 40 − log 4 (base 10)?$mq$, $mq$["36","log 36","1","10"]$mq$, 2, $mq$Subtract logs by dividing: log (40 ÷ 4) = log 10 = 1. Subtracting the numbers 40 − 4 inside the log is not allowed.$mq$, $mq$medium$mq$),
($mq$Write 2 log 3 + log 4 as a single logarithm.$mq$, $mq$["log 10","log 36","log 24","log 18"]$mq$, 1, $mq$2 log 3 = log 3² = log 9. Then log 9 + log 4 = log (9 × 4) = log 36. The power law moves the 2 up as an exponent, not a multiplier.$mq$, $mq$medium$mq$),
($mq$Solve 3^(x + 1) = 81.$mq$, $mq$["x = 3","x = 4","x = 26","x = 80"]$mq$, 0, $mq$81 = 3⁴, so x + 1 = 4 and x = 3. Subtracting 1 from 81 or dividing does not work for powers.$mq$, $mq$medium$mq$),
($mq$Solve 5ˣ = 40, giving your answer to 3 significant figures.$mq$, $mq$["x = 8","x = 2.30","x = 1.74","x = 2.29"]$mq$, 3, $mq$Take logs: x = log 40 ÷ log 5 = 1.6021 ÷ 0.6990 = 2.292, which is 2.29 to 3 s.f. Dividing 40 by 5 gives 8, which is not a solution because 5⁸ is far larger than 40.$mq$, $mq$medium$mq$),
($mq$An account has £1200 and earns 5% compound interest each year. After how many whole years is the balance first more than £2400?$mq$, $mq$["14 years","20 years","15 years","24 years"]$mq$, 2, $mq$Solve 1.05ⁿ > 2: n > log 2 ÷ log 1.05 = 14.2. After 14 years the balance is about £2376, which is less than £2400. After 15 years it is about £2495.$mq$, $mq$medium$mq$),
($mq$A car worth £18 000 loses 12% of its value each year. After how many whole years is it first worth less than £9000?$mq$, $mq$["5 years","6 years","8 years","12 years"]$mq$, 1, $mq$Solve 0.88ⁿ < 0.5: n > log 0.5 ÷ log 0.88 = 5.42. After 5 years the car is worth 18 000 × 0.88⁵ ≈ £9499, and after 6 years about £8359.$mq$, $mq$medium$mq$),
($mq$Which expression is equal to log_a (x²) for x > 0?$mq$, $mq$["2 log_a x","(log_a x)²","log_a 2x","x log_a 2"]$mq$, 0, $mq$The power law says log_a (xⁿ) = n log_a x. The square on the argument becomes a multiplier of the whole logarithm. (log_a x)² is different.$mq$, $mq$medium$mq$),
($mq$Solve 4ˣ = 2^(x + 3).$mq$, $mq$["x = 1","x = 6","x = 1.5","x = 3"]$mq$, 3, $mq$Write 4ˣ as (2²)ˣ = 2^(2x). Then 2x = x + 3 so x = 3. Check: 4³ = 64 and 2⁶ = 64.$mq$, $mq$hard$mq$),
($mq$Solve log₂ x + log₂ (x − 2) = 3, for x > 2.$mq$, $mq$["x = 5","x = −2","x = 4","x = 8"]$mq$, 2, $mq$Combine: log₂ (x(x − 2)) = 3 so x² − 2x = 8, giving x² − 2x − 8 = 0, so (x − 4)(x + 2) = 0. The value x = −2 is rejected because x must be more than 2. Check: log₂ 4 + log₂ 2 = 2 + 1 = 3.$mq$, $mq$hard$mq$),
($mq$A culture starts with 200 bacteria and triples every hour, so N = 200 × 3ᵗ. At what time t, in hours to 3 significant figures, does N first reach 5000?$mq$, $mq$["25 hours","2.93 hours","1.46 hours","3.00 hours"]$mq$, 1, $mq$Solve 3ᵗ = 25. Then t = log 25 ÷ log 3 = 2.930. At t = 3 the number is 5400, which is more than 5000, so 3.00 is not the first time.$mq$, $mq$hard$mq$),
($mq$The solution of 5ˣ = 40 is x ≈ 2.292. A student uses x = 2.3 to check, and calculates 5^2.3 ≈ 40.52. What is the percentage error in this value compared with 40, to 1 decimal place?$mq$, $mq$["1.3%","0.5%","8%","0.3%"]$mq$, 0, $mq$Percentage error = (40.52 − 40) ÷ 40 × 100 ≈ 1.3%. Rounding the exponent to 2 d.p. has a bigger effect because small changes in a power make big changes in the result.$mq$, $mq$hard$mq$),
($mq$Town A has 50 000 people and grows 2% per year. Town B has 40 000 people and grows 4% per year. After how many whole years does Town B first have more people than Town A?$mq$, $mq$["11 years","10 years","6 years","12 years"]$mq$, 3, $mq$Solve 40 000 × 1.04ⁿ > 50 000 × 1.02ⁿ, so (1.04 ÷ 1.02)ⁿ > 1.25 and n > log 1.25 ÷ log (1.0196) = 11.49. After 11 years B has about 61 578 and A about 62 169. After 12 years B has about 64 041 and A about 63 412.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Laws of Logarithms and Solving Exponential Equations$mq$ and p.name = $mq$Exponentials and Logarithms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Meaning of log_b N = x$mq$, $mq$It means bˣ = N. The logarithm is the power.$mq$),
($mq$Product law$mq$, $mq$log_b (mn) = log_b m + log_b n.$mq$),
($mq$Quotient law$mq$, $mq$log_b (m ÷ n) = log_b m − log_b n.$mq$),
($mq$Power law$mq$, $mq$log_b (mᵏ) = k log_b m.$mq$),
($mq$Special values$mq$, $mq$log_b 1 = 0 and log_b b = 1.$mq$),
($mq$Solving by matching bases$mq$, $mq$Write both sides as powers of the same base, then equate the powers. Example: 3^(x+1) = 81 gives x + 1 = 4.$mq$),
($mq$Solving by taking logs$mq$, $mq$For aˣ = N, take logs: x = log N ÷ log a.$mq$),
($mq$Compound growth model$mq$, $mq$A × rᵗ with r = 1 + p/100 for growth or 1 − p/100 for decay. Use logs to find the time t.$mq$),
($mq$Common log mistake$mq$, $mq$log (a + b) is not log a + log b. Reject log arguments that are zero or negative.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Laws of Logarithms and Solving Exponential Equations$mq$ and p.name = $mq$Exponentials and Logarithms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is a logarithm?
A logarithm answers the question: "What power do I need?" If bˣ = N, then log_b N = x. For example, 2³ = 8, so log₂ 8 = 3. The number b is the base, and it must be positive and not equal to 1. When no base is written, a calculator log usually means base 10, so log 1000 = 3 because 10³ = 1000. Logs and exponentials are inverses: log_b (bˣ) = x and b^(log_b N) = N.

## The laws of logarithms
These laws hold for the same base and for positive numbers:
- **Product law**: log_b (m × n) = log_b m + log_b n
- **Quotient law**: log_b (m ÷ n) = log_b m − log_b n
- **Power law**: log_b (mᵏ) = k × log_b m
- **Special values**: log_b 1 = 0 and log_b b = 1

Example: log 2 + log 5 = log 10 = 1. Example: 2 log 3 + log 4 = log 9 + log 4 = log 36.

Be careful: log (a + b) is not log a + log b, and (log a)² is not 2 log a. The laws only work for products, quotients and powers.

## Solving exponential equations
An exponential equation has the unknown in the power.
- **Method 1: same base.** Write both sides as powers of the same number, then equate the powers. For 3^(x+1) = 81, write 81 = 3⁴, so x + 1 = 4 and x = 3. For 4ˣ = 2^(x+3), write 4ˣ = 2^(2x), so 2x = x + 3 and x = 3.
- **Method 2: take logs.** If the bases cannot be matched, take logs of both sides and use the power law. For 5ˣ = 40, x log 5 = log 40, so x = log 40 ÷ log 5 = 2.29 to 3 s.f.

## Solving log equations
Combine logs into one using the laws, convert to a power, solve, then check your answers. For log₂ x + log₂ (x − 2) = 3: log₂ (x(x − 2)) = 3, so x² − 2x = 8, giving x = 4 or x = −2. You must reject x = −2 because you cannot take the log of a negative number.

## Using logs in real problems
Growth and decay models have the form A × rᵗ, where r = 1 + percentage/100 for growth, or r = 1 − percentage/100 for decay. To find when a target is reached, divide to isolate rᵗ and then take logs. Example: £1200 at 5% per year doubles when 1.05ⁿ > 2, so n > log 2 ÷ log 1.05 = 14.2, which means 15 whole years. Always check by substituting back, and decide whether to round up or down to answer in context.

## Accuracy
If you round an answer early, errors can grow. Keep full calculator values and round only at the end. You can check accuracy with percentage error = |approximate − exact| ÷ exact × 100.

## How this is examined
Tasks use realistic models, such as population, bacteria, depreciation or savings. You may be asked to write the model, solve for time, state assumptions (a constant rate that does not change), check accuracy using percentage error, and judge whether the model fits reality in the long term.

Exam tip: Show the step where you take logs or match bases, and always check that your final answer makes sense in context, for example a time in whole years.$mq$ from st;

-- Data Analysis Extension > Standard Deviation and Comparing Data Sets
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Data Analysis Extension$mq$, 5, 4 from public.subjects s where s.slug = $mq$extended-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Standard Deviation and Comparing Data Sets$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$extended-mathematics$mq$ and p.grade = 5 and p.name = $mq$Data Analysis Extension$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Standard Deviation and Comparing Data Sets$mq$ and p.name = $mq$Data Analysis Extension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does the standard deviation of a data set measure?$mq$, $mq$["How spread out the values are around the mean","The most common value","The middle value when the data is ordered","The difference between the largest and smallest value"]$mq$, 0, $mq$Standard deviation measures the typical distance of the values from the mean. The most common value is the mode, the middle is the median, and the largest minus smallest is the range.$mq$, $mq$easy$mq$),
($mq$What is the mean of the data set 2, 4, 4, 4, 5, 5, 7, 9?$mq$, $mq$["4","4.5","6","5"]$mq$, 3, $mq$The sum is 40 and there are 8 values, so the mean is 40 ÷ 8 = 5. The median is 4.5, which is a different measure.$mq$, $mq$easy$mq$),
($mq$Two classes sit the same test. Class A has a standard deviation of 3 marks and Class B has a standard deviation of 9 marks. Which statement is correct?$mq$, $mq$["Class A's marks are more spread out","Class B has the higher mean","Class B's marks are more spread out","Class A has the higher mean"]$mq$, 2, $mq$A larger standard deviation means more spread. Standard deviation says nothing about which mean is higher.$mq$, $mq$easy$mq$),
($mq$What is the standard deviation of the data set 7, 7, 7, 7?$mq$, $mq$["7","0","1","28"]$mq$, 1, $mq$Every value equals the mean, so every deviation is 0 and the standard deviation is 0. There is no spread.$mq$, $mq$easy$mq$),
($mq$Every value in a data set has 10 added to it. What happens to the standard deviation?$mq$, $mq$["It stays the same","It increases by 10","It is multiplied by 10","It decreases by 10"]$mq$, 0, $mq$Adding the same amount shifts the whole set but does not change how spread out it is. The mean increases by 10, but the standard deviation stays the same.$mq$, $mq$easy$mq$),
($mq$For the data 2, 4, 4, 4, 5, 5, 7, 9 the mean is 5 and the sum of the squared deviations from the mean is 32. What is the population standard deviation (σ)?$mq$, $mq$["4","√32","3.2","2"]$mq$, 3, $mq$Variance = 32 ÷ 8 = 4, and σ = √4 = 2. Forgetting to divide by 8 or forgetting to take the square root are the common mistakes.$mq$, $mq$medium$mq$),
($mq$Class X scored a mean of 62% with a standard deviation of 4. Class Y scored a mean of 62% with a standard deviation of 11. Which conclusion is best?$mq$, $mq$["Class Y performed better overall","The two classes performed the same, so they are the same","Class X's results are more consistent than Class Y's","Class X has the larger range of results"]$mq$, 2, $mq$The means are equal, so the average performance is the same. The smaller standard deviation shows that Class X's marks are closer together, so they are more consistent.$mq$, $mq$medium$mq$),
($mq$Every value in a data set is multiplied by 3. The original standard deviation was 2. What is the new standard deviation?$mq$, $mq$["2","6","5","18"]$mq$, 1, $mq$Multiplying all values by 3 stretches the spread by a factor of 3, so σ becomes 3 × 2 = 6. The variance would be multiplied by 9, not the standard deviation.$mq$, $mq$medium$mq$),
($mq$The ages of five people are 12, 15, 11, 18 and 14. What is the standard deviation, to 3 significant figures (treat the five people as the whole population)?$mq$, $mq$["2.45","6","2.74","14"]$mq$, 0, $mq$The mean is 14. The squared deviations are 4, 1, 9, 16 and 0, which sum to 30. The variance is 30 ÷ 5 = 6 and σ = √6 = 2.45. The number 6 is the variance, not the standard deviation.$mq$, $mq$medium$mq$),
($mq$Why is the standard deviation usually a better measure of spread than the range?$mq$, $mq$["It is always larger than the range","It is easier to calculate by hand","It is not affected by extreme values at all","It uses every value in the data set, not just the largest and smallest"]$mq$, 3, $mq$The range uses only two values, so one unusual value changes it a lot. The standard deviation uses every value, although a very extreme value still affects it.$mq$, $mq$medium$mq$),
($mq$Athlete A runs 100 m with a mean time of 11.2 s and a standard deviation of 0.1 s. Athlete B has a mean time of 11.0 s and a standard deviation of 0.4 s. Which statement is correct?$mq$, $mq$["A is faster on average and more consistent","B is faster on average and more consistent","B is faster on average, but A is more consistent","A is faster on average, but B is more consistent"]$mq$, 2, $mq$A lower mean time is faster, so B is faster on average. A lower standard deviation shows more consistent times, which is A.$mq$, $mq$medium$mq$),
($mq$Scores are 1, 2 and 3 with frequencies 2, 5 and 3. The mean is 2.1. What is the standard deviation?$mq$, $mq$["0.49","0.7","0.84","1"]$mq$, 1, $mq$The squared deviations weighted by frequency are 2(1.1²) + 5(0.1²) + 3(0.9²) = 2.42 + 0.05 + 2.43 = 4.9. Variance = 4.9 ÷ 10 = 0.49 and σ = 0.7. The value 0.49 is the variance.$mq$, $mq$medium$mq$),
($mq$A test has a mean of 50 and a standard deviation of 8. Which score is within one standard deviation of the mean?$mq$, $mq$["57","59","35","66"]$mq$, 0, $mq$Within one standard deviation means between 50 − 8 = 42 and 50 + 8 = 58. Only 57 is in that interval.$mq$, $mq$medium$mq$),
($mq$Set P is 20, 22, 24, 26, 28 and Set Q is 14, 20, 24, 28, 34. Which statement is correct?$mq$, $mq$["Set P has the greater standard deviation","They have the same standard deviation because the means are equal","Set Q has the greater mean","They have the same mean (24), but Set Q has the greater standard deviation"]$mq$, 3, $mq$Both sets have a mean of 24. Set P has σ = √8 ≈ 2.83 and Set Q has σ ≈ 6.81, because Q's values are further from the mean.$mq$, $mq$hard$mq$),
($mq$A data set has a mean of 5 and a standard deviation of 2. Each value x is changed to 2x − 5. What are the new mean and standard deviation?$mq$, $mq$["Mean 5 and standard deviation 2","Mean 5 and standard deviation −1","Mean 5 and standard deviation 4","Mean 10 and standard deviation 4"]$mq$, 2, $mq$The mean follows the same rule: 2 × 5 − 5 = 5. The standard deviation is only multiplied by the 2 (not shifted by −5), giving 2 × 2 = 4.$mq$, $mq$hard$mq$),
($mq$The data 2, 4, 4, 4, 5, 5, 7, 9 has a mean of 5 and σ = 2. An extra value of 30 is added. Which statement is correct?$mq$, $mq$["The mean rises to 5 and σ rises to 2","The mean rises to about 7.78 and σ rises to about 8.08","The mean stays 5 but σ rises to about 8.08","The mean rises to about 7.78 and σ stays 2"]$mq$, 1, $mq$The new sum is 70 for 9 values, so the mean is 7.78. The extreme value is far from the mean, which greatly increases the spread to about 8.08. This shows outliers affect both measures.$mq$, $mq$hard$mq$),
($mq$A factory must make rods of length 50 mm with a tolerance of ±1 mm (49 mm to 51 mm). Machine A has mean 50.0 mm and σ = 0.5 mm. Machine B has mean 50.4 mm and σ = 0.1 mm. Assuming bell-shaped data, which machine is more suitable and why?$mq$, $mq$["Machine B, because almost all its rods lie within 50.1 mm to 50.7 mm, inside the tolerance","Machine A, because its mean is exactly on target","Machine A, because a larger σ means more variety","Machine B, because its mean is higher"]$mq$, 0, $mq$Machine A's tolerance is only ±2σ, so about 5% of rods fall outside. Machine B is slightly off target, but about 99.7% of its rods lie within 3σ (50.1 to 50.7), which is inside 49 to 51. B could be adjusted to be even better.$mq$, $mq$hard$mq$),
($mq$Six values have a mean of 8, and the sum of the squared deviations from 8 is 54. A seventh value equal to 8 is added. What is the new standard deviation, to 3 significant figures?$mq$, $mq$["3","2.57","2.65","2.78"]$mq$, 3, $mq$Before: variance 54 ÷ 6 = 9 so σ = 3. Adding 8 keeps the mean at 8 and adds a deviation of 0, so the sum of squares is still 54 but there are 7 values. The new variance is 54 ÷ 7 = 7.714 and σ = 2.78.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Standard Deviation and Comparing Data Sets$mq$ and p.name = $mq$Data Analysis Extension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Standard deviation (σ)$mq$, $mq$A measure of how far values typically lie from the mean. It uses every value in the data set.$mq$),
($mq$Steps to find σ$mq$, $mq$Find the mean, find the deviations, square them, add and divide by n to get the variance, then take the square root.$mq$),
($mq$Variance$mq$, $mq$The mean of the squared deviations. The standard deviation is its square root.$mq$),
($mq$Small vs large σ$mq$, $mq$Small σ: values are close to the mean (consistent). Large σ: values are spread out (variable).$mq$),
($mq$σ = 0$mq$, $mq$Every value in the data set is the same.$mq$),
($mq$Adding k to every value$mq$, $mq$The mean increases by k. The standard deviation is unchanged.$mq$),
($mq$Multiplying every value by k$mq$, $mq$The mean and the standard deviation are both multiplied by |k|.$mq$),
($mq$Effect of an outlier$mq$, $mq$An extreme value changes the mean and can increase σ a lot.$mq$),
($mq$Comparing two data sets$mq$, $mq$Comment on an average (mean) and on spread (σ), both in context, for example faster on average but less consistent.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Standard Deviation and Comparing Data Sets$mq$ and p.name = $mq$Data Analysis Extension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why we need more than the mean
The mean tells you where the middle of a data set is, but not how spread out the values are. Two classes can both have a mean of 62%, yet one has marks that are tightly bunched and the other has marks that are far apart. A measure of spread is needed. The range (largest − smallest) is simple but uses only two values. The standard deviation uses every value.

## Calculating the standard deviation
The standard deviation, written σ for a whole population, measures the typical distance from the mean. Follow these steps:
- Find the mean.
- Find each deviation (value − mean).
- Square each deviation.
- Add the squares, divide by the number of values to get the variance.
- Take the square root of the variance.

Worked example: 2, 4, 4, 4, 5, 5, 7, 9 has mean 5. The deviations are −3, −1, −1, −1, 0, 0, 2, 4. The squares are 9, 1, 1, 1, 0, 0, 4, 16, and they add to 32. Variance = 32 ÷ 8 = 4, so σ = 2. In an exam you will usually use the calculator's statistics mode, so make sure you know which key gives σ (the population standard deviation) and report it clearly. For a frequency table, enter the values and frequencies into the calculator in the same way.

## What the value means
- A small σ means the data is clustered close to the mean (consistent).
- A large σ means the data is spread out (variable).
- σ = 0 means every value is the same.
- For bell-shaped data, about 68% of values lie within 1σ of the mean and about 95% within 2σ.

## Effects of changing the data
- Adding a constant to every value: the mean changes by that constant, σ is unchanged.
- Multiplying every value by k: the mean is multiplied by k, σ is multiplied by |k|.
- Adding an outlier: both the mean and σ can change a lot, and σ usually increases.
- Adding a value equal to the mean keeps the mean but reduces σ.

## Comparing data sets
When comparing two sets, always comment on both a measure of average and a measure of spread, and write your answer in context. For example: "Athlete B has a lower mean time, so is faster on average, but a higher standard deviation, so is less consistent." Never say that a high standard deviation is "better" without context. Sometimes consistency matters more than average, such as in manufacturing where parts must fit within a tolerance.

## Common mistakes
- Giving the variance when the question asks for the standard deviation.
- Forgetting to square root, or dividing by the wrong number.
- Saying a bigger σ means a bigger mean.
- Comparing only the means.
- Not writing a conclusion in context.

## How this is examined
Questions give data in context, such as test marks, sprint times or factory measurements. You calculate the mean and standard deviation (often with technology), compare two sets in words, and justify a decision. Extended tasks ask you to consider assumptions (such as the data being bell-shaped), the effect of outliers and the reliability of conclusions.

Exam tip: Write one sentence about the average and one about the spread, each in context, and use comparative words such as "higher", "more consistent" or "more varied".$mq$ from st;

-- Functions > Rational Functions and Asymptotes
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Functions$mq$, 5, 5 from public.subjects s where s.slug = $mq$extended-mathematics$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Rational Functions and Asymptotes$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$extended-mathematics$mq$ and p.grade = 5 and p.name = $mq$Functions$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Rational Functions and Asymptotes$mq$ and p.name = $mq$Functions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the vertical asymptote of y = 1/(x − 3)?$mq$, $mq$["x = 3","x = −3","y = 3","y = 0"]$mq$, 0, $mq$The denominator is zero when x = 3, so the graph cannot cross or touch the line x = 3. The line y = 0 is the horizontal asymptote.$mq$, $mq$easy$mq$),
($mq$For which value of x is y = 5/(x + 1) undefined?$mq$, $mq$["x = 1","x = 5","x = 0","x = −1"]$mq$, 3, $mq$The function is undefined when the denominator is zero: x + 1 = 0 gives x = −1.$mq$, $mq$easy$mq$),
($mq$What is the horizontal asymptote of y = 1/x + 2?$mq$, $mq$["y = 0","x = 2","y = 2","y = 1"]$mq$, 2, $mq$For large positive or negative x, 1/x is almost 0 so y is close to 2. The graph of y = 1/x is shifted up 2, so the horizontal asymptote moves from y = 0 to y = 2.$mq$, $mq$easy$mq$),
($mq$For y = 6/x, when x = 3 the value of y is 2. What is y when x = 6?$mq$, $mq$["4","1","2","12"]$mq$, 1, $mq$y = 6 ÷ 6 = 1. When x doubles, y halves, because y and x are inversely proportional.$mq$, $mq$easy$mq$),
($mq$The graph of y = 4/x has two separate curves. What are these curves called?$mq$, $mq$["Branches","Intercepts","Asymptotes","Tangents"]$mq$, 0, $mq$A reciprocal graph is made of two branches, one in each of two opposite quadrants. They approach the asymptotes but never touch them.$mq$, $mq$easy$mq$),
($mq$What are the asymptotes of y = 3/(x + 4) − 1?$mq$, $mq$["x = 4 and y = 1","x = −4 and y = 3","x = −1 and y = −4","x = −4 and y = −1"]$mq$, 3, $mq$The denominator x + 4 = 0 gives the vertical asymptote x = −4. The −1 shifts the graph down by 1, so the horizontal asymptote is y = −1.$mq$, $mq$medium$mq$),
($mq$What are the asymptotes of y = (2x + 1)/(x − 3)?$mq$, $mq$["x = −3 and y = 2","x = 3 and y = 1","x = 3 and y = 2","x = 3 and y = 0"]$mq$, 2, $mq$The denominator is zero at x = 3. For large x, the +1 and −3 matter less, so y ≈ 2x/x = 2, the ratio of the coefficients of x.$mq$, $mq$medium$mq$),
($mq$Where does y = (2x + 1)/(x − 3) cross the axes?$mq$, $mq$["(0, 1/3) and (1/2, 0)","(0, −1/3) and (−1/2, 0)","(0, −3) and (−2, 0)","(0, 2) and (3, 0)"]$mq$, 1, $mq$When x = 0, y = 1/(−3) = −1/3. When y = 0, the numerator is zero: 2x + 1 = 0 gives x = −1/2.$mq$, $mq$medium$mq$),
($mq$Solve 12/(x − 1) = 3.$mq$, $mq$["x = 5","x = 4","x = 13","x = 3"]$mq$, 0, $mq$Multiply by (x − 1): 12 = 3(x − 1), so 12 = 3x − 3 and x = 5. Check: 12 ÷ 4 = 3.$mq$, $mq$medium$mq$),
($mq$A 240 km journey at an average speed of v km/h takes t = 240/v hours. At 80 km/h it takes 3 hours. How long does it take if the average speed is 100 km/h?$mq$, $mq$["2 hours 40 minutes","2 hours 15 minutes","2 hours 4 minutes","2 hours 24 minutes"]$mq$, 3, $mq$t = 240 ÷ 100 = 2.4 hours. 0.4 of an hour is 0.4 × 60 = 24 minutes, so the time is 2 h 24 min. Writing 2.4 hours as 2 h 40 min is a decimal-time mistake.$mq$, $mq$medium$mq$),
($mq$What is the range of y = 1/(x − 2) + 3?$mq$, $mq$["All real y except y = 2","All real y except y = 0","All real y except y = 3","All real y"]$mq$, 2, $mq$The graph never reaches the horizontal asymptote y = 3, so y can be any real number except 3. The excluded value x = 2 is about the domain, not the range.$mq$, $mq$medium$mq$),
($mq$A graph has a vertical asymptote x = −1 and a horizontal asymptote y = 4. Which equation could it be?$mq$, $mq$["y = 1/(x − 1) + 4","y = 1/(x + 1) + 4","y = 1/(x + 1) − 4","y = 1/(x + 4) − 1"]$mq$, 1, $mq$1/(x + 1) is undefined at x = −1, and the + 4 shifts the graph up so the horizontal asymptote is y = 4. Check each option against both asymptotes.$mq$, $mq$medium$mq$),
($mq$For y = 8/x + 2, what happens as x becomes very large and positive?$mq$, $mq$["y gets closer to 2 from above but never equals 2","y gets closer to 0","y becomes very large","y becomes exactly 2"]$mq$, 0, $mq$As x grows, 8/x gets smaller but stays positive, so y is slightly more than 2. It approaches the asymptote y = 2 without reaching it.$mq$, $mq$medium$mq$),
($mq$Solve (2x + 1)/(x − 3) = 5.$mq$, $mq$["x = 16","x = 6","x = −2","x = 16/3"]$mq$, 3, $mq$Multiply by (x − 3): 2x + 1 = 5x − 15. Then 16 = 3x, so x = 16/3 ≈ 5.33. Check: (2 × 16/3 + 1) ÷ (16/3 − 3) = (35/3) ÷ (7/3) = 5.$mq$, $mq$hard$mq$),
($mq$A rational function has a vertical asymptote x = 2, a horizontal asymptote y = 3 and passes through (0, 4). Which equation fits?$mq$, $mq$["y = 2/(x − 2) + 3","y = 1/(x − 2) + 3","y = −2/(x − 2) + 3","y = −2/(x + 2) + 3"]$mq$, 2, $mq$Use y = a/(x − 2) + 3. At x = 0: a/(−2) + 3 = 4, so a/(−2) = 1 and a = −2. Check: −2/(−2) + 3 = 4.$mq$, $mq$hard$mq$),
($mq$A group hires a hall for £120 plus £15 per person. For n people, the cost per person is C = (120 + 15n)/n. What is the smallest whole number of people that makes the cost per person £18 or less?$mq$, $mq$["24","40","8","120"]$mq$, 1, $mq$C = 15 + 120/n. We need 120/n ≤ 3, so n ≥ 40. With 39 people, C = 15 + 120/39 ≈ £18.08, which is too high.$mq$, $mq$hard$mq$),
($mq$For C = 15 + 120/n, what does the horizontal asymptote C = 15 mean in context?$mq$, $mq$["The cost per person gets closer to £15 as the group grows, but is always above £15","The cost per person is £15 for every group","The hall costs £15","The cost per person can be less than £15 for large groups"]$mq$, 0, $mq$As n grows, 120/n tends to 0, so C approaches 15. Because 120/n is positive, C is always a little above 15. The £15 is the per-person charge once the hall fee is shared among very many people.$mq$, $mq$hard$mq$),
($mq$Which expression is equal to (3x − 5)/(x − 2), and so shows its horizontal asymptote?$mq$, $mq$["3 − 1/(x − 2)","3 + 5/(x − 2)","3x − 5/(x − 2)","3 + 1/(x − 2)"]$mq$, 3, $mq$Write 3x − 5 = 3(x − 2) + 1. Then (3(x − 2) + 1)/(x − 2) = 3 + 1/(x − 2). The horizontal asymptote is y = 3 and the vertical asymptote is x = 2.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Rational Functions and Asymptotes$mq$ and p.name = $mq$Functions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Reciprocal function$mq$, $mq$y = k/x. It has two branches and the axes are the asymptotes. It models inverse proportion.$mq$),
($mq$Asymptote$mq$, $mq$A line that a graph gets closer and closer to without touching.$mq$),
($mq$Vertical asymptote$mq$, $mq$Found where the denominator = 0 (and the numerator is not 0). For y = 1/(x − 3) it is x = 3.$mq$),
($mq$Horizontal asymptote of (ax + b)/(cx + d)$mq$, $mq$y = a/c. For (2x + 1)/(x − 3) it is y = 2.$mq$),
($mq$y = k/(x − p) + q$mq$, $mq$The graph of y = k/x moved p right and q up. Asymptotes: x = p and y = q.$mq$),
($mq$Finding intercepts$mq$, $mq$y-intercept: put x = 0. x-intercept: numerator = 0.$mq$),
($mq$Solving a rational equation$mq$, $mq$Multiply both sides by the denominator, solve, then check the answer is not the excluded value.$mq$),
($mq$Inverse proportion$mq$, $mq$When x doubles, y halves. The product xy is constant.$mq$),
($mq$Interpreting an asymptote$mq$, $mq$Say what it means in context, such as a cost per person that gets close to a fixed amount but never below it.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$extended-mathematics$mq$ and t.grade = 5 and t.name = $mq$Rational Functions and Asymptotes$mq$ and p.name = $mq$Functions$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Reciprocal functions
A rational function has an algebraic fraction in which the variable appears in the denominator. The simplest example is y = k/x. Its graph has two branches. If k > 0 the branches lie in the first and third quadrants, and if k < 0 they lie in the second and fourth. The graph never touches either axis. These lines are asymptotes: lines that a graph gets closer and closer to without reaching. The value y = k/x also describes inverse proportion: when x doubles, y halves.

## Vertical asymptotes
A vertical asymptote occurs where the denominator is zero but the numerator is not, because you cannot divide by zero. For y = 1/(x − 3), x − 3 = 0 gives x = 3, so the vertical asymptote is x = 3, and x = 3 is excluded from the domain. Near the asymptote the graph shoots up or down very steeply.

## Horizontal asymptotes
A horizontal asymptote shows what happens to y when x is very large (positive or negative). In y = 1/x + 2, the 1/x part becomes almost 0, so y gets closer to 2, and the horizontal asymptote is y = 2. For a function of the form (ax + b)/(cx + d), the horizontal asymptote is y = a/c. For example, (2x + 1)/(x − 3) has horizontal asymptote y = 2, because the leading coefficients are 2 and 1. The range excludes this value.

## Transformations
The graph of y = k/(x − p) + q is the graph of y = k/x translated p units right and q units up. Its asymptotes are x = p and y = q. So y = 3/(x + 4) − 1 has asymptotes x = −4 and y = −1.

## Rewriting a fraction
You can rewrite (3x − 5)/(x − 2) by splitting the numerator: 3x − 5 = 3(x − 2) + 1. Then the fraction is 3 + 1/(x − 2). This shows the horizontal asymptote y = 3 and vertical asymptote x = 2 immediately.

## Finding intercepts and solving
- y-intercept: substitute x = 0.
- x-intercept: set the numerator equal to 0 (the denominator must not also be 0).
- To solve an equation such as (2x + 1)/(x − 3) = 5, multiply both sides by the denominator, solve, and then check your answer is not the excluded value. Here 2x + 1 = 5x − 15 gives x = 16/3.

## Rational functions in real life
Many real models are rational: time = distance ÷ speed (t = 240/v), and cost per person = total cost ÷ number of people (C = (120 + 15n)/n = 15 + 120/n). The asymptote has a meaning in context: the cost per person never falls below £15, however large the group. You should also state the sensible domain (for example n must be a positive whole number) and the limitations of the model.

## Common mistakes
- Writing the vertical asymptote with the wrong sign (x + 2 = 0 gives x = −2).
- Confusing which asymptote is horizontal and which is vertical.
- Saying a graph "crosses" its asymptote, or that y = 0 at the asymptote.
- Forgetting to check that the solution is not the excluded value.

## How this is examined
You may be given a real situation, such as a journey or a shared cost, and asked to form the function, state its domain, identify and explain the asymptotes in context, solve an equation and judge how reliable the model is. Extended tasks ask you to compare models or to explain why the model breaks down for extreme values.

Exam tip: When asked to interpret an asymptote, always use the context: say what the variable stands for and what the value means, for example "the cost per person approaches but never goes below £15".$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('extended-mathematics')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;