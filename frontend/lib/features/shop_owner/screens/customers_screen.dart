import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';

/// SCREEN 46 — SHOP CUSTOMERS SCREEN
class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  static const List<Map<String, dynamic>> _customerList = [
    {'name': 'Ramesh Kumar', 'phone': '+91 98765 43210', 'ordersCount': 8, 'lastPickup': 'Yesterday'},
    {'name': 'Priya Sundaram', 'phone': '+91 98765 12345', 'ordersCount': 4, 'lastPickup': '3 days ago'},
    {'name': 'Anand Verma', 'phone': '+91 98765 99999', 'ordersCount': 12, 'lastPickup': '1 week ago'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Regular Shop Customers', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: _customerList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final c = _customerList[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppCorners.roundedMd,
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.greenSubtle,
                    child: Text((c['name'] as String)[0], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.green)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 14)),
                        const SizedBox(height: 2),
                        Text('${c['phone']} • ${c['ordersCount']} pickup orders', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
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
