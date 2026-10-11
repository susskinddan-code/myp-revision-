-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Spanish Language & Literature MYP 5 Full eAssessment Mock (110 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish Language & Literature MYP 5 Full eAssessment Mock$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish Language & Literature MYP 5 Full eAssessment Mock$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Texto A (un fragmento de un cuento, escrito para esta prueba)

La oficina de correos de Villaluz cerraba a las ocho, y a las siete y cuarenta Sofía todavía estaba de pie en la cola, con el sobre apretado contra el pecho como si pudiera escaparse. Delante de ella, una señora discutía con el funcionario por un paquete que había viajado de Valencia a Lima y había vuelto sin que nadie supiera por qué.

El reloj de pared tenía una manera muy suya de contar los segundos: un chasquido seco, una pausa, otro chasquido. Sofía los contaba también. Llevaba treinta y cuatro minutos allí y todavía no sabía si iba a enviar la carta. El sobre no llevaba remitente. Dentro había seis páginas que había escrito, roto y vuelto a escribir durante todo el mes de octubre.

—¿Siguiente? —preguntó el funcionario, sin levantar la vista. Tenía la voz de quien repite la misma palabra desde hace treinta años y ya no la oye.

Sofía dio un paso. Sobre el mostrador, una balanza esperaba con su platillo vacío, brillante y paciente. Pensó en el destinatario, en la casa de su padre al otro lado del mar, en la puerta que quizá no se abriría.

Puso el sobre en el platillo. La aguja tembló un instante, dudó y se quedó quieta, como si también ella hubiera decidido esperar.

Lee el texto A y contesta a las preguntas.

(a) Señala dos detalles de los dos primeros párrafos que muestran que Sofía lleva mucho tiempo esperando. (2 marks)

(b) Explica qué sugiere el texto sobre los sentimientos de Sofía hacia la carta. (3 marks)

(c) Explica cómo se presenta al funcionario. (3 marks)

Total para la pregunta 1: 8 marks$mq$, $mq$(a)
[1] One valid detail, e.g. «a las siete y cuarenta todavía estaba de pie en la cola»; la señora discute por un paquete; «llevaba treinta y cuatro minutos allí»; Sofía cuenta los chasquidos del reloj.
[1] A second, different valid detail.
(b)
[1] A valid inference, e.g. Sofía is anxious and unsure, and the letter is extremely important to her.
[1] Supported by reference, e.g. she holds the envelope «apretado contra el pecho como si pudiera escaparse»; she wrote, tore up and rewrote the letter throughout October.
[1] Developed comment, e.g. the envelope without a sender and the doubt about posting it show fear of the answer, or of rejection by her father.
(c)
[1] Identifies a valid impression: tired, routine, indifferent, mechanical.
[1] Supported by quotation or close reference, e.g. «sin levantar la vista»; «la voz de quien repite la misma palabra desde hace treinta años y ya no la oye».
[1] Explains the effect, e.g. his indifference contrasts with Sofía's inner turmoil and makes her moment feel lonelier and more important.
Levels of response guidance: award marks for inference supported by the text, not for retelling.$mq$, $mq$A$mq$),
(2, $mq$Consulta el texto A (el fragmento sobre Sofía) impreso en la pregunta 1.

Analiza cómo utiliza el autor el lenguaje y la estructura para crear una sensación de espera, duda y tensión en el fragmento. (10 marks)

Puedes comentar, por ejemplo: el escenario, el reloj, las comparaciones, la longitud de las frases y el final.

Total para la pregunta 2: 10 marks$mq$, $mq$Indicative content (credit any valid, well-supported point):
[1] Setting: a post office near closing time («cerraba a las ocho», «siete y cuarenta») builds time pressure and a sense that the chance will soon be gone.
[1] The simile «apretado contra el pecho como si pudiera escaparse»: the letter is alive and precious; Sofía's fear of losing it or of letting go of it.
[1] The comic anecdote of the parcel that «había vuelto sin que nadie supiera por qué»: ordinary bureaucracy contrasts with Sofía's private drama and raises the question of whether messages ever arrive.
[1] The clock («un chasquido seco, una pausa, otro chasquido») and the rhythm of the sentence: the waiting is heard; a pause creates suspense.
[1] The detail of October, with the letter «escrito, roto y vuelto a escribir»: obsessive effort and uncertainty.
[1] The official's voice «ya no la oye»: mechanical routine contrasts with her emotion.
[1] The scale «brillante y paciente»: personification; the scale waits as Sofía does and will «weigh» her decision.
[1] The father's house «al otro lado del mar» and «la puerta que quizá no se abriría»: distance and fear of rejection.
[1] Sentence length: long sentences of waiting give way to short ones of action («Puso el sobre en el platillo»), showing the decision.
[1] The ending: the needle that «tembló», «dudó» and «se quedó quieta, como si también ella hubiera decidido esperar»: the final personification mirrors Sofía's feelings and leaves the outcome open.
Levels of response guidance: Levels 1-2 (1-3 marks) identify features with little explanation; Levels 3-4 (4-6 marks) explain effects with some support; Levels 5-6 (7-10 marks) sustained, precise analysis of language and structure.
Common errors: retelling the story; naming features without explaining the effect.$mq$, $mq$A$mq$),
(3, $mq$Texto B (un poema, escrito para esta prueba)

Bicicleta

Mi abuelo sujetaba el sillín con una mano
y con la otra el miedo, que era mío.
—No te suelto —decía, y me soltaba.

Yo pedaleaba derecho porque creía
que él seguía detrás, sosteniendo el mundo.
Al volverme, estaba lejos, sonriendo, pequeño.

Hoy subo la cuesta del barrio
y la bicicleta sigue recta, sin ayuda.
Sé que nada se sostiene solo.

Alguien, hace años, mintió con ternura
para que yo aprendiera a creer
que podía llegar hasta aquí.

Lee el texto B (un poema).

(a) ¿Qué decía el abuelo mientras enseñaba a montar en bicicleta, y qué hacía en realidad? (1 mark)

(b) Explica qué sugiere la última estrofa («Alguien, hace años, mintió con ternura...») sobre la actitud de la voz poética hacia su abuelo. (3 marks)

(c) Analiza cómo utiliza el poeta las imágenes y la estructura para expresar la confianza y la independencia. (6 marks)

Total para la pregunta 3: 10 marks$mq$, $mq$(a)
[1] He said «No te suelto» but in fact he let go («y me soltaba»).
(b)
[1] A valid inference, e.g. the speaker feels gratitude and understanding; she/he no longer sees the lie as a betrayal.
[1] Supported by reference, e.g. the oxymoron «mintió con ternura» shows that the lie was an act of love.
[1] Developed comment, e.g. the speaker recognises that the grandfather's trust gave them the courage to reach «hasta aquí» in life.
(c)
[1] The image of the grandfather holding «con la otra el miedo, que era mío»: fear is given a physical form and is shared.
[1] The promise and its contradiction «No te suelto —decía, y me soltaba»: tender irony, the dash and the comma create a turn.
[1] «sosteniendo el mundo» and «pequeño»: the child's belief against the adult's reality; the grandfather fades into the distance.
[1] The shift from past to present («Hoy subo la cuesta»): a mature voice that now rides alone, a visible structure of growth.
[1] The generalisation «Sé que nada se sostiene solo»: a short, reflective line that gives the poem its central idea.
[1] The structure of four short stanzas and the final stanza's reflection with enjambement: gentle, conversational rhythm and a closing sense of resolution.
Levels of response guidance: award marks for explained effects, not for feature-spotting.
Common errors: assuming the grandfather has died without textual support; ignoring structure.$mq$, $mq$A$mq$),
(4, $mq$El texto A (el fragmento sobre Sofía) y el texto B (el poema «Bicicleta») están impresos más arriba. Consulta los dos textos.

Compara cómo presentan los autores de los textos A y B la relación con un familiar y el miedo a dar un paso.

En tu respuesta debes:
- comparar las ideas que presenta cada autor
- comparar las decisiones de lenguaje, estructura o forma
- apoyar tus comentarios con citas breves. (12 marks)

Total para la pregunta 4: 12 marks$mq$, $mq$[1] Identifies the family relationship and fear in Text A (Sofía and her father; fear that the door will not open).
[1] Identifies the family relationship and fear in Text B (the grandfather and the child's fear on the bicycle).
[1] A valid similarity, e.g. in both texts a physical object (el sobre; la bicicleta) is the means by which a character crosses a threshold with the help of someone far away.
[1] A valid difference, e.g. Text A is tense and unresolved in a single present moment, whereas Text B looks back and finds peace and gratitude.
[1] Quotation from Text A used accurately.
[1] Quotation from Text B used accurately.
[1] Language comparison, e.g. the personifying similes of Text A («como si pudiera escaparse», «como si también ella hubiera decidido esperar») versus the paradox and direct speech of Text B («No te suelto»).
[1] Explains the effect of the language in at least one text.
[1] Structure or form comparison, e.g. third-person narrative ending with a suspended image versus free verse in short stanzas with a shift from past to present.
[1] Explains the effect of structure or form in at least one text.
[1] The comparison is sustained and linked, using connectives such as «mientras que», «igualmente», «en cambio».
[1] Overall judgement, e.g. both writers suggest that crossing a threshold requires trust, and that love can be expressed through distance and risk.
Levels of response guidance: Levels 1-2 (1-4 marks) separate descriptions with little comparison; Levels 3-4 (5-8 marks) explicit comparison of ideas with some language or structure; Levels 5-6 (9-12 marks) sustained, integrated comparison with precise evidence.
Common errors: writing about each text in turn with no links; comparing only plots.$mq$, $mq$A$mq$),
(5, $mq$Texto C (un artículo de prensa, escrito para esta prueba)

SALVEMOS EL CINE ALAMEDA
por Marcos Peñalver, columnista

La noche en que el ayuntamiento anunció que el cine Alameda cerraría en enero, me acerqué a la puerta y conté a la gente de la cola: treinta y una personas. Un abuelo con su nieta, dos estudiantes que compartían unas palomitas, una cuidadora que había traído a un señor en silla de ruedas. Ninguno miraba el móvil. Todos miraban la pantalla todavía apagada, con esa paciencia de quien espera algo bueno.

El ayuntamiento alega que mantener el edificio cuesta 85 000 euros al año. No lo discuto. Pero ¿cuánto cuesta un barrio donde nadie se junta? ¿Cuánto vale una tarde en la que un abuelo y su nieta comparten algo más que una pantalla pequeña? Esas cuentas no aparecen en ningún presupuesto, y sin embargo las pagaremos todos.

Según las cifras del propio ayuntamiento, el 7 % de los vecinos va al cine cada mes. Puede parecer poco; en una ciudad de cuarenta mil habitantes, son dos mil ochocientas personas.

Por eso propongo un trato: dennos un año. Un año para programar ciclos de cine escolar, para abrir los domingos, para que las asociaciones del barrio lo hagan suyo. Si fracasamos, apagaremos nosotros mismos las luces. Pero no las apaguen antes de mirar quién hay sentado en la oscuridad.

Lee el texto C (un artículo de prensa).

(a) Señala dos hechos (no opiniones) que se presentan en el artículo. (2 marks)

(b) Explica el propósito de la anécdota del comienzo del artículo. (2 marks)

(c) Explica cómo responde el autor al argumento del ayuntamiento sobre el coste del cine. (4 marks)

Total para la pregunta 5: 8 marks$mq$, $mq$(a)
[1] One valid fact, e.g. el ayuntamiento anunció que el cine cerraría en enero; mantener el edificio cuesta 85 000 euros al año; el 7 % de los vecinos va al cine cada mes; la ciudad tiene cuarenta mil habitantes.
[1] A second valid fact (not an opinion).
(b)
[1] Identifies the purpose: to open with a concrete, human image before the argument, and to present the writer as a first-hand witness.
[1] Explains the effect, e.g. the varied people in the queue (un abuelo, dos estudiantes, una cuidadora) create emotional appeal and show that the cinema serves the whole community.
(c)
[1] Concession: «No lo discuto» shows the writer is fair and reasonable.
[1] Rhetorical questions: «¿cuánto cuesta un barrio donde nadie se junta?».
[1] Reframing: the real costs are social and invisible, «no aparecen en ningún presupuesto».
[1] Explains the effect: the argument seems balanced yet turns the council's cost argument against it; the future tense «las pagaremos todos» adds a warning.
Accept other valid points supported by the text.$mq$, $mq$A$mq$),
(6, $mq$Consulta de nuevo el texto C (el artículo sobre el cine Alameda), impreso en la pregunta 5.

Analiza cómo utiliza el autor el lenguaje y la estructura para convencer a los lectores de que el cine debe seguir abierto. (10 marks)

Puedes comentar, por ejemplo: la apertura, los datos y las cifras, las preguntas retóricas, el tono, la estructura de los párrafos y el final.

Total para la pregunta 6: 10 marks$mq$, $mq$Indicative content (credit any valid, well-supported point):
[1] The personal, anecdotal opening («me acerqué a la puerta y conté a la gente») gives credibility and a first-hand viewpoint.
[1] Specific, varied examples (el abuelo y su nieta, los estudiantes, la cuidadora) create pathos and show who would be harmed.
[1] The detail «Ninguno miraba el móvil» and «paciencia de quien espera algo bueno»: positive, human image of shared attention.
[1] The concession «No lo discuto» makes the writer seem reasonable.
[1] Rhetorical questions («¿Cuánto vale una tarde...?») force the reader to reconsider what is valuable.
[1] Statistics (85 000 euros, 7 %, dos mil ochocientas personas) and the reframing of «Puede parecer poco»: logos used to defend the cinema.
[1] The shift from «yo» to «nosotros» («Si fracasamos, apagaremos nosotros mismos las luces») involves the community.
[1] The practical proposal («dennos un año», ciclos de cine escolar, abrir los domingos): constructive tone.
[1] Structure: anecdote, objection, evidence, proposal; clear logical progression.
[1] The final image («quién hay sentado en la oscuridad») and the use of the formal imperative «no las apaguen»: memorable ending that challenges the decision-makers.
Levels of response guidance: Levels 1-2 (1-3 marks) list devices; Levels 3-4 (4-6 marks) explain effects with examples; Levels 5-6 (7-10 marks) sustained, precise evaluation of how choices persuade.
Common errors: retelling; naming devices without effect.$mq$, $mq$A$mq$),
(7, $mq$Texto D (un texto multimodal: un cartel de barrio, descrito con palabras)

[Descripción de la imagen: Una fotografía ocupa la mitad superior del cartel. Muestra una calle sin coches al amanecer; en el centro, un niño de unos nueve años pedalea con los brazos abiertos y una sonrisa enorme. A lo lejos se ve una fila de globos amarillos.]

Texto en letras grandes, blancas, sobre fondo azul: ¿Y SI LA CALLE FUERA TUYA?
Texto mediano: Este domingo, de 10:00 a 14:00, el centro del barrio se cierra al tráfico. Bicis, juegos, música en directo y desayuno gratis.
Texto pequeño, abajo: Plaza Mayor. Entrada libre. Trae tu bici y a tus vecinos.

Lee el texto D (un cartel).

(a) Señala dos elementos visuales o tipográficos del cartel. (2 marks)

(b) Explica cómo funcionan juntos el titular y la fotografía para atraer la atención del público. (3 marks)

(c) Explica cómo ayuda la organización del cartel (el orden y el tamaño de los elementos) a que el lector entienda el mensaje. (3 marks)

Total para la pregunta 7: 8 marks$mq$, $mq$(a)
[1] One valid feature, e.g. letras grandes blancas sobre fondo azul; fotografía de un niño en bicicleta; globos amarillos; calle sin coches.
[1] A second, different valid feature.
(b)
[1] The headline is a direct question («¿Y SI LA CALLE FUERA TUYA?») that addresses the reader as «tuya»/«tú».
[1] The photograph shows an empty street and a child with arms open, smiling: it makes the idea of reclaiming the street seem joyful and possible.
[1] Explains the effect: an emotional and imaginative hook that invites the reader to picture the event and to read on.
(c)
[1] The large image and headline come first and catch the eye (visual hierarchy).
[1] The medium-sized text then gives the details (cuándo, qué actividades), so the reader moves from emotion to information.
[1] The practical details at the bottom in small print (lugar, entrada libre) and the imperative «Trae tu bici y a tus vecinos» invite action and target families and neighbours.
Accept other valid points on layout and audience.$mq$, $mq$B$mq$),
(8, $mq$Tarea de escritura 1: escritura creativa

Lee la descripción de la fotografía.

[Descripción de la imagen: Un paraguas amarillo abierto yace en el suelo de una estación vacía. Junto a él hay una maleta pequeña con la cremallera a medio cerrar. En el panel de salidas, la palabra «CANCELADO» parpadea sobre el nombre de un tren.]

Escribe el comienzo de un cuento (unas 350 a 450 palabras) que empiece con esta escena. Debes:
- crear un escenario y una atmósfera claros
- desarrollar al menos un personaje
- utilizar una variedad de técnicas de lenguaje y de estructura para crear efectos. (22 marks)

Los puntos se conceden por la producción de texto (8 puntos), la organización de las ideas y de la estructura (6 puntos) y el uso de una lengua precisa y eficaz (8 puntos).

Total para la pregunta 8: 22 marks$mq$, $mq$Criterion C: producing text
[8] Levels 1-2 (1-3 marks): ideas are limited or generic; little sense of purpose, audience or voice. Levels 3-4 (4-6 marks): clear, sustained ideas with relevant development; some deliberate choices for effect. Levels 5-6 (7-8 marks): original, controlled and convincing; atmosphere and character are convincingly developed; techniques (imagery, sensory detail, pacing, point of view) are used purposefully and linked to the stimulus.
Criterion B: organising
[6] Levels 1-2 (1-2 marks): little structure; ideas are listed or repeated. Levels 3-4 (3-4 marks): clear opening and development with paragraphing and some linking. Levels 5-6 (5-6 marks): shaped, cohesive piece with deliberate structural choices; e.g. a shift in focus, a withheld detail or a hook ending; paragraphs and transitions enhance meaning.
Criterion D: using language
[8] Levels 1-2 (1-3 marks): frequent errors affect meaning; limited vocabulary. Levels 3-4 (4-6 marks): generally accurate spelling, accents, agreement and verb forms; some range of vocabulary and sentence types. Levels 5-6 (7-8 marks): accurate, fluent and varied writing with precise vocabulary and a range of tenses and structures; sentence variety is used for effect; tenses (pretérito indefinido and imperfecto) are controlled.
Indicative content: any suitable narrative; accept first or third person. Strong answers might use the abandoned umbrella and half-closed suitcase as symbols of a sudden departure or an interrupted plan. Do not reward length for its own sake; writing well below 350 words belongs in the lower part of the level.
Common errors: summarising the whole story rather than writing an opening; listing the objects in the image; clichés such as «era una noche oscura y tormentosa»; inconsistent tenses; anglicisms; missing accents, agreement errors and confusion between ser/estar or por/para.$mq$, $mq$C$mq$),
(9, $mq$Tarea de escritura 2: escritura argumentativa

Lee la afirmación.

«El uniforme escolar debería ser obligatorio en todos los institutos.»

Escribe un artículo para la revista de un instituto (unas 400 a 500 palabras) en el que des tu opinión sobre esta afirmación. Puedes estar a favor, en contra o matizar, pero debes llegar a una conclusión clara. Debes:
- expresar un punto de vista claro
- apoyar tus ideas con ejemplos y valorar los argumentos contrarios
- organizar tu texto para un público adolescente
- usar un lenguaje adecuado al propósito y al público. (22 marks)

Los puntos se conceden por la producción de texto (8 puntos), la organización de las ideas y de la estructura (6 puntos) y el uso de una lengua precisa y eficaz (8 puntos).

Total para la pregunta 9: 22 marks$mq$, $mq$Criterion C: producing text
[8] Levels 1-2 (1-3 marks): ideas are limited or generic; little sense of purpose, audience or voice. Levels 3-4 (4-6 marks): clear, sustained ideas with relevant development; some deliberate choices for effect. Levels 5-6 (7-8 marks): original, controlled and convincing; a convincing, insightful argument with well-chosen evidence and sustained evaluation of counter-arguments; a clear sense of the teenage readership and a deliberate tone.
Criterion B: organising
[6] Levels 1-2 (1-2 marks): little structure; ideas are listed or repeated. Levels 3-4 (3-4 marks): clear opening and development with paragraphing and some linking. Levels 5-6 (5-6 marks): shaped, cohesive piece with deliberate structural choices; e.g. a hook introduction, linked paragraphs, signposting and a memorable conclusion; the conventions of a magazine article (titular, entradilla) used skilfully.
Criterion D: using language
[8] Levels 1-2 (1-3 marks): frequent errors affect meaning; limited vocabulary. Levels 3-4 (4-6 marks): generally accurate spelling, accents, agreement and verb forms; some range of vocabulary and sentence types. Levels 5-6 (7-8 marks): accurate, fluent and varied writing with precise vocabulary and a range of tenses and structures; rhetorical devices (pregunta retórica, enumeración de tres elementos, anécdota, apelación directa) used precisely; a range of connectives and verb forms, including the subjunctive after expressions such as «es importante que» where appropriate.
Indicative content: accept for, against or balanced views; strong answers use concrete examples (igualdad, identidad, coste, comodidad, pertenencia) and weigh them. Writing significantly below 400 words belongs in the lower part of the level.
Common errors: a list of points with no evaluation; ignoring the opposing view; an overly informal or text-message register; confusing «a ver/haber», «porque/porqué», «hay/ahí/ay», «tuvo/tubo».$mq$, $mq$B$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
