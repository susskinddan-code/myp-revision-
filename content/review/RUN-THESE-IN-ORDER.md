# What to run in the Supabase SQL editor (project qntfyxrlnvdsqklaedcm), in this order

All are safe to re-run. Paste each file into the SQL editor and press Run.

1. `drizzle/migrations/0007_ai_hardening.sql` (cache counters, RPC lock-down)
2. `drizzle/migrations/0008_rate_limits.sql` (daily AI allowance, report de-dup, revokes anon access to the cache tables)
3. `content/fixes/humanities-fixes.sql`  (expect 23 x UPDATE 1)
4. `content/review/humanities-fixes.sql` (19 x UPDATE 1, 1 x UPDATE 2)
5. `content/fixes/language-fixes.sql`    (42 x UPDATE 1)
6. `content/review/languages-fixes.sql`  (10 x UPDATE 1)
7. `content/review/language-fixes.sql`   (11 x UPDATE 1)
8. `content/papers-widgets/load.sql`     (11 interactive-widget papers)
9. `content/biology-myp4/sql/part-01-of-06.sql` ... `part-06-of-06.sql` (Biology MYP 4, 33 sub-topics). Check first that no MYP 4 Biology top-level topic has the same name as one of the new sub-topics.

If a fix file reports UPDATE 0 for a whole subject, check that subject's slug in the `subjects` table.

Then, in the host's secret settings and in an untracked `.env.local`:
`ANTHROPIC_API_KEY`, `SUPABASE_SERVICE_ROLE_KEY`, optionally `TASK_SIGNING_KEY`, `AI_USER_DAILY_UNITS` (default 400), `AI_DAILY_BUDGET_UNITS` (default 20000).
In Supabase: turn on "Confirm email", enable the Google provider, and add the site URL and `<site>/auth` to the redirect allow-list.
