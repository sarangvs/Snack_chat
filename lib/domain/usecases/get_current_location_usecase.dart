import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentLocation {
  final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;

  Future<Position> call() async {
    final permission = await _geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await _geolocator.requestPermission();
    }
    return await _geolocator.getCurrentPosition();
  }
}
