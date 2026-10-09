import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../core/utils/responsive.dart';

/// Visually Rich QUCZO Flow Discovery Banner in Green & Photographic Theme
class DiscoveryBanner extends StatelessWidget {
  final VoidCallback? onExploreTap;

  const DiscoveryBanner({
    super.key,
    this.onExploreTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.9 : 1.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0xFFECFDF5), // Light Green Theme
          borderRadius: AppCorners.roundedLg,
          border: Border.all(
            color: const Color(0xFFA7F3D0),
            width: 1.2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A059669),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Right Side Photographic Local Store Image Overlay
            Positioned(
              right: -15,
              bottom: -15,
              top: -15,
              child: Opacity(
                opacity: 0.22,
                child: Image.network(
                  'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=400&q=80',
                  width: 160 * scaleFactor,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                ),
              ),
            ),

            // Banner Content Column
            Padding(
              padding: EdgeInsets.all(16.0 * scaleFactor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 4-Step Local Pickup Journey Pills
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildJourneyStep('🔍 Search', scaleFactor),
                        _buildArrow(),
                        _buildJourneyStep('📍 Nearby', scaleFactor),
                        _buildArrow(),
                        _buildJourneyStep('₹ Compare', scaleFactor),
                        _buildArrow(),
                        _buildJourneyStep('✓ Reserve', scaleFactor),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    context.tr('bannerTitle'),
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 16.5 * scaleFactor,
                      fontWeight: FontWeight.w800,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'AI-powered search across local shops.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12 * scaleFactor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton.icon(
                    onPressed: onExploreTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0 * scaleFactor,
                        vertical: 10.0 * scaleFactor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(
                      Icons.near_me_outlined,
                      size: 16,
                    ),
                    label: Text(
                      context.tr('exploreNearbyCTA'),
                      style: TextStyle(
                        fontSize: 13 * scaleFactor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJourneyStep(String text, double scaleFactor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFA7F3D0), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.greenDark,
          fontSize: 10.5 * scaleFactor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildArrow() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Icon(
        Icons.chevron_right,
        color: AppColors.green,
        size: 14,
      ),
    );
  }
}
