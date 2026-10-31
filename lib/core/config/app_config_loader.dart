import 'dart:convert';

import 'package:abould_ada/core/config/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Resolves [AppConfig] from compile-time `--dart-define` values, with a debug
/// fallback that reads `dart_defines/supabase.local.json` from assets.
abstract final class AppConfigLoader {
  static const _supabaseAssetPath = 'dart_defines/supabase.local.json';

  static Future<AppConfig> resolve({AppConfig? override}) async {
    if (override != null) return override;

    final fromEnv = AppConfig.fromEnvironment();
    if (fromEnv.isSupabaseConfigured || !kDebugMode) {
      return fromEnv;
    }

    return _mergeSupabaseFromAsset(fromEnv);
  }

  static Future<AppConfig> _mergeSupabaseFromAsset(AppConfig base) async {
    try {
      final raw = await rootBundle.loadString(_supabaseAssetPath);
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final url = map['SUPABASE_URL']?.toString().trim() ?? '';
      final publishable =
          map['SUPABASE_PUBLISHABLE_KEY']?.toString().trim() ?? '';
      final anon = map['SUPABASE_ANON_KEY']?.toString().trim() ?? '';
      final clientKey = publishable.isNotEmpty ? publishable : anon;

      if (url.isEmpty || clientKey.isEmpty) return base;

      return AppConfig(
        environment: base.environment,
        appName: base.appName,
        apiBaseUrl: base.apiBaseUrl,
        enableRequestLogging: base.enableRequestLogging,
        useFirebase: base.useFirebase,
        authBackend: base.authBackend,
        supabaseUrl: url,
        supabaseClientKey: clientKey,
      );
    } catch (_) {
      return base;
    }
  }
}
