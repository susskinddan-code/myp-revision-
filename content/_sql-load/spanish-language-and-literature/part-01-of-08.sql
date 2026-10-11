-- Part 1 of 8: 3 sub-topics. Safe to re-run: sub-topics that already have a note are skipped.
begin;

-- Reading and Comprehension > Literal and Inferential Understanding
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Reading and Comprehension$mq$, 5, 1 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Literal and Inferential Understanding$mq$, 5, p.id, 1
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Reading and Comprehension$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Literal and Inferential Understanding$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué es la comprensión literal de un texto?$mq$, $mq$["Entender lo que el texto dice de forma explícita","Adivinar los secretos del autor","Decidir si el texto es bonito","Resumir el texto en una sola palabra"]$mq$, 0, $mq$La comprensión literal se centra en la información escrita claramente: quién, qué, dónde y cuándo.$mq$, $mq$easy$mq$),
($mq$¿Qué es una inferencia?$mq$, $mq$["Una cita copiada palabra por palabra","Una falta de ortografía","El título de un capítulo","Una conclusión basada en pistas del texto y en lo que sabemos"]$mq$, 3, $mq$Inferir es «leer entre líneas»: unimos las pistas del texto con nuestros conocimientos.$mq$, $mq$easy$mq$),
($mq$Extracto inventado: «Marta cerró el paraguas y sacudió las botas en el felpudo.» ¿Qué dato es literal?$mq$, $mq$["Llovió todo el día","Marta acababa de llegar a una casa ajena","Marta cerró el paraguas","Marta estaba cansada"]$mq$, 2, $mq$El texto dice explícitamente que cerró el paraguas. Las demás opciones son suposiciones.$mq$, $mq$easy$mq$),
($mq$¿Qué pregunta exige una respuesta literal?$mq$, $mq$["¿Por qué parece inquieto el narrador?","¿Dónde ocurre la escena inicial?","¿Qué siente probablemente el personaje?","¿Qué mensaje quiere transmitir la autora?"]$mq$, 1, $mq$Para saber dónde ocurre la escena basta localizar un dato escrito. Las otras preguntas piden interpretar.$mq$, $mq$easy$mq$),
($mq$Cuando justificamos una inferencia, ¿qué debemos hacer?$mq$, $mq$["Apoyarla en una palabra o frase del texto","Dar solo nuestra opinión","Copiar el párrafo completo","Cambiar el sentido del texto"]$mq$, 0, $mq$Una inferencia válida siempre se apoya en una prueba concreta, citada de forma breve.$mq$, $mq$easy$mq$),
($mq$Extracto inventado: «Samuel miraba el reloj cada medio minuto. Sus dedos tamborileaban sobre la mesa.» ¿Qué inferencia está mejor justificada?$mq$, $mq$["Samuel está enfadado con su vecino","Samuel se aburre en la biblioteca","Samuel acaba de ganar un premio","Samuel está impaciente o nervioso"]$mq$, 3, $mq$Mirar el reloj sin parar y tamborilear son pistas de impaciencia o nervios. Nada indica enfado ni alegría.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «El pueblo aún dormía cuando Inés cerró la puerta sin hacer ruido. Su maleta la esperaba en el camino.» ¿Qué se puede inferir?$mq$, $mq$["Inés vuelve a casa tras un largo viaje","Inés se muda con toda su familia","Inés se marcha con discreción, quizá a escondidas","Inés prepara un picnic"]$mq$, 2, $mq$«Aún dormía», «sin hacer ruido» y la maleta lista sugieren una salida discreta. El texto no dice que regrese ni que vaya acompañada.$mq$, $mq$medium$mq$),
($mq$Una alumna escribe: «El personaje está triste porque llora.» ¿Cuál es el fallo principal de esta respuesta?$mq$, $mq$["Es demasiado larga","Da por probada la causa del llanto sin citar el texto","Usa el tiempo presente","Menciona al personaje"]$mq$, 1, $mq$Se puede llorar de alegría, de dolor o de tristeza. Hay que buscar en el texto la causa real y citarla.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «El autobús arrancó a las 8:05, con cinco minutos de retraso.» ¿Qué respuesta es literal?$mq$, $mq$["El autobús salió a las 8:05","El conductor es irresponsable","Los pasajeros están furiosos","El autobús perderá el transbordo"]$mq$, 0, $mq$La hora de salida está escrita en el texto. Las demás respuestas son suposiciones no confirmadas.$mq$, $mq$medium$mq$),
($mq$¿Por qué ayuda el contexto a entender una palabra desconocida?$mq$, $mq$["Porque el diccionario está prohibido","Porque toda palabra significa lo mismo en cualquier texto","Porque el título siempre la define","Porque las palabras cercanas ofrecen pistas sobre su significado"]$mq$, 3, $mq$Las frases vecinas, el tema y el tono permiten deducir el sentido probable de una palabra.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Lucía guardó la carta sin abrirla y apagó la luz de golpe.» ¿Qué pregunta de comprensión es inferencial?$mq$, $mq$["¿Qué guardó Lucía?","¿Qué hizo Lucía con la luz?","¿Qué actitud tiene Lucía ante la carta?","¿Abrió Lucía la carta?"]$mq$, 2, $mq$La actitud no se dice: se deduce de gestos como no abrir la carta y apagar la luz de golpe. Las otras preguntas se responden con datos explícitos.$mq$, $mq$medium$mq$),
($mq$Un texto dice: «Cuando por fin llegó la ambulancia, el parque ya estaba en silencio.» ¿Qué opción es una inferencia razonable?$mq$, $mq$["La ambulancia llegó antes que nadie","Hubo algún accidente o emergencia antes de llegar la ambulancia","El parque estaba lleno de gente cantando","La ambulancia llegó sin sirena"]$mq$, 1, $mq$La presencia de una ambulancia y el silencio sugieren una emergencia. El resto contradice el texto o no aparece en él.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «—No pasa nada —dijo Tomás, mientras apretaba tanto la taza que le temblaron los nudillos.» ¿Qué revela el gesto?$mq$, $mq$["Que sus palabras ocultan tensión o enfado","Que Tomás tiene frío","Que la taza está rota","Que Tomás está completamente relajado"]$mq$, 0, $mq$El gesto contradice lo que dice: la tensión física muestra emociones que no verbaliza.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Desde que llegó la nueva vecina, el señor Ortega dejó de regar sus geranios y bajaba el volumen de la radio.» ¿Qué conclusión está más sólidamente apoyada?$mq$, $mq$["Ortega odia las plantas desde siempre","La vecina le ha prohibido tener radio","Ortega se ha mudado de casa","Su comportamiento ha cambiado desde la llegada de la vecina, quizá por respeto o incomodidad"]$mq$, 3, $mq$El texto establece un cambio posterior a un hecho (la llegada). La causa exacta no se dice, por eso hay que formularla con prudencia.$mq$, $mq$hard$mq$),
($mq$Un alumno responde: «El narrador es cruel» a partir de la frase «Sonrió al ver caer a su rival». ¿Qué le falta para que la inferencia sea convincente?$mq$, $mq$["Añadir más adjetivos","Eliminar la cita","Explicar la conexión entre la frase citada y la crueldad, considerando otras lecturas","Escribir en pasado"]$mq$, 2, $mq$Una inferencia sólida cita la prueba, explica el razonamiento y descarta alternativas (¿quizá sonrió por nervios?).$mq$, $mq$hard$mq$),
($mq$Extracto inventado: «En el mapa del pueblo, la escuela aparecía tachada con un rotulador rojo.» Una alumna dice: «La escuela cerró.» Otra: «Alguien tachó la escuela del mapa.» ¿Cuál es la lectura más segura y por qué?$mq$, $mq$["La primera, porque es más breve","La segunda, porque describe lo que el texto afirma sin añadir causas","La primera, porque todos los mapas tachados indican cierres","Ninguna, porque no se puede leer el texto"]$mq$, 1, $mq$La segunda es literal. La primera es una inferencia posible, pero el texto no confirma el cierre.$mq$, $mq$hard$mq$),
($mq$Extracto inventado: «Leo guardó el trofeo en el fondo del armario, detrás de los abrigos, y cerró con llave.» Se pregunta por la actitud de Leo hacia su éxito. ¿Qué respuesta combina mejor pista y razonamiento?$mq$, $mq$["Esconde el trofeo; quizá siente vergüenza o no quiere recordar cómo lo logró","Está orgulloso, porque los trofeos se guardan siempre","Ha olvidado el trofeo, porque está en el armario","Quiere regalarlo, porque lo cierra con llave"]$mq$, 0, $mq$Esconder y cerrar con llave sugiere que no desea exhibirlo, lo cual contradice el orgullo. La respuesta correcta formula una hipótesis apoyada en pistas.$mq$, $mq$hard$mq$),
($mq$En un examen aparece: «Explica qué sugiere el autor sobre la relación entre los hermanos.» ¿Qué tipo de respuesta se espera?$mq$, $mq$["Literal, copiando el primer párrafo","Una opinión personal sin referencia al texto","Un resumen de la biografía del autor","Inferencial, con citas que respalden lo sugerido"]$mq$, 3, $mq$El verbo «sugiere» indica que la información no es explícita: se debe inferir y probar con citas.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Literal and Inferential Understanding$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Comprensión literal$mq$, $mq$Entender la información escrita de forma explícita: quién, qué, dónde y cuándo. La respuesta se localiza directamente en el texto.$mq$),
($mq$Inferencia$mq$, $mq$Conclusión que sacamos de pistas del texto y de nuestros conocimientos sobre lo que no se dice directamente. Es «leer entre líneas».$mq$),
($mq$Fórmula para justificar una inferencia$mq$, $mq$Afirmación + prueba (cita breve y exacta) + explicación del razonamiento. Sin cita no hay justificación sólida.$mq$),
($mq$¿Qué verbos de mandato piden respuesta literal?$mq$, $mq$«Indica», «localiza», «identifica» o «menciona». Piden un dato escrito en el texto, sin interpretación.$mq$),
($mq$¿Qué verbos de mandato piden inferencia?$mq$, $mq$«Deduce», «explica qué sugiere», «justifica» o «qué revela». Exigen interpretar y apoyarse en citas.$mq$),
($mq$Error típico al inferir$mq$, $mq$Dar una causa como cierta sin prueba, por ejemplo: «llora, luego está triste». Hay que buscar evidencias y usar «probablemente».$mq$),
($mq$Cómo entender una palabra desconocida$mq$, $mq$Usar el contexto: palabras cercanas, tono y estructura de la palabra (prefijos, sufijos, familia léxica).$mq$),
($mq$Pista textual$mq$, $mq$Palabra, gesto o detalle del texto que sirve de base a una inferencia, como «tamborileaban los dedos» para mostrar nervios.$mq$),
($mq$Lenguaje de probabilidad$mq$, $mq$Expresiones como «parece», «sugiere», «probablemente» o «da a entender» muestran que la inferencia es una interpretación razonable.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Literal and Inferential Understanding$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Lo esencial
Leer no consiste solo en reconocer palabras: consiste en entender lo que el texto dice y también lo que deja entrever. En Lengua y Literatura se evalúan dos niveles de comprensión: la **comprensión literal** y la **comprensión inferencial**. Los exámenes suelen combinarlos en una misma pregunta, por eso conviene dominar ambos.

## Comprensión literal
Se refiere a la información que está escrita de forma explícita: personajes, lugares, momentos, acciones y datos. La respuesta se encuentra directamente en el texto, a veces en una sola frase. Para responder basta con localizar, copiar con precisión o reformular con tus palabras.
- **¿Quién?** Los personajes y el narrador.
- **¿Dónde y cuándo?** Las referencias de lugar y tiempo.
- **¿Qué?** Los hechos, en su orden.
- **¿Cómo?** La manera de actuar y las descripciones.
Ejemplo inventado: en «Marta cerró el paraguas», el dato literal es que Marta cerró el paraguas. El texto no dice que llueva, aunque podamos sospecharlo.

## Comprensión inferencial
Inferir es sacar una conclusión a partir de pistas. El autor no lo dice todo: deja huecos que el lector completa. Para inferir combinamos tres elementos: una **pista** del texto, un **conocimiento** del mundo o del contexto y un **razonamiento** que los une.
Ejemplo: «Samuel miraba el reloj cada medio minuto.» Pista: mira el reloj sin parar. Conocimiento: la gente mira la hora cuando espera o está nerviosa. Conclusión: Samuel está impaciente. Fíjate en que se escribe «probablemente», «parece» o «sugiere», porque una inferencia es una interpretación razonable, no un hecho seguro.

## Cómo justificar una inferencia
Una buena respuesta sigue la secuencia **afirmación, prueba y explicación**:
- Afirmación: «Samuel está impaciente.»
- Prueba: «mirar el reloj cada medio minuto» y «tamborilear sobre la mesa».
- Explicación: estas acciones repetidas muestran que desea que el tiempo pase más rápido.
Las citas deben ser breves, exactas y entrecomilladas. Copiar un párrafo entero no demuestra comprensión.

## Errores frecuentes
- **Confundir lo explícito con lo inferido.** Decir «llueve» porque alguien tiene un paraguas es suponer, no leer literalmente.
- **Inventar causas.** «Llora, por tanto está triste» ignora que se puede llorar de alegría. Busca la causa en el texto.
- **Responder sin citar.** Una opinión sin prueba no obtiene buenos niveles en los criterios.
- **Dejarse llevar por la intuición.** Si una pista contradice tu idea, revisa la idea, no el texto.
- **Olvidar el contexto.** Una misma palabra cambia de sentido según la época, el narrador y la situación.

## Palabras desconocidas
No te detengas ante un vocabulario difícil. Fíjate en las palabras cercanas, en el tono y en la estructura de la palabra (prefijos, sufijos, familia de palabras). Por ejemplo, en «el sendero era angosto, apenas cabía una persona», el contexto muestra que «angosto» significa estrecho.

## Cómo se evalúa
En la evaluación en pantalla suele aparecer un extracto breve, original, seguido de preguntas de distinto nivel. Primero se pide localizar un dato; después, explicar qué sugiere un gesto o una palabra; por último, justificar una interpretación con varias pruebas. Los verbos de mandato importan: «indica» y «localiza» piden respuestas literales; «explica qué sugiere», «deduce» o «justifica» exigen inferencia con pruebas.

Exam tip: antes de responder, subraya el verbo de mandato y decide si la información está dicha o sugerida; si está sugerida, cita la pista y explica tu razonamiento con «porque» o «lo que indica que».$mq$ from st;

-- Reading and Comprehension > Purpose and Audience
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Reading and Comprehension$mq$, 5, 1 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Purpose and Audience$mq$, 5, p.id, 2
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Reading and Comprehension$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Purpose and Audience$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué es el propósito de un texto?$mq$, $mq$["La razón por la que el autor lo escribe","El número de párrafos que tiene","El lugar donde se publicó","El color de la portada"]$mq$, 0, $mq$El propósito es lo que el autor quiere lograr: informar, persuadir, entretener, instruir o expresar sentimientos.$mq$, $mq$easy$mq$),
($mq$¿Qué es el público o destinatario de un texto?$mq$, $mq$["El autor del texto","El título","La editorial","Las personas a quienes se dirige el texto"]$mq$, 3, $mq$El destinatario es el lector previsto, y condiciona el vocabulario, el tono y los ejemplos.$mq$, $mq$easy$mq$),
($mq$Un folleto dice: «¡Ven a la feria del libro! Entrada gratuita, sábado a las 10:00». ¿Cuál es su propósito principal?$mq$, $mq$["Narrar una historia de miedo","Expresar tristeza","Informar e invitar a un evento","Criticar una novela"]$mq$, 2, $mq$El folleto da datos prácticos y anima a asistir: su finalidad es informar y convencer de manera sencilla.$mq$, $mq$easy$mq$),
($mq$¿Cuál de estos textos tiene como propósito principal entretener?$mq$, $mq$["Un manual de instrucciones","Un cuento de aventuras","Una receta de cocina","Un aviso de seguridad"]$mq$, 1, $mq$Los cuentos buscan entretener al lector mediante una historia. Los otros textos buscan instruir o avisar.$mq$, $mq$easy$mq$),
($mq$¿Qué pista indica que un texto se dirige a niños pequeños?$mq$, $mq$["Frases cortas, palabras sencillas y un tono cercano","Términos técnicos y tecnicismos","Cifras estadísticas complejas","Citas legales extensas"]$mq$, 0, $mq$El registro y el vocabulario se adaptan al público: con niños se usa un lenguaje simple y cercano.$mq$, $mq$easy$mq$),
($mq$Extracto inventado: «Si no cuidamos nuestros ríos, mañana no habrá agua para nuestros hijos. ¡Actúa hoy!». ¿Cuál es el propósito dominante?$mq$, $mq$["Describir un paisaje","Narrar una anécdota","Explicar un proceso técnico","Persuadir al lector para que actúe"]$mq$, 3, $mq$La amenaza futura y el imperativo «actúa» buscan convencer y mover a la acción.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Primero, vierte la mezcla en el molde; después, hornea durante veinte minutos.» ¿Qué propósito y destinatario son más probables?$mq$, $mq$["Entretener a lectores de poesía","Criticar a un cocinero famoso","Instruir a cualquier persona que quiera cocinar","Persuadir a votar en unas elecciones"]$mq$, 2, $mq$Los pasos ordenados y los verbos en imperativo señalan un texto instructivo dirigido a un público general.$mq$, $mq$medium$mq$),
($mq$Un mismo hecho —la apertura de una biblioteca— se cuenta en una noticia y en una publicación de una red social escolar. ¿Qué diferencia se espera?$mq$, $mq$["Ambas usan exactamente el mismo registro","La noticia usa registro más formal y neutral; la publicación, más informal y emocional","La noticia lleva emojis; la publicación, datos oficiales","La noticia no puede informar"]$mq$, 1, $mq$El canal y el público determinan el registro: la prensa tiende a la formalidad, y las redes escolares a un tono cercano.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Estimado vecino: Le comunicamos que el corte de agua se realizará el martes, de 9:00 a 13:00.» ¿Qué rasgos muestran el destinatario?$mq$, $mq$["El tratamiento de «usted» y el registro formal indican un público adulto y desconocido","El tuteo cercano indica amistad","Los emoticonos indican público infantil","El lenguaje poético indica lectores de novela"]$mq$, 0, $mq$«Estimado» y «le comunicamos» son fórmulas formales de comunicación con ciudadanos.$mq$, $mq$medium$mq$),
($mq$Un anuncio dice: «Más rápido, más barato, más tuyo». ¿Qué recurso sirve a su propósito?$mq$, $mq$["Una explicación científica extensa","Una descripción detallada del paisaje","Una cita literaria antigua","La repetición de «más» para persuadir y crear ritmo"]$mq$, 3, $mq$El paralelismo y la repetición hacen el eslogan memorable, lo que ayuda a vender.$mq$, $mq$medium$mq$),
($mq$Una autora escribe para adolescentes sobre el sueño. ¿Qué elección sería más adecuada?$mq$, $mq$["Una terminología médica sin explicaciones","Un tono autoritario y distante","Ejemplos de la vida escolar y un tono cercano pero respetuoso","Una referencia exclusiva a la jubilación"]$mq$, 2, $mq$Adaptar los ejemplos y el tono al público facilita la comprensión y la atención.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «No fue un día cualquiera: aquel jueves, el viejo faro volvió a encenderse.» ¿Qué propósito sugiere el texto?$mq$, $mq$["Dar instrucciones de seguridad","Entretener y crear interés mediante la narración","Vender un producto","Pedir una donación"]$mq$, 1, $mq$El tono narrativo y la expresión «no fue un día cualquiera» despiertan curiosidad, típica de la ficción.$mq$, $mq$medium$mq$),
($mq$Un artículo de opinión dice: «Es evidente que las pantallas perjudican el aprendizaje». ¿Qué debe notar el lector atento?$mq$, $mq$["Que se presenta como hecho una afirmación que necesita pruebas","Que el texto es neutral","Que no tiene destinatario","Que solo describe"]$mq$, 0, $mq$«Es evidente» afirma con seguridad sin ofrecer datos: es una técnica persuasiva.$mq$, $mq$medium$mq$),
($mq$Extracto inventado de un comunicado escolar: «Les rogamos que revisen con sus hijos el reglamento de uso del móvil; entre todos haremos un centro más tranquilo.» ¿Qué dos destinatarios identifica el texto?$mq$, $mq$["Solo los profesores","Solo los vecinos del barrio","El director y el inspector","Las familias, como receptoras directas, y el alumnado, de forma indirecta"]$mq$, 3, $mq$«Les rogamos» se dirige a las familias, pero «con sus hijos» implica que el mensaje llega también al alumnado.$mq$, $mq$hard$mq$),
($mq$Dos textos sobre una excursión: el primero dice «El grupo salió a las 8:00 y regresó a las 17:00»; el segundo, «¡Qué maravilla de día! Nos reímos hasta que nos dolió la tripa». ¿Qué comparación es acertada?$mq$, $mq$["Ambos informan con el mismo tono","El primero busca emocionar; el segundo, dar un horario","El primero informa con datos; el segundo expresa emociones y busca complicidad","Ninguno tiene propósito"]$mq$, 2, $mq$El primero es objetivo y concreto; el segundo emplea exclamaciones y lenguaje subjetivo.$mq$, $mq$hard$mq$),
($mq$Un texto publicitario para jóvenes usa vocabulario coloquial y un humor irónico. Un lector adulto lo considera «poco serio». ¿Qué conclusión sobre la relación entre propósito y público es correcta?$mq$, $mq$["Está mal escrito porque debería ser formal","Está bien adaptado: el estilo sirve para conectar con su público previsto","No tiene propósito","Su público es el juez de un tribunal"]$mq$, 1, $mq$La eficacia se juzga según el destinatario previsto, no según el gusto de cualquier lector.$mq$, $mq$hard$mq$),
($mq$Extracto inventado: «Nuestros científicos han demostrado que este champú es el más eficaz.» ¿Qué análisis crítico es más completo?$mq$, $mq$["Se apoya en autoridad sin detallar datos, para persuadir; conviene preguntar cómo y con qué pruebas se demostró","Es un hecho comprobado y no requiere análisis","Es una descripción literaria","Es una pregunta retórica"]$mq$, 0, $mq$El texto invoca la autoridad científica sin ofrecer datos: es una técnica persuasiva que el lector debe cuestionar.$mq$, $mq$hard$mq$),
($mq$Una alumna debe explicar «el propósito y el público de un cartel contra el acoso escolar». ¿Qué respuesta tiene mejor estructura?$mq$, $mq$["El cartel es azul y tiene letras grandes","El propósito es entretener; el público, el director; sin pruebas","Simplemente: me gusta mucho","Propósito: concienciar y movilizar; público: alumnado y profesorado; prueba: uso de imperativos y la frase «No mires hacia otro lado»"]$mq$, 3, $mq$Una respuesta sólida identifica propósito y destinatario y los apoya con evidencias del texto.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Purpose and Audience$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Propósito del texto$mq$, $mq$La razón por la que se escribe: informar, persuadir, entretener, instruir o expresar. Se descubre preguntando qué quiere lograr el autor.$mq$),
($mq$Público o destinatario$mq$, $mq$El lector previsto. Condiciona el registro, el vocabulario, los ejemplos y el tono del texto.$mq$),
($mq$Texto persuasivo: rasgos$mq$, $mq$Imperativos, preguntas retóricas, exclamaciones, repeticiones y afirmaciones seguras que buscan convencer al lector.$mq$),
($mq$Texto informativo: rasgos$mq$, $mq$Datos, fechas, cifras, lenguaje objetivo y registro neutral; busca que el lector comprenda hechos.$mq$),
($mq$Texto instructivo: rasgos$mq$, $mq$Pasos ordenados, verbos en imperativo o infinitivo, conectores de secuencia y vocabulario preciso.$mq$),
($mq$Pistas del destinatario$mq$, $mq$Tratamiento (tú/usted), nivel de vocabulario, temas de interés y canal de publicación.$mq$),
($mq$Tema frente a propósito$mq$, $mq$El tema es de qué trata el texto; el propósito es para qué se escribe. Ejemplo: tema, el agua; propósito, concienciar.$mq$),
($mq$Estructura de respuesta de análisis$mq$, $mq$Afirmación + prueba textual + efecto sobre el lector. Ejemplo: «Persuade; el imperativo “actúa” urge a participar».$mq$),
($mq$Un texto con varios propósitos$mq$, $mq$Puede informar y persuadir a la vez, como un anuncio. Hay que decidir cuál es el propósito dominante y justificarlo.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Purpose and Audience$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Lo esencial
Ningún texto aparece porque sí. Cada uno se escribe con un **propósito** (lo que el autor quiere lograr) y para un **público** (las personas a las que se dirige). Entender ambas ideas es la base de la lectura crítica y aparece en casi todas las pruebas de Lengua y Literatura.

## Los propósitos más frecuentes
- **Informar:** dar datos de forma clara y objetiva, como en una noticia, un folleto o un informe.
- **Persuadir:** convencer al lector de pensar o hacer algo, como en un anuncio, un discurso o un artículo de opinión.
- **Entretener:** divertir o emocionar, como en un cuento, una novela, un cómic o un poema.
- **Instruir:** enseñar a hacer algo, como en una receta o un manual.
- **Expresar:** comunicar sentimientos o reflexiones, como en un diario personal o una carta íntima.
Un texto puede tener varios propósitos. Un anuncio, por ejemplo, informa sobre un producto, pero su fin principal es persuadir. Siempre debes decidir cuál domina.

## El público o destinatario
El público determina las decisiones del autor: el **registro** (formal o informal), el **vocabulario**, la **longitud** de las frases, los **ejemplos** y el **tono**. Para identificar al destinatario, busca pistas:
- Tratamiento: el «tú» cercano, el «usted» formal o el «vosotros» y «ustedes» de grupo.
- Vocabulario: sencillo, técnico, juvenil o especializado.
- Referencias: temas que interesan a cierta edad o profesión.
- Canal: periódico, red social, cartel, carta oficial.
Ejemplo inventado: «Estimado vecino: le comunicamos que el martes habrá un corte de agua» se dirige a adultos que no conocen al emisor; el «usted» y el verbo «comunicar» lo muestran.

## Cómo se relacionan propósito y público
Cuando cambia el público, el mismo mensaje cambia de forma. Una campaña para reciclar dirigida a niños de seis años usa frases cortas, personajes simpáticos y el tuteo. La misma campaña para el ayuntamiento incluiría cifras, plazos y un registro formal. El propósito (concienciar) no cambia, pero las decisiones lingüísticas sí.

## Cómo analizarlo en un examen
1. Lee el texto entero y fíjate en el título, el formato y el canal.
2. Pregúntate: «¿Qué quiere lograr el autor en el lector?»
3. Busca pruebas de lenguaje: imperativos y exclamaciones para persuadir; datos y fechas para informar; verbos en pasado e imágenes para narrar.
4. Escribe una respuesta con la estructura **afirmación, prueba, efecto**: «El propósito es persuadir; el imperativo “actúa hoy” urge al lector a participar.»

## Errores frecuentes
- **Describir en vez de analizar.** Contar de qué trata el texto no equivale a decir para qué se escribió.
- **Elegir un propósito sin pruebas.** Toda afirmación necesita una cita.
- **Ignorar el público.** Decir solo «es para todos» es débil; sé concreto: adolescentes, familias, vecinos, etc.
- **Confundir tema y propósito.** El tema es «el agua»; el propósito puede ser «convencer de ahorrarla».

## Cómo se evalúa
En la evaluación en pantalla se presentan dos o tres textos breves de géneros diferentes (un cartel, una carta, un artículo) y se pregunta qué propósito domina, a quién va dirigido y qué elecciones lo demuestran. Las preguntas finales piden comparar cómo un mismo tema se adapta a públicos distintos.

Exam tip: cuando te pidan el propósito, nómbralo con un verbo (informar, persuadir, entretener), cita una pista del texto y explica el efecto que produce en el destinatario.$mq$ from st;

-- Reading and Comprehension > Tone and Attitude
insert into public.topics (subject_id, name, grade, position)
select s.id, $mq$Reading and Comprehension$mq$, 5, 1 from public.subjects s where s.slug = $mq$spanish-language-and-literature$mq$
on conflict (subject_id, name, grade) do nothing;
insert into public.topics (subject_id, name, grade, parent_topic_id, position)
select p.subject_id, $mq$Tone and Attitude$mq$, 5, p.id, 3
from public.topics p join public.subjects s on s.id = p.subject_id
where s.slug = $mq$spanish-language-and-literature$mq$ and p.grade = 5 and p.name = $mq$Reading and Comprehension$mq$ and p.parent_topic_id is null
on conflict (subject_id, name, grade) do nothing;
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Tone and Attitude$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.questions (subject_id, topic_id, grade, type, content, options, answer, explanation, difficulty)
select st.subject_id, st.topic_id, 5, 'MCQ', v.content, v.options::jsonb, v.answer, v.explanation, v.difficulty
from st, (values
($mq$¿Qué es el tono de un texto?$mq$, $mq$["La actitud o el sentimiento que transmite el autor","La rima de los versos","El número de páginas","El tipo de letra"]$mq$, 0, $mq$El tono refleja cómo se siente el autor o cómo quiere que se sienta el lector: irónico, serio, esperanzado, etc.$mq$, $mq$easy$mq$),
($mq$¿Qué tono transmite la frase «¡Qué alegría volver a verte después de tanto tiempo!»?$mq$, $mq$["Amenazante","Indiferente","Resignado","Alegre y afectuoso"]$mq$, 3, $mq$La exclamación y la palabra «alegría» muestran entusiasmo.$mq$, $mq$easy$mq$),
($mq$¿Qué tono tiene «Nada podía hacerse; el invierno había vencido otra vez»?$mq$, $mq$["Burlón","Entusiasta","Resignado y sombrío","Orgulloso"]$mq$, 2, $mq$«Nada podía hacerse» expresa aceptación del fracaso, y «vencido» refuerza el ambiente triste.$mq$, $mq$easy$mq$),
($mq$¿Qué es la ironía?$mq$, $mq$["Repetir una palabra tres veces","Decir lo contrario de lo que se piensa para criticar o burlarse","Describir un color","Resumir un texto"]$mq$, 1, $mq$La ironía dice una cosa para dar a entender la contraria, a menudo con intención crítica.$mq$, $mq$easy$mq$),
($mq$¿Cuál de estas palabras es de connotación positiva?$mq$, $mq$["Valiente","Temerario","Obstinado","Soberbio"]$mq$, 0, $mq$Valiente suele connotar admiración; las otras tres suelen implicar defectos.$mq$, $mq$easy$mq$),
($mq$Extracto inventado: «Qué estupendo plan: tres horas de cola para ver una pared pintada.» ¿Qué tono domina?$mq$, $mq$["Entusiasta","Neutral y objetivo","Nostálgico","Irónico"]$mq$, 3, $mq$«Qué estupendo plan» se dice con intención contraria, pues la situación descrita es molesta.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Recordaba el patio de su abuela, el olor a jazmín, las tardes interminables… y sentía un nudo en la garganta.» ¿Qué tono predomina?$mq$, $mq$["Furioso","Humorístico","Nostálgico","Científico"]$mq$, 2, $mq$Los recuerdos agradables del pasado y el nudo en la garganta muestran añoranza.$mq$, $mq$medium$mq$),
($mq$¿Qué efecto tiene el cambio de «dijo» a «espetó» en «—Cállate —espetó Luis»?$mq$, $mq$["Indica alegría","Transmite brusquedad y enfado","Transmite neutralidad total","Muestra timidez"]$mq$, 1, $mq$El verbo «espetar» implica decir algo de manera brusca, por lo que cambia la actitud del hablante.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «El alcalde, con su habitual modestia, inauguró la fuente que lleva su propio nombre.» ¿Qué actitud del narrador se percibe?$mq$, $mq$["Crítica irónica hacia el alcalde","Admiración sincera","Indiferencia","Compasión"]$mq$, 0, $mq$«Habitual modestia» contrasta con poner su nombre a la fuente: el contraste revela ironía.$mq$, $mq$medium$mq$),
($mq$¿Qué diferencia hay entre tono y estado de ánimo (ambiente)?$mq$, $mq$["Son exactamente lo mismo","El tono lo elige el lector","El ambiente solo existe en poesía","El tono es la actitud del autor; el ambiente es el sentimiento que el texto provoca en el lector"]$mq$, 3, $mq$El tono viene del autor o narrador; el ambiente es la atmósfera emocional que se crea.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Los resultados fueron los esperados: setenta y dos inscripciones, doce bajas, un informe.» ¿Qué tono tiene?$mq$, $mq$["Apasionado","Burlón","Neutral y objetivo","Misterioso"]$mq$, 2, $mq$Presenta datos sin adjetivos ni exclamaciones: es un tono neutro e informativo.$mq$, $mq$medium$mq$),
($mq$¿Qué recurso aumenta más claramente el tono urgente de «Ahora. Ya. No mañana.»?$mq$, $mq$["Una descripción larga","Frases muy breves y repetición del mismo sentido","Un vocabulario técnico","Una cita literaria"]$mq$, 1, $mq$Las frases cortas marcan un ritmo apremiante que refuerza la urgencia.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Aunque la lluvia arreciaba, Elena sonrió: tarde o temprano, el sol volvería.» ¿Qué actitud transmite?$mq$, $mq$["Optimismo","Desesperación","Burla","Indiferencia"]$mq$, 0, $mq$La sonrisa y la confianza en el sol que volverá muestran esperanza.$mq$, $mq$medium$mq$),
($mq$Extracto inventado: «Se marchó sin despedirse, como quien cierra una puerta que ya no volverá a abrir.» ¿Qué tono combina la comparación y el verbo «marchó»?$mq$, $mq$["Humorístico y ligero","Entusiasta y expectante","Técnico y neutro","Melancólico y definitivo"]$mq$, 3, $mq$La comparación de la puerta cerrada para siempre añade finalidad y tristeza.$mq$, $mq$hard$mq$),
($mq$Extracto inventado: «Gracias, queridísima Marta, por recordarme tan amablemente que hoy no me tocaba fregar.» Si el contexto es una discusión, ¿qué tono y qué pista lo confirman?$mq$, $mq$["Sincero; el superlativo muestra cariño","Neutral; es una simple frase","Sarcástico; los superlativos y «tan amablemente» exageran la cortesía","Triste; hay una despedida"]$mq$, 2, $mq$El exceso de cortesía en una discusión revela que el hablante dice lo contrario de lo que siente.$mq$, $mq$hard$mq$),
($mq$Dos reseñas del mismo restaurante: A «Un local honesto, sin pretensiones» y B «Un local mediocre y sin ambición». ¿Qué explica la diferencia?$mq$, $mq$["Describen locales distintos","Las connotaciones: «honesto, sin pretensiones» es positivo; «mediocre, sin ambición» es negativo","La primera es objetiva y la segunda es poética","No hay diferencia de actitud"]$mq$, 1, $mq$Describen casi lo mismo, pero las palabras elegidas orientan la valoración.$mq$, $mq$hard$mq$),
($mq$Un narrador describe a un ladrón con la frase «aquel caballero de dedos ágiles». ¿Qué efecto produce el contraste?$mq$, $mq$["Un tono humorístico o irónico que suaviza y critica a la vez","Un tono solemne y reverente","Un tono puramente informativo","Un tono de terror"]$mq$, 0, $mq$Llamar «caballero» a un ladrón crea ironía; la expresión «dedos ágiles» alude al robo.$mq$, $mq$hard$mq$),
($mq$Para analizar el tono en un examen, ¿qué respuesta es la más sólida?$mq$, $mq$["El tono es bueno","El tono es feliz porque sí","El tono es como el de ayer","El tono es esperanzado: «el sol volvería» y la sonrisa de Elena contrastan con la lluvia y muestran confianza"]$mq$, 3, $mq$Una respuesta fuerte nombra el tono con precisión, cita el texto y explica el efecto.$mq$, $mq$hard$mq$)
) as v(content, options, answer, explanation, difficulty);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Tone and Attitude$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.flashcards (subject_id, topic_id, grade, front, back)
select st.subject_id, st.topic_id, 5, v.front, v.back
from st, (values
($mq$Tono$mq$, $mq$La actitud del autor o narrador hacia el tema o el lector: alegre, irónico, nostálgico, neutro, etc. Se crea con el lenguaje.$mq$),
($mq$Ambiente o atmósfera$mq$, $mq$El sentimiento que el texto provoca en el lector. No es lo mismo que el tono, que es la actitud del autor.$mq$),
($mq$Denotación y connotación$mq$, $mq$Denotación: significado literal de una palabra. Connotación: valor emocional asociado (positivo, negativo o neutro).$mq$),
($mq$Ironía$mq$, $mq$Decir lo contrario de lo que se piensa para criticar o burlarse. Pista: un elogio que choca con la situación descrita.$mq$),
($mq$Sarcasmo$mq$, $mq$Ironía cruel o mordaz, a menudo con exageración de cortesía, dicha para herir o ridiculizar.$mq$),
($mq$Verbos de habla y tono$mq$, $mq$«Susurró», «espetó» o «suplicó» revelan la actitud del hablante mucho más que «dijo».$mq$),
($mq$Tono nostálgico: pistas$mq$, $mq$Recuerdos sensoriales, pasado en imperfecto y palabras de añoranza, como «aquellos años» o «ya no».$mq$),
($mq$Método para analizar el tono$mq$, $mq$Subrayar palabras con carga emocional, nombrar un tono preciso y explicar su efecto con una cita breve.$mq$),
($mq$Cambio de tono$mq$, $mq$Cuando el texto pasa, por ejemplo, del humor a la gravedad. Hay que indicarlo y explicar qué lo provoca.$mq$)
) as v(front, back);
with st as (select t.id as topic_id, t.subject_id from public.topics t
    join public.subjects s on s.id = t.subject_id
    join public.topics p on p.id = t.parent_topic_id
    where s.slug = $mq$spanish-language-and-literature$mq$ and t.grade = 5 and t.name = $mq$Tone and Attitude$mq$ and p.name = $mq$Reading and Comprehension$mq$
      and not exists (select 1 from public.notes n where n.topic_id = t.id))
insert into public.notes (topic_id, content) select st.topic_id, $mq$## Lo esencial
El **tono** es la actitud que el autor o el narrador muestra hacia el tema, hacia los personajes o hacia el lector. Puede ser alegre, irónico, grave, esperanzado, nostálgico, sarcástico o neutro. Se distingue del **ambiente** (también llamado atmósfera), que es el sentimiento que el texto provoca en quien lee. Muchas preguntas de examen piden identificar el tono y explicar con qué palabras se consigue.

## Cómo se crea el tono
El tono no se declara: se construye con las decisiones del autor. Estas son las principales herramientas:
- **Elección de palabras (léxico):** no es lo mismo «delgado» que «flaco», ni «decidido» que «terco». Cada término lleva una **connotación** positiva, negativa o neutra, además de su **denotación**, que es su significado literal.
- **Verbos de habla:** «dijo», «susurró», «espetó» o «suplicó» cambian por completo la lectura de un diálogo.
- **Estructura de las frases:** frases cortas dan urgencia o tensión; frases largas con enumeraciones dan calma, nostalgia o agobio.
- **Puntuación:** exclamaciones, puntos suspensivos y preguntas retóricas añaden emoción.
- **Recursos literarios:** comparaciones, metáforas e ironía matizan la actitud.

## Algunos tonos y cómo reconocerlos
- **Irónico o sarcástico:** se dice lo contrario de lo que se piensa. Pista: un elogio que choca con la realidad. Ejemplo: «Qué estupendo plan: tres horas de cola para ver una pared pintada.»
- **Nostálgico:** añoranza del pasado, con recuerdos sensoriales y verbos en imperfecto.
- **Optimista:** confianza en el futuro. Palabras como «esperanza», «pronto», «seguro».
- **Sombrío o melancólico:** vocabulario de pérdida, oscuridad o final.
- **Neutro u objetivo:** datos sin adjetivos valorativos, común en informes o noticias.
- **Humorístico:** exageraciones, contrastes y juegos de palabras.

## Un método en tres pasos
1. **Subraya** las palabras con carga emocional (adjetivos, verbos, adverbios).
2. **Nombra** el tono con un adjetivo preciso, no con «bueno» o «malo». «Esperanzado» es mejor que «positivo».
3. **Explica** el efecto: «El adverbio “tan amablemente” exagera la cortesía y revela sarcasmo, porque el contexto es una discusión.»
Ejemplo inventado: «Se marchó sin despedirse, como quien cierra una puerta que ya no volverá a abrir.» El tono es melancólico y definitivo: la comparación sugiere un final sin vuelta atrás.

## Cambios de tono
Un texto puede empezar con humor y terminar con gravedad. Cuando notes un cambio, indícalo y explica qué lo provoca. Estos cambios suelen marcar un momento clave del relato o del argumento.

## Errores frecuentes
- **Confundir tono con tema.** El tema es de qué trata; el tono es cómo se trata.
- **Usar etiquetas vagas.** «Triste» sirve, pero «resignado» o «desolado» son más precisos.
- **Olvidar la prueba.** Sin cita no hay análisis.
- **No distinguir autor y personaje.** Un personaje puede ser cruel mientras el narrador lo juzga con ironía.
- **Pasar por alto la ironía.** Si el elogio no encaja con los hechos, sospecha.

## Cómo se evalúa
En la evaluación en pantalla se muestra un extracto breve y se pregunta qué tono domina, qué palabras lo crean o cómo cambia entre el inicio y el final. Las respuestas con mejor nivel combinan un adjetivo exacto, una cita breve y una explicación del efecto en el lector.

Exam tip: nombra el tono con un adjetivo preciso, cita dos o tres palabras concretas que lo crean y explica qué sentimiento provocan en el lector.$mq$ from st;

commit;

select s.name as subject, p.name as topic, count(distinct t.id) as sub_topics,
  count(distinct n.topic_id) as with_notes
from public.topics p join public.subjects s on s.id = p.subject_id and s.slug in ('spanish-language-and-literature')
join public.topics t on t.parent_topic_id = p.id left join public.notes n on n.topic_id = t.id
where p.grade = 5 and p.parent_topic_id is null group by s.name, p.name, p.position order by s.name, p.position;