import 'package:brew_coffee/constants/constant.dart';
import 'package:brew_coffee/controllers/auth_controller.dart';
import 'package:brew_coffee/controllers/database_controller.dart';
import 'package:brew_coffee/controllers/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsForm extends StatelessWidget {
  final GlobalKey<FormState> _formState = GlobalKey();
  final DatabaseController _databaseController = DatabaseController.instance;
  final UserController _userController = UserController.instance;
  final AuthController _authController = AuthController.instance;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Form(
        key: _formState,
        child: Column(
          children: [
            Text(
              'Update your brew settings.',
              style: Get.textTheme.bodyText2,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: _userController.getUser.name,
              decoration: textInputDecoration,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your name' : null,
              onChanged: (value) => _userController.getUser.name = value,
            ),
            SizedBox(
              height: 10.0,
            ),
            DropdownButtonFormField(
              decoration: textInputDecoration,
              value: _userController.getUser.sugars,
              items: _databaseController.sugars.map((sugar) {
                return DropdownMenuItem(
                  value: sugar,
                  child: Text("$sugar sugars"),
                );
              }).toList(),
              onChanged: (value) =>
                  _userController.getUser.sugars = value.toString(),
            ),
            SizedBox(
              height: 10.0,
            ),
            Slider(
              activeColor: Colors.brown[_userController.getUser.strength],
              inactiveColor: Colors.brown,
              value: _userController.getUser.strength.toDouble(),
              min: 0.0,
              max: 900.0,
              onChanged: (value) {
                _userController.getUser.strength = value.round();
                print(_userController.getUser.strength);
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formState.currentState!.validate()) {
                    _databaseController.updateUserData(_userController.getUser);
                    Get.back();
                  }
                },
                child: Text("Update")),
          ],
        ),
      );
    });
  }
}
