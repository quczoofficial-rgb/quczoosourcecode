const getShopReservations = async (shopId) => {
  const { data, error } = await supabase
    .from("reservations")
    .select(`
      id, customer_id, product_id, quantity, status, created_at, updated_at,
      products!inner ( name, category, price, selling_price, unit, shop_id ),
      customers ( name, phone )
    `)
    .eq('products.shop_id', shopId)
    .order("created_at", { ascending: false });
  if (error) throw error;
  return data;
};

const acceptReservation = async (reservationId) => {
  const { data, error } = await supabase.from("reservations").update({ status: 'accepted' }).eq('id', reservationId).select();
  if (error) throw error;
  return data[0];
};

const rejectReservation = async (reservationId) => {
  const { data, error } = await supabase.from("reservations").update({ status: 'rejected' }).eq('id', reservationId).select();
  if (error) throw error;
  return data[0];
};

module.exports.getShopReservations = getShopReservations;
module.exports.acceptReservation = acceptReservation;
module.exports.rejectReservation = rejectReservation;
