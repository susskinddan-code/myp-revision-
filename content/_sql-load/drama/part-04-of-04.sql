-- Part 4 of 4: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Production Skills > Lighting, Sound and Staging
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Production Skills$mq$, 5, 4 from public.subjects s where s.slug = $mq$drama$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Lighting, Sound and Staging$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$drama$mq$ and p.grade = 5 and p.name = $mq$Production Skills$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Lighting, Sound and Staging$mq$ and p.name = $mq$Production Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a spotlight?$mq$, $mq$["A lamp that makes a narrow, bright beam to light one actor or area","A recorded sound effect","A type of curtain","The area behind the stage"]$mq$, 0, $mq$Spotlights focus the audience's attention.$mq$, $mq$easy$mq$),
($mq$What is a blackout?$mq$, $mq$["A slow sunrise effect","A costume change","A type of prop","All stage lights switched off at once"]$mq$, 3, $mq$A blackout is often used to end a scene or show.$mq$, $mq$easy$mq$),
($mq$What is a sound effect?$mq$, $mq$["A type of lantern","A script direction","A recorded or live noise, such as thunder or a door slam, that adds to the scene","A seating plan"]$mq$, 2, $mq$Sound effects help create place, time and mood.$mq$, $mq$easy$mq$),
($mq$In a proscenium arch theatre, where is the audience?$mq$, $mq$["On all four sides","In front of the stage, looking through a frame","On three sides","On the stage"]$mq$, 1, $mq$A proscenium stage has the audience on one side, viewing through the arch.$mq$, $mq$easy$mq$),
($mq$What are the wings?$mq$, $mq$["The areas at the sides of the stage hidden from the audience","The seats at the back","The lighting desk","The ticket office"]$mq$, 0, $mq$Actors wait and enter from the wings.$mq$, $mq$easy$mq$),
($mq$A cold blue wash covers the stage during a lonely scene. What effect is most likely intended?$mq$, $mq$["A hot summer day","A party","A sunrise celebration","A cold, sad or night-time mood"]$mq$, 3, $mq$Cool colours often suggest cold, calm, night or sadness, though meaning depends on context.$mq$, $mq$medium$mq$),
($mq$What is a thrust stage?$mq$, $mq$["A stage with no audience","A stage with the audience in a full circle","A stage that projects into the audience, who sit on three sides","A stage only used outdoors"]$mq$, 2, $mq$A thrust stage brings actors closer to the audience.$mq$, $mq$medium$mq$),
($mq$A play is staged in the round. What must actors remember?$mq$, $mq$["Stay against one wall","Everyone can see them from all sides, so they should avoid blocking one section with their backs for long","Only face the front","Speak only to the technician"]$mq$, 1, $mq$In the round, no side is 'the front', so movement and facing must be shared.$mq$, $mq$medium$mq$),
($mq$What is a cue sheet?$mq$, $mq$["A list of lighting and sound cues, with numbers, positions and timings","A list of audience names","A costume plan","A set of bricks"]$mq$, 0, $mq$Cue sheets help technicians operate the show accurately.$mq$, $mq$medium$mq$),
($mq$A recorded rainstorm plays under a conversation. What should be true of the volume?$mq$, $mq$["It should be louder than the actors","It should switch off at random","It should be the same as a fire alarm","It should stay quieter than the voices so the lines can be heard"]$mq$, 3, $mq$Underscore sound supports speech; it must not drown it.$mq$, $mq$medium$mq$),
($mq$An actor is told to move 'downstage centre'. Where does she go?$mq$, $mq$["Away from the audience, at the side","Off the stage","Towards the audience, in the middle","Into the wings"]$mq$, 2, $mq$Downstage is the area nearest the audience; centre is the middle.$mq$, $mq$medium$mq$),
($mq$An actor stands in front of a bright light behind them so only their outline can be seen. What is this effect called and what might it suggest?$mq$, $mq$["A spotlight; celebration","A silhouette; mystery or hidden identity","A blackout; the end of the play","A gobo; comedy"]$mq$, 1, $mq$Silhouettes hide detail and can suggest mystery, threat or anonymity.$mq$, $mq$medium$mq$),
($mq$Before rehearsal, a technician tapes cables to the floor and checks the ladder. What is this an example of?$mq$, $mq$["Risk management for safety","Costume design","Improvisation","Applause"]$mq$, 0, $mq$Safety checks reduce the chance of accidents.$mq$, $mq$medium$mq$),
($mq$A scene shows dawn after a frightening night. Which lighting plan best shows hope returning?$mq$, $mq$["Cut instantly to full white","Stay in blackout","Flash red repeatedly","Fade slowly from dark blue to warm amber over about 20 seconds"]$mq$, 3, $mq$A slow shift from cold to warm shows time passing and an emotional change.$mq$, $mq$hard$mq$),
($mq$A scene lasts 200 seconds. A storm track must start 45 seconds in and finish 15 seconds before the final line. How long must the track be?$mq$, $mq$["155 seconds","185 seconds","140 seconds","200 seconds"]$mq$, 2, $mq$200 − 45 − 15 = 140 seconds.$mq$, $mq$hard$mq$),
($mq$In a small studio with a low ceiling and a tiny budget, which staging choice is most sensible?$mq$, $mq$["Hang a huge heavy set from the ceiling","Use simple lighting states, a few flexible items and careful actor placement","Use fireworks","Buy complex moving lights"]$mq$, 1, $mq$Good design fits space and budget and still supports the intention.$mq$, $mq$hard$mq$),
($mq$Footsteps are heard approaching the door well before the character enters. What is the most likely effect?$mq$, $mq$["It builds anticipation and tension","It makes the scene shorter","It tells the audience the scene is over","It hides the dialogue"]$mq$, 0, $mq$Sound before action creates suspense and uses off-stage space.$mq$, $mq$hard$mq$),
($mq$In end-on staging, a key action on the floor at the front is hidden from the back rows. What is the best solution?$mq$, $mq$["Ask the back rows to stand","Ignore it","Shout the line louder","Raise the action onto a platform or move it where all can see"]$mq$, 3, $mq$Sightlines must be checked so important action can be seen by everyone.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Lighting, Sound and Staging$mq$ and p.name = $mq$Production Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Spotlight$mq$, $mq$A lamp giving a narrow, bright beam to focus the audience on one actor or area.$mq$),
($mq$Wash$mq$, $mq$An even area of coloured or white light over the stage.$mq$),
($mq$Blackout$mq$, $mq$All lights off at once, often used to end a scene.$mq$),
($mq$Silhouette$mq$, $mq$An outline made by lighting an actor from behind; hides detail and can suggest mystery.$mq$),
($mq$Underscore$mq$, $mq$Quiet music or sound under dialogue to support the mood without covering the lines.$mq$),
($mq$Cue sheet$mq$, $mq$A list of lighting and sound cues with numbers, triggers and timings, used by technicians.$mq$),
($mq$Proscenium, thrust, in the round$mq$, $mq$Audience on one side through a frame; on three sides; on all sides.$mq$),
($mq$Upstage and downstage$mq$, $mq$Upstage is away from the audience; downstage is towards the audience (actor's view facing the audience).$mq$),
($mq$Sightline$mq$, $mq$The line of sight from an audience seat to the action. It must be checked so key action is visible.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Lighting, Sound and Staging$mq$ and p.name = $mq$Production Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Lighting, sound and staging are the technical and spatial tools that shape what an audience sees and hears. They support the director's intention and often show a world, mood or time. In MYP Drama, understanding these tools supports Criterion A: Knowing and understanding, and choosing them wisely supports Criterion C. Each criterion is reported in Levels 1-8.

## Lighting
Lighting does four main jobs: it **illuminates** so the audience can see, it **focuses** attention, it **creates mood and time**, and it can **suggest place**.
- **Colour**: cool blues often suggest night, cold or sadness; warm ambers suggest comfort, sunlight or danger, depending on context.
- **Intensity**: bright light feels open or harsh; dim light feels secretive or sad.
- **Direction**: light from above, below or behind changes how a face looks. Backlighting can create a **silhouette**, hiding detail and suggesting mystery.
- **Spotlight**: a narrow beam on one person or area. **Wash**: an even area of colour. **Blackout**: all lights off at once.
- **Fade**: slowly increasing or decreasing light. A slow fade from dark blue to warm amber over about 20 seconds can show dawn and hope after a frightening night.

## Sound
- **Live sound** is made in the space, such as a drum or voices.
- **Recorded sound** includes sound effects, music and **underscore** (quiet sound under dialogue).
- Sound can set place (traffic, birds), time (a clock) and mood (a low hum). Sound heard before an entrance, such as footsteps approaching a door, builds anticipation.
- Keep volume under speech so lines can be heard.
- **Timing sums** help technicians: if a scene lasts 200 seconds and a storm must start 45 seconds in and end 15 seconds before the last line, the track needs to be 200 − 45 − 15 = 140 seconds.

## Stage types and areas
- **Proscenium arch**: audience on one side, looking through a frame.
- **End-on**: audience at one end of a room.
- **Thrust**: audience on three sides.
- **In the round**: audience on all sides, so actors must share their facing.
- **Traverse**: audience on two sides facing each other.
Stage areas are named from the actor's point of view facing the audience: **upstage** is away from the audience, **downstage** is towards them, with **stage left** and **stage right** being the actor's left and right. The **wings** are the sides hidden from view.

## Planning and safety
A **cue sheet** lists each lighting and sound cue with a number, the line or action that triggers it and its timing. Always do **risk assessment**: tape down cables, avoid trailing wires, check ladders and keep exits clear. Check **sightlines**: if key action happens on the floor at the front, back rows may not see it, so raise it or move it.

## Matching tools to intention
Ask: what does the audience need to feel at this moment? Then choose the simplest tool that does it. A small studio with a tiny budget can still create atmosphere with a few lighting states, careful actor placement and carefully chosen sounds.

## Common mistakes
- Using sound so loud that lines are lost.
- Choosing a colour without a reason.
- Forgetting sightlines and safety.
- Describing equipment without explaining its effect.

## How this is examined
Tasks may give a short description of a scene and ask which lighting, sound or staging choice would best achieve a stated mood, or ask you to explain the effect of a cue or evaluate a plan against a budget or space. Command terms such as suggest, explain and justify decide the depth.

Exam tip: for every technical choice, name the tool, the effect and the audience response, such as "A slow amber fade shows hope returning".$mq$ from st;

-- Production Skills > Costume, Set and Props
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Production Skills$mq$, 5, 4 from public.subjects s where s.slug = $mq$drama$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Costume, Set and Props$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$drama$mq$ and p.grade = 5 and p.name = $mq$Production Skills$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Costume, Set and Props$mq$ and p.name = $mq$Production Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is costume in drama?$mq$, $mq$["Clothing and accessories worn by actors to help show character","The sound plan","The seating","The script's title"]$mq$, 0, $mq$Costume helps show age, status, period, personality and place.$mq$, $mq$easy$mq$),
($mq$What is a prop?$mq$, $mq$["A type of light","A theatre seat","A rehearsal schedule","A portable object used or carried by actors"]$mq$, 3, $mq$Props are items such as a letter, umbrella or phone that actors handle.$mq$, $mq$easy$mq$),
($mq$What is a set?$mq$, $mq$["The performers' names","The ticket price","The scenery and furniture that create the setting","The warm-up"]$mq$, 2, $mq$The set shows or suggests where the action happens.$mq$, $mq$easy$mq$),
($mq$Which of these is a hand prop?$mq$, $mq$["A painted backdrop","A key that a character hides in a pocket","A lighting stand","A stage curtain"]$mq$, 1, $mq$A hand prop is carried or used by an actor.$mq$, $mq$easy$mq$),
($mq$Why might an actor wear make-up in a performance?$mq$, $mq$["To show age, injury or character, or to be seen under stage lights","To change the lighting","To write the script","To sell tickets"]$mq$, 0, $mq$Make-up supports character and helps expressions read under lights.$mq$, $mq$easy$mq$),
($mq$In a play, every character wears grey except one in red. What is the most likely meaning?$mq$, $mq$["The designer ran out of grey","The red character is invisible","All characters are the same","The character in red stands out as different or an outsider"]$mq$, 3, $mq$Colour contrast can be a symbolic way to separate a character from the group.$mq$, $mq$medium$mq$),
($mq$What is a minimalist set?$mq$, $mq$["A set with hundreds of objects","A set made only of lights","A few carefully chosen items that suggest the place, using the audience's imagination","A set that moves around the stage"]$mq$, 2, $mq$Minimalist design uses little to suggest much.$mq$, $mq$medium$mq$),
($mq$Which item is set dressing rather than a hand prop?$mq$, $mq$["A suitcase the actor carries","A framed picture hanging on the wall","A pen the character writes with","A phone answered on stage"]$mq$, 1, $mq$Set dressing decorates the space but is not handled by actors.$mq$, $mq$medium$mq$),
($mq$A designer limits the colours in the set and costume to blue, grey and white. What is the main aim?$mq$, $mq$["To unify the look and create a particular mood","To hide the actors","To increase the volume","To shorten the play"]$mq$, 0, $mq$A restricted palette makes a consistent visual world.$mq$, $mq$medium$mq$),
($mq$A group uses wooden crates as a bench, a table and a door in different scenes. What is the main advantage?$mq$, $mq$["They make the actors taller","They remove the need for lighting","They stop the audience clapping","They are flexible, cheap and make quick scene changes possible"]$mq$, 3, $mq$Multi-purpose items save money and time.$mq$, $mq$medium$mq$),
($mq$An actor must run and kneel in a scene. What should the costume designer consider?$mq$, $mq$["That it is as tight as possible","That it must be heavy","That the costume allows free, safe movement","That it should trail on the floor"]$mq$, 2, $mq$Costumes must support the action and be safe.$mq$, $mq$medium$mq$),
($mq$A glass is half full of water at the start of the scene and must look the same after a scene change. Which skill is needed?$mq$, $mq$["Projection","Continuity","Improvisation","Blocking"]$mq$, 1, $mq$Continuity means keeping props and costumes consistent throughout.$mq$, $mq$medium$mq$),
($mq$What is a design concept?$mq$, $mq$["An overall idea that links costume, set, props and other design choices to the intention","A seating plan","A rehearsal timetable","A reminder to applaud"]$mq$, 0, $mq$A design concept gives a unified vision.$mq$, $mq$medium$mq$),
($mq$A group stages a play in a refugee waiting room on a small budget. Which design best suggests a temporary, uncertain place?$mq$, $mq$["A luxury sofa and gold curtains","A brand-new kitchen set","A sunny garden","Mismatched chairs, worn bags and a muted palette"]$mq$, 3, $mq$Mismatched, worn items and muted colours suggest a place people pass through.$mq$, $mq$hard$mq$),
($mq$An actor needs to change costume in 15 seconds between scenes. Which solution is best?$mq$, $mq$["Use many small buttons","Sew the costume on her","Use layers and quick fastenings, and plan the change in advance","Add a heavy coat"]$mq$, 2, $mq$Quick-change costumes are designed with simple fastenings and rehearsed changes.$mq$, $mq$hard$mq$),
($mq$A budget is £120. Fabric is 14 metres at £4.50 per metre; props cost £28.75; paint costs £19.40. How much money is left?$mq$, $mq$["£11.15","£8.85","£63.00","£111.15"]$mq$, 1, $mq$Fabric: 14 × 4.50 = £63.00. Total = 63.00 + 28.75 + 19.40 = £111.15. Left: 120 − 111.15 = £8.85.$mq$, $mq$hard$mq$),
($mq$A cracked mirror prop appears in several scenes and is finally repaired. What is the most likely function of this symbol?$mq$, $mq$["To represent a character's damaged sense of self and recovery","To tell the audience when to clap","To show the time of day","To make the stage safer"]$mq$, 0, $mq$A recurring object with a changing state can symbolise change in a character.$mq$, $mq$hard$mq$),
($mq$A scene needs lit candles. What is the safest choice for a school stage?$mq$, $mq$["Real candles near curtains","Matches held by actors","A small fire on the floor","Battery-powered LED candles"]$mq$, 3, $mq$LED candles give the effect without the fire risk; safety comes first.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Costume, Set and Props$mq$ and p.name = $mq$Production Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Costume$mq$, $mq$Clothing and accessories worn by actors to show age, status, time, place and personality.$mq$),
($mq$Prop$mq$, $mq$A portable object used by actors, such as a key or letter.$mq$),
($mq$Hand prop vs set dressing$mq$, $mq$A hand prop is carried or used by actors; set dressing decorates the space and is not handled.$mq$),
($mq$Minimalist set$mq$, $mq$A few carefully chosen items that suggest a place and rely on the audience's imagination.$mq$),
($mq$Multi-purpose set item$mq$, $mq$An item used in several ways, such as a crate acting as bench, table or door; flexible and cheap.$mq$),
($mq$Design concept$mq$, $mq$One overall idea that unites costume, set, props and other choices around the intention.$mq$),
($mq$Colour symbolism$mq$, $mq$Using colour to carry meaning, such as one red costume among grey ones to show an outsider.$mq$),
($mq$Continuity$mq$, $mq$Keeping props, costumes and set consistent from scene to scene.$mq$),
($mq$Safe design choices$mq$, $mq$Free movement in costume, stable sets, clear exits and LED candles instead of real flames.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Costume, Set and Props$mq$ and p.name = $mq$Production Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Costume, set and props form the visual world of a performance. They tell the audience who people are, where and when the action takes place, and what the piece is about. In MYP Drama, understanding design supports Criterion A: Knowing and understanding, and making considered design choices supports Criterion C: Thinking creatively. Each criterion is reported in Levels 1-8.

## Costume
Costume includes clothes, shoes, hats, accessories and sometimes make-up and hair. It can show:
- **age, job and status** (a crisp uniform or ragged coat)
- **time and place** (period clothing or modern streetwear)
- **personality** (bright and bold or neat and plain)
- **relationships** (matching colours for a group, one different colour for an outsider)
Always consider **practicality**: can the actor move, run and kneel safely? For fast changes, use layers, simple fastenings and a planned changing area. In an ensemble where everyone wears grey except one person in red, the red costume uses colour symbolism to mark that person as different.

## Set
The **set** includes scenery, furniture and structures that create the setting. It may be:
- **realistic**: detailed and lifelike.
- **minimalist or suggestive**: a few items such as a chair and a window frame, relying on the audience's imagination.
- **symbolic**: shapes or colours that represent ideas, such as a barrier made of tangled string.
- **multi-purpose**: crates used as a bench, table or door, which is flexible and cheap and makes scene changes quick.
Design must respect **sightlines** (everyone can see) and **safety** (stable, secure and clear exits).

## Props
**Props** are portable objects. A **hand prop** is carried by an actor, such as a key or a letter. **Set dressing** is decoration actors do not handle, such as pictures on a wall. Props can be symbolic: a cracked mirror that appears in many scenes and is eventually repaired can represent a character's damaged confidence and recovery. Props need **continuity**: if a glass is half full at the start of a scene, it must be the same after any scene change.

## Design concept and colour
A **design concept** is the single idea that unites everything. A limited palette, for example blue, grey and white, builds a consistent mood. For a play set in a waiting room for people who have just arrived in a new country, mismatched chairs, worn bags and muted colours suggest a temporary, uncertain place.

## Budget and planning
Real productions are limited by money, time and space. Plan costs: for example, with £120, 14 metres of fabric at £4.50 per metre costs £63.00; adding £28.75 of props and £19.40 of paint gives £111.15, leaving £8.85. Recycle, borrow and reuse where possible. Always do a risk assessment: LED candles instead of real flames, flame-retardant fabrics where required, and secure scenery.

## Common mistakes
- Choosing items because they look good, with no link to the intention.
- Forgetting actors must move comfortably.
- Using too many objects, which can clutter the stage.
- Not noting continuity.

## How this is examined
Typical tasks present a short description of a play and ask you to recommend design choices, explain what a costume or prop suggests, or evaluate a plan for budget and safety. Command terms such as describe, explain and justify decide the level of detail.

Exam tip: name the design choice, say what it communicates, and tie it to the intention, such as "Mismatched chairs suggest a temporary place".$mq$ from st;

-- Production Skills > Performing and Evaluating
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Production Skills$mq$, 5, 4 from public.subjects s where s.slug = $mq$drama$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Performing and Evaluating$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$drama$mq$ and p.grade = 5 and p.name = $mq$Production Skills$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Performing and Evaluating$mq$ and p.name = $mq$Production Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is projection?$mq$, $mq$["Speaking so the audience can hear clearly without shouting","Whispering as quietly as possible","Looking at the floor","Moving offstage"]$mq$, 0, $mq$Projection uses breath support and clarity to reach the back of the room.$mq$, $mq$easy$mq$),
($mq$What does 'evaluate' mean in a response about a performance?$mq$, $mq$["Copy the script","List the cast only","Draw the set","Judge how well something worked, using evidence"]$mq$, 3, $mq$Evaluating means making a reasoned judgement supported by examples.$mq$, $mq$easy$mq$),
($mq$What is articulation?$mq$, $mq$["Moving fast","Changing costume","Pronouncing words clearly","Changing the set"]$mq$, 2, $mq$Clear articulation helps the audience follow the words.$mq$, $mq$easy$mq$),
($mq$What does it mean to stay in role?$mq$, $mq$["To read the script aloud","To keep playing the character, even when something unexpected happens","To leave the stage","To speak to the audience as yourself"]$mq$, 1, $mq$Staying in role protects the illusion and the group's work.$mq$, $mq$easy$mq$),
($mq$What is audience feedback?$mq$, $mq$["Comments from the audience about the performance","The lights","The costume plan","The seating"]$mq$, 0, $mq$Audience feedback is one source of evidence for evaluating.$mq$, $mq$easy$mq$),
($mq$Which of these is the strongest evaluation?$mq$, $mq$["Only a plot summary","Only a list of lines","'It was good.'","Strengths, weaknesses, specific evidence and a suggested improvement"]$mq$, 3, $mq$Good evaluations are balanced and evidence-based, and look forward.$mq$, $mq$medium$mq$),
($mq$Which sentence is the most evidence-based?$mq$, $mq$["'I liked my voice.'","'We did the scene.'","'The slow, quiet delivery of \"Stay\" made the room go still; next time I would pair it with a step towards her.'","'It was funny and nice.'"]$mq$, 2, $mq$It names a choice, the audience effect and an improvement.$mq$, $mq$medium$mq$),
($mq$An actor drops a prop mid-scene. What is the best thing to do?$mq$, $mq$["Stop and apologise to the audience","Stay in role and adapt, using the moment if possible","Walk off","Stare at the technicians"]$mq$, 1, $mq$Professional performers keep going and adjust.$mq$, $mq$medium$mq$),
($mq$Which MYP Arts criterion is mainly about reflecting on and evaluating your own and others' drama?$mq$, $mq$["Criterion D: Responding","Criterion A: Knowing and understanding","Criterion B: Developing skills","Criterion C: Thinking creatively"]$mq$, 0, $mq$Criterion D covers responding to and evaluating art. Each criterion is reported in Levels 1-8.$mq$, $mq$medium$mq$),
($mq$An actor rushes lines when nervous. What is the best fix?$mq$, $mq$["Speak faster","Look away","Stop breathing deeply","Slow breathing, deliberate pauses and rehearsing the lines with a steady pace"]$mq$, 3, $mq$Controlled breath and planned pauses steady the pace.$mq$, $mq$medium$mq$),
($mq$Why is watching a video of your performance useful?$mq$, $mq$["It replaces rehearsal","It removes nerves","It lets you notice habits such as fidgeting or unclear speech","It changes the script"]$mq$, 2, $mq$A recording gives objective evidence of your work.$mq$, $mq$medium$mq$),
($mq$In 'two stars and a wish' feedback, what is the 'wish'?$mq$, $mq$["A prop","A suggestion for improvement","A costume","A compliment"]$mq$, 1, $mq$Two stars are strengths; the wish is what to improve.$mq$, $mq$medium$mq$),
($mq$In an ensemble scene, what does 'upstaging' a speaker mean and why is it a problem?$mq$, $mq$["Drawing attention away from the speaker, which damages the focus of the scene","Standing downstage, which is always helpful","Speaking louder, which is always helpful","Walking offstage for a prop"]$mq$, 0, $mq$Good ensemble members support the focus instead of pulling attention away.$mq$, $mq$medium$mq$),
($mq$An audience survey of 25 people shows 18 understood the ending. What percentage did not understand, and what is a sensible response?$mq$, $mq$["72%; do nothing","18%; remove the ending","50%; change the title","28%; review how the ending is clarified and test again"]$mq$, 3, $mq$25 − 18 = 7; 7 ÷ 25 = 28%. A sizeable minority were unsure, so adjust and retest.$mq$, $mq$hard$mq$),
($mq$Which statement is evaluation rather than description?$mq$, $mq$["'She sat down and the lights faded.'","'There were two characters.'","'The silence before her answer built tension because the audience expected an outburst.'","'The scene was in a kitchen.'"]$mq$, 2, $mq$Evaluation judges effect and gives reasons; description only says what happened.$mq$, $mq$hard$mq$),
($mq$The target length is 10 minutes. The performance lasted 11 minutes 40 seconds. By how many seconds did it run over?$mq$, $mq$["40 seconds","100 seconds","80 seconds","160 seconds"]$mq$, 1, $mq$11 min 40 s = 700 s; 700 − 600 = 100 s.$mq$, $mq$hard$mq$),
($mq$An actor lost lines in a performance because they only learned them silently. Which improvement plan is best?$mq$, $mq$["Run lines aloud with a partner each day, using cue lines, and record progress","Hope it improves","Learn fewer lines","Stop rehearsing"]$mq$, 0, $mq$A specific, repeatable plan with measurement targets the real problem.$mq$, $mq$hard$mq$),
($mq$A performer evaluates how a slow lighting fade and a whispered final line worked together. What makes this a strong analysis?$mq$, $mq$["It lists the lights separately","It only describes the lines","It ignores the audience","It explains how two choices combine to create one audience effect"]$mq$, 3, $mq$Analysis links different elements and shows their combined impact on the audience.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Performing and Evaluating$mq$ and p.name = $mq$Production Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Projection$mq$, $mq$Speaking so the audience can hear you clearly without shouting; supported by breath.$mq$),
($mq$Articulation$mq$, $mq$Pronouncing words clearly so the audience can follow every line.$mq$),
($mq$Staying in role$mq$, $mq$Keeping the character going even when something unexpected happens, such as a dropped prop.$mq$),
($mq$Upstaging$mq$, $mq$Drawing attention away from the speaker, which weakens the focus of the scene.$mq$),
($mq$Describe vs evaluate$mq$, $mq$Describe says what happened; evaluate judges how well it worked, using evidence.$mq$),
($mq$Four parts of a strong evaluation$mq$, $mq$Intention, strengths with evidence, honest weaknesses, and specific improvements.$mq$),
($mq$Two stars and a wish$mq$, $mq$Peer feedback: two strengths and one suggestion for improvement.$mq$),
($mq$Sources of evidence for evaluation$mq$, $mq$Video recordings, audience feedback or surveys, peer comments and your own rehearsal journal.$mq$),
($mq$Which MYP Arts criterion covers evaluating?$mq$, $mq$Criterion D: Responding, reported in Levels 1-8. Use Point, Evidence, Effect, Improvement.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$drama$mq$ and t.grade = 5 and t.name = $mq$Performing and Evaluating$mq$ and p.name = $mq$Production Skills$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Performing is where all the work of devising, scripting and rehearsal meets an audience. Evaluating is how you learn from it. In MYP Drama, performance connects to Criterion B: Developing skills, and evaluation sits in Criterion D: Responding. Each criterion is reported in Levels 1-8.

## Performance skills
- **Voice**: projection (being heard without shouting), articulation (clear words), pace, pitch, tone and pause. Breathing from the diaphragm supports all of these.
- **Body**: posture, gesture, facial expression, eye contact and use of space. Small, truthful choices often work better than exaggerated ones.
- **Focus and concentration**: staying in role even when something unexpected happens, such as a dropped prop.
- **Ensemble skills**: listening, reacting, supporting the speaker and not upstaging. Upstaging means pulling attention away from the focus of the scene.
- **Controlling nerves**: warm up, breathe slowly, plan pauses and trust your rehearsal.

If you rush lines when nervous, slow your breathing and mark deliberate pauses in your script.

## Performance conditions
Performing well also means respecting time and space. If the target length is 10 minutes and a run takes 11 minutes 40 seconds, that is 100 seconds over, because 700 − 600 = 100. Edit or tighten pace rather than rushing.

## Evaluating
To **describe** is to say what happened. To **evaluate** is to judge how well it worked, using evidence. A strong evaluation:
1. states the intention.
2. identifies strengths with examples and links them to audience effect.
3. identifies weaknesses honestly.
4. suggests specific improvements.
For example: "The slow, quiet delivery of 'Stay' made the room go still. Next time I would pair it with a step towards her to show the character's choice."

## Sources of evidence
- **Video recordings**: help you notice habits such as fidgeting or unclear speech.
- **Audience feedback**: comments or surveys. If 18 of 25 people understood the ending, then 7 did not, which is 28%, so you may adjust the ending and test again.
- **Peer feedback**, such as "two stars and a wish" (two strengths and one suggestion).
- **Your own journal** from rehearsals.
Be careful: a small survey may not represent everyone, so compare it with other evidence.

## Responding to others' work
You can also evaluate professional or peer performances. Identify the intention, describe key choices, explain their effect and judge their success. Link elements: how lighting, voice and movement worked together to build one effect.

## Improvement plans
A useful plan is specific, measurable and time-bound: "Run lines aloud with a partner each day for a week, using cue lines, and record how many I miss." Vague plans such as "try harder" are weak.

## Common mistakes
- Retelling the plot rather than judging the performance.
- Writing only positives, or only negatives.
- Giving opinions without evidence.
- Forgetting to suggest improvements.

## How this is examined
Tasks may give a short performance description, comments or survey data and ask you to identify the strongest evaluation, calculate a percentage, suggest improvements or justify a judgement. Command terms such as describe, evaluate and justify decide the depth.

Exam tip: use the pattern Point, Evidence, Effect, Improvement: what you did, what it looked or sounded like, how the audience reacted and what you would change.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('drama')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;