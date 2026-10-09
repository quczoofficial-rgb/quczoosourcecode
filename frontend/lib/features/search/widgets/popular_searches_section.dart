import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

/// Popular Searches Section with Diverse Non-Grocery Examples for Screen 08 Part B
class PopularSearchesSection extends StatelessWidget {
  final ValueChanged<String> onQueryTap;

  const PopularSearchesSection({
    super.key,
    required this.onQueryTap,
  });

  static const List<Map<String, dynamic>> _popularItems = [
    {'title': 'Milk', 'color': Color(0xFFE6F4EA), 'textColor': Color(0xFF047857), 'icon': Icons.local_drink_outlined},
    {'title': 'Rice', 'color': Color(0xFFFEF7E0), 'textColor': Color(0xFFB45309), 'icon': Icons.rice_bowl_outlined},
    {'title': 'Shampoo', 'color': Color(0xFFF3E8FF), 'textColor': Color(0xFF6B21A8), 'icon': Icons.sanitizer_outlined},
    {'title': 'LED Bulb', 'color': Color(0xFFFEF9C3), 'textColor': Color(0xFFA16207), 'icon': Icons.lightbulb_outlined},
    {'title': 'Phone Charger', 'color': Color(0xFFE8F0FE), 'textColor': Color(0xFF1D4ED8), 'icon': Icons.power_outlined},
    {'title': 'Notebook', 'color': Color(0xFFFFE8D6), 'textColor': Color(0xFFC2410C), 'icon': Icons.menu_book_outlined},
    {'title': 'Power Drill', 'color': Color(0xFFE0F7FA), 'textColor': Color(0xFF0E7490), 'icon': Icons.build_outlined},
    {'title': 'Detergent', 'color': Color(0xFFFFE5EC), 'textColor': Color(0xFFBE123C), 'icon': Icons.cleaning_services_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.9 : 1.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: "Popular searches"
          Row(
            children: [
              const Icon(
                Icons.trending_up,
                size: 16,
                color: AppColors.green,
              ),
              const SizedBox(width: 6),
              Text(
                context.tr('popularSearches'),
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 14 * scaleFactor,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Pastel chips grid/wrap
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _popularItems.map((item) {
              final String title = item['title'] as String;
              final Color bg = item['color'] as Color;
              final Color textColor = item['textColor'] as Color;
              final IconData icon = item['icon'] as IconData;

              return Container(
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: textColor.withValues(alpha: 0.2),
                  ),
                ),
                child: InkWell(
                  onTap: () => onQueryTap(title),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon,
                          size: 13,
                          color: textColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          title,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12.5 * scaleFactor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
