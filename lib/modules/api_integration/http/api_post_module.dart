import 'package:abould_ada/modules/api_integration/config/dummyjson_endpoints.dart';
import 'package:abould_ada/modules/api_integration/models/user_model.dart';
import 'package:abould_ada/modules/api_integration/services/dio_api_client.dart';

/// POST requests against DummyJSON (simulated create — not persisted on server).
class ApiPostModule {
  ApiPostModule(this._client);

  final DioApiClient _client;

  Future<UserModel> addUser(Map<String, dynamic> body) async {
    final response = await _client.post<Map<String, dynamic>>(
      DummyJsonEndpoints.usersAdd,
      data: body,
    );
    return UserModel.fromJson(response.data ?? {});
  }

  Future<UserModel> addUserModel(UserModel draft) async {
    return addUser(draft.toJson());
  }
}
