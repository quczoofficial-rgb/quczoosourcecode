import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/utils/responsive.dart';
import '../../../models/product_model.dart';

enum SearchStatus { idle, loading, empty, error, results }

/// Interactive Search State & Product Results View for Screen 08 Part B
class SearchResultsStateView extends StatelessWidget {
  final SearchStatus status;
  final List<ProductModel> products;
  final String activeQuery;
  final VoidCallback onRetry;
  final ValueChanged<ProductModel>? onProductTap;

  const SearchResultsStateView({
    super.key,
    required this.status,
    required this.products,
    required this.activeQuery,
    required this.onRetry,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.9 : 1.0;

    switch (status) {
      case SearchStatus.idle:
        return const SizedBox.shrink();

      case SearchStatus.loading:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 20.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 36,
                height: 36,
                child: CircularProgressIndicator(
                  color: AppColors.green,
                  strokeWidth: 3,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Searching for "$activeQuery"...',
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 14 * scaleFactor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );

      case SearchStatus.error:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF2F2),
            borderRadius: AppCorners.roundedMd,
            border: Border.all(color: const Color(0xFFFCA5A5)),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.error_outline,
                color: Color(0xFFDC2626),
                size: 36,
              ),
              const SizedBox(height: 10),
              Text(
                context.tr('searchErrorGeneric'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 13.5 * scaleFactor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              ElevatedButton.icon(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.refresh, size: 16),
                label: Text(
                  context.tr('retryCTA'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );

      case SearchStatus.empty:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 20.0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: AppColors.surfaceSubtle,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.search_off_outlined,
                  color: AppColors.textSecondary,
                  size: 30,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'No products found for "$activeQuery"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 14 * scaleFactor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                context.tr('searchNaturalHint'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12 * scaleFactor,
                ),
              ),
            ],
          ),
        );

      case SearchStatus.results:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${products.length} results for "$activeQuery"',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 14 * scaleFactor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7ED),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Location unavailable',
                      style: TextStyle(
                        color: const Color(0xFFEA580C),
                        fontSize: 11 * scaleFactor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return InkWell(
                    onTap: () {
                      if (onProductTap != null) onProductTap!(product);
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppCorners.roundedMd,
                        border: Border.all(color: AppColors.border),
                        boxShadow: AppShadows.card,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.imageUrl,
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 72,
                              height: 72,
                              color: AppColors.surfaceSubtle,
                              child: const Icon(
                                Icons.image_not_supported_outlined,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.navy,
                                  fontSize: 13.5 * scaleFactor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                product.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 11 * scaleFactor,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${product.brand} • ${product.category}',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 11.5 * scaleFactor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    '₹${(product.bestPrice ?? product.price).toInt()}',
                                    style: TextStyle(
                                      color: AppColors.green,
                                      fontSize: 15 * scaleFactor,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  if (product.bestPrice != null && product.price > product.bestPrice!)
                                    Text(
                                      '₹${product.price.toInt()}',
                                      style: TextStyle(
                                        color: AppColors.textMuted,
                                        fontSize: 12 * scaleFactor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  const Spacer(),
                                  Text(
                                    '${product.distanceKm} km',
                                    style: TextStyle(
                                      color: AppColors.navy,
                                      fontSize: 11.5 * scaleFactor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.storefront_outlined,
                                    size: 13,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      product.shopName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 11.5 * scaleFactor,
                                        fontWeight: FontWeight.w500,
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
                  ),
                );
              },
              ),
            ],
          ),
        );
    }
  }
}
