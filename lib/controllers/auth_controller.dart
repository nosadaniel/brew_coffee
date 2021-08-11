import 'dart:developer';

import 'package:brew_coffee/constants/firebase.dart';
import 'package:brew_coffee/models/user_model.dart';
import 'package:brew_coffee/view/pages/auth/authPage.dart';
import 'package:brew_coffee/view/pages/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var isLoading = false.obs;
  var userModel = UserModel().obs;
  Rx<User?> firebaseUser = Rx<User?>(auth.currentUser);
  String userCollection = "brews";

  @override
  void onReady() {
    firebaseUser.bindStream(auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
    super.onReady();
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => AuthPage());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  UserModel _userFromFirebaseUser(User user) {
    return UserModel(uid: user.uid, email: user.email);
  }

  Future signupWithEmailPassword(
      TextEditingController email, TextEditingController password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      User user = userCredential.user!;
      //await firebaseFirestore.collection(userCollection).doc(user.uid).g
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Message", 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Message", 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future loginWithEmailPassword(
      TextEditingController email, TextEditingController password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      log(userCredential.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Message", 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Message", 'Wrong password provided for that user.');
      }
    }
  }

  Future<void> logout() async {
    try {
      return await auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
