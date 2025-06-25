import 'package:chat_app/domain/entities/country_model.dart';

abstract class CountryRepository {
  Future<List<Country>> getCountries();
}
