import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/common_branding.dart';

/// SEPARATE ADMIN WEB PORTAL SIDEBAR NAVIGATION
class AdminSidebar extends StatelessWidget {
  final String activeRoute;

  const AdminSidebar({super.key, required this.activeRoute});

  static const List<Map<String, dynamic>> _adminMenu = [
    {'title': 'Dashboard', 'icon': Icons.dashboard_outlined, 'route': '/admin-dashboard'},
    {'title': 'Customers', 'icon': Icons.people_outline, 'route': '/admin-customers'},
    {'title': 'Shops', 'icon': Icons.storefront_outlined, 'route': '/admin-shops'},
    {'title': 'Products', 'icon': Icons.inventory_2_outlined, 'route': '/admin-products'},
    {'title': 'Categories', 'icon': Icons.category_outlined, 'route': '/admin-categories'},
    {'title': 'Reservations', 'icon': Icons.receipt_long_outlined, 'route': '/admin-orders'},
    {'title': 'Shop Verification', 'icon': Icons.verified_outlined, 'route': '/admin-shop-verification'},
    {'title': 'Analytics', 'icon': Icons.analytics_outlined, 'route': '/admin-analytics'},
    {'title': 'Reports', 'icon': Icons.assessment_outlined, 'route': '/admin-reports'},
    {'title': 'Notifications', 'icon': Icons.notifications_none_outlined, 'route': '/admin-notifications'},
    {'title': 'Support', 'icon': Icons.support_agent_outlined, 'route': '/admin-support'},
    {'title': 'Settings', 'icon': Icons.settings_outlined, 'route': '/admin-settings'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: AppColors.navy,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                QuczoBrandLogo(size: 32, showWordmark: false),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('QUCZO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 0.5)),
                    Text('ADMIN PORTAL', style: TextStyle(color: AppColors.greenLight, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 0.8)),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white24, height: 1),

          // Menu List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: _adminMenu.length,
              itemBuilder: (context, index) {
                final item = _adminMenu[index];
                final String route = item['route'] as String;
                final bool isSelected = activeRoute == route;

                return InkWell(
                  onTap: () {
                    if (!isSelected) {
                      Navigator.pushReplacementNamed(context, route);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    color: isSelected ? AppColors.green.withValues(alpha: 0.2) : Colors.transparent,
                    child: Row(
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          color: isSelected ? AppColors.greenLight : Colors.white70,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          item['title'] as String,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white70,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            fontSize: 13.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
