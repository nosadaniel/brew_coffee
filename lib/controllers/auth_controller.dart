import 'dart:developer';

import 'package:brew_coffee/binding/user_binding.dart';
import 'package:brew_coffee/controllers/database_controller.dart';
import 'package:brew_coffee/controllers/userController.dart';
import 'package:brew_coffee/models/userData.dart';

import 'package:brew_coffee/services/auth_service.dart';
import 'package:brew_coffee/services/database_service.dart';

import 'package:brew_coffee/view/pages/auth/authPage.dart';
import 'package:brew_coffee/view/pages/home/home_page.dart';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static final AuthController instance = Get.find();
  DatabaseController _databaseController = Get.find();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  AuthService _authService = AuthService();
  var isLoading = false.obs;
  var isLogIn = false.obs;

  //initial user with direct access to the firebase instance currentuser
  Rx<User?> user = Rx<User?>(AuthService.auth.currentUser);

  @override
  // using onReady cause of AuthController was initialized together with
  // firebase initialization
  void onReady() {
    // bind directly using the firebase instance
    user.bindStream(AuthService.auth.userChanges());
    ever(user, _handleAuthChanged);

    super.onReady();
  }

  _handleAuthChanged(User? login) {
    if (login == null) {
      resetAllField();
      Get.offAll(() => AuthPage());
    } else {
      Get.offAll(() => HomePage(), binding: UserBinding());
    }
  }

  signUpWithEmailPassword(TextEditingController username) async {
    String? uid = await _authService.signUpWithEmailAndPassword(
        email: email, password: password, username: username);
    //add userDetails to fireStore
    UserDataModel _userData =
        UserDataModel(uid: uid, name: username.text, strength: 0, sugars: "0");
    await _databaseController.databaseService!.addUser(_userData);
  }

  loginWithEmailPassword() async {
    String? uid = await _authService.signInWithEmailAndPassword(
        email: email, password: password);
    UserController.instance.setUser =
        await _databaseController.userDetailFuture(uid!);
  }

  logout() async {
    await _authService.signOut();
    Get.find<UserController>().clear();
  }

  String? validatePasswordField(String? value) {
    if (value!.isEmpty) {
      return "Field must not be empty";
    } else if (value.length < 6) {
      return "Password should be more than six characters";
    } else {
      return null;
    }
  }

  String? validateEmailField(String? value) {
    if (value!.isEmpty) {
      return "Field must not be empty";
    } else if (!EmailValidator.validate(value))
      return "Invalid Email";
    else {
      return null;
    }
  }

  String? validateTextField(String? value) {
    if (value!.isEmpty) {
      return "Field must not be empty";
    } else {
      return null;
    }
  }

  resetAllField() {
    email.clear();
    password.clear();
    username.clear();
  }
}
