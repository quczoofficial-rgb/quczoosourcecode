import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/utils/responsive.dart';
import '../../../models/product_model.dart';
import 'home_image_assets.dart';

/// "Compare Nearby Prices" Multi-Shop Comparison Section for QUCZO Home
class PriceComparisonSection extends StatelessWidget {
  final List<ProductModel> deals;
  final ValueChanged<ProductModel>? onCompareTap;

  const PriceComparisonSection({
    super.key,
    required this.deals,
    this.onCompareTap,
  });

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Compare Nearby Prices',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 16 * scaleFactor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.greenSubtle,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'CORE FEATURE',
                      style: TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 9 * scaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'See the same product across nearby shops',
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

        // Vertical List of Comparison Cards
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: deals.map((deal) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppCorners.roundedMd,
                  boxShadow: AppShadows.card,
                  border: Border.all(color: AppColors.green.withValues(alpha: 0.2), width: 1.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Product Image Visual
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: HomeImageAssets.buildProductImage(
                            deal.category,
                            deal.name,
                            height: 48 * scaleFactor,
                            width: 54 * scaleFactor,
                            imageUrl: deal.imageUrl,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Title & Best Price
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                deal.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.navy,
                                  fontSize: 13.5 * scaleFactor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${context.tr('fromPrice')} ₹${(deal.bestPrice ?? deal.price).toStringAsFixed(0)}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.green,
                                        fontSize: 13 * scaleFactor,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.surfaceSubtle,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        deal.availability, // e.g. "3 nearby shops"
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 10 * scaleFactor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Multi-Shop 4-Factor Preview (Price, Distance, Rating, Availability)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: _buildFactorChip('₹${(deal.bestPrice ?? deal.price).toStringAsFixed(0)}', 'Best Price', AppColors.green)),
                          Expanded(child: _buildFactorChip('${deal.distanceKm} km', 'Distance', AppColors.navy)),
                          Expanded(child: _buildFactorChip('${deal.rating} ★', 'Rating', const Color(0xFFD97706))),
                          Expanded(child: _buildFactorChip('In Stock', 'Status', AppColors.green)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Compare CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 36,
                      child: ElevatedButton.icon(
                        onPressed: () => onCompareTap?.call(deal),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.compare_arrows, size: 16),
                        label: Text(
                          'Compare Shops',
                          style: TextStyle(
                            fontSize: 12 * scaleFactor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFactorChip(String value, String label, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: color,
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 9.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
