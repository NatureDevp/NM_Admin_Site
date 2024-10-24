import 'package:admin_new/pages/plant/sc_list_plant.dart';
import 'package:admin_new/pages/start/sc_landing.dart';
import 'package:admin_new/utils/_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

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
      home: const Scaffold(
        body: PlantListPage(),
      ),
    );
  }
}
