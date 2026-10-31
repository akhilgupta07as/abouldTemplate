import 'package:abould_ada/modules/api_integration/config/dummyjson_endpoints.dart';
import 'package:abould_ada/modules/api_integration/models/user_model.dart';
import 'package:abould_ada/modules/api_integration/services/dio_api_client.dart';

/// PUT requests against DummyJSON (simulated full replace — not persisted).
class ApiPutModule {
  ApiPutModule(this._client);

  final DioApiClient _client;

  Future<UserModel> replaceUser({
    required int id,
    required Map<String, dynamic> body,
  }) async {
    final response = await _client.put<Map<String, dynamic>>(
      DummyJsonEndpoints.userById(id),
      data: body,
    );
    return UserModel.fromJson(response.data ?? {});
  }
}
