import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../models/shop_model.dart';
import '../../../navigation/app_routes.dart';

/// SCREEN 15 — SHOP DETAILS SCREEN
class ShopDetailsScreen extends StatelessWidget {
  final ShopModel? shop;

  const ShopDetailsScreen({super.key, this.shop});

  @override
  Widget build(BuildContext context) {
    final String sName = shop?.name ?? 'Super Fresh Supermarket & Groceries';
    final String sCat = shop?.category ?? 'Supermarket & Groceries';
    final double sDist = shop?.distanceKm ?? 0.5;
    final double sRating = shop?.rating ?? 4.8;
    final int sCount = shop?.itemCount ?? 1250;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Shop Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Store Front Banner Header
              Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.navy,
                  image: DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=600&q=80'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            sName,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.greenSubtle,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('VERIFIED SHOP', style: TextStyle(color: AppColors.greenDark, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(sCat, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFEAB308), size: 16),
                        const SizedBox(width: 4),
                        Text('$sRating (240 reviews)', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        const SizedBox(width: 16),
                        const Icon(Icons.location_on, color: AppColors.green, size: 16),
                        const SizedBox(width: 4),
                        Text('$sDist km away', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      ],
                    ),
                    const Divider(height: 24),

                    // Pickup Address Info Card
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppCorners.roundedMd,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.storefront, color: AppColors.green, size: 18),
                              SizedBox(width: 6),
                              Text('PHYSICAL PICKUP ADDRESS', style: TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Text('No. 42, 2nd Avenue, Anna Nagar East, Chennai - 600102', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                          const SizedBox(height: 6),
                          const Text('Open Today: 8:00 AM - 10:00 PM', style: TextStyle(color: AppColors.greenDark, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      'AVAILABLE INVENTORY ($sCount items)',
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8),
                    ),
                    const SizedBox(height: 12),

                    // Sample products in this shop
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network('https://images.unsplash.com/photo-1586201375761-83865001e31c?w=200&q=80', width: 50, height: 50, fit: BoxFit.cover),
                          ),
                          title: Text('Sona Masoori Rice 5kg #$index', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.navy)),
                          subtitle: const Text('In Stock • Pickup Today'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.cart);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white, elevation: 0),
                            child: const Text('Reserve'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
