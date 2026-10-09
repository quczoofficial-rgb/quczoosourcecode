import 'package:flutter/material.dart';

/// Generic Category Model for QUCZO Home Categories
class CategoryModel {
  final String id;
  final String titleKey;
  final String fallbackTitle;
  final String imageUrl;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const CategoryModel({
    required this.id,
    required this.titleKey,
    required this.fallbackTitle,
    required this.imageUrl,
    required this.icon,
    this.backgroundColor = const Color(0xFFF1F5F9),
    this.iconColor = const Color(0xFF0F172A),
  });
}
