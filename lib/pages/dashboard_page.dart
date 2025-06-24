import 'package:dompetly/components/goal_progress_card.dart';
import 'package:dompetly/components/layout_template.dart';
import 'package:dompetly/controllers/auth_controller.dart';
import 'package:dompetly/controllers/theme_controller.dart';
import 'package:dompetly/pages/welcome_page.dart';
import 'package:dompetly/themes/app_colors.dart';
import 'package:dompetly/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  static final String routeName = '/dashboard';

  DashboardPage({super.key});

  final AuthController _authController = AuthController.to;
  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutTemplate(
        headerAlignment: Alignment.topLeft,
        header: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, Welcome Back',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        StringUtil.sayHello(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _themeController.toggleTheme();
                        },
                        icon: Obx(
                          () => Icon(
                            _themeController.themeMode.value == ThemeMode.dark
                                ? Icons.light_mode
                                : Icons.dark_mode,
                            color:
                                _themeController.themeMode.value ==
                                    ThemeMode.dark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimary,
                          ),
                        ),
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.all(5),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Badge.count(
                          count: 99,
                          textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimaryDark,
                          ),
                          child: Icon(
                            Icons.notifications_outlined,
                            size: 30,
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            AppColors.textPrimaryDark,
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.all(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 5,
                          children: [
                            Obx(
                              () => Image.asset(
                                _themeController.themeMode.value ==
                                        ThemeMode.dark
                                    ? 'assets/images/icons/income_arrow_light.png'
                                    : 'assets/images/icons/income_arrow_dark.png',
                              ),
                            ),
                            Text(
                              'Total Balance',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Rp 100.000.000',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: 1,
                      height: 42,
                      color: AppColors.textPrimaryDark,
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 5,
                          children: [
                            Obx(
                              () => Image.asset(
                                _themeController.themeMode.value ==
                                        ThemeMode.dark
                                    ? 'assets/images/icons/expense_arrow_light.png'
                                    : 'assets/images/icons/expense_arrow_dark.png',
                              ),
                            ),
                            Text(
                              'Total Expense',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          '-Rp 100.000',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.red.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.3,
                        child: Container(
                          width: 100,
                          height: 27,
                          decoration: BoxDecoration(
                            color: AppColors.darkModeGreenBlack,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(99),
                              bottomLeft: Radius.circular(99),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '30%',
                              style: TextStyle(
                                color: AppColors.textPrimaryDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          width: 250,
                          height: 27,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1FFF3),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Center(
                            child: Text(
                              '70%',
                              style: TextStyle(
                                color: AppColors.darkModeGreenBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Obx(
                      () => Image.asset(
                        _themeController.themeMode.value == ThemeMode.dark
                            ? 'assets/images/icons/check_icon_light.png'
                            : 'assets/images/icons/check_icon_dark.png',
                      ),
                    ),
                    Expanded(child: Text('30% Of Your Expenses, looks good.')),
                  ],
                ),
              ),
            ],
          ),
        ),
        children: [
          GoalProgressCard(progress: 0.75),
          IconButton(
            onPressed: () {
              _authController.signOut();

              Get.offAllNamed(WelcomePage.routeName);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
