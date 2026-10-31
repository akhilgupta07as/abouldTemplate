import 'package:abould_ada/modules/api_integration/config/dummyjson_endpoints.dart';
import 'package:abould_ada/modules/api_integration/models/user_model.dart';
import 'package:abould_ada/modules/api_integration/services/dio_api_client.dart';

/// DELETE requests against DummyJSON (simulated delete — not persisted).
class ApiDeleteModule {
  ApiDeleteModule(this._client);

  final DioApiClient _client;

  Future<UserModel> deleteUser(int id) async {
    final response = await _client.delete<Map<String, dynamic>>(
      DummyJsonEndpoints.userById(id),
    );
    return UserModel.fromJson(response.data ?? {});
  }
}
