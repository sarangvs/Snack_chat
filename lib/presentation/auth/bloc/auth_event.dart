part of 'auth_bloc.dart';

abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String name, email, password, mobile, country;

  RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.mobile,
    required this.country,
  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}
