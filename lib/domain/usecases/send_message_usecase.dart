import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/repositories/message_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendMessageUseCase {
  final MessageRepository repository;

  SendMessageUseCase(this.repository);

  Future<void> call(String token, MessageEntity message) {
    return repository.sendMessage(token, message);
  }
}
