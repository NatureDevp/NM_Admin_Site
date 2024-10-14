import 'package:email_validator/email_validator.dart';

String? validateFirstName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Required. Please enter your first name.';
  }
  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
    return 'Invalid. First name should only contain letters.';
  }
  return null;
}

String? validateLastName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Required. Please enter your last name.';
  }
  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
    return 'Invalid. Last name should only contain letters.';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Required. Please enter an email address.';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value) &&
      !EmailValidator.validate(value)) {
    return 'Invalid. Please enter a valid email address.';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Required. Please enter a password';
  }
  if (value.length < 6) {
    return 'Required. Password must be at least 6 characters';
  }
  if (!RegExp(r'(?=.*?[A-Z])').hasMatch(value)) {
    return 'Required. Password must contain at least one uppercase letter';
  }
  if (!RegExp(r'(?=.*?[0-9])').hasMatch(value)) {
    return 'Required. Password must contain at least one number';
  }
  if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(value)) {
    return 'Required. Password must contain at least one special character';
  }
  return null;
}

String? validateConfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Required. Please enter a confirmation password';
  }
  if (value != password) {
    return 'Invalid. Passwords do not match';
  }
  return null;
}
