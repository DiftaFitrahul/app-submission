import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/features/user/shared/data/repository/auth_repository.dart';

part "register_event.dart";
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(RegisterState.initial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  final AuthRepository _authRepository;

  Future<void> _onRegisterSubmitted(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    try {
      emit(state.copyWith(stateStatus: RegisterStateStatus.loading));
      final registerDataRepository = await _authRepository.register(
          name: event.name, email: event.email, password: event.password);
      registerDataRepository.fold((failure) {
        emit(state.copyWith(
            stateStatus: RegisterStateStatus.failure,
            message: failure.message));
      }, (registerData) {
        emit(state.copyWith(
            stateStatus: RegisterStateStatus.success,
            message: "success register"));
      });
    } catch (_) {
      emit(state.copyWith(
          stateStatus: RegisterStateStatus.failure,
          message: "Error occured!!"));
    }
  }
}
