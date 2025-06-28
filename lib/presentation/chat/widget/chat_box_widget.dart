import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChatBoxWidget extends StatelessWidget {
  const ChatBoxWidget({
    super.key,
    required this.isMe,
    required this.model,
    required this.timeString,
  });

  final bool isMe;
  final MessageEntity model;
  final String timeString;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? AppColors.chatBox1 : AppColors.chatBox2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              model.text,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              timeString,
              style: TextStyle(fontSize: 10, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
