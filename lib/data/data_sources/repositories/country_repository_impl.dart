import 'package:chat_app/data/data_sources/remote/country_service.dart';
import 'package:chat_app/domain/entities/country_entity.dart';
import 'package:chat_app/domain/repositories/country_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CountryRepository)
class CountryRepositoryImpl implements CountryRepository {
  final RemoteDataSource remoteDataSource;

  CountryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CountryEntity>> getCountryNames() async {
    return await remoteDataSource.fetchCountries();
  }
}
