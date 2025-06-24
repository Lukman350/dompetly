import 'package:dompetly/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final email = TextEditingController();
  final emailError = RxnString();
  final loading = false.obs;

  bool validateForm() {
    emailError.value = email.text.isEmpty
        ? 'Email address field is required'
        : StringUtil.isValidEmail(email.text)
        ? null
        : 'Email address is not valid';

    return emailError.value == null;
  }

  void clearForm() {
    email.clear();
    emailError.value = null;
  }

  void disposeControllers() {
    email.dispose();
  }

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }
}
