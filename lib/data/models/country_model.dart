// data/models/country_model.dart
import '../../domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  CountryModel({required super.name});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(name: json['country']);
  }
}
