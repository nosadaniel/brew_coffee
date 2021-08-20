import 'package:brew_coffee/controllers/auth_controller.dart';
import 'package:brew_coffee/controllers/database_controller.dart';
import 'package:brew_coffee/controllers/userController.dart';
import 'package:brew_coffee/view/pages/auth/widgets/login.dart';
import 'package:brew_coffee/view/pages/auth/widgets/signup_page.dart';
import 'package:brew_coffee/view/pages/home/widget/settings_form.dart';
import 'package:brew_coffee/view/pages/home/widget/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final AuthController _authController = AuthController.instance;
  final DatabaseController _dataBaseController = DatabaseController.instance;

  String color(index) {
    return ".shade${_dataBaseController.brews[index].strength}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brew Coffee"),
        actions: [
          TextButton.icon(
              onPressed: () => _showSettingsPanel(context),
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: Text(
                "Settings",
                style: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
              ))
        ],
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
              fit: BoxFit.cover),
        ),
        child: Obx(() {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors
                          .brown[_dataBaseController.brews[index].strength],
                      backgroundImage:
                          AssetImage("assets/images/coffee_icon.png"),
                    ),
                    title: Text("${_dataBaseController.brews[index].name}"),
                    subtitle: Text(
                        "Takes ${_dataBaseController.brews[index].sugars} Sugars"),
                  ),
                ),
              );
            },
            itemCount: _dataBaseController.brews.length,
          );
        }),
      ),
    );
  }

  void _showSettingsPanel(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm());
        });
  }
}
