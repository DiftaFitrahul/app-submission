import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/features/user/shared/data/model/login_data.dart';
import 'package:story_app/features/user/shared/data/repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginState.initial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final AuthRepository _authRepository;

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(stateStatus: LoginStateStatus.loading));
      final loginDataRepository = await _authRepository.login(
          email: event.email, password: event.password);

      loginDataRepository.fold((err) {
        emit(state.copyWith(stateStatus: LoginStateStatus.failure));
      }, (loginData) {
        emit(state.copyWith(
            loginData: loginData, stateStatus: LoginStateStatus.success));
      });
    } catch (err) {
      emit(state.copyWith(stateStatus: LoginStateStatus.failure));
      rethrow;
    }
  }
}
