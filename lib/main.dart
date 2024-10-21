import 'package:admin_new/pages/request/sc_request_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'pages/home/sc_home.dart';
import 'utils/_init.dart';
import 'utils/_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: RootBinding(),
      initialRoute: Routes.getInitialPage,
      getPages: Routes.pages,
    );
  }
}
