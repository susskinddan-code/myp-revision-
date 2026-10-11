-- Part 3 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Music in Context > Western Classical Periods
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Music in Context$mq$, 5, 3 from public.subjects s where s.slug = $mq$music$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Western Classical Periods$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$music$mq$ and p.grade = 5 and p.name = $mq$Music in Context$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Western Classical Periods$mq$ and p.name = $mq$Music in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Johann Sebastian Bach composed in which period of Western classical music?$mq$, $mq$["Baroque","Classical","Romantic","Renaissance"]$mq$, 0, $mq$Bach (1685–1750) is a leading Baroque composer. Mozart and Haydn are Classical; Chopin and Tchaikovsky are Romantic.$mq$, $mq$easy$mq$),
($mq$Which keyboard instrument gradually replaced the harpsichord as the main keyboard in the Classical period?$mq$, $mq$["Organ","Accordion","Synthesiser","Piano"]$mq$, 3, $mq$The piano (pianoforte) could play both loudly and softly depending on touch, which suited Classical style.$mq$, $mq$easy$mq$),
($mq$Gregorian chant, sung by monks, belongs to which period?$mq$, $mq$["Baroque","Classical","Medieval","Romantic"]$mq$, 2, $mq$Plainchant is unaccompanied, monophonic sacred song from the medieval period (roughly 500–1400).$mq$, $mq$easy$mq$),
($mq$Wolfgang Amadeus Mozart is a composer from which period?$mq$, $mq$["Baroque","Classical","Romantic","Medieval"]$mq$, 1, $mq$Mozart (1756–1791) and Haydn are the most famous Classical composers.$mq$, $mq$easy$mq$),
($mq$What is a symphony?$mq$, $mq$["A long work for orchestra, usually in several movements","A song for one voice","A short piece for solo piano","A dance for a small band"]$mq$, 0, $mq$A symphony is a major orchestral work, often in four movements. Classical composers such as Haydn developed it.$mq$, $mq$easy$mq$),
($mq$What is 'basso continuo' in Baroque music?$mq$, $mq$["A very loud ending","A repeated drum rhythm","A type of choir","A bass line with chords played by instruments like harpsichord and cello"]$mq$, 3, $mq$The continuo group supplies the bass line and harmony throughout a Baroque piece.$mq$, $mq$medium$mq$),
($mq$Baroque composers often used 'terraced dynamics'. What does this mean?$mq$, $mq$["Very gradual crescendos","Only quiet playing","Sudden changes between loud and soft levels","A fading out of sound"]$mq$, 2, $mq$On harpsichord and organ, volume could not change gradually, so contrasts were made in steps, like terraces.$mq$, $mq$medium$mq$),
($mq$What was the main texture of Renaissance vocal music such as motets and madrigals?$mq$, $mq$["Monophonic, a single line","Polyphonic, with several equal vocal lines","A solo melody over drums","Electronic layers"]$mq$, 1, $mq$Renaissance composers wove independent vocal lines together, often imitating each other.$mq$, $mq$medium$mq$),
($mq$Which description best fits Classical period music?$mq$, $mq$["Balanced, clear phrases with light, clear textures","Huge, wildly emotional orchestral sound","Plainsong with no accompaniment","Atonal and unpredictable"]$mq$, 0, $mq$The Classical period prized order, elegance and clarity, using forms such as sonata form.$mq$, $mq$medium$mq$),
($mq$Which feature is typical of the Romantic period?$mq$, $mq$["Strict, simple phrases only","Monophonic chant","No dynamics at all","Expressive music with big orchestras and wide dynamics"]$mq$, 3, $mq$Romantic composers such as Tchaikovsky stressed emotion, imagination and personal expression.$mq$, $mq$medium$mq$),
($mq$Ludwig van Beethoven is often seen as a bridge between which two periods?$mq$, $mq$["Medieval and Renaissance","Baroque and Medieval","Classical and Romantic","Romantic and Baroque"]$mq$, 2, $mq$Beethoven (1770–1827) trained in the Classical style, then expanded its forms and emotion, opening the way for Romantic music.$mq$, $mq$medium$mq$),
($mq$What is 'programme music'?$mq$, $mq$["Music played at school concerts","Instrumental music that tells a story or paints a scene","Music with a printed list of songs","Music with no tune"]$mq$, 1, $mq$Programme music, popular in the Romantic period, uses sound to depict events, places or stories.$mq$, $mq$medium$mq$),
($mq$A pianist plays a short, dreamy piece called a 'nocturne' for solo piano in the 1830s. Which composer is most likely?$mq$, $mq$["Chopin","Vivaldi","Palestrina","Haydn"]$mq$, 0, $mq$Frédéric Chopin (1810–1849) wrote many nocturnes for piano, a typical Romantic character piece.$mq$, $mq$medium$mq$),
($mq$An extract has a harpsichord playing continuo, ornamented melodies and sudden shifts between loud and soft. Which period is it from?$mq$, $mq$["Classical","Romantic","Medieval","Baroque"]$mq$, 3, $mq$Harpsichord continuo, ornamentation and terraced dynamics are all Baroque features.$mq$, $mq$hard$mq$),
($mq$Mozart was born in 1756 and died in 1791. How old was he when he died, to the nearest year?$mq$, $mq$["31","45","35","65"]$mq$, 2, $mq$1791 − 1756 = 35. He wrote hundreds of works in his short life.$mq$, $mq$hard$mq$),
($mq$Which change in the Romantic period best explains why symphonies sounded bigger?$mq$, $mq$["Smaller groups of players","Larger orchestras with more brass and percussion","Removal of all strings","Fewer dynamic markings"]$mq$, 1, $mq$Romantic composers added instruments and extended the range of volume and colour for dramatic effect.$mq$, $mq$hard$mq$),
($mq$Why did the piano suit Classical composers better than the harpsichord?$mq$, $mq$["Hammers let players vary volume by touch","It was always louder than an orchestra","It had no keys","It played only one note at a time"]$mq$, 0, $mq$On a harpsichord the strings are plucked at a fixed volume; on a piano the hammer strikes with force that depends on the finger's touch.$mq$, $mq$hard$mq$),
($mq$A piece uses whole-tone scales and blurred, floating harmonies to suggest mist on water rather than tell a story. Which composer might have written it?$mq$, $mq$["Joseph Haydn","George Frideric Handel","Antonio Vivaldi","Claude Debussy"]$mq$, 3, $mq$Debussy (1862–1918) is linked to Impressionism, which suggests atmosphere and colour through unusual scales and harmony.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Western Classical Periods$mq$ and p.name = $mq$Music in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Medieval music$mq$, $mq$c. 500–1400. Monophonic plainchant (Gregorian chant) sung by monks.$mq$),
($mq$Renaissance music$mq$, $mq$c. 1400–1600. Polyphonic vocal music: masses, motets, madrigals. Composer: Palestrina.$mq$),
($mq$Baroque features$mq$, $mq$Basso continuo, ornamentation, terraced dynamics, fugue. Composers: Bach, Handel, Vivaldi.$mq$),
($mq$Classical features$mq$, $mq$Balanced, clear phrases, light textures, sonata form, symphony. Haydn, Mozart.$mq$),
($mq$Romantic features$mq$, $mq$Emotional, expressive, large orchestras, wide dynamics, programme music. Chopin, Tchaikovsky.$mq$),
($mq$Basso continuo$mq$, $mq$Baroque bass line plus chords played by a harpsichord or organ with a cello.$mq$),
($mq$Terraced dynamics$mq$, $mq$Sudden step changes between loud and soft, typical of Baroque music.$mq$),
($mq$Beethoven (1770–1827)$mq$, $mq$A bridge between Classical and Romantic periods.$mq$),
($mq$Programme music$mq$, $mq$Instrumental music that tells a story or describes a scene or idea.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Western Classical Periods$mq$ and p.name = $mq$Music in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why study the periods?
Western classical music is usually divided into periods, each with its own style, instruments, forms and typical composers. Knowing these helps you place an extract you hear and explain why you chose that period. The dates are approximate, because styles overlapped.

## Medieval (c. 500–1400)
Music was mostly sacred. **Plainchant** (Gregorian chant) was sung by monks in a single melodic line (monophonic), without instruments and in free rhythm. Later, singers began adding a second line, the start of polyphony.

## Renaissance (c. 1400–1600)
Vocal music flourished in church and at court. **Polyphonic** textures were typical, with several independent lines imitating each other, in **masses**, **motets** and secular **madrigals**. Palestrina is a famous composer of the period. Instruments included the lute and recorder. Printing helped spread music.

## Baroque (c. 1600–1750)
Music became ornate and dramatic. Key features:
- **Basso continuo**: a bass line and chords played by harpsichord or organ with cello.
- **Terraced dynamics**: sudden changes between loud and soft.
- **Ornamentation**: decorations added to melodies.
- Forms such as the **fugue**, concerto, suite and the new genre of opera.

Composers include Bach (1685–1750), Handel and Vivaldi.

## Classical (c. 1750–1820)
Music aimed for clarity, balance and elegance. Melodies had clear, even phrases with simple accompaniments (homophonic texture). The orchestra grew and the **piano** replaced the harpsichord. Forms such as **sonata form**, the **symphony** and the **string quartet** developed. Main composers are Haydn, Mozart (1756–1791) and early Beethoven.

## Romantic (c. 1820–1900)
Composers prized emotion, imagination and individuality. Orchestras grew, dynamics became wider, harmony more chromatic and **rubato** was common. **Programme music** told stories or painted scenes. Chopin wrote piano nocturnes, Tchaikovsky wrote ballets and symphonies, and Beethoven (1770–1827) bridged Classical and Romantic styles.

## Twentieth century onwards
Composers experimented with new sounds and techniques. Debussy and Impressionism evoked atmosphere using whole-tone scales and fluid harmony. Others such as Stravinsky used strong, irregular rhythms. Electronic instruments and recording opened new possibilities.

## Quick comparison
- Baroque: ornate, continuo, terraced dynamics.
- Classical: balanced, clear, light textures.
- Romantic: emotional, big orchestra, wide dynamics.

## Common mistakes
- Treating Beethoven as only Classical or only Romantic; he belongs to both.
- Saying the Baroque is 'less advanced'. It has complex counterpoint.
- Confusing a composer's lifespan with the period; dates overlap.

## How this is examined
You may read a short description of an extract, such as its instruments, texture and dynamics, then choose the period and justify your choice with at least two features. You might also be asked to calculate a composer's age or time span.

Exam tip: Always back up your choice of period with two or more musical features from the extract, not just a guess at the composer.$mq$ from st;

-- Music in Context > World and Popular Music
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Music in Context$mq$, 5, 3 from public.subjects s where s.slug = $mq$music$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$World and Popular Music$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$music$mq$ and p.grade = 5 and p.name = $mq$Music in Context$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$World and Popular Music$mq$ and p.name = $mq$Music in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$From which country does the gamelan orchestra come?$mq$, $mq$["Indonesia","Brazil","Jamaica","Spain"]$mq$, 0, $mq$Gamelan is the traditional ensemble of Java and Bali in Indonesia, made up mostly of bronze percussion instruments.$mq$, $mq$easy$mq$),
($mq$In Indian classical music, what is the 'raga'?$mq$, $mq$["A type of drum","A rhythm cycle","A song with words only","A melodic framework of notes and rules for improvising"]$mq$, 3, $mq$A raga defines the notes, their characteristic movements and mood. The rhythmic cycle is called the tala.$mq$, $mq$easy$mq$),
($mq$What are tabla?$mq$, $mq$["A set of bronze gongs","A bowed string instrument","A pair of hand drums from India","A brass horn"]$mq$, 2, $mq$Tabla are played with the fingers and palms and are central to North Indian classical music.$mq$, $mq$easy$mq$),
($mq$The djembe is a drum from which region?$mq$, $mq$["South America","West Africa","Scandinavia","East Asia"]$mq$, 1, $mq$The djembe is a goblet-shaped hand drum from West Africa played with bare hands.$mq$, $mq$easy$mq$),
($mq$Reggae music developed in which country?$mq$, $mq$["Jamaica","Cuba","Ireland","Japan"]$mq$, 0, $mq$Reggae emerged in Jamaica in the late 1960s, growing out of ska and rocksteady.$mq$, $mq$easy$mq$),
($mq$What is a 'tala' in Indian classical music?$mq$, $mq$["A melodic scale","A drone instrument","A singer's range","A repeating rhythmic cycle"]$mq$, 3, $mq$The tala organises beats into cycles, for example the 16-beat cycle called teental. Ragas supply the melody.$mq$, $mq$medium$mq$),
($mq$What is polyrhythm?$mq$, $mq$["A single melody sung in unison","A chord with many notes","Several different rhythms played at the same time","A slow, steady beat only"]$mq$, 2, $mq$Polyrhythm layers contrasting patterns and is a key feature of West African drumming.$mq$, $mq$medium$mq$),
($mq$Which instrument provides the constant drone in a North Indian raga performance?$mq$, $mq$["Tabla","Tanpura","Flute","Harmonium only"]$mq$, 1, $mq$The tanpura is a long-necked plucked instrument whose strings sound the tonic and fifth continuously.$mq$, $mq$medium$mq$),
($mq$Where did the blues originate?$mq$, $mq$["African American communities in the southern United States","Eastern Europe","Northern India","Australia"]$mq$, 0, $mq$The blues grew out of work songs and spirituals in the late 19th and early 20th century, and it shaped jazz, rock and soul.$mq$, $mq$medium$mq$),
($mq$Hip-hop began in the 1970s in which place?$mq$, $mq$["London","Kingston, Jamaica","Rio de Janeiro","The Bronx, New York City"]$mq$, 3, $mq$Hip-hop culture, with MCing, DJing, breakdancing and graffiti, grew from Bronx neighbourhoods in the 1970s.$mq$, $mq$medium$mq$),
($mq$What is sampling?$mq$, $mq$["Singing a tune from memory","Tuning an instrument","Reusing a recorded section of existing music in a new track","Playing a scale"]$mq$, 2, $mq$Producers take snippets of recordings and loop or edit them. Rights to the original recording and composition must be respected.$mq$, $mq$medium$mq$),
($mq$In flamenco, what do the 'palmas' refer to?$mq$, $mq$["A type of guitar","Rhythmic hand-clapping","A dress","A rest in the music"]$mq$, 1, $mq$Flamenco, from Andalusia in southern Spain, combines singing, guitar, dance and palmas.$mq$, $mq$medium$mq$),
($mq$In a reggae groove counted '1 & 2 & 3 & 4 &', where does the guitar chop usually fall?$mq$, $mq$["On the off-beats, the '&'s","Only on beat 1","On every beat with equal accent","Nowhere; it is silent"]$mq$, 0, $mq$Reggae's 'skank' emphasises the off-beats while the bass plays a prominent melodic line.$mq$, $mq$medium$mq$),
($mq$An extract features bronze metallophones, hanging gongs and interlocking patterns, with a large gong marking the end of each cycle. Which tradition is it?$mq$, $mq$["Mariachi","Bluegrass","Brass band","Gamelan"]$mq$, 3, $mq$Gamelan music uses bronze instruments in interlocking parts, and large gongs mark the cycle's structure.$mq$, $mq$hard$mq$),
($mq$Three drummers play different repeating patterns while a leader calls and the group answers. Which two features does this show?$mq$, $mq$["Monophony and rubato","Modulation and cadence","Polyrhythm and call and response","Staccato and legato"]$mq$, 2, $mq$Layered patterns are polyrhythm, and a leader answered by a group is call and response, both typical in West African drumming.$mq$, $mq$hard$mq$),
($mq$Why is the drone important in a raga performance?$mq$, $mq$["It adds loud rhythms","It gives a fixed reference pitch for the improvised melody","It plays the tala","It changes key often"]$mq$, 1, $mq$The continuous tonic lets listeners hear each note's relationship to the home note, shaping the raga's mood.$mq$, $mq$hard$mq$),
($mq$A band mixes jazz improvisation with sitar and tabla. What is this blending called?$mq$, $mq$["Fusion","Canon","Plainchant","Serialism"]$mq$, 0, $mq$Fusion combines elements from different styles or cultures into a new sound.$mq$, $mq$hard$mq$),
($mq$Which statement about learning a style from another culture is the strongest?$mq$, $mq$["Copy it quickly without research","Change it until it is unrecognisable","Avoid learning because it is unfamiliar","Listen carefully, learn its context and credit the tradition"]$mq$, 3, $mq$Showing respect and understanding is a key principle of intercultural learning, and it improves the quality of the performance too.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$World and Popular Music$mq$ and p.name = $mq$Music in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Gamelan$mq$, $mq$Indonesian ensemble of bronze percussion (metallophones, gongs) with interlocking cyclic patterns.$mq$),
($mq$Raga$mq$, $mq$An Indian melodic framework of notes and patterns used for improvisation.$mq$),
($mq$Tala$mq$, $mq$A repeating rhythmic cycle in Indian classical music, e.g. 16-beat teental.$mq$),
($mq$Tanpura$mq$, $mq$A plucked instrument that sounds a continuous drone in Indian classical music.$mq$),
($mq$Polyrhythm$mq$, $mq$Several contrasting rhythms layered together, typical of West African drumming.$mq$),
($mq$Call and response$mq$, $mq$A leader sings or plays a phrase and a group answers it.$mq$),
($mq$Reggae features$mq$, $mq$From Jamaica; prominent bass, off-beat guitar chops (skank), steady drum pulse.$mq$),
($mq$Blues origins$mq$, $mq$African American communities in the southern US; 12-bar form and blue notes.$mq$),
($mq$Fusion$mq$, $mq$A blend of elements from different musical styles or cultures.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$World and Popular Music$mq$ and p.name = $mq$Music in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Music around the world
Every culture has music, but styles, instruments, tuning systems and purposes differ widely. Studying world and popular music helps us understand how musical elements are used in different traditions and why those traditions developed. Always describe music with the vocabulary of the elements, and be respectful of the culture it comes from.

## Indonesia: gamelan
A **gamelan** ensemble from Java or Bali consists mostly of bronze percussion: metallophones, gongs and drums. The parts **interlock**, and a large gong marks the end of a cycle. The music is based on repeating cycles with different layers moving at different speeds.

## India: raga and tala
North and South Indian classical music is based on **raga** (a melodic framework with specific notes, patterns and moods, used for improvisation) and **tala** (a repeating rhythmic cycle, for example the 16-beat teental). A **drone**, usually played on the **tanpura**, provides a constant tonic. Common instruments are the **sitar**, **sarod**, bansuri flute, **tabla** and harmonium. Performances typically build slowly from free-time introduction to fast, rhythmic sections.

## West Africa: drumming
Drum ensembles use **polyrhythm**, several contrasting repeating patterns layered together, and **call and response** between a leader and the group. Instruments include the **djembe** and the **talking drum**, which can imitate the pitches of speech. Music is closely tied to community, dance and storytelling.

## The Americas and Caribbean
- **Blues**: began in African American communities in the southern United States. It uses the 12-bar pattern, blue notes and expressive vocal style.
- **Jazz**: grew in New Orleans in the early 20th century with swing rhythms, syncopation and improvisation.
- **Reggae**: from Jamaica, with prominent bass, off-beat guitar and keyboard 'skank' chords, and socially conscious lyrics.
- **Samba**: Brazilian carnival music with large percussion groups and syncopated rhythms.
- **Mariachi**: Mexican ensemble with trumpets, violins and guitars.

## Other traditions
**Flamenco** from Andalusia in Spain combines guitar, singing, dance and palmas (clapping). Japanese **taiko** drumming is powerful and ceremonial. Chinese music commonly uses the pentatonic scale and instruments such as the erhu and guzheng.

## Popular music
Popular music includes rock and roll (1950s), pop, soul, funk, disco, electronic dance music and **hip-hop**, which began in the Bronx, New York in the 1970s. Pop songs commonly use verse-chorus structure, a strong hook, and a steady beat. Technologies such as the electric guitar, synthesiser, drum machine and **sampling** have shaped new genres. **Fusion** blends styles together.

## Common mistakes
- Treating 'world music' as one style rather than many different traditions.
- Mixing up raga (melody) and tala (rhythm).
- Saying a drone is a rhythm.

## How this is examined
You may meet a written description of an extract and be asked to identify the style from features, or to compare two styles. Name the features, link them to the culture, and show respect in your wording.

Exam tip: Identify the tradition by at least two features, such as 'bronze gongs and interlocking cyclic patterns, so gamelan'.$mq$ from st;

-- Music in Context > Music, Culture and Society
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Music in Context$mq$, 5, 3 from public.subjects s where s.slug = $mq$music$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Music, Culture and Society$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$music$mq$ and p.grade = 5 and p.name = $mq$Music in Context$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Music, Culture and Society$mq$ and p.name = $mq$Music in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a national anthem mainly used for?$mq$, $mq$["To represent a country's identity at official events","To teach scales","To accompany a film","To advertise products"]$mq$, 0, $mq$Anthems express national pride and are performed at ceremonies and sporting events.$mq$, $mq$easy$mq$),
($mq$What is the purpose of a lullaby?$mq$, $mq$["To start a dance","To protest","To announce a sports result","To soothe a child to sleep"]$mq$, 3, $mq$Lullabies use soft dynamics, gentle repeated melodies and steady rocking rhythms.$mq$, $mq$easy$mq$),
($mq$What is the main function of dance music?$mq$, $mq$["To tell a legal story","To teach history only","To accompany and inspire dancing","To be played in silence"]$mq$, 2, $mq$Dance music has a clear, steady beat so dancers can move together.$mq$, $mq$easy$mq$),
($mq$In film music, what is a leitmotif?$mq$, $mq$["A very loud chord","A short theme linked to a character, idea or place","A type of microphone","A silence between scenes"]$mq$, 1, $mq$Leitmotifs, used by composers like John Williams and earlier by Wagner, return when their subject appears on screen.$mq$, $mq$easy$mq$),
($mq$What is a protest song?$mq$, $mq$["A song that expresses opinions about social or political issues","A song that sells goods","A lullaby","A classical symphony"]$mq$, 0, $mq$Protest songs raise awareness and unite people around a cause.$mq$, $mq$easy$mq$),
($mq$What does copyright protect?$mq$, $mq$["The price of instruments","The tempo of a song","Who may listen to music at home","The rights of creators over their original work"]$mq$, 3, $mq$Copyright gives composers and recording artists control over how their work is copied, performed and shared.$mq$, $mq$medium$mq$),
($mq$How have streaming services changed how people listen to music?$mq$, $mq$["Music can only be heard in concert halls","Recordings can no longer be made","Listeners can access huge catalogues instantly","All music is free to the artist"]$mq$, 2, $mq$Streaming makes a wide range of music available at any time, changing how music is discovered and paid for.$mq$, $mq$medium$mq$),
($mq$In earlier centuries, why were the church and royal courts important to composers?$mq$, $mq$["They banned all music","They acted as patrons who employed and paid composers","They sold instruments only","They designed concert halls only"]$mq$, 1, $mq$Bach worked for churches and courts and Haydn spent decades employed by a noble family, so patrons shaped what was written.$mq$, $mq$medium$mq$),
($mq$In a film, music that the characters cannot hear, such as an orchestral score, is called what?$mq$, $mq$["Non-diegetic music","Diegetic music","Source music","Silent music"]$mq$, 0, $mq$Non-diegetic music is added for the audience. Diegetic music comes from within the scene, such as a radio playing.$mq$, $mq$medium$mq$),
($mq$Which is a valid way music can support wellbeing?$mq$, $mq$["It always raises blood pressure","It removes the need for sleep","It cures all illnesses","It can help people relax and express feelings"]$mq$, 3, $mq$Listening to or making music can reduce stress and support mood. It is a support, not a cure.$mq$, $mq$medium$mq$),
($mq$What does it mean to appreciate rather than appropriate another culture's music?$mq$, $mq$["Copy it and claim it as your own","Use sacred songs as jokes","Learn about it, credit its source and treat it with respect","Change it until its origins vanish"]$mq$, 2, $mq$Appreciation involves understanding context, giving credit and respecting meaning, especially for sacred or ceremonial music.$mq$, $mq$medium$mq$),
($mq$What is traditional folk music?$mq$, $mq$["Music written only by famous composers","Music passed down by ear within a community","Music made only on computers","Music played only in concert halls"]$mq$, 1, $mq$Folk songs are often learned orally and reflect everyday life, festivals and history.$mq$, $mq$medium$mq$),
($mq$Which invention first allowed people to hear a performance after it had finished?$mq$, $mq$["Sound recording (such as Edison's phonograph in 1877)","The metronome","The music stave","The piano"]$mq$, 0, $mq$Recording technology started with the phonograph in 1877 and later developed through vinyl, tape, CDs and digital audio.$mq$, $mq$medium$mq$),
($mq$A school wants to put a famous pop song behind a video that will be shared online. What should it do first?$mq$, $mq$["Upload it anyway","Change one note to avoid rules","Delete the video's title","Check copyright and get permission or a licence"]$mq$, 3, $mq$Using protected music in a public video usually requires permission or a licence from the rights holders.$mq$, $mq$hard$mq$),
($mq$A thriller scene uses non-diegetic low tremolo strings and sudden dissonant chords. What is the likely purpose?$mq$, $mq$["To make the audience laugh","To tell the time","To build suspense and fear for the audience","To teach harmony"]$mq$, 2, $mq$Low tremolo and dissonance produce tension. The audience feels fear before the characters know of danger.$mq$, $mq$hard$mq$),
($mq$A student wants to sample a traditional song from another culture in a composition. Which approach is most respectful?$mq$, $mq$["Use it without telling anyone","Research its meaning, credit the source and get permission where needed","Change the words to jokes","Claim the tune as an original"]$mq$, 1, $mq$Respect involves understanding context, acknowledging the culture and following copyright or community rules.$mq$, $mq$hard$mq$),
($mq$Someone argues: 'Music is a universal language, so it means the same thing everywhere.' What is the best evaluation?$mq$, $mq$["Music is found in all cultures, but its meanings and uses vary","The statement is completely true","Music has no meaning anywhere","Only classical music has meaning"]$mq$, 0, $mq$Making music is universal, but features like scales, instruments and the occasions for performing differ and can carry different meanings.$mq$, $mq$hard$mq$),
($mq$A town festival uses drums, singing and dance to celebrate the harvest, and everybody joins in. Which functions of music does it show?$mq$, $mq$["Private study","Advertising","Silent reflection","Celebration and community bonding"]$mq$, 3, $mq$Shared music making in a festival brings people together and marks a special occasion.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Music, Culture and Society$mq$ and p.name = $mq$Music in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Functions of music$mq$, $mq$Ceremony, entertainment, dance, storytelling, protest, identity, comfort and wellbeing, film and media.$mq$),
($mq$Leitmotif$mq$, $mq$A short theme linked to a character, place or idea in a film or opera.$mq$),
($mq$Diegetic vs non-diegetic$mq$, $mq$Diegetic: music characters can hear (a radio). Non-diegetic: score added for the audience.$mq$),
($mq$Copyright$mq$, $mq$The legal right of creators to control copying, performance and sharing of their original work.$mq$),
($mq$Patron$mq$, $mq$A church, noble or court that paid composers and influenced the music they wrote.$mq$),
($mq$Sampling$mq$, $mq$Reusing a short part of an existing recording in a new piece; needs permission.$mq$),
($mq$Cultural appreciation$mq$, $mq$Learning, crediting and respecting a culture's music and its meaning.$mq$),
($mq$Phonograph, 1877$mq$, $mq$Edison's invention that first recorded and replayed sound.$mq$),
($mq$Folk music$mq$, $mq$Traditional community music, often passed on by ear and linked to everyday life.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$music$mq$ and t.grade = 5 and t.name = $mq$Music, Culture and Society$mq$ and p.name = $mq$Music in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why people make music
Music is part of every society. People use it to celebrate, mourn, worship, work, play, protest, advertise and heal. Studying the roles of music in society helps us understand why composers and performers make the choices they do. Think about music as something that is made **for** a purpose and a place, as well as something to analyse.

## Functions of music
- **Ceremony and ritual**: weddings, funerals, religious services and national events. Hymns, chants and anthems unite groups. A **national anthem** is a song that represents a country's identity.
- **Entertainment**: concerts, festivals, musicals, games.
- **Dance**: a steady, clear beat helps dancers move together.
- **Communication and storytelling**: folk songs, work songs and ballads pass stories through generations. Folk music is often learned by ear.
- **Protest and identity**: protest songs raise awareness of issues. Music can show who a community is.
- **Comfort and wellbeing**: lullabies soothe, and listening or playing can help people relax and express feelings.
- **Film, television and games**: composers use **leitmotifs**, themes linked to characters or ideas, and tailor the music to the story. **Diegetic** music is part of the scene (a radio playing). **Non-diegetic** music is added for the audience (an orchestral score).

## Music and history
Before recordings, composers often depended on **patrons** such as the church and royal courts, who paid them and decided what they wrote. Later, public concerts, printed music and teaching offered new incomes. Technology has changed music again and again: the phonograph (1877) allowed recorded sound, radio spread music widely, the electric guitar and synthesiser created new sounds, and streaming and digital tools now allow almost anyone to share music worldwide.

## Rights and responsibilities
**Copyright** protects the rights of creators over their original music. If you want to use another person's music in a video, recording or performance, you usually need permission or a licence, and you should credit the source. **Sampling** uses short excerpts of existing recordings and also needs permission. Plagiarism is passing off someone else's work as your own.

## Respecting cultures
**Cultural appreciation** means learning about the origin, meaning and context of a style, crediting where it comes from and performing it respectfully. **Cultural appropriation** is taking elements from a culture without understanding or credit, especially if the music is sacred or important to its community. When composing in another style, research, listen to a range of performers and, if possible, learn from members of that community.

## Common mistakes
- Saying music means the same everywhere. Meanings and uses differ.
- Confusing diegetic and non-diegetic music.
- Thinking free access online means free to reuse.

## How this is examined
You are likely to read a scenario, such as a school event, film scene or community festival, and explain the function of the music, choose an appropriate response to a copyright issue, or evaluate an argument about culture and technology. Use specific terms and give reasons for each choice.

Exam tip: Link every point about music to a person, a purpose and a place, for example 'the leitmotif tells the audience the villain is near'.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('music')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;