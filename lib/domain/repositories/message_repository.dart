import 'package:chat_app/domain/entities/message_entity.dart';

abstract class MessageRepository {
  Future<String?> getDeviceToken();
  Future<void> sendMessage(String token, MessageEntity message);
  Future<void> saveMessage(MessageEntity message);
  Stream<List<MessageEntity>> getMessages();
}
