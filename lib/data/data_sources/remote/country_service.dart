import 'dart:convert';

import 'package:chat_app/data/models/country_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@lazySingleton
class RemoteDataSource {
  Future<List<CountryModel>> fetchCountries() async {
    final response = await http.get(
      Uri.parse("https://api.first.org/data/v1/countries"),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final data = jsonResponse['data'] as Map<String, dynamic>;

      return data.entries.map((entry) {
        return CountryModel.fromJson(entry.value);
      }).toList();
    } else {
      throw Exception("Failed to load countries");
    }
  }
}
