abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoggedIn extends ProfileState {
  final String email;
  final String firstName;
  final String lastName;
  final int? phone;

  ProfileLoggedIn({
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phone,
  });
}

class ProfileSignedUp extends ProfileState {
  final String email;
  final String firstName;
  final String lastName;
  final int phone;

  ProfileSignedUp({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });
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
  final SharedUserData? sharedData;
  AuthTabChanged(this.index, {this.sharedData});
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
    required bool isPasswordVisible,
    required bool isConfirmPasswordVisible,
  }) : super(
         isPasswordVisible: isPasswordVisible,
         isConfirmPasswordVisible: isConfirmPasswordVisible,
       );
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


class SharedUserData {
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? phone;
  final String? password;

  const SharedUserData({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.password,
  });

  SharedUserData copyWith({
    String? firstName,
    String? lastName,
    String? email,
    int? phone,
    String? password,
  }) {
    return SharedUserData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }
}
