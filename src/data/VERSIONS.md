# Menu pricing versions

The menu data is versioned so we can swap the entire site's pricing and roll
back instantly.

## How it works

- **`menu.v1.js`, `menu.v2.js`, …** — frozen snapshots. Each exports a complete
  `menuCategories` array for that printed menu. Never edit an old snapshot.
- **`menu.js`** — the selector. It imports every version and exposes the active
  one via `ACTIVE_MENU_VERSION`. All app code imports from `menu.js` only.

### To switch versions

1. In `menu.js`, set `ACTIVE_MENU_VERSION` to the version you want (e.g. `'v1'`).
2. Re-run the DB seed so the live site matches:
   ```bash
   # add SUPABASE_SERVICE_ROLE_KEY to .env (temporarily), then:
   node scripts/seed-menu.mjs
   ```
   This matters because **Supabase is the runtime source of truth** — the
   bundled `menu.*.js` data is only the optimistic first render + offline
   fallback. Editing code without re-seeding leaves the live prices unchanged.

### To add a new menu (v3, v4, …)

1. Copy the current active snapshot to `menu.v3.js`, apply the new photo's changes.
2. In `menu.js`: import it, add it to `MENU_VERSIONS`, bump `ACTIVE_MENU_VERSION`.
3. Re-seed (step 2 above).
4. Add a changelog section below.

---

## v2 — updated laminated menu card  *(active)*

~36 price changes, 5 new items, 2 structural changes. Everything else is
unchanged from v1.

### New items
| Category | Item | Price |
| --- | --- | --- |
| Thali | Rice & Butter Roti Half Thali | ₹110 |
| Bhujiya | Punjabi Kadi Pakoda | ₹80 |
| Bhujiya | Baingan Bharta | ₹80 |
| Milkshakes | Lassi | ₹60 |
| Milkshakes | Chhachh (Buttermilk) | ₹50 |

### Structural changes
- **Bhujiya:** `parval-bhujiya` + `bhindi-bhujiya` + `karela-bhujiya` (3 items,
  ₹90 each) merged into one line `parval-bhindi-karela-bhujiya` — "Parval /
  Bhindi / Karela Bhujiya" ₹90. (The seed script deactivates the 3 old ids.)
- **Paneer:** `paneer-tikka` renamed "Paneer Tikka" → "Paneer Tikka / Masala"
  with dual price **₹200 / ₹240** (was a single ₹270). Id kept stable.

### Price changes (existing items)
| Category | Item | v1 | v2 |
| --- | --- | --- | --- |
| Paneer | Paneer Butter Masala | ₹200 | ₹220 |
| Paneer | Shahi Paneer | ₹250 | ₹260 |
| Paneer | Mattar Paneer | ₹190 | ₹200 |
| Paneer | Paneer Pakoda (8 pcs) | ₹170 | ₹180 |
| Paneer | Paneer Do Pyaja | ₹230 | ₹250 |
| Paneer | Paneer Kadhai | ₹230 | ₹250 |
| Paneer | Mix Veg | ₹180 | ₹200 |
| Paneer | Paneer Chatpatta | ₹230 | ₹260 |
| Paneer | Paneer Garlic | ₹230 | ₹260 |
| Mushroom | Mushroom Butter Masala | ₹230 | ₹240 |
| Mushroom | Mushroom Do Pyaja | ₹240 | ₹250 |
| Mushroom | Mushroom Kadhai | ₹250 | ₹260 |
| Mushroom | Mushroom Capsicum Masala | ₹250 | ₹260 |
| Mushroom | Mushroom Garlic | ₹250 | ₹260 |
| Green Veg | Aloo Do Pyaja / Dum Aloo / Aloo Jeera | ₹110 | ₹120 |
| Bhujiya | Paneer Bhujiya | ₹150 | ₹160 |
| Roti | Aloo Parantha | ₹40 | ₹50 |
| Roti | Paneer Parantha | ₹60 | ₹70 |
| Roti | Gobhi Parantha | ₹60 | ₹70 |
| Rice | Jeera Rice | ₹90 | ₹100 |
| Rice | Veg Biryani | ₹140 | ₹150 |
| Rice | Veg Fried Rice | ₹130 | ₹140 |
| Rice | Veg Pulao | ₹130 | ₹140 |
| Rice | Mutter Pulao | ₹130 | ₹140 |
| South Indian | Masala Dosa | ₹90 | ₹100 |
| South Indian | Onion Dosa | ₹80 | ₹90 |
| South Indian | Masala Paneer Dosa | ₹120 | ₹130 |
| South Indian | Butter Masala Dosa | ₹100 | ₹120 |
| South Indian | Cheese Plain Dosa | ₹120 | ₹130 |
| South Indian | Cheese Masala Dosa | ₹130 | ₹140 |
| South Indian | Uttapam | ₹60 | ₹70 |
| Chinese | Mushroom Chilli | ₹240 | ₹250 |
| Chinese | Paneer Chilli | ₹230 | ₹240 |
| Chinese | Veg Manchurian | ₹190 | ₹200 |
| Desserts | Ras Malai | ₹60 | ₹70 |
| Desserts | Kheer | ₹60 | ₹70 |

### Unchanged categories
Soya Veggies · Dal · Papad & Salad — plus all other items not listed above.

---

## v1 — original printed menu  *(2026-04-27 photos)*

The first digitised menu. Kept as the rollback baseline.
