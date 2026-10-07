# Physics MYP 4 — Sub-topic breakdown for review

Each of the 18 Physics MYP 4 topics splits into 2–4 focused sub-topics. Nothing is generated yet — review and adjust the names, splits or counts first.

Existing questions and notes stay attached to the parent topic; new content would be written per sub-topic, with a difficulty spread and MYP Levels 1–8 grading.

## Core mechanics

1. **Forces and Motion** → Newton's Laws · Friction and Resistance · Momentum and Collisions
2. **Speed Distance and Time** → Speed and Average Speed · Distance–Time Graphs · Velocity, Acceleration and Speed–Time Graphs
3. **Introduction to Forces** → Types of Force · Measuring and Drawing Forces · Force Diagrams
4. **Gravity and Weight** → Mass vs Weight · Gravitational Field Strength · Falling Objects and Terminal Velocity
5. **Balanced and Unbalanced Forces** → Resultant Forces · Equilibrium and Stability · Turning Forces and Moments
6. **Simple Machines** → Levers and Moments · Pulleys and Gears · Mechanical Advantage and Efficiency

## Energy and thermal physics

7. **Introduction to Energy** → Energy Stores · Energy Transfers and Conservation · Work Done and Power
8. **Kinetic and Potential Energy** → Kinetic Energy Calculations · Gravitational Potential Energy · Energy Conversions in Motion
9. **Energy Transfer and Efficiency** → Sankey Diagrams and Energy Loss · Efficiency Calculations · Energy Resources and Sustainability
10. **Heat Transfer** → Conduction · Convection · Radiation and Insulation
11. **Heat and Temperature** → Temperature vs Thermal Energy · Specific Heat Capacity · Thermal Expansion
12. **States of Matter** → Particle Model of Matter · Changes of State · Heating and Cooling Curves

## Waves, light and sound

13. **Sound Waves** → Properties of Sound Waves · Pitch, Loudness and the Oscilloscope · Speed of Sound, Echoes and Hearing
14. **Light and Reflection** → Properties of Light · Reflection and Ray Diagrams · Refraction and Lenses
15. **Light and Shadows** → Light Travelling in Straight Lines · Shadows, Eclipses and Pinhole Images · Colour and Filters

## Electricity and magnetism

16. **Electricity and Circuits** → Current, Charge and Circuit Symbols · Voltage, Resistance and Ohm's Law · Series and Parallel Circuits · Electrical Power and Safety
17. **Magnetism and Electromagnetism** → Magnets and Magnetic Fields · Electromagnets · The Motor Effect and Generators

## Fluids

18. **Pressure** → Pressure on Solids · Pressure in Liquids and Hydraulics · Gas Pressure and the Atmosphere

## Totals

56 sub-topics across 18 topics (most 3, Electricity 4).

## How it would be built (technical)

- Sub-topics stored as ordinary rows in `topics`, with a new nullable `parent_topic_id` self-reference so parent topics keep their existing questions and notes while sub-topics nest under them.
- Subject page topic picker becomes two-level: parent topic, then sub-topic.
- Content generation (15–20 MCQs plus a 400+ word note per sub-topic) happens only after you approve this breakdown, one topic group at a time.
