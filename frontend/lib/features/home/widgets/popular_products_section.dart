import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../core/utils/responsive.dart';
import '../../../models/product_model.dart';
import 'home_image_assets.dart';

/// "Popular Near You" Consumer Carousel for QUCZO Home
class PopularProductsSection extends StatelessWidget {
  final List<ProductModel> products;
  final ValueChanged<ProductModel>? onProductTap;

  const PopularProductsSection({
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr('popularNearYou'),
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 16 * scaleFactor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Products customers are finding nearby',
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
        SizedBox(
          height: 215 * scaleFactor,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                width: cardWidth,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Card(
                  elevation: 0,
                  color: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppCorners.roundedMd,
                    side: const BorderSide(color: AppColors.borderLight, width: 1.0),
                  ),
                  child: InkWell(
                    onTap: () => onProductTap?.call(product),
                    borderRadius: AppCorners.roundedMd,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Large Product Image (50% Card Height)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: HomeImageAssets.buildProductImage(
                              product.category,
                              product.name,
                              height: 95 * scaleFactor,
                              width: double.infinity,
                              imageUrl: product.imageUrl,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Brand & Product Name
                          Text(
                            product.brand,
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 10 * scaleFactor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
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
                          const Spacer(),

                          // Price, Rating & Distance
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  '₹${product.price.toStringAsFixed(0)}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.green,
                                    fontSize: 13.5 * scaleFactor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xFFD97706),
                                    size: 11,
                                  ),
                                  Text(
                                    '${product.rating}',
                                    style: TextStyle(
                                      color: AppColors.navy,
                                      fontSize: 10 * scaleFactor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    '${product.distanceKm}km',
                                    style: TextStyle(
                                      color: AppColors.textMuted,
                                      fontSize: 10 * scaleFactor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
