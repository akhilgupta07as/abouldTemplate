import 'package:abould_ada/core/constants/storage_keys.dart';
import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/core/localization/app_locales.dart';
import 'package:abould_ada/core/storage/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleController extends StateNotifier<Locale> {
  LocaleController(this._storage) : super(AppLocales.english) {
    _load();
  }

  final LocalStorageService _storage;

  Future<void> _load() async {
    final saved = await _storage.getString(StorageKeys.localeCode);
    state = AppLocales.fromLanguageCode(saved);
  }

  Future<void> setLocale(Locale locale) async {
    if (!AppLocales.isSupported(locale.languageCode)) return;
    state = locale;
    await _storage.setString(StorageKeys.localeCode, locale.languageCode);
  }
}

final localeControllerProvider =
    StateNotifierProvider<LocaleController, Locale>((ref) {
  return LocaleController(ref.watch(localStorageProvider));
});
