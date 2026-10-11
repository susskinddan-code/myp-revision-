-- Part 2 of 4: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Theatre in Context > Theatre History and Conventions
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Theatre in Context$mq$, 5, 2 from public.subjects s where s.slug = $mq$drama$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Theatre History and Conventions$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$drama$mq$ and p.grade = 5 and p.name = $mq$Theatre in Context$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Theatre History and Conventions$mq$ and p.name = $mq$Theatre in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$In which ancient civilisation did Western theatre and the tradition of tragedy and comedy begin?$mq$, $mq$["Ancient Greece","Ancient Egypt","Viking Scandinavia","Aztec Mexico"]$mq$, 0, $mq$Western theatre, including tragedy and comedy, developed in ancient Greece, linked to festivals for the god Dionysus.$mq$, $mq$easy$mq$),
($mq$What is a 'convention' in theatre?$mq$, $mq$["A fee paid to the theatre","A type of lighting fixture","A mistake in rehearsal","An accepted way of doing something that audience and performers understand"]$mq$, 3, $mq$A convention is an agreed technique, such as a narrator or a freeze frame, that the audience accepts.$mq$, $mq$easy$mq$),
($mq$What was the role of the Greek chorus?$mq$, $mq$["A single lead actor","The lighting crew","A group who commented on the action, often speaking and moving together","The audience"]$mq$, 2, $mq$The chorus spoke and moved as a group, commenting on events and the feelings of the community.$mq$, $mq$easy$mq$),
($mq$Which famous London theatre is linked to Shakespeare and opened in 1599?$mq$, $mq$["The Colosseum","The Globe","The Royal Albert Hall","Drury Lane"]$mq$, 1, $mq$The Globe opened in 1599 and was used by Shakespeare's company.$mq$, $mq$easy$mq$),
($mq$In medieval Europe, plays based on Bible stories were often called what?$mq$, $mq$["Mystery plays","Radio plays","Opera buffa","Puppet films"]$mq$, 0, $mq$Medieval mystery (and miracle) plays told religious stories, often performed by guilds.$mq$, $mq$easy$mq$),
($mq$Why were masks widely used in ancient Greek theatre?$mq$, $mq$["They hid actors from the audience for safety","They were required by law for all audiences","They provided lighting","They helped actors play several roles and made expressions visible in a large open-air space"]$mq$, 3, $mq$Masks let a few actors play many roles and made emotions clear to a huge audience.$mq$, $mq$medium$mq$),
($mq$In Shakespeare's time, who played the female roles on the public stage?$mq$, $mq$["Only famous women","Puppets only","Boys and young men","Children from the audience"]$mq$, 2, $mq$Women did not perform on the public stage in Elizabethan England, so boys and men played female parts.$mq$, $mq$medium$mq$),
($mq$What did the 'groundlings' do at the Globe Theatre?$mq$, $mq$["Sat in the best boxes","Stood in the open yard in front of the stage","Worked backstage","Acted the main roles"]$mq$, 1, $mq$Groundlings were audience members who paid little and stood in the yard.$mq$, $mq$medium$mq$),
($mq$In 1660, King Charles II was restored to the throne in England. What change followed for theatre?$mq$, $mq$["Women were allowed to act on the professional stage","All theatres were permanently closed","Masks became compulsory","Plays could only be silent"]$mq$, 0, $mq$After the Restoration, professional actresses appeared on English stages.$mq$, $mq$medium$mq$),
($mq$Japanese Noh theatre is known for which feature?$mq$, $mq$["Fast comic farce with no costumes","Realistic furniture and kitchen sets","Audience participation in every scene","Slow, stylised performance with masks and symbolic movement"]$mq$, 3, $mq$Noh uses masks, slow stylised movement, chanting and music, and developed from the 14th century.$mq$, $mq$medium$mq$),
($mq$A modern company stages a story with a narrator who tells the audience what happens, actors who speak directly to the crowd and a bare platform. Which tradition does this most resemble?$mq$, $mq$["A silent film","A television quiz","Ancient and medieval storytelling traditions using direct address","A cartoon"]$mq$, 2, $mq$Direct address, narrators and simple stages draw on old traditions of storytelling theatre.$mq$, $mq$medium$mq$),
($mq$A theatre company presents a Kabuki-inspired piece. Which feature would you expect?$mq$, $mq$["A single plain grey costume","Elaborate costume, make-up and stylised poses","Naturalistic domestic dialogue only","No music or movement"]$mq$, 1, $mq$Kabuki is famous for dramatic make-up, elaborate costumes, stylised poses and music.$mq$, $mq$medium$mq$),
($mq$Why do audiences accept that a bare stage with a chair can be a palace in a convention-based performance?$mq$, $mq$["They agree to imagine, as the convention asks","The chair is real royal furniture","They cannot see the stage","The text forbids interpretation"]$mq$, 0, $mq$The shared understanding that objects can symbolise other things is part of theatre convention.$mq$, $mq$medium$mq$),
($mq$A historian compares a Greek amphitheatre with a modern proscenium theatre. Which difference is most accurate?$mq$, $mq$["Greek theatres had electric lights; proscenium theatres do not","Greek theatres were tiny; modern theatres are huge","Greek theatres had no audience","Greek theatres were open-air and carved into hillsides, and proscenium theatres are usually indoors with a frame"]$mq$, 3, $mq$Greek amphitheatres were open-air, often built into hillsides; proscenium theatres are enclosed with a picture-frame arch.$mq$, $mq$hard$mq$),
($mq$Commedia dell'arte began in Italy in the 16th century. What is a key feature?$mq$, $mq$["Realistic prison sets","Long silent plays","Stock characters, masks and improvised comic routines","Only female actors"]$mq$, 2, $mq$Commedia used stock masked characters such as Arlecchino and improvised comic business called lazzi.$mq$, $mq$hard$mq$),
($mq$A designer wants a student production to feel like a 'Greek tragedy'. Which choice fits best?$mq$, $mq$["A realistic kitchen set with a ringing phone","A chorus speaking in unison on a raised platform with simple costumes","A pantomime cow and sing-along","A cartoon projection"]$mq$, 1, $mq$A speaking and moving chorus and a simple structure reflect Greek staging.$mq$, $mq$hard$mq$),
($mq$A student argues: 'Conventions are rules that can never be broken.' Which reply is strongest?$mq$, $mq$["Conventions are agreements that companies may follow, adapt or deliberately break for effect","Conventions are fixed by law","Conventions only apply in films","Conventions are invented by audiences each night"]$mq$, 0, $mq$Theatre makers often adapt or subvert conventions to create surprise or new meaning.$mq$, $mq$hard$mq$),
($mq$A group stages a play on the street with no curtain, mobile props and actors talking to passers-by. Which historical idea does this echo most?$mq$, $mq$["Indoor Victorian opera","Silent film studios","Radio broadcasting","Travelling performers and pageant-style outdoor theatre"]$mq$, 3, $mq$Open, mobile, public performance echoes medieval pageants and street entertainers.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Theatre History and Conventions$mq$ and p.name = $mq$Theatre in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Convention$mq$, $mq$An accepted technique that performers and audience understand, such as a narrator or a freeze frame.$mq$),
($mq$Greek chorus$mq$, $mq$A group who spoke and moved together, commenting on events and the feelings of the community.$mq$),
($mq$Amphitheatre$mq$, $mq$An open-air Greek theatre, often built into a hillside, seating thousands.$mq$),
($mq$Mystery play$mq$, $mq$A medieval play telling Bible stories, often performed by guilds on pageant wagons.$mq$),
($mq$The Globe$mq$, $mq$Shakespeare's theatre in London, opened in 1599, with a thrust stage and standing groundlings.$mq$),
($mq$Groundlings$mq$, $mq$Cheap-ticket audience members who stood in the yard in front of the Globe stage.$mq$),
($mq$Restoration (1660)$mq$, $mq$The return of the monarchy in England; theatres reopened and women began acting professionally.$mq$),
($mq$Proscenium arch$mq$, $mq$A frame around the stage that separates audience and performers like a picture frame.$mq$),
($mq$Noh and Kabuki$mq$, $mq$Japanese traditions: Noh is slow and masked; Kabuki is colourful with dramatic make-up and stylised poses.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Theatre History and Conventions$mq$ and p.name = $mq$Theatre in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why history matters
Knowing how theatre developed helps you understand why we stage plays the way we do today. At MYP level you do not need every date, but you should recognise the main periods, their key features and the idea of **conventions**.

## Conventions
A **convention** is an accepted way of doing something in theatre that both the performers and the audience understand. Examples are a narrator speaking to the audience, a freeze frame, a chair standing in for a throne, or a character stepping forward to speak their thoughts. Companies may follow conventions, adapt them or deliberately break them to surprise the audience.

## Ancient Greece
- Theatre began in ancient Greece, linked to festivals for the god Dionysus.
- Plays were **tragedies** and **comedies**, performed in large open-air theatres (often called **amphitheatres**) built into hillsides, such as the one at Epidaurus.
- A small number of male actors played all the roles using **masks**, which made emotions visible to a huge audience and let one actor play several characters.
- The **chorus** was a group who spoke and moved together, commenting on the action.
- Famous playwrights include Sophocles, Euripides and Aristophanes.

## Medieval theatre
- In medieval Europe, religious stories were staged as **mystery** and **miracle plays**, often by town guilds.
- Plays were frequently performed on **pageant wagons**, moveable carts, or in market squares, so the audience travelled or the stage did.
- Characters like devils and angels were easy to recognise from costume.

## Elizabethan theatre
- In England in the late 1500s, theatres like the **Globe** (opened 1599) had a **thrust stage** surrounded by galleries and a standing yard where the **groundlings** stood.
- There was little scenery, so language painted the setting. Speeches described time and place.
- Only men and boys performed on the public stage, so boys played women.

## The Restoration and later
- When the monarchy was restored in 1660, theatres reopened and women began to act professionally in England.
- Indoor theatres with **proscenium arches** (a picture frame around the stage), painted scenery and, later, gas and electric lighting became common.
- In the 1800s, **melodrama** (dramatic stories with clear heroes and villains and music) was popular. Modern theatre then moved towards realism and many experimental styles.

## Theatre outside Europe
- **Noh** (Japan, developed from the 1300s) uses slow stylised movement, masks, chanting and music.
- **Kabuki** (Japan, from the early 1600s) is famous for striking make-up, costumes, stylised poses and a walkway through the audience called the hanamichi.
- **Peking opera** (China) combines singing, speech, acrobatics and symbolic costume.
- **Commedia dell'arte** (Italy, 1500s) used stock masked characters and improvised comic routines called lazzi.

## Common mistakes
- Saying women acted in Shakespeare's theatre; they did not on the public stage.
- Mixing up the proscenium arch (a frame) with thrust (audience on three sides).
- Treating conventions as unbreakable rules.
- Forgetting that a convention only works because the audience agrees to accept it.

## How this is examined
Tasks may give a short description of a performance and ask which period or tradition it resembles, or how a historical practice could be used in a new devised piece. You may need to explain how a convention affects the audience's understanding.

Exam tip: Link a historical feature to a practical effect: 'The chorus spoke in unison, which showed the voice of the community and added rhythm.'$mq$ from st;

-- Theatre in Context > Dramatic Styles and Practitioners
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Theatre in Context$mq$, 5, 2 from public.subjects s where s.slug = $mq$drama$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Dramatic Styles and Practitioners$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$drama$mq$ and p.grade = 5 and p.name = $mq$Theatre in Context$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Dramatic Styles and Practitioners$mq$ and p.name = $mq$Theatre in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which practitioner is linked to the 'magic if' and naturalistic acting?$mq$, $mq$["Konstantin Stanislavski","Bertolt Brecht","Antonin Artaud","Augusto Boal"]$mq$, 0, $mq$Stanislavski developed a system for believable acting including the 'magic if'.$mq$, $mq$easy$mq$),
($mq$What is 'naturalism' in theatre?$mq$, $mq$["Using only masks","Performing without speech","Showing dreams in abstract shapes","Staging life as realistically as possible"]$mq$, 3, $mq$Naturalism tries to show everyday life believably on stage.$mq$, $mq$easy$mq$),
($mq$Which practitioner is linked to 'epic theatre' and the aim of making the audience think critically?$mq$, $mq$["Stanislavski","Shakespeare","Bertolt Brecht","Walt Disney"]$mq$, 2, $mq$Brecht created epic theatre to make audiences think about social issues, not just feel emotion.$mq$, $mq$easy$mq$),
($mq$Which practitioner created Forum Theatre?$mq$, $mq$["Stanislavski","Augusto Boal","Grotowski","Molière"]$mq$, 1, $mq$Boal created Forum Theatre in which audience members (spect-actors) step in to change the action.$mq$, $mq$easy$mq$),
($mq$What is 'physical theatre'?$mq$, $mq$["Theatre that tells the story mainly through body movement","Theatre only on radio","Theatre without actors","Theatre using only words"]$mq$, 0, $mq$Physical theatre uses bodies, movement and gesture as the main storytelling tool.$mq$, $mq$easy$mq$),
($mq$Which technique did Brecht use to remind the audience they were watching a play?$mq$, $mq$["Hiding the actors","Realistic kitchens","Silent film","Placards, narration and visible lights"]$mq$, 3, $mq$Brecht used placards, direct address, visible lighting and narration to distance the audience (the alienation effect).$mq$, $mq$medium$mq$),
($mq$Theatre of the Absurd, such as the plays of Samuel Beckett, often features what?$mq$, $mq$["Perfectly realistic detective stories","Only singing","Illogical situations and a sense of meaninglessness","Historical documentaries"]$mq$, 2, $mq$Absurd theatre uses strange, illogical situations to question meaning and communication.$mq$, $mq$medium$mq$),
($mq$Antonin Artaud's 'Theatre of Cruelty' aimed to do what?$mq$, $mq$["Make the audience laugh gently","Shock and overwhelm the senses of the audience","Copy everyday life","Teach grammar"]$mq$, 1, $mq$Artaud wanted intense sound, light and movement to jolt audiences out of complacency.$mq$, $mq$medium$mq$),
($mq$A group performs a story about a factory. Actors step out of role to read statistics aloud, then step back in. Which style does this resemble most?$mq$, $mq$["Brechtian epic theatre","Naturalism","Silent comedy","Opera"]$mq$, 0, $mq$Stepping out to inform the audience is a Brechtian technique.$mq$, $mq$medium$mq$),
($mq$A group asks the audience to suggest how a bullied character should respond and invites someone to replace the actor. Which practice is this?$mq$, $mq$["Melodrama","Noh","Pantomime","Forum Theatre"]$mq$, 3, $mq$Replacing the protagonist to try solutions is Forum Theatre.$mq$, $mq$medium$mq$),
($mq$Which description best fits Jerzy Grotowski's 'Poor Theatre'?$mq$, $mq$["Theatre with huge budgets and special effects","Theatre for television","Stripped-back theatre that relies on the actor's body and voice rather than elaborate sets","Theatre using no actors"]$mq$, 2, $mq$Poor Theatre removes costly extras to focus on the actor and audience.$mq$, $mq$medium$mq$),
($mq$A performer approaches a scene by asking 'What would I do if I were in this situation?' Which idea is this?$mq$, $mq$["Brecht's gestus","Stanislavski's 'magic if'","Boal's image theatre","Artaud's cruelty"]$mq$, 1, $mq$The 'magic if' asks the actor to imagine how they would behave in the character's circumstances.$mq$, $mq$medium$mq$),
($mq$In Brecht's theatre, what is 'gestus'?$mq$, $mq$["A gesture or movement that reveals a character's attitude or social position","The final bow","A stage lighting cue","A prop table"]$mq$, 0, $mq$Gestus is a physical expression that shows social attitude.$mq$, $mq$medium$mq$),
($mq$A company stages a play with a realistic living room set, believable dialogue and actors behaving as if the fourth wall exists. Which style is most likely?$mq$, $mq$["Epic theatre","Absurdism","Physical theatre","Naturalism"]$mq$, 3, $mq$A realistic room, believable speech and a fourth wall are naturalist features.$mq$, $mq$hard$mq$),
($mq$What does 'the fourth wall' mean?$mq$, $mq$["The back wall of the stage","The wall of the dressing room","The imaginary wall between actors and audience","The roof"]$mq$, 2, $mq$The fourth wall is the invisible barrier at the front of the stage in naturalism.$mq$, $mq$hard$mq$),
($mq$A director wants to use Brecht in a play about water pollution. Which choice is the best application?$mq$, $mq$["Hide the facts and show only a love story","Actors hold up signs with facts, address the audience directly and show how people are affected unfairly","Use an invisible fourth wall and realistic furniture only","Remove all speech"]$mq$, 1, $mq$Facts, direct address and a social focus match Brecht's aims.$mq$, $mq$hard$mq$),
($mq$A group chooses Absurdist ideas for a piece about waiting in a never-ending queue. Which choice fits best?$mq$, $mq$["Repeated, circular dialogue where nothing is resolved","A detective who solves the mystery","A realistic sad story about family","A musical with a happy ending"]$mq$, 0, $mq$Circular, repeated dialogue and no resolution are typical Absurdist features.$mq$, $mq$hard$mq$),
($mq$A student says Stanislavski and Brecht want the same effect. Which correction is most accurate?$mq$, $mq$["Both aim to hide the theatre","Brecht used the fourth wall; Stanislavski did not","Both avoided speech","Stanislavski aims for emotional truth; Brecht aims for critical thinking and distance"]$mq$, 3, $mq$Stanislavski encourages believability and emotional truth while Brecht wanted the audience to think and judge.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Dramatic Styles and Practitioners$mq$ and p.name = $mq$Theatre in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Stanislavski$mq$, $mq$Russian practitioner of naturalism and truthful acting: the 'magic if', objectives, given circumstances.$mq$),
($mq$Naturalism$mq$, $mq$A style that stages everyday life as realistically as possible, usually with a fourth wall.$mq$),
($mq$Brecht and epic theatre$mq$, $mq$Brecht used the alienation effect, narration, placards and gestus to make audiences think critically.$mq$),
($mq$Gestus$mq$, $mq$A physical gesture or action that shows a character's attitude or social position.$mq$),
($mq$Forum Theatre$mq$, $mq$Boal's method: audience spect-actors replace a character and try solutions to a problem.$mq$),
($mq$Theatre of the Absurd$mq$, $mq$Plays with illogical situations, circular dialogue and no resolution, e.g. Beckett.$mq$),
($mq$Artaud$mq$, $mq$French practitioner who proposed a Theatre of Cruelty to shock and overwhelm the senses.$mq$),
($mq$Grotowski$mq$, $mq$Polish practitioner of Poor Theatre: focus on actor and audience, little scenery.$mq$),
($mq$Physical theatre$mq$, $mq$Storytelling mainly through bodies, movement and ensemble work, as used by Frantic Assembly.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Dramatic Styles and Practitioners$mq$ and p.name = $mq$Theatre in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Styles and practitioners
A **dramatic style** is a distinctive way of making theatre, with its own aims and techniques. A **practitioner** is a theatre maker (an actor, director or writer) whose methods have influenced others. Knowing these ideas gives you tools to use in your own devising and to discuss in written work.

## Naturalism and Stanislavski
**Konstantin Stanislavski** (Russia, late 1800s to early 1900s) wanted believable, truthful acting. His ideas include:
- **The magic if**: asking 'What would I do if I were in this situation?'
- **Given circumstances**: the facts about the character's world (who, where, when).
- **Objectives and obstacles**: what the character wants and what stops them.
- **Emotion memory** and imagination to find real feeling.
**Naturalism** uses realistic sets, costumes and speech and often a **fourth wall**, the imaginary wall between actors and audience.

## Epic theatre and Brecht
**Bertolt Brecht** (Germany) created **epic theatre**. He wanted audiences to think about society and make changes, not just feel emotion. Techniques include:
- the **alienation effect** (Verfremdungseffekt), reminding the audience it is watching a play;
- **narration**, **direct address** and **placards**;
- visible lights and minimal sets;
- **gestus**, a gesture that shows attitude or social position;
- actors stepping out of role to comment.

## Theatre of Cruelty and Artaud
**Antonin Artaud** (France) wanted to shock the audience's senses with intense sound, lighting and movement, breaking the habit of just listening to a story.

## Poor Theatre and Grotowski
**Jerzy Grotowski** (Poland) stripped away elaborate sets and costumes, focusing on the actor's body, voice and close relationship with the audience.

## Theatre of the Absurd
Writers such as **Samuel Beckett** and **Eugène Ionesco** showed situations that seemed illogical or meaningless, with circular dialogue and no clear resolution. This often reflected a sense that life lacks clear meaning.

## Forum Theatre and Boal
**Augusto Boal** (Brazil) created **Theatre of the Oppressed**. In **Forum Theatre**, a short scene shows a problem. The audience, called **spect-actors**, can stop the scene, replace a character and try different solutions. The goal is to rehearse change in real life.

## Physical theatre
Companies such as **Frantic Assembly** and **Complicité** tell stories mainly through the body: movement, lifts, ensemble work and rhythm, often with minimal text.

## Other styles
- **Commedia dell'arte**: masks, stock characters and improvised comic routines.
- **Melodrama**: heroes, villains, exaggerated emotion.
- **Pantomime**: a British family tradition with comedy, song, audience participation.
- **Verbatim theatre**: scripts built from real interviews and documents.

## Common mistakes
- Mixing up Stanislavski (believable emotion) and Brecht (critical distance).
- Describing Forum Theatre as an audience watching in silence.
- Thinking Absurdist plays are random and have no meaning.
- Using a style label without giving a technique.

## How this is examined
Tasks usually describe a scene and ask which style or practitioner it uses, how a technique could be applied to a topic, or to justify why a style suits an audience and message.

Exam tip: Name the practitioner, the technique and the effect, for example: 'Placards give facts, which makes the audience think about the issue, as Brecht intended.'$mq$ from st;

-- Theatre in Context > Drama, Culture and Society
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Theatre in Context$mq$, 5, 2 from public.subjects s where s.slug = $mq$drama$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Drama, Culture and Society$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$drama$mq$ and p.grade = 5 and p.name = $mq$Theatre in Context$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Drama, Culture and Society$mq$ and p.name = $mq$Theatre in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Why do many communities use drama?$mq$, $mq$["To tell stories, share beliefs and explore issues","Only to sell tickets","Only to entertain tourists","Only to practise handwriting"]$mq$, 0, $mq$Drama is used to communicate stories, culture and social messages.$mq$, $mq$easy$mq$),
($mq$What is 'Theatre in Education' (TIE)?$mq$, $mq$["A school lesson with no performance","A building for teachers","A type of lighting","Drama performed to teach audiences about an issue"]$mq$, 3, $mq$TIE uses performance and participation to explore educational or social topics.$mq$, $mq$easy$mq$),
($mq$A play that raises awareness of a social problem such as homelessness is an example of what?$mq$, $mq$["Pure fantasy only","Silent comedy","Drama for social comment","Advertising only"]$mq$, 2, $mq$Drama can raise awareness and encourage reflection on social issues.$mq$, $mq$easy$mq$),
($mq$What does 'cultural context' mean?$mq$, $mq$["The theatre's seating","The social and cultural background in which a play is made or set","The ticket price","The costume size"]$mq$, 1, $mq$Cultural context is the background of beliefs, history and customs that shape a work.$mq$, $mq$easy$mq$),
($mq$Which of these is an example of storytelling theatre rooted in a community's heritage?$mq$, $mq$["A traditional dance-drama retelling a local legend","A cooking show","A sports match","A weather report"]$mq$, 0, $mq$Traditional dance-drama and storytelling carry cultural heritage.$mq$, $mq$easy$mq$),
($mq$A group wants to perform a story from a culture that is not their own. What is the most respectful first step?$mq$, $mq$["Copy a few costumes without asking","Make fun of customs","Ignore the source","Research it carefully and consult people from that culture"]$mq$, 3, $mq$Respectful practice means research, consultation and avoiding stereotypes.$mq$, $mq$medium$mq$),
($mq$A play uses real interviews with residents of a town about a flood, word for word. This style is called what?$mq$, $mq$["Absurdist theatre","Pantomime","Verbatim theatre","Mime"]$mq$, 2, $mq$Verbatim theatre builds scripts from real people's words.$mq$, $mq$medium$mq$),
($mq$Which is an example of applied drama?$mq$, $mq$["A Broadway musical","A workshop using role play to help students tackle bullying","A film premiere","A circus show"]$mq$, 1, $mq$Applied drama uses theatre techniques for a purpose beyond entertainment, such as education or discussion.$mq$, $mq$medium$mq$),
($mq$A playwright writes a drama about a family from another country moving to a new city. Which element most helps to portray cultural context?$mq$, $mq$["Customs, language, food and beliefs shown accurately","A random choice of accents","Exaggerated stereotypes","Only a title"]$mq$, 0, $mq$Authentic details help portray culture truthfully.$mq$, $mq$medium$mq$),
($mq$A school performs a piece about climate change using statistics, characters from different regions and audience discussion. Which purpose is strongest?$mq$, $mq$["Hiding facts","Making money only","Avoiding the topic","Raising awareness and encouraging action"]$mq$, 3, $mq$Combining facts, human stories and discussion engages the audience with a global issue.$mq$, $mq$medium$mq$),
($mq$A drama group wants to include Indigenous storytelling. Which approach shows the most respect?$mq$, $mq$["Using the story with no attribution","Changing it to suit the group's costume budget","Working with and crediting community members who hold the story","Mocking the language"]$mq$, 2, $mq$Respect means consultation, accuracy and credit.$mq$, $mq$medium$mq$),
($mq$A director sets Romeo and Juliet in a modern city with two rival gangs. What is this an example of?$mq$, $mq$["Copying exactly","Adapting a classic to a new context","A censorship act","A mime"]$mq$, 1, $mq$Updating setting while keeping the plot is a common adaptation.$mq$, $mq$medium$mq$),
($mq$Which practice is an example of community theatre?$mq$, $mq$["Local residents devising and performing a play about their neighbourhood","A famous actor touring alone","A film shoot","A broadcast news show"]$mq$, 0, $mq$Community theatre involves local people making work about their own lives.$mq$, $mq$medium$mq$),
($mq$A drama group wants to discuss a sensitive topic with Year 7 students. Which choice is the most responsible?$mq$, $mq$["Show the most graphic scenes","Avoid explaining the purpose","Force students to participate in role","Give a content warning, use age-appropriate material and include a supportive discussion"]$mq$, 3, $mq$Care for the audience and participants is part of ethical practice.$mq$, $mq$hard$mq$),
($mq$A play set in the 1930s includes outdated attitudes held by some characters. A director wants to avoid endorsing them. Which strategy works best?$mq$, $mq$["Remove all other characters","Make the attitudes seem admirable","Present the attitudes critically, using other characters or staging to challenge them","Leave the context unexplained"]$mq$, 2, $mq$Framing and staging can show harmful attitudes as part of history without endorsing them.$mq$, $mq$hard$mq$),
($mq$A student says that a play from another culture 'makes no sense'. What is the best first response?$mq$, $mq$["Dismiss it","Research the cultural conventions, such as symbolism and form, that shape its meaning","Change the ending","Remove the music"]$mq$, 1, $mq$Understanding cultural conventions helps interpret unfamiliar work.$mq$, $mq$hard$mq$),
($mq$A drama group has to choose between presenting a minority culture as a set of stereotypes or presenting several different individual characters. Which choice avoids a harmful single story?$mq$, $mq$["Presenting varied, individual characters","Using only the most exaggerated image","Using one character to represent everyone","Avoiding any characters"]$mq$, 0, $mq$Varied individual characters resist stereotypes and show the complexity of people.$mq$, $mq$hard$mq$),
($mq$After a performance on food waste, a teacher asks how the drama changed students' habits. What type of evaluation is this?$mq$, $mq$["Counting seats","Checking lighting","Marking spelling","Evaluating the impact on the audience"]$mq$, 3, $mq$Impact on audience attitudes and actions is an important measure of applied drama.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Drama, Culture and Society$mq$ and p.name = $mq$Theatre in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Cultural context$mq$, $mq$The beliefs, customs, history and values that shape a work of drama.$mq$),
($mq$Applied drama$mq$, $mq$Using theatre techniques for a purpose beyond entertainment, such as teaching or discussing issues.$mq$),
($mq$Theatre in Education (TIE)$mq$, $mq$A company performs and involves students to explore a topic or issue.$mq$),
($mq$Verbatim theatre$mq$, $mq$Scripts built from the exact words of real people, e.g. interviews.$mq$),
($mq$Community theatre$mq$, $mq$Local people making and performing a play about their own community.$mq$),
($mq$Censorship$mq$, $mq$Authorities controlling or banning what can be performed or said.$mq$),
($mq$Adaptation$mq$, $mq$Changing the setting, time or language of an existing play for a new audience.$mq$),
($mq$Stereotype$mq$, $mq$An oversimplified image of a group; good drama shows varied individuals.$mq$),
($mq$Respectful practice$mq$, $mq$Research, consult people from the culture, give credit and avoid decoration without understanding.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Drama, Culture and Society$mq$ and p.name = $mq$Theatre in Context$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Drama and the world around us
Drama has always been part of human life. People use performance to **tell stories**, **share beliefs**, **celebrate festivals**, **teach**, **remember history** and **challenge injustice**. Understanding the **context** of a piece, who made it, when and why, helps you interpret and create work responsibly.

## Cultural context
**Cultural context** means the beliefs, customs, history and values that shape a work of drama. For example, a traditional dance-drama may retell a local legend, with movement, costume and music that carry meaning for that community. When you study or perform work from a culture, ask:
- Who made it and for whom?
- What traditions, symbols and conventions does it use?
- What did it mean to its first audience?
- How can we present it respectfully?

## Social, political and moral issues
Many plays respond to issues such as poverty, prejudice, war, the environment or migration. A play can raise **awareness**, encourage **empathy**, challenge **stereotypes** and ask audiences to **take action**. Styles such as **verbatim theatre**, which uses real people's words from interviews, and **documentary theatre** give strong evidence.

## Applied drama
**Applied drama** uses theatre techniques for a purpose beyond pure entertainment.
- **Theatre in Education (TIE)**: a company performs and involves students to explore a topic.
- **Community theatre**: local people make a play about their own community.
- **Forum Theatre**: the audience tries out solutions to a problem.
- **Drama therapy and role play** to practise real-life choices in a safe space.
Evaluate impact by asking whether the audience learned, changed their view or took action.

## Adaptation and updating
Directors often **adapt** classic plays by changing the setting, language or time so they speak to a new audience. Setting Romeo and Juliet among rival gangs in a modern city keeps the plot but changes context.

## Censorship
**Censorship** is when authorities control or ban what can be performed. Throughout history, plays have been banned for criticising rulers or challenging beliefs. Discussing censorship helps students think about freedom of expression and its limits.

## Ethical practice
- **Respect**: research and consult people from the culture before you stage their story; give credit.
- **Avoid stereotypes**: show varied individuals, not one exaggerated image of a group.
- **Care for the audience and performers**: age-appropriate content, warnings where needed and supportive discussion afterwards.
- **Context for difficult attitudes**: present them critically rather than endorsing them.

## Common mistakes
- Saying drama is only entertainment.
- Using costumes or sacred symbols from a culture as decoration without understanding.
- Choosing a serious issue but offering no point of view or audience engagement.
- Forgetting to evaluate the impact on the audience.

## How this is examined
In ePortfolio style tasks you may research a cultural or social context, explain how it influenced a piece of drama, and justify choices that treat sensitive topics respectfully. MCQs often give a project scenario and ask for the most respectful or most effective choice.

Exam tip: Link context to choices: 'Because the story comes from this community, we consulted community members and credited them.'$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('drama')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;