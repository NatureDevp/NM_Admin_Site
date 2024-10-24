import 'package:admin_new/pages/plant/sc_plant_form.dart';
import 'package:admin_new/pages/request/sc_request_info.dart';
import 'package:get/get.dart';

import '../pages/auth/sc_login.dart';
import '../pages/auth/sc_signup.dart';
import '../pages/home/sc_home.dart';
import '../pages/start/sc_landing.dart';

class Routes {
  static get getInitialPage => '/';
  static get getLandingPage => '/landing';
  static get getLoginPage => '/login';
  static get getSignupPage => '/signup';
  static get getHomePage => '/home';
  static get getRequestInfoPage => '/home/reqInfo';
  static get getCreatePlantPage => '/home/createPlant';

  static List<GetPage> pages = [
    GetPage(
      name: getInitialPage,
      page: () => const HomePage(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: getLandingPage,
      page: () => const LandingPage(),
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: getLoginPage,
      page: () => LoginPage(),
    ),
    GetPage(
      name: getSignupPage,
      page: () => SignupPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: getHomePage,
      page: () => const HomePage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: getRequestInfoPage,
      page: () => const RequestInfoPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: getCreatePlantPage,
      page: () => PlantFormPage(),
      transition: Transition.cupertino,
    ),
  ];
}
