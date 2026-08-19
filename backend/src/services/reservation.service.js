const supabase = require("../config/supabase");

const createReservation = async ({
  customerId,
  productId,
  quantity,
}) => {
  const { data, error } = await supabase.rpc("create_reservation", {
    p_customer_id: Number(customerId),
    p_product_id: productId,
    p_quantity: Number(quantity),
  });

  if (error) {
    throw error;
  }

  if (!data || data.length === 0) {
    throw new Error("Reservation could not be created");
  }

  return data[0];
};
const cancelReservation = async (reservationId) => {
  const { data, error } = await supabase.rpc("cancel_reservation", {
    p_reservation_id: reservationId,
  });

  if (error) {
    throw error;
  }

  if (!data || data.length === 0) {
    throw new Error("Reservation cancellation failed");
  }

  return data[0];
};
const completeReservation = async (reservationId) => {
  const { data, error } = await supabase.rpc("complete_reservation", {
    p_reservation_id: reservationId,
  });

  if (error) {
    throw error;
  }

  if (!data || data.length === 0) {
    throw new Error("Reservation completion failed");
  }

  return data[0];
};

const getCustomerReservations = async (customerId) => {
  const { data, error } = await supabase
    .from("reservations")
    .select(`
      id,
      customer_id,
      product_id,
      quantity,
      status,
      created_at,
      updated_at,
      products (
        name,
        category,
        price,
        selling_price,
        unit
      )
    `)
    .eq("customer_id", Number(customerId))
    .order("created_at", { ascending: false });

  if (error) {
    throw error;
  }

  return data;
};

const getReservationById = async (id) => {
  const { data, error } = await supabase
    .from("reservations")
    .select(`
      id,
      customer_id,
      product_id,
      quantity,
      status,
      created_at,
      updated_at,
      products (
        name,
        category,
        price,
        selling_price,
        unit
      )
    `)
    .eq("id", id)
    .single();

  if (error) {
    return null;
  }

  return data;
};

module.exports = {
  createReservation,
  cancelReservation,
  completeReservation,
  getCustomerReservations,
  getReservationById,
};