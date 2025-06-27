class MessageEntity {
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime timestamp;

  const MessageEntity({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
  });
}
