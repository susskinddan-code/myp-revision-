-- Part 3 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Techniques and Media > Drawing and Painting
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Techniques and Media$mq$, 5, 3 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Drawing and Painting$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Techniques and Media$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Drawing and Painting$mq$ and p.name = $mq$Techniques and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which drawing medium is made from soft, dark material that smudges easily and is good for rich tones?$mq$, $mq$["Charcoal","Ballpoint pen","Hard pencil (4H)","Fineliner"]$mq$, 0, $mq$Charcoal is soft and smudgy, ideal for broad tonal work. Hard pencils (H grades) give pale, precise lines.$mq$, $mq$easy$mq$),
($mq$What is hatching in drawing?$mq$, $mq$["Blending with a finger","Dotting with a brush","Cutting paper","Closely spaced parallel lines used to build tone"]$mq$, 3, $mq$Hatching uses parallel lines; cross-hatching adds layers crossing at angles to deepen tone.$mq$, $mq$easy$mq$),
($mq$Which pencil grade is the softest and darkest?$mq$, $mq$["2H","HB","6B","4H"]$mq$, 2, $mq$B pencils are soft and dark (higher number = softer/darker); H pencils are hard and light.$mq$, $mq$easy$mq$),
($mq$What is a wash in watercolour painting?$mq$, $mq$["A thick layer of opaque paint","A thin, transparent layer of diluted paint","A dry brush texture","A paper collage"]$mq$, 1, $mq$A wash is a diluted layer that spreads smoothly; watercolour relies on transparent layers.$mq$, $mq$easy$mq$),
($mq$Which of these is a water-based, fast-drying paint that can be used thickly or diluted?$mq$, $mq$["Acrylic","Oil paint","Charcoal","Etching ink"]$mq$, 0, $mq$Acrylic is water-based and dries quickly. Oil paint dries slowly and is thinned with oil or solvent.$mq$, $mq$easy$mq$),
($mq$Which technique involves painting a thick, textured layer of paint that stands out from the surface?$mq$, $mq$["Wash","Glaze","Sfumato","Impasto"]$mq$, 3, $mq$Impasto leaves visible brushstrokes or palette-knife marks, as seen in van Gogh.$mq$, $mq$medium$mq$),
($mq$A student wants to paint a smooth sky gradient from deep blue to pale blue. Which technique is most suitable?$mq$, $mq$["Stippling","Dry brush","Blending wet paint together","Hatching"]$mq$, 2, $mq$Blending while paint is wet gives smooth transitions. Stippling and dry brush leave visible texture.$mq$, $mq$medium$mq$),
($mq$What is a glaze in oil painting?$mq$, $mq$["A thick layer with a knife","A thin, transparent layer applied over a dry layer to deepen colour","A masking technique","A coat of varnish only"]$mq$, 1, $mq$Glazing builds luminous colour with transparent layers over dry paint.$mq$, $mq$medium$mq$),
($mq$Which tool lets you lift pencil or charcoal to create highlights?$mq$, $mq$["A putty (kneaded) eraser","A palette knife","A roller","A sponge brush"]$mq$, 0, $mq$A kneaded eraser can be shaped to lift tone, making highlights.$mq$, $mq$medium$mq$),
($mq$A student draws a still life using hatching, then cross-hatching on the shadow side. What is the purpose?$mq$, $mq$["To make the shadow lighter","To change the drawing into a print","To make the paper waterproof","To increase the darkness of the shadow gradually"]$mq$, 3, $mq$Layers of crossing lines deepen tone and describe form.$mq$, $mq$medium$mq$),
($mq$Why do painters often start with a mid-tone ground instead of white canvas?$mq$, $mq$["It makes paint dry faster","It removes the need for drawing","It makes judging light and dark values easier","It hides all mistakes"]$mq$, 2, $mq$A mid-tone ground lets you add both darks and lights and see their relationship.$mq$, $mq$medium$mq$),
($mq$What does 'wet-on-wet' watercolour create?$mq$, $mq$["Sharp crisp lines","Soft, blended edges as colours bleed into each other","A thick impasto effect","A pencil texture"]$mq$, 1, $mq$Painting onto a damp surface lets pigments spread, creating soft, atmospheric effects.$mq$, $mq$medium$mq$),
($mq$In oil painting, 'fat over lean' is a rule. What does it mean?$mq$, $mq$["Each layer should contain more oil than the layer below","Use more water in upper layers","Apply the thickest paint first","Use charcoal on top"]$mq$, 0, $mq$Layers with more oil dry more slowly and flexibly; fat over lean prevents cracking.$mq$, $mq$medium$mq$),
($mq$A student wants fine, controlled detail in a portrait drawing. Which combination is best?$mq$, $mq$["A broad charcoal stick only","A large house-painting brush","Thick poster paint","A range of graphite pencils and a sharp point"]$mq$, 3, $mq$Graphite pencils allow control and subtle tonal change.$mq$, $mq$hard$mq$),
($mq$A watercolour looks muddy and overworked. Which cause is most likely?$mq$, $mq$["Using a clean brush","Leaving areas of white paper","Too many layers or too many mixed colours disturbing the underlying paint","Using fewer colours"]$mq$, 2, $mq$Watercolour is best with fewer, confident washes. Overmixing, especially complements, makes colours dull.$mq$, $mq$hard$mq$),
($mq$A painter uses 'scumbling' by dragging a thin, dry, opaque layer over a darker one. What effect results?$mq$, $mq$["A smooth glaze","A broken, textured veil of colour","A solid flat coat","A printed repeat"]$mq$, 1, $mq$Scumbling gives soft, broken, atmospheric texture as the underlayer shows through.$mq$, $mq$hard$mq$),
($mq$Which choice shows a good reason to use acrylic instead of oil paint in a short school project?$mq$, $mq$["Acrylic dries quickly and cleans with water, allowing several layers in a lesson","Acrylic never needs brushes","Acrylic cannot be mixed","Acrylic is always more expensive"]$mq$, 0, $mq$Practical factors such as drying time, cleaning and safety affect media choices.$mq$, $mq$hard$mq$),
($mq$Two sketches of an apple are compared. Sketch A is outline only. Sketch B uses soft shading and a cast shadow. Which statement is most accurate?$mq$, $mq$["A shows form while B is flat","Both show the same value range","A uses more tone","B shows form and light, while A shows only shape"]$mq$, 3, $mq$Tonal modelling suggests volume, light direction and ground contact.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Drawing and Painting$mq$ and p.name = $mq$Techniques and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Pencil grades$mq$, $mq$H = hard and light; B = soft and dark; HB is in the middle. 6B is much darker and softer than 2H.$mq$),
($mq$Hatching vs cross-hatching$mq$, $mq$Hatching: parallel lines building tone. Cross-hatching: layers of lines crossing at angles for darker tone.$mq$),
($mq$Stippling$mq$, $mq$Building tone with dots: more dots mean a darker area.$mq$),
($mq$Wash$mq$, $mq$A thin, transparent layer of diluted paint, used mostly in watercolour.$mq$),
($mq$Wet-on-wet$mq$, $mq$Painting onto a damp surface so colours bleed, giving soft blended edges.$mq$),
($mq$Impasto$mq$, $mq$Thick paint that stands out from the surface and shows brush or palette-knife marks.$mq$),
($mq$Glazing$mq$, $mq$Thin transparent layers over dry paint to deepen colour and create luminosity.$mq$),
($mq$Acrylic vs oil$mq$, $mq$Acrylic is water-based and fast-drying. Oil is slow-drying, needs oil/solvent, and follows the rule 'fat over lean'.$mq$),
($mq$Tonal modelling$mq$, $mq$Shading from light to dark to create the illusion of three-dimensional form.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Drawing and Painting$mq$ and p.name = $mq$Techniques and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Drawing and painting are the oldest and most widely used ways of making images. In MYP Arts you build skills by experimenting with different media, understanding how each behaves, and choosing the right one to communicate your ideas. This is the heart of criterion B, Developing skills.

## Drawing media
- **Graphite pencils**: graded from hard (H, light and precise) to soft (B, dark and smooth). A set from 2H to 6B lets you build a full range of tone. HB sits in the middle.
- **Charcoal**: soft, dark and smudgy; excellent for bold tonal work and expressive marks. It needs fixing with spray to prevent smudging.
- **Pastels and chalk**: bring colour and soft blending; oil pastels are waxy and blend with pressure.
- **Ink and pens**: give crisp lines and strong contrast; they are hard to erase, so confident marks matter.
- **Erasers** are drawing tools too. A putty eraser lifts tone to create highlights.

## Drawing techniques
- **Hatching**: parallel lines to build tone.
- **Cross-hatching**: layers of lines crossing at angles for darker tone.
- **Stippling**: dots; the more dots, the darker the area.
- **Blending**: smoothing tone with a finger, tissue or blending stump.
- **Contour drawing**: line following the edge and shape of a subject.
- **Gesture drawing**: quick, flowing lines capturing movement.
- **Tonal modelling**: shading from light to dark to create the illusion of form.

## Painting media
- **Watercolour**: transparent, water-based. Work from light to dark, keep the white of the paper for highlights, and avoid overworking. Wet-on-wet gives soft blends; wet-on-dry gives crisp edges. A **wash** is a diluted layer.
- **Acrylic**: water-based, fast-drying and versatile; can be thin like watercolour or thick like oil. Dried acrylic is waterproof.
- **Oil paint**: slow-drying, rich and blendable. Follow the rule of **fat over lean** (more oil in upper layers) to avoid cracking. Needs ventilation and proper cleaning.
- **Gouache / poster paint**: opaque, matte, water-based; good for flat colour.

## Painting techniques
- **Impasto**: thick paint showing brush or knife marks.
- **Glazing**: thin transparent layers over dry paint to deepen colour.
- **Scumbling**: a thin dry opaque layer dragged over another to create a broken effect.
- **Dry brush**: a brush with little paint creating scratchy texture.
- **Blending**: moving wet paint together to make smooth gradients.
Use a mid-tone ground when you want to work both up to light and down to dark.

## Choosing media
Choose according to your intention and practical limits. Want soft, misty atmosphere? Watercolour wet-on-wet. Want bold texture? Impasto acrylic. Short lesson? Acrylic dries fast. Always test on a small sample first, record what you learn and note health and safety needs such as ventilation, cleaning and not putting brushes in the mouth.

## Common mistakes
- Using only outline and ignoring tone.
- Overworking watercolour until it goes muddy.
- Confusing a glaze (thin and transparent) with impasto (thick).
- Not testing mixes and layers before committing to the final piece.

## How this is examined
Questions ask you to match a technique to an effect, pick a suitable medium for a stated intention, or diagnose a problem in a described piece of work. Use correct names and give reasons.

Exam tip: whenever you choose a medium, justify it with a quality of the medium and the effect you want, for example 'wet-on-wet watercolour for soft, hazy edges'.$mq$ from st;

-- Techniques and Media > Printmaking, Sculpture and Mixed Media
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Techniques and Media$mq$, 5, 3 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Printmaking, Sculpture and Mixed Media$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Techniques and Media$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Printmaking, Sculpture and Mixed Media$mq$ and p.name = $mq$Techniques and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which printmaking method uses a block with parts cut away so the raised areas take the ink?$mq$, $mq$["Relief printing (such as lino cut)","Etching","Photography","Watercolour wash"]$mq$, 0, $mq$In relief printing, the surface is carved and the raised parts hold ink. Etching holds ink in grooves.$mq$, $mq$easy$mq$),
($mq$What is an edition in printmaking?$mq$, $mq$["A single unique painting","A type of canvas","A drawing tool","A set of prints made from the same plate or block"]$mq$, 3, $mq$Prints in an edition are usually numbered, such as 3/20.$mq$, $mq$easy$mq$),
($mq$Which of these is a 3D process that involves adding material, such as clay or plaster, to build a form?$mq$, $mq$["Carving","Etching","Modelling","Cyanotype"]$mq$, 2, $mq$Modelling builds up soft material. Carving removes material, and assembling joins parts.$mq$, $mq$easy$mq$),
($mq$What does 'carving' mean in sculpture?$mq$, $mq$["Pouring molten metal into a mould","Removing material from a solid block to reveal a form","Joining found objects","Photographing a form"]$mq$, 1, $mq$Carving is subtractive; modelling is additive.$mq$, $mq$easy$mq$),
($mq$Which is an example of mixed media?$mq$, $mq$["An artwork combining paint, fabric and paper collage","A pencil drawing using only graphite","A single oil painting without additions","A photograph with no editing"]$mq$, 0, $mq$Mixed media combines more than one medium in a single piece.$mq$, $mq$easy$mq$),
($mq$What is a collagraph plate usually made from?$mq$, $mq$["Pure silver","Glass","Digital pixels","Card and textured materials glued onto a base"]$mq$, 3, $mq$Collagraph plates are built by sticking textured items onto a board, then inked and printed.$mq$, $mq$medium$mq$),
($mq$When printing a lino block with a roller, what mistake would cause a patchy print?$mq$, $mq$["Using the correct pressure","Using clean paper","Uneven or too little ink on the block","Using an inked roller"]$mq$, 2, $mq$Even ink coverage is needed for a solid print. Too little or uneven ink gives a patchy effect.$mq$, $mq$medium$mq$),
($mq$A student wants to make a sculpture that is lightweight, easy to shape and cheap. Which material is the best choice?$mq$, $mq$["Marble","Cardboard or papier-mâché","Cast bronze","Granite"]$mq$, 1, $mq$Cardboard and papier-mâché are accessible and light. Stone and bronze are heavy, costly and need specialist skills.$mq$, $mq$medium$mq$),
($mq$In printmaking, why is the image on the block reversed in the final print?$mq$, $mq$["The print is a mirror image of the block","The ink dries backward","The paper bends it","It does not reverse"]$mq$, 0, $mq$Printing transfers the block face-down, so left and right are flipped. Text must be carved in reverse.$mq$, $mq$medium$mq$),
($mq$What is the purpose of an armature in clay or plaster sculpture?$mq$, $mq$["To add colour","To act as a signature","To smooth the surface","To provide an internal support structure"]$mq$, 3, $mq$Armatures made of wire or wood support the weight of soft material while it is built.$mq$, $mq$medium$mq$),
($mq$Which is a safety rule when working with lino-cutting tools?$mq$, $mq$["Cut towards your hand for control","Hold the block in the air","Always cut away from your body and keep the other hand behind the tool","Test sharpness on your finger"]$mq$, 2, $mq$Safe cutting direction and hand placement prevent injuries.$mq$, $mq$medium$mq$),
($mq$An artist glues found objects like keys and buttons onto a board to make an image. What is this technique called?$mq$, $mq$["Etching","Assemblage","Impasto","Lithography"]$mq$, 1, $mq$Assemblage builds 3D or relief artworks by combining found objects.$mq$, $mq$medium$mq$),
($mq$A student's lino print has unwanted ink in areas that should be white. What is the most likely cause?$mq$, $mq$["Background areas were not cut deeply enough, so they picked up ink","Too much cutting","Too little paper","Over-diluted paint"]$mq$, 0, $mq$Shallow cutting leaves the surface high enough to catch the roller, so it prints.$mq$, $mq$medium$mq$),
($mq$Why might an artist choose mixed media for a piece about memory?$mq$, $mq$["Mixed media cannot show ideas","Mixed media is always cheaper","Only one material can express memory","Different textures and materials can represent layers of experience"]$mq$, 3, $mq$Layering materials can symbolise accumulation, fragments or changes over time.$mq$, $mq$hard$mq$),
($mq$In a reduction print, the block is carved and printed several times. What happens to the block between colours?$mq$, $mq$["It is replaced by a new block","It is washed and left unchanged","More of it is cut away, so earlier colours are preserved","It is turned to a photograph"]$mq$, 2, $mq$Reduction printing removes more of the block after each colour. It cannot be repeated once complete, so planning is vital.$mq$, $mq$hard$mq$),
($mq$A student wants to print a three-colour design. Which approach helps keep colours aligned?$mq$, $mq$["Place paper by eye each time","Use registration marks or a template to place paper consistently","Print from different blocks randomly","Rotate the block after each colour"]$mq$, 1, $mq$Registration keeps layers aligned to avoid blurred or offset prints.$mq$, $mq$hard$mq$),
($mq$A sculptor wants an outdoor piece that survives rain. Which factor is most important when choosing the material?$mq$, $mq$["Weather-resistance and durability","Whether it smudges","Whether it is edible","Whether it is transparent"]$mq$, 0, $mq$Outdoor works need materials that resist moisture, UV and temperature changes.$mq$, $mq$hard$mq$),
($mq$Which statement about 3D art is most accurate?$mq$, $mq$["It only needs one viewing angle","It cannot use texture","It does not need a plan","It must be considered from many viewpoints, so form, balance and structure matter"]$mq$, 3, $mq$Sculpture exists in space and is viewed from all sides, so planning for stability and viewpoints is key.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Printmaking, Sculpture and Mixed Media$mq$ and p.name = $mq$Techniques and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Relief printing$mq$, $mq$Raised parts of a carved block take the ink (lino, woodcut). Cut-away parts stay the paper colour.$mq$),
($mq$Intaglio$mq$, $mq$Ink held in grooves cut or scratched into a plate (etching, drypoint), wiped clean on the surface and printed with strong pressure.$mq$),
($mq$Edition$mq$, $mq$A set of prints made from the same plate or block, usually numbered such as 3/20.$mq$),
($mq$Why is a print reversed?$mq$, $mq$The block is pressed face-down, so the printed image is a mirror image of the block.$mq$),
($mq$Registration marks$mq$, $mq$Guides that help align paper accurately when printing several colours or layers.$mq$),
($mq$Four sculpture processes$mq$, $mq$Carving (subtractive), modelling (additive), casting and assembling (including assemblage).$mq$),
($mq$Armature$mq$, $mq$An internal frame, e.g. wire or wood, supporting soft material such as clay or plaster while it is built.$mq$),
($mq$Mixed media$mq$, $mq$Combining different materials, such as paint, paper, fabric and found objects, in one artwork.$mq$),
($mq$Collage$mq$, $mq$Gluing pieces of paper, fabric or other materials onto a surface to build an image.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Printmaking, Sculpture and Mixed Media$mq$ and p.name = $mq$Techniques and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Beyond drawing and painting, artists use printmaking, sculpture and mixed media to explore ideas in new ways. These areas ask you to think about process, planning and materials. They are great for criterion B (Developing skills) because your technical control shows clearly.

## Printmaking
Printmaking means making an image on a plate or block that can be transferred to paper or fabric again and again. A set of identical prints is an **edition**, usually numbered (for example 4/15). Main methods:
- **Relief printing** (lino cut, woodcut): areas are cut away and the raised surface takes the ink. What you cut away stays the colour of the paper.
- **Intaglio** (etching, drypoint): ink sits in grooves cut or scratched into a plate and is wiped from the surface, then printed with heavy pressure.
- **Collagraph**: a plate built up from card and textured materials.
- **Screen printing**: ink is pushed through a mesh with a stencil.
- **Monoprint**: a one-off print.
Key points: the image is reversed (mirror image) when printed, so plan text and compositions accordingly. Use a roller for even ink, check pressure, and use registration marks when printing more than one colour. In a **reduction print**, the block is cut further after each colour. Cut away from your body, keep your other hand behind the tool, and use a bench hook.

## Sculpture
Sculpture is three-dimensional art. Four broad processes:
- **Carving** (subtractive): removing material from a block, such as wood or soft stone.
- **Modelling** (additive): building up soft material like clay or plaster.
- **Casting**: pouring liquid material into a mould that hardens.
- **Assembling / construction**: joining parts, including found objects (assemblage).
Sculptors think about **form, balance, structure and viewpoint**; the work will be seen from all sides. An **armature** (a frame inside) supports soft material. Choose materials for weight, cost, ease and durability, and think about whether the piece will be outdoors.

## Mixed media and collage
Mixed media combines different materials in one artwork, such as paint, fabric, paper, ink and found objects. **Collage** glues pieces onto a surface. Mixed media allows layering of texture and meaning, for instance to represent memory, culture or change. To make mixed media cohesive, link materials through colour, repeated shapes or theme (unity). Check that adhesives suit the materials and that work is stable.

## Choosing and justifying
Ask: What do I want to say? Which process suits this idea and my skills? What materials are available and safe? Test small samples first, record results in your process journal and refine.

## Common mistakes
- Forgetting that prints are mirror images.
- Cutting too shallowly so backgrounds print.
- Choosing materials that cannot support the form or weather.
- Piling materials without unity or purpose in mixed media.

## How this is examined
Questions describe a process or problem and ask for the correct term, the likely cause of a fault, or the best material for a purpose. You are also asked to justify choices.

Exam tip: name the process, give the material property that matters, and link it to your idea. 'Papier-mâché is light and quick to build, which suits a large, hollow sculpture.'$mq$ from st;

-- Techniques and Media > Photography and Digital Art
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Techniques and Media$mq$, 5, 3 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Photography and Digital Art$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Techniques and Media$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Photography and Digital Art$mq$ and p.name = $mq$Techniques and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In photography, what does the aperture control?$mq$, $mq$["How much light enters the lens (and the depth of field)","The colour of the image","The file name","The photo's frame"]$mq$, 0, $mq$Aperture is the opening of the lens. A wider opening lets in more light and gives a shallower depth of field.$mq$, $mq$easy$mq$),
($mq$What is the rule of thirds?$mq$, $mq$["A rule that every photo must have three people","A rule for mixing three colours","A rule of three printing plates","A composition guide dividing the frame into a 3×3 grid and placing key elements on the lines or intersections"]$mq$, 3, $mq$Placing a subject off-centre on grid points often looks more dynamic than centring.$mq$, $mq$easy$mq$),
($mq$Which term describes the part of an image that appears sharp and in focus, from near to far?$mq$, $mq$["Exposure","Resolution","Depth of field","Saturation"]$mq$, 2, $mq$A shallow depth of field blurs the background; a deep one keeps most of the scene sharp.$mq$, $mq$easy$mq$),
($mq$Pixels are:$mq$, $mq$["Sheets of paper","The tiny squares of colour that make up a digital image","Drawing pencils","Printing blocks"]$mq$, 1, $mq$More pixels in an image give higher resolution and more detail.$mq$, $mq$easy$mq$),
($mq$Which file type supports transparent backgrounds and is good for logos?$mq$, $mq$["PNG","TXT","MP3","DOC"]$mq$, 0, $mq$PNG supports transparency. JPEG compresses photos but has no transparency.$mq$, $mq$easy$mq$),
($mq$What is a 'layer' in digital editing software?$mq$, $mq$["A folder of printed work","A pencil grade","A set of paper sheets","A separate level in an image that can be edited without changing other parts"]$mq$, 3, $mq$Layers allow non-destructive editing, such as changing colour on one layer without touching others.$mq$, $mq$medium$mq$),
($mq$A photographer uses a slow shutter speed to photograph a waterfall. What effect results?$mq$, $mq$["The water looks frozen in sharp droplets","The image is always darker","The water looks soft and blurred, showing motion","The picture has no depth"]$mq$, 2, $mq$A slow shutter lets light in for longer, so movement blurs. Fast shutter speeds freeze action.$mq$, $mq$medium$mq$),
($mq$Which low camera angle effect is most likely?$mq$, $mq$["The subject looks small and weak","The subject looks powerful or larger than life","The subject has no emphasis","The image becomes black and white"]$mq$, 1, $mq$Low angles make subjects seem tall and imposing; high angles make them look smaller.$mq$, $mq$medium$mq$),
($mq$A student wants the background to be blurred behind a portrait. Which setting helps?$mq$, $mq$["A wide aperture (low f-number) to reduce depth of field","A very small aperture","A very low resolution","Switching to black and white"]$mq$, 0, $mq$Wide apertures give a shallow depth of field, isolating the subject.$mq$, $mq$medium$mq$),
($mq$A digital drawing is enlarged and the edges look blocky. What is the problem?$mq$, $mq$["Wrong colour name","Too many layers","A vector file with too many curves","Low resolution in a raster (pixel) image"]$mq$, 3, $mq$Raster images are made of pixels and lose quality when enlarged. Vector images scale without loss.$mq$, $mq$medium$mq$),
($mq$What is the difference between raster and vector graphics?$mq$, $mq$["Raster uses curves; vector uses pixels","They are the same","Raster uses pixels; vector uses mathematical lines and curves that scale without losing quality","Vector images cannot be printed"]$mq$, 2, $mq$Vector graphics suit logos and posters needing resizing; raster suits photographs.$mq$, $mq$medium$mq$),
($mq$Which editing approach is the most respectful of the original image file?$mq$, $mq$["Overwriting the only copy","Working on a copy or using non-destructive layers","Deleting the original after editing","Cropping and saving over the camera file"]$mq$, 1, $mq$Always keep the original file so you can return to it.$mq$, $mq$medium$mq$),
($mq$A photographer edits an image to increase contrast and saturation. Which intention is most likely?$mq$, $mq$["To make the image more dramatic and eye-catching","To make it more neutral","To remove all colour","To reduce emphasis"]$mq$, 0, $mq$Increased contrast and saturation intensify drama and make an image stand out.$mq$, $mq$medium$mq$),
($mq$A student wants to use an online photo in their artwork. What is the best practice?$mq$, $mq$["Use any image since it is online","Remove the name of the creator","Claim they took it","Check copyright or licence, use permitted images and credit the source"]$mq$, 3, $mq$Respecting copyright and giving credit are essential parts of academic and artistic honesty.$mq$, $mq$hard$mq$),
($mq$A portrait photograph has a harsh shadow across half the face and a plain dark background. Which mood is likely?$mq$, $mq$["Cheerful and light-hearted","Calm and sunny","Dramatic, serious or mysterious","Playful and busy"]$mq$, 2, $mq$Strong lighting contrast, as in chiaroscuro, suggests drama and tension.$mq$, $mq$hard$mq$),
($mq$A designer needs a poster to print at A2 size from a small image of 600 × 400 pixels. What problem is likely?$mq$, $mq$["The image will turn into a vector","The print will look pixelated because the resolution is too low for that size","The colours will change names","The file will be too large to open"]$mq$, 1, $mq$Low-resolution images enlarged to big sizes show pixels; high-resolution originals or vectors are needed.$mq$, $mq$hard$mq$),
($mq$A student edits a photo so heavily that a news image no longer shows what happened. What ethical issue is raised?$mq$, $mq$["Manipulation can mislead viewers about the truth of an event","Using layers is illegal","Editing always improves truth","Photos can never be edited"]$mq$, 0, $mq$In documentary and news contexts, honesty matters; manipulated images can mislead.$mq$, $mq$hard$mq$),
($mq$Which choice combines technique and intention most effectively for a photograph meant to show fast movement?$mq$, $mq$["A very fast shutter freezing all blur","A small aperture and no movement","A centred subject with no action","A slow shutter with panning to blur the background while the subject stays fairly sharp"]$mq$, 3, $mq$Panning with a slower shutter keeps the subject clearer while the background streaks, giving a strong sense of speed.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Photography and Digital Art$mq$ and p.name = $mq$Techniques and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Rule of thirds$mq$, $mq$Divide the frame into a 3×3 grid and place key elements on the lines or intersections for a more dynamic composition.$mq$),
($mq$Aperture$mq$, $mq$The lens opening. A wider opening (low f-number) lets in more light and gives a shallower depth of field.$mq$),
($mq$Shutter speed$mq$, $mq$How long the sensor is exposed. Fast speeds freeze motion; slow speeds blur it.$mq$),
($mq$Depth of field$mq$, $mq$The zone of the image that looks sharp. Shallow isolates the subject; deep keeps most of the scene in focus.$mq$),
($mq$Raster vs vector$mq$, $mq$Raster images are made of pixels and lose quality when enlarged. Vector images use mathematical curves and scale without loss.$mq$),
($mq$Resolution$mq$, $mq$The amount of detail in a digital image, related to the number of pixels. Too low gives pixelation when enlarged.$mq$),
($mq$Layers$mq$, $mq$Separate levels in editing software so parts of an image can be changed without affecting the rest (non-destructive editing).$mq$),
($mq$Camera angle effects$mq$, $mq$Low angle: subject looks powerful. High angle: subject looks small or vulnerable. Eye level: neutral.$mq$),
($mq$Ethical use of images$mq$, $mq$Check copyright and licences, credit creators, get consent when photographing people, and avoid misleading manipulation.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Photography and Digital Art$mq$ and p.name = $mq$Techniques and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Photography and digital art let you create images using cameras, software and screens. They are now part of daily life, so knowing how they work and how to use them thoughtfully is an important MYP Arts skill. Many students use these media for portfolio work because they allow fast experimentation, as long as the process is documented well.

## Photography basics
- **Composition**: frame the subject deliberately. The **rule of thirds** places important parts on the lines of a 3×3 grid. Other tools include leading lines, framing, symmetry, foreground/background and negative space.
- **Viewpoint**: a low angle makes a subject look powerful; a high angle makes it look small or vulnerable; eye level feels neutral.
- **Lighting**: soft light gives gentle shadows; hard light gives strong shadows and drama. Natural light changes with time of day.
- **Exposure** depends on three linked settings. **Aperture** is the lens opening: wide (low f-number) lets in more light and gives a shallow depth of field. **Shutter speed** is how long the sensor is exposed: fast freezes motion, slow blurs it. **ISO** is sensor sensitivity: high ISO brightens but adds noise.
- **Depth of field**: the zone that looks sharp. Shallow depth of field isolates a subject from the background.

## Digital art and editing
- **Pixels**: tiny squares of colour that make up a **raster** image. More pixels at a given size give higher **resolution**. Enlarging a low-resolution image causes blocky edges.
- **Vector graphics** use lines and curves defined mathematically and can be resized without loss, ideal for logos and posters.
- **Layers** let you edit parts of an image separately. Use adjustment layers, masks and a copy of the original so edits are non-destructive.
- Common edits: crop, adjust brightness and contrast, change saturation, apply filters, remove distractions, combine images.
- **File types**: JPEG for compressed photographs, PNG for transparency, and layered formats to keep editing options.
- Save versions and back up your files.

## Choosing techniques for intention
Ask what you want viewers to feel. Slow shutter waterfalls feel dreamy; sharp, frozen action feels energetic. High contrast and saturation feel dramatic; muted tones feel quiet. Cropping and viewpoint steer attention. Digital collage can combine images to explore ideas about identity or imagination.

## Ethics and responsibility
- **Copyright**: images found online usually belong to someone. Use permitted sources, check licences and credit the creator.
- **Consent and privacy**: ask before photographing identifiable people, especially in sensitive situations, and consider how you share the images.
- **Manipulation**: editing for art is fine, but in documentary or news contexts heavy changes can mislead.
- Be honest in your process journal about what is your own work and what comes from other sources.

## Common mistakes
- Always placing the subject in the centre.
- Using low-resolution images for large prints.
- Overwriting original files.
- Over-editing so that the result looks artificial without purpose.

## How this is examined
Questions give a photographic or digital problem and ask which setting or technique solves it, or what is the effect of a choice. Ethical scenarios about copyright, consent and manipulation are common.

Exam tip: link a setting to a visual result and an intention: 'A wide aperture gives shallow depth of field, which isolates the portrait subject and focuses attention.'$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('visual-arts')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;