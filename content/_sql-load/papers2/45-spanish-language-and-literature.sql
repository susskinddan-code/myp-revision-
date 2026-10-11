-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Spanish Language & Literature MYP 5 eAssessment-style Practice Paper 1 (44 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish Language & Literature MYP 5 eAssessment-style Practice Paper 1$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish Language & Literature MYP 5 eAssessment-style Practice Paper 1$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Texto A (un fragmento de un cuento, escrito para esta prueba)

El sábado, la plaza de Santa Lucía olía a churros y a lluvia reciente. Mateo llevaba veinte minutos sentado en el borde de la fuente, fingiendo mirar el móvil, aunque la pantalla estaba apagada desde hacía rato. Al otro lado de la plaza, la furgoneta de mudanzas estaba ya casi cargada.

Había pensado en mil maneras de decirlo: una broma, un abrazo, una carta. Pero cada plan se le desmoronaba al llegar a la plaza, como un castillo de arena cuando sube la marea, y ahora ya no recordaba ni cómo empezaba la primera frase.

El camarero de la churrería salió a barrer el toldo y lo miró un segundo. Mateo pensó que era respeto: la manera en que la gente mira a un chico solo y decide no meterse.

Entonces se abrió la puerta del portal. Iván cruzó la plaza con una caja de cartón en los brazos y se detuvo frente a la fuente. Durante un instante ninguno dijo nada. En la caja, entre cables y cuadernos, asomaba el balón de fútbol que los dos habían firmado el verano anterior.

—Pensaba dejártelo en el buzón —dijo Iván por fin—. No sabía cómo dártelo en persona.

Mateo cogió el balón. Pesaba más de lo que recordaba, o quizá lo que pesaba era el silencio. A su espalda, las campanas de la iglesia dieron las doce, y le pareció que contaban algo más que las horas.

Lee el texto A y contesta a las preguntas.

(a) Señala dos detalles del primer párrafo que muestran que Mateo está nervioso o no sabe qué hacer. (2 marks)

(b) Explica qué sugiere el texto sobre los sentimientos de Mateo ante la despedida. (2 marks)$mq$, $mq$(a)
[1] One relevant detail from the first paragraph, e.g. lleva veinte minutos sentado en la fuente; finge mirar el móvil con la pantalla apagada; la furgoneta de mudanzas ya está casi cargada (time is running out).
[1] A second, different relevant detail.
(b)
[1] A valid inference, e.g. Mateo is anxious and sad, and wants to say goodbye but does not know how.
[1] Supported by a reference, e.g. «cada plan se le desmoronaba»; «ya no recordaba ni cómo empezaba la primera frase»; he is described as «un chico solo».
Accept other valid inferences supported by the text.$mq$, $mq$A$mq$),
(2, $mq$Texto A (un fragmento de un cuento, escrito para esta prueba)

El sábado, la plaza de Santa Lucía olía a churros y a lluvia reciente. Mateo llevaba veinte minutos sentado en el borde de la fuente, fingiendo mirar el móvil, aunque la pantalla estaba apagada desde hacía rato. Al otro lado de la plaza, la furgoneta de mudanzas estaba ya casi cargada.

Había pensado en mil maneras de decirlo: una broma, un abrazo, una carta. Pero cada plan se le desmoronaba al llegar a la plaza, como un castillo de arena cuando sube la marea, y ahora ya no recordaba ni cómo empezaba la primera frase.

El camarero de la churrería salió a barrer el toldo y lo miró un segundo. Mateo pensó que era respeto: la manera en que la gente mira a un chico solo y decide no meterse.

Entonces se abrió la puerta del portal. Iván cruzó la plaza con una caja de cartón en los brazos y se detuvo frente a la fuente. Durante un instante ninguno dijo nada. En la caja, entre cables y cuadernos, asomaba el balón de fútbol que los dos habían firmado el verano anterior.

—Pensaba dejártelo en el buzón —dijo Iván por fin—. No sabía cómo dártelo en persona.

Mateo cogió el balón. Pesaba más de lo que recordaba, o quizá lo que pesaba era el silencio. A su espalda, las campanas de la iglesia dieron las doce, y le pareció que contaban algo más que las horas.

Analiza cómo crea el autor una atmósfera de tensión contenida y de despedida en este texto. Puedes comentar, por ejemplo: el ambiente, la comparación, la mirada del camarero, el silencio y el final. (6 marks)$mq$, $mq$[1] Setting and sensory detail (olor a churros y a lluvia reciente, la plaza, la furgoneta cargada) create a grey, everyday scene in which a farewell is about to happen.
[1] Explains the simile «como un castillo de arena cuando sube la marea»: Mateo's plans are fragile and are being washed away by time.
[1] Comments on the list «una broma, un abrazo, una carta» and the failure of each plan: nervous overthinking.
[1] Comments on the waiter's look and Mateo's interpretation («respeto»): isolation, the way the world seems to leave him alone with his feelings.
[1] Comments on the ball and on Iván's line «No sabía cómo dártelo en persona»: both boys share the same difficulty, which brings the tension to a quiet release.
[1] Comments on the ending («pesaba más de lo que recordaba, o quizá lo que pesaba era el silencio»; las campanas que «contaban algo más que las horas»): the weight of silence and a sense of time passing.
Award marks for effect, not for feature-spotting. Accept other valid, well-supported points.$mq$, $mq$A$mq$),
(3, $mq$Texto B (un artículo de opinión, escrito para esta prueba)

MÁS SOMBRA, MENOS EXCUSAS
por Elena Ortega, columnista

Cada junio, el patio de nuestro instituto se convierte en una sartén. El asfalto quema, el sol cae a plomo y los alumnos buscan refugio en un trozo de pared del tamaño de un armario. Lo llamamos «el calor de siempre», como si fuera un fenómeno de la naturaleza. No lo es. Es una decisión, y la tomamos cada año al no hacer nada.

Los datos son testarudos. En una medición realizada el verano pasado por un grupo de alumnos de Ciencias, la temperatura del suelo del patio superaba en doce grados la de un parque cercano con árboles. Doce. ¿De verdad tenemos que esperar a que alguien se desmaye para reaccionar?

Me dirán que plantar árboles es caro y que el patio se necesita para el deporte. Es cierto, y no lo niego. Pero ¿cuánto cuesta un recreo en el que nadie quiere salir? Un árbol da sombra, limpia el aire y enseña a los alumnos que el lugar donde estudian también es suyo.

Por eso pido a la dirección que reserve una esquina del patio para plantar diez árboles esta primavera. Y a mis compañeros les digo: no esperemos permiso para cuidar nuestro propio sitio. La sombra no se pide: se planta.

Lee el texto B y contesta a las preguntas.

(a) Identifica el propósito de este artículo y el público al que se dirige, apoyándote en el texto. (2 marks)

(b) Explica cómo ayuda la estructura del artículo a la autora a convencer al lector. Puedes comentar el título, la apertura, los datos, la respuesta a las objeciones y la conclusión. (4 marks)$mq$, $mq$(a)
[1] Purpose: to persuade the school management and students that the playground needs shade/trees, supported by e.g. «Por eso pido a la dirección que reserve una esquina del patio».
[1] Audience: the school management and fellow students, supported by «Y a mis compañeros les digo».
(b)
[1] The title and the opening image («una sartén») engage the reader and present the problem immediately.
[1] The data from the students' measurement and the rhetorical question «¿De verdad tenemos que esperar a que alguien se desmaye?» add credibility and urgency in the second paragraph.
[1] The concession followed by a rebuttal («Me dirán que... Es cierto, y no lo niego. Pero...») shows fairness while answering the objection.
[1] The conclusion uses a clear request and a memorable closing sentence («La sombra no se pide: se planta») to finish with a call to action.
Accept other valid structural points.$mq$, $mq$B$mq$),
(4, $mq$Texto C (un poema, escrito para esta prueba)

Cuaderno de mi abuela

En la última página de su cuaderno
mi abuela anotaba el tiempo como quien guarda monedas:
lluvia el martes, un petirrojo en el alambre,
el pan que subió bien.

Yo, que lo medía todo con prisa,
no entendía por qué escribía lo pequeño
como si lo pequeño pudiera perderse.

Hoy abro el cuaderno en la cocina vacía.
Las letras se inclinan hacia la derecha,
como árboles que aprendieron del viento.
Leo: «Hoy vino a verme mi nieta. Se quedó diez minutos».

Diez minutos.
La tinta no me reprocha nada.
Y sin embargo, cada palabra
pesa como una piedra de río en la mano.

Analiza cómo utiliza la poeta el lenguaje y la estructura para expresar la memoria y la ausencia. Puedes comentar, por ejemplo: las imágenes, las comparaciones, la repetición y la última estrofa. (6 marks)$mq$, $mq$[1] Explains the simile «como quien guarda monedas»: the grandmother treats small moments as valuable things worth saving.
[1] Comments on the contrast between the speaker's former haste («todo con prisa») and the grandmother's attention to small things: regret and growing understanding.
[1] Explains the simile «como árboles que aprendieron del viento»: the handwriting is shaped by life, with a sense of nature, age and movement.
[1] Comments on the quoted diary entry «Se quedó diez minutos» and the isolated line «Diez minutos.»: repetition and short lines place guilt and emotion in a small detail.
[1] Comments on personification and tone in «La tinta no me reprocha nada»: gentleness, yet the speaker's own self-reproach.
[1] Comments on the final image «pesa como una piedra de río en la mano»: the words are heavy with feeling but also smooth, worn by time; or comments on the structure, which moves from past habit to present reading.
Accept other valid, well-supported points.$mq$, $mq$A$mq$),
(5, $mq$Texto D (un párrafo provisional de una crónica de un alumno para la revista del instituto)

La semana pasada el equipo de baloncesto del instituto jugó la final en el polideportivo. Los jugadores estaban muy nerviosos, pero su actuación fue excelente. El entrenador, el señor Ramos dijo que era el mejor partido que habían jugado nunca, y todo el mundo estaba flipando muchísimo. Nosotros pensamos que el equipo son fantástico y tambien creemos que ganaremos el año que viene. Gracias a todos los que nos a apoyado!

Lee el texto D y contesta a las preguntas.

(a) Señala tres errores de gramática, ortografía o puntuación en el texto y corrígelos. (3 marks)

(b) Señala una expresión demasiado coloquial para una revista escolar y propón otra más formal. (1 mark)

(c) Reescribe la última oración («Gracias a todos los que nos a apoyado!») en español correcto y en un registro formal. (2 marks)$mq$, $mq$(a) One mark for each error correctly identified AND corrected (maximum three).
[1] First correct identification and correction.
[1] Second correct identification and correction.
[1] Third correct identification and correction.
Acceptable errors: the missing comma after «Ramos» (el entrenador, el señor Ramos, dijo); «el equipo son fantástico» becomes «el equipo es fantástico»; «tambien» becomes «también»; «nos a apoyado» becomes «nos han apoyado»; the missing opening exclamation mark «¡Gracias... apoyado!».
(b)
[1] «flipando muchísimo» is slang; accept «entusiasmado», «encantado» or «maravillado».
(c)
[1] Correct verb form and spelling: «nos han apoyado», with the exclamation marks (or a full stop) correctly used.
[1] Formal register, e.g. «Agradecemos sinceramente a todos los que nos han apoyado.»$mq$, $mq$D$mq$),
(6, $mq$Texto A (un fragmento de un cuento, escrito para esta prueba)

El sábado, la plaza de Santa Lucía olía a churros y a lluvia reciente. Mateo llevaba veinte minutos sentado en el borde de la fuente, fingiendo mirar el móvil, aunque la pantalla estaba apagada desde hacía rato. Al otro lado de la plaza, la furgoneta de mudanzas estaba ya casi cargada.

Había pensado en mil maneras de decirlo: una broma, un abrazo, una carta. Pero cada plan se le desmoronaba al llegar a la plaza, como un castillo de arena cuando sube la marea, y ahora ya no recordaba ni cómo empezaba la primera frase.

El camarero de la churrería salió a barrer el toldo y lo miró un segundo. Mateo pensó que era respeto: la manera en que la gente mira a un chico solo y decide no meterse.

Entonces se abrió la puerta del portal. Iván cruzó la plaza con una caja de cartón en los brazos y se detuvo frente a la fuente. Durante un instante ninguno dijo nada. En la caja, entre cables y cuadernos, asomaba el balón de fútbol que los dos habían firmado el verano anterior.

—Pensaba dejártelo en el buzón —dijo Iván por fin—. No sabía cómo dártelo en persona.

Mateo cogió el balón. Pesaba más de lo que recordaba, o quizá lo que pesaba era el silencio. A su espalda, las campanas de la iglesia dieron las doce, y le pareció que contaban algo más que las horas.

Texto C (un poema, escrito para esta prueba)

Cuaderno de mi abuela

En la última página de su cuaderno
mi abuela anotaba el tiempo como quien guarda monedas:
lluvia el martes, un petirrojo en el alambre,
el pan que subió bien.

Yo, que lo medía todo con prisa,
no entendía por qué escribía lo pequeño
como si lo pequeño pudiera perderse.

Hoy abro el cuaderno en la cocina vacía.
Las letras se inclinan hacia la derecha,
como árboles que aprendieron del viento.
Leo: «Hoy vino a verme mi nieta. Se quedó diez minutos».

Diez minutos.
La tinta no me reprocha nada.
Y sin embargo, cada palabra
pesa como una piedra de río en la mano.

Compara cómo presentan los textos A y C la relación entre un joven y una persona cercana y el peso del recuerdo. (4 marks)$mq$, $mq$[1] A valid similarity, e.g. both show a young person who has a difficulty expressing feelings to someone close (Iván; la abuela) and both leave important things unsaid.
[1] A valid difference, e.g. Text A shows a precise moment as it happens, whereas Text C looks back from the present with a more reflective, regretful voice.
[1] Compares a technique, e.g. both use a comparison from the everyday world (castillo de arena; árboles que aprendieron del viento), or both finish with an image of weight («pesaba más»; «pesa como una piedra»).
[1] Uses a short accurate quotation from each text and the comparison is explicit (mientras que, igualmente, en cambio).
Accept other valid comparisons.$mq$, $mq$A$mq$),
(7, $mq$Escribe un discurso de unas 300 palabras para pronunciarlo en la asamblea de tu instituto. En él, defiende que los estudiantes deberían dedicar una tarde a la semana a actividades al aire libre en lugar de pasar tanto tiempo ante las pantallas. Debes convencer tanto a los alumnos como a los profesores. (12 marks)

Se evaluarán el propósito y la conciencia del público, la estructura del discurso, las técnicas de persuasión y la riqueza y corrección de la lengua.$mq$, $mq$[1] The purpose is clear and sustained: the speech argues a definite position about outdoor activities.
[1] There is clear awareness of the audience of students and teachers, e.g. direct address with «vosotros»/«ustedes» and «nosotros».
[1] The register is appropriate for a spoken school assembly, formal but engaging.
[1] The opening is engaging, e.g. a question, anecdote or striking statement.
[1] The central argument is clear and easy to follow.
[1] Ideas are developed with relevant examples, reasons or evidence.
[1] A range of persuasive techniques is used purposefully, e.g. rhetorical questions, repetition, the rule of three, emotive language.
[1] An opposing view is acknowledged and answered (e.g. «algunos dirán que no hay tiempo...»).
[1] The speech is organised logically in paragraphs with a clear progression of ideas.
[1] Connectives create cohesion (en primer lugar, además, sin embargo, por último, por eso).
[1] Vocabulary and sentence structures are varied; verb forms (including the subjunctive where appropriate), agreement, accents and spelling are mostly accurate.
[1] The conclusion is effective and ends with a memorable call to action.
Credit any valid approach that meets these qualities.$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
