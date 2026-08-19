const express = require("express");

const router = express.Router();

router.get("/profile", (req, res) => {
  res.json({
    success: true,
    message: "Customer profile API is working",
  });
});

router.get("/addresses", (req, res) => {
  res.json({
    success: true,
    message: "Customer addresses API is working",
  });
});

module.exports = router;