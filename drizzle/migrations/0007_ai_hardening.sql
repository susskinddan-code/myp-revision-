-- AI hardening: atomic counters, report thresholds, index fix, dedupe and criterion check.
-- answer_cache and generated_tasks stay server-only: RLS on, deliberately no policies.

-- 1. Report counter for cached verdicts (retired at 3 reports).
alter table public.answer_cache add column if not exists reports integer not null default 0;

-- 2. Atomic counters. Called only by server functions with the service-role key.
create or replace function public.bump_cache_use(p_id uuid) returns void
language sql security definer set search_path = public as $$
  update public.answer_cache set uses = uses + 1 where id = p_id;
$$;

create or replace function public.bump_task_served(p_ids uuid[]) returns void
language sql security definer set search_path = public as $$
  update public.generated_tasks set times_served = times_served + 1 where id = any(p_ids);
$$;

-- Returns the new report count; the task drops out of the bank (reports < 3) at 3.
create or replace function public.bump_task_report(p_id uuid) returns integer
language sql security definer set search_path = public as $$
  update public.generated_tasks set reports = reports + 1 where id = p_id returning reports;
$$;

-- Counts a report against one cached verdict (exact key match) and deletes it at 3 reports.
create or replace function public.report_cached_check(p_question_id uuid, p_key text) returns integer
language plpgsql security definer set search_path = public as $$
declare
  n integer;
begin
  update public.answer_cache set reports = reports + 1
    where question_id = p_question_id and answer_key = p_key
    returning reports into n;
  if n is not null and n >= 3 then
    delete from public.answer_cache where question_id = p_question_id and answer_key = p_key;
  end if;
  return coalesce(n, 0);
end;
$$;

revoke all on function public.bump_cache_use(uuid) from public, anon, authenticated;
revoke all on function public.bump_task_served(uuid[]) from public, anon, authenticated;
revoke all on function public.bump_task_report(uuid) from public, anon, authenticated;
revoke all on function public.report_cached_check(uuid, text) from public, anon, authenticated;
grant execute on function public.bump_cache_use(uuid) to service_role;
grant execute on function public.bump_task_served(uuid[]) to service_role;
grant execute on function public.bump_task_report(uuid) to service_role;
grant execute on function public.report_cached_check(uuid, text) to service_role;

-- 3. Criterion must be A-D. NOT VALID so existing rows cannot block the migration; new rows are checked.
do $$
begin
  if not exists (select 1 from pg_constraint where conname = 'generated_tasks_criterion_check') then
    alter table public.generated_tasks
      add constraint generated_tasks_criterion_check
      check (criterion is null or criterion in ('A', 'B', 'C', 'D')) not valid;
  end if;
end $$;

-- 4. The bank query filters reports < 3 and orders by times_served; the old index only covered reports = 0.
drop index if exists public.generated_tasks_lookup;
create index if not exists generated_tasks_lookup
  on public.generated_tasks (subject_id, grade, times_served) where reports < 3;

-- 5. Never store the same task twice (the server skips a row that hits this index).
delete from public.generated_tasks a
  using public.generated_tasks b
  where md5(a.content) = md5(b.content)
    and (a.created_at, a.id) > (b.created_at, b.id);
create unique index if not exists generated_tasks_content_md5 on public.generated_tasks (md5(content));
