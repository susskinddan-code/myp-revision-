-- Part 3 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Computational Thinking > Data, Variables and Logic
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Computational Thinking$mq$, 5, 2 from public.subjects s where s.slug = $mq$digital-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Data, Variables and Logic$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$digital-design$mq$ and p.grade = 5 and p.name = $mq$Computational Thinking$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Data, Variables and Logic$mq$ and p.name = $mq$Computational Thinking$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which data type best stores the value 3.75?$mq$, $mq$["Float (decimal number)","Integer","Boolean","String only"]$mq$, 0, $mq$Decimal numbers are floats (real numbers). Integers are whole numbers.$mq$, $mq$easy$mq$),
($mq$A Boolean variable can hold which values?$mq$, $mq$["Any whole number","Any word","Any date","True or False"]$mq$, 3, $mq$Booleans have only two values, true or false, and are used in decisions.$mq$, $mq$easy$mq$),
($mq$Which is a string?$mq$, $mq$["42","3.14","'Hello'","True"]$mq$, 2, $mq$A string is text, usually inside quotes.$mq$, $mq$easy$mq$),
($mq$In binary, what is the value of 101?$mq$, $mq$["3","5","7","10"]$mq$, 1, $mq$Binary place values are 4, 2, 1. 4 + 0 + 1 = 5.$mq$, $mq$easy$mq$),
($mq$What is stored in the array list = [4, 8, 15] at index 0?$mq$, $mq$["4","8","15","0"]$mq$, 0, $mq$Most languages start indexing at 0, so the first item is at index 0.$mq$, $mq$easy$mq$),
($mq$What is the result of (5 > 3) AND (2 > 4)?$mq$, $mq$["True","5","Error","False"]$mq$, 3, $mq$The first part is true, the second is false. AND needs both parts to be true.$mq$, $mq$medium$mq$),
($mq$What is the result of (5 > 3) OR (2 > 4)?$mq$, $mq$["False","2","True","Error"]$mq$, 2, $mq$OR is true when at least one part is true. 5 > 3 is true.$mq$, $mq$medium$mq$),
($mq$A door opens if (cardValid AND NOT locked). cardValid = True, locked = False. What happens?$mq$, $mq$["The door stays shut","The door opens","An error occurs","The card is deleted"]$mq$, 1, $mq$NOT False is True. True AND True is True, so the door opens.$mq$, $mq$medium$mq$),
($mq$What is the decimal value of binary 1101?$mq$, $mq$["13","11","15","9"]$mq$, 0, $mq$8 + 4 + 0 + 1 = 13.$mq$, $mq$medium$mq$),
($mq$scores = [12, 7, 19, 3]. What does scores[2] give?$mq$, $mq$["7","3","12","19"]$mq$, 3, $mq$Index 0 is 12, index 1 is 7, index 2 is 19.$mq$, $mq$medium$mq$),
($mq$There are 17 students and groups of 5 are made. What is 17 MOD 5, and what is 17 DIV 5 (whole number division)?$mq$, $mq$["3 and 2","12 and 5","2 and 3","0 and 17"]$mq$, 2, $mq$17 = 3 × 5 + 2, so the quotient is 3 and the remainder (MOD) is 2.$mq$, $mq$medium$mq$),
($mq$Why should a registration form store a birth date as a date type rather than as a string?$mq$, $mq$["Strings are not allowed","Dates can be sorted and used in calculations such as age","Dates use less electricity","Strings can only hold numbers"]$mq$, 1, $mq$The correct data type allows correct validation, sorting and calculation.$mq$, $mq$medium$mq$),
($mq$One kilobyte is 1000 bytes. A text file is 4500 bytes. How many kilobytes is it?$mq$, $mq$["4.5 kB","45 kB","0.45 kB","450 kB"]$mq$, 0, $mq$4500 ÷ 1000 = 4.5 kB.$mq$, $mq$medium$mq$),
($mq$A pixel uses 24 bits for colour. An image is 100 × 100 pixels. What is the uncompressed size in bytes?$mq$, $mq$["240 000 bytes","10 000 bytes","2400 bytes","30 000 bytes"]$mq$, 3, $mq$100 × 100 = 10 000 pixels. 24 bits = 3 bytes, so 10 000 × 3 = 30 000 bytes.$mq$, $mq$hard$mq$),
($mq$The rule is: a user can post if (age ≥ 13 AND parentConsent) OR age ≥ 16. Which user can post?$mq$, $mq$["Age 14 without consent","Age 12 with consent","Age 14 with parent consent","Age 13 without consent"]$mq$, 2, $mq$Age 14 with consent satisfies the first part. Age 14 alone fails both, and age 12 fails the age conditions.$mq$, $mq$hard$mq$),
($mq$A programmer writes IF score > 50 AND score < 20. What is wrong?$mq$, $mq$["It always returns true","The condition can never be true","It uses too many variables","It cannot be a Boolean"]$mq$, 1, $mq$No number is both above 50 and below 20. The programmer probably needed OR.$mq$, $mq$hard$mq$),
($mq$A 3-bit binary number can represent how many different values, and what is the largest decimal value?$mq$, $mq$["8 values, largest is 7","3 values, largest is 3","6 values, largest is 6","8 values, largest is 8"]$mq$, 0, $mq$3 bits give 2 × 2 × 2 = 8 values from 0 to 7. The largest is 111 = 7.$mq$, $mq$hard$mq$),
($mq$A school database field 'ClassSize' must be a whole number between 1 and 35. Which input should be rejected?$mq$, $mq$["35","1","20","35.5"]$mq$, 3, $mq$A class size must be a whole number. 35.5 breaks the data type rule even though it is near the upper limit.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Data, Variables and Logic$mq$ and p.name = $mq$Computational Thinking$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Integer, float, string, Boolean$mq$, $mq$Whole number, decimal number, text, and True/False.$mq$),
($mq$Array / list$mq$, $mq$A variable holding several items, each reached by an index that usually starts at 0.$mq$),
($mq$AND$mq$, $mq$True only if both conditions are true.$mq$),
($mq$OR$mq$, $mq$True if at least one condition is true.$mq$),
($mq$NOT$mq$, $mq$Reverses a Boolean: NOT True is False.$mq$),
($mq$MOD and DIV$mq$, $mq$MOD gives the remainder, DIV gives the whole-number quotient. 17 MOD 5 = 2, 17 DIV 5 = 3.$mq$),
($mq$Binary place values$mq$, $mq$128, 64, 32, 16, 8, 4, 2, 1. Binary 1101 = 13.$mq$),
($mq$Bit and byte$mq$, $mq$A bit is one binary digit. A byte is 8 bits.$mq$),
($mq$Validation checks$mq$, $mq$Range, type, presence and length checks stop invalid data entering a program.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Data, Variables and Logic$mq$ and p.name = $mq$Computational Thinking$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Why data types matter
A program works with **data**, and the computer needs to know what kind of data each variable holds. This decides how it is stored, which operations are allowed and how it is checked. Choosing the right type is part of good design and helps avoid bugs.

## Common data types
- **Integer**: whole numbers, such as 15 or −3.
- **Float (real)**: numbers with decimals, such as 3.75.
- **String**: text, such as "Hello" or "Mia".
- **Boolean**: only True or False.
- **Date/time**: stored so that it can be sorted and used in calculations.

## Variables and arrays
A **variable** stores one value. An **array** (list) stores several values under one name, for example scores = [12, 7, 19, 3]. Each item has an **index**, and counting usually starts from 0. So scores[0] is 12 and scores[2] is 19. A **constant** is a value that does not change while the program runs, such as TAX_RATE.

## Operators and logic
Arithmetic: + − × ÷, **MOD** (remainder) and **DIV** (whole number division). For 17 and 5, 17 DIV 5 = 3 and 17 MOD 5 = 2.
Comparison: ==, !=, <, >, <= and >=. These give True or False.
**Logical operators** combine conditions:
- **AND** is true only if both parts are true.
- **OR** is true if at least one part is true.
- **NOT** reverses a Boolean value.

Example: a door opens if cardValid AND NOT locked. If cardValid is True and locked is False, NOT locked is True, so the door opens. A truth table lists every case. For AND: True AND True is True, and all other combinations are False. For OR: only False OR False is False.

## Binary and data size
Computers use **binary** (base 2). Place values are 128, 64, 32, 16, 8, 4, 2, 1. Binary 1101 = 8 + 4 + 0 + 1 = 13. A **bit** is one binary digit and 8 bits make a **byte**. n bits can represent 2 to the power n values, so 3 bits give 8 values (0 to 7). Typical units: 1 kB = 1000 bytes. Image size in bytes = number of pixels × bytes per pixel. For a 100 × 100 image with 24 bits (3 bytes) per pixel: 10 000 × 3 = 30 000 bytes. Compression reduces file size.

## Validation and data quality
A good program checks data. A **range check** makes sure a value is between limits. A **type check** makes sure it is the correct type. A **presence check** makes sure it is not empty. A **length check** limits the number of characters. For example, a class size must be a whole number from 1 to 35, so 35.5 is rejected because of its type even though it is near the limit.

## How this is examined
Questions give a context such as an app sign-up rule or an image file, and ask you to evaluate Boolean expressions, convert binary, calculate data size or decide which data type or validation check is appropriate.

## Common mistakes
- Forgetting that indexes start at 0.
- Mixing up AND and OR.
- Confusing a bit with a byte.
- Storing phone numbers as numbers when leading zeros matter, so a string is better.

Exam tip: For logic questions, evaluate each bracket separately, write True or False beside it, then combine them.$mq$ from st;

-- Digital Products > User Interfaces and Experience
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Digital Products$mq$, 5, 3 from public.subjects s where s.slug = $mq$digital-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$User Interfaces and Experience$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$digital-design$mq$ and p.grade = 5 and p.name = $mq$Digital Products$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$User Interfaces and Experience$mq$ and p.name = $mq$Digital Products$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What does UI stand for?$mq$, $mq$["User interface","Universal internet","Unique installation","Updated information"]$mq$, 0, $mq$The user interface is what the user sees and interacts with: buttons, menus, text and images.$mq$, $mq$easy$mq$),
($mq$What does UX stand for?$mq$, $mq$["User exchange","Universal extension","Unit examination","User experience"]$mq$, 3, $mq$UX is how a person feels and performs when using a product, including how easy it is to use.$mq$, $mq$easy$mq$),
($mq$Which feature makes text easier to read?$mq$, $mq$["Light grey text on white","Tiny fonts","Strong contrast between text and background","Busy patterned backgrounds"]$mq$, 2, $mq$High contrast helps readability, particularly for users with low vision.$mq$, $mq$easy$mq$),
($mq$What is 'navigation' in an app?$mq$, $mq$["The speed of the battery","The way users move between screens and find content","The price of the product","The size of the phone"]$mq$, 1, $mq$Clear navigation, such as menus and back buttons, helps users find things.$mq$, $mq$easy$mq$),
($mq$Why do designers use consistent buttons and icons across an app?$mq$, $mq$["Users learn the pattern once and can predict what things do","It makes the app load slower","It hides bugs","It saves battery only"]$mq$, 0, $mq$Consistency reduces the effort of learning and avoids confusion.$mq$, $mq$easy$mq$),
($mq$A user taps 'Submit' and nothing visible happens, so they tap it five times. Which design principle is missing?$mq$, $mq$["Colour variety","Longer text","More menus","Feedback showing the action was received"]$mq$, 3, $mq$Systems should give clear feedback such as a message or loading indicator.$mq$, $mq$medium$mq$),
($mq$A form deletes an account with one tap and no warning. Which improvement is best?$mq$, $mq$["Make the delete button smaller","Remove all text from the page","Add a confirmation message before deleting","Make the delete button red only"]$mq$, 2, $mq$Error prevention is an important usability principle: confirm destructive actions.$mq$, $mq$medium$mq$),
($mq$Which choice best supports accessibility for users who cannot see images?$mq$, $mq$["Using larger images","Adding descriptive alternative text (alt text) to images","Using only photographs","Turning off sound"]$mq$, 1, $mq$Screen readers read alt text aloud, so the meaning of the image is not lost.$mq$, $mq$medium$mq$),
($mq$In an A/B test, version A gets 12 sign-ups from 200 visitors and version B gets 18 sign-ups from 200 visitors. What are the conversion rates?$mq$, $mq$["A is 6% and B is 9%","A is 9% and B is 6%","A is 12% and B is 18%","Both are 10%"]$mq$, 0, $mq$12 ÷ 200 = 6%. 18 ÷ 200 = 9%. Version B performed better.$mq$, $mq$medium$mq$),
($mq$Which layout is best for a thumb-operated phone app?$mq$, $mq$["Tiny links at the top corners","Buttons spaced only 1 pixel apart","Icons without any labels","Important buttons large and within easy reach at the lower part of the screen"]$mq$, 3, $mq$Large, well-spaced touch targets reduce mistakes.$mq$, $mq$medium$mq$),
($mq$Why is it poor design to use red and green alone to show 'error' and 'success'?$mq$, $mq$["Red and green are not allowed","Colours slow the device","Users with colour-vision deficiency may not see the difference","Only text can show success"]$mq$, 2, $mq$Add icons or words so meaning does not rely only on colour.$mq$, $mq$medium$mq$),
($mq$Which statement describes 'white space' in a layout?$mq$, $mq$["A wasted area that must be filled","Empty space that separates items and makes the screen easier to scan","The white colour only","A bug in the design"]$mq$, 1, $mq$White space (negative space) improves readability and focus.$mq$, $mq$medium$mq$),
($mq$A usability test finds 6 of 10 participants cannot find the settings page. What is the best conclusion?$mq$, $mq$["The navigation to settings needs redesign","Users need more training","Ten users is too many","Settings are not important"]$mq$, 0, $mq$If most users fail at a task, the design is likely the problem, not the users.$mq$, $mq$medium$mq$),
($mq$A designer reduces the number of taps to book a ticket from 6 to 4. Assuming each tap takes 2 seconds, what is the time saved per booking?$mq$, $mq$["2 seconds","6 seconds","12 seconds","4 seconds"]$mq$, 3, $mq$Taps saved = 2. 2 × 2 seconds = 4 seconds.$mq$, $mq$hard$mq$),
($mq$Two checkout designs were tested with 50 users each. Design 1: 40 completed. Design 2: 45 completed. What is the difference in completion rate?$mq$, $mq$["5 percentage points","10%","10 percentage points","45 percentage points"]$mq$, 2, $mq$Design 1 is 80% and Design 2 is 90%. The difference is 10 percentage points.$mq$, $mq$hard$mq$),
($mq$A designer adds 15 menu options to the home screen of an app 'so users have choice'. What is the most likely UX problem?$mq$, $mq$["The app will not install","Too many options make it harder and slower to choose","The app will use less data","Users will read more slowly in dark mode"]$mq$, 1, $mq$Too many choices cause overload. Grouping and prioritising options improves usability.$mq$, $mq$hard$mq$),
($mq$Which approach best balances a visually rich design with accessibility?$mq$, $mq$["Use attractive images but provide alt text, sufficient contrast and keyboard-friendly controls","Remove all images","Make every element animated","Hide the menu to look cleaner"]$mq$, 0, $mq$Good design meets both aesthetic and accessibility needs.$mq$, $mq$hard$mq$),
($mq$A user-centred designer finds that older users cannot read 12 pixel text. What should they do?$mq$, $mq$["Ask users to buy glasses","Reduce contrast","Remove the text","Increase text size and test again with older users"]$mq$, 3, $mq$User-centred design adapts to users and tests the change.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$User Interfaces and Experience$mq$ and p.name = $mq$Digital Products$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$UI$mq$, $mq$User interface: the visible parts a user interacts with, such as buttons, menus and layout.$mq$),
($mq$UX$mq$, $mq$User experience: how easy, efficient and pleasant a product is to use.$mq$),
($mq$Consistency$mq$, $mq$Using the same patterns throughout a product so users can predict what things do.$mq$),
($mq$Feedback$mq$, $mq$A visible response to an action, such as a message, tick or loading icon.$mq$),
($mq$Accessibility$mq$, $mq$Designing so people with different abilities can use the product, e.g. alt text and good contrast.$mq$),
($mq$Alt text$mq$, $mq$A written description of an image for screen readers.$mq$),
($mq$White space$mq$, $mq$Empty space that separates content and improves readability.$mq$),
($mq$Usability testing$mq$, $mq$Watching users complete tasks to find problems in a design.$mq$),
($mq$A/B test$mq$, $mq$Comparing two versions of a design to see which performs better.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$User Interfaces and Experience$mq$ and p.name = $mq$Digital Products$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## UI and UX
The **user interface (UI)** is everything the user sees and touches: layouts, buttons, menus, icons, text, colours and images. The **user experience (UX)** is the overall feeling and effectiveness of using the product. A beautiful interface can still have poor UX if people cannot complete tasks. Good designers think about both, always starting with the needs of the target audience from Criterion A.

## Core design principles
- **Consistency**: use the same patterns for buttons, icons, colours and positions, so users can predict what happens.
- **Feedback**: show the user that an action worked, for example a loading spinner, a tick or a message.
- **Clear navigation**: users should always know where they are and how to get back. Menus should be simple and logically grouped.
- **Hierarchy**: size, colour and position show what is most important. Headings are bigger than body text.
- **White space**: empty areas separate content and make screens easy to scan.
- **Error prevention**: warn before destructive actions, such as deleting an account, and validate input.
- **Simplicity**: too many options slow people down. Group, prioritise and hide advanced features.

## Accessibility
Good products work for as many people as possible. Examples:
- **Contrast** between text and background. Light grey text on white is hard to read.
- **Alt text** on images so screen readers can describe them.
- **Not relying on colour alone**, since some people have colour-vision deficiency. Add words or icons.
- **Text that can be resized** and large touch targets for people with limited dexterity.
- **Captions** for video and **keyboard** access for people who cannot use a mouse.

## Colour, fonts and layout
Choose a colour palette that fits the audience and purpose and keep it consistent. Limit the number of fonts, usually to two. Align items on a grid. Group related items together (proximity). On mobile, place important controls within thumb reach and use large touch targets.

## Testing a UX
**Usability testing** watches real users complete set tasks. Measure the time taken, number of errors and number who succeed. An **A/B test** compares two versions. Example: version A gets 12 sign-ups from 200 visitors (6%) and version B gets 18 from 200 (9%), so B is better. When comparing percentages, say percentage points for the difference: 9% − 6% = 3 percentage points.

## Worked example
Design 1: 40 of 50 users complete checkout, which is 80%. Design 2: 45 of 50, which is 90%. The difference is 10 percentage points. Design 2 meets a 90% criterion and design 1 does not.

## How this is examined
Scenarios present a screen or short description and ask you to identify the principle broken, suggest the best improvement, interpret simple test data, or evaluate whether a design is accessible. Command terms: identify, suggest, justify, evaluate.

## Common mistakes
- Using decoration that distracts from the task.
- Hiding key functions in unclear icons.
- Testing only with the designer's friends.
- Saying a design is "user-friendly" without evidence.

Exam tip: Name the principle and then give a specific change. Example: "Add a confirmation message before deleting, to prevent accidental loss of data."$mq$ from st;

-- Digital Products > Websites and Apps
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Digital Products$mq$, 5, 3 from public.subjects s where s.slug = $mq$digital-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Websites and Apps$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$digital-design$mq$ and p.grade = 5 and p.name = $mq$Digital Products$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Websites and Apps$mq$ and p.name = $mq$Digital Products$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which language gives a web page its structure and content?$mq$, $mq$["HTML","CSS","Python","SQL"]$mq$, 0, $mq$HTML marks up headings, paragraphs, images and links. CSS styles them.$mq$, $mq$easy$mq$),
($mq$Which language is mainly used to style a web page (colours, fonts, layout)?$mq$, $mq$["HTML","SQL","Java","CSS"]$mq$, 3, $mq$CSS controls the presentation of HTML elements.$mq$, $mq$easy$mq$),
($mq$What does the 's' in https mean?$mq$, $mq$["The site is slow","The site is stored on a school server","The connection is secure and encrypted","The site is for students only"]$mq$, 2, $mq$HTTPS encrypts data between browser and server, protecting information such as passwords.$mq$, $mq$easy$mq$),
($mq$What is a URL?$mq$, $mq$["A type of virus","The web address of a page","A programming error","A file compressor"]$mq$, 1, $mq$A URL such as https://example.com/page identifies the location of a resource.$mq$, $mq$easy$mq$),
($mq$What does a responsive website do?$mq$, $mq$["Adjusts its layout to fit different screen sizes","Responds to emails","Plays music by default","Works only offline"]$mq$, 0, $mq$Responsive design lets the same site work on phones, tablets and computers.$mq$, $mq$easy$mq$),
($mq$Which HTML tag creates a hyperlink?$mq$, $mq$["<link rel>","<h1>","<img>","<a href='page.html'>"]$mq$, 3, $mq$The anchor tag <a> with an href attribute links to another page. <img> displays an image.$mq$, $mq$medium$mq$),
($mq$Which code adds an image with alternative text?$mq$, $mq$["<img alt='logo.png'>","<image 'School logo'>","<img src='logo.png' alt='School logo'>","<pic src alt>"]$mq$, 2, $mq$<img> needs src for the file and alt for the description.$mq$, $mq$medium$mq$),
($mq$What is the main difference between a web app and a native app?$mq$, $mq$["Web apps cannot use the internet","A web app runs in a browser, but a native app is installed for a specific operating system","Native apps are never fast","Native apps are written in HTML only"]$mq$, 1, $mq$Native apps are installed from a store. Web apps are accessed through a browser.$mq$, $mq$medium$mq$),
($mq$A page includes a 2 MB image and loads on a connection of 8 megabits per second. About how long does that image take to download (1 byte = 8 bits)?$mq$, $mq$["2 seconds","16 seconds","0.25 seconds","8 seconds"]$mq$, 0, $mq$2 MB = 16 megabits. 16 ÷ 8 = 2 seconds.$mq$, $mq$medium$mq$),
($mq$Why do designers compress images for websites?$mq$, $mq$["To make them more colourful","To make them private","To stop them being copied","To reduce load time and data use"]$mq$, 3, $mq$Smaller files load faster, which helps users on slow connections or limited data.$mq$, $mq$medium$mq$),
($mq$Which is the best use of a site map in planning?$mq$, $mq$["Showing the colour palette","Recording survey answers","Showing how pages connect so navigation is logical","Testing passwords"]$mq$, 2, $mq$A site map is a plan of pages and links, and helps design navigation.$mq$, $mq$medium$mq$),
($mq$What does the client–server model mean?$mq$, $mq$["Two clients share one keyboard","A client such as a browser asks a server for pages or data, and the server responds","A server is the same as a screen","Clients never send information"]$mq$, 1, $mq$The browser requests resources and the server sends them back.$mq$, $mq$medium$mq$),
($mq$A mobile website's menu is hidden behind a three-line icon on small screens. What is the design technique?$mq$, $mq$["Responsive design with a collapsible menu","Encryption","A firewall","Data validation"]$mq$, 0, $mq$Responsive layouts change on small screens. The 'hamburger' icon saves space.$mq$, $mq$medium$mq$),
($mq$A shop website works on a desktop but text overflows on a phone. Which CSS idea best fixes it?$mq$, $mq$["Use fixed widths of 1200 pixels","Remove all CSS","Use only images of text","Use flexible layouts and media queries for small screens"]$mq$, 3, $mq$Media queries and flexible units let the layout adapt. Fixed widths cause overflow.$mq$, $mq$hard$mq$),
($mq$A designer wants search engines to understand a page. Which action best supports this?$mq$, $mq$["Hiding text in the background colour","Using only images for all text","Using clear headings, descriptive page titles and alt text","Using one long paragraph"]$mq$, 2, $mq$Search engines read structure and text. Meaningful headings and titles help both people and search tools.$mq$, $mq$hard$mq$),
($mq$An app stores user scores in a database on a server. A user is offline. Which design best supports this?$mq$, $mq$["Refuse to start the app","Save scores locally and sync them when the connection returns","Delete the scores","Ask the user to move to another country"]$mq$, 1, $mq$Offline support stores data on the device and syncs later, improving usability.$mq$, $mq$hard$mq$),
($mq$A website asks users to enter their email on a page that starts with http:// not https://. What is the main risk?$mq$, $mq$["Data could be intercepted because it is not encrypted","The page will be blank","The email will be deleted","The page will look different"]$mq$, 0, $mq$Without HTTPS, data travels unencrypted and could be read by others on the network.$mq$, $mq$hard$mq$),
($mq$A designer must choose between a web app and a native app for a school club with students using many different devices. Which is the best reason to choose a web app?$mq$, $mq$["Web apps always run faster","Web apps use no internet","Native apps cannot be updated","It works in browsers on all devices without separate versions for each system"]$mq$, 3, $mq$A single web app reaches many devices. Native apps may offer better performance but require separate versions.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Websites and Apps$mq$ and p.name = $mq$Digital Products$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$HTML$mq$, $mq$Markup language that gives a web page its structure and content.$mq$),
($mq$CSS$mq$, $mq$Language that styles a web page: colours, fonts, spacing and layout.$mq$),
($mq$JavaScript$mq$, $mq$Programming language that adds behaviour and interactivity to web pages.$mq$),
($mq$HTTPS$mq$, $mq$Secure version of HTTP that encrypts data between browser and server.$mq$),
($mq$Client–server model$mq$, $mq$A client (browser) requests resources and a server responds.$mq$),
($mq$Responsive design$mq$, $mq$Layout that adapts to different screen sizes using flexible grids and media queries.$mq$),
($mq$Web app vs native app$mq$, $mq$Web apps run in a browser on many devices. Native apps are installed for a specific operating system.$mq$),
($mq$Site map$mq$, $mq$A diagram of pages and links used to plan website navigation.$mq$),
($mq$Download time$mq$, $mq$File size in bits ÷ speed in bits per second. 1 byte = 8 bits.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Websites and Apps$mq$ and p.name = $mq$Digital Products$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## How the web works
A **website** is a collection of linked pages stored on a **server**. Your **browser** (the client) sends a request using a **URL**, and the server sends back files. **HTTPS** encrypts the connection, which protects data such as passwords. This is the **client–server model**.

## The three core languages
- **HTML** (HyperText Markup Language) gives structure and content: headings (<h1>), paragraphs (<p>), links (<a href>), images (<img src alt>) and lists.
- **CSS** (Cascading Style Sheets) controls appearance: colours, fonts, spacing and layout.
- **JavaScript** adds behaviour: menus that open, form checks, animations and updating content without reloading.

Example: <img src="logo.png" alt="School logo"> shows an image and gives screen readers a description.

## Planning a site or app
Use a **site map** to show pages and how they connect. Use **wireframes** for each page. Plan the navigation so key pages are only a few clicks away. Keep a consistent header, menu and footer. These support Criterion B.

## Responsive design
People use phones, tablets and computers. **Responsive design** makes the layout adjust. Techniques include flexible grids, images that scale and **media queries** that change the layout at certain widths. On small screens menus often collapse into a three-line "hamburger" icon. A mobile-first approach designs for the smallest screen first.

## Web apps and native apps
A **web app** runs in a browser and works on many devices. A **native app** is installed for a specific system (such as iOS or Android) and can use device features like the camera more directly, but needs separate versions. Choose based on the audience, devices and features needed.

## Performance
Pages should load quickly. Large images are the most common problem. Compress images and use the right size. Download time = file size in bits ÷ speed in bits per second. A 2 MB image is 16 megabits, so on an 8 megabit-per-second connection it takes 16 ÷ 8 = 2 seconds. Remember that 1 byte = 8 bits.

## Databases and data
Many sites and apps store data in a **database** on a server: user accounts, scores and products. For offline use, an app can store data locally and sync later.

## Security basics
Use HTTPS, validate user input, use strong passwords and ask only for the data you really need.

## Search visibility
Clear headings, meaningful page titles and alt text help people and search engines understand a page.

## How this is examined
Scenarios involve a school or business website or app. Questions ask you to identify the role of HTML, CSS or JavaScript, choose responsive features, calculate a download time, or compare web and native apps for a given audience.

## Common mistakes
- Mixing up the jobs of HTML and CSS.
- Forgetting alt text.
- Using fixed widths that break on phones.
- Confusing bits and bytes.

Exam tip: For web-versus-native questions, link your choice to the audience and devices given in the scenario.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('digital-design')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;