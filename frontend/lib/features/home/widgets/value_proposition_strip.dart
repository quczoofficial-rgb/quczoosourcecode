import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

/// Compact Colorful Visual Strip showing QUCZO Core Value Propositions
class ValuePropositionStrip extends StatelessWidget {
  const ValuePropositionStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.88 : 1.0;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          SizedBox(
            width: 84 * scaleFactor,
            child: _buildPropItem(
              icon: Icons.storefront_outlined,
              label: 'Nearby Shops',
              bgColor: AppColors.mintSubtle,
              iconColor: AppColors.green,
              scaleFactor: scaleFactor,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 84 * scaleFactor,
            child: _buildPropItem(
              icon: Icons.sell_outlined,
              label: 'Better Prices',
              bgColor: AppColors.yellowSubtle,
              iconColor: const Color(0xFFD97706),
              scaleFactor: scaleFactor,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 84 * scaleFactor,
            child: _buildPropItem(
              icon: Icons.compare_arrows_outlined,
              label: 'Easy Comparison',
              bgColor: AppColors.blueSubtle,
              iconColor: const Color(0xFF2563EB),
              scaleFactor: scaleFactor,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 84 * scaleFactor,
            child: _buildPropItem(
              icon: Icons.shopping_bag_outlined,
              label: 'Reserve Pickup',
              bgColor: AppColors.lavenderSubtle,
              iconColor: const Color(0xFF7C3AED),
              scaleFactor: scaleFactor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropItem({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color iconColor,
    required double scaleFactor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: iconColor.withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18 * scaleFactor, color: iconColor),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 10 * scaleFactor,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
