import 'package:admin_side/screens/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'dependencies/init.dart';
import 'routes/pages.dart';
import 'screens/landing.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitDependencies(),
      initialRoute: SystemPage.getLadingPage,
      getPages: SystemPage.routes,
      home: const LandingPage(),
    );
  }
}
