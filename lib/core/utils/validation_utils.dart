import 'package:easy_localization/easy_localization.dart';


class ValidationUtils {
  
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'email_required'.tr();
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'email_invalid'.tr();
    }

    return null;
  }

  
  static String? validatePassword(String? value, {bool checkStrength = false}) {
    if (value == null || value.trim().isEmpty) {
      return 'password_required'.tr();
    }

    if (value.length < 6) {
      return 'password_too_short'.tr();
    }

    if (checkStrength) {
      if (!_hasUpperCase(value)) {
        return 'password_needs_uppercase'.tr();
      }
      if (!_hasLowerCase(value)) {
        return 'password_needs_lowercase'.tr();
      }
      if (!_hasDigit(value)) {
        return 'password_needs_number'.tr();
      }
    }

    return null;
  }

  
  static String? validateConfirmPassword(
    String? value,
    String? originalPassword,
  ) {
    if (value == null || value.trim().isEmpty) {
      return 'confirm_password_required'.tr();
    }

    if (value != originalPassword) {
      return 'passwords_do_not_match'.tr();
    }

    return null;
  }

  
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'phone_required'.tr();
    }

    
    final cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');

    
    if (cleanPhone.length != 11) {
      return 'phone_invalid'.tr();
    }

    if (!cleanPhone.startsWith('01')) {
      return 'phone_invalid_format'.tr();
    }

    return null;
  }

  
  static String? validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName}_required'.tr();
    }

    if (value.trim().length < 2) {
      return '${fieldName}_too_short'.tr();
    }

    if (value.trim().length > 50) {
      return '${fieldName}_too_long'.tr();
    }

    
    final nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$');
    if (!nameRegex.hasMatch(value.trim())) {
      return '${fieldName}_invalid_characters'.tr();
    }

    return null;
  }

  
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName}_required'.tr();
    }
    return null;
  }

  
  static String? validateNumeric(
    String? value,
    String fieldName, {
    int? min,
    int? max,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName}_required'.tr();
    }

    final number = int.tryParse(value.trim());
    if (number == null) {
      return '${fieldName}_must_be_number'.tr();
    }

    if (min != null && number < min) {
      return '${fieldName}_too_small'.tr();
    }

    if (max != null && number > max) {
      return '${fieldName}_too_large'.tr();
    }

    return null;
  }

  
  static bool _hasUpperCase(String value) => value.contains(RegExp(r'[A-Z]'));
  static bool _hasLowerCase(String value) => value.contains(RegExp(r'[a-z]'));
  static bool _hasDigit(String value) => value.contains(RegExp(r'[0-9]'));
}


extension StringValidation on String? {
  String? get validateEmail => ValidationUtils.validateEmail(this);
  String? get validatePassword => ValidationUtils.validatePassword(this);
  String? validateConfirmPassword(String? original) =>
      ValidationUtils.validateConfirmPassword(this, original);
  String? get validatePhone => ValidationUtils.validatePhone(this);
  String? validateName(String fieldName) =>
      ValidationUtils.validateName(this, fieldName);
  String? validateRequired(String fieldName) =>
      ValidationUtils.validateRequired(this, fieldName);
}
