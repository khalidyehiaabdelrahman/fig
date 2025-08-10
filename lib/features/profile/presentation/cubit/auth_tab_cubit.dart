import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthTabCubit extends Cubit<int> {
  AuthTabCubit() : super(0); // 0 = Login, 1 = Sign Up

  void changeTab(int index) => emit(index);
}

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  void changeLocale(Locale locale) {
    emit(locale);
  }
}
