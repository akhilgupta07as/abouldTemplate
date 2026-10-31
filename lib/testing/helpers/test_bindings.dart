import 'package:abould_ada/core/bindings/app_bindings.dart';
import 'package:abould_ada/core/di/localization_providers.dart';
import 'package:abould_ada/testing/fakes/fake_translation_client.dart';
import 'package:abould_ada/core/config/app_config.dart';
import 'package:abould_ada/modules/authentication/data/fake_auth_repository.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/core/services/connectivity_service.dart';
import 'package:abould_ada/testing/fakes/in_memory_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Override>> testBindings() async {
  SharedPreferences.setMockInitialValues({});
  const testConfig = AppConfig(
    environment: Environment.development,
    appName: 'ADA',
    apiBaseUrl: 'https://dummyjson.com',
    useFirebase: false,
    authBackend: AuthBackend.dummyJson,
  );
  final inMemorySecure = InMemorySecureStorage();
  final overrides = await AppBindings.initialize(
    configOverride: testConfig,
    secureStorageOverride: inMemorySecure,
    restoreAuthSession: false,
  );
  return [
    ...overrides,
    secureStorageProvider.overrideWithValue(inMemorySecure),
    connectivityServiceProvider.overrideWithValue(FakeConnectivityService()),
    authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
    translationClientProvider.overrideWithValue(FakeTranslationClient()),
  ];
}
