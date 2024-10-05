import 'package:admin_side/models/user.dart';
import 'package:admin_side/screens/pages/plant/plant_info.dart';
import 'package:admin_side/screens/pages/request/req_info.dart';
import 'package:admin_side/screens/pages/request/req_list.dart';
import 'package:admin_side/screens/pages/user/user_info.dart';
import 'package:admin_side/screens/pages/workplace/work.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/pages/dashboard/dashboard.dart';
import '../screens/pages/plant/plant.dart';
import '../screens/pages/request/request.dart';
import '../screens/pages/user/user.dart';

class SidebarController extends GetxController {
  RxInt selectedButtonIndex = 0.obs;
  Rx<Widget> selectedPage = Rx<Widget>(Dashboard());
  RxString titlePage = 'Dashboard'.obs;

  //
  void selectButton(int index, {args = null}) {
    selectedButtonIndex.value = index;
    selectPage(index, args: args);

    selectTitle(index);
  }

  void selectPage(int index, {args = null}) {
    switch (index) {
      case 0:
        selectedPage.value = Dashboard();
        break;
      case 1:
        selectedPage.value = const RequestPage();
        break;
      case 2:
        selectedPage.value = const PlantPage();
        break;
      case 3:
        selectedPage.value = const UserPage();
        break;
      case 4:
        selectedPage.value = const RequestListPage();
        break;
      case 5:
        selectedPage.value = const WorkplacePage();
        break;
      case 6:
        selectedPage.value = const RequestInformation();
        break;
      case 7:
        selectedPage.value = const PlantInfo();
        break;
      case 8:
        selectedPage.value = UserInfoPage(user: args! as User);
        break;
      default:
        selectedPage.value = Dashboard();
    }
  }

  void selectTitle(int index) {
    switch (index) {
      case 0:
        titlePage.value = 'Dashboard';
        break;
      case 1:
        titlePage.value = 'Manage Request';
        break;
      case 2:
        titlePage.value = 'Manage Plant';
        break;
      case 3:
        titlePage.value = 'Manage User';
        break;
      case 4:
        titlePage.value = 'Request List';
        break;
      case 5:
        titlePage.value = 'Workplace';
        break;
      case 5:
        titlePage.value = 'Workplace';
        break;
      case 6:
        titlePage.value = 'Request Information';
        break;
      case 7:
        titlePage.value = 'Plant Information';
        break;
      case 8:
        titlePage.value = 'User Information';
        break;
      default:
        titlePage.value = 'Dashboard';
    }
  }
}
