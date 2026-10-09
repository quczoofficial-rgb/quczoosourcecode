import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../navigation/app_routes.dart';

/// SCREEN 16 — NEARBY SHOPS MAP & DISCOVERY SCREEN
class NearbyShopsMapScreen extends StatelessWidget {
  const NearbyShopsMapScreen({super.key});

  static const List<Map<String, dynamic>> _nearbyShopsList = [
    {
      'name': 'Super Fresh Supermarket & Groceries',
      'category': 'Supermarket',
      'distance': '0.5 km',
      'rating': 4.8,
      'items': 1250,
      'isOpen': true,
    },
    {
      'name': 'Lakshmi Electricals & Lighting',
      'category': 'Electrical & Wiring',
      'distance': '0.8 km',
      'rating': 4.8,
      'items': 650,
      'isOpen': true,
    },
    {
      'name': 'Student Stationery & Book Hub',
      'category': 'Stationery & Books',
      'distance': '0.6 km',
      'rating': 4.7,
      'items': 890,
      'isOpen': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Shops Near You', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Map Visualizer Canvas Simulation
            Container(
              color: const Color(0xFFE2E8F0),
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map_outlined, size: 64, color: AppColors.textMuted),
                        SizedBox(height: 8),
                        Text('Interactive Map View: Anna Nagar, Chennai', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                  // Shop Pins Simulated
                  Positioned(
                    top: 140,
                    left: 80,
                    child: _buildMapPin(context, 'Super Fresh', '0.5 km'),
                  ),
                  Positioned(
                    top: 220,
                    right: 60,
                    child: _buildMapPin(context, 'Lakshmi Electricals', '0.8 km'),
                  ),
                ],
              ),
            ),

            // Bottom Draggable Sheet of Shops
            DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.2,
              maxChildSize: 0.85,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: _nearbyShopsList.length + 1,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)),
                          ),
                        );
                      }
                      final shop = _nearbyShopsList[index - 1];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.background,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapPin(BuildContext context, String name, String dist) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.shopDetails);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.green, width: 1.5),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.storefront, color: AppColors.green, size: 16),
            const SizedBox(width: 4),
            Text(name, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.navy)),
          ],
        ),
      ),
    );
  }
}
