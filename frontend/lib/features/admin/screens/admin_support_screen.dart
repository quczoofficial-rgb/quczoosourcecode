import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../widgets/admin_sidebar.dart';

/// ADMIN 12 — PLATFORM SUPPORT & ISSUES SCREEN
class AdminSupportScreen extends StatelessWidget {
  const AdminSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isWide ? null : AppBar(title: const Text('Support & Tickets'), backgroundColor: AppColors.navy, foregroundColor: Colors.white),
      drawer: isWide ? null : const Drawer(child: AdminSidebar(activeRoute: '/admin-support')),
      body: SafeArea(
        child: Row(
          children: [
            if (isWide) const AdminSidebar(activeRoute: '/admin-support'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Customer & Shop Support Tickets', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy)),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppCorners.roundedMd, border: Border.all(color: AppColors.border)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Ticket #TCK-1092 • Open', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                          SizedBox(height: 4),
                          Text('From: Lakshmi Electricals (Shop Owner)', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                          SizedBox(height: 4),
                          Text('Subject: Request assistance updating shop operating hours for festival weekend.', style: TextStyle(color: AppColors.navy)),
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
