import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';

/// SCREEN 20 — PICKUP CONFIRMATION SCREEN (NOT PAYMENT CHECKOUT)
class PickupCheckoutScreen extends StatefulWidget {
  const PickupCheckoutScreen({super.key});

  @override
  State<PickupCheckoutScreen> createState() => _PickupCheckoutScreenState();
}

class _PickupCheckoutScreenState extends State<PickupCheckoutScreen> {
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Confirm Pickup Reservation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
              // Selected Shop Info
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppCorners.roundedMd,
                  border: Border.all(color: AppColors.green, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.storefront, color: AppColors.green, size: 22),
                        SizedBox(width: 8),
                        Text('PICKUP SHOP DETAILS', style: TextStyle(color: AppColors.greenDark, fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('Super Fresh Supermarket & Groceries', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.navy)),
                    SizedBox(height: 4),
                    Text('No. 42, 2nd Avenue, Anna Nagar East, Chennai - 600102', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    SizedBox(height: 4),
                    Text('Open Hours: 8:00 AM - 10:00 PM', style: TextStyle(color: AppColors.navy, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Customer Contact Summary
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppCorners.roundedMd,
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('CUSTOMER CONTACT', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 11)),
                    SizedBox(height: 6),
                    Text('+91 98765 43210', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 14)),
                    SizedBox(height: 2),
                    Text('SMS confirmation will be sent to this number.', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Reservation Summary
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppCorners.roundedMd,
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('RESERVATION SUMMARY', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 11)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Sona Masoori Rice 5kg (x1)', style: TextStyle(color: AppColors.navy, fontSize: 13)),
                        Text('₹295', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('12W Cool Day LED Bulb (x2)', style: TextStyle(color: AppColors.navy, fontSize: 13)),
                        Text('₹178', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 13)),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Total Amount Payable at Shop', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 14)),
                        Text('₹473', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.green, fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Notice
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSubtle,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline, color: AppColors.green, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'The shop will accept & reserve stock. Collect and pay directly at the store.',
                        style: TextStyle(color: AppColors.navy, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: ElevatedButton(
          onPressed: _isSubmitting ? null : () async {
            setState(() => _isSubmitting = true);
            // Simulate network delay for smooth UX
            await Future.delayed(const Duration(milliseconds: 1200));
            if (mounted) {
              setState(() => _isSubmitting = false);
              Navigator.pushReplacementNamed(context, '/order-success');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.green,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColors.green.withValues(alpha: 0.6),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: AppCorners.roundedMd),
          ),
          child: _isSubmitting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Text('Confirm & Place Pickup Order', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
