const supabase = require("../config/supabase");

const formatProduct = (product) => {
  if (!product) return null;

  return {
    id: product.id,
    name: product.name,
    category: product.category,
    price: product.price,
    sellingPrice: product.selling_price,
    unit: product.unit,
    stock: product.stock,
    reservedStock: product.reserved_stock || 0,
    availableStock:
      Number(product.stock) - Number(product.reserved_stock || 0),
    createdAt: product.created_at,
    updatedAt: product.updated_at,
  };
};


// CREATE PRODUCT
const createProduct = async (productData) => {
  const {
    name,
    category,
    price,
    sellingPrice,
    unit,
    stock,
  } = productData;

  const initialStock = Number(stock);

  const { data, error } = await supabase
    .from("products")
    .insert([
      {
        name,
        category,
        price: Number(price),
        selling_price: Number(sellingPrice),
        unit,
        stock: initialStock,
        reserved_stock: 0,
      },
    ])
    .select()
    .single();

  if (error) {
    throw error;
  }

  // Record initial stock
  const { error: transactionError } = await supabase
    .from("inventory_transactions")
    .insert([
      {
        product_id: data.id,
        transaction_type: "STOCK_ADJUSTMENT",
        quantity: initialStock,
        stock_before: 0,
        stock_after: initialStock,
        reserved_before: 0,
        reserved_after: 0,
        notes: "Initial product stock",
      },
    ]);

  if (transactionError) {
    throw transactionError;
  }

  return formatProduct(data);
};


// GET ALL PRODUCTS
const getProducts = async () => {
  const { data, error } = await supabase
    .from("products")
    .select("*")
    .order("created_at", { ascending: false });

  if (error) {
    throw error;
  }

  return data.map(formatProduct);
};


// GET PRODUCTS BY CATEGORY
const getProductsByCategory = async (category) => {
  const { data, error } = await supabase
    .from("products")
    .select("*")
    .ilike("category", category)
    .order("created_at", { ascending: false });

  if (error) {
    throw error;
  }

  return data.map(formatProduct);
};


// GET PRODUCT BY ID
const getProductById = async (id) => {
  const { data, error } = await supabase
    .from("products")
    .select("*")
    .eq("id", id)
    .maybeSingle();

  if (error) {
    throw error;
  }

  return formatProduct(data);
};


// UPDATE PRODUCT
const updateProduct = async (id, productData) => {
  // First get current product
  const { data: existingProduct, error: findError } = await supabase
    .from("products")
    .select("*")
    .eq("id", id)
    .maybeSingle();

  if (findError) {
    throw findError;
  }

  if (!existingProduct) {
    return null;
  }

  const updateData = {};

  if (productData.name !== undefined) {
    updateData.name = productData.name;
  }

  if (productData.category !== undefined) {
    updateData.category = productData.category;
  }

  if (productData.price !== undefined) {
    updateData.price = Number(productData.price);
  }

  if (productData.sellingPrice !== undefined) {
    updateData.selling_price = Number(productData.sellingPrice);
  }

  if (productData.unit !== undefined) {
    updateData.unit = productData.unit;
  }

  if (productData.stock !== undefined) {
    const newStock = Number(productData.stock);
    const currentReserved = Number(existingProduct.reserved_stock || 0);

    // Physical stock cannot be less than already reserved quantity
    if (newStock < currentReserved) {
      throw new Error(
        `Stock cannot be less than reserved stock (${currentReserved})`
      );
    }

    updateData.stock = newStock;
  }

  updateData.updated_at = new Date().toISOString();

  const { data, error } = await supabase
    .from("products")
    .update(updateData)
    .eq("id", id)
    .select()
    .single();

  if (error) {
    throw error;
  }

  // Record stock adjustment only when stock changed
  if (productData.stock !== undefined) {
    const oldStock = Number(existingProduct.stock);
    const newStock = Number(data.stock);

    if (oldStock !== newStock) {
      const { error: transactionError } = await supabase
        .from("inventory_transactions")
        .insert([
          {
            product_id: id,
            transaction_type: "STOCK_ADJUSTMENT",
            quantity: Math.abs(newStock - oldStock),
            stock_before: oldStock,
            stock_after: newStock,
            reserved_before: Number(existingProduct.reserved_stock || 0),
            reserved_after: Number(data.reserved_stock || 0),
            notes: "Shop owner updated stock",
          },
        ]);

      if (transactionError) {
        throw transactionError;
      }
    }
  }

  return formatProduct(data);
};


// DELETE PRODUCT
const deleteProduct = async (id) => {
  const { data: existingProduct, error: findError } = await supabase
    .from("products")
    .select("id")
    .eq("id", id)
    .maybeSingle();

  if (findError) {
    throw findError;
  }

  if (!existingProduct) {
    return false;
  }

  const { error } = await supabase
    .from("products")
    .delete()
    .eq("id", id);

  if (error) {
    throw error;
  }

  return true;
};


module.exports = {
  createProduct,
  getProducts,
  getProductsByCategory,
  getProductById,
  updateProduct,
  deleteProduct,
};