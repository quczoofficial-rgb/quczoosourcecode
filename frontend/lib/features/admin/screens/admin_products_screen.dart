import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../widgets/admin_sidebar.dart';

/// ADMIN 05 — GLOBAL PRODUCT CATALOG MANAGEMENT SCREEN
class AdminProductsScreen extends StatelessWidget {
  const AdminProductsScreen({super.key});

  static const List<Map<String, dynamic>> _adminProducts = [
    {'name': 'Sona Masoori Rice 5kg', 'category': 'Grocery', 'shopsCount': 4, 'bestPrice': 295},
    {'name': '12W Cool Day LED Bulb B22', 'category': 'Electrical & Wiring', 'shopsCount': 3, 'bestPrice': 89},
    {'name': 'Surf Excel Easy Wash 2kg', 'category': 'Household', 'shopsCount': 4, 'bestPrice': 240},
    {'name': 'CPVC Pipe 1 inch Heavy Duty', 'category': 'Pipes & Plumbing', 'shopsCount': 4, 'bestPrice': 170},
  ];

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isWide ? null : AppBar(title: const Text('Global Product Catalog'), backgroundColor: AppColors.navy, foregroundColor: Colors.white),
      drawer: isWide ? null : const Drawer(child: AdminSidebar(activeRoute: '/admin-products')),
      body: SafeArea(
        child: Row(
          children: [
            if (isWide) const AdminSidebar(activeRoute: '/admin-products'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Global Product Catalog Management', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy)),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppCorners.roundedMd, border: Border.all(color: AppColors.border)),
                        child: ListView.separated(
                          itemCount: _adminProducts.length,
                          separatorBuilder: (c, i) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final p = _adminProducts[index];
                            return ListTile(
                              leading: const Icon(Icons.inventory_2_outlined, color: AppColors.green),
                              title: Text(p['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                              subtitle: Text('Category: ${p['category']} • Listed by ${p['shopsCount']} local shops'),
                              trailing: Text('Best Price: ₹${p['bestPrice']}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.green, fontSize: 14)),
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
