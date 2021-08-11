import 'package:brew_coffee/controllers/auth_controller.dart';
import 'package:brew_coffee/view/pages/auth/widgets/login.dart';
import 'package:brew_coffee/view/pages/auth/widgets/signup_page.dart';
import 'package:brew_coffee/view/pages/home/widget/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Coffee"),
          backgroundColor: Colors.brown[400],
        ),
        drawer: Drawer(
          child: SideMenu(
            authController: _authController,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/coffee_bg.png"),
            ),
          ),
        ));
  }
}
