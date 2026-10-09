import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

/// Natural Language Search Intent Prompts Section for Screen 08 Part B
class NaturalSearchExamples extends StatelessWidget {
  final ValueChanged<String> onQueryTap;

  const NaturalSearchExamples({
    super.key,
    required this.onQueryTap,
  });

  static const List<String> _naturalQueries = [
    'Find milk nearby',
    'Surf Excel 2kg',
    'I need an LED bulb',
    'Show me phone chargers',
    'Where can I find a power drill?',
    'Find notebooks near me',
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
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                size: 15,
                color: AppColors.green,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  context.tr('naturalSearchExamples'),
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 13.5 * scaleFactor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _naturalQueries.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final query = _naturalQueries[index];
                return InkWell(
                  onTap: () => onQueryTap(query),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.greenSubtle,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.green.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.chat_bubble_outline,
                          size: 13,
                          color: AppColors.greenDark,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '"$query"',
                          style: TextStyle(
                            color: AppColors.greenDark,
                            fontSize: 12 * scaleFactor,
                            fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
