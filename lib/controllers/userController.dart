import 'package:brew_coffee/models/userData.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  var _userDataModel = UserDataModel().obs;

  UserDataModel get getUser {
    return _userDataModel.value;
  }

  set setUser(UserDataModel value) {
    _userDataModel.value = value;
  }

  void clear() {
    _userDataModel.value = UserDataModel();
  }
}
