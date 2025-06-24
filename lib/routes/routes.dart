import 'package:dompetly/pages/analysis_page.dart';
import 'package:dompetly/pages/auth/forgot_password_screen.dart';
import 'package:dompetly/pages/dashboard_page.dart';
import 'package:dompetly/pages/security_pin_page.dart';
import 'package:dompetly/pages/splash_screen.dart';
import 'package:dompetly/pages/welcome_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final String title = 'Dompetly';
  static final pages = [
    GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
    GetPage(name: WelcomePage.routeName, page: () => WelcomePage()),
    GetPage(
      name: ForgotPasswordPage.routeName,
      page: () => ForgotPasswordPage(),
    ),
    GetPage(name: SecurityPinPage.routeName, page: () => SecurityPinPage()),
    GetPage(
      name: DashboardPage.routeName,
      page: () => DashboardPage(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: AnalysisPage.routeName,
      page: () => AnalysisPage(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 300),
    ),
  ];
}
