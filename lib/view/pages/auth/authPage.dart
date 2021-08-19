import 'package:brew_coffee/controllers/app_controller.dart';
import 'package:brew_coffee/controllers/auth_controller.dart';
import 'package:brew_coffee/view/pages/auth/widgets/login.dart';
import 'package:brew_coffee/view/pages/auth/widgets/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPage extends StatelessWidget {
  final AppController _appController = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text("Brew Coffee"),
        backgroundColor: Colors.brown[400],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/coffee_bg.png"),
              fit: BoxFit.fill),
        ),
        child: Obx(() {
          return Column(
            children: [
              Visibility(
                visible: _appController.isLoggedWidget.value,
                child: SignupPage(),
              ),
              Visibility(
                visible: !_appController.isLoggedWidget.value,
                child: LoginPage(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
