import 'package:chat_app/data/data_sources/repositories/map_repository_impl.dart';
import 'package:chat_app/domain/repositories/map_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @lazySingleton
  FirebaseMessaging get messaging => FirebaseMessaging.instance;
}

@module
abstract class RegisterModule {
  @Named('GoogleMapsApiKey')
  String get apiKey => dotenv.env['GOOGLE_MAPS_API_KEY']!;

  @LazySingleton(as: MapRepository)
  MapRepositoryImpl provideMapRepository(
    @Named('GoogleMapsApiKey') String apiKey,
  ) => MapRepositoryImpl(apiKey);
}
