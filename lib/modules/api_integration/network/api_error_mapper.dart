import 'package:abould_ada/core/errors/app_exception.dart';
import 'package:dio/dio.dart';

abstract final class ApiErrorMapper {
  static AppException fromDio(DioException error) {
    final response = error.response;
    final data = response?.data;

    String message = 'Network request failed.';
    String? code = error.type.name;

    if (data is Map && data['message'] != null) {
      message = data['message'].toString();
    } else if (response?.statusMessage != null) {
      message = response!.statusMessage!;
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        message = 'Request timed out. Please try again.';
        code = 'timeout';
      case DioExceptionType.connectionError:
        message = 'No internet connection.';
        code = 'network';
      default:
        break;
    }

    if (response?.statusCode == 401) {
      message = 'Invalid username or password.';
      code = 'unauthorized';
    }

    return AppException(message: message, code: code, cause: error);
  }
}
