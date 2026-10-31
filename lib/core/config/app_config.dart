import 'package:abould_ada/core/config/auth_backend.dart';
import 'package:abould_ada/core/config/environment.dart';

export 'auth_backend.dart';
export 'environment.dart';

/// Application-wide configuration. Values come from compile-time defines or
/// defaults suitable for local development — never hardcode secrets here.
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    required this.apiBaseUrl,
    this.enableRequestLogging = true,
    this.useFirebase = true,
    this.authBackend = AuthBackend.dummyJson,
    this.supabaseUrl = '',
    this.supabaseClientKey = '',
  });

  final Environment environment;
  final String appName;
  final String apiBaseUrl;
  final bool enableRequestLogging;
  final bool useFirebase;
  final AuthBackend authBackend;
  final String supabaseUrl;
  /// Anon JWT or `sb_publishable_…` key — never use the service role key in the app.
  final String supabaseClientKey;

  bool get isSupabaseConfigured =>
      supabaseUrl.trim().isNotEmpty && supabaseClientKey.trim().isNotEmpty;

  /// Default config for local runs. Override via `--dart-define` in CI/production.
  factory AppConfig.fromEnvironment() {
    const envName = String.fromEnvironment(
      'ENV',
      defaultValue: 'development',
    );
    const apiBaseUrl = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://dummyjson.com',
    );
    const authBackendName = String.fromEnvironment(
      'AUTH_BACKEND',
      defaultValue: 'dummyjson',
    );
    const appName = String.fromEnvironment(
      'APP_NAME',
      defaultValue: 'ADA',
    );
    const useFirebase = bool.fromEnvironment(
      'USE_FIREBASE',
      defaultValue: true,
    );
    const supabaseUrl = String.fromEnvironment(
      'SUPABASE_URL',
      defaultValue: 'https://fenywyyvxwebgihuqvyt.supabase.co',
    );
    const supabasePublishableKey = String.fromEnvironment(
      'SUPABASE_PUBLISHABLE_KEY',
      defaultValue: '',
    );
    const supabaseAnonKey = String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue: '',
    );
    final supabaseClientKey = supabasePublishableKey.isNotEmpty
        ? supabasePublishableKey
        : supabaseAnonKey;

    final environment = Environment.values.firstWhere(
      (e) => e.label == envName,
      orElse: () => Environment.development,
    );

    return AppConfig(
      environment: environment,
      appName: appName,
      apiBaseUrl: apiBaseUrl,
      enableRequestLogging: !environment.isProduction,
      useFirebase: useFirebase,
      authBackend: AuthBackendX.fromLabel(authBackendName),
      supabaseUrl: supabaseUrl,
      supabaseClientKey: supabaseClientKey,
    );
  }
}
