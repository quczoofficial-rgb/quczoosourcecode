import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';

/// SCREEN 23 — PICKUP STATUS & TIMELINE SCREEN
class PickupStatusScreen extends StatelessWidget {
  final String? orderId;

  const PickupStatusScreen({super.key, this.orderId});

  static const List<Map<String, dynamic>> _timelineSteps = [
    {'title': 'Order Placed', 'subtitle': '10:30 AM', 'isDone': true},
    {'title': 'Shop Received', 'subtitle': '10:31 AM', 'isDone': true},
    {'title': 'Shop Accepted', 'subtitle': '10:33 AM', 'isDone': true},
    {'title': 'Stock Reserved', 'subtitle': '10:35 AM', 'isDone': true},
    {'title': 'Ready for Pickup', 'subtitle': 'Available now at store', 'isDone': true, 'isCurrent': true},
    {'title': 'Customer Collects', 'subtitle': 'Pending physical pickup', 'isDone': false},
    {'title': 'Completed', 'subtitle': 'Order complete', 'isDone': false},
  ];

  @override
  Widget build(BuildContext context) {
    final String currentId = orderId ?? 'QCZ-98241';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Pickup Status #$currentId', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Store Header
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppCorners.roundedMd,
                  border: Border.all(color: AppColors.green, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.storefront, color: AppColors.green, size: 24),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text('Super Fresh Supermarket', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.navy)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text('No. 42, 2nd Avenue, Anna Nagar East, Chennai', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 42),
                      ),
                      icon: const Icon(Icons.directions),
                      label: const Text('Get Directions to Shop', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Text('PICKUP LIFECYCLE', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
              const SizedBox(height: 12),

              // Timeline List
              Column(
                children: List.generate(_timelineSteps.length, (index) {
                  final step = _timelineSteps[index];
                  final bool isDone = step['isDone'] as bool;
                  final bool isCurrent = step['isCurrent'] ?? false;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isDone ? AppColors.green : AppColors.surfaceSubtle,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDone ? AppColors.green : AppColors.border,
                              ),
                            ),
                            child: Icon(
                              isDone ? Icons.check : Icons.circle,
                              size: 12,
                              color: isDone ? Colors.white : AppColors.textMuted,
                            ),
                          ),
                          if (index < _timelineSteps.length - 1)
                            Container(
                              width: 2,
                              height: 36,
                              color: isDone ? AppColors.green : AppColors.border,
                            ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                step['title'] as String,
                                style: TextStyle(
                                  fontWeight: isCurrent || isDone ? FontWeight.bold : FontWeight.normal,
                                  color: isCurrent ? AppColors.greenDark : (isDone ? AppColors.navy : AppColors.textMuted),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                step['subtitle'] as String,
                                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 16),

              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/review');
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.navy),
                  foregroundColor: AppColors.navy,
                  minimumSize: const Size(double.infinity, 46),
                ),
                child: const Text('Write Shop Review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
