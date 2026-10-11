begin;
-- English Language and Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks) (80 marks)
with sub as (select id from public.subjects where slug = $mq$english-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$English Language and Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$English Language and Literature MYP 5 eAssessment Structure Mock A (7 tasks, 80 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1.1 | A 2]]
Task 1: Analysing
Questions 1.1 to 1.4 focus on the key concept of communication. Question 1.5 focuses on the key concept of connections. The criteria assessed are A (Analysing) and B (Organizing). Suggested time for Questions 1.1 to 1.4: 15 minutes. Suggested time for Question 1.5: 35 minutes.

Text A: 'The Spice Tin' (an extract from a short story, written for this paper)
This extract describes Rania, a girl who has recently arrived in England, on the evening a parcel from her mother reaches her.

The tin arrived in the second week of November, wrapped in a jumper that smelled of someone else's house. Rania carried it up the stairs of the flat as if it might spill, though the lid was sealed with tape, and set it on the windowsill beside the radiator, where the cold glass of an English evening pressed against it.

On the lid her mother had written in Arabic, in the looping hand that had once signed every one of Rania's school reports: for the soup that cures things. Rania did not open it. She knew what she would find: cumin, coriander, the dark crumbs of dried lime, all ground by her grandmother's wrists in a kitchen in a city that no airline flew to any more.

Downstairs, the neighbours' television laughed at something. Somebody was frying onions, but they were the wrong onions. The smell was too thin, too polite.

At school she had been Rania for two months, which is to say she had been Ray-nee-a, then Rainy, then, whenever Mr Whitfield took the register, a brief and hopeful silence while he searched the page for how she was supposed to sound. She had stopped correcting him. Correcting took energy she needed for the other work: the daily labour of arranging her face into a person who was fine.

On the phone her mother said, "You are eating? You are speaking English all day?" and Rania said yes to both, because yes was the shortest road to the end of the call.

Now she lifted the tin and held it against her chest. It weighed almost nothing. It weighed everything. When she finally prised off the tape and the lid, the smell rose like a hand laid on the back of her neck, and for a moment the radiator, the rain, the wrong onions, all of it went quiet.

She said her own name aloud, slowly, the way her grandmother used to, with the rolled r that English had no room for. Rania. Rania. It sounded like a door she had not realised was still unlocked.

Text B: webpage for 'Suitcase Stories', a community exhibition (written for this paper; in the live exam this would be a screen image)

[Layout: A wide banner photograph fills the top of the page. An open brown leather suitcase rests on a bare wooden floor. It holds no clothes. Instead it is crammed with small objects: a dented kettle, a school photograph, a paper bag of seeds, a football scarf and a child's red shoe. The light falls softly from the left. Across a deep teal band beneath the photograph, in large white capitals, are the words:]

WHAT WOULD YOU CARRY?

[Subheading in white italics:] Twenty-six people. Twenty-six suitcases. One city that is still learning to call itself home.

[The page divides into two columns below a thin gold line.]

[Left column, heading in teal capitals:] THE EXHIBITION
Every object here has crossed a border. Some arrived in a pocket, some in the back of a lorry, some only in the memory of a person who had to leave the real thing behind. For six weeks they sit under glass at Eastfield Library, beside the words of the people who carried them. Come and listen.

[A small photograph sits beneath this text: an elderly man holding a chipped enamel cup in both hands and looking just past the camera. Caption in grey italics:] Tomasz, 74, carried this cup from Gdansk in 1981. "It is worth nothing. That is why it is worth everything."

[Right column, heading in teal capitals:] JOIN IN
- Bring one object and tell us its story (open table, every Saturday, 2 p.m.)
- Record a message in your first language for our listening wall
- Help us translate the labels into twenty languages

[A bright yellow button, centred below both columns, reads:] ADD YOUR STORY

[A pull quote in large serif type is set between two thin lines across the full width of the page:] "Home is not only where you come from. It is what you refuse to leave behind."

[Footer in small grey type:] Free entry. Step-free access. 14 March to 30 April. A project of Eastfield Library and the Eastfield Welcome Network.

Q 1.1 Comment on the use of the senses in the first two paragraphs of Text A. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a sense or sensory detail with a reference to the text but does not explain its effect, e.g. 'a jumper that smelled of someone else's house' appeals to smell. [1] Level 2 (2 marks): comments on the use of the senses with an example and some explanation, e.g. smell ('someone else's house'), touch ('the cold glass of an English evening pressed against it') and sight ('the looping hand') build a sense of Rania's loneliness in an unfamiliar place and make the parcel feel precious as a link with her mother. [1] Accept any valid sense and effect (hearing is not yet used in these paragraphs). Award 0 for no or incorrect reference to the text.$mq$, $mq$A$mq$),
(2, $mq$[[Q 1.2 | A 3]]
Refer to Text A (printed in Question 1.1). Explain the effect of the lines: 'Somebody was frying onions, but they were the wrong onions. The smell was too thin, too polite.' (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies an effect without developing it, e.g. the lines show that Rania misses her home. [1] Level 2 (2 marks): describes an effect with some example or explanation, e.g. the repeated 'wrong onions' shows that even ordinary smells are foreign to her, so she feels she does not belong. [1] Level 3 (3 marks): explains the effect consistently with well-chosen quotation, e.g. the personification of the smell as 'too polite' suggests the new country is courteous but distant and cold, contrasted with the warmth of the spices; the short, flat sentence rhythm after the longer sentence echoes her sense of disappointment and isolation. [1] Accept any valid reading supported by the text.$mq$, $mq$A$mq$),
(3, $mq$[[Q 1.3 | A 2]]
Refer to Text B (printed in Question 1.1). Describe the purpose of the question 'WHAT WOULD YOU CARRY?' in the banner. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a purpose without explanation, e.g. it makes the reader think. [1] Level 2 (2 marks): describes the purpose with an example or explanation, e.g. the direct question addresses the reader personally and invites them to imagine being forced to leave home, so that they feel empathy before reading about the exhibition; the large capitals on teal make it the first thing the eye sees and catch attention. [1] Accept: to engage and involve the audience; to introduce the theme of what matters most.$mq$, $mq$A$mq$),
(4, $mq$[[Q 1.4 | A 3]]
Refer to Text B (printed in Question 1.1). Analyse the effect of a technique used in Text B. (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies a technique and an effect with no development, e.g. there is a photograph of a suitcase. [1] Level 2 (2 marks): describes the effect of one technique with some justification, e.g. the suitcase holds everyday objects such as a kettle and a child's shoe, which makes the migrants' lives seem familiar and human to the reader. [1] Level 3 (3 marks): analyses the effect consistently with a precise example, e.g. the caption quotation 'It is worth nothing. That is why it is worth everything.' uses paradox and a personal voice to show that value is emotional, not financial, and the contrast with the gentle grey caption text makes the old man's words stand out; or the imperative button 'ADD YOUR STORY' turns the audience from observers into participants. [1] Accept any valid technique: layout, colour, imagery, list structure, repetition of 'Twenty-six', pull quote, direct address.$mq$, $mq$A$mq$),
(5, $mq$[[Q 1.5 | A 10 | B 10]]
Refer to Text A and Text B (printed in Question 1.1). Compare and contrast how the concept of identity is explored in the two texts. (Approximately 350 words) (20 marks)

Criterion A (Analysing) is worth 10 marks and Criterion B (Organizing) is worth 10 marks.$mq$, $mq$Total 20 marks: Criterion A (10) and Criterion B (10). Criterion A Analysing (10 marks). 0: no work that meets a descriptor. 1-2 (limited): identifies some content, language, structure or technique with few or no examples; little sense of how the texts relate. 3-4 (adequate): describes some features of the texts with some examples; a degree of understanding of how features create meaning; some awareness of similarity or difference. 5-6 (considerable): explains the effect of a range of features with relevant examples from both texts; clear understanding of how meaning is created; sound awareness of similarities and differences. 7-8 (substantial): analyses the effect of content, language, structure and technique in both texts with well-chosen evidence; thoughtful understanding of the writers' and creators' choices and of the relationship between the texts. 9-10 (excellent): perceptive, sustained analysis of both texts with precise, well-integrated evidence; insightful evaluation of how and why meaning is shaped, and a discerning view of the relationship between the texts. Indicative content for A (not exhaustive; credit any valid, evidenced point). Text A: identity under pressure; the mispronounced name (Ray-nee-a, Rainy) and the 'person who was fine' show a self that is diminished and masked; the tin, the smell and the grandmother's pronunciation carry identity across distance; third-person limited narration and the final door metaphor create a private, quiet moment of reclaiming the self; imagery of senses and sentence rhythm. Text B: identity as shared, collective and public; objects and stories are displayed so that identity is recorded, respected and celebrated; the use of numbers ('Twenty-six'), the direct address of the question, the caption voice of Tomasz, the pull quote and the invitation to participate; the multimodal layout moves the audience from empathy to action. Similarities: both use ordinary objects (tin, cup, suitcase) as symbols of belonging; both link identity to memory, language and home; both ask the audience to value what has been left behind. Differences: private, painful and unresolved in Text A versus public, hopeful and communal in Text B; fiction showing one voice versus an informative and persuasive text showing many; narrative interiority versus direct address. Award up to [10] for Criterion A. Criterion B Organizing (10 marks). 0: no work that meets a descriptor. 1-2 (limited): little structure; the texts are mostly treated separately or in a list; ideas are hard to follow; little or no concluding thought. 3-4 (adequate): some structure with an opening and a close; both texts are discussed with a few links; some paragraphing and a degree of coherence. 5-6 (considerable): a clear structure; comparison and contrast appear in most paragraphs; ideas are generally logical and linked; an appropriate conclusion. 7-8 (substantial): an effective, purposeful structure; comparison and contrast are woven through the response; transitions are controlled and ideas build; a developed conclusion. 9-10 (excellent): a sophisticated, fully controlled structure that shapes the argument; comparison and contrast are integrated throughout; seamless linking; a conclusion that synthesizes the argument. Look for a comparative structure (for example by idea or by technique), topic sentences that name both texts, comparative connectives (whereas, similarly, in contrast) and a conclusion. Award up to [10] for Criterion B.$mq$, $mq$A$mq$),
(6, $mq$[[Q 2 | C 10 | D 10]]
Task 2: Producing literary text
This task focuses on the key concept of creativity. The criteria assessed are C (Producing text) and D (Using language). Suggested time: 35 minutes.

Image 1 (described in words): a single battered suitcase stands alone on a deserted railway platform at dusk. The last carriage of a train, its windows lit orange, is pulling away into the distance. A yellow lamp flickers overhead and rain gleams on the platform.
Image 2 (described in words): the inside of a kitchen window, steamed up on a winter morning. Someone has drawn a small heart in the condensation and, beside it, pressed a child's handprint, through which the street outside is blurred into grey and gold.

Using one of the images, write the opening of a story about a character who must leave something behind, or who returns to something they have left behind. You may consider purpose, characterisation, setting, mood and point of view. State which image you are using before you start. (Approximately 350 words) (20 marks)$mq$, $mq$Total 20 marks: Criterion C (10) and Criterion D (10). Criterion C Producing text (10 marks). 0: no work that meets a descriptor. 1-2 (limited): limited creative choices; little imagination or insight; little detail; the image or prompt is hardly used. 3-4 (adequate): some creative choices; some imagination and insight; some relevant detail; the image and prompt are used in a basic way. 5-6 (considerable): thoughtful creative choices of content, character, setting and point of view; considerable imagination and insight; sufficient relevant detail. 7-8 (substantial): purposeful, imaginative choices; a developed voice and perspective; substantial insight; well-chosen detail that supports a clear purpose. 9-10 (excellent): highly original, perceptive choices; an assured, distinctive voice and perspective; extensive, precise detail and a controlled narrative or poetic shape that fully serves the prompt. A response that uses neither image and does not address the prompt scores 0 for Criterion C. Indicative content: the named image is clearly used as a starting point; a character with a believable reason to leave or return; a controlled setting and mood (for example transience, nostalgia, uncertainty); sensory detail; a deliberate point of view; an opening that creates curiosity. Credit narrative, descriptive or poetic forms if they work as an opening. Award up to [10] for Criterion C. Criterion D Using language (10 marks). 0: no work that meets a descriptor. 1-2 (limited): limited range of vocabulary and structures; errors are frequent and often hinder communication; register is rarely appropriate. 3-4 (adequate): adequate range; a degree of accuracy; errors sometimes hinder communication; register is sometimes appropriate. 5-6 (considerable): a varied range of vocabulary, sentence structures and devices; considerable accuracy; errors do not hinder communication; register and style are generally appropriate. 7-8 (substantial): an effective range used with control; high accuracy with occasional slips; register and style are consistently appropriate and purposeful. 9-10 (excellent): a sophisticated, flexible range used with precision and flair; highly accurate with only minor errors; register and style are skilfully sustained throughout. Look for varied sentence length, precise verbs and imagery, effective control of tense, and accurate punctuation of dialogue where used. Award up to [10] for Criterion D.$mq$, $mq$C$mq$),
(7, $mq$[[Q 3 | B 10 | C 10 | D 10]]
Task 3: Producing non-literary text
This task focuses on the key concept of perspective. You will create a piece of non-literary writing in relation to the global context orientation in space and time: migration and the movement of people. The criteria assessed are B (Organizing), C (Producing text) and D (Using language). Suggested time: 50 minutes.

Write a feature article for your school magazine under the title 'Between Two Places' about what it means to belong to more than one place or culture, and what a welcoming school community can do to help newcomers feel they belong. Use a clear structure and the conventions of a feature article, such as a headline, an engaging opening, a balance of personal voice and evidence, and a closing thought. (Approximately 350 words) (30 marks)$mq$, $mq$Total 30 marks: Criterion B (10), Criterion C (10) and Criterion D (10). Criterion B Organizing (10 marks). 0: no work that meets a descriptor. 1-2 (limited): little organisation; few or no text-type conventions; ideas not sequenced; paragraphing absent or random. 3-4 (adequate): some organisation; some conventions of the text type are used; a basic opening and ending; paragraphing is mostly logical. 5-6 (considerable): a clear structure; most conventions of the text type are used appropriately; ideas are generally sequenced and linked. 7-8 (substantial): an effective structure; conventions of the text type used purposefully; clear progression with controlled links and an effective opening and close. 9-10 (excellent): a skilfully crafted structure; conventions of the text type exploited for effect; seamless progression, with every paragraph contributing to the purpose and audience. Indicative content: headline and possible standfirst; a hook (an anecdote, a striking image or a question); developed paragraphs on belonging and identity; examples drawn from school life, language, food, friendship or traditions; a quotation or interview, real or imagined; a balanced call to action; a closing line that links back to the opening. Award up to [10] for Criterion B. Criterion C Producing text (10 marks). 0: no work that meets a descriptor. 1-2 (limited): little insight into the global context or topic; little relevant detail; limited sense of audience and purpose. 3-4 (adequate): some insight into the global context; some relevant detail and examples; some awareness of audience and purpose. 5-6 (considerable): considerable insight into the global context and the topic; sufficient relevant detail and examples; a clear perspective and a good sense of audience and purpose. 7-8 (substantial): substantial, well-developed insight; well-chosen examples that support the argument; an assured perspective and a controlled appeal to the audience. 9-10 (excellent): perceptive, original insight into the global context; extensive, precise detail and examples; a distinctive, convincing perspective that fully serves the audience and purpose. Indicative content: insight into migration as both loss and gain; the experience of newcomers and of those who welcome them; specific, plausible suggestions such as buddy systems, language clubs, shared meals and a curriculum that reflects many histories; awareness that identity can be plural. Award up to [10] for Criterion C. Criterion D Using language (10 marks). 0: no work that meets a descriptor. 1-2 (limited): limited range of vocabulary and structures; errors are frequent and often hinder communication; register is rarely appropriate. 3-4 (adequate): adequate range; a degree of accuracy; errors sometimes hinder communication; register is sometimes appropriate. 5-6 (considerable): a varied range of vocabulary, sentence structures and devices; considerable accuracy; errors do not hinder communication; register and style are generally appropriate. 7-8 (substantial): an effective range used with control; high accuracy with occasional slips; register and style are consistently appropriate and purposeful. 9-10 (excellent): a sophisticated, flexible range used with precision and flair; highly accurate with only minor errors; register and style are skilfully sustained throughout. Look for an engaging journalistic register that is semi-formal, rhetorical devices used purposefully (rule of three, anecdote, inclusive pronouns, rhetorical question), and accurate grammar, spelling and punctuation. Award up to [10] for Criterion D.$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- English Language and Literature MYP 5 eAssessment Structure Mock B (7 tasks, 80 marks) (80 marks)
with sub as (select id from public.subjects where slug = $mq$english-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$English Language and Literature MYP 5 eAssessment Structure Mock B (7 tasks, 80 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$English Language and Literature MYP 5 eAssessment Structure Mock B (7 tasks, 80 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1.1 | A 2]]
Task 1: Analysing
Questions 1.1 to 1.4 focus on the key concept of communication. Question 1.5 focuses on the key concept of connections. The criteria assessed are A (Analysing) and B (Organizing). Suggested time for Questions 1.1 to 1.4: 15 minutes. Suggested time for Question 1.5: 35 minutes.

Text A: 'Night Mode' (an extract from a short story, written for this paper)
This extract describes Kofi, a fifteen-year-old, awake in his bedroom in the early hours of a school night.

At 1.17 a.m. the phone lit Kofi's face from below, which made him look, he thought, like someone telling a ghost story to himself. He was not asleep. He had stopped pretending to be around midnight, when the tenth video in a row about a stranger's perfect morning had slid into the eleventh without his thumb ever deciding anything.

The screen gave nothing back. That was its gift and its crime. It never grew tired, never said enough, never looked at him with the particular patience of his father at the kitchen table. It simply refreshed, and a new face appeared, laughing at a joke he had missed.

Somewhere below his window a bin lorry groaned, and the ordinary noise startled him: a real thing, made by real people on a real night shift. He looked up. His bedroom had been there all along: the poster peeling at one corner, the chemistry homework glowing faintly white on the desk like a small accusation, the dark square of the window.

The phone buzzed in his hand.

Mara: you up?

Three words. He typed an answer, deleted it, typed another. Every version looked like a boy pretending not to care. In the end he did what he always did. He sent a thumbs-up, a small yellow hand lifted in the dark, and the conversation ended where it had begun.

Mara had been his best friend since they were seven. Mara lived four streets away. They sat in the same row in registration, and in six weeks neither had said a sentence to the other that was longer than a reaction.

He lay back. The ceiling had a crack in it shaped like a river. For a second he imagined pulling on his trainers, walking the four streets, and throwing a pebble at her window. Four streets was nothing. It had somehow become the longest distance he knew.

He turned the phone face down on the duvet. The room did not collapse. The light drained from his hands, and the darkness came up around him, soft and enormous and slightly frightening, like the deep end when you first let go of the side.

Text B: poster for 'The Look Up Challenge' (written for this paper; in the live exam this would be an image)

[Layout: a tall poster with a dark navy background. The top two-thirds is a photograph of a crowded bus stop at dusk. Six people stand in a row and every head is bowed over a glowing phone, their faces lit a pale, ghostly blue. The whole photograph is in muted blue-grey, with one exception. At the far right edge a small girl in a yellow raincoat looks straight out at the viewer, and in her hand is a bright red paper kite.]

[Across the middle of the poster, in huge white capitals:] WHO ARE YOU MISSING?

[Beneath it, in smaller gold type:] Our survey of 2,000 teenagers found that most check their phones more than eighty times a day. How many times did you look up?

[Centred body text in white, in short lines, with generous space between them:]
Your friends are not in your pocket.
They are at the next bus stop.
The next table.
The next street.

[A row of three small white icons, each with a one-word caption underneath: a phone lying face down, "PARK IT"; two speech bubbles, "SAY IT"; a sunrise over a hill, "GO OUTSIDE".]

Seven days. One rule. When you are with people, phones go face down.

[Across the bottom, a bright red band with white capitals:] START MONDAY. TELL THREE FRIENDS. #LOOKUP

[Small print in the bottom corner:] A project of the Greenfield Youth Trust. Join in at lookupchallenge.example. No apps. No downloads. Just people.

Q 1.1 Comment on the use of light in the first two paragraphs of Text A. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a use of light with a reference to the text but does not explain its effect, e.g. the phone 'lit Kofi's face from below'. [1] Level 2 (2 marks): comments on the use of light with an example and some explanation, e.g. the cold glow of the phone from below, compared to a ghost-story teller, makes Kofi seem eerie and cut off, and suggests the screen is the only source of life in his night; the screen 'gave nothing back' as light without warmth. [1] Accept any valid effect, for example isolation, unreality or the unnatural hour. Award 0 for no or incorrect reference to the text.$mq$, $mq$A$mq$),
(2, $mq$[[Q 1.2 | A 3]]
Refer to Text A (printed in Question 1.1). Explain the effect of the lines: 'Four streets was nothing. It had somehow become the longest distance he knew.' (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies an effect without developing it, e.g. it shows Kofi is far from his friend. [1] Level 2 (2 marks): describes an effect with some example or explanation, e.g. the contrast between 'nothing' and 'the longest distance' shows that physical closeness has been replaced by emotional distance. [1] Level 3 (3 marks): explains the effect consistently with well-chosen quotation, e.g. the very short first sentence mirrors how easy the walk would be, then the longer second sentence with the reflective 'somehow' conveys Kofi's confusion and sadness; the paradox implies that constant digital contact has made real contact harder, so the reader feels the loss of the friendship. [1] Accept any valid reading supported by the text.$mq$, $mq$A$mq$),
(3, $mq$[[Q 1.3 | A 2]]
Refer to Text B (printed in Question 1.1). Describe the purpose of the colour in the photograph. (2 marks)$mq$, $mq$Criterion A, 2 marks. Level 1 (1 mark): identifies a purpose without explanation, e.g. the colours make the people look dull. [1] Level 2 (2 marks): describes the purpose with an example or explanation, e.g. the muted blue-grey of the phone users makes them look cold and lifeless, while the bright red kite and the yellow raincoat of the girl draw the eye and suggest that real life, play and connection are vivid and are found by looking up. [1] Accept: to contrast absorption in screens with the energy of the real world; to focus on the girl as the model of behaviour.$mq$, $mq$A$mq$),
(4, $mq$[[Q 1.4 | A 3]]
Refer to Text B (printed in Question 1.1). Analyse the effect of a technique used in Text B. (3 marks)$mq$, $mq$Criterion A, 3 marks. Level 1 (1 mark): identifies a technique and an effect with no development, e.g. the poster uses a question as the headline. [1] Level 2 (2 marks): describes the effect of one technique with some justification, e.g. the question 'WHO ARE YOU MISSING?' addresses the viewer directly and makes them feel slightly guilty, so they keep reading. [1] Level 3 (3 marks): analyses the effect consistently with a precise example, e.g. the list structure 'The next bus stop. The next table. The next street.' uses repetition and a falling rhythm to move from the public to the personal, so that friends seem close enough to reach; the red band with imperatives 'START MONDAY. TELL THREE FRIENDS.' turns guilt into a simple action. [1] Accept any valid technique: statistics, imagery, imperative verbs, hashtag, icons, small print 'No apps. Just people.', layout.$mq$, $mq$A$mq$),
(5, $mq$[[Q 1.5 | A 10 | B 10]]
Refer to Text A and Text B (printed in Question 1.1). Compare and contrast how the relationship between technology and human connection is presented in the two texts. (Approximately 350 words) (20 marks)

Criterion A (Analysing) is worth 10 marks and Criterion B (Organizing) is worth 10 marks.$mq$, $mq$Total 20 marks: Criterion A (10) and Criterion B (10). Criterion A Analysing (10 marks). 0: no work that meets a descriptor. 1-2 (limited): identifies some content, language, structure or technique with few or no examples; little sense of how the texts relate. 3-4 (adequate): describes some features of the texts with some examples; a degree of understanding of how features create meaning; some awareness of similarity or difference. 5-6 (considerable): explains the effect of a range of features with relevant examples from both texts; clear understanding of how meaning is created; sound awareness of similarities and differences. 7-8 (substantial): analyses the effect of content, language, structure and technique in both texts with well-chosen evidence; thoughtful understanding of the writers' and creators' choices and of the relationship between the texts. 9-10 (excellent): perceptive, sustained analysis of both texts with precise, well-integrated evidence; insightful evaluation of how and why meaning is shaped, and a discerning view of the relationship between the texts. Indicative content for A (not exhaustive; credit any valid, evidenced point). Text A: technology as a seductive and isolating force; the endless scroll ('slid into the eleventh without his thumb ever deciding anything'), the personified screen that 'gave nothing back', the thumbs-up as a failed message, the contrast of the bin lorry and the peeling poster (the real world) with the phone; close third-person narration and the tentative ending in darkness that suggests possible change without resolving it. Text B: technology as a barrier that can be overcome by choice; the visual contrast of the muted crowd and the red kite; direct address, statistics, imperatives and a call to action; the tone moves from guilt to encouragement and practical hope ('No apps. Just people.'). Similarities: both show people physically near but emotionally apart; both use colour or light to separate the screen world from the real one; both suggest that real connection is within reach. Differences: private, ambiguous, internal in Text A versus public, persuasive and purposeful in Text B; Text A shows the problem through one character's story, Text B proposes a solution to a whole group; narrative withholds an answer, while the poster gives a clear one. Award up to [10] for Criterion A. Criterion B Organizing (10 marks). 0: no work that meets a descriptor. 1-2 (limited): little structure; the texts are mostly treated separately or in a list; ideas are hard to follow; little or no concluding thought. 3-4 (adequate): some structure with an opening and a close; both texts are discussed with a few links; some paragraphing and a degree of coherence. 5-6 (considerable): a clear structure; comparison and contrast appear in most paragraphs; ideas are generally logical and linked; an appropriate conclusion. 7-8 (substantial): an effective, purposeful structure; comparison and contrast are woven through the response; transitions are controlled and ideas build; a developed conclusion. 9-10 (excellent): a sophisticated, fully controlled structure that shapes the argument; comparison and contrast are integrated throughout; seamless linking; a conclusion that synthesizes the argument. Look for a comparative structure (for example by idea or by technique), topic sentences that name both texts, comparative connectives (whereas, similarly, in contrast) and a conclusion. Award up to [10] for Criterion B.$mq$, $mq$A$mq$),
(6, $mq$[[Q 2 | C 10 | D 10]]
Task 2: Producing literary text
This task focuses on the key concept of creativity. The criteria assessed are C (Producing text) and D (Using language). Suggested time: 35 minutes.

Image 1 (described in words): an old television set glows in a dark, empty living room. A single armchair is pulled close to it, a cup of tea steaming on its arm, and the screen shows only grey static that casts a flickering light on the wallpaper and a framed family photograph.
Image 2 (described in words): a girl stands alone on a flat city rooftop at dawn, holding a small handheld radio with its aerial raised towards a pale sky. Behind her, the lights of towers and windows are fading as the sun comes up.

Using one of the images, write a scene in a story in which a character hears or sees something that changes how they understand the world. You may consider purpose, characterisation, setting, mood and point of view. State which image you are using before you start. (Approximately 350 words) (20 marks)$mq$, $mq$Total 20 marks: Criterion C (10) and Criterion D (10). Criterion C Producing text (10 marks). 0: no work that meets a descriptor. 1-2 (limited): limited creative choices; little imagination or insight; little detail; the image or prompt is hardly used. 3-4 (adequate): some creative choices; some imagination and insight; some relevant detail; the image and prompt are used in a basic way. 5-6 (considerable): thoughtful creative choices of content, character, setting and point of view; considerable imagination and insight; sufficient relevant detail. 7-8 (substantial): purposeful, imaginative choices; a developed voice and perspective; substantial insight; well-chosen detail that supports a clear purpose. 9-10 (excellent): highly original, perceptive choices; an assured, distinctive voice and perspective; extensive, precise detail and a controlled narrative or poetic shape that fully serves the prompt. A response that uses neither image and does not address the prompt scores 0 for Criterion C. Indicative content: the named image is clearly used as a starting point; a character with a clear motive; a controlled shift from not knowing to understanding; a purposeful setting and mood (for example anticipation, loneliness, wonder, unease); sensory detail, especially sound and light; a deliberate point of view; an ending that resonates. Credit science fiction, realist, mystery or poetic treatments. Award up to [10] for Criterion C. Criterion D Using language (10 marks). 0: no work that meets a descriptor. 1-2 (limited): limited range of vocabulary and structures; errors are frequent and often hinder communication; register is rarely appropriate. 3-4 (adequate): adequate range; a degree of accuracy; errors sometimes hinder communication; register is sometimes appropriate. 5-6 (considerable): a varied range of vocabulary, sentence structures and devices; considerable accuracy; errors do not hinder communication; register and style are generally appropriate. 7-8 (substantial): an effective range used with control; high accuracy with occasional slips; register and style are consistently appropriate and purposeful. 9-10 (excellent): a sophisticated, flexible range used with precision and flair; highly accurate with only minor errors; register and style are skilfully sustained throughout. Look for varied sentence length, precise verbs, controlled imagery and tense, and accurate punctuation. Award up to [10] for Criterion D.$mq$, $mq$C$mq$),
(7, $mq$[[Q 3 | B 10 | C 10 | D 10]]
Task 3: Producing non-literary text
This task focuses on the key concept of communication. You will create a piece of non-literary writing in relation to the global context scientific and technical innovation: digital life. The criteria assessed are B (Organizing), C (Producing text) and D (Using language). Suggested time: 50 minutes.

Your school is considering introducing a 'phone-free day' every week. Write a formal letter to the head teacher giving your view on this proposal and recommending what the school should do. Use a clear structure and the conventions of a formal letter, including an appropriate opening and close, a clear purpose, developed reasons supported by evidence and a persuasive but respectful tone. (Approximately 350 words) (30 marks)$mq$, $mq$Total 30 marks: Criterion B (10), Criterion C (10) and Criterion D (10). Criterion B Organizing (10 marks). 0: no work that meets a descriptor. 1-2 (limited): little organisation; few or no text-type conventions; ideas not sequenced; paragraphing absent or random. 3-4 (adequate): some organisation; some conventions of the text type are used; a basic opening and ending; paragraphing is mostly logical. 5-6 (considerable): a clear structure; most conventions of the text type are used appropriately; ideas are generally sequenced and linked. 7-8 (substantial): an effective structure; conventions of the text type used purposefully; clear progression with controlled links and an effective opening and close. 9-10 (excellent): a skilfully crafted structure; conventions of the text type exploited for effect; seamless progression, with every paragraph contributing to the purpose and audience. Indicative content: sender and recipient details or an acceptable letter layout, date, formal salutation and sign-off that match (Dear Mr/Ms X ... Yours sincerely, or Dear Sir or Madam ... Yours faithfully), a subject line or an opening that states the purpose, logically sequenced paragraphs (position, reasons, counterargument, recommendation) and a courteous close. Award up to [10] for Criterion B. Criterion C Producing text (10 marks). 0: no work that meets a descriptor. 1-2 (limited): little insight into the global context or topic; little relevant detail; limited sense of audience and purpose. 3-4 (adequate): some insight into the global context; some relevant detail and examples; some awareness of audience and purpose. 5-6 (considerable): considerable insight into the global context and the topic; sufficient relevant detail and examples; a clear perspective and a good sense of audience and purpose. 7-8 (substantial): substantial, well-developed insight; well-chosen examples that support the argument; an assured perspective and a controlled appeal to the audience. 9-10 (excellent): perceptive, original insight into the global context; extensive, precise detail and examples; a distinctive, convincing perspective that fully serves the audience and purpose. Indicative content: insight into digital life, including benefits (research, communication, creativity, safety) and costs (distraction, sleep, wellbeing, comparison, reduced face-to-face contact); a clear and defensible position; specific evidence or examples from school life; consideration of the head teacher's concerns; a practical recommendation such as a trial period with review. Award up to [10] for Criterion C. Criterion D Using language (10 marks). 0: no work that meets a descriptor. 1-2 (limited): limited range of vocabulary and structures; errors are frequent and often hinder communication; register is rarely appropriate. 3-4 (adequate): adequate range; a degree of accuracy; errors sometimes hinder communication; register is sometimes appropriate. 5-6 (considerable): a varied range of vocabulary, sentence structures and devices; considerable accuracy; errors do not hinder communication; register and style are generally appropriate. 7-8 (substantial): an effective range used with control; high accuracy with occasional slips; register and style are consistently appropriate and purposeful. 9-10 (excellent): a sophisticated, flexible range used with precision and flair; highly accurate with only minor errors; register and style are skilfully sustained throughout. Look for a consistently formal register (no slang or contractions unless justified), measured persuasive devices, effective connectives and accurate grammar, spelling and punctuation. Award up to [10] for Criterion D.$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

-- French ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 68 marks) (68 marks)
with sub as (select id from public.subjects where slug = $mq$french-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 68 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 68 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the voice message, then answer in English.

Message vocal de Mathieu :
« Salut Lucas, c'est Mathieu. Samedi, c'est mon anniversaire : j'ai quatorze ans ! Je fais une fête chez moi à dix-huit heures. Au menu, il y a un gâteau au chocolat et des pizzas. Tu peux apporter des boissons ? Après le repas, nous jouons aux jeux vidéo et nous écoutons de la musique. Ma maison est près de la gare, au numéro douze, rue Victor-Hugo. Réponds-moi vite ! À samedi ! »

(a) How old will Mathieu be on Saturday? (1 mark)
(b) At what time does the party start? (1 mark)
(c) Which two things will there be to eat? (2 marks)
(d) What is Lucas asked to bring? (1 mark)
(e) What two things will the guests do after the meal? (2 marks)
(f) Where is Mathieu's house? (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] 14 / fourteen
(b) [1] 6 pm / 18:00
(c) [1] Chocolate cake
[1] Pizzas (accept pizza)
(d) [1] Drinks
(e) [1] Play video games
[1] Listen to music
(f) [1] Near the station (also accept: 12 rue Victor-Hugo)$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the conversation, then answer in English.

À la gare
Employé : Bonjour, madame. Vous désirez ?
Cliente : Bonjour. Je voudrais des billets pour Lyon, s'il vous plaît.
Employé : Un aller simple ou un aller-retour ?
Cliente : Un aller-retour. C'est pour aujourd'hui.
Employé : Le prochain train part à quatorze heures quinze, du quai numéro trois. Le voyage dure deux heures.
Cliente : C'est combien ?
Employé : Un billet adulte coûte trente-huit euros et un billet enfant coûte dix-neuf euros.
Cliente : Alors, je voudrais un billet pour moi et un pour ma fille. Elle a huit ans. Je paie par carte.
Employé : Très bien. Voilà vos billets. Bon voyage !

(a) Where does the customer want to go? (1 mark)
(b) Does she want a single or a return ticket? (1 mark)
(c) At what time does the next train leave? (1 mark)
(d) From which platform does the train leave? (1 mark)
(e) How long does the journey take? (1 mark)
(f) How much is a child's ticket? (1 mark)
(g) How much does the customer pay in total for herself and her daughter? Show your working or give the total. (1 mark)
(h) How does she pay? (1 mark)

Total for Question 2: 8 marks$mq$, $mq$(a) [1] Lyon
(b) [1] Return (aller-retour)
(c) [1] 2.15 pm / 14:15
(d) [1] Platform 3 / number three
(e) [1] Two hours
(f) [1] 19 euros
(g) [1] 57 euros (38 + 19)
(h) [1] By card$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 10]]
Reading. Read the text, then answer in English.

Text A (message)
Salut Léa ! Mon téléphone est cassé, alors j'écris depuis l'ordinateur de mon père. Le week-end, je joue aux jeux vidéo, mais pas pendant la semaine parce que j'ai beaucoup de devoirs. Mon jeu préféré s'appelle « Planète Bleue ». Et toi, tu aimes jouer ? Hugo

Text B (poster)
CLUB INFORMATIQUE
Tu aimes les ordinateurs ? Rejoins le club informatique du collège !
Quand ? Le lundi et le vendredi, de midi à treize heures.
Où ? En salle 12, à côté de la bibliothèque.
Au programme : créer un site web, apprendre à programmer, jouer à des jeux éducatifs.
C'est gratuit ! Inscription auprès de Madame Roux.

(a) What is wrong with Hugo's phone? (1 mark)
(b) When does Hugo play video games? (1 mark)
(c) Why does he not play during the week? (1 mark)
(d) What is the name of his favourite game? (1 mark)
(e) On which two days does the computer club meet? (2 marks)
(f) Where does the club meet? (1 mark)
(g) Name one activity at the club. (1 mark)
(h) How much does the club cost? (1 mark)
(i) Who should students register with? (1 mark)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] It is broken
(b) [1] At the weekend
(c) [1] He has a lot of homework
(d) [1] Planète Bleue (Blue Planet)
(e) [1] Monday
[1] Friday
(f) [1] Room 12 (next to the library)
(g) [1] Any one of: create a website / learn to programme (code) / play educational games
(h) [1] Nothing / it is free
(i) [1] Madame Roux$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 12]]
Reading. Read the text, then answer in English.

Salut Tom !
Tu me demandes comment est ma ville. J'habite à Saint-Aubin, un petit village près de la mer, dans l'ouest de la France. Il y a deux mille habitants. Dans le village, il y a une boulangerie, une pharmacie, un petit supermarché et une église. Il n'y a pas de cinéma, mais il y a une grande plage. En été, il y a beaucoup de touristes : ils font de la voile et mangent des glaces. En hiver, il fait froid et il pleut souvent, mais j'aime mon village parce qu'il est calme. Pour aller au collège, je prends le bus : le collège est à dix kilomètres. Le week-end, je joue au volley sur la plage avec mes copains. L'année dernière, tu as visité Paris avec ta famille ; cet été, tu peux venir chez moi !
À bientôt, Camille

(a) Where is Saint-Aubin? Give two details. (2 marks)
(b) How many people live in Saint-Aubin? (1 mark)
(c) Name two shops or services in the village. (2 marks)
(d) What is there not in the village? (1 mark)
(e) What do tourists do in summer? Give two details. (2 marks)
(f) Why does Camille like the village in winter? (1 mark)
(g) How does Camille get to school, and how far away is it? (2 marks)
(h) What does Camille do at the weekend? (1 mark)

Total for Question 4: 12 marks$mq$, $mq$(a) [1] Near the sea
[1] In the west of France
(b) [1] 2000 / two thousand
(c) [1] Any one of: bakery / pharmacy / small supermarket (church is not accepted)
[1] A different one of these
(d) [1] A cinema
(e) [1] They go sailing
[1] They eat ice creams
(f) [1] It is calm / quiet
(g) [1] By bus
[1] 10 km / ten kilometres
(h) [1] Plays volleyball on the beach (with friends)$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | D 8]]
Language in context. Answer all parts. Parts (a) to (d) are gap-fills, (e) and (f) are choices, (g) and (h) are translations into the target language.

(a) Complete with the correct form of the verb in brackets: Nous ______ (habiter) dans une petite maison. (1 mark)
(b) Complete with the correct form of the verb in brackets: Mon frère ______ (avoir) seize ans. (1 mark)
(c) Complete with the correct form of the verb in brackets: Tu ______ (aller) au collège à pied ? (1 mark)
(d) Complete with the correct form of the verb in brackets: Elles ______ (faire) leurs devoirs. (1 mark)
(e) Choose the correct word, un or une: J'ai ______ chat noir. (1 mark)
(f) Choose the correct word, le or l' : Ma mère travaille à ______ hôpital. (1 mark)
(g) Translate into French: Tomorrow I am going to play tennis. (1 mark)
(h) Translate into French: There are three bedrooms in the house. (1 mark)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] habitons
(b) [1] a
(c) [1] vas
(d) [1] font
(e) [1] un
(f) [1] l'
(g) [1] Demain, je vais jouer au tennis. (accept: Je vais jouer au tennis demain.)
(h) [1] Il y a trois chambres dans la maison.$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | D 10]]
Writing. You will soon stay with a host family in France. Write an email to introduce yourself. Include: your name and age; where you live; one family member; two hobbies; a question for the family.

Write 60 to 70 words in French. (10 marks)

Total for Question 6: 10 marks$mq$, $mq$Content (1 mark each)
[1] Gives name and age (e.g. Je m'appelle Sam et j'ai quinze ans)
[1] Says where they live
[1] Describes at least one family member
[1] Mentions a first hobby (e.g. J'aime jouer au football)
[1] Mentions a second hobby
[1] Asks a question to the family (e.g. Vous avez un chien ?)
Language
[3] Vocabulary and grammar: 3 = mostly accurate with some variety of structures; 2 = generally accurate, simple structures; 1 = frequent errors, message still understood; 0 = not understandable
Organisation
[1] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 40 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | D 12]]
Writing. Your school magazine has a competition called « Protégeons notre planète ». Write an article. Include: one environmental problem; two things you do at home to protect the planet; one thing you did recently to help; one thing you are going to do next week; why you think it is important.

Write 80 to 90 words in French. (12 marks)

Total for Question 7: 12 marks$mq$, $mq$Content (1 mark each)
[1] Names a problem (e.g. la pollution, les déchets, le plastique)
[1] Gives a first action at home (e.g. Je recycle le papier)
[1] Gives a second action at home (e.g. J'éteins la lumière)
[1] Says what they did recently (past tense or a clear attempt, e.g. J'ai ramassé des déchets)
[1] Says what they will do next week (e.g. Je vais utiliser un vélo)
[1] Gives a reason or opinion (e.g. C'est important parce que la planète est notre maison)
Language
[4] Vocabulary and grammar: 4 = mostly accurate with some variety of structures; 3 = generally accurate, simple structures; 2 = frequent errors, message still understood; 1 = very limited; 0 = not understandable
Organisation
[2] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 50 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- French ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 68 marks) (68 marks)
with sub as (select id from public.subjects where slug = $mq$french-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$French ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 68 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$French ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 68 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the school announcement, then answer in English.

Annonce du collège :
« Bonjour à tous les élèves de troisième. Demain, mercredi, le cours de sciences est à neuf heures, en salle quinze. Apportez votre cahier et une calculatrice. Le cours de sport est annulé parce que le professeur est malade. Vendredi, c'est la fête de l'école. Les élèves peuvent venir avec leurs parents à partir de dix-sept heures. Il y a des jeux, un concert et un repas. Merci et bonne journée ! »

(a) On which day and at what time is the science lesson? (2 marks)
(b) In which room is the science lesson? (1 mark)
(c) What two things must students bring? (2 marks)
(d) Why is the sport lesson cancelled? (1 mark)
(e) On which day is the school party? (1 mark)
(f) Name one thing there will be at the party. (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] Wednesday
[1] 9 am / 09:00
(b) [1] Room 15 / fifteen
(c) [1] An exercise book / notebook
[1] A calculator
(d) [1] The teacher is ill / sick
(e) [1] Friday
(f) [1] Any one of: games / a concert / a meal$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the radio weather forecast, then answer in English.

Bulletin météo à la radio :
« Voici la météo pour demain. Dans le nord, il pleut le matin et il y a du vent l'après-midi. La température est de douze degrés. Dans l'est, il neige dans les montagnes. Dans le sud, il fait beau et chaud : vingt-sept degrés, avec beaucoup de soleil. À l'ouest, il y a du brouillard le matin, puis du soleil. Pour le week-end, il fait plus froid partout. Bonne journée ! »

(a) What is the weather like in the north in the morning? (1 mark)
(b) What is the weather like in the north in the afternoon? (1 mark)
(c) What is the temperature in the north? (1 mark)
(d) What is the weather like in the mountains in the east? (1 mark)
(e) What is the weather like in the south? (1 mark)
(f) What is the temperature in the south? (1 mark)
(g) What is the weather like in the west in the morning? (1 mark)
(h) What will the weather be like at the weekend? (1 mark)

Total for Question 2: 8 marks$mq$, $mq$(a) [1] Rain / it rains
(b) [1] Windy / wind
(c) [1] 12 degrees
(d) [1] Snow / it snows
(e) [1] Fine / nice and warm / sunny (accept any one of these)
(f) [1] 27 degrees
(g) [1] Fog / foggy
(h) [1] Colder (everywhere)$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 10]]
Reading. Read the text, then answer in English.

OFFRE D'EMPLOI
Le café Le Soleil, rue des Fleurs, cherche un serveur ou une serveuse pour juillet et août.
Tu as seize ans ou plus. Tu es sympa et tu aimes parler avec les gens.
Tu travailles du mardi au samedi, de dix heures à seize heures.
Salaire : neuf euros par heure. Un repas gratuit à midi.
Écris à Monsieur Blanc : cafelesoleil@exemple.fr

(a) In which two months is the job? (2 marks)
(b) What is the minimum age? (1 mark)
(c) Which two qualities does the café want? (2 marks)
(d) On which days does the person work? (1 mark)
(e) What are the working hours? (2 marks)
(f) How much is the pay per hour? (1 mark)
(g) What is free at midday? (1 mark)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] July
[1] August
(b) [1] 16 / sixteen
(c) [1] Friendly / nice
[1] Likes talking to people
(d) [1] Tuesday to Saturday
(e) [1] From 10 am / 10:00
[1] To 4 pm / 16:00
(f) [1] 9 euros
(g) [1] A meal$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 12]]
Reading. Read the text, then answer in English.

Mes vacances au Canada
Cet été, ma famille et moi, nous sommes allés au Canada, chez ma tante, à Québec. Nous avons pris l'avion à Paris. En juillet, il fait chaud, mais en hiver il fait très froid. Nous avons visité le vieux Québec et nous avons mangé des crêpes au sirop d'érable. Mon père a pris beaucoup de photos. À Québec, tout le monde parle français, et ma cousine parle aussi anglais. Demain, nous allons faire une promenade en bateau pour voir des baleines. Ensuite, nous allons rentrer à Paris.
Sarah

(a) Where did Sarah go on holiday? (1 mark)
(b) Whose house did the family stay at? (1 mark)
(c) How did the family travel? (1 mark)
(d) What is the weather like in July? (1 mark)
(e) What did they visit? (1 mark)
(f) What did they eat? Give two details. (2 marks)
(g) Who took a lot of photos? (1 mark)
(h) Which two languages does Sarah's cousin speak? (2 marks)
(i) What are they going to do tomorrow? (1 mark)
(j) What are they going to do after that? (1 mark)

Total for Question 4: 12 marks$mq$, $mq$(a) [1] Canada / Québec
(b) [1] Her aunt's
(c) [1] By plane
(d) [1] Warm / hot
(e) [1] The old town of Québec / old Québec
(f) [1] Pancakes / crêpes
[1] With maple syrup
(g) [1] Her father
(h) [1] French
[1] English
(i) [1] Go on a boat trip (to see whales)
(j) [1] Return / go back to Paris$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | D 8]]
Language in context. Answer all parts. Parts (a) to (d) use the words in the box: est · a · vais · prend. Parts (e) and (f) are adjective agreements. Parts (g) and (h) are translations into French.

(a) Complete with a word from the box: Ma mère ______ le bus pour aller au travail. (1 mark)
(b) Complete with a word from the box: Je ______ au marché samedi. (1 mark)
(c) Complete with a word from the box: Il ______ vingt ans. (1 mark)
(d) Complete with a word from the box: Mon père ______ médecin. (1 mark)
(e) Write the adjective in the correct form: Les chaussures sont ______ (noir). (1 mark)
(f) Write the adjective in the correct form: Ma sœur est ______ (content). (1 mark)
(g) Translate into French: I have a brother and two sisters. (1 mark)
(h) Translate into French: She likes playing the guitar. (1 mark)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] prend
(b) [1] vais
(c) [1] a
(d) [1] est
(e) [1] noires
(f) [1] contente
(g) [1] J'ai un frère et deux sœurs.
(h) [1] Elle aime jouer de la guitare.$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | D 10]]
Writing. Your French friend asks about your school. Write a message to answer. Include: the name of your school and where it is; your favourite subject and why; what time lessons start; what you eat at lunchtime; a question about your friend's school.

Write 60 to 70 words in French. (10 marks)

Total for Question 6: 10 marks$mq$, $mq$Content (1 mark each)
[1] Gives the name or the location of the school
[1] Says their favourite subject (e.g. Ma matière préférée, c'est l'anglais)
[1] Gives a reason (e.g. parce que le professeur est sympa)
[1] Says what time lessons start (e.g. Les cours commencent à huit heures)
[1] Says what they eat at lunchtime
[1] Asks a question about the friend's school (e.g. Comment est ton école ?)
Language
[3] Vocabulary and grammar: 3 = mostly accurate with some variety of structures; 2 = generally accurate, simple structures; 1 = frequent errors, message still understood; 0 = not understandable
Organisation
[1] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 40 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | D 12]]
Writing. Your school magazine is preparing an issue called « Les écrans et moi ». Write an article. Include: which devices you use; how long you use them each day; two things you do online; one advantage or one problem of screens; what you are going to do tomorrow with a device or without one.

Write 80 to 90 words in French. (12 marks)

Total for Question 7: 12 marks$mq$, $mq$Content (1 mark each)
[1] Says which device(s) they use (e.g. J'utilise un téléphone et un ordinateur)
[1] Says how long each day (e.g. deux heures par jour)
[1] Gives a first online activity (e.g. je regarde des vidéos)
[1] Gives a second online activity (e.g. je parle avec mes amis)
[1] Gives an advantage or a problem (e.g. C'est utile pour les devoirs / Ça fatigue les yeux)
[1] Says what they will do tomorrow (e.g. Demain, je vais jouer au foot sans mon téléphone)
Language
[4] Vocabulary and grammar: 4 = mostly accurate with some variety of structures; 3 = generally accurate, simple structures; 2 = frequent errors, message still understood; 1 = very limited; 0 = not understandable
Organisation
[2] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 50 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Spanish ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 68 marks) (68 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 68 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish ab initio MYP 5 eAssessment Structure Mock A (7 tasks, 68 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the voice message, then answer in English.

Mensaje de voz de Marta:
« Hola, Pablo, soy Marta. Te llamo porque mañana es el cumpleaños de mi abuela. Cumple setenta años. Vamos a comer en un restaurante italiano que se llama La Piazza, a las dos de la tarde. Somos doce personas: mis padres, mis tíos, mis primos y mis hermanos. Después de la comida, vamos a casa de mi abuela y comemos tarta. ¿Puedes comprar flores? Cuestan unos diez euros en la tienda de la esquina. ¡Gracias y hasta mañana! »

(a) Whose birthday is it tomorrow? (1 mark)
(b) How old is she going to be? (1 mark)
(c) What kind of restaurant are they going to? (1 mark)
(d) At what time is the meal? (1 mark)
(e) How many people will be at the meal? (1 mark)
(f) What will they do after the meal? Give two details. (2 marks)
(g) What is Pablo asked to buy? (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] Marta's grandmother's
(b) [1] 70 / seventy
(c) [1] Italian
(d) [1] 2 pm / 14:00
(e) [1] 12 / twelve
(f) [1] Go to the grandmother's house
[1] Eat cake
(g) [1] Flowers$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the conversation, then answer in English.

En un restaurante
Camarero: Buenas tardes. ¿Qué van a tomar?
Cliente: De primero, quiero una sopa de verduras. Mi hija quiere pescado con ensalada de segundo.
Camarero: Muy bien. ¿Y para beber?
Cliente: Agua para mí y un zumo de naranja para ella.
Camarero: De postre, tenemos helado de chocolate o fruta.
Cliente: Helado para los dos, por favor.
(Más tarde)
Cliente: La cuenta, por favor.
Camarero: Son veintiocho euros.
Cliente: ¿Puedo pagar con tarjeta?
Camarero: Lo siento, solo en efectivo.

(a) What does the customer order as a first course? (1 mark)
(b) What does the daughter order as her main course? Give two details. (2 marks)
(c) What do the customer and his or her daughter drink? (2 marks)
(d) What do they have for dessert? (1 mark)
(e) How much is the bill? (1 mark)
(f) Can the customer pay by card? (1 mark)

Total for Question 2: 8 marks$mq$, $mq$(a) [1] Vegetable soup
(b) [1] Fish
[1] Salad
(c) [1] Water (customer)
[1] Orange juice (daughter)
(d) [1] Chocolate ice cream
(e) [1] 28 euros
(f) [1] No, cash only$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 10]]
Reading. Read the text, then answer in English.

COLEGIO SAN MIGUEL - ACTIVIDADES DESPUÉS DE CLASE
El lunes hay teatro, de las cuatro a las cinco y media, en el aula cuatro. El martes hay fútbol en el polideportivo, de las cuatro a las cinco. El miércoles hay ajedrez en la biblioteca, y el jueves hay un taller de fotografía en el laboratorio de informática. Cada alumno puede elegir un máximo de dos actividades. Cada actividad cuesta quince euros al mes. Para apuntarse, hay que hablar con la señora Ruiz, en la secretaría, antes del treinta de septiembre.

(a) At what time does the theatre activity start and finish? (2 marks)
(b) Where does the football take place? (1 mark)
(c) Which activity is on Wednesday? (1 mark)
(d) Where is the photography workshop? (1 mark)
(e) What is the maximum number of activities a student can choose? (1 mark)
(f) How much does one activity cost? (1 mark)
(g) How much would a student pay each month for two activities? (1 mark)
(h) Who should students speak to in order to sign up? (1 mark)
(i) What is the deadline for signing up? (1 mark)

Total for Question 3: 10 marks$mq$, $mq$(a) [1] Starts at 4 pm / 16:00
[1] Finishes at 5.30 pm / 17:30
(b) [1] In the sports hall / sports centre
(c) [1] Chess
(d) [1] In the computer lab / IT room
(e) [1] Two
(f) [1] 15 euros a month
(g) [1] 30 euros
(h) [1] Mrs Ruiz / Señora Ruiz
(i) [1] 30 September$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 12]]
Reading. Read the text, then answer in English.

Hola, Ben:
Me preguntas cómo es mi pueblo. Vivo en Villaverde, un pueblo pequeño en el norte de España, cerca de las montañas. Hay unos tres mil habitantes. En el centro hay una plaza grande con una iglesia antigua, un mercado y muchos bares. No hay cine ni piscina, pero hay un parque muy bonito con un lago. En invierno nieva y mucha gente viene a esquiar. En verano hace buen tiempo y hacemos excursiones por la montaña. Mi casa está lejos del instituto, a cinco kilómetros, y voy en autobús. Los sábados juego al baloncesto con mis amigos en el parque. El año pasado visitaste España con tu familia; este verano puedes visitar mi pueblo. ¡Te va a gustar!
Un abrazo, Javier

(a) Where is Villaverde? Give two details. (2 marks)
(b) How many people live in Villaverde? (1 mark)
(c) Name two things in the centre of the village. (2 marks)
(d) Name two things the village does not have. (2 marks)
(e) What happens in winter? Give two details. (2 marks)
(f) How does Javier travel to school? (1 mark)
(g) How far is his house from the school? (1 mark)
(h) What does Javier do on Saturdays? (1 mark)

Total for Question 4: 12 marks$mq$, $mq$(a) [1] In the north of Spain
[1] Near the mountains
(b) [1] About 3000 / three thousand
(c) [1] Any one of: large square / old church / market / bars
[1] A different one of these
(d) [1] Cinema
[1] Swimming pool
(e) [1] It snows
[1] Many people come to ski
(f) [1] By bus
(g) [1] 5 km / five kilometres
(h) [1] Plays basketball (with friends in the park)$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | D 8]]
Language in context. Answer all parts. Parts (a) to (d) are verb forms, (e) and (f) are choices, (g) and (h) are translations into Spanish.

(a) Complete with the correct form of the verb in brackets: Mi hermano ______ (tener) quince años. (1 mark)
(b) Complete with the correct form of the verb in brackets: Nosotros ______ (vivir) en un piso pequeño. (1 mark)
(c) Complete with the correct form of the verb in brackets: ¿______ (tú, hablar) inglés? (1 mark)
(d) Complete with the correct form of the verb in brackets: Mis padres ______ (trabajar) en un banco. (1 mark)
(e) Choose the correct verb, es or está: Mi casa ______ cerca del parque. (1 mark)
(f) Choose the correct verb, es or está: Ana ______ muy simpática. (1 mark)
(g) Translate into Spanish: I like playing tennis. (1 mark)
(h) Translate into Spanish: Tomorrow we are going to eat paella. (1 mark)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] tiene
(b) [1] vivimos
(c) [1] Hablas
(d) [1] trabajan
(e) [1] está
(f) [1] es
(g) [1] Me gusta jugar al tenis.
(h) [1] Mañana vamos a comer paella. (accept: Vamos a comer paella mañana.)$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | D 10]]
Writing. You are joining a school exchange website for students who want to learn Spanish. Write a message to introduce yourself. Include: your name and age; where you live; one family member; two hobbies; a question for your new friend.

Write 60 to 70 words in Spanish. (10 marks)

Total for Question 6: 10 marks$mq$, $mq$Content (1 mark each)
[1] Gives name and age (e.g. Me llamo Sam y tengo quince años)
[1] Says where they live
[1] Describes at least one family member
[1] Mentions a first hobby (e.g. Me gusta jugar al fútbol)
[1] Mentions a second hobby
[1] Asks a question to the friend (e.g. ¿Y tú, qué haces en tu tiempo libre?)
Language
[3] Vocabulary and grammar: 3 = mostly accurate with some variety of structures; 2 = generally accurate, simple structures; 1 = frequent errors, message still understood; 0 = not understandable
Organisation
[1] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 40 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | D 12]]
Writing. Your school magazine has a competition called « Cuidemos el planeta ». Write an article. Include: one environmental problem; two things you do at home to protect the planet; one thing you did recently to help; one thing you are going to do next week; why you think it is important.

Write 80 to 90 words in Spanish. (12 marks)

Total for Question 7: 12 marks$mq$, $mq$Content (1 mark each)
[1] Names a problem (e.g. la contaminación, la basura, el plástico)
[1] Gives a first action at home (e.g. Reciclo el papel)
[1] Gives a second action at home (e.g. Apago la luz)
[1] Says what they did recently (past tense or a clear attempt, e.g. Ayer recogí basura en el parque)
[1] Says what they will do next week (e.g. Voy a ir al colegio en bicicleta)
[1] Gives a reason or opinion (e.g. Es importante porque el planeta es nuestra casa)
Language
[4] Vocabulary and grammar: 4 = mostly accurate with some variety of structures; 3 = generally accurate, simple structures; 2 = frequent errors, message still understood; 1 = very limited; 0 = not understandable
Organisation
[2] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 50 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);

-- Spanish ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 67 marks) (67 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-ab-initio$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 67 marks)$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish ab initio MYP 5 eAssessment Structure Mock B (7 tasks, 67 marks)$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$[[Q 1 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the radio advertisement, then answer in English.

Anuncio de radio:
« ¿Necesitas un ordenador nuevo? ¡Ven a Tecno-Mundo! Estamos en la calle Mayor, número veinte, al lado del banco. Abrimos de lunes a sábado, de diez de la mañana a ocho de la tarde. Esta semana, los ordenadores portátiles cuestan solo cuatrocientos euros. Los móviles tienen un descuento del veinte por ciento. Si compras un móvil, la funda es gratis. Además, hay clases de informática para jóvenes los sábados por la mañana. ¡Visita también nuestra página web! »

(a) Where is the shop? Give two details. (2 marks)
(b) On which days is the shop open? (1 mark)
(c) What are the opening hours? (2 marks)
(d) How much are the laptops this week? (1 mark)
(e) What discount is there on mobile phones? (1 mark)
(f) What is free if you buy a mobile phone? (1 mark)

Total for Question 1: 8 marks$mq$, $mq$(a) [1] Calle Mayor, number 20
[1] Next to the bank
(b) [1] Monday to Saturday
(c) [1] From 10 am / 10:00
[1] To 8 pm / 20:00
(d) [1] 400 euros
(e) [1] 20% / twenty per cent
(f) [1] A (phone) case$mq$, $mq$A$mq$),
(2, $mq$[[Q 2 | A 8]]
Listening. [Audio transcript - read twice] Read the transcript of the conversation, then answer in English.

Dos amigos hablan del verano
Lucía: Hola, Carlos. ¿Qué haces este verano?
Carlos: Voy a trabajar en la heladería de mi tío, en la playa.
Lucía: ¿Cuántas horas trabajas?
Carlos: Seis horas al día, de las once a las cinco.
Lucía: ¿Y cuánto ganas?
Carlos: Ocho euros la hora.
Lucía: ¡Qué bien! ¿Te gusta el trabajo?
Carlos: Sí, me gusta porque hablo con mucha gente, pero hace mucho calor.
Lucía: Yo voy a estudiar inglés en Dublín durante dos semanas.
Carlos: ¡Qué suerte! ¿Cuándo sales?
Lucía: El quince de julio.

(a) Where is Carlos going to work? (1 mark)
(b) At what time does he start and finish work? (2 marks)
(c) How much does Carlos earn per hour? (1 mark)
(d) What does Carlos like about the job? (1 mark)
(e) What is the problem with the job? (1 mark)
(f) What is Lucía going to do? (1 mark)
(g) When does she leave? (1 mark)

Total for Question 2: 8 marks$mq$, $mq$(a) [1] In his uncle's ice-cream shop (on the beach)
(b) [1] Starts at 11 am / 11:00
[1] Finishes at 5 pm / 17:00
(c) [1] 8 euros
(d) [1] He talks to lots of people
(e) [1] It is very hot
(f) [1] Study English (in Dublin)
(g) [1] 15 July$mq$, $mq$A$mq$),
(3, $mq$[[Q 3 | B 9]]
Reading. Read the text, then answer in English.

Mi vida con el móvil
Me llamo Daniel y tengo catorce años. Tengo un móvil desde los doce años. Lo uso para hablar con mis amigos, escuchar música y ver vídeos. Por la noche, no uso el móvil después de las diez, porque necesito dormir ocho horas. Mis padres dicen que paso demasiado tiempo con la pantalla, pero yo creo que el móvil es útil para hacer los deberes. Mi aplicación favorita es un diccionario de inglés. El fin de semana prefiero salir con mis amigos y jugar al fútbol.

(a) How old is Daniel? (1 mark)
(b) How old was he when he got his phone? (1 mark)
(c) What does Daniel use his phone for? Give three details. (3 marks)
(d) What is his rule about the phone at night? (1 mark)
(e) Why does he have this rule? (1 mark)
(f) What do his parents say? (1 mark)
(g) Why does Daniel think the phone is useful? (1 mark)

Total for Question 3: 9 marks$mq$, $mq$(a) [1] 14 / fourteen
(b) [1] 12 / twelve
(c) [1] Talking to friends
[1] Listening to music
[1] Watching videos
(d) [1] No phone after 10 pm / 22:00
(e) [1] He needs eight hours of sleep
(f) [1] He spends too much time on the screen
(g) [1] For doing homework$mq$, $mq$B$mq$),
(4, $mq$[[Q 4 | B 12]]
Reading. Read the text, then answer in English.

Querida Sofía:
¡Saludos desde la costa! Estoy de vacaciones con mi familia en un hotel pequeño, cerca de la playa. Llegamos el sábado por la noche en tren; el viaje duró cinco horas. La habitación es grande y tiene vista al mar. Cada mañana desayunamos en la terraza: tostadas con tomate y zumo de naranja. Ayer visitamos un acuario y vimos tortugas y tiburones. Mi hermano pequeño se bañó en el mar, pero el agua estaba muy fría. Hoy llueve, así que vamos a ir al museo. Mañana vamos a alquilar bicicletas y vamos a ir a un pueblo cercano. Volvemos a casa el domingo. ¡Hasta pronto!
Un abrazo, Irene

(a) Who is Irene on holiday with? (1 mark)
(b) Where are they staying? (1 mark)
(c) How did they travel? (1 mark)
(d) How long did the journey take? (1 mark)
(e) What do they have for breakfast? Give two details. (2 marks)
(f) Where did they go yesterday? (1 mark)
(g) Which two animals did they see? (2 marks)
(h) What was the problem when her brother swam in the sea? (1 mark)
(i) What is the weather like today? (1 mark)
(j) What are they going to do today because of the weather? (1 mark)

Total for Question 4: 12 marks$mq$, $mq$(a) [1] Her family
(b) [1] In a small hotel near the beach
(c) [1] By train
(d) [1] Five hours
(e) [1] Toast with tomato
[1] Orange juice
(f) [1] To an aquarium
(g) [1] Turtles
[1] Sharks
(h) [1] The water was very cold
(i) [1] It is raining
(j) [1] Go to the museum$mq$, $mq$B$mq$),
(5, $mq$[[Q 5 | D 8]]
Language in context. Answer all parts. Parts (a) to (d) use the words in the box: es · está · hay · tiene. Parts (e) and (f) are adjective agreements. Parts (g) and (h) are translations into Spanish.

(a) Complete with a word from the box: Mi tía ______ cuarenta años. (1 mark)
(b) Complete with a word from the box: En mi ciudad ______ un museo muy grande. (1 mark)
(c) Complete with a word from the box: Mi padre ______ ingeniero. (1 mark)
(d) Complete with a word from the box: El banco ______ al lado de la farmacia. (1 mark)
(e) Write the adjective in the correct form: Las casas son ______ (blanco). (1 mark)
(f) Write the adjective in the correct form: Mi hermana es muy ______ (alto). (1 mark)
(g) Translate into Spanish: I have a brother and two sisters. (1 mark)
(h) Translate into Spanish: She does not eat meat. (1 mark)

Total for Question 5: 8 marks$mq$, $mq$(a) [1] tiene
(b) [1] hay
(c) [1] es
(d) [1] está
(e) [1] blancas
(f) [1] alta
(g) [1] Tengo un hermano y dos hermanas.
(h) [1] No come carne. (accept: Ella no come carne.)$mq$, $mq$D$mq$),
(6, $mq$[[Q 6 | D 10]]
Writing. Your Spanish friend asks about your school. Write a message to answer. Include: the name of your school and where it is; your favourite subject and why; what time lessons start; what you eat at lunchtime; a question about your friend's school.

Write 60 to 70 words in Spanish. (10 marks)

Total for Question 6: 10 marks$mq$, $mq$Content (1 mark each)
[1] Gives the name or the location of the school
[1] Says their favourite subject (e.g. Mi asignatura favorita es el inglés)
[1] Gives a reason (e.g. porque el profesor es simpático)
[1] Says what time lessons start (e.g. Las clases empiezan a las ocho)
[1] Says what they eat at lunchtime
[1] Asks a question about the friend's school (e.g. ¿Cómo es tu colegio?)
Language
[3] Vocabulary and grammar: 3 = mostly accurate with some variety of structures; 2 = generally accurate, simple structures; 1 = frequent errors, message still understood; 0 = not understandable
Organisation
[1] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 40 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$),
(7, $mq$[[Q 7 | D 12]]
Writing. A Spanish-speaking visitor is coming to your town or city. Write a short guide for them. Include: where your town or city is; two places to visit; the weather in summer; what the visitor can eat; one thing you are going to do together at the weekend.

Write 80 to 90 words in Spanish. (12 marks)

Total for Question 7: 12 marks$mq$, $mq$Content (1 mark each)
[1] Says where the town or city is
[1] Gives a first place to visit (e.g. Hay un castillo muy antiguo)
[1] Gives a second place to visit
[1] Describes the weather in summer (e.g. En verano hace calor)
[1] Says what the visitor can eat or drink (e.g. Puedes comer pescado con patatas)
[1] Says what they will do together at the weekend (e.g. El sábado vamos a ir al parque)
Language
[4] Vocabulary and grammar: 4 = mostly accurate with some variety of structures; 3 = generally accurate, simple structures; 2 = frequent errors, message still understood; 1 = very limited; 0 = not understandable
Organisation
[2] Clear sequence with linking words, a greeting/closing or title where appropriate; award 1 mark for partial control when 2 are available.
Writing below about 50 words: cap the language marks at 2. Accept any logical, original content. Ab initio writers are rewarded for clear, simple, mostly accurate language. Indicative Language Acquisition criterion D levels 1-8: 1-2 very limited, 3-4 basic but understandable, 5-6 mostly clear and accurate, 7-8 clear, varied and well organised.$mq$, $mq$D$mq$)
) as v(position, content, mark_scheme, criterion);


commit;
