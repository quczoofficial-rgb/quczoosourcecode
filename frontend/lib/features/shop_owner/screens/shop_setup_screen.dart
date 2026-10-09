import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';

/// SCREEN 35 — SHOP SETUP SCREEN
class ShopSetupScreen extends StatelessWidget {
  const ShopSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Shop Profile Setup', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Configure physical shop details, address, opening hours, and business categories.', style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 20),

              const Text('Shop Name', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
              const SizedBox(height: 6),
              const TextField(decoration: InputDecoration(hintText: 'Super Fresh Supermarket')),
              const SizedBox(height: 16),

              const Text('Physical Shop Address', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
              const SizedBox(height: 6),
              const TextField(decoration: InputDecoration(hintText: 'No. 42, 2nd Avenue, Anna Nagar East, Chennai')),
              const SizedBox(height: 16),

              const Text('Opening Hours', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
              const SizedBox(height: 6),
              const TextField(decoration: InputDecoration(hintText: '8:00 AM - 10:00 PM (Mon - Sun)')),
              const SizedBox(height: 28),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/shop-owner-dashboard');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: AppCorners.roundedMd),
                ),
                child: const Text('Save Shop Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
