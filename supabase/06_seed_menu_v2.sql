-- ============================================================================
-- Kailash Bhojnalaya — Menu V2 sync
-- Generated from src/data/menu.js (active version: v2).
-- Paste into Supabase -> SQL Editor -> Run. Idempotent & transactional.
-- The SQL Editor runs as admin, so no service-role key is required.
-- image_url is left untouched (admin-uploaded photos are preserved).
-- ============================================================================
begin;

-- 1) Categories ---------------------------------------------------------------
insert into public.menu_categories (id, name, tagline, icon, accent, sort_order, is_featured) values
  ('thali', 'Thali', 'Complete meals, the heart of Kailash', '🍽️', 'from-leaf-200/70 to-leaf-100/60', 1, true),
  ('paneer', 'Paneer', 'Fresh-made paneer in twelve avatars', '🧀', 'from-cream-100/80 to-leaf-50/80', 2, true),
  ('soya', 'Soya Veggies', 'Smoky, hearty, protein-rich', '🌱', 'from-leaf-100/70 to-cream-50/70', 3, false),
  ('mushroom', 'Mushroom', 'Earthy, slow-cooked classics', '🍄', 'from-cream-100/70 to-leaf-100/60', 4, false),
  ('green-veg', 'Green Veg', 'Garden-fresh seasonal sabzis', '🥬', 'from-leaf-100/70 to-leaf-50/60', 5, false),
  ('dal', 'Dal', 'Slow-simmered lentils', '🥣', 'from-cream-100/80 to-leaf-50/70', 6, false),
  ('bhujiya', 'Bhujiya', 'Stir-fried, light, full of crunch', '🥦', 'from-leaf-100/60 to-cream-100/70', 7, false),
  ('roti', 'Roti & Parantha', 'From the tandoor & tawa', '🫓', 'from-cream-100/80 to-leaf-50/60', 8, false),
  ('rice', 'Rice', 'Steamed, fragrant, and biryani-fresh', '🍚', 'from-leaf-50/80 to-cream-100/70', 9, false),
  ('south-indian', 'South Indian', 'Crisp dosas & soft idlis', '🥞', 'from-leaf-100/70 to-cream-50/70', 10, false),
  ('chinese', 'Chinese', 'Indo-Chinese, the Kailash way', '🥡', 'from-cream-100/70 to-leaf-100/70', 11, false),
  ('papad-salad', 'Papad & Salad', 'Sides, raitas & coolers', '🥗', 'from-leaf-50/70 to-cream-100/70', 12, false),
  ('milkshakes', 'Milkshakes', 'Thick, creamy, hand-blended', '🥤', 'from-cream-100/80 to-leaf-100/60', 13, false),
  ('desserts', 'Desserts', 'Sweet endings', '🍮', 'from-leaf-100/60 to-cream-100/80', 14, false)
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
  ('thali-rice-half-butter-roti', 'thali', 'Rice & Butter Roti Half Thali', 'Half plate — rice with two butter rotis, dal, sabzi, bhujia & chatni.', '₹110', 110, '{}'::text[], true, false, 1),
  ('thali-rice', 'thali', 'Rice Thali', 'Dal, sabzi, bhujia, chatni — served with steamed rice.', '₹100', 100, '{}'::text[], true, false, 2),
  ('thali-roti', 'thali', 'Roti Thali (4 pcs)', 'Dal, sabzi, bhujia, chatni with four tawa rotis.', '₹90', 90, '{}'::text[], true, false, 3),
  ('thali-butter-roti', 'thali', 'Butter Roti Thali (4 pcs)', 'Dal, sabzi, bhujia, chatni with four buttered rotis.', '₹110', 110, '{}'::text[], true, false, 4),
  ('thali-basmati', 'thali', 'Basmati Rice Thali', 'Long-grain basmati with dal, sabzi, bhujia, chatni.', '₹130', 130, '{}'::text[], true, false, 5),
  ('thali-green-veg', 'thali', 'Green Veg Thali', 'Two seasonal sabzis, green bhujia, dal, two rotis & rice.', '₹170', 170, array['Popular']::text[], true, false, 6),
  ('thali-special', 'thali', 'Kailash Special Thali', 'Paneer, seasonal sabzi, dal, two rotis, basmati rice, papad & sweet — the signature spread.', '₹240', 240, array['Signature','Recommended']::text[], true, true, 7),
  ('thali-chinese', 'thali', 'Chinese Thali', 'Chowmein, fried rice, manchurian, paneer chilli & Chinese salad.', '₹200', 200, '{}'::text[], true, false, 8),
  ('paneer-butter-masala', 'paneer', 'Paneer Butter Masala', null, '₹220', 220, '{}'::text[], true, false, 1),
  ('shahi-paneer', 'paneer', 'Shahi Paneer', null, '₹260', 260, array['Rich']::text[], true, true, 2),
  ('malai-kofta', 'paneer', 'Malai Kofta', null, '₹250', 250, '{}'::text[], true, false, 3),
  ('mattar-paneer', 'paneer', 'Mattar Paneer', null, '₹200', 200, '{}'::text[], true, false, 4),
  ('paneer-pakoda', 'paneer', 'Paneer Pakoda (8 pcs)', null, '₹180', 180, '{}'::text[], true, false, 5),
  ('paneer-do-pyaja', 'paneer', 'Paneer Do Pyaja', null, '₹250', 250, '{}'::text[], true, false, 6),
  ('paneer-kadhai', 'paneer', 'Paneer Kadhai', null, '₹250', 250, '{}'::text[], true, false, 7),
  ('mix-veg', 'paneer', 'Mix Veg', null, '₹200', 200, '{}'::text[], true, false, 8),
  ('palak-paneer', 'paneer', 'Palak Paneer', null, '₹200', 200, '{}'::text[], true, false, 9),
  ('paneer-chatpatta', 'paneer', 'Paneer Chatpatta', null, '₹260', 260, '{}'::text[], true, false, 10),
  ('paneer-garlic', 'paneer', 'Paneer Garlic', null, '₹260', 260, '{}'::text[], true, false, 11),
  ('paneer-tikka', 'paneer', 'Paneer Tikka / Masala', '₹200 tikka · ₹240 masala', '₹200 / ₹240', 200, array['Tandoor']::text[], true, true, 12),
  ('soya-veggets', 'soya', 'Soya Veggets', null, '₹150', 150, '{}'::text[], true, false, 1),
  ('soya-ball-manchurian', 'soya', 'Soya Ball Manchurian', null, '₹160', 160, '{}'::text[], true, false, 2),
  ('soya-chikka-butter', 'soya', 'Soya Chikka Butter Masala', null, '₹200', 200, '{}'::text[], true, false, 3),
  ('soya-chop-stick', 'soya', 'Soya Chop Stick (Dry)', null, '₹170', 170, '{}'::text[], true, false, 4),
  ('soya-bhurji', 'soya', 'Soya Scrambled Bhurji', null, '₹150', 150, '{}'::text[], true, false, 5),
  ('soya-chilli', 'soya', 'Soya Chilli', null, '₹210', 210, '{}'::text[], true, false, 6),
  ('mushroom-butter-masala', 'mushroom', 'Mushroom Butter Masala', null, '₹240', 240, '{}'::text[], true, false, 1),
  ('mushroom-do-pyaja', 'mushroom', 'Mushroom Do Pyaja', null, '₹250', 250, '{}'::text[], true, false, 2),
  ('mushroom-kadhai', 'mushroom', 'Mushroom Kadhai', null, '₹260', 260, '{}'::text[], true, false, 3),
  ('mushroom-capsicum', 'mushroom', 'Mushroom Capsicum Masala', null, '₹260', 260, '{}'::text[], true, false, 4),
  ('mushroom-garlic', 'mushroom', 'Mushroom Garlic', null, '₹260', 260, '{}'::text[], true, false, 5),
  ('chana-masala', 'green-veg', 'Chana Masala', null, '₹160', 160, '{}'::text[], true, false, 1),
  ('aloo-trio', 'green-veg', 'Aloo Do Pyaja / Dum Aloo / Aloo Jeera', null, '₹120', 120, '{}'::text[], true, false, 2),
  ('aloo-gobhi-trio', 'green-veg', 'Aloo Gobhi / Aloo Palak / Aloo Parwal', null, '₹130', 130, '{}'::text[], true, false, 3),
  ('gobhi-parwal-bhindi', 'green-veg', 'Gobhi / Parwal / Bhindi Masala', null, '₹150', 150, '{}'::text[], true, false, 4),
  ('dal-fry', 'dal', 'Dal Fry', null, '₹110', 110, '{}'::text[], true, false, 1),
  ('butter-dal-fry', 'dal', 'Butter Dal Fry', null, '₹130', 130, '{}'::text[], true, false, 2),
  ('paneer-tadka', 'dal', 'Paneer Tadka', null, '₹150', 150, '{}'::text[], true, false, 3),
  ('butter-tadka', 'dal', 'Butter Tadka', null, '₹130', 130, '{}'::text[], true, false, 4),
  ('plain-tadka', 'dal', 'Plain Tadka', null, '₹110', 110, '{}'::text[], true, false, 5),
  ('dal-makhani', 'dal', 'Dal Makhani', null, '₹150', 150, array['House favourite']::text[], true, true, 6),
  ('aloo-bhujiya', 'bhujiya', 'Aloo Bhujiya', null, '₹60', 60, '{}'::text[], true, false, 1),
  ('parval-bhindi-karela-bhujiya', 'bhujiya', 'Parval / Bhindi / Karela Bhujiya', null, '₹90', 90, '{}'::text[], true, false, 2),
  ('gobhi-bhujiya', 'bhujiya', 'Gobhi Bhujiya', null, '₹90', 90, '{}'::text[], true, false, 3),
  ('punjabi-kadi-pakoda', 'bhujiya', 'Punjabi Kadi Pakoda', null, '₹80', 80, '{}'::text[], true, false, 4),
  ('baingan-bharta', 'bhujiya', 'Baingan Bharta', null, '₹80', 80, '{}'::text[], true, false, 5),
  ('paneer-bhujiya', 'bhujiya', 'Paneer Bhujiya', null, '₹160', 160, '{}'::text[], true, false, 6),
  ('tawa-roti', 'roti', 'Tawa Roti', null, '₹10', 10, '{}'::text[], true, false, 1),
  ('butter-tawa-roti', 'roti', 'Butter Tawa Roti', null, '₹15', 15, '{}'::text[], true, false, 2),
  ('tandoori-roti', 'roti', 'Tandoori Roti', null, '₹15', 15, '{}'::text[], true, false, 3),
  ('butter-tandoori-roti', 'roti', 'Butter Tandoori Roti', null, '₹20', 20, '{}'::text[], true, false, 4),
  ('plain-parantha', 'roti', 'Plain Parantha (Ghee)', null, '₹40', 40, '{}'::text[], true, false, 5),
  ('butter-naan', 'roti', 'Butter Naan', null, '₹60', 60, '{}'::text[], true, false, 6),
  ('stuff-naan', 'roti', 'Stuff Naan / Kulcha', null, '₹70', 70, '{}'::text[], true, false, 7),
  ('aloo-parantha', 'roti', 'Aloo Parantha', null, '₹50', 50, '{}'::text[], true, false, 8),
  ('paneer-parantha', 'roti', 'Paneer Parantha', null, '₹70', 70, '{}'::text[], true, false, 9),
  ('gobhi-parantha', 'roti', 'Gobhi Parantha', null, '₹70', 70, '{}'::text[], true, false, 10),
  ('lachha-parantha', 'roti', 'Lachha Parantha', null, '₹40', 40, '{}'::text[], true, false, 11),
  ('millet-roti', 'roti', 'Bajara / Ragi / Makka / Jowar Roti', '₹20 plain · ₹25 buttered', '₹20 / ₹25', 20, '{}'::text[], true, false, 12),
  ('jeera-rice', 'rice', 'Jeera Rice', null, '₹100', 100, '{}'::text[], true, false, 1),
  ('steam-rice-fine', 'rice', 'Steam Rice (Fine)', null, '₹70', 70, '{}'::text[], true, false, 2),
  ('steam-rice-miniket', 'rice', 'Steam Rice (Miniket)', null, '₹50', 50, '{}'::text[], true, false, 3),
  ('veg-biryani', 'rice', 'Veg Biryani', null, '₹150', 150, array['Bestseller']::text[], true, true, 4),
  ('veg-fried-rice', 'rice', 'Veg Fried Rice', null, '₹140', 140, '{}'::text[], true, false, 5),
  ('veg-pulao', 'rice', 'Veg Pulao', null, '₹140', 140, '{}'::text[], true, false, 6),
  ('mutter-pulao', 'rice', 'Mutter Pulao', null, '₹140', 140, '{}'::text[], true, false, 7),
  ('plain-dosa', 'south-indian', 'Plain Dosa', null, '₹80', 80, '{}'::text[], true, false, 1),
  ('masala-dosa', 'south-indian', 'Masala Dosa', null, '₹100', 100, '{}'::text[], true, true, 2),
  ('onion-dosa', 'south-indian', 'Onion Dosa', null, '₹90', 90, '{}'::text[], true, false, 3),
  ('masala-paneer-dosa', 'south-indian', 'Masala Paneer Dosa', null, '₹130', 130, '{}'::text[], true, false, 4),
  ('butter-masala-dosa', 'south-indian', 'Butter Masala Dosa', null, '₹120', 120, '{}'::text[], true, false, 5),
  ('cheese-plain-dosa', 'south-indian', 'Cheese Plain Dosa', null, '₹130', 130, '{}'::text[], true, false, 6),
  ('cheese-masala-dosa', 'south-indian', 'Cheese Masala Dosa', null, '₹140', 140, '{}'::text[], true, false, 7),
  ('uttapam', 'south-indian', 'Uttapam (Onion / Tomato)', null, '₹70', 70, '{}'::text[], true, false, 8),
  ('idli-sambar', 'south-indian', 'Idli Sambar (2 pcs)', null, '₹60', 60, '{}'::text[], true, false, 9),
  ('veg-chowmein', 'chinese', 'Veg Chowmein', null, '₹120', 120, '{}'::text[], true, false, 1),
  ('special-chowmein', 'chinese', 'Special Chowmein', null, '₹160', 160, '{}'::text[], true, false, 2),
  ('mushroom-chilli', 'chinese', 'Mushroom Chilli (Dry / Gravy)', null, '₹250', 250, '{}'::text[], true, false, 3),
  ('paneer-chilli', 'chinese', 'Paneer Chilli (Dry / Gravy)', null, '₹240', 240, '{}'::text[], true, false, 4),
  ('veg-manchurian', 'chinese', 'Veg Manchurian', null, '₹200', 200, '{}'::text[], true, false, 5),
  ('papad', 'papad-salad', 'Papad', null, '₹15', 15, '{}'::text[], true, false, 1),
  ('green-salad', 'papad-salad', 'Green Salad', null, '₹60', 60, '{}'::text[], true, false, 2),
  ('onion-salad', 'papad-salad', 'Onion Salad', null, '₹30', 30, '{}'::text[], true, false, 3),
  ('raita', 'papad-salad', 'Raita (Mix / Pineapple / Boondi)', null, '₹80', 80, '{}'::text[], true, false, 4),
  ('dahi-milk', 'papad-salad', 'Dahi / Milk (200 ml)', null, '₹30', 30, '{}'::text[], true, false, 5),
  ('shake-chocolate', 'milkshakes', 'Chocolate Milkshake', null, '₹119', 119, '{}'::text[], true, false, 1),
  ('shake-vanilla', 'milkshakes', 'Vanilla Milkshake', null, '₹119', 119, '{}'::text[], true, false, 2),
  ('shake-strawberry', 'milkshakes', 'Strawberry Milkshake', null, '₹119', 119, '{}'::text[], true, false, 3),
  ('shake-oreo', 'milkshakes', 'Oreo Milkshake', null, '₹119', 119, '{}'::text[], true, false, 4),
  ('shake-butterscotch', 'milkshakes', 'Butterscotch Milkshake', null, '₹129', 129, '{}'::text[], true, false, 5),
  ('shake-blackcurrent', 'milkshakes', 'Black Current Milkshake', null, '₹119', 119, '{}'::text[], true, false, 6),
  ('lassi', 'milkshakes', 'Lassi', null, '₹60', 60, '{}'::text[], true, false, 7),
  ('chhachh', 'milkshakes', 'Chhachh (Buttermilk)', null, '₹50', 50, '{}'::text[], true, false, 8),
  ('gulab-jamun', 'desserts', 'Gulab Jamun', null, '₹25', 25, '{}'::text[], true, false, 1),
  ('ras-malai', 'desserts', 'Ras Malai', null, '₹70', 70, '{}'::text[], true, false, 2),
  ('kheer', 'desserts', 'Kheer', null, '₹70', 70, '{}'::text[], true, false, 3)
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
 where id not in ('thali-rice-half-butter-roti', 'thali-rice', 'thali-roti', 'thali-butter-roti', 'thali-basmati', 'thali-green-veg', 'thali-special', 'thali-chinese', 'paneer-butter-masala', 'shahi-paneer', 'malai-kofta', 'mattar-paneer', 'paneer-pakoda', 'paneer-do-pyaja', 'paneer-kadhai', 'mix-veg', 'palak-paneer', 'paneer-chatpatta', 'paneer-garlic', 'paneer-tikka', 'soya-veggets', 'soya-ball-manchurian', 'soya-chikka-butter', 'soya-chop-stick', 'soya-bhurji', 'soya-chilli', 'mushroom-butter-masala', 'mushroom-do-pyaja', 'mushroom-kadhai', 'mushroom-capsicum', 'mushroom-garlic', 'chana-masala', 'aloo-trio', 'aloo-gobhi-trio', 'gobhi-parwal-bhindi', 'dal-fry', 'butter-dal-fry', 'paneer-tadka', 'butter-tadka', 'plain-tadka', 'dal-makhani', 'aloo-bhujiya', 'parval-bhindi-karela-bhujiya', 'gobhi-bhujiya', 'punjabi-kadi-pakoda', 'baingan-bharta', 'paneer-bhujiya', 'tawa-roti', 'butter-tawa-roti', 'tandoori-roti', 'butter-tandoori-roti', 'plain-parantha', 'butter-naan', 'stuff-naan', 'aloo-parantha', 'paneer-parantha', 'gobhi-parantha', 'lachha-parantha', 'millet-roti', 'jeera-rice', 'steam-rice-fine', 'steam-rice-miniket', 'veg-biryani', 'veg-fried-rice', 'veg-pulao', 'mutter-pulao', 'plain-dosa', 'masala-dosa', 'onion-dosa', 'masala-paneer-dosa', 'butter-masala-dosa', 'cheese-plain-dosa', 'cheese-masala-dosa', 'uttapam', 'idli-sambar', 'veg-chowmein', 'special-chowmein', 'mushroom-chilli', 'paneer-chilli', 'veg-manchurian', 'papad', 'green-salad', 'onion-salad', 'raita', 'dahi-milk', 'shake-chocolate', 'shake-vanilla', 'shake-strawberry', 'shake-oreo', 'shake-butterscotch', 'shake-blackcurrent', 'lassi', 'chhachh', 'gulab-jamun', 'ras-malai', 'kheer')
   and is_active = true;

commit;

-- Optional sanity check (run separately after committing):
-- select category_id, count(*) as active_items
--   from public.menu_items where is_active group by 1 order by 1;
