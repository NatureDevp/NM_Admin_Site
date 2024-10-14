import 'package:admin_new/controllers/ct_global.dart';
import 'package:get/get.dart';

import '../controllers/ct_form.dart';
import '../controllers/ct_home.dart';
import '../controllers/ct_landing.dart';
import '../controllers/ct_login.dart';
import '../controllers/ct_plant.dart';
import '../controllers/ct_request.dart';
import '../controllers/ct_sidebar.dart';
import '../controllers/ct_signup.dart';
import '../controllers/ct_workplace.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => HomePageController(), fenix: true);
    Get.lazyPut(() => SignupPageController(), fenix: true);
    Get.lazyPut(() => LandingPageController(), fenix: true);
    Get.lazyPut(() => LoginPageController(), fenix: true);

    //
    Get.lazyPut(() => GlobalController(), fenix: true);
    Get.lazyPut(() => SidebarController(), fenix: true);
    Get.lazyPut(() => FormController(), fenix: true);
    Get.lazyPut(() => RequestController(), fenix: true);
    Get.lazyPut(() => WorkplaceController(), fenix: true);
    Get.lazyPut(() => WorkplaceController(), fenix: true);
    Get.lazyPut(() => PlantController(), fenix: true);
  }
}
