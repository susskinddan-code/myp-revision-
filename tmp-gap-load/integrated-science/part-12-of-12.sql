-- Part 12 of 12: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Scientific Inquiry Skills > Designing Fair Investigations
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Scientific Inquiry Skills$mq$, 5, 12 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Designing Fair Investigations$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Scientific Inquiry Skills$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Designing Fair Investigations$mq$ and p.name = $mq$Scientific Inquiry Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In an investigation, what is the independent variable?$mq$, $mq$["The variable that the investigator changes","The variable that is measured","The variable kept the same","The result that is predicted"]$mq$, 0, $mq$The independent variable is deliberately changed. The dependent variable is measured, and control variables are kept constant.$mq$, $mq$easy$mq$),
($mq$In an investigation on how temperature affects the rate of an enzyme reaction, what is the dependent variable?$mq$, $mq$["The temperature","The type of enzyme","The volume of solution","The rate of reaction"]$mq$, 3, $mq$The rate is what you measure to see the effect of changing temperature.$mq$, $mq$easy$mq$),
($mq$Why should an experiment be repeated several times?$mq$, $mq$["To change the independent variable","To prove the hypothesis is true","To identify anomalies and improve reliability","To make the experiment more dangerous"]$mq$, 2, $mq$Repeats allow a mean to be calculated, anomalies to be spotted and random errors to be reduced.$mq$, $mq$easy$mq$),
($mq$Which of these is a testable hypothesis?$mq$, $mq$["Hot water is nicer","If the temperature of water increases, then sugar will dissolve faster","Sugar is sweet","Scientists like experiments"]$mq$, 1, $mq$A testable hypothesis states a relationship between variables that can be measured, ideally with a reason.$mq$, $mq$easy$mq$),
($mq$What is a control variable?$mq$, $mq$["A factor kept the same so the test is fair","The variable that is measured","The variable that is changed","The final conclusion"]$mq$, 0, $mq$Control variables are kept constant so that only the independent variable affects the dependent variable.$mq$, $mq$easy$mq$),
($mq$A student tests how the mass of a trolley affects its speed down a ramp. Which is a control variable?$mq$, $mq$["The mass of the trolley","The speed","The student's name","The height of the ramp"]$mq$, 3, $mq$The ramp height must stay the same. Mass is the independent variable and speed is the dependent variable.$mq$, $mq$medium$mq$),
($mq$A student investigates how light intensity affects plant growth. One group of plants is placed in a bright room that is also warmer than the dark room. What is the main problem?$mq$, $mq$["The plants should be larger","Light cannot affect growth","Temperature is a second variable that is not controlled","The experiment has too many repeats"]$mq$, 2, $mq$Temperature differs along with light, so any difference in growth could be due to either. This makes the test unfair.$mq$, $mq$medium$mq$),
($mq$Why is a control group used in a drug trial?$mq$, $mq$["To give all patients the drug","To compare with the group receiving the treatment","To make the trial cheaper","To avoid repeating the trial"]$mq$, 1, $mq$A control group (often given a placebo) shows what happens without the treatment, so the effect of the drug can be isolated.$mq$, $mq$medium$mq$),
($mq$To measure 5 cm³ of acid accurately, which is the best choice?$mq$, $mq$["A 10 cm³ measuring cylinder","A 250 cm³ beaker","A 1000 cm³ measuring cylinder","A 100 cm³ measuring cylinder"]$mq$, 0, $mq$A smaller measuring instrument has a finer scale, giving a smaller percentage uncertainty for a small volume.$mq$, $mq$medium$mq$),
($mq$A student plans to test the effect of temperature on dissolving using 0°C, 20°C, 40°C, 60°C and 80°C. Why is this a good choice of values?$mq$, $mq$["It uses only one temperature","It has an uneven spacing","It tests only the extremes","It covers a wide range with equal intervals"]$mq$, 3, $mq$A wide range with equal intervals helps show the pattern clearly and allows a graph to be drawn.$mq$, $mq$medium$mq$),
($mq$Which is the best safety precaution when heating a liquid in a test tube?$mq$, $mq$["Heat the test tube while looking into it","Seal the test tube with a stopper","Wear eye protection and point the tube away from people","Touch the tube to check its temperature"]$mq$, 2, $mq$Wear eye protection, use a holder, and point the tube away from yourself and others. Never seal a heated tube.$mq$, $mq$medium$mq$),
($mq$A hypothesis says: 'If concentration of salt increases, the mass of a potato slice decreases, because water leaves by osmosis.' Which part is the scientific explanation?$mq$, $mq$["If concentration of salt increases","Because water leaves by osmosis","The mass decreases","A potato slice"]$mq$, 1, $mq$The 'because' clause links the prediction to scientific knowledge.$mq$, $mq$medium$mq$),
($mq$A student measures reaction time with a ruler drop test. She carries out three trials with each of 10 volunteers. Why are 10 volunteers better than 1?$mq$, $mq$["It reduces the effect of individual differences","It makes the test faster","It removes all errors","It makes the independent variable change"]$mq$, 0, $mq$A larger sample is more representative and reduces the effect of one unusual individual.$mq$, $mq$medium$mq$),
($mq$A student records the mass of a balance as 0.3 g when nothing is on it. What type of error is this, and what should she do?$mq$, $mq$["Random error; take more readings","Anomaly; ignore the balance","Human error; blame the teacher","Systematic (zero) error; subtract 0.3 g from every reading"]$mq$, 3, $mq$A zero error shifts all readings by the same amount. Correct it by subtracting or by re-zeroing the balance.$mq$, $mq$hard$mq$),
($mq$Which plan gives the fairest test of whether detergent type affects how well stains are removed?$mq$, $mq$["Different cloths and stains for each detergent","Hot water for one detergent and cold for another","Same cloth, same stain, same temperature and volume, and only the detergent changes","Each detergent used on a different day by a different person"]$mq$, 2, $mq$Everything except the detergent is kept constant, so only the independent variable can explain differences.$mq$, $mq$hard$mq$),
($mq$A student's results are close together but all about 2 cm lower than the true value. What best describes the results?$mq$, $mq$["Accurate but not precise","Precise but not accurate","Both accurate and precise","Neither precise nor repeatable"]$mq$, 1, $mq$Results that agree with each other are precise. Results that are far from the true value are not accurate, which suggests a systematic error.$mq$, $mq$hard$mq$),
($mq$A student wants to investigate whether caffeine affects heart rate in volunteers. Which is the most important ethical step?$mq$, $mq$["Get informed consent and make sure that participants can withdraw","Hide the purpose from the participants and give them a large dose","Test only on animals","Choose participants who cannot refuse"]$mq$, 0, $mq$Human participants should agree freely after being told the risks and be allowed to stop at any time. Doses should be safe.$mq$, $mq$hard$mq$),
($mq$Which change would most improve the validity of a test of how fertiliser affects plant growth?$mq$, $mq$["Measuring only the tallest plant","Using different plant species in each group","Giving different amounts of water to groups","Using the same plant species, soil and light for all plants and measuring growth the same way"]$mq$, 3, $mq$Validity means the investigation measures what it claims to. Controlling other variables and measuring consistently makes the conclusion valid.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Designing Fair Investigations$mq$ and p.name = $mq$Scientific Inquiry Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Independent variable$mq$, $mq$The variable you deliberately change in an investigation.$mq$),
($mq$Dependent variable$mq$, $mq$The variable you measure to see the effect of the change.$mq$),
($mq$Control variables$mq$, $mq$Factors kept constant so that the test is fair. Always say how each is controlled.$mq$),
($mq$Hypothesis$mq$, $mq$A testable prediction, ideally using if... then... because... with a scientific explanation.$mq$),
($mq$Reliable vs valid$mq$, $mq$Reliable: can be repeated with similar results. Valid: measures what it claims to and controls other variables.$mq$),
($mq$Accurate vs precise$mq$, $mq$Accurate: close to the true value. Precise: results close to each other.$mq$),
($mq$Random vs systematic error$mq$, $mq$Random: unpredictable variation, reduced by repeats. Systematic: same shift every time, such as a zero error.$mq$),
($mq$Control group$mq$, $mq$A group not given the treatment (or given a placebo) used for comparison.$mq$),
($mq$Risk assessment$mq$, $mq$Identify the hazard, the risk and the precaution, such as eye protection when heating liquids.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Designing Fair Investigations$mq$ and p.name = $mq$Scientific Inquiry Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Science is about asking questions that can be tested and then collecting evidence. A good investigation is planned carefully so that the results can be trusted. This is the heart of the MYP sciences Criterion B (inquiring and designing).

## From question to hypothesis
Start with a focused research question, for example: How does temperature affect the rate at which an enzyme breaks down starch? A **hypothesis** is a testable prediction, ideally with a scientific explanation: If the temperature increases (up to the optimum), the rate of reaction will increase, because particles have more kinetic energy so more collisions occur.

## Variables
- **Independent variable**: the one you change (for example temperature).
- **Dependent variable**: the one you measure (for example time for the starch to disappear).
- **Control variables**: everything else you keep constant (volume, concentration, enzyme type, pH). Name them and say how each is controlled.
If more than one thing changes, you cannot tell which caused the result. This is why the test is not fair.

## Choosing method and apparatus
- Choose a **range** and sensible **intervals**, for example 20, 30, 40, 50 and 60°C, to see a pattern.
- Choose equipment with suitable **resolution**. To measure 5 cm³, a 10 cm³ measuring cylinder gives a smaller percentage uncertainty than a 100 cm³ one.
- Plan **repeats** (at least three) so you can calculate a mean and spot anomalies.
- Use a large enough **sample** where living things are involved, because individuals vary.
- Include a **control** (comparison) group when testing a treatment, such as a placebo in a drug trial.
- Write numbered, clear steps that another person could follow.

## Errors, accuracy and precision
- **Random errors** vary from reading to reading, for example timing a reaction by eye. Repeats and averaging reduce them.
- **Systematic errors** shift all readings in the same direction, for example a balance that reads 0.3 g with nothing on it. Check zero readings and calibrate equipment.
- **Accurate** results are close to the true value. **Precise** results are close to each other. A set of results can be precise but not accurate if there is a systematic error.
- **Reliable** results can be repeated and **valid** results measure what the question is asking.

## Safety and ethics
Complete a risk assessment: hazard, risk, precaution. For example, hot water scalds, so use a heatproof mat and tongs. Wear eye protection when heating liquids or using chemicals. When using people or animals in an investigation, get informed consent from people, minimise harm and have clear reasons for the work.

## How this is examined
You may be given a short scenario, for example a student wanting to test whether temperature affects dissolving. You then identify the variables, point out a flaw in the method, improve the design and justify your choices. Use phrases such as "to make the test fair", "to improve reliability" and "so that only the independent variable changes".

## Common mistakes
- Naming variables vaguely (say "volume of water in cm³", not "water").
- Saying "repeat to make it accurate". Repeats improve reliability.
- Forgetting the units, or leaving out safety.

Exam tip: When asked to identify a flaw, say what was wrong, why it affects the results and how to fix it. When asked to design, state the three variable types, the range and intervals, the equipment with units and the number of repeats.$mq$ from st;

-- Scientific Inquiry Skills > Processing Data and Evaluating Conclusions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Scientific Inquiry Skills$mq$, 5, 12 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Processing Data and Evaluating Conclusions$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Scientific Inquiry Skills$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Processing Data and Evaluating Conclusions$mq$ and p.name = $mq$Scientific Inquiry Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$How is the mean of a set of results calculated?$mq$, $mq$["Add all values and divide by the number of values","Find the middle value","Find the most frequent value","Subtract the smallest from the largest"]$mq$, 0, $mq$Mean = total ÷ number of values. The middle value is the median and the most frequent is the mode.$mq$, $mq$easy$mq$),
($mq$A student measured the time for a ball to fall: 1.1 s, 1.2 s, 2.6 s, 1.1 s. Which result is an anomaly?$mq$, $mq$["1.1 s","1.2 s","None","2.6 s"]$mq$, 3, $mq$2.6 s is far from the others and probably caused by a mistake, so it should be investigated and usually left out of the mean.$mq$, $mq$easy$mq$),
($mq$Which type of graph is best for plotting temperature (a continuous variable) against time?$mq$, $mq$["Pie chart","Bar chart of categories","Line graph","Pictogram"]$mq$, 2, $mq$Two continuous variables are shown on a line graph or scatter graph with a line of best fit.$mq$, $mq$easy$mq$),
($mq$On a graph, which variable goes on the x-axis?$mq$, $mq$["The dependent variable","The independent variable","The control variable","The anomaly"]$mq$, 1, $mq$The independent variable goes on the x-axis (horizontal) and the dependent variable on the y-axis.$mq$, $mq$easy$mq$),
($mq$What is the range of the results 34, 36, 35, 35, 40?$mq$, $mq$["6","36","40","5"]$mq$, 0, $mq$Range = largest − smallest = 40 − 34 = 6.$mq$, $mq$easy$mq$),
($mq$A student measured the length of a spring four times: 12.1 cm, 12.3 cm, 15.8 cm, 12.2 cm. 15.8 cm is identified as an anomaly. What is the mean of the other results?$mq$, $mq$["13.1 cm","12.3 cm","15.8 cm","12.2 cm"]$mq$, 3, $mq$(12.1 + 12.3 + 12.2) ÷ 3 = 12.2 cm. Including the anomaly would give 13.1 cm.$mq$, $mq$medium$mq$),
($mq$A plant grows from 8.0 cm to 10.0 cm over a week. What is the percentage increase?$mq$, $mq$["20%","2%","25%","80%"]$mq$, 2, $mq$(10.0 − 8.0) ÷ 8.0 × 100 = 25%. Dividing by the final value would wrongly give 20%.$mq$, $mq$medium$mq$),
($mq$A gas syringe collects 24 cm³ of gas in 40 s. What is the mean rate of gas production?$mq$, $mq$["1.7 cm³/s","0.6 cm³/s","64 cm³/s","960 cm³/s"]$mq$, 1, $mq$Rate = volume ÷ time = 24 ÷ 40 = 0.6 cm³/s.$mq$, $mq$medium$mq$),
($mq$A student measures the acceleration due to gravity as 9.4 m/s². The accepted value is 9.8 m/s². What is the percentage error, to one decimal place?$mq$, $mq$["4.1%","4.3%","0.4%","41%"]$mq$, 0, $mq$|9.4 − 9.8| ÷ 9.8 × 100 = 4.08%, which rounds to 4.1%.$mq$, $mq$medium$mq$),
($mq$A table shows the extension of a spring: load 1 N: 2.0 cm, 2 N: 4.1 cm, 3 N: 5.9 cm, 4 N: 8.0 cm. What is the best description of the pattern?$mq$, $mq$["Extension decreases as load increases","Extension is constant","There is no pattern","Extension is directly proportional to load"]$mq$, 3, $mq$The extension per newton is about 2 cm each time, so the relationship is approximately directly proportional.$mq$, $mq$medium$mq$),
($mq$What does a line of best fit show?$mq$, $mq$["The exact path through every point","The anomaly","The general trend through the data","The mean of the x-values"]$mq$, 2, $mq$A line of best fit shows the overall trend and does not need to pass through every point.$mq$, $mq$medium$mq$),
($mq$Why should results be recorded to the same number of decimal places as the instrument's resolution?$mq$, $mq$["It makes the table look longer","It reflects the precision of the measurement","It removes errors","It changes the units"]$mq$, 1, $mq$A ruler marked in mm should be read to the nearest mm. Extra digits would give a false impression of precision.$mq$, $mq$medium$mq$),
($mq$A graph of distance against time for a trolley is a straight line through the origin, passing through (8 s, 20 m). What is the speed?$mq$, $mq$["2.5 m/s","0.4 m/s","160 m/s","12 m/s"]$mq$, 0, $mq$Gradient = 20 ÷ 8 = 2.5 m/s, and a straight line means constant speed.$mq$, $mq$medium$mq$),
($mq$A student writes a conclusion: 'Plants given fertiliser grew taller (mean 22 cm versus 15 cm), so fertiliser causes growth.' Only 3 plants were used in each group. What is the best improvement?$mq$, $mq$["Remove the control group","Use a different type of plant","Only measure the tallest plant","Use more plants, repeat the investigation and control other variables"]$mq$, 3, $mq$A larger sample and repeats increase reliability. Controlling other variables supports the claim of cause.$mq$, $mq$hard$mq$),
($mq$The percentage uncertainty of a measurement is (uncertainty ÷ measured value) × 100. A ruler has an uncertainty of ±0.5 mm. What is the percentage uncertainty when it is used to measure a 20 mm length, and what does it suggest?$mq$, $mq$["25%; the ruler is accurate","0.4%; the measurement is exact","2.5%; a larger length would give a smaller percentage uncertainty","2.5%; the uncertainty is independent of the length"]$mq$, 2, $mq$0.5 ÷ 20 × 100 = 2.5%. Measuring a longer length reduces the percentage uncertainty.$mq$, $mq$hard$mq$),
($mq$Ice cream sales and drowning incidents both rise in summer. Which interpretation is best?$mq$, $mq$["Ice cream causes drowning","They are correlated, but a third factor (hot weather) probably explains both","Drowning causes ice cream sales","There is no relationship at all"]$mq$, 1, $mq$A correlation does not prove causation. A common cause, warm weather, probably increases both.$mq$, $mq$hard$mq$),
($mq$Data on pulse rate (beats per minute) after exercise for 5 students: 110, 118, 114, 112, 116. Mean pulse is 114. A student claims 'exercise increases pulse rate'. What data is missing for a fair conclusion?$mq$, $mq$["Resting pulse rates for comparison","The age of the teacher","The colour of the shoes","The temperature of the sun"]$mq$, 0, $mq$Without a baseline for comparison, we cannot say that exercise increased the pulse. Resting data gives the comparison.$mq$, $mq$hard$mq$),
($mq$An experiment on plant growth gives a mean of 6.0 cm for light group A and 5.9 cm for group B, each with a range of about 2 cm. What is the best conclusion?$mq$, $mq$["Group A is definitely better","Group B is definitely worse","The experiment proves the light has no effect on anything","The difference is small compared with the variation, so there is no clear evidence of an effect"]$mq$, 3, $mq$A difference of 0.1 cm is much smaller than the spread of results, so the data does not clearly show a difference.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Processing Data and Evaluating Conclusions$mq$ and p.name = $mq$Scientific Inquiry Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Mean$mq$, $mq$Total of the values ÷ number of values. Exclude and justify any anomalies.$mq$),
($mq$Anomaly$mq$, $mq$A result that does not fit the pattern. Check for a mistake and say if it is excluded from the mean.$mq$),
($mq$Range$mq$, $mq$Largest value − smallest value.$mq$),
($mq$Percentage change$mq$, $mq$(New − old) ÷ old × 100.$mq$),
($mq$Percentage error$mq$, $mq$|Measured − accepted| ÷ accepted × 100.$mq$),
($mq$Graph rules$mq$, $mq$Independent variable on the x-axis, dependent on the y-axis, labelled axes with units, sensible scale, line of best fit.$mq$),
($mq$Directly proportional$mq$, $mq$A straight line through the origin: when one variable doubles, the other doubles.$mq$),
($mq$Correlation and causation$mq$, $mq$A correlation does not prove causation. A third factor may affect both variables.$mq$),
($mq$Evaluating a conclusion$mq$, $mq$Use data, comment on reliability (sample size, repeats), name errors, suggest specific improvements.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Processing Data and Evaluating Conclusions$mq$ and p.name = $mq$Scientific Inquiry Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Collecting data is only half the job. The other half is processing and presenting it so that patterns become clear, then deciding whether your conclusion is justified. This is the MYP sciences Criterion C (processing and evaluating) in action.

## Recording data
Use a table with a clear title, headings and units in the heading (for example Time (s)). Record raw data to a consistent number of decimal places that matches the instrument. Include repeats in separate columns and then a mean.

## Calculations
- **Mean** = total of the values ÷ number of values. Worked example: 12.1, 12.3, 12.2 cm gives (12.1 + 12.3 + 12.2) ÷ 3 = 12.2 cm.
- **Anomaly**: a result that does not fit the pattern, for example 15.8 cm in the set above. Check if it came from a mistake, and exclude it from the mean if justified, saying that you have done so.
- **Range** = largest − smallest. A large range suggests the data are not very precise.
- **Rate** = amount ÷ time. For 24 cm³ of gas in 40 s the rate is 0.6 cm³/s.
- **Percentage change** = (new − old) ÷ old × 100. From 8.0 cm to 10.0 cm is a 25% increase.
- **Percentage error** = |measured − accepted| ÷ accepted × 100. For 9.4 compared with 9.8 it is about 4.1%.
- **Gradient** of a distance–time graph is speed. A line through (8 s, 20 m) has a gradient of 20 ÷ 8 = 2.5 m/s.

## Graphs
- Independent variable on the x-axis, dependent variable on the y-axis.
- Choose a scale that uses at least half the grid, label both axes with quantities and units, and plot points accurately.
- Draw a **line of best fit** (a smooth curve or a straight line, not dot-to-dot). It does not need to pass through every point.
- Use a bar chart when one variable is a category (for example type of fuel), and a line graph when both variables are continuous.

## Describing patterns
Say what happens to the dependent variable as the independent variable changes, and use numbers: "As the temperature rose from 20°C to 60°C, the rate of reaction increased from 0.2 to 1.0 cm³/s". Terms include directly proportional (a straight line through the origin), inverse relationship, positive correlation and no correlation. Correlation does not prove causation. Two variables might both be affected by a third factor.

## Evaluating a conclusion
1. State whether the data support the hypothesis, using figures.
2. Judge the reliability: sample size, repeats, range of results.
3. Identify sources of error (random and systematic) and the effect each has.
4. Suggest specific improvements, such as more repeats, a smaller interval, a digital probe or a larger sample.
5. Suggest further investigations.

## Limitations
Conclusions only apply to the range tested. If you tested 20–60°C you cannot predict the rate at 100°C. A small difference compared with the variation in the results does not show a real effect.

## How this is examined
Expect a data table or a short description of an experiment, then questions on calculating a mean, spotting an anomaly, finding a percentage error, describing a trend and evaluating whether a conclusion is justified. Longer questions ask you to suggest improvements and explain how each improves the results.

Exam tip: Quote numbers from the data in every description or conclusion. For evaluation, always pair a limitation with a specific improvement and say how the improvement helps.$mq$ from st;

-- Scientific Inquiry Skills > Science, Society and Ethical Impact
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Scientific Inquiry Skills$mq$, 5, 12 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Science, Society and Ethical Impact$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Scientific Inquiry Skills$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Science, Society and Ethical Impact$mq$ and p.name = $mq$Scientific Inquiry Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is peer review?$mq$, $mq$["Experts checking a scientific report before it is published","A teacher marking homework","A company advertising a product","A newspaper summarising a study"]$mq$, 0, $mq$Peer review is when independent experts evaluate methods, data and conclusions before publication.$mq$, $mq$easy$mq$),
($mq$What is a scientific model?$mq$, $mq$["A perfect copy of reality","A fixed fact that never changes","A type of experiment without data","A representation used to explain or predict something"]$mq$, 3, $mq$Models simplify reality to help explain and predict. They are changed when new evidence appears.$mq$, $mq$easy$mq$),
($mq$Which is an example of technology based on scientific knowledge?$mq$, $mq$["A rock","A cloud","An MRI scanner","A mountain"]$mq$, 2, $mq$Technology is the practical application of science, such as medical scanners, vaccines or solar panels.$mq$, $mq$easy$mq$),
($mq$Which of these is a renewable energy resource?$mq$, $mq$["Coal","Wind","Oil","Natural gas"]$mq$, 1, $mq$Wind is replaced naturally and does not run out. Fossil fuels are non-renewable.$mq$, $mq$easy$mq$),
($mq$Why is it important to use more than one source when researching a scientific claim?$mq$, $mq$["To check whether independent sources agree","To make the research longer","To avoid reading anything critically","To find the most popular opinion"]$mq$, 0, $mq$Cross-checking helps reveal bias or errors, and agreement from independent reliable sources strengthens a claim.$mq$, $mq$easy$mq$),
($mq$Which source of information about a new medicine is likely to be most reliable?$mq$, $mq$["An advertisement by the manufacturer","A social media post by a celebrity","A friend's opinion","A peer-reviewed journal report of a large controlled trial"]$mq$, 3, $mq$Peer-reviewed controlled trials are checked by independent experts. Adverts and personal opinions may be biased.$mq$, $mq$medium$mq$),
($mq$A clinical trial gives a new drug to one group and a placebo to another. Neither patients nor doctors know who gets which. What is this called?$mq$, $mq$["Single sample","Open trial","Double-blind trial","Observation only"]$mq$, 2, $mq$In a double-blind trial neither the patients nor the researchers know who receives the treatment. This reduces bias.$mq$, $mq$medium$mq$),
($mq$A company that sells a sports drink pays for a study that concludes the drink improves performance. Which concern is most valid?$mq$, $mq$["The study must be correct since it was funded","The funding source may bias the study","Sports drinks cannot be studied","Performance cannot be measured"]$mq$, 1, $mq$A conflict of interest does not make the study wrong, but its design and data should be checked carefully, ideally with independent replication.$mq$, $mq$medium$mq$),
($mq$A newspaper headline says 'Chocolate makes you cleverer!' based on a survey of 20 people that found a link. Which is the best response?$mq$, $mq$["The sample is small and the study shows a correlation only","The headline must be true because it is in print","Chocolate is proven to cause intelligence","The survey proves the opposite"]$mq$, 0, $mq$A small sample and correlation do not show a cause. More controlled evidence is required.$mq$, $mq$medium$mq$),
($mq$Which statement about the use of animals in medical research is the most balanced?$mq$, $mq$["It has no ethical issues","It should always be done without rules","It is never of any use","It may lead to medical advances, but it raises ethical concerns, so the number and suffering should be minimised"]$mq$, 3, $mq$Ethical evaluation weighs benefits against harm. The 3Rs principle (replace, reduce, refine) is widely used to guide research.$mq$, $mq$medium$mq$),
($mq$A town replaces a coal power station with a wind farm. Which is the best example of an environmental benefit and a drawback?$mq$, $mq$["Benefit: no cost; drawback: none","Benefit: more smoke; drawback: less wind","Benefit: lower CO₂ emissions; drawback: possible effects on birds and the landscape","Benefit: more coal; drawback: more rain"]$mq$, 2, $mq$Wind turbines do not release CO₂ in operation. Drawbacks include visual impact, effects on birds and variable output.$mq$, $mq$medium$mq$),
($mq$Why can scientific knowledge change over time?$mq$, $mq$["Scientists change their minds randomly","New evidence and better technology can show earlier ideas to be incomplete","Old ideas are always false","Facts are decided by votes"]$mq$, 1, $mq$Science is self-correcting. Theories are accepted because of evidence and revised when new evidence is found.$mq$, $mq$medium$mq$),
($mq$Which of these decisions needs scientific evidence AND an ethical or social judgement?$mq$, $mq$["Whether to allow genetically modified crops","The boiling point of water","The mass of an electron","The number of planets"]$mq$, 0, $mq$Science supplies data on benefits and risks, but societies must also weigh values, costs and fairness.$mq$, $mq$medium$mq$),
($mq$A city plans to build a new incinerator for waste. Which group is MOST likely to be affected negatively?$mq$, $mq$["Everyone who visits the city once","People in a different continent","Scientists who study fish","People who live next to the site"]$mq$, 3, $mq$Stakeholders who live close to the site experience the noise, traffic and air quality effects most directly. A full evaluation considers all stakeholders.$mq$, $mq$hard$mq$),
($mq$A report says a new pesticide reduces insect pests by 80%. Which additional information is most important before approving it?$mq$, $mq$["The colour of the bottle","The price of other pesticides only","Effects on beneficial insects, water and human health from independent tests","The name of the sales manager"]$mq$, 2, $mq$Benefits must be weighed against risks. Independent environmental and health testing is needed.$mq$, $mq$hard$mq$),
($mq$Vaccination programmes protect vulnerable people by herd immunity. Which statement best shows a justified argument for vaccination?$mq$, $mq$["It must be right because doctors say so","It reduces disease spread in the population, supported by evidence of lower infection rates","It never has any side effects, so there is nothing to discuss","It is only useful for adults"]$mq$, 1, $mq$A justified argument uses evidence (lower infection rates) and acknowledges that side effects are rare but monitored.$mq$, $mq$hard$mq$),
($mq$A student must decide whether to recommend a hydroelectric dam. Which response shows the highest-quality evaluation?$mq$, $mq$["Compares clean energy and flood control with habitat loss and displaced communities, using data, and reaches a justified conclusion","Lists only advantages","States an opinion without reasons","Says it is impossible to decide"]$mq$, 0, $mq$A strong evaluation balances ecological, economic and social impacts, uses evidence and gives a reasoned conclusion.$mq$, $mq$hard$mq$),
($mq$Which statement about the precautionary approach is correct?$mq$, $mq$["It supports releasing any new technology at once","It requires proof that no risk exists","It only applies to computers","It supports limiting a new technology when evidence suggests possible serious harm, even if uncertain"]$mq$, 3, $mq$The precautionary approach is to act to prevent possible serious harm when full certainty is not yet available, while research continues.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Science, Society and Ethical Impact$mq$ and p.name = $mq$Scientific Inquiry Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Peer review$mq$, $mq$Independent experts check a study's methods and conclusions before it is published.$mq$),
($mq$Technology$mq$, $mq$The application of scientific knowledge to solve practical problems, such as vaccines and wind turbines.$mq$),
($mq$Conflict of interest$mq$, $mq$When the funder or author benefits from a particular result. It is a reason to check methods and look for independent replication.$mq$),
($mq$Double-blind trial$mq$, $mq$Neither the participants nor the researchers know who receives the treatment or placebo, which reduces bias.$mq$),
($mq$Placebo$mq$, $mq$A treatment with no active ingredient, given to the control group for comparison.$mq$),
($mq$Stakeholder$mq$, $mq$A person or group affected by a decision, such as residents, workers, businesses or future generations.$mq$),
($mq$Precautionary approach$mq$, $mq$Limit or delay a technology when there is a plausible risk of serious harm, even if evidence is incomplete.$mq$),
($mq$The 3Rs$mq$, $mq$Replace animals where possible, reduce numbers used, refine methods to reduce suffering.$mq$),
($mq$Strong evaluation$mq$, $mq$Give evidence for and against, compare short- and long-term effects and groups affected, then make a justified conclusion.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Science, Society and Ethical Impact$mq$ and p.name = $mq$Scientific Inquiry Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Science does not take place in isolation. Scientific discoveries lead to technologies that change how we live, and society influences which research is funded and how it is done. This is the focus of MYP sciences Criterion D (reflecting on the impacts of science), which asks you to discuss and evaluate the implications of science in real-world contexts.

## How science works in society
Scientists collect evidence, publish their methods and results, and have them checked by other experts in **peer review**. Other scientists try to replicate the findings. Scientific theories and models are accepted because of the weight of evidence, and they are revised when new evidence appears. This is a strength of science, not a weakness. **Technology** is the application of scientific knowledge to solve practical problems, such as vaccines, MRI scanners, wind turbines and water purification.

## Judging evidence and sources
When you read a claim, ask these questions.
- Who made the claim, and do they have expertise?
- Was it **peer-reviewed**, or is it an advert, a social media post or an opinion?
- Is there a **conflict of interest**, such as the study being funded by a company that sells the product? This does not make it wrong, but it means you should look at the methods and look for independent replication.
- Is the **sample size** large enough, and was there a **control group**? In medical trials, a **placebo** and a **double-blind** design (neither patient nor researcher knows who has the treatment) reduce bias.
- Does the evidence show a **correlation** only, or good evidence of cause?
- Do independent sources agree?

## Benefits, risks and ethics
Most scientific developments have benefits and risks, and they affect people differently. Examples:
- **Genetic modification**: higher yields and improved nutrition against concerns for biodiversity and ownership.
- **Fossil fuels versus renewables**: reliable energy against greenhouse gas emissions; wind and solar have lower emissions but variable output and land use.
- **Animal research**: possible medical advances against animal welfare. The 3Rs (replace, reduce, refine) aim to limit the harm.
- **Vaccination**: protects individuals and the community through herd immunity; very rare side effects are monitored.
- **Plastics**: useful and cheap, but cause waste and pollution.
The **precautionary approach** supports limiting a technology when there is a plausible risk of serious harm, even if the evidence is incomplete.

## Stakeholders and global contexts
Stakeholders are the people or groups affected by a decision: residents, workers, businesses, governments, future generations and wildlife. A good answer names at least two stakeholders and explains how each is affected. Link your answer to a global context, for example scientific and technical innovation, globalization and sustainability, or fairness and development.

## Writing a strong evaluation
- State the issue and the options.
- Give evidence for each side, with data where possible.
- Compare short-term and long-term impacts, and local and global impacts.
- Reach a justified conclusion and say what further evidence would help.

## How this is examined
You may get a short article about, for example, a hydroelectric dam, with data. You are asked to summarise the scientific idea, explain the issue, discuss the implications for different groups and evaluate the reliability of the information.

Exam tip: Avoid one-sided answers. For every benefit give a limitation, name the stakeholder who is affected, use the evidence given and end with a clear, justified judgement.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('integrated-science')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;