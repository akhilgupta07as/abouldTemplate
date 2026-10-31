import 'package:abould_ada/modules/api_integration/models/product_model.dart';

class ProductsCacheSnapshot {
  const ProductsCacheSnapshot({
    required this.items,
    required this.page,
    required this.hasMore,
    required this.searchQuery,
    required this.updatedAt,
  });

  final List<ProductModel> items;
  final int page;
  final bool hasMore;
  final String searchQuery;
  final DateTime updatedAt;
}

/// In-memory cache for product list responses (per search query).
class ProductsCache {
  ProductsCache({this.maxAge = const Duration(minutes: 30)});

  final Duration maxAge;
  final _store = <String, ProductsCacheSnapshot>{};

  static String keyForQuery(String searchQuery) {
    final q = searchQuery.trim().toLowerCase();
    return q.isEmpty ? '__all__' : q;
  }

  ProductsCacheSnapshot? get(String searchQuery) {
    final entry = _store[keyForQuery(searchQuery)];
    if (entry == null) return null;
    if (DateTime.now().difference(entry.updatedAt) > maxAge) {
      _store.remove(keyForQuery(searchQuery));
      return null;
    }
    return entry;
  }

  void save({
    required String searchQuery,
    required List<ProductModel> items,
    required int page,
    required bool hasMore,
  }) {
    _store[keyForQuery(searchQuery)] = ProductsCacheSnapshot(
      items: List.unmodifiable(items),
      page: page,
      hasMore: hasMore,
      searchQuery: searchQuery,
      updatedAt: DateTime.now(),
    );
  }

  void clear() => _store.clear();
}
