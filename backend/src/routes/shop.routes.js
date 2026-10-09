const express = require("express");
const { getNearbyShops } = require("../controllers/shop.controller");

const router = express.Router();

router.get("/nearby", getNearbyShops);

router.get("/profile", (req, res) => {
  res.json({
    success: true,
    message: "Shop profile API is working",
  });
});

router.get("/dashboard", (req, res) => {
  res.json({
    success: true,
    message: "Shop dashboard API is working",
  });
});

router.get("/inventory", (req, res) => {
  res.json({
    success: true,
    message: "Shop inventory API is working",
  });
});

router.get("/orders", (req, res) => {
  res.json({
    success: true,
    message: "Shop orders API is working",
  });
});

module.exports = router;