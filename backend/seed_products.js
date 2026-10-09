require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SECRET_KEY);

const productsToSeed = [
  { name: 'Fresh Dairy Milk 1L', category: 'Dairy', price: 65, selling_price: 60, unit: 'L', stock: 20 },
  { name: 'Sona Masoori Rice 5kg', category: 'Grocery', price: 340, selling_price: 295, unit: 'kg', stock: 50 },
  { name: 'Herbal Care Shampoo 200ml', category: 'Personal Care', price: 150, selling_price: 135, unit: 'bottle', stock: 15 },
  { name: '12W Cool Day LED Bulb', category: 'Electrical', price: 120, selling_price: 89, unit: 'piece', stock: 100 },
  { name: 'Fast Charging Phone Charger 20W', category: 'Electronics', price: 499, selling_price: 399, unit: 'piece', stock: 30 },
  { name: 'Ruled Notebook 160 pages', category: 'Stationery', price: 50, selling_price: 45, unit: 'piece', stock: 60 },
  { name: 'Cordless Power Drill 12V', category: 'Hardware', price: 2500, selling_price: 1899, unit: 'piece', stock: 5 },
  { name: 'Stain Wash Liquid Detergent 1L', category: 'Household', price: 220, selling_price: 199, unit: 'L', stock: 25 }
];

async function seed() {
  // Clear existing products
  const { error: delErr } = await supabase.from('products').delete().neq('id', '00000000-0000-0000-0000-000000000000');
  if (delErr) {
    console.error('Delete error:', delErr);
  } else {
    console.log('Cleared existing products.');
  }

  for (const p of productsToSeed) {
    const { data, error } = await supabase.from('products').insert([p]).select();
    if (error) {
      console.error('Insert error for', p.name, error);
    } else {
      console.log('Inserted:', p.name);
    }
  }
}

seed();
