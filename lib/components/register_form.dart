import 'package:dompetly/api/user/api_user.dart';
import 'package:dompetly/api/user/request/user_request.dart';
import 'package:dompetly/components/button.dart';
import 'package:dompetly/components/custom_form_field.dart';
import 'package:dompetly/controllers/register_form_controller.dart';
import 'package:dompetly/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterForm extends StatelessWidget {
  final controller = Get.put(RegisterFormController());

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
              label: 'Konfirmasi Password',
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
                  type: "primary",
                  onPressed: controller.loading.value
                      ? null
                      : () async {
                          if (controller.validateForm()) {
                            controller.loading.value = true;

                            try {
                              final user = await ApiUser.register(
                                request: UserRequest(
                                  email: controller.email.text,
                                  password: controller.password.text,
                                  username: controller.username.text,
                                  confirmPassword:
                                      controller.confirmPassword.text,
                                ),
                              );

                              if (user.success == false) {
                                Get.snackbar(
                                  "Error",
                                  user.message ?? "Unknown error",
                                );
                                return;
                              }

                              controller.resetForm();

                              Get.snackbar("Success", "Register successful");

                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              print(e);
                              Get.snackbar(
                                "Error",
                                "There was an error registering the user",
                              );
                            } finally {
                              controller.loading.value = false;
                            }
                          }
                        },
                  child: controller.loading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
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
