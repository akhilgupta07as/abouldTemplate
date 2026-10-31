import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Compresses picked images before upload (JPEG, max width, quality).
class ImageCompressionService {
  const ImageCompressionService();

  Future<File?> compressForUpload(
    String sourcePath, {
    int maxWidth = 1280,
    int quality = 82,
  }) async {
    if (sourcePath.isEmpty) return null;
    final source = File(sourcePath);
    if (!await source.exists()) return null;

    final dir = await getTemporaryDirectory();
    final targetPath = p.join(
      dir.path,
      'ada_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    final result = await FlutterImageCompress.compressAndGetFile(
      source.absolute.path,
      targetPath,
      quality: quality,
      minWidth: maxWidth,
      minHeight: maxWidth,
      format: CompressFormat.jpeg,
    );

    if (result == null) return null;
    return File(result.path);
  }
}
