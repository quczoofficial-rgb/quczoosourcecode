import 'package:flutter/material.dart';

/// QUCZO Design System - Core Color Palette
/// 
/// Strictly adheres to the QUCZO corporate visual identity:
/// Primary Navy: #0F172A
/// Professional Green: #059669
/// Background: #F8FAFC
abstract class AppColors {
  // Brand Primary Palette
  static const Color navy = Color(0xFF0F172A);
  static const Color navyLight = Color(0xFF1E293B);
  static const Color navyDark = Color(0xFF090D16);

  // Brand Accent & Interactive (Professional Green)
  static const Color green = Color(0xFF059669);
  static const Color greenLight = Color(0xFF10B981);
  static const Color greenDark = Color(0xFF047857);
  static const Color greenSubtle = Color(0xFFECFDF5);
  static const Color greenBorder = Color(0xFFA7F3D0);

  // Neutral Background & Surfaces
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSubtle = Color(0xFFF1F5F9);

  // Text & Typography Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textOnNavy = Color(0xFFFFFFFF);
  static const Color textOnGreen = Color(0xFFFFFFFF);

  // Structural & Borders
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color borderFocused = Color(0xFF059669);

  // Status & System Colors
  static const Color success = Color(0xFF059669);
  static const Color warning = Color(0xFFD97706);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF0284C7);

  // Soft Pastel Category & Consumer Accents
  static const Color mintSubtle = Color(0xFFE6F4EA);
  static const Color blueSubtle = Color(0xFFE8F0FE);
  static const Color yellowSubtle = Color(0xFFFEF7E0);
  static const Color orangeSubtle = Color(0xFFFFE8D6);
  static const Color lavenderSubtle = Color(0xFFF3E8FF);
  static const Color cyanSubtle = Color(0xFFE0F7FA);
  static const Color peachSubtle = Color(0xFFFFE5EC);
  static const Color slateSubtle = Color(0xFFF1F5F9);

  // Overlay & Gradients
  static const Color shadowColor = Color(0x0F0F172A);
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      navy,
      navyLight,
    ],
  );
  
  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      green,
      greenLight,
    ],
  );
}
