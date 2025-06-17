import 'package:dompetly/api/user/request/user_request.dart';
import 'package:dompetly/components/button.dart';
import 'package:dompetly/controllers/auth_controller.dart';
import 'package:dompetly/controllers/login_form_controller.dart';
import 'package:dompetly/pages/dashboard_page.dart';
import 'package:dompetly/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_form_field.dart';

class LoginForm extends StatelessWidget {
  final controller = Get.put(LoginFormController());
  final authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
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
          SizedBox(height: 12),
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
                          bool loggedIn = await authController.signInWithEmail(
                            request: UserRequest(
                              email: controller.email.text,
                              password: controller.password.text,
                            ),
                          );

                          controller.loading.value = false;

                          if (loggedIn) {
                            Get.offAllNamed(DashboardPage.routeName);
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
                        'Login',
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
    );
  }
}
