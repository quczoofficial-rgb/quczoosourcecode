import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../repositories/cart_repository.dart';

/// 5-Item Bottom Navigation Bar for QUCZO Customer Experience
class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    this.currentIndex = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.85 : 1.0;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.borderLight,
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                index: 0,
                icon: Icons.home_filled,
                unselectedIcon: Icons.home_outlined,
                labelKey: 'navHome',
                scaleFactor: scaleFactor,
              ),
              _buildNavItem(
                context,
                index: 1,
                icon: Icons.search,
                unselectedIcon: Icons.search_outlined,
                labelKey: 'navSearch',
                scaleFactor: scaleFactor,
              ),
              _buildNavItem(
                context,
                index: 2,
                icon: Icons.shopping_bag,
                unselectedIcon: Icons.shopping_bag_outlined,
                labelKey: 'navCart',
                scaleFactor: scaleFactor,
              ),
              _buildNavItem(
                context,
                index: 3,
                icon: Icons.receipt_long,
                unselectedIcon: Icons.receipt_long_outlined,
                labelKey: 'navOrders',
                scaleFactor: scaleFactor,
              ),
              _buildNavItem(
                context,
                index: 4,
                icon: Icons.person,
                unselectedIcon: Icons.person_outline,
                labelKey: 'navProfile',
                scaleFactor: scaleFactor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required IconData unselectedIcon,
    required String labelKey,
    required double scaleFactor,
  }) {
    final bool isSelected = index == currentIndex;
    final Color color = isSelected ? AppColors.green : AppColors.textMuted;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    isSelected ? icon : unselectedIcon,
                    color: color,
                    size: 22 * scaleFactor,
                  ),
                  if (index == 2)
                    Positioned(
                      top: -4,
                      right: -8,
                      child: ListenableBuilder(
                        listenable: CartRepository(),
                        builder: (context, _) {
                          final count = CartRepository().itemCount;
                          if (count == 0) return const SizedBox.shrink();
                          return Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$count',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  context.tr(labelKey),
                  style: TextStyle(
                    color: color,
                    fontSize: 10.5 * scaleFactor,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
