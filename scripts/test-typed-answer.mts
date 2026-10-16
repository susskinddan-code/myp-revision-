import fs from "node:fs";
import path from "node:path";
import { localCheck, stemNeedsOptions } from "../src/lib/typed-answer.ts";
import { fitToMinutes, minutesFor } from "../src/lib/exam-fit.ts";

const cases: [string, string, boolean][] = [
  ["5 cm", "5 m", false],
  ["3 kg", "3 g", false],
  ["2 J", "2 W", false],
  ["2x", "2", false],
  ["2", "2x", false],
  ["+1", "n+1", false],
  ["3.14", "3.15", false],
  ["1000", "1004", false],
  ["not photosynthesis", "photosynthesis", false],
  ["5 m", "5 m", true],
  ["5", "5 m", true],
  ["0.50", ".5", true],
  ["1,000", "1000", true],
  ["3/4", "0.75", true],
  ["Photosynthesis.", "photosynthesis", true],
  ["it is photosynthesis", "photosynthesis", true],
  ["£1,200", "1200", true],
  ["-7", "7", false],
  ["10 N", "10", false],
  ["", "x", false],
  // Language answers (offline checker)
  ["十二", "十二 (shí'èr)", true],
  ["shí'èr", "十二 (shí'èr)", true],
  ["shier", "十二 (shí'èr)", true],
  ["shi'er", "十二 (shí'èr)", true],
  // Tone-number pinyin (L10)
  ["ni3 hao3", "你好 (nǐ hǎo)", true],
  ["ni3hao3", "你好 (nǐ hǎo)", true],
  ["你好 ni3 hao3", "你好 (nǐ hǎo)", true],
  ["shi2'er4", "十二 (shí'èr)", true],
  ["lv4", "绿 (lǜ)", true],
  ["ni3 hao4", "你好 (nǐ hǎo)", true],
  ["xie4xie5", "谢谢 (xièxie)", true],
  ["ni3 hao3 ma5", "你好 (nǐ hǎo)", false],
  ["十二 shí'èr", "十二 (shí'èr)", true],
  ["shí'èr 十二", "十二 (shí'èr)", true],
  ["十二（shí'èr）", "十二 (shí'èr)", true],
  ["十一", "十二 (shí'èr)", false],
  ["十二", "十一 (shí'yī)", false],
  ["nǐ hǎo", "你好 (nǐ hǎo)", true],
  ["ni hao", "你好 (nǐ hǎo)", true],
  ["你好", "你好 (nǐ hǎo)", true],
  ["谢谢", "你好 (nǐ hǎo)", false],
  ["où est la gare", "Où est la gare ?", true],
  ["Où est la gare?", "Où est la gare ?", true],
  ["Où est la gare ?", "Où est la gare", true],
  ["ou est la gare", "Où est la gare ?", true], // accent-less: accepted offline
  ["Où est le gare", "Où est la gare ?", false],
  ["Qu’est-ce que c’est ?", "Qu'est-ce que c'est ?", true],
  ["« Bonjour ! »", "Bonjour", true],
  ["j'habite a paris", "J'habite à Paris.", true],
  ["el ninio", "el niño", false],
  ["el nino", "el niño", true],
  ["¿Cómo estás?", "como estas", true],
  ["¿Dónde está la biblioteca?", "Dónde está la biblioteca", true],
  ["manana", "mañana", true],
  ["est", "été", false],
  ["a", "à", true],
  ["hello", "bonjour (hello)", false],
  ["la maison", "le maison", false],
];
let bad = 0;
for (const [s, c, want] of cases) {
  const got = localCheck(s, c);
  if (got !== want) {
    bad++;
    console.log("FAIL", JSON.stringify(s), JSON.stringify(c), "want", want, "got", got);
  }
}

// Option-list rule: show options only when the stem refers to given candidates.
const stems: [string, boolean][] = [
  ["Which of these is an organ?", true],
  ["Which of these diseases is caused by a virus?", true],
  ["Which of the following is needed for natural selection to occur?", true],
  ["Which description best matches a prokaryote?", true],
  ["Which sentence correctly says 'She likes tea'?", true],
  ["Which is the best justification for a sustainable city?", true],
  ["Which statement best describes natural selection?", true],
  ["What is natural selection?", false],
  ["Why is variation necessary for natural selection?", false],
  ["Who proposed the theory of evolution by natural selection?", false],
  ["A farmer uses selective breeding. What is this?", false],
  ["A poet chooses free verse. What effect does it have?", false],
  ["What is a microorganism that causes disease called?", false],
  ["Which hormone prepares the body for a fight-or-flight situation?", false],
  ["What is the next term of 1, 3, 6, 10, 15?", false],
];
// Stems whose outcome depends on the stored answer (long phrase = unguessable without the options).
const withAnswer: [string, string, boolean][] = [
  ["Which goal is the most SMART?", "Increase my 5 km time from 30 to 25 minutes by 1 June", true],
  ["Which refinement is likely to help?", "Add more repeats and control the temperature", true],
  [
    "In an investigation, which control is most important?",
    "Keep the volume of acid the same in each trial",
    true,
  ],
  [
    "Which scenario is the clearest example of the tragedy of the commons?",
    "Fishermen overfishing a shared lake",
    true,
  ],
  ["Which hormone prepares the body for a fight-or-flight situation?", "Adrenaline", false],
  ["Which gas do plants take in?", "Carbon dioxide", false],
  ["Quelle phrase est correcte ?", "Je suis allé au cinéma hier soir", true],
  ["Select the correct spelling.", "necessary", true],
  [
    "What is the best response to a pharmacist who asks 'Qu'est-ce qui ne va pas ?'",
    "J'ai mal à la gorge et je tousse.",
    true,
  ],
  [
    "What is natural selection?",
    "The process by which better adapted organisms survive and reproduce",
    false,
  ],
  [
    "Explain a process which involves natural selection.",
    "Survival of the fittest and inheritance of traits",
    false,
  ],
  [
    "A farmer uses selective breeding. What is this?",
    "Artificial selection of animals with useful traits",
    false,
  ],
];
for (const [stem, ans, want] of withAnswer) {
  const got = stemNeedsOptions(stem, ans);
  if (got !== want) {
    bad++;
    console.log("FAIL stem+answer", JSON.stringify(stem), "want", want, "got", got);
  }
}
for (const [stem, want] of stems) {
  const got = stemNeedsOptions(stem);
  if (got !== want) {
    bad++;
    console.log("FAIL stem", JSON.stringify(stem), "want", want, "got", got);
  }
}

// Report over all shipped content (MCQ rows only, excluding content/_unused).
let total = 0;
let shown = 0;
const shownList: string[] = [];
const hiddenList: string[] = [];
const walk = (d: string) => {
  for (const f of fs.readdirSync(d, { withFileTypes: true })) {
    const p = path.join(d, f.name);
    if (f.isDirectory()) {
      if (f.name !== "_unused") walk(p);
    } else if (f.name.endsWith(".json")) {
      try {
        const j = JSON.parse(fs.readFileSync(p, "utf8"));
        for (const sub of Array.isArray(j) ? j : [j])
          for (const q of sub?.questions ?? [])
            if (Array.isArray(q.options) && typeof q.content === "string") {
              total++;
              const ans = String(q.options[q.answer] ?? "");
              const need = stemNeedsOptions(q.content, ans);
              if (need) {
                shown++;
                shownList.push(q.content);
              } else hiddenList.push(`${q.content}  => ${ans}`);
            }
      } catch {}
    }
  }
};
const contentDir = path.join(path.dirname(new URL(import.meta.url).pathname), "..", "content");
if (fs.existsSync(contentDir)) {
  walk(contentDir);
  console.log(`content MCQ stems: ${total}, options shown ${shown}, hidden ${total - shown}`);
}

if (process.env.DUMP) {
  const pick = (a: string[]) => a.sort(() => Math.random() - 0.5).slice(0, 40);
  console.log("--- SHOWN ---\n" + pick(shownList).join("\n"));
  console.log("--- HIDDEN ---\n" + pick(hiddenList).join("\n"));
}
/* L9: the stated minutes are a cap on the sitting */
{
  const mk = (marks: number, i: number) => ({
    content: `[[Q ${i} | A ${marks}]] question ${i}`,
    mark_scheme: `Answer [${marks}]`,
    position: i,
  });
  const pool = Array.from({ length: 30 }, (_, i) => mk(5 + (i % 4) * 2, i + 1));
  for (const cap of [30, 60, 105, 120]) {
    const fitted = fitToMinutes(pool, cap);
    const mins = minutesFor(fitted);
    const okFit = mins > 0 && mins <= cap && mins >= cap * 0.8;
    if (!okFit) {
      bad++;
      console.log(`FAIL L9 cap ${cap}: ${mins} min from ${fitted.length} tasks`);
    }
    const nums = fitted.map((t) => t.position).join();
    if (nums !== fitted.map((_, i) => i + 1).join()) {
      bad++;
      console.log("FAIL L9 renumber", nums);
    }
    if (!/^\[\[Task 1 /.test(fitted[0]!.content)) {
      bad++;
      console.log("FAIL L9 header", fitted[0]!.content);
    }
  }
  // 127 minutes of stored tasks against a stated 105 => trimmed to <= 105
  const big = Array.from({ length: 9 }, (_, i) => mk(12, i + 1)); // 108 marks = 130 min
  if (minutesFor(big) <= 105 || minutesFor(fitToMinutes(big, 105)) > 105) {
    bad++;
    console.log(
      "FAIL L9 stored-paper overshoot",
      minutesFor(big),
      minutesFor(fitToMinutes(big, 105)),
    );
  }
  if (minutesFor(fitToMinutes(pool, 60)) > 60) bad++;
  if (fitToMinutes([], 30).length !== 0) bad++;
  if (fitToMinutes([mk(40, 1)], 30).length !== 1) bad++; // never returns an empty paper
}
console.log(
  bad ? `${bad} failed` : `all ${cases.length + stems.length + withAnswer.length} passed`,
);
process.exit(bad ? 1 : 0);
