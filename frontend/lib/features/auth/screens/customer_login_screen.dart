import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../widgets/common_branding.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/responsive.dart';
import '../../../navigation/app_routes.dart';

/// SCREEN 03 — CUSTOMER MOBILE LOGIN SCREEN
class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  void _onContinuePressed() {
    final phone = _phoneController.text.trim();
    if (phone.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(phone)) {
      setState(() {
        _errorMessage = 'Please enter a valid 10-digit mobile number';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
    });

    // Navigate to OTP Verification screen passing phone number
    Navigator.pushNamed(
      context,
      AppRoutes.otpVerification,
      arguments: phone,
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.9 : 1.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.navy, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                // QUCZO Logo Badge
                const QuczoBrandLogo(size: 44, showWordmark: true),

                const SizedBox(height: 28),

                // Welcome Heading & Description
                Text(
                  loc.translate('welcomeBackTitle'),
                  style: AppTypography.headingLarge.copyWith(
                    fontSize: 24 * scaleFactor,
                    color: AppColors.navy,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  loc.translate('findProductsSubtitle'),
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 14 * scaleFactor,
                    height: 1.35,
                  ),
                ),

                const SizedBox(height: 32),

                // Mobile Number Label & Input Field
                Text(
                  loc.translate('mobileNumberLabel'),
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5 * scaleFactor,
                  ),
                ),
                const SizedBox(height: 8),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppCorners.roundedLg,
                    border: Border.all(
                      color: _errorMessage != null ? AppColors.error : AppColors.border,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Country Code Prefix (+91)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceSubtle,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          border: Border(
                            right: BorderSide(color: AppColors.borderLight, width: 1.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              '🇮🇳',
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '+91',
                              style: AppTypography.headingMedium.copyWith(
                                fontSize: 15 * scaleFactor,
                                color: AppColors.navy,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Mobile Input Text Field
                      Expanded(
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          style: AppTypography.headingMedium.copyWith(
                            fontSize: 16 * scaleFactor,
                            color: AppColors.navy,
                            letterSpacing: 1.2,
                          ),
                          decoration: InputDecoration(
                            hintText: loc.translate('enter10DigitMobile'),
                            hintStyle: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 14 * scaleFactor,
                              letterSpacing: 0,
                            ),
                            counterText: '',
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                          ),
                          onChanged: (_) {
                            if (_errorMessage != null) {
                              setState(() => _errorMessage = null);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                if (_errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: AppColors.error,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],

                const SizedBox(height: 36),

                // Primary Continue CTA Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _onContinuePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppCorners.roundedLg,
                      ),
                    ),
                    child: Text(
                      loc.translate('continueCTA'),
                      style: AppTypography.buttonLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16 * scaleFactor,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Security & Privacy Disclaimer
                Center(
                  child: Text(
                    loc.translate('otpSecurityNotice'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11.5 * scaleFactor,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
