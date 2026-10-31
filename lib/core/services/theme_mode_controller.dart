import 'package:abould_ada/core/constants/storage_keys.dart';
import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/core/storage/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeModeController extends StateNotifier<ThemeMode> {
  ThemeModeController(this._storage) : super(ThemeMode.system) {
    _load();
  }

  final LocalStorageService _storage;

  Future<void> _load() async {
    final saved = await _storage.getString(StorageKeys.themeMode);
    state = switch (saved) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _storage.setString(StorageKeys.themeMode, mode.name);
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeController, ThemeMode>((ref) {
  return ThemeModeController(ref.watch(localStorageProvider));
});
