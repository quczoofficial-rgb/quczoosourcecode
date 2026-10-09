import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

/// Top Header for Customer Home Screen
class HomeHeader extends StatelessWidget {
  final String locationText;
  final bool isLocating;
  final VoidCallback? onLocationTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const HomeHeader({
    super.key,
    required this.locationText,
    this.isLocating = false,
    this.onLocationTap,
    this.onNotificationTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.9 : 1.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderLight,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: QUCZO Emblem Wordmark & Search Area Location Selector
          Expanded(
            child: Row(
              children: [
                // QUCZO Small Brand Emblem with Brand Green
                Container(
                  width: 34 * scaleFactor,
                  height: 34 * scaleFactor,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Q',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Location Search Area Column
                Expanded(
                  child: InkWell(
                    onTap: onLocationTap,
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                context.tr('searchingNear'),
                                style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 11 * scaleFactor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 3),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                size: 14,
                                color: AppColors.textMuted,
                              ),
                            ],
                          ),
                          const SizedBox(height: 1),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: AppColors.green,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Row(
                                  children: [
                                    if (isLocating) ...[
                                      const SizedBox(
                                        width: 12,
                                        height: 12,
                                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.green),
                                      ),
                                      const SizedBox(width: 6),
                                    ],
                                    Flexible(
                                      child: AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 300),
                                        child: Text(
                                          locationText,
                                          key: ValueKey<String>(locationText),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppColors.navy,
                                            fontSize: 13.5 * scaleFactor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Right Shortcuts: Notification & Profile
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onNotificationTap,
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: AppColors.navy,
                  size: 22,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                tooltip: 'Notifications',
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: onProfileTap,
                icon: const Icon(
                  Icons.person_outline,
                  color: AppColors.navy,
                  size: 22,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                tooltip: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
