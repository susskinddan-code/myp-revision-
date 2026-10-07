-- MYP Revision core schema
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  display_name text,
  grade int check (grade between 1 and 5),
  streak_days int not null default 0,
  last_active_at timestamptz,
  created_at timestamptz not null default now()
);
grant select, insert, update on public.profiles to authenticated;
grant all on public.profiles to service_role;
alter table public.profiles enable row level security;
create policy "own profile select" on public.profiles for select to authenticated using (auth.uid() = id);
create policy "own profile insert" on public.profiles for insert to authenticated with check (auth.uid() = id);
create policy "own profile update" on public.profiles for update to authenticated using (auth.uid() = id) with check (auth.uid() = id);

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, email, display_name)
  values (new.id, new.email, coalesce(new.raw_user_meta_data->>'display_name', split_part(new.email, '@', 1)))
  on conflict (id) do nothing;
  return new;
end;
$$;
create trigger on_auth_user_created after insert on auth.users
for each row execute function public.handle_new_user();

create or replace function public.is_mcq_options(j jsonb)
returns boolean language sql immutable set search_path = public as $$
  select jsonb_typeof(j) = 'array'
     and jsonb_array_length(j) = 4
     and (select bool_and(jsonb_typeof(e) = 'string' and length(trim(e #>> '{}')) > 0)
          from jsonb_array_elements(j) e);
$$;

create table public.subjects (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name text not null unique,
  subject_group text not null,
  group_key text not null,
  grades int[] not null default '{1,2,3,4,5}',
  description text,
  position int not null default 0
);
grant select on public.subjects to anon, authenticated;
grant all on public.subjects to service_role;
alter table public.subjects enable row level security;
create policy "subjects public read" on public.subjects for select to anon, authenticated using (true);

create table public.topics (
  id uuid primary key default gen_random_uuid(),
  subject_id uuid not null references public.subjects(id) on delete cascade,
  name text not null,
  grade int not null check (grade between 1 and 5),
  description text,
  position int not null default 0,
  unique (subject_id, name, grade)
);
create index topics_subject_grade_idx on public.topics (subject_id, grade);
grant select on public.topics to anon, authenticated;
grant all on public.topics to service_role;
alter table public.topics enable row level security;
create policy "topics public read" on public.topics for select to anon, authenticated using (true);

create table public.questions (
  id uuid primary key default gen_random_uuid(),
  subject_id uuid not null references public.subjects(id) on delete cascade,
  topic_id uuid not null references public.topics(id) on delete cascade,
  grade int not null check (grade between 1 and 5),
  type text not null default 'MCQ',
  content text not null check (length(trim(content)) > 0),
  options jsonb not null,
  answer int not null,
  explanation text,
  mark_scheme text,
  difficulty text not null default 'medium' check (difficulty in ('easy','medium','hard')),
  visual jsonb,
  created_at timestamptz not null default now(),
  constraint questions_options_four check (public.is_mcq_options(options)),
  constraint questions_answer_in_range check (answer >= 0 and answer <= 3)
);
create index questions_topic_idx on public.questions (topic_id);
create index questions_subject_grade_idx on public.questions (subject_id, grade);
grant select on public.questions to anon, authenticated;
grant all on public.questions to service_role;
alter table public.questions enable row level security;
create policy "questions public read" on public.questions for select to anon, authenticated using (true);

create table public.flashcards (
  id uuid primary key default gen_random_uuid(),
  subject_id uuid not null references public.subjects(id) on delete cascade,
  topic_id uuid not null references public.topics(id) on delete cascade,
  grade int not null check (grade between 1 and 5),
  front text not null,
  back text not null,
  created_at timestamptz not null default now()
);
create index flashcards_subject_grade_idx on public.flashcards (subject_id, grade);
create index flashcards_topic_idx on public.flashcards (topic_id);
grant select on public.flashcards to anon, authenticated;
grant all on public.flashcards to service_role;
alter table public.flashcards enable row level security;
create policy "flashcards public read" on public.flashcards for select to anon, authenticated using (true);

create table public.notes (
  id uuid primary key default gen_random_uuid(),
  topic_id uuid not null unique references public.topics(id) on delete cascade,
  content text not null
);
grant select on public.notes to anon, authenticated;
grant all on public.notes to service_role;
alter table public.notes enable row level security;
create policy "notes public read" on public.notes for select to anon, authenticated using (true);

create table public.past_papers (
  id uuid primary key default gen_random_uuid(),
  subject_id uuid not null references public.subjects(id) on delete cascade,
  title text not null,
  grade int not null check (grade between 1 and 5),
  year int,
  criterion text,
  is_generated boolean not null default true,
  created_at timestamptz not null default now()
);
grant select on public.past_papers to anon, authenticated;
grant all on public.past_papers to service_role;
alter table public.past_papers enable row level security;
create policy "papers public read" on public.past_papers for select to anon, authenticated using (true);

create table public.paper_questions (
  id uuid primary key default gen_random_uuid(),
  paper_id uuid not null references public.past_papers(id) on delete cascade,
  position int not null,
  content text not null,
  options jsonb not null,
  answer int not null check (answer >= 0 and answer <= 3),
  mark_scheme text,
  criterion text,
  constraint paper_questions_options_four check (public.is_mcq_options(options))
);
create index paper_questions_paper_idx on public.paper_questions (paper_id);
grant select on public.paper_questions to anon, authenticated;
grant all on public.paper_questions to service_role;
alter table public.paper_questions enable row level security;
create policy "paper questions public read" on public.paper_questions for select to anon, authenticated using (true);

create table public.question_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  question_id uuid references public.questions(id) on delete set null,
  topic_id uuid references public.topics(id) on delete set null,
  subject_id uuid references public.subjects(id) on delete set null,
  source text not null default 'question-bank' check (source in ('question-bank','practice-paper','flashcards')),
  correct boolean not null,
  created_at timestamptz not null default now()
);
create index attempts_user_idx on public.question_attempts (user_id, created_at desc);
create index attempts_user_subject_idx on public.question_attempts (user_id, subject_id);
grant select, insert on public.question_attempts to authenticated;
grant all on public.question_attempts to service_role;
alter table public.question_attempts enable row level security;
create policy "own attempts select" on public.question_attempts for select to authenticated using (auth.uid() = user_id);
create policy "own attempts insert" on public.question_attempts for insert to authenticated with check (auth.uid() = user_id);