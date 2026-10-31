import 'package:abould_ada/modules/api_integration/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ProductModel.fromJson parses DummyJSON shape', () {
    final product = ProductModel.fromJson({
      'id': 1,
      'title': 'iPhone 9',
      'description': 'An apple mobile',
      'price': 549,
      'thumbnail': 'https://cdn.dummyjson.com/product-images/1/thumbnail.jpg',
      'brand': 'Apple',
      'category': 'smartphones',
    });

    expect(product.id, 1);
    expect(product.title, 'iPhone 9');
    expect(product.price, 549);
  });
}
