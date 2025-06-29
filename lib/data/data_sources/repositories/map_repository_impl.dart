import 'dart:convert';

import 'package:chat_app/domain/repositories/map_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapRepositoryImpl implements MapRepository {
  final String apiKey;

  MapRepositoryImpl(this.apiKey);

  @override
  Future<List<LatLng>> getNearbyWaterBodies(double lat, double lng) async {
    const radius = 2000;
    const keyword = 'lake|pond';

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
      '?location=$lat,$lng'
      '&radius=$radius'
      '&type=natural_feature'
      '&keyword=$keyword'
      '&key=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;

      return results.map((e) {
        final loc = e['geometry']['location'];
        return LatLng(loc['lat'], loc['lng']);
      }).toList();
    } else {
      throw Exception('Failed to fetch nearby water bodies');
    }
  }
}
