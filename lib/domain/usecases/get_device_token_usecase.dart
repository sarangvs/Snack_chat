import 'package:chat_app/domain/repositories/message_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDeviceTokenUseCase {
  final MessageRepository repository;

  GetDeviceTokenUseCase(this.repository);

  Future<String?> call() => repository.getDeviceToken();
}
