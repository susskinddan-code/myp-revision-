-- Part 8 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- eAssessment Skills for Literature > Command Terms and Question Types
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Literature$mq$, 5, 8 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Command Terms and Question Types$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Literature$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Command Terms and Question Types$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$En un examen, la orden «Identifica» pide:$mq$, $mq$["Señalar o nombrar algo sin desarrollarlo","Valorar con criterios y conclusión","Comparar tres textos","Escribir un poema"]$mq$, 0, $mq$«Identifica» exige localizar o nombrar un elemento; es una orden de nivel bajo.$mq$, $mq$easy$mq$),
($mq$La orden «Explica» pide:$mq$, $mq$["Copiar una cita larga","Solo nombrar un recurso","Contar tu opinión sin pruebas","Dar razones y mostrar cómo o por qué ocurre algo"]$mq$, 3, $mq$Explicar es desarrollar causas, relaciones y efectos.$mq$, $mq$easy$mq$),
($mq$La orden «Resume» pide:$mq$, $mq$["Analizar cada palabra","Juzgar la calidad del texto","Presentar de forma breve las ideas principales","Reescribir el texto con más detalles"]$mq$, 2, $mq$Un resumen es breve y selecciona lo esencial.$mq$, $mq$easy$mq$),
($mq$La orden «Compara y contrasta» exige:$mq$, $mq$["Solo similitudes","Señalar similitudes y diferencias","Solo diferencias de ortografía","Una opinión personal sin mencionar los textos"]$mq$, 1, $mq$Debes tratar ambos aspectos: lo que se parece y lo que se diferencia.$mq$, $mq$easy$mq$),
($mq$La orden «Justifica» pide:$mq$, $mq$["Dar razones o pruebas que apoyen tu afirmación","Negar la afirmación","Memorizar el texto","Resumir el argumento contrario"]$mq$, 0, $mq$Justificar es sostener lo que dices con evidencia del texto.$mq$, $mq$easy$mq$),
($mq$¿Qué orden exige un nivel de pensamiento más profundo?$mq$, $mq$["Identifica","Nombra","Señala","Evalúa"]$mq$, 3, $mq$«Evalúa» implica valorar con criterios y llegar a un juicio razonado; las otras órdenes son más sencillas.$mq$, $mq$medium$mq$),
($mq$«Analiza el efecto de la repetición en el poema». ¿Qué debes hacer?$mq$, $mq$["Decir que la repetición es bonita","Copiar el poema","Dividir el recurso en partes y explicar cómo contribuye al sentido","Hablar de la vida del poeta"]$mq$, 2, $mq$El análisis exige descomponer, citar y explicar el efecto sobre el significado.$mq$, $mq$medium$mq$),
($mq$En una pregunta de opción múltiple, el enunciado dice «¿Cuál es la idea principal?». ¿Qué estrategia es útil?$mq$, $mq$["Elegir la opción más larga siempre","Leer el texto, anticipar la respuesta y descartar opciones que solo mencionan detalles","Escoger la primera que suene bien","Ignorar el texto"]$mq$, 1, $mq$La idea principal resume el conjunto; los detalles secundarios son típicos distractores.$mq$, $mq$medium$mq$),
($mq$¿Cuál es la diferencia entre «Describe» y «Explica»?$mq$, $mq$["Describe dice cómo es algo; explica dice por qué o cómo funciona","No hay ninguna diferencia","Describe pide una opinión; explica pide una cita","Explica pide menos que describe"]$mq$, 0, $mq$Describir da características; explicar añade causas, razones y efectos.$mq$, $mq$medium$mq$),
($mq$En una respuesta extensa, ¿qué estructura ayuda a organizar un párrafo analítico?$mq$, $mq$["Título, subtítulo y firma","Introducción, anécdota y despedida","Pregunta, pregunta y pregunta","Punto, evidencia y explicación"]$mq$, 3, $mq$Afirmas una idea, la apoyas con una cita breve y explicas su efecto.$mq$, $mq$medium$mq$),
($mq$La orden «Discute» pide:$mq$, $mq$["Contar un cuento","Repetir un único argumento","Presentar varios puntos de vista y llegar a una conclusión razonada","Sustituir la pregunta por otra"]$mq$, 2, $mq$Discutir es explorar ventajas, inconvenientes o enfoques y concluir con criterio.$mq$, $mq$medium$mq$),
($mq$La consigna dice: «Justifica tu respuesta con dos citas». Solo incluyes una. ¿Qué ocurre?$mq$, $mq$["Tu respuesta es perfecta","Respondes solo a una parte de lo pedido","Se recompensa la brevedad","La orden no importa"]$mq$, 1, $mq$Los números de la consigna indican lo que debes aportar; contarlos evita perder puntos.$mq$, $mq$medium$mq$),
($mq$La pregunta empieza con «Según el texto…». ¿De dónde debe salir la respuesta?$mq$, $mq$["Del propio texto, no de tus conocimientos previos","De tu experiencia personal","De otro texto cualquiera","De un diccionario de memoria"]$mq$, 0, $mq$Esa fórmula exige basarse en la información del extracto.$mq$, $mq$medium$mq$),
($mq$Orden: «Evalúa la eficacia del cartel para persuadir a adolescentes». ¿Qué respuesta cumple mejor?$mq$, $mq$["La que solo describe los colores","La que enumera técnicas sin comentar","La que resume la historia del cartel","La que juzga la eficacia con criterios, evidencias del cartel, referencia a la audiencia y una conclusión"]$mq$, 3, $mq$Evaluar es valorar: criterios, pruebas, relación con el público y juicio final.$mq$, $mq$hard$mq$),
($mq$Texto inventado: «Hugo cerró el cuaderno con un golpe seco y salió sin despedirse». ¿Qué inferencia está mejor apoyada?$mq$, $mq$["Hugo está disfrutando del estudio","Hugo tiene prisa por una cita","Hugo está molesto","Hugo es muy educado"]$mq$, 2, $mq$El «golpe seco» y el marcharse «sin despedirse» sugieren enfado; las otras opciones no tienen apoyo textual.$mq$, $mq$hard$mq$),
($mq$Para «Compara y contrasta dos textos», ¿qué organización funciona mejor?$mq$, $mq$["Resumir cada texto por separado sin relacionarlos","Por puntos de comparación, con conectores como «mientras que» y «en cambio»","Copiar los dos textos","Hablar solo del primero"]$mq$, 1, $mq$Una respuesta integrada compara punto por punto y usa conectores para marcar similitudes y diferencias.$mq$, $mq$hard$mq$),
($mq$¿Qué respuesta NO cumple la orden «Explica cómo el autor crea suspense en el párrafo 2»?$mq$, $mq$["«El párrafo trata de un viaje en tren»","Cita «de repente» y explica que acelera el ritmo","Cita dos frases breves y explica su efecto de tensión","Subraya «corrió» y explica la sensación de rapidez"]$mq$, 0, $mq$Resumir el tema no explica el procedimiento ni su efecto. Las demás respuestas sí ligan técnica y efecto.$mq$, $mq$hard$mq$),
($mq$«Hay una metáfora.» ¿Qué falta para que sea una respuesta de nivel alto?$mq$, $mq$["Más adjetivos","Escribirla en mayúsculas","Repetir la pregunta","Una cita, el efecto que produce y su vínculo con el propósito o la audiencia"]$mq$, 3, $mq$Identificar no basta: hay que citar, explicar el efecto y relacionarlo con el sentido global.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Command Terms and Question Types$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Identifica$mq$, $mq$Señalar o nombrar un elemento; respuesta breve.$mq$),
($mq$Describe$mq$, $mq$Decir cómo es algo, con detalles; no es lo mismo que explicar.$mq$),
($mq$Explica$mq$, $mq$Dar razones y mostrar cómo o por qué ocurre algo.$mq$),
($mq$Analiza$mq$, $mq$Descomponer un texto o recurso en partes y explicar cómo contribuyen al significado.$mq$),
($mq$Compara y contrasta$mq$, $mq$Indicar similitudes y diferencias, organizadas por puntos de comparación.$mq$),
($mq$Justifica$mq$, $mq$Sostener una afirmación con razones y evidencias del texto.$mq$),
($mq$Discute$mq$, $mq$Presentar varios puntos de vista y concluir con un juicio razonado.$mq$),
($mq$Evalúa$mq$, $mq$Emitir un juicio argumentado sobre eficacia o valor, con criterios y pruebas.$mq$),
($mq$Estructura punto-evidencia-explicación$mq$, $mq$Afirmación, cita breve del texto y explicación del efecto en el lector.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Command Terms and Question Types$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$La evaluación en pantalla de Lengua y Literatura combina preguntas cerradas (opción múltiple) con respuestas más extensas sobre textos nuevos. Para sacar el máximo partido de tu preparación, debes saber qué te pide exactamente cada pregunta. Las órdenes (command terms) indican la profundidad y el tipo de respuesta esperados. Si ignoras la orden, aunque sepas la materia, puedes perder puntos.

## Órdenes frecuentes y qué significan
- **Identifica / Señala / Nombra**: localiza un elemento. Respuesta breve.
- **Describe**: explica cómo es algo, con detalles.
- **Resume**: presenta las ideas principales en pocas palabras.
- **Explica**: da razones y muestra cómo o por qué ocurre algo.
- **Analiza**: descompón el texto o recurso en partes y explica cómo contribuyen al significado.
- **Compara y contrasta**: indica similitudes y diferencias entre textos, ideas o recursos.
- **Justifica / Apoya**: sostén tu afirmación con razones y pruebas (citas) del texto.
- **Discute**: presenta varios puntos de vista y llega a una conclusión razonada.
- **Evalúa**: emite un juicio argumentado sobre la eficacia, el valor o el éxito, usando criterios y evidencias.
Cuanto más alto es el nivel de la orden (evaluar, analizar), más debes interpretar y no solo localizar.

## Tipos de pregunta
1. **Opción múltiple**: lee el texto antes de ver las opciones, anticipa tu respuesta y elimina las opciones incorrectas. Atención a palabras clave como «principal», «no», «mejor» y a distractores que mencionan un detalle cierto pero irrelevante.
2. **Respuesta corta**: contesta directamente, con una cita o un dato.
3. **Respuesta extensa de análisis**: usa párrafos con la estructura **punto + evidencia + explicación**.
4. **Escritura creativa o argumentativa**: produce un texto adecuado a género, audiencia y propósito.

## Leer bien la consigna
- Subraya la orden, el texto al que se refiere («en el párrafo 2», «en el cartel») y los números («dos citas»).
- La fórmula «Según el texto…» significa que la respuesta debe basarse en el extracto y no en conocimientos externos.
- Responde exactamente a lo que se pide: si piden explicar el efecto, un resumen del contenido no basta.

## Cómo responder según la orden
- **Explica cómo** → recurso + cita breve + efecto.
- **Compara y contrasta** → organiza por puntos de comparación y usa conectores («mientras que», «en cambio», «de igual manera»).
- **Evalúa** → establece criterios, aporta pruebas, relaciona con la audiencia y cierra con un juicio.
- **Justifica** → afirmación + cita + razón.

## Ejemplo
Orden: «Explica cómo el autor crea suspense en el párrafo 2». Respuesta fuerte: «El autor acelera el ritmo con frases breves como “corrió” y “tropezó”, lo que transmite urgencia y hace que el lector sienta la tensión de la huida». La respuesta débil dice «el párrafo trata de un viaje en tren», porque no explica nada.

## Cómo se evalúa
Los examinadores comprueban si la respuesta cumple la orden, si se apoya en el texto y si muestra comprensión. Las respuestas que solo resumen o que usan términos técnicos sin efecto reciben pocos puntos.

## Errores frecuentes
- Resumir cuando se pide analizar.
- No citar el texto.
- Responder solo a una parte de la consigna.
- Escribir «hay una metáfora» sin efecto ni cita.

Exam tip: encierra la orden en un círculo y, antes de entregar cada respuesta, pregúntate: ¿he hecho exactamente lo que dice este verbo?$mq$ from st;

-- eAssessment Skills for Literature > Time Management
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Literature$mq$, 5, 8 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Time Management$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Literature$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Time Management$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$En un examen de sesenta minutos, ¿qué conviene hacer al empezar?$mq$, $mq$["Leer todas las preguntas y planificar el tiempo","Responder sin leer la tarea","Dedicar toda la hora a la primera pregunta","Esperar a que acabe el tiempo"]$mq$, 0, $mq$Una visión general al inicio permite repartir el tiempo según la dificultad y los puntos.$mq$, $mq$easy$mq$),
($mq$¿Qué conviene hacer si una pregunta de opción múltiple es muy difícil?$mq$, $mq$["Quedarse bloqueado cinco minutos","Dejar toda la prueba en blanco","Cambiar todas las demás respuestas","Marcarla, pasar a la siguiente y volver después"]$mq$, 3, $mq$Avanzar evita quedarse sin tiempo para preguntas más fáciles.$mq$, $mq$easy$mq$),
($mq$¿Para qué sirve reservar unos minutos al final?$mq$, $mq$["Para empezar una tarea nueva","Para copiar el texto","Para revisar respuestas y corregir errores","Para terminar antes siempre"]$mq$, 2, $mq$La revisión final permite detectar olvidos, ortografía y respuestas incompletas.$mq$, $mq$easy$mq$),
($mq$¿Qué es un reloj de pantalla en una prueba en línea?$mq$, $mq$["Un traductor","Un temporizador que muestra el tiempo restante","Un corrector ortográfico","Una calculadora"]$mq$, 1, $mq$Consultarlo con regularidad ayuda a mantener el ritmo.$mq$, $mq$easy$mq$),
($mq$Si una tarea vale más puntos, ¿cuánto tiempo conviene dedicarle?$mq$, $mq$["Más tiempo que a las tareas de menos puntos","Menos tiempo","El mismo tiempo siempre","Ninguno"]$mq$, 0, $mq$El reparto del tiempo debe reflejar el valor de cada tarea.$mq$, $mq$easy$mq$),
($mq$Tienes sesenta minutos: diez preguntas de opción múltiple y una redacción extensa. ¿Qué reparto es más razonable?$mq$, $mq$["Cincuenta minutos para las preguntas y diez para la redacción","Todo el tiempo para la redacción","Veinte minutos para planear y cero para escribir","Unos quince minutos para las preguntas y unos cuarenta para la redacción, con repaso final"]$mq$, 3, $mq$La redacción vale más y exige planificar, escribir y revisar.$mq$, $mq$medium$mq$),
($mq$En una pregunta de opción múltiple tardas más de dos minutos. ¿Qué decisión es mejor?$mq$, $mq$["Seguir sin elegir ninguna","Reiniciar la prueba","Eliminar las opciones imposibles, elegir la mejor y seguir","Repetir la pregunta en voz alta"]$mq$, 2, $mq$Si ya has reducido las opciones, es mejor decidir y continuar; puedes volver si sobra tiempo.$mq$, $mq$medium$mq$),
($mq$¿Cuál es el uso más eficaz de cinco minutos de planificación antes de escribir?$mq$, $mq$["Escribir la introducción completa","Anotar tesis, tres ideas con ejemplos y el orden de los párrafos","Dibujar adornos","Contar las palabras ya escritas"]$mq$, 1, $mq$Un esquema breve evita bloqueos y repeticiones.$mq$, $mq$medium$mq$),
($mq$Te quedan diez minutos y falta la conclusión. ¿Qué haces?$mq$, $mq$["Escribir una conclusión breve que retome la tesis","Empezar un párrafo nuevo con otra idea","Abandonar el texto","Releer solo la introducción"]$mq$, 0, $mq$Una conclusión corta da cierre y muestra control de la estructura.$mq$, $mq$medium$mq$),
($mq$¿Qué señal indica que te estás extendiendo demasiado en un párrafo?$mq$, $mq$["Hay una cita bien explicada","Usas un conector","Incluyes un ejemplo","Dedicas más tiempo del previsto y repites ideas"]$mq$, 3, $mq$La repetición consume tiempo sin aumentar la calidad.$mq$, $mq$medium$mq$),
($mq$¿Qué hábito ayuda a gestionar la ansiedad durante la prueba?$mq$, $mq$["Pensar en la nota final todo el rato","Comparar tu ritmo con el de los demás","Respirar, avanzar paso a paso y centrarse en la pregunta actual","Saltarte la lectura de las instrucciones"]$mq$, 2, $mq$Controlar la ansiedad favorece la concentración y el uso eficaz del tiempo.$mq$, $mq$medium$mq$),
($mq$Respondes una pregunta de respuesta extensa en veinte minutos cuando planeaste diez. ¿Qué es lo más razonable?$mq$, $mq$["Seguir hasta acabar aunque falte tiempo para otras","Resumir el resto con ideas esenciales y pasar a la siguiente","Borrarlo todo","Dejar el resto sin leer"]$mq$, 1, $mq$Es preferible una respuesta completa pero concisa y aprovechar las demás preguntas.$mq$, $mq$medium$mq$),
($mq$Antes de pulsar «enviar» en una prueba en pantalla, ¿qué conviene comprobar?$mq$, $mq$["Que todas las preguntas tienen respuesta y que respondes lo que pide cada orden","Que la pantalla esté limpia","Que sea la hora exacta","Que no hayas leído las preguntas"]$mq$, 0, $mq$Una respuesta en blanco es una oportunidad perdida.$mq$, $mq$medium$mq$),
($mq$Un alumno gasta 35 de 60 minutos en la primera de tres tareas de igual valor. ¿Cuál es el problema principal?$mq$, $mq$["El texto es demasiado corto","Usó demasiados conectores","Escribió con letra pequeña","Un reparto desequilibrado que deja poco tiempo para las otras dos"]$mq$, 3, $mq$Con tareas del mismo valor, conviene repartir el tiempo de forma equilibrada. Treinta y cinco minutos dejan solo veinticinco para las otras dos.$mq$, $mq$hard$mq$),
($mq$Si la tarea final de escritura vale el doble que la de lectura, ¿cuál es un reparto razonable de 60 minutos?$mq$, $mq$["40 para la lectura y 20 para la escritura","30 y 30 sin revisar","20 minutos para la lectura y 40 para la escritura","55 para la lectura y 5 para la escritura"]$mq$, 2, $mq$El doble de puntos justifica el doble de tiempo: 20 y 40 suman 60 minutos y mantienen la proporción.$mq$, $mq$hard$mq$),
($mq$Quedan 12 minutos y dos preguntas de comprensión sin responder. ¿Qué plan es más sensato?$mq$, $mq$["Redactar una de ellas en cinco párrafos y dejar la otra vacía","Responder ambas brevemente con cita y explicación, sin perfeccionar","Releer el texto entero antes de empezar","Cambiar las respuestas anteriores"]$mq$, 1, $mq$Un intento breve en ambas suma más puntos que una respuesta perfecta y otra vacía.$mq$, $mq$hard$mq$),
($mq$Terminas la redacción con diez minutos de sobra. ¿Cuál es la mejor revisión?$mq$, $mq$["Releer con atención, corregir ortografía y puntuación y comprobar que cumple la consigna","Entregar sin leer","Añadir un párrafo sin relación","Cambiar todo el vocabulario por sinónimos raros"]$mq$, 0, $mq$La revisión ordenada mejora claridad y precisión sin arriesgar la coherencia.$mq$, $mq$hard$mq$),
($mq$Notas que una planificación de diez minutos te hizo llegar justo a la redacción. ¿Cómo ajustar la próxima vez?$mq$, $mq$["Eliminar la planificación","Planificar más aún","Escribir sin conclusión","Reducir la planificación a unos cinco minutos con un esquema más ágil"]$mq$, 3, $mq$Se trata de equilibrar: un esquema breve y útil, no una versión completa del texto.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Time Management$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Regla del tiempo$mq$, $mq$El tiempo sigue a los puntos: más puntos, más tiempo.$mq$),
($mq$Inicio de la prueba$mq$, $mq$Leer todas las instrucciones y repartir el tiempo entre tareas.$mq$),
($mq$Opción múltiple: estrategia$mq$, $mq$Lee el texto, anticipa la respuesta, elimina opciones imposibles y avanza si dudas.$mq$),
($mq$Plan breve$mq$, $mq$Entre 5 y 10 minutos: idea central, tres ideas con ejemplos y orden de párrafos.$mq$),
($mq$Revisión final$mq$, $mq$Comprobar consigna, estructura, ortografía, puntuación y conclusión.$mq$),
($mq$Si te falta tiempo$mq$, $mq$Escribe una conclusión breve y responde brevemente a las preguntas pendientes.$mq$),
($mq$Bloqueo$mq$, $mq$Respira, relee la orden, anota palabras clave y pasa a otra tarea.$mq$),
($mq$Reparto de 60 minutos$mq$, $mq$Por ejemplo: 20 para lectura, 40 para escritura (5 plan, 28 redacción, 7 revisión).$mq$),
($mq$Antes de enviar$mq$, $mq$Verifica que no hay preguntas sin respuesta y que cada respuesta cumple su orden.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Time Management$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$En una prueba en pantalla con tiempo limitado, saber la materia no basta: debes decidir cuánto tiempo dedicas a cada parte. Una buena gestión del tiempo reduce el estrés, evita dejar preguntas en blanco y mejora la calidad de las respuestas largas. Esta lección te enseña un método sencillo para planificar, avanzar y revisar.

## Antes de empezar
- Lee las instrucciones y echa un vistazo a toda la prueba.
- Fíjate en el tipo de tarea (opción múltiple, respuesta corta, redacción) y en los puntos que vale cada una.
- Anota mentalmente un reparto del tiempo. Por ejemplo, con sesenta minutos: unos 15-20 para preguntas de comprensión, unos 35-40 para la tarea de escritura y 5-10 para revisar.
- Mira el temporizador de pantalla cada cierto tiempo.

## Regla de oro: el tiempo sigue a los puntos
Si una tarea vale el doble, dedícale aproximadamente el doble de tiempo. Si tienes tres tareas de igual valor, reparte el tiempo de forma equilibrada. Gastar treinta y cinco minutos en la primera de tres tareas iguales deja pocos minutos para las otras dos y reduce tu nota total.

## Preguntas de opción múltiple
- Lee el texto primero y la pregunta después. Anticipa la respuesta antes de mirar las opciones.
- Elimina las opciones claramente incorrectas.
- Si dudas más de uno o dos minutos, elige la mejor opción, márcala y sigue. Vuelve si te sobra tiempo.
- No dejes ninguna sin responder.

## Respuestas extensas y escritura
1. **Planifica** entre cinco y diez minutos: tesis o idea central, tres ideas con ejemplos y orden.
2. **Escribe** siguiendo el esquema. Controla el tiempo por párrafo para no extenderte.
3. **Revisa** en los últimos minutos: cumple la consigna, la estructura es clara, no hay errores de ortografía y la conclusión retoma la idea inicial.
Si te falta tiempo, escribe una conclusión breve en lugar de dejar el texto sin cierre. Si una respuesta extensa te llevó más de lo previsto, resume el resto con las ideas esenciales y pasa a la siguiente.

## Qué hacer cuando te bloqueas
- Respira y relee la orden.
- Escribe palabras clave en el borrador.
- Sigue con otra tarea y vuelve después.
- Evita compararte con los demás: concéntrate en tu ritmo.

## Antes de enviar
Comprueba que todas las preguntas tienen respuesta y que cada una cumple la orden. Una respuesta en blanco no puede puntuar, mientras que una respuesta breve con cita y explicación sí puede conseguir puntos.

## Cómo se evalúa
El tiempo no se evalúa directamente, pero afecta a la calidad: textos incompletos, estructura desordenada, respuestas vacías y errores sin revisar. Los alumnos que reparten bien su tiempo suelen completar todas las tareas.

## Un ejemplo de reparto
Prueba de 60 minutos con una tarea de lectura (que vale la mitad que la de escritura): 20 minutos para la lectura, 40 para la escritura. Dentro de los 40: 5 minutos de plan, 28 de redacción y 7 de revisión.

## Errores frecuentes
- Empezar a escribir sin leer toda la prueba.
- Bloquearse en una pregunta difícil.
- No dejar tiempo para la conclusión.
- Entregar sin revisar.

Exam tip: practica con un cronómetro. Después de cada simulacro, anota qué tarea te llevó más tiempo del previsto y ajusta tu reparto para el siguiente.$mq$ from st;

-- eAssessment Skills for Literature > Using the Criteria
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$eAssessment Skills for Literature$mq$, 5, 8 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Using the Criteria$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$eAssessment Skills for Literature$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Using the Criteria$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Cuántos criterios se utilizan para valorar Lengua y Literatura en el MYP?$mq$, $mq$["Cuatro","Dos","Seis","Ocho"]$mq$, 0, $mq$Los criterios son A (analizar), B (organizar), C (producir texto) y D (utilizar el lenguaje).$mq$, $mq$easy$mq$),
($mq$¿Qué evalúa el criterio A?$mq$, $mq$["Organizar","Producir texto","Utilizar el lenguaje","Analizar"]$mq$, 3, $mq$El criterio A mide cómo analizas el contenido, el contexto, el lenguaje, la estructura y las técnicas de textos.$mq$, $mq$easy$mq$),
($mq$¿Qué evalúa el criterio B?$mq$, $mq$["Analizar","Memorizar","Organizar","Traducir"]$mq$, 2, $mq$El criterio B se centra en la organización de ideas, la estructura y el formato adecuado.$mq$, $mq$easy$mq$),
($mq$¿Qué evalúa el criterio C?$mq$, $mq$["Utilizar el lenguaje","Producir texto","Organizar sin escribir","Resumir sin crear"]$mq$, 1, $mq$El criterio C valora la creatividad, la perspectiva y las elecciones de estilo y técnica en tus textos.$mq$, $mq$easy$mq$),
($mq$¿Qué evalúa el criterio D?$mq$, $mq$["Utilizar el lenguaje","Analizar","Organizar","Producir texto"]$mq$, 0, $mq$El criterio D se centra en el vocabulario, la gramática, la puntuación, la ortografía y el registro.$mq$, $mq$easy$mq$),
($mq$¿Cuál es el nivel máximo que puedes alcanzar en un criterio?$mq$, $mq$["5","7","10","8"]$mq$, 3, $mq$Cada criterio se valora en niveles del 1 al 8 (con 0 si no se alcanza ningún descriptor).$mq$, $mq$medium$mq$),
($mq$¿Qué aspecto pertenece sobre todo al criterio B?$mq$, $mq$["Corrección de tildes","Interpretación de un símbolo","Estructura clara, párrafos ordenados y conectores adecuados","Originalidad del argumento de un cuento"]$mq$, 2, $mq$La organización es la base del criterio B; la ortografía es del criterio D.$mq$, $mq$medium$mq$),
($mq$¿Qué aspecto pertenece sobre todo al criterio C?$mq$, $mq$["Identificar la rima de un poema ajeno","Elecciones creativas de estilo, perspectiva y técnica en el texto propio","Corregir la concordancia","Organizar la bibliografía"]$mq$, 1, $mq$El criterio C valora cómo produces tus textos, con voz propia e intención.$mq$, $mq$medium$mq$),
($mq$¿Qué aspecto pertenece sobre todo al criterio D?$mq$, $mq$["Gramática, puntuación, ortografía y registro adecuados","La estructura narrativa","La originalidad del tema","La interpretación de un título"]$mq$, 0, $mq$El criterio D mide el uso preciso del lenguaje.$mq$, $mq$medium$mq$),
($mq$En los descriptores de nivel alto aparecen palabras como «perspicaz» y «sostenido». ¿Qué implican?$mq$, $mq$["Una respuesta muy corta","Un texto sin pruebas","Un resumen general","Un análisis profundo y mantenido a lo largo de toda la respuesta"]$mq$, 3, $mq$Para niveles altos no basta una buena idea aislada: debe sostenerse con profundidad en todo el texto.$mq$, $mq$medium$mq$),
($mq$¿Qué práctica mejora más el criterio A?$mq$, $mq$["Aumentar la longitud sin citar","Escribir más adjetivos","Citar el texto y explicar el efecto de cada recurso en el significado","Copiar un resumen"]$mq$, 2, $mq$El criterio A premia análisis con evidencia y explicación de efectos.$mq$, $mq$medium$mq$),
($mq$Un texto tiene párrafos desordenados, ideas repetidas y casi sin conectores. ¿Qué criterio se ve más afectado?$mq$, $mq$["A","B","C","D"]$mq$, 1, $mq$La coherencia y la organización lógica pertenecen al criterio B.$mq$, $mq$medium$mq$),
($mq$Un cuento tiene ideas muy creativas, pero con muchas faltas de ortografía y errores de concordancia. ¿Qué criterio se ve más afectado?$mq$, $mq$["D","A","B","C"]$mq$, 0, $mq$La corrección gramatical y ortográfica pertenece al criterio D.$mq$, $mq$medium$mq$),
($mq$Una respuesta dice «Hay una metáfora». ¿Por qué se queda en un nivel bajo del criterio A?$mq$, $mq$["Es demasiado larga","Tiene errores de ortografía","No tiene conectores","Identifica el recurso sin cita ni explicación de su efecto"]$mq$, 3, $mq$Para subir de nivel debes citar y explicar cómo el recurso influye en el significado.$mq$, $mq$hard$mq$),
($mq$¿Qué incluiría una respuesta analítica de nivel alto sobre un recurso?$mq$, $mq$["Solo nombrar el recurso","Solo resumir la trama","Identificar, citar, explicar el efecto y vincularlo con el propósito del autor","Solo opinar si el texto gusta"]$mq$, 2, $mq$Estos cuatro pasos muestran un análisis completo y relacionado con el sentido global.$mq$, $mq$hard$mq$),
($mq$Un alumno escribe un relato sin errores, pero con trama muy predecible y sin voz propia. ¿Qué criterio quedará más limitado?$mq$, $mq$["A","C","B","D"]$mq$, 1, $mq$El criterio C premia la creatividad, la perspectiva y las elecciones estilísticas; la corrección es del D.$mq$, $mq$hard$mq$),
($mq$En un simulacro un alumno obtiene A: 4, B: 6, C: 5, D: 7. ¿Qué enfoque de estudio es más eficaz?$mq$, $mq$["Practicar más el análisis con citas y efectos, el criterio más bajo","Dejar de practicar escritura","Repasar solo ortografía","Evitar los textos difíciles"]$mq$, 0, $mq$Mejorar el criterio con menor nivel suele dar la mayor ganancia total.$mq$, $mq$hard$mq$),
($mq$Para pasar de un nivel medio a uno alto en análisis, ¿qué es lo más importante?$mq$, $mq$["Escribir el doble sin cambiar el contenido","Copiar más citas sin comentarlas","Cambiar el tema","Mayor perspicacia y matiz, con evidencia bien seleccionada, no solo más extensión"]$mq$, 3, $mq$Los niveles altos premian la calidad del razonamiento y de la evidencia, no la mera longitud.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Using the Criteria$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Criterio A$mq$, $mq$Analizar: interpretar contenido, contexto, lenguaje, estructura y técnicas, con evidencia y explicación.$mq$),
($mq$Criterio B$mq$, $mq$Organizar: estructura, coherencia, párrafos, conectores y formato adecuado a la tarea.$mq$),
($mq$Criterio C$mq$, $mq$Producir texto: creatividad, perspectiva, voz propia y elecciones de estilo y técnica.$mq$),
($mq$Criterio D$mq$, $mq$Utilizar el lenguaje: vocabulario, gramática, puntuación, ortografía y registro.$mq$),
($mq$Niveles por criterio$mq$, $mq$Cada criterio se valora en niveles 1-8 (0 si no se alcanza ningún descriptor).$mq$),
($mq$Niveles altos$mq$, $mq$Piden análisis perspicaz, matizado y sostenido con evidencia bien seleccionada, no solo más extensión.$mq$),
($mq$Respuesta analítica completa$mq$, $mq$Identificar el recurso, citar, explicar el efecto y vincularlo con el propósito.$mq$),
($mq$Autoevaluación$mq$, $mq$Valorar tu texto con los criterios y trabajar el criterio más bajo con un objetivo concreto.$mq$),
($mq$Organización frente a corrección$mq$, $mq$Organización (B): estructura y coherencia. Corrección (D): gramática, ortografía y puntuación.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Using the Criteria$mq$ and p.name = $mq$eAssessment Skills for Literature$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Los criterios de evaluación son la guía que usan tus profesores y examinadores para valorar tus textos. Si los conoces bien, sabrás exactamente qué se espera en cada respuesta y podrás convertir tus errores en mejoras concretas. En Lengua y Literatura del MYP hay cuatro criterios, y cada uno se valora en niveles del 1 al 8 (0 si no se alcanza ningún descriptor).

## Los cuatro criterios
- **Criterio A, Analizar**: cómo interpretas el contenido, el contexto, el lenguaje, la estructura y las técnicas de un texto, y cómo justificas tus ideas con ejemplos y explicaciones.
- **Criterio B, Organizar**: cómo estructuras y presentas ideas de manera coherente y lógica, con formato y convenciones adecuados a la tarea.
- **Criterio C, Producir texto**: cómo creas textos con intención, perspectiva y elecciones de estilo y técnica. Incluye creatividad y voz propia.
- **Criterio D, Utilizar el lenguaje**: vocabulario, gramática, sintaxis, puntuación, ortografía y registro. Se trata de la precisión y la adecuación del lenguaje.
Un mismo texto puede evaluarse con más de un criterio, y cada uno mira un aspecto distinto.

## Qué significa cada nivel
Los niveles suben de forma gradual y cada uno tiene descriptores. En los niveles bajos, las respuestas son limitadas, con poca evidencia. En los niveles medios, hay comprensión pero el análisis es irregular. En los niveles altos, las ideas son perspicaces, matizadas y sostenidas en todo el texto, con evidencia bien elegida. Palabras como «perspicaz», «sostenido» y «con detalle» no se refieren a la longitud, sino a la calidad del razonamiento.

## Cómo subir de nivel
- **Criterio A**: no basta con nombrar un recurso («hay una metáfora»). Identifica, cita, explica el efecto y vincúlalo con el propósito y la audiencia.
- **Criterio B**: planifica, usa frases temáticas, ordena los párrafos y emplea conectores.
- **Criterio C**: arriesga con una voz propia, una perspectiva clara y recursos bien escogidos. Evita historias predecibles sin intención.
- **Criterio D**: revisa tildes, concordancia, tiempos verbales, puntuación y registro; amplía el vocabulario.

## Autoevaluación
Después de cada práctica, evalúa tu respuesta con los criterios. Por ejemplo, un simulacro con A: 4, B: 6, C: 5 y D: 7 sugiere dedicar más tiempo al análisis con citas y efectos, porque es el criterio más bajo. Registra tu progreso y fíjate un objetivo concreto para la próxima vez.

## Cómo se relacionan con el examen en pantalla
Las preguntas de opción múltiple comprueban habilidades de comprensión que preparan el análisis del criterio A. Las respuestas extensas y las tareas de escritura se valoran con los criterios que correspondan: normalmente análisis, organización, producción de texto y uso del lenguaje. La calificación global de la asignatura se calcula aparte de los niveles por criterio (los niveles de criterio van de 1 a 8; en el examen oficial la nota global de la asignatura se informa en la escala de 1 a 7), por lo que conviene entenderlos como herramienta de mejora.

## Ejemplo
Respuesta A: «Hay una metáfora». Respuesta B: «La metáfora “el mar era un espejo roto” sugiere que la calma es frágil, lo que anticipa el conflicto y prepara la tensión del final». La segunda identifica, cita, explica el efecto y vincula con la estructura; por eso queda en un nivel superior.

## Errores frecuentes
- Pensar que más longitud significa más nivel.
- No relacionar una técnica con su efecto.
- Descuidar la revisión del lenguaje al final.
- Confundir organización (B) con corrección (D).

Exam tip: antes de entregar una tarea de escritura, repasa los cuatro criterios en orden A-B-C-D como lista de control y pregúntate qué evidencia concreta muestra cada uno en tu texto.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;