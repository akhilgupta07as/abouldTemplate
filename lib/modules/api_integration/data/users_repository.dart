import 'package:abould_ada/modules/api_integration/http/api_delete_module.dart';
import 'package:abould_ada/modules/api_integration/http/api_get_module.dart';
import 'package:abould_ada/modules/api_integration/http/api_patch_module.dart';
import 'package:abould_ada/modules/api_integration/http/api_post_module.dart';
import 'package:abould_ada/modules/api_integration/http/api_put_module.dart';
import 'package:abould_ada/modules/api_integration/models/paginated_result.dart';
import 'package:abould_ada/modules/api_integration/models/user_model.dart';

/// Facade over verb-specific DummyJSON user modules.
class UsersRepository {
  UsersRepository({
    required ApiGetModule getModule,
    required ApiPostModule postModule,
    required ApiPutModule putModule,
    required ApiPatchModule patchModule,
    required ApiDeleteModule deleteModule,
  })  : _get = getModule,
        _post = postModule,
        _put = putModule,
        _patch = patchModule,
        _delete = deleteModule;

  final ApiGetModule _get;
  final ApiPostModule _post;
  final ApiPutModule _put;
  final ApiPatchModule _patch;
  final ApiDeleteModule _delete;

  Future<PaginatedResult<UserModel>> listUsers({
    int limit = 10,
    int skip = 0,
  }) =>
      _get.fetchUsers(limit: limit, skip: skip);

  Future<UserModel> getUser(int id) => _get.fetchUserById(id);

  Future<UserModel> createUser({
    required String firstName,
    required String lastName,
    int? age,
  }) =>
      _post.addUser({
        'firstName': firstName,
        'lastName': lastName,
        if (age != null) 'age': age,
      });

  Future<UserModel> replaceUser({
    required int id,
    required Map<String, dynamic> body,
  }) =>
      _put.replaceUser(id: id, body: body);

  Future<UserModel> updateUser({
    required int id,
    required Map<String, dynamic> body,
  }) =>
      _patch.patchUser(id: id, body: body);

  Future<UserModel> removeUser(int id) => _delete.deleteUser(id);
}
