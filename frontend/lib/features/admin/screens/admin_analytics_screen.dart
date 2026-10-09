import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../widgets/admin_sidebar.dart';

/// ADMIN 09 — PLATFORM ANALYTICS SCREEN
class AdminAnalyticsScreen extends StatelessWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isWide ? null : AppBar(title: const Text('Platform Analytics'), backgroundColor: AppColors.navy, foregroundColor: Colors.white),
      drawer: isWide ? null : const Drawer(child: AdminSidebar(activeRoute: '/admin-analytics')),
      body: SafeArea(
        child: Row(
          children: [
            if (isWide) const AdminSidebar(activeRoute: '/admin-analytics'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Platform-Wide Analytics & Metrics', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy)),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppCorners.roundedMd, border: Border.all(color: AppColors.border)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('TOP SEARCH INTENTS (AI SEARCH DEMAND)', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
                          SizedBox(height: 12),
                          Text('1. Rice 5kg (14,200 searches/mo)', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                          SizedBox(height: 6),
                          Text('2. LED Bulb 9W / 12W (9,800 searches/mo)', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                          SizedBox(height: 6),
                          Text('3. Surf Excel 2kg (8,400 searches/mo)', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                          SizedBox(height: 6),
                          Text('4. Power Drill / Hardware (6,100 searches/mo)', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
