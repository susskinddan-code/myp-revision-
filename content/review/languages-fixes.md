# Language content accuracy review: fixes

Scope: content/french-ab-initio-myp5, spanish-ab-initio-myp5, mandarin-ab-initio-myp5, french-language-and-literature-myp5, spanish-language-and-literature-myp5 (129 sub-topics, 2,322 questions, 1,161 flashcards, 129 notes read in full).

Every fix is applied in place in the JSON (schema, 18 questions, 9 flashcards and numeric answer indices unchanged). `languages-fixes.sql` applies the same changes to the live database.

## 1. french-ab-initio-myp5/01-greetings-and-introductions.json

- Sub-topic: Greetings and Introductions > Greetings and Farewells
- Item: Q16 (explanation): Which pair of sentences is correct for speaking to your headteacher?
- Before: Only option B stays formal throughout: 'Bonjour' and 'vous'.
- After: Only 'Bonjour, Madame. Comment allez-vous ?' stays formal throughout: 'Bonjour' and 'vous'.
- Why: explanation cites an option letter; DB reorders options

## 2. french-ab-initio-myp5/01-greetings-and-introductions.json

- Sub-topic: Greetings and Introductions > Introducing Yourself and Others
- Item: Q14 (explanation): Read this email extract: 'Je m'appelle Marc Lambert. Je suis suisse et j'habite à Genève a...
- Before: We are not told where Noah lives, so B cannot be assumed.
- After: We are not told where Noah lives, so 'Noah lives in Geneva' cannot be assumed.
- Why: explanation cites an option letter

## 3. french-ab-initio-myp5/04-school-and-work.json

- Sub-topic: School and Work > School Subjects and Objects
- Item: Study note
- Before: Une journée à l'école is written as an emploi du temps (timetable). You will read
- After: A school week is set out in an emploi du temps (timetable). You will read
- Why: garbled/unidiomatic sentence

## 4. french-ab-initio-myp5/04-school-and-work.json

- Sub-topic: School and Work > Classroom Language and Instructions
- Item: Q15 (explanation): A teacher says to one pupil: “Ferme la fenêtre, Léo.” Now she gives the same instruction t...
- Before: For a group the command ends in -ez. Fermes is a wrong spelling, and fermons means let us close.
- After: For a group the command ends in -ez. 'Fermes' is the tu form of the present tense, not a command (the tu command is 'ferme'), and 'fermons' means let us close.
- Why: imprecise grammar claim

## 5. french-ab-initio-myp5/06-town-and-travel.json

- Sub-topic: Town and Travel > Transport and Holidays
- Item: Study note
- Before: Saying "en pied" instead of "à pied", or "à bus" instead of "en bus", or "à bus" instead of "en bus".
- After: Saying "en pied" instead of "à pied", or "à bus" instead of "en bus".
- Why: duplicated phrase in note

## 6. spanish-ab-initio-myp5/01-greetings-and-introductions.json

- Sub-topic: Greetings and Introductions > Greetings and Farewells
- Item: Q12 (content): Listening transcript:

Profesor: Buenos días, Marta. ¿Cómo estás hoy?
Alumna: Buenos días,...
- Before: Profesor: Buenos días, Marta. ¿Cómo está usted hoy?
- After: Profesor: Buenos días, Marta. ¿Cómo estás hoy?
- Why: teacher would address a pupil with tú, not usted

## 7. spanish-ab-initio-myp5/04-school-and-work.json

- Sub-topic: School and Work > Classroom Language and Instructions
- Item: Q11 (content): Read the notice.
'Prohibido usar el móvil en clase. Los móviles deben estar en la mochila....
- Before: 'Prohibido usar el móvil en clase. Los móviles están en la mochila.'
- After: 'Prohibido usar el móvil en clase. Los móviles deben estar en la mochila.'
- Why: notice stated a fact rather than a rule; question asks where phones must be kept

## 8. spanish-ab-initio-myp5/04-school-and-work.json

- Sub-topic: School and Work > Classroom Language and Instructions
- Item: Q11 (explanation): Read the notice.
'Prohibido usar el móvil en clase. Los móviles deben estar en la mochila....
- Before: Los móviles están en la mochila means that the phones are in the backpack.
- After: Los móviles deben estar en la mochila means that phones must be kept in the backpack.
- Why: matches fixed notice

## 9. spanish-language-and-literature-myp5/02-language-devices.json

- Sub-topic: Language Devices > Sound and Rhythm
- Item: Q7 (explanation): Dos versos inventados: «La luna cuenta al viento su cuento / mientras duerme el sendero le...
- Before: «viento» y «lento» coinciden en todos los sonidos desde la vocal tónica: -ento.
- After: «cuento» y «lento», las palabras finales de los versos, coinciden en todos los sonidos desde la vocal tónica: -ento.
- Why: Explanation named viento/lento but the rhyming end words are cuento/lento

## 10. spanish-language-and-literature-myp5/07-grammar-and-accuracy.json

- Sub-topic: Grammar and Accuracy > Verb Tenses and Moods
- Item: Q6 (options): Completa: «Esta mañana ___ fruta para desayunar».
- Before: Options: he desayunado | desayuné | desayunaba | desayunaré (correct: he desayunado)
- After: Options: he tomado | tomara | tomaba | tomaré (correct: he tomado)
- Why: Stem already contains "desayunar" (he desayunado ... para desayunar is redundant) and desayuné is correct in Latin American Spanish, so the answer was not unique

