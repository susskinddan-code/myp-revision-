-- Biology MYP 5: consolidate 19 empty headings to 13 topics and add 40 sub-topics.
-- Source: .lovable/plan/biology-myp-5-sub-topic-breakdown-for-review-2026-09-16.md
-- Idempotent and name-based (no hard-coded ids). NOT YET APPLIED to the live database.
-- Run in the Supabase SQL editor, then check the Biology MYP 5 topic list in the app.

-- 1. Remove the six short legacy headings at MYP 5 only, and only if they hold nothing.
DELETE FROM public.topics t
USING public.subjects s
WHERE t.subject_id = s.id AND s.slug = 'biology' AND t.grade = 5
  AND t.name IN ('Cell Structure', 'Genetics', 'Evolution', 'Ecology', 'Human Physiology', 'Biodiversity')
  AND NOT EXISTS (SELECT 1 FROM public.questions x WHERE x.topic_id = t.id)
  AND NOT EXISTS (SELECT 1 FROM public.notes x WHERE x.topic_id = t.id)
  AND NOT EXISTS (SELECT 1 FROM public.flashcards x WHERE x.topic_id = t.id)
  AND NOT EXISTS (SELECT 1 FROM public.topics c WHERE c.parent_topic_id = t.id);

-- 2. Make sure the 13 parent topics exist (existing headings are left untouched).
INSERT INTO public.topics (subject_id, name, grade, position)
SELECT s.id, v.name, 5, v.pos
FROM public.subjects s,
(VALUES
('Cells and Cell Processes',1),
('Cell Division',2),
('Photosynthesis and Respiration',3),
('Genetics and Inheritance',4),
('Evolution and Natural Selection',5),
('Ecosystems and Food Chains',6),
('Human Body Systems',7),
('Disease and Immunity',8),
('Plant Biology',9),
('Microbiology',10),
('Biotechnology',11),
('Biodiversity and Classification',12),
('Reproduction and Development',13)
) AS v(name, pos)
WHERE s.slug = 'biology'
ON CONFLICT (subject_id, name, grade) DO NOTHING;

-- 3. Insert the 40 sub-topics under their parents.
INSERT INTO public.topics (subject_id, name, grade, parent_topic_id, position)
SELECT p.subject_id, v.name, 5, p.id, v.pos
FROM (VALUES
('Cells and Cell Processes','Cell Structure and Ultrastructure',1),
('Cells and Cell Processes','Movement In and Out of Cells',2),
('Cells and Cell Processes','Specialised Cells and Levels of Organisation',3),
('Cell Division','Mitosis and the Cell Cycle',1),
('Cell Division','Meiosis and Gamete Formation',2),
('Cell Division','Stem Cells and Cancer',3),
('Photosynthesis and Respiration','Photosynthesis and Limiting Factors',1),
('Photosynthesis and Respiration','Aerobic and Anaerobic Respiration',2),
('Photosynthesis and Respiration','Gas Exchange and Energy Budgets',3),
('Genetics and Inheritance','DNA, Genes and Protein Synthesis',1),
('Genetics and Inheritance','Monohybrid Crosses and Punnett Squares',2),
('Genetics and Inheritance','Genetic Variation, Mutation and Inherited Disease',3),
('Evolution and Natural Selection','Variation, Adaptation and Selection Pressure',1),
('Evolution and Natural Selection','Evidence for Evolution',2),
('Evolution and Natural Selection','Speciation, Extinction and Selective Breeding',3),
('Ecosystems and Food Chains','Energy Flow, Food Webs and Pyramids',1),
('Ecosystems and Food Chains','Nutrient Cycles (Carbon, Nitrogen, Water)',2),
('Ecosystems and Food Chains','Population Dynamics and Sampling Methods',3),
('Human Body Systems','Circulation and the Heart',1),
('Human Body Systems','Digestion, Enzymes and Nutrition',2),
('Human Body Systems','Nervous and Endocrine Coordination',3),
('Human Body Systems','Homeostasis and Excretion',4),
('Disease and Immunity','Pathogens and Transmission',1),
('Disease and Immunity','Immune Response and Vaccination',2),
('Disease and Immunity','Antibiotics, Resistance and Drug Development',3),
('Plant Biology','Plant Transport (Xylem and Phloem)',1),
('Plant Biology','Plant Responses and Hormones',2),
('Plant Biology','Plant Reproduction and Seed Dispersal',3),
('Microbiology','Microorganism Types and Growth',1),
('Microbiology','Decomposition and Nutrient Recycling',2),
('Microbiology','Microbes in Food and Industry',3),
('Biotechnology','Genetic Engineering and GMOs',1),
('Biotechnology','Cloning and Tissue Culture',2),
('Biotechnology','Ethics and Impacts of Biotechnology',3),
('Biodiversity and Classification','Classification and Keys',1),
('Biodiversity and Classification','Measuring and Monitoring Biodiversity',2),
('Biodiversity and Classification','Conservation and Human Impact',3),
('Reproduction and Development','Human Reproductive Systems and Fertilisation',1),
('Reproduction and Development','Pregnancy, Birth and Development',2),
('Reproduction and Development','Hormones, Puberty and Fertility Control',3)
) AS v(parent, name, pos)
JOIN public.subjects s ON s.slug = 'biology'
JOIN public.topics p ON p.subject_id = s.id AND p.name = v.parent AND p.grade = 5 AND p.parent_topic_id IS NULL
ON CONFLICT (subject_id, name, grade) DO NOTHING;
