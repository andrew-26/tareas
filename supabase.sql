-- Pega esto en Supabase → SQL Editor → Run
create table if not exists public.tasks(
  id text primary key, n text not null, s text not null, e text not null,
  st text not null default 'pend', p int default 0, g text default '', no text default '',
  updated_at timestamptz default now());
alter table public.tasks enable row level security;
drop policy if exists "solo eve" on public.tasks;
create policy "solo eve" on public.tasks for all
  using ((auth.jwt()->>'email') = 'arecamaless@gmail.com')
  with check ((auth.jwt()->>'email') = 'arecamaless@gmail.com');
alter publication supabase_realtime add table public.tasks;
