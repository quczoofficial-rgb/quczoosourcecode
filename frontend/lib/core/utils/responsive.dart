import 'package:flutter/material.dart';

/// Responsive Layout Utility for QUCZO Mobile Viewports
class Responsive {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;

  static bool isCompact(BuildContext context) => width(context) <= 360;
  static bool isStandardMobile(BuildContext context) => width(context) > 360 && width(context) <= 414;
  static bool isLargeMobile(BuildContext context) => width(context) > 414;

  static double responsiveFont(BuildContext context, double baseFontSize) {
    final w = width(context);
    if (w <= 360) return baseFontSize * 0.92;
    if (w >= 414) return baseFontSize * 1.05;
    return baseFontSize;
  }
}
