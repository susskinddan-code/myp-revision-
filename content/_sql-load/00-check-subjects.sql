select slug, name from public.subjects
where slug in ('french-ab-initio','spanish-ab-initio','mandarin-ab-initio','french-language-and-literature','spanish-language-and-literature','environmental-systems','visual-arts','music','drama','product-design','digital-design','physical-health-education')
order by slug;
