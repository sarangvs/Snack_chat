import 'package:chat_app/data/data_sources/local/user_local_datasource.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserLocalDatasource datasource;

  UserRepositoryImpl(this.datasource);

  @override
  Future<void> registerUser(UserEntity user) async {
    await datasource.registerUser(
      UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        password: user.password,
        mobile: user.mobile,
        country: user.country,
      ),
    );
  }

  @override
  Future<UserEntity?> loginUser(String email, String password) {
    return datasource.loginUser(email, password);
  }
}
