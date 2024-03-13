import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/features/user/shared/data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState(
            userCurrentState: UserCurrentState.unauthenticated)) {
    on<AuthChecked>(_onAuthChecked);
  }

  final AuthRepository _authRepository;

  void _onAuthChecked(AuthChecked event, Emitter<AuthState> emit) async {
    try {
      final isUserAuthenticated = await _authRepository.checkUserAuth();
      if (isUserAuthenticated) {
        emit(state.copyWith(userCurrentState: UserCurrentState.authenticated));
      } else {
        emit(
            state.copyWith(userCurrentState: UserCurrentState.unauthenticated));
      }
    } catch (_) {
      emit(state.copyWith(userCurrentState: UserCurrentState.unauthenticated));
    }
  }
}
