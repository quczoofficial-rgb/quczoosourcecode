import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../core/utils/responsive.dart';
import '../../../models/category_model.dart';
import 'home_image_assets.dart';

/// Image-Based Category Discovery Carousel for Customer Home Screen
class CategoryCarousel extends StatelessWidget {
  final List<CategoryModel> categories;
  final ValueChanged<CategoryModel>? onCategoryTap;
  final VoidCallback? onViewAllTap;

  const CategoryCarousel({
    super.key,
    required this.categories,
    this.onCategoryTap,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.9 : 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header with View All
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  context.tr('shopByCategory'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 16 * scaleFactor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              InkWell(
                onTap: onViewAllTap,
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View All',
                        style: TextStyle(
                          color: AppColors.green,
                          fontSize: 12.5 * scaleFactor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: AppColors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Horizontal Image-Based Category Cards
        SizedBox(
          height: 138 * scaleFactor,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12.0),
            itemBuilder: (context, index) {
              final category = categories[index];
              final String categoryTitle = context.tr(category.titleKey);

              return GestureDetector(
                onTap: () => onCategoryTap?.call(category),
                child: Container(
                  width: 110 * scaleFactor,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: category.backgroundColor,
                    borderRadius: AppCorners.roundedLg,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0A0F172A),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: category.iconColor.withValues(alpha: 0.22),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Large Recognized Category Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: HomeImageAssets.buildCategoryImage(
                          category.id,
                          height: 70 * scaleFactor,
                          width: 94 * scaleFactor,
                          imageUrl: category.imageUrl,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        categoryTitle.isNotEmpty ? categoryTitle : category.fallbackTitle,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: 11.5 * scaleFactor,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
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
