import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterFormController extends GetxController {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final usernameError = RxnString();
  final emailError = RxnString();
  final passwordError = RxnString();
  final confirmPasswordError = RxnString();

  final obscurePassword = true.obs;
  final obscureConfirm = true.obs;

  final loading = false.obs;

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool validateForm() {
    usernameError.value = username.text.isEmpty
        ? 'Username field is required'
        : null;
    emailError.value = email.text.isEmpty
        ? 'Email field is required'
        : _isValidEmail(email.text)
        ? null
        : 'Email is not valid';
    passwordError.value = password.text.length < 6
        ? 'Password must be at least 6 characters'
        : null;
    confirmPasswordError.value = confirmPassword.text != password.text
        ? 'Confirm password does not match with password'
        : null;

    return [
      usernameError.value,
      emailError.value,
      passwordError.value,
      confirmPasswordError.value,
    ].every((error) => error == null);
  }

  void resetForm() {
    username.clear();
    email.clear();
    password.clear();
    confirmPassword.clear();
  }

  void disposeControllers() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }
}
