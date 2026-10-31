import 'package:abould_ada/core/constants/storage_keys.dart';
import 'package:abould_ada/core/storage/secure_storage_service.dart';
import 'package:abould_ada/modules/api_integration/config/dummyjson_endpoints.dart';
import 'package:dio/dio.dart';

/// On 401, rotates DummyJSON tokens via `POST /auth/refresh` and retries once.
class TokenRefreshInterceptor extends QueuedInterceptor {
  TokenRefreshInterceptor({
    required Dio dio,
    required SecureStorageService secureStorage,
  })  : _dio = dio,
        _secureStorage = secureStorage;

  final Dio _dio;
  final SecureStorageService _secureStorage;

  static const _skipRefreshKey = 'skipTokenRefresh';

  Future<void>? _refreshInFlight;

  bool _shouldSkip(RequestOptions options) {
    if (options.extra[_skipRefreshKey] == true) {
      return true;
    }
    final path = options.path;
    return path.endsWith(DummyJsonEndpoints.login) ||
        path.endsWith(DummyJsonEndpoints.refresh);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final status = err.response?.statusCode;
    if (status != 401 || _shouldSkip(err.requestOptions)) {
      handler.next(err);
      return;
    }

    try {
      await _refreshTokens();
      final token = await _secureStorage.read(StorageKeys.accessToken);
      if (token == null || token.isEmpty) {
        handler.next(err);
        return;
      }

      final request = err.requestOptions;
      request.headers['Authorization'] = 'Bearer $token';
      request.extra[_skipRefreshKey] = true;

      final response = await _dio.fetch<dynamic>(request);
      handler.resolve(response);
    } catch (_) {
      await _clearTokens();
      handler.next(err);
    }
  }

  Future<void> _refreshTokens() async {
    if (_refreshInFlight != null) {
      return _refreshInFlight!;
    }
    _refreshInFlight = _performRefresh();
    try {
      await _refreshInFlight;
    } finally {
      _refreshInFlight = null;
    }
  }

  Future<void> _performRefresh() async {
    final refresh = await _secureStorage.read(StorageKeys.refreshToken);
    if (refresh == null || refresh.isEmpty) {
      throw StateError('No refresh token');
    }

    final response = await _dio.post<Map<String, dynamic>>(
      DummyJsonEndpoints.refresh,
      data: {'refreshToken': refresh, 'expiresInMins': 60},
      options: Options(extra: {_skipRefreshKey: true}),
    );

    final data = response.data;
    final access = data?['accessToken']?.toString();
    final newRefresh = data?['refreshToken']?.toString();
    if (access == null || access.isEmpty) {
      throw StateError('Refresh failed');
    }
    await _secureStorage.write(StorageKeys.accessToken, access);
    if (newRefresh != null && newRefresh.isNotEmpty) {
      await _secureStorage.write(StorageKeys.refreshToken, newRefresh);
    }
  }

  Future<void> _clearTokens() async {
    await _secureStorage.delete(StorageKeys.accessToken);
    await _secureStorage.delete(StorageKeys.refreshToken);
  }
}
