import 'dart:developer';

import 'package:admin_side/api/plant.dart';
import 'package:admin_side/load.dart';
import 'package:admin_side/screens/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'dependencies/init.dart';
import 'routes/pages.dart';
import 'screens/landing.dart';
import 'utils/_system.dart';

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
      initialBinding: InitDependencies(),
      initialRoute: SystemPage.getInitialPage,
      getPages: SystemPage.routes,
      home: const InitialScreen(),
    );
  }
}
