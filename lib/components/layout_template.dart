import 'package:dompetly/controllers/theme_controller.dart';
import 'package:dompetly/pages/analysis_page.dart';
import 'package:dompetly/pages/dashboard_page.dart';
import 'package:dompetly/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutTemplate extends StatelessWidget {
  final Widget header;
  final List<Widget> children;
  final Alignment headerAlignment;

  LayoutTemplate({
    super.key,
    required this.header,
    required this.children,
    this.headerAlignment = Alignment.topCenter,
  });

  final ThemeController _themeController = Get.find();

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String routeName,
    required VoidCallback onTap,
  }) {
    final bool isActive = Get.currentRoute == routeName;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: 57,
        height: 53,
        decoration: BoxDecoration(
          color: isActive ? AppColors.mainGreen : null,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Icon(
          icon,
          size: 40,
          color: isActive
              ? AppColors.darkBackgroundColor
              : (_themeController.themeMode.value == ThemeMode.dark
                    ? AppColors.textPrimaryDark
                    : AppColors.darkBackgroundColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: _themeController.themeMode.value == ThemeMode.dark
              ? AppColors.darkBackgroundColor
              : AppColors.mainGreen,
        ),
        child: Stack(
          alignment: headerAlignment,
          children: <Widget>[
            // Headers
            header,
            // Contents
            Positioned.fill(
              top: 280,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: _themeController.themeMode.value == ThemeMode.dark
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
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            ),
            // Bottom navigation
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 108,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _themeController.themeMode.value == ThemeMode.dark
                      ? Color(0xFF0E3E3E)
                      : Color(0xFFDFF7E2),
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
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      context,
                      icon: Icons.home_outlined,
                      routeName: DashboardPage.routeName,
                      onTap: () {
                        if (Get.currentRoute != DashboardPage.routeName) {
                          Get.toNamed(DashboardPage.routeName);
                        }
                      },
                    ),
                    _buildNavItem(
                      context,
                      icon: Icons.analytics_outlined,
                      routeName: AnalysisPage.routeName,
                      onTap: () {
                        if (Get.currentRoute != AnalysisPage.routeName) {
                          Get.toNamed(AnalysisPage.routeName);
                        }
                      },
                    ),
                    _buildNavItem(
                      context,
                      icon: Icons.stacked_line_chart_outlined,
                      routeName: "transactions_page",
                      onTap: () {
                        if (Get.currentRoute != "transactions_page") {
                          Get.toNamed("transactions_page");
                        }
                      },
                    ),
                    _buildNavItem(
                      context,
                      icon: Icons.layers_outlined,
                      routeName: "/categories_page",
                      onTap: () {
                        if (Get.currentRoute != "/categories_page") {
                          Get.toNamed("/categories_page");
                        }
                      },
                    ),
                    _buildNavItem(
                      context,
                      icon: Icons.person_2_outlined,
                      routeName: "/profile_page",
                      onTap: () {
                        if (Get.currentRoute != "profile_page") {
                          Get.toNamed("profile_page");
                        }
                      },
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
