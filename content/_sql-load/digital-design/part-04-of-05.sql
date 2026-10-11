-- Part 4 of 5: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Digital Products > Digital Media and Graphics
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Digital Products$mq$, 5, 3 from public.subjects s where s.slug = $mq$digital-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Digital Media and Graphics$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$digital-design$mq$ and p.grade = 5 and p.name = $mq$Digital Products$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Digital Media and Graphics$mq$ and p.name = $mq$Digital Products$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Which type of graphic is made of tiny coloured squares called pixels?$mq$, $mq$["Raster (bitmap)","Vector","3D model","Audio"]$mq$, 0, $mq$Raster images are grids of pixels. Vector graphics use mathematical shapes.$mq$, $mq$easy$mq$),
($mq$Which type of graphic stays sharp when enlarged to any size?$mq$, $mq$["Raster","Screenshot","Low-resolution photo","Vector"]$mq$, 3, $mq$Vector graphics are defined by shapes and paths, so they scale without losing quality.$mq$, $mq$easy$mq$),
($mq$What does RGB stand for?$mq$, $mq$["Red, grey, black","Rapid graphics base","Red, green, blue","Resolution, grid, brightness"]$mq$, 2, $mq$Screens create colours by mixing red, green and blue light.$mq$, $mq$easy$mq$),
($mq$Which file format is commonly used for photographs with small file sizes?$mq$, $mq$["SVG","JPEG","TXT","HTML"]$mq$, 1, $mq$JPEG uses lossy compression, which is good for photos.$mq$, $mq$easy$mq$),
($mq$What does 'frame rate' mean in video?$mq$, $mq$["The number of images shown per second","The width of the screen","The size of the sound file","The number of colours"]$mq$, 0, $mq$Frame rate is measured in frames per second (fps).$mq$, $mq$easy$mq$),
($mq$A video is 10 seconds long and runs at 24 frames per second. How many frames does it have?$mq$, $mq$["34","2.4","24","240"]$mq$, 3, $mq$24 × 10 = 240 frames.$mq$, $mq$medium$mq$),
($mq$A logo must be used on a business card and a billboard. Which format is best?$mq$, $mq$["Low-resolution JPEG","Small GIF","Vector (such as SVG)","Screenshot"]$mq$, 2, $mq$Vector scales to any size without becoming pixelated.$mq$, $mq$medium$mq$),
($mq$Which statement about lossy compression is correct?$mq$, $mq$["It restores all removed data","It reduces file size by permanently removing some data","It makes files larger","It only works on text"]$mq$, 1, $mq$Lossy formats (JPEG, MP3) discard some detail. Lossless formats (PNG) keep all data.$mq$, $mq$medium$mq$),
($mq$An image is 1920 × 1080 pixels. How many pixels does it contain?$mq$, $mq$["2 073 600","3000","207 360","20 736 000"]$mq$, 0, $mq$1920 × 1080 = 2 073 600 pixels.$mq$, $mq$medium$mq$),
($mq$Which format supports a transparent background for a logo on a web page?$mq$, $mq$["JPEG","MP3","DOC","PNG"]$mq$, 3, $mq$PNG supports transparency and lossless compression. JPEG does not support transparency.$mq$, $mq$medium$mq$),
($mq$A designer resizes a 400 × 300 pixel image to 1200 × 900 pixels. What is likely to happen?$mq$, $mq$["The image becomes a vector","The file size shrinks","The image looks blurry or pixelated","The image becomes sharper"]$mq$, 2, $mq$Enlarging a raster image stretches the existing pixels and loses sharpness.$mq$, $mq$medium$mq$),
($mq$Which action is cropping?$mq$, $mq$["Changing the colours","Removing unwanted outer parts of an image","Making the file a different type","Adding a border"]$mq$, 1, $mq$Cropping cuts away edges to improve composition.$mq$, $mq$medium$mq$),
($mq$A design must keep a 16:9 ratio. The width is 1280 pixels. What height is needed?$mq$, $mq$["720 pixels","640 pixels","900 pixels","1080 pixels"]$mq$, 0, $mq$1280 ÷ 16 = 80, and 80 × 9 = 720.$mq$, $mq$medium$mq$),
($mq$An image file is 6 MB and, after compression, is 1.5 MB. What is the percentage reduction?$mq$, $mq$["25%","4%","400%","75%"]$mq$, 3, $mq$The reduction is 6 − 1.5 = 4.5 MB. 4.5 ÷ 6 × 100 = 75%.$mq$, $mq$hard$mq$),
($mq$An uncompressed image is 800 × 600 pixels at 3 bytes per pixel. What is its size in bytes?$mq$, $mq$["480 000 bytes","14 400 bytes","1 440 000 bytes","4 800 000 bytes"]$mq$, 2, $mq$800 × 600 = 480 000 pixels. 480 000 × 3 = 1 440 000 bytes.$mq$, $mq$hard$mq$),
($mq$A website needs a quick-loading banner showing a photo. Which choice is most suitable?$mq$, $mq$["A large uncompressed bitmap","A JPEG compressed to suit screen size","A vector file of 100 MB","A video file"]$mq$, 1, $mq$A compressed JPEG gives acceptable quality with small size. Large files slow loading.$mq$, $mq$hard$mq$),
($mq$A poster designer uses an image copied from a website with no permission or credit. Which is the main issue?$mq$, $mq$["Copyright infringement and a failure to acknowledge the creator","The image has too many pixels","The image is a vector","The image has the wrong colour model"]$mq$, 0, $mq$Respecting copyright and giving credit are essential. Use licensed, free-to-use or self-created media.$mq$, $mq$hard$mq$),
($mq$A stereo audio clip of 10 seconds uses 44 100 samples per second, 16 bits per sample and 2 channels. What is its uncompressed size in bytes?$mq$, $mq$["882 000 bytes","14 112 000 bytes","176 400 bytes","1 764 000 bytes"]$mq$, 3, $mq$44 100 × 16 × 2 × 10 = 14 112 000 bits. Divide by 8 to get 1 764 000 bytes.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Digital Media and Graphics$mq$ and p.name = $mq$Digital Products$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Raster image$mq$, $mq$Made of pixels. Loses quality when enlarged. Photographs are raster.$mq$),
($mq$Vector graphic$mq$, $mq$Made of mathematical shapes. Scales to any size without losing quality.$mq$),
($mq$Lossy vs lossless$mq$, $mq$Lossy compression permanently removes data. Lossless keeps all data so the original can be restored.$mq$),
($mq$JPEG, PNG, GIF, SVG$mq$, $mq$JPEG: photos. PNG: lossless with transparency. GIF: 256 colours and simple animation. SVG: vector.$mq$),
($mq$RGB vs CMYK$mq$, $mq$RGB (light) is for screens. CMYK (ink) is for printing.$mq$),
($mq$Resolution$mq$, $mq$The number of pixels in an image, such as 1920 × 1080.$mq$),
($mq$Uncompressed image size$mq$, $mq$Pixels × bytes per pixel. 24-bit colour is 3 bytes per pixel.$mq$),
($mq$Frame rate$mq$, $mq$The number of video frames shown per second (fps).$mq$),
($mq$Aspect ratio$mq$, $mq$The ratio of width to height, for example 16:9.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Digital Media and Graphics$mq$ and p.name = $mq$Digital Products$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Raster and vector graphics
**Raster (bitmap) images** are grids of tiny squares called **pixels**, each with its own colour. Photographs are raster. When you enlarge a raster image, the pixels stretch and the image becomes blurry. **Vector graphics** use mathematical shapes, lines and curves, so they can be scaled to any size without losing quality. They are ideal for logos, icons and illustrations. Common formats: JPEG, PNG and GIF are raster. SVG is vector.

## Image file formats
- **JPEG**: good for photographs, small files, uses lossy compression, no transparency.
- **PNG**: lossless, supports transparency, good for logos and screenshots.
- **GIF**: up to 256 colours, supports simple animation.
- **SVG**: vector format for scalable graphics on the web.

**Lossy compression** removes some data permanently to make files smaller. **Lossless compression** keeps all data, so the original can be restored.

## Colour
Screens use the **RGB** model, mixing red, green and blue light. Printers use **CMYK** inks (cyan, magenta, yellow, key/black). Web colours are often written as hex codes such as #FF0000 for red. Colour choices should suit the audience and keep text readable.

## Resolution and size
**Resolution** is the number of pixels. An image 1920 × 1080 has 1920 × 1080 = 2 073 600 pixels. File size (uncompressed) = pixels × bytes per pixel. For 800 × 600 at 3 bytes per pixel: 480 000 × 3 = 1 440 000 bytes. **Aspect ratio** is the ratio of width to height. For 16:9 with width 1280, height = 1280 ÷ 16 × 9 = 720.

## Editing techniques
Cropping removes unwanted edges. Resizing changes dimensions (keep the aspect ratio to avoid stretching). Layers let you edit parts separately. Adjusting brightness and contrast improves the image. Always keep an original copy.

## Video and audio
Video is a series of still images called **frames** shown at a **frame rate** in frames per second. 24 fps for 10 seconds is 240 frames. Audio is **sampled**: the sample rate (samples per second), bit depth (bits per sample) and number of channels all affect quality and size. Size in bytes = rate × bits × channels × seconds ÷ 8. Formats such as MP3 use lossy compression.

## Percentage reduction
A 6 MB file compressed to 1.5 MB has been reduced by 4.5 MB. 4.5 ÷ 6 × 100 = 75%.

## Legal and ethical use
Respect **copyright** and licences, such as free-to-use or licences requiring credit. Create your own media or give clear credit. Do not edit images to mislead people.

## How this is examined
Typical items give a media context, such as an advert or a school video, and ask you to choose the right format, calculate pixel counts or file sizes, find a percentage reduction or identify the legal issue.

## Common mistakes
- Enlarging a small raster image and expecting it to stay sharp.
- Using JPEG where transparency is needed.
- Forgetting to divide by 8 to convert bits to bytes.
- Using other people's images without permission.

Exam tip: In calculation questions, write the formula first, substitute the numbers, then state the unit.$mq$ from st;

-- Technology and Society > Online Safety and Ethics
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Technology and Society$mq$, 5, 4 from public.subjects s where s.slug = $mq$digital-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Online Safety and Ethics$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$digital-design$mq$ and p.grade = 5 and p.name = $mq$Technology and Society$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Online Safety and Ethics$mq$ and p.name = $mq$Technology and Society$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is cyberbullying?$mq$, $mq$["Using technology to repeatedly hurt, threaten or embarrass someone","Playing an online game with friends","Reporting a rude message to a teacher","Updating an app's software"]$mq$, 0, $mq$Cyberbullying is deliberate, repeated harm carried out through digital tools such as messages, posts or games.$mq$, $mq$easy$mq$),
($mq$Which is the strongest password?$mq$, $mq$["password123","maya2010","qwerty","Tr@in-Purple-Lamp-47!"]$mq$, 3, $mq$Long passwords that mix unrelated words, numbers and symbols are hard to guess. The others are common or based on personal details.$mq$, $mq$easy$mq$),
($mq$What is phishing?$mq$, $mq$["A way of speeding up Wi-Fi","A type of video file","A fake message that tricks you into giving away private information","A backup method for photos"]$mq$, 2, $mq$Phishing messages pretend to come from a trusted source to steal passwords or personal details.$mq$, $mq$easy$mq$),
($mq$What does 'plagiarism' mean?$mq$, $mq$["Sharing a link with credit","Presenting someone else's work as your own","Editing your own work","Saving a file in two places"]$mq$, 1, $mq$Plagiarism is using another person's work or ideas without acknowledging them.$mq$, $mq$easy$mq$),
($mq$You receive a message from a stranger asking for your home address. What should you do first?$mq$, $mq$["Ignore it and tell a trusted adult","Reply with your street only","Send it if they say please","Post it publicly so they can find it"]$mq$, 0, $mq$Never share personal details with strangers. Telling a trusted adult and blocking the sender keeps you safe.$mq$, $mq$easy$mq$),
($mq$Aiko receives an email saying 'Your account will be closed in 1 hour! Click here to confirm your password.' The sender address is support@school-secure-login.biz. Which is the best response?$mq$, $mq$["Click the link quickly before time runs out","Reply with a different password","Forward it to all her classmates","Do not click; go to the real website yourself or ask the school IT team"]$mq$, 3, $mq$Urgency, a strange sender address and a request for a password are classic phishing signs. Checking via a trusted route is safest.$mq$, $mq$medium$mq$),
($mq$A student copies three paragraphs from a website into a report and does not name the source. Which action would make this ethical?$mq$, $mq$["Change the font","Put the paragraphs in the middle of the report","Quote or paraphrase them and include a citation and reference","Delete the title page"]$mq$, 2, $mq$Ethical use of sources means acknowledging the original author. Changing appearance or position does not fix plagiarism.$mq$, $mq$medium$mq$),
($mq$Which statement about two-factor authentication (2FA) is correct?$mq$, $mq$["It means using the same password twice","It asks for a second proof of identity, such as a code sent to a phone","It removes the need for any password","It only works on school computers"]$mq$, 1, $mq$2FA combines something you know (a password) with something you have (a code or device), so a stolen password alone is not enough.$mq$, $mq$medium$mq$),
($mq$Leo sees classmates sharing an embarrassing photo of another student in a group chat. Which response is most responsible?$mq$, $mq$["Do not share it, support the student and report it to a teacher or the platform","Add a laughing emoji","Forward it to a different group","Wait to see if more people share it"]$mq$, 0, $mq$A bystander who refuses to join in, supports the target and reports the content helps stop the harm.$mq$, $mq$medium$mq$),
($mq$A website address begins with 'https://' and shows a padlock. What does this tell you?$mq$, $mq$["The site is guaranteed to be honest","The site has no adverts","The site was made by a government","The connection is encrypted, but the site could still be misleading"]$mq$, 3, $mq$HTTPS protects data in transit. It does not prove the owners are trustworthy, and some scam sites also use it.$mq$, $mq$medium$mq$),
($mq$Which licence situation lets a student legally reuse an image in a school website with credit?$mq$, $mq$["The image is marked 'all rights reserved' with no permission","The image is found in a search result with no information","The image has a Creative Commons licence that allows reuse with attribution","The image was posted on social media"]$mq$, 2, $mq$Creative Commons licences state how a work can be reused. Without permission or a licence you should not copy an image.$mq$, $mq$medium$mq$),
($mq$Priya uses an AI tool to write her whole design report and submits it as her own work without saying so. Which ethical issue is most direct?$mq$, $mq$["Copyright of her own keyboard","Academic honesty, because she is claiming work she did not create","Screen time limits","Battery use"]$mq$, 1, $mq$Submitting generated work as your own misrepresents your learning and breaks academic honesty rules unless the use is permitted and acknowledged.$mq$, $mq$medium$mq$),
($mq$A free game asks for access to your contacts, microphone and location, none of which the game needs. What is the best decision?$mq$, $mq$["Deny the unnecessary permissions or choose a different app","Allow everything to be safe","Allow only if friends did","Allow and then delete the game"]$mq$, 0, $mq$Apps should only receive the permissions they need. Over-broad requests are a warning sign.$mq$, $mq$medium$mq$),
($mq$Which pair of actions best reduces the risk of a hacked account?$mq$, $mq$["Reuse one password and share it with a friend","Write passwords on a public post and change them yearly","Use short passwords so they are easy to type","Use a unique password for each account and turn on 2FA"]$mq$, 3, $mq$Unique passwords stop one breach spreading to other accounts, and 2FA adds a second barrier.$mq$, $mq$hard$mq$),
($mq$A team's app collects users' ages. A developer suggests, 'Let's also sell this data without telling users because it is not illegal everywhere.' Which evaluation is strongest?$mq$, $mq$["It is acceptable because the data is only numbers","It is acceptable if the app is free","It is unethical, because users have not given informed consent, even if the law is unclear","It is acceptable because other apps do it"]$mq$, 2, $mq$Ethics goes beyond what is legal. Hidden use of data breaks trust and informed consent.$mq$, $mq$hard$mq$),
($mq$An online quiz says 'Win a phone! Enter your full name, school, birthday and parents' bank details to claim.' Which two features make this most suspicious?$mq$, $mq$["It offers a prize and uses a quiz format","It asks for sensitive financial data and far more information than a prize needs","It mentions a phone and a school","It uses a colourful design"]$mq$, 1, $mq$Requests for bank details and unneeded personal data are a strong scam signal. A colourful design proves nothing.$mq$, $mq$hard$mq$),
($mq$Sam tells his friend Zoe her photo was posted by a fake account. Zoe replies, 'Let's post a fake account of them to get revenge.' Which evaluation is best?$mq$, $mq$["It would repeat the harm, risk breaking rules and is better handled by reporting and saving evidence","Revenge is fair because it is online","It is fine if no one knows who did it","It would only be wrong if they got caught"]$mq$, 0, $mq$Retaliation continues the cycle. Saving screenshots and reporting to the platform and a trusted adult is the effective, ethical route.$mq$, $mq$hard$mq$),
($mq$A designer must choose between a login screen that nudges users to share their location 'for the best experience' and one that clearly explains why location is needed and lets users decline. Which design is more ethical and why?$mq$, $mq$["The nudging one, because it collects more data","The nudging one, because it is faster","Neither, because location is always unethical","The explaining one, because it respects user choice and transparency"]$mq$, 3, $mq$Transparent design lets people make informed choices; manipulative 'dark patterns' undermine consent.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Online Safety and Ethics$mq$ and p.name = $mq$Technology and Society$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$What is phishing?$mq$, $mq$A fake message or site that pretends to be trusted in order to steal passwords or personal information.$mq$),
($mq$Two-factor authentication (2FA)$mq$, $mq$A login method that needs two proofs of identity, such as a password plus a code sent to your phone.$mq$),
($mq$What makes a strong password?$mq$, $mq$Long, unique for each account, mixing unrelated words, numbers and symbols, and not based on personal details.$mq$),
($mq$Plagiarism$mq$, $mq$Presenting another person's work or ideas as your own without acknowledging the source.$mq$),
($mq$Creative Commons licence$mq$, $mq$A licence that states how others may reuse a work, often with credit to the creator.$mq$),
($mq$Upstander$mq$, $mq$A person who helps when they see bullying, by supporting the target and reporting, instead of joining in or ignoring it.$mq$),
($mq$Dark pattern$mq$, $mq$A deceptive design trick that pushes users into choices they did not intend, such as hiding the decline button.$mq$),
($mq$What does https and a padlock show?$mq$, $mq$The connection is encrypted. It does not prove the website is honest or safe.$mq$),
($mq$Informed consent$mq$, $mq$Users agree to how their data is used after being told clearly and honestly what will happen.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Online Safety and Ethics$mq$ and p.name = $mq$Technology and Society$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Staying safe and acting ethically online are two sides of the same skill. Safety is about protecting yourself and others from harm. Ethics is about deciding what is the right thing to do, even when nobody is watching and even when something is easy to do.

## Common online risks
- **Cyberbullying**: using technology to repeatedly hurt, threaten, exclude or embarrass someone. Messages, group chats, edited photos and online games can all be used.
- **Phishing**: a fake email, text or website that pretends to be a trusted organisation to steal passwords or personal information. Warning signs include urgent wording, odd sender addresses, spelling mistakes and requests for passwords or bank details.
- **Malware**: harmful software such as viruses and spyware, often hidden in unknown downloads or attachments.
- **Scams and strangers**: prizes that are too good to be true, or people who ask for personal details, photos or money.

## Protecting yourself
- Use **strong passwords**: long, unique for every account, and not based on your name or birthday. A password manager can help you remember them.
- Turn on **two-factor authentication (2FA)**, which asks for a second proof such as a code sent to your phone.
- Check privacy settings and app permissions. An app should only get the permissions it really needs.
- Look at the web address. A padlock and https mean the connection is encrypted, but they do not prove the site is honest.
- Keep software updated, because updates repair security weaknesses.
- Do not share private information with strangers. If something feels wrong, stop, save evidence with screenshots, block the person and tell a trusted adult.

## Being a responsible digital citizen
An **upstander** helps instead of watching. If you see bullying, do not join in or forward the content. Support the person and report it to a teacher or the platform.

**Academic honesty** means that work you submit is truly yours or is properly acknowledged. **Plagiarism** is presenting another person's work or ideas as your own. In design projects you must cite images, code, music and text that you did not create, and follow the licence. A **Creative Commons** licence tells you how a work may be reused, usually with credit. If there is no licence or permission, do not copy. If you use an AI tool where it is allowed, you should say how you used it and still show your own thinking.

## Ethics in design
Designers make choices that affect real people. Ask these questions: Who could be harmed? Have users given informed **consent**? Is the product honest about what it does with data? Does it include people with different needs? **Dark patterns** are tricks that push users into choices they would not otherwise make, such as hiding the decline button. Ethical designs are transparent and respect user choice. Something being legal does not automatically make it ethical.

## Worked example
A team builds a homework app that records students' locations. Ethical questions: Is location needed? Have students and parents agreed? Where is the data stored and who can see it? If the answer to any of these is unclear, the design should be changed, for example by removing location tracking or making it optional and well explained.

## How this is examined
Questions usually give a short scenario, such as a suspicious email, an app asking for permissions or a student reusing an image. You are asked to identify the risk, apply a command term such as justify or evaluate, and recommend an action. The strongest answers name the issue, give a reason and consider the people affected.

Common mistakes: believing a padlock means a website is safe, treating legal and ethical as the same thing, and thinking that changing the wording of copied work removes plagiarism.

Exam tip: When asked to evaluate an online situation, name the risk, state who is affected, and recommend a specific action with a reason, not just 'be careful'.$mq$ from st;

-- Technology and Society > Digital Footprint and Privacy
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Technology and Society$mq$, 5, 4 from public.subjects s where s.slug = $mq$digital-design$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Digital Footprint and Privacy$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$digital-design$mq$ and p.grade = 5 and p.name = $mq$Technology and Society$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Digital Footprint and Privacy$mq$ and p.name = $mq$Technology and Society$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$What is a digital footprint?$mq$, $mq$["The trail of data you leave by using the internet","The size of your screen","A type of keyboard","A printed photograph"]$mq$, 0, $mq$Your digital footprint is all the information about you that exists because of your online activity.$mq$, $mq$easy$mq$),
($mq$Which is an example of an active digital footprint?$mq$, $mq$["A website recording your IP address","A cookie tracking pages you view","Your phone's location history made without you noticing","Posting a photo on a social media profile"]$mq$, 3, $mq$An active footprint is data you choose to share, such as posts and comments. Passive footprints are collected without you posting.$mq$, $mq$easy$mq$),
($mq$What is a cookie in web browsing?$mq$, $mq$["A virus that deletes files","A type of password","A small file a website stores to remember information about your visit","A pop-up advert"]$mq$, 2, $mq$Cookies remember things like login status or preferences, and some are used to track browsing across sites.$mq$, $mq$easy$mq$),
($mq$Which is personal data?$mq$, $mq$["The colour of the sky","Your full name and home address","The date of a public holiday","A school's opening hours"]$mq$, 1, $mq$Personal data identifies a specific person, such as a name, address, photo or ID number.$mq$, $mq$easy$mq$),
($mq$Which setting helps limit who can see your social media posts?$mq$, $mq$["Privacy settings","Screen brightness","Volume","Language"]$mq$, 0, $mq$Privacy settings let you choose whether posts are public, friends only or private.$mq$, $mq$easy$mq$),
($mq$Ravi posted a party photo publicly when he was 14. At 17 he applies for a work placement. What is the most likely risk?$mq$, $mq$["The photo will delete itself","His phone battery will drain","The photo will become smaller","The employer might find it and judge him"]$mq$, 3, $mq$Online content can last and be found later, so it can affect reputation and opportunities.$mq$, $mq$medium$mq$),
($mq$Which is a passive digital footprint?$mq$, $mq$["Writing a blog","Sending an email","A website logging your IP address and the pages you visited","Uploading a video"]$mq$, 2, $mq$Passive footprints are collected without you deliberately sharing, for example logs, cookies and location data.$mq$, $mq$medium$mq$),
($mq$A free app earns money by showing adverts matched to your interests. Which describes how this works?$mq$, $mq$["It guesses at random","It collects data about your behaviour to build a profile for targeting","It reads your thoughts","It copies your friends' passwords"]$mq$, 1, $mq$Many free services collect usage data to personalise adverts, so the data is part of the price.$mq$, $mq$medium$mq$),
($mq$Which action best reduces your digital footprint?$mq$, $mq$["Deleting old accounts you no longer use","Using the same username everywhere","Posting your location in real time","Accepting every cookie banner"]$mq$, 0, $mq$Fewer old accounts means less data stored about you and fewer places for it to be leaked.$mq$, $mq$medium$mq$),
($mq$Why is it a risk to post a photo that shows your school uniform, street sign and a time stamp?$mq$, $mq$["The photo will be too dark","It will not upload","It breaks copyright","It could reveal where you are and your routine"]$mq$, 3, $mq$Small details can be combined to work out where you go and when, which is a safety risk.$mq$, $mq$medium$mq$),
($mq$Before installing a new app, Maria reads the privacy policy. Which detail is most important to check?$mq$, $mq$["The colour of the logo","The number of downloads","What data is collected and whether it is shared with third parties","The font used"]$mq$, 2, $mq$A privacy policy should say what is collected, why, how long it is kept and who receives it.$mq$, $mq$medium$mq$),
($mq$Which situation is an example of an 'opt-in' consent?$mq$, $mq$["A box is already ticked to receive marketing emails","You tick an unticked box to agree to receive marketing emails","An app collects data after you simply open it","Data is collected whenever you visit any site"]$mq$, 1, $mq$Opt-in means the user takes a deliberate action to agree. Pre-ticked boxes are opt-out and weaker for privacy.$mq$, $mq$medium$mq$),
($mq$A user wants to browse without a record in their browser history on a shared school computer. Which choice helps most?$mq$, $mq$["Using a private or incognito window","Changing the desktop picture","Turning the sound off","Closing the lid"]$mq$, 0, $mq$Private windows do not save history or cookies on that device, but they do not hide activity from the school network or websites.$mq$, $mq$medium$mq$),
($mq$Tom says, 'Incognito mode makes me completely anonymous online.' Which reply is correct?$mq$, $mq$["True, nobody can see anything","True, but only on phones","False, it deletes his accounts","False, websites, his school network and his internet provider can still see activity"]$mq$, 3, $mq$Private mode only stops local storage of history and cookies. It does not hide your IP address or network activity.$mq$, $mq$hard$mq$),
($mq$A company stores users' names, birth dates and home addresses in one unprotected file and it is leaked. Which is the most serious consequence for users?$mq$, $mq$["The company's logo changes","Websites load faster","Identity theft and scams become more likely","The users' screens turn off"]$mq$, 2, $mq$Combined personal details make it easier for criminals to impersonate people or target them with convincing scams.$mq$, $mq$hard$mq$),
($mq$Two designers propose a sign-up form. Form A asks only for an email. Form B asks for email, birth date, address and phone number 'in case we need it later'. Which principle supports choosing Form A?$mq$, $mq$["Data growth: collect as much as possible","Data minimisation: only collect what is needed","Data decoration: make the form long","Data speed: ask for more to be quicker"]$mq$, 1, $mq$Data minimisation reduces risk, because information that is never collected cannot be leaked or misused.$mq$, $mq$hard$mq$),
($mq$An app says, 'By continuing you agree to our terms', with no way to decline settings. Which is the best evaluation from a privacy view?$mq$, $mq$["It is poor because users have no real choice or clear explanation of their data","It is good because it is quick","It is acceptable because users always read the terms","It is good because it hides the policy"]$mq$, 0, $mq$Meaningful consent needs clear information and a real choice. Forcing agreement weakens user control.$mq$, $mq$hard$mq$),
($mq$A student wants to check how much of their data is public. Which sequence of steps is the most effective?$mq$, $mq$["Delete their phone, then search nothing","Post more to hide old posts","Change their profile picture only","Search their own name, review privacy settings, then remove or hide anything they do not want public"]$mq$, 3, $mq$Searching yourself shows what others can find. Reviewing settings and removing content then reduces your public footprint.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Digital Footprint and Privacy$mq$ and p.name = $mq$Technology and Society$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Digital footprint$mq$, $mq$The trail of data you leave online, created by what you post and by what is collected about you.$mq$),
($mq$Active digital footprint$mq$, $mq$Data you deliberately share, such as posts, photos, comments and forms you fill in.$mq$),
($mq$Passive digital footprint$mq$, $mq$Data collected about you without you posting it, such as IP address, cookies, browsing history and location.$mq$),
($mq$Personal data$mq$, $mq$Information that identifies a person, such as name, address, photo, phone number, school or birth date.$mq$),
($mq$Cookie$mq$, $mq$A small file a website stores in your browser to remember information; some cookies track you across sites.$mq$),
($mq$Data minimisation$mq$, $mq$Collect only the data that is truly needed, so there is less to leak or misuse.$mq$),
($mq$Opt-in vs opt-out$mq$, $mq$Opt-in: the user takes action to agree. Opt-out: agreement is assumed and the user must act to refuse. Opt-in is better for privacy.$mq$),
($mq$What does incognito mode do?$mq$, $mq$It stops your browser saving history and cookies on that device. It does not hide your activity from websites or networks.$mq$),
($mq$Targeted advertising$mq$, $mq$Adverts chosen using a profile built from your online behaviour and data.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$digital-design$mq$ and t.grade = 5 and t.name = $mq$Digital Footprint and Privacy$mq$ and p.name = $mq$Technology and Society$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Every time you go online, you leave information behind. This trail is your **digital footprint**. It can follow you for years, and it shapes how apps, companies, schools and future employers see you. Understanding your footprint helps you control it.

## Active and passive footprints
- An **active digital footprint** is data you deliberately share: posts, comments, photos, videos, emails, forms you fill in and accounts you create.
- A **passive digital footprint** is data collected about you without you posting it: your IP address, the pages you visit, cookies, device details and location history.

Both kinds matter. Even if you never post, you still leave a passive footprint.

## What is personal data?
**Personal data** is information that identifies you or could be linked to you: your name, address, phone number, photos, school, birth date, account names and location. Small pieces can be combined. A school uniform, a street sign and a time stamp in one photo might reveal where you will be and when.

## How data is collected and used
- **Cookies** are small files that websites store in your browser. Some remember your login or language. Others track your behaviour across sites.
- Many free apps earn money from **targeted advertising**: they collect data about what you view and like, build a profile and show you matching adverts. The service may be free, but your data is the payment.
- Companies may share or sell data to third parties. A **privacy policy** should explain what is collected, why, how long it is kept and who receives it.
- If data is stored badly, it can be **leaked** in a breach. Criminals can use combined details for identity theft and convincing scams.

## Managing your privacy
- Review the **privacy settings** on every account and choose friends only or private where possible.
- Think before you post: once something is shared, others can copy it, and it may stay online permanently.
- Do not share real-time location publicly.
- Delete accounts you no longer use.
- Search for your own name to see what others can find.
- Use strong, unique passwords and 2FA.
- Be careful with permissions, and read key parts of privacy policies.

A **private or incognito window** stops your browser saving history and cookies on that device. It does not make you anonymous: websites, your school network and your internet provider can still see activity.

## Consent and design
Good privacy design follows **data minimisation**: collect only what is needed. **Opt-in** consent means a user takes a clear action to agree, such as ticking an empty box. **Opt-out** means the choice is already made and the user must act to stop it. Opt-in is better for privacy. Designers should also explain clearly, in plain language, why data is collected and give a real choice.

## Worked example
A homework app asks for name, email, home address, phone number and birth date. The app only needs an email and a year group to work. A privacy-aware redesign removes the extra fields, explains why the email is needed, and allows deletion of the account and data.

## How this is examined
Questions often show a scenario, such as a sign-up form, a social media profile or a privacy policy extract. You may be asked to identify the type of footprint, explain a risk, or justify improvements using ideas such as consent and minimisation. Strong answers link the data collected to a specific harm and to a specific fix.

Common mistakes: thinking deleting a post removes every copy, believing incognito means anonymous, and confusing active with passive footprints.

Exam tip: When you justify a privacy improvement, name the data, the risk it creates, and the change that reduces that risk.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('digital-design')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;