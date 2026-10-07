// Server-only helper for the Anthropic Messages API. Never import from client code.
// Requires the ANTHROPIC_API_KEY environment variable (server-side secret).

const API_URL = "https://api.anthropic.com/v1/messages";
export const MODEL = "claude-sonnet-4-5";

export type ClaudeResult<T> = { ok: true; value: T } | { ok: false; error: string };

function errorForStatus(status: number, what: string): string {
  if (status === 429) return `The ${what} service is busy right now. Try again in a moment.`;
  if (status === 402 || status === 529) return `The ${what} service is unavailable right now. Try again shortly.`;
  if (status === 401 || status === 403) return `AI ${what} is not configured correctly.`;
  return `Could not complete ${what} right now.`;
}

async function post(body: unknown, what: string): Promise<ClaudeResult<Response>> {
  const apiKey = process.env["ANTHROPIC_API_KEY"];
  if (!apiKey) return { ok: false, error: `AI ${what} is not configured.` };

  let response: Response;
  try {
    response = await fetch(API_URL, {
      method: "POST",
      headers: {
        "content-type": "application/json",
        "x-api-key": apiKey,
        "anthropic-version": "2023-06-01",
      },
      body: JSON.stringify(body),
    });
  } catch {
    return { ok: false, error: `Could not reach the ${what} service. Try again.` };
  }
  if (!response.ok) return { ok: false, error: errorForStatus(response.status, what) };
  return { ok: true, value: response };
}

/** Plain-text completion. */
export async function claudeText(opts: {
  prompt: string;
  maxTokens: number;
  what: string;
}): Promise<ClaudeResult<string>> {
  const res = await post(
    { model: MODEL, max_tokens: opts.maxTokens, messages: [{ role: "user", content: opts.prompt }] },
    opts.what,
  );
  if (!res.ok) return res;
  try {
    const json = (await res.value.json()) as { content?: { type: string; text?: string }[] };
    const text = (json.content ?? [])
      .filter((b) => b.type === "text" && typeof b.text === "string")
      .map((b) => b.text)
      .join("")
      .trim();
    if (!text) return { ok: false, error: `No ${opts.what} was returned.` };
    return { ok: true, value: text };
  } catch {
    return { ok: false, error: `The ${opts.what} result could not be read.` };
  }
}

/** Structured output: forces a single tool call and returns its validated-by-schema input. */
export async function claudeJson<T>(opts: {
  prompt: string;
  maxTokens: number;
  what: string;
  toolName: string;
  schema: Record<string, unknown>;
}): Promise<ClaudeResult<T>> {
  const res = await post(
    {
      model: MODEL,
      max_tokens: opts.maxTokens,
      messages: [{ role: "user", content: opts.prompt }],
      tools: [
        {
          name: opts.toolName,
          description: "Return the result in exactly this structure.",
          input_schema: opts.schema,
        },
      ],
      tool_choice: { type: "tool", name: opts.toolName },
    },
    opts.what,
  );
  if (!res.ok) return res;
  try {
    const json = (await res.value.json()) as {
      content?: { type: string; name?: string; input?: unknown }[];
    };
    const block = (json.content ?? []).find((b) => b.type === "tool_use" && b.name === opts.toolName);
    if (!block || block.input == null) return { ok: false, error: `The ${opts.what} result could not be read.` };
    return { ok: true, value: block.input as T };
  } catch {
    return { ok: false, error: `The ${opts.what} result could not be read.` };
  }
}
