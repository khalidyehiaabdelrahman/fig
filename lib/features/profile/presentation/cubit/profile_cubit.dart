import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial());

  Future<void> login({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await Future.delayed(const Duration(seconds: 2));

    if (email == "test@test.com" && password == "123456") {
      emit(
        state.copyWith(
          status: ProfileStatus.loggedIn,
          username: username,
          email: email,
          isLoading: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "error_email_password".tr(),
        ),
      );
    }
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await Future.delayed(const Duration(seconds: 2));

    if (password != confirmPassword) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "error_password_mismatch".tr(),
        ),
      );
      return;
    }

    if (email.endsWith("@test.com")) {
      emit(
        state.copyWith(
          status: ProfileStatus.signedUp,
          username: username,
          email: email,
          isLoading: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "error_email_not_allowed".tr(),
        ),
      );
    }
  }

  void logout() => emit(ProfileState.initial());
}

class AuthTabCubit extends Cubit<int> {
  AuthTabCubit() : super(0);
  void changeTab(int index) => emit(index);
}

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));
  void changeLocale(Locale locale) => emit(locale);
}

class LoginVisibilityCubit extends Cubit<bool> {
  LoginVisibilityCubit() : super(false);
  void toggleVisibility() => emit(!state);
}

class SignUpVisibilityCubit extends Cubit<SignUpVisibilityState> {
  SignUpVisibilityCubit()
    : super(
        const SignUpVisibilityState(
          isPasswordVisible: false,
          isConfirmPasswordVisible: false,
        ),
      );

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }
}

class SignUpVisibilityState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  const SignUpVisibilityState({
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
  });

  SignUpVisibilityState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
  }) {
    return SignUpVisibilityState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
    );
  }
}

class LanguageCubit extends Cubit<String> {
  LanguageCubit(super.initialLang);

  void selectLanguage(String languageCode) {
    emit(languageCode);
  }
}
