import 'package:abould_ada/core/config/app_config.dart';
import 'package:abould_ada/core/constants/storage_keys.dart';
import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/core/storage/local_storage_service.dart';
import 'package:abould_ada/core/storage/secure_storage_service.dart';
import 'package:abould_ada/modules/api_integration/data/dummyjson_auth_api.dart';
import 'package:abould_ada/modules/authentication/data/auth_repository_registry.dart';
import 'package:abould_ada/modules/authentication/data/dummyjson_auth_repository.dart';
import 'package:abould_ada/modules/authentication/data/fake_auth_repository.dart';
import 'package:abould_ada/modules/authentication/data/firebase_auth_repository.dart';
import 'package:abould_ada/modules/authentication/data/supabase_auth_repository.dart';
import 'package:abould_ada/modules/authentication/data/unavailable_auth_repository.dart';
import 'package:abould_ada/modules/authentication/domain/auth_repository.dart';
import 'package:abould_ada/modules/authentication/domain/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

export 'package:abould_ada/core/config/auth_backend.dart'
    show AuthBackend, AuthBackendX;

final authRepositoryRegistryProvider = Provider<AuthRepositoryRegistry>(
  (ref) => throw UnimplementedError('Register AuthRepositoryRegistry in AppBindings.'),
);

/// Active session backend when signed in; otherwise null.
final authSessionBackendProvider = StateProvider<AuthBackend?>(
  (ref) => null,
);

/// Login screen method picker (Firebase / Supabase / API).
final loginAuthBackendProvider = StateProvider<AuthBackend>(
  (ref) => AuthBackend.dummyJson,
);

/// Registration screen method picker (Firebase / Supabase only).
final registrationAuthBackendProvider = StateProvider<AuthBackend>(
  (ref) => AuthBackend.firebase,
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final registry = ref.watch(authRepositoryRegistryProvider);
  final sessionBackend = ref.watch(authSessionBackendProvider);
  if (sessionBackend != null) {
    return registry.resolve(sessionBackend);
  }
  final loginPick = ref.watch(loginAuthBackendProvider);
  return registry.resolve(loginPick);
});

final authStateProvider = StreamProvider<AuthUser?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

final currentAuthUserProvider = Provider<AuthUser?>((ref) {
  return ref.watch(authStateProvider).valueOrNull ??
      ref.watch(authRepositoryProvider).currentUser;
});

AuthRepositoryRegistry createAuthRepositoryRegistry({
  required AppConfig config,
  required SecureStorageService secureStorage,
  required DummyJsonAuthApi dummyJsonAuthApi,
  required bool supabaseReady,
  SupabaseClient? supabaseClient,
}) {
  final dummyJson = DummyJsonAuthRepository(
    authApi: dummyJsonAuthApi,
    secureStorage: secureStorage,
  );

  final firebase = config.useFirebase
      ? FirebaseAuthRepository(FirebaseAuth.instance)
      : UnavailableAuthRepository(
          'Firebase is disabled in this build. Run with --dart-define=USE_FIREBASE=true.',
        );

  final AuthRepository supabase;
  if (supabaseReady && supabaseClient != null) {
    supabase = SupabaseAuthRepository(supabaseClient);
  } else if (config.isSupabaseConfigured) {
    supabase = UnavailableAuthRepository(
      'Supabase keys are set but initialization failed. Check URL, anon key, and network.',
    );
  } else {
    supabase = UnavailableAuthRepository(
      'Supabase is not configured. Use --dart-define-from-file=dart_defines/supabase.local.json '
      'or SUPABASE_PUBLISHABLE_KEY / SUPABASE_ANON_KEY (see docs/SUPABASE.md).',
    );
  }

  return AuthRepositoryRegistry(
    dummyJson: dummyJson,
    firebase: firebase,
    supabase: supabase,
  );
}

extension AuthSessionPersistence on WidgetRef {
  Future<void> persistAuthSessionBackend(AuthBackend backend) async {
    read(authSessionBackendProvider.notifier).state = backend;
    await read(localStorageProvider).setString(
          StorageKeys.authSessionBackend,
          backend.label,
        );
  }

  Future<void> persistLoginPreference(AuthBackend backend) async {
    read(loginAuthBackendProvider.notifier).state = backend;
    await read(localStorageProvider).setString(
          StorageKeys.authLoginPreference,
          backend.label,
        );
  }

  Future<void> clearAuthSession() async {
    read(authSessionBackendProvider.notifier).state = null;
    await read(localStorageProvider).remove(StorageKeys.authSessionBackend);
  }
}

Future<AuthBackend?> readStoredSessionBackend(
  LocalStorageService storage,
) async {
  final label = await storage.getString(StorageKeys.authSessionBackend);
  if (label == null || label.isEmpty) return null;
  return AuthBackendX.fromLabel(label);
}

Future<AuthBackend> readStoredLoginPreference(
  LocalStorageService storage,
  AuthBackend fallback,
) async {
  final label = await storage.getString(StorageKeys.authLoginPreference);
  if (label == null || label.isEmpty) return fallback;
  return AuthBackendX.fromLabel(label);
}

/// Legacy helper — prefer [createAuthRepositoryRegistry].
AuthRepository createAuthRepository({
  required AppConfig config,
  required SecureStorageService secureStorage,
  DummyJsonAuthApi? dummyJsonAuthApi,
}) {
  if (config.authBackend == AuthBackend.dummyJson && dummyJsonAuthApi != null) {
    return DummyJsonAuthRepository(
      authApi: dummyJsonAuthApi,
      secureStorage: secureStorage,
    );
  }
  if (config.useFirebase) {
    return FirebaseAuthRepository(FirebaseAuth.instance);
  }
  return FakeAuthRepository();
}
