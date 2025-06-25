import 'package:chat_app/domain/entities/country_entity.dart';
import 'package:chat_app/domain/repositories/country_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCountryNames {
  final CountryRepository repository;

  GetCountryNames(this.repository);

  Future<List<CountryEntity>> call() async {
    return await repository.getCountryNames();
  }
}
