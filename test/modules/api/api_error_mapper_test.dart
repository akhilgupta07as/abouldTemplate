import 'package:abould_ada/modules/api_integration/network/api_error_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiErrorMapper', () {
    test('maps connection timeout', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionTimeout,
      );

      final appEx = ApiErrorMapper.fromDio(dioError);
      expect(appEx.code, 'timeout');
      expect(appEx.message, contains('timed out'));
    });

    test('maps connection error / network issue', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.connectionError,
      );

      final appEx = ApiErrorMapper.fromDio(dioError);
      expect(appEx.code, 'network');
      expect(appEx.message, 'No internet connection.');
    });

    test('maps 401 unauthorized', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 401,
        ),
      );

      final appEx = ApiErrorMapper.fromDio(dioError);
      expect(appEx.code, 'unauthorized');
      expect(appEx.message, contains('Invalid username or password'));
    });

    test('extracts custom error message from JSON response', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 400,
          data: {'message': 'Custom API validation failure.'},
        ),
      );

      final appEx = ApiErrorMapper.fromDio(dioError);
      expect(appEx.message, 'Custom API validation failure.');
    });
  });
}
