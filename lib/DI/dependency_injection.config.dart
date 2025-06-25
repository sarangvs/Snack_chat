// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chat_app/presentation/auth/bloc/auth_bloc.dart' as _i1053;
import 'package:chat_app/presentation/home/bloc/home_bloc.dart' as _i432;
import 'package:chat_app/presentation/splash/bloc/splash_cubit.dart' as _i154;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i432.HomeBloc>(() => _i432.HomeBloc());
    gh.factory<_i154.SplashCubit>(() => _i154.SplashCubit());
    gh.factory<_i1053.AuthBloc>(() => _i1053.AuthBloc());
    return this;
  }
}
