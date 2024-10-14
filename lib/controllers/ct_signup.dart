import 'package:get/get.dart';

import '../utils/_local_storage.dart';
import '../utils/_routes.dart';

class SignupPageController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    session();
  }

  void session() {
    hasSessionToken().then((isLoggedIn) {
      if (isLoggedIn) {
        if (Get.currentRoute == Routes.getLandingPage ||
            Get.currentRoute == Routes.getLoginPage ||
            Get.currentRoute == Routes.getSignupPage) {
          Get.offAllNamed(Routes.getHomePage);
        }
      }
    });
  }
}
