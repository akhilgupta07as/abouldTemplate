import 'package:abould_ada/core/config/app_config.dart';
import 'package:abould_ada/core/services/connectivity_service.dart';
import 'package:abould_ada/core/storage/local_storage_service.dart';
import 'package:abould_ada/core/storage/secure_storage_service.dart';
import 'package:abould_ada/core/utils/app_logger.dart';
import 'package:abould_ada/modules/api_integration/services/dio_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appConfigProvider = Provider<AppConfig>(
  (ref) => throw UnimplementedError(
    'Call AppBindings.initialize() before runApp.',
  ),
);

final appLoggerProvider = Provider<AppLogger>(
  (ref) => throw UnimplementedError(
    'Call AppBindings.initialize() before runApp.',
  ),
);

final localStorageProvider = Provider<LocalStorageService>(
  (ref) => throw UnimplementedError(
    'Call AppBindings.initialize() before runApp.',
  ),
);

final secureStorageProvider = Provider<SecureStorageService>(
  (ref) => throw UnimplementedError(
    'Call AppBindings.initialize() before runApp.',
  ),
);

final dioApiClientProvider = Provider<DioApiClient>(
  (ref) => throw UnimplementedError(
    'Call AppBindings.initialize() before runApp.',
  ),
);

/// Legacy alias — prefer [dioApiClientProvider].
@Deprecated('Use dioApiClientProvider')
final apiClientProvider = dioApiClientProvider;

final connectivityServiceProvider = Provider<ConnectivityService>(
  (ref) => throw UnimplementedError(
    'Call AppBindings.initialize() before runApp.',
  ),
);

final isOnlineProvider = StreamProvider<bool>((ref) {
  return ref.watch(connectivityServiceProvider).onConnected;
});
