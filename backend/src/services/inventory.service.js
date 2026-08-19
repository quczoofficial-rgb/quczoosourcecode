const supabase = require("../config/supabase");

const recordPhysicalSale = async ({
  productId,
  quantity,
}) => {
  const { data, error } = await supabase.rpc("record_physical_sale", {
    p_product_id: productId,
    p_quantity: Number(quantity),
  });

  if (error) {
    throw error;
  }

  if (!data || data.length === 0) {
    throw new Error("Physical sale could not be recorded");
  }

  return data[0];
};
const getInventoryTransactions = async () => {
  const { data, error } = await supabase
    .from("inventory_transactions")
    .select(`
      id,
      product_id,
      transaction_type,
      quantity,
      stock_before,
      stock_after,
      reserved_before,
      reserved_after,
      notes,
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
  recordPhysicalSale,
  getInventoryTransactions,
};