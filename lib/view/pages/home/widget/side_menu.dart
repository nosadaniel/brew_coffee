import 'package:brew_coffee/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  final AuthController authController;

  const SideMenu({Key? key, required this.authController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text("userEmail"),
            accountName: Text("userName"),
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
