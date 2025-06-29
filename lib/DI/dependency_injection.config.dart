// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chat_app/data/data_sources/local/user_local_datasource.dart'
    as _i862;
import 'package:chat_app/data/data_sources/remote/country_service.dart'
    as _i990;
import 'package:chat_app/data/data_sources/remote/firebase_remote_data_source.dart'
    as _i1029;
import 'package:chat_app/data/data_sources/repositories/chat_repository_impl.dart'
    as _i100;
import 'package:chat_app/data/data_sources/repositories/country_repository_impl.dart'
    as _i587;
import 'package:chat_app/data/data_sources/repositories/firebase_remote_data_source_impl.dart'
    as _i482;
import 'package:chat_app/data/data_sources/repositories/user_repository_impl.dart'
    as _i845;
import 'package:chat_app/DI/app_module.dart' as _i584;
import 'package:chat_app/domain/repositories/chat_repository.dart' as _i23;
import 'package:chat_app/domain/repositories/country_repository.dart' as _i236;
import 'package:chat_app/domain/repositories/map_repository.dart' as _i745;
import 'package:chat_app/domain/repositories/user_repository.dart' as _i390;
import 'package:chat_app/domain/usecases/get_country_names.dart' as _i385;
import 'package:chat_app/domain/usecases/get_current_location_usecase.dart'
    as _i480;
import 'package:chat_app/domain/usecases/get_messages_stream_usecase.dart'
    as _i746;
import 'package:chat_app/domain/usecases/get_my_uid_usecase.dart' as _i568;
import 'package:chat_app/domain/usecases/get_nearby_water_bodies.dart' as _i825;
import 'package:chat_app/domain/usecases/login_user.dart' as _i680;
import 'package:chat_app/domain/usecases/register_user.dart' as _i841;
import 'package:chat_app/domain/usecases/send_message_usecase.dart' as _i40;
import 'package:chat_app/domain/usecases/start_chat_usecase.dart' as _i820;
import 'package:chat_app/presentation/auth/bloc/auth_bloc.dart' as _i1053;
import 'package:chat_app/presentation/auth/cubit/country_cubit.dart' as _i761;
import 'package:chat_app/presentation/chat/bloc/chat_bloc.dart' as _i693;
import 'package:chat_app/presentation/home/bloc/home_bloc.dart' as _i432;
import 'package:chat_app/presentation/map/bloc/map_bloc.dart' as _i564;
import 'package:chat_app/presentation/qr_generater/bloc/qr_generator_bloc.dart'
    as _i548;
import 'package:chat_app/presentation/splash/bloc/splash_cubit.dart' as _i154;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
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
    final firebaseModule = _$FirebaseModule();
    final registerModule = _$RegisterModule();
    gh.factory<_i480.GetCurrentLocation>(() => _i480.GetCurrentLocation());
    gh.factory<_i432.HomeBloc>(() => _i432.HomeBloc());
    gh.factory<_i154.SplashCubit>(() => _i154.SplashCubit());
    gh.factory<_i548.QrGeneratorBloc>(() => _i548.QrGeneratorBloc());
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i892.FirebaseMessaging>(() => firebaseModule.messaging);
    gh.lazySingleton<_i990.RemoteDataSource>(() => _i990.RemoteDataSource());
    gh.factory<String>(
      () => registerModule.apiKey,
      instanceName: 'GoogleMapsApiKey',
    );
    gh.lazySingleton<_i1029.FirebaseRemoteDataSource>(
      () => _i482.FirebaseRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i23.ChatRepository>(
      () => _i100.ChatRepositoryImpl(gh<_i1029.FirebaseRemoteDataSource>()),
    );
    gh.lazySingleton<_i862.UserLocalDatasource>(
      () => _i862.UserLocalDatasourceImpl(),
    );
    gh.factory<_i746.GetMessagesStreamUseCase>(
      () => _i746.GetMessagesStreamUseCase(gh<_i23.ChatRepository>()),
    );
    gh.factory<_i820.StartChatUseCase>(
      () => _i820.StartChatUseCase(gh<_i23.ChatRepository>()),
    );
    gh.factory<_i40.SendMessageUseCase>(
      () => _i40.SendMessageUseCase(gh<_i23.ChatRepository>()),
    );
    gh.factory<_i693.ChatBloc>(
      () => _i693.ChatBloc(
        getMessagesStream: gh<_i746.GetMessagesStreamUseCase>(),
        sendMessage: gh<_i40.SendMessageUseCase>(),
      ),
    );
    gh.lazySingleton<_i745.MapRepository>(
      () => registerModule.provideMapRepository(
        gh<String>(instanceName: 'GoogleMapsApiKey'),
      ),
    );
    gh.factory<_i568.GetMyUidUseCase>(
      () => _i568.GetMyUidUseCase(gh<String>()),
    );
    gh.factory<_i825.GetNearbyWaterBodies>(
      () => _i825.GetNearbyWaterBodies(gh<_i745.MapRepository>()),
    );
    gh.lazySingleton<_i236.CountryRepository>(
      () => _i587.CountryRepositoryImpl(gh<_i990.RemoteDataSource>()),
    );
    gh.factory<_i564.MapBloc>(
      () => _i564.MapBloc(
        getCurrentLocation: gh<_i480.GetCurrentLocation>(),
        getNearbyWaterBodies: gh<_i825.GetNearbyWaterBodies>(),
      ),
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

class _$FirebaseModule extends _i584.FirebaseModule {}

class _$RegisterModule extends _i584.RegisterModule {}
