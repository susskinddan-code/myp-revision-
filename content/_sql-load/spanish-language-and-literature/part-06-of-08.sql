-- Part 6 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Writing > Planning Your Writing
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Writing$mq$, 5, 6 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Planning Your Writing$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Writing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Planning Your Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Cuál debe ser el primer paso antes de escribir en un examen?$mq$, $mq$["Leer con atención la consigna y subrayar tipo de texto, propósito y audiencia","Empezar a escribir sin pensar","Contar las palabras de la hoja","Copiar la consigna en el borrador"]$mq$, 0, $mq$La consigna dice qué se pide. Si no la analizas, puedes escribir un texto perfecto pero equivocado.$mq$, $mq$easy$mq$),
($mq$¿Qué es una lluvia de ideas?$mq$, $mq$["Corregir las faltas de ortografía","Escribir la versión final","Elegir el título definitivo","Anotar libremente todas las ideas que se te ocurran sobre el tema"]$mq$, 3, $mq$Primero se generan ideas sin censura; después se seleccionan y se ordenan.$mq$, $mq$easy$mq$),
($mq$¿Para qué sirve un esquema?$mq$, $mq$["Para sustituir al texto final","Para aumentar el número de palabras","Para ordenar las ideas antes de redactar","Para decorar la hoja"]$mq$, 2, $mq$Un esquema organiza la estructura y evita repeticiones o saltos de tema.$mq$, $mq$easy$mq$),
($mq$¿Qué es la audiencia de un texto?$mq$, $mq$["La longitud del texto","La persona o grupo a quien se dirige","El título","La letra utilizada"]$mq$, 1, $mq$La audiencia condiciona el registro, el vocabulario y el tono.$mq$, $mq$easy$mq$),
($mq$¿Cuántas ideas principales debería desarrollar, normalmente, un párrafo?$mq$, $mq$["Una","Cinco","Ninguna","Tantas como se puedan"]$mq$, 0, $mq$Un párrafo bien construido desarrolla una idea principal con explicación y ejemplo.$mq$, $mq$easy$mq$),
($mq$Consigna: «Escribe una carta al director del instituto para pedir más canastas en el patio». ¿Qué debe incluir tu plan?$mq$, $mq$["Un diálogo entre dos alumnos","Un poema con rima","Una receta de cocina","Formato de carta formal, registro formal y argumentos para persuadir"]$mq$, 3, $mq$La consigna fija el género (carta), el registro (formal) y el propósito (persuadir).$mq$, $mq$medium$mq$),
($mq$¿Qué orden es adecuado para planificar un texto argumentativo?$mq$, $mq$["Conclusión, anécdota y despedida","Ejemplos, título y firma","Tesis, argumentos con ejemplos, contraargumento y conclusión","Diálogos, descripción y final abierto"]$mq$, 2, $mq$Este orden lógico guía al lector desde tu posición hasta su justificación y cierre.$mq$, $mq$medium$mq$),
($mq$En un examen de sesenta minutos, ¿cuánto tiempo conviene dedicar a planificar?$mq$, $mq$["Ningún minuto","Entre cinco y diez minutos","La mitad del tiempo","Solo los dos últimos minutos"]$mq$, 1, $mq$Una planificación breve pero real mejora la estructura sin quitar tiempo a la redacción.$mq$, $mq$medium$mq$),
($mq$¿Por qué conviene anotar conectores en el plan?$mq$, $mq$["Para marcar cómo se enlazan las ideas («en primer lugar», «además», «sin embargo»)","Para alargar el texto sin sentido","Para evitar el uso de párrafos","Para cambiar el género"]$mq$, 0, $mq$Prever los conectores ayuda a que el texto sea coherente y fluido.$mq$, $mq$medium$mq$),
($mq$¿Qué significa filtrar ideas durante la planificación?$mq$, $mq$["Borrar todo el plan","Elegir la idea más extraña","Anotar más ideas sin ordenar","Descartar las que no ayudan al propósito de la consigna"]$mq$, 3, $mq$No todas las ideas valen: se conservan las más relevantes, claras y mejor apoyadas.$mq$, $mq$medium$mq$),
($mq$¿Cuál de estas frases es una tesis y no solo un tema?$mq$, $mq$["«El uso del móvil»","«Los móviles en el instituto»","«Los móviles deberían limitarse en clase porque reducen la concentración»","«Hablaré de móviles»"]$mq$, 2, $mq$Una tesis toma posición y da una razón; un tema solo nombra el asunto.$mq$, $mq$medium$mq$),
($mq$Escribes un texto para niños de ocho años. ¿Qué decisión de registro es más adecuada?$mq$, $mq$["Oraciones largas con términos técnicos","Frases cortas y vocabulario sencillo","Citas de especialistas","Frases con muchas subordinadas"]$mq$, 1, $mq$El registro debe adaptarse a la capacidad de comprensión de la audiencia.$mq$, $mq$medium$mq$),
($mq$Planeas un relato breve. ¿Qué elementos debería recoger tu plan?$mq$, $mq$["Personaje, lugar, conflicto, clímax y resolución","Solo el título","Solo una lista de adjetivos","Solo el número de párrafos"]$mq$, 0, $mq$Una narración necesita estructura: sin conflicto ni resolución el relato queda plano.$mq$, $mq$medium$mq$),
($mq$Consigna: «Escribe un artículo para la revista escolar que convenza a tus compañeros de reciclar». ¿Qué plan encaja mejor?$mq$, $mq$["Narración con diálogos en tercera persona","Carta formal dirigida al ayuntamiento","Poema en verso libre sin argumentos","Gancho, tres argumentos con ejemplos del instituto, objeción y llamada a la acción, en registro cercano"]$mq$, 3, $mq$El artículo de revista persuasivo para estudiantes exige argumentos, ejemplos cercanos y cierre con acción.$mq$, $mq$hard$mq$),
($mq$Una alumna escribe durante 30 de los 45 minutos sin plan. Su texto repite ideas y carece de conclusión. ¿Cuál es el diagnóstico más preciso?$mq$, $mq$["Faltó vocabulario de moda","El texto era demasiado corto","Faltó planificación y gestión del tiempo","Usó demasiados párrafos"]$mq$, 2, $mq$Sin esquema es fácil repetirse y quedarse sin tiempo para cerrar; planificar evita ambos problemas.$mq$, $mq$hard$mq$),
($mq$¿Cuál es la mejor frase temática para un párrafo sobre las ventajas del deporte escolar?$mq$, $mq$["«Voy a hablar del deporte»","«El deporte escolar mejora la salud física y favorece la convivencia»","«El deporte es bueno»","«Hay muchos deportes»"]$mq$, 1, $mq$La frase temática presenta con precisión la idea que el párrafo desarrollará.$mq$, $mq$hard$mq$),
($mq$Tu consigna dice: «Explica y valora». ¿Cómo debe reflejarse en el plan?$mq$, $mq$["Reservar espacio equilibrado para explicar y para valorar con justificación","Solo explicar","Solo dar tu opinión","Copiar la consigna"]$mq$, 0, $mq$Cada verbo de la consigna pide una tarea distinta; si omites una, pierdes puntos.$mq$, $mq$hard$mq$),
($mq$Al planificar, notas que tu tercera idea no apoya tu tesis. ¿Qué es lo más razonable?$mq$, $mq$["Mantenerla igualmente","Ponerla como introducción","Repetirla al final","Eliminarla o modificarla para que sirva al argumento"]$mq$, 3, $mq$Cada idea debe contribuir a la tesis o al propósito; la coherencia vale más que la cantidad.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Planning Your Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Primer paso al escribir$mq$, $mq$Analizar la consigna: género, propósito, audiencia, verbos de la tarea y condiciones.$mq$),
($mq$Lluvia de ideas$mq$, $mq$Anotar sin censura todas las ideas posibles sobre el tema antes de seleccionarlas.$mq$),
($mq$Mapa mental$mq$, $mq$Esquema con el tema en el centro y ramas para cada idea; sirve para relacionar conceptos.$mq$),
($mq$Esquema$mq$, $mq$Plan ordenado de las partes del texto y las ideas de cada párrafo.$mq$),
($mq$Tesis$mq$, $mq$Frase que toma posición y da una razón. Un tema solo nombra el asunto.$mq$),
($mq$Frase temática$mq$, $mq$Frase inicial del párrafo que anuncia su idea principal.$mq$),
($mq$Estructura argumentativa$mq$, $mq$Introducción con tesis, argumentos con ejemplos, contraargumento y refutación, conclusión.$mq$),
($mq$Estructura narrativa$mq$, $mq$Presentación, conflicto, clímax y resolución.$mq$),
($mq$Reparto del tiempo$mq$, $mq$En una hora: 5-10 min planificar, unos 40 redactar y unos 10 revisar.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Planning Your Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Planificar es la parte menos vistosa de escribir, pero marca la diferencia entre un texto claro y uno confuso. En una prueba en pantalla, con tiempo limitado, un buen plan de cinco a diez minutos te ayuda a ordenar las ideas, mantener el foco y llegar a una conclusión.

## 1. Analiza la consigna
Lee la tarea dos veces y subraya:
- **Tipo de texto** (carta, artículo, discurso, relato, descripción).
- **Propósito** (informar, persuadir, entretener, describir).
- **Audiencia** (compañeros, director, lectores de una revista, niños).
- **Verbos de la tarea** («explica», «valora», «convence», «describe»). Cada verbo pide una acción distinta; si dice «explica y valora», necesitas ambas.
- **Condiciones** (extensión, número de ejemplos, tono).

## 2. Genera ideas
La **lluvia de ideas** consiste en anotar sin censura todo lo que se te ocurra: palabras clave, ejemplos, recuerdos, argumentos. Puedes usar una lista o un **mapa mental**, con el tema en el centro y ramas para cada idea. No pierdas tiempo en frases perfectas: solo palabras clave.

## 3. Filtra y ordena
Elige las ideas más relevantes, mejor apoyadas y más originales. Descarta las que no sirvan al propósito. Después ordénalas en un **esquema**. Para un texto argumentativo, un buen orden es: introducción con gancho y tesis; dos o tres párrafos de argumentos con ejemplos; contraargumento y refutación; conclusión con llamada a la acción. Para un relato: presentación, conflicto, clímax y resolución.

## 4. Tesis y frases temáticas
Una **tesis** toma posición y da una razón: «Los móviles deberían limitarse en clase porque reducen la concentración». Un tema como «los móviles en el instituto» no es tesis. Cada párrafo debe empezar con una **frase temática** precisa que anuncie su idea. Un párrafo desarrolla una idea principal, la explica y la ilustra con un ejemplo.

## 5. Registro y conectores
Anota el registro: formal para una carta al director, cercano para una revista escolar, sencillo para niños. Prevé también algunos conectores para unir las ideas: «en primer lugar», «además», «por otra parte», «sin embargo», «por lo tanto», «en conclusión».

## 6. Gestiona el tiempo
En una hora, una posible distribución es: cinco a diez minutos de planificación, treinta y cinco a cuarenta de redacción y los últimos diez de revisión. En la revisión comprueba que respondes a la consigna, que cada párrafo sirve a la tesis, y corrige ortografía y puntuación.

## Cómo se evalúa
El plan no se califica por sí solo, pero su efecto se ve en la organización del texto final. Los criterios premian estructura clara, desarrollo coherente de ideas y adecuación a la audiencia y al propósito.

## Errores frecuentes
- Empezar a escribir sin leer bien la consigna.
- Escribir un tema, no una tesis.
- Incluir ideas que no sirven al propósito.
- No guardar tiempo para la conclusión ni para repasar.

Exam tip: apunta en el borrador la consigna resumida en tres palabras (género, propósito, audiencia) y vuelve a mirarla cuando termines cada párrafo.$mq$ from st;

-- Writing > Narrative and Descriptive Writing
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Writing$mq$, 5, 6 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Narrative and Descriptive Writing$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Writing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Narrative and Descriptive Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué caracteriza a un narrador en primera persona?$mq$, $mq$["Cuenta la historia con «yo» y participa en ella","Habla de todos desde fuera sin ser personaje","Se dirige al lector con órdenes","No existe en el relato"]$mq$, 0, $mq$El narrador en primera persona es un personaje y solo conoce lo que vive, piensa o le cuentan.$mq$, $mq$easy$mq$),
($mq$¿Qué es el clímax de un relato?$mq$, $mq$["El título","La presentación de los personajes","La despedida del autor","El momento de mayor tensión o emoción"]$mq$, 3, $mq$El clímax es el punto culminante del conflicto, antes de la resolución.$mq$, $mq$easy$mq$),
($mq$¿Qué signo se usa en español para introducir el diálogo de un personaje?$mq$, $mq$["El asterisco (*)","El guion bajo (_)","La raya (—)","La barra (/)"]$mq$, 2, $mq$En español el diálogo se marca con raya; las comillas se usan para citas o pensamientos.$mq$, $mq$easy$mq$),
($mq$En «Era una noche fría y oscura», ¿para qué se usa el imperfecto «era»?$mq$, $mq$["Para marcar una acción puntual","Para describir el ambiente o las circunstancias","Para dar una orden","Para expresar un futuro"]$mq$, 1, $mq$El imperfecto presenta el fondo de la escena: cómo era el lugar, el clima o el estado de las cosas.$mq$, $mq$easy$mq$),
($mq$¿A qué recursos sensoriales recurre una buena descripción?$mq$, $mq$["A los cinco sentidos: vista, oído, olfato, gusto y tacto","Solo a la vista","Solo a los adjetivos de color","A ninguno, solo a datos"]$mq$, 0, $mq$Los detalles sensoriales hacen que el lector «viva» la escena.$mq$, $mq$easy$mq$),
($mq$¿Qué frase muestra miedo sin decir la palabra «miedo»?$mq$, $mq$["«Tenía mucho miedo»","«Sintió miedo de verdad»","«Estaba asustado y tenía miedo»","«Le temblaban las manos y el vaso tintineó contra el plato»"]$mq$, 3, $mq$«Mostrar» es dar detalles de conducta y cuerpo; «decir» es nombrar la emoción.$mq$, $mq$medium$mq$),
($mq$«Corría como un rayo.» ¿Qué recurso se usa y para qué?$mq$, $mq$["Una pregunta retórica, para dudar","Una anáfora, para repetir","Un símil, para destacar la velocidad","Un diálogo, para informar"]$mq$, 2, $mq$El símil compara con «como» y hace más vivo lo descrito.$mq$, $mq$medium$mq$),
($mq$«La lluvia golpeaba los cristales y el pasillo olía a humedad.» ¿Qué efecto crea?$mq$, $mq$["Una atmósfera festiva","Una atmósfera sombría y cerrada","Un tono científico","Una descripción de datos exactos"]$mq$, 1, $mq$Los detalles sensoriales y el verbo «golpeaba» construyen el ambiente.$mq$, $mq$medium$mq$),
($mq$¿Qué frase combina correctamente un imperfecto de fondo con un pretérito indefinido de acción?$mq$, $mq$["«Mientras llovía, Ana abrió la puerta»","«Mientras llovió, Ana abría la puerta»","«Mientras llueve, Ana abrió la puerta»","«Mientras lloverá, Ana abrió la puerta»"]$mq$, 0, $mq$El imperfecto («llovía») sitúa el contexto y el indefinido («abrió») marca la acción puntual.$mq$, $mq$medium$mq$),
($mq$¿Qué línea de diálogo está bien puntuada?$mq$, $mq$["—No lo sé, dijo Lucía. Quizá mañana.","No lo sé —dijo Lucía— quizá mañana.","—No lo sé— dijo Lucía —. Quizá mañana.","—No lo sé —dijo Lucía—. Quizá mañana."]$mq$, 3, $mq$La raya abre la intervención, encierra el verbo de habla sin espacio entre raya y palabra, y tras el cierre sigue el punto.$mq$, $mq$medium$mq$),
($mq$¿Cuál es la mejor mejora de «una casa bonita»?$mq$, $mq$["«Una casa muy, muy bonita»","«Una casa agradable»","«Una casa de postigos azules y tejado cubierto de musgo»","«Una casa que era bonita»"]$mq$, 2, $mq$Los detalles concretos sustituyen a los adjetivos vagos y permiten ver la casa.$mq$, $mq$medium$mq$),
($mq$¿Qué es un narrador omnisciente?$mq$, $mq$["Un personaje que habla de sí mismo","Un narrador en tercera persona que conoce los pensamientos de todos","Un lector que comenta el texto","Un narrador que solo ve lo que se ve por fuera"]$mq$, 1, $mq$El omnisciente ve dentro de todos los personajes; el testigo solo ve lo externo.$mq$, $mq$medium$mq$),
($mq$¿Qué significa empezar un relato «in medias res»?$mq$, $mq$["Comenzar en mitad de la acción","Comenzar por el final de la historia","Comenzar con una definición","Comenzar con una cita de un diccionario"]$mq$, 0, $mq$Así se capta enseguida la atención del lector y se aporta el contexto más tarde.$mq$, $mq$medium$mq$),
($mq$¿Qué reescritura de «Estaba muy triste» muestra el sentimiento mejor?$mq$, $mq$["«Estaba profundamente triste»","«Se sentía tristísimo»","«Qué triste estaba»","«Miró el teléfono, lo dejó sobre la cama y no contestó a nadie en toda la tarde»"]$mq$, 3, $mq$Las acciones concretas sugieren la tristeza sin nombrarla, y el lector la infiere.$mq$, $mq$hard$mq$),
($mq$«Corrió. Tropezó. Se levantó. La puerta estaba cerrada.» ¿Qué efecto crean las frases cortas?$mq$, $mq$["Calma y reflexión","Humor suave","Velocidad y tensión","Descripción lenta de un paisaje"]$mq$, 2, $mq$El ritmo entrecortado imita la urgencia de la escena. Los cambios de longitud de frase controlan el ritmo narrativo.$mq$, $mq$hard$mq$),
($mq$«El cielo lloraba con ella.» ¿Qué recurso es y qué hace?$mq$, $mq$["Hipérbole que exagera una cifra","Personificación que refleja el estado de ánimo del personaje","Símil sin comparación","Rima consonante"]$mq$, 1, $mq$Atribuir a la naturaleza un sentimiento humano (a veces llamado falacia patética) refuerza la emoción de la escena.$mq$, $mq$hard$mq$),
($mq$Un relato en primera persona dice: «Yo no sabía que, en otra habitación, mi hermano preparaba una sorpresa». ¿Qué problema de punto de vista hay?$mq$, $mq$["El narrador cuenta algo que no puede saber desde su posición","El verbo está en futuro","Falta el diálogo","Hay demasiados adjetivos"]$mq$, 0, $mq$Un narrador en primera persona está limitado a lo que ve o averigua; si lo sabe, debe explicar cómo.$mq$, $mq$hard$mq$),
($mq$Para un cuento de 300 palabras, ¿qué enfoque funciona mejor?$mq$, $mq$["Muchos personajes con varias historias","Un resumen de toda una vida","Una explicación larga de la moraleja","Un solo conflicto, pocos personajes y un final con sentido"]$mq$, 3, $mq$En pocas palabras conviene concentrarse en un momento significativo, con desarrollo y cierre.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Narrative and Descriptive Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Estructura narrativa$mq$, $mq$Presentación, conflicto, clímax y resolución.$mq$),
($mq$Mostrar, no decir$mq$, $mq$Sugerir emociones con acciones y detalles concretos en vez de nombrarlas.$mq$),
($mq$Narrador en primera persona$mq$, $mq$Cuenta con «yo»; solo sabe lo que vive, ve o le cuentan.$mq$),
($mq$Narrador omnisciente$mq$, $mq$Narrador en tercera persona que conoce los pensamientos de todos los personajes.$mq$),
($mq$In medias res$mq$, $mq$Empezar el relato en mitad de la acción y explicar el contexto después.$mq$),
($mq$Pretérito indefinido e imperfecto$mq$, $mq$Indefinido: acción puntual terminada. Imperfecto: descripción y acción en curso.$mq$),
($mq$Raya del diálogo$mq$, $mq$—No lo sé —dijo Lucía—. Quizá mañana. La raya abre la intervención y encierra el verbo de habla.$mq$),
($mq$Símil y personificación$mq$, $mq$Símil: comparación con «como». Personificación: dar rasgos humanos a lo no humano.$mq$),
($mq$Control del ritmo$mq$, $mq$Frases cortas para tensión y acción; frases largas para descripción y calma.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Narrative and Descriptive Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$La escritura narrativa y descriptiva te permite demostrar creatividad, control del lenguaje y dominio de la estructura. En la evaluación debes producir un texto original que responda a una consigna (un relato, una escena, una descripción de un lugar o personaje) y que muestre elecciones conscientes de voz, estructura y estilo.

## Estructura de un relato
Un cuento breve suele tener cuatro momentos:
- **Presentación**: personajes, lugar y ambiente.
- **Conflicto**: el problema que mueve la historia.
- **Clímax**: el momento de mayor tensión.
- **Resolución**: cómo termina el conflicto, aunque el final puede ser abierto.
En un texto corto es mejor un solo conflicto, pocos personajes y un final con sentido. También puedes empezar **in medias res**, en mitad de la acción, y explicar el contexto después.

## Punto de vista
- **Primera persona** («yo»): cercanía, pero el narrador solo sabe lo que vive, ve o le cuentan.
- **Tercera persona omnisciente**: conoce los pensamientos de todos.
- **Tercera persona limitada**: sigue a un personaje.
Mantén el mismo punto de vista a lo largo del texto.

## Mostrar, no decir
En lugar de escribir «tenía miedo», muestra su cuerpo y sus acciones: «Le temblaban las manos y el vaso tintineó contra el plato». Los detalles concretos hacen que el lector deduzca la emoción y se implique.

## Descripción eficaz
Usa los cinco sentidos y sustituye los adjetivos vagos («bonito», «grande») por detalles precisos: «una casa de postigos azules y tejado cubierto de musgo». Recursos útiles: **símil** («corría como un rayo»), **metáfora**, **personificación** («el cielo lloraba con ella») y adjetivación precisa. Los detalles del ambiente (luz, sonidos, olores, clima) crean atmósfera.

## Tiempos verbales en la narración
- **Pretérito indefinido**: acciones puntuales y terminadas («abrió la puerta»).
- **Pretérito imperfecto**: descripción de fondo y acciones en curso («llovía», «era una noche fría»).
- **Presente histórico**: se usa a veces para dar viveza, pero debes mantenerlo con coherencia.
Un ejemplo: «Mientras llovía, Ana abrió la puerta».

## Diálogo
El diálogo se marca con raya: —No lo sé —dijo Lucía—. Quizá mañana. La raya de apertura va pegada a la primera palabra, y el comentario del narrador queda entre rayas. Cada intervención empieza en línea nueva. El diálogo debe revelar carácter o avanzar la acción, no solo llenar espacio.

## Ritmo
Alterna frases largas para describir y frases cortas para la tensión: «Corrió. Tropezó. Se levantó». Los párrafos breves aceleran el relato.

## Cómo se evalúa
La tarea se valora por creatividad, estructura, estilo, coherencia y corrección del lenguaje. Los mejores textos tienen una voz clara, imágenes originales y un final coherente.

## Errores frecuentes
- Resumir la historia en lugar de narrar la escena.
- Mezclar tiempos verbales sin motivo.
- Cambiar de punto de vista sin querer.
- Explicar la moraleja con un párrafo final demasiado largo.

Exam tip: antes de cerrar, relee el primer y el último párrafo: el comienzo debe captar la atención y el final debe responder al conflicto planteado.$mq$ from st;

-- Writing > Argument and Formal Writing
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Writing$mq$, 5, 6 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Argument and Formal Writing$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Writing$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Argument and Formal Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué características tiene un texto formal?$mq$, $mq$["Vocabulario cuidado, ausencia de coloquialismos y trato respetuoso","Frases con muchas muletillas","Abreviaturas de mensajería","Tuteo siempre y bromas"]$mq$, 0, $mq$El registro formal evita expresiones coloquiales y adapta el trato al destinatario.$mq$, $mq$easy$mq$),
($mq$¿Qué es una tesis en un texto argumentativo?$mq$, $mq$["Un ejemplo anecdótico","La despedida","El título del periódico","La idea principal que el autor defiende"]$mq$, 3, $mq$La tesis expresa la posición del autor y orienta todo el texto.$mq$, $mq$easy$mq$),
($mq$¿Qué función cumple la conclusión de un texto argumentativo?$mq$, $mq$["Introducir un argumento nuevo y extenso","Presentar el tema por primera vez","Resumir la tesis y cerrar con una reflexión o propuesta","Copiar el primer párrafo"]$mq$, 2, $mq$La conclusión recoge la idea central y deja una impresión final.$mq$, $mq$easy$mq$),
($mq$¿Cómo se suele empezar una carta formal en español?$mq$, $mq$["Con «¡Ey, qué tal!»","Con un saludo respetuoso como «Estimado señor director:»","Con una pregunta sin saludo","Con la despedida"]$mq$, 1, $mq$El saludo formal marca el registro y el respeto hacia el destinatario.$mq$, $mq$easy$mq$),
($mq$¿Qué es un argumento?$mq$, $mq$["Una razón que apoya la tesis, con ejemplo o dato","Una opinión sin explicación","Una anécdota que no se relaciona con el tema","Una pregunta sin respuesta"]$mq$, 0, $mq$Un argumento sólido se compone de razón y evidencia.$mq$, $mq$easy$mq$),
($mq$¿Qué conector introduce un contraste?$mq$, $mq$["«Además»","«Por lo tanto»","«En primer lugar»","«Sin embargo»"]$mq$, 3, $mq$«Sin embargo» opone una idea a la anterior; «además» suma y «por lo tanto» concluye.$mq$, $mq$medium$mq$),
($mq$¿Cuál de estas frases es más adecuada en una carta al director?$mq$, $mq$["«Oye, jefe, ¿podemos ir más a la biblioteca?»","«Quiero que abráis más tiempo, ¿vale?»","«Le escribo para solicitarle que amplíe el horario de la biblioteca»","«La biblioteca, bua, qué rollo»"]$mq$, 2, $mq$La frase correcta usa el trato de «usted», una estructura formal y un verbo de petición educado.$mq$, $mq$medium$mq$),
($mq$¿Qué función tiene un contraargumento en un texto argumentativo?$mq$, $mq$["Cambiar de tema","Reconocer la postura contraria para refutarla y reforzar la propia","Abandonar la tesis","Repetir el primer argumento"]$mq$, 1, $mq$Anticipar una objeción y responderla muestra madurez y fortalece la credibilidad.$mq$, $mq$medium$mq$),
($mq$¿Qué conector es más adecuado para introducir la conclusión?$mq$, $mq$["«En definitiva»","«Por ejemplo»","«Sin embargo»","«Mientras tanto»"]$mq$, 0, $mq$«En definitiva», «en conclusión» o «por todo ello» sirven para cerrar.$mq$, $mq$medium$mq$),
($mq$¿Qué frase mantiene un tono objetivo en un informe formal?$mq$, $mq$["«Es un desastre total lo del agua»","«A mí me parece horrible»","«¡Qué barbaridad de agua gastan!»","«Los datos indican que el consumo de agua aumentó un diez por ciento»"]$mq$, 3, $mq$El tono objetivo se apoya en datos y evita valoraciones emotivas innecesarias.$mq$, $mq$medium$mq$),
($mq$¿Qué recurso usa «Por un lado… por otro lado…»?$mq$, $mq$["Introduce un diálogo","Anuncia un cambio de tiempo verbal","Organiza dos puntos de vista o aspectos contrapuestos","Indica una cita literal"]$mq$, 2, $mq$Estas expresiones estructuran comparaciones y matices.$mq$, $mq$medium$mq$),
($mq$¿Cuál es una buena frase de apertura para un ensayo breve sobre el uso del móvil en clase?$mq$, $mq$["«Hola, hoy voy a hablar del móvil»","«Cada vez más centros debaten si el móvil ayuda o perjudica el aprendizaje»","«El móvil, como dice el diccionario…»","«Este es mi ensayo sobre móviles»"]$mq$, 1, $mq$Contextualiza el tema y despierta interés sin recurrir a fórmulas vacías.$mq$, $mq$medium$mq$),
($mq$¿Qué es mejor para sostener un argumento?$mq$, $mq$["Un ejemplo concreto con dato o situación comprobable","Repetir la opinión más fuerte","Usar mayúsculas","Escribir más frases largas"]$mq$, 0, $mq$Los ejemplos y datos dan prueba y no solo afirmación.$mq$, $mq$medium$mq$),
($mq$Un alumno escribe: «Está claro que todo el mundo opina igual que yo». ¿Qué debilidad tiene?$mq$, $mq$["Usa un conector adecuado","Es demasiado formal","Incluye una cifra comprobada","Generaliza sin pruebas y suena como un argumento débil"]$mq$, 3, $mq$«Todo el mundo» es una generalización sin evidencia; conviene matizar y aportar datos.$mq$, $mq$hard$mq$),
($mq$Texto: «Aunque algunos creen que las tareas diarias son inútiles, varios docentes señalan que fomentan la responsabilidad». ¿Qué estructura argumentativa aparece?$mq$, $mq$["Narración en pasado","Descripción de un paisaje","Concesión y refutación","Diálogo directo"]$mq$, 2, $mq$Reconoce la objeción («aunque algunos creen…») y la responde con otra idea.$mq$, $mq$hard$mq$),
($mq$Un estudiante escribe una carta formal y firma «Besos, Dani». ¿Cuál es el fallo?$mq$, $mq$["La carta es demasiado extensa","El cierre es informal y rompe el registro","No hay saludo","Usa conectores"]$mq$, 1, $mq$Una carta formal cierra con fórmulas como «Atentamente» o «Reciba un cordial saludo» y la firma.$mq$, $mq$hard$mq$),
($mq$Para persuadir al director de que acorte los recreos, ¿qué argumento es más sólido?$mq$, $mq$["Uno que se apoya en datos del propio centro y evita exageraciones","Uno que solo usa adjetivos negativos","Uno que culpa a los profesores","Uno que cambia de tema a mitad"]$mq$, 0, $mq$Los argumentos con evidencia relevante y sin ataques persuaden mejor.$mq$, $mq$hard$mq$),
($mq$Analiza: «Es evidente que los exámenes son injustos; por tanto, deberían eliminarse». ¿Qué critica es más acertada?$mq$, $mq$["La frase es demasiado larga","Tiene demasiados datos","No tiene ningún conector","La premisa («es evidente») no está demostrada y la conclusión salta sin pruebas"]$mq$, 3, $mq$Se da por cierto lo que habría que probar; falta evidencia que justifique la conclusión.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Argument and Formal Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Estructura argumentativa$mq$, $mq$Introducción con tesis, argumentos con ejemplos, contraargumento y refutación, conclusión.$mq$),
($mq$Tesis$mq$, $mq$Idea principal que el autor defiende en el texto.$mq$),
($mq$Contraargumento$mq$, $mq$Postura contraria que se menciona para refutarla y fortalecer la propia posición.$mq$),
($mq$Conectores de contraste$mq$, $mq$Sin embargo, no obstante, aunque, por el contrario.$mq$),
($mq$Conectores de conclusión$mq$, $mq$En definitiva, en conclusión, por todo ello, por lo tanto.$mq$),
($mq$Registro formal$mq$, $mq$Vocabulario preciso, trato respetuoso, sin coloquialismos ni abreviaturas de mensajería.$mq$),
($mq$Carta formal: saludo y cierre$mq$, $mq$Saludo: «Estimado señor director:». Cierre: «Atentamente» o «Reciba un cordial saludo», y firma.$mq$),
($mq$Tipos de argumento$mq$, $mq$Datos, ejemplos, autoridad y causa-consecuencia.$mq$),
($mq$Generalización débil$mq$, $mq$Frases como «todo el mundo opina igual» o «es evidente que» sin pruebas debilitan el argumento.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Argument and Formal Writing$mq$ and p.name = $mq$Writing$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$El texto argumentativo y el texto formal comparten un objetivo: defender una posición o hacer una petición de manera clara, respetuosa y razonada. Los verás en la evaluación como cartas formales, artículos de opinión, ensayos breves, discursos o informes. La clave es combinar un registro adecuado con una estructura lógica y argumentos con pruebas.

## Estructura del texto argumentativo
- **Introducción**: presenta el tema, despierta interés y formula la **tesis**.
- **Desarrollo**: dos o tres párrafos, cada uno con una idea principal (frase temática), una explicación y un ejemplo o dato.
- **Contraargumento**: reconoce una postura contraria y la refuta («aunque algunos creen que…, lo cierto es que…»).
- **Conclusión**: recuerda la tesis con otras palabras y cierra con una propuesta, una reflexión o una llamada a la acción.

## Tipos de argumentos
- **Datos y estadísticas**: «el consumo aumentó un diez por ciento».
- **Ejemplos**: una situación concreta y creíble.
- **Autoridad**: la opinión de un experto.
- **Causa y consecuencia**: «si se reducen los recreos, disminuye la concentración».
Evita generalizaciones como «todo el mundo opina igual», afirmaciones sin prueba («es evidente que…») y ataques personales.

## Conectores útiles
- Orden: en primer lugar, en segundo lugar, por último.
- Suma: además, asimismo.
- Contraste: sin embargo, no obstante, aunque.
- Causa y consecuencia: porque, ya que, por lo tanto, así pues.
- Conclusión: en definitiva, en conclusión, por todo ello.

## El registro formal
Un texto formal usa vocabulario preciso, trato de «usted» cuando corresponde, oraciones completas y evita coloquialismos, abreviaturas de mensajería y exclamaciones excesivas. Ejemplo de petición: «Le escribo para solicitarle que amplíe el horario de la biblioteca». Para dar objetividad, usa datos: «Los datos indican que…», y evita valoraciones emotivas innecesarias.

## Estructura de una carta formal
1. Lugar y fecha.
2. Saludo: «Estimado señor director:».
3. Motivo de la carta, en el primer párrafo.
4. Desarrollo con argumentos o explicación.
5. Petición o propuesta clara.
6. Despedida: «Atentamente» o «Reciba un cordial saludo».
7. Firma.

## Cómo se evalúa
Los criterios valoran la claridad de la tesis, la organización, la calidad de los argumentos, el registro y la corrección. Una pregunta típica pide persuadir a un destinatario concreto y juzga si has adaptado el tono, el contenido y la estructura.

## Ejemplo
Tesis: «Los institutos deberían empezar las clases una hora más tarde». Argumento: «Según un estudio de un colegio ficticio, los alumnos que dormían más obtuvieron mejor atención». Contraargumento: «Algunos piensan que las familias no podrían organizarse; sin embargo, muchos horarios ya son flexibles». Conclusión: propuesta de una prueba de un trimestre.

## Errores frecuentes
- Mezclar registros (carta formal con cierre cariñoso).
- Escribir argumentos sin ejemplos.
- Introducir ideas nuevas en la conclusión.
- Usar los conectores de modo mecánico.

Exam tip: antes de entregar, comprueba tres cosas: tesis clara en la introducción, un ejemplo o dato en cada argumento y un cierre coherente con el registro del destinatario.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;