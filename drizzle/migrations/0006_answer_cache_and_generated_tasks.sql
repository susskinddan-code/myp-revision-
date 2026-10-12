-- Shared caches that cut AI cost. Both tables are written and read ONLY by server functions using the
-- service-role key (RLS is on and there are deliberately no policies, so the public/anon key cannot touch them).

-- 1. AI verdicts for typed answers, keyed by question and the normalised first-attempt answer text.
create table if not exists public.answer_cache (
  id uuid primary key default gen_random_uuid(),
  question_id uuid not null references public.questions(id) on delete cascade,
  answer_key text not null check (char_length(answer_key) between 1 and 200),
  verdict text not null check (verdict in ('correct', 'partial', 'wrong')),
  feedback text not null check (char_length(feedback) between 1 and 800),
  uses integer not null default 1,
  created_at timestamptz not null default now(),
  unique (question_id, answer_key)
);
alter table public.answer_cache enable row level security;

-- 2. Exam tasks written by the AI, shared so later students get unseen tasks without a new AI call.
create table if not exists public.generated_tasks (
  id uuid primary key default gen_random_uuid(),
  subject_id uuid not null references public.subjects(id) on delete cascade,
  grade integer not null check (grade between 1 and 5),
  topic_name text,
  marks integer not null check (marks between 1 and 60),
  criterion text,
  content text not null,
  mark_scheme text not null,
  kind text not null default 'written',
  reports integer not null default 0,
  times_served integer not null default 0,
  created_at timestamptz not null default now()
);
create index if not exists generated_tasks_lookup on public.generated_tasks (subject_id, grade) where reports = 0;
alter table public.generated_tasks enable row level security;
