/// Supported runtime environments for API and feature flags.
enum Environment {
  development,
  staging,
  production;

  bool get isDevelopment => this == Environment.development;
  bool get isProduction => this == Environment.production;

  String get label => switch (this) {
        Environment.development => 'development',
        Environment.staging => 'staging',
        Environment.production => 'production',
      };
}
