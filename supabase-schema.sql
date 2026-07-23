-- Run this once in your Supabase project's SQL editor (Supabase Dashboard →
-- SQL Editor → New query → paste this → Run) before deploying the backend
-- with real accounts enabled.

create extension if not exists pgcrypto;

create table if not exists users (
  id uuid primary key default gen_random_uuid(),
  email text unique not null,
  password_hash text not null,
  username text not null,
  bio text default '',
  avatar_url text default '',
  location text default '',
  website text default '',
  created_at timestamptz not null default now()
);

create table if not exists password_reset_tokens (
  token text primary key,
  user_id uuid not null references users(id) on delete cascade,
  expires_at timestamptz not null,
  used boolean not null default false,
  created_at timestamptz not null default now()
);

create index if not exists idx_password_reset_tokens_user_id on password_reset_tokens(user_id);
