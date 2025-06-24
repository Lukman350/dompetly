import 'package:dompetly/components/button.dart';
import 'package:dompetly/controllers/forgot_password_controller.dart';
import 'package:dompetly/controllers/theme_controller.dart';
import 'package:dompetly/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatelessWidget {
  static const String routeName = '/forgot_password';

  ForgotPasswordPage({super.key});

  final ThemeController themeController = Get.find();
  final controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: themeController.themeMode.value == ThemeMode.dark
              ? AppColors.darkBackgroundColor
              : AppColors.mainGreen,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Positioned(
              top: 90,
              child: Text(
                'Forgot Password',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
            Positioned.fill(
              top: 200,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: themeController.themeMode.value == ThemeMode.dark
                      ? AppColors.textSecondaryDark
                      : AppColors.backgroundGreenWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(70, 70),
                    topRight: Radius.elliptical(70, 70),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Reset Password?',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.mainGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Please enter your email address. You will receive a link to create a new password via email.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => TextFormField(
                        controller: controller.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email address',
                          errorText: controller.emailError.value,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Obx(
                      () => Button(
                        isLoading: controller.loading.value,
                        onPressed: () async {
                          controller.loading.value = true;

                          if (controller.validateForm()) {
                            // Handle form submission
                          }

                          controller.loading.value = false;
                        },
                        type: ButtonType.primary,
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,

                                color: AppColors.textSecondaryDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Button(
                      onPressed: () {
                        Get.back();
                      },
                      type: ButtonType.secondary,
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: 25,
                              color: AppColors.mainGreen,
                            ),
                            Text(
                              'Go Back',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
