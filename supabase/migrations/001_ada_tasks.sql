-- Abould ADA — Supabase tasks (auth + CRUD + Realtime)
-- Run in Supabase Dashboard → SQL Editor

create table if not exists public.ada_tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  title text not null default '',
  is_completed boolean not null default false,
  created_at timestamptz not null default timezone('utc', now())
);

create index if not exists ada_tasks_user_id_created_at_idx
  on public.ada_tasks (user_id, created_at desc);

alter table public.ada_tasks enable row level security;

drop policy if exists "ada_tasks_select_own" on public.ada_tasks;
create policy "ada_tasks_select_own"
  on public.ada_tasks for select
  using (auth.uid() = user_id);

drop policy if exists "ada_tasks_insert_own" on public.ada_tasks;
create policy "ada_tasks_insert_own"
  on public.ada_tasks for insert
  with check (auth.uid() = user_id);

drop policy if exists "ada_tasks_update_own" on public.ada_tasks;
create policy "ada_tasks_update_own"
  on public.ada_tasks for update
  using (auth.uid() = user_id);

drop policy if exists "ada_tasks_delete_own" on public.ada_tasks;
create policy "ada_tasks_delete_own"
  on public.ada_tasks for delete
  using (auth.uid() = user_id);

alter publication supabase_realtime add table public.ada_tasks;
