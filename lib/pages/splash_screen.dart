import 'package:dompetly/controllers/auth_controller.dart';
import 'package:dompetly/pages/dashboard_page.dart';
import 'package:dompetly/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static final String routeName = "/splash_screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    Future.delayed(Duration(seconds: 2), () {
      if (authController.isLoggedIn) {
        Get.offAllNamed(DashboardPage.routeName);
      } else {
        Get.offAllNamed(WelcomePage.routeName);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Color(0xFF063831) : Color(0xFF25C19B),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            isDark
                ? 'assets/images/dompetly_dark.png'
                : 'assets/images/dompetly_light.png',
            width: 500,
          ),
        ),
      ),
    );
  }
}
