import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../widgets/admin_sidebar.dart';

/// ADMIN 03 — CUSTOMER MANAGEMENT SCREEN
class AdminCustomersScreen extends StatelessWidget {
  const AdminCustomersScreen({super.key});

  static const List<Map<String, dynamic>> _customers = [
    {'name': 'Ramesh Kumar', 'mobile': '+91 98765 43210', 'location': 'Anna Nagar, Chennai', 'reservations': 18, 'status': 'Active'},
    {'name': 'Priya Sundaram', 'mobile': '+91 98765 12345', 'location': 'T. Nagar, Chennai', 'reservations': 12, 'status': 'Active'},
    {'name': 'Anand Verma', 'mobile': '+91 98765 99999', 'location': 'Koramangala, Bengaluru', 'reservations': 24, 'status': 'Active'},
  ];

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isWide ? null : AppBar(title: const Text('Customer Management'), backgroundColor: AppColors.navy, foregroundColor: Colors.white),
      drawer: isWide ? null : const Drawer(child: AdminSidebar(activeRoute: '/admin-customers')),
      body: SafeArea(
        child: Row(
          children: [
            if (isWide) const AdminSidebar(activeRoute: '/admin-customers'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Platform Customer Directory', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy)),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppCorners.roundedMd, border: Border.all(color: AppColors.border)),
                        child: ListView.separated(
                          itemCount: _customers.length,
                          separatorBuilder: (c, i) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final cust = _customers[index];
                            return ListTile(
                              leading: const CircleAvatar(backgroundColor: AppColors.greenSubtle, child: Icon(Icons.person, color: AppColors.green)),
                              title: Text(cust['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                              subtitle: Text('${cust['mobile']} • ${cust['location']} • ${cust['reservations']} reservations'),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: AppColors.greenSubtle, borderRadius: BorderRadius.circular(4)),
                                child: Text(cust['status'] as String, style: const TextStyle(color: AppColors.greenDark, fontWeight: FontWeight.bold, fontSize: 11)),
                              ),
                            );
                          },
                        ),
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
