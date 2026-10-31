import 'package:abould_ada/modules/api_integration/data/dummyjson_products_api.dart';
import 'package:abould_ada/modules/api_integration/models/paginated_result.dart';
import 'package:abould_ada/modules/api_integration/models/product_model.dart';

class ProductsRepository {
  ProductsRepository(this._api);

  final DummyJsonProductsApi _api;

  Future<PaginatedResult<ProductModel>> getProducts({
    required int page,
    required int limit,
    String? searchQuery,
  }) async {
    final skip = page * limit;
    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      return _api.searchProducts(
        query: searchQuery.trim(),
        limit: limit,
        skip: skip,
      );
    }
    return _api.fetchProducts(limit: limit, skip: skip);
  }
}
