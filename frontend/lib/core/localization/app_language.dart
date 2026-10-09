import 'package:flutter/material.dart';

enum AppLanguage {
  english('en', 'English', 'English'),
  tamil('ta', 'Tamil', 'தமிழ்'),
  telugu('te', 'Telugu', 'తెలుగు'),
  kannada('kn', 'Kannada', 'ಕನ್ನಡ'),
  hindi('hi', 'Hindi', 'हिन्दी');

  final String code;
  final String englishName;
  final String nativeName;

  const AppLanguage(this.code, this.englishName, this.nativeName);

  Locale get locale => Locale(code);

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => AppLanguage.english,
    );
  }
}
