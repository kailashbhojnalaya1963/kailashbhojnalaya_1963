// ─────────────────────────────────────────────────────────────────────────
// MENU — version selector & shared helpers
// ─────────────────────────────────────────────────────────────────────────
// The actual item/price data lives in versioned snapshot files:
//   • menu.v1.js — original printed menu
//   • menu.v2.js — updated printed menu (current)
//
// To switch the whole site to a different pricing version, change the ONE
// line below (ACTIVE_MENU_VERSION) and re-run `node scripts/seed-menu.mjs`
// so the live Supabase DB matches (the DB is the runtime source of truth;
// this bundled data is the optimistic render + offline fallback).
//
// When a new menu photo arrives: add menu.v3.js, import it here, add it to
// VERSIONS, and bump ACTIVE_MENU_VERSION to 'v3'. See VERSIONS.md.

import { menuCategories as menuV1 } from './menu.v1.js';
import { menuCategories as menuV2 } from './menu.v2.js';

// ─── ACTIVE PRICING VERSION ──────────────────────────────────────────────
// Flip this to 'v1' to instantly roll back to the old pricing.
export const ACTIVE_MENU_VERSION = 'v2';
// ─────────────────────────────────────────────────────────────────────────

const MENU_VERSIONS = {
  v1: menuV1,
  v2: menuV2,
};

export const menuCategories =
  MENU_VERSIONS[ACTIVE_MENU_VERSION] ?? menuV2;

export const menuMeta = {
  notice: 'GST charges extra. Pure vegetarian kitchen.',
  packagingNote: 'A flat ₹20 delivery charge is added to every order.',
};

// Helpers used by UI / Supabase sync.
export function getCategoryById(id) {
  return menuCategories.find((c) => c.id === id) || null;
}

export function getAllItems() {
  return menuCategories.flatMap((c) =>
    c.items.map((item) => ({ ...item, categoryId: c.id, categoryName: c.name }))
  );
}

export function searchItems(query) {
  const q = query.trim().toLowerCase();
  if (!q) return [];
  return getAllItems().filter(
    (i) =>
      i.name.toLowerCase().includes(q) ||
      i.categoryName.toLowerCase().includes(q) ||
      (i.description && i.description.toLowerCase().includes(q))
  );
}

// Curated picks shown on the home page preview. These ids are stable across
// versions, so featured dishes keep working whichever version is active.
export const featuredItemIds = [
  'thali-special',
  'shahi-paneer',
  'paneer-tikka',
  'veg-biryani',
  'dal-makhani',
  'masala-dosa',
];

export function getFeaturedItems() {
  const all = getAllItems();
  return featuredItemIds
    .map((id) => all.find((i) => i.id === id))
    .filter(Boolean);
}
