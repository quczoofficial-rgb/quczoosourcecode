const express = require("express");

const {
  customerRegister,
  customerLogin,
  shopRegister,
  shopLogin,
} = require("../controllers/auth.controller");

const validate = require("../middleware/validate.middleware");

const {
  customerRegisterValidator,
  customerLoginValidator,
  shopRegisterValidator,
  shopLoginValidator,
} = require("../utils/auth.validators");

const router = express.Router();

// Customer
router.post(
  "/customer/register",
  customerRegisterValidator,
  validate,
  customerRegister
);

router.post(
  "/customer/login",
  customerLoginValidator,
  validate,
  customerLogin
);

// Shop Owner
router.post(
  "/shop/register",
  shopRegisterValidator,
  validate,
  shopRegister
);

router.post(
  "/shop/login",
  shopLoginValidator,
  validate,
  shopLogin
);

// Test
router.get("/test", (req, res) => {
  res.json({
    success: true,
    message: "Authentication route is working",
  });
});

module.exports = router;