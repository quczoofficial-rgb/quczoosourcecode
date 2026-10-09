import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';

/// SCREEN 43 — INVENTORY DASHBOARD SCREEN
class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  static const List<Map<String, dynamic>> _stockItems = [
    {'name': 'Sona Masoori Rice 5kg', 'category': 'Grocery', 'stock': 45, 'status': 'In Stock', 'price': 295},
    {'name': '12W Cool Day LED Bulb', 'category': 'Electrical', 'stock': 8, 'status': 'Low Stock', 'price': 89},
    {'name': 'Surf Excel Easy Wash 2kg', 'category': 'Household', 'stock': 24, 'status': 'In Stock', 'price': 240},
    {'name': '20W USB-C Fast Charger', 'category': 'Electronics', 'stock': 0, 'status': 'Out of Stock', 'price': 820},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Inventory Control', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: _stockItems.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final item = _stockItems[index];
            final String status = item['status'] as String;
            final isOut = status == 'Out of Stock';
            final isLow = status == 'Low Stock';

            final Color badgeColor = isOut ? const Color(0xFFDC2626) : (isLow ? const Color(0xFFD97706) : AppColors.green);

            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppCorners.roundedMd,
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 14)),
                        const SizedBox(height: 2),
                        Text('Price: ₹${item['price']} • Category: ${item['category']}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('${item['stock']} units (${item['status']})', style: TextStyle(color: badgeColor, fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
