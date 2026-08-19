const express = require("express");

const {
  getShopDashboard,
} = require("../services/dashboard.service");

const protect = require("../middleware/auth.middleware");

const router = express.Router();


// Shop dashboard
router.get("/", protect, async (req, res) => {
  try {
    const dashboard = await getShopDashboard();

    return res.status(200).json({
      success: true,
      message: "Shop dashboard fetched successfully",
      data: dashboard,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Failed to fetch shop dashboard",
      error: error.message,
    });
  }
});


module.exports = router;