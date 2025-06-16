import 'package:dompetly/pages/dashboard_page.dart';
import 'package:dompetly/pages/splash_screen.dart';
import 'package:dompetly/pages/welcome_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final String title = 'Dompetly';
  static final pages = [
    GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
    GetPage(name: WelcomePage.routeName, page: () => WelcomePage()),
    GetPage(name: DashboardPage.routeName, page: () => DashboardPage()),
  ];
}
