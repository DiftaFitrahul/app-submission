import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on(_onLoginLogged);
  }

  Future<void> _onLoginLogged(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    try {} catch (err) {
      rethrow;
    }
  }
}
