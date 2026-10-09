require('dotenv').config({ path: '.env' });
const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SECRET_KEY);

const productsToSeed = [
  { name: 'Fresh Cow Milk 1L', category: 'Groceries', price: 65, selling_price: 60, unit: '1L', stock: 100 },
  { name: 'Sona Masoori Rice 5kg', category: 'Groceries', price: 350, selling_price: 320, unit: '5kg', stock: 50 },
  { name: 'Daily Care Shampoo 200ml', category: 'Personal Care', price: 150, selling_price: 135, unit: '200ml', stock: 30 },
  { name: '12W Cool Day LED Bulb', category: 'Home', price: 120, selling_price: 99, unit: '1 pc', stock: 200 },
  { name: 'Fast Phone Charger 20W', category: 'Electronics', price: 499, selling_price: 399, unit: '1 pc', stock: 20 },
  { name: 'A4 Spiral Notebook 200 Pages', category: 'Stationery', price: 80, selling_price: 65, unit: '1 pc', stock: 150 },
  { name: 'Heavy Duty Power Drill 500W', category: 'Home', price: 1500, selling_price: 1200, unit: '1 pc', stock: 5 },
  { name: 'Surf Excel Easy Wash Detergent 2kg', category: 'Groceries', price: 290, selling_price: 260, unit: '2kg', stock: 40 }
];

async function seed() {
  const { data: existing } = await supabase.from('products').select('name');
  const existingNames = existing ? existing.map(e => e.name) : [];
  
  for (const p of productsToSeed) {
    if (!existingNames.some(name => name.includes(p.name))) {
      const { error } = await supabase.from('products').insert([
        { ...p, reserved_stock: 0, image_url: null }
      ]);
      if (error) console.error("Error inserting", p.name, error);
      else console.log("Seeded", p.name);
    } else {
      console.log("Already exists:", p.name);
    }
  }
}
seed().then(() => console.log('Done'));
