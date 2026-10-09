import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quczo/features/welcome/screens/welcome_screen.dart';
import 'package:quczo/main.dart';

void main() {
  group('Screen 02 - Welcome, Language & Role Selection Tests', () {
    testWidgets('Renders all Screen 02 components cleanly', (WidgetTester tester) async {
      await tester.pumpWidget(const QuczoApp());
      await tester.pump(const Duration(milliseconds: 500));

      // Navigate to welcome screen
      tester.state<NavigatorState>(find.byType(Navigator)).pushReplacementNamed('/welcome-language');
      await tester.pumpAndSettle();

      expect(find.byType(WelcomeScreen), findsOneWidget);
      expect(find.text('Welcome to QUCZO'), findsOneWidget);
      expect(find.text('Choose your language'), findsOneWidget);
      expect(find.text('Choose your role'), findsOneWidget);

      // Verify 5 language choices exist
      expect(find.text('English'), findsOneWidget);
      expect(find.text('Tamil'), findsOneWidget);
      expect(find.text('தமிழ்'), findsOneWidget);
      expect(find.text('Telugu'), findsOneWidget);
      expect(find.text('Kannada'), findsOneWidget);
      expect(find.text('Hindi'), findsOneWidget);

      // Verify 2 role cards exist
      expect(find.text('Customer'), findsOneWidget);
      expect(find.text('Shop Owner'), findsOneWidget);

      // Verify Continue button is disabled initially
      final buttonFinder = find.widgetWithText(ElevatedButton, 'Continue');
      expect(buttonFinder, findsOneWidget);
      final ElevatedButton button = tester.widget(buttonFinder);
      expect(button.onPressed, isNull);
    });

    testWidgets('Selecting a role enables Continue CTA button', (WidgetTester tester) async {
      await tester.pumpWidget(const QuczoApp());
      await tester.pump(const Duration(milliseconds: 500));

      tester.state<NavigatorState>(find.byType(Navigator)).pushReplacementNamed('/welcome-language');
      await tester.pumpAndSettle();

      // Tap Customer role card
      await tester.tap(find.text('Customer'));
      await tester.pumpAndSettle();

      // Verify Continue button is now enabled
      final ElevatedButton enabledButton = tester.widget(find.widgetWithText(ElevatedButton, 'Continue'));
      expect(enabledButton.onPressed, isNotNull);

      // Tap Continue and verify it navigates to CustomerLoginScreen, NOT CustomerHomeScreen
      final continueButton = find.widgetWithText(ElevatedButton, 'Continue');
      await tester.ensureVisible(continueButton);
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      expect(find.text('Mobile Number'), findsOneWidget);
    });

    testWidgets('Tapping Hindi language updates live strings immediately and keeps selected role', (WidgetTester tester) async {
      await tester.pumpWidget(const QuczoApp());
      await tester.pump(const Duration(milliseconds: 500));

      tester.state<NavigatorState>(find.byType(Navigator)).pushReplacementNamed('/welcome-language');
      await tester.pumpAndSettle();

      // Select Customer role
      await tester.tap(find.text('Customer'));
      await tester.pumpAndSettle();

      // Tap Hindi language card
      await tester.tap(find.text('Hindi'));
      await tester.pumpAndSettle();

      // Verify live Hindi strings render
      expect(find.text('QUCZO में आपका स्वागत है'), findsOneWidget);
      expect(find.text('अपनी भाषा चुनें'), findsOneWidget);
      expect(find.text('अपनी भूमिका चुनें'), findsOneWidget);
      expect(find.text('ग्राहक'), findsOneWidget);
      expect(find.text('दुकानदार'), findsOneWidget);
      expect(find.text('आगे बढ़ें'), findsOneWidget);
    });

    testWidgets('Viewport responsiveness test at 360x800', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const QuczoApp());
      await tester.pump(const Duration(milliseconds: 500));

      tester.state<NavigatorState>(find.byType(Navigator)).pushReplacementNamed('/welcome-language');
      await tester.pumpAndSettle();

      expect(find.byType(WelcomeScreen), findsOneWidget);
      expect(find.text('Welcome to QUCZO'), findsOneWidget);
    });

    testWidgets('Viewport responsiveness test at 375x812', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const QuczoApp());
      await tester.pump(const Duration(milliseconds: 500));

      tester.state<NavigatorState>(find.byType(Navigator)).pushReplacementNamed('/welcome-language');
      await tester.pumpAndSettle();

      expect(find.byType(WelcomeScreen), findsOneWidget);
    });

    testWidgets('Viewport responsiveness test at 390x844', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const QuczoApp());
      await tester.pump(const Duration(milliseconds: 500));

      tester.state<NavigatorState>(find.byType(Navigator)).pushReplacementNamed('/welcome-language');
      await tester.pumpAndSettle();

      expect(find.byType(WelcomeScreen), findsOneWidget);
    });

    testWidgets('Viewport responsiveness test at 414x896', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(414, 896);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const QuczoApp());
      await tester.pump(const Duration(milliseconds: 500));

      tester.state<NavigatorState>(find.byType(Navigator)).pushReplacementNamed('/welcome-language');
      await tester.pumpAndSettle();

      expect(find.byType(WelcomeScreen), findsOneWidget);
    });
  });
}
