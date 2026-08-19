const express = require("express");

const {
  recordPhysicalSale,
  getInventoryTransactions,
} = require("../services/inventory.service");

const protect = require("../middleware/auth.middleware");

const router = express.Router();


// Get inventory transactions
router.get("/transactions", protect, async (req, res) => {
  try {
    const transactions = await getInventoryTransactions();

    return res.status(200).json({
      success: true,
      message: "Inventory transactions fetched successfully",
      data: transactions,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Failed to fetch inventory transactions",
      error: error.message,
    });
  }
});


// Record physical shop sale
router.post("/physical-sale", protect, async (req, res) => {
  try {
    const {
      productId,
      quantity,
    } = req.body;

    if (!productId || !quantity) {
      return res.status(400).json({
        success: false,
        message: "productId and quantity are required",
      });
    }

    const result = await recordPhysicalSale({
      productId,
      quantity,
    });

    return res.status(200).json({
      success: true,
      message: "Physical sale recorded successfully",
      data: result,
    });

  } catch (error) {
    return res.status(400).json({
      success: false,
      message: "Physical sale failed",
      error: error.message,
    });
  }
});


module.exports = router;