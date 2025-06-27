import 'package:chat_app/data/models/message_model.dart';

abstract class FirebaseRemoteDataSource {
  Stream<List<MessageModel>> getMessagesStream(String chatRoomId);
  Future<void> sendMessage(String chatRoomId, MessageModel message);
  Future<String> createOrGetChatRoom(String myUid, String otherUid);
}
