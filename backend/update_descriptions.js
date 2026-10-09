const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SECRET_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

const descriptions = {
  'Milk': 'Fresh and nutritious milk suitable for everyday use. Ideal for tea, coffee, cereals and cooking.',
  'Rice': 'Premium quality rice suitable for everyday meals, biryani and traditional rice dishes.',
  'Shampoo': 'Gentle everyday shampoo designed to cleanse the scalp and hair while keeping hair fresh and soft.',
  'LED Bulb': 'Energy-efficient LED bulb suitable for home, office and everyday lighting.',
  'Phone Charger': 'Reliable fast-charging phone charger designed for compatible smartphones and everyday charging.',
  'Notebook': 'High-quality ruled notebook suitable for study, notes, assignments and everyday writing.',
  'Power Drill': 'Compact power drill suitable for household repairs, DIY work and basic drilling applications.',
  'Detergent': 'Effective laundry detergent designed to remove everyday dirt and stains while keeping clothes fresh.'
};

async function updateDescriptions() {
  for (const [name, description] of Object.entries(descriptions)) {
    console.log(`Updating description for ${name}...`);
    const { data, error } = await supabase
      .from('products')
      .update({ description: description })
      .ilike('name', `%${name}%`);
    if (error) {
      console.error(`Error updating ${name}:`, error);
    } else {
      console.log(`Successfully updated ${name}`);
    }
  }
}

updateDescriptions();
