import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinController extends GetxController {
  final pinLength = 6;

  final currentStep = 1.obs;
  final firstPin = ''.obs;
  final pin = ''.obs;

  final textController = TextEditingController();

  void onChanged(String value) {
    pin.value = value;
  }

  void clearPin() {
    pin.value = '';
    textController.clear();
  }

  void goToStep2() {
    firstPin.value = pin.value;
    clearPin();
    currentStep.value = 2;
  }

  void reset() {
    firstPin.value = '';
    clearPin();
    currentStep.value = 1;
  }

  @override
  void onClose() {
    if (Get.isRegistered<PinController>(tag: 'pin')) {
      Get.delete<PinController>(tag: 'pin');
    }
    super.onClose();
  }
}
