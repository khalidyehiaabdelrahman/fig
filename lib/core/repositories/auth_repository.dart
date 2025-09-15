import 'package:fig/features/profile/presentation/cubit/profile_state.dart';

abstract class AuthRepository {
  Future<void> login({
    required String email,
    required String password,
    SharedUserData? sharedData,
  });

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required int phone,
  });

  Future<SharedUserData?> getStoredUserData();
  Future<void> logout();
  Future<bool> checkLoginStatus();
  Future<void> saveUserData(SharedUserData userData);
}
