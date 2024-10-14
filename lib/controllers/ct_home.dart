import 'dart:html' as html;
import 'package:get/get.dart';

import '../api/api_auth.dart';
import '../models/md_auth.dart';
import '../utils/_local_storage.dart';
import '../utils/_routes.dart';

class HomePageController extends GetxController {
  //
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadAllData();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    redirectToLandingPage();
  }

  String pageTitle = 'NatureMedix | Admin';
  var isLoading = false.obs;
  var isRedirecting = false.obs;
  var errorMessage = ''.obs;
  Rx<Authorization> authorization =
      Authorization(firstName: 'User', email: '').obs;

  Future<void> loadAllData() async {
    await _session();
    _setWindowTitle();
  }

  void _setWindowTitle() {
    html.document.title = pageTitle;
  }

  Future<void> _session() async {
    isLoading.value = true;
    var isLoggedIn = await hasSessionToken();

    if (!isLoggedIn) {
      isRedirecting.value = true;
      isLoading.value = false;
      return;
    }

    var sessionToken = await getSessionToken();
    var result = await APIAuth.checkLoginStatus(sessionToken!);

    if (result == null || result['success'] == false) {
      errorMessage.value = 'Session Expired';
      deleteSessionToken();
      isRedirecting.value = true;
      isLoading.value = false;
      return;
    }

    authorization.value = Authorization.fromJson(
      result['data'][0],
      result['access_token'],
    );
    isRedirecting.value = false;
    isLoading.value = false;
  }

  void redirectToLandingPage() {
    if (isRedirecting.value) {
      Get.offAllNamed(Routes.getInitialPage);
      isRedirecting.value = false;
    }
  }
}
