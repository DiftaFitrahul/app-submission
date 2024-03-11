part of "login_bloc.dart";

enum LoginStateStatus { initial, loading, success, failure }

class LoginState {
  final String email;
  final String password;
  final LoginStateStatus stateStatus;

  const LoginState(
      {required this.email, required this.password, required this.stateStatus});

  factory LoginState.initial() {
    return const LoginState(
      email: "",
      password: "",
      stateStatus: LoginStateStatus.initial,
    );
  }
}
