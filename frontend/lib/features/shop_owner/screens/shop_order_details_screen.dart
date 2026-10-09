import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';

/// SCREEN 45 — SHOP OWNER ORDER DETAILS & ACTION SCREEN
class ShopOrderDetailsScreen extends StatefulWidget {
  final String? orderId;

  const ShopOrderDetailsScreen({super.key, this.orderId});

  @override
  State<ShopOrderDetailsScreen> createState() => _ShopOrderDetailsScreenState();
}

class _ShopOrderDetailsScreenState extends State<ShopOrderDetailsScreen> {
  String _currentStatus = 'Pending Accept';

  @override
  Widget build(BuildContext context) {
    final String currentId = widget.orderId ?? 'QCZ-98241';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Reservation Details #$currentId', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
              // Order Header Box
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('CURRENT STATUS', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: AppColors.greenSubtle, borderRadius: BorderRadius.circular(4)),
                          child: Text(_currentStatus, style: const TextStyle(color: AppColors.greenDark, fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Customer Contact: +91 98765 43210', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 14)),
                    const SizedBox(height: 2),
                    const Text('Customer will physically visit shop for collection & payment.', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              const Text('RESERVED ITEMS', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppCorners.roundedMd,
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: const [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sona Masoori Rice 5kg (x1)', style: TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold)),
                        Text('₹295', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('12W Cool Day LED Bulb (x2)', style: TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold)),
                        Text('₹178', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                      ],
                    ),
                    Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Customer Payment Due', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                        Text('₹473', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.green, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text('UPDATE RESERVATION STATUS', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
              const SizedBox(height: 10),

              _buildStatusButton('1. Accept Reservation', 'Shop Accepted', AppColors.navy),
              const SizedBox(height: 8),
              _buildStatusButton('2. Mark Stock Reserved', 'Stock Reserved', const Color(0xFF2563EB)),
              const SizedBox(height: 8),
              _buildStatusButton('3. Mark Ready for Pickup', 'Ready for Pickup', AppColors.green),
              const SizedBox(height: 8),
              _buildStatusButton('4. Mark Collected & Complete', 'Completed', AppColors.greenDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusButton(String label, String statusValue, Color color) {
    final bool isSelected = _currentStatus == statusValue;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _currentStatus = statusValue;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order status updated to: $statusValue')));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? color : AppColors.surface,
        foregroundColor: isSelected ? Colors.white : AppColors.navy,
        side: BorderSide(color: color),
        minimumSize: const Size(double.infinity, 46),
        elevation: isSelected ? 2 : 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (isSelected) const Icon(Icons.check_circle, size: 18),
        ],
      ),
    );
  }
}
