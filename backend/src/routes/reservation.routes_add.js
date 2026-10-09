
// ==========================================
// SHOP ONLY MIDDLEWARE
// ==========================================
const shopOnly = (req, res, next) => {
  if (req.user.role !== "shop_owner") {
    return res.status(403).json({
      success: false,
      message: "Shop Owner access required",
    });
  }
  next();
};

const { getShopReservations, acceptReservation, rejectReservation } = require("../services/reservation.service");

// GET SHOP RESERVATIONS
router.get("/shop/:shopId", protect, shopOnly, async (req, res) => {
  try {
    const reservations = await getShopReservations(req.params.shopId);
    return res.status(200).json({ success: true, data: reservations });
  } catch (error) {
    return res.status(500).json({ success: false, message: error.message });
  }
});

// ACCEPT RESERVATION
router.patch("/:id/accept", protect, shopOnly, async (req, res) => {
  try {
    const reservation = await acceptReservation(req.params.id);
    return res.status(200).json({ success: true, message: "Reservation accepted", data: reservation });
  } catch (error) {
    return res.status(400).json({ success: false, message: error.message });
  }
});

// REJECT RESERVATION
router.patch("/:id/reject", protect, shopOnly, async (req, res) => {
  try {
    const reservation = await rejectReservation(req.params.id);
    return res.status(200).json({ success: true, message: "Reservation rejected", data: reservation });
  } catch (error) {
    return res.status(400).json({ success: false, message: error.message });
  }
});

module.exports = router;
