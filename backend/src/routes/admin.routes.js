const express = require("express");
const protect = require("../middleware/auth.middleware");
const { adminOnly } = require("../middleware/role.middleware");
const {
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
} = require("../controllers/admin.controller");

const router = express.Router();

router.post("/login", adminLogin);

router.use(protect);
router.use(adminOnly);

router.get("/dashboard", getDashboardStats);
router.get("/customers", getCustomers);
router.get("/shop-owners", getShopOwners);
router.get("/shops", getShops);

router.get("/products", getProducts);
router.post("/products", createProduct);
router.put("/products/:id", updateProduct);
router.delete("/products/:id", deleteProduct);

router.get("/reservations", getReservations);
router.get("/inventory", getInventory);
router.get("/billing", getBilling);

module.exports = router;