import 'package:abould_ada/modules/api_integration/cache/products_cache.dart';
import 'package:abould_ada/modules/api_integration/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ProductsCache returns saved snapshot for search key', () {
    final cache = ProductsCache();
    const product = ProductModel(
      id: 1,
      title: 'Test',
      description: 'd',
      price: 1,
      thumbnail: 't',
      brand: 'b',
      category: 'c',
    );

    cache.save(
      searchQuery: 'phone',
      items: const [product],
      page: 0,
      hasMore: true,
    );

    final snap = cache.get('phone');
    expect(snap, isNotNull);
    expect(snap!.items.single.title, 'Test');
    expect(snap.hasMore, isTrue);
  });

  test('ProductsCache uses separate keys for search vs all', () {
    final cache = ProductsCache();
    cache.save(
      searchQuery: '',
      items: const [],
      page: 0,
      hasMore: false,
    );
    expect(cache.get(''), isNotNull);
    expect(cache.get('other'), isNull);
  });
}
