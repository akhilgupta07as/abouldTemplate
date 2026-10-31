import 'package:shared_preferences/shared_preferences.dart';

/// Abstraction over key-value local persistence (non-sensitive data).
abstract class LocalStorageService {
  Future<String?> getString(String key);
  Future<bool> setString(String key, String value);
  Future<bool> remove(String key);
  Future<bool> clear();
}

class SharedPreferencesLocalStorage implements LocalStorageService {
  SharedPreferencesLocalStorage(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<String?> getString(String key) async => _prefs.getString(key);

  @override
  Future<bool> setString(String key, String value) async =>
      _prefs.setString(key, value);

  @override
  Future<bool> remove(String key) async => _prefs.remove(key);

  @override
  Future<bool> clear() async => _prefs.clear();
}
