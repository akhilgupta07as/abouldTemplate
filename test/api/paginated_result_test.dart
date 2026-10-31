import 'package:abould_ada/modules/api_integration/models/paginated_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaginatedResult.hasMore', () {
    test('true when more items exist on server', () {
      const page = PaginatedResult<int>(
        items: [1, 2, 3],
        total: 10,
        skip: 0,
        limit: 3,
      );
      expect(page.hasMore, isTrue);
    });

    test('false when all items loaded', () {
      const page = PaginatedResult<int>(
        items: [1, 2],
        total: 2,
        skip: 0,
        limit: 10,
      );
      expect(page.hasMore, isFalse);
    });
  });
}
