import 'dart:developer';

import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/presentation/auth/widgets/custom_textfield.dart';
import 'package:chat_app/presentation/chat/bloc/chat_bloc.dart';
import 'package:chat_app/presentation/chat/widget/chat_box_widget.dart';
import 'package:chat_app/presentation/chat/widget/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  final String myUid;
  final String receiverUid;
  final String chatRoomId;

  const ChatScreen({
    super.key,
    required this.myUid,
    required this.receiverUid,
    required this.chatRoomId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    log("myUserId ${widget.myUid}");
    context.read<ChatBloc>().add(LoadMessages(widget.chatRoomId));
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final model = MessageEntity(
      senderId: widget.myUid,
      receiverId: widget.receiverUid,
      text: text,
      timestamp: DateTime.now(),
    );

    context.read<ChatBloc>().add(SendMessage(widget.chatRoomId, model));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final themeColor = Theme.of(context);
    final themeStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.user, style: themeStyle.titleLarge),
        backgroundColor: themeColor.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatLoaded) {
                    final messages = state.messages;
                    return ListView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (_, index) {
                        final model = messages[index];
                        final isMe = model.senderId == widget.myUid;

                        final timeString = formatChatTimestamp(
                          context,
                          model.timestamp,
                        );

                        return ChatBoxWidget(
                          isMe: isMe,
                          model: model,
                          timeString: timeString,
                        );
                      },
                    );
                  } else if (state is ChatError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
            _sendMessageWidget(loc),
          ],
        ),
      ),
    );
  }

  Padding _sendMessageWidget(AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              hintText: "${loc.message}...",
              controller: _controller,
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: _sendMessage,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.black,
              elevation: 4,
            ),
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
