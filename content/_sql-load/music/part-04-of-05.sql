-- Part 4 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Performing and Composing > Performance Skills
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Performing and Composing$mq$, 5, 4 from public.subjects s where s.slug = $mq$music$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Performance Skills$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$music$mq$ and p.grade = 5 and p.name = $mq$Performing and Composing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Performance Skills$mq$ and p.name = $mq$Performing and Composing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which posture helps a singer or instrumentalist most?$mq$, $mq$["Sitting or standing tall with relaxed shoulders","Slouching to save energy","Tensing the neck and shoulders","Looking down at the floor"]$mq$, 0, $mq$Good, relaxed posture frees breathing and movement and reduces the risk of strain.$mq$, $mq$easy$mq$),
($mq$Why should performers warm up before playing?$mq$, $mq$["To make the piece shorter","To get a louder sound only","To avoid reading music","To prepare the body and instrument and reduce the risk of injury"]$mq$, 3, $mq$Warm-ups loosen muscles, focus attention and prepare the voice or hands.$mq$, $mq$easy$mq$),
($mq$What does 'intonation' mean?$mq$, $mq$["How fast the piece is played","How loudly a note is played","How accurately the pitch is played or sung","How long a note lasts"]$mq$, 2, $mq$Good intonation means being in tune. A tuner or careful listening helps.$mq$, $mq$easy$mq$),
($mq$What is meant by playing 'in time'?$mq$, $mq$["Playing as fast as possible","Keeping a steady pulse and accurate rhythms","Playing only loud notes","Ignoring the other performers"]$mq$, 1, $mq$Keeping time means the beat stays steady and note lengths are correct.$mq$, $mq$easy$mq$),
($mq$What does 'expression' add to a performance?$mq$, $mq$["Dynamics, phrasing and character that convey the mood","Only extra notes","A faster tempo","More performers"]$mq$, 0, $mq$Expressive playing shapes phrases with dynamics, articulation and tone colour so that the music communicates.$mq$, $mq$easy$mq$),
($mq$What is 'sight-reading'?$mq$, $mq$["Performing from memory","Improvising a solo","Tuning an instrument","Performing music from notation you have not seen before"]$mq$, 3, $mq$Sight-reading tests how well you can read rhythm, pitch and markings quickly.$mq$, $mq$medium$mq$),
($mq$A singer uses breath support. Which description is correct?$mq$, $mq$["Taking tiny breaths in the upper chest","Holding the breath between phrases","Controlled breathing using the lower body so the sound stays steady","Breathing only at the end of a song"]$mq$, 2, $mq$Support from the diaphragm and lower abdomen gives control, longer phrases and a healthier sound.$mq$, $mq$medium$mq$),
($mq$In an ensemble, what is the best way to keep together?$mq$, $mq$["Play as loudly as you can","Listen to the others and watch the leader or conductor","Ignore the pulse and follow your own part","Look only at your own music"]$mq$, 1, $mq$Ensemble skills include listening, watching cues and adjusting to the group.$mq$, $mq$medium$mq$),
($mq$What does the term 'articulation' refer to in performing?$mq$, $mq$["How notes are started and joined, such as legato or staccato","The pitch of the note","The speed of the music","The size of the audience"]$mq$, 0, $mq$Articulation shapes the beginning, length and connection of notes.$mq$, $mq$medium$mq$),
($mq$Which strategy helps a performer manage nerves before a concert?$mq$, $mq$["Avoiding practice","Skipping the warm-up","Playing faster than usual","Regular practice, slow breathing and positive preparation"]$mq$, 3, $mq$Thorough preparation and calm breathing build confidence. Rushing or avoiding practice increases anxiety.$mq$, $mq$medium$mq$),
($mq$Why might a performer practise with a metronome?$mq$, $mq$["To make the instrument louder","To change key","To develop a steady tempo and accurate rhythms","To improve tone colour only"]$mq$, 2, $mq$A metronome clicks a steady pulse, so it shows whether you rush or drag.$mq$, $mq$medium$mq$),
($mq$What is 'technical control' on an instrument?$mq$, $mq$["Owning an expensive instrument","Accurate use of fingers, bow, breath or voice to produce the intended sound","Playing only simple music","Using a microphone"]$mq$, 1, $mq$Technique includes fingering, bowing, breath and embouchure that let a performer play accurately and fluently.$mq$, $mq$medium$mq$),
($mq$Which behaviour shows 'fluency' in a performance?$mq$, $mq$["Playing without hesitations or stops","Stopping at every mistake","Playing with the music upside down","Repeating each bar twice"]$mq$, 0, $mq$Fluent playing flows smoothly from one phrase to the next.$mq$, $mq$medium$mq$),
($mq$A student plays all notes correctly but the high passages are consistently flat. Which feedback is most useful?$mq$, $mq$["Play the passages louder","Play the whole piece faster","Skip the passages","Practise those passages slowly with a tuner and listen to the pitch"]$mq$, 3, $mq$Flat means below the correct pitch. Slow practice with a tuner trains the ear and the technique.$mq$, $mq$hard$mq$),
($mq$A band's guitar solo is hard to hear over the drums and bass during the melody. What is the problem?$mq$, $mq$["Wrong key signature","Incorrect clef","Poor balance between parts","Too many bars"]$mq$, 2, $mq$Balance means each part is heard at the right level. Accompanying parts should usually be softer than the melody.$mq$, $mq$hard$mq$),
($mq$In a choir, the singers speed up during the loud, exciting sections without meaning to. What is this called?$mq$, $mq$["Rubato","Rushing","Ritardando","Syncopation"]$mq$, 1, $mq$Rushing is unintentional speeding up. Rubato is an intentional, expressive change of tempo.$mq$, $mq$hard$mq$),
($mq$After an hour of drumming a student feels sharp wrist pain. What is the best response?$mq$, $mq$["Stop, rest, check technique and practise in shorter sessions","Keep playing through the pain","Play harder to warm up","Ignore it"]$mq$, 0, $mq$Pain is a warning sign. Rest, correct technique and shorter, regular practice reduce the risk of overuse injuries.$mq$, $mq$hard$mq$),
($mq$Which practice plan is most effective for a concert in four weeks?$mq$, $mq$["One long session the night before","Playing the whole piece once a week","Practising only the easy sections","Short sessions most days, with slow work on difficult bars"]$mq$, 3, $mq$Regular, spaced and focused practice helps memory and technique much more than last-minute cramming.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Performance Skills$mq$ and p.name = $mq$Performing and Composing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Intonation$mq$, $mq$Playing or singing accurately in tune.$mq$),
($mq$Rushing vs dragging$mq$, $mq$Rushing = unintentionally speeding up. Dragging = unintentionally slowing down.$mq$),
($mq$Articulation$mq$, $mq$How notes are started and joined, for example legato or staccato.$mq$),
($mq$Fluency$mq$, $mq$Playing smoothly and continuously without hesitations.$mq$),
($mq$Ensemble skills$mq$, $mq$Listening, watching the leader, balance, blending and tuning with others.$mq$),
($mq$Balance$mq$, $mq$Each part is heard at the right level; the melody leads and accompaniment supports.$mq$),
($mq$Sight-reading$mq$, $mq$Performing from notation you have not seen before.$mq$),
($mq$Safe practice$mq$, $mq$Warm up, take breaks, use relaxed technique, stop if there is pain and protect hearing.$mq$),
($mq$Effective practice$mq$, $mq$Short, regular, focused sessions: slow work, metronome, repeat difficult bars.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Performance Skills$mq$ and p.name = $mq$Performing and Composing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What makes a good performance?
Performing is more than playing the right notes. It combines **technical skill**, **musical understanding** and **communication with an audience**. Whether you sing, play an instrument or use technology, the same core skills apply.

## Technique
- **Accuracy of pitch (intonation)**: playing or singing in tune. Use a tuner and your ears.
- **Accuracy of rhythm and tempo**: keeping a steady pulse and correct note lengths. Avoid **rushing** (speeding up unintentionally) and **dragging** (slowing down).
- **Tone quality**: producing a clear, controlled sound, through bow control, breath support, embouchure or touch.
- **Articulation**: how notes begin and connect, such as legato or staccato.
- **Fluency**: playing smoothly without hesitations.
- **Posture and breathing**: sit or stand tall and relaxed. Singers and wind players need breath support from the lower body.

## Expression and interpretation
Expression turns correct notes into music. Use **dynamics**, **phrasing**, **tempo changes** such as rubato and **tone colour** to show the character of the piece. Read the markings in the score, but also think about the style and the period. A lively dance needs rhythmic energy, while a lyrical melody needs long, smooth phrases.

## Ensemble skills
Playing with others adds extra skills:
- **Listening** to balance your part with the others.
- **Watching** the conductor or leader for starts, stops and tempo changes.
- **Balance**: the melody should stand out and accompanying parts should support.
- **Blend and tuning**: matching tone and pitch with the group.
- **Responding** to what others do, especially in improvised styles.

## Preparing and staying healthy
- Warm up before you play to prepare muscles and reduce injury risk.
- Practise **regularly in short, focused sessions**. Slow practice, repetition of difficult bars and use of a metronome build accuracy before speed.
- Take breaks, keep a relaxed posture and stop if you feel pain. Overuse injuries can occur if you play too long with tension.
- Protect your hearing in loud rehearsals with sensible volume and breaks.
- Manage nerves with preparation, steady breathing and positive thinking.

## Sight-reading
Sight-reading is performing from music you have not seen. Check the key and time signature first, scan for tricky rhythms, set a steady tempo and keep going even if you make a mistake.

## Common mistakes
- Playing too fast too soon, which locks in errors.
- Ignoring dynamics and phrasing markings.
- Stopping at every mistake instead of keeping the pulse.
- Practising only the parts you already play well.

## How this is examined
You may be asked to identify which skill is weak in a described performance, choose the best practice strategy, explain how an ensemble can improve balance, or justify a safe-practice routine. Match each problem to its cause and a specific fix.

Exam tip: Name the skill (intonation, rhythm, balance, expression), say what went wrong, then give a specific practice method to improve it.$mq$ from st;

-- Performing and Composing > Composing and Improvising
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Performing and Composing$mq$, 5, 4 from public.subjects s where s.slug = $mq$music$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Composing and Improvising$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$music$mq$ and p.grade = 5 and p.name = $mq$Performing and Composing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Composing and Improvising$mq$ and p.name = $mq$Performing and Composing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is improvisation?$mq$, $mq$["Making up music on the spot while performing","Writing every note on paper first","Copying a recording exactly","Tuning an instrument"]$mq$, 0, $mq$In improvisation, the performer creates melodies or rhythms in the moment, as in jazz and Indian classical music.$mq$, $mq$easy$mq$),
($mq$What is composing?$mq$, $mq$["Playing someone else's tune from memory","Listening to a recording","Tuning a guitar","Creating original music, then shaping and recording or writing it"]$mq$, 3, $mq$Composing involves developing ideas, structuring them and recording or notating the result.$mq$, $mq$easy$mq$),
($mq$What is a motif?$mq$, $mq$["A very long piece","A change of key","A short musical idea that can be developed","A type of drum"]$mq$, 2, $mq$A motif can be a few notes or a rhythm that is repeated and changed to build a piece.$mq$, $mq$easy$mq$),
($mq$What is a 'hook' in a song?$mq$, $mq$["A music stand","A short catchy musical idea that stays in the listener's memory","A silent bar","The last chord"]$mq$, 1, $mq$Hooks are often melodic or rhythmic and are repeated, especially in the chorus.$mq$, $mq$easy$mq$),
($mq$What effect does repetition have in a composition?$mq$, $mq$["It makes ideas familiar and memorable","It always makes music boring","It speeds the tempo","It removes the melody"]$mq$, 0, $mq$Repetition builds unity and recognition, but it should be balanced with contrast.$mq$, $mq$easy$mq$),
($mq$What is 'augmentation' of a motif?$mq$, $mq$["Making its notes shorter","Playing it backwards only","Playing it quieter","Making its note values longer"]$mq$, 3, $mq$Augmentation lengthens note values, often doubling them. The opposite is diminution.$mq$, $mq$medium$mq$),
($mq$What does 'inversion' do to a motif?$mq$, $mq$["Repeats it exactly","Doubles its speed","Turns its intervals upside down","Changes its instrument"]$mq$, 2, $mq$If the motif rose by a step, the inversion falls by a step.$mq$, $mq$medium$mq$),
($mq$A composer wants to develop a four-note motif. Which technique does NOT develop it?$mq$, $mq$["Repeating it in sequence","Playing it note for note unchanged in the same place for the whole piece","Changing its rhythm","Playing it in a different register"]$mq$, 1, $mq$Development means changing something, such as pitch, rhythm or timbre. Exact unchanged repetition just repeats it.$mq$, $mq$medium$mq$),
($mq$Which chords form a basic progression in C major?$mq$, $mq$["C, F, G, C","C, D, E, F","C, C♯, D, D♯","A, B, C, D"]$mq$, 0, $mq$I–IV–V–I in C major is C, F, G, C. It is a simple, strong progression.$mq$, $mq$medium$mq$),
($mq$An improviser in a 12-bar blues in C often uses which scale?$mq$, $mq$["The chromatic scale only","A whole-tone scale only","A scale of one note","The blues scale"]$mq$, 3, $mq$The blues scale includes 'blue notes' that give a bluesy colour over the chords.$mq$, $mq$medium$mq$),
($mq$Why plan the structure of a composition before writing it?$mq$, $mq$["To avoid using any ideas","To make the music louder","To give the piece shape, contrast and a clear ending","To use fewer instruments"]$mq$, 2, $mq$A plan such as ABA helps balance repetition and contrast.$mq$, $mq$medium$mq$),
($mq$A brief asks you to compose music for a thunderstorm. Which choice best fits?$mq$, $mq$["A quiet, steady lullaby","Tremolo strings, timpani rolls and a big crescendo","Light, bouncy staccato in a major key throughout","A single sustained flute note only"]$mq$, 1, $mq$Tremolo, drum rolls and dynamic build-ups suggest rumbling and growing power.$mq$, $mq$medium$mq$),
($mq$What is the advantage of using a digital audio workstation (DAW) to compose?$mq$, $mq$["You can record, edit, layer and replay ideas easily","It removes the need for ideas","It stops you making mistakes automatically","It plays instruments without sounds"]$mq$, 0, $mq$DAWs let composers experiment with layers and structure, and then refine them.$mq$, $mq$medium$mq$),
($mq$A motif is C–D–E in crotchets. It is repeated as a sequence starting on D within C major. Which notes are played?$mq$, $mq$["D–E–F♯","C–D–E","E–F–G","D–E–F"]$mq$, 3, $mq$A sequence moves the same shape up a step: C D E becomes D E F in C major. F♯ would leave the key.$mq$, $mq$hard$mq$),
($mq$A motif has two crotchets and a minim, lasting 4 beats. It is used in augmentation by doubling the note values. How long is it now?$mq$, $mq$["6 beats","2 beats","8 beats","4 beats"]$mq$, 2, $mq$Doubling every value gives 2 + 2 + 4 = 8 beats. Diminution would halve them to 2 beats.$mq$, $mq$hard$mq$),
($mq$A composer's piece 'Sunrise' lasts 60 seconds. Which plan best matches the title?$mq$, $mq$["Loud and thick throughout with no change","Thin, low and quiet at first, then rising melody, crescendo and fuller texture","A fast, chaotic rhythm only","One long note from start to finish"]$mq$, 1, $mq$The musical build-up of pitch, dynamics and texture mirrors light growing.$mq$, $mq$hard$mq$),
($mq$A composer feels a piece is monotonous. Which change best adds contrast?$mq$, $mq$["Change the dynamics, texture, key or instrument in the middle","Repeat the first section four more times","Remove the ending","Play everything at the same volume"]$mq$, 0, $mq$Contrast in dynamics, texture, key or timbre keeps the listener engaged.$mq$, $mq$hard$mq$),
($mq$Why can a composition be more refined than an improvisation?$mq$, $mq$["Composers cannot change anything","Improvisers always make more mistakes","Compositions must be longer","The composer can revise and edit before the final version"]$mq$, 3, $mq$Improvisation is spontaneous, while composition lets you redraft until the ideas work.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Composing and Improvising$mq$ and p.name = $mq$Performing and Composing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Composing vs improvising$mq$, $mq$Composing: creating and refining original music. Improvising: making it up on the spot.$mq$),
($mq$Motif$mq$, $mq$A short musical idea that can be repeated and developed.$mq$),
($mq$Hook$mq$, $mq$A catchy short idea that sticks in the listener's mind, often in the chorus.$mq$),
($mq$Sequence$mq$, $mq$A motif repeated at a higher or lower pitch, e.g. C D E then D E F.$mq$),
($mq$Augmentation / diminution$mq$, $mq$Augmentation lengthens note values (often doubling). Diminution shortens them (often halving).$mq$),
($mq$Inversion$mq$, $mq$Turning a motif's intervals upside down.$mq$),
($mq$I–IV–V–I in C major$mq$, $mq$Chords C, F, G, C. A basic, strong progression.$mq$),
($mq$Blues scale$mq$, $mq$A scale with 'blue notes' used for improvising over 12-bar blues.$mq$),
($mq$DAW$mq$, $mq$Digital audio workstation: software for recording, layering and editing music.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Composing and Improvising$mq$ and p.name = $mq$Performing and Composing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Composing and improvising
**Composing** is creating original music, then shaping it into a final version that can be performed, written or recorded. **Improvising** is creating music spontaneously as you perform, usually within a style or framework such as a chord pattern, scale or raga. Both need musical ideas, but composers can redraft, while improvisers must respond in the moment.

## Starting points
Composition begins with a **stimulus** or **brief**. This could be a picture, a poem, a mood, an event or a set of musical constraints. Start by listening to examples, collecting ideas and choosing your instruments, key, tempo and structure. Think about the intended audience and purpose.

## Developing ideas
A **motif** is a short musical idea. A **hook** is a catchy motif that stays in the listener's memory. To develop a motif you can:
- **Repeat** it, to establish it.
- Use **sequence**: repeat it at a higher or lower pitch. If C D E becomes D E F, that is a sequence.
- **Invert** it: turn the intervals upside down.
- **Augment** it (lengthen the note values) or use **diminution** (shorten them). Doubling the notes of a 4-beat motif makes it 8 beats.
- Change its rhythm, **register**, dynamics, instrument or harmony.

## Structure and harmony
Plan the **structure**, for example ABA, verse-chorus or rondo. Use repetition for unity and contrast for variety. Compose a **chord progression** that fits your key. A simple progression in C major is C, F, G, C (I–IV–V–I). A good ending, such as a perfect cadence (V–I), gives a sense of finish. Decide on texture and dynamics, building the music towards a climax and back, if appropriate.

## Improvising
To improvise, you need a framework. For example, a blues improviser might use the **blues scale** over a 12-bar blues in C. Improvise short phrases, repeat and vary a motif, leave space and listen to the other players. Start simply and build confidence. Recording your improvisations lets you hear what worked and can give you ideas to use later.

## Tools
You can compose with notation, an instrument, or a **digital audio workstation (DAW)**. A DAW lets you record, layer and edit sound, copy and paste sections, and try different instruments quickly. Always save multiple versions.

## Common mistakes
- Writing many unconnected ideas with no repetition.
- Repeating too much, with no contrast.
- Forgetting that the composition must fit the brief.
- Mixing up augmentation (longer) and diminution (shorter).

## How this is examined
You may be given a brief and asked which choices of instruments, structure and techniques would fit it best. Others may involve working out the notes of a sequence or the length of an augmented motif. Reasoning must connect each musical decision to the intention.

Exam tip: For every compositional choice, finish the sentence 'I did this in order to...' with the effect you wanted.$mq$ from st;

-- Performing and Composing > Rehearsal and Evaluation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Performing and Composing$mq$, 5, 4 from public.subjects s where s.slug = $mq$music$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Rehearsal and Evaluation$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$music$mq$ and p.grade = 5 and p.name = $mq$Performing and Composing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Rehearsal and Evaluation$mq$ and p.name = $mq$Performing and Composing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Why do musicians rehearse?$mq$, $mq$["To improve and prepare the music for performance","To avoid performing","To shorten the piece","To tune the instruments only"]$mq$, 0, $mq$Rehearsal is where you fix problems, build fluency and make musical decisions together.$mq$, $mq$easy$mq$),
($mq$Why is recording a rehearsal useful?$mq$, $mq$["It makes you perform faster","It replaces practising","It tunes your instrument","You can listen back and spot strengths and weaknesses"]$mq$, 3, $mq$Recordings reveal things you cannot hear while you play, such as balance and rhythm errors.$mq$, $mq$easy$mq$),
($mq$What is a good way to practise a difficult passage?$mq$, $mq$["Play it once at full speed","Skip it","Play it slowly and repeat it, then gradually speed up","Play it as loudly as possible"]$mq$, 2, $mq$Slow, repeated practice builds accuracy, and speed can be increased in small steps.$mq$, $mq$easy$mq$),
($mq$Why is feedback from a teacher or peer helpful?$mq$, $mq$["It always gives the final mark","It gives you a fresh view of what to improve","It makes rehearsal unnecessary","It stops mistakes from existing"]$mq$, 1, $mq$Others notice things you do not and can suggest next steps.$mq$, $mq$easy$mq$),
($mq$Which is a useful goal for a rehearsal?$mq$, $mq$["Play bars 9 to 16 without errors at the target tempo","Do better","Play more","Be good"]$mq$, 0, $mq$A clear, specific goal is easier to plan and check than a vague one.$mq$, $mq$easy$mq$),
($mq$Which goal is the most SMART (specific, measurable, achievable, relevant, time-bound)?$mq$, $mq$["Get better at the piece","Practise a lot","Be famous","Play bars 9–16 at 80 BPM with no errors by Friday"]$mq$, 3, $mq$This goal says what, how well and by when. The others are vague.$mq$, $mq$medium$mq$),
($mq$What should a rehearsal log include?$mq$, $mq$["Only the date","Only your mark","What you practised, problems found and solutions tried","Nothing, to save time"]$mq$, 2, $mq$A log shows progress and the thinking behind your choices, which is helpful evidence for reflection.$mq$, $mq$medium$mq$),
($mq$What are the three parts of a good evaluation?$mq$, $mq$["Date, time and place","Strengths, weaknesses and next steps","Title, length and key","Volume, speed and pitch"]$mq$, 1, $mq$An evaluation judges what worked, what did not and what to do next.$mq$, $mq$medium$mq$),
($mq$What does 'chunking' mean in rehearsal?$mq$, $mq$["Dividing a piece into small sections and mastering each one","Playing it all at once","Skipping sections","Changing the key"]$mq$, 0, $mq$Working on small chunks makes practice more focused and prevents repeating mistakes.$mq$, $mq$medium$mq$),
($mq$A teacher suggests you shape the phrase in bar 5 with a crescendo. What should you do?$mq$, $mq$["Ignore it","Play it louder everywhere","Stop rehearsing","Try the suggestion, listen to the result and decide how to use it"]$mq$, 3, $mq$Good musicians respond to feedback by experimenting and then judging the effect.$mq$, $mq$medium$mq$),
($mq$What is the purpose of a sound check before a concert?$mq$, $mq$["To tune only the drums","To decide the order of pieces","To set the balance and volume of voices and instruments","To sell tickets"]$mq$, 2, $mq$A sound check ensures that every part is heard and the equipment works.$mq$, $mq$medium$mq$),
($mq$Why should the group agree a plan before rehearsal?$mq$, $mq$["So nobody has to practise at home","So time is used on the sections that need work","So nobody speaks","So the concert is shorter"]$mq$, 1, $mq$An agenda helps the group focus on goals such as the ending or tricky transitions.$mq$, $mq$medium$mq$),
($mq$Why is a process journal useful in the ePortfolio?$mq$, $mq$["It shows your development, decisions and reflections over time","It replaces the performance","It lists other people's work","It is not needed"]$mq$, 0, $mq$The ePortfolio rewards evidence of development and reflection, not just the final product.$mq$, $mq$medium$mq$),
($mq$A student starts at 60 BPM and aims to perform at 100 BPM, raising the tempo by 10 BPM each time. How many tempo steps are needed?$mq$, $mq$["3","5","6","4"]$mq$, 3, $mq$The tempos are 70, 80, 90 and 100, which is 4 steps.$mq$, $mq$hard$mq$),
($mq$Which evaluation sentence is strongest?$mq$, $mq$["The performance was fine","It was bad","The trumpet entry in bar 12 was late; practising with a metronome should fix this","I did not like it"]$mq$, 2, $mq$The best evaluations give evidence, a judgement and a next step.$mq$, $mq$hard$mq$),
($mq$Feedback says: 'You rush in bar 17.' What is the best action?$mq$, $mq$["Play it faster","Practise bar 17 slowly with a metronome, record it and compare","Remove the bar","Change the key"]$mq$, 1, $mq$The metronome shows where you speed up, and recording checks improvement.$mq$, $mq$hard$mq$),
($mq$A quartet rehearsal keeps ending in arguments. Which action will help most?$mq$, $mq$["Agree roles, a plan and a way to give kind, specific feedback","Rehearse alone","Stop the group","Play louder"]$mq$, 0, $mq$Clear roles and respectful feedback let a group solve problems.$mq$, $mq$hard$mq$),
($mq$What is the difference between describing and evaluating a performance?$mq$, $mq$["Describing gives a mark","Evaluating only lists notes","There is no difference","Evaluating judges quality with reasons and suggests improvements"]$mq$, 3, $mq$Description says what happened, but evaluation says how well and why, and what to change.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Rehearsal and Evaluation$mq$ and p.name = $mq$Performing and Composing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Purpose of rehearsal$mq$, $mq$To refine technique, solve problems, build confidence and make musical decisions.$mq$),
($mq$SMART goal$mq$, $mq$Specific, Measurable, Achievable, Relevant, Time-bound.$mq$),
($mq$Chunking$mq$, $mq$Dividing a piece into small sections and mastering each one.$mq$),
($mq$Why use a metronome?$mq$, $mq$To keep a steady tempo and see where you rush or drag.$mq$),
($mq$Rehearsal log$mq$, $mq$A record of what was practised, problems found, solutions tried and what was learned.$mq$),
($mq$Why record rehearsals?$mq$, $mq$To listen back and hear strengths and weaknesses you may miss while playing.$mq$),
($mq$Good feedback is...$mq$, $mq$Specific, kind and helpful, with a suggestion, e.g. 'bar 17 rushes; try the metronome'.$mq$),
($mq$Evaluation has three parts$mq$, $mq$Strengths, weaknesses and next steps, all with evidence.$mq$),
($mq$Sound check$mq$, $mq$A pre-performance test of volume and balance of voices and instruments.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Rehearsal and Evaluation$mq$ and p.name = $mq$Performing and Composing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why rehearse?
Rehearsal is the stage between learning the notes and giving a performance. It is where you refine technique, make musical decisions, fix problems and build confidence. Effective rehearsal is **planned**, **focused** and **reflective**. In MYP Music your ePortfolio rewards evidence of your development, so how you rehearse and what you learn matters as well as the final result.

## Setting goals
Start each session by setting a **goal**. A strong goal is **SMART**: specific, measurable, achievable, relevant and time-bound. For example: 'Play bars 9–16 at 80 BPM without errors by Friday.' This is much better than 'get better at the piece'. Break big goals into smaller steps, such as raising the tempo in stages: 60, 70, 80, 90, 100 BPM.

## Effective rehearsal strategies
- **Warm up** first.
- **Chunk** the piece: divide it into sections and master each one.
- Work **slowly** on hard passages, then increase speed gradually.
- Use a **metronome** to check the pulse.
- Repeat difficult bars, but think about what is wrong each time.
- **Record** your rehearsal and listen back, noticing intonation, rhythm, balance and expression.
- In groups, agree a **plan** and roles, and listen carefully to each other. Run through transitions and endings, which often go wrong.
- Do a **sound check** if you are using amplification, so the balance is right.

## Using feedback
Ask teachers and peers for **specific** feedback, such as 'I rushed bar 17' rather than 'it was fine'. Try suggestions, listen to the result and decide whether it improves the music. Group feedback should be kind, specific and helpful.

## Keeping a record
A **rehearsal log** or **process journal** records what you practised, problems you found, solutions you tried and what you learned. Include photos, recordings or annotated scores. This is strong evidence for your ePortfolio.

## Evaluating
To **evaluate**, you judge how successful something was and give reasons. A good evaluation names **strengths**, **weaknesses** and **next steps**, with evidence. Compare this with simply describing, which says only what happened. A useful sentence is: 'The balance was good in the chorus because the guitar played quietly, but I came in late in bar 12, so next time I will count the rest aloud.'

## Common mistakes
- Always playing from the beginning rather than isolating difficult sections.
- Speeding up before the notes are secure.
- Giving vague feedback such as 'good job'.
- Writing a log with no reflection.

## How this is examined
Questions might ask you to choose the best goal, put rehearsal steps in order, work out the number of tempo steps, or judge which evaluation statement is most useful. Make sure each answer links a problem to evidence and an improvement.

Exam tip: Good evaluation always contains three things: what worked, what did not, and what you will do next.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('music')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;