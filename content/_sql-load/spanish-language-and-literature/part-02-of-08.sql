-- Part 2 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Language Devices > Figurative Language
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Language Devices$mq$, 5, 2 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Figurative Language$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Language Devices$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Figurative Language$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué es una metáfora?$mq$, $mq$["Identificar una cosa con otra sin usar «como»","Comparar usando «como» o «parecido a»","Repetir sonidos al inicio de las palabras","Exagerar una cualidad"]$mq$, 0, $mq$La metáfora afirma que algo es otra cosa («sus ojos son dos luceros»); la comparación usa nexos como «como».$mq$, $mq$easy$mq$),
($mq$¿Qué recurso aparece en «Eres fuerte como un roble»?$mq$, $mq$["Metáfora","Hipérbole","Aliteración","Símil o comparación"]$mq$, 3, $mq$El nexo «como» introduce una comparación explícita entre dos elementos.$mq$, $mq$easy$mq$),
($mq$¿Qué es la personificación?$mq$, $mq$["Comparar dos personas","Exagerar un dato","Dar rasgos humanos a animales, objetos o ideas","Repetir una palabra"]$mq$, 2, $mq$Cuando «el viento susurra» o «la ciudad duerme», se atribuyen acciones humanas a elementos no humanos.$mq$, $mq$easy$mq$),
($mq$¿Qué recurso hay en «Te lo he dicho un millón de veces»?$mq$, $mq$["Ironía","Hipérbole","Metáfora","Onomatopeya"]$mq$, 1, $mq$Es una exageración evidente para enfatizar la repetición, no una cifra real.$mq$, $mq$easy$mq$),
($mq$¿Cuál es una onomatopeya?$mq$, $mq$["«Zas»","«Silencio»","«Hermoso»","«Triste»"]$mq$, 0, $mq$Las onomatopeyas imitan sonidos: «zas», «pum», «miau».$mq$, $mq$easy$mq$),
($mq$Extracto inventado: «La ciudad despertó bostezando entre las nubes grises.» ¿Qué recurso destaca?$mq$, $mq$["Hipérbole","Antítesis","Comparación","Personificación"]$mq$, 3, $mq$La ciudad realiza una acción humana: bosteza al despertar.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Sus manos eran dos pájaros nerviosos.» ¿Qué recurso se emplea y qué sugiere?$mq$, $mq$["Símil; sugiere calma","Hipérbole; sugiere gran tamaño","Metáfora; sugiere movimientos inquietos y rápidos","Ironía; sugiere humor"]$mq$, 2, $mq$Identifica las manos con pájaros sin nexo comparativo, y sugiere nerviosismo.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Era tan alto que tuvo que agacharse para entrar en el cielo.» ¿Qué recurso es y qué efecto tiene?$mq$, $mq$["Personificación; humaniza el cielo","Hipérbole; resalta la gran estatura de forma humorística","Símil; compara dos paisajes","Eufemismo; suaviza una realidad dura"]$mq$, 1, $mq$La exageración es evidente y busca un efecto cómico.$mq$, $mq$medium$mq$),
($mq$¿Qué diferencia hay entre «El tiempo es oro» y «El tiempo vale como el oro»?$mq$, $mq$["La primera es metáfora; la segunda, símil","La primera es símil; la segunda, metáfora","Ambas son personificaciones","Ninguna es un recurso"]$mq$, 0, $mq$La ausencia de «como» convierte la primera en metáfora; la segunda compara explícitamente.$mq$, $mq$medium$mq$),
($mq$¿Qué es la sinestesia?$mq$, $mq$["Atribuir cualidades humanas a objetos","Decir lo contrario de lo que se piensa","Repetir el principio de varias frases","Mezclar sensaciones de sentidos distintos"]$mq$, 3, $mq$En «una voz dulce» o «un color chillón» se mezclan oído/gusto o vista/oído.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Murió de risa.» ¿Cuál es la lectura correcta?$mq$, $mq$["Es literal: murió realmente","Es una onomatopeya","Es una hipérbole: se rio muchísimo, no murió","Es una pregunta retórica"]$mq$, 2, $mq$La expresión exagera la intensidad de la risa; no debe entenderse al pie de la letra.$mq$, $mq$medium$mq$),
($mq$Un autor escribe «el eco de su risa vivía en las paredes». ¿Qué efecto produce la personificación?$mq$, $mq$["Transmite datos técnicos","Hace la ausencia más presente y emotiva","Muestra una enumeración","Crea un ritmo de verso"]$mq$, 1, $mq$Atribuir vida al eco da la sensación de que el recuerdo persiste.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Los coches serpenteaban por la avenida.» ¿Qué se está diciendo figurativamente?$mq$, $mq$["Que los coches avanzaban formando curvas, como serpientes","Que los coches eran serpientes reales","Que había un zoo cerca","Que la avenida estaba vacía"]$mq$, 0, $mq$«Serpentear» es una metáfora verbal basada en el movimiento sinuoso de la serpiente.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «La noche nos tragó. Éramos pequeñas luces en su estómago oscuro.» ¿Qué análisis es más completo?$mq$, $mq$["Solo hay una onomatopeya","Es una enumeración que informa","Es un texto literal sin imágenes","Personificación y metáfora crean una sensación de amenaza e insignificancia"]$mq$, 3, $mq$La noche «traga» (personificación) y tiene «estómago» (metáfora): se transmite miedo y pequeñez.$mq$, $mq$hard$mq$),
($mq$¿Por qué un lector puede considerar que una metáfora está «muerta» (como «la pata de la mesa»)?$mq$, $mq$["Porque contiene un error ortográfico","Porque solo aparece en poesía","Porque se usa tanto que ya no se percibe como imagen","Porque siempre es una hipérbole"]$mq$, 2, $mq$Las metáforas lexicalizadas pierden su efecto de sorpresa y pasan al uso común.$mq$, $mq$hard$mq$),
($mq$Extracto inventado: «El silencio gritaba en la biblioteca vacía.» ¿Qué figura combina contradicción y personificación?$mq$, $mq$["Hipérbole pura","Oxímoron con personificación","Aliteración","Metonimia"]$mq$, 1, $mq$«Silencio» y «gritar» se contradicen (oxímoron), y además el silencio actúa como una persona.$mq$, $mq$hard$mq$),
($mq$Una alumna analiza «Las promesas del político eran globos de colores» y escribe: «Es un símil porque compara». ¿Qué corrección es necesaria?$mq$, $mq$["Es una metáfora, porque no aparece «como»; además sugiere promesas bonitas pero vacías","Es un símil porque hay colores","Es una hipérbole porque hay globos","Es literal porque hay globos"]$mq$, 0, $mq$Sin nexo comparativo se trata de metáfora; los globos sugieren fragilidad y aire.$mq$, $mq$hard$mq$),
($mq$Extracto inventado: «Nuestro equipo no tuvo la mejor tarde» tras perder 9-0. ¿Qué figura se usa y con qué efecto?$mq$, $mq$["Hipérbole que lo agrava","Onomatopeya que imita un grito","Antítesis entre dos goles","Eufemismo o atenuación irónica, que suaviza el fracaso"]$mq$, 3, $mq$Se minimiza una derrota evidente; puede ser humorístico o evasivo.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Figurative Language$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Metáfora$mq$, $mq$Identifica una cosa con otra sin usar nexo comparativo. Ejemplo: «sus manos eran dos pájaros nerviosos».$mq$),
($mq$Símil o comparación$mq$, $mq$Relaciona dos elementos con un nexo como «como» o «igual que». Ejemplo: «pesaba como un saco de harina».$mq$),
($mq$Personificación$mq$, $mq$Atribuir acciones o rasgos humanos a animales, cosas o ideas: «la ciudad bostezaba».$mq$),
($mq$Hipérbole$mq$, $mq$Exageración evidente para enfatizar algo: «te lo he dicho mil veces». No pretende engañar.$mq$),
($mq$Oxímoron$mq$, $mq$Unión de dos términos contradictorios en una misma expresión, como «silencio ensordecedor».$mq$),
($mq$Sinestesia$mq$, $mq$Mezcla de sensaciones de sentidos distintos: «voz dulce» (oído y gusto), «color chillón» (vista y oído).$mq$),
($mq$Eufemismo$mq$, $mq$Expresión suave para aludir a algo duro o desagradable: «nos dejó» en vez de «murió».$mq$),
($mq$Fórmula de análisis de un recurso$mq$, $mq$Identificar (recurso y cita) + interpretar (significado) + valorar (efecto en el lector, tono o tema).$mq$),
($mq$Metáfora muerta$mq$, $mq$Metáfora tan usada que ya no se percibe como imagen, como «la pata de la mesa» o «el ojo de la cerradura».$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Figurative Language$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Lo esencial
El lenguaje **figurado** se aparta del significado literal para crear imágenes, emociones y efectos. Los autores lo usan en poesía, prosa, publicidad y discursos. Para analizarlo no basta con nombrar el recurso: hay que explicar qué significa y qué efecto produce en el lector. Esa secuencia, **identificar, interpretar, valorar**, es la base de las respuestas de nivel alto.

## Los recursos principales
- **Metáfora:** identifica una cosa con otra sin nexo. «Sus manos eran dos pájaros nerviosos» sugiere movimientos inquietos.
- **Símil o comparación:** compara con «como», «igual que» o «parecido a». «Los años pesaban como sacos de harina.»
- **Personificación:** atribuye rasgos humanos a lo que no es humano. «La ciudad despertó bostezando.»
- **Hipérbole:** exageración evidente. «Te lo he dicho mil veces.»
- **Antítesis:** contraste de ideas opuestas. «Era de día, pero reinaba la noche.»
- **Oxímoron:** unión de dos términos contradictorios. «Un silencio ensordecedor.»
- **Sinestesia:** mezcla de sensaciones. «Una voz dulce», «un color estridente».
- **Onomatopeya:** palabra que imita un sonido. «Plas», «pum».
- **Eufemismo:** expresión suave para aludir a algo duro. «Nos dejó» por «murió».
- **Ironía:** decir lo contrario de lo que se piensa.

## Cómo analizarlo
1. **Identifica** el recurso y cita las palabras exactas.
2. **Interpreta** su significado: ¿qué dos cosas se relacionan? ¿Qué cualidad se transmite?
3. **Valora** el efecto: ¿qué emoción o idea refuerza en el lector, y cómo contribuye al tono o al tema?
Ejemplo inventado: «La noche nos tragó.» Identificación: personificación. Interpretación: la noche actúa como un animal que devora. Efecto: crea una sensación de amenaza y de insignificancia, adecuada al miedo que sienten los personajes.

## Diferencias que suelen preguntarse
- **Metáfora o símil:** si hay «como», es símil; si no, es metáfora.
- **Metáfora o personificación:** la personificación exige darle rasgos humanos a algo no humano; la metáfora puede relacionar cosas de cualquier tipo.
- **Hipérbole o mentira:** la hipérbole no pretende engañar; el lector sabe que es una exageración.
- **Sentido literal o figurado:** «Murió de risa» no significa que alguien falleciera. Pregúntate si el sentido literal tiene lógica en el contexto.

## Errores frecuentes
- **Etiquetar sin explicar.** Decir «hay una metáfora» sin interpretar vale poco.
- **Repetir la cita como explicación.** Parafrasea con tus palabras.
- **Buscar recursos en cada línea.** Es mejor analizar con profundidad dos o tres.
- **Olvidar el contexto.** El mismo recurso puede ser humorístico en un cuento y trágico en un poema.
- **Considerar literal lo figurado.** Si «los coches serpenteaban», no hay serpientes.

## Metáforas muertas
Muchas expresiones cotidianas fueron metáforas y hoy ya no se perciben como tales: «la pata de la mesa» o «el ojo de la cerradura». Los autores suelen buscar imágenes nuevas y sorprendentes, que obligan al lector a imaginar.

## Cómo se evalúa
En la evaluación en pantalla suele aparecer un fragmento breve, con frases como «¿Qué efecto tiene la imagen de...?» o «Analiza cómo el autor usa el lenguaje figurado para crear...». Las respuestas con mejor nivel citan palabras exactas, interpretan la imagen y la conectan con el tema, el tono o el efecto en el lector.

Exam tip: usa la fórmula «El autor utiliza [recurso] en “[cita]”, lo que sugiere [significado] y hace que el lector sienta [efecto]».$mq$ from st;

-- Language Devices > Sound and Rhythm
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Language Devices$mq$, 5, 2 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Sound and Rhythm$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Language Devices$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Sound and Rhythm$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué es la aliteración?$mq$, $mq$["Repetición de sonidos consonánticos parecidos en palabras cercanas","Repetición de una idea al principio de cada verso","Comparación entre dos ideas","Exageración de una cualidad"]$mq$, 0, $mq$La aliteración repite sonidos para crear musicalidad o imitar un ruido.$mq$, $mq$easy$mq$),
($mq$¿Qué es la rima consonante?$mq$, $mq$["Solo coinciden las vocales","No coincide ningún sonido","Se repite la primera palabra","Coinciden todos los sonidos desde la última vocal acentuada"]$mq$, 3, $mq$En «canción / corazón» coinciden todos los sonidos desde la vocal tónica.$mq$, $mq$easy$mq$),
($mq$¿Qué es la rima asonante?$mq$, $mq$["Coinciden vocales y consonantes","Coinciden solo las consonantes","Coinciden solo las vocales desde la última vocal acentuada","No hay rima"]$mq$, 2, $mq$En «casa / palma» solo coinciden las vocales a-a.$mq$, $mq$easy$mq$),
($mq$¿Qué hace la onomatopeya?$mq$, $mq$["Compara dos cosas","Imita un sonido real mediante palabras","Describe un olor","Repite una pregunta"]$mq$, 1, $mq$Palabras como «tic-tac» o «guau» recrean sonidos.$mq$, $mq$easy$mq$),
($mq$¿Qué es una sílaba tónica?$mq$, $mq$["La sílaba que se pronuncia con mayor fuerza","La primera sílaba de la palabra","La última sílaba siempre","La sílaba con tilde siempre"]$mq$, 0, $mq$La sílaba tónica lleva el acento de intensidad; puede llevar o no tilde.$mq$, $mq$easy$mq$),
($mq$Extracto inventado: «Bajo el ancho ramaje, el rumor del río rueda en ronroneo.» ¿Qué sonido se repite y qué efecto imita?$mq$, $mq$["La /s/; imita un silbido","La /m/; imita un golpe","La /t/; imita un chasquido","La /r/ vibrante; imita el murmullo continuo del agua"]$mq$, 3, $mq$La repetición de /r/ en «ramaje», «rumor», «río» y «rueda» sugiere un fluir rumoroso.$mq$, $mq$medium$mq$),
($mq$Dos versos inventados: «La luna cuenta al viento su cuento / mientras duerme el sendero lento». ¿Qué rima hay?$mq$, $mq$["Asonante, en -a-o","No hay rima","Consonante, en -ento","Asonante, en -e-o"]$mq$, 2, $mq$«viento» y «lento» coinciden en todos los sonidos desde la vocal tónica: -ento.$mq$, $mq$medium$mq$),
($mq$Verso inventado: «Tic, tac, tic, tac, el reloj insiste». ¿Qué efecto principal produce?$mq$, $mq$["Expresa una idea abstracta sin ritmo","Imita el paso mecánico del tiempo y crea un ritmo constante","Introduce un diálogo","Hace una comparación"]$mq$, 1, $mq$La onomatopeya repetida marca un compás que evoca el reloj.$mq$, $mq$medium$mq$),
($mq$¿Cuántas sílabas métricas tiene el verso «mi casa tiene un jardín»?$mq$, $mq$["8","7","9","6"]$mq$, 0, $mq$Tiene ocho sílabas gramaticales; la sinalefa en «tiene un» resta una (7) y, como «jardín» es aguda, se suma una al final: 8.$mq$, $mq$medium$mq$),
($mq$¿Qué es la sinalefa?$mq$, $mq$["La separación de dos vocales","La pausa al final del verso","La rima entre dos palabras","Unión en una sola sílaba métrica de la vocal final de una palabra y la inicial de la siguiente"]$mq$, 3, $mq$Ejemplo: en «la amiga» las vocales a-a se unen y se cuentan tres sílabas métricas (laa-mi-ga) en lugar de cuatro.$mq$, $mq$medium$mq$),
($mq$Un verso corto de cuatro sílabas seguido de uno de diez crea un cambio de ritmo. ¿Qué efecto puede producir?$mq$, $mq$["Un error de métrica","Una rima perfecta","Contraste entre rapidez e inmersión o reflexión","Una pausa final obligatoria"]$mq$, 2, $mq$La variación de longitud afecta al ritmo y puede reforzar el significado.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Sonó el silbido suave de la sirena.» ¿Qué sonido se repite?$mq$, $mq$["La /m/","La /s/","La /p/","La /ch/"]$mq$, 1, $mq$La /s/ repetida sugiere un silbido, tema de la frase.$mq$, $mq$medium$mq$),
($mq$¿Qué indica un encabalgamiento en un poema?$mq$, $mq$["La frase continúa en el verso siguiente sin pausa al final","Que termina el poema","Que todos los versos riman","Que hay un diálogo"]$mq$, 0, $mq$El sentido sigue entre versos, creando fluidez o tensión.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Pasos pesados pisan el pasillo palpitante.» ¿Qué análisis es más sólido?$mq$, $mq$["La /p/ suaviza y calma la escena","No hay ningún recurso","Es una rima asonante","La /p/ oclusiva repetida imita golpes de pasos y tensión"]$mq$, 3, $mq$La /p/ es oclusiva y seca: refuerza la idea de pisadas pesadas.$mq$, $mq$hard$mq$),
($mq$Versos inventados: «Callaba el campo, quieto, entre la bruma, / y el aire, de tan frío, se hacía espuma.» ¿Qué rima y qué efecto hay?$mq$, $mq$["Asonante en -a-a; sin efecto","No hay rima porque son versos libres","Consonante en -uma; el eco enlaza imagen de bruma y espuma","Rima en -ío; sugiere calor"]$mq$, 2, $mq$«bruma / espuma» coinciden totalmente desde «u»; la rima une dos imágenes del frío.$mq$, $mq$hard$mq$),
($mq$Un poema usa frases largas con muchas comas y luego una sola palabra: «Silencio.». ¿Qué efecto produce el cambio de ritmo?$mq$, $mq$["Una aceleración sin sentido","Una pausa dramática que enfatiza el silencio","Una rima forzada","Una descripción técnica"]$mq$, 1, $mq$La brevedad contrasta con las frases largas y enfatiza el vacío.$mq$, $mq$hard$mq$),
($mq$¿Por qué la rima asonante es frecuente en el romance tradicional?$mq$, $mq$["Da musicalidad más flexible y fácil de recordar en un texto largo","Porque es obligatoria en todo poema","Porque es más exacta que la consonante","Porque elimina el ritmo"]$mq$, 0, $mq$Al rimar solo vocales, un poema largo mantiene musicalidad sin forzar el vocabulario.$mq$, $mq$hard$mq$),
($mq$Una alumna escribe: «Hay aliteración porque se repiten palabras». ¿Qué corrección es necesaria?$mq$, $mq$["No hay corrección: es correcta","Debe decir que es una rima","Debe decir que es una metáfora","La aliteración repite sonidos, no palabras; hay que indicar el sonido y su efecto"]$mq$, 3, $mq$Repetir una palabra es repetición o anáfora; la aliteración repite fonemas.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Sound and Rhythm$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Aliteración$mq$, $mq$Repetición de sonidos consonánticos en palabras cercanas para crear musicalidad o imitar un ruido. No es repetir palabras.$mq$),
($mq$Onomatopeya$mq$, $mq$Palabra que imita un sonido de la realidad, como «tic-tac», «pum» o «guau».$mq$),
($mq$Rima consonante$mq$, $mq$Coinciden todos los sonidos desde la última vocal acentuada: «viento / lento».$mq$),
($mq$Rima asonante$mq$, $mq$Coinciden solo las vocales desde la última vocal acentuada: «casa / palma».$mq$),
($mq$Sinalefa$mq$, $mq$Unión en una sola sílaba métrica de la vocal final de una palabra y la inicial de la siguiente.$mq$),
($mq$Reglas del final de verso$mq$, $mq$Palabra aguda: se suma una sílaba; llana: no cambia; esdrújula: se resta una.$mq$),
($mq$Encabalgamiento$mq$, $mq$La frase continúa en el verso siguiente sin pausa al final del verso; crea fluidez o tensión.$mq$),
($mq$Anáfora$mq$, $mq$Repetición de una palabra o expresión al comienzo de varios versos o frases para enfatizar.$mq$),
($mq$Sonido y significado$mq$, $mq$Sonidos suaves (/l/, /m/) sugieren calma; sonidos oclusivos (/p/, /t/, /k/) sugieren golpes o tensión; /s/ sugiere silbido.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Sound and Rhythm$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Lo esencial
Un texto no solo se lee con los ojos: también se oye. Los autores trabajan los **sonidos** y el **ritmo** para crear atmósfera, imitar la realidad y subrayar ideas. En poesía, canciones y discursos esto es especialmente importante. Para analizarlo, identifica el recurso, cita los versos y explica qué efecto produce.

## Recursos de sonido
- **Aliteración:** repetición de sonidos consonánticos en palabras cercanas. «El rumor del río rueda en ronroneo» repite /r/ para evocar un murmullo.
- **Onomatopeya:** palabra que imita un sonido: «tic-tac», «plas», «guau».
- **Rima consonante:** coinciden todos los sonidos a partir de la última vocal acentuada: «viento / lento».
- **Rima asonante:** solo coinciden las vocales desde la última vocal acentuada: «casa / palma».
- **Paralelismo:** repetición de una misma estructura sintáctica en frases o versos.
- **Anáfora:** repetición de una palabra o expresión al comienzo de varios versos o frases.

## El ritmo
El ritmo nace de la combinación de sílabas, acentos y pausas. En poesía influyen:
- **Métrica:** número de sílabas de cada verso. Se cuentan sílabas métricas, no gramaticales.
- **Sinalefa:** dos vocales contiguas de palabras distintas forman una sola sílaba métrica. «Mi casa tiene un jardín» tiene ocho sílabas gramaticales, siete tras la sinalefa de «tiene un» y ocho métricas al sumar una por la palabra aguda final.
- **Reglas del final de verso:** si la última palabra es aguda, se suma una sílaba; si es llana, se deja como está; si es esdrújula, se resta una.
- **Pausa o cesura** y **encabalgamiento:** cuando la oración continúa en el verso siguiente, el ritmo se vuelve fluido o tenso.
- **Longitud de las frases:** frases cortas aceleran; frases largas ralentizan o crean agobio.

## Cómo conectar sonido y significado
El sonido siempre debe vincularse al sentido. Los sonidos suaves (/l/, /m/, /n/, vocales abiertas) suelen sugerir calma o ternura. Los sonidos duros u oclusivos (/p/, /t/, /k/) sugieren golpes, tensión o violencia. Los sonidos sibilantes (/s/) pueden sugerir silbido, secreto o suspiro.
Ejemplo inventado: «Pasos pesados pisan el pasillo palpitante.» La /p/ repetida imita pisadas secas y crea tensión.

## Un método de análisis
1. **Localiza** el recurso y cita las palabras.
2. **Nombra** el recurso con precisión (por ejemplo, «aliteración de /s/»).
3. **Explica** qué sonido o ritmo recrea.
4. **Relaciónalo** con el significado: ¿qué emoción o escena refuerza?

## Errores frecuentes
- **Confundir aliteración con repetición de palabras.** La aliteración repite sonidos.
- **Contar sílabas gramaticales.** En métrica hay que aplicar sinalefa y las reglas del final de verso.
- **Mezclar rima asonante y consonante.** Si se repiten consonantes, es consonante.
- **Nombrar sin explicar.** Un recurso sin efecto no suma puntos.
- **Olvidar leer en voz alta.** Murmura el verso: oírlo ayuda a detectar el ritmo.

## Cómo se evalúa
En la evaluación en pantalla aparecen versos o párrafos breves y se pregunta qué sonidos se repiten, qué efecto tiene el cambio de ritmo o cómo una pausa refuerza el significado. Las mejores respuestas relacionan siempre el sonido con la emoción o la idea.

Exam tip: nunca digas solo «hay aliteración»; escribe qué sonido se repite, entre qué palabras y qué imagen sonora o emoción refuerza.$mq$ from st;

-- Language Devices > Register and Word Choice
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Language Devices$mq$, 5, 2 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Register and Word Choice$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Language Devices$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Register and Word Choice$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué es el registro de un texto?$mq$, $mq$["El nivel de formalidad del lenguaje según la situación","La tipografía","La rima de los versos","El género literario"]$mq$, 0, $mq$El registro puede ser formal, informal o coloquial según emisor, receptor y situación.$mq$, $mq$easy$mq$),
($mq$¿Qué frase es más formal?$mq$, $mq$["¡Oye, dame una cita ya!","Quiero cita, ¿vale?","Dame una cita, tío","Le agradecería que me concediera una cita"]$mq$, 3, $mq$Usa «usted» implícito, condicional de cortesía y vocabulario cuidado.$mq$, $mq$easy$mq$),
($mq$¿Qué palabra es coloquial?$mq$, $mq$["Muchacho","Joven","Chaval","Adolescente"]$mq$, 2, $mq$«Chaval» es habitual en el habla informal, no en textos formales.$mq$, $mq$easy$mq$),
($mq$¿Qué es la connotación?$mq$, $mq$["El significado literal de una palabra","El valor emocional que una palabra añade a su significado","La sílaba tónica","La rima"]$mq$, 1, $mq$Las connotaciones pueden ser positivas, negativas o neutras.$mq$, $mq$easy$mq$),
($mq$¿Qué es un sinónimo?$mq$, $mq$["Una palabra con significado parecido a otra","Una palabra con significado opuesto","Una palabra que suena igual","Una palabra sin significado"]$mq$, 0, $mq$Sinónimos: «casa» y «vivienda»; pero rara vez tienen exactamente la misma connotación.$mq$, $mq$easy$mq$),
($mq$Compara «Se marchó a hurtadillas» y «Se fue sin que nadie lo notara». ¿Qué diferencia de registro hay?$mq$, $mq$["La primera es más coloquial y vulgar","Ambas son idénticas","La segunda es poética","La primera es más literaria y expresiva; la segunda, más neutra y cotidiana"]$mq$, 3, $mq$«A hurtadillas» es una locución más expresiva y culta; la segunda es neutra.$mq$, $mq$medium$mq$),
($mq$Extracto inventado de una carta formal: «Me dirijo a usted para solicitarle información.» ¿Qué rasgo de registro formal aparece?$mq$, $mq$["Abreviaturas de mensajes","Interjecciones","El uso de «usted» y de fórmulas de cortesía","Palabras malsonantes"]$mq$, 2, $mq$«Me dirijo a usted» y «solicitarle» son fórmulas propias del registro formal escrito.$mq$, $mq$medium$mq$),
($mq$¿Qué efecto tiene usar «inquilino» en lugar de «habitante»?$mq$, $mq$["Indica que vive en la montaña","Aporta un matiz de relación contractual","Convierte la frase en poética","No cambia nada"]$mq$, 1, $mq$El léxico preciso aporta matices: «inquilino» implica alquiler.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «El chaval flipó con la peli.» ¿Qué registro tiene?$mq$, $mq$["Coloquial","Formal","Científico","Jurídico"]$mq$, 0, $mq$«Chaval», «flipar» y «peli» son rasgos del habla informal.$mq$, $mq$medium$mq$),
($mq$Un autor elige «vociferar» en lugar de «hablar». ¿Qué aporta?$mq$, $mq$["Más suavidad","Más formalidad","Más rima","Intensidad: hablar a gritos y con enfado"]$mq$, 3, $mq$El verbo concreto transmite un modo específico de hablar.$mq$, $mq$medium$mq$),
($mq$¿Qué es un eufemismo y qué registro suele implicar?$mq$, $mq$["Una exageración vulgar","Una palabra técnica","Una expresión suave para algo desagradable; suele ser cortés o evasivo","Un insulto"]$mq$, 2, $mq$Ejemplo: «persona mayor» por «anciano»; suaviza y evita la crudeza.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «La reunión se aplaza sine die por causas ajenas a la dirección.» ¿Qué tipo de léxico domina?$mq$, $mq$["Juvenil","Administrativo y formal","Poético","Infantil"]$mq$, 1, $mq$La locución latina «sine die» y las fórmulas impersonales son propias del lenguaje institucional.$mq$, $mq$medium$mq$),
($mq$En una publicación de un grupo de amigos, aparece «Nos vemos mañana, ¿vale?». ¿Qué rasgo es informal?$mq$, $mq$["La fórmula «¿vale?» y el tono directo","El uso de «usted»","Las fórmulas legales","La puntuación excesiva"]$mq$, 0, $mq$«¿Vale?» busca confirmación cercana, típica del habla informal.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «El gobierno aplicó un ajuste» vs. «El gobierno recortó los salarios». ¿Qué conclusión de análisis es más sólida?$mq$, $mq$["Ambas son iguales","La primera es más agresiva","La segunda es un eufemismo","La primera usa un eufemismo que suaviza; la segunda es directa y negativa"]$mq$, 3, $mq$«Ajuste» disimula la medida; «recortó» nombra la acción sin suavizar.$mq$, $mq$hard$mq$),
($mq$Un orador político usa «nosotros», «juntos» y «nuestro futuro». ¿Qué intención lingüística se aprecia?$mq$, $mq$["Mostrar lejanía","Dar instrucciones técnicas","Crear identificación y unidad con el público","Narrar un chiste"]$mq$, 2, $mq$La primera persona del plural incluye al público y busca complicidad.$mq$, $mq$hard$mq$),
($mq$Un texto científico para estudiantes cambia «el experimento falló» por «el resultado no confirmó la hipótesis». ¿Qué efecto tiene el cambio?$mq$, $mq$["Más emoción","Mayor objetividad y precisión; sustituye un juicio por un hecho","Más ironía","Más informalidad"]$mq$, 1, $mq$El segundo enunciado describe el resultado sin valorarlo.$mq$, $mq$hard$mq$),
($mq$Compara «pobre» y «humilde» al describir una casa. ¿Qué análisis es más acertado?$mq$, $mq$["«Humilde» connota dignidad y sencillez; «pobre» suele connotar carencia","Son exactamente iguales","«Humilde» es insultante","«Pobre» es poético"]$mq$, 0, $mq$Aunque a veces sean sinónimos, los matices connotativos orientan la valoración.$mq$, $mq$hard$mq$),
($mq$Una alumna cambia el registro de una carta de queja de coloquial a formal. ¿Qué cambio es correcto?$mq$, $mq$["Sustituir «Atentamente» por «Un abrazo, tío»","Sustituir «guay» por «pasada»","Ningún cambio es necesario","Sustituir «Os digo que esto es una pasada» por «Le comunico que considero inaceptable este servicio»"]$mq$, 3, $mq$La opción formal usa «usted», un verbo de comunicación y un juicio claramente expresado.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Register and Word Choice$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Registro$mq$, $mq$Nivel de formalidad del lenguaje según la situación, el emisor y el destinatario: formal, neutro, informal o técnico.$mq$),
($mq$Rasgos del registro formal$mq$, $mq$Tratamiento de «usted», léxico cuidado, frases completas y fórmulas de cortesía como «Atentamente».$mq$),
($mq$Rasgos del registro coloquial$mq$, $mq$Expresiones cercanas, interjecciones, abreviaturas y marcas de oralidad como «vale», «pues» o «¿sabes?».$mq$),
($mq$Denotación$mq$, $mq$Significado literal de una palabra, tal como aparece en el diccionario.$mq$),
($mq$Connotación$mq$, $mq$Carga emocional o cultural que añade una palabra. «Hogar» connota calidez; «casucha», deterioro.$mq$),
($mq$Eufemismo$mq$, $mq$Palabra o expresión suave que sustituye otra dura o desagradable, como «ajuste» por «recorte».$mq$),
($mq$Verbos precisos$mq$, $mq$«Susurró», «vociferó» o «murmuró» sustituyen «dijo» y revelan actitud, volumen y emoción.$mq$),
($mq$Pronombre «nosotros» en un discurso$mq$, $mq$Incluye al público e intenta crear unidad e identificación; «ellos» crea distancia.$mq$),
($mq$Cómo analizar una elección de palabras$mq$, $mq$Citar la palabra, compararla con un sinónimo, nombrar su connotación y explicar el efecto en el lector.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Register and Word Choice$mq$ and p.name = $mq$Language Devices$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Lo esencial
Cada vez que escribes, eliges palabras. Esa elección, llamada **léxico** o **elección de palabras**, y el nivel de formalidad, llamado **registro**, transmiten significado tanto como el contenido. Un texto puede decir lo mismo de maneras muy distintas según quién lo escribe, a quién y en qué situación. En Lengua y Literatura debes ser capaz de reconocer el registro, explicar las connotaciones y valorar sus efectos.

## Los registros
- **Formal:** vocabulario cuidado, frases completas, tratamiento de «usted», ausencia de expresiones coloquiales. Ejemplo inventado: «Le agradecería que me concediera una cita.»
- **Neutro o estándar:** comprensible para cualquier lector, sin rasgos marcados. Es el registro de muchas noticias.
- **Informal o coloquial:** expresiones cercanas, frases cortas, interjecciones, abreviaturas. «Nos vemos mañana, ¿vale?»
- **Técnico o especializado:** vocabulario propio de una disciplina, como «hipótesis», «cláusula» o «bioma».
- **Literario:** léxico cuidado, imágenes y construcciones expresivas.

## Pistas para identificar el registro
- **Tratamiento:** «usted» frente a «tú».
- **Léxico:** «chaval» o «flipar» frente a «muchacho» o «asombrarse».
- **Sintaxis:** frases largas y subordinadas (formal) o breves y elípticas (informal).
- **Marcas de oralidad:** «bueno», «pues», «¿sabes?», «¿vale?».
- **Fórmulas de cortesía:** «Atentamente», «Reciba un cordial saludo».

## Denotación y connotación
La **denotación** es el significado literal de una palabra. La **connotación** es el valor emocional o cultural que añade. «Hogar» denota un lugar donde se vive y connota calidez; «casucha» denota lo mismo, pero connota deterioro. Los sinónimos rara vez son exactamente iguales: «delgado» y «flaco» tienen distinta carga. Cuando analices una elección de palabras, pregúntate qué otras opciones tenía el autor y por qué eligió esa.

## Elección de palabras con efecto
- **Verbos precisos:** «susurró», «vociferó» o «murmuró» sustituyen «dijo» y revelan actitud.
- **Adjetivos valorativos:** orientan la opinión del lector. «Humilde» frente a «pobre».
- **Eufemismos:** suavizan una realidad dura («ajuste» por «recorte»).
- **Pronombres:** el «nosotros» incluye al público; el «ellos» crea distancia.
- **Léxico abstracto o concreto:** lo concreto da imágenes, lo abstracto da generalidad.

## Cómo analizarlo
Cita la palabra, nombra la clase de connotación y explica el efecto. Ejemplo inventado: «El gobierno aplicó un ajuste.» El sustantivo «ajuste» funciona como eufemismo: evita nombrar la pérdida de empleos y presenta la medida como técnica y necesaria.

## Errores frecuentes
- **Pensar que formal significa complicado.** Un texto formal puede ser claro y sencillo.
- **Decir que dos sinónimos son idénticos.** Siempre cambian los matices.
- **Describir el registro sin pruebas.** Cita palabras concretas.
- **Mezclar registros sin intención.** Al escribir, evita pasar de «usted» a «tú» sin motivo.
- **Confundir coloquial con incorrecto.** El registro coloquial es válido en su contexto.

## Cómo se evalúa
En la evaluación en pantalla se presentan dos versiones del mismo mensaje o un fragmento con vocabulario llamativo. Preguntan qué registro predomina, qué connotaciones tienen ciertas palabras y qué efecto producen en un público concreto. También puede pedirse reescribir una frase en otro registro.

Exam tip: cuando analices una palabra, compárala mentalmente con un sinónimo; la diferencia de connotación suele ser la clave de tu respuesta.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;