import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

/// Quick Search Chips Horizontal Scroll for Customer Home Screen
class QuickSearchChips extends StatelessWidget {
  final ValueChanged<String>? onChipTap;

  const QuickSearchChips({
    super.key,
    this.onChipTap,
  });

  static const List<Map<String, dynamic>> _suggestions = [
    {'label': 'Fresh Produce', 'bg': AppColors.mintSubtle, 'color': Color(0xFF059669)},
    {'label': 'Groceries', 'bg': AppColors.yellowSubtle, 'color': Color(0xFFD97706)},
    {'label': 'Snacks', 'bg': AppColors.orangeSubtle, 'color': Color(0xFFEA580C)},
    {'label': 'Household', 'bg': AppColors.cyanSubtle, 'color': Color(0xFF0891B2)},
    {'label': 'Electronics', 'bg': AppColors.blueSubtle, 'color': Color(0xFF2563EB)},
    {'label': 'Hardware', 'bg': AppColors.slateSubtle, 'color': Color(0xFF475569)},
    {'label': 'Plumbing', 'bg': AppColors.cyanSubtle, 'color': Color(0xFF0284C7)},
    {'label': 'Mobile', 'bg': AppColors.blueSubtle, 'color': Color(0xFF2563EB)},
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.9 : 1.0;

    return SizedBox(
      height: 34 * scaleFactor,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: _suggestions.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8.0),
        itemBuilder: (context, index) {
          final item = _suggestions[index];
          final String label = item['label'] as String;
          final Color bg = item['bg'] as Color;
          final Color color = item['color'] as Color;

          return ActionChip(
            onPressed: () => onChipTap?.call(label),
            elevation: 0,
            pressElevation: 1,
            backgroundColor: bg,
            side: BorderSide(color: color.withValues(alpha: 0.2), width: 1.0),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            label: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11.5 * scaleFactor,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
      ),
    );
  }
}
