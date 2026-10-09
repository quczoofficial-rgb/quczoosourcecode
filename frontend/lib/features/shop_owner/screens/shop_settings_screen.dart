import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../navigation/app_routes.dart';

/// SCREEN 49 — SHOP OWNER SETTINGS SCREEN
class ShopSettingsScreen extends StatelessWidget {
  const ShopSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Business Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSettingTile(context, Icons.storefront_outlined, 'Shop Profile & Hours', 'Edit address, phone, operating hours', () => Navigator.pushNamed(context, '/shop-setup')),
              _buildSettingTile(context, Icons.card_membership_outlined, 'Subscription & Billing', '₹99/month Business Pro plan', () => Navigator.pushNamed(context, '/subscription')),
              _buildSettingTile(context, Icons.people_outline, 'Customer History', 'View regular store customers', () => Navigator.pushNamed(context, '/customers')),
              _buildSettingTile(context, Icons.file_upload_outlined, 'Bulk CSV Inventory Upload', 'Import product spreadsheets', () => Navigator.pushNamed(context, '/bulk-upload')),
              const SizedBox(height: 24),

              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.welcomeLanguage, (route) => false);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFDC2626),
                  side: const BorderSide(color: Color(0xFFFCA5A5)),
                  minimumSize: const Size(double.infinity, 46),
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Log Out of Shop Account', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile(BuildContext context, IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppCorners.roundedMd,
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.green),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
        onTap: onTap,
      ),
    );
  }
}
