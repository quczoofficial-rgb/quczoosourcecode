import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/utils/responsive.dart';
import '../../../models/shop_model.dart';
import '../../../widgets/common_branding.dart';

/// Nearby Shops Cards for Customer Home Screen with Photographic Store Visuals
class NearbyShopsSection extends StatelessWidget {
  final List<ShopModel> shops;
  final ValueChanged<ShopModel>? onShopTap;

  const NearbyShopsSection({super.key, required this.shops, this.onShopTap});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.9 : 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            context.tr('nearbyShops'),
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 16 * scaleFactor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Horizontal List of Shop Cards
        SizedBox(
          height: 155 * scaleFactor,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: shops.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12.0),
            itemBuilder: (context, index) {
              final shop = shops[index];

              return GestureDetector(
                onTap: () => onShopTap?.call(shop),
                child: Container(
                  width: 220 * scaleFactor,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppCorners.roundedMd,
                    boxShadow: AppShadows.card,
                    border: Border.all(
                      color: AppColors.borderLight,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Real Store Photo Thumbnail
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: 48 * scaleFactor,
                              height: 48 * scaleFactor,
                              child: shop.imageUrl.isNotEmpty
                                  ? Image.network(
                                      shop.imageUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, progress) {
                                            if (progress == null) return child;
                                            return Container(
                                              color: AppColors.surfaceSubtle,
                                              alignment: Alignment.center,
                                              child: const SizedBox(
                                                width: 18,
                                                height: 18,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: AppColors.green,
                                                    ),
                                              ),
                                            );
                                          },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                color: AppColors.surfaceSubtle,
                                                alignment: Alignment.center,
                                                child: const QuczoBrandLogo(
                                                  size: 28,
                                                  showWordmark: false,
                                                ),
                                              ),
                                    )
                                  : Container(
                                      color: AppColors.surfaceSubtle,
                                      alignment: Alignment.center,
                                      child: const QuczoBrandLogo(
                                        size: 28,
                                        showWordmark: false,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Open Status Tag
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                        vertical: 1.5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: shop.isOpen
                                            ? AppColors.green.withValues(
                                                alpha: 0.12,
                                              )
                                            : Colors.red.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        shop.isOpen ? 'OPEN NOW' : 'CLOSED',
                                        style: TextStyle(
                                          color: shop.isOpen
                                              ? AppColors.green
                                              : Colors.red,
                                          fontSize: 8.5 * scaleFactor,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),

                                    // Rating Badge
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,
                                          size: 13,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(width: 1),
                                        Text(
                                          shop.rating.toStringAsFixed(1),
                                          style: const TextStyle(
                                            color: AppColors.navy,
                                            fontSize: 10.5,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),

                                // Shop Name
                                Text(
                                  shop.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.navy,
                                    fontSize: 12.5 * scaleFactor,
                                    fontWeight: FontWeight.w700,
                                    height: 1.15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Category & Items
                      Text(
                        shop.category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11 * scaleFactor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      // Distance & Item Count Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.near_me_outlined,
                                  size: 12,
                                  color: AppColors.green,
                                ),
                                const SizedBox(width: 3),
                                Expanded(
                                  child: Text(
                                    '${shop.distanceKm} km away',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.textMuted,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${shop.itemCount}+ items',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontSize: 11 * scaleFactor,
                              fontWeight: FontWeight.w700,
                            ),
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
