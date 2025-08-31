abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoggedIn extends ProfileState {
  final String username;
  final String email;
  ProfileLoggedIn({required this.username, required this.email});
}

class ProfileSignedUp extends ProfileState {
  final String username;
  final String email;
  ProfileSignedUp({required this.username, required this.email});
}

class ProfileLoggedOut extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

abstract class AuthTabState {}

class AuthTabInitial extends AuthTabState {}

class AuthTabChanged extends AuthTabState {
  final int index;
  AuthTabChanged(this.index);
}

abstract class LoginVisibilityState {}

class LoginVisibilityHidden extends LoginVisibilityState {}

class LoginVisibilityShown extends LoginVisibilityState {}

abstract class SignUpVisibilityState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  const SignUpVisibilityState({
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
  });
}

class SignUpVisibilityInitial extends SignUpVisibilityState {
  const SignUpVisibilityInitial()
    : super(isPasswordVisible: false, isConfirmPasswordVisible: false);
}

class SignUpVisibilityChanged extends SignUpVisibilityState {
  const SignUpVisibilityChanged({
    required super.isPasswordVisible,
    required super.isConfirmPasswordVisible,
  });
}

abstract class LanguageState {
  final String languageCode;
  const LanguageState(this.languageCode);
}

class LanguageInitial extends LanguageState {
  const LanguageInitial(super.languageCode);
}

class LanguageChanged extends LanguageState {
  const LanguageChanged(super.languageCode);
}
