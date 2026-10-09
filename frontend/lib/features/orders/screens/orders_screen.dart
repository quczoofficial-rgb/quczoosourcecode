import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/config/api_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../home/widgets/custom_bottom_nav.dart';
import '../../../navigation/app_routes.dart';
import '../../../repositories/auth_repository.dart';

/// SCREEN 22 — ORDERS & RESERVATION HISTORY SCREEN (Real Supabase data)
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  List<Map<String, dynamic>> _allReservations = [];
  String? _error;

  /// Statuses that count as ACTIVE (pending / shop-acknowledged / accepted)
  static const _activeStatuses = {
    'pending', 'shop_received', 'accepted', 'confirmed', 'ready',
    'PENDING', 'SHOP_RECEIVED', 'ACCEPTED', 'CONFIRMED', 'READY',
  };

  /// Statuses that count as COMPLETED
  static const _completedStatuses = {
    'completed', 'COMPLETED',
  };

  /// Statuses that count as CANCELLED
  static const _cancelledStatuses = {
    'cancelled', 'rejected', 'CANCELLED', 'REJECTED',
  };

  List<Map<String, dynamic>> get _activeOrders =>
      _allReservations.where((r) => _activeStatuses.contains(r['status'])).toList();

  List<Map<String, dynamic>> get _completedOrders =>
      _allReservations.where((r) => _completedStatuses.contains(r['status'])).toList();

  List<Map<String, dynamic>> get _cancelledOrders =>
      _allReservations.where((r) => _cancelledStatuses.contains(r['status'])).toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchOrders() async {
    setState(() { _isLoading = true; _error = null; });

    final auth = AuthRepository();
    final token = auth.token;
    final customerId = auth.currentUserPhone; // phone used as ID in customer login

    if (token == null || customerId == null) {
      setState(() { _isLoading = false; _error = 'Not logged in'; });
      return;
    }

    try {
      // The backend route: GET /api/reservations/customer/:customerId
      // customerId here is the numeric customer table ID from the JWT, not the phone
      // We decode the JWT to get the numeric id
      final parts = token.split('.');
      if (parts.length == 3) {
        final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
        final claims = jsonDecode(payload) as Map<String, dynamic>;
        final numericId = claims['id']?.toString() ?? customerId;

        final res = await http.get(
          Uri.parse('${ApiConfig.reservations}/customer/$numericId'),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (res.statusCode == 200) {
          final body = jsonDecode(res.body);
          final List raw = body['data'] ?? [];
          setState(() {
            _allReservations = raw.map((r) => Map<String, dynamic>.from(r as Map)).toList();
            _isLoading = false;
          });
          return;
        } else {
          setState(() { _isLoading = false; _error = 'Failed: HTTP ${res.statusCode}'; });
          return;
        }
      }
    } catch (e) {
      setState(() { _isLoading = false; _error = 'Error: $e'; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Pickup Orders', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh',
            onPressed: _fetchOrders,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.green,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.green,
          tabs: [
            Tab(text: 'Active (${_activeOrders.length})'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColors.green))
            : _error != null
                ? _buildError()
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildOrderList(_activeOrders, emptyMsg: 'No active reservations'),
                      _buildOrderList(_completedOrders, emptyMsg: 'No completed orders'),
                      _buildOrderList(_cancelledOrders, emptyMsg: 'No cancelled orders'),
                    ],
                  ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) { Navigator.pushReplacementNamed(context, AppRoutes.customerHome); }
          else if (index == 1) { Navigator.pushReplacementNamed(context, AppRoutes.search); }
          else if (index == 2) { Navigator.pushNamed(context, AppRoutes.cart); }
          else if (index == 4) { Navigator.pushNamed(context, AppRoutes.profile); }
        },
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.textSecondary, size: 48),
            const SizedBox(height: 12),
            Text(_error ?? 'Unknown error', textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchOrders,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.green),
              child: const Text('Retry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(List<Map<String, dynamic>> orders, {required String emptyMsg}) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.receipt_long_outlined, size: 56, color: AppColors.textMuted),
            const SizedBox(height: 12),
            Text(emptyMsg, style: const TextStyle(color: AppColors.textSecondary, fontSize: 15)),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.green,
      onRefresh: _fetchOrders,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _buildOrderCard(orders[index]),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final rawStatus = (order['status'] ?? 'pending').toString();
    final displayStatus = _statusLabel(rawStatus);
    final statusColor = _statusColor(rawStatus);

    // Friendly order ID from UUID or fallback
    final orderId = 'QCZ-${(order['id']?.toString() ?? '').substring(0, 8).toUpperCase()}';

    // Product name from join or fallback
    final productName = order['products'] != null
        ? (order['products']['name'] ?? 'Product')
        : 'Product';

    final qty = order['quantity']?.toString() ?? '1';
    final createdAt = order['created_at'] != null
        ? _formatDate(order['created_at'].toString())
        : 'Recently';

    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/pickup-status', arguments: orderId),
      borderRadius: AppCorners.roundedMd,
      child: Container(
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
                Text(orderId,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 13)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(displayStatus,
                      style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 11)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(productName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.navy)),
            const SizedBox(height: 4),
            Text('Qty: $qty', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            const Divider(height: 20),
            Text(createdAt, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  String _statusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'pending': return 'Shop Received';
      case 'shop_received': return 'Shop Received';
      case 'accepted': return 'Accepted';
      case 'confirmed': return 'Confirmed';
      case 'ready': return 'Ready for Pickup';
      case 'completed': return 'Completed';
      case 'cancelled': return 'Cancelled';
      case 'rejected': return 'Rejected';
      default: return status;
    }
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'shop_received': return const Color(0xFF2563EB);
      case 'accepted':
      case 'confirmed': return AppColors.green;
      case 'ready': return const Color(0xFF059669);
      case 'completed': return AppColors.greenDark;
      case 'cancelled':
      case 'rejected': return const Color(0xFFDC2626);
      default: return AppColors.textSecondary;
    }
  }

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso).toLocal();
      final now = DateTime.now();
      final diff = now.difference(dt);
      if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
      if (diff.inHours < 24) return '${diff.inHours} hr ago';
      if (diff.inDays == 1) return 'Yesterday';
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) { return iso; }
  }
}
