import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';

/// SCREEN 32 — SHOP OWNER LOGIN SCREEN
class ShopOwnerLoginScreen extends StatefulWidget {
  const ShopOwnerLoginScreen({super.key});

  @override
  State<ShopOwnerLoginScreen> createState() => _ShopOwnerLoginScreenState();
}

class _ShopOwnerLoginScreenState extends State<ShopOwnerLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(6)),
                child: const Text('QUCZO BUSINESS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
              ),
              const SizedBox(height: 16),
              Text(
                'Shop Owner Login',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Manage your local shop, catalog, inventory, and customer reservations.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 32),

              const Text('Registered Business Mobile', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixText: '+91 ',
                  hintText: 'Enter 10-digit mobile',
                  border: OutlineInputBorder(borderRadius: AppCorners.roundedMd),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/shop-owner-otp');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: AppCorners.roundedMd),
                ),
                child: const Text('Send Business OTP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have a shop account? ", style: TextStyle(color: AppColors.textSecondary)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/shop-owner-registration');
                    },
                    child: const Text('Register Shop', style: TextStyle(color: AppColors.green, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
