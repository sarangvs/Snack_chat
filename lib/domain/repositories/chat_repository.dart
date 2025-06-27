import 'package:chat_app/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<void> sendMessage(String chatRoomId, MessageEntity message);
  Stream<List<MessageEntity>> getMessages(String chatRoomId);
  Future<String> startChat(String myUid, String otherUid);
}
