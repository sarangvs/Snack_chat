import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/usecases/get_messages_stream_usecase.dart';
import 'package:chat_app/domain/usecases/send_message_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessagesStreamUseCase getMessagesStream;
  final SendMessageUseCase sendMessage;

  ChatBloc({required this.getMessagesStream, required this.sendMessage})
    : super(ChatInitial()) {
    on<LoadMessages>((event, emit) async {
      emit(ChatLoading());
      await emit.forEach<List<MessageEntity>>(
        getMessagesStream(event.chatRoomId),
        onData: (messages) => ChatLoaded(messages),
        onError: (_, __) => ChatError("Failed to load messages"),
      );
    });

    on<SendMessage>((event, emit) async {
      try {
        await sendMessage(event.chatRoomId, event.message);
      } catch (_) {
        emit(ChatError("Failed to send message"));
      }
    });
  }
}
