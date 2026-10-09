import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';

/// SCREEN 47 — SHOP BUSINESS ANALYTICS SCREEN
class ShopAnalyticsScreen extends StatelessWidget {
  const ShopAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Store Performance Analytics', style: TextStyle(fontWeight: FontWeight.bold)),
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
              // Monthly Revenue Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.navy,
                  borderRadius: AppCorners.roundedMd,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('ESTIMATED MONTHLY SHOP RESERVATIONS', style: TextStyle(color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text('₹1,48,250', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800)),
                    SizedBox(height: 4),
                    Text('+18.4% from last month in Anna Nagar area', style: TextStyle(color: AppColors.greenLight, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Text('TOP DEMANDED PRODUCTS', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
              const SizedBox(height: 10),

              _buildAnalyticsRow('1. Sona Masoori Rice 5kg', '142 reservations', '₹41,890', 0.85),
              _buildAnalyticsRow('2. Surf Excel Easy Wash 2kg', '98 reservations', '₹23,520', 0.65),
              _buildAnalyticsRow('3. 12W Cool Day LED Bulb', '86 reservations', '₹7,654', 0.55),
              _buildAnalyticsRow('4. Aavin Full Cream Milk', '210 reservations', '₹5,880', 0.92),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsRow(String title, String subtitle, String total, double percent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
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
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 13)),
              Text(total, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.green, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percent,
            color: AppColors.green,
            backgroundColor: AppColors.surfaceSubtle,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}
