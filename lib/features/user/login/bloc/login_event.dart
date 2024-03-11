part of "login_bloc.dart";

sealed class LoginEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});
}

class LoginSubmitted extends LoginEvent {
  LoginSubmitted({required super.email, required super.password});
}
