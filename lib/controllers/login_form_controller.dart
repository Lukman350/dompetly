import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFormController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();

  final emailError = RxnString();
  final passwordError = RxnString();

  final obscurePassword = true.obs;
  final loading = false.obs;

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool validateForm() {
    emailError.value = email.text.isEmpty
        ? 'Email field is required'
        : _isValidEmail(email.text)
        ? null
        : 'Email is not valid';
    passwordError.value = password.text.length < 6
        ? 'Password must be at least 6 characters'
        : null;

    return [
      emailError.value,
      passwordError.value,
    ].every((error) => error == null);
  }

  void disposeControllers() {
    email.dispose();
    password.dispose();
  }

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }
}
