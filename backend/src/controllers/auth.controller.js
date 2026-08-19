const supabase = require("../config/supabase");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");


// =========================
// CUSTOMER REGISTER
// =========================

const customerRegister = async (req, res) => {
  try {
    const { mobile, language, location } = req.body;

    const { data: existingCustomer, error: existingError } = await supabase
      .from("customers")
      .select("id")
      .eq("mobile", mobile)
      .maybeSingle();

    if (existingError) {
      return res.status(500).json({
        success: false,
        message: "Failed to check existing customer",
        error: existingError.message,
      });
    }

    if (existingCustomer) {
      return res.status(409).json({
        success: false,
        message: "Customer already registered",
      });
    }

    const { data, error } = await supabase
      .from("customers")
      .insert([
        {
          mobile,
          language: language || "English",
          location: location || null,
        },
      ])
      .select()
      .single();

    if (error) {
      return res.status(500).json({
        success: false,
        message: "Customer registration failed",
        error: error.message,
      });
    }

    return res.status(201).json({
      success: true,
      message: "Customer registered successfully",
      data,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: error.message,
    });
  }
};


// =========================
// CUSTOMER LOGIN
// =========================

const customerLogin = async (req, res) => {
  try {
    const { mobile } = req.body;

    const { data: customer, error } = await supabase
      .from("customers")
      .select("*")
      .eq("mobile", mobile)
      .maybeSingle();

    if (error) {
      return res.status(500).json({
        success: false,
        message: "Customer login failed",
        error: error.message,
      });
    }

    if (!customer) {
      return res.status(404).json({
        success: false,
        message: "Customer not found",
      });
    }

    // Create JWT token for customer
    const token = jwt.sign(
      {
        id: customer.id,
        role: "customer",
      },
      process.env.JWT_SECRET,
      {
        expiresIn: "7d",
      }
    );

    return res.status(200).json({
      success: true,
      message: "Customer login successful",
      token,
      data: customer,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: error.message,
    });
  }
};


// =========================
// SHOP REGISTER
// =========================

const shopRegister = async (req, res) => {
  try {
    const {
      businessName,
      ownerName,
      businessCategory,
      shopAddress,
      city,
      mobile,
      email,
      gstNumber,
      password,
    } = req.body;

    // Check mobile
    const { data: existingMobile, error: mobileCheckError } =
      await supabase
        .from("shops")
        .select("id")
        .eq("mobile", mobile)
        .maybeSingle();

    if (mobileCheckError) {
      return res.status(500).json({
        success: false,
        message: "Failed to check existing mobile number",
        error: mobileCheckError.message,
      });
    }

    if (existingMobile) {
      return res.status(409).json({
        success: false,
        message: "Shop with this mobile number already exists",
      });
    }

    // Check email
    const { data: existingEmail, error: emailCheckError } =
      await supabase
        .from("shops")
        .select("id")
        .eq("email", email)
        .maybeSingle();

    if (emailCheckError) {
      return res.status(500).json({
        success: false,
        message: "Failed to check existing email",
        error: emailCheckError.message,
      });
    }

    if (existingEmail) {
      return res.status(409).json({
        success: false,
        message: "Shop with this email already exists",
      });
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create shop
    const { data, error } = await supabase
      .from("shops")
      .insert([
        {
          business_name: businessName,
          owner_name: ownerName,
          business_category: businessCategory,
          shop_address: shopAddress,
          city,
          mobile,
          email,
          gst_number: gstNumber || null,
          password: hashedPassword,
        },
      ])
      .select()
      .single();

    if (error) {
      return res.status(500).json({
        success: false,
        message: "Shop registration failed",
        error: error.message,
      });
    }

    // Never return password
    delete data.password;

    return res.status(201).json({
      success: true,
      message: "Shop registered successfully",
      data,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: error.message,
    });
  }
};


// =========================
// SHOP LOGIN
// =========================

const shopLogin = async (req, res) => {
  try {
    const { mobile, password } = req.body;

    const { data: shop, error } = await supabase
      .from("shops")
      .select("*")
      .eq("mobile", mobile)
      .maybeSingle();

    if (error) {
      return res.status(500).json({
        success: false,
        message: "Shop login failed",
        error: error.message,
      });
    }

    if (!shop) {
      return res.status(404).json({
        success: false,
        message: "Shop not found",
      });
    }

    // Compare password
    const passwordMatch = await bcrypt.compare(
      password,
      shop.password
    );

    if (!passwordMatch) {
      return res.status(401).json({
        success: false,
        message: "Invalid mobile number or password",
      });
    }

    // Create JWT token for shop owner
    const token = jwt.sign(
      {
        id: shop.id,
        role: "shop_owner",
      },
      process.env.JWT_SECRET,
      {
        expiresIn: "7d",
      }
    );

    // Never return password
    delete shop.password;

    return res.status(200).json({
      success: true,
      message: "Shop login successful",
      token,
      data: shop,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Internal server error",
      error: error.message,
    });
  }
};


// =========================
// EXPORTS
// =========================

module.exports = {
  customerRegister,
  customerLogin,
  shopRegister,
  shopLogin,
};