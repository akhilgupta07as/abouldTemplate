import 'package:abould_ada/core/services/image_compression_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = ImageCompressionService();

  test('compressForUpload returns null for missing file', () async {
    final result = await service.compressForUpload('');
    expect(result, isNull);
  });

  test('compressForUpload returns null for non-existent path', () async {
    final result =
        await service.compressForUpload(r'C:\no_such_file_ada_test.jpg');
    expect(result, isNull);
  });
}
