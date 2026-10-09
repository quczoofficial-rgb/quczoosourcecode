import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../core/utils/responsive.dart';
import '../../../models/category_model.dart';
import '../../home/widgets/home_image_assets.dart';

/// "Explore products" Category Shortcuts Carousel for Screen 08
class SearchCategoryShortcuts extends StatelessWidget {
  final List<CategoryModel> categories;
  final ValueChanged<CategoryModel>? onCategoryTap;

  const SearchCategoryShortcuts({
    super.key,
    required this.categories,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.9 : 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            context.tr('exploreProducts'),
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 16 * scaleFactor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 124 * scaleFactor,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10.0),
            itemBuilder: (context, index) {
              final category = categories[index];
              final String categoryTitle = context.tr(category.titleKey);

              return GestureDetector(
                onTap: () => onCategoryTap?.call(category),
                child: Container(
                  width: 100 * scaleFactor,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: category.backgroundColor,
                    borderRadius: AppCorners.roundedMd,
                    border: Border.all(
                      color: category.iconColor.withValues(alpha: 0.18),
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Semantically Correct Product Cutout Category Photo
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: HomeImageAssets.buildCategoryImage(
                          category.id,
                          height: 58 * scaleFactor,
                          width: 84 * scaleFactor,
                          imageUrl: category.imageUrl,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        categoryTitle.isNotEmpty ? categoryTitle : category.fallbackTitle,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: 11 * scaleFactor,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
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
