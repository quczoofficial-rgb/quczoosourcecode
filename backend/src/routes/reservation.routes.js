const express = require("express");

const protect = require("../middleware/auth.middleware");

const {
  createReservation,
  cancelReservation,
  completeReservation,
  getCustomerReservations,
  getReservationById,
} = require("../services/reservation.service");

const router = express.Router();


// ==========================================
// CUSTOMER ONLY MIDDLEWARE
// ==========================================
const customerOnly = (req, res, next) => {
  if (req.user.role !== "customer") {
    return res.status(403).json({
      success: false,
      message: "Customer access required",
    });
  }

  next();
};


// ==========================================
// GET CUSTOMER RESERVATIONS
// ==========================================
router.get(
  "/customer/:customerId",
  protect,
  customerOnly,
  async (req, res) => {
    try {

      // Customer can access only their own reservations
      if (String(req.user.id) !== String(req.params.customerId)) {
        return res.status(403).json({
          success: false,
          message: "You can access only your own reservations",
        });
      }

      const reservations = await getCustomerReservations(
        req.params.customerId
      );

      return res.status(200).json({
        success: true,
        message: "Customer reservations fetched successfully",
        data: reservations,
      });

    } catch (error) {
      return res.status(500).json({
        success: false,
        message: "Failed to fetch customer reservations",
        error: error.message,
      });
    }
  }
);


// ==========================================
// CREATE RESERVATION - CUSTOMER ONLY
// ==========================================
router.post(
  "/",
  protect,
  customerOnly,
  async (req, res) => {
    try {

      const {
        customerId,
        productId,
        quantity,
      } = req.body;

      if (!customerId || !productId || !quantity) {
        return res.status(400).json({
          success: false,
          message: "customerId, productId and quantity are required",
        });
      }

      // Customer can create reservation only for themselves
      if (String(req.user.id) !== String(customerId)) {
        return res.status(403).json({
          success: false,
          message: "You can create reservation only for yourself",
        });
      }

      const reservation = await createReservation({
        customerId,
        productId,
        quantity,
      });

      return res.status(201).json({
        success: true,
        message: "Product reserved successfully",
        data: reservation,
      });

    } catch (error) {
      return res.status(400).json({
        success: false,
        message: "Reservation failed",
        error: error.message,
      });
    }
  }
);


// ==========================================
// CANCEL RESERVATION - CUSTOMER ONLY
// ==========================================
router.patch(
  "/:id/cancel",
  protect,
  customerOnly,
  async (req, res) => {
    try {

      const reservation = await cancelReservation(req.params.id);

      return res.status(200).json({
        success: true,
        message: "Reservation cancelled successfully",
        data: reservation,
      });

    } catch (error) {
      return res.status(400).json({
        success: false,
        message: "Reservation cancellation failed",
        error: error.message,
      });
    }
  }
);


// ==========================================
// COMPLETE RESERVATION - CUSTOMER ONLY
// ==========================================
router.patch(
  "/:id/complete",
  protect,
  customerOnly,
  async (req, res) => {
    try {

      const reservation = await completeReservation(req.params.id);

      return res.status(200).json({
        success: true,
        message: "Reservation completed successfully",
        data: reservation,
      });

    } catch (error) {
      return res.status(400).json({
        success: false,
        message: "Reservation completion failed",
        error: error.message,
      });
    }
  }
);


// ==========================================
// GET RESERVATION BY ID - CUSTOMER ONLY
// ==========================================
router.get(
  "/:id",
  protect,
  customerOnly,
  async (req, res) => {
    try {

      const reservation = await getReservationById(req.params.id);

      if (!reservation) {
        return res.status(404).json({
          success: false,
          message: "Reservation not found",
        });
      }

      return res.status(200).json({
        success: true,
        data: reservation,
      });

    } catch (error) {
      return res.status(500).json({
        success: false,
        message: "Failed to fetch reservation",
        error: error.message,
      });
    }
  }
);


module.exports = router;