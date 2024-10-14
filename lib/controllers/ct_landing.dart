import 'dart:developer';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

import '../api/api_auth.dart';
import '../models/md_auth.dart';
import '../utils/_colors.dart';
import '../utils/_local_storage.dart';
import '../utils/_routes.dart';

class LandingPageController extends GetxController {
  //
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
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

      getSessionToken().then((sessionToken) async {
        Get.offNamed(Routes.getHomePage, arguments: sessionToken!);
      });
    });
  }
}
