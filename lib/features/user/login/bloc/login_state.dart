part of "login_bloc.dart";

enum LoginStateStatus { initial, loading, success, failure }

class LoginState {
  final LoginStateStatus stateStatus;
  final LoginData loginData;

  const LoginState({required this.stateStatus, required this.loginData});

  factory LoginState.initial() {
    return const LoginState(
        stateStatus: LoginStateStatus.initial, loginData: LoginData());
  }

  LoginState copyWith({
    String? email,
    String? password,
    LoginStateStatus? stateStatus,
    LoginData? loginData,
  }) {
    return LoginState(
        stateStatus: stateStatus ?? this.stateStatus,
        loginData: loginData ?? this.loginData);
  }
}
