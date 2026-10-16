-- ORDER: run 0008 before 0009, and do not re-run 0008 afterwards (it would re-create the old 4-argument
-- functions next to these). If you ever do, simply run this file again: it drops them first.
-- Separate daily AI allowances ("buckets"): typed-answer checks ('check') versus exam marking and writing ('exam'),
-- so heavy typed practice can never use up the units that pay for marking an exam.
-- Safe to run once after 0008. The app works without it (it falls back to the single shared 0008 pool).
-- The 4-argument 0008 overloads are dropped below; a call with four arguments still works through the default and lands in the 'exam' bucket.

alter table public.ai_usage add column if not exists bucket text not null default 'exam';
alter table public.ai_usage_global add column if not exists bucket text not null default 'exam';

do $$
begin
  if not exists (
    select 1 from pg_index i
    join pg_attribute a on a.attrelid = i.indrelid and a.attnum = any (i.indkey)
    where i.indrelid = 'public.ai_usage'::regclass and i.indisprimary and a.attname = 'bucket'
  ) then
    alter table public.ai_usage drop constraint if exists ai_usage_pkey;
    alter table public.ai_usage add primary key (user_id, day, bucket);
  end if;
  if not exists (
    select 1 from pg_index i
    join pg_attribute a on a.attrelid = i.indrelid and a.attnum = any (i.indkey)
    where i.indrelid = 'public.ai_usage_global'::regclass and i.indisprimary and a.attname = 'bucket'
  ) then
    alter table public.ai_usage_global drop constraint if exists ai_usage_global_pkey;
    alter table public.ai_usage_global add primary key (day, bucket);
  end if;
end $$;

-- Replace the 0008 functions with bucket-aware ones (p_bucket defaults to 'exam').
drop function if exists public.ai_usage_take(uuid, integer, integer, integer);
drop function if exists public.ai_usage_refund(uuid, integer);

create or replace function public.ai_usage_take(
  p_user uuid, p_cost integer, p_user_cap integer, p_global_cap integer, p_bucket text default 'exam'
) returns text
language plpgsql security definer set search_path = public, pg_temp as $$
declare
  d date := (now() at time zone 'utc')::date;
  g integer;
  u integer;
begin
  if p_bucket is null or p_bucket not in ('exam', 'check') then
    raise exception 'ai_usage_take: unknown bucket %', p_bucket;
  end if;
  insert into public.ai_usage_global (day, bucket) values (d, p_bucket) on conflict do nothing;
  select units into g from public.ai_usage_global where day = d and bucket = p_bucket for update;
  if g + p_cost > p_global_cap then return 'global_cap'; end if;
  insert into public.ai_usage (user_id, day, bucket) values (p_user, d, p_bucket) on conflict do nothing;
  select units into u from public.ai_usage where user_id = p_user and day = d and bucket = p_bucket for update;
  if u + p_cost > p_user_cap then return 'user_cap'; end if;
  update public.ai_usage_global set units = units + p_cost where day = d and bucket = p_bucket;
  update public.ai_usage set units = units + p_cost where user_id = p_user and day = d and bucket = p_bucket;
  return 'ok';
end;
$$;

create or replace function public.ai_usage_refund(p_user uuid, p_cost integer, p_bucket text default 'exam')
returns void
language plpgsql security definer set search_path = public, pg_temp as $$
declare d date := (now() at time zone 'utc')::date;
begin
  if p_bucket is null or p_bucket not in ('exam', 'check') then
    raise exception 'ai_usage_refund: unknown bucket %', p_bucket;
  end if;
  update public.ai_usage_global set units = greatest(0, units - p_cost) where day = d and bucket = p_bucket;
  update public.ai_usage set units = greatest(0, units - p_cost) where user_id = p_user and day = d and bucket = p_bucket;
end;
$$;

revoke all on function public.ai_usage_take(uuid, integer, integer, integer, text) from public, anon, authenticated;
revoke all on function public.ai_usage_refund(uuid, integer, text) from public, anon, authenticated;
grant execute on function public.ai_usage_take(uuid, integer, integer, integer, text) to service_role;
grant execute on function public.ai_usage_refund(uuid, integer, text) to service_role;
