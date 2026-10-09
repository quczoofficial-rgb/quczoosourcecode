import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quczo/core/localization/app_language.dart';
import 'package:quczo/core/localization/app_localizations.dart';
import 'package:quczo/core/theme/app_theme.dart';
import 'package:quczo/features/search/screens/ai_search_screen.dart';
import 'package:quczo/navigation/app_routes.dart';

Widget buildTestableAiSearchScreen({Locale locale = const Locale('en')}) {
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
    initialRoute: AppRoutes.aiSearch,
    routes: AppRoutes.routes,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Screen 08 - AI Search Screen Part A & B Complete Tests', () {
    testWidgets('Renders all Screen 08 Part A & Part B components cleanly', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableAiSearchScreen());
      await tester.pumpAndSettle();

      expect(find.byType(AiSearchScreen), findsOneWidget);

      // Check Header & Search Location
      expect(find.text('Searching near'), findsOneWidget);
      expect(find.text('Choose your location'), findsOneWidget);

      // Check AI Search Hero Box & Prompts
      expect(find.text('What are you looking for?'), findsOneWidget);
      expect(find.text('Find products from nearby local shops'), findsOneWidget);
      expect(find.text('AI Search'), findsOneWidget);

      // Check Action Icons (Mic & Camera)
      expect(find.byIcon(Icons.mic_none_outlined), findsOneWidget);
      expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);

      // Check Part B Sections: Recent Searches & Popular Searches & Intent Prompts
      expect(find.text('Recent searches'), findsOneWidget);
      expect(find.text('Popular searches'), findsOneWidget);
      expect(find.text('Clear all'), findsOneWidget);
      expect(find.text('Search naturally — try these queries'), findsOneWidget);

      // Check Quick Search Suggestions
      expect(find.text('Try searching for'), findsOneWidget);

      // Check Category Shortcuts
      expect(find.text('Explore products'), findsOneWidget);
      expect(find.text('Fresh Produce'), findsWidgets);

      // Check 5-Item Bottom Navigation Bar (Search selected)
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Cart'), findsOneWidget);
      expect(find.text('Orders'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('Submitting search query executes search and updates results', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableAiSearchScreen());
      await tester.pumpAndSettle();

      // Enter search query
      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      await tester.enterText(textField, 'LED Bulb');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump(); // Start loading state

      expect(find.text('Finding products nearby...'), findsOneWidget);

      await tester.pumpAndSettle(); // Complete search execution

      // Verify matching products displayed
      expect(find.textContaining('LED Bulb'), findsWidgets);
    });

    testWidgets('Clearing recent searches removes the recent searches section', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableAiSearchScreen());
      await tester.pumpAndSettle();

      expect(find.text('Recent searches'), findsOneWidget);

      final clearAllBtn = find.text('Clear all');
      expect(clearAllBtn, findsOneWidget);

      await tester.tap(clearAllBtn);
      await tester.pumpAndSettle();

      expect(find.text('Recent searches'), findsNothing);
    });

    testWidgets('Renders cleanly in all 5 supported languages', (WidgetTester tester) async {
      for (final lang in AppLanguage.values) {
        await tester.pumpWidget(buildTestableAiSearchScreen(locale: lang.locale));
        await tester.pumpAndSettle();

        expect(find.byType(AiSearchScreen), findsOneWidget);
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

        await tester.pumpWidget(buildTestableAiSearchScreen());
        await tester.pumpAndSettle();

        expect(find.byType(AiSearchScreen), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    }
  });
}
