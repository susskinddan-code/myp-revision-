-- Persistent AI usage limits and per-user report de-duplication.
-- Everything here is server-only: RLS on, no policies, functions granted to service_role only.

-- 1. Daily usage in "units" (a typed-answer check costs 1, marking a paper 5, writing an exam 20).
create table if not exists public.ai_usage (
  user_id uuid not null,
  day date not null,
  units integer not null default 0,
  primary key (user_id, day)
);
create table if not exists public.ai_usage_global (
  day date primary key,
  units integer not null default 0
);
alter table public.ai_usage enable row level security;
alter table public.ai_usage_global enable row level security;
revoke all on table public.ai_usage, public.ai_usage_global from anon, authenticated;

-- Atomically takes p_cost units for today. Returns 'ok', 'user_cap' or 'global_cap' (nothing is charged
-- when a cap would be exceeded). Row locks serialise concurrent calls.
create or replace function public.ai_usage_take(
  p_user uuid, p_cost integer, p_user_cap integer, p_global_cap integer
) returns text
language plpgsql security definer set search_path = public, pg_temp as $$
declare
  d date := (now() at time zone 'utc')::date;
  g integer;
  u integer;
begin
  insert into public.ai_usage_global (day) values (d) on conflict do nothing;
  select units into g from public.ai_usage_global where day = d for update;
  if g + p_cost > p_global_cap then return 'global_cap'; end if;
  insert into public.ai_usage (user_id, day) values (p_user, d) on conflict do nothing;
  select units into u from public.ai_usage where user_id = p_user and day = d for update;
  if u + p_cost > p_user_cap then return 'user_cap'; end if;
  update public.ai_usage_global set units = units + p_cost where day = d;
  update public.ai_usage set units = units + p_cost where user_id = p_user and day = d;
  return 'ok';
end;
$$;

-- Gives units back after a call that failed (so outages are not charged to the student).
create or replace function public.ai_usage_refund(p_user uuid, p_cost integer) returns void
language plpgsql security definer set search_path = public, pg_temp as $$
declare d date := (now() at time zone 'utc')::date;
begin
  update public.ai_usage_global set units = greatest(0, units - p_cost) where day = d;
  update public.ai_usage set units = greatest(0, units - p_cost) where user_id = p_user and day = d;
end;
$$;

-- 2. One report per user per target; a verdict or task is retired at 3 DISTINCT users.
create table if not exists public.ai_reports (
  user_id uuid not null,
  kind text not null check (kind in ('cache', 'task')),
  target text not null,
  created_at timestamptz not null default now(),
  primary key (user_id, kind, target)
);
alter table public.ai_reports enable row level security;
revoke all on table public.ai_reports from anon, authenticated;

create or replace function public.report_cached_check_v2(p_user uuid, p_question_id uuid, p_key text)
returns integer
language plpgsql security definer set search_path = public, pg_temp as $$
declare
  t text := p_question_id::text || '|' || p_key;
  n integer;
begin
  insert into public.ai_reports (user_id, kind, target) values (p_user, 'cache', t) on conflict do nothing;
  select count(*) into n from public.ai_reports where kind = 'cache' and target = t;
  update public.answer_cache set reports = n where question_id = p_question_id and answer_key = p_key;
  if n >= 3 then
    delete from public.answer_cache where question_id = p_question_id and answer_key = p_key;
    delete from public.ai_reports where kind = 'cache' and target = t;
  end if;
  return n;
end;
$$;

create or replace function public.bump_task_report_v2(p_user uuid, p_id uuid) returns integer
language plpgsql security definer set search_path = public, pg_temp as $$
declare
  t text := p_id::text;
  n integer;
begin
  insert into public.ai_reports (user_id, kind, target) values (p_user, 'task', t) on conflict do nothing;
  select count(*) into n from public.ai_reports where kind = 'task' and target = t;
  update public.generated_tasks set reports = n where id = p_id;
  return n;
end;
$$;

revoke all on function public.ai_usage_take(uuid, integer, integer, integer) from public, anon, authenticated;
revoke all on function public.ai_usage_refund(uuid, integer) from public, anon, authenticated;
revoke all on function public.report_cached_check_v2(uuid, uuid, text) from public, anon, authenticated;
revoke all on function public.bump_task_report_v2(uuid, uuid) from public, anon, authenticated;
grant execute on function public.ai_usage_take(uuid, integer, integer, integer) to service_role;
grant execute on function public.ai_usage_refund(uuid, integer) to service_role;
grant execute on function public.report_cached_check_v2(uuid, uuid, text) to service_role;
grant execute on function public.bump_task_report_v2(uuid, uuid) to service_role;

-- 3. The old single-user report functions are replaced by the _v2 ones above.
drop function if exists public.report_cached_check(uuid, text);
drop function if exists public.bump_task_report(uuid);

-- 4. Defence in depth from the review (L3): no table grants for anon/authenticated on the server-only tables.
revoke all on table public.answer_cache, public.generated_tasks from anon, authenticated;
