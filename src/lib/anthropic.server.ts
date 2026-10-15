// Server-only helper for the Anthropic Messages API. Never import from client code.
// Requires the ANTHROPIC_API_KEY environment variable (server-side secret).
// Optional env: ANTHROPIC_API_URL, ANTHROPIC_MODEL, ANTHROPIC_FAST_MODEL, ANTHROPIC_TIMEOUT_MS.

const DEFAULT_MODEL = "claude-sonnet-4-5";
export const MODEL = process.env["ANTHROPIC_MODEL"] || DEFAULT_MODEL;

function apiUrl() {
  return process.env["ANTHROPIC_API_URL"] ?? "https://api.anthropic.com/v1/messages";
}
function model(fast?: boolean) {
  const main = process.env["ANTHROPIC_MODEL"] || DEFAULT_MODEL;
  return fast ? process.env["ANTHROPIC_FAST_MODEL"] || main : main;
}
/** Per-call timeout; `ANTHROPIC_TIMEOUT_MS` overrides every call (used by tests), else the call's own default. */
function timeoutMs(fallback = 60000) {
  const n = Number(process.env["ANTHROPIC_TIMEOUT_MS"]);
  return Number.isFinite(n) && n > 0 ? n : fallback;
}

/** `code`: no_key = AI not configured; busy = transport/overload/timeout/refusal/truncation. */
export type ClaudeResult<T> =
  | { ok: true; value: T }
  | {
      ok: false;
      error: string;
      code: "no_key" | "busy";
      /** True when the reply was cut off at max_tokens (callers may retry with a shorter ask). */
      truncated?: boolean;
    };

function errorForStatus(status: number, what: string): string {
  if (status === 429) return `The ${what} service is busy right now. Try again in a moment.`;
  if (status === 402 || status === 529)
    return `The ${what} service is unavailable right now. Try again shortly.`;
  if (status === 401 || status === 403) return `AI ${what} is not configured correctly.`;
  return `Could not complete ${what} right now.`;
}

const RETRYABLE = new Set([429, 500, 502, 503, 529]);
const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

function retryDelay(res: Response): number {
  const ra = Number(res.headers.get("retry-after"));
  const base = Number.isFinite(ra) && ra > 0 ? ra * 1000 : 500;
  return Math.min(5000, base + Math.random() * 400);
}

type Posted = { response: Response; signal: AbortSignal };

type PostOpts = { timeoutMs?: number; retryOnTimeout?: boolean };

async function post(
  body: unknown,
  what: string,
  opts: PostOpts = {},
): Promise<ClaudeResult<Posted>> {
  const apiKey = process.env["ANTHROPIC_API_KEY"];
  if (!apiKey) return { ok: false, error: `AI ${what} is not configured.`, code: "no_key" };

  for (let attempt = 0; attempt < 2; attempt++) {
    const signal = AbortSignal.timeout(timeoutMs(opts.timeoutMs));
    let response: Response;
    try {
      response = await fetch(apiUrl(), {
        method: "POST",
        headers: {
          "content-type": "application/json",
          "x-api-key": apiKey,
          "anthropic-version": "2023-06-01",
        },
        body: JSON.stringify(body),
        signal,
      });
    } catch (e) {
      console.error(
        `[anthropic] ${what}: request failed (${(e as Error)?.name ?? "error"}) attempt ${attempt + 1}`,
      );
      if (attempt === 0 && (!signal.aborted || opts.retryOnTimeout)) {
        await sleep(300 + Math.random() * 300);
        continue;
      }
      return { ok: false, error: `Could not reach the ${what} service. Try again.`, code: "busy" };
    }
    if (response.ok) return { ok: true, value: { response, signal } };

    let snippet = "";
    try {
      snippet = (await response.text()).slice(0, 200);
    } catch {
      /* ignore */
    }
    console.error(`[anthropic] ${what}: HTTP ${response.status} ${snippet}`);
    if (attempt === 0 && RETRYABLE.has(response.status)) {
      await sleep(retryDelay(response));
      continue;
    }
    const code = response.status === 401 || response.status === 403 ? "no_key" : "busy";
    return { ok: false, error: errorForStatus(response.status, what), code };
  }
  return { ok: false, error: `Could not complete ${what} right now.`, code: "busy" };
}

type Block = { type: string; text?: string; name?: string; input?: unknown };
type Reply = { content?: Block[]; stop_reason?: string };

async function readReply(p: Posted, what: string): Promise<ClaudeResult<Reply>> {
  let json: Reply;
  try {
    json = (await p.response.json()) as Reply;
  } catch (e) {
    console.error(`[anthropic] ${what}: unreadable reply (${(e as Error)?.name ?? "error"})`);
    return { ok: false, error: `The ${what} result could not be read.`, code: "busy" };
  }
  if (!json || typeof json !== "object")
    return { ok: false, error: `The ${what} result could not be read.`, code: "busy" };
  if (json.stop_reason === "max_tokens" || json.stop_reason === "refusal") {
    console.error(`[anthropic] ${what}: stop_reason=${json.stop_reason}`);
    return {
      ok: false,
      error: `The ${what} result was incomplete. Try again.`,
      code: "busy",
      truncated: json.stop_reason === "max_tokens",
    };
  }
  return { ok: true, value: json };
}

/** Plain-text completion. */
export async function claudeText(opts: {
  prompt: string;
  system?: string;
  maxTokens: number;
  what: string;
  fast?: boolean;
}): Promise<ClaudeResult<string>> {
  const res = await post(
    {
      model: model(opts.fast),
      max_tokens: opts.maxTokens,
      ...(opts.system ? { system: opts.system } : {}),
      messages: [{ role: "user", content: opts.prompt }],
    },
    opts.what,
  );
  if (!res.ok) return res;
  const reply = await readReply(res.value, opts.what);
  if (!reply.ok) return reply;
  const text = (reply.value.content ?? [])
    .filter((b) => b.type === "text" && typeof b.text === "string")
    .map((b) => b.text)
    .join("")
    .trim();
  if (!text) return { ok: false, error: `No ${opts.what} was returned.`, code: "busy" };
  return { ok: true, value: text };
}

/** Structured output: forces a single tool call and returns its input (an object). */
export async function claudeJson<T>(opts: {
  prompt: string;
  system?: string;
  maxTokens: number;
  what: string;
  toolName: string;
  schema: Record<string, unknown>;
  fast?: boolean;
  /** Default 60 s. Long exam writing uses more and retries once if it times out. */
  timeoutMs?: number;
  retryOnTimeout?: boolean;
}): Promise<ClaudeResult<T>> {
  const res = await post(
    {
      model: model(opts.fast),
      max_tokens: opts.maxTokens,
      ...(opts.system ? { system: opts.system } : {}),
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
    {
      ...(opts.timeoutMs ? { timeoutMs: opts.timeoutMs } : {}),
      ...(opts.retryOnTimeout ? { retryOnTimeout: true } : {}),
    },
  );
  if (!res.ok) return res;
  const reply = await readReply(res.value, opts.what);
  if (!reply.ok) return reply;
  const block = (reply.value.content ?? []).find(
    (b) => b.type === "tool_use" && b.name === opts.toolName,
  );
  if (
    !block ||
    block.input == null ||
    typeof block.input !== "object" ||
    Array.isArray(block.input)
  )
    return { ok: false, error: `The ${opts.what} result could not be read.`, code: "busy" };
  return { ok: true, value: block.input as T };
}
