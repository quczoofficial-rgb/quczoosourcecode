import 'package:flutter_test/flutter_test.dart';
import 'package:quczo/main.dart';
import 'package:quczo/features/splash/screens/splash_screen.dart';

void main() {
  testWidgets('QUCZO Splash Screen Smoke Test', (WidgetTester tester) async {
    await tester.pumpWidget(const QuczoApp());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('QUCZO'), findsOneWidget);
    expect(find.text('Smart Search. Local Shops.'), findsOneWidget);
    expect(find.text('Shop smarter with nearby stores.'), findsOneWidget);
    expect(find.byType(LocalTownIllustration), findsOneWidget);
  });
}
