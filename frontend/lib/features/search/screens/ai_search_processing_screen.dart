import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../navigation/app_routes.dart';

/// SCREEN 09 — AI SEARCH PROCESSING SCREEN
class AiSearchProcessingScreen extends StatefulWidget {
  final String query;

  const AiSearchProcessingScreen({super.key, this.query = 'Surf Excel 2kg'});

  @override
  State<AiSearchProcessingScreen> createState() => _AiSearchProcessingScreenState();
}

class _AiSearchProcessingScreenState extends State<AiSearchProcessingScreen> {
  int _currentStepIndex = 0;

  static const List<String> _processingSteps = [
    'Understanding your request...',
    'Finding nearby local shops...',
    'Checking real-time product inventory...',
    'Comparing local prices & distance...',
  ];

  @override
  void initState() {
    super.initState();
    _startProcessingSimulation();
  }

  void _startProcessingSimulation() async {
    for (int i = 0; i < _processingSteps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 600));
      if (mounted) {
        setState(() {
          _currentStepIndex = i;
        });
      }
    }
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.searchResults,
        arguments: widget.query,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.greenSubtle,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.green, width: 2),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.green,
                      strokeWidth: 3.5,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'QUCZO Smart Search',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '"${widget.query}"',
                  style: const TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 36),

                // Step Progression List
                Column(
                  children: List.generate(_processingSteps.length, (index) {
                    final isDone = index < _currentStepIndex;
                    final isCurrent = index == _currentStepIndex;

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? AppColors.surface
                            : (isDone ? AppColors.greenSubtle : Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isCurrent
                              ? AppColors.green
                              : (isDone ? AppColors.green.withValues(alpha: 0.3) : AppColors.borderLight),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isDone
                                ? Icons.check_circle
                                : (isCurrent ? Icons.auto_awesome : Icons.circle_outlined),
                            color: isDone || isCurrent ? AppColors.green : AppColors.textMuted,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _processingSteps[index],
                              style: TextStyle(
                                color: isDone || isCurrent ? AppColors.navy : AppColors.textMuted,
                                fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                                fontSize: 13.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
