import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationReadResult {
  const LocationReadResult.success(this.position)
      : errorMessage = null,
        permissionDenied = false;

  const LocationReadResult.permissionDenied()
      : position = null,
        errorMessage = null,
        permissionDenied = true;

  const LocationReadResult.failure(this.errorMessage)
      : position = null,
        permissionDenied = false;

  final Position? position;
  final String? errorMessage;
  final bool permissionDenied;
}

class LocationService {
  const LocationService();

  Future<LocationReadResult> getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const LocationReadResult.failure('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      return const LocationReadResult.permissionDenied();
    }
    if (permission == LocationPermission.deniedForever) {
      await openAppSettings();
      return const LocationReadResult.permissionDenied();
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 15),
        ),
      );
      return LocationReadResult.success(position);
    } catch (e) {
      return LocationReadResult.failure(e.toString());
    }
  }
}
