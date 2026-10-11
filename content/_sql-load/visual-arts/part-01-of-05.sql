-- Part 1 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Visual Analysis > Elements of Art
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Visual Analysis$mq$, 5, 1 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Elements of Art$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Visual Analysis$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Elements of Art$mq$ and p.name = $mq$Visual Analysis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which element of art describes the lightness or darkness of a colour or surface?$mq$, $mq$["Value","Texture","Space","Line"]$mq$, 0, $mq$Value is the range from light to dark. Texture is surface quality, space is the area around and within objects, and line is a mark joining points.$mq$, $mq$easy$mq$),
($mq$A student draws with a thick, curved, flowing mark. Which element of art are they mainly using?$mq$, $mq$["Form","Shape","Hue","Line"]$mq$, 3, $mq$Line is a mark made by a moving point, and it can be thick, thin, curved or straight.$mq$, $mq$easy$mq$),
($mq$Which colours are the primary colours in the traditional pigment (painting) colour wheel?$mq$, $mq$["Red, green and blue","Orange, green and purple","Red, yellow and blue","Cyan, magenta and black"]$mq$, 2, $mq$The traditional painter's wheel uses red, yellow and blue as primaries. Red, green and blue are the primaries of light (screens).$mq$, $mq$easy$mq$),
($mq$What is the difference between shape and form?$mq$, $mq$["Shape is coloured; form is black and white","Shape is two-dimensional; form is three-dimensional","Shape is natural; form is man-made","Shape is always geometric; form is always organic"]$mq$, 1, $mq$Shape has height and width only, while form also has depth, such as a sphere compared with a circle.$mq$, $mq$easy$mq$),
($mq$A rough, bumpy surface on a clay pot is an example of which element?$mq$, $mq$["Texture","Value","Hue","Line"]$mq$, 0, $mq$Texture is how a surface feels or looks like it would feel, such as rough, smooth, bumpy or silky.$mq$, $mq$easy$mq$),
($mq$Two colours sit directly opposite each other on the colour wheel. What are they called?$mq$, $mq$["Analogous colours","Monochromatic colours","Tertiary colours","Complementary colours"]$mq$, 3, $mq$Complementary colours (for example blue and orange) are opposite each other and create strong contrast. Analogous colours sit side by side.$mq$, $mq$medium$mq$),
($mq$A painting uses only blues, blue-greens and greens. Which colour scheme is this?$mq$, $mq$["Complementary","Triadic","Analogous","Monochromatic"]$mq$, 2, $mq$Analogous schemes use neighbouring colours on the wheel. A monochromatic scheme uses one hue only, in different tints and shades.$mq$, $mq$medium$mq$),
($mq$An artist adds white to red to make pink. What has been created?$mq$, $mq$["A shade","A tint","A tone of grey","A complementary"]$mq$, 1, $mq$Adding white to a hue makes a tint; adding black makes a shade; adding grey makes a tone.$mq$, $mq$medium$mq$),
($mq$A drawing shows a sphere with a bright patch on one side, a mid-tone, and a dark side with a cast shadow. What is the artist using to suggest form?$mq$, $mq$["A range of values","Only line","Flat shapes of colour","Pattern"]$mq$, 0, $mq$Gradations of value (light, mid-tone, shadow) make a flat shape look three-dimensional.$mq$, $mq$medium$mq$),
($mq$In a landscape, distant hills are painted paler and bluer than the trees close to the viewer. Which idea is shown?$mq$, $mq$["Implied texture","Complementary contrast","Positive shape","Atmospheric perspective creating the illusion of space"]$mq$, 3, $mq$Distant objects look lighter, cooler and less detailed, which creates depth. This is the element of space at work.$mq$, $mq$medium$mq$),
($mq$What is negative space in an artwork?$mq$, $mq$["The darkest part of the picture","A space left unfinished by mistake","The area around and between the main subjects","The area painted with cool colours"]$mq$, 2, $mq$Negative space surrounds the positive shapes. Artists use it deliberately to shape the composition.$mq$, $mq$medium$mq$),
($mq$Which pair describes warm and cool colours?$mq$, $mq$["Blue/purple are warm; yellow/orange are cool","Red/orange are warm; blue/green are cool","Black is warm; white is cool","Green/red are both cool"]$mq$, 1, $mq$Warm colours seem to advance and feel energetic; cool colours often seem to recede and feel calm.$mq$, $mq$medium$mq$),
($mq$A student makes a print with a repeated line pattern over a dark background. Which statement describes a high-contrast result?$mq$, $mq$["Pale lines on a dark ground make a strong value contrast","Dark lines on a dark ground make strong contrast","Similar mid-greys make strong contrast","Using one hue only guarantees contrast"]$mq$, 0, $mq$Contrast is the difference between values. Light on dark, or dark on light, makes the strongest contrast.$mq$, $mq$medium$mq$),
($mq$A portrait uses a limited palette of browns, with one small patch of bright blue near the eyes. Which effect is most likely intended?$mq$, $mq$["The painting becomes monochromatic","The blue recedes into the background","The painting loses all emphasis","The blue becomes a focal point through colour contrast"]$mq$, 3, $mq$A small area of contrasting hue against a muted palette attracts the eye. A monochromatic work could not include the blue.$mq$, $mq$hard$mq$),
($mq$An artist wants a calm, restful atmosphere. Which choice of elements best suits this aim?$mq$, $mq$["Sharp zigzag lines, clashing complementaries and high contrast","Heavy black outlines and jagged shapes","Soft, cool analogous colours, gentle curves and low contrast","Random bright colours of equal intensity"]$mq$, 2, $mq$Cool analogous colours, curves and low contrast produce a calm mood; sharp lines and clashing colours feel tense.$mq$, $mq$hard$mq$),
($mq$A student mixes orange and its complement, blue, in equal amounts and gets a muddy brown-grey. What does this show?$mq$, $mq$["The paint was low quality only","Mixing complementary colours neutralises them","Blue and orange are analogous","The mix has become a tint"]$mq$, 1, $mq$Complementaries cancel each other's intensity when mixed. This is useful for making natural neutrals, but too much mixing leads to mud.$mq$, $mq$hard$mq$),
($mq$Two drawings of the same cube are compared. Drawing A has outline only. Drawing B uses tonal shading and a cast shadow. Which element makes B look more convincing in space?$mq$, $mq$["Value used to show form and shadow","Line weight alone","Increased saturation","Repetition of shape"]$mq$, 0, $mq$Tonal shading shows how light falls on a form and where it sits relative to a surface, creating volume and space.$mq$, $mq$hard$mq$),
($mq$Which analysis of the following extract is strongest? 'The artist uses short, broken lines in the sky and long, smooth lines in the water.'$mq$, $mq$["Lines are used, which is an element of art","The artist drew lines because lines are necessary","The sky and water are both done with the same line quality","The contrast between line types creates movement in the sky and calm in the water"]$mq$, 3, $mq$A strong analysis names the element, describes its quality, and explains the effect. The other statements only name or contradict.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Elements of Art$mq$ and p.name = $mq$Visual Analysis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$List the main elements of art$mq$, $mq$Line, shape, form, colour, value, texture and space.$mq$),
($mq$Shape vs form$mq$, $mq$Shape is two-dimensional (height and width). Form is three-dimensional (it also has depth), real or suggested.$mq$),
($mq$Hue, value, saturation$mq$, $mq$Hue is the colour name; value is how light or dark it is; saturation (intensity) is how vivid or dull it is.$mq$),
($mq$Primary colours (pigment)$mq$, $mq$Red, yellow and blue. Secondaries are orange, green and purple.$mq$),
($mq$Complementary colours$mq$, $mq$Opposite each other on the colour wheel (e.g. blue and orange). They give strong contrast and neutralise each other when mixed.$mq$),
($mq$Analogous colours$mq$, $mq$Neighbours on the colour wheel (e.g. yellow, yellow-green, green). They give a harmonious effect.$mq$),
($mq$Tint, shade, tone$mq$, $mq$Tint = hue + white. Shade = hue + black. Tone = hue + grey.$mq$),
($mq$Positive and negative space$mq$, $mq$Positive space holds the main subjects; negative space is the area around and between them.$mq$),
($mq$Actual vs implied texture$mq$, $mq$Actual texture can be felt (thick paint, collage). Implied texture is created by marks that look like a texture.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Elements of Art$mq$ and p.name = $mq$Visual Analysis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$The elements of art are the basic building blocks that artists use to make any artwork. Think of them as the vocabulary of visual language: you can combine them in endless ways, but you first need to recognise each one and describe it accurately. The seven elements most often used in MYP Arts are line, shape, form, colour (hue, value, saturation), value, texture and space.

## The seven elements
- **Line**: a mark made by a moving point. Lines can be thick or thin, straight or curved, continuous or broken. Line can show direction, edge, movement and mood.
- **Shape**: a flat, two-dimensional area with height and width, enclosed by line or by a change of colour or value. Shapes can be geometric (circle, square) or organic (irregular, natural).
- **Form**: a three-dimensional object with height, width and depth, either real (a sculpture) or suggested (a shaded drawing of a sphere).
- **Colour**: described by hue (the name of the colour), value (lightness or darkness) and saturation, also called intensity (how vivid or dull it is).
- **Value**: the lightness or darkness of any colour or surface. Value creates contrast and the illusion of form.
- **Texture**: how a surface feels or appears to feel. Actual texture can be touched; visual or implied texture is created by marks.
- **Space**: the area around, between and within objects. Positive space holds the main subjects; negative space surrounds them. Artists create depth with overlapping, size change, placement and atmospheric perspective.

## Colour in more detail
In the traditional painting colour wheel the primary colours are red, yellow and blue. Mixing two primaries gives a secondary (orange, green, purple), and mixing a primary with a neighbouring secondary gives a tertiary colour. Learn these useful terms:
- **Complementary colours** sit opposite each other (such as blue and orange) and create strong contrast.
- **Analogous colours** sit side by side (such as yellow, yellow-green and green) and feel harmonious.
- **Monochromatic** means one hue used in many tints and shades.
- A **tint** is a hue plus white, a **shade** is a hue plus black, and a **tone** is a hue plus grey.
- **Warm** colours (reds, oranges, yellows) often feel energetic and seem to advance; **cool** colours (blues, greens, purples) often feel calm and seem to recede.

## Using elements to create effects
Elements are never random. A jagged, thick line suggests anger or tension, while a flowing thin line feels gentle. A small patch of bright colour in a muted painting becomes a focal point. A dark shape against a pale ground gives strong contrast, while neighbouring mid-tones give a quiet, low-contrast feel. When you describe an artwork, always link the element to its effect: name it, describe it, then explain what it does.

## Common mistakes
- Mixing up shape and form. Shape is flat; form has volume.
- Confusing value with saturation. Value is light to dark; saturation is dull to vivid.
- Saying the primary colours are red, green and blue for paint. That is the set for light on screens.
- Writing 'the artist uses colour' with no detail. Say which colours, how they are arranged and what effect they have.

## How this is examined
Questions usually show a short description of an artwork or a student's studio problem, then ask you to identify the element, explain an effect, or choose the best way to achieve a mood. Stronger answers use accurate vocabulary and connect each choice to the meaning or impact on the viewer.

Exam tip: use the pattern element, evidence, effect. For example: 'The high-contrast value (element) between the pale figure and dark ground (evidence) draws the eye to the figure (effect).'$mq$ from st;

-- Visual Analysis > Principles of Design
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Visual Analysis$mq$, 5, 1 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Principles of Design$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Visual Analysis$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Principles of Design$mq$ and p.name = $mq$Visual Analysis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which principle of design describes the way the eye is led to the most important part of an artwork?$mq$, $mq$["Emphasis","Rhythm","Balance","Proportion"]$mq$, 0, $mq$Emphasis (focal point) is created by contrast, size, colour or placement so the viewer looks there first.$mq$, $mq$easy$mq$),
($mq$A design is mirrored exactly on either side of a central line. What type of balance is this?$mq$, $mq$["Asymmetrical","Radial","Random","Symmetrical"]$mq$, 3, $mq$Symmetrical balance has matching halves. Asymmetrical balance uses different elements that still feel equal in visual weight.$mq$, $mq$easy$mq$),
($mq$What does repetition of a shape across a poster create?$mq$, $mq$["Emphasis on one shape only","Perfect asymmetry","Pattern and rhythm","Negative space"]$mq$, 2, $mq$Repeating elements creates pattern, and regular repetition creates a visual beat called rhythm.$mq$, $mq$easy$mq$),
($mq$Which principle refers to the relationship between the sizes of parts within a whole, such as head to body in a figure?$mq$, $mq$["Contrast","Proportion","Unity","Movement"]$mq$, 1, $mq$Proportion compares sizes of parts. Scale compares size to something external.$mq$, $mq$easy$mq$),
($mq$What is unity in an artwork?$mq$, $mq$["The feeling that all parts belong together","Using only one colour","Having an exactly symmetrical layout","Making every part equally prominent"]$mq$, 0, $mq$Unity (harmony) comes from linking elements such as colour, shape or style so the work feels complete.$mq$, $mq$easy$mq$),
($mq$A poster uses a huge red circle among many small grey squares. Which principle is most obvious?$mq$, $mq$["Symmetry","Repetition only","Radial balance","Contrast leading to emphasis"]$mq$, 3, $mq$The big red circle differs strongly in size, colour and shape, so it stands out as the focal point.$mq$, $mq$medium$mq$),
($mq$An artwork has a large dark shape on the left and several small bright shapes on the right, and still feels stable. Which balance is it?$mq$, $mq$["Symmetrical balance","Radial balance","Asymmetrical balance","No balance"]$mq$, 2, $mq$Different elements can balance in visual weight without being identical, which is asymmetrical balance.$mq$, $mq$medium$mq$),
($mq$A painter places a winding river that leads the eye from the bottom corner up to a distant castle. Which principle is used?$mq$, $mq$["Proportion","Movement","Symmetry","Pattern only"]$mq$, 1, $mq$Movement directs the viewer's eye through a work using lines, edges and repeated shapes.$mq$, $mq$medium$mq$),
($mq$What is the difference between pattern and rhythm?$mq$, $mq$["Pattern is a repeated design; rhythm is the visual beat created by repetition and variation","Pattern is only in sculpture; rhythm is only in painting","Pattern uses colour; rhythm uses line","They are exactly the same thing"]$mq$, 0, $mq$Pattern repeats elements in a set way. Rhythm is the flow or beat made by repeated elements, which can include variation.$mq$, $mq$medium$mq$),
($mq$A designer repeats the same shape, but changes its size gradually from large to small. Which effect is produced?$mq$, $mq$["Strict symmetry","Loss of unity","Flat colour","Rhythm with a sense of progression or depth"]$mq$, 3, $mq$Gradual change gives progressive rhythm and can suggest space or movement.$mq$, $mq$medium$mq$),
($mq$Why might an artist deliberately distort proportion in a figure with a huge head and tiny body?$mq$, $mq$["Because proportions cannot be changed","To make the work symmetrical","To express an idea or exaggerate a feature","To remove emphasis"]$mq$, 2, $mq$Distorted proportion is a common expressive choice, as in caricature or surreal work.$mq$, $mq$medium$mq$),
($mq$A circular mandala has elements arranged outward from a centre. Which kind of balance is this?$mq$, $mq$["Asymmetrical balance","Radial balance","Diagonal balance","Proportional balance"]$mq$, 1, $mq$Radial balance spreads elements around a central point, like the spokes of a wheel.$mq$, $mq$medium$mq$),
($mq$Which change would reduce unity in a collage?$mq$, $mq$["Adding unrelated styles, colours and shapes with no link","Repeating a colour across the work","Using a shared border","Keeping a consistent theme"]$mq$, 0, $mq$Unity needs links such as colour, theme or style. Random, unrelated parts weaken it.$mq$, $mq$medium$mq$),
($mq$A poster has text and image perfectly mirrored, with everything evenly spaced and the same size. Which weakness might a critic mention?$mq$, $mq$["The poster has too much contrast","It lacks balance","The proportions are impossible","There may be no clear emphasis, so the eye has nowhere to start"]$mq$, 3, $mq$Perfect symmetry with equal emphasis can feel static. A focal point gives the viewer a place to begin.$mq$, $mq$hard$mq$),
($mq$A student writes: 'The artist uses rhythm because there are stripes.' Which improvement gives the strongest analysis?$mq$, $mq$["Add that stripes are a pattern","Remove the word rhythm","State how the stripes repeat and vary, and how this makes the eye move across the work","Say that rhythm is always good"]$mq$, 2, $mq$Good analysis names the principle, uses evidence and explains its effect on the viewer.$mq$, $mq$hard$mq$),
($mq$In a composition the focal point is placed exactly in the centre and surrounded by symmetrical elements. What effect is most likely?$mq$, $mq$["A sense of chaos and instability","A stable, formal, calm feeling","Random movement","Loss of emphasis"]$mq$, 1, $mq$Central placement with symmetry creates stability and formality; instability needs off-centre or diagonal arrangements.$mq$, $mq$hard$mq$),
($mq$A designer wants a feeling of tension in a poster. Which combination best supports this?$mq$, $mq$["Strong diagonals, unbalanced weight and high contrast","Gentle horizontal lines and symmetrical layout","Equal sizes and soft colours","Evenly repeated shapes with low contrast"]$mq$, 0, $mq$Diagonals and imbalance feel dynamic and unstable. Horizontals and symmetry feel at rest.$mq$, $mq$hard$mq$),
($mq$Compare two works. Work A repeats identical flowers in rows. Work B varies flower size, colour and direction but keeps a limited palette. Which statement is most accurate?$mq$, $mq$["A shows asymmetry; B shows no unity","Both show the same pattern","A has no repetition; B has strict repetition","A shows regular pattern; B shows varied rhythm with unity from the palette"]$mq$, 3, $mq$Identical repetition makes pattern. Variation within a limited palette creates lively rhythm while the palette keeps unity.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Principles of Design$mq$ and p.name = $mq$Visual Analysis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Balance: three types$mq$, $mq$Symmetrical (mirrored), asymmetrical (different but equal in weight) and radial (arranged around a centre).$mq$),
($mq$Emphasis$mq$, $mq$The focal point that grabs attention first, made by contrast, size, colour or placement.$mq$),
($mq$Contrast$mq$, $mq$Differences between elements (light/dark, large/small, rough/smooth) that add interest and can create emphasis.$mq$),
($mq$Movement$mq$, $mq$How the viewer's eye is led through the work by lines, edges, diagonals and repeated shapes.$mq$),
($mq$Pattern vs rhythm$mq$, $mq$Pattern is a repeated design. Rhythm is the visual beat created by repetition, regular, alternating or progressive.$mq$),
($mq$Proportion vs scale$mq$, $mq$Proportion compares sizes of parts within a work. Scale compares the work or object to something else, such as the human body.$mq$),
($mq$Unity$mq$, $mq$The feeling that all parts belong together, built with a consistent palette, theme, style or repeated shapes.$mq$),
($mq$Variety$mq$, $mq$Differences that keep a work interesting. Compositions need a good balance of unity and variety.$mq$),
($mq$Effect of diagonals$mq$, $mq$Strong diagonals feel dynamic and tense; horizontals and symmetry feel stable and calm.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Principles of Design$mq$ and p.name = $mq$Visual Analysis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$The principles of design describe how artists organise the elements of art to make a composition work. If the elements are the ingredients, the principles are the recipe. In MYP Arts you are expected to identify them, explain how they are used, and choose them deliberately in your own work.

## The main principles
- **Balance**: the distribution of visual weight. **Symmetrical** balance mirrors the two halves. **Asymmetrical** balance uses different elements that still feel equal, for example one large dark shape balanced by several small bright ones. **Radial** balance spreads elements around a central point, like a mandala.
- **Emphasis (focal point)**: the part that grabs attention first. It is created through contrast of colour, value, size, shape or placement, or by isolating a subject.
- **Contrast**: differences between elements, such as light and dark, large and small, rough and smooth. Contrast adds interest and can create emphasis.
- **Movement**: how the eye travels through the work. Lines, edges, repeated shapes and diagonals guide the viewer.
- **Pattern**: a repeated arrangement of elements in a set way.
- **Rhythm**: the visual beat made by repetition, which can be regular, alternating or progressive (changing gradually).
- **Proportion and scale**: proportion compares the sizes of parts within a work; scale compares the size of the work or object to something else, such as the human body.
- **Unity (harmony)**: the sense that everything belongs together. It is built through a consistent palette, theme, style or repeated shapes.
- **Variety**: the differences that keep a work interesting. Good compositions balance unity and variety.

## Putting principles to work
Imagine a poster for a school science fair. To make the title the focal point, you might make it much larger than other text, in a colour that contrasts with the background. To lead the eye downward, you could arrange smaller images along a diagonal. To make the poster feel unified, you could repeat one colour in the title, the images and the border. Each decision is a principle used for a purpose.

Different principles create different moods. Symmetry and horizontals feel stable and formal. Diagonals, imbalance and strong contrast feel dynamic and tense. Gradual repetition feels flowing. Distorted proportion can express humour, fear or fantasy.

## Common mistakes
- Treating symmetry as the only kind of balance. Asymmetrical balance is common and often more interesting.
- Confusing pattern and rhythm. Pattern is the repeated design; rhythm is the beat or flow it creates.
- Using many principles in a list without evidence. Pick two or three and explain them well.
- Forgetting that perfect unity with no variety can feel dull, and lots of variety with no unity feels chaotic.

## How this is examined
Questions describe a composition and ask which principle is being used, what effect it has, or how to change it to match an intention. You may be asked to evaluate a composition, so use words like 'effective because' and 'less successful because'.

Exam tip: always connect principle, evidence and effect. 'Asymmetrical balance (principle) between the large dark tree and the three small bright houses (evidence) keeps the picture stable but lively (effect).'$mq$ from st;

-- Visual Analysis > Analysing and Critiquing Artworks
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Visual Analysis$mq$, 5, 1 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Analysing and Critiquing Artworks$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Visual Analysis$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Analysing and Critiquing Artworks$mq$ and p.name = $mq$Visual Analysis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which word best describes the first stage of analysis, where you say what you can see without giving opinions?$mq$, $mq$["Description","Judgement","Prediction","Interpretation"]$mq$, 0, $mq$Describing records the visible facts (subject, colours, materials). Interpretation and judgement come later.$mq$, $mq$easy$mq$),
($mq$What does 'formal analysis' focus on?$mq$, $mq$["The artist's family life","How much the work sold for","The gallery's opening hours","How elements and principles are used in the artwork"]$mq$, 3, $mq$Formal analysis looks at line, colour, composition and so on, not external facts.$mq$, $mq$easy$mq$),
($mq$Which sentence is a description rather than an opinion?$mq$, $mq$["The painting is beautiful","The painting is boring","The painting shows a woman in a blue coat standing by a window","The painting is the best in the room"]$mq$, 2, $mq$A description states what is visible. Words like beautiful or boring are opinions.$mq$, $mq$easy$mq$),
($mq$What does it mean to interpret an artwork?$mq$, $mq$["To copy it exactly","To suggest what it means or communicates, using evidence","To say if you like it","To list its materials only"]$mq$, 1, $mq$Interpretation is a reasoned explanation of meaning, supported by visual evidence.$mq$, $mq$easy$mq$),
($mq$Which term describes a judgement about how successful an artwork is?$mq$, $mq$["Evaluation","Description","Documentation","Imitation"]$mq$, 0, $mq$Evaluation weighs strengths and weaknesses, giving reasons.$mq$, $mq$easy$mq$),
($mq$A critic writes: 'The cool blues and empty space make the figure look lonely.' Which parts of analysis does this sentence combine?$mq$, $mq$["Only a description of materials","Only the artist's biography","Only a technical judgement of skill","Evidence of elements and an interpretation of mood"]$mq$, 3, $mq$It names elements (cool blues, empty space) and links them to mood (loneliness).$mq$, $mq$medium$mq$),
($mq$Which of the following is the strongest piece of visual evidence for the claim 'the artist wants us to feel the crowd's energy'?$mq$, $mq$["The frame is made of wood","The painting is large","Short, broken brushstrokes in bright colours that cover the whole canvas","The artist was born in a big city"]$mq$, 2, $mq$Visual evidence must come from the artwork itself, such as brushwork and colour, to support meaning.$mq$, $mq$medium$mq$),
($mq$Why is it important to mention context when analysing an artwork?$mq$, $mq$["Context replaces looking at the work","Time, place and purpose can change how the work is understood","Context is always unimportant","Context only matters for sculpture"]$mq$, 1, $mq$Knowing when, where and why a work was made helps explain choices and meanings.$mq$, $mq$medium$mq$),
($mq$Which sentence is the best evaluation?$mq$, $mq$["The strong diagonal composition is effective because it leads the eye to the figure, though the busy background competes for attention","I think it is nice","The artist did well","It has a diagonal"]$mq$, 0, $mq$A good evaluation gives a judgement, reasons and a balanced view of strengths and weaknesses.$mq$, $mq$medium$mq$),
($mq$Two students analyse the same portrait. Student A: 'It has a face.' Student B: 'The soft side lighting gives the face gentle modelling, creating a thoughtful mood.' What makes B stronger?$mq$, $mq$["It is longer","It uses the word face","It states an opinion without evidence","It uses specific vocabulary, evidence and an explained effect"]$mq$, 3, $mq$Specific evidence plus effect is what makes analysis strong. Length alone does not.$mq$, $mq$medium$mq$),
($mq$In a critique, what is a good way to give constructive feedback to a classmate?$mq$, $mq$["Say only that you do not like it","Compare them with a famous artist","Identify a strength and a specific suggestion, linked to their intention","Avoid mentioning any problems"]$mq$, 2, $mq$Constructive feedback is specific, respectful and connected to what the artist is trying to do.$mq$, $mq$medium$mq$),
($mq$A student says that an abstract painting 'means nothing because there is nothing in it'. Which response is best?$mq$, $mq$["They are right because it has no objects","Abstract work can still communicate through colour, line and composition, so look for these choices","Abstract art cannot be analysed","Only titles can give meaning"]$mq$, 1, $mq$Abstract art uses elements and principles to express mood and ideas, so it can be analysed formally.$mq$, $mq$medium$mq$),
($mq$Which is a limitation of judging an artwork only by how realistic it looks?$mq$, $mq$["It ignores works whose purpose is expression or concept rather than realism","Realism is never used","It always gives accurate results","It makes all art equal"]$mq$, 0, $mq$Many artists distort or simplify on purpose, so realism is just one of many possible aims.$mq$, $mq$medium$mq$),
($mq$An image of a crowded market is painted in warm reds with thick, rapid strokes. What interpretation is best supported by this evidence?$mq$, $mq$["The mood is silent and still","The scene is a cold, empty field","The artist wanted precise photographic detail","The mood is lively and energetic"]$mq$, 3, $mq$Warm colours and quick thick strokes suggest energy and activity, matching the crowded scene.$mq$, $mq$hard$mq$),
($mq$A critic says 'This work is successful because it is famous'. What is the problem with this reasoning?$mq$, $mq$["It uses too much evidence","It is too formal","Fame does not explain how the artwork's visual choices work","It refers to context"]$mq$, 2, $mq$Fame is not visual evidence. Evaluation should refer to the artwork's elements, principles, ideas and effect.$mq$, $mq$hard$mq$),
($mq$A student compares two landscapes. Which approach is the most effective comparison?$mq$, $mq$["Describing one work entirely and ignoring the other","Discussing the same aspects (colour, composition, mood) for both works and showing similarities and differences","Listing the artists' birthdays","Saying both are landscapes"]$mq$, 1, $mq$Comparison works best when the same criteria are applied to both works and links are made between them.$mq$, $mq$hard$mq$),
($mq$The artist of a protest poster says her aim was to shock. A viewer finds the image shocking. Which statement best judges the work?$mq$, $mq$["The work is effective in achieving its intention, supported by the harsh contrast and large scale that provoke the reaction","The work is poor because shocking images are wrong","Intentions never matter in judging art","The work succeeds only if it is beautiful"]$mq$, 0, $mq$Judging success against intention and evidence is a valid method. Beauty is not the only standard.$mq$, $mq$hard$mq$),
($mq$A student's essay says: 'The painting uses red. Red means anger. So the painting is about anger.' What is the main weakness?$mq$, $mq$["It describes the colours","It mentions the artwork","It uses a conclusion","It treats colour symbolism as fixed without considering context and other evidence"]$mq$, 3, $mq$Colour meanings vary with culture, context and use. Strong interpretation weighs several pieces of evidence.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Analysing and Critiquing Artworks$mq$ and p.name = $mq$Visual Analysis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Four-step method of analysis$mq$, $mq$Describe, analyse, interpret, evaluate.$mq$),
($mq$Describe$mq$, $mq$State what you can see (subject, colours, materials, composition) without giving opinions.$mq$),
($mq$Formal analysis$mq$, $mq$Examining how the elements of art and principles of design are used in a work.$mq$),
($mq$Interpret$mq$, $mq$Suggest what the work means or communicates, supported by visual evidence.$mq$),
($mq$Evaluate$mq$, $mq$Judge how successful the work is, giving reasons and balancing strengths and weaknesses.$mq$),
($mq$What counts as evidence?$mq$, $mq$Anything visible in the work: colour, line quality, composition, technique, scale, subject matter.$mq$),
($mq$Sentence frame for analysis$mq$, $mq$Element/evidence, then effect, then meaning: 'The artist uses ___, which creates ___, suggesting ___.'$mq$),
($mq$Constructive peer critique$mq$, $mq$Respectful, specific and useful: name a strength, give a clear suggestion, and link it to the artist's intention.$mq$),
($mq$Is symbolism fixed?$mq$, $mq$No. Colours and objects can mean different things in different cultures and contexts, so support interpretations with several pieces of evidence.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Analysing and Critiquing Artworks$mq$ and p.name = $mq$Visual Analysis$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Analysing and critiquing artworks means looking closely, thinking carefully and explaining your ideas with evidence. It is central to MYP Arts criterion D (Responding), and it also supports your own making, because the more you understand how other artists solve problems, the better your own choices become.

## A four-step method
A reliable way to structure your thinking is describe, analyse, interpret, evaluate.
- **Describe**: say what you can see, without opinion. Subject, colours, materials, size, composition. Example: 'A seated woman in a blue coat looks out of a window; the room is dark.'
- **Analyse**: examine how the elements of art and principles of design are used. Example: 'Strong value contrast between the lit face and the dark room draws attention to her expression.'
- **Interpret**: suggest what the work means or communicates, using evidence. Example: 'The dark room and her distant gaze suggest loneliness or longing.'
- **Evaluate**: judge how successful the work is, giving reasons and considering strengths and weaknesses. Example: 'The lighting is highly effective at conveying mood, but the cluttered table on the right distracts from the main figure.'

## Using evidence and vocabulary
Evidence is anything you can point to in the artwork: a colour, a line quality, a placement, a technique. A claim without evidence is just an opinion. Compare these two sentences: 'It is a sad painting' and 'Muted blue-greys and drooping diagonal lines give the painting a sad mood.' The second is much stronger. Use accurate subject vocabulary such as hue, texture, composition, focal point, medium, brushwork and tone.

## Context and intention
Artworks are made at a certain time, in a certain place and for a certain purpose. Knowing the context, such as a political event or a cultural tradition, can help explain the choices. Still, keep your focus on what is visible: context supports analysis; it does not replace it. You can also judge a work by its intention. A protest poster may aim to shock, a portrait to flatter, a landscape to calm. Ask: did the artist achieve the aim, and how?

## Critiquing peers
A critique is a discussion about artwork to help improve it. Good critique is respectful, specific and useful. Try: 'The textures in the bark are convincing. To make the tree the focal point, you could make the background paler.' Avoid vague comments such as 'It's good' or personal comments about the artist.

## Comparing works
When comparing two artworks, use the same points for both (for example colour, composition, mood and context) and write about similarities and differences together, not in two separate lists.

## Common mistakes
- Giving only opinion ('I like it') without evidence.
- Describing and never explaining the effect.
- Treating symbolism as fixed. A colour or object can mean different things in different cultures and contexts.
- Judging only on realism or fame.

## How this is examined
You may be shown a description or reproduction of an artwork and asked to select the best analysis, interpretation or feedback, or to explain how a choice creates an effect. Strong responses use specific evidence, correct vocabulary and balanced judgement.

Exam tip: use the sentence frame 'The artist uses ___ (evidence), which creates ___ (effect), suggesting ___ (meaning).'$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('visual-arts')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;