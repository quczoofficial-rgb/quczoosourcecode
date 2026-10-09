import 'package:flutter/material.dart';

/// QUCZO Design System - Shadow Tokens
/// Modern, soft, corporate shadows (no harsh black drop shadows)
abstract class AppShadows {
  static const List<BoxShadow> subtle = [
    BoxShadow(
      color: Color(0x080F172A),
      blurRadius: 8.0,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0C0F172A),
      blurRadius: 16.0,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> elevated = [
    BoxShadow(
      color: Color(0x140F172A),
      blurRadius: 24.0,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> greenGlow = [
    BoxShadow(
      color: Color(0x33059669),
      blurRadius: 16.0,
      offset: Offset(0, 4),
    ),
  ];
}
