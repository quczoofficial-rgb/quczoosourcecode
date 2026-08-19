const supabase = require("../config/supabase");

const createWalkInSale = async ({ productId, quantity }) => {
  const { data, error } = await supabase.rpc("create_walk_in_sale", {
    p_product_id: productId,
    p_quantity: Number(quantity),
  });

  if (error) {
    throw error;
  }

  if (!data || data.length === 0) {
    throw new Error("Walk-in sale could not be created");
  }

  return data[0];
};
const getSales = async () => {
  const { data, error } = await supabase
    .from("sales")
    .select(`
      id,
      product_id,
      quantity,
      unit_price,
      total_amount,
      sale_type,
      created_at,
      products (
        name,
        category,
        unit
      )
    `)
    .order("created_at", { ascending: false });

  if (error) {
    throw error;
  }

  return data;
};
module.exports = {
  createWalkInSale,
  getSales,
};