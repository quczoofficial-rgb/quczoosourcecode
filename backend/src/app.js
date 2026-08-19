const express = require("express");
const cors = require("cors");
const helmet = require("helmet");
const morgan = require("morgan");
const notFound = require("./middleware/notFound.middleware");
const errorHandler = require("./middleware/error.middleware");
const customerRoutes = require("./routes/customer.routes");
const shopRoutes = require("./routes/shop.routes");
const productRoutes = require("./routes/product.routes");
const shopProductRoutes = require("./routes/shop-product.routes");
const reservationRoutes = require("./routes/reservation.routes");
const inventoryRoutes = require("./routes/inventory.routes");
const billingRoutes = require("./routes/billing.routes");
const dashboardRoutes = require("./routes/dashboard.routes");
require("dotenv").config();

const authRoutes = require("./routes/auth.routes");

const app = express();

app.use(helmet());
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));



if (process.env.NODE_ENV !== "test") {
  app.use(morgan("dev"));
}

app.get("/", (req, res) => {
  res.json({
    success: true,
    message: "PICKZO Backend API is running",
  });
});

app.get("/api/health", (req, res) => {
  res.json({
    success: true,
    message: "PICKZO API is healthy",
  });
});

app.use("/api/auth", authRoutes);
app.use("/api/customer", customerRoutes);
app.use("/api/shop", shopRoutes);
app.use("/api/products", productRoutes);
app.use("/api/shop/products", shopProductRoutes);
app.use("/api/reservations", reservationRoutes);
app.use("/api/inventory", inventoryRoutes);
app.use("/api/billing", billingRoutes);
app.use("/api/dashboard", dashboardRoutes);
app.use(notFound);
app.use(errorHandler);
module.exports = app;