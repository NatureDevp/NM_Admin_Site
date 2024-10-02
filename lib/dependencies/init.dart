import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../controllers/request.dart';
import '../controllers/sidebar.dart';
import '../controllers/table.dart';
import '../controllers/workplace.dart';

class InitDependencies extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SidebarController(), fenix: true);
    Get.lazyPut(() => RequestController(), fenix: true);
    Get.lazyPut(() => TableController(), fenix: true);
    Get.lazyPut(() => WorkplaceController(), fenix: true);
  }
}
