-- Part 8 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Investigating Environmental Systems > Fieldwork and Sampling
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Investigating Environmental Systems$mq$, 5, 8 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Fieldwork and Sampling$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Investigating Environmental Systems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Fieldwork and Sampling$mq$ and p.name = $mq$Investigating Environmental Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a quadrat?$mq$, $mq$["A square frame placed on the ground to sample the organisms inside it","A tool for measuring wind speed","A net for catching fish","A type of thermometer"]$mq$, 0, $mq$Quadrats are used to estimate abundance or percentage cover of plants and slow-moving animals in a defined area.$mq$, $mq$easy$mq$),
($mq$Why do ecologists sample instead of counting every organism in an area?$mq$, $mq$["Sampling is always more accurate than a full count","Organisms are too small to count","Counting is illegal","It is usually impossible or too time-consuming to count everything"]$mq$, 3, $mq$A well-designed sample lets us estimate the whole population using a smaller area.$mq$, $mq$easy$mq$),
($mq$Which is an abiotic factor you could measure in a woodland?$mq$, $mq$["Number of oak trees","Number of birds","Light intensity","Presence of fungi"]$mq$, 2, $mq$Abiotic factors are non-living, such as light, temperature, pH and soil moisture. Organisms are biotic.$mq$, $mq$easy$mq$),
($mq$What is a transect?$mq$, $mq$["A kind of fish net","A line along which samples are taken to show change across an area","A random number","A type of graph"]$mq$, 1, $mq$Transects are used to study change along a gradient, such as from the sea inland or from a path into woodland.$mq$, $mq$easy$mq$),
($mq$Which action is part of safe and ethical fieldwork?$mq$, $mq$["Doing a risk assessment and leaving the site as you found it","Taking all rare plants home","Working alone in remote places without telling anyone","Ignoring weather forecasts"]$mq$, 0, $mq$Plan for hazards, follow permissions and minimise damage to habitats.$mq$, $mq$easy$mq$),
($mq$In five 1 m² quadrats the numbers of daisies were 12, 8, 15, 10, 5. The field is 20 m by 20 m. What is the best estimate of the total number of daisies?$mq$, $mq$["50","400","200","4000"]$mq$, 3, $mq$Mean = 50 ÷ 5 = 10 per m². Area = 400 m². 10 × 400 = 4000. Using the total (50) as if it were the field count is a common error.$mq$, $mq$medium$mq$),
($mq$Why should quadrats be placed using random coordinates?$mq$, $mq$["To make fieldwork easier","To guarantee more organisms","To avoid bias, such as choosing areas that look interesting","To avoid counting any organisms"]$mq$, 2, $mq$Random placement gives each part of the area an equal chance of being sampled, making the results more representative.$mq$, $mq$medium$mq$),
($mq$A student studies how plant cover changes from the edge of a path into a woodland. Which sampling method is most suitable?$mq$, $mq$["One quadrat at the path","A belt or line transect with quadrats at regular intervals","Random quadrats in the sky","Counting only the tallest tree"]$mq$, 1, $mq$A transect samples along the gradient so patterns of change can be seen.$mq$, $mq$medium$mq$),
($mq$A student catches 40 beetles, marks them and releases them. Later she catches 35 beetles of which 8 are marked. What is the estimated population size using N = (M × C) ÷ R?$mq$, $mq$["175","320","5","280"]$mq$, 0, $mq$N = 40 × 35 ÷ 8 = 175. M is the number first marked, C the second catch and R the number recaptured marked.$mq$, $mq$medium$mq$),
($mq$Which change would make a sample more representative?$mq$, $mq$["Using one quadrat in a dense patch","Sampling only on one sunny day in the best spot","Choosing the places with most plants","Increasing the number of quadrats and spreading them across the area"]$mq$, 3, $mq$A larger, random or systematic sample reduces the effect of chance and bias.$mq$, $mq$medium$mq$),
($mq$A heath is 70% grass and 30% shrub. A student takes 20 quadrats and uses stratified sampling. How many should be placed in the shrub area?$mq$, $mq$["14","10","6","30"]$mq$, 2, $mq$30% of 20 = 6 quadrats in shrub and 14 in grass. Stratified sampling reflects the proportion of each habitat.$mq$, $mq$medium$mq$),
($mq$Which of these is an example of systematic sampling?$mq$, $mq$["Throwing a quadrat over your shoulder","Placing a quadrat every 5 m along a tape measure","Picking the greenest place","Counting only what you see easily"]$mq$, 1, $mq$Systematic sampling uses a regular pattern, which is good for gradients. Random sampling uses chance.$mq$, $mq$medium$mq$),
($mq$Which tool would best measure the pH of a soil sample in the field?$mq$, $mq$["A soil pH probe or indicator test kit","A light meter","An anemometer","A quadrat"]$mq$, 0, $mq$Match the instrument to the variable: anemometers measure wind speed and light meters measure light.$mq$, $mq$medium$mq$),
($mq$A student counted 24 snails in six quadrats, each 0.5 m × 0.5 m. What is the density per m²?$mq$, $mq$["4 snails per m²","24 snails per m²","96 snails per m²","16 snails per m²"]$mq$, 3, $mq$Each quadrat is 0.25 m²; six quadrats cover 1.5 m². 24 ÷ 1.5 = 16 per m². Dividing by 6 only gives the mean per quadrat (4).$mq$, $mq$hard$mq$),
($mq$Mark-recapture estimates assume that marked animals mix back in randomly, no animals move in or out, and marks are not lost. Which situation would cause the estimate to be too high?$mq$, $mq$["Marked animals are easier to catch","Marks last the whole study","Marked animals are trap-shy and avoid being recaptured","Animals mix completely"]$mq$, 2, $mq$If fewer marked animals are recaptured (R smaller), N = M × C ÷ R becomes larger than the true population.$mq$, $mq$hard$mq$),
($mq$A group measures species richness along a rocky shore transect from the sea to the land. They find fewer species high on the shore. Which hypothesis best explains this?$mq$, $mq$["More water high on the shore","Longer exposure to air means more extreme temperature and drying, so fewer species can tolerate it","Less light high on the shore","Lower predation by the sea"]$mq$, 1, $mq$Environmental gradients can be explained by changing abiotic factors. A good hypothesis suggests a factor that can be tested.$mq$, $mq$hard$mq$),
($mq$Which design improves the validity of an investigation comparing daisy density in trampled and untrampled grass?$mq$, $mq$["Choose sites with similar soil, slope and light, and sample both areas with the same number of random quadrats","Choose very different sites","Use 1 quadrat in each","Count only in trampled areas"]$mq$, 0, $mq$Controlling other variables and using equal sampling effort ensures that differences are due to trampling.$mq$, $mq$hard$mq$),
($mq$A student says: 'Our results from one month prove that this meadow's plant population is stable over time.' What is the best criticism?$mq$, $mq$["One month is always enough","Plants never change","The data cannot be used at all","A single short-term sample cannot show long-term stability; seasonal and yearly repeats are needed"]$mq$, 3, $mq$Populations change with seasons and years. Long-term claims require long-term data.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Fieldwork and Sampling$mq$ and p.name = $mq$Investigating Environmental Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Quadrat$mq$, $mq$A square frame used to sample organisms in a defined area, to estimate density or percentage cover.$mq$),
($mq$Transect$mq$, $mq$A line or belt along which samples are taken to study how organisms or conditions change across a gradient.$mq$),
($mq$Random sampling$mq$, $mq$Choosing sample points by chance (e.g. random coordinates) so every point has an equal chance, reducing bias.$mq$),
($mq$Systematic sampling$mq$, $mq$Sampling at regular intervals (e.g. every 5 m), useful for studying change along a gradient.$mq$),
($mq$Stratified sampling$mq$, $mq$Sampling each habitat in proportion to its area. In 70% grass and 30% shrub, 20 quadrats means 14 and 6.$mq$),
($mq$Estimating a population with quadrats$mq$, $mq$Find mean number per quadrat, divide by quadrat area for density, then multiply by the total area.$mq$),
($mq$Capture-mark-recapture formula$mq$, $mq$N = (M × C) ÷ R, where M is the number first marked, C the second catch and R the number of marked animals in it.$mq$),
($mq$Biotic vs abiotic factors$mq$, $mq$Biotic: living (species, predators). Abiotic: non-living (light, temperature, pH, moisture, wind).$mq$),
($mq$Why increase sample size?$mq$, $mq$A larger, spread-out sample reduces the effect of chance and gives a more representative and reliable estimate.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Fieldwork and Sampling$mq$ and p.name = $mq$Investigating Environmental Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Environmental scientists investigate real ecosystems by collecting data in the field. Because you cannot count every plant and animal, you **sample** a small part of the area and use it to estimate the whole. A good method gives results that are **representative** (a fair picture), **reliable** (repeatable) and **valid** (they really test the question).

## Choosing what to measure
- **Biotic factors** (living): species counts, density, percentage cover, species richness.
- **Abiotic factors** (non-living): light intensity, temperature, soil moisture, soil pH, wind speed, water flow rate and dissolved oxygen.

Match each variable to a suitable instrument: a light meter for light, an anemometer for wind speed, a probe or kit for pH, a thermometer for temperature.

## Sampling methods
- **Random sampling**: use random numbers for coordinates so every point has an equal chance of being chosen. This reduces bias.
- **Systematic sampling**: samples at regular intervals, such as every 5 m along a tape. Good for studying change along a gradient.
- **Stratified sampling**: sample each habitat in proportion to its area. If a heath is 70% grass and 30% shrub and you take 20 quadrats, use 14 in grass and 6 in shrub.
- **Transects**: a line or belt across an area, used to study change along a gradient such as a shoreline or from a path into woodland.
- **Capture-mark-recapture**: used for mobile animals. Capture M animals, mark and release them. Later capture C animals, of which R are marked. Estimate: N = (M × C) ÷ R. For example, 40 × 35 ÷ 8 = 175.

Assumptions of mark-recapture: marks last and are harmless, marked animals mix randomly, and no animals move in or out.

## Using quadrats
Count organisms, or estimate percentage cover, in each quadrat. Convert to a mean per quadrat and then scale up.

Worked example: five 1 m² quadrats with counts 12, 8, 15, 10 and 5 give a total of 50 and a mean of 10 per m². If the field is 400 m², the estimate is 10 × 400 = 4000 plants. If six quadrats of 0.5 m × 0.5 m (0.25 m² each) contain 24 snails, the area sampled is 1.5 m² and the density is 24 ÷ 1.5 = 16 per m².

## Improving a sample
- Use more quadrats.
- Spread them over the whole area.
- Use random placement to avoid choosing "interesting" spots.
- Repeat at different times of day or season if the question is about change over time.
- Control other variables when comparing two sites (similar slope, soil and light).

## Safe and ethical fieldwork
Carry out a risk assessment (weather, water, terrain, allergies), work in groups, get permission, avoid damaging habitats, do not remove rare species and return organisms to where you found them.

## Common mistakes
- Putting quadrats where plants look dense. This is bias.
- Using a very small sample and claiming a firm conclusion.
- Forgetting to scale up using the area of the whole site.
- Mixing up the total count with the mean per quadrat.

## How this is examined
You might receive a short description of a field study, such as a woodland, shore or pond, with quadrat counts and abiotic data. You calculate mean density or population estimates, justify the sampling method, and suggest improvements to make the data more reliable.

Exam tip: when asked to "justify" a method, name the method, say what it avoids (such as bias) and link it to the research question.$mq$ from st;

-- Investigating Environmental Systems > Data Handling and Graphs
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Investigating Environmental Systems$mq$, 5, 8 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Data Handling and Graphs$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Investigating Environmental Systems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Data Handling and Graphs$mq$ and p.name = $mq$Investigating Environmental Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the mean of 4, 6, 8 and 10?$mq$, $mq$["7","28","8","6"]$mq$, 0, $mq$Mean = (4 + 6 + 8 + 10) ÷ 4 = 28 ÷ 4 = 7.$mq$, $mq$easy$mq$),
($mq$Which graph is best for showing the relationship between two continuous variables, such as temperature and plant height?$mq$, $mq$["A pie chart","A pictogram","A table of names","A scatter graph"]$mq$, 3, $mq$Scatter graphs show correlation. A line of best fit can show the trend.$mq$, $mq$easy$mq$),
($mq$On a graph, which variable normally goes on the x-axis?$mq$, $mq$["The dependent variable","The control variable","The independent variable","The mean"]$mq$, 2, $mq$The independent variable (the one you change or measure along) is on the x-axis; the dependent variable is on the y-axis.$mq$, $mq$easy$mq$),
($mq$What is an anomalous result?$mq$, $mq$["The average result","A result that does not fit the pattern of the other results","The first result","The largest unit"]$mq$, 1, $mq$Anomalies may come from errors and should be identified and discussed, not silently deleted.$mq$, $mq$easy$mq$),
($mq$What is the range of the data 3, 7, 9, 12?$mq$, $mq$["9","12","3","31"]$mq$, 0, $mq$Range = largest − smallest = 12 − 3 = 9.$mq$, $mq$easy$mq$),
($mq$Temperatures (°C) in a pond on six days: 14, 16, 15, 22, 15, 13. What is the median?$mq$, $mq$["15.8 °C","22 °C","9 °C","15 °C"]$mq$, 3, $mq$In order: 13, 14, 15, 15, 16, 22. The middle two values are 15 and 15, so the median is 15 °C. The mean is about 15.8 °C and the range is 9 °C.$mq$, $mq$medium$mq$),
($mq$Using the same pond data (14, 16, 15, 22, 15, 13), the 22 °C reading was taken beside a warm outflow pipe. What is the mean after removing it?$mq$, $mq$["15.8 °C","15 °C","14.6 °C","16 °C"]$mq$, 2, $mq$(14 + 16 + 15 + 15 + 13) ÷ 5 = 73 ÷ 5 = 14.6 °C. Always explain why a value is excluded.$mq$, $mq$medium$mq$),
($mq$Dissolved oxygen in a stream rose from 6.0 mg/L to 7.2 mg/L. What is the percentage increase?$mq$, $mq$["17%","20%","1.2%","120%"]$mq$, 1, $mq$Increase = 1.2. 1.2 ÷ 6.0 × 100 = 20%. Dividing by the new value would give about 17%.$mq$, $mq$medium$mq$),
($mq$A scatter graph of nitrate concentration against algae count shows points rising from bottom left to top right. What type of correlation is this?$mq$, $mq$["Positive correlation","Negative correlation","No correlation","Perfect circle"]$mq$, 0, $mq$As one variable increases the other tends to increase. This shows association but not necessarily cause.$mq$, $mq$medium$mq$),
($mq$Which statement is a correct interpretation of a strong positive correlation between ice cream sales and drowning accidents?$mq$, $mq$["Ice cream causes drowning","Drowning causes ice cream sales","Temperature has no effect","Both may increase in hot weather; correlation does not prove one causes the other"]$mq$, 3, $mq$A third variable (temperature) can explain both. Always consider confounding variables.$mq$, $mq$medium$mq$),
($mq$Which is the best choice of scale for a graph with data between 0 and 83?$mq$, $mq$["Axis from 0 to 83 with uneven steps","Axis from 80 to 83","Axis from 0 to 90 with equal intervals of 10","No scale"]$mq$, 2, $mq$Use an even, easy-to-read scale that spreads the points across the graph.$mq$, $mq$medium$mq$),
($mq$A kite diagram is most suitable for displaying:$mq$, $mq$["The pH of rain","The abundance of species along a transect","The mean of three numbers","A chemical equation"]$mq$, 1, $mq$Kite diagrams show how species abundance changes along a transect.$mq$, $mq$medium$mq$),
($mq$A table gives the mean number of seedlings per quadrat: shaded 3.5, open 8.0. A student writes 'Seedlings are 4.5 more in open areas.' What is the correct comparison as a percentage?$mq$, $mq$["The open area has about 129% more seedlings than the shaded area","The open area has 4.5% more","The shaded area has 129% more","The areas are equal"]$mq$, 0, $mq$Difference 4.5 ÷ 3.5 × 100 ≈ 129%. Quote the difference together with the reference value.$mq$, $mq$medium$mq$),
($mq$Data: distance from a path (m) and mean plant height (cm): 0 m: 5; 2 m: 8; 4 m: 12; 6 m: 15; 8 m: 18. Which statement best describes the pattern and a prediction at 10 m?$mq$, $mq$["Height falls as distance increases","Height stays at 5 cm","Height is exactly 100 cm at 10 m","Height rises about 1.6 cm per metre, so roughly 21 cm at 10 m, though extrapolating is uncertain"]$mq$, 3, $mq$From 5 to 18 cm over 8 m is 13 ÷ 8 ≈ 1.6 cm/m, so about 21 cm at 10 m. A prediction outside the data range is less reliable.$mq$, $mq$hard$mq$),
($mq$Two sites have mean oxygen levels of 8.0 mg/L (range 7.9 to 8.1) and 8.0 mg/L (range 4.0 to 12.0). What is the best interpretation?$mq$, $mq$["The sites are identical","The first site varies more","The means are equal but the second site varies far more, so the mean alone hides important differences","Range is irrelevant"]$mq$, 2, $mq$Always consider spread as well as average. A large range may suggest unstable conditions.$mq$, $mq$hard$mq$),
($mq$A student plots a line of best fit through scatter data that shows a clear upward trend but points widely spread. Which statement is the most accurate?$mq$, $mq$["There is a perfect correlation","There is a weak positive correlation; the line shows a general trend but predictions are uncertain","The data show no link","The line proves causation"]$mq$, 1, $mq$Wide scatter indicates weak correlation. The line of best fit is a model, not exact truth.$mq$, $mq$hard$mq$),
($mq$A bar chart shows the number of invertebrates in two streams: Stream A 120 individuals from 4 samples, Stream B 150 individuals from 6 samples. Which statement is correct?$mq$, $mq$["A has the higher mean per sample (30 versus 25), so comparing totals is misleading","B has a higher mean per sample","They have equal means","Totals are always the best comparison"]$mq$, 0, $mq$A: 120 ÷ 4 = 30. B: 150 ÷ 6 = 25. Unequal sampling effort means raw totals cannot be fairly compared.$mq$, $mq$hard$mq$),
($mq$A report shows a graph with the y-axis starting at 95 rather than 0, making a change from 96 to 98 look huge. What is the problem and how should it be fixed?$mq$, $mq$["The data are wrong","There is no problem","Graphs must never use numbers","The truncated axis exaggerates the change; start the axis at zero or clearly state the scale and give the actual percentage change (about 2%)"]$mq$, 3, $mq$(98 − 96) ÷ 96 × 100 ≈ 2.1%. Misleading scales are a form of poor data communication.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Data Handling and Graphs$mq$ and p.name = $mq$Investigating Environmental Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Mean, median, mode, range$mq$, $mq$Mean: total ÷ number of values. Median: middle value. Mode: most common value. Range: largest − smallest.$mq$),
($mq$Percentage change formula$mq$, $mq$(new − old) ÷ old × 100. Divide by the original value.$mq$),
($mq$Percentage points vs percentage change$mq$, $mq$A rise from 50% to 75% is 25 percentage points but a 50% increase.$mq$),
($mq$Anomalous result$mq$, $mq$A value that does not fit the pattern. Identify it, suggest a cause, and explain whether you exclude it.$mq$),
($mq$When to use a scatter graph$mq$, $mq$To show the relationship between two continuous variables; add a line of best fit to show the trend.$mq$),
($mq$Axes rules$mq$, $mq$Independent variable on the x-axis, dependent on the y-axis; label with units, use an even scale and a title.$mq$),
($mq$Positive correlation$mq$, $mq$As one variable increases, the other tends to increase as well.$mq$),
($mq$Correlation vs causation$mq$, $mq$Correlation shows association, not proof of cause; a third variable may explain both.$mq$),
($mq$Kite diagram$mq$, $mq$A graph that shows species abundance along a transect.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Data Handling and Graphs$mq$ and p.name = $mq$Investigating Environmental Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Collecting data is only half of an investigation. You must process and present it so patterns are clear, then interpret it honestly. In MYP sciences this includes choosing suitable calculations and graphs, spotting anomalies and explaining what the data do and do not show.

## Summarising data
- **Mean**: add all values and divide by how many there are.
- **Median**: the middle value when data are in order. If there are two middle values, find their mean.
- **Mode**: the most common value.
- **Range**: largest minus smallest value.

Example: pond temperatures 14, 16, 15, 22, 15, 13 °C. Mean = 95 ÷ 6 ≈ 15.8 °C. In order: 13, 14, 15, 15, 16, 22, so the median is 15 °C, the mode is 15 °C and the range is 22 − 13 = 9 °C. If 22 °C was taken beside a warm pipe, removing that anomaly gives a mean of 73 ÷ 5 = 14.6 °C. Always explain why you exclude a value.

Do not just look at the mean. Two sites can have the same mean oxygen level but very different ranges. The range shows how variable the conditions are.

## Percentage change
Percentage change = (new − old) ÷ old × 100. Dissolved oxygen rising from 6.0 to 7.2 mg/L is an increase of 1.2 ÷ 6.0 × 100 = 20%. If a value is quoted as a percentage of a percentage, check you divide by the original value. Remember the difference between percentage points and percentage change.

## Fair comparisons
Compare means per sample, not raw totals, if the number of samples differs. For example 120 animals from 4 samples is a mean of 30, while 150 animals from 6 samples is a mean of 25.

## Choosing graphs
- **Bar chart**: categories (such as sites).
- **Line graph**: change over time or along a continuous scale, where connecting points makes sense.
- **Scatter graph**: relationship between two continuous variables. Add a line of best fit.
- **Kite diagram**: species abundance along a transect.
- **Pie chart**: parts of a whole, such as the percentage cover of different types.

Good graphs have a title, labelled axes with units, an even scale, the independent variable on the x-axis and plotted points that are accurate. Starting an axis at a value above zero can exaggerate small changes, so state this clearly.

## Describing patterns
Describe the overall trend, quote some data (start, end and change), mention anomalies and, if appropriate, estimate a rate. If height rises from 5 cm at 0 m to 18 cm at 8 m, the average rate is 13 ÷ 8 ≈ 1.6 cm per metre. Predicting beyond the data (extrapolation) is less reliable.

## Correlation and causation
A **positive correlation** means that as one variable increases, the other tends to increase. A **negative correlation** means one rises as the other falls. Correlation shows an association but does not prove that one thing causes the other: a third variable may cause both.

## Common mistakes
- Forgetting units or labels on axes.
- Joining points when a line graph is not appropriate.
- Using totals instead of means when sample sizes differ.
- Saying correlation proves causation.
- Deleting anomalies without explanation.

## How this is examined
Expect a table of field data to process, a graph to describe, and questions about correlation, anomalies and the reliability of conclusions.

Exam tip: describe, then explain. Quote numbers from the data, and use words like "positive correlation", "anomaly" and "trend" precisely.$mq$ from st;

-- Investigating Environmental Systems > Evaluating Investigations
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Investigating Environmental Systems$mq$, 5, 8 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Evaluating Investigations$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Investigating Environmental Systems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Evaluating Investigations$mq$ and p.name = $mq$Investigating Environmental Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does it mean if an investigation is reliable?$mq$, $mq$["Repeating it gives similar results","It was done outdoors","It used expensive equipment","It has a long title"]$mq$, 0, $mq$Reliability is about consistency. Repeated trials that agree closely increase confidence.$mq$, $mq$easy$mq$),
($mq$What is a control variable?$mq$, $mq$["The variable you measure","The variable you change","An unexpected result","A factor kept the same so that the test is fair"]$mq$, 3, $mq$Controlling variables ensures that changes in the dependent variable are due to the independent variable.$mq$, $mq$easy$mq$),
($mq$What is a hypothesis?$mq$, $mq$["A final conclusion","A list of materials","A testable prediction that explains what you expect to happen and why","A graph"]$mq$, 2, $mq$A hypothesis links variables and gives a reason, such as 'Higher nitrate will increase algae because it is a nutrient'.$mq$, $mq$easy$mq$),
($mq$Which of these is a limitation of an investigation?$mq$, $mq$["Using a ruler","A small sample size that may not represent the whole area","Writing a title","Wearing safety goggles"]$mq$, 1, $mq$Limitations are weaknesses in the method or data that affect confidence in the conclusion.$mq$, $mq$easy$mq$),
($mq$What does 'accuracy' mean in measurement?$mq$, $mq$["How close a measurement is to the true value","How many times you repeated it","How fast you measured","How expensive the tool was"]$mq$, 0, $mq$Accuracy refers to closeness to the true value; precision is about how closely repeated measurements agree.$mq$, $mq$easy$mq$),
($mq$A pH meter reads 6.8 for a buffer solution that is actually pH 7.0. What is the percentage error?$mq$, $mq$["0.2%","29%","2.0%","Approximately 2.9%"]$mq$, 3, $mq$Error = 0.2. 0.2 ÷ 7.0 × 100 ≈ 2.9%. The percentage error is divided by the true value.$mq$, $mq$medium$mq$),
($mq$A student measures stream width with a tape accurate to ±0.5 cm. The stream is 20 cm wide. What is the percentage uncertainty?$mq$, $mq$["0.5%","25%","2.5%","10%"]$mq$, 2, $mq$0.5 ÷ 20 × 100 = 2.5%. A smaller measurement has larger relative uncertainty for the same instrument.$mq$, $mq$medium$mq$),
($mq$Three trials of dissolved oxygen gave 5.1, 5.3 and 5.2 mg/L. Which statement is best?$mq$, $mq$["The results are very scattered","The results are close, so they are precise and reliable; the mean is 5.2 mg/L","The mean is 5.3 mg/L","The experiment is invalid"]$mq$, 1, $mq$Mean = 15.6 ÷ 3 = 5.2. Close agreement suggests high precision. Accuracy would require comparison with a true value.$mq$, $mq$medium$mq$),
($mq$Which improvement would best increase the reliability of a quadrat survey?$mq$, $mq$["Taking more quadrats and repeating the survey on different days","Using one very large quadrat once","Counting only the easy ones","Using different quadrat sizes each time"]$mq$, 0, $mq$Increasing the sample size and repeating measurements reduces the effect of chance.$mq$, $mq$medium$mq$),
($mq$A student investigates whether light affects plant growth, but one pot is warmer than the other. What is the main problem?$mq$, $mq$["The graph has a title","The pots are round","There are too few ideas","An uncontrolled variable (temperature) affects validity"]$mq$, 3, $mq$If temperature differs, you cannot be sure that light caused the difference. This lowers validity.$mq$, $mq$medium$mq$),
($mq$Which sentence best explains a random error?$mq$, $mq$["The same mistake in every reading because of a faulty scale","A hypothesis","Unpredictable variation in measurements, such as slightly different readings of a thermometer each time","A complete data set"]$mq$, 2, $mq$Random errors vary in size and direction and can be reduced by repeating and averaging. Systematic errors shift all values the same way.$mq$, $mq$medium$mq$),
($mq$A balance reads 2 g too high every time because it was not zeroed. What type of error is this?$mq$, $mq$["Random error","Systematic error","No error","Anomaly only"]$mq$, 1, $mq$A consistent offset is a systematic error. Repeating the measurement will not remove it; calibrate or zero the equipment.$mq$, $mq$medium$mq$),
($mq$A conclusion states: 'Nitrate causes all the algae growth in the lake.' The investigation measured nitrate and algae in one pond for one week. What is the best criticism?$mq$, $mq$["The claim is too strong for such limited data; other factors and longer sampling are needed","The claim is perfectly justified","Algae cannot be measured","Nitrate is not a nutrient"]$mq$, 0, $mq$Conclusions should match the evidence. Use cautious language and mention other variables like phosphate, light and temperature.$mq$, $mq$medium$mq$),
($mq$In a survey, mean beetle density was 4.0 per m² at a path and 3.8 per m² away from the path, with ranges overlapping widely. A student concludes: 'Paths increase beetle density.' What is the best evaluation?$mq$, $mq$["The data prove the conclusion","The difference is huge","Overlap in ranges strengthens the claim","The 5% difference is small relative to the spread, so the data do not strongly support the conclusion; more samples or a statistical test would help"]$mq$, 3, $mq$(4.0 − 3.8) ÷ 3.8 ≈ 5%. With overlapping ranges the difference could be due to chance, so the claim is weak.$mq$, $mq$hard$mq$),
($mq$A stream survey finds fewer species below a factory. The factory owner says other things (for example less shade) could explain this. Which investigation design best tests the claim?$mq$, $mq$["Only count species downstream","Compare unrelated streams","Compare upstream and downstream sites matched for shade, flow and substrate, and measure pollutants, repeating over time","Use a single reading"]$mq$, 2, $mq$Matching sites controls confounding variables, and measuring pollutants links the cause to the effect.$mq$, $mq$hard$mq$),
($mq$Which extension would best strengthen a conclusion that a fertiliser causes algal growth?$mq$, $mq$["Reading a newspaper article","A controlled experiment in tanks with different fertiliser levels and replicates, measuring algal growth","Counting fish only","Waiting for rain"]$mq$, 1, $mq$A controlled experiment with replicates tests cause and effect more directly than a one-off field observation.$mq$, $mq$hard$mq$),
($mq$A group estimates a fish population by mark-recapture and gets 400. A later full drain-down count shows 250 fish. Which is the most likely explanation for the overestimate?$mq$, $mq$["Marked fish were less likely to be recaptured, for example because they learned to avoid nets","The net was too clean","Fish grew bigger","The pond was very large"]$mq$, 0, $mq$Fewer marked recaptures (small R) inflate the estimate. Violated assumptions are a key limitation.$mq$, $mq$hard$mq$),
($mq$A report on a forest study includes a hypothesis, a clear method, repeated data, a graph, a conclusion that refers to the data, and a section on limitations and improvements. Which feature makes the evaluation strongest?$mq$, $mq$["Listing limitations without links to results","Saying nothing could be improved","Changing the data to fit","Explaining how each limitation affects confidence in the conclusion and suggesting specific improvements"]$mq$, 3, $mq$A strong evaluation links weaknesses to their effect on the conclusion and suggests realistic improvements.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Evaluating Investigations$mq$ and p.name = $mq$Investigating Environmental Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Hypothesis$mq$, $mq$A testable prediction that includes a scientific reason, linking independent and dependent variables.$mq$),
($mq$Reliability vs validity$mq$, $mq$Reliable: repeatable and consistent. Valid: the method really tests the question, with variables controlled.$mq$),
($mq$Accuracy vs precision$mq$, $mq$Accuracy: closeness to the true value. Precision: how closely repeated measurements agree.$mq$),
($mq$Random error$mq$, $mq$Unpredictable variation in readings; reduced by repeating and averaging.$mq$),
($mq$Systematic error$mq$, $mq$A consistent shift in all readings (e.g. an unzeroed balance); repeating does not fix it, so calibrate equipment.$mq$),
($mq$Percentage error$mq$, $mq$|measured − true| ÷ true × 100. Example: 6.8 for pH 7.0 gives about 2.9%.$mq$),
($mq$Percentage uncertainty$mq$, $mq$Uncertainty ÷ measurement × 100. ±0.5 cm on 20 cm is 2.5%.$mq$),
($mq$Structure of a limitation point$mq$, $mq$State the limitation, explain how it affects the results or conclusion, then suggest a specific improvement.$mq$),
($mq$Why use cautious wording in conclusions?$mq$, $mq$Data from a limited sample may only suggest a relationship; wording should match the strength of evidence.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Evaluating Investigations$mq$ and p.name = $mq$Investigating Environmental Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$An investigation is only as trustworthy as its method. Evaluating means judging how good your method and data were, how much you can trust the conclusion and how the investigation could be improved. In MYP sciences this is a key skill in criterion C (Processing and evaluating) and in the evaluation of methods in criterion B (Inquiring and designing).

## Key terms
- **Hypothesis**: a testable prediction with a reason.
- **Independent variable**: what you change or compare. **Dependent variable**: what you measure. **Control variables**: what you keep the same.
- **Reliability**: results are consistent when repeated.
- **Validity**: the method really tests the question, with variables controlled.
- **Accuracy**: closeness to the true value. **Precision**: closeness of repeated measurements to each other.

Three readings of 5.1, 5.3 and 5.2 mg/L are precise (close together) with a mean of 5.2 mg/L. They are only accurate if the true value is also near 5.2.

## Errors
- **Random errors** vary unpredictably (reading a thermometer slightly differently). Repeating and averaging reduces their effect.
- **Systematic errors** shift every reading the same way (a balance that reads 2 g too high). Repeating does not fix them; you must calibrate or zero the equipment.

## Percentage error and uncertainty
- Percentage error = |measured − true| ÷ true × 100. A pH meter reading 6.8 for a pH 7.0 buffer has an error of 0.2 ÷ 7.0 × 100 ≈ 2.9%.
- Percentage uncertainty = uncertainty ÷ measurement × 100. A tape accurate to ±0.5 cm measuring 20 cm gives 2.5%. Smaller measurements have larger percentage uncertainty.

## Making a conclusion
A good conclusion:
- answers the research question,
- refers to specific data (numbers and trends),
- says whether the hypothesis is supported,
- uses cautious wording such as "suggests" if evidence is limited,
- explains the science behind the result.

For example, beetle density of 4.0 per m² beside a path and 3.8 per m² away is a difference of about 5%. If the ranges overlap widely, the evidence for a real difference is weak.

## Evaluating the method
Identify specific strengths and limitations, explain the effect of each on your results, then suggest realistic improvements.
- Small sample size: increase the number of quadrats or repeats.
- Uncontrolled variables (shade, temperature, time of day): match sites or control conditions.
- Short time period: repeat across seasons.
- Equipment limits: use a more precise instrument.
- Bias in placement: use random sampling.
- Assumptions of mark-recapture violated: use alternative methods or check assumptions.

## Extending the investigation
Suggest a new question or a controlled experiment, for instance testing fertiliser levels in tanks to move from correlation to cause.

## Common mistakes
- Writing vague limitations such as "human error" without saying what happened and how it affected results.
- Making conclusions that go beyond the data.
- Mixing up accuracy and precision.
- Dividing percentage error by the measured value instead of the true value.

## How this is examined
You evaluate a described investigation with data, such as a stream survey or growth experiment. Tasks include calculating percentage error, identifying systematic or random errors, judging validity, and recommending improvements.

Exam tip: use a pattern of limitation, effect on results, improvement, and make each improvement specific.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('environmental-systems')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;