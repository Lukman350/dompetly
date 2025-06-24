import 'package:dompetly/components/button.dart';
import 'package:dompetly/components/login_form.dart';
import 'package:dompetly/components/register_form.dart';
import 'package:dompetly/controllers/auth_controller.dart';
import 'package:dompetly/controllers/theme_controller.dart';
import 'package:dompetly/pages/auth/forgot_password_screen.dart';
import 'package:dompetly/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  static final String routeName = "/welcome_page";

  WelcomePage({super.key});

  final ThemeController themeController = Get.find();
  final auth = AuthController.to;

  void _showAuthSheet(
    BuildContext context, {
    ThemeMode? currentTheme = ThemeMode.light,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isDismissible: true,
      enableDrag: true,
      backgroundColor: currentTheme == ThemeMode.dark
          ? AppColors.textSecondaryDark
          : AppColors.backgroundGreenWhite,
      builder: (context) {
        return DefaultTabController(
          length: 2,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 24,
            ),
            child: Wrap(
              spacing: 5,
              children: [
                Center(
                  child: Text(
                    'Authentication',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainGreen,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TabBar(
                  tabs: [
                    Tab(text: 'Login'),
                    Tab(text: 'Register'),
                  ],
                  labelColor: AppColors.mainGreen,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: AppColors.mainGreen,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 500, // Tinggi konten dalam sheet
                  child: TabBarView(children: [LoginForm(), RegisterForm()]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Obx(
        () => Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: themeController.themeMode.value == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundGreenWhite,
          ),
          child: Stack(
            children: [
              Positioned(
                right: 10,
                top: 30,
                child: IconButton(
                  onPressed: () {
                    themeController.toggleTheme();
                  },
                  icon: Icon(
                    themeController.themeMode.value == ThemeMode.dark
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color: themeController.themeMode.value == ThemeMode.dark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 15,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 70),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        clipBehavior: Clip.none,
                        children: [
                          Hero(
                            tag: 'dompetly-logo',
                            child: Image.asset(
                              'assets/images/logo-transparent.png',
                              width: 200,
                              height: 200,
                              alignment: Alignment.center,
                            ),
                          ),
                          Positioned.directional(
                            textDirection: TextDirection.ltr,
                            bottom: -50,
                            width: 300,
                            child: Column(
                              spacing: 5,
                              children: [
                                Text(
                                  'Dompetly',
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.mainGreen,
                                  ),
                                ),
                                Text(
                                  'Atur Uangmu, agar Hidup Lebih Terencana',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Button(
                      type: ButtonType.primary,
                      onPressed: () async {
                        await auth.signInWithGoogle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Image.asset(
                            'assets/images/icons/google.png',
                            width: 25,
                            height: 25,
                            color: AppColors.textSecondaryDark,
                          ),
                          Text(
                            'Continue with Google',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('or', style: TextStyle(fontSize: 18)),
                    Button(
                      type: ButtonType.secondary,
                      onPressed: () => _showAuthSheet(
                        context,
                        currentTheme: themeController.themeMode.value,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.email,
                            size: 25,
                            color: AppColors.mainGreen,
                          ),
                          Text(
                            'Continue with Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(ForgotPasswordPage.routeName);
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
