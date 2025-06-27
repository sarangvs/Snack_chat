import 'package:chat_app/data/data_sources/remote/firebase_remote_data_source.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/repositories/chat_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> sendMessage(String chatRoomId, MessageEntity message) async {
    final model = MessageModel(
      senderId: message.senderId,
      receiverId: message.receiverId,
      text: message.text,
      timestamp: message.timestamp,
    );
    await remoteDataSource.sendMessage(chatRoomId, model);
  }

  @override
  Stream<List<MessageEntity>> getMessages(String chatRoomId) {
    return remoteDataSource.getMessagesStream(chatRoomId);
  }

  @override
  Future<String> startChat(String myUid, String otherUid) {
    return remoteDataSource.createOrGetChatRoom(myUid, otherUid);
  }
}
