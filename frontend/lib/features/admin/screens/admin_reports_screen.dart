import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../widgets/admin_sidebar.dart';

/// ADMIN 10 — PLATFORM REPORTS SCREEN
class AdminReportsScreen extends StatelessWidget {
  const AdminReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isWide ? null : AppBar(title: const Text('Reports'), backgroundColor: AppColors.navy, foregroundColor: Colors.white),
      drawer: isWide ? null : const Drawer(child: AdminSidebar(activeRoute: '/admin-reports')),
      body: SafeArea(
        child: Row(
          children: [
            if (isWide) const AdminSidebar(activeRoute: '/admin-reports'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Generate Platform Reports', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy)),
                    const SizedBox(height: 16),
                    _buildReportTile('Monthly Reservation Summary', 'CSV / PDF Export', () {}),
                    _buildReportTile('Shop Verification & Compliance', 'PDF Export', () {}),
                    _buildReportTile('Local Search Inventory Coverage', 'Excel Export', () {}),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportTile(String title, String format, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppCorners.roundedMd, border: Border.all(color: AppColors.border)),
      child: ListTile(
        leading: const Icon(Icons.description_outlined, color: AppColors.green),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
        subtitle: Text(format),
        trailing: const Icon(Icons.download, color: AppColors.green),
        onTap: onTap,
      ),
    );
  }
}
