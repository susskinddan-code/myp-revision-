# Physics MYP 5 — sub-topic breakdown for review

## What exists today at MYP 5

Physics MYP 5 has the same 18 topic headings as MYP 4, but they are completely
empty: 0 questions, 0 study notes, 0 flashcards, 0 sub-topics, and 0 practice
papers at this grade. So MYP 5 is structure only.

## Proposed sub-topics (55 in total)

Same shape as MYP 4 — 3 sub-topics per topic, 4 for Electricity and Circuits —
but pitched a year further on, with more algebra, graph work and evaluation.

1. Forces and Motion — Newton's Laws Applied; Resultant Forces and Free-Body Diagrams; Momentum and Impulse
2. Speed Distance and Time — Velocity and Acceleration Calculations; Motion Graphs and Gradients; Equations of Motion
3. Pressure — Pressure and Force on Solids; Hydraulics and Liquid Pressure; Gas Laws and Atmospheric Pressure
4. Heat Transfer — Conduction and Convection in Context; Radiation and Emissivity; Insulation, U-values and Efficiency
5. Light and Reflection — Reflection and Image Formation; Refraction and Refractive Index; Lenses, Ray Diagrams and Optical Instruments
6. Electricity and Circuits — Charge, Current and Ohm's Law; Series and Parallel Calculations; Resistance, I-V Graphs and Components; Electrical Power, Energy and Cost
7. Magnetism and Electromagnetism — Magnetic Fields and Electromagnets; The Motor Effect and Fleming's Left Hand Rule; Electromagnetic Induction and Transformers
8. Energy Transfer and Efficiency — Energy Stores, Transfers and Conservation; Efficiency, Sankey Diagrams and Power; Energy Resources, Generation and Sustainability
9. Introduction to Forces — Force Types and Interaction Pairs; Vectors, Scalars and Resolving Forces; Springs, Hooke's Law and Deformation
10. Gravity and Weight — Weight, Mass and Gravitational Field Strength; Free Fall, Air Resistance and Terminal Velocity; Orbits and Gravity Beyond Earth
11. Balanced and Unbalanced Forces — Resultant Force and Acceleration; Moments, Levers and Equilibrium; Stability, Centre of Mass and Structures
12. Introduction to Energy — Work Done and Energy Transfer; Power and Rate of Transfer; Energy in Everyday Systems
13. Kinetic and Potential Energy — Kinetic Energy Calculations; Gravitational and Elastic Potential Energy; Energy Conversion Problems and Losses
14. Heat and Temperature — Thermal Energy vs Temperature; Specific Heat Capacity Calculations; Latent Heat and Changes of State
15. States of Matter — Particle Model and Density; Changes of State and Energy; Heating, Cooling Curves and Gas Behaviour
16. Sound Waves — Wave Properties and the Wave Equation; Pitch, Loudness and Oscilloscope Traces; Speed of Sound, Echoes and Ultrasound
17. Light and Shadows — Rectilinear Propagation, Shadows and Eclipses; The Electromagnetic Spectrum; Colour, Filters and Absorption
18. Simple Machines — Levers and Moment Calculations; Pulleys, Gears and Inclined Planes; Mechanical Advantage, Work and Efficiency

## How it would be built (after your approval)

- Add these 55 sub-topics as rows under their MYP 5 parent topics, exactly the
  way MYP 4 works, so the new Study navigation (Topic → Sub-topic → everything
  on one page) picks them up automatically with no code change.
- Then, only once you approve, generate content group by group: 18 multiple-choice
  questions per sub-topic (5 easy / 8 medium / 5 hard, with worked calculations),
  a 400+ word study note, and 9 flashcards — matching the MYP 4 style and using
  MYP Levels 1-8.
- Parent topics keep their "Whole topic" option, which mixes every sub-topic
  together.

## Technical notes

- Sub-topics are ordinary `topics` rows with `parent_topic_id` set to the MYP 5
  parent and `grade = 5`; inserted via a migration with sequential `position`.
- No schema change and no new dependencies; `fetchTopics` / `fetchSubTopics`
  and `TopicStudy` already handle any grade.
- Content generation runs through the existing AI gateway script pattern
  (strict JSON schema, validated, loaded as batched SQL inserts).

Tell me if you want different sub-topic names, a different split (2-4 per
topic), or topics dropped/merged for MYP 5 before I insert anything.
