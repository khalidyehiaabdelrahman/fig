import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial());

  void login({required String username, required String email}) {
    emit(
      state.copyWith(
        status: ProfileStatus.loggedIn,
        username: username,
        email: email,
      ),
    );
  }

  void logout() {
    emit(ProfileState.initial());
  }
}

class LoginVisibilityCubit extends Cubit<bool> {
  LoginVisibilityCubit() : super(false); // false = password hidden

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
