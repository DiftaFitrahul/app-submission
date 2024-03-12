part of "register_bloc.dart";

sealed class RegisterEvent {}

final class RegisterSubmitted extends RegisterEvent {
  final String name;
  final String email;
  final String password;

  RegisterSubmitted(
      {required this.email, required this.password, required this.name});
}
