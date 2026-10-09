import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Interactive Voice Search Modal Dialog for QUCZO
class VoiceSearchDialog extends StatefulWidget {
  final ValueChanged<String>? onQueryResult;

  const VoiceSearchDialog({super.key, this.onQueryResult});

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const VoiceSearchDialog(),
    );
  }

  @override
  State<VoiceSearchDialog> createState() => _VoiceSearchDialogState();
}

class _VoiceSearchDialogState extends State<VoiceSearchDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  String _listeningStateText = 'Listening... Say a product name';
  String _recognizedText = '';
  Timer? _simulatedSpeechTimer;

  static const List<String> _sampleVoiceCommands = [
    'Surf Excel 2kg nearby',
    '9W LED bulb price',
    'Bosch power drill in stock',
    'Sona Masoori Rice 5kg',
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Simulate listening feedback
    _simulatedSpeechTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _recognizedText.isEmpty) {
        setState(() {
          _listeningStateText = 'Tap a sample voice search or speak into mic';
        });
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _simulatedSpeechTimer?.cancel();
    super.dispose();
  }

  void _selectVoiceQuery(String query) {
    setState(() {
      _recognizedText = query;
      _listeningStateText = 'Searching for: "$query"';
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        Navigator.pop(context, query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Title & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.auto_awesome, color: AppColors.green, size: 18),
              SizedBox(width: 6),
              Text(
                'QUCZO Voice Search',
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            _listeningStateText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),

          // Pulsing Microphone Visualizer Button
          GestureDetector(
            onTap: () => _selectVoiceQuery('Surf Excel 2kg'),
            child: ScaleTransition(
              scale: _pulseAnimation,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.green.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.green, width: 2),
                ),
                child: Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: AppColors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Soundwave visualizer bar simulation
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(7, (index) {
              final heights = [12.0, 24.0, 18.0, 32.0, 20.0, 28.0, 14.0];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 4,
                height: heights[index],
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),

          // Sample Voice Commands List
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Sample Voice Suggestions:',
              style: TextStyle(
                color: AppColors.navy,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _sampleVoiceCommands.map((command) {
              return ActionChip(
                backgroundColor: AppColors.surfaceSubtle,
                side: const BorderSide(color: AppColors.borderLight),
                avatar: const Icon(Icons.mic, size: 14, color: AppColors.green),
                label: Text(
                  command,
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () => _selectVoiceQuery(command),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
