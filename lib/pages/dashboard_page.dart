import 'package:dompetly/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  static final String routeName = '/dashboard';

  DashboardPage({super.key});

  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        'Welcome to dashboard ${authController.loginType == LoginType.google
            ? 'Google'
            : 'Email'} ${authController.firebaseUser.value} ${authController
            .localUser.value}',
      ),
    );
  }
}
