import 'package:flutter/material.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/localization/app_language_storage.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../main.dart';

/// SCREEN 30 — SETTINGS & GLOBAL LANGUAGE SELECTION SCREEN
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
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
              const Text('APP LANGUAGE (GLOBAL)', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
              const SizedBox(height: 10),

              // 5-Language Selector Card
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppCorners.roundedMd,
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: AppLanguage.values.map((lang) {
                    final isSelected = Localizations.localeOf(context).languageCode == lang.code;
                    return Column(
                      children: [
                        ListTile(
                          title: Text('${lang.englishName} (${lang.nativeName})', style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, color: AppColors.navy)),
                          trailing: isSelected ? const Icon(Icons.check_circle, color: AppColors.green) : null,
                          onTap: () {
                            AppLanguageStorage.saveLanguageCode(lang.code);
                            QuczoApp.setLocale(context, lang.locale);
                            setState(() {});
                          },
                        ),
                        if (lang != AppLanguage.values.last) const Divider(height: 1),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),

              const Text('PREFERENCES', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppCorners.roundedMd,
                  border: Border.all(color: AppColors.border),
                ),
                child: SwitchListTile(
                  activeThumbColor: AppColors.green,
                  title: const Text('Push Notifications', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                  subtitle: const Text('Receive pickup order status updates'),
                  value: _notificationsEnabled,
                  onChanged: (val) {
                    setState(() {
                      _notificationsEnabled = val;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),

              const Text('ABOUT QUCZO', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppCorners.roundedMd,
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('QUCZO Version 2.4.0', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                    SizedBox(height: 2),
                    Text('Smart Search. Local Shops.', style: TextStyle(color: AppColors.greenDark, fontWeight: FontWeight.w600, fontSize: 12)),
                    SizedBox(height: 6),
                    Text('Hyperlocal commerce & product reservation platform for local shops.', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
