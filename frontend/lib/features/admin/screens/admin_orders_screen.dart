import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../widgets/admin_sidebar.dart';

/// ADMIN 07 — RESERVATIONS & ORDER MONITORING SCREEN
class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  static const List<Map<String, dynamic>> _adminOrders = [
    {
      'id': 'QCZ-98241',
      'customer': 'Ramesh Kumar (+91 98765 43210)',
      'shop': 'Super Fresh Supermarket',
      'items': 'Sona Masoori Rice 5kg, 12W LED Bulb',
      'total': 473,
      'status': 'Ready for Pickup',
      'color': AppColors.green,
    },
    {
      'id': 'QCZ-98240',
      'customer': 'Priya Sundaram (+91 98765 12345)',
      'shop': 'Lakshmi Electricals',
      'items': '9W LED Bulb B22',
      'total': 89,
      'status': 'Stock Reserved',
      'color': Color(0xFF2563EB),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isWide ? null : AppBar(title: const Text('Reservation Monitoring'), backgroundColor: AppColors.navy, foregroundColor: Colors.white),
      drawer: isWide ? null : const Drawer(child: AdminSidebar(activeRoute: '/admin-orders')),
      body: SafeArea(
        child: Row(
          children: [
            if (isWide) const AdminSidebar(activeRoute: '/admin-orders'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Platform Pickup Reservations Monitor', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy)),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppCorners.roundedMd, border: Border.all(color: AppColors.border)),
                        child: ListView.separated(
                          itemCount: _adminOrders.length,
                          separatorBuilder: (c, i) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final o = _adminOrders[index];
                            final Color statusColor = o['color'] as Color;
                            return ListTile(
                              leading: const Icon(Icons.receipt_long, color: AppColors.navy),
                              title: Text('Order #${o['id']} • ₹${o['total']}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                              subtitle: Text('Customer: ${o['customer']}\nShop: ${o['shop']}'),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(4)),
                                child: Text(o['status'] as String, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 11)),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
