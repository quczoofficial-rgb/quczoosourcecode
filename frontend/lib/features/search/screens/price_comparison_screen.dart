import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../models/product_model.dart';
import '../../../navigation/app_routes.dart';

/// SCREEN 13 — PRICE COMPARISON SCREEN (CORE QUCZO FEATURE)
class PriceComparisonScreen extends StatelessWidget {
  final ProductModel? product;

  const PriceComparisonScreen({super.key, this.product});

  static const List<Map<String, dynamic>> _comparisonShops = [
    {
      'shopName': 'Super Fresh Supermarket',
      'price': 240,
      'originalPrice': 275,
      'distanceKm': 0.5,
      'rating': 4.8,
      'availability': 'In Stock (12 units)',
      'badge': 'BEST PRICE',
      'badgeColor': AppColors.green,
    },
    {
      'shopName': 'Anna Nagar Fresh Mart',
      'price': 250,
      'originalPrice': 275,
      'distanceKm': 0.3,
      'rating': 4.9,
      'availability': 'In Stock (5 units)',
      'badge': 'NEAREST',
      'badgeColor': Color(0xFF2563EB),
    },
    {
      'shopName': 'Green Leaf General Store',
      'price': 255,
      'originalPrice': 275,
      'distanceKm': 0.8,
      'rating': 4.7,
      'availability': 'In Stock (8 units)',
      'badge': null,
      'badgeColor': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final String titleName = product?.name ?? 'Surf Excel Easy Wash 2kg';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Compare Nearby Shops', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Summary Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppCorners.roundedMd,
                  border: Border.all(color: AppColors.green.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.compare_arrows, color: AppColors.green, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titleName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.navy,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Available at 3 shops near Anna Nagar, Chennai',
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'LOCAL SHOP COMPARISON',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 12),

              // Shops Comparison List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _comparisonShops.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final shop = _comparisonShops[index];
                  final String? badge = shop['badge'] as String?;
                  final Color? badgeColor = shop['badgeColor'] as Color?;

                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppCorners.roundedMd,
                      border: Border.all(
                        color: badge != null ? (badgeColor ?? AppColors.green) : AppColors.border,
                        width: badge != null ? 1.5 : 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                shop['shopName'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppColors.navy,
                                ),
                              ),
                            ),
                            if (badge != null) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: (badgeColor ?? AppColors.green).withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  badge,
                                  style: TextStyle(
                                    color: badgeColor ?? AppColors.green,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 14, color: Color(0xFFEAB308)),
                            const SizedBox(width: 4),
                            Text(
                              '${shop['rating']} • ${shop['distanceKm']} km away',
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                            ),
                            const Spacer(),
                            Text(
                              '${shop['availability']}',
                              style: const TextStyle(color: AppColors.greenDark, fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '₹${shop['price']}',
                                  style: const TextStyle(
                                    color: AppColors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  'MRP ₹${shop['originalPrice']}',
                                  style: const TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 11,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.cart);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Reserve for Pickup', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
