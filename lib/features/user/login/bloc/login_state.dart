part of "login_bloc.dart";

enum LoginStateStatus { initial, loading, success, failure }

class LoginState {
  final LoginStateStatus stateStatus;
  final LoginData loginData;
  final String? message;

  const LoginState(
      {required this.stateStatus, required this.loginData, this.message});

  factory LoginState.initial() {
    return const LoginState(
        stateStatus: LoginStateStatus.initial, loginData: LoginData());
  }

  LoginState copyWith(
      {LoginStateStatus? stateStatus, LoginData? loginData, String? message}) {
    return LoginState(
        stateStatus: stateStatus ?? this.stateStatus,
        loginData: loginData ?? this.loginData,
        message: message);
  }
}
