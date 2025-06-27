import 'package:chat_app/domain/repositories/chat_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartChatUseCase {
  final ChatRepository repository;
  StartChatUseCase(this.repository);

  Future<String> call(String myUid, String otherUid) {
    return repository.startChat(myUid, otherUid);
  }
}
