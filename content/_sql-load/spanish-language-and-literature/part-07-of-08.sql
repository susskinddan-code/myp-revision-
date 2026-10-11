-- Part 7 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Grammar and Accuracy > Verb Tenses and Moods
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Grammar and Accuracy$mq$, 5, 7 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Verb Tenses and Moods$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Grammar and Accuracy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Verb Tenses and Moods$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$Completa: «Ayer nosotros ___ al cine».$mq$, $mq$["fuimos","vamos","iremos","vayamos"]$mq$, 0, $mq$«Ayer» pide un pasado puntual: pretérito indefinido de «ir», «fuimos».$mq$, $mq$easy$mq$),
($mq$Completa: «Cuando era niña, ___ en el campo».$mq$, $mq$["viví","viviré","viva","vivía"]$mq$, 3, $mq$El imperfecto describe una situación habitual o de fondo en el pasado.$mq$, $mq$easy$mq$),
($mq$Completa: «El próximo año ___ a Chile».$mq$, $mq$["viajé","viajaba","viajaré","viajado"]$mq$, 2, $mq$«El próximo año» sitúa la acción en el futuro: futuro simple, «viajaré».$mq$, $mq$easy$mq$),
($mq$¿Qué frase está en modo imperativo?$mq$, $mq$["«Cerraba la ventana»","«Cierra la ventana, por favor»","«Cerré la ventana»","«Cerraría la ventana»"]$mq$, 1, $mq$El imperativo expresa órdenes, peticiones o consejos: «cierra».$mq$, $mq$easy$mq$),
($mq$Completa: «Esta semana he ___ tres cuentos».$mq$, $mq$["escrito","escribido","escribió","escribiendo"]$mq$, 0, $mq$«Escribir» tiene un participio irregular: «escrito».$mq$, $mq$easy$mq$),
($mq$Completa: «Esta mañana ___ fruta para desayunar».$mq$, $mq$["desayuné","desayunaba","desayunaré","he desayunado"]$mq$, 3, $mq$«Esta mañana» incluye el presente de quien habla, así que se usa el pretérito perfecto compuesto.$mq$, $mq$medium$mq$),
($mq$Completa: «Quiero que tú ___ a mi fiesta».$mq$, $mq$["vienes","vendrás","vengas","vienas"]$mq$, 2, $mq$Tras «querer que» se usa el presente de subjuntivo: «vengas».$mq$, $mq$medium$mq$),
($mq$Completa: «Si tuviera tiempo, ___ más libros».$mq$, $mq$["leeré","leería","leí","leo"]$mq$, 1, $mq$En las condicionales irreales, la oración principal usa el condicional: «leería».$mq$, $mq$medium$mq$),
($mq$Completa: «Dudo que ella ___ la verdad».$mq$, $mq$["diga","dice","dirá","dijo"]$mq$, 0, $mq$Los verbos de duda y negación de certeza suelen exigir subjuntivo: «diga».$mq$, $mq$medium$mq$),
($mq$Completa: «Ayer ellos ___ la verdad».$mq$, $mq$["dijieron","decieron","dijeran","dijeron"]$mq$, 3, $mq$«Decir» tiene pretérito irregular con «j» y la terminación «-eron»: «dijeron».$mq$, $mq$medium$mq$),
($mq$Completa: «Cuando eran jóvenes, todos los veranos mis abuelos ___ a la playa».$mq$, $mq$["viajarán","viajen","viajaban","viajaran"]$mq$, 2, $mq$La costumbre en el pasado se expresa con el imperfecto: «viajaban».$mq$, $mq$medium$mq$),
($mq$Completa: «Si yo ___ tú, hablaría con ella».$mq$, $mq$["soy","fuera","seré","sería"]$mq$, 1, $mq$En condicionales irreales, la parte con «si» lleva imperfecto de subjuntivo: «fuera».$mq$, $mq$medium$mq$),
($mq$Completa: «Cuando llegamos, la película ya ___».$mq$, $mq$["había empezado","ha empezado","empezará","empiece"]$mq$, 0, $mq$Una acción anterior a otra acción pasada se expresa con el pluscuamperfecto.$mq$, $mq$medium$mq$),
($mq$Completa: «Espero que mañana no ___».$mq$, $mq$["llueve","lloverá","llovió","llueva"]$mq$, 3, $mq$«Esperar que» exige subjuntivo, y aquí se trata de una expectativa futura: «llueva».$mq$, $mq$hard$mq$),
($mq$Completa: «Cuando ___ el examen, saldré a jugar».$mq$, $mq$["termino","terminaré","termine","terminé"]$mq$, 2, $mq$Tras «cuando» y con referencia al futuro se usa presente de subjuntivo: «termine».$mq$, $mq$hard$mq$),
($mq$¿Qué oración es correcta?$mq$, $mq$["«Si tendría dinero, compraría un coche»","«Si tuviera dinero, compraría un coche»","«Si tengo dinero, compraría un coche»","«Si tuviera dinero, compré un coche»"]$mq$, 1, $mq$La condicional irreal combina imperfecto de subjuntivo («tuviera») y condicional («compraría»).$mq$, $mq$hard$mq$),
($mq$¿Qué oración mantiene la coherencia de tiempos?$mq$, $mq$["«Entré en la sala, vi a mi amigo y le pregunté si había visto la película»","«Entro en la sala, vi a mi amigo y le pregunto si había visto la película»","«Entré en la sala, veo a mi amigo y le pregunté si he visto la película»","«Entraré en la sala, vi a mi amigo y le preguntaba si ver la película»"]$mq$, 0, $mq$Todos los hechos están en pasado, y «había visto» expresa una acción anterior a «pregunté».$mq$, $mq$hard$mq$),
($mq$Completa: «Quería que mis padres me ___ una bicicleta».$mq$, $mq$["compran","compren","compraron","compraran"]$mq$, 3, $mq$Con «quería que» (pasado) se usa imperfecto de subjuntivo: «compraran».$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Verb Tenses and Moods$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Pretérito indefinido$mq$, $mq$Acción puntual y terminada en el pasado: ayer fuimos, escribió, dijeron.$mq$),
($mq$Pretérito imperfecto$mq$, $mq$Descripción, costumbre o acción en curso en el pasado: vivía, viajaban, era.$mq$),
($mq$Pretérito perfecto compuesto$mq$, $mq$He + participio; acción pasada conectada con el presente: he escrito, hemos desayunado.$mq$),
($mq$Pluscuamperfecto$mq$, $mq$Había + participio; acción anterior a otra acción pasada: había empezado.$mq$),
($mq$Participios irregulares$mq$, $mq$escrito, hecho, dicho, visto, puesto, abierto, roto, vuelto.$mq$),
($mq$Subjuntivo tras deseo y duda$mq$, $mq$Quiero que vengas; dudo que diga; espero que no llueva.$mq$),
($mq$Subjuntivo con cuando (futuro)$mq$, $mq$Cuando termine el examen, saldré. Con referencia futura se usa subjuntivo.$mq$),
($mq$Condicional irreal$mq$, $mq$Si + imperfecto de subjuntivo, condicional: Si tuviera tiempo, leería más.$mq$),
($mq$Error típico$mq$, $mq$No se dice «si tendría»; tras «si» no va condicional. Correcto: «si tuviera».$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Verb Tenses and Moods$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Los tiempos y modos verbales son uno de los puntos más examinables de la corrección lingüística en Lengua y Literatura. Un error de tiempo o de modo cambia el significado y resta claridad. Para MYP 5 se espera que uses con seguridad los tiempos del pasado, el futuro, el condicional y el subjuntivo en frases habituales.

## Modo indicativo
Expresa hechos, certezas y acciones reales. Sus tiempos principales son:
- **Presente**: hábitos y hechos actuales (escribo, leemos).
- **Pretérito indefinido**: acciones puntuales y terminadas en el pasado (ayer fuimos, escribió).
- **Pretérito imperfecto**: descripciones, costumbres y acciones en curso en el pasado (vivía, viajaban).
- **Pretérito perfecto compuesto**: acciones pasadas que conectan con el presente (he escrito, hemos desayunado). Aparece con «hoy», «esta semana», «esta mañana».
- **Pretérito pluscuamperfecto**: acción anterior a otra del pasado (había empezado).
- **Futuro simple**: acciones por venir (viajaré).
- **Condicional**: hipótesis o consecuencia (leería, compraría).

## Modo subjuntivo
Se usa para deseos, dudas, emociones, opiniones negadas y situaciones hipotéticas. Se activa tras expresiones como:
- Deseo o petición: quiero que, espero que, ojalá.
- Duda o negación: dudo que, no creo que, es posible que.
- Emoción: me alegra que, siento que.
- Tiempo futuro: cuando, en cuanto, antes de que («Cuando termine el examen, saldré»).
Ejemplos: «Quiero que vengas», «Dudo que ella diga la verdad», «Espero que mañana no llueva».

## Concordancia de tiempos con el subjuntivo
Si el verbo principal está en presente o futuro, el subordinado suele ir en presente de subjuntivo: «Quiero que vengas». Si el verbo principal está en pasado, suele ir en imperfecto de subjuntivo: «Quería que mis padres me compraran una bicicleta».

## Oraciones condicionales
- **Reales**: si + presente, futuro o presente («Si estudias, aprobarás»).
- **Irreales**: si + imperfecto de subjuntivo, condicional («Si tuviera tiempo, leería más libros»).
- Error típico: «si tendría»; después de «si» no se usa condicional.

## Modo imperativo
Sirve para dar órdenes o consejos: «Cierra la ventana», «Escribid con cuidado», «No hables tan alto». En el imperativo negativo se emplea el subjuntivo («no cierres»).

## Verbos irregulares frecuentes
- decir: dijo, dijeron.
- hacer: hizo, hecho.
- escribir: escrito.
- ir: fui, fuimos.
- poner: puso, puesto.
- ver: visto.
Aprende estas formas y revisa los participios irregulares.

## Cómo se evalúa
Las preguntas pueden pedir completar frases, elegir la forma correcta, detectar errores en un texto o explicar el efecto de un cambio de tiempo en una narración. Además, en la escritura se valora la coherencia: no mezclar pasado y presente sin motivo.

## Errores frecuentes
- Usar «he» con «ayer» (con marcadores de pasado cerrado se prefiere el indefinido).
- Mezclar tiempos dentro de una misma narración.
- Olvidar el subjuntivo tras expresiones de deseo, duda o tiempo futuro.
- Formas incorrectas como «escribido» o «dijieron».

Exam tip: al revisar tu texto, subraya cada verbo y comprueba tres cosas: ¿es coherente con el momento de la historia?, ¿lleva el modo adecuado? y ¿la forma está bien escrita?$mq$ from st;

-- Grammar and Accuracy > Sentence Structure and Punctuation
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Grammar and Accuracy$mq$, 5, 7 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Sentence Structure and Punctuation$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Grammar and Accuracy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Sentence Structure and Punctuation$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Cómo se escribe correctamente esta pregunta en español?$mq$, $mq$["¿Dónde vives?","Dónde vives?","¿Dónde vives","¿Dónde vives¿"]$mq$, 0, $mq$En español las preguntas llevan signo de apertura (¿) y de cierre (?).$mq$, $mq$easy$mq$),
($mq$¿Qué oración usa bien las comas en una enumeración?$mq$, $mq$["Compré manzanas peras y uvas.","Compré, manzanas, peras y uvas.","Compré manzanas, peras, y uvas.","Compré manzanas, peras y uvas."]$mq$, 3, $mq$Los elementos se separan con comas, pero antes de «y» no se pone coma en una enumeración sencilla.$mq$, $mq$easy$mq$),
($mq$¿Cuál de estas palabras se escribe con mayúscula inicial en medio de una frase?$mq$, $mq$["lunes","marzo","Madrid","primavera"]$mq$, 2, $mq$Los nombres propios llevan mayúscula; los días, los meses y las estaciones se escriben con minúscula.$mq$, $mq$easy$mq$),
($mq$¿Qué indica un punto y aparte?$mq$, $mq$["Una pausa breve dentro de una frase","El final de un párrafo","El final de una pregunta","Una enumeración"]$mq$, 1, $mq$El punto y aparte cierra el párrafo y la siguiente línea empieza un párrafo nuevo.$mq$, $mq$easy$mq$),
($mq$En «Los niños juegan en el parque», ¿cuál es el sujeto?$mq$, $mq$["Los niños","juegan","en el parque","juegan en el parque"]$mq$, 0, $mq$El sujeto es quien realiza la acción: «los niños». El resto es el predicado.$mq$, $mq$easy$mq$),
($mq$¿Qué oración puntúa bien el vocativo?$mq$, $mq$["Ven aquí Marta.","Ven, aquí Marta.","Ven aquí Marta,","Ven aquí, Marta."]$mq$, 3, $mq$El vocativo (el nombre de a quien nos dirigimos) se separa con coma.$mq$, $mq$medium$mq$),
($mq$¿Cuándo es adecuado usar el punto y coma?$mq$, $mq$["Antes de una pregunta","Al final de cada título","Entre dos oraciones relacionadas: «Llovía mucho; cancelamos el partido»","Entre el sujeto y el verbo siempre"]$mq$, 2, $mq$El punto y coma une ideas cercanas con una pausa mayor que la coma y menor que el punto.$mq$, $mq$medium$mq$),
($mq$¿Qué frase usa correctamente los dos puntos?$mq$, $mq$["Necesito: tres cosas papel, lápiz y goma.","Necesito tres cosas: papel, lápiz y goma.","Necesito tres: cosas papel, lápiz y goma.","Necesito tres cosas papel: lápiz y goma."]$mq$, 1, $mq$Los dos puntos introducen una enumeración o explicación tras una frase completa.$mq$, $mq$medium$mq$),
($mq$¿Qué oración puntúa bien una conjunción adversativa?$mq$, $mq$["Estudié mucho, pero suspendí.","Estudié mucho pero, suspendí.","Estudié, mucho pero suspendí.","Estudié mucho pero suspendí,"]$mq$, 0, $mq$Antes de «pero» se pone coma; no después de la conjunción.$mq$, $mq$medium$mq$),
($mq$En «Dijo que vendría», ¿cuál es la oración subordinada?$mq$, $mq$["Dijo","Dijo que","vendría que","que vendría"]$mq$, 3, $mq$«Que vendría» depende del verbo principal «dijo» y funciona como complemento directo.$mq$, $mq$medium$mq$),
($mq$¿Qué oración puntúa correctamente la aposición?$mq$, $mq$["Cervantes autor del Quijote, nació en Alcalá de Henares.","Cervantes, autor del Quijote nació en Alcalá de Henares.","Cervantes, autor del Quijote, nació en Alcalá de Henares.","Cervantes autor del Quijote nació en Alcalá de Henares."]$mq$, 2, $mq$La aposición se encierra entre dos comas. Cervantes nació en Alcalá de Henares en 1547.$mq$, $mq$medium$mq$),
($mq$¿Cuál es una oración compuesta?$mq$, $mq$["Salimos temprano.","Salimos cuando dejó de llover.","Los pájaros cantan.","Mi hermana estudia música."]$mq$, 1, $mq$Tiene dos verbos conjugados («salimos» y «dejó») y dos proposiciones.$mq$, $mq$medium$mq$),
($mq$¿Qué oración tiene la concordancia correcta?$mq$, $mq$["Los problemas de matemáticas son difíciles.","Los problemas de matemáticas es difícil.","Los problemas de matemáticas son difícil.","Los problemas de matemáticas es difíciles."]$mq$, 0, $mq$El verbo y el adjetivo concuerdan en número con el sujeto plural: «son difíciles».$mq$, $mq$medium$mq$),
($mq$¿Qué diferencia de sentido hay entre «Vamos a comer, niños» y «Vamos a comer niños»?$mq$, $mq$["Ninguna, solo cambia el tiempo verbal","La primera es una pregunta","La segunda es un diálogo","La primera invita a los niños a comer; la segunda dice que se comerá a niños"]$mq$, 3, $mq$La coma marca el vocativo: sin ella, «niños» es el complemento directo de «comer».$mq$, $mq$hard$mq$),
($mq$¿Qué oración evita el dequeísmo?$mq$, $mq$["Pienso de que tienes razón.","Pienso del que tienes razón.","Pienso que tienes razón.","Pienso de qué tienes razón."]$mq$, 2, $mq$«Pensar» no lleva preposición «de» ante la subordinada: se dice «pienso que».$mq$, $mq$hard$mq$),
($mq$¿Cuál es un fragmento, es decir, una oración incompleta, si se escribe sola?$mq$, $mq$["Estaba cansada.","Aunque estaba cansada.","Siguió trabajando.","Aunque estaba cansada, siguió."]$mq$, 1, $mq$«Aunque estaba cansada» deja la idea sin acabar: necesita una oración principal.$mq$, $mq$hard$mq$),
($mq$¿Qué oración mantiene el paralelismo?$mq$, $mq$["Me gusta nadar, leer y bailar.","Me gusta nadar, leer y el baile.","Me gusta nadar, la lectura y bailar.","Me gusta nadar, lectura y bailando."]$mq$, 0, $mq$Los tres elementos de la enumeración van en infinitivo: la estructura es uniforme.$mq$, $mq$hard$mq$),
($mq$¿Qué opción une mejor «Estaba lloviendo. Salimos igualmente» con una idea de concesión y buena puntuación?$mq$, $mq$["Aunque estaba lloviendo. Salimos igualmente.","Estaba lloviendo aunque salimos igualmente.","Estaba lloviendo salimos igualmente.","Aunque estaba lloviendo, salimos igualmente."]$mq$, 3, $mq$«Aunque» introduce la concesión, y la subordinada inicial se separa con coma de la principal.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Sentence Structure and Punctuation$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Sujeto y predicado$mq$, $mq$Sujeto: quien realiza la acción. Predicado: lo que se dice del sujeto.$mq$),
($mq$Oración simple y compuesta$mq$, $mq$Simple: un verbo conjugado. Compuesta: dos o más, coordinadas o subordinadas.$mq$),
($mq$Coma con vocativo$mq$, $mq$Se separa el nombre de quien escucha: «Ven aquí, Marta». Sin coma cambia el sentido.$mq$),
($mq$Coma con aposición$mq$, $mq$Se encierra entre comas: «Cervantes, autor del Quijote, nació en Alcalá de Henares».$mq$),
($mq$Coma antes de pero$mq$, $mq$«Estudié mucho, pero suspendí.» Va antes de la conjunción adversativa.$mq$),
($mq$Dos puntos$mq$, $mq$Introducen una enumeración, explicación o cita: «Necesito tres cosas: papel, lápiz y goma».$mq$),
($mq$Signos dobles en español$mq$, $mq$Interrogación y exclamación se abren y se cierran: ¿Dónde vives? ¡Qué sorpresa!$mq$),
($mq$Fragmento$mq$, $mq$Oración incompleta, como «Aunque estaba cansada.»; necesita una principal.$mq$),
($mq$Mayúsculas$mq$, $mq$Inicio de oración y nombres propios. Días, meses y estaciones: minúscula.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Sentence Structure and Punctuation$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$Una buena sintaxis y una puntuación precisa hacen que tus ideas se entiendan a la primera. En Lengua y Literatura, estos aspectos influyen directamente en la claridad de tus textos y en la nota de lenguaje. En esta lección repasamos los tipos de oraciones, las relaciones entre ellas y las reglas de puntuación más rentables.

## Estructura de la oración
- **Sujeto**: quién realiza la acción («Los niños» en «Los niños juegan en el parque»).
- **Predicado**: lo que se dice del sujeto («juegan en el parque»).
- **Oración simple**: contiene un solo verbo conjugado («Mi hermana estudia música»).
- **Oración compuesta**: contiene dos o más verbos conjugados. Pueden estar **coordinadas** (unidas por «y», «pero», «o») o ser **subordinadas** (una depende de otra: «Dijo que vendría»).
- **Concordancia**: el verbo, el sustantivo y el adjetivo deben coincidir en número y género («Los problemas son difíciles»).

## Variar la sintaxis
Un texto lleno de frases cortas suena monótono, y uno lleno de frases largas cansa. Combina ambas. Por ejemplo, «Estaba lloviendo. Salimos igualmente» mejora con una concesiva: «Aunque estaba lloviendo, salimos igualmente». Usa también conectores y subordinadas de causa, consecuencia, tiempo y concesión.

## Frases claras
- **Paralelismo**: mantén la misma estructura en las enumeraciones («Me gusta nadar, leer y bailar», no «nadar, la lectura y bailando»).
- **Fragmentos**: «Aunque estaba cansada.» es un fragmento; falta la oración principal.
- **Dequeísmo**: evita «pienso de que»; la forma correcta es «pienso que».

## Signos de puntuación
- **Punto**: seguido (misma línea del párrafo), aparte (cierra el párrafo) y final.
- **Coma**: separa elementos de una enumeración («manzanas, peras y uvas»), encierra el vocativo y la aposición («Cervantes, autor del Quijote, nació en Alcalá de Henares»), y va antes de «pero» («Estudié mucho, pero suspendí»). No separa sujeto y verbo.
- **Punto y coma**: une ideas relacionadas y separa elementos de una lista que ya llevan comas.
- **Dos puntos**: introducen una enumeración, una explicación o una cita.
- **Signos de interrogación y exclamación**: en español van siempre al principio y al final (¿Dónde vives?, ¡Qué sorpresa!).
- **Raya**: diálogos e incisos.
- **Comillas**: citas y títulos de poemas o artículos.
- **Mayúsculas**: inicio de oración y nombres propios. Los días, los meses y las estaciones van en minúscula.

## La coma puede cambiar el sentido
«Vamos a comer, niños» (invitación) no significa lo mismo que «Vamos a comer niños». Al revisar, pregúntate si una coma o su ausencia cambia lo que quieres decir.

## Cómo se evalúa
Verás preguntas para elegir la oración correctamente puntuada, detectar errores, unir frases con conectores adecuados o reescribir un fragmento. En tus propios textos se valora que utilices estructuras variadas con corrección.

## Errores frecuentes
- Poner coma entre sujeto y verbo.
- Olvidar el signo de apertura (¿ o ¡).
- Dejar subordinadas como frases sueltas.
- Escribir meses o días con mayúscula.
- Dequeísmo o queísmo.

Exam tip: lee tu texto en voz baja; allí donde hagas una pausa natural puede ir una coma, y donde te falte el aire, quizá necesites un punto.$mq$ from st;

-- Grammar and Accuracy > Spelling and Vocabulary
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Grammar and Accuracy$mq$, 5, 7 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Spelling and Vocabulary$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Grammar and Accuracy$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Spelling and Vocabulary$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué palabra está bien escrita?$mq$, $mq$["hacer","aser","acer","hazer"]$mq$, 0, $mq$El verbo «hacer» se escribe con h inicial y con c ante e.$mq$, $mq$easy$mq$),
($mq$¿Qué palabra lleva la tilde en el lugar correcto?$mq$, $mq$["cancion","cáncion","canciòn","canción"]$mq$, 3, $mq$«Canción» es aguda terminada en -n, por eso lleva tilde en la última sílaba.$mq$, $mq$easy$mq$),
($mq$Completa: «Voy ___ la película con mis amigos».$mq$, $mq$["haber","a ber","a ver","aver"]$mq$, 2, $mq$«A ver» es la preposición «a» seguida del verbo «ver».$mq$, $mq$easy$mq$),
($mq$¿Qué palabra está bien escrita?$mq$, $mq$["ospital","hospital","hospitál","hóspital"]$mq$, 1, $mq$«Hospital» lleva h inicial y es aguda terminada en -l, por lo que no lleva tilde.$mq$, $mq$easy$mq$),
($mq$¿Cuál es un sinónimo de «rápido»?$mq$, $mq$["veloz","lento","sereno","pesado"]$mq$, 0, $mq$«Veloz» expresa también gran velocidad.$mq$, $mq$easy$mq$),
($mq$Completa: «¿___ llegaste tarde?».$mq$, $mq$["Porque","Porqué","Por que","Por qué"]$mq$, 3, $mq$En preguntas directas se usa «por qué», en dos palabras y con tilde.$mq$, $mq$medium$mq$),
($mq$Completa: «Tiene que ___ una solución».$mq$, $mq$["a ver","aver","haber","haver"]$mq$, 2, $mq$«Haber» es el verbo (aquí infinitivo de «existir/darse»). «A ver» es preposición más verbo.$mq$, $mq$medium$mq$),
($mq$Completa: «___ eres muy amable, y ___ madre también».$mq$, $mq$["Tu / tú","Tú / tu","Tú / tú","Tu / tu"]$mq$, 1, $mq$«Tú» (pronombre) lleva tilde; «tu» (posesivo) no la lleva.$mq$, $mq$medium$mq$),
($mq$¿Qué palabra está bien escrita?$mq$, $mq$["imposible","inposible","imposibel","inmposible"]$mq$, 0, $mq$Antes de p y b se escribe m: «imposible».$mq$, $mq$medium$mq$),
($mq$¿Qué palabra no pertenece a la familia de «zapato»?$mq$, $mq$["zapatero","zapatería","zapatilla","zafiro"]$mq$, 3, $mq$«Zafiro» es una piedra preciosa, sin relación con «zapato».$mq$, $mq$medium$mq$),
($mq$¿Qué palabra tiene una connotación más negativa?$mq$, $mq$["delgado","esbelto","esquelético","estilizado"]$mq$, 2, $mq$«Esquelético» sugiere una delgadez extrema y poco saludable; las otras son neutras o positivas.$mq$, $mq$medium$mq$),
($mq$¿Qué palabra es más adecuada que «currar» en un texto formal?$mq$, $mq$["currar","trabajar","chambear","apencar"]$mq$, 1, $mq$«Trabajar» es neutro y adecuado a un registro formal; las otras son coloquiales o regionales.$mq$, $mq$medium$mq$),
($mq$¿Por qué lleva tilde «María»?$mq$, $mq$["Por el hiato: la «i» débil es tónica","Porque es aguda","Porque es esdrújula","Porque es un nombre propio"]$mq$, 0, $mq$La «í» tónica rompe el diptongo con la «a» y exige tilde, aunque sea una palabra llana terminada en vocal.$mq$, $mq$medium$mq$),
($mq$Completa: «Dime el ___ de tu decisión».$mq$, $mq$["por qué","porque","por que","porqué"]$mq$, 3, $mq$Cuando significa «motivo» y va precedido de artículo, se escribe «porqué», una sola palabra con tilde.$mq$, $mq$hard$mq$),
($mq$Completa: «No quiero té, ___ café».$mq$, $mq$["si no","sinó","sino","cino"]$mq$, 2, $mq$«Sino» introduce una alternativa tras una negación («no… sino…»).$mq$, $mq$hard$mq$),
($mq$¿En qué oración «aún» significa «todavía»?$mq$, $mq$["«Aun los más pequeños saben nadar»","«Aún no han llegado los invitados»","«Aun así, salimos a correr»","«Ni aun con ayuda lo logró»"]$mq$, 1, $mq$Con valor de «todavía» lleva tilde; con valor de «incluso» o en «aun así» no la lleva.$mq$, $mq$hard$mq$),
($mq$¿Cuál es la mejor sustitución de la palabra vaga «cosa» en «Me regalaron una cosa para escribir»?$mq$, $mq$["un bolígrafo","un objeto","algo","un elemento"]$mq$, 0, $mq$Las palabras comodín como «cosa» empobrecen el texto; un sustantivo concreto da precisión.$mq$, $mq$hard$mq$),
($mq$En «La fama de ese cantante fue efímera», ¿qué significa «efímera»?$mq$, $mq$["Eterna","Ruidosa","Injusta","De corta duración"]$mq$, 3, $mq$«Efímero» se aplica a lo que dura poco; el contexto («fama») ayuda a deducirlo.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Spelling and Vocabulary$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Aguda con tilde$mq$, $mq$Lleva tilde si termina en vocal, -n o -s: canción, café, compás.$mq$),
($mq$Llana con tilde$mq$, $mq$Lleva tilde si NO termina en vocal, -n o -s: árbol, lápiz.$mq$),
($mq$Hiato con tilde$mq$, $mq$Vocal débil tónica junto a vocal fuerte lleva tilde: María, día.$mq$),
($mq$Por qué, porque, porqué$mq$, $mq$Por qué: pregunta. Porque: causa. Porqué: sustantivo (motivo), «el porqué».$mq$),
($mq$A ver y haber$mq$, $mq$A ver: preposición + ver. Haber: verbo auxiliar o existencial.$mq$),
($mq$Sino y si no$mq$, $mq$Sino: «No quiero té, sino café». Si no: condición, «si no vienes…».$mq$),
($mq$Aún y aun$mq$, $mq$Aún = todavía. Aun = incluso («aun así»).$mq$),
($mq$Tú y tu$mq$, $mq$Tú: pronombre. Tu: posesivo, sin tilde.$mq$),
($mq$Connotación$mq$, $mq$Matiz positivo o negativo de una palabra: delgado (neutro) frente a esquelético (negativo).$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Spelling and Vocabulary$mq$ and p.name = $mq$Grammar and Accuracy$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$La ortografía y el vocabulario forman la base de una escritura precisa. Aunque no sean el único aspecto que se evalúa, los errores frecuentes distraen al lector y limitan la nota de lenguaje. Un buen vocabulario, además, te permite expresar matices en el análisis literario. En esta lección repasamos las reglas más rentables y estrategias para ampliar tu léxico.

## Tilde y acentuación
- **Agudas** (última sílaba tónica): llevan tilde si terminan en vocal, -n o -s (canción, café, compás).
- **Llanas** (penúltima sílaba tónica): llevan tilde si NO terminan en vocal, -n o -s (árbol, lápiz).
- **Esdrújulas y sobresdrújulas**: siempre llevan tilde (pájaro, cuéntamelo).
- **Hiato**: cuando una vocal débil (i, u) es tónica junto a una vocal fuerte, lleva tilde (María, día, país).
- **Tilde diacrítica**: distingue palabras iguales con funciones distintas: tú (pronombre) y tu (posesivo); él y el; sí y si; más y mas (pero); qué (interrogativo) y que.

## Parejas que se confunden
- **a ver** (preposición + verbo): «Voy a ver la película». **haber** (verbo): «Tiene que haber una solución».
- **por qué** (pregunta): «¿Por qué llegaste tarde?». **porque** (causa): «Llegué tarde porque perdí el autobús». **porqué** (sustantivo = motivo): «No entiendo el porqué». **por que** (= para que): «Lucho por que haya paz» (menos frecuente).
- **sino** («no quiero té, sino café») y **si no** («si no vienes, me enfado»).
- **aún** (todavía): «Aún no ha llegado». **aun** (incluso): «Aun así, salimos».
- **hay**, **ahí** y **ay**: verbo haber, lugar y exclamación.

## Letras problemáticas
- **b / v**: no se distinguen al hablar, así que memoriza familias de palabras (bello, belleza; vello). Antes de p y b se escribe m (imposible, embarcar).
- **h**: es muda. Aparece en hacer, hospital, humano.
- **g / j** y **ll / y**: practica con tarjetas y listas.
- **mayúsculas**: nombres propios y comienzo de oración; los días y meses van en minúscula.

## Cómo ampliar el vocabulario
- **Familias de palabras**: zapato, zapatero, zapatería, zapatilla. Aprende una raíz y reconocerás muchas.
- **Prefijos y sufijos**: des- (negación: desconfiar), in-/im- (imposible), re- (repetición).
- **Sinónimos y antónimos**: veloz es sinónimo de rápido.
- **Connotación**: dos palabras pueden referirse a lo mismo con distinto matiz. «Delgado» es neutral; «esquelético» es negativo.
- **Registro**: elige palabras adecuadas a la situación (trabajar frente a currar en un texto formal).
- **Precisión**: evita palabras comodín como «cosa» o «hacer»; escoge sustantivos y verbos concretos («un bolígrafo», «construir»).
- **Contexto**: para deducir un significado, mira las palabras vecinas. En «la fama de ese cantante fue efímera», «efímera» significa de corta duración.

## Cómo se evalúa
Las preguntas piden elegir la forma correcta, localizar errores en un texto breve o decidir qué palabra encaja mejor por significado, matiz o registro. En tus textos, se valora un vocabulario variado y preciso, con pocos errores ortográficos.

## Errores frecuentes
- Confundir «porque», «por qué» y «porqué».
- Omitir tildes en palabras como «canción».
- Escribir «haber» en lugar de «a ver».
- Repetir las mismas palabras de siempre.

Exam tip: durante la revisión final, haz una pasada solo para buscar tildes, h, b/v y las parejas confusas; aprende de tus propios errores anotándolos en una lista personal.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;