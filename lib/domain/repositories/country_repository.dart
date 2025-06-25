import 'package:chat_app/domain/entities/country_entity.dart';

abstract class CountryRepository {
  Future<List<CountryEntity>> getCountryNames();
}
