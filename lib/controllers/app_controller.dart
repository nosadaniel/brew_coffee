import 'package:get/get.dart';

class AppController extends GetxController {
  var isLoggedWidget = false.obs;

  void changeIsLoggedWidget() {
    isLoggedWidget.value = !isLoggedWidget.value;
  }
}
