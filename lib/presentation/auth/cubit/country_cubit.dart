import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/entities/country_entity.dart';
import 'package:chat_app/domain/usecases/get_country_names.dart';
import 'package:injectable/injectable.dart';

part 'country_state.dart';

@injectable
class CountryCubit extends Cubit<CountryState> {
  final GetCountryNames getCountryNames;
  CountryCubit(this.getCountryNames) : super(CountryInitial());

  Future<void> loadCountries() async {
    emit(CountryLoading());

    try {
      final countries = await getCountryNames();
      emit(CountryLoaded(countries));
    } catch (e) {
      emit(CountryError("Failed to load countries"));
    }
  }
}
