import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class AuthService {
  static final Future<FirebaseApp> initialization = Firebase.initializeApp();
  static final FirebaseAuth auth = FirebaseAuth.instance;

  //if null is return, means user is not login
  Stream<User?> onAuthChanged() {
    return auth.userChanges();
  }

  Future<String?> signInWithEmailAndPassword(
      {required TextEditingController email,
      required TextEditingController password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Message",
          'No user found email. or password incorrect',
          duration: Duration(seconds: 30),
        );
        password.clear();
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Message",
          'No user found email. or password incorrect',
          duration: Duration(seconds: 30),
        );
        log("Wrong password provided");
        password.clear();
      }
    }
  }

  Future<String?> signUpWithEmailAndPassword(
      {required TextEditingController email,
      required TextEditingController password,
      TextEditingController? username}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Message", 'The password provided is too weak.');
        password.clear();
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Message", 'The account already exists for that email.');
        email.clear();
        password.clear();
      }
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        "Fail to Register User",
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e);
    }
  }

  User? getCurrentUser() {
    return auth.currentUser;
  }

  Future<String?> getAccessToken() async {
    User? user = getCurrentUser();
    IdTokenResult idTokenResult = (await user!.getIdToken()) as IdTokenResult;
    return idTokenResult.token;
  }

  Future<void> signOut() async {
    return await auth.signOut();
  }

  Future<void> sendEmailVerification() async {
    User? user = getCurrentUser();
    return user!.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User? user = getCurrentUser();
    return user!.emailVerified;
  }

  Future<void> changeEmail({required String email}) async {
    User? user = getCurrentUser();
    return user!.updateEmail(email);
  }

  Future<void> changePassword({required String password}) async {
    User? user = getCurrentUser();
    user!
        .updatePassword(password)
        .then((value) => log("Password changed Successfully"))
        .catchError((error) {
      log("Password can't be changed" + error.toString());
    });
    return null;
  }

  Future<void> deleteUser() async {
    User? user = getCurrentUser();
    user!
        .delete()
        .then((value) => log("User Deleted Successfully"))
        .catchError((error) {
      log("User can't be deleted" + error.toString());
    });
  }
}
