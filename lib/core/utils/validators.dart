/// Validation utilities for form fields.
class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain an uppercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain a number';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? required(String? value, [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? weight(String? value) {
    if (value == null || value.isEmpty) return 'Weight is required';
    final weight = double.tryParse(value);
    if (weight == null || weight < 20 || weight > 500) {
      return 'Please enter a valid weight (20–500 kg)';
    }
    return null;
  }

  static String? height(String? value) {
    if (value == null || value.isEmpty) return 'Height is required';
    final height = double.tryParse(value);
    if (height == null || height < 50 || height > 300) {
      return 'Please enter a valid height (50–300 cm)';
    }
    return null;
  }
}
