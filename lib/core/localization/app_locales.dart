import 'package:flutter/material.dart';

abstract final class AppLocales {
  static const english = Locale('en');
  static const hindi = Locale('hi');

  static const supported = [english, hindi];

  static bool isSupported(String languageCode) =>
      languageCode == 'en' || languageCode == 'hi';

  static Locale fromLanguageCode(String? code) {
    if (code == 'hi') return hindi;
    return english;
  }
}
