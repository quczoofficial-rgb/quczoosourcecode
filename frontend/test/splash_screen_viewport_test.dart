import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quczo/main.dart';
import 'package:quczo/features/splash/screens/splash_screen.dart';

void main() {
  group('Screen 01 - Splash Screen Viewport Responsiveness Tests', () {
    testWidgets('Renders cleanly at 360x800 viewport', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const QuczoApp());
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('QUCZO'), findsOneWidget);
      expect(find.text('Smart Search. Local Shops.'), findsOneWidget);
      expect(find.text('Shop smarter with nearby stores.'), findsOneWidget);
      expect(find.byType(LocalTownIllustration), findsOneWidget);
      expect(find.text('Locally yours. Always.'), findsOneWidget);
    });

    testWidgets('Renders cleanly at 375x812 viewport', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const QuczoApp());
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('QUCZO'), findsOneWidget);
      expect(find.text('Smart Search. Local Shops.'), findsOneWidget);
      expect(find.text('Shop smarter with nearby stores.'), findsOneWidget);
    });

    testWidgets('Renders cleanly at 390x844 viewport', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const QuczoApp());
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('QUCZO'), findsOneWidget);
      expect(find.text('Smart Search. Local Shops.'), findsOneWidget);
      expect(find.text('Shop smarter with nearby stores.'), findsOneWidget);
    });

    testWidgets('Renders cleanly at 414x896 viewport', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(414, 896);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const QuczoApp());
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('QUCZO'), findsOneWidget);
      expect(find.text('Smart Search. Local Shops.'), findsOneWidget);
      expect(find.text('Shop smarter with nearby stores.'), findsOneWidget);
    });
  });
}
