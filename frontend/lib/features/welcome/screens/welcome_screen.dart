import 'package:flutter/material.dart';
import '../../../core/localization/app_language.dart';
import '../../../core/localization/app_language_storage.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/responsive.dart';
import '../../../main.dart';
import '../../../navigation/app_routes.dart';

/// SCREEN 02 — WELCOME + LANGUAGE SELECTION + ROLE SELECTION
/// 
/// First interactive onboarding screen allowing users to:
/// 1. Choose their language (Live localized strings update across 5 languages)
/// 2. Choose their role (Customer vs Shop Owner)
/// 3. Proceed via bottom-aligned CTA
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  AppLanguage _selectedLanguage = AppLanguage.english;
  String? _selectedRole; // 'customer' or 'shop_owner'

  void _onLanguageSelected(AppLanguage language) {
    if (_selectedLanguage != language) {
      setState(() {
        _selectedLanguage = language;
      });
      AppLanguageStorage.saveLanguageCode(language.code);
      // Immediately update active application locale while preserving selected role
      QuczoApp.setLocale(context, language.locale);
    }
  }

  void _onRoleSelected(String role) {
    setState(() {
      _selectedRole = role;
    });
  }

  void _onContinuePressed() {
    if (_selectedRole == null) return;

    if (_selectedRole == 'customer') {
      Navigator.pushNamed(context, AppRoutes.customerLogin);
    } else if (_selectedRole == 'shop_owner') {
      Navigator.pushNamed(context, AppRoutes.shopOwnerLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final double screenWidth = Responsive.width(context);
    final bool isSmallScreen = screenWidth <= 360;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Safe Header with Compact QUCZO Branding
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.navy,
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(
                          color: AppColors.greenBorder.withValues(alpha: 0.3),
                          width: 1.0,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Q',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'QUC',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                              fontFamily: 'sans-serif',
                            ),
                          ),
                          TextSpan(
                            text: 'ZO',
                            style: TextStyle(
                              color: AppColors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                              fontFamily: 'sans-serif',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Scrollable Content Layout
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // WELCOME SECTION - Minimal Corporate Styling
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(isSmallScreen ? 16.0 : 20.0),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppCorners.roundedLg,
                        border: Border.all(color: AppColors.border, width: 1.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x060F172A),
                            blurRadius: 12,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.translate('welcomeTitle'),
                            style: AppTypography.headingLarge.copyWith(
                              fontSize: isSmallScreen ? 20.0 : 22.0,
                              color: AppColors.navy,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            loc.translate('welcomeSubtitle'),
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // LANGUAGE SELECTION - 2-Column Responsive Grid Layout
                    Text(
                      loc.translate('chooseLanguage'),
                      style: AppTypography.headingMedium.copyWith(
                        fontSize: 16.0,
                        color: AppColors.navy,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildLanguageGrid(context),

                    const SizedBox(height: 28),

                    // ROLE SELECTION - Dual Role Cards (Customer & Shop Owner)
                    Text(
                      loc.translate('chooseRole'),
                      style: AppTypography.headingMedium.copyWith(
                        fontSize: 16.0,
                        color: AppColors.navy,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Customer Card
                    _buildRoleCard(
                      context: context,
                      roleKey: 'customer',
                      title: loc.translate('customerRoleTitle'),
                      description: loc.translate('customerRoleDesc'),
                      icon: Icons.person_outline_rounded,
                      isSelected: _selectedRole == 'customer',
                      onTap: () => _onRoleSelected('customer'),
                    ),

                    const SizedBox(height: 12),

                    // Shop Owner Card
                    _buildRoleCard(
                      context: context,
                      roleKey: 'shop_owner',
                      title: loc.translate('shopOwnerRoleTitle'),
                      description: loc.translate('shopOwnerRoleDesc'),
                      icon: Icons.storefront_outlined,
                      isSelected: _selectedRole == 'shop_owner',
                      onTap: () => _onRoleSelected('shop_owner'),
                    ),

                    const SizedBox(height: 32),

                    // Bottom-Aligned Primary CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _selectedRole != null ? _onContinuePressed : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedRole != null
                              ? AppColors.green
                              : AppColors.border,
                          foregroundColor: _selectedRole != null
                              ? Colors.white
                              : AppColors.textMuted,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppCorners.roundedMd,
                          ),
                        ),
                        child: Text(
                          loc.translate('continueCTA'),
                          style: AppTypography.buttonLarge.copyWith(
                            color: _selectedRole != null
                                ? Colors.white
                                : AppColors.textMuted,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    if (_selectedRole == null) ...[
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          loc.translate('selectRolePrompt'),
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 2-Column Responsive Language Selector Arrangement
  Widget _buildLanguageGrid(BuildContext context) {
    final languages = AppLanguage.values;

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildLanguageItem(languages[0])), // English
            const SizedBox(width: 10),
            Expanded(child: _buildLanguageItem(languages[1])), // Tamil
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _buildLanguageItem(languages[2])), // Telugu
            const SizedBox(width: 10),
            Expanded(child: _buildLanguageItem(languages[3])), // Kannada
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _buildLanguageItem(languages[4])), // Hindi
            const SizedBox(width: 10),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
      ],
    );
  }

  /// Individual Language Card Widget
  Widget _buildLanguageItem(AppLanguage language) {
    final bool isSelected = _selectedLanguage == language;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onLanguageSelected(language),
        borderRadius: AppCorners.roundedMd,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.greenSubtle : AppColors.surface,
            borderRadius: AppCorners.roundedMd,
            border: Border.all(
              color: isSelected ? AppColors.green : AppColors.border,
              width: isSelected ? 1.8 : 1.0,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.green : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppColors.green : AppColors.textMuted,
                    width: 1.5,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      language.englishName,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                        color: isSelected ? AppColors.navy : AppColors.textPrimary,
                        fontFamily: 'sans-serif',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (language.nativeName != language.englishName) ...[
                      const SizedBox(height: 2),
                      Text(
                        language.nativeName,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: isSelected ? AppColors.greenDark : AppColors.textSecondary,
                          fontFamily: 'sans-serif',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Individual Role Choice Card Widget
  Widget _buildRoleCard({
    required BuildContext context,
    required String roleKey,
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppCorners.roundedLg,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.greenSubtle : AppColors.surface,
            borderRadius: AppCorners.roundedLg,
            border: Border.all(
              color: isSelected ? AppColors.green : AppColors.border,
              width: isSelected ? 2.0 : 1.0,
            ),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: Color(0x1A059669),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ]
                : const [
                    BoxShadow(
                      color: Color(0x060F172A),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Role Icon Badge
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.green : AppColors.surfaceSubtle,
                  borderRadius: AppCorners.roundedMd,
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: isSelected ? Colors.white : AppColors.navy,
                ),
              ),

              const SizedBox(width: 14),

              // Title and Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.headingMedium.copyWith(
                        fontSize: 16,
                        color: isSelected ? AppColors.navy : AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTypography.bodyMedium.copyWith(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // Radio Selection Indicator
              Container(
                width: 22,
                height: 22,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.green : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppColors.green : AppColors.border,
                    width: 2.0,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
