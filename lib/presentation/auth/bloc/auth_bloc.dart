import 'dart:developer';

import 'package:chat_app/core/utils/uuid_generator.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/usecases/login_user.dart';
import 'package:chat_app/domain/usecases/register_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    print("RegisterEvent received");

    try {
      final user = UserEntity(
        id: generateUUID(),
        name: event.name,
        email: event.email,
        password: event.password,
        mobile: event.mobile,
        country: event.country,
      );

      log("Registering user: ${user.email}");
      await registerUser(user);

      log("✅ User registered, emitting AuthRegistered");
      emit(AuthRegistered());
      await saveLoginState();
    } catch (e) {
      log("❌ Error during registration: $e");
      emit(AuthError("Registration failed: ${e.toString()}"));
    }
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    log("LoginEvent received");

    try {
      final user = await loginUser(event.email, event.password);
      log("User from DB: $user");

      if (user != null) {
        log("✅ Login Success");
        emit(AuthLoggedIn(user.name));
        await saveLoginState();
      } else {
        log("❌ Invalid credentials");
        emit(AuthError("Invalid credentials"));
      }
    } catch (e) {
      log("❌ Exception during login: $e");

      emit(AuthError("Something went wrong. Please try again."));
    }
  }

  Future<void> saveLoginState() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool('isLoggedIn', true);
      log("Saved login state");
    } catch (e) {
      log("Erorr $e");
    }
  }
}
