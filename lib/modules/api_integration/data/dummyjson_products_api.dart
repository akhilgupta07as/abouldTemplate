import 'package:abould_ada/modules/api_integration/config/dummyjson_endpoints.dart';
import 'package:abould_ada/modules/api_integration/models/paginated_result.dart';
import 'package:abould_ada/modules/api_integration/models/product_model.dart';
import 'package:abould_ada/modules/api_integration/services/dio_api_client.dart';

class DummyJsonProductsApi {
  DummyJsonProductsApi(this._client);

  final DioApiClient _client;

  Future<PaginatedResult<ProductModel>> fetchProducts({
    required int limit,
    required int skip,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      DummyJsonEndpoints.products,
      queryParameters: {'limit': limit, 'skip': skip},
    );
    return _parse(response.data);
  }

  Future<PaginatedResult<ProductModel>> searchProducts({
    required String query,
    required int limit,
    required int skip,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      DummyJsonEndpoints.productsSearch,
      queryParameters: {'q': query, 'limit': limit, 'skip': skip},
    );
    return _parse(response.data);
  }

  PaginatedResult<ProductModel> _parse(Map<String, dynamic>? data) {
    if (data == null) {
      return const PaginatedResult(
        items: [],
        total: 0,
        skip: 0,
        limit: 0,
      );
    }
    final list = (data['products'] as List<dynamic>? ?? [])
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return PaginatedResult(
      items: list,
      total: data['total'] as int? ?? list.length,
      skip: data['skip'] as int? ?? 0,
      limit: data['limit'] as int? ?? list.length,
    );
  }
}
