import 'package:flutter/material.dart';

/// In-memory & local language persistence manager for QUCZO
class AppLanguageStorage {
  static String _currentLanguageCode = 'en';

  static String get currentLanguageCode => _currentLanguageCode;

  static Locale get currentLocale => Locale(_currentLanguageCode, '');

  static void saveLanguageCode(String code) {
    if (['en', 'ta', 'te', 'kn', 'hi'].contains(code)) {
      _currentLanguageCode = code;
    }
  }
}
