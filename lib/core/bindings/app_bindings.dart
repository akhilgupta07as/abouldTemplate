import 'package:abould_ada/core/config/app_config.dart';
import 'package:abould_ada/core/config/app_config_loader.dart';
import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/core/services/connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:abould_ada/core/storage/local_storage_service.dart';
import 'package:abould_ada/core/storage/secure_storage_service.dart';
import 'package:abould_ada/core/utils/app_logger.dart';
import 'package:abould_ada/modules/api_integration/data/dummyjson_auth_api.dart';
import 'package:abould_ada/modules/api_integration/services/dio_api_client.dart';
import 'package:abould_ada/modules/authentication/data/dummyjson_auth_repository.dart';
import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/modules/firebase/di/firebase_providers.dart';
import 'package:abould_ada/modules/firebase/firebase_bootstrap.dart';
import 'package:abould_ada/modules/firebase/firebase_initializer.dart';
import 'package:abould_ada/modules/supabase/di/supabase_providers.dart';
import 'package:abould_ada/modules/supabase/supabase_initializer.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    hide SharedPreferencesLocalStorage;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBindings {
  AppBindings._();

  static Future<List<Override>> initialize({
    AppConfig? configOverride,
    SecureStorageService? secureStorageOverride,
    bool restoreAuthSession = true,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    final config = await AppConfigLoader.resolve(override: configOverride);
    final logger = AppLogger(config);
    logger.info('Abould ADA bootstrap (${config.environment.label})');

    FirebaseServices firebaseServices;
    if (config.useFirebase) {
      await FirebaseInitializer.initialize(logger);
      firebaseServices = await FirebaseBootstrap.configure(
        config: config,
        logger: logger,
      );
    } else {
      logger.info('Firebase disabled (USE_FIREBASE=false)');
      firebaseServices = FirebaseServices.noop();
    }

    final prefs = await SharedPreferences.getInstance();
    final localStorage = SharedPreferencesLocalStorage(prefs);
    final secureStorage =
        secureStorageOverride ?? FlutterSecureStorageService();
    final dioClient = DioApiClient(
      config: config,
      logger: logger,
      secureStorage: secureStorage,
    )..validateConfiguration();

    final supabaseReady = await SupabaseInitializer.initialize(
      config: config,
      logger: logger,
    );
    final supabaseClient =
        supabaseReady ? Supabase.instance.client : null;

    final dummyAuthApi = DummyJsonAuthApi(dioClient);
    final authRegistry = createAuthRepositoryRegistry(
      config: config,
      secureStorage: secureStorage,
      dummyJsonAuthApi: dummyAuthApi,
      supabaseReady: supabaseReady,
      supabaseClient: supabaseClient,
    );

    AuthBackend? sessionBackend;
    AuthBackend loginPreference = config.authBackend;
    if (restoreAuthSession) {
      sessionBackend = await readStoredSessionBackend(localStorage);
      loginPreference = await readStoredLoginPreference(
        localStorage,
        config.authBackend,
      );
      if (sessionBackend == AuthBackend.dummyJson &&
          authRegistry.dummyJson is DummyJsonAuthRepository) {
        await (authRegistry.dummyJson as DummyJsonAuthRepository).initialize();
      }
    }

    final connectivity = ConnectivityPlusService(Connectivity());

    return [
      appConfigProvider.overrideWithValue(config),
      appLoggerProvider.overrideWithValue(logger),
      localStorageProvider.overrideWithValue(localStorage),
      secureStorageProvider.overrideWithValue(secureStorage),
      dioApiClientProvider.overrideWithValue(dioClient),
      authRepositoryRegistryProvider.overrideWithValue(authRegistry),
      authSessionBackendProvider.overrideWith((ref) => sessionBackend),
      loginAuthBackendProvider.overrideWith((ref) => loginPreference),
      firebaseServicesProvider.overrideWithValue(firebaseServices),
      connectivityServiceProvider.overrideWithValue(connectivity),
      supabaseReadyProvider.overrideWithValue(supabaseReady),
    ];
  }
}
