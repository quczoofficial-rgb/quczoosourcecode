import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../home/widgets/custom_bottom_nav.dart';
import '../../../navigation/app_routes.dart';

/// SCREEN 26 — CUSTOMER PROFILE SCREEN
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // User Card Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppCorners.roundedMd,
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: AppColors.greenSubtle,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'K',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.green),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Customer User', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.navy)),
                          SizedBox(height: 2),
                          Text('+91 98765 43210', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: AppColors.green),
                      onPressed: () {
                        Navigator.pushNamed(context, '/edit-profile');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Menu List
              _buildMenuItem(
                context,
                icon: Icons.location_on_outlined,
                title: 'Saved Search Areas',
                subtitle: 'Anna Nagar, T. Nagar, Velachery',
                onTap: () => Navigator.pushNamed(context, '/saved-locations'),
              ),
              _buildMenuItem(
                context,
                icon: Icons.storefront_outlined,
                title: 'Saved Shops',
                subtitle: 'Super Fresh, Lakshmi Electricals',
                onTap: () => Navigator.pushNamed(context, '/saved-shops'),
              ),
              _buildMenuItem(
                context,
                icon: Icons.notifications_none_outlined,
                title: 'Notifications',
                subtitle: 'Order updates and local offers',
                onTap: () => Navigator.pushNamed(context, '/notifications'),
              ),
              _buildMenuItem(
                context,
                icon: Icons.settings_outlined,
                title: 'Settings & Language',
                subtitle: 'App preferences and 5-language system',
                onTap: () => Navigator.pushNamed(context, '/settings'),
              ),
              _buildMenuItem(
                context,
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'FAQs, contact support, report issue',
                onTap: () => Navigator.pushNamed(context, '/help-support'),
              ),

              const SizedBox(height: 20),
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
                label: const Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 4, // Profile tab selected
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, AppRoutes.customerHome);
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, AppRoutes.search);
          } else if (index == 2) {
            Navigator.pushNamed(context, AppRoutes.cart);
          } else if (index == 3) {
            Navigator.pushNamed(context, AppRoutes.orders);
          }
        },
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppCorners.roundedMd,
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.navy),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
        onTap: onTap,
      ),
    );
  }
}
