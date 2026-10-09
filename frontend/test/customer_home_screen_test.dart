import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quczo/core/localization/app_language.dart';
import 'package:quczo/core/localization/app_localizations.dart';
import 'package:quczo/core/theme/app_theme.dart';
import 'package:quczo/features/home/screens/customer_home_screen.dart';
import 'package:quczo/navigation/app_routes.dart';

Widget buildTestableCustomerHomeScreen({Locale locale = const Locale('en')}) {
  return MaterialApp(
    theme: AppTheme.lightTheme,
    locale: locale,
    supportedLocales: AppLanguage.values.map((e) => e.locale),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    initialRoute: AppRoutes.customerHome,
    routes: AppRoutes.routes,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Screen 07 - Customer Home Screen Tests', () {
    testWidgets('Renders all Home marketplace components cleanly', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableCustomerHomeScreen());
      await tester.pumpAndSettle();

      // Check Header & Search Location Area
      expect(find.text('Searching near'), findsOneWidget);
      expect(find.text('Choose your location'), findsOneWidget);

      // Check Commerce Search Hero Banner
      expect(find.text('Find anything nearby from local shops.'), findsOneWidget);

      // Check Quick Search Chips & Categories
      expect(find.text('Fresh Produce'), findsWidgets);
      expect(find.textContaining('Grocery'), findsWidgets);

      // Check Category Carousel Header
      expect(find.text('Shop by Category'), findsOneWidget);



      // Check Popular Near You Section
      expect(find.text('Popular Near You'), findsOneWidget);
      expect(find.text('Sona Masoori Rice 5kg'), findsWidgets);

      // Check Compare Nearby Prices Section
      expect(find.text('Compare Nearby Prices'), findsOneWidget);
      expect(find.text('Compare Shops'), findsWidgets);

      // Check Available Near You Section
      expect(find.text('Available Near You'), findsOneWidget);

      // Check Nearby Shops Section
      expect(find.text('Shops Near You'), findsOneWidget);

      // Check 5-Item Bottom Navigation Bar
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Cart'), findsOneWidget);
      expect(find.text('Orders'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('Renders properly in all 5 supported languages', (WidgetTester tester) async {
      for (final lang in AppLanguage.values) {
        await tester.pumpWidget(buildTestableCustomerHomeScreen(locale: lang.locale));
        await tester.pumpAndSettle();

        expect(find.byType(CustomerHomeScreen), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    });

    final List<Size> viewports = [
      const Size(360, 800),
      const Size(375, 812),
      const Size(390, 844),
      const Size(414, 896),
    ];

    for (final size in viewports) {
      testWidgets('Viewport responsiveness test at ${size.width.toInt()}x${size.height.toInt()}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(buildTestableCustomerHomeScreen());
        await tester.pumpAndSettle();

        expect(find.byType(CustomerHomeScreen), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    }
  });
}
