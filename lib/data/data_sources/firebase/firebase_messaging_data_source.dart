import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class FirebaseMessagingDataSource {
  Future<String?> getDeviceToken();
  Future<void> sendPushNotification({
    required String token,
    required Map<String, dynamic> data,
    required String title,
    required String body,
  });
}

@LazySingleton(as: FirebaseMessagingDataSource)
class FirebaseMessagingDataSourceImpl implements FirebaseMessagingDataSource {
  final FirebaseMessaging messaging;

  FirebaseMessagingDataSourceImpl(this.messaging);

  @override
  Future<String?> getDeviceToken() async {
    try {
      final token = await messaging.getToken();
      print("FCM Token: $token");
      return token;
    } catch (e) {
      print("Error getting token: $e");
      return null;
    }
  }

  @override
  Future<void> sendPushNotification({
    required String token,
    required Map<String, dynamic> data,
    required String title,
    required String body,
  }) async {
    final serverKey = 'YOUR_SERVER_KEY';

    await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "key=$serverKey",
      },
      body: jsonEncode({
        "to": token,
        "data": data,
        "notification": {"title": title, "body": body},
      }),
    );
  }
}
