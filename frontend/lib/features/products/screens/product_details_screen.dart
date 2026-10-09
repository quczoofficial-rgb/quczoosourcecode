import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../models/product_model.dart';
import '../../../navigation/app_routes.dart';
import '../../../repositories/cart_repository.dart';

/// SCREEN 14 — PRODUCT DETAILS SCREEN
class ProductDetailsScreen extends StatelessWidget {
  final ProductModel? product;

  const ProductDetailsScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final String pName = product?.name ?? 'Sona Masoori Rice 5kg';
    final String pBrand = product?.brand ?? 'Fortune';
    final double pPrice = product?.price ?? 340.0;
    final double pBestPrice = product?.bestPrice ?? 295.0;
    final String pShop = product?.shopName ?? 'Super Fresh Supermarket';
    final String pImg = product?.imageUrl ?? 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400&q=80';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Product Details', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Hero Image Container
              Container(
                height: 240,
                width: double.infinity,
                color: AppColors.surface,
                child: Image.network(
                  pImg,
                  fit: BoxFit.contain,
                  errorBuilder: (ctx, err, stack) => const Icon(Icons.image, size: 80, color: AppColors.textMuted),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.greenSubtle,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        pBrand.toUpperCase(),
                        style: const TextStyle(color: AppColors.greenDark, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pName,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy),
                    ),
                    const SizedBox(height: 12),

                    // Price comparison summary
                    Row(
                      children: [
                        Text(
                          '₹${pBestPrice.toInt()}',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.green),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '₹${pPrice.toInt()}',
                          style: const TextStyle(fontSize: 14, color: AppColors.textMuted, decoration: TextDecoration.lineThrough),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF7E0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Available at 4 nearby shops',
                            style: TextStyle(color: Color(0xFFB45309), fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Preferred Shop Tile
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppCorners.roundedMd,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('BEST NEARBY PICKUP SHOP', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.storefront, color: AppColors.green, size: 22),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(pShop, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                                    const Text('0.5 km away • Open till 10:00 PM', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                  ],
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.shopDetails);
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: AppColors.green),
                                  foregroundColor: AppColors.green,
                                ),
                                child: const Text('View Shop'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Product Description',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.navy),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product?.description != null && product!.description.isNotEmpty
                          ? product!.description
                          : 'Premium high quality product sourced directly from verified local suppliers. Stock verified in real-time across nearby stores in your area.',
                      style: const TextStyle(color: AppColors.textSecondary, height: 1.4),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/price-comparison', arguments: product);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.navy),
                  foregroundColor: AppColors.navy,
                  minimumSize: const Size(0, 48),
                ),
                child: const Text('Compare Prices', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (product != null) {
                    CartRepository().addItem(product!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product!.name} added to cart')),
                    );
                  }
                  Navigator.pushNamed(context, AppRoutes.cart);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 48),
                ),
                child: const Text('Reserve for Pickup', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
