import 'package:abould_ada/modules/api_integration/config/dummyjson_endpoints.dart';
import 'package:abould_ada/modules/api_integration/services/dio_api_client.dart';

class DummyJsonAuthApi {
  DummyJsonAuthApi(this._client);

  final DioApiClient _client;

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
    int expiresInMins = 60,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      DummyJsonEndpoints.login,
      data: {
        'username': username,
        'password': password,
        'expiresInMins': expiresInMins,
      },
    );
    return response.data ?? {};
  }

  Future<Map<String, dynamic>> getMe() async {
    final response = await _client.get<Map<String, dynamic>>(
      DummyJsonEndpoints.me,
    );
    return response.data ?? {};
  }

  Future<Map<String, dynamic>> refresh({
    required String refreshToken,
    int expiresInMins = 60,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      DummyJsonEndpoints.refresh,
      data: {
        'refreshToken': refreshToken,
        'expiresInMins': expiresInMins,
      },
    );
    return response.data ?? {};
  }
}
