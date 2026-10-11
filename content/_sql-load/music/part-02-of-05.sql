-- Part 2 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Listening and Analysing > Instruments and Ensembles
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Listening and Analysing$mq$, 5, 2 from public.subjects s where s.slug = $mq$music$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Instruments and Ensembles$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$music$mq$ and p.grade = 5 and p.name = $mq$Listening and Analysing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Instruments and Ensembles$mq$ and p.name = $mq$Listening and Analysing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$To which orchestral family does the clarinet belong?$mq$, $mq$["Woodwind","Brass","Strings","Percussion"]$mq$, 0, $mq$The clarinet is a woodwind instrument that uses a single reed. Brass instruments are played by buzzing the lips.$mq$, $mq$easy$mq$),
($mq$Which of these is a bowed string instrument?$mq$, $mq$["Trumpet","Oboe","Xylophone","Violin"]$mq$, 3, $mq$The violin has four strings played with a bow. It is the highest-pitched string instrument of the orchestra.$mq$, $mq$easy$mq$),
($mq$Which instrument family does the trumpet belong to?$mq$, $mq$["Woodwind","Strings","Brass","Keyboard"]$mq$, 2, $mq$The trumpet is made of metal and the player buzzes the lips into a cup-shaped mouthpiece, so it is brass.$mq$, $mq$easy$mq$),
($mq$Two violins, a viola and a cello form which ensemble?$mq$, $mq$["Piano trio","String quartet","Brass band","Jazz combo"]$mq$, 1, $mq$A string quartet has four players: two violins, viola and cello. It is a well-known chamber music group.$mq$, $mq$easy$mq$),
($mq$Which of these is a tuned percussion instrument?$mq$, $mq$["Xylophone","Snare drum","Cymbals","Tambourine"]$mq$, 0, $mq$A xylophone has bars of different lengths, so it plays definite pitches. Snare drum, cymbals and tambourine have no definite pitch.$mq$, $mq$easy$mq$),
($mq$How is the sound made on a brass instrument?$mq$, $mq$["Air is blown across a double reed","A string is bowed","A skin is struck","The player's lips vibrate inside a mouthpiece"]$mq$, 3, $mq$Brass players 'buzz' their lips into the mouthpiece, and the instrument's tube amplifies and shapes the sound.$mq$, $mq$medium$mq$),
($mq$A flute produces its sound in which way?$mq$, $mq$["A single reed vibrates against the mouthpiece","Two reeds vibrate together","Air is blown across an opening, with no reed","The lips buzz in a cup"]$mq$, 2, $mq$The flute is a reedless woodwind: a stream of air across the edge of the embouchure hole sets the air column vibrating.$mq$, $mq$medium$mq$),
($mq$Which four sections make up a standard symphony orchestra?$mq$, $mq$["Strings, keyboards, vocals, drums","Strings, woodwind, brass, percussion","Brass, bass, guitars, keyboards","Woodwind, vocals, brass, synthesisers"]$mq$, 1, $mq$The four sections are strings, woodwind, brass and percussion. Keyboards and harps are sometimes added.$mq$, $mq$medium$mq$),
($mq$Which string instrument has the lowest pitch in the orchestra?$mq$, $mq$["Double bass","Violin","Viola","Cello"]$mq$, 0, $mq$The double bass is the largest bowed string instrument and plays the lowest notes. The cello is lower than the viola but higher than the bass.$mq$, $mq$medium$mq$),
($mq$Which group is the usual 'rhythm section' of a rock band?$mq$, $mq$["Lead singer and backing vocals","Violins and cellos","Trumpets and trombones","Drum kit, bass guitar and rhythm guitar or keyboard"]$mq$, 3, $mq$The rhythm section supplies the beat and harmony. Vocals and solo instruments usually carry the melody.$mq$, $mq$medium$mq$),
($mq$What does 'a cappella' singing mean?$mq$, $mq$["Singing very quietly","Singing in a church only","Singing without instrumental accompaniment","Singing with only drums"]$mq$, 2, $mq$A cappella is vocal music performed with no instruments, for example by a barbershop quartet.$mq$, $mq$medium$mq$),
($mq$In a choir, what do the letters SATB stand for?$mq$, $mq$["Solo, accompanied, tutti, band","Soprano, alto, tenor, bass","Staccato, accent, tenuto, beat","Slow, andante, tempo, bar"]$mq$, 1, $mq$These are the four standard voice types in a mixed choir, from highest to lowest.$mq$, $mq$medium$mq$),
($mq$A composer writes 'pizzicato' for the cellos. What should the players do?$mq$, $mq$["Pluck the strings with their fingers","Bow the strings very softly","Tap the wood of the instrument","Slide between notes"]$mq$, 0, $mq$Pizzicato means plucked. The return to bowing is marked 'arco'.$mq$, $mq$medium$mq$),
($mq$A slow movement opens with a plaintive, nasal solo played on a double-reed woodwind. Which instrument is most likely?$mq$, $mq$["Clarinet","Flute","Trombone","Oboe"]$mq$, 3, $mq$The oboe uses a double reed and has a distinctive nasal, pastoral tone. Clarinets use a single reed and flutes have no reed.$mq$, $mq$hard$mq$),
($mq$Why might a composer ask trumpeters to use a mute?$mq$, $mq$["To make the instrument higher in pitch","To make the notes longer","To produce a softer, altered tone colour","To let the player breathe"]$mq$, 2, $mq$A mute fits into the bell and changes the timbre, giving a muffled or buzzy sound at a lower volume.$mq$, $mq$hard$mq$),
($mq$A B♭ clarinet plays a written C. A listener hears B♭. What does this show?$mq$, $mq$["The clarinet is out of tune","It is a transposing instrument sounding a tone below the written note","The player made a mistake","Clarinets always sound a fifth higher"]$mq$, 1, $mq$B♭ instruments sound a tone lower than written. Composers write transposed parts so players can use the same fingerings on different-sized instruments.$mq$, $mq$hard$mq$),
($mq$A violin and a flute play the same note at the same loudness but sound different. What element explains this?$mq$, $mq$["Timbre","Tempo","Rhythm","Texture"]$mq$, 0, $mq$Timbre is the tone quality of an instrument, shaped by its materials, shape and the mix of harmonics it produces.$mq$, $mq$hard$mq$),
($mq$A composer scores a piece for piano quintet. How many performers are needed?$mq$, $mq$["Four","Six","Seven","Five"]$mq$, 3, $mq$A piano quintet is a piano plus a string quartet, which is five players. A quintet always means five.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Instruments and Ensembles$mq$ and p.name = $mq$Listening and Analysing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Four orchestral sections$mq$, $mq$Strings, woodwind, brass and percussion.$mq$),
($mq$How do brass instruments make sound?$mq$, $mq$The player's lips buzz inside a mouthpiece; the tube shapes the sound.$mq$),
($mq$Single reed vs double reed$mq$, $mq$Single reed: clarinet, saxophone. Double reed: oboe, bassoon. Flute has no reed.$mq$),
($mq$Timbre$mq$, $mq$The tone colour or quality of a sound that tells one instrument from another.$mq$),
($mq$String quartet$mq$, $mq$Two violins, a viola and a cello. Four players, a chamber music ensemble.$mq$),
($mq$SATB$mq$, $mq$Soprano, alto, tenor, bass: the four voice parts of a mixed choir.$mq$),
($mq$Arco vs pizzicato$mq$, $mq$Arco = played with the bow. Pizzicato = plucked with the fingers.$mq$),
($mq$Tuned vs untuned percussion$mq$, $mq$Tuned (xylophone, timpani) plays definite pitches. Untuned (snare drum, cymbals) does not.$mq$),
($mq$Transposing instrument$mq$, $mq$One whose written notes sound at a different pitch. A B♭ clarinet sounds a tone lower than written.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Instruments and Ensembles$mq$ and p.name = $mq$Listening and Analysing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## The families of instruments
Instruments are grouped into families by how they make sound. In a **symphony orchestra** there are four main sections.

**Strings** are the violin, viola, cello and double bass, usually played with a bow (**arco**) or plucked (**pizzicato**). They have the largest section of the orchestra. The harp is also a string instrument. Pitch gets lower as the instruments get larger.

**Woodwind** instruments produce sound from a vibrating column of air. The **flute** and piccolo have no reed: air is blown across an opening. The **clarinet** has a single reed. The **oboe** and **bassoon** have double reeds, giving the oboe its nasal tone and the bassoon its low, woody tone. The saxophone is a single-reed instrument often heard in jazz.

**Brass** instruments are made of metal and played by buzzing the lips into a mouthpiece. They include the trumpet, French horn, trombone and tuba. A **mute** can be placed in the bell to alter the tone colour.

**Percussion** instruments are struck, shaken or scraped. **Tuned percussion** such as the xylophone, glockenspiel, marimba and timpani play definite pitches. **Untuned percussion** such as the snare drum, cymbals, triangle and tambourine do not. Keyboards such as the piano and organ are often counted separately.

## Timbre
**Timbre** (tone colour) is the quality of a sound that lets you tell a flute from a violin even when they play the same pitch at the same loudness. Timbre depends on how the sound is produced, the shape and materials of the instrument and its mix of harmonics. Good descriptions of timbre use words like bright, warm, mellow, nasal, hollow, harsh, rich or buzzy.

## Voices
Human voices are also instruments. In a choir the four main parts are **SATB**: soprano, alto, tenor and bass. Singing without instruments is **a cappella**. Voices can sing in unison, in harmony or in canon.

## Ensembles
Ensembles are named by number and type of performers:
- **Solo, duet, trio, quartet, quintet**: one, two, three, four, five players.
- **Chamber music**: a small group with one player to a part, such as a string quartet (two violins, viola and cello) or a piano trio.
- **Orchestra**: a large group with many players on each string part.
- **Concert band / brass band**: wind and percussion, or brass and percussion only.
- **Rock band**: lead vocals, guitar, bass guitar, keyboard and drum kit. The **rhythm section** is the drums and bass, plus chordal instruments.
- **Jazz combo**: a small group usually including piano, double bass, drums and a solo instrument such as saxophone or trumpet.

## Transposing instruments
Some instruments are written in a different pitch from how they sound. A B♭ clarinet or B♭ trumpet sounds a tone lower than written. This is called transposition, and it lets players switch between members of an instrument family easily.

## Common mistakes
- Saying the saxophone is a brass instrument because it is metal. It is a woodwind because it has a reed.
- Calling the piano a string-only instrument without noting its keys and hammers.
- Mixing up quartet (four players) and quintet (five).

## How this is examined
You may hear or read a description of an extract and identify the instruments, the family and the likely ensemble, or explain how the timbre creates a mood. Pair the instrument with a descriptive word and an effect.

Exam tip: Say which family and how the sound is produced, for example 'oboe, a double-reed woodwind with a plaintive nasal tone'.$mq$ from st;

-- Listening and Analysing > Musical Forms and Structures
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Listening and Analysing$mq$, 5, 2 from public.subjects s where s.slug = $mq$music$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Musical Forms and Structures$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$music$mq$ and p.grade = 5 and p.name = $mq$Listening and Analysing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Musical Forms and Structures$mq$ and p.name = $mq$Listening and Analysing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What letter pattern describes binary form?$mq$, $mq$["AB","ABA","ABACA","AAA"]$mq$, 0, $mq$Binary form has two contrasting sections, A and B. Ternary is ABA.$mq$, $mq$easy$mq$),
($mq$What letter pattern describes ternary form?$mq$, $mq$["AB","ABC","AABB","ABA"]$mq$, 3, $mq$Ternary form has a first section, a contrasting middle section and a return of the first section.$mq$, $mq$easy$mq$),
($mq$In a rondo, what comes back several times?$mq$, $mq$["The final chord only","The tempo marking","The main theme (A)","The key signature"]$mq$, 2, $mq$A rondo alternates a main theme with contrasting episodes, such as ABACA.$mq$, $mq$easy$mq$),
($mq$In a song, which section has the same music but different words each time it appears?$mq$, $mq$["Chorus","Verse","Intro","Coda"]$mq$, 1, $mq$Verses share a melody but tell the story with new lyrics. The chorus normally repeats the same words.$mq$, $mq$easy$mq$),
($mq$In a song, which section is usually repeated with the same words and melody and has the main hook?$mq$, $mq$["Chorus","Verse","Bridge","Intro"]$mq$, 0, $mq$The chorus is the memorable, repeated section that listeners sing along to.$mq$, $mq$easy$mq$),
($mq$What is a bridge (middle eight) in a pop song?$mq$, $mq$["The opening of the song","The final chord","A repeated drum pattern","A contrasting section that gives variety, often before the final chorus"]$mq$, 3, $mq$The bridge usually has new chords or melody, which makes the return of the chorus feel fresh.$mq$, $mq$medium$mq$),
($mq$In strophic form, how is each verse set?$mq$, $mq$["To new music each time","In a different key every time","To the same music","Without any melody"]$mq$, 2, $mq$Strophic songs, like many hymns and folk songs, repeat the same music for each verse.$mq$, $mq$medium$mq$),
($mq$What happens in theme and variations form?$mq$, $mq$["Every section is brand new","A theme is presented and then repeated with changes","The piece has only two sections","The theme is played once only"]$mq$, 1, $mq$Each variation alters features like rhythm, melody, harmony, tempo or timbre while the theme stays recognisable.$mq$, $mq$medium$mq$),
($mq$What are the three main parts of sonata form?$mq$, $mq$["Exposition, development, recapitulation","Verse, chorus, bridge","Intro, coda, bridge","Theme, ostinato, drone"]$mq$, 0, $mq$Themes are introduced in the exposition, changed and explored in the development, and return in the recapitulation.$mq$, $mq$medium$mq$),
($mq$What is an ostinato?$mq$, $mq$["A very loud chord","A slowing down at the end","A change of key","A short pattern repeated over and over"]$mq$, 3, $mq$Ostinati, such as a repeated bass riff, give music momentum and are common in pop, film and world music.$mq$, $mq$medium$mq$),
($mq$A song uses new music for every section and never repeats earlier material. What form is this?$mq$, $mq$["Strophic","Rondo","Through-composed","Ternary"]$mq$, 2, $mq$Through-composed means the music continues without repeating sections, as in some art songs.$mq$, $mq$medium$mq$),
($mq$In a 12-bar blues in C, which chord is usually played in bar 5?$mq$, $mq$["G (chord V)","F (chord IV)","C (chord I)","A minor"]$mq$, 1, $mq$The 12-bar blues starts with four bars of chord I, then two bars of IV (here F). Chord V (G) comes later.$mq$, $mq$medium$mq$),
($mq$A ternary piece has an A section of 16 bars, a B section of 8 bars and then A repeated exactly. How many bars in total?$mq$, $mq$["40","24","32","16"]$mq$, 0, $mq$16 + 8 + 16 = 40 bars. The returning A is the same length as the first A.$mq$, $mq$medium$mq$),
($mq$A rondo has the plan A B A C A D A. How many times is the main theme A heard?$mq$, $mq$["Three","Seven","Two","Four"]$mq$, 3, $mq$Counting the letters A gives four statements. The B, C and D episodes each appear once.$mq$, $mq$hard$mq$),
($mq$A pop song goes: intro, verse, chorus, verse, chorus, bridge, chorus, outro. Why does the bridge before the last chorus help?$mq$, $mq$["It makes the song shorter","It changes the song into binary form","Contrast makes the final chorus feel more satisfying","It replaces the verse"]$mq$, 2, $mq$A contrasting bridge creates tension or surprise, so the return of the chorus feels like a release.$mq$, $mq$hard$mq$),
($mq$A listener says a piece is in ternary form because the opening tune returns after a contrasting middle. What further evidence would best support this?$mq$, $mq$["The song is in 4/4","The middle section has a different key or mood and the first tune comes back","The middle section is longer than the last","The piece uses many instruments"]$mq$, 1, $mq$Ternary form needs a clear contrast and then a return of A. Time signature and instrumentation do not decide form.$mq$, $mq$hard$mq$),
($mq$Why do composers use both repetition and contrast within a structure?$mq$, $mq$["Repetition gives unity, contrast gives interest","Repetition and contrast are the same thing","They make music slower","They are only used in jazz"]$mq$, 0, $mq$Repeated ideas make music memorable and cohesive, while contrasting ideas prevent boredom.$mq$, $mq$hard$mq$),
($mq$A theme is 8 bars. Variation 1 changes the rhythm, variation 2 changes the key, and variation 3 changes the instrument. What is being done?$mq$, $mq$["Writing a new theme each time","Composing a rondo","Ending the piece","Developing the theme while keeping it recognisable"]$mq$, 3, $mq$In a theme and variations, features are altered one at a time so that the original idea is still heard.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Musical Forms and Structures$mq$ and p.name = $mq$Listening and Analysing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Binary form$mq$, $mq$AB: two contrasting sections.$mq$),
($mq$Ternary form$mq$, $mq$ABA: a section, a contrasting section, then the first section returns.$mq$),
($mq$Rondo form$mq$, $mq$The main theme (A) keeps returning between contrasting episodes: ABACA...$mq$),
($mq$Strophic form$mq$, $mq$The same music is repeated for every verse.$mq$),
($mq$Through-composed$mq$, $mq$New music throughout with no repeated sections.$mq$),
($mq$Sonata form parts$mq$, $mq$Exposition (themes introduced), development (themes changed), recapitulation (themes return).$mq$),
($mq$Verse vs chorus$mq$, $mq$Verse: same tune, new words each time. Chorus: same tune and same words, the main hook.$mq$),
($mq$Bridge / middle eight$mq$, $mq$A contrasting section in a song, usually before the last chorus, giving variety.$mq$),
($mq$12-bar blues chords$mq$, $mq$Based on chords I, IV and V. In C: C, F, G. Bar 5 is usually chord IV.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Musical Forms and Structures$mq$ and p.name = $mq$Listening and Analysing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why form matters
Musical **form** (or structure) is how a piece is organised into sections. Understanding form helps you listen, analyse and compose. We label sections with letters: the first idea is A, a contrasting idea is B, a third idea C, and so on. When A returns it is still called A.

## Common forms
- **Binary form (AB)**: two contrasting sections, often each repeated.
- **Ternary form (ABA)**: a first section, a contrasting section and a return of the first. This gives balance and a satisfying return.
- **Rondo form (ABACA...)**: a main theme returns again and again between contrasting episodes. The refrain gives familiarity.
- **Theme and variations**: a theme is stated and then repeated with changes to features such as melody, rhythm, harmony, tempo, key or timbre.
- **Strophic form**: the same music is used for every verse, common in hymns and folk songs.
- **Through-composed**: new music throughout, with little or no repetition.
- **Sonata form**: used in many classical first movements. The **exposition** introduces the main themes, the **development** changes and explores them, and the **recapitulation** brings them back.
- **Twelve-bar blues**: a 12-bar chord pattern built on chords I, IV and V. In C these are C, F and G.

## Song structure
Most pop songs use named sections:
- **Intro**: sets the mood.
- **Verse**: the same melody with new words each time.
- **Pre-chorus**: builds towards the chorus.
- **Chorus**: the repeated hook with the same words and melody.
- **Bridge** or **middle eight**: a contrasting section, usually before the final chorus.
- **Outro** or **coda**: finishing section.

Other structural devices include the **ostinato** (a repeated pattern), **riff** (a short catchy repeated phrase), **sequence** (a pattern repeated at a higher or lower pitch) and **call and response** (a phrase answered by another).

## Working out lengths
You can find the number of bars by adding the sections. If the A section is 16 bars, B is 8 bars and A returns unchanged, the total is 16 + 8 + 16 = 40 bars. At 4/4, that is 160 beats.

## Common mistakes
- Calling every repeat a new letter; a repeated A is still A.
- Saying a piece is in ternary form without a clear contrast in the middle.
- Mixing up verse and chorus. The verse changes its words; the chorus does not.

## How this is examined
You may be given a description of an extract (sections, keys, instruments) and asked to identify the form, label the sections, calculate the number of bars or explain why a composer chose it. Strong answers link structure to effect: contrast creates interest, repetition creates unity and memorability.

Exam tip: Give the form, quote evidence from the sections, then explain the effect, for example 'ternary form because the opening tune returns after a contrasting middle, which gives balance'.$mq$ from st;

-- Listening and Analysing > Describing Music with Vocabulary
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Listening and Analysing$mq$, 5, 2 from public.subjects s where s.slug = $mq$music$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Describing Music with Vocabulary$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$music$mq$ and p.grade = 5 and p.name = $mq$Listening and Analysing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Describing Music with Vocabulary$mq$ and p.name = $mq$Listening and Analysing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'timbre' mean?$mq$, $mq$["The tone colour or quality of a sound","How loud a sound is","How fast the beat is","How many notes are in a chord"]$mq$, 0, $mq$Timbre separates the sound of one instrument or voice from another.$mq$, $mq$easy$mq$),
($mq$What is a melody?$mq$, $mq$["A set of chords","A steady beat","A change of key","A tune: a sequence of notes with rhythm"]$mq$, 3, $mq$The melody is the part you hum or sing along to.$mq$, $mq$easy$mq$),
($mq$A melody moves mainly in small steps from note to note. How is it described?$mq$, $mq$["Disjunct","Staccato","Conjunct (stepwise)","Polyphonic"]$mq$, 2, $mq$Conjunct melodies move by step, giving a smooth, flowing shape. Disjunct melodies have wide leaps.$mq$, $mq$easy$mq$),
($mq$What does 'pitch' describe?$mq$, $mq$["How loud a note is","How high or low a note is","How long a note lasts","How the note is attacked"]$mq$, 1, $mq$Pitch is related to the frequency of the sound wave. Higher frequency means higher pitch.$mq$, $mq$easy$mq$),
($mq$What is the 'beat' in music?$mq$, $mq$["The steady pulse you can tap along to","The highest note","The loudest note","The last chord"]$mq$, 0, $mq$The beat is the regular pulse, which is grouped into bars by the time signature.$mq$, $mq$easy$mq$),
($mq$A melody has big jumps between notes. Which word describes it?$mq$, $mq$["Conjunct","Monophonic","Legato","Disjunct"]$mq$, 3, $mq$Wide leaps make a melody disjunct, which can sound angular or dramatic.$mq$, $mq$medium$mq$),
($mq$What is the 'range' of a melody?$mq$, $mq$["The number of bars","The tempo","The distance from its lowest to highest note","The number of instruments"]$mq$, 2, $mq$A wide range makes a melody dramatic, while a narrow range is often calm.$mq$, $mq$medium$mq$),
($mq$A phrase is repeated starting two notes higher each time. What is this?$mq$, $mq$["Ostinato","Sequence","Drone","Canon"]$mq$, 1, $mq$A sequence repeats a pattern at a different pitch. An ostinato repeats at the same pitch.$mq$, $mq$medium$mq$),
($mq$Which word best describes a smooth, singable, expressive melody?$mq$, $mq$["Lyrical","Percussive","Dissonant","Static"]$mq$, 0, $mq$Lyrical melodies are song-like, with long smooth lines.$mq$, $mq$medium$mq$),
($mq$What is an anacrusis?$mq$, $mq$["A note held at the end","The loudest bar","The final chord","One or more notes before the first full bar"]$mq$, 3, $mq$An anacrusis (upbeat or pick-up) leads into the first strong beat, as in the opening of 'Happy Birthday'.$mq$, $mq$medium$mq$),
($mq$What is a drone?$mq$, $mq$["A very fast scale","A sudden loud chord","A long sustained or repeated note held beneath a tune","A solo"]$mq$, 2, $mq$Drones are used in bagpipes, sitar music and many folk traditions.$mq$, $mq$medium$mq$),
($mq$Which sentence is the best example of musical description?$mq$, $mq$["It sounded kind of cool and scary","The strings play a quick, staccato pattern in a minor key, creating tension","The song has many parts","I liked the music a lot"]$mq$, 1, $mq$Precise language (instrument, articulation, tempo, key) with a stated effect is what examiners reward.$mq$, $mq$medium$mq$),
($mq$Which pair of words describes a quiet, slow, thin texture?$mq$, $mq$["Calm and sparse","Frantic and dense","Loud and heavy","Fast and bright"]$mq$, 0, $mq$Slow tempo, soft dynamics and few layers combine to give a calm, sparse sound.$mq$, $mq$medium$mq$),
($mq$An extract has a walking double bass line, brushed drums, piano chords and an improvised saxophone solo. Which style is it most likely?$mq$, $mq$["Baroque chamber music","Brass band march","Electronic dance music","Jazz"]$mq$, 3, $mq$This combination of walking bass, brush drums, chordal piano and improvised solo is typical of a jazz combo.$mq$, $mq$hard$mq$),
($mq$In a listening answer, what does a 'point, evidence, effect' structure mean?$mq$, $mq$["List every instrument you hear","Describe your feelings only","State a feature, quote a musical detail, explain what it does","Write the longest answer you can"]$mq$, 2, $mq$Make a claim, support it with what you heard and explain the impact on the listener.$mq$, $mq$hard$mq$),
($mq$A long held note in the bass stays the same while chords change above it. What is it called?$mq$, $mq$["Arpeggio","Pedal note","Glissando","Cadence"]$mq$, 1, $mq$A pedal note creates tension and stability beneath changing harmony. It is a form of drone.$mq$, $mq$hard$mq$),
($mq$Extract A is 60 BPM, ppp, with one flute. Extract B is 160 BPM, ff, with full orchestra. Which pair of descriptions fits best?$mq$, $mq$["A is tranquil and fragile, B is energetic and powerful","A is energetic, B is tranquil","Both are tranquil","Both are energetic"]$mq$, 0, $mq$Slow, very quiet and thin means tranquil; fast, very loud and thick means powerful. Matching terms to evidence is key.$mq$, $mq$hard$mq$),
($mq$A melody has two 4-bar phrases. The second ends on the tonic, the first on a dominant chord. How can the relationship be described?$mq$, $mq$["Two unrelated melodies","A drone and a melody","A sequence of three notes","Question and answer phrasing"]$mq$, 3, $mq$Ending the first phrase unresolved and the second on the tonic makes a call-and-answer effect, like a musical sentence.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Describing Music with Vocabulary$mq$ and p.name = $mq$Listening and Analysing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Conjunct vs disjunct$mq$, $mq$Conjunct = moves by step, smooth. Disjunct = wide leaps, angular.$mq$),
($mq$Range$mq$, $mq$The distance between the lowest and highest notes of a melody.$mq$),
($mq$Sequence$mq$, $mq$A pattern repeated at a higher or lower pitch.$mq$),
($mq$Ostinato$mq$, $mq$A short pattern repeated persistently, often in the bass.$mq$),
($mq$Anacrusis$mq$, $mq$Pick-up note(s) before the first full bar line.$mq$),
($mq$Drone vs pedal note$mq$, $mq$A drone is a long held or repeated note under a tune; a pedal note is held in the bass while chords change above.$mq$),
($mq$Point, evidence, effect$mq$, $mq$State a feature, quote a musical detail you heard, explain the effect on the listener.$mq$),
($mq$Lyrical$mq$, $mq$Smooth, flowing and song-like, describing a melody.$mq$),
($mq$Pitch vs volume$mq$, $mq$Pitch = how high or low a note is. Volume (dynamics) = how loud or soft.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Describing Music with Vocabulary$mq$ and p.name = $mq$Listening and Analysing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why vocabulary matters
Describing music well is a key skill in listening, analysing and evaluating. A good answer uses accurate musical terms rather than vague words like 'nice' or 'cool'. It also links each feature to its effect. This sub-topic gives you the vocabulary toolkit and shows you how to use it.

## Describing melody
- **Pitch**: how high or low. A melody's **range** is the distance from its lowest to its highest note: narrow ranges feel calm, wide ranges feel dramatic.
- **Conjunct** (stepwise) melodies move by small steps and sound smooth. **Disjunct** melodies leap by wide intervals and sound angular.
- **Ascending** and **descending** show direction. A **sequence** repeats a pattern at a different pitch.
- **Lyrical** melodies are smooth and singable. **Phrases** are musical sentences, often in question-and-answer pairs.
- An **anacrusis** is the pick-up note or notes before the first bar line.

## Describing rhythm and tempo
Use beat, metre (2/4, 3/4, 4/4, 6/8), **syncopation**, **ostinato**, and tempo words such as allegro or adagio. A steady beat gives security, while syncopation gives surprise.

## Describing dynamics, timbre and texture
- Dynamics: pp, p, mf, f, ff, crescendo and diminuendo.
- Timbre: bright, warm, mellow, nasal, harsh, rich, breathy, buzzy, hollow.
- Texture: monophonic, homophonic, polyphonic, thin, thick, sparse, dense, unison.
- Articulation: legato, staccato, accented.
- Harmony: major, minor, consonant, dissonant, drone, pedal note, cadence.

## Writing a listening answer
Use the pattern **point, evidence, effect**. For example: 'The melody is disjunct (point), with leaps of an octave in the violins (evidence), which makes the opening sound bold and dramatic (effect).' Compare two extracts using words like 'whereas', 'in contrast' and 'both'. Always name the instrument, the feature and the impact.

## Matching features to moods
- Slow tempo, soft dynamics, thin texture, minor key: sad, fragile, calm.
- Fast tempo, loud dynamics, thick texture, staccato: energetic, tense, exciting.
- Wide range and disjunct melody: dramatic. Narrow range and conjunct melody: gentle.
- Dissonant harmony creates tension. Consonant harmony suggests resolution.

## Common mistakes
- Writing about feelings only, with no musical evidence.
- Using 'fast' for both loudness and speed. Loud is a dynamic, fast is a tempo.
- Listing features without explaining their effect.
- Mixing up pitch (high or low) and volume (loud or soft).

## How this is examined
You may be asked to choose the best description of a short extract, identify genre from features, compare two extracts or complete a sentence with the right term. In written tasks, marks come from accurate terminology and clear links to effect.

## Worked example
Imagine an extract that begins with a solo cello playing a slow, descending line in a low register, very quietly. Later, violins join with a sustained high chord and the music slowly gets louder. A strong answer might say: 'The cello melody is conjunct and descending (point), played pianissimo in a low register (evidence), which creates a dark, mournful opening (effect). The texture then thickens as violins enter with a crescendo, building tension and hope.' Notice that the answer names the instrument, the feature and the effect, and also traces how the music changes over time.

Exam tip: Never write 'it sounds good'. Name the element, the term and the effect.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('music')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;