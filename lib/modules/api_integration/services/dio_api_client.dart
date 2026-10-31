import 'package:abould_ada/core/config/app_config.dart';
import 'package:abould_ada/core/constants/app_constants.dart';
import 'package:abould_ada/core/errors/app_exception.dart';
import 'package:abould_ada/core/storage/secure_storage_service.dart';
import 'package:abould_ada/core/utils/app_logger.dart';
import 'package:abould_ada/modules/api_integration/network/api_error_mapper.dart';
import 'package:abould_ada/modules/api_integration/network/auth_interceptor.dart';
import 'package:abould_ada/modules/api_integration/network/logging_interceptor.dart';
import 'package:abould_ada/modules/api_integration/network/token_refresh_interceptor.dart';
import 'package:dio/dio.dart';

class DioApiClient {
  DioApiClient({
    required AppConfig config,
    required AppLogger logger,
    required SecureStorageService secureStorage,
  })  : _config = config,
        _dio = Dio(
          BaseOptions(
            baseUrl: config.apiBaseUrl,
            connectTimeout: const Duration(
              seconds: AppConstants.connectionTimeoutSeconds,
            ),
            receiveTimeout: const Duration(
              seconds: AppConstants.receiveTimeoutSeconds,
            ),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
  _dio.interceptors.add(AuthInterceptor(secureStorage));
    _dio.interceptors.add(
      TokenRefreshInterceptor(dio: _dio, secureStorage: secureStorage),
    );
    if (config.enableRequestLogging) {
      _dio.interceptors.add(LoggingInterceptor(logger));
    }
    logger.debug('DioApiClient ready (${config.apiBaseUrl})');
  }

  final AppConfig _config;
  final Dio _dio;

  Dio get dio => _dio;

  String get baseUrl => _config.apiBaseUrl;

  void validateConfiguration() {
    if (_config.apiBaseUrl.isEmpty) {
      throw const AppException(
        message: 'API base URL is not configured.',
        code: 'invalid_api_config',
      );
    }
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ApiErrorMapper.fromDio(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ApiErrorMapper.fromDio(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ApiErrorMapper.fromDio(e);
    }
  }

  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ApiErrorMapper.fromDio(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ApiErrorMapper.fromDio(e);
    }
  }

  /// Uploads a file using multipart form-data.
  Future<Response<T>> uploadFile<T>(
    String path, {
    required String filePath,
    required String fieldName,
    String? fileName,
    Map<String, dynamic>? extraFields,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final multipartFile = await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      );
      final formData = FormData.fromMap({
        fieldName: multipartFile,
        if (extraFields != null) ...extraFields,
      });

      return await _dio.post<T>(
        path,
        data: formData,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
      );
    } on DioException catch (e) {
      throw ApiErrorMapper.fromDio(e);
    }
  }

  /// Downloads a remote file to a local destination file path.
  Future<Response> downloadFile(
    String urlPath,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    try {
      return await _dio.download(
        urlPath,
        savePath,
        queryParameters: queryParameters,
        data: data,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw ApiErrorMapper.fromDio(e);
    }
  }
}
