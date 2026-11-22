// scripts/verify-menu-db.mjs
//
// Reads the LIVE menu from Supabase using the ANON key (the same read path as
// the public site) and diffs it against the active version in src/data/menu.js.
// Use it to confirm a seed / SQL sync landed correctly. Read-only, safe.
//
//   node scripts/verify-menu-db.mjs

import 'dotenv/config';
import { createClient } from '@supabase/supabase-js';
import { menuCategories, ACTIVE_MENU_VERSION } from '../src/data/menu.js';

const url = process.env.VITE_SUPABASE_URL;
const anon = process.env.VITE_SUPABASE_ANON_KEY;
if (!url || !anon) {
  console.error('Missing VITE_SUPABASE_URL / VITE_SUPABASE_ANON_KEY in .env');
  process.exit(1);
}

const supabase = createClient(url, anon, { auth: { persistSession: false } });

// Expected items from the active version in code.
const expected = new Map();
for (const c of menuCategories)
  for (const it of c.items)
    expected.set(it.id, { name: it.name, price: it.price, priceNum: it.priceNum });

// Anon RLS returns only is_active = true rows — exactly what customers see.
const { data, error } = await supabase
  .from('menu_items')
  .select('id,name,price,price_num,category_id')
  .limit(1000);

if (error) {
  console.error('Fetch failed:', error.message);
  process.exit(1);
}

const live = new Map(data.map((r) => [r.id, r]));
let problems = 0;

for (const [id, e] of expected) {
  const l = live.get(id);
  if (!l) {
    console.log(`MISSING in live DB (or inactive): ${id}`);
    problems++;
    continue;
  }
  if (l.price !== e.price || l.price_num !== e.priceNum) {
    console.log(`PRICE mismatch ${id}: live ${l.price}/${l.price_num} vs expected ${e.price}/${e.priceNum}`);
    problems++;
  }
  if (l.name !== e.name) {
    console.log(`NAME mismatch ${id}: live "${l.name}" vs expected "${e.name}"`);
    problems++;
  }
}
for (const id of live.keys()) {
  if (!expected.has(id)) {
    console.log(`STALE active item still live (should be deactivated): ${id}`);
    problems++;
  }
}

console.log(`\nActive version (code): ${ACTIVE_MENU_VERSION}`);
console.log(`Expected active items: ${expected.size}`);
console.log(`Live active items:     ${live.size}`);
// A few explicit spot-checks for the eyeball:
for (const id of ['veg-fried-rice', 'paneer-butter-masala', 'paneer-tikka', 'lassi', 'baingan-bharta']) {
  const l = live.get(id);
  console.log(`  ${id}: ${l ? l.price : '(absent)'}`);
}
console.log(problems === 0 ? '\n✅ Live DB matches menu.js exactly — v2 is live.' : `\n⚠️  ${problems} problem(s) found above.`);
process.exit(problems === 0 ? 0 : 1);
