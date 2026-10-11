-- Part 5 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Non-Fiction and Media > Persuasive Techniques
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Non-Fiction and Media$mq$, 5, 5 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Persuasive Techniques$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Non-Fiction and Media$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Persuasive Techniques$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué es un texto persuasivo?$mq$, $mq$["Un texto que intenta convencer al lector de una idea o de una acción","Un texto que solo cuenta una historia inventada","Un texto que describe un paisaje sin opinar","Un texto que enseña la gramática del verbo"]$mq$, 0, $mq$La finalidad de un texto persuasivo es influir en el lector: que piense algo o que haga algo.$mq$, $mq$easy$mq$),
($mq$Un anuncio dice: «¡Compra hoy! ¡Solo quedan tres unidades!». ¿Qué técnica usa?$mq$, $mq$["Una metáfora poética","Una descripción objetiva","Una cita de autoridad","Apelación a la urgencia"]$mq$, 3, $mq$Las expresiones «hoy» y «solo quedan tres» presionan al lector para actuar rápido.$mq$, $mq$easy$mq$),
($mq$«¿Quién no quiere vivir en un barrio limpio?» ¿Qué recurso es?$mq$, $mq$["Una pregunta de examen","Una definición","Una pregunta retórica","Una cita textual"]$mq$, 2, $mq$Una pregunta retórica no espera respuesta: la respuesta obvia refuerza la opinión del emisor.$mq$, $mq$easy$mq$),
($mq$Una oradora comienza: «Como médica con veinte años de experiencia…». ¿Qué tipo de apelación usa?$mq$, $mq$["Pathos (emoción)","Ethos (credibilidad del emisor)","Logos (datos numéricos)","Ironía"]$mq$, 1, $mq$El ethos busca que el público confíe en quien habla gracias a su experiencia o prestigio.$mq$, $mq$easy$mq$),
($mq$¿Qué busca el pathos en un texto persuasivo?$mq$, $mq$["Despertar emociones en el lector","Presentar estadísticas","Demostrar la fama del autor","Corregir errores de ortografía"]$mq$, 0, $mq$El pathos apela a sentimientos como la compasión, el miedo, el orgullo o la esperanza.$mq$, $mq$easy$mq$),
($mq$«Rápido, limpio y barato.» ¿Qué efecto tiene esta enumeración de tres elementos?$mq$, $mq$["Crea una atmósfera de misterio","Introduce un narrador en primera persona","Expresa duda sobre el producto","Da ritmo y sensación de que el producto lo tiene todo"]$mq$, 3, $mq$La regla de tres es muy frecuente en publicidad: es fácil de recordar y suena completa.$mq$, $mq$medium$mq$),
($mq$«Los pobres cachorros abandonados tiemblan de frío y de miedo.» ¿Qué efecto busca principalmente?$mq$, $mq$["Informar con datos exactos","Divertir al público","Provocar compasión en el lector","Describir el clima con precisión"]$mq$, 2, $mq$Los adjetivos y verbos emotivos («pobres», «tiemblan», «miedo») apelan al pathos.$mq$, $mq$medium$mq$),
($mq$«Según una encuesta ficticia a 2000 estudiantes, el 78 % duerme menos de ocho horas.» ¿Qué apelación predomina?$mq$, $mq$["Pathos (emoción)","Logos (datos y razonamiento)","Ethos (fama personal)","Humor"]$mq$, 1, $mq$Las cifras y las encuestas buscan convencer con pruebas, es decir, con logos.$mq$, $mq$medium$mq$),
($mq$«Todos juntos debemos cuidar nuestro barrio.» ¿Qué efecto tiene el «nosotros» inclusivo?$mq$, $mq$["Crea sensación de comunidad y responsabilidad compartida","Excluye al lector del problema","Muestra distancia y frialdad","Convierte el texto en una narración"]$mq$, 0, $mq$El plural inclusivo hace que el lector se sienta parte del grupo y comparta la meta.$mq$, $mq$medium$mq$),
($mq$«Es el mejor móvil del universo.» ¿Qué recurso se usa?$mq$, $mq$["Dato verificable","Ironía amarga","Cita de un experto","Hipérbole: una exageración sin prueba"]$mq$, 3, $mq$El anuncio exagera para destacar el producto; una afirmación tan absoluta no se puede comprobar.$mq$, $mq$medium$mq$),
($mq$«Únete, participa, actúa.» ¿Qué función tienen los imperativos?$mq$, $mq$["Describir hechos del pasado","Expresar duda","Dirigirse al lector directamente e invitarlo a la acción","Presentar una hipótesis"]$mq$, 2, $mq$Los verbos en imperativo funcionan como órdenes o invitaciones y buscan una reacción inmediata.$mq$, $mq$medium$mq$),
($mq$Anuncio: «Tu primera mochila para el instituto, ¡con descuento de estudiante!». ¿A qué público se dirige?$mq$, $mq$["A jubilados","A adolescentes y estudiantes","A bebés","A profesores universitarios"]$mq$, 1, $mq$La audiencia se deduce del vocabulario («instituto», «estudiante») y de la oferta.$mq$, $mq$medium$mq$),
($mq$«Hoy gastas un poco; mañana ahorrarás mucho.» ¿Qué recurso se emplea?$mq$, $mq$["Contraste (antítesis) para mostrar un beneficio futuro","Rima consonante","Onomatopeya","Personificación"]$mq$, 0, $mq$Se oponen «hoy/un poco» y «mañana/mucho» para que el sacrificio parezca pequeño.$mq$, $mq$medium$mq$),
($mq$Anuncio ficticio: «Nueve de cada diez dentistas de la clínica Sonrisa recomiendan nuestra pasta.» ¿Qué debilidad tiene esta técnica?$mq$, $mq$["No contiene ninguna cifra","Solo apela al humor","Cita un poema famoso","Usa una muestra poco clara e interesada, aunque suene a autoridad"]$mq$, 3, $mq$Parece ethos y logos, pero no se dice cuántos dentistas hay ni quién hizo el estudio: un lector crítico duda.$mq$, $mq$hard$mq$),
($mq$«Si no apoyas esta ley, no quieres a tu país.» ¿Qué problema tiene el argumento?$mq$, $mq$["Es demasiado objetivo","Usa demasiadas estadísticas","Presenta un falso dilema y chantajea emocionalmente","Está escrito en pasado"]$mq$, 2, $mq$Solo ofrece dos opciones extremas e ignora que alguien puede querer a su país y discrepar de la ley.$mq$, $mq$hard$mq$),
($mq$¿Cuál es la mejor frase analítica sobre las preguntas retóricas de un discurso?$mq$, $mq$["El autor usa preguntas retóricas","Las preguntas retóricas («¿Hasta cuándo esperaremos?») implican al público y contagian la indignación del orador","Las preguntas retóricas son muy bonitas","Hay cuatro preguntas en el segundo párrafo"]$mq$, 1, $mq$Un buen análisis nombra el recurso, cita un ejemplo y explica su efecto sobre el lector.$mq$, $mq$hard$mq$),
($mq$Cartel: una anciana sola en una casa vacía y el texto «Su casa está vacía. Tú puedes llenarla de compañía.» ¿Qué técnicas se combinan?$mq$, $mq$["Pathos y apelación directa al lector («tú»)","Logos y lenguaje técnico","Ethos y cita de experto","Ironía y humor negro"]$mq$, 0, $mq$La imagen y las frases cortas despiertan compasión, y el «tú» invita a actuar.$mq$, $mq$hard$mq$),
($mq$Para convencer a un público escéptico, ¿qué estrategia es más eficaz?$mq$, $mq$["Repetir la opinión con mayúsculas","Insultar a quienes piensan distinto","Usar solo exageraciones","Reconocer una objeción y responderla con datos verificables"]$mq$, 3, $mq$Conceder el punto contrario y rebatirlo con pruebas aumenta la credibilidad (ethos) y la fuerza del argumento.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Persuasive Techniques$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Texto persuasivo$mq$, $mq$Texto cuyo propósito es convencer al lector de una idea o llevarlo a actuar: anuncios, discursos, editoriales, campañas.$mq$),
($mq$Ethos$mq$, $mq$Apelación a la credibilidad del emisor: experiencia, prestigio, expertos citados.$mq$),
($mq$Pathos$mq$, $mq$Apelación a las emociones del lector: compasión, miedo, orgullo, esperanza.$mq$),
($mq$Logos$mq$, $mq$Apelación a la razón mediante datos, estadísticas, ejemplos y argumentos lógicos.$mq$),
($mq$Pregunta retórica$mq$, $mq$Pregunta que no espera respuesta porque la respuesta es obvia; implica al lector y refuerza una opinión.$mq$),
($mq$Regla de tres$mq$, $mq$Enumeración de tres elementos («rápido, limpio y barato») que da ritmo y sensación de totalidad.$mq$),
($mq$Hipérbole en publicidad$mq$, $mq$Exageración que destaca un producto («el mejor del universo») sin posibilidad de comprobación.$mq$),
($mq$Falacia: falso dilema$mq$, $mq$Argumento que solo ofrece dos opciones extremas: «O estás conmigo o estás contra mí».$mq$),
($mq$Fórmula de análisis$mq$, $mq$Recurso + cita breve + efecto en el lector (y relación con propósito y audiencia).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Persuasive Techniques$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Un texto persuasivo no se limita a informar: quiere que el lector cambie de opinión o actúe. Aparece en anuncios, carteles de campañas, editoriales, cartas al director, discursos y reseñas. En el examen de Lengua y Literatura, tu tarea no es solo reconocer que un texto convence, sino explicar cómo lo consigue y con qué efecto.

## Las tres apelaciones clásicas
- **Ethos**: apela a la credibilidad de quien habla. Ejemplos: «Como médica con veinte años de experiencia…», una cita de un experto, un logotipo de una institución.
- **Pathos**: apela a las emociones (compasión, miedo, orgullo, esperanza). Se logra con adjetivos emotivos, historias personales e imágenes conmovedoras.
- **Logos**: apela a la razón mediante datos, porcentajes, ejemplos y razonamientos lógicos.
Muchos textos combinan las tres. Pregúntate cuál predomina y por qué la eligió el autor para su público.

## Recursos lingüísticos frecuentes
- **Pregunta retórica**: no espera respuesta («¿Quién no quiere un barrio limpio?»). Sugiere que la respuesta es evidente.
- **Regla de tres** (enumeración de tres elementos): «rápido, limpio y barato». Da ritmo y suena completa.
- **Imperativo**: «Únete, participa, actúa». Se dirige al lector y lo empuja a la acción.
- **Hipérbole**: exageración («el mejor del universo»). Llama la atención, pero no se puede comprobar.
- **Plural inclusivo** («nosotros debemos»): crea comunidad y responsabilidad compartida.
- **Antítesis o contraste**: «hoy gastas poco; mañana ahorrarás mucho».
- **Repetición**: insiste en una idea para que se grabe.
- **Urgencia**: «solo hoy», «últimas unidades». Evita que el lector lo piense demasiado.

## Audiencia y propósito
Antes de analizar, identifica el propósito (vender, concienciar, pedir apoyo) y la audiencia (adolescentes, familias, votantes). El vocabulario, el tono y las imágenes se adaptan a ese público. Un anuncio para jóvenes usará frases cortas, humor y registro cercano; una campaña de salud para adultos puede usar datos y un tono serio.

## Argumentos débiles
Un lector crítico también detecta trucos. Una **falacia** es un razonamiento engañoso, por ejemplo el falso dilema («si no apoyas esto, no quieres a tu país») o la generalización con una muestra poco clara («nueve de cada diez expertos» sin decir cuántos ni quiénes). Señalar estas debilidades demuestra pensamiento crítico.

## Cómo se evalúa
En la evaluación en pantalla suele aparecer un anuncio, un cartel o un fragmento de discurso inventado, y preguntas del tipo «¿qué efecto tiene…?», «identifica la técnica» o «justifica por qué el texto es eficaz para su público». Se premia la respuesta que combina tres pasos: nombrar el recurso, citar una prueba breve y explicar el efecto.

## Ejemplo de análisis
Texto: «¿Hasta cuándo vamos a mirar hacia otro lado?». Recurso: pregunta retórica con plural inclusivo. Efecto: el orador no pregunta de verdad; hace sentir al público culpable y parte del problema, lo que prepara una llamada a actuar.

## Errores frecuentes
- Nombrar técnicas sin explicar su efecto («el autor usa una hipérbole»).
- Decir que algo «queda bonito» en lugar de explicar su función.
- Olvidar la audiencia.
- Citar párrafos enteros en vez de palabras clave.

Exam tip: usa siempre la fórmula recurso + cita breve + efecto en el lector, y menciona la audiencia y el propósito al menos una vez en tu respuesta.$mq$ from st;

-- Non-Fiction and Media > Articles and Speeches
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Non-Fiction and Media$mq$, 5, 5 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Articles and Speeches$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Non-Fiction and Media$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Articles and Speeches$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué función tiene el titular de una noticia?$mq$, $mq$["Resumir el hecho o atraer la atención del lector con pocas palabras","Contar toda la noticia con detalle","Citar al periodista","Firmar el texto"]$mq$, 0, $mq$El titular es breve: informa del tema y despierta interés para que el lector siga leyendo.$mq$, $mq$easy$mq$),
($mq$¿Qué preguntas suele responder la entradilla de una noticia?$mq$, $mq$["Solo cuántos años tiene el periodista","Qué opina el director del periódico","Cómo termina la historia inventada","Qué, quién, cuándo, dónde y por qué"]$mq$, 3, $mq$La entradilla resume lo esencial: las famosas «cinco W» del periodismo.$mq$, $mq$easy$mq$),
($mq$¿Cuál es la diferencia principal entre una noticia y un artículo de opinión?$mq$, $mq$["La noticia siempre es más larga","El artículo de opinión no tiene título","La noticia informa de forma objetiva; el artículo defiende un punto de vista","La noticia nunca usa citas"]$mq$, 2, $mq$Ambos son no ficción, pero la noticia busca informar y el artículo de opinión argumentar.$mq$, $mq$easy$mq$),
($mq$¿Para qué se escribe un discurso?$mq$, $mq$["Para ser leído solo en silencio","Para ser pronunciado ante un público","Para anotar datos en una tabla","Para traducir un poema"]$mq$, 1, $mq$Un discurso piensa en la voz y el oído: usa repeticiones, ritmo y una relación directa con el público.$mq$, $mq$easy$mq$),
($mq$En una noticia, ¿qué es una cita textual?$mq$, $mq$["Las palabras exactas de una persona, entre comillas","Un resumen hecho por el periodista","Una opinión sin autor","El titular de otra noticia"]$mq$, 0, $mq$Las comillas indican que se reproduce literalmente lo que dijo alguien, lo que da credibilidad.$mq$, $mq$easy$mq$),
($mq$¿Qué significa que una noticia sigue la «pirámide invertida»?$mq$, $mq$["Empieza con una anécdota y termina con la fecha","Solo contiene un párrafo","Los detalles van antes que los hechos","Los datos más importantes aparecen al principio y los detalles después"]$mq$, 3, $mq$Así el lector se informa con rapidez aunque deje de leer, y el editor puede recortar el final.$mq$, $mq$medium$mq$),
($mq$¿Cuál de estos titulares es más subjetivo?$mq$, $mq$["«Cuatrocientos alumnos limpian la playa de Marlinda»","«La playa de Marlinda acoge una jornada de limpieza»","«Los increíbles alumnos que salvaron por fin nuestra playa»","«Un instituto organiza una limpieza en la costa»"]$mq$, 2, $mq$«Increíbles», «salvaron» y «por fin» son valoraciones. Los otros titulares solo informan.$mq$, $mq$medium$mq$),
($mq$«El alcalde admitió que el presupuesto fue insuficiente.» ¿Qué sugiere el verbo «admitió»?$mq$, $mq$["Que celebra un éxito","Que reconoce algo negativo, quizá a regañadientes","Que no ha dicho nada","Que repite una pregunta"]$mq$, 1, $mq$Los verbos de habla («admitió», «alegó», «denunció») revelan la actitud del periodista; «declaró» sería más neutro.$mq$, $mq$medium$mq$),
($mq$Un orador repite: «Quiero una escuela abierta. Quiero una escuela justa. Quiero una escuela de todos». ¿Qué recurso es?$mq$, $mq$["Anáfora (repetición al inicio de frases)","Onomatopeya","Hipérbaton","Símil"]$mq$, 0, $mq$La anáfora da ritmo y énfasis, y es muy frecuente en discursos porque se recuerda al escucharla.$mq$, $mq$medium$mq$),
($mq$¿Para qué sirve un saludo como «Queridos compañeros» al comienzo de un discurso?$mq$, $mq$["Presentar las conclusiones","Citar una fuente","Dar datos estadísticos","Captar la atención y crear conexión con el público"]$mq$, 3, $mq$El saludo establece la relación entre orador y audiencia y fija el registro.$mq$, $mq$medium$mq$),
($mq$Una noticia dice: «Según fuentes del ayuntamiento…». ¿Qué debe plantearse un lector crítico?$mq$, $mq$["Si el periodista usa letra cursiva","Si la noticia tiene más de dos párrafos","Si la fuente está identificada y es fiable","Si hay mayúsculas en el titular"]$mq$, 2, $mq$Las fuentes anónimas o vagas restan solidez. Citar quién, cómo y cuándo aumenta la credibilidad.$mq$, $mq$medium$mq$),
($mq$«La biblioteca recibió 12 000 visitas el año pasado y es el mejor lugar del barrio.» ¿Qué parte es una opinión?$mq$, $mq$["«recibió 12 000 visitas»","«es el mejor lugar del barrio»","«el año pasado»","«la biblioteca»"]$mq$, 1, $mq$El dato numérico y la fecha se pueden comprobar; «el mejor» es una valoración personal.$mq$, $mq$medium$mq$),
($mq$¿Cuál es una estructura habitual de un discurso persuasivo?$mq$, $mq$["Introducción que capta la atención, argumentos y llamada final a la acción","Resumen, anécdota y despedida sin conclusión","Solo una lista de datos","Diálogo entre dos personajes"]$mq$, 0, $mq$Un discurso eficaz abre con gancho, desarrolla razones y cierra con una petición clara.$mq$, $mq$medium$mq$),
($mq$Texto: «El ayuntamiento, que gastó dos millones en una plaza, recorta ahora la biblioteca.» ¿Qué revela la construcción de la frase?$mq$, $mq$["Es una noticia completamente neutral","Es un poema lírico","Es un diálogo teatral","Aunque parece informar, el contraste sugiere una crítica al ayuntamiento"]$mq$, 3, $mq$La subordinada coloca el gasto junto al recorte y orienta al lector a juzgar: hay un sesgo implícito.$mq$, $mq$hard$mq$),
($mq$Titular: «El ayuntamiento “ahorra” cerrando la biblioteca». ¿Qué indican las comillas en «ahorra»?$mq$, $mq$["Que es una cita exacta del alcalde","Que la palabra está mal escrita","Ironía o distancia crítica del periodista","Que es un título de libro"]$mq$, 2, $mq$Las comillas pueden marcar un uso irónico: el autor duda de que cerrar sea realmente ahorrar.$mq$, $mq$hard$mq$),
($mq$«No les pido que cambien el mundo; les pido que cambien hoy un hábito.» ¿Qué efecto principal logra?$mq$, $mq$["Genera confusión sobre el tema","Hace la petición más alcanzable al pasar de lo enorme a lo pequeño","Presenta datos científicos","Aleja al público de la acción"]$mq$, 1, $mq$El contraste entre «el mundo» y «un hábito» reduce el esfuerzo percibido y facilita que el público acepte actuar.$mq$, $mq$hard$mq$),
($mq$Un orador empieza con «yo» («Yo crecí en este barrio») y termina con «nosotros» («Juntos lo cambiaremos»). ¿Qué efecto tiene este cambio?$mq$, $mq$["Pasa de la experiencia personal a un compromiso colectivo","Muestra que el orador cambia de tema","Indica que el discurso es una carta","Revela que el orador se ha equivocado"]$mq$, 0, $mq$La experiencia personal da credibilidad (ethos) y el «nosotros» final implica al público en la acción.$mq$, $mq$hard$mq$),
($mq$«Es cierto que la medida cuesta dinero; sin embargo, el ahorro en salud será mayor.» ¿Qué función cumple la primera parte?$mq$, $mq$["Abandona la tesis del autor","Introduce una anécdota personal","Cambia de género textual","Concede un argumento contrario para refutarlo después y ganar credibilidad"]$mq$, 3, $mq$La concesión seguida de refutación muestra equilibrio y fortalece la posición del autor.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Articles and Speeches$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Titular$mq$, $mq$Título breve de una noticia que resume el hecho o atrae la atención del lector.$mq$),
($mq$Entradilla$mq$, $mq$Primer párrafo de una noticia: responde a qué, quién, cuándo, dónde y por qué.$mq$),
($mq$Pirámide invertida$mq$, $mq$Estructura de la noticia: lo más importante al principio y los detalles después.$mq$),
($mq$Hecho frente a opinión$mq$, $mq$Un hecho se puede comprobar; una opinión es una valoración personal («el mejor»).$mq$),
($mq$Verbos de habla$mq$, $mq$«Declaró», «admitió», «denunció»: según el verbo, el periodista revela su actitud hacia lo dicho.$mq$),
($mq$Partes de un discurso$mq$, $mq$Introducción (saludo, gancho, tesis), desarrollo (argumentos) y conclusión (llamada a la acción).$mq$),
($mq$Anáfora$mq$, $mq$Repetición de palabras al inicio de frases sucesivas; da ritmo y énfasis, muy común en discursos.$mq$),
($mq$Concesión y refutación$mq$, $mq$Reconocer una objeción («es cierto que…») y responderla («sin embargo…») para ganar credibilidad.$mq$),
($mq$Sesgo$mq$, $mq$Orientación parcial de un texto mediante selección de datos, adjetivos valorativos, comillas irónicas u omisiones.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Articles and Speeches$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Los artículos y los discursos son géneros de no ficción con propósitos distintos. Un artículo de prensa puede informar (noticia, reportaje) o argumentar (editorial, columna de opinión, carta al director). Un discurso está pensado para la voz: se escribe para ser escuchado por un público presente. En el examen verás extractos inventados de ambos géneros y tendrás que analizar su estructura, su lenguaje y su efecto.

## La noticia
Una noticia informa de un hecho reciente. Sus partes son:
- **Titular**: breve, resume el tema y capta la atención.
- **Entradilla**: primer párrafo que responde a qué, quién, cuándo, dónde y por qué.
- **Cuerpo**: detalles, citas y contexto, ordenados de más a menos importante (**pirámide invertida**).
- **Fuentes y citas textuales**: dan credibilidad. Un lector crítico se pregunta si las fuentes están identificadas.
El registro es formal y el lenguaje debería ser objetivo, aunque la selección de datos y los verbos de habla («declaró», «admitió», «denunció») pueden revelar una actitud.

## El artículo de opinión y el editorial
Aquí el autor defiende una tesis. Suele presentar el tema, ofrecer argumentos con ejemplos y datos, **conceder** una objeción («es cierto que cuesta dinero…») y refutarla, y cerrar con una conclusión o propuesta. El lenguaje puede ser valorativo: adjetivos, ironía, preguntas retóricas. Distingue siempre **hecho** (se puede comprobar) y **opinión** (valoración personal).

## El discurso
Un discurso se organiza en:
- **Introducción**: saludo («Queridos compañeros»), gancho (anécdota, pregunta, dato) y tesis.
- **Desarrollo**: argumentos claros, ordenados y con ejemplos.
- **Conclusión**: resumen y llamada a la acción.
Como se escucha una sola vez, usa recursos de oralidad: **anáfora** (repetir el inicio de frases), tríadas, preguntas retóricas, frases cortas, segunda persona y plural inclusivo («nosotros»). El cambio de «yo» a «nosotros» suele marcar el paso de la experiencia personal al compromiso colectivo.

## Sesgo y perspectiva
Ningún texto es completamente neutral. Fíjate en el orden de la información, en lo que se omite, en los adjetivos valorativos, en las comillas irónicas («el ayuntamiento “ahorra”») y en los verbos de habla. Compara cómo dos titulares sobre el mismo hecho orientan al lector de manera distinta.

## Cómo se evalúa
En la prueba en pantalla es habitual encontrar un artículo o un fragmento de discurso inventado con preguntas como «identifica el propósito», «explica el efecto del titular» o «analiza cómo el autor construye su credibilidad». Se valora que cites palabras concretas y expliques su efecto, y que relaciones el género con la audiencia.

## Ejemplo de análisis
Texto: «No les pido que cambien el mundo; les pido que cambien hoy un hábito». Contraste entre «el mundo» y «un hábito». Efecto: la petición parece pequeña y realizable, y por eso el público se siente capaz de aceptarla.

## Errores frecuentes
- Confundir tema y propósito.
- Hablar del género sin citar el texto.
- Tratar toda opinión como si fuera un hecho.

Exam tip: antes de responder, identifica género, propósito y audiencia en una línea; después comenta recursos con la fórmula cita breve + efecto, y recuerda distinguir hecho y opinión.$mq$ from st;

-- Non-Fiction and Media > Visual and Multimodal Texts
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Non-Fiction and Media$mq$, 5, 5 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Visual and Multimodal Texts$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Non-Fiction and Media$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Visual and Multimodal Texts$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué es un texto multimodal?$mq$, $mq$["Un texto que combina varios modos, como palabras, imágenes, colores o sonido","Un texto escrito solo con palabras","Un texto escrito en varios idiomas","Un texto con muchas faltas de ortografía"]$mq$, 0, $mq$Un cartel o un anuncio de vídeo son multimodales porque el significado nace de la combinación de varios modos.$mq$, $mq$easy$mq$),
($mq$En un cartel, ¿qué es el «primer plano»?$mq$, $mq$["El fondo lejano","El pie de foto","El lema final","Lo que aparece más cerca del observador y destaca primero"]$mq$, 3, $mq$El primer plano atrae la mirada; el fondo aporta contexto.$mq$, $mq$easy$mq$),
($mq$¿Qué indica normalmente el color rojo en un cartel de advertencia?$mq$, $mq$["Calma y relajación","Naturaleza y ecología","Peligro o alerta","Lujo discreto"]$mq$, 2, $mq$Los colores tienen asociaciones culturales; el rojo suele indicar peligro, urgencia o pasión.$mq$, $mq$easy$mq$),
($mq$¿Qué es un lema (eslogan)?$mq$, $mq$["Un párrafo largo de datos","Una frase breve y fácil de recordar que resume el mensaje","La firma del fotógrafo","Una nota a pie de página"]$mq$, 1, $mq$El lema condensa la idea principal de una campaña y suele usar rima, repetición o juego de palabras.$mq$, $mq$easy$mq$),
($mq$¿Qué es el pie de foto?$mq$, $mq$["El texto breve que acompaña y explica una imagen","La fecha de impresión","El título de un libro","Un tipo de letra"]$mq$, 0, $mq$El pie orienta la interpretación de la imagen y puede cambiar su sentido.$mq$, $mq$easy$mq$),
($mq$Una fotografía muestra a una niña pequeña desde arriba, mirando hacia lo alto. ¿Qué sensación crea ese ángulo?$mq$, $mq$["Poder y dominio","Alegría ruidosa","Velocidad","Vulnerabilidad o pequeñez"]$mq$, 3, $mq$Un plano desde arriba (picado) hace que el sujeto parezca pequeño y frágil.$mq$, $mq$medium$mq$),
($mq$Un anuncio usa un plano contrapicado (desde abajo) de un deportista. ¿Qué efecto suele buscar?$mq$, $mq$["Hacerlo parecer débil","Ocultar su rostro","Hacerlo parecer fuerte, admirable o poderoso","Indicar que es un dibujo"]$mq$, 2, $mq$Mirar hacia arriba al sujeto lo engrandece y aumenta su prestigio.$mq$, $mq$medium$mq$),
($mq$En un cartel, el texto está en letras grandes y mayúsculas, con tipografía gruesa. ¿Qué transmite?$mq$, $mq$["Delicadeza y misterio","Fuerza, urgencia o importancia","Duda","Ironía suave"]$mq$, 1, $mq$La tipografía forma parte del mensaje: el tamaño y el grosor señalan prioridad y tono.$mq$, $mq$medium$mq$),
($mq$Una campaña sobre el reciclaje usa fondo verde, hojas y letras redondeadas. ¿Qué mensaje transmite el conjunto?$mq$, $mq$["Un mensaje amable y ecológico","Una advertencia de peligro","Un tono violento","Un ambiente nocturno de misterio"]$mq$, 0, $mq$El verde y las hojas se asocian con la naturaleza; las formas redondeadas suavizan el tono.$mq$, $mq$medium$mq$),
($mq$En un cartel, la mirada de una persona apunta directamente a la cámara. ¿Qué efecto tiene?$mq$, $mq$["Muestra que el personaje está distraído","Crea sensación de intimidad con el fondo","Hace que la imagen parezca antigua","Interpela al espectador y crea conexión"]$mq$, 3, $mq$El contacto visual directo («mirada de demanda») invita al espectador a implicarse.$mq$, $mq$medium$mq$),
($mq$En un anuncio, el producto aparece en el centro y el resto de elementos lo rodean. ¿Qué función tiene la composición?$mq$, $mq$["Ocultar el producto","Indicar un error de diseño","Dirigir la atención hacia el producto","Reducir el impacto del mensaje"]$mq$, 2, $mq$El centro y la simetría concentran la mirada en el elemento clave.$mq$, $mq$medium$mq$),
($mq$Un cartel contra el ruido muestra una ciudad en blanco y negro con un único globo rojo. ¿Qué efecto produce el color?$mq$, $mq$["Hace que todo parezca igual","Destaca el globo y le da valor simbólico","Indica que el cartel es de otro país","Elimina el mensaje"]$mq$, 1, $mq$El contraste cromático dirige la mirada y sugiere que lo coloreado es lo importante.$mq$, $mq$medium$mq$),
($mq$Un cartel muestra un reloj de arena con arena casi agotada y el texto «Queda poco tiempo». ¿Cómo se relacionan imagen y texto?$mq$, $mq$["Se refuerzan: ambos transmiten urgencia","Se contradicen","No tienen relación","La imagen solo es decorativa"]$mq$, 0, $mq$La imagen simboliza el paso del tiempo y el texto lo dice con palabras; juntos intensifican el mensaje.$mq$, $mq$medium$mq$),
($mq$Cartel de una campaña sobre alimentación saludable: foto de una manzana con la leyenda «Tu cuerpo te lo agradecerá». ¿A qué apelación recurre sobre todo?$mq$, $mq$["Logos con estadísticas","Ethos de un científico famoso","Humor negro","Pathos y beneficio personal, con apelación directa («tu»)"]$mq$, 3, $mq$La imagen agradable y el «tu» personalizan el beneficio; no hay datos ni expertos.$mq$, $mq$hard$mq$),
($mq$Un anuncio tiene un pie de foto que dice: «Marta, 14 años, ahorró 200 euros en un año». La foto muestra a Marta sonriendo. ¿Qué logra el pie de foto?$mq$, $mq$["Contradice la imagen","Introduce un narrador omnisciente","Da credibilidad y cercanía con un caso concreto","Oculta la identidad de la protagonista"]$mq$, 2, $mq$Un testimonio con datos concretos y una persona real o creíble ayuda a convencer.$mq$, $mq$hard$mq$),
($mq$Un cartel muestra a un grupo de jóvenes de espaldas, en fila, mirando un horizonte con sol naciente. ¿Qué lectura simbólica es más razonable?$mq$, $mq$["Fracaso colectivo","Esperanza y futuro compartido","Aburrimiento","Miedo al presente"]$mq$, 1, $mq$Los personajes de espaldas, el horizonte y el amanecer se asocian con futuro y esperanza; el grupo sugiere unión.$mq$, $mq$hard$mq$),
($mq$Un estudiante escribe: «El cartel usa mucho color». ¿Cómo mejorar esta frase para el examen?$mq$, $mq$["Citar el color concreto y explicar su efecto en el mensaje y el público","Añadir otra frase igual","Escribir en mayúsculas","Copiar el lema del cartel completo"]$mq$, 0, $mq$El análisis exige un detalle visual específico, su significado y su efecto sobre la audiencia.$mq$, $mq$hard$mq$),
($mq$Un anuncio pide ayuda para un refugio de animales. Muestra un perro gris, solo, en un plano picado, y un texto blanco sobre fondo negro: «No pide mucho. Solo a alguien». ¿Qué combinación de recursos construye el mensaje?$mq$, $mq$["Un tono humorístico y colores vivos","Datos estadísticos y un experto citado","Una narración en pasado con diálogos","Plano picado, colores apagados y frases cortas crean pathos y piden acción"]$mq$, 3, $mq$El plano picado vuelve vulnerable al perro, los colores apagados refuerzan la tristeza y las frases breves son directas; todo apela a la compasión.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Visual and Multimodal Texts$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Texto multimodal$mq$, $mq$Texto que combina varios modos de significado: palabras, imagen, color, tipografía, composición, sonido.$mq$),
($mq$Plano picado$mq$, $mq$Imagen tomada desde arriba; hace que el sujeto parezca pequeño, débil o vulnerable.$mq$),
($mq$Plano contrapicado$mq$, $mq$Imagen tomada desde abajo; engrandece al sujeto y lo muestra fuerte o admirable.$mq$),
($mq$Mirada directa$mq$, $mq$Cuando el personaje mira a la cámara, interpela al espectador y crea conexión.$mq$),
($mq$Lema o eslogan$mq$, $mq$Frase breve y memorable que resume el mensaje de una campaña.$mq$),
($mq$Pie de foto$mq$, $mq$Texto breve junto a una imagen que la explica y orienta su interpretación.$mq$),
($mq$Simbolismo del color$mq$, $mq$Rojo: peligro o urgencia; verde: naturaleza o salud; azul: calma; negro: seriedad. Depende de la cultura.$mq$),
($mq$Imagen y texto$mq$, $mq$Pueden reforzarse, completarse o contradecirse (ironía). Analiza siempre su relación.$mq$),
($mq$Fórmula de análisis visual$mq$, $mq$Detalle visual concreto + significado + efecto en la audiencia.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Visual and Multimodal Texts$mq$ and p.name = $mq$Non-Fiction and Media$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Hoy leemos mucho más que palabras: carteles, anuncios, portadas, infografías, memes o vídeos. Un texto multimodal combina varios modos de comunicar, como el lenguaje escrito, la imagen, el color, la tipografía, la composición y, en el caso del vídeo, el sonido. En el examen debes demostrar que sabes leer imágenes con la misma atención con la que lees un párrafo.

## Elementos que se analizan
- **Imagen**: qué se muestra, quién aparece, qué gestos y qué mirada tienen los personajes. Si el personaje mira a la cámara, interpela al espectador.
- **Plano y ángulo**: un plano **picado** (desde arriba) hace que el sujeto parezca pequeño o vulnerable; un plano **contrapicado** (desde abajo) lo engrandece; un primer plano crea intimidad.
- **Composición**: lo que está en el centro, en primer plano o en la parte superior llama primero la atención. El espacio vacío puede sugerir soledad.
- **Color**: tiene asociaciones culturales. El rojo suele indicar peligro, urgencia o pasión; el verde, naturaleza o salud; el azul, calma o confianza; el negro, seriedad o misterio. Un color que destaca sobre un fondo gris suele tener valor simbólico.
- **Tipografía**: las letras grandes, gruesas y en mayúsculas transmiten fuerza o urgencia; las finas y redondeadas, delicadeza o amabilidad.
- **Texto verbal**: titular, lema, pie de foto, cuerpo de texto y logotipo. El **lema** o eslogan es breve y fácil de recordar. El **pie de foto** orienta la interpretación de la imagen.

## Relación entre imagen y texto
Pregúntate cómo se relacionan. Pueden **reforzarse** (el reloj de arena y el texto «Queda poco tiempo»), **completarse** (la imagen muestra y el texto explica) o **contradecirse** (para crear ironía o humor). Nunca analices solo uno de los dos.

## Propósito y audiencia
Igual que en los textos escritos, identifica para qué se creó el mensaje (vender, informar, concienciar) y a quién se dirige. El nivel de lenguaje, los personajes y los colores se eligen para esa audiencia. Un cartel para adolescentes puede usar colores vivos, memes y registro coloquial; uno institucional, un tono más sobrio.

## Cómo se evalúa
La evaluación en pantalla suele presentar una descripción de un cartel o anuncio inventado, a veces con texto y una breve descripción de la imagen, y preguntas como «explica cómo el diseño transmite urgencia» o «analiza la relación entre imagen y lema». Se valora que identifiques el recurso, aportes un detalle concreto y expliques su efecto.

## Ejemplo de análisis
Descripción: un perro gris, solo, visto desde arriba; texto blanco sobre fondo negro: «No pide mucho. Solo a alguien». Análisis: el plano picado hace vulnerable al perro, los colores apagados refuerzan la tristeza, y las frases cortas son directas. El conjunto apela a la compasión (pathos) y prepara la petición de adopción.

## Errores frecuentes
- Describir la imagen sin interpretarla.
- Decir «es llamativo» sin explicar por qué.
- Ignorar el texto o la tipografía.
- Olvidar que el significado de un color depende del contexto cultural.

Exam tip: usa la secuencia detalle visual + significado + efecto en la audiencia, y comenta siempre cómo se relacionan imagen y texto.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;