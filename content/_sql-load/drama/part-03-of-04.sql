-- Part 3 of 4: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Creating Drama > Devising Original Work
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Creating Drama$mq$, 5, 3 from public.subjects s where s.slug = $mq$drama$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Devising Original Work$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$drama$mq$ and p.grade = 5 and p.name = $mq$Creating Drama$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Devising Original Work$mq$ and p.name = $mq$Creating Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'devising' mean in drama?$mq$, $mq$["Creating original drama as a group from a starting idea, rather than from a finished script","Memorising a published play word for word","Designing the lighting plan only","Reviewing a performance afterwards"]$mq$, 0, $mq$Devising means making new work, usually collaboratively, from a stimulus instead of performing an existing script.$mq$, $mq$easy$mq$),
($mq$Which of these could be used as a stimulus for devising?$mq$, $mq$["A set of lighting cues","A programme sold in the foyer","A cast list for a past show","A newspaper photograph of an empty playground"]$mq$, 3, $mq$A stimulus is a starting point such as an image, poem, object or headline that sparks ideas.$mq$, $mq$easy$mq$),
($mq$During a brainstorm, what is the best rule?$mq$, $mq$["Reject any idea that sounds strange","Only the director may speak","Collect many ideas first and judge them later","Choose the first idea and stop"]$mq$, 2, $mq$Brainstorming works best when ideas are gathered freely before the group selects and shapes them.$mq$, $mq$easy$mq$),
($mq$What is improvisation?$mq$, $mq$["Reading lines from a script","Making up action and dialogue on the spot","Painting the set","Counting the audience"]$mq$, 1, $mq$Improvisation is unplanned, spontaneous drama and is a key tool for generating material.$mq$, $mq$easy$mq$),
($mq$In an ensemble devising process, who makes creative decisions?$mq$, $mq$["The whole group shares them","Only the tallest performer","Only the person with the most lines","The audience, before the show"]$mq$, 0, $mq$Ensemble work depends on shared ideas, listening and agreement.$mq$, $mq$easy$mq$),
($mq$A group is given a stimulus: a battered suitcase left on a station bench. What is the most useful first step?$mq$, $mq$["Choose the costumes straight away","Write out the final programme notes","Decide the applause timing","Improvise and ask questions: whose is it, why was it left, who is looking for it?"]$mq$, 3, $mq$Early exploration through questions and improvisation generates characters and situations to shape later.$mq$, $mq$medium$mq$),
($mq$Two group members each want a different ending and the argument is taking all the rehearsal. What is the best way forward?$mq$, $mq$["Let the louder person decide","Cut the ending completely","Try both endings in short improvisations and choose the one that best serves the intention","Vote without trying either"]$mq$, 2, $mq$Testing ideas in action lets the group judge them against their artistic intention instead of by volume.$mq$, $mq$medium$mq$),
($mq$A devised piece has five scenes that all have the same quiet, even energy. What would improve the structure most?$mq$, $mq$["Make every scene exactly the same length","Build tension across the scenes towards a clear climax","Remove the beginning","Add more scenery to each scene"]$mq$, 1, $mq$A strong structure varies pace and intensity, rising towards a climax and then resolving.$mq$, $mq$medium$mq$),
($mq$Which is the clearest artistic intention for a devised piece?$mq$, $mq$["To make the audience question how much time they spend on their phones, using isolated characters and repeated notification sounds","To do a play","To have lots of costumes","To last ten minutes"]$mq$, 0, $mq$An intention states the effect on the audience and hints at the methods; the other options are vague or only about format.$mq$, $mq$medium$mq$),
($mq$Which MYP Arts criterion mainly rewards developing original ideas and exploring alternatives when devising?$mq$, $mq$["Criterion A: Knowing and understanding","Criterion B: Developing skills","Criterion D: Responding","Criterion C: Thinking creatively"]$mq$, 3, $mq$Criterion C covers creative thinking, including generating ideas and developing a concept. Each criterion is reported in Levels 1-8.$mq$, $mq$medium$mq$),
($mq$A journal entry reads: 'We played the argument fast and loud, but it hid the sadness, so we slowed it down and lowered our voices.' What does this show?$mq$, $mq$["A description with no opinion","A plan for lighting","Reflection leading to a reasoned change","A list of cast members"]$mq$, 2, $mq$The student tested a choice, judged its effect and changed it, which is evidence of refining work.$mq$, $mq$medium$mq$),
($mq$A group shows a key moment as a still picture. When tapped on the shoulder, each character says what they are thinking aloud. Which technique is this?$mq$, $mq$["Cross-cutting","Thought-tracking","Blackout","Cueing"]$mq$, 1, $mq$Thought-tracking reveals inner thoughts at a frozen moment, often used with tableau.$mq$, $mq$medium$mq$),
($mq$After a work-in-progress showing, a classmate says, 'I did not understand who the old woman was.' What is the best response?$mq$, $mq$["Make the character clearer through voice, posture or a prop, then test it again","Ignore the comment","Remove the old woman and keep the scene the same","Tell the audience to watch more carefully"]$mq$, 0, $mq$Feedback is useful when the group makes a specific adjustment and checks whether it solved the problem.$mq$, $mq$medium$mq$),
($mq$A group devises a piece from a poem about migration. They are worried about stereotypes. What is the best approach?$mq$, $mq$["Use the first exaggerated accent that comes to mind","Avoid giving the characters any detail","Copy a news report word for word","Research carefully and use specific, respectful detail rather than caricature"]$mq$, 3, $mq$Specific, researched, respectful detail makes characters truthful; stereotypes flatten people.$mq$, $mq$hard$mq$),
($mq$A piece must last no more than 10 minutes but the draft runs for 14. What should the group cut first?$mq$, $mq$["Whichever scene is at the end","The best scene, to be fair","Moments that do not support the intention, even if they are favourites","Nothing; they should speak faster"]$mq$, 2, $mq$Shaping means selecting only what serves the intention, even if cutting is hard.$mq$, $mq$hard$mq$),
($mq$A group wants to show growing isolation between two characters across three scenes. Which refinement best does this?$mq$, $mq$["Keep them in the same position each time","Gradually increase the distance and reduce contact between them in each scene","Make them touch more in each scene","Give both characters identical lines"]$mq$, 1, $mq$Spatial relationships can show emotional change; widening distance reflects growing isolation.$mq$, $mq$hard$mq$),
($mq$A group says, 'We improvised for three weeks, so it is devised.' But they have no fixed order, no repeated moments and no shaped ending. What is the fairest judgement?$mq$, $mq$["Improvisation is a tool, but the work still needs selecting, structuring and rehearsing into a performance","The work is finished","The piece is automatically a script","Improvisation can never be used in devising"]$mq$, 0, $mq$Devising includes improvising, but it only becomes a piece when material is shaped, structured and repeated reliably.$mq$, $mq$hard$mq$),
($mq$Which evaluation is strongest?$mq$, $mq$["'It went well and everybody liked it.'","'We did a scene about a family.'","'It was good because it was good.'","'The slow repetition of the word Stay made the room go still; next time I would add a step towards her to show the choice.'"]$mq$, 3, $mq$It names a specific choice, its effect on the audience, and a clear improvement, linking evidence to judgement.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Devising Original Work$mq$ and p.name = $mq$Creating Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Devising$mq$, $mq$Creating original drama, usually as an ensemble, from a stimulus instead of a finished script.$mq$),
($mq$Stimulus$mq$, $mq$A starting point for devising, such as a photograph, poem, object, headline or piece of music.$mq$),
($mq$Artistic intention$mq$, $mq$What the group wants the audience to think, feel or question; it guides every choice.$mq$),
($mq$Improvisation$mq$, $mq$Making up action and dialogue spontaneously to explore and generate material.$mq$),
($mq$Tableau (still image)$mq$, $mq$A frozen picture made by actors to show a moment, relationships and status.$mq$),
($mq$Thought-tracking$mq$, $mq$Characters speak their inner thoughts aloud while the scene is frozen.$mq$),
($mq$Hot-seating$mq$, $mq$Questioning a character, played by an actor in role, to uncover motives and background.$mq$),
($mq$Shaping a devised piece$mq$, $mq$Selecting the best material, ordering it, building to a climax and cutting what does not serve the intention.$mq$),
($mq$Which MYP Arts criterion covers creative thinking?$mq$, $mq$Criterion C: Thinking creatively. Criteria A to D are each assessed in Levels 1-8.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Devising Original Work$mq$ and p.name = $mq$Creating Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Devising means creating original drama, usually as an ensemble, rather than performing a finished script. In MYP Drama it is the heart of Criterion C: Thinking creatively, although it also draws on knowledge (A), skills (B) and reflection (D). Each criterion is assessed in Levels 1-8.

## Starting points
Devising begins with a **stimulus**: a photograph, poem, object, headline, piece of music or a single question. The group explores it through **brainstorming**, discussion and **improvisation**. At this stage there are no wrong ideas. Write down every idea, then explore the promising ones in action, because ideas often look different once they are on their feet.

## Intention and audience
Before shaping the piece, agree an **artistic intention**: what you want the audience to think, feel or question. A weak intention is "to do a play about school". A strong one is "to make the audience uncomfortable about how easily rumours spread, using whispering, overlapping voices and characters turning away". The intention becomes your measuring stick. When you cannot decide between two ideas, test them in short improvisations and ask which better serves the intention.

## Exploring and developing material
Useful techniques include:
- **Still image (tableau)**: freezing a moment to show relationships and status.
- **Thought-tracking**: characters speak their thoughts aloud at a frozen moment.
- **Hot-seating**: questioning a character in role to discover motives.
- **Role play and improvisation**: finding dialogue and conflict spontaneously.
- **Flashback and cross-cutting**: moving between times or places to build meaning.

## Shaping and structure
Material is not a performance until it is shaped. Select the strongest moments, decide an order, and build towards a **climax** rather than keeping the same energy throughout. Think about a clear beginning (who, where, what is wrong), a middle where tension rises, and an ending that resolves or deliberately leaves a question. Use contrast: loud and quiet, fast and slow, movement and stillness. Cut anything that does not support the intention, even if you love it. If a piece must last ten minutes, time it and edit honestly.

## Working as an ensemble
Listen, accept and build on offers from others, share decisions, and disagree respectfully. Give feedback that is specific and kind, for example "the pause before she answered made me nervous", and respond to feedback by changing something and testing again. When representing real communities or sensitive issues, research carefully and avoid stereotypes. Use specific, truthful detail.

## Recording the process
Keep a process journal: ideas, experiments, what worked, what failed, and why you changed things. Evidence of testing alternatives and making reasoned decisions is exactly what shows creative thinking.

## Common mistakes
- Thinking that improvising for weeks equals a finished piece.
- Keeping every scene at the same intensity.
- Having no clear intention, so choices feel random.
- Writing "it went well" without evidence.

## How this is examined
In exam-style practice tasks you may be given a stimulus (for example a short extract or image description) and asked to suggest ideas, justify a structure, choose techniques for a given intention, or evaluate how a group's choices affected the audience. Command terms such as describe, suggest, justify and evaluate decide the depth: justify needs a reason, evaluate needs a judgement supported by evidence.

Exam tip: always link a devising choice to the intention and the audience effect, for example "Widening the distance between the characters shows their growing isolation".$mq$ from st;

-- Creating Drama > Scripts and Dialogue
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Creating Drama$mq$, 5, 3 from public.subjects s where s.slug = $mq$drama$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Scripts and Dialogue$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$drama$mq$ and p.grade = 5 and p.name = $mq$Creating Drama$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Scripts and Dialogue$mq$ and p.name = $mq$Creating Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is dialogue in a script?$mq$, $mq$["Words spoken between characters","Instructions about lighting only","The title page","A list of props"]$mq$, 0, $mq$Dialogue is the spoken exchange between characters.$mq$, $mq$easy$mq$),
($mq$What is a stage direction?$mq$, $mq$["A line spoken by the audience","The name of the playwright","The ticket price","A note in the script about action, setting or delivery that is not spoken aloud"]$mq$, 3, $mq$Stage directions guide movement, setting and tone and are usually in brackets or italics.$mq$, $mq$easy$mq$),
($mq$What is a monologue?$mq$, $mq$["A fight scene","A silent scene","A long speech by one character","A song for the whole cast"]$mq$, 2, $mq$A monologue is an extended speech given by one character, often to reveal thoughts or feelings.$mq$, $mq$easy$mq$),
($mq$In a standard script layout, what usually appears before each line of dialogue?$mq$, $mq$["The cost of the costume","The name of the character speaking","The time of the show","The audience's name"]$mq$, 1, $mq$Scripts label each speech with the speaking character's name so actors know their lines.$mq$, $mq$easy$mq$),
($mq$What is an aside?$mq$, $mq$["A brief remark a character makes directly to the audience","A scene change","A lighting fade","A curtain call"]$mq$, 0, $mq$An aside is spoken to the audience, outside the conversation of the other characters.$mq$, $mq$easy$mq$),
($mq$A character says, 'Lovely party,' while repeatedly checking the door. What does this show?$mq$, $mq$["The party is a success","A scene change","A cue for sound","Subtext: the character really wants to leave"]$mq$, 3, $mq$Subtext is what a character feels or means beneath the words; the actions contradict the line.$mq$, $mq$medium$mq$),
($mq$Which line sounds most like natural spoken dialogue?$mq$, $mq$["'I did indeed promise that I would attend this event.'","'Attendance was promised by me.'","'Well, I... I mean, I did say I'd come, didn't I?'","'Promise. Attend. Indeed.'"]$mq$, 2, $mq$Natural speech includes hesitations, contractions and incomplete sentences.$mq$, $mq$medium$mq$),
($mq$In the line MIA: (looking at the floor) I'm sure it's fine. What does the bracket do?$mq$, $mq$["It is part of Mia's spoken line","It tells the actor what to do while speaking","It is the title of the scene","It is a lighting cue only"]$mq$, 1, $mq$Brackets show action or delivery that suggests the character may not be telling the truth.$mq$, $mq$medium$mq$),
($mq$Which opening is most likely to create immediate conflict?$mq$, $mq$["Dara is leaving; Sam has hidden the keys and says, 'You're not going anywhere.'","Dara and Sam agree about everything","Dara looks at a plant","Sam says hello and Dara says hello back"]$mq$, 0, $mq$Conflict arises when characters want opposite things and the stakes are clear.$mq$, $mq$medium$mq$),
($mq$A line is written: 'You said— No. Listen. I—' What does the punctuation suggest?$mq$, $mq$["A calm, planned speech","A long poem","A scene change","Interruption, urgency and a character struggling to speak"]$mq$, 3, $mq$Dashes and short fragments show breaks in thought, interruption and heightened emotion.$mq$, $mq$medium$mq$),
($mq$A character says, 'As you know, my brother Tom, who lives in Leeds and works at the bank, is coming tomorrow.' What is the main problem?$mq$, $mq$["It has too few words","It is too quiet","It is clumsy exposition: information is told to the audience unnaturally","It uses a stage direction"]$mq$, 2, $mq$Exposition should be revealed naturally through conflict or action rather than characters telling each other what both know.$mq$, $mq$medium$mq$),
($mq$A prose line says, 'She was furious.' How should a scriptwriter convey this?$mq$, $mq$["Write 'She was furious' in the dialogue only","Show it through action and dialogue, for example slamming a door and spitting out short sentences","Remove the character","Leave it for the audience to imagine without any action"]$mq$, 1, $mq$Drama shows emotion through what characters say and do, rather than only stating it.$mq$, $mq$medium$mq$),
($mq$In a short script, what test should every line pass?$mq$, $mq$["It should reveal character or move the story forward","It should be as long as possible","It should rhyme","It should copy the previous line"]$mq$, 0, $mq$In a tight scene, every line should earn its place.$mq$, $mq$medium$mq$),
($mq$Which pair of lines gives two characters distinct voices?$mq$, $mq$["TEO: 'I am Teo.' / RUBY: 'I am Ruby.'","TEO: 'Hello.' / RUBY: 'Hello.'","TEO: 'Yes.' / RUBY: 'Yes.'","TEO: 'Excuse me, I believe this is my seat.' / RUBY: 'Nah, mate, I got here first.'"]$mq$, 3, $mq$Different vocabulary, formality and rhythm give characters distinct voices.$mq$, $mq$hard$mq$),
($mq$A draft line reads: 'I am angry that you lied to me.' Which rewrite creates more tension through subtext?$mq$, $mq$["'I am so very upset.'","'You are a liar and I am angry.'","'You said you were at Tom's.' (Pause.) 'Funny. Tom's mum said you never turned up.'","'Lying is wrong and I feel hurt.'"]$mq$, 2, $mq$The rewrite lets the audience infer anger from evidence and pauses instead of naming the emotion.$mq$, $mq$hard$mq$),
($mq$After a quarrel, Ana says, 'Do you want tea?' Ben says, 'I'm not thirsty,' but does not leave. What is the most likely subtext?$mq$, $mq$["They are talking about the weather only","Ana is offering peace and Ben is still hurt but willing to stay","Ana wants Ben to leave","Ben has forgotten the quarrel"]$mq$, 1, $mq$Offering tea after an argument is a gesture of repair; Ben's refusal with staying shows mixed feelings.$mq$, $mq$hard$mq$),
($mq$A script says '(Pause.)' after a character's revelation. What is the best purpose of this?$mq$, $mq$["To let the shock land and build tension","To make the scene shorter","To signal the end of the play","To hide the actor's mistake"]$mq$, 0, $mq$Silence and pause can carry as much meaning as words.$mq$, $mq$hard$mq$),
($mq$A script direction reads: '(She remembers her childhood.)' Why is this a weak direction?$mq$, $mq$["It uses brackets","It is too short","It mentions the character","The actor cannot show an unseen thought unless it is turned into something visible or audible"]$mq$, 3, $mq$A direction should be playable: rewrite as action, such as touching a faded photograph and smiling faintly.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Scripts and Dialogue$mq$ and p.name = $mq$Creating Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Dialogue$mq$, $mq$Words spoken between characters in a script.$mq$),
($mq$Stage direction$mq$, $mq$A note about action, setting, entrances or delivery; it is not spoken, and is usually in brackets or italics.$mq$),
($mq$Monologue$mq$, $mq$A long speech by one character, often used to reveal thoughts or feelings.$mq$),
($mq$Aside$mq$, $mq$A short remark made directly to the audience, outside the conversation on stage.$mq$),
($mq$Subtext$mq$, $mq$The meaning or feeling beneath the words; what a character really wants to say.$mq$),
($mq$Exposition$mq$, $mq$Background information the audience needs. It should come out naturally, not through clumsy telling.$mq$),
($mq$Objective$mq$, $mq$What a character wants in a scene; the goal that drives the dialogue.$mq$),
($mq$What makes dialogue sound natural?$mq$, $mq$Contractions, short sentences, hesitations, interruptions and silence, as people really speak.$mq$),
($mq$What is a playable stage direction?$mq$, $mq$One an actor can show or hear, such as touching a faded photograph, rather than an unseen thought.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Scripts and Dialogue$mq$ and p.name = $mq$Creating Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$A script is the written plan of a drama. It tells actors what to say and, through stage directions, often how to move, where to stand and how to deliver lines. Writing scripts is a way of developing original ideas in Criterion C, while understanding how scripts work belongs to Criterion A. Each criterion is reported in Levels 1-8.

## Parts of a script
- **Character names** appear before each speech, often in capitals.
- **Dialogue** is what characters say to each other.
- **Stage directions** describe action, setting, entrances, exits, sound or tone. They are usually in brackets or italics and are not spoken.
- **Scenes and acts** divide the story into sections of time or place.
- **Monologue**: one character speaks at length. **Soliloquy**: a character speaks thoughts aloud, alone. **Aside**: a quick remark to the audience.

## Writing believable dialogue
Real people interrupt, hesitate, change direction and rarely say exactly what they feel. Good dialogue therefore uses contractions, short sentences, fragments and silence. Compare "I did indeed promise to attend" with "Well... I did say I'd come, didn't I?" The second sounds like a person. Dashes show interruptions; ellipses show trailing thoughts; (Pause.) controls timing.

## Conflict, objective and subtext
A scene works when characters want something and something stands in the way. Give each character an **objective** and let them use tactics such as pleading, joking or threatening to get it. **Subtext** is the meaning beneath the words. If a character says "Lovely party" while checking the exit, the audience reads the real feeling. Avoid dialogue that simply states emotions ("I am angry") because it leaves the actor and audience nothing to discover. Instead show it: "You said you were at Tom's."

## Exposition and economy
**Exposition** is background information. Do not make characters tell each other things they both know ("As you know, my brother Tom...") just to inform the audience. Let information slip out during conflict. Every line should do at least one job: reveal character, move the story, or build tension. If it does not, cut it.

## Distinct voices
Each character should sound different through vocabulary, rhythm, formality and favourite phrases. A nervous student might speak in broken sentences. A confident captain might give short commands. If you cover the names and cannot tell who is speaking, the voices are too similar.

## Writing playable directions
Stage directions must be things an actor can show. "(She remembers her childhood.)" is not playable. "(She touches the faded photograph and smiles faintly.)" is. Do not overload the script with directions; leave room for the director and actors to interpret.

## Adapting from prose
When turning a story into a script, replace narration with action and dialogue. Instead of "He was nervous", write him fidgeting with his cuffs and stumbling over his words.

## How this is examined
You may be given a short invented extract and asked to identify subtext, explain what a stage direction suggests for an actor, choose the best rewrite to increase tension, or justify how dialogue reveals relationships. Command terms such as identify, explain and suggest set the depth.

Exam tip: when you quote a line, name the technique (such as subtext, interruption or pause) and explain its effect on the audience.$mq$ from st;

-- Creating Drama > Rehearsing and Directing
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Creating Drama$mq$, 5, 3 from public.subjects s where s.slug = $mq$drama$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Rehearsing and Directing$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$drama$mq$ and p.grade = 5 and p.name = $mq$Creating Drama$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Rehearsing and Directing$mq$ and p.name = $mq$Creating Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does a director do?$mq$, $mq$["Leads the artistic vision and guides the actors and designers","Sells tickets","Only paints the set","Only works the lights on the night"]$mq$, 0, $mq$The director shapes the overall interpretation and works with actors and designers.$mq$, $mq$easy$mq$),
($mq$What is blocking?$mq$, $mq$["The scenery sold at the end","The sound of the audience","The scene's title","The planned movement and positions of actors on stage"]$mq$, 3, $mq$Blocking is deciding where and when actors move.$mq$, $mq$easy$mq$),
($mq$What is the purpose of a warm-up?$mq$, $mq$["To learn the lines overnight","To clean the stage","To prepare the voice and body for rehearsal or performance","To choose the costumes"]$mq$, 2, $mq$Warm-ups prevent strain and focus the group.$mq$, $mq$easy$mq$),
($mq$What is a run-through?$mq$, $mq$["Cutting a scene","Performing the piece from start to finish without stopping","Painting the backdrop","Memorising a single line"]$mq$, 1, $mq$A run-through lets the group test pace and flow.$mq$, $mq$easy$mq$),
($mq$What is a cue?$mq$, $mq$["A signal for an action, such as a line, movement or lighting or sound change","A type of costume","A seat number","A ticket"]$mq$, 0, $mq$Cues tell performers and technicians when to act.$mq$, $mq$easy$mq$),
($mq$Which is the most sensible order for a rehearsal process?$mq$, $mq$["Dress rehearsal, then blocking, then reading","Performance, then blocking, then reading","Technical rehearsal, then reading, then dress rehearsal","Blocking, then refining the scenes, then technical rehearsal, then dress rehearsal"]$mq$, 3, $mq$Basic structure comes first; technical elements are added once the scenes are secure.$mq$, $mq$medium$mq$),
($mq$An actor speaks with her back to the audience and the back row cannot hear. What should the director suggest?$mq$, $mq$["Speak more quietly","Stand even closer to the wall","Open the body towards the audience and project the voice","Look at the floor"]$mq$, 2, $mq$Facing the audience and projecting make lines audible without losing truth.$mq$, $mq$medium$mq$),
($mq$Which piece of director feedback is most useful?$mq$, $mq$["'Make it better.'","'Slow the last line and hold eye contact so the threat lands.'","'I didn't like it.'","'Do it again, but good.'"]$mq$, 1, $mq$Useful feedback is specific, actionable and linked to an effect.$mq$, $mq$medium$mq$),
($mq$An actor questions a character in role to understand the character's past and motives. Which rehearsal technique is this?$mq$, $mq$["Hot-seating","Blocking","Prompting","Striking the set"]$mq$, 0, $mq$In hot-seating the actor answers questions as the character.$mq$, $mq$medium$mq$),
($mq$What is the main focus of a technical rehearsal?$mq$, $mq$["Learning the lines for the first time","Selling tickets","Marking the audience seats","Fitting lighting, sound and scene changes to the action"]$mq$, 3, $mq$Technical rehearsals work through cues, and may stop often.$mq$, $mq$medium$mq$),
($mq$What does a stage manager do?$mq$, $mq$["Writes the play","Designs the costumes only","Runs the rehearsal and performance practically, keeping the prompt book and calling cues","Decides the artistic message alone"]$mq$, 2, $mq$The stage manager coordinates people, cues and safety.$mq$, $mq$medium$mq$),
($mq$What makes a dress rehearsal different from earlier run-throughs?$mq$, $mq$["It has no actors","It is performed in full costume with lights and sound as in the final show","It is performed in everyday clothes","It happens before blocking"]$mq$, 1, $mq$A dress rehearsal is the final practice under performance conditions.$mq$, $mq$medium$mq$),
($mq$A scene drags because there are long gaps between lines. Which note best fixes the pace?$mq$, $mq$["Pick up cues so each line follows the last without unplanned gaps","Add pauses after every line","Speak more slowly","Remove all movement"]$mq$, 0, $mq$Quick cue pick-up keeps energy; pauses should be deliberate, not accidental.$mq$, $mq$medium$mq$),
($mq$An actor is repeatedly late to rehearsals, and the group is losing time. What is the best director response?$mq$, $mq$["Remove the actor without warning","Shout at the actor in front of everyone","Ignore it and rehearse without them","Talk privately, agree clear expectations and adjust the schedule if needed"]$mq$, 3, $mq$Fair, respectful communication with clear expectations solves problems while keeping the ensemble working.$mq$, $mq$hard$mq$),
($mq$A director wants a scene to feel claustrophobic on a wide stage. Which blocking choice best does this?$mq$, $mq$["Spread them to the far edges","Have them all stand in a line downstage","Group the characters tightly in a small area, with low levels and little space between them","Leave the middle of the stage empty"]$mq$, 2, $mq$Close grouping and restricted space create a feeling of being trapped.$mq$, $mq$hard$mq$),
($mq$Which journal entry shows the strongest improvement through rehearsal?$mq$, $mq$["'We rehearsed on Tuesday.'","'We tried the line three ways: shouted, whispered, flat. The whisper made the threat clearer, so I kept it and practised breath control.'","'Rehearsal was fine.'","'I forgot some lines but it was okay.'"]$mq$, 1, $mq$It records experiments, a judgement, a decision and follow-up practice.$mq$, $mq$hard$mq$),
($mq$A group has 4 weeks with 2 sessions per week, each 45 minutes. They plan to spend 20% of this total on technical and dress rehearsals. How many minutes is that?$mq$, $mq$["72 minutes","36 minutes","90 minutes","144 minutes"]$mq$, 0, $mq$4 × 2 × 45 = 360 minutes in total; 20% of 360 = 72 minutes.$mq$, $mq$hard$mq$),
($mq$A director and an actor disagree about how to play a confession. What is the best way to settle it?$mq$, $mq$["The director must always win without discussion","The actor must always win","Cut the confession","Discuss the intention, try both versions and choose the one that best serves the audience effect"]$mq$, 3, $mq$Testing both options against the intended effect respects everyone and produces the strongest choice.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Rehearsing and Directing$mq$ and p.name = $mq$Creating Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Director$mq$, $mq$Leads the artistic vision and guides actors and designers to realise the intention.$mq$),
($mq$Blocking$mq$, $mq$The planned movement and positions of actors on stage, usually marked in the script.$mq$),
($mq$Stage manager$mq$, $mq$Runs rehearsals and performances practically, keeps the prompt book, calls cues and helps keep everyone safe.$mq$),
($mq$Run-through$mq$, $mq$Performing the whole piece from start to finish without stopping.$mq$),
($mq$Technical rehearsal$mq$, $mq$A rehearsal for fitting lighting, sound and scene changes to the action; it often stops and restarts.$mq$),
($mq$Dress rehearsal$mq$, $mq$A full run in costume, with lights and sound, as in the real performance.$mq$),
($mq$Cue pick-up$mq$, $mq$Starting your line as soon as the previous one ends, so the pace does not drag.$mq$),
($mq$Hot-seating$mq$, $mq$Answering questions in role to explore a character's background and motives.$mq$),
($mq$What makes a note useful?$mq$, $mq$It is specific, actionable and linked to an effect, such as 'Slow the last line and hold eye contact so the threat lands.'$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Rehearsing and Directing$mq$ and p.name = $mq$Creating Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Rehearsal is where ideas become performance. In MYP Drama, rehearsing and directing connect most closely to Criterion B: Developing skills, because you practise and refine, and Criterion D: Responding, because you evaluate what you try. Each criterion is reported in Levels 1-8.

## Roles in rehearsal
- **Director**: leads the artistic vision, makes interpretation decisions, gives notes and guides actors and designers.
- **Stage manager**: organises rehearsals, keeps the prompt book (a marked-up script with cues and blocking), calls cues and helps keep the space safe.
- **Actors**: bring characters to life, offer ideas, learn lines and take notes.
- **Designers and technicians**: create lighting, sound, set and costume that support the intention.

## A sensible rehearsal sequence
1. **Read-through** to understand the story and intention.
2. **Blocking**: deciding where and when actors move. Mark it in the script in pencil.
3. **Working scenes**: refining objectives, relationships, voice and movement.
4. **Run-throughs**: performing without stopping to check flow and pace.
5. **Technical rehearsal**: adding lighting, sound and scene changes, often stopping to fix cues.
6. **Dress rehearsal**: a full performance with costume, lights and sound, as for the audience.

Planning time helps. If you have 4 weeks with 2 sessions a week of 45 minutes each, you have 360 minutes in total. Deciding that 20% will be used for technical and dress rehearsal gives 72 minutes, so you know how long you have for earlier stages.

## Rehearsal techniques
- **Hot-seating**: answering questions in role.
- **Still image and thought-tracking** to explore relationships.
- **Repeating a line in different ways**: shouted, whispered, flat, to discover what works.
- **Cue pick-up**: starting your line as soon as the previous one ends so the scene does not drag. Pauses should be chosen, not accidental.
- **Warm-ups**: voice and body, to protect yourself and focus the group.

## Directing choices
A director thinks about the intention and the audience. Blocking can tell a story: characters grouped tightly can feel trapped; wide distance can show isolation; a character on a higher level can seem powerful. Always check sightlines so the audience can see important action, and remind actors to open their bodies towards the audience and to project.

## Giving and taking notes
Useful notes are specific and tied to an effect: "Slow the last line and hold eye contact so the threat lands." Weak notes, such as "make it better", give no direction. Actors should listen, try the note and report how it felt. If you disagree, suggest testing both versions and judge by the intended effect.

## Professional behaviour
Arrive on time, bring a pencil, stay focused, support the ensemble and be respectful. If problems arise, such as lateness, talk privately and agree clear expectations.

## Recording progress
Keep notes of what you tried, why, and what happened. A good entry records an experiment, a judgement and the next step.

## How this is examined
You might be given a short rehearsal scenario and asked to choose the best direction note, identify a rehearsal stage, plan time sensibly, or justify blocking choices. Command terms such as suggest, justify and evaluate set the depth.

Exam tip: tie every directing or rehearsal decision to the effect on the audience and to the group's intention, not to personal preference.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('drama')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;