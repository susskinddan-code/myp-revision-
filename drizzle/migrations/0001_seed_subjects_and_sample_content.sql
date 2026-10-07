insert into public.subjects (slug, name, subject_group, group_key, grades, description, position) values
('physics','Physics','Sciences','sciences','{1,2,3,4,5}','Forces, energy, waves, electricity and the physical rules behind everyday life.',1),
('chemistry','Chemistry','Sciences','sciences','{1,2,3,4,5}','Matter, atoms, reactions and the language of chemical change.',2),
('biology','Biology','Sciences','sciences','{1,2,3,4,5}','Cells, systems, genetics and ecosystems across living things.',3),
('environmental-systems','Environmental Systems','Sciences','sciences','{1,2,3,4,5}','Ecosystems, sustainability and human impact on the planet.',4),
('integrated-science','Integrated Science','Sciences','sciences','{1,2,3}','Combined science skills for the early MYP years.',5),
('standard-mathematics','Standard Mathematics','Mathematics','mathematics','{1,2,3,4,5}','Number, algebra, geometry, statistics and probability.',6),
('extended-mathematics','Extended Mathematics','Mathematics','mathematics','{4,5}','Deeper algebra, functions and proof for extended learners.',7),
('english-language-literature','English Language & Literature','Language & Literature','language-literature','{1,2,3,4,5}','Reading, analysis and writing across texts and media.',8),
('french-language-literature','French Language & Literature','Language & Literature','language-literature','{1,2,3,4,5}','Literary study and writing in French.',9),
('spanish-language-literature','Spanish Language & Literature','Language & Literature','language-literature','{1,2,3,4,5}','Literary study and writing in Spanish.',10),
('french-ab-initio','French ab initio','Language Acquisition','language-acquisition','{1,2,3,4,5}','Beginner French vocabulary, grammar and communication.',11),
('spanish-ab-initio','Spanish ab initio','Language Acquisition','language-acquisition','{1,2,3,4,5}','Beginner Spanish vocabulary, grammar and communication.',12),
('mandarin-ab-initio','Mandarin ab initio','Language Acquisition','language-acquisition','{1,2,3,4,5}','Beginner Mandarin characters, tones and communication.',13),
('history','History','Individuals & Societies','individuals-societies','{1,2,3,4,5}','Sources, causation and significance across world history.',14),
('geography','Geography','Individuals & Societies','individuals-societies','{1,2,3,4,5}','Physical and human geography, maps and fieldwork.',15),
('economics','Economics','Individuals & Societies','individuals-societies','{3,4,5}','Markets, scarcity, trade and economic decision making.',16),
('visual-arts','Visual Arts','Arts','arts','{1,2,3,4,5}','Studio practice, art history and visual analysis.',17),
('music','Music','Arts','arts','{1,2,3,4,5}','Theory, listening, performance and composition.',18),
('drama','Drama','Arts','arts','{1,2,3,4,5}','Performance skills, theatre history and devising.',19),
('product-design','Product Design','Design','design','{1,2,3,4,5}','The design cycle applied to physical products.',20),
('digital-design','Digital Design','Design','design','{1,2,3,4,5}','Digital products, interfaces and the design cycle.',21),
('physical-health-education','Physical & Health Education','Physical & Health Education','physical-health','{1,2,3,4,5}','Movement, training, health and wellbeing.',22);

insert into public.topics (subject_id, name, grade, description, position)
select s.id, t.name, t.grade, t.description, t.position
from (values
  ('physics','Forces and Motion',4,'Balanced and unbalanced forces, speed, acceleration and Newton''s laws.',1),
  ('physics','Energy Transfers',4,'Kinetic and potential energy, conservation and efficiency.',2),
  ('physics','Electricity and Circuits',4,'Current, voltage, resistance and series and parallel circuits.',3),
  ('physics','Waves and Sound',4,'Wave properties, reflection, refraction and how sound travels.',4),
  ('physics','Forces and Motion',5,'Momentum, resultant forces and motion graphs.',1),
  ('physics','Electromagnetism',5,'Magnetic fields, electromagnets and induction.',2),
  ('chemistry','Atomic Structure',4,'Protons, neutrons, electrons and the periodic table.',1),
  ('chemistry','Chemical Reactions',4,'Reactants, products, word equations and conservation of mass.',2),
  ('chemistry','Acids and Bases',4,'The pH scale, indicators and neutralisation.',3),
  ('chemistry','States of Matter',4,'Particle model, changes of state and diffusion.',4),
  ('biology','Cells and Organisation',4,'Cell structures, specialised cells, tissues and organs.',1),
  ('biology','Human Body Systems',4,'Circulatory, respiratory and digestive systems.',2),
  ('biology','Ecosystems',4,'Food chains, energy flow and interdependence.',3),
  ('biology','Genetics and Inheritance',4,'DNA, genes, chromosomes and simple inheritance.',4),
  ('standard-mathematics','Algebraic Expressions',4,'Simplifying, expanding and factorising expressions.',1),
  ('standard-mathematics','Linear Equations',4,'Solving equations and using them to model situations.',2),
  ('standard-mathematics','Geometry and Angles',4,'Angle rules, triangles, polygons and constructions.',3),
  ('standard-mathematics','Statistics and Probability',4,'Averages, spread, charts and simple probability.',4),
  ('history','Causes of Conflict',4,'Long-term and short-term causes, triggers and consequences.',1),
  ('history','Working with Sources',4,'Origin, purpose, value and limitations of sources.',2),
  ('geography','Population and Migration',4,'Population structure, push and pull factors and urbanisation.',1),
  ('geography','Natural Hazards',4,'Tectonic and climatic hazards, risk and response.',2),
  ('english-language-literature','Analysing Prose',4,'Narrative voice, structure and language techniques.',1),
  ('english-language-literature','Persuasive Writing',4,'Audience, purpose, rhetoric and structure.',2),
  ('visual-arts','Elements and Principles',4,'Line, shape, colour, balance and composition.',1),
  ('product-design','The Design Cycle',4,'Inquiry, developing ideas, creating the solution and evaluating.',1),
  ('digital-design','User Interface Basics',4,'Usability, hierarchy, accessibility and prototyping.',1),
  ('physical-health-education','Training and Fitness',4,'Components of fitness, training principles and recovery.',1),
  ('french-ab-initio','Everyday Vocabulary',4,'School, family, food and daily routine vocabulary.',1),
  ('music','Elements of Music',4,'Pitch, rhythm, dynamics, texture and form.',1)
) as t(subject_slug, name, grade, description, position)
join public.subjects s on s.slug = t.subject_slug;

insert into public.questions (subject_id, topic_id, grade, content, options, answer, explanation, mark_scheme, difficulty)
select tp.subject_id, tp.id, tp.grade, q.content, q.options::jsonb, q.answer, q.explanation, q.mark_scheme, q.difficulty
from (values
  ('physics','Forces and Motion',4,'A box sits still on a table. What can you say about the forces acting on it?','["The forces are balanced","There are no forces acting","Gravity is switched off","The upward force is larger"]',0,'When an object is stationary the resultant force is zero, so the forces are balanced.','Level 3-4: identifies balanced forces. Level 5-6: explains resultant force is zero. Level 7-8: links to Newton''s First Law.','easy'),
  ('physics','Forces and Motion',4,'A car travels 120 m in 8 s. What is its average speed?','["12 m/s","15 m/s","20 m/s","960 m/s"]',1,'Speed = distance / time = 120 / 8 = 15 m/s.','Level 3-4: correct formula. Level 5-6: correct substitution. Level 7-8: correct value with units.','easy'),
  ('physics','Forces and Motion',4,'Which statement best describes Newton''s Third Law?','["Objects keep moving unless a force acts","Force equals mass times acceleration","Every action has an equal and opposite reaction","Heavier objects always fall faster"]',2,'Newton''s Third Law states forces act in equal and opposite pairs on different objects.','Level 5-6: states the law. Level 7-8: applies it to a named pair of forces.','medium'),
  ('physics','Energy Transfers',4,'A ball is dropped from a height. Which energy transfer happens as it falls?','["Kinetic to gravitational potential","Gravitational potential to kinetic","Chemical to thermal","Elastic to nuclear"]',1,'As height decreases, gravitational potential energy is transferred into kinetic energy.','Level 5-6: names both stores. Level 7-8: refers to conservation of energy.','easy'),
  ('physics','Energy Transfers',4,'A lamp is 20% efficient. If 100 J of electrical energy is supplied, how much is usefully transferred to light?','["10 J","20 J","80 J","100 J"]',1,'Efficiency 20% of 100 J = 20 J transferred usefully; the rest is dissipated as heat.','Level 5-6: correct calculation. Level 7-8: explains wasted energy as thermal.','medium'),
  ('physics','Electricity and Circuits',4,'In a series circuit with two identical bulbs, what happens to the current through each bulb?','["It is the same through both","It is larger in the first bulb","It is larger in the second bulb","It is zero in the second bulb"]',0,'Current is the same at every point in a series circuit.','Level 5-6: states current is constant. Level 7-8: justifies using charge conservation.','medium'),
  ('physics','Waves and Sound',4,'Which property of a sound wave determines how loud it sounds?','["Frequency","Wavelength","Amplitude","Speed"]',2,'Larger amplitude means more energy carried, which the ear detects as a louder sound.','Level 3-4: names amplitude. Level 7-8: links amplitude to energy.','easy'),
  ('chemistry','Atomic Structure',4,'An atom has 11 protons and 12 neutrons. What is its mass number?','["11","12","23","1"]',2,'Mass number = protons + neutrons = 11 + 12 = 23.','Level 3-4: recalls the definition. Level 5-6: correct calculation.','easy'),
  ('chemistry','Atomic Structure',4,'Which subatomic particle has a negative charge?','["Proton","Neutron","Electron","Nucleus"]',2,'Electrons carry a negative charge and orbit the nucleus.','Level 3-4: correct identification.','easy'),
  ('chemistry','Chemical Reactions',4,'In a sealed container, 10 g of magnesium reacts with 6 g of oxygen. What is the total mass of product?','["4 g","10 g","16 g","60 g"]',2,'Mass is conserved, so 10 g + 6 g = 16 g of magnesium oxide.','Level 5-6: applies conservation of mass. Level 7-8: explains with particle rearrangement.','medium'),
  ('chemistry','Acids and Bases',4,'A solution has a pH of 2. What is it?','["A strong alkali","A weak alkali","Neutral","A strong acid"]',3,'pH values well below 7 indicate a strongly acidic solution.','Level 3-4: identifies acid. Level 5-6: refers to the pH scale.','easy'),
  ('chemistry','States of Matter',4,'Why can gases be compressed much more easily than liquids?','["Gas particles are smaller","Gas particles have large gaps between them","Gas particles are heavier","Gas particles do not move"]',1,'In gases the particles are far apart, so the volume can be reduced considerably.','Level 5-6: refers to particle spacing. Level 7-8: compares with liquid arrangement.','medium'),
  ('biology','Cells and Organisation',4,'Which structure is found in a plant cell but not an animal cell?','["Nucleus","Cell membrane","Chloroplast","Mitochondrion"]',2,'Chloroplasts carry out photosynthesis and are only found in plant cells.','Level 3-4: identifies chloroplast. Level 7-8: links structure to function.','easy'),
  ('biology','Human Body Systems',4,'Which blood vessel carries blood away from the heart?','["Vein","Artery","Capillary","Alveolus"]',1,'Arteries carry blood away from the heart, usually at high pressure.','Level 3-4: correct vessel. Level 5-6: refers to pressure or direction.','easy'),
  ('biology','Ecosystems',4,'In the food chain grass to rabbit to fox, what is the rabbit?','["Producer","Primary consumer","Secondary consumer","Decomposer"]',1,'The rabbit eats the producer, so it is the primary consumer.','Level 3-4: correct term. Level 7-8: explains energy transfer between levels.','easy'),
  ('biology','Genetics and Inheritance',4,'Where in a cell is most genetic information stored?','["Cytoplasm","Nucleus","Cell wall","Ribosome"]',1,'DNA is packaged into chromosomes inside the nucleus.','Level 3-4: identifies nucleus. Level 5-6: refers to chromosomes or DNA.','easy'),
  ('standard-mathematics','Algebraic Expressions',4,'Simplify 5x + 3x - 2x.','["6x","10x","6","8x"]',0,'Collect like terms: 5x + 3x - 2x = 6x.','Level 3-4: collects like terms. Level 5-6: fully simplified answer.','easy'),
  ('standard-mathematics','Algebraic Expressions',4,'Expand 3(2x + 4).','["6x + 4","5x + 7","6x + 12","2x + 12"]',2,'Multiply each term inside the bracket by 3: 6x + 12.','Level 5-6: correct expansion of both terms.','easy'),
  ('standard-mathematics','Linear Equations',4,'Solve 4x - 7 = 21.','["x = 3.5","x = 7","x = 14","x = 28"]',1,'Add 7 to both sides to get 4x = 28, then divide by 4 so x = 7.','Level 5-6: correct inverse operations. Level 7-8: checks the solution.','medium'),
  ('standard-mathematics','Geometry and Angles',4,'What is the sum of the interior angles of a pentagon?','["360 degrees","450 degrees","540 degrees","720 degrees"]',2,'(n - 2) x 180 = (5 - 2) x 180 = 540 degrees.','Level 5-6: uses the formula. Level 7-8: justifies with triangles.','medium'),
  ('standard-mathematics','Statistics and Probability',4,'A fair six-sided dice is rolled. What is the probability of rolling an even number?','["1/6","1/3","1/2","2/3"]',2,'Three of the six outcomes are even, so the probability is 3/6 = 1/2.','Level 5-6: correct probability as a fraction.','easy'),
  ('history','Causes of Conflict',4,'Which of these is best described as a short-term trigger rather than a long-term cause?','["A long-standing alliance system","An assassination of a political leader","Decades of economic rivalry","Ongoing colonial competition"]',1,'A single dramatic event such as an assassination acts as a trigger for conflict already building.','Level 5-6: distinguishes trigger and long-term cause. Level 7-8: explains the relationship between them.','medium'),
  ('history','Working with Sources',4,'A diary written by a soldier during a battle is most valuable to a historian as evidence of what?','["Objective battle statistics","Personal experience and attitudes at the time","Government policy decisions","Long-term economic effects"]',1,'A diary gives first-hand insight into experience and attitudes, though it is limited in scope.','Level 5-6: identifies value. Level 7-8: also evaluates limitations.','medium'),
  ('geography','Population and Migration',4,'Which of these is a push factor for migration?','["Better job opportunities","Political persecution","Good healthcare","Family already settled abroad"]',1,'Push factors drive people away from an area; persecution is a classic example.','Level 3-4: identifies push factor. Level 7-8: contrasts with pull factors.','easy'),
  ('geography','Natural Hazards',4,'Earthquakes are most commonly found in which location?','["The centre of tectonic plates","Along plate boundaries","Only near the equator","Only in deserts"]',1,'Most earthquakes occur where plates meet and stress is released.','Level 5-6: refers to plate boundaries. Level 7-8: names a boundary type.','easy'),
  ('english-language-literature','Analysing Prose',4,'A story told using "I" and "my" is written in which narrative voice?','["First person","Second person","Third person limited","Third person omniscient"]',0,'First person narration uses I/my and gives direct access to one character''s viewpoint.','Level 3-4: identifies the voice. Level 7-8: comments on its effect on the reader.','easy'),
  ('english-language-literature','Persuasive Writing',4,'Which technique is being used in: "We must act now, before it is too late"?','["Simile","Rhetorical question","Urgency through imperative","Alliteration"]',2,'The imperative "must act now" creates urgency and pressures the reader to respond.','Level 5-6: names the technique. Level 7-8: explains the effect on audience.','medium'),
  ('visual-arts','Elements and Principles',4,'Which principle describes the even distribution of visual weight in an artwork?','["Contrast","Balance","Texture","Hue"]',1,'Balance is the arrangement of elements so no part overwhelms the rest.','Level 3-4: names balance. Level 7-8: applies it to a specific artwork.','easy'),
  ('product-design','The Design Cycle',4,'Which stage of the MYP design cycle comes immediately after developing ideas?','["Inquiring and analysing","Creating the solution","Evaluating","Researching"]',1,'The cycle runs inquiring and analysing, developing ideas, creating the solution, then evaluating.','Level 3-4: correct order recall.','easy'),
  ('digital-design','User Interface Basics',4,'Why is strong colour contrast important in an interface?','["It makes files smaller","It helps users with low vision read content","It speeds up the internet","It removes the need for headings"]',1,'Sufficient contrast keeps text legible for users with low vision and in bright conditions.','Level 5-6: links contrast to accessibility. Level 7-8: references a guideline or user group.','medium'),
  ('physical-health-education','Training and Fitness',4,'What does the principle of progressive overload mean?','["Training at the same level every week","Gradually increasing training demand over time","Training only once a month","Avoiding rest days completely"]',1,'Progressive overload means gradually increasing intensity, duration or frequency so the body adapts.','Level 5-6: defines the principle. Level 7-8: applies it to a training plan.','medium'),
  ('music','Elements of Music',4,'Which element of music describes how loud or soft the music is?','["Tempo","Dynamics","Timbre","Pitch"]',1,'Dynamics describe volume, from pianissimo to fortissimo.','Level 3-4: names dynamics.','easy'),
  ('french-ab-initio','Everyday Vocabulary',4,'What does "la salle de classe" mean in English?','["The dining hall","The classroom","The library","The playground"]',1,'"La salle de classe" translates as the classroom.','Level 3-4: correct translation.','easy')
) as q(subject_slug, topic_name, grade, content, options, answer, explanation, mark_scheme, difficulty)
join public.subjects s on s.slug = q.subject_slug
join public.topics tp on tp.subject_id = s.id and tp.name = q.topic_name and tp.grade = q.grade;

insert into public.flashcards (subject_id, topic_id, grade, front, back)
select tp.subject_id, tp.id, tp.grade, f.front, f.back
from (values
  ('physics','Forces and Motion',4,'What is a resultant force?','The single force that has the same effect as all the forces acting on an object combined.'),
  ('physics','Forces and Motion',4,'State Newton''s First Law.','An object stays at rest or moves at constant velocity unless acted on by a resultant force.'),
  ('physics','Energy Transfers',4,'What does conservation of energy mean?','Energy cannot be created or destroyed, only transferred between stores.'),
  ('physics','Electricity and Circuits',4,'What does an ammeter measure?','Electric current, in amperes, and it is connected in series.'),
  ('physics','Waves and Sound',4,'What is frequency?','The number of complete waves passing a point each second, measured in hertz.'),
  ('chemistry','Atomic Structure',4,'What is the atomic number of an element?','The number of protons in the nucleus of one of its atoms.'),
  ('chemistry','Chemical Reactions',4,'What is a word equation?','A way of writing a reaction using the names of reactants and products, e.g. magnesium + oxygen = magnesium oxide.'),
  ('chemistry','Acids and Bases',4,'What is neutralisation?','A reaction between an acid and a base that produces a salt and water.'),
  ('chemistry','States of Matter',4,'What is diffusion?','The spreading of particles from a high concentration to a low concentration.'),
  ('biology','Cells and Organisation',4,'What is the function of the mitochondria?','They release energy from glucose during aerobic respiration.'),
  ('biology','Human Body Systems',4,'What is the role of red blood cells?','They carry oxygen around the body using haemoglobin.'),
  ('biology','Ecosystems',4,'What is a producer?','An organism, usually a plant, that makes its own food by photosynthesis.'),
  ('biology','Genetics and Inheritance',4,'What is a gene?','A section of DNA that codes for a particular characteristic or protein.'),
  ('standard-mathematics','Algebraic Expressions',4,'What are like terms?','Terms with exactly the same variable part, such as 3x and 5x, which can be added or subtracted.'),
  ('standard-mathematics','Linear Equations',4,'How do you check a solution to an equation?','Substitute the value back into the original equation and confirm both sides are equal.'),
  ('standard-mathematics','Geometry and Angles',4,'What do angles on a straight line add up to?','180 degrees.'),
  ('standard-mathematics','Statistics and Probability',4,'What is the median?','The middle value when the data is placed in order.'),
  ('history','Working with Sources',4,'What does OPVL stand for?','Origin, Purpose, Value and Limitation - a framework for evaluating sources.'),
  ('geography','Population and Migration',4,'What is urbanisation?','The increasing proportion of a population living in towns and cities.'),
  ('geography','Natural Hazards',4,'What is a natural hazard?','A natural event that has the potential to cause harm to people or property.'),
  ('english-language-literature','Persuasive Writing',4,'What is ethos in persuasive writing?','An appeal to the credibility or authority of the speaker or writer.'),
  ('visual-arts','Elements and Principles',4,'Name three elements of art.','Line, shape and colour (also form, value, space and texture).'),
  ('product-design','The Design Cycle',4,'Name the four stages of the MYP design cycle.','Inquiring and analysing, developing ideas, creating the solution, evaluating.'),
  ('digital-design','User Interface Basics',4,'What is visual hierarchy?','Arranging elements so the most important information is noticed first.'),
  ('physical-health-education','Training and Fitness',4,'What does FITT stand for?','Frequency, Intensity, Time and Type - the variables in a training programme.'),
  ('music','Elements of Music',4,'What is timbre?','The characteristic tone colour of an instrument or voice.'),
  ('french-ab-initio','Everyday Vocabulary',4,'How do you say "I have breakfast" in French?','Je prends le petit-dejeuner.')
) as f(subject_slug, topic_name, grade, front, back)
join public.subjects s on s.slug = f.subject_slug
join public.topics tp on tp.subject_id = s.id and tp.name = f.topic_name and tp.grade = f.grade;

insert into public.notes (topic_id, content)
select tp.id, n.content
from (values
  ('physics','Forces and Motion',4,'A force is a push or a pull measured in newtons. Forces change the speed, direction or shape of an object. When several forces act at once, the single force with the same overall effect is the resultant force. If the resultant force is zero the forces are balanced: a stationary object stays still and a moving object keeps a constant velocity. This is Newton''s First Law. When the resultant force is not zero the object accelerates in the direction of that force. Newton''s Second Law links these quantities as force equals mass times acceleration, so the same force produces less acceleration on a heavier object. Newton''s Third Law reminds us that forces come in pairs: if you push on a wall, the wall pushes back on you with an equal force in the opposite direction. Speed is distance divided by time, and average speed smooths out changes over a journey. Distance-time graphs show speed as the gradient, with a horizontal line meaning the object is at rest. Velocity-time graphs show acceleration as the gradient and distance travelled as the area beneath the line. When answering MYP questions, state the rule, substitute the numbers with units and then comment on what the answer means in context.'),
  ('biology','Cells and Organisation',4,'All living things are made of cells. Animal cells contain a nucleus that holds the genetic material, cytoplasm where reactions take place, a cell membrane that controls what enters and leaves, and mitochondria that release energy through respiration. Plant cells contain all of these plus a rigid cellulose cell wall for support, a permanent vacuole filled with cell sap, and chloroplasts containing chlorophyll for photosynthesis. Cells become specialised to do particular jobs. Red blood cells lose their nucleus and take on a biconcave shape to carry as much oxygen as possible. Root hair cells have a long extension that increases surface area for absorbing water and minerals. Nerve cells are long and thin to carry electrical impulses over distance. Specialised cells of the same type group together into tissues, tissues form organs, and organs work together as organ systems such as the circulatory or digestive system. This hierarchy - cell, tissue, organ, organ system, organism - is the backbone of many MYP Criterion A questions, so be ready to give a clear example at each level and to explain how a structure is adapted to its function.')
) as n(subject_slug, topic_name, grade, content)
join public.subjects s on s.slug = n.subject_slug
join public.topics tp on tp.subject_id = s.id and tp.name = n.topic_name and tp.grade = n.grade;