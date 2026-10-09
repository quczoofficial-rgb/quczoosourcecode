import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/constants/app_constants.dart';
import 'core/localization/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/screens/splash_screen.dart';
import 'navigation/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const QuczoApp());
}

class QuczoApp extends StatefulWidget {
  const QuczoApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _QuczoAppState? state = context.findAncestorStateOfType<_QuczoAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<QuczoApp> createState() => _QuczoAppState();
}

class _QuczoAppState extends State<QuczoApp> {
  Locale _locale = const Locale('en', '');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ta', ''), // Tamil
        Locale('te', ''), // Telugu
        Locale('kn', ''), // Kannada
        Locale('hi', ''), // Hindi
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: AppRoutes.splash,
      onGenerateInitialRoutes: (String initialRouteName) {
        return [
          MaterialPageRoute(
            settings: const RouteSettings(name: AppRoutes.splash),
            builder: (context) => const SplashScreen(),
          ),
        ];
      },
      routes: AppRoutes.routes,
    );
  }
}
