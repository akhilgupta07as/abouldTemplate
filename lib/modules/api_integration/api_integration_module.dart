/// REST/API integration module — HTTP client, verb modules, DummyJSON APIs.

library;



export 'cache/products_cache.dart';

export 'config/dummyjson_endpoints.dart';

export 'data/dummyjson_auth_api.dart';

export 'data/dummyjson_products_api.dart';

export 'data/products_repository.dart';

export 'data/users_repository.dart';

export 'di/api_providers.dart';

export 'http/api_delete_module.dart';

export 'http/api_get_module.dart';

export 'http/api_patch_module.dart';

export 'http/api_post_module.dart';

export 'http/api_put_module.dart';

export 'models/paginated_result.dart';

export 'models/product_model.dart';

export 'models/user_model.dart';

export 'network/api_error_mapper.dart';

export 'network/token_refresh_interceptor.dart';

export 'services/dio_api_client.dart';

