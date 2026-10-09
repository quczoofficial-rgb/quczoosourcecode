import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../widgets/admin_sidebar.dart';

/// ADMIN 02 — ADMIN DASHBOARD SCREEN
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isWide
          ? null
          : AppBar(
              title: const Text('QUCZO Admin Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
              backgroundColor: AppColors.navy,
              foregroundColor: Colors.white,
            ),
      drawer: isWide ? null : const Drawer(child: AdminSidebar(activeRoute: '/admin-dashboard')),
      body: SafeArea(
        child: Row(
          children: [
            if (isWide) const AdminSidebar(activeRoute: '/admin-dashboard'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Platform Executive Dashboard', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.navy)),
                            Text('Real-time hyperlocal operations summary across Chennai & Bengaluru', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white),
                          icon: const Icon(Icons.download, size: 16),
                          label: const Text('Export Platform Report'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // KPI Cards Grid
                    LayoutBuilder(builder: (ctx, constraints) {
                      final count = constraints.maxWidth >= 900 ? 4 : (constraints.maxWidth >= 500 ? 2 : 1);
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: count,
                        childAspectRatio: 1.8,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        children: [
                          _buildKpi('Total Registered Customers', '48,290', '+12.5% this month', Icons.people, AppColors.navy),
                          _buildKpi('Verified Local Shops', '1,450', '54 pending review', Icons.storefront, AppColors.green),
                          _buildKpi('Listed Products Catalog', '3,48,200', '14 categories', Icons.inventory_2, const Color(0xFF2563EB)),
                          _buildKpi('Total Pickup Reservations', '1,24,800', '98.2% completion rate', Icons.receipt_long, const Color(0xFF7C3AED)),
                        ],
                      );
                    }),
                    const SizedBox(height: 28),

                    // Recent Registrations & Verification Alert Table
                    const Text('RECENT SHOP VERIFICATION REQUESTS', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
                    const SizedBox(height: 10),

                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppCorners.roundedMd,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: [
                          _buildShopRow(context, 'Sri Balaji Hardware & Pipes', 'Hardware & Plumbing', 'Anna Nagar, Chennai', 'Pending Verification'),
                          const Divider(height: 1),
                          _buildShopRow(context, 'Anna Nagar Fresh Mart', 'Supermarket & Produce', 'Anna Nagar, Chennai', 'Approved'),
                          const Divider(height: 1),
                          _buildShopRow(context, 'Metro Mobiles & Electronics', 'Electronics', 'T. Nagar, Chennai', 'Pending Verification'),
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

  Widget _buildKpi(String title, String val, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppCorners.roundedMd,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(val, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: color)),
              Icon(icon, color: color, size: 22),
            ],
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.navy)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildShopRow(BuildContext context, String name, String cat, String loc, String status) {
    final bool isPending = status.contains('Pending');
    return ListTile(
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 14)),
      subtitle: Text('$cat • $loc', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isPending ? const Color(0xFFFEF7E0) : AppColors.greenSubtle,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(status, style: TextStyle(color: isPending ? const Color(0xFFB45309) : AppColors.greenDark, fontWeight: FontWeight.bold, fontSize: 11)),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textMuted),
            onPressed: () => Navigator.pushNamed(context, '/admin-shop-verification'),
          ),
        ],
      ),
    );
  }
}
