part of "register_bloc.dart";

enum RegisterStateStatus { inital, loading, success, failure }

class RegisterState {
  final RegisterStateStatus stateStatus;
  final String message;

  const RegisterState({required this.message, required this.stateStatus});

  factory RegisterState.initial() {
    return const RegisterState(
        message: "", stateStatus: RegisterStateStatus.inital);
  }
  RegisterState copyWith({RegisterStateStatus? stateStatus, String? message}) {
    return RegisterState(
        message: message ?? this.message,
        stateStatus: stateStatus ?? this.stateStatus);
  }
}
