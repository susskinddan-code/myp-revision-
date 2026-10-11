-- Part 4 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Poetry > Reading Poems Closely
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Poetry$mq$, 5, 4 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Reading Poems Closely$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Poetry$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Reading Poems Closely$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué es un verso?$mq$, $mq$["Cada línea de un poema","Un grupo de varios poemas","El título del poema","Una palabra final"]$mq$, 0, $mq$El verso es la unidad básica del poema; varios versos forman una estrofa.$mq$, $mq$easy$mq$),
($mq$¿Qué es una estrofa?$mq$, $mq$["Una sola palabra","La rima final","Un tipo de narrador","Un conjunto de versos que forma una unidad"]$mq$, 3, $mq$Las estrofas separan el poema en bloques con sentido.$mq$, $mq$easy$mq$),
($mq$¿Qué es el yo poético (o voz poética)?$mq$, $mq$["El poeta real siempre","El editor","La voz que habla en el poema","El lector"]$mq$, 2, $mq$El yo lírico es una voz creada por el poeta; no siempre coincide con él.$mq$, $mq$easy$mq$),
($mq$¿Qué es el tema de un poema?$mq$, $mq$["El número de versos","La idea o sentimiento central que expresa","La rima","El título del libro"]$mq$, 1, $mq$El tema es la idea general: el paso del tiempo, el amor, la soledad, etc.$mq$, $mq$easy$mq$),
($mq$¿Qué es una imagen poética?$mq$, $mq$["Una expresión que evoca una sensación mediante palabras","Una fotografía","Una rima perfecta","Un signo de puntuación"]$mq$, 0, $mq$Las imágenes recrean sensaciones visuales, sonoras, táctiles, olfativas o gustativas.$mq$, $mq$easy$mq$),
($mq$Poema inventado: «Cae la tarde sobre el puerto, / se encienden las luces, una a una, / y mi nombre queda dormido / en el agua que no pregunta.» ¿Qué tema y atmósfera sugiere?$mq$, $mq$["Fiesta y bullicio","Rabia y violencia","Deporte y competición","Soledad y quietud al anochecer"]$mq$, 3, $mq$La tarde que cae, el nombre «dormido» y el agua que «no pregunta» transmiten calma y soledad.$mq$, $mq$medium$mq$),
($mq$En el mismo poema, «el agua que no pregunta» es una…$mq$, $mq$["Onomatopeya","Hipérbole","Personificación negativa que sugiere silencio y falta de respuestas","Símil"]$mq$, 2, $mq$Se atribuye al agua la acción humana de preguntar, negada: refuerza la soledad.$mq$, $mq$medium$mq$),
($mq$Poema inventado: «No me dijiste adiós. / Solo dejaste / la taza tibia sobre la mesa.» ¿Qué efecto produce la forma de los versos cortos?$mq$, $mq$["Aceleran la acción","Crea pausas que subrayan la ausencia y la emoción contenida","Impiden comprender","Indican una rima"]$mq$, 1, $mq$Los versos breves dejan silencios y enfatizan lo no dicho.$mq$, $mq$medium$mq$),
($mq$¿Qué significa interpretar el título de un poema?$mq$, $mq$["Pensar qué anticipa o cómo se relaciona con el tema","Copiar el título","Ignorar el título","Contar las letras"]$mq$, 0, $mq$El título orienta la lectura y puede ofrecer una clave simbólica.$mq$, $mq$medium$mq$),
($mq$Poema inventado: «Las campanas de abril / me llaman por mi nombre antiguo.» ¿Qué sentido tiene «mi nombre antiguo»?$mq$, $mq$["Que ha cambiado de ciudad","Que no tiene nombre","Que odia abril","Sugiere una identidad pasada o recuerdos de la infancia"]$mq$, 3, $mq$Lo antiguo del nombre evoca el pasado y la nostalgia.$mq$, $mq$medium$mq$),
($mq$¿Qué ocurre con la puntuación en un poema sin puntos ni comas?$mq$, $mq$["Es siempre un error","Impide todo significado","Puede crear fluidez y ambigüedad que obliga al lector a decidir el sentido","Indica rima consonante"]$mq$, 2, $mq$La ausencia de puntuación puede unir ideas y abrir varias lecturas.$mq$, $mq$medium$mq$),
($mq$Poema inventado: «Tu voz, oscura miel, / se me derrama en el oído.» ¿Qué recurso destaca?$mq$, $mq$["Onomatopeya","Metáfora con sinestesia (oído y gusto)","Símil con «como»","Hipérbole matemática"]$mq$, 1, $mq$«Oscura miel» identifica la voz con miel y mezcla sensaciones de distintos sentidos.$mq$, $mq$medium$mq$),
($mq$Poema inventado: «Hoy el mar no tiene prisa; / yo tampoco.» ¿Qué efecto produce la última frase?$mq$, $mq$["Identifica al yo poético con el mar y transmite serenidad","Introduce una crítica social","Genera un tono furioso","Describe un ruido"]$mq$, 0, $mq$El paralelismo entre el mar y el yo crea una sensación de calma compartida.$mq$, $mq$medium$mq$),
($mq$Poema inventado: «Barro fui, barro seré, / pero entre un barro y otro / me tocó sentir la lluvia.» ¿Qué lectura es más profunda?$mq$, $mq$["Describe un trabajo de alfarería","Es una queja sobre el clima","Es un chiste","Reflexión sobre la fugacidad de la vida: lo valioso es lo vivido entre origen y final"]$mq$, 3, $mq$El barro simboliza la condición mortal; la lluvia representa la experiencia vital.$mq$, $mq$hard$mq$),
($mq$Poema inventado: «Se fue el verano sin avisar. / Quedó la silla en el jardín, / mirando hacia ninguna parte.» ¿Qué análisis de la silla es más sólido?$mq$, $mq$["Onomatopeya del verano","Hipérbole que ridiculiza el verano","Personificación y símbolo de ausencia, que da a la escena una melancolía discreta","Metáfora del trabajo"]$mq$, 2, $mq$La silla «mira», y esa mirada vacía sugiere abandono y nostalgia.$mq$, $mq$hard$mq$),
($mq$Una alumna escribe: «El poema habla de la lluvia porque menciona lluvia en el verso 2.» ¿Qué falta para un análisis competente?$mq$, $mq$["Cambiar el verso","Interpretar qué simboliza la lluvia y cómo se relaciona con el tono y el tema","Contar sílabas únicamente","Añadir más citas sin explicar"]$mq$, 1, $mq$No basta con mencionar el elemento: hay que interpretar su función.$mq$, $mq$hard$mq$),
($mq$Poema inventado: «Cuento los pasos hasta tu puerta: / cuarenta, cuarenta y uno, / y me falta valor para el cuarenta y dos.» ¿Qué recurso formal refuerza la tensión?$mq$, $mq$["La enumeración numérica gradual, que interrumpe el avance justo antes del final","La rima consonante de todo el poema","La onomatopeya","La ausencia de verbos"]$mq$, 0, $mq$El conteo crea ritmo y expectación; la interrupción muestra duda.$mq$, $mq$hard$mq$),
($mq$En un examen, la pregunta «¿Cómo transmite el poeta la sensación de pérdida?» exige…$mq$, $mq$["Resumir la vida del poeta","Parafrasear sin citar","Contar versos","Identificar recursos concretos, citar versos y explicar el efecto emocional"]$mq$, 3, $mq$Se pide analizar el «cómo»: recursos, citas y efecto.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Reading Poems Closely$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Verso y estrofa$mq$, $mq$Verso: cada línea del poema. Estrofa: conjunto de versos que forma un bloque con unidad de sentido.$mq$),
($mq$Yo poético o voz lírica$mq$, $mq$La voz que habla en el poema. No siempre coincide con el poeta real.$mq$),
($mq$Imagen poética$mq$, $mq$Expresión que evoca sensaciones (vista, oído, tacto, olfato o gusto) mediante recursos como metáforas o comparaciones.$mq$),
($mq$Tema y tono de un poema$mq$, $mq$Tema: idea o sentimiento central. Tono: actitud de la voz poética hacia ese tema, como melancólico o esperanzado.$mq$),
($mq$Efecto de los versos cortos$mq$, $mq$Crean pausas, silencios y emoción contenida; pueden subrayar ausencias o dudas.$mq$),
($mq$Encabalgamiento$mq$, $mq$La frase continúa en el verso siguiente sin pausa. Crea fluidez, tensión o sensación de urgencia.$mq$),
($mq$Método de lectura de un poema$mq$, $mq$Observar título y forma; parafrasear; subrayar imágenes y sonidos; interpretar la relación entre forma y significado.$mq$),
($mq$Cadena de análisis poético$mq$, $mq$Cita + recurso + efecto + relación con el tema. Ejemplo: personificación del agua que subraya la soledad.$mq$),
($mq$Parafrasear$mq$, $mq$Explicar con palabras sencillas lo que dice el poema. Es el primer paso antes de analizar los recursos.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Reading Poems Closely$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Lo esencial
Leer un poema de cerca significa desmontar cómo está hecho para comprender lo que expresa. Un poema condensa mucho sentido en pocas palabras, así que cada elección importa: el título, la voz, las imágenes, la forma de los versos, los sonidos y los silencios. En Lengua y Literatura debes pasar del «qué dice» al «cómo lo dice» y al «por qué importa».

## Conceptos básicos
- **Verso:** cada línea del poema.
- **Estrofa:** conjunto de versos que forma un bloque.
- **Yo poético o voz lírica:** la voz que habla; no siempre coincide con el poeta.
- **Tema:** idea o sentimiento central, como la ausencia, el tiempo o la nostalgia.
- **Tono:** actitud de la voz (melancólica, esperanzada, irónica).
- **Imagen:** expresión que evoca una sensación visual, auditiva, táctil, olfativa o gustativa.

## Un método en cuatro pasos
1. **Antes de leer:** observa el título y la forma (versos largos o cortos, estrofas, espacios).
2. **Primera lectura:** parafrasea. ¿Quién habla? ¿A quién? ¿Qué sucede? ¿Qué sentimiento domina?
3. **Segunda lectura:** subraya imágenes, palabras repetidas, contrastes, sonidos y cambios de ritmo.
4. **Tercera lectura:** interpreta. ¿Por qué elige esas imágenes? ¿Qué relación hay entre forma y significado?

## La forma también significa
- **Versos cortos:** crean pausas y silencios, y pueden transmitir emoción contenida. Ejemplo inventado: «No me dijiste adiós. / Solo dejaste / la taza tibia sobre la mesa.»
- **Versos largos:** dan sensación de flujo o de agobio.
- **Encabalgamiento:** una frase continúa en el verso siguiente, creando tensión o fluidez.
- **Puntuación:** su ausencia puede crear ambigüedad y abrir varias lecturas.
- **Espacios en blanco:** representan silencios.
- **Final del poema:** suele concentrar el giro emocional.

## Lenguaje figurado y simbolismo en poesía
Las imágenes poéticas aparecen en metáforas, personificaciones, símiles y sinestesias. Por ejemplo, «Tu voz, oscura miel, / se me derrama en el oído» mezcla el oído y el gusto. Cuando una imagen se repite, puede convertirse en símbolo: el agua como paso del tiempo, la silla vacía como ausencia, el barro como condición mortal. Analiza siempre qué sentimiento transmite la imagen y por qué es adecuada.

## Cómo escribir un análisis
Usa la cadena **cita, recurso, efecto, tema**. Ejemplo: «En “el agua que no pregunta”, la personificación negativa subraya la soledad de la voz, que no recibe respuestas.» Evita contar el contenido verso a verso; selecciona los momentos más significativos y explica su relación con el sentido global.

## Errores frecuentes
- **Parafrasear sin analizar.** Contar lo que dice no basta.
- **Identificar recursos sin explicar su efecto.**
- **Confundir poeta y yo poético.** Habla de «la voz poética» o «el yo lírico».
- **Buscar un único sentido correcto.** Un poema admite varias interpretaciones, siempre que se justifiquen.
- **Ignorar la forma.** Longitud de los versos, ritmo y espacios también tienen significado.

## Cómo se evalúa
En la evaluación en pantalla aparece un poema breve, original, con preguntas sobre el sentido de una imagen, el efecto del ritmo, el cambio de tono al final o la relación entre título y contenido. Las preguntas de respuesta extensa piden analizar cómo el poeta crea un sentimiento o desarrolla un tema.

Exam tip: nunca cites un verso sin añadir el recurso y su efecto; la combinación de cita, nombre del recurso y efecto emocional es lo que más puntúa.$mq$ from st;

-- Poetry > Poetic Forms
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Poetry$mq$, 5, 4 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Poetic Forms$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Poetry$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Poetic Forms$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Cuántas sílabas métricas tiene un verso endecasílabo?$mq$, $mq$["Once","Ocho","Catorce","Seis"]$mq$, 0, $mq$Endecasílabo significa «de once sílabas».$mq$, $mq$easy$mq$),
($mq$¿Cuántos versos tiene un soneto?$mq$, $mq$["Diez","Ocho","Dieciséis","Catorce"]$mq$, 3, $mq$Dos cuartetos y dos tercetos forman 14 versos.$mq$, $mq$easy$mq$),
($mq$¿Qué es el verso libre?$mq$, $mq$["Un verso de ocho sílabas con rima","Un verso sin significado","Un verso sin rima fija ni métrica regular","Un verso con rima consonante obligatoria"]$mq$, 2, $mq$El verso libre no sigue patrón fijo de rima o de medida.$mq$, $mq$easy$mq$),
($mq$¿Qué es un haiku?$mq$, $mq$["Un poema de catorce versos","Un poema breve de tres versos, tradicionalmente de 5, 7 y 5 sílabas","Un poema narrativo","Un poema sin imágenes"]$mq$, 1, $mq$Procede de Japón; en español suele adaptarse a la medida 5-7-5.$mq$, $mq$easy$mq$),
($mq$¿Qué es un caligrama?$mq$, $mq$["Un poema cuya disposición gráfica dibuja un objeto","Un poema sin versos","Un poema con rima asonante","Un poema de dos versos"]$mq$, 0, $mq$La forma visual forma parte del significado.$mq$, $mq$easy$mq$),
($mq$¿Qué esquema de rima tiene un cuarteto ABBA?$mq$, $mq$["El primero con el segundo","El primero con el tercero","Todos los versos riman igual","El primer verso rima con el cuarto y el segundo con el tercero"]$mq$, 3, $mq$A-B-B-A: los versos externos riman entre sí y los internos entre sí.$mq$, $mq$medium$mq$),
($mq$Estrofa inventada: «Cuando el invierno llega con su frío (A) / y el viento pule el mármol de la plaza (B) / yo pienso en una luz que nos abraza (B) / y sueño con zarpar en un navío (A)». ¿Qué estrofa es?$mq$, $mq$["Serventesio ABAB","Terceto","Cuarteto con rima ABBA","Haiku"]$mq$, 2, $mq$El primero y el cuarto riman, y el segundo y el tercero también: ABBA.$mq$, $mq$medium$mq$),
($mq$¿Qué es el romance tradicional?$mq$, $mq$["Un poema de catorce versos con rima consonante","Una serie de versos octosílabos con rima asonante en los pares","Un poema de tres versos","Una sola estrofa sin rima"]$mq$, 1, $mq$El romance rima en asonante los versos pares y deja libres los impares.$mq$, $mq$medium$mq$),
($mq$Verso inventado: «Ya se oculta el sol detrás del monte». ¿Cuántas sílabas métricas tiene?$mq$, $mq$["10","8","9","12"]$mq$, 0, $mq$Tiene 12 sílabas gramaticales; las sinalefas de «se o-culta» y «oculta el» restan dos, y como «monte» es llana no se añade nada: 10.$mq$, $mq$medium$mq$),
($mq$¿Qué diferencia hay entre rima y ritmo?$mq$, $mq$["Son lo mismo","La rima aparece solo en prosa","El ritmo es la repetición de palabras","La rima es coincidencia de sonidos finales; el ritmo es la cadencia producida por acentos y pausas"]$mq$, 3, $mq$Un poema puede tener ritmo sin rima, como en el verso libre.$mq$, $mq$medium$mq$),
($mq$¿Qué suele expresar un soneto en sus tercetos finales?$mq$, $mq$["Una descripción del paisaje solo","Un diálogo teatral","Una conclusión o giro respecto a lo planteado en los cuartetos","Una lista de objetos"]$mq$, 2, $mq$En el soneto clásico los tercetos suelen resolver o dar un giro.$mq$, $mq$medium$mq$),
($mq$Haiku inventado: «Lluvia en la hoja, / un caracol se asoma: / respira el campo.» ¿Qué rasgo es propio de un haiku?$mq$, $mq$["Una reflexión filosófica extensa","Una imagen breve de la naturaleza que sugiere una emoción","Una rima consonante","Un diálogo entre dos personas"]$mq$, 1, $mq$El haiku capta un instante natural con pocas palabras.$mq$, $mq$medium$mq$),
($mq$¿Qué ventaja ofrece el verso libre a un poeta?$mq$, $mq$["Libertad para adaptar el ritmo y la forma al sentimiento","Obliga a rimar","Evita el uso de imágenes","Elimina el ritmo"]$mq$, 0, $mq$No sigue un patrón fijo, de modo que se ajusta a lo que se quiere expresar.$mq$, $mq$medium$mq$),
($mq$Estrofa inventada: «Dejé la luz en la ventana / por si regresabas de noche / y la tarde se fue sin fiesta…». ¿Qué sería necesario para llamarlo romance?$mq$, $mq$["Catorce versos consonantes","Solo tres versos","Rima ABBA exclusiva","Versos octosílabos y rima asonante en los pares"]$mq$, 3, $mq$El romance exige octosílabos con asonancia en los pares.$mq$, $mq$hard$mq$),
($mq$¿Qué efecto tiene que un poeta use un soneto para expresar un sentimiento personal?$mq$, $mq$["Anula la emoción","Obliga a narrar","La disciplina de la forma contrasta con la emoción y la hace más concentrada","Aumenta el humor siempre"]$mq$, 2, $mq$Las restricciones formales concentran el sentido y generan tensión expresiva.$mq$, $mq$hard$mq$),
($mq$Un poema inventado de 5 versos tiene rima abaab con versos de ocho sílabas. ¿Qué estrofa es?$mq$, $mq$["Soneto","Quintilla","Haiku","Romance"]$mq$, 1, $mq$La quintilla es de cinco versos octosílabos con dos rimas combinadas.$mq$, $mq$hard$mq$),
($mq$¿Por qué puede un caligrama combinar forma y significado?$mq$, $mq$["Porque la disposición visual refleja el tema, como un poema en forma de lluvia que cae","Porque elimina las palabras","Porque obliga a rimar","Porque solo se usa en prosa"]$mq$, 0, $mq$Al dibujar una imagen con las líneas, la forma refuerza el contenido.$mq$, $mq$hard$mq$),
($mq$Una alumna afirma: «Este poema no tiene forma porque es verso libre». ¿Qué corrección es adecuada?$mq$, $mq$["No hay corrección","Debe rimar","Debe ser un soneto","El verso libre también tiene forma: usa ritmo, cortes de versos, estrofas y pausas con intención"]$mq$, 3, $mq$Aunque no sigue un esquema fijo, la organización también significa.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Poetic Forms$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Soneto$mq$, $mq$Poema de catorce versos endecasílabos: dos cuartetos y dos tercetos. Los tercetos suelen dar un giro o conclusión.$mq$),
($mq$Endecasílabo$mq$, $mq$Verso de once sílabas métricas. Es el verso característico del soneto.$mq$),
($mq$Octosílabo$mq$, $mq$Verso de ocho sílabas métricas. Es típico del romance y de la copla.$mq$),
($mq$Romance$mq$, $mq$Serie de octosílabos con rima asonante en los versos pares; los impares quedan sueltos. Suele narrar historias.$mq$),
($mq$Haiku$mq$, $mq$Poema breve de tres versos, tradicionalmente de 5, 7 y 5 sílabas, que capta un instante de la naturaleza.$mq$),
($mq$Cuarteto y serventesio$mq$, $mq$Ambos tienen cuatro versos endecasílabos. El cuarteto rima ABBA; el serventesio rima ABAB.$mq$),
($mq$Verso libre$mq$, $mq$Verso sin rima fija ni métrica regular. Aun así tiene ritmo y forma con intención expresiva.$mq$),
($mq$Caligrama$mq$, $mq$Poema cuya disposición gráfica dibuja un objeto relacionado con el tema, de modo que forma y contenido se refuerzan.$mq$),
($mq$Reglas del conteo de sílabas métricas$mq$, $mq$Se aplica la sinalefa y, al final, aguda suma una sílaba, llana no cambia y esdrújula resta una.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Poetic Forms$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Lo esencial
La **forma** de un poema (cuántos versos tiene, cómo riman, cómo se agrupan) no es decoración: sirve para dar sentido. Reconocer las formas poéticas te permite explicar por qué el poeta eligió una estructura y qué efecto produce. En Lengua y Literatura se espera que combines la identificación con el análisis.

## Medida del verso
La **métrica** es el número de sílabas métricas de un verso. Algunos tipos habituales son:
- **Octosílabo:** ocho sílabas; típico del romance y de la copla.
- **Endecasílabo:** once sílabas; es el verso del soneto.
- **Alejandrino:** catorce sílabas.
- **Versos de arte menor:** hasta ocho sílabas. **De arte mayor:** nueve o más.
Recuerda: se cuenta con sinalefa y se aplican las reglas del final del verso (aguda suma una, esdrújula resta una).

## Rima
- **Rima consonante:** coinciden todos los sonidos desde la última vocal acentuada.
- **Rima asonante:** coinciden solo las vocales.
- **Versos sueltos:** no riman con ningún otro.
- Los esquemas se señalan con letras: con mayúsculas en versos de arte mayor y con minúsculas en versos de arte menor.

## Estrofas y poemas de forma fija
- **Cuarteto:** cuatro versos endecasílabos con rima consonante ABBA.
- **Serventesio:** cuatro versos endecasílabos con rima ABAB.
- **Terceto:** tres versos endecasílabos.
- **Quintilla:** cinco versos octosílabos con dos rimas combinadas.
- **Soneto:** catorce versos endecasílabos, divididos en dos cuartetos y dos tercetos. Los cuartetos suelen plantear una idea y los tercetos la resuelven o dan un giro.
- **Romance:** serie ilimitada de octosílabos con rima asonante en los versos pares; los impares quedan sueltos. Tiene origen en la tradición oral y suele narrar historias.
- **Haiku:** poema breve de tres versos, tradicionalmente de cinco, siete y cinco sílabas, que capta un instante de la naturaleza. Ejemplo inventado: «Lluvia en la hoja, / un caracol se asoma: / respira el campo.»

## Verso libre y caligrama
- **Verso libre:** sin rima fija ni métrica regular. Aun así, tiene ritmo, cortes de verso, pausas y estrofas que el poeta elige con intención.
- **Caligrama:** poema cuya disposición visual dibuja un objeto relacionado con el tema.

## Cómo analizar una forma
1. **Identifica** el tipo de poema o estrofa con pruebas: cuenta versos, sílabas y rimas.
2. **Explica** por qué esa forma conviene al contenido. Un soneto concentra la emoción; un romance cuenta historias con fluidez; un haiku concentra una imagen.
3. **Valora** el efecto: orden, tensión, musicalidad, silencio.
4. **Observa** si el poeta rompe la forma: una ruptura suele marcar un momento importante.

## Errores frecuentes
- **Contar sílabas gramaticales.** Debes usar sinalefa y reglas del final de verso.
- **Confundir cuarteto y serventesio.** Ambos tienen cuatro versos, pero ABBA y ABAB no son iguales.
- **Decir que el verso libre carece de forma.**
- **Nombrar la forma sin interpretarla.**

## Cómo se evalúa
En la evaluación en pantalla se muestra un poema original, breve, y se pide identificar su estructura, calcular el número de sílabas o explicar por qué el poeta eligió esa forma. En las tareas más abiertas se compara cómo dos formas distintas expresan sentimientos parecidos.

Exam tip: cuando identifiques una forma, aporta una prueba concreta (número de versos, esquema de rima o tipo de verso) y conecta enseguida con el significado.$mq$ from st;

-- Poetry > Comparing Poems
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Poetry$mq$, 5, 4 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Comparing Poems$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Poetry$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Comparing Poems$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué significa comparar dos poemas?$mq$, $mq$["Analizar semejanzas y diferencias de tema, forma, recursos y tono","Elegir el poema más corto","Copiar uno de ellos","Contar versos"]$mq$, 0, $mq$Comparar no es describir uno y luego otro: se relacionan sus puntos.$mq$, $mq$easy$mq$),
($mq$¿Qué palabra señala una semejanza?$mq$, $mq$["Sin embargo","En cambio","Por el contrario","Igualmente"]$mq$, 3, $mq$«Igualmente» introduce un punto en común.$mq$, $mq$easy$mq$),
($mq$¿Qué palabra señala una diferencia?$mq$, $mq$["Asimismo","También","En cambio","Del mismo modo"]$mq$, 2, $mq$«En cambio» marca contraste.$mq$, $mq$easy$mq$),
($mq$¿Qué debe contener una buena comparación?$mq$, $mq$["Solo opiniones","Pruebas textuales de ambos poemas","Solo un poema","Solo la biografía"]$mq$, 1, $mq$Cada afirmación debe apoyarse en citas.$mq$, $mq$easy$mq$),
($mq$¿Qué es el tema común de dos poemas?$mq$, $mq$["La idea que ambos tratan","La rima que comparten obligatoriamente","El mismo número de versos","El título"]$mq$, 0, $mq$Dos poemas pueden compartir un tema, como el paso del tiempo, aunque lo traten de manera distinta.$mq$, $mq$easy$mq$),
($mq$Poema A (inventado): «El tiempo es un río manso que me lleva». Poema B (inventado): «El tiempo me persigue con dientes de hierro». ¿Qué diferencia hay?$mq$, $mq$["Ambos presentan el tiempo igual","A es literal; B es un soneto","A usa onomatopeya; B, hipérbole","A presenta el tiempo de forma serena; B, de forma amenazante"]$mq$, 3, $mq$La metáfora del río manso transmite calma; la persecución con dientes de hierro, amenaza.$mq$, $mq$medium$mq$),
($mq$En una comparación, ¿qué estructura evita simplemente describir uno y luego otro?$mq$, $mq$["Escribir todo sobre A y todo sobre B","Copiar los poemas","Organizar por puntos (tema, recursos, tono) y relacionar ambos poemas en cada punto","Dar solo opiniones"]$mq$, 2, $mq$La estructura por puntos fuerza al análisis comparado.$mq$, $mq$medium$mq$),
($mq$Poema A: versos cortos y silencios. Poema B: versos largos con enumeraciones. ¿Qué efecto contrastado se puede explicar?$mq$, $mq$["Ambos son iguales","A transmite contención y vacío; B, desborde o agobio","A es más alegre por sus pausas","B no tiene ritmo"]$mq$, 1, $mq$La longitud y la enumeración modifican el ritmo y el efecto emocional.$mq$, $mq$medium$mq$),
($mq$Ambos poemas hablan del mar. A lo presenta como libertad; B, como peligro. ¿Qué conclusión comparativa es correcta?$mq$, $mq$["Comparten motivo, pero lo usan con valores simbólicos opuestos","No se pueden comparar","Ambos tienen el mismo tono","El mar no es un símbolo"]$mq$, 0, $mq$Un mismo elemento puede simbolizar significados distintos según el poeta.$mq$, $mq$medium$mq$),
($mq$¿Qué conector es adecuado en «A usa la ironía; ___, B opta por un tono solemne»?$mq$, $mq$["asimismo","igualmente","por ejemplo","en cambio"]$mq$, 3, $mq$Se contrastan dos tonos, así que se necesita un conector de contraste.$mq$, $mq$medium$mq$),
($mq$Poema A: «Yo, solo, miro la lluvia». Poema B: «Nosotros miramos la lluvia». ¿Qué diferencia de voz poética existe?$mq$, $mq$["A es colectiva; B individual","Ambas son impersonales","A usa una voz individual y aislada; B, una voz colectiva","A y B son idénticas"]$mq$, 2, $mq$El cambio de persona gramatical altera la perspectiva y el sentido.$mq$, $mq$medium$mq$),
($mq$Dos poemas tratan la despedida. A es un soneto; B, verso libre. ¿Qué análisis formal es útil?$mq$, $mq$["Decir que A es mejor","Explicar cómo la forma fija ordena la emoción en A y cómo el verso libre la deja fluir en B","Ignorar la forma","Contar solo versos"]$mq$, 1, $mq$Comparar forma implica explicar el efecto de cada estructura.$mq$, $mq$medium$mq$),
($mq$¿Qué pasa si una comparación solo dice «ambos poemas tratan del amor»?$mq$, $mq$["Es insuficiente: falta concretar cómo lo tratan y con qué recursos","Es perfecta","Es suficiente si hay una cita","Es una comparación completa"]$mq$, 0, $mq$El tema general no basta; se debe especificar el enfoque y las pruebas.$mq$, $mq$medium$mq$),
($mq$Poema A (inventado): «Mi abuela guardaba el verano en frascos de cristal». Poema B (inventado): «Mi abuela era un archivo de naftalina». ¿Qué comparación es la más sólida?$mq$, $mq$["Ambos hablan de cocina y nada más","A es sarcástico; B, humorístico","No hay metáforas","A transmite ternura y abundancia; B sugiere rigidez y olvido, con metáforas de signo emocional opuesto"]$mq$, 3, $mq$Ambos evocan a la abuela mediante metáforas, pero con connotaciones opuestas (conservación cálida frente a rigidez).$mq$, $mq$hard$mq$),
($mq$Dos poemas sobre la ciudad: A la describe con luces y música; B, con sombras y ruido de sirenas. Un alumno concluye: «Ambos tienen el mismo tono». ¿Qué falla?$mq$, $mq$["Nada falla","Falta contar sílabas","Ignora que el léxico y las imágenes crean tonos distintos (festivo y angustiado)","Falta una rima"]$mq$, 2, $mq$La selección de imágenes y sonidos revela actitudes diferentes.$mq$, $mq$hard$mq$),
($mq$¿Qué es más convincente al comparar dos poemas?$mq$, $mq$["Dedicar un párrafo a cada poema por separado","Relacionar un recurso de cada poema con su efecto y con el tema en una misma frase comparativa","Copiar las estrofas","Enumerar solo los recursos"]$mq$, 1, $mq$La comparación integrada demuestra pensamiento crítico.$mq$, $mq$hard$mq$),
($mq$Poema A termina con una pregunta; poema B con una afirmación rotunda. ¿Qué diferencia de efecto puede explicarse?$mq$, $mq$["A deja abierta la duda; B transmite certeza o cierre","Ambos cierran del mismo modo","A es siempre más largo","B no tiene final"]$mq$, 0, $mq$La pregunta final abre; la afirmación cierra.$mq$, $mq$hard$mq$),
($mq$Una pregunta de examen dice: «Compara cómo los poetas transmiten la nostalgia». ¿Qué plan es más sólido?$mq$, $mq$["Resumir los dos poemas","Hablar de los poetas","Elegir el poema más largo","Definir la nostalgia en ambos, comparar imágenes, tono y forma con citas, y concluir cuál transmite el sentimiento más intensamente y por qué"]$mq$, 3, $mq$La respuesta debe comparar el «cómo» con pruebas y valorarlo.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Comparing Poems$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Comparar poemas$mq$, $mq$Relacionar dos poemas punto por punto (tema, tono, voz, imágenes, forma y efecto), no describirlos por separado.$mq$),
($mq$Estructura integrada$mq$, $mq$Cada párrafo trata un aspecto y relaciona los dos poemas. Puntúa más que describir primero A y luego B.$mq$),
($mq$Tesis comparativa$mq$, $mq$Idea central que resume semejanza y diferencia: «Ambos tratan la pérdida, pero A con calma y B con dolor».$mq$),
($mq$Conectores de semejanza$mq$, $mq$Igualmente, del mismo modo, asimismo, también, al igual que.$mq$),
($mq$Conectores de diferencia$mq$, $mq$En cambio, por el contrario, sin embargo, mientras que, a diferencia de.$mq$),
($mq$Qué comparar en dos poemas$mq$, $mq$Tema, tono, voz poética, imágenes y símbolos, forma, sonido y ritmo, y efecto en el lector.$mq$),
($mq$Frase comparativa modelo$mq$, $mq$Cita en A + efecto + conector + cita en B + efecto + tema común.$mq$),
($mq$Error frecuente en comparaciones$mq$, $mq$Quedarse en un tema general como «ambos hablan del amor» sin concretar enfoque, recursos ni citas.$mq$),
($mq$Un mismo motivo con distinto símbolo$mq$, $mq$Dos poemas pueden usar el mar, pero uno como libertad y otro como peligro. Hay que explicar la diferencia de sentido.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Comparing Poems$mq$ and p.name = $mq$Poetry$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Lo esencial
Comparar poemas es una de las tareas más exigentes del curso, porque obliga a mirar dos textos a la vez y encontrar conexiones. No se trata de describir un poema y luego otro, sino de **relacionarlos** punto por punto: tema, tono, voz, imágenes, forma y efecto. La mejor comparación tiene una idea central clara y se sostiene con citas.

## Qué se compara
- **Tema:** ¿tratan el mismo asunto? ¿Con qué enfoque? Dos poemas sobre el mar pueden presentarlo como libertad o como peligro.
- **Tono:** ¿serenos, irónicos, melancólicos, furiosos?
- **Voz poética:** persona gramatical (yo, nosotros), destinatario, actitud.
- **Imágenes y símbolos:** ¿qué recursos usan? ¿Con qué connotaciones?
- **Forma y estructura:** soneto, verso libre, versos cortos o largos, estrofas, cierre.
- **Sonido y ritmo:** rima, aliteración, pausas.
- **Efecto en el lector:** emociones y ideas que cada poema provoca.

## Cómo organizar la respuesta
Hay dos estructuras posibles:
- **Por poemas (bloques):** primero A, luego B. Es más sencilla, pero suele quedarse en la descripción.
- **Por puntos (integrada):** cada párrafo trata un aspecto (por ejemplo, el tono) y relaciona A con B. Es la que mejor puntúa.
Empieza con una tesis comparativa: «Ambos poemas retratan la pérdida, pero A la presenta como una calma resignada, mientras que B la vive como una herida abierta.»

## Conectores de comparación
- **Semejanza:** igualmente, del mismo modo, asimismo, también, al igual que.
- **Diferencia:** en cambio, por el contrario, sin embargo, mientras que, a diferencia de.
- **Matiz:** aunque, si bien, no obstante.
Úsalos para mostrar que estás relacionando los textos y no solo enumerándolos.
Ejemplo inventado: «A presenta el tiempo como un río manso; en cambio, B lo muestra como un perseguidor, con “dientes de hierro”.»

## Una frase comparativa modelo
Cita en A + efecto + conector + cita en B + efecto + tema común. Ejemplo: «En A, “un río manso” sugiere serenidad ante el paso del tiempo; en cambio, en B, “me persigue con dientes de hierro” transmite miedo, de modo que ambos tratan la fugacidad, pero con actitudes opuestas.»

## Errores frecuentes
- **Describir dos poemas sin relacionarlos.**
- **Hablar solo de similitudes o solo de diferencias.** Los mejores análisis combinan ambas.
- **Quedarse en el tema general.** «Ambos hablan del amor» es insuficiente.
- **Olvidar las citas.**
- **Valorar sin criterio.** «A es mejor» necesita razones basadas en el efecto.
- **Ignorar la forma.** Pasa por alto contrastes importantes.

## Cómo se evalúa
En la evaluación en pantalla se ofrecen dos poemas breves, originales, de tema relacionado. Las preguntas piden comparar el tono, las imágenes o el modo de cerrar el poema, y luego redactar una conclusión. Las respuestas con mejor nivel presentan una tesis, usan conectores y cierran con una valoración razonada.

Exam tip: antes de escribir, anota tres puntos de contacto y una diferencia clave; así tu respuesta tendrá una tesis comparativa y no será una descripción en paralelo.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;