-- Part 3 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Prose and Fiction > Narrative Voice
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Prose and Fiction$mq$, 5, 3 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Narrative Voice$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Prose and Fiction$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Narrative Voice$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué es el narrador de un relato?$mq$, $mq$["La voz que cuenta la historia","El autor real del libro","El personaje principal siempre","El editor"]$mq$, 0, $mq$El narrador es una voz creada por el autor para contar los hechos; no siempre coincide con el autor.$mq$, $mq$easy$mq$),
($mq$¿Qué narrador usa «yo» y participa en la historia?$mq$, $mq$["Narrador en tercera persona omnisciente","Narrador en segunda persona","Narrador objetivo","Narrador en primera persona"]$mq$, 3, $mq$El narrador en primera persona cuenta desde dentro de la historia: «Yo abrí la puerta».$mq$, $mq$easy$mq$),
($mq$¿Qué sabe un narrador omnisciente?$mq$, $mq$["Solo lo que ve desde fuera","Solo lo que piensa el protagonista","Los pensamientos y sentimientos de todos los personajes","Nada sobre el futuro"]$mq$, 2, $mq$Omnisciente significa «que lo sabe todo»: accede a la mente de cualquier personaje.$mq$, $mq$easy$mq$),
($mq$¿Qué es el punto de vista?$mq$, $mq$["El título de la obra","La perspectiva desde la que se cuenta la historia","La rima de un texto","El número de capítulos"]$mq$, 1, $mq$El punto de vista decide quién cuenta, qué sabe y qué muestra al lector.$mq$, $mq$easy$mq$),
($mq$¿Qué pronombre es típico del narrador en tercera persona?$mq$, $mq$["Él o ella","Yo","Nosotros","Tú"]$mq$, 0, $mq$Cuenta los hechos como ajenos: «Ella abrió la puerta».$mq$, $mq$easy$mq$),
($mq$Extracto inventado: «Yo sabía que Daniel mentía, pero no me atreví a decírselo.» ¿Qué narrador y qué limitación aparecen?$mq$, $mq$["Tercera persona omnisciente; conoce todo","Segunda persona; habla al lector","Narrador objetivo; no interpreta","Primera persona; solo conoce sus propios pensamientos y sospechas"]$mq$, 3, $mq$El «yo» limita el conocimiento: sabe lo que piensa él, y de Daniel solo lo que observa o sospecha.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Marina cruzó el patio. Pensaba en su madre; Andrés, desde el banco, deseaba que lo mirara.» ¿Qué narrador es?$mq$, $mq$["Primera persona protagonista","Narrador testigo","Tercera persona omnisciente","Segunda persona"]$mq$, 2, $mq$Accede a los pensamientos de dos personajes distintos: es omnisciente.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Entró en la sala. Nadie habló. La taza tembló sobre el plato.» ¿Qué rasgo se aprecia?$mq$, $mq$["Narración omnisciente con análisis psicológico","Narración objetiva: describe hechos sin acceder a pensamientos","Narración en primera persona","Monólogo interior"]$mq$, 1, $mq$Solo se muestran acciones observables; no hay acceso a pensamientos.$mq$, $mq$medium$mq$),
($mq$¿Qué es un narrador poco fiable?$mq$, $mq$["Un narrador cuyo relato el lector no puede aceptar sin cuestionarlo","Un narrador que habla poco","Un narrador siempre omnisciente","Un narrador sin nombre"]$mq$, 0, $mq$Por ignorancia, prejuicio o intereses, puede distorsionar los hechos.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Yo jamás he roto nada en mi vida. Si el jarrón está roto, fue el viento.» ¿Qué sospecha se puede plantear?$mq$, $mq$["Que el jarrón es de oro","Que el narrador es omnisciente","Que es una descripción neutral","Que el narrador oculta o falsea la verdad"]$mq$, 3, $mq$La insistencia en su inocencia y la excusa improbable sugieren falta de fiabilidad.$mq$, $mq$medium$mq$),
($mq$¿Qué efecto tiene una narración en primera persona sobre el lector?$mq$, $mq$["Crea siempre distancia","Da acceso a todos los pensamientos","Genera cercanía, pero ofrece una visión parcial","Hace imposible la emoción"]$mq$, 2, $mq$Al hablar un personaje, el lector se identifica con él, pero conoce solo su versión.$mq$, $mq$medium$mq$),
($mq$En un relato, el narrador cambia entre capítulos: Ana, Luis, Ana. ¿Qué técnica se usa?$mq$, $mq$["Un único narrador omnisciente","Narración con varios puntos de vista","Un narrador objetivo","Un diálogo teatral"]$mq$, 1, $mq$Alternar voces muestra los mismos hechos desde perspectivas diferentes.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Tú entras en la casa, tú dejas las llaves, tú no sabes que alguien te observa.» ¿Qué narrador es?$mq$, $mq$["Segunda persona","Primera persona","Tercera persona objetiva","Omnisciente en pasado"]$mq$, 0, $mq$Se dirige al protagonista con «tú», técnica menos frecuente que crea implicación.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Yo creía que el viejo me odiaba; después comprendí que solo me temía.» ¿Qué recurso narrativo revela esta frase?$mq$, $mq$["Un narrador objetivo","Un narrador omnisciente en tercera persona","Una descripción de paisaje","Un narrador adulto que reinterpreta su experiencia pasada"]$mq$, 3, $mq$«Creía» frente a «después comprendí» muestra distancia entre el yo que vivió y el yo que cuenta.$mq$, $mq$hard$mq$),
($mq$Extracto inventado: «El cartero, que jamás hablaba mal de nadie, aseguraba que la señora Pons era un ángel.» ¿Qué análisis es más completo?$mq$, $mq$["Es una narración en segunda persona","El narrador comparte plenamente la opinión","El narrador transmite el testimonio con distancia, lo que invita a dudar de la imagen de «ángel»","Es una descripción objetiva sin matices"]$mq$, 2, $mq$«Aseguraba» y la información sobre el cartero introducen un filtro; el lector valora la opinión.$mq$, $mq$hard$mq$),
($mq$Dos versiones del mismo hecho: A (narrador omnisciente) «Sofía temía el examen; su madre, ocupada, ni lo recordaba»; B (primera persona de Sofía) «Mi madre ni se acordaba de mi examen». ¿Qué diferencia es correcta?$mq$, $mq$["B sabe todo lo que piensa la madre","A ofrece conocimiento de ambos personajes; B solo la percepción de Sofía","A es una narración objetiva","No hay diferencia"]$mq$, 1, $mq$El narrador omnisciente accede a ambas mentes; en B, Sofía solo interpreta lo que ve.$mq$, $mq$hard$mq$),
($mq$¿Por qué un autor elegiría un niño como narrador en primera persona de una guerra?$mq$, $mq$["Para ofrecer una visión ingenua que contrasta con la gravedad de los hechos","Para dar un análisis político completo","Para evitar que el lector sienta empatía","Para usar un vocabulario técnico"]$mq$, 0, $mq$La inocencia del narrador crea contraste y, con frecuencia, ironía dramática.$mq$, $mq$hard$mq$),
($mq$Un examen pregunta: «Explica cómo el punto de vista influye en la comprensión del conflicto.» ¿Qué enfoque es más sólido?$mq$, $mq$["Resumir la trama","Contar la vida del autor","Enumerar los personajes","Identificar el narrador, explicar qué sabe y qué calla, y valorar el efecto en el lector"]$mq$, 3, $mq$La respuesta debe relacionar tipo de narrador, límites de su conocimiento y efecto.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Narrative Voice$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Narrador$mq$, $mq$Voz creada por el autor para contar la historia. No debe confundirse con el autor real.$mq$),
($mq$Narrador en primera persona$mq$, $mq$Cuenta con «yo» y participa en la historia. Aporta cercanía y emoción, pero su visión es parcial.$mq$),
($mq$Narrador omnisciente$mq$, $mq$En tercera persona, conoce pensamientos y sentimientos de todos los personajes, y también el pasado y el futuro.$mq$),
($mq$Narrador objetivo$mq$, $mq$Describe solo lo que se ve y se oye, sin acceder a los pensamientos de los personajes.$mq$),
($mq$Narrador en segunda persona$mq$, $mq$Se dirige a un «tú», personaje o lector. Es poco frecuente y crea implicación o tensión.$mq$),
($mq$Narrador poco fiable$mq$, $mq$Narrador cuyo relato no se puede aceptar sin dudas por ingenuidad, prejuicio, miedo o interés. Pistas: contradicciones y justificaciones.$mq$),
($mq$Focalización$mq$, $mq$Filtro de conocimiento del relato: qué sabe el narrador y desde dónde observa los hechos.$mq$),
($mq$Distancia temporal del narrador$mq$, $mq$Diferencia entre cuando suceden los hechos y cuando se narran. Permite reinterpretar el pasado.$mq$),
($mq$Fórmula de análisis de la voz narrativa$mq$, $mq$Identificar persona y conocimiento + citar pistas + explicar límites y ventajas + valorar el efecto en el lector.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Narrative Voice$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Lo esencial
Todo relato es contado por alguien: el **narrador**. No hay que confundirlo con el **autor**, que es la persona real que escribe. El narrador es una voz creada por el autor y decide qué sabemos, qué ocultamos y cómo interpretamos los hechos. Analizar la **voz narrativa** y el **punto de vista** es una de las habilidades más evaluadas en Lengua y Literatura.

## Tipos de narrador
- **Primera persona (yo):** el narrador participa en la historia. Puede ser protagonista o testigo. Da cercanía y emoción, pero su visión es parcial. Ejemplo inventado: «Yo sabía que Daniel mentía, pero no me atreví a decírselo.»
- **Segunda persona (tú):** se dirige al personaje o al lector. Es poco frecuente y crea implicación o tensión.
- **Tercera persona omnisciente:** conoce los pensamientos de todos los personajes, el pasado y el futuro. Ofrece una visión amplia.
- **Tercera persona limitada:** cuenta desde fuera, pero solo accede a la mente de un personaje.
- **Narrador objetivo o cámara:** describe lo que se ve y se oye, sin entrar en las mentes. Ejemplo: «Entró en la sala. Nadie habló. La taza tembló sobre el plato.»

## Punto de vista y focalización
La **focalización** es el filtro de conocimiento: qué sabe el narrador y desde dónde mira. Un narrador en primera persona solo puede saber lo que vive, lo que le cuentan o lo que sospecha. Un narrador omnisciente puede saltar de mente en mente. Un cambio de punto de vista, como alternar capítulos de Ana y de Luis, permite mostrar un mismo hecho desde ángulos opuestos.

## El narrador poco fiable
A veces el narrador distorsiona los hechos por ingenuidad, prejuicio, miedo o interés. Se llama **narrador poco fiable**. Pistas para detectarlo:
- Se justifica con insistencia: «Yo jamás he roto nada.»
- Se contradice o cambia de versión.
- Otros personajes lo desmienten.
- Hay un contraste entre lo que dice y lo que muestra la escena.
Cuando ocurre, el lector debe leer con sospecha y buscar las pruebas del texto.

## Distancia temporal y tono
Un narrador puede contar los hechos mientras suceden o mucho después. En «Yo creía que el viejo me odiaba; después comprendí que solo me temía», el narrador adulto reinterpreta lo que sentía de niño. Esta distancia añade reflexión, nostalgia o ironía.

## Cómo analizarlo
1. **Identifica** la persona gramatical (yo, tú, él) y el tipo de conocimiento.
2. **Cita** pronombres, verbos y expresiones que lo prueben.
3. **Explica** qué ventajas y límites tiene esa perspectiva.
4. **Valora** el efecto en el lector: ¿genera empatía, intriga, ironía, sospecha?

## Errores frecuentes
- **Confundir narrador y autor.** Aunque el relato diga «yo», no necesariamente habla el escritor.
- **Decir «narrador en tercera persona» sin precisar.** Aclara si es omnisciente, limitado u objetivo.
- **Resumir la trama.** Se pide analizar la voz, no repetir el argumento.
- **Olvidar el efecto.** Nombrar al narrador sin explicar su influencia da pocos puntos.
- **Aceptar siempre al narrador.** Pregunta si lo que cuenta es creíble.

## Cómo se evalúa
En la evaluación en pantalla se presenta un extracto narrativo breve y se pregunta qué tipo de narrador aparece, qué sabe y qué efecto tiene. Las preguntas más difíciles piden comparar cómo cambiaría el pasaje si lo contara otro narrador o explicar por qué un narrador puede no ser fiable.

Exam tip: identifica la persona y el conocimiento del narrador con una cita, y concluye siempre con el efecto: qué gana y qué pierde el lector con esa perspectiva.$mq$ from st;

-- Prose and Fiction > Character and Setting
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Prose and Fiction$mq$, 5, 3 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Character and Setting$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Prose and Fiction$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Character and Setting$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué es la caracterización?$mq$, $mq$["El modo en que el autor presenta a un personaje","La rima de un poema","El número de capítulos","La estructura de una carta"]$mq$, 0, $mq$Incluye lo que el personaje dice, hace, piensa, cómo se describe y qué dicen los demás de él.$mq$, $mq$easy$mq$),
($mq$¿Qué es el protagonista?$mq$, $mq$["El narrador siempre","El personaje que aparece una vez","El autor","El personaje principal de la historia"]$mq$, 3, $mq$El protagonista es el centro de la acción.$mq$, $mq$easy$mq$),
($mq$¿Qué es el antagonista?$mq$, $mq$["El mejor amigo del protagonista","El narrador","El personaje u obstáculo que se opone al protagonista","El autor"]$mq$, 2, $mq$Crea el conflicto principal al oponerse a los objetivos del protagonista.$mq$, $mq$easy$mq$),
($mq$¿Qué es el ambiente o escenario de un relato?$mq$, $mq$["La opinión del narrador","El lugar y el tiempo en que ocurre la acción","El título de la obra","La rima de un verso"]$mq$, 1, $mq$El escenario incluye lugar, época y atmósfera.$mq$, $mq$easy$mq$),
($mq$¿Qué muestra una descripción física como «ojos hundidos y manos temblorosas»?$mq$, $mq$["Una caracterización directa que sugiere cansancio o nervios","Una rima","Un diálogo","Una metáfora de un paisaje"]$mq$, 0, $mq$El aspecto físico puede sugerir estados internos.$mq$, $mq$easy$mq$),
($mq$Extracto inventado: «Julia ordenó tres veces los lápices antes de empezar.» ¿Qué sugiere sobre su carácter?$mq$, $mq$["Que es perezosa","Que es generosa","Que odia el colegio","Que es meticulosa o ansiosa por el control"]$mq$, 3, $mq$La repetición de un gesto de orden sugiere perfeccionismo o nervios.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «El pueblo olía a pan y a tierra mojada; las persianas verdes se abrían despacio.» ¿Qué atmósfera crea el ambiente?$mq$, $mq$["Una atmósfera hostil","Una atmósfera futurista","Una atmósfera tranquila y acogedora","Una atmósfera de pánico"]$mq$, 2, $mq$Los olores familiares y los gestos pausados transmiten calma.$mq$, $mq$medium$mq$),
($mq$¿Qué diferencia hay entre caracterización directa e indirecta?$mq$, $mq$["Directa: se deduce; indirecta: se dice","Directa: el narrador dice cómo es; indirecta: se deduce de acciones, palabras y reacciones","No hay diferencia","Directa es solo física"]$mq$, 1, $mq$«Era generoso» es directa; verlo repartir su comida es indirecta.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «—No tengo miedo —dijo Pablo, y escondió las manos en los bolsillos.» ¿Qué revela la acción?$mq$, $mq$["Que su valentía es aparente: oculta nerviosismo","Que no tiene frío","Que es completamente sereno","Que desea saludar"]$mq$, 0, $mq$Las manos escondidas contradicen sus palabras y dejan ver su miedo.$mq$, $mq$medium$mq$),
($mq$¿Qué es un personaje redondo?$mq$, $mq$["Un personaje que siempre es igual","Un personaje sin nombre","Un personaje animal","Un personaje complejo, con cualidades contradictorias que puede cambiar"]$mq$, 3, $mq$Los personajes redondos evolucionan y sorprenden; los planos son simples y previsibles.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «La casa llevaba años cerrada; el polvo cubría los muebles y las cortinas colgaban como telas de araña.» ¿Qué función cumple el escenario?$mq$, $mq$["Muestra alegría","Indica prisa","Crea una atmósfera de abandono y misterio","Explica un proceso científico"]$mq$, 2, $mq$Los detalles de polvo y cortinas evocan abandono y suspense.$mq$, $mq$medium$mq$),
($mq$¿Qué efecto tiene mostrar un cambio entre el personaje al inicio y al final?$mq$, $mq$["Provoca una rima","Refleja su evolución y refuerza el tema","Elimina el conflicto","Reduce el interés"]$mq$, 1, $mq$El desarrollo del personaje suele expresar un mensaje o aprendizaje.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Entró en el comedor y la conversación se apagó como una vela.» ¿Qué se infiere de su relación con el grupo?$mq$, $mq$["Su presencia incomoda o impone respeto","Es el invitado de honor y todos aplauden","Nadie lo ve","Se trata de un amigo íntimo"]$mq$, 0, $mq$La conversación se apaga al entrar él: genera tensión.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «El día era espléndido, y Clara, en su vestido negro, no levantaba la vista del suelo.» ¿Qué efecto crea el contraste?$mq$, $mq$["Muestra una escena festiva","Indica que Clara es despistada","Transmite un tono humorístico","Resalta su dolor o duelo frente a la alegría del exterior"]$mq$, 3, $mq$El día luminoso y el vestido negro contrastan y subrayan su tristeza.$mq$, $mq$hard$mq$),
($mq$Un personaje cuenta a un amigo: «Yo nunca pido ayuda», pero dos escenas después llama a su hermana a medianoche. ¿Qué análisis de caracterización es más sólido?$mq$, $mq$["Es un narrador omnisciente","No hay conflicto","Se revela una contradicción entre su imagen orgullosa y su necesidad real","Es un personaje plano"]$mq$, 2, $mq$El contraste entre palabra y acción muestra complejidad y sugiere desarrollo.$mq$, $mq$hard$mq$),
($mq$Extracto inventado: «En la plaza estrecha, los balcones casi se tocaban y el sol nunca llegaba al suelo.» Una alumna dice: «El escenario es una plaza.» ¿Qué le falta para un análisis sólido?$mq$, $mq$["Contar la historia de la plaza","Interpretar qué atmósfera crean los detalles (opresión o encierro) y cómo afecta a los personajes","Cambiar la plaza por una calle","Eliminar los detalles"]$mq$, 1, $mq$Describir no basta: hay que explicar el efecto y la función del espacio.$mq$, $mq$hard$mq$),
($mq$En un relato, un personaje bondadoso pasa de vivir en una ciudad ruidosa a una aldea silenciosa y se vuelve más reflexivo. ¿Qué relación literaria se observa?$mq$, $mq$["El espacio influye en la transformación del personaje","El espacio no tiene relación con el personaje","El personaje es plano","El narrador es objetivo"]$mq$, 0, $mq$Espacio y personaje se condicionan: el nuevo entorno favorece el cambio.$mq$, $mq$hard$mq$),
($mq$¿Cuál es la mejor justificación para afirmar que un antagonista es complejo?$mq$, $mq$["Aparece muy poco","Es siempre malvado","No habla nunca","Tiene motivaciones comprensibles y rasgos que provocan simpatía y rechazo"]$mq$, 3, $mq$Un antagonista complejo no es solo «malo»: sus razones permiten al lector entenderlo.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Character and Setting$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Caracterización$mq$, $mq$Conjunto de técnicas con las que el autor presenta a un personaje: aspecto, acciones, palabras, pensamientos y opiniones de otros.$mq$),
($mq$Caracterización directa e indirecta$mq$, $mq$Directa: el narrador afirma cómo es el personaje. Indirecta: el lector lo deduce de lo que hace, dice o piensa.$mq$),
($mq$Protagonista y antagonista$mq$, $mq$Protagonista: personaje central. Antagonista: quien o lo que se opone a sus objetivos; puede ser una persona, la sociedad o un conflicto interno.$mq$),
($mq$Personaje plano y redondo$mq$, $mq$Plano: simple y previsible. Redondo: complejo, con contradicciones y capaz de cambiar.$mq$),
($mq$Ambiente o escenario$mq$, $mq$Lugar, época y atmósfera donde ocurre la acción. Crea atmósfera y puede influir en los personajes.$mq$),
($mq$Contraste entre ambiente y emoción$mq$, $mq$Un entorno que contradice los sentimientos, como un día soleado durante un funeral, intensifica la emoción o crea ironía.$mq$),
($mq$Evolución del personaje$mq$, $mq$Cambio entre el comienzo y el final del relato. Suele expresar un tema como la madurez o el perdón.$mq$),
($mq$Contradicción entre palabra y acción$mq$, $mq$Cuando lo que dice el personaje no coincide con lo que hace. Revela su complejidad o sus emociones ocultas.$mq$),
($mq$Cadena de análisis$mq$, $mq$Cita + lo que revela + por qué importa en la historia. Sirve para personajes, escenarios y atmósfera.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Character and Setting$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Lo esencial
Una historia necesita **personajes** que actúan y un **escenario** donde actúan. El análisis literario consiste en explicar cómo los conocemos, qué nos revelan sus decisiones y qué función cumple el entorno. En el examen no basta describir: hay que interpretar y relacionar con el sentido del texto.

## Los personajes
- **Protagonista:** el personaje central; su objetivo mueve la historia.
- **Antagonista:** quien o lo que se opone al protagonista; puede ser una persona, un grupo, la sociedad o incluso un conflicto interno.
- **Personajes secundarios:** acompañan, ayudan o complican la acción.
- **Personaje plano:** simple, previsible, con pocos rasgos.
- **Personaje redondo:** complejo, con contradicciones y capacidad de cambiar.

## Cómo se construye un personaje (caracterización)
El autor muestra cómo es un personaje de varias maneras:
- **Descripción física:** el aspecto sugiere carácter, edad o estado. «Ojos hundidos y manos temblorosas» sugiere cansancio o nervios.
- **Acciones y gestos:** lo que hace dice más que lo que declara. «Julia ordenó tres veces los lápices» sugiere meticulosidad.
- **Palabras:** lo que dice, cómo lo dice y lo que calla.
- **Pensamientos:** cuando el narrador permite acceder a ellos.
- **Opinión de otros:** lo que dicen o cómo reaccionan los demás.
- **Caracterización directa:** el narrador lo afirma («era generoso»). **Indirecta:** el lector lo deduce de sus acciones.
Un análisis sólido señala contradicciones. Si alguien dice «no tengo miedo» mientras esconde las manos temblorosas, la acción desmiente la palabra.

## El desarrollo del personaje
Los personajes importantes cambian o se revelan. Compara cómo es al principio y al final, y busca el momento que provoca el cambio. Ese cambio suele expresar el tema: la valentía, el perdón, la madurez, etc.

## El escenario o ambiente
Incluye **lugar**, **época** y **atmósfera**. Sirve para:
- Crear atmósfera: casa abandonada, calle luminosa, bosque oscuro.
- Reflejar o contrastar con las emociones: un día espléndido durante un funeral genera contraste.
- Influir en los personajes: un lugar opresivo puede empujar al conflicto.
- Situar socialmente la historia: estilo de vida, costumbres, clase social.
Ejemplo inventado: «En la plaza estrecha, los balcones casi se tocaban y el sol nunca llegaba al suelo.» Los detalles sugieren encierro y opresión.

## Cómo analizarlo
1. **Selecciona** una cita clave de rasgo o escenario.
2. **Interpreta** lo que revela: carácter, sentimientos, atmósfera.
3. **Conecta** con el conflicto o el tema.
4. **Explica** el efecto en el lector: simpatía, tensión, rechazo, curiosidad.

## Errores frecuentes
- **Resumir en vez de analizar.** No cuentes la trama; explica qué muestra la cita.
- **Usar adjetivos vagos.** «Bueno» o «malo» dicen poco; prefiere «generoso», «obstinado», «inseguro».
- **Separar personaje y espacio.** El entorno suele influir en las decisiones.
- **Aceptar la declaración sin pruebas.** Busca acciones que la confirmen o la contradigan.
- **Olvidar la evolución.** Compara el principio y el final.

## Cómo se evalúa
En la evaluación en pantalla aparece un extracto con un personaje en una situación concreta y se pregunta qué se sugiere de él, qué técnicas usa el autor o cómo contribuye el espacio a la atmósfera. En las preguntas largas se piden dos o tres pruebas textuales con interpretación.

Exam tip: para cada personaje o lugar, usa la cadena «cita, lo que revela, por qué importa en la historia»; las respuestas con los tres pasos obtienen los niveles más altos.$mq$ from st;

-- Prose and Fiction > Themes and Symbols
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Prose and Fiction$mq$, 5, 3 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Themes and Symbols$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Prose and Fiction$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Themes and Symbols$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué es el tema de una obra?$mq$, $mq$["La idea central sobre la que reflexiona","La trama resumida","El nombre del protagonista","La rima del título"]$mq$, 0, $mq$El tema es una idea general (amistad, injusticia, libertad), no un resumen de lo que ocurre.$mq$, $mq$easy$mq$),
($mq$¿Qué es un símbolo?$mq$, $mq$["Una palabra sin significado","Una rima","Un adverbio","Un objeto o imagen que representa una idea más amplia"]$mq$, 3, $mq$Por ejemplo, una paloma puede simbolizar la paz.$mq$, $mq$easy$mq$),
($mq$¿Qué suele simbolizar un camino en la literatura?$mq$, $mq$["La comida","El aburrimiento","El viaje de la vida o una decisión importante","La velocidad de un coche"]$mq$, 2, $mq$Los caminos representan etapas, elecciones y destinos.$mq$, $mq$easy$mq$),
($mq$¿Qué es un motivo?$mq$, $mq$["Un error del autor","Un elemento que se repite en la obra y refuerza una idea","El final de la historia","El título de un capítulo"]$mq$, 1, $mq$Un motivo recurrente (el agua, un reloj) puede reforzar el tema.$mq$, $mq$easy$mq$),
($mq$¿Cuál de estas frases expresa un tema, no un argumento?$mq$, $mq$["La amistad exige sacrificio","Ana pierde las llaves","Luis llega tarde a clase","Dos amigos viajan a Sevilla"]$mq$, 0, $mq$El tema es una idea general sobre la vida; las otras son hechos concretos.$mq$, $mq$easy$mq$),
($mq$Extracto inventado: «Cada vez que Inés mentía, el reloj de la sala se detenía.» ¿Qué puede simbolizar el reloj?$mq$, $mq$["La riqueza","El juego","La amistad","El peso de la verdad o el paso del tiempo"]$mq$, 3, $mq$El reloj detenido se vincula con la mentira, de modo que sugiere culpa o tiempo detenido.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Tras la tormenta, Marcos plantó un pequeño olivo en el jardín devastado.» ¿Qué simboliza el olivo?$mq$, $mq$["Derrota","Envidia","Esperanza y renovación","Aburrimiento"]$mq$, 2, $mq$Plantar tras la destrucción sugiere comenzar de nuevo; el olivo se asocia con la paz.$mq$, $mq$medium$mq$),
($mq$Un relato muestra a un niño que comparte siempre su bocadillo con un perro callejero, y al final el perro lo salva de un peligro. ¿Qué tema es más probable?$mq$, $mq$["La riqueza personal","La generosidad y su recompensa","La vergüenza","El miedo a las alturas"]$mq$, 1, $mq$La acción repetida y el desenlace refuerzan la idea de que la bondad es recompensada.$mq$, $mq$medium$mq$),
($mq$¿Por qué conviene formular un tema como frase completa?$mq$, $mq$["Porque muestra una idea sobre el tema, no solo un tema general","Porque es más corto","Porque la rima lo exige","Porque se evita citar"]$mq$, 0, $mq$«La amistad» es un tema; «La amistad verdadera se prueba en la dificultad» expresa una idea.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «El gato entró en la habitación oscura mientras la luz de la vela se apagaba.» ¿Qué simbolismo asociado a la oscuridad es probable?$mq$, $mq$["Alegría festiva","Riqueza","Salud","Peligro, ignorancia o miedo"]$mq$, 3, $mq$La oscuridad suele representar incertidumbre o amenaza.$mq$, $mq$medium$mq$),
($mq$En una novela, una puerta cerrada aparece en cada capítulo. ¿Qué función tiene?$mq$, $mq$["Es un error de edición","Es una rima interna","Es un motivo que representa un secreto o una barrera","Es una descripción gratuita"]$mq$, 2, $mq$La repetición convierte un objeto en motivo asociado a un significado.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «El viejo puente cruzaba el río que separaba las dos familias.» ¿Qué puede simbolizar el puente?$mq$, $mq$["La competencia deportiva","La posibilidad de reconciliación o de unión","El hambre","La juventud"]$mq$, 1, $mq$Un puente une dos orillas y sugiere reconciliación.$mq$, $mq$medium$mq$),
($mq$¿Cuál es la diferencia entre símbolo y metáfora?$mq$, $mq$["El símbolo representa una idea a lo largo de la obra; la metáfora identifica dos elementos en una expresión concreta","No hay diferencia","El símbolo es siempre un sonido","La metáfora solo aparece en teatro"]$mq$, 0, $mq$El símbolo es un objeto con valor recurrente; la metáfora opera en una imagen específica.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Aldara guardaba los zapatos de su padre junto a la puerta aunque hacía años que se había ido.» ¿Qué análisis es más completo?$mq$, $mq$["Los zapatos solo son de su padre","Los zapatos muestran su afición a la moda","Son un recurso sonoro","Los zapatos simbolizan la ausencia y la esperanza de su regreso; sugieren que no acepta la pérdida"]$mq$, 3, $mq$Mantener los zapatos preparados revela una espera simbólica y emocional.$mq$, $mq$hard$mq$),
($mq$Un cuento muestra a un rey que construye muros más altos, mientras sus ciudadanos se marchan. ¿Qué tema se refuerza?$mq$, $mq$["La generosidad","La amistad infantil","El aislamiento y el poder mal ejercido","La alegría del juego"]$mq$, 2, $mq$Los muros simbolizan el aislamiento; la huida de los ciudadanos muestra sus consecuencias.$mq$, $mq$hard$mq$),
($mq$Una alumna escribe: «El tema de la novela es una niña y un río.» ¿Qué corrección es necesaria?$mq$, $mq$["Debe resumir toda la trama","Debe formular una idea general, por ejemplo: la relación entre infancia y naturaleza como espacio de libertad","Debe omitir el río","Debe indicar la página"]$mq$, 1, $mq$Un tema es una idea abstracta con enfoque; no un elemento de la trama.$mq$, $mq$hard$mq$),
($mq$Extracto inventado: «La lluvia lavó las huellas del callejón; Esteban respiró aliviado.» ¿Qué lectura simbólica fundamenta mejor el alivio?$mq$, $mq$["La lluvia purifica y borra la culpa o las pruebas","La lluvia trae calor","La lluvia es ruido","La lluvia señala que es de día"]$mq$, 0, $mq$El agua suele simbolizar purificación; borrar huellas conecta con la culpa.$mq$, $mq$hard$mq$),
($mq$Un examen pide: «Discute cómo el autor desarrolla el tema de la memoria.» ¿Qué plan de respuesta es más sólido?$mq$, $mq$["Resumir la trama","Hablar de la vida del autor","Describir la portada","Definir el tema, seleccionar tres momentos y símbolos o motivos, y explicar cómo cada uno lo desarrolla"]$mq$, 3, $mq$El verbo «discute» exige argumentar con pruebas y mostrar cómo evoluciona la idea.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Themes and Symbols$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Tema$mq$, $mq$Idea central sobre la que reflexiona una obra. Se formula como una frase con enfoque, no como un resumen de la trama.$mq$),
($mq$Argumento frente a tema$mq$, $mq$El argumento cuenta qué ocurre; el tema es la idea general que la historia transmite sobre la vida.$mq$),
($mq$Símbolo$mq$, $mq$Objeto, lugar o imagen que representa una idea más amplia. Su significado depende del contexto de la obra.$mq$),
($mq$Motivo$mq$, $mq$Elemento que se repite en la obra y refuerza un tema o una emoción, como un reloj que se detiene.$mq$),
($mq$Símbolo del puente$mq$, $mq$Suele simbolizar la unión o la reconciliación entre personas, familias o mundos separados.$mq$),
($mq$Símbolo de la oscuridad$mq$, $mq$Suele representar miedo, peligro o ignorancia. El amanecer, en cambio, simboliza esperanza o renovación.$mq$),
($mq$Símbolo frente a metáfora$mq$, $mq$El símbolo mantiene un significado a lo largo de la obra; la metáfora identifica dos elementos en una expresión concreta.$mq$),
($mq$Cómo defender un tema$mq$, $mq$Con tres pruebas: una cita, un símbolo o motivo, y un cambio en un personaje, explicando cómo cada una lo desarrolla.$mq$),
($mq$Error al hablar del tema$mq$, $mq$Decir «el tema es el amor» es demasiado general. Hay que concretar qué dice la obra sobre el amor.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Themes and Symbols$mq$ and p.name = $mq$Prose and Fiction$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Lo esencial
Una historia cuenta qué ocurre, pero la literatura también dice algo sobre la vida. Esa idea profunda es el **tema**. Para sugerirla, los autores usan **símbolos** y **motivos** que dan significado más amplio a objetos, lugares o imágenes. Aprender a leerlos es clave para obtener niveles altos en el análisis.

## El tema
El tema es la idea central sobre la que reflexiona una obra. No es lo mismo que el **argumento** (qué sucede) ni que el **asunto** (de qué se habla). Compara:
- Argumento: «Dos amigos viajan a una isla y uno cae enfermo.»
- Asunto: «La amistad en una situación difícil.»
- Tema: «La amistad verdadera se prueba en la dificultad.»
Un buen tema se formula como una frase completa con un enfoque. Un mismo relato puede tener varios temas: la justicia, la libertad, la identidad, el paso a la edad adulta, la memoria, el miedo, la soledad, la familia, etc.

## Símbolos
Un **símbolo** es un objeto, personaje, lugar o imagen que representa una idea más amplia. Algunos significados comunes son:
- **Camino:** viaje de la vida, decisiones.
- **Puente:** unión, reconciliación.
- **Muro o puerta cerrada:** barrera, secreto, aislamiento.
- **Amanecer:** esperanza, renovación; **noche u oscuridad:** miedo, ignorancia, peligro.
- **Agua o lluvia:** purificación, cambio, vida.
- **Olivo o paloma:** paz.
Los significados dependen del contexto. No hay que memorizar una lista: hay que preguntarse qué sugiere el objeto en ese relato concreto.
Ejemplo inventado: «Aldara guardaba los zapatos de su padre junto a la puerta aunque hacía años que se había ido.» Los zapatos simbolizan la ausencia y la espera.

## Motivos
Un **motivo** es un elemento que se repite y refuerza un tema. Si un reloj se detiene cada vez que un personaje miente, ese reloj se convierte en motivo asociado a la culpa. Un símbolo puede aparecer una vez, pero un motivo aparece varias veces.

## Cómo se relacionan tema, símbolo y personaje
Los símbolos suelen aparecer en momentos clave y se vinculan con los personajes: sus cambios, sus decisiones y sus conflictos. Observa el principio y el final de la historia: ¿cómo se transforma el símbolo? Un olivo que se planta tras una tormenta puede marcar el paso de la pérdida a la esperanza.

## Cómo analizarlo
1. **Localiza** el objeto o imagen y cítalo.
2. **Propón** un significado razonable.
3. **Apóyalo** con el contexto (personajes, momento del relato).
4. **Conecta** con el tema y explica el efecto en el lector.

## Errores frecuentes
- **Resumir la trama en lugar de formular un tema.**
- **Dar un significado único y fijo.** Un símbolo admite varias lecturas, siempre que se justifiquen.
- **Olvidar la evidencia.** No basta decir «simboliza esperanza»; hay que mostrar por qué.
- **Confundir símbolo y metáfora.** El símbolo mantiene un significado en el conjunto de la obra; la metáfora actúa en una imagen concreta.
- **Quedarse en lo general.** Escribir «el tema es el amor» es débil; concreta qué se dice del amor.

## Cómo se evalúa
En la evaluación en pantalla aparece un pasaje breve con un objeto o imagen recurrente y se pregunta qué sugiere, cómo se relaciona con el conflicto o cómo desarrolla un tema. En preguntas amplias, se pide discutir la evolución de una idea en varios momentos del relato.

Exam tip: formula el tema como una frase completa y defiéndelo con tres pruebas: una cita, un símbolo o motivo, y un cambio en un personaje.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;