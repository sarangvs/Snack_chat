import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.senderId,
    required super.receiverId,
    required super.text,
    required super.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    senderId: json['senderId'],
    receiverId: json['receiverId'],
    text: json['text'],
    timestamp: (json['timestamp'] as Timestamp).toDate(),
  );

  Map<String, dynamic> toJson() => {
    'senderId': senderId,
    'receiverId': receiverId,
    'text': text,
    'timestamp': timestamp,
  };
}
