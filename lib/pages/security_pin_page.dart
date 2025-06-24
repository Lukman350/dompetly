import 'package:dompetly/components/button.dart';
import 'package:dompetly/components/snackbar.dart';
import 'package:dompetly/controllers/auth_controller.dart';
import 'package:dompetly/controllers/theme_controller.dart';
import 'package:dompetly/pages/dashboard_page.dart';
import 'package:dompetly/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/pin_controller.dart';

class SecurityPinPage extends StatelessWidget {
  static const routeName = '/security-pin';

  final PinController _pinController = Get.put(
    PinController(),
    tag: 'pin',
    permanent: false,
  );
  final AuthController _authController = AuthController.to;
  final ThemeController _themeController = Get.find();

  SecurityPinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = Get.parameters['mode'] ?? 'auth';

    return Scaffold(
      appBar: AppBar(
        title: Text(mode == 'create' ? 'Create PIN' : 'Enter PIN'),
        backgroundColor: _themeController.themeMode.value == ThemeMode.dark
            ? AppColors.mainGreen
            : AppColors.primaryColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PinCodeTextField(
                appContext: context,
                length: _pinController.pinLength,
                controller: _pinController.textController,
                obscureText: true,
                obscuringCharacter: '●',
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                autoFocus: true,
                textStyle: const TextStyle(fontSize: 28),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.circle,
                  borderRadius: BorderRadius.circular(20),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeColor:
                      _themeController.themeMode.value == ThemeMode.dark
                      ? AppColors.mainGreen
                      : AppColors.primaryColor,
                  selectedColor:
                      _themeController.themeMode.value == ThemeMode.dark
                      ? AppColors.mainGreen
                      : AppColors.primaryColor,
                  inactiveColor: Colors.grey.shade300,
                ),
                onChanged: _pinController.onChanged,
                onCompleted: (enteredPin) {
                  if (mode == 'create') {
                    if (_pinController.currentStep.value == 1) {
                      _pinController.goToStep2();
                    } else {
                      if (_pinController.firstPin.value == enteredPin) {
                        Future.delayed(Duration.zero, () async {
                          bool result = await _authController.createPin(
                            int.parse(enteredPin),
                          );

                          if (!result) {
                            _pinController.reset();
                          }
                        });
                      } else {
                        Snackbar.show(
                          "PINs do not match. Try again.",
                          SnackbarType.error,
                        );
                        _pinController.reset();
                      }
                    }
                  } else {
                    final isValid = _authController.checkPin(enteredPin);
                    if (isValid) {
                      Snackbar.show('Login successful', SnackbarType.success);

                      Get.offAllNamed(DashboardPage.routeName);
                    } else {
                      Snackbar.show("Incorrect PIN", SnackbarType.error);
                      _pinController.clearPin();
                    }
                  }
                },
              ),
              const SizedBox(height: 16),
              if (mode == 'create')
                Obx(
                  () => Text(
                    _pinController.currentStep.value == 1
                        ? "Create a new PIN"
                        : "Confirm new PIN",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              const SizedBox(height: 20),
              Button(
                type: ButtonType.secondary,
                onPressed: () => _pinController.clearPin(),
                child: const Text("Clear", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
