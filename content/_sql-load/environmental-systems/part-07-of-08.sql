-- Part 7 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Sustainability and Policy > Environmental Values and Worldviews
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Sustainability and Policy$mq$, 5, 7 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Environmental Values and Worldviews$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Sustainability and Policy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Environmental Values and Worldviews$mq$ and p.name = $mq$Sustainability and Policy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which worldview puts human needs and interests at the centre when making environmental decisions?$mq$, $mq$["Anthropocentric","Ecocentric","Biocentric","Lithocentric"]$mq$, 0, $mq$Anthropocentric means human-centred. Ecocentric views value whole ecosystems and biocentric views value all living things.$mq$, $mq$easy$mq$),
($mq$Which worldview values ecosystems and nature for their own sake, not only for what they provide to people?$mq$, $mq$["Anthropocentric","Technocentric","Consumerist","Ecocentric"]$mq$, 3, $mq$Ecocentric thinking sees nature as having intrinsic value, so humans are one part of a larger system.$mq$, $mq$easy$mq$),
($mq$What is a stakeholder in an environmental decision?$mq$, $mq$["Only the government","Only scientists","A person or group affected by, or able to influence, the decision","Only the company's owners"]$mq$, 2, $mq$Stakeholders include residents, businesses, governments, conservation groups and future generations.$mq$, $mq$easy$mq$),
($mq$What is meant by 'intrinsic value' of a species?$mq$, $mq$["Its price at market","Its value in its own right, regardless of its use to humans","Its use in medicine only","Its number in zoos"]$mq$, 1, $mq$Intrinsic value does not depend on usefulness. Instrumental value means useful to others.$mq$, $mq$easy$mq$),
($mq$Which statement describes a technocentric view?$mq$, $mq$["Technology and human ingenuity can solve environmental problems","Technology should never be used","Nature has no value","Population growth is the only problem"]$mq$, 0, $mq$Technocentric thinkers trust science, technology and management; critics warn that technology alone may not be enough.$mq$, $mq$easy$mq$),
($mq$A town wants to drain a wetland to build a shopping centre. A resident says: 'The wetland has a right to exist even if no one uses it.' Which worldview is this?$mq$, $mq$["Anthropocentric","Technocentric only","Economic only","Ecocentric"]$mq$, 3, $mq$Valuing the wetland for its own sake reflects an ecocentric or biocentric perspective rather than a human-use one.$mq$, $mq$medium$mq$),
($mq$A mayor says: 'We should protect the river because clean water supports tourism and public health.' What is the main basis of this argument?$mq$, $mq$["Intrinsic value of the river only","Biocentric ethics only","Instrumental value, benefits to people","No value"]$mq$, 2, $mq$The river is valued for what it does for humans, an anthropocentric argument.$mq$, $mq$medium$mq$),
($mq$The precautionary principle states that:$mq$, $mq$["Action is only allowed when harm is proved","Where serious harm is possible, lack of full certainty should not delay protective action","No new technology should ever be used","Uncertain risks should be ignored"]$mq$, 1, $mq$The precautionary principle supports acting early when risks are serious, even if the science is not complete.$mq$, $mq$medium$mq$),
($mq$Why might two people with the same data reach different conclusions about a new mine?$mq$, $mq$["Their values, interests and worldviews lead them to weigh costs and benefits differently","One of them must be lying","Data never influence decisions","Mines have no effects"]$mq$, 0, $mq$Data inform decisions, but values decide which costs and benefits matter most.$mq$, $mq$medium$mq$),
($mq$What does 'tragedy of the commons' describe?$mq$, $mq$["Sharing resources always protects them","Governments owning all land","Commons being unlimited","Individuals acting in their own interest overuse a shared resource until it is depleted"]$mq$, 3, $mq$Without rules or shared responsibility, each user gains from taking more while the cost is shared, leading to depletion such as overfishing.$mq$, $mq$medium$mq$),
($mq$Which statement identifies an ethical argument for protecting the environment for future generations?$mq$, $mq$["Future generations do not matter","Only present profits count","Current generations have a duty not to leave a degraded planet for people not yet born","The environment has no limits"]$mq$, 2, $mq$Intergenerational equity is a key idea in sustainable development.$mq$, $mq$medium$mq$),
($mq$Which of these is the best example of an environmental perspective that compares cost and benefit in money terms?$mq$, $mq$["A purely spiritual perspective","An economic perspective, such as putting a price on a wetland's flood protection","A random guess","A political slogan"]$mq$, 1, $mq$Economic valuation tries to measure services such as flood control or carbon storage in monetary terms, which is useful but cannot capture everything.$mq$, $mq$medium$mq$),
($mq$A fishing community has fished one bay for centuries and keeps catches below a limit. What does this show?$mq$, $mq$["Local knowledge and shared rules can manage a common resource sustainably","Commons always fail","Local people know nothing","Fish do not need management"]$mq$, 0, $mq$Traditional and community systems can prevent the tragedy of the commons by agreeing limits.$mq$, $mq$medium$mq$),
($mq$A council must decide whether to protect a forest. Group A: loggers (jobs). Group B: villagers (clean water). Group C: a conservation charity (biodiversity). Which approach best supports fair decision making?$mq$, $mq$["Follow only the loudest group","Ignore the villagers","Decide without any data","Consult all stakeholders, weigh evidence on social, economic and environmental impacts and seek a compromise"]$mq$, 3, $mq$Fair processes include all affected groups and use evidence, then explain how trade-offs were balanced.$mq$, $mq$hard$mq$),
($mq$A company states: 'New technology will fix any pollution later, so we can expand now.' Which critique is strongest?$mq$, $mq$["Technology never helps","It is a perfect argument","It assumes future technology will solve the problem, which is uncertain and may be too late or costly; the precautionary principle suggests acting now","Expansion has no effects"]$mq$, 2, $mq$Relying on future solutions is risky if damage is irreversible. A critique should name the assumption and the risk.$mq$, $mq$hard$mq$),
($mq$Which statement best compares an ecocentric and an anthropocentric answer to the question 'Should a rare orchid be moved so a road can be built?'$mq$, $mq$["Both say the road must be built","Ecocentric: the orchid and its habitat matter in themselves; anthropocentric: weigh the road's benefits to people against the orchid's value to people","Both say orchids have no value","Ecocentric: ignore evidence; anthropocentric: ignore people"]$mq$, 1, $mq$The two views use different starting points for value, which can lead to different conclusions even with the same facts.$mq$, $mq$hard$mq$),
($mq$A survey of 200 people in a town finds that 150 support a new wind farm. A councillor says: 'Everyone supports it.' What is the best evaluation?$mq$, $mq$["75% support, so 25% do not; 'everyone' is inaccurate and minority views should be considered","The statement is accurate","The 25% should be excluded","200 is too many people"]$mq$, 0, $mq$150 ÷ 200 × 100 = 75%. A fair report states the proportion and recognises disagreement.$mq$, $mq$hard$mq$),
($mq$Which scenario is the clearest example of the tragedy of the commons?$mq$, $mq$["A family garden managed by one owner","A protected park with strict limits","A farm that rotates crops","Many boats each increase their catch in an unregulated fishery until fish stocks collapse"]$mq$, 3, $mq$Open access and individual gain without limits lead to overuse. Rules, quotas or shared management can prevent it.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Environmental Values and Worldviews$mq$ and p.name = $mq$Sustainability and Policy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Anthropocentric$mq$, $mq$Human-centred worldview: nature is valued mainly for how it benefits people.$mq$),
($mq$Ecocentric$mq$, $mq$Ecosystem-centred worldview: ecosystems and nature have value in their own right; humans are part of nature.$mq$),
($mq$Biocentric$mq$, $mq$Worldview that gives value to all living things, not just humans.$mq$),
($mq$Technocentric$mq$, $mq$Belief that science, technology and good management can solve environmental problems.$mq$),
($mq$Instrumental vs intrinsic value$mq$, $mq$Instrumental: valued for its usefulness. Intrinsic: valued for its own sake, whatever its use.$mq$),
($mq$Stakeholder$mq$, $mq$Any person or group affected by a decision or able to influence it, e.g. residents, businesses, governments, conservation groups.$mq$),
($mq$Precautionary principle$mq$, $mq$If an action could cause serious harm, lack of certainty should not delay protective measures.$mq$),
($mq$Tragedy of the commons$mq$, $mq$Individuals overusing a shared, open-access resource for personal gain until it collapses, e.g. overfishing.$mq$),
($mq$Intergenerational equity$mq$, $mq$Fairness between generations: leave future people a healthy environment and enough resources.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Environmental Values and Worldviews$mq$ and p.name = $mq$Sustainability and Policy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Environmental decisions are never based on facts alone. People weigh costs and benefits differently because of their **values**, interests and **worldviews**. Understanding these perspectives helps you explain why a mine, dam or wind farm can be supported by some people and opposed by others.

## Main worldviews
- **Anthropocentric** (human-centred): nature is valued mainly for what it provides to people, such as food, water, jobs and recreation. It focuses on human wellbeing and can still support conservation if it benefits people.
- **Biocentric**: all living things have value, not only humans.
- **Ecocentric** (ecosystem-centred): whole ecosystems, including living and non-living parts, have value in their own right. Humans are part of nature, not above it.
- **Technocentric**: people can solve environmental problems through technology, science and good management.

Real people often mix these views. A person can value nature for its own sake and still support new technology.

## Types of value
- **Instrumental value**: something is valued because it is useful (a forest provides timber and clean water).
- **Intrinsic value**: something has worth in itself, regardless of use (a rare orchid).
- **Economic value**: value in money terms, such as the cost of flood damage a wetland prevents.
- **Cultural and spiritual value**: sacred sites, traditions and a sense of place.

## Key ideas for decision-making
- **Stakeholders** are people or groups affected by a decision or able to influence it. Examples: local residents, businesses, governments, conservation groups, future generations.
- **Intergenerational equity**: the idea that we should leave future generations enough resources and a healthy environment.
- **Precautionary principle**: if an action could cause serious harm, lack of complete scientific certainty should not be used as a reason to delay protective action.
- **Tragedy of the commons**: when many people share an open-access resource such as a fishery, each gains by taking more, so the resource is overused and collapses. Solutions include quotas, laws, community agreements and ownership with responsibility.

## Interpreting opinion data
Suppose 150 of 200 people surveyed support a wind farm. The support is 150 ÷ 200 × 100 = 75%. That means 25% do not support it. Saying "everyone supports it" would be inaccurate, and the opposing group may have good reasons, such as noise or landscape.

## Fair evaluation
When you evaluate an environmental choice:
- List the stakeholders and what each gains or loses.
- Use evidence about social, economic and environmental impacts.
- Identify the worldview or value behind each argument.
- Consider short-term and long-term effects.
- Suggest compromises or alternatives.

## Common mistakes
- Assuming one worldview is "correct" in every situation. In MYP you analyse and compare perspectives.
- Confusing anthropocentric (humans first) with technocentric (technology will solve it).
- Treating opinions as facts. A good answer separates evidence from values.

## How this is examined
Tasks usually present a local issue, such as a quarry, a reserve or a fishing ban, with quotes from different stakeholders. You identify each viewpoint, describe the values behind it, interpret survey data and discuss a balanced decision.

Exam tip: name the worldview, explain the value behind the statement, and then link it to evidence; avoid saying one group is simply "wrong".$mq$ from st;

-- Sustainability and Policy > Environmental Impact Assessment
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Sustainability and Policy$mq$, 5, 7 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Environmental Impact Assessment$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Sustainability and Policy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Environmental Impact Assessment$mq$ and p.name = $mq$Sustainability and Policy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is an Environmental Impact Assessment (EIA)?$mq$, $mq$["A study of the likely environmental effects of a proposed project before it goes ahead","A list of animals in a zoo","A tax on pollution","A report written after a disaster only"]$mq$, 0, $mq$An EIA predicts and evaluates effects of a project, and suggests ways to reduce harm, before decisions are made.$mq$, $mq$easy$mq$),
($mq$Which project would most likely need an EIA?$mq$, $mq$["A bedroom repaint","A school bake sale","A garden bird feeder","A new motorway through a forest"]$mq$, 3, $mq$Large projects that could affect ecosystems, water, air or communities usually need an EIA.$mq$, $mq$easy$mq$),
($mq$What is a baseline survey?$mq$, $mq$["A survey after construction","A guess","A record of the environment's condition before the project begins","A tax form"]$mq$, 2, $mq$Without baseline data you cannot tell what has changed because of the project.$mq$, $mq$easy$mq$),
($mq$Which of the following is an example of a negative environmental impact of a quarry?$mq$, $mq$["More habitat","Dust and loss of habitat","Cleaner air","Higher rainfall everywhere"]$mq$, 1, $mq$Quarrying removes land, creates dust and noise and can disturb wildlife.$mq$, $mq$easy$mq$),
($mq$What does 'mitigation' mean in an EIA?$mq$, $mq$["Steps to reduce or avoid negative impacts","Making impacts worse","Ignoring impacts","Proving there are no impacts"]$mq$, 0, $mq$Mitigation measures include relocating a route, building wildlife crossings or controlling dust.$mq$, $mq$easy$mq$),
($mq$Which is the correct order for the main steps of an EIA?$mq$, $mq$["Construction, then baseline, then decision","Decision, then prediction, then baseline","Monitoring only","Baseline study, predict impacts, suggest mitigation, public consultation and decision, then monitoring"]$mq$, 3, $mq$The EIA is done before approval, and monitoring continues during and after the project.$mq$, $mq$medium$mq$),
($mq$A proposed dam will flood a valley. Which impact is direct, long term and likely irreversible?$mq$, $mq$["Short-term noise during building","Temporary traffic","Loss of the valley's habitats under the reservoir","Short-term dust"]$mq$, 2, $mq$Flooding permanently removes habitat. Noise, traffic and dust are shorter-term effects of construction.$mq$, $mq$medium$mq$),
($mq$An EIA scores each option from 1 (very harmful) to 5 (very beneficial) with weights: economic 0.5, social 0.3, environmental 0.2. Option A scores 4, 2, 5 and Option B scores 2, 5, 3. Which has the higher weighted score and what is it?$mq$, $mq$["Option B with 3.1","Option A with 3.6","Option A with 3.6 and B equal","Option B with 4.2"]$mq$, 1, $mq$A: 0.5×4 + 0.3×2 + 0.2×5 = 3.6. B: 0.5×2 + 0.3×5 + 0.2×3 = 3.1. Note that the weights decide the result, so changing the weights could change the ranking.$mq$, $mq$medium$mq$),
($mq$Why is public consultation important in an EIA?$mq$, $mq$["Local people can provide knowledge and views, and their concerns can be considered","It makes the report longer","It removes the need for data","It guarantees the project is approved"]$mq$, 0, $mq$Consultation gives affected communities a voice and may reveal impacts experts missed.$mq$, $mq$medium$mq$),
($mq$A developer's EIA was written only by the developer's own staff. What is the main concern?$mq$, $mq$["EIAs must be secret","Staff cannot read","There is no concern","Possible bias, so independent review is useful"]$mq$, 3, $mq$A conflict of interest may lead to under-reporting of harm. Independent assessment and publication improve trust.$mq$, $mq$medium$mq$),
($mq$Which is an example of a mitigation measure for a new road through woodland?$mq$, $mq$["Increasing the speed limit only","Removing more trees","Building tunnels or bridges for wildlife to cross","Ignoring local people"]$mq$, 2, $mq$Wildlife crossings reduce the barrier effect of roads and collisions.$mq$, $mq$medium$mq$),
($mq$What is the purpose of monitoring after a project is approved?$mq$, $mq$["To find a new site","To check whether predicted impacts occur and whether mitigation works","To prevent any measurement","To increase costs only"]$mq$, 1, $mq$Monitoring allows problems to be found and corrected, and improves future predictions.$mq$, $mq$medium$mq$),
($mq$A wind farm EIA reports that bird deaths were 'low'. Which extra information would make the claim more useful?$mq$, $mq$["Numbers of deaths per year compared with baseline and with the population size","The colour of the turbines","The name of the developer","The weather yesterday"]$mq$, 0, $mq$Quantified data and comparison with a baseline show whether the effect is significant.$mq$, $mq$medium$mq$),
($mq$An EIA predicts that a new factory will raise river temperature by 3 °C and that the river currently averages 12 °C, with fish suffering stress above 16 °C. What is the most appropriate conclusion?$mq$, $mq$["The project is definitely harmless","The river will reach 18 °C","Temperature cannot matter to fish","The predicted 15 °C is below the threshold on average, but summer peaks and uncertainty should be checked"]$mq$, 3, $mq$12 + 3 = 15 °C, below 16 °C on average. A careful evaluation considers variation, worst cases and the limits of predictions.$mq$, $mq$hard$mq$),
($mq$Which statement best shows why EIA predictions have limitations?$mq$, $mq$["They are always exact","They never use data","They rely on models, incomplete data and assumptions about future conditions","They only consider money"]$mq$, 2, $mq$Uncertainty arises because ecosystems are complex and future events cannot be known. Good reports state limitations.$mq$, $mq$hard$mq$),
($mq$An EIA recommends a pipeline route that avoids a wetland but passes close to a village, adding 12 km to the route. The original route was 40 km and costs 2 million per km. What is the extra cost of the longer route?$mq$, $mq$["2 million","24 million","80 million","104 million"]$mq$, 1, $mq$Extra distance 12 km × 2 million = 24 million. The longer route costs 52 × 2 = 104 million in total, compared with 80 million. Trade-offs between cost, ecology and communities should be discussed.$mq$, $mq$hard$mq$),
($mq$A developer says: 'No harm was found because we surveyed only one day in winter.' Which flaw in the investigation is most important?$mq$, $mq$["A single winter day gives an unrepresentative sample; seasonal variation and repeated sampling are required","Winter data are always wrong","One day is ideal","Surveys never matter"]$mq$, 0, $mq$Many species are present or active only in some seasons. Reliable baseline data need repeated surveys across time.$mq$, $mq$hard$mq$),
($mq$Which conclusion is best supported when an EIA finds large benefits to jobs but significant, irreversible loss of a rare habitat?$mq$, $mq$["Approve the project because jobs always matter most","Reject all projects","Ignore the habitat since it is rare","A cautious decision considering alternatives, stronger mitigation, compensation or rejecting the project under the precautionary principle"]$mq$, 3, $mq$When harm is serious and irreversible, decision-makers should consider alternatives and precaution, and weigh the trade-offs explicitly.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Environmental Impact Assessment$mq$ and p.name = $mq$Sustainability and Policy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Environmental Impact Assessment (EIA)$mq$, $mq$A study before a major project to predict its environmental and social effects, suggest mitigation, and inform the decision.$mq$),
($mq$Baseline study$mq$, $mq$Measurements of the environment before a project, used to judge later change.$mq$),
($mq$Mitigation$mq$, $mq$Measures to avoid, reduce or compensate for negative impacts, e.g. wildlife crossings or dust control.$mq$),
($mq$Direct vs indirect impact$mq$, $mq$Direct: caused immediately by the project (habitat removed). Indirect: knock-on effects (more traffic and pollution nearby).$mq$),
($mq$Short-term vs long-term impacts$mq$, $mq$Short-term: during construction (noise, dust). Long-term: lasting effects (flooded valley, permanent habitat loss).$mq$),
($mq$Reversible vs irreversible$mq$, $mq$Reversible impacts can recover after the project; irreversible impacts, like extinction, cannot.$mq$),
($mq$Role of public consultation$mq$, $mq$Gives affected people a voice, adds local knowledge and increases fairness and trust in the decision.$mq$),
($mq$Weighted scoring matrix$mq$, $mq$Scores options on criteria multiplied by weights that reflect priorities. Changing weights can change the ranking.$mq$),
($mq$Limitations of EIAs$mq$, $mq$Uncertain predictions, short surveys, possible bias, overlooking cumulative effects, and the result is advice, not a legal requirement to reject.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Environmental Impact Assessment$mq$ and p.name = $mq$Sustainability and Policy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$An **Environmental Impact Assessment (EIA)** is a systematic study carried out before a major project, such as a road, dam, mine, airport or housing estate, to predict how it will affect the environment and communities. The purpose is to help decision-makers avoid or reduce harm before it happens, and to make the decision open to the public.

## Main steps
- **Screening and scoping**: decide whether an EIA is needed and which issues to study.
- **Baseline study**: record the environment before the project, for example species counts, water quality, noise levels and land use. Without a baseline you cannot say what changed.
- **Impact prediction**: estimate the effects of construction and operation on air, water, soil, wildlife, landscape and people.
- **Mitigation**: propose steps to avoid, reduce or compensate for harm, such as wildlife bridges, dust control, planting trees or changing the route.
- **Report and public consultation**: publish findings and listen to stakeholders.
- **Decision and monitoring**: authorities approve, change or reject the project. After approval, monitoring checks whether the predictions were right.

## Describing impacts
Impacts can be described as:
- **Positive or negative**
- **Direct or indirect** (habitat loss versus more traffic and pollution nearby)
- **Short-term or long-term** (noise during building versus flooding of a valley)
- **Reversible or irreversible**
- **Local or wide-ranging**
- **Significant or minor**

## Comparing options
An EIA often compares alternatives with a scoring matrix. Suppose options are scored from 1 to 5 and weighted: economic 0.5, social 0.3, environmental 0.2. Option A scores 4, 2 and 5, giving 0.5×4 + 0.3×2 + 0.2×5 = 3.6. Option B scores 2, 5 and 3, giving 3.1. The weights represent values, so another group with different priorities could choose differently. Always state this limitation.

## Strengths and limitations
Strengths: considers impacts early, encourages alternatives and public participation, and creates evidence for decisions.

Limitations:
- Predictions use models and assumptions and cannot be perfectly certain.
- Surveys may miss seasonal or rare species if sampling is too short.
- Reports may be biased if written by the developer.
- Cumulative effects of many small projects can be overlooked.
- The EIA informs the decision but does not force a particular outcome.

## Common mistakes
- Treating an EIA as a simple "yes or no". It is a process that informs a decision.
- Describing impacts without saying whether they are direct, indirect, short or long term.
- Giving numbers without comparing them to a baseline or a threshold.

## How this is examined
You may receive an extract from an EIA of a proposed airport or wind farm with data tables or a map. Tasks include identifying types of impact, calculating costs or weighted scores, proposing mitigation, and evaluating how reliable the assessment is.

Exam tip: for "evaluate", state a decision, give evidence from the data, name a limitation of the data or method, and suggest further information that would improve the assessment.$mq$ from st;

-- Sustainability and Policy > Sustainable Development Goals in Action
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Sustainability and Policy$mq$, 5, 7 from public.subjects s where s.slug = $mq$environmental-systems$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Sustainable Development Goals in Action$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$environmental-systems$mq$ and p.grade = 5 and p.name = $mq$Sustainability and Policy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Sustainable Development Goals in Action$mq$ and p.name = $mq$Sustainability and Policy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What are the Sustainable Development Goals (SDGs)?$mq$, $mq$["17 global goals adopted by UN member states in 2015 to be achieved by 2030","10 goals to end war","5 goals for sports","7 goals for pollution only"]$mq$, 0, $mq$The SDGs are a shared plan for people, planet and prosperity, part of the 2030 Agenda.$mq$, $mq$easy$mq$),
($mq$Which SDG focuses on access to safe water and sanitation?$mq$, $mq$["SDG 1: No Poverty","SDG 13: Climate Action","SDG 4: Quality Education","SDG 6: Clean Water and Sanitation"]$mq$, 3, $mq$SDG 6 aims for available and sustainably managed water and sanitation for all.$mq$, $mq$easy$mq$),
($mq$Which SDG is directly about taking urgent action on climate change?$mq$, $mq$["SDG 2: Zero Hunger","SDG 5: Gender Equality","SDG 13: Climate Action","SDG 16: Peace and Justice"]$mq$, 2, $mq$SDG 13 covers climate action and resilience. Other goals also link to climate in different ways.$mq$, $mq$easy$mq$),
($mq$What does 'sustainable development' mean?$mq$, $mq$["Fast growth at any cost","Meeting the needs of the present without compromising the ability of future generations to meet their own needs","Only protecting animals","Stopping all development"]$mq$, 1, $mq$This widely used definition comes from the 1987 Brundtland Commission report.$mq$, $mq$easy$mq$),
($mq$The three pillars of sustainability are:$mq$, $mq$["Environmental, social and economic","Political, military and religious","Solar, wind and water","Past, present and future only"]$mq$, 0, $mq$Sustainable solutions balance the three pillars, rather than focusing on one.$mq$, $mq$easy$mq$),
($mq$A village installs a solar-powered water pump so girls no longer spend hours collecting water and can attend school. Which SDGs does this support most directly?$mq$, $mq$["SDG 14 only","SDG 9 only","None","SDG 6 (clean water), SDG 7 (clean energy) and SDG 4 (education)"]$mq$, 3, $mq$The project links water, energy and education, showing the interconnected nature of the SDGs.$mq$, $mq$medium$mq$),
($mq$Why can the SDGs sometimes conflict with each other?$mq$, $mq$["All goals are identical","Goals never involve trade-offs","Actions that boost economic growth (SDG 8) may increase resource use or emissions that harm SDG 13 or SDG 15","Conflicts only happen in science labs"]$mq$, 2, $mq$Trade-offs and synergies exist between goals, so planning must balance them.$mq$, $mq$medium$mq$),
($mq$Which is the best example of SDG 12 (Responsible Consumption and Production)?$mq$, $mq$["A factory dumps waste into a river","A company redesigns packaging to use less material and be fully recyclable","A shop gives free plastic bags","A city adds more landfills"]$mq$, 1, $mq$SDG 12 includes reducing waste through prevention, reduction, recycling and reuse.$mq$, $mq$medium$mq$),
($mq$A city has a target to cut waste sent to landfill from 240 000 tonnes to 180 000 tonnes per year. What is the percentage reduction?$mq$, $mq$["25%","33%","75%","60%"]$mq$, 0, $mq$Reduction = 60 000 t. 60 000 ÷ 240 000 × 100 = 25%. Dividing by 180 000 would wrongly give 33%.$mq$, $mq$medium$mq$),
($mq$Which is an indicator that could track progress for SDG 7 (Affordable and Clean Energy)?$mq$, $mq$["Number of football matches","Average shoe size","Number of cars sold","Percentage of the population with access to electricity"]$mq$, 3, $mq$Indicators are measurable values used to monitor goals. Access to electricity is a standard indicator.$mq$, $mq$medium$mq$),
($mq$Why are partnerships important in SDG 17?$mq$, $mq$["Countries should avoid cooperation","Only charities can act","Large global problems need cooperation between governments, businesses, communities and organisations","Partnerships are illegal"]$mq$, 2, $mq$Funding, technology transfer and shared knowledge help achieve the goals.$mq$, $mq$medium$mq$),
($mq$Which action by a student community best matches SDG 15 (Life on Land)?$mq$, $mq$["Building a new car park","Restoring a local woodland with native trees","Using more pesticides","Draining a wetland"]$mq$, 1, $mq$SDG 15 aims to protect, restore and sustainably use land ecosystems and halt biodiversity loss.$mq$, $mq$medium$mq$),
($mq$A community project plants mangroves along a coast. Which benefit links to adaptation to climate change?$mq$, $mq$["Mangroves reduce wave damage and protect against storm surges","They increase sea level","They remove all rain","They release more CO₂ than they absorb"]$mq$, 0, $mq$Mangroves protect coastlines and also store carbon and shelter marine life, supporting several goals.$mq$, $mq$medium$mq$),
($mq$A country reports that 90 of 120 villages now have clean water, up from 60 villages five years ago. By how many percentage points has coverage risen?$mq$, $mq$["15 percentage points","50 percentage points","75 percentage points","25 percentage points (50% to 75%)"]$mq$, 3, $mq$60 ÷ 120 = 50% and 90 ÷ 120 = 75%. The rise is 25 percentage points. Note the number of villages rose by 30, a 50% increase on the original 60.$mq$, $mq$hard$mq$),
($mq$A project builds a large hydroelectric dam to provide clean energy (SDG 7). It floods farmland and displaces 5000 people. Which evaluation is most balanced?$mq$, $mq$["It supports every goal fully","It supports no goals","It supports SDG 7 and reduces emissions, but harms SDGs related to land, communities and ecosystems; compensation, alternatives and consultation must be considered","Only the cost matters"]$mq$, 2, $mq$Real projects have synergies and trade-offs. A balanced evaluation considers all pillars.$mq$, $mq$hard$mq$),
($mq$A report states that a country has 'achieved SDG 2 (Zero Hunger)' because average food supply per person is above a minimum. What is the main flaw in this reasoning?$mq$, $mq$["Averages are always correct","Averages can hide inequality; some groups may still be hungry","Food supply is not measurable","SDG 2 is about energy"]$mq$, 1, $mq$Disaggregated data (by region, income, gender) are needed to see whether everyone is reached, a principle of leaving no one behind.$mq$, $mq$hard$mq$),
($mq$A local council wants to reduce emissions (SDG 13), improve health (SDG 3) and make cities safer (SDG 11). Which single policy would most likely support all three?$mq$, $mq$["Safe walking and cycling routes with improved public transport","Building more car-only roads","Removing public transport","Allowing more traffic in the centre"]$mq$, 0, $mq$Active travel and public transport cut emissions, improve air quality and fitness, and make streets safer.$mq$, $mq$hard$mq$),
($mq$A student argues: 'The SDGs are useless because they have not all been met yet.' Which reply is best?$mq$, $mq$["Goals should be deleted","If a goal is unmet, it was impossible","Indicators are not used","Progress can be measured against targets and indicators, and unmet goals show where more effort and funding are needed"]$mq$, 3, $mq$Goals are meant as a framework to drive action and track progress. Evaluating achievements and gaps is part of the process.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Sustainable Development Goals in Action$mq$ and p.name = $mq$Sustainability and Policy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$SDGs$mq$, $mq$17 Sustainable Development Goals adopted by UN member states in 2015, to be achieved by 2030, each with targets and indicators.$mq$),
($mq$Sustainable development$mq$, $mq$Meeting present needs without compromising future generations' ability to meet their own needs (Brundtland report, 1987).$mq$),
($mq$Three pillars of sustainability$mq$, $mq$Environmental, social and economic. Good solutions balance all three.$mq$),
($mq$SDG 6, 7 and 13$mq$, $mq$SDG 6: Clean Water and Sanitation. SDG 7: Affordable and Clean Energy. SDG 13: Climate Action.$mq$),
($mq$SDG 14, 15 and 12$mq$, $mq$SDG 14: Life Below Water. SDG 15: Life on Land. SDG 12: Responsible Consumption and Production.$mq$),
($mq$Synergy vs trade-off$mq$, $mq$Synergy: progress on one goal helps another. Trade-off: progress on one goal harms another (e.g. a dam gives energy but floods land).$mq$),
($mq$Indicator$mq$, $mq$A measurable value used to track progress on a target, e.g. percentage of people with access to electricity.$mq$),
($mq$Percentage point change$mq$, $mq$Difference between two percentages. Coverage from 50% to 75% is a rise of 25 percentage points.$mq$),
($mq$Why averages can mislead$mq$, $mq$They can hide inequality between regions or groups, so data should be broken down to show who is being left behind.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$environmental-systems$mq$ and t.grade = 5 and t.name = $mq$Sustainable Development Goals in Action$mq$ and p.name = $mq$Sustainability and Policy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$The **Sustainable Development Goals (SDGs)** are 17 global goals adopted by all United Nations member states in 2015 as part of the 2030 Agenda. They aim to end poverty, protect the planet and improve lives by 2030. Each goal has targets and indicators so progress can be measured.

## Sustainable development
Sustainable development means meeting the needs of the present without compromising the ability of future generations to meet their own needs. It balances three pillars:
- **Environmental**: protecting ecosystems, climate and natural resources.
- **Social**: health, education, fairness and community wellbeing.
- **Economic**: jobs, income and stable growth.

## Examples of SDGs
- SDG 1: No Poverty
- SDG 2: Zero Hunger
- SDG 3: Good Health and Wellbeing
- SDG 4: Quality Education
- SDG 6: Clean Water and Sanitation
- SDG 7: Affordable and Clean Energy
- SDG 11: Sustainable Cities and Communities
- SDG 12: Responsible Consumption and Production
- SDG 13: Climate Action
- SDG 14: Life Below Water
- SDG 15: Life on Land
- SDG 17: Partnerships for the Goals

You do not need to memorise all 17 in order, but you should recognise the environmental goals (6, 7, 11, 12, 13, 14, 15) and be able to link actions to goals.

## Goals in action
Projects usually support more than one goal. A solar water pump in a village supports clean water (SDG 6), clean energy (SDG 7), and education (SDG 4) if children spend less time fetching water. Planting mangroves supports climate action (13), life below water (14) and life on land (15) and protects communities from storms.

## Synergies and trade-offs
Some goals support each other (synergies), but others can conflict (trade-offs). Economic growth (SDG 8) may increase resource use and emissions. A hydroelectric dam may supply clean energy but flood farmland and displace communities. Good planning identifies trade-offs and looks for solutions that minimise harm.

## Measuring progress
Indicators are measurable values, such as the percentage of people with access to electricity, or tonnes of waste sent to landfill. Example: if waste to landfill falls from 240 000 t to 180 000 t, the reduction is 60 000 ÷ 240 000 × 100 = 25%. If clean water coverage rises from 50% to 75%, that is a rise of 25 percentage points. Be careful with averages. A national average can hide inequality between regions or groups, so disaggregated data are useful.

## Evaluating an SDG project
Ask:
- Which goals does it support, and which could it harm?
- Who benefits and who may lose?
- Is it affordable and long-lasting?
- Is there evidence and a way to monitor results?
- Are local people involved?

## Common mistakes
- Naming a goal without explaining the link to the action.
- Ignoring trade-offs. Almost every project has some.
- Using the same word for percentage and percentage points.
- Saying the goals are "met" based only on an average.

## How this is examined
Questions present a local project, such as a school garden, a solar scheme or a waste initiative, and ask which goals it supports, how success could be measured, and how to balance benefits and costs.

Exam tip: link each claim to a specific goal number and name, and then give one benefit and one limitation of the project.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('environmental-systems')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;