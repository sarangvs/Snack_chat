import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<UserEntity?> call(String email, String password) {
    return repository.loginUser(email, password);
  }
}
