import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

/// "Try searching for" Quick Suggestion Chips for Screen 08
class QuickSearchChipsSection extends StatelessWidget {
  final ValueChanged<String>? onChipTap;

  const QuickSearchChipsSection({
    super.key,
    this.onChipTap,
  });

  static const List<Map<String, dynamic>> _suggestions = [
    {
      'label': 'Surf Excel 2kg',
      'bgColor': AppColors.mintSubtle,
      'borderColor': Color(0xFFA7F3D0),
      'textColor': AppColors.greenDark,
    },
    {
      'label': 'Milk',
      'bgColor': AppColors.blueSubtle,
      'borderColor': Color(0xFFBFDBFE),
      'textColor': Color(0xFF1E40AF),
    },
    {
      'label': 'LED Bulb',
      'bgColor': AppColors.yellowSubtle,
      'borderColor': Color(0xFFFDE68A),
      'textColor': Color(0xFFB45309),
    },
    {
      'label': 'Phone Charger',
      'bgColor': AppColors.orangeSubtle,
      'borderColor': Color(0xFFFED7AA),
      'textColor': Color(0xFFC2410C),
    },
    {
      'label': 'Rice',
      'bgColor': AppColors.lavenderSubtle,
      'borderColor': Color(0xFFE9D5FF),
      'textColor': Color(0xFF6B21A8),
    },
    {
      'label': 'Power Drill',
      'bgColor': AppColors.cyanSubtle,
      'borderColor': Color(0xFFA5F3FC),
      'textColor': Color(0xFF0369A1),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.9 : 1.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr('trySearchingFor'),
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 14 * scaleFactor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _suggestions.map((chip) {
              return InkWell(
                onTap: () => onChipTap?.call(chip['label'] as String),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: chip['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: chip['borderColor'] as Color,
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.north_west,
                        size: 11,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        chip['label'] as String,
                        style: TextStyle(
                          color: chip['textColor'] as Color,
                          fontSize: 12 * scaleFactor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
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
