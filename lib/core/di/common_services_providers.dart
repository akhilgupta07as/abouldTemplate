import 'package:abould_ada/core/services/image_compression_service.dart';
import 'package:abould_ada/core/services/location_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageCompressionServiceProvider = Provider<ImageCompressionService>(
  (ref) => const ImageCompressionService(),
);

final locationServiceProvider = Provider<LocationService>(
  (ref) => const LocationService(),
);
