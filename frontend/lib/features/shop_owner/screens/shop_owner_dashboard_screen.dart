import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../repositories/auth_repository.dart';
import '../../../repositories/order_repository.dart';

/// SCREEN 36 — SHOP OWNER BUSINESS DASHBOARD SCREEN
class ShopOwnerDashboardScreen extends StatefulWidget {
  const ShopOwnerDashboardScreen({super.key});

  @override
  State<ShopOwnerDashboardScreen> createState() => _ShopOwnerDashboardScreenState();
}

class _ShopOwnerDashboardScreenState extends State<ShopOwnerDashboardScreen> {
  bool _isShopOpen = true;
  List<dynamic> _recentOrders = [];
  bool _isLoadingOrders = false;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    setState(() => _isLoadingOrders = true);
    final shopId = AuthRepository().currentUserPhone ?? '';
    final orders = await OrderRepository().getShopOrders(shopId);
    if (mounted) {
      setState(() {
        _recentOrders = orders;
        _isLoadingOrders = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Super Fresh Supermarket', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Anna Nagar Branch • Business Portal', style: TextStyle(fontSize: 11, color: AppColors.greenLight)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () => Navigator.pushNamed(context, '/barcode-scanner'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/shop-settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shop Open / Closed Toggle Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _isShopOpen ? AppColors.greenSubtle : const Color(0xFFFEF2F2),
                  borderRadius: AppCorners.roundedMd,
                  border: Border.all(
                    color: _isShopOpen ? AppColors.green : const Color(0xFFFCA5A5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            _isShopOpen ? Icons.storefront : Icons.store_outlined,
                            color: _isShopOpen ? AppColors.greenDark : const Color(0xFFDC2626),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _isShopOpen ? 'Shop Status: ONLINE (Accepting Reservations)' : 'Shop Status: OFFLINE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _isShopOpen ? AppColors.greenDark : const Color(0xFFDC2626),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      activeThumbColor: AppColors.green,
                      value: _isShopOpen,
                      onChanged: (val) => setState(() => _isShopOpen = val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // KPI Metrics Cards
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.6,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildKpiCard('Today\'s Reservations', '18', Icons.shopping_bag_outlined, AppColors.green),
                  _buildKpiCard('Pending Action', '4', Icons.pending_actions_outlined, const Color(0xFFEAB308)),
                  _buildKpiCard('Low Stock Items', '6', Icons.warning_amber_outlined, const Color(0xFFDC2626)),
                  _buildKpiCard('Total Catalog Items', '1,250', Icons.inventory_2_outlined, const Color(0xFF2563EB)),
                ],
              ),
              const SizedBox(height: 20),

              // Quick Actions Bar
              const Text('QUICK BUSINESS ACTIONS', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildActionButton(context, Icons.add_box_outlined, 'Add Product', '/add-product'),
                    const SizedBox(width: 10),
                    _buildActionButton(context, Icons.inventory_outlined, 'Inventory', '/inventory'),
                    const SizedBox(width: 10),
                    _buildActionButton(context, Icons.receipt_long_outlined, 'Orders', '/order-management'),
                    const SizedBox(width: 10),
                    _buildActionButton(context, Icons.analytics_outlined, 'Analytics', '/shop-analytics'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Pending Orders Summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('RECENT RESERVATION REQUESTS', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/order-management'),
                    child: const Text('View All', style: TextStyle(color: AppColors.green, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Reservation Items List
              if (_isLoadingOrders)
                const Center(child: CircularProgressIndicator())
              else if (_recentOrders.isEmpty)
                const Center(child: Text('No recent reservations', style: TextStyle(color: AppColors.textSecondary)))
              else
                ..._recentOrders.take(5).map((order) => _buildRecentOrderCard(context, order)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKpiCard(String title, String val, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppCorners.roundedMd,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(val, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: color)),
              Icon(icon, color: color, size: 22),
            ],
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.green, size: 24),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.navy)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrderCard(BuildContext context, Map<String, dynamic> order) {
    return _OrderCardItem(order: order, onStatusChanged: _fetchOrders);
  }
}

class _OrderCardItem extends StatefulWidget {
  final Map<String, dynamic> order;
  final VoidCallback onStatusChanged;

  const _OrderCardItem({required this.order, required this.onStatusChanged});

  @override
  State<_OrderCardItem> createState() => _OrderCardItemState();
}

class _OrderCardItemState extends State<_OrderCardItem> {
  bool _isAccepting = false;
  bool _isRejecting = false;

  Future<void> _handleAccept() async {
    setState(() => _isAccepting = true);
    final success = await OrderRepository().acceptOrder(widget.order['id']?.toString() ?? '');
    setState(() => _isAccepting = false);
    
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success ? 'Order accepted' : 'Failed to accept order')),
    );
    if (success) widget.onStatusChanged();
  }

  Future<void> _handleReject() async {
    setState(() => _isRejecting = true);
    final success = await OrderRepository().rejectOrder(widget.order['id']?.toString() ?? '');
    setState(() => _isRejecting = false);
    
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success ? 'Order rejected' : 'Failed to reject order')),
    );
    if (success) widget.onStatusChanged();
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.order['id']?.toString() ?? '';
    final customer = widget.order['customer_id']?.toString() ?? 'Unknown';
    final productId = widget.order['product_id']?.toString() ?? '';
    final qty = widget.order['quantity']?.toString() ?? '1';
    final status = widget.order['status']?.toString() ?? 'Unknown';
    final item = 'Product ID: $productId (x$qty)';
    final total = 'N/A'; // Mocked or calculated

    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppCorners.roundedMd,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('#$id', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: AppColors.greenSubtle, borderRadius: BorderRadius.circular(4)),
                child: Text(status, style: const TextStyle(color: AppColors.greenDark, fontWeight: FontWeight.bold, fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('Customer: $customer', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          Text(item, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.navy)),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Value: $total', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.green)),
              if (status.toLowerCase() == 'pending')
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: (_isAccepting || _isRejecting) ? null : _handleReject,
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), minimumSize: Size.zero),
                      child: Text(_isRejecting ? 'Rejecting...' : 'Reject', style: const TextStyle(fontSize: 12, color: Color(0xFFDC2626))),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: (_isAccepting || _isRejecting) ? null : _handleAccept,
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), minimumSize: Size.zero),
                      child: Text(_isAccepting ? 'Accepting...' : 'Accept', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
