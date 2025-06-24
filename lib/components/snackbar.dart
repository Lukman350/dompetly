import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackbarType { error, success, warning, info }

class Snackbar {
  static void show(String message, SnackbarType type) {
    Get.snackbar(
      type == SnackbarType.error
          ? 'Error'
          : type == SnackbarType.success
          ? 'Success'
          : type == SnackbarType.warning
          ? 'Warning'
          : 'Info',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: type == SnackbarType.error
          ? Colors.red
          : type == SnackbarType.success
          ? Colors.green
          : type == SnackbarType.warning
          ? Colors.yellow
          : Colors.blue,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      isDismissible: true,
      margin: EdgeInsets.all(16),
      borderRadius: 10,
      padding: EdgeInsets.all(16),
      icon: Icon(
        type == SnackbarType.error
            ? Icons.error
            : type == SnackbarType.success
            ? Icons.check_circle
            : type == SnackbarType.warning
            ? Icons.warning
            : Icons.info,
        color: Colors.white,
      ),
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
