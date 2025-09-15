import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fig/core/repositories/auth_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository _authRepository;

  ProfileCubit(this._authRepository) : super(ProfileInitial());

  void showError(String message) {
    emit(ProfileError(message));
  }

  Future<void> login({
    required String email,
    required String password,
    SharedUserData? sharedData,
  }) async {
    emit(ProfileLoading());
    await Future.delayed(const Duration(seconds: 2));

    try {
      await _authRepository.login(
        email: email,
        password: password,
        sharedData: sharedData,
      );

      final storedData = await _authRepository.getStoredUserData();

      emit(
        ProfileLoggedIn(
          email: email,
          firstName: storedData?.firstName ?? sharedData?.firstName ?? "Test",
          lastName: storedData?.lastName ?? sharedData?.lastName ?? "User",
          phone: storedData?.phone ?? sharedData?.phone,
        ),
      );
    } catch (e) {
      emit(ProfileError("error_email_password".tr()));
    }
  }

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required int phone,
  }) async {
    emit(ProfileLoading());
    await Future.delayed(const Duration(seconds: 2));

    try {
      await _authRepository.signUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phone: phone,
      );

      emit(
        ProfileSignedUp(
          email: email,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
        ),
      );
    } catch (e) {
      emit(ProfileError("error_password_mismatch".tr()));
    }
  }

  Future<SharedUserData?> getStoredUserData() async {
    return await _authRepository.getStoredUserData();
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(ProfileInitial());
  }

  Future<void> checkLoginStatus() async {
    emit(ProfileLoading());

    final isLoggedIn = await _authRepository.checkLoginStatus();

    if (isLoggedIn) {
      final storedData = await _authRepository.getStoredUserData();

      emit(
        ProfileLoggedIn(
          email: storedData?.email ?? '',
          firstName: storedData?.firstName ?? "Test",
          lastName: storedData?.lastName ?? "User",
          phone: storedData?.phone,
        ),
      );
    } else {
      emit(ProfileInitial());
    }
  }
}

class AuthTabCubit extends Cubit<AuthTabState> {
  AuthTabCubit() : super(AuthTabInitial());

  void changeTab(int index, {SharedUserData? sharedData}) =>
      emit(AuthTabChanged(index, sharedData: sharedData));
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
