-- Allow non-MCQ (short answer / criterion) items to store an empty options array
CREATE OR REPLACE FUNCTION public.is_mcq_options(j jsonb)
RETURNS boolean
LANGUAGE sql
IMMUTABLE
AS $$
  SELECT jsonb_typeof(j) = 'array'
     AND (
       jsonb_array_length(j) = 0
       OR (
         jsonb_array_length(j) = 4
         AND NOT EXISTS (
           SELECT 1 FROM jsonb_array_elements(j) e
           WHERE jsonb_typeof(e) <> 'string' OR length(btrim(e #>> '{}')) = 0
         )
       )
     )
$$;

-- Clear seeded sample content ahead of the legacy import (order respects FKs)
DELETE FROM public.question_attempts;
DELETE FROM public.paper_questions;
DELETE FROM public.past_papers;
DELETE FROM public.notes;
DELETE FROM public.flashcards;
DELETE FROM public.questions;
DELETE FROM public.topics;
DELETE FROM public.subjects;
