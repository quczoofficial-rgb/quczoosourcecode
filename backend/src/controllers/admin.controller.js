const supabase = require("../config/supabase");
const jwt = require("jsonwebtoken");

const adminLogin = async (req, res) => {
  try {
    const { email, password } = req.body;
    // Hardcoded admin for demonstration
    if (email === "admin@quczo.com" && password === "admin123") {
      const token = jwt.sign(
        { id: "admin-id", role: "admin" },
        process.env.JWT_SECRET,
        { expiresIn: "7d" }
      );
      return res.json({ success: true, token, user: { email, role: "admin" } });
    }
    
    return res.status(401).json({ success: false, message: "Invalid credentials" });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getDashboardStats = async (req, res) => {
  try {
    const [customers, shops, products, reservations] = await Promise.all([
      supabase.from("customers").select("id", { count: "exact" }),
      supabase.from("shops").select("id", { count: "exact" }),
      supabase.from("products").select("id", { count: "exact" }),
      supabase.from("reservations").select("id", { count: "exact" }),
    ]);

    res.json({
      success: true,
      data: {
        totalCustomers: customers.count || 0,
        totalShopOwners: shops.count || 0,
        totalShops: shops.count || 0,
        totalProducts: products.count || 0,
        totalReservations: reservations.count || 0,
      }
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getCustomers = async (req, res) => {
  try {
    const { data, error } = await supabase.from("customers").select("*").order("created_at", { ascending: false });
    if (error) throw error;
    res.json({ success: true, data });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getShopOwners = async (req, res) => {
  try {
    const { data, error } = await supabase.from("shops").select("*").order("created_at", { ascending: false });
    if (error) throw error;
    res.json({ success: true, data });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getShops = async (req, res) => {
  try {
    const { data, error } = await supabase.from("shops").select("*").order("created_at", { ascending: false });
    if (error) throw error;
    res.json({ success: true, data });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getProducts = async (req, res) => {
  try {
    const { data, error } = await supabase.from("products").select("*").order("created_at", { ascending: false });
    if (error) throw error;
    res.json({ success: true, data });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getReservations = async (req, res) => {
  try {
    const { data, error } = await supabase.from("reservations").select("*, customer:customer_id(phone, name), shop:shop_id(name)").order("created_at", { ascending: false });
    if (error) throw error;
    res.json({ success: true, data });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getInventory = async (req, res) => {
  try {
    const { data, error } = await supabase.from("products").select("id, name, stock, reserved_stock").order("stock", { ascending: true });
    if (error) throw error;
    res.json({ success: true, data });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const createProduct = async (req, res) => {
  try {
    const { name, description, category, price, stock, image_url } = req.body;
    const { data, error } = await supabase.from("products").insert([{
      name, description, category, price, stock, image_url, selling_price: price, unit: 'piece'
    }]).select();
    if (error) throw error;
    res.json({ success: true, data: data[0] });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const updateProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const updates = req.body;
    const { data, error } = await supabase.from("products").update(updates).eq("id", id).select();
    if (error) throw error;
    res.json({ success: true, data: data[0] });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const deleteProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const { error } = await supabase.from("products").delete().eq("id", id);
    if (error) throw error;
    res.json({ success: true, message: "Product deleted" });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getBilling = async (req, res) => {
  try {
    // For now, return reservations as sales/billing since there isn't a separate sales table
    const { data, error } = await supabase.from("reservations").select("*, customer:customer_id(phone, name), shop:shop_id(name)").order("created_at", { ascending: false });
    if (error) throw error;
    res.json({ success: true, data });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

module.exports = {
  adminLogin,
  getDashboardStats,
  getCustomers,
  getShopOwners,
  getShops,
  getProducts,
  createProduct,
  updateProduct,
  deleteProduct,
  getReservations,
  getInventory,
  getBilling
};