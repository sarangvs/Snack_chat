import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUser {
  final UserRepository repository;

  RegisterUser(this.repository);

  Future<void> call(UserEntity user) => repository.registerUser(user);
}
