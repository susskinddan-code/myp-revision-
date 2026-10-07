# Biology MYP 5 — sub-topic breakdown for review

## Where Biology MYP 5 stands today

All 19 Biology MYP 5 topic headings are completely empty: 0 questions, 0 study notes, 0 flashcards, 0 sub-topics and 0 practice papers. Only the headings exist. (Biology MYP 4 has questions on 10 of its topics and no sub-topics yet.)

Six of the 19 headings duplicate another heading. Per your decision, Biology MYP 5 is consolidated to 13 topics: the six short legacy headings (Cell Structure, Genetics, Evolution, Ecology, Human Physiology, Biodiversity) are removed at MYP 5 only — they hold no content — and their themes live under the fuller headings. MYP 4 Biology is untouched, so its existing questions stay exactly where they are.

## Proposed sub-topics (13 topics, 40 sub-topics)

**Cells and Cell Processes** — Cell Structure and Ultrastructure; Movement In and Out of Cells; Specialised Cells and Levels of Organisation

**Cell Division** — Mitosis and the Cell Cycle; Meiosis and Gamete Formation; Stem Cells and Cancer

**Photosynthesis and Respiration** — Photosynthesis and Limiting Factors; Aerobic and Anaerobic Respiration; Gas Exchange and Energy Budgets

**Genetics and Inheritance** — DNA, Genes and Protein Synthesis; Monohybrid Crosses and Punnett Squares; Genetic Variation, Mutation and Inherited Disease

**Evolution and Natural Selection** — Variation, Adaptation and Selection Pressure; Evidence for Evolution; Speciation, Extinction and Selective Breeding

**Ecosystems and Food Chains** — Energy Flow, Food Webs and Pyramids; Nutrient Cycles (Carbon, Nitrogen, Water); Population Dynamics and Sampling Methods

**Human Body Systems** — Circulation and the Heart; Digestion, Enzymes and Nutrition; Nervous and Endocrine Coordination; Homeostasis and Excretion

**Disease and Immunity** — Pathogens and Transmission; Immune Response and Vaccination; Antibiotics, Resistance and Drug Development

**Plant Biology** — Plant Transport (Xylem and Phloem); Plant Responses and Hormones; Plant Reproduction and Seed Dispersal

**Microbiology** — Microorganism Types and Growth; Decomposition and Nutrient Recycling; Microbes in Food and Industry

**Biotechnology** — Genetic Engineering and GMOs; Cloning and Tissue Culture; Ethics and Impacts of Biotechnology

**Biodiversity and Classification** — Classification and Keys; Measuring and Monitoring Biodiversity; Conservation and Human Impact

**Reproduction and Development** — Human Reproductive Systems and Fertilisation; Pregnancy, Birth and Development; Hormones, Puberty and Fertility Control

## What gets built after you approve

1. Consolidate to the 13 topics and insert the 40 sub-topics under them, so each topic opens into its sub-topics plus a "Whole topic" option — exactly like Physics.
2. Confirm the structure looks right in the app.
3. Only then generate content for each sub-topic, in batches: 18 multiple-choice questions (5 easy, 8 medium, 5 hard), a 450+ word study note, and 9 flashcards, all pitched at MYP Year 5 and using MYP Levels 1-8.
4. Practice papers for Biology MYP 5 (Criteria A-D) can follow as a separate step, matching the Physics papers.

## Technical notes

- Sub-topics are rows in `topics` with `parent_topic_id` set to the parent and `grade = 5`; no schema change is needed.
- Removing the six duplicate MYP 5 headings is a delete of empty `topics` rows (no questions, notes, flashcards or sub-topics reference them) scoped to `grade = 5` and the Biology subject.
- Content generation reuses the Physics pipeline: Lovable AI Gateway, `openai/gpt-6-astra`, strict JSON schema, validated then loaded in batches.
