import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../navigation/app_routes.dart';

/// SCREEN 29 — SAVED SHOPS SCREEN
class SavedShopsScreen extends StatelessWidget {
  const SavedShopsScreen({super.key});

  static const List<Map<String, dynamic>> _savedShops = [
    {
      'name': 'Super Fresh Supermarket & Groceries',
      'category': 'Supermarket & Groceries',
      'distance': '0.5 km',
      'rating': 4.8,
    },
    {
      'name': 'Lakshmi Electricals & Lighting',
      'category': 'Electrical & Lighting',
      'distance': '0.8 km',
      'rating': 4.8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Saved Local Shops', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: _savedShops.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final shop = _savedShops[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppCorners.roundedMd,
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(Icons.storefront, color: AppColors.green, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(shop['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 14)),
                        const SizedBox(height: 2),
                        Text('${shop['category']} • ${shop['distance']}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Color(0xFFDC2626)),
                    onPressed: () {},
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.shopDetails);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, elevation: 0),
                    child: const Text('View'),
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
