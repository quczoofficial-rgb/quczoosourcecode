import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// Professional Corporate QUCZO Brand Logo
class QuczoBrandLogo extends StatelessWidget {
  final double size;
  final bool showWordmark;

  const QuczoBrandLogo({
    super.key,
    this.size = 40.0,
    this.showWordmark = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Clean Corporate Logo Icon Mark
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(size * 0.22),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                'Q',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size * 0.65,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'sans-serif',
                  height: 1.1,
                ),
              ),
              Positioned(
                bottom: size * 0.18,
                right: size * 0.18,
                child: Container(
                  width: size * 0.18,
                  height: size * 0.18,
                  decoration: const BoxDecoration(
                    color: AppColors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),

        if (showWordmark) ...[
          SizedBox(width: size * 0.25),
          // Brand Wordmark
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'QUC',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: size * 0.65,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                    fontFamily: 'sans-serif',
                  ),
                ),
                TextSpan(
                  text: 'ZO',
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: size * 0.65,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                    fontFamily: 'sans-serif',
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

