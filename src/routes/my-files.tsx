import { createFileRoute } from "@tanstack/react-router";
import { useEffect, useRef, useState } from "react";
import { ExternalLink, FileText, Trash2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

export const Route = createFileRoute("/my-files")({
  head: () => ({
    meta: [
      { title: "My files — MYP Revision" },
      {
        name: "description",
        content:
          "Keep your own revision links and open PDFs from your device next to your practice, privately in your browser.",
      },
    ],
  }),
  component: MyFiles,
});

type Link = { id: string; title: string; url: string };
const KEY = "myp-my-links";

function load(): Link[] {
  try {
    return JSON.parse(localStorage.getItem(KEY) ?? "[]") as Link[];
  } catch {
    return [];
  }
}

function MyFiles() {
  const [links, setLinks] = useState<Link[]>([]);
  const [title, setTitle] = useState("");
  const [url, setUrl] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [pdf, setPdf] = useState<{ name: string; src: string } | null>(null);
  const input = useRef<HTMLInputElement>(null);

  useEffect(() => setLinks(load()), []);
  useEffect(() => () => (pdf ? URL.revokeObjectURL(pdf.src) : undefined), [pdf]);

  function save(next: Link[]) {
    setLinks(next);
    try {
      localStorage.setItem(KEY, JSON.stringify(next));
    } catch {
      setError("Your browser would not save the list. It will last until you close the tab.");
    }
  }
  function add() {
    setError(null);
    let href = url.trim();
    if (!/^https?:\/\//i.test(href)) href = `https://${href}`;
    try {
      new URL(href);
    } catch {
      setError("That does not look like a web address.");
      return;
    }
    save([...links, { id: String(Date.now()), title: title.trim() || href, url: href }]);
    setTitle("");
    setUrl("");
  }

  return (
    <div className="page-fade mx-auto max-w-[1000px] px-6 py-12 md:px-12">
      <h1 className="text-4xl">My files</h1>
      <p className="mt-2 max-w-2xl text-sm text-muted-foreground">
        Keep the links your school gives you and open PDFs from your device. Everything stays in
        this browser. Nothing is uploaded, so only you can see it, and it is gone if you clear your
        browser data.
      </p>

      <section className="mt-8 rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
        <h2 className="font-display text-2xl">Open a PDF</h2>
        <p className="mt-1 text-sm text-muted-foreground">
          Pick a PDF from your device to read it here, beside your practice.
        </p>
        <input
          ref={input}
          type="file"
          accept="application/pdf"
          className="sr-only"
          aria-label="Choose a PDF"
          onChange={(e) => {
            const f = e.target.files?.[0];
            if (!f) return;
            if (pdf) URL.revokeObjectURL(pdf.src);
            setPdf({ name: f.name, src: URL.createObjectURL(f) });
          }}
        />
        <Button className="mt-3 rounded-full" onClick={() => input.current?.click()}>
          <FileText className="mr-1 size-4" /> Choose a PDF
        </Button>
        {pdf ? (
          <div className="mt-4">
            <p className="mb-2 text-sm font-medium">{pdf.name}</p>
            <iframe
              title={pdf.name}
              src={pdf.src}
              className="h-[70vh] w-full rounded-md border border-border"
            />
          </div>
        ) : null}
      </section>

      <section className="mt-6 rounded-lg border border-border bg-card p-6 shadow-[var(--shadow-soft)]">
        <h2 className="font-display text-2xl">My links</h2>
        <form
          className="mt-3 flex flex-col gap-2 sm:flex-row"
          onSubmit={(e) => {
            e.preventDefault();
            add();
          }}
        >
          <Input
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            placeholder="Name (e.g. Maths mock folder)"
          />
          <Input
            value={url}
            onChange={(e) => setUrl(e.target.value)}
            placeholder="https://…"
            required
          />
          <Button type="submit" className="rounded-full" disabled={!url.trim()}>
            Add
          </Button>
        </form>
        {error ? <p className="mt-2 text-sm text-destructive">{error}</p> : null}
        {links.length ? (
          <ul className="mt-4 flex flex-col gap-2">
            {links.map((l) => (
              <li
                key={l.id}
                className="flex items-center justify-between gap-3 rounded-md border border-border p-3"
              >
                <a
                  href={l.url}
                  target="_blank"
                  rel="noreferrer"
                  className="inline-flex min-w-0 items-center gap-1.5 text-sm underline underline-offset-4"
                >
                  <span className="truncate">{l.title}</span>{" "}
                  <ExternalLink className="size-3.5 shrink-0" />
                </a>
                <button
                  type="button"
                  aria-label={`Remove ${l.title}`}
                  onClick={() => save(links.filter((x) => x.id !== l.id))}
                  className="text-muted-foreground hover:text-destructive"
                >
                  <Trash2 className="size-4" />
                </button>
              </li>
            ))}
          </ul>
        ) : (
          <p className="mt-4 text-sm text-muted-foreground">No links yet.</p>
        )}
      </section>
    </div>
  );
}
