import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_corners.dart';
import '../../../repositories/auth_repository.dart';

class ShopOwnerOtpScreen extends StatefulWidget {
  const ShopOwnerOtpScreen({super.key});

  @override
  State<ShopOwnerOtpScreen> createState() => _ShopOwnerOtpScreenState();
}

class _ShopOwnerOtpScreenState extends State<ShopOwnerOtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  String _otpError = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Request focus on first box after frame renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  /// Distribute a pasted string across the 6 boxes
  void _pasteFill(String text) {
    final digits = text.replaceAll(RegExp(r'\D'), '');
    if (digits.length >= 6) {
      for (int i = 0; i < 6; i++) {
        _controllers[i].text = digits[i];
      }
      _focusNodes[5].requestFocus();
      setState(() {});
    }
  }

  void _onChanged(String value, int index) {
    // Handle paste (6 chars typed at once on box 0)
    if (value.length > 1) {
      _pasteFill(value);
      return;
    }
    if (value.isNotEmpty) {
      _controllers[index].text = value[0];
      _controllers[index].selection = const TextSelection.collapsed(offset: 1);
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }
    setState(() => _otpError = '');
  }

  void _onKeyEvent(KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        _controllers[index - 1].clear();
        _focusNodes[index - 1].requestFocus();
        setState(() {});
      } else {
        _controllers[index].clear();
        setState(() {});
      }
    }
  }

  bool get _isComplete => _controllers.every((c) => c.text.isNotEmpty);

  void _verifyOtp() async {
    if (!_isComplete) {
      setState(() => _otpError = 'Please enter the complete 6-digit OTP');
      return;
    }

    setState(() {
      _isLoading = true;
      _otpError = '';
    });

    final otpCode = _controllers.map((c) => c.text).join();
    final success = await AuthRepository().verifyOtp(otpCode);

    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        Navigator.pushReplacementNamed(context, '/shop-owner-dashboard');
      } else {
        setState(() => _otpError = 'Invalid OTP. Please try again.');
        // Clear boxes on error
        for (var c in _controllers) {
          c.clear();
        }
        _focusNodes[0].requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Verify Business OTP',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter the 6-digit business verification code sent to your mobile number:',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),

              // OTP Input Boxes
              LayoutBuilder(
                builder: (context, constraints) {
                  final double boxWidth =
                      ((constraints.maxWidth - 5 * 10) / 6).clamp(0.0, 52.0);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: boxWidth,
                        height: 56,
                        child: KeyboardListener(
                          focusNode: FocusNode(skipTraversal: true),
                          onKeyEvent: (event) => _onKeyEvent(event, index),
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 6, // Allow 6 for paste detection
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.navy,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                  borderRadius: AppCorners.roundedMd),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: AppCorners.roundedMd,
                                borderSide: const BorderSide(
                                    color: AppColors.green, width: 2),
                              ),
                              filled: true,
                              fillColor: AppColors.surface,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (val) => _onChanged(val, index),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),

              if (_otpError.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: AppCorners.roundedSm,
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(_otpError,
                            style: const TextStyle(color: Colors.red, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _isComplete && !_isLoading ? _verifyOtp : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AppColors.border,
                  disabledForegroundColor: AppColors.textSecondary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: AppCorners.roundedMd),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : const Text('Verify & Enter Business Dashboard',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
              ),

              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    for (var c in _controllers) {
                      c.clear();
                    }
                    _focusNodes[0].requestFocus();
                    setState(() => _otpError = '');
                  },
                  child: const Text('Resend OTP',
                      style: TextStyle(color: AppColors.green)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
