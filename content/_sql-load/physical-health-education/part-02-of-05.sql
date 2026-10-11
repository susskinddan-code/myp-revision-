-- Part 2 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Body Systems > Muscular and Skeletal Systems
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Body Systems$mq$, 5, 2 from public.subjects s where s.slug = $mq$physical-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Muscular and Skeletal Systems$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-health-education$mq$ and p.grade = 5 and p.name = $mq$Body Systems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Muscular and Skeletal Systems$mq$ and p.name = $mq$Body Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which tissue connects a muscle to a bone?$mq$, $mq$["Tendon","Ligament","Cartilage","Skin"]$mq$, 0, $mq$Tendons attach muscle to bone. Ligaments connect bone to bone.$mq$, $mq$easy$mq$),
($mq$Which joint type allows the greatest range of movement, as found in the shoulder and hip?$mq$, $mq$["Hinge","Fixed","Pivot","Ball and socket"]$mq$, 3, $mq$Ball and socket joints allow movement in many directions, including rotation.$mq$, $mq$easy$mq$),
($mq$Which of these is a function of the skeleton?$mq$, $mq$["Digesting food","Pumping blood","Protecting organs such as the brain","Producing hormones for digestion"]$mq$, 2, $mq$The skeleton supports the body, protects organs (skull protects the brain), allows movement, makes blood cells and stores minerals.$mq$, $mq$easy$mq$),
($mq$The elbow and the knee are examples of which type of joint?$mq$, $mq$["Ball and socket","Hinge","Pivot","Gliding"]$mq$, 1, $mq$Hinge joints move mainly in one plane, bending and straightening like a door.$mq$, $mq$easy$mq$),
($mq$When you bend your arm at the elbow, which muscle contracts as the prime mover?$mq$, $mq$["Biceps","Triceps","Quadriceps","Hamstrings"]$mq$, 0, $mq$The biceps contracts to flex the elbow while the triceps relaxes.$mq$, $mq$easy$mq$),
($mq$In an antagonistic pair, what happens when the biceps contracts to bend the arm?$mq$, $mq$["The triceps also contracts fully","The bone shortens","The tendon relaxes and the muscle pushes","The triceps relaxes (lengthens)"]$mq$, 3, $mq$Muscles can only pull. In a pair, one contracts while the other relaxes, and the roles swap for the return movement.$mq$, $mq$medium$mq$),
($mq$Which pair is correctly matched as antagonistic muscles in the upper leg?$mq$, $mq$["Biceps and quadriceps","Triceps and hamstrings","Quadriceps and hamstrings","Deltoid and calf"]$mq$, 2, $mq$The quadriceps (front of thigh) extend the knee and the hamstrings (back of thigh) flex it.$mq$, $mq$medium$mq$),
($mq$Where are red blood cells made?$mq$, $mq$["Cartilage","Bone marrow","Ligaments","Tendons"]$mq$, 1, $mq$Red blood cells are produced in the bone marrow of certain bones.$mq$, $mq$medium$mq$),
($mq$What is the job of cartilage at the ends of bones in a joint?$mq$, $mq$["Cushion and reduce friction","Produce blood","Join muscle to bone","Make the bone longer permanently"]$mq$, 0, $mq$Smooth cartilage reduces friction and acts as a shock absorber at joints.$mq$, $mq$medium$mq$),
($mq$A swimmer lifts her arm out sideways away from her body. What is this movement called?$mq$, $mq$["Adduction","Flexion","Extension","Abduction"]$mq$, 3, $mq$Abduction is movement away from the midline of the body. Adduction is movement toward it.$mq$, $mq$medium$mq$),
($mq$Which type of muscle is under voluntary control and attached to bones?$mq$, $mq$["Cardiac muscle","Smooth muscle","Skeletal muscle","Blood muscle"]$mq$, 2, $mq$Skeletal muscle is voluntary and moves the skeleton. Cardiac and smooth muscle work involuntarily.$mq$, $mq$medium$mq$),
($mq$During a plank, the abdominal muscles hold tension but the body does not move. What type of muscle contraction is this?$mq$, $mq$["Isotonic","Isometric","Elastic","Reflex"]$mq$, 1, $mq$In an isometric contraction the muscle produces tension without changing length, as in holding a plank. An isotonic contraction changes length, as in a press-up.$mq$, $mq$medium$mq$),
($mq$A footballer kicks a ball. The knee changes from bent to straight. What is the movement and which muscle group is the prime mover?$mq$, $mq$["Extension; quadriceps","Flexion; quadriceps","Extension; hamstrings","Flexion; hamstrings"]$mq$, 0, $mq$Straightening is extension, and the quadriceps contract to straighten the knee.$mq$, $mq$medium$mq$),
($mq$Why do athletes include weight-bearing exercise such as running and jumping in their training for bone health?$mq$, $mq$["Exercise makes bones shrink","Bones only need rest","Weight-bearing makes cartilage disappear","Bones adapt to stress and become denser"]$mq$, 3, $mq$Bones respond to mechanical stress by becoming stronger and denser, which is why weight-bearing activity supports bone health.$mq$, $mq$hard$mq$),
($mq$A student says: 'Tendons and ligaments are the same thing.' What is the best correction?$mq$, $mq$["Both connect muscle to muscle","Ligaments connect muscle to bone; tendons connect bone to bone","Tendons connect muscle to bone; ligaments connect bone to bone","They are both types of cartilage"]$mq$, 2, $mq$The two connective tissues have different jobs and are often confused in exams.$mq$, $mq$hard$mq$),
($mq$A ligament in the ankle is overstretched in a fall. Which function is most affected?$mq$, $mq$["Production of red blood cells","Stability of the joint","Digestion","Heart rate"]$mq$, 1, $mq$Ligaments hold bones together and stabilise joints, so damage reduces joint stability.$mq$, $mq$hard$mq$),
($mq$A rower pulls the oar toward the chest, bending the elbow while the shoulders pull back. Which statement is the best analysis?$mq$, $mq$["Biceps shorten while triceps lengthen at the elbow; muscles pull on bones across a hinge joint","Triceps shorten while biceps lengthen at the elbow","Bones pull the muscles","Muscles push the bones"]$mq$, 0, $mq$Elbow flexion uses the biceps as the prime mover with the triceps relaxing. Muscles only pull, pulling on bones that act as levers.$mq$, $mq$hard$mq$),
($mq$Why might a 15-year-old athlete avoid lifting very heavy loads with poor technique while growing?$mq$, $mq$["Bones stop growing at 10","Muscle cannot get stronger","Heavy loads cure all injuries","Growing bones and joints can be injured if loads and technique are not suitable"]$mq$, 3, $mq$Teenagers' bodies are still growing, so training with age-appropriate loads, good technique and supervision is advised.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Muscular and Skeletal Systems$mq$ and p.name = $mq$Body Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Functions of the skeleton$mq$, $mq$Support, protection, movement, blood cell production in bone marrow, and storage of minerals such as calcium.$mq$),
($mq$Tendon vs ligament$mq$, $mq$Tendons connect muscle to bone. Ligaments connect bone to bone and stabilise joints.$mq$),
($mq$Hinge joint$mq$, $mq$Moves mainly in one plane, bending and straightening. Examples: elbow and knee.$mq$),
($mq$Ball and socket joint$mq$, $mq$Allows movement in many directions, including rotation. Examples: shoulder and hip.$mq$),
($mq$Function of cartilage$mq$, $mq$Covers bone ends in joints to reduce friction and absorb shock.$mq$),
($mq$Antagonistic muscle pair$mq$, $mq$Two muscles working in opposite ways: one contracts (agonist) while the other relaxes (antagonist). Example: biceps and triceps.$mq$),
($mq$Three types of muscle$mq$, $mq$Skeletal (voluntary, attached to bone), cardiac (heart, involuntary) and smooth (organ walls, involuntary).$mq$),
($mq$Flexion vs extension$mq$, $mq$Flexion decreases the angle at a joint (bending). Extension increases the angle (straightening).$mq$),
($mq$Isometric vs isotonic$mq$, $mq$Isometric: tension without a change in muscle length (plank). Isotonic: muscle changes length while producing force (press-up).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Muscular and Skeletal Systems$mq$ and p.name = $mq$Body Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The skeletal system
The skeleton has about 206 bones in an adult. It gives the body shape and has five main jobs:
- **Support**: it holds the body upright and provides a frame.
- **Protection**: the skull protects the brain, the ribcage protects the heart and lungs, and the vertebrae protect the spinal cord.
- **Movement**: bones act as levers that muscles pull on.
- **Blood cell production**: red blood cells are made in bone marrow.
- **Mineral storage**: bones store calcium and phosphorus.

## Joints
A joint is where two or more bones meet. Types you should know:
- **Hinge** (elbow, knee): movement mainly in one direction, bending and straightening.
- **Ball and socket** (shoulder, hip): movement in many directions, including rotation.
- **Pivot** (top of the neck): allows rotation, so you can shake your head.
- **Gliding** (wrist, ankle bones): small sliding movements.

At a joint, **cartilage** covers bone ends to reduce friction and absorb shock. **Ligaments** join bone to bone and keep joints stable. **Tendons** join muscle to bone. A good memory trick: Ligaments Link bones, Tendons Tie muscle.

## Types of movement
- **Flexion**: bending a joint, decreasing the angle.
- **Extension**: straightening a joint.
- **Abduction**: moving a limb away from the midline.
- **Adduction**: moving a limb towards the midline.
- **Rotation**: turning around a long axis.

## The muscular system
There are three types of muscle:
- **Skeletal muscle**: voluntary, attached to bones, moves the body.
- **Cardiac muscle**: found only in the heart, involuntary, does not tire easily.
- **Smooth muscle**: involuntary, found in the walls of organs such as the stomach and blood vessels.

Muscles can only **pull** by contracting; they cannot push. So they work in **antagonistic pairs**. The muscle that contracts to cause the movement is the **agonist** (prime mover). The muscle that relaxes is the **antagonist**.
- Elbow flexion: biceps contracts (agonist), triceps relaxes.
- Elbow extension: triceps contracts, biceps relaxes.
- Knee extension: quadriceps contract, hamstrings relax.
- Knee flexion: hamstrings contract, quadriceps relax.

Other muscle groups to know include the deltoids (shoulder), pectorals (chest), abdominals (stomach area), gluteals (buttocks) and gastrocnemius (calf).

## Types of contraction
In an **isotonic** contraction the muscle changes length while producing force, as in a press-up. In an **isometric** contraction the muscle produces tension without changing length, as in holding a plank.

## Training and the body
Regular exercise causes adaptations. Muscles can become stronger and larger with resistance training. Bones respond to weight-bearing activities such as running and jumping by becoming denser. Joints stay mobile with regular movement. Young people are still growing, so they need good technique, suitable loads and supervision.

## Common mistakes
- Saying muscles push. Muscles only pull.
- Mixing up tendons and ligaments.
- Giving only the name of the muscle without saying whether it contracts or relaxes.
- Using "extension" and "flexion" the wrong way round for the knee.

## How this is examined
You may be given a sport photo description or movement, such as a kick, a throw or a push-up, and asked to name the joint, the type of movement and the muscle working. Command terms like "describe" and "explain" ask you to link structure to function.

Exam tip: for any movement, write three things: the joint, the movement (flexion or extension), and the agonist and antagonist muscles with which one contracts.$mq$ from st;

-- Body Systems > Heart, Lungs and Circulation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Body Systems$mq$, 5, 2 from public.subjects s where s.slug = $mq$physical-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Heart, Lungs and Circulation$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-health-education$mq$ and p.grade = 5 and p.name = $mq$Body Systems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Heart, Lungs and Circulation$mq$ and p.name = $mq$Body Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$How many chambers does the human heart have?$mq$, $mq$["Four","Two","Three","Six"]$mq$, 0, $mq$The heart has four chambers: two atria on top and two ventricles below.$mq$, $mq$easy$mq$),
($mq$Which blood vessels carry blood away from the heart?$mq$, $mq$["Veins","Capillaries","Valves","Arteries"]$mq$, 3, $mq$Arteries carry blood away from the heart at high pressure and have thick, muscular walls.$mq$, $mq$easy$mq$),
($mq$Where does gas exchange take place in the lungs?$mq$, $mq$["Trachea","Bronchi","Alveoli","Ribs"]$mq$, 2, $mq$Oxygen passes into the blood and carbon dioxide passes out across the thin walls of the alveoli.$mq$, $mq$easy$mq$),
($mq$What happens to heart rate during exercise?$mq$, $mq$["It decreases","It increases","It stops","It stays exactly the same"]$mq$, 1, $mq$Heart rate rises to deliver more oxygenated blood to working muscles.$mq$, $mq$easy$mq$),
($mq$Which muscle contracts and flattens to help you breathe in?$mq$, $mq$["Diaphragm","Biceps","Heart","Hamstrings"]$mq$, 0, $mq$When the diaphragm contracts and flattens and the intercostal muscles lift the ribs, the chest volume increases and air flows in.$mq$, $mq$easy$mq$),
($mq$Which statement about veins is correct?$mq$, $mq$["They carry blood away from the heart under high pressure","They are where gas exchange takes place","They have walls one cell thick","They carry blood towards the heart and have valves"]$mq$, 3, $mq$Veins return blood to the heart at lower pressure and have valves to stop backflow.$mq$, $mq$medium$mq$),
($mq$A student's heart rate is 70 beats per minute and each beat pumps 70 mL of blood. What is the cardiac output?$mq$, $mq$["140 mL per minute","490 mL per minute","4,900 mL per minute","49,000 mL per minute"]$mq$, 2, $mq$Cardiac output = heart rate × stroke volume = 70 × 70 = 4,900 mL per minute.$mq$, $mq$medium$mq$),
($mq$Which route is correct for blood returning from the body?$mq$, $mq$["Aorta → left atrium → lungs","Vena cava → right atrium → right ventricle → pulmonary artery → lungs","Pulmonary vein → right ventricle → body","Vena cava → left ventricle → aorta"]$mq$, 1, $mq$Deoxygenated blood from the body enters the right atrium, passes to the right ventricle and is pumped to the lungs through the pulmonary artery.$mq$, $mq$medium$mq$),
($mq$Why are capillary walls only one cell thick?$mq$, $mq$["To allow quick exchange of oxygen, carbon dioxide and nutrients","To withstand high pressure","To store blood","To pump blood"]$mq$, 0, $mq$A thin wall gives a short diffusion distance between the blood and the surrounding tissue cells.$mq$, $mq$medium$mq$),
($mq$Compare the air breathed in with air breathed out. Which is correct?$mq$, $mq$["Exhaled air has more oxygen and less carbon dioxide","Both are identical","Exhaled air contains no oxygen","Exhaled air has less oxygen and more carbon dioxide"]$mq$, 3, $mq$Inhaled air is about 21% oxygen and exhaled air about 16% oxygen, while carbon dioxide rises from about 0.04% to about 4%.$mq$, $mq$medium$mq$),
($mq$A teen's tidal volume is 500 mL and breathing rate is 15 breaths per minute. What is the minute ventilation?$mq$, $mq$["515 mL per minute","750 mL per minute","7,500 mL (7.5 L) per minute","75 L per minute"]$mq$, 2, $mq$Minute ventilation = tidal volume × breathing rate = 500 × 15 = 7,500 mL.$mq$, $mq$medium$mq$),
($mq$Why does breathing rate stay raised for a short time after hard exercise stops?$mq$, $mq$["The lungs are broken","The body needs extra oxygen to recover and is clearing carbon dioxide","The muscles are growing","Breathing is voluntary only"]$mq$, 1, $mq$The body needs extra oxygen to recover, restore energy stores and clear waste, so breathing stays elevated before returning to normal.$mq$, $mq$medium$mq$),
($mq$Which long-term effect of regular aerobic training is most likely?$mq$, $mq$["Lower resting heart rate","Higher resting heart rate","Smaller heart","Fewer red blood cells forming"]$mq$, 0, $mq$A stronger heart pumps more blood per beat, so fewer beats are needed at rest.$mq$, $mq$medium$mq$),
($mq$Rafael's resting heart rate is 72. Over a day, how many heartbeats is that at rest?$mq$, $mq$["4,320","10,368","1,728","103,680"]$mq$, 3, $mq$72 × 60 minutes × 24 hours = 103,680 beats. 72 × 60 = 4,320 is only one hour.$mq$, $mq$hard$mq$),
($mq$A trained athlete has resting heart rate 55 and stroke volume 90 mL. An untrained person has 70 and 70 mL. Which conclusion is best?$mq$, $mq$["Athlete's cardiac output is half","Athlete's heart is weaker","Athlete: 4,950 mL/min, similar output at rest with fewer, bigger beats","Both have identical stroke volume"]$mq$, 2, $mq$Athlete: 55 × 90 = 4,950 mL/min. Untrained: 70 × 70 = 4,900 mL/min. Similar output but the athlete's heart does it more efficiently.$mq$, $mq$hard$mq$),
($mq$Why are valves found in veins but not in arteries?$mq$, $mq$["Arteries are too wide","Venous blood is at low pressure and could flow backwards","Veins are one cell thick","Valves make arteries pump"]$mq$, 1, $mq$Blood pressure in veins is low, so valves prevent backflow, helped by muscle contractions that squeeze the veins.$mq$, $mq$hard$mq$),
($mq$In a graph, a student's heart rate rises from 70 to 160 during a run and takes 4 minutes to return to 80 afterwards. What is the best interpretation?$mq$, $mq$["The heart responded to demand, and recovery time is an indicator of fitness","The heart is damaged","The test is invalid","Recovery time is irrelevant to fitness"]$mq$, 0, $mq$Heart rate increasing with exercise is normal. A quicker recovery rate usually shows better cardiovascular fitness, though other factors influence it.$mq$, $mq$hard$mq$),
($mq$A student claims: 'Our lungs use up all the oxygen we breathe in.' Which reply is best?$mq$, $mq$["Lungs absorb 100% of oxygen","Lungs make oxygen","Oxygen is only used by the heart","Exhaled air still holds around 16% oxygen, so only part is absorbed"]$mq$, 3, $mq$Only a fraction is taken into the blood, which is why mouth-to-mouth resuscitation can work with exhaled air.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Heart, Lungs and Circulation$mq$ and p.name = $mq$Body Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Four chambers of the heart$mq$, $mq$Right atrium, right ventricle, left atrium and left ventricle. Atria receive blood; ventricles pump it out.$mq$),
($mq$Artery vs vein$mq$, $mq$Arteries carry blood away from the heart under high pressure (thick walls). Veins carry blood towards the heart (valves, thinner walls).$mq$),
($mq$Capillaries$mq$, $mq$Tiny vessels with walls one cell thick where oxygen, nutrients and waste are exchanged with body cells.$mq$),
($mq$Alveoli$mq$, $mq$Tiny air sacs in the lungs with thin walls and many capillaries, where gas exchange takes place.$mq$),
($mq$How we breathe in$mq$, $mq$The diaphragm contracts and flattens and the ribs move up and out. Chest volume increases and air flows in.$mq$),
($mq$Cardiac output$mq$, $mq$Cardiac output = heart rate × stroke volume. Example: 70 × 70 mL = 4,900 mL per minute.$mq$),
($mq$Minute ventilation$mq$, $mq$Tidal volume × breathing rate. Example: 500 mL × 15 = 7,500 mL per minute.$mq$),
($mq$Short-term effects of exercise$mq$, $mq$Heart rate, stroke volume and breathing rate increase to deliver more oxygen and remove carbon dioxide.$mq$),
($mq$Long-term effects of aerobic training$mq$, $mq$Stronger heart, larger stroke volume, lower resting heart rate, faster recovery, more capillaries in muscles.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Heart, Lungs and Circulation$mq$ and p.name = $mq$Body Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The circulatory system
The circulatory system transports oxygen, nutrients, hormones and waste around the body. It has three parts: the heart (the pump), the blood vessels (the pipes) and the blood (the transport fluid).

## The heart
The heart is a muscular organ with four chambers: two **atria** (upper) that receive blood and two **ventricles** (lower) that pump blood out. The right side handles deoxygenated blood: it arrives from the body through the vena cava, goes to the right atrium, then the right ventricle, and is pumped to the lungs through the pulmonary artery. The left side handles oxygenated blood: it returns from the lungs through the pulmonary vein into the left atrium, then the left ventricle, and is pumped to the body through the aorta. Valves keep blood flowing in one direction. The left ventricle has the thickest wall because it must push blood around the whole body.

## Blood vessels
- **Arteries** carry blood away from the heart. They have thick, elastic walls to cope with high pressure.
- **Veins** carry blood towards the heart. They have thinner walls and valves to stop backflow.
- **Capillaries** are tiny vessels with walls one cell thick where substances move between blood and body cells.

## The respiratory system
Air travels through the nose or mouth, trachea, bronchi and bronchioles to the alveoli. The alveoli are tiny air sacs with thin walls and a rich blood supply, so oxygen diffuses into the blood and carbon dioxide diffuses out. To breathe in, the diaphragm contracts and flattens and the rib muscles lift the ribs, so the chest gets bigger and air rushes in. To breathe out, the muscles relax and the chest gets smaller. Inhaled air has about 21% oxygen and 0.04% carbon dioxide. Exhaled air has about 16% oxygen and 4% carbon dioxide.

## Useful calculations
- **Cardiac output** = heart rate × stroke volume. If heart rate is 70 beats per minute and stroke volume is 70 mL, output is 4,900 mL per minute.
- **Minute ventilation** = tidal volume × breathing rate. At 500 mL and 15 breaths per minute that is 7,500 mL per minute.
- Total beats in a day at rest, for 72 beats per minute: 72 × 60 × 24 = 103,680.

## What happens during exercise?
Short-term responses: heart rate, stroke volume and breathing rate all increase so that more oxygen reaches the muscles and more carbon dioxide is removed. Blood is redirected to working muscles. After exercise, heart and breathing rates stay raised briefly while the body recovers.

Long-term adaptations to regular aerobic training: the heart muscle gets stronger, stroke volume increases, resting heart rate decreases, recovery is faster, and more capillaries develop in the muscles. This is why trained athletes can produce the same cardiac output with fewer, stronger beats.

## Common mistakes
- Saying arteries always carry oxygenated blood. The pulmonary artery carries deoxygenated blood.
- Saying the lungs "use" oxygen. Cells use oxygen; lungs transfer it.
- Mixing up cardiac output and stroke volume.
- Forgetting units in calculations.

## How this is examined
Expect heart rate data from a short activity, a diagram description of blood flow, or a graph of heart rate over time. You may be asked to calculate cardiac output, describe the effects of exercise and explain how training changes the system. Criterion A rewards correct terms; Criterion D rewards evaluation of data.

Exam tip: if asked to explain a change, give cause then effect then benefit: "Heart rate increases so that more blood reaches the muscles, which delivers more oxygen for energy release."$mq$ from st;

-- Body Systems > Injury Prevention and First Aid
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Body Systems$mq$, 5, 2 from public.subjects s where s.slug = $mq$physical-health-education$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Injury Prevention and First Aid$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$physical-health-education$mq$ and p.grade = 5 and p.name = $mq$Body Systems$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Injury Prevention and First Aid$mq$ and p.name = $mq$Body Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a sprain?$mq$, $mq$["An injury to a ligament","An injury to a tendon only","A broken bone","A cut in the skin"]$mq$, 0, $mq$A sprain is an injury to a ligament, often at the ankle or wrist. A strain involves a muscle or tendon.$mq$, $mq$easy$mq$),
($mq$What does the 'R' in RICE stand for?$mq$, $mq$["Run","Repeat","Reaction","Rest"]$mq$, 3, $mq$RICE stands for Rest, Ice, Compression and Elevation, a common first-aid approach for minor soft-tissue injuries.$mq$, $mq$easy$mq$),
($mq$What should a student do first if a classmate is badly hurt in PE?$mq$, $mq$["Ignore it","Move them quickly without thinking","Tell the teacher or a responsible adult straight away","Carry on playing"]$mq$, 2, $mq$Getting help from a responsible adult quickly is the first priority.$mq$, $mq$easy$mq$),
($mq$Which is an example of a protective measure to prevent injury?$mq$, $mq$["Skipping the warm-up","Wearing a gum shield in a contact sport","Playing on a wet slippery surface","Using damaged equipment"]$mq$, 1, $mq$Protective equipment such as gum shields, helmets and shin pads reduces injury risk.$mq$, $mq$easy$mq$),
($mq$An injury caused by repeated stress over time, such as shin splints in a runner, is called what?$mq$, $mq$["An overuse injury","An acute injury","A cut","A sudden fracture"]$mq$, 0, $mq$Overuse injuries build up gradually from repeated stress; acute injuries happen suddenly.$mq$, $mq$easy$mq$),
($mq$In first aid, what do the letters DR in the DRSABCD approach remind you to check?$mq$, $mq$["Doctors and Rescue","Drink and Rest","Direction and Repeat","Danger and Response"]$mq$, 3, $mq$First check for danger to yourself and others, then check whether the person responds, before sending for help.$mq$, $mq$medium$mq$),
($mq$A player twists an ankle. The ankle is swollen and tender. Which action matches the RICE approach?$mq$, $mq$["Keep running on it","Heat it and massage hard","Rest the ankle, apply a cold pack wrapped in cloth, use a bandage and raise it","Pull the ankle to straighten it"]$mq$, 2, $mq$Rest, a covered cold pack, gentle compression and elevation help to limit swelling in a minor sprain. A teacher or medical professional should check the injury.$mq$, $mq$medium$mq$),
($mq$Which is an extrinsic (outside the body) risk factor for injury?$mq$, $mq$["Low flexibility","Poor playing surface","Previous injury","Weak muscles"]$mq$, 1, $mq$Extrinsic factors come from outside, like equipment, surface, weather and rules. Intrinsic factors come from the person.$mq$, $mq$medium$mq$),
($mq$After a head knock, a student feels dizzy and confused. What should happen?$mq$, $mq$["Stop playing, tell an adult and get medical advice","Carry on, since it is only a game","Do ten more minutes of training","Drink coffee"]$mq$, 0, $mq$A suspected concussion needs the person to stop activity immediately and seek medical assessment. It should never be ignored.$mq$, $mq$medium$mq$),
($mq$Why does a gradual increase in training reduce the risk of overuse injuries?$mq$, $mq$["It makes the body weaker","It stops all recovery","It makes the activity easier","It allows the body time to adapt"]$mq$, 3, $mq$Gradual progression gives bones, muscles and tendons time to adapt to higher loads.$mq$, $mq$medium$mq$),
($mq$What is the main difference between a strain and a sprain?$mq$, $mq$["A strain affects bone; a sprain affects skin","They are the same","A strain affects muscle or tendon; a sprain affects a ligament","A strain affects ligaments; a sprain affects muscles"]$mq$, 2, $mq$Strain = muscle or tendon. Sprain = ligament. They are commonly confused.$mq$, $mq$medium$mq$),
($mq$A basketball court has a loose floorboard that sticks up. What is the best action?$mq$, $mq$["Play around it","Stop the activity there and report it so it can be fixed","Tell no one","Make a rule to run faster"]$mq$, 1, $mq$Reporting the hazard and removing the risk is the correct control. Working around it leaves the risk in place.$mq$, $mq$medium$mq$),
($mq$A runner develops pain at the front of the lower leg after doubling her weekly distance in a week. Which factor is the most likely cause?$mq$, $mq$["Too much too soon (training load increased too quickly)","Too little distance","Too much rest","Too much stretching"]$mq$, 0, $mq$A rapid increase in training load is a common cause of overuse pain. A slower build-up and rest would be a more suitable plan.$mq$, $mq$medium$mq$),
($mq$Which two actions together are the best prevention of a hamstring strain in a sprinter?$mq$, $mq$["Skipping the warm-up and sprinting hard","Stretching only after an injury","Wearing heavier shoes","A proper warm-up and a balanced strength and flexibility programme"]$mq$, 3, $mq$Preparing the muscle and keeping the muscles strong and flexible reduces the chance of strain.$mq$, $mq$hard$mq$),
($mq$In an emergency, a student is the first to notice that a classmate has collapsed and does not respond. Which sequence is most appropriate?$mq$, $mq$["Leave to find a friend","Take a photo","Check for danger, check response, shout for help and send someone to call emergency services","Give them water immediately"]$mq$, 2, $mq$The priorities are safety, checking response and getting help quickly. Trained responders then take over.$mq$, $mq$hard$mq$),
($mq$A school keeps an accident log. After reviewing it, staff see most injuries happen when teams of different sizes play together. What is the best response?$mq$, $mq$["Cancel all sport forever","Match groups by size and ability and review again","Remove the log","Increase speed of games"]$mq$, 1, $mq$Using data to adjust the activity is a good risk-management step, and the effect should be checked afterwards.$mq$, $mq$hard$mq$),
($mq$Why should first aid for a suspected broken bone avoid trying to straighten or force the limb?$mq$, $mq$["Moving it could cause further damage; keep it still and get professional help","Straightening cures fractures","Bones are not important","Ice will heal it at once"]$mq$, 0, $mq$The aim is to keep the limb supported and still, and get trained help. Only professionals should attempt to realign bones.$mq$, $mq$hard$mq$),
($mq$A student says: 'First aid training means I can treat any injury without telling anyone.' Which answer is best?$mq$, $mq$["They are right","Students should ignore injuries","First aid replaces doctors","First aid is initial help until professional help is available; always report injuries"]$mq$, 3, $mq$First aid is the first response, not a replacement for medical care. Injuries should always be reported to staff.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Injury Prevention and First Aid$mq$ and p.name = $mq$Body Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Sprain vs strain$mq$, $mq$A sprain is an injury to a ligament. A strain is an injury to a muscle or tendon.$mq$),
($mq$Acute vs overuse injury$mq$, $mq$Acute injuries happen suddenly (e.g. a fracture). Overuse injuries build up over time from repeated stress (e.g. shin splints).$mq$),
($mq$RICE$mq$, $mq$Rest, Ice (cold pack wrapped in cloth), Compression and Elevation. For minor soft-tissue injuries, with adult guidance.$mq$),
($mq$Fracture$mq$, $mq$A break or crack in a bone. Keep the limb still and supported and get help. Do not try to straighten it.$mq$),
($mq$Concussion response$mq$, $mq$Stop playing at once, tell an adult and seek medical advice. Never ignore a head injury.$mq$),
($mq$DRSABCD$mq$, $mq$Danger, Response, Send for help, Airway, Breathing, CPR, Defibrillator. A first-aid action sequence.$mq$),
($mq$Intrinsic vs extrinsic risk factors$mq$, $mq$Intrinsic come from the person (technique, tiredness, previous injury). Extrinsic come from outside (surface, equipment, weather, rules).$mq$),
($mq$Ways to prevent sports injuries$mq$, $mq$Warm-up, correct technique, gradual progression, protective equipment, safe environment, hydration, rest and following rules.$mq$),
($mq$Why report injuries and hazards?$mq$, $mq$So that an adult can give proper care and fix the hazard, which protects you and others. First aid is not a replacement for medical care.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$physical-health-education$mq$ and t.grade = 5 and t.name = $mq$Injury Prevention and First Aid$mq$ and p.name = $mq$Body Systems$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why injuries happen
Sport and exercise are good for you, but injuries can happen. Most are minor, yet some are serious. Understanding how injuries occur helps you prevent them and respond sensibly. Note that this lesson is education about safe practice, not medical advice. If someone is injured, always tell a teacher or responsible adult and follow their directions.

## Types of injury
- **Acute injuries** happen suddenly, for example a sprained ankle, a fracture or a bruise.
- **Overuse injuries** develop gradually from repeated stress, for example shin splints or tennis elbow.

Common injuries:
- **Sprain**: a stretched or torn ligament.
- **Strain**: a stretched or torn muscle or tendon.
- **Fracture**: a break or crack in a bone.
- **Dislocation**: a bone is pushed out of its normal position at a joint.
- **Contusion (bruise)**: bleeding under the skin after a knock.
- **Cuts, grazes and blisters**: damage to the skin.
- **Concussion**: a brain injury after a knock to the head or body. It needs medical attention and a gradual return to sport.
- **Heat illness**: dizziness, headache or feeling faint in hot weather.

## Causes and risk factors
Intrinsic factors are about the person: poor technique, tight or weak muscles, tiredness, previous injury or growth spurts. Extrinsic factors are outside the person: poor surfaces, unsuitable equipment, weather, crowding, mismatched opponents or breaking the rules.

## Preventing injuries
- Warm up and cool down properly.
- Learn and use correct technique.
- Increase training gradually and include rest days.
- Use suitable protective equipment and footwear, and check equipment.
- Check the space and surface before you play.
- Stay hydrated and protect yourself from heat and sun.
- Follow the rules and respect other players.
- Build balanced strength and flexibility.
- Report hazards and injuries.

## First aid basics
First aid is the immediate help given to someone before professional help arrives. A well-known sequence is DRSABCD: Danger (check it is safe), Response (check if the person responds), Send for help (call emergency services or an adult), Airway, Breathing, CPR if needed, Defibrillator if available. Students are not expected to do more than they are trained for, but they must know to stay calm, keep safe and get help quickly.

For minor soft-tissue injuries such as a sprain, many schools teach **RICE**:
- **R**est the injured part.
- **I**ce: a cold pack wrapped in cloth for short periods.
- **C**ompression: a firm but not tight bandage.
- **E**levation: raise the injured part to reduce swelling.

Note that first-aid advice for soft-tissue injuries changes over time (some newer guidance uses PEACE & LOVE instead of RICE), so follow your school's first-aid training.

A suspected fracture should be kept still and supported, with help called. A suspected concussion means stopping play at once and getting medical advice. Do not try to straighten bones or move a seriously injured person.

## Common mistakes
- Saying a sprain and a strain are the same thing.
- Treating all injuries with RICE, even serious ones that need urgent help.
- Continuing to play with a head injury.
- Forgetting to report hazards.

## How this is examined
Questions often provide a scenario, such as a sprained ankle in a basketball game or an overuse injury in a runner, and ask you to identify the injury, state a cause, explain how it could have been prevented and describe a safe response. Criterion A uses correct terms; Criterion B involves planning safety into an activity.

Exam tip: always link prevention to the cause. If a runner increased distance too fast, say "increase training gradually", not just "warm up".$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('physical-health-education')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;