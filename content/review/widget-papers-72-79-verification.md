# Verification of widget papers 72-79

Checked every task: language accuracy, widget parsing (src/lib/task-markup.ts via tsx), chart data vs text, answer strings vs options, arithmetic, level, mark sums. `validate-widget-papers.mjs` and `check-paper-sizes.mjs` pass; load.sql regenerated. No parse errors, no commas inside drag slots/items, no "1-7" text, all texts original, no quoted literature.

| File | Task | What was wrong | Fixed |
|---|---|---|---|
| 73 French L&L | Q1 text | "manquer quelque chose d'important" is unidiomatic (manquer = to miss a person/event/target) | Changed to "rater" |
| 73 French L&L | Q3(a) select f3a | Distractor "opposé à son contraire" is nonsensical French | "remplacé par son contraire" |
| 74 Spanish L&L | Q2 poem | Task (c) refers to "the second stanza" but the poem was printed as one block | Blank line added between the two quatrains |
| 76 Spanish ab initio | Q1(c) select a3 | Sentence "a la ___" with options una/dos/tres: only "una" was grammatical, giving the answer away | Article moved into options: la una / las dos / las tres; mark scheme updated |
| 76 Spanish ab initio | Q1 mark scheme (b) | Stray remark about "diez y media" | Removed |
| 77 Mandarin ab initio | Q2(b) | "最少同学喜欢" is not natural Chinese | Now "哪个爱好的人数最少 (Nǎge àihào de rénshù zuì shǎo)? Which hobby has the fewest students?" (options unchanged) |
| 79 IDL 2 | Q2(a) statement 2 | "Asking staff which style of sign they would notice" could be read as Mathematics (survey/statistics), so not unambiguous | Reworded to "Deciding the colours and layout of a reminder sign so that staff will notice it" (Design) |

Counts (errors found / fixed): 72: 0/0; 73: 2/2; 74: 1/1; 75: 0/0; 76: 2/2; 77: 1/1; 78: 0/0; 79: 1/1. Total 7/7.

Verified correct (no change): all select/drag answer strings in mark schemes are identical to option strings (Mandarin options include the pinyin exactly as in the scheme); pie 40/30/20/10 = 100; French bar chart totals 120 (multiple answers allowed, stated); Spanish L&L chart = 100; ab initio charts match the text (least popular and "six/seven students" items); Mandarin pinyin checked with pypinyin (tone sandhi yí kuài, yígòng are correct); IDL 78: mean 1.2 m, road 24 m gives 20 years, costs 60 000 / 150 000 / 30 000 per year; IDL 79: total 1600 kWh, 25/15/20/30 %, saving 200 kWh, 8000 kWh x 0.25 = 2000 pounds a year, payback 2.5 years, plot points (1,2),(2,4),(3,6),(4,8).

Unresolved / suggestions: none blocking. A native French, Spanish and Mandarin speaker skim is still advisable for the free-writing prompts and acceptable-answer lists. The fill-table and plot answers are free text, so marking relies on the AI reading "Interactive answers:" lines (e.g. "60 000" vs "60000" accepted by intent).
