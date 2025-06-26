import 'package:chat_app/DI/dependency_injection.dart';
import 'package:chat_app/app.dart';
import 'package:chat_app/data/data_sources/local/user_local_datasource.dart';
import 'package:chat_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:chat_app/presentation/splash/bloc/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await getIt<UserLocalDatasource>().init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(lazy: true, create: (_) => SplashCubit()),
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}
