const { body } = require("express-validator");

const customerLoginValidator = [
  body("mobile")
    .trim()
    .notEmpty()
    .withMessage("Mobile number is required")
    .matches(/^[0-9]{10}$/)
    .withMessage("Mobile number must contain exactly 10 digits"),
];

const customerRegisterValidator = [
  body("mobile")
    .trim()
    .notEmpty()
    .withMessage("Mobile number is required")
    .matches(/^[0-9]{10}$/)
    .withMessage("Mobile number must contain exactly 10 digits"),

  body("language")
    .optional()
    .isIn(["English", "Tamil"])
    .withMessage("Language must be English or Tamil"),

  body("location")
    .optional()
    .trim()
    .isLength({ max: 150 })
    .withMessage("Location is too long"),
];

const shopLoginValidator = [
  body("mobile")
    .trim()
    .notEmpty()
    .withMessage("Mobile number is required")
    .matches(/^[0-9]{10}$/)
    .withMessage("Mobile number must contain exactly 10 digits"),

  body("password")
    .notEmpty()
    .withMessage("Password is required")
    .isLength({ min: 6 })
    .withMessage("Password must contain at least 6 characters"),
];

const shopRegisterValidator = [
  body("businessName")
    .trim()
    .notEmpty()
    .withMessage("Business name is required")
    .isLength({ min: 2, max: 100 })
    .withMessage("Business name must be between 2 and 100 characters"),

  body("ownerName")
    .trim()
    .notEmpty()
    .withMessage("Owner name is required"),

  body("businessCategory")
    .trim()
    .notEmpty()
    .withMessage("Business category is required"),

  body("shopAddress")
    .trim()
    .notEmpty()
    .withMessage("Shop address is required"),

  body("city")
    .trim()
    .notEmpty()
    .withMessage("City/Area is required"),

  body("mobile")
    .trim()
    .notEmpty()
    .withMessage("Mobile number is required")
    .matches(/^[0-9]{10}$/)
    .withMessage("Mobile number must contain exactly 10 digits"),

  body("email")
    .trim()
    .isEmail()
    .withMessage("Please provide a valid email address"),
  body("password")
    .notEmpty()
    .withMessage("Password is required")
    .isLength({ min: 6 })
    .withMessage("Password must contain at least 6 characters"),

  body("gstNumber")
    .optional()
    .trim(),
];

module.exports = {
  customerLoginValidator,
  customerRegisterValidator,
  shopLoginValidator,
  shopRegisterValidator,
};