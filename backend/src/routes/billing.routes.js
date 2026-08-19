const express = require("express");

const {
  createWalkInSale,
  getSales,
} = require("../services/billing.service");

const protect = require("../middleware/auth.middleware");

const router = express.Router();


// Get sales history
router.get("/sales", protect, async (req, res) => {
  try {
    const sales = await getSales();

    return res.status(200).json({
      success: true,
      message: "Sales fetched successfully",
      data: sales,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Failed to fetch sales",
      error: error.message,
    });
  }
});


// Create walk-in sale
router.post("/walk-in", protect, async (req, res) => {
  try {
    const { productId, quantity } = req.body;

    if (!productId || quantity === undefined) {
      return res.status(400).json({
        success: false,
        message: "productId and quantity are required",
      });
    }

    const sale = await createWalkInSale({
      productId,
      quantity,
    });

    return res.status(201).json({
      success: true,
      message: "Walk-in sale created successfully",
      data: sale,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: "Walk-in sale failed",
      error: error.message,
    });
  }
});


module.exports = router;