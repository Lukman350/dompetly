import 'package:dompetly/api/user/request/user_request.dart';
import 'package:dompetly/components/button.dart';
import 'package:dompetly/components/custom_form_field.dart';
import 'package:dompetly/components/snackbar.dart';
import 'package:dompetly/controllers/auth_controller.dart';
import 'package:dompetly/controllers/register_form_controller.dart';
import 'package:dompetly/models/auth_user.dart';
import 'package:dompetly/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterForm extends StatelessWidget {
  final controller = Get.put(RegisterFormController());
  final authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            CustomFormField(
              label: 'Username',
              controller: controller.username,
              errorText: controller.usernameError,
            ),
            CustomFormField(
              label: 'Email',
              controller: controller.email,
              errorText: controller.emailError,
              keyboardType: TextInputType.emailAddress,
            ),
            CustomFormField(
              label: 'Password',
              controller: controller.password,
              errorText: controller.passwordError,
              obscureText: controller.obscurePassword,
              isPassword: true,
              onToggleObscure: () => controller.obscurePassword.toggle(),
            ),
            CustomFormField(
              label: 'Confirm Password',
              controller: controller.confirmPassword,
              errorText: controller.confirmPasswordError,
              obscureText: controller.obscureConfirm,
              isPassword: true,
              onToggleObscure: () => controller.obscureConfirm.toggle(),
            ),
            const SizedBox(height: 12),
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: Button(
                  type: ButtonType.primary,
                  isLoading: controller.loading.value,
                  onPressed: () async {
                    if (controller.validateForm()) {
                      controller.loading.value = true;

                      try {
                        final user = await authController.registerWithEmail(
                          request: UserRequest(
                            email: controller.email.text,
                            password: controller.password.text,
                            username: controller.username.text,
                            confirmPassword: controller.confirmPassword.text,
                            loginType: LoginType.email,
                          ),
                        );

                        if (user.success == false) {
                          Snackbar.show(
                            user.message ?? "Register failed, please try again",
                            SnackbarType.error,
                          );
                          return;
                        }

                        controller.resetForm();

                        Snackbar.show(
                          "Register successful, please check your email to verify your account",
                          SnackbarType.success,
                        );

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        print(e);
                        Snackbar.show(
                          "Register failed, please try again",
                          SnackbarType.error,
                        );
                      } finally {
                        controller.loading.value = false;
                      }
                    }
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
