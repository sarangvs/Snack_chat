import 'package:chat_app/DI/dependency_injection.dart';
import 'package:chat_app/app.dart';
import 'package:chat_app/data/data_sources/local/user_local_datasource.dart';
import 'package:chat_app/data/data_sources/repositories/chat_repository_impl.dart';
import 'package:chat_app/data/data_sources/repositories/firebase_remote_data_source_impl.dart';
import 'package:chat_app/domain/usecases/get_messages_stream_usecase.dart';
import 'package:chat_app/domain/usecases/send_message_usecase.dart';
import 'package:chat_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:chat_app/presentation/chat/bloc/chat_bloc.dart';
import 'package:chat_app/presentation/splash/bloc/splash_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  final remoteDataSource = FirebaseRemoteDataSourceImpl(
    FirebaseFirestore.instance,
  );
  final chatRepository = ChatRepositoryImpl(remoteDataSource);
  final getMessagesStreamUseCase = GetMessagesStreamUseCase(chatRepository);
  final sendMessageUseCase = SendMessageUseCase(chatRepository);

  await configureDependencies();
  await getIt<UserLocalDatasource>().init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(lazy: true, create: (_) => SplashCubit()),
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<ChatBloc>()),
      ],
      child: MyApp(),
    ),
  );
}
