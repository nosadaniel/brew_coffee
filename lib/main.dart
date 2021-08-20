import 'package:brew_coffee/controllers/auth_controller.dart';
import 'package:brew_coffee/controllers/database_controller.dart';
import 'package:brew_coffee/controllers/userController.dart';
import 'package:brew_coffee/services/auth_service.dart';
import 'package:brew_coffee/view/pages/auth/authPage.dart';
import 'package:brew_coffee/view/pages/auth/widgets/signup_page.dart';
import 'package:brew_coffee/view/pages/home/home_page.dart';
import 'package:brew_coffee/view/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:brew_coffee/constants/firebase.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.initialization;
  Get.put(DatabaseController());
  Get.put(AuthController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashPage(),
      //theme: Get.theme.buttonTheme.,
      theme: ThemeData(primaryColor: Colors.brown, accentColor: Colors.white),
    );
  }
}
