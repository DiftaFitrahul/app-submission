part of "auth_bloc.dart";

enum UserCurrentState { authenticated, unauthenticated }

class AuthState {
  final UserCurrentState userCurrentState;
  const AuthState({required this.userCurrentState});
  AuthState copyWith({UserCurrentState? userCurrentState}) {
    return AuthState(
        userCurrentState: userCurrentState ?? this.userCurrentState);
  }
}
