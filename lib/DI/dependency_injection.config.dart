// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chat_app/data/data_sources/firebase/firebase_messaging_data_source.dart'
    as _i537;
import 'package:chat_app/data/data_sources/local/user_local_datasource.dart'
    as _i862;
import 'package:chat_app/data/data_sources/remote/country_service.dart'
    as _i990;
import 'package:chat_app/data/data_sources/repositories/country_repository_impl.dart'
    as _i587;
import 'package:chat_app/data/data_sources/repositories/message_repository_impl.dart'
    as _i567;
import 'package:chat_app/data/data_sources/repositories/user_repository_impl.dart'
    as _i845;
import 'package:chat_app/DI/app_module.dart' as _i584;
import 'package:chat_app/domain/repositories/country_repository.dart' as _i236;
import 'package:chat_app/domain/repositories/message_repository.dart' as _i747;
import 'package:chat_app/domain/repositories/user_repository.dart' as _i390;
import 'package:chat_app/domain/usecases/get_country_names.dart' as _i385;
import 'package:chat_app/domain/usecases/get_device_token_usecase.dart'
    as _i1054;
import 'package:chat_app/domain/usecases/login_user.dart' as _i680;
import 'package:chat_app/domain/usecases/register_user.dart' as _i841;
import 'package:chat_app/domain/usecases/send_message_usecase.dart' as _i40;
import 'package:chat_app/presentation/auth/bloc/auth_bloc.dart' as _i1053;
import 'package:chat_app/presentation/auth/cubit/country_cubit.dart' as _i761;
import 'package:chat_app/presentation/home/bloc/home_bloc.dart' as _i432;
import 'package:chat_app/presentation/splash/bloc/splash_cubit.dart' as _i154;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i432.HomeBloc>(() => _i432.HomeBloc());
    gh.factory<_i154.SplashCubit>(() => _i154.SplashCubit());
    gh.lazySingleton<_i990.RemoteDataSource>(() => _i990.RemoteDataSource());
    gh.lazySingleton<_i892.FirebaseMessaging>(
      () => appModule.firebaseMessaging,
    );
    gh.lazySingleton<_i537.FirebaseMessagingDataSource>(
      () =>
          _i537.FirebaseMessagingDataSourceImpl(gh<_i892.FirebaseMessaging>()),
    );
    gh.lazySingleton<_i862.UserLocalDatasource>(
      () => _i862.UserLocalDatasourceImpl(),
    );
    gh.lazySingleton<_i747.MessageRepository>(
      () =>
          _i567.MessageRepositoryImpl(gh<_i537.FirebaseMessagingDataSource>()),
    );
    gh.lazySingleton<_i236.CountryRepository>(
      () => _i587.CountryRepositoryImpl(gh<_i990.RemoteDataSource>()),
    );
    gh.factory<_i385.GetCountryNames>(
      () => _i385.GetCountryNames(gh<_i236.CountryRepository>()),
    );
    gh.factory<_i761.CountryCubit>(
      () => _i761.CountryCubit(gh<_i385.GetCountryNames>()),
    );
    gh.lazySingleton<_i390.UserRepository>(
      () => _i845.UserRepositoryImpl(gh<_i862.UserLocalDatasource>()),
    );
    gh.factory<_i1054.GetDeviceTokenUseCase>(
      () => _i1054.GetDeviceTokenUseCase(gh<_i747.MessageRepository>()),
    );
    gh.factory<_i40.SendMessageUseCase>(
      () => _i40.SendMessageUseCase(gh<_i747.MessageRepository>()),
    );
    gh.factory<_i841.RegisterUser>(
      () => _i841.RegisterUser(gh<_i390.UserRepository>()),
    );
    gh.factory<_i680.LoginUser>(
      () => _i680.LoginUser(gh<_i390.UserRepository>()),
    );
    gh.factory<_i1053.AuthBloc>(
      () => _i1053.AuthBloc(gh<_i841.RegisterUser>(), gh<_i680.LoginUser>()),
    );
    return this;
  }
}

class _$AppModule extends _i584.AppModule {}
