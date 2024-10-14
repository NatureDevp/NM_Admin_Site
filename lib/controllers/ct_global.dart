import 'package:get/get.dart';

import '../models/md_auth.dart';

class GlobalController extends GetxController {
  final Rx<Authorization?> _AUTHORIZATION_TMP = Rx<Authorization?>(null);

  Authorization? get currentUser => _AUTHORIZATION_TMP.value;

  //

  void saveUser(Authorization auth) {
    _AUTHORIZATION_TMP.value = auth;
  }

  void removeUser() {
    _AUTHORIZATION_TMP.value = null;
  }
}
