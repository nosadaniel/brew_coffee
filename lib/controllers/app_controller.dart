import 'package:get/get.dart';

import 'auth_controller.dart';

class AppController extends GetxController {
  var isLoggedWidget = false.obs;
  final AuthController _authController = Get.find();

  changeIsLoggedWidget() {
    _authController.resetAllField();
    isLoggedWidget.value = !isLoggedWidget.value;
  }
}
