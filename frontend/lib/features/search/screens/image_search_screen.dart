import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../home/dialogs/image_search_dialog.dart';

/// SCREEN 11 — STANDALONE IMAGE SEARCH SCREEN
class ImageSearchScreen extends StatelessWidget {
  const ImageSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Search by Image', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: const Center(
        child: ImageSearchDialog(),
      ),
    );
  }
}
