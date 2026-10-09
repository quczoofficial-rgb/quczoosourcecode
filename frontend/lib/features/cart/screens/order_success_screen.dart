import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../navigation/app_routes.dart';

/// SCREEN 21 — ORDER SUCCESS & RESERVATION CONFIRMATION SCREEN
class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

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
                const Spacer(),
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    color: AppColors.greenSubtle,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: AppColors.green,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Pickup Reservation Placed!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Order #QCZ-98241',
                  style: TextStyle(
                    color: AppColors.greenDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your request has been sent to Super Fresh Supermarket. The shop is reserving your items for pickup.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 28),

                // Pickup Summary Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppCorners.roundedMd,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: const [
                      Row(
                        children: [
                          Icon(Icons.storefront, color: AppColors.green, size: 20),
                          SizedBox(width: 8),
                          Text('Super Fresh Supermarket', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text('No. 42, 2nd Avenue, Anna Nagar East, Chennai', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Status', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                          Text('Shop Received', style: TextStyle(color: AppColors.greenDark, fontWeight: FontWeight.bold, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),

                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/pickup-status');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: AppCorners.roundedMd),
                  ),
                  child: const Text('Track Pickup Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.customerHome);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.navy,
                    side: const BorderSide(color: AppColors.border),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: AppCorners.roundedMd),
                  ),
                  child: const Text('Back to Home', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
