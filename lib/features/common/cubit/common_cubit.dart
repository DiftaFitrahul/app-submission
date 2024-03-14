import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonCubit extends Cubit<Locale> {
  CommonCubit() : super(const Locale('en'));

  void chageLocale(Locale locale) {
    emit(locale);
  }
}
