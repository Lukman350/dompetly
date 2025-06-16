import 'package:dompetly/components/button.dart';
import 'package:dompetly/themes/app_colors.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
              validator: (val) =>
                  val == null || val.isEmpty ? 'Masukkan username' : null,
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (val) => val == null || !_isValidEmail(val)
                  ? 'Email tidak valid'
                  : null,
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
              validator: (val) =>
                  val == null || val.length < 6 ? 'Minimal 6 karakter' : null,
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Konfirmasi Password'),
              validator: (val) {
                if (val == null || val.isEmpty) return 'Masukkan konfirmasi';
                if (val != passwordController.text) {
                  return 'Password tidak cocok';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Button(
                type: "primary",
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.textSecondaryDark,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    print('Registrasi: ${emailController.text}');
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
