-- Part 1 of 4: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Elements of Drama > Role, Character and Relationships
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Elements of Drama$mq$, 5, 1 from public.subjects s where s.slug = $mq$drama$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Role, Character and Relationships$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$drama$mq$ and p.grade = 5 and p.name = $mq$Elements of Drama$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Role, Character and Relationships$mq$ and p.name = $mq$Elements of Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In drama, what does the word 'role' mean?$mq$, $mq$["The part an actor plays in a drama","The set the actors stand on","The lights used in a scene","The audience's seating plan"]$mq$, 0, $mq$A role is the part or character an actor takes on in a piece of drama.$mq$, $mq$easy$mq$),
($mq$A student plays a nervous new teacher in an improvisation. What is the student doing?$mq$, $mq$["Writing a review","Operating the lights","Directing the whole play","Taking on a role"]$mq$, 3, $mq$Taking on a role means pretending to be someone else, here a nervous teacher.$mq$, $mq$easy$mq$),
($mq$Which of these is a way an actor shows a character's age through the body?$mq$, $mq$["Wearing a sound cue","Standing in the wings","Slow, stiff movement and a stooped back","Writing a script"]$mq$, 2, $mq$Posture and pace of movement can show age; the other options are not physical character choices.$mq$, $mq$easy$mq$),
($mq$Two actors play a brother and sister who argue. What is the link between their characters called?$mq$, $mq$["A prop","A relationship","A cue","A blackout"]$mq$, 1, $mq$The connection between characters, such as siblings, is their relationship.$mq$, $mq$easy$mq$),
($mq$What is a 'motivation' in character work?$mq$, $mq$["The reason a character wants or does something","The cost of the costume","The length of the scene","The size of the stage"]$mq$, 0, $mq$Motivation is the why behind a character's actions.$mq$, $mq$easy$mq$),
($mq$In a rehearsal, an actor plays a shopkeeper. She keeps her chin high, speaks crisply and avoids eye contact with a customer who owes money. What is she mainly showing?$mq$, $mq$["The time of day","The stage direction 'upstage'","The lighting plan","Status and attitude through voice and body"]$mq$, 3, $mq$Chin, voice and eye contact are used to show status and attitude toward another character.$mq$, $mq$medium$mq$),
($mq$An actor playing a grandfather speaks slowly and leans on a stick. A classmate says it looks like a cartoon because the actor wobbles constantly. What is the best advice?$mq$, $mq$["Add more wobbling","Remove the voice completely","Make the physical choices smaller and more believable","Stand still for the whole scene"]$mq$, 2, $mq$Exaggerating every detail makes a character unbelievable; subtler, selected choices feel more real.$mq$, $mq$medium$mq$),
($mq$A character says 'I'm fine' but clenches both fists and looks at the floor. What does this contrast show?$mq$, $mq$["A lighting error","Subtext: the true feeling differs from the words","A scene change","A blocking mistake"]$mq$, 1, $mq$Subtext is what a character really feels beneath the words; body language reveals it.$mq$, $mq$medium$mq$),
($mq$Which technique asks an actor to list a character's age, family, hobbies and fears before rehearsing?$mq$, $mq$["Building a character profile","Blocking the scene","Setting a lighting cue","Choosing the genre"]$mq$, 0, $mq$A character profile gathers background details that guide choices in performance.$mq$, $mq$medium$mq$),
($mq$In a scene, a leader character moves to the centre, others gather around and she speaks while sitting; everyone else stands. What relationship is communicated?$mq$, $mq$["That she is the least important","That the scene is a comedy","That the scene is set at night","Her high status over the others"]$mq$, 3, $mq$Being central, seated and the focus of others suggests high status.$mq$, $mq$medium$mq$),
($mq$Two actors perform a conversation. One keeps stepping closer; the other keeps stepping back. What is shown through proxemics?$mq$, $mq$["Agreement between two best friends","A change of lighting","Discomfort and an imbalance in the relationship","The end of the play"]$mq$, 2, $mq$Proxemics is the use of distance. One advancing and one retreating signals unease or pressure.$mq$, $mq$medium$mq$),
($mq$An actor plays a character who is lying to a friend. Which choice best shows the lie without saying it?$mq$, $mq$["A loud sound effect","A too-wide smile with shifty eye contact","Turning off the lights","Reading the stage directions aloud"]$mq$, 1, $mq$The body and face can betray the lie, creating subtext without extra words.$mq$, $mq$medium$mq$),
($mq$Which is the best definition of 'characterisation'?$mq$, $mq$["The choices an actor makes to create a believable character","The writing of the programme","The choice of theatre building","The marking of the script"]$mq$, 0, $mq$Characterisation includes voice, movement, gesture, attitude and background choices.$mq$, $mq$medium$mq$),
($mq$Students rehearse a scene where a daughter returns after years away. Which exercise would best explore the relationship?$mq$, $mq$["Memorising the lighting plot","Counting seats in the hall","Copying the script by hand","Hot-seating the daughter and the parent in character"]$mq$, 3, $mq$Hot-seating means answering questions in role, so it deepens understanding of the relationship.$mq$, $mq$hard$mq$),
($mq$An actor is told: 'Your character wants to leave but is trapped by duty.' Which approach best shows this inner conflict?$mq$, $mq$["Stay perfectly still throughout","Speak louder every line","Start towards the door, then pause and turn back","Look straight at the audience throughout"]$mq$, 2, $mq$A physical action that starts and stops shows two competing desires.$mq$, $mq$hard$mq$),
($mq$Two characters are enemies. Which staging choice keeps this tension clear even when they are silent?$mq$, $mq$["They sit close and smile","They avoid eye contact and keep angled bodies with a wide gap","They both exit","They stay in blackout"]$mq$, 1, $mq$Distance and closed body angles show hostility without dialogue.$mq$, $mq$hard$mq$),
($mq$A director asks an actor to 'play against the line': say 'I'm delighted' in a flat tone while looking away. What effect is most likely?$mq$, $mq$["The audience senses the character does not mean it","The audience becomes confused about the plot only","The line becomes louder","The scene ends"]$mq$, 0, $mq$Contradicting words with delivery creates irony and signals hidden feeling.$mq$, $mq$hard$mq$),
($mq$An actor must show a character who changes from shy to confident during a scene lasting ten minutes. Which plan is strongest?$mq$, $mq$["Change completely in the first line","Keep the same posture throughout","Change only the costume","Gradually widen posture and strengthen voice at key moments"]$mq$, 3, $mq$A gradual, motivated change in voice and body makes the arc believable.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Role, Character and Relationships$mq$ and p.name = $mq$Elements of Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Role$mq$, $mq$The part an actor plays in a piece of drama.$mq$),
($mq$Characterisation$mq$, $mq$The voice, movement, attitude and background choices an actor makes to create a believable character.$mq$),
($mq$Motivation$mq$, $mq$The reason a character wants something or acts in a certain way.$mq$),
($mq$Subtext$mq$, $mq$What a character truly feels or means beneath the words they say.$mq$),
($mq$Status$mq$, $mq$How important or powerful a character seems compared with others; shown by space, posture, voice and focus.$mq$),
($mq$Proxemics$mq$, $mq$The use of distance between characters to show a relationship or feeling.$mq$),
($mq$Hot-seating$mq$, $mq$Answering questions in role so you understand the character's thoughts and background.$mq$),
($mq$Character arc$mq$, $mq$The change a character goes through during the drama.$mq$),
($mq$Multi-roling$mq$, $mq$Playing more than one character in a piece, using clear changes in voice, posture or costume.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Role, Character and Relationships$mq$ and p.name = $mq$Elements of Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## What is a role?
In drama, a **role** is the part you take on when you pretend to be someone else. A **character** is the person you create: their age, background, beliefs, needs and the way they speak and move. **Characterisation** is the set of choices an actor makes to make that character believable and interesting for an audience.

## Building a character
Strong actors do not just copy a stereotype. They gather information and then select a few clear choices.
- **Character profile**: list the character's age, family, job, hobbies, fears and secrets, even details the script never mentions.
- **Motivation**: the reason the character wants something. A character who wants to win an argument behaves differently from one who wants to avoid it.
- **Objective and obstacle**: what the character wants in this scene and what stops them.
- **Hot-seating**: answering questions in role so you discover how the character thinks.
- **Thought-tracking**: speaking a character's private thoughts aloud at a frozen moment.

## Showing character through the body and voice
Audiences read characters mainly from what they see and hear.
- **Posture and gait**: a stooped back and slow steps suggest age or tiredness; a lifted chest suggests confidence.
- **Gesture and facial expression**: small movements such as clenched fists or a nervous smile can say more than a speech.
- **Voice**: pitch, pace, volume, accent and tone. A quiet, fast voice may suggest fear; a slow, low voice may suggest authority.
- **Eye contact**: avoiding it can show shyness, guilt or dishonesty.
Choose a few clear details and repeat them. Too many make a character look like a cartoon.

## Status, subtext and relationships
A **relationship** is the connection between two characters, such as friends, rivals or parent and child. Relationships are shown through how characters treat each other.
- **Status** is how important a character seems compared with others. High status is shown by taking up space, being central, speaking calmly and being listened to. Low status is shown by smaller movements, looking away and giving way.
- **Proxemics** is the use of distance between characters. Stepping closer can show affection or threat; stepping back can show fear or dislike.
- **Subtext** is what a character really feels beneath the words. If a character says 'I'm fine' while staring at the floor, the audience understands the truth from the body language.
- **Contrast and irony**: playing against a line makes the audience notice the gap between what is said and what is meant.

## Character arc and multi-roling
A **character arc** is the change a character goes through during the drama. If an actor plays a shy girl who becomes confident, the change should be gradual and linked to events. **Multi-roling** means playing more than one character in the same piece, which is common in devised work. Clear changes in posture, voice and a simple costume item (a jacket or hat) help the audience follow.

## Common mistakes
- Playing the same emotion all the way through a scene.
- Over-acting every detail.
- Forgetting to react when you are not speaking; listening is part of acting.
- Staying in the same position, so relationships never seem to move.

## How this is examined
In ePortfolio style tasks, you are expected to name the elements you used, explain why a choice suited the character, and evaluate how well it worked for the audience. Questions typically give a short scene description and ask which choice best shows a relationship or inner conflict, or how to improve a performance.

Exam tip: Use precise terms such as status, subtext, motivation and proxemics, and always link a performance choice to its effect on the audience.$mq$ from st;

-- Elements of Drama > Space, Movement and Voice
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Elements of Drama$mq$, 5, 1 from public.subjects s where s.slug = $mq$drama$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Space, Movement and Voice$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$drama$mq$ and p.grade = 5 and p.name = $mq$Elements of Drama$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Space, Movement and Voice$mq$ and p.name = $mq$Elements of Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is the 'stage space'?$mq$, $mq$["The area where the performance takes place","The money spent on the show","The script's title page","The costume cupboard"]$mq$, 0, $mq$Stage space is the performance area used by actors.$mq$, $mq$easy$mq$),
($mq$Which part of the stage is closest to the audience in a proscenium theatre?$mq$, $mq$["Upstage","Backstage","Offstage left","Downstage"]$mq$, 3, $mq$Downstage is nearest the audience; upstage is furthest away.$mq$, $mq$easy$mq$),
($mq$What does 'pace' mean in vocal work?$mq$, $mq$["How loud you speak","How high your voice is","The speed at which you speak","The accent used"]$mq$, 2, $mq$Pace is the speed of speech; volume is loudness and pitch is highness or lowness.$mq$, $mq$easy$mq$),
($mq$Which vocal skill describes how high or low a voice sounds?$mq$, $mq$["Pause","Pitch","Projection","Pace"]$mq$, 1, $mq$Pitch is the highness or lowness of the voice.$mq$, $mq$easy$mq$),
($mq$What is 'projection'?$mq$, $mq$["Making the voice reach the audience clearly without shouting","Showing a film on a wall","Moving across the stage fast","Hiding the face"]$mq$, 0, $mq$Projection uses breath support so the audience can hear you without strain.$mq$, $mq$easy$mq$),
($mq$A character is frightened of a noise behind them. Which movement best shows this?$mq$, $mq$["A relaxed stroll and a yawn","A cartwheel","Sitting facing away and reading","A sudden freeze, head turning slowly and shallow breaths"]$mq$, 3, $mq$Freezing and slowly turning shows fear using movement.$mq$, $mq$medium$mq$),
($mq$A group stands in a tight cluster while one actor stands alone, far stage left. What does the use of space suggest?$mq$, $mq$["The group is lost","The lone actor is the director","The lone actor is excluded or isolated","The scene is over"]$mq$, 2, $mq$Distance and grouping can communicate belonging and isolation.$mq$, $mq$medium$mq$),
($mq$A speaker gradually increases volume and pace towards the end of a speech. What effect is created?$mq$, $mq$["Calm and boredom","Rising urgency or anger","A change of scene","A blackout"]$mq$, 1, $mq$Building volume and pace creates rising tension.$mq$, $mq$medium$mq$),
($mq$What are 'levels' in staging?$mq$, $mq$["Different heights used by actors, such as standing, sitting or lying","Volume settings","Different rehearsal days","Music genres"]$mq$, 0, $mq$Levels use height to show status, relationships or focus.$mq$, $mq$medium$mq$),
($mq$A director places a character on a high platform while the others sit on the floor. Which meaning is most likely?$mq$, $mq$["The character is lost","The character is hiding","The character is sleeping","The character has power over the others"]$mq$, 3, $mq$Height is commonly used to show high status.$mq$, $mq$medium$mq$),
($mq$An actor must perform a long speech in a big hall. The back row cannot hear the final words. What is the best fix?$mq$, $mq$["Whisper more","Speak faster","Breathe from the diaphragm and finish each sentence with energy","Turn away from the audience"]$mq$, 2, $mq$Breath support and strong endings help projection without shouting.$mq$, $mq$medium$mq$),
($mq$A scene shows someone sneaking through a house at night. Which combination suits the mood?$mq$, $mq$["Fast stamping and shouting","Slow, low movement, quiet voice and light steps","Bright lights and loud music only","Standing still and waving"]$mq$, 1, $mq$Slow, light, quiet choices suit stealth.$mq$, $mq$medium$mq$),
($mq$Two actors speak the same line, 'Come here'. One uses a low, slow tone; the other uses a high, quick tone. What changes?$mq$, $mq$["The meaning and mood of the line","The words of the script","The position of the stage","The type of theatre"]$mq$, 0, $mq$Vocal delivery changes how the same words are understood.$mq$, $mq$medium$mq$),
($mq$A choreographed ensemble repeats a mechanical walk and sharp turns while chanting a rhythm. What is the movement style most likely meant to show?$mq$, $mq$["A natural family dinner","A gentle lullaby","A forest at dawn","A controlled, factory-like or robotic group"]$mq$, 3, $mq$Repetitive, precise movement and chanting suggest control or machines.$mq$, $mq$hard$mq$),
($mq$In a scene, a character is lying but the director wants the audience to feel it before the other character does. How can voice and movement help?$mq$, $mq$["A perfectly steady posture and flat tone","Leaving the stage","A slightly too fast pace, a rise in pitch and shifting weight","Reading from the script"]$mq$, 2, $mq$Small signs of stress give the audience clues that the character is not truthful.$mq$, $mq$hard$mq$),
($mq$A student's group scene feels flat because everyone stays in a line facing the audience. Which change would most improve the stage picture?$mq$, $mq$["Add more lines","Use levels, groupings and angles to create focus","Speak faster","Remove the audience"]$mq$, 1, $mq$Varying levels, groupings and angles creates a more interesting focus.$mq$, $mq$hard$mq$),
($mq$An actor delivers: 'I will never forgive you.' The director asks for a quiet voice and a long pause before 'never'. What is the likely aim?$mq$, $mq$["To show controlled, cold anger","To show a joke","To show forgetfulness","To end the scene"]$mq$, 0, $mq$Quiet control plus a pause adds weight and menace.$mq$, $mq$hard$mq$),
($mq$The audience is seated on all four sides of the performance area. Which problem must the actors especially manage?$mq$, $mq$["Hiding from the audience","Using only upstage","Removing all movement","Making sure their faces and voices reach every side"]$mq$, 3, $mq$In the round, actors must keep moving so every side sees and hears them.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Space, Movement and Voice$mq$ and p.name = $mq$Elements of Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Downstage and upstage$mq$, $mq$Downstage is nearest the audience; upstage is furthest from them.$mq$),
($mq$Blocking$mq$, $mq$The planned movement and positioning of actors on stage.$mq$),
($mq$Levels$mq$, $mq$The use of different heights (standing, sitting, platforms) to show status or relationships.$mq$),
($mq$Focus$mq$, $mq$Where the audience's attention is directed, using position, movement, light or contrast.$mq$),
($mq$Projection$mq$, $mq$Making the voice reach the audience through breath support and clarity, without shouting.$mq$),
($mq$Pitch, pace, volume, tone$mq$, $mq$The main vocal elements: how high, how fast, how loud and the emotional colour of the voice.$mq$),
($mq$Pause$mq$, $mq$A deliberate silence that gives a line weight and builds tension.$mq$),
($mq$In the round$mq$, $mq$A staging layout where the audience surrounds the performance area on all sides.$mq$),
($mq$Physical theatre$mq$, $mq$Telling a story mainly through the body, using movement and gesture rather than only words.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Space, Movement and Voice$mq$ and p.name = $mq$Elements of Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Using the stage space
Every performance happens in a **performance space**. Understanding it lets you place actors so the audience sees and hears the story.
- **Downstage** is nearest the audience; **upstage** is furthest away. Stage left and stage right are from the actor's point of view, facing the audience.
- Common layouts are **proscenium arch** (audience in front), **thrust** (audience on three sides), **in the round** (audience all around), **traverse** (audience on two sides) and **promenade** (audience moves with the action).
- **Levels** use height: standing, sitting, kneeling or using platforms. Height often suggests status.
- **Groupings and distance**: a tight group suggests unity; a lone figure suggests isolation.
- **Focus** is where the audience looks. Centre stage, strong lines and contrast in level or movement direct focus.
- **Blocking** is the planned movement and positioning of actors.

## Movement
Movement tells the audience who a character is and how they feel.
- **Posture and gait**: how a character stands and walks.
- **Gesture and facial expression**: smaller actions that show thought and mood.
- **Pace and rhythm**: slow, steady movement may show calm or tiredness; sharp, quick movement may show anger or panic.
- **Stillness and freezes** can be as powerful as action.
- **Stylised movement**: repeated or exaggerated patterns, used in ensemble work to suggest machines, crowds or dreams.
- **Mime and physical theatre**: telling the story with the body, often with little or no speech.

## Voice
Your voice is an instrument. Vocal elements to remember are:
- **Volume**: how loud or quiet.
- **Pitch**: how high or low.
- **Pace**: how fast or slow.
- **Tone**: the emotional colour, such as warm, cold, sarcastic or tender.
- **Pause**: deliberate silence that gives words weight.
- **Accent and dialect**: where and who a character comes from.
- **Projection and clarity**: making the voice reach the back row through good breathing and clear consonants, not by shouting.
Practise breathing from the diaphragm, relaxing the jaw, and finishing each sentence with energy. Warm up before every rehearsal.

## Combining the elements
Strong performance joins voice, movement and space. If a character is nervous, you might use quick, small steps, a rising pitch and a position near the exit. If a character is in control, you might hold the centre, move slowly and speak in a low, steady voice. Same words can mean very different things depending on delivery.

## Common mistakes
- Turning your back to the audience without a reason.
- Mumbling or dropping the ends of lines.
- Staying in a straight line for a group scene.
- Using movement that has no meaning, such as fidgeting.

## How this is examined
In tasks you may be given a short scene or a staging problem and asked which choice best communicates a meaning, how to improve audibility or focus, or how to adapt a scene to a different performance space. You should justify choices using terms such as levels, pace, pitch and focus.

Exam tip: When asked to improve a scene, name the element, state your change and explain the effect on the audience.$mq$ from st;

-- Elements of Drama > Tension, Mood and Symbol
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Elements of Drama$mq$, 5, 1 from public.subjects s where s.slug = $mq$drama$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Tension, Mood and Symbol$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$drama$mq$ and p.grade = 5 and p.name = $mq$Elements of Drama$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Tension, Mood and Symbol$mq$ and p.name = $mq$Elements of Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does 'tension' mean in drama?$mq$, $mq$["A feeling of suspense or conflict that keeps the audience engaged","The tightness of a costume","A type of lighting stand","The title of a play"]$mq$, 0, $mq$Dramatic tension is the suspense, anxiety or conflict that holds the audience's attention.$mq$, $mq$easy$mq$),
($mq$What is 'mood'?$mq$, $mq$["The length of a play","The actor's salary","The name of a role","The feeling or atmosphere of a scene"]$mq$, 3, $mq$Mood is the atmosphere a scene creates for the audience.$mq$, $mq$easy$mq$),
($mq$A prop that stands for an idea, such as a cage for freedom lost, is called a what?$mq$, $mq$["Cue","Blackout","Symbol","Interval"]$mq$, 2, $mq$A symbol is an object, action or image that represents a larger idea.$mq$, $mq$easy$mq$),
($mq$Which sound would most easily build a tense mood?$mq$, $mq$["A bright, cheerful jingle","A slow, rising low drone","Loud applause","Birdsong"]$mq$, 1, $mq$Low, slow rising sounds create unease and suspense.$mq$, $mq$easy$mq$),
($mq$What is 'contrast' in drama?$mq$, $mq$["Using opposites, such as loud then silent, to create impact","Copying one scene twice","Using no props","Learning lines"]$mq$, 0, $mq$Contrast highlights differences between moments to create impact.$mq$, $mq$easy$mq$),
($mq$A scene begins with a laughing family. Suddenly the phone rings, everyone freezes and the lights dim. What has changed?$mq$, $mq$["The play ends","The costumes change","The audience leaves","The mood shifts to suspense"]$mq$, 3, $mq$Freeze, silence and dimming lights shift the mood from joy to suspense.$mq$, $mq$medium$mq$),
($mq$In a play, a character repeatedly polishes a silver watch their missing brother left behind. What is the watch most likely doing?$mq$, $mq$["Acting as a stage direction","Showing the time of day only","Acting as a symbol of memory and loss","Replacing the script"]$mq$, 2, $mq$A repeated, meaningful object can symbolise absent loved ones and grief.$mq$, $mq$medium$mq$),
($mq$A director wants to build tension before a reveal. Which technique helps most?$mq$, $mq$["Speed up every line","Slow the pace, use silence and focus the lighting on one actor","Add loud comic music","Bring everyone to the front"]$mq$, 1, $mq$Slowing pace and using silence and focus builds anticipation.$mq$, $mq$medium$mq$),
($mq$How can an actor create 'dramatic irony'?$mq$, $mq$["The audience knows something a character does not","The actor forgets lines","The set falls down","The lights go out"]$mq$, 0, $mq$Dramatic irony occurs when the audience has information that the character lacks.$mq$, $mq$medium$mq$),
($mq$A single red scarf appears in each scene of a devised play about a village. Each time something painful happens, someone touches it. What is the best interpretation?$mq$, $mq$["The scarf is just a costume mistake","The scarf is a lighting cue","The scarf shows the play is a comedy","The scarf symbolises shared suffering or memory"]$mq$, 3, $mq$Repeated use at painful moments gives the scarf symbolic meaning.$mq$, $mq$medium$mq$),
($mq$In a scene, two characters whisper while a ticking clock sound gets louder. What does the rising clock most likely add?$mq$, $mq$["Humour only","A change in place","Pressure and urgency","Silence"]$mq$, 2, $mq$A louder ticking increases a sense of time running out.$mq$, $mq$medium$mq$),
($mq$A play uses sudden bright light, a scream and then complete silence. Which mood is most likely being created?$mq$, $mq$["Boredom","Shock","Calm","Celebration"]$mq$, 1, $mq$Sudden light and sound followed by silence create shock.$mq$, $mq$medium$mq$),
($mq$Which is the best example of tension created through use of space?$mq$, $mq$["Two rivals circling the same table, never turning their backs","Everyone seated in rows","One actor leaving the stage","A character yawning"]$mq$, 0, $mq$Circling and refusing to turn away creates visible tension.$mq$, $mq$medium$mq$),
($mq$An ensemble repeats the same whispered phrase, getting faster and louder while moving closer to one character. What effect is intended?$mq$, $mq$["Relaxation","A comic punchline","A scene about sleeping","Growing pressure and a feeling of being trapped"]$mq$, 3, $mq$Repetition with escalating pace, volume and closeness traps and pressures the character.$mq$, $mq$hard$mq$),
($mq$A director must show a character's guilt without any dialogue. Which choice is the most subtle and symbolic?$mq$, $mq$["A narrator says 'He is guilty'","The character announces a confession","The character keeps washing their hands but can never feel clean","A sign reads GUILT"]$mq$, 2, $mq$A repeated symbolic action shows guilt without telling the audience directly.$mq$, $mq$hard$mq$),
($mq$A comedy scene suddenly includes slow music and a spotlight on one actor. What effect might this create?$mq$, $mq$["More laughter only","A moment of seriousness that contrasts with the humour","The end of the show","No effect"]$mq$, 1, $mq$A sudden change of lighting and music can create a poignant contrast within a comedy.$mq$, $mq$hard$mq$),
($mq$A student claims 'tension needs shouting'. Which response is the strongest?$mq$, $mq$["Tension can come from silence, stillness and pace as much as from volume","Tension always needs loud music","Tension needs no actors","Tension means long scenes"]$mq$, 0, $mq$Quiet, controlled moments can be very tense; volume is only one tool.$mq$, $mq$hard$mq$),
($mq$A group performs a play with a locked door that nobody opens, even when characters say they must leave. What might the door represent?$mq$, $mq$["The interval","The director","A prop mistake","A barrier or fear that stops the characters"]$mq$, 3, $mq$A door that stays closed can symbolise a barrier or fear.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Tension, Mood and Symbol$mq$ and p.name = $mq$Elements of Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Dramatic tension$mq$, $mq$The suspense or conflict that holds an audience's attention and makes them want to know what happens next.$mq$),
($mq$Mood / atmosphere$mq$, $mq$The overall feeling of a scene, created by lighting, sound, movement, voice and design.$mq$),
($mq$Symbol$mq$, $mq$An object, image, colour, sound or action that stands for a bigger idea.$mq$),
($mq$Contrast$mq$, $mq$Using opposites (loud and silent, light and dark, fast and slow) to create impact.$mq$),
($mq$Dramatic irony$mq$, $mq$When the audience knows something a character does not, creating suspense or humour.$mq$),
($mq$Silence and pause$mq$, $mq$Used to hold the audience's attention and raise tension before a line or event.$mq$),
($mq$Escalation$mq$, $mq$Gradually increasing pace, volume or intensity to build tension.$mq$),
($mq$Repeated motif$mq$, $mq$An action, phrase or object that appears again and again to build meaning.$mq$),
($mq$Building a calm mood$mq$, $mq$Soft warm light, slow movement and gentle music or quiet.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Tension, Mood and Symbol$mq$ and p.name = $mq$Elements of Drama$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Tension
**Tension** (or **dramatic tension**) is the feeling of suspense, worry or conflict that keeps an audience watching. Without tension, a scene can feel flat. Tension rises when the audience wants to know what will happen and fears or hopes for a certain outcome.

Ways to build tension:
- **Pace and rhythm**: slowing down before a surprise, or speeding up to create panic.
- **Silence and pauses**: holding a moment so the audience waits.
- **Conflict**: characters want opposite things.
- **Secrets and dramatic irony**: the audience knows something a character does not, so they watch with worry.
- **Use of space**: rivals circling a table, a character trapped near a door, or a figure standing too close.
- **Repetition and escalation**: repeating a phrase or action with growing volume, speed or closeness.
- **Time pressure**: a ticking clock, a deadline or a countdown.

## Mood and atmosphere
**Mood** (also called **atmosphere**) is the overall feeling of a scene, such as peaceful, eerie, joyful, threatening or sad. Mood is created by several elements working together:
- **Lighting**: soft warm light feels safe; cold, dim or flickering light feels uneasy.
- **Sound and music**: low drones suggest threat; light music suggests happiness; silence can be eerie.
- **Movement**: slow gliding movement may feel calm; jerky movement may feel anxious.
- **Voice**: whispering, hushed tones or loud shouting each create a different atmosphere.
- **Colour and costume**: dark colours can feel serious, bright colours playful.
A sudden change of mood is a powerful **contrast**. A cheerful scene that is interrupted by a phone ringing and a freeze feels shocking because of the change.

## Symbol
A **symbol** is an object, image, colour, sound or action that represents a larger idea. A cage may stand for lost freedom, a bridge for connection, a red scarf for memory or pain, a clock for time running out. A symbol works best when it:
- appears more than once, so the audience notices it;
- is linked to important moments or characters;
- is simple and clear, not overloaded.
Symbols can be physical (props), visual (colour and shape), aural (a repeated sound) or physical actions (a character repeatedly washing their hands).

## Putting it together
Imagine a scene where a daughter waits for news. The director dims the light, uses a low hum, slows the pace and has the mother repeatedly straighten the same photo frame. The frame is a symbol of trying to keep control; the slow pace and hum build tension; the lighting sets an anxious mood.

## Common mistakes
- Believing tension always means shouting.
- Using too many symbols so none are clear.
- Changing mood without a reason in the story.
- Explaining the symbol in the dialogue instead of letting the audience discover it.

## How this is examined
In tasks, you are often given a short scene and asked to select or justify choices that create a mood, build tension or use a symbol. Strong answers name the technique, describe exactly what the audience sees or hears and explain the effect.

Exam tip: Link every technique to an effect: 'The slow pace and silence build tension because the audience waits for the reveal.'$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('drama')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;