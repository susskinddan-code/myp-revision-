-- Part 2 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Art in Context > Art Movements and Periods
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Art in Context$mq$, 5, 2 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Art Movements and Periods$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Art in Context$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Art Movements and Periods$mq$ and p.name = $mq$Art in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which art movement is associated with Claude Monet's painting 'Impression, Sunrise'?$mq$, $mq$["Impressionism","Cubism","Surrealism","Pop Art"]$mq$, 0, $mq$The title of Monet's 1872 painting gave Impressionism its name. The movement focused on light and fleeting moments.$mq$, $mq$easy$mq$),
($mq$Which artist is best known as a co-founder of Cubism, with Georges Braque?$mq$, $mq$["Salvador Dalí","Andy Warhol","Claude Monet","Pablo Picasso"]$mq$, 3, $mq$Picasso and Braque developed Cubism in the early 1900s, showing objects from several viewpoints at once.$mq$, $mq$easy$mq$),
($mq$Renaissance artists such as Leonardo da Vinci used which technique to show depth on a flat surface?$mq$, $mq$["Collage","Pointillism","Linear perspective","Readymade art"]$mq$, 2, $mq$Linear perspective uses converging lines and a vanishing point to create the illusion of space.$mq$, $mq$easy$mq$),
($mq$Which movement is known for dreamlike, irrational imagery, as in Salvador Dalí's melting clocks?$mq$, $mq$["Realism","Surrealism","Impressionism","Minimalism"]$mq$, 1, $mq$Surrealism explored dreams and the unconscious, combining realistic detail with impossible scenes.$mq$, $mq$easy$mq$),
($mq$Andy Warhol's soup can and celebrity prints belong to which movement?$mq$, $mq$["Pop Art","Romanticism","Fauvism","Baroque"]$mq$, 0, $mq$Pop Art of the 1950s and 60s used images from advertising, mass media and popular culture.$mq$, $mq$easy$mq$),
($mq$Which description best fits Cubism?$mq$, $mq$["Soft light effects painted outdoors","Dreamlike scenes from the unconscious","Highly emotional landscapes of the sublime","Objects broken into geometric forms and shown from multiple viewpoints"]$mq$, 3, $mq$Cubism fragments objects and shows several sides at once, rejecting single-point perspective.$mq$, $mq$medium$mq$),
($mq$Impressionist painters often worked outdoors. What were they most interested in capturing?$mq$, $mq$["Perfectly smooth, hidden brushstrokes","Mythological stories","Changing light and atmosphere in a moment","Pure geometric abstraction"]$mq$, 2, $mq$They used quick, visible brushstrokes and bright colour to record effects of light.$mq$, $mq$medium$mq$),
($mq$Which pairing of artist and movement is correct?$mq$, $mq$["Piet Mondrian and Baroque","Vincent van Gogh and Post-Impressionism","Leonardo da Vinci and Pop Art","Claude Monet and Surrealism"]$mq$, 1, $mq$Van Gogh is a key Post-Impressionist, using expressive colour and thick brushwork. Mondrian was linked to De Stijl, not Baroque.$mq$, $mq$medium$mq$),
($mq$The Baroque period (c. 1600–1750) is known for which qualities?$mq$, $mq$["Drama, strong contrasts of light and dark, and movement","Flat colour and minimal forms","Plain, undecorated surfaces","Random chance and found objects"]$mq$, 0, $mq$Baroque art such as Caravaggio's uses dramatic lighting (chiaroscuro) and emotional intensity.$mq$, $mq$medium$mq$),
($mq$What does abstract art mainly do?$mq$, $mq$["Copies photographs exactly","Illustrates only historical events","Avoids using colour","Uses shape, colour and line without trying to show things as they look"]$mq$, 3, $mq$Abstract art may simplify forms or have no recognisable subject at all.$mq$, $mq$medium$mq$),
($mq$Which statement best describes Renaissance art compared with much medieval art?$mq$, $mq$["It rejected all religious subjects","It used only abstract shapes","It emphasised realism, perspective and the study of anatomy","It was made only in the twentieth century"]$mq$, 2, $mq$The Renaissance (from about the 14th century in Italy) revived classical ideas and observation of nature.$mq$, $mq$medium$mq$),
($mq$Why did the invention of photography in the 1800s influence painters?$mq$, $mq$["It stopped people painting","Painters no longer needed to focus only on exact realism, so many explored light, feeling and abstraction","It made colour impossible to use","It introduced Cubism immediately"]$mq$, 1, $mq$Cameras could record realism, which encouraged artists to explore other aims such as impression and expression.$mq$, $mq$medium$mq$),
($mq$Which description fits Minimalism?$mq$, $mq$["Simple, reduced forms with little or no decoration","Crowded, ornate surfaces","Dreamlike, symbolic scenes","Detailed portraits of royalty"]$mq$, 0, $mq$Minimalism (1960s) reduces art to basic geometric forms, industrial materials and clean surfaces.$mq$, $mq$medium$mq$),
($mq$A student states: 'Art movements follow each other neatly, and artists belong to only one.' What is the best correction?$mq$, $mq$["Artists never change style","Movements never influence each other","All movements started in the same year","Movements overlap, and artists often change styles or are linked to several movements"]$mq$, 3, $mq$Movements are labels used by historians. Artists such as Picasso worked in many styles, and movements influence and react against each other.$mq$, $mq$hard$mq$),
($mq$Dada artists such as Marcel Duchamp challenged traditional ideas of art. Which work is by Duchamp and shows this approach?$mq$, $mq$["'The Starry Night'","'The Persistence of Memory'","'Fountain', a readymade urinal presented as art","'Girl with a Pearl Earring'"]$mq$, 2, $mq$Duchamp's 1917 'Fountain' questioned what counts as art. The other works are by van Gogh, Dalí and Vermeer.$mq$, $mq$hard$mq$),
($mq$Abstract Expressionists such as Jackson Pollock stressed gesture and the act of painting. Which technique is most associated with Pollock?$mq$, $mq$["Detailed miniature painting","Dripping and pouring paint onto a canvas laid on the floor","Tiny dots of colour","Perspective drawing from life"]$mq$, 1, $mq$Pollock's drip paintings of the late 1940s and 50s record his body movements across the canvas.$mq$, $mq$hard$mq$),
($mq$A student compares Impressionism with Realism. Which statement is accurate?$mq$, $mq$["Realism shows ordinary subjects in a detailed, truthful way, while Impressionism captures fleeting light with loose brushwork","Both use only mythological subjects","Realism is abstract and Impressionism is photographic","Realism was invented after Pop Art"]$mq$, 0, $mq$Realists such as Gustave Courbet depicted everyday life accurately; Impressionists wanted to convey a momentary visual impression.$mq$, $mq$hard$mq$),
($mq$Why is it risky to guess an artwork's movement only from its subject matter?$mq$, $mq$["Subjects are never relevant","Movements do not have styles","All landscapes are Impressionist","The same subject can be treated in very different styles, so style, technique and context must also be considered"]$mq$, 3, $mq$Dating and classifying needs several clues: techniques, colour use, composition and historical context.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Art Movements and Periods$mq$ and p.name = $mq$Art in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Impressionism$mq$, $mq$1870s: changing light and atmosphere, quick visible brushstrokes, often outdoors. Key artist: Claude Monet.$mq$),
($mq$Cubism$mq$, $mq$Early 1900s: objects broken into geometric forms shown from several viewpoints. Key artists: Pablo Picasso, Georges Braque.$mq$),
($mq$Surrealism$mq$, $mq$1920s onward: dreamlike, irrational imagery from the unconscious. Key artist: Salvador Dalí.$mq$),
($mq$Pop Art$mq$, $mq$1950s-60s: imagery from advertising and popular culture. Key artist: Andy Warhol.$mq$),
($mq$Renaissance$mq$, $mq$Revival of classical ideas from the 1300s: realism, anatomy and linear perspective. Key artists: Leonardo da Vinci, Michelangelo.$mq$),
($mq$Baroque$mq$, $mq$c. 1600-1750: drama, movement and strong light-dark contrast (chiaroscuro). Key artist: Caravaggio.$mq$),
($mq$Dada$mq$, $mq$Protest movement around World War I that questioned what art is. Marcel Duchamp's readymade 'Fountain' is an example.$mq$),
($mq$Pointillism$mq$, $mq$Image built from tiny dots of pure colour that blend in the viewer's eye. Key artist: Georges Seurat.$mq$),
($mq$Why are movements only labels?$mq$, $mq$They are historians' groupings. Movements overlap, influence one another, and artists often change style.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Art Movements and Periods$mq$ and p.name = $mq$Art in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Art history is a long conversation. Each generation of artists looks at what came before, borrows ideas, and often reacts against them. An **art movement** is a label for a group of artists who share style, ideas or aims during a period of time. At MYP level you do not need to memorise every date. You do need to recognise major movements, link a few key artists and works to them, and explain why they matter.

## Key periods and movements
- **Renaissance** (from the 1300s in Italy): revival of classical ideas, careful observation of nature, anatomy and linear perspective. Artists include Leonardo da Vinci and Michelangelo.
- **Baroque** (c. 1600–1750): drama, movement and strong contrast of light and dark (chiaroscuro), for example Caravaggio.
- **Romanticism** (late 1700s to mid-1800s): emotion, imagination and the power of nature.
- **Realism** (mid-1800s): ordinary people and everyday life shown honestly, for example Gustave Courbet.
- **Impressionism** (1870s onwards): changing light and atmosphere, quick visible brushstrokes, often painted outdoors. Claude Monet is the best-known name; the title of his 'Impression, Sunrise' gave the movement its name.
- **Post-Impressionism**: artists who built on Impressionism but used colour and form more expressively, including Vincent van Gogh and Paul Cézanne. Georges Seurat developed Pointillism, using tiny dots of colour.
- **Cubism** (early 1900s): Pablo Picasso and Georges Braque broke objects into geometric parts viewed from several angles at once.
- **Surrealism** (1920s onwards): dreams and the unconscious, with strange combinations of realistic things, as in Salvador Dalí.
- **Dada**: a protest movement during and after World War I that questioned what art is. Marcel Duchamp's readymade 'Fountain' is a famous example.
- **Abstract Expressionism** (1940s–50s): emotion and gesture, as in Jackson Pollock's drip paintings.
- **Pop Art** (1950s–60s): imagery from advertising and popular culture, such as Andy Warhol's soup cans.
- **Minimalism** (1960s): reduced, simple forms and industrial materials.

## How to talk about movements
Describe the movement through its **style** (colour, line, brushwork), **subject matter**, **ideas** and **context**. For example, Pop Art used bold colour and repeated images because it was responding to mass production and consumer culture. Impressionism happened partly because paint in tubes allowed painting outdoors and because photography was changing what painters needed to do.

## Seeing links and change
Movements are labels created by historians. They overlap, and many artists changed style during their lives. Picasso worked in several styles, for instance. When you meet an unfamiliar artwork, look for clues: how realistic is it, how are colours used, what is the subject, what does it seem to react against? Then compare with movements you know.

## Common mistakes
- Mixing up artists and movements, such as Dalí with Cubism or Warhol with Surrealism.
- Assuming movements follow neatly one after another. They overlap.
- Judging older art as 'worse' because it is less abstract (or the reverse). Each movement had its own aims.
- Guessing a movement from subject matter only. A landscape can be painted in many styles.

## How this is examined
Questions often provide a short description of an artwork or artist and ask you to identify the movement, explain why it developed, or compare two styles. Written tasks reward linking style to context and using accurate terms.

Exam tip: for each movement learn a trio: one key idea, one key artist, one visual clue (such as 'broken into geometric parts' for Cubism).$mq$ from st;

-- Art in Context > Art, Culture and Society
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Art in Context$mq$, 5, 2 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Art, Culture and Society$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Art in Context$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Art, Culture and Society$mq$ and p.name = $mq$Art in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'cultural context' mean when studying an artwork?$mq$, $mq$["The beliefs, traditions and customs of the society in which it was made","The colour palette used","The price of the materials","The size of the canvas"]$mq$, 0, $mq$Cultural context helps explain why an artwork looks the way it does and what it means to its audience.$mq$, $mq$easy$mq$),
($mq$Which of the following is an example of art serving a religious purpose?$mq$, $mq$["A pop poster advertising a snack","A caricature in a newspaper","A fashion photograph","A stained glass window in a cathedral telling a Bible story"]$mq$, 3, $mq$Many cultures have made art to honour beliefs and tell sacred stories, such as stained glass, icons and temple sculpture.$mq$, $mq$easy$mq$),
($mq$Murals painted on walls in a city often communicate:$mq$, $mq$["Private diary entries","Only decorative patterns with no meaning","Ideas to the community, such as history, identity or social messages","Information for museum staff only"]$mq$, 2, $mq$Public murals reach many people and often reflect local identity or issues.$mq$, $mq$easy$mq$),
($mq$Which statement best defines 'propaganda art'?$mq$, $mq$["Art made only for private collections","Art made to influence public opinion, often for a political cause","Art that copies nature perfectly","Art with no message"]$mq$, 1, $mq$Propaganda uses persuasive imagery, bold colour and simple messages to shape opinion.$mq$, $mq$easy$mq$),
($mq$Why might an artist create work about an environmental issue?$mq$, $mq$["To raise awareness and encourage viewers to think or act","Because art cannot comment on society","To hide the issue","Because it is required by all museums"]$mq$, 0, $mq$Artists often respond to social issues to start conversations and inspire change.$mq$, $mq$easy$mq$),
($mq$Indigenous Australian dot paintings often represent connection to land and story. What does this show about art?$mq$, $mq$["Art is only decoration","Art has no cultural purpose","Dots always mean the same thing in every culture","Art can carry knowledge, identity and heritage within a community"]$mq$, 3, $mq$Many Indigenous artworks hold cultural knowledge and relationships to Country. Meanings can be specific to communities, so respect and careful research matter.$mq$, $mq$medium$mq$),
($mq$A poster from wartime shows a strong worker pointing at the viewer with bold red and white text. Which purpose is most likely?$mq$, $mq$["To record a private memory","To explore abstract forms","To persuade people to support a cause","To decorate a living room"]$mq$, 2, $mq$Direct address, bold colour and clear text are typical of persuasive posters.$mq$, $mq$medium$mq$),
($mq$How can historical events affect artists?$mq$, $mq$["They cannot influence art","They can inspire subject matter, change materials available and influence artists' attitudes","They only affect sculptors","They only affect colour names"]$mq$, 1, $mq$Events such as wars, revolutions or technological change often shape what artists make and how.$mq$, $mq$medium$mq$),
($mq$What does it mean to appropriate imagery from another culture without understanding it?$mq$, $mq$["Using it without respect or knowledge, which can cause offence or misrepresent its meaning","Always giving credit and learning","Learning from teachers","Only using your own culture's images"]$mq$, 0, $mq$Cultural appropriation concerns can arise when sacred or meaningful symbols are used carelessly. Research, credit and respect are important.$mq$, $mq$medium$mq$),
($mq$In many cultures, masks are used in ceremonies. Why is it important not to treat them only as 'decorations'?$mq$, $mq$["They are always made by machines","They are always for tourism","They have no meaning outside museums","They may have spiritual, social or storytelling roles"]$mq$, 3, $mq$Understanding function and meaning avoids misreading objects through only a visual lens.$mq$, $mq$medium$mq$),
($mq$Street art such as graffiti and stencils is sometimes debated. Which is a fair argument in favour of it as art?$mq$, $mq$["It is always legal","It never uses skill","It can express community ideas and bring art to public spaces","It cannot carry messages"]$mq$, 2, $mq$Supporters point to creativity, social commentary and access. Critics raise issues of permission and property.$mq$, $mq$medium$mq$),
($mq$A museum displays a sculpture taken from a country long ago, and that country asks for its return. This raises which kind of issue?$mq$, $mq$["The element of line","Ethics of ownership and cultural heritage","Colour mixing","Printing technique"]$mq$, 1, $mq$Debates about repatriation concern who should own and care for cultural objects.$mq$, $mq$medium$mq$),
($mq$Why might the same artwork be understood differently by people from different cultures?$mq$, $mq$["Symbols, colours and traditions can have different meanings","All symbols are universal","Viewers never bring personal experience","Meaning is always in the title only"]$mq$, 0, $mq$Interpretation is shaped by viewers' backgrounds. Context helps to avoid assuming one meaning.$mq$, $mq$medium$mq$),
($mq$Which question best helps you analyse the relationship between art and society?$mq$, $mq$["How many colours were used?","Is the frame gold?","Was it painted with a large brush?","Who made this, for whom, when, and what was happening around it?"]$mq$, 3, $mq$Asking who, for whom, when and why connects the artwork with the society that shaped it.$mq$, $mq$hard$mq$),
($mq$A series of photographs shows daily life in a community during a flood. How might this art help society?$mq$, $mq$["It can only entertain","It can only be sold","It can document events, build empathy and preserve memory","It cannot influence viewers"]$mq$, 2, $mq$Documentary imagery records history and can move audiences to understand experiences.$mq$, $mq$hard$mq$),
($mq$Two posters use the same bold red. One advertises a charity, the other a political rally. Why might viewers read the colour differently?$mq$, $mq$["Red has a fixed meaning","Context and surrounding images guide interpretation","Posters cannot have meaning","Colour does not matter to audiences"]$mq$, 1, $mq$Meaning is built from colour plus context: text, imagery and setting.$mq$, $mq$hard$mq$),
($mq$Which statement shows the strongest understanding of how an artwork reflects its society?$mq$, $mq$["Its choice of subject, style and materials can show the values, technology and concerns of the time and place","It copies earlier art with no link to its time","Its meaning is private and unrelated to anything outside","Its price is its only link with society"]$mq$, 0, $mq$Artworks are products of their time: materials, technology, beliefs and issues leave visible traces.$mq$, $mq$hard$mq$),
($mq$A student argues that all art in a museum is 'dead history'. Which reply shows balanced thinking?$mq$, $mq$["Old art has no relevance","Only new art matters","Museums only hold fake art","Historic art can still speak to current issues, and contemporary artists often respond to it"]$mq$, 3, $mq$Artists revisit historic works to question or update them, showing art as a continuing dialogue.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Art, Culture and Society$mq$ and p.name = $mq$Art in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Cultural context$mq$, $mq$The beliefs, traditions, history and events of the society in which an artwork was made.$mq$),
($mq$List some functions of art$mq$, $mq$Religious/spiritual, political and persuasive, social commentary, record and memory, identity and community, decoration.$mq$),
($mq$Propaganda art$mq$, $mq$Art made to influence public opinion, often for a political cause, using bold imagery and simple messages.$mq$),
($mq$Public murals$mq$, $mq$Large wall paintings that can express community identity, history or social messages to many viewers.$mq$),
($mq$Cultural appropriation$mq$, $mq$Using elements of another culture without understanding, credit or respect, which can misrepresent or offend.$mq$),
($mq$How does technology shape art?$mq$, $mq$New tools and materials (paint tubes, photography, digital tools) change what artists can make and why.$mq$),
($mq$Documentary art$mq$, $mq$Work such as photography that records real events or lives, preserving memory and building empathy.$mq$),
($mq$Why avoid fixed symbol meanings?$mq$, $mq$Colours and symbols mean different things in different cultures and contexts, so use context and evidence.$mq$),
($mq$Ethics of cultural objects$mq$, $mq$Museums and countries debate who should own, care for and display objects of cultural heritage.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Art, Culture and Society$mq$ and p.name = $mq$Art in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Art is never made in a vacuum. Every artwork is created by someone, at a certain time, in a certain place, for a certain reason. Studying art in its cultural and social setting helps you understand why it looks the way it does and what it meant to its first audience. It is also a core idea behind MYP Arts, where you are asked to think about art in context.

## What is context?
**Context** includes the culture, history, beliefs, technology and events surrounding a work. When you look at a Gothic cathedral window, you see colour and shape, but its context tells you it was made to teach Bible stories to people who could not read. When you see a wartime poster, the context explains its bold colours and direct message.

## Functions of art in society
Art has served many purposes throughout history:
- **Religious or spiritual**: icons, temples, masks used in ceremonies, sacred architecture.
- **Political and persuasive**: propaganda posters, portraits of leaders, protest art.
- **Social commentary**: caricature, documentary photography, art about inequality or the environment.
- **Record and memory**: portraits, landscapes, photography, war memorials.
- **Identity and community**: murals, textiles, traditional patterns, Indigenous art that holds knowledge about land and story.
- **Decoration and enjoyment**: ornamentation in buildings, ceramics, fashion.
Many artworks have more than one function.

## How society shapes art, and art shapes society
Technology changes what artists can do: paint in tubes made outdoor painting easier; photography changed the role of painting; digital tools opened new media. Wars, revolutions and social movements influence subjects and attitudes. At the same time, art can influence society by raising awareness, challenging stereotypes or bringing communities together. A public mural can change how a neighbourhood sees itself.

## Respecting cultures
When you research or reference art from a culture other than your own, take care. Some symbols are sacred or have specific meanings to particular communities. **Cultural appropriation** concerns arise when elements of another culture are borrowed without understanding, credit or respect. A responsible approach is to research from reliable sources, credit the culture and artists, and ask what the work means to the people who made it. Debates about museum collections and the return of cultural objects also show that art involves questions of ownership and ethics.

## Interpreting with care
The same colour or symbol can mean different things in different cultures. Red may mean danger in one place and good luck in another. So avoid fixed rules about meaning; look at the full context and the evidence in the work.

## Common mistakes
- Treating art only as decoration.
- Assuming that your own culture's meanings apply everywhere.
- Describing context with no link back to the visual evidence in the work.
- Treating a culture as one single style, when there is great diversity within it.

## How this is examined
Questions give a short description of an artwork or situation and ask about its purpose, how context influences its meaning, or what ethical issue is raised. Good answers link a feature of the work to a feature of its time or place.

Exam tip: name the context, point to visual evidence, then explain how one explains the other. 'The bold red and direct stare (evidence) suit a wartime recruitment poster (context) because they demand action (effect).'$mq$ from st;

-- Art in Context > Artists' Intentions and Audience
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Art in Context$mq$, 5, 2 from public.subjects s where s.slug = $mq$visual-arts$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Artists' Intentions and Audience$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$visual-arts$mq$ and p.grade = 5 and p.name = $mq$Art in Context$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Artists' Intentions and Audience$mq$ and p.name = $mq$Art in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is an artist's intention?$mq$, $mq$["What the artist hopes to express or achieve with the work","The price they set","The size of the studio","The name of the gallery"]$mq$, 0, $mq$Intention is the purpose or message behind the work, such as to calm, shock, inform or celebrate.$mq$, $mq$easy$mq$),
($mq$Who is the audience of an artwork?$mq$, $mq$["Only the artist's family","Only art critics","The people who made the paint","The people who view or experience it"]$mq$, 3, $mq$The audience may be a gallery visitor, a social media user, a passer-by or a specific community.$mq$, $mq$easy$mq$),
($mq$A poster for a school recycling campaign is designed mainly to:$mq$, $mq$["Show abstract feelings only","Record a private memory","Communicate a message and encourage action","Imitate a famous painting"]$mq$, 2, $mq$Design and campaign work usually has a clear audience and call to action.$mq$, $mq$easy$mq$),
($mq$A children's picture book illustrator chooses bright colours and simple shapes. Which factor most likely influenced this choice?$mq$, $mq$["The artist's age","The intended audience","The book's price","Gallery lighting"]$mq$, 1, $mq$Artists make choices to suit who they are speaking to. Young children respond to bold, clear images.$mq$, $mq$easy$mq$),
($mq$Which medium is likely to reach the largest public audience quickly?$mq$, $mq$["A digital image shared online","A small framed painting in a private home","A sketch in a notebook","A clay pot kept in a drawer"]$mq$, 0, $mq$Online sharing can reach people worldwide almost instantly.$mq$, $mq$easy$mq$),
($mq$A sculptor makes a very large figure for a public square. Which audience consideration matters most?$mq$, $mq$["It should only be understood by art experts","It should be tiny","It should be hidden","It must be visible, durable and appropriate for people of many ages"]$mq$, 3, $mq$Public art needs to work in its space and for diverse viewers.$mq$, $mq$medium$mq$),
($mq$An artist paints a harsh, cluttered street scene in dull colours to make people think about city poverty. Which intention is most likely?$mq$, $mq$["To create pure decoration","To show a joyful holiday","To raise awareness about a social issue","To practise mixing tints"]$mq$, 2, $mq$The subject and mood suggest social commentary rather than celebration or decoration.$mq$, $mq$medium$mq$),
($mq$What is the difference between an artist's intended meaning and a viewer's interpretation?$mq$, $mq$["They are always identical","The artist plans the meaning, but viewers may understand it differently based on their own experience","Viewers' views are always wrong","Artists never have intentions"]$mq$, 1, $mq$Meaning can be shared but also changes with the viewer's background and context.$mq$, $mq$medium$mq$),
($mq$How could an artist find out whether their work communicates as intended?$mq$, $mq$["Ask viewers for feedback and compare their responses with the intention","Never show it to anyone","Only ask people who agree","Change the title and assume it works"]$mq$, 0, $mq$Audience feedback shows whether choices are read as intended and where to refine.$mq$, $mq$medium$mq$),
($mq$An artist includes a title that explains a symbol in a painting. What is the purpose?$mq$, $mq$["To hide the meaning","To reduce emphasis","To change medium","To guide the viewer towards the intended meaning"]$mq$, 3, $mq$Titles and artist statements provide clues about meaning.$mq$, $mq$medium$mq$),
($mq$Why would an artist change the style of a poster when targeting teenagers instead of retired adults?$mq$, $mq$["All audiences have the same tastes","Style is not important","Different audiences respond to different visual languages, trends and platforms","Posters cannot be targeted"]$mq$, 2, $mq$Knowing your audience helps you choose imagery, tone and platform.$mq$, $mq$medium$mq$),
($mq$A performance-based artwork invites visitors to add notes to a wall. What is the aim regarding audience?$mq$, $mq$["To ban viewers","To involve the audience as participants in the work","To keep viewers silent","To sell tickets only"]$mq$, 1, $mq$Participatory art treats viewers as part of the work, changing the usual artist-viewer relationship.$mq$, $mq$medium$mq$),
($mq$A designer wants a charity logo to be read quickly from a distance. Which feature would help?$mq$, $mq$["Simple shapes, strong contrast and a clear colour scheme","Many tiny details","Pale colours on a pale ground","Complicated overlapping text"]$mq$, 0, $mq$Legibility depends on simplicity and contrast, especially for quick, distant reading.$mq$, $mq$medium$mq$),
($mq$Two photographers shoot the same protest. One focuses on a calm child, the other on police and crowds. How may the intention differ?$mq$, $mq$["They must have the same message","Framing never changes meaning","Photographs cannot have intention","Their framing and focus can steer viewers towards different messages"]$mq$, 3, $mq$Selection, framing and emphasis shape interpretation, even in documentary photography.$mq$, $mq$hard$mq$),
($mq$An artwork contains a symbol from a faith tradition. The artist is not a member of that faith. What should they consider?$mq$, $mq$["Ignoring its meaning since symbols are free","Altering it randomly","Researching its meaning and respecting how members of the community view it","Claiming it as their own invention"]$mq$, 2, $mq$Respectful research avoids misrepresentation and offence.$mq$, $mq$hard$mq$),
($mq$A student's artist statement says: 'My work is about nature.' How can it be improved to explain intention more clearly?$mq$, $mq$["Remove the word nature","State what idea about nature, who it is for, and which choices communicate it","Add that the work is good","Write one more word"]$mq$, 1, $mq$A strong statement specifies the idea, audience and how materials, colour and composition serve the aim.$mq$, $mq$hard$mq$),
($mq$A mural was painted to unite a neighbourhood, but residents say it excluded their culture. What does this show?$mq$, $mq$["Intention and audience reception can differ, so consultation matters","Reception always matches intention","Murals never involve communities","Audiences have no say"]$mq$, 0, $mq$Public art works best when audiences are consulted. Even good intentions may not be received as planned.$mq$, $mq$hard$mq$),
($mq$A critic claims: 'We should judge the work only by the artist's stated intention.' What is a limitation of this view?$mq$, $mq$["Artists' aims are never useful","Only the audience's view matters at all times","Intention cannot be stated","A work may communicate meanings the artist did not intend, and the stated aim might not be achieved"]$mq$, 3, $mq$Intention is useful evidence, but the work's visible effects and audience responses also matter.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Artists' Intentions and Audience$mq$ and p.name = $mq$Art in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Artist's intention$mq$, $mq$What the artist wants to express or achieve, such as to inform, persuade, move, record or celebrate.$mq$),
($mq$Audience$mq$, $mq$The person or group who will view or experience the work (a community, children, gallery visitors, online viewers).$mq$),
($mq$Reception$mq$, $mq$How viewers actually understand a work, which can differ from the artist's intention because of their own experiences and cultures.$mq$),
($mq$How can audience affect choices?$mq$, $mq$Style, imagery, medium, platform, scale, placement and symbols may all be chosen to suit the intended audience.$mq$),
($mq$Participatory art$mq$, $mq$Art that involves the audience as active participants who help make or complete the work.$mq$),
($mq$Evidence for intention$mq$, $mq$The artwork itself (subject, colour, composition), the title or artist statement, and the context of making.$mq$),
($mq$Testing communication$mq$, $mq$Show drafts to the intended audience, compare their responses with your intention, then refine.$mq$),
($mq$Strong artist statement$mq$, $mq$Short and specific: names the idea, the audience and how key choices communicate it.$mq$),
($mq$Why consult communities in public art?$mq$, $mq$Intentions may not match reception; consulting audiences avoids exclusion or misrepresentation.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$visual-arts$mq$ and t.grade = 5 and t.name = $mq$Artists' Intentions and Audience$mq$ and p.name = $mq$Art in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Every artist makes choices for a reason. Understanding why an artwork exists and who it is for lets you analyse it more deeply and plan better work of your own. Two linked ideas sit at the centre of this topic: **artist's intention** and **audience**.

## Artist's intention
Intention is what the artist wants to say, show or make people feel. Common intentions include to inform, persuade, entertain, express an emotion, record a moment, celebrate, challenge, raise awareness, or simply explore materials and ideas. Intentions can be personal (a memory), social (a protest) or experimental (testing a technique). Often an artist has several aims at once.

How do you find the intention? Use evidence:
- The artwork itself: subject, colour, composition, medium.
- The title and any artist statement.
- The context in which it was made.
Be careful: the intention you guess may not be the one the artist had. Support your claims with evidence from the work and phrase them tentatively (for example, 'suggests', 'seems to aim').

## Audience
The **audience** is the person or group who will see the work. It might be gallery visitors, children, a local community, social media followers or a client who commissioned a design. Audience affects many decisions:
- **Style and imagery**: bright simple shapes for young children; subtle and complex for specialists.
- **Medium and platform**: a mural for the street, a digital image for online sharing, a small drawing for a sketchbook.
- **Scale and placement**: a huge sculpture in a public square must be visible and durable.
- **Language and symbols**: a symbol must be understood by the people it targets, and treated with respect if it comes from a particular community.
In participatory art the audience even helps complete the work.

## Intention versus reception
The way a viewer understands an artwork (**reception**) may differ from what the artist planned. People bring their own experiences and cultures. A strong artist tests communication: show drafts to your intended audience, ask what they notice and feel, compare this with your intention, and refine your choices. This is an important habit for the Developing Ideas and Presenting and Reflecting stages of your portfolio.

## Writing an artist statement
A good statement is short and clear. It names the idea, the audience, and how key choices communicate it. For example: 'My series explores everyday plastic waste for teenage viewers. I used bright, saturated colours and repetition to show how quickly waste builds up.' Compare with 'My work is about the environment', which is too vague.

## Common mistakes
- Assuming the artist's stated intention is always achieved.
- Forgetting audience when evaluating success.
- Treating intention as the only valid way to judge a work.
- Writing vague aims with no link to the choices made.

## How this is examined
You are asked to match features of a work to an intention or audience, suggest improvements to reach a target audience, or evaluate how well a work communicates. Show you understand that meaning is shared between artist, work and viewer.

Exam tip: always write intention, choice, effect on audience. 'To help young children notice recycling (intention), the illustrator used bold shapes and bright colours (choice), which are easy to read and engaging (effect).'$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('visual-arts')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;