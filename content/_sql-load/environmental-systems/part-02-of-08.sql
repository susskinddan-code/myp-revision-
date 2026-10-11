-- Part 2 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Biodiversity and Conservation > Measuring Biodiversity
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Biodiversity and Conservation$mq$, 5, 2 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Measuring Biodiversity$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Biodiversity and Conservation$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Measuring Biodiversity$mq$ and p.name = $mq$Biodiversity and Conservation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does the term biodiversity mean?$mq$, $mq$["The variety of living things in an area, including species and genetic variety","The number of individuals of one species","The total mass of living things in an ecosystem","The size of a nature reserve"]$mq$, 0, $mq$Biodiversity is the variety of life, often described at the level of genes, species and ecosystems.$mq$, $mq$easy$mq$),
($mq$What is species richness?$mq$, $mq$["How many individuals of each species are present","How evenly individuals are spread between species","The total area of a habitat","The number of different species in an area"]$mq$, 3, $mq$Species richness is the count of different species. It does not describe how many individuals each species has.$mq$, $mq$easy$mq$),
($mq$Which sampling tool is most suitable for estimating the number of daisies on a school field?$mq$, $mq$["Pitfall trap","Kick net","Quadrat","Light meter"]$mq$, 2, $mq$A quadrat is a square frame used to sample plants and other organisms that do not move.$mq$, $mq$easy$mq$),
($mq$Why are quadrats placed at random positions in a habitat?$mq$, $mq$["To make the survey quicker","To avoid bias, so the sample represents the whole area","To count only the common species","To make sure at least one quadrat is in shade"]$mq$, 1, $mq$Random placement means the researcher's choices do not influence which areas are sampled, so results are more representative.$mq$, $mq$easy$mq$),
($mq$Site A has 12 species and Site B has 5 species. Which statement is correct?$mq$, $mq$["Site A has greater species richness","Site B has greater species richness","Both sites have the same species richness","Site B is more even"]$mq$, 0, $mq$Richness is the number of species, so Site A (12) has higher richness than Site B (5).$mq$, $mq$easy$mq$),
($mq$A student counts clover plants in five 1 m² quadrats: 3, 5, 2, 4 and 6. The field is 200 m². What is the best estimate of the clover population?$mq$, $mq$["20","4","1000","800"]$mq$, 3, $mq$Mean = (3 + 5 + 2 + 4 + 6) ÷ 5 = 4 per m². 4 × 200 = 800.$mq$, $mq$medium$mq$),
($mq$In a capture-mark-recapture study, 40 beetles are marked and released. A later sample catches 30 beetles, of which 6 are marked. Using population = (marked × second sample) ÷ marked recaptured, what is the estimate?$mq$, $mq$["120","7","200","72"]$mq$, 2, $mq$40 × 30 ÷ 6 = 200 beetles. The recaptured fraction (6 of 30) suggests the marked beetles are one fifth of the population.$mq$, $mq$medium$mq$),
($mq$Site A has 20 individuals in 4 species, with counts of 10, 6, 3 and 1. Site B has 20 individuals in 4 species, with counts of 17, 1, 1 and 1. Which conclusion is best?$mq$, $mq$["Site B is more diverse because it has one large population","Site A is more diverse because individuals are more evenly spread among species","Both sites have the same diversity","Site B has more species"]$mq$, 1, $mq$Both sites have four species, so richness is equal. Site A has a more even spread (50%, 30%, 15% and 5% of individuals), while Site B is dominated by one species (85%).$mq$, $mq$medium$mq$),
($mq$Two woodlands each contain four tree species. Woodland X has 25 trees of each species. Woodland Y has 97 trees of one species and 1 tree of each of the others. What is the difference between them?$mq$, $mq$["They have the same richness but X has greater evenness","Y has greater species richness","X has fewer species","They are identical in diversity"]$mq$, 0, $mq$Richness is the same (four species), but X is even and Y is dominated by one species. Diversity indices consider both richness and evenness.$mq$, $mq$medium$mq$),
($mq$A researcher wants to see how species change from the sea edge up a sand dune. Which method is best?$mq$, $mq$["A single quadrat at the top","A kick sample","A pitfall trap in the car park","A line transect with quadrats at regular intervals"]$mq$, 3, $mq$A transect samples along a line across an environmental gradient, so changes in species can be linked to changes in conditions.$mq$, $mq$medium$mq$),
($mq$Mayfly larvae are found in a stream. Why might an ecologist use them as an indicator species?$mq$, $mq$["They are the largest animals in the stream","They are easy to catch with a net","They are sensitive to pollution, so their presence suggests clean, oxygen-rich water","They are present in all water, polluted or clean"]$mq$, 2, $mq$Indicator species have tolerance limits. Mayfly larvae need well-oxygenated water, so their presence shows good quality.$mq$, $mq$medium$mq$),
($mq$When sampling stream invertebrates by kick sampling, why is each site sampled for exactly three minutes?$mq$, $mq$["Longer would damage the net","A standard effort makes results from different sites comparable","Three minutes catches every animal","Animals only live for three minutes"]$mq$, 1, $mq$Keeping time, net size and method the same means differences in results are more likely to be real differences between sites.$mq$, $mq$medium$mq$),
($mq$In a survey, 95% of all the individuals counted belong to a single species. What does this suggest about the community?$mq$, $mq$["The community is dominated by one or very few species","The site has very high diversity","No species are present","Species are perfectly even"]$mq$, 0, $mq$When almost all individuals belong to one species, the community is uneven and dominated by that species. Its diversity is low, even if a few rare species are also present.$mq$, $mq$medium$mq$),
($mq$A sample contains 16 individuals: 8 of species P, 4 of Q, 2 of R and 2 of S. What percentage of the sample is species P, and what does this show?$mq$, $mq$["25%, so the four species are perfectly even","8%, so P is a rare species","200%, so P is the only species present","50%, so P is dominant and the community is uneven even though four species are present"]$mq$, 3, $mq$8 ÷ 16 × 100 = 50%. Half of all individuals belong to one species, so the community is uneven, although species richness is still four.$mq$, $mq$hard$mq$),
($mq$In a capture-mark-recapture study, which assumption must be true for the estimate to be reliable?$mq$, $mq$["Marking makes animals easier for predators to see","Marked animals stay in one corner of the habitat","Marking does not harm the animals, and marked individuals mix evenly with the population with no migration in or out","Only female animals should be marked"]$mq$, 2, $mq$If marking changes survival, or marked animals do not mix or the population changes through migration, the recaptured fraction will not represent the population.$mq$, $mq$hard$mq$),
($mq$A survey of one 100 m² plot finds 14 plant species in a native woodland and 5 in a nearby pine plantation. A student concludes that all native woodlands are more diverse than all plantations. Which is the best evaluation?$mq$, $mq$["The conclusion is valid because 14 is bigger than 5","The conclusion is not supported: only one pair of sites was sampled once, so it cannot be generalised","The conclusion is invalid because richness cannot be measured","The conclusion is valid because woodlands are older"]$mq$, 1, $mq$A general claim needs repeated sampling of many sites. One plot at each site shows a difference at those places only.$mq$, $mq$hard$mq$),
($mq$Quadrat counts of a plant vary widely between quadrats (0, 12, 1, 9, 0, 14). What is the best way to improve the reliability of the density estimate?$mq$, $mq$["Use more randomly placed quadrats","Use only the highest counts","Remove the zero counts","Use one larger quadrat in the densest patch"]$mq$, 0, $mq$A larger sample reduces the effect of chance and gives a more reliable mean. Removing data points or choosing dense areas introduces bias.$mq$, $mq$hard$mq$),
($mq$A student places 25 quadrats (1 m² each) along the edge of a path in a 400 m² field and counts 75 daisies. She multiplies the mean by the area. What is the best evaluation of her estimate?$mq$, $mq$["3 daisies, because the mean is the population","1200 daisies, which is certainly accurate","75 daisies, because that is the total counted","1200 daisies, but likely an overestimate because the quadrats were not placed at random across the field"]$mq$, 3, $mq$Mean = 75 ÷ 25 = 3 per m². 3 × 400 = 1200. However, quadrats placed along the path may not represent the whole field, so the estimate is probably biased.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Measuring Biodiversity$mq$ and p.name = $mq$Biodiversity and Conservation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Biodiversity$mq$, $mq$The variety of life in an area, including genetic diversity, species diversity and ecosystem diversity.$mq$),
($mq$Species richness vs evenness$mq$, $mq$Richness is the number of different species. Evenness is how equal the numbers of individuals are between species.$mq$),
($mq$Why use random sampling?$mq$, $mq$To avoid bias, so the sample represents the whole habitat and the results are more reliable.$mq$),
($mq$Population estimate from quadrats$mq$, $mq$Mean number per quadrat ÷ quadrat area × total area of the habitat.$mq$),
($mq$Capture-mark-recapture formula$mq$, $mq$Population = (number marked first × size of second sample) ÷ number of marked animals in the second sample.$mq$),
($mq$Relative abundance (dominance)$mq$, $mq$Number of one species ÷ total number of individuals × 100. If one species makes up most of the sample, the community is uneven and less diverse.$mq$),
($mq$Indicator species$mq$, $mq$A species whose presence or absence shows environmental quality, for example lichens (clean air) or mayfly larvae (clean water).$mq$),
($mq$When use a transect?$mq$, $mq$To sample along a line across a gradient, such as from the sea up a dune, so changes in species can be linked to changing conditions.$mq$),
($mq$Assumptions of mark-recapture$mq$, $mq$Marking is harmless, marked animals mix evenly with the population, and there is no migration, birth or death between samples.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Measuring Biodiversity$mq$ and p.name = $mq$Biodiversity and Conservation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is biodiversity?
**Biodiversity** is the variety of life. It can be described at three levels: **genetic diversity** (variation within a species), **species diversity** (the variety of species in an area) and **ecosystem diversity** (the variety of habitats). Scientists measure biodiversity so they can compare places, track change over time and decide which areas most need protection.

## Richness and evenness
- **Species richness** is the number of different species in an area.
- **Species evenness** is how similar the numbers of individuals of each species are.

Two sites can have the same richness but very different diversity. A meadow with 100 individuals spread equally over four species is more diverse than one with 97 of one species and one of each of the other three. Diversity measures use both ideas.

## Sampling methods
Because we cannot count every organism, we take samples.
- **Quadrats**: a square frame placed on the ground to count plants or slow-moving animals. Use random positions (for example, random coordinates) to avoid bias.
- **Transects**: a line across a habitat with samples at regular intervals. Good for showing changes along a gradient such as the shore, a hillside or a path.
- **Kick sampling**: a net held downstream while you kick the stream bed for a set time (for example three minutes) to collect invertebrates.
- **Pitfall traps** and **pooters** collect ground insects.
- **Capture-mark-recapture** is used for mobile animals. Population = (number marked first × size of second sample) ÷ number of marked animals recaptured. Example: 40 marked, second sample 30 with 6 marked: 40 × 30 ÷ 6 = 200. Assumptions: marking does not harm the animals, marked animals mix back in evenly and there is no migration, birth or death between samples.

## Estimating a population from quadrats
Mean density = total number counted ÷ number of quadrats. Population estimate = mean density × total area ÷ quadrat area. Example: counts of 3, 5, 2, 4, 6 in 1 m² quadrats give a mean of 4 per m². In a 200 m² field the estimate is 800.

## Comparing diversity using relative abundance
To compare how even two communities are, work out the percentage of all individuals that each species makes up: species count ÷ total individuals × 100. Example: counts of 10, 6, 3 and 1 (total 20) give 50%, 30%, 15% and 5%. Counts of 17, 1, 1 and 1 (total 20) give 85%, 5%, 5% and 5%. Both sites have four species, but the second is dominated by one species, so it is less even and less diverse. If one species makes up almost all of a sample, diversity is low.

## Indicator species
Some species are sensitive to pollution, so their presence or absence suggests environmental quality. Lichens indicate clean air, and mayfly larvae suggest clean, oxygen-rich water. Rat-tailed maggots and sludge worms can survive in polluted, low-oxygen water.

## Improving reliability
Use random sampling, enough samples, the same method and time at each site, and repeat. Keep variables such as quadrat size and season constant. Say what could cause error, such as animals escaping or misidentified species.

## Common mistakes
- Saying richness and diversity are the same thing. Diversity includes evenness.
- Placing quadrats where there are more plants and calling it random.
- Forgetting to multiply the mean by the total area, or dividing by the wrong quadrat size.

## How this is examined
You may get a table of species counts from two sites, a description of a survey method, and be asked to calculate a mean density, population estimate or the percentage of each species, compare sites, and evaluate the reliability and limitations of the sampling.

Exam tip: when asked to evaluate a survey, comment on sample size, randomness, repeats and whether the conclusion can be generalised beyond the sites sampled.$mq$ from st;

-- Biodiversity and Conservation > Threats to Biodiversity
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Biodiversity and Conservation$mq$, 5, 2 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Threats to Biodiversity$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Biodiversity and Conservation$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Threats to Biodiversity$mq$ and p.name = $mq$Biodiversity and Conservation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which human activity is considered the leading cause of biodiversity loss worldwide?$mq$, $mq$["Destruction and degradation of habitats","Increased tourism","Planting trees","Using renewable energy"]$mq$, 0, $mq$Clearing land for farming, buildings and roads removes the places where species live, and is the largest single cause of biodiversity loss.$mq$, $mq$easy$mq$),
($mq$What is an invasive species?$mq$, $mq$["Any species with a small population","A species that has recently evolved","A species that is hunted by humans","A non-native species that spreads and harms the native community"]$mq$, 3, $mq$Invasive species are introduced to a new area, spread quickly and damage native species or ecosystems.$mq$, $mq$easy$mq$),
($mq$A species is described as extinct. What does this mean?$mq$, $mq$["Its numbers are falling","It only lives in zoos","No individuals of the species remain alive anywhere","It lives in only one country"]$mq$, 2, $mq$Extinction means the whole species has died out. Species that survive only in captivity are called extinct in the wild.$mq$, $mq$easy$mq$),
($mq$Which of these is an example of overexploitation?$mq$, $mq$["Planting a hedgerow","Catching fish faster than their populations can replace themselves","Building a nature reserve","Reintroducing wolves"]$mq$, 1, $mq$Overexploitation means harvesting a resource, such as fish, timber or wildlife, faster than it can be replaced.$mq$, $mq$easy$mq$),
($mq$How does climate change threaten coral reefs?$mq$, $mq$["Warmer water can cause corals to expel their algae and bleach","It makes oceans too cold","It increases the amount of salt in sand","It stops fish from breathing air"]$mq$, 0, $mq$When the water is too warm, corals expel the symbiotic algae that give them colour and food. This is bleaching and it can kill the coral.$mq$, $mq$easy$mq$),
($mq$A forest of 500 km² loses 12% of its area to farming. How much forest remains?$mq$, $mq$["60 km²","380 km²","488 km²","440 km²"]$mq$, 3, $mq$12% of 500 = 60 km² lost. 500 − 60 = 440 km² remains.$mq$, $mq$medium$mq$),
($mq$A square reserve measures 10 km by 10 km (area 100 km², perimeter 40 km). It is split by roads into four separate 5 km by 5 km squares. What happens to the total length of edge?$mq$, $mq$["It stays the same at 40 km","It halves to 20 km","It doubles to 80 km, giving more edge habitat and exposure to outside effects","It falls to zero"]$mq$, 2, $mq$Each small square has a perimeter of 20 km, and 4 × 20 = 80 km. More edge means more exposure to wind, predators and invasive species, and less core habitat.$mq$, $mq$medium$mq$),
($mq$Why are island species often especially vulnerable to an introduced predator such as a cat or rat?$mq$, $mq$["Island species are always smaller","They often evolved without such predators and have few defences","Predators cannot swim to islands","Islands have no food for predators"]$mq$, 1, $mq$Many island species lost defences such as flight or fear of predators because there were none. Introduced predators can drive them to extinction quickly.$mq$, $mq$medium$mq$),
($mq$An insecticide that does not break down washes into a pond. Later, fish-eating birds lay eggs with thin shells that break easily. What is the best explanation?$mq$, $mq$["The pesticide accumulates in food chains and affects the birds' reproduction","The birds are eating too much calcium","The pond has too much oxygen","The birds have been hunted too much"]$mq$, 0, $mq$Persistent chemicals build up in tissues and get more concentrated at higher trophic levels. Some caused eggshell thinning in birds of prey and fish-eating birds.$mq$, $mq$medium$mq$),
($mq$A population of a rare frog falls from 2400 to 1800 over five years. What is the percentage decrease?$mq$, $mq$["33%","50%","75%","25%"]$mq$, 3, $mq$The decrease is 600. 600 ÷ 2400 × 100 = 25%. Using 1800 as the base gives 33%, which is incorrect.$mq$, $mq$medium$mq$),
($mq$Why is a specialist species, such as an animal that eats only one kind of bamboo, more at risk than a generalist?$mq$, $mq$["Specialists are always larger","Specialists reproduce too quickly","It depends on a single resource, so losing that resource could cause its extinction","Generalists have smaller ranges"]$mq$, 2, $mq$A specialist has a narrow niche. If its food or habitat disappears it cannot easily switch to something else.$mq$, $mq$medium$mq$),
($mq$High demand for rhino horn and elephant ivory has led to illegal hunting. Which threat does this represent?$mq$, $mq$["Pollution","Overexploitation","Habitat fragmentation","Invasive species"]$mq$, 1, $mq$Poaching harvests wild animals faster than populations can recover. This is overexploitation, driven by market demand.$mq$, $mq$medium$mq$),
($mq$Why does a very small population of a rare animal face extra danger even if its habitat is protected?$mq$, $mq$["Small populations have low genetic variety, so inbreeding and disease can have a large effect","Small populations eat more food","Small populations are always invasive","Small populations cause habitat loss"]$mq$, 0, $mq$With few individuals, mates are related, harmful traits become common and a disease or bad year can wipe out the population.$mq$, $mq$medium$mq$),
($mq$Researchers list the threats to 200 endangered species: habitat loss affects 120, overexploitation 70, invasive species 50 and pollution 40. The total is 280. A student says there is an error. What is the best response?$mq$, $mq$["Yes, because the total must not exceed 200","Yes, because pollution cannot affect species","No, because habitat loss is the only real threat","No, because many species face more than one threat, so counts overlap"]$mq$, 3, $mq$Most species face several threats at once, so the counts add up to more than the number of species. Percentages of species affected would not total 100%.$mq$, $mq$hard$mq$),
($mq$A student claims: "Introduced species always damage ecosystems." Which is the most accurate evaluation?$mq$, $mq$["The claim is correct because every introduced species is invasive","The claim is incorrect because introduced species never spread","The claim is overgeneralised: many introduced species fail to establish or have little effect, and only some become invasive","The claim is correct because native species never compete"]$mq$, 2, $mq$Only a fraction of introduced species establish and spread enough to cause harm. Cane toads in Australia are an example of one that did.$mq$, $mq$hard$mq$),
($mq$A forest of 1200 ha loses 60 ha each year. If this constant loss continues, after how many years will 300 ha remain?$mq$, $mq$["5 years","15 years","20 years","10 years"]$mq$, 1, $mq$The area to be lost is 1200 − 300 = 900 ha. 900 ÷ 60 = 15 years. The whole forest would be gone in 20 years.$mq$, $mq$hard$mq$),
($mq$A road splits a reserve in two. Ten years later, the mouse populations on each side are small and genetically different from each other. Which explanation is best?$mq$, $mq$["The road is a barrier that reduces movement and gene flow between the two populations","Mice have stopped breeding","The road has increased the food supply","The mice have evolved wings"]$mq$, 0, $mq$Fragmentation isolates populations. With little movement between them, genetic variety within each falls and the groups drift apart.$mq$, $mq$hard$mq$),
($mq$Rainforest is cleared for oil palm plantations. Which statement best explains why this causes a major loss of biodiversity?$mq$, $mq$["Palms release too much oxygen","Rainforest has few species, so little is lost","Plantations always increase rainfall","A plantation of one crop species offers far fewer niches, food sources and shelter than a forest with many species"]$mq$, 3, $mq$A monoculture supports far fewer species than diverse forest. It also removes habitat for species that need the original forest structure.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Threats to Biodiversity$mq$ and p.name = $mq$Biodiversity and Conservation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$HIPPO$mq$, $mq$A memory aid for the main threats: Habitat loss, Invasive species, Pollution, Population growth (human) and Overexploitation.$mq$),
($mq$Habitat fragmentation$mq$, $mq$Breaking up a large habitat into small isolated pieces, which increases edge effects and reduces gene flow between populations.$mq$),
($mq$Invasive species$mq$, $mq$A non-native species that spreads and harms native species or ecosystems, often because it has no natural predators in its new home.$mq$),
($mq$Overexploitation$mq$, $mq$Harvesting a species faster than it can reproduce, for example overfishing or poaching for ivory.$mq$),
($mq$Why are island species vulnerable?$mq$, $mq$They often evolved without predators or competitors, so introduced species such as rats and cats can quickly drive them to extinction.$mq$),
($mq$Biomagnification$mq$, $mq$A persistent chemical builds up in tissues and becomes more concentrated at each higher trophic level of a food chain.$mq$),
($mq$Coral bleaching$mq$, $mq$Warm water causes corals to expel their symbiotic algae, so they turn white and may die.$mq$),
($mq$Why do small populations face extra risk?$mq$, $mq$Low genetic variety causes inbreeding, and disease or a bad year can wipe them out.$mq$),
($mq$Percentage decrease formula$mq$, $mq$(original − new) ÷ original × 100. Always divide by the original value.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Threats to Biodiversity$mq$ and p.name = $mq$Biodiversity and Conservation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why is biodiversity declining?
Species have always gone extinct naturally, but today the rate of loss is far higher than the natural background rate. Almost all of this increase is linked to human activity. A useful way to remember the main threats is the **HIPPO** list: **H**abitat loss, **I**nvasive species, **P**ollution, **P**opulation growth (human) and **O**verexploitation. Climate change is now often added as a major threat.

## Habitat loss and fragmentation
Clearing forests, draining wetlands and building cities removes habitats completely. Where some habitat remains it is often broken into small pieces. This is **fragmentation**. Fragments have:
- more **edge** and less core habitat, so organisms are more exposed to wind, heat, predators and invasive species;
- smaller populations that are isolated, so there is less movement of individuals and genes;
- greater risk of local extinction because small populations are vulnerable to disease and bad years.

Example: a 10 km by 10 km square reserve has an edge of 40 km. Split it into four 5 km squares and the total edge is 80 km, although the area is unchanged.

## Invasive species
Species moved to new places, deliberately or by accident, can become invasive. They may eat or outcompete native species, spread disease, or change the habitat. Invasive species often have no natural predators or diseases in their new home. Island species are especially vulnerable because they evolved without predators such as rats and cats. Only some introduced species become invasive, so avoid saying that all do.

## Overexploitation
Harvesting wild species faster than they can reproduce causes populations to collapse. Examples include overfishing, illegal hunting for ivory and rhino horn, and the collecting of rare plants. The passenger pigeon, once among the most numerous birds in North America, was hunted to extinction by 1914.

## Pollution
Chemicals such as pesticides, plastics and fertiliser runoff harm organisms directly or accumulate in food chains. Persistent pesticides caused eggshell thinning in some birds of prey. Nutrient pollution can cause oxygen loss in water.

## Climate change
Rising temperatures and changing rainfall alter habitats faster than many species can adapt or move. Warm oceans cause coral bleaching, and melting sea ice removes habitat for polar species. Specialist species and those on mountain tops or islands have nowhere to go.

## Vulnerable species
Species are more at risk if they are specialists, have small populations, have a small range, reproduce slowly, or are large predators needing big territories. Small populations lose genetic diversity, which makes inbreeding and disease more damaging.

## Worked example
A frog population falls from 2400 to 1800. Percentage decrease = (2400 − 1800) ÷ 2400 × 100 = 25%. Always divide by the original value.

## Common mistakes
- Saying all introduced species are invasive.
- Treating threats as separate when they often combine.
- Calculating a percentage change from the new value rather than the original.

## How this is examined
Questions may give a case study, such as a forest cleared for farming or an island with introduced predators, plus data on area or population. You may need to identify the threats, calculate the change, explain how the threat reduces biodiversity, and evaluate which is the most serious.

Exam tip: link each threat to a mechanism. For example, say fragmentation reduces gene flow because populations are isolated, not just that it is bad.$mq$ from st;

-- Biodiversity and Conservation > Conservation Strategies
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Biodiversity and Conservation$mq$, 5, 2 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Conservation Strategies$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Biodiversity and Conservation$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Conservation Strategies$mq$ and p.name = $mq$Biodiversity and Conservation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which of these is an example of ex situ conservation?$mq$, $mq$["A seed bank","A national park","A marine protected area","A wildlife corridor"]$mq$, 0, $mq$Ex situ means "off site": protecting species outside their natural habitat, for example in zoos, botanic gardens and seed banks.$mq$, $mq$easy$mq$),
($mq$Which of these is an example of in situ conservation?$mq$, $mq$["A zoo breeding programme","Freezing seeds in a vault","Storing animal cells in a lab","Establishing a protected national park"]$mq$, 3, $mq$In situ means "on site": protecting species in their natural habitat.$mq$, $mq$easy$mq$),
($mq$What does the agreement known as CITES regulate?$mq$, $mq$["Fishing quotas in the Atlantic","The use of fertilisers","International trade in endangered species and their products","Emissions from cars"]$mq$, 2, $mq$CITES controls the international trade of wild animals and plants to make sure trade does not threaten their survival.$mq$, $mq$easy$mq$),
($mq$What is the main purpose of a wildlife corridor?$mq$, $mq$["Provide a place for tourists to camp","Connect separated habitats so animals can move between them","Keep predators out of a reserve","Increase the amount of fertiliser in soil"]$mq$, 1, $mq$Corridors link fragments of habitat, helping animals find food and mates and allowing gene flow between populations.$mq$, $mq$easy$mq$),
($mq$Which IUCN Red List category describes a species facing a very high risk of extinction in the wild, but not yet critically?$mq$, $mq$["Endangered","Least Concern","Vulnerable","Extinct"]$mq$, 0, $mq$The order of threat runs: Least Concern, Near Threatened, Vulnerable, Endangered, Critically Endangered, Extinct in the Wild, Extinct. Endangered is higher risk than Vulnerable.$mq$, $mq$easy$mq$),
($mq$A zoo breeds endangered parrots for release. Which is a limitation of captive breeding?$mq$, $mq$["Parrots can never reproduce in zoos","It always damages wild habitats","It is always cheaper than protecting habitat","Captive-bred animals may lack skills for the wild and the breeding group may have little genetic variety"]$mq$, 3, $mq$Animals bred in captivity may not know how to find food or avoid predators, and a small founder group limits genetic diversity.$mq$, $mq$medium$mq$),
($mq$A fishing authority sets a quota on the total weight of cod that can be caught each year. How does this support conservation?$mq$, $mq$["It lets fishers take unlimited cod","It bans all fishing forever","It limits harvesting so the fish population can reproduce and recover","It increases the numbers of predators"]$mq$, 2, $mq$A quota is a limit set so that catches stay at or below the level the population can replace, supporting sustainable use.$mq$, $mq$medium$mq$),
($mq$A village is given the right to manage a forest and share income from sustainable tourism. Why can this community-based approach help conservation?$mq$, $mq$["It removes all rules","Local people gain a direct benefit from protecting the forest, so they are more likely to support it","It stops all income","It forces people to leave the area"]$mq$, 1, $mq$When local people benefit economically they have a reason to protect wildlife. Conservation that ignores local needs often fails.$mq$, $mq$medium$mq$),
($mq$Programme A spends $240 000 to protect 600 ha. Programme B spends $450 000 to protect 1500 ha. Which has the lower cost per hectare?$mq$, $mq$["Programme B, at $300 per hectare","Programme A, at $400 per hectare","They are equal","Neither, because cost per hectare cannot be calculated"]$mq$, 0, $mq$A: 240 000 ÷ 600 = $400 per ha. B: 450 000 ÷ 1500 = $300 per ha. B is cheaper per hectare, although cost is only one factor.$mq$, $mq$medium$mq$),
($mq$Ecotourism is promoted as a conservation tool. Which statement shows a possible problem with it?$mq$, $mq$["It creates no jobs","It lowers awareness of wildlife","It always protects every species","It can bring disturbance, waste and development if visitor numbers are not controlled"]$mq$, 3, $mq$Ecotourism can fund protection, but large numbers of visitors may disturb animals, create pollution and damage habitats.$mq$, $mq$medium$mq$),
($mq$Wolves were reintroduced to Yellowstone National Park in the mid-1990s. Which result is an example of how the strategy can restore ecosystem balance?$mq$, $mq$["Wolves removed all other predators","Plants stopped growing","Deer and elk numbers and behaviour changed, allowing vegetation to recover in some areas","Rivers dried up"]$mq$, 2, $mq$Predator reintroduction can reduce overgrazing, giving plants a chance to regrow. It is a rewilding approach, and results are complex and debated.$mq$, $mq$medium$mq$),
($mq$The Svalbard Global Seed Vault in Norway stores duplicates of seeds from gene banks around the world. What is its main aim?$mq$, $mq$["To grow food for Norway","To protect crop genetic diversity as a back-up against loss","To sell seeds to farmers","To plant forests in the Arctic"]$mq$, 1, $mq$Seed banks preserve genetic variety for future breeding and as insurance against disasters, war or disease.$mq$, $mq$medium$mq$),
($mq$What is a no-take zone within a marine protected area?$mq$, $mq$["An area where fishing and extraction of marine life are banned, allowing populations to recover","An area where tourists are not allowed to swim","An area where only large boats may fish","An area where waste is dumped"]$mq$, 0, $mq$In a no-take zone nothing can be removed. Fish can grow larger and breed, and some may move out to nearby fishing areas.$mq$, $mq$medium$mq$),
($mq$A captive breeding programme releases 30 animals into the wild after beginning with 12 breeding animals. What is the percentage increase from 12 to 30?$mq$, $mq$["60%","18%","250%","150%"]$mq$, 3, $mq$The increase is 30 − 12 = 18. 18 ÷ 12 × 100 = 150%. A 250% value is the 30 compared as a percentage of 12, not the increase.$mq$, $mq$hard$mq$),
($mq$A habitat is nearly destroyed and only 40 individuals of a species remain. Which strategy combination is best justified?$mq$, $mq$["Do nothing, as natural selection will solve the problem","Only ex situ conservation for ever","Protect and restore remaining habitat (in situ) and run a captive breeding programme as a back-up (ex situ), with careful planning for reintroduction","Only create more roads through the habitat"]$mq$, 2, $mq$Ex situ methods provide security while in situ work restores habitat. Without habitat the animals have nowhere to be released.$mq$, $mq$hard$mq$),
($mq$A fish stock of 50 000 grows by 12% each year if left alone. Fishers take 8000 in one year. What is the stock at the end of the year, assuming growth is added before the catch?$mq$, $mq$["58 000","48 000","42 000","50 000"]$mq$, 1, $mq$Growth = 12% of 50 000 = 6000, so the stock becomes 56 000. After taking 8000 it is 48 000. The catch is higher than the growth, so the stock is falling and the harvest is not sustainable.$mq$, $mq$hard$mq$),
($mq$A government announces a "protected area" but there are few rangers and logging continues. A student says the area is not effective. Which evidence would best support the student's claim?$mq$, $mq$["Satellite images show forest cover continuing to fall inside the boundary","The area has a sign at the entrance","The area is large","The area is mentioned in a speech"]$mq$, 0, $mq$Effectiveness is judged by outcomes. If forest is still being lost, the protection exists on paper only, so it needs enforcement and resources.$mq$, $mq$hard$mq$),
($mq$Should conservation funding go to one very large reserve or several small ones of the same total area? Which argument favours the single large reserve?$mq$, $mq$["Small reserves have more core habitat","Small reserves cannot be fenced","Large reserves never need management","Large areas have less edge relative to area and can support bigger populations of species that need space"]$mq$, 3, $mq$A large reserve has proportionally less edge and supports larger, more genetically healthy populations. Several small reserves can spread risk, so the choice involves trade-offs.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Conservation Strategies$mq$ and p.name = $mq$Biodiversity and Conservation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$In situ conservation$mq$, $mq$Protecting species in their natural habitat, for example national parks, marine protected areas and wildlife corridors.$mq$),
($mq$Ex situ conservation$mq$, $mq$Protecting species away from their natural habitat, for example zoos, botanic gardens, seed banks and gene banks.$mq$),
($mq$CITES$mq$, $mq$An international agreement that regulates trade in endangered wild animals and plants and their products.$mq$),
($mq$Wildlife corridor$mq$, $mq$A strip of habitat linking separated areas so animals can move, find mates and allow gene flow between populations.$mq$),
($mq$Limitations of captive breeding$mq$, $mq$Animals may lack wild survival skills, genetic variety may be small, it is costly, and release needs a suitable habitat.$mq$),
($mq$Fishing quota$mq$, $mq$A limit on the amount of a species that can be caught, set so the population can replace itself.$mq$),
($mq$Why involve local communities?$mq$, $mq$If they benefit, for example from jobs or sustainable income, they are more likely to protect wildlife and follow rules.$mq$),
($mq$IUCN Red List order of risk$mq$, $mq$Least Concern, Near Threatened, Vulnerable, Endangered, Critically Endangered, Extinct in the Wild, Extinct.$mq$),
($mq$Rewilding$mq$, $mq$Restoring ecosystems by letting nature recover, often by reintroducing missing species such as large predators.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Conservation Strategies$mq$ and p.name = $mq$Biodiversity and Conservation$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why conserve?
Conservation means protecting and managing species and ecosystems. People give several reasons: ecosystems provide services such as clean water, pollination and flood control; species have value for food, medicine and tourism; and many people feel that nature has its own right to exist. In MYP Sciences you should be able to describe strategies, evaluate their strengths and limits, and judge which is most suitable in a given case.

## In situ strategies (on site)
Protecting species in their natural habitat.
- **Protected areas** such as national parks, nature reserves and marine protected areas restrict harmful activities. They only work if rules are enforced and local people are involved.
- **Wildlife corridors** connect fragments so animals can move and genes can flow.
- **Habitat restoration and rewilding**: replanting forests, restoring wetlands, or reintroducing missing species. Wolves were reintroduced to Yellowstone National Park in the mid-1990s, and the effect on deer behaviour and vegetation has been studied.
- **Sustainable management**: fishing quotas, closed seasons and sustainable forestry let harvesting continue without collapsing populations.

## Ex situ strategies (off site)
Protecting species outside their natural habitat.
- **Captive breeding** in zoos and aquaria, with the aim to release animals later.
- **Seed banks and botanic gardens**, such as the Svalbard Global Seed Vault in Norway, which stores back-up seed from around the world.
- **Gene banks** that freeze cells or sperm.

Limitations: captive animals may lose wild skills, the founder group may have little genetic variety, it is expensive, and there is no point releasing animals if their habitat has gone. Ex situ is best used as a back-up and alongside in situ work.

## Laws and agreements
International agreements such as **CITES** regulate trade in endangered species. National laws can ban hunting or protect habitats. Laws need monitoring, penalties and enough funding.

## Community involvement
People who live next to wildlife are more likely to protect it if they benefit, for example from ecotourism jobs or from managing resources sustainably. Ignoring local needs can lead to poaching and conflict. Ecotourism can fund conservation, but too many visitors can cause disturbance and waste.

## The IUCN Red List
This assesses extinction risk. Categories from lowest to highest risk: Least Concern, Near Threatened, Vulnerable, Endangered, Critically Endangered, Extinct in the Wild, Extinct. It helps to decide which species need action first.

## Worked example: comparing costs
Programme A: $240 000 for 600 ha = $400 per ha. Programme B: $450 000 for 1500 ha = $300 per ha. B is cheaper per hectare, but you should also consider the quality of the habitat, the species protected and long-term running costs.

Sustainable harvest example: a fish stock of 50 000 grows 12% a year (6000). Taking 8000 means the stock falls to 48 000, so the catch is not sustainable. A sustainable catch is no more than the annual growth.

## Common mistakes
- Confusing in situ (on site) with ex situ (off site).
- Saying captive breeding alone saves a species. Habitat protection is also needed.
- Ignoring people. The best strategies consider local communities and economics.

## How this is examined
Questions usually give a species or region and ask you to recommend and justify strategies. You may need to calculate cost per hectare or population change, compare two options using stated criteria, and discuss limitations such as cost, enforcement and genetic diversity.

Exam tip: in an evaluation question give at least one strength and one limitation of each strategy, then make a clear judgement using evidence from the context.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('environmental-systems')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;