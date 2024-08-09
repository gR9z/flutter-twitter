import 'package:email_validator/email_validator.dart';

class AppValidator {
  static String? emailValidator(String? value) {
    value = value?.trim().toLowerCase();

    if (value == null) {
      return "email can't be null";
    }

    if (value.isEmpty) {
      return "email can't be empty";
    }

    if(!EmailValidator.validate(value)) {
      return "email is not valid";
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null) {
      return "password can't be null";
    }

    if (value.isEmpty) {
      return "password can't be empty";
    }

    if (value.length < 6) {
      return "password can't be less than 6 characters";
    }

    return null;
  }
}