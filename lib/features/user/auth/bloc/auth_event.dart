part of "auth_bloc.dart";

sealed class AuthEvent {}

final class AuthChecked extends AuthEvent {}

final class AuthOut extends AuthEvent {}
