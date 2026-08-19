const express = require("express");

const validateProduct = require("../utils/product.validator");
const productService = require("../services/product.service");
const protect = require("../middleware/auth.middleware");

const router = express.Router();


// CREATE PRODUCT
router.post("/", protect, async (req, res) =>{
  try {
    const { isValid, errors } = validateProduct(req.body);

    if (!isValid) {
      return res.status(400).json({
        success: false,
        message: "Product validation failed",
        errors,
      });
    }

    const product = await productService.createProduct(req.body);

    return res.status(201).json({
      success: true,
      message: "Product created successfully",
      data: product,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Product creation failed",
      error: error.message,
    });
  }
});


// UPDATE PRODUCT
router.put("/:id", protect, async (req, res) => {
  try {
    const { isValid, errors } = validateProduct(req.body);

    if (!isValid) {
      return res.status(400).json({
        success: false,
        message: "Product validation failed",
        errors,
      });
    }

    const product = await productService.updateProduct(
      req.params.id,
      req.body
    );

    if (!product) {
      return res.status(404).json({
        success: false,
        message: "Product not found",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Product updated successfully",
      data: product,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: "Product update failed",
      error: error.message,
    });
  }
});


// DELETE PRODUCT
router.delete("/:id", protect, async (req, res) =>  {
  try {
    const deleted = await productService.deleteProduct(req.params.id);

    if (!deleted) {
      return res.status(404).json({
        success: false,
        message: "Product not found",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Product deleted successfully",
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Product deletion failed",
      error: error.message,
    });
  }
});


module.exports = router;