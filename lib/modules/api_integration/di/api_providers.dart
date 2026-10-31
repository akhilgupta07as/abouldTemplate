import 'package:abould_ada/core/di/providers.dart';
import 'package:abould_ada/modules/api_integration/data/dummyjson_auth_api.dart';
import 'package:abould_ada/modules/api_integration/data/dummyjson_products_api.dart';
import 'package:abould_ada/modules/api_integration/cache/products_cache.dart';
import 'package:abould_ada/modules/api_integration/data/products_repository.dart';
import 'package:abould_ada/modules/api_integration/data/users_repository.dart';
import 'package:abould_ada/modules/api_integration/http/api_delete_module.dart';
import 'package:abould_ada/modules/api_integration/http/api_get_module.dart';
import 'package:abould_ada/modules/api_integration/http/api_patch_module.dart';
import 'package:abould_ada/modules/api_integration/http/api_post_module.dart';
import 'package:abould_ada/modules/api_integration/http/api_put_module.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsCacheProvider = Provider<ProductsCache>((ref) {
  ref.keepAlive();
  return ProductsCache();
});

final dummyJsonAuthApiProvider = Provider<DummyJsonAuthApi>(
  (ref) => DummyJsonAuthApi(ref.watch(dioApiClientProvider)),
);

final dummyJsonProductsApiProvider = Provider<DummyJsonProductsApi>(
  (ref) => DummyJsonProductsApi(ref.watch(dioApiClientProvider)),
);

final productsRepositoryProvider = Provider<ProductsRepository>(
  (ref) => ProductsRepository(ref.watch(dummyJsonProductsApiProvider)),
);

final apiGetModuleProvider = Provider<ApiGetModule>(
  (ref) => ApiGetModule(ref.watch(dioApiClientProvider)),
);

final apiPostModuleProvider = Provider<ApiPostModule>(
  (ref) => ApiPostModule(ref.watch(dioApiClientProvider)),
);

final apiPutModuleProvider = Provider<ApiPutModule>(
  (ref) => ApiPutModule(ref.watch(dioApiClientProvider)),
);

final apiPatchModuleProvider = Provider<ApiPatchModule>(
  (ref) => ApiPatchModule(ref.watch(dioApiClientProvider)),
);

final apiDeleteModuleProvider = Provider<ApiDeleteModule>(
  (ref) => ApiDeleteModule(ref.watch(dioApiClientProvider)),
);

final usersRepositoryProvider = Provider<UsersRepository>(
  (ref) => UsersRepository(
    getModule: ref.watch(apiGetModuleProvider),
    postModule: ref.watch(apiPostModuleProvider),
    putModule: ref.watch(apiPutModuleProvider),
    patchModule: ref.watch(apiPatchModuleProvider),
    deleteModule: ref.watch(apiDeleteModuleProvider),
  ),
);
