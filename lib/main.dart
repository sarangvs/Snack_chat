import 'package:chat_app/DI/dependency_injection.dart';
import 'package:chat_app/app.dart';
import 'package:chat_app/data/data_sources/local/user_local_datasource.dart';
import 'package:chat_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:chat_app/presentation/chat/bloc/chat_bloc.dart';
import 'package:chat_app/presentation/map/bloc/map_bloc.dart';
import 'package:chat_app/presentation/splash/bloc/splash_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  await configureDependencies();
  await getIt<UserLocalDatasource>().init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(lazy: true, create: (_) => SplashCubit()),
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<ChatBloc>()),
        BlocProvider(create: (_) => getIt<MapBloc>()),
      ],
      child: MyApp(),
    ),
  );
}
