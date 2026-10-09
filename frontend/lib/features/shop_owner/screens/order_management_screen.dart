import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../repositories/order_repository.dart';
import '../../../repositories/auth_repository.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> _allOrders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchOrders();
  }
  
  Future<void> _fetchOrders() async {
    setState(() => _isLoading = true);
    final shopId = AuthRepository().currentUserPhone ?? '';
    final orders = await OrderRepository().getShopOrders(shopId);
    if (mounted) {
      setState(() {
        _allOrders = orders;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    final pendingOrders = _allOrders.where((o) => o['status'] == 'pending').toList();
    final acceptedOrders = _allOrders.where((o) => o['status'] == 'accepted').toList();
    final completedOrders = _allOrders.where((o) => o['status'] == 'completed').toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Customer Reservations', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.green,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.green,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Accepted'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildShopOrderList(pendingOrders),
            _buildShopOrderList(acceptedOrders),
            _buildShopOrderList(completedOrders),
          ],
        ),
      ),
    );
  }

  Widget _buildShopOrderList(List<dynamic> orders) {
    if (orders.isEmpty) {
      return const Center(child: Text('No orders found', style: TextStyle(color: AppColors.textSecondary)));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final order = orders[index];
        return _OrderCardItem(order: order, onStatusChanged: _fetchOrders);
      },
    );
  }
}

class _OrderCardItem extends StatefulWidget {
  final dynamic order;
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
    if (mounted) {
      setState(() => _isAccepting = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success ? 'Order accepted' : 'Failed to accept order')));
      if (success) widget.onStatusChanged();
    }
  }

  Future<void> _handleReject() async {
    setState(() => _isRejecting = true);
    final success = await OrderRepository().rejectOrder(widget.order['id']?.toString() ?? '');
    if (mounted) {
      setState(() => _isRejecting = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success ? 'Order rejected' : 'Failed to reject order')));
      if (success) widget.onStatusChanged();
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.order['id']?.toString() ?? '';
    final customer = widget.order['customers']?['phone'] ?? widget.order['customer_id']?.toString() ?? 'Unknown';
    final qty = widget.order['quantity']?.toString() ?? '1';
    final productName = widget.order['products']?['name'] ?? 'Unknown Product';
    final status = widget.order['status']?.toString() ?? 'Unknown';
    
    return Container(
      padding: const EdgeInsets.all(14),
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
              Text('Order #$id', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: AppColors.greenSubtle, borderRadius: BorderRadius.circular(4)),
                child: Text(status.toUpperCase(), style: const TextStyle(color: AppColors.greenDark, fontWeight: FontWeight.bold, fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('Customer: $customer', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          Text('$productName (x$qty)', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.navy)),
          const Divider(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Action:', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.green)),
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
                )
              else
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/shop-order-details', arguments: id);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.navy, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), minimumSize: Size.zero),
                  child: const Text('Manage', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
