import 'package:get/get.dart';

import '../pages/auth/sc_login.dart';
import '../pages/auth/sc_signup.dart';
import '../pages/home/sc_home.dart';
import '../pages/start/sc_landing.dart';
import '_init.dart';

class Routes {
  static get getInitialPage => '/';
  static get getLandingPage => '/landing';
  static get getLoginPage => '/login';
  static get getSignupPage => '/signup';
  static get getHomePage => '/home';

  static List<GetPage> pages = [
    GetPage(
      name: getInitialPage,
      page: () => const LandingPage(),
      transition: Transition.zoom,
    ),

    GetPage(
      name: getLandingPage,
      page: () => const LandingPage(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: getLoginPage,
      page: () => LoginPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
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
    // GetPage(
    //   name: getRequestListpage,
    //   page: () => const RequestListPage(),
    //   transition: Transition.cupertino,
    // ),
    // GetPage(
    //   name: getWorkplacepage,
    //   page: () => const WorkplacePage(),
    //   transition: Transition.cupertino,
    // ),
  ];
}
