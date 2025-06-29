import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../repositories/map_repository.dart';

@injectable
class GetNearbyWaterBodies {
  final MapRepository repository;

  GetNearbyWaterBodies(this.repository);

  Future<List<LatLng>> call(double lat, double lng) {
    return repository.getNearbyWaterBodies(lat, lng);
  }
}
