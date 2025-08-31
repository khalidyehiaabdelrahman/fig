import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> login({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(ProfileLoading());
    await Future.delayed(const Duration(seconds: 2));

    if (email == "test@test.com" && password == "123456") {
      emit(ProfileLoggedIn(username: username, email: email));
    } else {
      emit(ProfileError("error_email_password".tr()));
    }
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(ProfileLoading());
    await Future.delayed(const Duration(seconds: 2));

    if (password != confirmPassword) {
      emit(ProfileError("error_password_mismatch".tr()));
      return;
    }

    if (email.endsWith("@test.com")) {
      emit(ProfileSignedUp(username: username, email: email));
    } else {
      emit(ProfileError("error_email_not_allowed".tr()));
    }
  }

  void logout() => emit(ProfileLoggedOut());
}

class AuthTabCubit extends Cubit<AuthTabState> {
  AuthTabCubit() : super(AuthTabInitial());

  void changeTab(int index) => emit(AuthTabChanged(index));
}

class LoginVisibilityCubit extends Cubit<LoginVisibilityState> {
  LoginVisibilityCubit() : super(LoginVisibilityHidden());

  void toggleVisibility() {
    if (state is LoginVisibilityHidden) {
      emit(LoginVisibilityShown());
    } else {
      emit(LoginVisibilityHidden());
    }
  }
}

class SignUpVisibilityCubit extends Cubit<SignUpVisibilityState> {
  SignUpVisibilityCubit() : super(const SignUpVisibilityInitial());

  void togglePasswordVisibility() {
    emit(
      SignUpVisibilityChanged(
        isPasswordVisible: !state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      ),
    );
  }

  void toggleConfirmPasswordVisibility() {
    emit(
      SignUpVisibilityChanged(
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
      ),
    );
  }
}

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(String initialLang) : super(LanguageInitial(initialLang));

  void selectLanguage(String langCode) {
    emit(LanguageChanged(langCode));
  }
}
