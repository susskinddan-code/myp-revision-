-- 1 papers. Safe to re-run: a paper with the same subject, grade and title is skipped.
begin;

-- Spanish Language & Literature MYP 5 eAssessment-style Practice Paper 2 (44 marks)
with sub as (select id from public.subjects where slug = $mq$spanish-language-and-literature$mq$),
new_paper as (
  insert into public.past_papers (subject_id, title, grade, criterion, is_generated)
  select sub.id, $mq$Spanish Language & Literature MYP 5 eAssessment-style Practice Paper 2$mq$, 5, null, true from sub
  where not exists (select 1 from public.past_papers x where x.subject_id = sub.id and x.grade = 5 and x.title = $mq$Spanish Language & Literature MYP 5 eAssessment-style Practice Paper 2$mq$)
  returning id
)
insert into public.paper_questions (paper_id, position, content, options, answer, mark_scheme, criterion)
select new_paper.id, v.position, v.content, '[]'::jsonb, 0, v.mark_scheme, v.criterion
from new_paper, (values
(1, $mq$Texto A (una crónica de viaje, escrita para esta prueba)

A Isla Bermeja no se llega: se desemboca. El barco, un cascarón blanco que olía a gasoil y a naranjas, cruzó la bruma durante dos horas antes de que apareciera el puerto, primero como una sospecha y luego como un dibujo de tiza: casas encaladas, una torre con un reloj parado y, sobre todo, un silencio que parecía llevar siglos esperándonos.

Desembarqué con la mochila a cuestas y el pelo pegado a la frente. En el muelle, un hombre con gorra de lana ordenaba cajas de pescado, y cada vez que levantaba una, el hielo crujía como cristales pisados. Cuando le pregunté por una pensión, no contestó con palabras: señaló con la barbilla una callejuela que subía hacia la luz, y esa fue toda la conversación.

Subí sin prisa. Las puertas estaban pintadas de colores que ningún ayuntamiento habría autorizado: añil, granate, un amarillo casi impertinente. De una ventana salía el olor del café recién hecho y, del fondo de la calle, una radio vieja cantaba un bolero con voz de abuela.

Al llegar arriba me di cuenta de que el reloj de la torre, el parado, marcaba justo la hora a la que yo había llegado. Será casualidad, pensé. Pero aquella mañana decidí no creérmelo del todo.

Lee el texto A y contesta a las preguntas.

(a) Señala dos detalles del primer párrafo que muestran que la isla parece aislada y tranquila. (2 marks)

(b) Explica qué sugiere el gesto del hombre del muelle sobre el carácter de los habitantes de la isla. (2 marks)$mq$, $mq$(a)
[1] One relevant detail, e.g. el puerto aparece entre la bruma «como una sospecha»; las casas encaladas; la torre con un reloj parado; «un silencio que parecía llevar siglos esperándonos».
[1] A second, different relevant detail from the first paragraph.
(b)
[1] A valid inference, e.g. the islanders are reserved, economical with words, but helpful.
[1] Supported by reference, e.g. «no contestó con palabras: señaló con la barbilla una callejuela»; «esa fue toda la conversación» (humour and warmth in the narrator's tone).
Accept other valid inferences supported by the text.$mq$, $mq$A$mq$),
(2, $mq$Texto A (una crónica de viaje, escrita para esta prueba)

A Isla Bermeja no se llega: se desemboca. El barco, un cascarón blanco que olía a gasoil y a naranjas, cruzó la bruma durante dos horas antes de que apareciera el puerto, primero como una sospecha y luego como un dibujo de tiza: casas encaladas, una torre con un reloj parado y, sobre todo, un silencio que parecía llevar siglos esperándonos.

Desembarqué con la mochila a cuestas y el pelo pegado a la frente. En el muelle, un hombre con gorra de lana ordenaba cajas de pescado, y cada vez que levantaba una, el hielo crujía como cristales pisados. Cuando le pregunté por una pensión, no contestó con palabras: señaló con la barbilla una callejuela que subía hacia la luz, y esa fue toda la conversación.

Subí sin prisa. Las puertas estaban pintadas de colores que ningún ayuntamiento habría autorizado: añil, granate, un amarillo casi impertinente. De una ventana salía el olor del café recién hecho y, del fondo de la calle, una radio vieja cantaba un bolero con voz de abuela.

Al llegar arriba me di cuenta de que el reloj de la torre, el parado, marcaba justo la hora a la que yo había llegado. Será casualidad, pensé. Pero aquella mañana decidí no creérmelo del todo.

Analiza cómo crea el autor una impresión de misterio y de acogida en esta crónica de viaje. Puedes comentar, por ejemplo: las comparaciones, los sentidos, los colores, el reloj parado y la última frase. (6 marks)$mq$, $mq$[1] Explains the opening «no se llega: se desemboca»: arrival as a gentle flow, mystery from the first sentence.
[1] Comments on the two similes of the port appearing «como una sospecha» and «como un dibujo de tiza»: the island seems unreal and fragile.
[1] Comments on sensory details (gasoil y naranjas, el hielo que crujía, el café, la radio): the island becomes physical and welcoming.
[1] Comments on colour («añil, granate, un amarillo casi impertinente»): personality and playful humour in the town.
[1] Explains the stopped clock that «marcaba justo la hora»: a touch of magic or fate, and a time that does not follow the rules of the outside world.
[1] Explains the final sentence «decidí no creérmelo del todo»: the narrator chooses to believe in the mystery, which leaves the reader with a sense of wonder.
Award marks for effect, not for feature-spotting. Accept other valid, well-supported points.$mq$, $mq$A$mq$),
(3, $mq$Texto B (una escena breve de teatro, escrita para esta prueba)

LA AZOTEA

Escenario: la azotea de un bloque de pisos, al atardecer. Hay una antena torcida y varias sillas de plástico. CLARA, dieciséis años, está sentada con las rodillas contra el pecho. Su hermano mayor, DIEGO, sube por la escalera con dos latas de refresco.

DIEGO: (tendiéndole una lata) Se te va a congelar la nariz.
CLARA: (sin mirarlo) No hace frío.
DIEGO: Ya. (Se sienta a su lado. Pausa larga. Abajo, un coche toca el claxon.) Mañana a esta hora estaré en un avión.
CLARA: Ya lo sé. Lo sabe todo el edificio. Mamá lo ha dicho hasta en la panadería.
DIEGO: (riendo bajito) Es verdad.
(Silencio. Clara abre la lata; el chasquido suena demasiado fuerte.)
CLARA: ¿Y quién me va a ayudar con las mates?
DIEGO: Hay vídeos. Y tú eres más lista que yo.
CLARA: Eso no es una respuesta.
DIEGO: (tras un momento) Tienes razón. No lo es. (Saca del bolsillo una llave pequeña y se la pone en la mano.) La de mi cuarto. Para que no se quede vacío.
(Clara cierra el puño. Las luces de la ciudad se van encendiendo una a una.)
CLARA: (en voz baja) Vuelve pronto. Y no te cambies el acento.

Lee el texto B.

Analiza cómo utiliza el autor las acotaciones, el diálogo y el ritmo para crear tensión emocional y, después, cercanía entre los hermanos. (6 marks)$mq$, $mq$[1] Comments on the opening setting (azotea, atardecer, antena torcida, sillas de plástico): an ordinary space that feels in-between, the end of a day and of a stage of life.
[1] Explains Clara's posture («rodillas contra el pecho») and her refusal to look at him: she is closed off and hurt.
[1] Comments on the pauses and silences and the noise of the can («el chasquido suena demasiado fuerte»): tension, the awkwardness of things not said.
[1] Comments on the short lines of dialogue («Eso no es una respuesta»): Clara's directness exposes her real fear.
[1] Comments on humour («Lo sabe todo el edificio. Mamá lo ha dicho hasta en la panadería»): a way of hiding sadness that also brings them closer.
[1] Explains the key as a symbol («Para que no se quede vacío») and the closing line («no te cambies el acento»): affection expressed indirectly through an object and a joke.
Accept other valid, well-supported points on stagecraft and dialogue.$mq$, $mq$A$mq$),
(4, $mq$Texto B (una escena breve de teatro, escrita para esta prueba)

LA AZOTEA

Escenario: la azotea de un bloque de pisos, al atardecer. Hay una antena torcida y varias sillas de plástico. CLARA, dieciséis años, está sentada con las rodillas contra el pecho. Su hermano mayor, DIEGO, sube por la escalera con dos latas de refresco.

DIEGO: (tendiéndole una lata) Se te va a congelar la nariz.
CLARA: (sin mirarlo) No hace frío.
DIEGO: Ya. (Se sienta a su lado. Pausa larga. Abajo, un coche toca el claxon.) Mañana a esta hora estaré en un avión.
CLARA: Ya lo sé. Lo sabe todo el edificio. Mamá lo ha dicho hasta en la panadería.
DIEGO: (riendo bajito) Es verdad.
(Silencio. Clara abre la lata; el chasquido suena demasiado fuerte.)
CLARA: ¿Y quién me va a ayudar con las mates?
DIEGO: Hay vídeos. Y tú eres más lista que yo.
CLARA: Eso no es una respuesta.
DIEGO: (tras un momento) Tienes razón. No lo es. (Saca del bolsillo una llave pequeña y se la pone en la mano.) La de mi cuarto. Para que no se quede vacío.
(Clara cierra el puño. Las luces de la ciudad se van encendiendo una a una.)
CLARA: (en voz baja) Vuelve pronto. Y no te cambies el acento.

Lee el texto B.

(a) Identifica el propósito de este texto y el público al que se dirige. Apóyate en un elemento del texto. (2 marks)

(b) Los hermanos hablan con un registro coloquial y cercano («mates», «Ya»). Explica qué efecto tiene este lenguaje en la presentación de su relación. (2 marks)$mq$, $mq$(a)
[1] Purpose: to entertain and to explore the emotions of a family farewell, supported by e.g. «Mañana a esta hora estaré en un avión» or the gift of the key.
[1] Audience: a school or youth theatre audience, or teenage readers who can relate to growing apart from a sibling.
(b)
[1] Identifies the colloquial register (abbreviation «mates», short answers «Ya», informal «tú» forms, the humour).
[1] Explains the effect: it shows closeness and trust between siblings and makes the moment of feeling more natural, because emotions are hidden under jokes and everyday language.
Accept other valid comments on register.$mq$, $mq$D$mq$),
(5, $mq$Texto C (un poema, escrito para esta prueba)

Estación de invierno

Los trenes pasan sin detenerse
y el andén aprende a esperar.
Un banco de madera guarda todavía
la forma de las despedidas.

Yo cuento las luces de la vía
como quien cuenta ovejas.
Ninguna se apaga. Ninguna llega.
El reloj respira despacio.

Quizá todo viaje sea eso:
dejar un lugar tibio
para que otro pueda sentarse
y esperar sin tener miedo.

Cuando por fin sube el viento
y arrastra un papel hasta mis pies,
lo recojo como si fuera una carta
y le contesto con el vapor de mi aliento.

Analiza cómo utiliza la poeta las imágenes y la estructura para presentar la espera y el paso del tiempo. Puedes comentar, por ejemplo: la personificación, las comparaciones, la progresión de las estrofas y la última estrofa. (6 marks)$mq$, $mq$[1] Explains the personification «el andén aprende a esperar»: the place has patience and a life of its own.
[1] Comments on «la forma de las despedidas» kept in the wooden bench: the past leaves a trace in objects.
[1] Comments on the simile «como quien cuenta ovejas» and the short statements «Ninguna se apaga. Ninguna llega.»: the monotony of waiting, a sense of suspended time.
[1] Explains «El reloj respira despacio»: time is slowed and made human.
[1] Comments on the third stanza's reflection («dejar un lugar tibio para que otro pueda sentarse»): a generous, universal idea of journeys and care for strangers; the poem moves from observation to reflection.
[1] Explains the final image of the paper «como si fuera una carta» and the answer with the breath: communication without words, a small gesture of hope at the end.
Accept other valid, well-supported points.$mq$, $mq$A$mq$),
(6, $mq$Texto A (una crónica de viaje, escrita para esta prueba)

A Isla Bermeja no se llega: se desemboca. El barco, un cascarón blanco que olía a gasoil y a naranjas, cruzó la bruma durante dos horas antes de que apareciera el puerto, primero como una sospecha y luego como un dibujo de tiza: casas encaladas, una torre con un reloj parado y, sobre todo, un silencio que parecía llevar siglos esperándonos.

Desembarqué con la mochila a cuestas y el pelo pegado a la frente. En el muelle, un hombre con gorra de lana ordenaba cajas de pescado, y cada vez que levantaba una, el hielo crujía como cristales pisados. Cuando le pregunté por una pensión, no contestó con palabras: señaló con la barbilla una callejuela que subía hacia la luz, y esa fue toda la conversación.

Subí sin prisa. Las puertas estaban pintadas de colores que ningún ayuntamiento habría autorizado: añil, granate, un amarillo casi impertinente. De una ventana salía el olor del café recién hecho y, del fondo de la calle, una radio vieja cantaba un bolero con voz de abuela.

Al llegar arriba me di cuenta de que el reloj de la torre, el parado, marcaba justo la hora a la que yo había llegado. Será casualidad, pensé. Pero aquella mañana decidí no creérmelo del todo.

Texto C (un poema, escrito para esta prueba)

Estación de invierno

Los trenes pasan sin detenerse
y el andén aprende a esperar.
Un banco de madera guarda todavía
la forma de las despedidas.

Yo cuento las luces de la vía
como quien cuenta ovejas.
Ninguna se apaga. Ninguna llega.
El reloj respira despacio.

Quizá todo viaje sea eso:
dejar un lugar tibio
para que otro pueda sentarse
y esperar sin tener miedo.

Cuando por fin sube el viento
y arrastra un papel hasta mis pies,
lo recojo como si fuera una carta
y le contesto con el vapor de mi aliento.

Compara cómo presentan los autores de los textos A y C un lugar y su efecto en quien habla. En tu respuesta, compara las ideas y después el lenguaje o la estructura, citando brevemente los textos. (6 marks)$mq$, $mq$[1] Identifies a similarity, e.g. both texts give their settings human qualities (el silencio que «parecía llevar siglos esperándonos»; el andén que «aprende a esperar»; el reloj que «respira») and show time behaving differently.
[1] Identifies a difference in tone or mood: Text A is curious, warm and humorous; Text C is quiet, reflective and melancholy.
[1] Compares the use of imagery, e.g. colourful, sensory and outdoor in A versus sparse, nocturnal and focused on small details in C.
[1] Compares structure or form: a first-person travel account in prose paragraphs with a reflective ending versus a short poem in four stanzas that ends with a gesture.
[1] Supports at least one point from each text with an accurate short quotation.
[1] The comparison is sustained and organised, with connectives such as «mientras que», «en cambio», «igualmente».
Accept other valid comparisons.$mq$, $mq$B$mq$),
(7, $mq$Escribe un texto descriptivo de unas 300 palabras titulado «La llegada». Puedes escribirlo como una crónica de viaje o como el comienzo de un cuento. Elige un lugar que conozcas o que imagines. Tu texto debe captar el interés de un lector adolescente. (12 marks)

Se evaluarán el propósito y la conciencia del público, la estructura del texto, las técnicas descriptivas y la riqueza y corrección de la lengua.$mq$, $mq$[1] The purpose, to describe and engage, is clear and sustained.
[1] There is clear awareness of a teenage audience, with appropriate tone and content.
[1] The chosen form (travel writing or story opening) is recognisable and the register is consistent.
[1] The opening is engaging and establishes place and time.
[1] Sensory details (several senses) bring the place to life.
[1] Figurative language (comparison, metaphor, personification) is used purposefully and is original rather than cliché.
[1] The description is organised, e.g. moving from wide to close focus, or following the narrator's movement.
[1] Paragraphs are used effectively, with a clear progression.
[1] Connectives and time markers create cohesion.
[1] Sentence length and structure are varied for effect.
[1] Verb tenses (e.g. pretérito indefinido and imperfecto, or presente) are controlled; agreement, accents and spelling are mostly accurate.
[1] The ending is effective and leaves an impression.
Credit any valid approach that meets these qualities.$mq$, $mq$C$mq$)
) as v(position, content, mark_scheme, criterion);

commit;

select s.name as subject, p.title, count(q.id) as questions
from public.past_papers p join public.subjects s on s.id = p.subject_id
left join public.paper_questions q on q.paper_id = p.id
where p.grade = 5 and (p.title like '%eAssessment-style%' or p.title like '%Full eAssessment Mock%') group by s.name, p.title order by s.name, p.title;
