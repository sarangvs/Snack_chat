import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/repositories/chat_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendMessageUseCase {
  final ChatRepository repository;
  SendMessageUseCase(this.repository);

  Future<void> call(String chatRoomId, MessageEntity message) {
    return repository.sendMessage(chatRoomId, message);
  }
}
