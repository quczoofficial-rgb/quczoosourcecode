import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../home/dialogs/voice_search_dialog.dart';

/// SCREEN 10 — STANDALONE VOICE SEARCH SCREEN
class VoiceSearchScreen extends StatelessWidget {
  const VoiceSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Voice Search', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: const Center(
        child: VoiceSearchDialog(),
      ),
    );
  }
}
