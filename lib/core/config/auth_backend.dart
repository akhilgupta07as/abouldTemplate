enum AuthBackend {
  dummyJson,
  firebase,
  supabase,
}

extension AuthBackendX on AuthBackend {
  String get label => switch (this) {
        AuthBackend.dummyJson => 'dummyjson',
        AuthBackend.firebase => 'firebase',
        AuthBackend.supabase => 'supabase',
      };

  String get displayName => switch (this) {
        AuthBackend.dummyJson => 'API (DummyJSON)',
        AuthBackend.firebase => 'Firebase',
        AuthBackend.supabase => 'Supabase',
      };

  bool get supportsRegistration => this != AuthBackend.dummyJson;

  static AuthBackend fromLabel(String value) {
    return AuthBackend.values.firstWhere(
      (e) => e.label == value,
      orElse: () => AuthBackend.dummyJson,
    );
  }
}

const loginAuthBackendOptions = [
  AuthBackend.firebase,
  AuthBackend.supabase,
  AuthBackend.dummyJson,
];

const registrationAuthBackendOptions = [
  AuthBackend.firebase,
  AuthBackend.supabase,
];
