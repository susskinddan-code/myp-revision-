-- Part 1 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Elements of Music > Pitch, Rhythm and Notation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Elements of Music$mq$, 5, 1 from public.subjects s where s.slug = $mq$music$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Pitch, Rhythm and Notation$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$music$mq$ and p.grade = 5 and p.name = $mq$Elements of Music$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Pitch, Rhythm and Notation$mq$ and p.name = $mq$Elements of Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In 4/4 time, how many beats does a minim (half note) last?$mq$, $mq$["2 beats","1 beat","3 beats","4 beats"]$mq$, 0, $mq$A minim is worth two crotchet beats. A semibreve is the 4-beat note.$mq$, $mq$easy$mq$),
($mq$Which clef is normally used for the higher notes, such as the right hand of a piano part?$mq$, $mq$["Bass clef","Percussion clef","Key clef","Treble clef"]$mq$, 3, $mq$The treble clef (G clef) curls around the G above middle C and is used for higher pitches. The bass clef is used for lower notes.$mq$, $mq$easy$mq$),
($mq$In a time signature, what does the top number tell you?$mq$, $mq$["How fast the music is","Which key the music is in","How many beats are in each bar","How loud the bar is"]$mq$, 2, $mq$The top number counts the beats per bar. The bottom number shows which note value counts as one beat.$mq$, $mq$easy$mq$),
($mq$Which symbol raises a note by one semitone?$mq$, $mq$["Flat (♭)","Sharp (♯)","Natural (♮)","Rest"]$mq$, 1, $mq$A sharp raises the pitch by a semitone, a flat lowers it, and a natural cancels an earlier sharp or flat.$mq$, $mq$easy$mq$),
($mq$What does a rest show in a score?$mq$, $mq$["A silence of a set length","A note held for longer","A repeat of the last bar","A sudden loud note"]$mq$, 0, $mq$Rests are written silences. Each rest has a length that matches a note value, for example a crotchet rest lasts one beat.$mq$, $mq$easy$mq$),
($mq$A student reads the notes on the five lines of the treble clef from the bottom upwards. Which letters do they read?$mq$, $mq$["F A C E G","G B D F A","A C E G B","E G B D F"]$mq$, 3, $mq$The lines of the treble clef from the bottom are E, G, B, D, F. A memory aid is 'Every Good Boy Deserves Fun'.$mq$, $mq$medium$mq$),
($mq$In a piece in 3/4, which single note fills one whole bar?$mq$, $mq$["Semibreve","Minim","Dotted minim","Dotted crotchet"]$mq$, 2, $mq$A minim is 2 beats and the dot adds half (1 beat), so a dotted minim is 3 crotchet beats. A semibreve is 4 beats and is too long.$mq$, $mq$medium$mq$),
($mq$The spaces of the treble clef, from bottom to top, spell which word?$mq$, $mq$["EGBDF","FACE","CAGE","BEAD"]$mq$, 1, $mq$The four spaces are F, A, C, E, which spell FACE. The lines are E G B D F.$mq$, $mq$medium$mq$),
($mq$A crotchet is tied to a minim of the same pitch. For how many beats is the note held?$mq$, $mq$["3 beats","2 beats","1 beat","4 beats"]$mq$, 0, $mq$A tie joins notes of the same pitch into one sound. 1 beat + 2 beats = 3 beats, and the note is not played again at the tie.$mq$, $mq$medium$mq$),
($mq$What does a dot placed after a note do?$mq$, $mq$["Doubles its length","Shortens it by half","Makes it louder","Makes it half as long again"]$mq$, 3, $mq$A dot adds half the note's value. A dotted crotchet is 1 + ½ = 1½ beats.$mq$, $mq$medium$mq$),
($mq$A tune is in 6/8. How is a bar usually felt?$mq$, $mq$["Six equal strong crotchet beats","Three main beats, each split into two quavers","Two main beats, each split into three quavers","Four main beats"]$mq$, 2, $mq$6/8 is compound duple time: six quavers grouped as two groups of three, giving two main pulses.$mq$, $mq$medium$mq$),
($mq$Counting every letter name including the first, what is the interval from C up to G?$mq$, $mq$["A third","A fifth","A fourth","A sixth"]$mq$, 1, $mq$C, D, E, F, G is five letter names, so the interval is a fifth. Counting from zero would wrongly give a fourth.$mq$, $mq$medium$mq$),
($mq$On a piano, what is the distance from E up to F?$mq$, $mq$["One semitone","One tone","Two semitones","A third"]$mq$, 0, $mq$There is no black key between E and F, so they are neighbouring notes one semitone apart.$mq$, $mq$medium$mq$),
($mq$In 4/4, which bar adds up to exactly four crotchet beats?$mq$, $mq$["Dotted minim, dotted crotchet","Semibreve, two crotchets","Minim, minim, quaver","Dotted crotchet, quaver, minim"]$mq$, 3, $mq$1½ + ½ + 2 = 4. The others total 4½, 6 and 4½ beats, so they overfill the bar.$mq$, $mq$hard$mq$),
($mq$A score has F♯ in its key signature. A bar later the composer writes an F♮ accidental, then another F follows in the same bar. How should the second F be played?$mq$, $mq$["As F♯, because the key signature always wins","As F♯, because accidentals only affect one note","As F♮, because the accidental lasts to the end of the bar","As F♭, to balance the natural"]$mq$, 2, $mq$An accidental stays in force until the next bar line, so the later F in that bar is still natural. In the next bar the key signature applies again.$mq$, $mq$hard$mq$),
($mq$A melody has accents on the 'and' between beats (1 AND 2 AND 3 AND) instead of on the main beats. What is this effect called?$mq$, $mq$["Anacrusis","Syncopation","Ostinato","Pedal note"]$mq$, 1, $mq$Syncopation places stress on weak beats or off-beats, which makes a rhythm feel unexpected or 'bouncy'.$mq$, $mq$hard$mq$),
($mq$Three quaver triplets are written over a bracket marked 3 in 2/4. How long do the three notes last together?$mq$, $mq$["One crotchet beat","One minim","One quaver","Three crotchet beats"]$mq$, 0, $mq$A triplet fits three notes into the time normally taken by two. Three quavers in the time of two quavers equals one crotchet beat.$mq$, $mq$hard$mq$),
($mq$A bar of 2/4 contains a crotchet rest, a quaver, a quaver rest and another quaver. Is the bar complete?$mq$, $mq$["Yes: it totals exactly 2 beats","Yes: rests are not counted","No: it totals 1½ beats, so it is short","No: it totals 2½ beats, so it is overfull"]$mq$, 3, $mq$Add the values: 1 + ½ + ½ + ½ = 2½ beats, but 2/4 holds only 2. Rests count in full, so the bar is overfull and needs correcting.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Pitch, Rhythm and Notation$mq$ and p.name = $mq$Elements of Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Treble clef lines and spaces$mq$, $mq$Lines (bottom to top): E G B D F. Spaces: F A C E (spells FACE).$mq$),
($mq$Bass clef lines and spaces$mq$, $mq$Lines (bottom to top): G B D F A. Spaces: A C E G.$mq$),
($mq$Note values in 4/4$mq$, $mq$Semibreve 4 beats, minim 2, crotchet 1, quaver ½, semiquaver ¼.$mq$),
($mq$What does a dot do?$mq$, $mq$A dot after a note adds half of its value: a dotted minim = 3 beats, a dotted crotchet = 1½ beats.$mq$),
($mq$What is a tie?$mq$, $mq$A curved line joining two notes of the same pitch so they sound as one longer note.$mq$),
($mq$Time signature 3/4$mq$, $mq$Three crotchet beats in each bar, giving a waltz-like feel.$mq$),
($mq$Compound time (e.g. 6/8)$mq$, $mq$Each main beat divides into three. 6/8 = two beats, each of three quavers.$mq$),
($mq$Semitone vs tone$mq$, $mq$A semitone is the smallest step (E to F). A tone is two semitones (C to D).$mq$),
($mq$Syncopation$mq$, $mq$Placing stress on weak beats or off-beats so the rhythm feels off-balance.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Pitch, Rhythm and Notation$mq$ and p.name = $mq$Elements of Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The building blocks
Pitch is how high or low a sound is. In written music, pitch is shown by where a note sits on the **stave**, a set of five lines and four spaces. The **clef** at the start tells you which pitches the lines represent. The **treble clef** is used for higher notes: its lines from the bottom are E G B D F and its spaces spell FACE. The **bass clef** is used for lower notes: its lines are G B D F A and its spaces are A C E G. Notes that go above or below the stave sit on small **ledger lines**, and middle C sits on the first ledger line below the treble stave.

Pitch moves by **semitones** (the smallest step on a piano, such as E to F) and **tones** (two semitones, such as C to D). A **sharp** (♯) raises a note by a semitone, a **flat** (♭) lowers it by a semitone and a **natural** (♮) cancels either. An accidental written in the music lasts until the end of that bar. A **key signature** at the start of each line applies to the whole piece.

An **interval** is the distance between two pitches. Count the letter names including the first and last: C up to E is a third, C up to G is a fifth, and C up to the next C is an octave.

## Rhythm and note values
Rhythm is the pattern of long and short sounds. The **beat** is the steady pulse. In 4/4 the main note values are:
- **Semibreve** (whole note): 4 beats
- **Minim** (half note): 2 beats
- **Crotchet** (quarter note): 1 beat
- **Quaver** (eighth note): ½ beat
- **Semiquaver** (sixteenth note): ¼ beat

Each note value has a matching **rest** for silence. A **dot** after a note adds half its value, so a dotted crotchet lasts 1½ beats. A **tie** joins two notes of the same pitch into one longer sound. A **triplet** squeezes three notes into the time of two. **Syncopation** puts stress on off-beats or weak beats, which creates excitement.

## Time signatures
The **time signature** sits after the clef. The top number shows beats per bar and the bottom number shows the note value of one beat (4 means crotchet, 8 means quaver). 2/4 has two crotchet beats, 3/4 has three (a waltz feel), and 4/4 has four (called common time). In **compound time**, such as 6/8, the beats divide into three, so a bar of 6/8 is felt as two big beats, each made of three quavers. Bar lines divide the music into bars.

## Common mistakes
- Counting an interval from zero instead of counting the first note as one.
- Forgetting that rests count towards the total in a bar.
- Thinking an accidental lasts for the whole piece rather than the bar.
- Mixing up the lines and spaces of the two clefs.

## How this is examined
Exam-style questions give a short stimulus, such as a rhythm described in words, a bar written as note names, or a time signature, and ask you to identify, calculate or justify. You may need to add note values to check that a bar is complete, name an interval, state what a symbol means, or explain why a composer used syncopation or compound time. Precise vocabulary is rewarded.

Exam tip: When checking a bar, write each note value as a number of beats and add them up; the total must match the top number of the time signature.$mq$ from st;

-- Elements of Music > Tempo, Dynamics and Texture
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Elements of Music$mq$, 5, 1 from public.subjects s where s.slug = $mq$music$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Tempo, Dynamics and Texture$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$music$mq$ and p.grade = 5 and p.name = $mq$Elements of Music$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Tempo, Dynamics and Texture$mq$ and p.name = $mq$Elements of Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does the Italian word 'allegro' tell a performer?$mq$, $mq$["Play fast and lively","Play slowly","Play very softly","Gradually get louder"]$mq$, 0, $mq$Allegro is a tempo marking meaning fast and cheerful. Adagio and largo are slow.$mq$, $mq$easy$mq$),
($mq$Which symbol means 'loud'?$mq$, $mq$["p","mp","dim.","f"]$mq$, 3, $mq$The letter f stands for forte (loud), p for piano (soft), and mp for mezzo piano (moderately soft).$mq$, $mq$easy$mq$),
($mq$What does tempo describe?$mq$, $mq$["How loud the music is","How high the notes are","The speed of the beat","The number of instruments"]$mq$, 2, $mq$Tempo is the speed of the pulse and is often measured in beats per minute (BPM).$mq$, $mq$easy$mq$),
($mq$What does 'crescendo' mean?$mq$, $mq$["Gradually getting slower","Gradually getting louder","Suddenly stopping","Gradually getting softer"]$mq$, 1, $mq$A crescendo (cresc.) is a gradual increase in volume. A diminuendo is the opposite.$mq$, $mq$easy$mq$),
($mq$Music with one melody line and no accompaniment has which texture?$mq$, $mq$["Monophonic","Homophonic","Polyphonic","Heterophonic"]$mq$, 0, $mq$Monophonic means a single melodic line, for example one person singing alone.$mq$, $mq$easy$mq$),
($mq$A piece is marked 'andante' and then 'ritardando' at the end. What should the performer do at the end?$mq$, $mq$["Speed up from a walking pace","Stop completely","Get louder at a walking pace","Gradually slow down from a walking pace"]$mq$, 3, $mq$Andante is a moderate walking tempo. Ritardando (rit.) means gradually slowing down.$mq$, $mq$medium$mq$),
($mq$In a song, a singer is accompanied by chords on a guitar. The melody stands out clearly and the guitar supports it. Which texture is this?$mq$, $mq$["Monophonic","Polyphonic","Homophonic","Unison"]$mq$, 2, $mq$Homophonic texture has a main melody with chordal accompaniment. Polyphonic has two or more equally important melodies.$mq$, $mq$medium$mq$),
($mq$Two voices sing the same melody, but the second begins two bars after the first. What is this technique called?$mq$, $mq$["Drone","Canon (round)","Call and response","Unison"]$mq$, 1, $mq$In a canon each voice imitates the same melody, entering one after another. A round such as 'Frère Jacques' is a simple example.$mq$, $mq$medium$mq$),
($mq$Which list puts these dynamics in order from softest to loudest?$mq$, $mq$["pp, p, mf, ff","p, pp, mf, ff","ff, mf, p, pp","mf, pp, p, ff"]$mq$, 0, $mq$pp (very soft) < p (soft) < mf (moderately loud) < ff (very loud).$mq$, $mq$medium$mq$),
($mq$What is the difference between 'staccato' and 'legato'?$mq$, $mq$["Staccato is smooth, legato is short","Staccato is loud, legato is soft","Staccato is fast, legato is slow","Staccato is short and detached, legato is smooth and connected"]$mq$, 3, $mq$These are articulation terms. They affect how notes are joined, not their volume or tempo.$mq$, $mq$medium$mq$),
($mq$A tempo marking says ♩ = 120. How many crotchet beats occur in 30 seconds?$mq$, $mq$["30","120","60","240"]$mq$, 2, $mq$120 beats per minute is 2 beats each second, so 30 seconds contains 60 beats.$mq$, $mq$medium$mq$),
($mq$A film composer wants the music to build tension. Which combination would work best?$mq$, $mq$["Diminuendo with thin texture and falling tempo","Crescendo with thickening texture and rising tempo","Constant piano with single line","Steady forte with a monophonic line"]$mq$, 1, $mq$Getting louder, adding layers and speeding up all increase intensity. The other options reduce energy or stay static.$mq$, $mq$medium$mq$),
($mq$Which term describes music where several independent melodies are heard at the same time?$mq$, $mq$["Polyphonic","Monophonic","Homophonic","Unison"]$mq$, 0, $mq$Polyphonic (contrapuntal) texture layers separate melodic lines of equal importance, as in a fugue.$mq$, $mq$medium$mq$),
($mq$A piece lasts 48 bars in 4/4 at 96 crotchet beats per minute. How long does it last in seconds?$mq$, $mq$["96 seconds","48 seconds","192 seconds","120 seconds"]$mq$, 3, $mq$Total beats = 48 × 4 = 192. At 96 beats per minute, 192 ÷ 96 = 2 minutes = 120 seconds.$mq$, $mq$hard$mq$),
($mq$A student writes: 'The texture changes from monophonic to homophonic at bar 9.' What evidence would best support this?$mq$, $mq$["The melody gets louder","The key changes","A solo melody becomes a melody with chords underneath","The tempo doubles"]$mq$, 2, $mq$Texture is about the number of lines and how they relate. A solo line gaining chordal support is the move from monophonic to homophonic.$mq$, $mq$hard$mq$),
($mq$A conductor writes 'rubato' over a phrase in a romantic piano piece. What is the best interpretation?$mq$, $mq$["Play at a strictly steady tempo","Flexibly speed up and slow down for expression","Play as quietly as possible","Play each note short"]$mq$, 1, $mq$Rubato means 'robbed time': the performer bends the tempo slightly, taking time and giving it back for expressive effect.$mq$, $mq$hard$mq$),
($mq$A score shows a sudden 'sfz' on a chord in a quiet passage. Which effect does the composer want?$mq$, $mq$["A sudden strong accent that surprises the listener","A gradual crescendo over the whole bar","A silent pause","A change to a slower tempo"]$mq$, 0, $mq$Sforzando (sfz) means a sudden strong accent. It is used for shock and contrast, not for gradual change.$mq$, $mq$hard$mq$),
($mq$Which of these changes is a change of tempo, not of dynamics?$mq$, $mq$["From p to f","From legato to staccato","From unison to chords","From adagio to presto"]$mq$, 3, $mq$Adagio (slow) to presto (very fast) alters the speed. p to f is dynamics, and legato to staccato is articulation.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Tempo, Dynamics and Texture$mq$ and p.name = $mq$Elements of Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Allegro / Andante / Adagio$mq$, $mq$Allegro = fast and lively. Andante = walking pace. Adagio = slow.$mq$),
($mq$BPM$mq$, $mq$Beats per minute: the number of beats in 60 seconds. ♩ = 120 means 120 crotchets a minute.$mq$),
($mq$Dynamics from soft to loud$mq$, $mq$pp, p, mp, mf, f, ff.$mq$),
($mq$Crescendo vs diminuendo$mq$, $mq$Crescendo = gradually louder. Diminuendo (decrescendo) = gradually softer.$mq$),
($mq$Accelerando / ritardando$mq$, $mq$Accelerando = gradually faster. Ritardando (rit.) = gradually slower.$mq$),
($mq$Monophonic texture$mq$, $mq$A single melodic line with no accompaniment.$mq$),
($mq$Homophonic texture$mq$, $mq$A main melody supported by chords or accompaniment.$mq$),
($mq$Polyphonic texture$mq$, $mq$Two or more independent melodies at the same time, such as a canon or fugue.$mq$),
($mq$Legato vs staccato$mq$, $mq$Legato = smooth and connected. Staccato = short and detached. These are articulation, not dynamics.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Tempo, Dynamics and Texture$mq$ and p.name = $mq$Elements of Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Tempo: how fast?
Tempo is the speed of the beat. It can be described with Italian words or with a metronome marking in **beats per minute (BPM)**. A marking such as ♩ = 120 means 120 crotchet beats every minute. Common tempo words, from slow to fast, are:
- **Largo** and **adagio**: very slow, broad
- **Andante**: walking pace
- **Moderato**: moderate speed
- **Allegro**: fast and lively
- **Vivace** and **presto**: very fast

Changes of speed are also marked. **Accelerando** (accel.) means gradually getting faster, **ritardando** (rit.) or **rallentando** means gradually slowing, and **a tempo** means return to the original speed. **Rubato** allows the performer to stretch and squeeze the tempo for expression. A **pause** (fermata) holds a note longer than written.

You can use BPM to work out how long a piece lasts. Multiply the number of bars by the beats in each bar, then divide by the BPM to get minutes. For example, 32 bars of 4/4 is 128 beats, and at 64 BPM that is two minutes.

## Dynamics: how loud?
Dynamics are the volume levels in music. From softest to loudest: **pp** (pianissimo), **p** (piano), **mp** (mezzo piano), **mf** (mezzo forte), **f** (forte), **ff** (fortissimo). **Crescendo** (getting louder) and **diminuendo** or decrescendo (getting softer) are gradual changes, shown with hairpin signs. **Sforzando** (sfz) is a sudden strong accent. Dynamics help to shape phrases and create emotion, drama and contrast.

**Articulation** is how notes are attacked and joined: **legato** (smooth), **staccato** (short and detached), **accent** (stressed) and **tenuto** (held for full value). Do not confuse articulation with dynamics.

## Texture: how many layers?
Texture describes how many layers of sound there are and how they relate:
- **Monophonic**: a single melodic line, with or without doubling at the octave.
- **Homophonic**: a main melody with chordal accompaniment, the most common texture in songs.
- **Polyphonic**: two or more independent melodies at once, for example a canon, round or fugue.
- **Unison**: everyone plays or sings the same notes together.
- **Heterophonic**: slightly different versions of one melody played at the same time, often in folk traditions.

We also use the words **thin** (few layers) and **thick** (many layers). A **drone** is a long held or repeated note beneath a melody. **Call and response** is a question-and-answer pattern between a leader and a group.

## Common mistakes
- Saying a loud piece is fast. Dynamics and tempo are separate.
- Calling every accompanied song polyphonic; if one melody dominates it is homophonic.
- Using 'legato' as a dynamic.

## How this is examined
Questions usually give a short description of an extract or a score marking and ask you to identify the tempo, dynamic or texture, explain its effect, or suggest what a composer could change to create a mood. Use precise terms and link them to an effect, such as 'the thin texture makes the opening feel lonely'.

Exam tip: Name the element, give the term, then explain the effect on the listener in the same sentence.$mq$ from st;

-- Elements of Music > Scales, Keys and Harmony
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Elements of Music$mq$, 5, 1 from public.subjects s where s.slug = $mq$music$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Scales, Keys and Harmony$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$music$mq$ and p.grade = 5 and p.name = $mq$Elements of Music$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Scales, Keys and Harmony$mq$ and p.name = $mq$Elements of Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$How many notes does a major scale contain before the octave repeats?$mq$, $mq$["Seven different notes","Five different notes","Six different notes","Eight different notes"]$mq$, 0, $mq$A major scale has seven different notes, and the eighth note is the octave of the first.$mq$, $mq$easy$mq$),
($mq$What is a chord?$mq$, $mq$["A single long note","A fast run of notes","A repeated rhythm","Three or more notes sounded together"]$mq$, 3, $mq$A chord combines several pitches at the same time. A triad has three notes.$mq$, $mq$easy$mq$),
($mq$Which pattern of tones (T) and semitones (S) makes a major scale?$mq$, $mq$["T S T T S T T","S T T S T T T","T T S T T T S","T T T S T T S"]$mq$, 2, $mq$A major scale is T T S T T T S. The pattern T S T T S T T is the natural minor scale.$mq$, $mq$easy$mq$),
($mq$What is the tonic of the key of G major?$mq$, $mq$["D","G","B","C"]$mq$, 1, $mq$The tonic is the first note (degree 1) of the scale and gives the key its name.$mq$, $mq$easy$mq$),
($mq$What does a key signature show?$mq$, $mq$["Which notes are sharp or flat throughout the piece","The speed of the piece","The loudness of the piece","The number of bars"]$mq$, 0, $mq$The sharps or flats at the start of each stave tell you which notes are altered, and so the key.$mq$, $mq$easy$mq$),
($mq$How many sharps does the key of G major have?$mq$, $mq$["Two (F♯ and C♯)","One (B♭)","None","One (F♯)"]$mq$, 3, $mq$G major has one sharp, F♯. D major has two (F♯, C♯). F major has one flat, B♭.$mq$, $mq$medium$mq$),
($mq$Which three notes make the C major triad?$mq$, $mq$["C, D, E","C, F, A","C, E, G","C, E, A"]$mq$, 2, $mq$A triad is built from the root, third and fifth of the scale: C, E, G.$mq$, $mq$medium$mq$),
($mq$A piece in A minor has a sad, serious character. Which feature most often causes this?$mq$, $mq$["A major third above the tonic","A minor third above the tonic","A faster tempo","A louder dynamic"]$mq$, 1, $mq$The minor third (A to C) gives minor keys their darker character, compared with the major third in major keys.$mq$, $mq$medium$mq$),
($mq$The notes of a chord are played one after another instead of together. What is this called?$mq$, $mq$["Arpeggio (broken chord)","Cluster","Drone","Glissando"]$mq$, 0, $mq$An arpeggio plays chord notes in sequence, rising or falling. A glissando slides across pitches.$mq$, $mq$medium$mq$),
($mq$In the key of C major, which chords are chord I, IV and V?$mq$, $mq$["C, D and E","C, E and G","D, F and A","C, F and G"]$mq$, 3, $mq$The primary chords are built on degrees 1, 4 and 5 of the scale: C (I), F (IV) and G (V).$mq$, $mq$medium$mq$),
($mq$A melody ends on a chord V and then chord I, making a feeling of finishing. What is this cadence called?$mq$, $mq$["Imperfect cadence","Plagal cadence","Perfect cadence","Interrupted cadence"]$mq$, 2, $mq$V to I is a perfect cadence and sounds like a full stop. Ending on V sounds unfinished (imperfect).$mq$, $mq$medium$mq$),
($mq$A song changes from C major to E♭ major in the middle. What is this called?$mq$, $mq$["Transposition","Modulation","Syncopation","Inversion"]$mq$, 1, $mq$Modulation is a change of key within a piece. Transposition is moving a whole piece to a new key.$mq$, $mq$medium$mq$),
($mq$A composer wants a song to move from the tonic key of C major to its relative minor for the sad verse. To which key should the music move?$mq$, $mq$["A minor","D minor","G minor","E♭ major"]$mq$, 0, $mq$The relative minor of C major is A minor because they share a key signature. D minor and G minor are neighbouring keys but not relative.$mq$, $mq$medium$mq$),
($mq$A harmony is described as 'dissonant, tense and needs to resolve'. What should happen next to satisfy the ear?$mq$, $mq$["Add more dissonant notes","Stop abruptly","Repeat the same chord louder","Move to a consonant chord, such as the tonic"]$mq$, 3, $mq$Dissonance creates tension, and resolution to a consonant chord, often the tonic, releases it.$mq$, $mq$hard$mq$),
($mq$A student states a piece is in D major because there are two sharps. Which extra check shows she is right?$mq$, $mq$["The sharps are B♭ and E♭","The tempo is allegro","The sharps are F♯ and C♯ and the music ends on D","The time signature is 3/4"]$mq$, 2, $mq$D major has F♯ and C♯. Checking the final chord and melody centre on D confirms it, because B minor shares the same signature.$mq$, $mq$hard$mq$),
($mq$The melody uses C major notes but keeps returning to A and ends on A. Which is the most likely key?$mq$, $mq$["C major","A minor","F major","E minor"]$mq$, 1, $mq$Sharing the C major signature, a tune that centres and ends on A is in A minor, its relative minor.$mq$, $mq$hard$mq$),
($mq$What does transposing a tune from C major to D major do to every note?$mq$, $mq$["Raises each note by a tone, keeping the same intervals","Changes the rhythms","Makes the tune twice as fast","Reverses the order of notes"]$mq$, 0, $mq$Transposition shifts all notes by the same interval: C to D is a tone. The shape and rhythm stay the same.$mq$, $mq$hard$mq$),
($mq$Which statement best explains why major keys sound happy and minor keys sad?$mq$, $mq$["They always use different time signatures","Minor keys are always slower","Major keys are always louder","Their third and sixth degrees differ in size"]$mq$, 3, $mq$Differences in the third (and usually sixth and seventh) steps alter the mood. Tempo and volume are separate choices.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Scales, Keys and Harmony$mq$ and p.name = $mq$Elements of Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Major scale pattern$mq$, $mq$T T S T T T S (tone = 2 semitones, S = semitone).$mq$),
($mq$Tonic$mq$, $mq$The first note of a scale (degree 1). It gives the key its name and feels like 'home'.$mq$),
($mq$Triad$mq$, $mq$A three-note chord made from the root, third and fifth of a scale. C major triad = C E G.$mq$),
($mq$Primary chords$mq$, $mq$I, IV and V. In C major: C, F and G.$mq$),
($mq$Relative minor$mq$, $mq$The minor key sharing a major key's signature, starting 3 semitones lower. A minor is relative to C major.$mq$),
($mq$Perfect cadence$mq$, $mq$Chord V then chord I. Sounds finished, like a full stop.$mq$),
($mq$Modulation vs transposition$mq$, $mq$Modulation = changing key within a piece. Transposition = moving a whole piece to another key.$mq$),
($mq$Arpeggio$mq$, $mq$A chord played one note at a time, rising or falling (a broken chord).$mq$),
($mq$Consonance vs dissonance$mq$, $mq$Consonant = stable and pleasing. Dissonant = tense, wants to resolve to consonance.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Scales, Keys and Harmony$mq$ and p.name = $mq$Elements of Music$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Scales
A **scale** is a set of notes arranged in order of pitch. The **major scale** has seven different notes and follows the pattern tone, tone, semitone, tone, tone, tone, semitone (T T S T T T S). C major uses only the white notes of a piano: C D E F G A B C. A **minor scale** has a different pattern; the natural minor is T S T T S T T, giving a darker, sadder character. The first note of the scale is the **tonic** and gives the key its name. Notes in a scale are numbered as **degrees**, with the tonic as degree 1.

A **chromatic scale** uses all twelve semitones. A **pentatonic scale** has five notes and is found in folk and pop music around the world.

## Keys and key signatures
The **key** tells you which scale a piece is based on and which note feels like home. A **key signature** is the group of sharps or flats written at the start of each stave. For example:
- C major: no sharps or flats
- G major: one sharp (F♯)
- D major: two sharps (F♯, C♯)
- F major: one flat (B♭)
- B♭ major: two flats (B♭, E♭)

Every major key has a **relative minor** that shares its key signature. It starts three semitones lower: A minor is relative to C major, and E minor is relative to G major. **Modulation** is a change of key within a piece. **Transposition** means moving the whole piece to a different key, keeping the same pattern of intervals.

## Chords and harmony
**Harmony** is what happens when notes sound together. A **chord** has three or more notes. The basic chord is a **triad**: the root, third and fifth of a scale. In C major the triad is C, E, G. Chords are numbered with Roman numerals from the scale degree they are built on. The main ones are **I** (tonic), **IV** (subdominant) and **V** (dominant). In C major these are C, F and G. When chord notes are played one after another, it is an **arpeggio** (or broken chord).

**Cadences** are chord endings to phrases. A **perfect cadence** is V then I and sounds finished. An **imperfect cadence** ends on V and sounds unfinished. A **plagal cadence** is IV then I, sometimes called the 'Amen' cadence. An **interrupted cadence** is V then vi and sounds surprising.

Harmony may be **consonant** (stable, pleasant) or **dissonant** (tense, wanting to resolve). Composers use dissonance to create tension and then release it with a consonant chord.

## Common mistakes
- Confusing relative minor (shares signature) with the tonic minor (shares the same starting note).
- Saying a piece is in a key just from the key signature without checking the ending.
- Mixing up transposition and modulation.

## How this is examined
Typical items present a short description of notes, a key signature or a chord pattern and ask you to name the key, identify a chord or cadence, or explain the effect of a change from major to minor. You may also justify a harmonic choice for a given mood in a composition task.

Exam tip: To decide between a major key and its relative minor, check where the melody starts and finishes and which chord ends the piece.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('music')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;