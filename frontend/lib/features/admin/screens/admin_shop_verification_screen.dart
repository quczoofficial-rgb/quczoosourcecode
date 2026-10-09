import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../widgets/admin_sidebar.dart';

/// ADMIN 08 — SHOP VERIFICATION & APPROVAL SCREEN
class AdminShopVerificationScreen extends StatelessWidget {
  const AdminShopVerificationScreen({super.key});

  static const List<Map<String, dynamic>> _pendingShops = [
    {
      'name': 'Sri Balaji Hardware & Pipes',
      'owner': 'Ketan Sharma (+91 98765 88888)',
      'address': 'No. 18, 3rd Main Road, Anna Nagar, Chennai',
      'gst': '33AAAAA0000A1Z5',
      'category': 'Hardware & Plumbing',
    },
    {
      'name': 'Metro Mobiles & Electronics',
      'owner': 'Venkatesh Rao (+91 98765 77777)',
      'address': 'No. 95, Usman Road, T. Nagar, Chennai',
      'gst': '33BBBBB1111B2Z6',
      'category': 'Electronics & Mobiles',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isWide ? null : AppBar(title: const Text('Shop Verification'), backgroundColor: AppColors.navy, foregroundColor: Colors.white),
      drawer: isWide ? null : const Drawer(child: AdminSidebar(activeRoute: '/admin-shop-verification')),
      body: SafeArea(
        child: Row(
          children: [
            if (isWide) const AdminSidebar(activeRoute: '/admin-shop-verification'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pending Shop Registration Requests', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy)),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.separated(
                        itemCount: _pendingShops.length,
                        separatorBuilder: (c, i) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final shop = _pendingShops[index];
                          return Container(
                            padding: const EdgeInsets.all(16),
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
                                    Text(shop['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.navy)),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(color: const Color(0xFFFEF7E0), borderRadius: BorderRadius.circular(4)),
                                      child: const Text('PENDING REVIEW', style: TextStyle(color: Color(0xFFB45309), fontWeight: FontWeight.bold, fontSize: 11)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text('Owner: ${shop['owner']}', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                                Text('Address: ${shop['address']}', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                                Text('GSTIN: ${shop['gst']} • Category: ${shop['category']}', style: const TextStyle(fontSize: 12, color: AppColors.greenDark, fontWeight: FontWeight.bold)),
                                const Divider(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Shop registration rejected.')));
                                      },
                                      style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFFDC2626)),
                                      child: const Text('Reject'),
                                    ),
                                    const SizedBox(width: 12),
                                    ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Shop verified & approved!')));
                                      },
                                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white),
                                      child: const Text('Approve & Verify Shop', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
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
