import 'package:admin_new/utils/_local_storage.dart';
import 'package:get/get.dart';
import 'dart:html' as html;

import '../utils/_routes.dart';

class LoginPageController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _session();
  }

  void setWindowTitle(String title) {
    html.document.title = title;
  }

  void _session() {
    hasSessionToken().then((isLoggedIn) {
      if (!isLoggedIn) {
        return;
      }
      getSessionToken().then((sessionToken) {
        Get.offAllNamed(Routes.getHomePage, arguments: sessionToken!);
      });
    });
  }
}
