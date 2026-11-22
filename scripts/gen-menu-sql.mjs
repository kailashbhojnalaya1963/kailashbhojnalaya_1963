// scripts/gen-menu-sql.mjs
//
// Generates an idempotent SQL sync for the ACTIVE menu version, meant to be
// pasted into the Supabase SQL Editor (which runs as admin — no service-role
// key needed). Mirrors scripts/seed-menu.mjs exactly, but emits SQL instead of
// calling the API. Writes supabase/06_seed_menu_v2.sql and prints to stdout.
//
// Re-run whenever you switch ACTIVE_MENU_VERSION or add a new version:
//   node scripts/gen-menu-sql.mjs
//
// Notes:
//   • Transactional (begin/commit) — all-or-nothing.
//   • Upserts every item, so prices, renames, new items and sort_order all land.
//   • Deactivates (not deletes) items the active version removed, matching the
//     menu_items "readable when is_active" RLS policy.
//   • Never touches image_url, so admin-uploaded dish photos are preserved.

import { writeFileSync } from 'node:fs';
import {
  menuCategories,
  featuredItemIds,
  ACTIVE_MENU_VERSION,
} from '../src/data/menu.js';

const FEATURED = new Set(featuredItemIds);

const q = (s) => `'${String(s).replace(/'/g, "''")}'`; // SQL-quote + escape
const txt = (s) => (s === undefined || s === null ? 'null' : q(s));
const num = (n) => (n === undefined || n === null ? 'null' : String(n));
const arr = (a) =>
  a && a.length ? `array[${a.map(q).join(',')}]::text[]` : `'{}'::text[]`;

const catRows = menuCategories.map(
  (c, i) =>
    `  (${q(c.id)}, ${q(c.name)}, ${txt(c.tagline)}, ${txt(c.icon)}, ${txt(c.accent)}, ${i + 1}, ${Boolean(c.featured)})`
);

const allIds = [];
const itemRows = [];
for (const cat of menuCategories) {
  cat.items.forEach((item, idx) => {
    allIds.push(item.id);
    itemRows.push(
      `  (${q(item.id)}, ${q(cat.id)}, ${q(item.name)}, ${txt(item.description)}, ${q(item.price)}, ${num(item.priceNum)}, ${arr(item.tags)}, true, ${FEATURED.has(item.id)}, ${idx + 1})`
    );
  });
}

const idList = allIds.map(q).join(', ');

const sql = `-- ============================================================================
-- Kailash Bhojnalaya — Menu ${ACTIVE_MENU_VERSION.toUpperCase()} sync
-- Generated from src/data/menu.js (active version: ${ACTIVE_MENU_VERSION}).
-- Paste into Supabase -> SQL Editor -> Run. Idempotent & transactional.
-- The SQL Editor runs as admin, so no service-role key is required.
-- image_url is left untouched (admin-uploaded photos are preserved).
-- ============================================================================
begin;

-- 1) Categories ---------------------------------------------------------------
insert into public.menu_categories (id, name, tagline, icon, accent, sort_order, is_featured) values
${catRows.join(',\n')}
on conflict (id) do update set
  name        = excluded.name,
  tagline     = excluded.tagline,
  icon        = excluded.icon,
  accent      = excluded.accent,
  sort_order  = excluded.sort_order,
  is_featured = excluded.is_featured;

-- 2) Items — prices, new items, renames, featured flags, ordering -------------
insert into public.menu_items
  (id, category_id, name, description, price, price_num, tags, is_active, is_featured, sort_order) values
${itemRows.join(',\n')}
on conflict (id) do update set
  category_id = excluded.category_id,
  name        = excluded.name,
  description = excluded.description,
  price       = excluded.price,
  price_num   = excluded.price_num,
  tags        = excluded.tags,
  is_active   = excluded.is_active,
  is_featured = excluded.is_featured,
  sort_order  = excluded.sort_order,
  updated_at  = now();

-- 3) Deactivate items this version removed (e.g. the merged bhujiyas) ----------
update public.menu_items
   set is_active = false, updated_at = now()
 where id not in (${idList})
   and is_active = true;

commit;

-- Optional sanity check (run separately after committing):
-- select category_id, count(*) as active_items
--   from public.menu_items where is_active group by 1 order by 1;
`;

writeFileSync(new URL('../supabase/06_seed_menu_v2.sql', import.meta.url), sql);
process.stdout.write(sql);
