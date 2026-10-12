-- Part 2 of 3: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Senses and Behaviour > Reflex Arcs and Behaviour
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Senses and Behaviour$mq$, 5, 2 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Reflex Arcs and Behaviour$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 5 and p.name = $mq$Senses and Behaviour$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Reflex Arcs and Behaviour$mq$ and p.name = $mq$Senses and Behaviour$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a reflex action?$mq$, $mq$["A fast, automatic response to a stimulus that does not involve conscious thought","A slow response that needs thinking","A response that only happens during sleep","A learned skill such as riding a bike"]$mq$, 0, $mq$Reflexes are quick, automatic and protective. They do not need the conscious part of the brain.$mq$, $mq$easy$mq$),
($mq$Which of these is an example of a reflex action?$mq$, $mq$["Choosing what to eat for lunch","Playing a piano piece","Writing a name","Blinking when something flies towards your eye"]$mq$, 3, $mq$Blinking is a quick protective reflex. The other actions are voluntary.$mq$, $mq$easy$mq$),
($mq$Which type of neurone carries impulses from a receptor to the central nervous system?$mq$, $mq$["Motor neurone","Relay neurone","Sensory neurone","Glial cell"]$mq$, 2, $mq$Sensory neurones carry impulses towards the CNS. Motor neurones carry impulses to effectors.$mq$, $mq$easy$mq$),
($mq$Which two organs make up the central nervous system (CNS)?$mq$, $mq$["Brain and heart","Brain and spinal cord","Spinal cord and muscles","Nerves and glands"]$mq$, 1, $mq$The CNS is made of the brain and spinal cord.$mq$, $mq$easy$mq$),
($mq$What is an effector?$mq$, $mq$["A muscle or gland that carries out a response","A cell that detects light","A nerve in the brain","A type of hormone"]$mq$, 0, $mq$Muscles contract and glands secrete in response to impulses. They are effectors.$mq$, $mq$easy$mq$),
($mq$Which sequence shows the correct order of a reflex arc?$mq$, $mq$["Stimulus → effector → relay neurone → receptor → response","Receptor → motor neurone → sensory neurone → effector","Stimulus → relay neurone → receptor → sensory neurone → response","Stimulus → receptor → sensory neurone → relay neurone → motor neurone → effector → response"]$mq$, 3, $mq$A reflex arc begins with the stimulus detected by a receptor and ends with an effector producing a response, with sensory, relay and motor neurones between.$mq$, $mq$medium$mq$),
($mq$Where is the relay neurone found in a spinal reflex?$mq$, $mq$["In the muscle","In the skin","In the spinal cord (CNS)","In the retina"]$mq$, 2, $mq$The relay neurone is within the CNS (spinal cord) and connects sensory to motor neurones.$mq$, $mq$medium$mq$),
($mq$A synapse is:$mq$, $mq$["A thick fatty layer around an axon","A tiny gap between two neurones where chemicals carry the signal across","A muscle that moves a limb","A part of the retina"]$mq$, 1, $mq$At a synapse the impulse is carried across the gap by neurotransmitter chemicals, which bind to receptors on the next neurone.$mq$, $mq$medium$mq$),
($mq$Why are reflex actions useful for survival?$mq$, $mq$["They are very fast, so they protect the body from harm","They allow detailed planning","They need no neurones","They only happen in adults"]$mq$, 0, $mq$By bypassing conscious thought the response is faster. This helps avoid injury, for example pulling a hand away from heat.$mq$, $mq$medium$mq$),
($mq$Which of the following correctly distinguishes a voluntary action from a reflex?$mq$, $mq$["A voluntary action does not use neurones","A reflex action always involves the brain's thinking areas","There is no difference","A voluntary action involves the conscious part of the brain and is slower"]$mq$, 3, $mq$Voluntary actions are decided by the brain. Reflexes pass through the spinal cord (or lower brain) without needing conscious decisions.$mq$, $mq$medium$mq$),
($mq$Why does the myelin sheath around some neurones speed up impulses?$mq$, $mq$["It adds more neurotransmitter","It makes the neurone shorter","It insulates the axon so impulses travel faster","It produces energy"]$mq$, 2, $mq$The fatty myelin sheath insulates the axon and allows the impulse to jump along it, increasing speed.$mq$, $mq$medium$mq$),
($mq$Pavlov-style conditioning: a dog hears a bell each time food arrives and eventually salivates at the bell alone. This is an example of:$mq$, $mq$["An inherited reflex only","A learned (conditioned) response","A random reaction","A hormone response only"]$mq$, 1, $mq$The dog has learned to link the bell with food. Salivating for food is a natural reflex, but salivating to a bell is learned.$mq$, $mq$medium$mq$),
($mq$A newborn baby grasps a finger placed in its palm. This type of behaviour is best described as:$mq$, $mq$["An innate (inborn) reflex","A learned behaviour","A conscious decision","A conditioned response"]$mq$, 0, $mq$Newborn babies show reflexes, such as grasping and sucking, which they did not need to learn.$mq$, $mq$medium$mq$),
($mq$Rashid touches a hot pan and his hand pulls away before he feels pain. Which explanation is best?$mq$, $mq$["The brain decides to move the hand before the stimulus","The muscle detects the heat","The relay neurone is in the hand","The reflex arc goes through the spinal cord, so the response happens before the brain processes the pain"]$mq$, 3, $mq$The signal passes via the spinal cord to the effector (muscle), producing a quick response. Impulses also travel to the brain afterwards, which is when pain is felt.$mq$, $mq$hard$mq$),
($mq$A drug blocks the receptors on the post-synaptic neurone at synapses. What is the most likely effect on a reflex?$mq$, $mq$["The reflex would be faster","No effect, because impulses can jump across the gap electrically","The reflex would be slowed or blocked because the signal cannot cross the synapse","The sensory neurone would become a motor neurone"]$mq$, 2, $mq$Neurotransmitters need receptors to start a new impulse. If receptors are blocked, transmission across the synapse fails.$mq$, $mq$hard$mq$),
($mq$In an experiment a student drops a ruler and a volunteer catches it. The ruler falls 12 cm in trial 1, 10 cm in trial 2 and 8 cm in trial 3 (same volunteer, practising). Which conclusion is best supported?$mq$, $mq$["Reaction time got worse","Reaction time improved with practice, which suggests catching is partly a learned, voluntary response","Catching a ruler is a true reflex, so practice has no effect","The ruler became lighter"]$mq$, 1, $mq$Shorter fall distance means faster reaction. Practice improved it, which a true reflex would not do. More trials and more volunteers would increase reliability.$mq$, $mq$hard$mq$),
($mq$Which statement best compares nervous and hormonal communication?$mq$, $mq$["Nervous responses are quick and short-lived; hormonal responses are slower and last longer","Nervous responses are slower and last longer","Both are identical in speed","Hormones travel along neurones"]$mq$, 0, $mq$Nerve impulses are electrical and fast. Hormones travel in the blood so effects are slower but often longer-lasting.$mq$, $mq$hard$mq$),
($mq$A scientist records that a person with spinal cord damage in the lower back can still jerk the knee when the tendon is tapped but cannot feel the tap. What does this suggest?$mq$, $mq$["The brain controls the knee jerk","The sensory neurone is missing","The knee has no receptors","The reflex arc is below the damage, but impulses cannot reach the brain to give a sensation"]$mq$, 3, $mq$A knee-jerk reflex arc is processed in the spinal cord. Damage higher up stops signals reaching the brain, so the person feels nothing even though the reflex still happens. This depends on where the damage is.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Reflex Arcs and Behaviour$mq$ and p.name = $mq$Senses and Behaviour$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Reflex action$mq$, $mq$A fast, automatic, protective response that does not involve conscious thought.$mq$),
($mq$Order of a reflex arc$mq$, $mq$Stimulus, receptor, sensory neurone, relay neurone, motor neurone, effector, response.$mq$),
($mq$Sensory vs motor neurone$mq$, $mq$Sensory carries impulses from receptors to the CNS. Motor carries impulses from the CNS to effectors.$mq$),
($mq$Central nervous system (CNS)$mq$, $mq$The brain and spinal cord.$mq$),
($mq$Effector$mq$, $mq$A muscle or gland that carries out a response.$mq$),
($mq$Synapse$mq$, $mq$Tiny gap between neurones. Neurotransmitters diffuse across and start a new impulse in the next neurone.$mq$),
($mq$Function of myelin sheath$mq$, $mq$Fatty layer that insulates an axon and speeds up the impulse.$mq$),
($mq$Innate vs learned behaviour$mq$, $mq$Innate: inborn (e.g. a baby's grasp reflex). Learned: gained through experience or conditioning.$mq$),
($mq$Nervous vs hormonal response$mq$, $mq$Nervous: fast, electrical, short-lived. Hormonal: slower, in the blood, longer-lasting.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Reflex Arcs and Behaviour$mq$ and p.name = $mq$Senses and Behaviour$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Behaviour is how an organism responds to its environment. Some behaviours are automatic and inborn, while others are learned. Understanding the nervous system pathway behind a reflex helps explain how organisms react quickly to danger.

## The nervous system
The **central nervous system (CNS)** is the brain and spinal cord. The **peripheral nervous system** is the nerves that connect the rest of the body to the CNS. Information travels as electrical impulses along neurones.
- **Sensory neurones** carry impulses from receptors to the CNS.
- **Relay neurones** are inside the CNS and connect sensory to motor neurones.
- **Motor neurones** carry impulses from the CNS to effectors.
Neurones can be covered in a fatty **myelin sheath** that insulates them and speeds up the impulse.

## Synapses
Neurones do not touch. At a **synapse** there is a tiny gap. The impulse in one neurone triggers the release of **neurotransmitter** chemicals, which diffuse across the gap and bind to receptors on the next neurone, starting a new impulse. Synapses make sure impulses travel in one direction only.

## The reflex arc
A **reflex** is a fast, automatic, protective response. The pathway is called the **reflex arc**:
- stimulus
- receptor
- sensory neurone
- relay neurone (in the spinal cord)
- motor neurone
- effector (muscle or gland)
- response.
Because the pathway is short and does not wait for the conscious brain, the response is very fast. Examples include pulling a hand from a hot object, blinking, the pupil reflex and the knee jerk. Impulses also go up to the brain, which is why you feel pain slightly after you pull away.

## Voluntary and learned behaviour
A **voluntary** response is decided by the brain and is slower. Behaviour can be **innate** (inborn, such as a baby's grasp reflex) or **learned**. In conditioning, an animal links a new stimulus to an old reflex, for example a dog that salivates at a bell after the bell has repeatedly been paired with food. Practice can also improve skills, such as catching a ball.

## Nervous vs hormonal control
Nervous responses use electrical impulses: fast and short-lived. Hormonal responses use chemicals in the blood: slower but longer-lasting.

## Common mistakes
- Writing that the brain is always part of a reflex arc. For many reflexes the spinal cord is the coordinator.
- Mixing the order of sensory and motor neurones.
- Saying neurones touch at a synapse. There is a gap.

## How this is examined
Typical items give a short scenario, such as a hand touching a hot object or a reaction time test using a dropped ruler, and ask you to order the arc, explain why it is fast, interpret results, or evaluate the reliability of an investigation (repeat trials, same conditions, several volunteers).

Exam tip: In reflex arc questions, write the full pathway in order and name each neurone type, then state why this makes the response quick.$mq$ from st;

-- Interactions Between Organisms > Predator-Prey Relationships and Competition
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Interactions Between Organisms$mq$, 5, 3 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Predator-Prey Relationships and Competition$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 5 and p.name = $mq$Interactions Between Organisms$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Predator-Prey Relationships and Competition$mq$ and p.name = $mq$Interactions Between Organisms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a predator?$mq$, $mq$["An animal that hunts and kills other animals for food","A plant that makes its own food","An organism that lives on a host without killing it","An organism that breaks down dead material"]$mq$, 0, $mq$A predator hunts and eats other animals (its prey). Plants are producers and decomposers break down dead matter.$mq$, $mq$easy$mq$),
($mq$Which of these is a resource that plants compete for?$mq$, $mq$["Mates","Prey","Territory","Light"]$mq$, 3, $mq$Plants compete for light, water, space and mineral ions. Animals compete for food, mates and territory.$mq$, $mq$easy$mq$),
($mq$Which term describes organisms of the SAME species competing with each other?$mq$, $mq$["Interspecific competition","Mutualism","Intraspecific competition","Parasitism"]$mq$, 2, $mq$Intra- means within, so intraspecific competition is within one species. Inter- means between species.$mq$, $mq$easy$mq$),
($mq$In a food chain grass → rabbit → fox, which organism is the prey of the fox?$mq$, $mq$["Grass","Rabbit","Fox","None of them"]$mq$, 1, $mq$The rabbit is eaten by the fox, so it is the fox's prey. The rabbit is also a predator of grass, but grass is a plant, not prey in this sense.$mq$, $mq$easy$mq$),
($mq$Which adaptation helps a predator catch prey?$mq$, $mq$["Sharp claws and forward-facing eyes","Thick spines only","Warning colours to show it tastes bad","Waxy leaves"]$mq$, 0, $mq$Sharp claws, strong jaws, speed and forward-facing eyes (good depth perception) help predators catch prey.$mq$, $mq$easy$mq$),
($mq$A graph shows the number of lynx rising a little after the number of snowshoe hares rises. What is the best explanation?$mq$, $mq$["Lynx eat the hares' food","Lynx and hares compete for the same food","Hares eat lynx","More hares means more food for lynx, so the lynx population increases afterwards"]$mq$, 3, $mq$Predator numbers follow prey numbers with a time delay because more food allows more lynx to survive and reproduce.$mq$, $mq$medium$mq$),
($mq$Which statement describes a typical predator-prey population cycle?$mq$, $mq$["Predator numbers always stay constant","Prey and predator numbers rise and fall at exactly the same time","Prey numbers rise, predator numbers rise, prey numbers fall, predator numbers fall","Prey numbers always continue to rise"]$mq$, 2, $mq$The predator numbers follow the prey numbers, with a lag. When predators become too numerous, prey decline, so predator numbers then fall.$mq$, $mq$medium$mq$),
($mq$Two species of squirrel live in the same wood and eat the same seeds. When seeds become scarce, what is the most likely outcome?$mq$, $mq$["Intraspecific competition only","Interspecific competition increases","Both species become mutualists","Both species become parasites"]$mq$, 1, $mq$Different species competing for the same limited resource is interspecific competition.$mq$, $mq$medium$mq$),
($mq$Which pair is correctly matched as an anti-predator adaptation?$mq$, $mq$["Camouflage: the prey blends into the background","Sharp teeth: the prey hides","Bright warning colour: the prey is invisible","Binocular vision: the prey is hidden"]$mq$, 0, $mq$Camouflage helps the prey avoid being seen. Bright warning colours (aposematism) advertise that an animal is poisonous or unpleasant, which also deters predators.$mq$, $mq$medium$mq$),
($mq$Why do predators usually not wipe out all of their prey?$mq$, $mq$["Predators only eat dead animals","Predators stop needing food","Prey cannot be caught","If prey became rare, predator numbers would fall due to starvation, letting prey recover"]$mq$, 3, $mq$Predator and prey populations regulate one another through negative feedback.$mq$, $mq$medium$mq$),
($mq$A farmer introduces a ladybird that eats aphids. Why might this be better than spraying insecticide?$mq$, $mq$["Ladybirds never eat anything","Insecticides are always cheaper and have no effects on other species","Biological control targets the pest and avoids chemical residues","Ladybirds also eat the crop"]$mq$, 2, $mq$Biological control uses a natural predator and avoids harmful chemical build-up. However it must be checked that the introduced species does not become a pest.$mq$, $mq$medium$mq$),
($mq$A student studies a woodland and finds oak seedlings growing poorly beneath a dense canopy. What is the main factor limiting their growth?$mq$, $mq$["Competition for mates","Competition for light","Predation by lions","Lack of oxygen in the air"]$mq$, 1, $mq$Dense canopy blocks light. Seedlings compete with larger trees for light as well as water and minerals.$mq$, $mq$medium$mq$),
($mq$In a lake, the number of small fish falls sharply after a large pike population increases. Later the pike numbers also fall. Which description is correct?$mq$, $mq$["Predation reduced prey numbers, then food shortage reduced predator numbers","Pike became mutualists with small fish","Small fish ate the pike","The pike migrated for no reason"]$mq$, 0, $mq$More pike ate more small fish. When prey became scarce, pike lacked food and numbers fell.$mq$, $mq$medium$mq$),
($mq$Hare numbers in a park: year 1: 400, year 2: 640, year 3: 900, year 4: 520. Lynx numbers: year 1: 30, year 2: 40, year 3: 70, year 4: 100. What is the best interpretation?$mq$, $mq$["Lynx numbers fell as hare numbers fell","Hares and lynx are not related","Hares are eating lynx","Lynx numbers kept rising after hare numbers peaked, so lynx are likely to reduce hare numbers further"]$mq$, 3, $mq$Hares peaked in year 3 and dropped in year 4, while lynx continued to rise because of the time lag. The pattern suggests predation is reducing hare numbers.$mq$, $mq$hard$mq$),
($mq$Why might a graph of predator and prey numbers not show a perfect cycle in real ecosystems?$mq$, $mq$["Predators and prey do not interact","Predators never die","Other factors such as disease, weather, other food sources and migration also affect numbers","Real populations are always stable"]$mq$, 2, $mq$Real communities have many interacting species and abiotic factors, so cycles are rarely smooth.$mq$, $mq$hard$mq$),
($mq$Two species of barnacle grow on a rocky shore. Species X lives on the upper rock, species Y lower down. When Y is removed experimentally, X spreads lower. What does this suggest?$mq$, $mq$["X is a predator of Y","Y was out-competing X on the lower shore, restricting its range","Y is a parasite of X","The two are mutualists"]$mq$, 1, $mq$When the competitor is removed X expands into a place it can survive. This indicates interspecific competition was limiting its range.$mq$, $mq$hard$mq$),
($mq$Wolves are reintroduced to a park. Elk numbers decrease, and willow trees along rivers begin to recover. Which explanation links these changes?$mq$, $mq$["Fewer elk are browsing willows, so the willows can grow","Wolves eat willows","Wolves plant willow seeds","Willows are eaten by wolves instead of elk"]$mq$, 0, $mq$A top predator can change the behaviour and numbers of herbivores, which affects vegetation. This is a knock-on effect through the food web.$mq$, $mq$hard$mq$),
($mq$A student argues 'Competition is always harmful to all organisms involved'. Which response evaluates this best?$mq$, $mq$["Completely true because competing organisms always die","False because competition never happens in nature","True only for plants","Partly true because competition reduces resources, but it can drive adaptation and keep populations in balance"]$mq$, 3, $mq$Competition limits individuals' success but can cause natural selection of better-adapted individuals and helps regulate population sizes.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Predator-Prey Relationships and Competition$mq$ and p.name = $mq$Interactions Between Organisms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Predator and prey$mq$, $mq$A predator hunts and eats other animals. The animal that is eaten is the prey.$mq$),
($mq$Intraspecific competition$mq$, $mq$Competition between members of the same species for the same resources.$mq$),
($mq$Interspecific competition$mq$, $mq$Competition between members of different species for the same resources.$mq$),
($mq$Resources plants compete for$mq$, $mq$Light, water, space and mineral ions.$mq$),
($mq$Resources animals compete for$mq$, $mq$Food, water, shelter, mates and territory.$mq$),
($mq$Why does the predator curve lag behind the prey curve?$mq$, $mq$It takes time for extra food to let predators reproduce, so predator numbers rise and fall after prey numbers.$mq$),
($mq$Camouflage$mq$, $mq$Colouring or pattern that helps an organism blend into its surroundings to avoid predators (or ambush prey).$mq$),
($mq$Biological control$mq$, $mq$Using a natural predator or parasite to control a pest instead of chemicals. Must be checked for effects on other species.$mq$),
($mq$Predator adaptations$mq$, $mq$Sharp teeth and claws, speed, forward-facing eyes (depth perception), strong senses.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Predator-Prey Relationships and Competition$mq$ and p.name = $mq$Interactions Between Organisms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Organisms in an ecosystem interact in many ways. Two of the most important are predation and competition. These interactions help control population sizes and shape the traits of organisms over time.

## Predators and prey
A **predator** hunts, kills and eats other animals. The animal that is eaten is the **prey**. For example, in the food chain grass → rabbit → fox, the rabbit is the prey of the fox.

### Adaptations of predators
- sharp teeth and claws
- speed, stealth and strength
- forward-facing eyes for depth perception
- good senses of smell or hearing.

### Adaptations of prey
- camouflage to avoid being seen
- speed or the ability to hide
- eyes on the sides of the head for a wide field of view
- spines, poison or warning colours.

## Predator-prey cycles
Predator and prey numbers often rise and fall in linked cycles.
- Prey numbers rise when there is plenty of food.
- More prey means more food for predators, so predator numbers rise a little later.
- More predators eat more prey, so prey numbers fall.
- Less prey means predators starve, so predator numbers fall.
- The cycle starts again.
On a graph, the predator curve is usually **delayed** compared with the prey curve and has a smaller peak. In real ecosystems cycles are not perfect because disease, weather and alternative food also affect numbers.

## Competition
**Competition** happens when organisms need the same limited resource.
- Plants compete for light, water, space and mineral ions.
- Animals compete for food, water, shelter, mates and territory.
- **Intraspecific** competition is between members of the same species.
- **Interspecific** competition is between members of different species.
Competition limits population size. The better-adapted organisms are more likely to survive and reproduce, which is a key idea in natural selection.

## Human uses and effects
Farmers sometimes use predators as **biological control**, for example ladybirds to eat aphids. This avoids chemical pesticides but introduced species must be checked carefully, because they may harm other native species. Changes in predator numbers can affect the whole food web, for example when top predators are removed or reintroduced.

## Worked example
Data: hares peak at 900 in year 3, while lynx peak at 100 in year 4. The lynx peak comes later because it takes time for food to become plentiful and for lynx to reproduce.

## Common mistakes
- Writing 'predators control prey' without explaining the feedback loop.
- Mixing up intraspecific and interspecific competition.
- Saying the predator curve is the same as the prey curve. It is delayed.
- Forgetting that interactions are limited by other factors too.

## How this is examined
Questions usually include a graph or data described in words showing two populations, and ask you to explain the pattern, predict what happens if one population is removed, or evaluate biological control as a solution. Extended answers need cause and effect in order.

Exam tip: In cycle questions, name which population changes first, state the cause, then describe the effect on the other population, using words like 'because' and 'therefore'.$mq$ from st;

-- Interactions Between Organisms > Parasitism, Mutualism and Symbiosis
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Interactions Between Organisms$mq$, 5, 3 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Parasitism, Mutualism and Symbiosis$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 5 and p.name = $mq$Interactions Between Organisms$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Parasitism, Mutualism and Symbiosis$mq$ and p.name = $mq$Interactions Between Organisms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In a parasitic relationship, what is true?$mq$, $mq$["The parasite benefits and the host is harmed","Both organisms benefit","Neither organism is affected","The host benefits and the parasite is harmed"]$mq$, 0, $mq$A parasite lives on or in a host and gains nutrients at the host's expense.$mq$, $mq$easy$mq$),
($mq$Which of the following is an example of a parasite?$mq$, $mq$["Oak tree","Rabbit","Earthworm","Tapeworm"]$mq$, 3, $mq$A tapeworm lives in the gut of a host and absorbs digested food. Oak trees, rabbits and earthworms are not parasites.$mq$, $mq$easy$mq$),
($mq$What term describes a relationship in which both organisms benefit?$mq$, $mq$["Parasitism","Predation","Mutualism","Competition"]$mq$, 2, $mq$In mutualism, both partners gain from the relationship.$mq$, $mq$easy$mq$),
($mq$Fleas feed on the blood of dogs. What is the dog called in this relationship?$mq$, $mq$["Predator","Host","Producer","Decomposer"]$mq$, 1, $mq$The organism that the parasite lives on or in is called the host.$mq$, $mq$easy$mq$),
($mq$Which of these is the correct meaning of symbiosis?$mq$, $mq$["Two different species living in close association","Two members of the same species competing","An animal eating a plant","Death of an organism"]$mq$, 0, $mq$Symbiosis means a close, long-term relationship between two different species. It includes mutualism and parasitism.$mq$, $mq$easy$mq$),
($mq$Clownfish live among the stinging tentacles of sea anemones. The anemone's tentacles protect the clownfish, and the clownfish chase away fish that eat anemones. What type of relationship is this?$mq$, $mq$["Parasitism","Predation","Interspecific competition","Mutualism"]$mq$, 3, $mq$Both species benefit: the clownfish get protection, and the anemone gets protection from enemies.$mq$, $mq$medium$mq$),
($mq$Bacteria in the root nodules of legumes (peas, beans) convert nitrogen from the air into compounds the plant can use. In return the plant provides sugars. Why is this mutualism?$mq$, $mq$["Only the plant benefits","Only the bacteria benefit","Both the bacteria and the plant benefit","The plant is harmed"]$mq$, 2, $mq$The plant gains usable nitrogen compounds and the bacteria gain a home and food, so both benefit.$mq$, $mq$medium$mq$),
($mq$Head lice live on human hair and feed on blood. They are best described as:$mq$, $mq$["Endoparasites","Ectoparasites","Mutualists","Predators"]$mq$, 1, $mq$Ectoparasites live on the outside of the host. Endoparasites live inside, like tapeworms.$mq$, $mq$medium$mq$),
($mq$Why is it usually not in a parasite's interest to kill its host quickly?$mq$, $mq$["The parasite depends on the host for food and a home","The parasite does not need nutrients","The host is a predator","Parasites cannot harm hosts"]$mq$, 0, $mq$If the host dies quickly, the parasite loses its supply of nutrients and its habitat.$mq$, $mq$medium$mq$),
($mq$Lichens are made of a fungus and an alga living together. The alga photosynthesises, and the fungus provides protection and absorbs water and minerals. This is an example of:$mq$, $mq$["Parasitism","Predation","Competition","Mutualism"]$mq$, 3, $mq$Both organisms gain: the alga gets protection and water, and the fungus gets sugars from photosynthesis.$mq$, $mq$medium$mq$),
($mq$Which statement correctly distinguishes a predator from a parasite?$mq$, $mq$["A parasite always kills its host quickly","A predator always lives inside its prey","A predator usually kills its prey quickly; a parasite usually lives on or in its host for a long time","There is no difference"]$mq$, 2, $mq$Predators capture and kill prey; parasites typically stay with a living host for an extended period.$mq$, $mq$medium$mq$),
($mq$Humans have bacteria living in their large intestine that help digest fibre and make some vitamins. We provide a warm home and food. This is best described as:$mq$, $mq$["Parasitism","Mutualism","Predation","Competition"]$mq$, 1, $mq$Both humans and gut bacteria benefit. Not all gut microbes are helpful, but these are.$mq$, $mq$medium$mq$),
($mq$The mosquito that carries the malaria parasite feeds on human blood. Which statement is correct?$mq$, $mq$["The mosquito is a vector that transfers the parasite between hosts","The mosquito is a mutualist of humans","Humans are the predator","The mosquito is a producer"]$mq$, 0, $mq$A vector carries a pathogen or parasite from one host to another. The malaria parasite is Plasmodium; the mosquito (Anopheles) is the vector.$mq$, $mq$medium$mq$),
($mq$A researcher removes the mycorrhizal fungi (fungi living on tree roots) from soil. The tree seedlings grow more slowly and absorb less phosphate. What does this suggest?$mq$, $mq$["The fungi are predators of the trees","The trees do not need minerals","The fungi are parasites that help growth","The fungi help the trees absorb minerals, suggesting a mutualistic relationship"]$mq$, 3, $mq$The fungi increase the surface area for absorbing minerals, and the trees supply sugars. When the fungi are removed, growth suffers.$mq$, $mq$hard$mq$),
($mq$Cuckoos lay eggs in other birds' nests. The host birds raise the cuckoo chick, which often pushes out the host's own eggs. The cuckoo is best described as a:$mq$, $mq$["Mutualist","Decomposer","Brood parasite","Producer"]$mq$, 2, $mq$The cuckoo gains free parental care while the host loses its own offspring, which matches parasitism.$mq$, $mq$hard$mq$),
($mq$A scientist compares the growth of coral with and without algae living in its tissue. Coral with algae grows 4.0 mm per month and coral without algae grows 1.5 mm per month. What is the best interpretation?$mq$, $mq$["Algae harm the coral","Algae help coral grow faster, supporting a mutualistic relationship","There is no relationship","Coral eats algae in a predator-prey relationship"]$mq$, 1, $mq$The coral with algae grew faster. The algae photosynthesise and provide sugars; the coral gives shelter and nutrients, so both benefit. More repeats would raise reliability.$mq$, $mq$hard$mq$),
($mq$A rising sea temperature causes coral to expel the algae living inside it. Which is the most likely consequence?$mq$, $mq$["The coral loses a major food source and turns white (bleaching)","The coral grows faster","The algae become predators","The coral becomes a parasite"]$mq$, 0, $mq$Without algae the coral loses sugars and its colour, which can cause the coral to die if conditions persist.$mq$, $mq$hard$mq$),
($mq$A student says 'symbiosis always means both organisms benefit'. Which response is best?$mq$, $mq$["Correct; symbiosis only includes mutualism","Incorrect; symbiosis describes competition within a species","Correct; parasites are not symbiotic","Incorrect; symbiosis is any close relationship between two species, including parasitism where one is harmed"]$mq$, 3, $mq$Symbiosis covers a close, long-term association between different species. Mutualism and parasitism are both types, and some definitions also include commensalism.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Parasitism, Mutualism and Symbiosis$mq$ and p.name = $mq$Interactions Between Organisms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Symbiosis$mq$, $mq$A close, long-term relationship between two different species. Includes mutualism and parasitism.$mq$),
($mq$Parasitism$mq$, $mq$Relationship where the parasite benefits and the host is harmed.$mq$),
($mq$Mutualism$mq$, $mq$Relationship where both species benefit.$mq$),
($mq$Ectoparasite vs endoparasite$mq$, $mq$Ectoparasites live on the outside of a host (fleas, lice). Endoparasites live inside (tapeworm, malaria parasite).$mq$),
($mq$Vector$mq$, $mq$An organism that carries a parasite or pathogen from one host to another, e.g. the Anopheles mosquito and malaria.$mq$),
($mq$Legume root nodule mutualism$mq$, $mq$Bacteria fix nitrogen into usable compounds for the plant; the plant gives sugars and a home to the bacteria.$mq$),
($mq$Coral bleaching$mq$, $mq$Warm water makes coral expel its algae, so it loses colour and food supply and may die.$mq$),
($mq$Brood parasite example$mq$, $mq$The cuckoo lays eggs in other birds' nests; the host raises the cuckoo chick, often at the cost of its own.$mq$),
($mq$Why do parasites rarely kill their hosts quickly?$mq$, $mq$They depend on the host for food and shelter, so killing it would remove their supply.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 5 and t.name = $mq$Parasitism, Mutualism and Symbiosis$mq$ and p.name = $mq$Interactions Between Organisms$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Not every relationship between organisms is about eating or fighting. Many species live in close, long-term association. This is called **symbiosis**. It includes parasitism, mutualism and (in some definitions) commensalism, where one organism benefits and the other is unaffected.

## Parasitism
A **parasite** lives on or in another organism, called the **host**, and gains food or shelter at the host's expense.
- The parasite benefits, and the host is harmed.
- **Ectoparasites** live on the outside (fleas, head lice, ticks).
- **Endoparasites** live inside the host (tapeworms, the malaria parasite).
- Parasites are usually smaller than their host and rarely kill it quickly, because they depend on it.
Some parasites need a **vector** to move between hosts. The female Anopheles mosquito carries the malaria parasite (Plasmodium) from person to person. The cuckoo is a brood parasite because it lays eggs in other birds' nests and the host raises its chick.

## Mutualism
In **mutualism**, both species benefit. Examples:
- **Legumes and nitrogen-fixing bacteria:** bacteria in root nodules turn nitrogen from the air into compounds the plant can use; the plant gives sugars and a home.
- **Mycorrhizal fungi and tree roots:** fungi increase the surface area for absorbing water and minerals; the tree provides sugars.
- **Coral and algae:** algae photosynthesise and give sugars; coral provides shelter and nutrients. If the water gets too warm, coral expels the algae and becomes white (bleached).
- **Lichens:** an alga and a fungus living together.
- **Gut bacteria in humans:** help digest fibre and make some vitamins.
- **Clownfish and anemones:** protection for both.

## Comparing relationships
- **Predation:** one organism kills and eats another.
- **Competition:** both organisms are harmed because resources are limited.
- **Parasitism:** parasite benefits and host is harmed.
- **Mutualism:** both benefit.

## Worked example
Coral with algae grows at 4.0 mm per month and coral without algae grows at 1.5 mm per month. The algae help growth by 2.5 mm per month, so the relationship benefits the coral. To say it is mutualism, you also need evidence that the algae benefit, such as shelter and nutrients.

## Common mistakes
- Treating symbiosis as meaning only 'both benefit'.
- Saying a parasite 'eats' its host. It feeds on or from it while the host is usually still alive.
- Missing the idea that the parasite depends on the host.
- Concluding from one data set that a relationship is mutualistic without checking both partners.

## How this is examined
Questions give a short scenario about two species and ask you to classify the relationship and justify it. Data questions compare organisms with and without a partner. Extended items ask about the effects of environmental change (for example coral bleaching) or the control of a parasitic disease.

Exam tip: To classify a relationship, say who benefits and who is harmed for each organism, in two short statements, before naming the type.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('biology')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;