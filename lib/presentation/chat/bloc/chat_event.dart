part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadMessages extends ChatEvent {
  final String chatRoomId;
  const LoadMessages(this.chatRoomId);

  @override
  List<Object?> get props => [chatRoomId];
}

class SendMessage extends ChatEvent {
  final String chatRoomId;
  final MessageEntity message;
  const SendMessage(this.chatRoomId, this.message);

  @override
  List<Object?> get props => [chatRoomId, message];
}
