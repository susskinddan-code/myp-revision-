-- Part 8 of 12: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Human Body and Health > Circulation, Breathing and Gas Exchange
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Human Body and Health$mq$, 5, 8 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Circulation, Breathing and Gas Exchange$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Human Body and Health$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Circulation, Breathing and Gas Exchange$mq$ and p.name = $mq$Human Body and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which organ pumps blood around the body?$mq$, $mq$["The heart","The lungs","The liver","The kidney"]$mq$, 0, $mq$The heart is a muscular pump that keeps blood circulating.$mq$, $mq$easy$mq$),
($mq$What type of blood vessel carries blood away from the heart?$mq$, $mq$["Veins","Capillaries","Valves","Arteries"]$mq$, 3, $mq$Arteries carry blood away from the heart at high pressure and have thick, elastic walls.$mq$, $mq$easy$mq$),
($mq$Which part of the blood carries oxygen?$mq$, $mq$["White blood cells","Platelets","Red blood cells","Plasma only"]$mq$, 2, $mq$Red blood cells contain haemoglobin, which binds oxygen.$mq$, $mq$easy$mq$),
($mq$Where does gas exchange take place in the lungs?$mq$, $mq$["Bronchi","Alveoli","Trachea","Diaphragm"]$mq$, 1, $mq$Oxygen diffuses into the blood and carbon dioxide diffuses out across the walls of the alveoli.$mq$, $mq$easy$mq$),
($mq$What happens to the diaphragm when you breathe in?$mq$, $mq$["It contracts and flattens","It relaxes and moves up","It contracts and moves up","It stays still"]$mq$, 0, $mq$The diaphragm flattens and the ribs move up and out, increasing chest volume and decreasing pressure so air flows in.$mq$, $mq$easy$mq$),
($mq$Why is the human circulatory system called a double circulation?$mq$, $mq$["There are two hearts","Blood travels in two directions in each vessel","Arteries and veins are the same","Blood passes through the heart twice in one complete circuit of the body"]$mq$, 3, $mq$One loop goes from the heart to the lungs and back (pulmonary); the other goes round the body (systemic).$mq$, $mq$medium$mq$),
($mq$Why is the wall of the left ventricle thicker than that of the right ventricle?$mq$, $mq$["It pumps blood to the lungs only","It is closer to the lungs","It pumps blood at high pressure around the whole body","It holds more oxygen"]$mq$, 2, $mq$The right ventricle only pumps blood to the nearby lungs, so it needs less muscle.$mq$, $mq$medium$mq$),
($mq$Which feature of the alveoli helps gas exchange?$mq$, $mq$["Thick muscular walls","Thin walls one cell thick with a good blood supply","A dry inner surface","A small surface area"]$mq$, 1, $mq$A short diffusion distance and a steep concentration gradient maintained by blood flow make exchange rapid.$mq$, $mq$medium$mq$),
($mq$A person has a heart rate of 72 beats per minute and a stroke volume of 70 cm³. What is the cardiac output?$mq$, $mq$["5040 cm³ per minute","142 cm³ per minute","1.03 cm³ per minute","504 cm³ per minute"]$mq$, 0, $mq$Cardiac output = heart rate × stroke volume = 72 × 70 = 5040 cm³/min.$mq$, $mq$medium$mq$),
($mq$Why does breathing rate increase during exercise?$mq$, $mq$["The lungs get smaller","The body needs less oxygen","Blood becomes thicker","Muscles respire faster, needing more oxygen and producing more carbon dioxide"]$mq$, 3, $mq$The brain detects the rise in carbon dioxide and speeds up breathing to supply oxygen and remove CO₂.$mq$, $mq$medium$mq$),
($mq$Which blood component helps the blood to clot at a wound?$mq$, $mq$["Red blood cells","Plasma proteins only","Platelets","Lymphocytes"]$mq$, 2, $mq$Platelets are cell fragments that help form clots to seal cuts.$mq$, $mq$medium$mq$),
($mq$What is the function of valves in veins?$mq$, $mq$["To increase blood pressure","To prevent backflow of blood","To pump blood","To add oxygen"]$mq$, 1, $mq$Veins carry blood at low pressure back to the heart, so valves stop it flowing the wrong way.$mq$, $mq$medium$mq$),
($mq$Compare inhaled and exhaled air. Which row is correct?$mq$, $mq$["Exhaled air has less oxygen (about 16 %) and more carbon dioxide (about 4 %) than inhaled air","Exhaled air has more oxygen and less carbon dioxide","Exhaled air has no oxygen","Both have exactly the same composition"]$mq$, 0, $mq$Some oxygen is absorbed and carbon dioxide is added during gas exchange. Inhaled air has about 21 % oxygen and 0.04 % carbon dioxide.$mq$, $mq$medium$mq$),
($mq$Heart rate recovery after exercise: Person A returns to resting rate in 2 minutes; Person B takes 6 minutes. What is the best conclusion?$mq$, $mq$["Person B is fitter","They have the same fitness","Heart rate recovery does not relate to fitness","Person A is likely to be fitter, as their heart recovers faster"]$mq$, 3, $mq$A fitter person has a stronger heart and better circulation, so rate returns to normal sooner. More data would be needed to be certain.$mq$, $mq$hard$mq$),
($mq$At rest a person has a heart rate of 70 beats per minute and a stroke volume of 70 cm³. During exercise heart rate is 150 and stroke volume is 100 cm³. What is the cardiac output during exercise?$mq$, $mq$["10 500 cm³ per minute","250 cm³ per minute","15 000 cm³ per minute","4900 cm³ per minute"]$mq$, 2, $mq$150 × 100 = 15 000 cm³/min. At rest it was 70 × 70 = 4900 cm³/min, so output has gone up about three times.$mq$, $mq$hard$mq$),
($mq$Smoking damages the lungs and circulation. Which statement describes an effect accurately?$mq$, $mq$["Nicotine increases the lung surface area","Carbon monoxide binds to haemoglobin, reducing the oxygen carried, and tar damages cilia","Tar increases oxygen transport","Carbon monoxide helps blood clot to carry more oxygen"]$mq$, 1, $mq$Carbon monoxide binds to haemoglobin permanently, so less oxygen is carried. Tar paralyses cilia and causes mucus build-up.$mq$, $mq$hard$mq$),
($mq$Ventilation and blood flow both help gas exchange. Why?$mq$, $mq$["They keep the concentration gradients steep by bringing fresh oxygen and removing oxygen-rich blood","They raise the temperature of the lungs","They make the alveoli walls thicker","They stop diffusion happening"]$mq$, 0, $mq$Moving air in and out and moving blood past the alveoli means oxygen concentration stays high on one side and low on the other, so diffusion continues quickly.$mq$, $mq$hard$mq$),
($mq$A student measures breathing rate before and after exercise by counting breaths for 15 seconds with one volunteer. Which improvement best increases reliability?$mq$, $mq$["Count for 5 seconds only","Use only one trial","Change the exercise each time","Repeat with several volunteers and calculate the mean breaths per minute"]$mq$, 3, $mq$Several volunteers and repeated trials reduce the effect of individual differences and random error.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Circulation, Breathing and Gas Exchange$mq$ and p.name = $mq$Human Body and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Double circulation$mq$, $mq$Blood passes through the heart twice per circuit: heart → lungs → heart (pulmonary) and heart → body → heart (systemic).$mq$),
($mq$Arteries, veins and capillaries$mq$, $mq$Arteries: away from heart, thick walls. Veins: to heart, valves. Capillaries: thin walls for exchange.$mq$),
($mq$Cardiac output$mq$, $mq$Heart rate × stroke volume. E.g. 72 × 70 = 5040 cm³ per minute.$mq$),
($mq$Components of blood$mq$, $mq$Plasma (transport), red cells (oxygen), white cells (defence), platelets (clotting).$mq$),
($mq$How air is inhaled$mq$, $mq$Diaphragm contracts and flattens, ribs move up and out, chest volume increases, pressure falls, air flows in.$mq$),
($mq$Adaptations of alveoli$mq$, $mq$Large surface area, walls one cell thick, moist lining and a dense capillary network.$mq$),
($mq$Inhaled vs exhaled air$mq$, $mq$Inhaled: about 21 % O₂, 0.04 % CO₂. Exhaled: about 16 % O₂, 4 % CO₂.$mq$),
($mq$Why does breathing rate rise in exercise?$mq$, $mq$Muscles respire faster so more oxygen is needed and more carbon dioxide must be removed.$mq$),
($mq$Effects of smoking$mq$, $mq$Tar damages cilia and alveoli; carbon monoxide reduces oxygen carried by haemoglobin; nicotine is addictive.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Circulation, Breathing and Gas Exchange$mq$ and p.name = $mq$Human Body and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The circulatory system
The circulatory system transports oxygen, carbon dioxide, nutrients, hormones, waste and heat around the body. It is a **double circulation**: the pulmonary circuit takes blood from the heart to the lungs and back, and the systemic circuit takes blood from the heart around the body and back.

## The heart
The heart is a muscular pump with four chambers: two atria (collect blood) and two ventricles (pump blood out). The right side pumps deoxygenated blood to the lungs. The left side pumps oxygenated blood around the body, so the left ventricle wall is thicker. Valves prevent backflow. The heart muscle has its own blood supply through the coronary arteries. If they are blocked by fatty deposits, the muscle is starved of oxygen, causing a heart attack.
Cardiac output = heart rate × stroke volume. With 72 beats per minute and a stroke volume of 70 cm³, output = 5040 cm³ per minute.

## Blood vessels
- **Arteries**: carry blood away from the heart at high pressure. Thick, elastic walls.
- **Veins**: carry blood to the heart at low pressure. Thinner walls and valves.
- **Capillaries**: tiny, one cell thick walls, allow exchange of substances with tissues.

## Blood
- **Plasma**: liquid carrying dissolved substances such as glucose, urea and carbon dioxide.
- **Red blood cells**: carry oxygen as oxyhaemoglobin. They have no nucleus and are biconcave for a large surface area.
- **White blood cells**: defend against pathogens.
- **Platelets**: fragments that help clotting.

## Breathing and gas exchange
Breathing is ventilation, moving air in and out of the lungs. Breathing in: intercostal muscles contract, ribs move up and out, diaphragm contracts and flattens, chest volume rises, pressure falls and air flows in. Breathing out is the reverse. Air passes through the trachea, bronchi and bronchioles to the **alveoli**.
Alveoli are adapted for gas exchange: a large surface area, thin walls (one cell thick), moist lining, and a dense network of capillaries. Oxygen diffuses from the alveolus into the blood, and carbon dioxide diffuses out. Ventilation and blood flow keep the concentration gradients steep. Inhaled air is about 21 % oxygen and 0.04 % carbon dioxide; exhaled air is about 16 % oxygen and 4 % carbon dioxide.

## Exercise and health
During exercise muscles respire faster, so heart rate, stroke volume and breathing rate rise. A fitter person has a stronger heart and recovers sooner. Smoking harms health: tar damages cilia and alveoli, carbon monoxide reduces oxygen carried by haemoglobin, and nicotine is addictive and raises heart rate. A balanced diet and exercise reduce the risk of coronary heart disease.

## Common mistakes
- Saying that arteries always carry oxygenated blood. The pulmonary artery carries deoxygenated blood.
- Mixing up breathing with respiration.
- Saying that the lungs "suck" air. Air moves because the pressure in the chest falls.
- Saying red blood cells have a nucleus.

## How this is examined
Typical contexts include athletes' training, heart rate data, smoking statistics or an investigation into breathing rate after exercise. You may calculate cardiac output, interpret recovery data, justify improvements to a method (repeat with several people, use a mean) and discuss lifestyle risks and public health.

Exam tip: Use the phrases "short diffusion distance" and "steep concentration gradient" when explaining gas exchange, and state the direction of the gas movement.$mq$ from st;

-- Human Body and Health > Nervous System, Hormones and Homeostasis
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Human Body and Health$mq$, 5, 8 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Nervous System, Hormones and Homeostasis$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Human Body and Health$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Nervous System, Hormones and Homeostasis$mq$ and p.name = $mq$Human Body and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the correct sequence in a response to a stimulus?$mq$, $mq$["Stimulus → receptor → coordinator → effector → response","Stimulus → effector → coordinator → receptor → response","Receptor → stimulus → response → effector","Stimulus → coordinator → response → receptor"]$mq$, 0, $mq$Receptors detect the stimulus, the coordinator (such as the brain) processes it, and effectors carry out the response.$mq$, $mq$easy$mq$),
($mq$What do neurones carry?$mq$, $mq$["Hormones","Oxygen","Digested food","Electrical impulses"]$mq$, 3, $mq$Neurones transmit electrical signals around the body quickly.$mq$, $mq$easy$mq$),
($mq$What are hormones?$mq$, $mq$["Electrical signals in nerves","Enzymes in the gut","Chemical messengers carried in the blood","Types of white blood cell"]$mq$, 2, $mq$Hormones are secreted by glands and travel in the bloodstream to target organs.$mq$, $mq$easy$mq$),
($mq$Which hormone lowers blood glucose?$mq$, $mq$["Adrenaline","Insulin","Glucagon","Thyroxine"]$mq$, 1, $mq$Insulin, made by the pancreas, causes cells to take up glucose and the liver to store it as glycogen.$mq$, $mq$easy$mq$),
($mq$What is a reflex action?$mq$, $mq$["A fast automatic response that does not involve conscious thought","A slow conscious response","A hormone response","A learned skill"]$mq$, 0, $mq$Reflexes protect the body, for example pulling your hand away from something hot.$mq$, $mq$easy$mq$),
($mq$What is the order of neurones in a reflex arc?$mq$, $mq$["Motor → relay → sensory","Relay → sensory → motor","Sensory → motor → relay","Sensory → relay → motor"]$mq$, 3, $mq$The sensory neurone carries the impulse to the spinal cord, the relay neurone connects, and the motor neurone goes to the effector.$mq$, $mq$medium$mq$),
($mq$How is an impulse passed across a synapse?$mq$, $mq$["An electrical spark jumps across","Blood carries it","Chemicals diffuse across the gap and trigger a new impulse","It does not cross"]$mq$, 2, $mq$Neurotransmitters released by one neurone diffuse across the gap and bind to receptors on the next.$mq$, $mq$medium$mq$),
($mq$Which is an effect of adrenaline?$mq$, $mq$["Decreased heart rate","Increased heart rate and wider pupils","Narrower pupils","Reduced blood flow to muscles"]$mq$, 1, $mq$Adrenaline prepares the body for fight or flight.$mq$, $mq$medium$mq$),
($mq$The body is too hot. Which response helps to cool it?$mq$, $mq$["Sweating and vasodilation of skin blood vessels","Shivering","Vasoconstriction of skin blood vessels","Hairs standing up"]$mq$, 0, $mq$Sweat evaporates, taking heat away. Wider blood vessels near the skin lose more heat by radiation.$mq$, $mq$medium$mq$),
($mq$What causes type 1 diabetes?$mq$, $mq$["The body makes too much insulin","The person eats too much salt","Liver cells lack oxygen","The pancreas does not produce enough insulin"]$mq$, 3, $mq$Type 1 is treated with insulin injections and monitoring of diet.$mq$, $mq$medium$mq$),
($mq$What is negative feedback?$mq$, $mq$["A change causes more of the same change","A hormone that has no effect","A change is detected and a response reverses it to return to the normal level","A response that ignores the stimulus"]$mq$, 2, $mq$Homeostasis works by negative feedback, keeping conditions such as temperature and glucose stable.$mq$, $mq$medium$mq$),
($mq$Blood glucose rises after a meal and then falls back. Which explains the fall?$mq$, $mq$["The pancreas releases glucagon","The pancreas releases insulin, which lowers blood glucose","The brain releases adrenaline","Insulin is destroyed"]$mq$, 1, $mq$Insulin makes cells absorb glucose and the liver convert it to glycogen.$mq$, $mq$medium$mq$),
($mq$How do nervous and hormonal responses compare?$mq$, $mq$["Nervous responses are faster and shorter-lived; hormonal responses are slower and longer-lasting","Both are equally fast","Hormones are electrical impulses","Nervous responses use the blood to travel"]$mq$, 0, $mq$Nerve impulses travel in milliseconds along neurones. Hormones travel in blood and have effects that last longer.$mq$, $mq$medium$mq$),
($mq$In a ruler-drop test, a student catches a ruler after it falls 15 cm. Use t = √(2d ÷ g) with g = 9.8 m/s². What is the reaction time (2 significant figures)?$mq$, $mq$["0.31 s","0.03 s","1.53 s","0.17 s"]$mq$, 3, $mq$d = 0.15 m, so t = √(2 × 0.15 ÷ 9.8) = √0.0306 = 0.175 s, which is 0.17 s to 2 significant figures (0.17496 before rounding).$mq$, $mq$hard$mq$),
($mq$A student compares reaction times using the ruler-drop test with three trials each. Which change improves reliability most?$mq$, $mq$["Use a different hand each time","Use only the first trial","Use the same hand and the same drop height, and calculate the mean","Drop the ruler without warning only once"]$mq$, 2, $mq$Controlling variables and averaging repeated trials reduces random error.$mq$, $mq$hard$mq$),
($mq$In bright light, what happens to the pupil, and why?$mq$, $mq$["Radial muscles contract, making the pupil larger","Circular muscles contract, making the pupil smaller to protect the retina","The pupil does not change","The lens becomes thinner to protect the retina"]$mq$, 1, $mq$The iris reflex reduces the amount of light entering the eye.$mq$, $mq$hard$mq$),
($mq$The skin temperature falls on a cold day. Which sequence describes negative feedback?$mq$, $mq$["Receptors detect cold → brain triggers shivering and vasoconstriction → temperature returns to normal","Receptors detect cold → sweating → temperature falls more","Receptors detect heat → shivering","The brain does nothing until the body is frozen"]$mq$, 0, $mq$The response opposes the change. Shivering generates heat and vasoconstriction reduces heat loss.$mq$, $mq$hard$mq$),
($mq$A person with type 1 diabetes skips insulin and eats a high-carbohydrate meal. What is the most likely result?$mq$, $mq$["Blood glucose falls rapidly","The pancreas releases more insulin","The liver stops making glucose","Blood glucose stays high and glucose may appear in the urine"]$mq$, 3, $mq$Without insulin, glucose cannot be taken up by cells or stored, so blood glucose remains high.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Nervous System, Hormones and Homeostasis$mq$ and p.name = $mq$Human Body and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Pathway of a response$mq$, $mq$Stimulus → receptor → coordinator → effector → response.$mq$),
($mq$Three types of neurone$mq$, $mq$Sensory (to CNS), relay (within CNS), motor (from CNS to effector).$mq$),
($mq$What is a synapse?$mq$, $mq$A gap between two neurones. A neurotransmitter diffuses across it and triggers a new impulse.$mq$),
($mq$Reflex action$mq$, $mq$Fast, automatic, protective response not involving conscious thought, e.g. pulling away from a hot object.$mq$),
($mq$Nervous vs hormonal control$mq$, $mq$Nervous: fast, short-lived, electrical. Hormonal: slower, longer-lasting, carried in the blood.$mq$),
($mq$Function of insulin and glucagon$mq$, $mq$Insulin lowers blood glucose. Glucagon raises it. Both are made by the pancreas.$mq$),
($mq$Negative feedback$mq$, $mq$A change from the normal level is detected and a response reverses it, keeping conditions stable.$mq$),
($mq$Responses when too hot$mq$, $mq$Sweating, vasodilation (skin blood vessels widen), hairs lie flat.$mq$),
($mq$Responses when too cold$mq$, $mq$Shivering, vasoconstriction (skin blood vessels narrow), hairs stand up, less sweating.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Nervous System, Hormones and Homeostasis$mq$ and p.name = $mq$Human Body and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Coordination and response
Organisms detect changes (stimuli) and respond. The nervous system and the endocrine system both coordinate the body.
Sequence: **stimulus → receptor → coordinator → effector → response**. Receptors are sense cells (such as light receptors in the eye). Coordinators are the brain, spinal cord or pancreas. Effectors are muscles or glands.

## The nervous system
The central nervous system (CNS) is the brain and spinal cord. Nerves carry electrical impulses along neurones. Three types:
- **Sensory neurones**: receptor to CNS.
- **Relay neurones**: inside the CNS.
- **Motor neurones**: CNS to effector.
Neurones are separated by gaps called **synapses**. A chemical neurotransmitter diffuses across and triggers an impulse in the next neurone.
A **reflex** is fast, automatic and protective, such as pulling away from a hot object. It goes through the spinal cord without conscious thought, so it is quicker than a voluntary response.

## Measuring reaction time
In a ruler-drop test a partner releases a ruler and you catch it. The distance fallen gives the time: t = √(2d ÷ g). For d = 0.15 m, t ≈ 0.17 s. Improve reliability with repeated trials, same hand and the mean.

## Hormones
Hormones are chemical messengers made in endocrine glands and carried in the blood to target organs. Effects are slower than nervous responses but last longer.
- Adrenaline (adrenal glands): increases heart rate and widens pupils.
- Insulin (pancreas): lowers blood glucose.
- Glucagon (pancreas): raises blood glucose.

## Homeostasis
Homeostasis is the maintenance of a constant internal environment, by **negative feedback**: a change is detected and a response reverses it.
- **Temperature**: controlled by the brain. When hot: sweating and vasodilation. When cold: shivering and vasoconstriction.
- **Blood glucose**: after a meal glucose rises, insulin is secreted, cells absorb glucose and the liver stores glycogen. If glucose falls, glucagon causes glycogen to be converted back to glucose.
In type 1 diabetes the pancreas makes too little insulin, treated with insulin injections, monitoring and diet. Type 2 diabetes is linked to cells not responding well to insulin, and is associated with lifestyle factors.

## Common mistakes
- Saying hormones are carried by neurones.
- Mixing up vasodilation (wider vessels, more heat loss) and vasoconstriction.
- Saying that insulin raises blood glucose.
- Describing reflexes as conscious.

## How this is examined
Questions might present data from a reaction time investigation, a glucose graph for a person with or without diabetes, or a temperature control scenario. You are expected to put the sequence in order, explain negative feedback, compare nervous and hormonal control, and suggest improvements to practicals.

Exam tip: For homeostasis questions, name the stimulus, receptor, coordinator, effector and response, and say that the response reverses the change.$mq$ from st;

-- Human Body and Health > Disease, Immunity and Vaccination
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Human Body and Health$mq$, 5, 8 from public.subjects s where s.slug = $mq$integrated-science$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Disease, Immunity and Vaccination$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$integrated-science$mq$ and p.grade = 5 and p.name = $mq$Human Body and Health$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Disease, Immunity and Vaccination$mq$ and p.name = $mq$Human Body and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a pathogen?$mq$, $mq$["A microorganism that causes disease","A cell that fights disease","A drug that cures disease","A hormone"]$mq$, 0, $mq$Pathogens include bacteria, viruses, fungi and protists.$mq$, $mq$easy$mq$),
($mq$Why do antibiotics not work on viral infections?$mq$, $mq$["Viruses are too large","Antibiotics are too weak","Viruses are not alive so cannot be infected","Antibiotics kill bacteria, not viruses"]$mq$, 3, $mq$Viruses live inside host cells and are not affected by antibiotics. Vaccines help prevent viral diseases.$mq$, $mq$easy$mq$),
($mq$What does a vaccine usually contain?$mq$, $mq$["Live fully dangerous pathogens","Antibiotics","Weakened, dead or part of a pathogen","White blood cells"]$mq$, 2, $mq$These are antigens that trigger the immune response without causing the disease.$mq$, $mq$easy$mq$),
($mq$Which cells produce antibodies?$mq$, $mq$["Red blood cells","Lymphocytes","Platelets","Phagocytes"]$mq$, 1, $mq$Lymphocytes produce antibodies that lock on to specific antigens. Phagocytes engulf pathogens.$mq$, $mq$easy$mq$),
($mq$Which of these is a non-communicable disease?$mq$, $mq$["Coronary heart disease","Measles","Malaria","Influenza"]$mq$, 0, $mq$Non-communicable diseases cannot be passed from person to person.$mq$, $mq$easy$mq$),
($mq$Which is a way that pathogens can be spread?$mq$, $mq$["Eating a balanced diet","Exercise","Vaccination","Droplets from coughs and sneezes"]$mq$, 3, $mq$Other ways are contaminated food or water, direct contact and vectors such as mosquitoes.$mq$, $mq$medium$mq$),
($mq$Which is a physical or chemical barrier that protects the body from pathogens?$mq$, $mq$["White blood cells","Antibodies","Stomach acid","Memory cells"]$mq$, 2, $mq$Skin, mucus, cilia and stomach acid are first lines of defence. White blood cells and antibodies are part of the immune response.$mq$, $mq$medium$mq$),
($mq$What do phagocytes do?$mq$, $mq$["Make antibodies","Engulf and digest pathogens","Carry oxygen","Cause clotting"]$mq$, 1, $mq$Phagocytosis is a non-specific defence. Lymphocytes make specific antibodies.$mq$, $mq$medium$mq$),
($mq$Why is the second response to a pathogen faster and larger than the first?$mq$, $mq$["Memory cells quickly produce the right antibodies","Antibodies from the first infection remain forever","The pathogen is weaker","Platelets help"]$mq$, 0, $mq$After infection or vaccination, memory lymphocytes remain and respond quickly if the same antigen returns.$mq$, $mq$medium$mq$),
($mq$What is herd immunity?$mq$, $mq$["When everyone has the disease","When animals are vaccinated","When antibiotics are given","When enough people are immune that the spread of a disease is reduced, protecting those who are not immune"]$mq$, 3, $mq$If a high proportion of the population is vaccinated, pathogens find it difficult to spread.$mq$, $mq$medium$mq$),
($mq$How does antibiotic resistance develop?$mq$, $mq$["Bacteria choose to become resistant","The patient becomes resistant","Random mutation gives some bacteria resistance; these survive treatment and reproduce","Antibiotics change the bacteria's DNA on purpose"]$mq$, 2, $mq$Natural selection favours resistant bacteria when antibiotics are overused or not finished.$mq$, $mq$medium$mq$),
($mq$Town A has 95 % vaccination coverage and 3 measles cases. Town B has 60 % coverage and 180 cases. What is the best conclusion?$mq$, $mq$["Vaccination causes more cases","Higher vaccination coverage is associated with fewer cases","Coverage has no effect","Town B has better health care"]$mq$, 1, $mq$The data show a link, and herd immunity explains it, though other factors such as population size should be considered.$mq$, $mq$medium$mq$),
($mq$How can the spread of malaria be reduced?$mq$, $mq$["Control the mosquito vector, for example with bed nets and draining standing water","Wash hands before eating only","Take antibiotics","Avoid people who are coughing"]$mq$, 0, $mq$Malaria is caused by a protist spread by the Anopheles mosquito, so breaking the vector's life cycle helps.$mq$, $mq$medium$mq$),
($mq$Each person with a disease infects 4 others (R₀ = 4). The fraction that must be immune to stop spread is 1 − 1 ÷ R₀. What percentage is this?$mq$, $mq$["25 %","4 %","40 %","75 %"]$mq$, 3, $mq$1 − 1 ÷ 4 = 0.75, which is 75 %.$mq$, $mq$hard$mq$),
($mq$A trial tests a new vaccine. Which design feature best reduces bias?$mq$, $mq$["Giving everyone the vaccine","Only testing volunteers who want the vaccine","A double-blind trial with a placebo group","Telling everyone which group they are in"]$mq$, 2, $mq$In a double-blind trial neither participants nor researchers know who gets the vaccine, reducing bias. A placebo group gives a comparison.$mq$, $mq$hard$mq$),
($mq$A graph shows antibody concentration after a first vaccine dose and a booster. What does the booster typically show?$mq$, $mq$["A slower and lower rise","A faster and higher rise in antibodies","No change","A fall to zero"]$mq$, 1, $mq$Memory cells formed after the first dose respond quicker and produce more antibodies on the second exposure.$mq$, $mq$hard$mq$),
($mq$A patient with influenza asks for antibiotics. Which is the best evaluation?$mq$, $mq$["Antibiotics are ineffective because influenza is caused by a virus, and misuse promotes resistance","Antibiotics are the best treatment for viruses","Antibiotics will be effective if taken twice as long","Antibiotics only work for adults"]$mq$, 0, $mq$Influenza is viral. Antibiotics have no effect and overuse increases the spread of resistant bacteria.$mq$, $mq$hard$mq$),
($mq$A patient stops taking antibiotics after three days, when they feel better, even though the course is 7 days. Why is this a problem?$mq$, $mq$["Antibiotics only work for three days","Resistance develops in the patient","Stopping makes the antibiotic stronger","Surviving bacteria may be more resistant and can multiply"]$mq$, 3, $mq$The bacteria least affected by the antibiotic survive and can pass resistance on.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Disease, Immunity and Vaccination$mq$ and p.name = $mq$Human Body and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$What is a pathogen?$mq$, $mq$A microorganism (bacterium, virus, fungus or protist) that causes disease.$mq$),
($mq$Communicable vs non-communicable$mq$, $mq$Communicable diseases are passed on by pathogens. Non-communicable ones, such as coronary heart disease, are not.$mq$),
($mq$Body's first defences$mq$, $mq$Skin, mucus and cilia, and stomach acid.$mq$),
($mq$Phagocytes vs lymphocytes$mq$, $mq$Phagocytes engulf and digest pathogens. Lymphocytes make antibodies specific to antigens.$mq$),
($mq$How vaccination works$mq$, $mq$A harmless form of the antigen stimulates lymphocytes to make antibodies and memory cells for fast future protection.$mq$),
($mq$Why a booster dose?$mq$, $mq$Memory cells respond faster and make more antibodies on second exposure, giving stronger, longer protection.$mq$),
($mq$Herd immunity$mq$, $mq$When enough of a population is immune, spread is reduced and unvaccinated people are protected.$mq$),
($mq$Antibiotic resistance$mq$, $mq$Mutations make some bacteria resistant; they survive treatment and reproduce. Overuse and unfinished courses speed it up.$mq$),
($mq$Double-blind placebo trial$mq$, $mq$Neither participants nor researchers know who receives the real treatment; reduces bias.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$integrated-science$mq$ and t.grade = 5 and t.name = $mq$Disease, Immunity and Vaccination$mq$ and p.name = $mq$Human Body and Health$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Health and disease
Health is physical, mental and social well-being, not just the absence of disease. Diseases can be **communicable** (caused by pathogens and passed on) or **non-communicable** (such as coronary heart disease, cancer and type 2 diabetes).

## Pathogens
- **Bacteria**: cause cholera, tuberculosis and food poisoning. Treated with antibiotics.
- **Viruses**: cause influenza, measles and COVID-19. Reproduce inside host cells. Antibiotics do not work; vaccination helps prevent them.
- **Fungi**: cause athlete's foot.
- **Protists**: cause malaria, spread by the Anopheles mosquito (a vector).
Pathogens spread by droplets, direct contact, contaminated food and water, and vectors. Prevention includes handwashing, clean water, sanitation, vector control and vaccination.

## The body's defences
- **Barriers**: skin, mucus and cilia in the airways, and stomach acid.
- **Phagocytes** engulf and digest pathogens.
- **Lymphocytes** produce **antibodies** that fit specific **antigens** on the pathogen and lead to its destruction.
After an infection, memory lymphocytes stay in the body so a second infection triggers a faster, larger response.

## Vaccination
A vaccine contains a harmless form of the antigen (dead, weakened or a part of the pathogen). The body makes antibodies and memory cells without suffering the disease. If the real pathogen arrives later the response is fast. A booster dose gives a bigger response.
**Herd immunity** occurs when a large proportion is immune so the pathogen struggles to spread, protecting babies and people who cannot be vaccinated. For a disease where each case infects R₀ others, the proportion needing to be immune is about 1 − 1 ÷ R₀. If R₀ = 4 that is 75 %.
Benefits: diseases such as smallpox have been eradicated and others greatly reduced. Risks: rare side effects. Scientists weigh these by large trials.

## Antibiotics and resistance
Antibiotics kill bacteria but not viruses. Random mutation can make some bacteria resistant. If antibiotics are overused or the course is not finished, resistant bacteria survive and reproduce, giving a resistant population. This is natural selection. To slow resistance, doctors prescribe antibiotics only when needed and patients should finish the course.

## Testing new drugs and vaccines
Trials go through lab tests, animal tests where required, then human clinical trials. In a double-blind trial with a placebo group, neither participants nor researchers know who gets the real treatment, to reduce bias. A large sample size makes results more reliable.

## Common mistakes
- Saying antibiotics work on viruses.
- Saying vaccines give you the disease.
- Saying that individual bacteria become resistant. The population changes through selection.
- Mixing up antigens (on pathogens) and antibodies (made by lymphocytes).

## How this is examined
Typical tasks give vaccination data from towns or countries, antibody graphs, or a trial description. You are asked to describe patterns, explain using memory cells and herd immunity, evaluate a trial design, and discuss the impact of vaccines and antibiotic resistance on global health.

Exam tip: Say what the vaccine contains, what the body makes (antibodies and memory cells), and why the second response is faster. For data questions, quote figures from the stimulus.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('integrated-science')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;