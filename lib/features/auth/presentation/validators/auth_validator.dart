// presentation/validators/auth_validators.dart
class AuthValidators {
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email обязателен';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Некорректный email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пароль обязателен';
    }
    if (value.length < 6) {
      return 'Минимум 6 символов'; // у Firebase минимум 6
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Подтвердите пароль';
    }
    if (value != password) {
      return 'Пароли не совпадают';
    }
    return null;
  }
}
