import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/dashboard/sc_dashboard.dart';

class SidebarController extends GetxController {
  final dash = 'Dashboard';
  final request = 'Request';
  final plant = 'Plant';
  final user = 'User';

  final Rx<Widget> _currentScreen = Rx(Dashboard());
  final RxString _currentTitle = 'Dashboard'.obs;
  final RxString _selectedButton = 'Dashboard'.obs;

  Rx<Widget> get currentScreen => _currentScreen;
  Rx<String> get currentTitle => _currentTitle;
  Rx<String> get selectedButton => _selectedButton;

  //
  void changeScreen(String buttonPath, String title, {required Widget screen}) {
    _selectedButton.value = buttonPath;
    _currentTitle.value = title;
    _currentScreen.value = screen;
  }

  bool isSelectedButton(String title) {
    return _selectedButton.value == title;
  }
}
