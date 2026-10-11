insert into public.subjects (name, slug, subject_group, group_key, grades, position)
select 'Integrated Science', 'integrated-science', 'Sciences', 'sciences', '{1,2,3,4,5}', 21
where not exists (select 1 from public.subjects where slug = 'integrated-science');
