import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';

/// SCREEN 31 — HELP & SUPPORT SCREEN
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Help & Support', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('FREQUENTLY ASKED QUESTIONS', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
              const SizedBox(height: 10),

              _buildFaqTile(
                'How does QUCZO pickup work?',
                'Search for products nearby, compare prices across local shops, reserve your items, and visit the physical store to collect and pay.',
              ),
              _buildFaqTile(
                'Do I need to pay online?',
                'No. Payment is made directly at the physical shop upon collecting your reserved items.',
              ),
              _buildFaqTile(
                'Does QUCZO deliver to home?',
                'QUCZO is a pickup and local reservation platform enabling customers to collect products directly from local stores.',
              ),
              _buildFaqTile(
                'How long is my stock reserved?',
                'Shops hold reserved stock for up to 24 hours. Check pickup shop hours in order details.',
              ),

              const SizedBox(height: 24),
              const Text('CONTACT US', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppCorners.roundedMd,
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.support_agent, color: AppColors.green),
                      title: const Text('Customer Support Chat', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                      subtitle: const Text('Available 9 AM - 9 PM daily'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.email_outlined, color: AppColors.navy),
                      title: const Text('Email Support', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                      subtitle: const Text('support@quczo.com'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqTile(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppCorners.roundedMd,
        border: Border.all(color: AppColors.border),
      ),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.navy)),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: Text(answer, style: const TextStyle(color: AppColors.textSecondary, height: 1.4, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
