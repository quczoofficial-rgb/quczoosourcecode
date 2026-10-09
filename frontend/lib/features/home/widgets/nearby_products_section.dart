import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/utils/responsive.dart';
import '../../../models/product_model.dart';
import 'home_image_assets.dart';

/// Available Near You Product Carousel for Customer Home Screen
class NearbyProductsSection extends StatelessWidget {
  final List<ProductModel> products;
  final ValueChanged<ProductModel>? onProductTap;

  const NearbyProductsSection({
    super.key,
    required this.products,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.9 : 1.0;
    final double cardWidth = screenWidth <= 360 ? 150 : 165;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header & Subtitle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr('availableNearYou'),
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 16 * scaleFactor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Ready to reserve from nearby shops',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12 * scaleFactor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Horizontal Product Cards
        SizedBox(
          height: 215 * scaleFactor,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10.0),
            itemBuilder: (context, index) {
              final product = products[index];

              return GestureDetector(
                onTap: () => onProductTap?.call(product),
                child: Container(
                  width: cardWidth,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppCorners.roundedMd,
                    boxShadow: AppShadows.card,
                    border: Border.all(color: AppColors.borderLight, width: 1.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Large Recognized Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: HomeImageAssets.buildProductImage(
                          product.category,
                          product.name,
                          height: 90 * scaleFactor,
                          width: double.infinity,
                          imageUrl: product.imageUrl,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Availability Tag & Distance
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.greenSubtle,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                product.availability,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.greenDark,
                                  fontSize: 9.5 * scaleFactor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${product.distanceKm} km',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 10 * scaleFactor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Product Name
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: 12.5 * scaleFactor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),

                      // Shop Name
                      Text(
                        product.shopName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 10.5 * scaleFactor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),

                      // Price & Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹${product.price.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: AppColors.green,
                              fontSize: 14 * scaleFactor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFFD97706),
                                size: 12,
                              ),
                              Text(
                                '${product.rating}',
                                style: TextStyle(
                                  color: AppColors.navy,
                                  fontSize: 10.5 * scaleFactor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
