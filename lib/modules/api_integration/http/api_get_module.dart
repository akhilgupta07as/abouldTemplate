import 'package:abould_ada/modules/api_integration/config/dummyjson_endpoints.dart';
import 'package:abould_ada/modules/api_integration/models/paginated_result.dart';
import 'package:abould_ada/modules/api_integration/models/user_model.dart';
import 'package:abould_ada/modules/api_integration/services/dio_api_client.dart';

/// GET requests against DummyJSON (users, search, filter, single resource).
class ApiGetModule {
  ApiGetModule(this._client);

  final DioApiClient _client;

  Future<PaginatedResult<UserModel>> fetchUsers({
    int limit = 10,
    int skip = 0,
    String? select,
    String? sortBy,
    String? order,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      DummyJsonEndpoints.users,
      queryParameters: {
        'limit': limit,
        'skip': skip,
        if (select != null) 'select': select,
        if (sortBy != null) 'sortBy': sortBy,
        if (order != null) 'order': order,
      },
    );
    return _parseUsersPage(response.data);
  }

  Future<UserModel> fetchUserById(int id) async {
    final response = await _client.get<Map<String, dynamic>>(
      DummyJsonEndpoints.userById(id),
    );
    return UserModel.fromJson(response.data ?? {});
  }

  Future<PaginatedResult<UserModel>> searchUsers({
    required String query,
    int limit = 10,
    int skip = 0,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      DummyJsonEndpoints.usersSearch,
      queryParameters: {'q': query, 'limit': limit, 'skip': skip},
    );
    return _parseUsersPage(response.data);
  }

  Future<PaginatedResult<UserModel>> filterUsers({
    required String key,
    required String value,
    int limit = 10,
    int skip = 0,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      DummyJsonEndpoints.usersFilter,
      queryParameters: {
        'key': key,
        'value': value,
        'limit': limit,
        'skip': skip,
      },
    );
    return _parseUsersPage(response.data);
  }

  PaginatedResult<UserModel> _parseUsersPage(Map<String, dynamic>? data) {
    if (data == null) {
      return const PaginatedResult(
        items: [],
        total: 0,
        skip: 0,
        limit: 0,
      );
    }
    final list = (data['users'] as List<dynamic>? ?? [])
        .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return PaginatedResult(
      items: list,
      total: data['total'] as int? ?? list.length,
      skip: data['skip'] as int? ?? 0,
      limit: data['limit'] as int? ?? list.length,
    );
  }
}
