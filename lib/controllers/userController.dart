import 'package:brew_coffee/controllers/auth_controller.dart';
import 'package:brew_coffee/controllers/database_controller.dart';
import 'package:brew_coffee/models/userData.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  DatabaseController _data = DatabaseController.instance;
  AuthController _user = AuthController.instance;

  var _userData = UserDataModel(strength: 0).obs;

  @override
  onReady() {
    _userData.bindStream(_loadUser());
    super.onReady();
  }

  UserDataModel get getUser {
    return _userData.value;
  }

  Stream<UserDataModel> _loadUser() {
    return _data.userDetails(_user.user.value!.uid);
  }

  void clear() {
    _userData.value = UserDataModel(strength: 0);
  }

  userSnapShot() {}
}
