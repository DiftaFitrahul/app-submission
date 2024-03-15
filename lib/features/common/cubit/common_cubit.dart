import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../user/shared/data/repository/user_repository.dart';

class CommonCubit extends Cubit<Locale> {
  CommonCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const Locale('en'));

  final UserRepository _userRepository;

  void getUserLocale() async {
    final localeLanguageCode = await _userRepository.getUserLocalePreferences();
    final locale = Locale(localeLanguageCode);
    emit(locale);
  }

  void chageLocale(Locale locale) async {
    await _userRepository.saveUserLocalePreferences(locale.languageCode);
    emit(locale);
  }

  void deleteUserLocale() async {
    await _userRepository.deleteUserLocalePreferences();
    emit(const Locale('en'));
  }
}
