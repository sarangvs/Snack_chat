import 'package:chat_app/core/utils/uuid_generator.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/usecases/login_user.dart';
import 'package:chat_app/domain/usecases/register_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUser registerUser;
  final LoginUser loginUser;

  AuthBloc(this.registerUser, this.loginUser) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
  }

  void _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = UserEntity(
        id: generateUUID(),
        name: event.name,
        email: event.email,
        password: event.password,
        mobile: event.mobile,
        country: event.country,
      );
      await registerUser(user);
      emit(AuthRegistered());
    } catch (e) {
      emit(AuthError("Registration failed"));
    }
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = await loginUser(event.email, event.password);
    if (user != null) {
      emit(AuthLoggedIn(user.name));
    } else {
      emit(AuthError("Invalid credentials"));
    }
  }
}
