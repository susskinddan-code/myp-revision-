-- Part 1 of 6: 6 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Cells and Microscopy > Organelles and Their Functions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Cells and Microscopy$mq$, 4, 1 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Organelles and Their Functions$mq$, 4, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Cells and Microscopy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Organelles and Their Functions$mq$ and p.name = $mq$Cells and Microscopy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Name the structure that contains the DNA and controls the activities of an animal cell.$mq$, $mq$["Nucleus","Vacuole","Cell membrane","Cytoplasm"]$mq$, 0, $mq$The nucleus holds the cell's DNA and controls its activities. The cytoplasm is where reactions happen, and the membrane controls what moves in and out.$mq$, $mq$easy$mq$),
($mq$Name the organelle where aerobic respiration takes place.$mq$, $mq$["Chloroplasts","Ribosomes","Nucleus","Mitochondria"]$mq$, 3, $mq$Mitochondria release energy from glucose using oxygen. Chloroplasts are for photosynthesis and ribosomes make proteins.$mq$, $mq$easy$mq$),
($mq$Name the organelle in plant cells where photosynthesis happens.$mq$, $mq$["Mitochondrion","Vacuole","Chloroplast","Nucleus"]$mq$, 2, $mq$Chloroplasts contain the green pigment chlorophyll, which absorbs light energy for photosynthesis.$mq$, $mq$easy$mq$),
($mq$Name the strong outer layer of a plant cell that is made of cellulose.$mq$, $mq$["Cell membrane","Cell wall","Cytoplasm","Vacuole"]$mq$, 1, $mq$The cell wall is made of cellulose. It supports the cell and stops it bursting. The membrane inside it is much thinner and controls what moves in and out.$mq$, $mq$easy$mq$),
($mq$Name the tiny organelles where proteins are made.$mq$, $mq$["Ribosomes","Mitochondria","Vacuoles","Chloroplasts"]$mq$, 0, $mq$Ribosomes join amino acids together to make proteins. They are found in all living cells, in the cytoplasm.$mq$, $mq$easy$mq$),
($mq$Name the thin layer around a cell that controls which substances enter and leave.$mq$, $mq$["Cell wall","Nucleus","Cytoplasm","Cell membrane"]$mq$, 3, $mq$The cell membrane is partially permeable, so it controls which substances pass through. A plant cell wall is fully permeable and mainly gives support.$mq$, $mq$medium$mq$),
($mq$Name the jelly-like substance in which most of a cell's chemical reactions take place.$mq$, $mq$["Cell sap","Chlorophyll","Cytoplasm","Cellulose"]$mq$, 2, $mq$Cytoplasm is a watery jelly that fills the cell. Many reactions, such as the start of respiration, happen in it.$mq$, $mq$medium$mq$),
($mq$Name the fluid-filled sac in a plant cell that contains cell sap and helps keep the cell firm.$mq$, $mq$["Chloroplast","Vacuole","Ribosome","Nucleus"]$mq$, 1, $mq$The permanent vacuole stores cell sap. When it is full of water it pushes on the cell wall and keeps the cell firm (turgid).$mq$, $mq$medium$mq$),
($mq$Muscle cells need a lot of energy. Name the organelle they have in very large numbers.$mq$, $mq$["Mitochondria","Chloroplasts","Cell walls","Large vacuoles"]$mq$, 0, $mq$Mitochondria release energy by aerobic respiration, so cells with a high energy demand contain many of them.$mq$, $mq$medium$mq$),
($mq$Root hair cells are underground and do not photosynthesise. Name the organelle they do not contain, even though most other plant cells do.$mq$, $mq$["Nucleus","Cell wall","Vacuole","Chloroplasts"]$mq$, 3, $mq$Chloroplasts need light, so cells in the roots do not have them. Root hair cells still have a nucleus, a cell wall and a vacuole.$mq$, $mq$medium$mq$),
($mq$A cell has a nucleus, membrane and cytoplasm, but no cell wall, chloroplasts or permanent vacuole. What type of cell is it?$mq$, $mq$["Plant cell","Bacterial cell","Animal cell","Fungal cell"]$mq$, 2, $mq$Animal cells lack a cell wall, chloroplasts and a large permanent vacuole. Bacterial cells have no nucleus, and fungal cells have a cell wall.$mq$, $mq$medium$mq$),
($mq$Name the green pigment in chloroplasts that absorbs light for photosynthesis.$mq$, $mq$["Cellulose","Chlorophyll","Haemoglobin","Glycogen"]$mq$, 1, $mq$Chlorophyll absorbs light energy, mainly red and blue light, and reflects green light, which is why leaves look green. Haemoglobin is the red pigment in blood.$mq$, $mq$medium$mq$),
($mq$Name the carbohydrate that plant cell walls are made of.$mq$, $mq$["Cellulose","Starch","Glycogen","Chitin"]$mq$, 0, $mq$Plant cell walls are made of cellulose fibres. Starch is a storage carbohydrate, glycogen is stored by animals, and chitin is found in fungal cell walls.$mq$, $mq$medium$mq$),
($mq$Mature human red blood cells have no nucleus. What is the advantage of this?$mq$, $mq$["Faster cell division","More mitochondria","A stronger cell wall","More room for haemoglobin"]$mq$, 3, $mq$Without a nucleus there is more space for haemoglobin, so more oxygen can be carried. The cell cannot divide, but that is a cost and not an advantage.$mq$, $mq$hard$mq$),
($mq$A leaf cell is kept in the dark for several days. Name the organelle that carries on releasing energy from glucose.$mq$, $mq$["Chloroplasts","Vacuole","Mitochondria","Cell wall"]$mq$, 2, $mq$Plant cells respire all the time, day and night, in their mitochondria. Chloroplasts need light, so photosynthesis stops in the dark.$mq$, $mq$hard$mq$),
($mq$If the mitochondria in a cell are damaged, which process is directly affected?$mq$, $mq$["Photosynthesis","Aerobic respiration","Osmosis","Diffusion"]$mq$, 1, $mq$Aerobic respiration happens in the mitochondria. Osmosis and diffusion are passive and need no energy from the cell, and photosynthesis happens in chloroplasts.$mq$, $mq$hard$mq$),
($mq$A cell contains a green organelle, a large central vacuole and a cell wall. Which kingdom of living things does it come from?$mq$, $mq$["Plants","Animals","Bacteria","Viruses"]$mq$, 0, $mq$Chloroplasts, a cell wall and a large vacuole are typical of plant cells. Viruses are not made of cells at all.$mq$, $mq$hard$mq$),
($mq$Yeast cells have a nucleus and a cell wall made of chitin. Are they prokaryotic or eukaryotic?$mq$, $mq$["Prokaryotic","Acellular","Non-living","Eukaryotic"]$mq$, 3, $mq$Any cell with a nucleus is eukaryotic. Prokaryotic cells, such as bacteria, have their DNA free in the cytoplasm.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Organelles and Their Functions$mq$ and p.name = $mq$Cells and Microscopy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Nucleus$mq$, $mq$Contains the DNA and controls the activities of the cell.$mq$),
($mq$Mitochondria$mq$, $mq$Organelles where aerobic respiration releases energy from glucose.$mq$),
($mq$Ribosomes$mq$, $mq$Tiny structures in the cytoplasm where proteins are made.$mq$),
($mq$Cell membrane$mq$, $mq$Thin partially permeable layer that controls which substances enter and leave the cell.$mq$),
($mq$Cell wall$mq$, $mq$Strong cellulose layer outside the membrane in plant cells. Gives support and shape.$mq$),
($mq$Chloroplast$mq$, $mq$Organelle containing chlorophyll where photosynthesis happens. Found in plant cells.$mq$),
($mq$Permanent vacuole$mq$, $mq$Sac filled with cell sap in plant cells. When full it keeps the cell firm.$mq$),
($mq$Organelle$mq$, $mq$A small structure inside a cell that carries out a particular job.$mq$),
($mq$Eukaryotic vs prokaryotic cell$mq$, $mq$Eukaryotic cells have a nucleus. Prokaryotic cells, such as bacteria, have no nucleus and their DNA is free in the cytoplasm.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Organelles and Their Functions$mq$ and p.name = $mq$Cells and Microscopy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Cells are the basic units of life, and each part inside a cell has a job. The small structures inside cells are called organelles. If you can link each organelle to its function, you can predict which cells will have lots of it.

## Organelles in animal cells
- The nucleus contains the cell's DNA, arranged in genes. It controls the activities of the cell, including which proteins are made.
- The cytoplasm is a jelly-like liquid. Many chemical reactions take place in it.
- The cell membrane is a thin, partially permeable layer around the cell. It controls which substances enter and leave.
- Mitochondria are where aerobic respiration happens. They release energy from glucose using oxygen.
- Ribosomes are tiny structures where amino acids are joined together to make proteins.

## Extra structures in plant cells
Plant cells have all of the above, plus three more:
- A cell wall made of cellulose. It is outside the membrane, gives strength and support, and is fully permeable.
- Chloroplasts, which contain chlorophyll and carry out photosynthesis.
- A permanent vacuole filled with cell sap. When it is full, it pushes the cytoplasm against the cell wall and keeps the cell firm.

Not every plant cell has chloroplasts. Cells in roots are underground, so they get no light and have none.

## Matching structure to function
Cells are adapted for their jobs. A muscle cell needs a lot of energy, so it has many mitochondria. A cell that makes a lot of protein, such as one in a gland, has many ribosomes. A palisade cell in a leaf is packed with chloroplasts because it is the main site of photosynthesis. A mature red blood cell has no nucleus, which leaves more room for haemoglobin to carry oxygen.

## Worked example
A scientist counts the organelles in two cells. Cell A has 2,000 mitochondria. Cell B has 100 mitochondria. Which cell uses more energy? Cell A, because mitochondria release energy in respiration, so more mitochondria suggests a higher energy demand. If the question asks you to explain, always write the link: more mitochondria, more aerobic respiration, more energy released.

A second example: a cell has a nucleus, a cell wall and a vacuole, but no chloroplasts. You can say it is a plant cell, probably from a part of the plant that is not exposed to light, such as a root.

## Common mistakes
- Saying the cell wall controls what enters and leaves. That is the membrane's job. The wall only supports the cell.
- Saying mitochondria make energy. Energy cannot be made; mitochondria release it from glucose. Say "release energy".
- Saying plant cells do not have mitochondria. They do, because plants respire too.
- Writing "mitochondria" for the organelle in photosynthesis. The correct organelle is the chloroplast.
- Believing that all plant cells have chloroplasts.

## Eukaryotes and prokaryotes
Animal, plant and fungal cells are eukaryotic: their DNA is inside a nucleus. Bacteria are prokaryotic: they have no nucleus and their DNA lies free in the cytoplasm.

## Command terms
- State: give a short answer with no explanation, for example "State the function of the nucleus."
- Describe: give the main features, for example describe how a root hair cell differs from a palisade cell.
- Explain: give reasons, using "because" or "so that". For example, explain why muscle cells contain many mitochondria.
- Compare: give similarities and differences of plant and animal cells, using words such as "whereas" and "both".

Exam tip: when you explain why a cell has lots of one organelle, always name the process that organelle carries out and link it to what the cell needs.$mq$ from st;

-- Cells and Microscopy > Using a Light Microscope
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Cells and Microscopy$mq$, 4, 1 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Using a Light Microscope$mq$, 4, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Cells and Microscopy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Using a Light Microscope$mq$ and p.name = $mq$Cells and Microscopy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Name the part of a light microscope that you look through.$mq$, $mq$["Eyepiece lens","Objective lens","Stage","Diaphragm"]$mq$, 0, $mq$You look through the eyepiece lens. The objective lenses are on the nosepiece, close to the slide.$mq$, $mq$easy$mq$),
($mq$Name the flat platform of a microscope on which the slide is placed.$mq$, $mq$["Nosepiece","Eyepiece","Diaphragm","Stage"]$mq$, 3, $mq$The slide sits on the stage, held by clips. The light shines up through a hole in the stage.$mq$, $mq$easy$mq$),
($mq$When you first focus a slide, which objective lens should you use?$mq$, $mq$["Highest power","Medium power","Lowest power","Oil-immersion"]$mq$, 2, $mq$Start with the lowest-power lens. It gives the widest field of view, makes the specimen easy to find, and is the safest for the slide.$mq$, $mq$easy$mq$),
($mq$Name the knob used to make the final small adjustments to sharpen an image.$mq$, $mq$["Coarse focus knob","Fine focus knob","Diaphragm","Stage clip"]$mq$, 1, $mq$The fine focus knob moves the lens a very small distance, which gives a sharp image. The coarse knob moves it a large distance.$mq$, $mq$easy$mq$),
($mq$Name the brown liquid stain often used to show up the nuclei and cell walls of onion cells.$mq$, $mq$["Iodine solution","Universal indicator","Benedict's solution","Limewater"]$mq$, 0, $mq$Iodine solution stains cell structures so they stand out against the background. The other liquids are used in different tests.$mq$, $mq$easy$mq$),
($mq$A microscope has a x10 eyepiece lens and a x40 objective lens. What is the total magnification?$mq$, $mq$["x50","x4000","x30","x400"]$mq$, 3, $mq$Total magnification = eyepiece magnification x objective magnification = 10 x 40 = x400.$mq$, $mq$medium$mq$),
($mq$Why must a specimen on a light microscope slide be very thin?$mq$, $mq$["It stays alive longer","It magnifies more","Light must pass through it","It dries faster"]$mq$, 2, $mq$A light microscope works by shining light through the specimen. If it is too thick, light cannot pass through and the image is dark.$mq$, $mq$medium$mq$),
($mq$Name the thin piece of glass or plastic placed over a specimen on a slide.$mq$, $mq$["Stage clip","Coverslip","Diaphragm","Petri dish"]$mq$, 1, $mq$The coverslip flattens the specimen, holds the liquid in place and protects the objective lens.$mq$, $mq$medium$mq$),
($mq$Why is a coverslip lowered onto the slide at an angle?$mq$, $mq$["To avoid trapping air bubbles","To warm the specimen","To increase magnification","To stop the stain evaporating"]$mq$, 0, $mq$Lowering it gently at an angle pushes the air out in front. Air bubbles would look like dark circles and could be mistaken for cells.$mq$, $mq$medium$mq$),
($mq$Why should the high-power lens be focused only with the fine focus knob?$mq$, $mq$["To increase brightness","To make the image smaller","To stain the cells","To avoid crushing the slide"]$mq$, 3, $mq$The high-power lens sits very close to the slide. Using the coarse knob could push the lens into the slide and break it.$mq$, $mq$medium$mq$),
($mq$Name the part of the microscope that changes the amount of light passing through the specimen.$mq$, $mq$["Eyepiece lens","Stage","Diaphragm","Nosepiece"]$mq$, 2, $mq$The diaphragm opens and closes to let in more or less light, which affects how clear the image is.$mq$, $mq$medium$mq$),
($mq$A x10 eyepiece is used with a x10 objective. What is the total magnification?$mq$, $mq$["x20","x100","x1000","x10"]$mq$, 1, $mq$10 x 10 = x100.$mq$, $mq$medium$mq$),
($mq$Name the term for how clearly two objects close together can be seen as separate.$mq$, $mq$["Resolution","Magnification","Contrast","Field of view"]$mq$, 0, $mq$Resolution is the ability to see two close points as separate. Magnification only makes the image bigger, which does not always show more detail.$mq$, $mq$medium$mq$),
($mq$A slide has the letter p written on it. How will the letter appear when viewed through the microscope?$mq$, $mq$["p","b","q","d"]$mq$, 3, $mq$A light microscope turns the image upside down and reversed, which is a rotation of 180 degrees. A letter p therefore looks like a d.$mq$, $mq$hard$mq$),
($mq$A cell appears in the top-left of the field of view. Which way should you move the slide to bring it to the centre?$mq$, $mq$["Towards the bottom right","Towards the top right","Towards the top left","Towards the bottom left"]$mq$, 2, $mq$The image is inverted, so the slide must be moved the opposite way to how you want the image to move. The image needs to go down and right, so the slide goes up and left, towards where the cell appears.$mq$, $mq$hard$mq$),
($mq$Name one structure that is too small to be seen with a school light microscope.$mq$, $mq$["Nucleus","Ribosomes","Cell wall","Chloroplast"]$mq$, 1, $mq$Ribosomes are only about 25 nanometres across, far smaller than a light microscope can resolve. Nuclei, cell walls and chloroplasts can all be seen.$mq$, $mq$hard$mq$),
($mq$Besides a title and labels, what should be written on a biological drawing so that readers know its size relative to the specimen?$mq$, $mq$["Magnification","Stain colour","Shading","Date"]$mq$, 0, $mq$The magnification, or a scale bar, tells the reader how much bigger the drawing is than the real specimen.$mq$, $mq$hard$mq$),
($mq$Stains are added to many specimens to increase which feature of the image?$mq$, $mq$["Magnification","Field of view","Light intensity","Contrast"]$mq$, 3, $mq$Most cells are almost colourless and transparent. A stain makes some parts darker or coloured, so they stand out clearly, which is an increase in contrast.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Using a Light Microscope$mq$ and p.name = $mq$Cells and Microscopy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Total magnification$mq$, $mq$Eyepiece magnification x objective magnification. A x10 eyepiece with a x40 objective gives x400.$mq$),
($mq$Which objective do you start with?$mq$, $mq$The lowest power. It gives the widest field of view and is the safest for the slide.$mq$),
($mq$Function of the diaphragm$mq$, $mq$Controls the amount of light passing through the specimen.$mq$),
($mq$Why use a coverslip?$mq$, $mq$It flattens the specimen, holds liquid in place and protects the objective lens.$mq$),
($mq$Why lower a coverslip at an angle?$mq$, $mq$To avoid trapping air bubbles, which could be mistaken for cells.$mq$),
($mq$Why add a stain?$mq$, $mq$To increase contrast so cell structures such as nuclei and cell walls can be seen.$mq$),
($mq$Resolution$mq$, $mq$The ability to see two close points as separate. Light microscopes cannot resolve very small structures such as ribosomes.$mq$),
($mq$How does a microscope image appear?$mq$, $mq$Upside down and reversed. The slide must be moved the opposite way to the movement wanted in the image.$mq$),
($mq$Rules for a biological drawing$mq$, $mq$Sharp pencil, single clear lines, no shading or colour, labels with straight lines, a title and the magnification.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Using a Light Microscope$mq$ and p.name = $mq$Cells and Microscopy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$A light microscope uses lenses and light to make small objects look larger. Learning to use it correctly is a practical skill that is often tested.

## Parts of the microscope
- Eyepiece lens: you look through it. It is usually x10.
- Objective lenses: mounted on a rotating nosepiece. Common powers are x4, x10 and x40.
- Stage: the platform that holds the slide, usually with clips.
- Light source (lamp or mirror): shines light up through the specimen.
- Diaphragm: controls how much light reaches the specimen.
- Coarse and fine focus knobs: move the lens or stage to bring the image into focus.

## Total magnification
Total magnification = eyepiece magnification x objective magnification. A x10 eyepiece with a x40 objective gives x400. Higher magnification shows a smaller part of the specimen, which is called a smaller field of view.

Magnification and resolution are different. Resolution is how well two close points can be told apart. A light microscope can resolve things down to about 200 nanometres, so very small structures such as ribosomes cannot be seen, however much the image is enlarged.

## How to focus
1. Turn the nosepiece so the lowest-power objective is over the slide.
2. Use the coarse focus knob to bring the lens close to the slide, looking from the side, not through the eyepiece.
3. Look through the eyepiece and turn the coarse focus knob until the image is almost sharp.
4. Use the fine focus knob to sharpen the image.
5. Move the slide to centre the part you want to study, then change to a higher-power lens if needed and use only the fine focus knob.

The image is upside down and reversed. If the cell is at the top left of what you see, the slide must be moved towards the top left to bring it to the middle.

## Preparing a temporary slide
Place a thin piece of tissue, such as a layer of onion epidermis, in a drop of water on a slide. Add a drop of stain such as iodine solution. Lower a coverslip at an angle with a needle so that no air bubbles are trapped. Blot any extra liquid with paper towel. A stain increases contrast, because cells are mostly transparent.

## Making a biological drawing
Use a sharp pencil and draw single, clear lines. Do not use shading or colour. Draw only what you see and make the drawing large. Label with straight lines that do not cross, and give a title and the magnification.

## Worked example
A student looks at a slide with a x10 eyepiece and x4 objective. Total magnification = 10 x 4 = x40. She changes to the x40 objective. New total = 10 x 40 = x400. The cells now look ten times bigger, but fewer cells fit in the field of view.

## Common mistakes
- Mixing up magnification and resolution.
- Adding the two magnifications instead of multiplying.
- Using the coarse knob with a high-power objective, which can break the slide.
- Moving the slide the wrong way because the image is inverted.
- Drawing with shading, sketchy lines or without a title.

## Command terms
- Identify: name a part, such as the diaphragm.
- Describe: give the steps of focusing in order.
- Explain: give reasons, for example explain why the lowest power lens is used first.
- Outline: give a brief summary of how to prepare a slide.

Exam tip: if asked why a step is carried out, give the reason in terms of the problem it prevents, such as air bubbles, a broken slide or a dark image.$mq$ from st;

-- Cells and Microscopy > Magnification and Scale Calculations
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Cells and Microscopy$mq$, 4, 1 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Magnification and Scale Calculations$mq$, 4, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Cells and Microscopy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Magnification and Scale Calculations$mq$ and p.name = $mq$Cells and Microscopy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In the equation magnification = image size ÷ ?, what quantity goes in place of the question mark?$mq$, $mq$["Actual size","Field of view","Lens power","Eyepiece size"]$mq$, 0, $mq$Magnification = image size ÷ actual size. Both sizes must be in the same units.$mq$, $mq$easy$mq$),
($mq$How many micrometres are there in 1 millimetre?$mq$, $mq$["100","10","10000","1000"]$mq$, 3, $mq$There are 1000 micrometres (µm) in 1 millimetre, so you multiply by 1000 to convert millimetres to micrometres.$mq$, $mq$easy$mq$),
($mq$What does the symbol µm stand for?$mq$, $mq$["Millimetre","Nanometre","Micrometre","Centimetre"]$mq$, 2, $mq$µm is the symbol for micrometre, which is one millionth of a metre. Most animal and plant cells are tens of micrometres across.$mq$, $mq$easy$mq$),
($mq$A drawing of a cell is 50 mm wide. The real cell is 5 mm wide. What is the magnification?$mq$, $mq$["x45","x10","x250","x0.1"]$mq$, 1, $mq$Magnification = 50 ÷ 5 = 10, so the drawing is x10.$mq$, $mq$easy$mq$),
($mq$Which unit is most suitable for measuring the width of a typical animal cell?$mq$, $mq$["Micrometres","Metres","Centimetres","Kilometres"]$mq$, 0, $mq$Cells are very small, usually 10 to 100 micrometres across, so micrometres give sensible numbers.$mq$, $mq$easy$mq$),
($mq$An image is 60 mm long and the magnification is x300. What is the actual length in mm?$mq$, $mq$["0.5 mm","5 mm","18000 mm","0.2 mm"]$mq$, 3, $mq$Actual size = image size ÷ magnification = 60 ÷ 300 = 0.2 mm.$mq$, $mq$medium$mq$),
($mq$Convert 0.04 mm to micrometres.$mq$, $mq$["4 µm","400 µm","40 µm","0.4 µm"]$mq$, 2, $mq$Multiply millimetres by 1000: 0.04 x 1000 = 40 µm.$mq$, $mq$medium$mq$),
($mq$A cell is drawn 45 mm long. Its actual length is 0.015 mm. What is the magnification?$mq$, $mq$["x300","x3000","x675","x30"]$mq$, 1, $mq$Magnification = 45 ÷ 0.015 = 3000.$mq$, $mq$medium$mq$),
($mq$A cell is 25 µm wide and viewed with magnification x400. How wide is its image in mm?$mq$, $mq$["10 mm","1 mm","100 mm","0.1 mm"]$mq$, 0, $mq$Image size = actual size x magnification = 25 x 400 = 10,000 µm. Dividing by 1000 gives 10 mm.$mq$, $mq$medium$mq$),
($mq$A photo shows a cell 12 mm wide at a magnification of x400. What is its actual width in µm?$mq$, $mq$["300 µm","3 µm","4800 µm","30 µm"]$mq$, 3, $mq$Actual size = 12 ÷ 400 = 0.03 mm. Multiply by 1000 to get 30 µm.$mq$, $mq$medium$mq$),
($mq$A scale bar is 20 mm long and represents 50 µm. What is the magnification?$mq$, $mq$["x1000","x40","x400","x2.5"]$mq$, 2, $mq$20 mm = 20,000 µm. Magnification = 20,000 ÷ 50 = 400.$mq$, $mq$medium$mq$),
($mq$Convert 3.5 mm to micrometres.$mq$, $mq$["350 µm","3500 µm","35 µm","35000 µm"]$mq$, 1, $mq$Multiply by 1000: 3.5 x 1000 = 3500 µm.$mq$, $mq$medium$mq$),
($mq$A cell appears 5 mm wide in an image magnified x100. What is its actual width in µm?$mq$, $mq$["50 µm","500 µm","5 µm","20 µm"]$mq$, 0, $mq$Actual size = 5 ÷ 100 = 0.05 mm = 50 µm.$mq$, $mq$medium$mq$),
($mq$A photo has a scale bar 15 mm long labelled 30 µm. A cell in the same photo is 45 mm long. What is its actual length?$mq$, $mq$["45 µm","22.5 µm","135 µm","90 µm"]$mq$, 3, $mq$15 mm represents 30 µm, so 1 mm represents 2 µm. The cell is 45 mm, so its actual length is 45 x 2 = 90 µm.$mq$, $mq$hard$mq$),
($mq$A chloroplast is 6 µm long and its image is 3 cm long. What is the magnification?$mq$, $mq$["x500","x18","x5000","x50000"]$mq$, 2, $mq$3 cm = 30 mm = 30,000 µm. Magnification = 30,000 ÷ 6 = 5000.$mq$, $mq$hard$mq$),
($mq$A microscope has a x10 eyepiece and gives a total magnification of x400. What is the power of the objective lens?$mq$, $mq$["x4","x40","x10","x400"]$mq$, 1, $mq$Total = eyepiece x objective, so objective = 400 ÷ 10 = x40.$mq$, $mq$hard$mq$),
($mq$A cell is 50 µm across. How many of these cells would fit in a line across 1 mm?$mq$, $mq$["20","50","200","2"]$mq$, 0, $mq$1 mm = 1000 µm. Number = 1000 ÷ 50 = 20.$mq$, $mq$hard$mq$),
($mq$A drawing of a cell is 36 mm long and the magnification is x240. What is the actual length in µm?$mq$, $mq$["15 µm","1500 µm","8640 µm","150 µm"]$mq$, 3, $mq$Actual = 36 ÷ 240 = 0.15 mm. Multiply by 1000 to get 150 µm.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Magnification and Scale Calculations$mq$ and p.name = $mq$Cells and Microscopy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Magnification equation$mq$, $mq$Magnification = image size ÷ actual size.$mq$),
($mq$Actual size equation$mq$, $mq$Actual size = image size ÷ magnification.$mq$),
($mq$Image size equation$mq$, $mq$Image size = actual size x magnification.$mq$),
($mq$Millimetres to micrometres$mq$, $mq$Multiply by 1000. For example 0.2 mm = 200 µm.$mq$),
($mq$Micrometres to millimetres$mq$, $mq$Divide by 1000. For example 50 µm = 0.05 mm.$mq$),
($mq$What is a micrometre?$mq$, $mq$A unit of length equal to one thousandth of a millimetre. Symbol µm. Cells are tens of micrometres across.$mq$),
($mq$How to use a scale bar$mq$, $mq$Measure the bar in mm, divide the real length it shows by that number to find what 1 mm represents, then measure the specimen and multiply.$mq$),
($mq$Total magnification of a microscope$mq$, $mq$Eyepiece magnification x objective magnification.$mq$),
($mq$Common unit error$mq$, $mq$Not converting to the same unit before using the equation. Convert mm and µm first.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Magnification and Scale Calculations$mq$ and p.name = $mq$Cells and Microscopy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Biologists often need to work out how big a cell really is from a drawing or a photograph, or to say how many times a specimen has been enlarged. This needs one equation, a few unit conversions and careful working.

## The magnification equation
Magnification = image size ÷ actual size

This can be rearranged:
- Actual size = image size ÷ magnification
- Image size = actual size x magnification

A triangle with image size at the top and actual size and magnification at the bottom helps you remember the three versions. Magnification is a ratio, so it has no units, but it is written with an x, such as x400. The image size and actual size must be in the same units before you divide.

## Units of length
- 1 metre = 1000 millimetres (mm)
- 1 mm = 1000 micrometres (µm)
- 1 cm = 10 mm

To change millimetres to micrometres, multiply by 1000. To change micrometres to millimetres, divide by 1000. Most animal and plant cells are 10 to 100 µm across, which is why micrometres are the usual unit.

## Using a scale bar
Many photographs have a scale bar. Measure the bar with a ruler, then use the label to work out how much each millimetre of the photo represents. For example, if a 10 mm bar is labelled 20 µm, then 1 mm of photo is 2 µm of real length. A cell that measures 30 mm on the photo is then 60 µm long.

## Worked example 1
A drawing of a cell is 48 mm long. The student's microscope magnified the cell x200 in the field of view and the drawing was made at the same size as the image.
Actual size = 48 ÷ 200 = 0.24 mm. To convert, 0.24 x 1000 = 240 µm.

## Worked example 2
An amoeba has a diameter of 0.25 mm. A photograph shows it with an image diameter of 75 mm.
Magnification = 75 ÷ 0.25 = 300, so the photo is x300.

## Worked example 3
A chloroplast is 5 µm long and a textbook picture has a magnification of x2000. Image size = 5 x 2000 = 10,000 µm = 10 mm.

## Good practice in calculations
1. Write the equation first.
2. Convert all lengths to the same unit before you substitute.
3. Show each step of working.
4. Give a unit with your final answer, except for magnification.
5. Check the answer is sensible. If you calculate a cell width of 5 metres, you have made a unit error.

## Common mistakes
- Dividing the wrong way round, which gives magnifications less than 1 for an enlarged image.
- Forgetting to convert mm and µm before calculating.
- Dividing by 1000 when multiplying is needed, or the reverse.
- Measuring the scale bar and the cell with different units.
- Adding the eyepiece and objective magnifications, instead of multiplying them.
- Writing the final answer without units.

## Command terms
- Calculate: work out a numerical answer and show your working.
- Determine: use the data given to find the answer, such as measuring a scale bar.
- State: give the unit or the answer only.
- Estimate: give an approximate value, such as how many cells would fit across the field of view.

Exam tip: if you are marked on the working, write the equation, the substitution and the answer with its unit on separate lines.$mq$ from st;

-- Movement of Substances > Diffusion: Rates and Gradients
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Movement of Substances$mq$, 4, 2 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Diffusion: Rates and Gradients$mq$, 4, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Movement of Substances$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Diffusion: Rates and Gradients$mq$ and p.name = $mq$Movement of Substances$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Name the process in which particles spread from a region of high concentration to a region of low concentration.$mq$, $mq$["Diffusion","Osmosis","Active transport","Respiration"]$mq$, 0, $mq$Diffusion is the net movement of particles from where they are more concentrated to where they are less concentrated, down the concentration gradient.$mq$, $mq$easy$mq$),
($mq$Name the gas that diffuses into a leaf for photosynthesis.$mq$, $mq$["Oxygen","Nitrogen","Hydrogen","Carbon dioxide"]$mq$, 3, $mq$Carbon dioxide is used up in photosynthesis, so its concentration is lower inside the leaf and it diffuses in through the stomata.$mq$, $mq$easy$mq$),
($mq$Diffusion needs no energy from the cell. What name is given to a process like this?$mq$, $mq$["Active","Aerobic","Passive","Anaerobic"]$mq$, 2, $mq$A passive process does not need energy from respiration. The energy comes from the random movement of the particles themselves.$mq$, $mq$easy$mq$),
($mq$Name the difference in concentration between two regions that makes particles diffuse.$mq$, $mq$["Pressure barrier","Concentration gradient","Osmotic membrane","Energy store"]$mq$, 1, $mq$A concentration gradient is a difference in concentration. The bigger the difference, the steeper the gradient.$mq$, $mq$easy$mq$),
($mq$Name the gas that diffuses from the air in the alveoli into the blood.$mq$, $mq$["Oxygen","Carbon dioxide","Hydrogen","Helium"]$mq$, 0, $mq$The air in the alveoli has a higher oxygen concentration than the blood arriving from the body, so oxygen diffuses into the blood.$mq$, $mq$easy$mq$),
($mq$How does raising the temperature affect the rate of diffusion?$mq$, $mq$["It decreases","It stays the same","It stops","It increases"]$mq$, 3, $mq$At higher temperatures particles move faster, so they spread out more quickly and diffusion is faster.$mq$, $mq$medium$mq$),
($mq$Name the type of energy that particles gain as the temperature rises, making them move faster.$mq$, $mq$["Chemical energy","Light energy","Kinetic energy","Nuclear energy"]$mq$, 2, $mq$Kinetic energy is the energy of movement. Particles with more kinetic energy move and collide more, so they diffuse faster.$mq$, $mq$medium$mq$),
($mq$Name the tiny air sacs in the lungs that provide a large surface area for gas exchange.$mq$, $mq$["Bronchi","Alveoli","Trachea","Diaphragm"]$mq$, 1, $mq$Millions of alveoli give the lungs a very large surface area, so a lot of oxygen can diffuse into the blood at once.$mq$, $mq$medium$mq$),
($mq$A cube has sides of 2 cm. What is its surface area to volume ratio?$mq$, $mq$["3:1","6:1","1:3","4:1"]$mq$, 0, $mq$Surface area = 6 x 2 x 2 = 24 cm squared. Volume = 2 x 2 x 2 = 8 cm cubed. Ratio = 24 : 8 = 3 : 1.$mq$, $mq$medium$mq$),
($mq$Why are the walls of the alveoli only one cell thick?$mq$, $mq$["Larger surface area","Higher temperature","More energy needed","Short diffusion distance"]$mq$, 3, $mq$A very thin wall means oxygen and carbon dioxide have only a tiny distance to diffuse, which makes diffusion fast.$mq$, $mq$medium$mq$),
($mq$Name the gas produced by photosynthesis that diffuses out of leaves.$mq$, $mq$["Carbon dioxide","Nitrogen","Oxygen","Hydrogen"]$mq$, 2, $mq$Oxygen is a product of photosynthesis. It builds up inside the leaf, so it diffuses out through the stomata.$mq$, $mq$medium$mq$),
($mq$Name the tiny pores on the underside of a leaf through which gases diffuse.$mq$, $mq$["Alveoli","Stomata","Xylem vessels","Villi"]$mq$, 1, $mq$Stomata (singular: stoma) are pores that open and close. They let carbon dioxide in and oxygen and water vapour out.$mq$, $mq$medium$mq$),
($mq$A student puts crystals of potassium permanganate into water at 10, 20, 30 and 40 degrees Celsius and measures how far the colour spreads in 5 minutes. Name the independent variable.$mq$, $mq$["Temperature","Distance spread","Time","Mass of crystal"]$mq$, 0, $mq$The independent variable is the one the student changes on purpose, which is temperature. The distance spread is the dependent variable, and time and crystal mass should be controlled.$mq$, $mq$medium$mq$),
($mq$A cube has sides of 3 cm. What is its surface area to volume ratio?$mq$, $mq$["6:1","3:1","1:2","2:1"]$mq$, 3, $mq$Surface area = 6 x 3 x 3 = 54 cm squared. Volume = 3 x 3 x 3 = 27 cm cubed. Ratio = 54 : 27 = 2 : 1.$mq$, $mq$hard$mq$),
($mq$Why do large animals need specialised gas exchange surfaces such as lungs?$mq$, $mq$["High surface area to volume ratio","Low metabolic rate","Low surface area to volume ratio","Thin skin"]$mq$, 2, $mq$As an organism gets bigger, its volume increases faster than its surface area. The body surface alone cannot supply enough oxygen, so lungs or gills are needed.$mq$, $mq$hard$mq$),
($mq$A cube doubles its side length from 1 cm to 2 cm. What happens to its surface area to volume ratio?$mq$, $mq$["It doubles","It halves","It stays the same","It quarters"]$mq$, 1, $mq$The ratio of a 1 cm cube is 6:1 and of a 2 cm cube is 3:1, so it halves.$mq$, $mq$hard$mq$),
($mq$Deep breathing during exercise brings in more oxygen. What does this do to the oxygen concentration gradient between the alveoli and the blood?$mq$, $mq$["Makes it steeper","Makes it shallower","Removes it","Reverses it"]$mq$, 0, $mq$Fresh air raises the oxygen concentration in the alveoli, while the blood has used oxygen, so the difference grows and diffusion is faster.$mq$, $mq$hard$mq$),
($mq$Carbon dioxide diffuses from respiring muscle cells into the blood. Where is the carbon dioxide concentration higher?$mq$, $mq$["In the blood","They are equal","In the alveoli","In the muscle cells"]$mq$, 3, $mq$Diffusion is down the gradient, from high to low concentration. Muscle cells make carbon dioxide, so the concentration is highest there.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Diffusion: Rates and Gradients$mq$ and p.name = $mq$Movement of Substances$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Diffusion$mq$, $mq$The net movement of particles from a region of higher concentration to a region of lower concentration.$mq$),
($mq$Is diffusion active or passive?$mq$, $mq$Passive. It needs no energy from respiration.$mq$),
($mq$Concentration gradient$mq$, $mq$The difference in concentration between two regions. A steeper gradient gives faster diffusion.$mq$),
($mq$Four factors that affect diffusion rate$mq$, $mq$Concentration gradient, temperature, surface area and diffusion distance.$mq$),
($mq$Why does temperature affect diffusion?$mq$, $mq$Warmer particles have more kinetic energy, move faster and spread more quickly.$mq$),
($mq$How are alveoli adapted for gas exchange?$mq$, $mq$Large surface area, walls one cell thick, a rich blood supply and ventilation to keep a steep concentration gradient.$mq$),
($mq$Surface area of a cube$mq$, $mq$6 x side x side. Volume is side x side x side.$mq$),
($mq$Surface area to volume ratio and size$mq$, $mq$As an organism gets larger, its surface area to volume ratio falls, so it needs specialised exchange surfaces.$mq$),
($mq$Where do gases diffuse in and out of a leaf?$mq$, $mq$Through the stomata. Carbon dioxide diffuses in and oxygen diffuses out during photosynthesis.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Diffusion: Rates and Gradients$mq$ and p.name = $mq$Movement of Substances$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Cells and organisms must exchange substances with their surroundings. Oxygen and glucose must get in, and carbon dioxide and other waste must get out. Many of these movements happen by diffusion.

## What is diffusion?
Diffusion is the net movement of particles from a region of higher concentration to a region of lower concentration. The particles move down the concentration gradient. They move randomly all the time, but more particles move from the crowded area to the empty one than the other way round, so there is a net movement. Diffusion is a passive process because it needs no energy from respiration. It happens in gases and in solutions.

Examples in living things include oxygen moving from the alveoli into the blood, carbon dioxide moving into a leaf, and digested food moving from the small intestine into the blood.

## Factors that affect the rate of diffusion
- Concentration gradient: the steeper the gradient, the faster the diffusion.
- Temperature: warmer particles have more kinetic energy and move faster, so diffusion is faster.
- Surface area: a larger surface lets more particles cross at once.
- Distance: a shorter distance means a faster rate.

## Adaptations for diffusion
The lungs have millions of alveoli, which provide a large surface area. Their walls are one cell thick, which gives a short diffusion distance. They are surrounded by capillaries, and blood flow keeps removing oxygen and bringing carbon dioxide, which maintains a steep concentration gradient. Breathing refreshes the air in the alveoli for the same reason. In the small intestine, villi increase the surface area for absorbing food.

## Surface area to volume ratio
Small organisms have a large surface area compared with their volume, so diffusion across the surface is enough. Large organisms have a small surface area to volume ratio, so they need special surfaces such as lungs and a transport system.

For a cube of side length L: surface area = 6 x L x L, and volume = L x L x L.
- Side 1 cm: area 6, volume 1, ratio 6:1.
- Side 2 cm: area 24, volume 8, ratio 3:1.
- Side 3 cm: area 54, volume 27, ratio 2:1.
As the cube grows, the ratio falls.

## Worked example
An investigation uses agar jelly cubes containing indicator. The cubes are placed in dilute acid and the time for the colour to disappear is measured. A 1 cm cube changes colour faster than a 2 cm cube. Explanation: the 1 cm cube has a larger surface area to volume ratio and a shorter distance for the acid to travel to the centre, so diffusion reaches all of it sooner.

## Common mistakes
- Saying particles "want" to move or that they stop when concentrations are equal. They keep moving, but there is no net movement.
- Confusing diffusion with osmosis. Osmosis is only the diffusion of water across a partially permeable membrane.
- Saying diffusion needs energy from respiration.
- Describing a gradient as the "amount" and not the difference in concentration.
- Forgetting to say "net" when describing movement.

## Command terms
- Define: give the precise meaning of diffusion.
- Describe: say what happens, for example describe how oxygen reaches the blood.
- Explain: give reasons, for example explain why the alveoli are efficient for gas exchange.
- Predict: say what would happen, such as the effect of a higher temperature.
- Calculate: work out the surface area to volume ratio.

Exam tip: in explanations use the phrase "down the concentration gradient" and link each adaptation to a factor: surface area, distance or gradient.$mq$ from st;

-- Movement of Substances > Osmosis in Plant and Animal Cells
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Movement of Substances$mq$, 4, 2 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Osmosis in Plant and Animal Cells$mq$, 4, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Movement of Substances$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Osmosis in Plant and Animal Cells$mq$ and p.name = $mq$Movement of Substances$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Name the process in which water moves across a partially permeable membrane from a dilute solution to a more concentrated solution.$mq$, $mq$["Osmosis","Filtration","Active transport","Transpiration"]$mq$, 0, $mq$Osmosis is the net movement of water across a partially permeable membrane, from a region of higher water concentration (dilute solution) to a region of lower water concentration (concentrated solution).$mq$, $mq$easy$mq$),
($mq$Name the type of membrane that lets small molecules like water through but not larger solute molecules.$mq$, $mq$["Fully permeable","Impermeable","Rigid","Partially permeable"]$mq$, 3, $mq$A partially permeable membrane lets some particles through and blocks others. Cell membranes are partially permeable.$mq$, $mq$easy$mq$),
($mq$Name the word for a plant cell that is firm because it is full of water.$mq$, $mq$["Flaccid","Plasmolysed","Turgid","Burst"]$mq$, 2, $mq$A turgid cell has water pressing against its cell wall. Turgid cells help to support the plant.$mq$, $mq$easy$mq$),
($mq$Which substance moves in osmosis?$mq$, $mq$["Glucose","Water","Oxygen","Salt"]$mq$, 1, $mq$Only water moves in osmosis. Solutes such as salt and sugar cannot cross a partially permeable membrane as easily.$mq$, $mq$easy$mq$),
($mq$A cell is put in a very concentrated salt solution. In which direction does water move by osmosis?$mq$, $mq$["Out of the cell","Into the cell","Nowhere","Into the nucleus"]$mq$, 0, $mq$The solution outside has a lower water concentration than the cell, so water moves out of the cell down its concentration gradient.$mq$, $mq$easy$mq$),
($mq$A potato cylinder is left in distilled water for an hour. What happens to its mass?$mq$, $mq$["It decreases","It stays the same","It doubles exactly","It increases"]$mq$, 3, $mq$Distilled water has a higher water concentration than the potato cells, so water enters the potato by osmosis and the mass goes up.$mq$, $mq$medium$mq$),
($mq$A red blood cell is placed in pure water. What happens to it?$mq$, $mq$["It shrinks","It becomes turgid","It bursts","Nothing happens"]$mq$, 2, $mq$Water enters by osmosis. An animal cell has no cell wall to resist the pressure, so the cell swells and bursts.$mq$, $mq$medium$mq$),
($mq$Name the process in which the cell membrane of a plant cell pulls away from the cell wall in a concentrated solution.$mq$, $mq$["Turgor","Plasmolysis","Lysis","Diffusion"]$mq$, 1, $mq$In a concentrated solution, water leaves the vacuole and cytoplasm. The cell shrinks away from the wall, which is called plasmolysis.$mq$, $mq$medium$mq$),
($mq$Name the structure that stops a plant cell bursting when it takes in water.$mq$, $mq$["Cell wall","Cell membrane","Vacuole","Nucleus"]$mq$, 0, $mq$The strong cellulose cell wall resists the pressure of the swelling cell, so the cell becomes turgid and does not burst.$mq$, $mq$medium$mq$),
($mq$A plant is short of water and its leaves droop. What state are the cells in?$mq$, $mq$["Turgid","Burst","Dividing","Flaccid"]$mq$, 3, $mq$When water is short, cells lose water and their pressure falls. The cells become flaccid and the leaves wilt.$mq$, $mq$medium$mq$),
($mq$Cell A contains 10% sugar solution and cell B contains 20% sugar solution. They touch through a partially permeable membrane. Which way does water move?$mq$, $mq$["From cell B to cell A","It does not move","From cell A to cell B","Only by active transport"]$mq$, 2, $mq$Cell A is more dilute, so it has the higher water concentration. Water moves by osmosis from A to the more concentrated B.$mq$, $mq$medium$mq$),
($mq$A potato cylinder has mass 4.0 g and gains 0.6 g in a solution. What is its percentage change in mass?$mq$, $mq$["13%","15%","6%","60%"]$mq$, 1, $mq$Percentage change = change ÷ original x 100 = 0.6 ÷ 4.0 x 100 = 15%.$mq$, $mq$medium$mq$),
($mq$Why do scientists calculate percentage change in mass in potato osmosis investigations?$mq$, $mq$["To compare cylinders with different starting masses","To remove anomalies","To save time","To make the results larger"]$mq$, 0, $mq$Cylinders never have exactly the same starting mass. A percentage change allows a fair comparison between them.$mq$, $mq$medium$mq$),
($mq$A potato cylinder shows no change in mass in a sugar solution. What does this tell you about the solution?$mq$, $mq$["More concentrated than the cell sap","More dilute than the cell sap","Pure water","Same concentration as the cell sap"]$mq$, 3, $mq$With no net movement of water, the water concentration inside and outside the potato is equal, so the solution matches the concentration of the potato cell sap.$mq$, $mq$hard$mq$),
($mq$A graph of percentage change in mass of potato against sugar concentration crosses the x-axis at 0.25 mol/dm cubed. What does that value estimate?$mq$, $mq$["The boiling point of sugar","The rate of osmosis","Concentration of the potato cell sap","The pH of the potato"]$mq$, 2, $mq$At the point where the change in mass is zero, there is no net osmosis, so the solution is the same concentration as the cell sap.$mq$, $mq$hard$mq$),
($mq$Boiled potato cylinders do not change mass in different sugar solutions. Why?$mq$, $mq$["They contain no water","Their membranes are damaged","Boiling removes their cell wall","They are too cold"]$mq$, 1, $mq$Boiling destroys the partially permeable membranes, so the cells can no longer control water movement.$mq$, $mq$hard$mq$),
($mq$Why is it dangerous to inject pure water into the blood?$mq$, $mq$["Red blood cells would burst","Blood would clot","Blood would turn cold","White cells would shrink"]$mq$, 0, $mq$Pure water has a higher water concentration than the blood cells, so water would enter red blood cells by osmosis until they burst.$mq$, $mq$hard$mq$),
($mq$Why does water move into root hair cells from the soil?$mq$, $mq$["Cell sap has a higher water concentration","Active transport pumps it in","The cells are flaccid","Soil water has a higher water concentration"]$mq$, 3, $mq$Soil water is usually more dilute than the cell sap in root hair cells, so water moves into the cells by osmosis down its concentration gradient.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Osmosis in Plant and Animal Cells$mq$ and p.name = $mq$Movement of Substances$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Osmosis$mq$, $mq$The net movement of water across a partially permeable membrane from a region of higher water concentration to a lower one.$mq$),
($mq$Partially permeable membrane$mq$, $mq$A membrane that lets some small particles, like water, pass but blocks larger solute molecules.$mq$),
($mq$Turgid$mq$, $mq$A plant cell full of water, pushing against its cell wall. It is firm and supports the plant.$mq$),
($mq$Flaccid$mq$, $mq$A plant cell that has lost water and is soft. Many flaccid cells cause wilting.$mq$),
($mq$Plasmolysis$mq$, $mq$When the membrane pulls away from the cell wall because the cell has lost a lot of water.$mq$),
($mq$Why does a red blood cell burst in pure water?$mq$, $mq$Water enters by osmosis and the animal cell has no cell wall to resist swelling.$mq$),
($mq$Percentage change in mass$mq$, $mq$(final mass - starting mass) ÷ starting mass x 100.$mq$),
($mq$Variables in a potato osmosis experiment$mq$, $mq$Independent: solution concentration. Dependent: change in mass. Control: volume, time, temperature, potato type and cylinder size.$mq$),
($mq$No change in mass of a potato cylinder$mq$, $mq$There is no net movement of water, so the solution has the same concentration as the potato cell sap.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Osmosis in Plant and Animal Cells$mq$ and p.name = $mq$Movement of Substances$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Osmosis is a very important process because it controls how much water is inside cells. It explains why plants wilt, why potato chips go limp and soft in very salty water, and why red blood cells must be kept in the correct solution.

## What is osmosis?
Osmosis is the net movement of water molecules across a partially permeable membrane from a region of higher water concentration to a region of lower water concentration. A dilute solution has a high water concentration. A concentrated solution has a low water concentration. So water moves from the dilute solution to the concentrated solution. Osmosis is a type of diffusion and is passive.

The membrane is partially permeable: small water molecules pass through, but larger solute molecules, such as sugar, cannot easily cross.

## Osmosis in plant cells
- In a dilute solution or pure water, water enters the cell. The vacuole swells and pushes the cell membrane against the cell wall. The cell becomes turgid. The wall stops the cell bursting. Turgid cells support leaves and soft stems.
- In a concentrated solution, water leaves the cell. The cell becomes flaccid. If it loses even more water, the membrane pulls away from the wall, which is called plasmolysis.
- Wilting happens when many cells in a plant lose water and become flaccid.

## Osmosis in animal cells
Animal cells have no cell wall. In pure water, a red blood cell takes in water and bursts. In a concentrated solution, it loses water and shrinks and becomes crinkled. This is why medical drips contain a solution with the same concentration as the blood.

## Potato investigation
Potato cylinders are cut with a cork borer, blotted dry, weighed and placed in different sugar solutions for a set time. They are blotted and weighed again.
- Independent variable: the sugar concentration.
- Dependent variable: the change in mass.
- Control variables: the volume of solution, the temperature, the time, the type of potato and the length of the cylinder.
Percentage change in mass = (final mass - starting mass) ÷ starting mass x 100.

Worked example: A cylinder starts at 3.2 g and ends at 2.8 g. Change = -0.4 g. Percentage change = -0.4 ÷ 3.2 x 100 = -12.5%. The negative sign shows it lost water, so the solution was more concentrated than the potato cells.

If the graph of percentage change against concentration crosses zero at 0.3 mol/dm cubed, then at that concentration there is no net movement of water, and the cell sap is about the same concentration.

## Common mistakes
- Saying that "water moves to where there is less water" without mentioning concentration. Use "from a higher to a lower water concentration".
- Saying that osmosis involves sugar moving. It does not.
- Forgetting to blot the cylinders before weighing, which adds extra water mass.
- Saying a plant cell bursts. The wall protects it.
- Calculating a percentage change using the final mass instead of the starting mass.

## Command terms
- Define: give the exact meaning of osmosis.
- Explain: link the change to water concentration and the membrane.
- Predict: say what will happen to the mass of a cylinder in a concentrated solution.
- Evaluate: judge how reliable the potato results are, for example by repeating and calculating a mean.

Exam tip: in osmosis explanations, always state the direction of water movement and mention the partially permeable membrane.$mq$ from st;

-- Movement of Substances > Active Transport and Mineral Uptake
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Movement of Substances$mq$, 4, 2 from public.subjects s where s.slug = $mq$biology$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Active Transport and Mineral Uptake$mq$, 4, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$biology$mq$ and p.grade = 4 and p.name = $mq$Movement of Substances$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Active Transport and Mineral Uptake$mq$ and p.name = $mq$Movement of Substances$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 4, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Name the process that uses energy to move substances from a low concentration to a high concentration.$mq$, $mq$["Active transport","Diffusion","Osmosis","Evaporation"]$mq$, 0, $mq$Active transport moves particles against the concentration gradient and needs energy from respiration.$mq$, $mq$easy$mq$),
($mq$Name the process that supplies the energy for active transport.$mq$, $mq$["Photosynthesis","Digestion","Osmosis","Respiration"]$mq$, 3, $mq$Cells release energy from glucose by respiration, and this energy is used to power active transport.$mq$, $mq$easy$mq$),
($mq$Name the cells in a plant that absorb water and mineral ions from the soil.$mq$, $mq$["Palisade cells","Guard cells","Root hair cells","Red blood cells"]$mq$, 2, $mq$Root hair cells have long extensions that give a large surface area for absorbing water and minerals.$mq$, $mq$easy$mq$),
($mq$Name the mineral ion that plants absorb to make amino acids and proteins.$mq$, $mq$["Sodium","Nitrate","Chloride","Iodide"]$mq$, 1, $mq$Plants combine nitrate from the soil with sugars to make amino acids, which are then built into proteins.$mq$, $mq$easy$mq$),
($mq$Name the mineral ion that plants need to make chlorophyll.$mq$, $mq$["Magnesium","Sodium","Iodide","Fluoride"]$mq$, 0, $mq$Each chlorophyll molecule has a magnesium ion at its centre. Without magnesium, leaves turn yellow.$mq$, $mq$easy$mq$),
($mq$Active transport requires something that diffusion does not. What is it?$mq$, $mq$["Light","A concentration gradient","Water","Energy"]$mq$, 3, $mq$Diffusion is passive, but active transport needs energy from respiration to move particles against the gradient.$mq$, $mq$medium$mq$),
($mq$Cells that carry out a lot of active transport contain many of which organelle?$mq$, $mq$["Chloroplasts","Cell walls","Mitochondria","Vacuoles"]$mq$, 2, $mq$Mitochondria release energy in aerobic respiration, so cells that need a lot of energy for active transport have many of them.$mq$, $mq$medium$mq$),
($mq$Plants in waterlogged soil take up fewer minerals. Which process is reduced because there is little oxygen in the soil?$mq$, $mq$["Osmosis","Aerobic respiration","Photosynthesis","Diffusion"]$mq$, 1, $mq$Roots need oxygen for aerobic respiration. With little oxygen, they release less energy, so active transport of minerals slows down.$mq$, $mq$medium$mq$),
($mq$Name the part of the digestive system where glucose is absorbed into the blood by diffusion and active transport.$mq$, $mq$["Small intestine","Stomach","Large intestine","Oesophagus"]$mq$, 0, $mq$The lining of the small intestine has villi and cells that can absorb glucose even when its concentration in the blood is higher than in the gut.$mq$, $mq$medium$mq$),
($mq$Why do root hair cells have long, thin extensions?$mq$, $mq$["To store starch","To carry out photosynthesis","To hold the plant upright","To increase surface area"]$mq$, 3, $mq$A larger surface area allows more water and mineral ions to be absorbed in a given time.$mq$, $mq$medium$mq$),
($mq$The nitrate concentration in a root hair cell is higher than in the soil. Name the process that moves nitrate ions into the cell.$mq$, $mq$["Diffusion","Osmosis","Active transport","Transpiration"]$mq$, 2, $mq$Nitrate moves from the lower soil concentration to the higher concentration in the cell, against the gradient, so it needs active transport.$mq$, $mq$medium$mq$),
($mq$Name the tissue that carries mineral ions upwards from the roots.$mq$, $mq$["Phloem","Xylem","Stomata","Cuticle"]$mq$, 1, $mq$Xylem vessels carry water and dissolved mineral ions from the roots to the leaves. Phloem carries sugars.$mq$, $mq$medium$mq$),
($mq$Cyanide is a poison that stops respiration. What happens to active transport in cells exposed to it?$mq$, $mq$["It stops","It speeds up","It stays the same","It reverses"]$mq$, 0, $mq$Active transport relies on energy from respiration. If respiration stops, no energy is available, so active transport stops.$mq$, $mq$medium$mq$),
($mq$Name the type of molecules in the cell membrane that bind to particles and carry them across during active transport.$mq$, $mq$["Cellulose fibres","Fat droplets","Chromosomes","Carrier proteins"]$mq$, 3, $mq$Carrier proteins in the membrane pick up a specific particle, then use energy to change shape and release it on the other side.$mq$, $mq$hard$mq$),
($mq$Mineral uptake by roots rises as oxygen supply increases, but then levels off even with more oxygen. What is a likely reason?$mq$, $mq$["Oxygen is toxic","Roots stop respiring","Limited number of carrier proteins","Diffusion takes over"]$mq$, 2, $mq$When all of the carrier proteins are working at their maximum speed, extra oxygen and energy cannot increase the rate any further.$mq$, $mq$hard$mq$),
($mq$Of active transport, osmosis, muscle contraction and protein synthesis, which needs no energy from respiration?$mq$, $mq$["Active transport","Osmosis","Muscle contraction","Protein synthesis"]$mq$, 1, $mq$Osmosis is a passive process driven by the movement of water molecules. The other three all need energy released in respiration.$mq$, $mq$hard$mq$),
($mq$Why do the cells that absorb food from the small intestine have many mitochondria?$mq$, $mq$["To release energy for active transport","To digest food","To store starch","To make enzymes"]$mq$, 0, $mq$Active transport of glucose and amino acids needs energy, which is released in the mitochondria by aerobic respiration.$mq$, $mq$hard$mq$),
($mq$A student compares nitrate uptake by roots with and without oxygen bubbled into the water. Name the independent variable.$mq$, $mq$["Nitrate uptake","Mass of the roots","Temperature","Oxygen supply"]$mq$, 3, $mq$The independent variable is what the student deliberately changes, which is whether oxygen is supplied. Nitrate uptake is the dependent variable.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Active Transport and Mineral Uptake$mq$ and p.name = $mq$Movement of Substances$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 4, v.front, v.back
from st, (values
($mq$Active transport$mq$, $mq$Movement of particles against the concentration gradient, from low to high concentration, using energy from respiration.$mq$),
($mq$Carrier protein$mq$, $mq$A protein in the cell membrane that binds a specific particle and moves it across during active transport.$mq$),
($mq$Source of energy for active transport$mq$, $mq$Respiration, which takes place in the mitochondria.$mq$),
($mq$How are root hair cells adapted?$mq$, $mq$Long extensions for a large surface area, a thin wall, and many mitochondria for active transport.$mq$),
($mq$Why do plants need nitrate?$mq$, $mq$To make amino acids and then proteins. A shortage causes poor growth.$mq$),
($mq$Why do plants need magnesium?$mq$, $mq$To make chlorophyll. A shortage causes yellow leaves.$mq$),
($mq$Why does waterlogged soil reduce mineral uptake?$mq$, $mq$Little oxygen means less aerobic respiration, so less energy is available for active transport.$mq$),
($mq$Diffusion versus active transport$mq$, $mq$Diffusion goes down the gradient and needs no energy. Active transport goes against the gradient and needs energy.$mq$),
($mq$Where in humans does active transport absorb glucose?$mq$, $mq$In the small intestine lining, when the glucose concentration in the gut is lower than in the blood.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$biology$mq$ and t.grade = 4 and t.name = $mq$Active Transport and Mineral Uptake$mq$ and p.name = $mq$Movement of Substances$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Sometimes cells need to take in substances even though their concentration inside the cell is already higher than outside. Diffusion cannot do this because it only moves particles down the concentration gradient. In these cases cells use active transport.

## What is active transport?
Active transport is the movement of particles across a membrane from a region of lower concentration to a region of higher concentration, which is against the concentration gradient. It needs energy from respiration, and it uses carrier proteins in the cell membrane. A carrier protein picks up a specific particle on one side, changes shape using energy, and releases it on the other side.

## Comparing diffusion, osmosis and active transport
- Diffusion: from high to low concentration, passive, needs no energy.
- Osmosis: only water, across a partially permeable membrane, from high to low water concentration, passive.
- Active transport: from low to high concentration, needs energy, uses carrier proteins.

## Active transport in plants
Mineral ions such as nitrate and magnesium are present in the soil in low concentrations. Root hair cells take them in against the gradient by active transport. This is important because:
- Nitrate is used to make amino acids and then proteins. A shortage causes stunted growth and yellow older leaves.
- Magnesium is needed to make chlorophyll. A shortage causes yellow leaves.
The ions then move upwards in the xylem.

Root hair cells are adapted for uptake. They have a very large surface area from their long extensions, a thin wall, and many mitochondria to supply energy.

Waterlogged soil has little oxygen. Roots cannot respire aerobically, so they release less energy and take up fewer minerals. This is why plants in flooded fields can show signs of mineral deficiency.

## Active transport in humans
In the small intestine, glucose is absorbed by diffusion when its concentration in the gut is high. When the concentration in the gut is lower than in the blood, glucose is absorbed by active transport. Cells in the lining have many mitochondria for this reason.

## Worked example
A student places roots in a nitrate solution. Roots with air bubbled through take up 12 units of nitrate per hour, and roots with no air take up 3 units per hour. Explain the difference. Answer: with air, there is more oxygen for aerobic respiration, so more energy is released, which allows more active transport of nitrate into the roots.

A second example: if the nitrate concentration inside a root hair cell is 40 units and in the soil 10 units, diffusion would move the ion out of the root. Because the plant still takes it in, it must be active transport.

## Common mistakes
- Saying that active transport "makes" energy. It uses energy.
- Saying that the particles move down the gradient.
- Writing that plants take in minerals by osmosis. Osmosis is for water only.
- Forgetting to mention respiration as the source of energy.
- Mixing up xylem (water and minerals) and phloem (sugars).

## Command terms
- State: name the process or ion.
- Describe: give features of active transport.
- Compare: give similarities and differences of diffusion and active transport.
- Suggest: use your knowledge to give a reason for a new situation, such as flooded fields.

Exam tip: to prove that a process is active transport, show two things: movement against the concentration gradient, and a need for energy from respiration.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('biology')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;