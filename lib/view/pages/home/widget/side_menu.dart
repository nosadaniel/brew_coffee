import 'package:brew_coffee/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brew_coffee/models/brew_coffe_model.dart';

class SideMenu extends StatelessWidget {
  final AuthController authController;

  const SideMenu({Key? key, required this.authController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text("${authController.user.value!.email}"),
            accountName: Text("Welcome"),
          ),
          ListTile(
            onTap: () => authController.logout(),
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
          )
        ],
      ),
    );
  }
}
