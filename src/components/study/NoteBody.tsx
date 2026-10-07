/** Renders the stored study notes: headings, bullet lists, bold and paragraphs. */
export function NoteBody({ content }: { content: string }) {
  const blocks: React.ReactNode[] = [];
  const lines = content.split("\n");
  let bullets: string[] = [];
  let para: string[] = [];

  const flushBullets = () => {
    if (!bullets.length) return;
    blocks.push(
      <ul key={`ul-${blocks.length}`} className="flex list-disc flex-col gap-2 pl-5">
        {bullets.map((b, i) => (
          <li key={i}>{inline(b)}</li>
        ))}
      </ul>,
    );
    bullets = [];
  };
  const flushPara = () => {
    if (!para.length) return;
    blocks.push(<p key={`p-${blocks.length}`}>{inline(para.join(" "))}</p>);
    para = [];
  };

  for (const raw of lines) {
    const line = raw.trim();
    if (!line) {
      flushBullets();
      flushPara();
      continue;
    }
    const heading = /^(#{1,4})\s+(.*)$/.exec(line);
    if (heading) {
      flushBullets();
      flushPara();
      blocks.push(
        <h3 key={`h-${blocks.length}`} className="font-display text-lg text-foreground">
          {inline(heading[2] ?? "")}
        </h3>,
      );
      continue;
    }
    const bullet = /^[-*]\s+(.*)$/.exec(line);
    if (bullet) {
      flushPara();
      bullets.push(bullet[1] ?? "");
      continue;
    }
    flushBullets();
    para.push(line);
  }
  flushBullets();
  flushPara();

  return (
    <div className="mt-4 flex flex-col gap-4 text-sm leading-relaxed text-foreground/90">
      {blocks}
    </div>
  );
}

/** Bold (**text**) segments inside a line of note text. */
function inline(text: string) {
  return text.split(/(\*\*[^*]+\*\*)/g).map((part, i) =>
    part.startsWith("**") && part.endsWith("**") ? (
      <strong key={i} className="font-medium text-foreground">
        {part.slice(2, -2)}
      </strong>
    ) : (
      <span key={i}>{part}</span>
    ),
  );
}
