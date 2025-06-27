import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/repositories/chat_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMessagesStreamUseCase {
  final ChatRepository repository;
  GetMessagesStreamUseCase(this.repository);

  Stream<List<MessageEntity>> call(String chatRoomId) {
    return repository.getMessages(chatRoomId);
  }
}
