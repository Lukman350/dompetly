import 'package:dompetly/controllers/theme_controller.dart';
import 'package:dompetly/pages/analysis_page.dart';
import 'package:dompetly/pages/dashboard_page.dart';
import 'package:dompetly/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    required String svgPath,
    required String routeName,
    required VoidCallback onTap,
  }) {
    final bool isActive = Get.currentRoute == routeName;

    return Material(
      color: Colors.transparent,
      elevation: isActive ? 4 : 0,
      shadowColor: Colors.black.withValues(alpha: 0.5),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 57,
          height: 53,
          decoration: BoxDecoration(
            color: isActive ? AppColors.mainGreen : null,
            borderRadius: BorderRadius.circular(22),
          ),
          child: SizedBox(
            width: 30,
            height: 30,
            child: Center(
              child: SvgPicture.asset(
                svgPath,
                colorFilter: isActive
                    ? ColorFilter.mode(
                        AppColors.darkBackgroundColor,
                        BlendMode.srcIn,
                      )
                    : (_themeController.themeMode.value == ThemeMode.dark
                          ? ColorFilter.mode(
                              AppColors.textPrimaryDark,
                              BlendMode.srcIn,
                            )
                          : ColorFilter.mode(
                              AppColors.darkBackgroundColor,
                              BlendMode.srcIn,
                            )),
                width: 30,
                height: 30,
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
            ),
          ),
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
              top: 265,
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
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                height: 90,
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
                      svgPath: 'assets/images/icons/nav_menu/home.svg',
                      routeName: DashboardPage.routeName,
                      onTap: () {
                        if (Get.currentRoute != DashboardPage.routeName) {
                          Get.toNamed(DashboardPage.routeName);
                        }
                      },
                    ),
                    _buildNavItem(
                      context,
                      svgPath: 'assets/images/icons/nav_menu/analysis.svg',
                      routeName: AnalysisPage.routeName,
                      onTap: () {
                        if (Get.currentRoute != AnalysisPage.routeName) {
                          Get.toNamed(AnalysisPage.routeName);
                        }
                      },
                    ),
                    _buildNavItem(
                      context,
                      svgPath: 'assets/images/icons/nav_menu/transactions.svg',
                      routeName: "transactions_page",
                      onTap: () {
                        if (Get.currentRoute != "transactions_page") {
                          Get.toNamed("transactions_page");
                        }
                      },
                    ),
                    _buildNavItem(
                      context,
                      svgPath: 'assets/images/icons/nav_menu/category.svg',
                      routeName: "/categories_page",
                      onTap: () {
                        if (Get.currentRoute != "/categories_page") {
                          Get.toNamed("/categories_page");
                        }
                      },
                    ),
                    _buildNavItem(
                      context,
                      svgPath: 'assets/images/icons/nav_menu/profile.svg',
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
