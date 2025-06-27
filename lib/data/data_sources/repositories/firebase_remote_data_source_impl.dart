import 'package:chat_app/core/utils/uuid_generator.dart';
import 'package:chat_app/data/data_sources/remote/firebase_remote_data_source.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FirebaseRemoteDataSource)
class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl(this.firestore);

  @override
  Future<String> createOrGetChatRoom(String myUid, String otherUid) async {
    final chatRoomId = generateChatRoomId(myUid, otherUid);
    final chatRef = firestore.collection('chats').doc(chatRoomId);
    if (!(await chatRef.get()).exists) {
      await chatRef.set({});
    }
    return chatRoomId;
  }

  @override
  Stream<List<MessageModel>> getMessagesStream(String chatRoomId) {
    return firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => MessageModel.fromJson(doc.data()))
                  .toList(),
        );
  }

  @override
  Future<void> sendMessage(String chatRoomId, MessageModel message) async {
    await firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .add(message.toJson());
  }
}
