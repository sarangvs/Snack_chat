import 'package:chat_app/data/data_sources/firebase/firebase_messaging_data_source.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/repositories/message_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MessageRepository)
class MessageRepositoryImpl implements MessageRepository {
  final FirebaseMessagingDataSource firebase;

  MessageRepositoryImpl(this.firebase);

  @override
  Future<String?> getDeviceToken() => firebase.getDeviceToken();

  @override
  Future<void> sendMessage(String token, MessageEntity entity) async {
    final model = MessageModel(
      sender: entity.sender,
      message: entity.message,
      timestamp: entity.timestamp,
    );

    await firebase.sendPushNotification(
      token: token,
      title: model.sender,
      body: model.message,
      data: model.toJson(),
    );
  }

  @override
  Future<void> saveMessage(MessageEntity message) async {
    // TODO: Save in local DB (Drift/SQLite)
  }

  @override
  Stream<List<MessageEntity>> getMessages() {
    // TODO: Read from local DB
    throw UnimplementedError();
  }
}
