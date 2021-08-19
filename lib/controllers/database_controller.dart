import 'dart:async';
import 'dart:developer';

import 'package:brew_coffee/models/brew_coffe_model.dart';
import 'package:brew_coffee/models/userData.dart';
import 'package:brew_coffee/services/database_service.dart';

import 'package:get/get.dart';

class DatabaseController extends GetxController {
  static final DatabaseController instance = Get.find();

  var brews = <BrewCoffeeModel>[].obs;

  var isLoading = false.obs;
  DatabaseService? databaseService;

  DatabaseController() {
    databaseService = DatabaseService();
  }

  @override
  onInit() {
    brews.bindStream(loadBrews());
    super.onInit();
  }

  Stream<List<BrewCoffeeModel>> loadBrews() {
    return databaseService!.brewsDataList();
  }

  Future<UserDataModel> userDetails(String uid) {
    isLoading.value = true;
    var result = databaseService!.userData(uid);
    isLoading.value = false;
    return result;
  }

  updateUserData(UserDataModel userData) async {
    try {
      isLoading.value = true;
      await databaseService!.updateUser(userData);
      //int index = brews.indexWhere((element) => element.uid == brews.uid);
    } catch (e) {
      Get.snackbar("Success", " updated", snackPosition: SnackPosition.BOTTOM);
      isLoading.value = true;
    }
  }

  deleteUserData(String uid) {
    try {
      databaseService!.deleteItem(uid);
      //int index = brews.indexWhere((element) => element.na == uid);
      //brews.removeAt(index);
      Get.snackbar("Success", "Deleted", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print(e);
    }
  }
}