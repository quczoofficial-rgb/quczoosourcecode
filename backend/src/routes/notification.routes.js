const express = require('express');
const router = express.Router();
const protect = require('../middleware/auth.middleware');
const supabase = require('../config/supabase');

/**
 * GET /api/notifications
 * Returns customer notifications derived from reservation status changes.
 * Requires auth token. Reads customer_id from JWT.
 */
router.get('/', protect, async (req, res) => {
  try {
    const customerId = req.user.id;

    // Fetch reservations for this customer where status is accepted or rejected
    const { data, error } = await supabase
      .from('reservations')
      .select(`
        id,
        status,
        quantity,
        updated_at,
        created_at,
        products (
          name,
          category
        )
      `)
      .eq('customer_id', customerId)
      .in('status', ['accepted', 'rejected', 'completed', 'CANCELLED', 'COMPLETED'])
      .order('updated_at', { ascending: false });

    if (error) throw error;

    const notifications = (data || []).map((r) => {
      const productName = r.products?.name ?? 'your product';
      const statusLower = (r.status || '').toLowerCase();
      let title = '';
      let body = '';
      let icon = 'notification';

      if (statusLower === 'accepted') {
        title = 'Reservation Accepted ✅';
        body = `Your reservation for "${productName}" has been accepted by the shop. Please pick it up soon.`;
        icon = 'check';
      } else if (statusLower === 'rejected') {
        title = 'Reservation Rejected ❌';
        body = `Your reservation for "${productName}" has been rejected by the shop. It may be out of stock.`;
        icon = 'close';
      } else if (statusLower === 'completed') {
        title = 'Pickup Completed 🎉';
        body = `Your pickup for "${productName}" has been marked as completed. Thank you!`;
        icon = 'done';
      } else if (statusLower === 'cancelled') {
        title = 'Reservation Cancelled';
        body = `Your reservation for "${productName}" was cancelled.`;
        icon = 'cancel';
      }

      const updatedAt = new Date(r.updated_at || r.created_at);
      const now = new Date();
      const diffMs = now - updatedAt;
      const diffMins = Math.floor(diffMs / 60000);
      const diffHours = Math.floor(diffMins / 60);
      const diffDays = Math.floor(diffHours / 24);

      let timeAgo = '';
      if (diffMins < 1) timeAgo = 'Just now';
      else if (diffMins < 60) timeAgo = `${diffMins} min ago`;
      else if (diffHours < 24) timeAgo = `${diffHours} hr ago`;
      else if (diffDays === 1) timeAgo = 'Yesterday';
      else timeAgo = `${diffDays} days ago`;

      return {
        id: r.id,
        title,
        body,
        time: timeAgo,
        isRead: diffDays > 0,
        icon,
        reservationId: r.id,
        status: r.status,
      };
    }).filter(n => n.title !== '');

    return res.status(200).json({
      success: true,
      count: notifications.length,
      data: notifications,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: 'Failed to fetch notifications',
      error: error.message,
    });
  }
});

module.exports = router;
