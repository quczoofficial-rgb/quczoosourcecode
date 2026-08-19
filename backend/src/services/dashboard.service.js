const supabase = require("../config/supabase");

const getShopDashboard = async () => {
  const { data: products, error: productError } = await supabase
    .from("products")
    .select("id, name, category, stock, reserved_stock, price, selling_price, unit");

  if (productError) {
    throw productError;
  }

  const { data: sales, error: salesError } = await supabase
    .from("sales")
    .select("id, product_id, quantity, unit_price, total_amount, sale_type, created_at")
    .order("created_at", { ascending: false });

  if (salesError) {
    throw salesError;
  }

  const totalProducts = products.length;

  const totalStock = products.reduce(
    (sum, product) => sum + Number(product.stock || 0),
    0
  );

  const totalReservedStock = products.reduce(
    (sum, product) => sum + Number(product.reserved_stock || 0),
    0
  );

  const totalAvailableStock = totalStock - totalReservedStock;

  const totalSalesAmount = sales.reduce(
    (sum, sale) => sum + Number(sale.total_amount || 0),
    0
  );

  const totalItemsSold = sales.reduce(
    (sum, sale) => sum + Number(sale.quantity || 0),
    0
  );

  return {
    totalProducts,
    totalStock,
    totalReservedStock,
    totalAvailableStock,
    totalSalesAmount,
    totalItemsSold,
    recentSales: sales.slice(0, 10),
  };
};

module.exports = {
  getShopDashboard,
};