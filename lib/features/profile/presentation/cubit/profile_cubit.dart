import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  static const _storage = FlutterSecureStorage();

  ProfileCubit() : super(ProfileInitial());

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

    
    final storedEmail = await _storage.read(key: 'user_email');
    final storedPassword = await _storage.read(key: 'user_password');
    final storedFirstName = await _storage.read(key: 'user_first_name');
    final storedLastName = await _storage.read(key: 'user_last_name');
    final storedPhone = await _storage.read(key: 'user_phone');

    
    if (email == storedEmail && password == storedPassword) {
      await _storage.write(key: 'user_is_logged_in', value: 'true');

      emit(
        ProfileLoggedIn(
          email: email,
          firstName: storedFirstName ?? sharedData?.firstName ?? "Test",
          lastName: storedLastName ?? sharedData?.lastName ?? "User",
          phone:
              storedPhone != null
                  ? int.tryParse(storedPhone)
                  : sharedData?.phone,
        ),
      );
    } else {
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

    if (password != confirmPassword) {
      emit(ProfileError("error_password_mismatch".tr()));
      return;
    }

    

    
    await _storage.write(key: 'user_first_name', value: firstName);
    await _storage.write(key: 'user_last_name', value: lastName);
    await _storage.write(key: 'user_email', value: email);
    await _storage.write(key: 'user_password', value: password);
    await _storage.write(key: 'user_phone', value: phone.toString());
    await _storage.write(key: 'user_is_logged_in', value: 'false');

    emit(
      ProfileSignedUp(
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      ),
    );
  }

  Future<SharedUserData?> getStoredUserData() async {
    final firstName = await _storage.read(key: 'user_first_name');
    final lastName = await _storage.read(key: 'user_last_name');
    final email = await _storage.read(key: 'user_email');
    final phone = await _storage.read(key: 'user_phone');

    if (firstName != null && lastName != null && email != null) {
      return SharedUserData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone != null ? int.tryParse(phone) : null,
      );
    }
    return null;
  }

  Future<void> logout() async {
    
    await _storage.deleteAll();

    
    emit(ProfileInitial());
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
