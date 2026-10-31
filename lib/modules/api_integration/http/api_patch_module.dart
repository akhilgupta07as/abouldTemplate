import 'package:abould_ada/modules/api_integration/config/dummyjson_endpoints.dart';
import 'package:abould_ada/modules/api_integration/models/user_model.dart';
import 'package:abould_ada/modules/api_integration/services/dio_api_client.dart';

/// PATCH requests against DummyJSON (simulated partial update — not persisted).
class ApiPatchModule {
  ApiPatchModule(this._client);

  final DioApiClient _client;

  Future<UserModel> patchUser({
    required int id,
    required Map<String, dynamic> body,
  }) async {
    final response = await _client.patch<Map<String, dynamic>>(
      DummyJsonEndpoints.userById(id),
      data: body,
    );
    return UserModel.fromJson(response.data ?? {});
  }
}
