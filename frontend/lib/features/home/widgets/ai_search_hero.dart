import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../core/utils/responsive.dart';

/// Clean Commerce Search Hero Box for Customer Home Screen (Matching Reference Screen 07)
class AiSearchHero extends StatelessWidget {
  final VoidCallback? onSearchTap;
  final VoidCallback? onVoiceSearchTap;
  final VoidCallback? onImageSearchTap;
  final ValueChanged<String>? onSuggestionTap;

  const AiSearchHero({
    super.key,
    this.onSearchTap,
    this.onVoiceSearchTap,
    this.onImageSearchTap,
    this.onSuggestionTap,
  });

  static const List<String> _querySuggestions = [
    'Grocery',
    'LED bulb',
    'Power charger',
    'Notebook',
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.9 : 1.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.green, // Corporate Green Banner
        borderRadius: AppCorners.roundedLg,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F059669),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Title
          Text(
            'Find anything nearby from local shops.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18 * scaleFactor,
              fontWeight: FontWeight.w800,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 14),

          // Primary White Commerce Search Bar Box
          GestureDetector(
            onTap: onSearchTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: AppColors.navy,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      context.tr('searchPlaceholder'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13 * scaleFactor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),

                  // Voice Search Action (🎙)
                  Tooltip(
                    message: 'Voice Search',
                    child: InkWell(
                      onTap: onVoiceSearchTap,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        child: const Icon(
                          Icons.mic_none_outlined,
                          color: AppColors.navy,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),

                  // Search by Image Action (📷)
                  Tooltip(
                    message: 'Search by Image',
                    child: InkWell(
                      onTap: onImageSearchTap,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.green,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Quick Commerce Search Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _querySuggestions.map(
                (query) => Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: InkWell(
                    onTap: () => onSuggestionTap?.call(query),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.35),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        query,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11 * scaleFactor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
