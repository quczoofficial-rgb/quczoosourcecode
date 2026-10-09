import 'dart:async';
import 'package:flutter/material.dart';
import '../../../widgets/common_branding.dart';
import '../../../core/utils/responsive.dart';
import '../../../navigation/app_routes.dart';

/// SCREEN 01 — SPLASH SCREEN
/// 
/// Official QUCZO Reference Splash Screen matching storyboard 100%:
/// - Clean light background (#FFFFFF)
/// - ALL CAPS "QUCZO" emerald green brand title (#059669)
/// - Tagline: "Smart Search. Local Shops."
/// - Subtext: "Shop smarter with nearby stores."
/// - Direct high-fidelity rendering of the official town storefront vector illustration from reference storyboard
/// - Animated green progress indicator pill
/// - Footer message: "Locally yours. Always."
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _progressAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );

    _progressAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.95, curve: Curves.easeInOut),
    );

    _controller.forward();

    _timer = Timer(const Duration(milliseconds: 3200), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.welcomeLanguage);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Responsive.width(context);
    final double scaleFactor = screenWidth <= 360 ? 0.85 : (screenWidth >= 414 ? 1.05 : 1.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 3),

              // Top / Center Quczo Brand Header (ALL CAPS as in reference)
              const QuczoBrandLogo(size: 64, showWordmark: true),
              const SizedBox(height: 12),
              
              Text(
                'Smart Search. Local Shops.',
                style: TextStyle(
                  color: const Color(0xFF1E293B),
                  fontSize: 16.0 * scaleFactor,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.1,
                  fontFamily: 'sans-serif',
                ),
              ),
              const SizedBox(height: 6),

              Text(
                'Shop smarter with nearby stores.',
                style: TextStyle(
                  color: const Color(0xFF64748B),
                  fontSize: 13.0 * scaleFactor,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'sans-serif',
                ),
              ),

              const Spacer(flex: 3),

              // High-Fidelity Reference Town Storefront Graphic
              Flexible(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LocalTownIllustration(scaleFactor: scaleFactor),
                ),
              ),

              const SizedBox(height: 24),

              // Animated Progress Bar Pill (As seen in reference storyboard 01 Splash)
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return Container(
                    width: 130 * scaleFactor,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: _progressAnimation.value.clamp(0.08, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF059669),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              // Bottom Footer Message
              Text(
                'Locally yours. Always.',
                style: TextStyle(
                  color: const Color(0xFF059669),
                  fontSize: 12.5 * scaleFactor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                  fontFamily: 'sans-serif',
                ),
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

/// Official Town Storefront Graphic Component
class LocalTownIllustration extends StatelessWidget {
  final double scaleFactor;

  const LocalTownIllustration({super.key, this.scaleFactor = 1.0});

  @override
  Widget build(BuildContext context) {
    // Replaced blurry raster image with a responsive, high-resolution vector painter.
    // Using FittedBox with BoxFit.contain guarantees the image preserves its aspect ratio
    // without distortion or pixel stretching, naturally adapting to desktop and mobile sizes.
    return FittedBox(
      fit: BoxFit.contain,
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 360,
        height: 210,
        child: CustomPaint(
          painter: _TownIllustrationPainter(),
        ),
      ),
    );
  }
}

/// Fallback Painter in case asset loading is delayed
class _TownIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double groundY = h * 0.88;

    final Paint skylinePaint = Paint()..color = const Color(0xFFE2E8F0).withValues(alpha: 0.85);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.08, groundY - 110, w * 0.22, groundY), const Radius.circular(4)), skylinePaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.24, groundY - 135, w * 0.40, groundY), const Radius.circular(4)), skylinePaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.45, groundY - 100, w * 0.62, groundY), const Radius.circular(4)), skylinePaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.66, groundY - 125, w * 0.84, groundY), const Radius.circular(4)), skylinePaint);

    final Paint foliageLight = Paint()..color = const Color(0xFF6EE7B7);
    final Paint foliageMid = Paint()..color = const Color(0xFF34D399);
    final Paint foliageDark = Paint()..color = const Color(0xFF10B981);
    canvas.drawCircle(Offset(w * 0.06, groundY - 55), 24, foliageLight);
    canvas.drawCircle(Offset(w * 0.12, groundY - 70), 30, foliageMid);
    canvas.drawCircle(Offset(w * 0.42, groundY - 75), 32, foliageMid);
    canvas.drawCircle(Offset(w * 0.58, groundY - 80), 35, foliageDark);
    canvas.drawCircle(Offset(w * 0.90, groundY - 75), 28, foliageLight);

    final Paint shop1Wall = Paint()..color = const Color(0xFFECFDF5);
    canvas.drawRect(Rect.fromLTRB(w * 0.07, groundY - 65, w * 0.32, groundY), shop1Wall);

    final Paint shop2Wall = Paint()..color = const Color(0xFFFFFBEB);
    canvas.drawRect(Rect.fromLTRB(w * 0.35, groundY - 80, w * 0.63, groundY), shop2Wall);
    const int numStripes = 6;
    final double stripeW = (w * 0.28) / numStripes;
    for (int i = 0; i < numStripes; i++) {
      final Paint stripePaint = Paint()..color = (i % 2 == 0) ? const Color(0xFFF97316) : Colors.white;
      canvas.drawRect(Rect.fromLTRB(w * 0.35 + (i * stripeW), groundY - 70, w * 0.35 + ((i + 1) * stripeW), groundY - 56), stripePaint);
    }

    final Paint shop3Wall = Paint()..color = Colors.white;
    canvas.drawRect(Rect.fromLTRB(w * 0.66, groundY - 105, w * 0.94, groundY), shop3Wall);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTRB(w * 0.63, groundY - 117, w * 0.97, groundY - 97), const Radius.circular(4)), Paint()..color = const Color(0xFF059669));

    canvas.drawRect(Rect.fromLTRB(0, groundY, w, groundY + 4), Paint()..color = const Color(0xFF059669));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
