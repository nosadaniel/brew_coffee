import 'package:brew_coffee/controllers/auth_controller.dart';
import 'package:brew_coffee/controllers/database_controller.dart';
import 'package:brew_coffee/models/userData.dart';
import 'package:brew_coffee/services/auth_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  DatabaseController _data = DatabaseController.instance;

  var _userData = UserDataModel(strength: 0).obs;

  @override
  onReady() {
    _userData.bindStream(_loadUser());
    super.onReady();
  }

  UserDataModel get getUser {
    return _userData.value;
  }

  set setUser(UserDataModel value) {
    this._userData.value = value;
  }

  Stream<UserDataModel> _loadUser() {
    return _data.userDetailStream(AuthService.auth.currentUser!.uid);
  }

  void clear() {
    _userData.value = UserDataModel(strength: 0);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
