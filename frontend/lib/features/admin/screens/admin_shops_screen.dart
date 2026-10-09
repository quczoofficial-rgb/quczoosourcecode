import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../widgets/admin_sidebar.dart';

/// ADMIN 04 — SHOP MANAGEMENT SCREEN
class AdminShopsScreen extends StatelessWidget {
  const AdminShopsScreen({super.key});

  static const List<Map<String, dynamic>> _shops = [
    {'name': 'Super Fresh Supermarket & Groceries', 'category': 'Supermarket', 'location': 'Anna Nagar, Chennai', 'status': 'Verified', 'items': 1250},
    {'name': 'Lakshmi Electricals & Lighting', 'category': 'Electrical & Wiring', 'location': 'Anna Nagar, Chennai', 'status': 'Verified', 'items': 650},
    {'name': 'Student Stationery & Book Hub', 'category': 'Stationery & Books', 'location': 'Anna Nagar, Chennai', 'status': 'Verified', 'items': 890},
    {'name': 'Sri Balaji Hardware & Pipes', 'category': 'Hardware & Plumbing', 'location': 'Anna Nagar, Chennai', 'status': 'Pending Review', 'items': 420},
  ];

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isWide ? null : AppBar(title: const Text('Shop Directory'), backgroundColor: AppColors.navy, foregroundColor: Colors.white),
      drawer: isWide ? null : const Drawer(child: AdminSidebar(activeRoute: '/admin-shops')),
      body: SafeArea(
        child: Row(
          children: [
            if (isWide) const AdminSidebar(activeRoute: '/admin-shops'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Registered Local Shops Directory', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy)),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppCorners.roundedMd, border: Border.all(color: AppColors.border)),
                        child: ListView.separated(
                          itemCount: _shops.length,
                          separatorBuilder: (c, i) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final s = _shops[index];
                            final bool isVer = s['status'] == 'Verified';
                            return ListTile(
                              leading: const Icon(Icons.storefront, color: AppColors.green),
                              title: Text(s['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                              subtitle: Text('${s['category']} • ${s['location']} • ${s['items']} listed products'),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: isVer ? AppColors.greenSubtle : const Color(0xFFFEF7E0), borderRadius: BorderRadius.circular(4)),
                                child: Text(s['status'] as String, style: TextStyle(color: isVer ? AppColors.greenDark : const Color(0xFFB45309), fontWeight: FontWeight.bold, fontSize: 11)),
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
