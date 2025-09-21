import 'package:fig/core/repositories/auth_repository.dart';
import 'package:fig/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  static const _storage = FlutterSecureStorage();

  @override
  Future<void> login({
    required String email,
    required String password,
    SharedUserData? sharedData,
  }) async {
    final storedEmail = await _storage.read(key: 'user_email');
    final storedPassword = await _storage.read(key: 'user_password');

    if (email == storedEmail && password == storedPassword) {
      await _storage.write(key: 'user_is_logged_in', value: 'true');
    } else {
      throw Exception("Invalid email or password");
    }
  }

  @override
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required int phone,
  }) async {
    if (password != confirmPassword) {
      throw Exception("Password mismatch");
    }

    await _storage.write(key: 'user_first_name', value: firstName);
    await _storage.write(key: 'user_last_name', value: lastName);
    await _storage.write(key: 'user_email', value: email);
    await _storage.write(key: 'user_password', value: password);
    await _storage.write(key: 'user_phone', value: phone.toString());
    await _storage.write(key: 'user_is_logged_in', value: 'false');
  }

  @override
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

  @override
  Future<void> logout() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw Exception('Failed to clear storage: $e');
    }
  }

  @override
  Future<bool> checkLoginStatus() async {
    final isLoggedIn = await _storage.read(key: 'user_is_logged_in');
    return isLoggedIn == 'true';
  }

  @override
  Future<void> saveUserData(SharedUserData userData) async {
    await _storage.write(key: 'user_first_name', value: userData.firstName);
    await _storage.write(key: 'user_last_name', value: userData.lastName);
    await _storage.write(key: 'user_email', value: userData.email);
    if (userData.phone != null) {
      await _storage.write(key: 'user_phone', value: userData.phone.toString());
    }
  }
}
