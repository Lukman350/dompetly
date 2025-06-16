import 'package:dompetly/components/button.dart';
import 'package:dompetly/themes/app_colors.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 3,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (val) => val != null && _isValidEmail(val)
                  ? null
                  : 'Email tidak valid',
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
              validator: (val) => val != null && val.length >= 6
                  ? null
                  : 'Password minimal 6 karakter',
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Button(
                type: "primary",
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.textSecondaryDark,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    print('Login dengan ${emailController.text}');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
