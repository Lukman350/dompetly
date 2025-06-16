import 'package:dompetly/controllers/auth_controller.dart';
import 'package:dompetly/controllers/theme_controller.dart';
import 'package:dompetly/pages/splash_screen.dart';
import 'package:dompetly/routes/routes.dart';
import 'package:dompetly/themes/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await GetStorage.init();
  Get.put(AuthController());
  Get.put(ThemeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppRoutes.title,
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkMode(),
        themeMode: themeController.themeMode.value,
        getPages: AppRoutes.pages,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
