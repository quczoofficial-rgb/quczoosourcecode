import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../widgets/admin_sidebar.dart';

/// ADMIN 06 — CATEGORY MANAGEMENT SCREEN
class AdminCategoriesScreen extends StatelessWidget {
  const AdminCategoriesScreen({super.key});

  static const List<String> _categories = [
    'Fresh Produce',
    'Groceries & Supermarket',
    'Snacks & Beverages',
    'Household Essentials',
    'Personal Care',
    'Electronics & Mobiles',
    'Mobile Accessories',
    'Hardware & Tools',
    'Electrical & Wiring',
    'Pipes & Plumbing',
    'Home Appliances',
    'Stationery & School',
    'Fashion & Apparel',
    'Local Stores',
  ];

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isWide ? null : AppBar(title: const Text('Category Management'), backgroundColor: AppColors.navy, foregroundColor: Colors.white),
      drawer: isWide ? null : const Drawer(child: AdminSidebar(activeRoute: '/admin-categories')),
      body: SafeArea(
        child: Row(
          children: [
            if (isWide) const AdminSidebar(activeRoute: '/admin-categories'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Marketplace Categories (14 Core Categories)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy)),
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white),
                          icon: const Icon(Icons.add),
                          label: const Text('Add Category'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppCorners.roundedMd, border: Border.all(color: AppColors.border)),
                        child: ListView.separated(
                          itemCount: _categories.length,
                          separatorBuilder: (c, i) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final cat = _categories[index];
                            return ListTile(
                              leading: const Icon(Icons.category, color: AppColors.green),
                              title: Text(cat, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: AppColors.greenSubtle, borderRadius: BorderRadius.circular(4)),
                                child: const Text('ACTIVE', style: TextStyle(color: AppColors.greenDark, fontWeight: FontWeight.bold, fontSize: 11)),
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
