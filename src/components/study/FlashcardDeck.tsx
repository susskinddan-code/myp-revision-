import { useState } from "react";
import { RotateCcw, ArrowLeft, ArrowRight } from "lucide-react";
import { Button } from "@/components/ui/button";
import type { Flashcard } from "@/lib/myp";

export function FlashcardDeck({ cards }: { cards: Flashcard[] }) {
  const [index, setIndex] = useState(0);
  const [flipped, setFlipped] = useState(false);

  const card = cards[index];
  if (!card) return null;

  function go(step: number) {
    setFlipped(false);
    setIndex((i) => (i + step + cards.length) % cards.length);
  }

  return (
    <div className="flex flex-col items-center gap-5">
      <p className="text-sm text-muted-foreground">
        Card {index + 1} of {cards.length}
      </p>

      <button
        type="button"
        onClick={() => setFlipped((f) => !f)}
        aria-label="Flip card"
        className="w-full max-w-xl"
        style={{ perspective: "1200px" }}
      >
        <div
          className="relative h-64 w-full transition-transform duration-500"
          style={{
            transformStyle: "preserve-3d",
            transform: flipped ? "rotateY(180deg)" : "rotateY(0deg)",
          }}
        >
          <div
            className="absolute inset-0 flex flex-col items-center justify-center gap-3 rounded-lg border border-border bg-card p-8 text-center shadow-[var(--shadow-soft)]"
            style={{ backfaceVisibility: "hidden" }}
          >
            <span className="text-xs uppercase tracking-wide text-muted-foreground">Front</span>
            <p className="font-display text-2xl">{card.front}</p>
            <span className="text-xs text-muted-foreground">Tap to reveal</span>
          </div>
          <div
            className="absolute inset-0 flex flex-col items-center justify-center gap-3 rounded-lg border border-border bg-surface-2 p-8 text-center shadow-[var(--shadow-soft)]"
            style={{ backfaceVisibility: "hidden", transform: "rotateY(180deg)" }}
          >
            <span className="text-xs uppercase tracking-wide text-muted-foreground">Back</span>
            <p className="text-lg">{card.back}</p>
          </div>
        </div>
      </button>

      <div className="flex items-center gap-2">
        <Button variant="outline" size="sm" className="rounded-full" onClick={() => go(-1)}>
          <ArrowLeft className="size-4" /> Previous
        </Button>
        <Button
          variant="ghost"
          size="sm"
          className="rounded-full"
          onClick={() => setFlipped(false)}
        >
          <RotateCcw className="size-4" /> Reset
        </Button>
        <Button size="sm" className="rounded-full" onClick={() => go(1)}>
          Next <ArrowRight className="size-4" />
        </Button>
      </div>
    </div>
  );
}
